!classDefinition: #PosicionesTablero category: #'TerniLapilli-Ejercicio'!
Object subclass: #PosicionesTablero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!PosicionesTablero methodsFor: 'as yet unclassified' stamp: 'das 11/6/2018 17:19:19'!
contabilizar

	^ self subclassResponsibility ! !


!classDefinition: #Blanco category: #'TerniLapilli-Ejercicio'!
PosicionesTablero subclass: #Blanco
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!Blanco methodsFor: 'as yet unclassified' stamp: 'das 11/6/2018 17:18:54'!
contabilizar

	^1! !

!Blanco methodsFor: 'as yet unclassified' stamp: 'das 11/6/2018 18:50:54'!
explodeIfBlack
! !

!Blanco methodsFor: 'as yet unclassified' stamp: 'das 11/6/2018 18:44:58'!
explodeIfEmpty
! !

!Blanco methodsFor: 'as yet unclassified' stamp: 'das 11/6/2018 18:27:04'!
explodeIfOccupied

	^ self error:TerniLapili superposicionDeFichasErrorDescription! !

!Blanco methodsFor: 'as yet unclassified' stamp: 'das 11/6/2018 18:49:06'!
explodeIfWhite

	^self error: TerniLapili turnoEquivocadoErrorDescription ! !


!classDefinition: #Negro category: #'TerniLapilli-Ejercicio'!
PosicionesTablero subclass: #Negro
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!Negro methodsFor: 'as yet unclassified' stamp: 'das 11/6/2018 17:19:01'!
contabilizar
	^ 1! !

!Negro methodsFor: 'as yet unclassified' stamp: 'das 11/6/2018 18:50:59'!
explodeIfBlack

	^self error: TerniLapili turnoEquivocadoErrorDescription ! !

!Negro methodsFor: 'as yet unclassified' stamp: 'das 11/6/2018 18:45:07'!
explodeIfEmpty! !

!Negro methodsFor: 'as yet unclassified' stamp: 'das 11/6/2018 18:27:26'!
explodeIfOccupied

	^ self error:TerniLapili superposicionDeFichasErrorDescription! !

!Negro methodsFor: 'as yet unclassified' stamp: 'das 11/6/2018 18:49:20'!
explodeIfWhite! !


!classDefinition: #Vacio category: #'TerniLapilli-Ejercicio'!
PosicionesTablero subclass: #Vacio
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!Vacio methodsFor: 'as yet unclassified' stamp: 'das 11/6/2018 17:19:12'!
contabilizar

^0! !

!Vacio methodsFor: 'as yet unclassified' stamp: 'das 11/6/2018 18:51:05'!
explodeIfBlack! !

!Vacio methodsFor: 'as yet unclassified' stamp: 'das 11/6/2018 18:43:59'!
explodeIfEmpty

	^self error.

	! !

!Vacio methodsFor: 'as yet unclassified' stamp: 'das 11/6/2018 18:18:55'!
explodeIfOccupied

	! !

!Vacio methodsFor: 'as yet unclassified' stamp: 'das 11/6/2018 18:49:24'!
explodeIfWhite! !


!classDefinition: #TerniLapili category: #'TerniLapilli-Ejercicio'!
Object subclass: #TerniLapili
	instanceVariableNames: 'tablero state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!TerniLapili methodsFor: 'as yet unclassified' stamp: 'das 11/6/2018 18:38:42'!
addBlackPieceAt:aPosition

	(tablero at: aPosition) explodeIfOccupied .
	
	tablero at: aPosition put: Negro new.
	
	state _ state nextFor: self.! !

!TerniLapili methodsFor: 'as yet unclassified' stamp: 'das 11/6/2018 17:59:17'!
addPiece: aPoint 

	state addPiece: aPoint in: self! !

!TerniLapili methodsFor: 'as yet unclassified' stamp: 'das 11/6/2018 18:38:59'!
addWhitePieceAt:aPosition

	(tablero at: aPosition) explodeIfOccupied .
	
	tablero at: aPosition put: Blanco new.
	
	state _ state nextFor:self.! !

!TerniLapili methodsFor: 'as yet unclassified' stamp: 'A.G. 11/5/2018 20:12:35'!
changePlayer
	
	(proximoJugador = Color black) ifTrue: [proximoJugador := Color white] ifFalse: [proximoJugador := Color black].! !

!TerniLapili methodsFor: 'as yet unclassified' stamp: 'A.G. 11/5/2018 19:38:16'!
hasAPieceAt: aPoint 
	
	^(tablero at:aPoint) isNil not! !

!TerniLapili methodsFor: 'as yet unclassified' stamp: 'das 11/6/2018 17:12:37'!
hasAWinner

	^ state hasWinner .! !

!TerniLapili methodsFor: 'as yet unclassified' stamp: 'das 11/6/2018 17:53:36'!
initialize

	tablero _ Array2D width: 3 height: 3.
	tablero replaceValues: [:i :j : previous | Vacio new].
	state _ PuttingPieceStateBlack new.! !

