DECLARE SUB copper ()
DECLARE SUB fadefromcolor (a%, c%, t%, r%, g%, B%)
DECLARE SUB fadetocolor (a%, c%, t%, r%, g%, B%)
DECLARE SUB getpal ()
DECLARE SUB setpal (c1%, c2%, r1%, g1%, b1%, r2%, g2%, b2%)

DECLARE SUB keyaction ()

DECLARE SUB crosfade (r1%(), r2%(), g1%(), g2%(), b1%(), b2%())
DECLARE SUB setcrosfadepal (r1%(), r2%(), g1%(), g2%(), b1%(), b2%())
DECLARE SUB initcrosfadepics (a%, B%)

DECLARE SUB clearscreen (c%)

DECLARE SUB spheremaplasma ()
DECLARE SUB zoomdistort ()
DECLARE SUB loadqbinside ()
DECLARE SUB rgblights ()
DECLARE SUB cycleblobs ()
DECLARE SUB plasmablobs ()

DECLARE SUB actions3d ()

DECLARE SUB loadobject (a$)
DECLARE SUB createobject (a%)

DECLARE SUB animatewavelet (k%)

DECLARE SUB mov3dpos (xp, yp, zp)
DECLARE SUB rotate3d (xr, yr, zr)
DECLARE SUB translate3d ()
DECLARE SUB output3d ()

DECLARE SUB load3drecord ()



DECLARE SUB loadrecord ()
DECLARE SUB precalculations ()
DECLARE SUB getmap (a$)

DECLARE SUB Intersections ()
DECLARE SUB Actions ()
DECLARE SUB saverecord ()

DECLARE SUB Output0 ()

DECLARE SUB deedlinesax (c%)
DECLARE SUB prehistoricode ()
DECLARE SUB sucking ()
DECLARE SUB delay (t%)

DECLARE SUB ffix
'ffix


RANDOMIZE TIMER

IF COMMAND$ = "-COPPER" THEN copper: END

SCREEN 13
deedlinesax 15
delay 140
deedlinesax 0
CLS

prehistoricode
sucking
delay 140



xit% = 0

'$DYNAMIC
DIM SHARED r%(0 TO 255), g%(0 TO 255), B%(0 TO 255)
DIM SHARED r1%(0 TO 255), g1%(0 TO 255), b1%(0 TO 255)
DIM SHARED fpos%(0 TO 255)
fp% = 256 * 86: DIM SHARED fonts%(0 TO fp%)
'$STATIC

'DIM SHARED fsin1%(-48 TO 826), fsin2%(-640 TO 602), fsin3%(-640 TO 715)
DIM SHARED fsin4%(-319 TO 602)

DIM SHARED fsin1%(-48 TO 1083)
DIM SHARED fsin2%(-640 TO 957)
DIM SHARED fsin3%(-640 TO 871)

DIM SHARED mod256128%(-168 TO 168)
DIM SHARED sp%(16384)

DIM SHARED dt%(-192 TO 180)
DIM SHARED dt100%(-180 TO 180)


DIM SHARED cd%(0 TO 1792)


DIM SHARED dsx%(10), dsy%(10), psx%(10), psy%(10), xp1%(10), yp1%(10), yy%(10)
DIM SHARED epi6%(0 TO 5), epi36%(0 TO 5)

DIM SHARED cy%(-100 TO 300)



DIM SHARED dis%(320), sla%(320), slb%(320), slc%(320), sc%(320)
DIM SHARED div2%(255), div4%(320), mul32%(32), mul128%(128)
DIM SHARED fs%(0 TO 199)
'DIM SHARED map%(1024)
DIM SHARED kon%(127)
DIM SHARED ka%(4)



setcrosfadepal r%(), r1%(), g%(), g1%(), B%(), b1%()
getpal
fadetocolor 0, 255, 1, 0, 0, 0

a$ = "fonts16.fnt"
c$ = " "

open ".\samples\pete\optimus\"+a$ FOR BINARY AS #1


FOR i% = 0 TO 255
GET #1, , c$: fpos%(i%) = ASC(c$)
NEXT i%


FOR i% = 0 TO 85

FOR y% = 0 TO 15
FOR x% = 0 TO 15
GET #1, , c$
fonts%(i% * 256 + y% * 16 + x%) = ASC(c$)
NEXT x%
NEXT y%

NEXT i%

CLOSE #1

'$DYNAMIC
DIM SHARED text$(3, 11)
'$STATIC

text$(0, 0) = "   Ok! Let's get    "
text$(0, 1) = "  serious now :)    "
text$(0, 2) = "                    "
text$(0, 3) = " Hopefully you will "
text$(0, 4) = "see a nice demo from"
text$(0, 5) = "my side and not old "
text$(0, 6) = "  prehistoric line  "
text$(0, 7) = " drawing and lame   "
text$(0, 8) = "oldstyle qbasic code"
text$(0, 9) = "                    "
text$(0, 10) = " But let's crosfade "
text$(0, 11) = " some more text now!"

text$(1, 0) = "  Optimus presents  "
text$(1, 1) = "  a demo done in a  "
text$(1, 2) = " hurry by connecting"
text$(1, 3) = "  various older or  "
text$(1, 4) = " newer sources into "
text$(1, 5) = " the main programm. "
text$(1, 6) = "                    "
text$(1, 7) = " All coded in pure  "
text$(1, 8) = "  Quickbasic 4.5    "
text$(1, 9) = "  Use ffix.com for  "
text$(1, 10) = "  maximum pleasure  "
text$(1, 11) = "                    "


text$(2, 0) = "  Featuring effects "
text$(2, 1) = "like Sphere mapping "
text$(2, 2) = "circle blobs,rgb8bpp"
text$(2, 3) = "lights, zoom distort"
text$(2, 4) = "plasma inside blob, "
text$(2, 5) = "hardware raster fx  "
text$(2, 6) = "3d dots and a simple"
text$(2, 7) = "raycaster engine.   "
text$(2, 8) = "    Some are not so "
text$(2, 9) = "optimized as I could"
text$(2, 10) = "and few have several"
text$(2, 11) = "bugs too..          "


text$(3, 0) = "They still run at   "
text$(3, 1) = "full frame rate in  "
text$(3, 2) = "my AMDK6-2/500Mhz,  "
text$(3, 3) = "though I had thought"
text$(3, 4) = "ways to optimize    "
text$(3, 5) = "them even more.     "
text$(3, 6) = "           Anyways.."
text$(3, 7) = "lean back and enjoy!"
text$(3, 8) = "                    "
text$(3, 9) = " Optimus/Dirty Minds"
text$(3, 10) = " Thessaloniki/Greece"
text$(3, 11) = " Saturday 25/05/2002"

CLS
dl% = 840

initcrosfadepics 0, 1
fadefromcolor 0, 255, 256, 0, 0, 0

delay dl%
IF xit% = 1 THEN xit% = 2: getpal: fadetocolor 0, 255, 64, 0, 0, 0: GOTO endfadetext


crosfade r%(), r1%(), g%(), g1%(), B%(), b1%()
IF xit% = 1 THEN xit% = 2: getpal: fadetocolor 0, 255, 64, 0, 0, 0: GOTO endfadetext

initcrosfadepics 1, 1
setcrosfadepal r%(), r1%(), g%(), g1%(), B%(), b1%()
initcrosfadepics 1, 2
delay dl%
IF xit% = 1 THEN xit% = 2: getpal: fadetocolor 0, 255, 64, 0, 0, 0: GOTO endfadetext

crosfade r%(), r1%(), g%(), g1%(), B%(), b1%()
IF xit% = 1 THEN xit% = 2: getpal: fadetocolor 0, 255, 64, 0, 0, 0: GOTO endfadetext


delay dl%
IF xit% = 1 THEN xit% = 2: getpal: fadetocolor 0, 255, 64, 0, 0, 0: GOTO endfadetext

initcrosfadepics 2, 2
setcrosfadepal r%(), r1%(), g%(), g1%(), B%(), b1%()
initcrosfadepics 2, 3
crosfade r%(), r1%(), g%(), g1%(), B%(), b1%()
IF xit% = 1 THEN xit% = 2: getpal: fadetocolor 0, 255, 64, 0, 0, 0: GOTO endfadetext


delay dl%
IF xit% = 1 THEN xit% = 2: getpal: fadetocolor 0, 255, 64, 0, 0, 0: GOTO endfadetext

getpal
fadetocolor 0, 255, 256, 63, 63, 63
IF xit% = 1 THEN xit% = 2: getpal: fadetocolor 0, 255, 64, 0, 0, 0: GOTO endfadetext


endfadetext:
xit% = 0

LINE (0, 0)-(320, 200), 255, BF


spheremaplasma
xit% = 0
zoomdistort
xit% = 0
getpal
fadetocolor 0, 255, 31, 0, 0, 0
CLS


' ------------- RGB Lights ---------------

rgblights
xit% = 0







' ------------- 3D Dots ---------------

'$DYNAMIC
DIM SHARED x(4096), y(4096), z(4096)
DIM SHARED xo%(4096), yo%(4096), zo%(4096)
DIM SHARED xs%(4096, 1), ys%(4096, 1)
'DIM SHARED pl%(8192, 2), ln%(8192, 1)
DIM SHARED ypk&(-100 TO 99)
DIM SHARED zpo%(8)
'$STATIC


CLS

' ------ Precalculations for Wavelet -----


FOR i% = 0 TO 826
fsin1%(i%) = SIN(i% / 50) * 48
NEXT i%


' ------ Precalculations for Poke ------


FOR i& = -100 TO 99
ypk&(i&) = (i& + 100) * 320
NEXT i&

' ---------------------------------------


actions3d

xit% = 0
' -------- Cycleblobs ------------

ERASE fsin2%, fsin3%
cycleblobs
xit% = 0

CLS
plasmablobs
xit% = 0
LINE (0, 0)-(320, 200), 255, BF




'dm% = 16384
'DIM SHARED mapout%(dm%)



setpal 0, 255, 0, 0, 0, 63, 63, 63

getmap "wolfmap0.wad"
precalculations


k$ = " "

a$ = "3rdrec.rec"
gi$ = " ": gg$ = " "
g% = 0: gi% = 0

open ".\samples\pete\optimus\"+a$ FOR BINARY AS #2
GET #2, , gi$: gi% = ASC(gi$): GET #2, , gg$: gg% = ASC(gg$)


WHILE INKEY$ <> "": WEND

' ----------------- Some important data -----------------

ph% = 32: px% = 64 + 32: py% = 64 + 32: pa% = 90: ps% = 3
fv% = 60: ra = fv% / 320: dpp% = 160 / TAN((fv% \ 2) / 57.3)
map% = 0

k% = 0
fps% = 0
filei% = 0

DO WHILE INKEY$ = ""
fps% = fps% + 1
IF fps% = 558 THEN map% = 1
IF fps% = 2148 THEN map% = 0
IF fps% = 3500 THEN map% = 1
IF fps% = 4760 THEN map% = 0

keyaction
loadrecord
Actions
sp%(mul128%(py% \ 16) + px% \ 16) = 64

Intersections
WAIT &H3DA, 8: WAIT &H3DA, 8, 8
Output0


