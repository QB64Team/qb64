DEFINT A-Z
DECLARE FUNCTION ak$ ()
DECLARE FUNCTION chot (t)
DECLARE FUNCTION chou (t)
DECLARE FUNCTION cr (t)
DECLARE FUNCTION cw (t)
DECLARE FUNCTION di (d1, d2)
DECLARE FUNCTION lts$ (nu)
DECLARE FUNCTION ltsb$ (nu&)
DECLARE FUNCTION ner (dn, max)
DECLARE FUNCTION nerb& (dn, max&)
DECLARE FUNCTION nerk$ ()
DECLARE FUNCTION txk$ ()
DECLARE SUB act (rl, t)
DECLARE SUB ar (t)
DECLARE SUB auc (t)
DECLARE SUB b ()
DECLARE SUB bca (t, houf, hotf)
DECLARE SUB box ()
DECLARE SUB broke (t)
DECLARE SUB buhot (t)
DECLARE SUB buhou (t)
DECLARE SUB ce (dn, tx$)
DECLARE SUB chk (l, m, h)
DECLARE SUB clk (se!)
DECLARE SUB cont (t, nos)
DECLARE SUB crd ()
DECLARE SUB dcha (t)
DECLARE SUB dche (t)
DECLARE SUB dy (wt)
DECLARE SUB fd (rl1, rl2, d1, d2, d3, d4)
DECLARE SUB gov (t)
DECLARE SUB inc (t)
DECLARE SUB init ()
DECLARE SUB inv ()
DECLARE SUB lil (wt)
DECLARE SUB lop (rl, t)
DECLARE SUB mb ()
DECLARE SUB md ()
DECLARE SUB mini (gr)
DECLARE SUB mob (t)
DECLARE SUB more (t)
DECLARE SUB mort (t)
DECLARE SUB move (dist, t)
DECLARE SUB noo (t)
DECLARE SUB opt (t)
DECLARE SUB p ()
DECLARE SUB pay (t, cge)
DECLARE SUB pim (gr, l, m, h)
DECLARE SUB popp (t, cge)
DECLARE SUB quit ()
DECLARE SUB rlc (t)
DECLARE SUB rules ()
DECLARE SUB save (t)
DECLARE SUB scha ()
DECLARE SUB sche ()
DECLARE SUB short (t, l, m, h)
DECLARE SUB shot (t)
DECLARE SUB shou (t)
DECLARE SUB sml (wt)
DECLARE SUB swbd ()
DECLARE SUB swbs ()
DECLARE SUB tiny (wt)
DECLARE SUB tj (t)
DECLARE SUB tn (t)
DECLARE SUB trade ()
DECLARE SUB unm (t)
DECLARE SUB upd ()
DECLARE SUB utc (t)
DECLARE SUB vwd ()
TYPE dd
ttl AS STRING * 21
ab AS STRING * 5
sty AS STRING * 1
c AS INTEGER
r AS INTEGER
r1 AS INTEGER
r2 AS INTEGER
r3 AS INTEGER
r4 AS INTEGER
rhot AS INTEGER
bc AS INTEGER
hue AS INTEGER
od AS INTEGER
oa AS INTEGER
id AS INTEGER
ia AS INTEGER
bdn AS INTEGER
bac AS INTEGER
own AS INTEGER
stat AS INTEGER
mop AS INTEGER
hk AS INTEGER
END TYPE
TYPE pl
ft AS STRING * 8
tk AS STRING * 1
c AS LONG
whr AS INTEGER
jc AS INTEGER
dc AS INTEGER
chag AS INTEGER
cheg AS INTEGER
END TYPE
ON ERROR GOTO 1
RANDOMIZE TIMER
DIM SHARED sf!, uf!, j, bn, x, q, fr&, bhu, bht, top(1 TO 6) AS STRING * 7, mdd(1 TO 6) AS STRING * 7, bot(1 TO 6) AS STRING * 7, cha(1 TO 16), che(1 TO 16), lot(39) AS dd, st(1 TO 2) AS pl
CLS
mb
md
swbd
cont t, nos
IF nos THEN
rules
bhu = 32
bht = 12
init
t = 1
END IF
IF st(1).whr > -10 THEN
LOCATE lot(st(1).whr).od, lot(st(1).whr).oa
PRINT st(1).tk
END IF
IF st(2).whr > -10 THEN
LOCATE lot(st(2).whr).id, lot(st(2).whr).ia
PRINT st(2).tk
END IF
DO
IF st(t).whr > -10 THEN tn t ELSE tj t
t = 3 - t
LOOP
1
SELECT CASE ERR
CASE 53
nos = -1
RESUME NEXT
CASE 255
ce 10, "The save is faulty."
ce 11, "I will delete it."
p
nos = -1
CLOSE
KILL "monopoly.dat"
RESUME NEXT
CASE ELSE
box
ce 5, "Crash " + lts(ERR) + " has happened."
ce 7, "Take note of what was going on just before the crash."
ce 9, "Contact me at grahambhg@yahoo.com,"
ce 10, "and I will see what I can do."
crd
END SELECT
DATA ,,o,,,,,,,,,,23,78,21,72,,
DATA Mediterranean Avenue,MEDIT,b,60,2,10,30,90,160,250,50,5,23,68,21,68,22,65
DATA ,,o,,,,,,,,,,23,61,21,61,,
DATA Baltic Avenue,BALTI,b,60,4,20,60,180,320,450,50,5,23,54,21,54,22,51
DATA ,,o,,,,,,,,,,23,47,21,47,,
DATA Reading Railroad,READR,r,200,,25,50,100,200,,,7,23,40,21,40,,
DATA Oriental Avenue,ORIEN,b,100,6,30,90,270,400,550,50,11,23,33,21,33,22,30
DATA ,,o,,,,,,,,,,23,26,21,26,,
DATA Vermont Avenue,VERMO,b,100,6,30,90,270,400,550,50,11,23,19,21,19,22,16
DATA Conneticut Avenue,CONNE,b,120,8,40,100,300,450,600,50,11,23,12,21,12,22,9
DATA ,,o,,,,,,,,,,23,2,21,8,,
DATA Saint Charles Place,STCHA,b,140,10,50,150,450,625,750,100,13,20,2,20,9,20,8
DATA Electric Company,ELECT,u,150,,,,,,,,7,18,2,18,9,,
DATA States Avenue,STATE,b,140,10,50,150,450,625,750,100,13,16,2,16,9,16,8
DATA Virginia Avenue,VIRGI,b,160,12,60,180,500,700,900,100,13,14,2,14,9,14,8
DATA Pennsylvania Railroad,PENRR,r,200,,25,50,100,200,,,7,12,2,12,9,,
DATA Saint James Place,STJAM,b,180,14,70,200,550,750,950,100,12,10,2,10,9,10,8
DATA ,,o,,,,,,,,,,8,2,8,9,,
DATA Tennessee Avenue,TENNE,b,180,14,70,200,550,750,950,100,12,6,2,6,9,6,8
DATA New York Avenue,NEWYO,b,200,16,80,220,600,800,1000,100,12,4,2,4,9,4,8
DATA ,,o,,,,,,,,,,1,2,3,8,,
DATA Kentucky Avenue,KENTU,b,220,18,90,250,700,875,1050,150,4,1,12,3,12,2,15
DATA ,,o,,,,,,,,,,1,19,3,19,,
DATA Indiana Avenue,INDIA,b,220,18,90,250,700,875,1050,150,4,1,26,3,26,2,29
DATA Illinois Avenue,ILLIN,b,240,20,100,300,750,925,1100,150,4,1,33,3,33,2,36
DATA B. & O. Railroad,B&ORR,r,200,,25,50,100,200,,,7,1,40,3,40,,
DATA Atlantic Avenue,ATLAN,b,260,22,110,330,800,975,1150,150,14,1,47,3,47,2,50
DATA Ventnor Avenue,VENTN,b,260,22,110,330,800,975,1150,150,14,1,54,3,54,2,57
DATA Water Works,WATER,u,150,,,,,,,,7,1,61,3,61,,
DATA Marvin Gardens,MARVI,b,280,24,120,360,850,1025,1200,150,14,1,68,3,68,2,71
DATA ,,o,,,,,,,,,,1,78,3,72,,
DATA Pacific Avenue,PACIF,b,300,26,130,390,900,1100,1275,200,10,4,78,4,71,4,72
DATA North Carolina Avenue,NORTH,b,300,26,130,390,900,1100,1275,200,10,6,78,6,71,6,72
DATA ,,o,,,,,,,,,,8,78,8,71,,
DATA Pennsylvania Avenue,PENAV,b,320,28,150,450,1000,1200,1400,200,10,10,78,10,71,10,72
DATA Short Line,SHORT,r,200,,25,50,100,200,,,7,12,78,12,71,,
DATA ,,o,,,,,,,,,,14,78,14,71,,
DATA Park Place,PARKP,b,350,35,175,500,1100,1300,1500,200,9,16,78,16,71,16,72
DATA ,,o,,,,,,,,,,18,78,18,71,,
DATA Boardwalk,BOARD,b,400,50,200,600,1400,1700,2000,200,9,20,78,20,71,20,72

SUB act (rl, t)
SELECT CASE st(t).whr
CASE 0
ce 10, "You landed on Go."
IF bn THEN
st(t).c = st(t).c + 200
ce 11, "Collect $400."
ELSE
ce 11, "Collect $200."
END IF
p
CASE 2, 17, 33
dche t
CASE 4
inc t
CASE 7, 22, 36
dcha t
CASE 10
ce 10, "Just visiting"
p
CASE 20
ce 10, "Free Parking"
IF j THEN
ce 11, "You get $" + ltsb(fr&)
st(t).c = st(t).c + fr&
fr& = 500
END IF
p
CASE 30
ar t
CASE 38
ce 10, "Luxury Tax. Pay $75."
p
pay t, 75
IF j THEN fr& = fr& + 75
p
CASE ELSE
lop rl, t
END SELECT
END SUB

FUNCTION ak$
DO
LOOP UNTIL INKEY$ = ""
DO
tx$ = LCASE$(INKEY$)
LOOP UNTIL tx$ > ""
ak = tx$
END FUNCTION

SUB ar (t)
ce 9, RTRIM$(st(t).ft) + " will be sent directly to Jail."
p
IF t = 1 THEN LOCATE lot(st(1).whr).od, lot(st(1).whr).oa ELSE LOCATE lot(st(2).whr).id, lot(st(2).whr).ia
PRINT " "
st(t).whr = -10
st(t).dc = 0
box
END SUB

SUB auc (t)
lwst = INT(.5 + lot(st(t).whr).c / 10)
bj = INT(.5 + lwst / 2)
nw = lwst
box
COLOR lot(st(t).whr).hue
ce 5, RTRIM$(lot(st(t).whr).ttl)
COLOR 15
ce 6, RTRIM$(st(1).ft) + ", you have $" + ltsb(st(1).c)
ce 7, "Do I hear $" + lts(nw) + "?"
IF cr(1) + st(1).c >= nw THEN ce 8, "(Y/N)" ELSE ce 8, "press N to Not bid."
DO
LOOP UNTIL INKEY$ = ""
DO
yn$ = LCASE$(INKEY$)
LOOP UNTIL yn$ = "n" OR (yn$ = "y" AND cr(1) + st(1).c >= nw)
IF yn$ = "y" THEN
ce 10, " I hear $" + lts(nw)
nw = nw + bj
bidder = 1
ELSE
ce 10, RTRIM$(st(1).ft) + " passes first bid."
END IF
clk .5
box
COLOR lot(st(t).whr).hue
ce 5, RTRIM$(lot(st(t).whr).ttl)
COLOR 15
ce 6, RTRIM$(st(2).ft) + ", you have $" + ltsb(st(2).c)
ce 7, "Do I hear $" + lts(nw) + "?"
IF cr(2) + st(2).c >= nw THEN ce 8, "(Y/N)" ELSE ce 8, "press N to Not bid."
DO
LOOP UNTIL INKEY$ = ""
DO
yn$ = LCASE$(INKEY$)
LOOP UNTIL yn$ = "n" OR (yn$ = "y" AND cr(2) + st(2).c >= nw)
IF yn$ = "y" THEN
ce 10, " I hear $" + lts(nw)
nw = nw + bj
bidder = 2
ELSE
ce 9, "Going, going, going..."
END IF
clk .5
SELECT CASE bidder
CASE 0
ce 11, "No sale!"
p
CASE 1
pay 1, lwst
COLOR lot(st(t).whr).hue
ce 10, RTRIM$(lot(st(t).whr).ttl)
COLOR 15
lot(st(t).whr).own = 1
p
CASE 2
who = 1
DO
box
COLOR lot(st(t).whr).hue
ce 5, RTRIM$(lot(st(t).whr).ttl)
COLOR 15
ce 6, RTRIM$(st(who).ft) + ", you have $" + ltsb(st(who).c)
ce 7, "Do I hear $" + lts(nw) + "?"
IF cr(who) + st(who).c >= nw THEN ce 8, "(Y/N)" ELSE ce 8, "press N to Not bid."
DO
LOOP UNTIL INKEY$ = ""
DO
yn$ = LCASE$(INKEY$)
LOOP UNTIL yn$ = "n" OR (yn$ = "y" AND cr(who) + st(who).c >= nw)
IF yn$ = "y" THEN
ce 10, " I hear $" + lts(nw)
nw = nw + bj
bidder = who
ELSE
ce 9, "Going, going, going..."
done = -1
END IF
clk .5
who = 3 - who
LOOP UNTIL done
COLOR lot(st(t).whr).hue
ce 10, RTRIM$(lot(st(t).whr).ttl)
COLOR 15
pay bidder, nw - bj
lot(st(t).whr).own = bidder
p
END SELECT
END SUB

