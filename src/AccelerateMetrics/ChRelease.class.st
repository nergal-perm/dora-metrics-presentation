Class {
	#name : #ChRelease,
	#superclass : #Object,
	#instVars : [
		'releaseDate',
		'tagRef',
		'releaseVersion'
	],
	#category : #AccelerateMetrics
}

{ #category : #'as yet unclassified' }
ChRelease class >> releaseRe [

	"comment stating purpose of class-side method"

	"scope: class-variables  &  class-instance-variables"

	^ '[\W\w]*release\/(\d+\.\d+)' asRegexIgnoringCase.
]

{ #category : #accessing }
ChRelease >> rawData: aRow [

	| tag releaseRegExp |
	tag := aRow splitOn: $,.
	releaseDate := (tag at: 1) asDateAndTime.
	tagRef := tag at: 2.
	releaseRegExp := self class releaseRe.
	releaseVersion := (releaseRegExp matchesPrefix: (tag at: 3)) ifTrue: [ 
		                  releaseRegExp subexpression: 2 ]
]

{ #category : #accessing }
ChRelease >> tagRef [ 

	^ tagRef .
]