IF filei% = 194 THEN GOTO telos

LOOP

telos:
CLOSE #2

xit% = 0
getpal
fadetocolor 0, 255, 255, 0, 0, 0

SUB Actions

SHARED kb%, px%, py%, pa%, ps%, map%

WHILE kon%(75) = 1
pa% = pa% + 1
IF pa% > 360 THEN pa% = 0 + (pa% - 360)
GOTO 101
WEND

101
WHILE kon%(77) = 1
pa% = pa% - 1
IF pa% < 0 THEN pa% = 360 + pa%
GOTO 102
WEND

102
WHILE kon%(72) = 1
pxd% = COS(pa% / 57.3) * ps%
pyd% = SIN(pa% / 57.3) * ps%
px% = px% + pxd%
IF cd%(mul32%(py% \ 64) + px% \ 64) = 1 THEN px% = px% - pxd%
py% = py% - pyd%
IF cd%(mul32%(py% \ 64) + px% \ 64) = 1 THEN py% = py% + pyd%
GOTO 103
WEND

103
WHILE kon%(80) = 1
pxd% = COS(pa% / 57.3) * ps%
pyd% = SIN(pa% / 57.3) * ps%
px% = px% - pxd%
IF cd%(mul32%(py% \ 64) + px% \ 64) = 1 THEN px% = px% + pxd%
py% = py% + pyd%
IF cd%(mul32%(py% \ 64) + px% \ 64) = 1 THEN py% = py% - pyd%
GOTO 104
WEND

104
WHILE kon%(15) = 1
IF map% = 0 THEN map% = 1 ELSE map% = 0
GOTO 105
WEND

105
WHILE kon%(1) = 1
END
WEND

WHILE INKEY$ <> "": WEND

END SUB

SUB actions3d

SHARED xit%

SHARED ndts%, ndtso%
SHARED xc, yc, zc, rxc, ryc, rzc
SHARED xp, yp, zp
SHARED gi$, gg$
SHARED k%, obj%
SHARED ftype%, filei%
SHARED mtr


CONST pi = 3.1415926#
mtr = pi / 180
k% = 0

gi$ = " "
gg$ = " "
xp = 0: yp = 0: zp = 800

'kyvos 100
'sphere 200
'torus 600
'wavelet 800
'teapot,cow 300

zpo%(1) = 100
zpo%(2) = 200
zpo%(3) = 600
zpo%(4) = 800
zpo%(5) = 300
zpo%(6) = 300




SCREEN 13
COLOR 255



DEF SEG = &HA000
xc = 0: yc = 0: zc = 0
rxc = 0: ryc = 0: rzc = 0


f$ = "3drec.001"
OPEN ".\samples\pete\optimus\"+f$ FOR BINARY AS #2

k% = 0
DO
B$ = INKEY$: IF B$ = "x" THEN END
load3drecord
IF ASC(gg$) = 0 THEN a$ = "" ELSE a$ = gg$


WHILE a$ = "s" OR a$ = "S"
setpal 0, 255, 0, 0, 0, 63, 63, 63
obj% = 1
'zp = zpo%(obj%)
createobject obj%
ndtso% = 64: ndts% = ndtso%
a$ = ""
WEND

WHILE a$ = "d" OR a$ = "D"
setpal 0, 255, 0, 0, 0, 63, 47, 15
obj% = 2
'zp = zpo%(obj%)
createobject obj%
ndtso% = 256: ndts% = ndtso%
a$ = ""
WEND

WHILE a$ = "f" OR a$ = "F"
setpal 0, 255, 0, 0, 0, 31, 63, 47
obj% = 3
'zp = zpo%(obj%)
createobject obj%
ndtso% = 512: ndts% = ndtso%
a$ = ""
WEND

WHILE a$ = "g" OR a$ = "G"
setpal 0, 255, 0, 0, 0, 15, 31, 63
obj% = 4
'zp = zpo%(obj%)
createobject obj%
ndtso% = 64: ndts% = 0
a$ = ""
WEND

WHILE a$ = "h" OR a$ = "H"
setpal 0, 255, 0, 0, 0, 0, 63, 63
obj% = 5
'zp = zpo%(obj%)
loadobject "hiteapot.3do"
ndtso% = 0
a$ = ""
WEND

WHILE a$ = "j" OR a$ = "J"
setpal 0, 255, 0, 0, 0, 63, 31, 47
obj% = 6
'zp = zpo%(obj%)
loadobject "cow.3do"
ndtso% = 0
a$ = ""
WEND


WHILE a$ = "," OR a$ = "<"

clearscreen 0
IF ndts% - ndtso% > 0 THEN ndts% = ndts% - ndtso%
a$ = ""
WEND

WHILE a$ = "." OR a$ = ">"
'clearscreen 0
IF ndts% + ndtso% < 4096 THEN ndts% = ndts% + ndtso%
a$ = ""
WEND


WHILE a$ = "k" OR a$ = "K"
'clearscreen 0
xp = -zpo%(obj%) * 1.5: yp = 0: zp = zpo%(obj%)
xc = 0: yc = 0: zc = 0
a$ = ""
WEND

WHILE a$ = "l" OR a$ = "L"
'clearscreen 0
xp = zpo%(obj%) * 1.5: yp = 0: zp = zpo%(obj%)
xc = 0: yc = 0: zc = 0
a$ = ""
WEND


WHILE a$ = "u" OR a$ = "U"
'clearscreen 0
xp = 0: yp = zpo%(obj%) * 1.5: zp = zpo%(obj%)
xc = 0: yc = 0: zc = 0
a$ = ""
WEND

WHILE a$ = "y" OR a$ = "Y"
'clearscreen 0
xp = 0: yp = -zpo%(obj%) * 1.5: zp = zpo%(obj%)
xc = 0: yc = 0: zc = 0
a$ = ""
WEND

WHILE a$ = "m" OR a$ = "M"
'clearscreen 0
xp = 0: yp = 0: zp = -zpo%(obj%) \ 2
xc = 0: yc = 0: zc = 0
a$ = ""
WEND






WHILE a$ = "a" OR a$ = "A"
yc = yc + .1
a$ = ""
WEND

WHILE a$ = "Q" OR a$ = "q"
yc = yc - .1
a$ = ""
WEND

WHILE a$ = "o" OR a$ = "O"
xc = xc - .1
a$ = ""
WEND

WHILE a$ = "p" OR a$ = "P"
xc = xc + .1
a$ = ""
WEND

WHILE a$ = "-"
zc = zc + .25
a$ = ""
WEND

WHILE a$ = "=" OR a$ = "+"
zc = zc - .25
a$ = ""
WEND

WHILE a$ = "z" OR a$ = "Z"
xr = 0: yr = 0: zr = 0
rxc = 0: ryc = 0: rzc = 0
a$ = ""
WEND



WHILE a$ = "x" OR a$ = "X"
END
WEND

WHILE a$ = "4"
ryc = ryc - .005
a$ = ""
WEND

WHILE a$ = "6"
ryc = ryc + .005
a$ = ""
WEND

WHILE a$ = "8"
rxc = rxc - .005
a$ = ""
WEND

WHILE a$ = "2"
rxc = rxc + .005
a$ = ""
WEND

WHILE a$ = "7"
rzc = rzc - .005
a$ = ""
WEND

WHILE a$ = "9"
rzc = rzc + .005
a$ = ""
WEND


WHILE a$ = "w" OR a$ = "W"
clearscreen 1
ftype% = 0
a$ = ""
WEND

WHILE a$ = "e" OR a$ = "E"
ftype% = 1
a$ = ""
WEND

WHILE a$ = "r" OR a$ = "R"
ftype% = 2
a$ = ""
WEND


xp = xp + xc: yp = yp + yc: zp = zp + zc
xr = xr + rxc: yr = yr + ryc: zr = zr + rzc


IF obj% = 4 THEN animatewavelet k%: k% = k% + 1: IF k% = 314 THEN k% = 0

rotate3d xr, yr, zr
mov3dpos xp, yp, zp
translate3d
output3d

IF filei% = 4446 THEN GOTO telos2

IF xit% = 0 THEN keyaction
IF xit% = 1 THEN GOTO telos2


LOOP


telos2:
filei% = 0

CLOSE #2

END SUB

SUB animatewavelet (k%)


l% = 0
FOR z% = 0 TO 511 STEP 8
FOR x% = 0 TO 511 STEP 8

xo%(l%) = x% - 256: zo%(l%) = z% - 256
yo%(l%) = fsin1%(x% + k%) + fsin1%(z% + k%)


l% = l% + 1
NEXT x%
NEXT z%

END SUB

SUB clearscreen (c%)


FOR y% = 0 TO 199
DEF SEG = &HA000 + y% * 20

FOR x% = 0 TO 319
POKE x%, c%
NEXT x%

NEXT y%

DEF SEG = &HA000


END SUB

SUB copper

CLS

'WHILE INKEY$ <> "": WEND
'SCREEN 0

LOCATE 2, 32: PRINT "Congratulations!"
LOCATE 4, 2: PRINT "You have just found the secret part of the demo, even if I guess it was quite"
LOCATE 5, 2: PRINT "easy, since I use to give away the source of every quickbasic demo of mine ;)"
PRINT
PRINT "   These are supposed to be hardware fx inspired by Amiga, C64, CPC or any other"
PRINT "raster display computer that happens to exist. Quite unstable if you are running"
PRINT "them under windows, so I suggest to boot up in pure DOS and retry there.."
PRINT
PRINT "   What you are just watching are called raster or copper bars. Originally 1st"
PRINT "seen in Amiga demos, giving to the machine the opportunity to display more than"
PRINT "the theoritical maximum number of colors (This is text mode!) in the screen (But"
PRINT "mostly used as horizontal colorfull lines and not per pixel. Do you remember"
PRINT "Shadow of the Beast or Agony, which used to have extra colors upon a colorfull"
PRINT "sky in the background?)"
PRINT "   They are so simple fx, just changing the RGB values of just one color several"
PRINT "times in a frame, synced with the raster beam of the CRT (You can use the &HDA "
PRINT "port address you know from Vsync to use for horizontal syncing too, by checking"
PRINT " the 1st bit, in the similar way you did that for the 4th bit for Vsync!)"

PRINT
PRINT "It seems that I have 2 go, unfortunatelly haven't explained you about the next"
PRINT "effects you are gonna see if you press any key.."
PRINT "                                                     Optimus"



DIM c%(1 TO 32)
DIM xb%(0 TO 319)
DIM ds%(1 TO 32), ps%(1 TO 32)
DIM xp%(32)
DIM rgb%(15, 15)
'DIM b01%(-1024 TO 1024)
'DIM b02%(-1024 TO 1024)
DIM b01%(-640 TO 640)
DIM b02%(-640 TO 640)

DIM y2%(0 TO 399)
DIM lc%(0 TO 399)


DIM l%(3)
DIM br%(-200 TO 500)

k% = 0
FOR i% = 168 TO 200
IF k% > 63 THEN k% = 63
br%(i%) = k%
k% = k% + 2
NEXT i%

FOR i% = 201 TO 232
k% = k% - 2
IF k% < 0 THEN k% = 0
br%(i%) = k%
NEXT i%