SUB b
DO
LOOP UNTIL INKEY$ = ""
FOR al = 300 TO 500 STEP 100
SOUND al, 2
NEXT
END SUB

SUB bca (t, houf, hotf)
hss = chou(t)
hts = chot(t)
ce 8, RTRIM$(st(t).ft) + ", you have " + lts(hss) + " house(s) and " + lts(hts) + " hotel(s)."
fee = hss * houf + hts * hotf
ce 9, "$" + lts(fee) + " due."
p
IF fee = 0 THEN EXIT SUB
pay t, fee
p
IF j THEN fr& = fr& + fee
END SUB

SUB box
COLOR 8
ce 4, CHR$(201) + STRING$(59, 205) + CHR$(187)
FOR sides = 5 TO 17
ce sides, CHR$(186) + SPACE$(59) + CHR$(186)
NEXT
ce 18, CHR$(204) + STRING$(8, 205) + CHR$(187) + SPACE$(50) + CHR$(186)
ce 19, CHR$(186) + SPACE$(8) + CHR$(186) + SPACE$(50) + CHR$(186)
ce 20, CHR$(200) + STRING$(8, 205) + CHR$(202) + STRING$(50, 205) + CHR$(188)
COLOR 6
LOCATE 19, 11
PRINT "JAIL:"
COLOR 15
IF st(1).whr = -10 THEN
LOCATE 19, 16
PRINT st(1).tk
END IF
IF st(2).whr = -10 THEN
LOCATE 19, 18
PRINT st(2).tk
END IF
IF (NOT x) THEN
LOCATE 18, 61
PRINT USING "houses:##"; bhu
END IF
IF (NOT x) THEN
LOCATE 19, 61
PRINT USING "hotels:##"; bht
END IF
END SUB

SUB broke (t)
DO
box
owe = ABS(st(t).c)
v = cr(t)
ce 5, RTRIM$(st(t).ft) + ", you need to raise $" + lts(ABS(owe))
ce 6, "You can raise $" + lts(v)
IF owe > v THEN
ce 12, "YOU ARE BROKE!!"
ce 16, "press Q to Quit game"
DO
LOOP UNTIL INKEY$ = ""
DO
done$ = LCASE$(INKEY$)
LOOP UNTIL done$ = "q"
gov 3 - t
END IF
ce 9, "press 4 to mortgage properties"
ce 10, "press 5 to sell houses"
ce 11, "press 6 to sell hotels"
ce 13, "press 8 to see inventories"
ce 14, "press 9 to view deeds"
ce 16, "press Q to Quit game"
DO
LOOP UNTIL INKEY$ = ""
DO
wtn$ = LCASE$(INKEY$)
wtn = VAL(wtn$)
LOOP UNTIL wtn$ > ""
IF wtn$ = "q" THEN quit
SELECT CASE wtn
CASE 4
mort t
CASE 5
shou t
swbs
CASE 6
shot t
swbs
CASE 8
inv
CASE 9
vwd
END SELECT
LOOP UNTIL st(t).c >= 0
box
END SUB

SUB buhot (t)
DIM gm(9)
gm(0) = -1
box
IF lot(1).own = t AND lot(1).stat = 4 AND st(t).c >= 50 AND bht > 0 THEN
gm(1) = -1
mini 1
END IF
IF lot(6).own = t AND lot(6).stat = 4 AND st(t).c >= 50 AND bht > 0 THEN
gm(2) = -1
mini 2
END IF
IF lot(11).own = t AND lot(11).stat = 4 AND st(t).c >= 100 AND bht > 0 THEN
gm(3) = -1
mini 3
END IF
IF lot(16).own = t AND lot(16).stat = 4 AND st(t).c >= 100 AND bht > 0 THEN
gm(4) = -1
mini 4
END IF
IF lot(21).own = t AND lot(21).stat = 4 AND st(t).c >= 150 AND bht > 0 THEN
gm(5) = -1
mini 5
END IF
IF lot(26).own = t AND lot(26).stat = 4 AND st(t).c >= 150 AND bht > 0 THEN
gm(6) = -1
mini 6
END IF
IF lot(31).own = t AND lot(31).stat = 4 AND st(t).c >= 200 AND bht > 0 THEN
gm(7) = -1
mini 7
END IF
IF lot(37).own = t AND lot(37).stat = 4 AND st(t).c >= 200 AND bht > 0 THEN
gm(8) = -1
mini 8
END IF
ce 9, RTRIM$(st(t).ft)
ce 10, "Choose a monopoly to buy hotels for"
ce 11, "or 0 to continue"
DO
IF wlb > 0 AND (NOT q) THEN b
DO
LOOP UNTIL INKEY$ = ""
DO
wlb$ = INKEY$
IF wlb$ = CHR$(13) THEN wlb$ = "0"
LOOP UNTIL wlb$ > ""
IF wlb$ >= "0" AND wlb$ <= "8" THEN wlb = VAL(wlb$) ELSE wlb = 9
LOOP UNTIL gm(wlb)
IF wlb = 0 THEN EXIT SUB
box
ce 5, RTRIM$(st(t).ft)
pim wlb, l, m, h
SELECT CASE m
CASE 2
IF lot(h).stat = 5 THEN max = 1 ELSE max = 2
CASE ELSE
max = 3
IF lot(h).stat = 5 THEN max = 2
IF lot(m).stat = 5 THEN max = 1
END SELECT
IF max > bht THEN max = bht
IF max > INT(st(t).c / lot(l).bc) THEN max = INT(st(t).c / lot(l).bc)
ce 7, "you can buy up to " + lts(max) + " hotel(s)."
ce 8, "or 0 to continue"
ce 10, "you have $" + ltsb(st(t).c)
ce 11, "hotels cost $" + lts(lot(l).bc) + " (plus four houses) each."
quan = ner(9, max)
IF quan = 0 THEN EXIT SUB
tot = lot(l).stat + lot(m).stat + lot(h).stat + quan
SELECT CASE m
CASE 2
lot(h).stat = INT(tot / 2)
lot(l).stat = INT(tot / 2)
IF lot(h).stat + lot(l).stat < tot THEN lot(h).stat = lot(h).stat + 1
CASE ELSE
lot(h).stat = INT(tot / 3)
lot(m).stat = INT(tot / 3)
lot(l).stat = INT(tot / 3)
IF lot(h).stat + lot(l).stat + lot(m).stat < tot THEN lot(h).stat = lot(h).stat + 1
IF lot(h).stat + lot(l).stat + lot(m).stat < tot THEN lot(m).stat = lot(m).stat + 1
END SELECT
pay t, lot(l).bc * quan
p
IF (NOT x) THEN
bht = bht - quan
bhu = bhu + quan * 4
END IF
END SUB

SUB buhou (t)
DIM gm(9)
gm(0) = -1
box
IF lot(1).own = t AND lot(1).mop AND (NOT lot(1).hk) AND (NOT lot(3).hk) AND lot(1).stat < 4 AND st(t).c >= 50 AND bhu > 0 THEN
gm(1) = -1
mini 1
END IF
IF lot(6).own = t AND lot(6).mop AND (NOT lot(6).hk) AND (NOT lot(8).hk) AND (NOT lot(9).hk) AND lot(6).stat < 4 AND st(t).c >= 50 AND bhu > 0 THEN
gm(2) = -1
mini 2
END IF
IF lot(11).own = t AND lot(11).mop AND (NOT lot(11).hk) AND (NOT lot(13).hk) AND (NOT lot(14).hk) AND lot(11).stat < 4 AND st(t).c >= 100 AND bhu > 0 THEN
gm(3) = -1
mini 3
END IF
IF lot(16).own = t AND lot(16).mop AND (NOT lot(16).hk) AND (NOT lot(18).hk) AND (NOT lot(19).hk) AND lot(16).stat < 4 AND st(t).c >= 100 AND bhu > 0 THEN
gm(4) = -1
mini 4
END IF
IF lot(21).own = t AND lot(21).mop AND (NOT lot(21).hk) AND (NOT lot(23).hk) AND (NOT lot(24).hk) AND lot(21).stat < 4 AND st(t).c >= 150 AND bhu > 0 THEN
gm(5) = -1
mini 5
END IF
IF lot(26).own = t AND lot(26).mop AND (NOT lot(26).hk) AND (NOT lot(27).hk) AND (NOT lot(29).hk) AND lot(26).stat < 4 AND st(t).c >= 150 AND bhu > 0 THEN
gm(6) = -1
mini 6
END IF
IF lot(31).own = t AND lot(31).mop AND (NOT lot(31).hk) AND (NOT lot(32).hk) AND (NOT lot(34).hk) AND lot(31).stat < 4 AND st(t).c >= 200 AND bhu > 0 THEN
gm(7) = -1
mini 7
END IF
IF lot(37).own = t AND lot(37).mop AND (NOT lot(37).hk) AND (NOT lot(39).hk) AND lot(37).stat < 4 AND st(t).c >= 200 AND bhu > 0 THEN
gm(8) = -1
mini 8
END IF
ce 9, RTRIM$(st(t).ft)
ce 10, "Choose a monopoly to buy houses for"
ce 11, "or 0 to continue"
DO
IF wlb > 0 AND (NOT q) THEN b
DO
LOOP UNTIL INKEY$ = ""
DO
wlb$ = INKEY$
IF wlb$ = CHR$(13) THEN wlb$ = "0"
LOOP UNTIL wlb$ > ""
IF wlb$ >= "0" AND wlb$ <= "8" THEN wlb = VAL(wlb$) ELSE wlb = 9
LOOP UNTIL gm(wlb)
IF wlb = 0 THEN EXIT SUB
box
ce 5, RTRIM$(st(t).ft)
pim wlb, l, m, h
SELECT CASE m
CASE 2
max = 8 - lot(l).stat - lot(h).stat
CASE ELSE
max = 12 - lot(l).stat - lot(m).stat - lot(h).stat
END SELECT
IF max > bhu THEN max = bhu
IF max > INT(st(t).c / lot(l).bc) THEN max = INT(st(t).c / lot(l).bc)
ce 7, "you can buy up to " + lts(max) + " house(s)."
ce 8, "or 0 to continue"
ce 10, "you have $" + ltsb(st(t).c)
ce 11, "houses cost $" + lts(lot(l).bc) + " each."
quan = ner(9, max)
IF quan = 0 THEN EXIT SUB
tot = lot(l).stat + lot(m).stat + lot(h).stat + quan
SELECT CASE m
CASE 2
lot(h).stat = INT(tot / 2)
lot(l).stat = INT(tot / 2)
IF lot(h).stat + lot(l).stat < tot THEN lot(h).stat = lot(h).stat + 1
CASE ELSE
lot(h).stat = INT(tot / 3)
lot(m).stat = INT(tot / 3)
lot(l).stat = INT(tot / 3)
IF lot(h).stat + lot(l).stat + lot(m).stat < tot THEN lot(h).stat = lot(h).stat + 1
IF lot(h).stat + lot(l).stat + lot(m).stat < tot THEN lot(m).stat = lot(m).stat + 1
END SELECT
pay t, lot(l).bc * quan
p
IF (NOT x) THEN bhu = bhu - quan
END SUB

SUB ce (dn, tx$)
LOCATE dn, 40 - INT(LEN(tx$) / 2)
PRINT tx$
END SUB

SUB chk (l, m, h)
IF lot(l).own = lot(m).own AND lot(m).own = lot(h).own AND lot(l).own > 0 THEN
lot(l).mop = -1
lot(m).mop = -1
lot(h).mop = -1
ELSE
lot(l).mop = 0
lot(m).mop = 0
lot(h).mop = 0
END IF
END SUB

FUNCTION chot (t)
FOR sq = 1 TO 39
IF lot(sq).sty = "b" AND lot(sq).own = t AND lot(sq).stat = 5 THEN ced = ced + 1
NEXT
chot = ced
END FUNCTION

FUNCTION chou (t)
FOR sq = 1 TO 39
IF lot(sq).sty = "b" AND lot(sq).own = t AND lot(sq).stat < 5 THEN ced = ced + lot(sq).stat
NEXT
chou = ced
END FUNCTION

SUB clk (se!)
start# = TIMER
DO
IF se! >= .1 THEN
DO
LOOP UNTIL INKEY$ = ""
END IF
LOOP UNTIL TIMER < start# OR TIMER - start# >= se!
END SUB

