'*****************************************************************************
'
'--------------------------- R A T T L E R . B A S ---------------------------
'
'---------------- Copyright (C) 2003 by Bob Seguin (Freeware) ----------------
'
'------------------------ Email: BOBSEG@sympatico.ca -------------------------
'
'--------------------- RATTLER is a graphical version of ---------------------
'--------------------- the classic QBasic game, NIBBLES ----------------------
'
'*****************************************************************************

DEFINT A-Z

DECLARE SUB DrawSCREEN ()
DECLARE SUB Intro ()
DECLARE SUB Instructions ()
DECLARE SUB InitGAME ()
DECLARE SUB InitLEVEL ()
DECLARE SUB PauseMENU (Item)
DECLARE SUB PlayGAME ()
DECLARE SUB TopTEN ()
DECLARE SUB SpeedSET ()
DECLARE SUB PutSPRITE (Col, Row, Index)
DECLARE SUB SetSTONES (Level)
DECLARE SUB PrintNUMS (Item, Value)
DECLARE SUB SetPALETTE ()
DECLARE SUB Wipe ()
DECLARE FUNCTION EndGAME ()

DIM SHARED SnakePIT(1 TO 32, 1 TO 24)
DIM SHARED WipeBOX(29, 21)

REDIM SHARED SpriteBOX(8000)
REDIM SHARED NumBOX(400)
REDIM SHARED TTBox(480)
REDIM SHARED BigBOX(32000)

'The following constants are used to determine sprite array indexes
CONST Head = 0
CONST Neck = 500
CONST Shoulders = 1000
CONST Body = 1500
CONST Tail = 2000
CONST TailEND = 2500
CONST Rattle = 3000

CONST Mouse = 6000
CONST Frog = 6500
CONST Stone = 7000
CONST Blank = 7500

CONST TURN = 3000

CONST Left = 0
CONST Up = 125
CONST Right = 250
CONST Down = 375

CONST DL = 0
CONST DR = 125
CONST UR = 250
CONST UL = 375
CONST RD = 375
CONST LD = 250
CONST LU = 125
CONST RU = 0

TYPE DiamondBACK
Row AS INTEGER
Col AS INTEGER
BodyPART AS INTEGER
TURN AS INTEGER
WhichWAY AS INTEGER
RattleDIR AS INTEGER
END TYPE
DIM SHARED Rattler(72) AS DiamondBACK

TYPE ScoreTYPE
PlayerNAME AS STRING * 20
PlayDATE AS STRING * 10
PlayerSCORE AS LONG
END TYPE
DIM SHARED ScoreDATA(10) AS ScoreTYPE

DIM SHARED SnakeLENGTH
DIM SHARED SetSPEED
DIM SHARED Speed
DIM SHARED SpeedLEVEL
DIM SHARED Level
DIM SHARED Lives
DIM SHARED Score
DIM SHARED CrittersLEFT

OPEN "rattler.top" FOR APPEND AS #1
CLOSE #1

OPEN "rattler.top" FOR INPUT AS #1
DO WHILE NOT EOF(1)
INPUT #1, ScoreDATA(n).PlayerNAME
INPUT #1, ScoreDATA(n).PlayDATE
INPUT #1, ScoreDATA(n).PlayerSCORE
n = n + 1
LOOP
CLOSE #1

RANDOMIZE TIMER

SCREEN 12
GOSUB DrawSPRITES
DrawSCREEN

Intro

DO
PlayGAME
LOOP

END

'------------------------- SUBROUTINE SECTION BEGINS -------------------------

DrawSPRITES:
'Creates images from compressed data

'Set all attributes to black (REM out to view the process)
FOR n = 1 TO 15
OUT &H3C8, n
OUT &H3C9, 0
OUT &H3C9, 0
OUT &H3C9, 0
NEXT n

OUT &H3C8, 9
OUT &H3C9, 52
OUT &H3C9, 42
OUT &H3C9, 32
LOCATE 12, 32: COLOR 9
PRINT "ONE MOMENT PLEASE..."

MaxWIDTH = 19
MaxDEPTH = 279
x = 0: y = 0

DO
READ Count, Colr
FOR Reps = 1 TO Count
PSET (x, y), Colr
x = x + 1
IF x > MaxWIDTH THEN
x = 0
y = y + 1
END IF
NEXT Reps
LOOP UNTIL y > MaxDEPTH

'Create directional sets
Index = 0
FOR y = 0 TO 260 STEP 20
GET (0, y)-(19, y + 19), SpriteBOX(Index)
GOSUB Poses
Index = Index + 500
NEXT y
CLS
PALETTE 9, 0
'Create stone block and erasing sprite(s)
LINE (0, 0)-(19, 19), 6, BF
FOR Reps = 1 TO 240
x = FIX(RND * 20) + 1
y = FIX(RND * 20) + 1
PSET (x, y), 7
PSET (x + 1, y + 1), 15
NEXT Reps
LINE (0, 0)-(19, 19), 6, B
LINE (1, 1)-(18, 18), 13, B
LINE (1, 1)-(1, 18), 15
LINE (1, 1)-(18, 1), 15
GET (0, 0)-(19, 19), SpriteBOX(Stone) 'stone tile
LINE (0, 0)-(19, 19), 8, BF
GET (0, 0)-(19, 19), SpriteBOX(Blank + Left) 'erasing tile
GET (0, 0)-(19, 19), SpriteBOX(Blank + Up) 'erasing tile
GET (0, 0)-(19, 19), SpriteBOX(Blank + Right) 'erasing tile
GET (0, 0)-(19, 19), SpriteBOX(Blank + Down) 'erasing tile
CLS
COLOR 9
LOCATE 9, 31
PRINT "RATTLER TOP-TEN LIST"
GET (240, 130)-(398, 140), TTBox
LOCATE 9, 31
PRINT SPACE$(20)

'GET numbers
FOR n = 0 TO 9
LOCATE 10, 10
IF n = 0 THEN PRINT "O" ELSE PRINT LTRIM$(STR$(n))
FOR x = 72 TO 80
FOR y = 144 TO 160
IF POINT(x, y) = 0 THEN PSET (x, y), 15 ELSE PSET (x, y), 4
NEXT y
NEXT x
GET (72, 144)-(79, 156), NumBOX(NumDEX)
NumDEX = NumDEX + 40
NEXT n
LINE (72, 144)-(80, 160), 0, BF
RETURN

Poses:
'Draws/GETs the other 3 directional poses from each sprite
FOR i = Index TO Index + 250 STEP 125
PUT (100, 100), SpriteBOX(i), PSET
FOR Px = 100 TO 119
FOR Py = 100 TO 119
PSET (219 - Py, Px - 20), POINT(Px, Py)
NEXT Py
NEXT Px
GET (100, 80)-(119, 99), SpriteBOX(i + 125)
NEXT i
RETURN

