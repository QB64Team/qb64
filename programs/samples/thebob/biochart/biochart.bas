CHDIR ".\programs\samples\thebob\biochart"

'****************************************************************************'
'------------------------- B I O C H A R T . B A S --------------------------'
'------------- Copyright (C) 2007 by Bob Seguin (Freeware)-------------------'
'****************************************************************************'

DEFINT A-Z
DECLARE SUB PrintSTRING (x, y, Prnt$)
DECLARE SUB Graphics ()
DECLARE SUB ChartGFX ()
DECLARE SUB Birthday ()
DECLARE SUB ChartBD ()
DECLARE SUB PutNUMS (x, Num)

DECLARE FUNCTION GetDATE$ ()

DIM SHARED NumBOX(300)
DIM SHARED Box(12000)
DIM SHARED FontBOX(6000)
DIM SHARED xBOX(1 TO 9)
DEF SEG = VARSEG(FontBOX(0))
BLOAD "brsmssb.fnt", VARPTR(FontBOX(0))
DEF SEG = VARSEG(NumBOX(0))
BLOAD "brsnums.bsv", VARPTR(NumBOX(0))
DEF SEG

CONST Degree! = 3.14159 / 180
CONST Physical! = 90 / 23
CONST Emotional! = 90 / 28
CONST Intellectual! = 90 / 33
CONST Intuitive! = 90 / 38

DIM SHARED DATE2$, Birthdate$
DIM SHARED Hour!
DIM SHARED Months(1 TO 12) AS INTEGER
RESTORE MonthDATA
FOR n = 1 TO 12: READ Months(n): NEXT n
RESTORE xDATA
FOR n = 1 TO 8: READ xBOX(n): NEXT n

SCREEN 12
GOSUB SetPALETTE
DATE2$ = DATE$

Graphics
Birthday

DO
k$ = UCASE$(INKEY$)
SELECT CASE k$
CASE "B"
PUT (162, 176), Box, PSET
B$ = GetDATE$
IF B$ = "NULL" THEN
SYSTEM
ELSE
Birthdate$ = B$
ChartBD
END IF
CASE "T"
PUT (162, 181), Box(3500), PSET
B$ = GetDATE$
IF B$ = "NULL" THEN DATE2$ = DATE$ ELSE DATE2$ = B$
LINE (194, 419)-(294, 434), 0, BF
PrintSTRING 196, 420, "DATE: " + DATE2$
ChartBD
CASE CHR$(27): EXIT DO
END SELECT
LOOP

SYSTEM

xDATA:
DATA 379, 386, 402, 409, 425, 432, 439, 446

MonthDATA:
DATA 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31

SetPALETTE:
RESTORE SetPALETTE
DATA 0, 0, 21, 21, 8, 43, 24, 10, 48, 26, 11, 53
DATA 28,12,58, 32, 13, 63, 63, 63, 21, 42, 42, 42
DATA 63, 0, 0, 21, 31, 63, 52, 41, 63, 55, 55, 55
DATA 0, 0, 42, 63, 21, 63, 32, 32, 42, 63, 63, 63
RESTORE SetPALETTE
OUT &H3C8, 0
FOR n = 1 TO 48
READ Colr
OUT &H3C9, Colr
NEXT n
RETURN

SUB Birthday

OPEN "brbd.dta" FOR BINARY AS #1
IF LOF(1) THEN
CLOSE #1
OPEN "brbd.dta" FOR INPUT AS #1
INPUT #1, Birthdate$
CLOSE #1
ELSE
CLOSE #1
PUT (162, 176), Box, PSET
B$ = GetDATE$
IF B$ = "NULL" THEN
SYSTEM
ELSE
Birthdate$ = B$
END IF
END IF
ChartBD

END SUB

SUB ChartBD

