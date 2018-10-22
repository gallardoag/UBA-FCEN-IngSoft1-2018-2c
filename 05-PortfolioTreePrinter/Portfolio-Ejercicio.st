!classDefinition: #AccountTransaction category: #'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'evaluating' stamp: 'HAW 10/18/2018 18:48:48'!
affectBalance: currentBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'value' stamp: 'A.G. 10/11/2018 21:22:03'!
balance 

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #Deposit category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HAW 10/18/2018 18:49:00'!
affectBalance: currentBalance

	^currentBalance + value! !

!Deposit methodsFor: 'value' stamp: 'A.G. 10/11/2018 21:21:53'!
balance

	^ value! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 19:41'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #TransferLeg category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!TransferLeg methodsFor: 'as yet unclassified' stamp: 'LB 10/18/2018 21:24:27'!
balance

	^ self subclassResponsibility ! !

!TransferLeg methodsFor: 'as yet unclassified' stamp: 'LB 10/18/2018 21:24:35'!
value

	^ self subclassResponsibility ! !


!classDefinition: #TransferFrom category: #'Portfolio-Ejercicio'!
TransferLeg subclass: #TransferFrom
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!TransferFrom methodsFor: 'as yet unclassified' stamp: 'LB 10/18/2018 20:27:04'!
balance

	^ self transfer value! !

!TransferFrom methodsFor: 'as yet unclassified' stamp: 'LB 10/18/2018 20:32:53'!
initializeWith:aTransfer

	transfer _ aTransfer! !

!TransferFrom methodsFor: 'as yet unclassified' stamp: 'LB 10/18/2018 20:03:31'!
transfer

	^ transfer ! !


!TransferFrom methodsFor: '*Chalten-Time Extensions' stamp: 'LB 10/18/2018 20:27:57'!
value

	^self transfer value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferFrom class' category: #'Portfolio-Ejercicio'!
TransferFrom class
	instanceVariableNames: ''!

!TransferFrom class methodsFor: 'as yet unclassified' stamp: 'LB 10/18/2018 20:31:50'!
with:aTransfer

	^ self new initializeWith: aTransfer ! !


!classDefinition: #TransferTo category: #'Portfolio-Ejercicio'!
TransferLeg subclass: #TransferTo
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!TransferTo methodsFor: 'as yet unclassified' stamp: 'LB 10/18/2018 20:27:33'!
balance

	^ (self transfer value)  negated ! !

!TransferTo methodsFor: 'as yet unclassified' stamp: 'LB 10/18/2018 20:32:35'!
initializeWith:aTransfer

	transfer _ aTransfer! !

!TransferTo methodsFor: 'as yet unclassified' stamp: 'LB 10/18/2018 20:03:27'!
transfer

	^ transfer ! !

!TransferTo methodsFor: 'as yet unclassified' stamp: 'LB 10/18/2018 20:27:46'!
value

	^ self transfer value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferTo class' category: #'Portfolio-Ejercicio'!
TransferTo class
	instanceVariableNames: ''!

!TransferTo class methodsFor: 'as yet unclassified' stamp: 'LB 10/18/2018 20:32:14'!
with:aTransfer

	^ self new initializeWith: aTransfer! !


!classDefinition: #Withdraw category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HAW 10/18/2018 18:49:08'!
affectBalance: currentBalance

	^currentBalance - value! !

!Withdraw methodsFor: 'value' stamp: 'A.G. 10/11/2018 21:22:17'!
balance

	^ (value negated)! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/14/2011 05:32'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #SummarizingAccount category: #'Portfolio-Ejercicio'!
Object subclass: #SummarizingAccount
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!SummarizingAccount methodsFor: 'testing' stamp: 'HAW 10/11/2018 16:53:28'!
doesManage: anAccount

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'testing' stamp: 'HAW 10/11/2018 16:53:54'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'testing' stamp: 'A.G. 10/18/2018 11:34:30'!
managedAccounts

	self subclassResponsibility ! !


!SummarizingAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:35'!
transactions

	self subclassResponsibility ! !


