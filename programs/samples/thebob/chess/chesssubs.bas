CHDIR ".\samples\thebob\chess"

'CHESSUBS.BAS
DEFINT A-Z
DECLARE FUNCTION InitMOUSE ()
DECLARE SUB MouseSTATUS (LB, RB, MouseX, MouseY)
DECLARE SUB ShowMOUSE ()
DECLARE SUB HideMOUSE ()
DECLARE SUB LocateMOUSE (x, y)
DECLARE SUB FieldMOUSE (x1, y1, x2, y2)
DECLARE SUB PauseMOUSE (LB, RB, MouseX, MouseY)
DECLARE SUB ClearMOUSE ()
DECLARE SUB MouseDRIVER (LB, RB, MX, MY)
DECLARE SUB LoadSCREEN ()
DECLARE SUB SetPALETTE ()
DECLARE SUB PutPIECE (OldROW, OldCOL, NewROW, NewCOL)
DECLARE SUB ClearSQUARE (Row, Col)
DECLARE SUB HighLIGHT (Row, Col, OnOFF)

DIM SHARED MouseDATA$
DIM SHARED LB, RB

'Create and load MouseDATA$ for CALL ABSOLUTE routines
DATA 55,89,E5,8B,5E,0C,8B,07,50,8B,5E,0A,8B,07,50,8B,5E,08,8B
DATA 0F,8B,5E,06,8B,17,5B,58,1E,07,CD,33,53,8B,5E,0C,89,07,58
DATA 8B,5E,0A,89,07,8B,5E,08,89,0F,8B,5E,06,89,17,5D,CA,08,00
MouseDATA$ = SPACE$(57)
FOR i = 1 TO 57
READ h$
Hexxer$ = CHR$(VAL("&H" + h$))
MID$(MouseDATA$, i, 1) = Hexxer$
NEXT i

Moused = InitMOUSE
IF NOT Moused THEN
PRINT "Sorry, cat must have got the mouse."
SLEEP 2
SYSTEM
END IF

BoardDATA:
DATA 2, 3, 4, 5, 6, 4, 3, 2
DATA 1, 1, 1, 1, 1, 1, 1, 1
DATA 0, 0, 0, 0, 0, 0, 0, 0
DATA 0, 0, 0, 0, 0, 0, 0, 0
DATA 0, 0, 0, 0, 0, 0, 0, 0
DATA 0, 0, 0, 0, 0, 0, 0, 0
DATA 11, 11, 11, 11, 11, 11, 11, 11
DATA 12, 13, 14, 15, 16, 14, 13, 12

DIM SHARED Box(1 TO 26000)
DIM SHARED LilBOX(1 TO 800)
DIM SHARED Board(1 TO 8, 1 TO 8)

CONST King = 1
CONST Queen = 751
CONST Bishop = 1501
CONST Knight = 2251
CONST Rook = 3001
CONST Pawn = 3751
CONST White = 0 'piece color
CONST Black = 4500 'piece color
CONST Light = 0 'square color
CONST Dark = 9000 'square color
CONST ELight = 18751 'erase light square
CONST EDark = 18001 'erase dark square

SCREEN 12

SetPALETTE
LoadSCREEN
COLOR 7: LOCATE 29, 22: PRINT "PRESS ESC TO QUIT";
LocateMOUSE 254, 194
ShowMOUSE
DO
k$ = INKEY$
MouseSTATUS LB, RB, MouseX, MouseY
SELECT CASE MouseX
CASE 31 TO 80: Col = 1
CASE 81 TO 130: Col = 2
CASE 131 TO 180: Col = 3
CASE 181 TO 230: Col = 4
CASE 231 TO 280: Col = 5
CASE 281 TO 330: Col = 6
CASE 331 TO 380: Col = 7
CASE 381 TO 430: Col = 8
END SELECT
SELECT CASE MouseY
CASE 31 TO 80: Row = 1
CASE 81 TO 130: Row = 2
CASE 131 TO 180: Row = 3
CASE 181 TO 230: Row = 4
CASE 231 TO 280: Row = 5
CASE 281 TO 330: Row = 6
CASE 331 TO 380: Row = 7
CASE 381 TO 430: Row = 8
END SELECT

IF LB = -1 THEN
SELECT CASE Clicked
CASE 0
ExROW = Row: ExCOL = Col
HighLIGHT Row, Col, 1
Clicked = 1
CASE 1
IF ExROW = Row AND ExCOL = Col THEN
HighLIGHT Row, Col, 0
ELSE
PutPIECE ExROW, ExCOL, Row, Col
END IF
Clicked = 0
END SELECT
END IF

ClearMOUSE
LOOP UNTIL k$ = CHR$(27)

SYSTEM

PaletteDATA:
DATA 12,0,10, 17,19,17, 20,22,20, 23,25,23
DATA 63,0,0, 63,60,50, 58,55,45, 53,50,40
DATA 0,0,0, 42,42,48, 50,50,55, 40,40,63
DATA 15,15,34, 58,37,15, 60,52,37, 63,63,63

