!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #RestInterfaceTest category: #TusLibros!
TestCase subclass: #RestInterfaceTest
	instanceVariableNames: 'factory interface clock debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterfaceTest methodsFor: 'setUp' stamp: 'LE 11/26/2018 21:09:16'!
setUp

	factory := StoreTestObjectsFactory new.
	clock _ ManualClock new.
	interface _ self createRestInterface .

! !


!RestInterfaceTest methodsFor: 'Testing' stamp: 'LE 11/25/2018 19:13:24'!
test01_cannotCreateCartWithInvalidUser


	
	self should: [interface createCartFor:factory unregisteredClient with: factory registeredClientPassword ]
	raise: Error  
	withExceptionDo:[:anError | anError messageText  = RestInteface clientNotFound.
		self assert: interface cartdatabase isEmpty 
		] ! !

!RestInterfaceTest methodsFor: 'Testing' stamp: 'LE 11/25/2018 19:13:33'!
test02_cannotCreateCartWithInvalidPassword


	
	self should: [interface createCartFor:factory registeredClient with: factory registeredClientInvalidPassword ]
	raise: Error  
	withExceptionDo:[:anError | anError messageText  = RestInteface wrongClientPassword.
	self assert: interface cartdatabase isEmpty 
		] 
	
	! !

!RestInterfaceTest methodsFor: 'Testing' stamp: 'LE 11/25/2018 19:13:44'!
test03_newCartIsEmpty

	|cartId|
	
	cartId := interface createCartFor:factory registeredClient with: factory registeredClientPassword.
	
	self assert: (interface listCart: cartId ) isEmpty .! !

!RestInterfaceTest methodsFor: 'Testing' stamp: 'LE 11/25/2018 19:14:12'!
test04_addingItemToCartAppearsOnCartList

	|cartId|
	cartId := interface createCartFor:factory registeredClient with: factory registeredClientPassword.
	interface addToCart:cartId ISBN: factory itemSellByTheStore Quantity:1.
	
	self assert: 1 equals:(interface listCart: cartId ) size.
	self assert: ((interface listCart:1) includes:(factory itemSellByTheStore)) .! !

!RestInterfaceTest methodsFor: 'Testing' stamp: 'LE 11/25/2018 19:14:19'!
test05_cannotAddAItemNotSold

	|  cartId |

	
	cartId := interface createCartFor:factory registeredClient with: factory registeredClientPassword.

	self should: [interface addToCart: cartId ISBN:factory itemNotSellByTheStore  Quantity:1 ] raise:Error  withExceptionDo: [
		:anError | anError = Cart invalidItemErrorMessage.
		self assert: (interface listCart: cartId ) isEmpty 
		 ]. ! !

!RestInterfaceTest methodsFor: 'Testing' stamp: 'LE 11/25/2018 19:14:25'!
test06_cannotAddItem0TimesToCart

	|  cartId |

	
	cartId := interface createCartFor:factory registeredClient with: factory registeredClientPassword.
	
	self should: [interface addToCart:cartId ISBN: factory itemSellByTheStore Quantity:0.] 
	raise:Error  
	withExceptionDo: [:anError | anError messageText = Cart invalidQuantityErrorMessage .
		self assert: (interface listCart: cartId) isEmpty. 
		]
! !

!RestInterfaceTest methodsFor: 'Testing' stamp: 'LE 11/25/2018 23:47:33'!
test07_cannotAddItemToANotValidCart

	|  cartId |

	
	cartId := 0.

	self should: [interface addToCart: cartId ISBN:factory itemNotSellByTheStore  Quantity:1 ] raise:Error  withExceptionDo: [
		:anError | anError = RestInteface invalidCartIDErrorMessage .
		self assert: interface cartdatabase isEmpty 
		 ]. ! !

!RestInterfaceTest methodsFor: 'Testing' stamp: 'LE 11/26/2018 21:00:14'!
test08bis_cannotCheckOutAfter30Minutes


	|cartId|
	cartId := interface createCartFor:factory registeredClient with: factory registeredClientPassword.
	interface addToCart: cartId ISBN:factory itemSellByTheStore  Quantity:1.
	
	self advanceTime: (30 * minute).

	self should: [interface checkOutCart: cartId with: factory notExpiredCreditCard ] raise:Error  withExceptionDo: [
		:anError | anError = CartSession expiredSessionErrorMessage .
		

		
		 ]. ! !

!RestInterfaceTest methodsFor: 'Testing' stamp: 'LE 11/26/2018 21:00:14'!
test08_cannotAddItemAfter30Minutes


	|cartId|
	cartId := interface createCartFor:factory registeredClient with: factory registeredClientPassword.
	self advanceTime: (30 * minute).

	self should: [interface addToCart: cartId ISBN:factory itemSellByTheStore  Quantity:1 ] raise:Error  withExceptionDo: [
		:anError | anError = CartSession expiredSessionErrorMessage .
		self assert: (interface listCart: cartId ) isEmpty 
		
		 ]. ! !

