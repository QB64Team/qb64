CHDIR ".\programs\samples\thebob\pongg"

'****************************************************************************
'---------------------------- P O N G G ! - 2.0 -----------------------------
'---------------------- Freeware by Bob Seguin - 2007 -----------------------
'****************************************************************************

DEFINT A-Z

DECLARE SUB MouseDRIVER (LB, RB, MX, MY)
DECLARE SUB MouseSTATUS (LB, RB, MouseX, MouseY)
DECLARE SUB ShowMOUSE ()
DECLARE SUB HideMOUSE ()
DECLARE SUB LocateMOUSE (x, y)
DECLARE SUB FieldMOUSE (x1, y1, x2, y2)
DECLARE SUB PauseMOUSE (LB, RB, MouseX, MouseY)
DECLARE SUB ClearMOUSE ()

DECLARE FUNCTION InitMOUSE ()

DECLARE SUB PrintSTRING (x, y, Prnt$, Mode)
DECLARE SUB Alphagetti (x, y, Char$, Mode)
DECLARE SUB Interval (Length!)
DECLARE SUB DrawSCREEN ()
DECLARE SUB SetPALETTE ()
DECLARE SUB PrintSCORE (x, n$)
DECLARE SUB TopFIVE ()
DECLARE SUB EndGAME ()

'$DYNAMIC

DIM SHARED BallBOX(1 TO 400)
DIM SHARED BackBOX(1 TO 200)
DIM SHARED HeadBOX(1 TO 1600)
DIM SHARED PaddleBOX(1 TO 250)
DIM SHARED BigBOX(1 TO 26000)
DIM SHARED FontBOX(7100)
DIM SHARED CharBOX(1 TO 22)

TYPE PlayerTYPE
PlayerNAME AS STRING * 20
PlayerSCORE AS LONG
PlayDATE AS STRING * 10
END TYPE
DIM SHARED PlayerBOX(1 TO 6) AS PlayerTYPE
OPEN "pongg.top" FOR APPEND AS #1
CLOSE #1

OPEN "pongg.top" FOR INPUT AS #1
DO WHILE NOT EOF(1)
    in = in + 1
    INPUT #1, PlayerBOX(in).PlayerNAME
    INPUT #1, PlayerBOX(in).PlayerSCORE
    INPUT #1, PlayerBOX(in).PlayDATE
LOOP
CLOSE #1

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
    COLOR 12
    LOCATE 10, 24: PRINT "Sorry, cat must have got the mouse."
    LOCATE 11, 24: PRINT STRING$(37, "-")
    LOCATE 12, 24: PRINT "Since this is a mouse-driven program,"
    LOCATE 13, 24: PRINT "it will have to be shut down."
    SLEEP 3
    SYSTEM
END IF
LocateMOUSE 308, 440

SCREEN 12
SetPALETTE
DrawSCREEN

PaddleX = 281
BallX = 310: BallY = 62
Lives = 5
PrintSCORE 106, "5"
PrintSCORE 582, "000000"
Start = 1
GET (310, 62)-(330, 92), BackBOX()
PUT (310, 62), BallBOX(201), AND
PUT (310, 62), BallBOX(), OR
RANDOMIZE TIMER
Start = 1: BincX = 0: BincY = 0

