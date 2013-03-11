CHDIR ".\programs\samples\thebob\kong"

'****************************************************************************'
'____________________________________________________________________________
'____________________________________________________________________________'
'_____²²___²²__²²²²²__²²___²²__²²²²²____________²²___²²___²²²²___²²__²²______'
'_____²²___²²_²²___²²_²²___²²_²²___²²___________²²___²²____²²____²²__²²______'
'_____²²__²²__²²___²²_²²²__²²_²²___²²___________²²²_²²²____²²____²²__²²______'
'_____²²_²²___²²___²²_²²²__²²_²²_______²_²_²_²__²²²_²²²____²²____²²__²²______'
'_____²²²²____²²___²²_²²²²_²²_²²_______²_²_²____²²²²²²²____²²____²²__²²______'
'_____°°°°____°°___°°_°°_°°°°_°°_______°_°___°__°°_°_°°____°°_____°°°°_______'
'_____°°_°°___°°___°°_°°__°°°_°°__°°°___°__°_°__°°_°_°°____°°______°°________'
'_____°°__°°__°°___°°_°°__°°°_°°___°°___________°°_°_°°_°°_°°______°°________'
'_____°°___°°_°°___°°_°°___°°_°°___°°___________°°___°°_°°_°°______°°________'
'_____°°___°°__°°°°°__°°___°°__°°°°°____________°°___°°__°°°______°°°°_______'
'                                                                            '
'----------- Microsoft QBasic originally came bundled with four -------------'
'----------- example programs: a simple money management program ------------'
'----------- called, appropriately, "Money", a utility for removing ---------'
'----------- line numbers from BASIC programs called "RemLine", and ---------'
'----------- two game programs, "Nibbles" and "Gorilla". In the case --------'
'----------- of the second game, I loved the idea of two gorillas -----------'
'----------- throwing exploding bananas at each other from the roof- --------'
'----------- tops and had always wanted to do my own version. Here ----------'
'----------- then, is my homage to the QBasic classic, GORILLA.BAS... -------'
'
'-------------------- ...KING-KONG vs MIGHTY JOE YOUNG ----------------------'
'------- (Freeware)--Unique elements Copyright (C) 2005 by Bob Seguin -------'
'------------------------ email: BOBSEG@sympatico.ca ------------------------'
'
'************** NOTE: Mouse routines will not work with QB7.1 ***************'

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

DECLARE FUNCTION ControlPANEL ()
DECLARE FUNCTION Computer ()
DECLARE FUNCTION BananaTOSS ()

DECLARE SUB SetPALETTE ()
DECLARE SUB DrawSCREEN ()
DECLARE SUB StartUP ()
DECLARE SUB DoAPES ()
DECLARE SUB PlayGAME ()
DECLARE SUB TopMENU (InOUT)
DECLARE SUB Instructions ()
DECLARE SUB Sliders (Value, Slider)
DECLARE SUB EndGAME ()
DECLARE SUB Interval (Duration!)
DECLARE SUB Fade (InOUT)
DECLARE SUB SetWIND ()
DECLARE SUB Explode (What)
DECLARE SUB ApeCHUCKLE (Which)
DECLARE SUB PrintSCORE (Ape, Score)

CONST Degree! = 3.14159 / 180
CONST g# = 9.8

REDIM SHARED Box(1 TO 26000)
REDIM SHARED KongBOX(1 TO 5500)
REDIM SHARED YoungBOX(1 TO 5500)
DIM SHARED ExplosionBACK(1200)
DIM SHARED SliderBOX(1 TO 440)
DIM SHARED Banana(1 TO 900)
DIM SHARED FadeBOX(1 TO 48)
DIM SHARED LilBOX(1 TO 120)
DIM SHARED Buildings(1 TO 8, 1 TO 2)
DIM SHARED NumBOX(1 TO 300)

DEF SEG = VARSEG(NumBOX(1))
BLOAD "kongnums.bsv", VARPTR(NumBOX(1))
DEF SEG = VARSEG(LilBOX(1))
BLOAD "kongwind.bsv", VARPTR(LilBOX(1))
DEF SEG = VARSEG(Banana(1))
BLOAD "kongbnna.bsv", VARPTR(Banana(1))
DEF SEG = VARSEG(SliderBOX(1))
BLOAD "kongsldr.bsv", VARPTR(SliderBOX(1))
DEF SEG

FOR n = 1 TO 8
    Buildings(n, 1) = n
NEXT n

DIM SHARED LB, RB, MouseX, MouseY
DIM SHARED x#, y#, Angle#, Speed#, Wind!, t#
DIM SHARED KongX, KongY, YoungX, YoungY, Ape
DIM SHARED KScore, YScore, Item, LBldg, RBldg
DIM SHARED NumPLAYERS, CompTOSS

DIM SHARED MouseDATA$

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

RESTORE PaletteDATA
FOR n = 1 TO 48
    READ FadeBOX(n)
NEXT n

SCREEN 12
OUT &H3C8, 0
FOR n = 1 TO 48
    OUT &H3C9, 0
