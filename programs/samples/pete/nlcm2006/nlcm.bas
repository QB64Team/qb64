CHDIR ".\programs\samples\pete\nlcm2006"

DECLARE SUB managerInfo ()
DECLARE SUB playerSalary ()
DECLARE SUB finance ()
DECLARE SUB endOfSeason ()
DECLARE SUB training ()
DECLARE SUB loadGame ()
DECLARE SUB saveGame ()
DECLARE SUB batOrder ()
DECLARE SUB statistics ()
DECLARE SUB groupTables ()
DECLARE SUB matchSimulator ()
DECLARE SUB manhattan ()
DECLARE SUB figures2 ()
DECLARE SUB scorecard2 ()
DECLARE SUB changeBowler ()
DECLARE SUB figures ()
DECLARE SUB scorecard ()
DECLARE FUNCTION rand! (c!)
DECLARE SUB matchDay ()
DECLARE SUB fixtures ()
DECLARE SUB getInfo ()
DECLARE SUB teamSheet ()
DIM SHARED overSeas1(19)
DIM SHARED overSeas2(19)
DIM SHARED points(19)
DIM SHARED ta(18)
DIM SHARED ti(18)
DIM SHARED f$(19)
DIM SHARED team$(19)
DIM SHARED rating(19)
DIM SHARED shirt1(19)
DIM SHARED shirt2(19)
DIM SHARED trousers1(19)
DIM SHARED trousers2(19)
DIM SHARED cs(19)
DIM SHARED wk(19)
DIM SHARED cp(19)
DIM SHARED ob1(19)
DIM SHARED ob2(19)
DIM SHARED player$(18, 19)
DIM SHARED gb(18, 19)
DIM SHARED rs(18, 19)
DIM SHARED wt(18, 19)
DIM SHARED eb(18, 19)
DIM SHARED ba(18, 19)
DIM SHARED fa(18, 19)
DIM SHARED bat(18, 19)
DIM SHARED bowl(18, 19)
DIM SHARED wicketKeeper(18, 19)
DIM SHARED peak(18, 19)
DIM SHARED international(18, 19)
DIM SHARED sm(18)
DIM SHARED salary(18, 19)
DIM SHARED sRuns(18)
DIM SHARED sBalls(18)
DIM SHARED sInnings(18)
DIM SHARED sOuts(18)
DIM SHARED hs(18)
DIM SHARED batAve(18)
DIM SHARED sOvers(18)
DIM SHARED sWickets(18)
DIM SHARED sConceded(18)
DIM SHARED strRte(18)
DIM SHARED ecnRte(18)
DIM SHARED bbw(18)
DIM SHARED bbr(18)
DIM SHARED bowlAve(18)
DIM SHARED bat$(2)
DIM SHARED bowl$(13)
DIM SHARED attribute$(6)
DIM SHARED tAttribute$(6)
DIM SHARED fixture(2, 9, 18)
DIM SHARED pitch$(5)
DIM SHARED pr(5)
DIM SHARED truns(19)
DIM SHARED tWickets(19)
DIM SHARED tovers(19)
DIM SHARED tBalls(19)
DIM SHARED runs(11, 19)
DIM SHARED balls(11, 19)
DIM SHARED o(11, 19)
DIM SHARED b(11, 19)
DIM SHARED m(11, 19)
DIM SHARED r(11, 19)
DIM SHARED w(11, 19)
DIM SHARED extras(19)
DIM SHARED wides(19)
DIM SHARED noBalls(19)
DIM SHARED byes(19)
DIM SHARED legByes(19)
DIM SHARED ball$(8)
DIM SHARED howOut1$(18, 19)
DIM SHARED howOut2$(18, 19)
DIM SHARED howOut3$(18, 19)
DIM SHARED howOut4$(18, 19)
DIM SHARED speed(8)
DIM SHARED bowlChange(12, 19)
DIM SHARED bowlers(19)
DIM SHARED fow(10, 19)
DIM SHARED cb(18, 19)
DIM SHARED fatigue(18, 19)
DIM SHARED in(18, 19)
DIM SHARED rpo(50, 2)
DIM SHARED groupTeam(10, 2)
DIM SHARED rank(19)
DIM SHARED position(19)
DIM SHARED played(19)
DIM SHARED wins(19)
DIM SHARED losses(19)
DIM SHARED ties(19)
DIM SHARED field$(3)
DIM SHARED career$(5)
DIM SHARED morale(18)
DIM SHARED iWeeks(18)
DIM SHARED duty(18)
COMMON SHARED directorsRating, fansRating, weekIn, weekOut, money, coinCheat, os, pr, battingSide, bowlingSide, lastSub, gt, bat1, bat2, team, name$, week, year, u$, d$, l$, r$, batSide, bowlSide, opponents, bowler, lbowler, momDone
CALL getInfo
fansRating = 40
directorsRating = 40

COLOR 11, 0
CLS
LOCATE 16, 20
PRINT "NATIONAL LEAGUE CRICKET MANAGER 2006"
LOCATE 19, 28
COLOR 3, 0
PRINT "By Alex Beighton"
DO
LOOP UNTIL INKEY$ = CHR$(13)

COLOR 11, 0
CLS
LOCATE 16, 28
PRINT "KEY CONFIGURATION:"
COLOR 3, 0
LOCATE 20, 22
PRINT "Enter the "; CHR$(34); "up"; CHR$(34); " key on your keypad"
DO
u$ = INKEY$
LOOP UNTIL u$ <> ""
COLOR 11, 0
CLS
LOCATE 16, 28
PRINT "KEY CONFIGURATION:"
COLOR 3, 0
LOCATE 20, 22
PRINT "Enter the "; CHR$(34); "down"; CHR$(34); " key on your keypad"
DO
d$ = INKEY$
LOOP UNTIL d$ <> ""
COLOR 11, 0
CLS
LOCATE 16, 28
PRINT "KEY CONFIGURATION:"
COLOR 3, 0
LOCATE 20, 22
PRINT "Enter the "; CHR$(34); "left"; CHR$(34); " key on your keypad"
DO
l$ = INKEY$
LOOP UNTIL l$ <> ""
COLOR 11, 0
CLS
LOCATE 16, 28
PRINT "KEY CONFIGURATION:"
COLOR 3, 0
LOCATE 20, 22
PRINT "Enter the "; CHR$(34); "right"; CHR$(34); " key on your keypad"
DO
r$ = INKEY$
LOOP UNTIL r$ <> ""

gc = 1
910 COLOR 11, 0
CLS
LOCATE 16, 20
PRINT "NATIONAL LEAGUE CRICKET MANAGER 2006"
LOCATE 19, 28
COLOR 3, 0
PRINT "By Alex Beighton"

IF gc = 1 THEN COLOR 0, 3 ELSE COLOR 3, 0
LOCATE 25, 30
PRINT "NEW GAME"
IF gc = 2 THEN COLOR 0, 3 ELSE COLOR 3, 0
LOCATE 27, 30
PRINT "LOAD GAME"
IF gc = 3 THEN COLOR 0, 3 ELSE COLOR 3, 0
LOCATE 29, 30
PRINT "QUIT GAME"

900 SELECT CASE INKEY$
CASE IS = u$
gc = gc - 1
IF gc < 1 THEN gc = 3
GOTO 910
CASE IS = d$
gc = gc + 1
IF gc > 3 THEN gc = 1
GOTO 910
CASE IS = CHR$(13)
CASE ELSE
GOTO 900
END SELECT

SELECT CASE gc
CASE IS = 2
CALL loadGame
os = 1
GOTO 970
CASE IS = 3
END
END SELECT

COLOR 11, 0
CLS
LOCATE 16, 26
PRINT "ENTER YOUR NAME"
COLOR 3, 0
LOCATE 20, 26
PRINT "My name is"
DO
LOCATE 20, 36
INPUT name$
LOOP UNTIL name$ <> ""

COLOR 3, 0
CLS
ct = 1
20 COLOR 11, 0
LOCATE 3, 5
PRINT "SELECT YOUR TEAM..."
COLOR 3, 0
FOR i = 1 TO 19
IF ct = i THEN COLOR 0, 3 ELSE COLOR 3, 0
LOCATE 6 + (i * 2), 5
PRINT team$(i)
NEXT i

COLOR shirt1(ct), 0
FOR i = 18 TO 27
FOR j = 38 TO 46
LOCATE i, j
PRINT CHR$(219)
NEXT j
NEXT i
COLOR shirt2(ct), 0
LOCATE 22, 40
PRINT CHR$(219); CHR$(219); CHR$(219); CHR$(219); CHR$(219)
LOCATE 18, 42
PRINT CHR$(219)
FOR i = 18 TO 24
FOR j = 36 TO 37
LOCATE i, j
PRINT CHR$(219)
NEXT j
FOR j = 47 TO 48
LOCATE i, j
PRINT CHR$(219)
NEXT j
NEXT i

COLOR trousers1(ct), 0
FOR i = 28 TO 38
FOR j = 38 TO 46
IF i > 30 AND j > 41 AND j < 43 THEN GOTO 440
LOCATE i, j
PRINT CHR$(219)
440 NEXT j
NEXT i

SELECT CASE cs(ct)
CASE IS = 1
COLOR trousers2(ct), trousers1(ct)
FOR i = 28 TO 38
LOCATE i, 38
PRINT CHR$(221)
LOCATE i, 46
PRINT CHR$(222)
NEXT i
CASE IS = 2
COLOR trousers1(ct), trousers2(ct)
FOR i = 28 TO 38
LOCATE i, 38
PRINT CHR$(222)
LOCATE i, 46
PRINT CHR$(221)
NEXT i
END SELECT

COLOR 11, 0
LOCATE 8, 36
PRINT "TEAM    :"
COLOR 3, 0
LOCATE 8, 47
PRINT team$(ct)
COLOR 11, 0
LOCATE 10, 36
PRINT "CAPTAIN :"
COLOR 3, 0
LOCATE 10, 47
PRINT player$(cp(ct), ct)
COLOR 11, 0
LOCATE 12, 36
PRINT "GROUP   :"
COLOR 3, 0
LOCATE 12, 47
IF groupTeam(1, 1) = ct OR groupTeam(2, 1) = ct OR groupTeam(3, 1) = ct OR groupTeam(4, 1) = ct OR groupTeam(5, 1) = ct OR groupTeam(6, 1) = ct OR groupTeam(7, 1) = ct OR groupTeam(8, 1) = ct OR groupTeam(9, 1) = ct THEN PRINT "DIVISION 1" ELSE PRINT "DIVISION 2"

10 SELECT CASE INKEY$
CASE IS = u$
CLS
ct = ct - 1
IF ct < 1 THEN ct = 19
GOTO 20
CASE IS = d$
CLS
ct = ct + 1
IF ct > 19 THEN ct = 1
GOTO 20
CASE IS = CHR$(13)
CASE ELSE
GOTO 10
END SELECT
team = ct

week = 1
year = 2006
os = 1
FOR i = 1 TO 18
morale(i) = rand(10) + 65
NEXT i
970 DO
FOR i = 1 TO 18
IF morale(i) < 25 THEN morale(i) = 25
IF morale(i) > 95 THEN morale(i) = 95
NEXT i
SELECT CASE os
CASE IS = 9
FOR i = 1 TO 18
IF iWeeks(i) > 0 THEN iWeeks(i) = iWeeks(i) - 1
NEXT i
FOR i = 1 TO 18
IF i > 11 THEN morale(i) = morale(i) + (rand(4) - 3) ELSE morale(i) = morale(i) + rand(4)
IF morale(i) < 25 THEN morale(i) = 25
IF morale(i) > 95 THEN morale(i) = 95
NEXT i
weekOut = 0
weekIn = 0
FOR i = 1 TO 18
money = money - salary(i, team)
weekOut = weekOut + salary(i, team)
NEXT i
weekIn = rand(12000) + 40000
money = money + weekIn
week = week + 1
os = 1
FOR i = 1 TO 18
IF peak(i, team) = 1 THEN ir = 4
IF peak(i, team) = 2 THEN ir = 8
IF peak(i, team) = 3 THEN ir = 12
IF peak(i, team) = 4 THEN ir = 16
IF peak(i, team) = 5 THEN ir = 20
IF ti(i) < 3 THEN ir = ir + 1
IF ti(i) > 3 THEN ir = ir - 1
cogb = rand(ir)
SELECT CASE ir
CASE IS = 1
IF ta(i) = 1 THEN gb(i, team) = gb(i, team) + 1
IF ta(i) = 2 THEN rs(i, team) = rs(i, team) + 1
IF ta(i) = 3 THEN wt(i, team) = wt(i, team) + 1
IF ta(i) = 4 THEN eb(i, team) = eb(i, team) + 1
IF ta(i) = 5 THEN fa(i, team) = fa(i, team) + 1
IF ta(i) = 6 THEN fa(i, team) = fa(i, team) + 1
END SELECT
NEXT i

injuryChance = rand(6)
SELECT CASE injuryChance
CASE IS = 1
injuries = 0
FOR j = 1 TO 18
IF iWeeks(j) > 0 THEN injuries = injuries + 1
NEXT j
IF injuries >= 3 THEN GOTO 3000
DO
injuredPlayer = rand(18)
LOOP UNTIL iWeeks(injuredPlayer) = 0
iWeeks(injuredPlayer) = rand(5)

COLOR 11, 0
CLS
LOCATE 2, 5
PRINT name$; "    "; team$(team); "    Week "; week; "  Year "; year
LOCATE 8, 5
PRINT "FOR YOUR INFORMATION:"
COLOR 3, 0
LOCATE 10, 5
PRINT player$(injuredPlayer, team); " has picked up an injury and will be out for "; iWeeks(injuredPlayer); " weeks."
DO
LOOP UNTIL INKEY$ = CHR$(13)
3000 END SELECT

internationals = 0
FOR i = 1 TO 18
IF international(i, team) = 1 THEN internationals = 1
NEXT i
IF internationals = 0 THEN GOTO 3300
SELECT CASE week
CASE IS = 5
COLOR 11, 0
CLS
LOCATE 2, 5
PRINT name$; "    "; team$(team); "    Week "; week; "  Year "; year
LOCATE 8, 5
PRINT "FOR YOUR INFORMATION:"
COLOR 3, 0
LOCATE 12, 5
PRINT "The following player(s) are from now on international duty and are"
LOCATE 13, 5
PRINT "unavailable for selection:"
internationalTotal = 0
FOR i = 1 TO 18
IF international(i, team) = 1 THEN internationalTotal = internationalTotal + 1
LOCATE 14 + internationalTotal, 5
IF international(i, team) = 1 THEN PRINT player$(i, team)
IF international(i, team) = 1 THEN duty(i) = 1
NEXT i
DO
LOOP UNTIL INKEY$ = CHR$(13)

CASE IS = 12
COLOR 11, 0
CLS
LOCATE 2, 5
PRINT name$; "    "; team$(team); "    Week "; week; "  Year "; year
LOCATE 8, 5
PRINT "FOR YOUR INFORMATION:"
COLOR 3, 0
LOCATE 12, 5
PRINT "The following player(s) have returned from international duty and are"
LOCATE 13, 5
PRINT "now available for selection:"
internationalTotal = 0
FOR i = 1 TO 18
IF international(i, team) = 1 THEN internationalTotal = internationalTotal + 1
LOCATE 14 + internationalTotal, 5
IF international(i, team) = 1 THEN PRINT player$(i, team)
IF international(i, team) = 1 THEN duty(i) = 0
NEXT i
DO
LOOP UNTIL INKEY$ = CHR$(13)
END SELECT
3300 END SELECT

IF week = 53 THEN year = year + 1
IF week = 53 THEN week = 1

totalMorale = 0
FOR i = 1 TO 18
totalMorale = totalMorale + morale(i)
NEXT i
directorsRating = (fansRating / 2)
SELECT CASE totalMorale
CASE IS >= 1250
directorsRating = directorsRating + 25
CASE 1200 TO 1249
directorsRating = directorsRating + 15
CASE 1150 TO 1199
directorsRating = directorsRating + 5
END SELECT

SELECT CASE money
CASE IS >= 18000
directorsRating = directorsRating + 25
CASE 16000 TO 17999
directorsRating = directorsRating + 20
CASE 14000 TO 15999
directorsRating = directorsRating + 15
CASE 12000 TO 13999
directorsRating = directorsRating + 10
CASE 10000 TO 11999
directorsRating = directorsRating + 5
END SELECT


IF fansRating > 100 THEN fansRating = 100
IF directorsRating > 100 THEN directorsRating = 100
IF fansRating < 5 THEN fansRating = 5
IF directorsRating < 5 THEN directorsRating = 5

COLOR 11, 0
CLS
LOCATE 2, 5
PRINT name$; "    "; team$(team); "    Week "; week; "  Year "; year

COLOR shirt1(team), 0
FOR i = 8 TO 17
FOR j = 44 TO 52
LOCATE i, j
PRINT CHR$(219)
NEXT j
NEXT i
COLOR shirt2(team), 0
LOCATE 12, 46
PRINT CHR$(219); CHR$(219); CHR$(219); CHR$(219); CHR$(219)
LOCATE 8, 48
PRINT CHR$(219)
FOR i = 8 TO 14
FOR j = 42 TO 43
LOCATE i, j
PRINT CHR$(219)
NEXT j
FOR j = 53 TO 54
LOCATE i, j
PRINT CHR$(219)
NEXT j
NEXT i

COLOR trousers1(team), 0
FOR i = 18 TO 28
FOR j = 44 TO 52
IF i > 20 AND j > 47 AND j < 49 THEN GOTO 70
LOCATE i, j
PRINT CHR$(219)
70 NEXT j
NEXT i

