life:
DATA 0,4,0,0,4,0
DATA 4,4,4,4,4,4
DATA 4,4,4,4,4,4
DATA 0,4,4,4,4,0
DATA 0,0,4,4,0,0
DATA 0,0,0,0,0,0
fighters:
DATA 0,0,0,0,0,0,0,0,6,6,6,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,6,7,7,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,6,7,7,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,4,4,4,7,7,4,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,7,4,4,4,4,4,0,7,7,0,0,0,0,0
DATA 0,0,0,0,0,7,7,4,4,4,4,7,8,7,7,0,0,0,0,0
DATA 0,0,0,0,7,7,0,4,4,4,4,7,7,7,0,0,0,0,0,0
DATA 0,0,0,0,7,7,0,4,4,4,4,0,7,7,0,0,0,0,0,0
DATA 0,0,0,0,7,7,0,4,4,4,4,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,7,7,8,8,8,8,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,7,7,1,1,1,1,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,1,1,1,0,1,1,1,0,0,0,0,0,0,0
DATA 0,0,0,0,0,1,1,1,0,0,0,1,1,0,0,0,0,0,0,0
DATA 0,0,0,0,0,1,1,0,0,0,0,1,1,0,0,0,0,0,0,0
DATA 0,0,0,0,0,1,1,0,0,0,0,1,1,0,0,0,0,0,0,0
DATA 0,0,0,0,0,6,6,0,0,0,0,6,6,0,0,0,0,0,0,0
DATA 0,0,0,0,0,6,6,6,0,0,0,6,6,6,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
fighters2:
DATA 0,0,0,0,0,0,0,0,6,6,6,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,6,7,7,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,6,7,7,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,4,4,4,7,7,4,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,7,4,4,4,4,4,7,7,7,7,7,0,0,0
DATA 0,0,0,0,0,7,7,4,4,4,4,7,7,7,8,7,7,0,0,0
DATA 0,0,0,0,7,7,0,4,4,4,4,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,7,7,0,4,4,4,4,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,7,7,0,4,4,4,4,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,7,7,8,8,8,8,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,7,7,1,1,1,1,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,1,1,1,0,1,1,1,0,0,0,0,0,0,0
DATA 0,0,0,0,0,1,1,1,0,0,0,1,1,0,0,0,0,0,0,0
DATA 0,0,0,0,0,1,1,0,0,0,0,1,1,0,0,0,0,0,0,0
DATA 0,0,0,0,0,1,1,0,0,0,0,1,1,0,0,0,0,0,0,0
DATA 0,0,0,0,0,6,6,0,0,0,0,6,6,0,0,0,0,0,0,0
DATA 0,0,0,0,0,6,6,6,0,0,0,6,6,6,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
SCREEN 9, 0, 1, 0: DIM f(20, 20), fp(20, 20), f2(20, 20), fp2(20, 20), life2(6, 6), life(6, 6)
RESTORE life
FOR y = 1 TO 6: FOR x = 1 TO 6
READ z: PSET (x, y), z
NEXT: NEXT
GET (1, 1)-(6, 6), life
RESTORE life
FOR y = 1 TO 6: FOR x = 1 TO 6
READ z
IF z = 4 THEN z = 14
PSET (x, y), z
NEXT: NEXT
GET (1, 1)-(6, 6), life2

RESTORE fighters: CLS
FOR y = 1 TO 20: FOR x = 1 TO 20
READ z: PSET (x, y), z
NEXT: NEXT
GET (1, 1)-(20, 20), f
RESTORE fighters2: CLS
FOR y = 1 TO 20: FOR x = 1 TO 20
READ z: PSET (x, y), z
NEXT: NEXT
GET (1, 1)-(20, 20), fp
RESTORE fighters: CLS
FOR y = 1 TO 20: FOR x = 20 TO 1 STEP -1
READ z
IF z = 4 THEN z = 14
PSET (x, y), z
NEXT: NEXT
GET (1, 1)-(20, 20), f2
RESTORE fighters2: CLS
FOR y = 1 TO 20
FOR x = 20 TO 1 STEP -1
READ z
IF z = 4 THEN z = 14
PSET (x, y), z
NEXT: NEXT
GET (1, 1)-(20, 20), fp2

StartFight:
CLS
DIM SHARED plife, oplife, px, py, opx, opy: plife = 10: oplife = 10
VIEW (10, 10)-(110, 50), , 4
VIEW PRINT 7 TO 12
Fighting:
DO
FOR x = 1 TO oplife
PUT (x * 7, 1), life2
NEXT
FOR x = 1 TO plife
PUT (x * 7, 30), life
NEXT
px = 10: py = 10: opx = 60: opy = 10
PUT (px, py), f
PUT (opx, opy), f2
PCOPY 1, 0
DO
IF oplife <= 0 THEN PRINT "You Win!": GOTO fe
IF plife <= 0 THEN PRINT "You; Lose!": GOTO fe
g$ = INPUT$(1)
IF g$ = CHR$(27) GOTO fe
IF g$ = "a" THEN
        GOSUB pa
END IF
IF g$ = "s" THEN
        IF plife > 12 THEN
                PRINT "Can't use any more medicine"
        ELSE
                plife = plife + 2
                PRINT "Used some medicine...You've gained some health!"
        END IF
END IF
IF g$ <> "" THEN EXIT DO
LOOP
CLS
a = INT(RND * 3)
IF a = 2 THEN GOSUB opa
IF a = 1 THEN
        IF oplife > 12 THEN
                PRINT "Oponent: I can beat you as I am now!"
        ELSE
                oplife = oplife + 2
                PRINT "Oponent: That feals better..."
        END IF
END IF
LOOP
fe:
PRINT "Game End."
END

pa:
FOR x = 10 TO 50 STEP 4
CLS
px = x
PUT (opx, opy), f2
PUT (px, py), fp
PCOPY 1, 0
NEXT
oplife = oplife - 1
CLS
px = 10: py = 10: opx = 60: opy = 10
PRINT "Oponent: Ow!"
RETURN

opa:
FOR x = 50 TO 10 STEP -4
CLS
opx = x
PUT (px, py), f
PUT (opx, opy), fp2
PCOPY 1, 0
NEXT
plife = plife - 1
CLS
px = 10: py = 10: opx = 60: opy = 10
PRINT "Player: Ouch!"
RETURN