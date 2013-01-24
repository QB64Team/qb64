CHDIR ".\samples\thebob\kong"

'K2.BAS: Creates graphics files for KONG.BAS, -chained by K1.BAS
'---------------------------------------------------------------
DEFINT A-Z
DECLARE SUB SaveINSTR (FileNAME$)
DECLARE SUB HighLIGHT (x1%, y1%, x2%, y2%, Colr%)
DECLARE SUB PrintSTRING (x, y, Prnt$)
DECLARE SUB SaveBUILDING (x, UpSET, Building)

DIM SHARED Box(1 TO 26000)
DIM SHARED FontBOX(5000)
SCREEN 12
GOSUB Instructions
GOSUB Buildings
GOSUB TitleBAR
GOSUB WinBOXES
GOSUB ControlPANEL
GOSUB DrawSCREEN

CLS
OUT &H3C8, 7
OUT &H3C9, 63
OUT &H3C9, 32
OUT &H3C9, 0
LINE (5, 5)-(634, 474), 6, B
LINE (8, 8)-(631, 471), 6, B
LINE (200, 180)-(439, 290), 6, B
LINE (197, 177)-(442, 293), 6, B
PrintSTRING 254, 212, "The graphics files for KONG"
PrintSTRING 243, 226, "have been successfully created."
PrintSTRING 246, 250, "You can now run the program."

a$ = INPUT$(1)
END

TitleBAR:
LINE (0, 300)-(639, 340), 1, BF
FOR x = -6 TO 660 STEP 21
    LINE (x, 309)-(x + 18, 331), 2, BF
NEXT x
FOR x = -1 TO 660 STEP 7
    LINE (x, 302)-(x + 2, 306), 10, BF
    LINE (x, 306)-(x + 2, 306), 2
    LINE (x, 334)-(x + 2, 338), 10, BF
    LINE (x, 338)-(x + 2, 338), 2
NEXT x
LINE (0, 300)-(639, 300), 2
LINE (0, 340)-(639, 340), 10
FOR x = 140 TO 498
    FOR y = 0 TO 18
        IF POINT(x, y) <> 0 THEN
            IF y > 9 THEN Colr = 8 ELSE Colr = 15
            PSET (x, y + 314), 10
            PSET (x, y + 311), Colr
        END IF
    NEXT y
NEXT x
PrintSTRING 20, 216, "Instructions"
PrintSTRING 595, 216, "EXIT"
FOR x = 20 TO 620
    FOR y = 216 TO 230
        IF y > 222 THEN Colr = 8 ELSE Colr = 15
        IF POINT(x, y) <> 0 THEN PSET (x, y + 100), Colr
        PSET (x, y), 0
    NEXT y
NEXT x
RETURN

ControlPANEL:
LINE (0, 446)-(639, 479), 7, BF
LINE (0, 446)-(639, 446), 9
PSET (115, 446), 7
DRAW "U10 E4 R399 F4 D10 L407 BE6 P7,7"
PSET (115, 446), 9
DRAW "U10 c15 E4 c9R399 C6 F4 D10"
PSET (0, 435), 7
DRAW "R52 F4 D10 L56 BE4 P7,7"
PSET (0, 435), 9
DRAW "R52 c6 F4 D6"
PSET (639, 435), 7
DRAW "L52 G4 D10 R56 BH4 P7,7"
PSET (639, 435), 9
DRAW "L52 c15 G4 c9 D6"
PSET (215, 432), 7
DRAW "U10 E4 R199 F4 D10 L207 BE5 P7,7"
PSET (215, 432), 9
DRAW "U10 c15 E4 R199 c6 F4 D10"
PSET (5, 440), 4
DRAW "R42 F3 D8 R70 U11 E3 R97 U11 E3 R191"
DRAW "F3 D11 R97 F3 D11 R70 U8 E3 R42 D20 L628 U20 bF4 P4,4"
FOR y = 424 TO 460 STEP 5
    FOR x = 5 TO 634
        IF POINT(x, y) = 4 THEN PSET (x, y), 8
        IF POINT(x, y - 1) = 4 THEN PSET (x, y - 1), 6
    NEXT x
NEXT y
FOR y = 424 TO 460
    FOR x = 4 TO 634
        IF POINT(x, y) = 4 THEN PSET (x, y), 7
    NEXT x
NEXT y
'Banana Button
LINE (305, 424)-(334, 450), 7, BF
LINE (305, 424)-(334, 451), 9, B
LINE (334, 424)-(334, 450), 6
LINE (309, 428)-(330, 446), 1, BF
LINE (309, 428)-(330, 446), 2, B
LINE (309, 446)-(330, 446), 10
LINE (330, 428)-(330, 446), 10
LINE (305, 451)-(334, 451), 10
LINE (305, 425)-(305, 451), 8
FOR x = 0 TO 16
    FOR y = 0 TO 16
        IF POINT(x, y) <> 0 THEN
            PSET (x + 312, y + 432), 10
            PSET (x + 312, y + 430), POINT(x, y)
        END IF
    NEXT y
NEXT x
'Transfer KONG
FOR x = 198 TO 256
    FOR y = 0 TO 18
        IF y > 9 THEN Colr = 8 ELSE Colr = 15
        IF POINT(x, y) <> 0 THEN
            PSET (x - 141, y + 452), 10
            PSET (x - 141, y + 450), Colr
        END IF
    NEXT y
NEXT x
'Transfer YOUNG
FOR x = 424 TO 500
    FOR y = 0 TO 18
        IF y > 9 THEN Colr = 8 ELSE Colr = 15
        IF POINT(x, y) <> 0 THEN
            PSET (x + 92, y + 452), 10
            PSET (x + 92, y + 450), Colr
        END IF
    NEXT y
NEXT x
'Player LED's
LINE (70, 470)-(100, 477), 8, B
LINE (70, 470)-(70, 477), 6
LINE (70, 470)-(100, 470), 6
LINE (72, 472)-(98, 475), 10, B
LINE (98, 472)-(98, 475), 8
LINE (72, 475)-(98, 475), 8
GET (70, 470)-(100, 477), Box()
PUT (537, 470), Box(), PSET
'Slider grooves
LINE (359, 469)-(489, 475), 7, BF
LINE (359, 472)-(489, 472), 10
LINE (359, 471)-(489, 473), 9, B
LINE (359, 471)-(359, 473), 6
LINE (359, 471)-(489, 471), 6
'Get/place slider grooves
GET (354, 462)-(494, 479), Box()
LINE (354, 462)-(494, 479), 7, BF
PUT (135, 442), Box(), PSET
PUT (364, 442), Box(), PSET
GET (245, 442)-(274, 456), Box()
PUT (227, 442), Box(), PSET
LINE (256, 442)-(272, 456), 7, BF
PrintSTRING 185, 462, "Force"
PrintSTRING 436, 462, "Angle"
FOR x = 140 TO 500
    FOR y = 462 TO 478
        IF y > 468 THEN Colr = 9 ELSE Colr = 15
        IF POINT(x, y) <> 7 THEN PSET (x, y), Colr
    NEXT y
