'3DEXP2.BAS By Rich Geldreich June 2nd, 1992
'A fast, QuickBASIC 4.5 3-D wireframe animation program.
'Compile it for maximum speed!
'If you have any questions or ideas, please write/call:

'Rich Geldreich
'410 Market St.
'Gloucester City, NJ 08030
'(609)-742-8752

'The following program is in the public domain! Have fun!
'Also look at VECT.ASM
DEFINT A-Z
TYPE LineType
    X AS INTEGER
    Y AS INTEGER
    Z AS INTEGER
    X1 AS INTEGER
    Y1 AS INTEGER
    Z1 AS INTEGER
END TYPE
DIM Points(100) AS LineType
DIM Xn(100), Yn(100), Zn(100)
DIM Xs1(100), Ys1(100), Xe1(100), Ye1(100)
DIM X(100), Y(100), Z(100), Pointers1(100), Pointers2(100), Sp(100), Zp(100)
DIM R(100), B(63), B1(63)
DIM Cosine&(360), Sine&(360)
CLS
PRINT "3-D Craft v1a"
PRINT "By Rich Geldreich June 2nd, 1992"
PRINT
PRINT "Keys to use: (Turn NUMLOCK on!)"
PRINT "Q...............Quits"
PRINT "Numeric keypad..Controls your position(press 5 on the keypad"
PRINT "                to completly stop yourself) "
PRINT "-...............Forward exceleration"
PRINT "+...............Backward exceleration"
PRINT "Arrow keys......Controls the rotation of the craft"
PRINT "F...............Excelerates the craft (Forward)"
PRINT "B...............Slows the craft (Backward)"
PRINT "S...............Stops the craft"
PRINT "A...............Toggles Auto Center, use this when you lose";
PRINT " the craft"
PRINT "C...............Stops the craft's rotation"
PRINT "V...............Resets the craft to starting position"
PRINT
PRINT "Wait a sec..."

'The following for/next loop makes a sine & cosine table.
'Each sine & cosine is multiplied by 1024 and stored as long integers.
'This is done so that we don't have to use any slow floating point
'math at run time.
A = 0
FOR A! = 0 TO 359 / 57.29577951# STEP 1 / 57.29577951#
    Cosine&(A) = INT(.5 + COS(A!) * 1024)
    Sine&(A) = INT(.5 + SIN(A!) * 1024): A = A + 1
NEXT
'Next we read in all of the lines that are in the object...
FOR A = 0 TO 44
    READ Points(A).X, Points(A).Y, Points(A).Z
    READ Points(A).X1, Points(A).Y1, Points(A).Z1
NEXT
'Here comes the hard part... Consider this scenario:

'We have two connected lines, like this:

'   1--------2 and 3
'            |
'            |
'            |
'            |
'            4
'Where 1,2, 3, & 4 are the starting and ending points of each line.
'The first line consists of points 1 & 2  and the second line
'is made of points 3 & 4.
'So, you ask, what's wrong? Nothing, really, but don't you see that
'points 2 and 3 are really at the sample place? Why rotate them twice,
'that would be a total waste of time? The following code eliminates such
'occurrences from the line table. (great explanation, huh?)

NumberLines = 45
'take all of the starting & ending points and put them in one big
'array...
Np = 0
FOR A = 0 TO NumberLines - 1
    X(Np) = Points(A).X
    Y(Np) = Points(A).Y
    Z(Np) = Points(A).Z
    Np = Np + 1
    X(Np) = Points(A).X1
    Y(Np) = Points(A).Y1
    Z(Np) = Points(A).Z1
    Np = Np + 1
NEXT
'Now set up two sets of pointers that point to each point that a line
'is made of... (in other words, scan for the first occurrence of each
'starting and ending point in the point array we just built...)
FOR A = 0 TO NumberLines - 1
    Xs = Points(A).X
    Ys = Points(A).Y
    Zs = Points(A).Z            'get the 3 coordinates of the start point
    FOR B = 0 TO Np - 1         'scan the point array
        IF X(B) = Xs AND Y(B) = Ys AND Z(B) = Zs THEN
            Pointers1(A) = B    'set the pointer to point to the
            EXIT FOR            'point we have just found
        END IF
    NEXT
    Xs = Points(A).X1           'do the same thing that we did above
    Ys = Points(A).Y1           'except scan for the ending point
    Zs = Points(A).Z1           'of each line
    FOR B = 0 TO Np - 1
        IF X(B) = Xs AND Y(B) = Ys AND Z(B) = Zs THEN
            Pointers2(A) = B
            EXIT FOR
        END IF
    NEXT
