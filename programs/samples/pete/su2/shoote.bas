CHDIR ".\samples\pete\su2"

DECLARE SUB border ()
DECLARE SUB center (text$)
SCREEN 13
U$ = CHR$(0) + "H"
D$ = CHR$(0) + "P"
L$ = CHR$(0) + "K"
R$ = CHR$(0) + "M"

new:
CLS
DIM map$(27, 12)
FOR y = 1 TO 12
FOR x = 1 TO 27
map$(x, y) = "5-0"
NEXT: NEXT

x = 13: y = 6

drawon:
CLS
border
FOR yy = 1 TO 12
FOR xx = 1 TO 27
FOR i = 1 TO 5
IF MID$(map$(xx, yy), i, 1) = "-" THEN B$ = MID$(map$(xx, yy), 1, i - 1): item2 = VAL(MID$(map$(xx, yy), i + 1, 10))
NEXT
c = VAL(B$)
IF c = 0 OR item2 = 0 OR item2 = 255 OR item2 = 32 THEN map$(xx, yy) = "0-0"
COLOR c: LOCATE yy + 4, xx + 6: PRINT CHR$(item2)
NEXT: NEXT
top:
IF drw = 0 THEN COLOR 15
IF drw = 1 THEN COLOR 12
LOCATE y + 4, x + 6: PRINT CHR$(197)
LOCATE 18, 7: COLOR clr: PRINT "Color "; CHR$(item)
DO: P$ = INKEY$: LOOP UNTIL P$ <> ""
oldy = y: oldx = x
IF P$ = U$ AND y <> 1 THEN y = y - 1
IF P$ = D$ AND y <> 12 THEN y = y + 1
IF P$ = R$ AND x <> 27 THEN x = x + 1
IF P$ = L$ AND x <> 1 THEN x = x - 1
IF P$ = "s" OR P$ = "S" THEN GOTO save
IF P$ = "l" OR P$ = "L" THEN GOTO load
IF P$ = "r" OR P$ = "R" THEN GOTO drawon
IF P$ = "i" THEN item = item + 1: IF item = 256 THEN item = 0
IF P$ = "I" THEN GOTO item
IF P$ = "h" OR P$ = "H" THEN drw = drw + 1: IF drw = 2 THEN drw = 0
IF P$ = CHR$(27) THEN END
IF P$ = "c" OR P$ = "C" THEN clr = clr + 1: IF clr = 16 THEN clr = 0
IF P$ = "1" THEN clr = 1
IF P$ = "2" THEN clr = 2
IF P$ = "3" THEN clr = 3
IF P$ = "4" THEN clr = 4
IF P$ = "5" THEN clr = 5
IF P$ = "6" THEN clr = 6
IF P$ = "7" THEN clr = 7
IF P$ = "8" THEN clr = 8
IF P$ = "9" THEN clr = 9
IF P$ = CHR$(32) OR drw = 1 THEN map$(x, y) = STR$(clr) + "-" + STR$(item): IF clr = 0 OR item = 0 OR item = 255 OR item = 32 THEN map$(x, y) = "0-0"
FOR i = 1 TO 5
IF MID$(map$(oldx, oldy), i, 1) = "-" THEN B$ = MID$(map$(oldx, oldy), 1, i - 1): item2 = VAL(MID$(map$(oldx, oldy), i + 1, 10))
NEXT
c = VAL(B$)
IF c = 0 OR item2 = 0 OR item2 = 255 OR item2 = 32 THEN map$(oldx, oldy) = "0-0"
COLOR c: LOCATE oldy + 4, oldx + 6: PRINT CHR$(item2)
GOTO top

item:
LOCATE 19, 7: COLOR 4
INPUT "ASCII Num"; item
IF item >= 256 THEN item = 255
LOCATE 19, 7: PRINT "               "
GOTO top

save:
LOCATE 19, 7: COLOR 12
IF file$ = "" THEN INPUT "File name to save as"; file$
OPEN file$ + ".dat" FOR OUTPUT AS #1
FOR yy = 1 TO 12
FOR xx = 1 TO 27
FOR i = 1 TO 5
IF MID$(map$(xx, yy), i, 1) = "-" THEN B$ = MID$(map$(xx, yy), 1, i - 1): item2 = VAL(MID$(map$(xx, yy), i + 1, 3))
NEXT
c = VAL(B$)
IF c = 0 OR item2 = 0 OR item2 = 255 OR item2 = 32 THEN map$(xx, yy) = "0-0"
PRINT #1, map$(xx, yy)
NEXT: NEXT
LOCATE 19, 7: PRINT "                                "
CLOSE #1
GOTO top

load:
LOCATE 19, 7: COLOR 12
INPUT "File name to load"; file$
OPEN file$ + ".dat" FOR INPUT AS #1
FOR yy = 1 TO 12
FOR xx = 1 TO 27
INPUT #1, map$(xx, yy)
NEXT: NEXT
CLOSE #1
GOTO drawon

SUB border
COLOR 4
center "Shoot Up Editor 2"
center ""
center ""
COLOR 7
center "±±±±±±±±±±±±±±±±±±±±±±±±±±±±±"
center "±                           ±"
center "±                           ±"
center "±                           ±"
center "±                           ±"
center "±                           ±"
center "±                           ±"
center "±                           ±"
center "±                           ±"
center "±                           ±"
center "±                           ±"
center "±                           ±"
center "±                           ±"
center "±±±±±±±±±±±±±±±±±±±±±±±±±±±±±"

END SUB

SUB center (text$)
PRINT TAB(20 - (INT(LEN(text$) / 2))); text$
END SUB

