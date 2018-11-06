!classDefinition: #TerniLapili category: #'TerniLapilli-Ejercicio'!
Object subclass: #TerniLapili
	instanceVariableNames: 'tablero proximoJugador'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!TerniLapili methodsFor: 'as yet unclassified' stamp: 'A.G. 11/5/2018 20:12:35'!
addPiece: aPoint 

	(tablero at:aPoint) ifNotNil: [^self error: self class superposicionDeFichasErrorDescription ].
	(self totalPieces = 6) ifTrue: [^self error: self class cantidadDeFichasIgualesErrorDescription ].
	tablero at: aPoint put: proximoJugador color.
	self changePlayer.! !

!TerniLapili methodsFor: 'as yet unclassified' stamp: 'A.G. 11/5/2018 20:12:35'!
changePlayer
	
	(proximoJugador = Color black) ifTrue: [proximoJugador := Color white] ifFalse: [proximoJugador := Color black].! !

!TerniLapili methodsFor: 'as yet unclassified' stamp: 'A.G. 11/5/2018 19:38:16'!
hasAPieceAt: aPoint 
	
	^(tablero at:aPoint) isNil not! !

!TerniLapili methodsFor: 'as yet unclassified' stamp: 'A.G. 11/5/2018 21:47:13'!
hasAWinner
	
	#(1 2 3) do: [:a | (((tablero at: a@1) = (tablero at: a@2) and: (tablero at: a@1) = (tablero at: a@3)) 
		and: (((tablero at: a@1) isNil) not)) 
		ifTrue: [^true] ].
	#(1 2 3) do: [:a | (((tablero at: 1@a) = (tablero at: 2@a) and: (tablero at: 1@a) = (tablero at: 3@a)) 
		and: (((tablero at: 1@a) isNil) not)) 
		ifTrue: [^true] ].
	(((tablero at: 1@1) = (tablero at: 2@2) and: (tablero at: 1@1) = (tablero at: 3@3)) 
		and: (((tablero at: 1@1) isNil) not)) 
		ifTrue: [^true].
	(((tablero at: 1@3) = (tablero at: 2@2) and: (tablero at: 1@3) = (tablero at: 3@1)) 
		and: (((tablero at: 1@3) isNil) not)) 
		ifTrue: [^true].
	^false! !

!TerniLapili methodsFor: 'as yet unclassified' stamp: 'A.G. 11/5/2018 20:12:53'!
initialize

	tablero _ Array2D width: 3 height: 3.
	proximoJugador := Color black .! !

!TerniLapili methodsFor: 'as yet unclassified' stamp: 'A.G. 11/5/2018 20:57:40'!
movePieceFrom: aPoint to: aPoint2 

	(self totalPieces = 6) ifFalse: [^self error: self class cantidadDeFichasMenorA6ErrorDescription ].
	(aPoint eightNeighbors includes: aPoint2) ifFalse: [^self error: self class distanceIsGreaterThanOne ].
	(aPoint2 between: 1@1 and: 3@3) ifFalse: [^self error: self class outOfBoundsErrorDescription ].
	(tablero at:aPoint2) ifNotNil: [^self error: self class superposicionDeFichasErrorDescription ].
	((tablero at:aPoint) = proximoJugador) ifFalse: [^self error: self class turnoEquivocadoErrorDescription ].
	tablero at: aPoint put: nil.
	self addPiece: aPoint2.! !

!TerniLapili methodsFor: 'as yet unclassified' stamp: 'A.G. 11/5/2018 20:31:31'!
nextPlayer
	
	^proximoJugador ! !

!TerniLapili methodsFor: 'as yet unclassified' stamp: 'A.G. 11/5/2018 20:32:25'!
pieceAt: aPoint 
	
	^tablero at: aPoint ! !

!TerniLapili methodsFor: 'as yet unclassified' stamp: 'A.G. 11/5/2018 19:33:07'!
totalPieces
	|result |
	result := 0 .
	tablero do:[:anElement| anElement ifNotNil:[result := result +1] ].
	^result .! !

!TerniLapili methodsFor: 'as yet unclassified' stamp: 'A.G. 11/5/2018 21:20:40'!
winner
	
	^Color black! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapili class' category: #'TerniLapilli-Ejercicio'!
TerniLapili class
	instanceVariableNames: ''!

!TerniLapili class methodsFor: 'as yet unclassified' stamp: 'A.G. 11/1/2018 20:33:51'!
cantidadDeFichasIgualesErrorDescription
	
	^'No se pueden agregar más de 3 fichas un mismo color'! !

!TerniLapili class methodsFor: 'as yet unclassified' stamp: 'A.G. 11/5/2018 20:58:03'!
cantidadDeFichasMenorA6ErrorDescription
	
	^'Hay menos de 6 fichas en juego'! !

!TerniLapili class methodsFor: 'as yet unclassified' stamp: 'A.G. 11/5/2018 20:39:09'!
distanceIsGreaterThanOne
	'The distance is more than 1 ' ! !

!TerniLapili class methodsFor: 'as yet unclassified' stamp: 'A.G. 11/5/2018 20:46:13'!
outOfBoundsErrorDescription
	
	^'No se pueden mover fichas a posiciones fuera del tablero'! !

!TerniLapili class methodsFor: 'as yet unclassified' stamp: 'A.G. 11/1/2018 19:50:02'!
superposicionDeFichasErrorDescription
	
	^'No se pueden superponer dos fichas en una misma posicion'! !

!TerniLapili class methodsFor: 'as yet unclassified' stamp: 'A.G. 11/1/2018 20:47:55'!
turnoEquivocadoErrorDescription

^'el mismo jugador no puede jugar dos veces seguidas '! !
