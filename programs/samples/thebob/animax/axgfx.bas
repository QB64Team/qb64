CHDIR ".\programs\samples\thebob\animax"

DEFINT A-Z
DECLARE SUB PrintSTRING (x, y, Prnt$, Font)
DECLARE SUB Interval (Length!)
DECLARE SUB DrawBOX (x, y, xx, yy, FlipFLOP)

DIM Box(10000)
DIM SHARED FontBOX(26000)
DIM TitleBOX(1000)
DIM ExBOX(1000)
DIM ToolBOX(1000)
DIM BBox(400)
DIM CBox(1 TO 672)
TYPE RecentTYPE
PName AS STRING * 8
FName AS STRING * 130
END TYPE
DIM Recent(1 TO 6) AS RecentTYPE

RESTORE HueDATA
Index = 1
FOR DStrings = 1 TO 10
READ h$
FOR n = 1 TO LEN(h$)
CBox(Index) = ASC(MID$(h$, n, 1)) - 35
Index = Index + 1
NEXT n
NEXT DStrings
DEF SEG = VARSEG(CBox(1))
BSAVE "anihues.bsv", VARPTR(CBox(1)), 1344
DEF SEG
OPEN "recent.axd" FOR RANDOM AS #1 LEN = LEN(Recent(1))
FOR n = 1 TO 6
Recent(n).PName = SPACE$(8)
Recent(n).FName = SPACE$(130)
PUT #1, n, Recent(n)
NEXT n
CLOSE #1

SCREEN 12
GOSUB Setpalette
'Create images from DATA
MaxWIDTH = 211
MaxDEPTH = 479
x = 0: y = 0
RESTORE PixDATA
DO
READ DataSTRING$
FOR n = 1 TO LEN(DataSTRING$)
Char$ = MID$(DataSTRING$, n, 1)
IF Char$ = CHR$(225) THEN Char$ = CHR$(160)
SELECT CASE Char$
CASE "!"
n = n + 1
a$ = MID$(DataSTRING$, n, 1)
Count = ASC(a$) + 68
CASE "#"
n = n + 1
B$ = MID$(DataSTRING$, n)
FOR I = 1 TO LEN(B$)
t$ = MID$(B$, I, 1)
IF t$ = "#" THEN EXIT FOR
c$ = c$ + t$
NEXT I
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
GET (16, 10)-(37, 35), ExBOX
GET (173, 0)-(182, 68), FontBOX
FOR x = 295 TO 335 STEP 10
PUT (x, 0), FontBOX, PSET
NEXT x
GET (300, 0)-(337, 67), FontBOX: PUT (300, 0), FontBOX
LINE (295, 0)-(300, 68), 0, BF
FOR y = 0 TO 400 STEP 68
PUT (300, y), FontBOX, PSET
NEXT y
GET (65, 0)-(116, 203), FontBOX: PUT (65, 0), FontBOX
PUT (337, 0), FontBOX, PSET
GET (117, 0)-(168, 203), FontBOX: PUT (117, 0), FontBOX
PUT (337, 204), FontBOX, PSET
GET (169, 0)-(211, 407), FontBOX: PUT (169, 0), FontBOX
PUT (391, 0), FontBOX, PSET
GET (156, 410)-(201, 477), FontBOX: PUT (156, 410), FontBOX
FOR y = 0 TO 400 STEP 68
PUT (434, y), FontBOX, PSET
NEXT y
GET (300, 0)-(300, 407), FontBOX: PUT (390, 0), FontBOX, PSET
GET (479, 0)-(479, 407), FontBOX: PUT (389, 0), FontBOX, PSET
GET (149, 304)-(152, 439), FontBOX: PUT (149, 304), FontBOX
PUT (431, 0), FontBOX, PSET
GET (156, 304)-(162, 407), FontBOX: PUT (156, 304), FontBOX
PUT (330, 304), FontBOX, PSET
FileNAME$ = "Book" + SPACE$(4)
FOR n = 1 TO 8
FontBOX(n) = ASC(MID$(FileNAME$, n, 1))
NEXT n
RESTORE Setpalette
FOR n = 9 TO 56
READ FontBOX(n)
NEXT n
FontBOX(57) = 12
Index = 58
x = 300: y = 0
FOR Index = 58 TO 18043 STEP 1635
GET (x, y)-(x + 89, y + 67), FontBOX(Index)
PUT (x, y), FontBOX(Index)
y = y + 68
IF y > 400 THEN x = x + 90: y = 0
NEXT Index
DEF SEG = VARSEG(FontBOX(0))
BSAVE "book.axb", VARPTR(FontBOX(1)), 19678 * 2&
DEF SEG
GET (0, 159)-(30, 174), TitleBOX
Index = 0
FOR y = 0 TO 160 STEP 20
GET (45, y)-(63, y + 14), ToolBOX(Index)
Index = Index + 100
NEXT y
DEF SEG = VARSEG(ToolBOX(0))
BSAVE "anitools.bsv", VARPTR(ToolBOX(0)), 1800
DEF SEG
Index = 0
FOR y = 0 TO 80 STEP 20
GET (0, y)-(10, y + 8), BBox(Index)
Index = Index + 50
NEXT y
FOR y = 100 TO 120 STEP 20
GET (0, y)-(15, y + 14), BBox(Index)
Index = Index + 75
GET (0, 140)-(30, 153), Box 'minimize/maximize buttons
GET (22, 0)-(28, 6), Box(150) 'screw
NEXT y
LINE (0, 0)-(64, 174), 0, BF
GET (13, 444)-(54, 453), FontBOX(10000): PUT (13, 444), FontBOX(10000)
GET (58, 444)-(87, 453), FontBOX(10200): PUT (58, 444), FontBOX(10200)
GET (91, 444)-(133, 453), FontBOX(10400)
GET (110, 444)-(133, 453), FontBOX(10600): PUT (91, 444), FontBOX(10400)
GET (54, 453)-(140, 462), FontBOX(10800): PUT (54, 453), FontBOX(10800)
PUT (53, 453), FontBOX(10600)
GET (13, 453)-(76, 462), FontBOX(11200): PUT (13, 453), FontBOX(11200)
Index = 12000
FOR x = 14 TO 104 STEP 10
IF x = 24 THEN Hop = -1 ELSE Hop = 0
GET (x + Hop, 462)-(x + 2 + Hop, 470), FontBOX(Index)
PUT (x + Hop, 462), FontBOX(Index)
Index = Index + 20
NEXT x

GOSUB GetFONT
CLS

