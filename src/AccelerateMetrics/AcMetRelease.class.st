Class {
	#name : #AcMetRelease,
	#superclass : #Object,
	#instVars : [
		'tag',
		'version',
		'releaseDate',
		'fixes',
		'tagRef',
		'commitList',
		'fromVersion',
		'fromDate'
	],
	#category : #AccelerateMetrics
}

{ #category : #accessing }
AcMetRelease >> commits [

	^ commitList ifNil: [Array new ]ifNotNil: [commitList commits]
]

{ #category : #accessing }
AcMetRelease >> commits: anObject [
	commitList := anObject
]

{ #category : #accessing }
AcMetRelease >> fixes [
	^ fixes ifNil: [ '' ]
]

{ #category : #accessing }
AcMetRelease >> from: aVersion [
	fromVersion := aVersion
]

{ #category : #accessing }
AcMetRelease >> fromDate [

	^ fromDate
]

{ #category : #accessing }
AcMetRelease >> fromDate: aDate [
	fromDate := aDate
]

{ #category : #accessing }
AcMetRelease >> medianCommitAge [
	^ commitList medianCommitAge: self refDate
]

{ #category : #accessing }
AcMetRelease >> rawData: aTag [

	tag := aTag splitOn: $,.
	releaseDate := (tag at: 1) asDateAndTime.
	tagRef := tag at: 2.
	version := self tagRef withoutPrefix: 'refs/tags/release/'.
	fixes := (self version endsWith: '-fix') ifTrue: [ 
		         self version withoutSuffix: '-fix' ]
]

{ #category : #accessing }
AcMetRelease >> refDate [
	^ releaseDate
]

{ #category : #accessing }
AcMetRelease >> refId [
	^ version
]

{ #category : #accessing }
AcMetRelease >> releaseDate [
	^ releaseDate
]

{ #category : #accessing }
AcMetRelease >> tagRef [

	^ tagRef
]

{ #category : #accessing }
AcMetRelease >> version [
	^ version
]
