!classDefinition: #CartTest category: #'TusLibros-Iteracion2'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion2'!

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


!classDefinition: #CashierTest category: #'TusLibros-Iteracion2'!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion2'!

!CashierTest methodsFor: 'Testing' stamp: 'Luis 11/22/2018 15:57:38'!
test01_cannotCheckOutAnEmptyCart
	
	| card cart cashier |
	cart := Cart with: self defaultCatalog.
	cashier := self createValidCashier.
	card := self createValidCard.
	
	
	self should: [cashier checkOut: cart with: card] 
	raise: Error 
	withExceptionDo: [:anError | anError messageText = Cashier emptyCartCheckOutMessage].
	self assert: (cashier totalSold) equals: 0.! !

!CashierTest methodsFor: 'Testing' stamp: 'Luis 11/22/2018 16:09:17'!
test03_aCartWithMultipleItemsCanCheckOut
	
	| card cart cashier total priceList |
	cart := Cart with: self defaultCatalog.
	priceList := self defaultPriceList.
	cashier := self createValidCashier.
	card := self createValidCard.
	
	cart addItem: 'ISBN001' times: 2.
	cart addItem: 'ISBN002' times: 1.
	
	total := (priceList at: 'ISBN001') * 2 + (priceList at: 'ISBN002').
	cashier checkOut: cart with: card.
	self assert: cashier totalSold equals: total.! !

!CashierTest methodsFor: 'Testing' stamp: 'Luis 11/22/2018 15:16:42'!
test04_cannotCheckoutWithanExpiredCreditCard
	
	| card cart cashier |
	cart := Cart with: self defaultCatalog.
	cashier := self createValidCashier.
	card := self createExpiredCard.
	
	cart addItem: 'ISBN001' times: 2.
	cart addItem: 'ISBN002' times: 1.
	
	
	
	self should: [cashier checkOut: cart with: card] raise:Error  withExceptionDo: [:anError | anError messageText = Cashier expiredCardErrorMessage.
		self assert: 0 equals:cashier totalSold 
		]! !

!CashierTest methodsFor: 'Testing' stamp: 'Luis 11/22/2018 15:58:05'!
test05_whenMerchantProcesorChargesACustomerCashierRecordsTheSale
	
	| card cart cashier  total priceList |
	priceList := self defaultPriceList .
	cart := Cart with: self defaultCatalog.
	cashier := self createValidCashier.
	card := self createValidCard.
	
	cart addItem: 'ISBN001' times: 2.
	cart addItem: 'ISBN002' times: 1.
	
	cashier checkOut: cart with: card.
	
	total := (priceList at: 'ISBN001') * 2 + (priceList at: 'ISBN002').
	
	self assert: total equals: cashier totalSold.! !

!CashierTest methodsFor: 'Testing' stamp: 'Luis 11/22/2018 16:21:06'!
test06_whenMerchantProcesorCannotChargeTheCustomerTheSaleIsNotDone
	
	| card cart cashier  |

	cart := Cart with: self defaultCatalog.
	cashier := self createValidCashierWith: (MerchantProcessorMock with:['400 1|Credit card has not enough funds']).
	card:= self createValidCard.
	
	cart addItem: 'ISBN001' times: 2.
	cart addItem: 'ISBN002' times: 1.
	
     self should:[cashier checkOut: cart with: card.]  raise:Error   withExceptionDo: [:anError | anError messageText = 'Credit card has not enough funds'.
		self assert:  0 equals:cashier totalSold .
		]
	! !


!CashierTest methodsFor: 'Testing-Support' stamp: 'A.G. 11/15/2018 20:58:47'!
createExpiredCard
	
	| from to |
	from := (GregorianMonthOfYear current) previous: 2*year.
	to := (GregorianMonthOfYear current) previous: 1*year.
	
	^Card name: 'Cosme Fulanito' number: 0001 from: from thru: to ccv: 999.! !

!CashierTest methodsFor: 'Testing-Support' stamp: 'A.G. 11/15/2018 20:58:33'!
createValidCard
	
	| from to |
	from := (GregorianMonthOfYear current) previous: 1*year.
	to := (GregorianMonthOfYear current) next: 1*year.
	
	^Card name: 'Cosme Fulanito' number: 0001 from: from thru: to ccv: 999.! !

!CashierTest methodsFor: 'Testing-Support' stamp: 'Luis 11/22/2018 15:59:33'!
createValidCashier

	| merchantProcessor |
	merchantProcessor := MerchantProcessorMock with: ['200 0|OK'].
	^self createValidCashierWith: merchantProcessor .! !

!CashierTest methodsFor: 'Testing-Support' stamp: 'Luis 11/22/2018 15:53:12'!
createValidCashierWith: aMerchantProcessor

	| priceList |
	priceList := self defaultPriceList.
	^Cashier withPriceList: priceList and: aMerchantProcessor .! !

!CashierTest methodsFor: 'Testing-Support' stamp: 'A.G. 11/15/2018 18:46:58'!
defaultCatalog

	^OrderedCollection with: 'ISBN001' with: 'ISBN002' with: 'ISBN003' with: 'ISBN004' with: 'ISBN005' with: 'ISBN006'.! !

!CashierTest methodsFor: 'Testing-Support' stamp: 'A.G. 11/15/2018 19:07:08'!
defaultPriceList
	|dict|
	
	dict := Dictionary new.
	dict at: 'ISBN001' put: 10*peso.
	dict at: 'ISBN002' put: 12*peso.
	dict at: 'ISBN003' put: 13*peso.
	dict at: 'ISBN004' put: 14*peso.
	dict at: 'ISBN005' put: 20*peso.
	dict at: 'ISBN006' put: 30*peso.
	
	^dict! !


