!classDefinition: #TerniLapilliBoardViewTest category: #TerniLapilliView!
TestCase subclass: #TerniLapilliBoardViewTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliView'!

!TerniLapilliBoardViewTest methodsFor: 'testing' stamp: 'A.G. 11/10/2018 22:16:12'!
test01_ANewBoardIsEmpty

	| board game |
	game _ TerniLapilli new.
	board _ TerniLapilliBoardView for: game.
	
	self assert: 5 equals: board lines size.! !


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

!TerniLapilliBoardView methodsFor: 'accessing' stamp: 'A.G. 11/10/2018 22:18:26'!
lines

	^tablero print! !

!TerniLapilliBoardView methodsFor: 'accessing' stamp: 'A.G. 11/10/2018 22:09:45'!
logPlay: aTerniLapiliPlay

	| startingPoint destinationPoint xIndex oIndex |

	xIndex _ aTerniLapiliPlay indexOf: $X ifAbsent: [xIndex _ 0. oIndex _ aTerniLapiliPlay indexOf: $O ifAbsent: [0] ].
	
	(xIndex = 22) ifTrue: [startingPoint _ (aTerniLapiliPlay copyFrom: 27 to: 29).
		self placeXIn: startingPoint. ].
	(xIndex = 18) ifTrue: [startingPoint _ (aTerniLapiliPlay copyFrom: 34 to: 36).
		destinationPoint _ (aTerniLapiliPlay copyFrom: 25 to: 27).
		self slideXFrom: startingPoint to: destinationPoint].
	
	
	(oIndex = 22) ifTrue: [startingPoint _ (aTerniLapiliPlay copyFrom: 27 to: 29).
		self placeOIn: startingPoint. ].
	(oIndex = 18) ifTrue: [startingPoint _ (aTerniLapiliPlay copyFrom: 34 to: 36).
		destinationPoint _ (aTerniLapiliPlay copyFrom: 25 to: 27).
		self slideOFrom: startingPoint to: destinationPoint].! !

!TerniLapilliBoardView methodsFor: 'accessing' stamp: 'A.G. 11/10/2018 22:13:01'!
logState: aTerniLapiliState 
	
	| stateString |

	((aTerniLapiliState isKindOf: PlacingX) or: (aTerniLapiliState isKindOf: SlidingX) ) ifTrue: [stateString  _ 'Playing X'].
	((aTerniLapiliState isKindOf: PlacingO) or: (aTerniLapiliState isKindOf: SlidingO) ) ifTrue: [stateString  _ 'Playing O'].
	(aTerniLapiliState isKindOf: WinningX ) ifTrue: [stateString  _ 'X Won!!'].
	(aTerniLapiliState isKindOf: WinningO) ifTrue: [stateString  _ 'O Won!!'].
		
	state _ stateString.! !

!TerniLapilliBoardView methodsFor: 'accessing' stamp: 'A.G. 11/10/2018 22:11:32'!
placeOIn:aPoint

	tablero at: aPoint put: 'O'! !

!TerniLapilliBoardView methodsFor: 'accessing' stamp: 'A.G. 11/10/2018 22:11:26'!
placeXIn:aPoint

	tablero at: aPoint put: 'X'! !

!TerniLapilliBoardView methodsFor: 'accessing' stamp: 'A.G. 11/10/2018 22:10:48'!
slideOFrom: aPoint to: anotherPoint

	tablero at: aPoint put: ' '.
	tablero at: anotherPoint put: 'O'.! !

!TerniLapilliBoardView methodsFor: 'accessing' stamp: 'A.G. 11/10/2018 22:10:40'!
slideXFrom: aPoint to: anotherPoint

	tablero at: aPoint put: ' '.
	tablero at: anotherPoint put: 'X'.! !


!TerniLapilliBoardView methodsFor: 'initialization' stamp: 'A.G. 11/10/2018 22:29:36'!
initializeWith: aTerniLapilli 
	game _ aTerniLapilli .
	tablero _ Array2D copyFrom: #($ ,$ ,$ ).
	state _ ''.! !


!TerniLapilliBoardView methodsFor: 'observing' stamp: 'A.G. 11/10/2018 21:52:01'!
notify
	
	self logPlay: game lastPlay.
	self logState: game state.! !

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

!TerniLapilliConsoleLog methodsFor: 'logging' stamp: 'A.G. 11/10/2018 21:19:37'!
logState: aTerniLapiliState 
	
	| stateString |

	((aTerniLapiliState isKindOf: PlacingX) or: (aTerniLapiliState isKindOf: SlidingX) ) ifTrue: [stateString  _ 'Estado: Jugando X'].
	((aTerniLapiliState isKindOf: PlacingO) or: (aTerniLapiliState isKindOf: SlidingO) ) ifTrue: [stateString  _ 'Estado: Jugando O'].
	(aTerniLapiliState isKindOf: WinningX ) ifTrue: [stateString  _ 'Estado: Juego terminado - ¡Ganó X!!'].
	(aTerniLapiliState isKindOf: WinningO) ifTrue: [stateString  _ 'Estado: Juego terminado - ¡Ganó O!!'].
		
	lines add: stateString.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliConsoleLog class' category: #TerniLapilliView!
TerniLapilliConsoleLog class
	instanceVariableNames: ''!

!TerniLapilliConsoleLog class methodsFor: 'initialization' stamp: 'das 11/8/2018 19:40:17'!
for: aTerniLapilli 
	^ self new initializeWith: aTerniLapilli .! !
