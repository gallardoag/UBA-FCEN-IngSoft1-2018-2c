!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'LE 12/2/2018 15:01:47'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'LE 12/2/2018 15:39:48'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'LE 12/2/2018 15:01:54'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidItemErrorMessage.
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
	instanceVariableNames: 'debitBehavior factory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'LE 12/2/2018 13:13:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: factory createCart 
			of: factory registeredClient charging: factory notExpiredCreditCard 
			throught: self
			on: factory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'LE 12/2/2018 13:13:50'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := factory createCart.
	cart add: 2 of: factory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		of: factory registeredClient charging: factory notExpiredCreditCard 
		throught: self
		on: factory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (factory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'LE 12/2/2018 13:13:50'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := factory createCart.
	cart add: factory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				of: factory registeredClient charging: factory expiredCreditCard 
				throught: self
				on: factory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'LE 12/2/2018 13:13:50'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := factory createCart.
	cart add: factory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		of: factory registeredClient charging: factory notExpiredCreditCard
		throught: self
		on: factory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'LE 12/2/2018 13:13:50'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := factory createCart.
	cart add: factory itemSellByTheStore.
	creditCard := factory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		of: factory registeredClient charging: creditCard
		throught: self
		on: factory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'LE 12/2/2018 13:13:50'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := factory createCart.
	cart add: factory itemSellByTheStore.
	creditCard := factory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		of: factory registeredClient charging: creditCard
		throught: self
		on: factory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'LE 12/2/2018 13:13:50'!
setUp 

	factory := StoreTestObjectsFactory new.
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


!RestInterfaceTest methodsFor: 'tests' stamp: 'LE 12/2/2018 13:23:49'!
test01_cannotCreateCartWithInvalidUser


	
	self should: [interface createCartFor:factory unregisteredClient with: factory registeredClientPassword ]
	raise: Error  
	withExceptionDo:[:anError | anError messageText  = RestInteface clientNotFound.
		] ! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'LE 12/2/2018 13:23:55'!
test02_cannotCreateCartWithInvalidPassword


	
	self should: [interface createCartFor:factory registeredClient with: factory registeredClientInvalidPassword ]
	raise: Error  
	withExceptionDo:[:anError | anError messageText  = RestInteface wrongClientPassword. 
		] 
	
	! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'LE 11/25/2018 19:13:44'!
test03_newCartIsEmpty

	|cartId|
	
	cartId := interface createCartFor:factory registeredClient with: factory registeredClientPassword.
	
	self assert: (interface listCart: cartId ) isEmpty .! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'LE 11/25/2018 19:14:12'!
test04_addingItemToCartAppearsOnCartList

	|cartId|
	cartId := interface createCartFor:factory registeredClient with: factory registeredClientPassword.
	interface addToCart:cartId ISBN: factory itemSellByTheStore Quantity:1.
	
	self assert: 1 equals:(interface listCart: cartId ) size.
	self assert: ((interface listCart:1) includes:(factory itemSellByTheStore)) .! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'LE 11/25/2018 19:14:19'!
test05_cannotAddAItemNotSold

	|  cartId |

	
	cartId := interface createCartFor:factory registeredClient with: factory registeredClientPassword.

	self should: [interface addToCart: cartId ISBN:factory itemNotSellByTheStore  Quantity:1 ] raise:Error  withExceptionDo: [
		:anError | anError = Cart invalidItemErrorMessage.
		self assert: (interface listCart: cartId ) isEmpty 
		 ]. ! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'LE 11/25/2018 19:14:25'!
test06_cannotAddItem0TimesToCart

	|  cartId |

	
	cartId := interface createCartFor:factory registeredClient with: factory registeredClientPassword.
	
	self should: [interface addToCart:cartId ISBN: factory itemSellByTheStore Quantity:0.] 
	raise:Error  
	withExceptionDo: [:anError | anError messageText = Cart invalidQuantityErrorMessage .
		self assert: (interface listCart: cartId) isEmpty. 
		]
! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'LE 12/2/2018 13:24:00'!
test07_cannotAddItemToANotValidCart

	|  cartId |

	
	cartId := 0.

	self should: [interface addToCart: cartId ISBN:factory itemNotSellByTheStore  Quantity:1 ] raise:Error  withExceptionDo: [
		:anError | anError = RestInteface invalidCartIDErrorMessage .
		 ]. ! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'LE 11/26/2018 21:00:14'!
test08bis_cannotCheckOutAfter30Minutes


	|cartId|
	cartId := interface createCartFor:factory registeredClient with: factory registeredClientPassword.
	interface addToCart: cartId ISBN:factory itemSellByTheStore  Quantity:1.
	
	self advanceTime: (30 * minute).

	self should: [interface checkOutCart: cartId with: factory notExpiredCreditCard ] raise:Error  withExceptionDo: [
		:anError | anError = CartSession expiredSessionErrorMessage .
		

		
		 ]. ! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'LE 12/2/2018 15:35:45'!
test08_cannotAddItemAfter30Minutes


	|cartId|
	cartId := interface createCartFor:factory registeredClient with: factory registeredClientPassword.
	self advanceTime: (30 * minute).

	self should: [interface addToCart: cartId ISBN:factory itemSellByTheStore  Quantity:1 ] raise:Error  withExceptionDo: [
		:anError | anError = CartSession expiredSessionErrorMessage .
		self rewindTime: (30 * minute ).
		self assert: (interface listCart: cartId ) isEmpty 
		
		 ]. ! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'LE 11/25/2018 23:45:28'!
test09_canAddItemBeforeTimeOut


	|cartId|
	cartId := interface createCartFor:factory registeredClient with: factory registeredClientPassword.
	self advanceTime: (25 * minute).
	interface addToCart: cartId ISBN:factory itemSellByTheStore  Quantity:1 .
	self deny: (interface listCart: cartId) isEmpty 
	
		

		
		 ! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'LE 11/26/2018 18:03:00'!
test10_cannotCheckoutWithAEmptyCart

	|cartId|
	cartId := interface createCartFor:factory registeredClient with: factory registeredClientPassword.
	self should: [ interface checkOutCart:cartId with: (factory notExpiredCreditCard)] 
	raise:Error  withExceptionDo: [:anError |
		self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage 
		] 
	

! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'LE 12/2/2018 12:01:25'!
test10_cannotCheckoutWithAExpiredCard

	|cartId|
	cartId := interface createCartFor:factory registeredClient with: factory registeredClientPassword.
	interface addToCart:cartId ISBN: factory itemSellByTheStore Quantity:1.

	self 
		should: [interface checkOutCart: cartId with:(factory expiredCreditCard )]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: (anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage ) 
	 ]



! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'LE 11/26/2018 18:44:56'!
test11_purchaseListIsEmptyWhenNoPurchasesHaveBeenDone

	self assert: (interface listPurchasesOf: factory registeredClient with: factory registeredClientPassword ) equals: (OrderedCollection new).! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'LE 12/2/2018 12:06:20'!
test12_aCorrectlyDonePurchaseIsListed

	|cartId debitedAmout debitedCreditCard |
	debitBehavior := [ :anAmount :aCreditCard | debitedAmout := anAmount. debitedCreditCard := aCreditCard ].
	cartId := interface createCartFor:factory registeredClient with: factory registeredClientPassword.
	interface addToCart:cartId ISBN: factory itemSellByTheStore Quantity:1.
	interface checkOutCart: cartId with: (factory notExpiredCreditCard ).
	self assert: (interface listPurchasesOf: factory registeredClient with: factory registeredClientPassword ) equals: (OrderedCollection with: factory  itemSellByTheStore ).! !


!RestInterfaceTest methodsFor: 'test support' stamp: 'LE 11/25/2018 20:37:04'!
advanceTime: aTimeSpan 
	clock advanceTime: aTimeSpan ! !

!RestInterfaceTest methodsFor: 'test support' stamp: 'LE 11/25/2018 23:35:44'!
createRestInterface

	^ RestInteface withDatabase: factory defaultUserDatabase WithCatalog: factory defaultCatalog RunningOn: clock savingSalesOn: OrderedCollection new WithMP: self.! !

!RestInterfaceTest methodsFor: 'test support' stamp: 'LE 11/25/2018 23:43:30'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !

!RestInterfaceTest methodsFor: 'test support' stamp: 'LE 12/2/2018 15:32:34'!
rewindTime: aTimeSpan 
	clock rewindTime:aTimeSpan ! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'assertions' stamp: 'LE 12/2/2018 15:01:37'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self class invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'LE 12/2/2018 15:39:33'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self class invalidQuantityErrorMessage ]! !


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
	instanceVariableNames: 'cart lastUsed system owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartSession methodsFor: 'cart protocol' stamp: 'LE 12/2/2018 11:58:34'!
add:anItem times:aNumber
	
	self assertIsStillValid .
	cart add:aNumber of:anItem.
	self updateTime.! !

!CartSession methodsFor: 'cart protocol' stamp: 'LE 12/2/2018 15:34:42'!
contents
	self assertIsStillValid.
	^ cart contents ! !

!CartSession methodsFor: 'cart protocol' stamp: 'LE 12/2/2018 15:34:20'!
isEmpty

	self assertIsStillValid.
	^ cart  isEmpty ! !

!CartSession methodsFor: 'cart protocol' stamp: 'LE 12/2/2018 15:34:48'!
total
	self assertIsStillValid.
	^ cart total.! !


