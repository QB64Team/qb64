CHDIR ".\samples\thebob\leapfrog"

'*****************************************************************************
'
'----------------------- L E A P F R O G. B A S -- 2.1 -----------------------
'
'------------ Copyright (C) 2002 - 2007 by Bob Seguin (Freeware) -------------
'
'*****************************************************************************
DEFINT A-Z

DECLARE FUNCTION InitMOUSE ()

DECLARE SUB MouseDRIVER (LB, RB, mX, mY)
DECLARE SUB MouseSTATUS (LB, RB, MouseX, MouseY)
DECLARE SUB ShowMOUSE ()
DECLARE SUB HideMOUSE ()
DECLARE SUB LocateMOUSE (x, y)
DECLARE SUB FieldMOUSE (x1, y1, x2, y2)
DECLARE SUB PauseMOUSE (LB, RB, MouseX, MouseY)
DECLARE SUB ClearMOUSE ()
DECLARE SUB Interval (Length!)

DECLARE SUB DrawSCREEN ()
DECLARE SUB RAMarrays ()
DECLARE SUB SETxy (Pad)
DECLARE SUB Rings (Pad, Colr)
DECLARE SUB PutFROG (Pad, Image)
DECLARE SUB Hop (From, Destination, Direction)
DECLARE FUNCTION HopCHEK (Pad1, Pad2)
DECLARE FUNCTION HopDIRECTION (Pad1, Pad2)

DIM SHARED LilyPOND(1 TO 15)
DIM SHARED Box(1 TO 16400)
DIM SHARED BasicsBOX(1 TO 3000)
DIM SHARED BackBOX(1 TO 1650)
DIM SHARED ErrorBOX(1 TO 2640)
DIM SHARED SoundON
DIM SHARED MouseDATA$

CONST ArrayHOP& = 1650
CONST Wdth = 89
CONST Dpth = 67

FOR n = 2 TO 15
LilyPOND(n) = 1
NEXT n

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

SCREEN 12

OUT &H3C8, 0
FOR n = 1 TO 48
OUT &H3C9, 0
NEXT n

RAMarrays
DrawSCREEN
GOSUB SetPALETTE

ShowMOUSE
SoundON = 1

DO
k$ = INKEY$
IF k$ = CHR$(27) THEN SYSTEM
MouseSTATUS LB, RB, MouseX, MouseY
SELECT CASE MouseY
CASE 8 TO 18
SELECT CASE MouseX
CASE 130 TO 188
IF Menu <> 1 THEN
GOSUB PutMENU
Mx1 = 130: Mx2 = 188
GOSUB GetMENU
HideMOUSE
PUT (130, 8), BasicsBOX(1851), PSET
ShowMOUSE
Menu = 1
END IF
IF LB THEN GOSUB NewGAME
CASE 220 TO 258
IF Menu <> 2 THEN
GOSUB PutMENU
Mx1 = 220: Mx2 = 260
GOSUB GetMENU
HideMOUSE
PUT (220, 8), BasicsBOX(2201), PSET
ShowMOUSE
Menu = 2
END IF
IF LB THEN
IF SoundON = 0 THEN
HideMOUSE
PUT (220, 8), BasicsBOX(2101), PSET
ShowMOUSE
SoundON = 1
ELSE
HideMOUSE
PUT (220, 8), BasicsBOX(2301), PSET
ShowMOUSE
SoundON = 0
END IF
GOSUB GetMENU
ClearMOUSE
END IF
CASE 600 TO 626
IF Menu <> 3 THEN
GOSUB PutMENU
Mx1 = 600: Mx2 = 626
GOSUB GetMENU
HideMOUSE
PUT (600, 8), BasicsBOX(2001), PSET
ShowMOUSE
Menu = 3
END IF
IF LB THEN SYSTEM
CASE ELSE
IF Menu THEN GOSUB PutMENU
END SELECT
CASE 65 TO 121
SELECT CASE MouseX
CASE 290 TO 346: Pad = 1
END SELECT
CASE 145 TO 201
SELECT CASE MouseX
CASE 242 TO 298: Pad = 2
CASE 338 TO 394: Pad = 3
END SELECT
CASE 225 TO 281
SELECT CASE MouseX
CASE 194 TO 250: Pad = 4
CASE 290 TO 346: Pad = 5
CASE 386 TO 442: Pad = 6
END SELECT
CASE 305 TO 361
SELECT CASE MouseX
CASE 146 TO 202: Pad = 7
CASE 242 TO 298: Pad = 8
CASE 338 TO 394: Pad = 9
CASE 434 TO 490: Pad = 10
END SELECT
CASE 385 TO 441
SELECT CASE MouseX
CASE 98 TO 154: Pad = 11
CASE 194 TO 250: Pad = 12
CASE 290 TO 346: Pad = 13
CASE 386 TO 442: Pad = 14
CASE 482 TO 538: Pad = 15
END SELECT
CASE ELSE
IF Menu THEN GOSUB PutMENU
END SELECT