k% = 0
DO WHILE INKEY$ = ""

k% = k% + 1

WAIT &H3DA, 8
WAIT &H3DA, 8, 8

l%(1) = SIN(k% / 25) * 120
l%(2) = SIN(k% / 45) * 110
l%(3) = SIN(k% / 35) * 100


FOR i% = 0 TO 380

WAIT &H3DA, 1, 1: WAIT &H3DA, 1

OUT &H3C8, 0
OUT &H3C9, br%(i% + l%(1))
OUT &H3C9, br%(i% + l%(2))
OUT &H3C9, br%(i% + l%(3))

NEXT i%



LOOP




SCREEN 13

OUT &H3D4, &H13
OUT &H3D5, 0

FOR i% = 1 TO 16
OUT &H3C8, i%
OUT &H3C9, (i% - 1) * 4
OUT &H3C9, 0
OUT &H3C9, 0
NEXT i%

FOR i% = 17 TO 32
OUT &H3C8, i%
OUT &H3C9, 0
OUT &H3C9, (i% - 17) * 4
OUT &H3C9, 0
NEXT i%

FOR i% = 33 TO 48
OUT &H3C8, i%
OUT &H3C9, 0
OUT &H3C9, 0
OUT &H3C9, (i% - 33) * 4
NEXT i%

FOR i% = 49 TO 64
OUT &H3C8, i%
OUT &H3C9, (i% - 49) * 4
OUT &H3C9, (i% - 49) * 4
OUT &H3C9, 0
NEXT i%

FOR i% = 65 TO 80
OUT &H3C8, i%
OUT &H3C9, (i% - 65) * 4
OUT &H3C9, 0
OUT &H3C9, (i% - 65) * 4
NEXT i%

FOR i% = 81 TO 96
OUT &H3C8, i%
OUT &H3C9, 0
OUT &H3C9, (i% - 81) * 4
OUT &H3C9, (i% - 81) * 4
NEXT i%

FOR i% = 97 TO 112
OUT &H3C8, i%
OUT &H3C9, (i% - 97) * 4
OUT &H3C9, (i% - 97) * 2
OUT &H3C9, 0
NEXT i%

FOR i% = 113 TO 128
OUT &H3C8, i%
OUT &H3C9, 0
OUT &H3C9, (i% - 113) * 2
OUT &H3C9, (i% - 113) * 4
NEXT i%






FOR i% = 1 TO 16: c%(i%) = i%: NEXT i%
FOR i% = 17 TO 32: c%(i%) = 33 - i%: NEXT i%



FOR i% = 1 TO 32
ds%(i%) = INT(RND * 63 + 32)
ps%(i%) = INT(RND * 127)
NEXT i%


DEF SEG = &HA000

k% = 0
DO WHILE INKEY$ = ""


k% = k% + 1

FOR i% = 1 TO 8
xp%(i%) = SIN(k% / ds%(i%)) * ps%(i%) + ps%(i%) + (280 - 2 * ps%(i%)) \ 2
NEXT i%

FOR ii% = 1 TO 8
FOR i% = 1 TO 32
xb%(i% + xp%(ii%)) = c%(i%) + 16 * (ii% - 1)
NEXT i%
NEXT ii%


WAIT &H3DA, 8
FOR i% = 0 TO 319
POKE i%, xb%(i%)
POKE i% + 80, xb%(i%)
NEXT i%
WAIT &H3DA, 8, 8




l%(1) = SIN(k% / 25) * 120
l%(2) = SIN(k% / 45) * 110
l%(3) = SIN(k% / 35) * 100


FOR i% = 0 TO 380


WAIT &H3DA, 1, 1: WAIT &H3DA, 1

OUT &H3C8, 0
OUT &H3C9, br%(i% + l%(1))
OUT &H3C9, br%(i% + l%(2))
OUT &H3C9, br%(i% + l%(3))

NEXT i%

FOR i% = 0 TO 319: xb%(i%) = 0: NEXT i%


LOOP





' --------- Translucent copper bars -----------



c% = 0
OUT &H3C8, 0

FOR a% = 0 TO 15
FOR B% = 0 TO 15

OUT &H3C9, a% * 2 + 33
OUT &H3C9, 0
OUT &H3C9, B% * 2 + 33

rgb%(a%, B%) = c%
c% = c% + 1

NEXT B%
NEXT a%


OUT &H3D4, &H13
OUT &H3D5, 0

'DIM fsin1%(0 TO 1083)
'DIM fsin2%(0 TO 957)
'DIM fsin3%(-471 TO 871)

FOR i% = 0 TO 1083: fsin1%(i%) = SIN(i% / 45) * 63 + 92: NEXT i%
FOR i% = 0 TO 957: fsin2%(i%) = SIN(i% / 25) * 31 + 31: NEXT i%
FOR i% = -471 TO 871: fsin3%(i%) = SIN(i% / 75) * 91 + 127: NEXT i%

DIM p16%(0 TO 15)
FOR i% = 0 TO 15
p16%(i%) = i% * 16
NEXT i%


DIM c1%(0 TO 7), c2%(0 TO 7), c3%(0 TO 7)

FOR i% = 0 TO 5: c1%(i%) = i% + 1: c2%(i%) = i% + 7: c3%(i%) = i% + 13: NEXT i%

FOR i% = 0 TO 399: y2%(i%) = i% * 2: NEXT i%


FOR i% = 0 TO 399: lc%(i%) = i% / 6.4: NEXT i%



y1% = 0
fps% = 0
DO WHILE INKEY$ = ""
k% = k% + 3: IF k% >= 283 THEN k% = 0
l% = l% + 2: IF l% >= 157 THEN l% = 0
m% = m% + 1: IF m% >= 471 THEN m% = 0
fps% = fps% + 1

IF fps% < 400 AND y1% < 395 THEN y1% = y1% + 1
IF fps% > 1200 AND y1% <> 0 THEN y1% = y1% - 1
IF y1% = 0 THEN GOTO out1


WAIT &H3DA, 8: WAIT &H3DA, 8, 8


'GOTO 17
OUT &H3C8, 0
OUT &H3C9, 0
OUT &H3C9, 0
OUT &H3C9, 0
17

DEF SEG = &HA000

FOR y% = 0 TO y1%

WAIT &H3DA, 1, 1: WAIT &H3DA, 1




f1% = fsin2%(y2%(y%) + l%) + fsin3%(y% - m%)
f2% = fsin2%(y% + l%) + fsin1%(y2%(y%) + k%)


FOR i% = 1 TO 15

b01%(f1% + i%) = i%
b02%(f2% + i%) = p16%(i%)

POKE f1% + i%, i% OR b02%(f1% + i%)
POKE f2% + i%, p16%(i%) OR b01%(f2% + i%)
NEXT i%


OUT &H3C8, 0
OUT &H3C9, (63 - lc%(y%))
OUT &H3C9, (63 - lc%(y%)) / 2
OUT &H3C9, lc%(y%)


NEXT y%


FOR i% = 0 TO 319: POKE i%, 0: NEXT i%
FOR i% = 0 TO 319: b01%(i%) = 0: b02%(i%) = 0: NEXT i%

LOOP

out1:







' --------- RGB copper bars -----------



CLS

FOR i% = 0 TO 7
OUT &H3C8, i%
OUT &H3C9, i% * 5 + 28
OUT &H3C9, 0
OUT &H3C9, 0
NEXT i%


FOR i% = 8 TO 15
OUT &H3C8, i%
OUT &H3C9, 0
OUT &H3C9, (i% - 8) * 5 + 28
OUT &H3C9, 0
NEXT i%

FOR i% = 16 TO 23
OUT &H3C8, i%
OUT &H3C9, 0
OUT &H3C9, 0
OUT &H3C9, (i% - 16) * 5 + 28
NEXT i%


OUT &H3D4, &H13
OUT &H3D5, 0

FOR i% = 0 TO 7: c1%(i%) = i%: c2%(i%) = i% + 8: c3%(i%) = i% + 16: NEXT i%: c1%(0) = 1





k% = 0
l% = 0
m% = 0
fps% = 0
y1% = 0
DO WHILE INKEY$ = ""
k% = k% + 3: IF k% >= 283 THEN k% = 0
l% = l% + 2: IF l% >= 157 THEN l% = 0
m% = m% + 1: IF m% >= 471 THEN m% = 0

fps% = fps% + 1

IF fps% < 400 AND y1% < 395 THEN y1% = y1% + 1
IF fps% > 1200 AND y1% <> 0 THEN y1% = y1% - 1
IF y1% = 0 THEN GOTO out2


WAIT &H3DA, 8: WAIT &H3DA, 8, 8

DEF SEG = &HA000

FOR y% = 0 TO y1%

WAIT &H3DA, 1

FOR i% = 0 TO 7
POKE fsin2%(y2%(y%) + l%) + fsin3%(y% - m%) + i%, c1%(i%)
POKE fsin2%(y% + l%) + fsin1%(y2%(y%) + k%) + i%, c2%(i%)
POKE fsin1%(y% + k%) + fsin2%(y% + l%) + fsin3%(y% + m%) + i% - 99, c3%(i%)
NEXT i%

OUT &H3C8, 0
OUT &H3C9, lc%(y%)
OUT &H3C9, 63 - lc%(y%)
OUT &H3C9, 63 - lc%(y%)

WAIT &H3DA, 1, 1

NEXT y%


FOR i% = 0 TO 319: POKE i%, 0: NEXT i%

LOOP

out2:


OUT &H3D4, &H28
OUT &H3D5, &H13

SCREEN 13
SCREEN 1

OUT &H3D4, &H28
OUT &H3D5, &H13

END SUB

SUB createobject (a%)


CONST pi = 3.1415926#
rtm = 180 / pi


clearscreen 0

SELECT CASE a%


CASE 1

' ========== Creating object 1 - Cube ==========


FOR i% = 0 TO 4

xo%(i%) = 2 * i% - 5: yo%(i%) = 5: zo%(i%) = 5
xo%(i% + 5) = 2 * i% - 5: yo%(i% + 5) = 5: zo%(i% + 5) = -5
xo%(i% + 10) = 2 * i% - 5: yo%(i% + 10) = -5: zo%(i% + 10) = 5
xo%(i% + 15) = 2 * i% - 5: yo%(i% + 15) = -5: zo%(i% + 15) = -5
xo%(i% + 20) = -5: yo%(i% + 20) = 5: zo%(i% + 20) = 2 * i% - 5
xo%(i% + 25) = 5: yo%(i% + 25) = 5: zo%(i% + 25) = 2 * i% - 5
xo%(i% + 30) = -5: yo%(i% + 30) = -5: zo%(i% + 30) = 2 * i% - 5
xo%(i% + 35) = 5: yo%(i% + 35) = -5: zo%(i% + 35) = 2 * i% - 5
xo%(i% + 40) = 5: yo%(i% + 40) = 2 * i% - 5: zo%(i% + 40) = 5
xo%(i% + 45) = 5: yo%(i% + 45) = 2 * i% - 5: zo%(i% + 45) = -5
xo%(i% + 50) = -5: yo%(i% + 50) = 2 * i% - 5: zo%(i% + 50) = 5
xo%(i% + 55) = -5: yo%(i% + 55) = 2 * i% - 5: zo%(i% + 55) = -5

