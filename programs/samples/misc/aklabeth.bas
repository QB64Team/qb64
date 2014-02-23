

0  ON ERROR GOTO 4

1  SCREEN 1: VIEW PRINT: CLS : q$ = "": DIM pw(5): DIM c(5): DIM m$(10), ml%(10, 1), mz%(10, 1): DIM w$(5)

4  REM PR# 0: IN# 0

5  REM HIMEM: 49151

'7  CLEAR : GOSUB 60000
7
IF restart% = 1 THEN END
restart% = 1
GOSUB 60000

8  RANDOMIZE ln

9  le = 0

10  SCREEN 1: VIEW PRINT: CLS : PRINT TAB(12); : PRINT " WELCOME TO AKALABETH, WORLD OF DOOM!"

20  DIM dn%(10, 10), te%(20, 20), xx%(10), yy%(10), pe%(10, 3), ld%(10, 5), cd%(10, 3), ft%(10, 5), la%(10, 3)

30  FOR x = 0 TO 20: te%(x, 0) = 1: te%(0, x) = 1: te%(x, 20) = 1: te%(20, x) = 1: NEXT

35  LOCATE 23, 1: PRINT "  (PLEASE WAIT)";

40  FOR x = 1 TO 19: FOR y = 1 TO 19: te%(x, y) = INT(RND(1) ^ 5 * 4.5)

41  IF te%(x, y) = 3 AND RND(1) > .5 THEN te%(x, y) = 0

42  NEXT: PRINT "."; : NEXT: SLEEP 2

50  te%(INT(RND(1) * 19 + 1), INT(RND(1) * 19 + 1)) = 5: tx = INT(RND(1) * 19 + 1): ty = INT(RND(1) * 19 + 1): te%(tx, ty) = 3

51  xx%(0) = 139: yy%(0) = 79

52  FOR x = 2 TO 20 STEP 2: xx%(x / 2) = INT(ATN(1 / x) / ATN(1) * 140 + .5): yy%(x / 2) = INT(xx%(x / 2) * 4 / 7)

53  pe%(x / 2, 0) = 139 - xx%(x / 2): pe%(x / 2, 1) = 139 + xx%(x / 2): pe%(x / 2, 2) = 79 - yy%(x / 2): pe%(x / 2, 3) = 79 + yy%(x / 2): NEXT

54  pe%(0, 0) = 0: pe%(0, 1) = 279: pe%(0, 2) = 0: pe%(0, 3) = 159

55  FOR x = 1 TO 10: cd%(x, 0) = 139 - xx%(x) / 3: cd%(x, 1) = 139 + xx%(x) / 3: cd%(x, 2) = 79 - yy%(x) * .7: cd%(x, 3) = 79 + yy%(x): NEXT: PRINT ".";

56  FOR x = 0 TO 9: ld%(x, 0) = (pe%(x, 0) * 2 + pe%(x + 1, 0)) / 3: ld%(x, 1) = (pe%(x, 0) + 2 * pe%(x + 1, 0)) / 3: w = ld%(x, 0) - pe%(x, 0)

57  ld%(x, 2) = pe%(x, 2) + w * 4 / 7: ld%(x, 3) = pe%(x, 2) + 2 * w * 4 / 7: ld%(x, 4) = (pe%(x, 3) * 2 + pe%(x + 1, 3)) / 3: ld%(x, 5) = (pe%(x, 3) + 2 * pe%(x + 1, 3)) / 3

58  ld%(x, 2) = ld%(x, 4) - (ld%(x, 4) - ld%(x, 2)) * .8: ld%(x, 3) = ld%(x, 5) - (ld%(x, 5) - ld%(x, 3)) * .8: IF ld%(x, 3) = ld%(x, 4) THEN ld%(x, 3) = ld%(x, 3) - 1

59  NEXT

60  FOR x = 0 TO 9: ft%(x, 0) = 139 - xx%(x) / 3: ft%(x, 1) = 139 + xx%(x) / 3: ft%(x, 2) = 139 - xx%(x + 1) / 3: ft%(x, 3) = 139 + xx%(x + 1) / 3

61  ft%(x, 4) = 79 + (yy%(x) * 2 + yy%(x + 1)) / 3: ft%(x, 5) = 79 + (yy%(x) + 2 * yy%(x + 1)) / 3: NEXT

62  FOR x = 0 TO 9: la%(x, 0) = (ft%(x, 0) * 2 + ft%(x, 1)) / 3: la%(x, 1) = (ft%(x, 0) + 2 * ft%(x, 1)) / 3: la%(x, 3) = ft%(x, 4): la%(x, 2) = 159 - la%(x, 3): NEXT

68  LOCATE 1, 1

69  LOCATE 1, 1

70  GOSUB 100: GOTO 1000

90  FOR x = 0 TO 9: FOR y = 0 TO 5: PRINT ld%(x, y); " "; : NEXT: PRINT : NEXT: DO: q$ = INKEY$: LOOP WHILE q$ = ""

100  SCREEN 1: VIEW PRINT 1 TO 21: CLS 2: VIEW PRINT 22 TO 25: WINDOW SCREEN (0, 0)-(279, 199): FOR y = -1 TO 1: FOR x = -1 TO 1

105  LINE (138, 75)-(142, 75): LINE (140, 73)-(140, 77)

110  zz = te%(tx + x, ty + y): x1 = 65 + (x + 1) * 50: y1 = (y + 1) * 50

120  IF zz = 2 THEN LINE (x1 + 20, y1 + 20)-(x1 + 30, y1 + 20): LINE -(x1 + 30, y1 + 30): LINE -(x1 + 20, y1 + 30): LINE -(x1 + 20, y1 + 20)

130  IF zz = 3 THEN
       LINE (x1 + 10, y1 + 10)-(x1 + 20, y1 + 10): LINE -(x1 + 20, y1 + 40): LINE -(x1 + 10, y1 + 40)
       LINE -(x1 + 10, y1 + 30): LINE -(x1 + 40, y1 + 30): LINE -(x1 + 40, y1 + 40): LINE -(x1 + 30, y1 + 40): LINE -(x1 + 30, y1 + 10): LINE -(x1 + 40, y1 + 10)
       LINE -(x1 + 40, y1 + 20): LINE -(x1 + 10, y1 + 20): LINE -(x1 + 10, y1 + 10)
     END IF

140  IF zz = 4 THEN LINE (x1 + 20, y1 + 20)-(x1 + 30, y1 + 30): LINE (x1 + 20, y1 + 30)-(x1 + 30, y1 + 20)

150  IF zz = 5 THEN
       LINE (x1, y1)-(x1 + 50, y1): LINE -(x1 + 50, y1 + 50): LINE -(x1, y1 + 50): LINE -(x1, y1)
       LINE (x1 + 10, y1 + 10)-(x1 + 10, y1 + 40): LINE -(x1 + 40, y1 + 40)
       LINE -(x1 + 40, y1 + 10): LINE -(x1 + 10, y1 + 10): LINE -(x1 + 40, y1 + 40): LINE (x1 + 10, y1 + 40)-(x1 + 40, y1 + 10)
     END IF

160  IF zz = 1 THEN
       LINE (x1 + 10, y1 + 50)-(x1 + 10, y1 + 40): LINE -(x1 + 20, y1 + 30): LINE -(x1 + 40, y1 + 30)
       LINE -(x1 + 40, y1 + 50): LINE (x1, y1 + 10)-(x1 + 10, y1 + 10): LINE (x1 + 50, y1 + 10)-(x1 + 40, y1 + 10)
       LINE (x1, y1 + 40)-(x1 + 10, y1 + 40): LINE (x1 + 40, y1 + 40)-(x1 + 50, y1 + 40)
     END IF

170  IF zz = 1 THEN LINE (x1 + 10, y1)-(x1 + 10, y1 + 20): LINE -(x1 + 20, y1 + 20): LINE -(x1 + 20, y1 + 30): LINE -(x1 + 30, y1 + 30): LINE -(x1 + 30, y1 + 10): LINE -(x1 + 40, y1 + 10): LINE -(x1 + 40, y1)

