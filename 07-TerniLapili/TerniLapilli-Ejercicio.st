!classDefinition: #PosicionesTablero category: #'TerniLapilli-Ejercicio'!
Object subclass: #PosicionesTablero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!PosicionesTablero methodsFor: 'comparing' stamp: 'A.G. 11/7/2018 18:03:51'!
isBlack

	^self subclassResponsibility ! !

!PosicionesTablero methodsFor: 'comparing' stamp: 'A.G. 11/7/2018 18:04:16'!
isEmpty
	^ self subclassResponsibility ! !

!PosicionesTablero methodsFor: 'comparing' stamp: 'A.G. 11/7/2018 18:03:44'!
isWhite

	^self subclassResponsibility ! !

!PosicionesTablero methodsFor: 'comparing' stamp: 'A.G. 11/7/2018 18:05:38'!
sameColourAs: aColour
	^self subclassResponsibility .! !


!PosicionesTablero methodsFor: 'testing' stamp: 'das 11/6/2018 17:19:19'!
contabilizar

	^ self subclassResponsibility ! !


!classDefinition: #Blanco category: #'TerniLapilli-Ejercicio'!
PosicionesTablero subclass: #Blanco
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!Blanco methodsFor: 'testing' stamp: 'das 11/6/2018 17:18:54'!
contabilizar

	^1! !

!Blanco methodsFor: 'testing' stamp: 'das 11/6/2018 18:50:54'!
explodeIfBlack
! !

!Blanco methodsFor: 'testing' stamp: 'das 11/6/2018 18:44:58'!
explodeIfEmpty
! !

!Blanco methodsFor: 'testing' stamp: 'A.G. 11/7/2018 17:57:17'!
explodeIfOccupied

	^self error:TerniLapili superposicionDeFichasErrorDescription! !

!Blanco methodsFor: 'testing' stamp: 'das 11/6/2018 18:49:06'!
explodeIfWhite

	^self error: TerniLapili turnoEquivocadoErrorDescription ! !


!Blanco methodsFor: 'comparing' stamp: 'A.G. 11/7/2018 16:07:09'!
isBlack

	^false! !

!Blanco methodsFor: 'comparing' stamp: 'A.G. 11/7/2018 16:06:10'!
isEmpty

	^false! !

!Blanco methodsFor: 'comparing' stamp: 'A.G. 11/7/2018 16:07:00'!
isWhite

	^true! !

!Blanco methodsFor: 'comparing' stamp: 'A.G. 11/7/2018 16:09:08'!
sameColourAs: aColour
	
	^aColour isWhite! !


!Blanco methodsFor: 'winning' stamp: 'A.G. 11/7/2018 16:43:42'!
declareWinner

	^GameFinishedStateWhiteWon new! !


!classDefinition: #Negro category: #'TerniLapilli-Ejercicio'!
PosicionesTablero subclass: #Negro
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!Negro methodsFor: 'testing' stamp: 'das 11/6/2018 17:19:01'!
contabilizar
	^ 1! !

!Negro methodsFor: 'testing' stamp: 'das 11/6/2018 18:50:59'!
explodeIfBlack

	^self error: TerniLapili turnoEquivocadoErrorDescription ! !

!Negro methodsFor: 'testing' stamp: 'das 11/6/2018 18:45:07'!
explodeIfEmpty! !

!Negro methodsFor: 'testing' stamp: 'A.G. 11/7/2018 17:57:03'!
explodeIfOccupied

	^self error: TerniLapili superposicionDeFichasErrorDescription! !

!Negro methodsFor: 'testing' stamp: 'das 11/6/2018 18:49:20'!
explodeIfWhite! !


!Negro methodsFor: 'comparing' stamp: 'A.G. 11/7/2018 16:06:40'!
isBlack

	^true! !

!Negro methodsFor: 'comparing' stamp: 'A.G. 11/7/2018 16:06:10'!
isEmpty

	^false! !

!Negro methodsFor: 'comparing' stamp: 'A.G. 11/7/2018 16:07:22'!
isWhite

	^false! !

!Negro methodsFor: 'comparing' stamp: 'A.G. 11/7/2018 16:08:57'!
sameColourAs: aColour
	
	^aColour isBlack! !


!Negro methodsFor: 'winning' stamp: 'A.G. 11/7/2018 16:43:53'!
declareWinner

	^GameFinishedStateBlackWon new! !


!classDefinition: #Vacio category: #'TerniLapilli-Ejercicio'!
PosicionesTablero subclass: #Vacio
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!Vacio methodsFor: 'testing' stamp: 'das 11/6/2018 17:19:12'!
contabilizar

^0! !

!Vacio methodsFor: 'testing' stamp: 'das 11/6/2018 18:51:05'!
explodeIfBlack! !

