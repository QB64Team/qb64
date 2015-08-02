DECLARE SUB ErrorDialog ()
DECLARE SUB NewFile ()
DECLARE SUB PutTileBG ()
DECLARE FUNCTION Menu% ()
DECLARE SUB EditLevel (Lvl%)
DECLARE SUB RestoreColors ()
DECLARE SUB HideBuild ()
DECLARE SUB ReadRGB (C%, R%, G%, B%)
DECLARE SUB SaveColors ()
DECLARE SUB OpenFile (File$)
DECLARE FUNCTION Confirmsave% (File$, Lvl%)
DECLARE SUB PrintFonts (X%, Y%, N$)
DECLARE SUB Printnum (X%, Y%, N$)
DECLARE SUB DrawStatusArea ()
DECLARE SUB InitColors ()
DECLARE FUNCTION FastKB% ()
DECLARE SUB DrawLevelBG (BGMode%, ColorStep%, ColorAttr%)
DECLARE SUB WriteRGB (C%, R%, G%, B%)
DECLARE SUB DrawSpike (X%, Y%)
DECLARE SUB DrawTile (X%, Y%, Clr%)
DECLARE SUB GetTileBackGround ()
DECLARE SUB DrawBorder ()
DECLARE SUB EditTile ()
DECLARE SUB SaveFile (File$)
DECLARE SUB InitFonts ()
DECLARE SUB InitNums ()
DEFINT A-Z

'==========Type declarations====================================
TYPE TileType
        X       AS INTEGER
        Y       AS INTEGER
        C       AS INTEGER
END TYPE
TYPE RGBtype
        R AS INTEGER
        G AS INTEGER
        B AS INTEGER
END TYPE

'$DYNAMIC


'====================Constants==================================
'Misc Const
CONST False = 0, True = NOT False

'Screen const
CONST MinX = 0, MaxX = 260, MinY = 0, MaxY = 200

'KeyConstants
CONST KRight = 77, KLeft = 75, KDown = 80, Kup = 72, KEsc = 1
CONST KW = &H11, KA = &H1E, KS = &H1F, KD = &H20, KPGD = &H51
CONST KSpc = &H39, KEnt = &H1C, KDel = &H53, KF5 = &H3F
CONST KTab = &HF


'Color Const
CONST BorderMin = 40, Bordermax = 47
CONST SpikeMin = 50, SpikeMax = 57
CONST TcolorMin = 60, TcolorMax = 93
CONST FColorMin = 96, FcolorMax = 100
CONST SnColorMin = 101, SnColorMax = 105

'Offset and Tile Const
CONST OffsetBG = 122    'TileY=19(0 to 180/6), TileX=12(0 to 220/20)
CONST TileMax = 227 '0 to 227
CONST TileW = 19, TileH = 5   ' 0 to 19, 0 to 5 (20*6)

'Font constant
CONST FontOffset = 12  'Size of SmallFonts



'==================Shared Arrays===================
DIM SHARED BackGround(27816)  AS INTEGER'BackGround for erasing tiles
DIM SHARED TBG(122) AS INTEGER
DIM SHARED Tile(TileMax) AS TileType
DIM SHARED SavRGB(0 TO 255) AS RGBtype
DIM SHARED SavRGBlvl(130 TO 193) AS RGBtype

'==================Shared Variables================
DIM SHARED Finished
DIM SHARED TX, TY, TCC, Tidx, Lvl, ColorAttr
'==================Non-Global Arrays===============
DIM SmallFonts(396) AS INTEGER
DIM SmallNum(132) AS INTEGER


DIM SHARED Path$

RANDOMIZE TIMER

CLS
SCREEN 13

'Path$ = "C:\qbasic\Arqanoid\"
Path$ = ""

ON ERROR GOTO ErrorHand


ColorAttr = 1 + INT(RND * 7)
ColorStep = 1 + INT(RND * 80)
Lvl = 0

InitColors

