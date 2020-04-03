CHDIR ".\programs\samples\thebob\animax"

'*****************************************************************************
'-------------------------- A N I M A X ! . B A S ----------------------------
'---------------------- A Graphics/Animation Utility -------------------------
'------------ Copyright (C) 2001-2007 by Bob Seguin (Freeware) ---------------
'*****************************************************************************

DEFINT A-Z

DECLARE FUNCTION InitMOUSE ()
DECLARE FUNCTION CancelBOX ()
DECLARE FUNCTION SavePROMPT ()

DECLARE SUB MouseSTATUS (LB, RB, MouseX, MouseY)
DECLARE SUB ShowMOUSE ()
DECLARE SUB HideMOUSE ()
DECLARE SUB LocateMOUSE (x, y)
DECLARE SUB PauseMOUSE (LB, RB, MouseX, MouseY)
DECLARE SUB ClearMOUSE ()
DECLARE SUB MouseDRIVER (LB, RB, Mx, My)
DECLARE SUB PrintSTRING (x, y, Prnt$, Font)
DECLARE SUB DrawSCREEN ()
DECLARE SUB LoadFILE ()
DECLARE SUB SetRECENT (Mode)
DECLARE SUB MenuBAR (InOUT)
DECLARE SUB ToolBAR ()
DECLARE SUB AniFILE (MenuITEM)
DECLARE SUB AniEDIT (MenuITEM)
DECLARE SUB AniCOLOR (MenuITEM)
DECLARE SUB AniSPECIAL (Trick)
DECLARE SUB AniHELP (OnWHAT)
DECLARE SUB WorkAREA ()
DECLARE SUB RunBUTTONS ()
DECLARE SUB LogoFRAME (Frame)
DECLARE SUB ColorBAR ()
DECLARE SUB DisplayERROR (ErrorNUM)
DECLARE SUB DisplayFRAMES ()
DECLARE SUB Interval (Length!)
DECLARE SUB PrintBLURB ()
DECLARE SUB PrintFRAME ()
DECLARE SUB SetXY ()
DECLARE SUB ScaleFRAME ()
DECLARE SUB ScaleUP ()
DECLARE SUB DrawBOX (x1, y1, x2, y2, Mode)

'$DYNAMIC
DIM SHARED Box(1 TO 26217)
DIM SHARED WindowBOX(18800)
DIM SHARED FontBOX(4700)
DIM SHARED TitleBOX(122)
DIM SHARED CopyBOX(1 TO 1650)
DIM SHARED UndoBOX(1 TO 1650)
DIM SHARED ItemBOX(1 TO 366)
DIM SHARED PaletteITEM(1 TO 312)
DIM SHARED ColorBOX(1 TO 672)
DIM SHARED ToolBOX(1 TO 12)
DIM SHARED FBox(1 TO 5)
DIM SHARED MenuBOX(280)
DIM SHARED FChar(1 TO 124)
DIM SHARED FileNAME$, PrintNAME$
DIM SHARED Workdone, Scale, Blurb, WClr
DIM SHARED Menu, WorkingTOOL, ExTOOL, Filled
DIM SHARED FrameCOUNT, FrameNUM
Scale = 5: ExTOOL = 1

TYPE RecentTYPE
PName AS STRING * 8
FName AS STRING * 130
END TYPE
DIM SHARED Recent(1 TO 6) AS RecentTYPE
OPEN "recent.axd" FOR RANDOM AS #1 LEN = LEN(Recent(1))
FOR n = 1 TO 6
GET #1, n, Recent(n)
NEXT n

DEF SEG = VARSEG(FontBOX(0))
BLOAD "animssr.fnt", VARPTR(FontBOX(0))
DEF SEG = VARSEG(ColorBOX(1))
BLOAD "anihues.bsv", VARPTR(ColorBOX(1))
DEF SEG

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
CLOSE #1
SYSTEM
END IF

RESTORE xDATA
FOR n = 1 TO 12: READ ToolBOX(n): NEXT n
RESTORE yDATA
FOR n = 1 TO 5: READ FBox(n): NEXT n

ON ERROR GOTO PathPROB

SCREEN 12
DrawSCREEN
GOSUB Clock
ON TIMER(1) GOSUB Clock
TIMER ON
ShowMOUSE

DO
MouseSTATUS LB, RB, MouseX, MouseY
SELECT CASE MouseY
CASE 0 TO 15
SELECT CASE MouseX
CASE 623 TO 639
IF LB = -1 THEN
HideMOUSE
DrawBOX 624, 2, 638, 15, 1
ShowMOUSE
Interval .1
HideMOUSE
DrawBOX 624, 2, 638, 15, 0
ShowMOUSE
Interval .1
ExitPROMPT = 10
AniFILE ExitPROMPT
IF ExitPROMPT <> 11 THEN CLOSE #1: SYSTEM
END IF
CASE ELSE
IF Menu THEN MenuBAR 0
END SELECT
CASE 16 TO 45
SELECT CASE MouseX
CASE 7 TO 236: MenuBAR 1
CASE 245 TO 600: ToolBAR
CASE ELSE: IF Menu THEN MenuBAR 0
END SELECT
CASE 57 TO 57 + Scale * 68 - 1
SELECT CASE MouseX
CASE 167 TO 167 + Scale * 90 - 1
WorkAREA
CASE ELSE
IF Menu THEN MenuBAR 0
END SELECT
CASE 400 TO 444
SELECT CASE MouseX
CASE 0 TO 145: RunBUTTONS
CASE 200 TO 632: ColorBAR
IF Menu THEN MenuBAR 0
CASE ELSE
IF Menu THEN MenuBAR 0
END SELECT
CASE ELSE
IF Menu THEN MenuBAR 0
END SELECT

IF Started = 0 THEN
DO
PauseMOUSE LB, RB, MouseX, MouseY
OUT &H3C7, 0
FOR n = 9 TO 56
Box(n) = INP(&H3C9)
NEXT n
FrameCOUNT = 1
Box(57) = FrameCOUNT
HideMOUSE
LINE (30, 194)-(119, 261), 15, BF
LINE (166, 56)-(615, 395), 15, BF
GET (30, 194)-(119, 261), Box(58)
FrameNUM = 1
PrintFRAME
ShowMOUSE
Started = 1
EXIT DO
LOOP
END IF

LOOP

CLOSE #1
SYSTEM

Clock:
Hour$ = MID$(TIME$, 1, 2)
IF VAL(Hour$) >= 12 THEN APM$ = " PM" ELSE APM$ = " AM"
Hour$ = LTRIM$(RTRIM$(STR$(VAL(Hour$) MOD 12)))
IF VAL(Hour$) = 0 THEN Hour$ = "12"
Minute$ = MID$(TIME$, 4, 2)
HideMOUSE
IF Hour$ <> OldHOUR$ THEN
LINE (566, 456)-(622, 471), 7, BF
IF LEN(Hour$) = 2 THEN
PrintSTRING 569, 459, "1", 1
PrintSTRING 575, 459, MID$(Hour$, 2, 1), 1
ELSE
PrintSTRING 575, 459, Hour$, 1
END IF
PrintSTRING 583, 458, ":", 1
PrintSTRING 599, 459, APM$, 1
OldHOUR$ = Hour$
END IF
LINE (587, 456)-(597, 471), 7, BF
IF MID$(Minute$, 1, 1) = "1" THEN
PrintSTRING 587, 459, "1", 1
PrintSTRING 593, 459, MID$(Minute$, 2, 1), 1
ELSE
PrintSTRING 587, 459, Minute$, 1
END IF
ShowMOUSE
RETURN

PathPROB:
PathERROR = 1
RESUME NEXT

xDATA:
DATA 255,280,313,338,363,388,413,438,463,508,533,558

yDATA:
DATA 338, 268, 194, 120, 50

REM $STATIC
SUB AniCOLOR (MenuITEM)
STATIC Mx, My, LB

TIMER OFF
ClearMOUSE
SELECT CASE MenuITEM
CASE 1
DEF SEG = VARSEG(WindowBOX(0))
BLOAD "anibox2.bsv", VARPTR(WindowBOX(0))
DEF SEG
HideMOUSE
GET (181, 90)-(460, 222), WindowBOX(9400)
PUT (181, 90), WindowBOX, PSET
ShowMOUSE
DO
MouseSTATUS LB, RB, MouseX, MouseY
IF MouseY > 95 AND MouseY < 110 THEN
IF MouseX > 437 AND MouseX < 453 THEN
IF CancelBOX THEN TIMER ON: EXIT SUB
END IF
END IF
SELECT CASE MouseX
CASE 204 TO 274
xx = 206
SELECT CASE MouseY
CASE 120 TO 133: ItemNUM = 1: yy = 120: GOSUB Itemize
CASE 134 TO 147: ItemNUM = 2: yy = 134: GOSUB Itemize
CASE 148 TO 161: ItemNUM = 3: yy = 148: GOSUB Itemize
CASE 162 TO 175: ItemNUM = 4: yy = 162: GOSUB Itemize
CASE 176 TO 189: ItemNUM = 5: yy = 176: GOSUB Itemize
CASE ELSE: GOSUB Otherwise
END SELECT
CASE 290 TO 360
xx = 292
SELECT CASE MouseY
CASE 120 TO 133: ItemNUM = 6: yy = 120: GOSUB Itemize
CASE 134 TO 147: ItemNUM = 7: yy = 134: GOSUB Itemize
CASE 148 TO 161: ItemNUM = 8: yy = 148: GOSUB Itemize
CASE 162 TO 175: ItemNUM = 9: yy = 162: GOSUB Itemize
CASE 176 TO 189: ItemNUM = 10: yy = 176: GOSUB Itemize
CASE ELSE: GOSUB Otherwise
END SELECT
CASE 376 TO 446
xx = 378
SELECT CASE MouseY
CASE 120 TO 133: ItemNUM = 11: yy = 120: GOSUB Itemize
CASE 134 TO 147: ItemNUM = 12: yy = 134: GOSUB Itemize
CASE 148 TO 161: ItemNUM = 13: yy = 148: GOSUB Itemize
CASE 162 TO 175: ItemNUM = 14: yy = 162: GOSUB Itemize
CASE 176 TO 189: ItemNUM = 15: yy = 176: GOSUB Itemize
CASE ELSE: GOSUB Otherwise
END SELECT
CASE ELSE: GOSUB Otherwise
END SELECT