NEXT x
FOR x = 146 TO 246 STEP 5
    LINE (x, 446)-(x, 449), 8
    LINE (x, 456)-(x, 459), 8
NEXT x
GET (365, 440)-(380, 460), Box()
LINE (365, 440)-(395, 460), 7, BF
PUT (394, 440), Box(), PSET
FOR x = 404 TO 494 STEP 5
    LINE (x, 446)-(x, 449), 8
    LINE (x, 456)-(x, 459), 8
NEXT x
LINE (255, 442)-(278, 460), 7, BF
LINE (255, 442)-(276, 460), 10, BF
LINE (255, 442)-(276, 460), 9, B
LINE (255, 442)-(276, 442), 6
LINE (255, 442)-(255, 460), 6
PrintSTRING 260, 446, "00"
LINE (362, 442)-(385, 460), 7, BF
LINE (364, 442)-(385, 460), 10, BF
LINE (364, 442)-(385, 460), 9, B
LINE (364, 442)-(364, 460), 6
LINE (364, 442)-(385, 442), 6
PrintSTRING 369, 446, "00"
'Transfer Cupola
FOR x = 61 TO 95
    FOR y = 48 TO 74
        IF POINT(x, y) <> 0 THEN
            PSET (x - 52, y + 360), POINT(x, y)
            PSET (690 - x, y + 360), POINT(x, y)
        END IF
    NEXT y
NEXT x
CIRCLE (123, 440), 5, 4
PAINT STEP(0, 0), 4
CIRCLE STEP(0, 0), 5, 9
PAINT STEP(0, 0), 7, 9
CIRCLE STEP(0, 0), 5, 6, 3.1, 0
CIRCLE (513, 440), 5, 4
PAINT STEP(0, 0), 4
CIRCLE STEP(0, 0), 5, 9
PAINT STEP(0, 0), 7, 9
CIRCLE STEP(0, 0), 5, 6, 3.1, 0
CIRCLE (223, 426), 5, 4
PAINT STEP(0, 0), 4
CIRCLE STEP(0, 0), 5, 9
PAINT STEP(0, 0), 7, 9
CIRCLE STEP(0, 0), 5, 6, 3.1, 0
CIRCLE (413, 426), 5, 4
PAINT STEP(0, 0), 4
CIRCLE STEP(0, 0), 5, 9
PAINT STEP(0, 0), 7, 9
CIRCLE STEP(0, 0), 5, 6, 3.1, 0
LINE (290, 461)-(350, 477), 9, B
LINE (350, 461)-(350, 477), 6
LINE (290, 477)-(350, 477), 6
LINE (290, 478)-(350, 478), 10
LINE (290, 461)-(290, 477), 8
'Score boxes
LINE (12, 444)-(42, 474), 0, BF
LINE (12, 444)-(42, 474), 9, B
LINE (12, 444)-(12, 474), 6
LINE (12, 444)-(42, 444), 6
LINE (597, 444)-(627, 474), 0, BF
LINE (597, 444)-(627, 474), 9, B
LINE (597, 444)-(597, 474), 6
LINE (597, 444)-(627, 444), 6
GET (438, 20)-(452, 38), Box()
PUT (19, 450), Box()
PUT (604, 450), Box()
FOR x = 0 TO 639
    FOR y = 362 TO 404
        IF POINT(x, y) = 0 THEN PSET (x, y), 12
    NEXT y
NEXT x
PrintSTRING 298, 464, "NO WIND"
FOR x = 298 TO 342
    FOR y = 465 TO 473
        IF y > 469 THEN Colr = 9 ELSE Colr = 15
        IF POINT(x, y) <> 7 THEN PSET (x, y), Colr
    NEXT y
NEXT x
GET (298, 465)-(342, 473), Box()
DEF SEG = VARSEG(Box(1))
BSAVE "kongwind.bsv", VARPTR(Box(1)), 240
DEF SEG
DIM SliderBOX(1 TO 440)
DEF SEG = VARSEG(SliderBOX(1))
BLOAD "kongsldr.bsv", VARPTR(SliderBOX(1))
DEF SEG
GET (141, 443)-(151, 461), SliderBOX(281)
GET (489, 443)-(499, 461), SliderBOX(361)
DEF SEG = VARSEG(SliderBOX(1))
BSAVE "kongsldr.bsv", VARPTR(SliderBOX(1)), 880
DEF SEG
RETURN

DrawSCREEN:
GET (16, 47)-(56, 87), Box(25000)
GET (0, 300)-(639, 340), Box()
LINE (0, 0)-(639, 350), 0, BF
LINE (0, 0)-(639, 43), 7, BF
LINE (0, 44)-(639, 44), 10
PUT (0, 1), Box(), PSET
PUT (299, 70), Box(25000), PSET
PrintSTRING 2, 46, "Freeware - Copyright 2005 by Bob Seguin"
PrintSTRING 497, 46, "email: BOBSEG@sympatico.ca"
FOR x = 0 TO 639
    FOR y = 46 TO 58
        IF POINT(x, y) <> 0 THEN PSET (x, y), 2
    NEXT y
NEXT x

PSET (0, 154), 12
DRAW "r7 U24 R35 NU20 R30 F20 D20 R30 F20 D30 R5 U50 R20 NU20 R20 D60"
DRAW "R5 U30 R5 U4 R20 NU20 R20 D4 R5 D20 R4 U30 R3 U40 R3"
DRAW "U3ru3ru3ru3ru3ru3r2Nu20R2D3rd3rd3rd3rd3rd3r3d40r3d20R4"
DRAW "U30 R30d20r3U60r3u4r25nu12r25d4r3d80r5U30r15Nu12r15d30r5u50r30d40"
DRAW "r5U30 r6U2r34nu12r34d2r6d30r4u20r20d20r5U30e12r20U18e23r"
DRAW "r12nu12r22d108L639U81bfp12,12"
LINE (0, 235)-(639, 400), 12, BF
CIRCLE (605, 198), 200, 12, 2.8, 3.2
CIRCLE (235, 198), 200, 12, 0, .34
LINE (416, 123)-(424, 136), 12, BF
LINE (419, 100)-(421, 125), 12, BF
LINE (420, 80)-(420, 100), 12
PAINT STEP(0, 40), 12

