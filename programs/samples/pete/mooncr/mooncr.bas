REM - written for QBasic / QuickBasic (freeware) -
REM - V.26
REM - by Daniel Kupfer
REM - for more info look at the end / press f1 in title
REM - any problems / questions ? mail: dk1000000@aol.com

SCREEN 7
DEFINT A-Z
scx = 159: scy = 99
xp = scx: yp = 172: vp = 6: vsh = 6
xpmin = 0: xpmax = 319: shmax = 15: emax = 7: esmax = 3: fmax = 15
stmax = 31: exmax = 7
SND = 1: bonplay& = 20000
pi! = 3.14158: pi2! = pi! / 2: pi4! = pi! / 4
cts1 = 0: cts2 = 4: cts3 = 10

DIM tae(201), tne(201): n = shmax
DIM xsh(n), ysh(n): n = stmax
DIM xst(n), yst(n), xst!(n), yst!(n), cst(n), vst(n): n = emax
DIM xe!(n), ye!(n), ae(n), dae(n), ne(n), ce(n), ste(n)
DIM ze(n), zze(n), tpe(n), tce(n): n = exmax
DIM xex(n), yex(n), stex(n), zex(n), tex(n): n = esmax
DIM xes!(n), yes!(n), dxes!(n), dyes!(n), stes(n), tes(n)
DIM aes(n), des(n): n = fmax
DIM fx!(n), fy!(n), dfx!(n), dfy!(n), fc(n), ft(n): n = 11
DIM ptse(n), dble(n), anie(n), adde(n), zoome(n)
DIM table(n), c1e(n), c2e(n), expe(n), c1ee(2, n), c2ee(2, n): n = 7
DIM tce0(n), xec(n), yec(n), aec(n): n = 12
DIM xc!(n), yc!(n), zc!(n), cc(n), ac(n), nc(n)
DIM ENEMY$(20, 3), CRASH$(4), bin(4), CH$(42): n = 7
DIM vbos(n), vsbos(n), tsbos(n), fsbos(n), ptsbos(n), hrbos(n)
DIM BOSS$(n), STAGE$(n)
DIM cp(95), SFINAL$(2, 9), CREDIT$(50)
A5$ = STRING$(4, CHR$(170)) + STRING$(4, CHR$(85))
     
FOR e = 1 TO 11: READ p, d, m, a, z, T, ex
ptse(e) = p: dble(e) = d: anie(e) = m: adde(e) = a: zoome(e) = z
table(e) = T: expe(e) = ex: NEXT e
DATA 10,0,0,0,64,1,1, 20,0,0,0,64,2,1, 25,0,0,0,64,2,1
DATA 40,0,0,0,64,5,1, 50,0,0,0,64,4,1, 200,0,0,0,64,6,1
DATA 250,0,0,0,64,7,1, 100,1,0,1,64,2,1, 120,0,0,0,64,3,1
DATA 120,1,3,1,64,2,1, 160,0,2,0,48,3,1

FOR s = 0 TO 2
FOR e = 1 TO 11: READ c1, c2: c1ee(s, e) = c1: c2ee(s, e) = c2: NEXT e: NEXT s
DATA 7,13, 6,14, 5,15, 5,11, 3,15, 2,10, 2,10, 4,12, 1,14, 2,14, 9,15
DATA 4,13, 2,10, 1,4,  7,15, 4,14, 3,11, 3,11, 5,13, 2,15, 2,14, 9,15
DATA 5,14, 3,11, 2,14, 12,14, 14,4, 4,12, 4,12, 6,14, 3,15, 6,14, 4,12

REM  - - - - BOSS SETUP - - - - - -

FOR n = 1 TO 7: READ a$, s$: BOSS$(n) = a$: STAGE$(n) = s$: NEXT n
DATA "MYKOR MASTER","VEGA SYSTEM","PHOENIX","ALPHA CENTAURI"
DATA "EVIL BATSY","DARK PLANET","QUARRIOR","AQUARUIS"
DATA "MC FISHKING","NEPTUN","BEEBOP QUEEN","MOONBASE"
DATA "MOTHERSHIP","EARTH"
FOR n = 1 TO 7: READ v, ts, f, p, r: vbos(n) = v: tsbos(n) = ts
fsbos(n) = f: ptsbos(n) = p: hrbos(n) = r: NEXT n
DATA 1,1,4,1000,20, 1,4,6,2500,20, 2,1,8,4000,20, 1,5,10,7500,20
DATA 1,3,100,10000,24, 2,2,10,16000,20, 1,0,0,25000,40
FOR n = 0 TO 3: READ c: csb(n) = c: NEXT n
DATA 4,12,14,10

REM  - - - - ESHOT SETUP - - - -
FOR n = 1 TO 5: READ v, d: ves(n) = v: ses(n) = d: NEXT n
DATA 5,2, 4,2, 2,4, 3,2, 3,2

n = 1
DO: READ a, T: tae(n) = a: tne(n) = T: n = n + 1
LOOP UNTIL a = -1 AND T = -1
nte = n - 1
PATTERN1:
DATA 0,100, -900,1, 0,32, -900,1, 0,50, -900,1, 0,8, -900,1
DATA 0,70, 900,1, 0,10, 900,1, 0,50, -900,1, 30,60 ,0,90
DATA 30,30, 0,50, 900,1, 0,14, 900,1, 0,20, 900,1, 0,16
DATA 900,1, 0,20, 900,1, 0,14, 900,1, 0,20, 900,1, 0,16
DATA 900,1, 0,20, 900,1, 0,14, 900,1, 0,40, 900,2, 0,0
PATTERN2:
DATA -30,30, 30,75, 0,34, -30,95, 0,34, 30,95, 0,34, -30,95
DATA  0,34, 30,95, 0,34, -30,95, 0,34, 30,50, 0,25, 30,30
DATA  0,60, 60,30, 0,110, -60,31, 0,90, 60,31, 0,60, -60,32
DATA  0,30, 60,32, 30,28, 0,20, 0,0, 0,0, 0,0, 0,0
PATTERN3:
DATA -90,20, 90,30, -90,30, 90,20, -90,20, 90,40, 90,10, -90,20
DATA  90,20, -90,30, 90,20, -90,20, 90,20, -90,21, 0,20, 0,0
DATA  90,20, -90,30, 90,30, -90,20, 90,20, -90,40, -90,10, 90,20
DATA -90,20, 90,30, -90,20, 90,20, -90,20, 90,21, 0,20, 0,0
PATTERN4:
DATA  30,60, -30,-30, 30,60, 0,40, 30,20, 0,30, 30,90, -30,90
DATA -30,90, 30,45, 0,20, -30,15, 0,10, 30,15, -30,15, 30,15
DATA  0,80, 30,5, 0,40, 30,5, 0,40, 30,5, 0,40, 30,5
DATA  0,40, 30,180, 0,120, 0,0, 0,0, 0,0, 0,0, 0,0
PATTERN5:
DATA  0,130, 30,60, 0,105, 90,20, 0,60, -90,20, 0,20, 90,20
DATA  0,60, 90,10, 0,80, 90,20, 0,80, -90,20, 0,80, 90,20
DATA  0,60, 30,270, 0,50, 0,0, 0,0, 0,0, 0,0, 0,0
PATTERN6:
DATA  -30,85, 0,50, 30,0, -30,80, 0,60, 30,80, 0,60, -30,80
DATA  0,60, 30,80, 0,60, -30,80, 0,60, 30,50, 0,25, 30,30
DATA  0,60, 60,30, 0,110, -60,31, 0,90, 60,31, 0,60, -60,32
DATA  0,30, 60,32, 30,28, 0,20, 0,0, 0,0, 0,0, 0,0
PATTERN7:
DATA -30,60, 0,80, 0,0, 0,0, 30,60, 0,80, 0,0, 0,0
DATA -1,-1

FOR n = 1 TO 7: READ T, x, y, a, v, c: tce0(n) = T: xec(n) = x: yec(n) = y
aec(n) = a: vec(n) = v: crec(n) = c: NEXT n
DATA 0,0,20,0,4,7, 40,159,119,900,4,7
DATA 72,159,119,900,4,7, 104,149,109,900,4,7
DATA 136,320,20,1800,4,7
DATA 160,159,50,900,4,7, 192,159,50,900,4,7

FOR n = 0 TO 9: READ x, y: pcx(n) = x: pcy(n) = y: NEXT n
DATA 0,-2, -10,-2, 10,-2, -10,3, 10,3
DATA 0,-5, -14,-4, 14,-4, -14,3, 14,3

RANDOMIZE TIMER
GOSUB LOAD.SPRITES
GOSUB LOAD.SOUNDS
GOSUB LOAD.CHARSET

FOR n = 0 TO shmax: ysh(n) = -1: NEXT n
FOR n = 0 TO stmax: GOSUB CREATE.STAR: NEXT n
FOR n = 0 TO emax: ste(n) = -1: ce(n) = 2: NEXT n
FOR n = 0 TO esmax: stes(n) = -1: NEXT n


REM - - - - - - - - TITLE SCREEN - - - - - - - -
x = -40: zmax = 40
FOR n = 0 TO 7: READ nc, cc
xc!(n) = x: yc!(n) = 26: zc!(n) = 200: nc(n) = nc: cc(n) = cc
x = x + 7: NEXT n
FOR n = 8 TO 9: READ nc, cc
xc!(n) = x + 55: yc!(n) = yc!(1) + 30: zc!(n) = zmax: nc(n) = nc: cc(n) = cc
x = x + 7: NEXT n
DATA 29,15, 31,15, 31,15, 30,15, 19,15, 34,15, 17,15, 32,15, 9,15, 9,15

REM  - - - LEVEL SETUP - - -
FOR n = 1 TO 9: READ T, r, s, h
ltpe(n) = T: lrad(n) = r: lsum(n) = s: lhit(n) = h: NEXT n
DATA 1,14,1,1, 1,14,2,1, 2,12,2,1, 3,12,2,1
DATA 4,12,2,1, 5,14,2,1, 8,16,1,3, 10,14,1,3
DATA 6,12,4,1

RESTORE CREDITS
FOR n = 1 TO 34: READ a$: CREDIT$(n) = a$: NEXT n

x = 100: y = 100: c1 = 6: c2 = 14: a = 0: z = 4
e = 6: f = 0: GOSUB DRAW.ESPRITE
REM END
 
GOSUB WAITKEY0: GOSUB TITLE

STAGE = 1: LEVEL = 1: stbos = -1: tbos = 1
GOSUB LOAD.LEVEL
REM                        ---> player setup
ssec(1) = 1: ssec(2) = 0: ssec(3) = 0: GOSUB SETUP.SHIP
stp = 0:                    REM status player
score& = 0
GOSUB DRAW.PLAYER1
n = INT(2 * RND)
IF n = 0 AND SND = 1 THEN PLAY SLAUNCH$
IF n = 1 AND SND = 1 THEN PLAY SNEWPL1$
GOSUB WAITFIRE: REM GOTO GAME.FINISH
GOSUB ENTER.STAGE

MAIN:
k0 = k: k = INP(96): k$ = INKEY$
IF k = 1 THEN END
IF k = 31 THEN SND = 1 - SND: GOSUB WAITKEY0
IF k = 25 THEN GOSUB PAUSE.MODE
IF k = 29 AND k0 <> 29 THEN GOSUB FIRE.SHOT
GOSUB KEYS
GOSUB MOVE.PLAYER
GOSUB MOVE.SHOT
GOSUB MOVE.ENEMY
GOSUB MOVE.BOSS
GOSUB MOVE.ESHOT
GOSUB REFR.SCREEN
WAIT &H3DA, 8: WAIT &H3DA, 8, 8
GOSUB DRAW.ESHOT
GOSUB DRAW.ENEMY
GOSUB DRAW.BOSS
GOSUB TEST.HIT.SHOT
GOSUB TEST.HIT.PLAYER
GOSUB DRAW.SHOT
GOSUB DRAW.EVENT
GOSUB DRAW.PLAYER
GOSUB DRAW.EXP
GOSUB DRAW.STAR
LOCATE 1, 30: PRINT score&
GOSUB CREATE.ESHOT
crec1 = crec1 - 1: IF crec1 = 0 THEN crec1 = crec0: GOSUB CREATE.ENEMY
cnt1 = (cnt1 + 1) AND 255
GOSUB BINARY.CNT
GOSUB TEST.LEVELEND
REM GOSUB DOCKING
GOTO MAIN


MOVE.BOSS:
IF stbos < 0 THEN RETURN
xbos! = xbos! + dxbos!: ybos! = ybos! + dybos!
IF hbos = 1 AND ybos! > 10 AND tbos < 7 THEN ybos! = ybos! - 3
IF xbos! < 10 THEN dxbos! = 1
IF xbos! > 309 THEN dxbos! = -1
IF ybos! < 10 THEN dybos! = 1
IF ybos! > 99 THEN dybos! = -1
GOSUB SHOT.BOSS
IF INT(100 * RND) < 1 THEN GOSUB ACTIV.BOSS
RETURN

SHOT.BOSS:
IF tbos = 7 THEN GOTO SHOT.SUPERBOSS
r = fsbos(tbos) * STAGE
IF INT(1000 * RND) > r THEN RETURN
x = xbos!: y = ybos!: T = tsbos(tbos): s = ses(T)
IF T = 3 THEN s = 2 + INT(5 * RND)
GOSUB FIRE.ESHOT
RETURN

SHOT.SUPERBOSS:
GOSUB CREATE.SUPERENEMY
RETURN

CREATE.SUPERENEMY:
IF INT(8 * RND) > 0 THEN RETURN
n = (eptr + 1) AND emax: IF ste(n) <> -1 THEN RETURN
T = tpe + 1: mt = table(T)
ye!(n) = ybos!: ae(n) = 900 + 180 * RND - 90
xe!(n) = xbos!
ze(n) = 64: zze(n) = zoome(T)
ste(n) = 0: tpe(n) = T
tce(n) = tce0(mt) + INT(2 * RND) * 4
GOSUB LOADPTR.ENEMY
RETURN

ACTIV.BOSS:
a! = INT(8 * RND) * pi4!
dxbos! = COS(a!) * vbos(tbos): dybos! = SIN(a!) * vbos(tbos)
IF tbos = 7 THEN dybos! = 0
RETURN

