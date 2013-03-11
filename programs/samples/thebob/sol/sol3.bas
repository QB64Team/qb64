CHDIR ".\programs\samples\thebob\sol"

'****************************************************************************'
'-------------------------- S O L I T A I R E - 3 ---------------------------'
'------------- Copyright (C) 2000-2007 by Bob Seguin (Freeware) -------------'
'****************************************************************************'

DEFINT A-Z

DECLARE FUNCTION InitMOUSE ()

DECLARE SUB MouseDRIVER (LB, RB, mX, mY)
DECLARE SUB MouseSTATUS (LB, RB, MouseX, MouseY)
DECLARE SUB ShowMOUSE ()
DECLARE SUB HideMOUSE ()
DECLARE SUB PauseMOUSE (LB, RB, MouseX, MouseY)
DECLARE SUB ClearMOUSE ()

DECLARE SUB DrawSCREEN (Mode)
DECLARE SUB Interval (Length!)
DECLARE SUB CheckOUT ()
DECLARE SUB InitVALS ()

DECLARE SUB PlayGAME ()

DECLARE SUB Sol3MENU (Item)
DECLARE SUB Sol3DEAL ()
DECLARE SUB Sol3UNDO ()
DECLARE SUB Sol3HELP (Item)
DECLARE SUB BigBOX (InOUT)

DECLARE SUB SetSCORE ()
DECLARE SUB PutCARD (x, y, CardNUM)
DECLARE SUB CheckTOTAL ()
DECLARE SUB Finito ()

TYPE PlayTYPE
Suit AS INTEGER
Value AS INTEGER
x AS INTEGER
y AS INTEGER
UpDOWN AS INTEGER
END TYPE
DIM SHARED MainPLAY(1 TO 7, 0 TO 18) AS PlayTYPE

TYPE DeckTYPE
Suit AS INTEGER
Value AS INTEGER
END TYPE
DIM SHARED Decks(1 TO 3, 1 TO 8) AS DeckTYPE
DIM SHARED TurnUPs(0 TO 24) AS DeckTYPE
DIM SHARED Stacks(1 TO 4) AS DeckTYPE
DIM SHARED Trick(1 TO 18) AS DeckTYPE

DIM SHARED LettFileName$

REDIM SHARED Buttons(600)
REDIM SHARED Title(1 TO 250)
REDIM SHARED Card(1 TO 2400)
REDIM SHARED CardBACK(1 TO 2400)
REDIM SHARED BackERASE(1 TO 2600)
REDIM SHARED Selected(1 TO 2400)
REDIM SHARED Suits(1 TO 800)
REDIM SHARED MenuBOX(220)
REDIM SHARED ItemBOX(500)
REDIM SHARED MenuGFX(500)
REDIM SHARED Deck(1 TO 52)
REDIM SHARED TopOFF(1 TO 44)
REDIM SHARED Chek(50)
REDIM SHARED GetBOX(8000)
REDIM SHARED OtherBOX(8000)
REDIM SHARED Numbers(1100)

DIM SHARED Score AS LONG
DIM SHARED MoneyCARD
DIM SHARED Tally
DIM SHARED StackIT
DIM SHARED Completed
DIM SHARED MouseDATA$

DIM SHARED Vegas
DIM SHARED Money
OPEN "sol3opts.dat" FOR INPUT AS #1
INPUT #1, Vegas, Money
CLOSE #1

DEF SEG = VARSEG(Suits(1))
BLOAD "sol3suit.bsv", VARPTR(Suits(1))
DEF SEG = VARSEG(Buttons(0))
BLOAD "sol3btns.bsv", VARPTR(Buttons(0))
DEF SEG = VARSEG(Title(1))
BLOAD "sol3titl.bsv", VARPTR(Title(1))
DEF SEG = VARSEG(CardBACK(1))
BLOAD "sol3cd53.bsv", VARPTR(CardBACK(1))
DEF SEG = VARSEG(BackERASE(1))
BLOAD "sol3cd54.bsv", VARPTR(BackERASE(1))
DEF SEG = VARSEG(Selected(1))
BLOAD "sol3sele.bsv", VARPTR(Selected(1))
DEF SEG = VARSEG(TopOFF(1))
BLOAD "sol3topp.bsv", VARPTR(TopOFF(1))
DEF SEG = VARSEG(Chek(0))
BLOAD "sol3chek.bsv", VARPTR(Chek(0))
DEF SEG = VARSEG(Numbers(0))
BLOAD "sol3nums.bsv", VARPTR(Numbers(0))
DEF SEG = VARSEG(MenuGFX(0))
BLOAD "sol3men1.bsv", VARPTR(MenuGFX(0))
DEF SEG

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

GOSUB SetPALETTE
DrawSCREEN 1
InitVALS
RANDOMIZE TIMER
Sol3DEAL
ShowMOUSE

DO
Beginning:
MouseSTATUS LB, RB, MouseX, MouseY
IF Menu > 2 THEN Sol3MENU 1: GOTO Beginning
SELECT CASE MouseY
CASE IS < 18
IF MouseX > 621 AND LB THEN CheckOUT
IF Menu THEN Sol3MENU 0
CASE 20 TO 35
SELECT CASE MouseX
CASE IS < 103
Sol3MENU 1
CASE ELSE
IF Menu THEN Sol3MENU 0
END SELECT
CASE IS > 38
IF Menu THEN Sol3MENU 0
PlayGAME
Finito
END SELECT
PauseMOUSE LB, RB, MouseX, MouseY
LOOP

SYSTEM

SetPALETTE:
DATA 0, 0, 0, 16, 16, 32, 21, 63, 21, 63, 63, 0
DATA 63, 0, 0, 28, 28, 28, 0, 34, 0, 63, 50, 10
DATA 0, 30, 55, 45, 50, 63, 0, 63, 63, 0, 42, 0
DATA 63, 45, 55, 63, 30, 40, 48, 48, 48, 63, 63, 63
RESTORE SetPALETTE
OUT &H3C8, 0
FOR n = 1 TO 48
READ Intensity
OUT &H3C9, Intensity
NEXT n
RETURN

SUB CheckOUT

HideMOUSE
PUT (622, 2), Buttons(400), PSET
ShowMOUSE

Interval .1

HideMOUSE
PUT (588, 2), Buttons, PSET
ShowMOUSE

Interval .1

SYSTEM

END SUB

SUB CheckTOTAL
SHARED Deck1, Deck2, Deck3, Deck4

