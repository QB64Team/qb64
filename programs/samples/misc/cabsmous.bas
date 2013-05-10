'Mouse utilities for text mode. Written by TFM 9/11/94
'Uses INT 33 to use a Microsoft Compatable mouse driver
'Written in basic calling an assembly language routine.
'Works in normal basic

DECLARE FUNCTION inbox! (boxx1!, boxx2!, boxy1!, boxy2!)            'if pointer is in box return 1 else return 0
DECLARE FUNCTION inboxpress1! (boxx1!, boxx2!, boxy1!, boxy2!)      'if last press was in box return 1 else return 0
DECLARE FUNCTION inboxpress2! (boxx1!, boxx2!, boxy1!, boxy2!)      'if last press was in box return 1 else return 0
DECLARE FUNCTION inboxrelease1! (boxx1!, boxx2!, boxy1!, boxy2!)    'if last release was in box return 1 else return 0
DECLARE FUNCTION inboxrelease2! (boxx1!, boxx2!, boxy1!, boxy2!)    'if last release was in box return 1 else return 0
DECLARE SUB releasemouse (button!)               'mouse x & y = last place botton 1 pressed
DECLARE SUB pressmouse (button!)                 'mouse x & y = last place botton 1 released
DECLARE SUB hidemouse ()                         'hide mose
DECLARE SUB mouseinterupt (ax!, bx!, cx!, dx!)   'int 33 with register values
DECLARE SUB initmouse ()                         'sets up mouse & if found mouse passed = 1
DECLARE SUB showmouse ()                         'show the mouse
DECLARE SUB getxymouse ()                        'get position of mouse in mouse x & y and mouse buttons in mousebutton 1 & 2
DECLARE SUB verticalmouse (miny!, maxy!)         'Set vertical mouse limmits
DECLARE SUB horizontalmouse (miny!, maxy!)       'Set horizontal mouse limmits

DIM SHARED ax AS INTEGER
DIM SHARED bx AS INTEGER
DIM SHARED cx AS INTEGER
DIM SHARED dx AS INTEGER
DIM SHARED mousex AS INTEGER
DIM SHARED mousey AS INTEGER
DIM SHARED mousebutton1 AS INTEGER
DIM SHARED mousebutton2 AS INTEGER
DIM SHARED mousevisible AS INTEGER
DIM SHARED mousepassed AS INTEGER

CLS

CALL initmouse
CALL showmouse
CALL horizontalmouse(10, 70)    'Set mouse position (min and max)
CALL verticalmouse(10, 15)      'Set mouse position

DO
    CALL pressmouse(1)      'Wait for button 1 to be pressed

    CALL getxymouse         'Store current positon in globals
                            'This isn't needed coz pressmouse(1)
                            'Already does it, but it is an example
   
        'Display position, stored in global variables
    LOCATE 24, 1
    PRINT "X - "; mousex, "  Y - "; mousey, "  Button1 - "; mousebutton1; "     Button2 - "; mousebutton2;
   
    IF inboxpress1(10, 70, 10, 12) THEN
        LOCATE 24, 70
        PRINT "*";
    ELSE
        LOCATE 24, 70
        PRINT " ";
    END IF
    IF mousebutton1 = 1 THEN CALL hidemouse
    IF mousebutton2 = 1 THEN CALL showmouse
LOOP

SUB getxymouse


IF mousepassed = 1 THEN
   
    CALL mouseinterupt(&H3, 0, 0, 0)

    mousex = (cx / 8) + 1
    mousey = (dx / 8) + 1
    button = bx


    IF button = 0 THEN
        mousebutton1 = 0: mousebutton2 = 0
    ELSEIF button = 1 THEN
        mousebutton1 = 1: mousebutton2 = 0
    ELSEIF button = 2 THEN
        mousebutton1 = 0: mousebutton2 = 1
    ELSEIF button = 3 THEN
        mousebutton1 = 1: mousebutton2 = 1
    END IF

    DEF SEG


    LOCATE 24, 1
    PRINT "X - "; mousex, "  Y - "; mousey, "  Button1 - "; mousebutton1; "     Button2 - "; mousebutton2;
ELSE
    LOCATE 24, 1
    PRINT "Sorry no mouse found"
END IF
END SUB

SUB hidemouse

IF mousepassed = 1 THEN
    IF mousevisible = 1 THEN
        CALL mouseinterupt(2, 0, 0, 0)
        mousevisible = 0
    END IF
ELSE
    LOCATE 24, 1
    PRINT "Sorry no mouse found"
END IF

END SUB

SUB horizontalmouse (minx, maxx)

