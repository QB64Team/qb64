CHDIR ".\samples\pete\booger"

REM
REM
REM             REALiTY Software
REM
REM         BOOGER and the Martians
REM
REM
REM             Coded By M.Ware
REM
REM
REM SWFX & GIF Routines used (Thanks dudes !!)
REM
REM   All other coding by REALiTY Software
REM
REM
REM
REM This is the 1st game from REALiTY Software
REM soon to be one of many ,i already have another BOOGER
REM game in the pipeline and have began work on it
REM hopefully it wont be too long coming.
REM
REM BOOGER and the Martians was written in QB4.5 on a 133Mhz
REM Pentium but should run on anything Pentium even 486 im not
REM sure about 386's etc maybe you could EMAIL me about how
REM it works on another machine ?
REM
REM Anyone out there who knows how to program music ,mail me please
REM i havent dabbled in it yet but someone who knows can save a
REM lot of time !.
REM
REM Hope you enjoy the GAME sorry there are not many REMARKS but hey
REM thats one of the joys of programming !.
REM
REM Best of luck ..........................
REM
REM P.S Maybe someone would like to join forces and make a really
REM     really really good game ???
REM
REM EMail me on : Matthew.Ware@virgin.net
REM
REM As Booger would say L8rs DUDES !!!







REM     -Set Up Those Variables-

DEFINT A-Z
RANDOMIZE TIMER

DIM SHARED c$(8) 'FM register information for 9 channels
c$(0) = "&hB0&h20&h23&h40&h43&h60&h63&h80&h83&hA0&HBD&HC0&HE0&HE3&hB0"
c$(1) = "&hB1&h21&h24&h41&h44&h61&h64&h81&h84&hA1&HBD&HC1&HE1&HE4&hB1"
c$(2) = "&hB2&h22&h25&h42&h45&h62&h65&h82&h85&hA2&HBD&HC2&HE2&HE5&hB2"
c$(3) = "&hB3&h28&h2B&h48&h4B&h68&h6B&h88&h8B&hA3&HBD&HC3&HE8&HEB&hB3"
c$(4) = "&hB4&h29&h2C&h49&h4C&h69&h6C&h89&h8C&hA4&HBD&HC4&HE9&HEC&hB4"
c$(5) = "&hB5&h2A&h2D&h4A&h4D&h6A&h6D&h8A&h8D&hA5&HBD&HC5&HEA&HED&hB5"
c$(6) = "&hB6&h30&h33&h50&h53&h70&h73&h90&h93&hA6&HBD&HC6&HF0&HF3&hB6"
c$(7) = "&hB7&h31&h34&h51&h54&h71&h74&h91&h94&hA7&HBD&HC7&HF1&HF4&hB7"
c$(8) = "&hB8&h32&h35&h52&h55&h72&h75&h92&h95&hA8&HBD&HC8&HF2&HF5&hB8"
DIM sfx$(25)
OPEN ".\data\noise.set" FOR INPUT AS #1
FOR fxnum% = 0 TO 25
    INPUT #1, sfx$(fxnum%)
NEXT
CLOSE #1


DIM Prefix(4095), Suffix(4095), OutStack(4095), shiftout%(8)
DIM Ybase AS LONG, powersof2(11) AS LONG, WorkCode AS LONG

graphics = 39
DIM grid(10, 10)
DIM sprite(74, 40)
DIM spriteback(74, 40)
DIM spritemask(74, 40)
DIM default(74): frame = 0

DIM greenback(74)
DIM greenmask(74)
DIM greensprite(74)
aliens = 50
DIM alienx!(aliens): DIM alieny!(aliens)
DIM alienmove(aliens): DIM aliengrap(aliens)
DIM alienspeed!(aliens)
DIM floor(8)
DIM scroller(1000)
DIM comment$(10)
DIM word$(32)