DRAW.BOSS:
IF stbos = -1 THEN RETURN
IF stbos < 0 THEN GOTO DRAW.BOSS1
x = xbos!: y = ybos!
ON tbos GOSUB DBOSS1, DBOSS2, DBOSS3, DBOSS4, DBOSS5, DBOSS6, DBOSS7
IF bin(1) = 0 THEN hbos = 0
RETURN
DRAW.BOSS1:
stbos = stbos + 1: GOSUB DRAW.BDOTS
IF stbos < -100 AND SND = 1 THEN SOUND 37 + 120 * RND, .4
IF stbos = -90 THEN GOTO DRAW.BOSS2
IF stbos > -96 AND stbos < -48 AND PLAY(0) = 0 AND SND = 1 THEN PLAY SBOSPTS$
RETURN
DRAW.BOSS2:
FOR e = 0 TO emax: ste(e) = -1: NEXT e: cresum = 0
pts& = ptsbos(tbos): GOSUB LOAD.SCORE
evcnt = 50: evpts = pts&: evtpe = 1
RETURN
                   
DRAW.BDOTS:
FOR m = 0 TO fmax
x = fx!(m): y = fy!(m)
LINE (x, y)-(x + 1, y + 1), fc(m), BF
fx!(m) = fx!(m) + dfx!(m): fy!(m) = fy!(m) + dfy!(m)
NEXT m
RETURN

DRAW.EVENT:
IF evcnt <= 0 THEN RETURN
evcnt = evcnt - 1: yc! = 70: ac = 0: sc = 4: T$ = evtxt$
IF evtpe = 1 THEN xc! = 160: i = evpts: cc = 15 * RND: GOSUB DRAW.INTF
IF evtpe = 2 THEN xc! = 159 - LEN(T$) * 4: cc = 15: GOSUB DRAW.TXTZ
RETURN

BINARY.CNT:
bin(1) = 1 - bin(1): b2 = bin(2): b3 = bin(3)
IF bin(1) = 0 THEN bin(2) = 1 - bin(2)
IF bin(2) < b2 THEN bin(3) = 1 - bin(3)
IF bin(3) < b3 THEN bin(4) = 1 - bin(4)
RETURN

TEST.LEVELEND:
IF emovcnt > 0 OR expcnt > 0 OR stbos <> -1 THEN etimer = 0: RETURN
etimer = etimer + 1: IF etimer < 25 THEN RETURN
etimer = 0
IF (LEVEL AND 7) = 5 THEN GOSUB DOCKING:                REM level 3 + 7
GOSUB ADVANCE.LEVEL
GOTO MAIN

PAUSE:
DO: WAIT &H3DA, 8: WAIT &H3DA, 8, 8: c = c - 1: LOOP UNTIL c = 0
RETURN

WAITFIRE:
GOSUB WAITKEY0
t0! = TIMER
DO
k = INP(96): k$ = INKEY$
t1! = TIMER - t0!
LOOP UNTIL k = 29 OR t1! > 4
GOSUB WAITKEY0
RETURN

KEYS:
REM IF k0 = 75 OR k0 = 77 THEN RETURN
IF k = 75 THEN dxp = -vp: k1 = 203
IF k = 77 THEN dxp = vp: k1 = 205
IF k = k1 THEN dxp = 0
RETURN

MOVE.PLAYER:
IF stp < 0 THEN GOTO CREATE.PLAYER
xp = xp + dxp
IF xp > xpmax THEN xp = xpmax
IF xp < xpmin THEN xp = xpmin
RETURN

CREATE.PLAYER:
IF stp < -1 THEN RETURN
stp = 0: f = 0
FOR q = 1 TO 3
IF ssec(q) > -1 THEN f = 1
IF ssec(q) = 0 THEN ssec(q) = 1: f = 1: EXIT FOR
NEXT q
IF f = 0 THEN stp = 1
IF f = 1 AND SND = 1 THEN PLAY SNEWPL2$
GOSUB SETUP.SHIP
RETURN

SETUP.SHIP:
sss0 = 0: sss1 = 0: s = 0
IF ssec(1) = 1 THEN s = s OR 1
IF ssec(2) = 1 THEN s = s OR 2
IF ssec(3) = 1 THEN s = s OR 2
IF s = 3 THEN sss0 = 1
IF s = 2 THEN sss1 = 1
RETURN

FIRE.SHOT:
IF stp > 0 THEN RETURN
IF sss0 = 1 THEN sss1 = 1 - sss1
IF sss1 = 0 AND ssec(1) = 1 THEN GOSUB FIRE.SHOT1: s = 1
IF sss1 = 1 AND ssec(2) = 1 THEN GOSUB FIRE.SHOT2: s = 2
IF sss1 = 1 AND ssec(3) = 1 THEN GOSUB FIRE.SHOT3: s = 2
RETURN
FIRE.SHOT1:
IF ysh(cts1) > 0 THEN RETURN
xsh(cts1) = xp: ysh(cts1) = yp - 4
cts1 = cts1 + 1: IF cts1 = 4 THEN cts1 = 0
IF PLAY(0) = 0 AND SND = 1 THEN PLAY SLASER1$
RETURN
FIRE.SHOT2:
IF ysh(cts2) > 0 OR ysh(cts2 + 1) > 0 THEN RETURN
xsh(cts2) = xp - 9: ysh(cts2) = yp + 3
xsh(cts2 + 1) = xp + 9: ysh(cts2 + 1) = yp + 3
cts2 = cts2 + 2: IF cts2 = 10 THEN cts2 = 4
IF PLAY(0) = 0 AND SND = 1 THEN PLAY SLASER2$
RETURN
FIRE.SHOT3:
IF ysh(cts3) > 0 OR ysh(cts3 + 1) > 0 THEN RETURN
xsh(cts3) = xp - 14: ysh(cts3) = yp + 10
xsh(cts3 + 1) = xp + 14: ysh(cts3 + 1) = yp + 10
cts3 = cts3 + 2: IF cts3 = 16 THEN cts3 = 10
IF PLAY(0) = 0 AND SND = 1 THEN PLAY SLASER2$
RETURN

REFR.SCREEN:
WAIT &H3DA, 8, 8: WAIT &H3DA, 8
scr = 1 - scr: SCREEN 7, 0, 1 - scr, scr: CLS
RETURN
REFR.DOCKSCREEN:
WAIT &H3DA, 8, 8: WAIT &H3DA, 8
scr = 1 - scr: SCREEN 7, 0, 1 - scr, scr
VIEW (1, 25)-(318, 198), 0, 0: VIEW
RETURN

MOVE.SHOT:
FOR n = 0 TO shmax: ys = ysh(n)
IF ys < 0 THEN GOTO MOVE.SHOT1
   ys = ys - vsh: ysh(n) = ys
MOVE.SHOT1:
NEXT n

MOVE.ENEMY:
emovcnt = 0
FOR n = 0 TO emax
IF ste(n) < 0 THEN GOTO MOVE.ENEMY1
ne(n) = ne(n) - 1: IF ne(n) <= 0 THEN GOSUB LOADPTR.ENEMY
 a! = ae(n) * (pi! / 1800): emovcnt = emovcnt + 1
 dx! = COS(a!) * vec: dy! = -SIN(a!) * vec
 xe!(n) = xe!(n) + dx! / 2: ye!(n) = ye!(n) + dy! / 2
 ae(n) = (ae(n) + dae(n)) MOD 3600
 IF ze(n) < zze(n) THEN ze(n) = ze(n) + 1
 IF ABS(xe!(n) - scx) > 180 OR ABS(ye!(n) - scy) > 120 THEN GOSUB RESET.ENEMY
MOVE.ENEMY1:
NEXT n
RETURN
 
MOVE.ESHOT:
FOR n = 0 TO esmax
IF stes(n) < 0 THEN GOTO MOVE.ESHOT1
 xes!(n) = xes!(n) + dxes!(n): yes!(n) = yes!(n) + dyes!(n)
 aes(n) = aes(n) + 1
 IF ABS(xes!(n) - scx) > 160 OR ABS(yes!(n) - scy) > 100 THEN stes(n) = -1
MOVE.ESHOT1:
NEXT n
RETURN

DRAW.ESHOT:
FOR n = 0 TO esmax
IF stes(n) < 0 THEN GOTO DRAW.ESHOT1
 x = xes!(n): y = yes!(n): a = aes(n): d = des(n)
 T = tes(n)
 ON T GOSUB DESHOT1, DESHOT2, DESHOT3, DESHOT4, DESHOT5
DRAW.ESHOT1:
NEXT n
RETURN

DESHOT1:
c = 1
LINE (x - 1, y - 2)-(x + 1, y + 2), c, B
LINE (x, y - 3)-(x, y + 3), c
LINE (x, y - 2)-(x, y + 2), 15
RETURN
DESHOT2:
CIRCLE (x, y), d, 4: PAINT (x, y), 10, 4
RETURN
DESHOT3:
f! = 1 + SIN(a / 4) * .4: f2! = d * .7
CIRCLE (x, y), d + .5, 7, , , f!
CIRCLE (x, y), d, 15, , , f!
LINE (x - d * .1 / f! - 1, y - d * .3 * f!)-(x - 1, y), 7, B
RETURN
DESHOT4:
a = (a * 30) MOD 360: z = 4: c = 15: e = 1: GOSUB DRAW.SSPRITE
RETURN
DESHOT5:
a = (a * 9) MOD 360: z = 4: c = 15: e = 2: GOSUB DRAW.SSPRITE
RETURN

CREATE.ESHOT:
IF STAGE <= 1 THEN RETURN
r = (20 / STAGE) * RND: IF r > 0 THEN RETURN
e = INT((emax + 1) * RND)
IF ye!(e) > 80 OR ste(e) < 0 THEN RETURN
x = xe!(e): y = ye!(e)
T = 1 - (tpe = 10): s = ses(T): GOSUB FIRE.ESHOT
RETURN
FIRE.ESHOT:
escnt = (escnt + 1) AND esmax: n = escnt
IF stes(n) > -1 THEN RETURN
 xes!(n) = x: yes!(n) = y: v = ves(T)
 a! = pi2! - (pi! / 8) * RND + pi4!: dx! = COS(a!) * v: dy! = SIN(a!) * v
 IF SGN(xp - x) <> SGN(dx!) THEN dx! = -dx!
 dxes!(n) = dx!: dyes!(n) = dy!
 stes(n) = 0: tes(n) = T: aes(n) = 0: des(n) = s
IF PLAY(0) > 0 OR SND = 0 THEN RETURN
ON T GOSUB SESHOT1, SESHOT2, SESHOT3, SESHOT3, SESHOT3
RETURN

SESHOT1:
PLAY SSHOOT2$: RETURN
SESHOT2:
PLAY SSHOOT2$: RETURN
SESHOT3:
PLAY SSHOOT3$: RETURN

RESET.STAR:
xst(n) = 320 * RND: yst(n) = 0 * RND: cst(n) = INT(15 * RND) + 1
RETURN
CREATE.STAR:
xst(n) = 320 * RND: yst(n) = 200 * RND: cst(n) = INT(8 * RND)
RETURN

RESET.ENEMY:
IF tbos = 7 THEN GOSUB RESET.SUPERENEMY
mt = table(tpe)
xe!(n) = xec(mt): ye!(n) = yec(mt): ze(n) = 9
RETURN
RESET.SUPERENEMY:
IF (n AND 1) = 1 THEN ste(n) = -1
RETURN

CREATE.ENEMY:
n = eptr: eptr = (eptr + 2) AND emax
IF ste(n) <> -1 THEN RETURN
crecnt = crecnt + 1: IF crecnt > cresum THEN RETURN
T = tpe: mt = table(T)
xe!(n) = xec(mt): ye!(n) = yec(mt): ae(n) = aec(mt)
ze(n) = 9: zze(n) = zoome(T)
ste(n) = 0: tpe(n) = T: tce(n) = tce0(mt)
GOSUB LOADPTR.ENEMY
IF PLAY(0) = 0 AND SND = 1 THEN PLAY SNEW1$
RETURN

LOADPTR.ENEMY:
c = tce(n): dae(n) = tae(c): ne(n) = tne(c)
c = c + 1: IF tae(c) = 0 AND tne(c) = 0 THEN c = tce0(mt)
tce(n) = c
RETURN

DRAW.STAR:
dy = (cnt1 AND 1)
FOR n = 0 TO stmax
x = xst(n): y = yst(n): c = cst(n): y = y + dy
IF POINT(x, y) = 0 THEN PSET (x, y), c
yst(n) = y: IF y > 200 THEN GOSUB RESET.STAR
NEXT n
stcnt = (stcnt + 1) AND stmax: n = stcnt
IF INT(2 * RND) = 0 THEN n = stmax * RND: GOSUB CREATE.STAR
RETURN

DRAW.PLAYER:
IF stp > 0 THEN GOTO DRAW.GAMEOVER
IF stp < 0 THEN GOTO DRAW.SHIPEXPLODE
IF ssec(1) = 1 THEN x = xp: y = yp + 0: c = 4: GOSUB DRAW.SHIP1
IF ssec(2) = 1 THEN x = xp: y = yp + 6: c = 9: GOSUB DRAW.SHIP2
IF ssec(3) = 1 THEN x = xp: y = yp + 15: c = 5: GOSUB DRAW.SHIP3
RETURN

DRAW.ESTAR:
FOR n = 0 TO stmax
x = xst(n): y = yst(n): c = cst(n)
x = x + 1: IF x > 320 THEN x = 0: yst(n) = 10 + 180 * RND
PSET (x, y), c: xst(n) = x
NEXT n
c = 12 + INT(4 * RND): IF c = 13 OR c < 12 THEN c = 0
n = stmax * RND: cst(n) = c
RETURN


DRAW.SHIPEXPLODE:
stp = stp + 1: IF stp > -10 THEN RETURN
x0 = xp: y0 = yp + 6
IF SND = 1 THEN SOUND 37 + f1! * RND, .5
f1! = f1! * .85
FOR n = 1 TO 5
x = fx!(n): y = fy!(n): a = ft(n): c = fc(n): z = dfx!(n)
e$ = CRASH$(1): GOSUB DRAW.SPRITE
NEXT n
IF bin(2) = 1 THEN GOSUB CREATE.SHIPEXPLODE
RETURN

CREATE.SHIPEXPLODE:
FOR n = 1 TO 5
fx!(n) = x0 + 24 * RND - 12: fy!(n) = y0 + 14 * RND - 7
ft(n) = 360 * RND: c = 12 + INT(4 * RND): IF c = 13 THEN c = 15
fc(n) = c: dfx!(n) = INT(3 * RND) + 2
NEXT n
RETURN