IF LB = -1 THEN
IF Item <> 0 THEN
IF Item = 1 THEN
PALETTE
ELSE
PalSTART = (Item - 2) * 48 + 1
OUT &H3C8, 0
FOR n = PalSTART TO PalSTART + 47
OUT &H3C9, ColorBOX(n)
NEXT n
END IF
HideMOUSE
PUT (181, 90), WindowBOX(9400), PSET
ShowMOUSE
Mx = 0: My = 0
PauseMOUSE LB, RB, MouseX, MouseY
ClearMOUSE
Workdone = 1
TIMER ON
EXIT SUB
END IF
END IF
ClearMOUSE
LOOP
CASE 2
DEF SEG = VARSEG(WindowBOX(0))
BLOAD "anibox3.bsv", VARPTR(WindowBOX(0))
DEF SEG
HideMOUSE
GET (181, 90)-(460, 222), WindowBOX(9400)
PUT (181, 90), WindowBOX, PSET
ShowMOUSE
OldCOLOR = 1: SetCOLOR = 1
ClearMOUSE
OUT &H3C7, 1: Red = INP(&H3C9): Grn = INP(&H3C9): Blu = INP(&H3C9)
OldRED = Red: OldGRN = Grn: OldBLU = Blu
GOSUB SetSLIDER1: GOSUB SetSLIDER2: GOSUB SetSLIDER3

DO
MouseSTATUS LB, RB, MouseX, MouseY
SELECT CASE MouseY
CASE 95 TO 110
IF MouseX > 437 AND MouseX < 453 THEN
IF CancelBOX THEN TIMER ON: EXIT SUB
END IF
CASE 131 TO 147
IF MouseX > 191 AND MouseX < 450 THEN
IF LB = -1 THEN
HideMOUSE
TryCOLOR = POINT(MouseX, MouseY)
ShowMOUSE
IF TryCOLOR <> 0 AND TryCOLOR <> 7 THEN
IF TryCOLOR <> 8 AND TryCOLOR <> 15 THEN
SetCOLOR = TryCOLOR
END IF
END IF
END IF
END IF
CASE 154 TO 164: Slider = 1: GOSUB SetSLIDER 'slider 1
CASE 166 TO 176: Slider = 2: GOSUB SetSLIDER 'slider 2
CASE 178 TO 188: Slider = 3: GOSUB SetSLIDER 'slider 3
CASE 192 TO 215
IF LB = -1 THEN
IF MouseX > 356 AND MouseX < 403 THEN 'Cancel
OUT &H3C8, OldCOLOR
OUT &H3C9, OldRED
OUT &H3C9, OldGRN
OUT &H3C9, OldBLU
HideMOUSE
LINE (352, 191)-(400, 216), 7, B
DrawBOX 353, 192, 399, 215, 1
ShowMOUSE
Interval .1
HideMOUSE
LINE (352, 191)-(400, 216), 0, B
DrawBOX 353, 192, 399, 215, 0
ShowMOUSE
Interval .1
HideMOUSE
PUT (181, 90), WindowBOX(9400), PSET
ShowMOUSE
TIMER ON
EXIT SUB
END IF
IF MouseX > 404 AND MouseX < 451 THEN 'OK
HideMOUSE
LINE (403, 191)-(451, 216), 7, B
DrawBOX 404, 192, 450, 215, 1
ShowMOUSE
Interval .1
HideMOUSE
LINE (403, 191)-(451, 216), 0, B
DrawBOX 404, 192, 450, 215, 0
ShowMOUSE
Interval .1
HideMOUSE
PUT (181, 90), WindowBOX(9400), PSET
ShowMOUSE
Workdone = 1
TIMER ON
EXIT SUB
END IF
END IF
END SELECT
IF OldCOLOR <> SetCOLOR THEN

OUT &H3C8, OldCOLOR
OUT &H3C9, OldRED
OUT &H3C9, OldGRN
OUT &H3C9, OldBLU

OUT &H3C7, SetCOLOR
Red = INP(&H3C9)
Grn = INP(&H3C9)
Blu = INP(&H3C9)

HideMOUSE
LINE (402, 155)-(450, 186), SetCOLOR, BF
ShowMOUSE

GOSUB SetSLIDER1
GOSUB SetSLIDER2
GOSUB SetSLIDER3
OldCOLOR = SetCOLOR
OldRED = Red
OldGRN = Grn
OldBLU = Blu
END IF
ClearMOUSE
LOOP
END SELECT

EXIT SUB

SetSLIDER:
IF LB THEN
IF MouseX > 209 AND MouseX < 365 THEN
IF MouseX > 358 THEN MouseX = 358
IF MouseX < 216 THEN MouseX = 216
SliderVAL = (MouseX - 216) / 9 * 4
SELECT CASE Slider
CASE 1: Red = SliderVAL: GOSUB SetSLIDER1
CASE 2: Grn = SliderVAL: GOSUB SetSLIDER2
CASE 3: Blu = SliderVAL: GOSUB SetSLIDER3
END SELECT
END IF
END IF
RETURN

SetSLIDER1:
RedX = Red / 4 * 9 + 209
IF RedX <> OldRX THEN
HideMOUSE
IF OldRX THEN PUT (OldRX, 155), WindowBOX(9300), PSET
PUT (RedX, 155), WindowBOX(9200), PSET
LINE (377, 155)-(390, 165), 7, BF
PrintSTRING 377, 155, LTRIM$(STR$(Red)), 2
ShowMOUSE
OldRX = RedX
GOSUB SetCOLOR
END IF
RETURN

SetSLIDER2:
GrnX = Grn / 4 * 9 + 209
IF GrnX <> OldGX THEN
HideMOUSE
IF OldGX THEN PUT (OldGX, 167), WindowBOX(9300), PSET
PUT (GrnX, 167), WindowBOX(9200), PSET
LINE (377, 167)-(390, 177), 7, BF
PrintSTRING 377, 167, LTRIM$(STR$(Grn)), 2
ShowMOUSE
OldGX = GrnX
GOSUB SetCOLOR
END IF
RETURN

SetSLIDER3:
BluX = Blu / 4 * 9 + 209
IF BluX <> OldBX THEN
HideMOUSE
IF OldBX THEN PUT (OldBX, 179), WindowBOX(9300), PSET
PUT (BluX, 179), WindowBOX(9200), PSET
LINE (377, 179)-(390, 189), 7, BF
PrintSTRING 377, 179, LTRIM$(STR$(Blu)), 2
ShowMOUSE
OldBX = BluX
GOSUB SetCOLOR
END IF
RETURN

SetCOLOR:
OUT &H3C8, SetCOLOR
OUT &H3C9, Red
OUT &H3C9, Grn
OUT &H3C9, Blu
RETURN

Itemize:
IF Item <> ItemNUM THEN
HideMOUSE
IF Mx THEN PUT (Mx, My), PaletteITEM, PSET
Mx = xx: My = yy
GET (Mx, My)-(Mx + 72, My + 14), PaletteITEM
PUT (Mx, My), PaletteITEM, PRESET
ShowMOUSE
Item = ItemNUM
END IF
RETURN

Otherwise:
IF Item <> 0 THEN
HideMOUSE
IF Mx THEN PUT (Mx, My), PaletteITEM, PSET
ShowMOUSE
Item = 0
END IF
RETURN

END SUB