PSET (0, 390), 10
DRAW "R10 U10 R100 D5 R10 U10 R80 D30 R20 U20 R60 U8rd8r62 D10"
DRAW "R80 U20 LU10R20 U6lu2r16d2ld6r60d10ld10r118d26L639"
DRAW "U14 BF4 P10,10"
FOR y = 401 TO 440
    FOR x = 0 TO 639
        IF POINT(x, y) = 0 THEN PSET (x, y), 10
    NEXT x
NEXT y
PAINT (60, 396), 10
PAINT (460, 396), 10
GET (80, 340)-(539, 400), Box()
PUT (80, 345), Box(), PSET
RANDOMIZE 123
FOR Reps = 1 TO 48
    x = FIX(RND * 640)
    y = FIX(RND * 60) + 45
    IF POINT(x, y) = 0 THEN PSET (x, y), 7
NEXT Reps
FOR x = 0 TO 639
    FOR y = 362 TO 404
        IF POINT(x, y) <> 10 THEN PSET (x, y), 0
    NEXT y
NEXT x
GET (0, 362)-(639, 404), Box() '7000
FOR x = 0 TO 639
    FOR y = 362 TO 404
        IF POINT(x, y) = 0 THEN PSET (x, y), 15 ELSE PSET (x, y), 0
    NEXT y
NEXT x
FOR x = 45 TO 595
    FOR y = 430 TO 460
        IF POINT(x, y) = 0 THEN PSET (x, y), 10
    NEXT y
NEXT x
GET (0, 362)-(639, 404), Box(7000) 'Get foreground building mask
PUT (0, 362), Box(), PSET
LINE (80, 410)-(88, 422), 5, BF
LINE (80, 410)-(88, 418), 3, BF
LINE (180, 410)-(188, 422), 0, BF
LINE (480, 390)-(488, 402), 5, BF
LINE (480, 390)-(488, 394), 3, BF
LINE (460, 390)-(468, 402), 0, BF
LINE (440, 412)-(448, 424), 0, BF
GET (0, 362)-(639, 404), Box() '7000 'Get/Save foreground buildings
DEF SEG = VARSEG(Box(1))
BSAVE "kongfbld.bsv", VARPTR(Box(1)), 28000
DEF SEG
LINE (0, 340)-(639, 404), 12, BF
PUT (0, 362), Box(7000), AND
PUT (0, 362), Box()

'Get/Save main screen
FileCOUNT = 0
DEF SEG = VARSEG(Box(1))
FOR y = 0 TO 320 STEP 160
    GET (0, y)-(639, y + 159), Box()
    FileCOUNT = FileCOUNT + 1
    FileNAME$ = "kongscr" + LTRIM$(STR$(FileCOUNT)) + ".bsv"
    BSAVE FileNAME$, VARPTR(Box(1)), 52000
NEXT y
DEF SEG
RETURN

Buildings:
'Government building?
PSET (97, 200), 11
DRAW "E16 R33 F16 L65 R32 BU2 P11,11"
FOR x = 102 TO 159 STEP 4
    FOR y = 184 TO 200
        IF POINT(x, y) = 11 THEN PSET (x, y), 3
    NEXT y
NEXT x
PSET (97, 200), 3
DRAW "E16 R33 U3 L33 D3 BE P11,3 BG C3 R33 F16 L67 D3 R69 U3 L30 BD P11,3"
LINE (90, 204)-(169, 208), 7, BF
LINE (90, 204)-(169, 204), 8
LINE (60, 200)-(68, 212), 3, B
LINE (61, 201)-(67, 211), 1, BF
LINE (61, 201)-(67, 211), 7, B
LINE (61, 206)-(67, 206), 7
GET (60, 200)-(68, 212), Box()
PUT (60, 200), Box()
FOR x = 112 TO 140 STEP 14
    PUT (x, 191), Box(), PSET
NEXT x
PSET (130, 180), 7
DRAW "U20 C15 d"
FOR x = 114 TO 146 STEP 2
    LINE (x, 177)-(x, 180), 6
    PSET (x, 177), 8
    IF x < 146 THEN PSET (x + 1, 179), 6
NEXT x
FlagDATA:
DATA 1,2,3,2,2,2,3,4,5,4,3,2
RESTORE FlagDATA
FOR x = 129 TO 119 STEP -1
    READ Down
    LINE (x, 162 + Down)-(x, 168 + Down), 4
NEXT x
LINE (90, 210)-(169, 479), 7, BF
FOR y = 210 TO 470 STEP 2
    LINE (95, y)-(164, y), 6
NEXT y
RANDOMIZE 145678
FOR y = 220 TO 420 STEP 20
    FOR x = 99 TO 157 STEP 11
        LINE (x - 1, y)-(x + 7, y + 12), 7, BF
        IF FIX(RND * 12) = 0 THEN
            Colr1 = 3: Colr2 = 5
        ELSE
            Colr1 = 1: Colr2 = 2
        END IF
        LINE (x + 1, y + 1)-(x + 5, y + 12), Colr1, BF
        LINE (x + 1, y + 3)-(x + 5, y + 12), Colr2, BF
        LINE (x, y + 13)-(x + 6, y + 13), 8
        LINE (x, y + 7)-(x + 5, y + 7), 7
    NEXT x
NEXT y
GET (80, 150)-(180, 479), Box()
PUT (80, 146), Box(), PSET
SaveBUILDING 90, 24, 1

'Modern building
LINE (300, 200)-(379, 204), 6, BF
LINE (300, 205)-(379, 479), 7, BF
PSET (321, 195), 2
DRAW "E4 R30 F4 L38 R10 BU P2,2"
PSET (321, 195), 8
DRAW "E4 ND4 R5 ND4 R5 ND4 R5 ND4 R5 ND4 R5 ND4 R5 ND4 F4 L38"
LINE (321, 195)-(359, 199), 8, BF
CIRCLE (308, 200), 6, 6, 0, 3.14
PAINT STEP(0, -1), 6
PSET STEP(0, -4), 8
CIRCLE (372, 200), 6, 6, 0, 3.14
PAINT STEP(0, -1), 6
PSET STEP(0, -4), 8
FOR x = 300 TO 379
    FOR y = 194 TO 197
        IF POINT(x, y) = 6 THEN PSET (x, y), 2
    NEXT y
NEXT x
LINE (300, 200)-(379, 204), 7, BF
LINE (300, 200)-(379, 200), 8
LINE (300, 205)-(379, 206), 10, B
LINE (317, 184)-(317, 199), 7
PSET STEP(0, -15), 8
LINE (363, 184)-(363, 199), 7
PSET STEP(0, -15), 8
FOR y = 210 TO 440 STEP 16
    LINE (300, y)-(379, y + 8), 2, BF
    LINE (300, y)-(379, y + 3), 1, BF
    LINE (300, y + 8)-(379, y + 8), 8
    FOR x = 305 TO 379 STEP 14
        LINE (x, y)-(x, y + 8), 7
    NEXT x