!CartSession methodsFor: 'initialization' stamp: 'LE 12/2/2018 13:30:50'!
initializeFor:aClient in:aSystem

	system _ aSystem .
	cart _ Cart acceptingItemsOf: aSystem catalog..
	owner _ aClient .
	lastUsed _ aSystem now.
	! !


!CartSession methodsFor: 'asertions' stamp: 'LE 12/2/2018 11:57:24'!
assertIsStillValid

	|timeSinceLastUsed|
	timeSinceLastUsed _ lastUsed distanceTo: system now. .
	(timeSinceLastUsed >= self sessionDuration ) ifTrue: [^ self error: self class expiredSessionErrorMessage ].

	! !


!CartSession methodsFor: 'support' stamp: 'LE 12/2/2018 13:26:31'!
owner

	^ owner copy! !

!CartSession methodsFor: 'support' stamp: 'LE 11/25/2018 21:59:39'!
sessionDuration

	^ 30 * minute ! !

!CartSession methodsFor: 'support' stamp: 'LE 12/2/2018 11:58:52'!
updateTime

	lastUsed _ system now.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartSession class' category: #TusLibros!
CartSession class
	instanceVariableNames: ''!

!CartSession class methodsFor: 'as yet unclassified' stamp: 'LE 11/25/2018 19:32:32'!
expiredSessionErrorMessage

	^ ' The session is expired'! !

!CartSession class methodsFor: 'as yet unclassified' stamp: 'LE 12/2/2018 13:30:24'!
for: aClient in:aSystem

	^ self new initializeFor:aClient in:aSystem ! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'LE 12/2/2018 15:05:48'!
createSale

	^ TicketSale of: total for: owner withItems: cart contents 
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


!Cashier methodsFor: 'initialization' stamp: 'LE 12/2/2018 15:05:15'!
initializeToCheckout: aCart of: aClient charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook.
	owner _ aClient ! !

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


!Cashier class methodsFor: 'instance creation' stamp: 'LE 12/2/2018 15:05:32'!
toCheckout: aCart of: aClient charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart of: aClient charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #Clock category: #TusLibros!
Object subclass: #Clock
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Clock methodsFor: 'initialization' stamp: 'LE 12/2/2018 11:53:33'!
initialize

	^ self subclassResponsibility ! !


!Clock methodsFor: 'user interface' stamp: 'LE 12/2/2018 11:53:50'!
now

	^ self subclassResponsibility ! !

!Clock methodsFor: 'user interface' stamp: 'LE 12/2/2018 11:53:43'!
today

	^ self subclassResponsibility ! !


!classDefinition: #ManualClock category: #TusLibros!
Clock subclass: #ManualClock
	instanceVariableNames: 'now today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ManualClock methodsFor: 'initialization' stamp: 'LE 11/26/2018 18:15:53'!
initialize

	now _ GregorianDateTime now.
	today _ Date today .! !


!ManualClock methodsFor: 'user interface' stamp: 'LE 11/25/2018 19:08:40'!
now
	
	^now! !

!ManualClock methodsFor: 'user interface' stamp: 'LE 11/26/2018 18:28:01'!
today

	^ today .! !


!ManualClock methodsFor: 'time manipulation' stamp: 'LE 11/25/2018 20:34:21'!
advanceTime:aTimeSpan

	now _ now next:aTimeSpan .! !

!ManualClock methodsFor: 'time manipulation' stamp: 'LE 11/25/2018 20:34:44'!
rewindTime:aTimeSpan

	now _ now next: aTimeSpan negated ! !


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


!classDefinition: #RestInteface category: #TusLibros!
Object subclass: #RestInteface
	instanceVariableNames: 'clientDatabase cartDatabase lastCartId catalog clock salesBook merchantProccessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInteface methodsFor: 'initialization' stamp: 'LE 12/2/2018 13:22:43'!
initializeWith: aClientDatabase withItems:aCatalog RunningOn: aClock SavingSalesOn: aSalesBook MakingTransactionsWith: aMerchantProcessor  .
	
	clientDatabase _ aClientDatabase.
	cartDatabase  _ Dictionary new.
	catalog _ aCatalog .
	lastCartId _ 0.
	clock _ aClock .
	salesBook _ aSalesBook .
	merchantProccessor _ aMerchantProcessor .
	! !


!RestInteface methodsFor: 'rest-methods' stamp: 'LE 11/25/2018 22:09:50'!
addToCart: aCartID ISBN: anItem Quantity: aNumber 
	

	self assertValidCartID: aCartID.
	(cartDatabase at:aCartID) add:anItem times:aNumber .! !

