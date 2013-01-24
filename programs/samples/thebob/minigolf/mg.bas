CHDIR ".\samples\thebob\minigolf"

'*****************************************************************************
'
'                            M I N I - G O L F
'
'               Freeware - Copyright (C) 2004 by Bob Seguin
'
'                       Email: BOBSEG@sympatico.ca
'
'*****************************************************************************

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

DECLARE SUB Interval (Length!)

DECLARE SUB SetSCREEN ()
DECLARE SUB Digital ()
DECLARE SUB PrintSTRING (x, y, Prnt$)
DECLARE SUB SetLEVEL (x, y)
DECLARE SUB SetPALETTE (OnOFF)
DECLARE SUB PutPUTTER (x, y, Angle)
DECLARE SUB ControlBOX ()
DECLARE SUB PlayGAME ()
DECLARE SUB Traps ()
DECLARE SUB Train ()
DECLARE SUB Bridge ()
DECLARE SUB Roulette (BallSLOT, Advance, OutCOME)
DECLARE SUB Instructions ()
DECLARE SUB ScoreCARD ()
DECLARE SUB EndGAME ()
DECLARE SUB ExitGAME ()
DECLARE SUB TopFIVE ()

CONST Degree! = 3.14159 / 180
OPTION BASE 1

DIM SHARED MouseDATA$
DIM SHARED LB, RB
DIM SHARED MapX!, MapY!, IncX!, IncY!
DIM SHARED BallX, BallY, ShiftX, ShiftY
DIM SHARED Drop, CupX, CupY, Count&
DIM SHARED Strokes, Level, Direction, GamePLAYED
DIM SHARED CharBOX(22)
DIM SHARED CheckCHAR AS STRING

Level = 1
CheckCHAR = "ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz1234567890.,?'!&()-_" + CHR$(34)

REDIM SHARED PuttBOX(32000)
REDIM SHARED MapBOX(1, 1)
REDIM SHARED FlagBOX(1)
REDIM SHARED SBox(850)
REDIM SHARED Box(1)
REDIM SHARED FontBOX(0 TO 1)
REDIM SHARED LilBOX(1)
REDIM SHARED LilBOX2(1)
REDIM SHARED TraxBOX(36)

DIM SHARED ScoreBOX(9, 2)
DIM SHARED SliderBOX(1325)
DIM SHARED DigitBOX(400)
DIM SHARED BallBOX(850)
DIM SHARED PutterBOX(300)

TYPE ScoreTYPE
PlayerNAME AS STRING * 20
PlayDATE AS STRING * 10
PlayerSCORE AS INTEGER
PlayerPAR AS INTEGER
PlayerSTATUS AS INTEGER
END TYPE
DIM SHARED ScoreDATA(6) AS ScoreTYPE
 
OPEN "mg.top" FOR APPEND AS #1: CLOSE #1

OPEN "mg.top" FOR INPUT AS #1
DO WHILE NOT EOF(1)
    Element = Element + 1
    INPUT #1, ScoreDATA(Element).PlayerNAME
    INPUT #1, ScoreDATA(Element).PlayDATE
    INPUT #1, ScoreDATA(Element).PlayerSCORE
    INPUT #1, ScoreDATA(Element).PlayerPAR
    INPUT #1, ScoreDATA(Element).PlayerSTATUS
LOOP
CLOSE #1

'Create and load MouseDATA$ for CALL ABSOLUTE routines
MouseDATA:
DATA 55,89,E5,8B,5E,0C,8B,07,50,8B,5E,0A,8B,07,50,8B,5E,08,8B
DATA 0F,8B,5E,06,8B,17,5B,58,1E,07,CD,33,53,8B,5E,0C,89,07,58
DATA 8B,5E,0A,89,07,8B,5E,08,89,0F,8B,5E,06,89,17,5D,CA,08,00
MouseDATA$ = SPACE$(57)
RESTORE MouseDATA
FOR i = 1 TO 57
    READ h$
    Hexxer$ = CHR$(VAL("&H" + h$))
    MID$(MouseDATA$, i, 1) = Hexxer$
NEXT i

Moused = InitMOUSE
IF NOT Moused THEN
    PRINT "Sorry, cat must have got the mouse."
    Interval 2
    SYSTEM
END IF

ParDATA:
DATA 2, 3, 4, 4, 4, 2, 3, 3, 3

SCREEN 12
 
SetSCREEN

DO
    PlayGAME
LOOP

SYSTEM

PaletteDATA:
DATA 0,0,12,   0,10,30,   4,11,1,   21,21,63
DATA 63,0,0,   42,0,42,   32,15,0,  63,16,0
DATA 0,63,21,  50,27,18,  5,13,1,   28,28,32
DATA 36,36,40, 44,44,48,  52,52,56, 63,63,63

SUB Bridge
STATIC Index, StartTIME#
SHARED BridgeNUM, StartBRIDGE

IF StartBRIDGE = 0 THEN
    Index = 261
    PUT (244, 231), SBox(Index), PSET
    PLAY "MBT255L64O6g"
    StartBRIDGE = 1
    BridgeNUM = 1
    StartTIME# = TIMER
END IF

IF TIMER > StartTIME# + 1.2 THEN
    Index = Index + 140
    IF Index = 821 THEN Index = 261
    PLAY "MBT255L64O6g"
    PUT (244, 231), SBox(Index), PSET
    BridgeNUM = BridgeNUM + 1
    IF BridgeNUM = 5 THEN BridgeNUM = 1
    StartTIME# = TIMER
END IF

END SUB

SUB ClearMOUSE

WHILE LB OR RB
    MouseSTATUS LB, RB, MouseX, MouseY
WEND

END SUB

SUB ControlBOX
STATIC SliderY1, SliderY2, Rotation, Force
SHARED SlowTRAIN, Putted, MapXD, MapYD, LowerLEVEL
SlowTRAIN = 0: Putted = 0
 
''FieldMOUSE 0, 0, 639, 479
 
GET (BallX - 13, BallY - 13)-(BallX + 13, BallY + 13), PutterBOX()
PUT (BallX - 5, BallY - 5), BallBOX(201), AND
PUT (BallX - 5, BallY - 5), BallBOX(), XOR

ShowMOUSE
IF Force = 0 THEN Force = 15
Rotate = 1

