Class {
	#name : #AcMetMetrics,
	#superclass : #Object,
	#instVars : [
		'releases'
	],
	#category : #AccelerateMetrics
}

{ #category : #accessing }
AcMetMetrics >> gtMetricsFor: aView [

	<gtView>
	^ aView columnedList
		title: 'Metrics';
		priority: 1;
		items: [ self metrics associations];
		column: 'Metric' text: [ :assoc | assoc key ];
		column: 'Value' text: [ :assoc | assoc value ];
		send: [ :assoc | assoc value ]
]

{ #category : #accessing }
AcMetMetrics >> metrics [

	^ Dictionary new
		at: 'Deployment Frequency' put: 'N/A';
		yourself
	
]

{ #category : #accessing }
AcMetMetrics >> releases: aCollection [
	releases := aCollection
]