!Vacio methodsFor: 'testing' stamp: 'das 11/6/2018 18:43:59'!
explodeIfEmpty

	^self error.

	! !

!Vacio methodsFor: 'testing' stamp: 'das 11/6/2018 18:18:55'!
explodeIfOccupied

	! !

!Vacio methodsFor: 'testing' stamp: 'das 11/6/2018 18:49:24'!
explodeIfWhite! !


!Vacio methodsFor: 'comparing' stamp: 'A.G. 11/7/2018 16:07:52'!
isBlack

	^false! !

!Vacio methodsFor: 'comparing' stamp: 'A.G. 11/7/2018 16:06:10'!
isEmpty

	^true! !

!Vacio methodsFor: 'comparing' stamp: 'A.G. 11/7/2018 16:07:57'!
isWhite

	^false! !

!Vacio methodsFor: 'comparing' stamp: 'A.G. 11/7/2018 16:09:16'!
sameColourAs: aColour
	
	^aColour isEmpty! !


!classDefinition: #TerniLapili category: #'TerniLapilli-Ejercicio'!
Object subclass: #TerniLapili
	instanceVariableNames: 'tablero state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!TerniLapili methodsFor: 'pieces-adding' stamp: 'das 11/6/2018 18:38:42'!
addBlackPieceAt:aPosition

	(tablero at: aPosition) explodeIfOccupied .
	
	tablero at: aPosition put: Negro new.
	
	state _ state nextFor: self.! !

!TerniLapili methodsFor: 'pieces-adding' stamp: 'A.G. 11/7/2018 16:44:17'!
addPiece: aPoint 

	(aPoint between: 1@1 and: 3@3 )ifFalse: [^self error: self class outOfBoundsErrorDescription ].
	state addPiece: aPoint in: self.
	self checkForAWinner.! !

!TerniLapili methodsFor: 'pieces-adding' stamp: 'das 11/6/2018 18:38:59'!
addWhitePieceAt:aPosition

	(tablero at: aPosition) explodeIfOccupied .
	
	tablero at: aPosition put: Blanco new.
	
	state _ state nextFor:self.! !


!TerniLapili methodsFor: 'pieces-moving' stamp: 'A.G. 11/7/2018 17:52:03'!
moveBlackPieceFrom: aPoint to: anotherPoint

	(tablero at: aPoint) explodeIfEmpty.
	(tablero at: anotherPoint) explodeIfOccupied.
	(tablero at: aPoint) explodeIfWhite.
	
	tablero at: aPoint put: Vacio new.
	tablero at: anotherPoint put: Negro new.
	
	state _ state nextFor: self.! !

!TerniLapili methodsFor: 'pieces-moving' stamp: 'A.G. 11/7/2018 18:00:02'!
movePieceFrom: aPoint to: anotherPoint

	((aPoint eightNeighbors includes: anotherPoint) or: (aPoint = anotherPoint ))ifFalse: [^self error: self class distanceIsGreaterThanOne ].
	(anotherPoint between: 1@1 and: 3@3 )ifFalse: [^self error: self class outOfBoundsErrorDescription ].
	state movePieceFrom: aPoint to: anotherPoint in: self.
	self checkForAWinner.! !

!TerniLapili methodsFor: 'pieces-moving' stamp: 'A.G. 11/7/2018 17:53:23'!
moveWhitePieceFrom: aPoint to: anotherPoint

	(tablero at: aPoint) explodeIfEmpty.
	(tablero at: anotherPoint) explodeIfOccupied.
	(tablero at: aPoint) explodeIfBlack.
	
	tablero at: aPoint put: Vacio new.
	tablero at: anotherPoint put: Blanco new.
	
	state _ state nextFor: self.! !


!TerniLapili methodsFor: 'pieces-checking' stamp: 'A.G. 11/7/2018 17:28:25'!
checkWinningLine:aPointCollection

	^aPointCollection allSatisfy: [:aPoint | ((tablero at: aPoint) sameColourAs: (tablero at:(aPointCollection first))) and: ((tablero at: aPoint) isEmpty) not].! !

!TerniLapili methodsFor: 'pieces-checking' stamp: 'A.G. 11/7/2018 16:05:47'!
hasAPieceAt: aPoint 
	
	^(tablero at: aPoint) isEmpty not! !

!TerniLapili methodsFor: 'pieces-checking' stamp: 'A.G. 11/5/2018 20:32:25'!
pieceAt: aPoint 
	
	^tablero at: aPoint ! !

!TerniLapili methodsFor: 'pieces-checking' stamp: 'das 11/6/2018 17:24:18'!
totalPieces
	|result |
	result := 0 .
	tablero do:[:anElement| result := result + anElement contabilizar . result].
	^result .! !


!TerniLapili methodsFor: 'game-checking' stamp: 'A.G. 11/7/2018 17:29:32'!
checkForAWinner