!RestInterfaceTest methodsFor: 'Testing' stamp: 'LE 11/25/2018 23:45:28'!
test09_canAddItemBeforeTimeOut


	|cartId|
	cartId := interface createCartFor:factory registeredClient with: factory registeredClientPassword.
	self advanceTime: (25 * minute).
	interface addToCart: cartId ISBN:factory itemSellByTheStore  Quantity:1 .
	self deny: (interface listCart: cartId) isEmpty 
	
		

		
		 ! !

!RestInterfaceTest methodsFor: 'Testing' stamp: 'LE 11/26/2018 18:03:00'!
test10_cannotCheckoutWithAEmptyCart

	|cartId|
	cartId := interface createCartFor:factory registeredClient with: factory registeredClientPassword.
	self should: [ interface checkOutCart:cartId with: (factory notExpiredCreditCard)] 
	raise:Error  withExceptionDo: [:anError |
		self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage 
		] 
	

! !

!RestInterfaceTest methodsFor: 'Testing' stamp: 'LE 11/26/2018 21:00:14'!
test10_cannotCheckoutWithAExpiredCard

	|cartId|
	cartId := interface createCartFor:factory registeredClient with: factory registeredClientPassword.
	interface addToCart:cartId ISBN: factory itemSellByTheStore Quantity:1.

	self 
		should: [interface checkOutCart: cartId with:(factory expiredCreditCard )]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: (anError messageText = CartSession expiredSessionErrorMessage) 
	 ]



! !

!RestInterfaceTest methodsFor: 'Testing' stamp: 'LE 11/26/2018 18:44:56'!
test11_purchaseListIsEmptyWhenNoPurchasesHaveBeenDone

	self assert: (interface listPurchasesOf: factory registeredClient with: factory registeredClientPassword ) equals: (OrderedCollection new).! !

!RestInterfaceTest methodsFor: 'Testing' stamp: 'LE 11/26/2018 18:52:39'!
test12_aCorrectlyDonePurchaseIsListed

	|cartId debitedAmout debitedCreditCard |
		debitBehavior := [ :anAmount :aCreditCard | debitedAmout := anAmount. debitedCreditCard := aCreditCard ].
	cartId := interface createCartFor:factory registeredClient with: factory registeredClientPassword.
	interface addToCart:cartId ISBN: factory itemSellByTheStore Quantity:1.
	interface checkOutCart: cartId with: (factory notExpiredCreditCard ).
	self assert: (interface listPurchasesOf: factory registeredClient with: factory registeredClientPassword ) equals: (OrderedCollection with: factory  itemSellByTheStore ).! !


!RestInterfaceTest methodsFor: 'test support' stamp: 'LE 11/25/2018 23:35:44'!
createRestInterface

	^ RestInteface withDatabase: factory defaultUserDatabase WithCatalog: factory defaultCatalog RunningOn: clock savingSalesOn: OrderedCollection new WithMP: self.! !

!RestInterfaceTest methodsFor: 'test support' stamp: 'LE 11/25/2018 23:43:30'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!RestInterfaceTest methodsFor: 'as yet unclassified' stamp: 'LE 11/25/2018 20:37:04'!
advanceTime: aTimeSpan 
	clock advanceTime: aTimeSpan ! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'A.G. 11/22/2018 21:01:11'!
contents

	^ items copy! !

!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!Cart class methodsFor: 'error messages' stamp: 'LE 11/25/2018 11:16:34'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart class methodsFor: 'error messages' stamp: 'LE 11/25/2018 11:13:49'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!classDefinition: #CartSession category: #TusLibros!
Object subclass: #CartSession
	instanceVariableNames: 'cart currentTime lastUsed system'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartSession methodsFor: 'cart protocol' stamp: 'LE 11/26/2018 13:57:23'!
contents
	
	^ cart contents ! !


!CartSession methodsFor: 'as yet unclassified' stamp: 'LE 11/25/2018 19:30:32'!
ValidTime

	^ 30 * minute ! !

!CartSession methodsFor: 'as yet unclassified' stamp: 'LE 11/25/2018 22:14:57'!
add:anItem times:aNumber
	
	self updateTime .
	self assertIsStillValid .
	cart add:aNumber of:anItem ! !

!CartSession methodsFor: 'as yet unclassified' stamp: 'LE 11/25/2018 22:15:51'!
assertIsStillValid

	|timeSinceLastUsed|
	timeSinceLastUsed _ lastUsed distanceTo: currentTime .
	(timeSinceLastUsed >= self sessionDuration ) ifTrue: [^ self error: self class expiredSessionErrorMessage ].

	! !