SELECT CASE cs(team)
CASE IS = 1
COLOR trousers2(team), trousers1(team)
FOR i = 18 TO 28
LOCATE i, 44
PRINT CHR$(221)
LOCATE i, 52
PRINT CHR$(222)
NEXT i
CASE IS = 2
COLOR trousers1(team), trousers2(team)
FOR i = 18 TO 28
LOCATE i, 44
PRINT CHR$(222)
LOCATE i, 52
PRINT CHR$(221)
NEXT i
END SELECT

40 LOCATE 8, 5
IF os = 1 THEN COLOR 0, 3 ELSE COLOR 3, 0
PRINT "Team Sheet"
LOCATE 10, 5
IF os = 2 THEN COLOR 0, 3 ELSE COLOR 3, 0
PRINT "Training"
LOCATE 12, 5
IF os = 3 THEN COLOR 0, 3 ELSE COLOR 3, 0
PRINT "Finance"
LOCATE 14, 5
IF os = 4 THEN COLOR 0, 3 ELSE COLOR 3, 0
PRINT "Fixtures"
LOCATE 16, 5
IF os = 5 THEN COLOR 0, 3 ELSE COLOR 3, 0
PRINT "League Tables"
LOCATE 18, 5
IF os = 6 THEN COLOR 0, 3 ELSE COLOR 3, 0
PRINT "Statistics"
LOCATE 20, 5
IF os = 7 THEN COLOR 0, 3 ELSE COLOR 3, 0
PRINT "Manager Info"
LOCATE 22, 5
IF os = 8 THEN COLOR 0, 3 ELSE COLOR 3, 0
PRINT "Save Game"
LOCATE 24, 5
IF os = 9 THEN COLOR 0, 3 ELSE COLOR 3, 0
PRINT "GO TO MATCHDAY"

30 SELECT CASE INKEY$
CASE IS = u$
os = os - 1
IF os < 1 THEN os = 9
GOTO 40
CASE IS = d$
os = os + 1
IF os > 9 THEN os = 1
GOTO 40
CASE IS = CHR$(13)
CASE ELSE
GOTO 30
END SELECT

SELECT CASE os
CASE IS = 1
CALL teamSheet
CASE IS = 2
CALL training
CASE IS = 3
CALL finance
CASE IS = 4
CALL fixtures
CASE IS = 5
CALL groupTables
CASE IS = 6
CALL statistics
CASE IS = 7
CALL managerInfo
CASE IS = 8
CALL saveGame
CASE IS = 9
injuryTeam = 0
FOR i = 1 TO 11
IF iWeeks(i) > 0 THEN injuryTeam = 1
IF duty(i) > 0 THEN injuryTeam = 1
NEXT i
SELECT CASE injuryTeam
CASE IS = 0
CALL matchDay
CASE IS = 1
COLOR 3, 0
LOCATE 40, 5
PRINT "You cannot play a match, as you do not have 11 valid players in your team."
GOTO 30
END SELECT
CASE ELSE
END SELECT
LOOP

SUB batOrder
ps = tWickets(batSide) + 3
22 COLOR 11, 0
CLS
LOCATE 2, 5
PRINT team$(batSide); " - CHANGE BATTING ORDER"

FOR i = 1 TO 11
LOCATE i * 2 + 6, 5
IF in(i, batSide) = 1 THEN COLOR 11, 0 ELSE COLOR 3, 0
PRINT player$(i, batSide)
LOCATE i * 2 + 6, 3
IF i = ps THEN PRINT CHR$(16) ELSE PRINT " "
NEXT i

COLOR 11, 0
LOCATE 40, 5
PRINT "Move the cursor to the player you want to swap, then press RETURN."

21 SELECT CASE INKEY$
CASE IS = u$
ps = ps - 1
IF ps - tWickets(batSide) < 3 THEN ps = 11
GOTO 22
CASE IS = d$
ps = ps + 1
IF ps > 11 THEN ps = tWickets(batSide) + 3
GOTO 22
CASE IS = CHR$(13)
CASE ELSE
GOTO 21
END SELECT

ps2 = tWickets(batSide) + 3
24 COLOR 11, 0
CLS
LOCATE 2, 5
PRINT team$(batSide); " - CHANGE BATTING ORDER"

FOR i = 1 TO 11
LOCATE i * 2 + 6, 5
IF in(i, batSide) = 1 THEN COLOR 11, 0 ELSE COLOR 3, 0
PRINT player$(i, batSide)
COLOR 3, 0
LOCATE i * 2 + 6, 3
IF i = ps THEN PRINT CHR$(16)
COLOR 9, 0
LOCATE i * 2 + 6, 3
IF i = ps2 THEN PRINT CHR$(16)
LOCATE i * 2 + 6, 3
IF i <> ps AND i <> ps2 THEN PRINT " "
NEXT i

COLOR 11, 0
LOCATE 40, 5
PRINT "Move the cursor to the player you want to swap, then press RETURN."

23 SELECT CASE INKEY$
CASE IS = u$
ps2 = ps2 - 1
IF ps2 - tWickets(batSide) < 3 THEN ps2 = 11
GOTO 24
CASE IS = d$
ps2 = ps2 + 1
IF ps2 > 11 THEN ps2 = tWickets(batSide) + 3
GOTO 24
CASE IS = CHR$(13)
CASE ELSE
GOTO 23
END SELECT

player2$ = player$(ps2, team)
gb2 = gb(ps2, team)
rs2 = rs(ps2, team)
eb2 = eb(ps2, team)
wt2 = wt(ps2, team)
ba2 = ba(ps2, team)
fa2 = fa(ps2, team)
bats2 = bat(ps2, team)
bowl2 = bowl(ps2, team)
wicketKeeper2 = wicketKeeper(ps2, team)
international2 = international(ps2, team)
salary2 = salary(ps2, team)
peak2 = peak(ps2, team)
sm2 = sm(ps2)
sInnings2 = sInnings(ps2)
sRuns2 = sRuns(ps2)
sOuts2 = sOuts(ps2)
hs2 = hs(ps2)
sBalls2 = sBalls(ps2)
sWickets2 = sWickets(ps2)
bbw2 = bbw(ps2)
bbr2 = bbr(ps2)
sOvers2 = sOvers(ps2)
sConceded2 = sConceded(ps2)
morale2 = morale(ps2)
iWeeks2 = iWeeks(ps2)
duty2 = duty(ps2)
o2 = o(ps2, team)
b2 = b(ps2, team)
m2 = m(ps2, team)
r2 = r(ps2, team)
w2 = w(ps2, team)

player$(ps2, team) = player$(ps, team)
player$(ps2, team) = player$(ps, team)
gb(ps2, team) = gb(ps, team)
rs(ps2, team) = rs(ps, team)
eb(ps2, team) = eb(ps, team)
wt(ps2, team) = wt(ps, team)
ba(ps2, team) = ba(ps, team)
fa(ps2, team) = fa(ps, team)
bat(ps2, team) = bat(ps, team)
bowl(ps2, team) = bowl(ps, team)
wicketKeeper(ps2, team) = wicketKeeper(ps, team)
international(ps2, team) = international(ps, team)
salary(ps2, team) = salary(ps, team)
peak(ps2, team) = peak(ps, team)
sm(ps2) = sm(ps)
sInnings(ps2) = sInnings(ps)
sRuns(ps2) = sRuns(ps)
sOuts(ps2) = sOuts(ps)
hs(ps2) = hs(ps)
sBalls(ps2) = sBalls(ps)
sWickets(ps2) = sWickets(ps)
bbw(ps2) = bbw(ps)
bbr(ps2) = bbr(ps)
sOvers(ps2) = sOvers(ps)
sConceded(ps2) = sConceded(ps)
morale(ps2) = morale(ps)
iWeeks(ps2) = iWeeks(ps)
duty(ps2) = duty(ps)
o(ps2, team) = o(ps, team)
b(ps2, team) = b(ps, team)
m(ps2, team) = m(ps, team)
r(ps2, team) = r(ps, team)
w(ps2, team) = w(ps, team)

player$(ps, team) = player2$
gb(ps, team) = gb2
rs(ps, team) = rs2
eb(ps, team) = eb2
wt(ps, team) = wt2
ba(ps, team) = ba2
fa(ps, team) = fa2
bat(ps, team) = bats2
bowl(ps, team) = bowl2
wicketKeeper(ps, team) = wicketKeeper2
international(ps, team) = international2
salary(ps, team) = salary2
peak(ps, team) = peak2
sm(ps) = sm2
sInnings(ps) = sInnings2
sRuns(ps) = sRuns2
sOuts(ps) = sOuts2
hs(ps) = hs2
sBalls(ps) = sBalls2
sWickets(ps) = sWickets2
bbw(ps) = bbw2
bbr(ps) = bbr2
sOvers(ps) = sOvers2
sConceded(ps) = sConceded2
morale(ps) = morale2
iWeeks(ps) = iWeeks2
duty(ps) = duty2
o(ps, team) = o2
b(ps, team) = b2
m(ps, team) = m2
r(ps, team) = r2
w(ps, team) = w2

SELECT CASE wk(team)
CASE IS = ps
IF ps2 < 12 THEN wk(team) = ps2
CASE IS = ps2
IF ps < 12 THEN wk(team) = ps
END SELECT
SELECT CASE cp(team)
CASE IS = ps
IF ps2 < 12 THEN cp(team) = ps2
CASE IS = ps2
IF ps < 12 THEN cp(team) = ps
END SELECT
SELECT CASE ob1(team)
CASE IS = ps
IF ps2 < 12 THEN ob1(team) = ps2
CASE IS = ps2
IF ps < 12 THEN ob1(team) = ps
END SELECT
SELECT CASE ob2(team)
CASE IS = ps
IF ps2 < 12 THEN ob2(team) = ps2
CASE IS = ps2
IF ps < 12 THEN ob2(team) = ps
END SELECT
FOR i = 1 TO 10
SELECT CASE bowlChange(i, team)
CASE IS = ps
bowlChange(i, team) = ps2
CASE IS = ps2
bowlChange(i, team) = ps
END SELECT
NEXT i
25 COLOR 3, 0
CLS
END SUB

SUB changeBowler
choose = 1
260 COLOR 11, 0
CLS
DO
LOCATE 2, 5
PRINT team$(bowlSide); " - CHANGE BOWLER"
LOCATE 6, 5
PRINT "PLAYER"
LOCATE 6, 26
PRINT "BOWL"
LOCATE 6, 33
PRINT "O"
LOCATE 6, 36
PRINT "M"
LOCATE 6, 39
PRINT "R"
LOCATE 6, 43
PRINT "W"
LOCATE 6, 50
PRINT "FATIGUE"

FOR i = 1 TO 11
IF i = 1 OR i = 3 OR i = 5 OR i = 7 OR i = 9 OR i = 11 THEN COLOR 3, 0 ELSE COLOR 11, 0
LOCATE 6 + (i * 2), 5
PRINT player$(i, bowlSide)
LOCATE 6 + (i * 2), 26
PRINT bowl$(bowl(i, bowlSide))
LOCATE 6 + (i * 2), 32
PRINT o(i, bowlSide)
LOCATE 6 + (i * 2), 35
PRINT m(i, bowlSide)
LOCATE 6 + (i * 2), 38
PRINT r(i, bowlSide)
LOCATE 6 + (i * 2), 42
PRINT w(i, bowlSide)
FOR j = 1 TO 10
LOCATE 6 + (i * 2), 49 + j
IF fatigue(i, bowlSide) > j THEN PRINT CHR$(219)
NEXT j
NEXT i

COLOR 11, 0
LOCATE 6 + (choose * 2), 3
PRINT CHR$(16)

250 SELECT CASE INKEY$
CASE IS = u$
choose = choose - 1
IF choose < 1 THEN choose = 11
GOTO 260
CASE IS = d$
choose = choose + 1
IF choose > 11 THEN choose = 1
GOTO 260
CASE IS = CHR$(13)
CASE ELSE
GOTO 250
END SELECT

COLOR 11, 0
LOCATE 38, 5
IF bowl(choose, bowlSide) = 13 THEN PRINT player$(choose, bowlSide); " does not bowl."
LOCATE 40, 5
IF o(choose, bowlSide) >= 10 THEN PRINT player$(choose, bowlSide); " has bowled his maximum 10 overs."
LOCATE 42, 5
IF choose = lbowler THEN PRINT player$(choose, bowlSide); " bowled the last over."
LOOP UNTIL o(choose, bowlSide) < 9 AND bowl(choose, bowlSide) < 13 AND choose <> lbowler
bowler = choose
COLOR 3, 0
CLS
pr = r(bowler, bowlSide)
END SUB

SUB endOfSeason
COLOR 11, 0
CLS
LOCATE 2, 5
PRINT name$; "    "; team$(team); "    Week "; week; "  Year "; year

FOR i = 1 TO 19
rank(i) = (15 - i) / 100
NEXT i
FOR k = 1 TO 2
IF k = 1 THEN t = 9 ELSE t = 10
FOR i = 1 TO t
position(groupTeam(i, k)) = 11
FOR j = 1 TO t
IF points(groupTeam(i, k)) + rank(groupTeam(i, k)) >= points(groupTeam(j, k)) + rank(groupTeam(j, k)) THEN position(groupTeam(i, k)) = position(groupTeam(i, k)) - 1
NEXT j
NEXT i
NEXT k
COLOR 11, 0
CLS
LOCATE 2, 3
PRINT name$; "    "; team$(team); "    Week "; week; "  Year "; year
LOCATE 6, 3
PRINT "END OF SEASON - NATIONAL LEAGUE TABLES"
LOCATE 9, 3
PRINT "DIVISION 1"
LOCATE 11, 3
PRINT "TEAM"
LOCATE 11, 21
PRINT "P"
LOCATE 11, 25
PRINT "W"
LOCATE 11, 29
PRINT "L"
LOCATE 11, 33
PRINT "T"
LOCATE 11, 38
PRINT "PTS"

FOR i = 1 TO 9
IF position(groupTeam(i, 1)) > 7 THEN COLOR 1, 0 ELSE COLOR 3, 0
IF groupTeam(i, 1) = team THEN COLOR 11, 0
LOCATE position(groupTeam(i, 1)) + 11, 3
PRINT team$(groupTeam(i, 1))
LOCATE position(groupTeam(i, 1)) + 11, 20
PRINT played(groupTeam(i, 1))
LOCATE position(groupTeam(i, 1)) + 11, 24
PRINT wins(groupTeam(i, 1))
LOCATE position(groupTeam(i, 1)) + 11, 28
PRINT losses(groupTeam(i, 1))
LOCATE position(groupTeam(i, 1)) + 11, 32
PRINT ties(groupTeam(i, 1))
LOCATE position(groupTeam(i, 1)) + 11, 37
PRINT points(groupTeam(i, 1))
NEXT i

COLOR 11, 0
LOCATE 29, 3
PRINT "DIVISION 2"
LOCATE 31, 3
PRINT "TEAM"
LOCATE 31, 21
PRINT "P"
LOCATE 31, 25
PRINT "W"
LOCATE 31, 29
PRINT "L"
LOCATE 31, 33
PRINT "T"
LOCATE 31, 38
PRINT "PTS"

FOR i = 1 TO 10
IF position(groupTeam(i, 2)) > 3 THEN COLOR 1, 0 ELSE COLOR 3, 0
IF groupTeam(i, 2) = team THEN COLOR 11, 0
LOCATE position(groupTeam(i, 2)) + 31, 3
PRINT team$(groupTeam(i, 2))
LOCATE position(groupTeam(i, 2)) + 31, 20
PRINT played(groupTeam(i, 2))
LOCATE position(groupTeam(i, 2)) + 31, 24
PRINT wins(groupTeam(i, 2))
LOCATE position(groupTeam(i, 2)) + 31, 28
PRINT losses(groupTeam(i, 2))
LOCATE position(groupTeam(i, 2)) + 31, 32
PRINT ties(groupTeam(i, 2))
LOCATE position(groupTeam(i, 2)) + 31, 37
PRINT points(groupTeam(i, 2))
NEXT i

DO
LOOP UNTIL INKEY$ = CHR$(13)
END
END SUB

SUB figures
o((bowlChange(i, bowlSide)), bowlSide) = 10
COLOR 11, 0
CLS
LOCATE 2, 4
PRINT team$(bowlSide)
LOCATE 5, 27
PRINT "O"
LOCATE 5, 35
PRINT "M"
LOCATE 5, 43
PRINT "R"
LOCATE 5, 51
PRINT "W"

COLOR 3, 0
FOR i = 1 TO bowlers(bowlSide)
LOCATE 5 + (i * 2), 4
PRINT player$((bowlChange(i, bowlSide)), bowlSide)
IF o((bowlChange(i, bowlSide)), bowlSide) >= 10 THEN LOCATE 5 + (i * 2), 23 ELSE LOCATE 5 + (i * 2), 24
PRINT o((bowlChange(i, bowlSide)), bowlSide); "."; b((bowlChange(i, bowlSide)), bowlSide)
LOCATE 5 + (i * 2), 34
PRINT m((bowlChange(i, bowlSide)), bowlSide)
LOCATE 5 + (i * 2), 42
PRINT r((bowlChange(i, bowlSide)), bowlSide)
LOCATE 5 + (i * 2), 50
PRINT w((bowlChange(i, bowlSide)), bowlSide)
NEXT i

COLOR 11, 0
LOCATE 16 + (i * 2), 4
PRINT "FOW:"
COLOR 3, 0
LOCATE 16 + (i * 2), 10
IF tWickets(batSide) = 0 THEN PRINT "-"
FOR j = 1 TO 5
LOCATE 16 + (i * 2), (12 * j)
IF tWickets(batSide) >= j THEN PRINT j; " - "; fow(j, batSide)
NEXT j
FOR j = 1 TO 5
LOCATE 17 + (i * 2), (12 * j)
IF tWickets(batSide) >= (j + 5) THEN PRINT j + 5; " - "; fow(j + 5, batSide)
NEXT j