IF Vegas = 0 THEN
IF Deck1 = 0 THEN
IF Deck2 = 0 THEN
IF Deck3 = 0 THEN
HideMOUSE
IF Deck4 > 0 THEN
Deck1 = Deck4
PUT (5, 43), CardBACK, PSET
END IF
IF Deck4 > 8 THEN
Deck1 = 8
Deck2 = Deck4 - 8
PUT (83, 43), CardBACK, PSET
END IF
IF Deck4 > 16 THEN
Deck1 = 8
Deck2 = 8
Deck3 = Deck4 - 16
PUT (161, 43), CardBACK, PSET
END IF
LINE (239, 43)-(313, 152), 11, BF
ShowMOUSE
FOR n = 1 TO Deck3
Decks(3, n).Value = TurnUPs(Deck4).Value
Decks(3, n).Suit = TurnUPs(Deck4).Suit
Deck4 = Deck4 - 1
NEXT n
FOR n = 1 TO Deck2
Decks(2, n).Value = TurnUPs(Deck4).Value
Decks(2, n).Suit = TurnUPs(Deck4).Suit
Deck4 = Deck4 - 1
NEXT n
FOR n = 1 TO Deck1
Decks(1, n).Value = TurnUPs(Deck4).Value
Decks(1, n).Suit = TurnUPs(Deck4).Suit
Deck4 = Deck4 - 1
NEXT n
Deck4 = 0
END IF
END IF
END IF
END IF

END SUB

SUB ClearMOUSE
SHARED LB

WHILE LB
MouseSTATUS LB, RB, MouseX, MouseY
WEND

END SUB

SUB DrawSCREEN (Mode)

HideMOUSE
IF Mode = 1 THEN
LINE (0, 0)-(639, 17), 1, BF
LINE (0, 18)-(639, 37), 14, BF
LINE (0, 38)-(639, 38), 0
PUT (588, 2), Buttons, PSET
PUT (20, 0), Title, PSET
PUT (20, 24), MenuGFX, PSET
PUT (73, 24), MenuGFX(100), PSET
PUT (532, 24), MenuGFX(400), PSET
END IF

LINE (0, 39)-(639, 479), 11, BF
LINE (0, 155)-(639, 155), 2
LINE (318, 39)-(318, 155), 2
LINE (321, 39)-(321, 154), 6
LINE (319, 155)-(320, 155), 11
PSET (321, 155), 8

Index = 1
FOR x = 326 TO 568 STEP 78
LINE (x, 43)-(x + 74, 151), 2, B
LINE (x, 43)-(x + 74, 43), 6
LINE (x, 43)-(x, 151), 6
LINE (x + 18, 73)-(x + 56, 121), 2, B
LINE (x + 18, 73)-(x + 56, 73), 6
LINE (x + 18, 73)-(x + 18, 121), 6
PUT (x + 25, 85), Suits(Index), PSET
Index = Index + 200
NEXT x

IF Vegas THEN SetSCORE
ShowMOUSE

END SUB

SUB Finito
IF Completed THEN EXIT SUB
IF Stacks(1).Value = 13 THEN
IF Stacks(2).Value = 13 THEN
IF Stacks(3).Value = 13 THEN
IF Stacks(4).Value = 13 THEN
HideMOUSE
PLAY "MBMST120O1L16ceg>ceg>ceg>L32cg"
PLAY "MBMST120O4L32cgcgcgcg"
FOR Reps = 1 TO 400
x = FIX(RND * 560)
y = FIX(RND * 370)
CardNUM = FIX(RND * 52) + 1
PutCARD x, y, CardNUM
NEXT Reps
ShowMOUSE
DrawSCREEN 1
PLAY "MBO1L16CEGC"
x = 30
FOR CardNUM = 1 TO 52
PutCARD x, 185, CardNUM
x = x + 10
NEXT CardNUM
COLOR 3
LINE (180, 230)-(470, 265), 0, BF
LINE (185, 235)-(465, 260), 4, B
LOCATE 16, 27: PRINT "C O N G R A T U L A T I O N S !"
Interval 2
DrawSCREEN 1
Completed = 1
END IF
END IF
END IF
END IF

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

SUB InitVALS
SHARED Menu

FOR n = 1 TO 52
Deck(n) = n
NEXT n

FOR Col = 1 TO 7
FOR Row = 1 TO 18
MainPLAY(Col, Row).x = (Col - 1) * 88 + 18
MainPLAY(Col, Row).y = (Row - 1) * 18 + 158
NEXT Row
NEXT Col

FOR Col = 1 TO 7
MainPLAY(Col, 0).x = (Col - 1) * 88 + 18
MainPLAY(Col, 0).y = 140
NEXT Col

END SUB

DEFSNG A-Z
SUB Interval (Length!)

OldTimer# = TIMER
DO: LOOP UNTIL TIMER > OldTimer# + Length!

END SUB

DEFINT A-Z
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

SUB Navigate
END SUB

SUB PauseMOUSE (OldLB, OldRB, OldMX, OldMY)
SHARED Key$

DO
Key$ = UCASE$(INKEY$)
MouseSTATUS LB, RB, MouseX, MouseY
LOOP UNTIL LB <> OldLB OR RB <> OldRB OR MouseX <> OldMX OR MouseY <> OldMY OR Key$ <> ""

END SUB

SUB PlayGAME
SHARED LB, RB, MouseX, MouseY
SHARED Deck1, Deck2, Deck3, Deck4, CardSELECT
SHARED FCcol, FCrow, FCx, FCy, FCsuit, FCvalue, LastDECK

BackERASE(2) = 127: CardBACK(2) = 109: Selected(2) = 109

