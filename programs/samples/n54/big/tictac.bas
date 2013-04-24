DECLARE FUNCTION XWin% (b1 AS INTEGER, b2 AS INTEGER, b3 AS INTEGER, l AS INTEGER)
DECLARE FUNCTION OWin% (b1 AS INTEGER, b2 AS INTEGER, b3 AS INTEGER, l AS INTEGER)
DECLARE SUB Winner (Lineup AS INTEGER)
DECLARE SUB ShowWin (b1 AS INTEGER, b2 AS INTEGER, b3 AS INTEGER)
DECLARE SUB GetUserSignal ()
DECLARE SUB EnableMouse (c%)
DECLARE SUB DrawSCREEN ()
DECLARE SUB xo (Row%, Col%, symbol%)

DIM SHARED False AS INTEGER, True AS INTEGER: True = NOT False
DIM SHARED SymbolBOX(6000) AS INTEGER '<---NOTE

DIM SHARED cH AS INTEGER: 'Cursor Position Horizontal
DIM SHARED cV AS INTEGER: 'Cursor Position Vertical
DIM SHARED click AS INTEGER: ' 0=no click, 1=left click, 2=right
' EnableMouse 1 = Turn cursor on, return coordinates
' EnableMouse 0 = Turn cursor off in order to draw stuff, etc.
DIM SHARED cC AS STRING: 'User pressed key
' GetUserSignal will set return cC or will return Click

DIM i AS INTEGER, j AS INTEGER, k AS INTEGER
DIM WhoWon AS INTEGER
DIM MadeAMove AS INTEGER, MovesMade AS INTEGER

' ----------------------------------------------------------
' Title Screen (Main Program)
' -----------------------------------------------------------
SCREEN 12
RANDOMIZE TIMER
DIM Command AS INTEGER, Hard AS INTEGER
GOSUB InitializeScreen
DO
DO: GetUserSignal: LOOP UNTIL click = 1
GOSUB FindClickedCommand
SELECT CASE Command
CASE 1:
Hard = False
WhoWon = 0
GOSUB PlayGame
GOSUB ShowWhoWon
GOSUB InitializeScreen
CASE 2:
Hard = True
WhoWon = 0
GOSUB PlayGame
GOSUB ShowWhoWon
GOSUB InitializeScreen
CASE 3:
GOSUB DoHelp
GOSUB InitializeScreen
CASE 4:
EXIT DO
END SELECT
LOOP
COLOR 7: CLS
SYSTEM

' ----------------------------------------------------------
' Game Screen
' -----------------------------------------------------------
DIM SHARED zX(9) AS INTEGER: ' Where all X's are placed
DIM SHARED zO(9) AS INTEGER: ' Where all O's are placed
DIM SHARED zE(9) AS INTEGER: ' Where empty squares are
DIM theRow AS INTEGER, theColumn AS INTEGER, theBox AS INTEGER

FindClickedPosition:
CONST Delta = 4
theRow = 0: theColumn = 0: theBox = 0
SELECT CASE cH
CASE IS < 170 + Delta: RETURN
CASE IS < 269 - Delta: theColumn = 1
CASE IS < 269 + Delta: RETURN
CASE IS < 368 - Delta: theColumn = 2
CASE IS < 368 + Delta: RETURN
CASE IS < 467 - Delta: theColumn = 3
CASE ELSE: RETURN
END SELECT
SELECT CASE cV
CASE IS < 91 + Delta: RETURN
CASE IS < 190 - Delta: theRow = 1
CASE IS < 190 + Delta: RETURN
CASE IS < 289 - Delta: theRow = 2
CASE IS < 289 + Delta: RETURN
CASE IS < 388 - Delta: theRow = 3
CASE ELSE: RETURN
END SELECT
theBox = (3 * (theRow - 1)) + theColumn
RETURN

' ----------------------------------------------------------
' Play Game
' -----------------------------------------------------------
PlayGame:
DrawSCREEN 'draw the screen and create X and O symbols.
FOR i = 1 TO 9: zO(i) = False: zX(i) = False: zE(i) = True: NEXT i
MovesMade = 0
DO
GetUserSignal
IF click THEN
MadeAMove = False
GOSUB MakeX
IF MadeAMove THEN
WhoWon = 1: GOSUB ComputeWin: IF WhoWon = 1 THEN RETURN
t% = 0
FOR i = 1 TO 9: t% = t% + zX(i): NEXT i
IF t% = -5 THEN WhoWon = 0: RETURN
MovesMade = MovesMade + 1
GOSUB MakeO
WhoWon = 2: GOSUB ComputeWin: IF WhoWon = 2 THEN RETURN
END IF
END IF
IF cC = "d" OR cC = CHR$(27) THEN WhoWon = 3
IF WhoWon > 0 THEN RETURN
LOOP