!TerniLapili methodsFor: 'as yet unclassified' stamp: 'das 11/6/2018 18:57:18'!
moveBlackPieceFrom: aPoint to: anotherPoint

	(tablero at: aPoint) explodeIfEmpty.
	(tablero at: anotherPoint) explodeIfOccupied.
	(tablero at: aPoint) explodeIfWhite.
	
	tablero at: aPoint put: Vacio new.
	tablero at: aPoint put: Negro new.
	
	state _ state nextFor: self.! !

!TerniLapili methodsFor: 'as yet unclassified' stamp: 'das 11/6/2018 18:43:24'!
movePieceFrom: aPoint to: anotherPoint

	state movePieceFrom: aPoint to: anotherPoint in: self! !

!TerniLapili methodsFor: 'as yet unclassified' stamp: 'das 11/6/2018 18:57:28'!
moveWhitePieceFrom: aPoint to: anotherPoint

	(tablero at: aPoint) explodeIfEmpty.
	(tablero at: anotherPoint) explodeIfOccupied.
	(tablero at: aPoint) explodeIfBlack.
	
	tablero at: aPoint put: Vacio new.
	tablero at: aPoint put: Blanco new.
	
	state _ state nextFor: self.! !

!TerniLapili methodsFor: 'as yet unclassified' stamp: 'das 11/6/2018 19:00:22'!
nextPlayer
	
	^ state player ! !

!TerniLapili methodsFor: 'as yet unclassified' stamp: 'A.G. 11/5/2018 20:32:25'!
pieceAt: aPoint 
	
	^tablero at: aPoint ! !

!TerniLapili methodsFor: 'as yet unclassified' stamp: 'das 11/6/2018 17:24:18'!
totalPieces
	|result |
	result := 0 .
	tablero do:[:anElement| result := result + anElement contabilizar . result].
	^result .! !

!TerniLapili methodsFor: 'as yet unclassified' stamp: 'das 11/6/2018 17:52:59'!
winner

	^ state winner! !

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

!TerniLapili class methodsFor: 'as yet unclassified' stamp: 'A.G. 11/6/2018 16:22:49'!
gameOverErrorDescription
	
	^'No se pueden mover más piezas una vez que el juego ya terminó'! !

!TerniLapili class methodsFor: 'as yet unclassified' stamp: 'A.G. 11/5/2018 20:46:13'!
outOfBoundsErrorDescription
	
	^'No se pueden mover fichas a posiciones fuera del tablero'! !

!TerniLapili class methodsFor: 'as yet unclassified' stamp: 'A.G. 11/1/2018 19:50:02'!
superposicionDeFichasErrorDescription
	
	^'No se pueden superponer dos fichas en una misma posicion'! !

!TerniLapili class methodsFor: 'as yet unclassified' stamp: 'A.G. 11/1/2018 20:47:55'!
turnoEquivocadoErrorDescription

^'el mismo jugador no puede jugar dos veces seguidas '! !


!classDefinition: #TerniLapiliState category: #'TerniLapilli-Ejercicio'!
Object subclass: #TerniLapiliState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!TerniLapiliState methodsFor: 'as yet unclassified' stamp: 'das 11/6/2018 17:06:54'!
hasWinner

	^ self subclassResponsibility .! !

!TerniLapiliState methodsFor: 'as yet unclassified' stamp: 'das 11/6/2018 17:07:34'!
movePieceFrom:aPosition to:anotherPosition

	^ self subclassResponsibility .! !

!TerniLapiliState methodsFor: 'as yet unclassified' stamp: 'das 11/6/2018 17:07:57'!
putPieceAt:aPosition

	^ self subclassResponsibility .! !

!TerniLapiliState methodsFor: 'as yet unclassified' stamp: 'das 11/6/2018 17:07:09'!
winner

	^ self subclassResponsibility .! !


!classDefinition: #GameFinishedState category: #'TerniLapilli-Ejercicio'!
TerniLapiliState subclass: #GameFinishedState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!GameFinishedState methodsFor: 'as yet unclassified' stamp: 'das 11/6/2018 18:41:27'!
addPiece: aPoint in:aGame

	^ self error: TerniLapili cantidadDeFichasIgualesErrorDescription ! !

!GameFinishedState methodsFor: 'as yet unclassified' stamp: 'das 11/6/2018 17:03:48'!
hasWinner

	^ true! !


!classDefinition: #GameFinishedStateBlackWon category: #'TerniLapilli-Ejercicio'!
GameFinishedState subclass: #GameFinishedStateBlackWon
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!GameFinishedStateBlackWon methodsFor: 'as yet unclassified' stamp: 'das 11/6/2018 18:54:47'!
player

	^ Negro new! !


!classDefinition: #GameFinishedStateWhiteWon category: #'TerniLapilli-Ejercicio'!
GameFinishedState subclass: #GameFinishedStateWhiteWon
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!GameFinishedStateWhiteWon methodsFor: 'as yet unclassified' stamp: 'das 11/6/2018 18:54:32'!
player

	^ Blanco new! !


