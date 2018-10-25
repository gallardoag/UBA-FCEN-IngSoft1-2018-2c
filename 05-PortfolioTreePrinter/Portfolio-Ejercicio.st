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


!classDefinition: #CertificateOfDeposit category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #CertificateOfDeposit
	instanceVariableNames: 'value duration rate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!CertificateOfDeposit methodsFor: 'as yet unclassified' stamp: 'das 10/22/2018 20:08:45'!
balance

	^ value negated ! !

!CertificateOfDeposit methodsFor: 'as yet unclassified' stamp: 'das 10/22/2018 20:21:00'!
duration

	^ duration ! !

!CertificateOfDeposit methodsFor: 'as yet unclassified' stamp: 'das 10/22/2018 19:48:05'!
initializeWith:anAmount and:aDuration and:aRate 

	value _ anAmount .
	duration _ aDuration .
	rate _ aRate .! !

!CertificateOfDeposit methodsFor: 'as yet unclassified' stamp: 'das 10/22/2018 20:20:49'!
interestRate

	^ rate! !

!CertificateOfDeposit methodsFor: 'as yet unclassified' stamp: 'das 10/22/2018 20:01:08'!
value

	^ value ! !


!CertificateOfDeposit methodsFor: '*Chalten-Time Extensions' stamp: 'das 10/22/2018 20:05:32'!
accept: aVisitor 
	aVisitor visitCertificateOfDeposit: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CertificateOfDeposit class' category: #'Portfolio-Ejercicio'!
CertificateOfDeposit class
	instanceVariableNames: ''!

!CertificateOfDeposit class methodsFor: 'as yet unclassified' stamp: 'das 10/22/2018 19:47:19'!
of:anAmount during:aDuration at:aRate

	^ self new initializeWith:anAmount and:aDuration and:aRate ! !


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


!Deposit methodsFor: 'as yet unclassified' stamp: 'das 10/22/2018 19:16:00'!
accept: aVisitor

	aVisitor visitDeposit: self! !

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

!TransferFrom methodsFor: 'as yet unclassified' stamp: 'das 10/22/2018 19:16:53'!
accept: aVisitor

	aVisitor visitTransferFrom: self! !

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

!TransferTo methodsFor: 'as yet unclassified' stamp: 'das 10/22/2018 19:17:21'!
accept: aVisitor

	aVisitor visitTransferTo: self! !

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

!Withdraw methodsFor: 'initialization' stamp: 'das 10/22/2018 19:17:36'!
accept: aVisitor

	aVisitor visitWithdraw: self! !

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


!classDefinition: #SumarizingAccountVisitor category: #'Portfolio-Ejercicio'!
Object subclass: #SumarizingAccountVisitor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!


!classDefinition: #InvestmentEarningsVisitor category: #'Portfolio-Ejercicio'!
SumarizingAccountVisitor subclass: #InvestmentEarningsVisitor
	instanceVariableNames: 'account acum'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!InvestmentEarningsVisitor methodsFor: 'as yet unclassified' stamp: 'das 10/22/2018 20:18:13'!
initializeWith:anAccount

	account _ anAccount ! !

!InvestmentEarningsVisitor methodsFor: 'as yet unclassified' stamp: 'A.G. 10/25/2018 16:30:43'!
value

	acum  _ 0.
	
	account transactionsDo:[:aTransaction | aTransaction accept:self ].
	
	^ acum ! !

!InvestmentEarningsVisitor methodsFor: 'as yet unclassified' stamp: 'das 10/22/2018 20:26:41'!
visitCertificateOfDeposit:aCertificateOfDeposit

	|earnings|
	
	earnings _ (aCertificateOfDeposit value * (aCertificateOfDeposit interestRate / 360) ) * aCertificateOfDeposit duration .

	acum _ acum + earnings ! !

!InvestmentEarningsVisitor methodsFor: 'as yet unclassified' stamp: 'A.G. 10/25/2018 16:30:55'!
visitDeposit:aDeposit

	^0! !

!InvestmentEarningsVisitor methodsFor: 'as yet unclassified' stamp: 'A.G. 10/25/2018 16:31:01'!
visitTransferFrom:aTransferFrom

	^0! !

!InvestmentEarningsVisitor methodsFor: 'as yet unclassified' stamp: 'A.G. 10/25/2018 16:31:08'!
visitTransferTo:aTransferTo

	^0! !

!InvestmentEarningsVisitor methodsFor: 'as yet unclassified' stamp: 'A.G. 10/25/2018 16:31:14'!
visitWithdraw:aWithdraw

	^0! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InvestmentEarningsVisitor class' category: #'Portfolio-Ejercicio'!
InvestmentEarningsVisitor class
	instanceVariableNames: ''!

!InvestmentEarningsVisitor class methodsFor: 'as yet unclassified' stamp: 'das 10/22/2018 20:16:50'!
with:anAccount

	^ self new initializeWith: anAccount ! !