SELECT CASE MouseY
CASE 43 TO 151
SELECT CASE MouseX
CASE 7 TO 81 'first deck
IF LB THEN
IF CardSELECT THEN GOSUB ZeroTURNUPS
IF Deck1 > 0 THEN
CardNUM = (Decks(1, Deck1).Suit - 1) * 13 + Decks(1, Deck1).Value
HideMOUSE
PutCARD 239, 43, CardNUM
ShowMOUSE
Deck4 = Deck4 + 1
TurnUPs(Deck4).Suit = Decks(1, Deck1).Suit
TurnUPs(Deck4).Value = Decks(1, Deck1).Value
Decks(1, Deck1).Suit = 0
Decks(1, Deck1).Value = 0
Deck1 = Deck1 - 1
LastDECK = 1
IF Deck1 = 0 THEN
HideMOUSE
LINE (5, 43)-(79, 152), 11, BF
IF Vegas = 0 THEN
LINE (24, 73)-(62, 121), 2, B
LINE (26, 75)-(60, 119), 2, BF
END IF
ShowMOUSE
END IF
ELSE
CheckTOTAL
END IF
ClearMOUSE
END IF
CASE 85 TO 159 'second deck
IF LB THEN
IF CardSELECT THEN GOSUB ZeroTURNUPS
IF Deck2 > 0 THEN
CardNUM = (Decks(2, Deck2).Suit - 1) * 13 + Decks(2, Deck2).Value
HideMOUSE
PutCARD 239, 43, CardNUM
ShowMOUSE
Deck4 = Deck4 + 1
TurnUPs(Deck4).Suit = Decks(2, Deck2).Suit
TurnUPs(Deck4).Value = Decks(2, Deck2).Value
Decks(2, Deck2).Suit = 0
Decks(2, Deck2).Value = 0
Deck2 = Deck2 - 1
LastDECK = 2
IF Deck2 = 0 THEN
HideMOUSE
LINE (83, 43)-(157, 152), 11, BF
IF Vegas = 0 THEN
LINE (102, 73)-(140, 121), 2, B
LINE (104, 75)-(138, 119), 2, BF
END IF
ShowMOUSE
END IF
ELSE
CheckTOTAL
END IF
ClearMOUSE
END IF
CASE 163 TO 237 'third deck
IF LB THEN
IF CardSELECT THEN GOSUB ZeroTURNUPS
IF Deck3 > 0 THEN
CardNUM = (Decks(3, Deck3).Suit - 1) * 13 + Decks(3, Deck3).Value
HideMOUSE
PutCARD 239, 43, CardNUM
ShowMOUSE
Deck4 = Deck4 + 1
TurnUPs(Deck4).Suit = Decks(3, Deck3).Suit
TurnUPs(Deck4).Value = Decks(3, Deck3).Value
Decks(3, Deck3).Suit = 0
Decks(3, Deck3).Value = 0
Deck3 = Deck3 - 1
LastDECK = 3
IF Deck3 = 0 THEN
HideMOUSE
LINE (161, 43)-(235, 152), 11, BF
IF Vegas = 0 THEN
LINE (180, 73)-(218, 121), 2, B
LINE (182, 75)-(216, 119), 2, BF
END IF
ShowMOUSE
END IF
ELSE
CheckTOTAL
END IF
ClearMOUSE
END IF
CASE 241 TO 319 'turn-up deck
IF Deck4 > 0 THEN
IF LB THEN
IF CardSELECT = 0 THEN
TSuit = TurnUPs(Deck4).Suit
TValue = TurnUPs(Deck4).Value
CardNUM = (TSuit - 1) * 13 + TValue
IF (CardNUM = MoneyCARD) AND Money THEN
HideMOUSE
PutCARD 239, 43, CardNUM
PLAY "MBT140O6L64GP32GP32GP32GP32GP32GP32GP32G"
Score = Score + 52 + Tally: SetSCORE
Tally = Tally + 5
MoneyCARD = 0
GOSUB ZeroVALS
ShowMOUSE
EXIT SUB
END IF
HideMOUSE
PUT (239, 43), Selected
ShowMOUSE
CardSELECT = 2
ELSE
HideMOUSE
IF CardSELECT = 2 THEN
TSuit = TurnUPs(Deck4).Suit
TValue = TurnUPs(Deck4).Value
CardNUM = (TSuit - 1) * 13 + TValue
IF (CardNUM = MoneyCARD) AND Money THEN
PutCARD 239, 43, CardNUM
PLAY "MBT140O6L64GP32GP32GP32GP32GP32GP32GP32G"
MoneyCARD = 0
GOSUB ZeroVALS
ShowMOUSE
EXIT SUB
END IF
IF Stacks(TSuit).Value = TValue - 1 THEN
IF TurnUPs(Deck4 - 1).Value <> 0 THEN
CardNUM = (TurnUPs(Deck4 - 1).Suit - 1) * 13 + TurnUPs(Deck4 - 1).Value
PutCARD 239, 43, CardNUM
ELSE
LINE (239, 43)-(313, 152), 11, BF
END IF
CardNUM = (TSuit - 1) * 13 + TValue
PutCARD ((TSuit - 1) * 78 + 325), 43, CardNUM
Score = Score + 5: Tally = Tally + 5
IF Vegas THEN SetSCORE
ShowMOUSE
Stacks(TSuit).Value = Stacks(TSuit).Value + 1
TurnUPs(Deck4).Suit = 0
TurnUPs(Deck4).Value = 0
Deck4 = Deck4 - 1
GOSUB ZeroVALS
ELSE
PUT (239, 43), Selected
GOSUB ZeroVALS
END IF
ELSE
PUT (FCx, FCy), Selected
GOSUB ZeroVALS
END IF
ShowMOUSE
END IF
ClearMOUSE
END IF
END IF
END SELECT
CASE IS > 159 'columns y
SELECT CASE MouseX
CASE 18 TO 92 'column 1
IF LB THEN
Column = 1
IF CardSELECT = 0 THEN
GOSUB SELECT1
ELSE
GOSUB SELECT2
END IF
END IF
CASE 106 TO 180 'column 2
IF LB THEN
Column = 2
IF CardSELECT = 0 THEN
GOSUB SELECT1
ELSE
GOSUB SELECT2
END IF
END IF
CASE 194 TO 268 'column 3
IF LB THEN
Column = 3
IF CardSELECT = 0 THEN
GOSUB SELECT1
ELSE
GOSUB SELECT2
END IF
END IF
CASE 282 TO 356 'column 4
IF LB THEN
Column = 4
IF CardSELECT = 0 THEN
GOSUB SELECT1
ELSE
GOSUB SELECT2
END IF
END IF
CASE 370 TO 444 'column 5
IF LB THEN
Column = 5
IF CardSELECT = 0 THEN
GOSUB SELECT1
ELSE
GOSUB SELECT2
END IF
END IF
CASE 458 TO 532 'column 6
IF LB THEN
Column = 6
IF CardSELECT = 0 THEN
GOSUB SELECT1
ELSE
GOSUB SELECT2
END IF
END IF
CASE 546 TO 620 'column 7
IF LB THEN
Column = 7
IF CardSELECT = 0 THEN
GOSUB SELECT1
ELSE
GOSUB SELECT2
END IF
END IF
END SELECT
END SELECT
ClearMOUSE
EXIT SUB