NEXT n

RANDOMIZE TIMER

DO
    PlayGAME
LOOP
 
END

PaletteDATA:
DATA   0,  4, 16,     0, 10, 21,    0, 16, 32,    32, 10, 0
DATA  63,  0,  0,    63, 32,  0,   18, 18, 24,    30, 30, 37
DATA  42, 42, 50,    55, 55, 63,    0,  0,  0,    43, 27, 20
DATA   8,  8, 21,     0, 63, 21,   63, 55, 25,    63, 63, 63

SUB ApeCHUCKLE (Which)

SELECT CASE Which
    CASE 1 'Kong chuckle
        FOR Reps = 1 TO 10
            WAIT &H3DA, 8
            WAIT &H3DA, 8, 8
            PUT (KongX, KongY), KongBOX(1351), PSET
            Interval .1
            WAIT &H3DA, 8
            WAIT &H3DA, 8, 8
            PUT (KongX, KongY), KongBOX(1801), PSET
            Interval .1
        NEXT Reps

    CASE 2 'Young chuckle
        FOR Reps = 1 TO 10
            WAIT &H3DA, 8
            WAIT &H3DA, 8, 8
            PUT (YoungX, YoungY), YoungBOX(1351), PSET
            Interval .1
            WAIT &H3DA, 8
            WAIT &H3DA, 8, 8
            PUT (YoungX, YoungY), YoungBOX(1801), PSET
            Interval .1
        NEXT Reps
END SELECT

END SUB

FUNCTION BananaTOSS

t# = 0
IF Ape = 1 THEN
    YTurn = 0: KTurn = 7
    x# = KongX: y# = KongY - 24
ELSE
    KTurn = 7: KTurn = 0
    x# = YoungX: y# = YoungY - 24
END IF

IF Ape = 2 THEN Angle# = 180 - Angle#
Angle# = Angle# * Degree!
vx# = Speed# * COS(Angle#)
vy# = Speed# * SIN(Angle#)
InitialX = x#
InitialY = y#