NEXT
'Okay, were almost done! All we have to do now is to build a table
'that tells us which points to actually rotate...
Nr = 0
FOR A = 0 TO NumberLines - 1
    F1 = Pointers1(A)   'get staring & ending point number
    S1 = Pointers2(A)
    IF Nr = 0 THEN      'if this is the first point then it of course
                        'has to be rotated
        R(Nr) = F1: Nr = Nr + 1
    ELSE
        Found = 0       'scan to see if this point already exists...
        FOR B = 0 TO Nr - 1
            IF R(B) = F1 THEN
                Found = -1: EXIT FOR    'shoot, it's already here!
            END IF
        NEXT
        IF NOT Found THEN R(Nr) = F1: Nr = Nr + 1   'point the point
                                                    'in the array it we
    END IF                                          'can't find it...
        
    Found = 0   'now look for the ending point
    FOR B = 0 TO Nr - 1
        IF R(B) = S1 THEN
            Found = -1: EXIT FOR
        END IF
    NEXT
    IF NOT Found THEN R(Nr) = S1: Nr = Nr + 1
NEXT
FOR A = 0 TO 63
    B(A) = (4 * A) \ 8
    B1(A) = A - B(A)
NEXT
PRINT "Press any key to begin..."
A$ = INPUT$(1)

Deg1 = 0: Deg2 = 0: D1 = 0: D2 = 0

Spos = -200: Mypos = 0

Mx = 0: My = 0: Mz = 0: Ox = 0: Oy = 0: Oz = -260

NumberOfFrames = 0
DEF SEG = &H40
StartTime = PEEK(&H6C)

SCREEN 13
FOR A = 0 TO 63
    OUT &H3C7, A: OUT &H3C8, A: OUT &H3C9, A: OUT &H3C9, 0: OUT &H3C9, 0
NEXT

