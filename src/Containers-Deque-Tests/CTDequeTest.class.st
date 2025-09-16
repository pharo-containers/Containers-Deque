"
I provide a comprehensive suite of unit tests for the CTDeque class.
"
Class {
	#name : 'CTDequeTest',
	#superclass : 'TestCase',
	#instVars : [
		'deque'
	],
	#category : 'Containers-Deque-Tests',
	#package : 'Containers-Deque-Tests'
}

{ #category : 'running' }
CTDequeTest >> setUp [
	super setUp.
	deque := CTDeque new: 5
]

{ #category : 'tests' }
CTDequeTest >> testAddFirstMultipleElements [

	deque
		addFirst: 'third';
		addFirst: 'second';
		addFirst: 'first'.
	self assert: deque size equals: 3.
	self assert: deque first equals: 'first'.
	self deny: deque isEmpty
]

{ #category : 'tests' }
CTDequeTest >> testAddFirstSingleElement [

	deque addFirst: 'first'.
	self assert: deque size equals: 1.
	self deny: deque isEmpty.
	self assert: deque first equals: 'first'
]

{ #category : 'tests' }
CTDequeTest >> testAddLastMultipleElements [

	deque
		addLast: 'first';
		addLast: 'second';
		addLast: 'third'.
	self assert: deque size equals: 3.
	self assert: deque first equals: 'first'.
	self assert: deque last equals: 'third'.
	self deny: deque isEmpty
]

{ #category : 'tests' }
CTDequeTest >> testAddLastSingleElement [

	deque addLast: 'first'.
	self assert: deque size equals: 1.
	self deny: deque isEmpty.
	self assert: deque first equals: 'first'.
	self assert: deque last equals: 'first'
]

{ #category : 'tests' }
CTDequeTest >> testDefaultDequeCreation [
	
	| defaultDeque |
	defaultDeque := CTDeque new.
	self assert: defaultDeque capacity equals: 10.
	self assert: defaultDeque isEmpty.
	self assert: defaultDeque size equals: 0
]

{ #category : 'tests' }
CTDequeTest >> testDequeCreationWithCapacity [

	| testDeque |
	testDeque := CTDeque new: 3.
	self assert: testDeque capacity equals: 3.
	self assert: testDeque isEmpty.
	self assert: testDeque size equals: 0
]

{ #category : 'tests' }
CTDequeTest >> testDequeCreationWithInvalidCapacity [

	self should: [ CTDeque new: -1 ] raise: Error.
	self should: [ CTDeque new: -10 ] raise: Error
]

{ #category : 'tests' }
CTDequeTest >> testIsEmpty [

	self assert: deque isEmpty
]

{ #category : 'tests' }
CTDequeTest >> testMixedAddFirstAddLast [

	deque addFirst: 'middle'.
	deque addFirst: 'first'.
	deque addLast: 'last'.
	
	self assert: deque size equals: 3.
	self assert: deque first equals: 'first'.
	self assert: deque last equals: 'last'
]

{ #category : 'tests' }
CTDequeTest >> testMixedRemoveFirstRemoveLast [

	deque addLast: 'first'; addLast: 'second'; addLast: 'third'.
	
	self assert: deque removeFirst equals: 'first'.
	self assert: deque removeLast equals: 'third'.
	self assert: deque size equals: 1.
	self assert: deque first equals: 'second'.
	self assert: deque last equals: 'second'
]

{ #category : 'tests' }
CTDequeTest >> testRemoveFirstMultipleElements [

	deque addFirst: 'third'; addFirst: 'second'; addFirst: 'first'.
	
	self assert: deque removeFirst equals: 'first'.
	self assert: deque removeFirst equals: 'second'.
	self assert: deque size equals: 1.
	self assert: deque first equals: 'third'
]

{ #category : 'tests' }
CTDequeTest >> testRemoveFirstSingleElement [

	| element |
	deque addFirst: 'test'.
	element := deque removeFirst.
	self assert: element equals: 'test'.
	self assert: deque isEmpty.
	self assert: deque size equals: 0
]

{ #category : 'tests' }
CTDequeTest >> testRemoveLastMultipleElements [

	deque addLast: 'first'; addLast: 'second'; addLast: 'third'.
	
	self assert: deque removeLast equals: 'third'.
	self assert: deque removeLast equals: 'second'.
	self assert: deque size equals: 1.
	self assert: deque last equals: 'first'
]

{ #category : 'tests' }
CTDequeTest >> testRemoveLastSingleElement [

	| element |
	deque addLast: 'test'.
	element := deque removeLast.
	self assert: element equals: 'test'.
	self assert: deque isEmpty.
	self assert: deque size equals: 0
]

{ #category : 'tests' }
CTDequeTest >> testSize [

	self assert: deque size equals: 0
]
