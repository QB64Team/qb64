'-----------------------------------------------------------------------
'GUJERO2.BAS by Antoni Gual 2/2004
'For the QBNZ 1/2004 9 liner contest
'-----------------------------------------------------------------------
'Tunnel effect (more or less)
'FFIX recommended. It does compile.
'-----------------------------------------------------------------------
'DECLARE SUB ffix
'ffix
1 IF i = 0 THEN SCREEN 13 ELSE IF i = 1 THEN OUT &H3C8, 0 ELSE IF i <= 194 THEN OUT &H3C9, INT((i - 2) / 3)
2  IF i <= 194 THEN GOTO 8
3  FOR y = -100 TO 99
4 FOR x = -160 TO 159
5  IF x >= 0 THEN IF y < 0 THEN alpha = 1.57079632679# + ATN(x / (y + .000001)) ELSE alpha = -ATN(y / (x + .000001)) ELSE IF y < 0 THEN alpha = 1.57079632679# + ATN(x / (y + .000001)) ELSE alpha = -1.57079632679# + ATN(x / (y + .000001))
6  PSET (x + 160, y + 100), (x * x + y * y) * .00003 * ((INT(-10000 * i + 5.2 * SQR(x * x + y * y)) AND &H3F) XOR (INT((191 * alpha) + 10 * i) AND &H3F))
7 NEXT x, y
8 i = i + 1
9 IF LEN(INKEY$) = 0 THEN GOTO 1