DRAW.SHIP1:
LINE (x, y - 3)-(x - 6, y + 3), c
LINE (x, y - 3)-(x + 6, y + 3), c
LINE (x - 6, y + 4)-(x + 6, y + 4), c
PAINT (x, y), c, c
REM c = SGN(cnt1 AND 8) * 14
LINE (x, y + 0)-(x, y + 2), 14
LINE (x - 5, y + 5)-(x - 5, y + 5), c
LINE (x + 5, y + 5)-(x + 5, y + 5), c
RETURN
DRAW.SHIP2:
LINE (x - 4, y - 1)-(x + 4, y + 4), c, BF
LINE (x - 10, y - 2)-(x - 9, y + 3), c, B
LINE (x + 9, y - 2)-(x + 10, y + 3), c, B
LINE (x - 9, y + 4)-(x + 9, y + 4), c
LINE (x - 1, y + 0)-(x - 1, y + 2), 14
LINE (x + 1, y + 0)-(x + 1, y + 2), 14
RETURN
DRAW.SHIP3:
LINE (x - 8, y)-(x - 4, y - 4), c
LINE (x - 4, y - 4)-(x + 4, y - 4), c
LINE (x + 4, y - 4)-(x + 8, y), c
LINE (x - 8, y)-(x - 4, y + 4), c
LINE (x - 4, y + 4)-(x + 4, y + 4), c
LINE (x + 4, y + 4)-(x + 8, y), c
PAINT (x, y), c, c
LINE (x - 13, y)-(x + 13, y), c
LINE (x - 14, y - 4)-(x - 13, y + 3), c, B
LINE (x + 13, y - 4)-(x + 14, y + 3), c, B
PSET (x - 13, y + 3), 0: PSET (x + 13, y + 3), 0
LINE (x - 2, y - 1)-(x - 2, y + 1), 14
LINE (x, y - 1)-(x, y + 1), 14
LINE (x + 2, y - 1)-(x + 2, y + 1), 14
RETURN

DRAW.SHOT:
FOR n = 0 TO shmax: xs = xsh(n): ys = ysh(n)
IF ys < 0 THEN GOTO DRAW.SHOT1
   LINE (xs, ys)-(xs, ys + 3), 14
DRAW.SHOT1:
NEXT n
RETURN

DRAW.EXP:
expcnt = 0
FOR n = 0 TO exmax
IF stex(n) = 0 THEN GOTO DRAW.EXP1
   T = tex(n): c = 12 + (cnt1 AND 1) * 4: a = ae(n) / 10
   x = xex(n): y = yex(n): z = zex(n) / 16
   e$ = CRASH$(T): GOSUB DRAW.SPRITE
   ae(n) = (ae(n) + 0) MOD 3600: stex(n) = stex(n) - 1
   expcnt = expcnt + 1
DRAW.EXP1:
NEXT n
RETURN

DRAW.ENEMY:
FOR n = 0 TO emax
s = ste(n): IF s < 0 THEN GOTO DRAW.ENEMY1
 a = ae(n) / 10: z = ze(n) / 16
 x = xe!(n): y = ye!(n)
 e = tpe(n): f = bin(anie(e)) * 2
 c1 = c1e(e): c2 = c2e(e): GOSUB DRAW.ESPRITE
DRAW.ENEMY1:
NEXT n
RETURN

DRAW.GAMEOVER:
stp = stp + 1
IF k = 29 AND stp > 50 THEN GOTO GAME.OVER
IF stp > 400 THEN GOTO GAME.OVER
ac = 0: sc = 4: cc = 15
yc! = 90
xc! = 120: T$ = "GAME": GOSUB DRAW.TXTF
xc! = 168: T$ = "OVER": GOSUB DRAW.TXTF
RETURN

GAME.OVER:
IF SND = 1 THEN PLAY SEND$
GOSUB WAITKEY0
sc = 8: ac = 0
DO
k = INP(96): k$ = INKEY$
GOSUB DRAW.ESTAR
cc = 16 * RND
T$ = "WELL DONE": xc! = 80: yc! = 60: GOSUB DRAW.TXTZ
LOCATE 14, 11
PRINT "SCORE: "; score&; "PTS"
GOSUB REFR.SCREEN
LOOP UNTIL k = 29
RUN

DRAW.SPRITE:
x$ = LTRIM$(STR$(x)): y$ = LTRIM$(STR$(y))
a$ = LTRIM$(STR$(a)): c$ = LTRIM$(STR$(c))
z$ = LTRIM$(STR$(z))
s$ = "S" + z$ + "TA" + a$ + "C" + c$ + "bm" + x$ + "," + y$ + e$
IF z > 1 THEN s$ = s$ + "P" + c$ + "," + c$
DRAW s$
RETURN
DRAW.SSPRITE:
x$ = LTRIM$(STR$(x)): y$ = LTRIM$(STR$(y))
a$ = LTRIM$(STR$(a)): c$ = LTRIM$(STR$(c)): z$ = LTRIM$(STR$(z))
s$ = "S" + z$ + "TA" + a$ + "C" + c$ + "bm" + x$ + "," + y$ + SHOT$(e)
DRAW s$
RETURN
DRAW.ESPRITE:
x$ = LTRIM$(STR$(x)): y$ = LTRIM$(STR$(y))
a$ = LTRIM$(STR$(a)): c1$ = LTRIM$(STR$(c1)): c2$ = LTRIM$(STR$(c2))
z$ = LTRIM$(STR$(z))
e1$ = ENEMY$(e, f): e2$ = ENEMY$(e, f + 1)
s$ = "S" + z$ + "TA" + a$ + "C" + c1$ + "bm" + x$ + "," + y$ + e1$
IF z > 1 THEN s$ = s$ + "P" + c1$ + "," + c1$
s$ = s$ + "C" + c2$ + e2$
IF z > 1 THEN s$ = s$ + "P" + c2$ + "," + c2$
DRAW s$
RETURN

DRAW.PLAYER1:
SCREEN 7, 0, 0, 0: CLS
cc = 15: yc! = 90
xc! = 120: T$ = "PLAYER": GOSUB DRAW.TXT
xc! = 182: i = 1: GOSUB DRAW.INTF
RETURN

TEST.HIT.SHOT:
FOR n = 0 TO shmax: xs = xsh(n): ys = ysh(n)
IF ys < 0 THEN GOTO TEST.HIT.SHOT1
   c = POINT(xs, ys) + POINT(xs, ys + 1) + POINT(xs, ys + 2)
   IF c > 0 THEN GOSUB HIT.SHOT
TEST.HIT.SHOT1:
NEXT n
RETURN

TEST.HIT.PLAYER:
IF stp <> 0 THEN RETURN
c = POINT(xp, yp - 3) + POINT(xp, yp + 2) + POINT(xp - 3, yp) + POINT(xp + 3, yp)
IF c <= 0 THEN RETURN
c1 = POINT(319, 199) * 4
c2 = POINT(0, 0) + POINT(319, 0) + POINT(0, 199) + POINT(319, 199)
IF c1 = c2 AND c1 > 0 THEN RETURN
GOSUB HIT.PLAYER
RETURN

HIT.SHOT:
x! = xs: y! = ys: r1! = hitrad
FOR e = 0 TO emax
IF ste(e) <> 0 THEN GOTO HIT.SHOT1
 dx! = xe!(e) - x!: dy! = ye!(e) - y!
 r! = SQR(dx! * dx! + dy! * dy!)
 IF r! < r1! THEN ysh(n) = -1: GOSUB HIT.ENEMY: EXIT FOR
HIT.SHOT1:
NEXT e
IF stbos < 0 THEN RETURN
dx! = xbos! - x!: dy! = ybos! - y!
rr! = SQR(dx! * dx! + dy! * dy!)
IF rr! < hrbos(tbos) THEN ysh(n) = -1: GOSUB HIT.BOSS
RETURN

HIT.BOSS:
IF PLAY(0) = 0 AND SND = 1 THEN PLAY SHITBOS1$
IF stbos < 0 THEN RETURN
IF stbos = 0 THEN GOTO EXP.BOSS
stbos = stbos - 1: hbos = 1
xex(0) = x!: yex(0) = y!: stex(0) = 12
zex(0) = 32: tex(0) = 2
GOSUB ACTIV.BOSS
RETURN

EXP.BOSS:
stbos = -160: dx = 48: d = 2
IF tbos = 7 THEN dx = 120: d = 4
FOR m = 0 TO exmax
xex(m) = xbos! + dx * RND - dx * .5: yex(m) = ybos! + 32 * RND - 16
stex(m) = 30 + 30 * RND
zex(m) = (3 + INT(d * RND)) * 16: tex(m) = 1
NEXT m
FOR m = 0 TO fmax
fx!(m) = xbos!: fy!(m) = ybos!: a! = pi! * 2 * RND
dfx!(m) = COS(a!) * 4: dfy!(m) = SIN(a!) * 4
fc(m) = 15
NEXT m
RETURN

PLAY.ENEMY.CRASH:
IF T = 1 THEN PLAY SETYPE1$
IF T = 2 THEN PLAY SETYPE2$
IF T = 3 THEN PLAY SETYPE3$
IF T = 4 THEN PLAY SETYPE4$
IF T = 5 THEN PLAY SETYPE1$
IF T = 6 THEN PLAY SETYPE1$
IF T = 7 THEN PLAY SETYPE1$
IF T = 8 THEN PLAY SETYPE8$
IF T = 9 THEN PLAY SETYPE9$
IF T = 10 THEN PLAY SETYPE10$
IF T = 11 THEN PLAY SETYPE11$
RETURN

HIT.ENEMY:
IF PLAY(0) = 0 AND SND = 1 THEN T = tpe(e): GOSUB PLAY.ENEMY.CRASH
ste(e) = -1: GOSUB CREATE.EXP
hitcnt = hitcnt + 1: pts& = ptse(tpe(e)) * STAGE: GOSUB LOAD.SCORE
T = tpe(e)
IF dble(T) = 0 THEN RETURN         ' unteilbar/teilbar
SPLIT.ENEMY:
f = e + 1
ste(e) = 0: ae(e) = 900: ze(e) = zoome(T + 1): zze(e) = ze(e)
ste(f) = 0: ae(f) = 900: ze(f) = zoome(T + 1): zze(f) = ze(f)
tpe(e) = T + 1: tpe(f) = T + 1
mt1 = table(T + 1): mt2 = table(T + 1)
tce(e) = tce0(mt1): tce(f) = tce0(mt2): tce(e) = 72: tce(f) = 88
dae(e) = tae(tce(e)): ne(e) = tne(tce(e))
dae(f) = tae(tce(f)): ne(f) = tne(tce(f))
xe!(f) = xe!(e): ye!(f) = ye!(e)
IF PLAY(0) = 0 AND SND = 1 THEN PLAY SSPLIT$
RETURN

HIT.PLAYER:
REM LOCATE 2, 1: PRINT "HIT ON PLAYER!"
stp = -35: f1! = 600
FOR q = 1 TO 3
IF ssec(q) = 1 THEN ssec(q) = -1: EXIT FOR
NEXT q
GOSUB SETUP.SHIP
x0 = xp: y0 = yp + 6: GOSUB CREATE.SHIPEXPLODE
RETURN

CREATE.EXP:
exptr = (exptr + 1) AND exmax
IF stex(exptr) > 0 THEN RETURN
xex(e) = xe!(e): yex(e) = ye!(e): stex(e) = 30
zex(e) = ze(e): tex(e) = 1
RETURN

LOAD.SCORE:
B& = bonplay&
s& = score&: score& = score& + pts&
IF (score& MOD B&) > (s& MOD B&) THEN RETURN
SCREEN 7, 0, scr, scr
FOR q = 1 TO 3: IF ssec(q) = -1 THEN ssec(q) = 0: EXIT FOR
NEXT q
x = 160: y = 20: c = 4
ON q GOSUB DRAW.SHIP1, DRAW.SHIP2, DRAW.SHIP3
sc = 4: ac = 0: cc = 15
T$ = "BONUS PLAYER": xc! = 178: yc! = 17: GOSUB DRAW.TXTZ
IF ssec(1) = 0 THEN ssec(1) = 1: ssec(2) = 0: ssec(3) = 0: GOSUB SETUP.SHIP
IF SND = 1 THEN PLAY SBONPLAY$
c = 50: GOSUB PAUSE: SCREEN 7, 0, 1 - scr, scr
RETURN

REM  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

DOCKING:
REM REM PLAY SDOCK1$: DO: LOOP UNTIL PLAY(0) = 0
ss1 = 0: ss2 = 0
IF ssec(1) = 1 THEN ss1 = ss1 OR 1
IF ssec(2) = 1 THEN ss1 = ss1 OR 2
IF ssec(3) = 1 THEN GOTO DOCK.END
IF ssec(3) = 0 THEN ss2 = 4: dp = 5
IF ssec(2) = 0 THEN ss2 = 2: dp = 0
IF ss2 = 0 THEN GOTO DOCK.END
xb = scx: yb = 172
xp! = xb - 30 + 60 * RND: yp! = 100: vxp! = 0: vyp! = 0
dyp! = 0: IF ss1 = 3 THEN dyp! = 6
fcnt = 0: FOR n = 0 TO fmax: ft(n) = -1: NEXT n
grav! = .01 + ss1 * .006
dfuel = 1000: dtime! = 10
FOR n = 0 TO 1: SCREEN 7, 0, n, n: CLS
LOCATE 4, 9: PRINT "Time": LOCATE 4, 27: PRINT "Fuel"
GOSUB DRAW.VALUES: LOCATE 9, 12: PRINT "Docking Sequence"
NEXT n
GOSUB WAITFIRE: timer0! = TIMER + dtime!

DOCK.MAIN:
k0 = k: k = INP(96): k$ = INKEY$
IF k = 1 THEN END
IF k = 29 THEN GOSUB THRUST
IF k = 75 THEN vxp! = vxp! - .03
IF k = 77 THEN vxp! = vxp! + .03
vyp! = vyp! + grav!
GOSUB MOVE.SECTION
GOSUB MOVE.FIRE
GOSUB REFR.DOCKSCREEN
WAIT &H3DA, 8: WAIT &H3DA, 8, 8
GOSUB DRAW.SECTION
GOTO TEST.HIT.BASE
DOCK.MAIN1:
dtime! = timer0! - TIMER
GOSUB DRAW.DSTAR
GOSUB DRAW.VALUES: GOSUB DRAW.FIRE
GOSUB DRAW.BASE: GOSUB DRAW.SECTION
cnt1 = (cnt1 + 1) AND 255
GOTO TEST.DOCK.OUT
GOTO DOCK.MAIN

THRUST:
IF dfuel = 0 THEN RETURN
vyp! = vyp! - .07: dfuel = dfuel - 8: IF dfuel < 0 THEN dfuel = 0
IF SND = 1 THEN SOUND 37 + 80 * RND, .3
GOSUB CREATE.FIRE
RETURN