SUB cont (t, nos)
OPEN "monopoly.dat" FOR INPUT AS #1
IF (NOT nos) THEN
ce 5, "I found a save."
ce 7, "Do you want to continue prior game? (Y/N)"
DO
yn$ = LCASE$(INKEY$)
LOOP UNTIL yn$ = "y" OR yn$ = "n"
ce 8, UCASE$(yn$)
p
IF yn$ = "n" THEN
CLOSE
nos = -1
EXIT SUB
END IF
INPUT #1, sf!
IF sf! <> 1 AND sf! <> .5 THEN GOTO oops
INPUT #1, uf!
IF uf! <> .5 AND uf! <> .55 THEN GOTO oops
INPUT #1, t
IF t < 1 OR t > 2 THEN GOTO oops
INPUT #1, fr&
IF fr& < 0 THEN GOTO oops
INPUT #1, bhu
IF bhu < 0 OR bhu > 32 THEN GOTO oops
INPUT #1, bht
IF bht < 0 OR bht > 12 THEN GOTO oops
INPUT #1, j
IF j < -1 OR j > 0 THEN GOTO oops
INPUT #1, bn
IF bn < -1 OR bn > 0 THEN GOTO oops
INPUT #1, x
IF x < -1 OR x > 0 THEN GOTO oops
INPUT #1, q
IF q < -1 OR q > 0 THEN GOTO oops
FOR sq = 0 TO 39
INPUT #1, lot(sq).own
IF lot(sq).own < 0 OR lot(sq).own > 2 THEN GOTO oops
INPUT #1, lot(sq).stat
IF lot(sq).stat < 0 OR lot(sq).stat > 5 THEN GOTO oops
INPUT #1, lot(sq).mop
IF lot(sq).mop < -1 OR lot(sq).mop > 0 THEN GOTO oops
INPUT #1, lot(sq).hk
IF lot(sq).hk < -1 OR lot(sq).hk > 0 THEN GOTO oops
NEXT
FOR sq = 1 TO 2
INPUT #1, st(sq).ft
INPUT #1, st(sq).tk
INPUT #1, st(sq).c
IF st(sq).c < 0 THEN GOTO oops
INPUT #1, st(sq).whr
IF (st(sq).whr < 0 OR st(sq).whr > 39) AND st(sq).whr <> -10 THEN GOTO oops
INPUT #1, st(sq).jc
IF st(sq).jc < 0 OR st(sq).jc > 2 THEN GOTO oops
INPUT #1, st(sq).dc
IF st(sq).dc < 0 OR st(sq).dc > 2 THEN GOTO oops
INPUT #1, st(sq).chag
IF st(sq).chag < -1 OR st(sq).chag > 0 THEN GOTO oops
INPUT #1, st(sq).cheg
IF st(sq).cheg < -1 OR st(sq).cheg > 0 THEN GOTO oops
NEXT
FOR sq = 1 TO 16
INPUT #1, cha(sq)
IF cha(sq) < 0 OR cha(sq) > 2 THEN GOTO oops
INPUT #1, che(sq)
IF che(sq) < 0 OR che(sq) > 2 THEN GOTO oops
NEXT
CLOSE
KILL "monopoly.dat"
upd
END IF
EXIT SUB
oops:
ERROR 255
END SUB

FUNCTION cr (t)
FOR sq = 1 TO 39
IF lot(sq).own = t THEN
IF (NOT lot(sq).hk) THEN current = current + lot(sq).c / 2
IF lot(sq).sty = "b" THEN current = current + lot(sq).bc * lot(sq).stat * sf!
END IF
NEXT
cr = current
END FUNCTION

SUB crd
ce 12, "Program written by Brian H. Graham."
ce 13, "Based on the board game 'Monopoly' by Parker Brothers."
p
LOCATE 25, 1
COLOR 7
SYSTEM
END SUB

FUNCTION cw (t)
FOR sq = 1 TO 39
IF lot(sq).own = t THEN
IF lot(sq).hk THEN current = current + lot(sq).c / 2 ELSE current = current + lot(sq).c
IF lot(sq).sty = "b" THEN current = current + lot(sq).bc * lot(sq).stat
END IF
NEXT
cw = current + st(t).c
END FUNCTION

SUB dcha (t)
FOR look = 1 TO 16
IF cha(look) > 0 THEN ucha = ucha + 1
NEXT
IF ucha = 16 THEN scha
box
ce 5, RTRIM$(st(t).ft)
DO
cd = INT(RND * 16) + 1
LOOP UNTIL cha(cd) = 0
cha(cd) = 1
COLOR 12
ce 6, "Chance"
COLOR 15
SELECT CASE cd
CASE 1
ce 7, "Advance to Go. (Collect $200.)"
p
move 40 - st(t).whr, t
p
CASE 2
ce 7, "Advance to Illinois Avenue."
p
IF st(t).whr < 24 THEN move 24 - st(t).whr, t ELSE move 64 - st(t).whr, t
lop rl, t
CASE 3
ce 7, "Advance to the nearest Utility."
ce 8, "If it is owned, roll the dice,"
ce 9, "and pay the own ten times the amount shown."
ce 10, "If it is not owned, you may buy it."
p
SELECT CASE st(t).whr
CASE 7
move 12 - st(t).whr, t
CASE 22
move 28 - st(t).whr, t
CASE 36
move 52 - st(t).whr, t
END SELECT
utc t
CASE 4, 5
ce 7, "Advance to the next Railroad."
ce 8, "If it is owned, pay the own double"
ce 9, "the rent he/she is usually entitled."
ce 10, "If it is not owned, you may buy it."
p
SELECT CASE st(t).whr
CASE 7
move 15 - st(t).whr, t
CASE 22
move 25 - st(t).whr, t
CASE 36
move 45 - st(t).whr, t
END SELECT
rlc t
CASE 6
ce 7, "Advance to Saint Charles Place."
ce 8, "If you pass Go, collect $200."
p
IF st(t).whr < 11 THEN move 11 - st(t).whr, t ELSE move 51 - st(t).whr, t
lop rl, t
CASE 7
ce 7, "Bank pays you dividend of $50."
st(t).c = st(t).c + 50
p
CASE 8
ce 7, "Get out of Jail free."
ce 8, "This card may be kept until used or traded."
cha(8) = 2
st(t).chag = -1
p
CASE 9
ce 7, "Go back three spaces."
p
mob t
act rl, t
CASE 10
ce 7, "Go directly to Jail."
ce 8, "Do not pass Go, Do not collect $200."
p
ar t
CASE 11
ce 7, "Make general repairs on all you properties."
ce 8, "Pay $25 per house, $100 per hotel."
bca t, 25, 100
CASE 12
ce 7, "Pay poor tax of $15."
p
pay t, 15
IF j THEN fr& = fr& + 15
p
CASE 13
ce 7, "Take a ride on the Reading."
ce 8, "Advance to Reading Railroad."
ce 9, "Collect $200 if you pass Go."
p
move 45 - st(t).whr, t
lop rl, t
CASE 14
ce 7, "Take a walk on the boardwalk."
ce 8, "Advance to Boardwalk."
p
move 39 - st(t).whr, t
lop rl, t
CASE 15
ce 7, "You have been elected chairman of the board."
ce 8, "Pay each player $50."
p
popp t, 50
CASE 16
ce 7, "Your building and loan matures. Collect $150."
st(t).c = st(t).c + 150
p
END SELECT
END SUB

SUB dche (t)
FOR look = 1 TO 16
IF che(look) > 0 THEN uche = uche + 1
NEXT
IF uche = 16 THEN sche
box
ce 5, RTRIM$(st(t).ft)
DO
cd = INT(RND * 16) + 1
LOOP UNTIL che(cd) = 0
che(cd) = 1
COLOR 14
ce 6, "Community Chest"
COLOR 15
SELECT CASE cd
CASE 1
ce 7, "Advance to Go. (Collect $200.)"
p
move 40 - st(t).whr, t
p
CASE 2
ce 7, "Bank error in your favor. Collect $200."
p
st(t).c = st(t).c + 200
CASE 3
ce 7, "Christmas fund matures. Collect $100."
p
st(t).c = st(t).c + 100
CASE 4
ce 7, "Doctor's fee. Pay $50."
p
pay t, 50
p
IF j THEN fr& = fr& + 50
CASE 5
ce 7, "From sale of stock you get $45."
p
st(t).c = st(t).c + 45
CASE 6
ce 7, "Get out of Jail free."
ce 8, "This card may be kept until used or traded."
che(6) = 2
st(t).cheg = -1
p
CASE 7
ce 7, "Go directly to Jail."
ce 8, "Do not pass Go, Do not collect $200."
p
ar t
CASE 8
ce 7, "Grand opera opening. Collect $50 from every player."
p
popp 3 - t, 50
CASE 9
ce 7, "Income tax refund. Collect $20."
p
st(t).c = st(t).c + 20
CASE 10
ce 7, "Life insurance matures. Collect $100."
p
st(t).c = st(t).c + 100
CASE 11
ce 7, "Pay hospital $100."
p
pay t, 100
p
IF j THEN fr& = fr& + 100
CASE 12
ce 7, "Pay school tax of $150."
p
pay t, 150
p
IF j THEN fr& = fr& + 150
CASE 13
ce 7, "Recieve for services $25."
p
st(t).c = st(t).c + 25
CASE 14
ce 7, "You are assesed for street repairs."
ce 8, "$40 per house, $115 per hotel."
bca t, 40, 115
CASE 15
ce 7, "You have won second prize in a beauty contest."
ce 8, "Collect $10."
p
st(t).c = st(t).c + 10
CASE 16
ce 7, "You inherit $100."
p
st(t).c = st(t).c + 100
END SELECT
END SUB

FUNCTION di (d1, d2)
d1 = INT(RND * 6) + 1
d2 = INT(RND * 6) + 1
di = d1 + d2
ce 14, CHR$(218) + STRING$(5, 196) + CHR$(191) + CHR$(218) + STRING$(5, 196) + CHR$(191)
ce 15, top(d1) + top(d2)
ce 16, mdd(d1) + mdd(d2)
ce 17, bot(d1) + bot(d2)
ce 18, CHR$(192) + STRING$(5, 196) + CHR$(217) + CHR$(192) + STRING$(5, 196) + CHR$(217)
END FUNCTION

SUB dy (wt)
PRINT wt;
COLOR lot(wt).hue
PRINT lot(wt).ab;
COLOR 15
PRINT " $";
IF lot(wt).hk THEN PRINT lts(INT(.5 + lot(wt).c * uf!)) ELSE PRINT lts(lot(wt).c / 2)
END SUB

SUB fd (rl1, rl2, d1, d2, d3, d4)
d1 = INT(RND * 6) + 1
d2 = INT(RND * 6) + 1
d3 = INT(RND * 6) + 1
d4 = INT(RND * 6) + 1
rl1 = d1 + d2
rl2 = d3 + d4
ce 13, RTRIM$(st(1).ft) + SPACE$(6) + RTRIM$(st(2).ft)
ce 14, CHR$(218) + STRING$(5, 196) + CHR$(191) + CHR$(218) + STRING$(5, 196) + CHR$(191) + SPACE$(6) + CHR$(218) + STRING$(5, 196) + CHR$(191) + CHR$(218) + STRING$(5, 196) + CHR$(191)
ce 15, top(d1) + top(d2) + SPACE$(6) + top(d3) + top(d4)
ce 16, mdd(d1) + mdd(d2) + SPACE$(6) + mdd(d3) + mdd(d4)
ce 17, bot(d1) + bot(d2) + SPACE$(6) + bot(d3) + bot(d4)
ce 18, CHR$(192) + STRING$(5, 196) + CHR$(217) + CHR$(192) + STRING$(5, 196) + CHR$(217) + SPACE$(6) + CHR$(192) + STRING$(5, 196) + CHR$(217) + CHR$(192) + STRING$(5, 196) + CHR$(217)
END SUB

SUB gov (t)
st(1).whr = 0
st(2).whr = 0
x = -1
CLS
swbd
IF t = 0 THEN
ce 5, "This game was a tie!"
ce 7, "Thank you for playing " + RTRIM$(st(1).ft) + " and " + RTRIM$(st(2).ft)
ELSE
ce 5, RTRIM$(st(t).ft) + " has won!!!"
ce 8, "Better luck next time " + RTRIM$(st(3 - t).ft)
END IF
crd
END SUB

SUB inc (t)
box
ce 5, RTRIM$(st(t).ft)
ce 6, "Income Tax"
ce 8, "press W to pay 10% of your Worth"
ce 9, "press F to pay $200 Flat rate"
DO
LOOP UNTIL INKEY$ = ""
DO
taxopt$ = LCASE$(INKEY$)
LOOP UNTIL taxopt$ = "f" OR taxopt$ = "w"
IF taxopt$ = "f" THEN fee = 200 ELSE fee = INT(.5 + cw(t) / 10)
ce 10, UCASE$(taxopt$) + ", $" + lts(fee) + " due."
p
pay t, fee
p
IF j THEN fr& = fr& + fee
END SUB

