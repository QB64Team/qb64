'Program (c) T.A.Giles - Mar 2001
'Right Angle Triangle Solver v 1.1
'640 x 480 graphics resolution
SCREEN 12
start:
CLS
'degrees - radians conversion ratios
LET dr = .0174532925199#
LET rd = 57.2957795131#
LOCATE 1, 34
COLOR 7
PRINT "Right Angle Triangle Solver v 1.1 (c) T.A.Giles"
'Draw Triangle
LINE (50, 400)-(400, 400), 2  'Side A
LINE (400, 400)-(400, 150), 2 'Side B
LINE (400, 150)-(50, 400), 2  'Side C
LINE (360, 400)-(360, 360), 2 'Vert box
LINE (360, 360)-(400, 360), 2 'Hori box
'Print Side and Angle labels
COLOR 3
LOCATE 27, 27
PRINT "Side A"
LOCATE 18, 53
PRINT "Side B"
LOCATE 16, 23
PRINT "Side C"
LOCATE 24, 15
COLOR 14
PRINT "Angle b"
LOCATE 14, 43
PRINT "Angle a"
COLOR 15
lab0:
'Re-set print position for output
LOCATE 1, 1
LET f = 0' Binary flag
'Input data routine
PRINT "Enter '0' if unknown"
INPUT "Side A "; a
INPUT "Side B "; b
INPUT "Side C "; c
INPUT "Angle a (deg)"; x
INPUT "Angle b (deg)"; y
'Error trapping routine
IF a < 0 OR b < 0 OR c < 0 OR x < 0 OR y < 0 THEN GOTO err1
IF x >= 90 OR y >= 90 OR x + y > 90 THEN GOTO err1
IF a >= c AND c > 0 OR b >= c AND c > 0 THEN GOTO err1
IF a > 0 AND b > 0 AND c > 0 AND NOT c = SQR(a ^ 2 + b ^ 2) THEN GOTO err1
IF NOT x = 0 THEN LET y = 90 - x
'Degrees to Radians conversion
LET x = x * dr
LET y = y * dr
'Binary flag routine
IF a = 0 THEN LET f = f + 1
IF b = 0 THEN LET f = f + 2
IF c = 0 THEN LET f = f + 4
IF y = 0 THEN LET f = f + 8
IF f = 1 OR f = 3 THEN GOTO lab1
IF f = 2 OR f = 6 THEN GOTO lab2
IF f = 4 OR f = 5 THEN GOTO lab3
IF f = 8 OR f = 9 THEN GOTO lab4
IF f = 10 THEN GOTO lab5
IF f = 12 THEN GOTO lab6
err1:
SOUND 750, 1
GOTO lab0
lab1:
LET a = c * COS(y)
LET b = c * SIN(y)
LET c = a / COS(y)
GOTO lab9
lab2:
LET b = a * TAN(y)
LET c = a / COS(y)
GOTO lab9
lab3:
LET a = b / TAN(y)
LET c = a / COS(y)
GOTO lab9
lab4:
LET a = SQR(c ^ 2 - b ^ 2)
LET y = ATN(b / a)
GOTO lab9
lab5:
LET b = SQR(c ^ 2 - a ^ 2)
LET y = ATN(b / a)
GOTO lab9
lab6:
LET y = ATN(b / a)
LET c = a / COS(y)
lab9:
'Output routine
LOCATE 1, 1
PRINT "  ........ SOLUTION ........"
PRINT "   Side A = "; a
PRINT "   Side B = "; b
PRINT "   Side C = "; c
PRINT "   Angle a (deg) = "; 90 - y * rd
PRINT "   Angle b (deg) = "; y * rd
PRINT "   Area of Triangle = "; (a * b) / 2
LOCATE 29, 1
INPUT "Ctrl+Break > EXIT : Enter > MORE"; x
GOTO start