190  NEXT: NEXT: WINDOW: RETURN

200  SCREEN 1: VIEW PRINT 1 TO 21: CLS 2: VIEW PRINT 22 TO 25: WINDOW SCREEN (0, 0)-(279, 199): di = 0: tb = 2

202  ce = dn%(px + dx * di, py + dy * di): le = dn%(px + dx * di + dy, py + dy * di - dx): ri = dn%(px + dx * di - dy, py + dy * di + dx)

204  l1 = pe%(di, 0): r1 = pe%(di, 1): t1 = pe%(di, 2): b1 = pe%(di, 3): l2 = pe%(di + 1, 0): r2 = pe%(di + 1, 1): t2 = pe%(di + 1, 2): b2 = pe%(di + 1, 3)

205  ce = INT(ce): le = INT(le): ri = INT(ri)

206  mc = INT(ce / 10): ce = ce - mc * 10: le = INT((le / 10 - INT(le / 10)) * 10 + .1): ri = INT((ri / 10 - INT(ri / 10)) * 10 + .1)

208  IF di = 0 THEN 216

210  IF ce = 1 OR ce = 3 OR ce = 4 THEN LINE (l1, t1)-(r1, t1): LINE -(r1, b1): LINE -(l1, b1): LINE -(l1, t1)

212  IF ce = 1 OR ce = 3 THEN en = 1: GOTO 260

214  IF ce = 4 THEN LINE (cd%(di, 0), cd%(di, 3))-(cd%(di, 0), cd%(di, 2)): LINE -(cd%(di, 1), cd%(di, 2)): LINE -(cd%(di, 1), cd%(di, 3)): en = 1: GOTO 260

216  IF le = 1 OR le = 3 OR le = 4 THEN LINE (l1, t1)-(l2, t2): LINE (l1, b1)-(l2, b2)

218  IF ri = 1 OR ri = 3 OR ri = 4 THEN LINE (r1, t1)-(r2, t2): LINE (r1, b1)-(r2, b2)

220  IF le = 4 AND di > 0 THEN LINE (ld%(di, 0), ld%(di, 4))-(ld%(di, 0), ld%(di, 2)): LINE -(ld%(di, 1), ld%(di, 3)): LINE -(ld%(di, 1), ld%(di, 5))

222  IF le = 4 AND di = 0 THEN LINE (0, ld%(di, 2) - 3)-(ld%(di, 1), ld%(di, 3)): LINE -(ld%(di, 1), ld%(di, 5))

224  IF ri = 4 AND di > 0 THEN LINE (279 - ld%(di, 0), ld%(di, 4))-(279 - ld%(di, 0), ld%(di, 2)): LINE -(279 - ld%(di, 1), ld%(di, 3)): LINE -(279 - ld%(di, 1), ld%(di, 5))

226  IF ri = 4 AND di = 0 THEN LINE (279, ld%(di, 2) - 3)-(279 - ld%(di, 1), ld%(di, 3)): LINE -(279 - ld%(di, 1), ld%(di, 5))

228  IF le = 3 OR le = 1 OR le = 4 THEN 234

230  IF di <> 0 THEN LINE (l1, t1)-(l1, b1)

232  LINE (l1, t2)-(l2, t2): LINE -(l2, b2): LINE -(l1, b2)

234  IF ri = 3 OR ri = 1 OR ri = 4 THEN 240

236  IF di <> 0 THEN LINE (r1, t1)-(r1, b1)

238  LINE (r1, t2)-(r2, t2): LINE -(r2, b2): LINE -(r1, b2)

240  IF ce = 7 OR ce = 9 THEN LINE (ft%(di, 0), ft%(di, 4))-(ft%(di, 2), ft%(di, 5)): LINE -(ft%(di, 3), ft%(di, 5)): LINE -(ft%(di, 1), ft%(di, 4)): LINE -(ft%(di, 0), ft%(di, 4))

242  IF ce = 8 THEN LINE (ft%(di, 0), 158 - ft%(di, 4))-(ft%(di, 2), 158 - ft%(di, 5)): LINE -(ft%(di, 3), 158 - ft%(di, 5)): LINE -(ft%(di, 1), 158 - ft%(di, 4)): LINE -(ft%(di, 0), 158 - ft%(di, 4))

244  IF ce = 7 OR ce = 8 THEN ba = la%(di, 3): TP = la%(di, 2): LX = la%(di, 0): RX = la%(di, 1): LINE (LX, ba)-(LX, TP): LINE (RX, TP)-(RX, ba)

246  IF ce = 7 OR ce = 8 THEN y1 = (ba * 4 + TP) / 5: Y2 = (ba * 3 + TP * 2) / 5: Y3 = (ba * 2 + TP * 3) / 5: Y4 = (ba + TP * 4) / 5: LINE (LX, y1)-(RX, y1): LINE (LX, Y2)-(RX, Y2): LINE (LX, Y3)-(RX, Y3): LINE (LX, Y4)-(RX, Y4)

248  IF di > 0 AND ce = 5 THEN LINE (139 - 10 / di, pe%(di, 3))-(139 - 10 / di, pe%(di, 3) - 10 / di): LINE -(139 + 10 / di, pe%(di, 3) - 10 / di): LINE -(139 + 10 / di, pe%(di, 3)): LINE -(139 - 10 / di, pe%(di, 3))

249  IF ce = 5 AND di > 0 THEN VIEW PRINT: LOCATE 1, tb: PRINT "CHEST! "; : tb = tb + 8

250  IF di > 0 AND ce = 5 THEN LINE (139 - 10 / di, pe%(di, 3) - 10 / di)-(139 - 5 / di, pe%(di, 3) - 15 / di): LINE -(139 + 15 / di, pe%(di, 3) - 15 / di): LINE -(139 + 15 / di, pe%(di, 3) - 5 / di): LINE -(139 + 10 / di, pe%(di, 3))

252  IF di > 0 AND ce = 5 THEN LINE (139 + 10 / di, pe%(di, 3) - 10 / di)-(139 + 15 / di, pe%(di, 3) - 15 / di)

260  IF mc < 1 THEN 490

265  b = 79 + yy%(di): c = 139

266  IF mc = 8 THEN VIEW PRINT: LOCATE 1, tb: PRINT "CHEST! "; : tb = tb + 8: PRINT : GOTO 269: REM call

267  VIEW PRINT: LOCATE 1, tb: PRINT m$(mc); : tb = tb + LEN(m$(mc)) + 2: PRINT : REM call

269  IF di = 0 THEN 490

270  ON mc GOTO 300, 310, 320, 330, 340, 350, 360, 370, 380, 390

280  GOTO 490

300  LINE (c - 23 / di, b)-(c - 15 / di, b): LINE -(c - 15 / di, b - 15 / di): LINE -(c - 8 / di, b - 30 / di): LINE -(c + 8 / di, b - 30 / di): LINE -(c + 15 / di, b - 15 / di): LINE -(c + 15 / di, b): LINE -(c + 23 / di, b)

301  LINE (c, b - 26 / di)-(c, b - 65 / di): LINE (c - 2 / di + .499, b - 38 / di)-(c + 2 / di + .499, b - 38 / di)
     LINE (c - 3 / di + .499, b - 45 / di)-(c + 3 / di + .499, b - 45 / di): LINE (c - 5 / di + .499, b - 53 / di)-(c + 5 / di + .499, b - 53 / di)

302  LINE (c - 23 / di, b - 56 / di)-(c - 30 / di, b - 53 / di): LINE -(c - 23 / di, b - 45 / di): LINE -(c - 23 / di, b - 53 / di): LINE -(c - 8 / di, b - 38 / di)

303  LINE (c - 15 / di, b - 45 / di)-(c - 8 / di, b - 60 / di): LINE -(c + 8 / di, b - 60 / di): LINE -(c + 15 / di, b - 45 / di)
     LINE -(c + 15 / di, b - 42 / di): LINE -(c + 15 / di, b - 57 / di): LINE (c + 12 / di, b - 45 / di)-(c + 20 / di, b - 45 / di)