SUB init
alto$ = CHR$(2) + CHR$(3) + CHR$(4) + CHR$(5) + CHR$(6) + CHR$(21) + CHR$(157) + CHR$(232) + CHR$(233) + CHR$(236)
FOR wide = 1 TO 10
wide$ = wide$ + MID$(alto$, wide, 1) + " "
NEXT
wide$ = RTRIM$(wide$)
FOR sq = 1 TO 2
DO
box
ce 5, "Player " + lts(sq) + " first name"
who$ = ""
DO
ltr$ = txk
IF ltr$ = CHR$(8) AND LEN(who$) > 0 THEN
who$ = LEFT$(who$, (LEN(who$) - 1))
ELSE
IF ltr$ <> CHR$(13) AND ltr$ <> CHR$(8) THEN who$ = who$ + ltr$
END IF
IF LEN(who$) < 9 THEN
ce 6, SPACE$(10)
ce 6, who$
END IF
LOOP UNTIL ltr$ = CHR$(13) OR LEN(who$) = 10
st(sq).ft = who$
LOOP UNTIL st(1).ft <> st(2).ft AND st(sq).ft <> SPACE$(8)
ce 7, "pick a token"
ce 8, wide$
ce 9, "1 2 3 4 5 6 7 8 9 0"
IF hide > 0 THEN
LOCATE 8, hide * 2 + 29
PRINT " "
LOCATE 9, hide * 2 + 29
PRINT " "
END IF
DO
LOOP UNTIL INKEY$ = ""
DO
pick$ = INKEY$
pick = VAL(pick$)
IF pick = 0 THEN pick = 10
LOOP UNTIL pick$ >= "0" AND pick$ <= "9" AND pick <> hide
hide = pick
st(sq).tk = MID$(alto$, hide, 1)
st(sq).c = 1500
ce 11, lts(pick) + ", " + st(sq).tk
p
NEXT
DO
box
fd rl1, rl2, d1, d2, d3, d4
ce 5, "Determining who goes first:"
ce 7, RTRIM$(st(1).ft) + " rolls " + lts(d1) + " + " + lts(d2) + " = " + lts(rl1)
ce 8, RTRIM$(st(2).ft) + " rolls " + lts(d3) + " + " + lts(d4) + " + " + lts(rl2)
IF rl1 = rl2 THEN
ce 10, "No decision. I will try again."
p
END IF
LOOP UNTIL rl1 <> rl2
IF rl2 > rl1 THEN SWAP st(1), st(2)
ce 10, "This means " + RTRIM$(st(1).ft) + " goes first."
p
END SUB

SUB inv
FOR look = 0 TO 2
box
IF lot(1).own = look THEN
LOCATE 5, 11
lil 1
END IF
IF lot(3).own = look THEN
LOCATE 6, 11
lil 3
END IF
IF lot(5).own = look THEN
LOCATE 7, 11
lil 5
END IF
IF lot(6).own = look THEN
LOCATE 8, 11
lil 6
END IF
IF lot(8).own = look THEN
LOCATE 9, 11
lil 8
END IF
IF lot(9).own = look THEN
LOCATE 10, 11
lil 9
END IF
IF lot(11).own = look THEN
LOCATE 5, 26
lil 11
END IF
IF lot(12).own = look THEN
LOCATE 6, 26
lil 12
END IF
IF lot(13).own = look THEN
LOCATE 7, 26
lil 13
END IF
IF lot(14).own = look THEN
LOCATE 8, 26
lil 14
END IF
IF lot(15).own = look THEN
LOCATE 9, 26
lil 15
END IF
IF lot(16).own = look THEN
LOCATE 10, 26
lil 16
END IF
IF lot(18).own = look THEN
LOCATE 11, 26
lil 18
END IF
IF lot(19).own = look THEN
LOCATE 12, 26
lil 19
END IF
IF lot(21).own = look THEN
LOCATE 5, 41
lil 21
END IF
IF lot(23).own = look THEN
LOCATE 6, 41
lil 23
END IF
IF lot(24).own = look THEN
LOCATE 7, 41
lil 24
END IF
IF lot(25).own = look THEN
LOCATE 8, 41
lil 25
END IF
IF lot(26).own = look THEN
LOCATE 9, 41
lil 26
END IF
IF lot(27).own = look THEN
LOCATE 10, 41
lil 27
END IF
IF lot(28).own = look THEN
LOCATE 11, 41
lil 28
END IF
IF lot(29).own = look THEN
LOCATE 12, 41
lil 29
END IF
IF lot(31).own = look THEN
LOCATE 5, 56
lil 31
END IF
IF lot(32).own = look THEN
LOCATE 6, 56
lil 32
END IF
IF lot(34).own = look THEN
LOCATE 7, 56
lil 34
END IF
IF lot(35).own = look THEN
LOCATE 8, 56
lil 35
END IF
IF lot(37).own = look THEN
LOCATE 9, 56
lil 37
END IF
IF lot(39).own = look THEN
LOCATE 10, 56
lil 39
END IF
SELECT CASE look
CASE 0
ce 14, "unowned properties"
IF j THEN ce 16, "Free Parking has $" + ltsb(fr&)
CASE 1, 2
IF st(look).chag THEN
COLOR 12
LOCATE 12, 11
PRINT "GOOJF";
COLOR 15
PRINT " Chance"
END IF
IF st(look).cheg THEN
COLOR 14
LOCATE 12, 56
PRINT "GOOJF";
COLOR 15
PRINT " Cm Chst"
END IF
ce 14, RTRIM$(st(look).ft) + ", your properties"
ce 15, "you are the " + st(look).tk
IF st(look).c >= 0 THEN ce 16, "you have $" + ltsb(st(look).c) ELSE ce 16, "you need to raise $" + lts(ABS(st(look).c))
END SELECT
p
NEXT
END SUB

SUB lil (wt)
COLOR lot(wt).hue
PRINT lot(wt).ab;
COLOR 15
IF lot(wt).hk THEN
PRINT " mort"
ELSE
IF lot(wt).own > 0 THEN
SELECT CASE lot(wt).stat
CASE 0
IF lot(wt).mop THEN PRINT " doubl" ELSE PRINT " plain"
CASE 1
SELECT CASE lot(wt).sty
CASE "b"
PRINT " 1 hse"
CASE "r"
PRINT " 1 rr"
CASE "u"
PRINT " 1 utl"
END SELECT
CASE 2
SELECT CASE lot(wt).sty
CASE "b"
PRINT " 2 hses"
CASE "r"
PRINT " 2 rrs"
CASE "u"
PRINT " 2 utls"
END SELECT
CASE 3
SELECT CASE lot(wt).sty
CASE "b"
PRINT " 3 hses"
CASE "r"
PRINT " 3 rrs"
END SELECT
CASE 4
SELECT CASE lot(wt).sty
CASE "b"
PRINT " 4 hses"
CASE "r"
PRINT " 4 rrs"
END SELECT
CASE 5
PRINT " hotel"
END SELECT
END IF
END IF
END SUB

SUB lop (rl, t)
IF lot(st(t).whr).own = 0 THEN
noo t
EXIT SUB
END IF
IF lot(st(t).whr).own = t THEN
COLOR lot(st(t).whr).hue
ce 12, RTRIM$(lot(st(t).whr).ttl)
COLOR 15
ce 13, "is yours."
p
EXIT SUB
END IF
IF lot(st(t).whr).hk THEN
COLOR lot(st(t).whr).hue
ce 12, RTRIM$(lot(st(t).whr).ttl)
COLOR 15
ce 13, "is mortgaged."
p
EXIT SUB
END IF
SELECT CASE lot(st(t).whr).stat
CASE 0
IF lot(st(t).whr).mop THEN popp t, lot(st(t).whr).r * 2 ELSE popp t, lot(st(t).whr).r
CASE 1
IF lot(st(t).whr).sty = "u" THEN popp t, 4 * rl ELSE popp t, lot(st(t).whr).r1
CASE 2
IF lot(st(t).whr).sty = "u" THEN popp t, 10 * rl ELSE popp t, lot(st(t).whr).r2
CASE 3
popp t, lot(st(t).whr).r3
CASE 4
popp t, lot(st(t).whr).r4
CASE 5
popp t, lot(st(t).whr).rhot
END SELECT
END SUB

FUNCTION lts$ (nu)
lts = LTRIM$(STR$(nu))
END FUNCTION

FUNCTION ltsb$ (nu&)
ltsb = LTRIM$(STR$(nu&))
END FUNCTION

SUB mb
FOR sq = 0 TO 39
READ lot(sq).ttl
READ lot(sq).ab
READ lot(sq).sty
READ lot(sq).c
READ lot(sq).r
READ lot(sq).r1
READ lot(sq).r2
READ lot(sq).r3
READ lot(sq).r4
READ lot(sq).rhot
READ lot(sq).bc
READ lot(sq).hue
READ lot(sq).od
READ lot(sq).oa
READ lot(sq).id
READ lot(sq).ia
READ lot(sq).bdn
READ lot(sq).bac
NEXT
END SUB

SUB md
p0$ = CHR$(179) + SPACE$(5) + CHR$(179)
p1a$ = CHR$(179) + "@" + SPACE$(4) + CHR$(179)
p1b$ = CHR$(179) + SPACE$(2) + "@" + SPACE$(2) + CHR$(179)
p1c$ = CHR$(179) + SPACE$(4) + "@" + CHR$(179)
p2$ = CHR$(179) + "@" + SPACE$(3) + "@" + CHR$(179)
top(1) = p0$
mdd(1) = p1b$
bot(1) = p0$
top(2) = p1a$
mdd(2) = p0$
bot(2) = p1c$
top(3) = p1a$
mdd(3) = p1b$
bot(3) = p1c$
top(4) = p2$
mdd(4) = p0$
bot(4) = p2$
top(5) = p2$
mdd(5) = p1b$
bot(5) = p2$
top(6) = p2$
mdd(6) = p2$
bot(6) = p2$
END SUB

SUB mini (gr)
SELECT CASE gr
CASE 1
dn = 5
ac = 11
mophue = 5
mopstr$ = "MEDIT/BALTI"
CASE 2
dn = 6
ac = 11
mophue = 11
mopstr$ = "OREIN/VERMO/CONNE"
CASE 3
dn = 7
ac = 11
mophue = 13
mopstr$ = "STCHA/STATE/VIRGI"
CASE 4
dn = 8
ac = 11
mophue = 12
mopstr$ = "STJAM/TENNE/NEWYO"
CASE 5
dn = 5
ac = 41
mophue = 4
mopstr$ = "KENTU/INDIA/ILLIN"
CASE 6
dn = 6
ac = 41
mophue = 14
mopstr$ = "ATLAN/VENTN/MARVI"
CASE 7
dn = 7
ac = 41
mophue = 10
mopstr$ = "PACIF/NORTH/PENAV"
CASE 8
dn = 8
ac = 41
mophue = 9
mopstr$ = "PARKP/BOARD"
END SELECT
LOCATE dn, ac
PRINT gr;
COLOR mophue
PRINT mopstr$
COLOR 15
END SUB

SUB mob (t)
FOR sq = 0 TO 2
IF t = 1 THEN LOCATE lot(st(1).whr - sq).od, lot(st(1).whr - sq).oa ELSE LOCATE lot(st(2).whr - sq).id, lot(st(2).whr - sq).ia
PRINT " "
IF t = 1 THEN LOCATE lot(st(1).whr - sq - 1).od, lot(st(1).whr - sq - 1).oa ELSE LOCATE lot(st(2).whr - sq - 1).id, lot(st(2).whr - sq - 1).ia
PRINT st(t).tk
clk .1
NEXT
st(t).whr = (st(t).whr - 3)
END SUB

SUB more (t)
DO
box
ce 5, RTRIM$(st(t).ft) + ", you have $" + ltsb(st(t).c)
ce 6, "press 1 to unmortgage properties"
ce 7, "press 2 to buy houses"
ce 8, "press 3 to buy hotels"
ce 9, "press 4 to mortgage properties"
ce 10, "press 5 to sell houses"
ce 11, "press 6 to sell hotels"
ce 12, "press 7 to trade"
ce 13, "press 8 to see inventories"
ce 14, "press 9 to view deeds"
ce 15, "press any other key to continue"
wtn = VAL(ak)
SELECT CASE wtn
CASE 1
unm t
CASE 2
buhou t
swbs
CASE 3
buhot t
swbs
CASE 4
mort t
CASE 5
shou t
swbs
CASE 6
shot t
swbs
CASE 7
trade
upd
CASE 8
inv
CASE 9
vwd
END SELECT
LOOP UNTIL wtn = 0
END SUB

