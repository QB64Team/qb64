CHDIR ".\programs\samples\pete\pongtennis"

DECLARE SUB challengeMatchDay ()
DECLARE SUB challengeMode ()
DECLARE SUB matchDayMenu ()
DECLARE SUB calender ()
DECLARE SUB career ()
DECLARE SUB worldRankings ()
DECLARE SUB backWallRally ()
DECLARE SUB training ()
DECLARE SUB targetPractice ()
DECLARE SUB tournament ()
DECLARE SUB preMatchDay ()
DECLARE SUB options ()
DECLARE SUB matchDay ()
DECLARE SUB getInfo ()
DECLARE FUNCTION rand! (c!)
DIM SHARED points(2)
DIM SHARED realPoints$(2)
DIM SHARED games(2)
DIM SHARED sets(2)
DIM SHARED forename$(32)
DIM SHARED surname$(32)
DIM SHARED speedRating(32)
DIM SHARED speed(32)
DIM SHARED power(32)
DIM SHARED accuracy(32)
DIM SHARED colour$(15)
DIM SHARED winners(2)
DIM SHARED aces(2)
DIM SHARED faults(2)
DIM SHARED errors(2)
DIM SHARED player(33)
DIM SHARED flag(32)
DIM SHARED in(32)
DIM SHARED tournamentPlayer(33)
DIM SHARED round$(5)
DIM SHARED arp(32)
DIM SHARED rankPoints(10, 32)
DIM SHARED minorRating(32)
DIM SHARED rank(32)
DIM SHARED month$(12)
DIM SHARED days(12)
DIM SHARED day(24)
DIM SHARED month(24)
DIM SHARED qual(34)
DIM SHARED tourney$(34)
DIM SHARED qual$(34)
DIM SHARED entrants(6)
DIM SHARED rounds(34)
DIM SHARED cPlayerNumber(2, 6)
DIM SHARED cGames(2, 6)
DIM SHARED cSets(2, 6)
DIM SHARED cGamesToWin(6)
DIM SHARED cSetsToWin(6)
DIM SHARED cAmount(6)
DIM SHARED cDescription$(6, 6)
DIM SHARED cCompleted(6)
COMMON SHARED challenge, day, month, year, userDone, winner, userColour, opponentColour, forename$, surname$, l$, r$, u$, d$, opponent, gamesToWin, setsToWin, gamesToWin2

SCREEN 0
CALL getInfo
gamesToWin = 6
gamesToWin2 = 2
setsToWin = 1
userColour = 11
opponentColour = 4
colour$(3) = "CYAN"
colour$(4) = "RED"
colour$(5) = "PURPLE"
colour$(6) = "ORANGE"
colour$(7) = "WHITE"
colour$(8) = "GREY"
colour$(9) = "TURQOUISE"
colour$(10) = "GREEN"
colour$(11) = "BLUE"
colour$(12) = "LIGHT RED"
colour$(13) = "PINK"
colour$(14) = "YELLOW"
colour$(15) = "BRIGHT WHITE"
name$ = "USER"

COLOR 15, 2
CLS
LOCATE 16, 32
PRINT "PONG TENNIS"
COLOR 7, 2
LOCATE 20, 30
PRINT "BY ALEX BEIGHTON"
DO
LOOP UNTIL INKEY$ = CHR$(13)

COLOR 15, 2
CLS
LOCATE 16, 32
PRINT "KEY CONFIG"
LOCATE 20, 25
COLOR 7, 2
PRINT "PLEASE ENTER THE "; CHR$(34); "LEFT"; CHR$(34); " KEY"
DO
l$ = INKEY$
LOOP UNTIL l$ <> ""
COLOR 15, 2
CLS
LOCATE 16, 32
PRINT "KEY CONFIG"
LOCATE 20, 24
COLOR 7, 2
PRINT "PLEASE ENTER THE "; CHR$(34); "RIGHT"; CHR$(34); " KEY"
DO
r$ = INKEY$
LOOP UNTIL r$ <> ""
COLOR 15, 2
CLS
LOCATE 16, 32
PRINT "KEY CONFIG"
LOCATE 20, 26
COLOR 7, 2
PRINT "PLEASE ENTER THE "; CHR$(34); "UP"; CHR$(34); " KEY"
DO
u$ = INKEY$
LOOP UNTIL u$ <> ""
COLOR 15, 2
CLS
LOCATE 16, 32
PRINT "KEY CONFIG"
LOCATE 20, 25
COLOR 7, 2
PRINT "PLEASE ENTER THE "; CHR$(34); "DOWN"; CHR$(34); " KEY"
DO
d$ = INKEY$
LOOP UNTIL d$ <> ""
COLOR 15, 2
CLS
LOCATE 16, 32
PRINT "PLEASE ENTER YOUR FORENAME"
LOCATE 20, 32
COLOR 7, 2
PRINT "MY FORENAME IS"
DO
LOCATE 20, 48
INPUT forename$
LOOP UNTIL forename$ <> ""
COLOR 15, 2
CLS
LOCATE 16, 32
PRINT "PLEASE ENTER YOUR SURNAME"
LOCATE 20, 32
COLOR 7, 2
PRINT "MY SURNAME IS"
DO
LOCATE 20, 48
INPUT surname$
LOOP UNTIL surname$ <> ""

210 COLOR 15, 2
CLS
os = 1
180 COLOR 15, 2
LOCATE 16, 28
PRINT "SELECT GAME MODE"
IF os = 1 THEN COLOR 2, 7 ELSE COLOR 7, 2
LOCATE 20, 28
PRINT "PLAY NOW"
IF os = 2 THEN COLOR 2, 7 ELSE COLOR 7, 2
LOCATE 22, 28
PRINT "TOURNAMENT MODE"
IF os = 3 THEN COLOR 2, 7 ELSE COLOR 7, 2
LOCATE 24, 28
PRINT "CAREER MODE"
IF os = 4 THEN COLOR 2, 7 ELSE COLOR 7, 2
LOCATE 26, 28
PRINT "TRAINING MODE"
IF os = 5 THEN COLOR 2, 7 ELSE COLOR 7, 2
LOCATE 28, 28
PRINT "CHALLENGE MODE"
IF os = 6 THEN COLOR 2, 7 ELSE COLOR 7, 2
LOCATE 30, 28
PRINT "QUIT GAME"

170 SELECT CASE INKEY$
CASE IS = u$
os = os - 1
IF os < 1 THEN os = 6
GOTO 180
CASE IS = d$
os = os + 1
IF os > 6 THEN os = 1
GOTO 180
CASE IS = CHR$(13)
CASE ELSE
GOTO 170
END SELECT

challenge = 0
SELECT CASE os
CASE IS = 1
CALL preMatchDay
GOTO 180
CASE IS = 2
CALL tournament
GOTO 180
CASE IS = 3
REM CALL career
GOTO 180
CASE IS = 4
CALL training
GOTO 180
CASE IS = 5
CALL challengeMode
GOTO 180
CASE IS = 6
COLOR 7, 2
END
END SELECT

SUB backWallRally
450 a = 37
b = 32
y = 36
z = 40
t = 0
w = 26
x = 1
bs = 1
rally = 0
rallyEnd = 0
alreadyAdded = 0
hitTarget = 0
totals = 0
speed = 0
direction = 1
directionbs = 1

COLOR 15, 2
CLS

LOCATE 16, 24
PRINT "BACK WALL RALLY"
COLOR 7, 2
LOCATE 20, 24
PRINT "Rally with the back wall as many times as"
LOCATE 21, 24
PRINT "possible before the ball goes out, or you"
LOCATE 22, 24
PRINT "miss the ball. Every time the ball makes"
LOCATE 23, 24
PRINT "contact with the back wall, you will score"
LOCATE 24, 24
PRINT "a point. The higher your score at the end,"
LOCATE 25, 24
PRINT "the better. However, it's not that simple -"
LOCATE 26, 24
PRINT "throughout your rally, a solid object will"
LOCATE 27, 24
PRINT "be bouncing between the walls and gradally"
LOCATE 28, 24
PRINT "increasing in size. Hit the object and it's"
LOCATE 29, 24
PRINT "game over!"
COLOR 15, 2
LOCATE 33, 24
PRINT "PRESS RETURN TO BEGIN BACK WALL RALLY"
DO
LOOP UNTIL INKEY$ = CHR$(13)

