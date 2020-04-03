CHDIR ".\programs\samples\thebob\chopper"

'                                                                  같       '
'                     같                                          같�       '
'            같같같 같�                                           같�       '
'           같같같� 같�                                           같�       '
'          같�  같  같�               같     같                   같�       '
'         같�   같  같  같       같 같같   같같      같�    같 같 같        '
'       같같        같 같�   같같같 같같   같같    같같   같같같� 같        '
'       같같       같 같같  같� 같같같같� 같같같  같 같   같같같  같        '
'       께�        께께께�  께  께 께께께께께께께 께께�   께께    께        '
'        께   께� 께� 께� 께�  께  께 께� 께 께께께께 께께께     께         '
'        께  께�  께�  께  께� 께  께� 께 께� 께 께� 께 께께     께�        '
'        께께께   께   께  께께�   께께�  께께�  께께께   께     께께       '
'                      께          께께   께께                    께        '
'                                  께     께                                '
'                                 께�    께�                                '
'                                 께     께                                 '
'                                                                           '
'         CHOPPER.BAS - Copyright (C) 2005 by Bob Seguin (Freeware)         '
'                                                                           '
'***************************************************************************'

DEFINT A-Z

DECLARE FUNCTION InitMOUSE ()
DECLARE FUNCTION Seeker (x, y, Mode)

DECLARE SUB MouseSTATUS (LB, RB, MouseX, MouseY)
DECLARE SUB ShowMOUSE ()
DECLARE SUB HideMOUSE ()
DECLARE SUB LocateMOUSE (x, y)
DECLARE SUB FieldMOUSE (x1, y1, x2, y2)
DECLARE SUB PauseMOUSE (LB, RB, MouseX, MouseY)
DECLARE SUB ClearMOUSE ()

DECLARE SUB MouseDRIVER (LB, RB, MX, MY)

DECLARE SUB PrintSTRING (x, y, Prnt$)

DECLARE SUB SetPALETTE ()
DECLARE SUB FourBIT (x1, y1, x2, y2, FileNAME$)
DECLARE SUB LoadIMAGE (x, y, FileNAME$)
DECLARE SUB LoadFILE (FileNAME$)
DECLARE SUB LoadBSI (x, y, FileNAME$)
DECLARE SUB ClearBOX ()

DECLARE SUB Interval (Length!)
DECLARE SUB ChopperIDE ()
DECLARE SUB Tire (x, y, Outer, Inner)
DECLARE SUB Tread (x, y, Radius, StartDEG, StopDEG, Colr)
DECLARE SUB ProjectMENU ()
DECLARE SUB HelpMENU ()
DECLARE SUB HiLIGHT ()
DECLARE SUB DeLIGHT ()
DECLARE SUB MenuBAR (InOUT)
DECLARE SUB LoadPHASE ()
DECLARE SUB Assembly1 ()
DECLARE SUB Assembly2 ()
DECLARE SUB Assembly3 ()
DECLARE SUB HandleBARS (InOUT)
DECLARE SUB PaintSHOP (Mode)

'----------------------------------------------------------------------------
'$DYNAMIC

DIM SHARED Box(26000)
DIM SHARED MenuBOX(500)
DIM SHARED MenuBOX2(500)
DIM SHARED MenuBOX3(4000)
DIM SHARED CustomCOLORS(9, 20)
DIM SHARED FChar(1 TO 124)

DIM SHARED MouseDATA$
DIM SHARED LB, RB, MouseX, MouseY
DIM SHARED Menu, TopMENU, Phase, Item, BarBOX, PaintITEM
DIM SHARED BikeCOLOR, FlameSTYLE, MenuITEM

CONST Degree! = 3.14159 / 180

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

DEF SEG = VARSEG(CustomCOLORS(0, 0))
BLOAD "chcolors.bsv", VARPTR(CustomCOLORS(0, 0))
DEF SEG

SCREEN 12

BikeCOLOR = 3
FlameSTYLE = 1
SetPALETTE

ChopperIDE
LocateMOUSE 319, 120
ShowMOUSE

DO
    MouseSTATUS LB, RB, MouseX, MouseY

    SELECT CASE MenuITEM
        CASE 1: ProjectMENU
        CASE 2: HelpMENU
    END SELECT

    SELECT CASE MouseY
        CASE 32 TO 46: MenuBAR 1
        CASE 294 TO 479
            SELECT CASE Phase
                CASE IS < 8: Assembly1
                CASE 8 TO 20: Assembly2
                CASE 21: HandleBARS 1
                CASE 22 TO 24: Assembly3
                CASE 25: PaintSHOP 1
            END SELECT
        CASE ELSE
            IF TopMENU THEN MenuBAR 0
            IF Item THEN DeLIGHT
            IF BarBOX THEN HandleBARS 0
            IF PaintITEM THEN PaintSHOP 0
    END SELECT

    IF Splash = 0 AND MouseY < 60 THEN
        LINE (146, 154)-(493, 356), 0, BF
        LINE (146, 288)-(493, 293), 1, BF
        LINE (146, 288)-(493, 288), 2, BF
        LINE (146, 293)-(493, 293), 5, BF
        LINE (146, 252)-(493, 280), 2, BF
        SetPALETTE
        Splash = 1
    END IF

    ClearMOUSE
    LoadPHASE
LOOP

END '************************** PALETTE DATA ********************************

PaletteDATA:
DATA 4, 2, 12, 6, 4, 14, 12, 12, 20
DATA 31, 31, 38, 46, 46, 50, 0, 0, 0

CustomCOLORS:
DATA 6,7,8,10,12,13,14

FlameCOLOR:
DATA 63, 63, 63, 63, 32, 12, 63, 52, 0
SilverCOLOR:
DATA 63, 63, 63, 38, 38, 35, 53, 53, 48
GoldCOLOR:
DATA 63, 63, 42, 63, 42, 21, 63, 52, 32
WhiteCOLOR:
DATA 63, 63, 63, 48, 48, 53, 53, 53, 58

REM $STATIC
SUB Assembly1
SHARED ItemX, ItemY, Choice, Frame, Extension, FrameCOLOR
SHARED ForkX, ForkY, WheelFX, WheelFY, WheelRX, WheelRY, BarX, BarY
SHARED OuterRADIUS, InnerRADIUS, FrontINDEX, RearINDEX, FrameX, FrameY

SELECT CASE Phase
    CASE 1
        SELECT CASE MouseX
            CASE 116 TO 310
                IF Item <> 1 THEN
                    DeLIGHT
                    ItemX = 156: ItemY = 452
                    HiLIGHT
                    Item = 1
                END IF
            CASE 330 TO 523
                IF Item <> 2 THEN
                    DeLIGHT
                    ItemX = 390: ItemY = 452
                    HiLIGHT
                    Item = 2
                END IF
            CASE ELSE
                DeLIGHT
        END SELECT
    CASE 2
        SELECT CASE MouseX
            CASE 20 TO 234
                IF Item <> 3 THEN
                    DeLIGHT
                    ItemX = 90: ItemY = 430
                    HiLIGHT
                    Item = 3
                END IF
            CASE 255 TO 384
                IF Item <> 4 THEN
                    DeLIGHT
                    ItemX = 271: ItemY = 430
                    HiLIGHT
                    Item = 4
                END IF
            CASE 405 TO 560
                IF Item <> 5 THEN
                    DeLIGHT
                    ItemX = 431: ItemY = 430
                    HiLIGHT
                    Item = 5
                END IF
            CASE ELSE
                DeLIGHT
        END SELECT
    CASE 3
        SELECT CASE MouseX
            CASE 110 TO 240
                IF Item <> 6 THEN
                    DeLIGHT
                    ItemX = 112: ItemY = 440
                    HiLIGHT
                    Item = 6
                END IF
            CASE 260 TO 390
                IF Item <> 7 THEN
                    DeLIGHT
                    ItemX = 270: ItemY = 440
                    HiLIGHT
                    Item = 7
                END IF
            CASE 410 TO 540
                IF Item <> 8 THEN
                    DeLIGHT
                    ItemX = 420: ItemY = 440
                    HiLIGHT
                    Item = 8
                END IF
        END SELECT
    CASE 4
        IF Extension = 1 OR Extension = 2 THEN
            SELECT CASE MouseX
                CASE 40 TO 150
                    IF Item <> 9 THEN
                        DeLIGHT
                        ItemX = 40: ItemY = 445
                        HiLIGHT
                        Item = 9
                    END IF
                CASE 170 TO 280
                    IF Item <> 10 THEN
                        DeLIGHT
                        ItemX = 180: ItemY = 445
                        HiLIGHT
                        Item = 10
                    END IF
                CASE 340 TO 450
                    IF Item <> 11 THEN
                        DeLIGHT
                        ItemX = 330: ItemY = 445
                        HiLIGHT
                        Item = 11
                    END IF
                CASE 470 TO 600
                    IF Item <> 12 THEN
                        DeLIGHT
                        ItemX = 470: ItemY = 445
                        HiLIGHT
                        Item = 12
                    END IF
                CASE ELSE
                    DeLIGHT
            END SELECT
        ELSE
            SELECT CASE MouseX
                CASE 20 TO 138
                    IF Item <> 13 THEN
                        DeLIGHT
                        ItemX = 12: ItemY = 445
                        HiLIGHT
                        Item = 13
                    END IF
                CASE 139 TO 232
                    IF Item <> 14 THEN
                        DeLIGHT
                        ItemX = 140: ItemY = 445
                        HiLIGHT
                        Item = 14
                    END IF
                CASE 264 TO 386
                    IF Item <> 15 THEN
                        DeLIGHT
                        ItemX = 250: ItemY = 445
                        HiLIGHT
                        Item = 15
                    END IF
                CASE 387 TO 490
                    IF Item <> 16 THEN
                        DeLIGHT
                        ItemX = 372: ItemY = 445
                        HiLIGHT
                        Item = 16
                    END IF
                CASE 491 TO 600
                    IF Item <> 17 THEN
                        DeLIGHT
                        ItemX = 490: ItemY = 445
                        HiLIGHT
                        Item = 17
                    END IF
                CASE ELSE
                    DeLIGHT
            END SELECT
        END IF
    CASE 5
        SELECT CASE MouseX
            CASE 80 TO 198
                IF Item <> 18 THEN
                    DeLIGHT
                    ItemX = 70: ItemY = 440
                    HiLIGHT
                    Item = 18
                END IF
            CASE 199 TO 318
                IF Item <> 19 THEN
                    DeLIGHT
                    ItemX = 190: ItemY = 440
                    HiLIGHT
                    Item = 19
                END IF
            CASE 319 TO 438
                IF Item <> 20 THEN
                    DeLIGHT
                    ItemX = 320: ItemY = 440
                    HiLIGHT
                    Item = 20
                END IF
            CASE 439 TO 560
                IF Item <> 21 THEN
                    DeLIGHT
                    ItemX = 440: ItemY = 440
                    HiLIGHT
                    Item = 21
                END IF
            CASE ELSE
                DeLIGHT
        END SELECT
    CASE 6
        SELECT CASE MouseX
            CASE 80 TO 198
                IF Item <> 22 THEN
                    DeLIGHT
                    ItemX = 70: ItemY = 440
                    HiLIGHT
                    Item = 22
                END IF
            CASE 199 TO 318
                IF Item <> 23 THEN
                    DeLIGHT
                    ItemX = 190: ItemY = 440
                    HiLIGHT
                    Item = 23
                END IF
            CASE 319 TO 438
                IF Item <> 24 THEN
                    DeLIGHT
                    ItemX = 320: ItemY = 440
                    HiLIGHT
                    Item = 24
                END IF
            CASE 439 TO 560
                IF Item <> 25 THEN
                    DeLIGHT
                    ItemX = 440: ItemY = 440
                    HiLIGHT
                    Item = 25
                END IF
            CASE ELSE
                DeLIGHT
        END SELECT
    CASE 7
        SELECT CASE MouseX
            CASE 70 TO 169
                IF Item <> 26 THEN
                    DeLIGHT
                    ItemX = 50: ItemY = 442
                    HiLIGHT
                    Item = 26
                END IF
            CASE 170 TO 269
                IF Item <> 27 THEN
                    DeLIGHT
                    ItemX = 150: ItemY = 442
                    HiLIGHT
                    Item = 27
                END IF
            CASE 270 TO 369
                IF Item <> 28 THEN
                    DeLIGHT
                    ItemX = 250: ItemY = 442
                    HiLIGHT
                    Item = 28
                END IF
            CASE 370 TO 469
                IF Item <> 29 THEN
                    DeLIGHT
                    ItemX = 350: ItemY = 442
                    HiLIGHT
                    Item = 29
                END IF
            CASE 470 TO 569
                IF Item <> 30 THEN
                    DeLIGHT
                    ItemX = 450: ItemY = 442
                    HiLIGHT
                    Item = 30
                END IF
            CASE ELSE
                DeLIGHT
        END SELECT
END SELECT

IF LB = -1 AND Item <> 0 THEN
    SELECT CASE Item
        CASE 1, 2
            Frame = Item
            DeLIGHT
            Phase = 2
        CASE 3, 4, 5
            FrameCOLOR = Item - 2
            DeLIGHT
            Phase = 3
        CASE 6, 7, 8
            Extension = Item - 5
            DeLIGHT
            GOSUB SetFRAME
            DeLIGHT
        CASE 9 TO 17
            GOSUB SetFORK
        CASE 18 TO 21
            GOSUB SetTIREF
            Phase = 6
        CASE 22 TO 25
            GOSUB SetTIRER
            Phase = 7
        CASE 26 TO 30
            GOSUB SetWHEELS
            Phase = 8
    END SELECT
END IF

EXIT SUB

'************************* SUBROUTINE SECTION BEGINS ************************