DRAW.DSTAR:
FOR n = 0 TO stmax
x = xst(n): y = yst(n): c = cst(n)
IF POINT(x, y) = 0 THEN PSET (x, y), c
NEXT n
IF cnt1 = 0 THEN RETURN
n = stmax * RND: xst(n) = 300 * RND + 10: yst(n) = 180 * RND + 10
RETURN

TEST.DOCK.OUT:
IF xp! < 0 OR xp! > 319 OR yp! < 32 OR yp! > 199 THEN GOTO DOCK.OUT
IF dtime! < .1 THEN GOTO DOCK.OUT
GOTO DOCK.MAIN

DRAW.VALUES:
LOCATE 6, 8: PRINT INT(dtime! * 10) / 10
LOCATE 6, 26: PRINT INT(dfuel / 10)
RETURN

DOCK.END:
RETURN

MOVE.FIRE:
FOR n = 0 TO fmax: IF ft(n) < 0 THEN GOTO MOVE.FIRE1
fx!(n) = fx!(n) + dfx!(n): fy!(n) = fy!(n) + dfy!(n): ft(n) = ft(n) - 1
IF POINT(fx!(n), fy!(n)) = 9 THEN dfy!(n) = -dfy!(n) / 2
MOVE.FIRE1:
NEXT n
RETURN
CREATE.FIRE:
IF ft(fcnt) >= 0 THEN RETURN
a! = pi2! + 1 * RND - .5: dv! = ABS(pi2! - a!) * 2: v! = 2 - dv!
fx!(fcnt) = xp!: fy!(fcnt) = yp! + 4
dfx!(fcnt) = COS(a!) * v! + vxp!: dfy!(fcnt) = SIN(a!) * v! + vyp!
ft(fcnt) = 8: fc(fcnt) = 14 - INT(2 * RND) * 8
fcnt = (fcnt + 1) AND fmax
RETURN
DRAW.FIRE:
FOR n = 0 TO fmax: IF ft(n) < 0 THEN GOTO DRAW.FIRE1
x = fx!(n): y = fy!(n): PSET (x, y), fc(n)
DRAW.FIRE1:
NEXT n

MOVE.SECTION:
xp! = xp! + vxp!: yp! = yp! + vyp!
RETURN

DRAW.SECTION:
IF (ss1 AND 1) = 1 THEN x = xp!: y = yp! - dyp!: c = 4: GOSUB DRAW.SHIP1
IF (ss1 AND 2) = 2 THEN x = xp!: y = yp!: c = 9: GOSUB DRAW.SHIP2
RETURN
DRAW.BASE:
IF ss2 = 2 THEN x = xb: y = yb: c = 9: GOSUB DRAW.SHIP2
IF ss2 = 4 THEN x = xb: y = yb: c = 5: GOSUB DRAW.SHIP3
RETURN

TEST.HIT.BASE:
n = dp
x = xb + pcx(n): y = yb + pcy(n)
IF POINT(x, y) > 0 THEN GOTO TEST.DOCK.OK
c = 14: IF (cnt1 AND 16) = 0 THEN c = 0
PSET (x, y), c
FOR n = dp + 1 TO dp + 4
x = xb + pcx(n): y = yb + pcy(n)
IF POINT(x, y) > 0 THEN GOTO DOCK.CRASH
REM PSET (x, y), 14
NEXT n
GOTO DOCK.MAIN1

TEST.DOCK.OK:
IF ABS(xp! - xb) > 3 THEN GOTO DOCK.CRASH
IF vyp! > .8 THEN GOTO DOCK.CRASH
GOTO DOCK.OK

DOCK.OK:
xp! = xb: yp! = yb + pcy(db) - 4
IF (ss1 AND 2) = 2 THEN yp! = yp! - 3
GOSUB REFR.DOCKSCREEN: SCREEN 7, 0, scr, scr: CLS
GOSUB DRAW.VALUES
GOSUB DRAW.BASE: GOSUB DRAW.SECTION
LOCATE 9, 15: PRINT "Right On !"
IF ss2 = 2 THEN ssec(2) = 1: GOSUB SETUP.SHIP
IF ss2 = 4 THEN ssec(3) = 1: GOSUB SETUP.SHIP
IF SND = 1 THEN PLAY SDOCK2$
DO: LOOP WHILE PLAY(0) > 0: c = 20: GOSUB PAUSE
T = INT(dtime! * 10) / 10: f = dfuel / 10: s = 200 * T + 10 * f
LOCATE 13, 6: PRINT "Bonus = 200 x"; T
LOCATE 15, 6: PRINT "      +  10 x"; f; " ="; s; "x"; STAGE
pts& = s * STAGE: GOSUB LOAD.SCORE
IF SND = 1 THEN PLAY SRGTON$
GOSUB WAITFIRE
RETURN

DOCK.OUT:
SCREEN 7, 0, scr, scr
LOCATE 9, 10: PRINT "Section Out of Range"
GOSUB WAITFIRE
RETURN

DOCK.CRASH:
s = 0: z1 = 4: f1! = 40
FOR n = 1 TO 200
a1 = 3600 * RND: c1 = (s AND 1) * 3 + 12
c2 = 15 - (s AND 1) * 3
IF s = 0 THEN z2 = 3 + 4 * RND: a2 = 3600 * RND: c2 = 15
GOSUB REFR.DOCKSCREEN: GOSUB DRAW.VALUES
LOCATE 9, 13: PRINT "Sorry, no Bonus"
x = xp!: y = yp!: a = a1 / 10: c = c1: z = z1
e$ = CRASH$(1): GOSUB DRAW.SPRITE
x = xb: y = yb: a = a2 / 10: c = c2: z = z2
e$ = CRASH$(1): GOSUB DRAW.SPRITE
s = (s + 1) AND 7
GOSUB DOCK.CRASH.SND
NEXT n
GOSUB WAITFIRE
RETURN

DOCK.CRASH.SND:
f2! = f1! * RND: f1! = f1! * .98
IF n < 150 AND SND = 1 THEN SOUND 37 + f2! * f2!, .3
RETURN

REM - - - - - - - - - - - - - - - - - - - - - - - -


ADVANCE.LEVEL:
LEVEL = LEVEL + 1
IF STAGE = 6 AND LEVEL = 10 THEN GOTO SUPER.LEVEL
IF LEVEL = 9 THEN GOTO BOSS.LEVEL
IF LEVEL = 10 THEN GOTO WARP.LEVEL
IF LEVEL = 11 THEN GOTO GAME.FINISH
GOSUB LOAD.LEVEL
RETURN

SUPER.LEVEL:
STAGE = 7: GOSUB ENTER.STAGE
tbos = tbos + 1: GOSUB BOSS.LEVEL
stbos = 50
LEVEL = 9: GOSUB LOAD.LEVEL
LEVEL = 10: cresum = 24: hitsum = 24
c1e(6) = 4: c2e(6) = 12
c1e(7) = 12: c2e(7) = 14
RETURN

BOSS.LEVEL:
evcnt = 70: evtpe = 2: evtxt$ = BOSS$(STAGE)
stbos = 8 + tbos * 4: abos = 0
xbos! = scx: ybos! = 50: dxbos! = 0: dybos! = 0
cresum = 0: crecnt = 0: hitcnt = 0: hitsum = 0
RETURN

LOAD.LEVEL:
n = LEVEL
hitrad = lrad(n): tpe = ltpe(n): mt = table(tpe)
vec = vec(mt)
cresum = lsum(n) + (STAGE - 1) * 2
crecnt = 0: hitcnt = 0: hitsum = cresum * lhit(n)
crec0 = crec(mt): crec1 = crec0
s = (STAGE - 1) MOD 3:             REM LOAD COLOR TABLE
FOR e = 1 TO 11: c1e(e) = c1ee(s, e): c2e(e) = c2ee(s, e): NEXT e
RETURN

WARP.LEVEL:
dyp! = .5: dys! = .5: ypp = yp: yp! = yp
f1! = 0
GOSUB SAVE.PALETTE
FOR o = 1 TO 260
IF INP(96) = 1 THEN END
GOSUB DRAW.WARPSTAR
GOSUB DRAW.PLAYER
yp = yp!: yp! = yp! - dyp!: dyp! = dyp! * 1.01: dys! = dys! + .1
WAIT &H3DA, 8, 8: WAIT &H3DA, 8
SCREEN 7, 0, 1 - scr, scr: scr = 1 - scr: CLS
IF o > 30 AND o < 150 THEN LOCATE 10, 14: PRINT " WARP OUT ! "
IF o < 180 THEN f1! = f1! + 3
IF o = 180 THEN f1! = 5000
IF o > 60 THEN c1 = 1: c2 = 31: c3 = 2: GOSUB INC.PALETTE
IF o > 180 THEN c1 = 0: c2 = 0: c3 = 4: GOSUB INC.PALETTE: f1! = f1! * .92
IF SND = 1 THEN SOUND 37 + f1! * RND, .3
NEXT o
SCREEN 7, 0, scr, scr: CLS
c1 = 0: c2 = 0: c3 = 4
FOR o = 1 TO 16: WAIT &H3DA, 8: WAIT &H3DA, 8, 8: GOSUB DEC.PALETTE: NEXT o
GOSUB LOAD.PALETTE
yp = ypp
REM IF SND = 1 THEN PLAY SFAROUT2$: PLAY SFAROUT2$
REM c = 70: GOSUB PAUSE
REM DO: LOOP UNTIL PLAY(0) < 4
LEVEL = 2: STAGE = STAGE + 1
GOSUB LOAD.LEVEL
tbos = tbos + 1: IF tbos > 6 THEN tbos = 1
c = 20: GOSUB PAUSE
GOSUB ENTER.STAGE
RETURN

ENTER.STAGE:
evcnt = 70: evtpe = 2: evtxt$ = "STAGE " + LTRIM$(STR$(STAGE))
GOSUB LOAD.3DSTAR
SCREEN 7, 0, 2, 0: CLS
xs! = 159: ys! = 160: rs! = 20
ON STAGE GOSUB DSTG1, DSTG2, DSTG3, DSTG4, DSTG5, DSTG6, DSTG7
REM IF SND = 1 THEN PLAY SSTAGE1$

ENTER.STAGE1:
xs! = 159: ys! = 99: rs! = 8: rsmax! = 40: cnt = 0
u$ = "STAGE " + LTRIM$(STR$(STAGE)): tptr = 0: mode = 0
sss = -(STAGE > 2 AND STAGE < 7): fs! = 1.02: cnt1 = 10: cnt2 = 0
DO
k = INP(96): k$ = INKEY$
rs! = rs! * fs!: vs! = 1.08
IF rs! >= rsmax! AND mode = 0 THEN rs! = rsmax!: vs! = 1.02
GOSUB ENTER.STAGE2
IF cnt < 160 AND mode = 0 THEN GOSUB ENTER.STAGE3
IF (cnt AND 7) = 7 THEN GOSUB ENTER.STAGE5
cnt = cnt + 1: IF cnt > 300 THEN GOSUB ENTER.STAGE4
GOSUB REFR.SCREEN
IF mode = 1 AND sss = 1 AND SND = 1 THEN SOUND 37 + cnt1 * RND, 1: cnt1 = (cnt1 * 1.2) MOD 32000
IF cnt2 = 4 AND SND = 1 THEN PLAY SSTAGE2$
IF k = 29 AND rs! >= rsmax! THEN GOSUB ENTER.STAGE4
LOOP WHILE rs! < 200
RETURN

ENTER.STAGE2:
IF sss = 0 THEN PCOPY 2, 1 - scr: RETURN
GOSUB DRAW.3DSTAR
ON STAGE - 2 GOSUB DSTG3, DSTG4, DSTG5, DSTG6
RETURN
ENTER.STAGE3:
T$ = LEFT$(u$, tptr)
xc! = 136: yc! = 24: ac = 0: sc = 4: cc = 15
GOSUB DRAW.TXTZ
T$ = STAGE$(STAGE)
xc! = 159 - LEN(T$) * 4: yc! = 44: ac = 0: sc = 4: cc = 15
s = (cnt AND 8)
IF tptr <= 8 OR s > 0 AND cnt2 < 24 THEN RETURN
GOSUB DRAW.TXTZ: cnt2 = cnt2 + 1
RETURN
ENTER.STAGE4:                   REM launch
mode = 1: fs! = 1.04: RETURN
ENTER.STAGE5:
tptr = tptr + 1: IF tptr < 8 THEN SOUND 622, 1
RETURN


SAVE.PALETTE:
OUT &H3C7, 0
FOR c = 0 TO 95: cp(c) = INP(&H3C9): NEXT c
RETURN
LOAD.PALETTE:
OUT &H3C8, 0
FOR c = 0 TO 95: OUT &H3C9, cp(c): NEXT c
RETURN
INC.PALETTE:
FOR c = c1 TO c2: OUT &H3C7, c
a = INP(&H3C9): a = a + c3: IF a > 63 THEN a = 63
B = INP(&H3C9): B = B + c3: IF B > 63 THEN B = 63
d = INP(&H3C9): d = d + c3: IF d > 63 THEN d = 63
OUT &H3C8, c: OUT &H3C9, a: OUT &H3C9, B: OUT &H3C9, d
NEXT c
RETURN
DEC.PALETTE:
FOR c = c1 TO c2: OUT &H3C7, c
a = INP(&H3C9): a = a - c3: IF a < 0 THEN a = 0
B = INP(&H3C9): B = B - c3: IF B < 0 THEN B = 0
d = INP(&H3C9): d = d - c3: IF d < 0 THEN d = 0
OUT &H3C8, c: OUT &H3C9, a: OUT &H3C9, B: OUT &H3C9, d
NEXT c
RETURN

DRAW.WARPSTAR:
dys = dys!
FOR n = 0 TO stmax
x = xst(n): y = yst(n)
LINE (x, y)-(x, y + dys), cst(n)
y = y + dys: yst(n) = y: IF y > 200 THEN yst(n) = -20: xst(n) = 320 * RND
NEXT n
RETURN


REM - - - - - - - - - - - - - - - - - - - - -
REM - - - - - - CREDITS - - - - - - -

GAME.FINISH:
GOSUB WAITKEY0
sc = 8: ac = 0: s = 1: GOSUB LOAD.SONG: GOSUB LOAD.3DSTAR
tcnt = 24: tptr = 0: cnt1 = -100: dy = 24: vs! = 1.06: cnt2 = 120
DO
k = INP(96): k$ = INKEY$
GOSUB DRAW.3DSTAR
d = 2: cc = 13
IF cnt1 < 0 THEN cnt1 = cnt1 + 1: cc = 16 * RND: d = 0
IF tptr > 28 THEN d = 0: cnt2 = cnt2 - 1
IF cnt2 = 0 THEN s = 2: GOSUB LOAD.SONG
tcnt = tcnt - d
IF tcnt = 0 THEN tcnt = dy: tptr = tptr + 1
yc! = tcnt - dy
FOR n = 1 TO 11
T$ = CREDIT$(n + tptr)
xc! = 20: GOSUB DRAW.TXTZ
yc! = yc! + dy
NEXT n
WAIT &H3DA, 8: WAIT &H3DA, 8, 8
GOSUB REFR.SCREEN: GOSUB PLAY.SONG
LOOP UNTIL (k = 29 AND cnt1 >= 0)
GOTO GAME.OVER

