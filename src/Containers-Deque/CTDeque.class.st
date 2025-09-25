"
I implement a double-ended queue (Deque) that grows dynamically as needed using a circular array.
- #addFirst: adds a new object to the front of the deque.
- #addLast: adds a new object to the rear of the deque.
- #removeFirst returns and removes the front element from the deque.
- #removeLast returns and removes the rear element from the deque.
- #first answers the front element without removing it.
- #last answers the rear element without removing it.
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

{ #category : 'instance creation' }
CTDeque class >> withAll: aCollection [

	"Create a new deque with elements from aCollection"
	| newDeque |
	newDeque := self new: (aCollection size max: 10).
	newDeque addAllLast: aCollection.
	^ newDeque
]

{ #category : 'adding' }
CTDeque >> add: anElement [

    ^ self addLast: anElement
]

{ #category : 'adding' }
CTDeque >> addAllFirst: aCollection [

	"Add all elements from aCollection to the front of the deque (in reverse order)"
	
	aCollection do: [ :each | self addFirst: each ].
	^ self
]

{ #category : 'adding' }
CTDeque >> addAllLast: aCollection [

	"Add all elements from aCollection to the rear of the deque"
	
	aCollection do: [ :each | self addLast: each ].
	^ self
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

{ #category : 'converting' }
CTDeque >> asArray [

	"Convert deque to array maintaining front-to-rear order"
	| result |
	self isEmpty ifTrue: [ ^ #() ].
	
	result := Array new: self size.
	1 to: self size do: [ :i |
		result at: i put: (elements at: (self indexAt: i - 1))
	].
	^ result
]

{ #category : 'converting' }
CTDeque >> asOrderedCollection [

	"Convert deque to OrderedCollection maintaining front-to-rear order"
	| result |
	result := OrderedCollection new: self size.
	self do: [ :each | result add: each ].
	^ result
]

{ #category : 'accessing' }
CTDeque >> capacity [

	"Return the current capacity of the deque"
	
	^ elements size
]

{ #category : 'copying' }
CTDeque >> copy [

	"Create a shallow copy of this deque"
	| newDeque |
	newDeque := self class new: self capacity.
	self do: [ :each | newDeque addLast: each ].
	^ newDeque
]

{ #category : 'actions' }
CTDeque >> dequeue [
	"Remove and return front element"

	^ self removeFirst
]

{ #category : 'enumerating' }
CTDeque >> do: aBlock [

	"Iterate over elements from front to rear"
	
	self isEmpty ifTrue: [ ^ self ].
	
	0 to: size - 1 do: [ :offset |
		aBlock value: (elements at: (self indexAt: offset))
	]
]

{ #category : 'accessing' }
CTDeque >> enqueue: anElement [

	^ self addLast: anElement
]

{ #category : 'accessing' }
CTDeque >> first [

	"Return the front element without removing it.
	Signal an error if the deque is empty."
	
	self isEmpty ifTrue: [ self error: 'Deque is empty' ].
	^ elements at: frontIndex
]

{ #category : 'actions' }
CTDeque >> front [

	"Return front element without removing"
	
	^ self first
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

{ #category : 'testing' }
CTDeque >> includes: anElement [

	"Return true if anElement exists in the deque"
	
	self isEmpty ifTrue: [ ^ false ].
	
	0 to: size - 1 do: [ :offset |
		(elements at: (self indexAt: offset)) = anElement ifTrue: [ ^ true ]
	].
	^ false
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

{ #category : 'removing' }
CTDeque >> pop [
	"Remove and return front element"

	^ self removeFirst
]

{ #category : 'private' }
CTDeque >> previousIndex: currentIndex [

	"Calculate previous index in circular array"
	
	^ currentIndex = 1
		ifTrue: [ self capacity ]
		ifFalse: [ currentIndex - 1 ]
]

{ #category : 'adding' }
CTDeque >> push: anElement [

	"Add element to front (stack-like interface)"
	
	^ self addFirst: anElement
]

{ #category : 'removing' }
CTDeque >> removeAll [

	"Remove all elements from the deque"
	
	elements := Array new: self capacity.
	frontIndex := 1.
	rearIndex := 1.
	size := 0
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
CTDeque >> removeFirstIfNone: aBlock [

	"Return and remove the front element, or evaluate aBlock if empty."
	
	self isEmpty ifTrue: [ ^ aBlock value ].
	^ self removeFirst
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

{ #category : 'removing' }
CTDeque >> removeLastIfNone: aBlock [

	"Return and remove the rear element, or evaluate aBlock if empty."
	
	self isEmpty ifTrue: [ ^ aBlock value ].
	^ self removeLast
]

{ #category : 'enumerating' }
CTDeque >> reverseDo: aBlock [

	"Iterate over elements from rear to front"
	
	self isEmpty ifTrue: [ ^ self ].
	
	size - 1 to: 0 by: -1 do: [ :offset |
		aBlock value: (elements at: (self indexAt: offset))
	]
]

{ #category : 'accessing' }
CTDeque >> search: anObject [

	"Return the 1-based position of anObject from the front of the deque.
	Return -1 if the object is not found.
	The front element is at position 1."
	
	self isEmpty ifTrue: [ ^ -1 ].
	
	0 to: size - 1 do: [ :offset |
		(elements at: (self indexAt: offset)) = anObject ifTrue: [ 
			^ offset + 1 
		]
	].
	^ -1
]

{ #category : 'accessing' }
CTDeque >> size [

	"Return the number of elements in the deque"
	
	^ size
]

{ #category : 'accessing' }
CTDeque >> top [

	"Return front element without removing"
	
	^ self first
]
