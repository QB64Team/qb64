CHDIR ".\programs\samples\qb45com\action\arcdemo"

rem No Tittle

screen 12

print "It`s great demo of my VIRTUAL SCREEN engene"
print "Press Q/A/O/P/M to move your soldier        "
print "This program written by Tsiplacov Sergey"
print "For best work, you need at least 486DX processor"
print "and FirstBasic Compiler."
print
print "maple@arstel.ru                 Sergey, Russia"
rus:
a$=inkey$
if a$<>"" then goto beg
goto rus


beg:
SCREEN 7
SCREEN , , 3, 2
RESTORE mdat
FOR f = 1 TO 77
READ a$
OPEN a$ + ".sps" FOR INPUT AS #2
INPUT #2, r, ah, bh
CLOSE #2
OPEN a$ + ".spr" FOR INPUT AS #2
DIM dd(ah, bh)
FOR x = 1 TO ah: FOR y = 1 TO bh: INPUT #2, dd(x, y): PSET (x, y), dd(x, y): NEXT y: NEXT x
CLOSE #2
IF f = 1 THEN DIM g1(r): GET (1, 1)-(ah, bh), g1
IF f = 2 THEN DIM g2(r): GET (1, 1)-(ah, bh), g2
IF f = 3 THEN DIM g3(r): GET (1, 1)-(ah, bh), g3
IF f = 4 THEN DIM wc(r): GET (1, 1)-(ah, bh), wc
IF f = 5 THEN DIM h1l(r): GET (1, 1)-(ah, bh), h1l
IF f = 6 THEN DIM h2l(r): GET (1, 1)-(ah, bh), h2l
IF f = 7 THEN DIM h1r(r): GET (1, 1)-(ah, bh), h1r
IF f = 8 THEN DIM h2r(r): GET (1, 1)-(ah, bh), h2r
IF f = 9 THEN DIM w1(r): GET (1, 1)-(ah, bh), w1
IF f = 10 THEN DIM w2(r): GET (1, 1)-(ah, bh), w2
IF f = 11 THEN DIM h1lm(r): GET (1, 1)-(ah, bh), h1lm
IF f = 12 THEN DIM h2lm(r): GET (1, 1)-(ah, bh), h2lm
IF f = 13 THEN DIM h1rm(r): GET (1, 1)-(ah, bh), h1rm
IF f = 14 THEN DIM h2rm(r): GET (1, 1)-(ah, bh), h2rm
IF f = 15 THEN DIM m1(r): GET (1, 1)-(ah, bh), m1
IF f = 16 THEN DIM m2(r): GET (1, 1)-(ah, bh), m2
IF f = 17 THEN DIM t1r(r): GET (1, 1)-(ah, bh), t1r
IF f = 18 THEN DIM t1l(r): GET (1, 1)-(ah, bh), t1l
IF f = 19 THEN DIM t1rm(r): GET (1, 1)-(ah, bh), t1rm
IF f = 20 THEN DIM t1lm(r): GET (1, 1)-(ah, bh), t1lm
IF f = 21 THEN DIM mr1r(r): GET (1, 1)-(ah, bh), mr1r
IF f = 22 THEN DIM mr2r(r): GET (1, 1)-(ah, bh), mr2r
IF f = 23 THEN DIM mr1l(r): GET (1, 1)-(ah, bh), mr1l
IF f = 24 THEN DIM mr2l(r): GET (1, 1)-(ah, bh), mr2l
IF f = 25 THEN DIM mr1rm(r): GET (1, 1)-(ah, bh), mr1rm
IF f = 26 THEN DIM mr2rm(r): GET (1, 1)-(ah, bh), mr2rm
IF f = 27 THEN DIM mr1lm(r): GET (1, 1)-(ah, bh), mr1lm
IF f = 28 THEN DIM mr2lm(r): GET (1, 1)-(ah, bh), mr2lm
IF f = 29 THEN DIM ff(r): GET (1, 1)-(ah, bh), ff
IF f = 30 THEN DIM ffm(r): GET (1, 1)-(ah, bh), ffm
IF f = 31 THEN DIM lkl(r): GET (1, 1)-(ah, bh), lkl
IF f = 32 THEN DIM lkr(r): GET (1, 1)-(ah, bh), lkr
IF f = 33 THEN DIM lklm(r): GET (1, 1)-(ah, bh), lklm
IF f = 34 THEN DIM lkrm(r): GET (1, 1)-(ah, bh), lkrm
IF f = 35 THEN DIM g4(r): GET (1, 1)-(ah, bh), g4
IF f = 36 THEN DIM g5(r): GET (1, 1)-(ah, bh), g5
IF f = 37 THEN DIM g6(r): GET (1, 1)-(ah, bh), g6
IF f = 38 THEN DIM g7(r): GET (1, 1)-(ah, bh), g7
IF f = 39 THEN DIM g8(r): GET (1, 1)-(ah, bh), g8
IF f = 40 THEN DIM g9(r): GET (1, 1)-(ah, bh), g9
IF f = 41 THEN DIM g10(r): GET (1, 1)-(ah, bh), g10
IF f = 42 THEN DIM g11(r): GET (1, 1)-(ah, bh), g11
IF f = 43 THEN DIM g12(r): GET (1, 1)-(ah, bh), g12
IF f = 44 THEN DIM tr1r(r): GET (1, 1)-(ah, bh), tr1r
IF f = 45 THEN DIM tr1l(r): GET (1, 1)-(ah, bh), tr1l
IF f = 46 THEN DIM tr1rm(r): GET (1, 1)-(ah, bh), tr1rm
IF f = 47 THEN DIM tr1lm(r): GET (1, 1)-(ah, bh), tr1lm
IF f = 48 THEN DIM bl1(r): GET (1, 1)-(ah, bh), bl1
IF f = 49 THEN DIM bl2(r): GET (1, 1)-(ah, bh), bl2
IF f = 50 THEN DIM bl3(r): GET (1, 1)-(ah, bh), bl3
IF f = 51 THEN DIM bl1m(r): GET (1, 1)-(ah, bh), bl1m
IF f = 52 THEN DIM bl2m(r): GET (1, 1)-(ah, bh), bl2m
IF f = 53 THEN DIM bl3m(r): GET (1, 1)-(ah, bh), bl3m
IF f = 54 THEN DIM dm1(r): GET (1, 1)-(ah, bh), dm1
IF f = 55 THEN DIM dm2(r): GET (1, 1)-(ah, bh), dm2
IF f = 56 THEN DIM dm1m(r): GET (1, 1)-(ah, bh), dm1m
IF f = 57 THEN DIM dm2m(r): GET (1, 1)-(ah, bh), dm2m
IF f = 58 THEN DIM dm3(r): GET (1, 1)-(ah, bh), dm3
IF f = 59 THEN DIM dm3m(r): GET (1, 1)-(ah, bh), dm3m
IF f = 60 THEN DIM mdl(r): GET (1, 1)-(ah, bh), mdl
IF f = 61 THEN DIM mdr(r): GET (1, 1)-(ah, bh), mdr
IF f = 62 THEN DIM mdlm(r): GET (1, 1)-(ah, bh), mdlm
IF f = 63 THEN DIM mdrm(r): GET (1, 1)-(ah, bh), mdrm
IF f = 64 THEN DIM am1(r): GET (1, 1)-(ah, bh), am1
IF f = 65 THEN DIM am2(r): GET (1, 1)-(ah, bh), am2
IF f = 66 THEN DIM am3(r): GET (1, 1)-(ah, bh), am3
IF f = 67 THEN DIM fc(r): GET (1, 1)-(ah, bh), fc
IF f = 68 THEN DIM am3m(r): GET (1, 1)-(ah, bh), am3m
IF f = 69 THEN DIM g13(r): GET (1, 1)-(ah, bh), g13
IF f = 70 THEN DIM g14(r): GET (1, 1)-(ah, bh), g14
IF f = 71 THEN DIM g15(r): GET (1, 1)-(ah, bh), g15
IF f = 72 THEN DIM g16(r): GET (1, 1)-(ah, bh), g16
IF f = 73 THEN DIM g17(r): GET (1, 1)-(ah, bh), g17
IF f = 74 THEN DIM g18(r): GET (1, 1)-(ah, bh), g18
IF f = 75 THEN DIM g19(r): GET (1, 1)-(ah, bh), g19
IF f = 76 THEN DIM g20(r): GET (1, 1)-(ah, bh), g20
IF f = 77 THEN DIM g21(r): GET (1, 1)-(ah, bh), g21