LOAD.SONG:
nsong = s: stsong = 1: tsong = 1: RETURN

PLAY.SONG:
IF stsong < 1 THEN RETURN
IF PLAY(0) > 0 THEN RETURN
PLAY SFINAL$(nsong, tsong)
tsong = tsong + 1: IF tsong > 7 THEN stsong = 0
RETURN

LOAD.3DSTAR:
FOR n = 0 TO stmax
x = 26 * RND - 13: y = 20 * RND - 10
xst!(n) = x * x * SGN(x): yst!(n) = y * y * SGN(y)
NEXT n
RETURN
DRAW.3DSTAR:
FOR n = 0 TO stmax
x! = xst!(n): y! = yst!(n): c = cst(n)
r! = SQR(x! * x! + y! * y!)
x! = x! * vs!: y! = y! * vs!
IF r! > 160 THEN r! = 2 + 6 * RND: a! = pi! * 2 * RND: x! = COS(a!) * r!: y! = SIN(a!) * r!
PSET (scx + x!, scy - y!), 15
xst!(n) = x!: yst!(n) = y!
NEXT n
RETURN




REM - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
TITLE:
a = 0: CH = 0: mode1 = 1: mode2 = 6: cnt = 35
TITLE.MAIN:
k = INP(96): k$ = INKEY$: IF k = 1 THEN END
IF k = 29 THEN RETURN
IF k = 31 THEN SND = 1 - SND: GOSUB WAITKEY0
IF k = 59 THEN GOSUB TITLE.HELP
GOSUB CARE.TITLE
GOSUB CARE.MENU
GOTO TITLE.MAIN

CARE.TITLE:
GOSUB MOVE.TITLE: IF mode1 > 4 THEN RETURN
cc = 15: GOSUB DRAW.TITLE: GOSUB DRAW.YEAR
WAIT &H3DA, 8, 8: WAIT &H3DA, 8
GOSUB REFR.TITLE
RETURN

DRAW.TITLE:
FOR n = 0 TO 7
nc = nc(n): ac = 0
xc! = xc!(n): yc! = yc!(n): zc! = zc!(n)
GOSUB DRAW.CHAR3D
NEXT n
RETURN
DRAW.YEAR:
IF CH < 8 THEN RETURN
FOR n = 8 TO 9
nc = nc(n): ac = 0
xc! = xc!(n): yc! = yc!(n): zc! = zc!(n)
GOSUB DRAW.CHAR3D
NEXT n
RETURN

MOVE.TITLE:
ON mode1 GOTO MTIT1, MTIT2, MTIT3, MTIT4
RETURN
MTIT1:
zc!(CH) = zc!(CH) - 12: IF zc!(CH) <= zmax AND SND = 1 THEN PLAY SCRASH8$
IF zc!(CH) <= zmax THEN CH = CH + 1
IF CH > 7 THEN mode1 = mode1 + 1: cnt = 2000
RETURN
MTIT2:
xc!(8) = xc!(8) - 2: yc!(8) = yc!(8) - 1
xc!(9) = xc!(9) - 2: yc!(9) = yc!(9) - 1
SOUND cnt, .4: cnt = cnt - 44
IF yc!(8) <= yc!(7) + 8 THEN mode1 = mode1 + 1: cnt = 35
RETURN
MTIT3:
cnt = cnt - 1: IF cnt = 34 AND SND = 1 THEN PLAY SCRASH9$
IF cnt = 0 THEN cnt = 35: mode1 = mode1 + 1
RETURN
MTIT4:
SCREEN 7, 0, scr, scr
scx = scx - 1: cc = 14: GOSUB DRAW.TITLE
scx = scx + 2: cc = 14: GOSUB DRAW.TITLE: scx = scx - 1
scy = scy - 1: cc = 14: GOSUB DRAW.TITLE
scy = scy + 2: cc = 14: GOSUB DRAW.TITLE: scy = scy - 1
cc = 4: GOSUB DRAW.TITLE
mode1 = mode1 + 1: mode2 = 1
sss = scx
FOR scx = sss - 2 TO sss + 2: cc = 15: GOSUB DRAW.YEAR: NEXT scx
x = 214: y = 15
CIRCLE (x, y), 5, 15: PAINT (x, y), 15, 15
CIRCLE (x - 3, y - 1), 5, 1: PAINT (x - 3, y - 1), 1, 1
RETURN

REFR.TITLE:
SCREEN 7, 0, scr, 1 - scr: scr = 1 - scr
LINE (0, 0)-(319, 120), 0, BF
RETURN

CARE.MENU:
IF mode2 < 6 THEN GOTO DRAW.MENU
RETURN
DRAW.MENU:
WAIT &H3DA, 8, 8: WAIT &H3DA, 8
ON mode2 GOTO DMEN1, DMEN2, DMEN3, DMEN4, DMEN5
RETURN
DMEN1:
cnt = cnt - 1: IF cnt = 0 THEN cnt = 35: mode2 = mode2 + 1
RETURN
DMEN2:
SCREEN 7, 0, scr, scr
x = 40: y = 66: a = 90: c1 = 8: c2 = 15: f = 0: z = 4
FOR e = 1 TO 5: GOSUB DRAW.ESPRITE: REM PSET (x, y), 10
y = y + 18: NEXT e
mode2 = mode2 + 1: x = 58
RETURN
DMEN3:
IF (x AND 7) > 0 THEN GOTO DMEN31
y = 70: c1 = 15
FOR e = 1 TO 5
REM LINE (x, y)-(x + 1, y + 1), 7, BF
REM PSET (x, y + 1), 15: PSET (x + 1, y), 8
LINE (x, y)-(x + 1, y), 8
LINE (x, y + 1)-(x + 1, y + 1), 15
y = y + 18: NEXT e
DMEN31:
x = x + 1: IF x >= 208 THEN mode2 = mode2 + 1
RETURN
DMEN4:
ac = 0: sc = 4: cc = 15: yc! = 64
FOR e = 1 TO 5
i = ptse(e): xc! = 220: GOSUB DRAW.INTF
T$ = "PTS": xc! = 234: GOSUB DRAW.TXTF: yc! = yc! + 18
NEXT e
ac = 0: sc = 4: cc = 7
xc! = 54: yc! = 162: T$ = "PRESS F1 FOR BRIEFING": GOSUB DRAW.TXTZ
mode2 = mode2 + 1
RETURN
DMEN5:
ac = 0: sc = 4: cc = 16 * RND
xc! = 100: yc! = 180: T$ = "PRESS FIRE": GOSUB DRAW.TXTZ
RETURN


REM - - - - - - - - - - - - - - - - -

DRAW.CHAR3D:
zf! = 100 / zc!: sc = zf! * 4
xd = INT(scx + xc! * zf!): yd = INT(scy - yc! * zf!)
x$ = LTRIM$(STR$(xd)): y$ = LTRIM$(STR$(yd))
ta$ = LTRIM$(STR$(ac)): c$ = LTRIM$(STR$(cc))
zs$ = LTRIM$(STR$(sc))
s$ = "TA" + ta$ + "S" + zs$ + "C" + c$ + "bm" + x$ + "," + y$ + CH$(nc)
DRAW s$
RETURN

DRAW.CHAR:
xd = xc!: yd = yc!
x$ = LTRIM$(STR$(xd)): y$ = LTRIM$(STR$(yd))
ta$ = LTRIM$(STR$(ac)): c$ = LTRIM$(STR$(cc))
zs$ = LTRIM$(STR$(sc))
s$ = "TA" + ta$ + "S" + zs$ + "C" + c$ + "bm" + x$ + "," + y$ + CH$(nc)
DRAW s$
RETURN

DRAW.FCHAR:
xd = xc!: yd = yc!
x$ = LTRIM$(STR$(xd)): y$ = LTRIM$(STR$(yd))
ta$ = LTRIM$(STR$(ac)): c$ = LTRIM$(STR$(cc))
zs$ = LTRIM$(STR$(sc))
s$ = "TA" + ta$ + "S" + zs$ + "C" + c$ + "bm" + x$ + "," + y$ + CH$(nc)
DRAW s$: x$ = LTRIM$(STR$(xd - 1))
s$ = "TA" + ta$ + "S" + zs$ + "C" + c$ + "bm" + x$ + "," + y$ + CH$(nc)
DRAW s$: x$ = LTRIM$(STR$(xd + 1))
s$ = "TA" + ta$ + "S" + zs$ + "C" + c$ + "bm" + x$ + "," + y$ + CH$(nc)
DRAW s$
RETURN

DRAW.INTF:
sc = 4: x! = xc!: ac = 0: sc = 4
FOR m = 0 TO 5
nc = i MOD 10
GOSUB DRAW.FCHAR
xc! = xc! - 10: i = INT(i / 10): IF i = 0 THEN EXIT FOR
NEXT m: xc! = x!
RETURN

DRAW.TXTF:
sc = 4: l = LEN(T$)
FOR m = 1 TO l
nc = ASC(MID$(T$, m, 1)) - 48
GOSUB DRAW.FCHAR
xc! = xc! + 9
NEXT m
RETURN

DRAW.TXT:
sc = 4: l = LEN(T$)
FOR m = 1 TO l
nc = ASC(MID$(T$, m, 1)) - 48
GOSUB DRAW.CHAR
xc! = xc! + 9
NEXT m
RETURN

DRAW.TXTZ:
l = LEN(T$)
FOR m = 1 TO l: nc = ASC(MID$(T$, m, 1)) - 48
IF nc >= 0 THEN GOSUB DRAW.CHAR
xc! = xc! + sc * 2
NEXT m
RETURN

WAITKEY0:
DO: k = INP(96): k$ = INKEY$: LOOP WHILE k < 128
RETURN

PAUSE.MODE:
GOSUB WAITKEY0: SCREEN 7, 0, scr, scr
LOCATE 11, 16: COLOR 14: PRINT "- PAUSE -"
DO: k$ = INKEY$: k = INP(96): LOOP UNTIL k = 25
GOSUB WAITKEY0
RETURN

REM - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

DBOSS1:
c1 = 13: c2 = 12: IF hbos = 1 THEN c1 = 15: c2 = 15
LINE (x - 10, y - 25)-(x, y - 32), 1
LINE (x, y - 32)-(x + 10, y - 25), 1
LINE (x - 10, y - 25)-(x + 10, y - 25), 1
PAINT (x, y - 30), c1, 1
LINE (x - 16, y)-(x, y + 16), 5
LINE (x, y + 16)-(x + 16, y), 5
LINE (x - 16, y)-(x + 16, y), 5
PAINT (x, y + 8), c1, 5
LINE (x, y + 15)-(x + 15, y), 5
LINE (x - 15, y)-(x, y + 15), 5
CIRCLE (x, y), 30, 5, -pi! * 2, -pi!, .85
PAINT (x, y - 10), c2, 5
CIRCLE (x - 11, y - 17), 4, 14: PAINT (x - 11, y - 17), 15, 14
CIRCLE (x + 10, y - 12), 8, 14: PAINT (x + 10, y - 12), 15, 14
CIRCLE (x - 15, y), 8, 14, -pi! * 2, -pi!, .85: PAINT (x - 15, y - 4), 15, 14
CIRCLE (x + 30, y), 8, 14, -pi! * .55, -pi!, .85: PAINT (x + 26, y - 3), 15, 14
s = SIN(cnt1 / 1) * 20 + 30
IF PLAY(0) = 0 AND s > 37 THEN SOUND s, .2
RETURN

DBOSS2:
c1 = 6: c2 = 14: IF hbos = 1 THEN c1 = 15
s = SGN(dybos!)
IF s > 0 THEN abos = abos + 2
IF s = 0 THEN abos = abos + 15
IF s < 0 THEN abos = abos + 30
dy1 = SIN(abos / 100) * 5: dy2 = SIN(abos / 100) * 10
LINE (x, y - 9)-(x + 20, y - 6 + dy1), c1
LINE (x + 20, y - 6 + dy1)-(x + 32, y - 1 + dy2), c1
LINE (x + 32, y - 1 + dy2)-(x + 32, y + 3 + dy2), c1
LINE (x + 32, y + 3 + dy2)-(x, y + 7), c1
LINE (x, y + 7)-(x - 32, y + 3 + dy2), c1
LINE (x - 32, y + 3 + dy2)-(x - 32, y - 1 + dy2), c1
LINE (x - 32, y - 1 + dy2)-(x - 20, y - 6 + dy1), c1
LINE (x - 20, y - 6 + dy1)-(x, y - 9), c1
PAINT (x, y), c1, c1
yy! = y + 4: dy! = dy2 / 7
FOR xx = 2 TO 32 STEP 4
x1 = x + xx: x2 = x - xx
LINE (x1, yy!)-(x1 + 1, yy! + 5), c1, B
LINE (x2 - 1, yy!)-(x2, yy! + 5), c1, B
yy! = yy! + dy!
NEXT xx
LINE (x, y - 9)-(x - 6, y - 3), c2
LINE (x - 6, y - 3)-(x, y + 12), c2
LINE (x, y + 12)-(x + 6, y - 3), c2
LINE (x + 6, y - 3)-(x, y - 9), c2
PAINT (x, y), c2, c2
CIRCLE (x, y - 13), 4, c1, , , 1: PAINT (x, y - 13), c2, c1
LINE (x, y + 11)-(x - 11, y + 23), c1
LINE (x - 11, y + 23)-(x, y + 19), c1
LINE (x, y + 19)-(x + 11, y + 23), c1
LINE (x + 11, y + 23)-(x, y + 11), c1
PAINT (x, y + 16), c2, c1
LINE (x - 1, y - 11)-(x + 1, y - 11), c1
PSET (x - 4, y - 17), c1
PSET (x + 4, y - 17), c1
LINE (x - 2, y - 14)-(x + 2, y - 14), c1
LINE (x - 2, y - 11)-(x - 2, y - 10), 0
LINE (x + 2, y - 11)-(x + 2, y - 10), 0
RETURN