SUB AniEDIT (MenuITEM)
SHARED Mask, TopLEFTx, TopLEFTy, BottomRIGHTx, BottomRIGHTy
STATIC Tx, Ty, Bx, By, CopyFRAME, WDTH, DPTH, MaskedCOPY, Pasted
TIMER OFF
SELECT CASE MenuITEM
CASE 1: PUT (30, 194), UndoBOX, PSET: ScaleUP 'Undo
CASE 2: 'Copy
HideMOUSE
IF Mask THEN
GOSUB AdjustCOORDINATES
GET (TopLEFTx, TopLEFTy)-(BottomRIGHTx, BottomRIGHTy), CopyBOX
Tx = TopLEFTx: Ty = TopLEFTy: Bx = BottomRIGHTx: By = BottomRIGHTy
WDTH = Bx - Tx: DPTH = By - Ty
Mask = 0: CopyFRAME = FrameNUM: MaskedCOPY = 1: Pasted = 0
ELSE
GET (30, 194)-(119, 261), CopyBOX
Pasted = 0
Tx = 30: Ty = 194: Bx = 119: By = 261
END IF
ScaleUP
ShowMOUSE
CASE 3: 'Paste
IF Pasted = 0 THEN
GET (30, 194)-(119, 261), UndoBOX
IF CopyFRAME <> FrameNUM THEN
IF MaskedCOPY THEN
PUT (Tx, Ty), CopyBOX, PSET
ELSE
PUT (30, 194), CopyBOX, PSET
END IF
GET (30, 194)-(119, 261), Box(58 + (FrameNUM - 1) * 1635)
Workdone = 1
ELSE
IF Mask = 1 THEN
GOSUB AdjustCOORDINATES
PWDTH = BottomRIGHTx - TopLEFTx
PDPTH = BottomRIGHTy - TopLEFTy
IF PWDTH < WDTH THEN Bx = Tx + PWDTH
IF PDPTH < DPTH THEN By = Ty + PDPTH
IF PWDTH >= WDTH THEN Bx = Tx + WDTH
IF PDPTH >= DPTH THEN By = Ty + DPTH
GET (Tx, Ty)-(Bx, By), CopyBOX
PUT (TopLEFTx, TopLEFTy), CopyBOX, PSET
Mask = 0: Pasted = 1
ELSE
PUT (Tx, Ty), CopyBOX, PSET
Pasted = 1
END IF
GET (30, 194)-(119, 261), Box(58 + (FrameNUM - 1) * 1635)
Workdone = 1
END IF
END IF
GET (30, 194)-(119, 261), Box(58 + (FrameNUM - 1) * 1635)
ScaleUP
END SELECT
TIMER ON
EXIT SUB

AdjustCOORDINATES:
IF TopLEFTx > BottomRIGHTx THEN SWAP TopLEFTx, BottomRIGHTx
IF TopLEFTy > BottomRIGHTy THEN SWAP TopLEFTy, BottomRIGHTy
IF TopLEFTx < 30 THEN TopLEFTx = 30
IF TopLEFTy < 194 THEN TopLEFTx = 194
IF BottomRIGHTx > 119 THEN BottomRIGHTx = 119
IF BottomRIGHTy > 261 THEN BottomRIGHTy = 261
RETURN

END SUB

SUB AniFILE (MenuITEM)
SHARED Ky$, OldFILENAME$, OldPRINTNAME$
STATIC Cancelled

OldFILENAME$ = FileNAME$: OldPRINTNAME$ = PrintNAME$

TIMER OFF
SELECT CASE MenuITEM
CASE 1 'New
IF Workdone THEN
SELECT CASE SavePROMPT
CASE 0 'x-button/Cancel button
TIMER ON: EXIT SUB
CASE 1 'Yes
GOSUB Yes
GOSUB NewFILE
CASE 2 'No
GOSUB NewFILE
END SELECT
ELSE
GOSUB NewFILE
END IF

CASE 2 'Open
IF Workdone THEN
SELECT CASE SavePROMPT
CASE 0
TIMER ON: EXIT SUB
CASE 1
GOSUB Yes
END SELECT
END IF
Banner = 1
GOSUB GetNAME
IF Cancelled = 1 THEN : Cancelled = 0: TIMER ON: EXIT SUB
LoadFILE

CASE 3 'Save
IF LEN(FileNAME$) = 0 THEN
Banner = 2
GOSUB GetNAME
IF Cancelled = 1 THEN Cancelled = 0: TIMER ON: EXIT SUB
GOSUB CheckEXISTING
GOSUB BSAVEFile
LINE (140, 0)-(300, 16), 0, BF
PrintSTRING 142, 3, PrintNAME$, 0
Workdone = 0
ELSE
GOSUB BSAVEFile
Workdone = 0
END IF

CASE 4 'Save As
Banner = 3
GOSUB GetNAME
IF Cancelled = 1 THEN Cancelled = 0: TIMER ON: EXIT SUB
GOSUB CheckEXISTING
GOSUB BSAVEFile
Workdone = 0
LINE (140, 0)-(300, 16), 0, BF
PrintSTRING 142, 3, PrintNAME$, 0

CASE 5 TO 8 'Open from recent list
FOR n = 1 TO 4
GET #1, n, Recent(n)
NEXT n
FileNUMBER = MenuITEM - 4
P$ = RTRIM$(Recent(FileNUMBER).PName)
IF LEN(P$) THEN
IF Workdone THEN
SELECT CASE SavePROMPT
CASE 0
TIMER ON: EXIT SUB
CASE 1
GOSUB Yes
END SELECT
END IF
FileNAME$ = RTRIM$(Recent(FileNUMBER).FName)
PrintNAME$ = RTRIM$(Recent(FileNUMBER).PName)
LoadFILE
END IF

CASE 9, 10 'Exit (finished)
IF Workdone THEN
SELECT CASE SavePROMPT
CASE 0
IF MenuITEM = 11 THEN MenuITEM = 12
TIMER ON: EXIT SUB
CASE 1
GOSUB Yes
CASE 2
IF MenuITEM = 9 THEN
CLOSE #1
SYSTEM
ELSE
TIMER ON: EXIT SUB
END IF
END SELECT
ELSE
CLOSE #1
SYSTEM
END IF

END SELECT

TIMER ON
EXIT SUB

GetNAME:
DEF SEG = VARSEG(WindowBOX(0))
BLOAD "anibox1.bsv", VARPTR(WindowBOX(0))
DEF SEG
HideMOUSE
GET (181, 90)-(460, 222), WindowBOX(9400)
PUT (181, 90), WindowBOX, PSET
SELECT CASE Banner '1:Open (default), 2:Save, 3:Save As
CASE 2: PUT (193, 98), WindowBOX(7000), PSET
CASE 3: PUT (193, 98), WindowBOX(7300), PSET
END SELECT
ShowMOUSE

n$ = "": Ky$ = "": PrintX = 194: CharNUM = 1

DO
MouseSTATUS LB, RB, MouseX, MouseY
HideMOUSE
LINE (PrintX + 2, 120)-(PrintX + 2, 130), 8
ShowMOUSE
IF LEN(Ky$) THEN
SELECT CASE ASC(Ky$)
CASE 8
IF LEN(n$) THEN
HideMOUSE
CharNUM = CharNUM - 1
LINE (FChar(CharNUM), 120)-(PrintX + 2, 131), 15, BF
PrintX = FChar(CharNUM)
n$ = MID$(n$, 1, LEN(n$) - 1)
LINE (PrintX + 2, 120)-(PrintX + 2, 130), 8
ShowMOUSE
END IF
CASE 13
GOSUB MakeNAME
RETURN
CASE 46, 48 TO 58, 65 TO 90, 92, 95, 97 TO 122, 126
IF PrintX < 440 THEN
FChar(CharNUM) = PrintX
CharNUM = CharNUM + 1
HideMOUSE
LINE (PrintX + 2, 120)-(PrintX + 2, 130), 15
PrintSTRING PrintX, 120, Ky$, 1
LINE (PrintX + 2, 120)-(PrintX + 2, 130), 8
ShowMOUSE
n$ = n$ + Ky$
END IF
END SELECT
END IF

SELECT CASE MouseY
CASE 95 TO 110
IF MouseX > 437 AND MouseX < 453 THEN
IF CancelBOX THEN Cancelled = 1: RETURN
END IF
CASE 150 TO 173
SELECT CASE MouseX
CASE 355 TO 401 'Cancel
IF LB = -1 THEN
HideMOUSE
LINE (355, 150)-(401, 173), 7, B
ShowMOUSE
Interval .1
HideMOUSE
DrawBOX 355, 150, 401, 173, 0
ShowMOUSE
Interval .1
HideMOUSE
PUT (181, 90), WindowBOX(9400), PSET
ShowMOUSE
Cancelled = 1
ClearMOUSE
RETURN
END IF
CASE 406 TO 452 'OK
IF LB = -1 THEN
HideMOUSE
LINE (406, 150)-(452, 173), 7, B
ShowMOUSE
Interval .1
HideMOUSE
DrawBOX 406, 150, 452, 173, 0
ShowMOUSE
Interval .1
GOSUB MakeNAME
RETURN
END IF
END SELECT
END SELECT
PauseMOUSE LB, RB, MouseX, MouseY
LOOP
RETURN

CheckEXISTING:
OPEN FileNAME$ FOR BINARY AS #2
IF LOF(2) THEN
CLOSE #2
DisplayERROR 2
FileNAME$ = OldFILENAME$
PrintNAME$ = OldPRINTNAME$
TIMER ON
EXIT SUB
END IF
CLOSE #2
RETURN

BSAVEFile:
FOR n = 1 TO 8
Char$ = MID$(PrintNAME$, n, 1)
Box(n) = ASC(Char$)
NEXT n
OUT &H3C7, 0
FOR n = 9 TO 56
Box(n) = INP(&H3C9)
NEXT n
Box(57) = FrameCOUNT
GET (30, 194)-(119, 261), Box(58 + (FrameNUM - 1) * 1635)
DEF SEG = VARSEG(Box(1))
BSAVE FileNAME$, VARPTR(Box(1)), (57 + Box(57) * 1635) * 2&
DEF SEG
SetRECENT 1
Workdone = 0
RETURN

