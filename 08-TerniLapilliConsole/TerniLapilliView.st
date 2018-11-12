!classDefinition: #TerniLapilliBoardViewTest category: #TerniLapilliView!
TestCase subclass: #TerniLapilliBoardViewTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliView'!

!TerniLapilliBoardViewTest methodsFor: 'testing' stamp: 'LE 11/12/2018 16:24:41'!
test01_ANewBoardIsEmpty

	| board game |
	game _ TerniLapilli new.
	board _ TerniLapilliBoardView for: game.
	
	self assert: 6 equals: board lines size.
	self assert: ' | | ' equals: (board lines at:1).
	self assert: '-----' equals: (board lines at:2).
	self assert: ' | | ' equals: (board lines at:3).
	self assert: '-----' equals: (board lines at:4).
	self assert: ' | | ' equals: (board lines at:5).
	self assert:'Estado Jugando: X' equals: (board lines at:6)! !

!TerniLapilliBoardViewTest methodsFor: 'testing' stamp: 'LE 11/12/2018 16:31:58'!
test02_WhenXPutsAPieceApiecesAppearsOnBoard

	| board game |
	game _ TerniLapilli new.
	board _ TerniLapilliBoardView for: game.
	game register: board.
	game putXAt: 2@2.
	self assert: 6 equals: board lines size.
	self assert: ' | | ' equals: (board lines at:1).
	self assert: '-----' equals: (board lines at:2).
	self assert: ' |X| ' equals: (board lines at:3).
	self assert: '-----' equals: (board lines at:4).
	self assert: ' | | ' equals: (board lines at:5).
	self assert:'Estado Jugando: O' equals: (board lines at:6)! !


!classDefinition: #TerniLapilliConsoleLogTest category: #TerniLapilliView!
TestCase subclass: #TerniLapilliConsoleLogTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliView'!

!TerniLapilliConsoleLogTest methodsFor: 'test support' stamp: 'A.G. 11/10/2018 18:58:10'!
putPieces:aCollectionOfPieces in:aGame

	aCollectionOfPieces do: [:aPosition | (aGame isPlacingX) ifTrue: [ aGame putXAt: aPosition ] ifFalse: [ aGame putOAt: aPosition ] ].! !


!TerniLapilliConsoleLogTest methodsFor: 'testing' stamp: 'A.G. 11/10/2018 20:55:33'!
test01_XPutsAppersOnLog

	|game console|
	game _ TerniLapilli new.
	console _ TerniLapilliConsoleLog for:game.
	game register: console.
	game putXAt: 2@2.
	self assert: 2 equals: console lines size.
	self assert:'X marcó en 2@2'  equals:(console lines at:1).
	self assert:'Estado: Jugando O' equals:(console lines at:2). 
! !

!TerniLapilliConsoleLogTest methodsFor: 'testing' stamp: 'A.G. 11/10/2018 21:08:07'!
test02_OPutsAppersOnLog

	|game console|
	game _ TerniLapilli new.
	console _ TerniLapilliConsoleLog for:game.
	game register: console .
	game putXAt: 2@2.
	game putOAt: 1@1.

	self assert: 4 equals: console lines size.
	self assert:'X marcó en 2@2'  equals:(console lines at:1).
	self assert:'Estado: Jugando O' equals:(console lines at:2).
	self assert:'O marcó en 1@1' equals: (console lines at:3).
	self assert:'Estado: Jugando X' equals:(console lines at:4)
! !

!TerniLapilliConsoleLogTest methodsFor: 'testing' stamp: 'A.G. 11/10/2018 20:55:59'!
test03_XWinsTheGame

	|game console jugadas|
	game _ TerniLapilli new.
	console _ TerniLapilliConsoleLog for:game.
	game register: console ..
	jugadas _ OrderedCollection with:2@2 with:1@1 with:1@3 with:1@2 with:3@1.
	self putPieces: jugadas in:game.
	self assert: 10 equals:console lines size.
	self assert:'Estado: Juego terminado - ¡Ganó X!!' equals: (console lines at:10)
	! !

