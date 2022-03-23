Class {
	#name : #AcMetReleases,
	#superclass : #Object,
	#instVars : [
		'releaseTags',
		'releases',
		'fixAge'
	],
	#category : #AccelerateMetrics
}

{ #category : #accessing }
AcMetReleases >> gtMetricsFor: aView [

	<gtView>
	^ aView columnedList
		  title: 'Metrics';
		  priority: 2;
		  items: self metrics associations;
		  column: 'Metric' text: [ :assoc | assoc key ] width: 150;
		  column: 'Value' text: [ :assoc | assoc value ]
]

{ #category : #accessing }
AcMetReleases >> gtReleasesListFor: aView [

	<gtView>
	^ aView columnedTree
		  title: 'Releases';
		  priority: 1;
		  items: [ self releases ];
		  children: [ :release | release commits ];
		  column: 'ID' text: [ :eachItem | eachItem refId ] width: 100;
		  column: 'Date' text: [ :eachItem | eachItem refDate asLocalStringYMDHM]
]

{ #category : #accessing }
AcMetReleases >> intervalAsString: anInterval [
	^ anInterval days asString, 'd ', anInterval hours asString, 'h ', anInterval minutes asString, 'm'
]

{ #category : #accessing }
AcMetReleases >> metrics [

	| tempReleases depInterval commitAge releaseCommitAge |
	tempReleases := releases allButFirst.
	depInterval := (tempReleases collect: [ :each | 
		                each refDate - each fromDate ]) average.
	commitAge := (tempReleases collect: [ :each | each medianCommitAge ])
		             average.
	releaseCommitAge := ((tempReleases select: [ :each | 
		                      each fixes isEmpty ]) collect: [ :each | 
		                     each medianCommitAge ]) average.
	fixAge := ((tempReleases select: [ :each | each fixes isNotEmpty ]) 
		           collect: [ :each | 
			           each refDate
			           -
			           (releases select: [ :fix | fix version = each fixes ])
				           first refDate ]) average.

	^ Dictionary new
		  at: 'Deployment Interval'
		  put: (self intervalAsString: depInterval);
		  at: 'Fail Rate'
		  put:
			  (((tempReleases select: [ :each | each fixes isNotEmpty ]) size
			    * 100 / releases size) asFloat round: 0) asString , '%';
		  at: 'Lead Time' put: (self intervalAsString: commitAge);
		  at: 'Release Lead Time'
		  put: (self intervalAsString: releaseCommitAge);
		  at: 'Mean Time to Recover' put: (self intervalAsString: fixAge);
		  yourself
]

{ #category : #accessing }
AcMetReleases >> rawData: anArray [

	| tempReleases lastRelease lastVersion |
	releaseTags := anArray.


	tempReleases := (releaseTags reject: [ :tag | 
		                 tag beginsWithSubCollection: '",' ]) collect: [ 
		                :tag | AcMetRelease new rawData: tag ].
	releases := tempReleases keysAndValuesDo: [ :index :currRelease | 
		            index = 1 ifFalse: [ 
			            lastVersion := currRelease version
				                           ifNil: [ lastVersion ]
				                           ifNotNil: [ currRelease version ].
			            lastRelease := tempReleases at: index - 1.
			            currRelease
			                fixes: (currRelease version ifNil: [lastVersion] ifNotNil:[nil]);
				            commits:
					            (AcMetCommits new rawData:
							             (GtExternalProcessBuilder new
								              workingDirectory: '/home/eugene/Dev/dora-metrics';
								              command: 'git';
								              args: { 
										              'log'.
										              '--pretty=format:"%h,%ai"'.
										              (lastRelease tagRef , '..'
										               , currRelease tagRef).
										              '--no-merges' };
								              output) stdout lines);
				            from: lastRelease refId;
				            fromDate: lastRelease refDate ] ]
]

{ #category : #accessing }
AcMetReleases >> releases [

	^ releases 
]