NewFILE:
HideMOUSE
LINE (30, 194)-(119, 261), 15, BF
GET (30, 194)-(119, 261), UndoBOX
IF Scale = 5 THEN
LINE (166, 56)-(615, 395), 15, BF
ELSE
LINE (166, 56)-(435, 259), 15, BF
END IF
FrameCOUNT = 1
FOR Reps = 1 TO 5
IF Reps = 3 THEN Reps = 4
LogoFRAME Reps
NEXT Reps
FileNAME$ = ""
PrintNAME$ = ""
LINE (140, 0)-(300, 16), 0, BF
PrintSTRING 142, 3, "untitled", 0
FrameNUM = 1
PrintFRAME
ShowMOUSE
PALETTE
Workdone = 0
TIMER ON
EXIT SUB
RETURN

MakeNAME:
IF LEN(n$) THEN
FOR n = LEN(n$) TO 1 STEP -1
Char$ = MID$(n$, n, 1)
IF Char$ = "." THEN Dot = n
IF Char$ = "\" THEN Slash = n: EXIT FOR
NEXT n
IF Dot THEN n$ = MID$(n$, 1, Dot - 1)
IF Slash THEN Path$ = MID$(n$, 1, Slash)
IF Slash THEN n$ = MID$(n$, Slash + 1, 8)
IF LEN(n$) > 8 THEN n$ = LEFT$(n$, 8)
Cap$ = UCASE$(MID$(n$, 1, 1))
LC$ = MID$(n$, 2)
PrintNAME$ = Cap$ + LC$ + SPACE$(8 - LEN(n$))
FileNAME$ = Path$ + n$ + ".AXB"
ELSE
Cancelled = 1
HideMOUSE
PUT (181, 90), WindowBOX(9400), PSET
ShowMOUSE
RETURN
END IF
HideMOUSE
PUT (181, 90), WindowBOX(9400), PSET
ShowMOUSE
RETURN

Yes:
IF LEN(FileNAME$) THEN
GOSUB BSAVEFile
ELSE
Banner = 2
GOSUB GetNAME
IF Cancelled THEN
Cancelled = 0
IF MenuITEM = 6 THEN MenuITEM = 7
TIMER ON
EXIT SUB
END IF
GOSUB CheckEXISTING
GOSUB BSAVEFile
END IF
RETURN

END SUB

SUB AniHELP (OnWHAT)
SHARED LB
HideMOUSE
GET (181, 90)-(460, 220), WindowBOX(9400)
ShowMOUSE
TIMER OFF
SELECT CASE OnWHAT
CASE 1 'Instructions
PageNUM = 1
GOSUB PutHELP
DO
MouseSTATUS LB, RB, MouseX, MouseY
IF MouseY > 95 AND MouseY < 110 THEN
SELECT CASE MouseX
CASE 380 TO 400: Button = 1
CASE 405 TO 425: Button = 2
CASE 438 TO 452: Button = 3
END SELECT
IF Button = 3 THEN IF CancelBOX THEN TIMER ON: EXIT SUB
IF Button = 1 OR Button = 2 THEN
IF LB = -1 THEN
IF Button = 1 AND PageNUM > 1 THEN PageNUM = PageNUM - 1
IF Button = 2 AND PageNUM < 10 THEN PageNUM = PageNUM + 1
GOSUB PutHELP
ClearMOUSE
END IF
END IF
END IF
LOOP
CASE 2 'Load Demo
IF Workdone = 0 THEN
PrintNAME$ = "Book"
FileNAME$ = "Book.AXB"
LoadFILE
ELSE
DisplayERROR 4
END IF
ClearMOUSE

CASE 3 'About
PageNUM = 11
GOSUB PutHELP
DO
MouseSTATUS LB, RB, MouseX, MouseY
IF MouseY > 95 AND MouseY < 110 THEN
IF MouseX > 437 AND MouseX < 453 THEN
IF CancelBOX THEN EXIT DO
END IF
END IF
LOOP
END SELECT

TIMER ON
EXIT SUB

PutHELP:
DEF SEG = VARSEG(WindowBOX(0))
FileNAME$ = "AxHELP" + LTRIM$(STR$(PageNUM)) + ".BSV"
BLOAD FileNAME$, VARPTR(WindowBOX(0))
HideMOUSE
PUT (181, 90), WindowBOX, PSET
ShowMOUSE
RETURN

END SUB

SUB AniSPECIAL (Trick)
TIMER OFF
GET (30, 194)-(119, 261), UndoBOX
SELECT CASE Trick
CASE 1 'flip horizontally
FOR x = 30 TO 75
GET (x, 194)-(x, 261), WindowBOX(9400)
GET (149 - x, 194)-(149 - x, 261), WindowBOX(9600)
PUT (149 - x, 194), WindowBOX(9400), PSET
PUT (x, 194), WindowBOX(9600), PSET
NEXT x
CASE 2 'flip vertically
FOR y = 194 TO 227
GET (30, y)-(119, y), WindowBOX(9400)
GET (30, 455 - y)-(119, 455 - y), WindowBOX(9600)
PUT (30, 455 - y), WindowBOX(9400), PSET
PUT (30, y), WindowBOX(9600), PSET
NEXT y
CASE 3 'negative
GET (30, 194)-(119, 261), WindowBOX(9400)
PUT (30, 194), WindowBOX(9400), PRESET
END SELECT
Workdone = 1
ScaleUP
TIMER ON

END SUB

FUNCTION CancelBOX

MouseSTATUS LB, RB, MouseX, MouseY
IF LB = -1 THEN
HideMOUSE
DrawBOX 438, 96, 452, 109, 1
ShowMOUSE
Interval .1
HideMOUSE
DrawBOX 438, 96, 452, 109, 0
ShowMOUSE
Interval .1
HideMOUSE
PUT (181, 90), WindowBOX(9400), PSET
ShowMOUSE
Mx = 0: My = 0
ClearMOUSE
CancelBOX = 1
END IF

END FUNCTION

SUB ClearMOUSE
SHARED LB, RB, MouseX, MouseY

WHILE LB OR RB
MouseSTATUS LB, RB, MouseX, MouseY
WEND

END SUB

SUB ColorBAR
SHARED MouseX, MouseY, LB
TIMER OFF
IF LB = -1 THEN
IF MouseY > 423 AND MouseY < 434 THEN
SELECT CASE MouseX
CASE 201 TO 222: WClr = 0
CASE 227 TO 248: WClr = 8
CASE 253 TO 274: WClr = 7
CASE 279 TO 300: WClr = 15
CASE ELSE
HideMOUSE
TC = POINT(MouseX, MouseY)
ShowMOUSE
IF TC <> 0 AND TC <> 7 AND TC <> 8 AND TC <> 15 THEN
IF TC <> WClr THEN WClr = TC
END IF
END SELECT
END IF
HideMOUSE
LINE (152, 424)-(189, 433), WClr, BF
ShowMOUSE
ClearMOUSE
END IF
TIMER ON
END SUB

SUB DisplayERROR (ErrorNUM)

DEF SEG = VARSEG(WindowBOX(0))
BLOAD "anibox4.bsv", VARPTR(WindowBOX(0))
DEF SEG
HideMOUSE
GET (181, 90)-(460, 222), WindowBOX(9400)
PUT (181, 90), WindowBOX, PSET
SELECT CASE ErrorNUM
CASE 1: 'default - file/path error
CASE 2: PUT (223, 125), WindowBOX(5535), PSET 'name in use
CASE 3: PUT (223, 125), WindowBOX(6650), PSET 'not Animax! file
CASE 4: PUT (223, 125), WindowBOX(7765), PSET 'save before demo
END SELECT
ShowMOUSE

DO
MouseSTATUS LB, RB, MouseX, MouseY
IF LB = -1 THEN
SELECT CASE MouseY
CASE 95 TO 110
IF MouseX > 437 AND MouseX < 453 THEN
IF CancelBOX THEN EXIT SUB
END IF
CASE 125 TO 149
IF MouseX > 401 AND MouseX < 450 THEN
HideMOUSE
LINE (402, 125)-(449, 149), 7, B
ShowMOUSE
Interval .1
HideMOUSE
DrawBOX 402, 125, 449, 149, 0
ShowMOUSE
Interval .1
HideMOUSE
PUT (181, 90), WindowBOX(9400), PSET
ShowMOUSE
ClearMOUSE
EXIT SUB
END IF
END SELECT
END IF
LOOP

END SUB

SUB DisplayFRAMES
HideMOUSE
FOR n = FrameNUM - 2 TO FrameNUM + 2
Frame = Frame + 1
IF n < 1 OR n > FrameCOUNT THEN
LogoFRAME Frame
ELSE
PUT (30, FBox(Frame)), Box(58 + (n - 1) * 1635), PSET
END IF
NEXT n
PrintFRAME
ShowMOUSE
END SUB

SUB DrawBOX (x1, y1, x2, y2, Mode)
IF Mode = 1 THEN
Colr1 = 8: Colr2 = 15
ELSE
Colr1 = 15: Colr2 = 8
END IF
LINE (x1, y1)-(x2, y2), Colr1, B
LINE (x1, y2)-(x2, y2), Colr2
LINE (x2, y1)-(x2, y2), Colr2
END SUB

SUB DrawSCREEN
SHARED Tx
DEF SEG = VARSEG(Box(1))
FOR y = 0 TO 360 STEP 120
Count = Count + 1
FileNAME$ = "Animax!" + LTRIM$(STR$(Count)) + ".BSV"
BLOAD FileNAME$, VARPTR(Box(1))
PUT (0, y), Box
NEXT y
DEF SEG
GET (60, 218)-(90, 232), TitleBOX
GET (30, 194)-(119, 261), UndoBOX
GET (30, 194)-(119, 261), CopyBOX
'Freehand tool selected
DrawBOX 338, 20, 362, 39, 1
WorkingTOOL = 4: ExTOOL = 4
Tx = 338: FileNAME$ = ""
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

