CHDIR ".\samples\thebob\sol"

DEFINT A-Z
DECLARE SUB SaveFILE (FileNAME$, ByteCOUNT&)
DECLARE SUB PrintSTRING (x, y, Prnt$)
DECLARE SUB DoHELP ()
DIM SHARED Box(28500)
SCREEN 12
GOSUB SetPALETTE
OPEN "sol3opts.dat" FOR OUTPUT AS #1: WRITE #1, 1, 1: CLOSE #1
LINE (100, 80)-(170, 110), 1, BF 'Draw buttons begins here
FOR x = 100 TO 152 STEP 16
    IF x = 132 THEN x = 134
    IF x = 150 THEN x = 152
    LINE (x, 80)-(x + 14, 93), 14, BF
    LINE (x, 80)-(x + 14, 93), 5, B
    LINE (x, 80)-(x + 14, 80), 15
    LINE (x, 80)-(x, 93), 15
NEXT x
LINE (104, 89)-(110, 91), 15, B
LINE (104, 89)-(109, 90), 5, B
LINE (120, 84)-(128, 91), 15, B
LINE (119, 82)-(127, 90), 5, B
LINE (119, 83)-(127, 83), 5
PSET (138, 83), 0: DRAW "F7lH7BR7G7rE7"
PSET (157, 83), 0: DRAW "F7lH7BR7G7rE7"
LINE (152, 80)-(166, 93), 5, B
LINE (153, 93)-(166, 93), 15
LINE (166, 81)-(166, 93), 15
GET (100, 80)-(148, 93), Box()
PUT (100, 95), Box(), PSET
LINE (101, 96)-(112, 107), 14, BF
LINE (117, 96)-(128, 107), 14, BF
PSET (121, 97), 1: DRAW "D9E4unH4bl1p1,1"
PSET (109, 97), 1: DRAW "D9H4unE4br1p1,1"
GET (100, 80)-(148, 93), Box()
GET (100, 95)-(148, 108), Box(200)
GET (152, 80)-(166, 93), Box(400)
SaveFILE "Sol3BTNS", 1000
LINE (100, 80)-(170, 110), 0, BF
MaxWIDTH = 587
MaxDEPTH = 98
x = 0: y = 0
RESTORE PixDATA
DO
    READ DataSTRING$
    FOR n = 1 TO LEN(DataSTRING$)
        Char$ = MID$(DataSTRING$, n, 1)
        SELECT CASE Char$
            CASE "!"
                n = n + 1
                a$ = MID$(DataSTRING$, n, 1)
                Count = ASC(a$) + 68
            CASE "#"
                n = n + 1
                B$ = MID$(DataSTRING$, n)
                FOR i = 1 TO LEN(B$)
                    t$ = MID$(B$, i, 1)
                    IF t$ = "#" THEN EXIT FOR
                    c$ = c$ + t$
                NEXT i
                Count = VAL("&H" + c$)
                n = n + LEN(c$)
                c$ = ""
            CASE ELSE
                Count = ASC(Char$) - 60
        END SELECT
        n = n + 1
        Colr = VAL("&H" + MID$(DataSTRING$, n, 1))
        FOR Reps = 1 TO Count
            PSET (x, y), Colr
            x = x + 1
            IF x > MaxWIDTH THEN x = 0: y = y + 1
        NEXT Reps
    NEXT n
LOOP UNTIL y > MaxDEPTH 'DATA drawing loop ends here --------------------
LINE (544, 75)-(544, 85), 14
GET (530, 89)-(542, 96), Box() 'check mark
LINE (530, 86)-(544, 98), 0, BF
SaveFILE "Sol3Chek", 100
FaceINDEX = 14500 'get face cards
FOR FaceX = 0 TO 540 STEP 49
    GET (FaceX, 0)-(FaceX + 48, 43), Box(FaceINDEX)
    PUT (FaceX, 0), Box(FaceINDEX)
    FaceINDEX = FaceINDEX + 800
NEXT FaceX
GET (48, 88)-(113, 98), Box(24000)
GET (119, 88)-(148, 98), Box(24200)
GET (154, 88)-(194, 98), Box(24400)
GET (200, 88)-(232, 98), Box(24600)
GET (238, 88)-(266, 98), Box(24800)
GET (272, 88)-(315, 98), Box(25000)
GET (320, 88)-(326, 98), Box(25200)
DEF SEG = VARSEG(Box(0))
BSAVE "sol3hdgs.bsv", VARPTR(Box(24000)), 2800
DEF SEG
LINE (48, 88)-(328, 98), 0, BF
GET (0, 45)-(40, 94), Box(25500)
PUT (0, 45), Box(25500)
GET (412, 70)-(462, 85), Box() 'Get title begins here ---------------------
PUT (412, 70), Box()
SaveFILE "Sol3TITL", 452
Index = 0 'Get numbers/$ begins here ----------------------
FOR x = 465 TO 537 STEP 8
    GET (x, 76)-(x + 7, 85), Box(Index)
    Index = Index + 50
NEXT x
GET (331, 87)-(337, 97), Box(Index)
Index = Index + 50
FOR x = 465 TO 544
    FOR y = 75 TO 85
        IF POINT(x, y) = 2 THEN PSET (x, y), 4
NEXT y: NEXT x
FOR x = 465 TO 537 STEP 8
    GET (x, 76)-(x + 7, 85), Box(Index)
    Index = Index + 50
NEXT x
GET (340, 87)-(347, 97), Box(Index)
SaveFILE "Sol3NUMS", 2200
LINE (329, 86)-(348, 98), 0, BF
LINE (465, 74)-(544, 85), 0, BF
Index = 0 'Get stack symbols begins here ----------------------------
FOR x = 430 TO 520 STEP 30
    GET (x, 46)-(x + 24, 69), Box(Index)
    PUT (x, 46), Box(Index)
    Index = Index + 200
NEXT x
SaveFILE "Sol3SUIT", 1600
Index = 2
FOR y = 50 TO 74 STEP 12
    FOR x = 44 TO 424 STEP 12
        GET (x, y)-(x + 11, y + 11), Box(Index)
        PUT (x, y), Box(Index)
        Index = Index + 50
        IF Index = 94 * 50 + 2 THEN EXIT FOR
NEXT x: NEXT y
Box(0) = 50
Box(1) = 3
FOR Index = 2 TO 93 * 50 + 2 STEP 50
    LINE (0, 200)-(20, 220), 0, BF
    PUT (0, 200), Box(Index)
    x1 = -1: x2 = -1
    FOR x = 0 TO 20
        FOR y = 200 TO 220
            IF POINT(x, y) <> 0 AND x1 = -1 THEN x1 = x
    NEXT y: NEXT x
    FOR x = 20 TO 0 STEP -1
        FOR y = 200 TO 220
            IF POINT(x, y) <> 0 AND x2 = -1 THEN x2 = x
    NEXT y: NEXT x
    GET (x1, 200)-(x2 + 1, 211), Box(Index)
NEXT Index
LINE (0, 200)-(20, 220), 0, BF
DEF SEG = VARSEG(Box(0))
BSAVE "sol3mssr.fnt", VARPTR(Box(0)), 10000
DEF SEG
GET (568, 73)-(582, 87), Box(2500) 'heart 'Card prep code begins here -----
GET (570, 90)-(580, 98), Box(2700) 'small heart
GET (546, 45)-(560, 60), Box(2900) 'club
GET (548, 62)-(558, 71), Box(3100) 'small club
GET (547, 72)-(560, 86), Box(3300) 'diamond
GET (549, 88)-(559, 98), Box(3500) 'small diamond
GET (567, 45)-(581, 60), Box(3700) 'spade
GET (569, 61)-(579, 71), Box(3900) 'small spade
LINE (546, 45)-(588, 98), 0, BF
Index = 4100 'Red Ace
FOR x = 350 TO 518 STEP 14
    GET (x, 87)-(x + 10, 98), Box(Index)
    Index = Index + 200
NEXT x
FOR x = 350 TO 532
    FOR y = 87 TO 98
        IF POINT(x, y) = 4 THEN PSET (x, y), 0
        IF POINT(x, y) = 12 THEN PSET (x, y), 14
NEXT y: NEXT x
Index = 6700 'Black Ace
FOR x = 350 TO 518 STEP 14
    GET (x, 87)-(x + 10, 98), Box(Index)
    Index = Index + 200
NEXT x
LINE (350, 86)-(530, 98), 0, BF
SpotINDEX = 2500
FOR Reps = 1 TO 4
    GOSUB DoSPOTS
    SpotINDEX = SpotINDEX + 400
NEXT Reps
GOSUB DrawBLANK
LINE (269, 191)-(339, 295), 15, BF
Index = 6100: SpotINDEX = 2700
FaceINDEX = 14500
CardNUM = 11
FOR Reps = 1 TO 12
    PUT (280, 200), Box(FaceINDEX), PSET
    PUT (269, 207), Box(SpotINDEX), PSET
    PUT (269, 194), Box(Index), PSET
    Index = Index + 200
    FaceINDEX = FaceINDEX + 800
    IF Index = 6700 THEN
        Index = 8700
        IF SpotINDEX = 3500 THEN SpotINDEX = 3900 ELSE SpotINDEX = 3100
    END IF
    IF Index = 9300 THEN Index = 6100: SpotINDEX = 3500
    FOR xx = 269 TO 339
        FOR yy = 191 TO 243
            PSET (608 - xx, 486 - yy), POINT(xx, yy)
    NEXT yy: NEXT xx
    FOR x = 269 TO 339
        FOR y = 191 TO 295
            PSET (x - 87, y), POINT(x, y)
    NEXT y: NEXT x
    GET (180, 189)-(254, 297), Box()
    FileNAME$ = "Sol3CD" + LTRIM$(RTRIM$(STR$(CardNUM)))
    SaveFILE FileNAME$, 4400
    CardNUM = CardNUM + 1
    IF CardNUM = 14 THEN CardNUM = 24
    IF CardNUM = 27 THEN CardNUM = 37
    IF CardNUM = 40 THEN CardNUM = 50
NEXT Reps
LINE (269, 191)-(339, 295), 0, BF
LINE (182, 191)-(252, 295), 15, BF 'Draw money card begins here ------------
LINE (193, 200)-(241, 286), 8, B
LINE (212, 205)-(214, 280), 6, BF
LINE (220, 205)-(222, 280), 6, BF
FOR y = 216 TO 256 STEP 20
    LINE (200, y)-(234, y + 16), 6, BF
    LINE (201, y + 4)-(233, y + 12), 2, BF
NEXT y
LINE (200, 220)-(200, 236), 6
LINE (234, 236)-(234, 256), 6
LINE (201, 224)-(201, 240), 2
LINE (233, 240)-(233, 260), 2
LINE (202, 230)-(202, 236), 6
LINE (232, 250)-(232, 256), 6
LINE (213, 208)-(213, 277), 2
LINE (221, 208)-(221, 277), 2
FOR y = 200 TO 210 STEP 5
    LINE (184, y)-(190, y + 2), 7, BF
NEXT y
LINE (184, 200)-(184, 205), 7
LINE (190, 205)-(190, 210), 7
PSET (188, 197), 7: DRAW "D18 bl2 U18"
GET (184, 197)-(190, 215), Box()
PUT (244, 271), Box(), PSET
FOR y = 216 TO 256 STEP 20
    LINE (205, y + 7)-(229, y + 9), 7, BF
    LINE (205, y + 7)-(229, y + 8), 3, B
NEXT y
GET (196, 210)-(206, 254), Box()
PUT (197, 210), Box(), PSET
GET (230, 234)-(238, 274), Box()
PUT (229, 234), Box(), PSET
PSET (201, 216), 15: DRAW "RG"
PSET (201, 252), 15: DRAW "RH"
PSET (233, 236), 15: DRAW "LF"
PSET (233, 272), 15: DRAW "LE"
GET (180, 189)-(254, 297), Box()
SaveFILE "Sol3CD55", 4400
LINE (182, 194)-(252, 292), 15, BF 'Draw card back begins here ------------
FOR x = 186 TO 248 STEP 2
    FOR y = 195 TO 291 STEP 2
        PSET (x, y), 1
        IF x <> 248 THEN PSET (x + 1, y + 1), 0
NEXT y: NEXT x
GET (180, 189)-(254, 297), Box()
SaveFILE "Sol3CD53", 4400
GET (180, 189)-(254, 317), Box()
SaveFILE "Sol3CD54", 5200
LINE (180, 189)-(254, 297), 5, BF
LINE (180, 189)-(181, 189), 0: PSET (180, 190), 0
LINE (180, 297)-(181, 297), 0: PSET (180, 296), 0
LINE (253, 189)-(254, 189), 0: PSET (254, 190), 0
LINE (253, 297)-(254, 297), 0: PSET (254, 296), 0
GET (180, 189)-(254, 297), Box()
SaveFILE "Sol3Sele", 4400
LINE (180, 189)-(254, 190), 0, B
LINE (182, 190)-(252, 190), 15
PSET (181, 189), 15: PSET (253, 189), 15
GET (180, 189)-(254, 190), Box()
SaveFILE "Sol3Topp", 88
LINE (170, 179)-(264, 320), 0, BF
DoHELP
OUT &H3C8, 14: OUT &H3C9, 63: OUT &H3C9, 52: OUT &H3C9, 40
LINE (5, 5)-(634, 474), 5, B: LINE (8, 8)-(631, 471), 5, B
LINE (200, 180)-(439, 290), 5, B: LINE (197, 177)-(442, 293), 5, B
PrintSTRING 238, 212, "The graphics files for SOLITAIRE-3"
PrintSTRING 243, 226, "have been successfully created."
PrintSTRING 246, 250, "You can now run the program."
a$ = INPUT$(1)
END

DrawBLANK:
LINE (170, 179)-(264, 320), 11, BF
LINE (180, 189)-(254, 297), 15, BF
LINE (180, 189)-(254, 297), 0, B
LINE (180, 189)-(181, 190), 11, B
PSET (181, 190), 0
LINE (253, 189)-(254, 190), 11, B
PSET (253, 190), 0
LINE (180, 296)-(181, 297), 11, B
PSET (181, 296), 0
LINE (253, 296)-(264, 297), 11, B
PSET (253, 296), 0
PUT (182, 207), Box(SpotINDEX + 200), PSET
RETURN

DoSPOTS:
GOSUB DrawBLANK
GOSUB PutNUM
PUT (210, 202), Box(SpotINDEX), PSET: GOSUB Invert
GOSUB SaveCARD: GOSUB PutNUM: GOSUB Ace: GOSUB SaveCARD
GOSUB DrawBLANK: GOSUB PutNUM: GOSUB Ace
IF SpotINDEX = 3700 THEN PUT (197, 215), Box(25500), PSET
GOSUB SaveCARD: GOSUB DrawBLANK
GOSUB Top: GOSUB PutNUM: GOSUB Invert: GOSUB SaveCARD
GOSUB PutNUM: GOSUB Ace: GOSUB SaveCARD
PAINT (217, 240), 15: GOSUB PutNUM: GOSUB Middle: GOSUB SaveCARD
GOSUB PutNUM: PUT (210, 218), Box(SpotINDEX), PSET
GOSUB Middle: GOSUB SaveCARD: LINE (195, 218)-(240, 260), 15, BF
GOSUB MidTOP: GOSUB PutNUM: GOSUB Invert: GOSUB SaveCARD
IF SpotINDEX = 2900 OR SpotINDEX = 3700 THEN Shift = -2 ELSE Shift = 0
GOSUB PutNUM: PUT (210, 237 + Shift), Box(SpotINDEX), PSET
IF SpotINDEX = 3700 THEN PSET (210, 235), 0: PSET (224, 235), 0
GOSUB SaveCARD: PAINT (217, 240), 15
PUT (210, 213), Box(SpotINDEX), PSET
GOSUB PutNUM
IF SpotINDEX = 3700 THEN PSET (210, 213), 0: PSET (224, 213), 0
IF SpotINDEX = 2500 THEN PSET (210, 226), 12: PSET (210, 227), 13
IF SpotINDEX = 2500 THEN PSET (224, 226), 12: PSET (224, 227), 13
GOSUB Invert: GOSUB SaveCARD
RETURN
Top:
PUT (196, 202), Box(SpotINDEX), PSET 'Four hearts
PUT (224, 202), Box(SpotINDEX), PSET 'Four hearts + Five (with Ace) + 6 Hearts top row
RETURN
MidTOP:
PUT (196, 224), Box(SpotINDEX), PSET
PUT (224, 224), Box(SpotINDEX), PSET
RETURN
Middle:
PUT (196, 236), Box(SpotINDEX), PSET
PUT (224, 236), Box(SpotINDEX), PSET
RETURN
Ace:
PUT (210, 235), Box(SpotINDEX), PSET
RETURN
Invert:
FOR x = 180 TO 254
    FOR y = 189 TO 244
        PSET (434 - x, 486 - y), POINT(x, y)