!CartSession methodsFor: 'as yet unclassified' stamp: 'LE 11/25/2018 18:23:10'!
initializeWith:aSystem

	system _ aSystem .
	cart _ Cart acceptingItemsOf: aSystem catalog.
	currentTime _ aSystem now.
	lastUsed _ aSystem now.
	! !

!CartSession methodsFor: 'as yet unclassified' stamp: 'LE 11/26/2018 13:48:36'!
isEmpty

	^ cart contents isEmpty ! !

!CartSession methodsFor: 'as yet unclassified' stamp: 'LE 11/25/2018 21:59:39'!
sessionDuration

	^ 30 * minute ! !

!CartSession methodsFor: 'as yet unclassified' stamp: 'LE 11/25/2018 22:10:31'!
updateTime

	^currentTime _ system now.
	! !


!CartSession methodsFor: 'nil' stamp: 'LE 11/26/2018 18:48:07'!
total

	^ cart total.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartSession class' category: #TusLibros!
CartSession class
	instanceVariableNames: ''!

!CartSession class methodsFor: 'as yet unclassified' stamp: 'LE 11/25/2018 19:32:32'!
expiredSessionErrorMessage

	^ ' The session is expired'! !

!CartSession class methodsFor: 'as yet unclassified' stamp: 'LE 11/25/2018 19:04:00'!
in:aSystem

	^ self new initializeWith: aSystem .! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'LE 11/26/2018 19:19:26'!
createSale

	^ Sale of: total for: nil withItems: nil
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'LE 11/26/2018 18:30:05'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'LE 11/26/2018 18:28:34'!
isExpiredOn: aDate 
	

	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #ManualClock category: #TusLibros!
Object subclass: #ManualClock
	instanceVariableNames: 'now today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ManualClock methodsFor: 'as yet unclassified' stamp: 'LE 11/25/2018 20:34:21'!
advanceTime:aTimeSpan

	now _ now next:aTimeSpan .! !

!ManualClock methodsFor: 'as yet unclassified' stamp: 'LE 11/26/2018 18:15:53'!
initialize

	now _ GregorianDateTime now.
	today _ Date today .! !

!ManualClock methodsFor: 'as yet unclassified' stamp: 'LE 11/25/2018 19:08:40'!
now
	
	^now! !

!ManualClock methodsFor: 'as yet unclassified' stamp: 'LE 11/25/2018 20:34:44'!
rewindTime:aTimeSpan

	now _ now next: aTimeSpan negated ! !

!ManualClock methodsFor: 'as yet unclassified' stamp: 'LE 11/26/2018 18:28:01'!
today

	^ today .! !


!classDefinition: #RestInteface category: #TusLibros!
Object subclass: #RestInteface
	instanceVariableNames: 'clientDatabase cartDatabase lastCartId catalog clock salesBook merchantProccessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInteface methodsFor: 'initialization' stamp: 'LE 11/25/2018 23:39:16'!
initializeWith: aClientDatabase withItems:aCatalog RunningOn: aClock SavingSalesOn: aSalesBook MakingTransactionsWith: aMP  .
	
	clientDatabase _ aClientDatabase.
	cartDatabase  _ Dictionary new.
	catalog _ aCatalog .
	lastCartId _ 0.
	clock _ aClock .
	salesBook _ aSalesBook .
	merchantProccessor _ aMP .
	! !


!RestInteface methodsFor: 'rest-methods' stamp: 'LE 11/25/2018 22:09:50'!
addToCart: aCartID ISBN: anItem Quantity: aNumber 
	

	self assertValidCartID: aCartID.
	(cartDatabase at:aCartID) add:anItem times:aNumber .! !

!RestInteface methodsFor: 'rest-methods' stamp: 'LE 11/26/2018 19:34:34'!
checkOutCart: aCartID with: aCreditCard 
	|cashier|

	self assertCartIsNotEmpty:aCartID .
	self assertValidCartID: aCartID .
	self assertCardIsStillValid:aCartID.

	
	cashier _ Cashier toCheckout:(cartDatabase at:aCartID  ) charging:aCreditCard  throught:merchantProccessor  on: (self today)  registeringOn:salesBook.
	cashier checkOut 
! !

!RestInteface methodsFor: 'rest-methods' stamp: 'LE 11/23/2018 23:51:16'!
createCartFor: aClient with: aPassword 
	
	| pass cartId |
	pass := clientDatabase at: aClient ifAbsent: [^self error: self class unregisteredClient ].
	(aPassword = pass)ifFalse: [^self error: self class wrongClientPassword].
	cartId := lastCartId +1.
	lastCartId _ cartId.
	cartDatabase at: cartId put: self createValidCart .
	^ cartId.! !