SetFRAME:
HideMOUSE
SELECT CASE Frame
    CASE 1
        SELECT CASE Extension
            CASE 1
                IF FrameCOLOR = 1 THEN LoadIMAGE 255, 130, "CHFrmRP": LoadFILE "CHNkRP"
                IF FrameCOLOR = 2 THEN LoadIMAGE 255, 130, "CHFrmRB": LoadFILE "CHNkRB"
                IF FrameCOLOR = 3 THEN LoadIMAGE 255, 130, "CHFrmRC": LoadFILE "CHNkRC"
                FrameX = 245: FrameY = 115
                PUT (247, 125), Box(), AND
                PUT (247, 125), Box(150)
                CIRCLE (270, 262), 6, 5, , , .3
                PAINT STEP(0, 0), 5
                DRAW "U nR40 D R40 D L40"
                PSET (316, 258), 5: DRAW "R120 F L121"
                PSET (316, 266), 5: DRAW "R126 F L127"
                LINE (310, 258)-(318, 262), 5, BF
                LINE (311, 263)-(319, 267), 5, BF
                LINE (380, 258)-(388, 262), 5, BF
                LINE (382, 263)-(390, 267), 5, BF
            CASE 2
                IF FrameCOLOR = 1 THEN LoadIMAGE 261, 130, "CHFrmRP": LoadFILE "CHNkXP"
                IF FrameCOLOR = 2 THEN LoadIMAGE 261, 130, "CHFrmRB": LoadFILE "CHNkXB"
                IF FrameCOLOR = 3 THEN LoadIMAGE 261, 130, "CHFrmRC": LoadFILE "CHNkXC"
                FrameX = 251: FrameY = 115
                PUT (252, 124), Box(), AND
                PUT (252, 124), Box(150)
                CIRCLE (270, 262), 6, 5, , , .3
                PAINT STEP(0, 0), 5
                DRAW "U nR47 D R47 D L47"
                PSET (324, 258), 5: DRAW "R120 F L121"
                PSET (324, 266), 5: DRAW "R126 F L127"
                LINE (316, 258)-(324, 262), 5, BF
                LINE (318, 263)-(326, 267), 5, BF
                LINE (386, 258)-(394, 262), 5, BF
                LINE (389, 263)-(396, 267), 5, BF
            CASE 3
                IF FrameCOLOR = 1 THEN LoadIMAGE 275, 130, "CHFrmRP": LoadFILE "CHNkXXP"
                IF FrameCOLOR = 2 THEN LoadIMAGE 275, 130, "CHFrmRB": LoadFILE "CHNkXXB"
                IF FrameCOLOR = 3 THEN LoadIMAGE 275, 130, "CHFrmRC": LoadFILE "CHNkXXC"
                FrameX = 265: FrameY = 115
                PUT (267, 125), Box(), AND
                PUT (267, 125), Box(150)
                CIRCLE (270, 262), 6, 5, , , .3
                PAINT STEP(0, 0), 5
                DRAW "U nR65 D R65 D L65"
                PSET (339, 258), 5: DRAW "R120 F L121"
                PSET (339, 266), 5: DRAW "R126 F L127"
                LINE (331, 258)-(339, 262), 5, BF
                LINE (333, 263)-(341, 267), 5, BF
                LINE (401, 258)-(409, 262), 5, BF
                LINE (404, 263)-(411, 267), 5, BF
        END SELECT
    CASE 2
        SELECT CASE Extension
            CASE 1
                IF FrameCOLOR = 1 THEN LoadIMAGE 250, 126, "CHFrmXP": LoadFILE "CHNkRP"
                IF FrameCOLOR = 2 THEN LoadIMAGE 250, 126, "CHFrmXB": LoadFILE "CHNkRB"
                IF FrameCOLOR = 3 THEN LoadIMAGE 250, 126, "CHFrmXC": LoadFILE "CHNkRC"
                FrameX = 250: FrameY = 126: DropSHADOW = 0
                PUT (245, 124), Box(), AND
                PUT (245, 124), Box(150)
                CIRCLE (270, 262), 6, 5, , , .3
                PAINT STEP(0, 0), 5
                DRAW "U nR50 D R50 D L50"
                PSET (324, 258), 5: DRAW "R130 F L131"
                PSET (324, 266), 5: DRAW "R136 F L137"
                LINE (316, 258)-(324, 262), 5, BF
                LINE (317, 263)-(325, 267), 5, BF
                LINE (360, 258)-(396, 262), 5, BF
                LINE (362, 263)-(398, 267), 5, BF
            CASE 2
                IF FrameCOLOR = 1 THEN LoadIMAGE 256, 126, "CHFrmXP": LoadFILE "CHNkXP"
                IF FrameCOLOR = 2 THEN LoadIMAGE 256, 126, "CHFrmXB": LoadFILE "CHNkXB"
                IF FrameCOLOR = 3 THEN LoadIMAGE 256, 126, "CHFrmXC": LoadFILE "CHNkXC"
                FrameX = 256: FrameY = 126: DropSHADOW = 0
                PUT (251, 124), Box(), AND
                PUT (251, 124), Box(150)
                CIRCLE (276, 262), 6, 5, , , .3
                PAINT STEP(0, 0), 5
                DRAW "U nR50 D R50 D L50"
                PSET (328, 258), 5: DRAW "R130 F L131"
                PSET (328, 266), 5: DRAW "R136 F L137"
                LINE (324, 258)-(332, 262), 5, BF
                LINE (325, 263)-(333, 267), 5, BF
                LINE (368, 258)-(404, 262), 5, BF
                LINE (370, 263)-(406, 267), 5, BF
            CASE 3
                IF FrameCOLOR = 1 THEN LoadIMAGE 270, 126, "CHFrmXP": LoadFILE "CHNkXXP"
                IF FrameCOLOR = 2 THEN LoadIMAGE 270, 126, "CHFrmXB": LoadFILE "CHNkXXB"
                IF FrameCOLOR = 3 THEN LoadIMAGE 270, 126, "CHFrmXC": LoadFILE "CHNkXXC"
                FrameX = 270: FrameY = 126: DropSHADOW = 0
                PUT (265, 126), Box(), AND
                PUT (265, 126), Box(150)
                CIRCLE (278, 262), 6, 5, , , .3
                PAINT STEP(0, 0), 5
                DRAW "U nR58 D R58 D L58"
                PSET (338, 258), 5: DRAW "R130 F L131"
                PSET (338, 266), 5: DRAW "R138 F L139"
                LINE (333, 258)-(341, 262), 5, BF
                LINE (335, 263)-(343, 267), 5, BF
                LINE (380, 258)-(416, 262), 5, BF
                LINE (383, 263)-(419, 267), 5, BF
        END SELECT
END SELECT
ShowMOUSE
Phase = 4
RETURN

SetFORK:
IF Frame = 1 THEN
    SELECT CASE Extension
        CASE 1
            SELECT CASE Item
                CASE 9: LoadFILE "CHSprRP.BSI": ForkX = 194: ForkY = 108
                CASE 10: LoadFILE "CHSprRC.BSI": ForkX = 194: ForkY = 108
                CASE 11: LoadFILE "CHFrkGRP.BSI": ForkX = 203: ForkY = 114
                CASE 12: LoadFILE "CHFrkGRC.BSI": ForkX = 203: ForkY = 114
            END SELECT
        CASE 2
            SELECT CASE Item
                CASE 9: LoadFILE "CHSprXP.BSI": ForkX = 184: ForkY = 108
                CASE 10: LoadFILE "CHSprXC.BSI": ForkX = 184: ForkY = 108
                CASE 11: LoadFILE "CHFrkGXP.BSI": ForkX = 193: ForkY = 113
                CASE 12: LoadFILE "CHFrkGXC.BSI": ForkX = 193: ForkY = 113
            END SELECT
        CASE 3
            SELECT CASE Item
                CASE 13: LoadFILE "CHSprXXP.BSI": ForkX = 176: ForkY = 113
                CASE 14: LoadFILE "CHSprXXC.BSI": ForkX = 176: ForkY = 113
                CASE 15: LoadFILE "CHFrkXXP.BSI": ForkX = 183: ForkY = 116
                CASE 16: LoadFILE "CHFrkXXM.BSI": ForkX = 183: ForkY = 116
                CASE 17: LoadFILE "CHFrkXXC.BSI": ForkX = 183: ForkY = 116
            END SELECT
    END SELECT
ELSE
    SELECT CASE Extension
        CASE 1
            SELECT CASE Item
                CASE 9: LoadFILE "CHSprRP.BSI": ForkX = 192: ForkY = 108
                CASE 10: LoadFILE "CHSprRC.BSI": ForkX = 192: ForkY = 108
                CASE 11: LoadFILE "CHFrkGRP.BSI": ForkX = 203: ForkY = 114
                CASE 12: LoadFILE "CHFrkGRC.BSI": ForkX = 203: ForkY = 114
            END SELECT
        CASE 2
            SELECT CASE Item
                CASE 9: LoadFILE "CHSprXP.BSI": ForkX = 182: ForkY = 108
                CASE 10: LoadFILE "CHSprXC.BSI": ForkX = 182: ForkY = 108
                CASE 11: LoadFILE "CHFrkGXP.BSI": ForkX = 190: ForkY = 113
                CASE 12: LoadFILE "CHFrkGXC.BSI": ForkX = 190: ForkY = 113
            END SELECT
        CASE 3
            SELECT CASE Item
                CASE 13: LoadFILE "CHSprXXP.BSI": ForkX = 175: ForkY = 113
                CASE 14: LoadFILE "CHSprXXC.BSI": ForkX = 175: ForkY = 113
                CASE 15: LoadFILE "CHFrkXXP.BSI": ForkX = 181: ForkY = 116
                CASE 16: LoadFILE "CHFrkXXM.BSI": ForkX = 181: ForkY = 116
                CASE 17: LoadFILE "CHFrkXXC.BSI": ForkX = 181: ForkY = 116
            END SELECT
    END SELECT
END IF
HideMOUSE
PUT (ForkX + Box(0), ForkY + Box(1)), Box(3), AND
PUT (ForkX, ForkY), Box(Box(2))
PSET (ForkX + 12, 258), 5
SELECT CASE Extension
    CASE 1
        DRAW "R78 d9 L84 E R82 u7 L76 R64"
        LINE STEP(-10, 0)-STEP(24, 7), 5, BF
    CASE 2
        DRAW "R88 d9 L94 E R92 u7 L86 R74"
        LINE STEP(-10, 0)-STEP(24, 7), 5, BF
    CASE 3
        DRAW "R98 d9 L104 E R102 u7 L96 R84"
        LINE STEP(-10, 0)-STEP(24, 7), 5, BF
END SELECT
DeLIGHT
ShowMOUSE
Phase = 5
FOR x = 254 TO 300
    FOR y = 110 TO 130
        IF POINT(x, y) = 11 THEN
            BarX = x: BarY = y
            RETURN
        END IF
    NEXT y
NEXT x
RETURN

SetTIREF:
HideMOUSE
SELECT CASE ForkX
    CASE 176: WheelFX = 179: WheelFY = 217
    CASE 183: WheelFX = 188: WheelFY = 217
    CASE 184: WheelFX = 188: WheelFY = 217
    CASE 175: WheelFX = 178: WheelFY = 217 '
    CASE 181: WheelFX = 186: WheelFY = 217 '
    CASE 182: WheelFX = 186: WheelFY = 217 '
    CASE 193: WheelFX = 199: WheelFY = 217
    CASE 194: WheelFX = 197: WheelFY = 217
    CASE 190: WheelFX = 196: WheelFY = 217 '
    CASE 192: WheelFX = 195: WheelFY = 217 '
    CASE 203: WheelFX = 208: WheelFY = 217
    CASE 203: WheelFX = 208: WheelFY = 217 '
END SELECT
SELECT CASE Item
    CASE 18: InnerRADIUS = 38: FrontINDEX = 0
    CASE 19: InnerRADIUS = 35: FrontINDEX = 1800
    CASE 20: InnerRADIUS = 33: FrontINDEX = 3600
    CASE 21: InnerRADIUS = 30: FrontINDEX = 5400
END SELECT
Tire WheelFX - 100, WheelFY - 100, 48, InnerRADIUS
ShowMOUSE
DeLIGHT
RETURN

SetTIRER:
HideMOUSE
IF Frame = 1 THEN
    SELECT CASE Extension
        CASE 1: WheelRX = 435: WheelRY = 217
        CASE 2: WheelRX = 441: WheelRY = 217
        CASE 3: WheelRX = 455: WheelRY = 217
    END SELECT
    OuterRADIUS = 48
    SELECT CASE Item
        CASE 22: InnerRADIUS = 33: RearINDEX = 3600
        CASE 23: InnerRADIUS = 30: RearINDEX = 5400
        CASE 24: InnerRADIUS = 27: RearINDEX = 7200
        CASE 25: InnerRADIUS = 24: RearINDEX = 9000
    END SELECT
ELSE
    SELECT CASE Extension
        CASE 1: WheelRX = 440: WheelRY = 223
        CASE 2: WheelRX = 446: WheelRY = 223
        CASE 3: WheelRX = 460: WheelRY = 223
    END SELECT
    OuterRADIUS = 42
    SELECT CASE Item
        CASE 22: InnerRADIUS = 27: RearINDEX = 10800
        CASE 23: InnerRADIUS = 25: RearINDEX = 12600
        CASE 24: InnerRADIUS = 23: RearINDEX = 14400
        CASE 25: InnerRADIUS = 21: RearINDEX = 16200
    END SELECT
END IF
Tire WheelRX + 100, WheelRY - 100, OuterRADIUS, InnerRADIUS
DeLIGHT
ShowMOUSE
RETURN

SetWHEELS:
SELECT CASE Item
    CASE 26: File$ = "CHSpokes"
    CASE 27: File$ = "CHMag1"
    CASE 28: File$ = "CHMag2"
    CASE 29: File$ = "CHMag3"
    CASE 30: File$ = "CHMag4"
END SELECT
LoadFILE File$
HideMOUSE
PUT (WheelFX - 140, WheelFY - 140), Box(FrontINDEX), PSET
PUT (WheelRX + 60, WheelRY - 140), Box(RearINDEX), PSET
DeLIGHT
ShowMOUSE
RETURN

END SUB

SUB Assembly2
SHARED ItemX, ItemY, Choice, Frame, Extension, FrameCOLOR, Cover, Tank
SHARED ForkX, ForkY, WheelFX, WheelFY, WheelRX, WheelRY, BarX, BarY
SHARED OuterRADIUS, InnerRADIUS, FrontINDEX, RearINDEX, FrameX, FrameY
SHARED MotorSTYLE, HighMEG, HighPIPE, OT, LightX, LightY, FenderSTYLE
SHARED FFLX, FFRX, FFTY, FFBY, RFLX, RFRX, RFTY, RFBY, GPaint, TX, TY, TTY