ERASE dd
NEXT f
CLS
SCREEN , , 3, 3

mdat:
DATA "gr1","gr2","gr3","wcl","m11l","m12l","m11r","m12r","wod1","wod2"
DATA "m11lm","m12lm","m11rm","m12rm","man1","man2","t1r","t1l","t1rm","t1lm"
DATA "mr1r","mr2r","mr1l","mr2l","mr1rm","mr2rm","mr1lm","mr2lm","fir","firm"
DATA "luk1l","luk1r","luk1lm","luk1rm","cfon1","cfon2","cfon3","cfon4","cfon5","cfon6","cfon7","cfon8","cfon9"
DATA "tr1r","tr1l","tr1rm","tr1lm","bl1","bl2","bl3","bl1m","bl2m","bl3m"
DATA "dm1","dm2","dm1m","dm2m","dm3","dm3m","mdl","mdr","mdlm","mdrm"
DATA "amm1","amm2","amm3","face","amm3m","cfon10","cfon11"
DATA "cfon12","cfon13","cfon14","cfon15","cfon16","cfon17","cfon18","cfon19","cfon20"

RANDOMIZE 1000
intro = 1: inhod = 1: col = 7: cc = 1
REM LOCATE 10, 12: PRINT "Program modified": END
DIM a(200, 10)
DIM b(200, 10)
DIM x(100, 10): DIM y(100, 10)
vid = 3
vir = 2
GOSUB lod
a = 7: b = 6: h = 1: s = 1: hh = 1: hj = 0: fly = 0: op = 0: hod = 0
wh = 1
bx = 10: by = 10: dx = 4: dy = -.2: fire = 0
hodd = 0
brekhod = 0
DIM aa(100): DIM bb(100): DIM u(100): DIM s(100): DIM die(100)
f = 1

