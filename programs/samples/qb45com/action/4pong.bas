SCREEN 12
RANDOMIZE TIMER
GOSUB title
WIDTH 80, 60
DIM tx(2 TO 16) AS INTEGER
DIM ty(2 TO 16) AS INTEGER
DIM itemx(1, 15) AS INTEGER
DIM itemy(1, 15) AS INTEGER
DIM demoitemx(1, 15) AS INTEGER
DIM demoitemy(1, 15) AS INTEGER
DIM symbolx(1 TO 30) AS INTEGER
DIM symboly(1 TO 30) AS INTEGER
DIM symbolt(1 TO 30) AS INTEGER
DIM symbolc(1 TO 30) AS INTEGER
DIM stime(1 TO 30) AS INTEGER
FOR i = 1 TO 15
demoitemx(1, i) = INT(RND * 74) + 14
demoitemy(1, i) = INT(RND * 74) + 14
NEXT i
speed& = 1
pad& = 1
scoret& = 4
max& = 100
dir& = 1
it1& = 1
it2& = 1
it3& = 1
it4& = 1
it5& = 1
it6& = 1
it7& = 1
it8& = 1
ballx& = 50
bally& = 10
ballxs& = INT(RND * 2) + 1
ballys& = INT(RND * 2) + 1
pad1& = 50
pad2& = 50
pad3& = 50
pad4& = 50
p1& = 1
p2& = 1
p3& = 1
p4& = 1
co& = 1
items& = 1
it& = 15
GOTO start
new:
x& = 240
y& = 240
xs& = 0
ys& = 0
a& = speed&
IF p1& = 0 THEN ly1& = 57 ELSE ly1& = 1
IF p2& = 0 THEN lx1& = 57 ELSE lx1& = 1
IF p3& = 0 THEN ly2& = 423 ELSE ly2& = 479
IF p4& = 0 THEN lx2& = 423 ELSE lx2& = 479
started& = 1
IF items& = 0 THEN it& = 0
IF p1& = 7 THEN p1& = INT(RND * 5) + 2
IF p2& = 7 THEN p2& = INT(RND * 5) + 2
IF p3& = 7 THEN p3& = INT(RND * 5) + 2
IF p4& = 7 THEN p4& = INT(RND * 5) + 2
p1hyper& = 0
p2hyper& = 0
p3hyper& = 0
p4hyper& = 0
p1descore& = 0
p2descore& = 0
p3descore& = 0
p4descore& = 0
IF scoret& = 3 OR scoret& = 6 THEN
        p1descore& = max&
        p2descore& = max&
        p3descore& = max&
        p4descore& = max&
END IF
IF p1& = 0 THEN p1descore& = -2000000000
IF p2& = 0 THEN p2descore& = -2000000000
IF p3& = 0 THEN p3descore& = -2000000000
IF p4& = 0 THEN p4descore& = -2000000000
p1score& = p1descore&
p2score& = p2descore&
p3score& = p3descore&
p4score& = p4descore&
p1des& = 240
p2des& = 240
p3des& = 240
p4des& = 240
p1pad& = 240
p2pad& = 240
p3pad& = 240
p4pad& = 240
p1size& = 0
p2size& = 0
p3size& = 0
p4size& = 0
p1desize& = 25
p2desize& = 25
p3desize& = 25
p4desize& = 25
p1dir& = 0
p2dir& = 0
p3dir& = 0
p4dir& = 0
p1scores& = 0
p2scores& = 0
p3scores& = 0
p4scores& = 0
p1speed& = pad& * 7
p2speed& = pad& * 7
p3speed& = pad& * 7
p4speed& = pad& * 7
center& = 0
serve& = 5
colo& = INT(RND * 5) + 1
FOR i = 1 TO it&
itemx(1, i) = INT(RND * 340) + 70
itemy(1, i) = INT(RND * 340) + 70
NEXT i
retrylast:
lasthit& = INT(RND * 4) + 1
IF lasthit& = 1 AND p1& = 0 THEN GOTO retrylast
IF lasthit& = 2 AND p2& = 0 THEN GOTO retrylast
IF lasthit& = 3 AND p3& = 0 THEN GOTO retrylast
IF lasthit& = 4 AND p4& = 0 THEN GOTO retrylast
finished& = 0
subtract& = 0
startedd& = TIMER
FOR i = 1 TO 30
stime(i) = 0
NEXT i
restart:
CLS
IF p1& > 1 THEN p1com& = 1 ELSE p1com& = 0
IF p1& > 1 THEN p1ac& = (6 - p1&) * 20
IF p1& > 1 THEN p1ai& = p1& * 80
IF p2& > 1 THEN p2com& = 1 ELSE p2com& = 0
IF p2& > 1 THEN p2ac& = (6 - p2&) * 20
IF p2& > 1 THEN p2ai& = p2& * 80
IF p3& > 1 THEN p3com& = 1 ELSE p3com& = 0
IF p3& > 1 THEN p3ac& = (6 - p3&) * 20
IF p3& > 1 THEN p3ai& = p3& * 80
IF p4& > 1 THEN p4com& = 1 ELSE p4com& = 0
IF p4& > 1 THEN p4ac& = (6 - p4&) * 20
IF p4& > 1 THEN p4ai& = p4& * 80
GOSUB draww
scombo& = 0
CLS
VIEW SCREEN (lx1&, ly1&)-(lx2&, ly2&)
DO

'IF delay& < 0 THEN delay& = 0
'FOR i = 1 TO delay&
'NEXT i
_DELAY 0.03 + DELAY& / 10000


finished& = TIMER
IF max& > 0 AND (scoret& = 3 OR scoret& = 6) THEN
        IF p1& > 0 THEN players& = players& + 1
        IF p2& > 0 THEN players& = players& + 1
        IF p3& > 0 THEN players& = players& + 1
        IF p4& > 0 THEN players& = players& + 1
        IF p1descore& < 1 AND p1& > 0 THEN
                p1& = 0
                p1descore& = -players&
                ly1& = 57
                serve& = 5
                GOSUB centerserve
                VIEW
                CLS
                GOSUB draww
        ELSEIF p2descore& < 1 AND p2& > 0 THEN
                p2& = 0
                p2descore& = -players&
                lx1& = 57
                serve& = 5
                GOSUB centerserve
                VIEW
                CLS
                GOSUB draww
        ELSEIF p3descore& < 1 AND p3& > 0 THEN
                p3& = 0
                p3descore& = -players&
                ly2& = 423
                serve& = 5
                GOSUB centerserve
                VIEW
                CLS
                GOSUB draww
        ELSEIF p4descore& < 1 AND p4& > 0 THEN
                p4& = 0
                p4descore& = -players&
                lx2& = 423
                serve& = 5
                GOSUB centerserve
                VIEW
                CLS
                GOSUB draww
        END IF
        IF players& = 1 THEN GOTO theend
        players& = 0
ELSE
        IF (p1descore& > max& - 1 OR p2descore& > max& - 1 OR p3descore& > max& - 1 OR p4descore& > max& - 1) AND max& > 0 THEN GOTO theend
END IF
IF p1score& <> p1descore& AND p1& > 0 THEN
        FOR i = 1 TO CLNG(ABS(p1descore& - p1score&) / 10) + 1
        IF p1descore& - p1score& > 0 THEN p1score& = p1score& + 1
        IF p1descore& - p1score& < 0 THEN p1score& = p1score& - 1
        NEXT i
        SOUND 1000, .1
        GOSUB draww
ELSEIF p2score& <> p2descore& AND p2& > 0 THEN
        FOR i = 1 TO CLNG(ABS(p2descore& - p2score&) / 10) + 1
        IF p2descore& - p2score& > 0 THEN p2score& = p2score& + 1
        IF p2descore& - p2score& < 0 THEN p2score& = p2score& - 1
        NEXT i
        SOUND 1000, .1
        GOSUB draww
ELSEIF p3score& <> p3descore& AND p3& > 0 THEN
        FOR i = 1 TO CLNG(ABS(p3descore& - p3score&) / 10) + 1
        IF p3descore& - p3score& > 0 THEN p3score& = p3score& + 1
        IF p3descore& - p3score& < 0 THEN p3score& = p3score& - 1
        NEXT i
        SOUND 1000, .1
        GOSUB draww
ELSEIF p4score& <> p4descore& AND p4& > 0 THEN
        FOR i = 1 TO CLNG(ABS(p4descore& - p4score&) / 10) + 1
        IF p4descore& - p4score& > 0 THEN p4score& = p4score& + 1
        IF p4descore& - p4score& < 0 THEN p4score& = p4score& - 1
        NEXT i
        SOUND 1000, .1
        GOSUB draww
END IF

IF p1size& > p1desize& THEN p1size& = p1size& - 1
IF p1size& < p1desize& THEN p1size& = p1size& + 1
IF p2size& > p2desize& THEN p2size& = p2size& - 1
IF p2size& < p2desize& THEN p2size& = p2size& + 1
IF p3size& > p3desize& THEN p3size& = p3size& - 1
IF p3size& < p3desize& THEN p3size& = p3size& + 1
IF p4size& > p4desize& THEN p4size& = p4size& - 1
IF p4size& < p4desize& THEN p4size& = p4size& + 1

IF scombo& > -1 THEN
        IF scombo& > 0 THEN COLOR 3 ELSE COLOR 0
        LOCATE 30, 30: PRINT combo&
        scombo& = scombo& - 1
END IF

IF ABS(xs&) < 8 AND ABS(ys&) < 8 AND serve& = 0 THEN
        IF ABS(xs&) > ABS(ys&) THEN
                IF xs& > 0 THEN
                        IF ys& > 0 THEN ys& = ys& + (8 / xs&)
                        IF ys& < 0 THEN ys& = ys& - xs&
                        xs& = 8
                ELSEIF xs& < 0 THEN
                        IF ys& > 0 THEN ys& = ys& + (8 / ABS(xs&))
                        IF ys& < 0 THEN ys& = ys& - (8 / ABS(xs&))
                        xs& = -8
                END IF
        ELSEIF ABS(xs&) < ABS(ys&) THEN
                IF ys& > 0 THEN
                        IF xs& > 0 THEN xs& = xs& + (8 / ys&)
                        IF xs& < 0 THEN xs& = xs& - (8 / ys&)
                        ys& = 8
                ELSEIF ys& < 0 THEN
                        IF xs& > 0 THEN xs& = xs& + (8 / ABS(ys&))
                        IF xs& < 0 THEN xs& = xs& - (8 / ABS(ys&))
                        ys& = -8
                END IF
        ELSEIF ABS(xs&) = ABS(ys&) AND xs& <> 0 THEN
                IF xs& > 0 THEN xs& = 8
                IF xs& < 0 THEN xs& = -8
                IF ys& > 0 THEN ys& = 8
                IF ys& < 0 THEN ys& = -8
        END IF
END IF

FOR ba = 1 TO a&

IF x& < 65 AND xs& = 0 THEN xs& = -1
IF x& > 415 AND xs& = 0 THEN xs& = 1
IF y& < 65 AND ys& = 0 THEN ys& = -1
IF y& > 415 AND ys& = 0 THEN ys& = 1

IF serve& = 1 THEN
        x& = p1pad&
        y& = 13
ELSEIF serve& = 2 THEN
        x& = 13
        y& = p2pad&
ELSEIF serve& = 3 THEN
        x& = p3pad&
        y& = 467
ELSEIF serve& = 4 THEN
        x& = 467
        y& = p4pad&
END IF

IF serve& > 0 THEN xs& = 0
IF serve& > 0 THEN ys& = 0

x& = x& + xs&
y& = y& + ys&

