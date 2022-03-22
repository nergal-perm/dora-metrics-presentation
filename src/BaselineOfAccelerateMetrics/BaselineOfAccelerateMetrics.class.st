Class {
	#name : #BaselineOfAccelerateMetrics,
	#superclass : #BaselineOf,
	#category : #BaselineOfAccelerateMetrics
}

{ #category : #accessing }
BaselineOfAccelerateMetrics >> baseline: spec [
      <baseline>

      spec for: #common do: [
        spec
          package: 'AccelerateMetrics'.]
]
