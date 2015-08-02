' cube rotator in 11 lines. From a 19 liner by Entropy, shrinked by Antoni Gual
'for Rel's 9 LINER contest at QBASICNEWS.COM  1/2003
'------------------------------------------------------------------------
1 IF x1 = 0 THEN SCREEN 13 ELSE r = (r + .01745) + 6.283185 * (r >= 6.283185)
2  FOR x = -30 TO 30 STEP 10
3    FOR y = -30 TO 30 STEP 10
4      FOR z = -30 TO 30 STEP 10
5        x1 = ((x * COS(r) - (z * COS(r) - y * SIN(r)) * SIN(r)) * COS(r) + (y * COS(r) + z * SIN(r)) * SIN(r)) / (x * SIN(r) + (z * COS(r) - y * SIN(r)) * COS(r) + 100)
6        y1 = ((y * COS(r) + z * SIN(r)) * COS(r) - (x * COS(r) - (z * COS(r) - y * SIN(r)) * SIN(r)) * SIN(r)) / (x * SIN(r) + (z * COS(r) - y * SIN(r)) * COS(r) + 100)
7        PSET ((100 * x1 + 160), (100 * y1 + 100)), 31
'7        PSET ((100 * (((x * COS(r) - (z * COS(r) - y * SIN(r)) * SIN(r)) * COS(r) + (y * COS(r) + z * SIN(r)) * SIN(r)) / (x * SIN(r) + (z * COS(r) - y * SIN(r)) * COS(r) + 100)) + 160), (100 * (((y * COS(r) + z * SIN(r)) * COS(r) - (x * COS(r) - (z * COS(r) - y * SIN(r)) * SIN(r)) * SIN(r)) / (x * SIN(r) + (z * COS(r) - y * SIN(r)) * COS(r) + 100)) + 100)), 31
8  NEXT z, y, x
9  WAIT &H3DA, 8
10 LINE (99, 39)-(221, 161), 0, BF
11 IF LEN(INKEY$) = 0 THEN GOTO 1