DO
    a$ = INKEY$
    IF a$ = CHR$(27) THEN SYSTEM
    MouseSTATUS LB, RB, MouseX, MouseY
    SELECT CASE MouseY
        CASE 166 TO 201 'Putt button
            IF MouseX > 527 AND MouseX < 603 THEN
                IF LB = -1 THEN
                    PUT (BallX - 13, BallY - 13), PutterBOX(), PSET
                    IF Level <> 6 THEN
                        HideMOUSE
                        LINE (531, 169)-(600, 199), 0, B
                        LINE (531, 199)-(600, 199), 15
                        LINE (600, 168)-(600, 199), 15
                        ShowMOUSE
                        Interval .1
                        HideMOUSE
                        LINE (530, 168)-(600, 199), 13, B
                        LINE (531, 169)-(598, 169), 3
                        LINE (531, 169)-(531, 197), 3
                        ShowMOUSE
                        ClearMOUSE
                    END IF
                    Opp! = COS(Rotation * Degree!)
                    Adj! = SIN(Rotation * Degree!)
                    IncX! = (Opp! * Force) / 100 * -1
                    IncY! = (Adj! * Force) / 100
                    Putted = 1
                    ''FieldMOUSE 478, 0, 639, 479
                    EXIT SUB
                END IF
            END IF
        CASE 249 TO 323 'Sliders
            SELECT CASE MouseX
                CASE 535 TO 557
                    IF LB = -1 THEN
                        ''FieldMOUSE 535, 250, 557, 323
                        IF Level = 6 THEN SlowTRAIN = 0
                        WHILE LB = -1
                            IF Level <> 6 THEN WAIT &H3DA, 8
                            GOSUB PutSLIDER1
                            IF Level = 7 THEN Bridge
                        WEND
                        SlowTRAIN = 1
                        ''FieldMOUSE 0, 0, 639, 479
                        Rotate = 0
                    END IF
                CASE 573 TO 595
                    IF LB = -1 THEN
                        ''FieldMOUSE 573, 250, 595, 323
                        SlowTRAIN = 0
                        Rotate = 0
                        WHILE LB = -1
                            IF Level = 6 THEN Train
                            IF Level = 7 THEN Bridge
                            IF Level <> 6 THEN WAIT &H3DA, 8
                            GOSUB PutSLIDER2
                            IF Level = 6 THEN Train
                        WEND
                        SlowTRAIN = 1
                        ''FieldMOUSE 0, 0, 639, 479
                    END IF
            END SELECT
        CASE 368 TO 380 'Instructions
            IF MouseX > 531 AND MouseX < 599 THEN
                IF MenuNUM <> 2 THEN
                    GOSUB CloseMENU
                    MenuY = 368
                    MI = 721
                    GOSUB OpenMENU
                    MenuNUM = 2
                END IF
                IF LB = -1 THEN
                    ERASE MapBOX
                    REDIM PuttBOX(32000)
                    Instructions
                    ERASE PuttBOX
                    IF Level = 5 AND LowerLEVEL = 1 THEN
                        REDIM MapBOX(1 TO 188, 1 TO 140)
                        DEF SEG = VARSEG(MapBOX(1, 1))
                        BLOAD "mglev5b.map", VARPTR(MapBOX(1, 1))
                        DEF SEG
                    ELSE
                        REDIM MapBOX(MapXD, MapYD)
                        FileNAME$ = "mglevel" + LTRIM$(STR$(Level)) + ".map"
                        DEF SEG = VARSEG(MapBOX(1, 1))
                        BLOAD FileNAME$, VARPTR(MapBOX(1, 1))
                        DEF SEG
                    END IF
                END IF
            END IF
        CASE 398 TO 414 'EXIT
            IF MouseX > 541 AND MouseX < 588 THEN
                IF LB THEN
                    HideMOUSE
                    LINE (542, 398)-(587, 414), 11, B
                    LINE (542, 414)-(587, 414), 15
                    LINE (587, 398)-(587, 414), 15
                    ShowMOUSE
                    Interval .1
                    HideMOUSE
                    LINE (542, 398)-(587, 414), 15, B
                    LINE (542, 414)-(587, 414), 11
                    LINE (587, 398)-(587, 414), 11
                    ShowMOUSE
                    Interval .1
                    ExitGAME
                END IF
            END IF
        CASE ELSE
            GOSUB CloseMENU
    END SELECT

    IF Rotate = 1 THEN
        PUT (BallX - 13, BallY - 13), PutterBOX(), PSET
        IF Level = 4 THEN
            Traps
            IF MapBOX(MapX!, MapY!) < 0 THEN
                GET (BallX - 13, BallY - 13)-(BallX + 13, BallY + 13), PutterBOX()
            END IF
        END IF
        Angler = Angler + 5
        IF Angler = 360 THEN Angler = 0
        PutPUTTER BallX, BallY, Angler
        WAIT &H3DA, 8
        WAIT &H3DA, 8, 8
    END IF
 
    IF Level = 4 AND Rotate = 0 THEN Traps
    IF Level = 6 THEN Train
    IF Level = 7 THEN Bridge

    IF LB = -1 AND MenuNUM THEN
        ClearMOUSE
    END IF
    IF Level = 7 THEN Bridge
LOOP
 
EXIT SUB

OpenMENU:
HideMOUSE
GET (532, MenuY)-(598, MenuY + 13), SliderBOX(981)
PUT (532, MenuY), SliderBOX(MI), PSET
ShowMOUSE
RETURN

CloseMENU:
IF MenuNUM THEN
    HideMOUSE
    PUT (532, MenuY), SliderBOX(981), PSET
    ShowMOUSE
    MenuNUM = 0
END IF
RETURN

PutSLIDER1:
IF SliderBOX(131) THEN
    HideMOUSE
    PUT (535, SliderY1), SliderBOX(131), PSET
    ShowMOUSE
ELSE
    HideMOUSE
    PUT (535, 316), SliderBOX(65), PSET
    ShowMOUSE
END IF
SliderY1 = MouseY - 5
HideMOUSE
GET (535, SliderY1)-(557, SliderY1 + 9), SliderBOX(131)
PUT (535, SliderY1), SliderBOX(), PSET
ShowMOUSE
Force = 317 - SliderY1
IF Force < 0 THEN Force = 0
IF Force > 72 THEN Force = 72
Force = Force + 15
RETURN

PutSLIDER2:
IF SliderBOX(1251) THEN
    HideMOUSE
    PUT (573, SliderY2), SliderBOX(1251), PSET
    ShowMOUSE
ELSE
    HideMOUSE
    PUT (573, 316), SliderBOX(65), PSET
    ShowMOUSE
END IF
SliderY2 = MouseY - 5
HideMOUSE
GET (573, SliderY2)-(595, SliderY2 + 9), SliderBOX(1251)
PUT (573, SliderY2), SliderBOX(), PSET
ShowMOUSE

Angle = 317 - SliderY2
IF Angle < 0 THEN Angle = 0
IF Angle > 72 THEN Angle = 72
Rotation = Angle * 5 - 90
HideMOUSE
PUT (BallX - 13, BallY - 13), PutterBOX(), PSET
GET (BallX - 13, BallY - 13)-(BallX + 13, BallY + 13), PutterBOX()
PutPUTTER BallX, BallY, Rotation
ShowMOUSE
WAIT &H3DA, 8
WAIT &H3DA, 8, 8
WAIT &H3DA, 8
WAIT &H3DA, 8, 8
RETURN

END SUB

SUB Digital

x = 558: y = 139
Num$ = LTRIM$(STR$(Strokes))
IF LEN(Num$) = 1 THEN Num$ = "0" + Num$
FOR Digit = 1 TO LEN(Num$)
    Digit$ = MID$(Num$, Digit, 1)
    DigitINDEX = VAL(Digit$) * 40 + 1
    PUT (x, y), DigitBOX(DigitINDEX), PSET
    x = x + DigitBOX(DigitINDEX)
NEXT Digit

END SUB

SUB EndGAME

HideMOUSE
BEEP
OPEN "mgover.dat" FOR INPUT AS #1
FOR x = 0 TO 257
    FOR y = 0 TO 60
        INPUT #1, Colr
        IF Colr THEN PSET (x + 140, y + 230), Colr
    NEXT y
NEXT x
CLOSE #1
DO: LOOP UNTIL INKEY$ = ""
Interval 1.4

REDIM PuttBOX(16000)
DEF SEG = VARSEG(PuttBOX(1))
BLOAD "mgfinal1.bsv", VARPTR(PuttBOX(1))
DEF SEG
PUT (110, 159), PuttBOX(), PSET
ScoreCARD
a$ = INPUT$(1)
IF a$ = CHR$(27) THEN SYSTEM
REDIM FontBOX(0 TO 5171)
DEF SEG = VARSEG(FontBOX(0))
BLOAD "mg.fbs", VARPTR(FontBOX(0))
DEF SEG

IF 1000 - Strokes > ScoreDATA(5).PlayerSTATUS THEN
    IF 1000 - Strokes > ScoreDATA(1).PlayerSTATUS THEN
        DEF SEG = VARSEG(PuttBOX(1))
        BLOAD "mgfinal5.bsv", VARPTR(PuttBOX(1))
        DEF SEG
    ELSE
        DEF SEG = VARSEG(PuttBOX(1))
        BLOAD "mgfinal2.bsv", VARPTR(PuttBOX(1))
        DEF SEG
    END IF
    PUT (110, 159), PuttBOX(), PSET
    GOSUB GetNAME
    IF LEN(ScoreDATA(6).PlayerNAME) THEN
        FOR a = 1 TO 6
            FOR B = a TO 6
                IF ScoreDATA(B).PlayerSTATUS > ScoreDATA(a).PlayerSTATUS THEN SWAP ScoreDATA(B), ScoreDATA(a)
            NEXT B
        NEXT a
        OPEN "mg.top" FOR OUTPUT AS #1
        FOR n = 1 TO 5
            WRITE #1, ScoreDATA(n).PlayerNAME, ScoreDATA(n).PlayDATE, ScoreDATA(n).PlayerSCORE, ScoreDATA(n).PlayerPAR, ScoreDATA(n).PlayerSTATUS
        NEXT n
        CLOSE #1
    END IF
END IF
DO: LOOP UNTIL INKEY$ = ""
TopFIVE
ERASE FontBOX
a$ = INPUT$(1)
IF a$ = CHR$(27) THEN SYSTEM
x1 = 268: x2 = 268
y1 = 100: y2 = 100

'Erase previous level graphic
FOR n = 0 TO 248
    IF x2 + n > 470 THEN y2 = 110
    LINE (x1 - n, y1)-(x1 - n, 460), 0
    LINE (x2 + n, y2)-(x2 + n, 460), 0
NEXT n
DEF SEG = VARSEG(PuttBOX(1))
BLOAD "mgfinal4.bsv", VARPTR(PuttBOX(1))
DEF SEG
PUT (80, 190), PuttBOX(), PSET

GamePLAYED = 1

