CHDIR ".\programs\samples\pete\simpire"

' ²±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±²
' ² Simpire Beta                    ²
' ²±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±²
' By Pyrus, Polarris@worldnet.att.net
' E-mail me with comments or suggestions.
'
' A strategy-type game in QuickBasic.
'
' You may will out of string space or memory in Qbasic 1.1,
' but this does work in Quickbasic 4.5. I would compile it, but
' it gets alot of errors...
'
' Some of the unfinished features in the beta are that
' you cannot battle another city, you cannot load a custom
' map yet, and sound has not been added. Also, the gold mine
' needs it's options programmed. You must go down to the CHDIR
' command and change it to the directory the program is in.
' I also need to make the small map update it's self.
'
' To gain citizens, build houses and Townhalls. To gain gold,
' you cut down trees and trade them for gold or by assassinating
' another city leader. To get more soldiers, you trade gold
' for them. Use the arror keys to scroll, and S to select menu
' items.

' For speed
DEFINT A-Z
' Declare subroutines and functions
DECLARE SUB printFX (text AS STRING)
DECLARE SUB menu ()
DECLARE FUNCTION CheckForVillage! ()
DECLARE SUB talkwin (text$, text2$, text3$, text4$, text5$, text6$, text7$, text8$, more%)
DECLARE SUB viewspr (filename$)
DECLARE SUB loadpal ()
DECLARE SUB changeanim ()
DECLARE SUB InitVars ()
DECLARE SUB LoadTiles ()
DECLARE SUB LoadWorld ()
DECLARE SUB ShowMap ()
DECLARE SUB MoveDown ()
DECLARE SUB MoveLeft ()
DECLARE SUB MoveRight ()
DECLARE SUB MoveUp ()
DECLARE SUB PutPlayerPic ()
DECLARE SUB PutTile (Ico, Jco, mapno)
DECLARE SUB LoadTile (Array())
DECLARE SUB jfont (a$, C, XCoordinate, YCoordinate, size)
DECLARE SUB PutCursorPic (cursor%)
DECLARE SUB Delay (seconds!)
DEFINT A-Z

' Some TYPES
TYPE WorldDataType
Rows            AS INTEGER
Cols            AS INTEGER
TopRow          AS INTEGER
TopCol          AS INTEGER
Action          AS INTEGER
AnimCycle       AS INTEGER
Direc           AS INTEGER
PlayerY         AS INTEGER
END TYPE

TYPE MapType
tile            AS INTEGER
WalkOn          AS INTEGER
END TYPE

TYPE HUES
Red AS INTEGER
grn AS INTEGER
blu AS INTEGER
END TYPE


' Define some Constants
CONST North = 1, South = 2, East = 3, West = 4
CONST true = -1, false = 0

' DIM Some Varibles
' "640K Ought to be enough for anyone" -Bill Gates'
DIM SHARED charset(128, 8, 6)   'array for storing font information
DIM SHARED WorldData AS WorldDataType
DIM SHARED map(-7 TO 70, -7 TO 62) AS MapType
DIM ColPal AS STRING * 768
DIM ColPal2 AS STRING * 768
DIM NewPal AS STRING * 768
DIM SHARED fontcolor$
DIM SHARED gold%
DIM SHARED wood%


' DIM the tile set
DIM SHARED ruble(205), stump(205), grass(205), water(205), Tree(205), stone(205), blank(205), ushore(205), dshore(205), lshore(205), rshore(205), tlshore(205), trshore(205), blshore(205), brshore(205), itlshore(205), itrshore(205), iblshore(205),  _
ibrshore(205), cpath(205)
DIM SHARED farm.topleft(205), farm.topright(205), castle.topleft(205), castle.topright(205), townhall.topleft(205), townhall.topright(205), civil.topleft(205), civil.topright(205)
DIM SHARED farm.bottomleft(205), farm.bottomright(205), castle.bottomleft(205), castle.bottomright(205), townhall.bottomleft(205), townhall.bottomright(205), civil.bottomleft(205), civil.bottomright(205)
DIM SHARED goldiconmask(205), goldicon(205)
DIM SHARED woodiconmask(205), woodicon(205)
DIM SHARED mine.topleft(205), mine.topright(205), mine.bottomleft(205), mine.bottomright(205)
DIM SHARED enemy.knight(205), path(205)

'DIM the cursor
DIM SHARED cursor(205), cursor02(205), cursormask(205), cursor02mask(205)
DIM SHARED woodtext(1050), bricktext(1050), cursor2(205), cursor2mask(205), cursor3mask(305), cursor3(305)

' DIM a few other graphics
DIM SHARED smallmap(9000), woodtextmini(205)
DIM SHARED person.consultor(805), person.ninja(805), person.other(805), person.snow(805), person.mean(805)

' Define some keys
upkey$ = CHR$(0) + "H"
downkey$ = CHR$(0) + "P"
RightKey$ = CHR$(0) + CHR$(77)
LeftKey$ = CHR$(0) + CHR$(75)
F1$ = CHR$(0) + CHR$(59)
F2$ = CHR$(0) + CHR$(60)
F3$ = CHR$(0) + CHR$(61)
F4$ = CHR$(0) + CHR$(62)
F5$ = CHR$(0) + CHR$(63)
F6$ = CHR$(0) + CHR$(64)
F7$ = CHR$(0) + CHR$(65)
F8$ = CHR$(0) + CHR$(66)
F9$ = CHR$(0) + CHR$(67)
F10$ = CHR$(0) + CHR$(68)
F11$ = CHR$(0) + CHR$(69)
CtrlRight$ = CHR$(0) + CHR$(116)
CtrlLeft$ = CHR$(0) + CHR$(115)
enter$ = CHR$(13)

' 320x200 with 256 color Resolution
SCREEN 13
printFX "By Pyrus"
PLAY "T160O0L32EF"
DO
x$ = INKEY$
LOOP UNTIL x$ = " " OR x$ = CHR$(13)

' Load Custom Palette
loadpal

' Load Custom Font
OPEN "fontdata.dat" FOR INPUT AS #1
FOR a = 1 TO 126
FOR x = 1 TO 8
FOR y = 1 TO 6
INPUT #1, B
charset(a, x, y) = B
NEXT y
NEXT x
NEXT a
CLOSE

' Loads graphic tile set
CALL LoadTiles
DIM title(5000)
DIM titlemask(5000)
viewspr ("title.spr")
GET (1, 1)-(119, 39), title
GET (1, 40)-(119, 79), titlemask
CLS

' intro and title screen
FOR y = 0 TO 180 STEP 20
FOR x = 0 TO 300 STEP 20
PUT (x, y), bricktext, PSET
NEXT
NEXT

PUT (95, 15), titlemask, AND
PUT (95, 15), title, OR
CALL jfont("v1.0", 15, 220, 30, 1)


LINE (95, 50)-(215, 140), 0, BF
LINE (95, 50)-(215, 140), 112, B
CALL jfont("Begin Simpire", 2, 117, 65, 1)
CALL jfont("Load Custom Map", 15, 111, 75, 1)
CALL jfont("Options", 15, 135, 85, 1)
CALL jfont("Help", 15, 144, 95, 1)
CALL jfont("About", 15, 142, 105, 1)
CALL jfont("Quit to Dos", 15, 124, 115, 1)
sel = 1
DIM tempimg(8200)

menu:

DO
x$ = INKEY$

LOOP UNTIL x$ = upkey$ OR x$ = downkey$ OR x$ = CHR$(13)

IF x$ = CHR$(13) THEN

IF sel = 6 THEN
FOR T = 1 TO 84 STEP 4
Delay .0009
LINE (0, 0)-(T, 200), 0, BF
LINE (80, 0)-(80 + T, 200), 0, BF
LINE (160, 0)-(160 + T, 200), 0, BF
LINE (240, 0)-(240 + T, 200), 0, BF
NEXT
CLS
END
END IF


IF sel = 1 THEN GOTO start