DBOSS3:
c1 = 6: c2 = 14: IF hbos = 1 THEN c1 = 15: c2 = 15
c3 = 4: abos = abos + 1: d = abos AND 63
IF d < 4 THEN c3 = 15 - d / 2
LINE (x, y - 6)-(x + 7, y - 7), c1
LINE (x + 7, y - 7)-(x + 12, y - 10), c1
LINE (x + 12, y - 10)-(x + 20, y - 7), c1
LINE (x + 20, y - 7)-(x + 24, y + 1), c1
LINE (x + 24, y + 1)-(x + 25, y + 9), c1
LINE (x + 25, y + 9)-(x + 20, y + 16), c1
LINE (x + 19, y + 16)-(x + 15, y + 7), c1
LINE (x + 15, y + 7)-(x + 6, y + 2), c1
LINE (x + 6, y + 2)-(x, y + 6), c1
LINE (x, y - 6)-(x - 7, y - 7), c1
LINE (x - 7, y - 7)-(x - 12, y - 10), c1
LINE (x - 12, y - 10)-(x - 20, y - 7), c1
LINE (x - 20, y - 7)-(x - 24, y + 1), c1
LINE (x - 24, y + 1)-(x - 25, y + 9), c1
LINE (x - 25, y + 9)-(x - 20, y + 16), c1
LINE (x - 19, y + 16)-(x - 15, y + 7), c1
LINE (x - 15, y + 7)-(x - 6, y + 2), c1
LINE (x - 6, y + 2)-(x, y + 6), c1

LINE (x + 18, y + 11)-(x + 24, y + 9), c1
PAINT (x + 20, y + 13), c2, c1
LINE (x - 18, y + 11)-(x - 24, y + 9), c1
PAINT (x - 20, y + 13), c2, c1
PAINT (x, y), 2, c1
LINE (x + 3, y)-(x + 5, y - 2), c3
LINE (x - 3, y)-(x - 5, y - 2), c3
LINE (x + 6, y + 2)-(x, y + 6), 4
LINE (x - 6, y + 2)-(x, y + 6), 4
RETURN

DBOSS4:
c1 = 9: c2 = 11: c3 = 15: IF hbos = 1 THEN c1 = 15
CIRCLE (x, y), 30, c1, 0, pi!, .85
CIRCLE (x, y), 30, c1, pi!, pi! * 2, .1
PAINT (x, y - 10), 0, c1
abos = (abos + 1) AND 255
FOR xx = x - 24 TO x + 24 STEP 5
a1! = abos + xx + 1: r1! = SIN(a1! / 4.33)
a2! = abos + xx + 2: r2! = SIN(a2! / 3.97)
a3! = abos + xx + 3: r3! = SIN(a3! / 3.67)
yy = y - 4 - r2!: f1 = 40 - ABS(xx - x): f2 = f1 / 5
x1 = xx + f2 * r1!: x2 = xx + f2 * r2!: x3 = xx + f2 * r3!
LINE (xx, yy)-(x1, yy + 16), c2
LINE (x1, yy + 16)-(x2, yy + 30), c2
LINE (x2, yy + 30)-(x3, yy + 30 + f2 * 2), c2
NEXT xx
CIRCLE (x, y), 30, c3, 0, pi!, .1
RETURN

DBOSS5:
c1 = 9: dy = 0: abos = abos + 1
IF (abos AND 63) > 40 THEN dy = 1
IF hbos = 1 THEN c1 = 15: dy = -2
CIRCLE (x, y), 20, c1, , , .6
PAINT (x, y), c1, c1
LINE (x - 6, y - 12)-(x + 11, y - 24), c1
LINE (x + 11, y - 24)-(x + 8, y - 14), c1
LINE (x + 8, y - 14)-(x + 16, y - 8), c1
PAINT (x + 3, y - 16), c1, c1
LINE (x - 7, y + 12)-(x + 2, y + 20), c1
LINE (x + 2, y + 20)-(x + 7, y + 12), c1
PAINT (x, y + 16), c1, c1
LINE (x + 18, y)-(x + 40, y - 12), c1
LINE (x + 18, y)-(x + 40, y + 12), c1
LINE (x + 40, y - 12)-(x + 36, y), c1
LINE (x + 36, y)-(x + 40, y + 12), c1
PAINT (x + 24, y), c1, c1
CIRCLE (x - 7, y - 4), 5, 15, , , .9: PAINT (x - 7, y - 4), 15, 15
CIRCLE (x - 7, y - 4 + dy), 2, 0, , , .9: PAINT (x - 7, y - 4 + dy), 0, 0
RETURN

DBOSS6:
a = ((abos MOD 7) - 3) * 12: abos = abos + 1
c1 = 6: c2 = 14: c3 = 11: IF hbos = 1 THEN c1 = 15
a! = a * pi! / 180: r = 20: s = 1
FOR q = -2 TO 1
s = SGN(q + .5): a! = -a!
x1 = COS(a!) * r * s: y1 = SIN(a!) * r
CIRCLE (x + x1, y - y1), 8, c3: PAINT (x + x1, y - y1), c3, c3
x2 = COS(a! - .36) * r * s: y2 = SIN(a! - .36) * r
LINE (x, y)-(x + x2, y - y2), c3
x3 = COS(a! + .36) * r * s: y3 = SIN(a! + .36) * r
LINE (x, y)-(x + x3, y - y3), c3
PAINT (x + x1 * .4, y - y1 * .4), c3, c3
NEXT q
CIRCLE (x, y), 11, c1, , , 1.2: PAINT (x, y), c1, c1
CIRCLE (x, y - 12), 8, c1, -pi! * 1.9, -pi! * 1.1, .8
PAINT (x, y - 14), c1, c1
CIRCLE (x - 5, y - 14), 4, 7, , , .8
PAINT (x - 5, y - 14), A5$, 7
CIRCLE (x + 5, y - 14), 4, 7, , , .8
PAINT (x + 5, y - 14), A5$, 7
LINE (x - 8, y - 3)-(x + 8, y - 1), c2, BF
LINE (x - 7, y + 4)-(x + 7, y + 6), c2, BF
c = cnt1 AND 127
IF PLAY(0) = 0 AND SND = 1 AND c < 32 THEN SOUND 1600 + 200 * RND, .6
RETURN

DBOSS7:
c1 = 4: c2 = 12: abos = abos + 1: s = SGN(abos AND 16) * 10
c3 = 4: IF hbos = 1 THEN c3 = 15
IF stbos < 12 THEN c3 = 1
c4 = csb(stbos / 16)
CIRCLE (x - 32, y - 14), 4, 2, , , 1
CIRCLE (x, y - 12), 20, 15
CIRCLE (x + 32, y - 14), 4, 2, , , 1
CIRCLE (x, y - 13), 7, 15, -pi! * 2, -pi!
PAINT (x, y - 14), c4, 15
PAINT (x - 32, y - 15), s, 2
PAINT (x + 32, y - 15), 10 - s, 2
LINE (x - 50, y - 10)-(x + 50, y - 10), c1
LINE (x - 25, y + 10)-(x + 25, y + 10), c1
LINE (x - 50, y - 10)-(x - 80, y), c1
LINE (x - 80, y)-(x - 80, y + 4), c1
LINE (x - 80, y + 4)-(x - 25, y + 10), c1
LINE (x + 50, y - 10)-(x + 80, y), c1
LINE (x + 80, y)-(x + 80, y + 4), c1
LINE (x + 80, y + 4)-(x + 25, y + 10), c1
PAINT (x, y), c1, c1
PAINT (x - 40, y), c1, c1: PAINT (x + 40, y), c1, c1
LINE (x - 40, y - 13)-(x - 43, y - 11), c1
LINE (x - 40, y - 13)-(x + 40, y - 13), c1
LINE (x + 40, y - 13)-(x + 43, y - 11), c1
PAINT (x, y - 12), c2, c1
LINE (x - 80, y - 1)-(x + 80, y + 3), 14, BF
xx = x - 88 + (abos MOD 24)
FOR q = 1 TO 7
LINE (xx, y - 1)-(xx + 11, y + 3), 0, BF
xx = xx + 24
NEXT q
LINE (x - 80, y + 4)-(x - 25, y + 10), c3
LINE (x - 25, y + 10)-(x + 25, y + 10), c3
LINE (x + 80, y + 4)-(x + 25, y + 10), c3
RETURN

REM  - - - - - - - - - - - - - - - - - - - - - - - - - - -

DSTG1:
a1! = pi! - .7
FOR n = 1 TO 21
r1 = 400 + 20 * RND
x1 = COS(a1!) * r1 + 300: y1 = 450 - SIN(a1!) * r1
FOR m = 1 TO 20
 a2! = pi! * 2 * RND
 r = 36 * RND: x2 = x1 + COS(a2!) * r: y2 = y1 + SIN(a2!) * r
 PSET (x2, y2), 1
 r = 28 * RND: x2 = x1 + COS(a2!) * r: y2 = y1 + SIN(a2!) * r
 PSET (x2, y2), 9
 r = 16 * RND: x2 = x1 + COS(a2!) * r: y2 = y1 + SIN(a2!) * r
 PSET (x2, y2), 11
 r = 12 * RND: x2 = x1 + COS(a2!) * r: y2 = y1 + SIN(a2!) * r
 PSET (x2, y2), 15
NEXT m
a1! = a1! - .05
NEXT n
RETURN

DSTG2:
c1 = 11: c2 = 9: c3 = 1
FOR n = 1 TO 32
x = 320 * RND: y = 200 * RND
c = 12 + INT(4 * RND): IF c = 13 THEN c = 4
PSET (x, y), c
NEXT n
x = 169: y = 109
CIRCLE (x, y), 36, 9, , , 1
CIRCLE (x, y), 37, 1, , , .94
CIRCLE (x - 19, y - 16), 18, c1, pi2! * 3, pi2! * 4
CIRCLE (x + 19, y - 16), 18, c1, pi2! * 2, pi2! * 3
CIRCLE (x - 19, y + 16), 18, c1, pi2! * 0, pi2! * 1
CIRCLE (x + 19, y + 16), 18, c1, pi2! * 1, pi2! * 2
LINE (x, y - 17)-(x, y - 50), c1
LINE (x, y + 17)-(x, y + 42), c1
LINE (x - 20, y)-(x - 48, y), c1
LINE (x + 20, y)-(x + 44, y), c1
LINE (x, y - 40)-(x, y - 50), c2
LINE (x, y + 40)-(x, y + 45), c2
LINE (x - 34, y)-(x - 48, y), c2
LINE (x + 34, y)-(x + 44, y), c2
LINE (x, y - 50)-(x, y - 54), c3
LINE (x, y + 45)-(x, y + 50), c3
LINE (x - 48, y)-(x - 52, y), c3
LINE (x + 44, y)-(x + 48, y), c3
PAINT (x, y), 15, c1
RETURN

DSTG3:
x = xs!: y = ys!: r1 = rs!: rsmax! = 30
c1 = 4: c2 = 14: c3 = 4: a2! = 0

a2! = a2! + .03
r2 = 0: n = 0: a! = 0
FOR a! = 0 TO pi! * 2 STEP .2
 x0 = x1: y0 = y1
 f = (r1 / 6) * RND: a1! = a! + .1 * RND
 r = r1 + r2 * f: r2 = 1 - r2
 x1 = SIN(a1! + a2!) * r + x: y1 = COS(a1! + a2!) * r + y
 IF n = 0 THEN x2 = x1: y2 = y1
 IF n > 0 THEN LINE (x0, y0)-(x1, y1), c1
 n = n + 1
NEXT a!
LINE (x1, y1)-(x2, y2), c1
PAINT (x, y), c2, c1
CIRCLE (x, y), r1 - 2, c3, , , 1
PAINT (x, y), 0, c3
RETURN


DSTG4:
x = xs!: y = ys!: r1 = rs!: rsmax! = 60
c1 = 1: c2 = 9: c3 = 11: c4 = 11

CIRCLE (x, y), r1, c1
CIRCLE (x, y), r1, c2, pi2! * 3, pi2!

CIRCLE (x, y), r1 * .84, c1, pi2!, pi2! * 3, 3
PAINT (x - r1 * .5, y), c1, c1
CIRCLE (x, y), r1 * .84, c2, pi2!, pi2! * 3, 3
PAINT (x + r1 * .5, y), c2, c2

x1 = x - r1 * .36: y1 = y - r1 * .16
CIRCLE (x1, y1), r1 * .16, c2, , , .7: PAINT (x1, y1), c2, c2
x1 = x - r1 * .8: y1 = y - r1 * .05
CIRCLE (x1, y1), r1 * .16, c2, , , 1.8: PAINT (x1, y1), c2, c2
x1 = x - r1 * .6: y1 = y + r1 * .05
CIRCLE (x1, y1), r1 * .2, c2, , , 1: PAINT (x1, y1), c2, c2
x1 = x - r1 * .3: y1 = y + r1 * .1
CIRCLE (x1, y1), r1 * .3, c2: PAINT (x1, y1), c2, c2
x1 = x - r1 * .3: y1 = y + r1 * .1
CIRCLE (x1, y1), r1 * .3, c3, -pi2! * 3.1, -pi2! * .95
PAINT (x1 + r1 * .1, y1), c3, c3

x1 = x + r1 * .24: y1 = y - r1 * .5
CIRCLE (x1, y1), r1 * .16, c3, , , .8: PAINT (x1, y1), c3, c3
x1 = x + r1 * .33: y1 = y - r1 * .3
CIRCLE (x1, y1), r1 * .2, c3, , , .9: PAINT (x1, y1), c3, c3
x1 = x + r1 * .46: y1 = y - r1 * .46
CIRCLE (x1, y1), r1 * .14, c3, , , .9: PAINT (x1, y1), c3, c3

x1 = x + r1 * .02: y1 = y + r1 * .75
CIRCLE (x1, y1), r1 * .12, c3, , , .4: PAINT (x1, y1), c3, c3
x1 = x + r1 * .07: y1 = y + r1 * .67
CIRCLE (x1, y1), r1 * .15, c3, , , .4: PAINT (x1, y1), c3, c3
x1 = x + r1 * .2: y1 = y + r1 * .6
CIRCLE (x1, y1), r1 * .15, c3, , , .66: PAINT (x1, y1), c3, c3

x1 = x + r1 * .9: y1 = y + r1 * .02
CIRCLE (x1, y1), r1 * .14, c3, , , 3: PAINT (x1, y1), c3, c3
x1 = x + r1 * .7: y1 = y + r1 * .13
CIRCLE (x1, y1), r1 * .17, c3, , , 1.2: PAINT (x1, y1), c3, c3

