'DECLARE SUB raytrace ()
'Antoni Gual raycaster
'Modified from Entropy's an 36-lines entry for the Biskbart's
'40-lines QB Raycaster Compo of fall-2001
'
'Added multikey handler
'Step emulation
'Added different textures, including clouds
'Separe
'with some of my ideas

'to do:
'   add screen buffer
'   optimize rendering loop
'   interpolate rays
'   shadowing
'   subpixel precision
'   make it a game???

'DECLARE SUB ffix ()

'ffix
SCREEN 13

DIM map(9, 9) AS INTEGER 'the map
DIM tex(31, 31, 4) AS INTEGER 'texture array
DIM foff(15) AS INTEGER 'walk simulation vertical offset
DIM kbd(128) AS INTEGER 'keyboard reader array
DIM frames%
DIM persplut(200) AS SINGLE 'vertical offsets for roof and floor
DIM d1(319) AS INTEGER 'temporal arrays raycaster->renderer
DIM d2(319) AS INTEGER
DIM tx(319) AS INTEGER
DIM tm(319) AS INTEGER
DIM dx(319) AS SINGLE
DIM dy(319) AS SINGLE

'read map,do fixed part of persp lut (sky is always in the infinite)
FOR i% = 0 TO 99
    READ map(i% \ 10, i% MOD 10)
    persplut(i%) = 25590 / (i% - 100)
NEXT

'make texture maps (should be read from file)
FOR i% = 0 TO 31
    FOR j% = 0 TO 31
        tex(i%, j%, 0) = (i% XOR j%) 'xor walls
        i1% = i% - 16: j1% = j% - 16
        tex(i%, j%, 1) = SQR((i1% * i1%) + (j1% * j1%)) 'concentric ground tiles
        tex(i%, j%, 2) = 16 - SQR((i1% * i1%) + (j1% * j1%))
NEXT j%, i%

'cloudy texture 1
d1% = 64
d% = 32
tex(0, 0, 3) = 32
WHILE d% > 1
    d2% = d% \ 2
    FOR i% = 0 TO 31 STEP d%
        FOR j% = 0 TO 31 STEP d%
            tex((i% + d2%) AND 31, j%, 3) = (tex(i%, j%, 3) + tex((i% + d%) AND 31, j%, 3) + (RND - .5) * d1%) / 2
            tex(i%, (j% + d2%) AND 31, 3) = (tex(i%, j%, 3) + tex(i%, (j% + d%) AND 31, 3) + (RND - .5) * d1%) / 2
            tex((i% + d2%) AND 31, (j% + d2%) AND 31, 3) = (tex(i%, j%, 3) + tex((i% + d%) AND 31, (j% + d%) AND 31, 3) + (RND - .5) * d1%) / 2
    NEXT j%, i%
    d1% = d1% / 2
    d% = d2%
WEND

'cloudy texture for sky
d1% = 64
d% = 32
tex(0, 0, 4) = 32
WHILE d% > 1
    d2% = d% \ 2
    FOR i% = 0 TO 31 STEP d%
        FOR j% = 0 TO 31 STEP d%
            tex((i% + d2%) AND 31, j%, 4) = (tex(i%, j%, 4) + tex((i% + d%) AND 31, j%, 4) + (RND - .5) * d1%) / 2
            tex(i%, (j% + d2%) AND 31, 4) = (tex(i%, j%, 4) + tex(i%, (j% + d%) AND 31, 4) + (RND - .5) * d1%) / 2
            tex((i% + d2%) AND 31, (j% + d2%) AND 31, 4) = (tex(i%, j%, 4) + tex((i% + d%) AND 31, (j% + d%) AND 31, 4) + (RND - .5) * d1%) / 2
    NEXT j%, i%
    d1% = d1% / 2
    d% = d2%
WEND


'fill step-simulation vertical offset
pioct! = 3.141592 / 8!
FOR i% = 0 TO 15
    foff(i%) = ABS(COS(i% * pioct!) * 64)
NEXT


'set palette
OUT &H3C8, 0
'grey:walls
FOR i% = 0 TO 63
    OUT &H3C9, i%: OUT &H3C9, i%: OUT &H3C9, i%
NEXT
'green:ground
FOR i% = 0 TO 63
    OUT &H3C9, 0: OUT &H3C9, 63 - i%: OUT &H3C9, 0
NEXT
'blue:sky
FOR i% = 0 TO 63
    OUT &H3C9, 63 - i% / 2: OUT &H3C9, 63 - i% / 2: OUT &H3C9, 63
NEXT

    
    
'launch raytracer
'erase key buffer and set num lock off
DEF SEG = &H40: POKE &H1C, PEEK(&H1A): POKE &H17, PEEK(&H17) AND NOT 32

tim! = TIMER
frames% = 0