IF BoxON THEN IF LB AND MouseX > 578 THEN SYSTEM
IF GameOVER = 0 THEN
IF LB AND Pad THEN
IF Chosen THEN
IF Pad = Pad1 THEN
Rings Pad1, 11
Pad1 = 0: Chosen = 0
ClearMOUSE
GOTO Continue
END IF
Direction = HopDIRECTION(Pad1, Pad)
MidPAD = HopCHEK(Pad1, Pad)
GOSUB ErrorCHECK
IF Pad THEN
Rings Pad1, 11
Chosen = 0
Hop Pad1, Pad, Direction
LilyPOND(Pad) = 1
LilyPOND(Pad1) = 0
LilyPOND(MidPAD) = 0
PutFROG MidPAD, 3
IF SoundON THEN PLAY "MBMST220L64O1cP16eP16g"
Interval .1
PutFROG MidPAD, 2
Interval .3
PutFROG MidPAD, 1
IF SoundON THEN PLAY "MBT220L64O2b"
Pad1 = 0: Pad = 0: Chosen = 0
FOR n = 1 TO 15
IF LilyPOND(n) = 1 THEN
Count = Count + 1
LastPAD = n
END IF
NEXT n
IF Count = 1 THEN
Interval .3
IF SoundON THEN
PLAY "MFMST120O1L16ceg>ceg>ceg>L32cg"
PLAY "MBMST120O4L32cgcgcgcg"
END IF
PutFROG LastPAD, 3
FOR Reps = 1 TO 8
Rings LastPAD, 0
WAIT &H3DA, 8
WAIT &H3DA, 8, 2
Rings LastPAD, 9
WAIT &H3DA, 8
WAIT &H3DA, 8, 8
Rings LastPAD, 4
WAIT &H3DA, 8
WAIT &H3DA, 8, 8
Rings LastPAD, 11
WAIT &H3DA, 8
WAIT &H3DA, 8, 8
NEXT Reps
Rings LastPAD, 9
PutFROG LastPAD, 2
GameOVER = 1
ELSE
Count = 0
END IF
END IF
ELSE
IF LilyPOND(Pad) = 1 THEN
Rings Pad, 7
Pad1 = Pad
Chosen = 1
ClearMOUSE
ELSE
HideMOUSE
PUT (38, 230), ErrorBOX, PSET
ShowMOUSE
Interval 1.5
HideMOUSE
LINE (36, 230)-(160, 260), 0, BF
ShowMOUSE
Pad1 = 0: Pad = 0: Chosen = 0
END IF
END IF
END IF
END IF
Continue:
Pad = 0
LOOP

SYSTEM