SUB mort (t)
DIM gp(39)
gp(0) = -1
box
IF lot(1).own = t AND (NOT lot(1).hk) AND lot(3).stat = 0 THEN
LOCATE 5, 11
dy 1
gp(1) = -1
END IF
IF lot(3).own = t AND (NOT lot(3).hk) AND lot(3).stat = 0 THEN
LOCATE 6, 11
dy 3
gp(3) = -1
END IF
IF lot(5).own = t AND (NOT lot(5).hk) THEN
LOCATE 7, 11
dy 5
gp(5) = -1
END IF
IF lot(6).own = t AND (NOT lot(6).hk) AND lot(9).stat = 0 THEN
LOCATE 8, 11
dy 6
gp(6) = -1
END IF
IF lot(8).own = t AND (NOT lot(8).hk) AND lot(9).stat = 0 THEN
LOCATE 9, 11
dy 8
gp(8) = -1
END IF
IF lot(9).own = t AND (NOT lot(9).hk) AND lot(9).stat = 0 THEN
LOCATE 10, 11
dy 9
gp(9) = -1
END IF
IF lot(11).own = t AND (NOT lot(11).hk) AND lot(14).stat = 0 THEN
LOCATE 5, 26
dy 11
gp(11) = -1
END IF
IF lot(12).own = t AND (NOT lot(12).hk) THEN
LOCATE 6, 26
dy 12
gp(12) = -1
END IF
IF lot(13).own = t AND (NOT lot(13).hk) AND lot(14).stat = 0 THEN
LOCATE 7, 26
dy 13
gp(13) = -1
END IF
IF lot(14).own = t AND (NOT lot(14).hk) AND lot(14).stat = 0 THEN
LOCATE 8, 26
dy 14
gp(14) = -1
END IF
IF lot(15).own = t AND (NOT lot(15).hk) THEN
LOCATE 9, 26
dy 15
gp(15) = -1
END IF
IF lot(16).own = t AND (NOT lot(16).hk) AND lot(19).stat = 0 THEN
LOCATE 10, 26
dy 16
gp(16) = -1
END IF
IF lot(18).own = t AND (NOT lot(18).hk) AND lot(19).stat = 0 THEN
LOCATE 11, 26
dy 18
gp(18) = -1
END IF
IF lot(19).own = t AND (NOT lot(19).hk) AND lot(19).stat = 0 THEN
LOCATE 12, 26
dy 19
gp(19) = -1
END IF
IF lot(21).own = t AND (NOT lot(21).hk) AND lot(24).stat = 0 THEN
LOCATE 5, 41
dy 21
gp(21) = -1
END IF
IF lot(23).own = t AND (NOT lot(23).hk) AND lot(24).stat = 0 THEN
LOCATE 6, 41
dy 23
gp(23) = -1
END IF
IF lot(24).own = t AND (NOT lot(24).hk) AND lot(24).stat = 0 THEN
LOCATE 7, 41
dy 24
gp(24) = -1
END IF
IF lot(25).own = t AND (NOT lot(25).hk) THEN
LOCATE 8, 41
dy 25
gp(25) = -1
END IF
IF lot(26).own = t AND (NOT lot(26).hk) AND lot(29).stat = 0 THEN
LOCATE 9, 41
dy 26
gp(26) = -1
END IF
IF lot(27).own = t AND (NOT lot(27).hk) AND lot(29).stat = 0 THEN
LOCATE 10, 41
dy 27
gp(27) = -1
END IF
IF lot(28).own = t AND (NOT lot(28).hk) THEN
LOCATE 11, 41
dy 28
gp(28) = -1
END IF
IF lot(29).own = t AND (NOT lot(29).hk) AND lot(29).stat = 0 THEN
LOCATE 12, 41
dy 29
gp(29) = -1
END IF
IF lot(31).own = t AND (NOT lot(31).hk) AND lot(34).stat = 0 THEN
LOCATE 5, 56
dy 31
gp(31) = -1
END IF
IF lot(32).own = t AND (NOT lot(32).hk) AND lot(34).stat = 0 THEN
LOCATE 6, 56
dy 32
gp(32) = -1
END IF
IF lot(34).own = t AND (NOT lot(34).hk) AND lot(34).stat = 0 THEN
LOCATE 7, 56
dy 34
gp(34) = -1
END IF
IF lot(35).own = t AND (NOT lot(35).hk) THEN
LOCATE 8, 56
dy 35
gp(35) = -1
END IF
IF lot(37).own = t AND (NOT lot(37).hk) AND lot(39).stat = 0 THEN
LOCATE 9, 56
dy 37
gp(37) = -1
END IF
IF lot(39).own = t AND (NOT lot(39).hk) AND lot(39).stat = 0 THEN
LOCATE 10, 56
dy 39
gp(39) = -1
END IF
ce 13, RTRIM$(st(t).ft)
ce 14, "Choose a deed to mortgage or 0 to continue"
IF st(t).c >= 0 THEN ce 17, "you have $" + ltsb(st(t).c) ELSE ce 17, "you need to raise $" + lts(-st(t).c)
DO
IF (NOT gp(pick)) AND (NOT q) THEN b
pick = ner(15, 39)
LOOP UNTIL gp(pick)
IF pick = 0 THEN EXIT SUB
lot(pick).hk = -1
st(t).c = st(t).c + lot(pick).c / 2
END SUB

SUB move (dist, t)
FOR sq = 0 TO dist - 1
IF t = 1 THEN LOCATE lot((st(1).whr + sq) MOD 40).od, lot((st(1).whr + sq) MOD 40).oa ELSE LOCATE lot((st(2).whr + sq) MOD 40).id, lot((st(2).whr + sq) MOD 40).ia
PRINT " "
IF t = 1 THEN LOCATE lot((st(1).whr + sq + 1) MOD 40).od, lot((st(1).whr + sq + 1) MOD 40).oa ELSE LOCATE lot((st(2).whr + sq + 1) MOD 40).id, lot((st(2).whr + sq + 1) MOD 40).ia
PRINT st(t).tk
clk .1
NEXT
IF st(t).whr + dist >= 40 THEN st(t).c = st(t).c + 200
IF st(t).whr + dist > 40 THEN
box
ce 5, RTRIM$(st(t).ft) + ", you collect $200 for passing Go."
clk .9
END IF
st(t).whr = (st(t).whr + dist) MOD 40
END SUB

FUNCTION ner (dn, max)
IF max = 0 THEN mk = 2 ELSE mk = INT(LOG(max) / LOG(10)) + 2
DO
ce dn, SPACE$(10)
IF num > 0 AND (NOT q) THEN b
num = 0
num$ = ""
DO
numk$ = nerk
IF numk$ = CHR$(8) AND LEN(num$) > 0 THEN
num$ = LEFT$(num$, (LEN(num$) - 1))
ELSE
IF numk$ <> CHR$(13) AND numk$ <> CHR$(8) THEN num$ = num$ + numk$
END IF
IF LEN(num$) < mk THEN
ce dn, SPACE$(10)
ce dn, num$
END IF
LOOP UNTIL numk$ = CHR$(13) OR LEN(num$) = mk
num = VAL(num$)
LOOP UNTIL num <= max
ner = num
END FUNCTION

FUNCTION nerb& (dn, max&)
IF max& = 0 THEN mk = 2 ELSE mk = INT(LOG(max&) / LOG(10)) + 2
DO
ce dn, SPACE$(10)
IF num& > 0 AND (NOT q) THEN b
num& = 0
num$ = ""
DO
numk$ = nerk
IF numk$ = CHR$(8) AND LEN(num$) > 0 THEN
num$ = LEFT$(num$, (LEN(num$) - 1))
ELSE
IF numk$ <> CHR$(13) AND numk$ <> CHR$(8) THEN num$ = num$ + numk$
END IF
IF LEN(num$) < mk THEN
ce dn, SPACE$(10)
ce dn, num$
END IF
LOOP UNTIL numk$ = CHR$(13) OR LEN(num$) = mk
num& = VAL(num$)
LOOP UNTIL num& <= max&
nerb& = num&
END FUNCTION

FUNCTION nerk$
DO
DO
LOOP UNTIL INKEY$ = ""
DO
tx$ = INKEY$
LOOP UNTIL tx$ > ""
SELECT CASE tx$
CASE "0" TO "9", CHR$(13), CHR$(8)
valid = -1
CASE ELSE
valid = 0
IF (NOT q) THEN b
END SELECT
LOOP UNTIL valid
nerk = tx$
END FUNCTION

SUB noo (t)
box
COLOR lot(st(t).whr).hue
ce 5, RTRIM$(lot(st(t).whr).ttl)
COLOR 7
ce 6, "cost $" + lts(lot(st(t).whr).c)
ce 7, "mortgage value $" + lts(lot(st(t).whr).c / 2)
SELECT CASE lot(st(t).whr).sty
CASE "b"
ce 8, "rent $" + lts(lot(st(t).whr).r)
ce 9, "rent with one house $" + lts(lot(st(t).whr).r1)
ce 10, "rent with two houses $" + lts(lot(st(t).whr).r2)
ce 11, "rent with three houses $" + lts(lot(st(t).whr).r3)
ce 12, "rent with four houses $" + lts(lot(st(t).whr).r4)
ce 13, "rent with hotel $" + lts(lot(st(t).whr).rhot)
ce 14, "houses cost $" + lts(lot(st(t).whr).bc) + " each"
ce 15, "hotel costs $" + lts(lot(st(t).whr).bc) + " plus 4 houses"
COLOR 15
CASE "u"
COLOR 15
ce 8, "rent with one Utility, four times dice"
ce 9, "rent with two Utilities, ten times dice"
CASE "r"
COLOR 15
ce 8, "rent with one Railroad $25"
ce 9, "rent with two Railroads $50"
ce 10, "rent with three Railroads $100"
ce 11, "rent with four Railroads $200"
END SELECT
ce 16, RTRIM$(st(t).ft) + ", you have $" + ltsb(st(t).c)
IF cr(t) + st(t).c >= lot(st(t).whr).c THEN ce 17, "press B to Buy"
ce 18, "press A to Auction"
DO
LOOP UNTIL INKEY$ = ""
DO
wt$ = LCASE$(INKEY$)
LOOP UNTIL wt$ = "a" OR (wt$ = "b" AND cr(t) + st(t).c >= lot(st(t).whr).c)
box
IF wt$ = "b" THEN
pay t, lot(st(t).whr).c
COLOR lot(st(t).whr).hue
ce 10, RTRIM$(lot(st(t).whr).ttl)
COLOR 15
lot(st(t).whr).own = t
p
ELSE
auc t
END IF
upd
END SUB

SUB opt (t)
DO
box
ce 5, RTRIM$(st(t).ft) + ", you have $" + ltsb(st(t).c)
ce 6, "press P for Property options"
ce 7, "press S to Save and exit"
ce 8, "press Q to Quit game early"
ce 9, "press any other key to continue"
wt$ = ak
SELECT CASE wt$
CASE "s"
save t
CASE "p"
more t
CASE "q"
quit
CASE ELSE
done = -1
END SELECT
LOOP UNTIL done
END SUB

SUB p
ce 19, "press any key."
DO
LOOP UNTIL INKEY$ > ""
ce 19, SPACE$(14)
END SUB

SUB pay (t, cge)
st(t).c = st(t).c - cge
IF st(t).c < 0 THEN broke t
ce 12, RTRIM$(st(t).ft) + " paid $" + lts(cge)
END SUB

SUB pim (gr, l, m, h)
SELECT CASE gr
CASE 1
l = 1
m = 2
h = 3
COLOR 5
ce 6, "MEDIT/BALTI"
CASE 2
l = 6
m = 8
h = 9
COLOR 11
ce 6, "OREIN/VERMO/CONNE"
CASE 3
l = 11
m = 13
h = 14
COLOR 13
ce 6, "STCHA/STATE/VIRGI"
CASE 4
l = 16
m = 18
h = 19
COLOR 12
ce 6, "STJAM/TENNE/NEWYO"
CASE 5
l = 21
m = 23
h = 24
COLOR 4
ce 6, "KENTU/INDIA/ILLIN"
CASE 6
l = 26
m = 27
h = 29
COLOR 14
ce 6, "ATLAN/VENTN/MARVI"
CASE 7
l = 31
m = 32
h = 34
COLOR 10
ce 6, "PACIF/NORTH/PENAV"
CASE 8
l = 37
m = 2
h = 39
COLOR 9
ce 6, "PARKP/BOARD"
END SELECT
COLOR 15
END SUB

SUB popp (t, cge)
pay t, cge
st(3 - t).c = st(3 - t).c + cge
ce 13, " to " + RTRIM$(st(3 - t).ft)
p
END SUB

SUB quit
DO
LOOP UNTIL INKEY$ = ""
DO
quithue = ((quithue + 1) AND 15) OR 8
COLOR quithue
ce 17, "ARE YOU SURE YOU WANT TO QUIT? (Y/N)"
clk .09
yn$ = LCASE$(INKEY$)
LOOP UNTIL yn$ = "y" OR yn$ = "n"
COLOR 15
IF yn$ = "y" THEN
IF st(1).c < 0 THEN gov 2
IF st(2).c < 0 THEN gov 1
worth1 = cw(1)
worth2 = cw(2)
IF worth1 > worth2 THEN gov 1
IF worth2 > worth1 THEN gov 2
gov 0
END IF
END SUB

SUB rlc (t)
IF lot(st(t).whr).own = 0 THEN
noo t
EXIT SUB
END IF
IF lot(st(t).whr).own = t THEN
COLOR lot(st(t).whr).hue
ce 12, RTRIM$(lot(st(t).whr).ttl)
COLOR 15
ce 13, "is yours."
p
EXIT SUB
END IF
IF lot(st(t).whr).hk THEN
COLOR lot(st(t).whr).hue
ce 12, RTRIM$(lot(st(t).whr).ttl)
COLOR 15
ce 13, "is mortgaged."
p
EXIT SUB
END IF
SELECT CASE lot(st(t).whr).stat
CASE 1
popp t, 50
CASE 2
popp t, 100
CASE 3
popp t, 200
CASE 4
popp t, 400
END SELECT
END SUB