NEXT y: NEXT x
RETURN
PutNUM:
CardCOUNT = CardCOUNT + 1
IF CardCOUNT = 11 THEN CardCOUNT = 14
IF CardCOUNT = 24 THEN CardCOUNT = 27
IF CardCOUNT = 37 THEN CardCOUNT = 40
SaveNUM = CardCOUNT
SELECT CASE SaveNUM
    CASE 1, 14, 27, 40: SaveNUM = SaveNUM + 1
    CASE 2, 15, 28, 41: SaveNUM = SaveNUM + 1
    CASE 3, 16, 29, 42: SaveNUM = SaveNUM - 2
END SELECT
NumINDEX = (SaveNUM MOD 13) * 200 + 3900
IF SaveNUM MOD 26 = SaveNUM MOD 13 THEN Advance = 0 ELSE Advance = 2600
PUT (182, 194), Box(NumINDEX + Advance), PSET
GOSUB Invert
RETURN
SaveCARD:
GET (180, 189)-(254, 297), Box()
FileNAME$ = "Sol3CD" + LTRIM$(RTRIM$(STR$(SaveNUM)))
SaveFILE FileNAME$, 4400
RETURN
DrawBOX:
RETURN

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

HelpDATA:
DATA "Solitaire 3 is played in the same way as con-"
DATA "ventional Solitaire, with one exceptiion: the"
DATA "24 cards remaining after the deal are divided"
DATA "into three stacks of 8 rather than the usual"
DATA "single stack of 24, thus creating an additional"
DATA "choice which can affect game outcome."
DATA "A game that might otherwise have been lost"
DATA "based strictly on the deal might now be won,"
DATA "and vice versa."
DATA ""
DATA "In conventional Solitaire, the outcome is"
DATA "determined at the time the cards are dealt."
DATA "In Solitaire 3, `Undo` is limited to cards"
DATA "turned up from one of the three decks. Any"
DATA "other move is considered finished."
DATA ""
DATA "This limited Undo is only possible immediately"
DATA "following a card turn-up."
DATA "To move cards or columns of cards, first"
DATA "click the column of the card(s) to be moved,"
DATA "then the destination column (it is not nec-"
DATA "essary to click a specific card; legal sel-"
DATA "ections are made automatically). In either"
DATA "case, only the bottom card is highlighted."
DATA "To send any legal card addition to the suit"
DATA "stacks (top-right screen), simply double-click"
DATA "the card, regardless of its location. To over-"
DATA "turn a card, simply click it."
DATA "For rules of Solitaire and basic play, reopen"
DATA "Help and click `Basic Solitaire`."
DATA "The object of Solitaire is to move all cards"
DATA "to their appropriate suit stack (top-right"
DATA "screen); aces first through kings."
DATA "Cards in the seven sorting columns (screen"
DATA "bottom) must be assembled in sequence:"
DATA "highest at the top to lowest at the bottom."
DATA "Black suits (clubs or spades) can only be"
DATA "placed on red suits (hearts or diamonds) in"
DATA "these columns, and vice versa."
DATA "It is not necessary to create entire columns"
DATA "of cards before moving cards to the stacks."
DATA "These columns are merely used for sorting."
DATA "Cards must be face up in order to be in play."
DATA "To overturn a card, simply click it. A card"
DATA "cannot be overturned unless there are no"
DATA "cards on top of it. To remove covering cards,"
DATA "they must be legally transferred to another"
DATA "column or sent to the suit stacks."
DATA "Multiple card groupings may also be moved"
DATA "(to columns only) provided the top-most card"
DATA "in the grouping is a legal match for the bot-"
DATA "tom card of the column being moved to."
DATA "Kings (or groupings with a king on top) may"
DATA "be moved to an empty column."
DATA "When no further play is possible with visible"
DATA "cards, overturn a new card by clicking one of"
DATA "the three decks in the top-left screen area."
DATA "If this new card cannot be played (legally"
DATA "moved to a sorting column or to a suit"
DATA "stack), click one of the three decks again."
DATA "When no further progressive moves are pos-"
DATA "sible, the game is over. Whether or not you"
DATA "have won depends on how many cards you"
DATA "have `stacked`. A minimum of eleven cards"
DATA "is required for a win, but the ideal, of course,"
DATA "is to stack all 52 cards."
DATA "Game Options in Solitaire 3 are limited to"
DATA "scoring preferences. These divide basically"
DATA "into Vegas-style scoring or no scoring."
DATA "There is a further option which can only"
DATA "be used when Vegas-style scoring is selec-"
DATA "ted: the Money card."
DATA "In Vegas-style scoring, you are charged"
DATA "$52.00 for each deck (deal) and are payed"
DATA "$5.00 for each card sent to the suit stacks."
DATA "Maximum earnings per game: $208.00."
DATA "With Vegas-style scoring, your score, plus"
DATA "or minus, is carried over from game to game."
DATA "The money card (if selected) is somewhere in"
DATA "the three decks and may turn up at any time."
DATA "When turned up, it can double the value of"
DATA "any cards on the suit stacks up to that point."
DATA "Its value is accessed merely by clicking it,"
DATA "at which time its host card replaces it."
DATA "If you select Vegas-style scoring, you are"
DATA "only permitted to go through the three decks"
DATA "once. If you deselect it, you may go"
DATA "through them as many times as you wish."
DATA "Simply click the deck area after it is empty"
DATA "of all cards to reset the decks."

PixDATA:

