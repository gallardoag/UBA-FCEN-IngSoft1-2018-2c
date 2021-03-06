!classDefinition: #AccountTransaction category: #'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

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


!classDefinition: #Withdraw category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


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

!Portfolio methodsFor: 'balance' stamp: 'A.G. 10/11/2018 21:46:43'!
balance

	^ managedAccounts inject: 0 into: [ :result :current | result + (current balance)] ! !


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


!ReceptiveAccount methodsFor: 'balance' stamp: 'A.G. 10/11/2018 21:25:41'!
balance

	^ transactions inject: 0 into: [ :result :current | result + (current balance)] ! !


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