IF mousepassed = 1 THEN
    IF minx < 0 THEN maxx = 0
    IF maxx > 80 THEN maxx = 80
    IF maxx < minx THEN maxx = minx
    CALL mouseinterupt(7, 0, (minx - 1) * 8, (maxx - 1) * 8)
ELSE
    LOCATE 24, 1
    PRINT "Sorry no mouse found"
END IF

END SUB

FUNCTION inbox (boxx1, boxx2, boxy1, boxy2)

IF mousepassed = 1 THEN
    CALL getxymouse
    IF mousex <= boxx2 AND mousex >= boxx1 AND mousey <= boxy2 AND mousey >= boxy1 THEN
        inbox = 1
    ELSE
        inbox = 0
    END IF
ELSE
    LOCATE 24, 1
    PRINT "Sorry no mouse found"
END IF


END FUNCTION

FUNCTION inboxpress1 (boxx1, boxx2, boxy1, boxy2)

IF mousepassed = 1 THEN
    CALL pressmouse(1)
    IF mousex <= boxx2 AND mousex >= boxx1 AND mousey <= boxy2 AND mousey >= boxy1 THEN
        inboxpress1 = 1
    ELSE
        inboxpress1 = 0
    END IF
ELSE
    LOCATE 24, 1
    PRINT "Sorry no mouse found"
END IF

END FUNCTION

FUNCTION inboxpress2 (boxx1, boxx2, boxy1, boxy2)

IF mousepassed = 1 THEN
    CALL pressmouse(2)
    IF mousex <= boxx2 AND mousex >= boxx1 AND mousey <= boxy2 AND mousey >= boxy1 THEN
        inboxpress2 = 1
    ELSE
        inboxpress2 = 0
    END IF
ELSE
    LOCATE 24, 1
    PRINT "Sorry no mouse found"
END IF

END FUNCTION

FUNCTION inboxrelease1 (boxx1, boxx2, boxy1, boxy2)

IF mousepassed = 1 THEN
    CALL releasemouse(1)
    IF mousex <= boxx2 AND mousex >= boxx1 AND mousey <= boxy2 AND mousey >= boxy1 THEN
        inboxrelease1 = 1
    ELSE
        inboxrelease1 = 0
    END IF
ELSE
    LOCATE 24, 1
    PRINT "Sorry no mouse found"
END IF


END FUNCTION

FUNCTION inboxrelease2 (boxx1, boxx2, boxy1, boxy2)

IF mousepassed = 1 THEN
    CALL releasemouse(2)
    IF mousex <= boxx2 AND mousex >= boxx1 AND mousey <= boxy2 AND mousey >= boxy1 THEN
        inboxrelease2 = 1
    ELSE
        inboxrelease2 = 0
    END IF
ELSE
    LOCATE 24, 1
    PRINT "Sorry no mouse found"
END IF


END FUNCTION

SUB initmouse


CALL mouseinterupt(0, 0, 0, 0)

IF ax = 2 THEN
    mousepassed = 1
ELSE
    mousepassed = 0
END IF

END SUB


SUB mouseinterupt (m1, m2, m3, m4)

n1 = 0: n2 = 0: n3 = 0: n4 = 0

DO WHILE m1 > 255
    m1 = m1 - 255
    n1 = n1 + 1
LOOP
DO WHILE m2 > 255
    m2 = m2 - 255
    n2 = n2 + 1
LOOP
DO WHILE m3 > 255
    m3 = m3 - 255
    n3 = n3 + 1
LOOP
DO WHILE m4 > 255
    m4 = m4 - 255
    n4 = n4 + 1