!classDefinition: #MovingPiecesState category: #'TerniLapilli-Ejercicio'!
TerniLapiliState subclass: #MovingPiecesState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!MovingPiecesState methodsFor: 'as yet unclassified' stamp: 'das 11/6/2018 18:41:10'!
addPiece: aPoint in:aGame

	^ self error: TerniLapili cantidadDeFichasIgualesErrorDescription ! !

!MovingPiecesState methodsFor: 'as yet unclassified' stamp: 'das 11/6/2018 17:03:56'!
hasWinner
	^ false! !


!classDefinition: #MovingPiecesStateBlack category: #'TerniLapilli-Ejercicio'!
MovingPiecesState subclass: #MovingPiecesStateBlack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!MovingPiecesStateBlack methodsFor: 'as yet unclassified' stamp: 'das 11/6/2018 18:46:18'!
movePieceFrom: aPoint to: anotherPoint in: aGame

	aGame moveBlackPieceFrom: aPoint to: anotherPoint.! !

!MovingPiecesStateBlack methodsFor: 'as yet unclassified' stamp: 'das 11/6/2018 18:55:48'!
nextFor:aGame

	^ MovingPiecesStateWhite new! !

!MovingPiecesStateBlack methodsFor: 'as yet unclassified' stamp: 'das 11/6/2018 18:54:40'!
player

	^ Negro new! !


!classDefinition: #MovingPiecesStateWhite category: #'TerniLapilli-Ejercicio'!
MovingPiecesState subclass: #MovingPiecesStateWhite
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!MovingPiecesStateWhite methodsFor: 'as yet unclassified' stamp: 'das 11/6/2018 18:46:33'!
movePieceFrom: aPoint to: anotherPoint in: aGame

	aGame moveWhitePieceFrom: aPoint to: anotherPoint.! !

!MovingPiecesStateWhite methodsFor: 'as yet unclassified' stamp: 'das 11/6/2018 18:56:09'!
nextFor:aGame

	^MovingPiecesStateBlack new! !

!MovingPiecesStateWhite methodsFor: 'as yet unclassified' stamp: 'das 11/6/2018 18:54:24'!
player

	^ Blanco new! !


!classDefinition: #PuttingPieceState category: #'TerniLapilli-Ejercicio'!
TerniLapiliState subclass: #PuttingPieceState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!PuttingPieceState methodsFor: 'as yet unclassified' stamp: 'das 11/6/2018 17:54:12'!
addPiece: aPoint 

	^ self subclassResponsibility ! !

!PuttingPieceState methodsFor: 'as yet unclassified' stamp: 'das 11/6/2018 17:04:03'!
hasWinner

	^ false! !

!PuttingPieceState methodsFor: 'as yet unclassified' stamp: 'das 11/6/2018 18:14:26'!
next

	^  self subclassResponsibility ! !


!classDefinition: #PuttingPieceStateBlack category: #'TerniLapilli-Ejercicio'!
PuttingPieceState subclass: #PuttingPieceStateBlack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!PuttingPieceStateBlack methodsFor: 'as yet unclassified' stamp: 'das 11/6/2018 18:07:35'!
addPiece:aPosition in:aTerniLapili

	aTerniLapili addBlackPieceAt: aPosition! !

!PuttingPieceStateBlack methodsFor: 'as yet unclassified' stamp: 'das 11/6/2018 18:14:50'!
next

	^ PuttingPieceStateWhite new.! !

!PuttingPieceStateBlack methodsFor: 'as yet unclassified' stamp: 'das 11/6/2018 18:31:13'!
nextFor:aGame

	^ (aGame totalPieces =6) ifTrue: [^ MovingPiecesStateWhite new] ifFalse:[^PuttingPieceStateWhite new] ! !

!PuttingPieceStateBlack methodsFor: 'as yet unclassified' stamp: 'das 11/6/2018 18:53:38'!
player

	^Negro new! !


!classDefinition: #PuttingPieceStateWhite category: #'TerniLapilli-Ejercicio'!
PuttingPieceState subclass: #PuttingPieceStateWhite
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!PuttingPieceStateWhite methodsFor: 'as yet unclassified' stamp: 'das 11/6/2018 18:24:48'!
addPiece:aPosition in:aTerniLapili

	aTerniLapili addWhitePieceAt: aPosition! !

!PuttingPieceStateWhite methodsFor: 'as yet unclassified' stamp: 'das 11/6/2018 18:25:45'!
next

	^ PuttingPieceStateBlack new.! !

!PuttingPieceStateWhite methodsFor: 'as yet unclassified' stamp: 'das 11/6/2018 18:36:51'!
nextFor:aGame

	^ (aGame totalPieces =6) ifTrue: [^ MovingPiecesStateBlack new] ifFalse:[^PuttingPieceStateBlack new] ! !

!PuttingPieceStateWhite methodsFor: 'as yet unclassified' stamp: 'das 11/6/2018 18:54:11'!
player

^Blanco new! !
