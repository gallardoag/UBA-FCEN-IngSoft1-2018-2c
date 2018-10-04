!classDefinition: #QueueTest category: #'Queue-Exercise'!
TestCase subclass: #QueueTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Queue-Exercise'!

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test01QueueShouldBeEmptyWhenCreated

	| queue |

	queue _ Queue new.

	self assert: queue isEmpty.! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test02EnqueueAddElementsToTheQueue

	| queue |

	queue _ Queue new.
	queue enqueue: 'Something'.

	self deny: queue isEmpty.! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test03DequeueRemovesElementsFromTheQueue

	| queue |

	queue _ Queue new.
	queue enqueue: 'Something'.
	queue dequeue.

	self assert: queue isEmpty.! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test04DequeueReturnsFirstEnqueuedObject

	| queue firstQueued secondQueued |

	queue _ Queue new.
	firstQueued _ 'Something1'.
	secondQueued _ 'Something2'.
	queue enqueue: firstQueued.
	queue enqueue: secondQueued.
	
	self assert: queue dequeue equals: firstQueued.! !

!QueueTest methodsFor: 'test' stamp: 'CGCM 9/27/2018 16:34:58'!
test05QueueBehavesFIFO

	| queue firstQueued secondQueued |

	queue _ Queue new.
	firstQueued _ 'First'.
	secondQueued _ 'Second'.
	queue enqueue: firstQueued.
	queue enqueue: secondQueued.

	self assert: queue dequeue equals: firstQueued.
	self assert: queue dequeue equals: secondQueued.
	self assert: queue isEmpty.! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test06NextReturnsFirstEnqueuedObject

	| queue firstQueued |

	queue _ Queue new.
	firstQueued _ 'Something'.
	queue enqueue: firstQueued.

	self assert: queue next equals: firstQueued.! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test07NextDoesNotRemoveObjectFromQueue

	| queue firstQueued |

	queue _ Queue new.
	firstQueued _ 'Something'.
	queue enqueue: firstQueued.

	queue next.
	self assert: queue size equals: 1.! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test08CanNotDequeueWhenThereAreNoObjectsInTheQueue

	| queue |

	queue _ Queue new.
	
	self
		should: [ queue dequeue ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Queue queueEmptyErrorDescription ].! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test09CanNotDequeueWhenThereAreNoObjectsInTheQueueAndTheQueueHadObjects

	| queue |

	queue _ Queue new.
	queue enqueue: 'Something'.
	queue dequeue.

	self
		should: [ queue dequeue ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Queue queueEmptyErrorDescription ].! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test10CanNotNextWhenThereAreNoObjectsInTheQueue

	| queue |

	queue _ Queue new.

	self
		should: [ queue next ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Queue queueEmptyErrorDescription ].! !


!classDefinition: #Queue category: #'Queue-Exercise'!
Object subclass: #Queue
	instanceVariableNames: 'head tail'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Queue-Exercise'!

!Queue methodsFor: 'as yet unclassified' stamp: 'L 10/3/2018 22:06:05'!
dequeue

	|oldHead|
	(head next  isKindOf: QueueTail ) ifTrue: [^ self error: self class  queueEmptyErrorDescription .].

	(head next isKindOf: QueueElement) ifTrue: [
		
		oldHead _ head next.
		head next: oldHead next.
		^ oldHead content
		
		].	
	! !

!Queue methodsFor: 'as yet unclassified' stamp: 'L 10/3/2018 21:09:29'!
enqueue:anObject

	|newElement|
		
	newElement _ QueueElement new.
	newElement content: anObject .

	(tail  isKindOf: QueueTail ) ifTrue: [head next:newElement. newElement next:QueueTail new. tail _ newElement].
	(tail  isKindOf: QueueElement ) ifTrue: [
		
		tail next:newElement .
		tail _ newElement .
		tail next: QueueTail new. 
		
	
		
		]! !

