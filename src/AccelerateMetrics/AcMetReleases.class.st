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
	^ anInterval hours asString, 'h ', anInterval minutes asString, 'm'
]

{ #category : #accessing }
AcMetReleases >> metrics [

	| tempReleases depInterval commitAge |
	tempReleases := releases allButLast.
	depInterval := (tempReleases collect: [ :each | 
		                each refDate - each fromDate ]) average.
	commitAge := (tempReleases collect: [ :each | each medianCommitAge ])
		             average.
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
			  ((tempReleases select: [ :each | each fixes isNotEmpty ]) size
			   / releases size round: 2) numerator asString , '%';
		  at: 'Lead Time' put: (self intervalAsString: commitAge);
		  at: 'Mean Time to Recover' put: (self intervalAsString: fixAge);
		  yourself
]

{ #category : #accessing }
AcMetReleases >> rawData: anArray [

	| tempReleases commits lastRelease |
	releaseTags := anArray.


	tempReleases := (releaseTags reject: [ :tag | tag beginsWith: '",' ]) 
		                collect: [ :tag | AcMetRelease new rawData: tag ].
	releases := tempReleases doWithIndex: [ :currRelease :index | 
		             index = tempReleases size ifFalse: [ 
			             lastRelease := tempReleases at: index + 1.
			             currRelease
				             commits:
					             (AcMetCommits new rawData:
							              (GtExternalProcessBuilder new
								               workingDirectory:
									               '/home/eugene/Dev/dora-metrics';
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