#(1 2 3) do: [:a | (self checkWinningLine: (OrderedCollection with: a@1 with: a@2 with: a@3)) ifTrue: [^state := (tablero at: a@1) declareWinner] ].

#(1 2 3) do: [:a | (self checkWinningLine:  (OrderedCollection with: 1@a with: 2@a with: 3@a)) ifTrue: [^state := (tablero at: 1@a) declareWinner] ]. 

(self checkWinningLine: (OrderedCollection with: 1@1 with: 2@2 with: 3@3)) ifTrue: [state := (tablero at: 1@1) declareWinner]. 
 
(self checkWinningLine: (OrderedCollection with: 1@3 with: 2@2 with: 3@1)) ifTrue: [state := (tablero at: 1@3) declareWinner]. ! !

!TerniLapili methodsFor: 'game-checking' stamp: 'das 11/6/2018 17:12:37'!
hasAWinner

	^ state hasWinner .! !

!TerniLapili methodsFor: 'game-checking' stamp: 'das 11/6/2018 19:00:22'!
nextPlayer
	
	^ state player ! !

!TerniLapili methodsFor: 'game-checking' stamp: 'das 11/6/2018 17:52:59'!
winner

	^ state winner! !


!TerniLapili methodsFor: 'initialization' stamp: 'das 11/6/2018 17:53:36'!
initialize

	tablero _ Array2D width: 3 height: 3.
	tablero replaceValues: [:i :j : previous | Vacio new].
	state _ PuttingPieceStateBlack new.! !

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

!TerniLapiliState methodsFor: 'game-checking' stamp: 'das 11/6/2018 17:06:54'!
hasWinner

	^ self subclassResponsibility .! !

!TerniLapiliState methodsFor: 'game-checking' stamp: 'das 11/6/2018 17:07:09'!
winner

	^ self subclassResponsibility .! !


!TerniLapiliState methodsFor: 'game-moving' stamp: 'das 11/6/2018 17:07:34'!
movePieceFrom:aPosition to:anotherPosition

	^ self subclassResponsibility .! !


!TerniLapiliState methodsFor: 'game-adding' stamp: 'das 11/6/2018 17:07:57'!
putPieceAt:aPosition

	^ self subclassResponsibility .! !


!classDefinition: #GameFinishedState category: #'TerniLapilli-Ejercicio'!
TerniLapiliState subclass: #GameFinishedState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!GameFinishedState methodsFor: 'game-checking' stamp: 'das 11/6/2018 17:03:48'!
hasWinner

	^ true! !

!GameFinishedState methodsFor: 'game-checking' stamp: 'das 11/8/2018 16:13:01'!
player

	^ self subclassResponsibility ! !


!GameFinishedState methodsFor: 'invalid-actions' stamp: 'A.G. 11/7/2018 17:37:54'!
addPiece: aPoint in:aGame

	^ self error: TerniLapili gameOverErrorDescription ! !

!GameFinishedState methodsFor: 'invalid-actions' stamp: 'A.G. 11/7/2018 17:47:30'!
movePieceFrom: aPoint to: anotherPoint in: aGame

	^self error: TerniLapili gameOverErrorDescription ! !


!classDefinition: #GameFinishedStateBlackWon category: #'TerniLapilli-Ejercicio'!
GameFinishedState subclass: #GameFinishedStateBlackWon
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!GameFinishedStateBlackWon methodsFor: 'game-checking' stamp: 'das 11/6/2018 18:54:47'!
player

	^ Negro new! !

!GameFinishedStateBlackWon methodsFor: 'game-checking' stamp: 'A.G. 11/7/2018 17:35:18'!
winner

	^Negro new! !


!classDefinition: #GameFinishedStateWhiteWon category: #'TerniLapilli-Ejercicio'!
GameFinishedState subclass: #GameFinishedStateWhiteWon
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!GameFinishedStateWhiteWon methodsFor: 'game-checking' stamp: 'das 11/6/2018 18:54:32'!
player

	^ Blanco new! !

!GameFinishedStateWhiteWon methodsFor: 'game-checking' stamp: 'A.G. 11/7/2018 17:35:06'!
winner

	^Blanco new! !


!classDefinition: #MovingPiecesState category: #'TerniLapilli-Ejercicio'!
TerniLapiliState subclass: #MovingPiecesState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!MovingPiecesState methodsFor: 'game-checking' stamp: 'das 11/6/2018 17:03:56'!
hasWinner
	^ false! !


!MovingPiecesState methodsFor: 'game-adding' stamp: 'das 11/6/2018 18:41:10'!
addPiece: aPoint in:aGame

	^ self error: TerniLapili cantidadDeFichasIgualesErrorDescription ! !