!classDefinition: #Card category: #'TusLibros-Iteracion2'!
Object subclass: #Card
	instanceVariableNames: 'holder number from thru ccv'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion2'!

!Card methodsFor: 'initialization' stamp: 'A.G. 11/15/2018 20:03:43'!
withHolder: holderName withNumber: cardNumber from:fromDate thru: thruDate ccv: ccvNumber

	holder _ holderName.
	number _ cardNumber.
	from _ fromDate.
	thru _ thruDate.
	ccv _ ccvNumber.! !


!Card methodsFor: 'evaluating' stamp: 'Luis 11/22/2018 15:34:55'!
holder

	^holder! !

!Card methodsFor: 'evaluating' stamp: 'A.G. 11/15/2018 21:01:19'!
isExpired

	^thru < GregorianMonthOfYear current.! !

!Card methodsFor: 'evaluating' stamp: 'Luis 11/22/2018 15:35:06'!
number

	^number ! !

!Card methodsFor: 'evaluating' stamp: 'Luis 11/22/2018 15:35:18'!
thru

	^thru ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Card class' category: #'TusLibros-Iteracion2'!
Card class
	instanceVariableNames: ''!

!Card class methodsFor: 'initialization' stamp: 'A.G. 11/15/2018 21:04:45'!
emptyNameError

	^'Card name cannot be empty'.! !

!Card class methodsFor: 'initialization' stamp: 'A.G. 11/15/2018 21:05:10'!
invalidDateIntervalError

	^'From date and Thru date interval is invalid'! !

!Card class methodsFor: 'initialization' stamp: 'A.G. 11/15/2018 21:04:04'!
name: holderName number: cardNumber from: fromDate thru: thruDate ccv: ccvNumber

	(holderName = '') ifTrue: [self error: self class emptyNameError].
	(fromDate > thruDate ) ifTrue: [self error: self class invalidDateIntervalError].
	
	^self new withHolder: holderName withNumber: cardNumber from:fromDate thru: thruDate ccv: ccvNumber.! !


!classDefinition: #Cart category: #'TusLibros-Iteracion2'!
Object subclass: #Cart
	instanceVariableNames: 'items catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion2'!

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


!Cart methodsFor: 'evaluating' stamp: 'A.G. 11/15/2018 19:37:29'!
sumarizeWIth: aPriceList 
	
	^items inject: 0*peso into: [:total :actual | total + (aPriceList at: actual)].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'TusLibros-Iteracion2'!
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


!classDefinition: #Cashier category: #'TusLibros-Iteracion2'!
Object subclass: #Cashier
	instanceVariableNames: 'priceList totalSold salesBook merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion2'!

!Cashier methodsFor: 'check-out' stamp: 'Luis 11/22/2018 15:47:07'!
checkOut: aCart with: aCard 
	|value response |
	(aCart isEmpty) ifTrue: [self error: self class emptyCartCheckOutMessage].
	(aCard isExpired) ifTrue: [self error: self class expiredCardErrorMessage].
	value _ aCart sumarizeWIth: priceList.
	
	response _ merchantProcessor charge: value to: aCard holder with: aCard number withExpiration: aCard thru.
	
	self verify: response.
	
	totalSold _ totalSold + value.
	
	^value.! !

!Cashier methodsFor: 'check-out' stamp: 'Luis 11/22/2018 16:20:22'!
verify: aResponseString 

	(aResponseString beginsWith: '400' ) ifTrue: [^self error: (aResponseString withoutPrefix: '400 1|')]! !


!Cashier methodsFor: 'initialization' stamp: 'Luis 11/22/2018 15:54:50'!
initializeWithPriceList:aPriceList  and: aMerchantProcessor 
	priceList _ aPriceList .
	totalSold _ 0.
	merchantProcessor _ aMerchantProcessor ! !


!Cashier methodsFor: 'evaluating' stamp: 'A.G. 11/15/2018 20:22:04'!
totalSold

	^totalSold! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #'TusLibros-Iteracion2'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'Error-Messages' stamp: 'A.G. 11/15/2018 18:40:16'!
emptyCartCheckOutMessage
	
	^'Cart cannot be empty when checking out'.! !

!Cashier class methodsFor: 'Error-Messages' stamp: 'A.G. 11/15/2018 20:20:31'!
expiredCardErrorMessage

	^'Credit card is expired'.! !


!Cashier class methodsFor: 'initialization' stamp: 'Luis 11/22/2018 15:54:18'!
withPriceList: aPriceList and: aMerchantProcessor .

	^self new initializeWithPriceList:aPriceList  and: aMerchantProcessor ! !

!Cashier class methodsFor: 'initialization' stamp: 'LE 11/21/2018 23:31:31'!
withPriceList:aPriceList registeringOn: aSalesBook 

	^self new initializeWithPriceList:aPriceList  on: aSalesBook ! !


!classDefinition: #MerchantProcessorMock category: #'TusLibros-Iteracion2'!
Object subclass: #MerchantProcessorMock
	instanceVariableNames: 'answer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion2'!

!MerchantProcessorMock methodsFor: 'initialization' stamp: 'Luis 11/22/2018 15:28:05'!
initializeWith:anAnswerBlock

	answer _ anAnswerBlock ! !


!MerchantProcessorMock methodsFor: 'accessing' stamp: 'Luis 11/22/2018 15:31:02'!
charge: anAmount to: aCreditCardOwner with: aCreditCardNumber withExpiration: anExpirationDate

	^answer value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorMock class' category: #'TusLibros-Iteracion2'!
MerchantProcessorMock class
	instanceVariableNames: ''!

!MerchantProcessorMock class methodsFor: 'initialization' stamp: 'Luis 11/22/2018 15:27:20'!
with:anAnswerBlock

	^ self new initializeWith: anAnswerBlock .

	! !