IF x& < 60 AND y& < 60 AND p1& > 0 AND p2& > 0 THEN
        FOR i = 1 TO 60
                IF (x& - 3) < i AND y& - 3 < (60 - i) THEN
                        SWAP xs&, ys&
                        xs& = -xs&
                        ys& = -ys&
                        IF ABS(xs&) = ABS(ys&) THEN xs& = xs& + 1
                        x& = i + 3
                        y& = 63 - i
                        SOUND 750, .1
                END IF
        NEXT i
END IF
IF x& < 60 AND y& > 420 AND p2& > 0 AND p3& > 0 THEN
        FOR i = 1 TO 60
                IF (x& - 3) < i AND (y& + 3) > (420 + i) THEN
                        SWAP xs&, ys&
                        IF ABS(xs&) = ABS(ys&) THEN xs& = xs& + 1
                        x& = i + 3
                        y& = 417 + i
                        SOUND 750, .1
                END IF
        NEXT i
END IF
IF x& > 420 AND y& < 60 AND p4& > 0 AND p1& > 0 THEN
        FOR i = 1 TO 60
                IF (x& + 3) > (480 - i) AND (y& - 3) < (60 - i) THEN
                        SWAP xs&, ys&
                        IF ABS(xs&) = ABS(ys&) THEN xs& = xs& + 1
                        x& = 477 - i
                        y& = 63 - i
                        SOUND 750, .1
                END IF
        NEXT i
END IF
IF x& > 420 AND y& > 420 AND p3& > 0 AND p4& > 0 THEN
        FOR i = 1 TO 60
                IF (x& + 3) > (480 - i) AND (y& + 3) > (420 + i) THEN
                        SWAP xs&, ys&
                        xs& = -xs&
                        ys& = -ys&
                        IF ABS(xs&) = ABS(ys&) THEN xs& = xs& + 1
                        x& = 477 - i
                        y& = 417 + i
                        SOUND 750, .1
                END IF
        NEXT i
END IF
IF countdown& > 0 THEN countdown& = countdown& - 1
FOR i = 1 TO it&
IF it1& = 0 AND it2& = 0 AND it3& = 0 AND it4& = 0 AND it5& = 0 AND it6& = 0 AND it7& = 0 AND it8& = 0 THEN EXIT FOR
IF x& < itemx(1, i) + 9 AND x& > itemx(1, i) - 9 AND y& < itemy(1, i) + 9 AND y& > itemy(1, i) - 9 THEN
        IF hit& = i AND countdown& > 0 THEN GOTO endder
        hit& = i
        countdown& = 20
        GOSUB item
END IF
endder:
NEXT i
IF y& < 60 AND p1& = 0 THEN
        ys& = -ys&
        IF ys& = 0 THEN ys& = 1
        y& = 60
        SOUND 500, .1
ELSEIF x& < 60 AND p2& = 0 THEN
        xs& = -xs&
        IF xs& = 0 THEN xs& = 1
        x& = 60
        SOUND 500, .1
ELSEIF y& > 420 AND p3& = 0 THEN
        ys& = -ys&
        IF ys& = 0 THEN ys& = -1
        y& = 420
        SOUND 500, .1
ELSEIF x& > 420 AND p4& = 0 THEN
        xs& = -xs&
        IF xs& = 0 THEN xs& = -1
        x& = 420
        SOUND 500, .1
END IF
IF y& < 8 AND ((x& > (p1pad& - p1size&) AND x& < (p1pad& + p1size&)) OR p1hyper& > 0) THEN
        ys& = INT(RND * 8) + 1
        IF xs& = 0 THEN xs& = INT(RND * 17) - 8
        lasthit& = 1
        IF p1hyper& = 1 THEN p1hyper& = 0
        y& = 8
        GOSUB universal
ELSEIF x& < 8 AND ((y& > (p2pad& - p2size&) AND y& < (p2pad& + p2size&)) OR p2hyper& > 0) THEN
        xs& = INT(RND * 8) + 1
        IF ys& = 0 THEN ys& = INT(RND * 17) - 8
        lasthit& = 2
        IF p2hyper& = 1 THEN p2hyper& = 0
        x& = 8
        GOSUB universal
ELSEIF y& > 472 AND ((x& > (p3pad& - p3size&) AND x& < (p3pad& + p3size&)) OR p3hyper& > 0) THEN
        ys& = -(INT(RND * 8) + 1)
        IF xs& = 0 THEN xs& = INT(RND * 17) - 8
        lasthit& = 3
        IF p3hyper& = 1 THEN p3hyper& = 0
        y& = 472
        GOSUB universal
ELSEIF x& > 472 AND ((y& > (p4pad& - p4size&) AND y& < (p4pad& + p4size&)) OR p4hyper& > 0) THEN
        xs& = -(INT(RND * 8) + 1)
        IF ys& = 0 THEN ys& = INT(RND * 17) - 8
        lasthit& = 4
        IF p4hyper& = 1 THEN p4hyper& = 0
        x& = 472
        GOSUB universal
END IF
IF y& < 0 AND p1& > 0 THEN GOSUB score1
IF x& < 0 AND p2& > 0 THEN GOSUB score2
IF y& > 480 AND p3& > 0 THEN GOSUB score3
IF x& > 480 AND p4& > 0 THEN GOSUB score4
NEXT ba

PSET (tx(16), ty(16)), 0
PSET (tx(15), ty(15)), 8
PSET (tx(14), ty(14)), 8
PSET (tx(13), ty(13)), 7
PSET (tx(12), ty(12)), 7
PSET (tx(11), ty(11)), 4
CIRCLE (tx(10), ty(10)), 1, 0
PSET (tx(10), ty(10)), 4
CIRCLE (tx(9), ty(9)), 1, 4
CIRCLE (tx(8), ty(8)), 1, 4
CIRCLE (tx(7), ty(7)), 1, 4
CIRCLE (tx(6), ty(6)), 1, 12
CIRCLE (tx(5), ty(5)), 1, 12
CIRCLE (tx(4), ty(4)), 2, 0
CIRCLE (tx(4), ty(4)), 1, 12
CIRCLE (tx(3), ty(3)), 2, 4
CIRCLE (tx(3), ty(3)), 1, 14
CIRCLE (tx(2), ty(2)), 3, 0
CIRCLE (tx(2), ty(2)), 2, 4
CIRCLE (tx(2), ty(2)), 1, 14
PSET (tx(2) - 1, ty(2) - 1), 0
PSET (tx(2) + 1, ty(2) - 1), 0
PSET (tx(2) - 1, ty(2) + 1), 0
PSET (tx(2) + 1, ty(2) + 1), 0
LINE (x& - 1, y& - 1)-(x& + 1, y& + 1), 14, BF
CIRCLE (x&, y&), 2, 12
CIRCLE (x&, y&), 3, 4

FOR i = 16 TO 3 STEP -1
tx(i) = tx(i - 1)
ty(i) = ty(i - 1)
NEXT i
tx(2) = x&
ty(2) = y&

IF p1& > 0 AND p1dir& = 2 THEN p1pad& = p1pad& - p1speed&
IF p1& > 0 AND p1dir& = 1 THEN p1pad& = p1pad& + p1speed&
IF p2& > 0 AND p2dir& = 2 THEN p2pad& = p2pad& - p2speed&
IF p2& > 0 AND p2dir& = 1 THEN p2pad& = p2pad& + p2speed&
IF p3& > 0 AND p3dir& = 2 THEN p3pad& = p3pad& - p3speed&
IF p3& > 0 AND p3dir& = 1 THEN p3pad& = p3pad& + p3speed&
IF p4& > 0 AND p4dir& = 2 THEN p4pad& = p4pad& - p4speed&
IF p4& > 0 AND p4dir& = 1 THEN p4pad& = p4pad& + p4speed&

IF p1hyper& > 0 THEN
        IF serve& = 0 AND p1hyper& > 1 THEN p1hyper& = p1hyper& - 1
        IF ys& < 0 THEN p1pad& = x&
END IF
IF p2hyper& > 0 THEN
        IF serve& = 0 AND p2hyper& > 1 THEN p2hyper& = p2hyper& - 1
        IF xs& < 0 THEN p2pad& = y&
END IF
IF p3hyper& > 0 THEN
        IF serve& = 0 AND p3hyper& > 1 THEN p3hyper& = p3hyper& - 1
        IF ys& > 0 THEN p3pad& = x&
END IF
IF p4hyper& > 0 THEN
        IF serve& = 0 AND p4hyper& > 1 THEN p4hyper& = p4hyper& - 1
        IF xs& > 0 THEN p4pad& = y&
END IF

IF (p1pad& - p1size&) < 60 THEN p1pad& = (60 + p1size&)
IF (p1pad& + p1size&) > 420 THEN p1pad& = (420 - p1size&)
IF (p2pad& - p2size&) < 60 THEN p2pad& = (60 + p2size&)
IF (p2pad& + p2size&) > 420 THEN p2pad& = (420 - p2size&)
IF (p3pad& - p3size&) < 60 THEN p3pad& = (60 + p3size&)
IF (p3pad& + p3size&) > 420 THEN p3pad& = (420 - p3size&)
IF (p4pad& - p4size&) < 60 THEN p4pad& = (60 + p4size&)
IF (p4pad& + p4size&) > 420 THEN p4pad& = (420 - p4size&)

FOR i = 1 TO it&
IF it1& = 0 AND it2& = 0 AND it3& = 0 AND it4& = 0 AND it5& = 0 AND it6& = 0 AND it7& = 0 AND it8& = 0 THEN EXIT FOR
IF items& = 0 THEN EXIT FOR
LINE (itemx(1, i) - 2, itemy(1, i) - 2)-(itemx(1, i) + 2, itemy(1, i) + 2), colo&, B
LINE (itemx(1, i) - 1, itemy(1, i) - 1)-(itemx(1, i) + 1, itemy(1, i) + 1), colo& + 8, B
PSET (itemx(1, i), itemy(1, i)), 15
NEXT i
FOR i = 1 TO 30
IF stime(i) > 0 THEN
        IF symbolt(i) = 3 OR symbolt(i) = 4 OR symbolt(i) = 5 OR symbolt(i) = 8 OR symbolt(i) = 9 OR symbolt(i) = 12 OR symbolt(i) = 13 THEN symbolc(i) = 0
        PSET (symbolx(i), symboly(i)), symbolc(i)
        stime(i) = stime(i) - 1
        IF symbolt(i) = 1 THEN DRAW "M-2,0 R4 U L4 BL2 C4 D BL2 U Bl2 D BR12 NE NR3 NF"
        IF symbolt(i) = 2 THEN DRAW "M-2,0 R4 U L4 BL2 C2 D BL2 U Bl2 D BR15 NH NL3 NG"
        IF symbolt(i) = 3 THEN DRAW "C4 E F C14 L1 C4 BD E BR2 NR3 NE NF BL5 L BR C0 U BL2 C8 G BE C0 L"
        IF symbolt(i) = 4 THEN DRAW "C4 E F C14 L1 C4 BD E C2 BR5 NL3 NH NG C4 BL8 L BR C0 U BL2 C8 G BE C0 L"
        IF symbolt(i) = 5 THEN DRAW "BD2 C8 F BU C0 L1 BM-2,-1 C12 R BG C0 U2 C4 U1 BD C0 L BU3 BR2 C14 R BR C4 G H E"
        IF symbolt(i) = 8 THEN DRAW "C3 BL H2 BD2 E2 BM+3,-1 E R F D G3 R3"
        IF symbolt(i) = 9 THEN DRAW "BM-1,-4 C14 R4 D L4 G R4 D L4 G R7 G L3 D R2 G L2 D R G L D"
        IF symbolt(i) = 10 THEN DRAW "BL2 R4 U1 L4 BM-5,1 C2 NR3 NF NE BR14 NL3 NG NH"
        IF symbolt(i) = 11 THEN DRAW "BL2 R4 U1 L4 BM-2,1 C4 NL3 NG NH BR8 NR3 NF NE"
        IF symbolt(i) = 12 THEN DRAW "C3 BM-3,-1 R2 H D2 BR4 F R E U H L2 U2 R3"
        IF symbolt(i) = 13 THEN DRAW "C3 BM-3,-1 R2 H D2 BR4 BU4 R F D G L D3 BE C0 L"
        IF stime(i) < 5 THEN LINE (symbolx(i) - 10, symboly(i) - 10)-(symbolx(i) + 10, symboly(i) + 10), 0, BF