TX = 0
TY = 0
TCC = 1
Tidx = 0


SaveColors

HideBuild
InitFonts
InitNums


DrawLevelBG 1, ColorStep, ColorAttr

GetTileBackGround

DrawStatusArea


RestoreColors


'GOTO Temp
Finished = False

DO
        EditTile

LOOP UNTIL Finished

C$ = INPUT$(1)

CLS
SCREEN 0

END


ErrorHand:

RESUME NEXT





'=============temp===================


'====================================

Temp:


END

REM $STATIC
FUNCTION Confirmsave (File$, Lvl) STATIC

Confirmsave = False

DIM Temp(4500)

        GET (30, 140)-STEP(200, 35), Temp
        LINE (30, 140)-STEP(200, 35), 0, BF
        LINE (30, 140)-STEP(200, 35), 14, B
        PrintFonts 35, 152, "are you sure you want to save? Y,N:"

        DO
                PrintFonts 80, 142, "@@@@ Warning!!! @@@@"
                K$ = ""
                K$ = INKEY$
                SELECT CASE UCASE$(K$)
                        CASE "Y"
                                EXIT DO
                        CASE "N"
                                EXIT DO
                        CASE ELSE
                END SELECT

                        FOR DD = 0 TO 1
                        FOR D! = 0 TO 32500: NEXT D!
                        NEXT DD
                                LINE (80, 142)-STEP(106, 5), 0, BF  'Blink
                        FOR DD = 0 TO 1
                        FOR D! = 0 TO 32500: NEXT D!
                        NEXT DD
        LOOP UNTIL UCASE$(K$) = "Y" OR UCASE$(K$) = "N"

SELECT CASE UCASE$(K$)
        CASE "Y"
                GOSUB EnterFileName
                File$ = Path$ + "Levels\" + "QbNoid" + RTRIM$(LTRIM$(STR$(Lvl))) + "." + "LVL"
                PUT (30, 140), Temp, PSET

                EXIT FUNCTION
        CASE "N"
                Confirmsave = False
                PUT (30, 140), Temp, PSET
        CASE ELSE
END SELECT


EXIT FUNCTION

EnterFileName:
        PrintFonts 55, 162, "Enter LevelName:"
        PrintFonts 135, 162, "QbNoid  .Lvl"
        Ok = False

        Printnum 160, 162, LTRIM$(STR$(Lvl))

        DO
                K$ = INPUT$(1)
                SELECT CASE FastKB
                        CASE Kup
                                IF Lvl < 50 THEN Lvl = Lvl + 1
                                LINE (170, 162)-STEP(10, 5), 0, BF
                                Printnum 160, 162, LTRIM$(STR$(Lvl))
                        CASE KDown
                                IF Lvl > 1 THEN Lvl = Lvl - 1
                                LINE (170, 162)-STEP(10, 5), 0, BF
                                Printnum 160, 162, LTRIM$(STR$(Lvl))
                        CASE KEsc
                                Ok = True
                                Confirmsave = False
                        CASE KEnt
                                Ok = True
                                Confirmsave = True
                        CASE ELSE
                END SELECT
        LOOP UNTIL Ok
RETURN


END FUNCTION

SUB DrawBorder STATIC

FOR I = 0 TO 6
        LINE (I, I)-(260 - I, 200 - I), BorderMin + I, B
NEXT I

END SUB

SUB DrawLevelBG (BGMode, ColorStep, ColorAttr) STATIC




Clr = 145

FOR Y = 0 TO 199 STEP 5
    FOR X = 0 TO 320 STEP 5

        IF CC = 0 THEN
            Clr = Clr + ColorStep
        ELSE
            Clr = Clr - ColorStep
        END IF
        IF BGMode = 1 THEN
                LINE (X, Y)-(X + 4, Y + 4), Clr, BF
                LINE (X + 1, Y + 1)-(X + 3, Y + 3), Clr + 5, BF
                LINE (X + 1, Y + 1)-(X + 1, Y + 1), Clr + 11, BF
        ELSE
                LINE (X, Y)-(X + 4, Y + 4), Clr, B
                LINE (X + 1, Y + 1)-(X + 3, Y + 3), Clr + 5, B
                LINE (X + 1, Y + 1)-(X + 1, Y + 1), Clr + 11, B
        END IF
        IF Clr >= 180 THEN CC = 1
        IF Clr <= 150 THEN CC = 0
    NEXT X
