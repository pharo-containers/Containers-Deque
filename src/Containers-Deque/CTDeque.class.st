"
I implement a double-ended queue (Deque) that grows dynamically as needed using a circular array.
"
Class {
	#name : 'CTDeque',
	#superclass : 'Object',
	#instVars : [
		'elements',
		'frontIndex',
		'rearIndex',
		'size'
	],
	#category : 'Containers-Deque',
	#package : 'Containers-Deque'
}

{ #category : 'instance creation' }
CTDeque class >> new [

	^ self new: 10
]

{ #category : 'instance creation' }
CTDeque class >> new: anInteger [

	anInteger < 0 ifTrue: [ self error: 'Initial capacity cannot be negative' ].
	^ self basicNew
		initializeWithCapacity: anInteger;
		yourself
]

{ #category : 'adding' }
CTDeque >> addFirst: anElement [
	"Add an element to the front of the deque"
	
	self isFull ifTrue: [ self grow ].
	
	frontIndex := self previousIndex: frontIndex.
	elements at: frontIndex put: anElement.
	size := size + 1.
	
	^ self
]

{ #category : 'adding' }
CTDeque >> addLast: anElement [
	"Add an element to the rear of the deque"
	
	self isFull ifTrue: [ self grow ].
	
	elements at: rearIndex put: anElement.
	rearIndex := self nextIndex: rearIndex.
	size := size + 1.
	
	^ self
]

{ #category : 'accessing' }
CTDeque >> capacity [

	"Return the current capacity of the deque"
	
	^ elements size
]

{ #category : 'accessing' }
CTDeque >> first [

	"Return the front element without removing it.
	Signal an error if the deque is empty."
	
	self isEmpty ifTrue: [ self error: 'Deque is empty' ].
	^ elements at: frontIndex
]

{ #category : 'private' }
CTDeque >> grow [

	"Double the capacity and reorganize elements to maintain order"
	| newElements newCapacity |
	
	newCapacity := (self capacity = 0 ifTrue: [ 10 ] ifFalse: [ self capacity * 2 ]).
	newElements := Array new: newCapacity.
	
	1 to: size do: [ :i |
		newElements at: i put: (elements at: (self indexAt: i - 1))
	].
	
	elements := newElements.
	frontIndex := 1.
	rearIndex := size + 1.
]

{ #category : 'private' }
CTDeque >> indexAt: offset [

	"Return the actual array index for a given offset from front"
	
	^ ((frontIndex - 1 + offset) rem: self capacity) + 1
]

{ #category : 'initialization' }
CTDeque >> initializeWithCapacity: anInteger [

	elements := Array new: anInteger.
	frontIndex := 1.
	rearIndex := 1.
	size := 0
]

{ #category : 'testing' }
CTDeque >> isEmpty [

	"Return true if the deque is empty"
	
	^ size = 0
]

{ #category : 'testing' }
CTDeque >> isFull [

	"Return true if deque is at maximum capacity"
	
	^ size = self capacity
]

{ #category : 'accessing' }
CTDeque >> last [

	"Return the rear element without removing it.
	Signal an error if the deque is empty."
	
	self isEmpty ifTrue: [ self error: 'Deque is empty' ].
	^ elements at: (self previousIndex: rearIndex)
]

{ #category : 'private' }
CTDeque >> nextIndex: currentIndex [

	"Calculate next index in circular array"
	
	^ currentIndex = self capacity 
		ifTrue: [ 1 ]
		ifFalse: [ currentIndex + 1 ]
]

{ #category : 'private' }
CTDeque >> previousIndex: currentIndex [

	"Calculate previous index in circular array"
	
	^ currentIndex = 1
		ifTrue: [ self capacity ]
		ifFalse: [ currentIndex - 1 ]
]

{ #category : 'removing' }
CTDeque >> removeFirst [

	"Return and remove the front element from the deque.
	Signal an error if the deque is empty."
	
	| element |
	self isEmpty ifTrue: [ self error: 'Deque is empty' ].
	
	element := elements at: frontIndex.
	elements at: frontIndex put: nil.
	frontIndex := self nextIndex: frontIndex.
	size := size - 1.
	
	^ element
]

{ #category : 'removing' }
CTDeque >> removeLast [

	"Return and remove the rear element from the deque.
	Signal an error if the deque is empty."
	
	| element |
	self isEmpty ifTrue: [ self error: 'Deque is empty' ].
	
	rearIndex := self previousIndex: rearIndex.
	element := elements at: rearIndex.
	elements at: rearIndex put: nil.
	size := size - 1.
	
	^ element
]

{ #category : 'accessing' }
CTDeque >> size [

	"Return the number of elements in the deque"
	
	^ size
]