304  LINE (c, b - 75 / di)-(c - 5 / di + .499, b - 80 / di): LINE -(c - 8 / di, b - 75 / di): LINE -(c - 5 / di + .499, b - 65 / di)
     LINE -(c + 5 / di + .499, b - 65 / di): LINE -(c + 5 / di + .499, b - 68 / di): LINE -(c - 5 / di + .499, b - 68 / di): LINE -(c - 5 / di + .499, b - 65 / di)

305  LINE -(c + 5 / di + .499, b - 65 / di): LINE -(c + 8 / di, b - 75 / di): LINE -(c + 5 / di + .499, b - 80 / di): LINE -(c - 5 / di + .499, b - 80 / di): PSET (c - 5 / di + .499, b - 72 / di): PSET (c + 5 / di + .499, b - 72 / di)

309  GOTO 490

310  LINE (c, b - 56 / di)-(c, b - 8 / di): LINE -(c + 10 / di, b): LINE -(c + 30 / di, b): LINE -(c + 30 / di, b - 45 / di): LINE -(c + 10 / di, b - 64 / di): LINE -(c, b - 56 / di)

311  LINE -(c - 10 / di, b - 64 / di): LINE -(c - 30 / di, b - 45 / di): LINE -(c - 30 / di, b): LINE -(c - 10 / di, b): LINE -(c, b - 8 / di)

312  LINE (c - 10 / di, b - 64 / di)-(c - 10 / di, b - 75 / di): LINE -(c, b - 83 / di)
     LINE -(c + 10 / di, b - 75 / di): LINE -(c, b - 79 / di): LINE -(c - 10 / di, b - 75 / di): LINE -(c, b - 60 / di)
     LINE -(c + 10 / di, b - 75 / di): LINE -(c + 10 / di, b - 64 / di)

319  GOTO 490

320  LINE (c + 5 / di, b - 30 / di)-(c, b - 25 / di): LINE -(c - 5 / di, b - 30 / di): LINE -(c - 15 / di, b - 5 / di): LINE -(c - 10 / di, b): LINE -(c + 10 / di, b): LINE -(c + 15 / di, b - 5 / di)

321  LINE -(c + 20 / di, b - 5 / di): LINE -(c + 10 / di, b): LINE -(c + 15 / di, b - 5 / di)
     LINE -(c + 5 / di, b - 30 / di): LINE -(c + 10 / di, b - 40 / di): LINE -(c + 3 / di + .499, b - 35 / di)
     LINE -(c - 3 / di + .499, b - 35 / di): LINE -(c - 10 / di, b - 40 / di): LINE -(c - 5 / di, b - 30 / di)

322  LINE (c - 5 / di, b - 33 / di)-(c - 3 / di + .499, b - 30 / di): LINE (c + 5 / di, b - 33 / di)-(c + 3 / di + .499, b - 30 / di): LINE (c - 5 / di, b - 20 / di)-(c - 5 / di, b - 15 / di)

323  LINE (c + 5 / di, b - 20 / di)-(c + 5 / di, b - 15 / di): LINE (c - 7 / di, b - 20 / di)-(c - 7 / di, b - 15 / di): LINE (c + 7 / di, b - 20 / di)-(c + 7 / di, b - 15 / di)

329  GOTO 490

330  LINE (c, b)-(c - 15 / di, b): LINE -(c - 8 / di, b - 8 / di): LINE -(c - 8 / di, b - 15 / di): LINE -(c - 15 / di, b - 23 / di): LINE -(c - 15 / di, b - 15 / di): LINE -(c - 23 / di, b - 23 / di)

331  LINE -(c - 23 / di, b - 45 / di): LINE -(c - 15 / di, b - 53 / di): LINE -(c - 8 / di, b - 53 / di): LINE -(c - 15 / di, b - 68 / di): LINE -(c - 8 / di, b - 75 / di): LINE -(c, b - 75 / di)

332  LINE (c, b)-(c + 15 / di, b): LINE -(c + 8 / di, b - 8 / di): LINE -(c + 8 / di, b - 15 / di): LINE -(c + 15 / di, b - 23 / di): LINE -(c + 15 / di, b - 15 / di): LINE -(c + 23 / di, b - 23 / di)

333  LINE -(c + 23 / di, b - 45 / di): LINE -(c + 15 / di, b - 53 / di): LINE -(c + 8 / di, b - 53 / di): LINE -(c + 15 / di, b - 68 / di): LINE -(c + 8 / di, b - 75 / di): LINE -(c, b - 75 / di)

334  LINE (c - 15 / di, b - 68 / di)-(c + 15 / di, b - 68 / di): LINE (c - 8 / di, b - 53 / di)-(c + 8 / di, b - 53 / di): LINE (c - 23 / di, b - 15 / di)-(c + 8 / di, b - 45 / di)

335  LINE (c - 8 / di, b - 68 / di)-(c, b - 60 / di): LINE -(c + 8 / di, b - 68 / di): LINE -(c + 8 / di, b - 60 / di): LINE -(c - 8 / di, b - 60 / di): LINE -(c - 8 / di, b - 68 / di)

336  LINE (c, b - 38 / di)-(c - 8 / di, b - 38 / di): LINE -(c + 8 / di, b - 53 / di): LINE -(c + 8 / di, b - 45 / di): LINE -(c + 15 / di, b - 45 / di): LINE -(c, b - 30 / di): LINE -(c, b - 38 / di)

339  GOTO 490

340  LINE (c - 10 / di, b - 15 / di)-(c - 10 / di, b - 30 / di): LINE -(c - 15 / di, b - 20 / di): LINE -(c - 15 / di, b - 15 / di): LINE -(c - 15 / di, b): LINE -(c + 15 / di, b): LINE -(c + 15 / di, b - 15 / di): LINE -(c - 15 / di, b - 15 / di)

341  LINE (c - 15 / di, b - 10 / di)-(c + 15 / di, b - 10 / di): LINE (c - 15 / di, b - 5 / di)-(c + 15 / di, b - 5 / di)

342  LINE (c, b - 15 / di)-(c - 5 / di, b - 20 / di): LINE -(c - 5 / di, b - 35 / di): LINE -(c + 5 / di, b - 35 / di): LINE -(c + 5 / di, b - 20 / di): LINE -(c + 10 / di, b - 15 / di)

343  LINE (c - 5 / di, b - 20 / di)-(c + 5 / di, b - 20 / di): LINE (c - 5 / di, b - 25 / di)-(c + 5 / di, b - 25 / di): LINE (c - 5 / di, b - 30 / di)-(c + 5 / di, b - 30 / di)

344  LINE (c - 10 / di, b - 35 / di)-(c - 10 / di, b - 40 / di): LINE -(c - 5 / di, b - 45 / di): LINE -(c + 5 / di, b - 45 / di): LINE -(c + 10 / di, b - 40 / di): LINE -(c + 10 / di, b - 35 / di)

345  LINE (c - 10 / di, b - 40 / di)-(c, b - 45 / di): LINE -(c + 10 / di, b - 40 / di)

346  LINE (c - 5 / di, b - 40 / di)-(c + 5 / di, b - 40 / di): LINE -(c + 15 / di, b - 30 / di): LINE -(c, b - 40 / di): LINE -(c - 15 / di, b - 30 / di): LINE -(c - 5 / di + .499, b - 40 / di)

349  GOTO 490

350  LINE (c - 20 / di, 79 - yy%(di))-(c - 20 / di, b - 88 / di): LINE -(c - 10 / di, b - 83 / di): LINE -(c + 10 / di, b - 83 / di): LINE -(c + 20 / di, b - 88 / di): LINE -(c + 20 / di, 79 - yy%(di)): LINE -(c - 20 / di, 79 - yy%(di))

351  LINE (c - 20 / di, b - 88 / di)-(c - 30 / di, b - 83 / di): LINE -(c - 30 / di, b - 78 / di): LINE (c + 20 / di, b - 88 / di)-(c + 30 / di, b - 83 / di): LINE -(c + 40 / di, b - 83 / di)