x1 = x - r1 * .01: y1 = y - r1 * .8
CIRCLE (x1, y1), r1 * .12, c3, -pi2! * 2.5, -pi2! * 1.3, .2: PAINT (x1 + r1 * .06, y1), c3, c3
x1 = x - r1 * .08: y1 = y - r1 * .8
CIRCLE (x1, y1), r1 * .12, c2, -pi2! * 1, -pi2! * 2.8, .2
PAINT (x1 - r1 * .04, y1), c2, c2

CIRCLE (x, y), r1, c4, pi2! * .28, pi2! * .7
RETURN


DSTG5:
x = xs!: y = ys!: r1 = rs!: rsmax! = 50
c1 = 6: c2 = 4: c3 = 12: c4 = 4
a1! = pi2! * 2: a2! = pi2! * 4: f! = .2
CIRCLE (x, y), r1, c2
PAINT (x, y), c1, c2
CIRCLE (x, y - r1 * .8), r1 * .2, c2, a1!, a2!, f!
CIRCLE (x, y - r1 * .7), r1 * .5, c2, a1!, a2!, f!
CIRCLE (x, y - r1 * .56), r1 * .74, c2, a1!, a2!, f!
CIRCLE (x, y - r1 * .4), r1 * .89, c2, a1!, a2!, f!
CIRCLE (x, y - r1 * .32), r1 * .93, c2, a1!, a2!, f!
CIRCLE (x, y - r1 * .16), r1 * .98, c2, a1!, a2!, f!
CIRCLE (x, y + r1 * .06), r1 * 1, c2, a1!, a2!, f!
CIRCLE (x, y + r1 * .29), r1 * .94, c2, a1!, a2!, f!
CIRCLE (x, y + r1 * .42), r1 * .87, c2, a1!, a2!, f!
CIRCLE (x, y + r1 * .6), r1 * .69, c2, a1!, a2!, f!
PAINT (x, y - r1 * .16), c2, c2
PAINT (x, y + r1 * .38), c2, c2
PAINT (x, y + r1 * .78), c2, c2
CIRCLE (x, y), r1, c3, pi2! * .2, pi2! * 1.4
a1! = pi2! * 1.5: a2! = pi2! * .5
CIRCLE (x, y + r1 * .04), r1 * 1.6, c4, pi2! * 1.42, pi2! * .58, f!
CIRCLE (x, y + r1 * .04), r1 * 1.76, c1, pi2! * 1.36, pi2! * .64, f!
CIRCLE (x, y + r1 * .04), r1 * 1.8, c4, pi2! * 1.36, pi2! * .64, f!
RETURN


DSTG6:
x = xs!: y = ys!: r1 = rs!: rsmax! = 60
c1 = 8: c2 = 7: c3 = 15: c4 = 8
a1! = -pi2! * 1.1: a2! = -pi2! * 3 * .9

CIRCLE (x, y), r1, c1
CIRCLE (x, y), r1, c2, pi2!, pi2! * 3

CIRCLE (x, y), r1 * .84, c2, pi2! * 3, pi2!, 1.6
PAINT (x - r1 * .5, y), c2, c2
CIRCLE (x, y), r1 * .84, c1, pi2! * 3, pi2!, 1.6
PAINT (x + r1 * .8, y), c1, c1

x1 = x - r1 * .25: y1 = y - r1 * .2
CIRCLE (x1, y1), r1 * .24, c1: PAINT (x1, y1), c1, c1
CIRCLE (x1, y1), r1 * .24, c3, a1!, a2!: PAINT (x1 - r1 * .05, y1), c3, c3
CIRCLE (x1 - r1 * .02, y1), r1 * .18, c2: PAINT (x1, y1), c2, c2
x1 = x - r1 * .8: y1 = y - r1 * .04
CIRCLE (x1, y1), r1 * .13, c1, , , 1.6: PAINT (x1, y1), c1, c1
CIRCLE (x1, y1), r1 * .13, c3, a1!, a2!, 1.6: PAINT (x1 - r1 * .05, y1), c3, c3
CIRCLE (x1 - r1 * .01, y1), r1 * .08, c2, , , 1.6: PAINT (x1, y1), c2, c2
x1 = x - r1 * .5: y1 = y + r1 * .3
CIRCLE (x1, y1), r1 * .1, c1, , , 1: PAINT (x1, y1), c1, c1
CIRCLE (x1, y1), r1 * .1, c3, -a1!, -a2!, 1

x1 = x + r1 * .14: y1 = y - r1 * .55
CIRCLE (x1, y1), r1 * .13, c1, , , .66: PAINT (x1, y1), c1, c1
x1 = x + r1 * .3: y1 = y + r1 * .1
CIRCLE (x1, y1), r1 * .2, c1, , , .9: PAINT (x1, y1), c1, c1
x1 = x + r1 * .02: y1 = y + r1 * .75
CIRCLE (x1, y1), r1 * .12, c1, , , .4: PAINT (x1, y1), c1, c1
x1 = x - r1 * .07: y1 = y + r1 * .5
CIRCLE (x1, y1), r1 * .15, c1, , , .8: PAINT (x1, y1), c1, c1
x1 = x - r1 * .01: y1 = y - r1 * .8
CIRCLE (x1, y1), r1 * .12, c1, , , .2: PAINT (x1 + r1 * .06, y1), c1, c1
CIRCLE (x1, y1), r1 * .12, c3, -a1!, -a2!, .2

x1 = x + r1 * .9: y1 = y + r1 * .05
CIRCLE (x1, y1), r1 * .1, c4, , , 3: PAINT (x1, y1), c4, c4
CIRCLE (x1, y1), r1 * .1, c2, -a1!, -a2!, 3
CIRCLE (x1 + r1 * .02, y1), r1 * .1, c2, -a1!, -a2!, 3
x1 = x + r1 * .7: y1 = y + r1 * .2
CIRCLE (x1, y1), r1 * .15, c4, , , 1.5: PAINT (x1, y1), c4, c4
CIRCLE (x1, y1), r1 * .15, c2, -a1!, -a2!, 1.5
CIRCLE (x1 + r1 * .02, y1), r1 * .15, c2, -a1!, -a2!, 1.5
x1 = x + r1 * .62: y1 = y - r1 * .35
CIRCLE (x1, y1), r1 * .05, c4, , , 1.2: PAINT (x1, y1), c4, c4
CIRCLE (x1, y1), r1 * .05, c2, -a1!, -a2!, 1.2
CIRCLE (x1 + r1 * .02, y1), r1 * .05, c2, -a1!, -a2!, 1.2
RETURN

DSTG7:
c1 = 1: c2 = 9: c3 = 11: c4 = 15: c5 = 2: c6 = 10
FOR n = 1 TO 32
x = 320 * RND: y = 200 * RND: c = 7 + INT(2 * RND) * 8
PSET (x, y), c
NEXT n
x = -20: y = 330: r1 = 300
CIRCLE (x, y), r1, c1: PAINT (0, 199), c1, c1
CIRCLE (x, y), r1 * .985, c2: PAINT (0, 199), c2, c2
CIRCLE (x, y), r1 * .97, c3: PAINT (0, 199), c3, c3
CIRCLE (x, y), r1 * .955, c4: PAINT (0, 199), c4, c4
CIRCLE (x, y), r1 * .94, c3: PAINT (0, 199), c3, c3
CIRCLE (x, y), r1 * .925, c2: PAINT (0, 199), c2, c2
CIRCLE (x, y), r1 * .91, c1: PAINT (0, 199), c1, c1
y1 = 0
RESTORE EARTH
DO
x0 = x1: y0 = y1: READ x1, y1
IF y0 > 0 AND y1 > 0 THEN LINE (x0, y0)-(x1, y1), c5
LOOP UNTIL x1 = -1 AND y1 = -1
PAINT (0, 199), c6, c5
PAINT (130, 199), c6, c5
RETURN

EARTH:
DATA 0,119, 24,121, 40,124, 70,134, 69,138, 62,140, 79,148, 73,148, 84,155
DATA 82,154, 86,157, 88,162, 80,161, 70,158, 73,164, 88,172, 70,182
DATA 52,180, 48,183, 52,187, 51,193, 46,193, 62,199, 0,0
DATA 108,199, 114,186, 124,177, 123,172, 131,172, 138,185, 144,186, 147,192
DATA 154,194, 161,195, 165,199
DATA -1,-1

REM  - - - - - - - - - - - - - - - - - - - - - - - - - - -

LOAD.SPRITES:
ENEMY$(1, 0) = "br5h8d4g4f4d4e8bl5"
ENEMY$(1, 1) = "br4h5d3g2f2d3e5bl4"
ENEMY$(1, 2) = "br6h5l2d10r2e5bl2"
ENEMY$(1, 3) = "bl1h7d5g2f2d5e7bl3"
ENEMY$(2, 0) = "br4e2h8g6f4g4f6e8h2bl4"
ENEMY$(2, 1) = "bl4e4f4g4h4br4"
ENEMY$(3, 0) = "e7l14f3d8g3r14h7bl1"
ENEMY$(3, 1) = "br6bu5l10bd10r10"
ENEMY$(4, 0) = "bu3br5d6g6l6e6u6h6r6f6bd3bl3"
ENEMY$(4, 1) = "bl5d3g5r4e5u6h5l4f5d3br2"
ENEMY$(5, 0) = "br3f3g3h3g5h3e5h5e3f5e3f3g3bl2"
ENEMY$(5, 1) = "br2e3d6h3br1"
ENEMY$(6, 0) = "g9l5e3u3e3h3u3h3r5f9bl4"
ENEMY$(6, 1) = "bl7e2r8f2g2l8h2br7"
ENEMY$(7, 0) = "h5l5f5g5r5e5bl3"
ENEMY$(7, 1) = "bl4u2r16f1r4f1g1l4g1l16u2l3br8"
ENEMY$(8, 0) = "bu4br7d8g4l6h5u8e4r6 f5"
ENEMY$(8, 1) = "bl1bd1g5l8e5r8bl7bd3"
ENEMY$(9, 0) = "bd5br6g2l4h5u7e4r2 l1"
ENEMY$(9, 1) = "bd10bl4e3r5g4l4u1br3bu2"
ENEMY$(10, 0) = "br7g9l3h3u3e3h3u3e3r3f9bl7"
ENEMY$(10, 1) = "br7g3l6h3e3r6f3bl8"
ENEMY$(10, 2) = "br6g4l10h2u4e2r10f4bl6"
ENEMY$(10, 3) = "br7g3l6h3e3r6f3bl7"
ENEMY$(11, 0) = "br7g9l3h3u3e3h3u3e3r3f9bl7"
ENEMY$(11, 1) = "br7g3l6h3e3r6f3bl8"
ENEMY$(11, 2) = "br6g4l10h2u4e2r10f4bl6"
ENEMY$(11, 3) = "br7g3l6h3e3r6f3bl7"

CRASH$(1) = "br4bu4h8d8g8r8f8u8e8l8bd4"
CRASH$(2) = "br4f4l4d4h4g4u4l4e4h4r4u4f4e4d4r4g4bl4"
CRASH$(3) = "br4d8h4l8e4u8f4r8g4bl4"

SHOT$(1) = "bl2bu2r2d4r2"
SHOT$(2) = "bl2bu2r4d4l4u4"
RETURN

LOAD.CHARSET:
CH$(0) = "br1r3f2d4g1l3h2u4e1"
CH$(1) = "br3ng1d7nl2r2"
CH$(2) = "bd2u1e1r3f1d1g2l1g2d1r5"
CH$(3) = "r5g3r2f1d2g1l3h1"
CH$(4) = "br4bd7u7g4d1r5"
CH$(5) = "br5l5d2r4f1d3g1l3h1"
CH$(6) = "br5l2g3d2f2r3e1u1h2l3g1"
CH$(7) = "r5d1g3d3"
CH$(8) = "br2r2f1d1g1l3g1d2f1r4e1u1h2l2h2e1r1"
CH$(9) = "bd7br1r2e3u2h2l3g1d1f2r3e1"
CH$(17) = "bd7u3nr5u2e2r1f2d5"
CH$(18) = "nd7r3f1d1g1bl3r4f1d2g1l4"
CH$(19) = "br4l2g2d4f1r3e1"
CH$(20) = "bd7u7r4f1d4g2l3"
CH$(21) = "nr4d3nr3d3f1r4"
CH$(22) = "br5l4g1d2nr3d4"
CH$(23) = "br4l2g2d4f1r3e1u3l2"
CH$(24) = "d7bu4r5bu3d7"
CH$(25) = "br2r2bl1d7bl1r2"
CH$(26) = "br1r4d5g2l2u1"
CH$(27) = "d7bu4r1ne3nf4"
CH$(28) = "d7r5"
CH$(29) = "bd7u6e1f2e2f1d6"
CH$(30) = "bd7u7f5nd2u5"
CH$(31) = "br2r2f1d4g2l2h1u4e2"
CH$(32) = "bd7u7r4f1d2g1l4"
CH$(33) = "br1r2f2d4nh2nf1g1l2h2u4e1"
CH$(34) = "bd7u7r4f1d1g1l4br1f4"
CH$(35) = "br5l3g2f1r3f1d2g1l5"
CH$(36) = "r6bl3d7"
CH$(37) = "d5f2r3e1u6"
CH$(38) = "d6f1e4u3"
CH$(39) = "d6f1e2nu2f2e1u6"
CH$(40) = "r1f2d3f2r1bl6r1e2bu3e2r1"
CH$(41) = "d2f3nd2e3u2"
CH$(42) = "r6d1g6r6"
RETURN

