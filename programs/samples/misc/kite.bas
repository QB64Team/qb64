'2007 mennonite
'public domain

ON ERROR GOTO 10
DIM b AS INTEGER
DIM a AS INTEGER
DIM atwo AS INTEGER
q$ = "...../" + CHR$(92) + "........./__" + CHR$(92) + "......./____" + CHR$(92) + "...../_q____" + CHR$(92) + ".../___b____" + CHR$(92) + "./__________" + CHR$(92)
q$ = q$ + CHR$(92) + "__________/." + CHR$(92) + "____6___/..." + CHR$(92) + "____4_/....." + CHR$(92) + "____/......." + CHR$(92) + "__/........." + CHR$(92) + "/....."
COLOR , 1

FOR y = 25 TO 1 STEP -1
FOR x = 1 TO 80
LOCATE y, x: PRINT CHR$(32);
NEXT x
NEXT y: LOCATE 1, 1

RANDOMIZE TIMER
FOR a = 1 TO 10
strn$ = strn$ + "||" + CHR$(247)
NEXT a
DO

FOR y = 25 TO 1 STEP -1
FOR x = 1 TO 80
LOCATE y, x: PRINT CHR$(32);
NEXT x
NEXT y: LOCATE 1, 1

b = b + (RND(1) * 3 - .5 - 1)
a = a + (RND(1) * 3 - .5 - 1)
IF b < 1 THEN b = 1 ELSE IF b > 10 THEN b = 10
IF a < 1 THEN a = 1 ELSE IF a > 67 THEN a = 67
FOR y = 1 TO 12
FOR x = 1 TO 12
one$ = RIGHT$(LEFT$(q$, y * 12 - 12 + x), 1)

fc = 11
IF one$ = "." THEN fc = 1
IF one$ = "_" THEN fc = 3
IF ASC(UCASE$(one$)) > 64 AND ASC(UCASE$(one$)) < 91 THEN fc = 14
IF ASC(UCASE$(one$)) > 47 AND ASC(UCASE$(one$)) < 58 THEN fc = 14

COLOR fc
LOCATE y + b, x + a
PRINT one$;
NEXT x
NEXT y
COLOR 15
atwo = 0
cursorline = b + 12
DO WHILE cursorline <= 24
LOCATE cursorline + 1, x + a - 6 + atwo
atwo = atwo + (RND(1) * 3 - .5 - 1)
PRINT RIGHT$(LEFT$(strn$, cursorline), 1);
cursorline = cursorline + 1
LOOP
t = TIMER: DO: LOOP UNTIL t > TIMER + .25 OR t < TIMER - .25
LOOP UNTIL INKEY$ = CHR$(27)

COLOR 7, 0
FOR y = 25 TO 1 STEP -1
FOR x = 1 TO 80
LOCATE y, x: PRINT CHR$(32);
NEXT x
NEXT y: LOCATE 1, 1
END
10 RESUME NEXT

