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

{ #category : #'as yet unclassified' }
AcMetRelease class >> releaseRe [

	"comment stating purpose of class-side method"

	"scope: class-variables  &  class-instance-variables"

	^ '[\W\w]*release\/(\d+\.\d+)' asRegexIgnoringCase.
]

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
AcMetRelease >> fixes: aVersion [

	fixes := aVersion.
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

	| releaseRegExp |
	tag := aTag splitOn: $,.
	releaseDate := (tag at: 1) asDateAndTime.
	tagRef := tag at: 2.
	releaseRegExp := self class releaseRe.
	version := (releaseRegExp matchesPrefix: (tag at: 3)) ifTrue: [ 
		                  releaseRegExp subexpression: 2 ]
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