SELECT CASE Phase
    CASE 8
        SELECT CASE MouseX
            CASE 95 TO 225
                IF Item <> 31 THEN
                    DeLIGHT
                    ItemX = 95: ItemY = 445
                    HiLIGHT
                    Item = 31
                END IF
            CASE 255 TO 385
                IF Item <> 32 THEN
                    DeLIGHT
                    ItemX = 255: ItemY = 445
                    HiLIGHT
                    Item = 32
                END IF
            CASE 415 TO 545
                IF Item <> 33 THEN
                    DeLIGHT
                    ItemX = 415: ItemY = 445
                    HiLIGHT
                    Item = 33
                END IF
            CASE ELSE
                DeLIGHT
        END SELECT
    CASE 9
        SELECT CASE MouseX
            CASE 135 TO 235
                IF Item <> 34 THEN
                    DeLIGHT
                    ItemX = 110: ItemY = 420
                    HiLIGHT
                    Item = 34
                END IF
            CASE 268 TO 368
                IF Item <> 35 THEN
                    DeLIGHT
                    ItemX = 246: ItemY = 420
                    HiLIGHT
                    Item = 35
                END IF
            CASE 400 TO 500
                IF Item <> 36 THEN
                    DeLIGHT
                    ItemX = 382: ItemY = 420
                    HiLIGHT
                    Item = 36
                END IF
            CASE ELSE
                DeLIGHT
        END SELECT
    CASE 10
        SELECT CASE MouseX
            CASE 124 TO 234
                IF Item <> 37 THEN
                    DeLIGHT
                    ItemX = 114: ItemY = 424
                    HiLIGHT
                    Item = 37
                END IF
            CASE 278 TO 358
                IF Item <> 38 THEN
                    DeLIGHT
                    ItemX = 268: ItemY = 424
                    HiLIGHT
                    Item = 38
                END IF
            CASE 406 TO 516
                IF Item <> 39 THEN
                    DeLIGHT
                    ItemX = 396: ItemY = 424
                    HiLIGHT
                    Item = 39
                END IF
            CASE ELSE
                DeLIGHT
        END SELECT
    CASE 11
        SELECT CASE MouseX
            CASE 120 TO 219
                IF Item <> 40 THEN
                    DeLIGHT
                    ItemX = 100: ItemY = 398
                    HiLIGHT
                    Item = 40
                END IF
            CASE 220 TO 319
                IF Item <> 41 THEN
                    DeLIGHT
                    ItemX = 210: ItemY = 398
                    HiLIGHT
                    Item = 41
                END IF
            CASE 320 TO 419
                IF Item <> 42 THEN
                    DeLIGHT
                    ItemX = 310: ItemY = 398
                    HiLIGHT
                    Item = 42
                END IF
            CASE 420 TO 519
                IF Item <> 43 THEN
                    DeLIGHT
                    ItemX = 420: ItemY = 398
                    HiLIGHT
                    Item = 43
                END IF
            CASE ELSE
                DeLIGHT
        END SELECT
    CASE 12
        SELECT CASE MouseX
            CASE 120 TO 219
                IF Item <> 44 THEN
                    DeLIGHT
                    ItemX = 100: ItemY = 398
                    HiLIGHT
                    Item = 44
                END IF
            CASE 220 TO 319
                IF Item <> 45 THEN
                    DeLIGHT
                    ItemX = 200: ItemY = 398
                    HiLIGHT
                    Item = 45
                END IF
            CASE 320 TO 419
                IF Item <> 46 THEN
                    DeLIGHT
                    ItemX = 300: ItemY = 398
                    HiLIGHT
                    Item = 46
                END IF
            CASE 420 TO 519
                IF Item <> 146 THEN
                    DeLIGHT
                    ItemX = 400: ItemY = 398
                    HiLIGHT
                    Item = 146
                END IF
            CASE ELSE
                DeLIGHT
        END SELECT
    CASE 13
        SELECT CASE MouseX
            CASE 110 TO 219
                IF Item <> 47 THEN
                    DeLIGHT
                    ItemX = 100: ItemY = 390
                    HiLIGHT
                    Item = 47
                END IF
            CASE 220 TO 329
                IF Item <> 48 THEN
                    DeLIGHT
                    ItemX = 220: ItemY = 390
                    HiLIGHT
                    Item = 48
                END IF
            CASE 330 TO 439
                IF Item <> 49 THEN
                    DeLIGHT
                    ItemX = 330: ItemY = 390
                    HiLIGHT
                    Item = 49
                END IF
            CASE 440 TO 549
                IF Item <> 50 THEN
                    DeLIGHT
                    ItemX = 430: ItemY = 390
                    HiLIGHT
                    Item = 50
                END IF
            CASE ELSE
                DeLIGHT
        END SELECT
    CASE 14
        SELECT CASE MouseX
            CASE 178 TO 308
                IF Item <> 51 THEN
                    DeLIGHT
                    ItemX = 178: ItemY = 408
                    HiLIGHT
                    Item = 51
                END IF
            CASE 338 TO 468
                IF Item <> 52 THEN
                    DeLIGHT
                    ItemX = 338: ItemY = 408
                    HiLIGHT
                    Item = 52
                END IF
            CASE ELSE
                DeLIGHT
        END SELECT
    CASE 15
        SELECT CASE MouseX
            CASE 90 TO 220
                IF Item <> 53 THEN
                    DeLIGHT
                    ItemX = 90: ItemY = 411
                    HiLIGHT
                    Item = 53
                END IF
            CASE 250 TO 380
                IF Item <> 54 THEN
                    DeLIGHT
                    ItemX = 250: ItemY = 411
                    HiLIGHT
                    Item = 54
                END IF
            CASE 412 TO 542
                IF Item <> 55 THEN
                    DeLIGHT
                    ItemX = 412: ItemY = 411
                    HiLIGHT
                    Item = 55
                END IF
            CASE ELSE
                DeLIGHT
        END SELECT
    CASE 16
        SELECT CASE MouseX
            CASE 40 TO 223
                IF Item <> 56 THEN
                    DeLIGHT
                    ItemX = 70: ItemY = 410
                    HiLIGHT
                    Item = 56
                END IF
            CASE 224 TO 409
                IF Item <> 57 THEN
                    DeLIGHT
                    ItemX = 250: ItemY = 410
                    HiLIGHT
                    Item = 57
                END IF
            CASE 410 TO 600
                IF Item <> 58 THEN
                    DeLIGHT
                    ItemX = 430: ItemY = 410
                    HiLIGHT
                    Item = 58
                END IF
            CASE ELSE
                DeLIGHT
        END SELECT
    CASE 17
        SELECT CASE MouseX
            CASE 50 TO 200
                IF Item <> 59 THEN
                    DeLIGHT
                    ItemX = 60: ItemY = 428
                    HiLIGHT
                    Item = 59
                END IF
            CASE 230 TO 380
                IF Item <> 60 THEN
                    DeLIGHT
                    ItemX = 240: ItemY = 428
                    HiLIGHT
                    Item = 60
                END IF
            CASE 410 TO 560
                IF Item <> 61 THEN
                    DeLIGHT
                    ItemX = 420: ItemY = 428
                    HiLIGHT
                    Item = 61
                END IF
            CASE ELSE
                DeLIGHT
        END SELECT
    CASE 18
        SELECT CASE MouseX
            CASE 65 TO 164
                IF Item <> 62 THEN
                    DeLIGHT
                    ItemX = 50: ItemY = 412
                    HiLIGHT
                    Item = 62
                END IF
            CASE 165 TO 264
                IF Item <> 63 THEN
                    DeLIGHT
                    ItemX = 150: ItemY = 412
                    HiLIGHT
                    Item = 63
                END IF
            CASE 265 TO 364
                IF Item <> 64 THEN
                    DeLIGHT
                    ItemX = 250: ItemY = 412
                    HiLIGHT
                    Item = 64
                END IF
            CASE 365 TO 464
                IF Item <> 65 THEN
                    DeLIGHT
                    ItemX = 350: ItemY = 412
                    HiLIGHT
                    Item = 65
                END IF
            CASE 465 TO 564
                IF Item <> 66 THEN
                    DeLIGHT
                    ItemX = 450: ItemY = 412
                    HiLIGHT
                    Item = 66
                END IF
            CASE ELSE
                DeLIGHT
        END SELECT
    CASE 19
        SELECT CASE MouseX
            CASE 60 TO 139
                IF Item <> 67 THEN
                    DeLIGHT
                    ItemX = 20: ItemY = 396
                    HiLIGHT
                    Item = 67
                END IF
            CASE 140 TO 219
                IF Item <> 68 THEN
                    DeLIGHT
                    ItemX = 125: ItemY = 396
                    HiLIGHT
                    Item = 68
                END IF
            CASE 240 TO 319
                IF Item <> 69 THEN
                    DeLIGHT
                    ItemX = 202: ItemY = 396
                    HiLIGHT
                    Item = 69
                END IF
            CASE 320 TO 399
                IF Item <> 70 THEN
                    DeLIGHT
                    ItemX = 304: ItemY = 396
                    HiLIGHT
                    Item = 70
                END IF
            CASE 420 TO 499
                IF Item <> 71 THEN
                    DeLIGHT
                    ItemX = 384: ItemY = 396
                    HiLIGHT
                    Item = 71
                END IF
            CASE 500 TO 579
                IF Item <> 72 THEN
                    DeLIGHT
                    ItemX = 490: ItemY = 396
                    HiLIGHT
                    Item = 72
                END IF
            CASE ELSE
                DeLIGHT
        END SELECT
    CASE 20
        SELECT CASE MouseX
            CASE 140 TO 219
                IF Item <> 67 THEN
                    DeLIGHT
                    ItemX = 100: ItemY = 396
                    HiLIGHT
                    Item = 67
                END IF
            CASE 220 TO 299
                IF Item <> 68 THEN
                    DeLIGHT
                    ItemX = 210: ItemY = 396
                    HiLIGHT
                    Item = 68
                END IF
            CASE 340 TO 419
                IF Item <> 69 THEN
                    DeLIGHT
                    ItemX = 290: ItemY = 396
                    HiLIGHT
                    Item = 69
                END IF
            CASE 420 TO 499
                IF Item <> 70 THEN
                    DeLIGHT
                    ItemX = 420: ItemY = 396
                    HiLIGHT
                    Item = 70
                END IF
            CASE ELSE
                DeLIGHT
        END SELECT
END SELECT

IF LB = -1 AND Item <> 0 THEN
    SELECT CASE Item
        CASE 31
            LoadFILE "CHFndrFS": GOSUB FrontWHEEL
            LoadFILE "CHFndrRS": GOSUB RearWHEEL
            FenderSTYLE = 1
            GOSUB Transfer
        CASE 32
            LoadFILE "CHFndrFC": GOSUB FrontWHEEL
            LoadFILE "CHFndrRC": GOSUB RearWHEEL
            FenderSTYLE = 2
            GOSUB Transfer
        CASE 33
            LoadFILE "CHFndrFF": GOSUB FrontWHEEL
            LoadFILE "CHFndrRF": GOSUB RearWHEEL
            FenderSTYLE = 3
            GOSUB Transfer
        CASE 34
            HideMOUSE
            IF Frame = 2 THEN
                GET (FrameX + 100, FrameY + 40)-STEP(20, 30), Box()
                PUT (FrameX + 70, FrameY + 25), Box(), PSET
                LINE (FrameX + 90, FrameY + 110)-STEP(40, 2), 0, BF
                CIRCLE (FrameX + 53, FrameY + 108), 3, 2
                PAINT STEP(0, 0), 4, 2
                CIRCLE (FrameX + 53, FrameY + 108), 2, 15, 0, 3
                LINE (FrameX + 50, FrameY + 101)-STEP(1, 1), 4, B
                CIRCLE (FrameX + 53, FrameY + 108), 3, 5, 3, 0
                LINE STEP(-2, 0)-STEP(4, 0), 3
            END IF
            LoadFILE "CHMtr750.BSI"
            MotorSTYLE = 1
            GOSUB InstallMOTOR
            DeLIGHT
            ShowMOUSE
            Phase = 15
        CASE 35
            HideMOUSE
            DeLIGHT
            ShowMOUSE
            MotorSTYLE = 2
            Phase = 10
        CASE 36
            HideMOUSE
            DeLIGHT
            ShowMOUSE
            MotorSTYLE = 3
            Phase = 10
        CASE 37
            IF MotorSTYLE = 2 THEN
                LoadFILE "CHMtrVKP.BSI"
            ELSE
                LoadFILE "CHMtrVBP.BSI"
            END IF
            GOSUB InstallMOTOR
        CASE 38
            IF MotorSTYLE = 2 THEN
                LoadFILE "CHMtrVKB.BSI"
            ELSE
                LoadFILE "CHMtrVBB.BSI"
            END IF
            GOSUB InstallMOTOR
        CASE 39
            IF MotorSTYLE = 2 THEN
                LoadFILE "CHMtrVKC.BSI"
            ELSE
                LoadFILE "CHMtrVBC.BSI"
            END IF
            GOSUB InstallMOTOR
        CASE 40
            HideMOUSE
            LoadBSI FrameX, FrameY, "CHDrvCH"
            LoadFILE "CHShdowD.BSI"
            PUT (FrameX + Box(0), 268), Box(3), AND
            PUT (FrameX + Box(0), 268), Box(Box(2))
            DeLIGHT
            ShowMOUSE
            Phase = 13
        CASE 41 TO 43
            HideMOUSE
            IF Item = 41 THEN LoadBSI FrameX, FrameY, "CHDrvBP"
            IF Item = 42 THEN LoadBSI FrameX, FrameY, "CHDrvBB"
            IF Item = 43 THEN LoadBSI FrameX, FrameY, "CHDrvBC"
            LoadFILE "CHShdowD.BSI"
            PUT (FrameX + Box(0), 268), Box(3), AND
            PUT (FrameX + Box(0), 268), Box(Box(2))
            DeLIGHT
            ShowMOUSE
            Phase = 12
        CASE 44, 45, 46, 146
            HideMOUSE
            IF Item = 44 THEN LoadBSI FrameX, FrameY, "CHDrvCP": Cover = 1
            IF Item = 45 THEN LoadBSI FrameX, FrameY, "CHDrvCB"
            IF Item = 46 THEN LoadBSI FrameX, FrameY, "CHDrvCC"
            DeLIGHT
            ShowMOUSE
            Phase = 13
        CASE 47 TO 50
            HideMOUSE
            IF Item = 47 THEN LoadBSI FrameX, FrameY, "CHBrthr3"
            IF Item = 48 THEN LoadBSI FrameX, FrameY, "CHBrthr4"
            IF Item = 49 THEN LoadBSI FrameX, FrameY, "CHBrthr1"
            IF Item = 50 THEN LoadBSI FrameX, FrameY, "CHBrthr2"
            DeLIGHT
            ShowMOUSE
            Phase = 14
        CASE 51, 52
            IF Frame = 1 THEN
                IF Item = 51 THEN FileNAME$ = "CHRDrRVC"
                IF Item = 52 THEN FileNAME$ = "CHRDrRVB"
            ELSE
                IF Item = 51 THEN FileNAME$ = "CHRDrXVC"
                IF Item = 52 THEN FileNAME$ = "CHRDrXVB"
            END IF
            HideMOUSE
            LoadBSI FrameX, FrameY, FileNAME$
            DeLIGHT
            ShowMOUSE
            Phase = 17
        CASE 53 TO 55
            IF Frame = 1 THEN
                IF Item = 53 THEN FileNAME$ = "CHRDrR7O"
                IF Item = 54 THEN FileNAME$ = "CHRDrR7P": GPaint = 1
                IF Item = 55 THEN FileNAME$ = "CHRDrR7C"
            ELSE
                IF Item = 53 THEN FileNAME$ = "CHRDrX7O"
                IF Item = 54 THEN FileNAME$ = "CHRDrX7P": GPaint = 1
                IF Item = 55 THEN FileNAME$ = "CHRDrX7C"
            END IF
            HideMOUSE
            LoadBSI FrameX, FrameY, FileNAME$
            DeLIGHT
            ShowMOUSE
            Phase = 16
        CASE 56 TO 58
            HideMOUSE
            IF Item = 56 THEN LoadBSI FrameX, FrameY, "CHExBLST"
            IF Item = 57 THEN LoadBSI FrameX, FrameY, "CHExBHMG": HighMEG = 1
            IF Item = 58 THEN LoadBSI FrameX, FrameY, "CHExBLMG"
            IF Frame = 1 THEN ShadowDROP = 11 ELSE ShadowDROP = 0
            LoadBSI FrameX, FrameY + ShadowDROP, "CHShdo7X"
            DeLIGHT
            ShowMOUSE
            Phase = 18
        CASE 59 TO 61
            HideMOUSE
            IF Item = 59 THEN LoadBSI FrameX, FrameY, "CHExVLMG": Extend = 0
            IF Item = 60 THEN LoadBSI FrameX, FrameY, "CHExVLSH": Extend = -20
            IF Item = 61 THEN LoadBSI FrameX, FrameY, "CHExVHOS": Extend = 60: HighPIPE = 1
            IF Frame = 1 THEN ShadowDROP = 11 ELSE ShadowDROP = 0
            LoadBSI FrameX + 12, FrameY + 44 + ShadowDROP, "CHShdoVX"
            LINE (FrameX + 120, FrameY + 143 + ShadowDROP)-(FrameX + 200 + Extend, FrameY + 147 + ShadowDROP), 5, BF
            DRAW "R5 H5 D5 R bU p5,5"
            DeLIGHT
            ShowMOUSE
            Phase = 18
        CASE 62 TO 66
            IF Frame = 1 THEN TankY = 5 ELSE TankY = 0
            HideMOUSE
            IF Item = 62 THEN
                LoadBSI FrameX, FrameY + TankY, "CHFTnkTD"
                Tank = 1: TX = 2: TY = 2 + TankY
                IF Frame = 1 THEN TTY = 5 ELSE TTY = 0
            END IF
            IF Item = 63 THEN
                LoadBSI FrameX, FrameY, "CHFTnkSC"
                TX = 4: Tank = 2: TY = 6 + TankY
                TTY = 0
            END IF
            IF Item = 64 THEN
                LoadBSI FrameX, FrameY + TankY, "CHFTnkOS"
                Tank = 3: TX = 0: TY = TankY
                IF Frame = 1 THEN TTY = 4 ELSE TTY = 0
            END IF
            IF Item = 65 THEN
                LoadBSI FrameX, FrameY + TankY, "CHFTnkCB"
                Tank = 4: TX = 10: TY = 3 + TankY
                IF Frame = 1 THEN TTY = 4 ELSE TTY = 0
            END IF
            IF Item = 66 THEN
                LoadBSI FrameX, FrameY + TankY, "CHFTnkBR"
                Tank = 5
                TX = 2
                TTY = 4
                IF Frame = 1 THEN TY = 12 ELSE TY = 7
                IF Frame = 1 THEN TTY = 4 ELSE TTY = 0
            END IF
            DeLIGHT
            ClearBOX
            IF MotorSTYLE = 1 AND Frame = 1 THEN
                Phase = 19
            ELSE
                Phase = 20
            END IF
            ShowMOUSE
        CASE 67 TO 72
            HideMOUSE
            IF Item = 67 THEN LoadBSI FrameX, FrameY, "CHOTnkHP": OT = 1
            IF Item = 68 THEN LoadBSI FrameX, FrameY, "CHOTnkHC": OT = 2
            IF Item = 69 THEN LoadBSI FrameX, FrameY, "CHOTnkCP": OT = 3
            IF Item = 70 THEN LoadBSI FrameX, FrameY, "CHOTnkCC": OT = 4
            IF Item = 71 THEN LoadBSI FrameX, FrameY, "CHOTnkBP": OT = 5
            IF Item = 72 THEN LoadBSI FrameX, FrameY, "CHOTnkBC": OT = 6
            IF HighMEG = 1 THEN
                LoadBSI FrameX, FrameY, "CHExBHMG"
                HighMEG = 0
            END IF
            DeLIGHT
            FOR x = BarX - 40 TO BarX - 10
                FOR y = BarY + 10 TO BarY + 40
                    IF POINT(x, y) = 14 THEN
                        LightX = x
                        LightY = y
                        PSET (x, y), 15
                        GOTO Continue
                    END IF
                NEXT y
            NEXT x
            Continue:
            ShowMOUSE
            Phase = 21
    END SELECT