!SummarizingAccount methodsFor: 'balance' stamp: 'HernanWilkinson 7/13/2011 18:34'!
balance

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
SummarizingAccount subclass: #Portfolio
	instanceVariableNames: 'managedAccounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:31:24'!
anyManagedAccountManages: anAccount 

	^accounts anySatisfy: [ :managedAccount | (managedAccount doesManage: anAccount) or: [ anAccount doesManage: managedAccount ] ] ! !

!Portfolio methodsFor: 'testing' stamp: 'A.G. 10/17/2018 17:47:11'!
doesManage: anAccount

	^  (managedAccounts includes: anAccount) or:  [managedAccounts anySatisfy: [:aManagedAccount | aManagedAccount doesManage: anAccount ]]
! !

!Portfolio methodsFor: 'testing' stamp: 'A.G. 10/17/2018 17:47:21'!
hasRegistered: aTransaction

	^ managedAccounts anySatisfy: [:aManagedAccount | aManagedAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'A.G. 10/18/2018 13:09:22'!
managedAccounts

	^ managedAccounts inject: OrderedCollection new into:[:result :current | result addAll: current managedAccounts.result]! !


!Portfolio methodsFor: 'transactions' stamp: 'L 10/14/2018 19:55:37'!
transactions 

	^ managedAccounts inject: OrderedCollection new into:[:result :current | result addAll: current transactions.result ] ! !

!Portfolio methodsFor: 'transactions' stamp: 'LB 10/18/2018 15:40:19'!
transactionsOf: anAccount 

	^managedAccounts detect:[:anManagedAccount | (anManagedAccount doesManage: anAccount) or:[managedAccounts includes: anAccount ] ]  
	ifFound:[:foundAccount | foundAccount transactions ]  
	ifNone:[self error: self class accountNotManagedMessageDescription ] ! !


!Portfolio methodsFor: 'initialization' stamp: 'A.G. 10/17/2018 17:20:54'!
initializeWithAll: aManagedAccountsList

	managedAccounts := OrderedCollection newFrom: aManagedAccountsList ! !


!Portfolio methodsFor: 'balance' stamp: 'A.G. 10/11/2018 21:46:43'!
balance

	^ managedAccounts inject: 0 into: [ :result :current | result + (current balance)] ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'A.G. 10/18/2018 11:51:03'!
with: leftAccount with: rightAccount

	| accountList |
	accountList := OrderedCollection with: leftAccount with: rightAccount.
	^self withAll: accountList! !

!Portfolio class methodsFor: 'instance creation' stamp: 'A.G. 10/18/2018 13:00:53'!
withAll: aCollectionOfAccounts

	
	| accounts |
	accounts := aCollectionOfAccounts  inject: OrderedCollection new into:[:result :current | result addAll: current managedAccounts. result].
	accounts detect: [:anAccount | (accounts occurrencesOf: anAccount) > 1]
	ifNone: [^self new initializeWithAll: aCollectionOfAccounts].
	^self error: self accountAlreadyManagedErrorMessage! !


!Portfolio class methodsFor: 'assertions' stamp: 'HAW 10/18/2018 16:31:24'!
check: sourceAccount doesNotManagaAnyOf: aCollectionOfAccounts

	^ aCollectionOfAccounts do: [ :targetAccount | 
			(sourceAccount = targetAccount) not ifTrue: [ 
				(sourceAccount doesManage: targetAccount) ifTrue: [ self error: self accountAlreadyManagedErrorMessage ] ] ]! !

!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:21'!
checkAccountsAreUnique: aCollectionOfAccounts

	aCollectionOfAccounts asSet size = aCollectionOfAccounts size
		ifFalse: [ self error: self accountAlreadyManagedErrorMessage ]! !

!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:21'!
checkCreationPreconditions: aCollectionOfAccounts

	self checkAccountsAreUnique: aCollectionOfAccounts.
	self checkNoCircularReferencesIn: aCollectionOfAccounts! !

!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:22'!
checkNoCircularReferencesIn: aCollectionOfAccounts

	aCollectionOfAccounts do: [ :sourceAccount | self check: sourceAccount doesNotManagaAnyOf: aCollectionOfAccounts ]! !


!Portfolio class methodsFor: 'error messages' stamp: 'HAW 5/8/2018 16:08:43'!
accountAlreadyManagedErrorMessage

	^ 'Account already managed'! !

!Portfolio class methodsFor: 'error messages' stamp: 'HAW 5/8/2018 16:08:53'!
accountNotManagedMessageDescription
	
	^ 'Account not managed'! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
SummarizingAccount subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 10/11/2018 16:53:28'!
doesManage: anAccount

	^ self = anAccount 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 10/11/2018 16:53:54'!
hasRegistered: aTtransaction

	^ transactions includes: aTtransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'A.G. 10/18/2018 12:30:05'!
managedAccounts

	^ OrderedCollection with: self
! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'A.G. 10/11/2018 21:25:41'!
balance

	^ transactions inject: 0 into: [ :result :current | result + (current balance)] ! !


!ReceptiveAccount methodsFor: '*Aconcagua-Extensions' stamp: 'LB 10/18/2018 19:59:49'!
transfer: anAmount to: destination

	|depositLeg withdrawLeg transfer|

	transfer _ Transfer with:anAmount .
	withdrawLeg := transfer withdrawLeg .
	depositLeg := transfer depositLeg ..
	 self register: withdrawLeg .
	destination register: depositLeg .
	
	^ transfer ! !


!classDefinition: #SummaryPrinter category: #'Portfolio-Ejercicio'!
Object subclass: #SummaryPrinter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!SummaryPrinter methodsFor: 'printing' stamp: 'A.G. 10/22/2018 09:20:27'!
print:aTransaction

	(aTransaction isKindOf: Deposit ) ifTrue: [^ 'Deposito por ' , (aTransaction value) asString ].
	(aTransaction isKindOf: TransferLeg ) ifTrue: [^ 'Transferencia por ' , (aTransaction balance) asString ].
	(aTransaction isKindOf: Withdraw ) ifTrue: [^ 'Extraccion por ' , (aTransaction value) asString ].! !

!SummaryPrinter methodsFor: 'printing' stamp: 'A.G. 10/22/2018 09:24:29'!
printDeposit:aDepositTransaction

	^ 'Deposito por ' , (aDepositTransaction value) asString! !

!SummaryPrinter methodsFor: 'printing' stamp: 'A.G. 10/22/2018 09:29:36'!
printTransfer:aTransferTransaction

	^ 'Transferencia por ' , (aTransferTransaction balance) asString! !

!SummaryPrinter methodsFor: 'printing' stamp: 'A.G. 10/22/2018 09:25:34'!
printWithdraw:aWithdrawTransaction

	^ 'Extraccion por ' , (aWithdrawTransaction value) asString! !

!SummaryPrinter methodsFor: 'printing' stamp: 'A.G. 10/22/2018 09:20:41'!
summaryOf:anAccount

	|transaction|
	
	transaction _ anAccount transactions .

	^transaction inject: OrderedCollection new into:[:result :current | result add:(self print:current).result ] ! !


!classDefinition: #Transfer category: #'Portfolio-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'depositLeg withdrawLeg value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Transfer methodsFor: 'as yet unclassified' stamp: 'LB 10/18/2018 19:32:46'!
depositLeg

	^ depositLeg ! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'LB 10/18/2018 20:31:09'!
initializeWith:aValue
	
	value _ aValue.
	depositLeg _ TransferFrom with: self.
	withdrawLeg _ TransferTo with: self.! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'LB 10/18/2018 20:28:09'!
value

	^ value.! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'LB 10/18/2018 19:32:39'!
withdrawLeg

	^ withdrawLeg .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: #'Portfolio-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'as yet unclassified' stamp: 'LB 10/18/2018 20:29:28'!
with:aValue 

	^ self new initializeWith: aValue.! !