SpriteVALUES:
DATA 47,8,2,12,2,0,16,8,3,5,1,12,1,13,1,12,1,13,1,12,8,8,1,0
DATA 1,12,1,15,1,8,1,15,3,5,1,14,3,1,1,14,1,13,5,8,2,5,1,12
DATA 1,5,4,12,3,3,1,5,1,12,1,3,1,12,1,14,1,13,2,8,1,3,14,5
DATA 1,3,1,5,1,1,1,13,1,3,1,5,1,12,1,5,1,12,1,5,1,12,1,5
DATA 1,12,1,5,1,12,3,5,1,12,1,5,1,12,2,3,1,1,22,5,1,12,1,5
DATA 1,12,1,3,1,12,1,3,1,12,1,3,1,12,1,3,1,12,1,15,1,12,1,3
DATA 1,12,1,3,1,12,1,3,2,5,1,12,1,5,1,12,1,3,1,12,1,3,1,12
DATA 1,3,1,12,1,3,1,12,1,15,1,12,1,3,1,12,1,3,1,12,1,3,17,5
DATA 1,3,2,5,1,3,1,5,1,12,1,5,1,12,1,5,1,12,1,5,1,12,1,5
DATA 1,12,3,5,1,12,1,5,1,12,2,3,1,1,1,8,1,3,14,5,1,3,1,14
DATA 1,1,1,13,2,8,2,5,1,12,1,5,4,12,2,3,1,1,1,5,1,12,1,1
DATA 1,12,1,14,1,13,4,8,1,0,1,12,1,15,1,8,1,15,3,5,2,14,2,1
DATA 1,14,1,13,10,8,2,5,1,14,1,12,1,13,1,12,1,13,1,12,12,8,2,12
DATA 2,0,169,8,1,13,1,12,1,13,1,1,1,13,1,12,1,13,1,1,1,13,1,12
DATA 1,13,1,12,1,13,1,1,1,13,1,12,1,13,1,1,1,13,1,12,1,1,1,14
DATA 1,1,1,14,1,12,1,14,1,12,1,14,1,1,1,14,1,1,1,14,1,1,1,14
DATA 1,12,1,14,1,12,1,14,1,1,1,14,2,3,1,5,1,12,1,5,1,12,1,5
DATA 1,12,1,5,3,3,1,5,1,12,1,5,1,12,1,5,1,12,1,5,3,3,1,12
DATA 1,5,1,12,1,5,1,12,1,5,1,12,1,5,2,3,1,12,1,5,1,12,1,5
DATA 1,12,1,5,1,12,1,5,1,3,1,5,1,12,1,5,1,12,1,5,1,12,1,5
DATA 1,12,1,5,1,3,1,5,1,12,1,5,1,12,1,5,1,12,1,5,1,12,1,5
DATA 2,3,1,5,1,12,1,5,1,12,1,5,1,12,1,5,3,3,1,5,1,12,1,5
DATA 1,12,1,5,1,12,1,5,1,3,1,1,1,14,1,1,1,14,1,12,1,14,1,12
DATA 1,14,1,1,1,14,1,1,1,14,1,1,1,14,1,12,1,14,1,12,1,14,1,1
DATA 1,14,1,13,1,12,1,13,1,1,1,13,1,12,1,13,1,1,1,13,1,12,1,13
DATA 1,12,1,13,1,1,1,13,1,12,1,13,1,1,1,13,1,12,220,8,1,12,1,13
DATA 1,12,1,13,1,12,1,13,1,12,1,13,1,12,1,13,1,12,1,13,1,12,1,13
DATA 1,12,1,13,1,12,1,13,1,12,1,13,1,14,1,12,1,14,1,1,1,14,1,12
DATA 1,14,1,1,1,14,1,12,1,14,1,12,1,14,1,1,1,14,1,12,1,14,1,1
DATA 1,14,2,12,1,14,1,3,1,14,1,12,1,14,1,12,1,14,1,3,1,14,1,12
DATA 1,14,1,3,1,14,1,12,1,14,1,12,1,14,1,3,1,14,1,5,1,3,1,5
DATA 1,12,1,5,1,12,1,5,1,12,1,5,1,3,1,5,1,3,1,5,1,12,1,5
DATA 1,12,1,5,1,12,1,5,1,3,1,15,1,5,1,12,1,5,1,12,1,5,1,12
DATA 1,5,1,12,1,5,1,15,1,5,1,12,1,5,1,12,1,5,1,12,1,5,1,12
DATA 1,5,1,15,1,5,1,12,1,5,1,12,1,5,1,12,1,5,1,12,1,5,1,15
DATA 1,5,1,12,1,5,1,12,1,5,1,12,1,5,1,12,2,5,1,3,1,5,1,12
DATA 1,5,1,12,1,5,1,12,1,5,1,3,1,5,1,3,1,5,1,12,1,5,1,12
DATA 1,5,1,12,1,5,1,3,1,12,1,14,1,3,1,14,1,12,1,14,1,12,1,14
DATA 1,3,1,14,1,12,1,14,1,3,1,14,1,12,1,14,1,12,1,14,1,3,2,14
DATA 1,12,1,14,1,1,1,14,1,12,1,14,1,1,1,14,1,12,1,14,1,12,1,14
DATA 1,1,1,14,1,12,1,14,1,1,1,14,2,12,1,13,1,12,1,13,1,12,1,13
DATA 1,12,1,13,1,12,1,13,1,12,1,13,1,12,1,13,1,12,1,13,1,12,1,13
DATA 1,12,1,13,180,8,1,13,1,12,1,13,1,12,1,13,1,1,1,13,1,12,1,13
DATA 1,12,1,13,1,12,1,13,1,12,1,13,1,1,1,13,1,12,1,13,2,12,1,14
DATA 1,12,1,14,1,1,1,5,1,1,1,14,1,12,1,14,1,12,1,14,1,12,1,14
DATA 1,1,1,5,1,1,1,14,1,12,2,14,1,12,1,14,1,1,1,14,1,12,1,14
DATA 1,1,1,14,1,12,1,14,1,12,1,14,1,1,1,14,1,12,1,14,1,1,1,14
DATA 2,12,1,5,1,3,1,5,1,12,1,5,1,12,1,5,1,3,1,5,1,12,1,5
DATA 1,3,1,5,1,12,1,5,1,12,1,5,1,3,2,5,1,3,1,5,1,12,1,5
DATA 1,12,1,5,1,12,1,5,1,3,1,5,1,3,1,5,1,12,1,5,1,12,1,5
DATA 1,12,1,5,1,3,1,15,1,5,1,12,1,5,1,12,1,5,1,12,1,5,1,12
DATA 1,5,1,15,1,5,1,12,1,5,1,12,1,5,1,12,1,5,1,12,1,5,1,15
DATA 1,5,1,12,1,5,1,12,1,5,1,12,1,5,1,12,1,5,1,15,1,5,1,12
DATA 1,5,1,12,1,5,1,12,1,5,1,12,2,5,1,3,1,5,1,12,1,5,1,12
DATA 1,5,1,12,1,5,1,3,1,5,1,3,1,5,1,12,1,5,1,12,1,5,1,12
DATA 1,5,1,3,1,12,1,5,1,3,1,5,1,12,1,5,1,12,1,5,1,3,1,5
DATA 1,12,1,5,1,3,1,5,1,12,1,5,1,12,1,5,1,3,1,5,1,14,1,12
DATA 1,14,1,1,1,14,1,12,1,14,1,1,1,14,1,12,1,14,1,12,1,14,1,1
DATA 1,14,1,12,1,14,1,1,1,14,2,12,1,14,1,12,1,14,1,1,1,14,1,1
DATA 1,14,1,12,1,14,1,12,1,14,1,12,1,14,1,1,1,14,1,1,1,14,1,12
DATA 1,14,1,13,1,12,1,13,1,12,1,13,1,1,1,13,1,12,1,13,1,12,1,13
DATA 1,12,1,13,1,12,1,13,1,1,1,13,1,12,1,13,1,12,220,8,1,12,1,13
DATA 1,1,1,13,1,12,1,13,1,12,1,13,1,1,1,13,1,12,1,13,1,1,1,13
DATA 1,12,1,13,1,12,1,13,1,1,1,13,1,14,1,1,1,14,1,12,1,14,1,12
DATA 1,14,1,12,1,14,1,1,1,14,1,1,1,14,1,12,1,14,1,12,1,14,1,12
DATA 1,14,1,1,1,15,1,5,1,12,1,5,1,12,1,5,1,12,1,5,1,12,1,5
DATA 1,15,1,5,1,12,1,5,1,12,1,5,1,12,1,5,1,12,1,5,1,15,1,5
DATA 1,12,1,5,1,12,1,5,1,12,1,5,1,12,1,5,1,15,1,5,1,12,1,5
DATA 1,12,1,5,1,12,1,5,1,12,1,5,1,14,1,1,1,14,1,12,1,14,1,12
DATA 1,14,1,12,1,14,1,3,1,14,1,3,1,14,1,12,1,14,1,12,1,14,1,12
DATA 1,14,1,1,1,12,1,13,1,1,1,13,1,12,1,13,1,12,1,13,1,1,1,13
DATA 1,12,1,13,1,1,1,13,1,12,1,13,1,12,1,13,1,1,1,13,300,8,1,12
DATA 1,13,1,12,1,13,1,3,1,13,1,3,1,13,1,3,1,13,1,12,1,13,1,12
DATA 1,13,1,3,1,13,1,3,1,13,1,3,1,13,1,5,1,12,1,5,1,12,1,5
DATA 1,3,1,5,1,12,2,3,1,5,1,12,1,5,1,12,1,5,1,3,1,5,1,12
DATA 2,3,1,5,1,12,1,5,1,12,1,5,1,3,1,5,1,12,2,3,1,5,1,12
DATA 1,5,1,12,1,5,1,3,1,5,1,12,2,3,1,12,1,13,1,12,1,13,1,3
DATA 1,13,1,3,1,13,1,3,1,13,1,12,1,13,1,12,1,13,1,3,1,13,1,3
DATA 1,13,1,3,1,13,286,8,2,13,1,8,2,13,1,8,2,13,1,8,2,13,8,8
DATA 1,5,2,1,1,14,2,1,1,14,2,1,1,14,2,1,1,14,1,13,1,8,1,13
DATA 1,3,1,13,1,3,1,13,1,1,2,3,1,14,2,3,1,14,2,3,1,14,2,3
DATA 1,14,1,3,1,13,1,3,1,5,1,12,5,3,1,5,2,3,1,5,2,3,1,5
DATA 2,3,1,5,3,3,1,5,1,12,5,3,1,5,2,3,1,5,2,3,1,5,2,3
DATA 1,5,2,3,1,13,1,3,1,13,1,3,1,13,1,1,2,3,1,14,2,3,1,14
DATA 2,3,1,14,2,3,1,14,1,3,1,13,5,8,1,5,2,1,1,12,2,1,1,12
DATA 2,1,1,12,2,1,1,14,1,13,7,8,2,13,1,8,2,13,1,8,2,13,1,8
DATA 2,13,129,8,1,12,1,5,1,3,2,5,1,3,1,5,1,12,12,8,1,13,1,1
DATA 1,5,2,12,1,5,1,1,1,13,12,8,1,12,1,5,1,12,2,5,1,12,1,5
DATA 1,12,12,8,1,13,1,12,1,5,2,12,1,5,1,12,1,13,12,8,1,12,1,5
DATA 1,12,2,5,1,12,1,5,1,12,11,8,1,13,1,5,1,3,1,5,2,12,1,5
DATA 1,1,1,13,6,8,1,13,1,12,1,13,1,12,1,13,1,1,1,5,1,15,1,12
DATA 2,5,1,3,1,5,1,12,6,8,1,1,1,5,1,1,1,5,1,12,1,5,1,12
DATA 1,5,1,15,1,5,1,3,1,5,1,1,1,13,6,8,2,3,1,5,1,12,1,5
DATA 1,12,1,5,1,12,1,5,1,3,2,5,1,13,7,8,1,12,1,15,1,12,1,5
DATA 1,12,1,5,1,12,1,5,1,12,2,5,1,1,1,12,7,8,1,5,1,15,1,12
DATA 1,5,1,12,1,5,1,12,1,5,1,12,1,5,1,1,1,13,8,8,2,3,1,5
DATA 1,12,1,5,1,12,1,5,1,12,1,5,1,3,1,12,9,8,1,1,1,5,1,1
DATA 1,5,1,12,1,5,1,12,1,5,1,1,1,13,10,8,1,13,1,12,1,13,1,12
DATA 1,13,1,12,1,13,1,12,137,8,1,13,1,12,1,14,1,3,2,5,1,3,1,14
DATA 1,12,1,13,10,8,1,12,1,14,1,3,1,5,2,12,1,5,1,3,1,14,1,12
DATA 10,8,1,13,1,1,1,5,1,12,2,5,1,12,1,5,1,1,1,13,10,8,1,12
DATA 1,3,1,12,1,5,2,12,1,5,1,12,1,5,1,12,9,8,1,13,1,14,1,3
DATA 2,12,2,5,1,12,1,5,1,14,1,13,5,8,1,12,1,13,1,12,1,13,1,12
DATA 1,5,1,3,1,5,1,12,1,5,1,12,2,5,1,1,1,12,5,8,1,14,1,12
DATA 1,14,1,1,1,3,1,12,1,5,1,15,1,5,1,12,1,5,1,12,1,3,1,14
DATA 1,13,5,8,1,12,1,14,1,1,1,5,1,12,2,3,1,5,1,15,2,5,1,3
DATA 1,14,1,13,6,8,1,5,1,3,1,5,1,12,1,5,1,12,1,5,1,12,1,5
DATA 2,3,1,14,2,12,6,8,1,15,1,5,1,12,1,5,1,12,1,5,1,12,1,5
DATA 1,3,1,12,1,14,1,12,1,13,7,8,1,15,1,5,1,12,1,5,1,12,1,5
DATA 1,12,1,5,1,3,1,14,1,12,1,13,1,12,7,8,1,5,1,3,1,5,1,12
DATA 1,5,1,12,1,5,1,12,2,1,1,13,1,12,8,8,1,12,1,14,1,1,1,14
DATA 1,12,1,14,1,12,1,14,1,1,1,13,1,12,9,8,1,14,1,12,1,14,1,1
DATA 1,14,1,12,1,14,1,13,1,12,11,8,1,12,1,13,1,12,1,13,1,12,1,13
DATA 1,12,117,8,1,13,1,12,1,5,1,3,1,5,2,12,1,5,1,3,1,14,1,12
DATA 1,13,8,8,1,12,1,14,1,3,1,5,1,12,2,5,1,12,1,5,1,3,1,14
DATA 1,12,8,8,1,13,2,3,1,12,1,5,2,12,1,5,1,12,1,5,1,3,1,13
DATA 7,8,1,13,1,14,1,3,1,12,1,5,1,12,2,5,1,12,1,5,1,12,1,5
DATA 1,3,4,8,1,12,1,13,1,12,1,14,1,12,2,3,1,12,1,5,2,12,1,5
DATA 1,12,1,14,1,3,1,13,4,8,1,14,1,12,3,3,1,12,1,3,1,5,1,12
DATA 2,5,1,12,1,5,1,3,1,14,1,12,4,8,1,12,1,5,1,3,1,14,1,12
DATA 4,3,2,12,1,5,1,3,1,5,1,12,1,13,4,8,1,14,1,3,1,5,1,12
DATA 1,5,1,12,1,5,1,12,4,3,1,5,1,12,1,14,1,12,4,8,2,3,1,12
DATA 1,5,1,12,1,5,1,12,1,5,1,12,1,3,3,12,1,14,1,12,5,8,1,5
DATA 1,3,1,5,1,12,1,5,2,12,2,5,1,3,1,12,2,14,1,12,1,13,5,8
DATA 1,5,1,3,1,5,1,12,1,5,1,12,1,5,1,12,1,14,1,3,1,14,2,12
DATA 1,14,6,8,1,3,1,5,1,3,1,5,1,12,1,5,1,12,1,14,1,12,1,3
DATA 1,12,2,14,1,12,6,8,1,5,1,12,1,5,1,3,1,14,1,12,1,14,1,12
DATA 1,14,1,3,1,14,1,12,1,13,7,8,1,12,1,14,1,12,1,5,3,3,1,5
DATA 1,3,1,5,1,12,1,13,8,8,1,14,1,12,1,14,1,12,1,14,1,12,1,14
DATA 1,12,1,13,1,12,1,0,9,8,1,12,1,13,1,12,1,13,1,12,1,13,1,12
DATA 1,13,1,0,98,8,1,13,1,3,2,5,1,3,1,13,14,8,1,3,1,14,2,12
DATA 1,5,1,3,14,8,1,13,1,12,2,5,1,12,1,13,14,8,1,12,1,14,2,12
DATA 1,14,1,12,14,8,1,13,1,12,2,5,1,12,1,13,14,8,1,3,1,14,2,12
DATA 1,14,1,3,13,8,1,13,1,14,1,12,2,5,1,12,1,5,7,8,1,12,1,13
DATA 1,3,1,13,1,12,1,3,1,12,1,15,1,12,1,5,1,12,1,3,1,13,7,8
DATA 1,14,1,3,1,14,1,12,1,14,1,12,1,3,1,12,1,15,1,12,1,3,1,5
DATA 8,8,1,15,1,5,1,12,1,5,1,12,1,5,1,12,1,5,1,12,1,5,1,12
DATA 1,13,8,8,1,15,1,5,1,12,1,5,1,12,1,5,1,12,1,3,1,12,1,14
DATA 1,13,9,8,1,14,1,3,1,14,1,12,1,14,1,12,1,14,1,12,1,13,1,3
DATA 10,8,1,12,1,13,1,3,1,13,1,12,1,3,1,12,1,13,160,8,1,1,2,3
DATA 1,1,16,8,1,1,2,3,1,1,16,8,1,13,2,12,1,13,16,8,1,3,2,5
DATA 1,3,16,8,1,13,2,3,1,13,16,8,1,3,2,5,1,3,15,8,1,13,1,5
DATA 1,15,1,12,1,13,14,8,1,13,1,5,1,12,2,5,1,0,8,8,1,12,1,13
DATA 1,12,1,13,1,3,1,13,3,3,2,12,9,8,1,3,1,12,1,3,1,12,1,3
DATA 1,15,1,5,1,12,2,3,1,0,9,8,1,5,1,12,1,5,1,12,1,5,1,15
DATA 1,5,1,12,1,3,11,8,1,12,1,13,1,12,1,13,1,3,1,13,1,3,1,0
DATA 257,8,2,6,3,8,2,6,1,7,7,8,1,13,1,8,1,13,1,8,3,6,1,7
DATA 3,8,2,7,1,13,7,8,1,6,2,8,2,6,2,7,1,8,1,0,3,6,1,7
DATA 8,8,2,7,1,15,2,7,1,8,1,0,5,6,1,7,6,8,2,7,1,8,1,15
DATA 2,6,1,7,7,6,1,7,4,8,1,6,4,7,2,6,1,7,7,6,1,7,2,6
DATA 2,8,1,6,4,7,2,6,1,7,7,6,1,7,1,6,1,8,1,6,2,8,2,7
DATA 1,8,1,15,2,6,1,7,7,6,1,7,3,8,1,6,2,8,2,7,1,15,2,7
DATA 1,8,1,0,5,6,1,7,4,8,1,6,1,8,1,6,2,8,2,6,2,7,1,8
DATA 1,0,3,6,1,7,4,8,1,6,1,8,1,13,1,8,1,13,1,8,3,6,1,7
DATA 3,8,2,7,1,13,3,8,1,13,7,8,2,6,3,8,2,6,1,7,5,8,1,13
DATA 138,8,1,10,8,8,1,10,7,8,1,2,1,8,1,10,8,8,1,10,2,2,5,8
DATA 2,11,1,2,1,8,1,2,10,8,1,2,2,8,1,10,2,2,1,8,1,2,9,8
DATA 1,10,1,2,1,8,1,2,1,8,4,2,10,8,1,10,1,15,2,2,1,11,2,2
DATA 2,11,2,2,8,8,1,10,1,8,1,15,1,2,2,11,2,2,2,11,3,2,6,8
DATA 1,10,6,2,1,11,3,2,1,11,2,2,6,8,1,10,6,2,1,11,3,2,1,11
DATA 2,2,7,8,1,10,1,8,1,15,1,2,2,11,2,2,2,11,3,2,8,8,1,10
DATA 1,15,2,2,1,11,2,2,2,11,2,2,10,8,1,10,1,2,1,8,1,2,1,8
DATA 4,2,14,8,1,2,2,8,1,10,2,2,1,8,1,2,9,8,1,10,2,2,5,8,2
DATA 11,1,2,1,8,1,2,8,8,1,10,7,8,1,2,1,8,1,10,20,8,1,10,42,8

