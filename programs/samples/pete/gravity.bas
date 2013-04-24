CLS
SCREEN 12
LET pi = 3.14159

LET accely = 0
LET ballx = 100
LET bally = 100

INPUT "Initial X Acceleration: ", accelx
CLS

LINE (0, 0)-(640, 480), 15, BF

FOR w = 1 TO 1000000
NEXT w

DO
CIRCLE (ballx, bally), 20, 15
LINE (COS(ballangle) * 20 + ballx, SIN(ballangle) * 20 + bally)-(COS(ballangle) * -20 + ballx, SIN(ballangle) * -20 + bally), 15

IF ballangle >= 2 * pi THEN LET ballangle = ballangle - 2 * pi

'###################### Y CONTROL #######################

IF bally + 20 < 480 AND accely < 4 THEN
 LET accely = accely + .06
END IF

IF accely <> 0 THEN
 LET bally = bally + accely
END IF

'###################### X CONTROL #######################

'This should work
IF ballx + 20 >= 640 AND accelx > 0 THEN
 LET accelx = accelx * -.5
ELSEIF ballx - 20 <= 0 AND accelx < 0 THEN
 LET accelx = accelx * -.5
END IF


IF accely > 0 AND bally + 20 >= 480 THEN
LET accely = accely * -.6
IF accelx > 0 THEN
  LET accelx = accelx - .05
  ELSEIF accelx < 0 THEN
  LET accelx = accelx + .05
END IF
ELSEIF accely <= 0 THEN
 IF accelx > 0 THEN
  LET accelx = accelx - .002
 ELSEIF accelx < 0 THEN
  LET accelx = accelx + .002
 END IF
END IF

IF accelx <> 0 THEN
LET ballx = ballx + accelx
LET ballangle = ballangle + accelx / pi / 10
END IF


'###################### DRAW #######################

CIRCLE (ballx, bally), 20, 0
LINE (COS(ballangle) * 20 + ballx, SIN(ballangle) * 20 + bally)-(COS(ballangle) * -20 + ballx, SIN(ballangle) * -20 + bally), 0

LET key$ = INKEY$
FOR w = 1 TO 40000
IF key$ <> "" THEN END
NEXT w

LOOP

