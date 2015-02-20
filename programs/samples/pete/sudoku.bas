DIM gr$(18, 9), rg$(18, 9): SCREEN 7: CLS : FOR a = 1 TO 9: FOR b = 1 TO 9: gr$(a, b) = " ": LINE (((a - 1) * 32), ((b - 1) * 16) + 11)-STEP(32, 16), 8, B
IF a / 3 = INT(a / 3) AND b / 3 = INT(b / 3) THEN LINE (((a - 3) * 32), ((b - 3) * 16) + 11)-STEP(96, 48), 15, B
NEXT b, a: x = 5: y = 5: vv = 1: c = 0: fl = 0: COLOR 10: LOCATE 21, 2: PRINT "CURSORS"; : COLOR 2: PRINT "=move"; : COLOR 10: PRINT " 1-9"; : COLOR 2
PRINT "=number"; : COLOR 10: PRINT " ENTER"; : COLOR 2: PRINT "=solve": COLOR 10: PRINT " SPACE"; : COLOR 2: PRINT "=clear number"; : COLOR 10
PRINT " DELETE"; : COLOR 2: PRINT "=wipe grid": COLOR 1: PRINT " *SuDoKu SoLVeR*  (c)David Hall 2005";
cc: LOCATE (y * 2) + 1, (x * 4) - 1: COLOR 11: i$ = CHR$(2): IF fl = 0 AND gr$(x, y) <> " " THEN i$ = gr$(x, y)
PRINT i$: COLOR 15: i$ = "": c = c + 1: IF c > 2400 THEN c = 0: fl = fl XOR 1
i$ = RIGHT$(INKEY$, 1): IF VAL(i$) > 0 THEN GOSUB hh: IF fl = 0 THEN gr$(x, y) = i$: GOSUB ff: x = x + 1: IF x > 9 THEN x = 1: y = y + 1: IF y > 9 THEN y = 1
IF i$ = " " THEN gr$(x, y) = " ": GOSUB ff: x = x + 1: IF x > 9 THEN x = 1: y = y + 1: IF y > 9 THEN y = 1
IF i$ = CHR$(13) THEN GOSUB ff: GOTO rn
IF i$ = CHR$(75) AND x > 1 THEN GOSUB ff: x = x - 1 ELSE IF i$ = CHR$(77) AND x < 9 THEN GOSUB ff: x = x + 1
IF i$ = CHR$(72) AND y > 1 THEN GOSUB ff: y = y - 1 ELSE IF i$ = CHR$(80) AND y < 9 THEN GOSUB ff: y = y + 1
IF i$ = CHR$(83) THEN RUN ELSE GOTO cc
ff: LOCATE (y * 2) + 1, (x * 4) - 1: PRINT gr$(x, y): RETURN
hh: fl = 0: a = 1: WHILE a < 10: IF gr$(a, y) = i$ OR gr$(x, a) = i$ THEN fl = 1: RETURN
a = a + 1: WEND: a = INT((x - 1) / 3): a = (a * 3) + 1: b = INT((y - 1) / 3): b = (b * 3) + 1
FOR c = a TO a + 2: FOR d = b TO b + 2: IF gr$(c, d) = i$ THEN fl = 1
NEXT d, c: RETURN
rn: COLOR 7: lf = 0: o = 49: a = 1: b = 1: FOR j = 49 TO 57: FOR y = 1 TO 9: FOR x = 1 TO 9: IF j = 49 THEN rg$(x, y) = ""
IF gr$(x, y) <> " " THEN GOTO zz
i$ = CHR$(j): GOSUB hh: IF fl = 0 THEN rg$(x, y) = rg$(x, y) + i$
IF j = 57 AND LEN(rg$(x, y)) = 1 THEN gr$(x, y) = rg$(x, y): GOSUB ff: lf = 1: rg$(x, y) = ""
zz: NEXT x, y, j: IF lf = 1 THEN GOTO rn
pip: i$ = CHR$(o): y = 1: WHILE y < 10: ct = 0: FOR x = 1 TO 9: IF rg$(x, y) = "" THEN GOTO ra
IF INSTR(1, rg$(x, y), i$) > 0 THEN ct = ct + 1: v = x
ra: NEXT x: IF ct = 1 THEN x = v: gr$(x, y) = i$: GOSUB ff: GOTO rn
y = y + 1: WEND: x = 1
WHILE x < 10: tc = 0: FOR y = 1 TO 9: IF rg$(x, y) = "" THEN GOTO ri
IF INSTR(1, rg$(x, y), i$) > 0 THEN tc = tc + 1: v = y
ri: NEXT y: IF tc = 1 THEN y = v: gr$(x, y) = i$: GOSUB ff: GOTO rn
x = x + 1: WEND
WHILE b < 10: ct = 0: FOR c = a TO a + 2: FOR d = b TO b + 2: IF rg$(c, d) = "" THEN GOTO rk
IF INSTR(1, rg$(c, d), i$) > 0 THEN ct = ct + 1: v = c: w = d
rk: NEXT d, c: IF ct = 1 THEN x = v: y = w: gr$(x, y) = i$: GOSUB ff: GOTO rn
a = a + 3: IF a > 7 THEN a = 1: b = b + 3
WEND: o = o + 1: IF o < 58 THEN GOTO pip
IF vv = 1 THEN vv = 2: j = 0: m = 9: GOSUB kl
mf = 0: co = 0: FOR y = 1 TO 9: FOR x = 1 TO 9: i$ = gr$(x, y): IF i$ = " " THEN co = 1: GOTO bl
gr$(x, y) = " ": GOSUB hh: gr$(x, y) = i$: IF fl = 1 OR (gr$(x, y) = " " AND rg$(x, y) = "") THEN mf = 1
bl: NEXT x, y: IF co = 0 AND mf = 0 THEN COLOR 15: FOR y = 1 TO 9: FOR x = 1 TO 9: GOSUB ff: NEXT x, y: END
IF mf = 1 THEN j = 9: m = 0: GOSUB kl
rb: x = INT(RND(1) * 9) + 1: y = INT(RND(1) * 9) + 1: IF LEN(rg$(x, y)) < 2 THEN GOTO rb
gr$(x, y) = MID$(rg$(x, y), INT(RND(1) * LEN(rg$(x, y))) + 1, 1): GOTO rn
kl: FOR y = 1 TO 9: FOR x = 1 TO 9: gr$(x + m, y) = gr$(x + j, y): rg$(x + m, y) = rg$(x + j, y): NEXT x, y: RETURN