END IF

EXIT SUB

'************************* SUBROUTINE SECTION BEGINS ************************

FrontWHEEL:
HideMOUSE
PUT (WheelFX - 153, WheelFY - 157), Box(3200), AND
PUT (WheelFX - 153, WheelFY - 157), Box()
ShowMOUSE
RETURN

RearWHEEL:
HideMOUSE
PUT (WheelRX + 45, WheelRY - 155), Box(3200), AND
PUT (WheelRX + 45, WheelRY - 155), Box()
DeLIGHT
ShowMOUSE
RETURN

Transfer:
HideMOUSE
LoadIMAGE 170, 80, "CHPrepAR"
LoadIMAGE 170, 80, "CHInstW"
FFLX = Seeker(WheelFX - 153, WheelFY - 157, 0)
FFRX = Seeker(WheelFX - 153, WheelFY - 157, 1)
FFTY = Seeker(WheelFX - 153, WheelFY - 157, 2)
FFBY = Seeker(WheelFX - 153, WheelFY - 157, 3)
OPEN "ff.dat" FOR OUTPUT AS #1
WRITE #1, FFLX + 100, FFRX - FFLX, FFTY + 100, FFBY - FFTY
FOR x = FFLX TO FFRX
    FOR y = FFTY TO FFBY
        IF POINT(x + 100, y + 100) = 0 THEN WRITE #1, 1 ELSE WRITE #1, 0
    NEXT y
NEXT x
CLOSE #1
PSET (WheelFX - 43, WheelFY + 48), 5
DRAW "R91 M+2,-5 L85 M-8,+5 R10 BU2 P5,5"
FOR x = WheelFX - 153 TO WheelFX - 43
    FOR y = WheelFY - 157 TO WheelFY - 47
        IF POINT(x, y) <> 0 THEN
            IF y < WheelFY - 72 THEN
                IF POINT(x + 100, y + 100) = 0 THEN
                    PSET (x + 100, y + 100), POINT(x, y)
                END IF
            ELSE
                PSET (x + 100, y + 100), POINT(x, y)
            END IF
            PSET (x, y), 0
        END IF
    NEXT y
NEXT x
RFLX = Seeker(WheelRX + 45, WheelRY - 157, 0)
RFRX = Seeker(WheelRX + 45, WheelRY - 157, 1)
RFTY = Seeker(WheelRX + 45, WheelRY - 157, 2)
RFBY = Seeker(WheelRX + 45, WheelRY - 157, 3)
OPEN "rf.dat" FOR OUTPUT AS #1
WRITE #1, RFLX - 100, RFRX - RFLX, RFTY + 100, RFBY - RFTY
FOR x = RFLX TO RFRX
    FOR y = RFTY TO RFBY
        IF POINT(x - 100, y + 100) = 0 THEN WRITE #1, 1 ELSE WRITE #1, 0
    NEXT y
NEXT x
CLOSE #1
IF Frame = 2 THEN
    PSET (WheelRX - 43, WheelRY + 42), 5
ELSE
    PSET (WheelRX - 43, WheelRY + 48), 5
END IF
DRAW "R91 M-8,-5 L88 F5 R20 BU3 P5,5"
FOR x = WheelRX + 45 TO WheelRX + 155
    FOR y = WheelRY - 155 TO WheelRY - 45
        IF POINT(x, y) <> 0 THEN
            IF y < WheelRY - 72 THEN
                IF POINT(x - 100, y + 100) = 0 THEN
                    PSET (x - 100, y + 100), POINT(x, y)
                END IF
            ELSE
                PSET (x - 100, y + 100), POINT(x, y)
            END IF
            PSET (x, y), 0
        END IF
    NEXT y
NEXT x
LoadIMAGE 170, 80, "CHInstW"
ShowMOUSE
Phase = 9
RETURN

InstallMOTOR:
HideMOUSE
PUT (FrameX + Box(0), FrameY + Box(1)), Box(3), AND
PUT (FrameX + Box(0), FrameY + Box(1)), Box(Box(2))
IF MotorSTYLE = 1 THEN
    LoadFILE "CHShdow7.BSI"
    PUT (FrameX + Box(0), 251), Box(3), AND
    PUT (FrameX + Box(0), 251), Box(Box(2))
ELSE
    IF Frame = 1 THEN
        SELECT CASE FrameCOLOR
            CASE 1: Colr1 = 6: Colr2 = 13
            CASE 2: Colr1 = 5: Colr2 = 2
            CASE 3: Colr1 = 4: Colr2 = 15
        END SELECT
        PSET (FrameX + Box(0) + 32, FrameY + Box(1)), Colr1
        DRAW "U8 M+4,+2 D6 L4 BE2 P" + LTRIM$(STR$(Colr1)) + "," + LTRIM$(STR$(Colr1))
        PSET (FrameX + Box(0) + 32, FrameY + Box(1)), Colr2
        DRAW "U7"
    END IF
    LoadBSI FrameX, FrameY, "CHLnkage"
    LoadFILE "CHShdowP.BSI"
    PUT (FrameX + Box(0), 254), Box(3), AND
    PUT (FrameX + Box(0), 254), Box(Box(2))
    LoadFILE "CHShdowV.BSI"
    PUT (FrameX + Box(0), 254), Box(3), AND
    PUT (FrameX + Box(0), 254), Box(Box(2))
END IF
DeLIGHT
IF MotorSTYLE > 1 THEN
END IF
ShowMOUSE
Phase = 11
RETURN

END SUB

SUB Assembly3
SHARED ItemX, ItemY, Choice, Frame, Extension, FrameCOLOR
SHARED ForkX, ForkY, WheelFX, WheelFY, WheelRX, WheelRY, BarX, BarY
SHARED OuterRADIUS, InnerRADIUS, FrontINDEX, RearINDEX, FrameX, FrameY
SHARED MotorSTYLE, HighMEG, HighPIPE, OT, LightX, LightY, FenderSTYLE
SHARED FFLX, FFRX, FFTY, FFBY, RFLX, RFRX, RFTY, RFBY

SELECT CASE Phase
    CASE 22
        SELECT CASE MouseX
            CASE 15 TO 114
                IF Item <> 73 THEN
                    DeLIGHT
                    ItemX = 12: ItemY = 406
                    HiLIGHT
                    Item = 73
                END IF
            CASE 115 TO 214
                IF Item <> 74 THEN
                    DeLIGHT
                    ItemX = 98: ItemY = 406
                    HiLIGHT
                    Item = 74
                END IF
            CASE 215 TO 314
                IF Item <> 75 THEN
                    DeLIGHT
                    ItemX = 200: ItemY = 406
                    HiLIGHT
                    Item = 75
                END IF
            CASE 315 TO 409
                IF Item <> 76 THEN
                    DeLIGHT
                    ItemX = 300: ItemY = 406
                    HiLIGHT
                    Item = 76
                END IF
            CASE 410 TO 519
                IF Item <> 77 THEN
                    DeLIGHT
                    ItemX = 400: ItemY = 406
                    HiLIGHT
                    Item = 77
                END IF
            CASE 520 TO 624
                IF Item <> 78 THEN
                    DeLIGHT
                    ItemX = 497: ItemY = 406
                    HiLIGHT
                    Item = 78
                END IF
            CASE ELSE
                DeLIGHT
        END SELECT
    CASE 23
        SELECT CASE MouseX
            CASE 60 TO 139
                IF Item <> 79 THEN
                    DeLIGHT
                    ItemX = 20: ItemY = 394
                    HiLIGHT
                    Item = 79
                END IF
            CASE 140 TO 219
                IF Item <> 80 THEN
                    DeLIGHT
                    ItemX = 126: ItemY = 394
                    HiLIGHT
                    Item = 80
                END IF
            CASE 240 TO 319
                IF Item <> 81 THEN
                    DeLIGHT
                    ItemX = 204: ItemY = 394
                    HiLIGHT
                    Item = 81
                END IF
            CASE 320 TO 399
                IF Item <> 82 THEN
                    DeLIGHT
                    ItemX = 306: ItemY = 394
                    HiLIGHT
                    Item = 82
                END IF
            CASE 420 TO 499
                IF Item <> 83 THEN
                    DeLIGHT
                    ItemX = 386: ItemY = 394
                    HiLIGHT
                    Item = 83
                END IF
            CASE 500 TO 580
                IF Item <> 84 THEN
                    DeLIGHT
                    ItemX = 486: ItemY = 394
                    HiLIGHT
                    Item = 84
                END IF
            CASE ELSE
                DeLIGHT
        END SELECT
    CASE 24
        SELECT CASE MouseX
            CASE 125 TO 235
                IF Item <> 85 THEN
                    DeLIGHT
                    ItemX = 115: ItemY = 420
                    HiLIGHT
                    Item = 85
                END IF
            CASE 265 TO 375
                IF Item <> 86 THEN
                    DeLIGHT
                    ItemX = 255: ItemY = 420
                    HiLIGHT
                    Item = 86
                END IF
            CASE 405 TO 515
                IF Item <> 87 THEN
                    DeLIGHT
                    ItemX = 395: ItemY = 420
                    HiLIGHT
                    Item = 87
                END IF
            CASE ELSE
                DeLIGHT
        END SELECT
END SELECT

