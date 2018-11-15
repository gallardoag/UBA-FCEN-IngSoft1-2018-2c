!classDefinition: #CartTest category: #'TusLibros-Iteracion1'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion1'!

!CartTest methodsFor: 'Testing' stamp: 'das 11/12/2018 20:37:05'!
test01_newCartIsEmpty

	|cart catalog | 
	catalog _ OrderedCollection new.
	cart _ Cart with: catalog.
	
	self assert: cart isEmpty ! !

!CartTest methodsFor: 'Testing' stamp: 'das 11/12/2018 20:37:47'!
test02_addedItemAppearsOnCart

	|cart anISBN catalog |
	anISBN _ '9780068689'.
	catalog _ OrderedCollection with: anISBN.
	cart _ Cart with:catalog .
	cart addItem:anISBN times:1.
	self deny: cart isEmpty .
	self assert: (cart isitemInCart:anISBN) .
	self assert: 1 equals: (cart howManyOf:anISBN )! !

!CartTest methodsFor: 'Testing' stamp: 'LE 11/15/2018 14:28:56'!
test03_cannotAddAItem0Times

	|cart anISBN catalog |
	anISBN _ '9780068689'.
	catalog _ OrderedCollection with: anISBN .
	cart _ Cart with:catalog .
	self should: [cart addItem: anISBN times:0 ] raise:Error  withExceptionDo: [:anError | anError messageText =Cart invalidQuantityErrorMessage .
		self assert: cart isEmpty ]! !

!CartTest methodsFor: 'Testing' stamp: 'LE 11/15/2018 14:29:26'!
test03_cannotAddAItemANotIntegerTime

	|cart anISBN catalog |
	anISBN _ '9780068689'.
	catalog _ OrderedCollection with: anISBN .
	cart _ Cart with: catalog.
	self should: [cart addItem: anISBN times:3.14 ] raise:Error  withExceptionDo: [:anError | anError messageText =Cart invalidQuantityErrorMessage .
		self assert: cart isEmpty ]! !

!CartTest methodsFor: 'Testing' stamp: 'LE 11/15/2018 14:29:18'!
test04_cannotAddAnItemNotPresentInCatalog

	|cart anISBN anotherISBN catalog |
	anISBN _ '9780068689'.
	anotherISBN _ '9780068690'.
	catalog := OrderedCollection with: anotherISBN .
	cart _ Cart with: catalog.
	self should: [cart addItem: anISBN times:3 ] raise:Error  withExceptionDo: [:anError | anError messageText =Cart invalidQuantityErrorMessage .
		self assert: cart isEmpty ]! !

!CartTest methodsFor: 'Testing' stamp: 'das 11/12/2018 20:51:31'!
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

!Cart methodsFor: 'assertions' stamp: 'LE 11/15/2018 13:31:33'!
howManyOf: anISBNNumber 
	
	^ items occurrencesOf: anISBNNumber 
	! !

!Cart methodsFor: 'assertions' stamp: 'das 11/12/2018 20:01:26'!
isEmpty
	^ items isEmpty ! !

!Cart methodsFor: 'assertions' stamp: 'das 11/12/2018 20:04:54'!
isitemInCart:anISBN

	^ items includes: anISBN ! !


!Cart methodsFor: 'initialization' stamp: 'LE 11/15/2018 13:34:54'!
initializeWith:aCatalog

	items _ Bag new.
	catalog _ aCatalog! !


!Cart methodsFor: 'adding' stamp: 'LE 11/15/2018 14:28:24'!
addItem: anISBN times: aNumber 

	((aNumber isKindOf: Integer ) and: [aNumber > 0])
	ifFalse: [^self error: self class invalidQuantityErrorMessage ].
	(catalog includes: anISBN ) ifFalse: [^self error: self class invalidItemErrorMessage ].
	items add: anISBN withOccurrences: aNumber .! !


!Cart methodsFor: 'accessing' stamp: 'das 11/12/2018 20:55:51'!
content

	^ items copy. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'TusLibros-Iteracion1'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'LE 11/15/2018 13:34:03'!
with:aCatalog

	^ self new initializeWith: aCatalog ! !


!Cart class methodsFor: 'error messages' stamp: 'LE 11/15/2018 14:25:04'!
invalidItemErrorMessage
	
		^ ' Item not present in the product catalog'! !

!Cart class methodsFor: 'error messages' stamp: 'LE 11/15/2018 14:24:54'!
invalidQuantityErrorMessage

		^ ' Please enter a positive Integer'! !