IF sel = 2 THEN
GET (30, 50)-(291, 111), tempimg
LINE (30, 50)-(291, 111), 0, BF
LINE (30, 50)-(291, 111), 112, B
FOR x = 1 TO 260 STEP 20
PUT (30 + x, 51), woodtextmini, PSET
PUT (30 + x, 71), woodtextmini, PSET
PUT (30 + x, 91), woodtextmini, PSET
NEXT
LINE (40, 60)-(81, 99), 0, BF
PUT (41, 60), person.snow, PSET
LINE (40, 60)-(81, 99), 112, B
LINE (90, 60)-(278, 100), 0, BF
LINE (90, 60)-(278, 100), 112, B
CALL jfont("This feature is not ready yet.", 15, 95, 61, 1)
CALL jfont("", 2, 95, 71, 1)
CALL jfont("", 2, 95, 81, 1)
CALL jfont("Press Enter", 15, 95, 91, 1)
DO
x$ = INKEY$
LOOP UNTIL x$ = CHR$(13)
PUT (30, 50), tempimg, PSET
ERASE tempimg
END IF

IF sel = 3 THEN
GET (30, 50)-(291, 111), tempimg
LINE (30, 50)-(291, 111), 0, BF
LINE (30, 50)-(291, 111), 112, B
FOR x = 1 TO 260 STEP 20
PUT (30 + x, 51), woodtextmini, PSET
PUT (30 + x, 71), woodtextmini, PSET
PUT (30 + x, 91), woodtextmini, PSET
NEXT
LINE (40, 60)-(81, 99), 0, BF
PUT (41, 60), person.ninja, PSET
LINE (40, 60)-(81, 99), 112, B
LINE (90, 60)-(278, 100), 0, BF
LINE (90, 60)-(278, 100), 112, B
CALL jfont("What kind of sound do you want?", 15, 95, 61, 1)
CALL jfont("I want Adlib Compable.", 2, 95, 71, 1)
CALL jfont("I want PC Speaker.", 15, 95, 81, 1)
CALL jfont("Press Enter when done", 15, 95, 91, 1)
sel = 1
options:
DO
x$ = INKEY$
LOOP UNTIL x$ = CHR$(13) OR x$ = upkey$ OR x$ = downkey$

IF x$ = downkey$ THEN sel = sel + 1
IF x$ = upkey$ THEN sel = sel + 1

IF sel = 3 THEN sel = 1
IF sel = 0 THEN sel = 2

CALL jfont("I want Adlib Compable.", 15, 95, 71, 1)
CALL jfont("I want PC Speaker.", 15, 95, 81, 1)

IF sel = 1 THEN CALL jfont("I want Adlib Compable.", 2, 95, 71, 1)
IF sel = 2 THEN CALL jfont("I want PC Speaker.", 2, 95, 81, 1)

IF x$ = CHR$(13) THEN

IF sel = 1 THEN
CALL talkwin("This feature has not been added yet.", "", "", "", "", "", "", "", 2)
END IF

IF sel = 2 THEN
CALL talkwin("This feature has not been added yet.", "", "", "", "", "", "", "", 2)
END IF

PUT (30, 50), tempimg, PSET
ERASE tempimg
sel = 3
GOTO donesound
END IF

GOTO options

donesound:
END IF

IF sel = 4 THEN
GET (30, 50)-(291, 111), tempimg
LINE (30, 50)-(291, 111), 0, BF
LINE (30, 50)-(291, 111), 112, B
FOR x = 1 TO 260 STEP 20
PUT (30 + x, 51), woodtextmini, PSET
PUT (30 + x, 71), woodtextmini, PSET
PUT (30 + x, 91), woodtextmini, PSET
NEXT
LINE (40, 60)-(81, 99), 0, BF
PUT (41, 60), person.mean, PSET
LINE (40, 60)-(81, 99), 112, B
LINE (90, 60)-(278, 100), 0, BF
LINE (90, 60)-(278, 100), 112, B
CALL jfont("How to play.", 15, 95, 61, 1)
CALL jfont("Arror keys control scrolling.", 2, 95, 71, 1)
CALL jfont("S controls the menu.", 2, 95, 81, 1)
CALL jfont("Press Enter", 15, 95, 91, 1)
sel = 1
DO
x$ = INKEY$
LOOP UNTIL x$ = CHR$(13)
PUT (30, 50), tempimg, PSET
ERASE tempimg
sel = 4
END IF

IF sel = 5 THEN
GET (30, 50)-(291, 111), tempimg
LINE (30, 50)-(291, 111), 0, BF
LINE (30, 50)-(291, 111), 112, B
FOR x = 1 TO 260 STEP 20
PUT (30 + x, 51), woodtextmini, PSET
PUT (30 + x, 71), woodtextmini, PSET
PUT (30 + x, 91), woodtextmini, PSET
NEXT
LINE (40, 60)-(81, 99), 0, BF
PUT (41, 60), person.other, PSET
LINE (40, 60)-(81, 99), 112, B
LINE (90, 60)-(278, 100), 0, BF
LINE (90, 60)-(278, 100), 112, B
CALL jfont("Simpire v1.0", 15, 95, 61, 1)
CALL jfont("By Pyrus of WinterScape", 2, 95, 71, 1)
CALL jfont("Polarris@worldnet.att.net", 2, 95, 81, 1)
CALL jfont("Press Enter", 15, 95, 91, 1)
DO
x$ = INKEY$
LOOP UNTIL x$ = CHR$(13)
PUT (30, 50), tempimg, PSET
ERASE tempimg
END IF



END IF




IF x$ = downkey$ THEN sel = sel + 1
IF x$ = upkey$ THEN sel = sel - 1

IF sel = 0 THEN sel = 6
IF sel = 7 THEN sel = 1
CALL jfont("Begin Simpire", 15, 117, 65, 1)
CALL jfont("Load Custom Map", 15, 111, 75, 1)
CALL jfont("Options", 15, 135, 85, 1)
CALL jfont("Help", 15, 144, 95, 1)
CALL jfont("About", 15, 142, 105, 1)
CALL jfont("Quit to Dos", 15, 124, 115, 1)

IF sel = 1 THEN CALL jfont("Begin Simpire", 2, 117, 65, 1)
IF sel = 2 THEN CALL jfont("Load Custom Map", 2, 111, 75, 1)
IF sel = 3 THEN CALL jfont("Options", 2, 135, 85, 1)
IF sel = 4 THEN CALL jfont("Help", 2, 144, 95, 1)
IF sel = 5 THEN CALL jfont("About", 2, 142, 105, 1)
IF sel = 6 THEN CALL jfont("Quit to Dos", 2, 124, 115, 1)

GOTO menu

start:
' Start Up Subs
CALL InitVars
CALL LoadWorld
CALL menu

' A few other im[porrtant varibles
selct% = 1: menutitle% = 1:
abletotrade% = 1: gold% = 20: wood% = 20


' Makes the begining main menu
LINE (5, 60)-(56, 152), 0, BF
LINE (5, 60)-(56, 152), 112, B
LINE (5, 72)-(56, 72), 112
CALL jfont("Menu:", 15, 7, 62, 1)
CALL jfont("Build", 2, 7, 75, 1)
CALL jfont("Destroy", 15, 7, 85, 1)
CALL jfont("Attack", 15, 7, 95, 1)
CALL jfont("Trade", 15, 7, 105, 1)
CALL jfont("Status", 15, 7, 115, 1)
CALL jfont("Quit", 15, 7, 125, 1)

' Prints how much gold and wood you have
COLOR 15
LOCATE 21, 4: PRINT gold%
LOCATE 23, 4: PRINT wood%

' Show the map
CALL ShowMap
CALL PutCursorPic(1)
                                            
' Startup Message
startup:
CALL talkwin("Welcome to this demo of Simpire. Feel free to", "build a city. If you can achieve a population", "of 100 citizens, you will win.", "", "", "", "", "", 2)

' Starts the main loop
again:

' Checks if you have reached your goal
IF poplation% >= 100 THEN
CALL talkwin("You achieved a population of 100 citizens.", "Very good job.", "", "", "", "", "", "", 2)
CLS
END
END IF

