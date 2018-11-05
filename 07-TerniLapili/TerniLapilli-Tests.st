!classDefinition: #TermiLapilliTesting category: #'TermiLapilli-Tests'!
TestCase subclass: #TermiLapilliTesting
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TermiLapilli-Tests'!

!TermiLapilliTesting methodsFor: 'Testing' stamp: 'A.G. 11/1/2018 19:25:16'!
test01

	| juego |
	juego := TermiLapili new.
	
	self assert: (juego cantidadDeFichasNegras = 0).
	self assert: (juego cantidadDeFichasBlancas = 0).
	! !

!TermiLapilliTesting methodsFor: 'Testing' stamp: 'A.G. 11/1/2018 19:32:56'!
test02

	| juego |
	juego := TermiLapili new.
	
	juego agregarFichaNegra: (2@2).
	juego agregarFichaBlanca: (2@1).
		
	self assert: (juego cantidadDeFichasNegras = 1).
	self assert: (juego cantidadDeFichasBlancas = 1).
	! !

!TermiLapilliTesting methodsFor: 'Testing' stamp: 'A.G. 11/1/2018 20:16:57'!
test03

	| juego |
	juego := TermiLapili new.
	
	juego agregarFichaNegra: (2@2).
	
	self assert: (juego tieneUnaFichaEn: (2@2)).
	self assert: (juego noTieneUnaFichaEn: (2@1)).
! !

!TermiLapilliTesting methodsFor: 'Testing' stamp: 'A.G. 11/1/2018 20:15:06'!
test04

	| juego |
	juego := TermiLapili new.
		
	self should: [juego agregarFichaNegra: (2@2). juego agregarFichaBlanca: (2@2).] 
	raise: Error
	withExceptionDo: [:anError |
		self assert: anError messageText equals: TermiLapili superposicionDeFichasErrorDescription].
	! !

!TermiLapilliTesting methodsFor: 'Testing' stamp: 'A.G. 11/1/2018 20:54:40'!
test05

	| juego |
	juego := TermiLapili new.
		
	self should: [juego agregarFichaNegra: (1@1). juego agregarFichaNegra: (3@3). juego agregarFichaNegra: (1@2). juego agregarFichaNegra: (2@1).] 
	raise: Error
	withExceptionDo: [:anError |
		self assert: anError messageText equals: TermiLapili turnoEquivocadoErrorDescription  ].
	! !

!TermiLapilliTesting methodsFor: 'Testing' stamp: 'A.G. 11/1/2018 20:54:48'!
test06

	| juego |
	juego := TermiLapili new.
		
	self should: [juego agregarFichaNegra: (1@1). juego agregarFichaBlanca: (1@2) . juego agregarFichaNegra: (1@3). juego agregarFichaBlanca: (2@1) .juego agregarFichaNegra: (2@2). juego agregarFichaBlanca: (2@3) .juego agregarFichaNegra: (3@1).] 
	raise: Error
	withExceptionDo: [:anError |
		self assert: anError messageText equals: TermiLapili  cantidadDeFichasIgualesErrorDescription ].
	! !

!TermiLapilliTesting methodsFor: 'Testing' stamp: 'A.G. 11/1/2018 21:01:04'!
test07

	| juego |
	juego := TermiLapili new.
		
	juego agregarFichaNegra: (1@1). 
	juego agregarFichaBlanca: (1@2) . 
	juego agregarFichaNegra: (1@3). 
	juego agregarFichaBlanca: (2@1). 
	juego agregarFichaNegra: (2@2). 
	juego agregarFichaBlanca: (2@3).
	juego moverFichaNegraDesde:1@1 a: 3@3.
	self assert: (juego tieneUnaFichaEn: 3@3).! !