END IF
NEXT i

IF lasthit& = 1 THEN c& = 1
IF lasthit& = 2 THEN c& = 4
IF lasthit& = 3 THEN c& = 2
IF lasthit& = 4 THEN c& = 6

LINE (lx1&, ly1&)-(lx2&, ly2&), c&, B
LINE (lx1& + 1, ly1& + 1)-(lx2& - 1, ly2& - 1), c& + 8, B

IF p1& = 0 OR p2& = 0 THEN GOTO skip1:
LINE (3, 3)-(3, 60), 1
LINE (3, 3)-(60, 3), 1
LINE (60, 3)-(3, 60), 1
LINE (4, 4)-(4, 59), 1
LINE (4, 4)-(59, 4), 1
LINE (59, 3)-(3, 59), 1
skip1:
IF p4& = 0 OR p1& = 0 THEN GOTO skip2:
LINE (477, 3)-(477, 60), 14
LINE (477, 3)-(420, 3), 14
LINE (420, 3)-(477, 60), 14
LINE (476, 4)-(476, 59), 14
LINE (476, 4)-(421, 4), 14
LINE (421, 3)-(477, 59), 14
skip2:
IF p2& = 0 OR p3& = 0 THEN GOTO skip3:
LINE (3, 477)-(3, 420), 4
LINE (3, 477)-(60, 477), 4
LINE (60, 477)-(3, 420), 4
LINE (4, 476)-(4, 421), 4
LINE (4, 476)-(59, 476), 4
LINE (59, 477)-(3, 421), 4
skip3:
IF p3& = 0 OR p4& = 0 THEN GOTO skip4:
LINE (477, 477)-(477, 420), 2
LINE (477, 477)-(420, 477), 2
LINE (420, 477)-(477, 420), 2
LINE (476, 476)-(476, 421), 2
LINE (476, 476)-(421, 476), 2
LINE (421, 477)-(477, 421), 2
skip4:

IF p1& > 0 THEN LINE (p1pad& - (p1size& - 1), 5)-(p1pad& + (p1size& - 1), 7), 1, BF
IF p1hyper& = 0 AND p1& > 0 THEN LINE (p1pad& - p1size&, 4)-(p1pad& + p1size&, 8), 1, B
IF p1& > 0 THEN LINE (p1pad& - (p1size& + 1), 3)-(61, 9), 0, BF
IF p1& > 0 THEN LINE (p1pad& + (p1size& + 1), 3)-(419, 9), 0, BF
IF p2& > 0 THEN LINE (5, p2pad& - (p2size& - 1))-(7, p2pad& + (p2size& - 1)), 4, BF
IF p2hyper& = 0 AND p2& > 0 THEN LINE (4, p2pad& - p2size&)-(8, p2pad& + p2size&), 4, B
IF p2& > 0 THEN LINE (3, p2pad& - (p2size& + 1))-(9, 61), 0, BF
IF p2& > 0 THEN LINE (3, p2pad& + (p2size& + 1))-(9, 419), 0, BF
IF p3& > 0 THEN LINE (p3pad& - (p3size& - 1), 475)-(p3pad& + (p3size& - 1), 473), 2, BF
IF p3hyper& = 0 AND p3& > 0 THEN LINE (p3pad& - p3size&, 476)-(p3pad& + p3size&, 472), 2, B
IF p3& > 0 THEN LINE (p3pad& - (p3size& + 1), 477)-(61, 471), 0, BF
IF p3& > 0 THEN LINE (p3pad& + (p3size& + 1), 477)-(419, 471), 0, BF
IF p4& > 0 THEN LINE (475, p4pad& - (p4size& - 1))-(473, p4pad& + (p4size& - 1)), 14, BF
IF p4hyper& = 0 AND p4& > 0 THEN LINE (476, p4pad& - p4size&)-(472, p4pad& + p4size&), 14, B
IF p4& > 0 THEN LINE (477, p4pad& - (p4size& + 1))-(471, 61), 0, BF
IF p4& > 0 THEN LINE (477, p4pad& + (p4size& + 1))-(471, 419), 0, BF
a$ = INKEY$
IF p1com& = 1 THEN GOTO player1
IF a$ = "v" THEN p1dir& = 2
IF a$ = "b" THEN p1dir& = 0
IF a$ = "n" THEN p1dir& = 1
IF a$ = "g" AND serve& = 1 THEN GOSUB serve
p2:
IF p2com& = 1 THEN GOTO player2
IF a$ = "q" THEN p2dir& = 2
IF a$ = "a" THEN p2dir& = 0
IF a$ = "z" THEN p2dir& = 1
IF a$ = "s" AND serve& = 2 THEN GOSUB serve
p3:
IF p3com& = 1 THEN GOTO player3
IF a$ = CHR$(0) + "K" THEN p3dir& = 2
IF a$ = CHR$(0) + "P" THEN p3dir& = 0
IF a$ = CHR$(0) + "M" THEN p3dir& = 1
IF a$ = CHR$(0) + "H" AND serve& = 3 THEN GOSUB serve
p4:
IF p4com& = 1 THEN GOTO player4
IF a$ = "]" THEN p4dir& = 2
IF a$ = "'" THEN p4dir& = 0
IF a$ = "/" THEN p4dir& = 1
IF a$ = ";" AND serve& = 4 THEN GOSUB serve
finish:
IF a$ = "=" THEN delay& = delay& - 100
IF a$ = "-" THEN delay& = delay& + 100
IF a$ = CHR$(27) THEN
        subtract& = TIMER
        GOTO start
ELSEIF a$ = "p" THEN
        subtract& = TIMER
        COLOR 3
        LOCATE 29, 29
        PRINT "PAUSED"
        SLEEP
        DO
        c$ = INKEY$
        LOOP UNTIL c$ <> "~"
        CLS
        subtract& = TIMER - subtract&
        startedd& = startedd& + subtract&
END IF
IF serve& = 5 THEN GOSUB centerserve
LOOP
universal:
IF p1& > 1 THEN p1ac2& = INT(RND * (p1ac& * 2)) - p1ac&
IF p2& > 1 THEN p2ac2& = INT(RND * (p2ac& * 2)) - p2ac&
IF p3& > 1 THEN p3ac2& = INT(RND * (p3ac& * 2)) - p3ac&
IF p4& > 1 THEN p4ac2& = INT(RND * (p4ac& * 2)) - p4ac&
combo& = combo& + 1
scombo& = 50
p1serve& = 0
p2serve& = 0
p3serve& = 0
p4serve& = 0
SOUND 700, .1
RETURN

serve:
IF serve& = 1 THEN
        IF p1dir& = 1 THEN
                xs& = 8
                ys& = 8
        ELSEIF p1dir& = 2 THEN
                xs& = -8
                ys& = 8
        END IF
        IF p1dir& = 0 THEN ys& = 8
        p1serve& = p1serve& + 1
ELSEIF serve& = 2 THEN
        IF p2dir& = 1 THEN
                xs& = 8
                ys& = 8
        ELSEIF p2dir& = 2 THEN
                xs& = 8
                ys& = -8
        END IF
        IF p2dir& = 0 THEN xs& = 8
        p2serve& = p2serve& + 1
ELSEIF serve& = 3 THEN
        IF p3dir& = 1 THEN
                xs& = 8
                ys& = -8
        ELSEIF p3dir& = 2 THEN
                xs& = -8
                ys& = -8
        END IF
        IF p3dir& = 0 THEN ys& = -8
        p3serve& = p3serve& + 1
ELSEIF serve& = 4 THEN
        IF p4dir& = 1 THEN
                xs& = -8
                ys& = 8
        ELSEIF p4dir& = 2 THEN
                xs& = -8
                ys& = -8
        END IF
        IF p4dir& = 0 THEN xs& = -8
        p4serve& = p4serve& + 1
END IF
serve& = 0
scombo& = 50
RETURN

centerserve:
x& = 240
y& = 240
xs& = 0
ys& = 0
center& = center& + 1
IF center& = 25 THEN
        scombo& = 50
        combo& = 5
ELSEIF center& = 50 THEN
        scombo& = 50
        combo& = 4
ELSEIF center& = 75 THEN
        scombo& = 50
        combo& = 3
ELSEIF center& = 100 THEN
        scombo& = 50
        combo& = 2
ELSEIF center& = 125 THEN
        scombo& = 50
        combo& = 1
ELSEIF center& = 150 THEN
retry:
        xs& = INT(RND * 17) - 8
        ys& = INT(RND * 17) - 8
        IF xs& = 0 AND ys& = 0 THEN GOTO retry
        IF xs& = 0 AND p1& = 0 AND p3& = 0 THEN GOTO retry
        IF ys& = 0 AND p2& = 0 AND p4& = 0 THEN GOTO retry
        DO
        lasthit& = INT(RND * 4) + 1
        IF lasthit& = 1 AND p1& > 0 THEN EXIT DO
        IF lasthit& = 2 AND p2& > 0 THEN EXIT DO
        IF last7hit& = 3 AND p3& > 0 THEN EXIT DO
        IF lasthit& = 4 AND p4& > 0 THEN EXIT DO
        LOOP
        serve& = 0
        center& = 0
END IF
RETURN

score1:
IF scoret& < 4 THEN combo& = 1
IF scoret& = 1 OR scoret& = 4 THEN
        IF lasthit& = 2 THEN p2descore& = p2descore& + combo&
        IF lasthit& = 3 THEN p3descore& = p3descore& + combo&
        IF lasthit& = 4 THEN p4descore& = p4descore& + combo&
        IF lasthit& = 1 THEN p1descore& = p1descore& - combo&
ELSEIF scoret& = 2 OR scoret& = 5 THEN
        p2descore& = p2descore& + combo&
        p3descore& = p3descore& + combo&
        p4descore& = p4descore& + combo&
ELSEIF scoret& = 3 OR scoret& = 6 THEN
        p1descore& = p1descore& - combo&
END IF
IF lasthit& = 2 THEN p2scores& = p2scores& + 1
IF lasthit& = 3 THEN p3scores& = p3scores& + 1
IF lasthit& = 4 THEN p4scores& = p4scores& + 1
IF lose& = 1 THEN
        p1desize& = 25
        p1speed& = 4 + pad& * 3
END IF
GOSUB score
RETURN

score2:
IF scoret& < 4 THEN combo& = 1
IF scoret& = 1 OR scoret& = 4 THEN
        IF lasthit& = 2 THEN p2descore& = p2descore& - combo&
        IF lasthit& = 3 THEN p3descore& = p3descore& + combo&
        IF lasthit& = 4 THEN p4descore& = p4descore& + combo&
        IF lasthit& = 1 THEN p1descore& = p1descore& + combo&
ELSEIF scoret& = 2 OR scoret& = 5 THEN
        p1descore& = p1descore& + combo&
        p3descore& = p3descore& + combo&
        p4descore& = p4descore& + combo&
ELSEIF scoret& = 3 OR scoret& = 6 THEN
        p2descore& = p2descore& - combo&