DATA "#24D#8BF=8?4=F@4=F>4=F?4=F>4=F@4=F=4=8JF>8BF=8=4=8=F=8=9=8=9=8=9=8>F@0"
DATA "=4=B=3=B=3=0NF>8KF=0=B?3=B?3=B?3=B>3=7=B?7=B>7=B=0BF>8AF=0>4=0?4=0>4=0"
DATA "@4=0?4=0?4=0>4=0KF>8=0@3?B=3=4?0=4>F>9=8=9=8=9=8>F=8QF>8IF=0=B?3=B?3=B"
DATA "?3=B>3=7=B?7=B?7=0DF>8BF=0>4=F?4=F?4=F@4=F>4=F?4=F>4=0JF>8=0@3?B=3=4?0"
DATA "=4=9=F>9=8=9=8=9=8=F=9=8QF>8IF=0=6=3=6=3=6=3=6=3=6=3=6>3=6C3A7=9BF>8AF"
DATA "=0>4=0@4=0=4=0@4=0=4=0@4=0?4=0KF>8BF=8=4=8=F=8=9=8=9=8=9=8>F=0=F>0=4=6"
DATA "?3=0NF>8IF=0=7=6?7=6?7=6=7>3=6?3=6?3=6?3=0CF>8CF=8?4=F?4=F>4=F?4=F>4=F"
DATA "?4=F=4=8KF>8BF=8=4>8=9AF>9=8@0=4=3=B=3=0OF>8LF=0=B=3=B=3=B=3=B=3=B=3=B"
DATA "=3=B=3=B=7=B=7=B=7=B=7=0CF>8BF=0>4=0?4=0>4=0?4=0>4=0?4=0>4=0BF=E=0=ECF"
DATA ">8=F=0?3>B>3=4>0>4=F=9>8@F=9>8=3GF=E=0=ECF>8CF=E=0=E@F=0=B=3=B=3=B=3=B"
DATA "=3=B=3=B=3=B=3=B=7=B=7=B=7=B=7=0EF>8CF=0>4=F?4=F>4=F?4=F>4=F?4=F>4=0CF"
DATA "=4CF>8=E=0?3>B>3=4>0>4=F=9>8@F=9=8=9=3IF=4CF>8CF=4AF=E=0=6?3=6?3=6>3=6"
DATA "=3=6>3=6?3@7=8@F=9>F>8BF=0>4=0?4=0=4=0@4=0=4=0?4=0?4=0CF=0DF>8=F=8@F=8"
DATA "=4>8=9AF>9=8=0=F>0=4=3=6=3=0FF=0DF>8DF=0AF=0=7=6=7=6=7=6=7=6=7=6=3=6=3"
DATA "=6=3=6=3=6=3=6=3=6=3=0DF>8DF=8?4@F>4AF>4@F=4=8=9KF>8BF=8=4=8FF=9?0=4=B"
DATA ">3=0OF>8MF=0>3=B?3=B?3=B>3=7=B?7=B=7=0DF>8BF=B=0>4=0>4=0>4=0?4=0>4=0?4"
DATA "=0=4=0BFA0BF>8>F=0@3=B=3=4>0=4=9=F=8DF=8=3FFA0BF>8BFA0@F=0>3=B?3=B?3=B"
DATA ">3=7=B?7=B=7=0FF>8DF=0=4=F?4=F>4=F?4=F>4=F>4=F>4=0CF?4BF>8=F=E=0@3=B=3"
DATA "=4>0=4=9=F=8DF=9=7=EGF?4BF>8BF?4AF=0=3?6=3?6=3>6=3=6>3=6=3=6=3=7=6>7=8"
DATA "?F=9>8>F>8CF=0>4@0=4B0=4@0?4=0CF?0CF?8=3=8?F=8=4=8FF=0=F>0=4=6>3=0EF?0"
DATA "CF>8CF?0AF=0?7=6?7=6=7>3=6?3=6?3=6=3=0EF>8EF=8P4=8=F=C?4=D?F=D?4=C>F>8"
DATA "AF=9=8=4=8=F>9?F?9=F=9?0>4=B=0AF=C?4=D?F=D?4=C>F>8>F=C?4=D?F=D?4=C>F=0"
DATA ">B=3?B=3?B=3?B=7?B=7=B=0=F>BAF>8BF=B=3=0>4?0>4A0>4@0=4=0BF=EA0=EAF>8>F"
DATA "=0=3>B=3=B>4=0>4=9=8=F?8?F=9>8=0=3DF=EA0=EAF>8AF=EA0=E?F=0>B=3?B=3?B=3"
DATA "?B=7?B=7=B=0FF>8EF=0=4@F>4AF>4?F>4=0CF=D?4=DAF>8>F=0=3>B=3=B>4=0>4=9=8"
DATA "=F?8?F=9=8=9=0=3FF=D?4=DAF>8AF=D?4=DAF=0CD@4=3>6=3=6=3=7=6=7=6=7=8>F=8"
DATA "=9=F=8>F>8=F=3=7=3@F=0O4=0CFA0BF?8=3=8?F=8=4=8=F>9?F?9=F=0=F>0=4=7=6=0"
DATA "EFA0BF>8BFA0AF=0>6=7?6=7?6=3?6=3?6=3=6=0EF>8?F=9BF=8N4=8=F=CA4=D=F=DA4"
DATA "=C=F>8AF=8>4=8>9=8?9=8>9=8=F=9?0=4=3=0@F=CA4=D=F=DA4=C=F>8=F=CA4=D=F=D"
DATA "A4=C>F=0G3C7=0>F>7=B@F>8=0@F=B>3=B=0>4>0>4A0>4?0>4=0BFC0AF>8?F=0@B=4>0"
DATA "=4=9=8=F>9=8>9>F=8>9=0=3DFC0AF>8AFC0@F=0G3C7=0GF>8EF=0>4?F>4AF>4>F?4=0"
DATA "BF=DA4=D@F>8>F=E=0@B=4>0=4>9=F>9=8>9>F=8>9=0=3EF=DA4=D@F>8@F=DA4=D@F=E"
DATA "BDE4?6=7=6=7=8>F=8?F=8=F=7>8=F=7=4=7AFO0CFC0AF>8?3=8=F=8>4@8?9@8=F=0=F"
DATA ">0=4=3=0DFC0AF>8AFC0@F=9=6D7F3=0FF>8?F>8=9AFN0=9=F=DB4=CB4=D=F>8AF=8>4"
DATA "=8=F>8>9=F?8>F=9?0=4=B=0@F=DB4=CB4=D=F>8=F=DB4=CB4=D?FI4>D?4?F=7@9>F>8"
DATA "=4=0?F=B=3=B=F=0M4=0CF=EA0=EAF>8?F=0=3=B>3=4>0=4=8?F?8=9>F>8=9=0=3DF=E"
DATA "A0=EAF>8AF=EA0=EAFI4>D?4HF>8=3EF=0M4=0BF=CC4=C?F>8?F=0=3=B>3=4>0=4>9>F"
DATA "?8=9>F>8=9=0=7=ECF=CC4=C?F>8?F=CC4=C@FE0E4=6=7=4>F=9=8>F>8=7?8=F=7=4=7"
DATA "AFO0BFE0@F>8?3>8>4=0=8=9>8>9=F>8=9>F=0=F>0=4=6=0CFE0@F>8@FE0@F@4>DI4GF"
DATA ">8=7>F=8=F=9=8@FN0>FK4=F>8AF=8=4=3=8?F=9CF=9?0=4=3=0@FK4=F>8=FK4?FI4>D"
DATA "?4?8=7@F=9=F>8>4=0>F=B=3=B=FO0DF=E?0=EBF>8?F=0>3=B=3=4=0>4=9GF=9>0=3DF"
DATA "=E?0=EBF>8BF=E?0=EBFI4>D?4HF>8=7=3DFO0AF=C=DC4=D=C>F>8?F=0>3=B=3=4=0>4"
DATA ">9FF=9>0=3BF=C=DC4=D=C>F>8>F=C=DC4=D=C?FG0F4>F=8>F=8=3>8=4>8=F=7=4=7AF"
DATA "=8CF=6=3=6=3=6=3=6=3=6=3=6AFG0?F>8?3>8=4=0=F=8?F=9CF=0=F>0=4=7=0BFG0?F"
DATA ">8?FG0?F@4>DI4GF?8=7=F=8?F=8?F=6=7=6=7=6=7=6=7=6=7=6BF=9>FJ4=D=F>8@F=9"
DATA "=8=4=3=8?F=9CF=9=F>0>4=8=0?FK4=F>8=FJ4=D?FN0?F=7B9>8?4=0=B=F=B>F=BN0AF"
DATA "=E=0=E=F?0=F=E=0=E?F>8>F=0>B=3=B>4=0=4=F=9GF=9>0=3AF=E=0=E=F?0=F=E=0=E"
DATA "?F>8?F=E=0=E=F?0=F=E=0=E?FN0EF=9>F>8=1=7=3CFN0=BAF=DE4=D>F>8>F=0>B=3=B"
DATA ">4=0=4=9=F=9FF=9>0=3BF=DE4=D>F>8>F=DE4=D?F=8AF=9B0C4=8=F=9=8>F=8>3=8=4"
DATA ">8=F=7=4=7AF>9>8>9>F=6=3=6=3=6=3=6=3=6=3=6@FI0>F>8?7>8=4=0=F=8?F=9CF=0"
DATA "=F>0=4=7=6=0@FI0>F>8>FI0>FO0DF=6>F>8=4=8=F>8>F=8=9>F=6=3=6=3=6=3=6=3=6"
DATA "=3=6>FA9>F=DI4=D=F>8@F=8>4=3=8?F=8CF=8=9?0=4=3=0?F=DI4=D=F>8=F=DI4=D?F"
DATA "N0>8>7AF=9>8@4=0?F=B=7=BFF=B=7=B>7=B=7=B?FI0>F>8>F=0@B=4>0=4=9=8EF=9=F"
DATA "=9=4=0=3@FI0>F>8>FI0>FN0DF=9=8=9=F>8=7=1=3CF=7=B>7=B=7=BFF=B=7@F=DG4=D"
DATA "=F>8=F=E=0@B=4>0=4=9=F=9DF=9=F=9=4=0=7=E@F=DG4=D=F>8=F=DG4=D>F=9>8=9@F"
DATA "=9G0>F=8>F=8>3=7=9?8=F=7=4=7AF=9=8?F=9=8=F=6=3=6=3=6=3=6=3=6=3=6?F=EI0"
DATA "=E=F>8=0=7=0>8=D=0=F=8?F=8CF=8=0=F>0=4=3=0?F=EI0=E=F>8=F=EI0=E=FO0CF=6"
DATA "=F=6=F>8=4=7>8=3=8>F=8>F=6=3=6=3=6=3=6=3=6=3=6=F=9?F=9=8>F=CI4=C=F>8@F"
DATA "=8>4=3=0=9>F=9=8=9@F=9=8=9?0=4=B=3=0>F=CI4=C=F>8=F=CI4=C?F=9HF=9=F=9=F"
DATA "=9?F=7AF=9>8A4=0>F=B=3@8?F@8=B>3=B=3=B=3=B>F=EI0=E=F>8=F=0>3=B>3=4=0>4"
DATA "=9=8=9AF=8>9>F=9=4>0=3>F=EI0=E=F>8=F=EI0=E=F=8=9GF=8=F=8=F=8CF=9?8=9>8"
DATA "=7=1=0BF=7=3=B=3=B>3=B?8=9?F=9?8=3=7@F=DE4=D>F>8=E=0>3=B>3=4=0>4=9=F=9"
DATA "AF=8>9>F=9=4>0=3AF=DE4=D>F>8>F=DE4=D?F=9=8?9@F=8=9E0>F@8>3=9=F=9>8=F?7"
DATA "@F>9=F>8>9>F=6=3=6=3=6=3=6=3=6=3=6?FK0=F?8=7?8=D=0=F=0=9>F=9=8=9@F=9=8"
DATA "=0=F>0=4=6=0?FK0=F>8=FK0=F=9=8=F=8=F=8GF=9=8BF=6?F=6>8=4=7=8>3=8>F=8=9"
DATA "=F=6=3=6=3=6=3=6=3=6=3=6=F>9>8=F=9?F=DG4=D>F>8@F=8>4=3=0=8EF=8=9=F=9>0"
DATA ">4>3=0>F=DG4=D>F>8>F=DG4=D@F@9?F?9?F=9=F=9=F=9?8=7@F=9=F>8C0=F=B=3=8=F"
DATA "=9=8=9=F>8=9>F>B=3=B=3=B=3=B>FK0=F>8=0>3>B=3>4=0>4=F=9=8FF=9=4>0=3>FK0"
DATA "=F>8=FK0=F=8=9=F=8>9?F=9=8>F=8=F=8=F=8CF=8=F=8=0=9>8=7=1=3@F=1=F=B=3=B"
DATA "=3=B=3>B=F>9=8>F=9=8=9=F=8=3=B@F=C=DC4=D=C>F>8=0>3>B=3>4=0>4=9=F=9FF=9"
DATA "=4>0=3AF=C=DC4=D=C>F>8>F=C=DC4=D=C>F=9>F?8=9?F=8=F=9=F=9B0>F=8>F=8>7=9"
DATA "=F=9>8>F=7AF=8>F=1?8>F=6=3=6=3=6=3=6=3=6=3=6?FK0=F>8?3=8>D=0=F=0=8EF=8"
DATA "=9=0=F>0=D=7=0?FK0=F>8=FK0=F=9=8=F=8=F=8>F=8=9?F>9=8=F=9=8BF=6=F=2=F=6"
DATA ">8=4=8=9=7>3=8>F=8=F=6=3=6=3=6=3=6=3=6=3=6?F=9=8>F=8?FG4?F>8?F=9=8=4=3"
DATA "=B=0=8=F=9?8=9?F=8?9?0>4>3=0>FG4?F>8?FG4AF=9?8=9>F?8=9>F=9=F=9=F=9=F=B"
DATA ">7@9>F>8>7=3=7=0?F=B=3A8>F?8=9=F=B=3=B=3=B=3=B>F=EI0=E=F>8=F>0>3>4>0=4"
DATA "?9=8@F=9?8=9=F=8>4=0=3>F=EI0=E=F>8=F=EI0=E=9A8>9=F@8>F=8=F=8=F=8BF=8=4"
DATA "=8=0=9>8=0=1=3>F>1=3=F=B=3=B=3=B=3=B=F=9?8>FA8=3=BAF=CC4=C?F>8=F>0>3>4"
DATA ">0=4>9=F=9@F=9?8=9=F=8>4=0=7=EAF=CC4=C?F>8?F=CC4=C>F=8>F=9=8=9@F=8=FC9"
DATA "=F=9=8>F@8?7=F=9>8=F=3=7=3?F=8?F>9AF=6=3=6=3=6=3=6=3=6=3=6>FK0=F?8=7>8"
DATA "=D=0>F=0=8=F=9?8=9?F=8>9=0=F?0@FK0=F>8=FK0=F=8=F=8=F=8>F@8=F>9A8=9AF=6"
DATA "=F=2=F=6>8=F=9=F=9>3@8=F=6=3=6=3=6=3=6=3=6=3=6CF=9@FE4@F>8?F=8>4=3?0>F"
DATA "=9=8=9?F=8=F>9=F=9?0>4=0@FE4@F>8@FE4BF>9>8=9>F?8>9=F=9=F=9=F=9=F=B>7?F"
DATA "=9>F>8>B=3=7=0?F=B=3=8=9>F=8?F>9>F=B=3=B=3=B=3=B?FA0=F=0=FA0>F>8?F=0>4"
DATA ">0>4=F>9=3=8@F=9>8>F?4>0=3>FA0=F=0=FA0>F>8>FA0=F=0=FA0=F=9=8=F=9>8>9=F"
DATA "=9>8>9=F=8=F=8=F=8BF=8=4=8=0=9>8=7=1=3>1>3=1=F=B=3=B=3=B=3=B>F>9?F=8=F"
DATA ">9=8=3=BBF=DA4=D@F>8?F=0>4>0>4=F=9=F=9=8@F=9>8>F?4>0=3BF=DA4=D@F>8@F=D"
DATA "A4=D>F=8>F=9CF=8=F=9=F=9=F=9=F=9=F=9=8>F=8?F=8>7=9?8=F=7=4=7>F>9FF=6=3"
DATA "=6=3=6=3=6=3=6=3=6>FB0=F=0=FB0=F>8?3=8=D=0=F?0=9=F=9=8=9?F=8=9?0=F>0=E"
DATA "@FB0=F=0=FB0=F>8=FB0=F=0=FB0=F=8=F=8=F=8=F>9>8=9=F>9>8=9=F=8=9AF=6=F=6"
DATA "=F=6>8=F=9=F=9>7=8>F=8=F=6=3=6=3=6=3=6=3=6=3=6DF=8@FC4AF>8?F=8>4=3>0=7"
DATA "=8BF=8>F=8?9?0=4=0BFC4AF>8AFC4CF=8=F?9?F?9>F=9=F=9=F>9=F>B@9>F>8>B=3=7"
DATA "=0>F=B>3=8?F=8CF=B=3=B=3=B=3=B@F=E=0=E>F=0>F=E=0=E?F>8@F=0=4>0=4?9=3=4"
DATA "=3=8CF=9?4>0=3?F=E=0=E>F=0>F=E=0=E?F>8?F=E=0=E>F=0>F=E=0=E>F=9=8>F@9>F"
DATA ">9?F=8=F=8=F=8BF=8>D=0=9>8?1>3=0=7=1=F=B=3=B=3=B=3=BCF=8?F=8=3=BCF=D?4"
DATA "=DAF>8@F=0=4>0=4=9=F=9=F=9=3=8CF=9=0>4>0=3CF=D?4=DAF>8AF=D?4=D?F=9>8=9"
DATA "?F=9?F=8=F=9=F=9=F=9=F=9=F=9=F=8=F=9=8>F=8>7=8=4>8=F?7>F?9>8?F>9?F=6=3"
DATA "=6=3=6=3=6=3=6=3=6>F@0=F=E=0=E=F@0>F>8?7=8=D=0=F>0=9=8AF=9=8>0=7>0=F?0"
DATA "AF@0=F=E=0=E=F@0>F>8>F@0=F=E=0=E=F@0>F=8=F=8=F=8?F>9>F@9>F=8=9AF=6=F=6"
DATA "=2=6>8=F=9=F?7@8=F=6=3=6=3=6=3>6>3=6>F=9?F?9AFA4BF>8?F=8>4=3>6>7=8@F@8"
DATA ">7>9=F?0DFA4BF>8BFA4DF=8?F=9DF=9=F=9=F>9?F@7>F>8=7>B=7=0>F>B=7=8>F>9>F"
DATA "=9@F=B=3=B=3=B=3=BDF?0CF>8AF>0>4>9=3=4=3=4=3>9@F=9=3@4=0=3CF?0CF>8CF?0"
DATA "BF=9=8@F=9DF=8=F=8=F=8BF=8=F=4=0=9>8?3=0>7=1>F=B=3=B=3=B=3=B@F=9>F>9>F"
DATA "=8=7=BDF?4BF>8AF>0>4=9=F=9=F=9>3>9@F=9>3=0>4=0=7=ECF?4BF>8BF?4BF?9=8=9"
DATA "@F=8=F=9=F=9=F=9=F=9=F=9=F=8>F=8?F?8=4>8>F=7AFB8=9@F=6=3=6=3=6=3=6=3=6"
DATA "=3=6CF?0CF>8=0=7>0=D=0=F=0=9>7=8?F=9=8?7>3>0?F=0EF?0CF>8CF?0CF=8=F=8=F"
DATA "=8DF=9@F=8=9AF=6>F>6>8=4=8=9>7=8?F=8=F=6=3=6=3>6=3=6=3=6?F>9=8=9=F=8CF"
DATA "?4CF>8?F=8>4=3=9=6=9>7=9>8=9?8>7=F=B>9?0=EDF?4CF>8CF?4DF>8?F=9DF=9=F=9"
DATA "=F>9=F>8@F=8=4>8=7>B=7=0?F>B=8?F?8=9@F=B=3=B=3=B=3?BAFA0BF>8@F=E=0>4>9"
DATA ">0=3=4=3=4=3=4=9>8=9=3=4=3?4>0=3AFA0BF>8BFA0AF>8?F>9DF=8=F=8=F>8AF=8=F"
DATA "=4=0=9>8=7=0?7=1=F?B=3=B=3=B=3=B@F=9?8?F=8>BEF=4CF>8@F=E=0>4>9=F>9>7?3"
DATA "=9>8=9>3=7>0=4>0=3DF=4CF>8CF=4CF=8=9CF=8=F>9=F=9=F=9=F=9=F=9=F=8>F=9?F"
DATA ">8=4>8=F=3=7=3@F=8=9EF=6=3=6=3?6>3=6=3=6AFA0BF>8?3=0=D>0=9=7=6>7?8>7@3"
DATA "=6=3B0CFA0BF>8BFA0BF=8=F=8=F=8DF>9?F>8AF=6>F>6>8=4=7=F>7=8>F=8=9=6=3=6"
DATA "=3=6=3=6=3=6=3=8BF?9DF=4?F?E>F>8>F=9=8>4=1=7=9=6=9E7=F=B=F?9?0=EDF=4DF"
DATA ">8DF=4DF=9=F=8=9EF=9=F=9=F=9=F?9B8=4=F>8>7?8>F>B=3=8=9FF=B=3=B=3?B=3>B"
DATA "KF>8?F=E>0>4>9=B=F=8=F>3=4=3=4=3=4=3=4=3>F>4>0=3LF>8KF=8=9=8?F>9>F=8AF"
DATA "=8=F=8=F>9=8@F=8=F=4=0=9>8=7=0>7=1>F=B=3?B=3=B=3=BFF=9=8=3>BLF>8?F=E>0"
DATA ">4>9=F>9>0>7B3=7B0=3LF>8KF>9BF=9?F=9=F=9=F=9=F=9=F=9=F=8>F=8=9>F>8=4>8"
DATA "=F=7=4=7@F=9>8=9CF=6=3=6?3=6=3=6?3=6KF>8?7?0=9?7=6A7=3=6>3=6?3B0MF>8LF"
DATA ">9=F=8=F=8AF=8>F>9?F=8=9AF=6=F=6=2=6>8=4=7=F>8?F=8=F=6=3=6=3=6=3=6=3>6"
DATA "DF=9GFA7=E=F>8>F=9=8=4=6=7=1=7=9=6=9=6=9=6=F=B=F=B=F=B=F=7=1>9=F?0=ELF"
DATA ">8LF=9>F=8=F=9=8?9=8?9>F=9=F=9=F>9=F=9@8=4>F>8=7=8?F>8?3>9=F=9?8>9?F=B"
DATA "=3?B=3=7=B=7=B=0JF>8>F=E>0>4>9@B>8EF=8=F=B>4=0=3LF>8KF>9=8@F>8>9AF=8=F"
DATA "=8>9>F=8?F=8>D=0=9>8?7=1>F=B=7=B=7=3?B=3=B?F>9?8=9=F>9?3=BKF>8>F=E>0>4"
DATA "=9=F?9>0=F>0B7=0=F=0=F?0=7LF>8JF?9BF=8>9=F=9=F=9=F=9=F=9=F=9=F=8?F>8=F"
DATA ">8=4>8=F=7=4=7@F=9=8=9CF=8>6=3>6>3=6>3=6=3=6=8JF>8=0=7?0?7=6>7>6>7>6>3"
DATA "=6?3D0=EJF=E>8KF=9=F>9=8=F=8AF>9>8@F=8=9AF=6=F=6=F=6>8=4=7=F=8?F=9>F=6"
DATA "=3=6=3=6=3=6=0=6=8=9CF=9=8BF=E?7=E=F>7=E>F>8>F=9=8=6?3=1=7=9=6=9=6=9=6"
DATA "=F=B=F=B=F=7=1=8=3?9?0>EJF>8JF>8=9>F=8>FB9@F=9=F>9>F=9=F?8=4>F=7B8>F=8"
DATA "=3>B=3=8=9=F@9?F=9=B?3=7=B=7=B=7=B?0HF>8>E>0?4=9>8=B=F=B=F=B=8>3?4>3=8"
DATA ">B=F=B=4>0=3KF>8KF@9=F=9>8>9>8=F=9>F=8=F=9>F=9=F=8?F=8=4=8=0=9>8?1?F=1"
DATA "=7=B=7=B=7?3=B=9?F@9=F=9=8=3>B=3=BKF>8>E>0?4=9=F>9=F=0=F=0>F?0=F>0=F=0"
DATA "=F=0=F?0=EDF>7=B>7>F>8IF>9DF=9=F=9=F=9=F=9=F=9=F=9=F=9=F=8@F=9=8=7=8=4"
DATA ">8=F=7=4=7AF=8CF=8=6>3=6?3=6=3=6>3=6=F?8HF>8?3?0?7=6?7>6=7>3=6?3G0AF?8"
DATA "AF=0>8JF>0?F=9=F=8>F=9=F>8>9>8=9=F=9>F=9@F=6=F=6=F=6>8=4=7=F=8>F=9=8=F"
DATA ">4>6=3>6>7>0=6>9@F>9=3>8AF?E>F>E?F>8>F=9=6AB=1=7=9=6=9=6=F=B=F=B=F=7=1"
DATA ">8=3=8>9=F@0>EHF>8GFA8=9=F=8=9?F?8>9@F=8=F=9=F=9=F=0=8=F=8=4>F=7=4>8>F"
DATA "=8=7=8>F=8=3=B>3=9>F>8?F=8=0=B=7=B>7=B=7?B=0=F=D=0GF>8?0?4=9=8>7>8?B=F"
DATA "=3=4?0=4=3=F>B>8=7>0=3KF>8LF>9=8>F=9=F>9=F>9>F=8=F=9=F=9=F=9=8=0?F=8=4"
DATA "=8=0=9>8=7=1=3>F=1=4>B=7=B>7=B=7=B=0=8?F>8>F=9>3=B>3=BKF>8?0?4@9=F=0>F"
DATA "=0=F=0=F=0=F=0=F=0=F=0=F>0=F>0=EDFA7>F>8HF=9>F=9BF>8>F=9=F=9=F=9=F=9=F"
DATA "=9=F=8CF=7=8=4>8=F=7=4=7AF=8=9?F=9>8=1=6=3=6=3=6=3=6?3>6=F=9=F?8GF>8=0"
DATA "=7@0@7=6B7=6?3E0>3>0=E>F=8?7>8>F=0=7>8IF>7=6=9=F=9=F=9=F=8>F>9=F>9=F=9"
DATA ">F=8?9@F=6=2=6=F=6>8=4=7=F=8=F>8=F@4>8=0@7?0=9?8=0?3=0>8CFA9>F>8>F=6?7"
DATA ">3=8=F=1E7=1=8=F=8=3=8=E?9A0>EFF>8EF>8>4=F=4>8=9>F=9?F=8?9?F=9=F=9=F=9"
DATA "=F=0=E>F=0=4=F=7>4>8=F?8=0>F=0=8@7=9@F=9=8=0=4>B=7=B=7>B=0=F=8=0=F=D=3"
DATA ">0DF=0>8>0?4=9=F=1@7=8=F>B>4=0=F=0>4=B=8=F@7=0=3FF=B@F>8KF=8?F=9>F=9>8"
DATA ">9>F=9=F=9=F=9=F=9?8=0>F=8=4=8=0=9>8=7=1=0=F=1=3=4>0>B=7=B=7>B=F=0=8=9"
DATA "@F=9@B=8=BLF>8>0?4=9=F>9=F=0=F=0=F=0=F>0=F?0=F>0>F>0=F>0=ECF=B=7=F=7=B"
DATA ">F>8>F?9@F?8?9>F=9=F=9=F=9W8=F?8@F=0B8@1E6?8=9>8=F=8>0EF>8?3@0@7=6@7=6"
DATA "?3E0>3=0>8>0=8=7=9=8=9=7>8=0=7=0>8GF>0=7=6=7=6=9=F=9=F=9=F=9>F>9>8=9>F"
DATA "=9?F=8@F>6>F=6>8=4=7=F>8=9=F=0=7@4>8=0C7B3=0>8>DAF=9?F=9=F=9=F>8=F=6AB"
DATA "=8=F>1=F>1=F=8=7C8=3=8>F>9=FB0=E@F?B>F>8CF>8=0=7=8>4=E=4=8A9?F=9@F=9>F"
DATA "?9=0=E=0=E=F=E>0>4?8?F=8=0>F=8=0?8>D@8>0?4@B>0=F=8=F=0=F=3=D=3=F>0AF=0"
DATA "=7>8=0?4=9?3=1=7>6>7>8=3=4?0=4=3=8?7>6=7=0FF?B?F>8HF?0=8=F>9=F=9>F?9>F"
DATA "=9>F?9>8=7=8=7=8=0=F=8>D=0=9>8=7=1=3>1=7=3=4=1>0@B?4>0@8A4=1=9=1KF>8=0"
DATA "?4@9=0>F>0=F=0=F=0>F?0>F=0=F=0=F=0=F?0CFA7=F=7>8=F=9=F=9=F=9>F=8?D>8=9"
DATA "=F=9>F=9>8>6=8=7=F=0>7=F=0>7=F=0>7=F=0>7=F=0>7=F?8?F=8>F=0=8=FN8=F=8=9"
DATA "=F=9=8=F=8=0=4>0CF>8=0=7A0A7@6>7=3D0>3>0>8?0>7=8=7=8=7=8=0=7=0=4>8EF>0"
DATA "=F>0=7=6=7>8?9>F=9>F?9>F=9=F>9=F=9>0>F?6=F=6>8=4=7=F=8>F=0=3=0=7@4>8=0"
DATA "B7A3=0>8@D?F=9>F=9=F?9=F>8=6>3?7=8=F=9?1=9=F>8=7=3=8=F>8=F=8=3=8=E>F?9"
DATA "B0=E>F=B?3=B=F>8AF>8>F?0=8>4=F=4=8=9>F>9BF=9=F>9=F=9=0>F=E>F?0=4@8=F?8"
DATA "=0>F>0AD=0=F?0A4@0>F=8=F=0=F=D=3=D=F?0?F=0>7>8?4=9A3=0B7>3?4>3=7>6>7A0"
DATA "CF=7?B=7>F>8GF?0>7=8>F=9=F=9AF=9=F>9=F=9>8=7=8=7=8=0>3=8=F=4=0=9>8=0=1"
DATA "=3?1=7=3=4=9=1?0J4?1=3>0HF=7>8?4=9=F>9=B=7=0?F=0=F=0=F>0=F=0=F>0>F=0>F"
DATA "=0=F=7=B=0@F=7=F>7=B?7=B>8=F>9=F=9=F=9>8?DD8@6=8>7>3>7>3>7>3>7>3>7>3>7"
DATA ">8=9>8>F=8=0=F=9=8=F?8=F>8=F>8=F>8=F>8=F=8=F=8=F=9=F=8=F=8?0=4>0AF>8?3"
DATA "A0F7B0=4>0=3=0=7=0=8=0?8=0=7=9=8=9=7?0>4>8CF>0=3=7@0=7=6=7>8=9=F>9=F=9"
DATA "AF=9=F=9>F=8A0=6=2=6=F=6>8=4=7=F=8=FA0=7@4>8=0A7@3=0>8@D=8=7=0=8=9?F>9"
DATA ">F=9>8AB=8=F>1=F>1=F@8=3>8>F>8=3=8=0=E=F=E>9=FB0=F=B=3=C=4=C=3=B>8?F>8"
DATA "AF>0=7=8>4=E=4=8=9>F>9=8?9@F=9=F=0BF?0A8?F=8=0>F=8=0>D>3=D=0?F@0=4@0>F"
DATA "=8>F=0=F?D=F>0=4?0=3>7>8=FC1>3>0=7>6>7>F>6>F@7>0=4@0AF?B=4?B=F>8EF?0=F"
DATA ">0>7=8@F=9=8=9=8=9?F=9=F>8=7=8=7=8=0=3>0=8=F=4=0=9>8=7=1=3=9=F=9=1=7=3"
DATA "=4=1=9@1F4?1=9=3>7=3>1EF>7>8>4=9=F>9=7>B=7?0>F=0=F?0=F>0=F>0=F>0=F=7?B"
DATA "=7?F=B=7>F=7=F=7=B=F>8=F=9=F=9=F=9=3>8?D=F>8=3D6>F=7=0>F=7=0>F=7=0>F=7"
DATA "=0>F=7=0>F=7>8=9=F=9=F>0=F=8=9=F=8=FL8=F>8=9>8=F=8>0>4@0?F>8=0=7>0=4@0"
DATA ">7?0?7B0>4=0>3@0@8=7>0>7=0>7=0>4>8BF>0=3=E=3=7=0=F=0>7=6=7>6BF=9=7=0=9"
DATA "?F=9=6=8=7>0=F=0=6=F>2=6>8=4=7=F=0=7=0=7>0=3=0=7@4>8E0>8@D=8=7=0=3>0AF"
DATA "?9>8>7>3=8=F=9?1=9=F=0@8=3=7=F>8=F=8=3=8=E@F?9@0=E=F=B=3=C=4=C=3=B>8=F"
DATA ">8=0>F=E?F=E?0=8>4=F=4=8>9>8?7=8=9>F>9=0=E?F=E?0=E=F=0@8=F>8=B=0>F=0=7"
DATA "=D=3?D?0?FB0>F=0=8>F=0=F=D=3=D=F>0>4=0=7=3>7>8=1=9B3?1=3=0@7>6>F>6>7>0"
DATA ">4B0?F?B?4?B>8DF?0=E=0=F>0?7=8>F=8?0=8?F=9>8=7=8=7=8=0=3=0>4=8=F=4=0=9"
DATA ">8?9=F=9?1=7=3=4>1=FL1=3>4=3=0=1>0BF=3>1>8>9=F>0=3>7>B=F=7=F>0=F=0=F=0"
DATA "=F=0>F?0=F=0=F=7?B?7?F=B>7@9=F>8=F>9=F=9>8=3>8=FA8=3>6?D>6U8>9=F?0=8=F"
DATA "=8=F=9=8=F=8I3=8=F=8=9=F=9=8=F=8=0>4>0>4?0=F>8=0=7>0>4A0=7=9=7=0=7A0@4"
DATA "=0>3=0?7=0@8>7>0@7=0=4>8@F>0=E=3=E=3=E=7?F=0=7>6=7>6=7=6>9>F=9>6=7>9?7"
DATA "=F@0=6>F>6>8=4=7>6=0>8=7@0=7>4=F=4G8=D=F>D=8=7@0=7=8=1AF=9>8@B=8=F=1=F"
DATA ">1=F>4=0?8=7=3=8>F>8=3=8?F=E>F=E=9=F>0=E?F=B?3=B=F?8>3=B=0=E=0=E=F=E=0"
DATA "=E>0=7=8>4=E=4=8=3>8=7=8=7>8?9=0=E=0=E=F=E?0=E=0=E>0?8>F=8=7=0>8=7=0>D"
DATA ">3=D=0=4?0?F?0>F=0=8>F=8=0=F=3=D=3=F>0>4=0>B=7=B>8=FB3=1?9>1?0=7>F>6>F"
DATA "=7=0=3?4@0?3?F?B=4?B=F>8BF@0=F>0=E?0?7>8A4=9@8=7=8=7=8=0=3=0=4=7=3=8>D"
DATA "=0=9>8?F>9>F=9=1=7=3=4=0>1=FG1=F>1=3=4=7=3=0=F=3=4>0@F=3=1=7>8@0=3=7>8"
DATA "=7?B>7=F?0=F?0=F>0=F>7@B=7@0?F=B=9?F=9=F>8=F?9>8=4=8=3?8?D=8=3=6>D=6>D"
DATA "=0D3>8=D@8=3C0>8=9=F=0=4?0=8=F=8=9=F=8=F=8H0=8=F=8=F=9=F=8=F=8=0=4>0>4"
DATA ">0>4=0>8=0=7@0=4?0=7=4=F=4=7@0?4@0>3B0?8>0>F@0>D>8?F=0=4=0=3=E=3=E=0=3"
DATA "=7=F>0>7>6=7>6D7@6=7?F>0=7=6>F>6>8=4=6=0>6=0>8=7>0=3=0=7>4=FB4AD=F>D=8"
DATA "=7=0=3>0=7=8=1=3=9=8@9>8>3>7=8=F>1=9=F@4=0=F>8=3A8=3=8>F=E=0=E?F>9=E=0"
DATA "@F?B=F=B>8=3>B?0=E?F=E>F?0=8>4=F=4=8=3>8>3=8=3=8=3=0>F=E>F?0>F=E>0=F=0"
DATA "@8=3=7=0=7?0=D=3?D=0=8>4?0AF>0=8>F=8=0=F=D=3=D=F>0>4=0>B>7>8B3=1B3=1>4"
DATA "E0=3>4@0>9>F=8?F=7?B=7>3>8AFE0=F=E>0@7=8>4>7>4=8>7=8=7=8=0=3=0=4?7=8=4"
DATA "=8=0=9>8?9=F=9A1=7=3=4?0=1=F=1=F=1=F=1=F=1=F?1=0=3>4=3>0>3=4=3>0>F>1=7"
DATA ">8?0=3=7>8=F?7@B=F>7=F>7=F>7=F=7?B?7?0>F=0>F=9>F>9=F=9>8=F=9=F>8?4=8=3"
DATA ">8?D>8=3=6?4=0=3=F=7=F=7=F=7=F=3=8?D>8=3=4>0@F=0>8=9=0=4A0=8=F=8=F=9=1"
DATA "=F=8G3=8=F>8=9>8=F=8?0>4>0>4=0=1>8=0=7=0A4>0=7=0=F=0=7?0C4=0>3=0A7=0=8"
DATA "=0AF=8=0?D>8=F>0=4=0=E>3=E=0=3=0=7@0>7>6=7E6@7>0=F>0=7=F=6=F=2>6>8=6>F"
DATA "=6=0>3>8=7@0=7>4?F?4>D?F>D=8=7@0=7=8=1=3=9=F=9=3=8>9>8@B=8=F?1=F>3?4=0"
DATA ">8=3=7@8=3=8=E>F=E>F=E>F=E>F=0AF>B=3>8=B>0?4=0CF>0=7=8>4=E=4=8=3?8=3=8"
DATA "=3=0AF=7>0?F>0=F=0=F>8>B=3=7>0>7=0>D>3=D=0=8=0?4?0>F>0=8>F=8=F=0=F?D=F"
DATA ">0>4=0=7>B=7>8A3=1D9=1>4=3=0=F=0=F=0=F=0=3>4@0>3=F?8?F?B=3>F>8?F@0?7?0"
DATA "=E>F=E>0=7>8=7=8@7=8=7>8=7=8=0=3=0=4?7=4=8=4=8=0=9>8?F>9=8=9>F=9=1=7=3"
DATA ">4>0B1=0?1>0=4=3=4=7=3=0=F=3>4>3=4>0=3=1=7>8>0=3=7>8=F>8=7=F>7BB=7=F>7"
DATA "=F>7=F=7=B>0=7>0@F=1=9?F=9=F=9=F>8=F>8=4>8=4>8=3>8=D>4=F=8=3?6=0=3=F=7"
DATA "=F=8=F=8=F=3>8=4>D>8=3>4>0=F=0=F=0>8=0=4>0>4?0=8=F=1=9=F=1=F=8@4>3@4=8"
DATA "=F>1=F>1=F=8>0>4>0>4@1=8=0=7=0=D?0>4=0=7=0=F=0=7>0>4?0?D=0=7=3D0BF=0=7"
DATA "=0>D>8=0>4=0>3=E=3=0=3=0=3=7>0=F=0=7=4=7>6E7>6=7A0=7=F=8=6=F?6>8>F=6=0"
DATA "@3>8=7>0=3=0=7?4CF?D=8=7=0=3>0=7>8=1=3=F=9=3=9=3@8>7>3=8=F=9>1=F>0=3?4"
DATA "=0=F=7=3=8=F>8=3=8=0=E?F=E=0=E?F=E>0@F=B>3>8=0?4@0>F=E?F=E?0=8>4=F=4=8"
DATA "=3=8=3=8=3=0=E?F=E?0=E>F>0=F=0=F=0>8=7>B=7=0=F>0=7AD=0=F=8>0?4@0=D=8>F"
DATA "=8=F=0=F=4=7=4=F>0=4>0=7>B=7>8@3=1C0?3=1=4=3>0=F>0=F=0=3>4?0?9=F?8@3=B"
DATA "@9>8=F>0A3=9=3=7E0>7=8=7=E>0=E=7=8>7=8=0=3=0>4=3=7>4=8=4=8=0=9>8?9=F=9"
DATA "C1=7=3?4F0?4=3>4=3>0=3?4>3=4=0=3>1>8=0=3=7>8=F>8=7=3=4=1=3?7IB=0=7>0?F"
DATA "?8=1?F>9=F=9@8?4>8>3=0=3C8=3=6=0=3=F=7=8A7=3=8=F=8=4>8=3>F>4>0>F=0>8=4"
DATA ">0>4A0=8=F=1=F=9=1=F=8=3=4=3>4=3=4=3=4=8=F=1=F=9=F=1=F=8=0>4>0>4>1>6>8"
DATA "=0=7=0>D@4=0=9?F=9=0A4?D>0>7=3=0@7=0BF=8=7=0=7=0=D>8=4=F=4=0=E>3=0=3=0"
DATA "=3=0=3=7?0=7>4=7F6?7=0=F>0=7=F>8=6=F?6>8>6=0@3>4>8=7@0=7A4>F@D=8=7@0=7"
DATA ">8=1=3=F=9=3=9=3=0=3?8@B=8=F=1=F=1=F>0=7=3>4=0>8=3=8=F>8=3=8=EAF=E?F>0"
DATA "=F=4=0>F>9>B>8=3=4>0?4>0=E=0=E=F=E=0=E>0=7=8>4=E=4=8=3=8=3=F=E=0=E=F=0"
DATA "=7>0=E=0=E=0=3>0=F=0=F>8=7>B=7>0=F=7=0=4?3=4=0>F=8?0>4?D=0=8=F>8=F=0=F"
DATA "=7=4=7=F?0=D=0=7=3>B>8?3>0C3>0>9=1=4=3=0=F=0=F=0=F=3=4@0>3=F?8>3>8=3=9"
DATA "?F=9>8=B>0@B=9=F=9=B>7?0=F=0=E>0>7=8@7=8=7>8>0=3=0A4=F=8>D=0=9>8?F>9=7"
DATA ">1=9>F=9=0=7=3C4?0A4=3>7=3=8=0=F>3>4@3=1=7>8=3=7>8=F>8=7@3=1=7>0?7DB>7"
DATA "=4=7>0>FA8=1>F=9=F=9=F>8=4>8=4>8=3?0>3=8=F?4=8=3=0=7=F>7=F=7?0=3@8=F>8"
DATA "?3=F>4>0=F=0>8>0>4>0=4@0=8=F=1=9=F=1=F=4=3=4>3=4=3>4=8=F>1=9>1=F=8=0=4"
DATA ">0=4>1=7=1>7>8=0=7=0?D>0=4=0=7=0=F=0=7=0=4>0@D@0>7=3@0=F=8@F>8>7=0=7=0"
DATA ">8>4=F=0=3>E>0=3=0=3=0=7>0=F=0=7>4B7>0>7=4=7@0=7=F>8=F=6=8=6=F=6>8=6=0"
DATA "@3>4=F?8=7>0=3=0=7@8>E@8=7=0=3>0=7?8=1=3=9=F=9=3=0=3=8=9>8>3>7=8=F>1=9"
DATA "=F=0=7=0=3?4=0=8=3=7?8=3=8?F=EAF>0=F=4>0=4=0=9=F=B=0>8>3?4>0>4=0=E?F=E"
DATA ">F?0B8=3?F=E=F=7>0?F=E=0=4>3>0=F=0>8>7>B?0=F=0A4=0>F=8A0>D>0>F>8=F=0=F"
DATA "=4=7=4=F?0=D=0=7=3>B>8=3=7=0?3A0?3=0>3=1=3>0=F>0=F=0=3?0?9=F@8=9=F=8=9"
DATA ">F>9=F>8=3>0?3>9=F>9>3=7C0=7=8B7>8=0=7=3=0=4=7=3>4>F=8=F=4=0=9>8?9=F=9"
DATA "=F=7@1=0=F=0=7=3?4=3>8=4>0>4>8=4>3>4=3>0=3=4=3@4>1=7>8=7>8=F>8=7=3=4>3"
DATA "=4=7=0=7?0E7>0=4=7>0>F@8>7=0>F=9=F=9=8?4?8=3?0=3=4=3>8?4=8=3=7=F=7=8=F"
DATA "=7=8?D=3>8=4?8=3=F>7>F>4?0>8=0>4>0=4=0=F@0=8=F=1=F=9=F=1=4@3?4=8=F>1=F"
DATA ">1=F=8?0>1?7=1>6>8=0=7>0?D>4=0=7=0=F=0=7=0=4@D@0=F>0>7=3>0=F=8=7=8>FF8"
DATA ">4=0?3>0=3=0=3=0=3=7=0?F=7?4=7>0@7=0=4=7=0=F>0=7=F>8=F=8?6=F=6>8=0@7>4"
DATA "=F=0=8=3>8=7@0=7=4>8>E>8=4=7@0=7>8=3=1=3=9=F=9=3=0=3=8=9?8@B=8=F?1=F=7"
DATA "?0=3>4=0=F=7=3?8=3=8>F=E=0=E?F>0=F=4>0=4=0=9>F=9=7>8?3?0>4>0BF=9=F>0=7"
DATA "=0=7=0?7=0=7=0=7A0>F=0=3>4>3>0=F>8=B=7>B@0=F>4>3=4=0?F=8=4B0=8=F>8=7=4"
DATA "=0=F?4=F>0>D=0=7=3>7>8=3=0>3?0?4?0>3=0=7=1=4=3=0=F>0=F=0=3?0?3=F?8=4=8"
DATA "=9=F=9>F?9>8=B>0>B=9AF=9=B=8>7>0=F>0=7?8>7?8=0=7=0=3=0=4>7=4>F=0=8=F=4"
DATA "=0=9>8?F=9=7>F=7=8=1=0=C=4=C=0=7=3>4>8=3=8=4>0=8=3>8=4=3=4=7=3>0=F>3>4"
DATA "=3=4=3=1=7@8=F>8=7=3=4>3=4=3=4=3=0=7>4>0B7>0>4=7>0?F>8>7=0=F=1>F=9=F>8"
DATA "=4>8>3>0>3>0=3>8?4>8=3>7=F=7=8@D=3=8?4>8=3=7>F>3=F>4>0>8>4>0=4=0=3=7=8"
DATA "@0=8=F=8?1>4>3?4=0=8=F=1=F=9=F=1=F=8=0=4=1=7=6=7=6=1?7>8=0=7=0=F=0?D=4"
DATA "=0=7=4=F=4=7=0=4?D?0@F>0>7=3=0=8?0>8=0E8=F=4=0?E=0=3?0=3=0=3=7=0=F=0=7"
DATA "?4>7A0=7=4=7?F=7=F>8=F=8=FA6>8@7>4=F=0=8=E>3>8=7>0=3=0=7>4>F>4=7=0=3>0"
DATA "=7>8>3=1=3=F=9=F=3=0=3=9=8=9>8>7>3=8=F=9>1=F@0=3>4=0>8=3?8=3=8=E>F=E>F"
DATA "=E>0=F=4>0=4>0=9=F=9=F=9>8?3?8>0>4>F@9>F=9?0=7=0=7=0=7=0=7?0?8?0=4=7=3"
DATA ">4>3>0>8>7=3=7=0=F?0=4=3?4=0=8?F=8>4@0>F=8=B=4=7=0=F=4=7=4=F>0=D=3=0=7"
DATA "=3>7>8=0=3>0?3?0?3>0=3=0=9=1=3>0=F=0=F=0=3?0>9=F?8?4=8=9=F=8=9?F>8=3>0"
DATA "?3A0>3?8=7>0=F>0=7B8=0=7>0=3=0>7>4=F>0=8=F=4=0=9>8=0=1=3=0=F=7>F=7=0=3"
DATA "=4=F=4=3=0=7=3C4=0B4=3>4=3?0=FA3>1?8=F>8=7=0?3=4?3=4=0=7=F=4=F=0B7=0=4"
DATA "=F=4=F=7>0?F>7=0=9=8=F=1=9>F@8=3?0=3=0>7=0=4=3@8=F=8=3=8=F=7=8@4=3>8?4"
DATA "=8=3>4=7=F?7=F>4=0>8=4>0=4=0>3=7>8?0=8>1=6=7=1=4=3>4=3=4=0=4=8=F>1=9>1"
DATA "=F=8=0=1A7=1?6>8=0=7=0>F>0?D=0=7=9=7>0>D?0?F>0>F>0>7=3=0?7=0>7=0D8=4=F"
DATA "=0?3=0?3>0=3=0=7?0=7?4=7=0=7=0=7>0>7>0=F=0=7>8=F=8=F=8=6=F=8>6>8?7>4=F"
DATA "=0=8>3=E>3>8=7?0=7=8=F>4=F=8=7?0=7>8?3=1=3=9=F=9=3=1=3=8=9?8@B=8=F=1=F"
DATA "=1=F@7=3>4=0=F=8=3=7>8=3=8=0=E?F=E>0=F=4>0=4?0A9>8?3=8=F>8>3=8=3=9DF=8"
DATA "=0=3=0?3=0=3>0>8>F=8>0>4=7=3>4>3=0>8>B=3=7>0=F>0>4>3=4=0>8>F=8=0>4=D=0"
DATA "=8=F>8=F=4>0=F=7=4=7=F=0=D=3=D=0>B=7=B>8=4=0A3?0A3=0=3=0=1=3>0=F=0=F=0"
DATA "=3?0>3=F>8>4=F>4=8=9=F=8=F>9>8=B>0>4=0=4=0=F=0=4>0=8?4=7>0=E=0=7=0@8?7"
DATA "=0=3=0=4>7=4>F=B=0=8=F=D=0=9>8=7=1=3=0>F=7=F=7>3=C=4=C=3=6=0=7=3>4=3>8"
DATA "=4=0>4>8=3=4=3=4=7=4=3@0=F=0=F=3=1=7>8=F>8=7=3=7=0=3>7=4=3=4>3=0=7=F=4"
DATA "=F=0B7=0=4=F=4=7?0=F>7=0=F>9>F=1>F?8=3?0=3=D=0>7=0=4=3=8=F=8=4>8=3>7=8"
DATA "A4=3=8=F=8=4>8=3=0>4=7=F>7>F>4>8>0=4=0=3=0=7>8=7>0>1=6=7=6=7=1MF=1=7=6"
DATA "=7=6=7=6=1?7>8=0=7=0=F=0=F>0?D?0?D>0?FA0>F>0>7=3?0@7=0C8>4=0?E=0A3>0=7"
DATA "@0=7>4D7@0=7@8=F>8=6=F?6>8>7>4=F=0=8=3=E>3=E>3=8=7=0=3=0=7=8=4>F=4=8=7"
DATA "=0=3=0=7=8@3=1=3=F=9=F=3=1=3=9=8=9>8>3>7=8=F>1=9=F@0=3>4=0>8=7=3>8=3=8"
DATA "=E@F>0=F=4>0=4?0=F=9=F=9>F>8?3>8=F=8>3=8=3@FB9A8=0>F=0>8=F>8=F=8=0?4=7"
DATA "=3>4>3>8>B=3=7?0=F=0=4=7?4=0=F>8>F=8>0>D=8=F=8=F=4=0=F=0=F=4=7=4=F=0>D"
DATA "=3=0>B>7>8>4=3>0=3A0=3>0=3=0>3=0=4=3>0=F>0=3@0>9=F>4=F=9=F>4=8=9=F=8>F"
DATA ">8=3>0=F=0>4?0>4=0A8=7?0>7=0=7?0>7=0=3=0>4=3=4=F=B=3BB>8=7=1=0=F=0=F=7"
DATA "=F=7>3=4=F=4=3=6>0=7=3=4>8=3=8=4=0=8=3>8=4=F=3=4=7=4>3=8@0>1=7@8=7=3>7"
DATA "=0@3=4?3=0=7=4=F=4=0B7=0=F=4=F=4=7>0>7=0=9=8>F=9=8=F=1=F>8=3>0>3>D=0>7"
DATA ">0=3>8?4=8=3=7=8B4=3@8=F=8=3=F=0>4=7>F>3=F=4>8=0=4=0>3=7>8=7=0>1>7=6=7"
DATA "=6=7=1L0=1C7=1?6>8=0=7=0=F>0>F>0AD>0?FD0>F>0>7=3=0>7=6?7=0B8>4=0?3?0A3"
DATA "=7>0=F=0=7@8=0=F=0=F=0=7=0=F>0=7>8=F?8=FA6?8>4=F=0=8?3=E>3?4=7?0=7>8>4"
DATA ">8=7?0=7=4@3=1=3=9=F=9=3=1=3=8=9?8@B=8=F?1=F=7?0=3>4=0=F>8=3>8=3=8?F=E"
DATA ">0=F=4>0=4?0=F=1=9=F?9>8?3=8=F>8>3=8=3EF=9>8?3=0>F=0>8=E=F=8=E=8=0>4=7"
DATA "=3>4?3>8=7>B=7@0=F>4=7>4=0=4=F>8>F=8>0=8=F=8=F=4=0=F=8=0=F?4=0?D=3=0=7"
DATA ">B=7>8=9>4@0?3@0>3=0=3=0=4=3=0=F=0=F=0=3=4?0>3>4=F=9=F=9=F>4=8=9=F=8=9"
DATA ">8=B>0=B?4=0=F=0?4=0?4>8=7?0>7=0=7>0>7=0=3=0@4=F=BC3>8=7=1=3=F=0>F=7=F"
DATA "=7=3=C=4=C=3>0>6=7=3A4=0A4=F=0=3>4=7=4B3=1=7?8=7=3=7>0=7=0=3=4@3=4=3=0"
DATA "=7?4=0B7=0@4=7=0=7=0=F>9>F>9>F=1>8>0>3>D=0>7?0=4=3=8?4>8=3B4=3>8>4>8=3"
DATA "=0>F=0>4=7=F?7=F>8=4=0=3=0=7>8=7=0=1?6=7=6=7=6=7=1=F>4=F>4=F>4=F>4=F>4"
DATA "=1=7=6=7=6=7=6=7=1@7>8=0=7=0=F?0?F>0>D=0?FG0>F>0>7=3=0>7?6=7=0A8=F=4=0"
DATA "?E=0>3>0>3=0=3=7?0=7@8=F=0=F=0=F=7?0=7>8=F?8=F=8=6?F=6>8=3=8=F=0=8=0AE"
DATA "@4=7=0=3=0=7>8>4>8=7=0=3=0=7=4@7=1=3=F=9=F=3=1>3=8=9>8>7=3=4=8=F=9>1=F"
DATA "=0=7=0=3?4=0?8=3>8=3=8>F=E>0=F=4>0=4?0=F=9=1=9=F=9>F>8?7>8=F=8>7=8=7@F"
DATA "B9?8=3=8=0>F=0=E?8=E>8=0=4=7=3>4?3=0>8=7>B=7=0=4>0@4=7=0?4=F>8=F=8>0=8"
DATA "=F=8=B=0=F>8=0=F=4=3=4=0=4>3=D=0=7>B=7>8=F=9>4>0=3?4=3>0?3=0>3=0=4=3@0"
DATA "=3=4@0>4=F=9=F=9=F=9=F>4=8=9=F?8=3I0B8=7>0>7>0@7=0=3=0=4=7=3=4=F=B=7AB"
DATA "=7>8=0=1=3>F=0=F=7=F=7=3=4=F=4>0>6>0=7=3=4>8=4=0>4>8=3=F>0>3>4=7=4=7=4"
DATA "=7=3>1>8=7=3=0=3>0=7=0=4?3=4>3=4=0N7=0=9=8>F=9=8>F=9=8=F>8=0>3?4=0>7?0"
DATA "=F=3=8?4>8=3B4=3=8@4=8=3=0?F=0>4=7=F>7=F>8=0>3=7>8=7=0=1?7=6=7=6=7=6>1"
DATA "=4=8>4=8>4=8>4=8>4=8=1D7=1@6>8=0=7=0DF>0OF>0>7=3=0=7>6?7=0=8=0>8=4=F=0"
DATA "?3=0>3=0>3=0=3=0=7?0=7=4?8=0=F=0=F=7@0=7=8=F?8=FC3>8=9=3>8=0=8@3A4=7?0"
DATA "=7B8=7?0=7=4@7=1=3=9=F=9=F=3=1>3?8>B>4=8=F=1=F=1=F>0=7=3>4=0=7>0>8=3=8"
DATA "=3=8=E>F=E=0=F=4=0=4?0=F>1=F=1=9=F>9>8?7=8=F>8>7=8=7EF=9A8=0=E=F=E=0?E"
DATA ">8=0=4=7=3>4?3>0>8>7>B=0>4=0>4>7=4=0>7>4=F>8=F>8=F=8=B=0=F?8=0=F=3=4=0"
DATA "=4=3>4=D=0=7=3>B>8=9=F=9>4=3=4=9=F=9=4=3>0>3>0=3=0=4=3=0=F=0=3?4?0>4=9"
DATA "=F=9=F=9=F=9=F>4=8=9=F>8=B=0=B=0=F=0=F=0=F=0=F=0=F=0?4@8D0>7=0=3=0=4>7"
DATA "=4=F>B=F>9>F=7>8=7=1=3>F=0=F=7=F=7=3=C=4>0>6>0=3=0=7=3=8=3=8=4=0=8=3>8"
DATA "=F>0=F=0>3=7@4=3=1=7>8=3>0=3=0=3=6=7=0>3=4=3=4>3=0=7J8>7=0=7>9>F>9>F>9"
DATA "=F>8>3?4=0>7?0>F=3>8=4?8=3B4=3=8@4=8=3=0=F=0>F=0>4=7>F=7>8=3>7>8=7>1?6"
DATA "=7=6=7=6>1=3=1I0=1A7=0>7=1@7=6>8=0=7]0>7=3=0=6=7=6?7=0=3>8>4=F=0=3=E=3"
DATA ">0>3=0=3=0=3=7=0=F=0=7>4>8=F=0=F=0=7=0=F=0=7>F?8=FD7>8>1=3>8=0@EA4=7=0"
DATA "=3=0=7=8A0=7=0=3=0=7=4@7=8=1=3=9=F=9=F=3=1>3>8=3?4=8=F>1=9=F>0=3?4>0>7"
DATA ">0=3=8=3=8=0=E>F=0=F=4=0=4>0=F=9?1=9=F?9>8?7>8=F=8>7=8=0@FA9=0=8?0=8=0"
DATA "?F=E=0?8=0=4=7=3>4?3>4=0>8=B=7>B=0>4=D=4=7?4=0>4>7=4=9>8=F=8=F=B=0=F?8"
DATA "=F=0=F=3=7=0=4>3>4=0=7=3>B>8=F=9=F=8>4=9=F=0=F=9=4=3?0=4=0=3=0=4=3=F=0"
DATA "=F=3@4=0=3=0>4=9=F=9=F=9=F=9=F>4=8=9>8=3=B=7=BF0B8=0AF>0?7=0=3=0=4>7=4"
DATA "=F=9>F@9=B>8=7=1=0>F=0=F=7=F=7=3=4>0>6=0=7=3=6=2=0=7=3?4=0@4=F>0=F=0=F"
DATA "=0A3=0=1=7>8?0>3>6=7=0=3=4?3=4=3=0=7I8>7=0=3=4=7=F=9=8>F=9=8>F=9>8@4=0"
DATA "?7>0?F=0=3=F>8=F=8=3B0=3>8>4=8=3=0=E=F>0>F=0>4=7=F=7>8=7?8=7=1@7=6=7=6"
DATA ">1>7=1J4=1>7?0?7=1@6=1>8=0=7?0N4HD=0>7=3=0@7=0>3>8A9>3=0>3=0=3=0=3=0=7"
DATA "?F=7>4@F=0=F=7?F=7=3?0=F=8=7=8B9>8>3>1>8@3=0C8=7=8>0?F>0=F=7C8=0=1=3=F"
DATA "=9=F=9=F=3=1=3>8@4=8=F?1=F=0=3?4>0=3>0>7?0=8=E?F=0=F=4=0=4>0=F=1=F>1=F"
DATA "=8?4>8?7=8=F>8A0C9=F>0=3=4=3>0AF@0=7=3>4?3>0>4>8>7=3=7=0>4=D>4>7=4=0=7"
DATA "?4>7=9@8=0=F?8=F=8=0=F=4=0@4=3=4=0=7=3>7>8=9=F=9=8=F>4?0=F=4=3?0=4=0=3"
DATA "G0=3=0>3>4=9=F=9=F=9=F=9=F>4?8=B?7=BDF=0?4>8=0>F=4=0=4>FA0=3=0=4=7=3=4"
DATA "=9>F?9>F=9>8=7=1=3>F=0=F=7=F=7=3>0>6>0=7=0=3=2=6=0=7=3=8=4=0=4>8=3=F>0"
DATA "=F?0=7>F=7=F=3=1=7>8?0=3?6=7=0>3=4=3=4>3=0=7IF=7=0=3=4=3=4=7>9>F>9>F=9"
DATA ">8@0?7>0>F=0=F=0=3>8=4>8=3A7=3>8=F=8=F=8=3=0>F>0=E=F=E=0>4=7=FA8=7=1=6"
DATA "=7>6=7=6=7=1@7=1@0?FB0=1?7>0?7=1@7=6=1>8=0=7?0=4Z7=0>7=3=0=7>0?3>8AF=9"
DATA "=E=3>0=3=0=3=0=3=7=0=F=0=7>8?0?8=7=0=F=0=7@3=0>F=9AF=9>8=F=9>3>1@E=0>8"
DATA "?F>8=7=F=0=F?8=F=0=8=7>8?F>8=0=8=1=3=F=9=F=9=F=3=1>8@4=8=F=9>1=F=3?4=0"
DATA ">7>0=3>0?7=0?F=E=0=F=4=0=4>0=F>1=9=F>8?4>8?7=0>8?0=3@F=E?F=E=F=0A3=0?F"
DATA "=E?F=E=0=3>4?3?4>0>8>B=3=7=0>4=D?4=7=4=0=4>7?4=7=9?8=F?8=F=8>0>4=0=4=7"
DATA ">3=4=D=0>B=7=B>8=F=9=F=8=F=9>4=0=F=9=4=3?0=4=0=3=0?8=0@8=0>3=0=3>0>4@8"
DATA "=9=F=9=F>4>8A7=BBF>0@3=0>F=0?4=0>F=0?3=0=3=0?4=9>FB9>8=0=1=3>F=0=F=7=F"
DATA "=7>0>6>0=4=3=7=0?6=0=7=3=4=0=8=3>8=FA0=7>F=7=F=0=3=1=0>8>0=3=F=7>6=7=0"
DATA "?3=4>3=4=0K7=0=4?3=4=7=F=9=8>F=9=8=F>8B7>0>F>0=F=0=3=8?4=8=3A7=3B8=3=0"
DATA "=F=E?0>F=0?4=7?8>7=0=1=6=7>6=7=6=1A7=1?0=F?1=FA0=1=7A0=7=1@6=7=1=0>8=0"
DATA "=7@0=7[0>7=3=0A3>8=FA9>3=E>0=3=0=3=0=7?0=7=8=0?4=0>8=7?0=7A3>0A9>F>8=9"
DATA "=F=9=F>3=1?3=0A8=F=8=7=0=F>8=4>8=F=0=7=8=FA8=0=7=1=3=9=F=9=F=9=F=3>8@4"
DATA "=8=F=1=F=1=F?4@0>7>0=7?4=7>0=E>0=F=4=0=4>0=F?1=F=8@4>8>7=3A0?3=0=F=E=0"
DATA "=E=F=E>0>3?4>3=0=F=E=0=E=F=E>0>4?3>0?4=3>8>B=3=7=0=4=D>4>7=4=0@4>7=4>8"
DATA "?3?8=F=8=0@4=0=7@4=D=0>B>7>8=9=F=9=8=F>9>4=9=4=3>0>3>0=3=0>8=0=4=0?8=0"
DATA "=3=0>3?0>4?F=8=9=F=9=F=4>8A7=BAF=0=3>0?8=0=FC4=F=0?8=0=3=0?4=9?F>9>F=9"
DATA ">8=7=1=3=F=0>F=7=F=7=0>6>0>8>3=7=0=6=2=3=0=7=3=0@4=F?0>B=7=F=7>F=0=3=1"
DATA "=7>8=0=3=F>9>7=0=3=4@3=4=3=0=7=1F4=1=7=0>3=4=3=4>3=7>9>F>9=F>8A7>0>F?0"
DATA "=F=0=3=8?4=8=3=F=4=F=4=F=3>8=4>8=3>0=FA0>F=0?4>8=7>0=1=7=6?7>1?7=0>7=1"
DATA "=F=0=FA8=F=0=F=0=1>7@0=7=1@7=6=7=1=0>8=0=7?0=7?0=F?0=F?0=F?0=F?0=F?0=F"
DATA "?0=F?0=F=0>7A3=0>8AF=9=3=E>3>0=3=0=3=7?0=7=3A4=3=7=0=F>0=7=0B3=9BF>8=F"
DATA "=9=F=9=F=9=3=1>E=0=8=F=8CF=8?4=8CF=8=F=8=0>E=1=3=9=F=9=F=9=F>8@4=8=F>1"
DATA "=9=F>4>0=4=F?0?7?4?7?0=F=4=0=4>0=F=9>1=F=8@4>8=7=3A0?3=4=0>F=E?F=E=0=4"
DATA "=3?4=3=4=0>F=E?F=E=0=4?3A0=3=7>8=7>B=7=0=4=D=4=7?4=0@B?4=B=3=9=3=9=3=B"
DATA "?0@4=0=4=7=3?4=D=0=7>B=7>8=F=9=F=9=8=F>9>4=3>0?3=0>3=0=8=0?4=0=8=0>3=0"
DATA "?3>0=3>4>9=F=8=9=F=9=F>8=B?7=BD0=3=0?8=0=F=0>4=0>4=0=F=0?8=0=3=0=4B0=F"
DATA ">9=F=9>8=7=1=0=F=0=F=7=F=7=0>6>0=F=3>8=4=3=7=0=3=6=3=0=7=3=4>8=3=F>0>B"
DATA "=0=7=F=7=F=0=F=0=1=7>8=3>F=8=9=7=0=3=4>3=4?3=0=7=1>4>F?9>F>4=1=7=1=0>3"
DATA "=4>3=4=3=7=F=9=8>F=9>8B0>F@0=F=0=3=8?4=8=3=4=F=8=F=4=3=8?4=8=3>0=F?0=E"
DATA "=F=EA0>8>0=1=6=7?6=1>7=0=7=0>7=1@FA8@F=1>7=0=7=0>7=1?6=7=6=1>0>8=0=7>0"
DATA "=3>7=0?F=0?F=0?F=0?F=0?F=0?F=0?F=0?F=0>7>3>0=F>8=FA9=E>3=E=3>0=3=7>0=F"
DATA "=0=7>3?4>3=7=F=0=F=7>3>0A3@9>F=8#24C#0PF=EPF#1F9#0BF=E=0=EOF=0\F=E=F=E"
DATA "OF#185#0UBA0UBA0UBA0HB=0HB=0AFA0MF?0ZF=E?F=ENF#185#0UBA0FB=5?0=5FBA0HB"
DATA "=4HBA0GB?0GB=0@F=EA0=EKFA0XF=E>F=0>F=EMF#185#0ABA4ABA4ABA0EBC0EBA0GB?4"
DATA "GBA0FBA0FB=0@FC0JFC0VF=E>F?0>F=ELF#185#0@BC4?BC4@BA0DBE0DBA0GB?4GBA0EB"
DATA "C0EB=0@F=EA0=EIFE0TF=E>F>0=F>0>F=EKF#185#0?BE4=BE4?BA0CB=5E0=5CBA0FBA4"
DATA "FBA0DBE0DB=0AF=E?0=EIFG0RF=E>F>0=F=0=F>0>F=EJF@0=EG0=E>0=EE0=E>0=EE0=E"
DATA "F0>EF0=EF0=EH0=EF0=E†0=EE0?EF0=EF0?EE0?EG0=ED0AED0?ED0AED0?EE0?E0?EG0"
DATA "@EB0>BQ4>BA0CBG0CBA0EBC4EBA0CBG0CB=0>F=E=0=E=F?0=F=E=0=EEFI0PF=E>F>0=F"
DATA "?0=F>0>F=EIF@0=EG0=E>0=EE0=E>0=ED0?ED0=E>0=E>0=EA0=E=0=EE0=EG0=EH0=EF0"
DATA "=E=0=Ex0=ED0=E?0=EC0?EE0=E?0=EC0=E?0=EE0>ED0=EG0=E?0=EG0=EC0=E?0=EC0=E"
DATA "?0=E0=E?0=ED0>E@0>E@0>BQ4>BA0CBG0CBA0EBC4EBA0BBI0BB=0=FI0CF=EI0=ENF=E"
DATA ">F>0=F>0=F>0=F>0>F=EHF@0=EG0=E>0=ED0BEB0=E=0=E=0=ED0>E>0=EB0=E=0=EE0=E"
DATA "G0=EH0=EG0=Ey0=ED0=E?0=EE0=EI0=EG0=EE0>ED0=EG0=EJ0=ED0=E?0=EC0=E?0=E^0"
DATA "=EP0=EK0=ED0=EB0=E@0=BS4=BA0CB=5E0=5CBA0DBE4DBA0ABK0AB=0=EI0=EBFK0MF=E"
DATA ">F>0=F>0=F=0=F>0=F>0>F=EGF@0=ET0=E>0=EC0=E=0=EI0=ED0=ER0=EH0=EF0=E=0=E"
DATA "G0=Ek0=EE0=E?0=EE0=EI0=EG0=ED0=E=0=ED0@ED0=EJ0=ED0=E?0=EC0=E?0=EC0=EH0"
DATA "=EH0=ER0=EJ0=EC0=E?0?E>0=E?0=BS4=BA0DBE0DBA0CBG4CBA0@BM0@BL0BFK0LF=E>F"
DATA ">0=F>0=F=0=F=0=F>0=F>0>F=EFF@0=ET0=E>0=ED0>EH0=EE0=ER0=EH0=ET0=Ek0=EE0"
DATA "=E?0=EE0=EH0=EF0>EE0=E=0=ED0=E?0=EC0@EF0=EF0?EE0@E\0=EF0AEE0=EH0=ED0=E"
DATA ">0=E>0=E>0=E?0=BS4=BA0?B=5?0=5=BC0=B=5?0=5?BA0BBI4BBA0?B=5M0=5?B=0=EI0"
DATA "=EBFK0KF=E>F>0=F>0=F>0=F>0=F>0=F>0>F=EEF@0=ET0=E>0=EE0>EF0=EE0=E=0=E=0"
DATA "=EO0=EH0=ER0AEO0>ES0=EF0=E?0=EE0=EG0=EI0=EC0=E>0=EH0=EC0=E?0=EE0=EE0=E"
DATA "?0=EG0=E[0=EV0=EF0=EE0=E>0=E>0=E>0=E?0=BS4=BA0>BC0=BA0=BC0>BA0ABK4ABA0"
DATA "?BO0?B=0=FA0=F=0=FA0CFB0=F=0=FB0JF=E>F>0=F>0=F>0=F=0=F>0=F>0=F>0>F=EDF"
DATA "@0=ES0BED0=E=0=ED0=E>0>EB0=E>0=EP0=EH0=ET0=Ej0=EF0=E?0=EE0=EF0=EJ0=EC0"
DATA "AEG0=EC0=E?0=ED0=EF0=E?0=EG0=E\0=EF0AEE0=EG0=EE0=E?0>E=0?E?0>BQ4>BA0=B"
DATA "E0=5?0=5E0=BA0ABK4ABA0>B=5O0=5>B=0>F=E=0=E>F=0>F=E=0=EEF@0=F=E=0=E=F@0"
DATA "KF=E=F=E=0=F>0=F>0AF>0=F>0=F=0=E=F=EDFY0=E>0=EC0=E=0=E=0=EC0=E>0=E>0=E"
DATA "A0=E>0=EP0=EH0=ET0=Ei0=EG0=E?0=EE0=EE0=EG0=E?0=EF0=ED0=E?0=EC0=E?0=ED0"
DATA "=EF0=E?0=EC0=E?0=E]0=ER0=ES0=EG0>BQ4>BA0=5S0=5A0@BM4@BA0>BQ0>B=0BF?0NF"
DATA "?0OF=E=F=E>0=F=0=F>0=FA0=F>0=F=0=F>0=E=F=ECF@0=ET0=E>0=ED0?EH0>EC0>E=0"
DATA "=EO0=EH0=E_0=ER0=EG0=EH0?EF0=EE0AED0?EG0=EE0?EE0?EE0=EG0?EE0?ED0=EH0=E"
DATA "I0=EP0=EI0=EF0>EF0?BO4?B_0ABK4ABA0>BQ0>B=0AFA0LFA0MF=E=F=E>0=F=0=F>0=F"
DATA ">0?F>0=F>0=F=0=F>0=E=F=EBFf0=Ei0=EH0=E^0=E!o0=Ez0AEA0?BO4?B_0ABK4ABA0>B"
DATA "Q0>B=0kF=E>F>0=F>0=F=0=F>0=F?0=F>0=F=0=F>0=F>0>F=EAF•0=EF0=E#120#0@BM4"
DATA "@BL0=5=0=5L0BBI4BBA0>BQ0>B=0XF=0NF=E=F>0=F>0=F>0=F=0=F>0=F>0=F=0=F>0=F"
DATA ">0=F>0=F=EAF#162#0=E^0ABK4ABA0=5E0=5?0=5E0=5A0CBG4CBA0>B=5O0=5>B=0BF?0"
DATA "NF?0LF=E=F=E>0=F=0=F>0>F=0=F=0?F=0=F=0>F>0=F=0=F>0=E=F=E@FC0=ED0@EE0@E"
DATA "C0@ED0AEC0AED0@EC0=E@0=EB0=EJ0=ED0=E?0=EC0=EG0=EA0=EA0=E@0=EC0@EC0AED0"
DATA "@EC0AED0?ED0AEC0=E@0=EB0=EA0=EA0=EE0=E=0=EA0=EA0=EA0=EA0CEA0>EF0=EG0>E"
DATA "G0=E=0=EP0=EH0BBI4BBA0=BE0=B?0=BE0=BA0DBE4DBA0?B=5B0=B=5=0=5=BB0=5?B=0"
DATA "AF=E?0=ELFA0JF=E>F>0=F>0=F=0=F=0=F=0=F>0=F>0=F=0=F=0=F=0=F>0=F>0>F=E?F"
DATA "C0=ED0=E?0=EC0=E@0=EB0=E?0=EC0=EG0=EG0=E@0=EB0=E@0=EB0=EJ0=ED0=E>0=ED0"
DATA "=EG0=EA0=EA0>E?0=EB0=E@0=EB0=E@0=EB0=E@0=EB0=E@0=EB0=E?0=EE0=EE0=E@0=E"
DATA "B0=EA0=EA0=EE0=E=0=EA0=EA0=EA0=EG0=EA0=EG0=EH0=EF0=E?0=EP0=EG0CBG4CBA0"
DATA ">BC0>B?0>BC0>BA0EBC4EBA0AB=5>0=5>B=5=0=5>B=5>0=5AB=0AF=E?0=EKFC0IF=E=F"
DATA ">0=F>0=F>0=F=0=F>0=F?0=F>0=F=0=F>0=F>0=F>0=F=E?FB0=E=0=EC0=E?0=EC0=EG0"
DATA "=E@0=EB0=EG0=EG0=EG0=E@0=EB0=EJ0=ED0=E=0=EE0=EG0>E?0>EA0>E?0=EB0=E@0=E"
DATA "B0=E@0=EB0=E@0=EB0=E@0=EB0=EI0=EE0=E@0=EC0=E?0=EC0=E?0=E?0=E?0=E?0=EC0"
DATA "=E?0=EG0=EB0=EG0=EH0=Ek0DBE4DBA0?B=5?0=5>B=5?0=5>B=5?0=5?BA0EBC4EBA0GB"
DATA "?0GB=0@F>0=F=0=F>0IF=EC0=EGF=E=F=E>0=F=0=F?0=F>0=F>0?F>0=F>0=F?0=F=0=F"
DATA ">0=E=F=E>FB0=E=0=EC0=E?0=EC0=EG0=E@0=EB0=EG0=EG0=EG0=E@0=EB0=EJ0=ED0>E"
DATA "F0=EG0>E?0>EA0=E=0=E>0=EB0=E@0=EB0=E@0=EB0=E@0=EB0=E@0=EB0=EI0=EE0=E@0"
DATA "=EC0=E?0=EC0=E?0=E?0=E@0=E=0=EE0=E=0=EG0=EC0=EH0=EG0=Ek0EBC4EBA0FB=5?0"
DATA "=5FBA0FBA4FBA0GB?0GB=0?FE0HFE0FF=E>F>0=F>0=F=0=F=0=F?0=FA0=F?0=F=0=F=0"
DATA "=F>0=F>0>F=E=FA0=E?0=EB0@ED0=EG0=E@0=EB0@ED0@ED0=E>0?EB0BEB0=EJ0=ED0>E"
DATA "F0=EG0=E=0=E=0=E=0=EA0=E=0=E>0=EB0=E@0=EB0AEC0=E@0=EB0AED0?EF0=EE0=E@0"
DATA "=EC0=E?0=EC0=E?0=E?0=EA0=EG0=EG0=ED0=EH0=EG0=Ek0FBA4FBA0EBC0EBA0GB?4GB"
DATA "A0FBA0FB=0?FE0HFE0FF=E=F=E>0=F=0=F>0=F>0=F?0AF?0=F>0=F>0=F>0=F=0=E=F=E"
DATA "=FA0=E?0=EB0=E?0=EC0=EG0=E@0=EB0=EG0=EG0=E@0=EB0=E@0=EB0=EJ0=ED0=E=0=E"
DATA "E0=EG0=E=0=E=0=E=0=EA0=E>0=E=0=EB0=E@0=EB0=EG0=E@0=EB0=E@0=EF0=EE0=EE0"
DATA "=E@0=ED0=E=0=EE0=E=0=E=0=E=0=EA0=E=0=EF0=EF0=EE0=EI0=EF0=Ek0GB?4GBA0DB"
DATA "E0DBA0GB?4GBA0EBC0EB=0@F>0=F=0=F>0JF>0=F=0=F>0FF=E>F>0=F>0=F=0=F=0=F>0"
DATA "=F?0=F=0=F?0=F>0=F=0=F=0=F>0=F>0>F=EA0AEB0=E?0=EC0=EG0=E@0=EB0=EG0=EG0"
DATA "=E@0=EB0=E@0=EB0=EG0=E>0=ED0=E>0=ED0=EG0=E>0=E>0=EA0=E?0>EB0=E@0=EB0=E"
DATA "G0=E>0=E=0=EB0=E@0=EF0=EE0=EE0=E@0=ED0=E=0=EE0=E=0=E=0=E=0=E@0=E?0=EE0"
DATA "=EE0=EF0=EI0=EF0=Ek0HB=4HBA0CBG0CBA0HB=4HBA0CBG0CB=0CF=0PF=0IF=E=F=E>0"
DATA "=F=0=F>0=F>0=F>0=F?0=F?0=F>0=F>0=F>0=F>0=F=0=E=F=E@0=EA0=EA0=E?0=EC0=E"
DATA "@0=EB0=E?0=EC0=EG0=EG0=E?0>EB0=E@0=EB0=EG0=E>0=ED0=E?0=EC0=EG0=E>0=E>0"
DATA "=EA0=E?0>EB0=E@0=EB0=EG0=E?0>EB0=E@0=EB0=E?0=EE0=EE0=E@0=EE0=EG0=E?0=E"
DATA "@0=EA0=ED0=ED0=EG0=EJ0=EE0=EY0o10BF?0NF?0HF=E=F=E=0=F>0=F=0=F@0=F>0=F"
DATA "=0=F=0=F=0=F>0=F@0=F=0=F>0=F=0=E=F=E@0=EA0=EA0@EE0@EC0@ED0AEC0=EH0?E=0"
DATA "=EB0=E@0=EB0=EH0>EE0=E@0=EB0AEC0=EA0=EA0=E@0=EC0@EC0=EH0@EC0=E@0=EC0?E"
DATA "F0=EF0@EF0=EG0=E?0=E@0=EA0=ED0=ED0CEA0=EJ0=EE0=EY0>1@3B1=3=1=3>1=3E1=3"
DATA "M1@3>10fF=E=F>0=F=0=F>0=F=0>F>0=F>0=F?0=F>0=F>0>F=0=F>0=F=0=F>0=F=E!…0"
DATA "=E®0=ET0=EY0=1A3B1=3=1=3>1=3E1=3M1A3=10DF=4]F=E=F>0=F=0=F=0=F>0=F>0=F"
DATA ">0=F=0=F=0=F=0=F>0=F>0=F>0=F=0=F=0=F>0=F=E#13C#0>ER0>ER0BE=0=1A3B1=3@1"
DATA "=3W1A3=10CF?4\F=E=F>0=F=0=F>0=F?0=F>0=F?0=F?0=F>0=F?0=F>0=F=0=F>0=F=E"
DATA "#13E#0=EQ0=EZ0=1A3B1=3@1=3W1A3=10BF=D?4=DHF=C?4=D?F=D?4=CBF=E=F>0=F>0"
DATA "=F=0=F=0>F>0=F?0=F=0=F?0=F>0@F=0=F>0=F>0=F=EL0=EW0=EP0=ER0=EG0=EG0=EG0"
DATA "=EG0=E!p0=EF0=EH0=EY0=1=3B1>3>1=3=1=3=1A3=1?3>1=3=1?3?1>3H1=3=1>0‹E>0AF"
DATA "=DA4=DFF=CA4=D=F=DA4=CAF=E=F>0=E=F=0=F>0=F?0=F?0=F?0=F?0=F?0=F>0=F=0=F"
DATA "=E>0=F=EL0=EW0=EO0=ES0=E_0=EG0=E›0=E0=EF0=EH0=EG0>E>0=EI0=1=3A1@3=1=3"
DATA "=1=3=1A3=1@3=1=3=1@3=1@3G1=3=1>0‹E>0@F=CC4=CEF=DB4=CB4=DAF=E=F=E>0=F>0"
DATA "=F?0>F?0=F>0=F>0=F?0>F?0=F>0=F>0=E=F=EL0=EW0=EO0=ES0=E_0=EG0=E›0=E0=E"
DATA "F0=EH0=EF0=E>0>EJ0=1@3>1@3=1=3=1=3=1A3=1@3=1=3=1@3=1@3D1@3=1>0=E@2BE>2"
DATA "@E@2@E@2BE>2?EB2?E@2?EB2?E@2@E@2>E>0?F=C=DC4=D=CDFK4AF=E>F>0=E=F>0?F@0"
DATA "=F>0?F>0=F@0?F>0=F=E>0>F=EA0?ED0@EE0?EE0@ED0?ED0>EG0@EC0=E=0>ED0=EG0=E"
DATA "G0=E>0=ED0=EG0?E=0>EB0=E=0>EE0?ED0@EE0@EC0>EG0>EE0>EF0=E?0=EC0=E?0=EC0"
DATA "=E>0=E>0=EA0=E>0=EE0=E>0=EC0@EE0=EF0=EH0=EY0=1A3=1@3=1=3=1=3=1A3=1@3=1"
DATA "=3=1@3=1@3D1@3=1>0>2>E>2?E@2?E>2>E>2>E>2>E>2@E?2?E>2BE>2>E>2BE>2>E>2>E"
DATA ">2>E>2>E>2=E>0?F=DE4=DDFK4BF=E=F=E>0=FD0=FE0=FD0=F>0=E=F=E=FD0=EC0=E?0"
DATA "=EC0=E?0=EC0=E?0=EC0=E?0=EC0=EG0=E?0=EC0>E>0=EC0=EG0=EG0=E=0=EE0=EG0=E"
DATA ">0=E>0=EA0>E>0=EC0=E?0=EC0=E?0=EC0=E?0=EC0=EG0=E>0=ED0=EG0=E?0=EC0=E?0"
DATA "=EC0=E>0=E>0=EA0=E>0=EE0=E>0=EF0=ED0=EG0=EI0=EX0>1@3=1=3>1=3=1=3=1=3>1"
DATA "=3C1=3=1=3=1=3@1=3>1=3=1A3>1@3=1>0>2>E>2AE>2CE>2BE>2@E?2?E>2BE>2EE>2?E"
DATA ">2>E>2>E>2>E>2=E>0>F=DG4=DCF=DI4=DBF=E>F?0>F@0>F?0=E=0=F=0=E?0>F@0>F?0"
DATA ">F=E=FA0@EC0=E?0=EC0=EG0=E?0=EC0AEC0=EG0=E?0=EC0=E?0=EC0=EG0=EG0>EF0=E"
DATA "G0=E>0=E>0=EA0=E?0=EC0=E?0=EC0=E?0=EC0=E?0=EC0=EH0=EF0=EG0=E?0=ED0=E=0"
DATA "=ED0=E=0=E=0=E=0=EB0>EF0=E>0=EE0=EF0=EF0=EH0=EY0A1=7=1=7>1=7=1=7=1=7>1"
DATA "=7A1?7=1=7=1=7@1@7=1A7A1=7=1>0>2>E>2AE>2CE>2BE>2?E@2?EA2?E>2EE>2?E>2>E"
DATA ">2>E>2>E>2=E>0?F=DE4=DDF=CI4=CCF=E>F@0@FA0=F=0=F=0=FA0@F@0>F=E>F@0=E?0"
DATA "=EC0=E?0=EC0=EG0=E?0=EC0=EG0=EG0=E?0=EC0=E?0=EC0=EG0=EG0=E=0=EE0=EG0=E"
DATA ">0=E>0=EA0=E?0=EC0=E?0=EC0=E?0=EC0=E?0=EC0=EI0=EE0=EG0=E?0=ED0=E=0=ED0"
DATA "=E=0=E=0=E=0=EB0>EF0=E>0=ED0=EG0=EF0=EH0=EY0A1=7=1=7>1=7=1=7=1=7>1=7@1"
DATA "=7>1=7=1=7=1=7@1=7J1=7=1>0>2>E>2AE>2BE>2AE?2@E@2?E>2>E>2>EA2AE>2AE@2@E"
DATA "A2=E>0?F=C=DC4=DFF=DG4=DEF=E>F=EE0?F?0?FE0=E>F=E?F@0=E?0=EC0=E?0=EC0=E"
DATA "?0=EC0=E?0=EC0=E?0=EC0=EG0=E?0=EC0=E?0=EC0=EG0=EG0=E>0=ED0=EG0=E>0=E>0"
DATA "=EA0=E?0=EC0=E?0=EC0=E?0=EC0=E?0=EC0=EG0=E>0=ED0=EG0=E>0>EE0=EF0=E?0=E"
DATA "B0=E>0=EF0>ED0=EH0=EF0=EH0=EY0=1A7=1@7=1=7=1=7>1@7=1@7=1=7=1=7@1@7C1A7"
DATA "=1>0>2>E>2AE>2AE>2DE>2>E>2=E>2CE>2>E>2>E>2@E>2@E>2>E>2BE>2=E>0@F=CC4=C"
DATA "GFG4GF=E?F=EA0=E>F=E=F=0=F=0=F=E>F=EA0=E?F=E@FA0@EC0@EE0?EE0@ED0?ED0=E"
DATA "H0@EC0=E?0=EC0=EG0=EG0=E?0=EC0=EG0=E>0=E>0=EA0=E?0=ED0?ED0@EE0@EC0=EH0"
DATA ">EF0=EG0>E=0=EE0=EF0=E?0=EB0=E>0=EF0=EE0@EE0=EF0=EH0=EY0=1A7=1@7=1=7=1"
DATA "=7>1@7=1@7=1=7=1=7@1@7C1A7=1>0>2>E>2AE>2@E>2EE>2>EB2BE>2>E>2>E>2?E>2AE"
DATA ">2>E>2BE>2=E>0AF=DA4=DIFE4IF>EEF>E=F?0=F>EEF>EAFŒ0=E[0=Eƒ0=EK0=E™0=ES0"
DATA "=EE0=EG0=EZ0=1A7=1@7=1=7=1=7>1@7=1@7=1=7=1=7@1@7C1A7=1>0>2>E>2AE>2?E>2"
DATA "BE>2>E>2AE>2?E>2>E>2>E>2>E>2?E>2AE>2>E>2>E>2>E>2=E>0BF=D?4=DKFC4LFFE>F"
DATA "=0=F=0>FFECFˆ0@E\0=Eƒ0=EK0=E—0>E‰0=1@7?1>7>1=7=1=7?1?7>1?7=1=7=1=7A1?7"
DATA "C1@7>1>0=E@2BE>2?EB2?E@2BE>2@E@2@E@2@E>2BE@2@E@2>E>0CF?4MFA4UF=E>F=0=F"
DATA "=0=F=0>F=EKF#120#0PE!0DF=4OF?4UF=E>FC0>F=EJF#120#0@E>2CE>4AE=0@F=C=4GF"
DATA "=C?4FF=C?4JF=4FFA4FF=C?4DFB4DFA4FF?4CF?4?F?4GF@4DF?4DF@4=F@4=F=0JF>0YF"
DATA "=4TF>E>F=0=F=0=F=0=F=0=F=0>F>EHFC0>FW1>FO1>FP1AFZ1AFI1>FX1>F@1>FW1AFK1"
DATA ">FI1@FE1>F=1>FH1>FM1@F>1=0?E@2AE@4@E=0@F>4GFA4EFA4HF>4EFA4FF?4EFB4=CCF"
DATA ">4?F>4DF>4=F>4CF>4>F>4=F>4GF>4CF>4=C=F=C>4CF>4?F=4=C>F=0JF>0pF>E>F=EG0"
DATA "=E>F>EFFC0>FD1>FM1>FK1>FS1>F?1>FX1>F?1>FD1>F\1>F@1>FO1>FB1>F>1>FX1>F>1"
DATA ">FD1>F@1>FW1>F>1>F=1=0>EB2?EB4?E=0@F?4EF>4=F=C>4DF=4>F=C>4GF?4EF=4IF>4"
DATA "=CFF=4@F=4DF>4?F>4CF>4?F>4BF>4=F>4?F>4FF>4CF>4?F>4CF>4>F=4=C?F=0JF>0DF"
DATA "=4eF>E>F=E>0=F=0=F=0=F=0=F=0=F=0=F>0=E>F>EDFC0>FD1>FM1>FK1>FS1>F]1>F?1"
DATA ">FD1>F[1@F?1>FO1>FB1>F>1>FX1>FH1>F@1>F[1>F=1=0>E@2AE@4AE=0?F=4=F>4IF>4"
DATA "HF>4FF=C?4DF=C?4=CEF=C>4LF=4DF?4=F=C>4CF>4?F>4BF>4=F>4?F>4FF>4BF>4AF>4"
DATA "BF>4=F=4=C@F=0EF=9>0>F>0CF?4LF>4=D=F=D>4LF=E>F=EO0=E>F=ECFC0>F=1AF>1?F"
DATA "=1?F>1@F?1AF=1>F>1>F>1@F>1?F=1>F>1@F>1AFB1>FC1@F>1CF?1@FB1>F?1>F=1AF>1"
DATA "?F=1>F>1@F>1AF?1?FD1@F?1AF?1@F>1>F>1>F=1?FA1>F>1>F>1@F?1?F>1>F>1@FB1>F"
DATA "B1@F>1>F=1>F=1?F>1@F>1>F=1?F>1@FF1>F=1=0>E@2AE@4AE=0?F=4=F=C>4HF>4GF>4"
DATA "GF=4=F>4DFB4DFA4=CHF=4=CEFA4DF>4?F>4BF>4=F>4?F>4FF>4BF>4AF>4BF?4=CAF=0"
DATA "=F>0=E@F=E=0@F>0BF=D?4=DJF=D?4=C?4=DKF=E=FS0=F=ECFC0>F=1?F=1>F=1>F>1>F"
DATA ">1>F>1>F=1>F>1>F=1>F>1>F=1>F>1>F=1>F>1>F=1>F>1>F=1?F=1>FA1>F=1@FA1>F=1"
DATA ">F=1>F=1>F=1>F>1>FA1>F?1>F=1>F>1>F=1>F>1>F=1>F>1>F=1?F=1>F=1>F=1>FB1>F"
DATA ">1>F>1>F>1>F=1>F>1>F=1>F>1>F=1>FB1AFB1>F=1>F=1>F=1>F=1>F>1>FB1@F>1>F>1"
DATA ">F=1>F=1>F=1>FB1>F=1>F=1>F>1>F>1>FC1?F>1=0?E@2AE@4@E=0>F=C=4>F>4GF=C=4"
DATA "=CFF@4EF=4>F>4HF?4CF>4>F=C=4=CGF=4GF@4DF=C=4=C>F>4BF>4=F>4?F>4FF>4BF>4"
DATA "AF>4BF?4BF=0=F=E>0?F=E=0AF>0AF=DA4=DIFE4KF=EUF=ECFC0>F=1>F>1>F=1>F>1>F"
DATA ">1>F>1>F=1>F>1>F=1>F>1>F=1>FA1>F>1>F=1>F>1>F=1>F>1>FA1>F?1>F>1AF=1>F=1"
DATA ">F=1>F=1BFA1>F?1>F=1>F>1>F=1>F>1>F=1>F>1>F=1>F>1>F>1>FD1>F>1>F>1>F>1>F"
DATA "=1>F>1>F=1>F>1>F=1>FB1>F>1>F>1AF>1>F?1>F=1>FI1>F=1>F>1>F=1>F=1>F=1>F?1"
DATA "AF=1>F=1>F>1BFE1>F=1=0@E@2AE@4?E=0>F=4?F=C>4FF>4IF?4CF=4?F>4IF=C=4CF>4"
DATA "?F>4GF=4FF=4=C=F?4DF=CA4BF>4=F>4?F>4FF>4BF>4AF>4BF@4AF=0>F>0=E=F=E=0BF"
DATA ">0@F=DC4=DHFE4KFWECFC0>F=1>F>1>F=1>F>1>F>1>F>1>F=1>F>1>F=1>F>1>F=1>FA1"
DATA ">F>1>F=1>F>1>F=1>F>1>FA1>F?1>F=1>F>1>F=1>F=1>F=1>F=1>FE1>F?1>F=1>F>1>F"
DATA "=1>F>1>F=1>F>1>F=1>F>1>F?1>FC1BF>1>F>1>F=1>F>1>F=1>F>1>F=1>FB1>F>1>F=1"
DATA ">F>1>F?1>F>1>F=1>FI1>F=1>F>1>F=1>F=1>F=1>F>1>F>1>F=1>F=1>F>1>FI1>F=1=0"
DATA "@E@2AE@4?E=0>FC4EF=C=4KF>4CFC4IF=4CF>4?F>4FF=4=CEF>4?F>4GF>4=CBF>4=F>4"
DATA "?F>4AF>4?F>4BF>4AF>4BF>4=C>4@F=0>F=E>0=E=0CF>0AF=DA4=DIF=DC4=DDFl0>F=1"
DATA ">F>1>F=1>F>1>F>1>F>1>F=1>F>1>F=1>F=1?F=1>F>1>F=1>F>1>F=1>F>1>F=1>F>1>F"
DATA "A1>F>1?F=1>F>1>F=1>F=1>F=1>F=1>F>1>FA1>F?1>F=1>F>1>F=1>F>1>F=1>F>1>F=1"
DATA ">F>1>F=1>F=1>FA1>F@1>F=1>F>1>F=1>F>1>F=1>F=1?F=1>FB1>F>1>F=1>F>1>F=1>F"
DATA "=1>F=1>F=1>F>1>FA1>F>1>F=1>F>1>F=1>F=1>F=1>F>1>F>1>F=1>F=1>F>1>F>1>FA1"
DATA ">F>1>F=1=0>EB2?EB4?E=0=F=C=4@F?4DF=4?F=4HF>4CFC4IF=4CF>4?F>4FF=4FF>4?F"
DATA ">4FF=C>4CF>4=F>4?F>4AF>4?F>4CF>4?F>4CF>4=F=C>4?F=0?F?0DF>0BF=D?4=DKFC4"
DATA "EFl0>F=1>F>1>F>1>F=1>F?1@F?1AF>1AF>1@F?1>F=1>F>1@F>1>F>1>FB1BF>1AF=1>F"
DATA "=1>F=1>F>1@FC1AF>1AF?1>F=1>F>1@F>1>F>1>F>1?FB1>F@1>F=1AF?1@F?1AF>1>FA1"
DATA "AF?1AF>1?F>1>F>1@FC1@F?1@F>1>F=1>F>1>F>1AF=1>F=1>F?1@FC1@F>1=0?E@2AE@4"
DATA "@E=0=F=4BF>4BF=CA4=CCF>4>F=C=4HF>4DF>4=C>F=4EF>4=F>4GF=4FF>4?F>4EF?4DF"
DATA ">4>F>4=F>4BF>4=C=F=C>4CF>4=C=F=C>4CF>4>F=C>4>F=0?F=9=0EF>0CF?4MFA4FFl0"
DATA "®1>F!`1=0@E>2CE>4AE=0@4?F@4AFB4DFA4IF>4DFA4GF?4GF=4=CGFA4DF?4=CDF@4>F?4"
DATA "DFA4FF?4>F=4AF@4=F@4=F=0JF>0DF=4OF?4GFl0®1>F!`1=0PE=0!\F?4LF=0JF>0YF=4"
DATA "HF"

