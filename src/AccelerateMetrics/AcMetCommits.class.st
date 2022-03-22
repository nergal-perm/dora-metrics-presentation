Class {
	#name : #AcMetCommits,
	#superclass : #Object,
	#instVars : [
		'rawData'
	],
	#category : #AccelerateMetrics
}

{ #category : #accessing }
AcMetCommits >> commits [

	| commitData |
	^ rawData collect: [ :commitRow | 
		  commitData := commitRow splitOn: ','.
		  AcMetCommit new
			  date: (commitData at: 2);
			  hash: (commitData at: 1) ] into: OrderedCollection new
]

{ #category : #accessing }
AcMetCommits >> medianCommitAge: releaseDate [

	| commit |
	^ self commits ifNotEmpty: [ 
		commit := self commits at: (self commits size / 2) floor + 1.
		releaseDate - commit refDate ]
]

{ #category : #accessing }
AcMetCommits >> rawData: anArray [
	rawData := anArray.
]