NEXT y
SaveBUILDING 300, 0, 2 '*************************************************

'Hotel --------------------------------------------------------------------
LINE (400, 200)-(479, 479), 3, BF
LINE (420, 195)-(459, 199), 6, BF
LINE (420, 195)-(459, 195), 7
LINE (460, 174)-(460, 199), 7
LINE (454, 176)-(464, 176), 7
LINE (457, 177)-(467, 177), 7
PSET (454, 176), 9
LINE (410, 192)-(414, 199), 6, BF
LINE (410, 192)-(414, 192), 7
LINE (465, 192)-(469, 199), 6, BF
LINE (465, 192)-(469, 192), 7
FOR x = 421 TO 454 STEP 4
    FOR y = 186 TO 193 STEP 3
        LINE (x, y)-(x + 4, y + 3), 6, B
    NEXT y
NEXT x
PrintSTRING 425, 162, "HOTEL"
FOR x = 425 TO 500
    FOR y = 162 TO 174
        IF POINT(x, y) <> 0 THEN PSET (x, y + 20), 4
        PSET (x, y), 0
    NEXT y
NEXT x
GET (100, 50)-(111, 76), Box()
FOR x = 404 TO 468 STEP 15
    PUT (x, 215), Box(), PSET
NEXT x
GET (100, 54)-(111, 76), Box()
FOR x = 404 TO 464 STEP 15
    PUT (x, 248), Box(), PSET
    IF x = 419 THEN
        FOR xx = x TO x + 12
            FOR yy = 248 TO 267
                IF POINT(xx, yy) = 2 THEN PSET (xx, yy), 5
            NEXT yy
        NEXT xx
    END IF
NEXT x
FOR x = 404 TO 464 STEP 15
    FOR y = 290 TO 479 STEP 32
        PUT (x, y), Box(), PSET
        IF FIX(RND * 12) = 2 THEN
            LINE (x + 2, y + 8)-(x + 9, y + 15), 1, BF
            LINE (x + 2, y + 16)-(x + 9, y + 16), 7
            LINE (x + 2, y + 17)-(x + 9, y + 17), 10
        END IF
        IF FIX(RND * 15) = 0 THEN
            FOR xx = x TO x + 12
                FOR yy = y TO y + 19
                    IF POINT(xx, yy) = 2 THEN PSET (xx, yy), 5
                NEXT yy
            NEXT xx
        END IF
    NEXT y
NEXT x
GET (88, 84)-(93, 91), Box()
FOR x = 401 TO 480 STEP 5
    PUT (x, 200), Box(), PSET
    PUT (x, 276), Box(), PSET
NEXT x
LINE (480, 200)-(484, 310), 0, BF
LINE (395, 200)-(399, 310), 0, BF
FOR y = 202 TO 479 STEP 2
    FOR x = 400 TO 480
        IF POINT(x, y) = 3 THEN PSET (x, y), 1
    NEXT x
NEXT y
GET (478, 200)-(478, 210), Box()
PUT (479, 200), Box(), PSET
PUT (400, 200), Box(), PSET
PUT (479, 276), Box(), PSET
PUT (400, 276), Box(), PSET
SaveBUILDING 400, 0, 3 '*************************************************

'Buff Apartment Block -------------------------------------------------------
GET (608, 44)-(619, 67), Box()
GET (621, 44)-(632, 67), Box(500)
LINE (500, 200)-(579, 479), 11, BF
FOR x = 504 TO 574 STEP 15
    FOR y = 216 TO 460 STEP 32
        IF FIX(RND * 6) = 0 THEN
            PUT (x, y), Box(500), PSET
        ELSE
            PUT (x, y), Box(), PSET
        END IF
        LINE (500, y + 27)-(579, y + 27), 9
        LINE (500, y + 28)-(579, y + 28), 8
    NEXT y
NEXT x
LINE (500, 200)-(579, 204), 7, BF
LINE (500, 200)-(579, 200), 9
LINE (500, 205)-(579, 205), 10
LINE (520, 189)-(559, 199), 11, BF
LINE (520, 189)-(559, 192), 7, BF
LINE (520, 189)-(559, 189), 9
LINE (520, 193)-(559, 193), 6
PSET (539, 188), 8
DRAW "U16 C14 D"
SaveBUILDING 500, 0, 4 '*************************************************

'Factory --------------------------------------------------------------------
LINE (0, 150)-(639, 479), 0, BF
LINE (100, 200)-(179, 479), 3, BF
CIRCLE (120, 220), 10, 15, , , .85
CIRCLE (120, 219), 12, 15, , , .83
LINE (105, 222)-(135, 240), 3, BF
GET (120, 206)-(150, 230), Box()
PUT (119, 206), Box(), PSET
PSET (110, 217), 3
PSET (129, 217), 3
LINE (129, 220)-(129, 228), 15
LINE (110, 220)-(110, 228), 15
DRAW "R19"
LINE (110, 236)-(129, 252), 15, B
PSET (108, 220), 15
DRAW "D34 R23 U34"
PAINT (119, 220), 2, 15
PAINT (119, 244), 2, 15
FOR x = 100 TO 140
    FOR y = 200 TO 260
        IF POINT(x, y) = 15 THEN PSET (x, y), 1
    NEXT y
NEXT x
FOR x = 120 TO 140
    FOR y = 216 TO 260
        IF POINT(x, y) = 1 THEN PSET (x, y), 11
    NEXT y
NEXT x
LINE (111, 228)-(120, 228), 11
LINE (111, 236)-(129, 236), 1
LINE (111, 252)-(129, 252), 11
LINE (109, 254)-(129, 254), 11
LINE (124, 213)-(124, 227), 1
LINE (115, 213)-(115, 227), 1
LINE (111, 219)-(129, 219), 1
LINE (115, 236)-(115, 251), 1
LINE (124, 236)-(124, 251), 1
LINE (111, 244)-(129, 244), 1

GET (120, 205)-(133, 256), Box()
PUT (118, 205), Box(), PSET
GET (106, 229)-(131, 253), Box()
FOR y = 254 TO 450 STEP 25
    PUT (106, y), Box(), PSET
NEXT y
GET (106, 202)-(132, 470), Box()
LINE (106, 202)-(132, 470), 3, BF
FOR x = 102 TO 158 STEP 25
    PUT (x, 202), Box(), PSET
NEXT x
FOR y = 255 TO 455 STEP 50
    LINE (100, y)-(179, y + 3), 3, BF
    LINE (100, y)-(179, y), 11
    LINE (100, y + 3)-(179, y + 3), 1
NEXT y
LINE (100, 230)-(104, 234), 3, BF
LINE (100, 230)-(104, 230), 11
LINE (100, 234)-(104, 234), 1
GET (100, 230)-(104, 234), Box()
FOR x = 100 TO 175 STEP 25
    FOR y = 230 TO 430 STEP 50
        PUT (x, y), Box(), PSET
    NEXT y
NEXT x
LINE (120, 190)-(159, 199), 3, BF
LINE (120, 190)-(159, 193), 6, BF
LINE (120, 190)-(159, 190), 7
LINE (120, 194)-(159, 194), 10
LINE (100, 200)-(179, 204), 6, BF
LINE (100, 200)-(179, 200), 7
LINE (100, 205)-(179, 205), 10

FOR y = 180 TO 479 STEP 2
    FOR x = 100 TO 179
        IF POINT(x, y) = 3 THEN PSET (x, y), 6
    NEXT x
NEXT y

FOR Reps = 1 TO 30
    x = FIX(RND * 80) + 100
    y = FIX(RND * 280) + 200
    Colr = FIX(RND * 3)
    SELECT CASE Colr
        CASE 0: Colr = 6
        CASE 1: Colr = 7
        CASE 2: Colr = 8
    END SELECT
    FOR xx = x - 6 TO x + 6
        FOR yy = y - 6 TO y + 6
            IF POINT(xx, yy) = 2 THEN PSET (xx, yy), Colr
        NEXT yy
    NEXT xx
NEXT Reps
PrintSTRING 212, 184, "B-Bomb Mfg"
FOR x = 204 TO 280
    FOR y = 184 TO 196
        IF POINT(x, y) <> 0 THEN PSET (x - 100, y), 4
        PSET (x, y), 0
    NEXT y
NEXT x
FOR x = 208 TO 270 STEP 5
    FOR y = 185 TO 194 STEP 3
        LINE (x, y)-(x + 5, y + 4), 2, B
    NEXT y
NEXT x
FOR x = 208 TO 275
    FOR y = 178 TO 200
        IF POINT(x, y) <> 0 THEN
            IF POINT(x - 101, y + 1) <> 4 THEN PSET (x - 101, y + 1), 6
            PSET (x, y), 0
        END IF
    NEXT y
NEXT x
SaveBUILDING 100, 0, 5 '*************************************************

'Apescape building -------------------------------------------------------------
LINE (200, 200)-(279, 479), 8, BF
LINE (210, 180)-(269, 299), 8, BF
LINE (220, 180)-(259, 180), 9
LINE (207, 200)-(272, 200), 9
CIRCLE (209, 209), 10, 0, 3.14159 * .5, 3.14159
PAINT (201, 201), 0
CIRCLE (270, 209), 10, 0, 0, 3.14159 * .5
PAINT (278, 201), 0
CIRCLE (219, 190), 10, 0, 3.14159 * .5, 3.14159
PAINT (211, 181), 0
CIRCLE (260, 190), 10, 0, 0, 3.14159 * .5
PAINT (268, 181), 0
FOR x = 203 TO 277 STEP 4
    FOR y = 180 TO 479
        IF POINT(x, y) = 8 THEN PSET (x, y), 7
        IF POINT(x + 1, y) = 8 THEN PSET (x + 1, y), 7
    NEXT y
NEXT x
FOR x = 206 TO 270 STEP 10
    FOR y = 220 TO 460 STEP 36
        LINE (x, y)-(x + 7, y + 26), 8, BF
        LINE (x + 1, y + 1)-(x + 6, y + 22), 2, BF
        LINE (x + 1, y + 1)-(x + 6, y + 6), 1, BF
    NEXT y
NEXT x
LINE (239, 158)-(239, 179), 8
PSET (236, 162), 4
PSET (242, 162), 4
FOR x = 217 TO 260 STEP 8
    LINE (x, 190)-(x + 4, 198), 2, BF
    LINE (x, 190)-(x + 4, 193), 1, BF
NEXT x
PSET (200, 205), 6
PSET (205, 200), 6
PSET (210, 186), 6
PSET (215, 181), 6
PSET (219, 180), 8
PSET (218, 180), 7

PSET (279, 205), 6
PSET (274, 200), 6
PSET (269, 186), 6
PSET (264, 181), 6

PSET (260, 180), 8
PSET (261, 180), 7

GET (200, 180)-(279, 214), Box()
PUT (200, 176), Box(), PSET
GET (200, 180)-(279, 214), Box()
PUT (200, 175), Box(), PSET
LINE (206, 200)-(273, 200), 9
LINE (206, 193)-(206, 200), 6
LINE (273, 193)-(273, 200), 6
LINE (214, 175)-(265, 175), 9
LINE (212, 203)-(267, 216), 8, BF
LINE (212, 217)-(267, 217), 6
LINE (212, 203)-(267, 203), 9
PrintSTRING 217, 203, "apescape"
FOR x = 217 TO 267
    FOR y = 203 TO 217
        IF POINT(x, y) = 15 THEN PSET (x, y), 1
    NEXT y
NEXT x
SaveBUILDING 200, 26, 6

'Tenement building ---------------------------------------------------------
LINE (200, 150)-(279, 479), 0, BF
RANDOMIZE 4
CIRCLE (220, 198), 10, 2, 0, 3.14159
CIRCLE (259, 198), 10, 2, 0, 3.14159
CIRCLE (220, 198), 7, 2, 0, 3.14159
CIRCLE (259, 198), 7, 2, 0, 3.14159
LINE (207, 198)-(210, 198), 2: DRAW "bl3D3r6u3"
LINE (230, 198)-(233, 198), 2: DRAW "D3l6u3"
LINE (246, 198)-(249, 198), 2: DRAW "bl3D3r6u3"
LINE (269, 198)-(272, 198), 2: DRAW "D3l6u3"
CIRCLE (182, 166), 35, 2, 5.3, 6
CIRCLE (297, 166), 35, 2, 3.42, 4.16
LINE (215, 176)-(264, 176), 2
PSET (200, 195), 2
DRAW "D4 R7 BR26 R12 BR27 R7 U4 l10 Bl20 l18 Bl20 l11"
PAINT (240, 190), 1, 2
PAINT (240, 197), 1, 2
PAINT (202, 197), 1, 2
PAINT (277, 197), 1, 2
FOR y = 168 TO 195 STEP 2
    FOR x = 200 TO 279
        IF POINT(x, y) = 1 THEN PSET (x, y), 2
    NEXT x
NEXT y
PAINT (220, 190), 1, 2
PAINT (259, 190), 1, 2
LINE (215, 176)-(264, 176), 7
CIRCLE (220, 198), 10, 7, .5, 2.64159
CIRCLE (259, 198), 10, 7, .5, 2.64159
PSET (200, 195), 7
DRAW "bD4 bR7 BR26 bR12 bBR27 bR7 bU4 l9 Bl22 l17 Bl22 l9"
FOR x = 215 TO 263 STEP 2
    PSET (x, 174), 7
    PSET (x, 175), 6