DO
    Beginning:
    MouseSTATUS LB, RB, MouseX, MouseY
    Key$ = UCASE$(INKEY$)
    SELECT CASE Key$
        CASE "T"
            TopFIVE
        CASE " "
            RePAUSE:
            DO: k$ = UCASE$(INKEY$): LOOP UNTIL k$ <> ""
            IF k$ = CHR$(27) THEN CLS: SYSTEM
            IF k$ = "T" THEN
                TopFIVE
                PUT (BallX, BallY), BallBOX(), PSET
                GOTO RePAUSE
            END IF
        CASE CHR$(27)
            CLS
            SYSTEM
    END SELECT
    IF Start = 1 THEN
        IF Lives = 5 THEN PLAY "MBT120L64O4cP32dP32eP32fP32gP32fP32eP32dP32c"
        LINE (PaddleX, 440)-(PaddleX + 79, 450), 0, BF
        LocateMOUSE 308, 440
        PaddleX = 281
        PUT (PaddleX, 440), PaddleBOX(), PSET
        DO
            MouseSTATUS LB, RB, MouseX, MouseY
            k$ = UCASE$(INKEY$)
            LINE (255 - Scan, 20)-(267 - Scan, 36), 5, BF
            LINE (375 + Scan, 20)-(387 + Scan, 36), 5, BF
            Scan = Scan + 12: IF Scan = 120 THEN Scan = 0
            LINE (255 - Scan, 20)-(267 - Scan, 36), 12, BF
            LINE (375 + Scan, 20)-(387 + Scan, 36), 12, BF
            WAIT &H3DA, 8: WAIT &H3DA, 8, 8
        LOOP UNTIL LB OR (k$ = "X" OR k$ = "T" OR k$ = "R" OR k$ = CHR$(27))
        LINE (255 - Scan, 20)-(267 - Scan, 36), 5, BF
        LINE (375 + Scan, 20)-(387 + Scan, 36), 5, BF
        SELECT CASE k$
            CASE "R"
                PaddleX = 281
                BallX = 310: BallY = 62
                LINE (BallX, BallY)-(BallX + 20, BallY + 22), 0, BF
                GET (BallX, BallY)-(BallX + 20, BallY + 20), BackBOX()
                PUT (BallX, BallY), BallBOX(201), AND
                PUT (BallX, BallY), BallBOX(), OR
                Lives = 5
                PlayerBOX(6).PlayerSCORE = 0
                Start = 1
                PrintSCORE 106, "5"
                PrintSCORE 582, "000000"
                GOTO Beginning
            CASE "X"
                DEF SEG = VARSEG(BigBOX(1))
                BLOAD "ponggin1.bsv", VARPTR(BigBOX(1))
                DEF SEG
                PUT (198, 178), BigBOX(), PSET
                DO
                    k$ = INKEY$
                LOOP UNTIL k$ <> ""
                IF k$ = CHR$(27) THEN CLS: SYSTEM
                DEF SEG = VARSEG(BigBOX(1))
                BLOAD "ponggin2.bsv", VARPTR(BigBOX(1))
                DEF SEG
                PUT (198, 178), BigBOX(), PSET
                DEF SEG = VARSEG(BigBOX(1))
                BLOAD "ponggacc.bsv", VARPTR(BigBOX(1))
                DEF SEG
                PUT (110, 118), BigBOX(4001), PSET
                PUT (409, 118), BigBOX(6001), PSET
                DO
                    k$ = INKEY$
                LOOP UNTIL k$ <> ""
                IF k$ = CHR$(27) THEN CLS: SYSTEM
                PUT (110, 118), BigBOX(1), PSET
                PUT (409, 118), BigBOX(2001), PSET
                DEF SEG = VARSEG(BigBOX(1))
                BLOAD "ponggin3.bsv", VARPTR(BigBOX(1))
                DEF SEG
                PUT (198, 178), BigBOX(), PSET
                DO
                    k$ = INKEY$
                LOOP UNTIL k$ <> ""
                IF k$ = CHR$(27) THEN CLS: SYSTEM
                DEF SEG = VARSEG(BigBOX(1))
                BLOAD "ponggbak.bsv", VARPTR(BigBOX(1))
                DEF SEG
                PUT (198, 178), BigBOX(), PSET
                DEF SEG = VARSEG(BigBOX(1))
                BLOAD "ponggops.bsv", VARPTR(BigBOX(1))
                DEF SEG
                PUT (246, 230), BigBOX(), PSET
                GOTO Beginning
            CASE CHR$(27)
                CLS
                SYSTEM
            CASE "T"
                TopFIVE
                DEF SEG = VARSEG(BigBOX(1))
                BLOAD "ponggops.bsv", VARPTR(BigBOX(1))
                DEF SEG
                PUT (246, 230), BigBOX(), PSET
                GOTO Beginning
        END SELECT
        MouseX = 308
        DEF SEG = VARSEG(BigBOX(1))
        BLOAD "ponggbak.bsv", VARPTR(BigBOX(1))
        DEF SEG
        PUT (198, 178), BigBOX(), PSET
        BincX = FIX(RND * 7) - 3: BincY = INT(RND * 3) + 4
        LocateMOUSE 308, 440
        Start = 0
    END IF
    SELECT CASE BincX
        CASE IS < 0
            IF BallX <= 12 THEN BincX = ABS(BincX): GOSUB NEON
        CASE IS > 0
            IF BallX >= 607 THEN BincX = -BincX: GOSUB NEON
    END SELECT
    SELECT CASE BincY
        CASE IS < 0
            IF BallY <= 60 THEN
                GOSUB NEON
                BincY = FIX(RND * 4) + 6
                BincX = FIX(RND * 11) - 5
            END IF
        CASE IS > 0
            IF BallY >= 419 THEN
                IF BallX + 10 >= PaddleX AND BallX + 10 <= PaddleX + 79 THEN
                    IF ABS(BincX) = ABS(OldBINCx) THEN BincX = BincX + FIX(RND * 5) - 2
                    BincY = -BincY: PLAY "MBMST220L64O1B"
                    OldBINCx = BincX

                    PlayerBOX(6).PlayerSCORE = PlayerBOX(6).PlayerSCORE + 10
                    IF Score = 1 THEN PlayerBOX(6).PlayerSCORE = PlayerBOX(6).PlayerSCORE + 15
                    IF Score = 2 THEN PlayerBOX(6).PlayerSCORE = PlayerBOX(6).PlayerSCORE + 40

                    PS$ = LTRIM$(STR$(PlayerBOX(6).PlayerSCORE))
                    SELECT CASE LEN(PS$)
                        CASE 1: PS$ = "00000" + PS$
                        CASE 2: PS$ = "0000" + PS$
                        CASE 3: PS$ = "000" + PS$
                        CASE 4: PS$ = "00" + PS$
                        CASE 5: PS$ = "0" + PS$
                    END SELECT
                    PrintSCORE 582, PS$
                    Score = 0
                END IF
            END IF
            IF BallY >= 430 THEN
                SOUND 50, 5
                LINE (BallX - 1, BallY - 1)-(BallX + 21, BallY + 21), 0, B
                PAINT (BallX + 10, BallY + 10), 15, 0
                Interval 0
                PAINT (BallX + 10, BallY + 10), 4, 0
                Interval 0
                PAINT (BallX + 10, BallY + 10), 14, 0
                Interval 0
                LINE (BallX, BallY)-(BallX + 20, BallY + 20), 0, BF
                GET (310, 60)-(330, 80), BackBOX()
                LINE (14, 440)-(625, 450), 0, BF
                PaddleX = 281: Paddle = 0
                LocateMOUSE 308, 440
                PUT (PaddleX, 440), PaddleBOX(), PSET
                BallX = 310: BallY = 60: Start = 1
                BincX = 0: BincY = 0

                Lives = Lives - 1
                Lives$ = LTRIM$(STR$(Lives))
                PrintSCORE 106, Lives$
                IF Lives = 0 THEN EndGAME

                Score = 0
                DEF SEG = VARSEG(BigBOX(1))
                BLOAD "ponggops.bsv", VARPTR(BigBOX(1))
                DEF SEG
                PUT (246, 230), BigBOX(), PSET
            END IF
    END SELECT

    WAIT &H3DA, 8
    WAIT &H3DA, 8, 8

    OUT &H3C8, 2
    OUT &H3C9, 50
    OUT &H3C9, 10
    OUT &H3C9, 50
    OUT &H3C8, 3
    OUT &H3C9, 50
    OUT &H3C9, 10
    OUT &H3C9, 50

    PUT (BallX, BallY), BackBOX(), PSET

    IF BincY = 0 THEN BincY = 2
    IF BincX > 10 OR BincX < -10 THEN BincY = BincY + 1

    IF BincX > 8 THEN BincX = BincX - 1
    IF BincY > 8 THEN BincY = BincY - 1
    IF BincX < -8 THEN BincX = BincX + 1
    IF BincY < -8 THEN BincY = BincY + 1

    BallX = BallX + BincX: BallY = BallY + BincY 'Update X/Y's
    IF BallX < 13 THEN BallX = 14: GOSUB NEON: BincX = ABS(BincX) + 1
    IF BallX > 608 THEN BallX = 607: GOSUB NEON: BincX = -ABS(BincX) - 1
    IF BallY < 60 THEN BallY = 60
    IF BallY > 439 AND BincY < 0 THEN BallY = 438

    IF BallY < 400 THEN
        GET (BallX, BallY)-(BallX + 20, BallY + 20), BackBOX()
    ELSE
        GET (310, 60)-(330, 80), BackBOX()
    END IF
    PUT (BallX, BallY), BallBOX(201), AND
    PUT (BallX, BallY), BallBOX(), OR

    IF BallY < 167 THEN
        IF BallX < 130 THEN 'LEFT Accelerator
            BallCX = BallX + 10: BallCY = BallY + 10
            IF BallCX > 67 THEN 'right half
                DiffX = BallCX - 67
                Q1 = 1
            ELSE
                DiffX = 67 - BallCX 'left half
                Q1 = 2
            END IF
            IF BallCY > 126 THEN 'lower half
                DiffY = BallCY - 126
                Q2 = 4
            ELSE 'upper half
                DiffY = 126 - BallCY
                Q2 = 8
            END IF
            IF SQR(DiffX ^ 2 + DiffY ^ 2) <= 37 THEN
                Quadrant = Q1 + Q2
                SELECT CASE Quadrant
                    CASE 5 'lower right
                        BincX = ABS(BincX) + 4
                        BincY = -ABS(BincY) + 1
                    CASE 6 'lower left
                        BincX = -ABS(BincX) - 1
                        BincY = ABS(BincY) + INT(RND * 2)
                    CASE 9 'upper right
                        BincX = ABS(BincX) + 3
                        BincY = ABS(BincY)
                    CASE 10 'upper left
                        BincX = ABS(BincX) + 3
                        BincY = ABS(BincY)
                END SELECT
                Score = 1
                GOSUB Accelerator1
            END IF
        END IF
        IF BallX > 495 THEN 'RIGHT Accelerator
            BallCX = BallX + 10: BallCY = BallY + 10
            IF BallCX > 565 THEN 'right half
                DiffX = BallCX - 565
                Q1 = 1
            ELSE
                DiffX = 565 - BallCX 'left half
                Q1 = 2
            END IF
            IF BallCY > 126 THEN 'bottom half
                DiffY = BallCY - 126
                Q2 = 4
            ELSE 'top half
                DiffY = 126 - BallCY
                Q2 = 8
            END IF
            IF SQR(DiffX ^ 2 + DiffY ^ 2) <= 37 THEN
                Quadrant = Q1 + Q2
                OldDIFF = Diff
                SELECT CASE Quadrant
                    CASE 5 'lower right
                        BincX = -ABS(BincX) - 4
                        BincY = -ABS(BincY) + 1
                    CASE 6 'lower left
                        BincX = -ABS(BincX) - 5
                        BincY = ABS(BincY) + INT(RND * 1)
                    CASE 9 'upper right
                        BincX = ABS(BincX) + 4
                        BincY = ABS(BincY)
                    CASE 10 'upper left
                        BincX = ABS(BincX) + 2
                        BincY = ABS(BincY)
                END SELECT
                GOSUB Accelerator2
                Score = 2
            END IF
        END IF
    END IF

    LINE (PaddleX, 440)-(PaddleX + 79, 450), 0, BF

    PaddleX = MouseX - 27
    PaddleX = PaddleX + Paddle
    IF PaddleX < 14 THEN PaddleX = 14
    IF PaddleX > 546 THEN PaddleX = 546
    PUT (PaddleX, 440), PaddleBOX(), PSET

