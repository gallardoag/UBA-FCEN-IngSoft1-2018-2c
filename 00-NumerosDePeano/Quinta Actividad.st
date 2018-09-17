!classDefinition: #I category: #'Quinta Actividad'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Quinta Actividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #'Quinta Actividad'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'operaciones' stamp: 'CDC 9/9/2018 15:49:11'!
* unNumeroDePeano

	^unNumeroDePeano.! !

!I class methodsFor: 'operaciones' stamp: 'ARM 9/6/2018 21:44:20'!
+ unNumeroDePeano

	^unNumeroDePeano next! !

!I class methodsFor: 'operaciones' stamp: 'CDC 9/11/2018 17:03:18'!
- unNumeroDePeano

	^self error: self descripcionDeErrorDeNumerosNegativosNoSoportados! !

!I class methodsFor: 'operaciones' stamp: 'CDC 9/11/2018 16:57:47'!
/ unNumeroDePeano

	(unNumeroDePeano == self) ifTrue: [^ self].
	^ self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor ! !


!I class methodsFor: 'metodos privados' stamp: 'CDC 9/11/2018 16:16:21'!
asNaturalNumber

	^ self name size.! !

!I class methodsFor: 'metodos privados' stamp: 'CDC 9/11/2018 16:59:29'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor

	^ 'Los Axiomas de Peano solo definen a los numeros naturales'.! !

!I class methodsFor: 'metodos privados' stamp: 'CDC 9/11/2018 16:52:40'!
descripcionDeErrorDeNumerosNegativosNoSoportados

	^ ' En los numeros de Peano, no existe ni el cero ni los enteros negativos'.

! !

!I class methodsFor: 'metodos privados' stamp: 'ARM 9/6/2018 21:29:22'!
next

	^II! !

!I class methodsFor: 'metodos privados' stamp: 'CDC 9/15/2018 20:35:34'!
restame:unNumeroDePeano

	^ unNumeroDePeano previous .! !


!I class methodsFor: 'comparaciones' stamp: 'CDC 9/11/2018 16:28:28'!
< unNumeroDePeano

	^ self asNaturalNumber < unNumeroDePeano asNaturalNumber .
	! !

!I class methodsFor: 'comparaciones' stamp: 'CDC 9/11/2018 16:28:36'!
> unNumeroDePeano

	^ self asNaturalNumber > unNumeroDePeano asNaturalNumber .
	! !


!classDefinition: #II category: #'Quinta Actividad'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Quinta Actividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #'Quinta Actividad'!
II class
	instanceVariableNames: 'next prev'!

!II class methodsFor: 'as yet unclassified' stamp: 'CDC 9/9/2018 16:48:55'!
* unNumeroDePeano

	^ unNumeroDePeano + (unNumeroDePeano * self prev )! !

!II class methodsFor: 'as yet unclassified' stamp: 'ARM 9/6/2018 21:47:13'!
+ unNumeroDePeano

	^self prev + unNumeroDePeano next! !

!II class methodsFor: 'as yet unclassified' stamp: 'CDC 9/15/2018 20:34:56'!
- unNumeroDePeano

	^unNumeroDePeano restame:self! !

!II class methodsFor: 'as yet unclassified' stamp: 'CDC 9/11/2018 16:58:14'!
/ unNumeroDePeano

	(unNumeroDePeano == self) ifTrue: [^ I].
	
	(unNumeroDePeano == I ) ifTrue: [^ self].
	
	( self < unNumeroDePeano ) ifTrue: [^ self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor ].
	
	^ (unNumeroDePeano cuantasVecesEntraEn: self conResultadoParcial:I).! !

!II class methodsFor: 'as yet unclassified' stamp: 'CDC 9/9/2018 22:46:57'!
< unNumeroDePeano

	^ self asNaturalNumber < unNumeroDePeano asNaturalNumber .
	! !

!II class methodsFor: 'as yet unclassified' stamp: 'CDC 9/9/2018 22:46:57'!
> unNumeroDePeano

	^ self asNaturalNumber > unNumeroDePeano asNaturalNumber .
	! !

!II class methodsFor: 'as yet unclassified' stamp: 'CDC 9/9/2018 22:46:57'!
asNaturalNumber

	^ self name size.! !

!II class methodsFor: 'as yet unclassified' stamp: 'CDC 9/11/2018 23:06:42'!
cuantasVecesEntraEn:unNumeroDePeano conResultadoParcial:unAcumulador
	"La idea es pasarse estrictamente y restar 1 en la division"
	
	(self == unNumeroDePeano ) ifTrue: [^unAcumulador].
	(self+self > unNumeroDePeano ) ifTrue: [^unAcumulador ].
	^ (self + self) cuantasVecesEntraEn: unNumeroDePeano conResultadoParcial: unAcumulador + I
	! !