pow = 3: liv = 3: amm = 3: gold = 0: bom = 0

mig = 0: mag = 0
mdm = 0
FOR x = 1 TO 200
FOR y = 1 TO 10
IF a(x, y) = 6 THEN s(f) = -2.5: u(f) = 1: bb(f) = 1: aa(f) = x * 15: GOTO jj
IF a(x, y) = 7 THEN s(f) = -4: u(f) = 2: bb(f) = 1: aa(f) = x * 15: GOTO jj
IF a(x, y) = 8 THEN s(f) = -4: u(f) = 3: aa(f) = x * 15: bb(f) = y * 15: f = f + 1
jj0:
NEXT y
NEXT x
GOTO ser
jj:
IF b(aa(f) / 15, bb(f) / 15) = 1 THEN bb(f) = bb(f) - 15: GOTO jj2
bb(f) = bb(f) + 15
GOTO jj
jj2:
f = f + 1
GOTO jj0
ser:
FOR f = 1 TO 10
a$ = INKEY$
NEXT f

gg:
SCREEN , , vid, vir
SCREEN , , vid, vir
GOSUB act
SCREEN , vid, vid
vid = vid + 1: IF vid > 4 THEN vid = 2
vir = vir + 1: IF vir > 4 THEN vir = 2
GOTO gg