'*************************** FIRST SELECTION SUBROUTINE **********************
SELECT1:
LastDECK = 0
FCcol = Column
FOR FCrow = 18 TO 1 STEP -1
IF MainPLAY(FCcol, FCrow).Value <> 0 THEN
IF MainPLAY(FCcol, FCrow).UpDOWN = 0 THEN
cn = (MainPLAY(FCcol, FCrow).Suit - 1) * 13 + MainPLAY(FCcol, FCrow).Value
CardNUM = cn
FCx = MainPLAY(FCcol, FCrow).x
FCy = MainPLAY(FCcol, FCrow).y
HideMOUSE
PutCARD FCx, FCy, CardNUM
ShowMOUSE
MainPLAY(FCcol, FCrow).UpDOWN = 1
GOSUB ZeroVALS
ClearMOUSE
RETURN
ELSE
FCsuit = MainPLAY(FCcol, FCrow).Suit
FCvalue = MainPLAY(FCcol, FCrow).Value
FCx = MainPLAY(FCcol, FCrow).x
FCy = MainPLAY(FCcol, FCrow).y
IF FCy + 108 < 479 THEN Selected(2) = 109 ELSE Selected(2) = 480 - FCy
HideMOUSE
PUT (FCx, FCy), Selected
ShowMOUSE
CardSELECT = 1
ClearMOUSE
RETURN
END IF
END IF
NEXT FCrow
RETURN

'************************* SECOND SELECTION SUBROUTINE ***********************

SELECT2:
LastDECK = 0
SCcol = Column
IF CardSELECT = 1 THEN
HideMOUSE
IF FCcol = SCcol OR FCvalue = 1 THEN
IF Stacks(FCsuit).Value = FCvalue - 1 THEN
GOSUB LiftCARD
CardNUM = (FCsuit - 1) * 13 + FCvalue
PutCARD ((FCsuit - 1) * 78 + 325), 43, CardNUM
Stacks(FCsuit).Value = Stacks(FCsuit).Value + 1
MainPLAY(FCcol, FCrow).Value = 0
MainPLAY(FCcol, FCrow).Suit = 0
GOSUB ZeroVALS
Score = Score + 5: Tally = Tally + 5
IF Vegas THEN SetSCORE
ShowMOUSE
ClearMOUSE
RETURN
ELSE
IF FCy + 108 < 479 THEN Selected(2) = 109 ELSE Selected(2) = 480 - FCy
PUT (FCx, FCy), Selected
GOSUB ZeroVALS
ShowMOUSE
ClearMOUSE
RETURN
END IF
ELSE
FOR SCrow = 18 TO 1 STEP -1
IF MainPLAY(SCcol, SCrow).Value <> 0 THEN EXIT FOR
NEXT SCrow

IF SCrow = 0 THEN
IF FCvalue = 13 THEN
GOSUB LiftCARD
CardNUM = (MainPLAY(FCcol, FCrow).Suit - 1) * 13 + 13
PutCARD MainPLAY(SCcol, 1).x, MainPLAY(SCcol, 1).y, CardNUM
ShowMOUSE
MainPLAY(SCcol, 1).Suit = FCsuit
MainPLAY(SCcol, 1).Value = 13
MainPLAY(FCcol, FCrow).Suit = 0
MainPLAY(FCcol, FCrow).Value = 0
GOSUB ZeroVALS
ClearMOUSE
RETURN
ELSE
FOR Reduce = FCrow TO 0 STEP -1
IF MainPLAY(FCcol, Reduce).UpDOWN = 1 THEN
IF MainPLAY(FCcol, Reduce).Value = 13 THEN
SCrow = 0
MatchCARD = Reduce
GOTO TrickHANDLER
END IF
END IF
NEXT Reduce

IF FCy + 108 > 479 THEN Selected(2) = 480 - FCx ELSE Selected(2) = 109
PUT (FCx, FCy), Selected
ShowMOUSE
GOSUB ZeroVALS
ClearMOUSE
RETURN
END IF
END IF


FOR MatchCARD = FCrow TO 0 STEP -1
IF MainPLAY(FCcol, MatchCARD).UpDOWN = 1 THEN
FCsuit = MainPLAY(FCcol, MatchCARD).Suit
FCvalue = MainPLAY(FCcol, MatchCARD).Value

IF FCvalue + 1 = MainPLAY(SCcol, SCrow).Value OR FCrow = 0 THEN
IF MainPLAY(SCcol, SCrow).Suit MOD 2 <> FCsuit MOD 2 THEN
IF MatchCARD < FCrow THEN
ERASE Trick
TrickHANDLER:
FOR Row = FCrow - 1 TO MatchCARD - 1 STEP -1
Ex = MainPLAY(FCcol, Row).x
Ey = MainPLAY(FCcol, Row).y
IF MainPLAY(FCcol, Row).UpDOWN = 1 THEN
EraseNUM = (MainPLAY(FCcol, Row).Suit - 1) * 13 + MainPLAY(FCcol, Row).Value
PutCARD Ex, Ey, EraseNUM
LINE (Ex, Ey + 109)-(Ex + 74, Ey + 127), 11, BF
ELSE
IF MainPLAY(FCcol, Row).Value = 0 THEN
LINE ((FCcol - 1) * 88 + 18, 158)-((FCcol - 1) * 88 + 92, 284), 11, BF
ELSE
IF Ey + 109 > 479 THEN
BackERASE(2) = 480 - Ey
ELSE
BackERASE(2) = 127
END IF
IF POINT(Ex + 1, Ey - 1) = 15 THEN OnTOP = 1
PUT (Ex, Ey), BackERASE, PSET
IF OnTOP THEN PUT (Ex, Ey), TopOFF, PSET
END IF
END IF
Count = Count + 1
Trick(Count).Suit = MainPLAY(FCcol, Row + 1).Suit
Trick(Count).Value = MainPLAY(FCcol, Row + 1).Value
MainPLAY(FCcol, Row + 1).Suit = 0
MainPLAY(FCcol, Row + 1).Value = 0
NEXT Row
x = MainPLAY(SCcol, SCrow).x
y = MainPLAY(SCcol, SCrow).y
FOR Cards = FCrow - MatchCARD + 1 TO 1 STEP -1
CardNUM = (Trick(Cards).Suit - 1) * 13 + Trick(Cards).Value
Slot = Slot + 1
MainPLAY(SCcol, SCrow + Slot).Suit = Trick(Cards).Suit
MainPLAY(SCcol, SCrow + Slot).Value = Trick(Cards).Value
MainPLAY(SCcol, SCrow + Slot).UpDOWN = 1
y = y + 18
PutCARD x, y, CardNUM
NEXT Cards
ShowMOUSE
ClearMOUSE
GOSUB ZeroVALS
RETURN
ELSE
GOSUB LiftCARD
CardNUM = (FCsuit - 1) * 13 + FCvalue