NEXT Y

'Erase RightSide for Info,Scores,Etc.

LINE (MaxX, MinY)-(320, 200), 255, BF
LINE (0, 200)-(320, 200), 255, BF

'Draw Spikes

FOR X = 5 TO 250 STEP 10
        DrawSpike X, 205
NEXT X

DrawBorder

END SUB

SUB DrawSpike (X, Y) STATIC

FOR I = 1 TO 5
       LINE (X + I, Y)-STEP(0, -(I * 4.5)), SpikeMax - I
       LINE ((X + 10) - I, Y)-STEP(0, -(I * 4.5)), SpikeMax - I
NEXT I


END SUB

SUB DrawStatusArea STATIC

PrintFonts 256, 0, "Qbnoid level"
PrintFonts 263, 10, "Designer"
PrintFonts 263, 20, "Beta Test"
PrintFonts 268, 30, "Ver"
Printnum 286, 30, "007"

PrintFonts 256, 45, "Directions:"

PrintFonts 256, 60, "Movement:"
Printnum 260, 70, "0"
PrintFonts 270, 70, "Arrows"

PrintFonts 256, 80, "Rot Color:"
Printnum 260, 90, "0"
PrintFonts 270, 90, "Space"

PrintFonts 256, 100, "Put tile:"
Printnum 260, 110, "0"
PrintFonts 270, 110, "Tab,Enter"


PrintFonts 256, 120, "Erasetile:"
Printnum 260, 130, "0"
PrintFonts 270, 130, "Delete"


PrintFonts 256, 140, "Save:"
Printnum 260, 150, "0"
PrintFonts 270, 150, "FS:FFive"


PrintFonts 256, 160, "Exit:"
Printnum 260, 170, "0"
PrintFonts 270, 170, "Escape"

PrintFonts 256, 182, "TileType:"
Printnum 300, 182, "0"

PrintFonts 270, 194, ":relsoft:"




END SUB

SUB DrawTile (X, Y, Clr)
        SELECT CASE Clr
                CASE 1
                        TB = 60
                        TC = 61
                        TM = 62
                CASE 2
                        TB = 63
                        TC = 64
                        TM = 65
                CASE 3
                        TB = 66
                        TC = 67
                        TM = 68
                CASE 4
                        TB = 69
                        TC = 70
                        TM = 71
                CASE 5
                        TB = 72
                        TC = 73
                        TM = 74
                CASE 6
                        TB = 75
                        TC = 76
                        TM = 77
                CASE 7
                        TB = 78
                        TC = 79
                        TM = 80
                CASE 8
                        TB = 81
                        TC = 82
                        TM = 83
                CASE 9
                        TB = 84
                        TC = 85
                        TM = 86
                CASE ELSE
        END SELECT


        LINE (X, Y)-STEP(TileW, TileH), TC, BF
        LINE (X, Y)-STEP(TileW, TileH), TM, B
        LINE (X, Y)-STEP(0, TileH), TB
        LINE (X, Y + TileH)-STEP(TileW - 1, 0), TB


END SUB

SUB EditLevel (Lvl) STATIC

DIM Temp(2000)
GET (53, 149)-(203, 170), Temp
LINE (54, 150)-(203, 170), 0, BF
LINE (54, 150)-(203, 170), 14, B

PrintFonts 95, 152, "Edit Level"
PrintFonts 55, 162, "Enter LevelName:"
PrintFonts 135, 162, "QbNoid  .Lvl"
Ok = False