!TerniLapilliConsoleLogTest methodsFor: 'testing' stamp: 'A.G. 11/10/2018 20:56:05'!
test04_OWinsTheGame

	|game console jugadas|
	game _ TerniLapilli new.
	console _ TerniLapilliConsoleLog for:game.
	game register: console ..
	jugadas _ OrderedCollection with:1@1 with:2@2 with:1@3 with:2@3 with:3@1 with:2@1.
	self putPieces: jugadas in:game.
	self assert: 12 equals:console lines size.
	self assert:'Estado: Juego terminado - ¡Ganó O!!' equals: (console lines at:12)
	! !

!TerniLapilliConsoleLogTest methodsFor: 'testing' stamp: 'A.G. 11/10/2018 21:39:15'!
test05_SlidingAppearsOnLog

	|game console jugadas|
	game _ TerniLapilli new.
	console _ TerniLapilliConsoleLog for:game.
	game register: console ..
	jugadas _ OrderedCollection with:2@2.
	jugadas add:1@1;add:1@3 ; add:3@1;add:2@1;add:2@3;yourself.
	self putPieces: jugadas in:game.
	game slideXFrom: 1@3 to:1@2. 
	game slideOFrom:3@1  to:3@2. 
	game slideXFrom: 2@2 to:3@3. 
	self assert: 18 equals:console lines size.
	self assert:'X deslizó hasta 1@2 desde 1@3' equals: (console lines at:13).
	self assert:'Estado: Jugando O' equals:(console lines at:14).
	self assert:'O deslizó hasta 3@2 desde 3@1' equals: (console lines at:15).
	self assert:'Estado: Jugando X' equals:(console lines at:16)
	! !


!classDefinition: #TerniLapilliBoardView category: #TerniLapilliView!
Object subclass: #TerniLapilliBoardView
	instanceVariableNames: 'game tablero state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliView'!

!TerniLapilliBoardView methodsFor: 'accessing' stamp: 'LE 11/12/2018 16:23:17'!
lines
|lines line|

	lines := OrderedCollection new.
	1 to: 3 do: [ :i |
		line := String new.
		1 to: 3 do: [ :j |
			line := line , (tablero at: (i@j)).
			line := line , '|'.].
		line := line allButLast .
		lines add: line.	
		lines add: '-----'.
	].
	lines removeLast.
	lines add:state.
	^ lines! !

!TerniLapilliBoardView methodsFor: 'accessing' stamp: 'LE 11/12/2018 16:57:32'!
logPlay: aTerniLapiliPlay

	| xIndex oIndex |

	xIndex _ aTerniLapiliPlay indexOf: $X ifAbsent: [xIndex _ 0. oIndex _ aTerniLapiliPlay indexOf: $O ifAbsent: [0] ].
	
	(xIndex = 22) ifTrue: [self putXAsIn: aTerniLapiliPlay ].
	(xIndex = 18) ifTrue: [self slideXAsIn: aTerniLapiliPlay ].
	
	
	(oIndex = 22) ifTrue: [self putOAsIn: aTerniLapiliPlay ].
	(oIndex = 18) ifTrue: [self slideOAsIn: aTerniLapiliPlay ].! !

!TerniLapilliBoardView methodsFor: 'accessing' stamp: 'LE 11/12/2018 16:42:58'!
logState: aTerniLapiliState 
	
	aTerniLapiliState accept:self.! !

!TerniLapilliBoardView methodsFor: 'accessing' stamp: 'A.G. 11/10/2018 22:11:32'!
placeOIn:aPoint

	tablero at: aPoint put: 'O'! !

!TerniLapilliBoardView methodsFor: 'accessing' stamp: 'A.G. 11/10/2018 22:11:26'!
placeXIn:aPoint

	tablero at: aPoint put: 'X'! !

