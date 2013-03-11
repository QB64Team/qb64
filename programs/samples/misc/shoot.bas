CHDIR ".\programs\samples\misc"

DEFLNG A-Z
SCREEN 13, , 1, 0

_SNDPLAYFILE "ps2battl.mid"
shootsound = _SNDOPEN("fireball.wav", "SYNC")

'index,filename(.RAW),width,height
DATA 1,ship1,21,27
DATA 2,shot1,10,10
DATA 3,evil1,93,80
DATA 4,land1,320,56
DATA 5,boom1,65,75

DIM SHARED spritedata(1000000) AS _UNSIGNED _BYTE
DIM SHARED freespritedata AS LONG
DIM SHARED freesprite AS LONG
freesprite = 1

TYPE spritetype
    x AS INTEGER
    y AS INTEGER
    index AS LONG 'an index in the spritedata() array
    index2 AS LONG 'optional secondary index
    halfx AS INTEGER
    halfy AS INTEGER
END TYPE
DIM SHARED s(1 TO 1000) AS spritetype

'load sprites
FOR i = 1 TO 5
    b$ = " "
    READ n
    READ f$: f$ = f$ + ".raw"
    READ x, y
    OPEN f$ FOR BINARY AS #1
    IF LOF(1) <> x * y THEN SCREEN 0: PRINT "Error loading " + f$: END
    FOR y2 = y - 1 TO 0 STEP -1
        FOR x2 = 0 TO x - 1
            GET #1, , b$
            PSET (x2, y2), ASC(b$)
        NEXT
    NEXT
    CLOSE #1
    GET (0, 0)-(x - 1, y - 1), spritedata(freespritedata)
    s(freesprite).index = freespritedata
    freespritedata = freespritedata + x * y + 4
    'create shadow
    FOR y2 = y - 1 TO 0 STEP -1
        FOR x2 = 0 TO x - 1
            IF POINT(x2, y2) <> 254 THEN PSET (x2, y2), 18
        NEXT
    NEXT
    GET (0, 0)-(x - 1, y - 1), spritedata(freespritedata)
    s(freesprite).index2 = freespritedata
    freespritedata = freespritedata + x * y + 4
    s(freesprite).x = x: s(freesprite).y = y
    s(freesprite).halfx = x \ 2: s(freesprite).halfy = y \ 2
    freesprite = freesprite + 1
NEXT

TYPE object
    active AS INTEGER
    x AS INTEGER
    y AS INTEGER
    z AS INTEGER 'height
    mx AS INTEGER
    my AS INTEGER
    sprite AS INTEGER
END TYPE

'create objects
DIM o(1 TO 1000) AS object 'all game objects
DIM SHARED lastobject AS INTEGER
lastobject = 1000

'create player
i = newobject(o())
o(i).sprite = 1
o(i).z = 50
o(i).active = 20
player = i

_MOUSEHIDE

