Class {
	#name : 'BaselineOfContainersDeque',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfContainersDeque',
	#package : 'BaselineOfContainersDeque'
}

{ #category : 'baselines' }
BaselineOfContainersDeque >> baseline: spec [

	<baseline>

	spec for: #pharo do: [		
		spec package: 'Containers-Deque'.
		spec package: 'Containers-Deque-Tests' with: [ spec requires: #('Containers-Deque') ]
	]
]