LOCATE 48, 27
COLOR 3, 0
PRINT "       MAIN MENU       "
LOCATE 48, 4
COLOR 3, 0
PRINT "   BATTING SCORECARD   "
LOCATE 48, 50
COLOR 0, 3
PRINT "    BOWLING FIGURES    "
LOCATE 46, 37
PRINT CHR$(17); " "; CHR$(16)

220 SELECT CASE INKEY$
CASE IS = l$
CASE ELSE
GOTO 220
END SELECT
END SUB

SUB figures2
o((bowlChange(i, bowlingSide)), bowlingSide) = 10
COLOR 11, 0
CLS
LOCATE 2, 4
PRINT team$(bowlingSide)
LOCATE 5, 27
PRINT "O"
LOCATE 5, 35
PRINT "M"
LOCATE 5, 43
PRINT "R"
LOCATE 5, 51
PRINT "W"

COLOR 3, 0
FOR i = 1 TO bowlers(bowlingSide)
LOCATE 5 + (i * 2), 4
PRINT player$((bowlChange(i, bowlingSide)), bowlingSide)
IF o((bowlChange(i, bowlingSide)), bowlingSide) >= 10 THEN LOCATE 5 + (i * 2), 23 ELSE LOCATE 5 + (i * 2), 24
PRINT o((bowlChange(i, bowlingSide)), bowlingSide); "."; b((bowlChange(i, bowlingSide)), bowlingSide)
LOCATE 5 + (i * 2), 34
PRINT m((bowlChange(i, bowlingSide)), bowlingSide)
LOCATE 5 + (i * 2), 42
PRINT r((bowlChange(i, bowlingSide)), bowlingSide)
LOCATE 5 + (i * 2), 50
PRINT w((bowlChange(i, bowlingSide)), bowlingSide)
NEXT i

COLOR 11, 0
LOCATE 16 + (i * 2), 4
PRINT "FOW:"
COLOR 3, 0
LOCATE 16 + (i * 2), 10
IF tWickets(battingSide) = 0 THEN PRINT "-"
FOR j = 1 TO 5
LOCATE 16 + (i * 2), (12 * j)
IF tWickets(battingSide) >= j THEN PRINT j; " - "; fow(j, battingSide)
NEXT j
FOR j = 1 TO 5
LOCATE 17 + (i * 2), (12 * j)
IF tWickets(battingSide) >= (j + 5) THEN PRINT j + 5; " - "; fow(j + 5, battingSide)
NEXT j

DO
LOOP UNTIL INKEY$ = CHR$(13)
END SUB

SUB finance
2110 cfo = 1
2100 COLOR 11, 0
CLS
LOCATE 2, 5
PRINT name$; "    "; team$(team); "    Week "; week; "  Year "; year
LOCATE 6, 5
PRINT "FINANCE"
LOCATE 8, 5
IF cfo = 1 THEN COLOR 0, 3 ELSE COLOR 3, 0
PRINT "Finance Information"
LOCATE 10, 5
IF cfo = 2 THEN COLOR 0, 3 ELSE COLOR 3, 0
PRINT "Player Salaries"
LOCATE 12, 5
IF cfo = 3 THEN COLOR 0, 3 ELSE COLOR 3, 0
PRINT "Back to the Main Menu"

2000 SELECT CASE INKEY$
CASE IS = u$
cfo = cfo - 1
IF cfo < 1 THEN cfo = 3
GOTO 2100
CASE IS = d$
cfo = cfo + 1
IF cfo > 3 THEN cfo = 1
GOTO 2100
CASE IS = CHR$(13)
CASE ELSE
GOTO 2000
END SELECT

SELECT CASE cfo
CASE IS = 2
CALL playerSalary
GOTO 2110
CASE IS = 3
GOTO 2200
END SELECT

COLOR 11, 0
CLS
LOCATE 2, 5
PRINT name$; "    "; team$(team); "    Week "; week; "  Year "; year
LOCATE 6, 5
PRINT "FINANCE INFORMATION"
COLOR 3, 0
LOCATE 12, 5
PRINT "WEEKLY INCOME                    : "; weekIn; "pounds"
COLOR 9, 0
LOCATE 14, 5
PRINT "WEEKLY OUTGOINGS                 : "; weekOut; "pounds"
COLOR 3, 0
LOCATE 16, 5
PRINT "________________________________________________________"
COLOR 3, 0
LOCATE 18, 5
PRINT "TOTAL FINANCE AT START OF SEASON :  20000 pounds"
COLOR 9, 0
LOCATE 20, 5
PRINT "TOTAL CURRENT FINANCE            : "; money; "pounds"
DO
LOOP UNTIL INKEY$ = CHR$(13)
GOTO 2110
2200 END SUB

SUB fixtures
IF week = 19 THEN GOTO 18
COLOR 11, 0
CLS
LOCATE 2, 5
PRINT name$; "    "; team$(team); "    Week "; week; "  Year "; year
LOCATE 6, 5
PRINT "THIS WEEK'S NATIONAL LEAGUE FIXTURES:"
LOCATE 10, 5
PRINT "DIVISION 1:"
FOR i = 6 TO 9
COLOR 3, 0
LOCATE (i * 2), 5
PRINT team$(fixture(1, i, week))
LOCATE (i * 2), 23
PRINT "V"
LOCATE (i * 2), 27
PRINT team$(fixture(2, i, week))
NEXT i

COLOR 11, 0
LOCATE 22, 5
PRINT "DIVISION 2:"
FOR i = 1 TO 5
COLOR 3, 0
LOCATE (i * 2) + 22, 5
PRINT team$(fixture(1, i, week))
LOCATE (i * 2) + 22, 23
PRINT "V"
LOCATE (i * 2) + 22, 27
PRINT team$(fixture(2, i, week))
NEXT i

DO
LOOP UNTIL INKEY$ = CHR$(13)
18 END SUB

SUB getInfo
f$(1) = "der.txt"
f$(2) = "dur.txt"
f$(3) = "ess.txt"
f$(4) = "gla.txt"
f$(5) = "glo.txt"
f$(6) = "ham.txt"
f$(7) = "kent.txt"
f$(8) = "lan.txt"
f$(9) = "lei.txt"
f$(10) = "mid.txt"
f$(11) = "nor.txt"
f$(12) = "not.txt"
f$(13) = "sco.txt"
f$(14) = "som.txt"
f$(15) = "sur.txt"
f$(16) = "sus.txt"
f$(17) = "war.txt"
f$(18) = "wor.txt"
f$(19) = "yor.txt"

FOR i = 1 TO 19
OPEN f$(i) FOR INPUT AS #1
INPUT #1, team$(i)
INPUT #1, rating(i)
INPUT #1, shirt1(i)
INPUT #1, shirt2(i)
INPUT #1, trousers1(i)
INPUT #1, trousers2(i)
INPUT #1, cs(i)
INPUT #1, wk(i)
INPUT #1, cp(i)
INPUT #1, ob1(i)
INPUT #1, ob2(i)
INPUT #1, overSeas1(i)
INPUT #1, overSeas2(i)
FOR j = 1 TO 18
INPUT #1, player$(j, i)
INPUT #1, gb(j, i)
INPUT #1, rs(j, i)
INPUT #1, wt(j, i)
INPUT #1, eb(j, i)
INPUT #1, ba(j, i)
INPUT #1, fa(j, i)
INPUT #1, bat(j, i)
INPUT #1, bowl(j, i)
INPUT #1, wicketKeeper(j, i)
INPUT #1, peak(j, i)
INPUT #1, international(j, i)
INPUT #1, salary(j, i)
NEXT j
CLOSE
NEXT i

OPEN "fix.txt" FOR INPUT AS #1
FOR i = 1 TO 18
FOR j = 1 TO 9
INPUT #1, fixture(1, j, i)
INPUT #1, fixture(2, j, i)
NEXT j
NEXT i

bat$(1) = "RHB"
bat$(2) = "LHB"
bowl$(1) = "OS"
bowl$(2) = "LS"
bowl$(3) = "RM"
bowl$(4) = "RMF"
bowl$(5) = "RFM"
bowl$(6) = "RF"
bowl$(7) = "LO"
bowl$(8) = "LC"
bowl$(9) = "LM"
bowl$(10) = "LMF"
bowl$(11) = "LFM"
bowl$(12) = "LF"
bowl$(13) = "-"
attribute$(1) = "General Batting "
attribute$(2) = "Run Scoring     "
attribute$(3) = "Wicket Taking   "
attribute$(4) = "Economic Bowling"
attribute$(5) = "Fielding        "
attribute$(6) = "Morale          "
tAttribute$(1) = "General Batting "
tAttribute$(2) = "Run Scoring     "
tAttribute$(3) = "Wicket Taking   "
tAttribute$(4) = "Economic Bowling"
tAttribute$(5) = "Fielding        "
tAttribute$(6) = "Fitness         "

pitch$(1) = "HARD"
pitch$(2) = "NORMAL"
pitch$(3) = "DUSTY"
pitch$(4) = "GREEN"
pitch$(5) = "DAMP"
pr(1) = 1
pr(2) = 0
pr(3) = -1
pr(4) = -1
pr(5) = 0

OPEN "groups.txt" FOR INPUT AS #2
FOR i = 1 TO 9
INPUT #2, groupTeam(i, 1)
NEXT i
FOR i = 1 TO 10
INPUT #2, groupTeam(i, 2)
NEXT i
CLOSE

field$(1) = "Set Attacking Field"
field$(2) = "Set Open Field"
field$(3) = "Set Defensive Field"

career$(1) = "Beginning of Career"
career$(2) = "Nearly at Peak"
career$(3) = "Currently at Peak"
career$(4) = "Just After Peak"
career$(5) = "Toward End of Career"

FOR i = 1 TO 18
ta(i) = 6
ti(i) = 3
NEXT i
money = 20000
END SUB

SUB groupTables
FOR i = 1 TO 19
rank(i) = (15 - i) / 100
NEXT i

FOR k = 1 TO 2
IF k = 1 THEN t = 9 ELSE t = 10
FOR i = 1 TO t
position(groupTeam(i, k)) = 11
FOR j = 1 TO t
IF points(groupTeam(i, k)) + rank(groupTeam(i, k)) >= points(groupTeam(j, k)) + rank(groupTeam(j, k)) THEN position(groupTeam(i, k)) = position(groupTeam(i, k)) - 1
NEXT j
NEXT i
NEXT k


COLOR 11, 0
CLS
LOCATE 2, 3
PRINT name$; "    "; team$(team); "    Week "; week; "  Year "; year
LOCATE 6, 3
PRINT "NATIONAL LEAGUE TABLES"
LOCATE 9, 3
PRINT "DIVISION 1"
LOCATE 11, 3
PRINT "TEAM"
LOCATE 11, 21
PRINT "P"
LOCATE 11, 25
PRINT "W"
LOCATE 11, 29
PRINT "L"
LOCATE 11, 33
PRINT "T"
LOCATE 11, 38
PRINT "PTS"

FOR i = 1 TO 9
IF position(groupTeam(i, 1)) > 7 THEN COLOR 1, 0 ELSE COLOR 3, 0
LOCATE position(groupTeam(i, 1)) + 11, 3
PRINT team$(groupTeam(i, 1))
LOCATE position(groupTeam(i, 1)) + 11, 20
PRINT played(groupTeam(i, 1))
LOCATE position(groupTeam(i, 1)) + 11, 24
PRINT wins(groupTeam(i, 1))
LOCATE position(groupTeam(i, 1)) + 11, 28
PRINT losses(groupTeam(i, 1))
LOCATE position(groupTeam(i, 1)) + 11, 32
PRINT ties(groupTeam(i, 1))
LOCATE position(groupTeam(i, 1)) + 11, 37
PRINT points(groupTeam(i, 1))
NEXT i

COLOR 11, 0
LOCATE 29, 3
PRINT "DIVISION 2"
LOCATE 31, 3
PRINT "TEAM"
LOCATE 31, 21
PRINT "P"
LOCATE 31, 25
PRINT "W"
LOCATE 31, 29
PRINT "L"
LOCATE 31, 33
PRINT "T"
LOCATE 31, 38
PRINT "PTS"

FOR i = 1 TO 10
IF position(groupTeam(i, 2)) > 3 THEN COLOR 1, 0 ELSE COLOR 3, 0
LOCATE position(groupTeam(i, 2)) + 31, 3
PRINT team$(groupTeam(i, 2))
LOCATE position(groupTeam(i, 2)) + 31, 20
PRINT played(groupTeam(i, 2))
LOCATE position(groupTeam(i, 2)) + 31, 24
PRINT wins(groupTeam(i, 2))
LOCATE position(groupTeam(i, 2)) + 31, 28
PRINT losses(groupTeam(i, 2))
LOCATE position(groupTeam(i, 2)) + 31, 32
PRINT ties(groupTeam(i, 2))
LOCATE position(groupTeam(i, 2)) + 31, 37
PRINT points(groupTeam(i, 2))
NEXT i

DO
LOOP UNTIL INKEY$ = CHR$(13)
END SUB

SUB loadGame
12 COLOR 11, 0
CLS
LOCATE 2, 5
PRINT "LOAD GAME"
oss = 1

1060 FOR i = 1 TO 5
IF oss = i THEN COLOR 0, 3 ELSE COLOR 3, 0
LOCATE (i * 2 + 6), 5
PRINT "LOAD GAME FROM FILE "; i
NEXT i

1050 SELECT CASE INKEY$
CASE IS = u$
oss = oss - 1
IF oss < 1 THEN oss = 5
GOTO 1060
CASE IS = d$
oss = oss + 1
IF oss > 5 THEN oss = 1
GOTO 1060
CASE IS = CHR$(13)
CASE ELSE
GOTO 1050
END SELECT

SELECT CASE oss
CASE IS = 6
CASE ELSE
IF oss = 1 THEN fi$ = "file1.txt"
IF oss = 2 THEN fi$ = "file2.txt"
IF oss = 3 THEN fi$ = "file3.txt"
IF oss = 4 THEN fi$ = "file4.txt"
IF oss = 5 THEN fi$ = "file5.txt"

gls = 0
OPEN fi$ FOR INPUT AS #1
INPUT #1, team
IF team = 20 THEN GOTO 11
INPUT #1, name$
INPUT #1, week
INPUT #1, year
INPUT #1, fansRating
INPUT #1, directorsRating
FOR i = 1 TO 18
INPUT #1, sm(i)
INPUT #1, sInnings(i)
INPUT #1, sRuns(i)
INPUT #1, sOuts(i)
INPUT #1, hs(i)
INPUT #1, sBalls(i)
INPUT #1, sOvers(i)
INPUT #1, sWickets(i)
INPUT #1, sConceded(i)
INPUT #1, bbw(i)
INPUT #1, bbr(i)
INPUT #1, iWeeks(i)
INPUT #1, duty(i)
INPUT #1, morale(i)
NEXT i
FOR i = 1 TO 19
INPUT #1, team$(i)
INPUT #1, rating(i)
INPUT #1, shirt1(i)
INPUT #1, shirt2(i)
INPUT #1, trousers1(i)
INPUT #1, trousers2(i)
INPUT #1, cs(i)
INPUT #1, wk(i)
INPUT #1, cp(i)
INPUT #1, ob1(i)
INPUT #1, ob2(i)
INPUT #1, overSeas1(i)
INPUT #1, overSeas2(i)
FOR j = 1 TO 18
INPUT #1, player$(j, i)
INPUT #1, gb(j, i)
INPUT #1, rs(j, i)
INPUT #1, wt(j, i)
INPUT #1, eb(j, i)
INPUT #1, ba(j, i)
INPUT #1, fa(j, i)
INPUT #1, bat(j, i)
INPUT #1, bowl(j, i)
INPUT #1, wicketKeeper(j, i)
INPUT #1, peak(j, i)
INPUT #1, international(j, i)
INPUT #1, salary(j, i)
NEXT j
INPUT #1, points(i)
INPUT #1, wins(i)
INPUT #1, ties(i)
INPUT #1, losses(i)
INPUT #1, played(i)
NEXT i
CLOSE
gls = 1
11 SELECT CASE gls
CASE IS = 1
COLOR 11, 0
CLS
LOCATE 20, 20
PRINT "GAME LOADED SUCCESFULLY FROM FILE "; oss
DO
LOOP UNTIL INKEY$ = CHR$(13)
CASE ELSE
CLOSE
COLOR 11, 0
CLS
LOCATE 20, 20
PRINT "NO SAVED GAME IN FILE "; oss
DO
LOOP UNTIL INKEY$ = CHR$(13)
GOTO 12
END SELECT
END SELECT
END SUB

SUB managerInfo
COLOR 11, 0
CLS
LOCATE 2, 5
PRINT name$; "    "; team$(team); "    Week "; week; "  Year "; year

COLOR 3, 0
LOCATE 8, 5
PRINT "MANAGER'S NAME    :  "; name$
LOCATE 10, 5
PRINT "CLUB MANAGED      :  "; team$(team)
LOCATE 12, 5
PRINT "WEEK'S AT CLUB    : "; week
LOCATE 16, 5
PRINT "DIRECTOR'S RATING :"
LOCATE 18, 5
PRINT "FANS RATING       :"