act:
IF a$ = " " AND intro = 1 THEN intro = 0: hod = 0
IF intro = 1 THEN hod = hod + inhod: IF hod > 91 OR hod < 1 THEN inhod = -inhod
IF hod < 2 AND hodd < 0 THEN hodd = 0
IF hod > 91 AND hodd > 0 THEN hodd = 0: brekhod = 1
IF hodd > 0 AND brekhod = 0 THEN hodd = hodd - 1: hod = hod + 1: a = a - 1: IF fire = 1 THEN bx = bx - 15
IF hodd < 0 AND brekhod = 0 THEN hodd = hodd + 1: hod = hod - 1: a = a + 1: IF fire = 1 THEN bx = bx + 15
act2:
bl = RND
FOR yy = 1 TO 10
PUT (0, yy * 15), wc, PSET
PUT (20 * 15, yy * 15), wc, PSET
NEXT yy
FOR x = 1 TO 19
FOR y = 1 TO 10
IF a(x + INT(hod), y) = 1 THEN PUT (x * 15, y * 15), g1, PSET: GOTO nn
IF a(x + INT(hod), y) = 2 THEN PUT (x * 15, y * 15), g2, PSET: GOTO nn
IF a(x + INT(hod), y) = 3 THEN PUT (x * 15, y * 15), g3, PSET: GOTO nn
IF a(x + INT(hod), y) = 4 AND wh = 1 THEN PUT (x * 15, y * 15), w1, PSET: GOTO nn
IF a(x + INT(hod), y) = 4 AND wh = -1 THEN PUT (x * 15, y * 15), w2, PSET: GOTO nn
IF a(x + INT(hod), y) = 5 AND bl <= .95 THEN PUT (x * 15, y * 15), m1, PSET: GOTO nn
IF a(x + INT(hod), y) = 5 AND bl > .95 THEN PUT (x * 15, y * 15), m2, PSET: GOTO nn
IF a(x + INT(hod), y) = 9 THEN PUT (x * 15, y * 15), g4, PSET: GOTO nn
IF a(x + INT(hod), y) = 10 THEN PUT (x * 15, y * 15), g5, PSET: GOTO nn
IF a(x + INT(hod), y) = 11 THEN PUT (x * 15, y * 15), g6, PSET: GOTO nn
IF a(x + INT(hod), y) = 12 THEN PUT (x * 15, y * 15), g7, PSET: GOTO nn
IF a(x + INT(hod), y) = 13 THEN PUT (x * 15, y * 15), g8, PSET: GOTO nn
IF a(x + INT(hod), y) = 14 THEN PUT (x * 15, y * 15), g9, PSET: GOTO nn
IF a(x + INT(hod), y) = 15 THEN PUT (x * 15, y * 15), g10, PSET: GOTO nn
IF a(x + INT(hod), y) = 16 THEN PUT (x * 15, y * 15), g11, PSET: GOTO nn
IF a(x + INT(hod), y) = 17 THEN PUT (x * 15, y * 15), g12, PSET: GOTO nn
IF a(x + INT(hod), y) = 18 THEN PUT (x * 15, y * 15), am1, PSET: GOTO nn
IF a(x + INT(hod), y) = 19 THEN PUT (x * 15, y * 15), am2, PSET: GOTO nn
IF a(x + INT(hod), y) = 20 THEN PUT (x * 15, y * 15), am3, PSET: GOTO nn
IF a(x + INT(hod), y) = 21 THEN PUT (x * 15, y * 15), g13, PSET: GOTO nn
IF a(x + INT(hod), y) = 22 THEN PUT (x * 15, y * 15), g14, PSET: GOTO nn
IF a(x + INT(hod), y) = 23 THEN PUT (x * 15, y * 15), g15, PSET: GOTO nn
IF a(x + INT(hod), y) = 24 THEN PUT (x * 15, y * 15), g16, PSET: GOTO nn
IF a(x + INT(hod), y) = 25 THEN PUT (x * 15, y * 15), g17, PSET: GOTO nn
IF a(x + INT(hod), y) = 26 THEN PUT (x * 15, y * 15), g18, PSET: GOTO nn
IF a(x + INT(hod), y) = 27 THEN PUT (x * 15, y * 15), g19, PSET: GOTO nn
IF a(x + INT(hod), y) = 28 AND bl > .7 THEN PUT (x * 15, y * 15), g21, PSET: GOTO nn
IF a(x + INT(hod), y) = 28 AND bl <= .7 THEN PUT (x * 15, y * 15), g20, PSET: GOTO nn
if a(x+int(hod),y-1)=28 or a(x+int(hod),y-1)=27 then put(x*15,y*15),wc,pset:gosub dddd:for ddt=1 to 10:ddx=rnd*5+5:ddy=rnd*ddd:pset (x*15+ddx,y*15+ddy),12:next ddt:goto nn
PUT (x * 15, y * 15), wc, PSET
nn:
NEXT y
IF mdm = 0 AND intro = 0 THEN GOSUB kli
NEXT x
IF intro = 1 THEN GOSUB intr: RETURN
IF a <> hh THEN h = -h: op = 1
IF op1 = 1 THEN op = 1
op1 = 0
hh = a
IF b(a + hod, b + .9) = 0 THEN fly = 1: b = b + hj: h = -1 ELSE fly = 0
IF b(a + hod, b + .8) <> 0 THEN b = b - .1: h = 1
IF b(a + hod, b - .5) <> 0 OR b < 1.5 THEN hj = .1
IF hj < .5 THEN hj = hj + .1
IF a(a + hod - .2, b + .8) = 5 THEN a(a + hod - .2, b + .8) = 0: gold = gold + 1: IF gold > 9 THEN gold = 0: liv = liv + 1
IF a(a + hod - .2, b + .8) = 18 THEN a(a + hod - .2, b + .8) = 0
IF a(a + hod - .2, b + .8) = 19 THEN a(a + hod - .2, b + .8) = 0: amm = amm + 1
IF a(a + hod - .2, b + .8) = 20 THEN a(a + hod - .2, b + .8) = 0: bom = bom + 1