END IF
IF lasthit& = 1 THEN p1scores& = p1scores& + 1
IF lasthit& = 3 THEN p3scores& = p3scores& + 1
IF lasthit& = 4 THEN p4scores& = p4scores& + 1
IF lose& = 1 THEN
        p2desize& = 25
        p2speed& = 4 + pad& * 3
END IF
GOSUB score
RETURN

score3:
IF scoret& < 4 THEN combo& = 1
IF scoret& = 1 OR scoret& = 4 THEN
        IF lasthit& = 2 THEN p2descore& = p2descore& + combo&
        IF lasthit& = 3 THEN p3descore& = p3descore& - combo&
        IF lasthit& = 4 THEN p4descore& = p4descore& + combo&
        IF lasthit& = 1 THEN p1descore& = p1descore& + combo&
ELSEIF scoret& = 2 OR scoret& = 5 THEN
        p1descore& = p1descore& + combo&
        p2descore& = p2descore& + combo&
        p4descore& = p4descore& + combo&
ELSEIF scoret& = 3 OR scoret& = 6 THEN
        p3descore& = p3descore& - combo&
END IF
IF lasthit& = 1 THEN p1scores& = p1scores& + 1
IF lasthit& = 2 THEN p2scores& = p2scores& + 1
IF lasthit& = 4 THEN p4scores& = p4scores& + 1
IF lose& = 1 THEN
        p3desize& = 25
        p3speed& = 4 + pad& * 3
END IF
GOSUB score
RETURN

score4:
IF scoret& < 4 THEN combo& = 1
IF scoret& = 1 OR scoret& = 4 THEN
        IF lasthit& = 2 THEN p2descore& = p2descore& + combo&
        IF lasthit& = 3 THEN p3descore& = p3descore& + combo&
        IF lasthit& = 4 THEN p4descore& = p4descore& - combo&
        IF lasthit& = 1 THEN p1descore& = p1descore& + combo&
ELSEIF scoret& = 2 OR scoret& = 5 THEN
        p1descore& = p1descore& + combo&
        p2descore& = p2descore& + combo&
        p3descore& = p3descore& + combo&
ELSEIF scoret& = 3 OR scoret& = 6 THEN
        p4descore& = p4descore& - combo&
END IF
IF lasthit& = 1 THEN p1scores& = p1scores& + 1
IF lasthit& = 2 THEN p2scores& = p2scores& + 1
IF lasthit& = 3 THEN p3scores& = p3scores& + 1
IF lose& = 1 THEN
        p4desize& = 25
        p4speed& = 4 + pad& * 3
END IF
GOSUB score
RETURN

score:
combo& = 1
scombo& = 0
serve& = lasthit&
IF p1serve& >= 5 OR p2serve& >= 5 OR p3serve& >= 5 OR p4serve& >= 5 THEN
        p1serve& = 0
        p2serve& = 0
        p3serve& = 0
        p4serve& = 0
        serve& = 5
        GOSUB centerserve
END IF
IF serve& = 1 THEN
        x& = p1pad&
        y& = 13
ELSEIF serve& = 2 THEN
        x& = 13
        y& = p2pad&
ELSEIF serve& = 3 THEN
        x& = p3pad&
        y& = 467
ELSEIF serve& = 4 THEN
        x& = 467
        y& = p4pad&
END IF
waits& = 100
GOSUB draww
IF p1& > 1 THEN p1ac2& = INT(RND * (p1ac& * 2)) - p1ac&
IF p2& > 1 THEN p2ac2& = INT(RND * (p2ac& * 2)) - p2ac&
IF p3& > 1 THEN p3ac2& = INT(RND * (p3ac& * 2)) - p3ac&
IF p4& > 1 THEN p4ac2& = INT(RND * (p4ac& * 2)) - p4ac&
COLOR 0: LOCATE 30, 30: PRINT combo&
RETURN

draww:
VIEW
p1loc& = 1
p2loc& = 1
p3loc& = 1
p4loc& = 1
IF p1descore& <= p2descore& THEN p1loc& = p1loc& + 1
IF p1descore& <= p3descore& THEN p1loc& = p1loc& + 1
IF p1descore& <= p4descore& THEN p1loc& = p1loc& + 1
IF p2descore& <= p1descore& THEN p2loc& = p2loc& + 1
IF p2descore& <= p3descore& THEN p2loc& = p2loc& + 1
IF p2descore& <= p4descore& THEN p2loc& = p2loc& + 1
IF p3descore& <= p1descore& THEN p3loc& = p3loc& + 1
IF p3descore& <= p2descore& THEN p3loc& = p3loc& + 1
IF p3descore& <= p4descore& THEN p3loc& = p3loc& + 1
IF p4descore& <= p1descore& THEN p4loc& = p4loc& + 1
IF p4descore& <= p2descore& THEN p4loc& = p4loc& + 1
IF p4descore& <= p3descore& THEN p4loc& = p4loc& + 1
DO
IF p1loc& = p2loc& OR p1loc& = p3loc& OR p1loc& = p4loc& THEN p1loc& = p1loc& - 1
IF p2loc& = p1loc& OR p2loc& = p3loc& OR p2loc& = p4loc& THEN p2loc& = p2loc& - 1
IF p3loc& = p1loc& OR p3loc& = p2loc& OR p3loc& = p4loc& THEN p3loc& = p3loc& - 1
IF p4loc& = p1loc& OR p4loc& = p2loc& OR p4loc& = p3loc& THEN p4loc& = p4loc& - 1
LOOP UNTIL (p1loc& <> p2loc& AND p2loc& <> p3loc& AND p3loc& <> p4loc& AND p4loc& <> p1loc& AND p2loc& <> p4loc& AND p3loc& <> p1loc&)
        LOCATE ((p1loc& - 1) * 15) + 2, 62
        COLOR 1
        IF p1& = 0 THEN COLOR 0
        PRINT "Score:"; p1score&; "     "
        LOCATE ((p1loc& - 1) * 15) + 3, 62
        IF p1com& = 1 THEN
                IF p1& = 2 THEN PRINT "Computer Easiest"
                IF p1& = 3 THEN PRINT "Computer Easy   "
                IF p1& = 4 THEN PRINT "Computer Medium "
                IF p1& = 5 THEN PRINT "Computer Hard   "
                IF p1& = 6 THEN PRINT "Computer Hardest"
                LOCATE ((p1loc& - 1) * 15) + 4, 62: PRINT "         "
                LOCATE ((p1loc& - 1) * 15) + 5, 62: PRINT "         "
                LOCATE ((p1loc& - 1) * 15) + 6, 62: PRINT "         "
                LOCATE ((p1loc& - 1) * 15) + 7, 62: PRINT "         "
                LOCATE ((p1loc& - 1) * 15) + 8, 62: PRINT "         "
        END IF
        IF p1com& = 1 THEN GOTO ppp2
        PRINT "Human           "
        LOCATE ((p1loc& - 1) * 15) + 4, 62: PRINT "Keys:"
        LOCATE ((p1loc& - 1) * 15) + 5, 62: PRINT "G -Serve "
        LOCATE ((p1loc& - 1) * 15) + 6, 62: PRINT "V -Left  "
        LOCATE ((p1loc& - 1) * 15) + 7, 62: PRINT "B -Stop  "
        LOCATE ((p1loc& - 1) * 15) + 8, 62: PRINT "N -Right "
ppp2:
        LOCATE ((p2loc& - 1) * 15) + 2, 62
        COLOR 4
        IF p2& = 0 THEN COLOR 0
        PRINT "Score:"; p2score&; "     "
        LOCATE ((p2loc& - 1) * 15) + 3, 62
        IF p2com& = 1 THEN
                IF p2& = 2 THEN PRINT "Computer Easiest"
                IF p2& = 3 THEN PRINT "Computer Easy   "
                IF p2& = 4 THEN PRINT "Computer Medium "
                IF p2& = 5 THEN PRINT "Computer Hard   "
                IF p2& = 6 THEN PRINT "Computer Hardest"
                LOCATE ((p2loc& - 1) * 15) + 4, 62: PRINT "         "
                LOCATE ((p2loc& - 1) * 15) + 5, 62: PRINT "         "
                LOCATE ((p2loc& - 1) * 15) + 6, 62: PRINT "         "
                LOCATE ((p2loc& - 1) * 15) + 7, 62: PRINT "         "
                LOCATE ((p2loc& - 1) * 15) + 8, 62: PRINT "         "
        END IF
        IF p2com& = 1 THEN GOTO ppp3
        PRINT "Human           "
        LOCATE ((p2loc& - 1) * 15) + 4, 62: PRINT "Keys:"
        LOCATE ((p2loc& - 1) * 15) + 5, 62: PRINT "S -Serve "
        LOCATE ((p2loc& - 1) * 15) + 6, 62: PRINT "Q -Up    "
        LOCATE ((p2loc& - 1) * 15) + 7, 62: PRINT "A -Stop  "
        LOCATE ((p2loc& - 1) * 15) + 8, 62: PRINT "Z -Down  "
ppp3:
        LOCATE ((p3loc& - 1) * 15) + 2, 62
        COLOR 2
        IF p3& = 0 THEN COLOR 0
        PRINT "Score:"; p3score&; "     "
        LOCATE ((p3loc& - 1) * 15) + 3, 62
        IF p3com& = 1 THEN
                IF p3& = 2 THEN PRINT "Computer Easiest"
                IF p3& = 3 THEN PRINT "Computer Easy   "
                IF p3& = 4 THEN PRINT "Computer Medium "
                IF p3& = 5 THEN PRINT "Computer Hard   "
                IF p3& = 6 THEN PRINT "Computer Hardest"
                LOCATE ((p3loc& - 1) * 15) + 4, 62: PRINT "         "
                LOCATE ((p3loc& - 1) * 15) + 5, 62: PRINT "         "
                LOCATE ((p3loc& - 1) * 15) + 6, 62: PRINT "         "
                LOCATE ((p3loc& - 1) * 15) + 7, 62: PRINT "         "
                LOCATE ((p3loc& - 1) * 15) + 8, 62: PRINT "         "
        END IF
        IF p3com& = 1 THEN GOTO ppp4
        PRINT "Human           "
        LOCATE ((p3loc& - 1) * 15) + 4, 62: PRINT "Keys:"
        LOCATE ((p3loc& - 1) * 15) + 5, 62: PRINT CHR$(24); " -Serve "
        LOCATE ((p3loc& - 1) * 15) + 6, 62: PRINT CHR$(17); " -Left  "
        LOCATE ((p3loc& - 1) * 15) + 7, 62: PRINT CHR$(25); " -Stop  "
        LOCATE ((p3loc& - 1) * 15) + 8, 62: PRINT CHR$(16); " -Right "
ppp4:
        LOCATE ((p4loc& - 1) * 15) + 2, 62
        COLOR 14
        IF p4& = 0 THEN COLOR 0
        PRINT "Score:"; p4score&; "     "
        LOCATE ((p4loc& - 1) * 15) + 3, 62
        IF p4com& = 1 THEN
                IF p4& = 2 THEN PRINT "Computer Easiest"
                IF p4& = 3 THEN PRINT "Computer Easy   "
                IF p4& = 4 THEN PRINT "Computer Medium "
                IF p4& = 5 THEN PRINT "Computer Hard   "
                IF p4& = 6 THEN PRINT "Computer Hardest"
                LOCATE ((p4loc& - 1) * 15) + 4, 62: PRINT "         "
                LOCATE ((p4loc& - 1) * 15) + 5, 62: PRINT "         "
                LOCATE ((p4loc& - 1) * 15) + 6, 62: PRINT "         "
                LOCATE ((p4loc& - 1) * 15) + 7, 62: PRINT "         "
                LOCATE ((p4loc& - 1) * 15) + 8, 62: PRINT "         "
        END IF
        IF p4com& = 1 THEN GOTO fff
        PRINT "Human           "
        LOCATE ((p4loc& - 1) * 15) + 4, 62: PRINT "Keys:"
        LOCATE ((p4loc& - 1) * 15) + 5, 62: PRINT "; -Serve "
        LOCATE ((p4loc& - 1) * 15) + 6, 62: PRINT "] -Up    "
        LOCATE ((p4loc& - 1) * 15) + 7, 62: PRINT "' -Stop  "
        LOCATE ((p4loc& - 1) * 15) + 8, 62: PRINT "/ -Down  "