LINE (220, 89)-(420, 102), 0, BF
PrintSTRING 240, 89, "For a person born"
PrintSTRING 340, 89, Birthdate$
OPEN "brbd.dta" FOR OUTPUT AS #1
PRINT #1, Birthdate$
CLOSE #1
ChartGFX

Hour! = VAL(MID$(TIME$, 1, 2)) * .83
LINE (310 + Hour!, 110)-(310 + Hour!, 426), 11
LINE (310 + Hour!, 426)-(338, 426), 11
PSET (310, 410), 7: DRAW "D16L12"

Month$ = MID$(DATE2$, 1, 2)
Day$ = MID$(DATE2$, 4, 2)
Year$ = MID$(DATE2$, 7, 4)
M$ = MID$(Birthdate$, 1, 2)
D$ = MID$(Birthdate$, 4, 2)
y$ = MID$(Birthdate$, 7, 4)
FirstMONTH = Months(VAL(M$)) - VAL(D$) + 1
FOR n = (VAL(M$) + 1) TO 12
BalMONTHS = BalMONTHS + Months(n)
IF n = 2 AND ((VAL(y$) MOD 4) = 0) THEN BalMONTHS = BalMONTHS + 1
NEXT n
FirstYEAR = FirstMONTH + BalMONTHS
FOR n = (VAL(y$) + 1) TO (VAL(Year$) - 1)
IF n MOD 4 = 0 THEN Yr = 366 ELSE Yr = 365
TDays = TDays + Yr
NEXT n
TDays = TDays + FirstYEAR

FOR n = 1 TO VAL(Month$) - 1
Days = Days + Months(n)
IF n = 2 THEN
IF VAL(Year$) MOD 4 = 0 THEN Days = Days + 1
END IF
NEXT n

TDays = TDays + Days + VAL(Day$) - 1

VIEW SCREEN (10, 110)-(630, 410)

'EMOTIONAL
PreviousX = 320 - (((TDays MOD 28) + 28) * 20)
PreviousY = 260
C! = 0
FOR x = 320 - (((TDays MOD 28) + 28) * 20) TO 630 STEP 5
LINE (PreviousX, PreviousY)-(x, 260 + SIN(C! * Degree!) * 150), 8
PreviousX = x
PreviousY = 260 + SIN(C! * Degree!) * 150
C! = C! - Emotional!
NEXT x

'INTELLECTUAL
PreviousX = 320 - (((TDays MOD 33) + 33) * 20)
PreviousY = 260
C! = 0
FOR x = 320 - (((TDays MOD 33) + 33) * 20) TO 630 STEP 5
LINE (PreviousX, PreviousY)-(x, 260 + SIN(C! * Degree!) * 150), 6
PreviousX = x
PreviousY = 260 + SIN(C! * Degree!) * 150
C! = C! - Intellectual!
NEXT x

PreviousX = 10
PreviousY = 260
C! = 0
'PHYSICAL
PreviousX = 320 - (((TDays MOD 23) + 23) * 20)
PreviousY = 250
FOR x = 320 - (((TDays MOD 23) + 23) * 20) TO 630 STEP 5
LINE (PreviousX, PreviousY)-(x, 260 + SIN(C! * Degree!) * 150), 9
PreviousX = x
PreviousY = 260 + SIN(C! * Degree!) * 150
C! = C! - Physical!
NEXT x


'INTUITIVE
PreviousX = 320 - (((TDays MOD 38) + 38) * 20)
PreviousY = 260
C! = 0
FOR x = 320 - (((TDays MOD 38) + 38) * 20) TO 630 STEP 5
LINE (PreviousX, PreviousY)-(x, 260 + SIN(C! * Degree!) * 150), 13
PreviousX = x
PreviousY = 260 + SIN(C! * Degree!) * 150
C! = C! - Intuitive!
NEXT x

VIEW

END SUB

DEFSNG A-Z
SUB ChartGFX