' Prints how much gold and wood you have
LOCATE 21, 4: PRINT gold%
LOCATE 23, 4: PRINT wood%

' Starts a loop that waits for keys
DO
x$ = INKEY$
LOOP UNTIL x$ = "d" OR x$ = "D" OR x$ = "p" OR x$ = "P" OR x$ = "q" OR x$ = "Q" OR x$ = enter$ OR x$ = "s" OR x$ = "S" OR x$ = CHR$(27) OR x$ = CHR$(0) + "H" OR x$ = CHR$(0) + "P" OR x$ = CHR$(0) + "K" OR x$ = CHR$(0) + "M"


' Determines what key you pressed

IF x$ = "d" OR x$ = "D" THEN

IF destroy% = 0 THEN GOTO nokill

IF destroy% = 1 THEN

IF map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 41 THEN
map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 2
destroy% = 0:
GOTO donedes
END IF


IF map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 4 THEN
map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 3
destroy% = 0: wood% = wood% + 1
IF wood% >= 99 THEN wood% = 99
GOTO donedes
END IF

IF map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 5 THEN
map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 2:
destroy% = 0
END IF

IF map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 18 OR map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 20 OR map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 23 OR map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 25 THEN
map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 1
map(WorldData.TopCol + 9, WorldData.TopRow + 5).tile = 1
map(WorldData.TopCol + 8, WorldData.TopRow + 6).tile = 1
map(WorldData.TopCol + 9, WorldData.TopRow + 6).tile = 1
destroy% = 0
END IF

IF map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 19 OR map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 21 OR map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 24 OR map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 26 THEN
map(WorldData.TopCol + 7, WorldData.TopRow + 5).tile = 1
map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 1
map(WorldData.TopCol + 7, WorldData.TopRow + 6).tile = 1
map(WorldData.TopCol + 8, WorldData.TopRow + 6).tile = 1
destroy% = 0
END IF

IF map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 27 OR map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 29 OR map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 32 OR map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 34 THEN
map(WorldData.TopCol + 8, WorldData.TopRow + 4).tile = 1
map(WorldData.TopCol + 9, WorldData.TopRow + 4).tile = 1
map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 1
map(WorldData.TopCol + 9, WorldData.TopRow + 5).tile = 1
destroy% = 0
END IF

IF map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 28 OR map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 30 OR map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 33 OR map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 35 THEN
map(WorldData.TopCol + 7, WorldData.TopRow + 4).tile = 1
map(WorldData.TopCol + 8, WorldData.TopRow + 4).tile = 1
map(WorldData.TopCol + 7, WorldData.TopRow + 5).tile = 1
map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 1
destroy% = 0
END IF

END IF

donedes:
CALL ShowMap

nokill:

END IF

IF x$ = "p" OR x$ = "P" THEN

IF wantbuild% = 0 THEN GOTO noplace
IF buildtoplace% = 0 THEN GOTO noplace

IF canbuild% = 1 THEN

IF gold% >= 5 AND wood% >= 5 THEN
IF buildtoplace% = 1 THEN
map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 18
map(WorldData.TopCol + 9, WorldData.TopRow + 5).tile = 19
map(WorldData.TopCol + 8, WorldData.TopRow + 6).tile = 27
map(WorldData.TopCol + 9, WorldData.TopRow + 6).tile = 28
CALL ShowMap
typ% = 1: CALL PutCursorPic(typ%)
farms% = farms% + 1
poplation% = poplation% + 1
wantbuild% = 0
gold% = gold% - 5
wood% = wood% - 5
END IF
END IF

IF gold% >= 15 AND wood% >= 15 THEN
IF buildtoplace% = 2 THEN
map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 20
map(WorldData.TopCol + 9, WorldData.TopRow + 5).tile = 21
map(WorldData.TopCol + 8, WorldData.TopRow + 6).tile = 29
map(WorldData.TopCol + 9, WorldData.TopRow + 6).tile = 30
CALL ShowMap
typ% = 1: CALL PutCursorPic(typ%)
wantbuild% = 0
gold% = gold% - 15
wood% = wood% - 15
castle% = castle% + 1
soldiers% = soldiers% + 5
END IF
END IF

IF gold% >= 15 AND wood% >= 15 THEN
IF buildtoplace% = 3 THEN
map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 23
map(WorldData.TopCol + 9, WorldData.TopRow + 5).tile = 24
map(WorldData.TopCol + 8, WorldData.TopRow + 6).tile = 32
map(WorldData.TopCol + 9, WorldData.TopRow + 6).tile = 33
CALL ShowMap
typ% = 1: CALL PutCursorPic(typ%)
wantbuild% = 0
gold% = gold% - 15
wood% = wood% - 15
townhall% = townhall% + 1
poplation% = poplation% + 10
END IF
END IF

IF gold% >= 5 AND wood% >= 5 THEN
IF buildtoplace% = 4 THEN
map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 25
map(WorldData.TopCol + 9, WorldData.TopRow + 5).tile = 26
map(WorldData.TopCol + 8, WorldData.TopRow + 6).tile = 34
map(WorldData.TopCol + 9, WorldData.TopRow + 6).tile = 35
CALL ShowMap
typ% = 1: CALL PutCursorPic(typ%)
wantbuild% = 0
gold% = gold% - 5
wood% = wood% - 5
house% = house% + 1
poplation% = poplation% + 3
END IF

END IF

IF gold% >= 1 AND wood% >= 1 THEN
IF buildtoplace% = 5 THEN
map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 41
CALL ShowMap
typ% = 1: CALL PutCursorPic(typ%)
wantbuild% = 0
gold% = gold% - 1
wood% = wood% - 1
numofspac% = 0
END IF
END IF

IF gold% >= 1 AND wood% >= 1 THEN
IF buildtoplace% = 6 THEN
map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 4
CALL ShowMap
typ% = 1: CALL PutCursorPic(typ%)
wantbuild% = 0
gold% = gold% - 1
wood% = wood% - 1
numofspac% = 0
END IF
END IF




END IF

noplace:
END IF

IF x$ = "q" OR x$ = "Q" THEN
END
END IF
  
IF x$ = CHR$(0) + "H" THEN
CALL MoveUp
END IF

IF x$ = CHR$(0) + "P" THEN
CALL MoveDown
END IF

IF x$ = CHR$(0) + "K" THEN
CALL MoveLeft
END IF

IF x$ = CHR$(0) + "M" THEN
CALL MoveRight
END IF

IF x$ = "s" OR x$ = "S" THEN
selct% = selct% + 1

selectmenu:
IF menutitle% = 1 THEN
IF selct% = 7 THEN selct% = 1
CALL jfont("Menu:", 15, 7, 62, 1)
CALL jfont("Build", 15, 7, 75, 1)
CALL jfont("Destroy", 15, 7, 85, 1)
CALL jfont("Attack", 15, 7, 95, 1)
CALL jfont("Trade", 15, 7, 105, 1)
CALL jfont("Status", 15, 7, 115, 1)
CALL jfont("Quit", 15, 7, 125, 1)

IF selct% = 1 THEN CALL jfont("Build", 2, 7, 75, 1)
IF selct% = 2 THEN CALL jfont("Destroy", 2, 7, 85, 1)
IF selct% = 3 THEN CALL jfont("Attack", 2, 7, 95, 1)
IF selct% = 4 THEN CALL jfont("Trade", 2, 7, 105, 1)
IF selct% = 5 THEN CALL jfont("Status", 2, 7, 115, 1)
IF selct% = 6 THEN CALL jfont("Quit", 2, 7, 125, 1)

END IF

IF menutitle% = 2 THEN
IF selct% = 8 THEN selct% = 1
CALL jfont("Build:", 15, 7, 62, 1)
CALL jfont("Farm", 15, 7, 75, 1)
CALL jfont("Castle", 15, 7, 85, 1)
CALL jfont("Townhall", 15, 7, 95, 1)
CALL jfont("House", 15, 7, 105, 1)
CALL jfont("Path", 15, 7, 115, 1)
CALL jfont("Tree", 15, 7, 125, 1)
CALL jfont("Exit", 15, 7, 135, 1)