Printnum 160, 162, (STR$(Lvl))

DO
        K$ = INPUT$(1)
        SELECT CASE FastKB
                CASE Kup
                        IF Lvl < 50 THEN Lvl = Lvl + 1
                                LINE (170, 162)-STEP(10, 5), 0, BF
                                Printnum 160, 162, (STR$(Lvl))

                CASE KDown
                        IF Lvl > 1 THEN Lvl = Lvl - 1
                                LINE (170, 162)-STEP(10, 5), 0, BF
                                Printnum 160, 162, (STR$(Lvl))
                CASE KEsc
                        Ok = True
                        PUT (53, 149), Temp, PSET
                CASE KEnt
                        Ok = True
                        PutTileBG
                        PUT (53, 149), Temp, PSET
                        OpenFile Path$ + "levels\" + "qbnoid" + LTRIM$(STR$(Lvl)) + "." + "lvl"
                CASE ELSE
        END SELECT
LOOP UNTIL Ok


END SUB

SUB EditTile
'227


OldTX = TX
OldTY = TY

GOSUB GetBG
GOSUB DrawT

DO

CD = CD MOD 1595 + 1
IF CD = 1 THEN
        CC = CC MOD 7 + 1
END IF
        LINE (10 + (TX * 20), 10 + (TY * 6))-STEP(TileW, TileH), CC + BorderMin, B

LOOP WHILE INKEY$ = ""

GOSUB PutBG



SELECT CASE FastKB
        CASE KRight, KD
                IF TX < 11 THEN
                        TX = TX + 1
                        IF Tidx < 227 THEN Tidx = Tidx + 1
                END IF
        CASE KLeft, KA
                IF TX > 0 THEN
                        TX = TX - 1
                        IF Tidx > 0 THEN Tidx = Tidx - 1
                END IF
        CASE KDown, KS
                IF TY < 18 THEN
                        TY = TY + 1
                        IF Tidx <= 227 - 12 THEN Tidx = Tidx + 12
                END IF
        CASE Kup, KW
                IF TY > 0 THEN
                        TY = TY - 1
                        IF Tidx >= 12 THEN Tidx = Tidx - 12
                END IF
        CASE KSpc
                TCC = (TCC MOD 9) + 1
                Printnum 305, 182, LTRIM$(STR$(TCC))
                GOSUB DrawT
                GOSUB PutBG
        CASE KEnt, KTab
                GOSUB DrawT
                Tile(Tidx).X = 10 + TX * 20
                Tile(Tidx).Y = 10 + TY * 6
                Tile(Tidx).C = TCC
        CASE KDel
                GOSUB EraseTile
                Tile(Tidx).X = 0
                Tile(Tidx).Y = 0
                Tile(Tidx).C = 0
        CASE KF5
                'Save
                Con = Confirmsave(File$, Lvl)
                DIM Temp(2000)
                GET (50, 40)-STEP(159, 15), Temp
                LINE (50, 40)-STEP(159, 15), 0, BF
                LINE (50, 40)-STEP(159, 15), 14, B
                        IF Con = True THEN
                                SaveFile File$
                                PrintFonts 55, 45, "File Saved as:"
                                PrintFonts 130, 45, "QbNoid  .Lvl"
                                Printnum 160, 45, LTRIM$(STR$(Lvl))
                                Con = False
                        ELSE
                                PrintFonts 55, 45, "File UnSaved "
                                PrintFonts 130, 45, "Press A key"
                        END IF
                X$ = INPUT$(1)
                PUT (50, 40), Temp, PSET

        CASE KEsc
                SELECT CASE Menu
                        CASE 1
                                NewFile
                        CASE 2
                                EditLevel Lvl
                        CASE 3
                                'Esc do nothing
                        CASE 4
                                Finished = True
                        CASE ELSE
                END SELECT
        CASE ELSE

END SELECT



EXIT SUB

