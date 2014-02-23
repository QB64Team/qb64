DECLARE SUB again (x!)
DECLARE SUB summer.day ()
DECLARE SUB summer.nite ()
DECLARE SUB winter.day ()
DECLARE SUB Race ()
DECLARE SUB nitedraw ()
DECLARE SUB day1draw ()

SCREEN 13
DIM SHARED lap
DIM SHARED lap2
DIM SHARED lap3

FOR y = 1 TO 5
FOR x = 1 TO 5
READ c
PSET (x, y), c
NEXT
NEXT

DATA 0,2,2,2,0
DATA 2,2,2,2,2
DATA 0,2,2,2,0
DATA 0,0,6,0,0
DATA 0,6,6,6,0

DIM SHARED Tree%(50)
GET (1, 1)-(10, 5), Tree%
CLS

FOR y = 1 TO 5
FOR x = 1 TO 10
READ c
PSET (x, y), c
NEXT
NEXT

DATA 0,0,0,0,0,0,0,0,0,0
DATA 0,0,4,4,4,4,4,4,0,0
DATA 0,4,4,4,4,4,4,4,4,0
DATA 0,4,4,4,4,4,4,4,4,0
DATA 0,0,7,0,0,0,0,7,0,0
DIM SHARED RedCar%(50)
GET (1, 1)-(10, 5), RedCar%
CLS

FOR y = 1 TO 5
FOR x = 1 TO 10
READ c
PSET (x, y), c
NEXT
NEXT

DATA 0,0,0,0,0,0,0,0,0,0
DATA 0,0,2,2,2,2,2,2,0,0
DATA 0,2,2,2,2,2,2,2,2,0
DATA 0,2,2,2,2,2,2,2,2,0
DATA 0,0,7,0,0,0,0,7,0,0
DIM SHARED GrnCar%(50)
GET (1, 1)-(10, 5), GrnCar%
CLS


FOR y = 1 TO 5
FOR x = 1 TO 10
READ c
PSET (x, y), c
NEXT
NEXT

DATA 0,0,0,0,0,0,0,0,0,0
DATA 0,0,1,1,1,1,1,1,0,0
DATA 0,1,1,1,1,1,1,1,1,0
DATA 0,1,1,1,1,1,1,1,1,0
DATA 0,0,7,0,0,0,0,7,0,0
DIM SHARED BlueCar%(50)
GET (1, 1)-(10, 5), BlueCar%
CLS

date = VAL(LEFT$(DATE$, 2))
time = VAL(LEFT$(TIME$, 2))
IF time > 7 AND time < 20 AND date > 4 AND date < 9 THEN summer.day
IF time <= 7 OR time >= 20 AND date > 4 AND date < 9 THEN summer.nite
IF date <= 4 OR date >= 9 THEN winter.day
Race

IF lap = 3 THEN LOCATE 20, 1: PRINT "Red wins!"
IF lap2 = 3 THEN LOCATE 20, 1: PRINT "Blue wins!"
IF lap3 = 3 THEN LOCATE 20, 1: PRINT "Green wins!"
again (0)

SUB again (x)
CLS
IF x = 1 THEN PRINT "You hit a car!"
IF x = 2 THEN PRINT "You hit a tree!"

x = 20
DO
LOCATE 2, 1: PRINT "Race again"
LOCATE 3, 1: PRINT "     Yes           No"
LOCATE 4, 1: PRINT "Press 5 to confirm selection."
SELECT CASE INKEY$
CASE IS = "4"
x = 20
CASE IS = "6"
x = 120
CASE IS = "5"
IF x = 20 THEN RUN ELSE END
END SELECT
PUT (x, 17), BlueCar%
LOOP
END SUB

SUB Race
x = 299
x2 = 299
x3 = 309
lane = 2
go = 1


RANDOMIZE TIMER
badcar = INT(RND * 250 + 1)


DO
 SOUND 100, 1
 'Check For Crashes
 IF lane > 2 OR lane < 1 THEN BEEP: again (2)
 IF x2 > x AND x2 < (x + 10) AND lane = 1 THEN BEEP: again (1)
 IF x2 < x AND x2 > (x - 10) AND lane = 1 THEN BEEP: again (1)
 IF x2 > x3 AND x2 < (x3 + 10) AND lane = 1 THEN BEEP: again (1)
 IF x2 < x3 AND x2 > (x3 - 10) AND lane = 1 THEN BEEP: again (1)

 IF x > x3 AND x < (x3 + 10) AND lane = 1 THEN BEEP: gout = 1: x3 = 700
 IF x < x3 AND x > (x3 - 10) AND lane = 1 THEN BEEP: gout = 1: x3 = 700

 IF x2 > badcar AND x2 < (badcar + 10) AND lane = 2 THEN BEEP: again (1)

 PUT (badcar, 41), RedCar%

 RANDOMIZE TIMER
 x = x - INT(RND * 3)
 IF go = 1 THEN x2 = x2 - INT(RND * 3)
 IF gout = 0 THEN x3 = x3 - INT(RND * 3)

 IF x <= 0 THEN lap = lap + 1: x = 309
 IF x2 <= 0 THEN lap2 = lap2 + 1: x2 = 309: badcar = INT(RND * 100 + 1)
 IF x3 <= 0 THEN lap3 = lap3 + 1: x3 = 309

 IF lap = 3 THEN EXIT DO
 IF lap2 = 3 THEN EXIT DO
 IF lap3 = 3 THEN EXIT DO

 LINE (0, 30)-(319, 50), 8, BF
 FOR y = 0 TO 300 STEP 20
  LINE (y, 40)-(y + 20, 40), 14
 NEXT

 PUT (x, 31), RedCar%
 IF gout = 0 THEN PUT (x3, 31), GrnCar%
 IF lane = 1 THEN PUT (x2, 31), BlueCar%
 IF lane = 2 THEN PUT (x2, 43), BlueCar%

 SELECT CASE INKEY$
 CASE IS = "8"
 lane = lane - 1
 CASE IS = "2"
 lane = lane + 1
 CASE IS = "4"
 go = 1
 CASE IS = "6"
 go = 0
 END SELECT

 LOCATE 15: PRINT "Red car:"; (lap + 1); "/ 3"
 LOCATE 16: PRINT "Green car:"; (lap3 + 1); "/ 3"
 LOCATE 17: PRINT "Blue car:"; (lap2 + 1); "/ 3"

 LOCATE 19
 IF x2 < x AND x2 < x3 AND lap2 >= lap AND lap2 >= lap3 THEN
 PRINT "You are winning!"
 ELSE PRINT "You are losing."
 END IF

LOOP

END SUB

SUB summer.day
LINE (0, 0)-(319, 20), 9, BF
LINE (0, 20)-(319, 199), 2, BF

FOR x = 1 TO 309 STEP 10
PUT (x, 57), Tree%
PUT (x, 22), Tree%
NEXT

END SUB

SUB summer.nite
FOR a = 1 TO 50
RANDOMIZE TIMER
x = INT(RND * 300 + 1)
y = INT(RND * 20 + 1)
PSET (x, y), 15
NEXT
END SUB

SUB winter.day

FOR y = 1 TO 30
FOR x = 1 TO 310
c = INT(RND * 2 + 1)
IF c = 2 THEN c = 15
PSET (x, y), c
NEXT
NEXT

END SUB