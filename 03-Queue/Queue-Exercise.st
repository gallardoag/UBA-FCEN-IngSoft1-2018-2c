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

!Queue methodsFor: 'operations - private' stamp: 'A.G. 10/4/2018 14:37:02'!
head

	^head! !

!Queue methodsFor: 'operations - private' stamp: 'A.G. 10/4/2018 12:58:22'!
tail

	^tail! !


!Queue methodsFor: 'operations - public' stamp: 'A.G. 10/4/2018 14:47:10'!
dequeue

	^self head dequeue! !

!Queue methodsFor: 'operations - public' stamp: 'A.G. 10/4/2018 12:57:32'!
enqueue:anObject

	self tail enqueue: anObject! !

!Queue methodsFor: 'operations - public' stamp: 'L 10/3/2018 14:59:35'!
isEmpty

	^ head next isEmpty .! !

!Queue methodsFor: 'operations - public' stamp: 'L 10/3/2018 16:01:39'!
next

	^ head next content .! !

!Queue methodsFor: 'operations - public' stamp: 'A.G. 10/4/2018 14:25:12'!
size

	^ head next deepSize ! !


!Queue methodsFor: 'initialization' stamp: 'A.G. 10/4/2018 14:32:55'!
initialize

	head _ QueueHead new.
	tail _ QueueTail new.
	head next: tail.
	tail prev: head.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Queue class' category: #'Queue-Exercise'!
Queue class
	instanceVariableNames: ''!

!Queue class methodsFor: 'error descriptions'!
queueEmptyErrorDescription
	^ 'Queue is empty'.! !



!classDefinition: #QueueObject category: #'Queue-Exercise'!
Object subclass: #QueueObject
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Queue-Exercise'!

!QueueObject methodsFor: 'common protocol' stamp: 'd 10/4/2018 15:28:35'!
dequeue

	^ self subclassResponsibility .! !


!classDefinition: #QueueElement category: #'Queue-Exercise'!
QueueObject subclass: #QueueElement
	instanceVariableNames: 'prev content next'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Queue-Exercise'!

!QueueElement methodsFor: 'common protocol' stamp: 'A.G. 10/4/2018 14:45:35'!
dequeue

	(self prev) next: (self next).
	(self next) prev: (self prev).
	^(self content)! !


!QueueElement methodsFor: 'accessing' stamp: 'L 10/3/2018 14:41:15'!
content

	^content ! !

!QueueElement methodsFor: 'accessing' stamp: 'A.G. 10/4/2018 14:37:36'!
next

	^next! !

!QueueElement methodsFor: 'accessing' stamp: 'A.G. 10/4/2018 14:37:41'!
prev

	^prev! !


!QueueElement methodsFor: 'queue operations' stamp: 'L 10/3/2018 14:39:48'!
isEmpty

	^ false! !

!QueueElement methodsFor: 'queue operations' stamp: 'A.G. 10/4/2018 14:31:31'!
prev:aQueueObject

	prev _ aQueueObject! !


!QueueElement methodsFor: 'operations private' stamp: 'L 10/3/2018 14:40:42'!
content:anObject

	content _ anObject 
	! !

!QueueElement methodsFor: 'operations private' stamp: 'L 10/3/2018 14:40:04'!
deepSize

	^ 1 + next deepSize ! !

!QueueElement methodsFor: 'operations private' stamp: 'A.G. 10/4/2018 14:30:43'!
next: aQueueObject

	next _ aQueueObject! !


!classDefinition: #QueueHead category: #'Queue-Exercise'!
QueueObject subclass: #QueueHead
	instanceVariableNames: 'next'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Queue-Exercise'!

!QueueHead methodsFor: 'common protocol' stamp: 'A.G. 10/4/2018 14:45:43'!
dequeue

	^((self next) dequeue)! !


!QueueHead methodsFor: 'operations private' stamp: 'A.G. 10/4/2018 14:37:23'!
next

	^next! !

!QueueHead methodsFor: 'operations private' stamp: 'A.G. 10/4/2018 14:31:10'!
next: aQueueObject

	next _ aQueueObject! !


!classDefinition: #QueueTail category: #'Queue-Exercise'!
QueueObject subclass: #QueueTail
	instanceVariableNames: 'prev'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Queue-Exercise'!

!QueueTail methodsFor: 'common protocol' stamp: 'A.G. 10/4/2018 14:23:39'!
dequeue

	^self error: Queue queueEmptyErrorDescription ! !


!QueueTail methodsFor: 'accessing' stamp: 'L 10/3/2018 20:30:49'!
content

	^ self error: Queue queueEmptyErrorDescription ! !

!QueueTail methodsFor: 'accessing' stamp: 'A.G. 10/4/2018 14:37:28'!
prev

	^prev! !


!QueueTail methodsFor: 'operations private' stamp: 'L 10/3/2018 14:39:38'!
deepSize

	^ 0! !

!QueueTail methodsFor: 'operations private' stamp: 'A.G. 10/4/2018 14:31:50'!
prev:aQueueObject

	prev _ aQueueObject! !


!QueueTail methodsFor: 'queue operations' stamp: 'A.G. 10/4/2018 14:41:01'!
enqueue:anObject

	|newElement|
		
	newElement _ QueueElement new.
	newElement content: anObject .
	newElement next: self.
	newElement prev: self prev.
	(self prev) next: newElement.
	self prev: newElement.! !

!QueueTail methodsFor: 'queue operations' stamp: 'L 10/3/2018 14:39:28'!
isEmpty

	^ true! !