IF LB = -1 AND Item <> 0 THEN
    SELECT CASE Item
        CASE 73 TO 78
            IF Frame = 1 THEN SeatUP = -2 ELSE SeatUP = 0
            HideMOUSE
            IF Item = 73 THEN LoadBSI FrameX, FrameY + SeatUP, "CHStOSHP"
            IF Item = 74 THEN LoadBSI FrameX, FrameY + SeatUP, "CHStOSHS"
            IF Item = 75 THEN LoadBSI FrameX, FrameY + SeatUP, "CHStOSLP"
            IF Item = 76 THEN LoadBSI FrameX, FrameY + SeatUP, "CHStOSLS"
            IF Item = 77 THEN
                IF Frame = 1 THEN
                    LoadBSI FrameX + 10, FrameY + 15, "CHStBNAR"
                    CIRCLE (FrameX + 156, FrameY + 64), 4, 15, 1, 3
                    PSET STEP(2, -4), 3
                    PSET STEP(-4, 0), 3
                ELSE
                    SELECT CASE FrameCOLOR
                        CASE 1: LoadBSI FrameX + 4, FrameY + 2, "CHStBNAP"
                        CASE 2: LoadBSI FrameX + 4, FrameY + 2, "CHStBNAB"
                        CASE 3: LoadBSI FrameX + 4, FrameY + 2, "CHStBNAC"
                    END SELECT
                END IF
            END IF
            IF Item = 78 THEN
                IF Frame = 1 THEN
                    SELECT CASE FrameCOLOR
                        CASE 1: LoadBSI FrameX + 8, FrameY + 4, "CHStCHPP"
                        CASE 2: LoadBSI FrameX + 8, FrameY + 4, "CHStCHPB"
                        CASE 3: LoadBSI FrameX + 8, FrameY + 4, "CHStCHPC"
                    END SELECT
                    IF OT > 4 THEN
                        IF OT = 5 THEN LoadBSI FrameX, FrameY, "CHOTnkBP"
                        IF OT = 6 THEN LoadBSI FrameX, FrameY, "CHOTnkBC"
                        IF HighMEG THEN LoadBSI FrameX, FrameY, "CHExBHMG"
                    END IF
                ELSE
                    LoadBSI FrameX + 8, FrameY + 4, "CHStCHPE"
                END IF
            END IF
            DeLIGHT
            ShowMOUSE
            Phase = 23
        CASE 79 TO 84
            HideMOUSE
            IF Item = 79 THEN LoadBSI LightX, LightY, "CHHDLTLP"
            IF Item = 80 THEN LoadBSI LightX, LightY, "CHHDLTLC"
            IF Item = 81 THEN LoadBSI LightX, LightY, "CHHDLTSP"
            IF Item = 82 THEN LoadBSI LightX, LightY, "CHHDLTSC"
            IF Item = 83 THEN LoadBSI LightX, LightY, "CHHDLTCP"
            IF Item = 84 THEN LoadBSI LightX, LightY, "CHHDLTCC"
            DeLIGHT
            ShowMOUSE
            Phase = 24
        CASE 85 TO 87
            HideMOUSE
            SELECT CASE FenderSTYLE
                CASE 1
                    IF Item = 85 THEN LoadBSI WheelRX, WheelRY, "CHTLLTSP"
                    IF Item = 86 THEN LoadBSI WheelRX, WheelRY, "CHTLLTSC"
                    IF HighPIPE = 1 THEN LoadBSI FrameX, FrameY, "CHExVHOS"
                CASE 2
                    IF Item = 85 THEN LoadBSI WheelRX, WheelRY, "CHTLLTCP"
                    IF Item = 86 THEN LoadBSI WheelRX, WheelRY, "CHTLLTCC"
                CASE 3
                    IF Item = 85 THEN LoadBSI WheelRX, WheelRY, "CHTLLTFP"
                    IF Item = 86 THEN LoadBSI WheelRX, WheelRY, "CHTLLTFC"
            END SELECT
            DeLIGHT
            ShowMOUSE
            Phase = 25
    END SELECT
END IF

END SUB

SUB ChopperIDE

FOR Colr = 8 TO 14
    OUT &H3C8, Colr
    OUT &H3C9, 63 - nn / 4
    OUT &H3C9, 24 - nn
    OUT &H3C9, 0
    nn = nn + 4
NEXT Colr

DEF SEG = VARSEG(Box(0))
FOR y = 0 TO 320 STEP 160
    FileCOUNT = FileCOUNT + 1
    FileNAME$ = "chide" + LTRIM$(STR$(FileCOUNT)) + ".bsv"
    BLOAD FileNAME$, VARPTR(Box(0))
    PUT (0, y), Box()
NEXT y
DEF SEG

END SUB

SUB ClearBOX

LINE (11, 295)-(628, 469), 0, BF

END SUB

SUB ClearMOUSE

WHILE LB OR RB
    MouseSTATUS LB, RB, MouseX, MouseY
WEND

END SUB

SUB DeLIGHT
SHARED ItemX, ItemY

IF Item THEN
    HideMOUSE
    PUT (ItemX, ItemY), MenuBOX(), PSET
    ShowMOUSE
    Item = 0
END IF

END SUB

SUB FieldMOUSE (x1, y1, x2, y2)

MouseDRIVER 7, 0, x1, x2
MouseDRIVER 8, 0, y1, y2

END SUB

SUB FourBIT (x1%, y1%, x2%, y2%, FileNAME$)

DIM FileCOLORS%(1 TO 48)
DIM Colors4%(15)
GraphX = 314

FOR x = x1% TO x2%
    FOR y = y1% TO y2%
        Colors4%(POINT(x, y)) = 1
    NEXT y
    LINE (GraphX, 323)-(GraphX, 331), 11
    IF x MOD 11 = 0 THEN GraphX = GraphX + 1
NEXT x
FOR n = 0 TO 15
    IF Colors4%(n) = 1 THEN SigCOLORS& = SigCOLORS& + 1
NEXT n

FileTYPE$ = "BM"
Reserved1% = 0
Reserved2% = 0
OffsetBITS& = 118
InfoHEADER& = 40
PictureWIDTH& = x2% - x1% + 1
PictureDEPTH& = y2% - y1% + 1
NumPLANES% = 1
BPP% = 4
Compression& = 0
WidthPELS& = 3780
DepthPELS& = 3780
NumCOLORS& = 16

IF PictureWIDTH& MOD 8 <> 0 THEN
    ZeroPAD$ = SPACE$((8 - PictureWIDTH& MOD 8) \ 2)
END IF

ImageSIZE& = (((ImageWIDTH& + LEN(ZeroPAD$)) * ImageDEPTH&) + .1) / 2
FileSIZE& = ImageSIZE& + OffsetBITS&

Colr = 0
FOR n = 1 TO 48 STEP 3
    OUT &H3C7, Colr
    FileCOLORS%(n) = INP(&H3C9)
    FileCOLORS%(n + 1) = INP(&H3C9)
    FileCOLORS%(n + 2) = INP(&H3C9)
    Colr = Colr + 1
NEXT n

OPEN FileNAME$ FOR BINARY AS #1

PUT #1, , FileTYPE$
PUT #1, , FileSIZE&
PUT #1, , Reserved1% 'should be zero
PUT #1, , Reserved2% 'should be zero
PUT #1, , OffsetBITS&
PUT #1, , InfoHEADER&
PUT #1, , PictureWIDTH&
PUT #1, , PictureDEPTH&
PUT #1, , NumPLANES%
PUT #1, , BPP%
PUT #1, , Compression&
PUT #1, , ImageSIZE&
PUT #1, , WidthPELS&
PUT #1, , DepthPELS&
PUT #1, , NumCOLORS&
PUT #1, , SigCOLORS&

u$ = " "
FOR n% = 1 TO 46 STEP 3
    Colr$ = CHR$(FileCOLORS%(n% + 2) * 4)
    PUT #1, , Colr$
    Colr$ = CHR$(FileCOLORS%(n% + 1) * 4)
    PUT #1, , Colr$
    Colr$ = CHR$(FileCOLORS%(n%) * 4)
    PUT #1, , Colr$
    PUT #1, , u$ 'Unused byte
NEXT n%

FOR y = y2% TO y1% STEP -1
    FOR x = x1% TO x2% STEP 2
        HiX = POINT(x, y)
        LoX = POINT(x + 1, y)
        HiNIBBLE$ = HEX$(HiX)
        LoNIBBLE$ = HEX$(LoX)
        HexVAL$ = "&H" + HiNIBBLE$ + LoNIBBLE$
        a$ = CHR$(VAL(HexVAL$))
        PUT #1, , a$
    NEXT x

    PUT #1, , ZeroPAD$

    IF y MOD 3 = 0 THEN
        LINE (GraphX, 323)-(GraphX, 331), 11
        GraphX = GraphX + 1
    END IF

NEXT y

CLOSE #1

END SUB

SUB HandleBARS (InOUT)
SHARED BarX, BarY, GotBOX

IF InOUT = 0 THEN GOSUB DeBOX: EXIT SUB

SELECT CASE MouseY
    CASE 332 TO 414
        SELECT CASE MouseX
            CASE 12 TO 87
                IF BarBOX <> 1 THEN
                    GOSUB DeBOX
                    BarBOX = 1
                    GOSUB BoxIT
                END IF
            CASE 89 TO 164
                IF BarBOX <> 2 THEN
                    GOSUB DeBOX
                    BarBOX = 2
                    GOSUB BoxIT
                END IF
            CASE 166 TO 241
                IF BarBOX <> 3 THEN
                    GOSUB DeBOX
                    BarBOX = 3
                    GOSUB BoxIT
                END IF
            CASE 243 TO 318
                IF MouseY < 374 THEN
                    IF BarBOX <> 4 THEN
                        GOSUB DeBOX
                        BarBOX = 4
                        GOSUB BoxIT
                    END IF
                ELSE
                    IF BarBOX <> 5 THEN
                        GOSUB DeBOX
                        BarBOX = 5
                        GOSUB BoxIT
                    END IF
                END IF
            CASE 320 TO 395
                IF BarBOX <> 6 THEN
                    GOSUB DeBOX
                    BarBOX = 6
                    GOSUB BoxIT
                END IF
            CASE 397 TO 472
                IF BarBOX <> 7 THEN
                    GOSUB DeBOX
                    BarBOX = 7
                    GOSUB BoxIT
                END IF
            CASE 474 TO 549
                IF BarBOX <> 8 THEN
                    GOSUB DeBOX
                    BarBOX = 8
                    GOSUB BoxIT
                END IF
            CASE 551 TO 626
                IF BarBOX <> 9 THEN
                    GOSUB DeBOX
                    BarBOX = 9
                    GOSUB BoxIT
                END IF
        END SELECT
    CASE 423 TO 439
        IF MouseX > 277 AND MouseX < 349 THEN
            IF LB = -1 THEN
                HideMOUSE
                GET (278, 423)-(358, 439), MenuBOX()
                LINE (278, 423)-(358, 439), 4, BF
                LINE (278, 423)-(278, 439), 3
                LINE (278, 423)-(358, 423), 3
                PrintSTRING 302, 426, "Accept"
                ShowMOUSE
                Interval .1
                HideMOUSE
                PUT (278, 423), MenuBOX(), PSET
                ShowMOUSE
                IF GotBOX = 1 THEN
                    DeLIGHT
                    GOSUB DeBOX
                    HideMOUSE
                    OPEN "chcable.dat" FOR INPUT AS #1
                    INPUT #1, xx, yy
                    FOR x = 0 TO xx
                        FOR y = 0 TO yy
                            INPUT #1, Colr
                            IF Colr <> 0 THEN
                                IF POINT(x + BarX - 16, y + BarY + 24) = 0 THEN
                                    PSET (x + BarX - 16, y + BarY + 24), Colr
                                END IF
                            END IF
                        NEXT y
                    NEXT x
                    CLOSE #1
                    ShowMOUSE
                    Phase = 22
                    EXIT SUB
                END IF
            END IF
        END IF
    CASE ELSE
        GOSUB DeBOX
END SELECT

IF BarBOX <> 0 AND LB = -1 THEN
    HideMOUSE
    IF GotBOX = 1 THEN PUT (BarX - 10, BarY - 45), Box(24000), PSET: GotBOX = 0
    GET (BarX - 10, BarY - 45)-(BarX + 66, BarY + 30), Box(24000): GotBOX = 1
    SELECT CASE BarBOX
        CASE 1: LoadFILE "CHBar1.BSI"
        CASE 2: LoadFILE "CHBar2.BSI"
        CASE 3: LoadFILE "CHBar3.BSI"
        CASE 4: LoadFILE "CHBar4.BSI"
        CASE 5: LoadFILE "CHBar5.BSI"
        CASE 6: LoadFILE "CHBar6.BSI"
        CASE 7: LoadFILE "CHBar7.BSI"
        CASE 8: LoadFILE "CHBar8.BSI"
        CASE 9: LoadFILE "CHBar9.BSI"
    END SELECT
    PUT (BarX - Box(0), BarY - Box(1)), Box(3), AND
    PUT (BarX - Box(0), BarY - Box(1)), Box(Box(2))
    ShowMOUSE
END IF

EXIT SUB

DeBOX:
IF BarBOX THEN
    HideMOUSE
    SELECT CASE BarBOX
        CASE 1: LINE (12, 332)-(87, 414), 3, B
        CASE 2: LINE (89, 332)-(164, 414), 3, B
        CASE 3: LINE (166, 332)-(241, 414), 3, B
        CASE 4: LINE (243, 332)-(318, 372), 3, B
        CASE 5: LINE (243, 374)-(318, 414), 3, B
        CASE 6: LINE (320, 332)-(395, 414), 3, B
        CASE 7: LINE (397, 332)-(472, 414), 3, B
        CASE 8: LINE (474, 332)-(549, 414), 3, B
        CASE 9: LINE (551, 332)-(626, 414), 3, B
    END SELECT
    ShowMOUSE
    BarBOX = 0
END IF
RETURN

BoxIT:
HideMOUSE
SELECT CASE BarBOX
    CASE 1: LINE (12, 332)-(87, 414), 15, B
    CASE 2: LINE (89, 332)-(164, 414), 15, B
    CASE 3: LINE (166, 332)-(241, 414), 15, B
    CASE 4: LINE (243, 332)-(318, 372), 15, B
    CASE 5: LINE (243, 374)-(318, 414), 15, B
    CASE 6: LINE (320, 332)-(395, 414), 15, B
    CASE 7: LINE (397, 332)-(472, 414), 15, B
    CASE 8: LINE (474, 332)-(549, 414), 15, B
    CASE 9: LINE (551, 332)-(626, 414), 15, B
END SELECT
ShowMOUSE
RETURN

END SUB

SUB HelpMENU
STATIC HelpITEM, HelpY, Instructions, CornerON