a$ = INPUT$(1)
IF a$ = CHR$(13) THEN
    Level = 1
    Count& = 0
    EXIT SUB
ELSEIF a$ = CHR$(27) THEN
    SYSTEM
ELSE
    ExitGAME
END IF

EXIT SUB

GetNAME:
x = 170
LINE (x, 298)-(x + 5, 298), 12, B
DO
    DO
        k$ = INKEY$
    LOOP UNTIL k$ <> ""
    SELECT CASE k$
        CASE CHR$(8) 'Backspace
            IF CharX THEN
                LINE (x, 298)-(x + 5, 298), 14, BF
                LINE (CharBOX(CharX), 286)-(x, 298), 14, BF
                Name$ = LEFT$(Name$, LEN(Name$) - 1)
                x = CharBOX(CharX)
                LINE (x, 298)-(x + 5, 298), 12, B
                CharX = CharX - 1
            END IF
        CASE CHR$(13) 'Enter
            Name$ = LTRIM$(Name$)
            IF LEN(Name$) THEN
                LINE (x, 298)-(x + 5, 298), 14, BF
                ScoreDATA(6).PlayerNAME = Name$
                ScoreDATA(6).PlayDATE = DATE$
                ScoreDATA(6).PlayerSCORE = Strokes
                ScoreDATA(6).PlayerPAR = Strokes - 28
                ScoreDATA(6).PlayerSTATUS = 1000 - Strokes
            ELSE
                ScoreDATA(6).PlayerSTATUS = 0
            END IF
            Name$ = ""
            CharX = 0
            ERASE CharBOX
            EXIT DO
        CASE CHR$(27)
            SYSTEM
        CASE ELSE
            IF INSTR(CheckCHAR, k$) THEN
                IF LEN(Name$) < 20 THEN
                    Name$ = Name$ + k$
                    LINE (x, 298)-(x + 5, 298), 14, BF
                    CharX = CharX + 1
                    CharBOX(CharX) = x
                    PrintSTRING x, 286, k$
                    LINE (x, 298)-(x + 5, 298), 12, B
                END IF
            END IF
    END SELECT
LOOP
RETURN

END SUB

SUB ExitGAME

SetPALETTE 0
HideMOUSE
CLS
ERASE MapBOX
REDIM PuttBOX(16000)
DEF SEG = VARSEG(PuttBOX(1))
IF ScoreBOX(1, 2) = 0 AND GamePLAYED = 0 THEN
    BLOAD "mgsplsh1.bsv", VARPTR(PuttBOX(1))
    PUT (154, 140), PuttBOX(1), PSET
    DEF SEG
    SetPALETTE 1
ELSE
    BLOAD "mgsplsh2.bsv", VARPTR(PuttBOX(1))
    DEF SEG
    PUT (154, 140), PuttBOX(1), PSET
    SetPALETTE 1
    OPEN "mgthanks.dat" FOR INPUT AS #1
    FOR x = 0 TO 210
        FOR y = 0 TO 38
            INPUT #1, Colr
            IF Colr THEN PSET (x + 208, y + 248), 8
        NEXT y
        IF x MOD 5 = 0 THEN WAIT &H3DA, 8
    NEXT x
    CLOSE #1
END IF
SLEEP 1
SYSTEM

END SUB

SUB FieldMOUSE (x1, y1, x2, y2)

MouseDRIVER 7, 0, x1, x2
MouseDRIVER 8, 0, y1, y2

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

SUB Instructions

ClearMOUSE
HideMOUSE
GET (110, 159)-(439, 347), PuttBOX()
DEF SEG = VARSEG(PuttBOX(1))
BLOAD "mghelp1.bsv", VARPTR(PuttBOX(16100))
DEF SEG
PUT (110, 159), PuttBOX(16100), PSET
ShowMOUSE

DO
    a$ = INKEY$
    IF a$ = CHR$(27) THEN SYSTEM
    MouseSTATUS LB, RB, MouseX, MouseY
    IF MouseX > 379 AND MouseX < 421 THEN
        IF MouseY > 177 AND MouseY < 199 THEN
            IF CloseMENU = 0 THEN GOSUB OpenCLOSE
        ELSE
            GOSUB CloseCLOSE
        END IF
    ELSE
        GOSUB CloseCLOSE
    END IF
    IF CloseMENU AND LB = -1 THEN
        IF HelpCOUNT = 0 THEN
            ClearMOUSE
            HelpCOUNT = 1
            DEF SEG = VARSEG(PuttBOX(1))
            BLOAD "mghelp2.bsv", VARPTR(PuttBOX(16100))
            DEF SEG
            HideMOUSE
            PUT (110, 159), PuttBOX(16100), PSET
            ShowMOUSE
            CloseMENU = 0
        ELSE
            EXIT DO
        END IF
    END IF
LOOP

HideMOUSE
PUT (110, 159), PuttBOX(), PSET
ShowMOUSE
ClearMOUSE

EXIT SUB

OpenCLOSE:
HideMOUSE
FOR x = 380 TO 416
    FOR y = 182 TO 194
        IF POINT(x, y) = 1 THEN PSET (x, y), 8
    NEXT y
NEXT x
ShowMOUSE
CloseMENU = 1
RETURN

CloseCLOSE:
IF CloseMENU = 1 THEN
    HideMOUSE
    FOR x = 380 TO 416
        FOR y = 182 TO 194
            IF POINT(x, y) = 8 THEN PSET (x, y), 1
        NEXT y
    NEXT x
    ShowMOUSE
    CloseMENU = 0
END IF
RETURN

END SUB

DEFSNG A-Z
SUB Interval (Length!)

OldTimer# = TIMER
DO
    a$ = INKEY$
    IF a$ = CHR$(27) THEN SYSTEM
LOOP UNTIL TIMER > OldTimer# + Length!
WAIT &H3DA, 8

END SUB

DEFINT A-Z
SUB LocateMOUSE (x, y)

LB = 4
MX = x
MY = y
MouseDRIVER LB, 0, MX, MY

END SUB

SUB MouseDRIVER (LB, RB, MX, MY)

DEF SEG = VARSEG(MouseDATA$)
Mouse = SADD(MouseDATA$)
CALL ABSOLUTE(LB, RB, MX, MY, Mouse)

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

SUB PlayGAME
SHARED BoxCAR, BallIN, StopTRAIN, BridgeNUM, StartBRIDGE, LowerLEVEL

SELECT CASE Level
    CASE 1
        Strokes = 0
        Digital
        RESTORE ParDATA
        FOR n = 1 TO 9
            READ ScoreBOX(n, 1)
            ScoreBOX(n, 2) = 0
        NEXT n
        SetLEVEL 81, 101
        IF GamePLAYED THEN SHELL "MGTheme"
    CASE 2
        SetLEVEL 70, 121
    CASE 3
        SetLEVEL 53, 117
    CASE 4
        SetLEVEL 40, 140
    CASE 5
        LowerLEVEL = 0
        SetLEVEL 40, 112
    CASE 6
        BoxCAR = 0: BallIN = 0: StopTRAIN = 0: Direction = 0
        SetLEVEL 60, 116
    CASE 7
        BridgeNUM = 0: StartBRIDGE = 0
        SetLEVEL 60, 116
    CASE 8
        SetLEVEL 70, 110
    CASE 9
        SetLEVEL 109, 105
END SELECT

BallX = MapX! * 2 + ShiftX
BallY = MapY! * 2 + ShiftY
GET (BallX - 5, BallY - 5)-(BallX + 5, BallY + 5), BallBOX(450)
PUT (BallX - 5, BallY - 5), BallBOX(201), AND
PUT (BallX - 5, BallY - 5), BallBOX(), XOR
 