!RestInteface methodsFor: 'rest-methods' stamp: 'LE 11/25/2018 11:28:10'!
listCart: aCartId 
	
	self assertValidCartID: aCartId .
	^ (cartDatabase at:aCartId) contents.! !

!RestInteface methodsFor: 'rest-methods' stamp: 'LE 11/26/2018 18:46:00'!
listPurchasesOf: aClientID with: aClientPassword 
	^ OrderedCollection new.! !


!RestInteface methodsFor: 'private methos' stamp: 'LE 11/23/2018 23:56:54'!
cartdatabase

	^ cartDatabase copy! !

!RestInteface methodsFor: 'private methos' stamp: 'LE 11/26/2018 21:00:14'!
createValidCart

	^ CartSession in:self.! !


!RestInteface methodsFor: 'assertions' stamp: 'LE 11/26/2018 19:34:15'!
assertCardIsStillValid:aCartID

	(cartDatabase at:aCartID ) assertIsStillValid .
! !

!RestInteface methodsFor: 'assertions' stamp: 'LE 11/25/2018 11:26:32'!
assertValidCartID:aCartID

	(cartDatabase includesKey: aCartID ) ifFalse: [^self error: self class invalidCartIDErrorMessage]! !


!RestInteface methodsFor: 'as yet unclassified' stamp: 'LE 11/26/2018 13:43:03'!
MerchantProccesor

	^  merchantProccessor copy! !

!RestInteface methodsFor: 'as yet unclassified' stamp: 'LE 11/26/2018 18:07:46'!
assertCartIsNotEmpty:aCartID

	(cartDatabase at:aCartID) contents isEmpty  ifTrue: [^self error: Cashier cartCanNotBeEmptyErrorMessage ]! !

!RestInteface methodsFor: 'as yet unclassified' stamp: 'LE 11/25/2018 19:07:47'!
catalog
	^catalog copy! !

!RestInteface methodsFor: 'as yet unclassified' stamp: 'LE 11/25/2018 19:08:13'!
now
 ^ clock now.! !

!RestInteface methodsFor: 'as yet unclassified' stamp: 'LE 11/26/2018 17:49:24'!
today
	^ clock today.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RestInteface class' category: #TusLibros!
RestInteface class
	instanceVariableNames: ''!

!RestInteface class methodsFor: 'initialization' stamp: 'LE 11/25/2018 23:37:44'!
withDatabase: aClientDatabase WithCatalog:aCatalog RunningOn: aClock savingSalesOn: aSalesBook WithMP: aMerchantProcessor  
 
	^self new initializeWith: aClientDatabase withItems:aCatalog RunningOn:aClock SavingSalesOn: OrderedCollection new MakingTransactionsWith: aMerchantProcessor ! !


!RestInteface class methodsFor: 'error messages' stamp: 'LE 11/24/2018 00:05:06'!
cartIDNotValid

	^ ' We not have this ID in the Cart Database'! !

!RestInteface class methodsFor: 'error messages' stamp: 'A.G. 11/22/2018 20:38:41'!
clientNotFound
	
	^'Client not found in database'.! !

!RestInteface class methodsFor: 'error messages' stamp: 'A.G. 11/22/2018 20:39:24'!
wrongClientPassword
	
	^'Wrong password'.! !


!RestInteface class methodsFor: 'as yet unclassified' stamp: 'LE 11/25/2018 11:26:56'!
invalidCartIDErrorMessage

	^' The Cart ID is invalid'.! !


!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'total clientID items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !



!Sale methodsFor: 'nil' stamp: 'LE 11/26/2018 20:32:27'!
initializeOf:aTotal for:aClient withItems:anItemList 

	total _ aTotal .
	clientID _ aClient.
	items _ anItemList .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'LE 11/26/2018 19:20:40'!
of: aTotal for: aClient withItems: anItemList  

	"should assert total is not negative or 0!!"
	^self new initializeOf:aTotal for:aClient withItems:anItemList .! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'A.G. 11/22/2018 20:15:55'!
registeredClient
	
	^'registeredClient'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'A.G. 11/22/2018 20:50:38'!
registeredClientInvalidPassword
	
	^'registeredClientInvalidPassword'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'A.G. 11/22/2018 20:15:45'!
registeredClientPassword
	
	^'registeredClientPassword'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'A.G. 11/22/2018 20:16:05'!
unregisteredClient
	
	^'unregisteredClient'! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'A.G. 11/22/2018 20:16:58'!
defaultUserDatabase
	
	^ Dictionary new
		at: self registeredClient put: self registeredClientPassword ;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !
