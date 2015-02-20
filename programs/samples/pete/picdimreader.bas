'QB Graphics Utility which reads the width and height of a SCREEN 13 BSAVEd image
'Written by drnull 02/09/06

DECLARE FUNCTION readInt! (file%, offset%)

SCREEN 13
CLS

INPUT "BSAVEd Filename>"; pic$
OPEN pic$ FOR BINARY AS #1

DIM picH, picW AS INTEGER
DIM bpp AS INTEGER

bpp = 8

picW = readInt(1, 8) / bpp
picH = readInt(1, 10)

PRINT "Width is" + STR$(picW)
PRINT "Height is" + STR$(picH)

FUNCTION readInt (file%, offset%)

DIM a$
a$ = " "

GET file%, offset%, a$
value = ASC(a$)
GET file%, , a$
value = value OR (ASC(a$) * 256)

readInt = value

END FUNCTION