DO
    ControlBOX
    Strokes = Strokes + 1
    ScoreBOX(Level, 2) = ScoreBOX(Level, 2) + 1
    Digital
    PUT (BallX - 5, BallY - 5), BallBOX(450), PSET
    PLAY "MBT220L64O3C"
 
    DO
        SELECT CASE MapBOX(MapX!, MapY!)
            CASE 0
                Bounce = 0
                Cup = 0
                MapX! = LocX!: MapY! = LocY!
            CASE -1, 1, 1000
                SELECT CASE Level
                    CASE 2
                        IF MapBOX(MapX!, MapY!) = 1 THEN
                            FOR Index = 261 TO 456 STEP 65
                                PUT (246, 231), SBox(Index), PSET
                                WAIT &H3DA, 8
                                WAIT &H3DA, 8, 8
                                WAIT &H3DA, 8
                                WAIT &H3DA, 8, 8
                            NEXT Index
                        END IF
                        PLAY "MFT255O2L64cp16<bp16ap16g"
                        GOSUB ResetBALL
                    CASE 4
                        IF Drop = 1 THEN
                            Sy = 158: Sy2 = 175
                            SI = 461
                            GOSUB DropBALL
                            MapX! = 117
                            MapY! = 19
                            IncX! = ABS(IncX!)
                            IncY! = 0
                        END IF
                    CASE 5
                        GET (168, 267)-(182, 281), SBox(456)
                        PUT (168, 267), SBox(391), AND
                        PUT (168, 267), SBox(261), XOR
                        Interval 0
                        PUT (168, 267), SBox(456), PSET
                        PUT (168, 267), SBox(391), AND
                        PUT (168, 267), SBox(326), XOR
                        Interval 0
                        PUT (168, 267), SBox(456), PSET
                        GOSUB ResetBALL
                        EXIT DO
                    CASE 6
                        IF BoxCAR THEN
                            BallIN = 1
                            SlowTRAIN = 1
                            PLAY "MBMST255O4L64b"
                            DO
                                Train
                                WAIT &H3DA, 8
                                WAIT &H3DA, 8, 8
                            LOOP WHILE BallIN
                            x = 195
                            PLAY "MBMST255L64O6b"
                            DO
                                GET (x - 5, 280)-(x + 5, 290), BallBOX(450)
                                PUT (x - 5, 280), BallBOX(201), AND
                                PUT (x - 5, 280), BallBOX(), XOR
                                WAIT &H3DA, 8
                                PUT (x - 5, 280), BallBOX(450), PSET
                                StopTRAIN = 1
                                Train
                                x = x - 1
                            LOOP UNTIL x = 90
                            Count2 = 2
                            Cup = 1
                        ELSE
                            PLAY "MBMST255L64O2C"
                            IncX! = IncX! * -1
                        END IF
                    CASE 9 'map value 1
                        IF MapY! > 84 THEN 'bottom half
                            IF MapX! < 61 THEN
                                'left side
                                StartDEGREES = 331
                                Advance = 37
                            ELSE
                                'right side
                                StartDEGREES = 31
                                Advance = 34
                            END IF
                        ELSE 'top half
                            IF MapX! < 61 THEN
                                'left side
                                StartDEGREES = 171
                                Advance = 45
                            ELSE
                                'right side
                                StartDEGREES = 111
                                Advance = 48
                            END IF
                        END IF
                        Roulette StartDEGREES, Advance, 4
                END SELECT
            CASE -2, 2, 20
                Bounce = 0
                CupSOUND = 0
                Cup = 0
                LocX! = MapX!: LocY! = MapY!
            CASE -3, 3 'left well
                SELECT CASE Level
                    CASE 4
                        IF Drop = 2 THEN
                            Sy = 188: Sy2 = 205
                            SI = 571
                            GOSUB DropBALL
                            MapX! = 117
                            MapY! = 34
                            IncX! = ABS(IncX!)
                            IncY! = 0
                        END IF
                    CASE 5
                        PLAY "MBMST255L64O3gP32eP32cO2CP32CP32>"
                        GET (138, 297)-(152, 311), SBox(456)
                        PUT (138, 297), SBox(391), AND
                        PUT (138, 297), SBox(261), XOR
                        Interval 0
                        PUT (138, 297), SBox(391), AND
                        PUT (138, 297), SBox(326), XOR
                        Interval 0
                        PUT (138, 297), SBox(456), PSET
                        Interval .5
                        PLAY "MFCP32CP32CP32CP32<CP32CP32CP32>CP32CP32C"
                        GOSUB NewMAP
                        MapX! = 105: MapY! = 20
                        BumpUP! = ABS(IncX!) + ABS(IncY!)
                        IF BumpUP! < .2 THEN BumpUP! = .2
                        IncX! = .36 * BumpUP!: IncY! = .18 * BumpUP!
                    CASE 9
                        IF MapY! > 84 THEN 'bottom half
                            StartDEGREES = 311
                            Advance = 45
                        ELSE
                            StartDEGREES = 191
                            Advance = 52
                        END IF
                        Roulette StartDEGREES, Advance, 2
                        GOSUB ResetBALL
                END SELECT
            CASE 4, 40
                IF Bounce <> 4 THEN
                    SwapX! = IncX!
                    IncX! = IncY! * -1
                    IncY! = SwapX! * -1
                    PLAY "MBMST255L64O2C"
                    Bounce = 4
                END IF
            CASE -5, 5 'right well
                SELECT CASE Level
                    CASE 4
                        IF Drop = 3 THEN
                            Sy = 218
                            Sy2 = 235
                            SI = 681
                            GOSUB DropBALL
                            MapX! = 117
                            MapY! = 49
                            IncX! = ABS(IncX!)
                            IncY! = 0
                        END IF
                    CASE 5
                        GET (198, 237)-(212, 251), SBox(456)
                        PUT (198, 237), SBox(391), AND
                        PUT (198, 237), SBox(261), XOR
                        Interval 0
                        PUT (198, 237), SBox(391), AND
                        PUT (198, 237), SBox(326), XOR
                        Interval 0
                        PUT (198, 237), SBox(456), PSET
                        PLAY "MBMST255L32O4Cp32bp32<ap32gp32fp32<ep32c"
                        GOSUB NewMAP
                        MapX! = MapX! - 2: MapY! = MapY! + 2
                        IncX! = -.16: IncY! = .16
                    CASE 9 'map value 5
                        IF MapY! > 84 THEN 'bottom half
                            IF MapX! > 59 THEN
                                'right side
                                StartDEGREES = 351
                                Advance = 44
                            ELSE
                                'left side
                                StartDEGREES = 291
                                Advance = 47
                            END IF
                        ELSE
                            IF MapX! > 59 THEN
                                'right side
                                StartDEGREES = 151
                                Advance = 54
                            ELSE 'top half
                                'left side
                                StartDEGREES = 211
                                Advance = 51
                            END IF
                        END IF
                        Roulette StartDEGREES, Advance, 3
                END SELECT
            CASE 6, 60
                IF Bounce <> 6 THEN
                    SwapX! = IncX!
                    IncX! = IncY! * -1
                    IncY! = SwapX! * -1
                    PLAY "MBMST255L64O2C"
                    Bounce = 6
                END IF
            CASE 7, 70
                IF Bounce <> 7 THEN
                    IncY! = ABS(IncY!)
                    PLAY "MBMST255L64O2C"
                    Bounce = 7
                END IF
            CASE 8, 80
                IF Bounce <> 8 THEN
                    SwapX! = IncX!
                    SWAP IncX!, IncY!
                    SWAP IncY!, SwapX!
                    PLAY "MBMST255L64O2C"
                    Bounce = 8
                END IF
            CASE 9, 90
                IF Bounce <> 9 THEN
                    IncY! = -ABS(IncY!)
                    PLAY "MBMST255L64O2C"
                    Bounce = 9
                END IF
            CASE 10, 100
                IF Bounce <> 10 THEN
                    IncX! = -ABS(IncX!)
                    PLAY "MBMST255L64O2C"
                    Bounce = 10
                END IF
            CASE 11, 110
                IF Bounce <> 11 THEN
                    IncX! = ABS(IncX!)
                    PLAY "MBMST255L64O2C"
                    Bounce = 11
                END IF
            CASE 12
                IF (ABS(IncX!) + ABS(IncY!)) < .2 THEN
                    Cup = 1
                ELSE
                    IF CupSOUND = 0 THEN
                        PLAY "MBMST255L64O5C"
                        CupSOUND = 1
                    END IF
                END IF
            CASE 13, 130
                IF Bounce <> 13 THEN
                    SWAP IncX!, IncY!
                    PLAY "MBMST255L64O2C"
                    Bounce = 13
                END IF
            CASE 14
                IF MapY! > 84 THEN 'bottom half
                    StartDEGREES = 11
                    Advance = 43
                ELSE
                    StartDEGREES = 131
                    Advance = 36
                END IF
                Roulette StartDEGREES, Advance, 1
                Cup = 1
            CASE 15 'hole 9 only
                PUT (170, 141), SBox(261), PSET
                PLAY "MfT255O2L64a"
                WAIT &H3DA, 8
                WAIT &H3DA, 8, 8
                PUT (170, 141), SBox(326), PSET
                WAIT &H3DA, 8
                WAIT &H3DA, 8, 8
                PUT (170, 141), SBox(391), PSET
                PLAY "MfT255O3L64c"
                WAIT &H3DA, 8
                WAIT &H3DA, 8, 8
                PUT (170, 141), SBox(456), PSET
                GOSUB ResetBALL
            CASE 30
                SELECT CASE IncX!
                    CASE IS < 0
                        SELECT CASE BridgeNUM
                            CASE 1: IncY! = 0
                            CASE 2: GOSUB SinkBALL
                            CASE 3: PLAY "MBMST255L64O2b": IncX! = IncX! * -1
                            CASE 4: GOSUB Splunk
                        END SELECT
                    CASE IS > 0
                        SELECT CASE BridgeNUM
                            CASE 1: IncY! = 0
                            CASE 2: GOSUB Splunk
                            CASE 3: PLAY "MBMST255L64O2b": IncX! = IncX! * -1
                            CASE 4: GOSUB SinkBALL
                        END SELECT
                END SELECT
        END SELECT
        BallX = MapX! * 2 + ShiftX
        BallY = MapY! * 2 + ShiftY
        Count2 = Count2 + 1
        IF Count2 = 32000 THEN Count2 = 0
        IF Cup = 1 THEN Count2 = Count2 - Count2 MOD 3
        IF Count2 MOD 3 = 0 THEN
            IF Cup = 1 THEN
                PUT (CupX, CupY), BallBOX(201), AND
                PUT (CupX, CupY), BallBOX(), XOR
                PLAY "MBMST255O5L64ap32bp32>c"
                Cup = 0
                Level = Level + 1
                IF Level = 7 THEN StopTRAIN = 0
                Interval 2
                IF Level = 10 THEN
                    ERASE MapBOX
                    EndGAME
                END IF
                EXIT SUB
            END IF
            GET (BallX - 5, BallY - 5)-(BallX + 5, BallY + 5), BallBOX(450)
            IF Level = 4 THEN Traps
            IF MapBOX(MapX!, MapY!) < 20 THEN
                PUT (BallX - 5, BallY - 5), BallBOX(201), AND
                PUT (BallX - 5, BallY - 5), BallBOX(), XOR
                IF Level = 6 THEN Train
                IF Level = 7 THEN Bridge
            END IF
            WAIT &H3DA, 8
            IF Level <> 6 THEN WAIT &H3DA, 8, 8
            PUT (BallX - 5, BallY - 5), BallBOX(450), PSET
            GET (BallX - 5, BallY - 5)-(BallX + 5, BallY + 5), BallBOX(450)
            IncX! = IncX! * .994
            IncY! = IncY! * .994
        END IF
        MapX! = MapX! + IncX!
        MapY! = MapY! + IncY!
    LOOP WHILE (ABS(IncX!) + ABS(IncY!)) > .05

    GET (BallX - 5, BallY - 5)-(BallX + 5, BallY + 5), BallBOX(450)
    IF MapBOX(MapX!, MapY!) < 20 THEN
        PUT (BallX - 5, BallY - 5), BallBOX(201), AND
        PUT (BallX - 5, BallY - 5), BallBOX(), XOR
    ELSE
        GOSUB ResetBALL
        IF Level = 5 THEN
            ERASE MapBOX
            REDIM MapBOX(67, 115)
            DEF SEG = VARSEG(MapBOX(1, 1))
            BLOAD "mglevel5.map", VARPTR(MapBOX(1, 1))
            DEF SEG
        END IF
        GET (BallX - 5, BallY - 5)-(BallX + 5, BallY + 5), BallBOX(450)
        PUT (BallX - 5, BallY - 5), BallBOX(201), AND
        PUT (BallX - 5, BallY - 5), BallBOX(), XOR
    END IF