IF selct% = 1 THEN CALL jfont("Farm", 2, 7, 75, 1)
IF selct% = 2 THEN CALL jfont("Castle", 2, 7, 85, 1)
IF selct% = 3 THEN CALL jfont("Townhall", 2, 7, 95, 1)
IF selct% = 4 THEN CALL jfont("House", 2, 7, 105, 1)
IF selct% = 5 THEN CALL jfont("Path", 2, 7, 115, 1)
IF selct% = 6 THEN CALL jfont("Tree", 2, 7, 125, 1)
IF selct% = 7 THEN CALL jfont("Exit", 2, 7, 135, 1)

END IF
END IF

IF x$ = enter$ THEN

IF menutitle% = 1 AND selct% = 1 THEN
selct% = 0
menutitle% = 2
LINE (5, 60)-(56, 152), 0, BF
LINE (5, 60)-(56, 152), 112, B
LINE (5, 72)-(56, 72), 112
GOTO selectmenu:
END IF

IF menutitle% = 1 AND selct% = 6 THEN
CALL talkwin("Thanks for Playing.", "", "", "", "", "", "", "", 2)
FOR T = 1 TO 84 STEP 4
Delay .0009
LINE (0, 0)-(T, 200), 0, BF
LINE (80, 0)-(80 + T, 200), 0, BF
LINE (160, 0)-(160 + T, 200), 0, BF
LINE (240, 0)-(240 + T, 200), 0, BF
NEXT
CLS
SYSTEM
END IF


IF menutitle% = 1 AND selct% = 2 THEN
CALL talkwin("Please select what you want to destory. Then", "press D.", "", "", "", "", "", "", 2)
destroy% = 1
END IF

IF menutitle% = 1 AND selct% = 5 THEN
CALL talkwin("Welcome to the status menu.", "", "", "", "", "", "", "", 2)
LINE (80, 50)-(301, 111), 0, BF
LINE (80, 50)-(301, 111), 112, B
FOR x = 1 TO 220 STEP 20
PUT (80 + x, 51), bricktext, PSET
PUT (80 + x, 71), bricktext, PSET
PUT (80 + x, 91), bricktext, PSET
NEXT
LINE (90, 55)-(131, 95), 0, BF
LINE (90, 55)-(131, 96), 112, B
PUT (91, 56), person.mean, PSET

LINE (140, 55)-(290, 95), 0, BF
LINE (140, 55)-(290, 95), 112, B
even% = RND * 9 + 1

IF even% = 1 AND abletotrade% = 1 THEN
event1$ = "Snow Fall Blocks Trade."
event2$ = ""
LINE (90, 55)-(131, 95), 0, BF
LINE (90, 55)-(131, 96), 112, B
PUT (91, 56), person.snow, PSET
abletotrade% = 0
END IF

IF even% = 2 THEN
event1$ = "Forigners cut down"
event2$ = "many trees."
p% = RND * 40
FOR I = p% TO p% + 10
FOR J = p% TO p% + 10
IF map(J, I).tile = 4 THEN map(J, I).tile = 3
NEXT
NEXT
END IF

IF even% = 3 THEN
event1$ = "You recive 5 gold!"
event2$ = ""
gold% = gold% + 5
IF gold% >= 99 THEN gold% = 99
END IF

IF even% = 4 AND abletotrade% = 0 THEN
event1$ = "The snowing stops."
event2$ = ""
abletotrade% = 1
GOTO eventss
END IF

IF even% = 4 AND abletotrade% = 1 THEN
event1$ = "3 new soldiers join"
event2$ = "your army."
soldiers% = soldiers% + 3
IF soldiers% >= 999 THEN soldiers% = 999
END IF

IF even% >= 5 AND even% <= 10 THEN
event1$ = "No new Events."
event2$ = ""
END IF

eventss:
CALL jfont("Important Events:", 15, 145, 56, 1)
CALL jfont(event1$, 2, 145, 66, 1)
CALL jfont(event2$, 2, 145, 76, 1)
CALL jfont("Press Enter", 15, 145, 86, 1)
sel = 1

statusmenu:

DO
x$ = INKEY$
LOOP UNTIL x$ = CHR$(13)

IF x$ = CHR$(13) THEN
LOCATE 21, 4: PRINT gold%
LOCATE 23, 4: PRINT wood%

LINE (140, 55)-(290, 95), 0, BF
LINE (140, 55)-(290, 95), 112, B

CALL jfont("Population, Soldiers", 15, 145, 56, 1)
LOCATE 10, 19: PRINT poplation%; ", "; soldiers%
CALL jfont("Press Enter to Exit", 15, 145, 86, 1)
DO
x$ = INKEY$
LOOP UNTIL x$ = CHR$(13)

END IF

END IF



IF menutitle% = 1 AND selct% = 3 THEN
CALL talkwin("Welcome to the attack menu.", "", "", "", "", "", "", "", 2)
LINE (80, 50)-(301, 111), 0, BF
LINE (80, 50)-(301, 111), 112, B
attmenu:
FOR x = 1 TO 220 STEP 20
PUT (80 + x, 51), bricktext, PSET
PUT (80 + x, 71), bricktext, PSET
PUT (80 + x, 91), bricktext, PSET
NEXT
LINE (90, 55)-(131, 95), 0, BF
PUT (91, 56), person.other, PSET
LINE (90, 55)-(131, 95), 112, B


LINE (140, 55)-(290, 95), 0, BF
LINE (140, 55)-(290, 95), 112, B

CALL jfont("How you want to attack?", 15, 145, 56, 1)
CALL jfont("Battle a city.", 2, 145, 66, 1)
CALL jfont("Kill a city leader.", 15, 145, 76, 1)
CALL jfont("Exit attack", 15, 145, 86, 1)
sel = 1

attackmenu:

DO
x$ = INKEY$
LOOP UNTIL x$ = upkey$ OR x$ = downkey$ OR x$ = CHR$(13) OR x$ = "s" OR x$ = "S"

IF x$ = CHR$(13) THEN
IF sel = 1 THEN
CALL talkwin("This feature has not been added yet.", "", "", "", "", "", "", "", 2)
END IF
IF sel = 3 THEN GOTO exitattack
IF sel = 2 THEN GOTO assattack

END IF

IF x$ = upkey$ THEN sel = sel - 1
IF x$ = downkey$ THEN sel = sel + 1
IF x$ = "s" OR x$ = "S" THEN sel = sel + 1
IF sel = 0 THEN sel = 4
IF sel = 4 THEN sel = 1
CALL jfont("How you want to attack?", 15, 145, 56, 1)
CALL jfont("Battle a city.", 15, 145, 66, 1)
CALL jfont("Kill a city leader.", 15, 145, 76, 1)
CALL jfont("Exit attack", 15, 145, 86, 1)

IF sel = 1 THEN CALL jfont("Battle a city.", 2, 145, 66, 1)
IF sel = 2 THEN CALL jfont("Kill a city leader.", 2, 145, 76, 1)
IF sel = 3 THEN CALL jfont("Exit attack", 2, 145, 86, 1)
GOTO attackmenu

assattack:
LINE (80, 50)-(301, 111), 0, BF
LINE (80, 50)-(301, 111), 112, B

FOR x = 1 TO 220 STEP 20
PUT (80 + x, 51), bricktext, PSET
PUT (80 + x, 71), bricktext, PSET
PUT (80 + x, 91), bricktext, PSET
NEXT
LINE (90, 55)-(131, 95), 0, BF
LINE (90, 55)-(131, 96), 112, B
PUT (91, 56), person.ninja, PSET

LINE (140, 55)-(290, 95), 0, BF
LINE (140, 55)-(290, 95), 112, B

CALL jfont("Are you sure?", 15, 145, 56, 1)
CALL jfont("Yes.", 2, 145, 66, 1)
CALL jfont("Exit kill menu", 15, 145, 86, 1)
sel = 1