SUB rules
x = -1
box
ce 5, "I will start a new game."
ce 7, "Do you want the Free Parking jackpot? (Y/N)"
DO
LOOP UNTIL INKEY$ = ""
DO
yn$ = LCASE$(INKEY$)
LOOP UNTIL yn$ = "y" OR yn$ = "n"
ce 8, UCASE$(yn$)
IF yn$ = "y" THEN
j = -1
fr& = 500
END IF
ce 9, "Do you want the land on Go bonus? (Y/N)"
DO
LOOP UNTIL INKEY$ = ""
DO
yn$ = LCASE$(INKEY$)
LOOP UNTIL yn$ = "y" OR yn$ = "n"
ce 10, UCASE$(yn$)
IF yn$ = "y" THEN bn = -1
ce 11, "Do you want unlimited buildings in the bank? (Y/N)"
DO
LOOP UNTIL INKEY$ = ""
DO
yn$ = LCASE$(INKEY$)
LOOP UNTIL yn$ = "y" OR yn$ = "n"
ce 12, UCASE$(yn$)
IF yn$ = "n" THEN x = 0
ce 13, "Do you want to suspend mortgage interest? (Y/N)"
DO
LOOP UNTIL INKEY$ = ""
DO
yn$ = LCASE$(INKEY$)
LOOP UNTIL yn$ = "y" OR yn$ = "n"
ce 14, UCASE$(yn$)
IF yn$ = "y" THEN uf! = .5 ELSE uf! = .55
ce 15, "Should builings sell back at full price? (Y/N)"
DO
LOOP UNTIL INKEY$ = ""
DO
yn$ = LCASE$(INKEY$)
LOOP UNTIL yn$ = "y" OR yn$ = "n"
ce 16, UCASE$(yn$)
IF yn$ = "y" THEN sf! = 1 ELSE sf! = .5
ce 17, "Do you want quiet mode? (Y/N)"
DO
LOOP UNTIL INKEY$ = ""
DO
yn$ = LCASE$(INKEY$)
LOOP UNTIL yn$ = "y" OR yn$ = "n"
ce 18, UCASE$(yn$)
IF yn$ = "y" THEN q = -1
p
END SUB

SUB save (t)
ce 10, "to be continued."
OPEN "monopoly.dat" FOR OUTPUT AS #1
PRINT #1, sf!
PRINT #1, uf!
PRINT #1, t
PRINT #1, fr&
PRINT #1, bhu
PRINT #1, bht
PRINT #1, j
PRINT #1, bn
PRINT #1, x
PRINT #1, q
FOR sq = 0 TO 39
PRINT #1, lot(sq).own
PRINT #1, lot(sq).stat
PRINT #1, lot(sq).mop
PRINT #1, lot(sq).hk
NEXT
FOR sq = 1 TO 2
PRINT #1, st(sq).ft
PRINT #1, st(sq).tk
PRINT #1, st(sq).c
PRINT #1, st(sq).whr
PRINT #1, st(sq).jc
PRINT #1, st(sq).dc
PRINT #1, st(sq).chag
PRINT #1, st(sq).cheg
NEXT
FOR sq = 1 TO 16
PRINT #1, cha(sq)
PRINT #1, che(sq)
NEXT
CLOSE
crd
END SUB

SUB scha
box
ce 5, "Shuffling Chance cards."
ce 6, "Please wait."
clk 2
IF cha(8) = 2 THEN goojfflag = -1
FOR flip = 1 TO 16
cha(flip) = 0
NEXT
IF goojfflag THEN cha(8) = 2
END SUB

SUB sche
box
ce 5, "Shuffling Community Chest cards."
ce 6, "Please wait."
clk 2
IF che(6) = 2 THEN goojfflag = -1
FOR flip = 1 TO 16
che(flip) = 0
NEXT
IF goojfflag THEN che(6) = 2
END SUB

SUB short (t, l, m, h)
IF lot(h).stat = 5 THEN
lot(h).stat = 4
bht = bht + 1
st(t).c = st(t).c + lot(l).bc * sf!
END IF
IF lot(m).stat = 5 THEN
lot(m).stat = 4
bht = bht + 1
st(t).c = st(t).c + lot(l).bc * sf!
END IF
IF lot(l).stat = 5 THEN
lot(l).stat = 4
bht = bht + 1
st(t).c = st(t).c + lot(l).bc * sf!
END IF
quan = chou(1) + chou(2) - 32
tot = lot(l).stat + lot(m).stat + lot(h).stat - quan
SELECT CASE m
CASE 2
lot(h).stat = INT(tot / 2)
lot(l).stat = INT(tot / 2)
IF lot(h).stat + lot(l).stat < tot THEN lot(h).stat = lot(h).stat + 1
CASE ELSE
lot(h).stat = INT(tot / 3)
lot(m).stat = INT(tot / 3)
lot(l).stat = INT(tot / 3)
IF lot(h).stat + lot(l).stat + lot(m).stat < tot THEN lot(h).stat = lot(h).stat + 1
IF lot(h).stat + lot(l).stat + lot(m).stat < tot THEN lot(m).stat = lot(m).stat + 1
END SELECT
st(t).c = st(t).c + lot(l).bc * quan * sf!
bhu = 0
box
ce 5, RTRIM$(st(t).ft)
ce 7, "a housing shortage sale taken place."
p
END SUB

SUB shot (t)
DIM gm(9)
gm(0) = -1
box
IF lot(3).own = t AND lot(3).stat = 5 THEN
gm(1) = -1
mini 1
END IF
IF lot(9).own = t AND lot(9).stat = 5 THEN
gm(2) = -1
mini 2
END IF
IF lot(14).own = t AND lot(14).stat = 5 THEN
gm(3) = -1
mini 3
END IF
IF lot(19).own = t AND lot(19).stat = 5 THEN
gm(4) = -1
mini 4
END IF
IF lot(24).own = t AND lot(24).stat = 5 THEN
gm(5) = -1
mini 5
END IF
IF lot(29).own = t AND lot(29).stat = 5 THEN
gm(6) = -1
mini 6
END IF
IF lot(34).own = t AND lot(34).stat = 5 THEN
gm(7) = -1
mini 7
END IF
IF lot(39).own = t AND lot(39).stat = 5 THEN
gm(8) = -1
mini 8
END IF
ce 9, RTRIM$(st(t).ft)
ce 10, "Choose a monopoly to sell hotels from"
ce 11, "or 0 to continue"
DO
IF ws > 0 AND (NOT q) THEN b
DO
LOOP UNTIL INKEY$ = ""
DO
ws$ = INKEY$
IF ws$ = CHR$(13) THEN ws$ = "0"
LOOP UNTIL ws$ > ""
IF ws$ >= "0" AND ws$ <= "8" THEN ws = VAL(ws$) ELSE ws = 9
LOOP UNTIL gm(ws)
IF ws = 0 THEN EXIT SUB
box
ce 5, RTRIM$(st(t).ft)
pim ws, l, m, h
SELECT CASE m
CASE 2
IF lot(l).stat = 5 THEN max = 2 ELSE max = 1
CASE ELSE
max = 1
IF lot(m).stat = 5 THEN max = 2
IF lot(l).stat = 5 THEN max = 3
END SELECT
ce 7, "you can sell up to " + lts(max) + " hotel(s)."
ce 8, "or 0 to continue"
IF st(t).c >= 0 THEN ce 11, "you have $" + ltsb(st(t).c) ELSE ce 11, "you need to raise $" + lts(-st(t).c)
ce 12, "hotels sell for $" + lts(lot(l).bc * sf!) + " (minus four houses) each."
quan = ner(9, max)
IF quan = 0 THEN EXIT SUB
tot = lot(l).stat + lot(m).stat + lot(h).stat - quan
SELECT CASE m
CASE 2
lot(h).stat = INT(tot / 2)
lot(l).stat = INT(tot / 2)
IF lot(h).stat + lot(l).stat < tot THEN lot(h).stat = lot(h).stat + 1
CASE ELSE
lot(h).stat = INT(tot / 3)
lot(m).stat = INT(tot / 3)
lot(l).stat = INT(tot / 3)
IF lot(h).stat + lot(l).stat + lot(m).stat < tot THEN lot(h).stat = lot(h).stat + 1
IF lot(h).stat + lot(l).stat + lot(m).stat < tot THEN lot(m).stat = lot(m).stat + 1
END SELECT
st(t).c = st(t).c + lot(l).bc * quan * sf!
IF (NOT x) THEN
bht = bht + quan
bhu = bhu - 4 * quan
IF bhu < 0 THEN short t, l, m, h
END IF
END SUB

SUB shou (t)
DIM gm(9)
gm(0) = -1
box
IF lot(3).own = t AND lot(3).stat > 0 AND lot(3).stat < 5 THEN
gm(1) = -1
mini 1
END IF
IF lot(9).own = t AND lot(9).stat > 0 AND lot(9).stat < 5 THEN
gm(2) = -1
mini 2
END IF
IF lot(14).own = t AND lot(14).stat > 0 AND lot(14).stat < 5 THEN
gm(3) = -1
mini 3
END IF
IF lot(19).own = t AND lot(19).stat > 0 AND lot(19).stat < 5 THEN
gm(4) = -1
mini 4
END IF
IF lot(24).own = t AND lot(24).stat > 0 AND lot(24).stat < 5 THEN
gm(5) = -1
mini 5
END IF
IF lot(29).own = t AND lot(29).stat > 0 AND lot(29).stat < 5 THEN
gm(6) = -1
mini 6
END IF
IF lot(34).own = t AND lot(34).stat > 0 AND lot(34).stat < 5 THEN
gm(7) = -1
mini 7
END IF
IF lot(39).own = t AND lot(39).stat > 0 AND lot(39).stat < 5 THEN
gm(8) = -1
mini 8
END IF
ce 9, RTRIM$(st(t).ft)
ce 10, "Choose a monopoly to sell houses from"
ce 11, "or 0 to continue"
DO
IF ws > 0 AND (NOT q) THEN b
DO
LOOP UNTIL INKEY$ = ""
DO
ws$ = INKEY$
IF ws$ = CHR$(13) THEN ws$ = "0"
LOOP UNTIL ws$ > ""
IF ws$ >= "0" AND ws$ <= "8" THEN ws = VAL(ws$) ELSE ws = 9
LOOP UNTIL gm(ws)
IF ws = 0 THEN EXIT SUB
box
ce 5, RTRIM$(st(t).ft)
pim ws, l, m, h
SELECT CASE m
CASE 2
max = lot(l).stat + lot(h).stat
CASE ELSE
max = lot(l).stat + lot(m).stat + lot(h).stat
END SELECT
ce 7, "you can sell up to " + lts(max) + " house(s)."
ce 8, "or 0 to continue"
IF st(t).c >= 0 THEN ce 11, "you have $" + ltsb(st(t).c) ELSE ce 11, "you need to raise $" + lts(-st(t).c)
ce 12, "houses sell for $" + lts(lot(l).bc * sf!) + " each."
quan = ner(9, max)
IF quan = 0 THEN EXIT SUB
tot = lot(l).stat + lot(m).stat + lot(h).stat - quan
SELECT CASE m
CASE 2
lot(h).stat = INT(tot / 2)
lot(l).stat = INT(tot / 2)
IF lot(h).stat + lot(l).stat < tot THEN lot(h).stat = lot(h).stat + 1
CASE ELSE
lot(h).stat = INT(tot / 3)
lot(m).stat = INT(tot / 3)
lot(l).stat = INT(tot / 3)
IF lot(h).stat + lot(l).stat + lot(m).stat < tot THEN lot(h).stat = lot(h).stat + 1
IF lot(h).stat + lot(l).stat + lot(m).stat < tot THEN lot(m).stat = lot(m).stat + 1
END SELECT
st(t).c = st(t).c + lot(l).bc * quan * sf!
IF (NOT x) THEN bhu = bhu + quan
END SUB

SUB sml (wt)
PRINT wt;
lil wt
END SUB

SUB swbd
box
COLOR 5
LOCATE 22, 66
PRINT "MEDIT"
LOCATE 22, 52
PRINT "BALTI"
COLOR 11
LOCATE 22, 31
PRINT "ORIEN"
LOCATE 22, 17
PRINT "VERMO"
LOCATE 22, 10
PRINT "CONNE"
COLOR 13
LOCATE 20, 3
PRINT "STCHA"
LOCATE 16, 3
PRINT "STATE"
LOCATE 14, 3
PRINT "VIRGI"
COLOR 12
LOCATE 10, 3
PRINT "STJAM"
LOCATE 6, 3
PRINT "TENNE"
LOCATE 4, 3
PRINT "NEWYO"
COLOR 4
LOCATE 2, 10
PRINT "KENTU"
LOCATE 2, 24
PRINT "INDIA"
LOCATE 2, 31
PRINT "ILLIN"
COLOR 14
LOCATE 2, 45
PRINT "ATLAN"
LOCATE 2, 52
PRINT "VENTN"
LOCATE 2, 66
PRINT "MARVI"
COLOR 10
LOCATE 4, 73
PRINT "PACIF"
LOCATE 6, 73
PRINT "NORTH"
LOCATE 10, 73
PRINT "PENAV"
COLOR 9
LOCATE 16, 73
PRINT "PARKP"
LOCATE 20, 73
PRINT "BOARD"
COLOR 7
LOCATE 22, 38
PRINT "READR"
LOCATE 18, 3
PRINT "ELECT"
LOCATE 12, 3
PRINT "PENRR"
LOCATE 2, 38
PRINT "B&ORR"
LOCATE 2, 59
PRINT "WATER"
LOCATE 12, 73
PRINT "SHORT"
COLOR 15
LOCATE 22, 73
PRINT "<-GO<"
LOCATE 22, 59
PRINT "COMMU"
LOCATE 22, 45
PRINT "INCTX"
LOCATE 22, 24
PRINT "CHANC"
LOCATE 22, 3
PRINT "JUSTV"
LOCATE 8, 3
PRINT "COMMU"
LOCATE 2, 3
PRINT "FREEP"
LOCATE 2, 17
PRINT "CHANC"
LOCATE 2, 73
PRINT "GOTOJ"
LOCATE 8, 73
PRINT "COMMU"
LOCATE 14, 73
PRINT "CHANC"
LOCATE 18, 73
PRINT "LUXTX"
END SUB