alreadyAdded = 0
COLOR 15, 2
CLS
FOR i = 2 TO 20
COLOR 1, 15
LOCATE 2, i
PRINT CHR$(219)
NEXT i
COLOR 15, 1
LOCATE 2, 2
PRINT surname$

tt = TIMER
DO
LOCATE 2, 21
COLOR 15, 3
PRINT "  RALLY "; rally

FOR i = 1 TO bs
COLOR 14, 2
LOCATE w, x + i
PRINT CHR$(219)
NEXT i

FOR i = 1 TO 17
COLOR userColour, 2
IF b + i > 0 AND b + i < 81 THEN LOCATE a, b + i
COLOR 6, 2
IF b + i > 0 AND b + i < 81 THEN PRINT CHR$(223)
NEXT i

LOCATE y, z
COLOR 10, 2
PRINT "o"

SELECT CASE INKEY$
CASE IS = l$
FOR i = 1 TO 17
IF b + i > 0 AND b + i < 81 THEN LOCATE a, b + i
COLOR 6, 2
IF b + i > 0 AND b + i < 81 THEN PRINT " "
NEXT i
b = b - 1
CASE IS = r$
FOR i = 1 TO 17
IF b + i > 0 AND b + i < 81 THEN LOCATE a, b + i
COLOR 6, 2
IF b + i > 0 AND b + i < 81 THEN PRINT " "
NEXT i
b = b + 1
CASE IS = CHR$(13)
IF y < b - 3 THEN GOTO 350
IF y > b + 13 THEN GOTO 350
IF speed <> 0 THEN GOTO 350
speed = 10
ballHit = b - z + 9
directionlr = 1
FOR i = 1 TO 8
IF ballHit = -i THEN directionlr = 2
IF ballHit = -i THEN ballHit = i
NEXT i
350 END SELECT

IF speed = 0 THEN GOTO 360
moveAmount = (15 - speed) / 200
moveAmount = INT(moveAmount * 1000) / 1000
SELECT CASE TIMER
CASE IS >= t + moveAmount
COLOR 2, 2
LOCATE y, z
PRINT " "
IF direction = 1 THEN y = y - 1 ELSE y = y + 1
t = TIMER
totals = totals + 1
END SELECT

SELECT CASE totals
CASE IS >= changeAmount
COLOR 2, 2
LOCATE y, z
PRINT " "
IF directionlr = 1 THEN z = z - 1 ELSE z = z + 1
IF ballHit = 8 AND directionlr = 1 AND serveHit <> 1 THEN z = z - 1
IF ballHit = 8 AND directionlr = 2 AND serveHit <> 1 THEN z = z + 1
totals = 0
END SELECT

hit1 = 0
IF y = a - 1 AND z <= b + 17 AND z >= b + 1 THEN hit1 = 1 ELSE hit1 = 0
SELECT CASE hit1
CASE IS = 1
ballHit = b - z + 9
directionlr = 1
direction = 1
FOR i = 1 TO 8
IF ballHit = -i THEN directionlr = 2
IF ballHit = -i THEN ballHit = i
NEXT i
END SELECT
360 IF ballHit = 0 THEN changeAmount = 100 ELSE changeAmount = 9 - ballHit
IF b < -12 THEN b = -12
IF b > 75 THEN b = 75
IF d < -12 THEN d = -12
IF d > 75 THEN d = 75
IF y < 1 THEN y = 1
IF y > 47 THEN y = 47
IF z < 1 THEN z = 1
IF z > 80 THEN z = 80
IF y = 3 THEN direction = 2
IF y = 3 AND alreadyAdded = 0 THEN rally = rally + 1
IF y = 3 AND alreadyAdded = 0 THEN alreadyAdded = 1
IF y = 4 THEN alreadyAdded = 0
outOfBounds = 0
IF y > 42 THEN outOfBounds = 1
IF z < 2 THEN outOfBounds = 1
IF z > 79 THEN outOfBounds = 1

FOR i = 1 TO bs
COLOR 2, 2
IF y = w AND z = x + i THEN rallyEnd = 1
NEXT i

SELECT CASE outOfBounds
CASE IS = 1
rallyEnd = 1
speed = 0
a = 37
b = 32
y = 36
z = 40
t = 0
totals = 0
speed = 0
direction = 1
alreadyAdded = 0
COLOR 15, 2
CLS
FOR i = 2 TO 20
COLOR 1, 15
LOCATE 2, i
PRINT CHR$(219)
NEXT i
COLOR 15, 1
LOCATE 2, 2
PRINT surname$
END SELECT

SELECT CASE TIMER - tt
CASE IS >= .005
FOR i = 1 TO bs
COLOR 2, 2
LOCATE w, x + i
PRINT " "
NEXT i
IF directionbs = 1 THEN x = x + 1 ELSE x = x - 1
tt = TIMER
END SELECT

IF directionbs = 2 THEN GOTO 400
SELECT CASE x + bs
CASE IS >= 80
directionbs = 2
END SELECT
400 IF directionbs = 1 THEN GOTO 410
SELECT CASE x
CASE IS <= 1
directionbs = 1
bs = bs + 1
END SELECT
410 LOOP UNTIL rallyEnd = 1

COLOR 15, 2
CLS
FOR i = 2 TO 20
COLOR 1, 15
LOCATE 2, i
PRINT CHR$(219)
NEXT i
COLOR 15, 1
LOCATE 2, 2
PRINT surname$
LOCATE 2, 21
COLOR 15, 3
PRINT "  RALLY "; rally

COLOR 15, 2
LOCATE 16, 24
SELECT CASE rally
CASE IS > 29
PRINT "THAT WAS AN UNBELIEVEABLE EFFORT! WELL PLAYED!"
CASE 24 TO 29
PRINT "WELL DONE! THAT WAS AN EXCELLENT PERFORMANCE."
CASE 19 TO 23
PRINT "VERY IMPRESSIVE! YOU SHOULD BE PLEASED WITH THAT SCORE."
CASE 16 TO 18
PRINT "GOOD SCORE, BUT STILL A LOT OF IMPROVEMENT TO BE MADE."
CASE 12 TO 15
PRINT "NOT A BAD SCORE, BUT YOU CAN DO MUCH BETTER."
CASE 9 TO 11
PRINT "BY NO MEANS IMPRESSIVE. TRY AGAIN."
CASE 6 TO 8
PRINT "THAT WAS ABSOLUTLY DREADFUL. ENOUGH SAID."
CASE 3 TO 5
PRINT "THAT WAS SHOCKING. HAVE YOU EVER PLAYED THIS GAME BEFORE?"
CASE 0 TO 2
PRINT "THE ONLY WAS TO DESCRIBE THAT PERFORMANCE IS EMBARRASING."
END SELECT

LOCATE 20, 24
PRINT "YOUR SCORE:"
COLOR 7, 2
LOCATE 20, 36
PRINT rally
LOCATE 28, 24
PRINT "PRESS RETURN TO GO BACK TO THE MAIN MENU"
LOCATE 30, 24
PRINT "PRESS SPACE TO TRY BACK WALL RALLY AGAIN"
440 SELECT CASE INKEY$
CASE IS = CHR$(13)
CASE IS = CHR$(32)
GOTO 450
CASE ELSE
GOTO 440
END SELECT
END SUB

SUB calender
COLOR 15, 2
CLS
LOCATE 2, 5
PRINT forename$(32); " "; surname$(32); "        "; day; " "; month$(month); " "; year
LOCATE 5, 5
PRINT "CALENDER"
LOCATE 9, 5
PRINT "DATE"
LOCATE 9, 20
PRINT "TOURNAMENT"
LOCATE 9, 60
PRINT "QUALIFICATION"