MakeX:
GOSUB FindClickedPosition
IF theBox = 0 THEN RETURN
IF NOT zE(theBox) THEN RETURN
xo theRow, theColumn, 1: ' Places an X
zX(theBox) = True: zE(theBox) = False
MadeAMove = True
RETURN

MakeO:
GOSUB FindPlaceForO
SLEEP 1: WHILE INKEY$ <> "": WEND
xo theRow, theColumn, 0: 'Places an O
zO(theBox) = True: zE(theBox) = False
RETURN

ComputeWin:
IF WhoWon = 1 THEN
IF XWin(1, 2, 3, 1) THEN RETURN
IF XWin(4, 5, 6, 2) THEN RETURN
IF XWin(7, 8, 9, 3) THEN RETURN
IF XWin(1, 4, 7, 4) THEN RETURN
IF XWin(2, 5, 8, 5) THEN RETURN
IF XWin(3, 6, 9, 6) THEN RETURN
IF XWin(1, 5, 9, 7) THEN RETURN
IF XWin(3, 5, 7, 8) THEN RETURN
ELSE
IF OWin(1, 2, 3, 1) THEN RETURN
IF OWin(4, 5, 6, 2) THEN RETURN
IF OWin(7, 8, 9, 3) THEN RETURN
IF OWin(1, 4, 7, 4) THEN RETURN
IF OWin(2, 5, 8, 5) THEN RETURN
IF OWin(3, 6, 9, 6) THEN RETURN
IF OWin(1, 5, 9, 7) THEN RETURN
IF OWin(3, 5, 7, 8) THEN RETURN
END IF
WhoWon = 0
RETURN

FindPlaceForO:
' See if there is a win for O. If so, take it.
' See if there is a threat of a win for X. If so, block it.
FOR TestType% = 1 TO 2
theBox = 0
FOR theRow = 1 TO 3: FOR theColumn = 1 TO 3
theBox = theBox + 1
IF zE(theBox) THEN
tk$ = ""
SELECT CASE theBox
CASE 1: tk$ = "234759"
CASE 2: tk$ = "1358"
CASE 3: tk$ = "126957"
CASE 4: tk$ = "1756"
CASE 5: tk$ = "19283746"
CASE 6: tk$ = "4539"
CASE 7: tk$ = "148935"
CASE 8: tk$ = "2579"
CASE 9: tk$ = "153678"
END SELECT
FOR i = 1 TO LEN(tk$) STEP 2
j = VAL(MID$(tk$, i, 1))
k = VAL(MID$(tk$, i + 1, 1))
IF TestType% = 1 THEN
IF zO(j) + zO(k) < -1 THEN RETURN
ELSE
IF zX(j) + zX(k) < -1 THEN RETURN
END IF
NEXT i
END IF
NEXT theColumn: NEXT theRow
NEXT TestType%
' No move selected above to win or block win, so
IF Hard THEN
IF MovesMade = 1 THEN
IF zE(5) THEN
theRow = 2: theColumn = 2: theBox = 5
ELSE
IF RND > .5 THEN theRow = 1 ELSE theRow = 3
IF RND > .5 THEN theColumn = 1 ELSE theColumn = 3
theBox = (3 * (theRow - 1)) + theColumn
END IF
RETURN
ELSEIF MovesMade = 2 THEN
IF zX(5) THEN
tk$ = ""
IF zO(1) AND zX(9) THEN
tk$ = "37"
ELSEIF zO(3) AND zX(7) THEN
tk$ = "19"
ELSEIF zO(7) AND zX(3) THEN
tk$ = "19"
ELSEIF zO(9) AND zX(1) THEN
tk$ = "37"
END IF
IF tk$ <> "" THEN
IF RND > .5 THEN
theBox = VAL(LEFT$(tk$, 1))
ELSE
theBox = VAL(LEFT$(tk$, 1))
END IF
theRow = (theBox + 2) \ 3
theColumn = theBox - (3 * (theRow - 1))
RETURN
END IF
ELSE
DO
DO: theBox = 2 * INT(1 + (RND * 4)): LOOP WHILE NOT zE(theBox)
SELECT CASE theBox
CASE 2: IF NOT zX(8) THEN EXIT DO
CASE 4: IF NOT zX(6) THEN EXIT DO
CASE 6: IF NOT zX(4) THEN EXIT DO
CASE 8: IF NOT zX(2) THEN EXIT DO
END SELECT
LOOP
theRow = (theBox + 2) \ 3
theColumn = theBox - (3 * (theRow - 1))
RETURN
END IF
END IF
END IF
' OK, no good move was found. Make a random one
DO: theBox = 1 + INT(RND * 9): LOOP WHILE NOT zE(theBox)
theRow = (theBox + 2) \ 3
theColumn = theBox - (3 * (theRow - 1))
RETURN