SUB swbs
FOR sq = 1 TO 39
IF lot(sq).sty = "b" THEN
LOCATE lot(sq).bdn, lot(sq).bac
IF (NOT lot(sq).mop) THEN
PRINT " "
ELSE
SELECT CASE lot(sq).stat
CASE 0 TO 4
COLOR 0, 10
PRINT USING "#"; lot(sq).stat
CASE 5
COLOR 0, 4
PRINT "H"
END SELECT
COLOR 15, 0
END IF
END IF
NEXT
END SUB

SUB tiny (wt)
PRINT wt;
COLOR lot(wt).hue
PRINT lot(wt).ab
COLOR 15
END SUB

SUB tj (t)
st(t).jc = st(t).jc + 1
box
ce 5, RTRIM$(st(t).ft) + ", in Jail, turn " + lts(st(t).jc) + " with $" + ltsb(st(t).c)
IF cr(t) + st(t).c >= 50 THEN ce 6, "press M to Make bail (pay $50)"
IF st(t).chag OR st(t).cheg THEN ce 7, "press C to use 'get out of jail free' Card"
ce 8, "press R to Roll dice"
DO
LOOP UNTIL INKEY$ = ""
DO
how$ = LCASE$(INKEY$)
LOOP UNTIL how$ = "r" OR (how$ = "m" AND cr(t) + st(t).c >= 50) OR (how$ = "c" AND (st(t).chag OR st(t).cheg))
box
SELECT CASE how$
CASE "r"
ce 5, RTRIM$(st(t).ft) + ", roll " + lts(st(t).jc) + " done, with $" + ltsb(st(t).c)
rlout = di(d1, d2)
ce 10, lts(d1) + " + " + lts(d2) + " = " + lts(rlout)
p
IF d1 = d2 THEN
st(t).jc = 0
st(t).whr = 10
box
IF t = 1 THEN LOCATE lot(10).od, lot(10).oa ELSE LOCATE lot(10).id, lot(10).ia
PRINT st(t).tk
move rlout, t
act rlout, t
END IF
IF st(t).jc = 3 THEN
IF st(t).chag OR st(t).cheg THEN
ce 6, "press M to Make bail (pay $50)"
ce 7, "press C to use 'get out of jail free' Card"
END IF
DO
LOOP UNTIL INKEY$ = ""
DO
payout$ = LCASE$(INKEY$)
IF (NOT st(t).chag) AND (NOT st(t).cheg) THEN payout$ = "m"
LOOP UNTIL payout$ = "m" OR payout$ = "c"
SELECT CASE payout$
CASE "m"
pay t, 50
IF j THEN fr& = fr& + 50
CASE "c"
IF st(t).chag AND st(t).cheg THEN
ce 10, "Pick a card."
ce 11, "Press A for chAnce"
ce 12, "press O for cOmmunity che"
END IF
DO
LOOP UNTIL INKEY$ = ""
DO
wtc$ = LCASE$(INKEY$)
IF (NOT st(t).chag) THEN wtc$ = "o"
IF (NOT st(t).cheg) THEN wtc$ = "a"
LOOP UNTIL wtc$ = "a" OR wtc$ = "o"
IF wtc$ = "a" THEN
ce 13, "Chance card used."
st(t).chag = 0
cha(8) = 1
ELSE
ce 13, "Community Chest card used."
st(t).cheg = 0
che(6) = 1
END IF
END SELECT
p
st(t).jc = 0
st(t).whr = 10
box
IF t = 1 THEN LOCATE lot(10).od, lot(10).oa ELSE LOCATE lot(10).id, lot(10).ia
PRINT st(t).tk
move rlout, t
act rlout, t
END IF
opt t
CASE "m"
pay t, 50
IF j THEN fr& = fr& + 50
st(t).jc = 0
p
box
IF t = 1 THEN LOCATE lot(10).od, lot(10).oa ELSE LOCATE lot(10).id, lot(10).ia
PRINT st(t).tk
st(t).whr = 10
tn t
CASE "c"
IF st(t).chag AND st(t).cheg THEN
ce 10, "Pick a card."
ce 11, "Press A for chAnce"
ce 12, "press O for cOmmunity che"
END IF
DO
LOOP UNTIL INKEY$ = ""
DO
wtc$ = LCASE$(INKEY$)
IF (NOT st(t).chag) THEN wtc$ = "o"
IF (NOT st(t).cheg) THEN wtc$ = "a"
LOOP UNTIL wtc$ = "a" OR wtc$ = "o"
IF wtc$ = "a" THEN
ce 13, "Chance card used."
st(t).chag = 0
cha(8) = 1
ELSE
ce 13, "Community Chest card used."
st(t).cheg = 0
che(6) = 1
END IF
p
box
IF t = 1 THEN LOCATE lot(10).od, lot(10).oa ELSE LOCATE lot(10).id, lot(10).ia
PRINT st(t).tk
st(t).jc = 0
st(t).whr = 10
tn t
END SELECT
END SUB

SUB tn (t)
DO
box
ce 5, RTRIM$(st(t).ft) + " press any key to roll the dice."
p
box
ce 5, RTRIM$(st(t).ft)
rl = di(d1, d2)
ce 7, lts(d1) + " + " + lts(d2) + " = " + lts(rl)
IF d1 = d2 THEN st(t).dc = st(t).dc + 1 ELSE st(t).dc = 0
SELECT CASE st(t).dc
CASE 0
clk 1.5
CASE 1
ce 8, "first doubles"
clk 1.5
CASE 2
ce 8, "second doubles"
clk 1.5
CASE 3
ce 8, "Third doubles"
ar t
END SELECT
IF st(t).whr > -10 THEN
move rl, t
act rl, t
END IF
opt t
LOOP UNTIL st(t).dc = 0
END SUB

SUB trade
DIM wit(41), cg(1 TO 2)
FOR gvr = 1 TO 2
DO
REDIM mt(41)
mt(0) = -1
box
IF lot(1).own = gvr AND lot(3).stat = 0 THEN
LOCATE 5, 11
sml 1
mt(1) = -1
END IF
IF lot(3).own = gvr AND lot(3).stat = 0 THEN
LOCATE 6, 11
sml 3
mt(3) = -1
END IF
IF lot(5).own = gvr THEN
LOCATE 7, 11
sml 5
mt(5) = -1
END IF
IF lot(6).own = gvr AND lot(9).stat = 0 THEN
LOCATE 8, 11
sml 6
mt(6) = -1
END IF
IF lot(8).own = gvr AND lot(9).stat = 0 THEN
LOCATE 9, 11
sml 8
mt(8) = -1
END IF
IF lot(9).own = gvr AND lot(9).stat = 0 THEN
LOCATE 10, 11
sml 9
mt(9) = -1
END IF
IF lot(11).own = gvr AND lot(14).stat = 0 THEN
LOCATE 5, 25
sml 11
mt(11) = -1
END IF
IF lot(12).own = gvr THEN
LOCATE 6, 25
sml 12
mt(12) = -1
END IF
IF lot(13).own = gvr AND lot(14).stat = 0 THEN
LOCATE 7, 25
sml 13
mt(13) = -1
END IF
IF lot(14).own = gvr AND lot(14).stat = 0 THEN
LOCATE 8, 25
sml 14
mt(14) = -1
END IF
IF lot(15).own = gvr THEN
LOCATE 9, 25
sml 15
mt(15) = -1
END IF
IF lot(16).own = gvr AND lot(19).stat = 0 THEN
LOCATE 10, 25
sml 16
mt(16) = -1
END IF
IF lot(18).own = gvr AND lot(19).stat = 0 THEN
LOCATE 11, 25
sml 18
mt(18) = -1
END IF
IF lot(19).own = gvr AND lot(19).stat = 0 THEN
LOCATE 12, 25
sml 19
mt(19) = -1
END IF
IF lot(21).own = gvr AND lot(24).stat = 0 THEN
LOCATE 5, 40
sml 21
mt(21) = -1
END IF
IF lot(23).own = gvr AND lot(24).stat = 0 THEN
LOCATE 6, 40
sml 23
mt(23) = -1
END IF
IF lot(24).own = gvr AND lot(24).stat = 0 THEN
LOCATE 7, 40
sml 24
mt(24) = -1
END IF
IF lot(25).own = gvr THEN
LOCATE 8, 40
sml 25
mt(25) = -1
END IF
IF lot(26).own = gvr AND lot(29).stat = 0 THEN
LOCATE 9, 40
sml 26
mt(26) = -1
END IF
IF lot(27).own = gvr AND lot(29).stat = 0 THEN
LOCATE 10, 40
sml 27
mt(27) = -1
END IF
IF lot(28).own = gvr THEN
LOCATE 11, 40
sml 28
mt(28) = -1
END IF
IF lot(29).own = gvr AND lot(29).stat = 0 THEN
LOCATE 12, 40
sml 29
mt(29) = -1
END IF
IF lot(31).own = gvr AND lot(34).stat = 0 THEN
LOCATE 5, 55
sml 31
mt(31) = -1
END IF
IF lot(32).own = gvr AND lot(34).stat = 0 THEN
LOCATE 6, 55
sml 32
mt(32) = -1
END IF
IF lot(34).own = gvr AND lot(34).stat = 0 THEN
LOCATE 7, 55
sml 34
mt(34) = -1
END IF
IF lot(35).own = gvr THEN
LOCATE 8, 55
sml 35
mt(35) = -1
END IF
IF lot(37).own = gvr AND lot(39).stat = 0 THEN
LOCATE 9, 55
sml 37
mt(37) = -1
END IF
IF lot(39).own = gvr AND lot(39).stat = 0 THEN
LOCATE 10, 55
sml 39
mt(39) = -1
END IF
IF st(gvr).chag THEN
LOCATE 12, 11
PRINT 40;
COLOR 12
PRINT "GOOJF"
COLOR 15
mt(40) = -1
END IF
IF st(gvr).cheg THEN
LOCATE 12, 55
PRINT 41;
COLOR 14
PRINT "GOOJF"
COLOR 15
mt(41) = -1
END IF
ce 13, RTRIM$(st(gvr).ft) + ", you have $" + ltsb(st(gvr).c)
ce 14, "Choose a deed to trade or 0 to continue"
DO
pick = 0
IF (NOT mt(pick)) AND (NOT q) THEN b
pick = ner(15, 41)
LOOP UNTIL mt(pick)
SELECT CASE pick
CASE 1 TO 39
lot(pick).own = 0
CASE 40
st(gvr).chag = 0
CASE 41
st(gvr).cheg = 0
END SELECT
wit(pick) = gvr
LOOP UNTIL pick = 0
ce 16, "cash to give"
cg(gvr) = nerb(17, st(gvr).c)
NEXT
IF cg(1) > cg(2) THEN
box
popp 1, cg(1) - cg(2)
END IF
IF cg(2) > cg(1) THEN
box
popp 2, cg(2) - cg(1)
END IF
IF wit(40) > 0 THEN st(3 - wit(40)).chag = -1
IF wit(41) > 0 THEN st(3 - wit(41)).cheg = -1
FOR flip = 1 TO 39
IF wit(flip) > 0 AND (NOT lot(flip).hk) THEN
lot(flip).own = 3 - wit(flip)
wit(flip) = 0
END IF
NEXT
FOR flip = 1 TO 39
IF wit(flip) > 0 THEN
lot(flip).own = 3 - wit(flip)
box
ce 5, RTRIM$(st(3 - wit(flip)).ft) + ", you have $" + ltsb(st(3 - wit(flip)).c)
COLOR lot(flip).hue
ce 6, RTRIM$(lot(flip).ttl)
COLOR 15
ce 7, "is mortgaged."
IF st(3 - wit(flip)).c >= INT(.5 + lot(flip).c * uf!) THEN
ce 8, "Do you want to unmortgage it now? (Y/N)"
y = INT(.5 + lot(flip).c * uf!)
n = INT(.5 + lot(flip).c * (uf! - .5))
ce 9, "Y will cost $" + lts(y)
IF n > 0 THEN ce 10, "N will cost $" + lts(n)
DO
LOOP UNTIL INKEY$ = ""
DO
yn$ = LCASE$(INKEY$)
LOOP UNTIL yn$ = "y" OR yn$ = "n"
ELSE
yn$ = "n"
END IF
IF yn$ = "y" THEN
pay 3 - wit(flip), y
lot(flip).hk = 0
ELSE
IF n > 0 THEN
pay 3 - wit(flip), n
ce 14, "mortgaged property fee."
END IF
p
END IF
END IF
NEXT
END SUB

FUNCTION txk$
DO
DO
LOOP UNTIL INKEY$ = ""
DO
tx$ = INKEY$
LOOP UNTIL tx$ > ""
SELECT CASE LCASE$(tx$)
CASE "a" TO "z", CHR$(13), CHR$(8)
valid = -1
CASE ELSE
valid = 0
IF (NOT q) THEN b
END SELECT
LOOP UNTIL valid
txk = tx$
END FUNCTION