FOR i = 1 TO 50
SELECT CASE directorsRating
CASE IS > (i * 2 - 1)
COLOR 1, 0
LOCATE 16, i + 25
PRINT CHR$(219)
CASE IS = (i * 2 - 1)
COLOR 1, 0
LOCATE 16, i + 25
PRINT CHR$(221)
CASE ELSE
COLOR 3, 0
LOCATE 16, i + 25
PRINT CHR$(196)
END SELECT
NEXT i

FOR i = 1 TO 50
SELECT CASE fansRating
CASE IS > (i * 2 - 1)
COLOR 1, 0
LOCATE 18, i + 25
PRINT CHR$(219)
CASE IS = (i * 2 - 1)
COLOR 1, 0
LOCATE 18, i + 25
PRINT CHR$(219)
CASE ELSE
COLOR 3, 0
LOCATE 18, i + 25
PRINT CHR$(196)
END SELECT
NEXT i


DO
LOOP UNTIL INKEY$ = CHR$(13)
END SUB

SUB manhattan
COLOR 11, 0
CLS
LOCATE 2, 3
PRINT team$(battingSide); " INNINGS MANHATTAN GRAPH"
FOR i = 1 TO 50
mgcc = mgcc + 1
IF mgcc = 3 THEN mgcc = 1
FOR j = 1 TO 30
COLOR 11, 0
LOCATE (41 - j), 3
IF j = 2 OR j = 4 OR j = 6 OR j = 8 OR j = 10 OR j = 12 OR j = 14 OR j = 16 OR j = 18 OR j = 20 THEN PRINT j
IF mgcc = 1 THEN COLOR 11, 0 ELSE COLOR 3, 0
LOCATE (41 - j), i + 6
IF rpo(i, battingSide) >= j THEN PRINT CHR$(219)
NEXT j
NEXT i
DO
LOOP UNTIL INKEY$ = CHR$(13)
END SUB

SUB matchDay
IF week = 19 THEN CALL endOfSeason
SELECT CASE gt
CASE IS = 1
gt = 0
GOTO 170
END SELECT

FOR i = 1 TO 9
IF fixture(1, i, week) = team OR fixture(2, i, week) = team THEN match = i
NEXT i

IF match > 0 THEN GOTO 410
COLOR 11, 0
CLS
LOCATE 1, 3
PRINT "MATCHDAY:"
COLOR 3, 0
LOCATE 16, 3
PRINT team$(team); " DO NOT HAVE A FIXTURE FOR TODAY..."
DO
LOOP UNTIL INKEY$ = CHR$(13)
GOTO 420

410 COLOR 11, 0
CLS
LOCATE 1, 22
PRINT "MATCHDAY:"

COLOR shirt1(fixture(1, match, week)), 0
FOR i = 8 TO 17
FOR j = 24 TO 32
LOCATE i, j
PRINT CHR$(219)
NEXT j
NEXT i
COLOR shirt2(fixture(1, match, week)), 6
LOCATE 12, 26
PRINT CHR$(219); CHR$(219); CHR$(219); CHR$(219); CHR$(219)
LOCATE 8, 28
PRINT CHR$(219)
FOR i = 8 TO 14
FOR j = 22 TO 23
LOCATE i, j
PRINT CHR$(219)
NEXT j
FOR j = 33 TO 34
LOCATE i, j
PRINT CHR$(219)
NEXT j
NEXT i

COLOR trousers1(fixture(1, match, week)), 0
FOR i = 18 TO 28
FOR j = 24 TO 32
IF i > 20 AND j > 27 AND j < 29 THEN GOTO 80
LOCATE i, j
PRINT CHR$(219)
80 NEXT j
NEXT i

SELECT CASE cs(fixture(1, match, week))
CASE IS = 1
COLOR trousers2(fixture(1, match, week)), trousers1(fixture(1, match, week))
FOR i = 18 TO 28
LOCATE i, 24
PRINT CHR$(221)
LOCATE i, 32
PRINT CHR$(222)
NEXT i
CASE IS = 2
COLOR trousers1(fixture(1, match, week)), trousers2(fixture(1, match, week))
FOR i = 18 TO 28
LOCATE i, 24
PRINT CHR$(222)
LOCATE i, 32
PRINT CHR$(221)
NEXT i
END SELECT

COLOR 11, 0
LOCATE 14, 38
PRINT "V"

COLOR shirt1(fixture(2, match, week)), 0
FOR i = 8 TO 17
FOR j = 44 TO 52
LOCATE i, j
PRINT CHR$(219)
NEXT j
NEXT i
COLOR shirt2(fixture(2, match, week)), 0
LOCATE 12, 46
PRINT CHR$(219); CHR$(219); CHR$(219); CHR$(219); CHR$(219)
LOCATE 8, 48
PRINT CHR$(219)
FOR i = 8 TO 14
FOR j = 42 TO 43
LOCATE i, j
PRINT CHR$(219)
NEXT j
FOR j = 53 TO 54
LOCATE i, j
PRINT CHR$(219)
NEXT j
NEXT i

COLOR trousers1(fixture(2, match, week)), 0
FOR i = 18 TO 28
FOR j = 44 TO 52
IF i > 20 AND j > 47 AND j < 49 THEN GOTO 90
LOCATE i, j
PRINT CHR$(219)
90 NEXT j
NEXT i

SELECT CASE cs(fixture(2, match, week))
CASE IS = 1
COLOR trousers2(fixture(2, match, week)), trousers1(fixture(2, match, week))
FOR i = 18 TO 28
LOCATE i, 44
PRINT CHR$(221)
LOCATE i, 52
PRINT CHR$(222)
NEXT i
CASE IS = 2
COLOR trousers1(fixture(2, match, week)), trousers2(fixture(2, match, week))
FOR i = 18 TO 28
LOCATE i, 44
PRINT CHR$(222)
LOCATE i, 52
PRINT CHR$(221)
NEXT i
END SELECT

pitch = rand(5)
COLOR 3, 0
LOCATE 36, 22
PRINT team$(fixture(1, match, week)); "  V  "; team$(fixture(2, match, week))
LOCATE 38, 22
PRINT "PITCH TYPE: "; pitch$(pitch)
LOCATE 40, 22
PRINT "Press RETURN to go to the match..."
DO
LOOP UNTIL INKEY$ = CHR$(13)

COLOR 11, 0
CLS
LOCATE 3, 22
PRINT "MATCHDAY:"
LOCATE 12, 22
PRINT "COIN TOSS: "; team$(team); " TO CALL"
tc = 1

110 LOCATE 14, 22
IF tc = 1 THEN COLOR 0, 3 ELSE COLOR 3, 0
PRINT "HEADS"
LOCATE 16, 22
IF tc = 2 THEN COLOR 0, 3 ELSE COLOR 3, 0
PRINT "TAILS"

100 SELECT CASE INKEY$
CASE IS = u$
tc = tc - 1
IF tc < 1 THEN tc = 2
GOTO 110
CASE IS = d$
tc = tc + 1
IF tc > 2 THEN tc = 1
GOTO 110
CASE IS = CHR$(13)
CASE ELSE
GOTO 100
END SELECT

IF coinCheat = 1 THEN result = 2 ELSE result = rand(2)
SELECT CASE result
CASE IS = 1
SELECT CASE pitch
CASE IS = 1
cc = 2
CASE IS = 2
cc = rand(2)
CASE IS = 3
cc = 1
CASE IS = 4
cc = 1
CASE IS = 5
cc = rand(2)
END SELECT
COLOR 11, 0
LOCATE 20, 22
IF cc = 1 THEN PRINT "YOU HAVE LOST THE COIN TOSS - YOU WILL BAT FIRST"
IF cc = 2 THEN PRINT "YOU HAVE LOST THE COIN TOSS - YOU WILL FIELD FIRST"
DO
LOOP UNTIL INKEY$ = CHR$(13)
CASE ELSE

LOCATE 22, 22
COLOR 11, 0
PRINT "YOU HAVE WON THE TOSS"
COLOR 3, 0
tc = 1

130 LOCATE 24, 22
IF tc = 1 THEN COLOR 0, 3 ELSE COLOR 3, 0
PRINT "BAT FIRST"
LOCATE 26, 22
IF tc = 2 THEN COLOR 0, 3 ELSE COLOR 3, 0
PRINT "FIELD FIRST"

120 SELECT CASE INKEY$
CASE IS = u$
tc = tc - 1
IF tc < 1 THEN tc = 2
GOTO 130
CASE IS = d$
tc = tc + 1
IF tc > 2 THEN tc = 1
GOTO 130
CASE IS = CHR$(13)
CASE ELSE
GOTO 120
END SELECT
cc = tc
END SELECT

IF fixture(1, match, week) = team THEN opponents = fixture(2, match, week)
IF fixture(2, match, week) = team THEN opponents = fixture(1, match, week)

FOR i = 1 TO 50
rpo(i, 1) = 0
rpo(i, 2) = 0
NEXT i

ft = 1
truns(team) = 0
tWickets(team) = 0
tovers(team) = 0
tBalls(team) = 0
bowlers(team) = 0
FOR i = 1 TO 10
bowlChange(i, team) = 0
NEXT i
FOR j = 1 TO 11
IF j = 1 OR j = 2 THEN in(j, team) = 1 ELSE in(j, team) = 2
runs(j, team) = 0
balls(j, team) = 0
howOut1$(j, team) = ""
howOut2$(j, team) = ""
howOut3$(j, team) = ""
howOut4$(j, team) = ""
o(j, team) = 0
b(j, team) = 0
m(j, team) = 0
w(j, team) = 0
r(j, team) = 0
fatigue(j, team) = 10
NEXT j
extras(team) = 0
wides(team) = 0
noBalls(team) = 0
legByes(team) = 0
byes(team) = 0

truns(opponents) = 0
tWickets(opponents) = 0
tovers(opponents) = 0
tBalls(opponents) = 0
bowlers(opponents) = 0
FOR i = 1 TO 10
bowlChange(i, opponents) = 0
NEXT i
FOR j = 1 TO 11
IF j = 1 OR j = 2 THEN in(j, opponents) = 1 ELSE in(j, opponents) = 2
runs(j, opponents) = 0
balls(j, opponents) = 0
howOut1$(j, opponents) = ""
howOut2$(j, opponents) = ""
howOut3$(j, opponents) = ""
howOut4$(j, opponents) = ""
o(j, opponents) = 0
m(j, opponents) = 0
w(j, opponents) = 0
r(j, opponents) = 0
fatigue(j, opponents) = 10
NEXT j
extras(opponents) = 0
wides(opponents) = 0
noBalls(opponents) = 0
legByes(opponents) = 0
byes(opponents) = 0

FOR innings = 1 TO 2
retain = 3
mindset = 2
SELECT CASE innings
CASE IS = 1
IF cc = 1 THEN batSide = team ELSE batSide = opponents
IF cc = 1 THEN bowlSide = opponents ELSE bowlSide = team
CASE IS = 2
neitherSide = batSide
batSide = bowlSide
bowlSide = neitherSide
END SELECT

finish = 0
bat1 = 1
bat2 = 2
bowler = ob1(bowlSide)
lbowler = ob2(bowlSide)
strike = 1
menu = 1

overBalls = 0
IF innings = 1 THEN hours = 11 ELSE hours = 14
IF innings = 1 THEN minutes = 0 ELSE minutes = 20
FOR j = 1 TO 11
NEXT j
FOR j = 1 TO 8
ball$(j) = ""
NEXT j

DO
170 COLOR 11, 0
CLS
SELECT CASE tBalls(batSide)
CASE IS = 6
IF innings = 1 THEN rpo(tovers(batSide), 1) = truns(batSide) - rbo
IF innings = 2 THEN rpo(tovers(batSide), 2) = truns(batSide) - rbo
rbo = truns(batSide)
fatigue(bowler, bowlSide) = fatigue(bowler, bowlSide) - 2
fatigue(lbowler, bowlSide) = fatigue(lbowler, bowlSide) - 1
FOR E = 1 TO 11
fatigue(E, bowlSide) = fatigue(E, bowlSide) + 1
IF fatigue(E, bowlSide) < 2 THEN fatigue(E, bowlSide) = 2
IF fatigue(E, bowlSide) > 10 THEN fatigue(E, bowlSide) = 10
NEXT E
overBouncers = 0
tovers(batSide) = tovers(batSide) + 1
tBalls(batSide) = 0
strike = strike + 1
IF strike = 3 THEN strike = 1
overExtras = 0
IF r(bowler, bowlSide) = pr THEN m(bowler, bowlSide) = m(bowler, bowlSide) + 1
o(bowler, bowlSide) = o(bowler, bowlSide) + 1
b(bowler, bowlSide) = 0

SELECT CASE bowlSide
CASE IS = team
cbowler = bowler
bowler = lbowler
lbowler = cbowler


CASE IS = opponents
change = 0
IF rand(4) = 1 THEN change = 1
IF tovers(batSide) < 9 THEN change = 0
IF o(lbowler, bowlSide) >= 9 THEN change = 1
IF fatigue(lbowler, bowlSide) < 4 THEN change = 1

SELECT CASE change
CASE IS = 0
cbowler = bowler
bowler = lbowler
lbowler = cbowler

CASE ELSE
cb(1, bowlSide) = ba(1, bowlSide)
cb(2, bowlSide) = ba(1, bowlSide) + ba(2, bowlSide)
cb(3, bowlSide) = ba(1, bowlSide) + ba(2, bowlSide) + ba(3, bowlSide)
cb(4, bowlSide) = ba(1, bowlSide) + ba(2, bowlSide) + ba(3, bowlSide) + ba(4, bowlSide)
cb(5, bowlSide) = ba(1, bowlSide) + ba(2, bowlSide) + ba(3, bowlSide) + ba(4, bowlSide) + ba(5, bowlSide)
cb(6, bowlSide) = ba(1, bowlSide) + ba(2, bowlSide) + ba(3, bowlSide) + ba(4, bowlSide) + ba(5, bowlSide) + ba(6, bowlSide)
cb(7, bowlSide) = ba(1, bowlSide) + ba(2, bowlSide) + ba(3, bowlSide) + ba(4, bowlSide) + ba(5, bowlSide) + ba(6, bowlSide) + ba(7, bowlSide)
cb(8, bowlSide) = ba(1, bowlSide) + ba(2, bowlSide) + ba(3, bowlSide) + ba(4, bowlSide) + ba(5, bowlSide) + ba(6, bowlSide) + ba(7, bowlSide) + ba(8, bowlSide)
cb(9, bowlSide) = ba(1, bowlSide) + ba(2, bowlSide) + ba(3, bowlSide) + ba(4, bowlSide) + ba(5, bowlSide) + ba(6, bowlSide) + ba(7, bowlSide) + ba(8, bowlSide) + ba(9, bowlSide)
cb(10, bowlSide) = ba(1, bowlSide) + ba(2, bowlSide) + ba(3, bowlSide) + ba(4, bowlSide) + ba(5, bowlSide) + ba(6, bowlSide) + ba(7, bowlSide) + ba(8, bowlSide) + ba(9, bowlSide) + ba(10, bowlSide)
cb(11, bowlSide) = ba(1, bowlSide) + ba(2, bowlSide) + ba(3, bowlSide) + ba(4, bowlSide) + ba(5, bowlSide) + ba(6, bowlSide) + ba(7, bowlSide) + ba(8, bowlSide) + ba(9, bowlSide) + ba(10, bowlSide) + ba(11, bowlSide)

tcb = 0
FOR k = 1 TO 11
tcb = tcb + ba(k, bowlSide)
NEXT k

lbowler = bowler
240 rtcb = rand(tcb)

SELECT CASE rtcb
CASE 0 TO cb(1, bowlSide)
bowler = 1
CASE cb(1, bowlSide) TO cb(2, bowlSide)
bowler = 2
CASE cb(2, bowlSide) TO cb(3, bowlSide)
bowler = 3
CASE cb(3, bowlSide) TO cb(4, bowlSide)
bowler = 4
CASE cb(4, bowlSide) TO cb(5, bowlSide)
bowler = 5
CASE cb(5, bowlSide) TO cb(6, bowlSide)
bowler = 6
CASE cb(6, bowlSide) TO cb(7, bowlSide)
bowler = 7
CASE cb(7, bowlSide) TO cb(8, bowlSide)
bowler = 8
CASE cb(8, bowlSide) TO cb(9, bowlSide)
bowler = 9
CASE cb(9, bowlSide) TO cb(10, bowlSide)
bowler = 10
CASE cb(10, bowlSide) TO cb(11, bowlSide)
bowler = 11
END SELECT
IF o(bowler, bowlSide) >= 9 THEN GOTO 240
IF bowler = lbowler THEN GOTO 240
END SELECT
END SELECT

pr = r(bowler, bowlSide)
END SELECT

270 COLOR 11, 0
LOCATE 2, 4
PRINT team$(batSide)
LOCATE 3, 3
PRINT truns(batSide); "-"; tWickets(batSide); " ("; tovers(batSide); "."; tBalls(batSide); ")"
COLOR 3, 0
LOCATE 5, 4
PRINT player$(bat1, batSide)
LOCATE 5, 20
PRINT runs(bat1, batSide)
LOCATE 5, 25
PRINT "("; balls(bat1, batSide); ")"
LOCATE 7, 4
PRINT player$(bat2, batSide)
LOCATE 7, 20
PRINT runs(bat2, batSide)
LOCATE 7, 25
PRINT "("; balls(bat2, batSide); ")"
IF strike = 1 THEN LOCATE 5, 2 ELSE LOCATE 7, 2
PRINT "*"
COLOR 3, 0
LOCATE 10, 4
PRINT "Extras: "; extras(batSide); " (w"; wides(batSide); ", nb"; noBalls(batSide); ", b"; byes(batSide); ", lb"; legByes(batSide); ")"
LOCATE 10, 55
PRINT "Last Delivery:"
COLOR 0, 3
LOCATE 10, 70
IF overBalls = 0 AND tovers(batSide) = 0 THEN PRINT "      mph" ELSE PRINT speed(overBalls); "mph"