comment$(1) = "Wake up dude!"
comment$(2) = "Are You Asleep Again!"
comment$(3) = "Were sposed to save the world!"
comment$(4) = "I need a LEAK !!"
comment$(5) = "G E T  A  M O V E  O N"
comment$(6) = "I'm the one in danger !!!!"
comment$(7) = "Stop thinking and play !"
comment$(8) = "The Bikes Overheating !!!"
comment$(9) = "PHHURRRP oops ,sorry!"
comment$(10) = "Fffarrt ,slipped out!"
word$(1) = "Easy Street Dude !!!"
leveltoo = 1
sndon = 1
size = 74
level = 1
SCREEN 13: CLS: GOSUB grabsprites




REM         -Main Prog Starts Here !!!-

mainstart:
jpdet = 9
look1 = 0
lives = 3

SCREEN 13: CLS

GOSUB titlescreen

CLS

restart:

CLS
GOSUB loadlevel ' Gets level data from disc

PALETTE: CLS



REM                   -Draw Level Contents-

FOR ground = 200 TO 40 STEP -50
    FOR layer = 1 TO 8
        LINE (1, ground - layer)-(319, ground - layer), floor(9 - layer)
    NEXT layer
NEXT ground
moving! = 0: movingy! = 0
counter = 0: movgot = 0: movgot1 = 3

FOR howmany = 1 TO 50
    IF alienx!(howmany) <> 0 AND alienmove(howmany) = 0 THEN PUT (alienx!(howmany), alieny!(howmany)), sprite(size, aliengrap(howmany)), PSET
NEXT howmany




REM     -Okey Here Goes the main Routine !!!(HELP)-

gx! = 4: gy! = 32: anim = 0: jump = 0
   
GET (gx!, gy!)-(gx! + 10, gy! + 10), greenback()
REM snd = 19: GOSUB snd


mainloop:

counter = counter + 1: IF counter = 50 THEN counter = 0

WAIT &H3DA, 8

PUT (gx!, gy!), greenback(), PSET
gx! = gx! + moving!
gy! = gy! + movingy!
   
IF POINT(gx! + 10, gy! + 10 + movingy!) = 0 AND POINT(gx!, gy! + 10 + movingy!) = 0 THEN movingy! = movingy! + .125
IF POINT(gx! + 9, gy! + 9 + movingy!) = land AND POINT(gx!, gy! + 9 + movingy!) = land THEN movingy! = 0: jump = 0
IF POINT(gx! - 3, gy! + 4) = land THEN jpdet = 9: GOSUB missit
   
IF passd <> 0 THEN GOTO missit

IF POINT(gx! - 3, gy! + 4) <> 0 OR POINT(gx! - movgot1, gy! + 9) <> 0 THEN GOSUB dead
IF POINT(gx! + 11, gy! + 4) <> 0 OR POINT(gx! + movgot, gy! + jpdet) <> 0 THEN GOSUB dead
IF POINT(gx! + 4, gy! + 9) <> 0 THEN GOSUB dead

missit:
   
IF POINT(gx! + 5, gy! - 2) <> 0 THEN a$ = "DEFAULT": GOSUB dead
IF gx! > 305 AND gy! > 162 THEN GOTO leveldone
IF gx! > 305 THEN gx! = 4: gy! = gy! + 50
GET (gx!, gy!)-(gx! + 10, gy! + 10), greenback()
PUT (gx!, gy!), greenmask(), AND
PUT (gx!, gy!), sprite(size, anim), OR

IF counter > 25 THEN frame = 1 ELSE frame = 0

GOSUB alienmove


a$ = INKEY$
a$ = LCASE$(a$)
IF a$ = "x" AND moving! < 2 THEN moving! = moving! + .5
IF a$ = "z" AND moving! > 0 THEN moving! = moving! - .25
IF a$ = " " AND jump <> 1 THEN jump = 1: jpdet = 4: movingy! = -1.8
   
IF a$ = "q" THEN END
IF a$ = "s" THEN sndon = sndon + 1: IF sndon > 1 THEN sndon = 0