LOOP
 
IF MapBOX(MapX!, MapY!) < 20 THEN
    PUT (BallX - 5, BallY - 5), BallBOX(201), AND
    PUT (BallX - 5, BallY - 5), BallBOX()
END IF
 
EXIT SUB

DropBALL:
PUT (235, Sy), SBox(), AND
PUT (235, Sy), SBox(221), XOR
WAIT &H3DA, 8
WAIT &H3DA, 8, 8
WAIT &H3DA, 8
WAIT &H3DA, 8, 8
PUT (235, Sy), SBox(), AND
PUT (235, Sy), SBox(331), XOR
WAIT &H3DA, 8
WAIT &H3DA, 8, 8
WAIT &H3DA, 8
WAIT &H3DA, 8, 8
PUT (235, Sy), SBox(SI), PSET
PLAY "MFT220L64O2AP32FP32DP1"
GET (270, Sy2)-(274, Sy2 + 11), SBox(800)
PUT (270, Sy2), SBox(441), PSET
WAIT &H3DA, 8
WAIT &H3DA, 8, 8
WAIT &H3DA, 8
WAIT &H3DA, 8, 8
PUT (270, Sy2), SBox(800), PSET
RETURN

NewMAP:
ERASE MapBOX
REDIM MapBOX(1 TO 188, 1 TO 140)
DEF SEG = VARSEG(MapBOX(1, 1))
BLOAD "mglev5b.map", VARPTR(MapBOX(1, 1))
DEF SEG
ShiftX = 45: ShiftY = 116
MapX! = MapX! + 31: MapY! = MapY! + 26
LowerLEVEL = 1
RETURN

ResetBALL:
SELECT CASE Level
    CASE 2
        ResetX = 119: ResetY = 379
        MapX! = 28: MapY! = 133
        ShiftX = 70: ShiftY = 121
    CASE 5:
        ResetX = 168: ResetY = 381
        MapX! = 34: MapY! = 109.5
        ShiftX = 107: ShiftY = 169
        LowerLEVEL = 0
    CASE 7:
        ResetX = 104: ResetY = 378
        MapX! = 25: MapY! = 83.5
    CASE 8:
        ResetX = 193: ResetY = 371
        MapX! = 27.5: MapY! = 132.5
    CASE 9:
        ResetX = 252: ResetY = 382
        MapX! = 58.5: MapY! = 141.5
END SELECT
IncX! = 0: IncY! = 0
PUT (ResetX, ResetY), SBox(), PSET
PLAY "MBT255L64O6b"
PLAY "MFMST255L64O3gP32eP32cO1CP32CP32"
PLAY "CP32CP32CP32CP32CP32CP32CP32CP32CP32CP32CP32CP32CP32CP32C"
PLAY "CP32CP32CP32CP32CP32CP32CP32CP32CP32"
PLAY "CP32CP32CP32CP32CP32CP32CP32CP32CP32CP32O5BP32>BP32<B"
Interval 0
PUT (ResetX, ResetY), SBox(66), PSET
Interval 0
PUT (ResetX, ResetY), SBox(131), PSET
Interval 0
PLAY "MBT255L64O6b"
PUT (ResetX, ResetY), SBox(196), PSET
BallX = MapX! * 2 + ShiftX
BallY = MapY! * 2 + ShiftY
RETURN

'The following 2 subroutines apply to hole 7 only
SinkBALL: 'Ball to cup
GET (249, 310)-(259, 320), BallBOX(450)
PLAY "MBMST255L64O2b"
StartTIME# = TIMER: DO: LOOP WHILE TIMER < StartTIME# + .2
PLAY "MFT255L64O5CP32<CP32<CP32<CP32<C"
FOR y = 297 TO 408
    GET (249, y)-(259, y + 10), BallBOX(450)
    PUT (249, y), BallBOX(201), AND
    PUT (249, y), BallBOX(), XOR
    WAIT &H3DA, 8
    WAIT &H3DA, 8, 8
    PUT (249, y), BallBOX(450), PSET
NEXT y
Cup = 1
RETURN

Splunk:  'Water hazard
PLAY "MBMST255L64O2b"
Interval .3
PLAY "MBMST255L64O5cP16eP16c<P16gP16>>c"
FOR Index = 851 TO 2251 STEP 200
    WAIT &H3DA, 8
    PUT (242, 195), SBox(Index), PSET
    Interval .02
NEXT Index
GOSUB ResetBALL
RETURN

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

SUB PutPUTTER (x, y, Angle)

Angle2 = Angle - 60
Angle3 = Angle + 60
Adj = COS(Angle * Degree!) * 3
Opp = SIN(Angle * Degree!) * 3
Adj1 = COS(Angle * Degree!) * 4
Opp1 = SIN(Angle * Degree!) * 4
Adj4 = COS(Angle * Degree!) * 5
Opp4 = SIN(Angle * Degree!) * 5
Adj2 = COS(Angle2 * Degree!) * 9
Opp2 = SIN(Angle2 * Degree!) * 9
Adj3 = COS(Angle3 * Degree!) * 9
Opp3 = SIN(Angle3 * Degree!) * 9
PointX = x + Adj
PointY = y - Opp
LeftX = PointX + Adj2
LeftY = PointY - Opp2
RightX = PointX + Adj3
RightY = PointY - Opp3
PointX2 = x + Adj1
PointY2 = y - Opp1
LeftX2 = PointX2 + Adj2
LeftY2 = PointY2 - Opp2
RightX2 = PointX2 + Adj3
RightY2 = PointY2 - Opp3
PointX3 = x + Adj4
PointY3 = y - Opp4
LeftX3 = PointX3 + Adj2
LeftY3 = PointY3 - Opp2
RightX3 = PointX3 + Adj3
RightY3 = PointY3 - Opp3