!II class methodsFor: 'as yet unclassified' stamp: 'CDC 9/11/2018 17:00:10'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor

	^ 'Los Axiomas de Peano solo definen a los numeros naturales'.! !

!II class methodsFor: 'as yet unclassified' stamp: 'CDC 9/11/2018 17:00:22'!
descripcionDeErrorDeNumerosNegativosNoSoportados

	^ ' En los numeros de Peano, no existe ni el cero ni los enteros negativos'.! !

!II class methodsFor: 'as yet unclassified' stamp: 'CDC 9/17/2018 14:50:53'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	prev := I.! !

!II class methodsFor: 'as yet unclassified' stamp: 'ARM 9/6/2018 21:48:10'!
next
	
	next ifNil:
	[
		next _ self cloneNamed: self name , 'I'.
		next prev: self.
	].
	^next! !

!II class methodsFor: 'as yet unclassified' stamp: 'ARM 9/6/2018 21:49:14'!
prev

	^prev! !

!II class methodsFor: 'as yet unclassified' stamp: 'ARM 9/6/2018 21:48:32'!
prev: unNumeroDePeano

	prev _ unNumeroDePeano! !

!II class methodsFor: 'as yet unclassified' stamp: 'CDC 9/10/2018 20:10:49'!
previous

	^ prev.
	! !

!II class methodsFor: 'as yet unclassified' stamp: 'CDC 9/11/2018 11:54:57'!
removeAllNext

	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	].

	next _ nil. 

! !

!II class methodsFor: 'as yet unclassified' stamp: 'CDC 9/16/2018 18:36:02'!
restame:unNumeroDePeano

	^unNumeroDePeano  prev - self prev
! !


!classDefinition: #III category: #'Quinta Actividad'!
DenotativeObject subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Quinta Actividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: #'Quinta Actividad'!
III class
	instanceVariableNames: 'next prev'!

!III class methodsFor: 'as yet unclassified' stamp: 'CDC 9/17/2018 14:50:38'!
* unNumeroDePeano

	^ unNumeroDePeano + (unNumeroDePeano * self prev )! !

!III class methodsFor: 'as yet unclassified' stamp: 'CDC 9/17/2018 14:50:38'!
+ unNumeroDePeano

	^self prev + unNumeroDePeano next! !

!III class methodsFor: 'as yet unclassified' stamp: 'CDC 9/17/2018 14:50:38'!
- unNumeroDePeano

	^unNumeroDePeano restame:self! !

!III class methodsFor: 'as yet unclassified' stamp: 'CDC 9/17/2018 14:50:38'!
/ unNumeroDePeano

	(unNumeroDePeano == self) ifTrue: [^ I].
	
	(unNumeroDePeano == I ) ifTrue: [^ self].
	
	( self < unNumeroDePeano ) ifTrue: [^ self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor ].
	
	^ (unNumeroDePeano cuantasVecesEntraEn: self conResultadoParcial:I).! !

!III class methodsFor: 'as yet unclassified' stamp: 'CDC 9/17/2018 14:50:38'!
< unNumeroDePeano

	^ self asNaturalNumber < unNumeroDePeano asNaturalNumber .
	! !

!III class methodsFor: 'as yet unclassified' stamp: 'CDC 9/17/2018 14:50:38'!
> unNumeroDePeano

	^ self asNaturalNumber > unNumeroDePeano asNaturalNumber .
	! !

!III class methodsFor: 'as yet unclassified' stamp: 'CDC 9/17/2018 14:50:38'!
asNaturalNumber

	^ self name size.! !

!III class methodsFor: 'as yet unclassified' stamp: 'CDC 9/17/2018 14:50:38'!
cuantasVecesEntraEn:unNumeroDePeano conResultadoParcial:unAcumulador
	"La idea es pasarse estrictamente y restar 1 en la division"
	
	(self == unNumeroDePeano ) ifTrue: [^unAcumulador].
	(self+self > unNumeroDePeano ) ifTrue: [^unAcumulador ].
	^ (self + self) cuantasVecesEntraEn: unNumeroDePeano conResultadoParcial: unAcumulador + I
	! !

!III class methodsFor: 'as yet unclassified' stamp: 'CDC 9/17/2018 14:50:38'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor

	^ 'Los Axiomas de Peano solo definen a los numeros naturales'.! !