FOR i = 1 TO 24
IF qual(i) = 1 THEN COLOR 15, 2 ELSE COLOR 7, 2
LOCATE i + 10, 4
PRINT day(i); month$(month(i))
LOCATE i + 10, 20
PRINT tourney$(i)
LOCATE i + 10, 60
PRINT qual$(qual(i))
NEXT i
DO
LOOP UNTIL INKEY$ = CHR$(13)
COLOR 15, 2
CLS
END SUB

SUB career
os = 1
COLOR 15, 2
CLS
470 COLOR 15, 2
LOCATE 16, 24
PRINT "CAREER MODE"
COLOR 7, 2
IF os = 1 THEN COLOR 2, 7 ELSE COLOR 7, 2
LOCATE 20, 24
PRINT "NEW CAREER"
IF os = 2 THEN COLOR 2, 7 ELSE COLOR 7, 2
LOCATE 22, 24
PRINT "LOAD CAREER"

460 SELECT CASE INKEY$
CASE IS = u$
os = os - 1
IF os < 1 THEN os = 2
GOTO 470
CASE IS = d$
os = os + 1
IF os > 2 THEN os = 1
GOTO 470
CASE IS = CHR$(13)
CASE ELSE
GOTO 460
END SELECT

SELECT CASE os
CASE IS = 1
CASE IS = 2
GOTO 470
END SELECT
year = 2006
day = 1
month = 1
forename$(32) = forename$
surname$(32) = surname$

DO
z = 0
arp(i) = 0
FOR i = 1 TO 32
FOR j = 1 TO 9
arp(i) = arp(i) + rankPoints(j, i)
NEXT j
arp(i) = INT(arp(i) / 10)
minorRating(i) = i / 1000
NEXT i
FOR i = 1 TO 32
rank(i) = 33
NEXT i
FOR i = 1 TO 32
FOR j = 1 TO 32
IF arp(i) + minorRating(i) >= arp(j) + minorRating(j) THEN rank(i) = rank(i) - 1
NEXT j
NEXT i

DO
COLOR 15, 2
CLS
os = 1
490 COLOR 15, 2
LOCATE 2, 24
PRINT forename$(32); " "; surname$(32); "        "; day; month$(month); year
LOCATE 16, 24
PRINT "CAREER MODE"
COLOR 7, 2
LOCATE 20, 24
IF os = 1 THEN COLOR 2, 7 ELSE COLOR 7, 2
PRINT "CALENDER"
LOCATE 22, 24
IF os = 2 THEN COLOR 2, 7 ELSE COLOR 7, 2
PRINT "PLAYER STATISTICS"
LOCATE 24, 24
IF os = 3 THEN COLOR 2, 7 ELSE COLOR 7, 2
PRINT "WORLD RANKINGS"
LOCATE 26, 24
IF os = 4 THEN COLOR 2, 7 ELSE COLOR 7, 2
PRINT "GO TO NEXT TOURNAMENT"
LOCATE 28, 24
IF os = 5 THEN COLOR 2, 7 ELSE COLOR 7, 2
PRINT "CAREER OPTIONS"
LOCATE 30, 24
IF os = 6 THEN COLOR 2, 7 ELSE COLOR 7, 2
PRINT "QUIT CAREER"

480 SELECT CASE INKEY$
CASE IS = u$
os = os - 1
IF os < 1 THEN os = 6
GOTO 490
CASE IS = d$
os = os + 1
IF os > 6 THEN os = 1
GOTO 490
CASE IS = CHR$(13)
CASE ELSE
GOTO 480
END SELECT

SELECT CASE os
CASE IS = 1
CALL calender
os = 1
GOTO 490
CASE IS = 3
CALL worldRankings
os = 3
GOTO 490
CASE IS = 4
z = 1
GOTO 490
CASE IS = 6
GOTO 500
CASE ELSE
GOTO 490
END SELECT
week = week + 1
IF week = 53 THEN year = year + 1
IF week = 53 THEN week = 1
LOOP UNTIL z = 1
LOOP UNTIL year = 11
500 COLOR 15, 2
CLS
END SUB

SUB challengeMatchDay
COLOR 15, 2
CLS
LOCATE 16, 24
IF cCompleted(challenge) = 1 THEN PRINT "MATCH "; challenge; " (Completed)" ELSE PRINT "MATCH "; challenge; " (Not Completed)"
COLOR 7, 2
FOR i = 1 TO cAmount(challenge)
LOCATE (i * 2) + 18, 24
PRINT cDescription$(i, challenge)
NEXT i
LOCATE 36, 24
COLOR 15, 2
PRINT "PRESS RETURN TO GO TO THE MATCH"
DO
LOOP UNTIL INKEY$ = CHR$(13)
CALL matchDay
END SUB

SUB challengeMode
os = 1
610 COLOR 15, 2
CLS
LOCATE 16, 24
PRINT "CHALLENGE MODE"
FOR i = 1 TO 6
LOCATE (i * 2) + 18, 24
IF os = i THEN COLOR 2, 7 ELSE COLOR 7, 2
IF cCompleted(i) = 1 THEN PRINT "MATCH "; i; " (Completed)" ELSE PRINT "MATCH "; i; " (Not Completed)"
NEXT i
LOCATE 32, 24
IF os = 7 THEN COLOR 2, 7 ELSE COLOR 7, 2
PRINT "RETURN TO MAIN MENU"

600 SELECT CASE INKEY$
CASE IS = u$
os = os - 1
IF os < 1 THEN os = 7
GOTO 610
CASE IS = d$
os = os + 1
IF os > 7 THEN os = 1
GOTO 610
CASE IS = CHR$(13)
CASE ELSE
GOTO 600
END SELECT

SELECT CASE os
CASE IS = 7
CASE ELSE
challenge = os
CALL challengeMatchDay
END SELECT
COLOR 15, 2
CLS
END SUB















SUB getInfo
OPEN "t.txt" FOR INPUT AS #1
FOR i = 1 TO 31
INPUT #1, forename$(i)
INPUT #1, surname$(i)
INPUT #1, speedRating(i)
INPUT #1, power(i)
INPUT #1, accuracy(i)
INPUT #1, arp(i)
NEXT i
CLOSE
FOR i = 1 TO 31
speed(i) = 11 - speedRating(i)
speed(i) = speed(i) * 25
NEXT i
round$(1) = "ROUND 1"
round$(2) = "ROUND 2"
round$(3) = "QUARTER-FINALS"
round$(4) = "SEMI-FINALS"
round$(5) = "FINAL"
FOR j = 1 TO 32
FOR i = 1 TO 10
rankPoints(i, j) = arp(j)
NEXT i
NEXT j

'OPEN "t2.txt" FOR INPUT AS #1
'FOR i = 1 TO 24
'INPUT #1, day(i)
'INPUT #1, month(i)
'INPUT #1, qual(i)
'INPUT #1, tourney$(i)
'NEXT i
'CLOSE

month$(1) = "JANUARY"
days(1) = 31
month$(2) = "FEBRUARY"
days(2) = 28
month$(3) = "MARCH"
days(3) = 31
month$(4) = "APRIL"
days(4) = 30
month$(5) = "MAY"
days(5) = 31
month$(6) = "JUNE"
days(6) = 30
month$(7) = "JULY"
days(7) = 31
month$(8) = "AUGUST"
days(8) = 31
month$(9) = "SEPTEMBER"
days(9) = 30
month$(10) = "OCTOBER"
days(10) = 31
month$(11) = "NOVEMBER"
days(11) = 30
month$(12) = "DECEMBER"
days(12) = 31

qual$(1) = "No qualification"
qual$(2) = "1-16 in Rankings"
qual$(3) = "17-32 in Rankings"
qual$(4) = "1-10 in Rankings"
qual$(5) = "11-20 in Rankings"
qual$(6) = "21-32 in Rankings"

entrants(1) = 32
entrants(2) = 16
entrants(3) = 16
entrants(4) = 8
entrants(5) = 8
entrants(6) = 8

rounds(1) = 5
rounds(2) = 4
rounds(3) = 4
rounds(4) = 3
rounds(5) = 3
rounds(6) = 3