NCx = MainPLAY(SCcol, SCrow).x
NCy = MainPLAY(SCcol, SCrow + 1).y

PutCARD NCx, NCy, CardNUM

ShowMOUSE
ClearMOUSE

MainPLAY(SCcol, SCrow + 1).Suit = FCsuit
MainPLAY(SCcol, SCrow + 1).Value = FCvalue
MainPLAY(SCcol, SCrow + 1).UpDOWN = 1

MainPLAY(FCcol, FCrow).Suit = 0
MainPLAY(FCcol, FCrow).Value = 0
GOSUB ZeroVALS
RETURN
END IF
END IF
END IF
END IF
NEXT MatchCARD
IF FCy + 108 > 479 THEN Selected(2) = 480 - FCx ELSE Selected(2) = 109
PUT (FCx, FCy), Selected
GOSUB ZeroVALS
ShowMOUSE
ClearMOUSE
RETURN
END IF

ELSE 'CardSELECT = 2

FOR SCrow = 18 TO 1 STEP -1
IF MainPLAY(SCcol, SCrow).Value <> 0 THEN EXIT FOR
NEXT SCrow

IF SCrow = 0 THEN
HideMOUSE
IF TurnUPs(Deck4).Value = 13 THEN
IF Deck4 > 1 THEN
CardNUM = (TurnUPs(Deck4 - 1).Suit - 1) * 13 + TurnUPs(Deck4 - 1).Value
PutCARD 239, 43, CardNUM
ELSE
LINE (239, 43)-(313, 153), 11, BF
END IF
CardNUM = (TurnUPs(Deck4).Suit - 1) * 13 + 13
PutCARD MainPLAY(SCcol, 1).x, 158, CardNUM
ShowMOUSE
MainPLAY(SCcol, 1).Suit = TurnUPs(Deck4).Suit
MainPLAY(SCcol, 1).Value = TurnUPs(Deck4).Value
TurnUPs(Deck4).Suit = 0
TurnUPs(Deck4).Value = 0
Deck4 = Deck4 - 1
GOSUB ZeroVALS
ClearMOUSE
RETURN
END IF
ShowMOUSE
END IF

HideMOUSE
IF TurnUPs(Deck4).Suit MOD 2 <> MainPLAY(SCcol, SCrow).Suit MOD 2 THEN
IF TurnUPs(Deck4).Value + 1 = MainPLAY(SCcol, SCrow).Value THEN
PUT (239, 43), Selected
TopcardNUM = (TurnUPs(Deck4).Suit - 1) * 13 + TurnUPs(Deck4).Value
SCsuit = TurnUPs(Deck4).Suit
SCvalue = TurnUPs(Deck4).Value
TurnUPs(Deck4).Suit = 0
TurnUPs(Deck4).Value = 0
IF Deck4 > 0 THEN
Deck4 = Deck4 - 1
IF Deck4 = 0 THEN
LINE (239, 43)-(313, 152), 11, BF
ELSE
CardNUM = (TurnUPs(Deck4).Suit - 1) * 13 + TurnUPs(Deck4).Value
PutCARD 239, 43, CardNUM
END IF
PutCARD MainPLAY(SCcol, SCrow).x, MainPLAY(SCcol, SCrow + 1).y, TopcardNUM
ShowMOUSE
MainPLAY(SCcol, SCrow + 1).Suit = SCsuit
MainPLAY(SCcol, SCrow + 1).Value = SCvalue
MainPLAY(SCcol, SCrow + 1).UpDOWN = 1
GOSUB ZeroVALS
ClearMOUSE
RETURN
ELSE
LINE (239, 43)-(315, 152), 11, BF
ShowMOUSE
GOSUB ZeroVALS
ClearMOUSE
RETURN
END IF
ELSE
PUT (239, 43), Selected
GOSUB ZeroVALS
ShowMOUSE
ClearMOUSE
RETURN
END IF
ELSE
PUT (239, 43), Selected
GOSUB ZeroVALS
ShowMOUSE
ClearMOUSE
RETURN
END IF
END IF

RETURN

ZeroVALS:
FCcol = 0: FCrow = 0: FCx = 0: FCy = 0: FCsuit = 0: FCvalue = 0: Column = 0: CardSELECT = 0
RETURN

LiftCARD:
IF FCrow = 1 THEN
LINE ((FCcol - 1) * 88 + 18, 158)-((FCcol - 1) * 88 + 92, 266), 11, BF
ELSE
IF MainPLAY(FCcol, FCrow - 1).UpDOWN = 1 THEN
CardNUM = (MainPLAY(FCcol, FCrow - 1).Suit - 1) * 13 + MainPLAY(FCcol, FCrow - 1).Value
PutCARD FCx, FCy - 18, CardNUM
LINE (FCx, FCy + 91)-(FCx + 74, FCy + 109), 11, BF
ELSE
IF FCy + 109 < 479 THEN BackERASE(2) = 127 ELSE BackERASE(2) = 479 - FCy
IF POINT(FCx + 1, FCy - 19) = 15 THEN OnTOP = 1
PUT (FCx, FCy - 18), BackERASE, PSET
IF OnTOP THEN PUT (FCx, FCy - 18), TopOFF, PSET
END IF
END IF
RETURN

ZeroTURNUPS:
HideMOUSE
IF FCy + 108 > 479 THEN Selected(2) = 480 - FCx ELSE Selected(2) = 109
IF CardSELECT = 1 THEN PUT (FCx, FCy), Selected
ShowMOUSE
GOSUB ZeroVALS
RETURN

END SUB

SUB PutCARD (x, y, CardNUM)
SHARED HoldNUM, Dealt

IF Money THEN
IF HoldNUM = CardNUM THEN Dealt = 1
IF CardNUM = MoneyCARD AND Dealt = 0 THEN
HoldNUM = CardNUM
CardNUM = 55
END IF
END IF

FileNAME$ = "Sol3CD" + LTRIM$(RTRIM$(STR$(CardNUM))) + ".BSV"
DEF SEG = VARSEG(Card(1))
BLOAD FileNAME$, VARPTR(Card(1))
DEF SEG
IF POINT(x + 1, y - 1) = 15 THEN OnTOP = 1 'Check for underlying card...
IF y + 108 > 479 THEN Card(2) = 480 - y ELSE Card(2) = 109
PUT (x, y), Card, PSET
IF OnTOP THEN PUT (x, y), TopOFF, PSET 'Place B/W card top if required

END SUB

SUB SetSCORE