COLOR 3, 0
FOR j = 1 TO 9
LOCATE j, 39
PRINT CHR$(179)
NEXT j
FOR j = 12 TO 28
LOCATE j, 26
PRINT CHR$(179)
NEXT j

FOR j = 1 TO 80
LOCATE 9, j
PRINT CHR$(196)
LOCATE 11, j
PRINT CHR$(196)
LOCATE 29, j
PRINT CHR$(196)
LOCATE 44, j
PRINT CHR$(196)
NEXT j

COLOR 11, 0
LOCATE 2, 43
PRINT team$(bowlSide)
COLOR 3, 0
LOCATE 5, 41
PRINT "*"
LOCATE 5, 43
PRINT player$(bowler, bowlSide)
LOCATE 5, 59
PRINT o(bowler, bowlSide); "."; b(bowler, bowlSide); "-"; m(bowler, bowlSide); "-"; r(bowler, bowlSide); "-"; w(bowler, bowlSide)
LOCATE 7, 43
PRINT player$(lbowler, bowlSide)
LOCATE 7, 59
PRINT o(lbowler, bowlSide); "."; b(lbowler, bowlSide); "-"; m(lbowler, bowlSide); "-"; r(lbowler, bowlSide); "-"; w(lbowler, bowlSide)

FOR i = 1 TO 8
IF overBalls < i THEN GOTO 140
LOCATE 11 + (i * 2), 4
COLOR 7, 4
PRINT i
LOCATE 11 + (i * 2), 10
COLOR 3, 0
PRINT ball$(i)
140 NEXT i

tb = (tovers(batSide) * 6) + tBalls(batSide)
IF truns(batSide) = 0 OR tb = 0 THEN GOTO 230
runRate = truns(batSide) / tb
runRate = runRate * 6
runRate = INT(runRate * 100)
runRate = runRate / 100
           
230 LOCATE 14, 29
PRINT team$(fixture(1, match, week)); "    V    "; team$(fixture(2, match, week))
LOCATE 16, 29
PRINT "PITCH TYPE: "; pitch$(pitch)
LOCATE 18, 29
SELECT CASE innings
CASE IS = 1
PRINT team$(batSide); " LEAD BY "; truns(batSide); " RUNS"
CASE ELSE
PRINT team$(batSide); " REQUIRE "; (truns(bowlSide) + 1) - truns(batSide); " MORE RUNS TO WIN"
END SELECT

LOCATE 20, 29
PRINT "CURRENT RUN RATE: "; runRate
LOCATE 23, 29
SELECT CASE strike
CASE IS = 1
PRINT player$(bowler, bowlSide); " ("; bowl$(bowl(bowler, bowlSide)); ") "; CHR$(16); "  "; player$(bat1, batSide); " ("; bat$(bat(bat1, batSide)); ")"
CASE IS = 2
PRINT player$(bowler, bowlSide); " ("; bowl$(bowl(bowler, bowlSide)); ") "; CHR$(16); "  "; player$(bat2, batSide); " ("; bat$(bat(bat2, batSide)); ")"
END SELECT
LOCATE 25, 29
SELECT CASE minutes
CASE IS = 0
PRINT "TIME: "; hours; ": 00"
CASE IS = 1
PRINT "TIME: "; hours; ": 01"
CASE IS = 2
PRINT "TIME: "; hours; ": 02"
CASE IS = 3
PRINT "TIME: "; hours; ": 03"
CASE IS = 4
PRINT "TIME: "; hours; ": 04"
CASE IS = 5
PRINT "TIME: "; hours; ": 05"
CASE IS = 6
PRINT "TIME: "; hours; ": 06"
CASE IS = 7
PRINT "TIME: "; hours; ": 07"
CASE IS = 8
PRINT "TIME: "; hours; ": 08"
CASE IS = 9
PRINT "TIME: "; hours; ": 09"
CASE ELSE
PRINT "TIME: "; hours; ":"; minutes
END SELECT

330 SELECT CASE team
CASE IS = bowlSide
COLOR 11, 0
LOCATE 31, 5
PRINT "Bowler:   "; player$(bowler, bowlSide); " ("; bowl$(bowl(bowler, bowlSide)); ")"
LOCATE 31, 50
COLOR 3, 0
PRINT "Fatigue:"
FOR i = 1 TO 10
LOCATE 31, 58 + i
IF fatigue(bowler, bowlSide) >= i THEN PRINT CHR$(219)
NEXT i
COLOR 11, 0
LOCATE 42, 5
PRINT "Press "; CHR$(34); "C"; CHR$(34); " at the end of any over to change bowler."

FOR i = 1 TO 3
IF i = 3 AND tovers(batSide) < 15 THEN COLOR 8, 0 ELSE COLOR 3, 0
LOCATE (i * 2 + 32), 5
PRINT field$(i)
LOCATE (i * 2 + 32), 3
IF ft = i THEN PRINT CHR$(16) ELSE PRINT " "
NEXT i

SELECT CASE tovers(batSide)
CASE 0 TO 5
IF tWickets(batSide) = 0 THEN mindset = 2 ELSE mindset = 1
CASE 6 TO 10
IF tWickets(batSide) < 2 THEN mindset = 3
IF tWickets(batSide) = 2 THEN mindset = 2
IF tWickets(batSide) > 2 THEN mindset = 1
CASE 11 TO 16
IF tWickets(batSide) < 4 THEN mindset = 3 ELSE mindset = 2
CASE 17 TO 25
IF tWickets(batSide) < 6 THEN mindset = 3 ELSE mindset = 2
IF tWickets(batSide) < 3 THEN mindset = 4
IF tWickets(batSide) < 2 THEN mindset = 5
CASE 26 TO 30
IF tWickets(batSide) < 7 THEN mindset = 3 ELSE mindset = 2
IF tWickets(batSide) < 4 THEN mindset = 4
IF tWickets(batSide) < 3 THEN mindset = 5
CASE 31 TO 37
IF tWickets(batSide) < 6 THEN mindset = 5 ELSE mindset = 4
CASE 38 TO 45
mindset = 5
END SELECT

CASE ELSE
COLOR 11, 0
LOCATE 31, 5
PRINT "Batsmen:   "; player$(bat1, batSide); " ("; bat$(bat(bat1, batSide)); ")   &   "; player$(bat2, batSide); " ("; bat$(bat(bat2, batSide)); ")"
COLOR 3, 0
LOCATE 34, 5
PRINT "Very Defensive"
LOCATE 36, 5
PRINT "Defensive"
LOCATE 38, 5
PRINT "Moderate"
LOCATE 40, 5
PRINT "Aggressive"
LOCATE 42, 5
PRINT "Very Aggressive"
FOR i = 1 TO 5
LOCATE 32 + (i * 2), 3
IF mindset <> i THEN PRINT " " ELSE PRINT CHR$(16)
NEXT i
LOCATE 42, 30
COLOR 11, 0
PRINT "Press "; CHR$(34); "C"; CHR$(34); " at any time to change batting order."
END SELECT

LOCATE 48, 27
COLOR 0, 3
PRINT "       MAIN MENU       "
LOCATE 48, 4
COLOR 3, 0
PRINT "   BATTING SCORECARD   "
LOCATE 48, 50
COLOR 3, 0
PRINT "    BOWLING FIGURES    "
COLOR 0, 3
LOCATE 46, 37
PRINT CHR$(17); " "; CHR$(16)

IF tovers(batSide) = 45 THEN finish = 1
IF tWickets(batSide) = 10 THEN finish = 2
IF truns(batSide) > truns(bowlSide) AND innings = 2 THEN finish = 3
IF finish = 0 THEN GOTO 310

COLOR 11, 0
LOCATE 50, 2
SELECT CASE innings
CASE IS = 1
PRINT team$(bowlSide); " REQUIRE "; truns(batSide) + 1; " RUNS TO WIN. PRESS SPACE TO GO THE NEXT INNINGS."
CASE IS = 2
IF truns(batSide) > truns(bowlSide) THEN PRINT team$(batSide); " BEAT "; team$(bowlSide); " BY "; 10 - tWickets(batSide); " WICKETS. PRESS SPACE TO CONTINUE."
IF truns(batSide) < truns(bowlSide) THEN PRINT team$(bowlSide); " BEAT "; team$(batSide); " BY "; truns(bowlSide) - truns(batSide); " RUNS. PRESS SPACE TO CONTINUE."
IF truns(batSide) = truns(bowlSide) THEN PRINT team$(batSide); " TIED WITH "; team$(bowlSide); ". PRESS SPACE TO CONTINUE."
END SELECT

310 lastSub = 1
160 SELECT CASE INKEY$
CASE IS = u$
IF finish > 0 THEN GOTO 310
IF batSide = team THEN mindset = mindset - 1 ELSE ft = ft - 1
IF tovers(batSide) < 15 AND ft < 1 THEN ft = 2
IF tovers(batSide) >= 15 AND ft < 1 THEN ft = 3
IF mindset < 1 THEN mindset = 5
GOTO 330
CASE IS = d$
IF finish > 0 THEN GOTO 310
IF batSide = team THEN mindset = mindset + 1 ELSE ft = ft + 1
IF ft = 3 AND tovers(batSide) < 15 THEN ft = 1
IF ft > 3 THEN ft = 1
IF mindset > 5 THEN mindset = 1
GOTO 330
CASE IS = l$
CALL scorecard
GOTO 170
CASE IS = r$
CALL figures
GOTO 170
CASE IS = "C"
IF finish > 0 THEN GOTO 160
IF bowlSide = team AND tBalls(batSide) = 0 AND overBalls <> 1 AND overBalls <> 2 THEN CALL changeBowler
IF batSide = team THEN CALL batOrder
GOTO 270
CASE IS = "c"
IF finish > 0 THEN GOTO 160
IF bowlSide = team AND tBalls(batSide) = 0 AND overBalls <> 1 AND overBalls <> 2 THEN CALL changeBowler
IF batSide = team THEN CALL batOrder
GOTO 270
CASE IS = CHR$(13)
IF finish > 0 THEN GOTO 160
IF tovers(batSide) >= 50 THEN GOTO 290
IF team = bowlSide AND o(bowler, bowlSide) >= 9 THEN GOTO 160
290
CASE IS = CHR$(32)
IF finish = 0 THEN GOTO 160
CASE ELSE
GOTO 160
END SELECT

IF finish > 0 THEN GOTO 300
REM _________________________________________________________________________

IF tBalls(batSide) <> 0 THEN GOTO 200
IF overBalls <= 5 THEN GOTO 200
overBalls = 0
FOR j = 1 TO 8
ball$(j) = ""
NEXT j
FOR j = 1 TO 8
speed(j) = 0
NEXT j

200 totals = 0
total1 = 100 - eb(bowler, bowlSide)
IF strike = 1 THEN total2 = rs(bat1, batSide)
IF strike = 2 THEN total2 = rs(bat2, batSide)
totals = total1 + total2
totals = INT(totals / 10)

IF strike = 1 THEN wtotal1 = 100 - (gb(bat1, batSide))
IF strike = 2 THEN wtotal1 = 100 - (gb(bat2, batSide))
wtotal2 = wt(bowler, bowlSide)
wtotals = wtotal1 + wtotal2
chance = INT(83 - (wtotals / 2.5))
IF bowl(bowler, bowlSide) = 1 OR bowl(bowler, bowlSide) = 2 OR bowl(bowler, bowlSide) = 7 OR bowl(bowler, bowlSide) = 8 THEN spinner = 1

IF tovers(batSide) < 10 AND spinner = 1 THEN chance = chance + 2
SELECT CASE mindset
CASE IS = 1
chance = INT(chance * 1.3)
totals = totals - 3
CASE IS = 2
chance = INT(chance * 1.15)
totals = totals - 1
CASE IS = 4
chance = INT(chance * .85)
totals = totals + 1
CASE IS = 5
chance = INT(chance * .7)
totals = totals + 3
END SELECT

IF fatigue(bowler, bowlSide) < 5 THEN chance = chance + (7 - fatigue(bowler, bowlSide))
aa = 5
bb = 6
cc = 7
dd = 20 + totals
ee = 22 + totals + totals
tt = rand(100)

SELECT CASE rand(chance)
CASE IS = 1
tBalls(batSide) = tBalls(batSide) + 1
b(bowler, bowlSide) = b(bowler, bowlSide) + 1
IF strike = 1 THEN balls(bat1, batSide) = balls(bat1, batSide) + 1 ELSE balls(bat2, batSide) = balls(bat2, batSide) + 1
tWickets(batSide) = tWickets(batSide) + 1
fow(tWickets(batSide), batSide) = truns(batSide)

IF bowl(bowler, bowlSide) = 1 OR bowl(bowler, bowlSide) = 2 OR bowl(bowler, bowlSide) = 7 OR bowl(bowler, bowlSide) = 8 THEN howOut = rand(22) ELSE howOut = rand(20)
SELECT CASE howOut
CASE IS <= 11
IF strike = 1 THEN howOut1$(bat1, batSide) = "c" ELSE howOut1$(bat2, batSide) = "c"
catch = rand(11)
IF catch = bowler THEN catch = wk(bowlSide)
IF strike = 1 THEN howOut2$(bat1, batSide) = player$(catch, bowlSide) ELSE howOut2$(bat2, batSide) = player$(catch, bowlSide)
IF strike = 1 THEN howOut3$(bat1, batSide) = "b" ELSE howOut3$(bat2, batSide) = "b"
IF strike = 1 THEN howOut4$(bat1, batSide) = player$(bowler, bowlSide) ELSE howOut4$(bat2, batSide) = player$(bowler, bowlSide)
ball$(overBalls + 1) = "WICKET - CAUGHT"
w(bowler, bowlSide) = w(bowler, bowlSide) + 1
CASE 12 TO 16
IF strike = 1 THEN howOut3$(bat1, batSide) = "b" ELSE howOut3$(bat2, batSide) = "b"
IF strike = 1 THEN howOut4$(bat1, batSide) = player$(bowler, bowlSide) ELSE howOut4$(bat2, batSide) = player$(bowler, bowlSide)
ball$(overBalls + 1) = "WICKET - BOWLED"
w(bowler, bowlSide) = w(bowler, bowlSide) + 1
CASE 17 TO 19
IF strike = 1 THEN howOut1$(bat1, batSide) = "lbw" ELSE howOut1$(bat2, batSide) = "lbw"
IF strike = 1 THEN howOut3$(bat1, batSide) = "b" ELSE howOut3$(bat2, batSide) = "b"
IF strike = 1 THEN howOut4$(bat1, batSide) = player$(bowler, bowlSide) ELSE howOut4$(bat2, batSide) = player$(bowler, bowlSide)
ball$(overBalls + 1) = "WICKET - LBW"
w(bowler, bowlSide) = w(bowler, bowlSide) + 1
CASE IS = 20
IF strike = 1 THEN howOut1$(bat1, batSide) = "run out" ELSE howOut1$(bat2, batSide) = "run out"
ball$(overBalls + 1) = "WICKET - RUN OUT"
CASE ELSE
IF strike = 1 THEN howOut1$(bat1, batSide) = "st" ELSE howOut1$(bat2, batSide) = "st"
IF strike = 1 THEN howOut2$(bat1, batSide) = player$(wk(bowlSide), bowlSide) ELSE howOut2$(bat2, batSide) = player$(wk(bowlSide), bowlSide)
IF strike = 1 THEN howOut3$(bat1, batSide) = "b" ELSE howOut3$(bat2, batSide) = "b"
IF strike = 1 THEN howOut4$(bat1, batSide) = player$(bowler, bowlSide) ELSE howOut4$(bat2, batSide) = player$(bowler, bowlSide)
ball$(overBalls + 1) = "WICKET - STUMPED"
w(bowler, bowlSide) = w(bowler, bowlSide) + 1
END SELECT
IF strike = 1 THEN in(bat1, batSide) = 0
IF strike = 2 THEN in(bat2, batSide) = 0
IF tWickets(batSide) = 10 THEN GOTO 320
IF strike = 1 THEN bat1 = tWickets(batSide) + 2 ELSE bat2 = tWickets(batSide) + 2
IF strike = 1 AND tWickets(batSide) < 10 THEN in(bat1, batSide) = 1
IF strike = 2 AND tWickets(batSide) < 10 THEN in(bat2, batSide) = 1
320 GOTO 150
END SELECT

