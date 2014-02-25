CLS
COLOR 2
d% = 2
w% = 2
WHILE INKEY$ = ""
LOCATE w%, d%
RANDOMIZE TIMER
c = INT(RND * 2)
f = INT(RND * 15) + 1
IF c = 0 THEN : FOR p = 1 TO 300: NEXT p: COLOR f: PRINT CHR$(1)

IF c = 1 THEN : FOR p = 1 TO 300: NEXT p: COLOR f: PRINT CHR$(2)

w% = w% + 1
IF w% = 23 THEN
d% = d% + 1
w% = 2
END IF
IF d% = 80 THEN SLEEP 1: CLS : w% = 2: d% = 2

WEND

