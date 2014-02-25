'Pure QB Realtime Raytracer Demo
'Translated to/optimized for QB by Antoni Gual agual@eic.ictnet.es
'The original was written in C by Texel, a Spanish demo coder.
'It will not work in the IDE due to integer overflow errors.
'Compile with QB 4.0 or QB4.5 + ffix. It does 12.5 fps in my P4 1,4.
'The C version (DOS protected mode, DJGPP) does 50 fps :(

'DECLARE SUB ffix
'ffix
CONST objnum = 4

DIM n AS INTEGER, K AS INTEGER, OBJMIN AS INTEGER, OBJMIN2 AS INTEGER
DIM OBJ(objnum)  AS INTEGER, l AS INTEGER, posi AS INTEGER, POS2 AS INTEGER
DIM s AS INTEGER, t(8200) AS INTEGER, XX AS INTEGER, YY AS INTEGER, XQ AS INTEGER
DIM YQ AS INTEGER, mmmm AS INTEGER, xx1 AS INTEGER, yy1 AS INTEGER
DIM t2(8200) AS INTEGER, ipos AS INTEGER

DIM A(objnum) AS SINGLE, B(objnum) AS SINGLE, C(objnum) AS SINGLE
DIM R(objnum) AS SINGLE

    SCREEN 13
    DEF SEG = &HA000
    'Cambiar la paleta a tonos de azul
    OUT &H3C8, 0'
    FOR n = 0 TO 127
        OUT &H3C9, 0
        OUT &H3C9, INT(n / 4)
        OUT &H3C9, INT(n / 2)
    NEXT
    FOR n = 0 TO 127
        OUT &H3C9, INT(n / 2)
        OUT &H3C9, INT(31 + n / 4)
        OUT &H3C9, 63
    NEXT
    D = 230
    l = 0
   
    'four objects
    OBJ(0) = 0: A(0) = -50 + l: B(0) = 0: C(0) = -100: R(0) = -55 * 55
    OBJ(1) = 0: A(1) = 50 - l: B(1) = -25: C(1) = -120: R(1) = -55 * 55
    OBJ(2) = 0: A(2) = 0: B(2) = 500: C(2) = -220: R(2) = -500! * 500
    OBJ(3) = 1: A(3) = 60: B(3) = -35: C(3) = -30

    tt! = TIMER
    FOR l = 0 TO 199
        
        A(0) = -50 + l
        A(1) = 50 - l
        posi = 400
        mmmm = -1
        'calculamos uno de cada 4 pixels a buffer t()
        FOR Y = -40 TO 39 STEP 2
            FOR X = -80 TO 79 STEP 2
                X0 = X
                Y0 = Y
                GOSUB raytrace
                t(posi) = COL
                posi = posi + 1
            NEXT
        NEXT
        posi = 482
        POS2 = 0
        'calculamos pixels restantes, interpolando si podemos
        FOR YQ = 6 TO 43
            FOR XQ = 2 TO 77
                 'interpolar
                 IF t2(posi) = t2(posi + 1) AND t2(posi) = t2(posi + 80) AND t2(posi) = t2(posi + 81) THEN
                    ipos = (YQ * 1280 + (XQ * 4))
                    FOR YY = 0 TO 3
                        FOR XX = 0 TO 3
                           POKE ipos, (YY * (t(posi + 80) * (4 - XX) + t(posi + 81) * XX) + (t(posi) * (4 - XX) + t(posi + 1) * XX) * (4 - YY)) \ 16
                           ipos = ipos + 1
                        NEXT
                        ipos = ipos + 316
                    NEXT
                 'no interpolar
                 ELSE
                    mmmm = 0
                    FOR yy1 = 0 TO 3
                        FOR xx1 = 0 TO 3
                            IF xx1 OR yy1 THEN
                                X0 = (-160 + XQ * 4 + xx1) / 2
                                Y0 = (-100 + YQ * 4 + yy1) / 2
                                GOSUB raytrace
                                POKE (YQ * 4 + yy1) * 320 + XQ * 4 + xx1, COL
                            ELSE
                                POKE YQ * 1280 + XQ * 4, t(posi)
                            END IF
                        NEXT
                    NEXT
                END IF
                posi = posi + 1
            NEXT
            posi = posi + 4
        NEXT
    IF LEN(INKEY$) THEN EXIT FOR
    NEXT
    COLOR 255: PRINT l / (TIMER - tt!)
    KK$ = INPUT$(1)
