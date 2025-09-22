# Containers-Deque
A High-performance, Circular Array based Deque (Double-Ended Queue) implementation providing efficient operations at both ends with dynamic capacity and proper error handling.

![Pharo Version](https://img.shields.io/badge/Pharo-10+-blue)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

## What is a Deque?

A Deque (Double-Ended Queue) is a linear data structure that allows insertion and deletion at both ends. It combines the functionality of both stacks and queues, making it extremely versatile. You can efficiently add or remove elements from either the front or the rear.

### Key Benefits
- **O(1) Performance**: Constant time operations at both front and rear
- **Versatile Usage**: Can function as stack, queue, or full deque
- **Dynamic Growth**: Circular array implementation that doubles capacity when needed
- **Memory Safe**: Automatic cleanup prevents memory leaks
- **Rich API**: Multiple interfaces for different usage patterns
- **Robust Error Handling**: Proper empty deque protection with clear error messages

## Loading 
The following script installs Containers-Deque in Pharo.

```smalltalk
Metacello new
  baseline: 'ContainersDeque';
  repository: 'github://pharo-containers/Containers-Deque/src';
  load.
```

## If you want to depend on it 

Add the following code to your Metacello baseline or configuration 

```smalltalk
spec 
   baseline: 'ContainersDeque' 
   with: [ spec repository: 'github://pharo-containers/Containers-Deque/src' ].
```

## Quick Start

```smalltalk
"Create a deque with default capacity of 10"
deque := CTDeque new.

"Add elements at both ends"
deque addFirst: 'front1'.
deque addLast: 'rear1'.
deque addFirst: 'front2'.
deque addLast: 'rear2'.

"Access elements without removing"
deque first.         "Returns 'front2'"
deque last.          "Returns 'rear2'"
deque size.          "Returns 4"

"Remove elements from both ends"
deque removeFirst.   "Returns 'front2'"
deque removeLast.    "Returns 'rear2'"
deque removeFirst.   "Returns 'front1'"
deque removeLast.    "Returns 'rear1'"

"Deque is now empty"
deque isEmpty.       "Returns true"
```

## Contributing

This is part of the Pharo Containers project. Feel free to contribute by implementing additional methods, improving tests, or enhancing documentation.