NEXT i%

xo%(60) = 5: yo%(60) = 5: zo%(60) = 5
xo%(61) = 5: yo%(61) = 5: zo%(61) = 5
xo%(62) = 5: yo%(62) = 5: zo%(62) = 5
xo%(63) = 5: yo%(63) = 5: zo%(63) = 5



' ========== Random copier for object 1 ==========

FOR j% = 1 TO 63
metx% = INT(RND * 64 - 32)
mety% = INT(RND * 64 - 32)
metz% = INT(RND * 64 - 32)

FOR i% = 0 TO 63
xo%(i% + j% * 64) = xo%(i%) + metx%
yo%(i% + j% * 64) = yo%(i%) + mety%
zo%(i% + j% * 64) = zo%(i%) + metz%
NEXT i%

NEXT j%

' =================================



CASE 2


' ========== Creating object 2 - Sphere ==========


j% = 0
FOR i% = 90 TO 270 STEP 11.25
c = i% / rtm
xo%(j%) = COS(c) * 63: yo%(j%) = SIN(c) * 63: zo%(j%) = 0
j% = j% + 1
NEXT i%



yr = 0
FOR i% = 1 TO 15

yr = yr + 22.5

c = yr / rtm

cosyr = COS(c)
sinyr = SIN(c)

FOR j% = 0 TO 15
xo%(j% + i% * 16) = cosyr * xo%(j%) - sinyr * zo%(j%)
zo%(j% + i% * 16) = sinyr * xo%(j%) + cosyr * zo%(j%)
yo%(j% + i% * 16) = yo%(j%)
NEXT j%

NEXT i%



' ========== Random copier for object 2 ==========

FOR j% = 1 TO 15
metx% = INT(RND * 512 - 256)
mety% = INT(RND * 512 - 256)
metz% = INT(RND * 512 - 256)

FOR i% = 0 TO 255
xo%(i% + j% * 256) = xo%(i%) + metx%
yo%(i% + j% * 256) = yo%(i%) + mety%
zo%(i% + j% * 256) = zo%(i%) + metz%
NEXT i%

NEXT j%


CASE 3

' ========== Creating object 3 - Torus ==========

j% = 0
FOR i% = 0 TO 359 STEP 22.5
c = i% / rtm
xo%(j%) = COS(c) * 64: yo%(j%) = SIN(c) * 64: zo%(j%) = 0
j% = j% + 1
NEXT i%


i% = 90
c = i% / rtm
cosyr = COS(c)
sinyr = SIN(c)

FOR i% = 0 TO 15
xp = xo%(i%)
xo%(i%) = cosyr * xp - sinyr * zo%(i%)
zo%(i%) = sinyr * xp + cosyr * zo%(i%)
yo%(i%) = yo%(i%) - 192
NEXT i%


zr = 0

FOR j% = 1 TO 31
zr = zr + 11.25
c = zr / rtm

coszr = COS(c)
sinzr = SIN(c)

FOR i% = 0 TO 15
xo%(i% + j% * 16) = coszr * xo%(i%) - sinzr * yo%(i%)
yo%(i% + j% * 16) = sinzr * xo%(i%) + coszr * yo%(i%)
zo%(i% + j% * 16) = zo%(i%)
NEXT i%

NEXT j%



' ========== Random copier for object 3 ==========

FOR j% = 1 TO 7

xr = (INT(RND * 180) - 90) / rtm
yr = (INT(RND * 180) - 90) / rtm
zr = (INT(RND * 180) - 90) / rtm
cosxr = COS(xr)
cosyr = COS(yr)
coszr = COS(zr)
sinxr = SIN(xr)
sinyr = SIN(yr)
sinzr = SIN(zr)

metx% = INT(RND * 1024 - 512)
mety% = INT(RND * 1024 - 512)
metz% = INT(RND * 1024 - 512)


FOR i% = 0 TO 511

x(i%) = cosyr * xo%(i%) - sinyr * zo%(i%)
z(i%) = sinyr * xo%(i%) + cosyr * zo%(i%)

y(i%) = cosxr * yo%(i%) - sinxr * z(i%)
z(i%) = sinxr * yo%(i%) + cosxr * z(i%)

nx = x(i%)
x(i%) = coszr * nx - sinzr * y(i%)
y(i%) = sinzr * nx + coszr * y(i%)

xo%(i% + j% * 512) = x(i%) + metx%
yo%(i% + j% * 512) = y(i%) + mety%
zo%(i% + j% * 512) = z(i%) + metz%
NEXT i%
NEXT j%

CASE ELSE


END SELECT


END SUB

SUB crosfade (r1%(), r2%(), g1%(), g2%(), b1%(), b2%())

SHARED xit%

FOR k% = 0 TO 63
WAIT &H3DA, 8: WAIT &H3DA, 8, 8
IF xit% = 0 THEN keyaction
IF xit% = 1 THEN GOTO endcrosfade


OUT &H3C8, 0
    FOR c% = 0 TO 255
      IF r1%(c%) < r2%(c%) THEN r1%(c%) = r1%(c%) + 1 ELSE IF r1%(c%) > r2%(c%) THEN r1%(c%) = r1%(c%) - 1
      IF g1%(c%) < g2%(c%) THEN g1%(c%) = g1%(c%) + 1 ELSE IF g1%(c%) > g2%(c%) THEN g1%(c%) = g1%(c%) - 1
      IF b1%(c%) < b2%(c%) THEN b1%(c%) = b1%(c%) + 1 ELSE IF b1%(c%) > b2%(c%) THEN b1%(c%) = b1%(c%) - 1
     OUT &H3C9, r1%(c%)
     OUT &H3C9, g1%(c%)
     OUT &H3C9, b1%(c%)
    NEXT c%
NEXT k%

endcrosfade:
END SUB

SUB cycleblobs

SHARED xit%

n% = 7

FOR i% = 0 TO 127
OUT &H3C8, i%
OUT &H3C9, 0
OUT &H3C9, 0
OUT &H3C9, 0
NEXT i%


FOR y% = 0 TO 99
FOR x% = 0 TO 159
sp%(p%) = 16384 \ SQR((160 - x%) ^ 2 + (100 - y%) ^ 2) ^ 1.5
IF sp%(p%) > 255 THEN sp%(p%) = 255
p% = p% + 1
NEXT x%
NEXT y%

FOR i% = 0 TO 319
IF i% < 160 THEN fsin2%(i%) = i% ELSE fsin2%(i%) = 319 - i%
NEXT i%

FOR i% = 0 TO 199
IF i% > 99 THEN fsin3%(i%) = (199 - i%) * 160 ELSE fsin3%(i%) = i% * 160
NEXT i%

FOR i% = 0 TO 1792
IF i% > 255 THEN cd%(i%) = 255 ELSE cd%(i%) = i%
NEXT i%

FOR i% = 1 TO n%
dsx%(i%) = INT(RND * 35 + 25)
dsy%(i%) = INT(RND * 35 + 25)
psx%(i%) = INT(RND * 64 + 64)
psy%(i%) = INT(RND * 50 + 50)
NEXT i%

m% = 0: q% = 32: r%(1) = 1: g%(1) = 1: B%(1) = 1

fps% = 0
DO
fps% = fps% + 1
k% = k% + 1
m% = m% + 1
IF fps% < 1600 AND m% = q% THEN m% = 0: q% = INT(RND * 255 + 5): r%(1) = r%(2): g%(1) = g%(2): B%(1) = B%(2): r%(2) = INT(RND * 63) + 1: g%(2) = INT(RND * 63) + 1: B%(2) = INT(RND * 63) + 1
IF fps% > 1600 AND fps% < 1855 AND m% = q% THEN sq% = 1: m% = 0: q% = 255: r%(1) = r%(2): g%(1) = g%(2): B%(1) = B%(2): r%(2) = 0: g%(2) = 0: B%(2) = 0
IF fps% > 1856 AND sq% = 1 AND m% >= q% THEN GOTO gout4
IF fps% > 2100 THEN GOTO gout4
r% = r%(1) + (r%(2) - r%(1)) / q% * m%
g% = g%(1) + (g%(2) - g%(1)) / q% * m%
B% = B%(1) + (B%(2) - B%(1)) / q% * m%
IF r% = 0 THEN r% = 1
IF g% = 0 THEN g% = 1
IF B% = 0 THEN B% = 1

FOR c% = 128 TO 255
OUT &H3C8, c%
IF c% < 192 THEN OUT &H3C9, (c% - 128) / (63 / r%): OUT &H3C9, (c% - 128) / (63 / g%): OUT &H3C9, (c% - 128) / (63 / B%) ELSE OUT &H3C9, (255 - c%) / (63 / r%): OUT &H3C9, (255 - c%) / (63 / g%): OUT &H3C9, (255 - c%) / (63 / B%)
NEXT c%

FOR i% = 1 TO n%
xp1%(i%) = SIN(k% / dsx%(i%)) * psx%(i%)
yp1%(i%) = SIN(k% / dsy%(i%)) * psy%(i%)
NEXT i%

yp% = 0
FOR y% = 0 TO 199
DEF SEG = &HA000 + yp%
yp% = yp% + 20

yy%(1) = fsin3%(y% - yp1%(1))
yy%(2) = fsin3%(y% - yp1%(2))
yy%(3) = fsin3%(y% - yp1%(3))
yy%(4) = fsin3%(y% - yp1%(4))
yy%(5) = fsin3%(y% - yp1%(5))
yy%(6) = fsin3%(y% - yp1%(6))
yy%(7) = fsin3%(y% - yp1%(7))

FOR x% = 24 TO 295
dn% = sp%(yy%(1) + fsin2%(x% - xp1%(1))) + sp%(yy%(2) + fsin2%(x% - xp1%(2))) + sp%(yy%(3) + fsin2%(x% - xp1%(3))) + sp%(yy%(4) + fsin2%(x% - xp1%(4))) + sp%(yy%(5) + fsin2%(x% - xp1%(5))) + sp%(yy%(6) + fsin2%(x% - xp1%(6))) + sp%(yy%(7) + fsin2%( _
x% - xp1%(7)))
POKE x%, cd%(dn%)

NEXT x%
NEXT y%

WAIT &H3DA, 8: WAIT &H3DA, 8, 8
IF xit% = 0 THEN keyaction
IF xit% = 1 THEN GOTO gout4

LOOP
gout4:

END SUB

SUB deedlinesax (c%)

SHARED xit%

LINE (20, 20)-(25, 80), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax
LINE (25, 80)-(60, 70), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax
LINE (60, 70)-(55, 30), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax
LINE (55, 30)-(20, 20), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax

LINE (25, 25)-(30, 60), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax
LINE (30, 60)-(50, 65), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax
LINE (50, 65)-(25, 25), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax

IF c% = 15 THEN f% = INT(RND * 255) ELSE f% = 0
PAINT (23, 23), f%, c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax

LINE (65, 20)-(100, 24), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax
LINE (100, 24)-(70, 34), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax
LINE (70, 34)-(85, 44), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax
LINE (85, 44)-(75, 54), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax
LINE (75, 54)-(75, 64), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax
LINE (75, 64)-(85, 64), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax
LINE (85, 64)-(70, 70), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax
LINE (70, 70)-(65, 20), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax

IF c% = 15 THEN f% = INT(RND * 255) ELSE f% = 0
PAINT (66, 21), f%, c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax

LINE (110, 30)-(130, 30), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax
LINE (130, 30)-(110, 40), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax
LINE (110, 40)-(110, 50), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax
LINE (110, 50)-(125, 50), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax
LINE (125, 50)-(125, 55), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax
LINE (125, 55)-(110, 55), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax
LINE (110, 55)-(110, 65), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax
LINE (110, 65)-(120, 65), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax
LINE (120, 65)-(120, 70), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax
LINE (120, 70)-(100, 70), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax
LINE (100, 70)-(110, 30), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax

IF c% = 15 THEN f% = INT(RND * 255) ELSE f% = 0
PAINT (111, 31), f%, c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax

LINE (150, 40)-(130, 20), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax
LINE (130, 20)-(140, 70), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax
LINE (140, 70)-(150, 40), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax

LINE (135, 30)-(140, 60), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax
LINE (140, 60)-(145, 40), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax
LINE (145, 40)-(135, 30), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax

IF c% = 15 THEN f% = INT(RND * 255) ELSE f% = 0
PAINT (133, 25), f%, c%: delay 10


LINE (160, 30)-(165, 70), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax
LINE (165, 70)-(190, 70), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax
LINE (190, 70)-(175, 65), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax
LINE (175, 65)-(160, 30), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax

IF c% = 15 THEN f% = INT(RND * 255) ELSE f% = 0
PAINT (164, 40), f%, c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax

LINE (180, 20)-(190, 60), c%, BF: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax

LINE (195, 20)-(195, 70), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax
LINE (195, 70)-(200, 40), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax
LINE (200, 40)-(220, 65), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax
LINE (220, 65)-(220, 35), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax
LINE (220, 35)-(215, 55), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax
LINE (215, 55)-(195, 20), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax

IF c% = 15 THEN f% = INT(RND * 255) ELSE f% = 0
PAINT (196, 30), f%, c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax


LINE (245, 20)-(225, 20), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax
LINE (225, 20)-(225, 60), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax
LINE (225, 60)-(250, 60), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax
LINE (250, 60)-(250, 50), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax
LINE (250, 50)-(230, 50), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax
LINE (230, 50)-(230, 40), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax
LINE (230, 40)-(240, 40), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax
LINE (240, 40)-(240, 35), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax
LINE (240, 35)-(228, 35), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax
LINE (228, 35)-(230, 25), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax
LINE (230, 25)-(245, 20), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax

IF c% = 15 THEN f% = INT(RND * 255) ELSE f% = 0
PAINT (227, 24), f%, c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax

LINE (300, 5)-(260, 8), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax
LINE (260, 8)-(290, 58), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax
LINE (290, 58)-(250, 68), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax
LINE (250, 68)-(305, 64), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax
LINE (305, 64)-(270, 18), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax
LINE (270, 18)-(300, 5), c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax

IF c% = 15 THEN f% = INT(RND * 255) ELSE f% = 0
PAINT (265, 10), f%, c%: delay 10: IF xit% = 1 THEN GOTO enddeedlinesax


COLOR c% \ 15
LOCATE 1, 1: PRINT "SAX!"
delay 70: IF xit% = 1 THEN GOTO enddeedlinesax

FOR y% = 0 TO 63
FOR x% = 0 TO 255
a% = POINT(x% \ 8, y% \ 8) * (SIN(y% / 45) * c% + COS(x% / 45) * c% + 2 * c%)
PSET (x% + 40, y% + 100), a%
NEXT x%
NEXT y%
delay 140: IF xit% = 1 THEN GOTO enddeedlinesax

COLOR c%
LOCATE 22, 10: PRINT "Not so serious side :)": PRINT "Just for fun or boredom to draw anything"

enddeedlinesax:

END SUB

SUB delay (t%)

SHARED xit%

FOR i% = 1 TO t%
WAIT &H3DA, 8: WAIT &H3DA, 8, 8
keyaction
IF xit% = 1 THEN GOTO endelay
NEXT i%

endelay:
END SUB

SUB fadefromcolor (a%, c%, t%, r%, g%, B%)

SHARED xit%

FOR s% = 1 TO t%

OUT &H3C8, a%
FOR k% = a% TO c%
OUT &H3C9, r% + s% * ((r%(k%) - r%) / t%)
OUT &H3C9, g% + s% * ((g%(k%) - g%) / t%)
OUT &H3C9, B% + s% * ((B%(k%) - B%) / t%)
NEXT k%

WAIT &H3DA, 8: WAIT &H3DA, 8, 8
IF xit% = 0 THEN keyaction
IF xit% = 1 THEN GOTO endfadefromcolor
NEXT s%


endfadefromcolor:
END SUB

SUB fadetocolor (a%, c%, t%, r%, g%, B%)

SHARED xit%

FOR s% = 1 TO t%

OUT &H3C8, a%
FOR k% = a% TO c%
OUT &H3C9, r%(k%) + s% * ((r% - r%(k%)) / t%)
OUT &H3C9, g%(k%) + s% * ((g% - g%(k%)) / t%)
OUT &H3C9, B%(k%) + s% * ((B% - B%(k%)) / t%)
NEXT k%

WAIT &H3DA, 8: WAIT &H3DA, 8, 8
IF xit% = 0 THEN keyaction
IF xit% = 1 THEN GOTO endfadetocolor

NEXT s%

endfadetocolor:
END SUB

SUB getmap (a$)

' ------------------ Get Map --------------------

open ".\samples\pete\optimus\"+a$ FOR BINARY AS #1

GET #1, 1, a$
xg% = ASC(a$)
GET #1, 2, a$
yg% = ASC(a$)

k% = 2
FOR y% = 0 TO yg% - 1
FOR x% = 0 TO xg% - 1

k% = k% + 1
GET #1, k%, a$
cd%(y% * 32 + x%) = ASC(a$)

NEXT x%
NEXT y%
CLOSE

END SUB

SUB getpal

OUT &H3C7, 0
FOR k% = 0 TO 255
r%(k%) = INP(&H3C9)
g%(k%) = INP(&H3C9)
B%(k%) = INP(&H3C9)
NEXT k%

END SUB

SUB initcrosfadepics (a%, B%)

FOR l% = 0 TO 11

FOR g% = 0 TO 19
c$ = MID$(text$(a%, l%), g% + 1, 1)
d$ = MID$(text$(B%, l%), g% + 1, 1)

yp% = 0
FOR y% = 0 TO 15
DEF SEG = &HA000 + yp% + l% * 320
yp% = yp% + 20

FOR x% = 0 TO 15
POKE x% + g% * 16, fonts%(fpos%(ASC(c$)) * 256 + y% * 16 + x%) OR (fonts%(fpos%(ASC(d$)) * 256 + y% * 16 + x%)) * 16
NEXT x%
NEXT y%

NEXT g%

NEXT l%

END SUB

SUB Intersections

SHARED px%, py%, pa%, ps%
SHARED va%, ra, dpp%


va = pa% + 32.2
IF va > 360 THEN va = 32.2 - (360 - pa%)

FOR sl% = 0 TO 319
va = va - ra
IF va < 0 THEN va = 358.8
va% = va

IF va% = 0 OR va% = 180 OR va% = 360 THEN GOTO 112


' ---------- Horizontal intersection ----------------

IF va% > 0 AND va% < 180 THEN ay% = (py% \ 64) * 64 - 1 ELSE IF va% > 180 AND va% < 360 THEN ay% = (py% \ 64) * 64 + 64
ax% = px% + (py% - ay%) / TAN(va / 57.3)

bx% = ax% \ 64
by% = ay% \ 64
IF bx% < 0 THEN bx% = 0
IF bx% > 31 THEN bx% = 31
IF by% < 0 THEN by% = 0
IF by% > 31 THEN by% = 31

IF cd%(mul32%(by%) + bx%) = 1 THEN cx% = ax%: cy% = ay%: GOTO 112

IF va% > 0 AND va% < 180 THEN yd% = -64 ELSE IF va% > 180 AND va% < 360 THEN yd% = 64

xd% = (-yd%) / TAN(va / 57.3)
IF xd% > 2048 THEN xd% = 2048
IF xd% < -2048 THEN xd% = -2048
cx% = ax%: cy% = ay%

DO
cx% = cx% + xd%: IF cx% > 2048 OR cx% < -2048 THEN GOTO 112
cy% = cy% + yd%: IF cy% > 2048 OR cy% < -2048 THEN GOTO 112
bx% = cx% \ 64: by% = cy% \ 64
IF bx% < 0 THEN bx% = 0
IF bx% > 31 THEN bx% = 31
IF by% < 0 THEN by% = 0
IF by% > 31 THEN by% = 31

LOOP UNTIL cd%(mul32%(by%) + bx%) = 1 OR bx% = 31 OR by% = 31


112
cxa% = cx%: cya% = cy%

IF va% = 90 OR va% = 270 THEN GOTO 113


' ---------- Vertical intersection ----------------

IF va% > 270 OR va% < 90 THEN ax% = (px% \ 64) * 64 + 64 ELSE IF va% > 90 OR va% < 270 THEN ax% = (px% \ 64) * 64 - 1
ay% = py% - (ax% - px%) * TAN(va / 57.3)

bx% = ax% \ 64
by% = ay% \ 64
IF bx% < 0 THEN bx% = 0
IF bx% > 31 THEN bx% = 31
IF by% < 0 THEN by% = 0
IF by% > 31 THEN by% = 31

IF cd%(mul32%(by%) + bx%) = 1 THEN cx% = ax%: cy% = ay%: GOTO 113

IF va% > 270 OR va% < 90 THEN xd% = 64 ELSE IF va% > 90 OR va% < 270 THEN xd% = -64

yd% = (-xd%) * TAN(va / 57.3)
cx% = ax%: cy% = ay%


DO
cx% = cx% + xd%: cy% = cy% + yd%
bx% = cx% \ 64: by% = cy% \ 64
IF bx% < 0 OR bx% > 31 THEN bx% = 31
IF by% < 0 OR by% > 31 THEN by% = 31

LOOP UNTIL cd%(mul32%(by%) + bx%) = 1 OR bx% = 31 OR by% = 31

113



cxb% = cx%: cyb% = cy%

wdisa% = SQR((px% - cxa%) ^ 2 + (py% - cya%) ^ 2)
wdisb% = SQR((px% - cxb%) ^ 2 + (py% - cyb%) ^ 2)

IF wdisa% < wdisb% THEN wdis% = wdisa% ELSE wdis% = wdisb%

dis%(sl%) = wdis% * COS((pa% - va) / 57.3)
slc%(sl%) = 64 * (dpp% / dis%(sl%))
IF slc%(sl%) > 200 THEN slc%(sl%) = 200
sc%(sl%) = 254 - dis%(sl%) \ 2: IF sc%(sl%) < 0 THEN sc%(sl%) = 0