IF overExtras = 2 THEN GOTO 190
extraChance = rand(130)
SELECT CASE extraChance
CASE IS = 1
truns(batSide) = truns(batSide) + 1
tBalls(batSide) = tBalls(batSide) + 1
b(bowler, bowlSide) = b(bowler, bowlSide) + 1
r(bowler, bowlSide) = r(bowler, bowlSide) + 1
ball$(overBalls + 1) = "ONE LEG-BYE"
IF strike = 1 THEN balls(bat1, batSide) = balls(bat1, batSide) + 1 ELSE balls(bat2, batSide) = balls(bat2, batSide) + 1
IF strike = 1 THEN strike = 2 ELSE strike = 1
extras(batSide) = extras(batSide) + 1
legByes(batSide) = legByes(batSide) + 1
CASE IS = 2
truns(batSide) = truns(batSide) + 1
tBalls(batSide) = tBalls(batSide) + 1
b(bowler, bowlSide) = b(bowler, bowlSide) + 1
ball$(overBalls + 1) = "ONE BYE"
IF strike = 1 THEN balls(bat1, batSide) = balls(bat1, batSide) + 1 ELSE balls(bat2, batSide) = balls(bat2, batSide) + 1
IF strike = 1 THEN strike = 2 ELSE strike = 1
extras(batSide) = extras(batSide) + 1
byes(batSide) = byes(batSide) + 1
CASE IS = 3
truns(batSide) = truns(batSide) + 1
r(bowler, bowlSide) = r(bowler, bowlSide) + 1
ball$(overBalls + 1) = "ONE NO-BALL"
IF strike = 1 THEN balls(bat1, batSide) = balls(bat1, batSide) + 1 ELSE balls(bat2, batSide) = balls(bat2, batSide) + 1
extras(batSide) = extras(batSide) + 1
noBalls(batSide) = noBalls(batSide) + 1
CASE IS = 4
truns(batSide) = truns(batSide) + 1
r(bowler, bowlSide) = r(bowler, bowlSide) + 1
ball$(overBalls + 1) = "ONE WIDE"
extras(batSide) = extras(batSide) + 1
wides(batSide) = wides(batSide) + 1
CASE IS = 5
truns(batSide) = truns(batSide) + 1
r(bowler, bowlSide) = r(bowler, bowlSide) + 1
ball$(overBalls + 1) = "ONE WIDE"
extras(batSide) = extras(batSide) + 1
wides(batSide) = wides(batSide) + 1
CASE IS = 6
truns(batSide) = truns(batSide) + 1
r(bowler, bowlSide) = r(bowler, bowlSide) + 1
ball$(overBalls + 1) = "ONE WIDE"
extras(batSide) = extras(batSide) + 1
wides(batSide) = wides(batSide) + 1
END SELECT
IF extraChance < 7 THEN overExtras = overExtras + 1
IF extraChance < 7 THEN GOTO 150

190 SELECT CASE tt
CASE IS <= aa
truns(batSide) = truns(batSide) + 2
tBalls(batSide) = tBalls(batSide) + 1
b(bowler, bowlSide) = b(bowler, bowlSide) + 1
r(bowler, bowlSide) = r(bowler, bowlSide) + 2
ball$(overBalls + 1) = "TWO RUNS"
IF strike = 1 THEN runs(bat1, batSide) = runs(bat1, batSide) + 2 ELSE runs(bat2, batSide) = runs(bat2, batSide) + 2
IF strike = 1 THEN balls(bat1, batSide) = balls(bat1, batSide) + 1 ELSE balls(bat2, batSide) = balls(bat2, batSide) + 1

CASE IS = bb
truns(batSide) = truns(batSide) + 3
tBalls(batSide) = tBalls(batSide) + 1
b(bowler, bowlSide) = b(bowler, bowlSide) + 1
r(bowler, bowlSide) = r(bowler, bowlSide) + 3
ball$(overBalls + 1) = "THREE RUNS"
IF strike = 1 THEN runs(bat1, batSide) = runs(bat1, batSide) + 3 ELSE runs(bat2, batSide) = runs(bat2, batSide) + 3
IF strike = 1 THEN balls(bat1, batSide) = balls(bat1, batSide) + 1 ELSE balls(bat2, batSide) = balls(bat2, batSide) + 1
IF strike = 1 THEN strike = 2 ELSE strike = 1

CASE IS = cc
truns(batSide) = truns(batSide) + 6
tBalls(batSide) = tBalls(batSide) + 1
b(bowler, bowlSide) = b(bowler, bowlSide) + 1
r(bowler, bowlSide) = r(bowler, bowlSide) + 6
ball$(overBalls + 1) = "SIX RUNS"
IF strike = 1 THEN runs(bat1, batSide) = runs(bat1, batSide) + 6 ELSE runs(bat2, batSide) = runs(bat2, batSide) + 6
IF strike = 1 THEN balls(bat1, batSide) = balls(bat1, batSide) + 1 ELSE balls(bat2, batSide) = balls(bat2, batSide) + 1

CASE cc + 1 TO dd
truns(batSide) = truns(batSide) + 1
tBalls(batSide) = tBalls(batSide) + 1
b(bowler, bowlSide) = b(bowler, bowlSide) + 1
r(bowler, bowlSide) = r(bowler, bowlSide) + 1
ball$(overBalls + 1) = "ONE RUN"
IF strike = 1 THEN runs(bat1, batSide) = runs(bat1, batSide) + 1 ELSE runs(bat2, batSide) = runs(bat2, batSide) + 1
IF strike = 1 THEN balls(bat1, batSide) = balls(bat1, batSide) + 1 ELSE balls(bat2, batSide) = balls(bat2, batSide) + 1
IF strike = 1 THEN strike = 2 ELSE strike = 1

CASE dd + 1 TO ee
truns(batSide) = truns(batSide) + 4
tBalls(batSide) = tBalls(batSide) + 1
b(bowler, bowlSide) = b(bowler, bowlSide) + 1
r(bowler, bowlSide) = r(bowler, bowlSide) + 4
ball$(overBalls + 1) = "FOUR RUNS"
IF strike = 1 THEN runs(bat1, batSide) = runs(bat1, batSide) + 4 ELSE runs(bat2, batSide) = runs(bat2, batSide) + 4
IF strike = 1 THEN balls(bat1, batSide) = balls(bat1, batSide) + 1 ELSE balls(bat2, batSide) = balls(bat2, batSide) + 1

CASE ELSE
tBalls(batSide) = tBalls(batSide) + 1
b(bowler, bowlSide) = b(bowler, bowlSide) + 1
ball$(overBalls + 1) = "NO RUN"
IF strike = 1 THEN balls(bat1, batSide) = balls(bat1, batSide) + 1 ELSE balls(bat2, batSide) = balls(bat2, batSide) + 1
END SELECT

150 SELECT CASE bowl(bowler, bowlSide)
CASE IS = 1
speed(overBalls + 1) = (rand(61) + 479) / 10
CASE IS = 2
speed(overBalls + 1) = (rand(61) + 479) / 10
CASE IS = 7
speed(overBalls + 1) = (rand(61) + 479) / 10
CASE IS = 8
speed(overBalls + 1) = (rand(61) + 479) / 10
CASE IS = 3
speed(overBalls + 1) = (rand(61) + 719) / 10
CASE IS = 9
speed(overBalls + 1) = (rand(61) + 719) / 10
CASE IS = 4
speed(overBalls + 1) = (rand(61) + 769) / 10
CASE IS = 10
speed(overBalls + 1) = (rand(61) + 769) / 10
CASE IS = 5
speed(overBalls + 1) = (rand(61) + 819) / 10
CASE IS = 11
speed(overBalls + 1) = (rand(61) + 819) / 10
CASE IS = 6
speed(overBalls + 1) = (rand(61) + 869) / 10
CASE IS = 12
speed(overBalls + 1) = (rand(61) + 869) / 10
END SELECT

IF o(bowler, bowlSide) = 0 AND overBalls = 0 THEN bowlers(bowlSide) = bowlers(bowlSide) + 1
IF o(bowler, bowlSide) = 0 AND overBalls = 0 THEN bowlChange(bowlers(bowlSide), bowlSide) = bowler
overBalls = overBalls + 1
delivery = 1
seconds = seconds + (rand(3) + 32)
SELECT CASE seconds
CASE IS >= 60
minutes = minutes + 1
seconds = seconds - 60
END SELECT
SELECT CASE minutes
CASE IS = 60
minutes = 0
hours = hours + 1
END SELECT
300 LOOP UNTIL finish > 0
NEXT innings

momDone = 0
eomc = 1
390 COLOR 11, 0
CLS
IF momDone = 1 THEN GOTO 370
FOR i = 1 TO 11
rc = 0
FOR j = 1 TO 11
IF runs(i, bowlSide) >= runs(j, bowlSide) THEN rc = rc + 1
NEXT j
IF rc = 11 THEN hrs = i
NEXT i
IF in(hrs, bowlSide) = 1 THEN asterisk$ = "*"

FOR i = 1 TO 11
rc = 0
FOR j = 1 TO 11
IF runs(i, batSide) >= runs(j, batSide) THEN rc = rc + 1
NEXT j
IF rc = 11 THEN hrs2 = i
NEXT i
IF in(hrs2, batSide) = 1 THEN asterisk2$ = "*"

IF tWickets(bowlSide) = 0 THEN GOTO 360
FOR i = 1 TO 11
wc = 0
FOR j = 1 TO 11
SELECT CASE w(i, batSide)
CASE IS > w(j, batSide)
wc = wc + 1
CASE IS = w(j, batSide)
IF r(i, batSide) <= r(j, batSide) THEN wc = wc + 1
END SELECT
NEXT j
IF wc = 11 THEN bbf = i
NEXT i


360 IF tWickets(batSide) = 0 THEN GOTO 370
FOR i = 1 TO 11
wc = 0
FOR j = 1 TO 11
SELECT CASE w(i, bowlSide)
CASE IS > w(j, bowlSide)
wc = wc + 1
CASE IS = w(j, bowlSide)
IF r(i, bowlSide) <= r(j, bowlSide) THEN wc = wc + 1
END SELECT
NEXT j
IF wc = 11 THEN bbf2 = i
NEXT i
370 momDone = 1


COLOR 11, 0
LOCATE 5, 3
PRINT team$(bowlSide)
LOCATE 5, 17
PRINT " "
LOCATE 5, 18
IF tWickets(bowlSide) = 10 THEN PRINT truns(bowlSide) ELSE PRINT truns(bowlSide); "-"; tWickets(bowlSide)
COLOR 3, 0
LOCATE 5, 36
PRINT player$(hrs, bowlSide); runs(hrs, bowlSide); asterisk$
LOCATE 5, 58
IF bbf = 0 THEN PRINT "" ELSE PRINT player$(bbf, batSide); w(bbf, batSide); "-"; r(bbf, batSide)

COLOR 11, 0
LOCATE 7, 3
PRINT team$(batSide)
LOCATE 7, 17
PRINT " "
LOCATE 7, 18
IF tWickets(batSide) = 10 THEN PRINT truns(batSide) ELSE PRINT truns(batSide); "-"; tWickets(batSide)
COLOR 3, 0
LOCATE 7, 36
PRINT player$(hrs2, batSide); runs(hrs2, batSide); asterisk2$
LOCATE 7, 58
IF bbf2 = 0 THEN PRINT "" ELSE PRINT player$(bbf2, bowlSide); w(bbf2, bowlSide); "-"; r(bbf2, bowlSide)

COLOR 11, 0
LOCATE 10, 3
SELECT CASE truns(batSide)
CASE IS > truns(bowlSide)
IF tWickets(batSide) = 9 THEN PRINT team$(batSide); " BEAT "; team$(bowlSide); " BY 1 WICKET" ELSE PRINT team$(batSide); " BEAT "; team$(bowlSide); " BY "; 10 - tWickets(batSide); " WICKETS"
winners = 1
CASE IS = truns(bowlSide)
PRINT team$(batSide); " TIED WITH "; team$(bowlSide)
winners = 1
CASE IS < truns(bowlSide)
PRINT team$(bowlSide); " BEAT "; team$(batSide); " BY "; truns(bowlSide) - truns(batSide); " RUNS"
winners = 2
END SELECT

LOCATE 26, 3
IF eomc = 1 THEN COLOR 0, 3 ELSE COLOR 3, 0
PRINT "VIEW "; team$(bowlSide); " BATTING SCORECARD"
LOCATE 28, 3
IF eomc = 2 THEN COLOR 0, 3 ELSE COLOR 3, 0
PRINT "VIEW "; team$(batSide); " BOWLING FIGURES"
LOCATE 30, 3
IF eomc = 3 THEN COLOR 0, 3 ELSE COLOR 3, 0
PRINT "VIEW "; team$(bowlSide); " MANHATTAN GRAPH"
LOCATE 34, 3
IF eomc = 4 THEN COLOR 0, 3 ELSE COLOR 3, 0
PRINT "VIEW "; team$(batSide); " BATTING SCORECARD"
LOCATE 36, 3
IF eomc = 5 THEN COLOR 0, 3 ELSE COLOR 3, 0
PRINT "VIEW "; team$(bowlSide); " BOWLING FIGURES"
LOCATE 38, 3
IF eomc = 6 THEN COLOR 0, 3 ELSE COLOR 3, 0
PRINT "VIEW "; team$(batSide); " MANHATTAN GRAPH"
LOCATE 42, 3
IF eomc = 7 THEN COLOR 0, 3 ELSE COLOR 3, 0
PRINT "VIEW ALL NATIONAL LEAGUE RESULTS"

380 SELECT CASE INKEY$
CASE IS = u$
eomc = eomc - 1
IF eomc < 1 THEN eomc = 7
GOTO 390
CASE IS = d$
eomc = eomc + 1
IF eomc > 7 THEN eomc = 1
GOTO 390
CASE IS = CHR$(13)
CASE ELSE
GOTO 380
END SELECT
SELECT CASE eomc
CASE IS = 1
battingSide = bowlSide
CALL scorecard2
GOTO 390
CASE IS = 2
bowlingSide = batSide
battingSide = bowlSide
CALL figures2
GOTO 390
CASE IS = 3
battingSide = 1
CALL manhattan
GOTO 390
CASE IS = 4
battingSide = batSide
CALL scorecard2
GOTO 390
CASE IS = 5
bowlingSide = bowlSide
battingSide = batSide
CALL figures2
GOTO 390
CASE IS = 6
battingSide = 2
CALL manhattan
GOTO 390
CASE ELSE
END SELECT

FOR i = 1 TO 11
sm(i) = sm(i) + 1
sRuns(i) = sRuns(i) + runs(i, team)
IF in(i, team) < 2 THEN sInnings(i) = sInnings(i) + 1
IF in(i, team) = 0 THEN sOuts(i) = sOuts(i) + 1
IF runs(i, team) > hs(i) THEN hs(i) = runs(i, team)
sBalls(i) = sBalls(i) + balls(i, team)

IF b(i, team) = 0 THEN sOvers(i) = sOvers(i) + o(i, team) ELSE sOvers(i) = sOvers(i) + (o(i, team) + 1)
sWickets(i) = sWickets(i) + w(i, team)
sConceded(i) = sConceded(i) + r(i, team)
SELECT CASE w(i, team)
CASE IS > bbw(i)
bbw(i) = w(i, team)
bbr(i) = r(i, team)
CASE IS = bbw(i)
IF runs(i, team) < bbr(i) THEN bbw(i) = w(i, team)
IF runs(i, team) < bbr(i) THEN bbr(i) = r(i, team)
END SELECT
NEXT i

SELECT CASE truns(team)
CASE IS > truns(opponents)
fansRating = fansRating + 8
directorsRating = directorsRating + 4
CASE IS = truns(opponents)
fansRating = fansRating + 5
directorsRating = directorsRating + 1
CASE ELSE
fansRating = fansRating - 8
directorsRating = directorsRating - 4
END SELECT

420 CALL matchSimulator
END SUB

SUB matchSimulator
COLOR 11, 0
CLS
LOCATE 2, 3
PRINT "WEEK "; week; " NATIONAL LEAGUE RESULTS"
FOR mn = 1 TO 9
COLOR 3, 0
myTeam = 0
IF fixture(1, mn, week) = team OR fixture(2, mn, week) = team THEN myTeam = 1
SELECT CASE myTeam
CASE IS = 1
COLOR 11, 0
LOCATE (mn * 2 + 8), 3
IF truns(batSide) > truns(bowlSide) THEN PRINT team$(batSide); " BEAT "; team$(bowlSide); " BY "; 10 - tWickets(batSide); " WICKETS"
IF truns(batSide) = truns(bowlSide) THEN PRINT team$(batSide); " TIED WITH "; team$(bowlSide)
IF truns(bowlSide) > truns(batSide) THEN PRINT team$(bowlSide); " BEAT "; team$(batSide); " BY "; truns(bowlSide) - truns(batSide); " RUNS"

played(batSide) = played(batSide) + 1
played(bowlSide) = played(bowlSide) + 1
SELECT CASE truns(batSide)
CASE IS > truns(bowlSide)
points(batSide) = points(batSide) + 4
wins(batSide) = wins(batSide) + 1
losses(bowlSide) = losses(bowlSide) + 1
CASE IS = truns(bowlSide)
points(batSide) = points(batSide) + 2
points(bowlSide) = points(bowlSide) + 2
ties(batSide) = ties(batSide) + 1
ties(bowlSide) = ties(bowlSide) + 1
CASE ELSE
points(bowlSide) = points(bowlSide) + 4
wins(bowlSide) = wins(bowlSide) + 1
losses(batSide) = losses(batSide) + 1
END SELECT
GOTO 430
END SELECT

team2 = fixture(1, mn, week)
opponents2 = fixture(2, mn, week)

totalRating = rating(team2) + rating(opponents2)
rtr = rand(totalRating)
SELECT CASE rtr
CASE IS <= rating(team2)
winners = team2
losers = opponents2
CASE ELSE
winners = opponents2
losers = team2
END SELECT

fb = rand(2)
SELECT CASE fb
CASE IS = 1
margain = rand(10)
LOCATE (mn * 2 + 8), 3
IF margain = 1 THEN PRINT team$(winners); " BEAT "; team$(losers); " BY 1 WICKET" ELSE PRINT team$(winners); " BEAT "; team$(losers); " BY "; margain; " WICKETS"
CASE IS = 2
margain = rand(100) + 1
LOCATE (mn * 2 + 8), 3
PRINT team$(winners); " BEAT "; team$(losers); " BY "; margain; " RUNS"
END SELECT

wins(winners) = wins(winners) + 1
losses(losers) = losses(losers) + 1
played(winners) = played(winners) + 1
played(losers) = played(losers) + 1
points(winners) = points(winners) + 4
430 NEXT mn
DO
LOOP UNTIL INKEY$ = CHR$(13)
END SUB