!classDefinition: #InvestmentNetVisitor category: #'Portfolio-Ejercicio'!
SumarizingAccountVisitor subclass: #InvestmentNetVisitor
	instanceVariableNames: 'account acum'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!InvestmentNetVisitor methodsFor: 'as yet unclassified' stamp: 'das 10/22/2018 19:56:52'!
initializeWith:anAccount

	account  _ anAccount .! !

!InvestmentNetVisitor methodsFor: 'as yet unclassified' stamp: 'A.G. 10/25/2018 16:29:40'!
value

	acum _ 0.

	account transactionsDo:[:aTransaction | aTransaction accept:self ].
	^ acum.
	! !

!InvestmentNetVisitor methodsFor: 'as yet unclassified' stamp: 'das 10/22/2018 20:02:59'!
visitCertificateOfDeposit:aCertificateOfDeposit

	acum _ acum + aCertificateOfDeposit value! !

!InvestmentNetVisitor methodsFor: 'as yet unclassified' stamp: 'A.G. 10/25/2018 16:29:55'!
visitDeposit:aDeposit

	^0! !

!InvestmentNetVisitor methodsFor: 'as yet unclassified' stamp: 'A.G. 10/25/2018 16:30:04'!
visitTransferFrom:aTransferFrom

	^0! !

!InvestmentNetVisitor methodsFor: 'as yet unclassified' stamp: 'A.G. 10/25/2018 16:30:11'!
visitTransferTo:aTransferTo

	^0! !

!InvestmentNetVisitor methodsFor: 'as yet unclassified' stamp: 'A.G. 10/25/2018 16:30:17'!
visitWithdraw:aWithdraw

	^0! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InvestmentNetVisitor class' category: #'Portfolio-Ejercicio'!
InvestmentNetVisitor class
	instanceVariableNames: ''!

!InvestmentNetVisitor class methodsFor: 'as yet unclassified' stamp: 'das 10/22/2018 19:56:09'!
with:anAccount

	^ self new initializeWith: anAccount ! !


!classDefinition: #SummaryVisitor category: #'Portfolio-Ejercicio'!
SumarizingAccountVisitor subclass: #SummaryVisitor
	instanceVariableNames: 'account lines'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!SummaryVisitor methodsFor: 'as yet unclassified' stamp: 'A.G. 10/25/2018 16:29:10'!
value

	lines:= OrderedCollection new.
	account transactionsDo: [:transaction | transaction accept: self].
	^lines! !

!SummaryVisitor methodsFor: 'as yet unclassified' stamp: 'das 10/22/2018 20:37:09'!
visitCertificateOfDeposit:aCertificateOfDeposit

	lines add:'Plazo fijo por ',aCertificateOfDeposit value asString , ' durante ',aCertificateOfDeposit duration asString ,' dias a una tna de ', (aCertificateOfDeposit interestRate * 100 )asString ,'%'.! !

!SummaryVisitor methodsFor: 'as yet unclassified' stamp: 'das 10/22/2018 19:10:41'!
visitDeposit: aDeposit

	lines add: 'Deposito por ', aDeposit  value asString.! !

!SummaryVisitor methodsFor: 'as yet unclassified' stamp: 'das 10/22/2018 19:13:43'!
visitTransferFrom: aTransferFrom

	lines add: 'Transferencia por ', aTransferFrom  value asString.! !

!SummaryVisitor methodsFor: 'as yet unclassified' stamp: 'das 10/22/2018 19:13:59'!
visitTransferTo: aTransferTo

	lines add: 'Transferencia por ', aTransferTo  value  negated asString.! !

!SummaryVisitor methodsFor: 'as yet unclassified' stamp: 'das 10/22/2018 19:11:46'!
visitWithdraw: aWithdraw

	lines add: 'Extraccion por ', aWithdraw  value asString.! !


!SummaryVisitor methodsFor: 'initialization' stamp: 'das 10/22/2018 19:22:09'!
initializeWith: aReceptiveAccount 
	
	account := aReceptiveAccount ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SummaryVisitor class' category: #'Portfolio-Ejercicio'!
SummaryVisitor class
	instanceVariableNames: ''!

!SummaryVisitor class methodsFor: 'initialization' stamp: 'das 10/22/2018 19:21:28'!
with: aReceptiveAccount 
	
	^self new initializeWith: aReceptiveAccount ! !


!classDefinition: #TransferNetVisitor category: #'Portfolio-Ejercicio'!
SumarizingAccountVisitor subclass: #TransferNetVisitor
	instanceVariableNames: 'account transferNet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!TransferNetVisitor methodsFor: 'as yet unclassified' stamp: 'das 10/22/2018 19:32:42'!
initializeWith:anAccount

	account _ anAccount ! !

!TransferNetVisitor methodsFor: 'as yet unclassified' stamp: 'A.G. 10/25/2018 16:21:55'!
value

	transferNet _ 0.
	
	account transactionsDo: [:aTransaction | aTransaction accept:self].
	
	^ transferNet ! !