DO
    MouseSTATUS LB, RB, MouseX, MouseY
    IF Instructions THEN
        SELECT CASE MouseX
            CASE 428 TO 456
                SELECT CASE MouseY
                    CASE 104 TO 118
                        IF CornerON <> 1 THEN
                            GOSUB LightINSTR
                            CornerON = 1
                        END IF
                    CASE ELSE
                        GOSUB DarkINSTR
                END SELECT
            CASE ELSE
                GOSUB DarkINSTR
        END SELECT
        IF CornerON AND LB = -1 THEN
            SELECT CASE Instructions
                CASE 1
                    LoadFILE "CHInstr2.BSV"
                    Instructions = 2
                    HideMOUSE
                    PUT (180, 100), Box(), PSET
                    ShowMOUSE
                    ClearMOUSE
                    CornerON = 0
                CASE 2
                    HideMOUSE
                    PUT (180, 100), Box(13000), PSET
                    ShowMOUSE
                    Instructions = 0
            END SELECT
        END IF
    ELSE
        SELECT CASE MouseX
            CASE 492 TO 584
                SELECT CASE MouseY
                    CASE 34 TO 55
                        GOSUB DarkHELP
                        IF MouseX < 500 OR MouseX > 544 THEN GOSUB CloseHELP
                    CASE 56 TO 71
                        IF HelpITEM <> 1 THEN
                            GOSUB DarkHELP
                            HelpY = 59
                            GOSUB LightHELP
                            HelpITEM = 1
                        END IF
                    CASE 72 TO 87
                        IF HelpITEM <> 2 THEN
                            GOSUB DarkHELP
                            HelpY = 75
                            GOSUB LightHELP
                            HelpITEM = 2
                        END IF
                    CASE ELSE: GOSUB CloseHELP
                END SELECT
            CASE ELSE: GOSUB CloseHELP
        END SELECT
        IF HelpITEM > 0 AND LB = -1 THEN
            SELECT CASE HelpITEM
                CASE 1
                    GOSUB DarkHELP
                    MenuITEM = 0
                    MenuBAR 0
                    HideMOUSE
                    GET (180, 100)-(460, 272), Box(13000)
                    LoadFILE "CHInstr1.BSV"
                    PUT (180, 100), Box(), PSET
                    ShowMOUSE
                    Instructions = 1
                CASE 2
                    GOSUB DarkHELP
                    MenuITEM = 0
                    MenuBAR 0
                    HideMOUSE
                    GET (180, 100)-(460, 272), Box(13000)
                    LoadFILE "CHAbout.BSV"
                    PUT (180, 100), Box(), PSET
                    ShowMOUSE
                    Instructions = 2
            END SELECT
        END IF
    END IF
LOOP

EXIT SUB

LightHELP:
HideMOUSE
GET (498, HelpY)-(598, HelpY + 10), MenuBOX2()
FOR x = 498 TO 598
    FOR y = HelpY TO HelpY + 10
        IF POINT(x, y) = 3 THEN PSET (x, y), 15
    NEXT y
NEXT x
ShowMOUSE
RETURN

DarkHELP:
IF HelpITEM THEN
    HideMOUSE
    PUT (498, HelpY), MenuBOX2(), PSET
    ShowMOUSE
    HelpITEM = 0
END IF
RETURN

LightINSTR:
HideMOUSE
FOR x = 428 TO 456
    FOR y = 104 TO 118
        IF POINT(x, y) = 3 THEN PSET (x, y), 15
    NEXT y
NEXT x
ShowMOUSE
RETURN

DarkINSTR:
IF CornerON <> 0 THEN
    HideMOUSE
    FOR x = 428 TO 456
        FOR y = 104 TO 118
            IF POINT(x, y) = 15 THEN PSET (x, y), 3
        NEXT y
    NEXT x
    ShowMOUSE
    CornerON = 0
END IF
RETURN

CloseHELP:
GOSUB DarkHELP
MenuITEM = 0
MenuBAR 0
EXIT SUB
RETURN

END SUB

SUB HideMOUSE

LB = 2
MouseDRIVER LB, 0, 0, 0

END SUB

SUB HiLIGHT
SHARED ItemX, ItemY

HideMOUSE
GET (ItemX, ItemY)-(ItemX + 130, ItemY + 10), MenuBOX()
FOR x = ItemX TO ItemX + 130
    FOR y = ItemY TO ItemY + 10
        IF POINT(x, y) <> 0 THEN PSET (x, y), 15
    NEXT y
NEXT x
ShowMOUSE

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
SUB LoadBSI (x, y, FileNAME$)

FileNAME$ = FileNAME$ + ".BSI"
LoadFILE FileNAME$
WAIT &H3DA, 8
PUT (x + Box(0), y + Box(1)), Box(3), AND
PUT (x + Box(0), y + Box(1)), Box(Box(2))

END SUB

SUB LoadFILE (FileNAME$)

IF INSTR(FileNAME$, ".") = 0 THEN FileNAME$ = FileNAME$ + ".BSV"
DEF SEG = VARSEG(Box(0))
BLOAD LCASE$(FileNAME$), VARPTR(Box(0))
DEF SEG

END SUB

SUB LoadIMAGE (x, y, FileNAME$)

IF INSTR(FileNAME$, ".") = 0 THEN FileNAME$ = FileNAME$ + ".BSV"
DEF SEG = VARSEG(Box(0))
BLOAD LCASE$(FileNAME$), VARPTR(Box(0))
DEF SEG
WAIT &H3DA, 8
PUT (x, y), Box()

END SUB

SUB LoadPHASE
STATIC ExPHASE
SHARED PX, PY, Trimmed, Style, MotorSTYLE
SHARED Frame, FrameCOLOR, Extension, FenderSTYLE, BarBOX, GotBOX

IF Phase <> ExPHASE THEN
    IF Phase = 1 THEN
        HideMOUSE
        LINE (20, 56)-(620, 200), 0, BF
        LINE (90, 201)-(549, 280), 0, BF
        LINE (90, 252)-(549, 280), 2, BF
        ShowMOUSE
    END IF
    HideMOUSE
    ClearBOX
    SELECT CASE Phase
        CASE 1
            BarBOX = 0: GotBOX = 0: ImageLOADED = 0
            PX = 0: PY = 0: Trimmed = 0: Style = 0
            BikeCOLOR = 3: FlameSTYLE = 1: SetPALETTE
            LoadIMAGE 116, 300, "CHFrames"
        CASE 2
            IF Frame = 1 THEN
                LoadIMAGE 18, 300, "CHFrmCLR"
            ELSE
                LoadIMAGE 18, 300, "CHFrmCLX"
            END IF
        CASE 3
            SELECT CASE FrameCOLOR
                CASE 1
                    IF Frame = 1 THEN
                        LoadIMAGE 112, 300, "CHExtRP"
                    ELSE
                        LoadIMAGE 112, 300, "CHExtXP"
                    END IF
                CASE 2
                    IF Frame = 1 THEN
                        LoadIMAGE 112, 300, "CHExtRB"
                    ELSE
                        LoadIMAGE 112, 300, "CHExtXB"
                    END IF
                CASE 3
                    IF Frame = 1 THEN
                        LoadIMAGE 112, 300, "CHExtRC"
                    ELSE
                        LoadIMAGE 112, 300, "CHExtXC"
                    END IF
            END SELECT
        CASE 4
            SELECT CASE Extension
                CASE 1: LoadIMAGE 53, 300, "CHFrksR"
                CASE 2: LoadIMAGE 53, 300, "CHFrksX"
                CASE 3: LoadIMAGE 20, 300, "CHFrksXX"
            END SELECT
        CASE 5
            LoadIMAGE 89, 312, "CHTiresF"
        CASE 6
            LoadIMAGE 170, 80, "CHPrepAR"
            IF Frame = 1 THEN
                LoadIMAGE 89, 312, "CHTireRR"
            ELSE
                LoadIMAGE 89, 312, "CHTireRX"
            END IF
        CASE 7
            LoadIMAGE 70, 310, "CHWheels"
        CASE 8
            LoadIMAGE 88, 305, "CHFndrs"
        CASE 9
            LoadIMAGE 140, 320, "CHMotors"
        CASE 10
            IF MotorSTYLE = 2 THEN
                LoadIMAGE 144, 320, "CHMtrKCL"
            ELSE
                LoadIMAGE 144, 320, "CHMtrBCL"
            END IF
        CASE 11
            LoadIMAGE 137, 320, "CHDrives"
        CASE 12
            LoadIMAGE 142, 330, "CHBDCvrs"
        CASE 13
            LoadIMAGE 118, 330, "CHIntaks"
        CASE 14
            LoadIMAGE 190, 320, "CHRDrvV"
        CASE 15
            LoadIMAGE 102, 320, "CHRDrv7"
        CASE 16
            LoadIMAGE 60, 310, "CHExBR"
        CASE 17
            LoadIMAGE 42, 310, "CHExVs"
        CASE 18
            LoadIMAGE 88, 320, "CHFTanks"
        CASE 19
            LoadIMAGE 76, 330, "CHOTnksR"
        CASE 20
            LoadIMAGE 167, 330, "CHOTnksX"
        CASE 21
            LoadIMAGE 12, 310, "CHHBars"
        CASE 22
            LoadIMAGE 38, 320, "CHSeats"
        CASE 23
            LoadIMAGE 80, 324, "CHHDLts"
        CASE 24
            SELECT CASE FenderSTYLE
                CASE 1: LoadIMAGE 122, 320, "CHTLLTSS"
                CASE 2: LoadIMAGE 122, 320, "CHTLLTSC"
                CASE 3: LoadIMAGE 122, 320, "CHTLLTSF"
            END SELECT
        CASE 25
            LoadIMAGE 20, 300, "CHPaint"
    END SELECT
    ShowMOUSE

    ExPHASE = Phase
END IF

END SUB

SUB LocateMOUSE (x, y)

LB = 4
MX = x
MY = y
MouseDRIVER LB, 0, MX, MY

END SUB

SUB MenuBAR (InOUT)
STATIC MenuX, Choice, Opening, BoxX
SHARED FFLX, FFRX, FFTY, FFBY, RFLX, RFRX, RFTY, RFBY, TX, TY
SHARED FrameX, FrameY, FenderSTYLE, HighPIPE, OT, GPaint, Frame

IF BoxX <> 0 THEN GOSUB CloseBOX
IF InOUT = 0 THEN GOSUB MenuDARK: EXIT SUB

SELECT CASE MouseX
    CASE 431 TO 464
        IF TopMENU <> 1 THEN
            GOSUB MenuDARK
            MenuX = 432
            GOSUB MenuLIGHT
            TopMENU = 1
        END IF
    CASE 513 TO 532
        IF TopMENU <> 2 THEN
            GOSUB MenuDARK
            MenuX = 513
            GOSUB MenuLIGHT
            TopMENU = 2
        END IF
    CASE 582 TO 602
        IF TopMENU <> 3 THEN
            GOSUB MenuDARK
            MenuX = 582
            GOSUB MenuLIGHT
            TopMENU = 3
        END IF
    CASE ELSE
        GOSUB MenuDARK
END SELECT

IF TopMENU AND LB = -1 THEN
    SELECT CASE TopMENU
        CASE 1
            HideMOUSE
            GET (416, 46)-(563, 148), MenuBOX3()
            LoadFILE "CHProMNU.BSV"
            WAIT &H3DA, 8
            PUT (416, 46), Box(), PSET
            BoxX = 416
            ShowMOUSE
            MenuITEM = 1
        CASE 2
            HideMOUSE
            GET (472, 46)-(598, 100), MenuBOX3()
            LoadFILE "CHHlpMNU.BSV"
            WAIT &H3DA, 8
            PUT (492, 46), Box(), PSET
            ShowMOUSE
            BoxX = 472
            MenuITEM = 2
        CASE 3: GOSUB MenuDARK: SYSTEM
    END SELECT
END IF

EXIT SUB

MenuLIGHT:
HideMOUSE
GET (MenuX, 34)-(MenuX + 31, 44), MenuBOX()
FOR x = MenuX TO MenuX + 31
    FOR y = 34 TO 44
        IF POINT(x, y) <> 1 THEN PSET (x, y), 15
    NEXT y
NEXT x
ShowMOUSE
RETURN

MenuDARK:
IF TopMENU THEN
    HideMOUSE
    PUT (MenuX, 34), MenuBOX(), PSET
    TopMENU = 0
    ShowMOUSE
END IF
RETURN

CloseBOX:
IF BoxX THEN
    HideMOUSE
    PUT (BoxX, 46), MenuBOX3(), PSET
    ShowMOUSE
    BoxX = 0
END IF
RETURN

END SUB

SUB MouseDRIVER (LB, RB, MX, MY)

DEF SEG = VARSEG(MouseDATA$)
Mouse = SADD(MouseDATA$)
CALL ABSOLUTE_MOUSE_EMU (LBLBLBLB,  RB RB RB RB,  MX Mx MX MX,  MY My MY MY) 

END SUB

SUB MouseSTATUS (LB, RB, MouseX, MouseY)

LB = 3
MouseDRIVER LB, RB, MX, MY
LB = ((RB AND 1) <> 0)
RB = ((RB AND 2) <> 0)
MouseX = MX
MouseY = MY

END SUB

SUB PaintSHOP (Mode)
SHARED PX, PY, Trimmed, Style
SHARED FFLX, FFRX, FFTY, FFBY, RFLX, RFRX, RFTY, RFBY, TX, TY
SHARED FrameX, FrameY, FenderSTYLE, HighPIPE, OT, GPaint, Frame
SHARED WheelFX, WheelFY, WheelRX, WheelRY, Cover, Tank, TTY, TTTY

IF Mode = 0 THEN GOSUB UnLIGHT: EXIT SUB