assmenu:
LOCATE 21, 4: PRINT gold%
LOCATE 23, 4: PRINT wood%

DO
x$ = INKEY$
LOOP UNTIL x$ = upkey$ OR x$ = downkey$ OR x$ = CHR$(13) OR x$ = "s" OR x$ = "S"

IF x$ = CHR$(13) THEN
IF sel = 1 THEN
kil% = RND * 9 + 1

IF kil% <= 4 THEN
CALL talkwin("You sucsessfully assassinated a city leader.", "You gain 10 gold, 10 wood, and 5 soldires.", "", "", "", "", "", "", 2)
gold% = gold% + 10
wood% = wood% + 10
IF gold% >= 99 THEN gold% = 99
IF wood% >= 99 THEN wood% = 99
soldiers% = soldiers% + 5
END IF

IF kil% >= 5 THEN
CALL talkwin("The assassination was not sucessful. The city", "demands at least 20 gold.", "", "", "", "", "", "", 2)
gold% = gold% - 20
IF gold% <= 0 THEN gold% = 0
END IF


END IF


IF sel = 2 THEN GOTO attmenu
END IF

IF x$ = upkey$ THEN sel = sel - 1
IF x$ = downkey$ THEN sel = sel + 1
IF x$ = "s" OR x$ = "S" THEN sel = sel + 1
IF sel = 0 THEN sel = 2
IF sel = 3 THEN sel = 1
CALL jfont("Are you sure?", 15, 145, 56, 1)
CALL jfont("Yes.", 15, 145, 66, 1)
CALL jfont("Exit kill menu", 15, 145, 86, 1)

IF sel = 1 THEN CALL jfont("Yes.", 2, 145, 66, 1)
IF sel = 2 THEN CALL jfont("Exit kill menu", 2, 145, 86, 1)
GOTO assmenu






exitattack:
END IF

IF menutitle% = 1 AND selct% = 4 AND abletotrade% = 0 THEN
CALL talkwin("Snowfall blocks trade.", "", "", "", "", "", "", "", 2)
END IF


IF menutitle% = 1 AND selct% = 4 AND abletotrade% = 1 THEN
CALL talkwin("Welcome to the trade menu.", "", "", "", "", "", "", "", 2)
LINE (80, 50)-(301, 111), 0, BF
LINE (80, 50)-(301, 111), 112, B

FOR x = 1 TO 220 STEP 20
PUT (80 + x, 51), bricktext, PSET
PUT (80 + x, 71), bricktext, PSET
PUT (80 + x, 91), bricktext, PSET
NEXT
LINE (90, 55)-(131, 95), 0, BF
LINE (90, 55)-(131, 95), 112, B
PUT (91, 55), person.consultor, PSET

LINE (140, 55)-(290, 95), 0, BF
LINE (140, 55)-(290, 95), 112, B

CALL jfont("What you want to trade?", 15, 145, 56, 1)
CALL jfont("10 wood for 5 gold.", 2, 145, 66, 1)
CALL jfont("5 gold for a soldiers.", 15, 145, 76, 1)
CALL jfont("Exit Trade", 15, 145, 86, 1)
sel = 1

trademenu:
LOCATE 21, 4: PRINT gold%
LOCATE 23, 4: PRINT wood%


DO
x$ = INKEY$
LOOP UNTIL x$ = upkey$ OR x$ = downkey$ OR x$ = CHR$(13) OR x$ = "s" OR x$ = "S"

IF x$ = CHR$(13) THEN

IF sel = 3 THEN GOTO exittrade

IF sel = 1 THEN

IF wood% >= 10 THEN
wood% = wood% - 10
gold% = gold% + 5
IF gold% >= 99 THEN gold% = 99
CALL talkwin("You traded.", "", "", "", "", "", "", "", 2)
GOTO donesel2
END IF

IF wood% <= 9 THEN
CALL talkwin("You dont have enough wood.", "", "", "", "", "", "", "", 2)
END IF
donesel2:
END IF

IF sel = 2 THEN

IF gold% >= 5 THEN
gold% = gold% - 5
soldiers% = soldiers% + 1
CALL talkwin("You traded.", "", "", "", "", "", "", "", 2)
GOTO donesel1
END IF

IF gold% <= 4 THEN
CALL talkwin("You dont have enough gold.", "", "", "", "", "", "", "", 2)
END IF

END IF

donesel1:

END IF

IF x$ = upkey$ THEN sel = sel - 1
IF x$ = downkey$ THEN sel = sel + 1
IF x$ = "s" OR x$ = "S" THEN sel = sel + 1
IF sel = 0 THEN sel = 4
IF sel = 4 THEN sel = 1
CALL jfont("What you want to trade?", 15, 145, 56, 1)
CALL jfont("10 wood for 5 gold.", 15, 145, 66, 1)
CALL jfont("5 gold for a soldiers.", 15, 145, 76, 1)
CALL jfont("Exit Trade", 15, 145, 86, 1)

IF sel = 1 THEN CALL jfont("10 wood for 5 gold.", 2, 145, 66, 1)
IF sel = 2 THEN CALL jfont("5 gold for a soldiers.", 2, 145, 76, 1)
IF sel = 3 THEN CALL jfont("Exit Trade", 2, 145, 86, 1)
GOTO trademenu

exittrade:
END IF


IF menutitle% = 2 THEN

IF selct% = 1 THEN
IF gold% >= 5 AND wood% >= 5 THEN CALL talkwin("Please select where you want to build a farm.", "Then press P.", "", "", "", "", "", "", 2): buildtoplace% = 1: typ% = 3: CALL PutCursorPic(typ%): wantbuild% = 1
IF gold% <= 4 OR wood% <= 4 THEN CALL talkwin("You do not have enough gold or wood.", "", "", "", "", "", "", "", 2): wantbuild% = 0
END IF

IF selct% = 2 THEN
IF gold% >= 15 AND wood% >= 15 THEN CALL talkwin("Please select where you want to build a", "castle. Then press P.", "", "", "", "", "", "", 2): buildtoplace% = 2: typ% = 3: CALL PutCursorPic(typ%): wantbuild% = 1
IF gold% <= 14 OR wood% <= 14 THEN CALL talkwin("You do not have enough gold or wood.", "", "", "", "", "", "", "", 2): wantbuild% = 0

END IF

IF selct% = 3 THEN
IF gold% >= 15 AND wood% >= 15 THEN CALL talkwin("Please select where you want to build a town", "hall. Then press P.", "", "", "", "", "", "", 2): buildtoplace% = 3: typ% = 3: CALL PutCursorPic(typ%): wantbuild% = 1
IF gold% <= 14 OR wood% <= 14 THEN CALL talkwin("You do not have enough gold or wood.", "", "", "", "", "", "", "", 2): wantbuild% = 0
END IF

IF selct% = 4 THEN
IF gold% >= 5 AND wood% >= 5 THEN CALL talkwin("Please select where you want to build a house.", "Then press P.", "", "", "", "", "", "", 2): buildtoplace% = 4: typ% = 3: CALL PutCursorPic(typ%): wantbuild% = 1
IF gold% <= 4 OR wood% <= 4 THEN CALL talkwin("You do not have enough gold or wood.", "", "", "", "", "", "", "", 2): wantbuild% = 0
END IF

IF selct% = 5 THEN
IF gold% >= 1 AND wood% >= 1 THEN CALL talkwin("Please select where you want to build a path", "segement. Then press P.", "", "", "", "", "", "", 2): buildtoplace% = 5: typ% = 3: CALL PutCursorPic(typ%): wantbuild% = 1: numofspac% = 1
IF gold% <= 0 OR wood% <= 0 THEN CALL talkwin("You do not have enough gold or wood.", "", "", "", "", "", "", "", 2): wantbuild% = 0
END IF

