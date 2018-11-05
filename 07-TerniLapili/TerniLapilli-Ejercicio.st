!classDefinition: #TermiLapili category: #'TermiLapilli-Ejercicio'!
Object subclass: #TermiLapili
	instanceVariableNames: 'fichasNegras fichasBlancas tablero proximoJugador'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TermiLapilli-Ejercicio'!

!TermiLapili methodsFor: 'as yet unclassified' stamp: 'A.G. 11/1/2018 20:41:33'!
agregarFicha: aColour at: aPoint

	(proximoJugador = aColour ) ifFalse: [^self error: self class turnoEquivocadoErrorDescription ].

	(self tieneUnaFichaEn: aPoint) ifTrue: [^self error: self class superposicionDeFichasErrorDescription ].
	
	tablero at: aPoint put: aColour! !

!TermiLapili methodsFor: 'as yet unclassified' stamp: 'A.G. 11/1/2018 20:44:01'!
agregarFichaBlanca: aPoint 

	(proximoJugador = Color white) ifFalse: [^self error: self class turnoEquivocadoErrorDescription ].
	(self cantidadDeFichasBlancas >= 3) ifTrue: [^self error: self class cantidadDeFichasIgualesErrorDescription ].
	self agregarFicha: Color white at: aPoint.
	fichasBlancas add: aPoint.
	proximoJugador := Color black.! !

!TermiLapili methodsFor: 'as yet unclassified' stamp: 'A.G. 11/1/2018 20:45:26'!
agregarFichaNegra: aPoint 

	(proximoJugador = Color black ) ifFalse: [^self error: self class turnoEquivocadoErrorDescription ].
	(self cantidadDeFichasNegras >= 3) ifTrue: [^self error: self class cantidadDeFichasIgualesErrorDescription ].
	self agregarFicha: Color black at: aPoint.
	fichasNegras add: aPoint.
	proximoJugador := Color white ! !

!TermiLapili methodsFor: 'as yet unclassified' stamp: 'A.G. 11/1/2018 19:39:35'!
cantidadDeFichasBlancas

	^fichasBlancas size! !

!TermiLapili methodsFor: 'as yet unclassified' stamp: 'A.G. 11/1/2018 19:39:25'!
cantidadDeFichasNegras

	^fichasNegras size! !

!TermiLapili methodsFor: 'as yet unclassified' stamp: 'A.G. 11/1/2018 20:39:33'!
initialize

	fichasNegras _ OrderedCollection new.
	fichasBlancas _ OrderedCollection new.
	tablero _ Array2D width: 3 height: 3.
	proximoJugador := Color black .! !

!TermiLapili methodsFor: 'as yet unclassified' stamp: 'A.G. 11/1/2018 20:28:04'!
noTieneUnaFichaEn: aPoint 
	
	^(self tieneUnaFichaEn: aPoint) not! !

!TermiLapili methodsFor: 'as yet unclassified' stamp: 'A.G. 11/1/2018 20:27:21'!
tieneUnaFichaEn: aPoint 
	
	^ ((tablero at: aPoint) isNil) not! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TermiLapili class' category: #'TermiLapilli-Ejercicio'!
TermiLapili class
	instanceVariableNames: ''!

!TermiLapili class methodsFor: 'as yet unclassified' stamp: 'A.G. 11/1/2018 20:33:51'!
cantidadDeFichasIgualesErrorDescription
	
	^'No se pueden agregar más de 3 fichas un mismo color'! !

!TermiLapili class methodsFor: 'as yet unclassified' stamp: 'A.G. 11/1/2018 19:50:02'!
superposicionDeFichasErrorDescription
	
	^'No se pueden superponer dos fichas en una misma posicion'! !

!TermiLapili class methodsFor: 'as yet unclassified' stamp: 'A.G. 11/1/2018 20:47:55'!
turnoEquivocadoErrorDescription

^'el mismo jugador no puede jugar dos veces seguidas '! !
