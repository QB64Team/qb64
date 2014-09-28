DECLARE SUB endDemo ()
DECLARE SUB intro ()
DECLARE SUB howToPlay ()
DECLARE SUB level2 ()
DECLARE FUNCTION rand! (c!)
DECLARE SUB level1 ()
DIM SHARED heart(10)
DIM SHARED missile(4)
COMMON SHARED L$, r$, u$, d$
locked = 1
CALL intro
COLOR 3, 0
CLS
LOCATE 18, 30
PRINT "KEY CONFIGURATION..."
LOCATE 24, 18
PRINT "Enter the key that you want to move LEFT with..."
DO
L$ = INKEY$
LOOP UNTIL L$ <> ""
CLS
LOCATE 18, 30
PRINT "KEY CONFIGURATION..."
LOCATE 24, 18
PRINT "Enter the key that you want to move RIGHT with..."
DO
r$ = INKEY$
LOOP UNTIL r$ <> ""
CLS
LOCATE 18, 30
PRINT "KEY CONFIGURATION..."
LOCATE 24, 18
PRINT "Enter the key that you want to move UP with..."
DO
u$ = INKEY$
LOOP UNTIL u$ <> ""
CLS
LOCATE 18, 30
PRINT "KEY CONFIGURATION..."
LOCATE 24, 18
PRINT "Enter the key that you want to move DOWN with..."
DO
d$ = INKEY$
LOOP UNTIL d$ <> ""
CALL level1

SUB endDemo
COLOR 3, 0
CLS
LOCATE 20, 20
PRINT "WELL DONE, YOU HAVE COMPLETED LEVEL ONE OF ALYMAN...."
LOCATE 22, 20
PRINT "Level One is the only level available on the demo, so"
LOCATE 23, 20
PRINT "remember to wait for the full game to be completed on"
LOCATE 24, 20
PRINT "Sunday 24th July 2005 for four additional levels, each"
LOCATE 25, 20
PRINT "one more difficult than the last..."
PLAY "o3l16ef+g+al8b"
DO
LOOP UNTIL INKEY$ = CHR$(13)
END
END SUB

SUB howToPlay
COLOR 3, 0
CLS
PRINT "HOW TO PLAY..."
PRINT
PRINT
PRINT "Dr. Evil and his troublesome followers plan to blow up the"
PRINT "world! You, ALYMAN, must put an end to his terrifying plans"
PRINT "and save the earth from destruction!"
PRINT
PRINT "To do so, you must demobilize the bomb at the end of each"
PRINT "level. To demobilize the bomb, it is vital that you collect"
PRINT "all ten hearts on your way. If you fail to collect just one"
PRINT "one of the hearts, then you will not be able to complete"
PRINT "the level. In order to open doors, you must hit a"
PRINT "corrosponding switch."
PRINT
PRINT "On your way through each level, there are a number of"
PRINT "enemies, weapons, traps and lasers which will kill ALYMAN"
PRINT "with just one blow, so be very careful!"
PRINT
PRINT "Each bomb will not wait forever to explode! In fact, you"
PRINT "must demobilize the bomb on each level within 40 seconds"
PRINT "before it detonates."
PRINT
PRINT "Before beginning the game, you will be asked to select"
PRINT "a custom key configuration (a key to move left, a key"
PRINT "to move right, a key to move up and a key to move down)."
PRINT "It is advised that you use the keypad direction keys,"
PRINT "although the selection your choice."
PRINT
PRINT "Good luck!"
PRINT
PRINT
PRINT "Press RETURN to continue..."
DO
LOOP UNTIL INKEY$ = CHR$(13)
COLOR 3, 0
CLS
END SUB

SUB intro
COLOR 3, 0
CLS
DO
LOCATE 14, 34
COLOR rand(15), 0
PRINT "ALYMAN"
COLOR 3, 0
LOCATE 16, 30
PRINT "(Demo Version)"
LOCATE 18, 18
PRINT "Full Game due for completion on 24th July 2005"
COLOR 3, 1
LOCATE 30, 28
PRINT "1  -  HOW TO PLAY  "
LOCATE 32, 28
PRINT "2  -  PLAY DEMO NOW"
FOR t = 1 TO 50
NEXT t
SELECT CASE INKEY$
CASE IS = "1"
CALL howToPlay
CASE IS = "2"
z = 1
END SELECT
LOOP UNTIL z = 1
END SUB