NEXT x
LINE (213, 198)-(227, 198), 2
PAINT (220, 197), 1, 2
CIRCLE (220, 195), 1, 8
LINE (215, 198)-(225, 217), 2, B
LINE (216, 199)-(224, 216), 1, BF
LINE (216, 199)-(224, 216), 6, B
LINE (220, 199)-(220, 211), 6: DRAW "nL3nR3"
PAINT (220, 215), 10, 6
CIRCLE (220, 199), 7, 10, .14, 3, 1.1
LINE (217, 200)-(219, 201), 10, B
LINE (221, 200)-(223, 201), 10, B
LINE (214, 218)-(226, 218), 7
GET (210, 190)-(230, 220), Box()
PUT (249, 190), Box(), PSET
PSET (200, 200), 10: DRAW "R6 D2 R6 BR16 R6 U2 R11 D2 R6 BR16 R6 U2 R6"
FOR x = 200 TO 279
    FOR y = 200 TO 479 STEP 2
        IF POINT(x, y) = 0 THEN PSET (x, y), 3
        IF POINT(x, y + 1) = 0 THEN PSET (x, y + 1), 1
    NEXT y
NEXT x
LINE (236, 202)-(243, 212), 2, B
PAINT (238, 210), 7, 2
LINE (237, 203)-(242, 211), 6, B
LINE (237, 207)-(242, 207), 6
PAINT (238, 206), 3, 6
PAINT (238, 208), 5, 6
LINE (235, 213)-(244, 213), 7
LINE (238, 204)-(241, 204), 10
LINE (202, 230)-(220, 234), 10, BF
LINE (218, 230)-(220, 254), 10, BF
LINE (259, 230)-(279, 234), 10, BF
LINE (200, 228)-(279, 229), 2, B
LINE (200, 229)-(201, 254), 2, B
LINE (278, 229)-(279, 254), 2, B
LINE (207, 232)-(212, 242), 6, B
LINE (208, 233)-(211, 233), 10
LINE (200, 245)-(220, 254), 2, B
PAINT (210, 235), 7, 6
PAINT (210, 235), 3, 6
LINE (207, 237)-(212, 237), 6
PAINT (210, 238), 5, 6
LINE (208, 233)-(211, 233), 10
LINE (200, 244)-(220, 254), 2, B
LINE (202, 244)-(220, 244), 7
LINE (202, 252)-(218, 253), 10, BF
FOR x = 202 TO 218 STEP 2
    LINE (x, 245)-(x, 254), 2
NEXT x
LINE (226, 232)-(236, 246), 1, BF
LINE (226, 232)-(236, 246), 6, B
LINE (226, 239)-(236, 239), 6
LINE (225, 247)-(237, 247), 7
FOR x = 200 TO 239
    FOR y = 200 TO 279
        PSET (479 - x, y), POINT(x, y)
    NEXT y
NEXT x
GET (200, 228)-(279, 258), Box()
FOR y = 224 TO 450 STEP 32
    PUT (200, y), Box(), PSET
    IF FIX(RND * 12) = 0 THEN
        PAINT (230, y + 6), 3, 6
        PAINT (230, y + 14), 5, 6
    END IF
    IF FIX(RND * 2) = 0 THEN
        PAINT (249, y + 6), 3, 6
        PAINT (249, y + 14), 5, 6
    END IF
    IF FIX(RND * 5) = 0 THEN
        PAINT (210, y + 8), 1, 6
        PAINT (210, y + 11), 7, 6
    END IF
    IF FIX(RND * 2) = 0 THEN
        PAINT (269, y + 8), 1, 6
        PAINT (269, y + 11), 7, 6
    END IF
    LINE (227, y + 5)-(235, y + 5), 10
    LINE (244, y + 5)-(252, y + 5), 10
    LINE (268, y + 5)-(271, y + 5), 10
    LINE (208, y + 5)-(211, y + 5), 10
NEXT y
SaveBUILDING 200, 25, 7

'Balcony Apartment ----------------------------------------------------------
LINE (0, 150)-(400, 479), 0, BF
GET (118, 50)-(133, 76), Box()
PUT (118, 250), Box()
LINE (300, 200)-(379, 479), 4, BF
GET (118, 240)-(133, 260), Box()
PUT (118, 246), Box(), PSET
GET (118, 256)-(133, 276), Box(6000)
PUT (218, 256), Box(6000)
FOR x = 218 TO 233
    FOR y = 256 TO 276
        IF POINT(x, y) = 1 OR POINT(x, y) = 10 THEN PSET (x, y), 3
        IF POINT(x, y) = 2 THEN PSET (x, y), 5
    NEXT y
NEXT x
GET (219, 257)-(232, 276), Box(5000)
FOR x = 304 TO 360 STEP 18
    IF x = 340 THEN x = 360
    PUT (x, 212), Box(6000), PSET
NEXT x
GET (118, 50)-(133, 76), Box()
PUT (341, 212), Box(), PSET
GET (340, 224)-(359, 235), Box()
PUT (340, 230), Box(), PSET
LINE (329, 242)-(368, 243), 9, B
LINE (329, 232)-(368, 243), 8, B
FOR x = 330 TO 368 STEP 2
    LINE (x, 232)-(x, 242), 8
NEXT x
LINE (300, 242)-(328, 243), 8, BF
LINE (369, 242)-(379, 243), 8, BF
LINE (300, 244)-(379, 244), 6
FOR x = 301 TO 379 STEP 18
    IF x = 355 THEN x = 357
    LINE (x, 214)-(x + 3, 228), 8, BF
    FOR y = 216 TO 226 STEP 2
        LINE (x + 1, y)-(x + 2, y), 7
    NEXT y
NEXT x
GET (300, 212)-(379, 244), Box()
FOR y = 212 TO 440 STEP 38
    PUT (300, y), Box(), PSET
NEXT y
LINE (300, 200)-(379, 204), 8, BF
LINE (300, 200)-(379, 200), 9
LINE (300, 205)-(379, 205), 6
LINE (320, 188)-(359, 199), 11, BF
LINE (319, 188)-(360, 190), 8, BF
LINE (320, 191)-(359, 191), 10
FOR x = 300 TO 379
    FOR y = 200 TO 479
        IF POINT(x, y) = 4 THEN PSET (x, y), 11
    NEXT y
NEXT x
FOR y = 188 TO 478 STEP 2
    FOR x = 300 TO 379
        IF POINT(x, y) = 11 THEN PSET (x, y), 3
    NEXT x