IF moving! <> 0 THEN IF anim1 = INT(5 / moving!) THEN anim = anim + 1: IF anim > 1 THEN anim = 0
IF moving! <> 0 THEN movgot1 = -3: movgot = 0: look1 = 0: anim1 = anim1 + 1: IF anim1 > INT(5 / moving!) THEN anim1 = 0: snd = 5: GOSUB snd
IF jump = 1 THEN jpdet = 4: anim = 11
IF jump = 0 THEN jpdet = 9
IF moving! = 0 AND look1 = 0 THEN anim = 0: look1 = 1
IF moving! = 0 AND jump = 1 THEN anim = 0
IF moving! = 0 THEN tick = tick + 1: IF tick = 35 THEN tick = 0: snd = 5: GOSUB snd
IF moving! = 0 AND look = 950 THEN anim = 10: snd = 7: GOSUB snd: COLOR 15: t$ = comment$(INT(RND(1) * 9) + 1): v = 1: GOSUB centre
IF moving! = 0 THEN movgot1 = 4: movgot = 12
IF look = 1290 THEN look1 = 0: anim = 0: v = 1: t$ = "                               ": look = 0: GOSUB centre
look = look + 1: IF look = 1300 THEN look = 0


GOTO mainloop


REM     -Routine for alien movement-

alienmove:
  
FOR howmany = 1 TO 50

    GET (0, 0)-(10, 9), default()

    IF alienmove(howmany) = 0 THEN GOTO skip

    PUT (alienx!(howmany), alieny!(howmany)), default(), PSET

    IF alienmove(howmany) = 1 THEN GOTO vert

    IF alienx!(howmany) < 10 OR alienx!(howmany) > 300 THEN alienspeed!(howmany) = -alienspeed!(howmany)
    IF POINT(alienx!(howmany) - 2, alieny!(howmany) + 4) <> 0 OR POINT(alienx!(howmany) + 12, alieny!(howmany) + 4) <> 0 THEN alienspeed!(howmany) = -alienspeed!(howmany): GOTO turned

    IF POINT(alienx!(howmany) - 2, alieny!(howmany) + 9) <> 0 OR POINT(alienx!(howmany) + 12, alieny!(howmany) + 9) <> 0 THEN alienspeed!(howmany) = -alienspeed!(howmany)

    turned:

    alienx!(howmany) = alienx!(howmany) + alienspeed!(howmany)
    GOTO placealien

    vert:

    alieny!(howmany) = alieny!(howmany) - alienspeed!(howmany)
    IF POINT(alienx!(howmany) + 4, alieny!(howmany) - 1) <> 0 OR POINT(alienx!(howmany) + 4, alieny!(howmany) + 10) <> 0 THEN alienspeed!(howmany) = -alienspeed!(howmany)

    placealien:

    PUT (alienx!(howmany), alieny!(howmany)), spritemask(size, aliengrap(howmany)), AND
    PUT (alienx!(howmany), alieny!(howmany)), sprite(size, aliengrap(howmany) + frame), OR


    skip:
NEXT howmany
RETURN





dead:

PUT (gx!, gy!), sprite(size, 21)
snd = 4
GOSUB snd
GOSUB delay
GOSUB delay
   
IF lives = 0 THEN GOSUB completedead
   
pic$ = ".\data\crashed1.bgr"
IF lives > 1 THEN pic$ = ".\data\crashed.bgr"
   
GOSUB picture
GOSUB keypress
lives = lives - 1: IF lives > -1 THEN GOTO restart

completedead:


pic$ = ".\data\totalled.bgr"
GOSUB picture
GOSUB keypress

GOTO mainstart


gamecomplete:

CLS
pic$ = ".\data\COMPLETE.bgr"
GOSUB picture
GOSUB keypress
level = 1
GOSUB mainstart



titlescreen:

pic$ = ".\data\title.bgr": GOSUB picture
GOSUB delay
pic$ = ".\data\title1.bgr": GOSUB picture
snd = 24
GOSUB snd
GOSUB keypress
pic$ = ".\data\title2.bgr": GOSUB picture
GOSUB keypress
pic$ = ".\data\title3.bgr": GOSUB picture
GOSUB keypress
pic$ = ".\data\title4.bgr": GOSUB picture
snd = 25: GOSUB snd


