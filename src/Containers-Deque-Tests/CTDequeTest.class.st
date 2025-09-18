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
CTDequeTest >> testAddAllFirst [

	deque addFirst: 'existing'.
	deque addAllFirst: #('c' 'b' 'a').
	
	self assert: deque size equals: 4.
	self assert: deque first equals: 'a'.
	self assert: deque last equals: 'existing'
]

{ #category : 'tests' }
CTDequeTest >> testAddAllLast [
deque addLast: 'existing'.
	deque addAllLast: #('a' 'b' 'c').
	
	self assert: deque size equals: 4.
	self assert: deque first equals: 'existing'.
	self assert: deque last equals: 'c'
	
]

{ #category : 'tests' }
CTDequeTest >> testAddAllWithEmptyCollection [

	deque addAllFirst: #().
	deque addAllLast: #().
	self assert: deque isEmpty
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
CTDequeTest >> testAlternatingOperations [

	deque addFirst: 'a'.
	self assert: deque removeFirst equals: 'a'.
	
	deque addLast: 'b'; addFirst: 'c'.
	self assert: deque removeLast equals: 'b'.
	
	deque addLast: 'd'.
	self assert: deque first equals: 'c'.
	self assert: deque last equals: 'd'.
	self assert: deque size equals: 2
]

{ #category : 'tests' }
CTDequeTest >> testAsArray [

	| result |
	deque addLast: 'first'; addLast: 'second'; addLast: 'third'.
	result := deque asArray.
	
	self assert: result equals: #('first' 'second' 'third').
	"Elements from front to rear"
]

{ #category : 'tests' }
CTDequeTest >> testAsArrayWithMixedOperations [

	| result |
	deque addFirst: 'second'; addFirst: 'first'; addLast: 'third'.
	result := deque asArray.
	
	self assert: result equals: #('first' 'second' 'third')
]

{ #category : 'tests' }
CTDequeTest >> testCapacityGrowth [

	| originalCapacity |
	originalCapacity := deque capacity.
	
	1 to: originalCapacity do: [ :i | deque addLast: i ].
	self assert: deque capacity equals: originalCapacity.
	
	deque addLast: 'overflow'.
	self assert: deque capacity equals: originalCapacity * 2.
	self assert: deque size equals: originalCapacity + 1
]

{ #category : 'tests' }
CTDequeTest >> testComplexInterleavedOperations [

	deque addFirst: 1; addLast: 2.
	self assert: deque removeFirst equals: 1.
	deque addFirst: 3; addLast: 4.
	self assert: deque removeLast equals: 4.
	deque addFirst: 5.
	
	self assert: deque first equals: 5.
	self assert: deque last equals: 2.
	self assert: deque size equals: 3
]

{ #category : 'tests' }
CTDequeTest >> testCopyCreatesNewObject [

	| copy |
	deque
		addFirst: 'a';
		addLast: 'b'.
	copy := deque copy.
	self deny: deque identicalTo: copy
]

{ #category : 'tests' }
CTDequeTest >> testCopyHasSameContents [

	| copy |
	deque
		addFirst: 'first';
		addLast: 'second';
		addFirst: 'third'.
	copy := deque copy.
	self assert: copy size equals: deque size.
	self assert: copy first equals: deque first.
	self assert: copy last equals: deque last
]

{ #category : 'tests' }
CTDequeTest >> testCopyIsIndependent [

	| copy |
	deque addFirst: 'a'; addLast: 'b'.
	copy := deque copy.
	"Now, modify the original deque"
	deque removeFirst.
	deque addLast: 'c'.
	
	self assert: copy size equals: 2.
	self assert: copy first equals: 'a'.
	self assert: copy last equals: 'b'.
	self deny: copy first equals: deque first
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
CTDequeTest >> testDequeCreationWithZeroCapacity [

	| zeroDeque |
	zeroDeque := CTDeque new: 0.
	
	self assert: zeroDeque capacity equals: 0.
	self assert: zeroDeque isEmpty.
	self assert: zeroDeque size equals: 0.
	
	zeroDeque addFirst: 'first'.
	self assert: zeroDeque capacity equals: 10.
	self assert: zeroDeque size equals: 1
]

{ #category : 'tests' }
CTDequeTest >> testDynamicDeque [

	| testDeque |
	testDeque := CTDeque new: 2.
	testDeque
		addFirst: 'a';
		addLast: 'b'.
	self assert: testDeque capacity equals: 2.
	"Add one more - should double capacity"
	testDeque addFirst: 'c'.
	self assert: testDeque capacity equals: 4.
	self assert: testDeque size equals: 3.
	self assert: testDeque first equals: 'c'.
	self assert: testDeque last equals: 'b'
]

{ #category : 'tests' }
CTDequeTest >> testErrorHandling [

	self should: [ deque removeFirst ] raise: Error.
	self should: [ deque removeLast ] raise: Error.
	self should: [ deque first ] raise: Error.
	self should: [ deque last ] raise: Error.
	
	deque addFirst: 'test'.
	deque removeFirst.
	
	self should: [ deque removeFirst ] raise: Error.
	self should: [ deque removeLast ] raise: Error.
	self should: [ deque first ] raise: Error.
	self should: [ deque last ] raise: Error
]

{ #category : 'tests' }
CTDequeTest >> testIncludes [

	deque addLast: 5; addFirst: 10; addLast: 15.
	self assert: (deque includes: 10).
	self deny: (deque includes: 20).
	self assert: deque size equals: 3. "includes: should not modify the deque"
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
CTDequeTest >> testQueueInterface [

	"Test queue-like operations"
	deque enqueue: 'first'; enqueue: 'second'; enqueue: 'third'.
	
	self assert: deque front equals: 'first'.
	self assert: deque dequeue equals: 'first'.
	self assert: deque dequeue equals: 'second'.
	self assert: deque size equals: 1.
	self assert: deque front equals: 'third'
]

{ #category : 'removing' }
CTDequeTest >> testRemoveAll [

	deque
		addFirst: 'a';
		addLast: 'b';
		addFirst: 'c'.
	deque removeAll.
	self assert: deque isEmpty.
	self assert: deque size equals: 0.
	deque addFirst: 'd'.
	self deny: deque isEmpty.
	self assert: deque size equals: 1.
	self assert: deque first equals: 'd'
]

{ #category : 'tests' }
CTDequeTest >> testRemoveFirstIfNone [

	| result |
	result := deque removeFirstIfNone: [ 'fallback' ].
	self assert: result equals: 'fallback'.
	
	deque addFirst: 'test'.
	result := deque removeFirstIfNone: [ 'fallback' ].
	self assert: result equals: 'test'
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
CTDequeTest >> testRemoveLastIfNone [

	| result |
	result := deque removeLastIfNone: [ 'fallback' ].
	self assert: result equals: 'fallback'.
	
	deque addLast: 'test'.
	result := deque removeLastIfNone: [ 'fallback' ].
	self assert: result equals: 'test'
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
CTDequeTest >> testSearchExistingElement [

	deque addLast: 'a'; addLast: 'b'; addLast: 'c'; addLast: 'b'.
	
	self assert: (deque search: 'a') equals: 1. "First element"
	self assert: (deque search: 'b') equals: 2. "First occurrence"
	self assert: (deque search: 'c') equals: 3
]

{ #category : 'tests' }
CTDequeTest >> testSearchNonExistentElement [

	deque addLast: 'a'; addLast: 'b'; addLast: 'c'.
	
	self assert: (deque search: 'x') equals: -1
]

{ #category : 'tests' }
CTDequeTest >> testSize [

	self assert: deque size equals: 0
]

{ #category : 'tests' }
CTDequeTest >> testStackInterface [

	"Test stack-like operations"
	deque push: 'first'; push: 'second'; push: 'third'.
	
	self assert: deque top equals: 'third'.
	self assert: deque pop equals: 'third'.
	self assert: deque pop equals: 'second'.
	self assert: deque size equals: 1.
	self assert: deque top equals: 'first'
]

{ #category : 'tests' }
CTDequeTest >> testWithAllConstructor [

	| testDeque |
	testDeque := CTDeque withAll: #('a' 'b' 'c').
	
	self assert: testDeque size equals: 3.
	self assert: testDeque first equals: 'a'.
	self assert: testDeque last equals: 'c'
]