!TransferNetVisitor methodsFor: 'as yet unclassified' stamp: 'A.G. 10/25/2018 16:28:28'!
visitCertificateOfDeposit:aCertificateOfDeposit

	^0! !

!TransferNetVisitor methodsFor: 'as yet unclassified' stamp: 'A.G. 10/25/2018 16:28:08'!
visitDeposit:aDeposit

	^0! !

!TransferNetVisitor methodsFor: 'as yet unclassified' stamp: 'das 10/22/2018 19:38:06'!
visitTransferFrom:aTransferFrom

	 transferNet  _ transferNet + aTransferFrom value

! !

!TransferNetVisitor methodsFor: 'as yet unclassified' stamp: 'das 10/22/2018 19:38:46'!
visitTransferTo:aTransferTo

	 transferNet  _ transferNet - aTransferTo value 
! !

!TransferNetVisitor methodsFor: 'as yet unclassified' stamp: 'A.G. 10/25/2018 16:28:16'!
visitWithdraw:aWithdraw

	^0! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNetVisitor class' category: #'Portfolio-Ejercicio'!
TransferNetVisitor class
	instanceVariableNames: ''!

!TransferNetVisitor class methodsFor: 'as yet unclassified' stamp: 'das 10/22/2018 19:32:57'!
with:anAccount

	^ self new initializeWith: anAccount .! !


!classDefinition: #TreePrinterVisitor category: #'Portfolio-Ejercicio'!
SumarizingAccountVisitor subclass: #TreePrinterVisitor
	instanceVariableNames: 'portfolio diccionary lines'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!TreePrinterVisitor methodsFor: 'as yet unclassified' stamp: 'A.G. 10/24/2018 23:57:22'!
initializeWith: aPortofolio using:aDiccionary 

	portfolio  _ aPortofolio .
	diccionary  _ aDiccionary .! !

!TreePrinterVisitor methodsFor: 'as yet unclassified' stamp: 'A.G. 10/25/2018 15:53:33'!
value

	lines  _ OrderedCollection  new.
	
	portfolio accept: self with:0.
	
	^ lines! !

!TreePrinterVisitor methodsFor: 'as yet unclassified' stamp: 'A.G. 10/25/2018 16:06:49'!
visitPortfolio:aPortofolio with:aDepth

	|lineToAdd |
	
	lineToAdd  _ ((String new:aDepth) atAllPut:$ ),(diccionary at:aPortofolio ).
	
	
	lines add:lineToAdd.
	
	aPortofolio managedAccountsDo: [:account | account accept: self with:aDepth+1]! !

!TreePrinterVisitor methodsFor: 'as yet unclassified' stamp: 'A.G. 10/25/2018 16:06:31'!
visitReceptiveAcount:aReceptiveAccount with:aDepth

	|lineToAdd |
	lineToAdd  _ ((String new:aDepth) atAllPut:$ ), (diccionary at:aReceptiveAccount ).
	
	
	lines add:lineToAdd.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TreePrinterVisitor class' category: #'Portfolio-Ejercicio'!
TreePrinterVisitor class
	instanceVariableNames: ''!

!TreePrinterVisitor class methodsFor: 'as yet unclassified' stamp: 'das 10/22/2018 20:42:59'!
with:aPortofolio using:aDiccionary

	^ self new initializeWith: aPortofolio using:aDiccionary ! !


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

!Portfolio methodsFor: 'testing' stamp: 'das 10/22/2018 21:05:53'!
anyManagedAccountManages: anAccount 

	^managedAccounts anySatisfy: [ :managedAccount | (managedAccount doesManage: anAccount) or: [ anAccount doesManage: managedAccount ] ] ! !

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

!Portfolio methodsFor: 'transactions' stamp: 'A.G. 10/25/2018 16:25:28'!
transactionsDo:aBlock

	managedAccounts do:aBlock! !

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


!Portfolio methodsFor: 'as yet unclassified' stamp: 'das 10/22/2018 21:01:19'!
accept:aPortfolioVisitor

	aPortfolioVisitor visitPortofolio: self.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'A.G. 10/24/2018 23:59:33'!
accept:aPortfolioVisitor at:aDepth

	aPortfolioVisitor visitPortofolio: self at:aDepth.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'A.G. 10/25/2018 15:28:34'!
accept:aPortfolioVisitor with:aCollaborator

	aPortfolioVisitor visitPortfolio: self with:aCollaborator .! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'A.G. 10/25/2018 16:02:50'!
managedAccountsDo:aBlock

	managedAccounts do: aBlock.! !

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

!ReceptiveAccount methodsFor: 'transactions' stamp: 'A.G. 10/25/2018 16:26:25'!
transactionsDo:aBlock

	transactions do: aBlock! !


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


!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'das 10/22/2018 21:01:42'!
accept:aVisitor

	aVisitor visitReceptiveAcount: self .! !

!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'A.G. 10/25/2018 00:00:44'!
accept:aVisitor with:aCollaborator

	aVisitor visitReceptiveAcount: self with:aCollaborator.! !


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