LOOP

END

'------------------------------- SUBROUTINES ---------------------------------

NEON:
PLAY "MBMST220L64O1B"
OUT &H3C8, 13
OUT &H3C9, 0
OUT &H3C9, 63
OUT &H3C9, 0
WAIT &H3DA, 8
WAIT &H3DA, 8, 8
OUT &H3C8, 13
OUT &H3C9, 42
OUT &H3C9, 42
OUT &H3C9, 42
RETURN

Accelerator1:
OUT &H3C8, 3
OUT &H3C9, 63
OUT &H3C9, 50
OUT &H3C9, 63
WAIT &H3DA, 8
GOSUB AcceleratorSOUND
RETURN

Accelerator2:
OUT &H3C8, 2
OUT &H3C9, 63
OUT &H3C9, 50
OUT &H3C9, 63
WAIT &H3DA, 8
GOSUB AcceleratorSOUND
RETURN

AcceleratorSOUND:
Hz = 620
FOR Reps = 1 TO 3
    Hz = Hz + 100
    SOUND Hz, Hz / 3000
NEXT Reps
RETURN

PaletteDATA:
DATA 12, 2, 22, 50, 37, 63, 40, 10, 50, 40, 10, 50
DATA 53, 0, 0, 19, 2, 22, 17, 2, 22, 42, 42, 42
DATA 55, 55, 55, 16, 9, 26, 15, 2, 22, 63, 55, 55
DATA 25, 12, 35, 42, 42, 42, 55, 63, 9, 63, 63, 63

