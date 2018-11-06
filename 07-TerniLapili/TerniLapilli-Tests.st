!classDefinition: #TerniLapilliTesting category: #'TerniLapilli-Tests'!
TestCase subclass: #TerniLapilliTesting
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Tests'!

!TerniLapilliTesting methodsFor: 'Testing' stamp: 'A.G. 11/5/2018 21:22:31'!
test01_newGameIsEmpty

	| game |
	game := TerniLapili new.
	
	self assert: game totalPieces equals:0.
	self deny: game hasAWinner .
	! !

!TerniLapilliTesting methodsFor: 'Testing' stamp: 'A.G. 11/5/2018 19:34:12'!
test02_puttingAPieceIncreasesTotalPieces

	| game |
	game := TerniLapili new.
	
	game addPiece: (2@2).
		
	self assert: (game totalPieces = 1).! !

!TerniLapilliTesting methodsFor: 'Testing' stamp: 'A.G. 11/5/2018 19:38:56'!
test03_aPiecePutAtAPointIsAtThatPoint

	| game |
	game := TerniLapili new.
	
	game addPiece: 2@2.
	
	self assert: (game hasAPieceAt: 2@2).
	self assert: game totalPieces equals: 1.
! !

!TerniLapilliTesting methodsFor: 'Testing' stamp: 'A.G. 11/5/2018 19:42:39'!
test04_canNotPlacePieceInAnAlreadyOccuppiedPosition

	| game |
	game := TerniLapili new.
	game addPiece: (2@2).
	self should: [ game addPiece: (2@2).] 
	raise: Error
	withExceptionDo: [:anError |
		self assert: anError messageText equals: TerniLapili superposicionDeFichasErrorDescription].
	! !

!TerniLapilliTesting methodsFor: 'Testing' stamp: 'A.G. 11/5/2018 20:53:44'!
test05_canNotAddMoreThan6Pieces

	| game pieces|
	pieces := (OrderedCollection new) add: 1@1; add:1@2; add:1@3; add: 2@1; add:2@2; add:2@3; yourself .
	game := TerniLapili new.
	self addPieces:pieces  to:game .
		
	self should: [game addPiece: (3@1).] 
	raise: Error
	withExceptionDo: [:anError |
		self assert: anError messageText equals: TerniLapili  cantidadDeFichasIgualesErrorDescription ].
	! !

!TerniLapilliTesting methodsFor: 'Testing' stamp: 'A.G. 11/5/2018 20:57:31'!
test06_canNotMoveAPieceWithLessThan6PiecesOnTheGameBoard

	| game pieces|
	pieces := OrderedCollection with: 1@1 with: 1@2.
	game := TerniLapili new.
	self addPieces:pieces to:game .

	self should: [game movePieceFrom: 1@1 to: 2@1.] 
	raise: Error
	withExceptionDo: [:anError |
		self assert: anError messageText equals: TerniLapili  cantidadDeFichasMenorA6ErrorDescription ].
	! !

!TerniLapilliTesting methodsFor: 'Testing' stamp: 'A.G. 11/5/2018 20:03:10'!
test07_canMoveAPiece

	| game pieces|
	pieces := (OrderedCollection new) add: 1@1; add:1@2; add:1@3; add: 2@1; add:2@2; add:2@3; yourself .
	game := TerniLapili new.
	self addPieces:pieces  to:game .
	game movePieceFrom:2@2 to: 3@2.
	self assert: game totalPieces equals: 6.
	self assert: (game hasAPieceAt: 3@2).
	self deny: (game hasAPieceAt: 2@2).! !

!TerniLapilliTesting methodsFor: 'Testing' stamp: 'A.G. 11/5/2018 20:35:02'!
test08_cannotMoveAPieceOfAnotherPlayer

	| game pieces|
	pieces := (OrderedCollection new) add: 1@1; add:1@2; add:1@3; add: 2@1; add:2@2; add:2@3; yourself .
	game := TerniLapili new.
	self addPieces:pieces to:game .
	self should: [game movePieceFrom: 2@3 to: 3@3] 
	raise: Error 
	withExceptionDo: [:anError |
		self assert: anError messageText equals: TerniLapili turnoEquivocadoErrorDescription .
		self assert: game totalPieces equals:6. 
		self deny: ((game pieceAt: 2@3) = game nextPlayer).
		].! !