SELECT CASE Angle
    CASE 90, -90, 270
        LINE (LeftX, RightY)-(RightX, RightY), 12
        LINE (LeftX2, RightY2)-(RightX2, RightY2), 13
        LINE (LeftX3, RightY3)-(RightX3, RightY3), 15
        LINE (LeftX, LeftY)-(LeftX, LeftY3), 15
        LINE (RightX, RightY)-(RightX, RightY3), 15
    CASE 180
        LINE (LeftX, LeftY)-(LeftX, RightY), 12
        LINE (LeftX2, LeftY2)-(LeftX2, RightY2), 13
        LINE (LeftX3, LeftY3)-(LeftX3, RightY3), 15
        LINE (LeftX, LeftY)-(LeftX, LeftY3), 15
        LINE (RightX, RightY)-(LeftX3, RightY3), 15
    CASE ELSE
        LINE (LeftX, LeftY)-(RightX, RightY), 12
        LINE (LeftX2, LeftY2)-(RightX2, RightY2), 13
        LINE (LeftX3, LeftY3)-(RightX3, RightY3), 15
        LINE (LeftX, LeftY)-(LeftX3, LeftY3), 15
        LINE (RightX, RightY)-(RightX3, RightY3), 15
END SELECT

END SUB

SUB Roulette (BallSLOT, Advance, OutCOME)

nn = BallSLOT
FOR Spins = 1 TO Advance
    a$ = INKEY$
    IF a$ = CHR$(27) THEN SYSTEM
    nn = nn + 20
    IF nn = 360 + BallSLOT THEN nn = BallSLOT
    Adj! = 260 + 54 * SIN(Degree! * nn)
    Opp! = 280 + 54 * COS(Degree! * nn)
    PUT (198, 217), SBox(525), PSET

    SpinCOUNT = SpinCOUNT + 1
    IF SpinCOUNT MOD 2 THEN
        PUT (198, 217), SBox(525), PSET
    ELSE
        PUT (198, 217), SBox(4530), PSET
    END IF

    GET (Adj! - 5, Opp! - 5)-(Adj! + 5, Opp! + 5), BallBOX(450)
    PUT (Adj! - 5, Opp! - 5), BallBOX(201), AND
    PUT (Adj! - 5, Opp! - 5), BallBOX()

    IF Spins > Advance * .6 THEN Clicks = 3 ELSE Clicks = 1
    FOR Reps = 1 TO Clicks
        WAIT &H3DA, 8
        WAIT &H3DA, 8, 8
    NEXT Reps

    PLAY "MFT255O6L64a"
    PUT (Adj! - 5, Opp! - 5), BallBOX(450), PSET
NEXT Spins

SELECT CASE OutCOME
    CASE 1
        GOSUB Cuppa
    CASE 2
        GOSUB Sewer
    CASE 3
        MapX! = 74
        MapY! = 55
        IncX! = -.15
        IncY! = -(RND * .5) - .01
    CASE 4:
        MapX! = 55
        MapY! = 122
        IncX! = .05
        IncY! = (RND * .2) + .01
END SELECT

EXIT SUB

Sewer:
x! = 267: y! = 210

DO
    GET (x!, y!)-(x! + 10, y! + 10), BallBOX(450)
    PUT (x!, y!), BallBOX(201), AND
    PUT (x!, y!), BallBOX()
    WAIT &H3DA, 8
    WAIT &H3DA, 8, 8
    PUT (x!, y!), BallBOX(450), PSET
    x! = x! - 1: y! = y! - 1.5
LOOP WHILE y! > 109
PLAY "MBMST255L64O2C"

DO
    GET (x!, y!)-(x! + 10, y! + 10), BallBOX(450)
    PUT (x!, y!), BallBOX(201), AND
    PUT (x!, y!), BallBOX()
    WAIT &H3DA, 8
    WAIT &H3DA, 8, 8
    PUT (x!, y!), BallBOX(450), PSET
    x! = x! - 1: y! = y! + 1.4
LOOP WHILE y! < 142

PUT (170, 141), SBox(261), PSET
PLAY "MfT255O2L64a"
WAIT &H3DA, 8
WAIT &H3DA, 8, 8
PUT (170, 141), SBox(326), PSET
WAIT &H3DA, 8
WAIT &H3DA, 8, 8
PUT (170, 141), SBox(391), PSET
PLAY "MfT255O3L64c"
WAIT &H3DA, 8
WAIT &H3DA, 8, 8
PUT (170, 141), SBox(456), PSET

RETURN

Cuppa:
x! = 282: y! = 216

DO
    GET (x!, y!)-(x! + 10, y! + 10), BallBOX(450)
    PUT (x!, y!), BallBOX(201), AND
    PUT (x!, y!), BallBOX()
    WAIT &H3DA, 8
    WAIT &H3DA, 8, 8
    PUT (x!, y!), BallBOX(450), PSET
    x! = x! - .52: y! = y! - 1.3
LOOP WHILE y! > 109
PLAY "MBMST255L64O2C"

DO
    GET (x!, y!)-(x! + 10, y! + 10), BallBOX(450)
    PUT (x!, y!), BallBOX(201), AND
    PUT (x!, y!), BallBOX()
    WAIT &H3DA, 8
    WAIT &H3DA, 8, 8
    PUT (x!, y!), BallBOX(450), PSET
    x! = x! - .52: y! = y! + 1.3
LOOP WHILE y! < 197
PLAY "MBMST255L64O2C"

SlowY! = .52
SlowX! = 1.3
DO
    GET (x!, y!)-(x! + 10, y! + 10), BallBOX(450)
    PUT (x!, y!), BallBOX(201), AND
    PUT (x!, y!), BallBOX()
    WAIT &H3DA, 8
    WAIT &H3DA, 8, 8
    PUT (x!, y!), BallBOX(450), PSET
    SlowX! = SlowX! * .993
    SlowY! = SlowY! * .993
    x! = x! + SlowX!: y! = y! - SlowY!
LOOP WHILE x! < 334

RETURN

END SUB

SUB ScoreCARD

REDIM NumBOX(1900)
DEF SEG = VARSEG(NumBOX(1))
BLOAD "mgnums.fbs", VARPTR(NumBOX(1))
DEF SEG

FOR y = 204 TO 268 STEP 32
    FOR x = 190 TO 370 STEP 90
        ParCOUNT = ParCOUNT + 1
        NumVAL = ScoreBOX(ParCOUNT, 2) - ScoreBOX(ParCOUNT, 1)
        SELECT CASE NumVAL
            CASE IS < 0
                PUT (x, y), NumBOX(1321)
                x = x + NumBOX(1321)
                GOSUB PrintNUMS
                x = x - NumBOX(1321)
            CASE 0
                PUT (x, y), NumBOX(1441)
            CASE IS > 0
                PUT (x, y), NumBOX(1201)
                x = x + NumBOX(1201)
                GOSUB PrintNUMS
                x = x - NumBOX(1201)
        END SELECT
    NEXT x
NEXT y

x = 290: y = 300
NumVAL = Strokes
GOSUB PrintNUMS
FinalSCORE = Strokes - 28

PUT (331, 297), NumBOX(1641)
IF FinalSCORE < 0 THEN PUT (338, 305), NumBOX(1321)
IF FinalSCORE > 0 THEN PUT (338, 305), NumBOX(1201)
IF FinalSCORE = 0 THEN
    PUT (338, 302), NumBOX(1441)
    PUT (366, 300), NumBOX(1741)
    ERASE NumBOX
    EXIT SUB
END IF

x = 348: y = 300
NumVAL = FinalSCORE
GOSUB PrintNUMS
PUT (xx, 297), NumBOX(1741)

ERASE NumBOX
EXIT SUB

PrintNUMS:
Num$ = LTRIM$(STR$(ABS(NumVAL)))
xx = x
FOR n = 1 TO LEN(Num$)
    Char$ = MID$(Num$, n, 1)
    Index = VAL(Char$) * 120 + 1
    PUT (xx, y), NumBOX(Index)
    xx = xx + NumBOX(Index)
NEXT n
RETURN

END SUB

SUB SetLEVEL (x, y)
STATIC NewGAME
SHARED MapXD, MapYD

x1 = 268: x2 = 268
y1 = 100: y2 = 100