352  LINE (c - 15 / di, b - 86 / di)-(c - 20 / di, b - 83 / di): LINE -(c - 20 / di, b - 78 / di): LINE -(c - 30 / di, b - 73 / di): LINE -(c - 30 / di, b - 68 / di): LINE -(c - 20 / di, b - 63 / di)

353  LINE (c - 10 / di, b - 83 / di)-(c - 10 / di, b - 58 / di): LINE -(c, b - 50 / di): LINE (c + 10 / di, b - 83 / di)-(c + 10 / di, b - 78 / di): LINE -(c + 20 / di, b - 73 / di): LINE -(c + 20 / di, b - 40 / di)

354  LINE (c + 15 / di, b - 85 / di)-(c + 20 / di, b - 78 / di): LINE -(c + 30 / di, b - 76 / di): LINE -(c + 30 / di, b - 60 / di)

355  LINE (c, b - 83 / di)-(c, b - 73 / di): LINE -(c + 10 / di, b - 68 / di): LINE -(c + 10 / di, b - 63 / di): LINE -(c, b - 58 / di)

359  GOTO 490

360  LINE (c + 5 / di + .499, b - 10 / di)-(c - 5 / di + .499, b - 10 / di): LINE -(c, b - 15 / di): LINE -(c + 10 / di, b - 20 / di): LINE -(c + 5 / di + .499, b - 15 / di): LINE -(c + 5 / di + .499, b - 10 / di)

361  LINE -(c + 7 / di + .499, b - 6 / di): LINE -(c + 5 / di + .499, b - 3 / di): LINE -(c - 5 / di + .499, b - 3 / di): LINE -(c - 7 / di + .499, b - 6 / di): LINE -(c - 5 / di + .499, b - 10 / di)

362  LINE (c + 2 / di + .499, b - 3 / di)-(c + 5 / di + .499, b): LINE -(c + 8 / di, b)
     LINE (c - 2 / di + .499, b - 3 / di)-(c - 5 / di + .499, b): LINE -(c - 8 / di, b): PSET (c + 3 / di + .499, b - 8 / di)
     PSET (c - 3 / di + .499, b - 8 / di): LINE (c + 3 / di + .499, b - 5 / di)-(c - 3 / di + .499, b - 5 / di)

363  GOTO 490

370  LINE (139 - 10 / di, pe%(di, 3))-(139 - 10 / di, pe%(di, 3) - 10 / di): LINE -(139 + 10 / di, pe%(di, 3) - 10 / di): LINE -(139 + 10 / di, pe%(di, 3)): LINE -(139 - 10 / di, pe%(di, 3))

371  LINE (139 - 10 / di, pe%(di, 3) - 10 / di)-(139 - 5 / di, pe%(di, 3) - 15 / di): LINE -(139 + 15 / di, pe%(di, 3) - 15 / di): LINE -(139 + 15 / di, pe%(di, 3) - 5 / di): LINE -(139 + 10 / di, pe%(di, 3))

372  LINE (139 + 10 / di, pe%(di, 3) - 10 / di)-(139 + 15 / di, pe%(di, 3) - 15 / di)

373  GOTO 490

380  LINE (c - 14 / di, b - 46 / di)-(c - 12 / di, b - 37 / di): LINE -(c - 20 / di, b - 32 / di): LINE -(c - 30 / di, b - 32 / di)
     LINE -(c - 22 / di, b - 24 / di): LINE -(c - 40 / di, b - 17 / di): LINE -(c - 40 / di, b - 7 / di): LINE -(c - 38 / di, b - 5 / di)
     LINE -(c - 40 / di, b - 3 / di): LINE -(c - 40 / di, b)

381  LINE -(c - 36 / di, b): LINE -(c - 34 / di, b - 2 / di): LINE -(c - 32 / di, b): LINE -(c - 28 / di, b)
     LINE -(c - 28 / di, b - 3 / di): LINE -(c - 30 / di, b - 5 / di): LINE -(c - 28 / di, b - 7 / di)
     LINE -(c - 28 / di, b - 15 / di): LINE -(c, b - 27 / di)

382  LINE (c + 14 / di, b - 46 / di)-(c + 12 / di, b - 37 / di): LINE -(c + 20 / di, b - 32 / di)
     LINE -(c + 30 / di, b - 32 / di): LINE -(c + 22 / di, b - 24 / di): LINE -(c + 40 / di, b - 17 / di)
     LINE -(c + 40 / di, b - 7 / di): LINE -(c + 38 / di, b - 5 / di): LINE -(c + 40 / di, b - 3 / di): LINE -(c + 40 / di, b)

383  LINE -(c + 36 / di, b): LINE -(c + 34 / di, b - 2 / di): LINE -(c + 32 / di, b): LINE -(c + 28 / di, b)
     LINE -(c + 28 / di, b - 3 / di): LINE -(c + 30 / di, b - 5 / di): LINE -(c + 28 / di, b - 7 / di)
     LINE -(c + 28 / di, b - 15 / di): LINE -(c, b - 27 / di)

384  LINE (c + 6 / di, b - 48 / di)-(c + 38 / di, b - 41 / di): LINE -(c + 40 / di, b - 42 / di): LINE -(c + 18 / di, b - 56 / di)
     LINE -(c + 12 / di, b - 56 / di): LINE -(c + 10 / di, b - 57 / di): LINE -(c + 8 / di, b - 56 / di): LINE -(c - 8 / di, b - 56 / di)
     LINE -(c - 10 / di, b - 58 / di): LINE -(c + 14 / di, b - 58 / di): LINE -(c + 16 / di, b - 59 / di)

385  LINE -(c + 8 / di, b - 63 / di): LINE -(c + 6 / di, b - 63 / di): LINE -(c + 2 / di + .499, b - 70 / di)
     LINE -(c + 2 / di + .499, b - 63 / di): LINE -(c - 2 / di + .499, b - 63 / di): LINE -(c - 2 / di + .499, b - 70 / di)
     LINE -(c - 6 / di, b - 63 / di): LINE -(c - 8 / di, b - 63 / di): LINE -(c - 16 / di, b - 59 / di): LINE -(c - 14 / di, b - 58 / di)

386  LINE -(c - 10 / di, b - 57 / di): LINE -(c - 12 / di, b - 56 / di): LINE -(c - 18 / di, b - 56 / di): LINE -(c - 36 / di, b - 47 / di)
     LINE -(c - 36 / di, b - 39 / di): LINE -(c - 28 / di, b - 41 / di): LINE -(c - 28 / di, b - 46 / di): LINE -(c - 20 / di, b - 50 / di)
     LINE -(c - 18 / di, b - 50 / di): LINE -(c - 14 / di, b - 46 / di)

387  GOTO 3087

390  LINE (c + 6 / di, b - 60 / di)-(c + 30 / di, b - 90 / di): LINE -(c + 60 / di, b - 30 / di): LINE -(c + 60 / di, b - 10 / di): LINE -(c + 30 / di, b - 40 / di): LINE -(c + 15 / di, b - 40 / di)

391  LINE (c - 6 / di, b - 60 / di)-(c - 30 / di, b - 90 / di): LINE -(c - 60 / di, b - 30 / di): LINE -(c - 60 / di, b - 10 / di): LINE -(c - 30 / di, b - 40 / di): LINE -(c - 15 / di, b - 40 / di)

392  LINE (c, b - 25 / di)-(c + 6 / di, b - 25 / di): LINE -(c + 10 / di, b - 20 / di): LINE -(c + 12 / di, b - 10 / di): LINE -(c + 10 / di, b - 6 / di)
     LINE -(c + 10 / di, b): LINE -(c + 14 / di, b): LINE -(c + 15 / di, b - 5 / di): LINE -(c + 16 / di, b): LINE -(c + 20 / di, b)