OPEN "t3.txt" FOR INPUT AS #1
FOR i = 1 TO 6
INPUT #1, cPlayerNumber(1, i)
INPUT #1, cGames(1, i)
INPUT #1, cSets(1, i)
INPUT #1, cPlayerNumber(2, i)
INPUT #1, cGames(2, i)
INPUT #1, cSets(2, i)
INPUT #1, cGamesToWin(i)
INPUT #1, cSetsToWin(i)
INPUT #1, cAmount(i)
FOR j = 1 TO cAmount(i)
INPUT #1, cDescription$(j, i)
NEXT j
cCompleted(i) = 0
NEXT i
CLOSE
END SUB


















SUB matchDay
IF challenge > 0 THEN oGamesToWin = gamesToWin
IF challenge > 0 THEN gamesToWin = cGamesToWin(challenge)
IF challenge > 0 THEN oSetsToWin = setsToWin
IF challenge > 0 THEN setsToWin = cSetsToWin(challenge)
IF challenge > 0 THEN oForename$ = forename$
IF challenge > 0 THEN forename$ = forename$(cPlayerNumber(1, challenge))
IF challenge > 0 THEN oSurname$ = surname$
IF challenge > 0 THEN surname$ = surname$(cPlayerNumber(1, challenge))
IF challenge > 0 THEN opponent = cPlayerNumber(2, challenge)
FOR i = 1 TO 2
points(i) = 0
realPoints$(i) = ""
IF challenge > 0 THEN games(i) = cGames(i, challenge) ELSE games(i) = 0
IF challenge > 0 THEN sets(i) = cSets(i, challenge) ELSE sets(i) = 0
winners(i) = 0
aces(i) = 0
faults(i) = 0
errors(i) = 0
NEXT i

side = 1
speed = 0
serve = 1
serveHit = 0
direction = 1
realPoints$(1) = "0"
realPoints$(2) = "0"

COLOR 0, 2
CLS
DO
SELECT CASE speed
CASE IS = 0
a = 37
b = 32
c = 16
IF serve = 1 THEN d = 32 ELSE d = rand(12) + 25
IF serve = 1 THEN y = 36 ELSE y = 17
z = 41
END SELECT
total = 0
totals = 0
moveAmount = 0
tt = 0
t = 0
noOutChance = 0

COLOR 0, 2
CLS
FOR i = 1 TO 2
LOCATE 1 + i, 2
COLOR 7, 1
PRINT "                  "
LOCATE 1 + i, 2
COLOR 7, 1
IF i = 1 AND serve = 1 THEN PRINT surname$; " *"
IF i = 1 AND serve = 2 THEN PRINT surname$
IF i = 2 AND serve = 1 THEN PRINT surname$(opponent);
IF i = 2 AND serve = 2 THEN PRINT surname$(opponent); " *"
LOCATE 1 + i, 20
COLOR 7, 3
PRINT "    "
LOCATE 1 + i, 21
COLOR 7, 3
PRINT realPoints$(i)
LOCATE 1 + i, 24
COLOR 7, 4
PRINT "    "
COLOR 7, 4
LOCATE 1 + i, 24
PRINT games(i)
LOCATE 1 + i, 28
COLOR 7, 6
PRINT "    "
COLOR 7, 6
LOCATE 1 + i, 28
PRINT sets(i)
IF i = 1 THEN j = 2 ELSE j = 1
SELECT CASE realPoints$(i)
CASE IS = "A"
LOCATE 1 + i, 32
COLOR 7, 6
PRINT "ADVANTAGE"
CASE IS = "40"
LOCATE 1 + i, 32
COLOR 7, 6
IF realPoints$(j) <> "40" AND realPoints$(j) <> "A" AND serve = i THEN PRINT "GAME POINT"
IF realPoints$(j) <> "40" AND realPoints$(j) <> "A" AND serve <> i THEN PRINT "BREAK POINT"
LOCATE 1 + i, 32
IF realPoints$(j) <> "40" AND realPoints$(j) <> "A" AND gamesToWin - games(i) = 1 AND setsToWin - sets(i) = 1 THEN PRINT "MATCH POINT"
LOCATE 1 + i, 32
IF realPoints$(j) <> "40" AND realPoints$(j) <> "A" AND gamesToWin - games(i) = 1 AND setsToWin - sets(i) <> 1 THEN PRINT "           "
LOCATE 1 + i, 32
IF realPoints$(j) <> "40" AND realPoints$(j) <> "A" AND gamesToWin - games(i) = 1 AND setsToWin - sets(i) <> 1 THEN PRINT "SET POINT  "
END SELECT
NEXT i

winner = 0
ttt = TIMER
DO

FOR i = 1 TO 17
IF b + i > 0 AND b + i < 81 THEN LOCATE a, b + i
COLOR userColour, 2
IF b + i > 0 AND b + i < 81 THEN PRINT CHR$(223)
NEXT i
FOR i = 1 TO 17
IF d + i > 0 AND d + i < 81 THEN LOCATE c, d + i
COLOR opponentColour, 2
IF d + i > 0 AND d + i < 81 THEN PRINT CHR$(220)
NEXT i
LOCATE y, z
COLOR 10, 2
PRINT CHR$(111)

zz = 0
DO
SELECT CASE INKEY$
CASE IS = l$
zz = 1
FOR i = 1 TO 17
IF b + i > 0 AND b + i < 81 THEN LOCATE a, b + i
COLOR 6, 2
IF b + i > 0 AND b + i < 81 THEN PRINT " "
NEXT i
b = b - 1
CASE IS = r$
zz = 1
FOR i = 1 TO 17
IF b + i > 0 AND b + i < 81 THEN LOCATE a, b + i
COLOR 6, 2
IF b + i > 0 AND b + i < 81 THEN PRINT " "
NEXT i
b = b + 1
CASE IS = CHR$(13)
IF speed <> 0 THEN GOTO 80
IF y < b - 4 THEN GOTO 80
IF y > b + 12 THEN GOTO 80
IF serve = 1 AND speed = 0 THEN direction = 1
IF serve = 1 AND speed = 0 THEN serveHit = 1
IF serve = 1 AND speed = 0 THEN speed = 10
longHit = rand(12 - accuracy(opponent))
SELECT CASE longHit
CASE IS = 1
IF d > 28 THEN sideHit = 1 ELSE sideHit = 2
290 IF sideHit = 1 THEN e = rand(3) + 0 ELSE e = rand(3) + 14
IF e = 1 OR e = 17 THEN GOTO 290
CASE ELSE
e = rand(17)
END SELECT

ballHit = b - z + 9
directionlr = 1
FOR i = 1 TO 8
IF ballHit = -i THEN directionlr = 2
IF ballHit = -i THEN ballHit = i
NEXT i
IF ballHit = 0 THEN changeAmount = 100 ELSE changeAmount = 9 - ballHit
80 END SELECT

IF speed = 0 THEN GOTO 40
moveAmount = (15 - speed) / 200
moveAmount = INT(moveAmount * 1000) / 1000
SELECT CASE TIMER
CASE IS >= t + moveAmount
zz = 1
COLOR 2, 2
LOCATE y, z
PRINT " "
IF direction = 1 THEN y = y - 1 ELSE y = y + 1
t = TIMER
totals = totals + 1
END SELECT

IF zz = 1 THEN GOTO 140
SELECT CASE totals
CASE IS >= changeAmount
zz = 1
COLOR 2, 2
LOCATE y, z
PRINT " "
IF directionlr = 1 THEN z = z - 1 ELSE z = z + 1
IF ballHit = 8 AND directionlr = 1 AND serveHit <> 1 THEN z = z - 1
IF ballHit = 8 AND directionlr = 2 AND serveHit <> 1 THEN z = z + 1
totals = 0
END SELECT