sla%(sl%) = (200 - slc%(sl%)) \ 2: slb%(sl%) = sla%(sl%) + slc%(sl%)



NEXT sl%

117

END SUB

SUB keyaction

SHARED xit%

kb% = INP(&H60)
IF kb% = 1 THEN xit% = 1
END SUB

SUB load3drecord

SHARED gi$, gg$, ggi%, gi%, filei%, gg%

IF ggi% < gi% THEN ggi% = ggi% + 1 ELSE GET #2, , gi$: gi% = ASC(gi$): GET #2, , gg$: gg% = ASC(gg$): ggi% = 1: filei% = filei% + 2


END SUB

SUB loadobject (a$)

SHARED ndts%, nlns%, npls%

clearscreen 0

open ".\samples\pete\optimus\"+a$ FOR BINARY AS #1

GET #1, , ndts%
GET #1, , nlns%
GET #1, , npls%

a$ = " "

FOR i% = 0 TO ndts% - 1
GET #1, , a$: xo%(i%) = ASC(a$) - 128
GET #1, , a$: yo%(i%) = ASC(a$) - 128
GET #1, , a$: zo%(i%) = ASC(a$) - 128
NEXT i%

FOR i% = 0 TO nlns% - 1
'GET #1, , ln%(i%, 0)
'GET #1, , ln%(i%, 1)
NEXT i%

FOR i% = 0 TO npls% - 1
'GET #1, , pl%(i%, 0)
'GET #1, , pl%(i%, 1)
'GET #1, , pl%(i%, 2)
NEXT i%

CLOSE #1

END SUB

SUB loadqbinside

' ------------ Load Quickbasic inside Big --------------

a$ = "qbrules.spr"
c$ = " "
open ".\samples\pete\optimus\"+a$ FOR BINARY AS #1

OUT &H3C8, 128
FOR i% = 0 TO 383
GET #1, , c$: OUT &H3C9, ASC(c$)
NEXT i%


xg% = 100
yg% = 100

i% = 0
FOR y% = 1 TO yg%
FOR x% = 1 TO xg%
GET #1, , c$: sp%(i%) = ASC(c$)
i% = i% + 1
NEXT x%
NEXT y%
CLOSE #1


END SUB

SUB loadrecord

SHARED k$, gi$, gg$, ggi%, gi%, filei%, gg%

IF ggi% < gi% THEN ggi% = ggi% + 1 ELSE GET #2, , gi$: gi% = ASC(gi$): GET #2, , gg$: gg% = ASC(gg$): ggi% = 1: filei% = filei% + 2
pushgg% = gg%
FOR i% = 4 TO 1 STEP -1
IF gg% - 2 ^ (i% - 1) >= 0 THEN gg% = gg% - 2 ^ (i% - 1): ka%(i%) = 1 ELSE ka%(i%) = 0
NEXT i%
gg% = pushgg%

kon%(75) = ka%(1)
kon%(77) = ka%(2)
kon%(72) = ka%(3)
kon%(80) = ka%(4)

END SUB

SUB mov3dpos (xp, yp, zp)

SHARED ndts%

FOR i% = 0 TO ndts% - 1
x(i%) = x(i%) + xp
y(i%) = y(i%) + yp
z(i%) = z(i%) + zp
NEXT i%

END SUB

SUB Output0

SHARED map%, px%, py%

' -------------- Output ------------------

cx% = px% \ 64
cy% = py% \ 64

SELECT CASE map%

CASE 0

yp% = 0
FOR y% = 0 TO 199
DEF SEG = &HA000 + yp%
yp% = yp% + 20

FOR x% = 0 TO 319

IF y% > sla%(x%) AND y% < slb%(x%) THEN POKE x%, sc%(x%) ELSE POKE x%, fs%(y%)

NEXT x%
NEXT y%

sp%(mul128%(py% \ 16) + px% \ 16) = 24


CASE 1

yp% = 0
FOR y% = 0 TO 199
DEF SEG = &HA000 + yp%
yp% = yp% + 20

FOR x% = 0 TO 319

IF y% > sla%(x%) AND y% < slb%(x%) THEN c% = sc%(x%) ELSE c% = fs%(y%)
IF x% > 127 OR y% > 127 THEN POKE x%, c% ELSE POKE x%, div2%(c%) + sp%(mul128%(y%) + x%)

NEXT x%
NEXT y%

sp%(mul128%(py% \ 16) + px% \ 16) = 24


CASE ELSE
END SELECT


END SUB

SUB output3d

SHARED ftype%, ndts%, nlns%, obj%
SHARED filei%

zp% = zpo%(obj%)
SELECT CASE ftype%

CASE IS = 0

FOR i% = 0 TO ndts% - 1

xak% = xs%(i%, 1) + 160
IF xak% > -1 AND xak% < 320 AND ys%(i%, 1) > -101 AND ys%(i%, 1) < 100 THEN POKE ypk&(ys%(i%, 1)) + xak%, 0

xsk% = xs%(i%, 0) + 160
c% = 256 - z(i%) * (80 / zp%): IF c% < 80 THEN c% = 80
IF xsk% > -1 AND xsk% < 320 AND ys%(i%, 0) > -101 AND ys%(i%, 0) < 100 THEN POKE ypk&(ys%(i%, 0)) + xsk%, c%


NEXT i%


SELECT CASE filei%

CASE 0 TO 10, 780 TO 936, 1320 TO 1440, 2162 TO 2400, 3520 TO 3640, 4180 TO 4230

CASE ELSE
WAIT &H3DA, 8: WAIT &H3DA, 8, 8
END SELECT


CASE ELSE

'FOR i% = 0 TO nlns% - 1
'LINE (xs%(ln%(i%, 0), 1) + 160, ys%(ln%(i%, 0), 1) + 100)-(xs%(ln%(i%, 1), 1) + 160, ys%(ln%(i%, 1), 1) + 100), 1
'NEXT i%
clearscreen 1

OUT &H3C8, 0
OUT &H3C9, 0
OUT &H3C9, 0
OUT &H3C9, 0

WAIT &H3DA, 8: WAIT &H3DA, 8, 8

OUT &H3C8, 0
OUT &H3C9, 63
OUT &H3C9, 0
OUT &H3C9, 0


FOR i% = 0 TO nlns% - 1
'LINE (xs%(ln%(i%, 0), 0) + 160, ys%(ln%(i%, 0), 0) + 100)-(xs%(ln%(i%, 1), 0) + 160, ys%(ln%(i%, 1), 0) + 100), 15
NEXT i%

END SELECT


END SUB

SUB plasmablobs

SHARED xit%

meg = 1.3
n% = 3



OUT &H3C8, 0
FOR i% = 0 TO 127
OUT &H3C9, 0
OUT &H3C9, 0
OUT &H3C9, 0
NEXT i%

FOR i% = 128 TO 159
OUT &H3C9, 0
OUT &H3C9, (i% - 128) * 2
OUT &H3C9, 0
NEXT i%

FOR i% = 160 TO 191
OUT &H3C9, 0
OUT &H3C9, (191 - i%) * 2
OUT &H3C9, 0
NEXT i%

FOR i% = 192 TO 255
OUT &H3C9, i% - 192
OUT &H3C9, i% - 192
OUT &H3C9, i% - 192
NEXT i%

getpal

OUT &H3C8, 0
FOR i% = 0 TO 255
OUT &H3C9, 0
OUT &H3C9, 0
OUT &H3C9, 0
NEXT i%


FOR i% = -157 TO 518
IF i% > -1 AND i% < 519 THEN fsin1%(i%) = SIN(i% / 45) * 63: fsin2%(i%) = SIN(i% / 35) * 127
IF i% > -158 AND i% < 476 THEN fsin3%(i%) = SIN(i% / 25) * 31
NEXT i%


rc% = -1

FOR i% = -1 TO -156 STEP -1
dt100%(i%) = 63 - (i% - ((i% - 63) \ 64) * 64)
IF rc% = 1 THEN dt100%(i%) = 63 - dt100%(i%)
IF dt100%(i%) = 0 AND rc% = 1 THEN rc% = -1
IF dt100%(i%) = 63 AND rc% = -1 THEN rc% = 1
NEXT i%

rc% = 1

FOR i% = 0 TO 156
dt100%(i%) = i% - ((i%) \ 64) * 64
IF rc% = -1 THEN dt100%(i%) = 63 - dt100%(i%)
IF dt100%(i%) = 63 AND rc% = 1 THEN rc% = -1
IF dt100%(i%) = 0 AND rc% = -1 THEN rc% = 1
NEXT i%




DIM cf%(0 TO 4095)

l% = 0
FOR i% = 0 TO 63
FOR k% = 0 TO 63
cf%(l%) = i% * (k% / 63)
l% = l% + 1
NEXT k%
NEXT i%


i% = 0
FOR y% = 0 TO 99
FOR x% = 0 TO 159
IF x% = 159 AND y% = 99 THEN sp%(i%) = 255 ELSE sp%(i%) = 16384 \ SQR((159 - x%) ^ 2 + (99 - y%) ^ 2) ^ meg
IF sp%(i%) > 255 THEN sp%(i%) = 255
i% = i% + 1
NEXT x%
NEXT y%



FOR i% = -160 TO 479
IF i% < 0 OR i% > 319 THEN fsin4%(i%) = 0 ELSE IF i% < 160 THEN fsin4%(i%) = i% ELSE fsin4%(i%) = 319 - i%
NEXT i%

FOR i% = -100 TO 300
IF i% < 0 OR i% > 199 THEN cy%(i%) = 0 ELSE IF i% > 99 THEN cy%(i%) = 199 - i% ELSE cy%(i%) = i%
cy%(i%) = cy%(i%) * 160
NEXT i%

FOR i% = 0 TO 767
IF i% > 255 THEN cd%(i%) = 255 ELSE cd%(i%) = i%
NEXT i%

FOR i% = -192 TO 63
dt%(i%) = i% * 64
NEXT i%




FOR i% = 1 TO n%
dsx%(i%) = INT(RND * 45 + 45)
dsy%(i%) = INT(RND * 30 + 30)
psx%(i%) = INT(RND * 80 + 80)
psy%(i%) = INT(RND * 50 + 50)
NEXT i%

k% = 0
l% = 0


ax = TIMER


s% = 0: t% = 256
s1% = 0: t1% = 256
k0% = 128: k1% = 191
l0% = 128: l1% = 191
r1% = 0: g1% = 0: b1% = 0
fps% = 0
DO
fps% = fps% + 1
k% = k% + 2
IF k% > 156 THEN k% = 0

l% = l% + 1
FOR i% = 1 TO n%
xp1%(i%) = SIN(l% / dsx%(i%)) * psx%(i%)
yp1%(i%) = SIN(l% / dsy%(i%)) * psy%(i%)
NEXT i%

IF fps% = 512 THEN k0% = 192: k1% = 255: s% = 0
IF fps% = 1512 THEN fadeout% = 1
IF fps% = 2500 THEN getpal: s1% = 0: l0% = 0: l1% = 255: r1% = 63: g1% = 63: b1% = 63
IF fps% = 2800 THEN GOTO gout7

IF s% < t% THEN s% = s% + 1 ELSE GOTO endfadepal1