IF mdm <> 0 THEN GOSUB md: GOTO mf
IF s = 1 AND h = 1 AND mig <> 1 THEN PUT (a * 15, b * 15), h1lm, AND: PUT (a * 15, b * 15), h1l, XOR
IF s = 1 AND h = -1 AND mig <> 1 THEN PUT (a * 15, b * 15), h2lm, AND: PUT (a * 15, b * 15), h2l, XOR
IF s = -1 AND h = 1 AND mig <> 1 THEN PUT (a * 15, b * 15), h1rm, AND: PUT (a * 15, b * 15), h1r, XOR
IF s = -1 AND h = -1 AND mig <> 1 THEN PUT (a * 15, b * 15), h2rm, AND: PUT (a * 15, b * 15), h2r, XOR
mf:
IF a > 15 THEN hodd = 8
IF a < 6 AND hod > 1 THEN hodd = -8
IF fly = 1 THEN GOSUB ts: IF t = 0 THEN a = a + s / 3
wsp = wsp + 1: IF wsp > 2 THEN wsp = 0: wh = -wh
IF fly = 0 THEN op = 0
IF brekhod = 0 THEN GOSUB mon
IF fire = 1 THEN IF bx / 15 > 20 OR bx / 15 < 1 THEN fire = 0: IF bom > 0 THEN bom = bom - 1
IF b(bx / 15 + hod, by / 15) <> 0 AND fire = 1 THEN fire = 0: IF bom > 0 THEN bom = bom - 1
IF fire = 1 AND bom <= 0 THEN PUT (bx, by), ffm, AND: PUT (bx, by), ff, XOR: bx = bx + dx
IF fire = 1 AND bom > 0 THEN PUT (bx, by), am3m, AND: PUT (bx, by), am3, XOR: bx = bx + dx
REM LOCATE 1, 1: PRINT mig; " "
ktm = ktm + 1
IF mig <> 0 THEN mig = mig + 1: IF mig > 3 THEN mig = 1
mag = mag - 1: IF mag < 0 THEN mig = 0
IF mdm > 20 THEN LOCATE 9, 14: COLOR 11: PRINT "Но это не конец"
GOSUB panel
RETURN