PaletteVALUES:
DATA 18,18,18, 50,44,36, 0,42,0, 56,50,42
DATA 63,0,0, 51,43,30, 48,48,52, 42,42,42
DATA 0,14,0, 54,24,63, 21,63,21, 0,30,0
DATA 34,22,21, 32,32,32, 45,37,24, 63,63,63

SUB DrawSCREEN

FOR Col = 1 TO 32
PutSPRITE Col, 1, Stone
PutSPRITE Col, 24, Stone
NEXT Col
FOR Row = 1 TO 24
PutSPRITE 1, Row, Stone
PutSPRITE 32, Row, Stone
NEXT Row

COLOR 4
LOCATE 3, 5: PRINT "LIVES:"
LOCATE 3, 34: PRINT "R A T T L E R"
LOCATE 3, 65: PRINT "SCORE:"
FOR x = 254 TO 376
FOR y = 32 TO 45
PSET (x + 4, y - 30), 15
NEXT y
NEXT x
FOR x = 254 TO 376
FOR y = 32 TO 45
IF POINT(x, y) = 4 THEN
PSET (x + 6, y - 29), 0
PSET (x + 5, y - 30), 5
END IF
PSET (x, y), 0
NEXT y
NEXT x
LINE (258, 1)-(378, 1), 0
LINE (258, 1)-(258, 15), 0
FOR x = 26 TO 99
FOR y = 32 TO 45
PSET (x + 4, y - 30), 15
NEXT y
NEXT x
FOR x = 26 TO 99
FOR y = 32 TO 45
IF POINT(x, y) = 4 THEN PSET (x + 6, y - 30), 0
PSET (x, y), 0
NEXT y
NEXT x
LINE (28, 1)-(103, 1), 0
LINE (28, 1)-(28, 15), 0
FOR x = 504 TO 607
FOR y = 32 TO 45
IF POINT(x, y) = 4 THEN
PSET (x + 4, y - 30), 0
ELSE
PSET (x + 4, y - 30), 15
END IF
PSET (x, y), 0
NEXT y
NEXT x
LINE (508, 1)-(611, 1), 0
LINE (508, 1)-(508, 15), 0
LOCATE 28, 5: PRINT "LEVEL:"
FOR x = 28 TO 98
FOR y = 432 TO 445
IF POINT(x, y) = 4 THEN
PSET (x, y + 32), 0
ELSE
PSET (x, y + 32), 15
END IF
PSET (x, y), 0
NEXT y
NEXT x
LINE (28, 463)-(98, 463), 0
LINE (28, 463)-(28, 476), 0
LOCATE 28, 70: PRINT "SPEED:"
FOR x = 548 TO 612
FOR y = 432 TO 445
IF POINT(x, y) = 4 THEN
PSET (x, y + 32), 0
ELSE
PSET (x, y + 32), 15
END IF
PSET (x, y), 0
NEXT y
NEXT x
LINE (548, 463)-(612, 463), 0
LINE (548, 463)-(548, 476), 0

