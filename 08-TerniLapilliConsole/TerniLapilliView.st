!classDefinition: #TerniLapilliConsoleLogTest category: #TerniLapilliView!
TestCase subclass: #TerniLapilliConsoleLogTest
	instanceVariableNames: 'state playerOPositions playerXPositions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliView'!

!TerniLapilliConsoleLogTest methodsFor: 'test support' stamp: 'das 11/8/2018 20:03:25'!
MarkingPieces:aCollectionOfPieces in:aGame

	aCollectionOfPieces do:[:aPosition | aGame MarkWith:aPosition ]
.! !


!TerniLapilliConsoleLogTest methodsFor: 'testing' stamp: 'das 11/8/2018 21:02:05'!
test01_XPutsAppersOnLog

	|game console|
	game _ TerniLapilli new.
	console _ TerniLapilliConsoleLog for:game.
	game console:console .
	.
	game putXAt: 2@2.
	self assert: 2 equals: console lines size.
	self assert:'X marco en 2@2'  equals:(console lines at:1).
	self assert:'Estado: Jugando O' equals:(console lines at:2). 
! !

!TerniLapilliConsoleLogTest methodsFor: 'testing' stamp: 'das 11/8/2018 21:02:21'!
test02_OPutsAppersOnLog

	|game console|
	game _ TerniLapilli new.
	console _ TerniLapilliConsoleLog for:game.
	game console: console .
	game putXAt: 2@2.
	game putOAt: 1@1.

	self assert: 4 equals: console lines size.
	self assert:'X marco en 2@2'  equals:(console lines at:1).
	self assert:'Estado: Jugando O' equals:(console lines at:2).
	self assert:'O marco en 1@1' equals: (console lines at:3).
	self assert:'Estado: Jugando X' equals:(console lines at:4)
! !

!TerniLapilliConsoleLogTest methodsFor: 'testing' stamp: 'das 11/8/2018 20:19:10'!
test03_XWinsTheGame

	|game console jugadas|
	game _ TerniLapilli new.
	console _ TerniLapilliConsoleLog for:game.
	game console: console ..
	jugadas _ OrderedCollection with:2@2 with:1@1 with:1@3 with:1@2 with:3@1.
	self MarkingPieces:  jugadas in:game.
	self assert: 10 equals:console lines size.
	self assert:'Estado: Juego terminado - ¡Gano X!!' equals: (console lines at:10)
	! !

!TerniLapilliConsoleLogTest methodsFor: 'testing' stamp: 'das 11/8/2018 20:30:45'!
test04_OWinsTheGame

	|game console jugadas|
	game _ TerniLapilli new.
	console _ TerniLapilliConsoleLog for:game.
	game console: console ..
	jugadas _ OrderedCollection with:1@1 with:2@2 with:1@3 with:2@3 with:3@1 with:2@1.
	self MarkingPieces:  jugadas in:game.
	self assert: 12 equals:console lines size.
	self assert:'Estado: Juego terminado - ¡Gano O!!' equals: (console lines at:12)
	! !

!TerniLapilliConsoleLogTest methodsFor: 'testing' stamp: 'das 11/8/2018 20:54:18'!
test05_SlidingAppearsOnLog

	|game console jugadas|
	game _ TerniLapilli new.
	console _ TerniLapilliConsoleLog for:game.
	game console: console ..
	jugadas _ OrderedCollection with:2@2.
	jugadas add:1@1;add:1@3 ; add:3@1;add:2@1;add:2@3;yourself.
	self MarkingPieces:  jugadas in:game.
	game slideXFrom: 1@3 to:1@2. 
	game slideOFrom:3@1  to:3@2. 
	game slideXFrom: 2@2 to:3@3. 
	self assert: 18 equals:console lines size.
	self assert:'X deslizo hasta 2@2 desde 1@3' equals: (console lines at:13).
	self assert:'Estado: Jugando O' equals:(console lines at:14).
	self assert:'O deslizo hasta 3@2 desde 3@1' equals: (console lines at:15).
	self assert:'Estado: Jugando X' equals:(console lines at:16)
	! !


!classDefinition: #TerniLapilliConsoleLog category: #TerniLapilliView!
Object subclass: #TerniLapilliConsoleLog
	instanceVariableNames: 'game lines'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliView'!

!TerniLapilliConsoleLog methodsFor: 'as yet unclassified' stamp: 'das 11/8/2018 19:50:09'!
addToLines:aLine

	lines add:aLine ! !

!TerniLapilliConsoleLog methodsFor: 'as yet unclassified' stamp: 'das 11/8/2018 19:48:27'!
initializeWith: aTerniLapilli 
	game _ aTerniLapilli .
	lines _ OrderedCollection new.! !

!TerniLapilliConsoleLog methodsFor: 'as yet unclassified' stamp: 'das 11/8/2018 19:48:11'!
lines
	
	^ lines! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliConsoleLog class' category: #TerniLapilliView!
TerniLapilliConsoleLog class
	instanceVariableNames: ''!

!TerniLapilliConsoleLog class methodsFor: 'init' stamp: 'das 11/8/2018 19:40:17'!
for: aTerniLapilli 
	^ self new initializeWith: aTerniLapilli .! !