393  LINE -(c + 20 / di, b - 6 / di): LINE -(c + 18 / di, b - 10 / di): LINE -(c + 18 / di, b - 20 / di): LINE -(c + 15 / di, b - 30 / di): LINE -(c + 15 / di, b - 45 / di): LINE -(c + 40 / di, b - 60 / di): LINE -(c + 40 / di, b - 70 / di)

394  LINE -(c + 10 / di, b - 55 / di): LINE -(c + 6 / di, b - 60 / di): LINE -(c + 10 / di, b - 74 / di): LINE -(c + 6 / di, b - 80 / di)
     LINE -(c + 4 / di + .499, b - 80 / di): LINE -(c + 3 / di + .499, b - 82 / di): LINE -(c + 2 / di + .499, b - 80 / di): LINE -(c, b - 80 / di)

395  LINE (c, b - 25 / di)-(c - 6 / di, b - 25 / di): LINE -(c - 10 / di, b - 20 / di): LINE -(c - 12 / di, b - 10 / di): LINE -(c - 10 / di, b - 6 / di)
     LINE -(c - 10 / di, b): LINE -(c - 14 / di, b): LINE -(c - 15 / di, b - 5 / di): LINE -(c - 16 / di, b): LINE -(c - 20 / di, b)

396  LINE -(c - 20 / di, b - 6 / di): LINE -(c - 18 / di, b - 10 / di): LINE -(c - 18 / di, b - 20 / di): LINE -(c - 15 / di, b - 30 / di): LINE -(c - 15 / di, b - 45 / di): LINE -(c - 40 / di, b - 60 / di): LINE -(c - 40 / di, b - 70 / di)

397  LINE -(c - 10 / di, b - 55 / di): LINE -(c - 6 / di, b - 60 / di): LINE -(c - 10 / di, b - 74 / di): LINE -(c - 6 / di, b - 80 / di)
     LINE -(c - 4 / di + .499, b - 80 / di): LINE -(c - 3 / di + .499, b - 82 / di): LINE -(c - 2 / di + .499, b - 80 / di): LINE -(c, b - 80 / di)

398  LINE (c - 6 / di, b - 25 / di)-(c, b - 6 / di): LINE -(c + 10 / di, b): LINE -(c + 4 / di + .499, b - 8 / di): LINE -(c + 6 / di, b - 25 / di)
     LINE (c - 40 / di, b - 64 / di)-(c - 40 / di, b - 90 / di): LINE -(c - 52 / di, b - 80 / di): LINE -(c - 52 / di, b - 40 / di)

399  LINE (c + 40 / di, b - 86 / di)-(c + 38 / di, b - 92 / di): LINE -(c + 42 / di, b - 92 / di): LINE -(c + 40 / di, b - 86 / di): LINE -(c + 40 / di, b - 50 / di)

400  LINE (c + 4 / di + .499, b - 70 / di)-(c + 6 / di, b - 74 / di): LINE (c - 4 / di + .499, b - 70 / di)-(c - 6 / di, b - 74 / di): LINE (c, b - 64 / di)-(c, b - 60 / di): GOTO 490

490  IF en = 1 THEN en = 0: WINDOW: RETURN

491  di = di + 1: GOTO 202

500  RANDOMIZE -ABS(ln) - tx * 10 - ty * 1000 + in * 31.4

501  FOR x = 1 TO 9: FOR y = 1 TO 9: dn%(x, y) = 0: NEXT: NEXT

510  FOR x = 0 TO 10: dn%(x, 0) = 1: dn%(x, 10) = 1: dn%(0, x) = 1: dn%(10, x) = 1: NEXT

520  FOR x = 2 TO 8 STEP 2: FOR y = 1 TO 9: dn%(x, y) = 1: NEXT: NEXT

530  FOR x = 2 TO 8 STEP 2: FOR y = 1 TO 9 STEP 2

540  IF RND(1) > .95 THEN dn%(x, y) = 2

541  IF RND(1) > .95 THEN dn%(y, x) = 2

542  IF RND(1) > .6 THEN dn%(y, x) = 3

543  IF RND(1) > .6 THEN dn%(x, y) = 3

544  IF RND(1) > .6 THEN dn%(x, y) = 4

545  IF RND(1) > .6 THEN dn%(y, x) = 4

546  IF RND(1) > .97 THEN dn%(y, x) = 9

547  IF RND(1) > .97 THEN dn%(x, y) = 9

548  IF RND(1) > .94 THEN dn%(x, y) = 5

549  IF RND(1) > .94 THEN dn%(y, x) = 5

568  NEXT: NEXT

569  dn%(2, 1) = 0: IF in / 2 = INT(in / 2) THEN dn%(7, 3) = 7: dn%(3, 7) = 8

570  IF in / 2 <> INT(in / 2) THEN dn%(7, 3) = 8: dn%(3, 7) = 7

580  IF in = 1 THEN dn%(1, 1) = 8: dn%(7, 3) = 0

585  GOSUB 2000

590  RETURN

1000  DO: LOOP UNTIL INKEY$ = "": VIEW PRINT 22 TO 25: LOCATE 25, 1: PRINT "COMMAND?                    "; : LOCATE CSRLIN, 10

1001  x$ = INKEY$: IF x$ = "" THEN 1001

1002  IF ASC(x$) = 0 THEN xq = ASC(MID$(x$, 2)) ELSE xq = 0

1010  REM poke -16368, 0

1030  IF xq = 72 THEN ON SGN(in) + 1 GOTO 1100, 1150

1040  IF xq = 77 THEN ON SGN(in) + 1 GOTO 1200, 1250

1050  IF xq = 75 THEN ON SGN(in) + 1 GOTO 1300, 1350

1060  IF xq = 80 THEN ON SGN(in) + 1 GOTO 1400, 1450

1070  IF x$ = "g" OR x$ = CHR$(13) OR x$ = "e" OR x$ = "k" OR x$ = "d" THEN ON SGN(in) + 1 GOTO 1500, 1550

1080  IF x$ = "a" OR x$ = "u" OR x$ = "c" THEN ON SGN(in) + 1 GOTO 1600, 1650

1081  IF x$ = " " THEN PRINT "PASS": GOTO 1090

1085  IF x$ = "i" OR x$ = "z" OR x$ = "y" THEN 1700

1086  IF x$ = "p" THEN IF pa = 1 THEN pa = 0: PRINT "PAUSE OFF": GOTO 1000

1087  IF x$ = "p" THEN IF pa = 0 THEN pa = 1: PRINT "PAUSE ON": GOTO 1000

1089  PRINT "HUH?": GOTO 1000

1090  pw(0) = pw(0) - 1 + SGN(in) * .9: IF pw(0) < 0 THEN c(0) = 0: PRINT : PRINT "YOU HAVE STARVED!!!!!": GOTO 1093

1091  FOR jj = 0 TO 2: LOCATE 22 + jj, 30: PRINT "         "; : NEXT
      LOCATE 22, 30: PRINT "FOOD="; LTRIM$(STR$(pw(0))); : LOCATE 23, 30: PRINT "H.P.="; LTRIM$(STR$(c(0)));
      LOCATE 24, 30: PRINT "GOLD="; LTRIM$(STR$(c(5))); : LOCATE 24, 1: REM call -868

1092  pw(0) = INT(pw(0) * 10) / 10

1093  IF c(0) <= 0 THEN SLEEP 3: GOTO 6000

1095  IF in > 0 THEN GOSUB 4000: IF c(0) <= 0 THEN 1093

1096  FOR jj = 0 TO 3: LOCATE 22 + jj, 30: PRINT "         "; : NEXT: LOCATE 22, 30: PRINT "FOOD="; LTRIM$(STR$(pw(0))); : LOCATE 23, 30: PRINT "H.P.="; LTRIM$(STR$(c(0))); : LOCATE 24, 30: PRINT "GOLD="; LTRIM$(STR$(c(5))); : LOCATE 24, 1

1097  IF in = 0 THEN GOSUB 100: GOTO 1000

1098  IF in > 0 THEN GOSUB 200: GOTO 1000