NEXT y
PSET (363, 199), 7
DRAW "U24 C15 D"
FOR x = 305 TO 360 STEP 18
    IF x = 341 THEN x = 361
    FOR y = 213 TO 440 STEP 38
        IF FIX(RND * 10) = 0 THEN PUT (x, y), Box(5000), PSET
        LINE (329, 232)-(368, 232), 15
    NEXT y
NEXT x
FOR y = 232 TO 470 STEP 38
    LINE (329, y)-(368, y), 15
NEXT y
SaveBUILDING 300, 0, 8
LINE (0, 150)-(639, 479), 0, BF
RETURN

SetPALETTE:
DATA 0, 4, 16, 0, 10, 21, 0, 16, 32, 32, 10, 0
DATA 63, 0, 0, 63, 32, 0, 18, 18, 24, 30, 30, 37
DATA 42, 42, 50, 55, 55, 63, 0, 0, 0, 43, 27, 19
DATA 8, 8, 21, 0, 63, 21, 63, 63, 21, 63, 63, 63

RESTORE SetPALETTE
OUT &H3C8, 0
FOR n = 1 TO 48
    READ Intensity
    OUT &H3C9, Intensity
NEXT n
RETURN

WinBOXES:
GET (140, 0)-(256, 18), Box()
GET (376, 0)-(500, 18), Box(5000)
GET (520, 0)-(580, 18), Box(10000)
PUT (198, 200), Box()
PUT (320, 200), Box(10000)
PrintSTRING 220, 223, "To play again, press ENTER"
PrintSTRING 219, 236, "Press any other key to EXIT"
FOR x = 174 TO 400
    FOR y = 192 TO 254
        IF y > 210 THEN Colr = 8 ELSE Colr = 15
        IF y > 222 THEN Colr = 9
        IF POINT(x, y) = 0 THEN PSET (x, y), 1 ELSE PSET (x, y), Colr
    NEXT y
NEXT x
FOR y = 224 TO 200 STEP -1
    FOR x = 174 TO 400
        IF POINT(x, y - 2) <> 1 AND POINT(x, y) = 1 THEN PSET (x, y), 10
    NEXT x
NEXT y
LINE (176, 194)-(398, 252), 6, B
LINE (174, 192)-(400, 254), 6, B
GET (174, 192)-(400, 254), Box()
LINE (170, 188)-(404, 258), 8, BF
LINE (170, 188)-(404, 258), 15, B
LINE (170, 258)-(404, 258), 10
LINE (404, 188)-(404, 258), 10
PUT (174, 192), Box(), PSET
GET (170, 188)-(404, 258), Box()
DEF SEG = VARSEG(Box(1))
BSAVE "kongwink.bsv", VARPTR(Box(1)), 9000
DEF SEG
LINE (177, 197)-(394, 222), 1, BF
PUT (196, 200), Box(5000)
PUT (324, 200), Box(10000)
FOR y = 224 TO 200 STEP -1
    FOR x = 190 TO 382
        IF y > 210 THEN Colr = 8 ELSE Colr = 15
        IF POINT(x, y - 2) <> 1 THEN PSET (x, y - 2), Colr
    NEXT x
NEXT y
FOR y = 224 TO 200 STEP -1
    FOR x = 174 TO 400
        IF POINT(x, y - 2) <> 1 AND POINT(x, y) = 1 THEN PSET (x, y), 10
    NEXT x
NEXT y
GET (196, 200)-(386, 220), Box()
PUT (195, 200), Box(), PSET
GET (170, 188)-(404, 258), Box()
PUT (170, 188), Box()
DEF SEG = VARSEG(Box(1))
BSAVE "kongwiny.bsv", VARPTR(Box(1)), 9000
DEF SEG
RETURN

Instructions:
LINE (192, 160)-(447, 310), 8, BF
LINE (192, 160)-(447, 310), 15, B
LINE (192, 310)-(447, 310), 10
LINE (447, 160)-(447, 310), 10
LINE (202, 164)-(436, 305), 1, BF
LINE (202, 164)-(436, 305), 6, B
LINE (204, 166)-(434, 303), 6, B
LINE (400, 175)-(424, 187), 7, BF
PrintSTRING 216, 176, "INSTRUCTIONS"
PrintSTRING 216, 194, "The object of the game is to be the first"
PrintSTRING 216, 206, "player to achieve a score of 3. You gain"
PrintSTRING 216, 218, "1"
PrintSTRING 225, 218, "point each time you blow up the other"
PrintSTRING 216, 230, "player's gorilla with an exploding banana."
PrintSTRING 216, 248, "Unless playing the computer, begin by"
PrintSTRING 216, 260, "deciding which player will control which"
PrintSTRING 216, 272, "gorilla, then click the"
PrintSTRING 340, 272, "button to begin."
PrintSTRING 216, 284, "The starting gorilla is chosen at random."
FOR x = 207 TO 431
    FOR y = 167 TO 295
        IF y < 194 THEN Colr = 9 ELSE Colr = 8
        IF y < 181 THEN Colr = 15
        IF POINT(x, y) <> 1 THEN PSET (x, y), Colr
    NEXT y
NEXT x
HighLIGHT 354, 206, 362, 217, 9
HighLIGHT 216, 218, 222, 229, 9
PSET (404, 184), 6
DRAW "U6 R12 U2 F5 G5 U2 L12 BE2 P6,6"
LINE (321, 275)-(332, 281), 8, BF
LINE (321, 282)-(332, 282), 10
LINE (323, 278)-(330, 278), 1: DRAW "NH2G2"
SaveINSTR "kongins1.bsv"
LINE (205, 193)-(433, 295), 1, BF
PrintSTRING 216, 194, "When a player's gorilla is the thrower,"
PrintSTRING 216, 206, "the LED will be green under his name (and"
PrintSTRING 216, 218, "he'll be holding a banana). Click on the"
PrintSTRING 216, 230, "Angle slider and drag it to adjust the initial"
PrintSTRING 216, 242, "throwing angle (0 degrees is a horizontal"
PrintSTRING 216, 254, "throw in the other gorilla's direction). Set"
PrintSTRING 216, 266, "the Force slider in the same way. To toss"
PrintSTRING 216, 278, "the banana, click the Banana button"
PrintSTRING 410, 278, "."
HighLIGHT 216, 194, 434, 295, 8
HighLIGHT 234, 206, 254, 217, 9
HighLIGHT 216, 230, 244, 241, 9
HighLIGHT 236, 266, 264, 277, 9
HighLIGHT 322, 278, 360, 299, 9
LINE (204, 166)-(434, 303), 6, B
GET (99, 80)-(109, 90), Box()
PUT (397, 279), Box(), PSET
SaveINSTR "kongins2.bsv"
LINE (205, 193)-(433, 295), 1, BF
PrintSTRING 216, 194, "Be sure to check the Wind arrow (bottom"
PrintSTRING 216, 206, "center of the screen). The arrow shows both"
PrintSTRING 216, 218, "the direction and strength of the wind (the"
PrintSTRING 216, 230, "longer the arrow, the stronger the wind). A"
PrintSTRING 216, 242, "strong opposing wind can actually blow the"
PrintSTRING 216, 254, "banana backwards if the Force of the toss"
PrintSTRING 216, 266, "isn't strong enough!"
PrintSTRING 348, 282, "Good Luck!"
HighLIGHT 216, 194, 434, 295, 8
HighLIGHT 320, 194, 348, 205, 9
HighLIGHT 348, 282, 420, 294, 15
LINE (400, 175)-(424, 187), 15, BF
LINE (400, 182)-(424, 187), 9, BF
PSET (406, 177), 4
DRAW "F8rH8rF8rH8rF8 BU8 G8lE8lG8lE8lG8"
FOR x = 400 TO 424
    FOR y = 175 TO 187
        IF POINT(x, y) <> 15 AND POINT(x, y) <> 9 THEN PSET (x, y), 6
    NEXT y