DrawT:
        DrawTile 10 + (TX * 20), 10 + (TY * 6), TCC
RETURN

GetBG:
        GET (INT(10 + (TX * 20)), INT(10 + (TY * 6)))-STEP(19, 5), TBG
RETURN

PutBG:
        PUT (INT(10 + (OldTX * 20)), INT(10 + (OldTY * 6))), TBG, PSET
RETURN

EraseTile:
        PUT (INT(10 + (TX * 20)), INT(10 + (TY * 6))), BackGround(OffsetBG * Tidx), PSET
RETURN


END SUB

SUB ErrorDialog

X = 60
Y = 40

DIM Temp(5000)

GET (X, Y)-STEP(150, 60), Temp


LINE (X, Y)-STEP(150, 60), 0, BF

LINE (X, Y)-STEP(150, 60), 14, B

Number = ERR

SELECT CASE Number


        CASE IS = 52

                PrintFonts X + 50, Y + 2, "Error!!!!!"
                PrintFonts X + 20, Y + 25, "File does not exist!!!!"
                PrintFonts X + 35, Y + 52, "Press Any key..."
        CASE ELSE
                PrintFonts X + 50, Y + 2, "Error!!!!!"
                PrintFonts X + 37, Y + 25, "Unknown Error!"
                Printnum X + 60, Y + 35, (LTRIM$(RTRIM$(STR$(ERR))))
                PrintFonts X + 35, Y + 52, "Press Any key..."

END SELECT


PUT (X, Y), Temp

END SUB

FUNCTION FastKB STATIC
        FastKB = INP(&H60)
        DO WHILE LEN(INKEY$): LOOP
END FUNCTION

SUB GetTileBackGround STATIC

I = 0
FOR Y = 0 TO 108 STEP 6
        FOR X = 0 TO 220 STEP 20
                GET (10 + X, 10 + Y)-STEP(19, 5), BackGround(OffsetBG * I)
                I = I + 1
        NEXT X
NEXT Y


END SUB

SUB HideBuild
FOR I = 0 TO 255
        R = 0
        G = 0
        B = 0
        WriteRGB I, R, G, B
NEXT I

END SUB

SUB InitColors STATIC

       WriteRGB 254, 63, 63, 63

'Color for Border============================================
R = 25
G = 25
B = 40

FOR I = BorderMin TO Bordermax
IF I <= BorderMin + 3 THEN
        R = R + 5
        G = G + 3
ELSE
        R = R - 5
        G = G - 3
END IF

        WriteRGB I, R, G, B
NEXT I

'FontColors================================
R = 63
G = 63
B = 63

FOR I = FColorMin TO FcolorMax
        R = R - 7
        B = B - 7
        WriteRGB I, R, G, B
NEXT I

'SmallNum colors============================
R = 63
G = 63
B = 63

FOR I = SnColorMin TO SnColorMax
        R = R - 7
        G = G - 7
        WriteRGB I, R, G, B
NEXT I

'Tile Colors=================================

'60-93

FOR I = TcolorMin TO TcolorMax
        II = II MOD 3 + 1

        IF II = 1 THEN
                IC = IC MOD 9 + 1
        END IF
        SELECT CASE II
                CASE 1
                        R = 10: G = 10: B = 10    'Dark Borders
                CASE 2
                        R = 30: G = 30: B = 30    'Tilecolor
                CASE 3
                        R = 50: G = 50: B = 50    'Light Borders
                CASE ELSE
        END SELECT
        'Tile color
        SELECT CASE IC
                CASE 1
                        G = 0
                        B = 0
                CASE 2
                        R = 0
                        B = 0
                CASE 3
                        R = 0
                        G = 0
                CASE 4
                        R = 0
                CASE 5
                        G = 0
                CASE 6
                        B = 0
                CASE 7
                        R = 25
                CASE 8
                        G = 25
                CASE 9
                        B = 25
                CASE ELSE
        END SELECT

        WriteRGB I, R, G, B