LINE (267, 463)-(371, 476), 15, BF
LINE (267, 463)-(371, 463), 0
LINE (267, 463)-(267, 476), 0
LINE (20, 20)-(619, 459), 8, BF

END SUB

FUNCTION EndGAME

IF Lives = 0 THEN
RemainingLIVES& = 1
ELSE
RemainingLIVES& = Lives
END IF
FinalSCORE& = Score * RemainingLIVES& * 10&

GET (166, 152)-(472, 327), BigBOX
LINE (166, 152)-(472, 327), 0, BF
LINE (168, 154)-(470, 325), 8, B
LINE (170, 156)-(468, 323), 7, B
LINE (172, 158)-(466, 321), 6, B

IF FinalSCORE& > ScoreDATA(9).PlayerSCORE THEN
COLOR 4
LOCATE 12, 31
PRINT "- G A M E  O V E R -"
COLOR 3
IF Lives = 0 THEN
LOCATE 13, 30
PRINT "(Sorry, no more lives)"
ELSE
LOCATE 13, 33
PRINT "Congratulations!"
END IF

Hundred$ = LTRIM$(STR$(FinalSCORE& MOD 1000))
IF FinalSCORE& >= 1000 THEN
IF VAL(Hundred$) = 0 THEN Hundred$ = "000"
IF VAL(Hundred$) < 100 THEN Hundred$ = "0" + Hundred$
Thousand$ = LTRIM$(STR$(FinalSCORE& \ 1000))
FinalSCORE$ = Thousand$ + "," + Hundred$
ELSE
FinalSCORE$ = Hundred$
END IF
COLOR 6: LOCATE 15, 28: PRINT "Your final score is ";
COLOR 15: PRINT FinalSCORE$
COLOR 9
LOCATE 16, 26: PRINT "Enter your name to record score"
LOCATE 17, 26: PRINT "(Just press ENTER to decline):"
COLOR 15
LOCATE 19, 26: INPUT ; Name$
IF LEN(Name$) THEN
ScoreDATA(10).PlayerNAME = LEFT$(Name$, 20)
ScoreDATA(10).PlayDATE = DATE$
ScoreDATA(10).PlayerSCORE = FinalSCORE&
FOR a = 0 TO 10
FOR B = a TO 10
IF ScoreDATA(B).PlayerSCORE > ScoreDATA(a).PlayerSCORE THEN
SWAP ScoreDATA(B), ScoreDATA(a)
END IF
NEXT B
NEXT a

TopTEN

OPEN "rattler.top" FOR OUTPUT AS #1
FOR Reps = 0 TO 9
WRITE #1, ScoreDATA(Reps).PlayerNAME
WRITE #1, ScoreDATA(Reps).PlayDATE
WRITE #1, ScoreDATA(Reps).PlayerSCORE
NEXT Reps
CLOSE #1
END IF
END IF

LINE (176, 160)-(462, 317), 0, BF
COLOR 4: LOCATE 14, 31: PRINT "- G A M E  O V E R -"
COLOR 9
LOCATE 16, 26: PRINT "Start new game......"
LOCATE 17, 26: PRINT "QUIT................"
COLOR 6
LOCATE 16, 47: PRINT "Press [1]"
LOCATE 17, 47: PRINT "Press [2]"

DO
k$ = INKEY$
LOOP UNTIL k$ = "1" OR k$ = "2" OR k$ = CHR$(27)
IF k$ = "1" THEN EndGAME = 1: EXIT FUNCTION
PALETTE: COLOR 7: CLS
SYSTEM

END FUNCTION

SUB InitGAME

SetSPEED = 9
SpeedLEVEL = 3
Level = 1
Lives = 5
Score = 0
CrittersLEFT = 10

END SUB

SUB InitLEVEL

ERASE SnakePIT
SnakeLENGTH = 11
StartCOL = 22

FOR n = 1 TO SnakeLENGTH
StartCOL = StartCOL - 1
Rattler(n).Col = StartCOL
Rattler(n).Row = 22
Rattler(n).TURN = 0
Rattler(n).WhichWAY = Right
SELECT CASE n
CASE 1: Rattler(n).BodyPART = Head
CASE 2: Rattler(n).BodyPART = Neck
CASE 3: Rattler(n).BodyPART = Shoulders
CASE 4: Rattler(n).BodyPART = Body
CASE 5: Rattler(n).BodyPART = Body
CASE 6: Rattler(n).BodyPART = Shoulders
CASE 7: Rattler(n).BodyPART = Neck
CASE 8: Rattler(n).BodyPART = Tail
CASE 9: Rattler(n).BodyPART = TailEND
CASE 10: Rattler(n).BodyPART = Rattle
CASE 11: Rattler(n).BodyPART = Blank
END SELECT
NEXT n

PrintNUMS 1, Lives
PrintNUMS 2, Score
PrintNUMS 3, Level
PrintNUMS 5, SpeedLEVEL

FOR n = 1 TO SnakeLENGTH
RCol = Rattler(n).Col
RRow = Rattler(n).Row
RIndex = Rattler(n).BodyPART + Rattler(n).TURN + Rattler(n).WhichWAY
PutSPRITE RCol, RRow, RIndex
NEXT n
SnakePIT(Rattler(SnakeLENGTH).Col, Rattler(SnakeLENGTH).Row) = 0

FOR Col = 1 TO 32
SnakePIT(Col, 1) = -1
SnakePIT(Col, 24) = -1
NEXT Col
FOR Row = 2 TO 23
SnakePIT(1, Row) = -1
SnakePIT(32, Row) = -1
NEXT Row

LINE (271, 466)-(368, 474), 15, BF
FOR x = 271 TO 361 STEP 10
Count = Count + 1
IF Count MOD 2 THEN Colr = 11 ELSE Colr = 7
LINE (x, 466)-(x + 7, 474), Colr, BF
NEXT x

END SUB

SUB Instructions

GET (100, 100)-(539, 379), BigBOX
LINE (100, 100)-(539, 379), 0, BF
LINE (106, 106)-(533, 373), 13, B
LINE (108, 108)-(531, 371), 7, B
LINE (110, 110)-(529, 369), 6, B