LOOP

    DIM b%(47)
    DEF SEG = VARSEG(b%(0))

    POKE VARPTR(b%(0)) + 0, &H50        'push AX
    POKE VARPTR(b%(0)) + 1, &H53        'push BX
    POKE VARPTR(b%(0)) + 2, &H51        'push CX
    POKE VARPTR(b%(0)) + 3, &H52        'push DX
    POKE VARPTR(b%(0)) + 4, &H1E        'push DS

    POKE VARPTR(b%(0)) + 5, &HB8
    POKE VARPTR(b%(0)) + 6, m1         'set AX
    POKE VARPTR(b%(0)) + 7, n1
   
    POKE VARPTR(b%(0)) + 8, &HBB
    POKE VARPTR(b%(0)) + 9, m2         'set BX
    POKE VARPTR(b%(0)) + 10, n2

    POKE VARPTR(b%(0)) + 11, &HB9
    POKE VARPTR(b%(0)) + 12, m3         'set CX
    POKE VARPTR(b%(0)) + 13, n3

    POKE VARPTR(b%(0)) + 14, &HBA
    POKE VARPTR(b%(0)) + 15, m4         'set DX
    POKE VARPTR(b%(0)) + 16, n4
   
    POKE VARPTR(b%(0)) + 17, &HCD        'INT 33
    POKE VARPTR(b%(0)) + 18, &H33
   
    POKE VARPTR(b%(0)) + 19, &H50        'push AX

    POKE VARPTR(b%(0)) + 20, &HB8        'AX = B800
    POKE VARPTR(b%(0)) + 21, &H0
    POKE VARPTR(b%(0)) + 22, &HB8

    POKE VARPTR(b%(0)) + 23, &H8E        'DS = AX
    POKE VARPTR(b%(0)) + 24, &HD8
          
    POKE VARPTR(b%(0)) + 25, &H58       'pop AX
   
    POKE VARPTR(b%(0)) + 26, &H89
    POKE VARPTR(b%(0)) + 27, &H1E       '[0001] = AX
    POKE VARPTR(b%(0)) + 28, &HA1
    POKE VARPTR(b%(0)) + 29, &HF
   
    POKE VARPTR(b%(0)) + 30, &H89
    POKE VARPTR(b%(0)) + 31, &H1E       '[0003] = BX
   
    POKE VARPTR(b%(0)) + 32, &HA3
    POKE VARPTR(b%(0)) + 33, &HF

    POKE VARPTR(b%(0)) + 34, &H89
    POKE VARPTR(b%(0)) + 35, &HE        '[0005] = CX
    POKE VARPTR(b%(0)) + 36, &HA5
    POKE VARPTR(b%(0)) + 37, &HF

    POKE VARPTR(b%(0)) + 38, &H89
    POKE VARPTR(b%(0)) + 39, &H16       '[0007] = DX
    POKE VARPTR(b%(0)) + 40, &HA7
    POKE VARPTR(b%(0)) + 41, &HF


    POKE VARPTR(b%(0)) + 42, &H1F       'pop DS
    POKE VARPTR(b%(0)) + 43, &H5A       'pop DX
    POKE VARPTR(b%(0)) + 44, &H59       'pop CX
    POKE VARPTR(b%(0)) + 45, &H5B       'pop BX
    POKE VARPTR(b%(0)) + 46, &H58       'pop AX

    POKE VARPTR(b%(0)) + 47, &HCB       'RETF


    CALL ABSOLUTE(VARPTR(b%(0)))

    DEF SEG = &HB800
    ax = PEEK(&HFA1) + 256 * PEEK(&HFA2)
    bx = PEEK(&HFA3) + 256 * PEEK(&HFA4)
    cx = PEEK(&HFA5) + 256 * PEEK(&HFA6)
    dx = PEEK(&HFA7) + 256 * PEEK(&HFA8)
    

END SUB

SUB movemouse (newx, newy)

IF mousepassed = 1 THEN
    IF newx < 26 AND newx > 0 AND newy < 81 AND newy > 0 THEN
        CALL mouseinterupt(4, 0, (newx - 1) * 8, (newy - 1) * 8)
        mousex = newx
        mousey = newy
    ELSE
        PRINT
        PRINT "Illegal mouse position!!!";
    END IF
ELSE
    LOCATE 24, 1
    PRINT "Sorry no mouse found"
END IF

END SUB

SUB pressmouse (button)

IF mousepassed = 1 THEN
    CALL mouseinterupt(5, button - 1, 0, 0)
    mousex = (cx / 8) + 1
    mousey = (dx / 8) + 1
   

ELSE
    LOCATE 24, 1
    PRINT "Sorry no mouse found"
END IF
END SUB

SUB releasemouse (button)

IF mousepassed = 1 THEN
    CALL mouseinterupt(5, button - 1, 0, 0)
    mousex = (cx / 8) + 1
    mousey = (dx / 8) + 1
ELSE
    LOCATE 24, 1
    PRINT "Sorry no mouse found"
END IF

END SUB

SUB showmouse

IF mousepassed = 1 THEN
    IF mousevisible = 0 THEN
        CALL mouseinterupt(1, 0, 0, 0)
        mousevisible = 1
    END IF
ELSE
    LOCATE 24, 1
    PRINT "Sorry no mouse found"
END IF

END SUB

SUB verticalmouse (miny, maxy)

IF mousepassed = 1 THEN
    IF miny < 0 THEN maxy = 0
    IF maxy > 25 THEN maxy = 25
    IF maxy < miny THEN maxy = miny
    CALL mouseinterupt(8, 0, (miny - 1) * 8, (maxy - 1) * 8)
ELSE
    LOCATE 24, 1
    PRINT "Sorry no mouse found"
END IF


END SUB