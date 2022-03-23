Class {
	#name : #ChReleases,
	#superclass : #Object,
	#category : #AccelerateMetrics
}

{ #category : #accessing }
ChReleases >> rawData: anArray [

	| tempReleases |
	tempReleases := anArray collect: [ :row | ChRelease new rawData: row ].
	^ tempReleases
]