LINE (0, 0)-(639, 17), 0, BF
LINE (30, 0)-(119, 16), 8, BF
LINE (0, 18)-(639, 40), 7, BF
LINE (0, 41)-(639, 41), 0
LINE (0, 411)-(639, 479), 7, BF
LINE (0, 411)-(639, 411), 15
'Tool bar
LINE (497, 20)-(497, 38), 8
LINE (498, 20)-(498, 38), 15
LINE (324, 28)-(326, 30), 0, BF
LINE (322, 26)-(328, 32), 0, B
FOR x = 313 TO 558 STEP 25
IF x = 488 THEN x = 508
LINE (x, 20)-(x + 24, 39), 8, B
LINE (x, 20)-(x + 23, 20), 15
LINE (x, 20)-(x, 38), 15
NEXT x
'Work area
LINE (0, 41)-(150, 479), 7, BF
LINE (0, 41)-(150, 41), 8
LINE (0, 42)-(150, 42), 15
LINE (151, 41)-(151, 410), 0
LINE (631, 43)-(639, 479), 7, BF
LINE (631, 41)-(639, 41), 8
LINE (631, 42)-(639, 42), 15
LINE (631, 42)-(631, 411), 15
LINE (154, 44)-(629, 409), 0, B
LINE (153, 43)-(628, 408), 7, B
PSET (153, 43), 15
PSET (153, 408), 15
PSET (628, 43), 15
PSET (628, 408), 15
'Coordinates box
LINE (19, 455)-(129, 473), 8, BF
LINE (21, 457)-(129, 471), 15, BF
LINE (129, 455)-(129, 473), 15
LINE (20, 473)-(129, 473), 15
LINE (20, 456)-(128, 472), 7, B
LINE (132, 463)-(146, 463), 7
'Status Bar blurbs box
LINE (280, 455)-(550, 473), 8, B
LINE (281, 473)-(550, 473), 15
LINE (550, 455)-(550, 473), 15
'Film strip graphic begins
LINE (15, 48)-(134, 407), 0, B
LINE (15, 48)-(133, 406), 8, BF
FOR y = 47 TO 404 STEP 17
IF y = 268 THEN y = 265
LINE (18, y)-(26, y + 5), 0, BF
LINE (19, y + 1)-(26, y + 5), 7, BF
LINE (122, y)-(129, y + 5), 0, BF
LINE (123, y + 1)-(129, y + 5), 7, BF
NEXT y
LINE (12, 44)-(136, 48), 7, BF
LINE (12, 407)-(136, 412), 7, BF
FOR y = 50 TO 381 STEP 70
IF y = 190 THEN y = 198
NEXT y
'Run control buttons
LINE (14, 414)-(135, 434), 0, B
LINE (15, 415)-(134, 415), 15
LINE (15, 433)-(134, 433), 8
LINE (134, 415)-(134, 433), 8
LINE (15, 415)-(15, 433), 15
FOR x = 38 TO 110 STEP 24
LINE (x, 414)-(x, 433), 8
LINE (x + 1, 415)-(x + 1, 433), 15
NEXT x
'Clock frame
LINE (563, 455)-(625, 473), 8, B
LINE (563, 473)-(625, 473), 15
LINE (625, 455)-(625, 473), 15
'Frame indicator
LINE (2, 191)-(149, 264), 7, BF
LINE (2, 190)-(149, 190), 15
LINE (3, 265)-(148, 265), 0
LINE (2, 191)-(2, 264), 15
LINE (149, 190)-(149, 265), 8
PUT (6, 194), Box(150), PSET
PUT (139, 194), Box(150), PSET
PUT (6, 255), Box(150), PSET
PUT (139, 255), Box(150), PSET
LINE (28, 192)-(121, 263), 8, BF
LINE (28, 192)-(121, 263), 15, B
LINE (28, 192)-(28, 262), 0
LINE (28, 192)-(120, 193), 0, B
LINE (30, 194)-(119, 261), 8, BF
LINE (124, 220)-(146, 235), 8, BF
LINE (124, 220)-(146, 235), 0, B
LINE (124, 235)-(146, 235), 15
LINE (146, 220)-(146, 235), 15
PrintSTRING 130, 222, "00", 1
'Color bar section
LINE (151, 423)-(190, 434), 8, B
LINE (151, 434)-(190, 434), 15
LINE (190, 423)-(190, 434), 15
LINE (152, 424)-(189, 433), 0, BF
CDATA:
DATA 0,8,7,15,1,2,3,4,5,6,9,10,11,12,13,14
RESTORE CDATA
FOR x = 200 TO 612 STEP 26
IF x = 304 THEN x = 321
READ Colr
LINE (x, 423)-(x + 23, 434), Colr, BF
LINE (x, 423)-(x + 23, 434), 0, B
LINE (x, 434)-(x + 23, 434), 15
LINE (x + 23, 423)-(x + 23, 434), 15
IF Colr > 9 THEN
PUT (x + 8, 413), FontBOX(12020)
Hop = 1
ELSE
Hop = 0
END IF
Colr$ = RTRIM$(STR$(Colr))
Num = VAL(RIGHT$(Colr$, 1))
PUT (x + 10 + Hop, 413), FontBOX(12000 + Num * 20)
NEXT x
PSET (14, 437), 15
DRAW "D5R34BR53R34U5"
PSET (200, 438), 15
DRAW "D4R25BR51R25U4BR20D4R118BR73R118U4"
PUT (54, 438), FontBOX(10000)
PUT (156, 438), FontBOX(10200)
PUT (229, 438), FontBOX(10400)
PUT (443, 438), FontBOX(11200)
PUT (147, 459), FontBOX(10800)
LINE (132, 463)-(142, 463), 15
P$ = "Check here for descriptions of the various functions"
PrintSTRING 290, 458, P$, 1
PUT (60, 1), TitleBOX, PSET
PUT (60, 218), TitleBOX, PSET
FOR y = 2 TO 16 STEP 2
LINE (313, y)-(586, y), 8
NEXT y
PUT (592, 2), Box, PSET
PUT (624, 2), BBox(250), PSET
ToolX:
DATA 342,366,391,416,441,466,511,536,560
RESTORE ToolX
FOR Index = 0 TO 800 STEP 100
READ x
IF x = 536 THEN y = 23 ELSE y = 22
PUT (x, y), ToolBOX(Index), PSET
NEXT Index
Index = 0
FOR x = 22 TO 118 STEP 24
PUT (x, 420), BBox(Index), PSET
Index = Index + 50
NEXT x
PrintSTRING 19, 24, "File", 1
PrintSTRING 60, 24, "Edit", 1
PrintSTRING 100, 24, "Color", 1
PrintSTRING 148, 24, "Special", 1
PrintSTRING 205, 24, "Help", 1
LINE (155, 45)-(626, 406), 7, BF
LINE (155, 45)-(626, 406), 15, B
LINE (155, 406)-(626, 406), 8
LINE (626, 45)-(626, 406), 8
LINE (166, 56)-(615, 395), 8, BF
LINE (165, 55)-(616, 396), 15, B
LINE (165, 55)-(616, 55), 0
LINE (165, 55)-(165, 396), 0
FOR y = 24 TO 38
FOR x = 30 TO 60
xx = x * 5 + 166
yy = y * 5 + 56
LINE (xx, y * 5 + 56)-(xx + 4, yy + 4), POINT(x + 30, y + 194), BF
NEXT x
NEXT y
LINE (169, 59)-(611, 392), 0, B
LINE (170, 60)-(610, 391), 0, B
LINE (174, 64)-(606, 387), 0, B
LINE (175, 65)-(605, 386), 0, B
PrintSTRING 142, 3, "untitled", 0
PrintSTRING 37, 459, "Pixel", 1
PrintSTRING 65, 459, "x:", 1
PrintSTRING 95, 459, "y:", 1
FOR y = 50 TO 338 STEP 70
IF y = 190 THEN y = 194
IF y = 264 THEN y = 268
LINE (30, y)-(119, y + 67), 0, B
LINE (32, y + 2)-(117, y + 65), 0, B
LINE (34, y + 4)-(115, y + 63), 0, B
PUT (60, y + 24), TitleBOX, PSET
NEXT y
FileCOUNT = 0
DEF SEG = VARSEG(FontBOX(0))
FOR y = 0 TO 360 STEP 120
GET (0, y)-(639, y + 119), FontBOX
PUT (0, y), FontBOX
FileCOUNT = FileCOUNT + 1
FileNAME$ = "Animax!" + LTRIM$(STR$(FileCOUNT)) + ".BSV"
BSAVE FileNAME$, VARPTR(FontBOX(0)), 19681 * 2&
NEXT y
DEF SEG = VARSEG(FontBOX(0))
BLOAD "animssb.fnt", VARPTR(FontBOX(0))
BLOAD "animssr.fnt", VARPTR(FontBOX(4700))
DEF SEG
DrawBOX 100, 100, 378, 216, 0
GOSUB BoxTOP
FOR x = 124 TO 284 STEP 80
LINE (x, 177)-(x + 70, 200), 0, B
DrawBOX x + 1, 178, x + 69, 199, 0
NEXT x
PrintSTRING 112, 107, "Animax!", 0
PrintSTRING 162, 139, "The currently loaded file has been", 1
PrintSTRING 162, 152, "altered. Do you wish to save changes?", 1
PrintSTRING 150, 183, "Yes", 1
PrintSTRING 233, 183, "No", 1
PrintSTRING 303, 183, "Cancel", 1
PUT (126, 138), ExBOX, PSET
GET (100, 100)-(378, 216), Box
PUT (100, 100), Box
DEF SEG = VARSEG(Box(0))
BSAVE "anibox5.bsv", VARPTR(Box(0)), 16400
DEF SEG
DrawBOX 100, 100, 184, 254, 0 '164
PrintSTRING 112, 108, "New", 1
PrintSTRING 112, 122, "Open", 1
PrintSTRING 112, 136, "Save", 1
PrintSTRING 112, 150, "Save As", 1
PrintSTRING 112, 173, "1", 1
PrintSTRING 117, 173, ".", 1
PrintSTRING 112, 187, "2.", 1
PrintSTRING 112, 201, "3.", 1
PrintSTRING 112, 215, "4.", 1
LINE (103, 166)-(181, 166), 8
LINE (103, 167)-(181, 167), 15
LINE (103, 231)-(181, 231), 8
LINE (103, 232)-(181, 232), 15
PrintSTRING 112, 238, "Exit", 1
GET (100, 100)-(184, 254), Box(0)
PUT (100, 100), Box(0)
DrawBOX 200, 100, 252, 156, 0
PrintSTRING 212, 108, "Undo", 1
PrintSTRING 212, 122, "Copy", 1
PrintSTRING 212, 136, "Paste", 1
GET (200, 100)-(252, 156), Box(3420)
PUT (200, 100), Box(3420)
DrawBOX 300, 100, 386, 142, 0
PrintSTRING 312, 108, "Select Palette", 1
PrintSTRING 312, 122, "Edit Colors", 1
GET (300, 100)-(386, 142), Box(4220)
PUT (300, 100), Box(4220)
DrawBOX 400, 100, 497, 156, 0
PrintSTRING 412, 108, "Flip Horizontally", 1
PrintSTRING 412, 122, "Flip Vertically", 1
PrintSTRING 412, 136, "Negative Image", 1
GET (400, 100)-(497, 156), Box(5350)
PUT (400, 100), Box(5350)
DrawBOX 100, 200, 196, 256, 0
PrintSTRING 112, 208, "Instructions", 1
PrintSTRING 112, 222, "Load Demo File", 1
PrintSTRING 112, 236, "About Animax!", 1
GET (100, 200)-(196, 256), Box(6834)
PUT (100, 200), Box(6834)
DEF SEG = VARSEG(Box(0))
BSAVE "animnus.bsv", VARPTR(Box(0)), 16640
DEF SEG
'WinicoCL.BSV
DrawBOX 100, 100, 379, 230, 0
DrawBOX 110, 128, 370, 222, 1
GOSUB BoxTOP
PrintSTRING 110, 107, "Animax! " + " Instructions", 0
LINE (300, 106)-(318, 118), 7, BF
PSET (303, 112), 0
DRAW "E5D3R6D4L6D3H5br2p0,0"
LINE (325, 106)-(343, 118), 7, BF
PSET (340, 112), 15
DRAW "H5D3L6D4R6D3E5bl2p15,15"
RESTORE HelpDATA
DEF SEG = VARSEG(Box(0))
FOR Page = 1 TO 10
IF Page = 2 THEN PAINT (305, 113), 15, 7
IF Page = 10 THEN PAINT (338, 113), 0, 7
LINE (111, 129)-(368, 220), 15, BF
y = 133
FOR Reps = 1 TO 7
Font = 1: yy = 0: xx = 0
IF Page = 6 THEN
IF Reps = 1 THEN Font = 0 ELSE Font = 1
IF Reps = 2 THEN yy = 2
IF Reps = 1 OR Reps = 2 THEN xx = -4
IF Reps = 4 OR Reps = 5 THEN yy = -5
LINE (143, 162)-(169, 217), 7, BF
LINE (143, 188)-(169, 191), 15, BF
DrawBOX 145, 164, 167, 185, 0
DrawBOX 145, 194, 167, 215, 0
PUT (147, 167), ToolBOX(700), PSET
PUT (147, 197), ToolBOX(800), PSET
END IF
READ h$
PrintSTRING 124 + xx, y + yy, h$, Font
y = y + 12
GET (100, 100)-(379, 230), Box
FileNAME$ = "AxHELP" + LTRIM$(STR$(Page)) + ".BSV"
BSAVE FileNAME$, VARPTR(Box(0)), 18400
NEXT Reps
NEXT Page
DEF SEG
DrawBOX 100, 100, 379, 230, 0
GOSUB BoxTOP
PrintSTRING 112, 107, "About Animax!", 0
PrintSTRING 124, 135, "Animax! 2.1", 0
PrintSTRING 242, 136, "(Freeware)", 1
PrintSTRING 124, 156, "Program type:", 1
PrintSTRING 242, 155, "Graphics/Animation Utility", 1
PrintSTRING 124, 167, "Program & Graphics by:", 1
PrintSTRING 242, 167, "Bob Seguin 2000 - 2007", 1
PrintSTRING 124, 179, "Language:", 1
PrintSTRING 242, 179, "QBasic 1.1", 1
PrintSTRING 124, 198, "Email:", 1
PrintSTRING 242, 198, "BOBSEG@sympatico.ca", 1
GET (100, 100)-(379, 230), Box
DEF SEG = VARSEG(Box(0))
BSAVE "axhelp11.bsv", VARPTR(Box(0)), 18400
DEF SEG
DrawBOX 100, 100, 379, 178, 0
GOSUB BoxTOP
PrintSTRING 110, 107, "Animax!", 0
PUT (112, 134), ExBOX, PSET
DrawBOX 321, 135, 368, 159, 0
LINE (320, 134)-(369, 160), 0, B
PrintSTRING 339, 142, "OK", 1
PrintSTRING 152, 135, "Sorry, your file (or its path) could", 1
PrintSTRING 152, 147, "not be found. Please try again.", 1
GET (100, 100)-(379, 178), Box
LINE (142, 135)-(312, 159), 7, BF
PrintSTRING 142, 135, "Sorry, the file name you entered is in", 1
PrintSTRING 142, 147, "use by another file. Please try again.", 1
GET (142, 135)-(312, 159), Box(5535)
LINE (142, 135)-(312, 159), 7, BF
PrintSTRING 148, 135, "Sorry, the file you requested is not", 1
PrintSTRING 148, 147, "a properly formatted Animax! file.", 1
GET (142, 135)-(312, 159), Box(6650)
LINE (142, 135)-(312, 159), 7, BF
PrintSTRING 142, 135, "Please save the currently loaded file", 1
PrintSTRING 142, 147, "or select 'New' before loading demo.", 1
GET (142, 135)-(312, 159), Box(7765)
DEF SEG = VARSEG(Box(0))
BSAVE "anibox4.bsv", VARPTR(Box(0)), 8880 * 2
DEF SEG
LINE (100, 100)-(379, 178), 0, BF
DrawBOX 100, 100, 379, 230, 0
GOSUB BoxTOP
PrintSTRING 112, 107, "Edit Colors", 0
FOR x = 272 TO 324 STEP 51
DrawBOX x, 202, x + 46, 225, 0
LINE (x - 1, 201)-(x + 47, 226), 0, B
NEXT x
PrintSTRING 279, 208, "Cancel", 1
PrintSTRING 340, 208, "OK", 1
DrawBOX 320, 164, 370, 197, 1
LINE (321, 165)-(369, 196), 1, BF
RESTORE CDATA
READ a, B, c, d
FOR y = 140 TO 150 STEP 10
FOR x = 110 TO 330 STEP 44
DrawBOX x, y, x + 39, y + 8, 1
READ Colr
LINE (x + 1, y + 1)-(x + 38, y + 7), Colr, BF
NEXT x
NEXT y
PrintSTRING 110, 125, "Click color to edit", 1
PrintSTRING 110, 164, "R", 1
PrintSTRING 110, 176, "G", 1
PrintSTRING 110, 188, "B", 1
FOR y = 169 TO 193 STEP 12
DrawBOX 125, y - 1, 285, y + 1, 1
LINE (126, y)-(285, y), 0
PSET (285, y - 1), 8
NEXT y
PrintSTRING 110, 208, "Adjust sliders, click OK to accept", 1
GET (100, 100)-(379, 230), Box(500)
DrawBOX 100, 300, 115, 308, 0
LINE (104, 301)-(104, 307), 15
LINE (111, 301)-(111, 307), 8
GET (100, 300)-(115, 308), Box(9700)
GET (144, 189)-(159, 197), Box(9800)
PUT (100, 300), Box(9700)
PUT (100, 100), Box(500)
DEF SEG = VARSEG(Box(0))
BSAVE "anibox3.bsv", VARPTR(Box(500)), 18800
DEF SEG
SelectionDATA:
DATA "DOS Default", "Crayons", "Pastels", "Floral", "Nature"
DATA "Grayscale", "Half-Gray", "Half-Blue", "Half-Violet", "Half-Beige"
DATA "Metals", "Paper & Ink", "Wood", "People", "Military"
DrawBOX 100, 100, 379, 210, 0
GOSUB BoxTOP
PrintSTRING 112, 107, "Select Palette", 0
RESTORE SelectionDATA
FOR x = 118 TO 290 STEP 86
FOR y = 134 TO 200 STEP 14
LINE (x, y)-(x + 4, y + 4), 15, B
READ Selection$
PrintSTRING x + 11, y - 3, Selection$, 1
NEXT y
NEXT x
GET (100, 100)-(379, 210), Box(500)
PUT (100, 100), Box(500)
DEF SEG = VARSEG(Box(0))
BSAVE "anibox2.bsv", VARPTR(Box(500)), 15544
DEF SEG
DrawBOX 100, 100, 379, 198, 0
LINE (108, 126)-(370, 144), 15, BF
LINE (108, 126)-(370, 144), 0, B
LINE (108, 146)-(372, 146), 15
LINE (372, 126)-(372, 146), 15
GOSUB BoxTOP
FOR x = 274 TO 325 STEP 51
DrawBOX x, 160, x + 46, 183, 0
LINE (x - 1, 159)-(x + 47, 184), 0, B
NEXT x
PrintSTRING 281, 166, "Cancel", 1
PrintSTRING 342, 166, "OK", 1
PrintSTRING 112, 107, "Open", 0
PrintSTRING 114, 160, "File names must be 8 characters", 1
PrintSTRING 114, 171, "or less. You may include a path.", 1
GET (100, 100)-(379, 198), Box(500)
GOSUB BoxTOP
PrintSTRING 112, 107, "Save", 0
GET (112, 107)-(156, 118), Box(7500)
GOSUB BoxTOP
PrintSTRING 112, 107, "Save As", 0
GET (112, 107)-(156, 118), Box(7800)
LINE (100, 100)-(379, 198), 0, BF
DEF SEG = VARSEG(Box(0))
BSAVE "anibox1.bsv", VARPTR(Box(500)), 15200
DEF SEG
'Finish up
LINE (5, 5)-(634, 474), 8, B
LINE (8, 8)-(631, 471), 8, B
LINE (200, 180)-(439, 290), 8, B
LINE (197, 177)-(442, 293), 8, B
PrintSTRING 247, 212, "The graphics files for ANIMAX!", 1
PrintSTRING 243, 226, "have been successfully created.", 1
PrintSTRING 246, 250, "You can now run the program.", 1

a$ = INPUT$(1)
END

BoxTOP:
LINE (104, 104)-(375, 121), 0, BF
FOR y = 105 TO 121 STEP 2
LINE (224, y)-(352, y), 8
NEXT y
DrawBOX 357, 106, 371, 119, 0
PSET (360, 109), 0
DRAW "F7rH7BD7nE7lE7"
RETURN

GetFONT:
'Stores two fonts in single array (see PrintSTRING sub program).
Index = 2
FOR y = 206 TO 454 STEP 14
FOR x = 0 TO 140 STEP 14
GET (x, y)-(x + 11, y + 11), FontBOX(Index)
PUT (x, y), FontBOX(Index)
Index = Index + 50
IF Index = 188 * 50 + 2 THEN EXIT FOR
NEXT x
NEXT y
FontBOX(0) = 50
FontBOX(1) = 4
FontBOX(4700) = 50
FontBOX(4701) = 4
FontBOTTOM = 211
FOR Index = 2 TO 187 * 50 + 2 STEP 50
GOSUB ReduceFONT
NEXT Index
DEF SEG = VARSEG(FontBOX(0))
BSAVE "animssb.fnt", VARPTR(FontBOX(0)), 9400
BSAVE "animssr.fnt", VARPTR(FontBOX(4700)), 9400
DEF SEG
RETURN

