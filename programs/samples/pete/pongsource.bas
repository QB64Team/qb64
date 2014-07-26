WIDTH 80, 50

GOTO menu
rt:
CLS
SCREEN 7
LINE (20, 20)-(300, 180), 1, B
LINE (10, 10)-(310, 190), 1, B
PAINT (12, 12), 1
LINE (20, 20)-(300, 180), 9, B
LINE (10, 10)-(310, 190), 9, B
LINE (23, 7)-(48, 16), 9, B
LINE (296, 7)-(271, 16), 9, B
COLOR 9
LOCATE 2, 4
PRINT win
LOCATE 2, 35
PRINT lose
blx = 50: ppx = 50: ppxx = 50: zim = 164:
bly = 21: mbx = 1: mby = 1: ppy = 22: PPYY = 52
amy = 0: amyy = 0: ay = 41: ayy = 51: ax = 36
ti = 0
iat = 1
COLOR 9
'-------------start location randomizer for ball
rerand:
RANDOMIZE TIMER
ballloc = INT(RND * 4) + 1
IF ballloc = 1 THEN GOTO location1
IF ballloc = 2 THEN GOTO location2
IF ballloc = 3 THEN GOTO location3
IF ballloc = 4 THEN GOTO location4
locre:
'-----------main loop
SLEEP 1
DO
PSET (50, 20), 9'-------------wall repair thing
pm = ppy + 25
LINE (ppx, ppy - 1)-(ppxx, PPYY + 1), 0, BF 'player erase

SELECT CASE INKEY$'-----------player control start
CASE CHR$(0) + CHR$(80)
IF PPYY = 178 THEN GOTO ppymm
ppy = ppy + 1
PPYY = PPYY + 1
ppymm:
CASE CHR$(0) + CHR$(72)
IF ppy = 22 THEN GOTO ppym
ppy = ppy - 1
PPYY = PPYY - 1
ppym:
CASE CHR$(27)
END
END SELECT'---------player control end

PSET (blx, bly), 0 '--------ball erase
'-------------------------ball colision detection
IF blx = 299 THEN mbx = -1
IF blx = 21 THEN mbx = 1
IF bly = 21 THEN mby = 1
IF bly = 179 THEN mby = -1
'----------------------------SCORE KEEPING
IF blx > 279 AND bly < ax - 15 THEN win = win + 1
IF blx > 279 AND bly < ax - 15 THEN GOTO rt
IF blx > 279 AND bly > ax + 15 THEN win = win + 1
IF blx > 279 AND bly > ax + 15 THEN GOTO rt
'---------------------------------------------------winning and losing
IF blx < 50 AND bly > ppy THEN lose = lose + 1
IF blx < 50 AND bly > ppy THEN GOTO rt
IF blx < 50 AND bly < PPYY THEN lose = lose + 1
IF blx < 50 AND bly < PPYY THEN GOTO rt
IF lose = 5 THEN GOTO losegame
bstt = 0
IF win = 5 THEN GOTO wingame
'----------------------------ball padle colision detection
IF blx = 50 GOTO ppm
GOTO sm
ppm:
IF bly > ppy AND bly < PPYY THEN mbx = 1
sm:
IF blx = 269 THEN GOTO ppmm
GOTO ms
ppmm:
IF bly < ax + 15 AND bly > ax - 15 THEN mbx = -1
ms:
'---------------ball movement
blx = blx + mbx
samy = samy + 1
IF samy = 1 THEN bly = bly + mby
IF samy = 1 THEN samy = 0
PSET (blx, bly), 15'-----------balldrawer

LINE (ppx, ppy - 1)-(ppxx, PPYY + 1), 15'------player padle drawer

'----------------------------------------------timing loop
DO
ti = ti + 1
LOOP UNTIL ti = gspeed
ti = 0
'-----------------------score display
LOCATE 2, 4
PRINT win
LOCATE 2, 35
PRINT lose
'------------ai goto
ait = ait + 1
IF ait = 1 THEN GOTO ai
backai:
ita = 0
LOOP
'--------------loop end
ai: '---------------------AI
sam = sam + 1
LINE (270, ax + 15)-(270, ax - 15), 0
IF sam < 0 THEN GOTO missera

IF ax - 14 < bly THEN amy = 1
IF ax + 14 > bly THEN amy = -1
IF ax = 164 THEN amy = -1
IF ax = 36 THEN amy = 1

IF sam = 2 THEN ax = ax + amy
missera:
IF sam = 2 THEN sam = 0
LINE (270, ax + 15)-(270, ax - 15), 15
ait = 0
GOTO backai
'------------------------------
losegame:
SLEEP 1
CLS
LOCATE 11, 19
PRINT "you lose"
SLEEP 2
END

wingame:
SLEEP 1
CLS
LOCATE 11, 19
PRINT "you win"
SLEEP 2
END

location1:
blx = 50
bly = 21
mbx = 1
mby = 1
GOTO locre

location2:
blx = 50
bly = 171
mby = -1
mbx = 1
GOTO locre

location3:
blx = 268
bly = 21
mbx = -1
mby = 1
GOTO locre

location4:
blx = 268
bly = 171
mbx = -1
mby = -1
GOTO locre

menu:
CLS
dotloc = 24
gspeed = 30000
dotloc = 24
menub:
COLOR 9
LOCATE 19, 35
PRINT "PONG CLONE"
PRINT " "
PRINT "                            programed by bj mccann"
PRINT
PRINT
PRINT "                                     START"
PRINT
PRINT "                                     CONTROLS"
PRINT
PRINT "                                     CHANGE SPEED "
PRINT
PRINT "                                     EXIT"
COLOR 1
DO
LOCATE dotloc, 35
PRINT " "
SELECT CASE INKEY$
'CASE CHR$(27)
'END
CASE CHR$(0) + CHR$(72)
IF dotloc > 24 THEN dotloc = dotloc - 2
CASE CHR$(0) + CHR$(80)
IF dotloc < 30 THEN dotloc = dotloc + 2
CASE CHR$(0) + CHR$(77)
IF dotloc = 24 THEN GOTO rt
IF dotloc = 26 THEN GOTO controls
IF dotloc = 28 THEN GOTO speed
IF dotloc = 30 THEN END
END SELECT
LOCATE dotloc, 35
PRINT "*"
LOOP

controls:
CLS
LOCATE 19, 25
PRINT "to move the paddle up press the up arrow."
PRINT "                        to move the paddle down press down."
PRINT "                        to return to the menu press escape"
SLEEP 5
GOTO menu

speed:
CLS
LOCATE 19, 25
PRINT "normal speed is 30000 the lower the number the faster the game runs"
INPUT gspeed
CLS
GOTO menub

