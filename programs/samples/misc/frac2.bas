CLS
SCREEN 8
s1 = 225
f1 = 1.4
s2 = 225
f2 = .35
x = .4
y = .1
FOR i = 1 TO 2000
x1 = y + 1 - 1.4 * x * x
y = .3 * x
IF s1 * (x1 + f1) < 640 AND x1 + f1 > 0 THEN
IF s2 * (y + f2) < 350 AND y + f2 > 0 THEN
PSET (s1 * (x1 + f1), s2 * (y + f2))
END IF
END IF
x = x1
NEXT