NEXT I

'BackGround Colors==============================================
I = 0

FOR I = 130 TO 193
        SELECT CASE ColorAttr
        CASE 1      'Red
               SavRGB(I).R = I \ 2
               SavRGB(I).G = 0
               SavRGB(I).B = 0
        CASE 2      'Green
               SavRGB(I).R = 0
               SavRGB(I).G = I \ 2
               SavRGB(I).B = 0

        CASE 3      'Blue
               SavRGB(I).R = 0
               SavRGB(I).G = 0
               SavRGB(I).B = I \ 2

        CASE 4      'Yellow
               SavRGB(I).R = I \ 2
               SavRGB(I).G = I \ 2
               SavRGB(I).B = 0

        CASE 5      'Purple
               SavRGB(I).R = I \ 2
               SavRGB(I).G = 0
               SavRGB(I).B = I \ 2

        CASE 6      'Metallic Blue
               SavRGB(I).R = 0
               SavRGB(I).G = I \ 2
               SavRGB(I).B = I \ 2

        CASE 7      'White
               SavRGB(I).R = I \ 2
               SavRGB(I).G = I \ 2
               SavRGB(I).B = I \ 2

        CASE ELSE
               SavRGB(I).R = I \ 2
               SavRGB(I).G = I \ 2
               SavRGB(I).B = I \ 2
        END SELECT

NEXT I
I = 0
FOR I = 130 TO 193
        WriteRGB I, SavRGB(I).R, SavRGB(I).G, SavRGB(I).B
NEXT I

END SUB

SUB InitFonts STATIC

SHARED SmallFonts() AS INTEGER
CLS
OPEN Path$ + "images\" + "small.fnt" FOR INPUT AS #1

INPUT #1, Maxfont



'Small numbers 0 to 4 height, 0 to 3 wide

FOR I = 1 TO Maxfont
        FOR Y = 0 TO 4
                 JC = JC MOD 5 + 1
        FOR X = 0 TO 3
                INPUT #1, J
                 IF J <> 0 THEN
                         PSET (X + XX, Y), JC + (FColorMin - 1)
                 END IF
        NEXT X
        NEXT Y
        XX = XX + 5
NEXT I

CLOSE

NI = 0
X = 0
Y = 0
FOR I = 1 TO Maxfont
        GET (X, Y)-STEP(3, 4), SmallFonts(NI * FontOffset%)
        NI = NI + 1
        X = X + 5
NEXT I


END SUB

SUB InitNums STATIC
SHARED SmallNum() AS INTEGER
CLS

OPEN Path$ + "images\" + "smallnum.fnt" FOR INPUT AS #1

INPUT #1, MaxNum


'Small numbers 0 to 4 height, 0 to 3 wide
FOR I = 1 TO MaxNum
        FOR Y = 0 TO 4
                 JC = JC MOD 5 + 1
        FOR X = 0 TO 3
                INPUT #1, J
                 IF J <> 0 THEN
                         PSET (X + XX, Y), JC + (SnColorMin - 1)
                 END IF
        NEXT X
        NEXT Y
        XX = XX + 5
NEXT I

CLOSE

NI = 0
X = 0
Y = 0
FOR I = 1 TO 11
        GET (X, Y)-STEP(3, 4), SmallNum(NI * FontOffset)
        NI = NI + 1
        X = X + 5
NEXT I


END SUB

FUNCTION Menu

DIM Temp(2100)
GET (93, 43)-(167, 96), Temp

LINE (95, 43)-(167, 96), 0, BF
LINE (95, 43)-(167, 96), 14, B

PrintFonts 110, 46, "Menu:"
PrintFonts 95, 55, "N: New File"
PrintFonts 95, 65, "E: Edit File"
PrintFonts 95, 75, "ESC: EXitMenu"
PrintFonts 95, 85, "X: Exit LVDES"