x$ = "    Right ,now dude ,this is the idea ,i've got this plan !!! .....     Firstly il'e get the Harley out of the garage ,won't go anywhere quick "
x$ = x$ + "on a pair of legs !! ,then what ,well lets get to the mothership i thinks and sort the main geezer out ,that bit you can leave to me but i need"
x$ = x$ + " your elp getting there !,basically we start at the top and the idea is to get to the bottom and onto the next street but just in case we meet"
x$ = x$ + " any Alien dudes i guess we ortta dodge em if poss i don't want to total my bike !, and we don't know what else to expect ,so only one way to find out"
x$ = x$ + " and thats to GO FOR IT !!! , OK,OK just in case i thinks the Harley will be alright for a couple of smashes ,maybe 4 i think ,but best none eh ,just hope"
x$ = x$ + " it's enuff to get us through the 30 streets !! ,and also finally"
x$ = x$ + " THE DUDE (almighty) said that the 'S' key will turn the sound on and off and 'Q' during the game will Quit and most finally if you want to get into the game"
x$ = x$ + " quick and the delays between screens and when we crash etc are toooo looonnnggg just hit the SPACEBAR !!  L8rs Dude !                  "

scroll = LEN(x$)

DO

    COLOR 37: v = 23: t$ = word$(level): GOSUB centre

    FOR r = 1 TO scroll

        COLOR 9: LOCATE 19, 37: PRINT MID$(x$, r, 1)
        IF MID$(x$, r, 1) <> " " THEN snd = 18: GOSUB snd

        FOR left = 1 TO 8


            GET (80, 144)-(300, 152), scroller()
            PUT (79, 144), scroller(), PSET
            WAIT &H3DA, 8

            a$ = INKEY$
            a$ = LCASE$(a$)

            IF a$ = "x" AND word$(level + 1) <> "" THEN level = level + 1: v = 23: t$ = "                                     ": GOSUB centre
            IF a$ = "z" AND level > 1 THEN level = level - 1: v = 23: t$ = "                                      ": GOSUB centre

            IF a$ = "z" OR a$ = "x" THEN v = 23: t$ = word$(level): GOSUB centre
            IF a$ = " " THEN GOTO doit
            IF a$ = "q" THEN END


        NEXT left
    NEXT r
LOOP

doit:
snd = 25
GOSUB snd
PALETTE
RETURN


leveldone:

pic$ = ".\data\doneit.bgr": GOSUB picture
GOSUB delay
GOSUB delay
level = level + 1
GOTO restart

keypress:
a$ = INKEY$
IF a$ = " " THEN RETURN
GOTO keypress
   
delay:
    
FOR r = 1 TO 300
    FOR rr = 1 TO 20000
    NEXT rr
NEXT r
RETURN

centre:

place = INT(40 - LEN(t$)) / 2
place = place
LOCATE v, place: PRINT t$
RETURN




REM     -Sound Routine (Thanks DUDE!)

snd:

IF sndon = 0 THEN RETURN
sfxnum% = snd
chan% = VAL(MID$(sfx$(sfxnum%), 61, 4))
FOR in = 1 TO 60 STEP 4
    reg$ = MID$(c$(chan%), in, 4): reg% = VAL(reg$)
    dat$ = MID$(sfx$(sfxnum%), in, 4): dat% = VAL(dat$)
    OUT &H388, reg%: FOR d% = 1 TO 6: b% = INP(&H388): NEXT
    OUT &H389, dat%: FOR d% = 1 TO 35: b% = INP(&H388): NEXT
NEXT

RETURN






REM     -Level Loader-

loadlevel:


IF level = 31 THEN GOSUB gamecomplete
pic$ = ".\data\loading.bgr": GOSUB picture

GOSUB delay

lev$ = STR$(level) + ".lev": lev$ = RIGHT$(lev$, LEN(lev$) - 1)
OPEN ".\levels\" + lev$ FOR INPUT AS #1
INPUT #1, levelname$
t$ = levelname$: word$(level) = t$: v = 5: COLOR 155: GOSUB centre
GOSUB delay: GOSUB delay