1100  PRINT "NORTH": IF te%(tx, ty - 1) = 1 THEN PRINT "YOU CAN'T PASS THE MOUNTAINS": GOTO 1090

1110  ty = ty - 1: GOTO 1090

1150  IF dn%(px + dx, py + dy) <> 1 AND dn%(px + dx, py + dy) < 10 THEN px = px + dx: py = py + dy

1155  PRINT "FORWARD"

1160  IF dn%(px, py) = 2 THEN PRINT "AAARRRGGGHHH!!! A TRAP!": c(0) = c(0) - INT(RND(1) * in + 3): MR = 1: in = in + 1: PRINT "FALLING TO LEVEL "; in: SLEEP 2: GOSUB 500: GOTO 1090

1165  z = 0

1170  IF dn%(px, py) = 5 THEN dn%(px, py) = 0: PRINT "GOLD!!!!!": z = INT(RND(1) * 5 * in + in): PRINT z; "-PIECES OF EIGHT": c(5) = c(5) + z

1175  IF z > 0 THEN z = INT(RND(1) * 6): PRINT "AND A "; w$(z): pw(z) = pw(z) + 1: SLEEP 1: GOTO 1090

1190  GOTO 1090

1200  PRINT "EAST": IF te%(tx + 1, ty) = 1 THEN PRINT "YOU CAN'T PASS THE MOUNTAINS": GOTO 1090

1210  tx = tx + 1: GOTO 1090

1250  PRINT "TURN RIGHT"

1255  IF dx <> 0 THEN dy = dx: dx = 0: GOTO 1090

1260  dx = -dy: dy = 0: GOTO 1090

1300  PRINT "WEST": IF te%(tx - 1, ty) = 1 THEN PRINT "YOU CAN'T PASS THE MOUNTAINS": GOTO 1090

1310  tx = tx - 1: GOTO 1090

1350  PRINT "TURN LEFT"

1355  IF dx <> 0 THEN dy = -dx: dx = 0: GOTO 1090

1360  dx = dy: dy = 0: GOTO 1090

1400  PRINT "SOUTH": IF te%(tx, ty + 1) = 1 THEN PRINT "YOU CAN'T PASS THE MOUNTAINS": GOTO 1090

1410  ty = ty + 1: GOTO 1090

1450  PRINT "TURN AROUND": dx = -dx: dy = -dy: GOTO 1090

1500  IF te%(tx, ty) = 3 THEN GOSUB 60080: GOSUB 60200: CLS : GOTO 1090

1510  IF te%(tx, ty) = 4 AND in = 0 THEN PRINT "GO DUNGEON": PRINT "PLEASE WAIT ": SLEEP 1: in = 1: GOSUB 500: dx = 1: dy = 0: px = 1: py = 1: CLS : GOTO 1090

1515  IF te%(tx, ty) = 5 THEN 7000

1520  PRINT "HUH?": GOTO 1000

1550  IF dn%(px, py) <> 7 AND dn%(px, py) <> 9 THEN 1580

1555  PRINT "GO DOWN TO LEVEL "; in + 1

1560  in = in + 1: GOSUB 500: MR = 1: GOTO 1090

1580  IF dn%(px, py) <> 8 THEN PRINT "HUH?": GOTO 1090

1581  IF in = 1 THEN PRINT "LEAVE DUNGEON": in = 0: GOTO 1586

1584  PRINT "GO UP TO LEVEL "; in - 1

1585  in = in - 1: GOSUB 500: MR = 1

1586  IF in = 0 THEN PRINT "THOU HAST GAINED": PRINT lk; " HIT POINTS": SLEEP 2: c(0) = c(0) + lk: lk = 0

1587  CLS : GOTO 1090

1600  GOTO 1090

1650  mn = 0: da = 0: PRINT "ATTACK ": PRINT "WHICH WEAPON "; : DO: q$ = INKEY$: LOOP WHILE q$ = ""

1651  IF q$ = "r" THEN da = 10: PRINT "RAPIER": IF pw(1) < 1 THEN PRINT "NOT OWNED": GOTO 1650

1652  IF q$ = "a" THEN da = 5: PRINT "AXE": IF pw(2) < 1 THEN PRINT "NOT OWNED": GOTO 1650

1653  IF q$ = "s" THEN da = 1: PRINT "SHIELD": IF pw(3) < 1 THEN PRINT "NOT OWNED": GOTO 1650

1654  IF q$ = "b" THEN da = 4: PRINT "BOW": IF pw(4) < 1 THEN PRINT "NOT OWNED": GOTO 1650

1655  IF q$ = "m" THEN PRINT "MAGIC AMULET": GOTO 1680

1656  IF q$ = "b" AND pt$ = "m" THEN PRINT "MAGES CAN'T USE BOWS!": GOTO 1650

1657  IF q$ = "r" AND pt$ = "m" THEN PRINT "MAGES CAN'T USE RAPIERS!": GOTO 1650

1659  IF da = 0 THEN PRINT "HANDS"

1660  IF da = 5 OR da = 4 THEN 1670

1661  mn = dn%(px + dx, py + dy) / 10: mn = INT(mn)

1662  IF mn < 1 OR c(2) - RND(1) * 25 < mn + in THEN PRINT " YOU MISSED": GOTO 1668

1663  PRINT "HIT!!! ": da = (RND(1) * da + c(1) / 5): mz%(mn, 1) = INT(mz%(mn, 1) - da)

1664  PRINT m$(mn); "'S HIT POINTS="; mz%(mn, 1)

1665  IF mz%(mn, 1) < 1 THEN PRINT "THOU HAST KILLED A "; m$(mn): PRINT "THOU SHALT RECEIVE": da = INT(mn + in): PRINT da; " PIECES OF EIGHT"

1666  IF mz%(mn, 1) < 1 THEN c(5) = INT(c(5) + da): dn%(ml%(mn, 0), ml%(mn, 1)) = dn%(ml%(mn, 0), ml%(mn, 1)) - 10 * mn: mz%(mn, 0) = 0

1667  lk = lk + INT(mn * in / 2): IF mn = ta THEN ta = -ta

1668  IF pa = 1 THEN PRINT "-CR- TO CONT. "; : INPUT q$

1669  SLEEP 1: GOTO 1090

1670  IF da = 5 THEN PRINT "TO THROW OR SWING:"; : DO: q$ = INKEY$: LOOP WHILE q$ = "": IF q$ <> "t" THEN PRINT "SWING": GOTO 1661

1671  IF da = 5 THEN PRINT "THROW": pw(2) = pw(2) - 1

1672  FOR y = 1 TO 5: IF px + dx * y < 1 OR px + dx * y > 9 OR py + dy * y > 9 OR py + dy * y < 0 THEN 1662

1673  mn = dn%(px + dx * y, py + dy * y): mn = INT(mn / 10): IF mn > 0 THEN 1662

1674  NEXT: GOTO 1662

1680  IF pw(5) < 1 THEN PRINT "NONE OWNED": GOTO 1650

1681  IF pt$ = "f" THEN q = INT(RND(1) * 4 + 1): GOTO 1685

1682  PRINT "1-LADDER-UP", "2-LADDER-DN": PRINT "3-KILL", "4-BAD??": PRINT "CHOICE "; : DO: q$ = INKEY$: LOOP WHILE q$ = "": q = VAL(q$): PRINT q: IF q < 1 OR q > 4 THEN 1682

1683  IF RND(1) > .75 THEN PRINT "LAST CHARGE ON THIS AMULET!": pw(5) = pw(5) - 1

1685  ON q GOTO 1686, 1690, 1691, 1692

1686  PRINT "LADDER UP": dn%(px, py) = 8: SLEEP 1: GOTO 1090

1690  PRINT "LADDER DOWN": dn%(px, py) = 7: SLEEP 1: GOTO 1090

1691  PRINT "MAGIC ATTACK": da = 10 + in: GOTO 1672

1692  ON INT(RND(1) * 3 + 1) GOTO 1693, 1695, 1697

1693  PRINT "YOU HAVE BEEN TURNED": PRINT "INTO A TOAD!"