IF zz = 1 THEN GOTO 140
40 IF serve = 1 AND speed = 0 THEN GOTO 140
fatigue = INT(TIMER - ttt)
IF fatigue > 40 THEN fatigue = 40
opponentMove = rand(speed(opponent) + fatigue)
SELECT CASE opponentMove
CASE IS = 1
zz = 1
IF speed <> 0 THEN GOTO 100
IF tt > 0 THEN GOTO 110
tt = TIMER
110 IF TIMER - tt < 1.5 THEN GOTO 100
direction = 2
speed = 10
ballHit = d - z + 9
serveHit = 1
serveNow = 1
100 IF speed = 0 THEN GOTO 120
FOR i = 1 TO 17
IF d + i > 0 AND d + i < 81 THEN LOCATE c, d + i
COLOR 2, 2
IF d + i > 0 AND d + i < 81 AND d + e <> z THEN PRINT " "
NEXT i
SELECT CASE d + e
CASE IS < z
d = d + 1
CASE IS > z
d = d - 1
END SELECT
120 END SELECT
140 LOOP UNTIL zz = 1

90 IF y = c + 1 AND z <= d + 17 AND z >= d + 1 THEN hit2 = 1 ELSE hit2 = 0
IF y = a - 1 AND z <= b + 17 AND z >= b + 1 THEN hit1 = 1 ELSE hit1 = 0

SELECT CASE hit1
CASE IS = 1
serveHit = 0
longHit = rand(12 - accuracy(opponent))
SELECT CASE longHit
CASE IS = 1
IF d > 28 THEN sideHit = 1 ELSE sideHit = 2
280 IF sideHit = 1 THEN e = rand(4) + 0 ELSE e = rand(4) + 13
IF e = 1 AND d < 50 AND d > 30 THEN GOTO 280
IF e = 17 AND d < 50 AND d > 30 THEN GOTO 280
CASE ELSE
e = rand(17)
END SELECT
END SELECT

SELECT CASE hit2
CASE IS = 1
IF serveNow = 0 THEN serveHit = 0
ballHit = d - z + 9
direction = 2
IF speed <> 0 THEN speed = power(opponent)
END SELECT
SELECT CASE hit1
CASE IS = 1
ballHit = b - z + 9
direction = 1
IF speed <> 0 THEN speed = 10
END SELECT
serveNow = 0

IF hit2 = 0 AND hit1 = 0 THEN GOTO 50
directionlr = 1
FOR i = 1 TO 8
IF ballHit = -i THEN directionlr = 2
IF ballHit = -i THEN ballHit = i
NEXT i

50 IF ballHit = 0 THEN changeAmount = 100 ELSE changeAmount = 9 - ballHit
IF b < -12 THEN b = -12
IF b > 75 THEN b = 75
IF d < -12 THEN d = -12
IF d > 75 THEN d = 75
IF y < 6 THEN y = 6
IF y > 47 THEN y = 47
IF z < 1 THEN z = 1
IF z > 80 THEN z = 80

IF winner > 0 THEN GOTO 160
finish = 0
IF y = 15 THEN winner = 1
IF y = 15 AND serveHit <> 1 THEN winners(1) = winners(1) + 1
IF y = 15 AND serveHit = 1 THEN aces(1) = aces(1) + 1
IF y = 38 THEN winner = 2
IF y = 38 AND serveHit <> 1 THEN winners(2) = winners(2) + 1
IF y = 38 AND serveHit = 1 THEN aces(2) = aces(2) + 1
IF y = 15 THEN noOutChance = 1
IF y = 38 THEN noOutChance = 1
IF z <= 1 AND direction = 1 THEN winner = 2
IF z <= 1 AND direction = 1 AND serveHit <> 1 THEN errors(1) = errors(1) + 1
IF z <= 1 AND direction = 1 AND serveHit = 1 THEN faults(1) = faults(1) + 1
IF z <= 1 AND direction = 2 THEN winner = 1
IF z <= 1 AND direction = 2 AND serveHit <> 1 THEN errors(2) = errors(2) + 1
IF z <= 1 AND direction = 2 AND serveHit = 1 THEN faults(2) = faults(2) + 1
IF z >= 80 AND direction = 1 THEN winner = 2
IF z >= 80 AND direction = 1 AND serveHit <> 1 THEN errors(1) = errors(1) + 1
IF z >= 80 AND direction = 1 AND serveHit = 1 THEN faults(1) = faults(1) + 1
IF z >= 80 AND direction = 2 THEN winner = 1
IF z >= 80 AND direction = 2 AND serveHit <> 1 THEN errors(2) = errors(2) + 1
IF z >= 80 AND direction = 2 AND serveHit = 1 THEN faults(2) = faults(2) + 1
160 IF y = 6 THEN finish = 1
IF y = 47 THEN finish = 2
IF z <= 1 AND direction = 1 THEN finish = 2
IF z <= 1 AND direction = 2 THEN finish = 1
IF z >= 80 AND direction = 1 THEN finish = 2
IF z >= 80 AND direction = 2 THEN finish = 1
IF noOutChance = 1 THEN GOTO 240
SELECT CASE winner
CASE IS > 0
LOCATE 24, 38
COLOR 15, 2
PRINT "OUT!"
FOR t = 1 TO 180000
NEXT t
END SELECT
240 SELECT CASE y
CASE IS <= 15
LOCATE 24, 38
COLOR 15, 2
IF serveHit = 1 THEN PRINT "ACE!"
CASE IS >= 38
LOCATE 24, 38
COLOR 15, 2
IF serveHit = 1 THEN PRINT "ACE!"
END SELECT
LOOP UNTIL finish <> 0

points(winner) = points(winner) + 1
SELECT CASE points(winner)
CASE IS = 4
IF winner = 1 THEN loser = 2 ELSE loser = 1
SELECT CASE points(loser)
CASE IS = 4
points(winner) = 3
points(loser) = 3
CASE IS < 3
points(winner) = 5
END SELECT
END SELECT

FOR i = 1 TO 2
SELECT CASE points(i)
CASE IS = 0
realPoints$(i) = "0"
CASE IS = 1
realPoints$(i) = "15"
CASE IS = 2
realPoints$(i) = "30"
CASE IS = 3
realPoints$(i) = "40"
CASE IS = 4
realPoints$(i) = "A"
CASE IS = 5
points(1) = 0
points(2) = 0
realPoints$(1) = "0"
realPoints$(2) = "0"
games(i) = games(i) + 1
IF serve = 1 THEN serve = 2 ELSE serve = 1
END SELECT
IF games(i) = gamesToWin THEN sets(i) = sets(i) + 1
IF games(i) = gamesToWin THEN games(1) = 0
IF games(i) = gamesToWin THEN games(2) = 0
NEXT i
speed = 0
LOOP UNTIL sets(1) = 1 OR sets(2) = setsToWin

COLOR 0, 2
CLS
FOR i = 1 TO 2
LOCATE 1 + i, 2
COLOR 7, 1
PRINT "                  "
LOCATE 1 + i, 2
COLOR 7, 1
IF i = 1 AND serve = 1 THEN PRINT surname$; " *"
IF i = 1 AND serve = 2 THEN PRINT surname$
IF i = 2 AND serve = 1 THEN PRINT surname$(opponent);
IF i = 2 AND serve = 2 THEN PRINT surname$(opponent); " *"
LOCATE 1 + i, 20
COLOR 7, 3
PRINT "    "
LOCATE 1 + i, 21
COLOR 7, 3
PRINT realPoints$(i)
LOCATE 1 + i, 24
COLOR 7, 4
PRINT "    "
COLOR 7, 4
LOCATE 1 + i, 24
PRINT games(i)
LOCATE 1 + i, 28
COLOR 7, 6
PRINT "    "
COLOR 7, 6
LOCATE 1 + i, 28
PRINT sets(i)
NEXT i
COLOR 15, 2
LOCATE 30, 20
SELECT CASE sets(1)
CASE IS > sets(2)
IF challenge = 1 THEN cCompleted(challenge) = 1
PRINT forename$; " "; surname$; " BEAT "; forename$(opponent); " "; surname$(opponent); " "; sets(1); "-"; sets(2)
CASE ELSE
PRINT forename$(opponent); " "; surname$(opponent); " BEAT "; forename$; " "; surname$; " "; sets(2); "-"; sets(1)
END SELECT
COLOR 7, 2
LOCATE 34, 20
PRINT "PRESS RETURN TO VIEW THE MATCH STATISTICS"
DO
LOOP UNTIL INKEY$ = CHR$(13)