!RestInteface methodsFor: 'rest-methods' stamp: 'LE 12/2/2018 15:07:13'!
checkOutCart: aCartID with: aCreditCard 
	|cashier cartSession|

	self assertCartIsNotEmpty:aCartID .
	self assertValidCartID: aCartID .
	self assertCardIsStillValid:aCartID.

	cartSession _ cartDatabase at:aCartID .
	
	cashier _ Cashier toCheckout:cartSession of: cartSession owner charging:aCreditCard  throught:merchantProccessor  on: (self today)  registeringOn:salesBook.
	cashier checkOut 
! !

!RestInteface methodsFor: 'rest-methods' stamp: 'LE 12/2/2018 15:27:30'!
createCartFor: aClient with: aPassword 
	
	|cartId|
	self assertThisUser: aClient canLogInWithThisPassword:aPassword .
	cartId := lastCartId +1.
	lastCartId _ cartId.
	cartDatabase at: cartId put: (self createValidCartFor:aClient) .
	^ cartId.! !

!RestInteface methodsFor: 'rest-methods' stamp: 'LE 11/25/2018 11:28:10'!
listCart: aCartId 
	
	self assertValidCartID: aCartId .
	^ (cartDatabase at:aCartId) contents.! !

!RestInteface methodsFor: 'rest-methods' stamp: 'LE 12/2/2018 15:27:30'!
listPurchasesOf: aClientID with: aClientPassword 

	|clientTickets|

	self assertThisUser: aClientID canLogInWithThisPassword: aClientPassword .
	clientTickets _ salesBook select:[:aSale | aSale buyer = aClientID ].
	^clientTickets inject: OrderedCollection new into:[:result :current | result addAll: current items . result ] ! !


!RestInteface methodsFor: 'private methos' stamp: 'LE 11/25/2018 19:07:47'!
catalog
	^catalog copy! !

!RestInteface methodsFor: 'private methos' stamp: 'LE 12/2/2018 13:29:04'!
createValidCartFor:aClient

	^ CartSession for: aClient in:self.! !


!RestInteface methodsFor: 'assertions' stamp: 'LE 11/26/2018 19:34:15'!
assertCardIsStillValid:aCartID

	(cartDatabase at:aCartID ) assertIsStillValid .
! !

!RestInteface methodsFor: 'assertions' stamp: 'LE 11/26/2018 18:07:46'!
assertCartIsNotEmpty:aCartID

	(cartDatabase at:aCartID) contents isEmpty  ifTrue: [^self error: Cashier cartCanNotBeEmptyErrorMessage ]! !

!RestInteface methodsFor: 'assertions' stamp: 'LE 12/2/2018 15:27:30'!
assertThisUser:aClient canLogInWithThisPassword:aPassword

	|pass|
	pass := clientDatabase at: aClient ifAbsent: [^self error: self class unregisteredClient ].
	(aPassword = pass)ifFalse: [^self error: self class wrongClientPassword].! !

!RestInteface methodsFor: 'assertions' stamp: 'LE 11/25/2018 11:26:32'!
assertValidCartID:aCartID

	(cartDatabase includesKey: aCartID ) ifFalse: [^self error: self class invalidCartIDErrorMessage]! !


!RestInteface methodsFor: 'time' stamp: 'LE 11/25/2018 19:08:13'!
now
 ^ clock now.! !

!RestInteface methodsFor: 'time' stamp: 'LE 11/26/2018 17:49:24'!
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

!RestInteface class methodsFor: 'error messages' stamp: 'LE 11/25/2018 11:26:56'!
invalidCartIDErrorMessage

	^' The Cart ID is invalid'.! !

!RestInteface class methodsFor: 'error messages' stamp: 'A.G. 11/22/2018 20:39:24'!
wrongClientPassword
	
	^'Wrong password'.! !


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


!classDefinition: #TicketSale category: #TusLibros!
Object subclass: #TicketSale
	instanceVariableNames: 'total buyer items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TicketSale methodsFor: 'getters' stamp: 'LE 12/2/2018 15:11:35'!
buyer

	^ buyer copy! !

!TicketSale methodsFor: 'getters' stamp: 'LE 12/2/2018 15:11:41'!
items

	^ items copy .! !

!TicketSale methodsFor: 'getters' stamp: 'LE 12/2/2018 15:11:28'!
total
	
	^ total copy! !


!TicketSale methodsFor: 'initialization' stamp: 'LE 12/2/2018 15:11:15'!
initializeOf:aTotal for:aClient withItems:anItemList 

	total _ aTotal .
	buyer _ aClient.
	items _ anItemList .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TicketSale class' category: #TusLibros!
TicketSale class
	instanceVariableNames: ''!

!TicketSale class methodsFor: 'instance creation' stamp: 'LE 11/26/2018 19:20:40'!
of: aTotal for: aClient withItems: anItemList  

	"should assert total is not negative or 0!!"
	^self new initializeOf:aTotal for:aClient withItems:anItemList .! !
