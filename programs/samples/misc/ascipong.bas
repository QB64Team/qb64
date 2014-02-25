' This work has been released into the public domain by the copyright
' holder. This applies worldwide.
'
' In case this is not legally possible:
' The copyright holder grants any entity the right to use this work for any
' purpose, without any conditions, unless such conditions are required by
' law.

DEFINT A-Z
DIM SCORE AS LONG, DELAY AS SINGLE, T AS SINGLE
SCREEN 12 ' This is just to make it full screen
SCREEN 0 ' Screen 0 rules
WIDTH 40
CLS
X = 50: Y = 50: X2 = 130: Y2 = 150
PSPEED = 5: XADJ = 1: YADJ = 1: DELAY = .05
DO
CLS
PRESS$ = INKEY$
LOCATE Y \ 8 + 1, X \ 8 + 1
PRINT "o"
LOCATE Y2 \ 8 + 1, X2 \ 8 + 1
PRINT STRING$(4, 219)
LOCATE 1, 1
PRINT SCORE
IF Y <= 20 THEN YADJ = 1
IF Y >= 180 THEN YADJ = -1
IF X >= 300 THEN XADJ = -1
IF X <= 20 THEN XADJ = 1
SELECT CASE PRESS$
CASE CHR$(0) + CHR$(75)
IF X2 > 1 THEN X2 = X2 - PSPEED
CASE CHR$(0) + CHR$(77)
IF X2 < 290 THEN X2 = X2 + PSPEED
CASE CHR$(27)
END
CASE CHR$(0) + CHR$(72)
DELAY = DELAY - .002
CASE CHR$(0) + CHR$(80)
DELAY = DELAY + .002
END SELECT
X = X + XADJ
Y = Y + YADJ
IF Y < Y2 + 8 AND Y > Y2 - 8 AND X < X2 + 32 AND X > X2 THEN
YADJ = -1: SCORE = SCORE + 1
END IF
IF Y > Y2 + 10 THEN
PRESS$=""
DO WHILE PRESS$ <> ""
PRESS$ = INKEY$
COLOR INT(RND(1) * 16)
PRINT "GAME OVER",
LOOP
END
END IF
T = TIMER + DELAY
WHILE T > TIMER: WEND
LOOP