DO


    
    Deg1 = (Deg1 + D1) MOD 360
    Deg2 = (Deg2 + D2) MOD 360
    IF Deg1 < 0 THEN Deg1 = Deg1 + 360
    IF Deg2 < 0 THEN Deg2 = Deg2 + 360
   
    C1& = Cosine&(Deg1): S1& = Sine&(Deg1)
    C2& = Cosine&(Deg2): S2& = Sine&(Deg2)
    C3& = Cosine&(Deg3): S3& = Sine&(Deg3)
    'Deg3 = (Deg3 + 5) MOD 360
   
    X = Speed: Y = 0: Z = 0
 
    X1 = (X * C1&) \ 1024: Y1 = (X * S1&) \ 1024
    X2 = (X1 * C2&) \ 1024: Zn = (X1 * S2&) \ 1024
   
    Y3 = (Y1 * C3& - Zn * S3&) \ 1024
    Z3 = (Y1 * S3& + Zn * C3&) \ 1024
   
    Ox = Ox + X2: Oy = Oy + Y3: Oz = Oz + Z3
    IF Oz > 32000 THEN Oz = 32000
    IF Oz < -32000 THEN Oz = -32000
    IF Ox > 32000 THEN Ox = 32000
    IF Ox < -32000 THEN Ox = -32000
    IF Oy > 32000 THEN Oy = 32000
    IF Oy < -32000 THEN Oy = -32000
   
    
    IF AtLoc THEN
        Mx = Mx + (Ox - Mx) \ 4
        My = My + (Oy - My) \ 4
        Mz = Mz + ((Oz + 200) - Mz) \ 4
    ELSE
        'adjust the users position based on how much he is moving...
        Mz = Mz + Mzm: Mx = Mx + Mxm: My = My + Mym
        IF Mz > 32000 THEN Mz = 32000
        IF Mz < -32000 THEN Mz = -32000
        IF Mx > 32000 THEN Mx = 32000
        IF Mx < -32000 THEN Mx = -32000
        IF My > 32000 THEN My = 32000
        IF My < -32000 THEN My = -32000
    END IF
   
    LOCATE 1, 1: PRINT A$
    
    MaxZ = -32768
    LowZ = 32767
    FOR A = 0 TO Nr - 1
        R = R(A)
        Xo = X(R): Yo = Y(R): Zo = Z(R)
        
        X1 = (Xo * C1& - Yo * S1&) \ 1024
        Y1 = (Xo * S1& + Yo * C1&) \ 1024
       
        X2& = (X1 * C2& - Zo * S2&) \ 1024 - Mx + Ox
        Z2 = (X1 * S2& + Zo * C2&) \ 1024
        
        Y3& = (Y1 * C3& - Z2 * S3&) \ 1024 - My + Oy
        Z4 = (Y1 * S3& + Z2 * C3&) \ 1024
        
        Z3 = Z4 - Mz + Oz
       

        Zn(R) = Z4
        IF Z4 > MaxZ THEN MaxZ = Z4
        IF Z4 < LowZ THEN LowZ = Z4
       
        'X2&,Y3&,Z3

        'if the point is too close(or behind) the viewer then
        'don't draw it...
        IF (Mypos - Z3) < 15 THEN
            Xn(R) = -1000: Yn(R) = 0: Zn = 0
        ELSE
            V = (1330& * (Spos - Z3)) \ (Mypos - Z3)
            Xn(R) = 160 + X2& + (-X2& * V) \ 1330
            Yn(R) = 100 + (8 * (Y3& + (-Y3& * V) \ 1330)) \ 10
        END IF
    NEXT
       
    MaxZ = MaxZ - LowZ
   
       
    Nl = 0
    FOR A = 0 TO NumberLines - 1
        F1 = Pointers1(A): S1 = Pointers2(A)
        IF Xn(F1) <> -1000 AND Xn(S1) <> -1000 THEN
            Sp(Nl) = A
            Zp(A) = (Zn(F1) + Zn(S1)) \ 2
            Nl = Nl + 1
        END IF
    NEXT
    Nl = Nl - 1
    'sort lines according to their Z coordinates 
    IF Nl > -1 THEN
        Mid = Nl \ 2
        DO
            FOR A = 0 TO Nl - Mid
                IF Zp(Sp(A)) > Zp(Sp(A + Mid)) THEN
                    SWAP Sp(A), Sp(A + Mid)
                    CL = A - Mid
                    CH = A
                    DO WHILE CL >= 0
                        IF Zp(Sp(CL)) > Zp(Sp(CH)) THEN
                            SWAP Sp(CL), Sp(CH)
                            CH = CL
                            CL = CL - Mid
                        ELSE
                            EXIT DO
                        END IF
                    LOOP
                END IF
            NEXT
            Mid = Mid \ 2
        LOOP WHILE Mid > 0
    END IF
    'wait for vertical retrace
    WAIT &H3DA, 8
    'erase old points
    FOR A = Ln - 1 TO 0 STEP -1
        LINE (Xs1(A), Ys1(A))-(Xe1(A), Ye1(A)), 0
    NEXT
   
    Ln = 0
    FOR A1 = 0 TO Nl
        A = Sp(A1)
       
        Z = Zp(A)
        F1 = Pointers1(Sp(A1)): S1 = Pointers2(Sp(A1))
       
        Xn = Xn(F1): Yn = Yn(F1)
        
        IF Xn <> -1000 THEN
            X1 = Xn(S1)
            IF X1 <> -1000 THEN
                Y1 = Yn(S1)
                Z1 = (Z - Mz + Oz)
                
                IF Z1 > -1500 THEN
                    'calculate color
                    T = 63 - ((Z1 * -63&) \ 1500)
                    C = B1(T) + (B(T) * (Z - LowZ)) \ MaxZ
                    'draw line  
                    LINE (X1, Y1)-(Xn, Yn), C
                    'store for later                 
                    Xs1(Ln) = X1: Ys1(Ln) = Y1
                    Xe1(Ln) = Xn: Ye1(Ln) = Yn
                    Ln = Ln + 1
                END IF
            END IF
        END IF
    NEXT
    'process keystroke
    K$ = UCASE$(INKEY$)
    'Process the keystroke(if any)...
    IF K$ <> "" THEN
        SELECT CASE K$
            CASE "A"
                AtLoc = NOT AtLoc
            CASE "+"
                Mzm = Mzm + 2
            CASE "-"
                Mzm = Mzm - 2
            CASE "5"
                Mxm = 0: Mym = 0: Mzm = 0
            CASE "4"
                Mxm = Mxm - 2
            CASE "6"
                Mxm = Mxm + 2
            CASE "8"
                Mym = Mym - 2
            CASE "2"
                Mym = Mym + 2
            CASE "F"
                Speed = Speed + 5
            CASE "B"
                Speed = Speed - 5
            CASE "C"
                D1 = 0: D2 = 0
            CASE "S"
                Speed = 0
            CASE CHR$(0) + CHR$(72)
                D1 = D1 + 1
            CASE CHR$(0) + CHR$(80)
                D1 = D1 - 1
            CASE CHR$(0) + CHR$(75)
                D2 = D2 - 1
            CASE CHR$(0) + CHR$(77)
                D2 = D2 + 1
            CASE "Q", CHR$(27)
                SCREEN 0, , 0, 0: WIDTH 80
                CLS
                PRINT "By Rich Geldreich June 2nd, 1992"
                PRINT "See ya later!"
                END
            CASE "V"
                D1 = 0: D2 = 0: Deg1 = 0: Deg2 = 0: Speed = 0
        END SELECT
    END IF
    'NumberOfFrames = NumberOfFrames + 1
    'see if 20 frames have passed; if so then see
    'how long it took...
    'IF NumberOfFrames = 20 THEN
    '    TotalTime = PEEK(&H6C) - StartTime
    '    IF TotalTime < 0 THEN TotalTime = TotalTime + 256
    '    FramesPerSecX100 = 36400 \ TotalTime
    '    High = FramesPerSecX100 \ 100
    '    Low = FramesPerSecX100 - High
    '    'A$ has the string that is printed at the upper left
    '    'corner of the screen
    '    A$ = MID$(STR$(High), 2) + "."
    '    A$ = A$ + RIGHT$("0" + MID$(STR$(Low), 2), 2) + "  "
    '    NumberOfFrames = 0
    '    StartTime = PEEK(&H6C)
    'END IF
