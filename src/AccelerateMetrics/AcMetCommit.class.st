Class {
	#name : #AcMetCommit,
	#superclass : #Object,
	#instVars : [
		'commitDate',
		'hash'
	],
	#category : #AccelerateMetrics
}

{ #category : #accessing }
AcMetCommit >> commits [

	^ Array new
]

{ #category : #accessing }
AcMetCommit >> date: aDate [

	commitDate := aDate asDateAndTime
]

{ #category : #accessing }
AcMetCommit >> hash: aString [

	hash := aString allButFirst
]

{ #category : #accessing }
AcMetCommit >> refDate [

	^ commitDate
]

{ #category : #accessing }
AcMetCommit >> refId [
	
	^ hash
]