COLOR 15, 2
CLS
FOR i = 1 TO 2
LOCATE 1 + i, 2
COLOR 7, 1
PRINT "                  "
LOCATE 1 + i, 2
COLOR 7, 1
IF i = 1 AND serve = 1 THEN PRINT surname$; " *"
IF i = 1 AND serve = 2 THEN PRINT surname$
IF i = 2 AND serve = 1 THEN PRINT surname$(opponent);
IF i = 2 AND serve = 2 THEN PRINT surname$(opponent); " *"
LOCATE 1 + i, 20
COLOR 7, 3
PRINT "    "
LOCATE 1 + i, 21
COLOR 7, 3
PRINT realPoints$(i)
LOCATE 1 + i, 24
COLOR 7, 4
PRINT "    "
COLOR 7, 4
LOCATE 1 + i, 24
PRINT games(i)
LOCATE 1 + i, 28
COLOR 7, 6
PRINT "    "
COLOR 7, 6
LOCATE 1 + i, 28
PRINT sets(i)
NEXT i

COLOR 15, 2
LOCATE 28, 20
PRINT surname$
LOCATE 28, 48
PRINT surname$(opponent)
LOCATE 30, 33
PRINT "TOTAL SETS"
LOCATE 32, 32
PRINT "TOTAL POINTS"
LOCATE 34, 36
PRINT "ACES"
LOCATE 36, 34
PRINT "WINNERS"
LOCATE 38, 30
PRINT "SERVICE FAULTS"
LOCATE 40, 30
PRINT "UNFORCED ERRORS"
COLOR 7, 2
LOCATE 30, 25
PRINT sets(1)
LOCATE 30, 47
PRINT sets(2)
LOCATE 32, 25
PRINT aces(1) + winners(1) + faults(2) + errors(2)
LOCATE 32, 47
PRINT aces(2) + winners(2) + faults(1) + errors(1)
LOCATE 34, 25
PRINT aces(1)
LOCATE 34, 47
PRINT aces(2)
LOCATE 36, 25
PRINT winners(1)
LOCATE 36, 47
PRINT winners(2)
LOCATE 38, 25
PRINT faults(1)
LOCATE 38, 47
PRINT faults(2)
LOCATE 40, 25
PRINT errors(1)
LOCATE 40, 47
PRINT errors(2)
DO
LOOP UNTIL INKEY$ = CHR$(13)
COLOR 15, 2
CLS
IF challenge > 0 THEN gamesToWin = oGamesToWin
IF challenge > 0 THEN setsToWin = oSetsToWin
IF challenge > 0 THEN forename$ = oForename$
IF challenge > 0 THEN surname$ = oSurname$
END SUB

SUB matchDayMenu
560 os = 1
COLOR 15, 2
CLS
550 LOCATE 16, 24
COLOR 15, 2
PRINT "MATCH DAY"
LOCATE 20, 24
PRINT forename$; " "; surname$; " V "; forename$(opponent); " "; surname$(opponent)
LOCATE 22, 24
PRINT "First to "; gamesToWin; " games"
LOCATE 24, 24
IF setsToWin = 1 THEN PRINT "First to  1  set" ELSE PRINT "First to "; setsToWin; " sets"
LOCATE 30, 24
IF os = 1 THEN COLOR 2, 7 ELSE COLOR 7, 2
PRINT "MATCH OPTIONS"
LOCATE 32, 24
IF os = 2 THEN COLOR 2, 7 ELSE COLOR 7, 2
PRINT "GO TO MATCH"

540 SELECT CASE INKEY$
CASE IS = u$
os = os - 1
IF os < 1 THEN os = 2
GOTO 550
CASE IS = d$
os = os + 1
IF os > 2 THEN os = 1
GOTO 550
CASE IS = CHR$(13)
CASE ELSE
GOTO 540
END SELECT

SELECT CASE os
CASE IS = 1
CALL options
GOTO 560
CASE IS = 2
CALL matchDay
END SELECT
END SUB

SUB options
COLOR 15, 2
os = 1
230 COLOR 15, 2
CLS
IF gamesToWin2 = 1 THEN gamesToWin = 3 ELSE gamesToWin = 6
COLOR 15, 2
LOCATE 16, 32
PRINT "OPTIONS"
IF os = 1 THEN COLOR 2, 7 ELSE COLOR 7, 2
LOCATE 20, 32
PRINT "GAMES IN A SET   : FIRST TO "; gamesToWin
IF os = 2 THEN COLOR 2, 7 ELSE COLOR 7, 2
LOCATE 22, 32
PRINT "SETS IN A MATCH  : FIRST TO "; setsToWin
IF os = 3 THEN COLOR 2, 7 ELSE COLOR 7, 2
LOCATE 24, 32
PRINT "USER'S RACKET    : "; colour$(userColour)
IF os = 4 THEN COLOR 2, 7 ELSE COLOR 7, 2
LOCATE 26, 32
PRINT "OPPONENT'S RACKET: "; colour$(opponentColour)
IF os = 5 THEN COLOR 2, 7 ELSE COLOR 7, 2
LOCATE 28, 32
PRINT "RETURN TO MATCH MENU"

220 SELECT CASE INKEY$
CASE IS = u$
os = os - 1
IF os < 1 THEN os = 5
GOTO 230
CASE IS = d$
os = os + 1
IF os > 5 THEN os = 1
GOTO 230
CASE IS = l$
IF os = 1 THEN gamesToWin2 = gamesToWin2 - 1
IF os = 2 THEN setsToWin = setsToWin - 1
IF gamesToWin2 < 1 THEN gamesToWin2 = 2
IF setsToWin < 1 THEN setsToWin = 3
IF os = 3 THEN userColour = userColour - 1
IF userColour < 3 THEN userColour = 15
IF os = 4 THEN opponentColour = opponentColour - 1
IF opponentColour < 3 THEN opponentColour = 15
GOTO 230
CASE IS = r$
IF os = 1 THEN gamesToWin2 = gamesToWin2 + 1
IF os = 2 THEN setsToWin = setsToWin + 1
IF gamesToWin2 > 2 THEN gamesToWin2 = 1
IF setsToWin > 3 THEN setsToWin = 1
IF os = 3 THEN userColour = userColour + 1
IF userColour > 15 THEN userColour = 3
IF os = 4 THEN opponentColour = opponentColour + 1
IF opponentColour > 15 THEN opponentColour = 3
GOTO 230
CASE IS = CHR$(13)
IF os <> 5 THEN GOTO 220
CASE ELSE
GOTO 220
END SELECT
COLOR 15, 2
CLS
END SUB

SUB preMatchDay
os = 1
COLOR 15, 2
CLS
200 COLOR 15, 2
LOCATE 16, 24
PRINT "SELECT YOUR OPPONENT"
COLOR 7, 2
LOCATE 20, 24
PRINT CHR$(29); " "; forename$(os); " "; surname$(os); " "; CHR$(29); "                    "
LOCATE 24, 24
COLOR 15, 2
PRINT "SPEED:"
LOCATE 26, 24
COLOR 15, 2
PRINT "POWER:"
LOCATE 28, 24
COLOR 15, 2
PRINT "ACCURACY:"
FOR i = 1 TO 10
LOCATE 24, i + 34
COLOR 4, 2
IF i <= speedRating(os) THEN PRINT CHR$(219) ELSE PRINT " "
LOCATE 26, i + 34
COLOR 5, 2
IF i <= power(os) THEN PRINT CHR$(219) ELSE PRINT " "
LOCATE 28, i + 34
COLOR 6, 2
IF i <= accuracy(os) THEN PRINT CHR$(219) ELSE PRINT " "
NEXT i

190 SELECT CASE INKEY$
CASE IS = l$
os = os - 1
IF os < 1 THEN os = 31
GOTO 200
CASE IS = r$
os = os + 1
IF os > 31 THEN os = 1
GOTO 200
CASE IS = CHR$(13)
CASE ELSE
GOTO 190
END SELECT