FOR r = 1 TO aliens
    INPUT #1, alienx!(r)
    INPUT #1, alieny!(r)
    INPUT #1, alienmove(r)
    INPUT #1, aliengrap(r)
    INPUT #1, alienspeed!(r)
    IF alienmove(r) = 1 THEN alieny!(r) = alieny!(r) - 2
    IF alienmove(r) <> 1 THEN alieny!(r) = alieny!(r) - 1
    aliengrap(r) = aliengrap(r) - 1
NEXT r
FOR r = 1 TO 8
    INPUT #1, floor(r)
NEXT r
CLOSE #1
land = floor(1)

RETURN

REM     -Routine to load and grab all sprite/mask etc data-

grabsprites:
FOR howmany = 1 TO graphics
    fa$ = STR$(howmany) + ".spr"
    fb$ = RIGHT$(fa$, LEN(fa$) - 1)
    f$ = ".\data\" + fb$
    OPEN f$ FOR INPUT AS #1
    FOR x = 1 TO 10
        FOR Y = 1 TO 10
            INPUT #1, grid(x, Y): PSET (x, Y), grid(x, Y)
        NEXT Y
    NEXT x
    CLOSE #1
    GET (1, 1)-(10, 10), sprite(size, spriteno)
    IF howmany = 1 THEN GET (1, 1)-(10, 10), greensprite()
    FOR x = 1 TO 10
        FOR Y = 1 TO 10
            IF POINT(x, Y) = 0 THEN PSET (x, Y), 255
        NEXT Y
    NEXT x
    GET (1, 1)-(10, 10), spritemask(size, spriteno)
    IF howmany = 1 THEN GET (1, 1)-(10, 10), greenmask()
    spriteno = spriteno + 1
NEXT howmany
CLS
RETURN

REM     -Routine to load pics (Thanks DUDE !)

picture:

FOR a% = 0 TO 7: shiftout%(8 - a%) = 2 ^ a%: NEXT a%
FOR a% = 0 TO 11: powersof2(a%) = 2 ^ a%: NEXT a%
OPEN pic$ FOR BINARY AS #1
pic$ = "      ": GET #1, , pic$
GET #1, , TotalX: GET #1, , TotalY: GOSUB GetByte
NumColors = 2 ^ ((a% AND 7) + 1): nopalette = (a% AND 128) = 0
GOSUB GetByte: Background = a%
GOSUB GetByte: IF a% <> 0 THEN PRINT "Bad screen descriptor.": END
IF nopalette = 0 THEN p$ = SPACE$(NumColors * 3): GET #1, , p$
DO
    GOSUB GetByte
    IF a% = 44 THEN
        EXIT DO
    ELSEIF a% <> 33 THEN
        PRINT "Unknown extension type.": END
    END IF
    GOSUB GetByte
    DO: GOSUB GetByte: pic$ = SPACE$(a%): GET #1, , pic$: LOOP UNTIL a% = 0
LOOP
GET #1, , XStart: GET #1, , YStart: GET #1, , XLength: GET #1, , YLength
XEnd = XStart + XLength: YEnd = YStart + YLength: GOSUB GetByte
IF a% AND 128 THEN PRINT "Can't handle local colormaps.": END
Interlaced = a% AND 64: PassNumber = 0: PassStep = 8
GOSUB GetByte
ClearCode = 2 ^ a%
EOSCode = ClearCode + 1
FirstCode = ClearCode + 2: NextCode = FirstCode
StartCodeSize = a% + 1: CodeSize = StartCodeSize
StartMaxCode = 2 ^ (a% + 1) - 1: MaxCode = StartMaxCode

BitsIn = 0: BlockSize = 0: BlockPointer = 1
x% = XStart: Y% = YStart: Ybase = Y% * 320&

SCREEN 13: DEF SEG = &HA000
IF nopalette = 0 THEN
    OUT &H3C7, 0: OUT &H3C8, 0
    FOR a% = 1 TO NumColors * 3: OUT &H3C9, ASC(MID$(p$, a%, 1)) \ 4: NEXT a%