'Erase previous level graphic
HideMOUSE
FOR n = 0 TO 248
    IF x2 + n > 470 THEN y2 = 110
    LINE (x1 - n, y1)-(x1 - n, 460), 0
    LINE (x2 + n, y2)-(x2 + n, 460), 0
NEXT n

ERASE MapBOX

REDIM PuttBOX(32000)
FileNAME$ = "mglevel" + LTRIM$(STR$(Level)) + ".bsv"
DEF SEG = VARSEG(PuttBOX(1))
BLOAD FileNAME$, VARPTR(PuttBOX(1))
DEF SEG
PUT (x, y), PuttBOX(), PSET
ShowMOUSE
ERASE PuttBOX

'PUT level number on flag
REDIM FlagBOX(1 TO 5000)
DEF SEG = VARSEG(FlagBOX(1))
BLOAD "mgfnums.bsv", VARPTR(FlagBOX(1))
DEF SEG
HideMOUSE
PUT (538, 44), FlagBOX(555 * (Level - 1) + 1), PSET
ShowMOUSE
ERASE FlagBOX

IF NewGAME = 0 THEN
    SetPALETTE 1
    NewGAME = 1
END IF
   
SELECT CASE Level
    CASE 1
        MapX! = 134: MapY! = 133
        ShiftX = 91: ShiftY = 111
        CupX = 134: CupY = 154
        REDIM MapBOX(157, 157)
        MapXD = 157: MapYD = 157
    CASE 2
        MapX! = 27.5: MapY! = 132.5
        ShiftX = 70: ShiftY = 121
        CupX = 379: CupY = 141
        DEF SEG = VARSEG(SBox(1))
        BLOAD "mgspec2.bsv", VARPTR(SBox(1))
        DEF SEG
        REDIM MapBOX(182, 146)
        MapXD = 182: MapYD = 146
    CASE 3
        MapX! = 148: MapY! = 118
        ShiftX = 60: ShiftY = 137
        CupX = 142: CupY = 150
        REDIM MapBOX(192, 127)
        MapXD = 192: MapYD = 127
    CASE 4
        MapX! = 50: MapY! = 105
        ShiftX = 42: ShiftY = 141
        CupX = 371: CupY = 360
        REDIM SBox(1330)
        DEF SEG = VARSEG(SBox(1))
        BLOAD "mgspec4.bsv", VARPTR(SBox(1))
        DEF SEG
        REDIM MapBOX(217, 136)
        MapXD = 217: MapYD = 136
    CASE 5
        MapX! = 34: MapY! = 109.5
        ShiftX = 107: ShiftY = 169
        CupX = 399: CupY = 154
        DEF SEG = VARSEG(SBox(1))
        BLOAD "mgspec5.bsv", VARPTR(SBox(1))
        DEF SEG
        REDIM MapBOX(67, 115)
        MapXD = 67: MapYD = 115
    CASE 6
        'MapX! = 59.5: MapY! = 24
        MapX! = 59.5: MapY! = 23.5
        ShiftX = 286: ShiftY = 238
        CupX = 84: CupY = 280
        DEF SEG = VARSEG(TraxBOX(1))
        BLOAD "mgtrack.lin", VARPTR(TraxBOX(1))
        DEF SEG
        REDIM LilBOX(410)
        REDIM LilBOX2(410)
        REDIM MapBOX(69, 47)
        MapXD = 69: MapYD = 47
    CASE 7
        MapX! = 25: MapY! = 83.5
        ShiftX = 61: ShiftY = 218
        CupX = 249: CupY = 409
        REDIM SBox(1 TO 2650)
        DEF SEG = VARSEG(SBox(1))
        BLOAD "mgspec7.bsv", VARPTR(SBox(1))
        DEF SEG
        REDIM MapBOX(192, 90)
        MapXD = 192: MapYD = 90
    CASE 8
        MapX! = 27.5: MapY! = 132.5
        ShiftX = 145: ShiftY = 113
        CupX = 345: CupY = 162
        DEF SEG = VARSEG(SBox(1))
        BLOAD "mgspec5.bsv", VARPTR(SBox(1))
        DEF SEG
        REDIM MapBOX(118, 144)
        MapXD = 118: MapYD = 144
    CASE 9
        MapX! = 58.5: MapY! = 141.5
        ShiftX = 142: ShiftY = 106
        CupX = 338: CupY = 143
        REDIM SBox(1 TO 8600)
        DEF SEG = VARSEG(SBox(1))
        BLOAD "mgspec9.bsv", VARPTR(SBox(1))
        DEF SEG
        REDIM MapBOX(117, 151)
        MapXD = 117: MapYD = 151
END SELECT

FileNAME$ = "mglevel" + LTRIM$(STR$(Level)) + ".map"
DEF SEG = VARSEG(MapBOX(1, 1))
BLOAD FileNAME$, VARPTR(MapBOX(1, 1))
DEF SEG

END SUB

SUB SetPALETTE (OnOFF)

SELECT CASE OnOFF
    CASE 0
        OUT &H3C8, 0
        FOR n = 1 TO 48
            OUT &H3C9, 0
        NEXT n
    CASE 1
        RESTORE PaletteDATA
        OUT &H3C8, 0
        FOR n = 1 TO 48
            READ Intensity
            Intensity = Intensity + 10
            IF Intensity > 63 THEN Intensity = 63
            OUT &H3C9, Intensity
        NEXT n
        OUT &H3C8, 0
        OUT &H3C9, 0
        OUT &H3C9, 0
        OUT &H3C9, 18
        'RESTORE PaletteDATA
        'OUT &H3C8, 0
        'FOR n = 1 TO 48
        'READ Intensity: OUT &H3C9, Intensity
        'NEXT n
END SELECT

END SUB

SUB SetSCREEN

SetPALETTE 0
DEF SEG = VARSEG(PuttBOX(1))
BLOAD "mgsplsh1.bsv", VARPTR(PuttBOX(16100))
DEF SEG
PUT (154, 140), PuttBOX(16100), PSET
SetPALETTE 1
SHELL "MGTheme.EXE"
Interval .75
  
SetPALETTE 0
CLS

'Screen borders
LINE (5, 5)-(634, 474), 2, B
LINE (10, 10)-(629, 469), 2, B

'Load title
DEF SEG = VARSEG(PuttBOX(1))
BLOAD "mgtitle.bsv", VARPTR(PuttBOX(1))
DEF SEG
PUT (20, 20), PuttBOX(), PSET
  
'Load golfball image and mask
DEF SEG = VARSEG(BallBOX(1))
BLOAD "mgball.bsv", VARPTR(BallBOX(1))
DEF SEG

'Load control panel
DEF SEG = VARSEG(PuttBOX(1))
BLOAD "mgctrl2.bsv", VARPTR(PuttBOX(1))
DEF SEG
PUT (438, 27), PuttBOX(), PSET
   
'Load digital numbers
DEF SEG = VARSEG(DigitBOX(1))
BLOAD "mgdigits.bsv", VARPTR(DigitBOX(1))
DEF SEG

Digital
 
'Load control slider images
DEF SEG = VARSEG(SliderBOX(1))
BLOAD "mgctrl.bsv", VARPTR(SliderBOX(1))
DEF SEG
PUT (535, 316), SliderBOX(), PSET
PUT (573, 316), SliderBOX(), PSET

'LocateMOUSE 563, 350

ERASE PuttBOX

END SUB

SUB ShowMOUSE
LB = 1
MouseDRIVER LB, 0, 0, 0
END SUB

SUB TopFIVE
        
DEF SEG = VARSEG(PuttBOX(1))
BLOAD "mgfinal3.bsv", VARPTR(PuttBOX(1))
DEF SEG
PUT (110, 159), PuttBOX(), PSET

TopY = 223
FOR n = 1 TO 5
    IF ScoreDATA(n).PlayerSCORE <> 0 THEN
        PrintSTRING 136, TopY, RTRIM$(ScoreDATA(n).PlayerNAME)
        PrintSTRING 276, TopY, ScoreDATA(n).PlayDATE
        PrintSTRING 354, TopY, LTRIM$(STR$(ScoreDATA(n).PlayerSCORE))
        IF ScoreDATA(n).PlayerPAR = 0 THEN
            PrintSTRING 392, TopY, "Par"
        ELSE
            PrintSTRING 393, TopY, LTRIM$(STR$(ScoreDATA(n).PlayerPAR))
        END IF
    END IF
    TopY = TopY + 19
NEXT n

END SUB

SUB Train
STATIC y, yy, Route, TrackINDEX, Count
STATIC StartINDEX, StopINDEX, TrainX, TrackY, UpDOWN
SHARED SlowTRAIN, Putted, BoxCAR, BallIN, StopTRAIN