OldTIMER! = TIMER
DO
IF TIMER < OldTIMER! THEN EXIT DO
LOOP UNTIL TIMER > OldTIMER! + Length!

END SUB

DEFINT A-Z
SUB LoadFILE
SHARED PathERROR, OldFILENAME$, OldPRINTNAME$


OPEN FileNAME$ FOR BINARY AS #2
IF LOF(2) THEN
FileEXISTS = 1
ELSE
FileEXISTS = 0
SetRECENT 2
END IF
CLOSE #2

IF FileEXISTS = 0 THEN
DisplayERROR 1
GOSUB NoFILE
END IF

OPEN FileNAME$ FOR BINARY AS #2
PathERROR = 0
IF PathERROR THEN
CLOSE #2
DisplayERROR 1
GOSUB NoFILE
ELSE
t$ = " "
GET #2, , t$
IF (LOF(2) - 7) / 2 >= 1692 AND t$ = CHR$(253) THEN
CLOSE #2
SetRECENT 1
DEF SEG = VARSEG(Box(1))
BLOAD FileNAME$, VARPTR(Box(1))
DEF SEG
Workdone = 0
ELSE
DisplayERROR 3
GOSUB NoFILE
END IF
END IF

LINE (166, 56)-(166 + Scale * 90 - 1, 56 + Scale * 68 - 1), 8, BF

PrintNAME$ = ""
FOR n = 1 TO 8
PrintNAME$ = PrintNAME$ + CHR$(Box(n))
NEXT n
OldPRINTNAME$ = PrintNAME$
HideMOUSE
LINE (140, 0)-(300, 16), 0, BF
PrintSTRING 142, 3, PrintNAME$, 0
ShowMOUSE
OUT &H3C8, 0
FOR n = 9 TO 56
OUT &H3C9, Box(n)
NEXT n
FrameCOUNT = Box(57)
HideMOUSE
LogoFRAME 1
LogoFRAME 2
FOR Reps = 0 TO FrameCOUNT - 1
PUT (30, FBox(Reps + 3)), Box(58 + Reps * 1635), PSET
IF Reps = 2 THEN EXIT FOR
NEXT Reps
IF FrameCOUNT < 3 THEN LogoFRAME 5
IF FrameCOUNT < 2 THEN LogoFRAME 4
GET (30, 194)-(119, 261), UndoBOX
FrameNUM = 1
PrintFRAME
ScaleUP
ShowMOUSE

EXIT SUB

NoFILE:
FileNAME$ = OldFILENAME$
PrintNAME$ = OldPRINTNAME$
EXIT SUB
RETURN

END SUB

SUB LocateMOUSE (x, y)

LB = 4
Mx = x
My = y
MouseDRIVER LB, 0, Mx, My

END SUB

SUB LogoFRAME (Frame)
LINE (30, FBox(Frame))-(119, FBox(Frame) + 67), 8, BF
LINE (30, FBox(Frame))-(119, FBox(Frame) + 67), 0, B
LINE (32, FBox(Frame) + 2)-(117, FBox(Frame) + 65), 0, B
LINE (34, FBox(Frame) + 4)-(115, FBox(Frame) + 63), 0, B
PUT (60, FBox(Frame) + 24), TitleBOX, PSET
END SUB

SUB MenuBAR (InOUT)
SHARED LB, MouseX
STATIC Mx, Mxx, OldIy, MenuRIGHT, MenuBOTTOM

IF InOUT = 0 THEN GOSUB EraseBUTTON: EXIT SUB
IF Menu > 5 THEN
TIMER OFF
DO
MouseSTATUS LB, RB, MouseX, MouseY
IF MouseY > MenuBOTTOM THEN GOSUB CloseMENU: EXIT SUB
SELECT CASE MouseX
CASE Mx TO MenuRIGHT
SELECT CASE MouseY
CASE IS < 20: GOSUB CloseMENU: EXIT SUB
CASE 20 TO 46
IF MouseX < Mx OR MouseX > Mxx THEN GOSUB CloseMENU: EXIT SUB
CASE 47 TO 60: ItemNUM = 1: Iy = 47: GOSUB LightITEM
CASE 61 TO 74: ItemNUM = 2: Iy = 61: GOSUB LightITEM
CASE 75 TO 88
IF Menu <> 30 THEN
ItemNUM = 3: Iy = 75: GOSUB LightITEM
END IF
CASE 89 TO 102
IF Menu = 10 THEN
ItemNUM = 4: Iy = 89: GOSUB LightITEM
END IF
CASE 112 TO 125
IF Menu = 10 THEN
ItemNUM = 5: Iy = 112: GOSUB LightITEM
END IF
CASE 126 TO 139
IF Menu = 10 THEN
ItemNUM = 6: Iy = 126: GOSUB LightITEM
END IF
CASE 140 TO 153
IF Menu = 10 THEN
ItemNUM = 7: Iy = 140: GOSUB LightITEM
END IF
CASE 154 TO 167
IF Menu = 10 THEN
ItemNUM = 8: Iy = 154: GOSUB LightITEM
END IF
CASE 177 TO 190
IF Menu = 10 THEN
ItemNUM = 9: Iy = 177: GOSUB LightITEM
END IF
END SELECT
IF LB = -1 THEN GOSUB SelectITEM
CASE ELSE
GOSUB CloseMENU: EXIT SUB
END SELECT
LOOP
GOSUB CloseMENU
EXIT SUB
ELSE
SELECT CASE MouseX
CASE 7 TO 47: MenuNUM = 1: ItemX = 7: ItemXX = 47: GOSUB Button
CASE 48 TO 87: MenuNUM = 2: ItemX = 48: ItemXX = 87: GOSUB Button
CASE 88 TO 135: MenuNUM = 3: ItemX = 88: ItemXX = 135: GOSUB Button
CASE 136 TO 193: MenuNUM = 4: ItemX = 136: ItemXX = 193: GOSUB Button
CASE 194 TO 235: MenuNUM = 5: ItemX = 194: ItemXX = 235: GOSUB Button
END SELECT
IF LB = -1 THEN
Menu = Menu * 10
GOSUB DropMENU
END IF
END IF

EXIT SUB

Button:
IF Menu <> MenuNUM THEN
GOSUB EraseBUTTON
Mx = ItemX: Mxx = ItemXX
GOSUB RaiseBUTTON
Menu = MenuNUM
END IF
RETURN

RaiseBUTTON:
HideMOUSE
LINE (Mx, 20)-(Mxx, 39), 15, B
LINE (Mx, 39)-(Mxx, 39), 8
LINE (Mxx, 20)-(Mxx, 39), 8
ShowMOUSE
RETURN

EraseBUTTON:
IF Menu THEN
HideMOUSE
LINE (Mx, 20)-(Mxx, 39), 7, B
ShowMOUSE
END IF
Menu = 0
TIMER ON
RETURN

DropMENU:
IF Menu > 5 THEN
DEF SEG = VARSEG(WindowBOX(0))
BLOAD "animnus.bsv", VARPTR(WindowBOX(0))
DEF SEG
SELECT CASE Menu
CASE 10: Index = 0
CASE 20: Index = 3420
CASE 30: Index = 4220
CASE 40: Index = 5350
CASE 50: Index = 6834
END SELECT
HideMOUSE
LINE (Mx, 20)-(Mxx, 39), 8, B
LINE (Mx, 39)-(Mxx, 39), 15
LINE (Mxx, 20)-(Mxx, 39), 15
GET (Mx, 40)-(Mx + WindowBOX(Index), 194), WindowBOX(9400)
PUT (Mx, 40), WindowBOX(Index), PSET
IF Menu = 10 THEN
num = 1
FOR y = 113 TO 155 STEP 14
x = 30
Name$ = RTRIM$(Recent(num).PName)
FOR n = 1 TO LEN(Name$)
Char$ = MID$(Name$, n, 1)
PrintSTRING x, y, Char$, 1
IF x > 76 THEN
PrintSTRING x, y, "...", 1
EXIT FOR
END IF
NEXT n
num = num + 1
NEXT y
END IF
ShowMOUSE
MenuRIGHT = WindowBOX(Index) + Mx
MenuBOTTOM = WindowBOX(Index + 1) + 39
ClearMOUSE
END IF
RETURN

CloseMENU:
HideMOUSE
PUT (Mx, 40), WindowBOX(9400), PSET
ShowMOUSE
GOSUB EraseBUTTON
RETURN

LightITEM:
IF Item <> ItemNUM THEN
GOSUB DeLIGHT
Ix = Mx + 3: Ixx = MenuRIGHT - 4
GOSUB HiLIGHT
Item = ItemNUM
OldIy = Iy
END IF
RETURN

SelectITEM:
MenuNUM = Menu
GOSUB CloseMENU
Selection = MenuNUM + Item
SELECT CASE Selection
CASE 11 TO 19: AniFILE Selection - 10
CASE 21 TO 23: AniEDIT Selection - 20
CASE 31, 32: AniCOLOR Selection - 30
CASE 41 TO 43: AniSPECIAL Selection - 40
CASE 51 TO 53: AniHELP Selection - 50
END SELECT
EXIT SUB
RETURN