LOAD.SOUNDS:
REM 2,7,10,13,15,19,22,25,27,31,34,39,43,46,58
SLASER1$ = "MBT255l64n58n57n56n55n54"
SLASER2$ = "MBT255l48n58n56n54n52n58n56n54n52"
SSHOOT1$ = "MBT255l64n63n61n58n55n58"
SSHOOT2$ = "MBT255l64n61n58n55"
SSHOOT3$ = "MBT255l48n7n10n7"
SETYPE1$ = "MBT255l32n39n34n31n27n25n22n19n15n13n10n7n2"
SETYPE2$ = "MBT255l40n60n59n58n57n19n13n10n7n2n7n5n1n3n1n2n1"
SETYPE3$ = "MBT255l32n36n24n1n17n2n19n0n11n1n15n3n17n2n9n1n6n2n4n1n3n1"
SETYPE4$ = "MBT255l64n50n48n45n41n36n50n47n43n37n33n26n19n12n1n9n1n7n1n5n1n3n1"
SETYPE6$ = "MBT255l40n39n31n25n19n13n7n2n7n10n7n13n15n19n15n22n25n27n25n31n34n39n34n43n46"
SETYPE8$ = "MBT255l32n2n7n10n13n15n19n22n25n27n31n34n39n43n46n58"
SETYPE9$ = "MBT255l40n58n46n43n39n34n31n27n25n22n19n15n13"
SETYPE10$ = "MBT255l32n56n55n53n50n45n43n41n40n41n43n45n50n53n55n56"
SETYPE11$ = "MBT255l64n70n69n68n67n66n65n64n63n62n61n60"
SCRASH8$ = "MBT255l64n58n25n19n13n10n7n2n7n5n1n3n1n2n1"
SCRASH9$ = "MBT255l32n30n1n23n2n19n3n14n2n15n1n11n1n7n1n4n1n5n1n3n1n2n1n0n1n3n1n2n1"
SNEW1$ = "MBT255l24n58n57n58n53n57n58"
SNEWPL1$ = "MBT255l3n25n32"
SNEWPL2$ = "MBT255l8n25n32"
SDOCK2$ = "MBT255l32n15n17n15n17n20n25n29n32n37"
SRGTON$ = "MBT80l24n27n0l24n27n29n34n31n34n31l12n29l24n29n32l6n36l24n38n34n31n38n34n31n38n34l12n39l24n38l8n39"
SLAUNCH$ = "MBT96l64n27l8n22l16n22l4n27n34l16n0n22MLl4n27n34MSl24n39n0n0l32n39n0l48n39n0l64n39n0n39n0l32n39n0n39n0l48n39n0n39n0l24n51MN"
SFAROUT1$ = "MBT80l8n22l12n22l8n26l12n26l8n29l12n29l8n34l12n34l8n22l12n22l8n26l12n26l8n29l12n29l8n34l12n34"
SFAROUT2$ = "MBT80l64n17l8n22l12n22l64n17l8n26l12n26l64n17l8n29l12n29l64n17l8n34l12n34"
SEND$ = "MBT96l6n22l16n27l2n25l16n27l8n25n27n29l16n25n27l48n25n27l12n29l32n27n29n27n29l4n34"
SBONPLAY$ = "MBT64l64n15n22n19n22n19n22n27l32n34"
SHITBOS1$ = "MBT255l64n63n62n61n60n50n40n30n20n13n10n8n7n5n4n3n2n1n1n1"
SBOSPTS$ = "MBT255l64n46n45n44n43n42n41n40n39n38n37n36n35n34"
SSTAGE1$ = "MBMST64l32n40n0n40n40n0n40n40n40n40n0n40n40n0n40n0n40n0n40n40n40n0n40n0MN"
SSTAGE2$ = "MBT255l32n19n22n25n27n31n34n39n43n46"

SFINAL$(1, 1) = "MBMNT64l4n25l24n18n18l4n25l24n18n18l24n25n0n30n0l4n25"
SFINAL$(1, 2) = "MBMNT64l24n18n18l24n25n0n30n0l3n32"
SFINAL$(1, 3) = "MBMNT64l24n23n23l24n28n0n30n0l8n32l24n34l4n35"
SFINAL$(1, 4) = "MBMNT64l6n37l6n34l8n30n28n32n35"
SFINAL$(1, 5) = "MBMLT64l8n39l6n37l6n34l8n30n28n32n35n39l6n42"
SFINAL$(1, 6) = "MBMLT64l64n37n42n49n37n42n49n37n42n49n37n42n49n37n42n49n37n42n49l16n42"
SFINAL$(1, 7) = "MBMLT64"
SFINAL$(2, 1) = "MBMNT64l6n13n15n18n20n25l24n23n22l12n20l6n23l24n22n20l12n18n22n18l6n20"
SFINAL$(2, 2) = "MBMLT64l64n25n30n37MNl16n0l24n13n13n18n0n18n18n20n0n20n20n25n0n25n25n23n22n20n0"
SFINAL$(2, 3) = "MBMNT64l24n23n0n23n23n22n20n18n0l12n22l24n23n0n18n0n22n0l4n20"
SFINAL$(2, 4) = "MBMNT64l16n8n8n8n0n8n0n8n0n8n8n8n0n8n0"
SFINAL$(2, 5) = "MBMNT48l64n20l4n32MLl12n32n30n29n27n25l4n30l24n32n34l4n32"
SFINAL$(2, 6) = "MBMNT48l12n8l4n32MLl12n32n30n29n27T64n25l4n35l24n37n39"
SFINAL$(2, 7) = "MBMLT64l64n25n37n25n37n25n37n25n37n25n37n25n37n25n37n25n37l8n37"
RETURN

CREDITS:
DATA " ", " ", " "
DATA "   YOU SAVED", "   THE GALAXY", " ", " ", " ", " "
DATA " CONGRATULATIONS", " ", "  THE MISSION", "IS ACCOMPLISHED"
DATA " ", "THE ALIENS HAVE", "     LEFT", " AND THE EARTH"
DATA "  IS NOW FREE", " ", "YOU HAVE BROUGHT", " BACK PEACE TO"
DATA "   OUR GALAXY", " ", "WE WILL THANK", " YOU FOREVER"
DATA " ", "    THE FORCE", "WILL BE WITH YOU", "     ALWAYS"
DATA " ", " ", " ", " ", "     THE END"


TITLE.HELP:
RESTORE THELP.TEXT
SCREEN 7, 0, 2, 2: tcnt = 0: tpos = 0: sss = 0
CLS : COLOR 15, 1

THELP.MAIN:
k = INP(96): k$ = INKEY$: da = 0
IF k = 1 THEN COLOR 15, 0: SCREEN 7, 0, scr, scr: GOTO WAITKEY0
WAIT &H3DA, 8: WAIT &H3DA, 8, 8
IF tcnt < 22 THEN GOSUB THELP.SOFT
IF k = 80 OR k = 77 OR tcnt < 22 THEN GOSUB THELP.SCROLL
IF k = 72 THEN RESTORE THELP.TEXT: CLS : tcnt = 0: tpos = 0: sss = 0
GOTO THELP.MAIN

THELP.SOFT:
a = 16024 + (tpos) * 80
OUT &H3D4, 12: OUT &H3D5, INT(a / 256)
OUT &H3D4, 13: OUT &H3D5, a AND 255
RETURN

THELP.SCROLL:
tpos = (tpos + 1) AND 3
IF tpos <> 2 OR sss > 0 THEN RETURN
LOCATE 24, 1: READ T$: PRINT T$: tcnt = tcnt + 1
IF T$ = "XXX" THEN sss = 1
IF SND = 1 THEN SOUND 600, .2
RETURN

THELP.TEXT:
DATA "- INCOMING MESSAGE -"
DATA ""
DATA "                        16.Dec. 2011"
DATA ""
DATA "THE UNITED EARTH ADMINISTRATION"
DATA "- - - - - - - - - - - - - - - -"
DATA ""
DATA ""
DATA "ALIENS HAVE INVADED TO OUR GALAXY."
DATA "THEY BUILD BASES TO NEARBY STARS "
DATA "IN RANGE OF SEVERAL LIGHT YEARS."
DATA "BEFORE WE COULD START ANY COUNTER"
DATA "MEASURES TO PROTECT OURSELF,"
DATA "THEY NOTICED OUR TELEMITRY SIGNALS,"
DATA "SENT BETWEEN THE EARTH AND OUR"
DATA "SATELLITES "
DATA ""
DATA "THEY REACHED OUR SOLAY SYSTEM AND"
DATA "INSTANTLY OCCUPIED ONE PLANET"
DATA "AFTER ANOTHER, STARTING WITH PLUTO"
DATA "OVER TO NEPTUN, SATURN, JUPITER AND"
DATA "FINALLY THE EARTH MOON, WHERE THEY  >>"
DATA "LOCATED THEIR GIANT NEXUS MOTHERSHIP"
DATA ""
DATA "WITH DESTROYING OUR SPACE STATION"
DATA "AND SEVERAL ORBIT SHUTTLES, COSTING"
DATA "OVER 10.000 HUMAN LIFES, THEYïVE"
DATA "DEMONSTRATED THEIR EXTREMELY AGRESSIVE
DATA "INTENTIONS"
DATA ""
DATA "ITS ASSUMED FOR CLEAR THAT THE"
DATA "MOTHERSHIP PREPARES FOR THE FINAL"
DATA "ATTACK ON THE EARTH"
DATA "AND IF THIS HAPPENS MANKIND CAN KISS"
DATA "THE DAYïS GOODBYE, THATS FOR SURE"
DATA ""
DATA "GOD, WE NEED SOMEONE WHO BLOWS THESE"
DATA "BASTARDS TO PIECES !"
DATA "WE NEED TO DESTROY ALL THEIR HOMEBASES"
DATA "TO BREAK UP THEIR SUPPLY LINE,"
DATA "STARTING AT THE VEGA CONSTELLATION"
DATA "37 LIGHTYEARS AWAY"
DATA ""
DATA ">> So, fine, but what has all this"
DATA "to do with me ? << YOU ASK
DATA ""
DATA "CAUSE ALL OUR ASTRONAUTS HAVE SUDDENLY"
DATA "GONE ON VACATION 3 DAYS AGO,"
DATA "WE ENGAGED YOU. YOUïRE OUR LAST HOPE !"
DATA ""
DATA "ALTHOUGH YOURE NO ASTRONAUT, NOT EVEN
DATA "A PILOT, THAT DOESNïT REALLY MATTER."
DATA ""
DATA "WEïVE SIMPLIFIED THE SHIPïS CONTROLS SO"
DATA "THAT EVEN AN AVERAGE CLEVER SPACE-COW"
DATA "CAN FLY IT"
DATA "LOOK, ITS REALLY EASY:"
DATA "","",""
DATA "- - - - - - - - - - - - - - - - - - -"
DATA "Lunar Module Control Keys"
DATA "","",""
DATA "Arrow Left / Num 4    = Move Left "
DATA "Arrow Left / Num 6    = Move Right"
DATA "Left Strg             = Fire / Thrust"
DATA "S                     = Sound On/Off"
DATA "P                     = Pause"
DATA "
DATA "Hint:"
DATA "Use the Num-Keys for better control"
DATA "","",""
DATA "Bonus Ship given every 20000 Pts"
DATA "Successful Docking increases Firepower"
DATA "Hitpoints increase every Stage"
DATA ""
DATA "- - - - - - - - - - - - - - - - - - -"
DATA "","","",""
DATA "YOU ARE SUPPLIED WITH 3 SEPERATE LUNAR"
DATA "MODULES, OUTFITTET WITH A STAR-DRIVE"
DATA "AND HIGH-VOLTAGE PLASMA LAUNCHERS"
DATA ""
DATA "THE MODULES CAN BE FLOWN SEPERATLY OR"
DATA "CONNECTED, WHICH GIVES AN EXTRA
DATA "FIRE-POWER."
DATA "HOWEVER, TO SAVE MODULES, THEY ARE"
DATA "DISCONNECTED AUTOMATICALLY WHEN POSSIBLE"
DATA "OR WHEN ONE OF THEM GETS DESTROYED."
DATA ""
DATA "IF THIS HAPPENS, YOU SHOULD BE EJECTED"
DATA "AND WHEN YOUïVE BEEN EJECTED, YOU
DATA "SHOULD ENTER THE NEXT INTACT SECTION"
DATA "AUTOMATICALLY."
DATA ""
DATA "- Why SHOULD ?
DATA ""
DATA "THE SYSTEMïS NOT PERFECT YET, CAUSE"
DATA "THE SHIPïS COMPUTER CRASHES FROM"
DATA "TIME TO TIME. BUT DONïT PANIC,"
DATA "OUR ENGINEERS WILL FIX THAT BY SENDING"
DATA "YOU UPDATE VERSIONS OF THE SHIPïS"
DATA "COMPUTERïS OPERATING SYSTEM"
DATA "(Windows 2011 v4.1.0.2.1-beta-beta)"
DATA ""
DATA ""
DATA "THE EARTH BASE WILL TRY TO SUPPLY YOU"
DATA "CONSTANTLY WITH NEW MODULES"
DATA ""
DATA "BUT PLEASE HANDLE WITH CARE,"
DATA "WE CANïT BAKE THEM LIKE BREADS"
DATA ""
DATA "GOOD LUCK!"
DATA "","","","",""
DATA "END OF MESSAGE."
DATA "","","","","","","","","","","",""
DATA "GAME INFO"
DATA ""
DATA "This programm was intended as a tutorial"
DATA "for beginners who want to learn"
DATA "programming in Qbasic, demonstrating"
DATA "some of its capabillities for making"
DATA "sound and graphics."
DATA "It uses PLAY and SOUND for music and"
DATA "most of the Graphic functions,"
DATA "exspecially the DRAW Command for Sprites"
DATA "(which lets you rotate and scale)."
DATA "Even if some of the letters look like"
DATA "vectors, but they are all DRAW-Sprites"
DATA ""
DATA "The inspiration and ideas i lend
DATA "(took, stole) from following games:"
DATA "Mooncresta arcade game (1983)"
DATA "Galaga 88 arcade"
DATA "Space Pilot I-II (C64)"
DATA "(They belong to my all-time favorite
DATA "shoot-em-ups)"
DATA ""
DATA "In the beginning i just wanted to make"
DATA "a simple shooter (what it still is) but"
DATA "then those old shooting games came to"
DATA "mind, exspecially Mooncresta (obviously"
DATA "you can see where i got the title),"
DATA "which i played as a kid totally"
DATA "fascinated me."
DATA "Those games had great graphics and
DATA "sound (for this time) and where FUN"
DATA "to play."
DATA "So i also wanted to put in something of"
DATA "these games, and as the programm grew"
DATA "bigger and bigger, i decided to make a"
DATA "complete game of it, and hereïs whats"
DATA "the result.
DATA "(hope you like this piece of ïcrapï)"
DATA "",""
DATA "Mooncr.99 made by Daniel Kupfer
DATA "in Nov.1999"
DATA "Mail me if U like"
DATA "EMail dk1000000@aol.com"
DATA "   or dku1000000@cs.com"
DATA "","","",""
DATA "Machine Requirements:"
DATA "",""
DATA "Qbasic:   Pentium 200"
DATA "Compiled: 486-66 / Pentium 66"
DATA ""
DATA "As its Qbasic you need decent computer"
DATA "power to run at full speed (35 frames)"
DATA "It works just fine on my P-II 233"
DATA "Iïve never tried to compile this"
DATA "with Quick Basic"
DATA "ïcause i donït own Quick Basic, but if"
DATA "it works, i guess its gonna be 5 times"
DATA "faster or so (however it never runs"
DATA "more than 35 frames)"
DATA "",""
DATA "Enjoy !"
DATA "If you liked it, ask for upcoming"
DATA "mooncr.2000"
DATA ""
DATA "SEE YA!"
DATA "","",""
DATA "PRESS ESC"
DATA "XXX"