REM $STATIC
SUB ClearMOUSE
SHARED LB

WHILE LB
    MouseSTATUS LB, RB, MouseX, MouseY
WEND

END SUB

SUB DrawSCREEN

DEF SEG = VARSEG(BigBOX(1))
FOR y = 0 TO 320 STEP 160
    FileNUM = FileNUM + 1
    FileNAME$ = "pongg" + LTRIM$(STR$(FileNUM)) + ".bsv"
    BLOAD FileNAME$, VARPTR(BigBOX(1))
    PUT (0, y), BigBOX()
NEXT y
DEF SEG

DEF SEG = VARSEG(HeadBOX(1))
BLOAD "ponggnms.bsv", VARPTR(HeadBOX(1))
DEF SEG = VARSEG(PaddleBOX(1))
BLOAD "ponggpdl.bsv", VARPTR(PaddleBOX(1))
DEF SEG = VARSEG(BigBOX(1))
PUT (281, 440), PaddleBOX(), PSET
DEF SEG = VARSEG(BallBOX(1))
BLOAD "ponggbal.bsv", VARPTR(BallBOX(1))

DEF SEG = VARSEG(BigBOX(1))
BLOAD "ponggops.bsv", VARPTR(BigBOX(1))
DEF SEG

PUT (246, 230), BigBOX(), PSET
DEF SEG = VARSEG(FontBOX(0))
BLOAD "pongg2.fbs", VARPTR(FontBOX(0))
DEF SEG

