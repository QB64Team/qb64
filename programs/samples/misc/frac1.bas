DIM XX(1 TO 3) AS DOUBLE, YY(1 TO 3) AS DOUBLE, X AS DOUBLE, Y AS DOUBLE
DIM I AS INTEGER
SCREEN 12
WINDOW (0, 0)-(1.6, 1.2)
XX(1) = 0
YY(1) = 0
XX(2) = 2.4 / SQR(3)
YY(2) = 0
XX(3) = 1.2 / SQR(3)
YY(3) = 1.2
DO
I = INT(RND(1) * 3) + 1
X = .5 * (X + XX(I))
Y = .5 * (Y + YY(I))
PSET (X, Y)
LOOP UNTIL INKEY$ = CHR$(27)