HiLIGHT:
HideMOUSE
GET (Ix, Iy)-(Ixx, Iy + 13), ItemBOX
PUT (Ix, Iy), ItemBOX, PRESET
ShowMOUSE
RETURN

DeLIGHT:
IF Ix THEN
HideMOUSE
PUT (Ix, OldIy), ItemBOX, PSET
ShowMOUSE
END IF
RETURN

END SUB

SUB MouseDRIVER (LB, RB, Mx, My)

DEF SEG = VARSEG(MouseDATA$)
mouse = SADD(MouseDATA$)
CALL ABSOLUTE_MOUSE_EMU (LBLB,  RB RB,  MX Mx,  MY My) 

END SUB

SUB MouseSTATUS (LB, RB, MouseX, MouseY)

LB = 3
MouseDRIVER LB, RB, Mx, My
LB = ((RB AND 1) <> 0)
RB = ((RB AND 2) <> 0)
MouseX = Mx
MouseY = My

END SUB

SUB PauseMOUSE (L, R, x, y)
SHARED Ky$

DO
Ky$ = INKEY$
MouseSTATUS LB, RB, MouseX, MouseY
LOOP UNTIL LB <> L OR R <> OldRB OR MouseX <> x OR MouseY <> y OR Ky$ <> ""

END SUB

SUB PrintBLURB
STATIC OldBLURB
SHARED ButtonsUP
TIMER OFF
IF Blurb <> OldBLURB THEN
LINE (281, 456)-(549, 471), 7, BF
SELECT CASE Blurb
CASE 1: B$ = "Rewind to first frame"
CASE 2: B$ = "Play"
CASE 3: B$ = "Fast forward to last frame"
CASE 4: B$ = "Back one frame"
CASE 5: B$ = "Frame advance (forward one frame)"
CASE 6, 7
IF ButtonsUP = 0 THEN OldBLURB = Blurb: EXIT SUB
IF Blurb = 7 THEN B$ = "Outlined" ELSE B$ = "Filled"
CASE 8: B$ = "Pixel tool: precisely color individual pixels"
CASE 9: B$ = "Freehand drawing tool"
CASE 10: B$ = "Box tool"
CASE 11: B$ = "Circle tool"
CASE 12: B$ = "Elipse tool"
CASE 13: B$ = "Line tool"
CASE 14: B$ = "Floodfill (paint) tool"
CASE 15: B$ = "Mask tool"
CASE 16: B$ = "Zoom tool: toggles between 3x and 5x magnification"
CASE 17: B$ = "Color-swap tool: changes selected color to pen color"
END SELECT
PrintSTRING 288, 459, B$, 1
END IF
OldBLURB = Blurb
TIMER ON
END SUB

SUB PrintFRAME
IF FrameNUM < 10 THEN
Frame$ = "0" + LTRIM$(STR$(FrameNUM))
ELSE
Frame$ = LTRIM$(STR$(FrameNUM))
END IF
LINE (125, 221)-(145, 234), 8, BF
PrintSTRING 130, 222, Frame$, 1
END SUB

SUB PrintSTRING (x, y, Prnt$, Font)

IF Font = 0 THEN
DEF SEG = VARSEG(FontBOX(0))
BLOAD "animssb.fnt", VARPTR(FontBOX(0))
DEF SEG
END IF

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

IF Font = 0 THEN
DEF SEG = VARSEG(FontBOX(0))
BLOAD "animssr.fnt", VARPTR(FontBOX(0))
DEF SEG
END IF

END SUB

SUB RunBUTTONS
SHARED MouseX, MouseY, LB
TIMER OFF
IF MouseY < 414 OR MouseY > 434 THEN
Button = 0
ELSE
SELECT CASE MouseX
CASE 15 TO 38: Bx = 15: Button = 1
CASE 39 TO 62: Bx = 39: Button = 2
CASE 63 TO 86: Bx = 63: Button = 3
CASE 87 TO 110: Bx = 87: Button = 4
CASE 111 TO 134: Bx = 111: Button = 5
CASE ELSE: Button = 0
END SELECT
END IF

Blurb = Button
PrintBLURB

IF LB = -1 THEN
IF Button THEN
HideMOUSE
DrawBOX Bx, 415, Bx + 23, 434, 1
ShowMOUSE
IF Button <> 2 THEN
GET (30, 194)-(119, 261), Box(58 + (FrameNUM - 1) * 1635)
END IF
SELECT CASE Button
CASE 1: FrameNUM = 1: DisplayFRAMES: ScaleUP'rewind to first frame
CASE 2 'play
FOR Frames = 1 TO 5
IF Frames = 3 THEN Frames = 4
LogoFRAME Frames
NEXT Frames
OldFRAMENUM = FrameNUM
FOR n = 1 TO FrameCOUNT
FOR Delay = 1 TO 5
WAIT &H3DA, 8
WAIT &H3DA, 8, 8
NEXT Delay
PUT (30, 194), Box(58 + (n - 1) * 1635), PSET
FrameNUM = n
PrintFRAME
Interval .05
NEXT n
Interval .5
FrameNUM = OldFRAMENUM
DisplayFRAMES
CASE 3: FrameNUM = FrameCOUNT: DisplayFRAMES: ScaleUP 'go to last frame
CASE 4 'back one frame
IF FrameNUM > 1 THEN
FrameNUM = FrameNUM - 1
DisplayFRAMES
GET (30, 194)-(119, 261), UndoBOX
ScaleUP
END IF
CASE 5 'frame advance
IF FrameNUM < 16 THEN
IF FrameNUM = FrameCOUNT THEN
FrameCOUNT = FrameCOUNT + 1
LINE (30, 194)-(119, 261), 15, BF
GET (30, 194)-(119, 261), Box(58 + (FrameCOUNT - 1) * 1635)
Workdone = 1
END IF
FrameNUM = FrameNUM + 1
DisplayFRAMES
GET (30, 194)-(119, 261), UndoBOX
ScaleUP
END IF
END SELECT
Interval .1
HideMOUSE
DrawBOX Bx, 415, Bx + 23, 434, 0
ShowMOUSE
ClearMOUSE
END IF
END IF
TIMER ON
END SUB

FUNCTION SavePROMPT
TIMER OFF
HideMOUSE
DEF SEG = VARSEG(WindowBOX(0))
BLOAD "anibox5.bsv", VARPTR(WindowBOX(0))
DEF SEG
GET (181, 90)-(460, 222), WindowBOX(9400)
PUT (181, 90), WindowBOX, PSET
ShowMOUSE
BEEP

DO
MouseSTATUS LB, RB, MouseX, MouseY
SELECT CASE MouseY
CASE 95 TO 110
IF MouseX > 437 AND MouseX < 453 THEN
IF CancelBOX THEN SavePROMPT = 0: TIMER ON: EXIT FUNCTION
END IF
CASE 168 TO 189
SELECT CASE MouseX
CASE 205 TO 272 'Yes
IF LB THEN
HideMOUSE
LINE (205, 168)-(272, 189), 7, B
GET (222, 172)-(255, 184), ItemBOX
PUT (223, 173), ItemBOX, PSET
ShowMOUSE
Interval .1
HideMOUSE
LINE (205, 168)-(272, 189), 15, B
LINE (272, 168)-(272, 189), 8
LINE (205, 189)-(272, 189), 8
PUT (222, 172), ItemBOX, PSET
ShowMOUSE
Interval .1
SavePROMPT = 1
HideMOUSE
PUT (181, 90), WindowBOX(9400), PSET
ShowMOUSE
TIMER ON
EXIT FUNCTION
END IF
CASE 285 TO 353 'No
IF LB THEN
HideMOUSE
LINE (285, 168)-(353, 189), 7, B
ShowMOUSE
Interval .1
HideMOUSE
DrawBOX 285, 168, 353, 189, 0
ShowMOUSE
Interval .1
SavePROMPT = 2
HideMOUSE
PUT (181, 90), WindowBOX(9400), PSET
ShowMOUSE
TIMER ON
EXIT FUNCTION
END IF
CASE 366 TO 434 'Cancel
IF LB = -1 THEN
HideMOUSE
LINE (366, 168)-(434, 189), 7, B
ShowMOUSE
Interval .1
HideMOUSE
DrawBOX 366, 168, 434, 189, 0
ShowMOUSE
Interval .1
SavePROMPT = 0
HideMOUSE
PUT (181, 90), WindowBOX(9400), PSET
ShowMOUSE
TIMER ON
EXIT FUNCTION
END IF
END SELECT
END SELECT
PauseMOUSE LB, RB, MouseX, MouseY
LOOP

END FUNCTION

SUB ScaleFRAME
HideMOUSE
TIMER OFF
LINE (155, 45)-(626, 406), 8, BF
IF Scale = 5 THEN
LINE (157, 47)-(626, 406), 0, B
LINE (156, 46)-(625, 405), 7, BF
LINE (156, 46)-(625, 405), 15, B
LINE (156, 405)-(625, 405), 8
LINE (625, 46)-(625, 405), 8

LINE (165, 55)-(616, 396), 15, B
LINE (165, 55)-(165, 395), 8
LINE (165, 55)-(615, 55), 8
LINE (166, 56)-(615, 395), 8, BF
ELSE
LINE (157, 47)-(446, 270), 0, B
LINE (156, 46)-(445, 269), 7, BF
LINE (156, 46)-(445, 269), 15, B
LINE (156, 269)-(445, 269), 8
LINE (445, 46)-(445, 269), 8