END SUB

SUB EndGAME
SHARED Lives, LB
STATIC MenuY

SelectSCREEN:
IF PlayerBOX(6).PlayerSCORE > PlayerBOX(5).PlayerSCORE THEN
    GetSCORE = 1
    DEF SEG = VARSEG(BigBOX(1))
    BLOAD "pongggo1.bsv", VARPTR(BigBOX(1)) 'GO1 = Game Over 1 (3 options)
    DEF SEG
    PUT (233, 220), BigBOX(), PSET
ELSE
    DEF SEG = VARSEG(BigBOX(1))
    BLOAD "pongggo2.bsv", VARPTR(BigBOX(1)) 'GO2 = Game Over 2 (2 options)
    DEF SEG
    PUT (233, 220), BigBOX(), PSET
END IF
MenuY = 256
GET (262, 256)-(374, 273), BigBOX(7001)
LocateMOUSE 320, 310
ShowMOUSE
DO
    MouseSTATUS LB, RB, MouseX, MouseY
    SELECT CASE MouseX
        CASE 266 TO 378
            SELECT CASE MouseY
                CASE 256 TO 273
                    IF Menu <> 1 THEN
                        HideMOUSE
                        PUT (262, MenuY), BigBOX(7001), PSET
                        GET (262, 256)-(374, 273), BigBOX(7001)
                        MenuY = 256
                        PLAY "MBMST220L64O6B"
                        PUT (262, 256), BigBOX(4001), PSET
                        ShowMOUSE
                        Menu = 1
                    END IF
                    IF LB THEN
                        IF GetSCORE THEN
                            GOSUB Topper
                            GOTO SelectSCREEN
                        ELSE
                            EXIT DO
                        END IF
                    END IF
                CASE 274 TO 291
                    IF Menu <> 2 THEN
                        HideMOUSE
                        PUT (262, MenuY), BigBOX(7001), PSET
                        GET (262, 274)-(374, 291), BigBOX(7001)
                        MenuY = 274
                        PLAY "MBMST220L64O6B"
                        PUT (262, 274), BigBOX(5001), PSET
                        ShowMOUSE
                        Menu = 2
                    END IF
                    IF LB THEN
                        IF GetSCORE THEN
                            EXIT DO
                        ELSE
                            HideMOUSE
                            CLS
                            SYSTEM
                        END IF
                    END IF
                CASE 292 TO 309
                    IF Menu <> 3 AND GetSCORE THEN
                        HideMOUSE
                        PUT (262, MenuY), BigBOX(7001), PSET
                        GET (262, 292)-(374, 309), BigBOX(7001)
                        MenuY = 292
                        PLAY "MBMST220L64O6B"
                        PUT (262, 292), BigBOX(6001), PSET
                        ShowMOUSE
                        Menu = 3
                    END IF
                    IF LB AND GetSCORE THEN
                        HideMOUSE
                        CLS
                        SYSTEM
                    END IF
            END SELECT
    END SELECT
    PauseMOUSE LB, RB, MouseX, MouseY