SUB DoHELP
LINE (63, 20)-(174, 35), 14, BF
PrintSTRING 70, 22, "Game"
PrintSTRING 110, 22, "Help"
PrintSTRING 140, 22, "Score:"
GET (70, 23)-(95, 33), Box()
GET (110, 23)-(129, 33), Box(100)
FOR x = 70 TO 129
    FOR y = 23 TO 33
        IF POINT(x, y) = 0 THEN PSET (x, y), 8
    NEXT y
NEXT x
GET (70, 23)-(95, 33), Box(200)
GET (110, 23)-(129, 33), Box(300)
GET (140, 23)-(167, 33), Box(400)
SaveFILE "Sol3Men1", 1000
LINE (63, 20)-(174, 35), 0, BF
LINE (310, 37)-(410, 110), 14, BF
LINE (310, 37)-(410, 110), 5, B
LINE (310, 37)-(410, 37), 15, BF
LINE (310, 37)-(310, 110), 15, BF
LINE (313, 89)-(407, 89), 5
LINE (313, 90)-(407, 90), 15
PrintSTRING 322, 44, "Introduction"
PrintSTRING 322, 59, "Basic Solitaire"
PrintSTRING 322, 74, "Game Options"
PrintSTRING 322, 94, "About Solitaire 3"
GET (310, 37)-(410, 110), Box()
SaveFILE "Sol3Men3", 4000
LINE (311, 38)-(409, 88), 14, BF
LINE (311, 91)-(409, 109), 14, BF
PrintSTRING 326, 44, "Deal"
PrintSTRING 326, 59, "Undo"
PrintSTRING 326, 74, "Game Options"
PrintSTRING 326, 94, "Exit"
GET (310, 37)-(410, 110), Box()
SaveFILE "Sol3Men2", 4000
LINE (310, 37)-(410, 110), 0, BF

