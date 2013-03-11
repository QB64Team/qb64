CHDIR ".\programs\samples\thebob\abacus"

'****************************************************************************'
'
'------------------------- A B A C U S 1 2. B A S ---------------------------'
'--------------- Copyright (C) 2007 by Bob Seguin (Freeware) ----------------'
'
'****************************************************************************'

DEFINT A-Z

DECLARE FUNCTION InitMOUSE ()

DECLARE SUB MouseSTATUS (LB, RB, MouseX, MouseY)
DECLARE SUB ShowMOUSE ()
DECLARE SUB HideMOUSE ()
DECLARE SUB ClearMOUSE ()

DECLARE SUB MouseDRIVER (LB, RB, MX, MY)

DECLARE SUB Graphics ()
DECLARE SUB PutBEADS (col, OneVAL)
DECLARE SUB PutNUM (col)
DECLARE SUB Menu (InOUT)
DECLARE SUB ResetABACUS ()

DIM SHARED Box(26000)
DIM SHARED NumBOX(1 TO 250)
DIM SHARED MenuBOX(600)
DEF SEG = VARSEG(NumBOX(1))
BLOAD "abanums.bsv", VARPTR(NumBOX(1))
DEF SEG = VARSEG(MenuBOX(0))
BLOAD "abamenu.bsv", VARPTR(MenuBOX(0))
DEF SEG
DIM SHARED Abacus(1 TO 10, 1 TO 2)

DIM SHARED MouseDATA$
DIM SHARED LB, RB

'Create and load MouseDATA$ for CALL ABSOLUTE routines
Cheddar:
DATA 55,89,E5,8B,5E,0C,8B,07,50,8B,5E,0A,8B,07,50,8B,5E,08,8B
DATA 0F,8B,5E,06,8B,17,5B,58,1E,07,CD,33,53,8B,5E,0C,89,07,58
DATA 8B,5E,0A,89,07,8B,5E,08,89,0F,8B,5E,06,89,17,5D,CA,08,00
MouseDATA$ = SPACE$(57)
RESTORE Cheddar
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

SCREEN 12

GOSUB SetPALETTE
Graphics
ShowMOUSE

DO
k$ = INKEY$
IF k$ = CHR$(27) THEN SYSTEM
MouseSTATUS LB, RB, MouseX, MouseY
SELECT CASE MouseX
CASE 212 TO 233: col = 1
CASE 234 TO 255: col = 2
CASE 256 TO 277: col = 3
CASE 278 TO 299: col = 4
CASE 300 TO 321: col = 5
CASE 322 TO 343: col = 6
CASE 344 TO 365: col = 7
CASE 366 TO 387: col = 8
CASE 388 TO 409: col = 9
CASE 410 TO 431: col = 10
CASE ELSE: col = 0
END SELECT
SELECT CASE MouseY
CASE 124 TO 133: Menu 1
CASE 161 TO 176: row = 1
CASE 177 TO 192: row = 2
CASE 202 TO 218: row = 3
CASE 219 TO 234: row = 4
CASE 235 TO 250: row = 5
CASE 251 TO 266: row = 6
CASE 267 TO 282: row = 7
CASE ELSE: row = 0: Menu 0
END SELECT

IF LB = -1 THEN
IF col <> 0 THEN
SELECT CASE row
CASE 1: PutBEADS col, 6: Abacus(col, 1) = 5
CASE 2: PutBEADS col, 5: Abacus(col, 1) = 0
CASE 3 TO 7: Sum = row - 3: Abacus(col, 2) = Sum: PutBEADS col, Sum
END SELECT
PutNUM col
END IF
ClearMOUSE
END IF

LOOP

SYSTEM

SetPALETTE:
DATA 20, 0, 24, 0, 0, 42, 0, 0, 45, 10, 0, 50
DATA 55, 0, 0, 50, 0, 0, 40, 0, 0, 42, 42, 42
DATA 30, 0, 0, 20, 10, 55, 25, 5, 29, 40, 30, 63
DATA 45, 0, 0, 63, 0, 0, 60, 45, 20, 63, 63, 63
RESTORE SetPALETTE
OUT &H3C8, 0
FOR n = 1 TO 48
READ Intensity
OUT &H3C9, Intensity
NEXT n
RETURN

SUB ClearMOUSE

WHILE LB OR RB
MouseSTATUS LB, RB, MouseX, MouseY
WEND

END SUB

SUB Graphics

DEF SEG = VARSEG(Box(0))
FOR y = 0 TO 320 STEP 160
FileCOUNT = FileCOUNT + 1
FileNAME$ = "ABACUS" + LTRIM$(RTRIM$(STR$(FileCOUNT))) + ".BSV"
BLOAD FileNAME$, VARPTR(Box(0))
PUT (0, y), Box
NEXT y
BLOAD "abasets.bsv", VARPTR(Box(0))
DEF SEG

END SUB

SUB HideMOUSE

LB = 2
MouseDRIVER LB, 0, 0, 0

END SUB

FUNCTION InitMOUSE

LB = 0
MouseDRIVER LB, 0, 0, 0
InitMOUSE = LB

END FUNCTION

SUB Menu (InOUT)
STATIC MenuITEM

IF InOUT = 0 THEN GOSUB CloseMENU: EXIT SUB

MouseSTATUS LB, RB, MouseX, MouseY
SELECT CASE MouseX
CASE 210 TO 238
IF MenuITEM <> 1 THEN
GOSUB CloseMENU
MenuITEM = 1
GOSUB OpenMENU
END IF
CASE 412 TO 432
IF MenuITEM <> 2 THEN
GOSUB CloseMENU
MenuITEM = 2
GOSUB OpenMENU
END IF
CASE ELSE: GOSUB CloseMENU
END SELECT

IF LB = -1 THEN
SELECT CASE MenuITEM
CASE 1: ResetABACUS
CASE 2: GOSUB CloseMENU: SYSTEM
END SELECT
END IF

EXIT SUB

OpenMENU:
HideMOUSE
SELECT CASE MenuITEM
CASE 1: PUT (210, 124), MenuBOX(200), PSET
CASE 2: PUT (412, 124), MenuBOX(300), PSET
END SELECT
ShowMOUSE
RETURN

CloseMENU:
IF MenuITEM <> 0 THEN
HideMOUSE
SELECT CASE MenuITEM
CASE 1: PUT (210, 124), MenuBOX, PSET
CASE 2: PUT (412, 124), MenuBOX(100), PSET
END SELECT
ShowMOUSE
MenuITEM = 0
END IF
RETURN

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

SUB PutBEADS (col, BeadVAL)

PutCOL = col * 22 + 192
IF BeadVAL > 4 THEN Hop = -43 ELSE Hop = 0
HideMOUSE
PUT (PutCOL, 204 + Hop), Box(BeadVAL * 1000 + 10000), PSET
ShowMOUSE

END SUB

SUB PutNUM (col)
Sum = Abacus(col, 1) + Abacus(col, 2)
HideMOUSE
PUT (col * 22 + 198, 320), NumBOX(Sum * 25 + 1), PSET
ShowMOUSE
END SUB

SUB ResetABACUS

HideMOUSE
PUT (212, 161), Box, PSET
ShowMOUSE
ERASE Abacus

END SUB

SUB ShowMOUSE
LB = 1
MouseDRIVER LB, 0, 0, 0
END SUB