md:
IF s = -1 THEN PUT (a * 15, b * 15 + 1), mdrm, AND: PUT (a * 15, b * 15 + 1), mdr, XOR
IF s = 1 THEN PUT (a * 15, b * 15 + 1), mdlm, AND: PUT (a * 15, b * 15 + 1), mdl, XOR
mdm = mdm + 1: IF mdm = 50 THEN END
RETURN

kli:

_LIMIT 250

a$ = INKEY$
IF a$ = "e" THEN END
IF a$ = "o" AND fly = 0 THEN ktm = 0: s = -1: GOSUB ts: IF t = 0 THEN a = a - .2
IF a$ = "p" AND fly = 0 THEN ktm = 0: s = 1: GOSUB ts: IF t = 0 THEN a = a + .2
IF a$ = "q" AND fly = 0 AND b > 2 THEN hj = -.6: b = b - .2
IF a$ = "o" AND fly = 1 THEN op1 = 1: s = -1
IF a$ = "p" AND fly = 1 THEN op1 = 1: s = 1
IF a$ = "m" AND fire = 0 THEN fire = 1: GOSUB firs
RETURN

firs:
IF s = -1 THEN bx = a * 15 - 10: by = b * 15 + 5: dx = -10
IF s = 1 THEN bx = a * 15 + 10: by = b * 15 + 5: dx = 10
IF bom > 0 THEN by = b * 15
RETURN

ts:
t = 0
IF s = 1 THEN IF b(a + hod + .6, b + .6) = 1 THEN t = 1
IF s = -1 THEN IF b(a + hod - .6, b + .6) = 1 THEN t = 1
IF s = -1 AND a < 1.5 THEN t = 1
IF ktm > 2 AND op = 0 AND fly = 1 THEN t = 1
RETURN

mon:
FOR f = 1 TO 100
aaa = 0
IF hodd > 0 THEN aa(f) = aa(f) - 15: aaa = 15: FOR sz = 1 TO 10: x(f, sz) = x(f, sz) - 15: NEXT sz
IF hodd < 0 THEN aa(f) = aa(f) + 15: aaa = -15: FOR sz = 1 TO 10: x(f, sz) = x(f, sz) + 15: NEXT sz
IF die(f) <> 0 THEN GOSUB dm: GOTO ccc2
IF aa(f) / 15 > 1 AND aa(f) / 15 < 19 THEN GOTO ccc
GOTO ccc2
ccc:
IF fire = 1 AND die(f) = 0 AND bx > aa(f) - 5 AND bx < aa(f) + 20 AND by > bb(f) - 10 AND by < bb(f) + 15 THEN die(f) = -1: GOSUB bm: FOR sz = 1 TO 10: x(f, sz) = aa(f) + RND * 15: y(f, sz) = bb(f) + RND * 5: NEXT sz: GOTO ccc2
IF u(f) = 1 THEN GOSUB mon1
IF u(f) = 2 THEN GOSUB mon2
IF u(f) = 3 THEN GOSUB mon3
IF mig = 0 AND a > aa(f) / 15 - 1 AND a < aa(f) / 15 + 1 AND b > bb(f) / 15 - 1 AND b < bb(f) / 15 + 1 THEN mag = 50: mig = 1: pow = pow - 1: IF pow <= 0 THEN mdm = 1
ccc2:
IF die(f) <> 0 THEN die(f) = die(f) - 1: GOSUB mbl
IF die(f) = 0 THEN x(f, 1) = aa(f): y(f, 1) = bb(f)
NEXT f
RETURN