!TerniLapilliTesting methodsFor: 'Testing' stamp: 'A.G. 11/5/2018 20:36:11'!
test09_cannotMoveAPieceToAOccupiedPosition

	| game pieces|
	pieces := (OrderedCollection new) add: 1@1; add:1@2; add:1@3; add: 2@1; add:2@2; add:2@3; yourself .
	game := TerniLapili new.
	self addPieces:pieces to:game .
	self should: [game movePieceFrom: 1@1 to: 1@2] 
	raise: Error 
	withExceptionDo: [:anError |
		self assert: anError messageText equals: TerniLapili superposicionDeFichasErrorDescription.
		self assert: game totalPieces equals:6. 
		self assert: (game pieceAt: 1@1) equals: game nextPlayer.
		].! !

!TerniLapilliTesting methodsFor: 'Testing' stamp: 'A.G. 11/5/2018 20:38:40'!
test10_cannotMoveAPieceToANotAdjacentPosition

	| game pieces|
	pieces := (OrderedCollection new) add: 1@1; add:1@2; add:1@3; add: 2@1; add:2@2; add:2@3; yourself .
	game := TerniLapili new.
	self addPieces:pieces to:game .
	self should: [game movePieceFrom: 1@1 to: 3@3] 
	raise: Error 
	withExceptionDo: [:anError |
		self assert: anError messageText equals: TerniLapili distanceIsGreaterThanOne.
		self assert: game totalPieces equals:6. 
		self assert: (game pieceAt: 1@1) equals: game nextPlayer.
		].! !

!TerniLapilliTesting methodsFor: 'Testing' stamp: 'A.G. 11/5/2018 20:45:40'!
test11_cannotMoveAPieceToAPositionOutsideTable

	| game pieces|
	pieces := (OrderedCollection new) add: 1@1; add:1@2; add:1@3; add: 2@1; add:2@3; add:2@2; yourself .
	game := TerniLapili new.
	self addPieces:pieces to:game .
	self should: [game movePieceFrom: 2@3 to: 2@4] 
	raise: Error 
	withExceptionDo: [:anError |
		self assert: anError messageText equals: TerniLapili outOfBoundsErrorDescription.
		self assert: game totalPieces equals:6. 
		self assert: (game pieceAt: 2@3) equals: game nextPlayer.
		].! !

!TerniLapilliTesting methodsFor: 'Testing' stamp: 'A.G. 11/5/2018 21:41:57'!
test12_horizontalLinesWinTheGame

	| game pieces|
	pieces := (OrderedCollection new) add: 1@1; add:2@1; add:1@2; add: 2@2; yourself .
	game := TerniLapili new.
	self addPieces:pieces to:game .
	game addPiece: 1@3.
	self assert: game hasAWinner.! !

!TerniLapilliTesting methodsFor: 'Testing' stamp: 'A.G. 11/5/2018 21:43:07'!
test13_verticalLinesWinTheGame

	| game pieces|
	pieces := (OrderedCollection new) add: 1@1; add:1@2; add:2@1; add: 2@2; yourself .
	game := TerniLapili new.
	self addPieces:pieces to:game .
	game addPiece: 3@1.
	self assert: game hasAWinner.! !

!TerniLapilliTesting methodsFor: 'Testing' stamp: 'A.G. 11/5/2018 21:45:06'!
test14_diagonalLinesWinTheGame

	| game pieces|
	pieces := (OrderedCollection new) add: 1@1; add:1@2; add:2@2; add: 2@1; yourself .
	game := TerniLapili new.
	self addPieces:pieces to:game .
	game addPiece: 3@3.
	self assert: game hasAWinner.! !

!TerniLapilliTesting methodsFor: 'Testing' stamp: 'A.G. 11/6/2018 16:16:58'!
test15_canTellWhoTheWinnerIs

	| game pieces|
	pieces := (OrderedCollection new) add: 1@1; add:1@2; add:2@2; add: 2@1; yourself .
	game := TerniLapili new.
	self addPieces:pieces to:game .
	game addPiece: 3@3.
	self assert: game winner equals: Color black.! !

!TerniLapilliTesting methodsFor: 'Testing' stamp: 'A.G. 11/6/2018 16:20:40'!
test16_cannotMoveWhenTheGameIsFinished

	| game pieces|
	pieces := (OrderedCollection new) add: 1@1; add:1@2; add:2@2; add: 2@1; yourself .
	game := TerniLapili new.
	self addPieces:pieces to:game .
	game addPiece: 3@3.
	self assert: game winner equals: Color black.
	self should: [game addPiece: 2@3] 
	raise: Error 
	withExceptionDo: [:anError | self assert: anError messageText equals: TerniLapili gameOverErrorDescription]! !


!TerniLapilliTesting methodsFor: 'test-support' stamp: 'A.G. 11/5/2018 19:45:11'!
addPieces:aCollectionOfPieces to: aGame

	aCollectionOfPieces do:[:current | aGame addPiece: current ].! !