IF Score < 0 THEN
PrintSCORE& = Score - Score * 2
Minus = 1
ELSE
PrintSCORE& = Score
END IF
Scor$ = "$" + LTRIM$(RTRIM$(STR$(PrintSCORE&)))
LINE (564, 23)-(631, 34), 14, BF
x = 572
IF Minus THEN LINE (566, 29)-(571, 29), 4
FOR n = 1 TO LEN(Scor$)
Char$ = MID$(Scor$, n, 1)
IF Char$ = "$" THEN
Index = 500
ELSE
Index = VAL(Char$) * 50
END IF
IF Minus THEN Index = Index + 550
PUT (x, 23), Numbers(Index), PSET
x = x + 7
NEXT n
IF Minus THEN Index = 550: Colr = 4 ELSE Index = 0: Colr = 2
LINE (x + 1, 31)-(x + 2, 32), Colr, B
PUT (x + 5, 23), Numbers(Index), PSET
PUT (x + 12, 23), Numbers(Index), PSET
END SUB

SUB ShowMOUSE
LB = 1
MouseDRIVER LB, 0, 0, 0
END SUB

SUB Sol3DEAL
SHARED Deck1, Deck2, Deck3, Deck4
SHARED FCcol, FCrow, FCx, FCy, FCsuit, FCvalue, CardSELECT
SHARED HoldNUM, Dealt

DrawSCREEN 2
ERASE Stacks: Completed = 0
HoldNUM = 0: Dealt = 0

HideMOUSE
FOR x = 5 TO 161 STEP 78
PUT (x, 43), CardBACK, PSET
NEXT x
ShowMOUSE

FOR Col = 1 TO 7
FOR Row = 1 TO 18
MainPLAY(Col, Row).Suit = 0
MainPLAY(Col, Row).Value = 0
MainPLAY(Col, Row).UpDOWN = 0
NEXT Row
NEXT Col

'Shuffle cards
FOR n = 52 TO 2 STEP -1
Card = INT(RND * n) + 1
SWAP Deck(n), Deck(Card)
NEXT n

MoneyNUM = FIX(RND * 24) + 29
MoneyCARD = Deck(MoneyNUM)

FOR Row = 1 TO 7
FOR Col = Row TO 7
PasteBOARD = PasteBOARD + 1
DeckVALUE = Deck(PasteBOARD)
SELECT CASE DeckVALUE
CASE 1 TO 13
MainPLAY(Col, Row).Suit = 1
MainPLAY(Col, Row).Value = DeckVALUE
CASE 14 TO 26
MainPLAY(Col, Row).Suit = 2
MainPLAY(Col, Row).Value = DeckVALUE - 13
CASE 27 TO 39
MainPLAY(Col, Row).Suit = 3
MainPLAY(Col, Row).Value = DeckVALUE - 26
CASE 40 TO 52
MainPLAY(Col, Row).Suit = 4
MainPLAY(Col, Row).Value = DeckVALUE - 39
END SELECT
Value = Deck(PasteBOARD) MOD 13
IF Value = 0 THEN Value = 13
MainPLAY(Col, Row).Value = Value
x = MainPLAY(Col, Row).x
y = MainPLAY(Col, Row).y
HideMOUSE
IF Row = Col THEN
MainPLAY(Col, Row).UpDOWN = 1
PutCARD x, y, DeckVALUE
ELSE
MainPLAY(Row, Col).UpDOWN = 0
IF POINT(x + 1, y - 1) = 15 THEN OnTOP = 1 ELSE OnTOP = 0
PUT (x, y), CardBACK, PSET
IF OnTOP THEN PUT (x, y), TopOFF, PSET
END IF
ShowMOUSE
NEXT Col
NEXT Row

FOR Col = 1 TO 3
FOR Num = 1 TO 8
PasteBOARD = PasteBOARD + 1
DeckVALUE = Deck(PasteBOARD)
SELECT CASE DeckVALUE
CASE 1 TO 13
Decks(Col, Num).Suit = 1
Decks(Col, Num).Value = DeckVALUE
CASE 14 TO 26
Decks(Col, Num).Suit = 2
Decks(Col, Num).Value = DeckVALUE - 13
CASE 27 TO 39
Decks(Col, Num).Suit = 3
Decks(Col, Num).Value = DeckVALUE - 26
CASE 40 TO 52
Decks(Col, Num).Suit = 4
Decks(Col, Num).Value = DeckVALUE - 39
END SELECT
NEXT Num
NEXT Col

Deck1 = 8: Deck2 = 8: Deck3 = 8: Deck4 = 0: CardSELECT = 0
FCcol = 0: FCrow = 0: FCx = 0: FCy = 0: FCsuit = 0: FCvalue = 0

Score = Score - 52: Tally = -52
IF Vegas THEN SetSCORE ELSE Score = 0

END SUB

SUB Sol3HELP (Item)
SHARED LB

GET (194, 80)-(446, 203), GetBOX
SELECT CASE Item
CASE 1 'Introduction
FirstPAGE = 1: LastPAGE = 5
CASE 2 'Basic Solitaire
FirstPAGE = 6: LastPAGE = 11
CASE 3 'Game Options
FirstPAGE = 12: LastPAGE = 15
CASE 4 'About Solitaire 3
HideMOUSE
DEF SEG = VARSEG(OtherBOX(0))
BLOAD "sol3hp16.bsv", VARPTR(OtherBOX(0))
DEF SEG
PUT (194, 80), OtherBOX, PSET
ShowMOUSE
END SELECT
IF Item <> 4 THEN CurrentPAGE = FirstPAGE: GOSUB PutHELP

DO
MouseSTATUS LB, RB, MouseX, MouseY
IF MouseY > 85 AND MouseY < 100 THEN
SELECT CASE MouseX
CASE 389 TO 403 'Left arrow button
IF LB = -1 THEN
IF CurrentPAGE > FirstPAGE THEN
CurrentPAGE = CurrentPAGE - 1
GOSUB PutHELP
END IF
END IF
CASE 405 TO 419 'Right arrow button
IF LB = -1 THEN
IF CurrentPAGE < LastPAGE THEN
CurrentPAGE = CurrentPAGE + 1
GOSUB PutHELP
END IF
END IF
CASE 423 TO 437 'Close button
IF LB = -1 THEN
GOSUB CloseHELP
EXIT DO
END IF
END SELECT
END IF
ClearMOUSE
PauseMOUSE LB, RB, MouseX, MouseY
LOOP

EXIT SUB

CloseHELP:
HideMOUSE
GET (423, 86)-(437, 99), Buttons(500)
PUT (423, 86), Buttons(400), PSET
ShowMOUSE
Interval .1
HideMOUSE
PUT (423, 86), Buttons(500), PSET
PUT (194, 80), GetBOX, PSET
ShowMOUSE
ClearMOUSE
RETURN