fff:

col1& = 0
col2& = 0
col3& = 0
col4& = 0
IF p1& > 0 THEN
        IF p1loc& = 1 THEN col1& = 1
        IF p1loc& = 2 THEN col2& = 1
        IF p1loc& = 3 THEN col3& = 1
        IF p1loc& = 4 THEN col4& = 1
END IF
IF p2& > 0 THEN
        IF p2loc& = 1 THEN col1& = 4
        IF p2loc& = 2 THEN col2& = 4
        IF p2loc& = 3 THEN col3& = 4
        IF p2loc& = 4 THEN col4& = 4
END IF
IF p3& > 0 THEN
        IF p3loc& = 1 THEN col1& = 2
        IF p3loc& = 2 THEN col2& = 2
        IF p3loc& = 3 THEN col3& = 2
        IF p3loc& = 4 THEN col4& = 2
END IF
IF p4& > 0 THEN
        IF p4loc& = 1 THEN col1& = 6
        IF p4loc& = 2 THEN col2& = 6
        IF p4loc& = 3 THEN col3& = 6
        IF p4loc& = 4 THEN col4& = 6
END IF
LINE (481, 0)-(639, 118), col1&, B
IF col1& = 0 THEN col1& = -8
LINE (482, 1)-(638, 117), col1& + 8, B
LINE (481, 121)-(639, 239), col2&, B
IF col2& = 0 THEN col2& = -8
LINE (482, 122)-(638, 238), col2& + 8, B
LINE (481, 241)-(639, 359), col3&, B
IF col3& = 0 THEN col3& = -8
LINE (482, 242)-(638, 358), col3& + 8, B
LINE (481, 361)-(639, 479), col4&, B
IF col4& = 0 THEN col4& = -8
LINE (482, 362)-(638, 478), col4& + 8, B

VIEW SCREEN (lx1& - 1, ly1& - 1)-(lx2&, ly2&)
RETURN

item:
startitem:
FOR j = 1 TO 30
IF stime(j) = 0 THEN symbol& = j
NEXT j
item& = INT(RND * 9) + 1
symbolt(symbol&) = item&
IF item& = 1 THEN
        IF it2& = 0 THEN GOTO startitem
        IF lasthit& = 1 THEN p1speed& = p1speed& - 1
        IF p1speed& < 1 THEN p1speed& = 1
        IF lasthit& = 2 THEN p2speed& = p2speed& - 1
        IF p2speed& < 1 THEN p2speed& = 1
        IF lasthit& = 3 THEN p3speed& = p3speed& - 1
        IF p3speed& < 1 THEN p3speed& = 1
        IF lasthit& = 4 THEN p4speed& = p4speed& - 1
        IF p4speed& < 1 THEN p4speed& = 1
ELSEIF item& = 2 THEN
        IF it2& = 0 THEN GOTO startitem
        IF lasthit& = 1 THEN p1speed& = p1speed& + 1
        IF p1speed& > 30 THEN p1speed& = 30
        IF lasthit& = 2 THEN p2speed& = p2speed& + 1
        IF p2speed& > 30 THEN p2speed& = 30
        IF lasthit& = 3 THEN p3speed& = p3speed& + 1
        IF p3speed& > 30 THEN p3speed& = 30
        IF lasthit& = 4 THEN p4speed& = p4speed& + 1
        IF p4speed& > 30 THEN p4speed& = 30
ELSEIF item& = 3 THEN
        IF it1& = 0 THEN GOTO startitem
        a& = a& - 1
        IF a& < 1 THEN a& = 1
ELSEIF item& = 4 THEN
        IF it1& = 0 THEN GOTO startitem
        a& = a& + 1
        IF a& > 4 THEN a& = 4
ELSEIF item& = 5 THEN
        IF it4& = 0 THEN GOTO startitem
rann:
        DO
        xs& = INT(RND * 17) - 8
        ys& = INT(RND * 17) - 8
        LOOP UNTIL (xs& <> 0 OR ys& <> 0)
        IF xs& = 0 AND p1& = 0 AND p3& = 0 THEN GOTO rann
        IF ys& = 0 AND p2& = 0 AND p4& = 0 THEN GOTO rann
ELSEIF item& = 6 THEN
        IF it3& = 0 THEN GOTO startitem
        rand& = INT(RND * 18) + 1
        padsize& = (rand& * 5) + 10
        IF lasthit& = 1 THEN
                IF padsize& > p1desize& THEN symbolt(symbol&) = 10 ELSE symbolt(symbol&) = 11
                p1desize& = padsize&
        ELSEIF lasthit& = 2 THEN
                IF padsize& > p2desize& THEN symbolt(symbol&) = 10 ELSE symbolt(symbol&) = 11
                p2desize& = padsize&
        ELSEIF lasthit& = 3 THEN
                IF padsize& > p3desize& THEN symbolt(symbol&) = 10 ELSE symbolt(symbol&) = 11
                p3desize& = padsize&
        ELSEIF lasthit& = 4 THEN
                IF padsize& > p4desize& THEN symbolt(symbol&) = 10 ELSE symbolt(symbol&) = 11
                p4desize& = padsize&
        END IF
ELSEIF item& = 7 THEN
        IF INT(RND * 5) + 1 = 1 THEN
                IF it8& = 0 THEN GOTO startitem
                points& = INT(RND * 50) + 1
                symbolt(symbol&) = 13
        ELSE
                IF it5& = 0 THEN GOTO startitem
                symbolt(symbol&) = 12
                points& = 5
        END IF
        IF lasthit& = 1 THEN p1descore& = p1descore& + points&
        IF lasthit& = 2 THEN p2descore& = p2descore& + points&
        IF lasthit& = 3 THEN p3descore& = p3descore& + points&
        IF lasthit& = 4 THEN p4descore& = p4descore& + points&
        GOSUB draww
ELSEIF item& = 8 THEN
        IF it6& = 0 THEN GOTO startitem
        IF INT(RND * 5) + 1 <> 1 THEN GOTO startitem
        IF combo& < 50000 THEN combo& = combo& * 2
        scombo& = 50
ELSEIF item& = 9 THEN
        IF it7& = 0 THEN GOTO startitem
        IF INT(RND * 3) + 1 <> 1 THEN GOTO startitem
        CLS
        IF lasthit& = 1 THEN p1hyper& = INT(RND * 1001) + 500
        IF lasthit& = 2 THEN p2hyper& = INT(RND * 1001) + 500
        IF lasthit& = 3 THEN p3hyper& = INT(RND * 1001) + 500
        IF lasthit& = 4 THEN p4hyper& = INT(RND * 1001) + 500
END IF
iitemx& = itemx(1, hit&)
iitemy& = itemy(1, hit&)
symbolx(symbol&) = iitemx&
symboly(symbol&) = iitemy&
IF re& = 1 THEN
        symbolx(symbol&) = iitemx& + 10
        symboly(symbol&) = iitemy& + 10
END IF
stime(symbol&) = 100
IF lasthit& = 1 THEN symbolc(symbol&) = 1
IF lasthit& = 2 THEN symbolc(symbol&) = 4
IF lasthit& = 3 THEN symbolc(symbol&) = 2
IF lasthit& = 4 THEN symbolc(symbol&) = 14
LINE (iitemx& - 2, iitemy& - 2)-(iitemx& + 2, iitemy& + 2), 0, BF
IF re& = 1 THEN RETURN
iitemx& = INT(RND * 340) + 70
iitemy& = INT(RND * 340) + 70
itemx(1, hit&) = iitemx&
itemy(1, hit&) = iitemy&
RETURN

player1:
IF y& < p1ai& AND ys& < 0 THEN
        p1des& = x& - xs& * (y& / ys&)
        p1des& = p1des& + p1ac2&
ELSE
        IF serve& = 0 AND p1& > 2 THEN p1des& = 240 ELSE p1des& = p1pad&
END IF
IF serve& = 2 AND p1& > 3 THEN
        p1des& = p2pad&
ELSEIF serve& = 3 AND p1& > 3 THEN
        p1des& = p3pad&
ELSEIF serve& = 4 AND p1& > 3 THEN
        p1des& = 480 - p4pad&
END IF
IF serve& = 1 THEN
        IF p2descore& < p4descore& THEN p1des& = 0
        IF p4descore& < p2descore& THEN p1des& = 480
        IF p2descore& = p4descore& THEN p1des& = 240
END IF
IF p1des& > p1pad& THEN p1dir& = 1
IF p1des& < p1pad& THEN p1dir& = 2
IF p1des& > (p1pad& - p1speed&) AND p1des& < (p1pad& + p1speed&) THEN p1dir& = 0
IF waits& > 0 THEN waits& = waits& - 1
IF serve& = 1 AND waits& = 0 THEN GOSUB serve
GOTO p2

player2:
IF x& < p2ai& AND xs& < 0 THEN
        p2des& = y& - ys& * (x& / xs&)
        p2des& = p2des& + p2ac2&
ELSE
        IF serve& = 0 AND p2& > 2 THEN p2des& = 240 ELSE p2des& = p2pad&
END IF
IF serve& = 1 AND p2& > 3 THEN
        p2des& = p1pad&
ELSEIF serve& = 3 AND p2& > 3 THEN
        p2des& = 480 - p3pad&
ELSEIF serve& = 4 AND p2& > 3 THEN
        p2des& = p4pad&
END IF
IF serve& = 2 THEN
        IF p1descore& < p3descore& THEN p2des& = 0
        IF p3descore& < p1descore& THEN p2des& = 480
        IF p1descore& = p3descore& THEN p2des& = 240
END IF
IF p2des& > p2pad& THEN p2dir& = 1
IF p2des& < p2pad& THEN p2dir& = 2
IF p2des& > (p2pad& - p2speed&) AND p2des& < (p2pad& + p2speed&) THEN p2dir& = 0
IF waits& > 0 THEN waits& = waits& - 1
IF serve& = 2 AND waits& = 0 THEN GOSUB serve
GOTO p3

player3:
IF y& > (480 - p3ai&) AND ys& > 0 THEN
        p3des& = x& - xs& * ((480 - y&) / -ys&)
        p3des& = p3des& + p3ac2&
ELSE
        IF serve& = 0 AND p3& > 2 THEN p3des& = 240 ELSE p3des& = p3pad&
END IF
IF serve& = 1 AND p3& > 3 THEN
        p3des& = p1pad&
ELSEIF serve& = 2 AND p3& > 3 THEN
        p3des& = 480 - p2pad&
ELSEIF serve& = 4 AND p3& > 3 THEN
        p3des& = p4pad&
END IF
IF serve& = 3 THEN
        IF p2descore& < p4descore& THEN p3des& = 0
        IF p4descore& < p2descore& THEN p3des& = 480
        IF p2descore& = p4descore& THEN p3des& = 240
END IF
IF p3des& > p3pad& THEN p3dir& = 1
IF p3des& < p3pad& THEN p3dir& = 2
IF p3des& > (p3pad& - p3speed&) AND p3des& < (p3pad& + p3speed&) THEN p3dir& = 0
IF waits& > 0 THEN waits& = waits& - 1
IF serve& = 3 AND waits& = 0 THEN GOSUB serve
GOTO p4