END IF
LINE (0, 0)-(319, 199), Background, BF
DO
    GOSUB GetCode
    IF Code <> EOSCode THEN
        IF Code = ClearCode THEN
            NextCode = FirstCode
            CodeSize = StartCodeSize
            MaxCode = StartMaxCode
            GOSUB GetCode
            CurCode = Code: LastCode = Code: LastPixel = Code
            IF x% < 320 THEN POKE x% + Ybase, LastPixel
            x% = x% + 1: IF x% = XEnd THEN GOSUB NextScanLine
        ELSE
            CurCode = Code: StackPointer = 0
            IF Code > NextCode THEN EXIT DO
            IF Code = NextCode THEN
                CurCode = LastCode
                OutStack(StackPointer) = LastPixel
                StackPointer = StackPointer + 1
            END IF

            DO WHILE CurCode >= FirstCode
                OutStack(StackPointer) = Suffix(CurCode)
                StackPointer = StackPointer + 1
                CurCode = Prefix(CurCode)
            LOOP

            LastPixel = CurCode
            IF x% < 320 THEN POKE x% + Ybase, LastPixel
            x% = x% + 1: IF x% = XEnd THEN GOSUB NextScanLine

            FOR a% = StackPointer - 1 TO 0 STEP -1
                IF x% < 320 THEN POKE x% + Ybase, OutStack(a%)
                x% = x% + 1: IF x% = XEnd THEN GOSUB NextScanLine
            NEXT a%

            IF NextCode < 4096 THEN
                Prefix(NextCode) = LastCode
                Suffix(NextCode) = LastPixel
                NextCode = NextCode + 1
                IF NextCode > MaxCode AND CodeSize < 12 THEN
                    CodeSize = CodeSize + 1
                    MaxCode = MaxCode * 2 + 1
                END IF
            END IF
            LastCode = Code
        END IF
    END IF
LOOP UNTIL doneflag OR Code = EOSCode



CLOSE #1
doneflag = 0
RETURN


GetByte: pic$ = " ": GET #1, , pic$: a% = ASC(pic$): RETURN

NextScanLine:
IF Interlaced THEN
    Y% = Y% + PassStep
    IF Y% >= YEnd THEN
        PassNumber = PassNumber + 1
        SELECT CASE PassNumber
            CASE 1: Y% = 4: PassStep = 8
            CASE 2: Y% = 2: PassStep = 4
            CASE 3: Y% = 1: PassStep = 2
        END SELECT
    END IF
ELSE
    Y% = Y% + 1
END IF
x% = XStart: Ybase = Y% * 320&: doneflag = Y% > 199
RETURN
GetCode:
IF BitsIn = 0 THEN GOSUB ReadBufferedByte: LastChar = a%: BitsIn = 8
WorkCode = LastChar \ shiftout%(BitsIn)
DO WHILE CodeSize > BitsIn
    GOSUB ReadBufferedByte: LastChar = a%
    WorkCode = WorkCode OR LastChar * powersof2(BitsIn)
    BitsIn = BitsIn + 8
LOOP
BitsIn = BitsIn - CodeSize
Code = WorkCode AND MaxCode
RETURN
ReadBufferedByte:
IF BlockPointer > BlockSize THEN
    GOSUB GetByte: BlockSize = a%
    pic$ = SPACE$(BlockSize): GET #1, , pic$
    BlockPointer = 1
END IF
a% = ASC(MID$(pic$, BlockPointer, 1)): BlockPointer = BlockPointer + 1
RETURN


REM         - I Guess this is the end (FOR NOW!)



SUB playsfx (sfx$)

chan = VAL(MID$(sfx$, 61, 4))
FOR in = 1 TO 60 STEP 4
    reg$ = MID$(c$(chan), in, 4): reg = VAL(reg$)
    dat$ = MID$(sfx$, in, 4): dat = VAL(dat$)
    OUT &H388, reg: FOR i1 = 1 TO 6: p = INP(&H388): NEXT
    OUT &H389, dat: FOR i1 = 1 TO 35: p = INP(&H388): NEXT
NEXT

END SUB