'GET starting background location of banana ---------------------------
GET (x#, y#)-(x# + 12, y# + 12), Banana(801)

'Animate banana toss (frames 2 & 3) -----------------------------------
FOR Index = 451 TO 901 STEP 450
    Interval .02
    WAIT &H3DA, 8
    WAIT &H3DA, 8, 8
    IF Ape = 1 THEN
        PUT (KongX, KongY), KongBOX(Index), PSET
    ELSE
        PUT (YoungX, YoungY), YoungBOX(Index), PSET
    END IF
NEXT Index

Index = 1 'Initialize banana index

DO 'banana toss loop

    Interval .001
    WAIT &H3DA, 8
    WAIT &H3DA, 8, 8

    'PUT banana background at old x/y ---------------------------
    IF x# >= 0 AND x# <= 627 THEN
        IF y# >= 40 THEN
            PUT (x#, y#), Banana(801), PSET
        END IF
    END IF

    'Determine new position of banana --------------------------
    'NOTE: The essential formula for determining the path of
    'the thrown banana is taken from the original GORILLA.BAS
    x# = InitialX + (vx# * t#) + (.5 * (Wind! / 5) * t# ^ 2)
    y# = InitialY + -(vy# * t#) + (.5 * G# * t# ^ 2)
    t# = t# + .1

    'Whether or not to PUT the banana and background
    IF x# >= 2 AND x# < 627 THEN
        IF y# >= 40 AND y# <= 467 THEN

            'JOE YOUNG hit
            IF x# + 12 >= YoungX + 2 AND x# <= YoungX + 38 THEN
                IF y# + 12 >= YoungY + 7 AND y# <= YoungY + 42 THEN
                    Explode 2
                    KScore = KScore + 1
                    PrintSCORE 1, KScore
                    ApeCHUCKLE 1
                    BananaTOSS = 1
                    EXIT FUNCTION
                END IF
            END IF

            'KONG is hit
            IF x# + 12 >= KongX + 2 AND x# <= KongX + 38 THEN
                IF y# + 12 >= KongY + 7 AND y# <= KongY + 42 THEN
                    Explode 1
                    YScore = YScore + 1
                    PrintSCORE 2, YScore
                    ApeCHUCKLE 2
                    BananaTOSS = 2
                    EXIT FUNCTION
                END IF
            END IF

            'Building hit
            IF y# > 120 THEN
                IF (POINT(x# + 2, y#) <> 12 AND POINT(x# + 2, y#) <> 0) THEN BLDG = 1
                IF (POINT(x# + 10, y#) <> 12 AND POINT(x# + 10, y#) <> 0) THEN BLDG = 1
                IF (POINT(x#, y# + 10) <> 12 AND POINT(x#, y# + 10) <> 0) THEN BLDG = 1
            END IF
            IF BLDG = 1 THEN
                BLDG = 0
                Explode 3
                BananaTOSS = 3
                EXIT FUNCTION
            END IF

            'GET background, PUT banana at new location
            GET (x#, y#)-(x# + 12, y# + 12), Banana(801)
            PUT (x#, y#), Banana(Index + 50), AND
            PUT (x#, y#), Banana(Index)

        END IF 'Legal banana-PUT END IF's
    END IF

    Index = Index + 100 'Index changes whether banana is PUT or not ---------
    IF Index = 801 THEN Index = 1

    'Ape reaction turns section -----------------------------------------------

    IF t# > .5 AND t# < .6 THEN 'Finish toss (arm goes down)
        IF Ape = 1 THEN
            PUT (KongX, KongY), KongBOX(4501), PSET
        ELSE
            PUT (YoungX, YoungY), YoungBOX(2701), PSET
        END IF
    END IF

    IF t# > 1.5 THEN 'Turn with passing banana (both apes)
        IF YTurn < 2 THEN
            WAIT &H3DA, 8
            WAIT &H3DA, 8, 8
            SELECT CASE YTurn
                CASE 0: PUT (YoungX, YoungY), YoungBOX(3151), PSET: YTurn = 1
                CASE 1: PUT (YoungX, YoungY), YoungBOX(2701), PSET: YTurn = 2
            END SELECT
        END IF

        IF KTurn < 2 THEN
            WAIT &H3DA, 8
            WAIT &H3DA, 8, 8
            SELECT CASE KTurn
                CASE 0: PUT (KongX, KongY), KongBOX(4051), PSET: KTurn = 1
                CASE 1: PUT (KongX, KongY), KongBOX(4501), PSET: KTurn = 2
            END SELECT
        END IF

        IF x# > YoungX AND YTurn < 7 THEN
            WAIT &H3DA, 8
            WAIT &H3DA, 8, 8
            SELECT CASE YTurn
                CASE 2: PUT (YoungX, YoungY), YoungBOX(2701), PSET: YTurn = 3
                CASE 3: PUT (YoungX, YoungY), YoungBOX(3151), PSET: YTurn = 4
                CASE 4: PUT (YoungX, YoungY), YoungBOX(3601), PSET: YTurn = 5
                CASE 5: PUT (YoungX, YoungY), YoungBOX(4051), PSET: YTurn = 6
                CASE 6: PUT (YoungX, YoungY), YoungBOX(4501), PSET: YTurn = 7
            END SELECT
        END IF

        IF x# < KongX + 40 AND KTurn < 7 THEN
            WAIT &H3DA, 8
            WAIT &H3DA, 8, 8
            SELECT CASE KTurn
                CASE 2: PUT (KongX, KongY), KongBOX(4501), PSET: KTurn = 3
                CASE 3: PUT (KongX, KongY), KongBOX(4051), PSET: KTurn = 4
                CASE 4: PUT (KongX, KongY), KongBOX(3601), PSET: KTurn = 5
                CASE 5: PUT (KongX, KongY), KongBOX(3151), PSET: KTurn = 6
                CASE 6: PUT (KongX, KongY), KongBOX(2701), PSET: KTurn = 7
            END SELECT
        END IF
    END IF

LOOP UNTIL x# < 3 OR x# > 627

IF x# >= 0 AND x# <= 627 THEN 'erase banana to end toss sequence -------
    IF y# >= 40 THEN
        PUT (x#, y#), Banana(801), PSET
    END IF
END IF

BananaTOSS = 3

END FUNCTION

SUB ClearMOUSE

WHILE LB OR RB
    MouseSTATUS LB, RB, MouseX, MouseY
WEND

END SUB

FUNCTION Computer
STATIC CompSPEED, CompANGLE, XDiff, YDiff, FinalX

'The computer's gameplay is designed to imitate the play of a
'real person. The first shot is established as an educated guess
'with a touch of randomness. On subsequent shots, the formula
'modifies Speed# and Angle# based on the outcome of this first shot.
'Sometimes, just like a real person, the first shot will score a
'hit. Other times, it is a long and embarassing process.

'Computer-shot computation formulas
IF CompTOSS = 0 THEN
    XDiff = YoungX - KongX
    YDiff = KongY - YoungY
    CompSPEED = XDiff / (FIX(RND * 2) + 6) + Wind!
    CompANGLE = 35 - (YDiff / 5)
    CompTOSS = 1
ELSE
    IF KongX > FinalX THEN
        CompSPEED = CompSPEED * .9
    ELSE
        CompSPEED = CompSPEED * 1.2
        IF YoungX - FinalX < 100 THEN 'Oops! Tall building
            CompANGLE = CompANGLE + 10
        ELSE
            CompANGLE = CompANGLE + 3
        END IF
    END IF
END IF
IF CompSPEED > 99 THEN CompSPEED = 99
IF CompSPEED < 0 THEN CompSPEED = 0
IF CompANGLE > 70 THEN CompANGLE = 70
IF CompANGLE < 0 THEN CompANGLE = 0

Speed# = CompSPEED
Angle# = CompANGLE
Sliders INT(Speed#), 1
Sliders INT(Angle#), 2
Interval 1

SELECT CASE BananaTOSS 'Call to BananaTOSS FUNCTION -----------
    CASE 1 'Kong exploded Young
        IF KScore = 3 THEN 'Kong wins
            Computer = 2 'Game over
            EXIT FUNCTION
        END IF
        Computer = 1 'Reset screen
        EXIT FUNCTION
    CASE 2 'Young exploded Kong
        IF YScore = 3 THEN 'Young wins
            Computer = 2 'Game over
            EXIT FUNCTION
        END IF
        Computer = 1 'Reset screen
        EXIT FUNCTION
    CASE 3 'Building explosion or banana out-of-play
        FinalX = x#
        Computer = -1 'Change player
        EXIT FUNCTION
END SELECT

Computer = 0 'No action required

END FUNCTION

FUNCTION ControlPANEL
SHARED Player1SPEED#, Player2SPEED#
SHARED Player1ANGLE#, Player2ANGLE#

SELECT CASE MouseX
    CASE 147 TO 246
        IF MouseY > 441 AND MouseY < 463 THEN
            IF LB = -1 THEN
                Speed# = MouseX - 147
                IF Speed# < 0 THEN Speed# = 0
                IF Speed# > 99 THEN Speed# = 99
                SELECT CASE Ape
                    CASE 1
                        Player1SPEED# = Speed#
                    CASE 2
                        Player2SPEED# = Speed#
                END SELECT
                Sp = INT(Speed#)
                Sliders Sp, 1
            END IF
        END IF
    CASE 385 TO 499
        IF MouseY > 423 AND MouseY < 463 THEN
            IF LB = -1 THEN
                Angle# = 494 - MouseX
                IF Angle# < 0 THEN Angle# = 0
                IF Angle# > 90 THEN Angle# = 90
                SELECT CASE Ape
                    CASE 1
                        Player1ANGLE# = Angle#
                    CASE 2
                        Player2ANGLE# = Angle#
                END SELECT
                An = INT(Angle#)
                Sliders An, 2
            END IF
        END IF
    CASE 305 TO 335
        IF MouseY > 423 AND MouseY < 452 THEN
            IF LB = -1 THEN
                HideMOUSE
                GET (308, 427)-(331, 447), Box(25500)
                GET (311, 430)-(328, 444), Box(25000)
                PUT (310, 429), Box(25000), PSET
                LINE (309, 428)-(330, 446), 1, B
                LINE (308, 428)-(331, 448), 10, B
                LINE (331, 429)-(331, 447), 8
                LINE (308, 448)-(330, 448), 8
                ShowMOUSE
                Interval .2
                HideMOUSE
                PUT (308, 427), Box(25500), PSET
                ShowMOUSE
                SELECT CASE BananaTOSS 'Call to BananaTOSS FUNCTION -----------
                    CASE 1 'Kong exploded Young
                        IF KScore = 3 THEN 'Kong wins
                            ControlPANEL = 2 'Game over
                            EXIT FUNCTION
                        END IF
                        ControlPANEL = 1 'Reset screen
                        EXIT FUNCTION
                    CASE 2 'Young exploded Kong
                        IF YScore = 3 THEN 'Young wins
                            ControlPANEL = 2 'Game over
                            EXIT FUNCTION
                        END IF
                        ControlPANEL = 1 'Reset screen
                        EXIT FUNCTION
                    CASE 3 'Building explosion or banana out-of-play
                        ControlPANEL = -1 'Change player
                        EXIT FUNCTION
                END SELECT
            END IF
        END IF
END SELECT
ControlPANEL = 0 'No action required

END FUNCTION

SUB DoAPES

KongX = LBldg * 80 - 59
KongY = Buildings(LBldg, 2) - 42
YoungX = RBldg * 80 - 59
YoungY = Buildings(RBldg, 2) - 42
 
DEF SEG = VARSEG(Box(1))
BLOAD "kongmjy.bsv", VARPTR(Box(1))
DEF SEG
ApeINDEX = 1
GET (YoungX, YoungY)-(YoungX + 38, YoungY + 42), YoungBOX(5000)
FOR Index = 1 TO 9001 STEP 900
    PUT (YoungX, YoungY), YoungBOX(5000), PSET
    PUT (YoungX, YoungY), Box(Index + 450), AND
    PUT (YoungX, YoungY), Box(Index)
    GET (YoungX, YoungY)-(YoungX + 38, YoungY + 42), YoungBOX(ApeINDEX)
    ApeINDEX = ApeINDEX + 450
NEXT Index

DEF SEG = VARSEG(Box(1))
BLOAD "kongkong.bsv", VARPTR(Box(1))
DEF SEG
ApeINDEX = 1
GET (KongX, KongY)-(KongX + 38, KongY + 42), KongBOX(5000)
FOR Index = 1 TO 9001 STEP 900
    PUT (KongX, KongY), KongBOX(5000), PSET
    PUT (KongX, KongY), Box(Index + 450), AND
    PUT (KongX, KongY), Box(Index)
    GET (KongX, KongY)-(KongX + 38, KongY + 42), KongBOX(ApeINDEX)
    ApeINDEX = ApeINDEX + 450
NEXT Index

PUT (KongX, KongY), KongBOX(2251), PSET
PUT (YoungX, YoungY), YoungBOX(2251), PSET

DEF SEG = VARSEG(Box(1))
BLOAD "kongexpl.bsv", VARPTR(Box(1))
DEF SEG

END SUB

SUB DrawSCREEN

'Main screen background/title bar and control panel
CLS
DEF SEG = VARSEG(Box(1))
FileCOUNT = 0
FOR y = 0 TO 320 STEP 160
    FileCOUNT = FileCOUNT + 1
    FileNAME$ = "kongscr" + LTRIM$(STR$(FileCOUNT)) + ".bsv"
    BLOAD FileNAME$, VARPTR(Box(1))
    PUT (0, y), Box(), PSET
NEXT y
DEF SEG

'Shuffle buildings order
FOR n = 8 TO 2 STEP -1
    Tower = INT(RND * n) + 1
    SWAP Buildings(n, 1), Buildings(Tower, 1)
NEXT n

LBldg = FIX(RND * 3) + 1
RBldg = FIX(RND * 3) + 6

'Set buildings order/ save height information to array
x = 0
DEF SEG = VARSEG(Box(1))
FOR n = 1 TO 8
    FileNAME$ = "kongbld" + LTRIM$(STR$(Buildings(n, 1))) + ".bsv"
    BLOAD FileNAME$, VARPTR(Box(1))
    Height = 165 + FIX(RND * 160)
    IF n = LBldg AND Height > 264 THEN Height = 264
    IF n = RBldg AND Height > 264 THEN Height = 264
    Buildings(n, 2) = Height
    Box(2001) = 405 - (Height + Box(1))
    PUT (x, Height + Box(1)), Box(2000), PSET
    PUT (x, Height + Box(1) - 45), Box(1000), AND
    PUT (x, Height + Box(1) - 45), Box(2)
    x = x + 80
NEXT n

'Street lights
FOR x = 19 TO 639 STEP 120
    LINE (x, 360)-(x + 1, 400), 10, B
    CIRCLE (x + 8, 364), 2, 15
    PAINT STEP(0, 0), 15
    CIRCLE STEP(0, 0), 5, 8
NEXT x

'Foreground building silhouettes
BLOAD "kongfbld.bsv", VARPTR(Box(1))
DEF SEG
PUT (0, 362), Box(7000), AND
PUT (0, 362), Box()

SetWIND
Sliders 0, 1
Sliders 0, 2
PrintSCORE 1, KScore
PrintSCORE 2, YScore

END SUB

SUB Explode (What)
STATIC BlastCOUNT

SELECT CASE What
    CASE 1
        Ex = x# - 26: Ey = y# - 26
        GOSUB FirstBLAST
        Ex = KongX - 12: Ey = KongY - 12
        Dx = KongX - 4: Dy = KongY + 20
    CASE 2
        Ex = x# - 26: Ey = y# - 26
        GOSUB FirstBLAST
        Ex = YoungX - 12: Ey = YoungY - 12
        Dx = YoungX - 4: Dy = YoungY + 20
    CASE 3
        Ex = x# - 26: Ey = y# - 26
        Dx = x# - 20: Dy = y# - 20
END SELECT

IF Ex + 62 > 639 THEN Ex = 639 - 62
IF Ex < 0 THEN Ex = 0
GET (Ex, Ey)-(Ex + 62, Ey + 62), ExplosionBACK()

FOR Index = 1 TO 14421 STEP 2060
    PUT (Ex, Ey), ExplosionBACK(), PSET
    IF Index = 4121 THEN
        IF What = 1 THEN
            PUT (KongX, KongY), KongBOX(5000), PSET
        ELSEIF What = 2 THEN
            PUT (YoungX, YoungY), YoungBOX(5000), PSET
        END IF
        GOSUB Damage
        GET (Ex, Ey)-(Ex + 62, Ey + 62), ExplosionBACK()
    END IF
    PUT (Ex, Ey), Box(Index + 1030), AND
    PUT (Ex, Ey), Box(Index), XOR
    Interval .05
    WAIT &H3DA, 8
    WAIT &H3DA, 8, 8
NEXT Index

PUT (Ex, Ey), ExplosionBACK(), PSET

EXIT SUB

Damage:
OPEN "kongcrtr.dat" FOR INPUT AS #2
INPUT #2, Wdth, Dpth
BlastCOUNT = BlastCOUNT + 1
SELECT CASE BlastCOUNT
    CASE 1
        FOR cx = Dx + Wdth TO Dx STEP -1
            FOR cy = Dy + Dpth TO Dy STEP -1
                GOSUB DrawCRATER
            NEXT cy
        NEXT cx
    CASE 2
        FOR cx = Dx TO Dx + Wdth
            FOR cy = Dy TO Dy + Dpth
                GOSUB DrawCRATER
            NEXT cy
        NEXT cx
        BlastCOUNT = 0
END SELECT
CLOSE #2
RETURN

DrawCRATER:
INPUT #2, Colr
IF Colr <> 0 THEN
    IF POINT(cx, cy) <> 0 AND POINT(cx, cy) <> 12 THEN
        PSET (cx, cy), Colr
    END IF
END IF
RETURN

FirstBLAST:
IF Ex < 0 THEN Ex = 0
IF Ex + 62 > 639 THEN Ex = 577
GET (Ex, Ey)-(Ex + 62, Ey + 62), ExplosionBACK()
FOR Index = 1 TO 6181 STEP 2060
    Interval 0
    WAIT &H3DA, 8
    WAIT &H3DA, 8, 8
    PUT (Ex, Ey), ExplosionBACK(), PSET
    PUT (Ex, Ey), Box(Index + 1030), AND
    PUT (Ex, Ey), Box(Index), XOR
NEXT Index
PUT (Ex, Ey), ExplosionBACK(), PSET
RETURN

END SUB

SUB Fade (InOUT)

IF InOUT = 1 THEN 'Fade out
    FullFADE! = 1
    DO
        Interval .1
        WAIT &H3DA, 8
        WAIT &H3DA, 8, 8
        FullFADE! = FullFADE! * 1.3
        OUT &H3C8, 0
        FOR n = 1 TO 48
            OUT &H3C9, INT(FadeBOX(n) / FullFADE!)
        NEXT n
    LOOP WHILE FullFADE! < 20
    OUT &H3C8, 0
    FOR n = 1 TO 48
        OUT &H3C9, 0
    NEXT n
ELSE 'Fade in
    FullFADE! = 20
    DO
        Interval .1
        WAIT &H3DA, 8
        WAIT &H3DA, 8, 8
        FullFADE! = FullFADE! * .825
        OUT &H3C8, 0
        FOR n = 1 TO 48
            OUT &H3C9, INT(FadeBOX(n) / FullFADE!)
        NEXT n
    LOOP WHILE FullFADE! > 1.2
    SetPALETTE
END IF

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

HideMOUSE
GET (192, 140)-(447, 290), Box(12000)
ShowMOUSE

FOR n = 1 TO 3
    DEF SEG = VARSEG(Box(1))
    FileNAME$ = "kongins" + LTRIM$(STR$(n)) + ".bsv"
    BLOAD FileNAME$, VARPTR(Box(1))
    DEF SEG
    HideMOUSE
    PUT (192, 140), Box(), PSET
    ShowMOUSE
    GOSUB ClickARROW
NEXT n

HideMOUSE
PUT (192, 140), Box(12000), PSET
ShowMOUSE

DEF SEG = VARSEG(Box(1))
BLOAD "kongexpl.bsv", VARPTR(Box(1))
DEF SEG

EXIT SUB

ClickARROW:
DO
    MouseSTATUS LB, RB, MouseX, MouseY
    SELECT CASE MouseX
        CASE 400 TO 424
            IF MouseY > 154 AND MouseY < 168 THEN
                IF Arrow = 0 THEN
                    HideMOUSE
                    GET (400, 154)-(424, 167), Box(25000)
                    FOR x = 400 TO 424
                        FOR y = 154 TO 167
                            IF POINT(x, y) = 6 THEN PSET (x, y), 13
                        NEXT y
                    NEXT x
                    ShowMOUSE
                    Arrow = 1
                END IF
            ELSE
                IF Arrow THEN
                    HideMOUSE
                    PUT (400, 154), Box(25000), PSET
                    ShowMOUSE
                    Arrow = 0
                END IF
            END IF
        CASE ELSE
            IF Arrow THEN
                HideMOUSE
                PUT (400, 154), Box(25000), PSET
                ShowMOUSE
                Arrow = 0
            END IF
    END SELECT
    IF Arrow = 1 AND LB = -1 THEN
        PUT (400, 154), Box(25000), PSET
        ClearMOUSE
        Arrow = 0
        RETURN
    END IF
LOOP
RETURN

END SUB

DEFSNG A-Z
SUB Interval (Length!)

OldTIMER# = TIMER
DO
    IF TIMER < OldTIMER# THEN EXIT SUB
LOOP UNTIL TIMER > OldTIMER# + Length!
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
STATIC Started
SHARED Player1SPEED#, Player2SPEED#
SHARED Player1ANGLE#, Player2ANGLE#

DrawSCREEN
DoAPES
CompTOSS = 0

Fade 2

DO
    IF Started = 0 THEN
        KScore = 0: YScore = 0
        PrintSCORE 1, KScore
        PrintSCORE 2, YScore
        StartUP
        Started = 1
        IF NumPLAYERS = 2 THEN
            Ape = FIX(RND * 2) + 1
            Player1SPEED# = 0: Player2SPEED# = 0
            Player1ANGLE# = 0: Player2ANGLE# = 0
        ELSE
            Ape = 2
        END IF
        ClearMOUSE
    END IF

    IF Ape = 1 THEN Ape = 2 ELSE Ape = 1

    IF Ape = 1 THEN
        YTurn = 0: KTurn = 7
        LINE (73, 473)-(97, 474), 13, B 'LED's
        LINE (540, 473)-(564, 474), 10, B
        PUT (KongX, KongY), KongBOX(), PSET
        Speed# = Player1SPEED#: Angle# = Player1ANGLE#
        Sliders INT(Player1SPEED#), 1
        Sliders INT(Player1ANGLE#), 0
    ELSE
        YTurn = 7: KTurn = 0
        LINE (73, 473)-(97, 474), 10, B 'LED's
        LINE (540, 473)-(564, 474), 13, B
        PUT (YoungX, YoungY), YoungBOX(), PSET
        Speed# = Player2SPEED#: Angle# = Player2ANGLE#
        Sliders INT(Player2SPEED#), 1
        Sliders INT(Player2ANGLE#), 0
    END IF
    IF NumPLAYERS = 1 AND Ape = 2 THEN LocateMOUSE 319, 440
    ShowMOUSE

    DO
        MouseSTATUS LB, RB, MouseX, MouseY
        SELECT CASE MouseY
            CASE 18 TO 27
                TopMENU 1
            CASE 424 TO 462
                IF NumPLAYERS = 1 AND Ape = 2 THEN
                    SELECT CASE Computer 'Call to Computer FUNCTION
                        CASE -1: EXIT DO 'Change player
                        CASE 1 'Reset screen
                            Fade 1
                            HideMOUSE
                            Player1SPEED# = 0: Player2SPEED# = 0
                            Player1ANGLE# = 0: Player2ANGLE# = 0
                            EXIT SUB
                        CASE 2: GOSUB EndGAME 'Game over
                    END SELECT
                ELSE
                    SELECT CASE ControlPANEL 'Call to ControlPANEL FUNCTION
                        CASE -1: EXIT DO 'Change player
                        CASE 1 'Reset screen
                            Fade 1
                            HideMOUSE
                            Player1SPEED# = 0: Player2SPEED# = 0
                            Player1ANGLE# = 0: Player2ANGLE# = 0
                            EXIT SUB
                        CASE 2: GOSUB EndGAME 'Game over
                    END SELECT
                END IF
            CASE ELSE
                IF Item THEN TopMENU 0
        END SELECT
    LOOP

LOOP

EXIT SUB

EndGAME:
DEF SEG = VARSEG(Box(1))
IF KScore = 3 THEN
    BLOAD "kongwink.bsv", VARPTR(Box(1))
ELSE
    BLOAD "kongwiny.bsv", VARPTR(Box(1))
END IF
DEF SEG
wx = (640 - Box(1)) / 2
WAIT &H3DA, 8
WAIT &H3DA, 8, 8
PUT (wx, 160), Box(), PSET
a$ = INPUT$(1)
IF a$ = CHR$(13) THEN
    Started = 0
    Fade 1
    Player1SPEED# = 0: Player2SPEED# = 0
    Player1ANGLE# = 0: Player2ANGLE# = 0
    HideMOUSE
    EXIT SUB
END IF
SYSTEM
RETURN

END SUB

SUB PrintSCORE (Ape, Score)

IF Ape = 1 THEN
    PUT (19, 452), NumBOX(Score * 75 + 1), PSET
ELSE
    PUT (604, 452), NumBOX(Score * 75 + 1), PSET
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

SUB SetWIND

Wind! = FIX(RND * 17) - 8
LINE (291, 462)-(349, 476), 7, BF
IF Wind! = 0 THEN
    PUT (298, 465), LilBOX(), PSET
ELSE
    IF Wind! < 0 THEN
        PSET (320 + ABS(Wind! * 2) + 3, 466), 13
        DRAW "L10"
        DRAW "L" + LTRIM$(STR$(ABS(Wind! * 3))) + "U3 G6 F6 U3 R10"
        DRAW "R" + LTRIM$(STR$(ABS(Wind! * 3))) + "U6 bg3 p13,13"
    ELSE
        PSET (320 - Wind! * 2 - 3, 466), 13
        DRAW "R10"
        DRAW "R" + LTRIM$(STR$(ABS(Wind! * 3))) + "U3 F6 G6 U3 L10"
        DRAW "L" + LTRIM$(STR$(ABS(Wind! * 3))) + "U6 bf3 p13,13"
    END IF
END IF

END SUB

SUB ShowMOUSE
LB = 1
MouseDRIVER LB, 0, 0, 0
END SUB

SUB Sliders (Value, Slider)
STATIC LeftX, RightX

IF LeftX = 0 THEN LeftX = 141
IF RightX = 0 THEN RightX = 484
WAIT &H3DA, 8
WAIT &H3DA, 8, 8

HideMOUSE
IF Slider = 1 THEN
    PUT (LeftX, 443), SliderBOX(281), PSET
    LeftX = 141 + Value
    GET (LeftX, 443)-(LeftX + 10, 461), SliderBOX(281)
    PUT (LeftX, 443), SliderBOX(201), PSET
ELSE
    PUT (RightX, 443), SliderBOX(361), PSET
    RightX = 489 - Value
    GET (RightX, 443)-(RightX + 10, 461), SliderBOX(361)
    PUT (RightX, 443), SliderBOX(201), PSET
END IF
ShowMOUSE

GOSUB SetNUMS

EXIT SUB

SetNUMS:
Num$ = LTRIM$(STR$(Value))
IF Value < 10 THEN
    LNum = 0
    RNum = VAL(Num$)
ELSE
    LNum = VAL(MID$(Num$, 1, 1))
    RNum = VAL(MID$(Num$, 2, 1))
END IF
HideMOUSE
IF Slider = 1 THEN
    PUT (260, 447), SliderBOX(LNum * 20 + 1), PSET
    PUT (266, 447), SliderBOX(RNum * 20 + 1), PSET
ELSE
    PUT (369, 447), SliderBOX(LNum * 20 + 1), PSET
    PUT (375, 447), SliderBOX(RNum * 20 + 1), PSET
END IF
ShowMOUSE
RETURN

END SUB

SUB StartUP

DEF SEG = VARSEG(Box(1))
BLOAD "kong1pl2.bsv", VARPTR(Box(1))
DEF SEG
GET (209, 160)-(430, 237), Box(12000)
PUT (209, 160), Box(), PSET
LocateMOUSE 340, 190
ShowMOUSE

DO
    MouseSTATUS LB, RB, MouseX, MouseY
    SELECT CASE MouseX
        CASE 244 TO 270
            IF Item = 0 THEN
                SELECT CASE MouseY
                    CASE 193 TO 205
                        IF LB THEN
                            ButtonX = 245: ButtonY = 194
                            GOSUB Clicker
                            NumPLAYERS = 2
                            FileNAME$ = "kongopen.bsv"
                            GOSUB LoadFILE
                        END IF
                    CASE 209 TO 221
                        IF LB THEN
                            ButtonX = 245: ButtonY = 210
                            GOSUB Clicker
                            NumPLAYERS = 1
                            FileNAME$ = "Kong1PLR.BSV"
                            GOSUB LoadFILE
                        END IF
                END SELECT
            END IF
        CASE 340 TO 366
            IF Item = 1 THEN
                IF MouseY > 209 AND MouseY < 221 THEN
                    IF LB THEN
                        ButtonX = 340: ButtonY = 210
                        GOSUB Clicker
                        EXIT DO
                    END IF
                END IF
            END IF
    END SELECT
LOOP

HideMOUSE
PUT (209, 160), Box(12000), PSET
ShowMOUSE
Item = 0
DEF SEG = VARSEG(Box(1))
BLOAD "kongexpl.bsv", VARPTR(Box(1))
DEF SEG

EXIT SUB

LoadFILE:
DEF SEG = VARSEG(Box(1))
BLOAD LCASE$(FileNAME$), VARPTR(Box(21500))
DEF SEG
HideMOUSE
PUT (209, 160), Box(21500), PSET
ShowMOUSE
RETURN

Clicker:
HideMOUSE
GET (ButtonX, ButtonY)-(ButtonX + 24, ButtonY + 10), Box(20000)
LINE (ButtonX, ButtonY)-(ButtonX + 24, ButtonY + 10), 8, B
ShowMOUSE
Interval .1
HideMOUSE
PUT (ButtonX, ButtonY), Box(20000), PSET
ShowMOUSE
Interval .01
Item = Item + 1
RETURN

END SUB

SUB TopMENU (InOUT)
STATIC MX1

IF InOUT = 0 THEN GOSUB DeLIGHT: EXIT SUB

SELECT CASE MouseX
    CASE 20 TO 72
        IF Item <> 1 THEN
            GOSUB DeLIGHT
            MX1 = 20: MX2 = 72
            GOSUB HiLIGHT
            Item = 1
        END IF
    CASE 594 TO 616
        IF Item <> 2 THEN
            GOSUB DeLIGHT
            MX1 = 594: MX2 = 616
            GOSUB HiLIGHT
            Item = 2
        END IF
    CASE ELSE
        GOSUB DeLIGHT
END SELECT

IF LB = -1 AND Item THEN
    SELECT CASE Item
        CASE 1: GOSUB DeLIGHT: Instructions
        CASE 2: GOSUB DeLIGHT: SYSTEM
    END SELECT
END IF

EXIT SUB

HiLIGHT:
HideMOUSE
GET (MX1, 18)-(MX2, 27), Box(25000)
FOR x = MX1 TO MX2
    FOR y = 18 TO 27
        IF POINT(x, y) <> 1 AND POINT(x, y) <> 2 THEN
            PSET (x, y), 13
        END IF
    NEXT y
NEXT x
ShowMOUSE
RETURN

DeLIGHT:
IF Item THEN
    HideMOUSE
    PUT (MX1, 18), Box(25000), PSET
    ShowMOUSE
END IF
Item = 0
RETURN

END SUB