SUB unm (t)
DIM gp(39)
gp(0) = -1
box
IF lot(1).own = t AND lot(1).hk AND st(t).c >= INT(.5 + lot(1).c * uf!) THEN
LOCATE 5, 11
dy 1
gp(1) = -1
END IF
IF lot(3).own = t AND lot(3).hk AND st(t).c >= INT(.5 + lot(3).c * uf!) THEN
LOCATE 6, 11
dy 3
gp(3) = -1
END IF
IF lot(5).own = t AND lot(5).hk AND st(t).c >= INT(.5 + lot(5).c * uf!) THEN
LOCATE 7, 11
dy 5
gp(5) = -1
END IF
IF lot(6).own = t AND lot(6).hk AND st(t).c >= INT(.5 + lot(6).c * uf!) THEN
LOCATE 8, 11
dy 6
gp(6) = -1
END IF
IF lot(8).own = t AND lot(8).hk AND st(t).c >= INT(.5 + lot(8).c * uf!) THEN
LOCATE 9, 11
dy 8
gp(8) = -1
END IF
IF lot(9).own = t AND lot(9).hk AND st(t).c >= INT(.5 + lot(9).c * uf!) THEN
LOCATE 10, 11
dy 9
gp(9) = -1
END IF
IF lot(11).own = t AND lot(11).hk AND st(t).c >= INT(.5 + lot(11).c * uf!) THEN
LOCATE 5, 26
dy 11
gp(11) = -1
END IF
IF lot(12).own = t AND lot(12).hk AND st(t).c >= INT(.5 + lot(12).c * uf!) THEN
LOCATE 6, 26
dy 12
gp(12) = -1
END IF
IF lot(13).own = t AND lot(13).hk AND st(t).c >= INT(.5 + lot(13).c * uf!) THEN
LOCATE 7, 26
dy 13
gp(13) = -1
END IF
IF lot(14).own = t AND lot(14).hk AND st(t).c >= INT(.5 + lot(14).c * uf!) THEN
LOCATE 8, 26
dy 14
gp(14) = -1
END IF
IF lot(15).own = t AND lot(15).hk AND st(t).c >= INT(.5 + lot(15).c * uf!) THEN
LOCATE 9, 26
dy 15
gp(15) = -1
END IF
IF lot(16).own = t AND lot(16).hk AND st(t).c >= INT(.5 + lot(16).c * uf!) THEN
LOCATE 10, 26
dy 16
gp(16) = -1
END IF
IF lot(18).own = t AND lot(18).hk AND st(t).c >= INT(.5 + lot(18).c * uf!) THEN
LOCATE 11, 26
dy 18
gp(18) = -1
END IF
IF lot(19).own = t AND lot(19).hk AND st(t).c >= INT(.5 + lot(19).c * uf!) THEN
LOCATE 12, 26
dy 19
gp(19) = -1
END IF
IF lot(21).own = t AND lot(21).hk AND st(t).c >= INT(.5 + lot(21).c * uf!) THEN
LOCATE 5, 41
dy 21
gp(21) = -1
END IF
IF lot(23).own = t AND lot(23).hk AND st(t).c >= INT(.5 + lot(23).c * uf!) THEN
LOCATE 6, 41
dy 23
gp(23) = -1
END IF
IF lot(24).own = t AND lot(24).hk AND st(t).c >= INT(.5 + lot(24).c * uf!) THEN
LOCATE 7, 41
dy 24
gp(24) = -1
END IF
IF lot(25).own = t AND lot(25).hk AND st(t).c >= INT(.5 + lot(25).c * uf!) THEN
LOCATE 8, 41
dy 25
gp(25) = -1
END IF
IF lot(26).own = t AND lot(26).hk AND st(t).c >= INT(.5 + lot(26).c * uf!) THEN
LOCATE 9, 41
dy 26
gp(26) = -1
END IF
IF lot(27).own = t AND lot(27).hk AND st(t).c >= INT(.5 + lot(27).c * uf!) THEN
LOCATE 10, 41
dy 27
gp(27) = -1
END IF
IF lot(28).own = t AND lot(28).hk AND st(t).c >= INT(.5 + lot(28).c * uf!) THEN
LOCATE 11, 41
dy 28
gp(28) = -1
END IF
IF lot(29).own = t AND lot(29).hk AND st(t).c >= INT(.5 + lot(29).c * uf!) THEN
LOCATE 12, 41
dy 29
gp(29) = -1
END IF
IF lot(31).own = t AND lot(31).hk AND st(t).c >= INT(.5 + lot(31).c * uf!) THEN
LOCATE 5, 56
dy 31
gp(31) = -1
END IF
IF lot(32).own = t AND lot(32).hk AND st(t).c >= INT(.5 + lot(32).c * uf!) THEN
LOCATE 6, 56
dy 32
gp(32) = -1
END IF
IF lot(34).own = t AND lot(34).hk AND st(t).c >= INT(.5 + lot(34).c * uf!) THEN
LOCATE 7, 56
dy 34
gp(34) = -1
END IF
IF lot(35).own = t AND lot(35).hk AND st(t).c >= INT(.5 + lot(35).c * uf!) THEN
LOCATE 8, 56
dy 35
gp(35) = -1
END IF
IF lot(37).own = t AND lot(37).hk AND st(t).c >= INT(.5 + lot(37).c * uf!) THEN
LOCATE 9, 56
dy 37
gp(37) = -1
END IF
IF lot(39).own = t AND lot(39).hk AND st(t).c >= INT(.5 + lot(39).c * uf!) THEN
LOCATE 10, 56
dy 39
gp(39) = -1
END IF
ce 13, RTRIM$(st(t).ft)
ce 14, "Choose a deed to unmortgage or 0 to continue"
ce 17, "you have $" + ltsb(st(t).c)
DO
IF (NOT gp(pick)) AND (NOT q) THEN b
pick = ner(15, 39)
LOOP UNTIL gp(pick)
IF pick = 0 THEN EXIT SUB
lot(pick).hk = 0
box
pay t, INT(.5 + lot(pick).c * uf!)
p
END SUB

SUB upd
chk 1, 1, 3
chk 6, 8, 9
chk 11, 13, 14
chk 16, 18, 19
chk 21, 23, 24
chk 26, 27, 29
chk 31, 32, 34
chk 37, 37, 39
IF lot(12).own = lot(28).own AND lot(12).own > 0 THEN
lot(12).stat = 2
lot(28).stat = 2
ELSE
lot(12).stat = SGN(lot(12).own)
lot(28).stat = SGN(lot(28).own)
END IF
FOR rtt = 5 TO 35 STEP 10
rro = rro * 10 + lot(rtt).own
lot(rtt).stat = 0
NEXT
SELECT CASE rro
CASE 1111, 2222
lot(5).stat = 4
lot(15).stat = 4
lot(25).stat = 4
lot(35).stat = 4
CASE 111, 222, 1222, 2111
lot(15).stat = 3
lot(25).stat = 3
lot(35).stat = 3
CASE 1011, 1211, 2022, 2122
lot(5).stat = 3
lot(25).stat = 3
lot(35).stat = 3
CASE 1101, 1121, 2202, 2212
lot(5).stat = 3
lot(15).stat = 3
lot(35).stat = 3
CASE 1110, 1112, 2220, 2221
lot(5).stat = 3
lot(15).stat = 3
lot(25).stat = 3
CASE ELSE
IF lot(5).own = lot(15).own AND lot(5).own > 0 THEN
lot(5).stat = 2
lot(15).stat = 2
END IF
IF lot(5).own = lot(25).own AND lot(5).own > 0 THEN
lot(5).stat = 2
lot(25).stat = 2
END IF
IF lot(5).own = lot(35).own AND lot(5).own > 0 THEN
lot(5).stat = 2
lot(35).stat = 2
END IF
IF lot(15).own = lot(25).own AND lot(15).own > 0 THEN
lot(15).stat = 2
lot(25).stat = 2
END IF
IF lot(15).own = lot(35).own AND lot(15).own > 0 THEN
lot(15).stat = 2
lot(35).stat = 2
END IF
IF lot(25).own = lot(35).own AND lot(25).own > 0 THEN
lot(25).stat = 2
lot(35).stat = 2
END IF
END SELECT
FOR rtt = 5 TO 35 STEP 10
IF lot(rtt).stat = 0 THEN lot(rtt).stat = SGN(lot(rtt).own)
NEXT
swbs
END SUB

SUB utc (t)
IF lot(st(t).whr).own = 0 THEN
noo t
EXIT SUB
END IF
IF lot(st(t).whr).own = t THEN
COLOR lot(st(t).whr).hue
ce 12, RTRIM$(lot(st(t).whr).ttl)
COLOR 15
ce 13, "is yours."
p
EXIT SUB
END IF
IF lot(st(t).whr).hk THEN
COLOR lot(st(t).whr).hue
ce 12, RTRIM$(lot(st(t).whr).ttl)
COLOR 15
ce 13, "is mortgaged."
p
EXIT SUB
END IF
crl = di(d1, d2)
ce 11, lts(d1) + " + " + lts(d2) + " = " + lts(crl) + ", $" + lts(10 * crl) + " due."
p
popp t, 10 * crl
END SUB

SUB vwd
DO
box
LOCATE 5, 11
tiny 1
LOCATE 6, 11
tiny 3
LOCATE 7, 11
tiny 5
LOCATE 8, 11
tiny 6
LOCATE 9, 11
tiny 8
LOCATE 10, 11
tiny 9
LOCATE 5, 25
tiny 11
LOCATE 6, 25
tiny 12
LOCATE 7, 25
tiny 13
LOCATE 8, 25
tiny 14
LOCATE 9, 25
tiny 15
LOCATE 10, 25
tiny 16
LOCATE 11, 25
tiny 18
LOCATE 12, 25
tiny 19
LOCATE 5, 40
tiny 21
LOCATE 6, 40
tiny 23
LOCATE 7, 40
tiny 24
LOCATE 8, 40
tiny 25
LOCATE 9, 40
tiny 26
LOCATE 10, 40
tiny 27
LOCATE 11, 40
tiny 28
LOCATE 12, 40
tiny 29
LOCATE 5, 55
tiny 31
LOCATE 6, 55
tiny 32
LOCATE 7, 55
tiny 34
LOCATE 8, 55
tiny 35
LOCATE 9, 55
tiny 37
LOCATE 10, 55
tiny 39
ce 13, "choose a deed to view or 0 to continue"
wt = ner(14, 39)
IF wt = 0 THEN EXIT DO
SELECT CASE lot(wt).sty
CASE "b"
box
COLOR lot(wt).hue
ce 5, RTRIM$(lot(wt).ttl)
COLOR 7
ce 6, "cost $" + lts(lot(wt).c)
ce 7, "mortgage value $" + lts(lot(wt).c / 2)
ce 8, "rent $" + lts(lot(wt).r)
ce 9, "rent with one house $" + lts(lot(wt).r1)
ce 10, "rent with two houses $" + lts(lot(wt).r2)
ce 11, "rent with three houses $" + lts(lot(wt).r3)
ce 12, "rent with four houses $" + lts(lot(wt).r4)
ce 13, "rent with hotel $" + lts(lot(wt).rhot)
ce 14, "houses cost $" + lts(lot(wt).bc) + " each"
ce 15, "hotel costs $" + lts(lot(wt).bc) + " plus 4 houses"
COLOR 15
IF lot(wt).own = 0 THEN
ce 16, "unowned"
ELSE
ce 16, "owned by " + RTRIM$(st(lot(wt).own).ft)
IF lot(wt).hk THEN
ce 17, "mortgaged, $" + lts(INT(.5 + lot(wt).c * uf!)) + " to unmortgage."
ELSE
SELECT CASE lot(wt).stat
CASE 0
ce 17, "with no buildings"
CASE 1
ce 17, "with one house"
CASE 2
ce 17, "with two houses"
CASE 3
ce 17, "with three houses"
CASE 4
ce 17, "with four houses"
CASE 5
ce 17, "with hotel"
END SELECT
END IF
END IF
p
CASE "u"
box
COLOR lot(wt).hue
ce 5, RTRIM$(lot(wt).ttl)
COLOR 15
ce 6, "cost $150"
ce 7, "mortgage value $75"
ce 8, "rent with one Utility, four times dice"
ce 9, "rent with two Utilities, ten times dice"
IF lot(wt).own = 0 THEN
ce 16, "unowned"
ELSE
ce 16, "owned by " + RTRIM$(st(lot(wt).own).ft)
IF lot(wt).hk THEN ce 17, "mortgaged, $" + lts(INT(.5 + lot(wt).c * uf!)) + " to unmortgage."
SELECT CASE lot(wt).stat
CASE 1
ce 18, "one Utility"
CASE 2
ce 18, "two utlities"
END SELECT
END IF
p
CASE "r"
box
COLOR lot(wt).hue
ce 5, RTRIM$(lot(wt).ttl)
COLOR 15
ce 6, "cost $200"
ce 7, "mortgage value $100"
ce 8, "rent with one Railroad $25"
ce 9, "rent with two Railroads $50"
ce 10, "rent with three Railroads $100"
ce 11, "rent with four Railroads $200"
IF lot(wt).own = 0 THEN
ce 16, "unowned"
ELSE
ce 16, "owned by " + RTRIM$(st(lot(wt).own).ft)
IF lot(wt).hk THEN ce 17, "mortgaged, $" + lts(INT(.5 + lot(wt).c * uf!)) + " to unmortgage."
SELECT CASE lot(wt).stat
CASE 1
ce 18, "one Railroad"
CASE 2
ce 18, "two Railroads"
CASE 3
ce 18, "three Railroads"
CASE 4
ce 18, "four Railroads"
END SELECT
END IF
p
CASE "o"
IF (NOT q) THEN b
END SELECT
LOOP UNTIL wt = 0
END SUB