COLOR 9: LOCATE 10, 27: PRINT "- I N S T R U C T I O N S -"
COLOR 6
LOCATE 12, 18: PRINT "RATTLER is a variation on the classic Microsoft"
LOCATE 13, 18: PRINT "QBasic game NIBBLES."
COLOR 15
LOCATE 12, 18: PRINT "RATTLER": LOCATE 13, 30: PRINT "NIBBLES"
COLOR 6
LOCATE 15, 18: PRINT "Steer the Diamondback Rattler using the Arrow"
LOCATE 16, 18: PRINT "keys, eating mice and frogs and scoring points"
COLOR 15: LOCATE 15, 58: PRINT "Arrow": COLOR 6
LOCATE 17, 18: PRINT "for each kill. These wary creatures cannot be"
LOCATE 18, 18: PRINT "caught from the front or sides, however. They"
LOCATE 19, 18: PRINT "must be snuck up on from behind, otherwise"
LOCATE 20, 18: PRINT "they will simply jump to a new location."

COLOR 13: LOCATE 22, 28: PRINT "PRESS ANY KEY TO CONTINUE..."

a$ = INPUT$(1)
LINE (120, 160)-(519, 332), 0, BF
COLOR 6
LOCATE 12, 18: PRINT "With each creature eaten, the rattler grows"
LOCATE 13, 18: PRINT "in length, making steering much more difficult"
LOCATE 14, 18: PRINT "and increasing the chance of self-collision."
LOCATE 16, 18: PRINT "There are ten levels, each one more hazardous"
LOCATE 17, 18: PRINT "than the last. If the snake hits a stone wall"
LOCATE 18, 18: PRINT "or bumps into himself, he dies. He has a total"
LOCATE 19, 18: PRINT "of five lives. Once they are used up, the game"
LOCATE 20, 18: PRINT "is over."
COLOR 15
LOCATE 16, 28: PRINT "ten": LOCATE 19, 21: PRINT "five"

a$ = INPUT$(1)
LINE (120, 160)-(519, 332), 0, BF
COLOR 6
LOCATE 12, 18: PRINT "Often, a mouse or frog will have its back to"
LOCATE 13, 18: PRINT "a wall, making it impossible to kill. In those"
LOCATE 14, 18: PRINT "situations, you must attack from the front or"
LOCATE 15, 18: PRINT "sides, forcing it to move to a location where"
LOCATE 16, 18: PRINT "its back is exposed."
LOCATE 18, 18: PRINT "There are five speeds to choose from. It may"
LOCATE 19, 18: PRINT "be wise to choose a slower speed for the high-"
LOCATE 20, 18: PRINT "er levels. The default speed is 3."
COLOR 15: LOCATE 18, 28: PRINT "five": LOCATE 20, 50: PRINT "3"
a$ = INPUT$(1)
LINE (120, 160)-(519, 332), 0, BF
COLOR 9
LOCATE 12, 18: PRINT "SCORING:"
COLOR 6
LOCATE 12, 18: PRINT "SCORING: Each kill scores 10 points multiplied"
LOCATE 13, 18: PRINT "by the level of difficulty and the speed. For"
LOCATE 14, 18: PRINT "example, at level 5, speed 3, a kill is worth"
LOCATE 15, 18: PRINT "150 points; level 10, speed 2: 200 points."
LOCATE 17, 18: PRINT "If you manage to complete all 10 levels, your"
LOCATE 18, 18: PRINT "final score is then multiplied by the number"
LOCATE 19, 18: PRINT "of remaining lives. In other words, the score"
LOCATE 20, 18: PRINT "accurately reflects your level of achievement."
COLOR 15
LOCATE 12, 18: PRINT "SCORING"
LOCATE 12, 44: PRINT "10": LOCATE 14, 36: PRINT "5"
LOCATE 14, 45: PRINT "3": LOCATE 15, 18: PRINT "150"
LOCATE 15, 36: PRINT "10": LOCATE 15, 46: PRINT "2"
LOCATE 15, 49: PRINT "200"
a$ = INPUT$(1)
LINE (120, 160)-(519, 368), 0, BF
COLOR 6
LOCATE 12, 18: PRINT "Indicators of remaining lives and the current"
LOCATE 13, 18: PRINT "score are located at the top of the screen on"
COLOR 15: LOCATE 12, 42: PRINT "lives"
LOCATE 13, 18: PRINT "score": COLOR 6
LOCATE 14, 18: PRINT "the extreme left and right, respectively."
LOCATE 16, 18: PRINT "The current level of play can be found on the"
LOCATE 17, 18: PRINT "bottom-left of the screen. Bottom-center you"
LOCATE 18, 18: PRINT "will find a graph indicating the number of"
LOCATE 19, 18: PRINT "prey remaining on the current level. The cur-"
LOCATE 20, 18: PRINT "rent speed can be read bottom-right."
COLOR 15
LOCATE 16, 30: PRINT "level"
LOCATE 18, 51: PRINT "number of": LOCATE 19, 18: PRINT "prey"
LOCATE 20, 23: PRINT "speed"
COLOR 13: LOCATE 22, 25: PRINT "PRESS ANY KEY TO RETURN TO GAME..."
a$ = INPUT$(1)

PUT (100, 100), BigBOX, PSET

END SUB

SUB Intro

PutSPRITE 7, 16, Rattle + Up
PutSPRITE 7, 15, TailEND + Up
PutSPRITE 7, 14, Tail + Up
PutSPRITE 7, 13, Neck + Up
PutSPRITE 7, 12, Shoulders + Up
PutSPRITE 7, 11, Body + Up
PutSPRITE 7, 10, Body + TURN + UR
PutSPRITE 8, 10, Body + Right
PutSPRITE 9, 10, Body + TURN + RD
PutSPRITE 9, 11, Body + TURN + DL
PutSPRITE 8, 11, Body + TURN + LD
PutSPRITE 8, 12, Body + TURN + DR
PutSPRITE 9, 12, Body + TURN + RD
PutSPRITE 9, 13, Body + Down
PutSPRITE 9, 14, Body + TURN + DR
PutSPRITE 10, 14, Body + TURN + RU
PutSPRITE 10, 13, Body + Up
PutSPRITE 10, 12, Body + Up
PutSPRITE 10, 11, Body + Up
PutSPRITE 10, 10, Body + TURN + UR
PutSPRITE 11, 10, Body + Right
PutSPRITE 12, 10, Body + TURN + RD
PutSPRITE 12, 11, Body + Down
PutSPRITE 12, 12, Body + Down
PutSPRITE 12, 13, Body + Down
PutSPRITE 12, 14, Body + TURN + DR
PutSPRITE 13, 14, Body + Right
PutSPRITE 11, 12, Body + Right
PutSPRITE 13, 10, Body + Right
PutSPRITE 14, 10, Body + Right
PutSPRITE 15, 10, Body + Right
PutSPRITE 16, 10, Body + Right
PutSPRITE 17, 10, Body + Right
PutSPRITE 14, 11, Body + Down
PutSPRITE 14, 12, Body + Down
PutSPRITE 14, 13, Body + Down
PutSPRITE 14, 14, Body + TURN + DR
PutSPRITE 15, 14, Body + Right
PutSPRITE 16, 11, Body + Down
PutSPRITE 16, 12, Body + Down
PutSPRITE 16, 13, Body + Down
PutSPRITE 16, 14, Body + TURN + DR
PutSPRITE 17, 14, Body + Right
PutSPRITE 18, 10, Body + Down
PutSPRITE 18, 11, Body + Down
PutSPRITE 18, 12, Body + Down
PutSPRITE 18, 13, Body + Down
PutSPRITE 18, 14, Body + TURN + DR
PutSPRITE 19, 14, Body + Right
PutSPRITE 20, 10, Body + TURN + UR
PutSPRITE 21, 12, Body + Right
PutSPRITE 21, 10, Body + Right
PutSPRITE 20, 11, Body + Down
PutSPRITE 20, 12, Body + Down
PutSPRITE 20, 13, Body + Down
PutSPRITE 20, 14, Body + TURN + DR
PutSPRITE 21, 14, Body + Right
PutSPRITE 22, 16, Rattle + Up
PutSPRITE 22, 15, TailEND + Up
PutSPRITE 22, 14, Tail + Up
PutSPRITE 22, 13, Neck + Up
PutSPRITE 22, 12, Shoulders + Up
PutSPRITE 22, 11, Body + Up
PutSPRITE 22, 10, Body + TURN + UR
PutSPRITE 23, 10, Body + Right
PutSPRITE 24, 10, Body + TURN + RD
PutSPRITE 24, 11, Body + TURN + DL
PutSPRITE 23, 11, Body + TURN + LD
PutSPRITE 23, 12, Body + TURN + DR
PutSPRITE 24, 12, Body + TURN + RD
PutSPRITE 24, 13, Body + Down
PutSPRITE 24, 14, Body + TURN + DR
PutSPRITE 25, 14, Body + Right
PutSPRITE 26, 14, Shoulders + TURN + RU
PutSPRITE 26, 13, Neck + Up
PutSPRITE 26, 12, Head + Up
COLOR 13
LOCATE 22, 20
PRINT "Copyright (C) 2003 by Bob Seguin (Freeware)"
FOR x = 152 TO 496
FOR y = 336 TO 352
IF POINT(x, y) = 0 THEN PSET (x, y), 8
NEXT y
NEXT x
LINE (80, 106)-(560, 386), 13, B
LINE (76, 102)-(564, 390), 7, B
SetPALETTE