player4:
IF x& > (480 - p4ai&) AND xs& > 0 THEN
        p4des& = y& - ys& * ((480 - x&) / -xs&)
        p4des& = p4des& + p4ac2&
ELSE
        IF serve& = 0 AND p4& > 2 THEN p4des& = 240 ELSE p4des& = p4pad&
END IF
IF serve& = 1 AND p4& > 3 THEN
        p4des& = 480 - p1pad&
ELSEIF serve& = 2 AND p4& > 3 THEN
        p4des& = p2pad&
ELSEIF serve& = 3 AND p4& > 3 THEN
        p4des& = p3pad&
END IF
IF serve& = 4 THEN
        IF p1descore& < p3descore& THEN p4des& = 0
        IF p3descore& < p1descore& THEN p4des& = 480
        IF p1descore& = p3descore& THEN p4des& = 240
END IF
IF p4des& > p4pad& THEN p4dir& = 1
IF p4des& < p4pad& THEN p4dir& = 2
IF p4des& > (p4pad& - p4speed&) AND p4des& < (p4pad& + p4speed&) THEN p4dir& = 0
IF waits& > 0 THEN waits& = waits& - 1
IF serve& = 4 AND waits& = 0 THEN GOSUB serve
GOTO finish

title:
WIDTH 80, 30
COLOR 4
LOCATE 1, 1: COLOR 8: PRINT "4 Player Pong"
FOR x = 0 TO 64
FOR y = 0 TO 15
LINE ((x * 5) + 160, (y * 5) + 160)-((x * 5) + 165, (y * 5) + 165), POINT(x, y) / 2, B
NEXT y
NEXT x
FOR x = 0 TO 40
FOR y = 0 TO 15
LINE ((x * 5) + 240, (y * 5) + 235)-((x * 5) + 245, (y * 5) + 240), POINT(x + 72, y) / 2, B
NEXT y
NEXT x
LOCATE 1, 1
PRINT "              "
LINE (153, 149)-(481, 316), 14, B
LINE (152, 148)-(482, 317), 6, B
COLOR 3: LOCATE 21, 31: PRINT "    By Matthew   "
COLOR 11
LINE (640, 327)-(353, 327)
LINE (0, 327)-(269, 327)
LINE (269, 334)-(269, 320)
LINE (353, 334)-(353, 320)
LINE (353, 334)-(269, 334)
LINE (353, 320)-(269, 320)
DO
changeword& = changeword& + 1
IF changeword& = 2000 THEN changeword& = 0
IF changeword& < 1001 THEN COLOR 1
IF changeword& > 1000 THEN COLOR 0
LOCATE 27, 34: PRINT "Press any key"
a$ = INKEY$
LOOP UNTIL (a$ <> "")
CLS
RETURN

theend:
VIEW
started& = 0
CLS
p1pl& = 1
p2pl& = 1
p3pl& = 1
p4pl& = 1
IF p1descore& <= p2descore& OR p1& = 0 THEN p1pl& = p1pl& + 1
IF p1descore& <= p3descore& OR p1& = 0 THEN p1pl& = p1pl& + 1
IF p1descore& <= p4descore& OR p1& = 0 THEN p1pl& = p1pl& + 1
IF p2descore& <= p1descore& OR p2& = 0 THEN p2pl& = p2pl& + 1
IF p2descore& <= p3descore& OR p2& = 0 THEN p2pl& = p2pl& + 1
IF p2descore& <= p4descore& OR p2& = 0 THEN p2pl& = p2pl& + 1
IF p3descore& <= p1descore& OR p3& = 0 THEN p3pl& = p3pl& + 1
IF p3descore& <= p2descore& OR p3& = 0 THEN p3pl& = p3pl& + 1
IF p3descore& <= p4descore& OR p3& = 0 THEN p3pl& = p3pl& + 1
IF p4descore& <= p1descore& OR p4& = 0 THEN p4pl& = p4pl& + 1
IF p4descore& <= p2descore& OR p4& = 0 THEN p4pl& = p4pl& + 1
IF p4descore& <= p3descore& OR p4& = 0 THEN p4pl& = p4pl& + 1
tie& = 0
IF p1pl& = 1 THEN
        IF p1pl& = p2pl& OR p1pl& = p3pl& OR p1pl& = p4pl& THEN tie& = 1
END IF
IF p2pl& = 1 THEN
        IF p2pl& = p3pl& OR p2pl& = p4pl& THEN tie& = 1
END IF
IF p3pl& = 1 THEN
        IF p3pl& = p4pl& THEN tie& = 1
END IF
IF p1pl& = 1 THEN co1& = 1
IF p2pl& = 1 THEN co1& = 4
IF p3pl& = 1 THEN co1& = 2
IF p4pl& = 1 THEN co1& = 14
IF tie& = 1 THEN co1& = 15
IF p1pl& = 1 THEN co2& = 9
IF p2pl& = 1 THEN co2& = 12
IF p3pl& = 1 THEN co2& = 10
IF p4pl& = 1 THEN co2& = 6
IF tie& = 1 THEN co2& = 8
co& = co1&
ch& = 0
FOR i = 1 TO 240
ch& = ch& + 1
IF ch& = 10 AND co& = co1& THEN
        co& = co2&
ELSEIF ch& = 10 AND co& = co2& THEN
        co& = co1&
END IF
IF ch& = 10 THEN ch& = 0
LINE (320 - i, 240 - i)-(320 + i, 240 + i), co&, B
NEXT i
FOR i = 1 TO 100
FOR d = 1 TO 500
NEXT d
LINE (320 - i, 240)-(320 + i, 240), 15
LINE (319 - i, 239)-(321 + i, 241), 7, B
NEXT i
FOR i = 1 TO 100
FOR d = 1 TO 200
NEXT d
LINE (220, 240 - i)-(420, 240 + i), 15, B
LINE (221, 241 - i)-(419, 239 + i), 7, B
LINE (219, 239 - i)-(421, 241 + i), 7, B
LINE (222, 242 - i)-(418, 238 + i), 0, BF
NEXT i
COLOR 3: LOCATE 20, 36: PRINT "Game Stats"
LINE (279, 160)-(359, 160), 3
COLOR co1&
LOCATE 22, 30
IF tie& = 1 THEN PRINT "        Tie Game       " ELSE IF p1pl& = 1 THEN PRINT "Player 1 is the winner!" ELSE IF p2pl& = 1 THEN PRINT "Player 2 is the winner!" ELSE IF p3pl& = 1 THEN PRINT "Player 3 is the winner!" ELSE IF p4pl& = 1 THEN PRINT  _
"Player 4 is the winner!"
IF p1& > 1 THEN p1t$ = "Com " ELSE IF p1& = 1 THEN p1t$ = "Human" ELSE IF p1& = 0 THEN p1t$ = "Off "
IF p2& > 1 THEN p2t$ = "Com " ELSE IF p2& = 1 THEN p2t$ = "Human" ELSE IF p2& = 0 THEN p2t$ = "Off "
IF p3& > 1 THEN p3t$ = "Com " ELSE IF p3& = 1 THEN p3t$ = "Human" ELSE IF p3& = 0 THEN p3t$ = "Off "
IF p4& > 1 THEN p4t$ = "Com " ELSE IF p4& = 1 THEN p4t$ = "Human" ELSE IF p4& = 0 THEN p4t$ = "Off "
DO
IF p1pl& = p2pl& OR p1pl& = p3pl& OR p1pl& = p4pl& THEN p1pl& = p1pl& - 1
IF p2pl& = p1pl& OR p2pl& = p3pl& OR p2pl& = p4pl& THEN p2pl& = p2pl& - 1
IF p3pl& = p1pl& OR p3pl& = p2pl& OR p3pl& = p4pl& THEN p3pl& = p3pl& - 1
IF p4pl& = p1pl& OR p4pl& = p2pl& OR p4pl& = p3pl& THEN p4pl& = p4pl& - 1
LOOP UNTIL (p1pl& <> p2pl& AND p2pl& <> p3pl& AND p3pl& <> p4pl& AND p4pl& <> p1pl& AND p2pl& <> p4pl& AND p3pl& <> p1pl&)
IF p1& = 0 THEN p1descore& = 0
IF p2& = 0 THEN p2descore& = 0
IF p3& = 0 THEN p3descore& = 0
IF p4& = 0 THEN p4descore& = 0
COLOR 3: LOCATE 24, 30: PRINT "Player   Score  Goals"
COLOR 1: LOCATE 24 + p1pl&, 31: PRINT "P1-"; p1t$
LOCATE 24 + p1pl&, 39: PRINT p1descore&
LOCATE 24 + p1pl&, 46: PRINT p1scores&
COLOR 4: LOCATE 24 + p2pl&, 31: PRINT "P2-"; p2t$
LOCATE 24 + p2pl&, 39: PRINT p2descore&
LOCATE 24 + p2pl&, 46: PRINT p2scores&
COLOR 2: LOCATE 24 + p3pl&, 31: PRINT "P3-"; p3t$
LOCATE 24 + p3pl&, 39: PRINT p3descore&
LOCATE 24 + p3pl&, 46: PRINT p3scores&
COLOR 14: LOCATE 24 + p4pl&, 31: PRINT "P4-"; p4t$
LOCATE 24 + p4pl&, 39: PRINT p4descore&
LOCATE 24 + p4pl&, 46: PRINT p4scores&
gts& = finished& - startedd&
DO
IF gts& >= 60 THEN
        gts& = gts& - 60
        gtm& = gtm& + 1
ELSE
        EXIT DO
END IF
LOOP
DO
IF gtm& >= 60 THEN
        gtm& = gtm& - 60
        gth& = gth& + 1
ELSE
        EXIT DO
END IF
LOOP
COLOR 3: LOCATE 30, 30: PRINT "Game time:"
LOCATE 31, 30: IF gts& > -1 THEN PRINT gts&; "sec" ELSE PRINT "Error"
LOCATE 31, 30: IF gtm& > 0 THEN PRINT gtm&; "min"; gts&; "sec"
LOCATE 31, 30: IF gth& > 0 THEN PRINT gth&; "hr"; gtm&; "min"; gts&; "sec"
LOCATE 33, 31: PRINT "ontinue"
COLOR 11: LOCATE 33, 30: PRINT "C"

DO WHILE a$ <> "c"
a$ = INKEY$
SWAP co1&, co2&
FOR i = 102 TO 240
ch& = ch& + 1
IF ch& = 10 AND co& = co1& THEN
        co& = co2&
ELSEIF ch& = 10 AND co& = co2& THEN
        co& = co1&
END IF
IF ch& = 10 THEN ch& = 0
LINE (320 - i, 240 - i)-(320 + i, 240 + i), co&, B
NEXT i
LOOP

gts& = 0
gtm& = 0
gth& = 0

GOTO start

switch:
COLOR 5
a$ = INKEY$
IF a$ = CHR$(0) + "P" THEN
        arrow& = arrow& + 1
ELSEIF a$ = CHR$(0) + "H" THEN
        arrow& = arrow& - 1
ELSEIF a$ = " " THEN
        IF arrow& = 1 THEN it1& = it1& + 1
        IF arrow& = 2 THEN it2& = it2& + 1
        IF arrow& = 3 THEN it3& = it3& + 1
        IF arrow& = 4 THEN it4& = it4& + 1
        IF arrow& = 5 THEN it5& = it5& + 1
        IF arrow& = 6 THEN it8& = it8& + 1
        IF arrow& = 7 THEN it6& = it6& + 1
        IF arrow& = 8 THEN it7& = it7& + 1