SUB level1
60 FOR i = 1 TO 10
heart(i) = 0
NEXT i
hearts = 0
a = 2
b = 4
c = 14
d = 76
laser = 0
ends = 0
missile = -1
locked = 1
CLS
COLOR 3, 0
LOCATE 22, 36
PRINT "LEVEL ONE"
LOCATE 24, 27
PRINT "Press RETURN to begin level..."
DO
LOOP UNTIL INKEY$ = CHR$(13)

COLOR 7, 0
CLS
t = TIMER
u = TIMER
v = TIMER
100 DO
times = times + 1
SELECT CASE TIMER - u
CASE IS >= .01
missile = missile - 1
IF missile = -6 THEN missile = 44
u = TIMER
CLS
END SELECT

SELECT CASE TIMER - v
CASE IS >= 3
IF laser = 1 THEN laser = 0 ELSE laser = 1
v = TIMER
END SELECT

COLOR 4, 0
LOCATE 34, 1
PRINT CHR$(16)
LOCATE 34, 44
PRINT CHR$(17)
SELECT CASE laser
CASE IS = 1
FOR i = 2 TO 43
LOCATE 34, i
PRINT CHR$(196)
NEXT i
END SELECT

ttt = tt
tt = INT(40 - (TIMER - t))
IF tt < 11 AND tt < ttt THEN PLAY "o4l8d-"
LOCATE 1, 1
COLOR 14, 0
PRINT tt
LOCATE 1, 10
COLOR 13, 0
PRINT CHR$(3); hearts

COLOR 3, 0
LOCATE a, b
PRINT CHR$(2)
LOCATE a + 1, b - 1
PRINT "/"; CHR$(179); "\"
LOCATE a + 2, b
PRINT CHR$(234)

COLOR 4, 0
LOCATE c, d
PRINT CHR$(1)
LOCATE c + 1, d - 1
PRINT "/"; CHR$(179); "\"
LOCATE c + 2, d
PRINT CHR$(234)


LOCATE 8, 44
COLOR 6, 0
PRINT CHR$(17)
IF missile < 1 THEN GOTO 70
LOCATE 8, missile
COLOR 0, 6
PRINT CHR$(8)
70 IF a > 5 AND a < 9 AND b = missile THEN GOTO 80


COLOR 13, 0
LOCATE 5, 68
IF heart(1) = 1 THEN PRINT "" ELSE PRINT CHR$(3)
LOCATE 9, 14
IF heart(2) = 1 THEN PRINT "" ELSE PRINT CHR$(3)
LOCATE 11, 75
IF heart(3) = 1 THEN PRINT "" ELSE PRINT CHR$(3)
LOCATE 22, 57
IF heart(4) = 1 THEN PRINT "" ELSE PRINT CHR$(3)
LOCATE 29, 39
IF heart(5) = 1 THEN PRINT "" ELSE PRINT CHR$(3)
LOCATE 33, 74
IF heart(6) = 1 THEN PRINT "" ELSE PRINT CHR$(3)
LOCATE 36, 75
IF heart(7) = 1 THEN PRINT "" ELSE PRINT CHR$(3)
LOCATE 37, 9
IF heart(8) = 1 THEN PRINT "" ELSE PRINT CHR$(3)
LOCATE 41, 20
IF heart(9) = 1 THEN PRINT "" ELSE PRINT CHR$(3)
LOCATE 44, 17
IF heart(10) = 1 THEN PRINT "" ELSE PRINT CHR$(3)

IF a > 2 AND a < 6 AND b = 68 THEN heart(1) = 1
IF a > 6 AND a < 10 AND b = 14 THEN heart(2) = 1
IF a > 8 AND a < 12 AND b = 75 THEN heart(3) = 1
IF a > 19 AND a < 23 AND b = 57 THEN heart(4) = 1
IF a > 26 AND a < 30 AND b = 39 THEN heart(5) = 1
IF a > 30 AND a < 34 AND b = 74 THEN heart(6) = 1
IF a > 33 AND a < 37 AND b = 75 THEN heart(7) = 1
IF a > 34 AND a < 38 AND b = 9 THEN heart(8) = 1
IF a > 38 AND a < 42 AND b = 20 THEN heart(9) = 1
IF a > 41 AND a < 45 AND b = 17 THEN heart(10) = 1

hearts = 0
FOR i = 1 TO 10
IF heart(i) = 1 THEN hearts = hearts + 1
NEXT i