LINE (180, 165)-(432, 288), 14, BF
LINE (186, 169)-(425, 186), 1, BF
LINE (180, 165)-(432, 288), 15, B
LINE (180, 288)-(432, 288), 5
LINE (432, 165)-(432, 288), 5
LINE (186, 190)-(427, 282), 15, B
LINE (186, 190)-(425, 280), 5, B
LINE (187, 191)-(425, 280), 15, BF
DEF SEG = VARSEG(Box(0))
BLOAD "sol3btns.bsv", VARPTR(Box(0))
DEF SEG
PUT (375, 171), Box(200), PSET
DEF SEG = VARSEG(Box(0))
BLOAD "sol3hdgs.bsv", VARPTR(Box(0))
DEF SEG
PUT (194, 173), Box(0), PSET
RESTORE HelpDATA
FOR Reps = 1 TO 15
    LINE (187, 191)-(425, 280), 15, BF
    FOR y = 200 TO 260 STEP 12
        READ a$: PrintSTRING 200, y, a$
    NEXT y
    FOR xx = 200 TO 420
        FOR yy = 200 TO 280
            IF POINT(xx, yy) = 1 THEN PSET (xx, yy), 8
        NEXT yy
    NEXT xx
    DEF SEG = VARSEG(Box(0))
    BLOAD "sol3hdgs.bsv", VARPTR(Box(0))
    DEF SEG
    SELECT CASE Reps
        CASE 6
            LINE (186, 169)-(340, 186), 1, BF
            PUT (194, 173), Box(800), PSET
            PUT (228, 173), Box(1000), PSET
        CASE 12
            LINE (186, 169)-(340, 186), 1, BF
            PUT (192, 173), Box(200), PSET
            PUT (227, 173), Box(400), PSET
    END SELECT
    GET (180, 165)-(432, 288), Box()
    SaveFILE "Sol3HP" + LTRIM$(RTRIM$(STR$(Reps))), 16000