LOOP
Lives = 5
PlayerBOX(6).PlayerSCORE = 0
PrintSCORE 106, "5"
PrintSCORE 582, "000000"
HideMOUSE
DEF SEG = VARSEG(BigBOX(1))
BLOAD "ponggbak.bsv", VARPTR(BigBOX(1))
DEF SEG
PUT (198, 178), BigBOX(), PSET
DO
    MouseSTATUS LB, RB, MouseX, MouseY
LOOP UNTIL LB
ClearMOUSE

EXIT SUB

'--------------------------------SUBROUTINES----------------------------------

Topper:

DEF SEG = VARSEG(BigBOX(1))
BLOAD "ponggbak.bsv", VARPTR(BigBOX(1))
DEF SEG
HideMOUSE
PUT (198, 178), BigBOX(), PSET

LINE (208, 198)-(428, 267), 8, BF
LINE (210, 200)-(426, 265), 15, B
LINE (218, 225)-(418, 257), 7, BF

PrintSTRING 264, 206, "Please enter your name:", 0
LINE (250, 253)-(254, 254), 15, B
x = 250

DO
    DO
        k$ = INKEY$
    LOOP UNTIL k$ <> ""
    SELECT CASE k$
        CASE CHR$(8) 'Backspace
            IF CharCOUNT THEN
                LINE (x, 253)-(x + 4, 254), 7, B
                LINE (CharBOX(CharCOUNT), 235)-(x, 255), 7, BF
                Name$ = LEFT$(Name$, LEN(Name$) - 1)
                x = CharBOX(CharCOUNT)
                LINE (x, 253)-(x + 4, 254), 15, B
                CharCOUNT = CharCOUNT - 1
            END IF
        CASE CHR$(13) 'Enter
            LINE (x, 253)-(x + 4, 254), 7, B
            PlayerBOX(6).PlayerNAME = Name$
            PlayerBOX(6).PlayDATE = DATE$
            EXIT DO
        CASE CHR$(27) 'Escape key
            CLS
            SYSTEM
        CASE ELSE
            IF LEN(Name$) < 20 THEN
                IF k$ = CHR$(34) THEN k$ = "'"
                Name$ = Name$ + k$
                LINE (x, 253)-(x + 4, 254), 7, B
                CharCOUNT = CharCOUNT + 1
                CharBOX(CharCOUNT) = x
                PrintSTRING x, 235, k$, 0
                LINE (x, 253)-(x + 4, 254), 15, B
            END IF
    END SELECT