ErrorCHECK:
IF MidPAD = 0 THEN
HideMOUSE
PUT (38, 230), ErrorBOX(661), PSET
ShowMOUSE
Rings Pad1, 11
Pad = 0: Pad1 = 0: Chosen = 0
Interval 1.5
HideMOUSE
LINE (36, 230)-(160, 260), 0, BF
ShowMOUSE
RETURN
END IF
IF LilyPOND(Pad) = 1 THEN
HideMOUSE
PUT (38, 230), ErrorBOX(1321), PSET
ShowMOUSE
Rings Pad1, 11
Pad = 0: Pad1 = 0: Chosen = 0
ELSE
IF LilyPOND(MidPAD) = 0 THEN
HideMOUSE
PUT (38, 230), ErrorBOX(1981), PSET
ShowMOUSE
Rings Pad1, 11
Pad = 0: Pad1 = 0: Chosen = 0
END IF
END IF
IF Pad = 0 THEN
Interval 1.5
HideMOUSE
LINE (36, 230)-(160, 260), 0, BF
ShowMOUSE
END IF
RETURN

GetMENU:
HideMOUSE
GET (Mx1, 8)-(Mx2, 18), BasicsBOX(2701)
ShowMOUSE
RETURN

PutMENU:
HideMOUSE
IF Menu = 1 THEN PUT (130, 8), BasicsBOX(2701), PSET
IF Menu = 2 THEN PUT (220, 8), BasicsBOX(2701), PSET
IF Menu = 3 THEN PUT (600, 8), BasicsBOX(2701), PSET
ShowMOUSE
Menu = 0
RETURN

NewGAME:
IF SoundON THEN PLAY "MBT220MSO5L64cP16dP16eP16fP16gP16fP16eP16dP16c"
FOR n = 2 TO 15
LilyPOND(n) = 1
PutFROG n, 2
NEXT n
LilyPOND(1) = 0
PutFROG 1, 1
IF LastPAD THEN Rings LastPAD, 11
Count = 0
GameOVER = 0
ClearMOUSE
RETURN

SetPALETTE:
DATA 0,0,21, 60,55,55, 0,38,14, 0,0,0, 63,0,0, 0,24,0, 0,34,10, 32,40,55
DATA 21,21,21, 53,0,63, 31,55,4, 18,28,40, 63,58,58, 8,30,0, 63,63,21, 63,63,63
RESTORE SetPALETTE
OUT &H3C8, 0
FOR n = 1 TO 48
READ Intensity: OUT &H3C9, Intensity
NEXT n
RETURN

SUB ClearMOUSE
SHARED LB, RB

WHILE LB OR RB
MouseSTATUS LB, RB, MouseX, MouseY
WEND

END SUB

SUB DrawSCREEN

DEF SEG = VARSEG(Box(1))
BLOAD "leappnd1.bsv", VARPTR(Box(1))
PUT (191, 63), Box, PSET
BLOAD "leappnd2.bsv", VARPTR(Box(1))
PUT (95, 302), Box, PSET
DEF SEG

DEF SEG = VARSEG(Box(1))
BLOAD "leapins1.bsv", VARPTR(Box(1))
PUT (24, 45), Box
BLOAD "leapins2.bsv", VARPTR(Box(1))
PUT (445, 45), Box
DEF SEG

LINE (5, 24)-(634, 474), 8, B
PAINT (0, 0), 8
LINE (10, 29)-(629, 469), 11, B
DEF SEG = VARSEG(Box(1))
BLOAD "leaphead.bsv", VARPTR(Box(1))
DEF SEG
PUT (12, 6), Box, PSET

DEF SEG = VARSEG(BasicsBOX(1))
BLOAD "leapbscs.bsv", VARPTR(BasicsBOX(1))
DEF SEG

FOR n = 2 TO 15
PutFROG n, 2
NEXT n

FOR n = 1 TO 15
Rings n, 11
NEXT n

DEF SEG = VARSEG(ErrorBOX(1))
BLOAD "leaperrs.bsv", VARPTR(ErrorBOX(1))
DEF SEG