END

raytrace:
    Z0 = 0
    MD = 1 / SQR(X0 * X0 + Y0 * Y0 + D * D)
    X1 = X0 * MD
    Y1 = Y0 * MD
    Z1 = -(D + Z0) * MD
    K = 0
    COL = 0
    OBJMIN = objnum
    IF mmmm THEN t2(posi) = objnum
    DO
        TMIN = 327680
        FOR n = 0 TO 2
            IF OBJ(n) = 0 AND (OBJ(n) <> OBJMIN) THEN
                 A0 = A(n) - X0
                 B0 = B(n) - Y0
                 C0 = C(n) - Z0
                 TB = A0 * X1 + B0 * Y1 + C0 * Z1
                 RZ = TB * TB - A0 * A0 - B0 * B0 - C0 * C0
                 IF RZ >= R(n) THEN
                      TN = TB - SQR(RZ - R(n))
                      IF TN < TMIN AND TN > 0 THEN TMIN = TN: OBJMIN2 = n
                 END IF
            END IF
        NEXT
        OBJMIN = OBJMIN2
        IF TMIN < 327680 AND (OBJ(OBJMIN) = 0) THEN
             IF mmmm THEN t2(posi) = t2(posi) * K * objnum * 3 + OBJMIN
             X0 = X0 + X1 * TMIN
             Y0 = Y0 + Y1 * TMIN
             Z0 = Z0 + Z1 * TMIN
             NX = X0 - A(OBJMIN)
             NY = Y0 - B(OBJMIN)
             NZ = Z0 - C(OBJMIN)
             CA = 2 * (NX * X1 + NY * Y1 + NZ * Z1) / (NX * NX + NY * NY + NZ * NZ + 1)
             X1 = X1 - NX * CA
             Y1 = Y1 - NY * CA
             Z1 = Z1 - NZ * CA
             A2 = A(3) - X0
             B2 = B(3) - Y0
             C2 = C(3) - Z0
             MV = 1 / SQR(A2 * A2 + B2 * B2 + C2 * C2)
             A2 = A2 * MV
             B2 = B2 * MV
             C2 = C2 * MV
             s = 0
             FOR n = 0 TO 2
                IF OBJ(n) = 0 AND NOT s THEN
                   A0 = X0 - A(n)
                   B0 = Y0 - B(n)
                   C0 = Z0 - C(n)
                   TB = A2 * A0 + B2 * B0 + C2 * C0
                   RZ = TB * TB - A0 * A0 - B0 * B0 - C0 * C0
                   IF RZ >= R(n) AND TB < 0 THEN s = -1: IF mmmm THEN t2(posi) = t2(posi) * 32
                END IF
             NEXT
             IF NOT s THEN
                IF mmmm THEN t2(posi) = t2(posi) + 1
                col2 = X1 * A2 + Y1 * B2 + Z1 * C2
                IF col2 < 0 THEN col2 = 0
                cc = col2 * col2
                col2 = cc * cc
                MV = SQR(NX * NX + NY * NY + NZ * NZ)
                'IF COL2 < 0 THEN COL2 = 0
                col2 = col2 + (NX * A2 + NY * B2 + NZ * C2) / MV
                IF col2 < 0 THEN col2 = 0
                COL = COL + col2 / ((K + 1) * (K + 1) * 2)
                IF COL > 1 THEN COL = 1
             END IF
        K = K + 1
        END IF
    LOOP WHILE TMIN < 327680 AND K <= 2
    IF K = 0 THEN COL = 50 ELSE COL = COL * 255
RETURN