IF selct% = 6 THEN
IF gold% >= 1 AND wood% >= 1 THEN CALL talkwin("Please select where you want to plant a Tree.", "Then press P.", "", "", "", "", "", "", 2): buildtoplace% = 6: typ% = 3: CALL PutCursorPic(typ%): wantbuild% = 1: numofspac% = 1
IF gold% <= 0 OR wood% <= 0 THEN CALL talkwin("You do not have enough gold or wood.", "", "", "", "", "", "", "", 2): wantbuild% = 0
END IF

IF selct% = 7 THEN
menutitle% = 1
selct% = 0
LINE (5, 60)-(56, 152), 0, BF
LINE (5, 60)-(56, 152), 112, B
LINE (5, 72)-(56, 72), 112
CALL jfont("Menu:", 15, 7, 62, 1)
CALL jfont("Build", 15, 7, 75, 1)
CALL jfont("Destroy", 15, 7, 85, 1)
CALL jfont("Attack", 15, 7, 95, 1)
CALL jfont("Trade", 15, 7, 105, 1)
CALL jfont("Status", 15, 7, 115, 1)
CALL jfont("Quit", 15, 7, 125, 1)
END IF




okok:
END IF
END IF

IF x$ = CHR$(27) THEN
IF wantbuild% = 1 THEN wantbuild% = 0: GOTO noesx
IF destroy% = 1 THEN destroy% = 0: GOTO noesx

menutitle% = 1
selct% = 0
LINE (5, 60)-(56, 152), 0, BF
LINE (5, 60)-(56, 152), 112, B
LINE (5, 72)-(56, 72), 112
CALL jfont("Menu:", 15, 7, 62, 1)
CALL jfont("Build", 15, 7, 75, 1)
CALL jfont("Destroy", 15, 7, 85, 1)
CALL jfont("Attack", 15, 7, 95, 1)
CALL jfont("Trade", 15, 7, 105, 1)
CALL jfont("Status", 15, 7, 115, 1)
CALL jfont("Quit", 15, 7, 125, 1)


noesx:
END IF

CALL ShowMap

' Places an appropiate cursor

IF destroy% = 1 THEN