LINE (5, 106)-(634, 414), 7, BF
LINE (9, 109)-(631, 170), 1, BF
LINE (9, 170)-(631, 230), 2, BF
LINE (9, 230)-(631, 290), 3, BF
LINE (9, 290)-(631, 350), 2, BF
LINE (9, 350)-(631, 411), 1, BF
LINE (9, 109)-(631, 411), 7, B
FOR x = 30 TO 610 STEP 20
LINE (x, 110)-(x, 410), 7
IF x = 330 THEN PAINT (x - 10, 260), 7
NEXT x
LINE (10, 260)-(630, 260), 7

END SUB

DEFINT A-Z
FUNCTION GetDATE$
i = 1: Interval! = .25: Colr = 15
DO
WAIT &H3DA, 8: WAIT &H3DA, 8, 8
IF i < 9 THEN LINE (xBOX(i) + 1, 201)-(xBOX(i) + 6, 202), Colr, B
k$ = INKEY$
SELECT CASE k$
CASE "0" TO "9"
IF i < 9 THEN
LINE (xBOX(i) + 1, 201)-(xBOX(i) + 6, 202), 15, BF
PutNUMS xBOX(i), VAL(k$)
D$ = D$ + k$
i = i + 1
END IF
CASE CHR$(13) 'Enter
IF LEN(D$) = 8 THEN
mm$ = MID$(D$, 1, 2)
dd$ = MID$(D$, 3, 2)
yy$ = MID$(D$, 5, 4)
IF VAL(mm$) > 0 AND VAL(mm$) < 13 THEN
IF VAL(dd$) > 0 AND VAL(dd$) < 32 THEN
IF VAL(yy$) > 1900 AND VAL(yy$) < 3000 THEN
GetDATE$ = mm$ + "-" + dd$ + "-" + yy$
ELSE
GetDATE$ = "NULL"
END IF
ELSE
GetDATE$ = "NULL"
END IF
ELSE
GetDATE$ = "NULL"
END IF
ELSE
GetDATE$ = "NULL"
END IF
EXIT FUNCTION
CASE CHR$(8) 'Backspace
IF i > 1 THEN
IF i < 9 THEN LINE (xBOX(i), 193)-(xBOX(i) + 6, 202), 15, BF
i = i - 1
LINE (xBOX(i), 193)-(xBOX(i) + 6, 202), 15, BF
D$ = MID$(D$, 1, LEN(D$) - 1)
END IF
END SELECT

IF TIMER > StartTIME! + Interval! THEN
StartTIME! = TIMER
IF Colr = 15 THEN Colr = 7 ELSE Colr = 15
END IF

LOOP

END FUNCTION

SUB Graphics
DEF SEG = VARSEG(Box(0))
BLOAD "brsheads.bsv", VARPTR(Box(0))
DEF SEG
PUT (78, 32), Box
PUT (20, 440), Box(7000)
PUT (10, 6), Box(10000)
PUT (500, 6), Box(11200)

PrintSTRING 196, 420, "DATE: " + DATE2$
PrintSTRING 342, 420, "TIME: " + TIME$
PrintSTRING 12, 460, "Press [B] to enter a new birth date"
PrintSTRING 270, 460, "Press [T] to enter a target date"
PrintSTRING 520, 460, "Press [ESC] to QUIT"

ChartGFX

DEF SEG = VARSEG(Box(0))
BLOAD "brsinpt.bsv", VARPTR(Box(0))
DEF SEG

END SUB

SUB PrintSTRING (x, y, Prnt$)

FOR i = 1 TO LEN(Prnt$)
Char$ = MID$(Prnt$, i, 1)
IF Char$ = " " THEN
x = x + FontBOX(1)
ELSE
Index = (ASC(Char$) - 33) * FontBOX(0) + 2
PUT (x, y), FontBOX(Index)
x = x + FontBOX(Index)
END IF
NEXT i

END SUB

SUB PutNUMS (x, Num)
PUT (x, 191), NumBOX(Num * 30)
END SUB