1694  FOR z2 = 1 TO 4: c(z2) = 3: NEXT z2: SLEEP 3: GOTO 1090

1695  PRINT "YOU HAVE BEEN TURNED": PRINT "INTO A LIZARD MAN": FOR y = 0 TO 4: c(y) = INT(c(y) * 2.5): NEXT: SLEEP 3: GOTO 1090

1697  PRINT "BACKFIRE": c(0) = c(0) / 2: SLEEP 2: GOTO 1090

1700  GOSUB 60080: LOCATE 1, 1: PRINT "PRESS -CR- TO CONTINUE"; : INPUT q$: SCREEN 1: CLS : GOTO 1090

2000  nm = 0: FOR x = 1 TO 10

2005  mz%(x, 0) = 0: mz%(x, 1) = x + 3 + in

2010  IF x - 2 > in OR RND(1) > .4 THEN 2090

2020  ml%(x, 0) = INT(RND(1) * 9 + 1): ml%(x, 1) = INT(RND(1) * 9 + 1)

2030  IF dn%(ml%(x, 0), ml%(x, 1)) <> 0 THEN 2020

2040  IF ml%(x, 0) = px AND ml%(x, 1) = py THEN 2020

2050  dn%(ml%(x, 0), ml%(x, 1)) = x * 10

2051  mz%(x, 0) = 1

2052  nm = nm + 1

2055  mz%(x, 1) = x * 2 + in * 2 * lp

2090  NEXT: RETURN

3087  LINE (c - 28 / di, b - 41 / di)-(c + 30 / di, b - 55 / di): LINE (c + 28 / di, b - 58 / di)-(c + 22 / di, b - 56 / di): LINE -(c + 22 / di, b - 53 / di)
      LINE -(c + 28 / di, b - 52 / di): LINE -(c + 34 / di, b - 54 / di): LINE (c + 20 / di, b - 50 / di)-(c + 26 / di, b - 47 / di)

3088  LINE (c + 10 / di, b - 58 / di)-(c + 10 / di, b - 61 / di): LINE -(c + 4 / di, b - 58 / di): LINE (c - 10 / di, b - 58 / di)-(c - 10 / di, b - 61 / di)
      LINE -(c - 4 / di, b - 58 / di): LINE (c + 40 / di, b - 9 / di)-(c + 50 / di, b - 12 / di): LINE -(c + 40 / di, b - 7 / di)

3089  LINE (c - 8 / di, b - 25 / di)-(c + 6 / di, b - 7 / di): LINE -(c + 28 / di, b - 7 / di): LINE -(c + 28 / di, b - 9 / di): LINE -(c + 20 / di, b - 9 / di): LINE -(c + 6 / di, b - 25 / di): GOTO 490

4000  FOR mm = 1 TO 10: IF mz%(mm, 0) = 0 THEN 4999

4010  ra = SQR((px - ml%(mm, 0)) ^ 2 + (py - ml%(mm, 1)) ^ 2)

4011  IF mz%(mm, 1) < in * lp THEN 4030

4020  IF ra < 1.3 THEN 4500

4025  IF mm = 8 AND ra < 3 THEN 4999

4030  x1 = SGN(px - ml%(mm, 0)): y1 = SGN(py - ml%(mm, 1))

4031  IF mz%(mm, 1) < in * lp THEN x1 = -x1: y1 = -y1

4035  IF y1 = 0 THEN 4045

4040  d = dn%(ml%(mm, 0), (ml%(mm, 1) + y1 + .499)): IF d = 1 OR d > 9 OR d = 2 THEN 4045

4042  x1 = 0: GOTO 4050

4045  y1 = 0: IF x1 = 0 THEN 4050

4046  d = dn%((ml%(mm, 0) + x1 + .499), ml%(mm, 1)): IF d = 1 OR d > 9 OR d = 2 THEN x1 = 0: GOTO 4081

4050  dn%(ml%(mm, 0), ml%(mm, 1)) = dn%(ml%(mm, 0), ml%(mm, 1)) - 10 * mm

4055  IF ml%(mm, 0) + x1 = px AND ml%(mm, 1) + y1 = py THEN 4999

4060  ml%(mm, 0) = ml%(mm, 0) + x1: ml%(mm, 1) = ml%(mm, 1) + y1

4080  dn%(ml%(mm, 0), ml%(mm, 1)) = (dn%(ml%(mm, 0), ml%(mm, 1)) + 10 * mm + .499)

4081  IF x1 <> 0 OR y1 <> 0 THEN 4999

4082  IF mz%(mm, 1) < in * lp AND ra < 1.3 THEN 4500

4083  IF mz%(mm, 1) < in * lp THEN mz%(mm, 1) = mz%(mm, 1) + mm + in

4499  GOTO 4999

4500  IF mm = 2 OR mm = 7 THEN 4600

4509  PRINT "YOU ARE BEING ATTACKED": PRINT "BY A "; m$(mm)

4510  IF RND(1) * 20 - SGN(pw(3)) - c(3) + mm + in < 0 THEN PRINT "MISSED": GOTO 4525

4520  PRINT "HIT": c(0) = c(0) - INT(RND(1) * mm + in)

4525  IF pa = 1 THEN PRINT "-CR- TO CONT. "; : INPUT q$

4530  GOTO 4999

4600  IF RND(1) < .5 THEN 4509

4610  IF mm = 7 THEN pw(0) = INT(pw(0) / 2): PRINT "A GREMLIN STOLE SOME FOOD": GOTO 4525

4620  zz = INT(RND(1) * 6): IF pw(zz) < 1 THEN 4620

4630  PRINT "A THIEF STOLE A "; w$(zz): pw(zz) = pw(zz) - 1: GOTO 4525

4999  NEXT: RETURN

6000  VIEW PRINT: CLS : PRINT : PRINT : PRINT "        WE MOURN THE PASSING OF"

6005  IF LEN(pn$) > 22 THEN pn$ = ""

6010  IF pn$ = "" THEN pn$ = "THE PEASANT"

6020  pn$ = pn$ + " AND HIS COMPUTER"

6030  PRINT TAB(20 - INT(LEN(pn$) / 2)); : PRINT pn$

6035  PRINT "  TO INVOKE A MIRACLE OF RESSURECTION"

6040  PRINT "             <HIT ESC KEY>";

6050  DO: LOOP UNTIL INKEY$ = CHR$(27)

6060  GOTO 1

7000  SCREEN 1: VIEW PRINT: CLS

7001  REM

7010  IF pn$ <> "" THEN 7500

7020  PRINT : PRINT : PRINT "     WELCOME PEASANT INTO THE HALLS OF": PRINT "THE MIGHTY LORD BRITISH. HEREIN THOU MAYCHOOSE TO DARE BATTLE WITH THE EVIL": PRINT "CREATURES OF THE DEPTHS, FOR GREAT": PRINT "REWARD!"

7030  PRINT : PRINT "WHAT IS THY NAME PEASANT "; : INPUT pn$: pn$ = UCASE$(pn$)

7040  PRINT "DOEST THOU WISH FOR GRAND ADVENTURE ? "; : DO: q$ = INKEY$: LOOP WHILE q$ = ""
      IF q$ <> "y" THEN PRINT : PRINT "THEN LEAVE AND BEGONE!": pn$ = "": PRINT : PRINT "         PRESS -SPACE- TO CONT."; : DO: q$ = INKEY$: LOOP UNTIL q$ = " ": CLS : GOTO 1090

7045  PRINT

7050  PRINT : PRINT "GOOD! THOU SHALT TRY TO BECOME A ": PRINT "KNIGHT!!!": PRINT : PRINT "THY FIRST TASK IS TO GO INTO THE": PRINT "DUNGEONS AND TO RETURN ONLY AFTER": PRINT "KILLING A(N) "; : ta = INT(c(4) / 3): PRINT m$(ta)

7060  PRINT : PRINT "     GO NOW UPON THIS QUEST, AND MAY": PRINT "LADY LUCK BE FAIR UNTO YOU.....": PRINT ".....ALSO I, BRITISH, HAVE INCREASED": PRINT "EACH OF THY ATTRIBUTES BY ONE!"

