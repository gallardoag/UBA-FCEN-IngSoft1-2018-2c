!classDefinition: #CartTest category: #'TusLibros-Iteracion1'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion1'!

!CartTest methodsFor: 'as yet unclassified' stamp: 'das 11/12/2018 20:37:05'!
test01_newCartIsEmpty

	|cart catalog | 
	catalog _ OrderedCollection new.
	cart _ Cart with: catalog.
	
	self assert: cart isEmpty ! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'das 11/12/2018 20:37:47'!
test02_addedItemAppearsOnCart

	|cart anISBN catalog |
	anISBN _ '9780068689'.
	catalog _ OrderedCollection with: anISBN.
	cart _ Cart with:catalog .
	cart addItem:anISBN times:1.
	self deny: cart isEmpty .
	self assert: (cart isitemInCart:anISBN) .
	self assert: 1 equals: (cart howManyOf:anISBN )! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'das 11/12/2018 20:38:10'!
test03_cannotAddAItem0Times

	|cart anISBN catalog |
	anISBN _ '9780068689'.
	catalog _ OrderedCollection with: anISBN .
	cart _ Cart with:catalog .
	self should: [cart addItem: anISBN times:0 ] raise:Error  withExceptionDo: [:anError | anError messageText =Cart cannotAddAItem0Times.
		self assert: cart isEmpty ]! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'das 11/12/2018 20:38:33'!
test03_cannotAddAItemANotIntegerTime

	|cart anISBN catalog |
	anISBN _ '9780068689'.
	catalog _ OrderedCollection with: anISBN .
	cart _ Cart with: catalog.
	self should: [cart addItem: anISBN times:3.14 ] raise:Error  withExceptionDo: [:anError | anError messageText =Cart cannotAddAnItemANonIntengerTimes.
		self assert: cart isEmpty ]! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'das 11/12/2018 20:39:23'!
test04_cannotAddAnItemNotPresentInCatalog

	|cart anISBN anotherISBN catalog |
	anISBN _ '9780068689'.
	anotherISBN _ '9780068690'.
	catalog := OrderedCollection with: anotherISBN .
	cart _ Cart with: catalog.
	self should: [cart addItem: anISBN times:3 ] raise:Error  withExceptionDo: [:anError | anError messageText =Cart cannotAddAnItemNotPresentInCatalog.
		self assert: cart isEmpty ]! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'das 11/12/2018 20:51:31'!
test05_cartContentCanBeKnown

	|cart anISBN anotherISBN catalog |
	anISBN _ '9780068689'.
	anotherISBN _ '9780068690'.
	catalog := OrderedCollection with: anISBN with: anotherISBN.
	cart _ Cart with: catalog.
	cart addItem: anISBN times:3.
	cart addItem: anotherISBN times:2.

	self assert: (cart content size) equals: 5.
	self assert: (cart content includes: anISBN).
	self assert: (cart content includes: anotherISBN).! !


!classDefinition: #Cart category: #'TusLibros-Iteracion1'!
Object subclass: #Cart
	instanceVariableNames: 'items catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion1'!

!Cart methodsFor: 'as yet unclassified' stamp: 'das 11/12/2018 20:35:42'!
addItem: anISBN times: aNumber 

	(aNumber > 0) ifFalse: [^self error: self class cannotAddAItem0Times ].
	(aNumber isKindOf: Integer ) ifFalse: [^self error: self class cannotAddAnItemANonIntengerTimes ].
	(catalog includes: anISBN ) ifFalse: [^self error: self class cannotAddAnItemNotPresentInCatalog ].
	items add: anISBN withOccurrences: aNumber .! !

!Cart methodsFor: 'as yet unclassified' stamp: 'das 11/12/2018 20:55:51'!
content

	^ items copy. ! !

!Cart methodsFor: 'as yet unclassified' stamp: 'das 11/12/2018 20:07:14'!
howManyOf: anISBNNumber 
	self assert: (self isitemInCart:anISBNNumber )..
	^ items occurrencesOf: anISBNNumber ! !

!Cart methodsFor: 'as yet unclassified' stamp: 'das 11/12/2018 20:01:16'!
initialize

	items _ Bag new.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'das 11/12/2018 20:29:34'!
initializeWith:aCatalog

	catalog _ aCatalog! !

!Cart methodsFor: 'as yet unclassified' stamp: 'das 11/12/2018 20:01:26'!
isEmpty
	^ items isEmpty ! !

!Cart methodsFor: 'as yet unclassified' stamp: 'das 11/12/2018 20:04:54'!
isitemInCart:anISBN

	^ items includes: anISBN ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'TusLibros-Iteracion1'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'as yet unclassified' stamp: 'das 11/12/2018 20:10:03'!
cannotAddAItem0Times
	
		^ ' Please enter a positive Integer'! !

!Cart class methodsFor: 'as yet unclassified' stamp: 'das 11/12/2018 20:14:23'!
cannotAddAnItemANonIntengerTimes

	^ ' Please Enter a Positive Intenger'.! !

!Cart class methodsFor: 'as yet unclassified' stamp: 'das 11/12/2018 20:34:48'!
cannotAddAnItemNotPresentInCatalog
	
		^ ' Item not present in the product catalog'! !

!Cart class methodsFor: 'as yet unclassified' stamp: 'das 11/12/2018 20:28:40'!
with:aCatalog

	^ self new initializeWith: aCatalog ! !
