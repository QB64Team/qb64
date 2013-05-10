'little game I made, just for fun
'and also to be rated on future software
'I hope you'll learn something with this little prog
'author  : darokin         Adrien Rebuzzi
'any comment or suggest here : darokin@infonie.fr
'darokin '99
RANDOMIZE TIMER
CLS
cx = 17
a = 1
bx = INT(RND * 318) + 1: by = INT(RND * 100) + 12
DO
px = INT(RND * 3) - 1: py = -1
LOOP UNTIL px <> 0 AND py <> 0
jx = 10
attente = 5000
moins = 200
SCREEN 13
DIM cache(120)
GET (0, 0)-(11, 10), cache
 
DIM balle(120)
DATA 00,00,00,00,04,04,04,00,00,00,00
DATA 00,00,04,04,04,04,04,04,04,00,00
DATA 00,04,04,15,15,04,04,04,04,04,00
DATA 00,04,04,15,15,04,04,04,04,04,00
DATA 04,04,04,04,04,04,04,04,04,04,04
DATA 04,04,04,04,04,04,04,04,04,04,04
DATA 00,04,04,04,04,04,04,04,04,04,00
DATA 00,04,04,04,04,04,04,04,04,04,00
DATA 00,00,04,04,04,04,04,04,04,00,00
DATA 00,00,00,00,04,04,04,00,00,00,00

xlenght = 11
ylenght = 10

FOR y% = 1 TO ylenght
    FOR x% = 1 TO xlenght
        READ z
        PSET (x%, y%), z
    NEXT x%
NEXT y%
GET (0, 0)-(11, 10), balle
CLS
LOCATE 1, 28
PRINT ""
COLOR 2
PRINT "     ___"
PRINT "    / _ \___ ________ ___  ___ ___ _"
COLOR 14
PRINT "   / // / _ `/ __/ _ | _ \/ _ | _ `/"
COLOR 4
PRINT "  /____/\_,_/_/ / ___|___/_//_|_, /"
PRINT "               /_/           /___/"
PRINT ""
COLOR 10
PRINT "                       (c)darokin '99"
LOCATE 12, 10
COLOR 32
PRINT "Choose your level"
COLOR 50
PRINT " "
LOCATE 15, 15
PRINT "easy"
COLOR 51
LOCATE 17, 15
PRINT "medium"
COLOR 52
LOCATE 19, 15
PRINT "difficult"
COLOR 53
LOCATE 21, 15
PRINT "impossible"
LOCATE cx, 13
PRINT "*"
LOCATE 23, 8: PRINT "Hit Space Bar To Continue"
DO
a$ = INKEY$
IF a$ = CHR$(0) + CHR$(80) AND cx <> 21 THEN : LOCATE cx, 13: PRINT " ": cx = cx + 2: LOCATE cx, 13: PRINT "*"
IF a$ = CHR$(0) + CHR$(72) AND cx <> 15 THEN : LOCATE cx, 13: PRINT " ": cx = cx - 2: LOCATE cx, 13: PRINT "*"
IF a$ = " " THEN GOTO sorti
LOOP
sorti:
SELECT CASE cx
CASE IS = 15
   attente = 6000
CASE IS = 17
   attente = 4000
CASE IS = 29
   attente = 3300
CASE IS = 21
   attente = 1000
END SELECT
CLS
COLOR 17
PRINT " "
PRINT "     ___"
PRINT "    / _ \___ ________ ___  ___ ___ _"
PRINT "   / // / _ `/ __/ _ | _ \/ _ | _ `/"
PRINT "  /____/\_,_/_/ / ___|___/_//_|_, /"
PRINT "               /_/           /___/"

LOCATE 1, 28
COLOR 4
PRINT "darokin pong"
COLOR 2
LOCATE 1, 1
PRINT "score"
DO
COLOR 14
LOCATE 1, 15
PRINT score
LINE (1, 10)-(319, 10), 10
LINE (jx, 199)-(jx + 50, 199), 30
PUT (bx, by), cache
PUT (bx, by), balle

FOR a = 1 TO attente

delayrequired = delayrequired + 1
IF delayrequired > 10000 THEN WAIT &H3DA, 8: WAIT &H3DA, 8, 8: delayrequired = 0

NEXT a

PUT (bx, by), balle
bx = bx + px: by = by + py
IF bx <= 0 OR bx >= 307 THEN px = -px: BEEP
IF by <= 11 THEN py = -py: BEEP
IF by >= 188 AND (bx + 8 > jx AND bx < jx + 50) THEN py = -py: attente = attente - moins: BEEP: score = score + 10: IF attente <= 3000 THEN moins = 250
IF by > 189 THEN GOTO fin


a$ = INKEY$
IF a$ = CHR$(27) THEN GOTO fin
IF a$ = CHR$(0) + "M" THEN LINE (jx, 199)-(jx + 50, 199), 0: jx = jx + 30: LINE (jx, 199)-(jx + 50, 199), 26
IF a$ = CHR$(0) + "K" THEN LINE (jx, 199)-(jx + 50, 199), 0: jx = jx - 30: LINE (jx, 199)-(jx + 50, 199), 26
IF jx < 0 THEN jx = 0
IF jx > 270 THEN jx = 270
LOOP
fin:
CLS
COLOR 30
PRINT " "
PRINT "               _____"
PRINT "              / __/___ ___ _ ___"
PRINT "             / (_ / _ `/  ' | -_)"
PRINT "             \___/\_,_/_/_/_|__/"
PRINT "            / __ \_  _ __ ____"
PRINT "           / /_/   |/ / -_) __/"
PRINT "           \____/|___/\__/_/"
PRINT " "
PRINT ""
COLOR 2
PRINT "                 GAME OVER"
PRINT ""
COLOR 14
PRINT "               Your score is: "
COLOR 4
LOCATE 16, 20
PRINT score
LOCATE 23, 8: PRINT "Hit Space Bar To Continue"
DO
a$ = INKEY$: IF a$ = " " AND a$ <> CHR$(0) + "M" AND a$ <> CHR$(0) + "K" THEN GOTO totalend
LOOP
totalend:
SYSTEM


