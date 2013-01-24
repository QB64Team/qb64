CLS
SCREEN 12
LET pi = 3.14159

DO
                                'ANGLE increase
FOR v = 0 TO 2 * pi STEP .008
LET v3 = v3 + .003
LET v4 = v4 + .01

IF v3 >= 2 * pi THEN
LET v3 = .003
END IF

IF v4 >= 2 * pi THEN
LET v4 = .01
END IF

                'CALCULATE
                'COS is for X
                'SIN is for Y
                        'Multiplier is for SIZE and
                        'addition is for OFFSET.
                        'Combine two equations with offset to
                        'get double rotation!

LET x = COS(v3) * 180 + (COS(v) * -20 + 320)
LET y = SIN(v3) * 180 + (SIN(v) * -20 + 240)
LET x2 = COS(v3) * 180 + (COS(v) * 20 + 320)
LET y2 = SIN(v3) * 180 + (SIN(v) * 20 + 240)

LET x3 = COS(v3) * 180 + (COS(v) * 0 + 320)
LET y3 = SIN(v3) * 180 + (SIN(v) * 0 + 240)

LET x4 = COS(v) * 20 + 320
LET y4 = SIN(v) * 20 + 240
LET x5 = COS(v4) * 80 + 320
LET y5 = SIN(v4) * 80 + 240

                                'DRAW
LINE (x, y)-(x2, y2), 15
CIRCLE (x3, y3), 20, 15
CIRCLE (x4, y4), 40, 15
CIRCLE (x5, y5), 10, 15

                                'WAIT and key press=exit
        LET key$ = INKEY$
FOR v2 = 1 TO 10000
        IF key$ <> "" THEN
        END
        END IF
NEXT v2

                                'ERASE
LINE (x, y)-(x2, y2), 0
CIRCLE (x3, y3), 20, 0
CIRCLE (x4, y4), 40, 0
CIRCLE (x5, y5), 10, 0

NEXT v
LOOP