!MovingPiecesState methodsFor: 'game-moving' stamp: 'das 11/8/2018 16:16:41'!
movePieceFrom: aPoint to: anotherPoint in: aGame

	^ self subclassResponsibility ! !

!MovingPiecesState methodsFor: 'game-moving' stamp: 'das 11/8/2018 16:17:47'!
nextFor:aGame

	^ self subclassResponsibility ! !


!MovingPiecesState methodsFor: 'game-player' stamp: 'das 11/8/2018 16:17:19'!
player

	^ self subclassResponsibility ! !


!classDefinition: #MovingPiecesStateBlack category: #'TerniLapilli-Ejercicio'!
MovingPiecesState subclass: #MovingPiecesStateBlack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!MovingPiecesStateBlack methodsFor: 'game-moving' stamp: 'das 11/6/2018 18:46:18'!
movePieceFrom: aPoint to: anotherPoint in: aGame

	aGame moveBlackPieceFrom: aPoint to: anotherPoint.! !

!MovingPiecesStateBlack methodsFor: 'game-moving' stamp: 'das 11/6/2018 18:55:48'!
nextFor:aGame

	^ MovingPiecesStateWhite new! !


!MovingPiecesStateBlack methodsFor: 'game-player' stamp: 'das 11/6/2018 18:54:40'!
player

	^ Negro new! !


!classDefinition: #MovingPiecesStateWhite category: #'TerniLapilli-Ejercicio'!
MovingPiecesState subclass: #MovingPiecesStateWhite
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!MovingPiecesStateWhite methodsFor: 'game-moving' stamp: 'das 11/6/2018 18:46:33'!
movePieceFrom: aPoint to: anotherPoint in: aGame

	aGame moveWhitePieceFrom: aPoint to: anotherPoint.! !

!MovingPiecesStateWhite methodsFor: 'game-moving' stamp: 'das 11/6/2018 18:56:09'!
nextFor:aGame

	^MovingPiecesStateBlack new! !


!MovingPiecesStateWhite methodsFor: 'game-player' stamp: 'das 11/6/2018 18:54:24'!
player

	^ Blanco new! !


!classDefinition: #PuttingPieceState category: #'TerniLapilli-Ejercicio'!
TerniLapiliState subclass: #PuttingPieceState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!PuttingPieceState methodsFor: 'gaming protocol' stamp: 'das 11/6/2018 17:54:12'!
addPiece: aPoint 

	^ self subclassResponsibility ! !

!PuttingPieceState methodsFor: 'gaming protocol' stamp: 'das 11/6/2018 17:04:03'!
hasWinner

	^ false! !

!PuttingPieceState methodsFor: 'gaming protocol' stamp: 'das 11/8/2018 15:59:47'!
movePieceFrom: aPoint to: anotherPoint in: aGame

	^self error: TerniLapili cantidadDeFichasMenorA6ErrorDescription ! !

!PuttingPieceState methodsFor: 'gaming protocol' stamp: 'das 11/8/2018 15:58:51'!
nextFor:aGame

	^ self subclassResponsibility ! !


!classDefinition: #PuttingPieceStateBlack category: #'TerniLapilli-Ejercicio'!
PuttingPieceState subclass: #PuttingPieceStateBlack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!PuttingPieceStateBlack methodsFor: 'gaming protocol' stamp: 'das 11/6/2018 18:07:35'!
addPiece:aPosition in:aTerniLapili

	aTerniLapili addBlackPieceAt: aPosition! !

!PuttingPieceStateBlack methodsFor: 'gaming protocol' stamp: 'das 11/6/2018 18:31:13'!
nextFor:aGame

	^ (aGame totalPieces =6) ifTrue: [^ MovingPiecesStateWhite new] ifFalse:[^PuttingPieceStateWhite new] ! !

!PuttingPieceStateBlack methodsFor: 'gaming protocol' stamp: 'das 11/6/2018 18:53:38'!
player

	^Negro new! !


!classDefinition: #PuttingPieceStateWhite category: #'TerniLapilli-Ejercicio'!
PuttingPieceState subclass: #PuttingPieceStateWhite
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!PuttingPieceStateWhite methodsFor: 'gaming protocol' stamp: 'das 11/6/2018 18:24:48'!
addPiece:aPosition in:aTerniLapili

	aTerniLapili addWhitePieceAt: aPosition! !

!PuttingPieceStateWhite methodsFor: 'gaming protocol' stamp: 'das 11/6/2018 18:36:51'!
nextFor:aGame

	^ (aGame totalPieces =6) ifTrue: [^ MovingPiecesStateBlack new] ifFalse:[^PuttingPieceStateBlack new] ! !

!PuttingPieceStateWhite methodsFor: 'gaming protocol' stamp: 'das 11/6/2018 18:54:11'!
player

^Blanco new! !