DoARROWS:
HideMOUSE
IF CurrentPAGE > FirstPAGE THEN
PAINT (396, 92), 15, 14
ELSE
PAINT (396, 92), 1, 14
END IF
IF CurrentPAGE < LastPAGE THEN
PAINT (411, 92), 15, 14
ELSE
PAINT (411, 92), 1, 14
END IF
ShowMOUSE
RETURN

PutHELP:
DEF SEG = VARSEG(OtherBOX(0))
FileNAME$ = "Sol3HP" + LTRIM$(RTRIM$(STR$(CurrentPAGE))) + ".BSV"
BLOAD FileNAME$, VARPTR(OtherBOX(0))
DEF SEG
HideMOUSE
PUT (194, 80), OtherBOX, PSET
ShowMOUSE
GOSUB DoARROWS
RETURN

END SUB

SUB Sol3MENU (InOUT)
SHARED LB, RB, MouseX, MouseY, Menu, Deck1, Deck2, Deck3
STATIC MenuX, MenuXX, Ix, Iy, Item, Count

IF InOUT = 0 THEN GOSUB PutMENU: EXIT SUB

'**************************** MENU OPEN SECTION ****************************

SELECT CASE Menu
CASE 3 'Game menu open
IF MouseX < 10 OR MouseX > 110 THEN GOSUB CloseMENU: EXIT SUB
SELECT CASE MouseY
CASE IS < 20
GOSUB CloseMENU
CASE 20 TO 37
IF MouseX < 12 OR MouseX > 52 THEN GOSUB CloseMENU
CASE 42 TO 56
IF Item <> 1 THEN
IF Item THEN GOSUB PutITEM
Ix = 16: Iy = 42
GOSUB GetITEM
Item = 1
END IF
IF LB THEN
GOSUB CloseMENU
Sol3DEAL
ClearMOUSE
END IF
CASE 57 TO 71
IF Item <> 2 THEN
IF Item THEN GOSUB PutITEM
Ix = 16: Iy = 57
GOSUB GetITEM
Item = 2
END IF
IF LB THEN
GOSUB CloseMENU
Sol3UNDO
ClearMOUSE
END IF
CASE 72 TO 86
IF Item <> 3 THEN
IF Item THEN GOSUB PutITEM
Ix = 16: Iy = 72
GOSUB GetITEM
Item = 3
END IF
IF LB THEN
GOSUB CloseMENU
DEF SEG = VARSEG(OtherBOX(0))
BLOAD "sol3hp17.bsv", VARPTR(OtherBOX(0))
DEF SEG
GET (194, 80)-(446, 203), GetBOX
PUT (194, 80), OtherBOX, PSET
IF Vegas = 1 THEN PUT (246, 137), Chek, PSET
IF Vegas = 0 THEN PUT (246, 155), Chek, PSET
IF Money = 1 THEN PUT (246, 173), Chek, PSET

DO
MouseSTATUS LB, RB, MouseX, MouseY
SELECT CASE MouseY
CASE 86 TO 99 'close options menu
IF (MouseX > 422 AND MouseX < 438) AND LB THEN
HideMOUSE
GET (423, 86)-(437, 99), Buttons(500)
PUT (423, 86), Buttons(400), PSET
ShowMOUSE
Interval .1
HideMOUSE
PUT (423, 86), Buttons(500), PSET
ShowMOUSE
ClearMOUSE
EXIT DO
END IF
CASE 136 TO 145 'select Vegas type scoring
IF (MouseX > 243 AND MouseX < 260) AND LB THEN
HideMOUSE
IF Vegas = 1 THEN
Vegas = 0: Score = 0
PUT (246, 155), Chek, PSET
LINE (245, 137)-(258, 144), 15, BF
LINE (563, 18)-(639, 37), 14, BF
IF Money THEN
LINE (245, 173)-(258, 180), 15, BF
Money = 0
END IF
ELSE
PUT (246, 137), Chek, PSET
LINE (245, 155)-(258, 162), 15, BF
Vegas = 1: Score = Tally
END IF
ShowMOUSE
ClearMOUSE
NewDEAL = 1
END IF
CASE 154 TO 163 'select no scoring (continuous play)
IF (MouseX > 243 AND MouseX < 260) AND LB THEN
HideMOUSE
IF Vegas = 1 THEN
LINE (563, 18)-(639, 37), 14, BF
LINE (246, 137)-(258, 144), 15, BF
Vegas = 0: Score = 0
PUT (246, 155), Chek, PSET
IF Money = 1 THEN
LINE (246, 173)-(258, 180), 15, BF
Money = 0
END IF
ELSE
PUT (246, 137), Chek, PSET
LINE (245, 155)-(258, 162), 15, BF
Vegas = 1: Score = Tally
END IF
ShowMOUSE
ClearMOUSE
NewDEAL = 1
END IF
CASE 172 TO 181 'money card
IF (MouseX > 243 AND MouseX < 260) AND LB THEN
HideMOUSE
IF Money = 1 THEN
LINE (245, 173)-(258, 180), 15, BF
Money = 0
ELSE
PUT (246, 173), Chek, PSET
Money = 1
IF Vegas = 0 THEN
PUT (246, 137), Chek, PSET
LINE (245, 155)-(258, 162), 15, BF
Vegas = 1: Score = Tally
END IF
END IF
ShowMOUSE
ClearMOUSE
NewDEAL = 1
END IF
END SELECT
PauseMOUSE LB, RB, MouseX, MouseY
LOOP
OPEN "sol3opts.dat" FOR OUTPUT AS #1
WRITE #1, Vegas, Money
CLOSE #1
HideMOUSE
PUT (194, 80), GetBOX, PSET
ShowMOUSE
IF NewDEAL THEN
Score = 0
HideMOUSE
Sol3DEAL
IF Vegas THEN SetSCORE
ShowMOUSE
ClearMOUSE
EXIT SUB
END IF
ClearMOUSE
END IF
CASE 92 TO 106
IF Item <> 4 THEN
IF Item THEN GOSUB PutITEM
Ix = 16: Iy = 92
GOSUB GetITEM
Item = 4
END IF
IF LB THEN
GOSUB CloseMENU
SYSTEM
END IF
CASE IS > 106
GOSUB CloseMENU
CASE ELSE
END SELECT
EXIT SUB
CASE 4 'Help menu open
IF MouseX < 63 OR MouseX > 163 THEN GOSUB CloseMENU: EXIT SUB
SELECT CASE MouseY
CASE IS < 20
GOSUB CloseMENU
CASE 20 TO 37
IF MouseX < 63 OR MouseX > 103 THEN GOSUB CloseMENU
CASE 42 TO 56
IF Item <> 1 THEN
IF Item THEN GOSUB PutITEM
Ix = 66: Iy = 42
GOSUB GetITEM
Item = 1
END IF
IF LB THEN
GOSUB CloseMENU
Sol3HELP 1
ClearMOUSE
END IF
CASE 57 TO 71
IF Item <> 2 THEN
IF Item THEN GOSUB PutITEM
Ix = 66: Iy = 57
GOSUB GetITEM
Item = 2
END IF
IF LB THEN
GOSUB CloseMENU
Sol3HELP 2
ClearMOUSE
END IF
CASE 72 TO 86
IF Item <> 3 THEN
IF Item THEN GOSUB PutITEM
Ix = 66: Iy = 72
GOSUB GetITEM
Item = 3
END IF
IF LB THEN
GOSUB CloseMENU
Sol3HELP 3
ClearMOUSE
END IF
CASE 92 TO 106
IF Item <> 4 THEN
IF Item THEN GOSUB PutITEM
Ix = 66: Iy = 92
GOSUB GetITEM
Item = 4
END IF
IF LB THEN
GOSUB CloseMENU
Sol3HELP 4
ClearMOUSE
END IF
CASE IS > 106
GOSUB CloseMENU
CASE ELSE
END SELECT
EXIT SUB
END SELECT