END SUB

SUB FieldMOUSE (x1, y1, x2, y2)

MouseDRIVER 7, 0, x1, x2
MouseDRIVER 8, 0, y1, y2

END SUB

SUB HideMOUSE

LB = 2
MouseDRIVER LB, 0, 0, 0

END SUB

SUB Hop (From, Destination, Direction)
SHARED x, y

SELECT CASE Direction
CASE 1: Direction$ = "UL"
CASE 2: Direction$ = "UR"
CASE 3: Direction$ = "DL"
CASE 4: Direction$ = "DR"
CASE 5: Direction$ = "L"
CASE 6: Direction$ = "R"
END SELECT

FileNAME$ = "Leap" + Direction$ + ".BSV"

DEF SEG = VARSEG(Box(1))
BLOAD FileNAME$, VARPTR(Box(1))
DEF SEG

SETxy From

IF SoundON THEN PLAY "MBT220MSL64O5cP16gP16>cP16gP16cP16<gP16c"
FOR n = 9903 TO 9921 STEP 3
PutFROG From, 1
HideMOUSE
GET (x + Box(n - 2), y + Box(n - 1))-(x + Box(n - 2) + Wdth, y + Box(n - 1) + Dpth), BackBOX
PUT (x + Box(n - 2), y + Box(n - 1)), Box(Box(n) + ArrayHOP&), AND
PUT (x + Box(n - 2), y + Box(n - 1)), Box(Box(n)), OR
'IF n = 9915 THEN a$ = INPUT$(1)
ShowMOUSE
Interval 0
WAIT &H3DA, 8
WAIT &H3DA, 8, 8
HideMOUSE
PUT (x + Box(n - 2), y + Box(n - 1)), BackBOX, PSET
ShowMOUSE
NEXT n
PutFROG Destination, 2
Interval .5

END SUB

FUNCTION HopCHEK (Pad1, Pad2)

HopVAL = VAL(LTRIM$(STR$(Pad1)) + LTRIM$(STR$(Pad2)))

SELECT CASE HopVAL
CASE 14: HopCHEK = 2
CASE 16: HopCHEK = 3
CASE 27: HopCHEK = 4
CASE 29: HopCHEK = 5
CASE 38: HopCHEK = 5
CASE 310: HopCHEK = 6
CASE 41: HopCHEK = 2
CASE 46: HopCHEK = 5
CASE 413: HopCHEK = 8
CASE 411: HopCHEK = 7
CASE 512: HopCHEK = 8
CASE 514: HopCHEK = 9
CASE 61: HopCHEK = 3
CASE 64: HopCHEK = 5
CASE 613: HopCHEK = 9
CASE 615: HopCHEK = 10
CASE 72: HopCHEK = 4
CASE 79: HopCHEK = 8
CASE 83: HopCHEK = 5
CASE 810: HopCHEK = 9
CASE 92: HopCHEK = 5
CASE 97: HopCHEK = 8
CASE 103: HopCHEK = 6
CASE 108: HopCHEK = 9
CASE 114: HopCHEK = 7
CASE 1113: HopCHEK = 12
CASE 125: HopCHEK = 8
CASE 1214: HopCHEK = 13
CASE 1311: HopCHEK = 12
CASE 134: HopCHEK = 8
CASE 136: HopCHEK = 9
CASE 1315: HopCHEK = 14
CASE 145: HopCHEK = 9
CASE 1412: HopCHEK = 13
CASE 156: HopCHEK = 10
CASE 1513: HopCHEK = 14
CASE ELSE: HopCHEK = 0
END SELECT

END FUNCTION

FUNCTION HopDIRECTION (Pad1, Pad2)
SHARED x, y

SETxy Pad1
Pad1x = x: Pad1y = y
SETxy Pad2
Pad2x = x: Pad2y = y