opponent = os
CALL matchDayMenu
END SUB

FUNCTION rand (c)
RANDOMIZE TIMER
rand = INT(c * RND(1)) + 1
END FUNCTION

SUB targetPractice
430 a = 37
b = 32
score = 0
w = 6
SELECT CASE target
CASE IS > 4
location = rand(2)
IF location = 1 THEN x = rand(16) ELSE x = rand(16) + 55
CASE ELSE
x = rand(68)
END SELECT
y = 36
z = 40
t = 0
alreadyAdded = 0
hitTarget = 0
totals = 0
speed = 0
direction = 1

COLOR 15, 2
CLS

LOCATE 16, 24
PRINT "TARGET PRACTICE"
COLOR 7, 2
LOCATE 20, 24
PRINT "There are 10 targets to hit, each one slightly"
LOCATE 21, 24
PRINT "smaller than the last. Every time you hit the"
LOCATE 22, 24
PRINT "back wall, hit the ball out, or miss the ball,"
LOCATE 23, 24
PRINT "your score will increase by 1 point. The lower"
LOCATE 24, 24
PRINT "your score at the end, the better. Shown next"
LOCATE 25, 24
PRINT "to your name are firstly, the amount of targets"
LOCATE 26, 24
PRINT "you've hit so far, followed by your points."
LOCATE 27, 24
PRINT "Remember to keep your points low!"
COLOR 15, 2
LOCATE 35, 24
PRINT "PRESS RETURN TO BEGIN TARGET PRACTICE"
DO
LOOP UNTIL INKEY$ = CHR$(13)

score = 0
FOR target = 1 TO 10
w = 6
SELECT CASE target
CASE IS > 4
location = rand(2)
IF location = 1 THEN x = rand(16) ELSE x = rand(16) + 55
CASE ELSE
x = rand(68)
END SELECT

alreadyAdded = 0
hitTarget = 0
IF y = w THEN y = y + 2
IF y - w = 1 THEN y = y + 1
COLOR 15, 2
CLS
FOR i = 2 TO 20
COLOR 1, 15
LOCATE 2, i
PRINT CHR$(219)
NEXT i
COLOR 15, 1
LOCATE 2, 2
PRINT surname$

DO
LOCATE 2, 21
COLOR 15, 4
PRINT target - 1
LOCATE 2, 24
COLOR 15, 5
PRINT "  SCORE "; score

FOR i = 1 TO 11 - target
LOCATE w, x + i
COLOR target + 2, 2
PRINT CHR$(219)
NEXT i

FOR i = 1 TO 17
COLOR userColour, 2
IF b + i > 0 AND b + i < 81 THEN LOCATE a, b + i
COLOR 6, 2
IF b + i > 0 AND b + i < 81 THEN PRINT CHR$(223)
NEXT i

LOCATE y, z
COLOR 10, 2
PRINT "o"

SELECT CASE INKEY$
CASE IS = l$
FOR i = 1 TO 17
IF b + i > 0 AND b + i < 81 THEN LOCATE a, b + i
COLOR 6, 2
IF b + i > 0 AND b + i < 81 THEN PRINT " "
NEXT i
b = b - 1
CASE IS = r$
FOR i = 1 TO 17
IF b + i > 0 AND b + i < 81 THEN LOCATE a, b + i
COLOR 6, 2
IF b + i > 0 AND b + i < 81 THEN PRINT " "
NEXT i
b = b + 1
CASE IS = CHR$(13)
IF y < b - 3 THEN GOTO 330
IF y > b + 13 THEN GOTO 330
IF speed <> 0 THEN GOTO 330
speed = 10
ballHit = b - z + 9
directionlr = 1
FOR i = 1 TO 8
IF ballHit = -i THEN directionlr = 2
IF ballHit = -i THEN ballHit = i
NEXT i
330 END SELECT

IF speed = 0 THEN GOTO 320
moveAmount = (15 - speed) / 200
moveAmount = INT(moveAmount * 1000) / 1000
SELECT CASE TIMER
CASE IS >= t + moveAmount
COLOR 2, 2
LOCATE y, z
PRINT " "
IF direction = 1 THEN y = y - 1 ELSE y = y + 1
t = TIMER
totals = totals + 1
END SELECT

SELECT CASE totals
CASE IS >= changeAmount
COLOR 2, 2
LOCATE y, z
PRINT " "
IF directionlr = 1 THEN z = z - 1 ELSE z = z + 1
IF ballHit = 8 AND directionlr = 1 AND serveHit <> 1 THEN z = z - 1
IF ballHit = 8 AND directionlr = 2 AND serveHit <> 1 THEN z = z + 1
totals = 0
END SELECT

hit1 = 0
IF y = a - 1 AND z <= b + 17 AND z >= b + 1 THEN hit1 = 1 ELSE hit1 = 0
SELECT CASE hit1
CASE IS = 1
ballHit = b - z + 9
directionlr = 1
direction = 1
FOR i = 1 TO 8
IF ballHit = -i THEN directionlr = 2
IF ballHit = -i THEN ballHit = i
NEXT i
END SELECT
320 IF ballHit = 0 THEN changeAmount = 100 ELSE changeAmount = 9 - ballHit
IF b < -12 THEN b = -12
IF b > 75 THEN b = 75
IF d < -12 THEN d = -12
IF d > 75 THEN d = 75
IF y < 1 THEN y = 1
IF y > 47 THEN y = 47
IF z < 1 THEN z = 1
IF z > 80 THEN z = 80
IF y = 2 THEN direction = 2
IF y = 2 AND alreadyAdded = 0 THEN score = score + 1
IF y = 2 AND alreadyAdded = 0 THEN alreadyAdded = 1
IF y = 3 THEN alreadyAdded = 0
outOfBounds = 0
IF y > 42 THEN outOfBounds = 1
IF z < 2 THEN outOfBounds = 1
IF z > 79 THEN outOfBounds = 1

FOR i = 1 TO 11 - target
IF y = w + 1 AND z = x + i THEN hitTarget = 1
IF y = w AND z = x + i THEN hitTarget = 1
NEXT i
IF hitTarget = 1 THEN direction = 2

SELECT CASE outOfBounds
CASE IS = 1
score = score + 1
speed = 0
a = 37
b = 32
y = 36
z = 40
t = 0
totals = 0
speed = 0
direction = 1
alreadyAdded = 0
COLOR 15, 2
CLS
FOR i = 2 TO 20
COLOR 1, 15
LOCATE 2, i
PRINT CHR$(219)
NEXT i
COLOR 15, 1
LOCATE 2, 2
PRINT surname$
END SELECT
LOOP UNTIL hitTarget = 1
NEXT target

COLOR 15, 2
CLS
FOR i = 2 TO 20
COLOR 1, 15
LOCATE 2, i
PRINT CHR$(219)
NEXT i
COLOR 15, 1
LOCATE 2, 2
PRINT surname$
LOCATE 2, 21
COLOR 15, 4
PRINT target - 1
LOCATE 2, 25
COLOR 15, 3
PRINT "  SCORE "; score

COLOR 15, 2
LOCATE 16, 24
SELECT CASE score
CASE IS < 10
PRINT "THAT WAS AN UNBELIEVEABLE EFFORT! WELL PLAYED!"
CASE 10 TO 18
PRINT "WELL DONE! THAT WAS AN EXCELLENT PERFORMANCE."
CASE 19 TO 26
PRINT "VERY IMPRESSIVE! YOU SHOULD BE PLEASED WITH THAT SCORE."
CASE 27 TO 35
PRINT "GOOD SCORE, BUT STILL A LOT OF IMPROVEMENT TO BE MADE."
CASE 36 TO 42
PRINT "NOT A BAD SCORE, BUT YOU CAN DO MUCH BETTER."
CASE 43 TO 50
PRINT "BY NO MEANS IMPRESSIVE. TRY AGAIN."
CASE 51 TO 56
PRINT "HAVE YOU FORGOTTEN THAT THE IDEA IS TO GET A LOW SCORE?"
CASE 57 TO 62
PRINT "THAT WAS ABSOLUTELY DREADFUL. ENOUGH SAID."
CASE IS > 62
PRINT "THAT WAS SHOCKING. HAVE YOU EVER PLAYED THIS GAME BEFORE?"
END SELECT