LINE (166, 56)-(435, 259), 8, BF
LINE (165, 55)-(436, 260), 15, B
LINE (165, 55)-(435, 55), 8
LINE (165, 55)-(165, 259), 8
END IF
ShowMOUSE
ScaleUP
TIMER ON
END SUB

SUB ScaleUP
TIMER OFF
HideMOUSE
FOR y = 0 TO 67
FOR x = 0 TO 89
LINE (x * Scale + 166, y * Scale + 56)-(x * Scale + 166 + Scale - 1, y * Scale + 56 + Scale - 1), POINT(x + 30, y + 194), BF
NEXT x
NEXT y
ShowMOUSE
TIMER ON
END SUB

SUB SetRECENT (Mode)

FOR n = 1 TO 6
GET #1, n, Recent(n)
NEXT n

IF Mode = 1 THEN

FOR n = 6 TO 2 STEP -1 'shift file names down one
Recent(n) = Recent(n - 1)
NEXT n
Recent(1).PName = PrintNAME$ 'add new name to top slot
Recent(1).FName = FileNAME$

ELSE 'file to be removed from recent list

FOR n = 1 TO 6
IF UCASE$(RTRIM$(Recent(n).FName)) = UCASE$(FileNAME$) THEN
Recent(n).PName = SPACE$(8)
Recent(n).FName = SPACE$(130)
END IF
NEXT n
FileNAME$ = OldFILENAME$
PrintNAME$ = OldPRINTNAME$
END IF

FOR n = 1 TO 5 'replace duplicates with blanks
FOR nn = n + 1 TO 6
IF UCASE$(RTRIM$(Recent(nn).PName)) = UCASE$(RTRIM$(Recent(n).PName)) THEN
Recent(nn).PName = SPACE$(8)
Recent(nn).FName = SPACE$(130)
END IF
NEXT nn
NEXT n

FOR n = 1 TO 5 'move all names to top of list, blanks to bottom
IF LEN(RTRIM$(Recent(n).PName)) = 0 THEN
Hop = 1
DO
IF LEN(RTRIM$(Recent(n + Hop).PName)) <> 0 THEN
SWAP Recent(n), Recent(n + Hop)
EXIT DO
END IF
Hop = Hop + 1
IF Hop + n > 6 THEN EXIT DO
LOOP
END IF
NEXT n

FOR n = 1 TO 6 'put new list configuration in file
PUT #1, n, Recent(n)
NEXT n

END SUB

SUB SetXY
SHARED MouseX, MouseY
STATIC ExX, ExY
IF MouseX > 165 AND MouseX < 165 + Scale * 90 THEN
IF MouseY > 55 AND MouseY < 55 + Scale * 68 THEN
IF MouseX <> ExX OR MouseY <> ExY THEN
PixelX = (MouseX - 166) \ Scale
PixelY = (MouseY - 55) \ Scale
WAIT &H3DA, 8
WAIT &H3DA, 8, 8
LINE (71, 459)-(91, 470), 15, BF
PrintSTRING 71, 459, STR$(PixelX), 1
LINE (102, 459)-(122, 470), 15, BF
PrintSTRING 102, 459, STR$(PixelY), 1
ExX = PixelX: ExY = PixelY
END IF
END IF
END IF
END SUB

SUB ShowMOUSE

LB = 1
MouseDRIVER LB, 0, 0, 0

END SUB

SUB ToolBAR
SHARED MouseX, MouseY, LB, ButtonsUP

TIMER OFF
IF MouseY < 20 OR MouseY > 40 THEN
Tool = -5
ELSE
SELECT CASE MouseX
CASE 255 TO 279: Tool = 1
CASE 280 TO 304: Tool = 2
CASE 313 TO 337: Tool = 3
CASE 338 TO 362: Tool = 4
CASE 363 TO 387: Tool = 5: ChangeSCALE = 1: xx = 364
CASE 388 TO 412: Tool = 6: ChangeSCALE = 1: xx = 389
CASE 413 TO 437: Tool = 7: ChangeSCALE = 1: xx = 414
CASE 438 TO 462: Tool = 8: ChangeSCALE = 1
CASE 463 TO 487: Tool = 9
CASE 508 TO 532: Tool = 10: ChangeSCALE = 1
CASE 533 TO 557: Tool = 11: IF LB = -1 THEN GOSUB Mag
CASE 558 TO 582: Tool = 12
CASE ELSE: Tool = -5
END SELECT
END IF

Blurb = Tool + 5
PrintBLURB

IF LB = -1 THEN
IF Tool > 2 THEN
IF Tool <> WorkingTOOL THEN
HideMOUSE
DrawBOX ToolBOX(WorkingTOOL), 20, ToolBOX(WorkingTOOL) + 24, 39, 0
WorkingTOOL = Tool
DrawBOX ToolBOX(WorkingTOOL), 20, ToolBOX(WorkingTOOL) + 24, 39, 1
ShowMOUSE
w = WorkingTOOL
IF w = 5 OR w = 6 OR w = 7 THEN
HideMOUSE
GET (xx, 21)-(xx + 22, 38), ItemBOX
PUT (281, 21), ItemBOX, PSET
PUT (256, 21), ItemBOX, PSET
PAINT (267, 30), 0
DrawBOX 280, 20, 304, 39, Filled + 1
DrawBOX 255, 20, 279, 39, Filled
ShowMOUSE
ButtonsUP = 1
ELSE
IF WorkingTOOL <> 1 AND WorkingTOOL <> 2 THEN
HideMOUSE
LINE (254, 20)-(312, 39), 7, BF
ButtonsUP = 0
ShowMOUSE
END IF
END IF
END IF
ELSE
IF ButtonsUP = 1 THEN
IF Tool = 1 THEN Filled = 1 ELSE Filled = 0
HideMOUSE
DrawBOX ToolBOX(1), 20, ToolBOX(1) + 24, 39, Filled
DrawBOX ToolBOX(2), 20, ToolBOX(2) + 24, 39, Filled + 1
ShowMOUSE
END IF
END IF
IF ChangeSCALE = 1 THEN
IF Scale = 5 THEN
Scale = 3
ScaleFRAME
END IF
END IF
ExTOOL = WorkingTOOL
GOSUB CloseUP
END IF

EXIT SUB

CloseUP:
ClearMOUSE
TIMER ON
EXIT SUB
RETURN

Mag:
IF Scale = 3 THEN
w = WorkingTOOL
IF w = 5 OR w = 6 OR w = 7 OR w = 8 OR w = 10 THEN
HideMOUSE
DrawBOX ToolBOX(WorkingTOOL), 20, ToolBOX(WorkingTOOL) + 24, 39, 0
WorkingTOOL = 4
DrawBOX ToolBOX(WorkingTOOL), 20, ToolBOX(WorkingTOOL) + 24, 39, 1
LINE (254, 20)-(312, 39), 7, BF
ButtonsUP = 0
ShowMOUSE
END IF
END IF
IF Scale = 3 THEN Scale = 5 ELSE Scale = 3
HideMOUSE
DrawBOX ToolBOX(11), 20, ToolBOX(11) + 24, 39, 1
ScaleFRAME
DrawBOX ToolBOX(11), 20, ToolBOX(11) + 24, 39, 0
ShowMOUSE
GOSUB CloseUP
RETURN

END SUB

SUB WorkAREA
SHARED LB, RB, MouseX, MouseY
SHARED Mask, TopLEFTx, TopLEFTy, BottomRIGHTx, BottomRIGHTy
IF Scale = 3 THEN Adjust = 2 ELSE Adjust = 0

IF RB THEN
HideMOUSE
WClr = POINT(MouseX, MouseY)
LINE (152, 424)-(189, 433), WClr, BF
ShowMOUSE
END IF

SetXY