SUB playerSalary
2900 pco = 1
2400 COLOR 11, 0
CLS
LOCATE 2, 5
PRINT name$; "    "; team$(team); "    Week "; week; "  Year "; year
LOCATE 6, 5
PRINT "FINANCE - PLAYER SALARIES"

FOR i = 1 TO 18
IF pco = i THEN COLOR 0, 3 ELSE COLOR 3, 0
LOCATE (i * 2 + 8), 5
PRINT player$(i, team)
NEXT i
IF pco = 19 THEN COLOR 0, 3 ELSE COLOR 3, 0
LOCATE 46, 5
PRINT "Go Back to Finance Menu"

2300 SELECT CASE INKEY$
CASE IS = u$
pco = pco - 1
IF pco < 1 THEN pco = 19
GOTO 2400
CASE IS = d$
pco = pco + 1
IF pco > 19 THEN pco = 1
GOTO 2400
CASE IS = CHR$(13)
CASE ELSE
GOTO 2300
END SELECT
IF pco = 19 THEN GOTO 2500

2700 COLOR 11, 0
CLS
LOCATE 2, 5
PRINT name$; "    "; team$(team); "    Week "; week; "  Year "; year
LOCATE 6, 5
PRINT "FINANCE - PLAYER SALARIES"
LOCATE 10, 5
PRINT player$(pco, team)
LOCATE 12, 5
PRINT "Weekly wage: "; salary(pco, team); " pounds "; CHR$(17); " "; CHR$(16)
LOCATE 20, 5
PRINT "Press RETURN to go back to the Player Salaries Menu"

2600 SELECT CASE INKEY$
CASE IS = r$
salary(pco, team) = salary(pco, team) + 100
IF salary(pco, team) <= 6000 THEN morale(pco) = morale(pco) + rand(2)
IF salary(pco, team) > 6000 THEN salary(pco, team) = 6000
GOTO 2700
CASE IS = l$
salary(pco, team) = salary(pco, team) - 100
IF salary(pco, team) >= 1000 THEN morale(pco) = morale(pco) - rand(2)
IF salary(pco, team) < 1000 THEN salary(pco, team) = 1000
GOTO 2700
CASE IS = CHR$(13)
GOTO 2800
CASE ELSE
GOTO 2600
END SELECT
2800 GOTO 2900
2500 END SUB

FUNCTION rand (c)
RANDOMIZE TIMER
rand = INT(c * RND(1)) + 1
END FUNCTION

SUB saveGame
COLOR 11, 0
CLS
LOCATE 2, 5
PRINT name$; "    "; team$(team); "    Week "; week; "  Year "; year
oss = 1

960 FOR i = 1 TO 5
IF oss = i THEN COLOR 0, 3 ELSE COLOR 3, 0
LOCATE (i * 2 + 6), 5
PRINT "SAVE GAME TO FILE "; i
NEXT i
IF oss = 6 THEN COLOR 0, 3 ELSE COLOR 3, 0
LOCATE 18, 5
PRINT "GO BACK TO OPTIONS"

950 SELECT CASE INKEY$
CASE IS = u$
oss = oss - 1
IF oss < 1 THEN oss = 6
GOTO 960
CASE IS = d$
oss = oss + 1
IF oss > 6 THEN oss = 1
GOTO 960
CASE IS = CHR$(13)
CASE ELSE
GOTO 950
END SELECT

SELECT CASE oss
CASE IS = 6
CASE ELSE
IF oss = 1 THEN fi$ = "file1.txt"
IF oss = 2 THEN fi$ = "file2.txt"
IF oss = 3 THEN fi$ = "file3.txt"
IF oss = 4 THEN fi$ = "file4.txt"
IF oss = 5 THEN fi$ = "file5.txt"

OPEN fi$ FOR OUTPUT AS #1
PRINT #1, team
PRINT #1, name$
PRINT #1, week
PRINT #1, year
PRINT #1, fansRating
PRINT #1, directorsRating
FOR i = 1 TO 18
PRINT #1, sm(i)
PRINT #1, sInnings(i)
PRINT #1, sRuns(i)
PRINT #1, sOuts(i)
PRINT #1, hs(i)
PRINT #1, sBalls(i)
PRINT #1, sOvers(i)
PRINT #1, sWickets(i)
PRINT #1, sConceded(i)
PRINT #1, bbw(i)
PRINT #1, bbr(i)
PRINT #1, iWeeks(i)
PRINT #1, duty(i)
PRINT #1, morale(i)
NEXT i
FOR i = 1 TO 19
PRINT #1, team$(i)
PRINT #1, rating(i)
PRINT #1, shirt1(i)
PRINT #1, shirt2(i)
PRINT #1, trousers1(i)
PRINT #1, trousers2(i)
PRINT #1, cs(i)
PRINT #1, wk(i)
PRINT #1, cp(i)
PRINT #1, ob1(i)
PRINT #1, ob2(i)
PRINT #1, overSeas1(i)
PRINT #1, overSeas2(i)
FOR j = 1 TO 18
PRINT #1, player$(j, i)
PRINT #1, gb(j, i)
PRINT #1, rs(j, i)
PRINT #1, wt(j, i)
PRINT #1, eb(j, i)
PRINT #1, ba(j, i)
PRINT #1, fa(j, i)
PRINT #1, bat(j, i)
PRINT #1, bowl(j, i)
PRINT #1, wicketKeeper(j, i)
PRINT #1, peak(j, i)
PRINT #1, international(j, i)
PRINT #1, salary(j, i)
NEXT j
PRINT #1, points(i)
PRINT #1, wins(i)
PRINT #1, ties(i)
PRINT #1, losses(i)
PRINT #1, played(i)
NEXT i
CLOSE
COLOR 11, 0
CLS
LOCATE 20, 20
PRINT "GAME SAVED SUCCESFULLY TO FILE "; oss
DO
LOOP UNTIL INKEY$ = CHR$(13)
END SELECT
END SUB

SUB scorecard
COLOR 11, 0
CLS
LOCATE 2, 4
PRINT team$(batSide)

FOR i = 1 TO 11
SELECT CASE in(i, batSide)
CASE IS = 1
howOut1$(i, batSide) = "not out"
COLOR 11, 0
CASE ELSE
IF howOut1$(i, batSide) = "not out" THEN howOut1$(i, batSide) = ""
COLOR 3, 0
END SELECT

LOCATE 2 + (i * 2), 4
PRINT player$(i, batSide)
LOCATE 2 + (i * 2), 23
PRINT howOut1$(i, batSide)
LOCATE 2 + (i * 2), 26
PRINT howOut2$(i, batSide)
LOCATE 2 + (i * 2), 44
PRINT howOut3$(i, batSide)
LOCATE 2 + (i * 2), 47
PRINT howOut4$(i, batSide)
LOCATE 2 + (i * 2), 67
PRINT runs(i, batSide)
LOCATE 2 + (i * 2), 72
PRINT "("; balls(i, batSide); ")"
NEXT i

COLOR 11, 0
LOCATE 27, 4
PRINT "Extras: "; extras(batSide); " (w"; wides(batSide); ", nb"; noBalls(batSide); ", b"; byes(batSide); ", lb"; legByes(batSide); ")"
LOCATE 30, 4
PRINT "Total, after "; tovers(batSide); "."; tBalls(batSide); " overs,"
LOCATE 30, 67
PRINT truns(batSide); "-"; tWickets(batSide)

LOCATE 48, 27
COLOR 3, 0
PRINT "       MAIN MENU       "
LOCATE 48, 4
COLOR 0, 3
PRINT "   BATTING SCORECARD   "
LOCATE 48, 50
COLOR 3, 0
PRINT "    BOWLING FIGURES    "
COLOR 0, 3
LOCATE 46, 37
PRINT CHR$(17); " "; CHR$(16)

180 SELECT CASE INKEY$
CASE IS = r$
CASE ELSE
GOTO 180
END SELECT
END SUB

SUB scorecard2
COLOR 11, 0
CLS
LOCATE 2, 4
PRINT team$(battingSide)

FOR i = 1 TO 11
SELECT CASE in(i, battingSide)
CASE IS = 1
howOut1$(i, battingSide) = "not out"
COLOR 11, 0
CASE ELSE
IF howOut1$(i, battingSide) = "not out" THEN howOut1$(i, battingSide) = ""
COLOR 3, 0
END SELECT

LOCATE 2 + (i * 2), 4
PRINT player$(i, battingSide)
LOCATE 2 + (i * 2), 23
PRINT howOut1$(i, battingSide)
LOCATE 2 + (i * 2), 26
PRINT howOut2$(i, battingSide)
LOCATE 2 + (i * 2), 44
PRINT howOut3$(i, battingSide)
LOCATE 2 + (i * 2), 47
PRINT howOut4$(i, battingSide)
LOCATE 2 + (i * 2), 67
PRINT runs(i, battingSide)
LOCATE 2 + (i * 2), 72
PRINT "("; balls(i, battingSide); ")"
NEXT i

COLOR 11, 0
LOCATE 27, 4
PRINT "Extras: "; extras(battingSide); " (w"; wides(battingSide); ", nb"; noBalls(battingSide); ", b"; byes(battingSide); ", lb"; legByes(battingSide); ")"
LOCATE 30, 4
PRINT "Total, after "; tovers(battingSide); "."; tBalls(battingSide); " overs,"
LOCATE 30, 67
PRINT truns(battingSide); "-"; tWickets(battingSide)

DO
LOOP UNTIL INKEY$ = CHR$(13)
END SUB

SUB statistics
COLOR 11, 0
CLS
LOCATE 2, 5
PRINT name$; "    "; team$(team); "    Week "; week; "  Year "; year

FOR i = 1 TO 18
batAve(i) = 0
bowlAve(i) = 0
strRte(i) = 0
ecnRte(i) = 0
IF sRuns(i) = 0 OR sOuts(i) = 0 THEN GOTO 700
batAve(i) = INT(sRuns(i) / sOuts(i) * 10) / 10
700 IF sConceded(i) = 0 OR sWickets(i) = 0 THEN GOTO 710
bowlAve(i) = INT(sConceded(i) / sWickets(i) * 10) / 10
710 IF sRuns(i) = 0 OR sBalls(i) = 0 THEN GOTO 720
strRte(i) = INT(sRuns(i) / sBalls(i) * 1000) / 10
720 IF sConceded(i) = 0 OR sOvers(i) = 0 THEN GOTO 730
ecnRte(i) = INT(sConceded(i) / sOvers(i) * 10) / 10
730 NEXT i

COLOR 11, 0
LOCATE 8, 5
PRINT "Name"
LOCATE 8, 23
PRINT " Mtc"
LOCATE 8, 28
PRINT "Inn"
LOCATE 8, 32
PRINT "Run"
LOCATE 8, 36
PRINT "HSc"
LOCATE 8, 40
PRINT "StrRt"
LOCATE 8, 47
PRINT "BatAv"
LOCATE 8, 54
PRINT "Wkt"
LOCATE 8, 58
PRINT "BBF"
LOCATE 8, 66
PRINT "EcnRt"
LOCATE 8, 73
PRINT "BwlAv"

FOR i = 1 TO 18
IF i = 1 OR i = 3 OR i = 5 OR i = 7 OR i = 9 OR i = 11 OR i = 13 OR i = 15 OR i = 17 THEN COLOR 3, 0 ELSE COLOR 9, 0
LOCATE (i * 2 + 8), 5
PRINT player$(i, team)
LOCATE (i * 2 + 8), 23
PRINT sm(i)
LOCATE (i * 2 + 8), 27
PRINT sInnings(i)
LOCATE (i * 2 + 8), 31
PRINT sRuns(i)
LOCATE (i * 2 + 8), 35
PRINT hs(i)
LOCATE (i * 2 + 8), 39
PRINT strRte(i)
LOCATE (i * 2 + 8), 46
PRINT batAve(i)
LOCATE (i * 2 + 8), 53
PRINT sWickets(i)
LOCATE (i * 2 + 8), 57
PRINT bbw(i)
LOCATE (i * 2 + 8), 60
PRINT "-"
LOCATE (i * 2 + 8), 61
PRINT bbr(i)
LOCATE (i * 2 + 8), 65
PRINT ecnRte(i)
LOCATE (i * 2 + 8), 72
PRINT bowlAve(i)
NEXT i

DO
LOOP UNTIL INKEY$ = CHR$(13)
END SUB

SUB teamSheet
480 dd = 0
ps = 1
ac = 1
so = 1

tos = 1
50  COLOR 11, 0
CLS
350 COLOR 11, 0
IF dd = 0 THEN GOTO 10000
FOR i = 1 TO 18
LOCATE i + 12, 1
IF i <> ps THEN PRINT " " ELSE PRINT CHR$(16)
NEXT i

10000 LOCATE 2, 3
PRINT name$; "    "; team$(team); "    Week "; week; "  Year "; year
COLOR 11, 0
LOCATE 10, 3
PRINT "NO"
LOCATE 10, 6
PRINT "NAME"
LOCATE 10, 22
PRINT "RLE"
LOCATE 10, 27
PRINT "BAT"
LOCATE 10, 32
PRINT "BWL"
LOCATE 10, 36
PRINT "ABILITY"
LOCATE 7, 3
PRINT CHR$(29); " ABILITY ATTRIBUTE: "; attribute$(ac); " "; CHR$(17); " "; CHR$(16)

FOR i = 1 TO 18
SELECT CASE ac
CASE IS = 1
attribute = gb(i, team)
CASE IS = 2
attribute = rs(i, team)
CASE IS = 3
attribute = wt(i, team)
CASE IS = 4
attribute = eb(i, team)
CASE IS = 5
attribute = fa(i, team)
CASE IS = 6
attribute = morale(i)
END SELECT

COLOR 7, 4
LOCATE i + 12, 3
IF duty(i) > 0 THEN PRINT "I"
IF duty(i) > 0 THEN GOTO 5000
COLOR 4, 7
LOCATE i + 12, 3
IF iWeeks(i) > 0 THEN PRINT "+"
5000 IF i = 1 OR i = 3 OR i = 5 OR i = 7 OR i = 9 OR i = 11 THEN COLOR 3, 0
IF i = 2 OR i = 4 OR i = 6 OR i = 8 OR i = 10 THEN COLOR 9, 0
IF i = 12 OR i = 14 OR i = 16 OR i = 18 THEN COLOR 10, 0
IF i = 13 OR i = 15 OR i = 17 THEN COLOR 2, 0
IF iWeeks(i) > 0 THEN GOTO 3100
IF duty(i) > 0 THEN GOTO 3100
LOCATE i + 12, 2
IF i < 12 THEN PRINT i
LOCATE i + 12, 3
IF i > 11 THEN PRINT "R"
3100 LOCATE i + 12, 6
PRINT player$(i, team)
IF ob1(team) = i OR ob2(team) = i OR wk(team) = i THEN LOCATE i + 12, 24 ELSE LOCATE i + 12, 23
COLOR 7, 1
IF cp(team) = i THEN PRINT "C"
LOCATE i + 12, 23
COLOR 7, 4
IF ob1(team) = i THEN PRINT "1"
IF ob2(team) = i THEN PRINT "2"
COLOR 7, 6
IF wk(team) = i THEN PRINT "W"
IF i = 1 OR i = 3 OR i = 5 OR i = 7 OR i = 9 OR i = 11 THEN COLOR 3, 0
IF i = 2 OR i = 4 OR i = 6 OR i = 8 OR i = 10 THEN COLOR 9, 0
IF i = 12 OR i = 14 OR i = 16 OR i = 18 THEN COLOR 10, 0
IF i = 13 OR i = 15 OR i = 17 THEN COLOR 2, 0
LOCATE i + 12, 27
PRINT bat$(bat(i, team))
LOCATE i + 12, 32
PRINT bowl$(bowl(i, team))

LOCATE i + 12, 36
PRINT CHR$(219)
l = 36
u = 0
FOR j = 10 TO 95
u = u + 1
IF u = 3 THEN u = 1
IF u = 1 THEN l = l + 1
LOCATE i + 12, l
SELECT CASE u
CASE IS = 1
IF attribute >= j THEN PRINT CHR$(221) ELSE PRINT " "
CASE IS = 2
IF attribute >= j THEN PRINT CHR$(219) ELSE PRINT " "
END SELECT
NEXT j
NEXT i

LOCATE 34, 3
IF tos = 1 THEN COLOR 0, 3 ELSE COLOR 3, 0
PRINT "Swap Players"
LOCATE 36, 3
IF tos = 2 THEN COLOR 0, 3 ELSE COLOR 3, 0
PRINT "Change Captain"
LOCATE 38, 3
IF tos = 3 THEN COLOR 0, 3 ELSE COLOR 3, 0
PRINT "Change Wicketkeeper"
LOCATE 40, 3
IF tos = 4 THEN COLOR 0, 3 ELSE COLOR 3, 0
PRINT "Change Opening Bowler 1"
LOCATE 42, 3
IF tos = 5 THEN COLOR 0, 3 ELSE COLOR 3, 0
PRINT "Change Opening Bowler 2"
LOCATE 44, 3
IF tos = 6 THEN COLOR 0, 3 ELSE COLOR 3, 0
PRINT "Back to Main Menu"