PLAY "MFMST200L32O0AP16AP16AP16DP16AP16AP16AP16>C<P16A"
FOR Reps = 1 TO 18
GOSUB Rattle1
NEXT Reps

Wipe

EXIT SUB

'------------------------ SUBROUTINE SECTION BEGINS --------------------------
Rattle1:
IF Reps MOD 3 = 0 THEN
LINE (509, 215)-(510, 219), 4, B
LINE (508, 210)-(508, 214), 4
LINE (511, 210)-(511, 214), 4
END IF
Hula = Hula + 1
PLAY "MFT220L64O0C"
WAIT &H3DA, 8
WAIT &H3DA, 8, 8
SELECT CASE Hula MOD 2
CASE 0
PUT (418, 300), SpriteBOX(Rattle + Up), PSET
CASE 1
PUT (422, 300), SpriteBOX(Rattle + Up), PSET
END SELECT
SOUND 30000, 1
WAIT &H3DA, 8
WAIT &H3DA, 8, 8
PUT (420, 300), SpriteBOX(Rattle + Up), PSET
IF Reps MOD 3 = 0 THEN
LINE (508, 210)-(511, 219), 8, BF
END IF
RETURN

END SUB

SUB PauseMENU (Item)

DO
GET (166, 162)-(472, 317), BigBOX
LINE (166, 162)-(472, 317), 0, BF
LINE (168, 164)-(470, 315), 8, B
LINE (170, 166)-(468, 313), 7, B
LINE (172, 168)-(466, 311), 6, B

SELECT CASE Item
CASE 1
COLOR 4: LOCATE 13, 34: PRINT "L E V E L -"; (STR$(Level))
COLOR 15: LOCATE 15, 30: PRINT "PRESS SPACE TO BEGIN..."
COLOR 9: LOCATE 16, 26: PRINT "Instructions:[I] SetSPEED:[S]"
LOCATE 17, 24: PRINT "EXIT:[Esc] TopTEN:[T] ReSTART:[R]"
COLOR 7: LOCATE 19, 25: PRINT "To pause during play press SPACE"
CASE 2
COLOR 4: LOCATE 14, 29: PRINT "- G A M E  P A U S E D -"
COLOR 6: LOCATE 15, 29: PRINT "Press SPACE to continue..."
COLOR 9: LOCATE 17, 26: PRINT "Instructions:[I] SetSPEED:[S]"
LOCATE 18, 24: PRINT "EXIT:[Esc] TopTEN:[T] ReSTART:[R]"
END SELECT

DO: LOOP UNTIL INKEY$ = "" 'Clear INKEY$ buffer

DO
DO
k$ = UCASE$(INKEY$)
LOOP WHILE k$ = ""
SELECT CASE k$
CASE "I": GOSUB CloseMENU: Instructions: EXIT DO
CASE "S": GOSUB CloseMENU: SpeedSET: EXIT DO
CASE "R": GOSUB CloseMENU: Item = -1: EXIT SUB
CASE "T": GOSUB CloseMENU: TopTEN: EXIT DO
CASE CHR$(27): SYSTEM
CASE " ": GOSUB CloseMENU: EXIT SUB
END SELECT
LOOP
LOOP
GOSUB CloseMENU

EXIT SUB

CloseMENU:
PUT (166, 162), BigBOX, PSET
RETURN

END SUB

SUB PlayGAME

IF Level = 0 THEN InitGAME
InitLEVEL
SetSTONES Level
Speed = SetSPEED

GOSUB PutPREY

Col = 21: Row = 22
RowINC = 0: ColINC = 1
Direction = Right: OldDIRECTION = Right
Increase = 0: Item = 1

DO: LOOP UNTIL INKEY$ = "" 'Clear INKEY$ buffer

PauseMENU Item
IF Item = -1 THEN GOSUB ReSTART

FOR Reps = 1 TO 6
GOSUB Rattle2
NEXT Reps

DO
k$ = INKEY$
SELECT CASE k$
CASE CHR$(0) + "H"
IF RowINC <> 1 THEN RowINC = -1: ColINC = 0: Direction = Up
CASE CHR$(0) + "P"
IF RowINC <> -1 THEN RowINC = 1: ColINC = 0: Direction = Down
CASE CHR$(0) + "K"
IF ColINC <> 1 THEN ColINC = -1: RowINC = 0: Direction = Left
CASE CHR$(0) + "M"
IF ColINC <> -1 THEN ColINC = 1: RowINC = 0: Direction = Right
CASE " "
Item = 2
PauseMENU Item
IF Item = -1 THEN GOSUB ReSTART:
END SELECT

Row = Row + RowINC
Col = Col + ColINC

'Lengthen snake if prey has been eaten
IF Increase THEN
SnakeLENGTH = SnakeLENGTH + 1
FOR n = SnakeLENGTH TO SnakeLENGTH - 7 STEP -1
Rattler(n).BodyPART = Rattler(n - 1).BodyPART
NEXT n
Increase = Increase - 1
'If snake length has been increased significantly, adjust speed
IF Increase = 0 THEN
SELECT CASE SnakeLENGTH
CASE 36 TO 46: Speed = SetSPEED - 1
CASE IS > 46: Speed = SetSPEED - 2
END SELECT
END IF
END IF

FOR n = SnakeLENGTH TO 2 STEP -1
SWAP Rattler(n).Row, Rattler(n - 1).Row
SWAP Rattler(n).Col, Rattler(n - 1).Col
SWAP Rattler(n).TURN, Rattler(n - 1).TURN
SWAP Rattler(n).WhichWAY, Rattler(n - 1).WhichWAY
SWAP Rattler(n).RattleDIR, Rattler(n - 1).RattleDIR
NEXT n

IF Direction <> OldDIRECTION THEN
Rattler(2).TURN = TURN
SELECT CASE OldDIRECTION
CASE Up
SELECT CASE Direction
CASE Left: Rattler(2).WhichWAY = UL
CASE Right: Rattler(2).WhichWAY = UR
END SELECT
Rattler(2).RattleDIR = Up
CASE Down
SELECT CASE Direction
CASE Left: Rattler(2).WhichWAY = DL
CASE Right: Rattler(2).WhichWAY = DR
END SELECT
Rattler(2).RattleDIR = Down
CASE Left
SELECT CASE Direction
CASE Up: Rattler(2).WhichWAY = LU
CASE Down: Rattler(2).WhichWAY = LD
END SELECT
Rattler(2).RattleDIR = Left
CASE Right
SELECT CASE Direction
CASE Up: Rattler(2).WhichWAY = RU
CASE Down: Rattler(2).WhichWAY = RD
END SELECT
Rattler(2).RattleDIR = Right
END SELECT
END IF

Rattler(1).Row = Row
Rattler(1).Col = Col
Rattler(1).TURN = 0
Rattler(1).WhichWAY = Direction
Rattler(SnakeLENGTH).TURN = 0
Rattler(SnakeLENGTH - 1).TURN = 0

IF Rattler(SnakeLENGTH - 2).TURN = 0 THEN
Rattler(SnakeLENGTH - 1).WhichWAY = Rattler(SnakeLENGTH - 2).WhichWAY
ELSE
Rattler(SnakeLENGTH - 1).WhichWAY = Rattler(SnakeLENGTH - 2).RattleDIR
END IF

OldDIRECTION = Direction

'TEST Map values
SELECT CASE SnakePIT(Col, Row)
CASE IS >= 1000
IF SnakePIT(Col, Row) MOD 1000 = Rattler(1).WhichWAY THEN
IF SnakePIT(Col, Row) \ 1000 = 1 THEN PLAY "MBMST220L64O0BP16BO1P64B"
IF SnakePIT(Col, Row) \ 1000 = 2 THEN PLAY "MBT160L32O6A-B-B"
SnakePIT(Col, Row) = 0
PreySCORE = PreySCORE + 1
Score = Score + (Level * SpeedLEVEL)
PrintNUMS 2, Score
Increase = Increase + 5
CrittersLEFT = CrittersLEFT - 1
PrintNUMS 4, CrittersLEFT
IF PreySCORE = 10 THEN
PutSPRITE Col, Row, Blank
Wipe
PreySCORE = 0
CrittersLEFT = 10
Level = Level + 1
IF Level = 11 THEN Choice = EndGAME
IF Choice THEN GOSUB ReSTART
PrintNUMS 3, Level
EXIT SUB
END IF
SetPREY = 1
ELSE
SetPREY = 2
END IF
CASE IS < 0
PLAY "MBMST100O0L32GFEDC"
Lives = Lives - 1
PrintNUMS 1, Lives
PreySCORE = 0
GET (188, 184)-(450, 295), BigBOX
LINE (188, 184)-(450, 295), 0, BF
LINE (190, 186)-(448, 293), 8, B
LINE (192, 188)-(446, 291), 7, B
LINE (194, 190)-(444, 289), 6, B
LINE (196, 192)-(442, 287), 6, B
IF SnakePIT(Col, Row) = -1 THEN
COLOR 4: LOCATE 15, 35: PRINT "G L O R N K !"
COLOR 9: LOCATE 16, 35: PRINT "HIT THE WALL!"
ELSE
COLOR 4: LOCATE 15, 37: PRINT "O U C H !"
COLOR 9: LOCATE 16, 35: PRINT "BIT YOURSELF!"
END IF
StartTIME! = TIMER: DO: LOOP WHILE TIMER < StartTIME! + 1
PUT (188, 184), BigBOX, PSET
IF Lives = 0 THEN Choice = EndGAME
IF Choice THEN GOSUB ReSTART
CrittersLEFT = 10
Wipe
EXIT SUB
END SELECT