LOOP
FOR a = 1 TO 6
    FOR B = a TO 6
        IF PlayerBOX(B).PlayerSCORE > PlayerBOX(a).PlayerSCORE THEN SWAP PlayerBOX(B), PlayerBOX(a)
    NEXT B
NEXT a
OPEN "pongg.top" FOR OUTPUT AS #1
FOR n = 1 TO 5
    WRITE #1, PlayerBOX(n).PlayerNAME, PlayerBOX(n).PlayerSCORE, PlayerBOX(n).PlayDATE
NEXT n
CLOSE #1
TopFIVE
Menu = 0: GetSCORE = 0
RETURN

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

DEFSNG A-Z
SUB Interval (Length!)

OldTimer# = TIMER
DO: LOOP UNTIL TIMER > OldTimer# + Length!
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
CALL ABSOLUTE_MOUSE_EMU (LBLBLBLBLBLBLBLB,  RB RB RB RB RB RB RB RB,  MX Mx MX MX MX mX MX MX,  MY My MY MY MY mY MY MY) 

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

SUB PrintSCORE (x, n$)

FOR n = 1 TO LEN(n$)
    Digit$ = MID$(n$, n, 1)
    NumSTART = VAL(Digit$) * 100 + 1
    PUT (x, 21), HeadBOX(NumSTART), PSET
    x = x + 7
NEXT n

END SUB

SUB PrintSTRING (x, y, Prnt$, Mode)

FOR i = 1 TO LEN(Prnt$)
    Char$ = MID$(Prnt$, i, 1)
    IF Char$ = " " THEN
        x = x + FontBOX(1)
    ELSE
        Index = (ASC(Char$) - 33) * FontBOX(0) + 2
        PUT (x, y), FontBOX(Index)
        x = x + FontBOX(Index)
    END IF
    IF Mode AND x > 300 THEN EXIT SUB
NEXT i

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

SUB TopFIVE

DEF SEG = VARSEG(BigBOX(1))
BLOAD "ponggtfv.bsv", VARPTR(BigBOX(1))
DEF SEG
PUT (198, 178), BigBOX(), PSET
TopY = 210
FOR n = 1 TO 5
    IF PlayerBOX(n).PlayerSCORE <> 0 THEN
        PrintSTRING 215, TopY, RTRIM$(PlayerBOX(n).PlayerNAME), 1
        PrintSTRING 320, TopY, LTRIM$(STR$(PlayerBOX(n).PlayerSCORE)), 0
        PrintSTRING 370, TopY, PlayerBOX(n).PlayDATE, 0
    END IF
    TopY = TopY + 21
NEXT n
DO
    k$ = INKEY$
LOOP UNTIL k$ <> ""
IF k$ = CHR$(27) THEN CLS: SYSTEM
DEF SEG = VARSEG(BigBOX(1))
BLOAD "ponggbak.bsv", VARPTR(BigBOX(1))
DEF SEG
PUT (198, 178), BigBOX(), PSET

END SUB
 
SUB ABSOLUTE_MOUSE_EMU (AX%, BX%, CX%, DX%)
SELECT CASE AX%
 CASE 0
 AX% = -1
 CASE 1
 _MOUSESHOW 
 CASE 2
 _MOUSEHIDE
 CASE 3
 WHILE _MOUSEINPUT
 WEND
 BX% = -_MOUSEBUTTON(1) - _MOUSEBUTTON(2) * 2 - _MOUSEBUTTON(3) * 4
 CX% = _MOUSEX
 DX% = _MOUSEY
 CASE 4
 _MOUSEMOVE CX%, DX% 'Not currently supported in QB64 GL
END SELECT
END SUB