SELECT CASE Direction
    CASE 0
        'Load Train"
        DEF SEG = VARSEG(LilBOX(1))
        BLOAD "mgtrupe.lin", VARPTR(LilBOX(1))
        DEF SEG
        DEF SEG = VARSEG(LilBOX2(1))
        BLOAD "mgtrupf.lin", VARPTR(LilBOX2(1))
        DEF SEG
        StartINDEX = 1: StopINDEX = 1
        TrackINDEX = 13: TrackY = 433
        TrainX = 265: UpDOWN = 1
        y = 365: Route = -1
        Direction = 1
    CASE 1
        IF StopTRAIN = 0 THEN
            IF y > 184 THEN yy = y ELSE yy = 184
            IF Count AND StartINDEX < 403 THEN StartINDEX = StartINDEX + 6
            IF yy = 184 THEN Count = 1
            IF SlowTRAIN AND Putted = 0 THEN WAIT &H3DA, 8
            GOSUB PutTRAIN
            IF y > 298 AND StopINDEX < 403 THEN StopINDEX = StopINDEX + 6
            IF y MOD 12 = 0 THEN SOUND 12000, .05
            TrackINDEX = TrackINDEX - 6
            IF TrackINDEX = -5 THEN TrackINDEX = 31
            IF y < 298 THEN PUT (TrainX, TrackY), TraxBOX(TrackINDEX), PSET
            IF y < 126 THEN LINE (TrainX, TrackY)-(TrainX + 14, TrackY), 0
            TrackY = TrackY - 1
            y = y - 1
            IF y > 227 AND y < 246 THEN
                BoxCAR = 1
            ELSE
                BoxCAR = 0
            END IF
            IF y = 115 THEN
                LINE (265, 184)-(279, 185), 0, B
                Count = 0
                Direction = 2
            END IF
        END IF
    CASE 2
        'Load Train"
        DEF SEG = VARSEG(LilBOX(1))
        BLOAD "mgtrdne.lin", VARPTR(LilBOX(1))
        DEF SEG
        DEF SEG = VARSEG(LilBOX2(1))
        BLOAD "mgtrdnf.lin", VARPTR(LilBOX2(1))
        DEF SEG
        StartINDEX = 1: StopINDEX = 1
        TrackINDEX = 13: TrackY = 116
        TrainX = 198: UpDOWN = -1
        y = 184
        Route = 1
        Direction = 3
    CASE 3
        IF y < 365 THEN yy = y ELSE yy = 365
        IF Count AND StartINDEX < 403 THEN StartINDEX = StartINDEX + 6
        IF yy = 365 THEN Count = 1
        IF SlowTRAIN AND Putted = 0 THEN WAIT &H3DA, 8
        GOSUB PutTRAIN
        IF y > 183 AND StopINDEX < 403 THEN StopINDEX = StopINDEX + 6
        IF y MOD 12 = 0 THEN SOUND 12000, .05
        IF y <= 261 AND y > 250 THEN LINE (TrainX, TrackY)-(TrainX + 14, TrackY), 0, B
        IF y > 261 THEN PUT (TrainX, TrackY), TraxBOX(TrackINDEX), PSET
        TrackINDEX = TrackINDEX + 6
        IF TrackINDEX = 37 THEN TrackINDEX = 1
        TrackY = TrackY + 1
        y = y + 1
        IF y = 433 THEN
            PUT (TrainX, TrackY), TraxBOX(TrackINDEX), PSET
            Count = 0
            Direction = 0
        END IF
        IF BallIN AND y > 335 THEN BallIN = 0
END SELECT

EXIT SUB

PutTRAIN:
Index = StartINDEX
FOR Reps = 1 TO 68
    SELECT CASE UpDOWN
        CASE 1
            SELECT CASE BallIN
                CASE 0: PUT (TrainX, yy), LilBOX(Index), PSET
                CASE 1: PUT (TrainX, yy), LilBOX2(Index), PSET
            END SELECT
        CASE -1
            SELECT CASE BallIN
                CASE 0: PUT (TrainX, yy), LilBOX(Index), PSET
                CASE 1: PUT (TrainX, yy), LilBOX2(Index), PSET
            END SELECT
    END SELECT
    IF Index < StopINDEX THEN
        Index = Index + 6
        yy = yy + UpDOWN
    END IF
NEXT Reps
RETURN

END SUB

SUB Traps
STATIC StartTIME#, Trap
SHARED StartTRAPS

IF StartTRAPS = 0 THEN
    PUT (235, 218), SBox(681), PSET
    PLAY "MBT220L64O0CO6B"
    Trap = 1
    StartTIME# = TIMER
    StartTRAPS = 1
END IF

IF TIMER - StartTIME# > 1 THEN GOSUB Trap

EXIT SUB

DropBALL2:
SELECT CASE Drop
    CASE 1
        Sy = 158: Sy2 = 175
        SI = 461
        MapX! = 117
        MapY! = 19
        GET (235, 158)-(252, 175), SBox(851)
    CASE 2
        Sy = 188: Sy2 = 205
        SI = 571
        MapX! = 117
        MapY! = 34
        GET (235, 188)-(252, 205), SBox(851)
    CASE 3
        Sy = 218
        Sy2 = 235
        SI = 681
        MapX! = 117
        MapY! = 49
        GET (235, 218)-(252, 235), SBox(851)
END SELECT
PUT (235, Sy), SBox(), AND
PUT (235, Sy), SBox(221), XOR
WAIT &H3DA, 8
WAIT &H3DA, 8, 8
WAIT &H3DA, 8
WAIT &H3DA, 8, 8
PUT (235, Sy), SBox(), AND
PUT (235, Sy), SBox(331), XOR
WAIT &H3DA, 8
WAIT &H3DA, 8, 8
WAIT &H3DA, 8
WAIT &H3DA, 8, 8
PUT (235, Sy), SBox(SI), PSET
PLAY "MBT220L64O2AP32FP32D"
Interval 1
GET (270, Sy2)-(274, Sy2 + 11), SBox(800)
PUT (270, Sy2), SBox(441), PSET
WAIT &H3DA, 8
WAIT &H3DA, 8, 8
WAIT &H3DA, 8
WAIT &H3DA, 8, 8
PUT (270, Sy2), SBox(800), PSET
IncX! = .25
IncY! = 0
BallX = MapX! * 2 + 42
BallY = MapY! * 2 + 141
GET (313, BallY - 13)-(339, BallY + 13), PutterBOX()
GET (BallX - 5, BallY - 5)-(BallX + 5, BallY + 5), BallBOX(450)
DO
    IF TIMER > StartTIME# + 1 THEN GOSUB Trap
    PUT (BallX - 5, BallY - 5), BallBOX(450), PSET
    MapX! = MapX! + IncX!
    BallX = MapX! * 2 + 42
    BallY = MapY! * 2 + 141
    GET (BallX - 5, BallY - 5)-(BallX + 5, BallY + 5), BallBOX(450)
    PUT (BallX - 5, BallY - 5), BallBOX(201), AND
    PUT (BallX - 5, BallY - 5), BallBOX()
    WAIT &H3DA, 8
    IncX! = IncX! * .994
LOOP WHILE IncX! > .1
PUT (BallX - 13, BallY - 13), PutterBOX(), PSET
PUT (BallX - 5, BallY - 5), BallBOX(201), AND
PUT (BallX - 5, BallY - 5), BallBOX()
GET (BallX - 13, BallY - 13)-(BallX + 13, BallY + 13), PutterBOX()
IncX! = 0
RETURN

Trap:
Count& = Count& + 1
SELECT CASE Count& MOD 3
    CASE 0
        PUT (235, 188), SBox(1111), PSET
        PUT (235, 218), SBox(461), PSET
        Drop = 3
        IF MapBOX(MapX!, MapY!) = -5 THEN GOSUB DropBALL2
    CASE 1
        PUT (235, 218), SBox(1221), PSET
        PUT (235, 158), SBox(571), PSET
        Drop = 1
        IF MapBOX(MapX!, MapY!) = -1 THEN GOSUB DropBALL2
    CASE 2
        PUT (235, 158), SBox(1001), PSET
        PUT (235, 188), SBox(681), PSET
        Drop = 2
        IF MapBOX(MapX!, MapY!) = -3 THEN GOSUB DropBALL2
END SELECT
PLAY "MBT220L64O0CO6B"
StartTIME# = TIMER
PUT (BallX - 5, BallY - 5), BallBOX(201), AND
PUT (BallX - 5, BallY - 5), BallBOX()
RETURN

END SUB