WAIT &H3DA, 8
FOR n = SnakeLENGTH TO 1 STEP -1
RCol = Rattler(n).Col
RRow = Rattler(n).Row
RIndex = Rattler(n).BodyPART + Rattler(n).TURN + Rattler(n).WhichWAY
PutSPRITE RCol, RRow, RIndex
IF Rattler(n).BodyPART = Body THEN
FOR nn = n TO 1 STEP -1
IF Rattler(n).BodyPART = Shoulders THEN
n = nn
EXIT FOR
END IF
NEXT nn
END IF
NEXT n

IF SetPREY THEN
IF SetPREY = 2 THEN
IF WhichPREY = 1 THEN WhichPREY = 0 ELSE WhichPREY = 1
END IF
GOSUB PutPREY
SetPREY = 0
END IF

SnakePIT(Rattler(SnakeLENGTH).Col, Rattler(SnakeLENGTH).Row) = 0

FOR Reps = 1 TO Speed
WAIT &H3DA, 8
WAIT &H3DA, 8, 8
NEXT Reps

LOOP

EXIT SUB

'------------------------ SUBROUTINE SECTION BEGINS --------------------------

Rattle2:
IF Reps MOD 3 = 0 THEN
LINE (420, 429)-(425, 430), 4, B
LINE (426, 428)-(430, 428), 4
LINE (426, 431)-(430, 431), 4
END IF
Hula = Hula + 1
PLAY "MFT220L64O0C"
WAIT &H3DA, 8
WAIT &H3DA, 8, 8
SELECT CASE Hula MOD 2
CASE 0: PUT (220, 418), SpriteBOX(Rattle + Right), PSET
CASE 1: PUT (220, 422), SpriteBOX(Rattle + Right), PSET
END SELECT
SOUND 30000, 1
WAIT &H3DA, 8
WAIT &H3DA, 8, 8
PUT (220, 420), SpriteBOX(Rattle + Right), PSET
IF Reps MOD 3 = 0 THEN
LINE (420, 428)-(430, 431), 8, BF
END IF
IF Level = 8 THEN PutSPRITE 12, 21, Stone
RETURN

PutPREY:
DO
PreyCOL = INT(RND * 30) + 2
PreyROW = INT(RND * 22) + 2
LOOP WHILE SnakePIT(PreyCOL, PreyROW) <> 0
WhichDIR = INT(RND * 4)
SELECT CASE WhichDIR
CASE 0: Way = Left
CASE 1: Way = Up
CASE 2: Way = Right
CASE 3: Way = Down
END SELECT
IF WhichPREY = 1 THEN
PutSPRITE PreyCOL, PreyROW, Frog + Way
SnakePIT(PreyCOL, PreyROW) = 1000 + Way
WhichPREY = 0
ELSE
PutSPRITE PreyCOL, PreyROW, Mouse + Way
SnakePIT(PreyCOL, PreyROW) = 2000 + Way
WhichPREY = 1
END IF
RETURN

ReSTART:
PLAY "MBMST200L32O0AP16AP16AP16DP16AP16AP16AP16>C<P16A"
Level = 0
Item = 0
Choice = 0
Wipe
EXIT SUB
RETURN

END SUB

SUB PrintNUMS (Item, Value)

PrintSCORE& = Value * 10&

SELECT CASE Item
CASE 1 'Lives
Num$ = LTRIM$(STR$(Value))
PrintX = 89: PrintY = 2
CASE 2 'Score
SELECT CASE PrintSCORE&
CASE 0 TO 9: Num$ = "0000"
CASE 10 TO 99: Num$ = "000"
CASE 100 TO 999: Num$ = "00"
CASE 1000 TO 9999: Num$ = "0"
END SELECT
Num$ = Num$ + LTRIM$(STR$(PrintSCORE&))
PrintX = 568: PrintY = 2
CASE 3 'Level
Num$ = LTRIM$(STR$(Value))
PrintX = 82: PrintY = 464
LINE (PrintX, PrintY)-(PrintX + 15, PrintY + 10), 15, BF
CASE 4 'Remaining prey
x = Value * 10 + 271
LINE (x, 466)-(x + 8, 474), 15, BF
CASE 5 'Speed
Num$ = LTRIM$(STR$(Value))
PrintX = 602: PrintY = 464
END SELECT

FOR n = 1 TO LEN(Num$)
Char$ = MID$(Num$, n, 1)
NumDEX = (ASC(Char$) - 48) * 40
PUT (PrintX, PrintY), NumBOX(NumDEX), PSET
PrintX = PrintX + 8
NEXT n

END SUB

SUB PutSPRITE (Col, Row, Index)

PUT ((Col - 1) * 20, (Row - 1) * 20), SpriteBOX(Index), PSET

SELECT CASE Index
CASE Stone: SnakePIT(Col, Row) = -1
CASE ELSE: SnakePIT(Col, Row) = -2
END SELECT

END SUB

SUB SetPALETTE

RESTORE PaletteVALUES
FOR Colr = 0 TO 15
OUT &H3C8, Colr
READ Red: OUT &H3C9, Red
READ Grn: OUT &H3C9, Grn
READ Blu: OUT &H3C9, Blu
NEXT Colr

END SUB

SUB SetSTONES (Level)