'*************************** MENU CLOSED SECTION ****************************

SELECT CASE MouseX
CASE IS < 12
IF Menu THEN GOSUB PutMENU
CASE 12 TO 52
IF Menu <> 1 THEN '-------------------- Game selected
HideMOUSE
IF Menu THEN GOSUB PutMENU
MenuX = 12
GOSUB GetMENU
LINE (12, 20)-(52, 36), 15, B
LINE (12, 36)-(52, 36), 0
LINE (52, 20)-(52, 36), 0
PUT (20, 24), MenuGFX(200), PSET
ShowMOUSE
Menu = 1
END IF
IF Menu = 1 AND LB THEN '-------------- Game opens
HideMOUSE
LINE (12, 20)-(52, 36), 14, BF
LINE (12, 20)-(52, 36), 15, B
LINE (12, 20)-(12, 36), 0
LINE (12, 20)-(52, 20), 0
PUT (21, 24), MenuGFX, PSET
GET (12, 37)-(112, 110), GetBOX
MenuXX = 12
DEF SEG = VARSEG(OtherBOX(0))
BLOAD "sol3men2.bsv", VARPTR(OtherBOX(0))
DEF SEG
PUT (12, 37), OtherBOX, PSET
Menu = 3
ShowMOUSE
END IF
CASE 53 TO 62
IF Menu THEN GOSUB PutMENU
CASE 63 TO 103
IF Menu <> 2 THEN '------------------ Help selected
HideMOUSE
IF Menu THEN GOSUB PutMENU
MenuX = 63
GOSUB GetMENU
LINE (63, 20)-(103, 36), 15, B
LINE (63, 36)-(103, 36), 0
LINE (103, 20)-(103, 36), 0
PUT (73, 24), MenuGFX(300), PSET
ShowMOUSE
Menu = 2
END IF
IF Menu = 2 AND LB THEN '-------------- Help opens
HideMOUSE
LINE (63, 20)-(103, 36), 14, BF
LINE (63, 20)-(103, 36), 15, B
LINE (63, 20)-(63, 36), 0
LINE (63, 20)-(103, 20), 0
PUT (74, 24), MenuGFX(100), PSET
GET (63, 37)-(163, 110), GetBOX
DEF SEG = VARSEG(OtherBOX(0))
BLOAD "sol3men3.bsv", VARPTR(OtherBOX(0))
DEF SEG
PUT (63, 37), OtherBOX, PSET
MenuXX = 63: Menu = 4
ShowMOUSE
END IF
END SELECT

EXIT SUB

GetITEM:
HideMOUSE
GET (Ix, Iy)-(Ix + 92, Iy + 15), ItemBOX
PUT (Ix, Iy), ItemBOX, PRESET
ShowMOUSE
RETURN

PutITEM:
HideMOUSE
IF ItemBOX(1) THEN PUT (Ix, Iy), ItemBOX, PSET
ShowMOUSE
Item = 0
RETURN

GetMENU:
HideMOUSE
GET (MenuX, 20)-(MenuX + 40, 36), MenuBOX
ShowMOUSE
RETURN

PutMENU:
HideMOUSE
PUT (MenuX, 20), MenuBOX, PSET
ShowMOUSE
Menu = 0
RETURN

CloseMENU:
HideMOUSE
PUT (MenuXX, 37), GetBOX, PSET
PUT (MenuX, 20), MenuBOX, PSET
ShowMOUSE
Menu = 0: Item = 0
RETURN
'LINE (16, 42)-(108, 56), 4, B
'LINE (16, 57)-(108, 71), 4, B
'LINE (16, 72)-(108, 86), 4, B
'LINE (16, 92)-(108, 106), 4, B

END SUB

SUB Sol3UNDO
SHARED Deck1, Deck2, Deck3, Deck4, LastDECK

HideMOUSE
IF Deck4 > 0 THEN
IF LastDECK THEN
LastSUIT = TurnUPs(Deck4).Suit
LastVALUE = TurnUPs(Deck4).Value
SELECT CASE LastDECK
CASE 1
Deck1 = Deck1 + 1
Decks(1, Deck1).Suit = LastSUIT
Decks(1, Deck1).Value = LastVALUE
PUT (5, 43), CardBACK, PSET
CASE 2
Deck2 = Deck2 + 1
Decks(2, Deck2).Suit = LastSUIT
Decks(2, Deck2).Value = LastVALUE
PUT (83, 43), CardBACK, PSET
CASE 3
Deck3 = Deck3 + 1
Decks(3, Deck3).Suit = LastSUIT
Decks(3, Deck3).Value = LastVALUE
PUT (161, 43), CardBACK, PSET
END SELECT
Deck4 = Deck4 - 1
LastSUIT = TurnUPs(Deck4).Suit
LastVALUE = TurnUPs(Deck4).Value
IF Deck4 = 0 THEN
LINE (239, 43)-(313, 152), 11, BF
ELSE
CardNUM = (LastSUIT - 1) * 13 + LastVALUE
PutCARD 239, 43, CardNUM
END IF
END IF
END IF
LastDECK = 0
ShowMOUSE

END SUB