!Queue methodsFor: 'as yet unclassified' stamp: 'L 10/3/2018 15:00:59'!
initialize

	head _ QueueHead new.
	tail _ QueueTail new.
	head next:tail.! !

!Queue methodsFor: 'as yet unclassified' stamp: 'L 10/3/2018 14:59:35'!
isEmpty

	^ head next isEmpty .! !

!Queue methodsFor: 'as yet unclassified' stamp: 'L 10/3/2018 16:01:39'!
next

	^ head next content .! !

!Queue methodsFor: 'as yet unclassified' stamp: 'L 10/3/2018 16:02:12'!
size

	^ head next deepSize ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Queue class' category: #'Queue-Exercise'!
Queue class
	instanceVariableNames: ''!

!Queue class methodsFor: 'error descriptions'!
queueEmptyErrorDescription
	^ 'Queue is empty'.! !


!Queue class methodsFor: 'casing' stamp: 'L 10/3/2018 20:30:13'!
signalQueueIsEmpty
	^ self error: self class queueEmptyErrorDescription ! !


!classDefinition: #QueueElement category: #'Queue-Exercise'!
Object subclass: #QueueElement
	instanceVariableNames: 'content next'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Queue-Exercise'!

!QueueElement methodsFor: 'as yet unclassified' stamp: 'L 10/3/2018 23:48:49'!
addElementToTheQueue:anObject withHead:aHead withTail:aTail! !

!QueueElement methodsFor: 'as yet unclassified' stamp: 'L 10/3/2018 14:41:15'!
content

	^content ! !

!QueueElement methodsFor: 'as yet unclassified' stamp: 'L 10/3/2018 14:40:42'!
content:anObject

	content _ anObject 
	! !

!QueueElement methodsFor: 'as yet unclassified' stamp: 'L 10/3/2018 14:40:04'!
deepSize

	^ 1 + next deepSize ! !

!QueueElement methodsFor: 'as yet unclassified' stamp: 'L 10/3/2018 14:39:48'!
isEmpty

	^ false! !

!QueueElement methodsFor: 'as yet unclassified' stamp: 'L 10/3/2018 14:41:06'!
next

	^next! !

!QueueElement methodsFor: 'as yet unclassified' stamp: 'L 10/3/2018 14:40:54'!
next:anObject

	next _ anObject ! !


!classDefinition: #QueueHead category: #'Queue-Exercise'!
Object subclass: #QueueHead
	instanceVariableNames: 'next'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Queue-Exercise'!

!QueueHead methodsFor: 'as yet unclassified' stamp: 'L 10/3/2018 14:32:41'!
isEmpty

	^ true! !

!QueueHead methodsFor: 'as yet unclassified' stamp: 'L 10/3/2018 15:00:12'!
next

	^ next! !

!QueueHead methodsFor: 'as yet unclassified' stamp: 'L 10/3/2018 14:40:29'!
next:anObject

	next _ anObject ! !


!classDefinition: #QueueTail category: #'Queue-Exercise'!
Object subclass: #QueueTail
	instanceVariableNames: 'prev'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Queue-Exercise'!

!QueueTail methodsFor: 'as yet unclassified' stamp: 'L 10/4/2018 00:01:37'!
addElementToTheQueue:anObject withHead:aHead withTail:aTail

	|newElement|
	
	newElement _ QueueElement new content: anObject .
	newElement next:self.
	aHead next: self.
	! !

!QueueTail methodsFor: 'as yet unclassified' stamp: 'L 10/3/2018 20:30:49'!
content

	^ self error: Queue queueEmptyErrorDescription ! !

!QueueTail methodsFor: 'as yet unclassified' stamp: 'L 10/3/2018 14:39:38'!
deepSize

	^ 0! !

!QueueTail methodsFor: 'as yet unclassified' stamp: 'L 10/3/2018 14:39:28'!
isEmpty

	^ true! !

!QueueTail methodsFor: 'as yet unclassified' stamp: 'L 10/3/2018 15:29:49'!
prev:anElement

	prev _ anElement ! !