LOOP
'The following data is the shuttle craft...
'stored as Start X,Y,Z & End X,Y,Z
DATA -157,22,39,-157,-18,39
DATA -157,-18,39,-127,-38,39
DATA -127,-38,39,113,-38,39
DATA 113,-38,39,193,12,39
DATA 33,42,39,33,42,-56
DATA 33,42,-56,-127,42,-56
DATA -127,42,-56,-157,22,-56
DATA -157,22,-56,-157,22,39
DATA -157,22,-56,-157,-18,-56
DATA -157,-18,-56,-157,-18,39
DATA -157,-18,-56,-127,-38,-56
DATA -127,-38,-56,-127,-38,39
DATA -127,-38,-56,113,-38,-56
DATA 113,-38,-56,113,-38,39
DATA 113,-38,-56,193,12,-56
DATA 193,12,-56,193,12,39
DATA -157,22,-56,193,12,-56
DATA 193,12,39,-157,22,39
DATA -56,-13,41,-56,-3,41
DATA -56,-3,41,-26,-3,41
DATA -26,-3,41,-26,7,41
DATA -51,7,41,-31,-13,41
DATA -11,-13,41,-11,-3,41
DATA -11,-3,41,-1,7,41
DATA 9,7,41,9,-8,41
DATA 9,-8,41,24,-8,41
DATA 34,16,41,34,-38,41
DATA 33,-39,41,33,-39,-53
DATA 33,-39,-53,33,15,-53
DATA -42,-38,19,-72,-38,19
DATA -72,-38,19,-72,-38,-41
DATA -72,-38,-41,-42,-38,-41
DATA -42,-38,-41,-42,-38,19
DATA 33,42,39,34,16,41
DATA 33,42,-56,33,15,-53
DATA -157,22,39,-127,42,39
DATA -127,42,-56,-127,42,39
DATA -127,42,39,33,42,39
DATA 159,-8,-56,159,-8,40
DATA 143,-18,-56,143,-18,39
DATA 193,12,39,193,32,30
DATA 33,42,39,193,32,30
DATA 193,32,30,193,32,-47
DATA 33,42,-56,193,32,-47
DATA 193,12,-56,193,32,-47
 