bm:
IF bom > 0 THEN fire = 1 ELSE fire = 0
RETURN

dm:
IF aa(f) / 15 > 1 AND aa(f) / 15 < 19 THEN GOTO dmm
RETURN
dmm:
IF u(f) = 3 AND bb(f) < 143 THEN yu = b(aa(f) / 15 + hod + aaa / 15, bb(f) / 15 + .9)
IF u(f) = 3 AND bb(f) < 143 AND a(aa(f) / 15 + hod + aaa / 15, bb(f) / 15) = 4 THEN bb(f) = bb(f) - RND: GOTO dmmm
IF u(f) = 3 AND yu <> 1 THEN bb(f) = bb(f) + 3
dmmm:
IF u(f) = 1 THEN PUT (aa(f) + aaa, bb(f)), dm1m, AND: PUT (aa(f) + aaa, bb(f)), dm1, XOR
IF u(f) = 2 THEN PUT (aa(f) + aaa, bb(f)), dm2m, AND: PUT (aa(f) + aaa, bb(f)), dm2, XOR
IF u(f) = 3 AND bb(f) < 143 THEN PUT (aa(f) + aaa, bb(f)), dm3m, AND: PUT (aa(f) + aaa, bb(f)), dm3, XOR
RETURN

mbl:
IF y(f, 1) > 150 THEN RETURN
FOR sz = 1 TO 10
FOR ssz = 1 TO 2
PSET (x(f, sz) + aaa + RND * 2, y(f, sz) + RND * 2 + 7), 12
PSET (x(f, sz) + aaa + RND * 2, y(f, sz) + RND * 2 + 7), 4
NEXT ssz
y(f, sz) = y(f, sz) - die(f) / 5 - 2
x(f, sz) = x(f, sz) + RND * 6 - 3
NEXT sz
RETURN

mon1:
IF b(aa(f) / 15 + hod + .5 + aaa / 15, bb(f) / 15 + 1) <> 1 THEN s(f) = -2.5
IF b(aa(f) / 15 + hod - .5 + aaa / 15, bb(f) / 15 + 1) <> 1 THEN s(f) = 2.5
IF b(aa(f) / 15 + hod + .5 + aaa / 15, bb(f) / 15) = 1 THEN s(f) = -2.5
IF b(aa(f) / 15 + hod - .5 + aaa / 15, bb(f) / 15) = 1 THEN s(f) = 2.5

aa(f) = aa(f) + s(f)
IF s(f) = 2.5 AND wh = 1 THEN PUT (aa(f) + aaa, bb(f) - 5), t1rm, AND: PUT (aa(f) + aaa, bb(f) - 5), t1r, XOR
IF s(f) = 2.5 AND wh = -1 THEN PUT (aa(f) + aaa, bb(f) - 5), tr1lm, AND: PUT (aa(f) + aaa, bb(f) - 5), tr1l, XOR
IF s(f) = -2.5 AND wh = 1 THEN PUT (aa(f) + aaa, bb(f) - 5), t1lm, AND: PUT (aa(f) + aaa, bb(f) - 5), t1l, XOR
IF s(f) = -2.5 AND wh = -1 THEN PUT (aa(f) + aaa, bb(f) - 5), tr1rm, AND: PUT (aa(f) + aaa, bb(f) - 5), tr1r, XOR
RETURN

mon2:
IF b(aa(f) / 15 + hod + .5 + aaa / 15, bb(f) / 15 + 1) <> 1 THEN s(f) = -4
IF b(aa(f) / 15 + hod - .5 + aaa / 15, bb(f) / 15 + 1) <> 1 THEN s(f) = 4
IF b(aa(f) / 15 + hod + .5 + aaa / 15, bb(f) / 15) = 1 THEN s(f) = -4
IF b(aa(f) / 15 + hod - .5 + aaa / 15, bb(f) / 15) = 1 THEN s(f) = 4