SUB ClearMOUSE

WHILE LB OR RB
MouseSTATUS LB, RB, MouseX, MouseY
WEND

END SUB

SUB ClearSQUARE (Row, Col)

IF (Col + Row MOD 2) MOD 2 THEN Square = EDark ELSE Square = ELight
x = Col * 50 - 19
y = Row * 50 - 19
PUT (x, y), Box(Square), PSET

END SUB

SUB FieldMOUSE (x1, y1, x2, y2)

MouseDRIVER 7, 0, x1, x2
MouseDRIVER 8, 0, y1, y2

END SUB

SUB HideMOUSE

LB = 2
MouseDRIVER LB, 0, 0, 0

END SUB

SUB HighLIGHT (Row, Col, OnOFF)
STATIC SquareON, Oldx, Oldy

IF SquareON AND OnOFF = 0 THEN
HideMOUSE
PUT (Oldx, Oldy), LilBOX, PSET
ShowMOUSE
SquareON = 0
EXIT SUB
END IF

x = Col * 50 - 19
y = Row * 50 - 19
HideMOUSE
GET (x, y)-(x + 46, y + 46), LilBOX
LINE (x, y)-(x + 46, y + 46), 4, B
LINE (x + 1, y + 1)-(x + 45, y + 45), 4, B
ShowMOUSE
SquareON = 1: Oldx = x: Oldy = y

END SUB

FUNCTION InitMOUSE

LB = 0
MouseDRIVER LB, 0, 0, 0
InitMOUSE = LB

END FUNCTION

SUB LoadSCREEN

'Loads screen and then loads chess pieces into Box array
FileNUM = 0
DEF SEG = VARSEG(Box(1))
FOR y = 0 TO 320 STEP 160
FileNUM = FileNUM + 1
FileNAME$ = "ChessBD" + LTRIM$(STR$(FileNUM)) + ".BSV"
BLOAD FileNAME$, VARPTR(Box(1))
PUT (0, y), Box, PSET
NEXT y
BLOAD "chesspcs.bsv", VARPTR(Box(1))
DEF SEG

'read starting values into map array
RESTORE BoardDATA
FOR Col = 1 TO 8
FOR Row = 1 TO 8
READ Board(Col, Row)
NEXT Row
NEXT Col

END SUB

SUB LocateMOUSE (x, y)

LB = 4
MX = x
MY = y
MouseDRIVER LB, 0, MX, MY

END SUB

SUB MouseDRIVER (LB, RB, MX, MY)

DEF SEG = VARSEG(MouseDATA$)
mouse = SADD(MouseDATA$)
CALL ABSOLUTE(LB, RB, MX, MY, mouse)

END SUB

SUB MouseSTATUS (LB, RB, MouseX, MouseY)

LB = 3
MouseDRIVER LB, RB, MX, MY
LB = ((RB AND 1) <> 0)
RB = ((RB AND 2) <> 0)
MouseX = MX
MouseY = MY

END SUB

SUB PauseMOUSE (OldLB, OldRB, OldMX, OldMY)


SHARED Key$

DO
Key$ = UCASE$(INKEY$)
MouseSTATUS LB, RB, MouseX, MouseY
LOOP UNTIL LB <> OldLB OR RB <> OldRB OR MouseX <> OldMX OR MouseY <> OldMY OR Key$ <> ""

END SUB

SUB PutPIECE (Row1, Col1, Row2, Col2)

IF Board(Row1, Col1) <> 0 THEN
SELECT CASE Board(Row1, Col1) MOD 10
CASE 1: Piece = Pawn
CASE 2: Piece = Rook
CASE 3: Piece = Knight
CASE 4: Piece = Bishop
CASE 5: Piece = Queen
CASE 6: Piece = King
END SELECT

IF (Col1 + Row1 MOD 2) MOD 2 THEN Cancel = EDark ELSE Cancel = ELight
IF (Col2 + Row2 MOD 2) MOD 2 THEN Square = Dark ELSE Square = Light
IF Board(Row1, Col1) \ 10 = 0 THEN Colr = Black ELSE Colr = White

x = Col1 * 50 - 19
y = Row1 * 50 - 19
HideMOUSE
PUT (x, y), Box(Cancel), PSET
ShowMOUSE

Board(Row2, Col2) = Board(Row1, Col1)
Board(Row1, Col1) = 0

x = Col2 * 50 - 19
y = Row2 * 50 - 19
HideMOUSE
PUT (x, y), Box(Colr + Piece + Square), PSET
ShowMOUSE
ELSE
HighLIGHT Row1, Col1, 0
END IF

END SUB

SUB SetPALETTE

RESTORE PaletteDATA
OUT &H3C8, 0
FOR n = 1 TO 48
READ Intensity
OUT &H3C9, Intensity
NEXT n

END SUB

SUB ShowMOUSE
LB = 1
MouseDRIVER LB, 0, 0, 0
END SUB
