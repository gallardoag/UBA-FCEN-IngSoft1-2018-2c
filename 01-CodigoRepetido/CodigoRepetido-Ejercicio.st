!classDefinition: #CantSuspend category: #'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: 'customerBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'L 9/22/2018 23:31:07'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	customerBook _ CustomerBook new.
	self assertThat: [customerBook addCustomerNamed: 'John Lennon']  doesNotTakeMoreTimeThan: (50*millisecond).! !

!CustomerBookTest methodsFor: 'testing' stamp: 'L 9/22/2018 23:31:19'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| paulMcCartney |
	customerBook _ CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	customerBook addCustomerNamed: paulMcCartney.
	
	self assertThat: [customerBook removeCustomerNamed: paulMcCartney]  doesNotTakeMoreTimeThan: (100*millisecond).! !

!CustomerBookTest methodsFor: 'testing' stamp: 'L 9/23/2018 17:46:26'!
test03CanNotAddACustomerWithEmptyName 

	customerBook _ CustomerBook  new.
	
	self assertThat:[ customerBook addCustomerNamed: '']  
		failsWith:Error  
		andAssert: [:anError | self assert: anError messageText = CustomerBook 	customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]			
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'L 9/23/2018 17:43:01'!
test04CanNotRemoveAnInvalidCustomer
	
	| johnLennon |
	customerBook  _ CustomerBook  new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	self assertThat: [ customerBook removeCustomerNamed: 'Paul McCartney'.
	self fail ] failsWith: NotFound 
		andAssert: [ :anError |  self assertTotalCustomersAre1AndIncludesJohnLennon ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'L 9/23/2018 17:47:51'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| paulMcCartney|
	
	customerBook := CustomerBook  new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self assertThatActiveCustomersAre: 0 andSuspendedCustomersAre:1  andTotalCustomersAre:1. 
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'L 9/23/2018 17:47:51'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| paulMcCartney|
	
	customerBook := CustomerBook  new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney .
	customerBook suspendCustomerNamed: paulMcCartney .
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assertThatActiveCustomersAre: 0 andSuspendedCustomersAre:0  andTotalCustomersAre:0. 
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'L 9/23/2018 17:45:01'!
test07CanNotSuspendAnInvalidCustomer
	
	|johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self assertThat:[ customerBook suspendCustomerNamed: 'Paul McCartney'.
	self fail ] failsWith: CantSuspend 
	andAssert:[ :anError | 
			self assertTotalCustomersAre1AndIncludesJohnLennon ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'L 9/23/2018 17:44:56'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	self assertThat:[ customerBook suspendCustomerNamed: johnLennon.
	self fail ]    failsWith:CantSuspend   
	andAssert: [ :anError | 
			self assertTotalCustomersAre1AndIncludesJohnLennon]. 
	
	
	! !


!CustomerBookTest methodsFor: 'asserting' stamp: 'A.G. 9/20/2018 21:31:35'!
assertThat:  aClosure doesNotTakeMoreTimeThan: time
	| millisecondsBeforeRunning millisecondsAfterRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aClosure value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < (time)! !

!CustomerBookTest methodsFor: 'asserting' stamp: 'L 9/23/2018 16:53:43'!
assertThat: aClosure failsWith:anExceptionType andAssert:anAssertionClosure 

	[ aClosure value.
	self fail ]
		on: anExceptionType 
		do: anAssertionClosure .! !

!CustomerBookTest methodsFor: 'asserting' stamp: 'L 9/23/2018 17:47:51'!
assertThatActiveCustomersAre:firstNumber andSuspendedCustomersAre: secondNumber andTotalCustomersAre:thirdNumber

	self assert: firstNumber equals: customerBook numberOfActiveCustomers.
	self assert: secondNumber equals: customerBook numberOfSuspendedCustomers.
	self assert: thirdNumber equals: customerBook numberOfCustomers.! !

!CustomerBookTest methodsFor: 'asserting' stamp: 'L 9/22/2018 16:33:51'!
assertTotalCustomersAre1AndIncludesJohnLennon

	self assert: customerBook numberOfCustomers = 1.
	self assert: (customerBook includesCustomerNamed: 'John Lennon')! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'L 9/23/2018 17:05:14'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'L 9/23/2018 17:05:14'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'L 9/23/2018 17:05:13'!
initialize

	super initialize.
	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'L 9/23/2018 17:05:13'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'L 9/23/2018 17:05:14'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'L 9/23/2018 17:05:14'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'L 9/23/2018 17:49:46'!
removeCustomerNamed: aName 
 
	active remove: aName ifAbsent: [
	suspended remove: aName ifAbsent: [

		^ NotFound signal.]]
	! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'L 9/23/2018 17:05:13'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:57'!
customerAlreadyExistsErrorMessage

	^'Customer already exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:53'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty'! !