Temp$ = "N" + "E" + CHR$(27) + "X"
DO
        K$ = UCASE$(INPUT$(1))

        M = INSTR(Temp$, K$)

LOOP UNTIL M > 0

PUT (93, 43), Temp, PSET

Menu = M

END FUNCTION

SUB NewFile STATIC

Lvl = 0

PutTileBG

'Refresh
FOR I = 0 TO TileMax
        Tile(I).X = 0
        Tile(I).Y = 0
        Tile(I).C = 0
NEXT I


END SUB

SUB OpenFile (File$) STATIC

OPEN File$ FOR INPUT AS #1

FOR I = 0 TO TileMax
        INPUT #1, Tile(I).X
        INPUT #1, Tile(I).Y
        INPUT #1, Tile(I).C
NEXT I

CLOSE


FOR I = 0 TO TileMax
        IF Tile(I).C <> 0 THEN
                DrawTile Tile(I).X, Tile(I).Y, Tile(I).C
        END IF
NEXT I


END SUB

SUB PrintFonts (X, Y, N$) STATIC

SHARED SmallFonts() AS INTEGER

N$ = LTRIM$(RTRIM$(UCASE$(N$)))

Letter$ = "@.,:!?ABCDEFGHIJKLMNOPQRSTUVWXYZ "


FOR I = 1 TO LEN(N$)
        II$ = MID$(N$, I, 1)
        OffSet = INSTR(Letter$, II$)
        PUT ((I * 5) + X, Y), SmallFonts((OffSet - 1) * FontOffset), PSET
NEXT I

END SUB

SUB Printnum (X, Y, N$) STATIC
SHARED SmallNum() AS INTEGER

FOR I = 1 TO LEN(N$)
        II$ = MID$(N$, I, 1)
        OffSet = INSTR("1234567890,", II$)
        PUT ((I * 5) + X, Y), SmallNum((OffSet - 1) * FontOffset), PSET
NEXT I

END SUB

SUB PutTileBG STATIC
Y = 0
X = 0
I = 0
FOR Y = 0 TO 108 STEP 6
        FOR X = 0 TO 220 STEP 20
                PUT (10 + X, 10 + Y), BackGround(OffsetBG * I), PSET
                I = I + 1
        NEXT X
NEXT Y

END SUB

SUB ReadRGB (C%, R%, G%, B%)

OUT &H3C7, C%
R% = INP(&H3C9)
G% = INP(&H3C9)
B% = INP(&H3C9)

END SUB

SUB RestoreColors


FOR II = 0 TO 63

FOR I = 0 TO 255

        ReadRGB I, RR, GG, BB
                R = SavRGB(I).R
                G = SavRGB(I).G
                B = SavRGB(I).B

        IF R > RR THEN
                RR = RR + 1
        ELSEIF R < RR THEN
                RR = RR - 1
        ELSE
                'Do nothing
        END IF

        IF G > GG THEN
                GG = GG + 1
        ELSEIF G < GG THEN
                GG = GG - 1
        ELSE
                'Do nothing
        END IF

        IF B > BB THEN
                BB = BB + 1
        ELSEIF B < BB THEN
                BB = BB - 1
        ELSE
                'Do nothing
        END IF

        WriteRGB I, RR, GG, BB

NEXT I
NEXT II



END SUB

SUB SaveColors

FOR I = 0 TO 255
        ReadRGB I, R, G, B
        SavRGB(I).R = R
        SavRGB(I).G = G
        SavRGB(I).B = B
NEXT I


END SUB

SUB SaveFile (File$) STATIC


OPEN File$ FOR OUTPUT AS #1

FOR I = 0 TO TileMax
        PRINT #1, Tile(I).X
        PRINT #1, Tile(I).Y
        PRINT #1, Tile(I).C
NEXT I

CLOSE

END SUB

SUB WriteRGB (C%, R%, G%, B%)

OUT &H3C8, C%

OUT &H3C9, R%
OUT &H3C9, G%
OUT &H3C9, B%

END SUB