!III class methodsFor: 'as yet unclassified' stamp: 'CDC 9/17/2018 14:50:38'!
descripcionDeErrorDeNumerosNegativosNoSoportados

	^ ' En los numeros de Peano, no existe ni el cero ni los enteros negativos'.! !

!III class methodsFor: 'as yet unclassified' stamp: 'CDC 9/17/2018 14:50:53'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	prev := II.! !

!III class methodsFor: 'as yet unclassified' stamp: 'CDC 9/17/2018 14:50:38'!
next
	
	next ifNil:
	[
		next _ self cloneNamed: self name , 'I'.
		next prev: self.
	].
	^next! !

!III class methodsFor: 'as yet unclassified' stamp: 'CDC 9/17/2018 14:50:38'!
prev

	^prev! !

!III class methodsFor: 'as yet unclassified' stamp: 'CDC 9/17/2018 14:50:38'!
prev: unNumeroDePeano

	prev _ unNumeroDePeano! !

!III class methodsFor: 'as yet unclassified' stamp: 'CDC 9/17/2018 14:50:38'!
previous

	^ prev.
	! !

!III class methodsFor: 'as yet unclassified' stamp: 'CDC 9/17/2018 14:50:38'!
removeAllNext

	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	].

	next _ nil. 

! !

!III class methodsFor: 'as yet unclassified' stamp: 'CDC 9/17/2018 14:50:38'!
restame:unNumeroDePeano

	^unNumeroDePeano  prev - self prev
! !


!classDefinition: #IIII category: #'Quinta Actividad'!
DenotativeObject subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Quinta Actividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: #'Quinta Actividad'!
IIII class
	instanceVariableNames: 'next prev'!

!IIII class methodsFor: 'as yet unclassified' stamp: 'CDC 9/17/2018 14:50:38'!
* unNumeroDePeano

	^ unNumeroDePeano + (unNumeroDePeano * self prev )! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'CDC 9/17/2018 14:50:38'!
+ unNumeroDePeano

	^self prev + unNumeroDePeano next! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'CDC 9/17/2018 14:50:38'!
- unNumeroDePeano

	^unNumeroDePeano restame:self! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'CDC 9/17/2018 14:50:38'!
/ unNumeroDePeano

	(unNumeroDePeano == self) ifTrue: [^ I].
	
	(unNumeroDePeano == I ) ifTrue: [^ self].
	
	( self < unNumeroDePeano ) ifTrue: [^ self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor ].
	
	^ (unNumeroDePeano cuantasVecesEntraEn: self conResultadoParcial:I).! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'CDC 9/17/2018 14:50:38'!
< unNumeroDePeano

	^ self asNaturalNumber < unNumeroDePeano asNaturalNumber .
	! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'CDC 9/17/2018 14:50:38'!
> unNumeroDePeano

	^ self asNaturalNumber > unNumeroDePeano asNaturalNumber .
	! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'CDC 9/17/2018 14:50:38'!
asNaturalNumber

	^ self name size.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'CDC 9/17/2018 14:50:38'!
cuantasVecesEntraEn:unNumeroDePeano conResultadoParcial:unAcumulador
	"La idea es pasarse estrictamente y restar 1 en la division"
	
	(self == unNumeroDePeano ) ifTrue: [^unAcumulador].
	(self+self > unNumeroDePeano ) ifTrue: [^unAcumulador ].
	^ (self + self) cuantasVecesEntraEn: unNumeroDePeano conResultadoParcial: unAcumulador + I
	! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'CDC 9/17/2018 14:50:38'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor

	^ 'Los Axiomas de Peano solo definen a los numeros naturales'.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'CDC 9/17/2018 14:50:38'!
descripcionDeErrorDeNumerosNegativosNoSoportados

	^ ' En los numeros de Peano, no existe ni el cero ni los enteros negativos'.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'CDC 9/17/2018 14:50:53'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	prev := III.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'CDC 9/17/2018 14:50:38'!
next
	
	next ifNil:
	[
		next _ self cloneNamed: self name , 'I'.
		next prev: self.
	].
	^next! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'CDC 9/17/2018 14:50:38'!
prev

	^prev! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'CDC 9/17/2018 14:50:38'!
prev: unNumeroDePeano

	prev _ unNumeroDePeano! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'CDC 9/17/2018 14:50:38'!
previous

	^ prev.
	! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'CDC 9/17/2018 14:50:38'!
removeAllNext

	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	].

	next _ nil. 

! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'CDC 9/17/2018 14:50:38'!
restame:unNumeroDePeano

	^unNumeroDePeano  prev - self prev
! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!