END IF
IF it1& = 2 THEN it1& = 0
IF it2& = 2 THEN it2& = 0
IF it3& = 2 THEN it3& = 0
IF it4& = 2 THEN it4& = 0
IF it5& = 2 THEN it5& = 0
IF it6& = 2 THEN it6& = 0
IF it7& = 2 THEN it7& = 0
IF it8& = 2 THEN it8& = 0
IF arrow& = 9 THEN arrow& = 1
IF arrow& = 0 THEN arrow& = 8

DRAW "BM583,130 C4 E F C14 L1 C4 BD E BR2 NR3 NE NF BL5 L BR C0 U BL2 C8 G BE C0 L"
DRAW "BM583,134 C4 E F C14 L1 C4 BD E C2 BR5 NL3 NH NG C4 BL8 L BR C0 U BL2 C8 G BE C0 L"
DRAW "BM578,138 C1 M-2,0 R4 U L4 BL2 C4 D BL2 U Bl2 D BR12 NE NR3 NF"
DRAW "BM578,142 C1 M-2,0 R4 U L4 BL2 C2 D BL2 U Bl2 D BR15 NH NL3 NG"
DRAW "BM585,146 C1 BL2 R4 U1 L4 BM-5,1 C2 NR3 NF NE BR14 NL3 NG NH"
DRAW "BM585,150 C1 BL2 R4 U1 L4 BM-2,1 C4 NL3 NG NH BR8 NR3 NF NE"
DRAW "BM574,156 BD2 C8 F BU C0 L1 BM-2,-1 C12 R BG C0 U2 C4 U1 BD C0 L BU3 BR2 C14 R BR C4 G H E"
DRAW "BM583,164 C3 BM-3,-1 R2 H D2 BR4 F R E U H L2 U2 R3"
DRAW "BM574,172 C3 BM-3,-1 R2 H D2 BR4 BU4 R F D G L D3 BE C0 L"
DRAW "BM583,180 C3 BL H2 BD2 E2 BM+3,-1 E R F D G3 R3"
DRAW "BM575,187 BM-1,-4 C14 R4 D L4 G R4 D L4 G R7 G L3 D R2 G L2 D R G L D"

COLOR 4
IF arrow& = 1 THEN COLOR 12 ELSE COLOR 4
LOCATE 17, 42
PRINT "Change Ball Speed -"
IF arrow& = 2 THEN COLOR 12 ELSE COLOR 4
LOCATE 18, 42
PRINT "Change Pad Speed -"
IF arrow& = 3 THEN COLOR 12 ELSE COLOR 4
LOCATE 19, 42
PRINT "Change Pad Size -"
IF arrow& = 4 THEN COLOR 12 ELSE COLOR 4
LOCATE 20, 42
PRINT "Change Ball Direction -"
IF arrow& = 5 THEN COLOR 12 ELSE COLOR 4
LOCATE 21, 42
PRINT "5 Point Bonus -"
IF arrow& = 6 THEN COLOR 12 ELSE COLOR 4
LOCATE 22, 42
PRINT "Major Point Bonus -"
IF arrow& = 7 THEN COLOR 12 ELSE COLOR 4
LOCATE 23, 42
PRINT "Combo Double -"
IF arrow& = 8 THEN COLOR 12 ELSE COLOR 4
LOCATE 24, 42
PRINT "Hyper Mode -"
IF it1& = 1 THEN COLOR 12 ELSE COLOR 4
LOCATE 17, 66
PRINT "On "
IF it1& = 0 THEN COLOR 12 ELSE COLOR 4
LOCATE 17, 69
PRINT "Off"
IF it2& = 1 THEN COLOR 12 ELSE COLOR 4
LOCATE 18, 66
PRINT "On "
IF it2& = 0 THEN COLOR 12 ELSE COLOR 4
LOCATE 18, 69
PRINT "Off"
IF it3& = 1 THEN COLOR 12 ELSE COLOR 4
LOCATE 19, 66
PRINT "On "
IF it3& = 0 THEN COLOR 12 ELSE COLOR 4
LOCATE 19, 69
PRINT "Off"
IF it4& = 1 THEN COLOR 12 ELSE COLOR 4
LOCATE 20, 66
PRINT "On "
IF it4& = 0 THEN COLOR 12 ELSE COLOR 4
LOCATE 20, 69
PRINT "Off"
IF it5& = 1 THEN COLOR 12 ELSE COLOR 4
LOCATE 21, 66
PRINT "On "
IF it5& = 0 THEN COLOR 12 ELSE COLOR 4
LOCATE 21, 69
PRINT "Off"
IF it8& = 1 THEN COLOR 12 ELSE COLOR 4
LOCATE 22, 66
PRINT "On "
IF it8& = 0 THEN COLOR 12 ELSE COLOR 4
LOCATE 22, 69
PRINT "Off"
IF it6& = 1 THEN COLOR 12 ELSE COLOR 4
LOCATE 23, 66
PRINT "On "
IF it6& = 0 THEN COLOR 12 ELSE COLOR 4
LOCATE 23, 69
PRINT "Off"
IF it7& = 1 THEN COLOR 12 ELSE COLOR 4
LOCATE 24, 66
PRINT "On "
IF it7& = 0 THEN COLOR 12 ELSE COLOR 4
LOCATE 24, 69
PRINT "Off"

IF a$ = "d" THEN
        CLS
        switch& = 0
END IF
GOTO skip

start:
IF it& = 0 THEN it& = 15
fic& = INT(RND * 5) + 1
IF p1r& = 1 THEN p1m& = p1&
IF p2r& = 1 THEN p2m& = p2&
IF p3r& = 1 THEN p3m& = p3&
IF p4r& = 1 THEN p4m& = p4&
IF p1r& = 1 THEN p1& = 7
IF p2r& = 1 THEN p2& = 7
IF p3r& = 1 THEN p3& = 7
IF p4r& = 1 THEN p4& = 7
VIEW
CLS
DO
COLOR 14: LOCATE 1, 15: PRINT "Game Setup"
LINE (111, 8)-(191, 8)
COLOR 2: LOCATE 3, 15: PRINT "Players ("
LOCATE 3, 31: PRINT ")"
COLOR 10: LOCATE 3, 24: PRINT "1,2,3,4"
COLOR 1: LOCATE 4, 16: PRINT "P1 -"
LOCATE 4, 21
IF p1& = 0 THEN PRINT "Off               "
IF p1& = 1 THEN PRINT "Human             "
IF p1& = 2 THEN PRINT "Computer (Easiest)"
IF p1& = 3 THEN PRINT "Computer (Easy)   "
IF p1& = 4 THEN PRINT "Computer (Medium) "
IF p1& = 5 THEN PRINT "Computer (Hard)   "
IF p1& = 6 THEN PRINT "Computer (Hardest)"
IF p1& = 7 THEN PRINT "Computer (Random) "
COLOR 4: LOCATE 5, 16: PRINT "P2 -"
LOCATE 5, 21
IF p2& = 0 THEN PRINT "Off               "
IF p2& = 1 THEN PRINT "Human             "
IF p2& = 2 THEN PRINT "Computer (Easiest)"
IF p2& = 3 THEN PRINT "Computer (Easy)   "
IF p2& = 4 THEN PRINT "Computer (Medium) "
IF p2& = 5 THEN PRINT "Computer (Hard)   "
IF p2& = 6 THEN PRINT "Computer (Hardest)"
IF p2& = 7 THEN PRINT "Computer (Random) "
COLOR 2: LOCATE 6, 16: PRINT "P3 -"
LOCATE 6, 21
IF p3& = 0 THEN PRINT "Off               "
IF p3& = 1 THEN PRINT "Human             "
IF p3& = 2 THEN PRINT "Computer (Easiest)"
IF p3& = 3 THEN PRINT "Computer (Easy)   "
IF p3& = 4 THEN PRINT "Computer (Medium) "
IF p3& = 5 THEN PRINT "Computer (Hard)   "
IF p3& = 6 THEN PRINT "Computer (Hardest)"
IF p3& = 7 THEN PRINT "Computer (Random) "
COLOR 14: LOCATE 7, 16: PRINT "P4 -"
LOCATE 7, 21
IF p4& = 0 THEN PRINT "Off               "
IF p4& = 1 THEN PRINT "Human             "
IF p4& = 2 THEN PRINT "Computer (Easiest)"
IF p4& = 3 THEN PRINT "Computer (Easy)   "
IF p4& = 4 THEN PRINT "Computer (Medium) "
IF p4& = 5 THEN PRINT "Computer (Hard)   "
IF p4& = 6 THEN PRINT "Computer (Hardest)"
IF p4& = 7 THEN PRINT "Computer (Random) "
COLOR 4
IF items& = 1 THEN
        COLOR 12: LOCATE 9, 48: PRINT "l"
        COLOR 4: LOCATE 9, 40: PRINT "Items Re"
        LOCATE 9, 49: PRINT "ocate when Hit"
        LOCATE 10, 41
        IF re& = 1 THEN PRINT "No "
        IF re& = 0 THEN PRINT "Yes"
        COLOR 12: LOCATE 12, 45: PRINT "U"
        COLOR 4: LOCATE 12, 40: PRINT "Lose "
        LOCATE 12, 46: PRINT "pgrades when Scored On"
        LOCATE 13, 41
        IF lose& = 0 THEN PRINT "No "
        IF lose& = 1 THEN PRINT "Yes"
        LOCATE 15, 40: PRINT "Item Switch"
        COLOR 12
        IF switch& = 1 THEN COLOR 4
        LOCATE 15, 46: PRINT "w"
        IF switch& = 1 THEN
                COLOR 4: LOCATE 15, 51: PRINT "(Press  "
                LOCATE 15, 60: PRINT "when done)"
                COLOR 12: LOCATE 15, 58: PRINT "D"
        END IF
END IF
COLOR 12: LOCATE 3, 40: PRINT "I"
COLOR 4: LOCATE 3, 41: PRINT "tems"
LOCATE 4, 41
IF items& = 1 THEN PRINT "On "
IF items& = 0 THEN PRINT "Off"
IF items& = 1 THEN
        COLOR 12: LOCATE 6, 40: PRINT "N"
        COLOR 4: LOCATE 6, 41: PRINT "umber of Items"
        LOCATE 7, 40: PRINT it&
END IF
COLOR 11: LOCATE 9, 15: PRINT "B"
COLOR 3: LOCATE 9, 16: PRINT "all Speed"
LOCATE 10, 16
IF speed& = 1 THEN PRINT "Normal   "
IF speed& = 2 THEN PRINT "Fast     "
IF speed& = 3 THEN PRINT "Very Fast"
IF speed& = 4 THEN PRINT "Too Fast "
COLOR 11: LOCATE 12, 15: PRINT "P"
COLOR 3: LOCATE 12, 16: PRINT "ad Speed"
LOCATE 13, 16
IF pad& = 1 THEN PRINT "Normal   "
IF pad& = 2 THEN PRINT "Fast     "
IF pad& = 3 THEN PRINT "Very Fast"
IF pad& = 4 THEN PRINT "Too Fast "
COLOR 9: LOCATE 15, 23: PRINT "M"
COLOR 1: LOCATE 15, 15: PRINT "Scoring"
LOCATE 15, 24: PRINT "ode"
LOCATE 16, 16
IF scoret& = 1 THEN PRINT "Basic           "
IF scoret& = 2 THEN PRINT "All Gain        "
IF scoret& = 3 THEN PRINT "One Lose        "
IF scoret& = 4 THEN PRINT "Combo           "
IF scoret& = 5 THEN PRINT "All Gain (Combo)"
IF scoret& = 6 THEN PRINT "One Lose (Combo)"
IF scoret& = 3 OR scoret& = 6 THEN
        COLOR 1: LOCATE 18, 15: PRINT "Start S"
        LOCATE 19, 15: PRINT max&
        LOCATE 18, 23: PRINT "ore 0 = No End "
        COLOR 9: LOCATE 18, 22: PRINT "c"