SELECT CASE MouseX
    CASE 82 TO 106
        SELECT CASE MouseY
            CASE 353 TO 364
                IF PaintITEM <> 1 THEN
                    GOSUB UnLIGHT
                    PX = 85: PY = 356
                    GOSUB LIGHT
                    PaintITEM = 1
                END IF
            CASE 367 TO 378
                IF PaintITEM <> 2 THEN
                    GOSUB UnLIGHT
                    PX = 85: PY = 370
                    GOSUB LIGHT
                    PaintITEM = 2
                END IF
            CASE 381 TO 392
                IF PaintITEM <> 3 THEN
                    GOSUB UnLIGHT
                    PX = 85: PY = 384
                    GOSUB LIGHT
                    PaintITEM = 3
                END IF
            CASE 395 TO 406
                IF PaintITEM <> 4 THEN
                    GOSUB UnLIGHT
                    PX = 85: PY = 398
                    GOSUB LIGHT
                    PaintITEM = 4
                END IF
            CASE 409 TO 420
                IF PaintITEM <> 5 THEN
                    GOSUB UnLIGHT
                    PX = 85: PY = 412
                    GOSUB LIGHT
                    PaintITEM = 5
                END IF
            CASE ELSE
                GOSUB UnLIGHT
        END SELECT
    CASE 172 TO 196
        SELECT CASE MouseY
            CASE 353 TO 364
                IF PaintITEM <> 6 THEN
                    GOSUB UnLIGHT
                    PX = 175: PY = 356
                    GOSUB LIGHT
                    PaintITEM = 6
                END IF
            CASE 367 TO 378
                IF PaintITEM <> 7 THEN
                    GOSUB UnLIGHT
                    PX = 175: PY = 370
                    GOSUB LIGHT
                    PaintITEM = 7
                END IF
            CASE 381 TO 392
                IF PaintITEM <> 8 THEN
                    GOSUB UnLIGHT
                    PX = 175: PY = 384
                    GOSUB LIGHT
                    PaintITEM = 8
                END IF
            CASE 395 TO 406
                IF PaintITEM <> 9 THEN
                    GOSUB UnLIGHT
                    PX = 175: PY = 398
                    GOSUB LIGHT
                    PaintITEM = 9
                END IF
            CASE 409 TO 420
                IF PaintITEM <> 10 THEN
                    GOSUB UnLIGHT
                    PX = 175: PY = 412
                    GOSUB LIGHT
                    PaintITEM = 10
                END IF
            CASE ELSE
                GOSUB UnLIGHT
        END SELECT
    CASE 304 TO 328
        SELECT CASE MouseY
            CASE 353 TO 364
                IF PaintITEM <> 11 THEN
                    GOSUB UnLIGHT
                    PX = 307: PY = 356
                    GOSUB LIGHT
                    PaintITEM = 11
                END IF
            CASE 367 TO 378
                IF PaintITEM <> 12 THEN
                    GOSUB UnLIGHT
                    PX = 307: PY = 370
                    GOSUB LIGHT
                    PaintITEM = 12
                END IF
            CASE 381 TO 392
                IF PaintITEM <> 13 THEN
                    GOSUB UnLIGHT
                    PX = 307: PY = 384
                    GOSUB LIGHT
                    PaintITEM = 13
                END IF
            CASE 409 TO 420
                IF PaintITEM <> 14 THEN
                    GOSUB UnLIGHT
                    PX = 307: PY = 412
                    GOSUB LIGHT
                    PaintITEM = 14
                END IF
            CASE ELSE
                GOSUB UnLIGHT
        END SELECT
    CASE 420 TO 444
        SELECT CASE MouseY
            CASE 353 TO 364
                IF PaintITEM <> 15 THEN
                    GOSUB UnLIGHT
                    PX = 423: PY = 356
                    GOSUB LIGHT
                    PaintITEM = 15
                END IF
            CASE 367 TO 378
                IF PaintITEM <> 16 THEN
                    GOSUB UnLIGHT
                    PX = 423: PY = 370
                    GOSUB LIGHT
                    PaintITEM = 16
                END IF
            CASE 381 TO 392
                IF PaintITEM <> 17 THEN
                    GOSUB UnLIGHT
                    PX = 423: PY = 384
                    GOSUB LIGHT
                    PaintITEM = 17
                END IF
            CASE 395 TO 406
                IF PaintITEM <> 18 THEN
                    GOSUB UnLIGHT
                    PX = 423: PY = 398
                    GOSUB LIGHT
                    PaintITEM = 18
                END IF
            CASE 409 TO 420
                IF PaintITEM <> 19 THEN
                    GOSUB UnLIGHT
                    PX = 423: PY = 412
                    GOSUB LIGHT
                    PaintITEM = 19
                END IF
            CASE ELSE
                GOSUB UnLIGHT
        END SELECT
    CASE ELSE
        GOSUB UnLIGHT
END SELECT

IF PaintITEM AND LB = -1 THEN
    SELECT CASE PaintITEM
        CASE 1 TO 10: BikeCOLOR = PaintITEM - 1: SetPALETTE
        CASE 11
            IF Style <> 1 THEN
                IF Frame = 1 AND Tank = 2 THEN TTTY = -6
                GOSUB NoTRIM
                OPEN "ff.dat" FOR INPUT AS #1
                SELECT CASE FenderSTYLE
                    CASE 1: OPEN "ffsf.dat" FOR INPUT AS #2
                    CASE 2: OPEN "ffcf.dat" FOR INPUT AS #2
                    CASE 3: OPEN "ffff.dat" FOR INPUT AS #2
                END SELECT
                OPEN "ffw.dat" FOR OUTPUT AS #3
                INPUT #1, x1, xx, y1, yy
                WRITE #3, x1, xx, y1, yy
                FOR x = x1 TO x1 + xx
                    FOR y = y1 TO y1 + yy
                        INPUT #1, Value
                        INPUT #2, Colr
                        WRITE #3, POINT(x, y)
                        IF Value = 1 AND Colr <> 0 THEN PSET (x, y), Colr
                    NEXT y
                NEXT x
                CLOSE #1, #2, #3
                OPEN "ftnkf.dti" FOR INPUT AS #1
                OPEN "tnkw.dat" FOR OUTPUT AS #2
                INPUT #1, x1, xx, y1, yy
                x1 = FrameX + x1 + TX
                y1 = FrameY + y1 + TY + TTTY
                WRITE #2, x1, xx, y1, yy
                FOR x = x1 TO x1 + xx
                    FOR y = y1 TO y1 + yy
                        WRITE #2, POINT(x, y)
                        INPUT #1, Colr
                        IF Colr <> 0 THEN
                            IF POINT(x, y) = 6 OR POINT(x, y) = 7 OR POINT(x, y) = 13 THEN PSET (x, y), Colr
                        END IF
                    NEXT y
                NEXT x
                CLOSE #1, #2
                IF Cover THEN
                    OPEN "dcpb.dat" FOR INPUT AS #1
                    OPEN "dcw.dat" FOR OUTPUT AS #2
                    INPUT #1, x1, xx, y1, yy
                    x1 = FrameX + x1
                    y1 = FrameY + y1
                    WRITE #2, x1, xx, y1, yy
                    FOR x = x1 TO x1 + xx
                        FOR y = y1 TO y1 + yy
                            WRITE #2, POINT(x, y)
                            INPUT #1, Colr
                            IF Colr <> 0 THEN
                                IF POINT(x, y) = 6 OR POINT(x, y) = 7 OR POINT(x, y) = 10 THEN PSET (x, y), Colr
                            END IF
                        NEXT y
                    NEXT x
                    CLOSE #1, #2
                END IF
                GOSUB OilTANK
                OPEN "rf.dat" FOR INPUT AS #1
                SELECT CASE FenderSTYLE
                    CASE 1
                        IF OT = 5 THEN
                            OPEN "rfsrfb.dat" FOR INPUT AS #2
                        ELSE
                            IF GPaint = 1 OR FenderSTYLE = 1 THEN
                                IF Frame = 1 THEN
                                    OPEN "rfsrcg.dat" FOR INPUT AS #2
                                ELSE
                                    OPEN "rfsxcg.dat" FOR INPUT AS #2
                                END IF
                            ELSE
                                OPEN "rfs.dat" FOR INPUT AS #2
                            END IF
                        END IF
                    CASE 2
                        IF OT = 5 THEN
                            OPEN "rfcrfb.dat" FOR INPUT AS #2
                        ELSE
                            IF GPaint = 1 THEN
                                IF Frame = 1 THEN
                                    OPEN "rfcrcg.dat" FOR INPUT AS #2
                                ELSE
                                    OPEN "rfcxcg.dat" FOR INPUT AS #2
                                END IF
                            ELSE
                                OPEN "rfc.dat" FOR INPUT AS #2
                            END IF
                        END IF
                    CASE 3: OPEN "rff.dat" FOR INPUT AS #2
                END SELECT
                OPEN "rfw.dat" FOR OUTPUT AS #3
                INPUT #1, x1, xx, y1, yy
                WRITE #3, x1, xx, y1, yy
                FOR x = x1 TO x1 + xx
                    FOR y = y1 TO y1 + yy
                        INPUT #1, Value
                        INPUT #2, Colr
                        IF POINT(x, y) = 8 OR POINT(x, y) = 12 OR POINT(x, y) = 14 THEN
                            WRITE #3, 7
                        ELSE
                            WRITE #3, POINT(x, y)
                        END IF
                        IF POINT(x, y) = 7 OR POINT(x, y) = 6 THEN
                            IF Value = 1 AND Colr <> 0 THEN PSET (x, y), Colr
                        END IF
                    NEXT y
                NEXT x
                CLOSE #1, #2, #3
                Trimmed = 1
                Style = 1
            END IF
        CASE 12
            IF Style <> 2 THEN
                IF Frame = 1 AND Tank = 2 THEN TTTY = -6
                GOSUB NoTRIM
                OPEN "ftnkf2.dti" FOR INPUT AS #1
                OPEN "tnkw.dat" FOR OUTPUT AS #2
                INPUT #1, xx, yy
                x1 = FrameX + 30 + TX
                y1 = FrameY + 12 + TY + TTTY
                WRITE #2, x1, xx, y1, yy
                FOR x = 0 TO xx
                    FOR y = 0 TO yy
                        WRITE #2, POINT(x + x1, y + y1)
                        INPUT #1, Colr
                        IF Colr <> 0 THEN
                            IF POINT(x + x1, y + y1) = 6 OR POINT(x + x1, y + y1) = 7 OR POINT(x + x1, y + y1) = 13 THEN PSET (x + x1, y + y1), Colr
                        END IF
                    NEXT y
                NEXT x
                CLOSE #1, #2
                IF Cover THEN
                    OPEN "drcvrf2.dti" FOR INPUT AS #1
                    OPEN "cvrw.dat" FOR OUTPUT AS #2
                    INPUT #1, xx, yy
                    x1 = FrameX + 74
                    y1 = FrameY + 101
                    WRITE #2, x1, xx, y1, yy
                    FOR x = 0 TO xx
                        FOR y = 0 TO yy
                            WRITE #2, POINT(x + x1, y + y1)
                            INPUT #1, Colr
                            IF Colr <> 0 THEN
                                IF POINT(x + x1, y + y1) > 5 AND POINT(x + x1, y + y1) < 11 THEN PSET (x + x1, y + y1), Colr
                            END IF
                        NEXT y
                    NEXT x
                    CLOSE #1, #2
                END IF
                Style = 2
                Trimmed = 1
            END IF
        CASE 13
            IF Style <> 3 THEN
                GOSUB NoTRIM
                SELECT CASE FenderSTYLE
                    CASE 1: OPEN "ffsp.dat" FOR INPUT AS #1
                    CASE 2: OPEN "ffcp.dat" FOR INPUT AS #1
                    CASE 3: OPEN "fffp.dat" FOR INPUT AS #1
                END SELECT
                OPEN "ff.dat" FOR INPUT AS #2
                OPEN "ffw.dat" FOR OUTPUT AS #3
                INPUT #2, x1, xx, y1, yy
                WRITE #3, x1, xx, y1, yy
                FOR x = x1 TO x1 + xx
                    FOR y = y1 TO y1 + yy
                        WRITE #3, POINT(x, y)
                        INPUT #1, Colr
                        INPUT #2, Value
                        IF Value = 1 THEN
                            IF Colr <> 0 THEN PSET (x, y), Colr
                        END IF
                    NEXT y
                NEXT x
                CLOSE #1, #2, #3
                IF Frame = 1 THEN
                    OPEN "dtr.dat" FOR INPUT AS #1
                ELSE
                    OPEN "dtx.dat" FOR INPUT AS #1
                END IF
                OPEN "dtw.dat" FOR OUTPUT AS #2
                INPUT #1, x1, xx, y1, yy
                x1 = FrameX + x1
                y1 = FrameY + y1
                WRITE #2, x1, xx, y1, yy
                FOR x = x1 TO x1 + xx
                    FOR y = y1 TO y1 + yy
                        WRITE #2, POINT(x, y)
                        INPUT #1, Colr
                        IF Colr <> 0 THEN
                            IF POINT(x, y) = 6 OR POINT(x, y) = 7 OR POINT(x, y) = 13 THEN PSET (x, y), Colr
                        END IF
                    NEXT y
                NEXT x
                CLOSE #1, #2
                SELECT CASE Tank
                    CASE 1: OPEN "ftnktdp.dat" FOR INPUT AS #1
                    CASE 2: OPEN "ftnkscp.dat" FOR INPUT AS #1
                    CASE 3: OPEN "ftnkosp.dat" FOR INPUT AS #1
                    CASE 4: OPEN "ftnkcbp.dat" FOR INPUT AS #1
                    CASE 5: OPEN "ftnkbrp.dat" FOR INPUT AS #1
                END SELECT
                OPEN "tnkw.dat" FOR OUTPUT AS #2
                INPUT #1, x1, xx, y1, yy
                x1 = x1 + FrameX
                y1 = y1 + FrameY + TTY
                WRITE #2, x1, xx, y1, yy
                HideMOUSE
                FOR x = x1 TO x1 + xx
                    FOR y = y1 TO y1 + yy
                        WRITE #2, POINT(x, y)
                        INPUT #1, Colr
                        IF Colr <> 0 THEN
                            IF POINT(x, y) = 6 OR POINT(x, y) = 7 OR POINT(x, y) = 13 THEN PSET (x, y), Colr
                        END IF
                    NEXT y
                NEXT x
                ShowMOUSE
                CLOSE #1, #2
                IF Cover THEN
                    OPEN "dcpb.dat" FOR INPUT AS #1
                    OPEN "dcw.dat" FOR OUTPUT AS #2
                    INPUT #1, x1, xx, y1, yy
                    x1 = FrameX + x1
                    y1 = FrameY + y1
                    WRITE #2, x1, xx, y1, yy
                    FOR x = x1 TO x1 + xx
                        FOR y = y1 TO y1 + yy
                            WRITE #2, POINT(x, y)
                            INPUT #1, Colr
                            IF Colr <> 0 THEN
                                IF POINT(x, y) = 6 OR POINT(x, y) = 7 OR POINT(x, y) = 10 THEN PSET (x, y), Colr
                            END IF
                        NEXT y
                    NEXT x
                    CLOSE #1, #2
                END IF
                GOSUB OilTANK
                SELECT CASE FenderSTYLE
                    CASE 1: OPEN "rfsp.dat" FOR INPUT AS #1
                    CASE 2: OPEN "rfcp.dat" FOR INPUT AS #1
                    CASE 3: OPEN "rffp.dat" FOR INPUT AS #1
                END SELECT
                OPEN "rf.dat" FOR INPUT AS #2
                OPEN "rfw.dat" FOR OUTPUT AS #3
                INPUT #2, x1, xx, y1, yy
                WRITE #3, x1, xx, y1, yy
                FOR x = x1 TO x1 + xx
                    FOR y = y1 TO y1 + yy
                        IF POINT(x, y) = 8 OR POINT(x, y) = 12 OR POINT(x, y) = 14 THEN
                            WRITE #3, 7
                        ELSE
                            WRITE #3, POINT(x, y)
                        END IF
                        INPUT #1, Colr
                        INPUT #2, Value
                        IF Value = 1 THEN
                            IF Colr <> 0 THEN
                                IF POINT(x, y) = 6 OR POINT(x, y) = 7 OR POINT(x, y) = 13 THEN PSET (x, y), Colr
                            END IF
                        END IF
                    NEXT y
                NEXT x
                CLOSE #1, #2, #3
                Style = 3
                Trimmed = 1
            END IF
        CASE 14
            GOSUB NoTRIM
        CASE 15: FlameSTYLE = 1: SetPALETTE
        CASE 16: FlameSTYLE = 0: SetPALETTE
        CASE 17: FlameSTYLE = 2: SetPALETTE
        CASE 18: FlameSTYLE = 3: SetPALETTE
        CASE 19: FlameSTYLE = 4: SetPALETTE
    END SELECT