ReduceFONT:
LINE (0, 200)-(20, 220), 0, BF
PUT (0, 200), FontBOX(Index)
x1 = -1: x2 = -1
FOR x = 0 TO 20
FOR y = 200 TO 220
IF POINT(x, y) <> 0 AND x1 = -1 THEN x1 = x
NEXT y
NEXT x
FOR x = 20 TO 0 STEP -1
FOR y = 200 TO 220
IF POINT(x, y) <> 0 AND x2 = -1 THEN x2 = x
NEXT y
NEXT x
GET (x1, 200)-(x2 + 1, FontBOTTOM), FontBOX(Index)
RETURN

Setpalette:
DATA 0,0,0,21,21,21,13,9,20,0,0,0,63,0,0,11,11,23,63,61,60,42,42,42,21
DATA 21,21,63,43,0,43,30,60,0,63,63,59,55,59,0,0,42,58,54,54,63,63,63
RESTORE Setpalette
OUT &H3C8, 0
FOR n = 1 TO 48
READ Intensity: OUT &H3C9, Intensity
NEXT n
RETURN

HelpDATA:
DATA "Animax is designed for the creation of animated"
DATA "sequences for use in QBasic programs. The images"
DATA "produced by this program are 90 pixels wide by"
DATA "68 pixels deep. This size is entirely appropriate"
DATA "since most animation is used in only small areas of"
DATA "a larger image -- for example, a fire crackling in"
DATA "in a fireplace or an animated character sprite."
DATA "The frame you are working on is displayed in"
DATA "the film gate to the left of the screen. Work is"
DATA "done in the large center screen work area. The"
DATA "icons across the top of this work area allow"
DATA "you to select a variety of useful drawing tools"
DATA "while the run controls on the lower left allow"
DATA "manipulation of the frames created."
DATA "Certain drawing functions (Box, Circle, Elipse,"
DATA "Line and Mask) can only be used at three times"
DATA "magnification. For these operations, the work"
DATA "area will switch automatically to this reduced"
DATA "size when the tool is selected."
DATA "NOTE: Watch the status window at the bottom of"
DATA "the screen for the tool/run control's description."
DATA "It is important to keep in mind when working,"
DATA "that you are actually drawing the small frame"
DATA "on the left, not the large image in the work"
DATA "area. After certain operations, the large drawing"
DATA "area will switch from a relatively detailed image"
DATA "to a magnified image of the frame. Aliasing will"
DATA "become more pronounced. This is normal."
DATA "To create a new frame, simply go to the last frame"
DATA "in the sequence and press the frame advance"
DATA "button. There are a total of 16 frames possible in"
DATA "an Animax! (.AXB) file. This should be sufficient"
DATA "for any animated action cycle. .AXB files are"
DATA "BSAVE'd for rapid loading. When opening or sav-"
DATA "ing, the extension .AXB is added automatically."
DATA "Specialty Tools:"
DATA "Right-click anywhere in work area to 'pick up' color.",""
DATA "ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿToggles between 3x and 5x magnifi-"
DATA "ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿcation of the frame being worked on."
DATA "ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿClick any color in the image and all"
DATA "ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿinstances of it change to pen color."
DATA "Copy and Paste can be used with or without the"
DATA "Mask tool. If you click Copy without masking, the"
DATA "entire frame is copied and can be pasted into an-"
DATA "other frame. If you copy a masked area it can only"
DATA "be pasted to the same location in another frame."
DATA "You can also locate a pasted image using a mask,"
DATA "but only from and to the frame being worked on."
DATA "In order to use .AXB files, you must first understand"
DATA "how these files are structured. Information is held"
DATA "in an integer array. The first 8 integers hold the"
DATA "ASCII values of the file's name. The next 48 hold"
DATA "the palette (RGB) intensity values in order from"
DATA "attribute 0 to 15. Element 57 holds the number of"
DATA "frames in the total sequence (1-16)."
DATA "From element 58 to the end of the file is individual"
DATA "frame information at 1635 integers per frame. For
DATA "example, Array(58) will PUT the first frame,"
DATA "Array(1693) the second, etc. The minimum array"
DATA "size necessary for a 16 frame sequence is 26217.",""
DATA "Formula: ArraySIZE = 8 + 48 + 1 + Frames * 1635"
DATA "Animax! can also be used as a drawing utility for"
DATA "detailed SCREEN 12 images involving custom colors,"
DATA "or to refine existing images created elsewhere."
DATA "If you understand the structure of the .AXB file"
DATA "you can GET images to an array in 90x68 'chunks'"
DATA "and save them with the extension .AXB, then load"
DATA "the file in Animax! to refine these images."
HueDATA:
DATA "###b8bM#M88b##Gbb#8b8MMM88<#M##?#bP#bC#b##M8#bbb###bSbWGWVVbMMbbbZbbMMM"
DATA "M88<MbMCWCbZMbSGbMMWBBbbb###bbMbb##b##M#bL8bBWMMM88<b##M##[MbI#AMWb88bb"
DATA "bb###bb#8b8#C##8#ZZb8CbMMM88<WMCMC8bP?bC#b##M8#bbb###___[[[WWWSSSOOOKKK"
DATA "MMM888GGGCCC???;;;777333bbb###bb##S###bb##___ZZZMMM88<UUUPPPKKKFFFAAA<<"
DATA "<bbb###bb##S###bb##?Ib;E_MMM88<7A[3=W/9S+5O'1K#-Gbbb###bb##S###bb##bIb_"
DATA "E_MMM88<[A[W=WS9SO5OK1KG-Gbbb###bb##S###bb##bUP_RMMMM88<\OJWJETGBQD?NA<"
DATA "K>9bbb###_[_UQUUIFK:<bZMbUCMMM88<bM#ZC#]C8Z9/NOU:<Gbbb###/PS7/M##Cb//__"
DATA "_bZbMMM88<UZbZbZbb]bZN]M;WG3bbb###bZR]M?WG7M8'WIII15MMM88<ZUKPKASIAE;=U"
DATA "QOIECbbb###_ZG_PASS]#8M[C<Q<7MMM88<G59=-/b]WbZSbUMbOGbbb###ZZb88M##bb##"
DATA "ZUMSMCMMM88<MC8C8-WWBMM8CC-88-bbb"
PixDATA:
DATA "@7=8@7=8J7?0b7!O5?7>8?7>8I7=0?F=0Y7@0@7Š5=2€5>7?8>7?8H7=0?F=0=F=0W7>0=F"
DATA ">0@7Š5=2v5=7E5=7@8=7@8H7=0>F=0>F=0V7>0=F?0@7‰5?2r5=2=E>6=7=2C5F8H7=0=F"
DATA "=0?F=0U7>0=F?0A7ˆ5@2q5?E?6D5=7@8=7@8I7=0?F=0V7=0=F?0B7!=2>1=2?E@6=EC2>7"
DATA "?8>7?8J7?0V7A0C7Œ2=7=1l2AEA6=7B2?7>8?7>8f7=0=F?0D7Œ2>6=7i2=1=2AEA6=EB2"
DATA "@7=8@7=8e7=0=F?0E72>6=7i2=7AEB6=7A2n7=0=F?0F7…5D2?6=7g5=2BE?6=D>6=EA5"
DATA "N7=8L0=8I7=0=F?0G7„3E2@6f3=1=2AEA6=D>6=7@3M7=0MF=0=8H7@0H7„3E2=7?6=1e3"
DATA "=2=7AE?6=D=6=D>6=E@3L7=8OF=0=8F7@0I7ƒ3F2=7?6=7e3=2BE@6=D=6=D>6=7?3L7=0"
DATA "DF?0DF=0=8F7>0K7‚3G2=7@6d3=1=2BE?6=D=6=D=6=D=6=E?3L7=0DF?0DF=0=8W7‚3H2"
DATA "@6=1c3=2=7BE@6>D=6=D>6=7>3L7=0DF?0DF=0=8W7=3=2?3=2=3?2=3=2?3=2=3?2=3=2"
DATA "?3=2=3?2=3=2?3=2=3?2=3=2?3=2=3?2=3=2=3=2?3=2=3?2=3=2?3=2=3I2@6=7=2=3?2"
DATA "=3=2?3=2=3?2=3=2=3=2=3?2=3=2?3=2=3?2=3=2?3>2BEA6=D=6=D?6=E=2=3L7=0DF?0"
DATA "DF=0=8W7C2?3C2?3C2?3C2?3C2?3E2?3P2@6=7>2?3C2?3A2?3C2?3A2=1=2BEB6>D@6>2"
DATA "L7=0DF?0DF=0=8W7=3=2=3=2=3=2A3=2=3=2=3=2A3=2=3=2=3=2A3=2=3=2=3=2A3=2=3"
DATA "=2=3=2A3=2=3=2=3=2=3=2A3=2=3=2=3B2=9D2=7@6=2A3=2=3=2=3=2A3=2=3=2A3=2=3"
DATA "=2=3=2A3=2=3=2=3=2=7BE?6=D?6>D?6=7=3L7=0DF?0DF=0=8W7>3?2C3?2C3?2C3?2C3"
DATA "?2E3?2C3D2=9F2@6=1B3?2C3=2C3?2C3@2CE@6=D>6=D=6=D>6=E=3L7=0DF?0DF=0=8W7"
DATA ">3=2=3=2C3=2=3=2C3=2=3=2C3=2=3=2C3=2=3=2E3=2=3=2C3=2=3A2=9G2@6=7B3=2=3"
DATA "=2C3=2C3=2=3=2C3=2=3=1=2BE@6>D?6>D?6=3?7>8G7=0DF?0DF=0=8W7>3?2C3?2C3?2"
DATA "C3?2C3?2E3?2C3B2=9H2@6=7B3?2C3=2C3?2C3@2BEA6>D>6=D=6=D>6@7?8F7=0DF?0DF"
DATA "=0=8F7I0@7=3=2=3=2=3=2A3=2=3=2=3=2A3=2=3=2=3=2A3=2=3=2=3=2A3=2=3=2=3=2"
DATA "A3=2=3=2=3=2=3=2A3=2=3A2=9>2=9E2=7@6=1@3=2=3=2=3=2A3=2=3=2A3=2=3=2=3=2"
DATA "A3=2=3=1=2=7BEA6=D=6=D>6=D=6=D>6?7@8E7=0DF?0DF=0=8F7=0G7=0@7=3>2=3>2A3"
DATA ">2=3>2A3>2=3>2A3>2=3>2A3>2=3>2A3=2=3>2=3>2A3B2=9>2=9G2@6=1@3>2=3>2A3?2"
DATA "A3>2=3>2A3>2=1=2DE?6=D=6>D>6=D=6=D>6?7A8D7=0DF?0DF=0=8F7=0G7=0@7=3=2?3"
DATA "=2A3=2?3=2A3=2?3=2A3=2?3=2A3=2?3=2A3=2=3=2?3=2A3A2=9K2@6=7@3=2?3=2A3=2"
DATA "=3=2A3=2?3=2A3=2=3>2EE?6=D=6>D>6=D=6=D=6?7B8C7=0DF?0DF=0=8F7=0G7=0@7>2"
DATA "?3?2=3?2?3?2=3?2?3?2=3?2?3?2=3?2?3?2=3A2?3?2=3B2=9?2=9H2@6=7=1=3?2?3?2"
DATA "=3?2=3?2=3?2?3?2=3?2=3=1=2EE?6=D=6=D=6=D>6=D>6?7A8D7=0DF?0DF=0=8F7=0G7"
DATA "=0@7z3@2=9C2=9E2=7@6=1]3=2=1FE?6=D=6>D>6=D>6?7@8E7=0OF=0=8F7=0G7=0@7z3"
DATA "?2=9?2=9?2=9G2@6=7^3=1=2FE?6>D=6=D>6=D=6?7?8F7=0OF=0=8F7=0G7=0@7y3@2=9"
DATA ">2=9?2=9H2@6=7=1^3=2FE?6=D=6>D>6=D=6?7>8G7=0DF?0DF=0=8F7=0G7=0@7C3>2=3"
DATA "[2O3@2=9B2=9I2A6=7^3=1=2FE?6=D=6>D?6L7=0DF?0DF=0=8F7=0G7=0@7B3?2=3\2L3"
DATA "=2=3?2=9?2=9>2=9J2=E@6=7_3=2FE@6>D=6=D>6L7=0DF?0DF=0=8F7=0G7=0@7B3?2=3"
DATA "\2L3=2=3B2=9?2=9G2=1=2?E@6=2^3=1=2FE?6=D=6>D>6L7=0DF?0DF=0=8F7=0G7=0@7"
DATA "E2=3m2=3A2=9K2=1=2BE>6=1`2FE@6>D=6=D=6L7=0OF=0=8F7=0G7=0@7F2=3l2=3D2=9"
DATA "G2=1=2DE=6=7_2=1=2EE@6=D=6=D>6L7=8=0MF>0=8F7I0@7F2=3l2=3O2=1=2EE=7=1a2"
DATA "FE@6=D=6=D=6M7O0=8X7A4A2=3B2B9>2>9=2=9>2C9B2I4>2=3B2=9G2=1=2EE=7b4=1=2"
DATA "EEA6=D>6N7N8Y7A4A2=3^2H4>2=3A2=9G2=1=2=7EE=7=6=7`4=1=2FE@6=D>6}7>9?3=2"
DATA "=9?2=3D2=9=2>9=2=9?2>9=2>9=2=9=2=9D2E9?3>2=3@2=9H2=1=7EE=7?6a9=1=2EEA6"
DATA "=D=6}7>4?3=9@2=3E2>9=2B9=2=9=2=9>2?9D2D4?3>2=3?2=9H2=1=2EE=7@6=7`4=3=2"
DATA "FE@6=D=6}7>4?3=9=2=9>2=3_2D4?3>2=3K2=1=2EE=7B6_4>3=1=2EEB6}7>4?3=2=9?2"
DATA "=3`2C4?3>2=3J2=1=2EE=7C6=7^4?3=2FEA6=8@7=8w7>4?3=2=9?2=3`2C4?3>2=3I2=1"
DATA "=2EE=7E6^4?3=1=2EEA6>8?7>8i7A0D7>4?3=9@2=3a2B4?3>2=3H2=1=2EE=7F6=7\4A3"
DATA "=2EEA6?8>7?8f7>0A7>0B7>4?3=9@2=3a2B4?3>2=3G2=1=2=7DE=7H6\4A3=1=2EE@6@8"
DATA "=7@8d7=0E7=0A7>4?3=9A2=3a2A4?3>2=3G2=1=7DE?D=6>DD6=7[4B3=2EE@6F8c7=0E7"
DATA "=0A7>4?3B2=3a2A4?3>2=3F2=1=2DE@7H6[4B3=1=2EE?6@8=7@8c7=0G7=0@7>4?3B2=3"
DATA "b2@4?3>2=3E2=1=2EE=7AD=6=D>6>D=6=D>6=7Y4D3=2EE?6?8>7?8d7=0G7=0@7>4?3B2"
DATA "=3b2@4?3>2=3D2=1=2EEA7I6Y4D3=1=2EE>6>8?7>8e7=0G7=0@7>4?3B2=3c2>4@3>2=3"
DATA "C2=1=2EEC7H6=7X4E3=2EE>6=8@7=8f7=0G7=0@7>4?3B2=3c2>4@3>2=3B2=1=2EED7I6"
DATA "W4F3=1=2DE>6l7=0G7=0@7>4?3B2=3d2=4@3>2=3A2=1=2=7DEE7I6=7V4G3=2EE=6m7=0"
DATA "E7=0A7>4?3@2>1=3c1=2=4@3>2=3A2=1=7DE>7=DA7=D=7=D=6>D?6=DB6V4G3=1=2EEm7"
DATA "=0E7=0A7>4?3?2=1e3>2=4@3>2=3@2=1=2DE=D=7?D=7?D=7@D=6=D=6?DA6=7U4H3=2EE"
DATA "n7>0A7>0B7>4?3?2=1e2?4@3>2=3?2=1=2DEI7J6T4I3=1=2DEp7A0D7>4?3>2=1>3d7?4"
DATA "@3>2=3>2=1=2EEI7J6=7S4J3=2DE}7>4?3>2=1=3=7dE?4@3>2=3=2=1=2EEK7J6S4J3=1"
DATA "=2CE}7>4?3=2=1>3dE=7?4@3>2=3=1=2EEL7J6=7Q4L3=2CE}7>4@3=1>3dE=7>4A3>2>3"
DATA "=2DEM7J6=7Q4L3=1=2BE}7>4?3=2=1>3dE=1>4A3>2=1=2DE=7[E=7Q4M3=2BE}7>4?3=2"
DATA "=1>3dE?4A3=2=1>3?E=7`E=7Q4M3=1=2AE}7>4?3=2?3dE=1>4B3=1>3=7=E=7aE=7P4O3"
DATA "=2AE>7=8@7=8u7>4C3dE=7>4B3=1?3cE=7P4O3=1=2>3>E>7=8?7>8h7@0E7>4@3=2>3=7"
DATA "cE=7=1=4B3=1=2>3cE=7=2O4P3=1=2?3>7=8>7?8g7=0@7=0D7>4D3=7cE=2=4C3=1?3cE"
DATA "=2N4R3=1=2>3>7=8=7@8f7=0B7=0C7>4A3=2?3cE>2C3?2=3=7bE>2M4R3>1=2=3>7B8f7"
DATA "=0B7=0C7>4B3>2>3d2E3g2M4T3=1=2>7=8=7@8e7=0D7=0B7>4D3?2—3e4>3>7=8>7?8e7"
DATA "=0D7=0B7!O4>7=8?7>8e7=0D7=0B7!O4>7=8@7=8e7=0D7=0B7!O5m7=0D7=0B7!O5n7=0"
DATA "B7=0C7!O5n7=0B7=0C75>2Š5o7=0@7=0D75=2=C=7=1ˆ5p7@0E7€2>6=C=7=1†2}7€2A6"
DATA "=7…2}7€2C6=7ƒ2}7€2D6p2=E=6M2}7~5>2D6m5=1=7>E>6L5}7}3?2D6m3=7?E?6K3}7}3"
DATA "?2D6l3=1=7?E@6J3>7=8@7=8u7}3?2D6l3=7?EA6=7I3>7>8?7=8u7}3?2D6l3=7?E?6=D"
DATA ">6I3>7?8>7=8o7=0A7|3@2D6k3=1@E@6=D>6H3>7@8=7=8n7=0B7=3=2?3=2=3?2=3=2?3"
DATA "=2=3?2=3=2?3=2=3?2=3=2?3=2=3?2=3=2?3=2=3?2=3=2=3=2?3=2=3?2=3A2D6=3=2=3"
DATA "?2=3=2?3=2=3?2=3=2?3=2=3?2=3=2=3=2=3?2=3=2?3=2=3?2=3=2=3=7@EA6=D=6=E=3"
DATA "?2=3=2?3=2=3>7B8m7=0C7C2?3C2?3C2?3C2?3C2?3E2?3B2D6?2?3C2?3C2?3A2?3C2?3"
DATA ">2=1=7?E@6=D>6=D=6=E?3C2>7@8=7=8l7=0D7=3=2=3=2=3=2A3=2=3=2=3=2A3=2=3=2"
DATA "=3=2A3=2=3=2=3=2A3=2=3=2=3=2A3=2=3=2=3=2=3=2A3A2D6=3=2A3=2=3=2=3=2A3=2"
DATA "=3=2=3=2A3=2=3=2A3=2=3=2=3=2A3=2=7@E?6=D=6=D>6=D=E=7?3=2=3=2=3=2=3>7?8"
DATA ">7=8k7=0E7>3?2C3?2C3?2C3?2C3?2E3?2B3A2D6=2C3?2C3?2C3=2C3?2C3=7@E@6=D=6"
DATA "=D=6=D>6@3?2>3>7>8?7=8j7=0F7>3=2=3=2C3=2=3=2C3=2=3=2C3=2=3=2C3=2=3=2E3"
DATA "=2=3=2B3A2D6=2C3=2=3=2C3=2=3=2C3=2C3=2=3=2B3=1AE>6=D>6=D=6=D=6=D=6=E?3"
DATA "=2=3=2>3>7=8@7=8i7=0G7>3?2C3?2C3?2C3A2A3?2E3?2A3?2=9>2D6=2C3?2C3?2C3=2"
DATA "C3?2B3=7@E@6=D>6>D?6>E>3?2>3p7=0H7=3=2=3=2=3=2A3=2=3=2=3=2A3=2=3=2=3=2"
DATA "A3B2@3=2=3=2=3=2A3=2=3=2=3=2=3=2@3>2=9?2D6=3=2A3=2=3=2=3=2A3=2=3=2=3=2"
DATA "A3=2=3=2A3=2=3=2=3=2@3=1=7@E?6=D=6=D>6>D@6=7=2=3=2=3=2=3o7=0I7=3>2=3>2"
DATA "A3>2=3>2A3>2=3>2=3G2?3>2=3>2A3=2=3>2=3>2@3>2=9?2D6>2A3>2=3>2A3>2=3>2A3"
DATA "?2A3>2=3>2@3=7AE@6>D>6=D=6=D@6>2=3>2=3n7=0J7=3=2?3=2A3=2?3=2A3=2=3K2?3"
DATA "=2?3=2A3=2=3=2?3=2?3>2=9@2D6=3=2A3=2?3=2A3=2?3=2A3=2=3=2A3=2?3=2?3=1=7"
DATA "BE@6>D>6=D=6=D?6=E?3=2=3m7=0K7>2?3?2=3?2?3?2=3S2?3?2=3A2?3?2=3>2=9@2D6"
DATA "=3?2=3?2?3?2=3?2?3?2=3?2=3?2=3?2?3@2=7DE?6=D=6=D>6=D=6=D?6=7>3>2l7=0L7"
DATA "K3T2R3C2D6f3=1=7EE?6=D=6=D>6>D?6=E@3}7G3Y2P3>2=9=2=9?2D6f3=7FE@6>D?6>D"
DATA "?6=7?3}7F3Q2>9C2P3>2=9=2=9?2D6f3=7GE@6>D>6=D=6=D>6=E?3}7C3>2=3L2>9=2=9"
DATA "G2O3>2=9@2=1>E=CA6f3>2GE?6=D=6=D>6=D=6=D>6=E>3}7B3?2=3H2>9=2=9K2N3>2=9"
DATA "=2=9?2=7AE=C>6g3=1=2FE@6=D=6=D>6=D=6=D=6=E=7=3}7B3?2=3D2?9C2>9H2M3>2=9"
DATA "=2=9?2=7DEI6[3=1=2FE@6>D?6>D>6=E=3}7E2=3A2>9C2=9=2>9\2=9=2=9?2=1EEI6=7"
DATA "[2=1FE@6=D=6=D?6>D>6=7KF=0d7?0B7F2=3E2@9`2=9=2=9?2=7EE=D=6=D=6CD?6]2FE"
DATA "@6=D=6=D>6=D?6=E=FI7=8=0c7=0>F=0B7F2=3D2=9E2>9=2=9W2=9A2=7DEK6=7[2=1=2"
DATA "FE@6=D=6=D>6=D>6=E=FI7=8=0b7=0>F?0A7A4A2=3J2=9=2=9L2I4>2=9=2=9?2=1EE?D"
DATA "=6>D>6>D=6?D>6\4=1FEA6=D=6=D@6=E=FI7=8=0a7=0?F>7>0@7A4A2=3F2=9=2=9P2I4"
DATA ">2=9A2=7EEL6=7\4=2FE@6=D>6=D@6=F?7>0@7>0>7=8=0^7>F=0@F?7>0?7>9?3A2=3C2"
DATA "?9S2=1D9@3@2=9?2=7DE=6GD=6=D=6=D>6\9=1=2FE@6=D=6=D@6=F@7>0>7>0?7=8=0\7"
DATA "?F=0?F=0=7=F?7>0>7>4?3=9@2=3A2=9X2D4@3C2=1EEN6=7\4=1=2EEA6=D=6=D?6=FA7"
DATA "@0@7=8=0\7>F=0@F?7=F?7>0=7>4?3=9@2=3^2=1C4@3C2=7EEO6\4=1=2FEA6=D@6=FB7"
DATA ">0A7=8=0[7>F>0=F=0>7=FC7=0=7>4?3A2=3_2C4@3C2=7DEP6=7[4=3=1=2FE@6=D@6=F"
DATA "A7@0@7=8=0[7>F=7?0?7=FA7>0=7>4?3=9@2=3_2C4@3B2=1EEQ6[4>3=1FEE6=F@7>0>7"
DATA ">0?7=8=0[7>F?7=0@7=F?7>0>7>4?3=9@2=3_2=1B4@3B2=7DEAD>6>D>6>D=6>D=6?D>6"
DATA "=7Y4@3=2FED6=F?7>0@7>0>7=8=0[7>F@7=0B7>0?7>4?3=9@2=3`2B4@3B2=7DES6Y4@3"
DATA "=1=2FEC6=FI7=8=0[7>FA7=0@7>0@7>4?3=9A2=3_2=1A4@3A2=1EEHD=6>D=6>D=6=D?6"
DATA "=7X4A3=2FEC6=FI7=8=0[7>FB7=0>7>0A7>4?3B2=3`2A4@3A2=7DEU6W4B3=1=2FEB6=F"
DATA "J8=0[7>FC7?0B7>4?3B2=3Z2?1>7B4@3A2=7DEED=6AD=6=D>6>D=6=D>6=7V4C3=1=2FE"
DATA "A6L0Y7BFJ7>4?3B2=3V2?1?7>E=7B4@3@2=1EEV6V4D3=2FEA6}7>4?3B2=3R2?1?7BE=7"
DATA "A4A3@2=1DE>6>DS6=7T4E3=1=2FE@6}7>4?3B2=3N2?1?7GE=7@4A3@2=7DEX6T4F3=1=2"
DATA "FE?6}7>4?3Q2?1?7KE=7@4A3?2=1=7CE=FX6=7S4G3=1=2EE?6}7>4?3N2>1?7OE=7@4A3"
DATA "?2=1CE=7=E=6>D=6=D>6=DA6=D=6=D=6>D?6=DB6R4I3=2FE>6}7>4?3L2=1>7TE@4A3?2"
DATA "=7CE=7=E>D=6>D=6?D=6?D=6@D=6=D=6?DA6=7Q4I3=1=2FE=6K0=Fm7>4?3I2=1>7RE@F"
DATA "=7@4A3>2=1=7CE=7=EZ6Q4J3=1=2EE=6=0J8=F[7>0=F>0=F>0=F>0=F>0@7>4?3?2=3A2"
DATA "=1>7RE?7=EAF@4A3>2=1CE?7Z6=7O4L3=2FE=0=8H7>F[7=0H7=0@7>4?3@2=3=2=1>7QE"
DATA "D7AF=7?4A3>2=1CE?7[6O4L3=1=2EE=0=8H7>F[7=FH7=F@7>4?3?2=1=3=7OEI7=EAF?4"
DATA "A3=2=1=7BE@7=EZ6=7N4M3=1=2DE=0=8H7>F[7=0H7=0@7>4@3=2=1=3=7LEN7AF=7>4A3"
DATA "=2=1=7BE@7=EZ6=7M4O3=1=2CE=0=8?7>0@7>0=7>F[7=0H7=0@7>4?3=2>3>7HE=7=EA7"
DATA "PE=7>4A3=2=1BE=7_E=7M4P3=2CE=0=8@7>0>7>0>7>F[7=FH7=F@7>4?3=2=1=3>7CE=7"
DATA "=E>7XE=7>4A3=2=1fE=7M4P3=1=2BE=0=8A7@0?7>F[7=0H7=0@7>4?3=2=1=3>7cE=7>4"
DATA "A3=2=1=3eE=7M4Q3=1=2AE=0=8B7>0@7>F[7=0H7=0@7>4@3=2=3>7cE=7>4B3=1>3=E=7"
DATA "bE=7L4S3=1=2@E=0=8A7@0?7>F[7=FH7=F@7>4@3=2>3=7cE=7=2=4B3=1?3cE=7=2K4S3"
DATA "=1=2>E>3=0=8@7>0>7>0>7>F[7=0H7=0@7>4A3=2=3>7cE=2=4C3=1?3cE=2K4T3=1>2>3"
DATA "=0=8?7>0@7>0=7>F[7=0H7=0@7>4A3=2>3=7cE>2C3=2=1>3cE>2I4V3=1>2=3=0=8H7>F"
DATA "[7=FH7=F@7>4B3>2>3d2D3>2=3=1d2I4W3>1=3=0=8JF[7=0H7=0@7>4D3?2m3?2c3I4Z3"
DATA "LF[7>0=F>0=F>0=F>0=F>0@7!H4C3}7!O4}7!O5}7!O5}7!O5}7s5=D—5KF=0KF^7r5=7=2"
DATA "—5=FI7=8=0=FI7=8M7I0@7r2=7=2E6Ž2=FI7=8=0=F>7E8>7=8M7D0@F=0@7r2=7=2E6=D"
DATA "2=FI7=8=0=F>7E8>7=8M7>0?F?0@F=0@7r2=7=2E6=72=FI7=8=0=F>7=8CF=8=F=7=8"
DATA "M7>0>F@0@F=0@7r2=7=2E6=E2=FI7=8=0=F>7=8=FB7=8=F=7=8M7>0=F=0=F?0@F=0@7"
DATA "r5=7=2F65=FI7=8=0=F>7=8=FB7=8=F=7=8M7A0=F>0@F=0@7r3=7=2F63=FI7=8=0=F"
DATA ">7=8=FB7=8=F=7=8M7B0=7=0@F=0@7r3=7=2F63=FI7=8=0=F>7=8=FB7=8=F=7=8M7C0"
DATA "=7@F=0@7\3=2Q3=7=2F63=F@7A8=F?7=8=0=F>7=8=FB7=8=F=7=8M7=0CF=0=F=0=F=0"
DATA "@7Z3@2P3=7=2F63=F@7A8=F?7=8=0=F>7=8=FB7=8=F=7=8M7=0DF>0=F=0@7Y3A2=7O3"
DATA "=7=2F63=FA7AF?7=8=0=F>7E8=F=7=8M7=0CF?0=F=0@7=3=2?3=2=3?2=3=2?3=2=3?2"
DATA "=3=2?3=2=3C2=6=2=3?2=3=2?3=2=3?2=3=2=3=2=7=2F6=3=2=3?2=3=2?3=2=3?2=3=2"
DATA "?3=2=3?2=3=2?3=2=3?2=3=2=3=2=3?2=3=2?3=2=3?2=3=2=6=D=3=2=3?2=3=2?3=2=3"
DATA "?2=3=2?3=2=3=FI7=8=0=FI7=8M7=0GF=0@7C2?3C2?3J2>7=2?3C2?3@2=1=2FE?2?3C2"
DATA "?3C2?3C2?3A2?3C2?3=2=E>6=7>2?3C2?3C2=FJ8=0=FJ8M7I0@7=3=2=3=2=3=2A3=2=3"
DATA "=2=3=2A3=2=3H2=6A3=2=3=2=3=2A3=2=3=2=1=2FE=3=2A3=2=3=2=3=2A3=2=3=2=3=2"
DATA "A3=2=3=2=3=2A3=2=3=2A3=2=3=2=3=2A3@6=7A3=2=3=2=3=2A3=2=3=2=3=2=3}7>3?2"
DATA "C3?2C3I2=6=7A3?2E3=1=2FE=2C3?2C3?2C3?2C3=2C3?2A3=EB6=7@3?2C3?2>3}7>3=2"
DATA "=3=2C3=2=3=2B3J2=7=6A3=2=3=2E3=1=2FE=2C3=2=3=2C3=2=3=2C3=2=3=2C3=2C3=2"
DATA "=3=2A3E6=7>3=2=3=2C3=2=3=2>3}7>3?2C3?2A3L2=6A3?2E3=1=2DE=C=E=2C3?2C3?2"
DATA "C3?2C3=2C3?2@3=E?6=DC6=7?2C3?2>3}7=3=2=3=2=3=2A3=2=3=2=3=2>3N2>7?3=2=3"
DATA "=2=3=2A3=2=3=2=1=2FE=3=2A3=2=3=2=3=2A3=2=3=2=3=2A3=2=3=2=3=2A3=2=3=2A3"
DATA "=2=3=2=3=2>3=2A6>DC6=7=3=2A3=2=3=2=3=2=3}7=3>2=3>2A3>2=3>2=3F2=9E2=6?3"
DATA ">2=3>2A3=2=3=2=1=2FE>2A3>2=3>2A3>2=3>2A3>2=3>2A3?2A3>2=3>2=3=2=E@6=D>6"
DATA "=DC6=7=2A3>2=3>2=3=8?FC8=FN8=F=8]7=3=2?3=2A3=2?3G2=9F2=6=7>3=2?3=2A3=2"
DATA "=3=2=1=2FE=3=2A3=2?3=2A3=2?3=2A3=2?3=2A3=2=3=2A3=2?3=2=3=2@6=D=6>D=6>D"
DATA "C6=7@3=2?3=2=3AFB8=FN8=F=8]7>2?3?2=3?2>3F2>9G2=7=6?2?3?2=3A2=1=2FE=3?2"
DATA "=3?2?3?2=3?2?3?2=3?2?3?2=3?2=3?2=3?2?3?2A6>D=6>D=6>DC6=7?2?3>2AFU8=F=8"
DATA "]7H3F2>9J2=6=1J3=1=2FEo3=E@6=D>6=D>6=DG6=7B3AFU8=F=8M7=0F7=0@7G3E2>9?2"
DATA ">9G2>7J3=1=2FEn3=2B6>D=6>D=6>DG6=7@3=F?8=F=8?F>8=F=8@F>8?F>8>F=8>F=8=F"
DATA "=8M7=0F7=0@7E3E2=9A2=9J2=6=1I3=1=2FEn3=ED6=D>6>D=6>DF6=7?3=F?8=F=8@F=8"
DATA "=F=8AF=8@F=8>F=8>F=8=F=8L7?0>7=F>7=F>7=0=F=0?7D3E2=9@2=9L2>7I3=1=2FEm3"
DATA "=2@6=DA6>D>6=D>6>DE6=7>3AF=8@F=8=F=8AF=8@F=8>F=8>F=8=F=8L7?0=7BF=7=0=F"
DATA "=0?7B3=2=3C2=9@2=9B2>9F2=7=6I3=1=2FEm3=EA6=D=6=D@6=D>6>D>6>DD6=7=3AF=8"
DATA "@F=8=F=8AF=8@F=8>F=8>F=8=F=8L7?0=7=0=F>0=F=0=7=0=F=0?7B3=2=3B2=9?2>9B2"
DATA "=9I2=6=7H3=1=2FES6U3=2A6=D=6=D>6=D?6>D>6>D>6=DD6=7AF=8=F>8=F=8=F=8=F=8"
DATA "=F=8=F@8=F?8=F?8=F=8K7=0=F?0=7=0>7=0=7=0?F=0>7C2=3E2=9A2=9=2=9J2=7=6H2"
DATA "=1=2FES6=7T2=EB6=D>6=D=6=D@6>D>6=D>6>DC6=F?8=F=8=F>8=F=8=F=8=F=8=F=8=F"
DATA ">8?F?8=F?8=F=8K7=0=F?0B7=0?F=0>7C2=3G2=9=2=9N2=7=6=7G2=1=2FE>D=6@D=6=D"
DATA "=6=D=6=D=6CD?6T2=E@6=D>6>D@6=D@6=D>6>D>6>DA6=F?8=F=8=F>8=F=8=F=8=F=8=F"
DATA "=8=F=8=F>8=F?8=F?8=F=8J7=0=FA0@7=0AF=0=7C2=3H2=9P2=1=6G2=1=2FET6=7R2?E"
DATA "@6>D>6>D=6=D=6=D@6>D>6>DC6=F?8=F=8=F>8=F=8=F=8=F=8=F=8=F=8@F=8>F=8>F?8"
DATA "J7C0@7=0AF=0=7A4>2=3E2?9P2=1=6=E=1F4=1=2FE?D>6?D=6?D=6>D>6>D=6?D>6Q4=2"
DATA "@EA6>D>6=D@6=D@6>D>6=DB6=F?8=F=8=F>8=F=8=F=8=F=8=F=8=F=8@F=8>F=8>F?8J7"
DATA "C0@7=0AF=0=7A4>2=3C2>9Q2>1=2=E>6F4=1=2FEU6=7P4BEB6=D>6>D=6=D=6>D@6=D>6"
DATA ">D@6=F?8=F=8=F>8=F=8=F=8=F=8=F=8=F=8@F=8>F=8>F=8=F=8K7A0B7=0?F=0>7>9?3"
DATA ">2=3C2=9Q2=1=2@E=6F9=1=2FE=D=6>D=6=D?6GD=6=D=6=D>6O9=2DEA6>D>6=D@6=D@6"
DATA ">DB6=F?8=F=8=F>8=F=8=F=8=F=8=F=8=F>8?F=8>F=8>F=8=F=8L7?0D7?0?7>4?3>2=3"
DATA "W2>1=2BE=6C4>3=1=2FEV6=7M4=2FEB6=D>6>D=6=D=6>DF6\8]7>4?3>2=3V2=1=2EEC4"
DATA ">3=1=2FE>D=6>D=6>DO6M4IEA6>D>6=D@6=DE6}0>4?3>2=3T2>1=2GEB4>3=1=2FEW6=7"
DATA "K4=2=7IEB6>D=6>D?6>DC6}0>4?3>2=3S2=1=2HE=7B4>3=1=2FEX6K4=1>2JEB6=D>6>D"
DATA "F6}0>4?3>2=3Q2>1=2HED4>3=1=2FEBD=6@D>6>D>6>D=6>D=6?D>6=7K4=1>2KEA6>D>6"
DATA "=D>6=DB6}0>4?3>2=3P2=1=2HE=6E4>3=1=2FEY6L4>1>2JEE6>D=6>D@6}0>4?3>2=3N2"
DATA ">1=2GE?6=7D4>3=1=2FE=D=6LD=6>D=6>D=6=D?6=7M4=1>2KEE6=DB6}0>4?3>2=3M2=1"
DATA "=2FEC6D4>3=1=2FEZ6N4>1=2KEE6>D@6}0>4?3>2=3K2>1=2FE>6>D=6=D>6=7C4>3=1=2"
DATA "FE=D=6HD=6AD=6=D>6>D=6=D>6=7O4=1>2KEI6}0>4?3>2=3J2=1=2FEG6C4>3=1=2FE[6"
DATA "P4>1=2KEH6}0=4@3>2=3H2>1=2FEH6=7B4>3=1=2FE>D=6>D=6>DS6=7O4>3=1>2KEF6}0"
DATA "=4@3>2=3G2=1=2FE>7I6B4>3=1=2FE\6O4?3>1=2LED6}0=4@3>2=3E2>1=2FE?7I6=7A4"
DATA ">3=1=2FE\6=7N4A3=1>2KEC6}0=4@3>2=3D2=1=2FE?7=D=7=D=6>D?6=DB6A4>3=1=2FE"
DATA "A6>D=6=D>6=DA6=D=6=D=6>D?6=DB6M4C3=1>3LEA6}0=4@3>2=3B2>1=2EE=D=7?D=7@D"
DATA "=6=D=6?DA6=7@4>3=1=2FE@6>D=6>D=6?D=6?D=6@D=6=D=6?DA6=7L4D3>1>2KE@6}0=4"
DATA "@3>2=3A2=1=2FEE7J6@4>3=1=2FE^6L4F3>1>2JE?6}0=4@3>2=3?2>1=2FEF7J6=7?4>3"
DATA "=1=2DE=C_6=7J4I3>1=2JE>6}0=4@3>2=3>2=1=2FEI7J6?4>3=1=2DE=C`6J4K3=1>2HE"
DATA ">6}0=4@3>2=3>1=2FEJ7J6=7>4>3=1=2DE=7`6=7I4L3>1=2HE=6}0A3>2>3=2EEL7J6=7"
DATA ">4>3=1=2DE=7`6=7H4O3=1>2GE}0A3>2=1=3=7cE=7>4>3=1=2CE>7`E=7H4P3>1=2FE}0"
DATA "A3=2=1>3=7>E=7`E=7>4>3=1=2BE>7aE=7H4R3=1>2DE}0B3=1?3=E=7aE=7>4>3=1=2>3"
DATA "@E=7bE=7G4T3>1=2CE}0B3=1?3cE=7>4>3=1=2?3=7=E=7cE=7G4V3=1>2AE}0B3=1=2>3"
DATA "cE=7=2=4>3>1A3dE=7=2F4W3>1=2?E=3}0C3=1?3cE=2=4?3=1=2@3eE=2E4Z3=1@3}0C3"
DATA "=1>2=3cE>2@3=1=2@3dE>2D4Z3=2>1>3}0E3g2A3=1=2@3e2C4\3>2>1}0p3>4@3=1@2e3"
DATA "d4>3=2}0r4A3>1C3‹4}0!O4!e0g5!e0g5!e0g5>FH0>F=0>FF0>F=0>FF0>FG0?FG0>FG0"
DATA ">FI0>FG0>Fs0g5>FH0>F=0>FF0>F=0>FE0@FE0>F=0>F=0>FB0@FF0>FH0>FI0>FG0@Fc0"
DATA "g5>FH0>F=0>FE0CFC0BFE0?F=0>FC0@FF0>FH0>FI0>FH0>Fd0g2>FW0>F=0>FD0@FJ0>F"
DATA "E0>FU0>FI0>FG0@FH0>FU0g2>FW0>F=0>FE0?FI0>FF0>FU0>FI0>FW0>FU0g2>FW0>F=0"
DATA ">FF0?FG0>FF0BFR0>FI0>FU0BFS0g2>FV0CFE0@FE0>F=0?FC0>F=0>FS0>FI0>FW0>FU0"
DATA "g5Y0>F=0>FD0BFD0>F=0>F=0>FB0>F=0>FS0>FI0>FW0>FU0g3>FW0>F=0>FE0@FI0?FD0"
DATA "AFR0>FI0>Fr0g3h0>Fp0>FI0>Fr0g3Ÿ0>FG0>Fs0g3!e0g3!e0=3=2=3?2=3=2?3=2=3?2"
DATA "=3=2?3=2=3?2=3=2?3=2=3?2=3=2?3=2=3!e0?2?3C2?3C2?3C2?3C2i0>FF0@FG0>FG0@F"
DATA "F0@FH0>FE0BFE0@FT0=3=2A3=2=3=2=3=2A3=2=3=2=3=2A3=2=3=2=3=2A3=2=3=2=3=2"
DATA "=3i0>FE0>F>0>FD0@FF0>F>0>FD0>F>0>FF0?FE0>FH0>F>0>FS0=2C3?2C3?2C3?2C3?2"
DATA ">3i0>FE0>F>0>FF0>FJ0>FH0>FF0?FE0>FH0>FW0=2C3=2=3=2C3=2=3=2C3=2=3=2C3=2"
DATA "=3=2>3h0>FF0>F>0>FF0>FJ0>FH0>FE0@FE0AFE0>FW0=2C3?2C3?2C3?2C3?2>3h0>FF0"
DATA ">F>0>FF0>FI0>FG0?FF0@FE0>F>0>FD0AFT0=3=2A3=2=3=2=3=2A3=2=3=2=3=2A3=2=3"
DATA "=2=3=2A3=2=3=2=3=2=3J0?FV0>FG0>F>0>FF0>FH0>FJ0>FD0>F=0>FI0>FD0>F>0>FS0"
DATA ">2A3>2=3>2?3=E=7>2=3>2A3>2=3>2A3>2=3>2=3g0>FG0>F>0>FF0>FG0>FK0>FD0BFH0"
DATA ">FD0>F>0>FS0=3=2A3=2?3=2?3>6=C=E=7=3=2A3=2?3=2A3=2?3=2=3f0>FH0>F>0>FF0"
DATA ">FF0>FH0>F>0>FG0>FE0>F>0>FD0>F>0>FS0=3?2=3?2?3?2=EA6=C=E=7=2=3?2?3?2=3"
DATA "?2?3>2=0>FU0>FH0>FI0@FG0>FF0BFE0@FH0>FF0@FF0@FT0J3F6=C=E=7L3>F!c0I3=EI6"
DATA "=C=E=7I3!e0I3N6=C=E=7E3!e0H3=2@6=DM6=E=7B3!e0H3=EA6?DL6=C=7@3!=0AF_0G3"
DATA "=2E6>DM6=7>3BFE0@FF0@FŒ0@FF0?F?0?FC0>FT0G2=EC6=D?6?DJ6=C=7=2@0>FD0>F>0"
DATA ">FD0>F>0>FŠ0>F>0>FE0>FA0>FC0>FT0G2=E?6=D@6?DO6=7?0>FE0>F>0>FD0>F>0>Fc0"
DATA ">FS0>FL0>FD0>F>0@F=0>FA0@FS0F2=EA6?D@6@DL6?0>FE0>F>0>FD0>F>0>FD0>FI0>F"
DATA "I0>FU0>FK0>FD0>F=0>F=0>F=0>FA0@FS0E4=2=E?6=D@6?DA6?DI6>0>FG0@FF0AFa0>F"
DATA "G0BFF0>FI0>FE0>F=0>F=0>F=0>F@0>F>0>FR0E4=EA6?D@6?DA6?DF6>0>FF0>F>0>FH0"
DATA ">F`0>FY0>FG0>FF0>F>0CF@0>F>0>FR0E9E6?D@6?DA6?DC6=0>FG0>F>0>FH0>Fa0>FG0"
DATA "BFF0>FH0>FG0>FH0BFR0D4=2@6=DC6?D@6?DH6=0>FG0>F>0>FD0>F>0>Fb0>FU0>FV0?F"
DATA "F0>F@0>FQ0D4B6?DC6?D@6?DE6=0>FH0@FF0@FE0>FI0>FJ0>FS0>FJ0>FJ0@FB0>F@0>F"
DATA "Q0C4=2@6=D@6?DC6?D@6?DB6t0>F«0C4=EA6?D@6?DC6>DG6!e0B4=2@6=D@6@D?6?DB6?D"
DATA "D6!e0B4=EA6?DA6?D?6?DB6?DA6!e0A4=2E6@D@6?D?6?DG6!e0A4=EI6?D@6?D?6?DD6AF"
DATA "F0AFD0AFE0BFD0BFE0AFD0>F?0>FC0>FK0>FE0>F>0>FD0>FW0@4=2?EJ6?D@6?D?6?DA6"
DATA ">F>0>FD0>F?0>FC0>F>0>FD0>FH0>FH0>F?0>FC0>F?0>FC0>FK0>FE0>F=0>FE0>FW0@4"
DATA "=7BEJ6?D@6?DD6>F>0>FD0>FH0>F?0>FC0>FH0>FH0>FH0>F?0>FC0>FK0>FE0@FF0>FW0"
DATA "@4FEQ6?DA6>F>0>FD0>FH0>F?0>FC0>FH0>FH0>FH0>F?0>FC0>FK0>FE0?FG0>FW0?4=2"
DATA "IEV6AFE0>FH0>F?0>FC0AFE0AFE0>F=0@FC0CFC0>FK0>FE0?FG0>FW0>4=2=7KET6>F>0"
DATA ">FD0>FH0>F?0>FC0>FH0>FH0>F?0>FC0>F?0>FC0>FK0>FE0@FF0>FW0>4=2OEQ6>F>0>F"
DATA "D0>FH0>F?0>FC0>FH0>FH0>F?0>FC0>F?0>FC0>FH0>F=0>FE0>F=0>FE0>FW0=4>2REN6"
DATA ">F>0>FD0>F?0>FC0>F>0>FD0>FH0>FH0>F>0?FC0>F?0>FC0>FH0>F=0>FE0>F>0>FD0>F"
DATA "W0=4=1@2REK6AFF0AFD0AFE0BFD0>FI0BFC0>F?0>FC0>FI0?FF0>F?0>FC0BFS0>4?1?2"
DATA "SEH6!e0A4?1@2REE6!e0B4>3?1@2QEC6!e0A4B3?1@2QE@6!e0A4E3?1@2NE@6!e0@4I3?1"
DATA "@2ME>6>F@0>FB0>F?0>FD0AFD0BFE0AFD0BFE0@FE0BFD0>F?0>FC0>F@0>FB0>FD0>FM0"
DATA "@4L3?1@2LE>F@0>FB0?F>0>FC0>F?0>FC0>F?0>FC0>F?0>FC0>F?0>FC0>F>0>FF0>FF0"
DATA ">F?0>FC0>F@0>FB0>FD0>FM0?4P3@1?2IE?F>0?FB0?F>0>FC0>F?0>FC0>F?0>FC0>F?0"
DATA ">FC0>F?0>FC0>FJ0>FF0>F?0>FD0>F>0>FD0>F>0>F>0>FN0?4T3?1?2FE?F>0?FB0@F=0"
DATA ">FC0>F?0>FC0>F?0>FC0>F?0>FC0>F?0>FC0>FJ0>FF0>F?0>FD0>F>0>FD0>F>0>F>0>F"
DATA "N0>4X3?1?2CEDFB0@F=0>FC0>F?0>FC0BFD0>F?0>FC0BFE0@FG0>FF0>F?0>FD0>F>0>F"
DATA "D0>F>0>F>0>FN0>4[3?1?2>E>3DFB0>F=0@FC0>F?0>FC0>FH0>F?0>FC0>F?0>FG0>FF0"
DATA ">FF0>F?0>FE0@FF0DFO0=4^3?1>2?3>F=0>F=0>FB0>F>0?FC0>F?0>FC0>FH0>F=0@FC0"
DATA ">F?0>FG0>FF0>FF0>F?0>FE0@FF0DFO0J4T3>1?3>F=0>F=0>FB0>F>0?FC0>F?0>FC0>F"
DATA "H0>F>0?FC0>F?0>FC0>F>0>FF0>FF0>F?0>FF0>FH0>F>0>FP0^4A3=2?1>F@0>FB0>F?0"
DATA ">FD0AFD0>FI0AFD0>F?0>FD0@FG0>FG0AFG0>FH0>F>0>FP0g4y0>F¦0g5!e0g5!e0g5!e0"
DATA "g5’0>F0g5>F@0>FB0>F@0>FB0DFB0?FG0>FH0?FH0@FS0>FV0>FW0g2>F@0>FB0>F@0>F"
DATA "H0>FB0>FH0>FI0>FG0>F>0>FS0>FU0>FW0g2=0>F>0>FD0>F>0>FH0>FC0>FH0>FI0>F0"
DATA ">FW0g2>0@FF0@FH0>FD0>FI0>FH0>Fr0@FE0AFT0g2?0>FH0>FH0>FE0>FI0>FH0>Fu0>F"
DATA "D0>F>0>FS0g5>0@FG0>FG0>FF0>FJ0>FG0>Fr0AFD0>F>0>FS0g3=0>F>0>FF0>FF0>FG0"
DATA ">FJ0>FG0>Fq0>F>0>FD0>F>0>FS0g3>F@0>FE0>FE0>FH0>FK0>FF0>Fq0>F>0>FD0>F>0"
DATA ">FS0g3>F@0>FE0>FE0DFB0>FK0>FF0>Fr0AFD0AFT0g3f0>FW0>Fœ0g3f0?FU0?FU0CF|0"
DATA "=3=2=3?2=3=2?3=2=3?2=3=2?3=2=3?2=3=2?3=2=3?2=3=2?3=2=3!e0?2?3C2?3C2?3C2"
DATA "?3C2!e0=3=2A3=2=3=2=3=2A3=2=3=2=3=2A3=2=3=2=3=2A3=2=3=2=3=2=3!e0=2C3?2"
DATA "C3?2C3?2C3?2>3N0>FS0>FU0>FH0>FH0>FH0>FH0>Fe0=2C3=2=3=2C3=2=3=2C3=2=3=2"
DATA "C3=2=3=2>3N0>FR0>FV0>Fd0>FH0>Fe0=2C3?2C3?2C3?2C3?2>3N0>FR0>FV0>Fd0>FH0"
DATA ">Fe0=3=2A3=2=3=2=3=2A3=2=3=2=3=2A3=2=3=2=3=2A3=2=3=2=3=2=3=0@FF0AFE0@F"
DATA "E0?FH0AFD0AFE0>FH0>FH0>F=0>FE0>FH0CFR0>2A3>2=3>2A3>2=3>2A3>2=3>2A3>2=3"
DATA ">2=3>F>0>FD0>F>0>FD0>F>0>FD0>FH0>F>0>FD0?F=0>FD0>FH0>FH0@FF0>FH0>F=0>F"
DATA "=0>FQ0=3=2A3=2?3=2A3=2?3=2A3=2?3=2A3=2?3=2=3>FH0>F>0>FD0BFD0>FH0>F>0>F"
DATA "D0>F>0>FD0>FH0>FH0?FG0>FH0>F=0>F=0>FQ0=3?2=3?2?3?2=3?2?3?2=3?2?3?2=3?2"
DATA "?3>2>FH0>F>0>FD0>FH0>FH0>F>0>FD0>F>0>FD0>FH0>FH0@FF0>FH0>F=0>F=0>FQ0g3"
DATA ">F>0>FD0>F>0>FD0>F>0>FD0>FH0>F>0>FD0>F>0>FD0>FH0>FH0>F=0>FE0>FH0>F=0>F"
DATA "=0>FQ0g3=0@FF0AFE0@FE0>FI0AFD0>F>0>FD0>FH0>FH0>F>0>FD0>FH0>F=0>F=0>FQ0"
DATA "g3x0>F`0>F0g3t0AFa0>F0g3!e0K3Q6=C=E=7@3!e0J2=7T6=C=7>2!Q0@5?0C2B0J2X6"
DATA "=7!Q0@5?0C2B0I2=7?6=D=6=DS60>F{0@5?0C4B0I4?6=D=6=D=6?D=6>D>6=DJ60>F{0"
DATA "@5?0C4B0H4=7Z6AFF0@FE0AFF0AFD0?FH0?FF0?FG0>F>0>FD0>F>0>FD0>F=0>F=0>FB0"
DATA ">F=0>F@0@5?0C9B0H9[6?F=0>FD0>F>0>FD0>F>0>FD0>F>0>FD0>FH0>F=0>FE0>FH0>F"
DATA ">0>FD0>F>0>FD0>F=0>F=0>FB0>F=0>F@0@2?0C4B0G4=7?6MD=6=D=6=D=6=DA6>F>0>F"
DATA "D0>F>0>FD0>F>0>FD0>F>0>FD0>FI0>FG0>FH0>F>0>FE0@FE0DFC0?FA0@2?0C4B0G4\6"
DATA ">F>0>FD0>F>0>FD0>F>0>FD0>F>0>FD0>FJ0>FF0>FH0>F>0>FE0@FE0DFC0?FA0@2?0C4"
DATA "B0F4=7?6ED=6?D=6ED=6=D@6>F>0>FD0>F>0>FD0>F>0>FD0>F>0>FD0>FH0>F=0>FE0>F"
DATA "H0>F=0?FF0>FG0>F>0>FC0>F=0>F@0@2?0C4B0F4]6>F>0>FE0@FE0AFF0AFD0>FI0?FG0"
DATA ">FH0AFF0>FG0>F>0>FC0>F=0>F@0@5?0C4B0E4=7?6=D>6=D=6HD=6BD=6=D@6X0>FL0>F"
DATA "¡0@3?0C4B0E4^6X0>FL0>F¡0@3?0C4B0D4=7?6=D>6>D=6BD=6>D=6?D=6?DD6!Q0@3?0C4"
DATA "B0D4_6!Q0@3?0C4B0C4=7_6Z0>FT0>F—0=7?3?0C4B0C4@6?D=6=D=6?D=6>D=6=D>6>D=6"
DATA "@D=6=D=6=DA6Y0>FG0>FI0>FU0=7I0=7>0=7G0=7>0=7G0=7H0>7B0=E=2=3=2?0C4B0B4"
DATA "=7`6Y0>FG0>FI0>FH0?F=0>FC0=7I0=7>0=7G0=7>0=7F0?7F0=7>0=7>0=7>0=6>2=3?0"
DATA "C4B0B4@6=D=6ED=6>D=6@D>6ADC6Y0>FG0>FI0>FG0>F=0?FD0=7I0=7>0=7F0B7D0=7=0"
DATA "=7=0=7F0>7>0=7?0=6=7>3?0C4B0A4=7a6=0>F=0>FD0AFF0>FG0>FI0>FU0=7X0=7>0=7"
DATA "E0=7=0=7K0=7@0=6=E>3?0C4B0A4@6=D=6@D=6=D>6=D>6?DN6=0>F=0>FG0>FE0>FH0>F"
DATA "J0>FT0=7X0=7>0=7F0>7J0=7A0>6>3?0C4B0@4=7b6=0>F=0>FF0>FG0>FG0>FI0>FU0=7"
DATA "X0=7>0=7G0>7H0=7B0>6=7=3?0C4B0@4c6=0>F=0>FE0>FH0>FG0>FI0>FU0=7W0B7F0=7"
DATA "=0=7F0=7>0>7?0=D>6=3?0C4B0?4=7c6>0?FE0>FI0>FG0>FI0>Fr0=7>0=7E0=7=0=7=0"
DATA "=7E0=7>0=7>0=7>0=D>6=2?0C4B0?4d6>0>FF0AFF0>FG0>FI0>FU0=7X0=7>0=7F0?7J0"
DATA ">7?0=6=D=6=7?0C4B0>4=7d6>0>FV0>FF0>FH0>F‚0=7P0=D>6=7?0B4=3B0>4=7d6?F!N0"
DATA "=D>6=E?0B4=3B0>4=7_EA6!Q0=6=D=6=E?0B4=3B0>4=7bE>6!Q0=6=D=6=E?0B4=3B0>4"
DATA "=7dE!Q0@6?0B4=3B0>4=7dE=0=7H0=7J0=7H0=7’0=7G0?7A0=D?6?0B4=3B0=4=2=7dE=7"
DATA "=0=7G0=7I0=7J0=7H0=7=0=7‚0=7F0=7?0=7@0=D?6?0B4=3B0=4=2eE=7=0=7G0=7I0=7"
DATA "J0=7I0=7ƒ0=7F0=7?0=7@0=6=D>6?0B4=3B0>2cE>3=0=7V0=7J0=7H0=7=0=7I0=7s0=7"
DATA "G0=7?0=7@0=D?6?0B4=3B0c2@3=0=7V0=7J0=7X0=7s0=7G0=7?0=7@0=6=D>6?0B4=3B0"
DATA "=4c2?3=7=0=7=0=7S0=7J0=7V0A7S0>7W0=7H0=7?0=7@0=D?6?0C4B0`4C2=7>0=7T0=7"
DATA "J0=7X0=7r0=7H0=7?0=7@0=D?6?0C4B0g4=7>0=7T0=7J0=7X0=7q0=7I0=7?0=7@0=6=D"
DATA ">6?0C5B0g5=0>7=0=7S0=7J0=7e0=7V0=7I0=7J0?7A0=6=D>6?0C5B0g5X0=7J0=7d0=7"
DATA "|0@6?0C5B0g5Y0=7H0=7¦0@6?0C5B0g5!Q0@6?0C5B0g5!Q0@6?0C2B0g2!Q0@6?0C2B0g2"
DATA ">0=7H0?7G0?7I0=7F0A7F0?7F0A7F0?7G0?7]0@6?0C2B0g2?7G0=7?0=7E0=7?0=7G0>7"
DATA "F0=7I0=7?0=7I0=7E0=7?0=7E0=7?0=7\0@6?0C2B0g2>0=7K0=7I0=7G0>7F0=7I0=7L0"
DATA "=7F0=7?0=7E0=7?0=7\0@6?0C5B0g5>0=7K0=7I0=7F0=7=0=7F0@7F0=7L0=7F0=7?0=7"
DATA "E0=7?0=7E0=7J0=7C0=E?6?0C3B0g3>0=7J0=7H0>7G0=7=0=7F0=7?0=7E0@7H0=7H0?7"
DATA "G0@7\0=E?6?0C3B0g3>0=7I0=7K0=7E0=7>0=7J0=7E0=7?0=7G0=7G0=7?0=7I0=7\0=E"
DATA "?6?0C3B0g3>0=7H0=7L0=7E0A7I0=7E0=7?0=7F0=7H0=7?0=7I0=7\0>E>6?0C3B0g3>0"
DATA "=7G0=7I0=7?0=7H0=7F0=7?0=7E0=7?0=7F0=7H0=7?0=7E0=7?0=7\0?E=6?0C3B0g3>0"
DATA "=7G0A7F0?7I0=7G0?7G0?7G0=7I0?7G0?7F0=7J0=7C0?E=6?0>3=2=3?2B0=3=2=3?2=3"
DATA "=2?3=2=3?2=3=2?3=2=3?2=3=2?3=2=3?2=3=2?3=2=3!H0=7D0?E=6?0@2?3B0?2?3C2?3"
DATA "C2?3C2?3C2!Q0@E?0=2=3=2@3B0=3=2A3=2=3=2=3=2A3=2=3=2=3=2A3=2=3=2=3=2A3=2"
DATA "=3=2=3=2=3!Q0@E?0>2A3B0=2C3?2C3?2C3?2C3?2>3!Q0@E?0=3=2A3B0=2C3=2=3=2C3"
DATA "=2=3=2C3=2=3=2C3=2=3=2>3!Q0@E?0>2A3B0=2C3?2C3?2C3?2C3?2>3g0?7I0@7F0=7F0"
DATA "@7G0@7E0@7F0A7E0A7@0@E?0=2=3=2@3B0=3=2A3=2=3=2=3=2A3=2=3=2=3=2A3=2=3=2"
DATA "=3=2A3=2=3=2=3=2=3f0=7?0=7F0>7@0>7D0=7F0=7?0=7E0=7@0=7D0=7?0=7E0=7I0=7"
DATA "D0@E?0=3>2@3B0>2A3>2=3>2A3>2=3>2A3>2=3>2A3>2=3>2=3?0=7T0=7M0=7F0=7B0=7"
DATA "C0=7=0=7E0=7?0=7E0=7I0=7@0=7D0=7I0=7D0@E?0>3=2@3B0=3=2A3=2?3=2A3=2?3=2"
DATA "A3=2?3=2A3=2?3=2=3>0=7V0=7L0=7E0=7?0?7>0=7B0=7=0=7E0=7?0=7E0=7I0=7@0=7"
DATA "D0=7I0=7D0=3?E?0>3?2=3=2B0=3?2=3?2?3?2=3?2?3?2=3?2?3?2=3?2?3>2=0=7H0A7"
DATA "G0=7J0=7F0=7>0=7>0=7>0=7A0=7?0=7D0@7F0=7I0=7@0=7D0@7F0@7A0@3?0C3B0g3=7"
DATA "Z0=7H0=7G0=7>0=7>0=7>0=7A0=7?0=7D0=7?0=7E0=7I0=7@0=7D0=7I0=7D0=2?3?0C3"
DATA "B0g3=0=7H0A7G0=7I0=7G0=7?0>7=0?7A0A7D0=7?0=7E0=7I0=7@0=7D0=7I0=7D0=1=2"
DATA ">3?0C3B0g3>0=7V0=7W0=7H0=7A0=7C0=7?0=7E0=7@0=7D0=7?0=7E0=7I0=7D0=3=1>2"
DATA "?0C3B0g3?0=7T0=7K0=7H0>7G0=7A0=7C0@7G0@7E0@7F0A7E0=7D0=4?3?0C3B0g3w0A7"
DATA "‘0?4=3?0C3B0K3Q6=C=E=7@3!Q0@4?0C2B0J2=7T6=C=7>2!Q0@5?0C2B0J2X6=7!Q0@5?0"
DATA "C2B0I2=7?6=D=6=DS6!Q0@5?0C4B0I4?6=D=6=D=6?D=6>D>6=DJ6=0@7E0=7@0=7D0=7L0"
DATA "=7F0=7?0=7E0=7I0=7A0=7C0=7@0=7E0@7E0A7F0@7@0@5?0C4B0H4=7Z6=7@0=7D0=7@0"
DATA "=7D0=7L0=7F0=7>0=7F0=7I0=7A0=7C0>7?0=7D0=7@0=7D0=7@0=7D0=7@0=7?0@5?0C9"
DATA "B0H9[6=7I0=7@0=7D0=7L0=7F0=7=0=7G0=7I0>7?0>7C0>7?0=7D0=7@0=7D0=7@0=7D0"
DATA "=7@0=7?0@2?0?4@3B0G4=7?6MD=6=D=6=D=6=DA6=7I0=7@0=7D0=7L0=7F0>7H0=7I0>7"
DATA "?0>7C0=7=0=7>0=7D0=7@0=7D0=7@0=7D0=7@0=7?0@2?0?4@3B0G4\6=7>0?7D0B7D0=7"
DATA "L0=7F0>7H0=7I0=7=0=7=0=7=0=7C0=7=0=7>0=7D0=7@0=7D0A7E0=7@0=7?0@2?0?4@3"
DATA "B0F4=7?6ED=6?D=6ED=6=D@6=7@0=7D0=7@0=7D0=7L0=7F0=7=0=7G0=7I0=7=0=7=0=7"
DATA "=0=7C0=7>0=7=0=7D0=7@0=7D0=7I0=7@0=7?0@2?0?4@3B0F4]6=7@0=7D0=7@0=7D0=7"
DATA "I0=7>0=7F0=7>0=7F0=7I0=7>0=7>0=7C0=7?0>7D0=7@0=7D0=7I0=7>0=7=0=7?0@5?0"
DATA "?4@3B0E4=7?6=D>6=D=6HD=6BD=6=D@6=7?0>7D0=7@0=7D0=7I0=7>0=7F0=7?0=7E0=7"
DATA "I0=7>0=7>0=7C0=7?0>7D0=7@0=7D0=7I0=7?0>7?0@3?0?4@3B0E4^6=0?7=0=7D0=7@0"
DATA "=7D0=7J0>7G0=7@0=7D0A7E0=7A0=7C0=7@0=7E0@7E0=7J0@7@0@3?0?4@3B0D4=7?6=D"
DATA ">6>D=6BD=6>D=6?D=6?DD6!M0=7?0@3?0>4A3B0D4_6!Q0@3?0>4A3B0C4=7_6!Q0@3?0>4"
DATA "A3B0C4@6?D=6=D=6?D=6>D=6=D>6>D=6@D=6=D=6=DA6!Q0=3=2=3=2?0>4A3B0B4=7`6!Q0"
DATA "?2=3?0>4A3B0B4@6=D=6ED=6>D=6@D>6ADC6A7F0?7F0A7E0=7@0=7D0=7A0=7C0=7E0=7"
DATA "?0=7A0=7C0=7A0=7C0C7C0>7H0=7D0=3=2>3?0>4A3B0A4=7a6=7@0=7D0=7?0=7G0=7G0"
DATA "=7@0=7D0=7A0=7C0=7E0=7?0=7A0=7C0=7A0=7I0=7C0=7I0=7D0=2?3?0>4A3B0A4@6=D"
DATA "=6@D=6=D>6=D>6?DN6=7@0=7D0=7K0=7G0=7@0=7E0=7?0=7E0=7?0=7?0=7A0=7?0=7E0"
DATA "=7?0=7I0=7D0=7I0=7D0=2?3?0>4A3B0@4=7b6=7@0=7D0=7K0=7G0=7@0=7E0=7?0=7E0"
DATA "=7?0=7?0=7B0=7=0=7G0=7=0=7I0=7E0=7J0=7C0=2?3?0=4B3B0@4c6A7F0?7H0=7G0=7"
DATA "@0=7E0=7?0=7E0=7?0=7?0=7C0=7I0=7I0=7F0=7J0=7C0=3=2>3?0=4B3B0?4=7c6=7@0"
DATA "=7H0=7G0=7G0=7@0=7F0=7=0=7G0=7=0=7=0=7=0=7C0=7=0=7H0=7H0=7G0=7K0=7B0>2"
DATA ">3?0=4B3B0?4d6=7@0=7H0=7G0=7G0=7@0=7F0=7=0=7G0=7=0=7=0=7=0=7B0=7?0=7G0"
DATA "=7G0=7H0=7K0=7B0=3=2>3?0=4B3B0>4=7d6=7@0=7D0=7?0=7G0=7G0=7@0=7G0=7I0=7"
DATA "?0=7B0=7A0=7F0=7F0=7I0=7L0=7A0=3?2?0=4B3B0>4=7d6=7@0=7E0?7H0=7H0@7H0=7"
DATA "I0=7?0=7B0=7A0=7F0=7F0C7C0=7L0=7A0@3?0=4B3B0>4=7_EA6º0=7R0@3?0=4B3B0>4"
DATA "=7bE>6º0>7Q0@3?0=4B3B0>4=7dE!Q0=E?3?0C3B0>4=7dE!Q0=E=7>3?0C3B0=4=2=7dE"
DATA "L0=7!@0=6=E>3?0C3B0=4=2eE>7I0=7=0=7T0=7W0=7[0=7T0=7Q0>6=7=2?0C3B0>2cE>3"
DATA "=0=7H0=7?0=7T0=7V0=7[0=7S0=7R0>6=E=2?0C3B0c2@3=0=7€0=7[0=7S0=7R0>6=E=7"
DATA "?0C4B0=4c2?3=0=7s0?7F0@7G0?7G0@7F0?7F0>7I0@7@0>6=E=7?0C4B0`4C2=0=7v0=7"
DATA "E0=7?0=7E0=7?0=7E0=7?0=7E0=7?0=7E0=7I0=7?0=7@0?6=7?0C4B0g4=0=7s0@7E0=7"
DATA "?0=7E0=7I0=7?0=7E0A7E0=7I0=7?0=7@0?6=7x0=7r0=7?0=7E0=7?0=7E0=7I0=7?0=7"
DATA "E0=7I0=7I0=7?0=7@0?6=7x0=7r0=7?0=7E0=7?0=7E0=7?0=7E0=7?0=7E0=7?0=7E0=7"
DATA "I0=7?0=7@0?6=7?0j5G0=7s0@7E0@7G0?7G0@7F0?7F0=7J0@7@0?6=7?0j5G0=7!J0=7@0"
DATA "?6=7?0j5F0>7V0B7¦0@7A0?6=7?0j5![0?6=7?0j5![0?6=7?0j2![0?6=7?0j2F0=7I0=7"
DATA "I0=7I0=7I0=7˜0?6=7?0j2F0=7e0=7I0=7˜0?6=7?0j2F0=7e0=7I0=7˜0?6=7?0j5F0=7"
DATA "=0>7F0=7I0=7I0=7>0=7F0=7I0?7=0>7D0=7=0>7G0?7F0@7G0@7E0>7C0?6=7?0j3F0>7"
DATA ">0=7E0=7I0=7I0=7=0=7G0=7I0=7>0=7>0=7C0>7>0=7E0=7?0=7E0=7?0=7E0=7?0=7E0"
DATA "=7D0?6=7?0j3F0=7?0=7E0=7I0=7I0>7H0=7I0=7>0=7>0=7C0=7?0=7E0=7?0=7E0=7?0"
DATA "=7E0=7?0=7E0=7D0=E>6=7?0j3F0=7?0=7E0=7I0=7I0=7=0=7G0=7I0=7>0=7>0=7C0=7"
DATA "?0=7E0=7?0=7E0=7?0=7E0=7?0=7E0=7D0>E=6=7?0j3F0=7?0=7E0=7I0=7I0=7>0=7F0"
DATA "=7I0=7>0=7>0=7C0=7?0=7E0=7?0=7E0=7?0=7E0=7?0=7E0=7D0>E=6=7?0j3F0=7?0=7"
DATA "E0=7I0=7I0=7?0=7E0=7I0=7>0=7>0=7C0=7?0=7F0?7F0@7G0@7E0=7D0?E=7?0?2=3=2"
DATA "?3=2=3?2=3=2?3=2=3?2=3=2?3=2=3?2=3=2?3=2=3?2=3=2=3b0=70=7M0=7N0?E=7?0"
DATA "?3C2?3C2?3C2?3C2?3?2b0=70=7M0=7N0?E=7?0@3=2=3=2=3=2A3=2=3=2=3=2A3=2=3"
DATA "=2=3=2A3=2=3=2=3=2A3=2=3![0?E=7?0A3?2C3?2C3?2C3?2C3=2![0?E=7?0A3=2=3=2"
DATA "C3=2=3=2C3=2=3=2C3=2=3=2C3=2¸0=7U0=7D0?E=7?0A3?2C3?2C3?2C3?2C3=2·0=7H0"
DATA "=7J0=7C0?E=7?0@3=2=3=2=3=2A3=2=3=2=3=2A3=2=3=2=3=2A3=2=3=2=3=2A3=2=3T0"
DATA "=7ž0=7H0=7J0=7C0?E=7?0@3>2=3>2A3>2=3>2A3>2=3>2A3>2=3>2A3>2T0=7ž0=7H0=7"
DATA "J0=7C0=E>3=7?0@3=2?3=2A3=2?3=2A3=2?3=2A3=2?3=2A3=2=3G0>7G0>7H0=7?0=7E0"
DATA "=7?0=7E0=7>0=7>0=7C0=7>0=7G0=7>0=7E0@7G0=7H0=7J0=7C0=2?3?0=2=3?2?3?2=3"
DATA "?2?3?2=3?2?3?2=3?2?3?2=3?2=3F0=7>0=7F0=7I0=7?0=7E0=7?0=7E0=7>0=7>0=7C0"
DATA "=7>0=7G0=7>0=7H0=7F0=7I0=7K0=7B0>2>3?0j3G0=7H0=7I0=7?0=7F0=7=0=7F0=7=0"
DATA "=7=0=7=0=7D0>7H0=7>0=7G0=7H0=7H0=7J0=7C0>1>3?0j3H0=7G0=7I0=7?0=7F0=7=0"
DATA "=7F0=7=0=7=0=7=0=7D0>7H0=7>0=7F0=7I0=7H0=7J0=7C0@3?0j3F0=7>0=7F0=7I0=7"
DATA ">0>7G0=7H0=7?0=7D0=7>0=7H0>7F0=7J0=7H0=7J0=7C0@3?0j3G0>7H0=7I0>7=0=7G0"
DATA "=7H0=7?0=7D0=7>0=7H0=7G0@7G0=7H0=7J0=7C0@4?0j3œ0=7W0=7G0=7I0=7K0A3=7=E"
DATA "S6L3š0>7‚0?2=7V6=7K2!b0=2=7>E>6?D=6@D=6=D=6=D=6=D=6CD?6K2!b0=7?E=6=DU6"
DATA "=7I2=5!b0=7?E>6@D>6?D=6?D=6>D>6>D=6?D>6J4T0?8G0?8E0=8E0=8C0?8G0?8A0=8F0"
DATA "?8=0=8G0=8?0?8A0=8A0=8>0=8W0=7=E=C=EX6=7I4G0>7>0=7D0=8=0=8G0=8=0=8E0=8"
DATA "E0=8C0=8=0=8G0=8=0=8A0=8F0=8K0=8?0=8=0=8A0=8A0=8>0=8W0=7>C=E>6>D=6>D=6"
DATA "=D?6GD=6=D=6=D>6I9F0=7>0>7E0=8=0=8=0=8=0=8=0?8?0=8?0?8=0?8=0>8=0>8=0?8"
DATA "=0=8=0?8?0=8=0=8=0?8=0?8?0=8?0?8=0=8=0?8=0>8?0=8?0=8=0=8=0=8=0?8=0?8?0"
DATA "=8=0=8=0?8=0=8=0?8=0>8=0>8=0?8R0=7>C=E=6=DW6=7H4T0>8>0=8=0=8=0=8=0=8?0"
DATA "=8?0=8=0=8=0=8=0=8=0=8>0=8>0=8=0=8=0=8=0=8A0?8=0=8=0=8=0=8=0=8?0=8?0=8"
DATA "=0=8=0=8=0=8=0=8=0=8@0>8>0=8=0=8=0=8=0=8=0=8=0=8=0=8?0?8?0=8=0=8=0=8=0"
DATA "=8=0=8>0=8>0=8=0=8R0=7>C=E>6?D=6>D=6>DO6H4T0=8=0=8=0=8=0=8=0=8=0=8?0=8"
DATA "?0=8=0=8=0=8=0=8=0=8>0=8>0=8=0=8=0=8=0?8?0=8?0?8=0=8=0=8?0=8?0=8=0=8=0"
DATA "=8=0=8=0=8=0=8@0=8?0=8>0=8>0?8=0=8=0=8?0=8?0?8=0=8=0?8=0=8>0=8>0?8R0=7"
DATA ">C=E=6=DX6=7G4T0=8=0=8=0=8=0=8=0=8=0=8?0=8=0=8=0=8=0=8=0=8=0=8=0=8>0=8"
DATA ">0=8=0=8=0=8?0=8?0=8?0=8?0=8=0=8?0=8=0=8=0=8=0=8=0=8=0=8=0=8=0=8@0=8?0"
DATA "=8=0=8=0=8=0=8?0=8=0=8?0=8?0=8=0=8=0=8=0=8?0=8>0=8>0=8T0=7>C=E[6G4T0=8"
DATA "=0=8=0?8=0=8=0=8?0?8=0?8=0=8=0=8=0>8=0=8>0?8=0=8=0?8?0=8?0?8=0=8=0=8?0"
DATA "?8=0?8=0=8=0?8=0=8@0=8?0=8=0=8=0=8=0?8=0?8?0=8?0?8=0=8=0?8=0>8=0>8=0?8"
DATA "R0=7>C=E>6CD=6@D>6>D>6>D=6>D=6?D>6=7F4!b0=7>C=E=6=DZ6F4!b0=7>C=E?6=D=6"
DATA "LD=6>D=6>D=6=D?6=7E4T0?8=0=8S0=8?0=8C0>8K0=8H0>8J0?8J0=8=0=8E0=8V0=7>C"
DATA "=E]6E4T0=8=0=8=0=8S0=8?0=8C0=8=0=8V0=8=0=8J0=8=0=8J0=8G0=8V0=7>C=E>6>D"
DATA "=6HD=6AD=6=D>6>D=6=D>6=7D4T0=8?0?8=0?8=0?8=0?8=0?8=0?8=0?8=0=8=0?8?0=8"
DATA "=0=8=0>8=0?8=0=8=0=8=0=8=0=8=0?8=0?8?0=8=0=8=0>8=0?8=0?8?0=8?0?8=0?8=0"
DATA ">8=0?8=0=8=0?8=0?8=0>8=0?8=0?8M0=7>C=E^6D4T0=8?0=8=0=8?0=8=0=8=0=8=0=8"
DATA "=0=8=0=8=0=8?0=8=0=8=0=8=0=8=0=8=0=8?0=8=0=8=0=8@0=8=0=8=0=8=0=8=0=8=0"
DATA "=8=0=8=0=8=0=8?0?8=0=8>0=8=0=8?0=8?0=8?0=8=0=8=0=8=0=8=0=8>0=8=0=8=0=8"
DATA "=0=8=0=8?0=8=0=8>0=8=0=8=0=8O0=7>C=E?6>D=6>D=6>DS6=7C4T0=8?0=8=0=8=0?8"
DATA "=0=8=0=8=0=8=0=8=0?8=0?8=0=8=0=8=0=8=0?8?0=8=0=8=0=8>0?8=0=8=0=8=0=8=0"
DATA "=8=0=8=0=8=0=8=0=8?0=8=0=8=0=8>0?8=0?8?0=8?0=8=0=8=0=8=0=8=0=8>0=8=0=8"
DATA "=0=8=0=8=0=8=0?8=0=8>0?8=0?8M0=7>C=E>6=D\6C4T0=8=0=8=0=8=0=8=0=8=0=8=0"
DATA "=8=0=8=0=8=0=8=0=8?0=8=0=8=0=8=0=8=0=8=0=8A0=8=0=8=0=8>0=8=0=8=0=8=0=8"
DATA "=0=8=0=8=0=8=0=8=0=8=0=8?0=8=0=8=0=8>0=8?0=8=0=8?0=8=0=8=0=8=0=8=0=8=0"
DATA "=8=0=8>0=8=0=8=0=8=0=8=0=8=0=8=0=8=0=8>0=8A0=8M0=7>C=E_6=7B4T0?8=0=8=0"
DATA "=8=0?8=0=8=0=8=0?8=0?8=0?8=0?8=0=8=0?8?0>8>0=8>0?8>0=8=0=8>0=8=0=8=0=8"
DATA "=0?8?0=8=0=8=0=8>0?8=0?8?0?8=0?8=0?8=0=8>0?8=0=8=0=8=0=8=0?8=0>8=0?8=0"
DATA "?8M0=7>C=ED6>D=6=D>6=DA6=D=6=D=6>D?6=DB6B4f0=8j0=8ˆ0=7>C>EB6>D=6>D=6?D"
DATA "=6?D=6@D=6=D=6?DA6=7A4d0>8i0>8‰0=7>C>E`6A4T0?8C0=8E0?8C0?8C0=8=0=8C0?8"
DATA "C0?8C0?8C0?8C0?8m0=7>C>E`6=7@4T0=8=0=8C0=8G0=8E0=8C0=8=0=8C0=8E0=8G0=8"
DATA "C0=8=0=8C0=8=0=8m0=7>C>Ea6@4T0=8=0=8C0=8G0=8E0=8C0=8=0=8C0=8E0=8G0=8C0"
DATA "=8=0=8C0=8=0=8m0=7=E=C>Ea6=7?4T0=8=0=8C0=8E0?8C0?8C0?8C0?8C0?8D0=8D0?8"
DATA "C0?8m0=7=E=C>Ea6=7?4T0=8=0=8C0=8E0=8G0=8E0=8E0=8C0=8=0=8D0=8D0=8=0=8E0"
DATA "=8m0=7=E=C>E=6`E=7?4T0=8=0=8C0=8E0=8G0=8E0=8E0=8C0=8=0=8D0=8D0=8=0=8E0"
DATA "=8m0=7eE=7?4T0?8C0=8E0?8C0?8E0=8C0?8C0?8D0=8D0?8C0?8m0=7eE=7?4!b0=7eE=7"
DATA "?4!b0=7eE=7=2>4!b0=3fE=2>4!b0?3dE>2=4!b0B3c2=4!b0=3A2c3=4!b0E3a4!b0j4#1B2#0"

SUB DrawBOX (x, y, xx, yy, FlipFLOP)
Colr1 = 15: Colr2 = 8
IF FlipFLOP THEN Colr1 = 8: Colr2 = 15
LINE (x, y)-(xx, yy), 7, BF
LINE (x, y)-(xx, yy), Colr1, B
LINE (xx, y)-(xx, yy), Colr2
LINE (x, yy)-(xx, yy), Colr2
END SUB

SUB Interval (Length!)
StartTIME! = TIMER
DO
IF TIMER < StartTIME! THEN EXIT DO
LOOP WHILE TIMER < StartTIME! + Length!
END SUB

SUB PrintSTRING (x, y, Prnt$, Font)

Offset = Font * 4700 '3 fonts in 1 array with 4700 offset
FOR n = 1 TO LEN(Prnt$)
Char$ = MID$(Prnt$, n, 1)
IF Char$ = " " OR Char$ = CHR$(255) THEN
x = x + 3'FontBOX(Offset + 1)
ELSE
Index = (ASC(Char$) - 33) * FontBOX(Offset) + 2 + Offset
PUT (x, y), FontBOX(Index)
x = x + FontBOX(Index)
END IF
NEXT n

END SUB