'gameloop
DO

    DO: LOOP WHILE _MOUSEINPUT 'read all available mouse messages until current message

    'set player's position
    o(player).x = _MOUSEX: o(player).y = _MOUSEY

    'draw land
    landy = (landy + 1) MOD 56
    FOR i = -1 TO 4
        PUT (0, i * 56 + landy), spritedata(s(4).index), _CLIP PSET, 254
    NEXT

    'draw enemy shadows
    FOR i = 1 TO lastobject
        IF o(i).sprite = 3 THEN displayshadow o(i)
    NEXT

    'draw player's shadow
    displayshadow o(player)

    'draw enemies
    FOR i = 1 TO lastobject
        IF o(i).sprite = 3 THEN
            display o(i)
            move o(i)
            IF o(i).y - s(o(i).sprite).halfy > 200 THEN o(i).y = -1000
        END IF
    NEXT

    'draw bullets
    FOR i = 1 TO lastobject
        IF o(i).sprite = 2 THEN
            display o(i)
            move o(i)
            IF offscreen(o(i)) THEN freeobject o(i)
            xshift = INT(RND * 3) - 1
            o(i).mx = o(i).mx + xshift
            o(i).my = o(i).my - 1
        END IF
    NEXT

    'draw player
    display o(player)

    'draw explosion(s)
    FOR i = 1 TO lastobject
        IF o(i).sprite = 5 THEN
            FOR i2 = 1 TO o(i).active
                rad = i2 * 5: halfrad = rad \ 2
                dx = RND * rad - halfrad: dy = RND * rad - halfrad
                displayat o(i).x + dx, o(i).y + dy, o(i)
            NEXT
            move o(i)
            o(i).active = o(i).active - 1
            IF o(i).active = 0 THEN freeobject o(i)
        END IF
    NEXT

    'hp bar
    x = 60
    y = 185
    LINE (x - 1, y)-STEP(20 * 10 + 2, 5), 2, B
    LINE (x, y - 1)-STEP(20 * 10, 5 + 2), 2, B
    LINE (x, y)-STEP(20 * 10, 5), 40, BF
    LINE (x, y)-STEP(o(player).active * 10, 5), 47, BF

    PCOPY 1, 0

    'shoot?
    IF _MOUSEBUTTON(1) THEN
        i = newobject(o())
        o(i).sprite = 2
        o(i).x = o(player).x
        o(i).y = o(player).y - s(o(player).sprite).halfy
        o(i).my = -1
        _SNDPLAYCOPY shootsound
    END IF

    'bullet->enemy collision
    FOR i = 1 TO lastobject
        IF o(i).sprite = 2 THEN 'bullet
            FOR i2 = 1 TO lastobject
                IF o(i2).sprite = 3 THEN 'enemy
                    IF collision(o(i), o(i2)) THEN
                        _SNDPLAYCOPY shootsound
                        i3 = newobject(o())
                        o(i3).sprite = 5
                        o(i3).my = o(i2).my \ 2 + 1
                        IF o(i2).active > 1 THEN 'hit (small explosion)
                            o(i2).active = o(i2).active - 1
                            o(i3).x = o(i).x
                            o(i3).y = o(i).y
                        ELSE 'destroyed (large explosion)
                            o(i3).x = o(i2).x
                            o(i3).y = o(i2).y
                            o(i3).active = 15
                            freeobject o(i2) 'enemy
                        END IF
                        freeobject o(i) 'bullet
                        EXIT FOR
                    END IF 'collision
                END IF
            NEXT
        END IF
    NEXT

    'ship->enemy collision
    i = player
    FOR i2 = 1 TO lastobject
        IF o(i2).sprite = 3 THEN 'enemy
            IF collision(o(i), o(i2)) THEN
                o(i).active = o(i).active - 1
                IF o(i).active = 0 THEN END
                EXIT FOR
            END IF 'collision
        END IF
    NEXT

    'add new enemy?
    addenemy = addenemy + 1
    IF addenemy = 50 THEN
        addenemy = 0
        i = newobject(o())
        o(i).sprite = 3
        o(i).x = RND * 320
        o(i).y = RND * -1000 - s(o(i).sprite).halfy
        o(i).my = 3 + RND * 6
        o(i).z = 25 + o(i).my * 8
        o(i).active = 15 'hp
    END IF

    'speed limit main loop to 18.2 frames per second
    DO: nt! = TIMER: LOOP WHILE nt! = lt!
    lt! = nt!

LOOP
'end main loop

SUB move (o AS object)
o.x = o.x + o.mx
o.y = o.y + o.my
END SUB

SUB display (o AS object)
PUT (o.x - s(o.sprite).halfx, o.y - s(o.sprite).halfy), spritedata(s(o.sprite).index), _CLIP PSET, 254
END SUB

SUB displayat (x AS INTEGER, y AS INTEGER, o AS object)
PUT (x - s(o.sprite).halfx, y - s(o.sprite).halfy), spritedata(s(o.sprite).index), _CLIP PSET, 254
END SUB


SUB displayshadow (o AS object)
PUT (o.x - s(o.sprite).halfx, o.y - s(o.sprite).halfy + o.z), spritedata(s(o.sprite).index2), _CLIP PSET, 254
END SUB

FUNCTION newobject (o() AS object)
FOR i = 1 TO lastobject
    IF o(i).active = 0 THEN
        o(i).active = 1
        o(i).mx = 0: o(i).my = 0
        o(i).z = 0
        newobject = i
        EXIT FUNCTION
    END IF
NEXT
SCREEN 0: PRINT "No more free objects available!": END
END FUNCTION

FUNCTION offscreen (o AS object)
IF o.x + s(o.sprite).halfx < 0 THEN offscreen = 1: EXIT FUNCTION
IF o.x - s(o.sprite).halfx > 319 THEN offscreen = 1: EXIT FUNCTION
IF o.y + s(o.sprite).halfy < 0 THEN offscreen = 1: EXIT FUNCTION
IF o.y - s(o.sprite).halfy > 199 THEN offscreen = 1: EXIT FUNCTION
END FUNCTION

SUB freeobject (o AS object)
o.active = 0
o.sprite = 0
END SUB

FUNCTION collision (o1 AS object, o2 AS object)
IF o1.y + s(o1.sprite).halfy < o2.y - s(o2.sprite).halfy THEN EXIT FUNCTION
IF o2.y + s(o2.sprite).halfy < o1.y - s(o1.sprite).halfy THEN EXIT FUNCTION
IF o1.x + s(o1.sprite).halfx < o2.x - s(o2.sprite).halfx THEN EXIT FUNCTION
IF o2.x + s(o2.sprite).halfx < o1.x - s(o1.sprite).halfx THEN EXIT FUNCTION
collision = 1
END FUNCTION