FOR kk% = k0% TO k1%
OUT &H3C8, kk%
OUT &H3C9, 0 + s% * ((r%(kk%) - 0) / t%)
OUT &H3C9, 0 + s% * ((g%(kk%) - 0) / t%)
OUT &H3C9, 0 + s% * ((B%(kk%) - 0) / t%)
NEXT kk%

endfadepal1:


IF fadeout% = 0 THEN GOTO nofadeout1
IF s1% < t1% THEN s1% = s1% + 1

FOR kk% = l0% TO l1%
OUT &H3C8, kk%
OUT &H3C9, r%(kk%) + s1% * ((r1% - r%(kk%)) / t1%)
OUT &H3C9, g%(kk%) + s1% * ((g1% - g%(kk%)) / t1%)
OUT &H3C9, B%(kk%) + s1% * ((b1% - B%(kk%)) / t1%)
NEXT kk%


nofadeout1:




yp% = 0

FOR y% = 0 TO 199
DEF SEG = &HA000 + yp%
yp% = yp% + 20

yy%(1) = cy%(y% - yp1%(1))
yy%(2) = cy%(y% - yp1%(2))
yy%(3) = cy%(y% - yp1%(3))

FOR x% = 0 TO 319

dyn% = cd%(sp%(yy%(1) + fsin4%(x% - xp1%(1))) + sp%(yy%(2) + fsin4%(x% - xp1%(2))) + sp%(yy%(3) + fsin4%(x% - xp1%(3))))
IF dyn% < 192 THEN POKE x%, dyn% ELSE pls% = dt100%(fsin3%(x% + k%) + fsin3%(y%) + fsin1%(x% + y%) + fsin3%(fsin3%(y% - k%) + fsin2%(x%) + k%)): POKE x%, cf%(dt%(dyn% - 192) + pls%) + 192

NEXT x%
NEXT y%


WAIT &H3DA, 8: WAIT &H3DA, 8, 8
IF xit% = 0 THEN keyaction
IF xit% = 1 THEN GOTO gout7



LOOP

gout7:

END SUB

SUB precalculations



REM --------- Div2 -----------

FOR i% = 0 TO 255
div2%(i%) = i% \ 2
NEXT i%


REM --------- Div4 -----------

FOR i% = 0 TO 320
div4%(i%) = i% \ 4
NEXT i%

REM ----------- Mul32 -------------
FOR i% = 0 TO 32
mul32%(i%) = i% * 32
NEXT i%

REM ----------- Nul128 ------------
FOR i% = 0 TO 127
mul128%(i%) = i% * 128
NEXT i%


REM --------- Map Output buffer precalc ---------


i% = 0
FOR y% = 0 TO 127
FOR x% = 0 TO 127
sp%(i%) = cd%((y% \ 4) * 32 + x% \ 4) * 128

i% = i% + 1
NEXT x%
NEXT y%


REM ----------- Floor&Ceiling Shades -------------

ast = 32 / 100
ang = 0

FOR i% = 0 TO 99

IF ang = 0 THEN ang = .01
dist = 24 / SIN(ang / 57.3)
fs = (255 - dist)
IF fs < 0 THEN fs%(99 - i%) = 0 ELSE fs%(99 - i%) = fs
fs%(i% + 100) = fs%(99 - i%)

ang = ang + ast
NEXT i%


END SUB

SUB prehistoricode

SHARED xit%

l% = 15
SCREEN 12

1
keyaction
IF xit% = 1 THEN GOTO prehistoricodend
COLOR 15: LOCATE 15, 18: PRINT "Press the" + CHR$(34) + "any key" + CHR$(34) + " button to continue.. ;-)"


c% = INT(RND * 63 + 1)
FOR i% = 1 TO 640 STEP 15
LINE (i%, 480)-(640, 480 - i%), i% / c%
NEXT i%
cc% = cc% + 1
CIRCLE (cx%, cy%), cc%, l%
IF cc% = 30 THEN cc% = 0: l% = 0: k% = 1: GOTO 1
IF k% = 1 AND cc% = 29 THEN cc% = 0: l% = 15: cx% = INT(RND * 640): cy% = INT(RND * 480): k% = 0
a$ = INKEY$

WHILE a$ = ""
GOTO 1
a$ = "z"
WEND

FOR z% = 1 TO 480
keyaction
IF xit% = 1 THEN GOTO prehistoricodend
t% = 31 - z% / 16
CIRCLE (320, 240), z%, t%
FOR i& = 0 TO 16383: NEXT i&
NEXT z%
FOR z% = 1 TO 640
keyaction
IF xit% = 1 THEN GOTO prehistoricodend
CIRCLE (320, 240), z%, 0
FOR i& = 0 TO 16383: NEXT i&
NEXT z%


prehistoricodend:

END SUB

SUB rgblights

SHARED xit%

meg = 2.2
n% = 3


FOR i% = 0 TO 127
OUT &H3C8, i%
OUT &H3C9, 0
OUT &H3C9, 0
OUT &H3C9, 0
NEXT i%



i% = 0
OUT &H3C8, 0

FOR a% = 0 TO 5
FOR B% = 0 TO 5
FOR c% = 0 TO 5

OUT &H3C9, a% * 12.6
OUT &H3C9, B% * 12.6
OUT &H3C9, c% * 12.6

r1%(i%) = i%
i% = i% + 1

NEXT c%
NEXT B%
NEXT a%


FOR i% = 0 TO 5
epi6%(i%) = i% * 6
epi36%(i%) = i% * 36
NEXT i%


i% = 0
FOR y% = 0 TO 99
FOR x% = 0 TO 159
IF x% = 159 AND y% = 99 THEN sp%(i%) = 255 ELSE sp%(i%) = 16384 \ SQR((159 - x%) ^ 2 + (99 - y%) ^ 2) ^ meg
IF sp%(i%) > 255 THEN sp%(i%) = 255
i% = i% + 1
NEXT x%
NEXT y%



FOR i% = -320 TO 639
IF i% < 0 OR i% > 319 THEN fsin3%(i%) = 0 ELSE IF i% < 160 THEN fsin3%(i%) = i% ELSE fsin3%(i%) = 319 - i%
NEXT i%

FOR i% = -300 TO 500
IF i% < 0 OR i% > 199 THEN fsin4%(i%) = 0 ELSE IF i% > 99 THEN fsin4%(i%) = 199 - i% ELSE fsin4%(i%) = i%
fsin4%(i%) = fsin4%(i%) * 160
NEXT i%

FOR i% = 0 TO 1792
IF i% > 5 THEN cd%(i%) = 5 ELSE cd%(i%) = i%
NEXT i%




FOR i% = 1 TO n%
dsx%(i%) = INT(RND * 35 + 15)
dsy%(i%) = INT(RND * 35 + 15)
psx%(i%) = INT(RND * 80 + 80)
psy%(i%) = INT(RND * 50 + 50)
NEXT i%

k% = 40
plx = 8: ply = 8
ax = TIMER
DO
k% = k% + 1
IF plx > 1 AND k% < 1024 THEN plx = plx - .025
IF ply > 1 AND k% < 1024 THEN ply = ply - .025
IF k% > 1024 THEN plx = plx + .01: ply = ply + .01
IF k% = 1220 THEN GOTO gout3


FOR i% = 1 TO n%
psx% = psx%(i%) * plx
psy% = psy%(i%) * ply
IF psx% > 320 THEN psx% = 320
IF psy% > 300 THEN psy% = 300
xp1%(i%) = SIN(k% / dsx%(i%)) * psx%
yp1%(i%) = SIN(k% / dsy%(i%)) * psy%
NEXT i%


yp% = 0

FOR y% = 0 TO 199
DEF SEG = &HA000 + yp%
yp% = yp% + 20

yy%(1) = fsin4%(y% - yp1%(1))
yy%(2) = fsin4%(y% - yp1%(2))
yy%(3) = fsin4%(y% - yp1%(3))

FOR x% = 0 TO 319

ca% = cd%(sp%(yy%(1) + fsin3%(x% - xp1%(1))))
cb% = cd%(sp%(yy%(2) + fsin3%(x% - xp1%(2))))
cc% = cd%(sp%(yy%(3) + fsin3%(x% - xp1%(3))))

POKE x%, r1%(ca% + epi6%(cb%) + epi36%(cc%))
NEXT x%
NEXT y%

WAIT &H3DA, 8: WAIT &H3DA, 8, 8
IF xit% = 0 THEN keyaction
IF xit% = 1 THEN GOTO gout3

LOOP

gout3:


END SUB

SUB rotate3d (xr, yr, zr)

SHARED ndts%

cosxr = COS(xr)
cosyr = COS(yr)
coszr = COS(zr)
sinxr = SIN(xr)
sinyr = SIN(yr)
sinzr = SIN(zr)

FOR i% = 0 TO ndts% - 1

x(i%) = cosyr * xo%(i%) - sinyr * zo%(i%)
z(i%) = sinyr * xo%(i%) + cosyr * zo%(i%)

y(i%) = cosxr * yo%(i%) - sinxr * z(i%)
z(i%) = sinxr * yo%(i%) + cosxr * z(i%)

nx = x(i%)
x(i%) = coszr * nx - sinzr * y(i%)
y(i%) = sinzr * nx + coszr * y(i%)

NEXT i%


END SUB

SUB saverecord

SHARED k$

k$ = CHR$(kon%(75)): PUT #2, , k$
k$ = CHR$(kon%(77)): PUT #2, , k$
k$ = CHR$(kon%(72)): PUT #2, , k$
k$ = CHR$(kon%(80)): PUT #2, , k$

END SUB

SUB setcrosfadepal (r1%(), r2%(), g1%(), g2%(), b1%(), b2%())

OUT &H3C8, 0

FOR j% = 0 TO 15
FOR i% = 0 TO 15
OUT &H3C9, i% * 4: r1%(j% * 16 + i%) = i% * 4
OUT &H3C9, i% * 4: g1%(j% * 16 + i%) = i% * 4
OUT &H3C9, i% * 4: b1%(j% * 16 + i%) = i% * 4
NEXT i%
NEXT j%

FOR i% = 0 TO 255
r2%(i%) = (i% \ 16) * 4
g2%(i%) = (i% \ 16) * 4
b2%(i%) = (i% \ 16) * 4
NEXT i%

END SUB

SUB setpal (c1%, c2%, r1%, g1%, b1%, r2%, g2%, b2%)

dc% = c2% - c1%
r = r1%: g = g1%: B = b1%


OUT &H3C8, c1%

FOR i% = c1% TO c2%

OUT &H3C9, r
OUT &H3C9, g
OUT &H3C9, B

r = r + (r2% - r1%) / dc%
g = g + (g2% - g1%) / dc%
B = B + (b2% - b1%) / dc%

NEXT i%


END SUB

SUB spheremaplasma

SHARED xit%

' ------------- Sphere mapped plasma ------------



setpal 0, 31, 0, 0, 0, 63, 0, 0
setpal 32, 63, 63, 0, 0, 63, 0, 63
setpal 64, 95, 63, 0, 63, 0, 63, 63
setpal 96, 127, 0, 63, 63, 0, 0, 0