COLOR 7, 0
FOR i = 1 TO 48
IF locked = 1 THEN GOTO 30
IF i = 17 OR i = 18 OR i = 19 THEN GOTO 10
30 LOCATE i, 45
IF i = 17 OR i = 18 OR i = 19 THEN COLOR 4 ELSE COLOR 7
IF i = 17 OR i = 18 OR i = 19 THEN PRINT CHR$(186) ELSE PRINT CHR$(179)
10 NEXT i

IF locked = 0 THEN GOTO 40
LOCATE 43, 7
COLOR 4, 7
PRINT CHR$(254)
COLOR 7, 0
40 IF a > 40 AND a < 44 AND b = 7 THEN locked = 0
IF b = 76 AND a > 41 AND a < 46 AND hearts = 10 THEN fin = 1

LOCATE 44, 76
COLOR 7, 0
PRINT CHR$(218)
LOCATE 45, 76
COLOR 4, 0
PRINT CHR$(219)

SELECT CASE ends
CASE IS = 1
COLOR 0, 0
FOR t = 1 TO 300
LOCATE 1, 1
PRINT "                     "
NEXT t
GOTO 80
END SELECT

IF (c - a) < 3 AND (a - c) < 3 AND b = d THEN ends = 1
IF (c - a) < 3 AND (a - c) < 3 AND b = d THEN GOTO 100

IF laser = 0 OR a < 32 OR a > 34 OR b > 44 THEN GOTO 90
FOR t = 1 TO 1000000
NEXT t
ends = 1
GOTO 100

90 SELECT CASE INKEY$
CASE IS = L$
b = b - 1
CLS
CASE IS = r$
b = b + 1
CLS
CASE IS = u$
a = a - 1
CLS
CASE IS = d$
a = a + 1
CLS
END SELECT

IF b < 45 THEN GOTO 110

timenow! = TIMER
IF timenow! <> oldtime! THEN
'chance = rand(130)
chance = CINT(RND * 8)
SELECT CASE chance
CASE IS = 1
IF a > c THEN c = c + 1
IF a < c THEN c = c - 1
CLS
CASE IS = 2
IF b > d THEN d = d + 1
IF b < d THEN d = d - 1
CLS
END SELECT
END IF
oldtime! = timenow!

110 IF d < 47 THEN d = 47
IF d > 79 THEN d = 79
IF c > 46 THEN c = 46
IF c < 12 THEN c = 12
IF a < 2 THEN a = 2
IF a > 46 THEN a = 46
IF b < 4 THEN b = 4
IF b > 79 THEN b = 79
IF a = 17 AND locked = 0 THEN GOTO 20
IF b = 44 THEN b = 43
IF b = 46 THEN b = 47
20 LOOP UNTIL tt <= 0 OR fin = 1

SELECT CASE fin
CASE IS = 1
FOR t = 1 TO 30000
NEXT t
CALL endDemo
END SELECT

80 SELECT CASE tt
CASE IS <= 0
FOR i = 1 TO 48
FOR j = 1 TO 80
COLOR 14, 0
LOCATE i, j
PRINT CHR$(176)
NEXT j
NEXT i
SOUND 40, 5
SOUND 45, 5
SOUND 50, 5
SOUND 55, 5
SOUND 50, 5
SOUND 45, 5
SOUND 40, 5
FOR t = 1 TO 10000
NEXT t
COLOR 3, 0
CLS
LOCATE 22, 34
PRINT "GAME OVER"
LOCATE 24, 27
PRINT "Try this level again? (y/n)"
50 SELECT CASE INKEY$
CASE IS = "y"
GOTO 60
CASE IS = "Y"
GOTO 60
CASE IS = "n"
END
CASE IS = "N"
END
CASE ELSE
GOTO 50
END SELECT
CASE ELSE
COLOR 3, 0
CLS
LOCATE 22, 34
PRINT "GAME OVER"
LOCATE 24, 27
PRINT "Try this level again? (y/n)"
SELECT CASE INKEY$
CASE IS = "y"
GOTO 60
CASE IS = "Y"
GOTO 60
CASE IS = "n"
END
CASE IS = "N"
END
CASE ELSE
GOTO 50
END SELECT
END SELECT
END SUB

FUNCTION rand (c)
RANDOMIZE TIMER
rand = INT(c * RND(1)) + 1
END FUNCTION