SELECT CASE Level
CASE 2
FOR Col = 10 TO 23
PutSPRITE Col, 12, Stone
PutSPRITE Col, 13, Stone
NEXT Col
CASE 3
Row1 = 8: Row2 = 17
FOR Col = 10 TO 23
PutSPRITE Col, Row1, Stone
PutSPRITE Col, Row2, Stone
NEXT Col
CASE 4
Col1 = 9: Col2 = 24
FOR Row = 7 TO 18
IF Row = 12 THEN Row = 14
PutSPRITE Col1, Row, Stone
PutSPRITE Col2, Row, Stone
NEXT Row
FOR Col = 10 TO 23
PutSPRITE Col, 7, Stone
PutSPRITE Col, 18, Stone
NEXT Col
CASE 5
Col1 = 9: Col2 = 24
FOR Row = 6 TO 19
PutSPRITE Col1, Row, Stone
PutSPRITE Col2, Row, Stone
NEXT Row
FOR Col = 10 TO 23
IF Col = 16 THEN Col = 18
PutSPRITE Col, 6, Stone
PutSPRITE Col, 19, Stone
NEXT Col
Row = 12
FOR Col = 2 TO 31
IF Col = 3 THEN Col = 5
IF Col = 9 THEN Col = 24
IF Col = 29 THEN Col = 31
PutSPRITE Col, Row, Stone
PutSPRITE Col, Row + 1, Stone
NEXT Col
CASE 6
Row1 = 5: Row2 = 20
FOR Col = 5 TO 28
PutSPRITE Col, Row1, Stone
PutSPRITE Col, Row2, Stone
NEXT Col
Row1 = 8: Row2 = 17
FOR Col = 8 TO 25
PutSPRITE Col, Row1, Stone
PutSPRITE Col, Row2, Stone
NEXT Col
FOR Row = 9 TO 16
IF Row = 12 THEN Row = 14
PutSPRITE 8, Row, Stone
PutSPRITE 25, Row, Stone
NEXT Row
Col1 = 5: Col2 = 28
FOR Row = 6 TO 19
IF Row = 12 THEN Row = 14
PutSPRITE Col1, Row, Stone
PutSPRITE Col2, Row, Stone
NEXT Row
FOR Col = 11 TO 22
PutSPRITE Col, 11, Stone
PutSPRITE Col, 14, Stone
NEXT Col
FOR Row = 2 TO 23 STEP 21
PutSPRITE 16, Row, Stone
PutSPRITE 17, Row, Stone
NEXT Row
FOR Col = 2 TO 31 STEP 29
PutSPRITE Col, 12, Stone
PutSPRITE Col, 13, Stone
NEXT Col
CASE 7
FOR Col = 14 TO 19
PutSPRITE Col, 5, Stone
NEXT Col
FOR Col = 12 TO 13
PutSPRITE Col, 6, Stone
PutSPRITE Col + 8, 6, Stone
NEXT Col
PutSPRITE 11, 7, Stone
PutSPRITE 10, 8, Stone
PutSPRITE 9, 9, Stone
PutSPRITE 22, 7, Stone
PutSPRITE 23, 8, Stone
PutSPRITE 24, 9, Stone
FOR Row = 10 TO 11
PutSPRITE 8, Row, Stone
PutSPRITE 25, Row, Stone
NEXT Row
FOR Col = 14 TO 19
PutSPRITE Col, 19, Stone
NEXT Col
FOR Col = 12 TO 13
PutSPRITE Col, 18, Stone
PutSPRITE Col + 8, 18, Stone
NEXT Col
PutSPRITE 11, 17, Stone
PutSPRITE 10, 16, Stone
PutSPRITE 9, 15, Stone
PutSPRITE 22, 17, Stone
PutSPRITE 23, 16, Stone
PutSPRITE 24, 15, Stone
FOR Row = 13 TO 14
PutSPRITE 8, Row, Stone
PutSPRITE 25, Row, Stone
NEXT Row
FOR Col = 4 TO 10
PutSPRITE Col, 4, Stone
PutSPRITE 33 - Col, 4, Stone
PutSPRITE Col, 20, Stone
PutSPRITE 33 - Col, 20, Stone
NEXT Col
FOR Row = 4 TO 11
PutSPRITE 4, Row, Stone
PutSPRITE 4, 24 - Row, Stone
PutSPRITE 29, Row, Stone
PutSPRITE 29, 24 - Row, Stone
NEXT Row
FOR Row = 7 TO 17
IF Row = 9 THEN Row = 16
PutSPRITE 9, Row, Stone
PutSPRITE 24, Row, Stone
NEXT Row
PutSPRITE 10, 7, Stone
PutSPRITE 10, 17, Stone
PutSPRITE 23, 7, Stone
PutSPRITE 23, 17, Stone
CASE 8
FOR Col = 5 TO 25 STEP 6
IF Col = 17 THEN Col = 18
FOR Row = 5 TO 21 STEP 4
PutSPRITE Col, Row, Stone
PutSPRITE Col + 1, Row, Stone
PutSPRITE Col + 3, Row, Stone
PutSPRITE Col + 4, Row, Stone
NEXT Row
NEXT Col
FOR Row = 5 TO 20
FOR Col = 5 TO 29 STEP 6
IF Col = 17 THEN Col = 22
PutSPRITE Col, Row, Stone
NEXT Col
NEXT Row
FOR Col = 2 TO 31
IF Col = 4 THEN Col = 30
PutSPRITE Col, 12, Stone
PutSPRITE Col, 13, Stone
NEXT Col
FOR Row = 2 TO 3
PutSPRITE 16, Row, Stone
PutSPRITE 17, Row, Stone
NEXT Row
CASE 9
FOR Col = 6 TO 24 STEP 8
FOR Row = 7 TO 16 STEP 9
PutSPRITE Col, Row, Stone
PutSPRITE Col + 1, Row - 1, Stone
PutSPRITE Col + 2, Row - 2, Stone
PutSPRITE Col + 3, Row - 2, Stone
PutSPRITE Col + 4, Row - 1, Stone
PutSPRITE Col + 5, Row, Stone
PutSPRITE Col, Row + 2, Stone
PutSPRITE Col + 1, Row + 3, Stone
PutSPRITE Col + 2, Row + 4, Stone
PutSPRITE Col + 3, Row + 4, Stone
PutSPRITE Col + 4, Row + 3, Stone
PutSPRITE Col + 5, Row + 2, Stone
NEXT Row
NEXT Col
FOR Col = 4 TO 31 STEP 8
FOR Row = 12 TO 13
PutSPRITE Col, Row, Stone
PutSPRITE Col + 1, Row, Stone
NEXT Row
NEXT Col
CASE 10
FOR Col = 7 TO 25 STEP 6
FOR Row = 7 TO 17 STEP 5
FOR Col2 = Col TO Col + 1
FOR Row2 = Row TO Row + 1
PutSPRITE Col2, Row2, Stone
NEXT Row2
NEXT Col2
PutSPRITE Col - 1, Row - 1, Stone
PutSPRITE Col - 1, Row + 2, Stone
PutSPRITE Col + 2, Row - 1, Stone
PutSPRITE Col + 2, Row + 2, Stone
NEXT Row
NEXT Col
FOR Col = 2 TO 30 STEP 28
FOR Row = 2 TO 22 STEP 20
PutSPRITE Col, Row, Stone
PutSPRITE Col + 1, Row, Stone
PutSPRITE Col, Row + 1, Stone
PutSPRITE Col + 1, Row + 1, Stone
NEXT Row
NEXT Col
PutSPRITE 4, 4, Stone
PutSPRITE 29, 4, Stone
PutSPRITE 4, 21, Stone
PutSPRITE 29, 21, Stone
FOR Col = 2 TO 31
IF Col = 5 THEN Col = 29
PutSPRITE Col, 11, Stone
PutSPRITE Col, 14, Stone
NEXT Col
END SELECT

END SUB

SUB SpeedSET

GET (166, 142)-(472, 337), BigBOX
LINE (166, 142)-(472, 337), 0, BF
LINE (168, 144)-(470, 335), 8, B
LINE (170, 146)-(468, 333), 7, B
LINE (172, 148)-(466, 331), 6, B

COLOR 4
LOCATE 12, 31: PRINT "- S E T  S P E E D -"
COLOR 9
LOCATE 13, 26: PRINT "The current speed setting is ";
PRINT LTRIM$(RTRIM$(STR$(SpeedLEVEL))); "."
COLOR 7
LOCATE 15, 28: PRINT "Slow............ Press [1]"
LOCATE 16, 28: PRINT "Moderate........ Press [2]"
LOCATE 17, 28: PRINT "Medium.......... Press [3]"
LOCATE 18, 28: PRINT "Quick........... Press [4]"
LOCATE 19, 28: PRINT "Fast............ Press [5]"
COLOR 6
LOCATE 15, 28: PRINT "Slow"
LOCATE 16, 28: PRINT "Moderate"
LOCATE 17, 28: PRINT "Medium"
LOCATE 18, 28: PRINT "Quick"
LOCATE 19, 28: PRINT "Fast"
COLOR 15
LOCATE 15, 52: PRINT "1"
LOCATE 16, 52: PRINT "2"
LOCATE 17, 52: PRINT "3"
LOCATE 18, 52: PRINT "4"
LOCATE 19, 52: PRINT "5"

DO
n$ = INKEY$
LOOP WHILE n$ = ""
SELECT CASE n$
CASE "1": SpeedLEVEL = 1: SetSPEED = 25
CASE "2": SpeedLEVEL = 2: SetSPEED = 15
CASE "3": SpeedLEVEL = 3: SetSPEED = 8
CASE "4": SpeedLEVEL = 4: SetSPEED = 5
CASE "5": SpeedLEVEL = 5: SetSPEED = 2
END SELECT

PrintNUMS 5, SpeedLEVEL
Speed = SetSPEED

PUT (166, 142), BigBOX, PSET

END SUB

SUB TopTEN

GET (84, 119)-(554, 359), BigBOX
LINE (84, 119)-(554, 359), 0, BF
PUT (240, 137), TTBox, PSET
COLOR 9
LOCATE 11, 15
PRINT "#"; SPACE$(2); "NAME"; SPACE$(21); "DATE"; SPACE$(10); "SCORE"
COLOR 7
LOCATE 22, 26
PRINT "PRESS ANY KEY TO RETURN TO GAME"
PrintROW = 12
FOR c = 0 TO 9
LOCATE PrintROW, 14
COLOR 9: PRINT USING "##"; c + 1
COLOR 3
IF ScoreDATA(c).PlayerSCORE > 0 THEN
LOCATE PrintROW, 18
PRINT ScoreDATA(c).PlayerNAME
LOCATE PrintROW, 40
PRINT ScoreDATA(c).PlayDATE
LOCATE PrintROW, 56
PRINT USING "###,###"; ScoreDATA(c).PlayerSCORE
END IF
PrintROW = PrintROW + 1
NEXT c
LINE (87, 121)-(551, 357), 13, B
LINE (89, 123)-(549, 355), 13, B
PSET (89, 123), 15
LINE (91, 125)-(547, 353), 13, B
PSET (91, 125), 15
LINE (100, 157)-(538, 334), 13, B
FOR LR = 174 TO 334 STEP 16
LINE (100, LR)-(538, LR), 13
NEXT LR
LINE (124, 158)-(124, 334), 13
LINE (300, 158)-(300, 334), 13
LINE (402, 158)-(402, 334), 13

a$ = INPUT$(1)
PUT (84, 119), BigBOX, PSET

END SUB

SUB Wipe

FOR n = 1 TO 660
DO
x = INT(RND * 30)
y = INT(RND * 22)
xx = x + 1: yy = y + 1
LOOP UNTIL WipeBOX(x, y) = 0
LINE (xx * 20, yy * 20)-(xx * 20 + 19, yy * 20 + 19), 9, BF
LINE (xx * 20, yy * 20)-(xx * 20 + 19, yy * 20 + 19), 4, BF
LINE (xx * 20, yy * 20)-(xx * 20 + 19, yy * 20 + 19), 10, BF
LINE (xx * 20, yy * 20)-(xx * 20 + 19, yy * 20 + 19), 15, BF
LINE (xx * 20, yy * 20)-(xx * 20 + 19, yy * 20 + 19), 10, BF
LINE (xx * 20, yy * 20)-(xx * 20 + 19, yy * 20 + 19), 8, BF
WipeBOX(x, y) = 1
NEXT n

ERASE WipeBOX

END SUB