GOSUB SetPIXEL
SELECT CASE WorkingTOOL
CASE 3 'Pixel tool
IF LB THEN
HideMOUSE
GET (30, 194)-(119, 261), UndoBOX
PSET (PixelX + 29, PixelY + 193), WClr
x = PixelX * Scale + 161 + Adjust
y = PixelY * Scale + 51 + Adjust
LINE (x, y)-(x + Scale - 1, y + Scale - 1), WClr, BF
ClearMOUSE
ShowMOUSE
Workdone = 1
END IF
CASE 4 'Freehand tool
IF LB THEN
TIMER OFF
OldPIXELx = PixelX: OldPIXELy = PixelY
OldMOUSEx = MouseX: OldMOUSEy = MouseY
HideMOUSE
GET (30, 194)-(119, 261), UndoBOX
ShowMOUSE
WHILE LB
MouseSTATUS LB, RB, MouseX, MouseY
GOSUB SetPIXEL
VIEW SCREEN (166, 56)-(166 + Scale * 90 - 1, 56 + Scale * 68 - 1)
LINE (OldMOUSEx - 2, OldMOUSEy - 2)-(MouseX - 2, MouseY - 2), WClr
LINE (OldMOUSEx - 1, OldMOUSEy - 1)-(MouseX - 1, MouseY - 1), WClr
LINE (OldMOUSEx, OldMOUSEy)-(MouseX, MouseY), WClr
VIEW SCREEN (30, 194)-(119, 261)
LINE (OldPIXELx + 29, OldPIXELy + 193)-(PixelX + 29, PixelY + 193), WClr
ShowMOUSE
PauseMOUSE LB, RB, MouseX, MouseY
OldPIXELx = PixelX: OldPIXELy = PixelY
OldMOUSEx = MouseX: OldMOUSEy = MouseY
WEND
TIMER ON
VIEW
ScaleUP
Workdone = 1
END IF
CASE 5 'Box tool
IF LB THEN
TIMER OFF
GOSUB SetPIXEL
HideMOUSE
GET (166, 56)-(435, 259), WindowBOX
GET (30, 194)-(119, 261), WindowBOX(14000)
GET (30, 194)-(119, 261), UndoBOX
ShowMOUSE
LocateMOUSE ScalePIXELx, ScalePIXELy
TopLEFTx = PixelX
TopLEFTy = PixelY
TopLEFTxx = ScalePIXELx + 2
TopLEFTyy = ScalePIXELy + 2
WHILE LB
MouseSTATUS LB, RB, MouseX, MouseY
GOSUB SetPIXEL
HideMOUSE
VIEW SCREEN (166, 56)-(435, 259)
PUT (166, 56), WindowBOX, PSET
LINE (TopLEFTxx, TopLEFTyy)-(ScalePIXELx + 4, ScalePIXELy + 2), WClr, B
LINE (TopLEFTxx + 1, TopLEFTyy + 1)-(ScalePIXELx + 3, ScalePIXELy + 3), WClr, B
LINE (TopLEFTxx + 2, TopLEFTyy + 2)-(ScalePIXELx + 2, ScalePIXELy + 4), WClr, B
VIEW SCREEN (30, 194)-(119, 261)
PUT (30, 194), WindowBOX(14000), PSET
LINE (TopLEFTx + 29, TopLEFTy + 193)-(PixelX + 29, PixelY + 193), WClr, B
ShowMOUSE
PauseMOUSE LB, RB, MouseX, MouseY
WEND
IF Filled = 1 THEN
HideMOUSE
VIEW SCREEN (30, 194)-(119, 261)
LINE (TopLEFTx + 29, TopLEFTy + 193)-(PixelX + 29, PixelY + 193), WClr, BF
ShowMOUSE
END IF
VIEW
ScaleUP
Workdone = 1
TIMER ON
END IF
CASE 6, 7 'Circle/Elipse tools
IF LB THEN
TIMER OFF
HideMOUSE
GET (166, 56)-(435, 259), WindowBOX
GET (30, 194)-(119, 261), WindowBOX(14000)
GET (30, 194)-(119, 261), UndoBOX
ShowMOUSE
VIEW SCREEN (166, 56)-(435, 259)
GOSUB SetPIXEL
CircleXX = ScalePIXELx + 3
CircleYY = ScalePIXELy + 2
CircleX = PixelX
CircleY = PixelY
WHILE LB
MouseSTATUS LB, RB, MouseX, MouseY
GOSUB SetPIXEL
Radius = SQR((ScalePIXELx - CircleXX) ^ 2 + (ScalePIXELy - CircleYY) ^ 2)
LilRADIUS = Radius / 3
IF WorkingTOOL = 6 THEN
Elipse! = 1
ELSE
IF ScalePIXELx > CircleXX THEN
Adjacent = ScalePIXELx - CircleXX
ELSE
Adjacent = CircleXX - ScalePIXELx
END IF
IF ScalePIXELy > CircleYY THEN
Opposite = ScalePIXELy - CircleYY
ELSE
Opposite = CircleYY - ScalePIXELy
END IF
Elipse! = Opposite / (Adjacent + .01)
END IF
HideMOUSE
VIEW SCREEN (166, 56)-(435, 259)
PUT (166, 56), WindowBOX, PSET
CIRCLE (CircleXX, CircleYY), Radius, WClr, , , Elipse!
CIRCLE (CircleXX, CircleYY), Radius + 1, WClr, , , Elipse!
CIRCLE (CircleXX, CircleYY), Radius + 2, WClr, , , Elipse!
VIEW SCREEN (30, 194)-(119, 261)
PUT (30, 194), WindowBOX(14000), PSET
CIRCLE (CircleX + 29, CircleY + 193), LilRADIUS, WClr, , , Elipse!
ShowMOUSE
PauseMOUSE LB, RB, MouseX, MouseY
WEND
IF Filled = 1 THEN
HideMOUSE
VIEW SCREEN (30, 194)-(119, 261)
FOR Radii = LilRADIUS TO 1 STEP -1
CIRCLE (CircleX + 29, CircleY + 193), Radii, WClr, , , Elipse!
IF Radii = LilRADIUS THEN
IF LilRADIUS > 2 THEN
CIRCLE (CircleX + 29, CircleY + 194), Radii, WClr, 0, 3.14259, Elipse!
END IF
ELSE
IF LilRADIUS > 2 THEN
CIRCLE (CircleX + 29, CircleY + 194), Radii, WClr, , , Elipse!
END IF
END IF
NEXT Radii
IF LilRADIUS = 1 THEN PSET (CircleX + 29, CircleY + 193), WClr
IF LilRADIUS = 2 THEN
LINE (CircleX + 28, CircleY + 192)-(CircleX + 30, CircleY + 194), WClr, BF
END IF
ShowMOUSE
END IF
VIEW
ScaleUP
Workdone = 1
TIMER ON
END IF
CASE 8 'Line tool
IF LB THEN
TIMER OFF
GOSUB SetPIXEL
HideMOUSE
GET (166, 56)-(435, 259), WindowBOX
GET (30, 194)-(119, 261), WindowBOX(14000)
GET (30, 194)-(119, 261), UndoBOX
ShowMOUSE
LocateMOUSE ScalePIXELx, ScalePIXELy
LEFTx = PixelX
LEFTy = PixelY
LEFTxx = ScalePIXELx + 3
LEFTyy = ScalePIXELy + 3
WHILE LB
MouseSTATUS LB, RB, MouseX, MouseY
GOSUB SetPIXEL
HideMOUSE
VIEW SCREEN (166, 56)-(435, 259)
PUT (166, 56), WindowBOX, PSET
LINE (LEFTxx - 1, LEFTyy - 1)-(ScalePIXELx - 1, ScalePIXELy - 1), WClr
LINE (LEFTxx, LEFTyy)-(ScalePIXELx, ScalePIXELy), WClr
LINE (LEFTxx + 1, LEFTyy + 1)-(ScalePIXELx + 1, ScalePIXELy + 1), WClr
VIEW SCREEN (30, 194)-(119, 261)
PUT (30, 194), WindowBOX(14000), PSET
LINE (LEFTx + 29, LEFTy + 193)-(PixelX + 28, PixelY + 192), WClr
ShowMOUSE
PauseMOUSE LB, RB, MouseX, MouseY
WEND
VIEW
ScaleUP
Workdone = 1
TIMER ON
END IF
CASE 9 'Paint tool
IF LB THEN
TIMER OFF
HideMOUSE
GET (30, 194)-(119, 261), UndoBOX
IF Scale = 5 THEN
VIEW SCREEN (166, 56)-(615, 395)
ELSE
VIEW SCREEN (166, 56)-(435, 259)
END IF
PAINT (MouseX, MouseY), WClr
VIEW SCREEN (30, 194)-(119, 261)
PAINT (PixelX + 29, PixelY + 193), WClr
ClearMOUSE
VIEW
ShowMOUSE
Workdone = 1
TIMER ON
Interval .2
END IF
CASE 10 'Mask tool
IF LB = -1 THEN
TIMER OFF
HideMOUSE
ScaleUP
GET (166, 56)-(435, 259), WindowBOX
GET (30, 194)-(119, 261), UndoBOX
ShowMOUSE
TopLEFTx = MouseX: IF TopLEFTx < 166 THEN TopLEFTx = 166
TopLEFTy = MouseY: IF TopLEFTy < 56 THEN TopLEFTy = 56
WHILE LB = -1
MouseSTATUS LB, RB, MouseX, MouseY
HideMOUSE
PUT (166, 56), WindowBOX, PSET
IF MouseX > 435 THEN MouseX = 435
IF MouseY > 259 THEN MouseY = 259
IF MouseX < 166 THEN MouseX = 166
IF MouseY < 56 THEN MouseY = 56
LINE (TopLEFTx, TopLEFTy)-(MouseX, MouseY), 0, B
LINE (TopLEFTx, TopLEFTy)-(MouseX, MouseY), 15, B, &HCCCC
ShowMOUSE
WEND
CopyWIDTH = INT((MouseX - TopLEFTx) / 3)
CopyDEPTH = INT((MouseY - TopLEFTy) / 3)
TopLEFTx = (TopLEFTx - 166) / 3 + 30: TopLEFTy = (TopLEFTy - 56) / 3 + 194
BottomRIGHTx = TopLEFTx + CopyWIDTH: BottomRIGHTy = TopLEFTy + CopyDEPTH
Mask = 1
TIMER ON
END IF
CASE 12 'Swap colors tool
IF LB THEN
HideMOUSE
GET (30, 194)-(119, 261), UndoBOX
RefCOLOR = POINT(MouseX, MouseY)
FOR x = 30 TO 119
FOR y = 194 TO 261
IF POINT(x, y) = RefCOLOR THEN PSET (x, y), WClr
NEXT y
NEXT x
ScaleUP
Workdone = 1
ShowMOUSE
END IF
END SELECT

EXIT SUB

SetPIXEL:
PixelX = INT((MouseX - 167) / Scale) + 1
PixelY = INT((MouseY - 57) / Scale) + 1
ScalePIXELx = PixelX * Scale + 161
ScalePIXELy = PixelY * Scale + 51
RETURN

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