LOCATE 20, 24
PRINT "YOUR SCORE:"
COLOR 7, 2
LOCATE 20, 36
PRINT score
LOCATE 28, 24
PRINT "PRESS RETURN TO GO BACK TO THE MAIN MENU"
LOCATE 30, 24
PRINT "PRESS SPACE TO TRY TARGET PRACTICE AGAIN"
420 SELECT CASE INKEY$
CASE IS = CHR$(13)
CASE IS = CHR$(32)
GOTO 430
CASE ELSE
GOTO 420
END SELECT
END SUB

SUB tournament
forename$(32) = forename$
surname$(32) = surname$

FOR i = 1 TO 32
in(i) = 1
flag(i) = 0
NEXT i

FOR roundNumber = 1 TO 5
SELECT CASE roundNumber
CASE IS = 1
entrants = 32
CASE IS = 2
entrants = 16
CASE IS = 3
entrants = 8
CASE IS = 4
entrants = 4
CASE IS = 5
entrants = 2
END SELECT

FOR i = 1 TO 32
flag(i) = 0
NEXT i

FOR i = 1 TO entrants
DO
tournamentPlayer(i) = rand(32)
LOOP UNTIL flag(tournamentPlayer(i)) = 0 AND in(tournamentPlayer(i)) = 1
flag(tournamentPlayer(i)) = 1
NEXT i

userIn = 0
COLOR 15, 2
CLS
LOCATE 6, 5
IF roundNumber = 5 THEN PRINT "THE FINAL:" ELSE PRINT round$(roundNumber); " FIXUTES:"
FOR i = 1 TO 32
FOR j = 1 TO entrants
IF tournamentPlayer(j) = 32 OR tournamentPlayer(j + 1) = 32 THEN COLOR 15, 2 ELSE COLOR 7, 2
IF tournamentPlayer(j) = 32 OR tournamentPlayer(j + 1) = 32 THEN userIn = 1
LOCATE j + 10, 5
IF tournamentPlayer(j) = i THEN PRINT forename$(i); " "; surname$(i)
LOCATE j + 10, 40
IF tournamentPlayer(j + 1) = i THEN PRINT forename$(i); " "; surname$(i)
LOCATE j + 10, 32
PRINT "V"
j = j + 1
NEXT j
NEXT i
COLOR 15, 2
LOCATE 44, 5
IF userIn = 1 THEN PRINT "PRESS RETURN TO GO TO YOUR NEXT MATCH" ELSE PRINT "YOU ARE OUT OF THE TOURNAMENT. PRESS RETURN TO SKIP TO THE NEXT ROUND"
DO
LOOP UNTIL INKEY$ = CHR$(13)

userDone = 0
FOR j = 1 TO entrants
IF tournamentPlayer(j) = 32 OR tournamentPlayer(j + 1) = 32 THEN userMatch = 1 ELSE userMatch = 0
IF userMatch = 1 THEN userDone = userDone + 1
SELECT CASE userMatch
CASE IS = 1
IF userDone > 1 THEN GOTO 270
IF tournamentPlayer(j) = 32 THEN opponent = tournamentPlayer(j + 1) ELSE opponent = tournamentPlayer(j)
CALL matchDayMenu
IF winner = 1 THEN in(opponent) = 0 ELSE in(32) = 0
CASE ELSE
270 totalRating = speedRating(tournamentPlayer(j)) + power(tournamentPlayer(j)) + accuracy(tournamentPlayer(j)) + speedRating(tournamentPlayer(j + 1)) + power(tournamentPlayer(j + 1)) + accuracy(tournamentPlayer(j + 1))
randTR = rand(totalRating)
SELECT CASE randTR
CASE IS <= speedRating(tournamentPlayer(j)) + power(tournamentPlayer(j)) + accuracy(tournamentPlayer(j))
in(tournamentPlayer(j + 1)) = 0
CASE ELSE
in(tournamentPlayer(j)) = 0
END SELECT
END SELECT
j = j + 1
NEXT j
NEXT roundNumber

COLOR 7, 2
CLS
FOR i = 34 TO 44
LOCATE 6, i
PRINT CHR$(219)
NEXT i
LOCATE 7, 34
PRINT CHR$(219); CHR$(219)
LOCATE 7, 43
PRINT CHR$(219); CHR$(219)
LOCATE 8, 35
PRINT CHR$(219); CHR$(219); CHR$(219)
LOCATE 8, 41
PRINT CHR$(219); CHR$(219); CHR$(219)
FOR i = 37 TO 41
LOCATE 9, i
PRINT CHR$(219)
NEXT i

FOR j = 10 TO 20
FOR i = 36 TO 42
LOCATE j, i
PRINT CHR$(219)
NEXT i
NEXT j

COLOR 7, 0
FOR i = 35 TO 43
LOCATE 21, i
IF i > 36 AND i < 42 THEN PRINT CHR$(196) ELSE PRINT " "
NEXT i
FOR i = 34 TO 44
LOCATE 22, i
IF i > 35 AND i < 43 THEN PRINT CHR$(196) ELSE PRINT " "
NEXT i
FOR i = 33 TO 45
LOCATE 23, i
IF i > 34 AND i < 44 THEN PRINT CHR$(196) ELSE PRINT " "
NEXT i

COLOR 15, 2
LOCATE 30, 20
PRINT "TOURNAMENT WINNER:"
COLOR 7, 2
LOCATE 30, 40
FOR i = 1 TO 32
IF in(i) = 1 THEN PRINT forename$(i); " "; surname$(i)
NEXT i
LOCATE 34, 20
PRINT "PRESS RETURN TO GO BACK TO THE MAIN MENU"
DO
LOOP UNTIL INKEY$ = CHR$(13)
COLOR 15, 2
CLS
END SUB

SUB training
os = 1
COLOR 15, 2
CLS
310 COLOR 15, 2
LOCATE 16, 32
PRINT "SELECT TRAINING TYPE"
LOCATE 20, 32
IF os = 1 THEN COLOR 2, 7 ELSE COLOR 7, 2
PRINT "TARGET PRACTICE"
LOCATE 22, 32
IF os = 2 THEN COLOR 2, 7 ELSE COLOR 7, 2
PRINT "BACK WALL RALLY"
LOCATE 24, 32
IF os = 3 THEN COLOR 2, 7 ELSE COLOR 7, 2
PRINT "RETURN TO MAIN MENU"

300 SELECT CASE INKEY$
CASE IS = u$
os = os - 1
IF os < 1 THEN os = 3
GOTO 310
CASE IS = d$
os = os + 1
IF os > 3 THEN os = 1
GOTO 310
CASE IS = CHR$(13)
CASE ELSE
GOTO 300
END SELECT

SELECT CASE os
CASE IS = 1
CALL targetPractice
CASE IS = 2
CALL backWallRally
CASE IS = 3
END SELECT

COLOR 15, 2
CLS
END SUB

SUB worldRankings
COLOR 15, 2
CLS
LOCATE 2, 5
PRINT forename$(32); " "; surname$(32); "        "; day; " "; month$(month); " "; year
LOCATE 5, 5
PRINT "WORLD RANKINGS:"
LOCATE 9, 5
PRINT "RANK"
LOCATE 9, 12
PRINT "PLAYER"
LOCATE 9, 38
PRINT "RANK POINTS"
FOR i = 1 TO 32
IF i = 32 THEN COLOR 15, 2 ELSE COLOR 7, 2
LOCATE rank(i) + 10, 4
PRINT rank(i)
LOCATE rank(i) + 10, 12
PRINT forename$(i); " "; surname$(i)
LOCATE rank(i) + 10, 37
PRINT arp(i)
NEXT i
DO
LOOP UNTIL INKEY$ = CHR$(13)
COLOR 15, 2
CLS
END SUB