setpal 128, 159, 0, 0, 31, 31, 0, 31
setpal 160, 191, 31, 0, 31, 31, 0, 63
setpal 192, 223, 31, 0, 63, 0, 47, 63
setpal 224, 254, 0, 47, 63, 0, 0, 31

getpal
r%(255) = 0: g%(255) = 0: B%(255) = 31

setpal 0, 255, 63, 63, 63, 63, 63, 63

delay 210



a$ = "sphrprec.dat"

fp& = -1
open ".\samples\pete\optimus\"+a$ FOR BINARY AS #1

FOR i% = 0 TO 16383

fp& = fp& + 2
GET #1, fp&, a$
xp% = ASC(a$)
GET #1, fp& + 1, a$
yp% = ASC(a$)

sp%(i%) = yp% * 128 + xp%
IF i% = 64 * 128 + 64 THEN sp%(i%) = sp%(i%) + 1

NEXT i%

CLOSE



dg% = 99

FOR i% = -180 TO -1
dt%(i%) = i% - ((i% - dg% + 1) \ dg%) * dg%
dt100%(i%) = (i% - ((i% - dg% + 1) \ dg%) * dg%) * 100
NEXT i%

FOR i% = 0 TO 180
dt%(i%) = i% - ((i% - 1) \ dg%) * dg%
dt100%(i%) = (i% - ((i% - 1) \ dg%) * dg%) * 100
NEXT i%



FOR i% = -640 TO 518
fsin2%(i%) = SIN(i% / 16) * 31
NEXT i%

FOR i% = -640 TO 715
fsin3%(i%) = SIN(i% / 63) * 75
NEXT i%


FOR i% = -168 TO 168
mod256128%(i%) = ((i% + 512) MOD 256) \ 2
NEXT i%







xs = 91: vxs = 1: ys = -96: vys = 0: fs = 0
yys% = 134


WHILE INKEY$ <> "": WEND

s% = 0: t% = 256
s1% = 0: t1% = 256
fps% = 0


k% = 0: l% = 0
DO
fps% = fps% + 1
k% = k% + 1: l% = l% + 1
IF k% = 101 THEN k% = 0
IF l% = 396 THEN l% = 0
m% = -1

IF fps% = 256 THEN fs = .02
IF fps% = 256 + 768 THEN yys% = 654
IF fps% = 256 + 1024 THEN fadeout% = 1


IF s% < t% THEN s% = s% + 1 ELSE GOTO endfadepal

OUT &H3C8, 0
FOR n% = 0 TO 255
OUT &H3C9, 63 + s% * ((r%(n%) - 63) / t%)
OUT &H3C9, 63 + s% * ((g%(n%) - 63) / t%)
OUT &H3C9, 63 + s% * ((B%(n%) - 63) / t%)
NEXT n%

endfadepal:


IF fadeout% = 0 THEN GOTO nofadeout
IF s1% < t1% THEN s1% = s1% + 1 ELSE GOTO gout

OUT &H3C8, 0
FOR n% = 0 TO 255
OUT &H3C9, r%(n%) + s1% * ((0 - r%(n%)) / t1%)
OUT &H3C9, g%(n%) + s1% * ((0 - g%(n%)) / t1%)
OUT &H3C9, B%(n%) + s1% * ((0 - B%(n%)) / t1%)
NEXT n%


nofadeout:


xs = xs + vxs: IF xs > 254 OR xs < 65 THEN vxs = -vxs
vys = vys + fs
ys = ys + vys
IF ys > yys% THEN ys = ys - vys: vys = -vys * .8

xs% = xs: ys% = ys
sy% = ys% - 63
sx% = xs% - 63
IF sy% < 0 AND sy% > -128 THEN m% = sy% * (-128) - 1

yw1% = -1 + sy%: yw2% = 128 + sy%
xw1% = -1 + sx%: xw2% = 128 + sx%

FOR y% = 0 TO 199
DEF SEG = &HA000 + y% * 20


IF y% > yw1% AND y% < yw2% THEN GOTO 111

FOR x% = 0 TO 319
c% = fsin2%(x%) + fsin3%(y% + l%) + fsin2%(x% + y%) + fsin2%(fsin3%(x% + l%) - fsin2%(x% - y% - k%))
POKE x%, mod256128%(c%)
NEXT x%

GOTO 1121

111
FOR x% = 0 TO 319
IF x% > xw1% AND x% < xw2% THEN m% = m% + 1: yn% = sp%(m%) \ 128: xn% = sp%(m%) - yn% * 128 + sx%: yn% = yn% + sy%: spp% = 128 ELSE xn% = x%: yn% = y%
IF xn% = x% AND yn% = y% THEN spp% = 0

c% = fsin2%(xn%) + fsin3%(yn% + l%) + fsin2%(xn% + yn%) + fsin2%(fsin3%(xn% + l%) - fsin2%(xn% - yn% - k%))
POKE x%, mod256128%(c%) + spp%
NEXT x%

1121

NEXT y%

'OUT &H3C8, 0
'OUT &H3C9, 0
'OUT &H3C9, 0
'OUT &H3C9, 0

WAIT &H3DA, 8: WAIT &H3DA, 8, 8
IF xit% = 0 THEN keyaction
IF xit% = 1 THEN GOTO gout

'OUT &H3C8, 0
'OUT &H3C9, 63
'OUT &H3C9, 0
'OUT &H3C9, 0

LOOP

gout:



END SUB

SUB sucking

SHARED xit%

SCREEN 13
COLOR 15

LOCATE 1, 1: PRINT "Still Sucking?"


FOR y% = 7 TO 0 STEP -1
FOR x% = 14 * 8 - 1 TO 0 STEP -1

c% = POINT(x%, y%) * (y% + 1) * SIN((x% + y%) / 45)
LINE (x% * 2.8, y% * 16 + 32)-((x% + 1) * 2.8, (y% + 1) * 16 + 32), c%, BF

NEXT x%
NEXT y%

END SUB

SUB translate3d

SHARED ndts%, obj%

IF obj% = 1 THEN zpr% = 1
IF obj% = 2 OR obj% = 3 THEN zpr% = 4
IF obj% = 4 THEN zpr% = 16
IF obj% > 4 THEN zpr% = 8

FOR i% = 0 TO ndts% - 1

xs%(i%, 1) = xs%(i%, 0)
ys%(i%, 1) = ys%(i%, 0)

IF z(i%) <= zpr% THEN GOTO 10

xs%(i%, 0) = (x(i%) * 256) / z(i%)
ys%(i%, 0) = (y(i%) * 256) / z(i%)

10

NEXT i%

END SUB

SUB zoomdistort

SHARED xit%

WHILE INKEY$ <> "": WEND

CLS



FOR i% = -640 TO 518
fsin2%(i%) = SIN(i% / 16) * 31
NEXT i%

FOR i% = -640 TO 715
fsin3%(i%) = SIN(i% / 63) * 75
NEXT i%

FOR i% = -48 TO 539
fsin1%(i%) = SIN(i% / 35) * 24
NEXT i%

FOR i% = -319 TO 602
fsin4%(i%) = SIN(i% / 45) * 24
NEXT i%

'$DYNAMIC
DIM dr%(-160 TO 160, -48 TO 48)
'$STATIC

FOR ii% = -48 TO 48
FOR i% = -160 TO 160
dva = ii% / 64 + 2
IF dva <> 0 THEN dr%(i%, ii%) = i% / dva ELSE dr%(i%, ii%) = i%
NEXT i%
NEXT ii%


' ------------ Load Quickbasic inside --------------

a$ = "qbinside.spr"
c$ = " "
open ".\samples\pete\optimus\"+a$ FOR BINARY AS #1

OUT &H3C8, 128
FOR i% = 0 TO 383
GET #1, , c$: OUT &H3C9, ASC(c$)
NEXT i%


xg% = 100
yg% = 100

i% = 0
FOR y% = 1 TO yg%
FOR x% = 1 TO xg%
GET #1, , c$: sp%(i%) = ASC(c$)
i% = i% + 1
NEXT x%
NEXT y%
CLOSE #1



setpal 0, 31, 0, 0, 0, 0, 31, 63
setpal 32, 63, 0, 31, 63, 31, 0, 63
setpal 64, 95, 31, 0, 63, 0, 63, 0
setpal 96, 127, 0, 63, 0, 0, 0, 0



FOR l% = 15 TO 305
LINE (14, 6)-(l%, 7), 27, B
LINE (13, 5)-(l% + 1, 8), 31, B
LINE (12, 4)-(l% + 2, 9), 27, B
WAIT &H3DA, 8: WAIT &H3DA, 8, 8
IF xit% = 0 THEN keyaction
IF xit% = 1 THEN GOTO gout2
NEXT l%

FOR n% = 7 TO 193
IF n% > 7 AND n% < 194 THEN LINE (15, n% - 1)-(304, n% - 1), 0, B
LINE (14, 6)-(305, n%), 27, B
LINE (13, 5)-(306, n% + 1), 31, B
LINE (12, 4)-(307, n% + 2), 27, B
WAIT &H3DA, 8: WAIT &H3DA, 8, 8
IF xit% = 0 THEN keyaction
IF xit% = 1 THEN GOTO gout2
NEXT n%


' ----------- Quickbasic Inside ------------


k0% = k%
l0% = l%
k% = 0
l% = 0

kxy0% = 0

fps% = 0
DO
fps% = fps% + 1
IF fps% > 1400 AND kxy0% > -100 THEN kxy0% = kxy0% - 100 ELSE IF fps% <= 1000 AND kxy0% < 10000 THEN kxy0% = kxy0% + 100
IF kxy0% = -100 THEN GOTO gout2

k% = k% + 1: IF k% = 220 THEN k% = 0
l% = l% + 1: IF l% = 283 THEN l% = 0

k0% = k0% + 1: IF k0% = 101 THEN k0% = 0
l0% = l0% + 1: IF l0% = 396 THEN l0% = 0


xp% = SIN(k% / 35) * 48
yp% = SIN(l% / 45) * 64


ypp% = 160
FOR y% = 8 TO 191
DEF SEG = &HA000 + ypp%
ypp% = ypp% + 20
sx% = fsin4%(y% + l%) + fsin1%(fsin1%(y%) + fsin4%(y% + l%))

FOR x% = 16 TO 303

sy% = fsin1%(x% + k%) + fsin4%(y% - x%)

kxy% = dt100%(dr%(y% - 100, sy%) + yp%) + dt%(dr%(x% - 160, sx%) + xp%)
IF kxy% > kxy0% THEN c% = 0 ELSE IF sp%(kxy%) = 129 THEN c% = mod256128%(fsin3%(x%) + fsin2%(x% + k0%) + fsin2%(y%)) ELSE c% = sp%(kxy%)

POKE x%, c%

NEXT x%
NEXT y%

'OUT &H3C8, 0
'OUT &H3C9, 0
'OUT &H3C9, 0
'OUT &H3C9, 0

WAIT &H3DA, 8: WAIT &H3DA, 8, 8
IF xit% = 0 THEN keyaction
IF xit% = 1 THEN GOTO gout2

'OUT &H3C8, 0
'OUT &H3C9, 63
'OUT &H3C9, 0
'OUT &H3C9, 0

LOOP

gout2:

END SUB