NEXT Reps
DEF SEG = VARSEG(Box(0))
BLOAD "sol3hdgs.bsv", VARPTR(Box(0))
DEF SEG
LINE (187, 191)-(425, 280), 14, BF
LINE (186, 169)-(406, 186), 1, BF
PUT (192, 173), Box(600), PSET
PUT (230, 173), Box(1000), PSET
PUT (280, 173), Box(1200), PSET
LINE (276, 178)-(279, 178), 15
FOR x = 230 TO 290
    FOR y = 173 TO 186
        IF POINT(x, y) = 15 THEN PSET (x - 20, y + 32), 0
    NEXT y
NEXT x
PrintSTRING 324, 204, "Version 2 - 2007"
PrintSTRING 210, 220, "Program type:"
PrintSTRING 324, 220, "Game (Freeware)"
PrintSTRING 210, 236, "Program & Graphics:"
PrintSTRING 324, 236, "Bob Seguin"
PrintSTRING 210, 252, "Language:"
PrintSTRING 324, 252, "QBasic 1.1"
GET (180, 165)-(432, 288), Box()
SaveFILE "Sol3HP16", 16000
DEF SEG = VARSEG(Box(0))
BLOAD "sol3hdgs.bsv", VARPTR(Box(0))
DEF SEG
LINE (186, 169)-(406, 186), 1, BF
PUT (192, 173), Box(200), PSET
PUT (227, 173), Box(400), PSET
LINE (187, 191)-(425, 280), 14, BF
FOR y = 220 TO 256 STEP 18
    LINE (229, y)-(245, y + 10), 15, BF
    LINE (229, y)-(229, y + 10), 5
    LINE (229, y)-(245, y), 5
    LINE (230, y + 1)-(244, y + 1), 14
    LINE (230, y + 1)-(230, y + 9), 14
NEXT y
PrintSTRING 213, 201, "Click corresponding box to toggle option."
PrintSTRING 255, 220, "Vegas Style Scoring"
PrintSTRING 255, 238, "No Scoring (continuous play)"
PrintSTRING 255, 256, "Money Card"
GET (180, 165)-(432, 288), Box()
SaveFILE "Sol3HP17", 16000
LINE (180, 165)-(432, 288), 0, BF
END SUB

SUB PrintSTRING (x, y, Prnt$)
DEF SEG = VARSEG(Box(0))
BLOAD "sol3mssr.fnt", VARPTR(Box(0))
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

SUB SaveFILE (FileNAME$, ByteCOUNT&)
FileNAME$ = LCASE$(FileNAME$ + ".BSV")
DEF SEG = VARSEG(Box(0))
BSAVE FileNAME$, VARPTR(Box(0)), ByteCOUNT&
DEF SEG
END SUB