Shuffle:
DO WHILE LEN(w1$) < 4
r% = 1 + INT(RND * 4)
IF MID$(w2$, r%, 1) <> "x" THEN
w1$ = w1$ + MID$(w2$, r%, 1)
MID$(w2$, r%, 1) = "x"
END IF
LOOP
RETURN

ShowWhoWon:
SELECT CASE WhoWon
CASE 0: c$ = "Tie! "
CASE 1: c$ = "YOU WIN! "
CASE 2: c$ = "YOU LOSE! "
CASE 3: c$ = "YOU RESIGNED?"
END SELECT
IF WhoWon < 3 THEN SLEEP 2: WHILE INKEY$ <> "": WEND
CLS
FOR i = 1 TO 30
COLOR 1 + INT(RND * 15)
LOCATE i, i + 20
PRINT c$;
NEXT i
SLEEP 3: WHILE INKEY$ <> "": WEND
RETURN

InitializeScreen:
CLS
COLOR 15
LOCATE 4, 23: PRINT "TIC TAC TOE by Paul Meyer & TheBOB"
LOCATE 6, 27: PRINT "(C) 2004 - 2007 Dos-Id Games"
COLOR 3
ds% = 131: dd% = 97: dz% = 75
LINE (ds%, 343)-(ds% + dz%, 380), , BF
LINE (ds% + (1 * dd%), 343)-(ds% + (1 * dd%) + dz%, 380), , BF
LINE (ds% + (2 * dd%), 343)-(ds% + (2 * dd%) + dz%, 380), , BF
LINE (ds% + (3 * dd%), 343)-(ds% + (3 * dd%) + dz%, 380), , BF
LOCATE 23, 19: PRINT " Easy ";
LOCATE , 31: PRINT " Hard ";
LOCATE , 43: PRINT " Info ";
LOCATE , 55: PRINT " Quit "
RETURN

FindClickedCommand:
Command = 0
SELECT CASE cV
CASE IS < 343: RETURN
CASE IS > 380: RETURN
END SELECT
SELECT CASE cH
CASE IS < 130: RETURN
CASE IS < 205: Command = 1
CASE IS < 227: RETURN
CASE IS < 303: Command = 2
CASE IS < 325: RETURN
CASE IS < 400: Command = 3
CASE IS < 421: RETURN
CASE IS < 497: Command = 4
END SELECT
RETURN


DoHelp:
CLS
COLOR 2
LOCATE 3, 1
PRINT "Credits"
PRINT "-------"
PRINT "This game was created by Paul Meyer in the year 2007."
PRINT : PRINT "Graphics by TheBob"
PRINT : PRINT "Improved mouse driver, modularity, machine play-to-win";
PRINT " by QBasic Mac"
PRINT : PRINT "History:"
PRINT "http://www.network54.com/Forum/190883/message/1175106480"
PRINT
PRINT "This is freeware, you may change this as much as you want"
PRINT "as long as you don't claim it as yours."
PRINT
PRINT
PRINT "About"
PRINT "-----"
PRINT "This is just a simple TIC TAC TOE game with mouse drivers."
PRINT "This game was created in QuickBasic."
CALL GetUserSignal
CLS
RETURN

SUB DrawSCREEN
DIM x AS INTEGER, y AS INTEGER
STATIC Finished AS INTEGER
CLS
OUT &H3C8, 0: OUT &H3C9, 0: OUT &H3C9, 0: OUT &H3C9, 18
OUT &H3C8, 4: OUT &H3C9, 63: OUT &H3C9, 0: OUT &H3C9, 0
OUT &H3C8, 9: OUT &H3C9, 0: OUT &H3C9, 12: OUT &H3C9, 48
OUT &H3C8, 11: OUT &H3C9, 0: OUT &H3C9, 18: OUT &H3C9, 54
COLOR 7: LOCATE 3, 31: PRINT "T I C - T A C - T O E"
LINE (170, 90)-(490, 410), 0, BF
LINE (160, 81)-(479, 399), 1, BF
LINE (155, 76)-(483, 404), 8, B
LINE (152, 73)-(487, 407), 8, B
LINE (160, 81)-(160, 399), 9
LINE (160, 81)-(479, 81), 9
LINE (371, 92)-(372, 393), 0, B
LINE (271, 92)-(272, 392), 0, B
LINE (171, 191)-(472, 192), 0, B
LINE (171, 291)-(472, 292), 0, B
LINE (369, 90)-(370, 390), 13, B
LINE (269, 90)-(270, 390), 13, B
LINE (169, 189)-(470, 190), 13, B
LINE (169, 289)-(470, 290), 13, B
LINE (5, 5)-(634, 474), 8, B
LINE (10, 10)-(629, 469), 8, B
IF Finished THEN EXIT SUB
Finished = True
FOR x = 194 TO 500
FOR y = 32 TO 46
IF POINT(x, y) = 8 THEN PSET (x, y), 7
NEXT y
NEXT x
PSET (188, 108), 0
DRAW "E3 F30 E30 F6 G30 F30 G6 H30 G30 H6 E30 H30 E3 BF2 P0,0"
PSET (186, 106), 10
DRAW "E3 F30 E30 F6 G30 F30 G6 H30 G30 H6 E30 H30 E3 BF2 P10,10"
CIRCLE (322, 141), 31, 0
CIRCLE (322, 141), 37, 0
PAINT STEP(0, 35), 0
PSET STEP(0, -35), 0
CIRCLE (320, 139), 31, 4
CIRCLE (320, 139), 37, 4
PAINT STEP(0, 35), 4
PSET STEP(0, -35), 1
GET STEP(-40, -40)-STEP(81, 81), SymbolBOX
GET (179, 98)-(260, 178), SymbolBOX(3000)
xo 1, 1, 2: xo 1, 2, 2
END SUB

