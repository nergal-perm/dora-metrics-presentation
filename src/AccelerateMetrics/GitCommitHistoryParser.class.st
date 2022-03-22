Class {
	#name : #GitCommitHistoryParser,
	#superclass : #Object,
	#instVars : [
		'repository',
		'releasePattern',
		'fixPattern'
	],
	#classInstVars : [
		'aString'
	],
	#category : #AccelerateMetrics
}

{ #category : #initialization }
GitCommitHistoryParser >> fixPattern: aString [

	"Setting the regexp to determine the fix version"

	fixPattern := aString
]

{ #category : #initialization }
GitCommitHistoryParser >> releasePattern: aString [

	"Setting the regexp to determine the release version"

	releasePattern := aString
]

{ #category : #initialization }
GitCommitHistoryParser >> repositoryPath: aString [
	"Sets the instance variable that stores path to repository"
			
	repository := aString.
]