'SUB raytrace
rtf = 2048
rtl = .0001
inf = 3000000
incu = .05
xpos = 1.5
ypos = 1.5
angle = 0
ini% = 1
'frames loop
DO

    WAIT &H3DA, 8
    WAIT &H3DA, 8, 8

    frames% = frames% + 1

    'keyboard input
    k% = INP(&H60):
    IF k% THEN
        kbd(k% AND 127) = -((k% AND 128) = 0)
        DEF SEG = &H40: POKE &H1C, PEEK(&H1A)
        IF kbd(1) THEN GOTO EXITDO1
        turn% = kbd(&H4D) - kbd(&H4B): kbd(&H4D) = 0: kbd(&H4B) = 0
        mov% = kbd(80) - kbd(72) + ini%
    END IF
    'a movement has happened, update and collision detect
    IF turn% OR mov% THEN
        angle = angle + turn% * .1
        xpos2 = mov% * COS(angle) * incu
        ypos2 = mov% * SIN(angle) * incu

        'calculate walk offsets,and floor part of perspective
        f% = f% + mov%
        foff% = foff(f% AND 15)
        calc = 25600 - 32 * foff%
        FOR y% = 100 TO 199: persplut(y%) = calc / (y% - 99): NEXT

        IF ini% THEN ini% = 0
        dxc = COS(angle) * incu
        dxs = SIN(angle) * incu / 160
        dyc = COS(angle) * incu / 160
        dys = SIN(angle) * incu
        'colision detector

        IF map(INT(ypos - incu), INT(xpos - xpos2 - xpos2 - incu)) = 0 THEN
            IF map(INT(ypos - incu), INT(xpos - xpos2 - xpos2 + incu)) = 0 THEN
                IF map(INT(ypos + incu), INT(xpos - xpos2 - xpos2 - incu)) = 0 THEN
                    IF map(INT(ypos + incu), INT(xpos - xpos2 - xpos2 + incu)) = 0 THEN
                        xpos = xpos - xpos2
                        xpos32 = xpos * 32
                        xp1! = (xpos - INT(xpos)) * rtf
                    END IF
                END IF
            END IF
        END IF
        IF map(INT(ypos - ypos2 - ypos2 - incu), INT(xpos - incu)) = 0 THEN
            IF map(INT(ypos - ypos2 - ypos2 + incu), INT(xpos - incu)) = 0 THEN
                IF map(INT(ypos - ypos2 - ypos2 - incu), INT(xpos + incu)) = 0 THEN
                    IF map(INT(ypos - ypos2 - ypos2 + incu), INT(xpos + incu)) = 0 THEN
                        ypos = ypos - ypos2
                        ypos32 = ypos * 32
                        yp1! = (ypos - INT(ypos)) * rtf
                    END IF
                END IF
            END IF
        END IF


        'raycast loop
        FOR x% = 0 TO 319
            'INIT RAYCASTER
            dx = dxc - (x% - 160) * dxs
            dy = (x% - 160) * dyc + dys
            dx(x%) = dx
            dy(x%) = dy
            SELECT CASE dx
                CASE IS < -rtl
                    nextxt = -xp1! / dx
                    dxt = -rtf / dx
                CASE IS > rtl
                    nextxt = (rtf - xp1!) / dx
                    dxt = rtf / dx
                CASE ELSE
                    nextxt = inf
            END SELECT
            SELECT CASE dy
                CASE IS < -rtl
                    nextyt = -yp1! / dy
                    dyt = -rtf / dy
                CASE IS > rtl
                    nextyt = (rtf - yp1!) / dy
                    dyt = rtf / dy
                CASE ELSE
                    nextyt = inf
            END SELECT
            sdx% = SGN(dx): sdy% = SGN(dy)
            xm% = INT(xpos): ym% = INT(ypos)

            'cast a ray and increase distance  until a wall is hit
            DO
                IF nextxt < nextyt THEN

                    xm% = xm% + sdx%
                    IF map(ym%, xm%) THEN ti = rtf / nextxt: GOTO exitdo2
                    nextxt = nextxt + dxt
                ELSE
                    'ny% = ny% + 1
                    ym% = ym% + sdy%
                    IF map(ym%, xm%) THEN ti = rtf / nextyt: GOTO exitdo2
                    nextyt = nextyt + dyt
                END IF
            LOOP
            exitdo2:
            'Enter texture index, top, bottom into table for this direction

            tm(x%) = map(ym%, xm%) MOD 5
            d1% = 99 - INT((800 + foff%) * ti)
            IF d1% > md1% THEN md1% = d1%
            d1(x%) = d1%
            d2% = 102 + INT((800 - foff%) * ti)
            d2(x%) = d2%
            IF d2% < md2% THEN md2% = d2%
            tx(x%) = ((xpos + ypos + (dx + dy) / ti) * 32) AND 31

        NEXT x%
    END IF

    'rendering  loop (too many products and divisions)

    DEF SEG = &HA000
    FOR x% = 0 TO 319
        d1% = d1(x%)
        d2% = d2(x%)
        tx% = tx(x%)
        d21% = d2% - d1%
        dx = dx(x%)
        dy = dy(x%)
        p& = x%
        mmap% = tm(x%)
        FOR y% = 0 TO 199
            pl = persplut(y%)
            SELECT CASE y%
                'sky
                CASE IS < d1%
                    tt% = 128 + tex(dx * pl AND 31, dy * pl AND 31, 4)
                    'wall
                CASE IS < d2%
                    tt% = 10 + tex(32 * (y% - d1%) \ d21%, tx%, mmap%)
                    'ground
                CASE ELSE
                    tt% = 56 + tex((xpos32 + dx * pl) AND 31, (ypos32 + dy * pl) AND 31, 4)
            END SELECT
            POKE p&, tt%
            p& = p& + 320
        NEXT y%
    NEXT x%
LOOP
EXITDO1:






COLOR 12
LOCATE 1, 1: PRINT frames% / (TIMER - tim!); " fps"
a$ = INPUT$(1)
END

'map data
DATA 7,8,7,8,7,8,7,8,7,8
DATA 7,0,0,0,0,0,0,0,0,8
DATA 8,0,9,1,0,2,10,2,0,7
DATA 7,0,1,9,0,0,0,10,0,8
DATA 8,0,0,0,0,0,0,0,0,7
DATA 7,0,3,11,3,11,0,0,0,8
DATA 8,0,11,0,0,3,0,0,0,7
DATA 7,0,3,0,0,11,0,0,0,8
DATA 8,0,0,0,0,0,0,0,0,7
DATA 8,7,8,7,8,7,8,7,8,8