ELSE
        COLOR 1: LOCATE 18, 15: PRINT "Ma"
        LOCATE 19, 15: PRINT max&
        LOCATE 18, 19: PRINT "Score 0 = Unlimited"
        COLOR 9: LOCATE 18, 17: PRINT "x "
END IF
COLOR 13: LOCATE 15, 2: PRINT "S"
LOCATE 17, 2: PRINT "R"
LOCATE 19, 2: PRINT "Q"
COLOR 5: LOCATE 15, 3: PRINT "tart"
LOCATE 17, 3: PRINT "eturn"
LOCATE 19, 3: PRINT "uit"
o& = 0
IF p1& > 0 THEN o& = o& + 1
IF p2& > 0 THEN o& = o& + 1
IF p3& > 0 THEN o& = o& + 1
IF p4& > 0 THEN o& = o& + 1
IF switch& = 1 THEN GOTO switch
a$ = INKEY$
IF a$ = "q" THEN END
IF a$ = "r" THEN EXIT DO
IF a$ = "s" THEN
        started& = 0
        EXIT DO
ELSEIF a$ = "l" THEN
        re& = -re& + 1
ELSEIF a$ = "u" THEN
        lose& = -lose& + 1
ELSEIF a$ = "x" OR a$ = "c" THEN
        LOCATE 19, 16
        PRINT "        "
        COLOR 1
        LOCATE 19, 16
        INPUT "", max&
        IF max& > 500000 THEN max& = 500000
        CLS
ELSEIF a$ = "m" THEN
        scoret& = scoret& + 1
        IF scoret& = 7 THEN scoret& = 1
ELSEIF a$ = "w" AND items& = 1 THEN
        arrow& = 1
        switch& = 1
ELSEIF a$ = "b" THEN
        speed& = speed& + 1
        IF speed& > 4 THEN speed& = 1
ELSEIF a$ = "p" THEN
        pad& = pad& + 1
        IF pad& = 5 THEN pad& = 1
ELSEIF a$ = "n" THEN
        it& = it& + 1
        IF it& > 15 THEN it& = 1: CLS
ELSEIF a$ = "i" THEN
        items& = -items& + 1
        CLS
ELSEIF a$ = "1" THEN
        p1& = p1& + 1
        IF p1& = 8 AND o& > 1 THEN p1& = 0
        IF p1& = 8 AND o& < 2 THEN p1& = 1
        started& = 0
        CLS
ELSEIF a$ = "2" THEN
        p2& = p2& + 1
        IF p2& = 8 AND o& > 1 THEN p2& = 0
        IF p2& = 8 AND o& < 2 THEN p2& = 1
        started& = 0
        CLS
ELSEIF a$ = "3" THEN
        p3& = p3& + 1
        IF p3& = 8 AND o& > 1 THEN p3& = 0
        IF p3& = 8 AND o& < 2 THEN p3& = 1
        started& = 0
        CLS
ELSEIF a$ = "4" THEN
        p4& = p4& + 1
        IF p4& = 8 AND o& > 1 THEN p4& = 0
        IF p4& = 8 AND o& < 2 THEN p4& = 1
        started& = 0
        CLS
END IF
skip:
VIEW SCREEN (0, 0)-(102, 102)
IF items& = 1 THEN
        FOR i = 1 TO it&
        IF ABS(ballx& - demoitemx(1, i)) < 2 AND ABS(bally& - demoitemy(1, i)) < 2 AND re& = 0 THEN
                CLS
                demoitemx(1, i) = INT(RND * 74) + 14
                demoitemy(1, i) = INT(RND * 74) + 14
        END IF
        LINE (demoitemx(1, i), demoitemy(1, i))-(demoitemx(1, i) + 1, demoitemy(1, i) + 1), fic&, BF
        NEXT i
END IF
x1& = 0
y1& = 0
x2& = 102
y2& = 102
IF p1& = 0 THEN y1& = 12
IF p2& = 0 THEN x1& = 12
IF p3& = 0 THEN y2& = 90
IF p4& = 0 THEN x2& = 90
LINE (x1&, y1&)-(x2&, y2&), co&, B
IF p1& > 0 AND p2& > 0 THEN
        LINE (2, 2)-(2, 14), 1
        LINE (2, 2)-(14, 2), 1
        LINE (14, 2)-(2, 14), 1
END IF
IF p2& > 0 AND p3& > 0 THEN
        LINE (2, 100)-(2, 88), 4
        LINE (2, 100)-(14, 100), 4
        LINE (14, 100)-(2, 88), 4
END IF
IF p3& > 0 AND p4& > 0 THEN
        LINE (100, 100)-(100, 88), 2
        LINE (100, 100)-(88, 100), 2
        LINE (88, 100)-(100, 88), 2
END IF
IF p4& > 0 AND p1& > 0 THEN
        LINE (100, 2)-(100, 14), 14
        LINE (100, 2)-(88, 2), 14
        LINE (88, 2)-(100, 14), 14
END IF
IF p1& > 0 THEN LINE (pad1& - 5, 2)-(pad1& + 5, 3), 1, BF
IF p2& > 0 THEN LINE (2, pad2& - 5)-(3, pad2& + 5), 4, BF
IF p3& > 0 THEN LINE (pad3& - 5, 100)-(pad3& + 5, 99), 2, BF
IF p4& > 0 THEN LINE (100, pad4& - 5)-(99, pad4& + 5), 14, BF

IF p1& > 0 THEN LINE (pad1& - 6, 2)-(15, 4), 0, BF
IF p1& > 0 THEN LINE (pad1& + 6, 2)-(87, 4), 0, BF
IF p2& > 0 THEN LINE (2, pad2& - 6)-(4, 15), 0, BF
IF p2& > 0 THEN LINE (2, pad2& + 6)-(4, 87), 0, BF
IF p3& > 0 THEN LINE (pad3& - 6, 100)-(15, 98), 0, BF
IF p3& > 0 THEN LINE (pad3& + 6, 100)-(87, 98), 0, BF
IF p4& > 0 THEN LINE (100, pad4& - 6)-(98, 15), 0, BF
IF p4& > 0 THEN LINE (100, pad4& + 6)-(98, 87), 0, BF

IF (bally& < 15 OR bally& > 87) AND ballxs& = 0 THEN ballxs& = 1
IF (ballx& < 15 OR ballx& > 87) AND ballys& = 0 THEN ballys& = 1

IF ballx& < 14 AND bally& < 14 THEN
        SWAP ballxs&, ballys&
        ballxs& = -ballxs&
        ballys& = -ballys&
        IF ABS(ballxs&) = ABS(ballys&) THEN ballxs& = ballxs& + 1
        LINE (ballx& - 1, bally& - 1)-(ballx&, bally&), 0, B
        bally& = 13
        ballx& = 13
        SOUND 750, .1
END IF
IF ballx& < 14 AND bally& > 88 THEN
        SWAP ballxs&, ballys&
        IF ABS(ballxs&) = ABS(ballys&) THEN ballxs& = ballxs& + 1
        LINE (ballx& - 1, bally& - 1)-(ballx&, bally&), 0, B
        bally& = 89
        ballx& = 13
        SOUND 750, .1
END IF
IF ballx& > 88 AND bally& < 14 THEN
        SWAP ballxs&, ballys&
        IF ABS(ballxs&) = ABS(ballys&) THEN ballxs& = ballxs& + 1
        LINE (ballx& - 1, bally& - 1)-(ballx&, bally&), 0, B
        bally& = 13
        ballx& = 89
        SOUND 750, .1
END IF
IF ballx& > 88 AND bally& > 88 THEN
        SWAP ballxs&, ballys&
        ballxs& = -ballxs&
        ballys& = -ballys&
        IF ABS(ballxs&) = ABS(ballys&) THEN ballxs& = ballxs& + 1
        LINE (ballx& - 1, bally& - 1)-(ballx&, bally&), 0, B
        bally& = 89
        ballx& = 89
        SOUND 750, .1
END IF
LINE (ballx& - 1, bally& - 1)-(ballx&, bally&), 0, B
PSET (ballx2&, bally2&), 0
PSET (ballx3&, bally3&), 0
PSET (ballx4&, bally4&), 0
bally4& = bally3&
bally3& = bally2&
bally2& = bally&
ballx4& = ballx3&
ballx3& = ballx2&
ballx2& = ballx&
bally& = bally& + ballys&
ballx& = ballx& + ballxs&
LINE (ballx& - 1, bally& - 1)-(ballx&, bally&), 4, B
PSET (ballx&, bally&), 14
PSET (ballx2&, bally2&), 12
PSET (ballx3&, bally3&), 12
PSET (ballx4&, bally4&), 8

IF bally& < 1 OR (bally& < 14 AND p1& = 0) THEN
        IF p1& > 0 THEN co& = 1
        ballys& = INT(RND * 3) + 1
        SOUND 500, .1
ELSEIF ballx& < 1 OR (ballx& < 14 AND p2& = 0) THEN
        IF p2& > 0 THEN co& = 4
        ballxs& = INT(RND * 3) + 1
        SOUND 500, .1
ELSEIF ballx& > 100 OR (ballx& > 88 AND p4& = 0) THEN
        IF p4& > 0 THEN co& = 14
        ballxs& = -(INT(RND * 3) + 1)
        SOUND 500, .1
ELSEIF bally& > 100 OR (bally& > 88 AND p3& = 0) THEN
        IF p3& > 0 THEN co& = 2
        ballys& = -(INT(RND * 3) + 1)
        SOUND 500, .1
END IF

IF ballys& < 0 THEN
        IF ballx& > pad1& THEN pad1& = pad1& + 3
        IF ballx& < pad1& THEN pad1& = pad1& - 3
        IF pad1& > 82 THEN pad1& = 82
        IF pad1& < 20 THEN pad1& = 20
END IF
IF ballxs& < 0 THEN
        IF bally& > pad2& THEN pad2& = pad2& + 3
        IF bally& < pad2& THEN pad2& = pad2& - 3
        IF pad2& > 82 THEN pad2& = 82
        IF pad2& < 20 THEN pad2& = 20
END IF
IF ballys& > 0 THEN
        IF ballx& > pad3& THEN pad3& = pad3& + 3
        IF ballx& < pad3& THEN pad3& = pad3& - 3
        IF pad3& > 82 THEN pad3& = 82
        IF pad3& < 20 THEN pad3& = 20
END IF
IF ballxs& > 0 THEN
        IF bally& > pad4& THEN pad4& = pad4& + 3
        IF bally& < pad4& THEN pad4& = pad4& - 3
        IF pad4& > 82 THEN pad4& = 82
        IF pad4& < 20 THEN pad4& = 20
END IF
VIEW
LOOP
IF (scoret& = 3 OR scoret& = 6) AND o& = 1 THEN GOTO start
IF p1& = 7 THEN p1r& = 1 ELSE p1r& = 0
IF p2& = 7 THEN p2r& = 1 ELSE p2r& = 0
IF p3& = 7 THEN p3r& = 1 ELSE p3r& = 0
IF p4& = 7 THEN p4r& = 1 ELSE p4r& = 0
IF started& = 1 THEN
        IF p1r& = 1 THEN p1& = p1m&
        IF p2r& = 1 THEN p2& = p2m&
        IF p3r& = 1 THEN p3& = p3m&
        IF p4r& = 1 THEN p4& = p4m&
END IF
IF started& = 1 THEN startedd& = startedd& + subtract&
IF started& = 0 THEN GOTO new ELSE GOTO restart