NEXT x
LINE (204, 166)-(434, 303), 6, B
SaveINSTR "kongins3.bsv"
PUT (192, 160), Box()
LINE (180, 194)-(400, 270), 7, BF
LINE (180, 194)-(400, 270), 9, B
LINE (180, 270)-(400, 270), 6
LINE (400, 194)-(400, 270), 6
LINE (194, 198)-(384, 266), 1, BF
LINE (196, 200)-(382, 264), 6, B
PrintSTRING 238, 208, "Click Your Preference"
PrintSTRING 252, 227, "2 players"
PrintSTRING 252, 243, "1 player (play computer)"
HighLIGHT 238, 208, 380, 255, 9
HighLIGHT 238, 208, 380, 214, 15
LINE (215, 227)-(241, 239), 10, B
LINE (216, 228)-(240, 238), 8, BF
LINE (216, 228)-(240, 238), 15, B
LINE (240, 228)-(240, 238), 6
LINE (216, 238)-(240, 238), 6
LINE (215, 243)-(241, 255), 10, B
LINE (216, 244)-(240, 254), 8, BF
LINE (216, 244)-(240, 254), 15, B
LINE (240, 244)-(240, 254), 6
LINE (216, 254)-(240, 254), 6
GET (180, 194)-(400, 270), Box()
PUT (180, 194), Box()
DEF SEG = VARSEG(Box(1))
BSAVE "kong1pl2.bsv", VARPTR(Box(1)), 8800
DEF SEG
LINE (180, 194)-(400, 270), 7, BF
LINE (180, 194)-(400, 270), 9, B
LINE (180, 270)-(400, 270), 6
LINE (400, 194)-(400, 270), 6
LINE (194, 198)-(384, 266), 1, BF
LINE (196, 200)-(382, 264), 6, B
PrintSTRING 256, 207, "Your gorilla is"
PrintSTRING 236, 243, "Click to begin"
HighLIGHT 233, 207, 380, 257, 9
FOR x = 138 TO 256
    FOR y = 0 TO 20
        IF y > 9 THEN Colr = 8 ELSE Colr = 15
        IF POINT(x, y) <> 0 THEN
            PSET (x + 92, y + 223), 10
            PSET (x + 92, y + 221), Colr
        END IF
    NEXT y
NEXT x
LINE (311, 244)-(337, 253), 10, B
LINE (312, 245)-(336, 255), 8, BF
LINE (312, 245)-(336, 255), 15, B
LINE (336, 245)-(336, 255), 6
LINE (312, 255)-(336, 255), 6
PSET (318, 249), 1
DRAW "R9 U2 F3 G3 U2 L9 U2 BF P1,1"
GET (180, 194)-(400, 270), Box()
PUT (180, 194), Box()
DEF SEG = VARSEG(Box(1))
BSAVE "kong1plr.bsv", VARPTR(Box(1)), 8800
DEF SEG
LINE (180, 194)-(400, 270), 7, BF
LINE (180, 194)-(400, 270), 9, B
LINE (180, 270)-(400, 270), 6
LINE (400, 194)-(400, 270), 6
LINE (194, 198)-(384, 266), 1, BF
LINE (196, 200)-(382, 264), 6, B
PrintSTRING 234, 214, "Decide who will control"
PrintSTRING 234, 226, "which gorilla and then..."
PrintSTRING 236, 243, "Click to begin"
HighLIGHT 225, 212, 380, 257, 9
LINE (311, 244)-(337, 253), 10, B
LINE (312, 245)-(336, 255), 8, BF
LINE (312, 245)-(336, 255), 15, B
LINE (336, 245)-(336, 255), 6
LINE (312, 255)-(336, 255), 6
PSET (318, 249), 1
DRAW "R9 U2 F3 G3 U2 L9 U2 BF P1,1"
GET (180, 194)-(400, 270), Box()
PUT (180, 194), Box()
DEF SEG = VARSEG(Box(1))
BSAVE "kongopen.bsv", VARPTR(Box(1)), 8800
DEF SEG
RETURN

SUB HighLIGHT (x1, y1, x2, y2, Colr)
FOR x = x1 TO x2
    FOR y = y1 TO y2
        IF POINT(x, y) <> 1 THEN PSET (x, y), Colr
    NEXT y
NEXT x
END SUB

SUB PrintSTRING (x, y, Prnt$)

DEF SEG = VARSEG(FontBOX(0))
BLOAD "kong.fbs", VARPTR(FontBOX(0))
DEF SEG

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

SUB SaveBUILDING (x, UpSET, Building)

Box(1) = UpSET
LINE (x, 155)-(x, 479), 0
LINE (x + 79, 155)-(x + 79, 479), 0
GET (x, 155)-(x + 79, 199), Box(2)
FOR xx = x TO x + 79
    FOR yy = 155 TO 199
        IF POINT(xx, yy) = 0 THEN PSET (xx, yy), 15 ELSE PSET (xx, yy), 0
    NEXT yy
NEXT xx
GET (x, 155)-(x + 79, 199), Box(1000)
GET (x, 200)-(x + 79, 479), Box(2000)
FileNAME$ = "kongbld" + LTRIM$(STR$(Building)) + ".bsv"
DEF SEG = VARSEG(Box(1))
BSAVE FileNAME$, VARPTR(Box(1)), 16000
DEF SEG

END SUB

SUB SaveINSTR (FileNAME$)
GET (192, 160)-(447, 310), Box()
DEF SEG = VARSEG(Box(1))
BSAVE FileNAME$, VARPTR(Box(1)), 20000
DEF SEG
END SUB