SUB EnableMouse (c%)
STATIC Status AS INTEGER
IF Status = 0 AND c% = 0 THEN EXIT SUB
STATIC Mx AS STRING
IF Mx = "" THEN
m$ = "58E85080585080585080850815510C358508058508085080850815C00"
n$ = "595BECB70BEAB70BE8BFBE6B7B8E7D33BEC978BEA97BE89FBE697DA80"
Mx = SPACE$(57)
FOR i% = 1 TO 57
H$ = CHR$(VAL("&H" + MID$(m$, i%, 1) + MID$(n$, i%, 1)))
MID$(Mx, i%, 1) = H$
NEXT i%
END IF
IF c% = 0 THEN
CALL Absolute(2, click, cH, cV, SADD(Mx))
Status = 0
EXIT SUB
END IF
IF Status = 0 THEN CALL Absolute(1, click, cH, cV, SADD(Mx))
Status = 1
CALL Absolute(3, click, cH, cV, SADD(Mx))
END SUB

SUB GetUserSignal
DO
IF 0 THEN ' Set to 1 for Debugging printout, otherwise 0
LOCATE 2, 1
PRINT click; "<Click"
PRINT cH; "ch (Horizontal)"
PRINT cV; "cv (Verticle)"
END IF
EnableMouse 1
IF click > 0 THEN
k% = click
WHILE click <> 0: EnableMouse 1: WEND
click = k%
EXIT DO
END IF
cC = INKEY$
LOOP WHILE cC = ""
EnableMouse 0
END SUB

FUNCTION OWin% (b1 AS INTEGER, b2 AS INTEGER, b3 AS INTEGER, l AS INTEGER)
IF zO(b1) = 0 OR zO(b2) = 0 OR zO(b3) = 0 THEN EXIT FUNCTION
Winner l
OWin% = -1
END FUNCTION

SUB Winner (Lineup AS INTEGER)
SELECT CASE Lineup
CASE 1: LINE (200, 140)-(440, 142), 14, BF: LINE (200, 143)-(440, 144), 0, B
CASE 2: LINE (200, 240)-(440, 242), 14, BF: LINE (200, 243)-(440, 244), 0, B
CASE 3: LINE (200, 340)-(440, 342), 14, BF: LINE (200, 343)-(440, 344), 0, B
CASE 4: LINE (220, 120)-(222, 360), 14, BF: LINE (223, 120)-(223, 360), 0
CASE 5: LINE (320, 120)-(322, 360), 14, BF: LINE (323, 120)-(323, 360), 0
CASE 6: LINE (420, 120)-(422, 360), 14, BF: LINE (423, 120)-(423, 360), 0
CASE 7: PSET (200, 120), 14: DRAW "F240 d H240 d F240 d H240 d C0 F240 d H240"
CASE 8: PSET (440, 120), 14: DRAW "G240 d E240 d G240 d E240 d C0 G240 d E240"
END SELECT
END SUB

SUB xo (Row AS INTEGER, Col AS INTEGER, symbol AS INTEGER)
DIM Index AS INTEGER, x AS INTEGER, y AS INTEGER
x = (Col - 1) * 100 + 180
y = (Row - 1) * 100 + 100
Index = symbol * 3000
IF Index < 6000 THEN
PUT (x, y), SymbolBOX(Index), PSET
ELSE
LINE (x, y)-(x + 80, y + 80), 1, BF
END IF
END SUB

FUNCTION XWin% (b1 AS INTEGER, b2 AS INTEGER, b3 AS INTEGER, l AS INTEGER)
IF zX(b1) = 0 OR zX(b2) = 0 OR zX(b3) = 0 THEN EXIT FUNCTION
Winner l
XWin% = -1
END FUNCTION