IF map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 3 OR map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 2 OR map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 1 OR map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 37 OR map( _
WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 38 OR map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 39 OR map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 40 THEN
CALL PutCursorPic(2)
GOTO donecursor
END IF


IF map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile > 2 OR map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile < 1 THEN
CALL PutCursorPic(3)
GOTO donecursor
END IF

END IF

IF wantbuild% = 1 THEN



IF numofspac% = 1 THEN

IF map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile <= 3 THEN
CALL PutCursorPic(3)
canbuild% = 1
GOTO donecursor
END IF

IF map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile >= 4 THEN
CALL PutCursorPic(2)
canbuild% = 2
GOTO donecursor
END IF


END IF



IF map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile >= 4 OR map(WorldData.TopCol + 9, WorldData.TopRow + 5).tile >= 4 OR map(WorldData.TopCol + 8, WorldData.TopRow + 6).tile >= 4 OR map(WorldData.TopCol + 9, WorldData.TopRow + 6).tile >= 4 THEN
CALL PutCursorPic(2)
canbuild% = 2
GOTO donecursor
END IF

IF map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile <= 2 AND map(WorldData.TopCol + 9, WorldData.TopRow + 5).tile <= 2 AND map(WorldData.TopCol + 8, WorldData.TopRow + 6).tile <= 2 AND map(WorldData.TopCol + 9, WorldData.TopRow + 6).tile <= 2 OR _
 map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile <= 3 OR map(WorldData.TopCol + 9, WorldData.TopRow + 5).tile <= 3 OR map(WorldData.TopCol + 8, WorldData.TopRow + 6).tile <= 3 OR map(WorldData.TopCol + 9, WorldData.TopRow + 6).tile <= 3 THEN
CALL PutCursorPic(3)
canbuild% = 1
GOTO donecursor
END IF

END IF

IF destroy% = 0 AND wantbuild% = 0 THEN CALL PutCursorPic(1)


donecursor:
' Go to the top of the loop
GOTO again

SUB changeanim

' Simple. If they are on animation tile 1, make it 2, or vice versa.

IF WorldData.AnimCycle = 1 THEN WorldData.AnimCycle = 2 ELSE IF WorldData.AnimCycle = 2 THEN WorldData.AnimCycle = 1

END SUB

DEFSNG A-Z
FUNCTION CheckForVillage
 IF map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 1 THEN
  CheckForVillage = true
 END IF

END FUNCTION

SUB Delay (seconds!)
   DEF SEG = 0
   D& = FIX(seconds! * 18.20444444#)
   FOR T& = 0 TO D&
     D% = PEEK(&H46C) AND 255
     DO WHILE D% = (PEEK(&H46C) AND 255)
     LOOP
   NEXT T&
END SUB

DEFINT A-Z
SUB InitVars

' Initalize some variables
WorldData.TopRow = 5
WorldData.TopCol = 5
WorldData.Direc = West
WorldData.AnimCycle = 1
WorldData.PlayerY = 94
END SUB

SUB jfont (a$, C, XCoordinate, YCoordinate, size)

size = INT(size)             'No decimals allowed!
IF size > 10 THEN size = 10  'Check and fix invalid size calls
IF size < 1 THEN size = 1    'likewise for <.

YCoordinate = INT(YCoordinate / size)     'Prevent ballooning of YCoordinates
                                          'that is a result of using
                                          'size values larger than 1 for size


'Enter 999 as XCoordinate for centered text...
IF XCoordinate = 999 THEN XCoordinate = 160 - (LEN(a$) * 3 * size)

startx = XCoordinate               'set Starting X-Val for character drawing

FOR E = 1 TO LEN(a$)

   B$ = MID$(a$, E, 1)     ' read each character of the string
   a = ASC(B$)             ' get ASCII values of each character

      FOR x = 1 TO 8

         FOR y = 1 TO 6

            SELECT CASE charset(a, x, y)       'use ASCII value (a) to point
                                               'to the correct element in
                                               'the array

               CASE 0: col = 0                 ' Don't draw pixel

               CASE 1: col = C                 ' Draw pixel
              
               CASE ELSE                       ' Error!
                  CLS
                  SCREEN 9
                  BEEP
                  COLOR 4
                  PRINT "Error in FONTDATA.DAT"
                  PRINT "Program will now continue, but may exhibit erratic behavior..."
                  DO: LOOP UNTIL INKEY$ <> ""
                  SCREEN 13

            END SELECT

          IF col <> 0 THEN        'Draw a pixel!
           LINE (startx + pixelsright, (x + YCoordinate) * size)-(startx + pixelsright + (size - 1), ((x + YCoordinate) * size) + (size - 1)), col, BF
          END IF

          startx = startx + size     'Set starting X-value for next pixel
       
        NEXT y
      
       startx = XCoordinate          'reset startx for next line of pixels
    
     NEXT x
   pixelsright = pixelsright + (6 * size)   ' add pixels for next character

NEXT E

END SUB

SUB loadpal
DIM Pal(255) AS HUES                     'dim array for palette
DEF SEG = VARSEG(Pal(0))                 'point to it
BLOAD "default.pal", 0                   'load the goods
OUT &H3C8, 0                             'inform vga
FOR atrib = 0 TO 255                     'entire palette
 OUT &H3C9, Pal(atrib).Red               'send red component
 OUT &H3C9, Pal(atrib).grn               'send grn component
 OUT &H3C9, Pal(atrib).blu               'send blu component
NEXT atrib                               'next attribute
END SUB

SUB LoadTiles
GET (0, 0)-(19, 19), blank

viewspr ("tiles.spr")
GET (0, 0)-(19, 19), grass
GET (20, 0)-(39, 19), stone
GET (40, 0)-(59, 19), water
GET (60, 0)-(79, 19), Tree
GET (80, 0)-(99, 19), stump
GET (100, 0)-(119, 19), ruble
GET (0, 40)-(19, 59), path



GET (0, 20)-(19, 39), ushore
GET (20, 20)-(39, 39), dshore
GET (40, 20)-(59, 39), lshore
GET (60, 20)-(79, 39), rshore
GET (80, 20)-(99, 39), tlshore
GET (100, 20)-(119, 39), trshore
GET (120, 20)-(139, 39), blshore
GET (140, 20)-(159, 39), brshore
GET (160, 20)-(179, 39), itlshore
GET (180, 20)-(199, 39), itrshore
GET (200, 20)-(219, 39), iblshore
GET (220, 20)-(239, 39), ibrshore

GET (0, 40)-(19, 59), cpath

GET (0, 60)-(19, 79), farm.topleft
GET (20, 60)-(39, 79), farm.topright
GET (40, 60)-(59, 79), castle.topleft
GET (60, 60)-(79, 79), castle.topright
GET (100, 60)-(119, 79), townhall.topleft
GET (120, 60)-(139, 79), townhall.topright
GET (140, 60)-(159, 79), civil.topleft
GET (160, 60)-(179, 79), civil.topright
GET (0, 100)-(19, 119), mine.topleft
GET (20, 100)-(39, 119), mine.topright

GET (0, 80)-(19, 99), farm.bottomleft
GET (20, 80)-(39, 99), farm.bottomright
GET (40, 80)-(59, 99), castle.bottomleft
GET (60, 80)-(79, 99), castle.bottomright
GET (100, 80)-(119, 99), townhall.bottomleft
GET (120, 80)-(139, 99), townhall.bottomright
GET (140, 80)-(159, 99), civil.bottomleft
GET (160, 80)-(179, 99), civil.bottomright
GET (0, 120)-(19, 139), mine.bottomleft
GET (20, 120)-(39, 139), mine.bottomright
GET (0, 140)-(19, 159), enemy.knight


CLS

viewspr ("buttons.spr")
GET (0, 0)-(19, 19), cursor
GET (20, 0)-(39, 19), cursor02
GET (40, 0)-(59, 19), cursormask
GET (60, 0)-(79, 19), cursor02mask
GET (0, 20)-(19, 39), cursor2
GET (60, 20)-(79, 39), cursor2mask
GET (0, 40)-(19, 59), cursor3
GET (60, 40)-(79, 59), cursor3mask

GET (80, 0)-(99, 19), goldicon
GET (100, 0)-(119, 19), goldiconmask
GET (80, 20)-(99, 39), woodicon
GET (100, 20)-(119, 39), woodiconmask

GET (0, 60)-(39, 99), woodtext
GET (0, 60)-(19, 79), woodtextmini

GET (40, 60)-(59, 79), bricktext


GET (0, 100)-(39, 139), person.consultor
GET (40, 100)-(79, 139), person.ninja
GET (80, 100)-(119, 139), person.other
GET (120, 100)-(159, 139), person.snow
GET (160, 100)-(199, 139), person.mean







CLS
END SUB

SUB LoadWorld

WorldData.Rows = 50
WorldData.Cols = 50         ' Get the rows and cols to read.
RANDOMIZE TIMER

FOR I = 1 TO WorldData.Rows                   ' Go through a for loop to
FOR J = 1 TO WorldData.Cols                  ' load the world map data.

tempnum% = RND * 10


IF tempnum% >= 1 THEN map(J, I).tile = 2
IF tempnum% <= 1 THEN map(J, I).tile = 4

IF tempnum% = 10 THEN
f% = RND * 5
IF f% = 5 OR f% = 4 THEN map(J, I).tile = 5
END IF

IF map(J, I).tile = 0 THEN map(J, I).WalkOn = false
IF map(J, I).tile <> 0 THEN map(J, I).WalkOn = true

IF map(J, I).tile = 2 THEN PSET (J, I), 70
IF map(J, I).tile = 4 THEN PSET (J, I), 65
IF map(J, I).tile = 36 THEN PSET (J, I), 1
IF map(J, I).tile <> 2 AND map(J, I).tile <> 4 AND map(J, I).tile <> 36 THEN PSET (J, I), 70

NEXT J
NEXT I


' randomly places mine
a = RND * 49
B = RND * 49

map(a, B).tile = 37
map(a + 1, B).tile = 38
map(a, B + 1).tile = 39
map(a + 1, B + 1).tile = 40
PSET (a, B), 14


GET (1, 1)-(49, 50), smallmap


END SUB

SUB menu
PUT (0, 0), woodtext, PSET
PUT (39, 0), woodtext, PSET
PUT (0, 40), woodtext, PSET
PUT (39, 40), woodtext, PSET
PUT (0, 80), woodtext, PSET
PUT (39, 80), woodtext, PSET
PUT (0, 120), woodtext, PSET
PUT (39, 120), woodtext, PSET
PUT (0, 160), woodtext, PSET
PUT (39, 160), woodtext, PSET
LINE (0, 0)-(60, 199), 112, B
LINE (5, 5)-(55, 56), 0, BF
LINE (5, 5)-(55, 56), 112, B
LINE (24, 155)-(55, 195), 0, BF
LINE (23, 154)-(56, 196), 112, B

PUT (1, 155), goldiconmask, AND
PUT (1, 155), goldicon, OR
PUT (1, 175), woodiconmask, AND
PUT (1, 175), woodicon, OR
PUT (6, 6), smallmap, PSET

END SUB

SUB MoveDown

WorldData.Direc = South                       ' Change players direc to south.
CALL changeanim                               ' Change player animation state.

IF map(WorldData.TopCol + 8, WorldData.TopRow + 5 + 1).WalkOn = true THEN
WorldData.TopRow = WorldData.TopRow + 1      ' If the tile below them
END IF                                        '  (WD.TopRow + 5 + 1) is
                                              ' walkable, move there.
END SUB

SUB MoveLeft

WorldData.Direc = West                        ' Refer to SUB MoveDown.
CALL changeanim

IF map(WorldData.TopCol + 8 - 1, WorldData.TopRow + 5).WalkOn = true THEN
WorldData.TopCol = WorldData.TopCol - 1
END IF

END SUB

SUB MoveRight

WorldData.Direc = East                        ' Refer to SUB MoveDown.
CALL changeanim

IF map(WorldData.TopCol + 8 + 1, WorldData.TopRow + 5).WalkOn = true THEN
 WorldData.TopCol = WorldData.TopCol + 1
END IF

END SUB

SUB MoveUp

WorldData.Direc = North                       ' Refer to SUB MoveDown.
CALL changeanim

IF map(WorldData.TopCol + 8, WorldData.TopRow + 5 - 1).WalkOn = true THEN
WorldData.TopRow = WorldData.TopRow - 1
END IF
END SUB

SUB printFX (text AS STRING)
  DIM x AS INTEGER, y AS INTEGER
  DIM zoom AS SINGLE, I AS INTEGER, clock AS SINGLE
  DIM xOff AS INTEGER, yOff AS INTEGER
  DIM textLen AS INTEGER, banner AS INTEGER
limX = 319: limY = 199
tileSize = 17: pSize = 170
midX = limX \ 2 - tileSize \ 2: midY = limY \ 2 - tileSize \ 2

  IF LEFT$(text, 1) = ">" THEN
    text = RIGHT$(text, LEN(text) - 1)
    banner = 40
  END IF
PALETTE 1, 0
  COLOR 1
  LOCATE 1, 1
  PRINT text
textLen = LEN(text) * 8 - 3
  DIM pic(textLen, 7) AS INTEGER

  FOR x = 0 TO textLen
    FOR y = 0 TO 7
      IF POINT(x, y) = 1 THEN pic(x, y) = true
    NEXT
  NEXT
  CLS

  FOR I = 0 TO 35
    OUT 968, I + palMax + 1
    OUT 969, I + 15
    OUT 969, I + 15
    OUT 969, I + 15
  NEXT
  IF banner > 0 THEN
    FOR I = 0 TO 35
      OUT 968, I + banner + 1
      OUT 969, I + 15
      OUT 969, (I + 1) \ 4
      OUT 969, (I + 1) \ 4
    NEXT
  END IF

  FOR zoom = .2 TO 3.3 STEP .2
    xOff = midX - (textLen * zoom) \ 2 + zoom
    yOff = midY - (7 * zoom) \ 2 + zoom
    colr = palMax + 1 + zoom * 9 + zoom
    bancol = (banner + 1 + zoom * 9 + zoom) * SGN(banner)
    FOR x = 0 TO textLen
      FOR y = 0 TO 7
        IF pic(x, y) THEN
          LINE (xOff + x * zoom, yOff + y * zoom)-STEP(zoom, zoom), 8, BF
        ELSE
          LINE (xOff + x * zoom, yOff + y * zoom)-STEP(zoom, zoom), bancol, BF
        END IF
      NEXT
    NEXT
    clock = TIMER
    DO UNTIL clock + .001 - TIMER <= 0
    LOOP
  NEXT



END SUB

SUB PutCursorPic (cursor%)

IF cursor% = 1 THEN
IF WorldData.AnimCycle = 1 THEN
PUT (160, WorldData.PlayerY + 6), cursormask, AND
PUT (160, WorldData.PlayerY + 6), cursor, OR
END IF

IF WorldData.AnimCycle <> 1 THEN
PUT (160, WorldData.PlayerY + 6), cursor02mask, AND
PUT (160, WorldData.PlayerY + 6), cursor02, OR
END IF
END IF

IF cursor% = 2 THEN
PUT (160, WorldData.PlayerY + 6), cursor2mask, AND
PUT (160, WorldData.PlayerY + 6), cursor2, OR
END IF

IF cursor% = 3 THEN
PUT (160, WorldData.PlayerY + 6), cursor3mask, AND
PUT (160, WorldData.PlayerY + 6), cursor3, OR
END IF




END SUB

SUB PutTile (Ico, Jco, mapno)

SELECT CASE mapno
CASE 0
 PUT (Ico * 20, Jco * 20), blank, PSET
CASE 1
 PUT (Ico * 20, Jco * 20), ruble, PSET
CASE 5
 PUT (Ico * 20, Jco * 20), stone, PSET
CASE 2
 PUT (Ico * 20, Jco * 20), grass, PSET
CASE 3
 PUT (Ico * 20, Jco * 20), stump, PSET
CASE 4
 PUT (Ico * 20, Jco * 20), Tree, PSET
CASE 6
 PUT (Ico * 20, Jco * 20), ushore, PSET
CASE 7
 PUT (Ico * 20, Jco * 20), dshore, PSET
CASE 8
 PUT (Ico * 20, Jco * 20), lshore, PSET
CASE 9
 PUT (Ico * 20, Jco * 20), rshore, PSET
CASE 10
 PUT (Ico * 20, Jco * 20), tlshore, PSET
CASE 11
 PUT (Ico * 20, Jco * 20), trshore, PSET
CASE 12
 PUT (Ico * 20, Jco * 20), blshore, PSET
CASE 13
 PUT (Ico * 20, Jco * 20), brshore, PSET
CASE 14
 PUT (Ico * 20, Jco * 20), itlshore, PSET
CASE 15
 PUT (Ico * 20, Jco * 20), itrshore, PSET
CASE 16
 PUT (Ico * 20, Jco * 20), iblshore, PSET
CASE 17
 PUT (Ico * 20, Jco * 20), cpath, PSET
CASE 18
 PUT (Ico * 20, Jco * 20), farm.topleft, PSET
CASE 19
 PUT (Ico * 20, Jco * 20), farm.topright, PSET
CASE 20
 PUT (Ico * 20, Jco * 20), castle.topleft, PSET
CASE 21
 PUT (Ico * 20, Jco * 20), castle.topright, PSET
CASE 23
 PUT (Ico * 20, Jco * 20), townhall.topleft, PSET
CASE 24
 PUT (Ico * 20, Jco * 20), townhall.topright, PSET
CASE 25
 PUT (Ico * 20, Jco * 20), civil.topleft, PSET
CASE 26
 PUT (Ico * 20, Jco * 20), civil.topright, PSET
CASE 27
 PUT (Ico * 20, Jco * 20), farm.bottomleft, PSET
CASE 28
 PUT (Ico * 20, Jco * 20), farm.bottomright, PSET
CASE 29
 PUT (Ico * 20, Jco * 20), castle.bottomleft, PSET
CASE 30
 PUT (Ico * 20, Jco * 20), castle.bottomright, PSET
CASE 32
 PUT (Ico * 20, Jco * 20), townhall.bottomleft, PSET
CASE 33
 PUT (Ico * 20, Jco * 20), townhall.bottomright, PSET
CASE 34
 PUT (Ico * 20, Jco * 20), civil.bottomleft, PSET
CASE 35
 PUT (Ico * 20, Jco * 20), civil.bottomright, PSET
CASE 36
 PUT (Ico * 20, Jco * 20), water, PSET
CASE 37
 PUT (Ico * 20, Jco * 20), mine.topleft, PSET
CASE 38
 PUT (Ico * 20, Jco * 20), mine.topright, PSET
CASE 39
 PUT (Ico * 20, Jco * 20), mine.bottomleft, PSET
CASE 40
 PUT (Ico * 20, Jco * 20), mine.bottomright, PSET
CASE 41
 PUT (Ico * 20, Jco * 20), path, PSET


END SELECT

END SUB

SUB ShowMap

FOR I = 3 TO 15
FOR J = 0 TO 9
PutTile I, J, map(I + WorldData.TopCol, J + WorldData.TopRow).tile
NEXT J
NEXT I
                                           
END SUB

SUB talkwin (text$, text2$, text3$, text4$, text5$, text6$, text7$, text8$, more%)
DIM talkw(9000)
GET (7, 7)-(284, 54), talkw
LINE (10, 10)-(280, 50), 0, BF
LINE (9, 9)-(281, 51), 8, B
LINE (8, 8)-(282, 52), 7, B
LINE (7, 7)-(283, 53), 15, B
CALL jfont(text$, 15, 12, 12, 1)
CALL jfont(text2$, 15, 12, 20, 1)
CALL jfont(text3$, 15, 12, 28, 1)
CALL jfont(text4$, 15, 12, 38, 1)

DO
x$ = INKEY$
LOOP UNTIL x$ = CHR$(13)
IF more% = 1 THEN
LINE (10, 10)-(280, 50), 0, BF
LINE (9, 9)-(281, 51), 8, B
LINE (8, 8)-(282, 52), 7, B
LINE (7, 7)-(283, 53), 15, B
CALL jfont(text5$, 15, 12, 12, 1)
CALL jfont(text6$, 15, 12, 20, 1)
CALL jfont(text7$, 15, 12, 28, 1)
CALL jfont(text8$, 15, 12, 38, 1)

DO
x$ = INKEY$
LOOP UNTIL x$ = CHR$(13)
END IF
PUT (7, 7), talkw, PSET
END SUB

SUB viewspr (filename$)

OPEN filename$ FOR BINARY AS #1
filesize& = LOF(1)
CLOSE #1


Bytes = (filesize& - 7) \ 2 - 1        'BSAVE & BLOAD use 7 bytes
REDIM sprites(Bytes)                   'redim the sprite array
DEF SEG = VARSEG(sprites(0))           'point to it
BLOAD filename$, 0                     'load the sprite file
spritewidth = sprites(0) \ 8           'get sprite width
spriteheight = sprites(1)              'get sprite height


xsprites = 319 \ (spritewidth + 1)  'calc number of sprites across
xend = spritewidth * (xsprites - 1) + xsprites   'last one
ElmPerSprite = ((spritewidth * spriteheight) \ 2) + 3  'elements per image


                                    'clear the screen

x = 0: y = 0                           'first sprite location
offset = 0                             'point to sprite


DO
  PUT (x, y), sprites(offset), PSET    'PUT image
  x = x + spritewidth                  'next column
  IF x > xend THEN                     'end of row?
    x = 0                              'restart
    y = y + spriteheight               'next row
  END IF
  offset = offset + ElmPerSprite       'point to next sprite
LOOP WHILE offset < Bytes              'do all the images

END SUB