aa(f) = aa(f) + s(f)
IF s(f) = 4 AND wh = 1 THEN PUT (aa(f) + aaa, bb(f)), mr1rm, AND: PUT (aa(f) + aaa, bb(f)), mr1r, XOR
IF s(f) = 4 AND wh = -1 THEN PUT (aa(f) + aaa, bb(f)), mr2rm, AND: PUT (aa(f) + aaa, bb(f)), mr2r, XOR
IF s(f) = -4 AND wh = 1 THEN PUT (aa(f) + aaa, bb(f)), mr1lm, AND: PUT (aa(f) + aaa, bb(f)), mr1l, XOR
IF s(f) = -4 AND wh = -1 THEN PUT (aa(f) + aaa, bb(f)), mr2lm, AND: PUT (aa(f) + aaa, bb(f)), mr2l, XOR
RETURN

mon3:
IF b(aa(f) / 15 + hod + .5 + aaa / 15, bb(f) / 15) = 1 THEN s(f) = -4
IF b(aa(f) / 15 + hod - .5 + aaa / 15, bb(f) / 15) = 1 THEN s(f) = 4
IF b(aa(f) / 15 + hod + .5 + aaa / 15, bb(f) / 15 + 1) = 1 THEN s(f) = -4
IF b(aa(f) / 15 + hod - .5 + aaa / 15, bb(f) / 15 + 1) = 1 THEN s(f) = 4

IF aa(f) / 15 > 18 THEN s(f) = -4
IF aa(f) / 15 < 2 THEN s(f) = 4
aa(f) = aa(f) + s(f)
IF s(f) = 4 THEN PUT (aa(f) + aaa, bb(f)), lkrm, AND: PUT (aa(f) + aaa, bb(f)), lkr, XOR
IF s(f) = -4 THEN PUT (aa(f) + aaa, bb(f)), lklm, AND: PUT (aa(f) + aaa, bb(f)), lkl, XOR
RETURN

intr:
LOCATE 1, 1: PRINT "  Press ~SPACE~"
FOR f = 0 TO 14
FOR y = 0 TO 10
FOR x = 0 + f * 8 TO 7 + f * 8
aa = POINT(x, y)
IF aa <> 0 THEN PSET (x + 105, y + 120), 4
IF aa <> 0 AND RND > y / 10 THEN PSET (x + 105, y + 120), 12
NEXT x
NEXT y
NEXT f
LOCATE 1, 1: PRINT " * DEMO *       "
FOR y = 0 TO 10
FOR x = 0 TO 72
aa = POINT(x, y)
FOR vb = 1 TO 6
IF aa <> 0 THEN PSET (x * 2 + 90 + RND * 2, y * 2 + 20 + RND * (y + 2)), 12
NEXT vb
NEXT x
NEXT y
LOCATE 1, 1: PRINT "              ": COLOR 15
a$ = INKEY$
RETURN

panel:
PUT (16, 0), fc, PSET
LOCATE 2, 6: PRINT "*"; liv
PUT (76, 0), am1, PSET
LOCATE 2, 13: PRINT "*"; pow
PUT (136, 0), am3, PSET
LOCATE 2, 20: PRINT "*"; bom
PUT (196, 0), m1, PSET
LOCATE 2, 28: PRINT "*"; gold
PUT (256, 0), am2, PSET
LOCATE 2, 36: PRINT "*"; amm
RETURN


dddd:
ddd=1
ddd1:
if rnd>.9 then return
ddd=ddd+1:if ddd>15 then return
goto ddd1

lod:
OPEN "demap.vir" FOR INPUT AS #2
FOR sx = 1 TO 200
FOR sy = 1 TO 10
INPUT #2, a(sx, sy)
INPUT #2, b(sx, sy)
NEXT sy
NEXT sx
CLOSE #2
RETURN