!TerniLapilliBoardView methodsFor: 'accessing' stamp: 'LE 11/12/2018 17:00:50'!
putOAsIn:aString

	| startingPoint |
	startingPoint _ (aString copyFrom: 27 to: 29).
	self placeOIn: (startingPoint at:1 numericValue ) @ (startingPoint at:3 numericValue )   .! !

!TerniLapilliBoardView methodsFor: 'accessing' stamp: 'LE 11/12/2018 17:00:56'!
putXAsIn:aString

	| startingPoint |
	startingPoint _ (aString copyFrom: 27 to: 29).
	self placeXIn: (startingPoint at:1  ) numericValue @ (startingPoint at:3  ) numericValue  .! !

!TerniLapilliBoardView methodsFor: 'accessing' stamp: 'LE 11/12/2018 17:01:06'!
slideOAsIn:aString

	| startingPoint destinationPoint |
	
	startingPoint _ (aString copyFrom: 34 to: 36).
		destinationPoint _ (aString copyFrom: 25 to: 27).
		self slideOFrom: (startingPoint at:1 numericValue )@ (startingPoint at:3 numericValue ) to: (destinationPoint at:1 numericValue ) @ (destinationPoint at:3 numericValue )! !

!TerniLapilliBoardView methodsFor: 'accessing' stamp: 'A.G. 11/10/2018 22:10:48'!
slideOFrom: aPoint to: anotherPoint

	tablero at: aPoint put: ' '.
	tablero at: anotherPoint put: 'O'.! !

!TerniLapilliBoardView methodsFor: 'accessing' stamp: 'LE 11/12/2018 17:01:14'!
slideXAsIn:aString

	| startingPoint destinationPoint |
	
	startingPoint _ (aString copyFrom: 34 to: 36).
		destinationPoint _ (aString copyFrom: 25 to: 27).
		self slideXFrom: (startingPoint at:1 numericValue )@ (startingPoint at:3 numericValue ) to: (destinationPoint at:1 numericValue ) @ (destinationPoint at:3 numericValue )! !

!TerniLapilliBoardView methodsFor: 'accessing' stamp: 'A.G. 11/10/2018 22:10:40'!
slideXFrom: aPoint to: anotherPoint

	tablero at: aPoint put: ' '.
	tablero at: anotherPoint put: 'X'.! !


!TerniLapilliBoardView methodsFor: 'initialization' stamp: 'LE 11/12/2018 16:23:39'!
initializeWith: aTerniLapilli 
	game _ aTerniLapilli .
	tablero _ Array2D width: 3 height:3. 
	tablero replaceValues: [:i :j : previous | ' '].
	state _ 'Estado Jugando: X'! !


!TerniLapilliBoardView methodsFor: 'observing' stamp: 'LE 11/12/2018 16:32:09'!
notify
	
	self logPlay: game lastPlay.
	self logState: game state.! !


!TerniLapilliBoardView methodsFor: 'visiting' stamp: 'LE 11/12/2018 16:47:18'!
visitPlacingO

	state _ 'Playing O'! !

!TerniLapilliBoardView methodsFor: 'visiting' stamp: 'LE 11/12/2018 16:47:08'!
visitPlacingX

	state _ 'Playing X'! !

!TerniLapilliBoardView methodsFor: 'visiting' stamp: 'LE 11/12/2018 16:47:29'!
visitSlidingO

	state _ 'Playing O'! !

!TerniLapilliBoardView methodsFor: 'visiting' stamp: 'LE 11/12/2018 16:47:01'!
visitSlidingX

	state _ 'Playing X'! !

!TerniLapilliBoardView methodsFor: 'visiting' stamp: 'LE 11/12/2018 16:48:04'!
visitWinningO
	state _ 'O Won!!'! !

!TerniLapilliBoardView methodsFor: 'visiting' stamp: 'LE 11/12/2018 16:48:07'!
visitWinningX
	state _ 'X Won!!'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliBoardView class' category: #TerniLapilliView!
TerniLapilliBoardView class
	instanceVariableNames: ''!