END IF

EXIT SUB

UnLIGHT:
IF PaintITEM THEN
    HideMOUSE
    PUT (PX, PY), MenuBOX(), PSET
    ShowMOUSE
    PaintITEM = 0
END IF
RETURN

LIGHT:
HideMOUSE
GET (PX, PY)-(PX + 18, PY + 5), MenuBOX()
LINE (PX + 1, PY + 1)-(PX + 17, PY + 4), 15, BF
ShowMOUSE
RETURN

NoTRIM:
IF Trimmed THEN
    SELECT CASE Style
        CASE 1
            HideMOUSE
            OPEN "ffw.dat" FOR INPUT AS #1
            GOSUB FileDAT
            CLOSE #1
            OPEN "tnkw.dat" FOR INPUT AS #1
            GOSUB FileDAT
            CLOSE #1
            IF Cover THEN
                OPEN "dcw.dat" FOR INPUT AS #1
                GOSUB FileDAT
                CLOSE #1
            END IF
            IF OT = 1 OR OT = 3 OR OT = 5 THEN
                OPEN "otw.dat" FOR INPUT AS #1
                GOSUB FileDAT
                CLOSE #1
            END IF
            OPEN "rfw.dat" FOR INPUT AS #1
            GOSUB FileDAT
            CLOSE #1
            ShowMOUSE
        CASE 2
            HideMOUSE
            OPEN "tnkw.dat" FOR INPUT AS #1
            GOSUB FileDAT
            CLOSE #1
            IF Cover THEN
                OPEN "dcw.dat" FOR INPUT AS #1
                GOSUB FileDAT
                CLOSE #1
            END IF
            IF OT = 1 OR OT = 3 OR OT = 5 THEN
                OPEN "otw.dat" FOR INPUT AS #1
                GOSUB FileDAT
                CLOSE #1
            END IF
            ShowMOUSE
        CASE 3
            HideMOUSE
            OPEN "ffw.dat" FOR INPUT AS #1
            GOSUB FileDAT
            CLOSE #1
            OPEN "dtw.dat" FOR INPUT AS #1
            GOSUB FileDAT
            CLOSE #1
            OPEN "tnkw.dat" FOR INPUT AS #1
            GOSUB FileDAT
            CLOSE #1
            IF Cover THEN
                OPEN "dcw.dat" FOR INPUT AS #1
                GOSUB FileDAT
                CLOSE #1
            END IF
            IF OT = 1 OR OT = 3 OR OT = 5 THEN
                OPEN "otw.dat" FOR INPUT AS #1
                GOSUB FileDAT
                CLOSE #1
            END IF
            OPEN "rfw.dat" FOR INPUT AS #1
            GOSUB FileDAT
            CLOSE #1
            ShowMOUSE
    END SELECT
    Trimmed = 0
    Style = 0
END IF
RETURN

OilTANK:
IF OT = 1 OR OT = 3 OR OT = 5 THEN
    IF OT = 1 THEN
        OPEN "oth.dat" FOR INPUT AS #1
        INPUT #1, x1, xx, y1, yy
    END IF
    IF OT = 3 THEN
        OPEN "otc.dat" FOR INPUT AS #1
        INPUT #1, x1, xx, y1, yy
    END IF
    IF OT = 5 THEN
        OPEN "otbp.dat" FOR INPUT AS #1
        INPUT #1, x1, xx, y1, yy
    END IF
    OPEN "otw.dat" FOR OUTPUT AS #2
    x1 = FrameX + x1
    y1 = FrameY + y1
    WRITE #2, x1, xx, y1, yy
    FOR x = x1 TO x1 + xx
        FOR y = y1 TO y1 + yy
            WRITE #2, POINT(x, y)
            INPUT #1, Colr
            IF Colr <> 0 THEN
                IF POINT(x, y) = 6 OR POINT(x, y) = 7 OR POINT(x, y) = 13 THEN PSET (x, y), Colr
            END IF
        NEXT y
    NEXT x
    CLOSE #1, #2
END IF
RETURN

FileDAT:
INPUT #1, x1, xx, y1, yy
FOR x = x1 TO x1 + xx
    FOR y = y1 TO y1 + yy
        INPUT #1, Colr
        PSET (x, y), Colr
    NEXT y
NEXT x
RETURN

END SUB

SUB PauseMOUSE (OldLB, OldRB, OldMX, OldMY)


SHARED Key$

DO
    Key$ = UCASE$(INKEY$)
    MouseSTATUS LB, RB, MouseX, MouseY
LOOP UNTIL LB <> OldLB OR RB <> OldRB OR MouseX <> OldMX OR MouseY <> OldMY OR Key$ <> ""

END SUB

SUB PrintSTRING (x, y, Prnt$)

DEF SEG = VARSEG(Box(0))
BLOAD "chmssr.fbs", VARPTR(Box(0))
DEF SEG

FOR i = 1 TO LEN(Prnt$)
    Char$ = MID$(Prnt$, i, 1)
    IF Char$ = " " THEN
        x = x + Box(1)
    ELSE
        Index = (ASC(Char$) - 33) * Box(0) + 2
        PUT (x, y), Box(Index)
        x = x + Box(Index)
    END IF
NEXT i

END SUB

SUB ProjectMENU
STATIC ProITEM, ProY

DO
    MouseSTATUS LB, RB, MouseX, MouseY
    SELECT CASE MouseX
        CASE 423 TO 552
            SELECT CASE MouseY
                CASE 34 TO 55
                    GOSUB DarkPRO
                    IF MouseX > 464 THEN GOSUB ClosePRO
                CASE 56 TO 71
                    IF ProITEM <> 1 THEN
                        GOSUB DarkPRO
                        ProY = 59
                        GOSUB LightPRO
                        ProITEM = 1
                    END IF
                CASE 72 TO 87
                    IF ProITEM <> 2 THEN
                        GOSUB DarkPRO
                        ProY = 75
                        GOSUB LightPRO
                        ProITEM = 2
                    END IF
                CASE ELSE: GOSUB ClosePRO
            END SELECT
        CASE ELSE: GOSUB ClosePRO
    END SELECT

    IF ProITEM <> 0 AND LB = -1 THEN
        SELECT CASE ProITEM
            CASE 1
                Phase = 1
                GOSUB ClosePRO
            CASE 2
                GOSUB DarkPRO
                MenuITEM = 0
                MenuBAR 0
                HideMOUSE
                GET (178, 60)-(460, 152), Box(10000)
                LoadFILE "CHSaveBM.BSV"
                PUT (178, 60), Box(), PSET
                ShowMOUSE
                GOSUB GetNAME
                HideMOUSE
                PUT (178, 60), Box(10000), PSET
                ShowMOUSE
                IF LEN(FileNAME$) THEN
                    FileNAME$ = LTRIM$(RTRIM$(FileNAME$))
                    IF INSTR(FileNAME$, " ") OR LEN(FileNAME$) > 8 THEN
                        LongNAME = 1
                        LongFILENAME$ = FileNAME$ + ".BMP"
                        FOR n = 1 TO LEN(FileNAME$)
                            Char$ = MID$(FileNAME$, n, 1)
                            IF Char$ <> " " THEN NewFILENAME$ = NewFILENAME$ + Char$
                        NEXT n
                        FileNAME$ = RTRIM$(LEFT$(NewFILENAME$, 6)) + "~1"
                        FileNAME$ = FileNAME$ + ".TBM"
                    ELSE
                        FileNAME$ = FileNAME$ + ".BMP"
                    END IF
                    HideMOUSE
                    GET (90, 250)-(549, 348), Box(5000)
                    LINE (90, 250)-(100, 310), 0, BF
                    LINE (539, 250)-(549, 310), 0, BF
                    LINE (90, 285)-(549, 310), 0, BF
                    LINE (95, 55)-(544, 305), 3, B
                    LINE (115, 310)-(524, 348), 0, BF
                    LoadFILE "CHGenBMP.BSV"
                    PUT (90, 310), Box(), PSET

                    FourBIT 90, 50, 549, 310, FileNAME$

                    LINE (95, 55)-(544, 305), 0, B
                    PUT (90, 250), Box(5000), PSET
                    ShowMOUSE
                    IF LongNAME = 1 THEN
                        SHELL "REN " + FileNAME$ + " TMP.TBM"
                        SHELL "REN TMP.TBM " + CHR$(34) + LongFILENAME$ + CHR$(34)
                        LongNAME = 0
                    END IF
                END IF
                EXIT SUB
        END SELECT
    END IF

LOOP

EXIT SUB

LightPRO:
HideMOUSE
GET (430, ProY)-(560, ProY + 10), MenuBOX2()
FOR x = 430 TO 560
    FOR y = ProY TO ProY + 10
        IF POINT(x, y) = 3 THEN PSET (x, y), 15
    NEXT y
NEXT x
ShowMOUSE
RETURN

DarkPRO:
IF ProITEM THEN
    HideMOUSE
    PUT (430, ProY), MenuBOX2(), PSET
    ShowMOUSE
    ProITEM = 0
END IF
RETURN

ClosePRO:
GOSUB DarkPRO
MenuITEM = 0
MenuBAR 0
EXIT SUB
RETURN

GetNAME:
CheckCHAR$ = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "
n$ = "": ky$ = "": PrintX = 242: CharNUM = 1

DO
    MouseSTATUS LB, RB, MouseX, MouseY
    ky$ = INKEY$
    LINE (PrintX + 2, 118)-(PrintX + 2, 128), 5
    IF LEN(ky$) THEN
        SELECT CASE ASC(ky$)
            CASE 8
                IF LEN(n$) > 0 THEN
                    HideMOUSE
                    CharNUM = CharNUM - 1
                    LINE (FChar(CharNUM), 118)-(PrintX + 2, 129), 15, BF
                    PrintX = FChar(CharNUM)
                    n$ = MID$(n$, 1, LEN(n$) - 1)
                    LINE (PrintX + 2, 118)-(PrintX + 2, 128), 5
                    ShowMOUSE
                END IF
            CASE 13
                FileNAME$ = n$
                n$ = ""
                ky$ = ""
                RETURN
            CASE ELSE
                IF INSTR(CheckCHAR$, ky$) THEN
                    IF PrintX < 390 THEN
                        FChar(CharNUM) = PrintX
                        CharNUM = CharNUM + 1
                        HideMOUSE
                        LINE (PrintX + 2, 118)-(PrintX + 2, 128), 15
                        PrintSTRING PrintX, 118, ky$
                        LINE (PrintX + 2, 118)-(PrintX + 2, 128), 5
                        ShowMOUSE
                        n$ = n$ + ky$
                    END IF
                END IF
        END SELECT
    END IF
LOOP
RETURN

END SUB

FUNCTION Seeker (x, y, Mode)

SELECT CASE Mode
    CASE 0 'left side
        FOR xx = x TO x + 140
            FOR yy = y TO y + 100
                IF POINT(xx, yy) = 6 OR POINT(xx, yy) = 7 THEN Seeker = xx: EXIT FUNCTION
            NEXT yy
        NEXT xx
    CASE 1 'right side
        FOR xx = x + 140 TO x STEP -1
            FOR yy = y TO y + 100
                IF POINT(xx, yy) = 6 OR POINT(xx, yy) = 7 THEN Seeker = xx: EXIT FUNCTION
            NEXT yy
        NEXT xx
    CASE 2 'top
        FOR yy = y TO y + 100
            FOR xx = x TO x + 140
                IF POINT(xx, yy) = 6 OR POINT(xx, yy) = 7 THEN Seeker = yy: EXIT FUNCTION
            NEXT xx
        NEXT yy
    CASE 3 'bottom
        FOR yy = y + 100 TO y STEP -1
            FOR xx = x TO x + 140
                IF POINT(xx, yy) = 6 OR POINT(xx, yy) = 7 THEN Seeker = yy: EXIT FUNCTION
            NEXT xx
        NEXT yy
END SELECT

END FUNCTION

SUB SetPALETTE

RESTORE PaletteDATA
OUT &H3C8, 0
FOR n = 1 TO 18
    READ Colr
    OUT &H3C9, Colr
NEXT n

RESTORE CustomCOLORS
REDIM Colors(6)
FOR n = 0 TO 6
    READ Colors(n)
NEXT n

CColor = 0
FOR n = 0 TO 6
    OUT &H3C8, Colors(n)
    FOR i = 1 TO 3
        OUT &H3C9, CustomCOLORS(BikeCOLOR, CColor)
        CColor = CColor + 1
    NEXT i
NEXT n

IF FlameSTYLE THEN
    SELECT CASE FlameSTYLE
        CASE 1: RESTORE FlameCOLOR
        CASE 2: RESTORE SilverCOLOR
        CASE 3: RESTORE GoldCOLOR
        CASE 4: RESTORE WhiteCOLOR
    END SELECT
    OUT &H3C8, 8
    FOR i = 1 TO 3
        READ Colr: OUT &H3C9, Colr
    NEXT i
    OUT &H3C8, 12
    FOR i = 1 TO 3
        READ Colr: OUT &H3C9, Colr
    NEXT i
    OUT &H3C8, 14
    FOR i = 1 TO 3
        READ Colr: OUT &H3C9, Colr
    NEXT i
END IF

OUT &H3C8, 9: OUT &H3C9, 21: OUT &H3C9, 21: OUT &H3C9, 63
OUT &H3C8, 11: OUT &H3C9, 63: OUT &H3C9, 0: OUT &H3C9, 0

END SUB

SUB ShowMOUSE
LB = 1
MouseDRIVER LB, 0, 0, 0
END SUB

SUB Tire (x, y, Outer, Inner)

CIRCLE (x, y), Outer, 2
CIRCLE STEP(0, 0), Inner, 2
PaintSPOT = Outer - 4
PAINT (x, y - PaintSPOT), 1, 2
CIRCLE (x, y), Outer, 1
CIRCLE (x, y), Outer - 1, 2, 30 * Degree!, 210 * Degree!
CIRCLE (x, y), Outer - 3, 2, 30 * Degree!, 210 * Degree!
Tread x, y, Outer - 1, 120, 300, 5
Tread x, y, Outer - 3, 120, 300, 5
Tread x, y, Outer - 1, 300, 475, 2
Tread x, y, Outer - 3, 300, 475, 2
IF Outer - Inner > 14 THEN
    CIRCLE (x, y), Outer - 6, 2, 30 * Degree!, 210 * Degree!
    Tread x, y, Outer - 6, 120, 300, 5
    Tread x, y, Outer - 6, 300, 475, 2
END IF

END SUB

SUB Tread (x, y, Radius, StartDEG, StopDEG, Colr)

FOR n = StartDEG TO StopDEG STEP 5
    Adj = Radius * SIN(n * Degree!)
    Opp = Radius * COS(n * Degree!)
    PSET (x + Adj, y + Opp), Colr
NEXT n

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