IF Pad1y - Pad2y = 160 THEN Up = 1
IF Pad2y - Pad1y = 160 THEN Down = 1
IF Pad1y = Pad2y THEN Across = 1
IF Pad1x - Pad2x = 96 THEN Left = 1
IF Pad2x - Pad1x = 96 THEN Right = 1

IF Up AND Left THEN HopDIRECTION = 1
IF Up AND Right THEN HopDIRECTION = 2
IF Down AND Left THEN HopDIRECTION = 3
IF Down AND Right THEN HopDIRECTION = 4
IF Across THEN
IF Pad1x - Pad2x = 192 THEN HopDIRECTION = 5
IF Pad2x - Pad1x = 192 THEN HopDIRECTION = 6
END IF

END FUNCTION

FUNCTION InitMOUSE

LB = 0
MouseDRIVER LB, 0, 0, 0
InitMOUSE = LB

END FUNCTION

SUB Interval (Length!)

OldTIMER# = TIMER
DO
IF TIMER < OldTIMER# THEN EXIT DO
LOOP UNTIL TIMER > OldTIMER# + Length!

END SUB

SUB LocateMOUSE (x, y)

LB = 4
mX = x
mY = y
MouseDRIVER LB, 0, mX, mY

END SUB

SUB MouseDRIVER (LB, RB, mX, mY)

DEF SEG = VARSEG(MouseDATA$)
Mouse = SADD(MouseDATA$)
CALL ABSOLUTE(LB, RB, mX, mY, Mouse)

END SUB

SUB MouseSTATUS (LB, RB, MouseX, MouseY)

LB = 3
MouseDRIVER LB, RB, mX, mY
LB = ((RB AND 1) <> 0)
RB = ((RB AND 2) <> 0)
MouseX = mX
MouseY = mY

END SUB

SUB PauseMOUSE (OldLB, OldRB, OldMX, OldMY)


SHARED Key$

DO
Key$ = UCASE$(INKEY$)
MouseSTATUS LB, RB, MouseX, MouseY
LOOP UNTIL LB <> OldLB OR RB <> OldRB OR MouseX <> OldMX OR MouseY <> OldMY OR Key$ <> ""

END SUB

SUB PutFROG (Pad, Image)
SHARED x, y

Index = (Image - 1) * 600 + 51
SETxy Pad

HideMOUSE
PUT (x - 24, y - 20), BasicsBOX(Index), PSET
ShowMOUSE

END SUB

SUB RAMarrays
DEF SEG = VARSEG(Box(1))
BLOAD "leapdr.bsv", VARPTR(Box(1))
BLOAD "leapdl.bsv", VARPTR(Box(1))
BLOAD "leapur.bsv", VARPTR(Box(1))
BLOAD "leapul.bsv", VARPTR(Box(1))
BLOAD "leapr.bsv", VARPTR(Box(1))
BLOAD "leapl.bsv", VARPTR(Box(1))
DEF SEG
END SUB

SUB Rings (Pad, Colr)
SHARED x, y

SETxy Pad

HideMOUSE
CIRCLE (x, y), 44, Colr
CIRCLE (x, y), 39, Colr
ShowMOUSE

END SUB

SUB SETxy (Pad)
SHARED x, y

SELECT CASE Pad
CASE 1: y = 95: x = 318
CASE 2: y = 175: x = 270
CASE 3: y = 175: x = 366
CASE 4: y = 255: x = 222
CASE 5: y = 255: x = 318
CASE 6: y = 255: x = 414
CASE 7: y = 335: x = 174
CASE 8: y = 335: x = 270
CASE 9: y = 335: x = 366
CASE 10: y = 335: x = 462
CASE 11: y = 415: x = 126
CASE 12: y = 415: x = 222
CASE 13: y = 415: x = 318
CASE 14: y = 415: x = 414
CASE 15: y = 415: x = 510
END SELECT

END SUB

SUB ShowMOUSE
LB = 1
MouseDRIVER LB, 0, 0, 0
END SUB