7070  PRINT : PRINT "         PRESS -SPACE- TO CONT."; : DO: q$ = INKEY$: LOOP WHILE q$ = "": FOR x = 0 TO 5: c(x) = c(x) + 1: NEXT: CLS : GOTO 1090

7500  IF ta > 0 THEN PRINT : PRINT : PRINT pn$; " WHY HAST THOU RETURNED?": PRINT "THOU MUST KILL A(N) "; m$(ta)
      PRINT "GO NOW AND COMPLETE THY QUEST!": PRINT : PRINT "         PRESS -SPACE- TO CONT."; : DO: q$ = INKEY$: LOOP WHILE q$ = "": CLS : GOTO 1090

7510  PRINT : PRINT : PRINT : PRINT "AAHH!!....."; pn$: PRINT : PRINT "THOU HAST ACOMPLISHED THY QUEST!": IF ABS(ta) = 10 THEN 7900

7520  PRINT "UNFORTUNATELY, THIS IS NOT ENOUGH TO": PRINT "BECOME A KNIGHT.": ta = ABS(ta) + 1: PRINT : PRINT "NOW THOU MUST KILL A(N) "; m$(ta)

7530  GOTO 7060

7900  SCREEN 1: VIEW PRINT: CLS : PRINT : PRINT : PRINT : pn$ = "LORD " + pn$: PRINT " "; pn$; ","

7910  PRINT "       THOU HAST PROVED THYSELF WORTHY": PRINT "OF KNIGHTHOOD, CONTINUE PLAY IF THOU": PRINT "DOTH WISH, BUT THOU HAST ACOMPLISHED": PRINT "THE MAIN OBJECTIVE OF THIS GAME..."

7920  IF lp = 10 THEN 7950

7930  PRINT : PRINT "   NOW MAYBE THOU ART FOOLHEARTY": PRINT "ENOUGH TOTRY DIFFICULTY LEVEL "; lp + 1

7940  GOTO 7070

7950  PRINT : PRINT "...CALL CALIFORNIA PACIFIC COMPUTER": PRINT "AT (415)-569-9126 TO REPORT THIS": PRINT "AMAZING FEAT!"

7990  GOTO 7070

60000  SCREEN 1: VIEW PRINT: CLS : LOCATE 5, 1: INPUT "TYPE THY LUCKY NUMBER....."; q$: ln = VAL(q$)

60005  LOCATE 7, 1: INPUT "LEVEL OF PLAY (1-10)......"; q$: lp = INT(VAL(q$))

60006  IF lp < 1 OR lp > 10 THEN 60005

60010  RANDOMIZE ln

60020  DATA   "HIT POINTS.....","STRENGTH.......","DEXTERITY......","STAMINA........","WISDOM.........","GOLD..........."

60025  REM

60030  DIM c$(5): FOR x = 0 TO 5: READ c$(x): NEXT

60040  REM

60041  REM

60042  DATA       "SKELETON","THIEF","GIANT RAT","ORC","VIPER","CARRION CRAWLER","GREMLIN","MIMIC","DAEMON","BALROG"

60043  FOR x = 1 TO 10: READ m$(x): NEXT

60050  FOR x = 0 TO 5: c(x) = INT(SQR(RND(1)) * 21 + 4): NEXT x

60060  CLS : LOCATE 8, 1: FOR x = 0 TO 5: PRINT c$(x); c(x): NEXT: PRINT : PRINT "SHALT THOU PLAY WITH THESE QUALITIES?": PRINT TAB(20); : DO: q$ = INKEY$: LOOP WHILE q$ = "": IF q$ <> "y" THEN 60050

60061  LOCATE 15, 1: PRINT : PRINT "AND SHALT THOU BE A FIGHTER OR A MAGE?": PRINT TAB(20); : DO: pt$ = INKEY$: LOOP WHILE pt$ = ""

60062  IF pt$ = "m" OR pt$ = "f" THEN 60070

60063  GOTO 60061

60070  DATA    "FOOD","RAPIER","AXE","SHIELD","BOW AND ARROWS","MAGIC AMULET": FOR x = 0 TO 5: READ w$(x): NEXT

60075  GOSUB 60080: GOSUB 60200: RETURN

60080  SCREEN 1: VIEW PRINT: CLS : PRINT : PRINT : PRINT "     STAT'S              WEAPONS": PRINT : FOR x = 0 TO 5: PRINT c$(x); c(x); TAB(24); "0-"; w$(x): NEXT: LOCATE 1, 1

60081  LOCATE 11, 18: PRINT "Q-QUIT"

60082  REM IF pw(0) > 0 THEN REM  CALL 62450

60085  FOR z = 0 TO 5: LOCATE 5 + z, 25 - LEN(STR$(pw(z))): PRINT STR$(pw(z)); : NEXT

60090  LOCATE 17, 5: PRINT "PRICE"; : PRINT TAB(15); : PRINT "DAMAGE"; : PRINT TAB(25); : PRINT "ITEM"

60100  FOR x = 0 TO 5: LOCATE 19 + x, 25: PRINT w$(x); : NEXT

60110  LOCATE 19, 5: PRINT "1 FOR 10"; : PRINT TAB(15); : PRINT "N/A": LOCATE 20, 5: PRINT "8"; : PRINT TAB(15); : PRINT "1-10": LOCATE 21, 5: PRINT "5"; : PRINT TAB(15); : PRINT "1-5"

60120  LOCATE 22, 5: PRINT "6"; : PRINT TAB(15); : PRINT "1": LOCATE 23, 5: PRINT "3"; : PRINT TAB(15); : PRINT "1-4"; : LOCATE 24, 5: PRINT "15"; : PRINT TAB(15); : PRINT "?????"; : LOCATE 1, 1

60130  RETURN

60200  LOCATE 1, 1: PRINT "WELCOME TO THE ADVENTURE SHOP"

60210  LOCATE 13, 1: FOR jj = 0 TO 1: PRINT "                                      ": NEXT
       LOCATE 12, 1: PRINT "WHICH ITEM SHALT THOU BUY        "; : LOCATE 12, 27: DO: q$ = INKEY$: LOOP WHILE q$ = ""
       IF q$ = "q" THEN PRINT : PRINT : PRINT "BYE": SLEEP 1: SCREEN 1: CLS : RETURN

60215  z = -1

60220  IF q$ = "f" THEN PRINT "FOOD": z = 0: p = 1

60221  IF q$ = "r" THEN PRINT "RAPIER": z = 1: p = 8

60222  IF q$ = "a" THEN PRINT "AXE": z = 2: p = 5

60223  IF q$ = "s" THEN PRINT "SHIELD": z = 3: p = 6

60224  IF q$ = "b" THEN PRINT "BOW": z = 4: p = 3

60225  IF q$ = "m" THEN PRINT "AMULET": z = 5: p = 15

60226  IF z = -1 THEN PRINT UCASE$(q$): PRINT "I'M SORRY WE DON'T HAVE THAT.": SLEEP 2: GOTO 60210

60227  IF q$ = "r" AND pt$ = "m" THEN PRINT "I'M SORRY MAGES": PRINT "CAN'T USE THAT!": SLEEP 2: GOTO 60210

60228  IF q$ = "b" AND pt$ = "m" THEN PRINT "I'M SORRY MAGES": PRINT "CAN'T USE THAT!": SLEEP 2: GOTO 60210

60230  IF c(5) - p < 0 THEN PRINT "M'LORD THOU CAN NOT AFFORD THAT ITEM.": SLEEP 2: GOTO 60210

60235  IF z = 0 THEN pw(z) = pw(z) + 9

60236  pw(z) = pw(z) + 1: c(5) = c(5) - p

60237  LOCATE 10, 16: PRINT c(5); "  "

60240  LOCATE 5 + z, 25 - LEN(STR$(pw(z))): PRINT pw(z); : LOCATE 14, 1: PRINT

60250  GOTO 60210