!TerniLapilliBoardView class methodsFor: 'initialization' stamp: 'A.G. 11/10/2018 21:53:10'!
for: aTerniLapilli 
	^ self new initializeWith: aTerniLapilli .! !


!classDefinition: #TerniLapilliConsoleLog category: #TerniLapilliView!
Object subclass: #TerniLapilliConsoleLog
	instanceVariableNames: 'game lines'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliView'!

!TerniLapilliConsoleLog methodsFor: 'initialization' stamp: 'das 11/8/2018 19:48:27'!
initializeWith: aTerniLapilli 
	game _ aTerniLapilli .
	lines _ OrderedCollection new.! !


!TerniLapilliConsoleLog methodsFor: 'accessing' stamp: 'das 11/8/2018 19:48:11'!
lines
	
	^ lines! !


!TerniLapilliConsoleLog methodsFor: 'observing' stamp: 'A.G. 11/10/2018 19:25:52'!
notify
	
	self logPlay: game lastPlay.
	self logState: game state.! !


!TerniLapilliConsoleLog methodsFor: 'logging' stamp: 'A.G. 11/10/2018 21:38:38'!
logPlay: aTerniLapiliPlay

	| playString xIndex oIndex |

	xIndex _ aTerniLapiliPlay indexOf: $X ifAbsent: [xIndex _ 0. oIndex _ aTerniLapiliPlay indexOf: $O ifAbsent: [0] ].
	
	(xIndex = 22) ifTrue: [playString _ 'X marcó en ', (aTerniLapiliPlay copyFrom: 27 to: 29)].
	(xIndex = 18) ifTrue: [playString _ 'X deslizó hasta ', (aTerniLapiliPlay copyFrom: 34 to: 36), ' desde ', (aTerniLapiliPlay copyFrom: 25 to: 27)].
	
	
	(oIndex = 22) ifTrue: [playString _ 'O marcó en ', (aTerniLapiliPlay copyFrom: 27 to: 29)].
	(oIndex = 18) ifTrue: [playString _ 'O deslizó hasta ', (aTerniLapiliPlay copyFrom: 34 to: 36), ' desde ', (aTerniLapiliPlay copyFrom: 25 to: 27)].
	
	lines add: playString.! !

!TerniLapilliConsoleLog methodsFor: 'logging' stamp: 'LE 11/12/2018 15:20:32'!
logState: aTerniLapiliState 
	
	aTerniLapiliState accept:self.! !


!TerniLapilliConsoleLog methodsFor: 'visiting' stamp: 'LE 11/12/2018 15:24:58'!
visitPlacingO
	lines add:'Estado: Jugando O'.! !

!TerniLapilliConsoleLog methodsFor: 'visiting' stamp: 'LE 11/12/2018 15:24:08'!
visitPlacingX
	lines add:'Estado: Jugando X'.! !

!TerniLapilliConsoleLog methodsFor: 'visiting' stamp: 'LE 11/12/2018 15:30:46'!
visitSlidingO
	lines add:'Estado: Jugando O'! !

!TerniLapilliConsoleLog methodsFor: 'visiting' stamp: 'LE 11/12/2018 15:30:28'!
visitSlidingX
	lines add:'Estado: Jugando X'! !

!TerniLapilliConsoleLog methodsFor: 'visiting' stamp: 'LE 11/12/2018 15:29:48'!
visitWinningO
	lines add:'Estado: Juego terminado - ¡Ganó O!!'! !

!TerniLapilliConsoleLog methodsFor: 'visiting' stamp: 'LE 11/12/2018 15:29:09'!
visitWinningX
	lines add: 'Estado: Juego terminado - ¡Ganó X!!'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliConsoleLog class' category: #TerniLapilliView!
TerniLapilliConsoleLog class
	instanceVariableNames: ''!

!TerniLapilliConsoleLog class methodsFor: 'initialization' stamp: 'das 11/8/2018 19:40:17'!
for: aTerniLapilli 
	^ self new initializeWith: aTerniLapilli .! !