60 SELECT CASE INKEY$
CASE IS = r$
ac = ac + 1
IF ac > 6 THEN ac = 1
GOTO 350
CASE IS = l$
ac = ac - 1
IF ac < 1 THEN ac = 6
GOTO 350
CASE IS = u$
IF dd = 0 THEN tos = tos - 1 ELSE ps = ps - 1
IF tos < 1 THEN tos = 6
IF ps < 1 THEN ps = 18
GOTO 350
CASE IS = d$
IF dd = 0 THEN tos = tos + 1 ELSE ps = ps + 1
IF tos > 6 THEN tos = 1
IF ps > 18 THEN ps = 1
GOTO 350
CASE IS = CHR$(13)
SELECT CASE dd
CASE IS = 0
dd = 1
IF tos = 6 THEN GOTO 450
GOTO 50
CASE IS = 1
IF tos = 1 THEN GOTO 2070
IF tos = 1 THEN dd = 0
IF tos = 2 AND ps < 12 THEN cp(team) = ps
IF tos = 2 AND ps < 12 THEN dd = 0
IF tos = 3 AND ps < 12 AND ob1(team) <> ps AND ob2(team) <> ps THEN wk(team) = ps
IF tos = 3 AND ps < 12 AND ob1(team) <> ps AND ob2(team) <> ps THEN dd = 0
IF tos = 4 AND ps < 12 AND ob2(team) <> ps AND wk(team) <> ps AND bowl(ps, team) <> 13 THEN ob1(team) = ps
IF tos = 4 AND ps < 12 AND ob2(team) <> ps AND wk(team) <> ps AND bowl(ps, team) <> 13 THEN dd = 0
IF tos = 5 AND ps < 12 AND wk(team) <> ps AND ob1(team) <> ps AND bowl(ps, team) <> 13 THEN ob2(team) = ps
IF tos = 5 AND ps < 12 AND wk(team) <> ps AND ob1(team) <> ps AND bowl(ps, team) <> 13 THEN dd = 0
IF dd = 0 THEN ps = 1
GOTO 50
END SELECT
CASE ELSE
GOTO 60
END SELECT

2070 ps2 = 1
dd = 1
COLOR 3, 0
CLS
2050 FOR i = 1 TO 18
COLOR 3, 0
LOCATE i + 12, 1
IF i = ps2 THEN PRINT CHR$(16)
COLOR 11, 0
LOCATE i + 12, 1
IF i = ps THEN PRINT CHR$(16)
LOCATE i + 12, 1
IF i <> ps AND i <> ps2 THEN PRINT " "
NEXT i

LOCATE 2, 3
PRINT name$; "    "; team$(team); "    Week "; week; "  Year "; year
COLOR 11, 0
LOCATE 10, 3
PRINT "NO"
LOCATE 10, 6
PRINT "NAME"
LOCATE 10, 22
PRINT "RLE"
LOCATE 10, 27
PRINT "BAT"
LOCATE 10, 32
PRINT "BWL"
LOCATE 10, 36
PRINT "ABILITY"
LOCATE 7, 3
PRINT CHR$(29); " ABILITY ATTRIBUTE: "; attribute$(ac); " "; CHR$(17); " "; CHR$(16)

FOR i = 1 TO 18
SELECT CASE ac
CASE IS = 1
attribute = gb(i, team)
CASE IS = 2
attribute = rs(i, team)
CASE IS = 3
attribute = wt(i, team)
CASE IS = 4
attribute = eb(i, team)
CASE IS = 5
attribute = fa(i, team)
CASE IS = 6
attribute = morale(i)
END SELECT

COLOR 7, 4
LOCATE i + 12, 3
IF duty(i) > 0 THEN PRINT "I"
IF duty(i) > 0 THEN GOTO 5100
COLOR 4, 7
LOCATE i + 12, 3
IF iWeeks(i) > 0 THEN PRINT "+"
5100 IF i = 1 OR i = 3 OR i = 5 OR i = 7 OR i = 9 OR i = 11 THEN COLOR 3, 0
IF i = 2 OR i = 4 OR i = 6 OR i = 8 OR i = 10 THEN COLOR 9, 0
IF i = 12 OR i = 14 OR i = 16 OR i = 18 THEN COLOR 10, 0
IF i = 13 OR i = 15 OR i = 17 THEN COLOR 2, 0
IF iWeeks(i) > 0 THEN GOTO 3200
IF duty(i) > 0 THEN GOTO 3200
LOCATE i + 12, 2
IF i < 12 THEN PRINT i
LOCATE i + 12, 3
IF i > 11 THEN PRINT "R"
3200 LOCATE i + 12, 6
PRINT player$(i, team)
IF ob1(team) = i OR ob2(team) = i OR wk(team) = i THEN LOCATE i + 12, 24 ELSE LOCATE i + 12, 23
COLOR 7, 1
IF cp(team) = i THEN PRINT "C"
LOCATE i + 12, 23
COLOR 7, 4
IF ob1(team) = i THEN PRINT "1"
IF ob2(team) = i THEN PRINT "2"
COLOR 7, 6
IF wk(team) = i THEN PRINT "W"
IF i = 1 OR i = 3 OR i = 5 OR i = 7 OR i = 9 OR i = 11 THEN COLOR 3, 0
IF i = 2 OR i = 4 OR i = 6 OR i = 8 OR i = 10 THEN COLOR 9, 0
IF i = 12 OR i = 14 OR i = 16 OR i = 18 THEN COLOR 10, 0
IF i = 13 OR i = 15 OR i = 17 THEN COLOR 2, 0
LOCATE i + 12, 27
PRINT bat$(bat(i, team))
LOCATE i + 12, 32
PRINT bowl$(bowl(i, team))

LOCATE i + 12, 36
PRINT CHR$(219)
l = 36
u = 0
FOR j = 10 TO 95
u = u + 1
IF u = 3 THEN u = 1
IF u = 1 THEN l = l + 1
LOCATE i + 12, l
SELECT CASE u
CASE IS = 1
IF attribute >= j THEN PRINT CHR$(221) ELSE PRINT " "
CASE IS = 2
IF attribute >= j THEN PRINT CHR$(219) ELSE PRINT " "
END SELECT
NEXT j
NEXT i

LOCATE 34, 3
IF tos = 1 THEN COLOR 0, 3 ELSE COLOR 3, 0
PRINT "Swap Players"
LOCATE 36, 3
IF tos = 2 THEN COLOR 0, 3 ELSE COLOR 3, 0
PRINT "Change Captain"
LOCATE 38, 3
IF tos = 3 THEN COLOR 0, 3 ELSE COLOR 3, 0
PRINT "Change Wicketkeeper"
LOCATE 40, 3
IF tos = 4 THEN COLOR 0, 3 ELSE COLOR 3, 0
PRINT "Change Opening Bowler 1"
LOCATE 42, 3
IF tos = 5 THEN COLOR 0, 3 ELSE COLOR 3, 0
PRINT "Change Opening Bowler 2"
LOCATE 44, 3
IF tos = 6 THEN COLOR 0, 3 ELSE COLOR 3, 0
PRINT "Back to Main Menu"

2060 dd = 1
SELECT CASE INKEY$
CASE IS = r$
ac = ac + 1
IF ac > 6 THEN ac = 1
GOTO 2050
CASE IS = l$
ac = ac - 1
IF ac < 1 THEN ac = 6
GOTO 2050
CASE IS = u$
IF dd = 0 THEN tos = tos - 1 ELSE ps2 = ps2 - 1
IF tos < 1 THEN tos = 6
IF ps2 < 1 THEN ps2 = 18
GOTO 2050
CASE IS = d$
IF dd = 0 THEN tos = tos + 1 ELSE ps2 = ps2 + 1
IF tos > 6 THEN tos = 1
IF ps2 > 18 THEN ps2 = 1
GOTO 2050
CASE IS = CHR$(13)
SELECT CASE dd
CASE IS = 0
dd = 1
GOTO 2050
CASE IS = 1
IF tos = 1 THEN GOTO 4600
IF tos = 1 THEN dd = 0
IF tos = 2 AND ps2 < 12 THEN cp(team) = ps2
IF tos = 2 AND ps2 < 12 THEN dd = 0
IF tos = 3 AND ps2 < 12 AND ob1(team) <> ps2 AND ob2(team) <> ps2 THEN wk(team) = ps2
IF tos = 3 AND ps2 < 12 AND ob1(team) <> ps2 AND ob2(team) <> ps2 THEN dd = 0
IF tos = 4 AND ps2 < 12 AND ob2(team) <> ps2 AND wk(team) <> ps2 THEN ob1(team) = ps2
IF tos = 4 AND ps2 < 12 AND ob2(team) <> ps2 AND wk(team) <> ps2 THEN dd = 0
IF tos = 5 AND ps2 < 12 AND wk(team) <> ps2 AND ob1(team) <> ps2 THEN ob2(team) = ps2
IF tos = 5 AND ps2 < 12 AND wk(team) <> ps2 AND ob1(team) <> ps2 THEN dd = 0
IF dd = 0 THEN ps2 = 1
GOTO 2050
END SELECT
CASE ELSE
GOTO 2060
END SELECT


4600 player2$ = player$(ps2, team)
gb2 = gb(ps2, team)
rs2 = rs(ps2, team)
eb2 = eb(ps2, team)
wt2 = wt(ps2, team)
ba2 = ba(ps2, team)
fa2 = fa(ps2, team)
bat2 = bat(ps2, team)
bowl2 = bowl(ps2, team)
wicketKeeper2 = wicketKeeper(ps2, team)
international2 = international(ps2, team)
salary2 = salary(ps2, team)
peak2 = peak(ps2, team)
sm2 = sm(ps2)
sInnings2 = sInnings(ps2)
sRuns2 = sRuns(ps2)
sOuts2 = sOuts(ps2)
hs2 = hs(ps2)
sBalls2 = sBalls(ps2)
sWickets2 = sWickets(ps2)
bbw2 = bbw(ps2)
bbr2 = bbr(ps2)
sOvers2 = sOvers(ps2)
sConceded2 = sConceded(ps2)
morale2 = morale(ps2)
iWeeks2 = iWeeks(ps2)
duty2 = duty(ps2)

player$(ps2, team) = player$(ps, team)
gb(ps2, team) = gb(ps, team)
rs(ps2, team) = rs(ps, team)
eb(ps2, team) = eb(ps, team)
wt(ps2, team) = wt(ps, team)
ba(ps2, team) = ba(ps, team)
fa(ps2, team) = fa(ps, team)
bat(ps2, team) = bat(ps, team)
bowl(ps2, team) = bowl(ps, team)
wicketKeeper(ps2, team) = wicketKeeper(ps, team)
international(ps2, team) = international(ps, team)
salary(ps2, team) = salary(ps, team)
peak(ps2, team) = peak(ps, team)
sm(ps2) = sm(ps)
sInnings(ps2) = sInnings(ps)
sRuns(ps2) = sRuns(ps)
sOuts(ps2) = sOuts(ps)
hs(ps2) = hs(ps)
sBalls(ps2) = sBalls(ps)
sWickets(ps2) = sWickets(ps)
bbw(ps2) = bbw(ps)
bbr(ps2) = bbr(ps)
sOvers(ps2) = sOvers(ps)
sConceded(ps2) = sConceded(ps)
morale(ps2) = morale(ps)
iWeeks(ps2) = iWeeks(ps)
duty(ps2) = duty(ps)

player$(ps, team) = player2$
gb(ps, team) = gb2
rs(ps, team) = rs2
eb(ps, team) = eb2
wt(ps, team) = wt2
ba(ps, team) = ba2
fa(ps, team) = fa2
bat(ps, team) = bat2
bowl(ps, team) = bowl2
wicketKeeper(ps, team) = wicketKeeper2
international(ps, team) = international2
salary(ps, team) = salary2
peak(ps, team) = peak2
sm(ps) = sm2
sInnings(ps) = sInnings2
sRuns(ps) = sRuns2
sOuts(ps) = sOuts2
hs(ps) = hs2
sBalls(ps) = sBalls2
sWickets(ps) = sWickets2
bbw(ps) = bbw2
bbr(ps) = bbr2
sOvers(ps) = sOvers2
sConceded(ps) = sConceded2
morale(ps) = morale2
iWeeks(ps) = iWeeks2
duty(ps) = duty2

SELECT CASE overSeas1(team)
CASE IS = ps
overSeas1(team) = ps2
CASE IS = ps2
overSeas1(team) = ps
END SELECT
SELECT CASE overSeas2(team)
CASE IS = ps
overSeas2(team) = ps2
CASE IS = ps2
overSeas2(team) = ps
END SELECT

SELECT CASE wk(team)
CASE IS = ps
IF ps2 < 12 THEN wk(team) = ps2
CASE IS = ps2
IF ps < 12 THEN wk(team) = ps
END SELECT
SELECT CASE cp(team)
CASE IS = ps
IF ps2 < 12 THEN cp(team) = ps2
CASE IS = ps2
IF ps < 12 THEN cp(team) = ps
END SELECT
SELECT CASE ob1(team)
CASE IS = ps
IF ps2 < 12 THEN ob1(team) = ps2
CASE IS = ps2
IF ps < 12 THEN ob1(team) = ps
END SELECT
SELECT CASE ob2(team)
CASE IS = ps
IF ps2 < 12 THEN ob2(team) = ps2
CASE IS = ps2
IF ps < 12 THEN ob2(team) = ps
END SELECT
cob1 = 0
IF ob1(team) = wk(team) THEN cob1 = 1
IF bowl(ob1(team), team) = 13 THEN cob1 = 1
IF ob1(team) = ob2(team) THEN cob1 = 1
SELECT CASE cob1
CASE IS = 1
DO
ob1(team) = rand(11)
LOOP UNTIL wk(team) <> ob1(team) AND bowl(ob1(team), team) <> 13 AND ob1(team) <> ob2(team)
END SELECT

cob2 = 0
IF ob2(team) = wk(team) THEN cob2 = 1
IF bowl(ob2(team), team) = 13 THEN cob2 = 1
IF ob2(team) = ob1(team) THEN cob2 = 1
SELECT CASE cob2
CASE IS = 1
DO
ob2(team) = rand(11)
LOOP UNTIL wk(team) <> ob2(team) AND bowl(ob2(team), team) <> 13 AND ob2(team) <> ob1(team)
END SELECT
GOTO 480
450 END SUB

SUB training
1131 cto = 1
dd = 0
1130 ops = 1
1110 COLOR 11, 0
CLS
LOCATE 2, 5
PRINT name$; "    "; team$(team); "    Week "; week; "  Year "; year
LOCATE 6, 5
PRINT "TRAINING"
FOR i = 1 TO 18
IF i = 1 OR i = 3 OR i = 5 OR i = 7 OR i = 9 OR i = 11 OR i = 13 OR i = 15 OR i = 17 THEN COLOR 3, 0 ELSE COLOR 9, 0
LOCATE (i + 8), 5
PRINT player$(i, team)
NEXT i

IF dd = 0 THEN GOTO 1132
FOR i = 1 TO 18
LOCATE (i + 8), 3
IF ops = i THEN PRINT CHR$(16) ELSE PRINT " "
NEXT i

1132 LOCATE 32, 5
IF cto = 1 THEN COLOR 0, 3 ELSE COLOR 3, 0
PRINT "Train Player"
LOCATE 34, 5
IF cto = 2 THEN COLOR 0, 3 ELSE COLOR 3, 0
PRINT "Back to Main Menu"

1100 SELECT CASE INKEY$
CASE IS = u$
IF dd = 0 THEN cto = cto - 1 ELSE ops = ops - 1
IF ops < 1 THEN ops = 18
IF cto < 1 THEN cto = 2
GOTO 1110
CASE IS = d$
IF dd = 0 THEN cto = cto + 1 ELSE ops = ops + 1
IF cto > 2 THEN cto = 1
IF ops > 18 THEN ops = 1
GOTO 1110
CASE IS = CHR$(13)
SELECT CASE dd
CASE IS = 0
dd = 1
IF cto = 2 THEN GOTO 1120
GOTO 1110
CASE IS = 1
GOTO 4000
END SELECT
CASE ELSE
GOTO 1100
END SELECT

4000 z = 0
DO
COLOR 11, 0
CLS
LOCATE 2, 5
PRINT name$; "    "; team$(team); "    Week "; week; "  Year "; year
LOCATE 6, 5
PRINT "TRAINING  -  "; player$(ops, team)
LOCATE 10, 5
PRINT "CAREER PERIOD: "; career$(peak(ops, team))
COLOR 3, 0
LOCATE 14, 5
PRINT "CURRENT TRAINING FOCUS:"
LOCATE 14, 30
PRINT tAttribute$(ta(ops)); " "; CHR$(17); " "; CHR$(16)

COLOR 9, 0
LOCATE 18, 5
PRINT "Very Low Intensity Training"
COLOR 3, 0
LOCATE 20, 5
PRINT "Low Intensity Training"
COLOR 9, 0
LOCATE 22, 5
PRINT "Medium Intensity Training"
COLOR 3, 0
LOCATE 24, 5
PRINT "High Intensity Training"
COLOR 9, 0
LOCATE 26, 5
PRINT "Very High Intensity Training"
LOCATE (ti(ops) * 2 + 16), 3
PRINT CHR$(16)
COLOR 11, 0
LOCATE 40, 5
PRINT "Press RETURN to go back"
1140 SELECT CASE INKEY$
CASE IS = u$
ti(ops) = ti(ops) - 1
IF ti(ops) < 1 THEN ti(ops) = 5
CASE IS = d$
ti(ops) = ti(ops) + 1
IF ti(ops) > 5 THEN ti(ops) = 1
CASE IS = l$
ta(ops) = ta(ops) - 1
IF ta(ops) < 1 THEN ta(ops) = 6
CASE IS = r$
ta(ops) = ta(ops) + 1
IF ta(ops) > 6 THEN ta(ops) = 1
CASE IS = CHR$(13)
z = 1
CASE ELSE
GOTO 1140
END SELECT
LOOP UNTIL z = 1
GOTO 1131
1120 END SUB

