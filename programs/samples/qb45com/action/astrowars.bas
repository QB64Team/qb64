DECLARE SUB player.three.win ()
DECLARE SUB draw.ship.three ()
DECLARE SUB flare.three ()
DECLARE SUB flare ()
DECLARE SUB t.flare ()
DECLARE SUB gravity ()
DECLARE SUB player.one.win ()
DECLARE SUB Player.two.win ()
DECLARE SUB flash ()
DECLARE SUB menu ()
DECLARE SUB check.side ()
DECLARE SUB back.ground ()
DECLARE SUB draw.ship ()
DECLARE SUB draw.enemy ()
DECLARE SUB check.bullet ()
DECLARE SUB score ()
DECLARE SUB draw.bullet ()
DECLARE SUB check.press ()
DECLARE SUB errcode ()


DIM SHARED lastpress(3) AS INTEGER
DIM SHARED shoot(10) AS INTEGER
DIM SHARED bulletx(10) AS INTEGER
DIM SHARED bullety(10) AS INTEGER
DIM SHARED gagne(3) AS INTEGER
DIM SHARED shots(3) AS INTEGER
DIM SHARED miss(3) AS INTEGER
DIM SHARED angle(3) AS INTEGER
DIM SHARED ammo(3) AS INTEGER

COMMON SHARED x, y, xx, yy, delaynumber, movenumber, shootnumber, gc, bc
COMMON SHARED dir, xa, ya, grav, gravint, fc, bcc, xxa, yya

ON ERROR GOTO errcode

0
dir = 1
xa = 1
ya = 1
shoot(1) = 0
shoot(2) = 0
shoot(3) = 0
bulletx(1) = x
bulletx(2) = xx
bullety(1) = y
bullety(2) = yy
gagne(1) = 0
gagne(2) = 0
gane(3) = 0
miss(1) = 0
miss(2) = 0
miss(3) = 0
angle(1) = 1
angle(2) = 1
angle(3) = 1
lastpress(1) = 8
lastpress(2) = 2
lastpress(3) = 2
ammo(1) = 1
ammo(2) = 1
ammo(3) = 1
shootnumber = 4
delaynumber = 10000
movenumber = 15
shots(1) = 15
shots(2) = 15
shots(3) = 15
x = 150
y = 190
xx = 150
yy = 20
xxa = 50
yya = 80
gc = 3
bc = 2
bcc = 43
gravint = 35
fc = 41



SCREEN 13
VIEW (1, 1)-(319, 199), 0
RANDOMIZE TIMER

DO
FOR delay = 1 TO delaynumber: NEXT delay
draw.ship
draw.enemy
draw.ship.three
check.bullet
draw.bullet
score
check.press
back.ground

raa = INT(RND * 10) + 1
IF raa = 3 THEN
flash
END IF

gravity
check.side
LOOP

errcode:
RESUME 0

SUB back.ground

LINE (100, 150)-(200, 160), 17, BF

LINE (100, 40)-(200, 50), 17, BF

LINE (20, 95)-(70, 105), 17, BF

LINE (230, 95)-(280, 105), 17, BF

END SUB

SUB check.bullet

IF shoot(1) = 1 THEN

IF bullety(1) < yy + 11 AND bullety(1) > yy - 11 AND bulletx(1) < xx + 4 AND bulletx(1) > xx - 4 THEN
'PRINT "boom"
'SLEEP 1
'CLS 2
shoot(1) = 0
bulletx(1) = x
bullety(1) = y

IF ammo(1) = 1 THEN
gagne(1) = gagne(1) + 1
END IF

IF ammo(1) = 2 THEN
gagne(1) = gagne(1) + 2
END IF

shots(2) = 15
END IF

IF bullety(1) < yya + 6 AND bullety(1) > yya - 6 AND bulletx(1) < xxa + 4 AND bulletx(1) > xxa - 4 THEN
'PRINT "boom"
'SLEEP 1
'CLS 2
shoot(1) = 0
bulletx(1) = x
bullety(1) = y

IF ammo(1) = 1 THEN
gagne(1) = gagne(1) + 1
END IF

IF ammo(1) = 2 THEN
gagne(1) = gagne(1) + 2
END IF

shots(3) = 15
END IF

END IF


IF shoot(2) = 1 THEN

IF bullety(2) < y + 11 AND bullety(2) > y - 11 AND bulletx(2) < x + 4 AND bulletx(2) > x - 4 THEN

'PRINT "boom"
'SLEEP 1
'CLS 2
shoot(2) = 0
bulletx(2) = xx
bullety(2) = yy

IF ammo(2) = 1 THEN
gagne(2) = gagne(2) + 1
END IF

IF ammo(2) = 2 THEN
gagne(2) = gagne(2) + 2
END IF

shots(1) = 15
END IF

'IF shoot(2) = 1 THEN
IF bullety(2) < yya + 6 AND bullety(2) > yya - 6 AND bulletx(2) < xxa + 4 AND bulletx(2) > xxa - 4 THEN

'PRINT "boom"
'SLEEP 1
'CLS 2
shoot(2) = 0
bulletx(2) = xx
bullety(2) = yy

IF ammo(2) = 1 THEN
gagne(2) = gagne(2) + 1
END IF

IF ammo(2) = 2 THEN
gagne(2) = gagne(2) + 2
END IF

shots(3) = 15
END IF

END IF


IF shoot(3) = 1 THEN

IF bullety(3) < yy + 11 AND bullety(3) > yy - 11 AND bulletx(3) < xx + 4 AND bulletx(3) > xx - 4 THEN
'PRINT "boom"
'SLEEP 1
'CLS 2
shoot(3) = 0
bulletx(3) = xxa
bullety(3) = yya

IF ammo(3) = 1 THEN
gagne(3) = gagne(3) + 1
END IF

IF ammo(3) = 2 THEN
gagne(3) = gagne(3) + 2
END IF

shots(2) = 15
END IF

IF bullety(3) < y + 11 AND bullety(3) > y - 11 AND bulletx(3) < x + 4 AND bulletx(3) > x - 4 THEN
'PRINT "boom"
'SLEEP 1
'CLS 2
shoot(3) = 0
bulletx(3) = xxa
bullety(3) = yya

IF ammo(3) = 1 THEN
gagne(3) = gagne(3) + 1
END IF

IF ammo(3) = 2 THEN
gagne(3) = gagne(3) + 2
END IF

shots(1) = 15
END IF

END IF





IF bulletx(1) < 200 AND bulletx(1) > 100 AND bullety(1) < 163 AND bullety(1) > 147 THEN
shoot(1) = 0
bulletx(1) = x
bullety(1) = y
END IF

IF bulletx(2) < 200 AND bulletx(2) > 100 AND bullety(2) < 163 AND bullety(2) > 147 THEN
shoot(2) = 0
bulletx(2) = xx
bullety(2) = yy
END IF

IF bulletx(1) < 200 AND bulletx(1) > 100 AND bullety(1) < 50 AND bullety(1) > 43 THEN
shoot(1) = 0
bulletx(1) = x
bullety(1) = y
END IF

IF bulletx(2) < 200 AND bulletx(2) > 100 AND bullety(2) < 50 AND bullety(2) > 37 THEN
shoot(2) = 0
bulletx(2) = xx
bullety(2) = yy
END IF

IF bulletx(1) < 73 AND bulletx(1) > 17 AND bullety(1) < 108 AND bullety(1) > 92 THEN
shoot(1) = 0
bulletx(1) = x
bullety(1) = y
END IF

IF bulletx(2) < 73 AND bulletx(2) > 17 AND bullety(2) < 108 AND bullety(2) > 92 THEN
shoot(2) = 0
bulletx(2) = xx
bullety(2) = yy
END IF

IF bulletx(1) < 283 AND bulletx(1) > 227 AND bullety(1) < 108 AND bullety(1) > 92 THEN
shoot(1) = 0
bulletx(1) = x
bullety(1) = y
END IF

IF bulletx(2) < 283 AND bulletx(2) > 227 AND bullety(2) < 108 AND bullety(2) > 92 THEN
shoot(2) = 0
bulletx(2) = x
bullety(2) = y
END IF



IF bulletx(3) < 200 AND bulletx(3) > 100 AND bullety(3) < 163 AND bullety(3) > 147 THEN
shoot(3) = 0
bulletx(3) = xxa
bullety(3) = yya
END IF


IF bulletx(3) < 200 AND bulletx(3) > 100 AND bullety(3) < 50 AND bullety(3) > 37 THEN
shoot(3) = 0
bulletx(3) = xxa
bullety(3) = yya
END IF


IF bulletx(3) < 73 AND bulletx(3) > 17 AND bullety(3) < 108 AND bullety(3) > 92 THEN
shoot(3) = 0
bulletx(3) = xxa
bullety(3) = yya
END IF


IF bulletx(3) < 283 AND bulletx(3) > 227 AND bullety(3) < 108 AND bullety(3) > 92 THEN
shoot(3) = 0
bulletx(3) = xxa
bullety(3) = yya
END IF



'LINE (230, 95)-(280, 105), 17, BF
END SUB

SUB check.press

press$ = INKEY$

'IF press$ = "6" THEN
'LINE (x - 10, y - 15)-(x + 10, y + 10), 0, BF
'x = x + movenumber
'END IF

'IF press$ = "4" THEN
'LINE (x - 10, y - 15)-(x + 10, y + 10), 0, BF
'x = x - movenumber
'END IF


IF press$ = "2" THEN
GOTO endersuber
LINE (x - 10, y - 15)-(x + 10, y + 10), 0, BF

IF angle(1) = 1 THEN
y = y + movenumber
END IF

IF angle(1) = 2 THEN
x = x + movenumber
END IF

IF angle(1) = 3 THEN
y = y - movenumber
END IF

IF angle(1) = 4 THEN
x = x - movenumber
END IF

END IF

IF press$ = "5" OR press$ = CHR$(0) + CHR$(80) THEN
IF shots(1) > 0 THEN
shoot(1) = 1
bullety(1) = y
bulletx(1) = x

IF ammo(1) = 1 THEN
shots(1) = shots(1) - 1
END IF

IF ammo(1) = 2 THEN
shots(1) = shots(1) - 2
END IF

miss(1) = miss(1) + 1
'flare
END IF
'lastpress(1) = 5
END IF

IF press$ = "8" OR press$ = CHR$(0) + CHR$(72) THEN
lastpress(1) = 8
LINE (x - 10, y - 15)-(x + 10, y + 10), 0, BF

IF angle(1) = 1 THEN
lastpress(1) = 2
y = y - movenumber
END IF

IF angle(1) = 2 THEN
lastpress(1) = 1
x = x - movenumber
y = y - movenumber
END IF

IF angle(1) = 3 THEN
lastpress(1) = 4
x = x - movenumber
END IF

IF angle(1) = 4 THEN
lastpress(1) = 7
x = x - movenumber
y = y + movenumber
END IF

IF angle(1) = 5 THEN
lastpress(1) = 8
y = y + movenumber
END IF

IF angle(1) = 6 THEN
lastpress(1) = 9
x = x + movenumber
y = y + movenumber
END IF

IF angle(1) = 7 THEN
lastpress(1) = 6
x = x + movenumber
END IF

IF angle(1) = 8 THEN
lastpress(1) = 3
x = x + movenumber
y = y - movenumber
END IF

flare
END IF



IF press$ = "0" THEN

IF ammo(1) = 1 THEN
ammo(1) = 2
z = 1
END IF

IF z <> 1 THEN
IF ammo(1) = 2 THEN
ammo(1) = 1
END IF
END IF

END IF
z = 0


IF press$ = "C" OR press$ = "c" THEN

IF ammo(2) = 1 THEN
ammo(2) = 2
zz = 1
END IF

IF zz <> 1 THEN
IF ammo(2) = 2 THEN
ammo(2) = 1
END IF
END IF

END IF
zz = 0

skip:
IF press$ = "4" OR press$ = CHR$(0) + CHR$(75) THEN
'lastpress(1) = 4
LINE (x - 10, y - 15)-(x + 10, y + 10), 0, BF
angle(1) = angle(1) + 1
IF angle(1) > 8 THEN angle(1) = 1
END IF

IF press$ = "6" OR press$ = CHR$(0) + CHR$(77) THEN
'lastpress(1) = 6
LINE (x - 10, y - 15)-(x + 10, y + 10), 0, BF
angle(1) = angle(1) - 1
IF angle(1) < 1 THEN angle(1) = 8
END IF

IF press$ = CHR$(27) THEN END

'FOR delay = 1 TO delaynumber: NEXT delay

'press$ = INKEY$
'
'
'
'         green ship
' '
'
IF press$ = "a" OR press$ = "A" THEN
LINE (xx - 12, yy + 15)-(xx + 12, yy - 12), 0, BF
angle(2) = angle(2) - 1
IF angle(2) < 1 THEN angle(2) = 8
'xx = xx + movenumber
END IF

IF press$ = "d" OR press$ = "D" THEN
LINE (xx - 12, yy + 15)-(xx + 12, yy - 12), 0, BF
'xx = xx - movenumber
angle(2) = angle(2) + 1
IF angle(2) < 1 THEN angle(2) = 8
IF angle(2) > 8 THEN angle(2) = 1
END IF

'IF press$ = "w" OR press$ = "W" THEN
'LINE (xx - 10, yy + 15)-(xx + 10, yy - 10), 0, BF
'yy = yy + movenumber
'shoot(2) = 1
'bullety(2) = yy
'bulletx(2) = xx
'END IF

IF press$ = "w" OR press$ = "W" THEN
LINE (xx - 15, yy - 15)-(xx + 15, yy + 15), 0, BF

IF angle(2) = 1 THEN
lastpress(2) = 2
yy = yy + movenumber
END IF

IF angle(2) = 8 THEN
lastpress(2) = 3
xx = xx + movenumber
yy = yy + movenumber
END IF


IF angle(2) = 3 THEN
lastpress(2) = 4
xx = xx - movenumber
END IF

IF angle(2) = 4 THEN
lastpress(2) = 7
xx = xx - movenumber
yy = yy - movenumber
END IF

IF angle(2) = 6 THEN
lastpress(2) = 9
xx = xx + movenumber
yy = yy - movenumber
END IF

IF angle(2) = 5 THEN
lastpress(2) = 9
yy = yy - movenumber
END IF

IF angle(2) = 7 THEN
lastpress(2) = 6
xx = xx + movenumber
END IF

IF angle(2) = 2 THEN
lastpress(2) = 1
xx = xx - movenumber
yy = yy + movenumber
END IF

t.flare
END IF

'GOTO endersuber
IF press$ = "x" OR press$ = "X" THEN
GOTO endersuber
LINE (xx - 10, yy + 15)-(xx + 10, yy - 10), 0, BF

IF angle(2) = 1 THEN
yy = yy - movenumber
END IF

IF angle(2) = 2 THEN
xx = xx + movenumber
END IF

IF angle(2) = 3 THEN
yy = yy + movenumber
END IF

IF angle(2) = 4 THEN
xx = xx - movenumber
END IF

END IF

IF press$ = "s" OR press$ = "S" THEN
IF shots(2) > 0 THEN
shoot(2) = 1
bullety(2) = yy
bulletx(2) = xx
miss(2) = miss(2) + 1

IF ammo(2) = 1 THEN
shots(2) = shots(2) - 1
END IF

IF ammo(2) = 2 THEN
shots(2) = shots(2) - 2
END IF

END IF
END IF

'END IF

'IF press$ = "0" THEN

'IF ammo(1) = 1 THEN
'ammo(1) = 2
'END IF

'END IF



IF press$ = CHR$(13) THEN menu

IF press$ = CHR$(27) THEN END

FOR delay = 1 TO delaynumber: NEXT delay




IF press$ = "g" OR press$ = "G" THEN
LINE (xxa - 12, yya + 15)-(xxa + 12, yya - 12), 0, BF
angle(3) = angle(3) - 1
IF angle(3) < 1 THEN angle(3) = 8
'xx = xx + movenumber
END IF

IF press$ = "j" OR press$ = "J" THEN
LINE (xxa - 12, yya + 15)-(xxa + 12, yya - 12), 0, BF
'xx = xx - movenumber
angle(3) = angle(3) + 1
IF angle(3) < 1 THEN angle(3) = 8
IF angle(3) > 8 THEN angle(3) = 1
END IF

'IF press$ = "w" OR press$ = "W" THEN
'LINE (xx - 10, yy + 15)-(xx + 10, yy - 10), 0, BF
'yy = yy + movenumber
'shoot(2) = 1
'bullety(2) = yy
'bulletx(2) = xx
'END IF

IF press$ = "y" OR press$ = "Y" THEN
LINE (xxa - 15, yya - 15)-(xxa + 15, yya + 15), 0, BF

IF angle(3) = 1 THEN
lastpress(3) = 2
yya = yya + movenumber
END IF

IF angle(3) = 8 THEN
lastpress(3) = 3
xxa = xxa + movenumber
yya = yya + movenumber
END IF


IF angle(3) = 3 THEN
lastpress(3) = 4
xxa = xxa - movenumber
END IF

IF angle(3) = 4 THEN
lastpress(3) = 7
xxa = xxa - movenumber
yya = yya - movenumber
END IF

IF angle(3) = 6 THEN
lastpress(3) = 8
xxa = xxa + movenumber
yya = yya - movenumber
END IF

IF angle(3) = 5 THEN
lastpress(3) = 9
yya = yya - movenumber
END IF

IF angle(3) = 7 THEN
lastpress(3) = 6
xxa = xxa + movenumber
END IF

IF angle(3) = 2 THEN
lastpress(3) = 1
xxa = xxa - movenumber
yya = yya + movenumber
END IF

flare.three
END IF

'END IF

IF press$ = "h" OR press$ = "H" THEN
IF shots(3) > 0 THEN
shoot(3) = 1
bullety(3) = yya
bulletx(3) = xxa
miss(3) = miss(3) + 1

IF ammo(3) = 1 THEN
shots(3) = shots(3) - 1
END IF

IF ammo(3) = 2 THEN
shots(3) = shots(3) - 2
END IF

END IF
END IF

'END IF

'IF press$ = "0" THEN

'IF ammo(1) = 1 THEN
'ammo(1) = 2
'END IF

'END IF

IF press$ = "M" OR press$ = "m" THEN

IF ammo(3) = 1 THEN
ammo(3) = 2
zzz = 1
END IF

IF zzz <> 1 THEN
IF ammo(3) = 2 THEN
ammo(3) = 1
END IF
END IF

END IF
zzz = 0



IF press$ = CHR$(13) THEN menu

IF press$ = CHR$(27) THEN END

FOR delay = 1 TO delaynumber: NEXT delay





endersuber:
END SUB

SUB check.ship
LINE (1, 1)-(5, 3), 0, BF

IF x < 205 AND x > 95 AND y < 161 AND y > 145 THEN
'shoot(1) = 0
'bulletx(1) = x
'bullety(1) = y
'gagne(2) = gagne(2) + 1
'PRINT "boom"
x = 150
y = 190
END IF

IF bulletx(2) < 200 AND bulletx(2) > 100 AND bullety(2) < 163 AND bullety(2) > 147 THEN
shoot(2) = 0
bulletx(2) = xx
bullety(2) = yy
END IF

IF bulletx(1) < 200 AND bulletx(1) > 100 AND bullety(1) < 53 AND bullety(1) > 37 THEN
shoot(1) = 0
bulletx(1) = x
bullety(1) = y
END IF

IF bulletx(2) < 200 AND bulletx(2) > 100 AND bullety(2) < 53 AND bullety(2) > 37 THEN
shoot(2) = 0
bulletx(2) = xx
bullety(2) = yy
END IF

IF bulletx(1) < 73 AND bulletx(1) > 17 AND bullety(1) < 108 AND bullety(1) > 92 THEN
shoot(1) = 0
bulletx(1) = x
bullety(1) = y
END IF

IF bulletx(2) < 73 AND bulletx(2) > 17 AND bullety(2) < 108 AND bullety(2) > 92 THEN
shoot(2) = 0
bulletx(2) = xx
bullety(2) = yy
END IF

IF bulletx(1) < 283 AND bulletx(1) > 227 AND bullety(1) < 108 AND bullety(1) > 92 THEN
shoot(1) = 0
bulletx(1) = x
bullety(1) = y
END IF

IF bulletx(2) < 283 AND bulletx(2) > 227 AND bullety(2) < 108 AND bullety(2) > 92 THEN
shoot(2) = 0
bulletx(2) = x
bullety(2) = y
END IF


END SUB

SUB check.side
LINE (1, 1)-(5, 3), 0, BF

IF x < 1 THEN
'gagne(2) = gagne(2) + 1
'shots(1) = 15
x = 150
y = 190
'PRINT "boom"
'SLEEP 1
CLS 2
END IF

IF x > 319 THEN
'gagne(2) = gagne(2) + 1
'shots(1) = 15
x = 150
y = 190
'PRINT "boom"
'SLEEP 1
CLS 2
END IF

IF y < 1 THEN
'gagne(2) = gagne(2) + 1
'shots(1) = 15
x = 150
y = 190
'PRINT "boom"
'SLEEP 1
CLS 2
END IF

IF y > 199 THEN
'gagne(2) = gagne(2) + 1
'shots(1) = 15
x = 150
y = 190
'PRINT "boom"
'SLEEP 1
CLS 2
END IF

IF xx < 1 THEN
'gagne(1) = gagne(1) + 1
'shots(2) = 15
xx = 150
yy = 20
'PRINT "boom"
'SLEEP 1
CLS 2
END IF

IF xx > 319 THEN
'gagne(1) = gagne(1) + 1
'shots(2) = 15
xx = 150
yy = 20
'PRINT "boom"
'SLEEP 1
CLS 2
END IF

IF yy < 1 THEN
'gagne(1) = gagne(1) + 1
'shots(2) = 15
xx = 150
yy = 20
'PRINT "boom"
'SLEEP 1
CLS 2
END IF

IF yy > 199 THEN
'gagne(1) = gagne(1) + 1
'shots(2) = 15
xx = 150
yy = 20
'PRINT "boom"
'SLEEP 1
CLS 2
END IF


IF xxa < 1 THEN
'gagne(1) = gagne(1) + 1
'shots(2) = 15
xxa = 50
yya = 80
'PRINT "boom"
'SLEEP 1
CLS 2
END IF

IF xxa > 319 THEN
'gagne(1) = gagne(1) + 1
'shots(2) = 15
xxa = 50
yya = 80
'PRINT "boom"
'SLEEP 1
CLS 2
END IF

IF yya < 1 THEN
'gagne(1) = gagne(1) + 1
'shots(2) = 15
xxa = 50
yya = 80
'PRINT "boom"
'SLEEP 1
CLS 2
END IF

IF yya > 199 THEN
'gagne(1) = gagne(1) + 1
'shots(2) = 15
xxa = 50
yya = 80
'PRINT "boom"
'SLEEP 1
CLS 2
END IF




END SUB

SUB draw.bullet


IF shoot(1) = 1 THEN


IF ammo(1) = 1 THEN

IF angle(1) = 1 THEN
CIRCLE (bulletx(1), bullety(1)), 10, 0
PAINT (bulletx(1), bullety(1)), 0, 0

bullety(1) = bullety(1) - shootnumber

CIRCLE (bulletx(1), bullety(1)), 1, 4
PAINT (bulletx(1), bullety(1)), 4, 4
END IF


IF angle(1) = 2 THEN
CIRCLE (bulletx(1), bullety(1)), 10, 0
PAINT (bulletx(1), bullety(1)), 0, 0

bullety(1) = bullety(1) - shootnumber
bulletx(1) = bulletx(1) - shootnumber

CIRCLE (bulletx(1), bullety(1)), 1, 4
PAINT (bulletx(1), bullety(1)), 4, 4
END IF


IF angle(1) = 3 THEN
CIRCLE (bulletx(1), bullety(1)), 10, 0
PAINT (bulletx(1), bullety(1)), 0, 0

bulletx(1) = bulletx(1) - shootnumber

CIRCLE (bulletx(1), bullety(1)), 1, 4
PAINT (bulletx(1), bullety(1)), 4, 4
END IF


IF angle(1) = 4 THEN
CIRCLE (bulletx(1), bullety(1)), 10, 0
PAINT (bulletx(1), bullety(1)), 0, 0

bullety(1) = bullety(1) + shootnumber
bulletx(1) = bulletx(1) - shootnumber

CIRCLE (bulletx(1), bullety(1)), 1, 4
PAINT (bulletx(1), bullety(1)), 4, 4
END IF


IF angle(1) = 5 THEN
CIRCLE (bulletx(1), bullety(1)), 10, 0
PAINT (bulletx(1), bullety(1)), 0, 0

bullety(1) = bullety(1) + shootnumber

CIRCLE (bulletx(1), bullety(1)), 1, 4
PAINT (bulletx(1), bullety(1)), 4, 4
END IF


IF angle(1) = 6 THEN
CIRCLE (bulletx(1), bullety(1)), 10, 0
PAINT (bulletx(1), bullety(1)), 0, 0

bullety(1) = bullety(1) + shootnumber
bulletx(1) = bulletx(1) + shootnumber

CIRCLE (bulletx(1), bullety(1)), 1, 4
PAINT (bulletx(1), bullety(1)), 4, 4
END IF


IF angle(1) = 7 THEN
CIRCLE (bulletx(1), bullety(1)), 10, 0
PAINT (bulletx(1), bullety(1)), 0, 0

bulletx(1) = bulletx(1) + shootnumber

CIRCLE (bulletx(1), bullety(1)), 1, 4
PAINT (bulletx(1), bullety(1)), 4, 4
END IF

IF angle(1) = 8 THEN
CIRCLE (bulletx(1), bullety(1)), 10, 0
PAINT (bulletx(1), bullety(1)), 0, 0

bullety(1) = bullety(1) - shootnumber
bulletx(1) = bulletx(1) + shootnumber

CIRCLE (bulletx(1), bullety(1)), 1, 4
PAINT (bulletx(1), bullety(1)), 4, 4
END IF
END IF




IF ammo(1) = 2 THEN

IF angle(1) = 1 THEN
CIRCLE (bulletx(1), bullety(1)), 10, 0
PAINT (bulletx(1), bullety(1)), 0, 0

bullety(1) = bullety(1) - shootnumber / 3

CIRCLE (bulletx(1), bullety(1)), 2, 14
PAINT (bulletx(1), bullety(1)), 14, 14
END IF


IF angle(1) = 2 THEN
CIRCLE (bulletx(1), bullety(1)), 10, 0
PAINT (bulletx(1), bullety(1)), 0, 0

bullety(1) = bullety(1) - shootnumber / 3
bulletx(1) = bulletx(1) - shootnumber / 3

CIRCLE (bulletx(1), bullety(1)), 2, 14
PAINT (bulletx(1), bullety(1)), 14, 14
END IF


IF angle(1) = 3 THEN
CIRCLE (bulletx(1), bullety(1)), 10, 0
PAINT (bulletx(1), bullety(1)), 0, 0

bulletx(1) = bulletx(1) - shootnumber / 3

CIRCLE (bulletx(1), bullety(1)), 2, 14
PAINT (bulletx(1), bullety(1)), 14, 14
END IF


IF angle(1) = 4 THEN
CIRCLE (bulletx(1), bullety(1)), 10, 0
PAINT (bulletx(1), bullety(1)), 0, 0

bullety(1) = bullety(1) + shootnumber / 3
bulletx(1) = bulletx(1) - shootnumber / 3

CIRCLE (bulletx(1), bullety(1)), 2, 14
PAINT (bulletx(1), bullety(1)), 14, 14
END IF


IF angle(1) = 5 THEN
CIRCLE (bulletx(1), bullety(1)), 10, 0
PAINT (bulletx(1), bullety(1)), 0, 0

bullety(1) = bullety(1) + shootnumber / 3

CIRCLE (bulletx(1), bullety(1)), 2, 14
PAINT (bulletx(1), bullety(1)), 14, 14
END IF


IF angle(1) = 6 THEN
CIRCLE (bulletx(1), bullety(1)), 10, 0
PAINT (bulletx(1), bullety(1)), 0, 0

bullety(1) = bullety(1) + shootnumber / 3
bulletx(1) = bulletx(1) + shootnumber / 3

CIRCLE (bulletx(1), bullety(1)), 2, 14
PAINT (bulletx(1), bullety(1)), 14, 14
END IF


IF angle(1) = 7 THEN
CIRCLE (bulletx(1), bullety(1)), 10, 0
PAINT (bulletx(1), bullety(1)), 0, 0

bulletx(1) = bulletx(1) + shootnumber / 3

CIRCLE (bulletx(1), bullety(1)), 2, 14
PAINT (bulletx(1), bullety(1)), 14, 14
END IF

IF angle(1) = 8 THEN
CIRCLE (bulletx(1), bullety(1)), 10, 0
PAINT (bulletx(1), bullety(1)), 0, 0

bullety(1) = bullety(1) - shootnumber / 3
bulletx(1) = bulletx(1) + shootnumber / 3

CIRCLE (bulletx(1), bullety(1)), 2, 14
PAINT (bulletx(1), bullety(1)), 14, 14
END IF


END IF
END IF







IF shoot(2) = 1 THEN

IF ammo(2) = 1 THEN

IF angle(2) = 1 THEN
CIRCLE (bulletx(2), bullety(2)), 10, 0
PAINT (bulletx(2), bullety(2)), 0, 0

bullety(2) = bullety(2) + shootnumber

CIRCLE (bulletx(2), bullety(2)), 1, 4
PAINT (bulletx(2), bullety(2)), 4, 4
END IF

IF angle(2) = 2 THEN
CIRCLE (bulletx(2), bullety(2)), 10, 0
PAINT (bulletx(2), bullety(2)), 0, 0

bullety(2) = bullety(2) + shootnumber
bulletx(2) = bulletx(2) - shootnumber

CIRCLE (bulletx(2), bullety(2)), 1, 4
PAINT (bulletx(2), bullety(2)), 4, 4
END IF


IF angle(2) = 3 THEN
CIRCLE (bulletx(2), bullety(2)), 10, 0
PAINT (bulletx(2), bullety(2)), 0, 0

bulletx(2) = bulletx(2) - shootnumber

CIRCLE (bulletx(2), bullety(2)), 1, 4
PAINT (bulletx(2), bullety(2)), 4, 4
END IF

IF angle(2) = 4 THEN
CIRCLE (bulletx(2), bullety(2)), 10, 0
PAINT (bulletx(2), bullety(2)), 0, 0

bullety(2) = bullety(2) - shootnumber
bulletx(2) = bulletx(2) - shootnumber

CIRCLE (bulletx(2), bullety(2)), 1, 4
PAINT (bulletx(2), bullety(2)), 4, 4
END IF

IF angle(2) = 5 THEN
CIRCLE (bulletx(2), bullety(2)), 10, 0
PAINT (bulletx(2), bullety(2)), 0, 0

bullety(2) = bullety(2) - shootnumber

CIRCLE (bulletx(2), bullety(2)), 1, 4
PAINT (bulletx(2), bullety(2)), 4, 4
END IF

IF angle(2) = 6 THEN
CIRCLE (bulletx(2), bullety(2)), 10, 0
PAINT (bulletx(2), bullety(2)), 0, 0

bullety(2) = bullety(2) - shootnumber
bulletx(2) = bulletx(2) + shootnumber

CIRCLE (bulletx(2), bullety(2)), 1, 4
PAINT (bulletx(2), bullety(2)), 4, 4
END IF

IF angle(2) = 7 THEN
CIRCLE (bulletx(2), bullety(2)), 10, 0
PAINT (bulletx(2), bullety(2)), 0, 0

bulletx(2) = bulletx(2) + shootnumber

CIRCLE (bulletx(2), bullety(2)), 1, 4
PAINT (bulletx(2), bullety(2)), 4, 4
END IF

IF angle(2) = 8 THEN
CIRCLE (bulletx(2), bullety(2)), 10, 0
PAINT (bulletx(2), bullety(2)), 0, 0

bullety(2) = bullety(2) + shootnumber
bulletx(2) = bulletx(2) + shootnumber

CIRCLE (bulletx(2), bullety(2)), 1, 4
PAINT (bulletx(2), bullety(2)), 4, 4
END IF

END IF


IF ammo(2) = 2 THEN

IF angle(2) = 1 THEN
CIRCLE (bulletx(2), bullety(2)), 10, 0
PAINT (bulletx(2), bullety(2)), 0, 0

bullety(2) = bullety(2) + shootnumber / 3

CIRCLE (bulletx(2), bullety(2)), 2, 14
PAINT (bulletx(2), bullety(2)), 14, 14
END IF

IF angle(2) = 2 THEN
CIRCLE (bulletx(2), bullety(2)), 10, 0
PAINT (bulletx(2), bullety(2)), 0, 0

bullety(2) = bullety(2) + shootnumber / 3
bulletx(2) = bulletx(2) - shootnumber / 3

CIRCLE (bulletx(2), bullety(2)), 2, 14
PAINT (bulletx(2), bullety(2)), 14, 14
END IF


IF angle(2) = 3 THEN
CIRCLE (bulletx(2), bullety(2)), 10, 0
PAINT (bulletx(2), bullety(2)), 0, 0

bulletx(2) = bulletx(2) - shootnumber / 3

CIRCLE (bulletx(2), bullety(2)), 2, 14
PAINT (bulletx(2), bullety(2)), 14, 14
END IF

IF angle(2) = 4 THEN
CIRCLE (bulletx(2), bullety(2)), 10, 0
PAINT (bulletx(2), bullety(2)), 0, 0

bullety(2) = bullety(2) - shootnumber / 3
bulletx(2) = bulletx(2) - shootnumber / 3

CIRCLE (bulletx(2), bullety(2)), 2, 14
PAINT (bulletx(2), bullety(2)), 14, 14
END IF

IF angle(2) = 5 THEN
CIRCLE (bulletx(2), bullety(2)), 10, 0
PAINT (bulletx(2), bullety(2)), 0, 0

bullety(2) = bullety(2) - shootnumber / 3

CIRCLE (bulletx(2), bullety(2)), 2, 14
PAINT (bulletx(2), bullety(2)), 14, 14
END IF

IF angle(2) = 6 THEN
CIRCLE (bulletx(2), bullety(2)), 10, 0
PAINT (bulletx(2), bullety(2)), 0, 0

bullety(2) = bullety(2) - shootnumber / 3
bulletx(2) = bulletx(2) + shootnumber / 3

CIRCLE (bulletx(2), bullety(2)), 2, 14
PAINT (bulletx(2), bullety(2)), 14, 14
END IF

IF angle(2) = 7 THEN
CIRCLE (bulletx(2), bullety(2)), 10, 0
PAINT (bulletx(2), bullety(2)), 0, 0

bulletx(2) = bulletx(2) + shootnumber / 3

CIRCLE (bulletx(2), bullety(2)), 2, 14
PAINT (bulletx(2), bullety(2)), 14, 14
END IF

IF angle(2) = 8 THEN
CIRCLE (bulletx(2), bullety(2)), 10, 0
PAINT (bulletx(2), bullety(2)), 0, 0

bullety(2) = bullety(2) + shootnumber / 3
bulletx(2) = bulletx(2) + shootnumber / 3

CIRCLE (bulletx(2), bullety(2)), 2, 14
PAINT (bulletx(2), bullety(2)), 14, 14
END IF
END IF

END IF


IF shoot(3) = 1 THEN

IF ammo(3) = 1 THEN

IF angle(3) = 1 THEN
CIRCLE (bulletx(3), bullety(3)), 10, 0
PAINT (bulletx(3), bullety(3)), 0, 0

bullety(3) = bullety(3) + shootnumber

CIRCLE (bulletx(3), bullety(3)), 1, 4
PAINT (bulletx(3), bullety(3)), 4, 4
END IF

IF angle(3) = 2 THEN
CIRCLE (bulletx(3), bullety(3)), 10, 0
PAINT (bulletx(3), bullety(3)), 0, 0

bullety(3) = bullety(3) + shootnumber
bulletx(3) = bulletx(3) - shootnumber

CIRCLE (bulletx(3), bullety(3)), 1, 4
PAINT (bulletx(3), bullety(3)), 4, 4
END IF


IF angle(3) = 3 THEN
CIRCLE (bulletx(3), bullety(3)), 10, 0
PAINT (bulletx(3), bullety(3)), 0, 0

bulletx(3) = bulletx(3) - shootnumber

CIRCLE (bulletx(3), bullety(3)), 1, 4
PAINT (bulletx(3), bullety(3)), 4, 4
END IF

IF angle(3) = 4 THEN
CIRCLE (bulletx(3), bullety(3)), 10, 0
PAINT (bulletx(3), bullety(3)), 0, 0

bullety(3) = bullety(3) - shootnumber
bulletx(3) = bulletx(3) - shootnumber

CIRCLE (bulletx(3), bullety(3)), 1, 4
PAINT (bulletx(3), bullety(3)), 4, 4
END IF

IF angle(3) = 5 THEN
CIRCLE (bulletx(3), bullety(3)), 10, 0
PAINT (bulletx(3), bullety(3)), 0, 0

bullety(3) = bullety(3) - shootnumber

CIRCLE (bulletx(3), bullety(3)), 1, 4
PAINT (bulletx(3), bullety(3)), 4, 4
END IF

IF angle(3) = 6 THEN
CIRCLE (bulletx(3), bullety(3)), 10, 0
PAINT (bulletx(3), bullety(3)), 0, 0

bullety(3) = bullety(3) - shootnumber
bulletx(3) = bulletx(3) + shootnumber

CIRCLE (bulletx(3), bullety(3)), 1, 4
PAINT (bulletx(3), bullety(3)), 4, 4
END IF

IF angle(3) = 7 THEN
CIRCLE (bulletx(3), bullety(3)), 10, 0
PAINT (bulletx(3), bullety(3)), 0, 0

bulletx(3) = bulletx(3) + shootnumber

CIRCLE (bulletx(3), bullety(3)), 1, 4
PAINT (bulletx(3), bullety(3)), 4, 4
END IF

IF angle(3) = 8 THEN
CIRCLE (bulletx(3), bullety(3)), 10, 0
PAINT (bulletx(3), bullety(3)), 0, 0

bullety(3) = bullety(3) + shootnumber
bulletx(3) = bulletx(3) + shootnumber

CIRCLE (bulletx(3), bullety(3)), 1, 4
PAINT (bulletx(3), bullety(3)), 4, 4
END IF
END IF


IF ammo(3) = 2 THEN

IF angle(3) = 1 THEN
CIRCLE (bulletx(3), bullety(3)), 10, 0
PAINT (bulletx(3), bullety(3)), 0, 0

bullety(3) = bullety(3) + shootnumber / 3

CIRCLE (bulletx(3), bullety(3)), 2, 14
PAINT (bulletx(3), bullety(3)), 14, 14
END IF

IF angle(3) = 2 THEN
CIRCLE (bulletx(3), bullety(3)), 10, 0
PAINT (bulletx(3), bullety(3)), 0, 0

bullety(3) = bullety(3) + shootnumber / 3
bulletx(3) = bulletx(3) - shootnumber / 3

CIRCLE (bulletx(3), bullety(3)), 2, 14
PAINT (bulletx(3), bullety(3)), 14, 14
END IF


IF angle(3) = 3 THEN
CIRCLE (bulletx(3), bullety(3)), 10, 0
PAINT (bulletx(3), bullety(3)), 0, 0

bulletx(3) = bulletx(3) - shootnumber / 3

CIRCLE (bulletx(3), bullety(3)), 2, 14
PAINT (bulletx(3), bullety(3)), 14, 14
END IF

IF angle(3) = 4 THEN
CIRCLE (bulletx(3), bullety(3)), 10, 0
PAINT (bulletx(3), bullety(3)), 0, 0

bullety(3) = bullety(3) - shootnumber / 3
bulletx(3) = bulletx(3) - shootnumber / 3

CIRCLE (bulletx(3), bullety(3)), 2, 14
PAINT (bulletx(3), bullety(3)), 14, 14
END IF

IF angle(3) = 5 THEN
CIRCLE (bulletx(3), bullety(3)), 10, 0
PAINT (bulletx(3), bullety(3)), 0, 0

bullety(3) = bullety(3) - shootnumber / 3

CIRCLE (bulletx(3), bullety(3)), 2, 14
PAINT (bulletx(3), bullety(3)), 14, 14
END IF

IF angle(3) = 6 THEN
CIRCLE (bulletx(3), bullety(3)), 10, 0
PAINT (bulletx(3), bullety(3)), 0, 0

bullety(3) = bullety(3) - shootnumber / 3
bulletx(3) = bulletx(3) + shootnumber / 3

CIRCLE (bulletx(3), bullety(3)), 2, 14
PAINT (bulletx(3), bullety(3)), 14, 14
END IF

IF angle(3) = 7 THEN
CIRCLE (bulletx(3), bullety(3)), 10, 0
PAINT (bulletx(3), bullety(3)), 0, 0

bulletx(3) = bulletx(3) + shootnumber / 3

CIRCLE (bulletx(3), bullety(3)), 2, 14
PAINT (bulletx(3), bullety(3)), 14, 14
END IF

IF angle(3) = 8 THEN
CIRCLE (bulletx(3), bullety(3)), 10, 0
PAINT (bulletx(3), bullety(3)), 0, 0

bullety(3) = bullety(3) + shootnumber / 3
bulletx(3) = bulletx(3) + shootnumber / 3

CIRCLE (bulletx(3), bullety(3)), 2, 14
PAINT (bulletx(3), bullety(3)), 14, 14
END IF
END IF






END IF

GOTO enddrawbullet

enddrawbullet:
END SUB

SUB draw.enemy

'LINE (xx - 12, yy - 15)-(xx + 12, yy + 11), 0, BF

'LINE (xx - 4, yy)-(xx + 4, yy), 2
'LINE (xx, yy)-(xx, yy + 8), 2

IF angle(2) = 1 THEN
LINE (xx - 4, yy)-(xx + 4, yy), bc
LINE (xx - 5, yy)-(xx, yy + 12), bc
LINE (xx + 5, yy)-(xx, yy + 12), bc
END IF

IF angle(2) = 8 THEN
LINE (xx - 4, yy + 4)-(xx + 4, yy - 4), bc
LINE (xx - 4, yy + 4)-(xx + 8, yy + 8), bc
LINE (xx + 4, yy - 4)-(xx + 8, yy + 8), bc
END IF


IF angle(2) = 3 THEN
LINE (xx, yy - 4)-(xx, yy + 4), bc
LINE (xx, yy - 5)-(xx - 12, yy), bc
LINE (xx, yy + 5)-(xx - 12, yy), bc
END IF

IF angle(2) = 6 THEN
LINE (xx - 4, yy - 4)-(xx + 4, yy + 4), bc
LINE (xx - 4, yy - 4)-(xx + 8, yy - 8), bc
LINE (xx + 4, yy + 4)-(xx + 8, yy - 8), bc
END IF

IF angle(2) = 5 THEN
LINE (xx - 4, yy)-(xx + 4, yy), bc
LINE (xx - 5, yy)-(xx, yy - 12), bc
LINE (xx + 5, yy)-(xx, yy - 12), bc
END IF

IF angle(2) = 4 THEN
LINE (xx - 4, yy + 4)-(xx + 4, yy - 4), bc
LINE (xx - 4, yy + 4)-(xx - 8, yy - 8), bc
LINE (xx + 4, yy - 4)-(xx - 8, yy - 8), bc
END IF

IF angle(2) = 7 THEN
LINE (xx, yy - 4)-(xx, yy + 4), bc
LINE (xx, yy - 5)-(xx + 12, yy), bc
LINE (xx, yy + 5)-(xx + 12, yy), bc
END IF

IF angle(2) = 2 THEN
LINE (xx - 4, yy - 4)-(xx + 4, yy + 4), bc
LINE (xx - 4, yy - 4)-(xx - 8, yy + 8), bc
LINE (xx + 4, yy + 4)-(xx - 8, yy + 8), bc
END IF

END SUB

SUB draw.ship

IF angle(1) = 1 THEN
LINE (x - 5, y)-(x + 5, y), gc
LINE (x, y)-(x, y - 10), gc
END IF

IF angle(1) = 2 THEN
LINE (x - 4, y + 4)-(x + 4, y - 4), gc
LINE (x, y)-(x - 8, y - 8), gc
END IF

IF angle(1) = 3 THEN
LINE (x, y + 5)-(x, y - 5), gc
LINE (x, y)-(x - 10, y), gc
END IF

IF angle(1) = 4 THEN
LINE (x - 4, y - 4)-(x + 4, y + 4), gc
LINE (x, y)-(x - 8, y + 8), gc
END IF

IF angle(1) = 5 THEN
LINE (x - 5, y)-(x + 5, y), gc
LINE (x, y)-(x, y + 10), gc
END IF

IF angle(1) = 6 THEN
LINE (x - 4, y + 4)-(x + 4, y - 4), gc
LINE (x, y)-(x + 8, y + 8), gc
END IF

IF angle(1) = 7 THEN
LINE (x, y + 5)-(x, y - 5), gc
LINE (x, y)-(x + 10, y), gc
END IF

IF angle(1) = 8 THEN
LINE (x - 4, y - 4)-(x + 4, y + 4), gc
LINE (x, y)-(x + 8, y - 8), gc
END IF

END SUB

SUB draw.ship.three

IF angle(3) = 1 THEN
LINE (xxa - 4, yya)-(xxa + 4, yya), bcc
LINE (xxa - 5, yya)-(xxa, yya + 5), bcc
LINE (xxa + 5, yya)-(xxa, yya + 5), bcc
END IF

IF angle(3) = 8 THEN
LINE (xxa - 4, yya + 4)-(xxa + 4, yya - 4), bcc
LINE (xxa - 4, yya + 4)-(xxa + 4, yya + 4), bcc
LINE (xxa + 4, yya - 4)-(xxa + 4, yya + 4), bcc
END IF


IF angle(3) = 3 THEN
LINE (xxa, yya - 4)-(xxa, yya + 4), bcc
LINE (xxa, yya - 5)-(xxa - 5, yya), bcc
LINE (xxa, yya + 5)-(xxa - 5, yya), bcc
END IF

IF angle(3) = 6 THEN
LINE (xxa - 4, yya - 4)-(xxa + 4, yya + 4), bcc
LINE (xxa - 4, yya - 4)-(xxa + 4, yya - 4), bcc
LINE (xxa + 4, yya + 4)-(xxa + 4, yya - 4), bcc
END IF

IF angle(3) = 5 THEN
LINE (xxa - 4, yya)-(xxa + 4, yya), bcc
LINE (xxa - 5, yya)-(xxa, yya - 5), bcc
LINE (xxa + 5, yya)-(xxa, yya - 5), bcc
END IF

IF angle(3) = 4 THEN
LINE (xxa - 4, yya + 4)-(xxa + 4, yya - 4), bcc
LINE (xxa - 4, yya + 4)-(xxa - 4, yya - 4), bcc
LINE (xxa + 4, yya - 4)-(xxa - 4, yya - 4), bcc
END IF

IF angle(3) = 7 THEN
LINE (xxa, yya - 4)-(xxa, yya + 4), bcc
LINE (xxa, yya - 5)-(xxa + 5, yya), bcc
LINE (xxa, yya + 5)-(xxa + 5, yya), bcc
END IF

IF angle(3) = 2 THEN
LINE (xxa - 4, yya - 4)-(xxa + 4, yya + 4), bcc
LINE (xxa - 4, yya - 4)-(xxa - 4, yya + 4), bcc
LINE (xxa + 4, yya + 4)-(xxa - 4, yya + 4), bcc
END IF


END SUB

SUB errcode



END SUB

SUB flare

IF angle(1) = 1 THEN
LINE (x - 5, y)-(x + 5, y), gc
LINE (x, y)-(x, y - 10), gc
LINE (x, y)-(x, y + 3), fc
END IF

IF angle(1) = 2 THEN
LINE (x - 4, y + 4)-(x + 4, y - 4), gc
LINE (x, y)-(x - 8, y - 8), gc
LINE (x, y)-(x + 2, y + 2), fc
END IF

IF angle(1) = 3 THEN
LINE (x, y + 5)-(x, y - 5), gc
LINE (x, y)-(x - 10, y), gc
LINE (x, y)-(x + 3, y), fc
END IF

IF angle(1) = 4 THEN
LINE (x - 4, y - 4)-(x + 4, y + 4), gc
LINE (x, y)-(x - 8, y + 8), gc
LINE (x, y)-(x + 2, y - 2), fc
END IF

IF angle(1) = 5 THEN
LINE (x - 5, y)-(x + 5, y), gc
LINE (x, y)-(x, y + 10), gc
LINE (x, y)-(x, y - 3), fc
END IF

IF angle(1) = 6 THEN
LINE (x - 4, y + 4)-(x + 4, y - 4), gc
LINE (x, y)-(x + 8, y + 8), gc
LINE (x, y)-(x - 2, y - 2), fc
END IF

IF angle(1) = 7 THEN
LINE (x, y + 5)-(x, y - 5), gc
LINE (x, y)-(x + 10, y), gc
LINE (x, y)-(x - 3, y), fc
END IF

IF angle(1) = 8 THEN
LINE (x - 4, y - 4)-(x + 4, y + 4), gc
LINE (x, y)-(x + 8, y - 8), gc
LINE (x, y)-(x - 2, y + 2), fc
END IF


FOR delay = 1 TO delaynumber * 10: NEXT delay

END SUB

SUB flare.three

IF angle(3) = 1 THEN
LINE (xxa - 5, yya)-(xxa + 5, yya), bcc
LINE (xxa - 5, yya)-(xxa, yya + 5), bcc
LINE (xxa + 5, yya)-(xxa, yya + 5), bcc
LINE (xxa, yya)-(xxa, yya - 3), fc
END IF

IF angle(3) = 2 THEN
LINE (xxa - 4, yya - 4)-(xxa + 4, yya + 4), bcc
LINE (xxa - 4, yya - 4)-(xxa - 4, yya + 4), bcc
LINE (xxa + 4, yya + 4)-(xxa - 4, yya + 4), bcc
LINE (xxa, yya)-(xxa + 2, yya - 2), fc
END IF

IF angle(3) = 3 THEN
LINE (xxa, yya - 5)-(xxa, yya + 5), bcc
LINE (xxa, yya - 5)-(xxa - 5, yya), bcc
LINE (xxa, yya + 5)-(xxa - 5, yya), bcc
LINE (xxa, yya)-(xxa + 3, yya), fc
END IF

IF angle(3) = 4 THEN
LINE (xxa - 4, yya + 4)-(xxa + 4, yya - 4), bcc
LINE (xxa - 4, yya + 4)-(xxa - 4, yya - 4), bcc
LINE (xxa + 4, yya - 4)-(xxa - 4, yya - 4), bcc
LINE (xxa, yya)-(xxa + 2, yya + 2), fc
END IF

IF angle(3) = 5 THEN
LINE (xxa - 5, yya)-(xxa + 5, yya), bcc
LINE (xxa - 5, yya)-(xxa, yya - 5), bcc
LINE (xxa + 5, yya)-(xxa, yya - 5), bcc
LINE (xxa, yya)-(xxa, yya + 3), fc
END IF

IF angle(3) = 6 THEN
LINE (xxa - 4, yya - 4)-(xxa + 4, yya + 4), bcc
LINE (xxa - 4, yya - 4)-(xxa + 4, yya - 4), bcc
LINE (xxa + 4, yya + 4)-(xxa + 4, yya - 4), bcc
LINE (xxa, yya)-(xxa - 2, yya + 2), fc
END IF

IF angle(3) = 7 THEN
LINE (xxa, yya - 5)-(xxa, yya + 5), bcc
LINE (xxa, yya - 5)-(xxa + 5, yya), bcc
LINE (xxa, yya + 5)-(xxa + 5, yya), bcc
LINE (xxa, yya)-(xxa - 3, yya), fc
END IF

IF angle(3) = 8 THEN
LINE (xxa - 4, yya + 4)-(xxa + 4, yya - 4), bcc
LINE (xxa - 4, yya + 4)-(xxa + 4, yya + 4), bcc
LINE (xxa + 4, yya - 4)-(xxa + 4, yya + 4), bcc
LINE (xxa, yya)-(xxa - 2, yya - 2), fc
END IF


END SUB

SUB flash



press$ = INKEY$

IF dir = 1 THEN
press$ = INKEY$
xa = xa + 3 'movenumber / 2 - 1

'LINE (x, y)-(x + 4, y), 14

LINE (0, 0)-(316, 196), 0, B
LINE (0, 0)-(317, 197), 0, B
LINE (0, 0)-(318, 198), 0, B

LINE (1, 1)-(315, 195), 14, B

'LINE (1, 1)-(1, 199), 14
'LINE (1, 190)-(315, 190), 14
'LINE (315, 195)-(315, 1), 14

PSET (xa, ya), 44
PSET (xa + 1, ya), 44
PSET (xa + 2, ya), 44
PSET (xa + 2, ya), 45
PSET (xa + 3, ya), 45
PSET (xa + 4, ya), 45
PSET (xa + 5, ya), 46
PSET (xa + 6, ya), 46
PSET (xa + 7, ya), 46
PSET (xa + 8, ya), 47
PSET (xa + 9, ya), 47
PSET (xa + 10, ya), 47
PSET (xa + 11, ya), 48
PSET (xa + 12, ya), 48
PSET (xa + 13, ya), 48
PSET (xa + 14, ya), 49
PSET (xa + 15, ya), 49
PSET (xa + 16, ya), 49

IF xa > 299 THEN
xa = 315
ya = 1
dir = 2
END IF

IF press$ = CHR$(27) THEN END
FOR delay = 1 TO delaynumber / 4: NEXT delay
END IF


IF dir = 2 THEN
ya = ya + 3 'movenumber / 2 - 1
LINE (0, 0)-(316, 196), 0, B
LINE (0, 0)-(317, 197), 0, B
LINE (0, 0)-(318, 198), 0, B

LINE (1, 1)-(315, 195), 14, B


PSET (xa, ya), 44
PSET (xa, ya + 1), 44
PSET (xa, ya + 2), 44
PSET (xa, ya + 2), 45
PSET (xa, ya + 3), 45
PSET (xa, ya + 4), 45
PSET (xa, ya + 5), 46
PSET (xa, ya + 6), 46
PSET (xa, ya + 7), 46
PSET (xa, ya + 8), 47
PSET (xa, ya + 9), 47
PSET (xa, ya + 10), 47
PSET (xa, ya + 11), 48
PSET (xa, ya + 12), 48
PSET (xa, ya + 13), 48
PSET (xa, ya + 14), 49
PSET (xa, ya + 15), 49
PSET (xa, ya + 16), 49
          
IF ya > 180 THEN
xa = 299
ya = 195
dir = 3
END IF

IF press$ = CHR$(27) THEN END
FOR delay = 1 TO delaynumber / 4: NEXT delay

END IF

IF dir = 3 THEN
press$ = INKEY$
xa = xa - 2 ' movenumber / 2 - 1

'LINE (x, y)-(x + 4, y), 14

LINE (0, 0)-(316, 196), 0, B
LINE (0, 0)-(317, 197), 0, B
LINE (0, 0)-(318, 198), 0, B

LINE (1, 1)-(315, 195), 14, B

'LINE (1, 1)-(1, 199), 14
'LINE (1, 190)-(315, 190), 14
'LINE (315, 195)-(315, 1), 14

PSET (xa, ya), 49
PSET (xa + 1, ya), 49
PSET (xa + 2, ya), 49
PSET (xa + 2, ya), 48
PSET (xa + 3, ya), 48
PSET (xa + 4, ya), 48
PSET (xa + 5, ya), 47
PSET (xa + 6, ya), 47
PSET (xa + 7, ya), 47
PSET (xa + 8, ya), 46
PSET (xa + 9, ya), 46
PSET (xa + 10, ya), 46
PSET (xa + 11, ya), 45
PSET (xa + 12, ya), 45
PSET (xa + 13, ya), 45
PSET (xa + 14, ya), 44
PSET (xa + 15, ya), 44
PSET (xa + 16, ya), 44

IF xa < 16 THEN
xa = 1
ya = 180
dir = 4
END IF

IF press$ = CHR$(27) THEN END
FOR delay = 1 TO delaynumber / 4: NEXT delay
END IF

IF dir = 4 THEN
ya = ya - 2 'movenumber / 2 - 1
LINE (0, 0)-(316, 196), 0, B
LINE (0, 0)-(317, 197), 0, B
LINE (0, 0)-(318, 198), 0, B

LINE (1, 1)-(315, 195), 14, B


PSET (xa, ya), 49
PSET (xa, ya + 1), 49
PSET (xa, ya + 2), 49
PSET (xa, ya + 2), 48
PSET (xa, ya + 3), 48
PSET (xa, ya + 4), 48
PSET (xa, ya + 5), 47
PSET (xa, ya + 6), 47
PSET (xa, ya + 7), 47
PSET (xa, ya + 8), 46
PSET (xa, ya + 9), 46
PSET (xa, ya + 10), 46
PSET (xa, ya + 11), 45
PSET (xa, ya + 12), 45
PSET (xa, ya + 13), 45
PSET (xa, ya + 14), 44
PSET (xa, ya + 15), 44
PSET (xa, ya + 16), 44
          
IF ya < 1 THEN
xa = 1
ya = 1
dir = 1
END IF

IF press$ = CHR$(27) THEN END
FOR delay = 1 TO delaynumber / 4: NEXT delay

END IF




END SUB

SUB gravity

grav = INT(RND * gravint)
IF grav = 1 THEN

LINE (xx - 12, yy - 15)-(xx + 12, yy + 12), 0, BF
LINE (x - 10, y - 15)-(x + 10, y + 10), 0, BF
LINE (xxa - 10, yya - 10)-(xxa + 10, yya + 6), 0, BF

'y = y + 1
'yy = yy + 1

IF lastpress(1) = 8 THEN
y = y + 3
END IF

IF lastpress(1) = 7 THEN
y = y + 3
x = x - 1
END IF

IF lastpress(1) = 4 THEN
y = y + 1
x = x - 2
END IF

IF lastpress(1) = 1 THEN
y = y + 1
x = x - 1
END IF

IF lastpress(1) = 2 THEN
y = y + 1
END IF

IF lastpress(1) = 3 THEN
y = y + 1
x = x + 1
END IF

IF lastpress(1) = 6 THEN
y = y + 1
x = x + 2
END IF

IF lastpress(1) = 9 THEN
y = y + 3
x = x + 1
END IF



IF lastpress(2) = 2 THEN
yy = yy + 3
END IF

IF lastpress(2) = 1 THEN
yy = yy + 3
xx = xx - 1
END IF

IF lastpress(2) = 4 THEN
yy = yy + 1
xx = xx - 2
END IF

IF lastpress(2) = 7 THEN
yy = yy + 1
xx = xx - 1
END IF

'IF lastpress(2) = 8 THEN
'yy = yy + 1
'END IF

IF lastpress(2) = 3 THEN
yy = yy + 1
xx = xx + 1
END IF

IF lastpress(2) = 9 THEN
yy = yy + 1
'xx = xx + 2
END IF

IF lastpress(2) = 6 THEN
yy = yy + 3
END IF



IF lastpress(3) = 2 THEN
yya = yya + 3
END IF

IF lastpress(3) = 1 THEN
yya = yya + 3
xxa = xxa - 1
END IF

IF lastpress(3) = 4 THEN
yya = yya + 1
xxa = xxa - 2
END IF

IF lastpress(3) = 7 THEN
yya = yya + 1
xxa = xxa - 1
END IF

IF lastpress(3) = 9 THEN
yya = yya + 1
END IF

IF lastpress(3) = 3 THEN
yya = yya + 1
xxa = xxa + 1
END IF

IF lastpress(3) = 8 THEN
yya = yya + 3
xxa = xxa + 2
END IF

IF lastpress(3) = 6 THEN
yya = yya + 3
xxa = xxa + 1
END IF





END IF

END SUB

SUB menu

CLS 1
CLS 2
press$ = INKEY$

menu:
press$ = INKEY$
CLS 1
CLS 2
COLOR 25
PRINT "MENU"
PRINT

PRINT "1) ";
COLOR 4: PRINT "H";
COLOR 25: PRINT "it percentage"

PRINT "2) ";
COLOR 4: PRINT "C";
COLOR 25: PRINT "ontrols"

PRINT "3) ";
COLOR 4: PRINT "S";
COLOR 25: PRINT "hip colour"

PRINT "4) ";
COLOR 4: PRINT "G";
COLOR 25: PRINT "ravity"

PRINT "5) ";
COLOR 4: PRINT "R";
COLOR 25: PRINT "estart"

PRINT "6) ";
PRINT "R";
COLOR 4: PRINT "e";
COLOR 25: PRINT "sume"

PRINT "7) ";
COLOR 4: PRINT "Q";
COLOR 25: PRINT "uit"

INPUT ">", ress$

IF ress$ = CHR$(27) THEN END
IF ress$ = "h" OR ress$ = "H" THEN GOTO hitmiss
IF ress$ = "c" OR ress$ = "C" THEN GOTO controls
IF ress$ = "s" OR ress$ = "S" THEN GOTO shipcolour
IF ress$ = "r" OR ress$ = "R" THEN GOTO restart
IF ress$ = "q" OR ress$ = "Q" THEN GOTO quit
IF ress$ = "e" OR ress$ = "E" THEN GOTO resumer
IF ress$ = "g" OR ress$ = "G" THEN GOTO gravity

hitmiss:
CLS 1
CLS 2
PRINT
PRINT "Player 1 hit/miss percentage: "; gagne(1) / miss(1)
PRINT "Player 2 hit/miss percentage: "; gagne(2) / miss(2)
PRINT "Player 3 hit/miss percentage: "; gagne(3) / miss(3)
INPUT ">", gasfddasfds$
IF gasfddasfds$ = "wer" THEN END
GOTO menu

controls:
CLS 1
CLS 2
COLOR 4
PRINT "Control          Player 1       Player 2     Player 3"
COLOR 25
PRINT
PRINT "Right            right arrow    d            j"
PRINT "Left             left arrow     a            g"
PRINT "Up               up arrow       w            y"
PRINT "Down/shoot       down arrow     s            h "
INPUT ">", gadsfsfda$
GOTO menu

shipcolour:
press$ = INKEY$
CLS 1
CLS 2
PRINT
PRINT "Player 1 "; gc
PRINT "Player 2 "; bc
PRINT "Player 3 "; bcc
PRINT
PRINT "1) ";
COLOR 4: PRINT "R";
COLOR 25: PRINT "esume"

PRINT "2) ";
COLOR 4: PRINT "E";
COLOR 25: PRINT "dit player 1 colour"

PRINT "3) ";
COLOR 4: PRINT "C";
COLOR 25: PRINT "hange player 2 colour"

PRINT "4) ";
COLOR 4: PRINT "A";
COLOR 25: PRINT "lter player 3 colour"

INPUT ">", pres$
IF pres$ = "r" OR pres$ = "R" THEN GOTO menu
IF pres$ = "e" OR pres$ = "E" THEN GOTO onechoose
IF pres$ = "c" OR pres$ = "C" THEN GOTO twochoose
IF pres$ = "a" OR pres$ = "A" THEN GOTO threechoose

onechoose:
CLS 1
CLS 2
PRINT
PRINT "Choose Player 1 colour:"
PRINT
PRINT "1) ";
COLOR 4: PRINT "G";
COLOR 25: PRINT "reen"

PRINT "2) ";
COLOR 4: PRINT "B";
COLOR 25: PRINT "lue"

PRINT "3) ";
COLOR 4: PRINT "R";
COLOR 25: PRINT "ed"

PRINT "4) ";
COLOR 4: PRINT "Y";
COLOR 25: PRINT "ellow"
INPUT ">", presss$
IF presss$ = "g" OR presss$ = "G" THEN gc = 2
IF presss$ = "b" OR presss$ = "B" THEN gc = 3
IF presss$ = "r" OR presss$ = "R" THEN gc = 4
IF presss$ = "y" OR presss$ = "Y" THEN gc = 14
GOTO shipcolour

twochoose:
CLS 1
CLS 2
PRINT
PRINT "Choose Player 2 colour:"
PRINT
PRINT "1) ";
COLOR 4: PRINT "G";
COLOR 25: PRINT "reen"

PRINT "2) ";
COLOR 4: PRINT "B";
COLOR 25: PRINT "lue"

PRINT "3) ";
COLOR 4: PRINT "R";
COLOR 25: PRINT "ed"

PRINT "4) ";
COLOR 4: PRINT "Y";
COLOR 25: PRINT "ellow"
INPUT ">", ppress$

IF ppress$ = "g" OR ppress$ = "G" THEN bc = 2
IF ppress$ = "b" OR ppress$ = "B" THEN bc = 3
IF ppress$ = "r" OR ppress$ = "R" THEN bc = 4
IF ppress$ = "y" OR ppress$ = "Y" THEN bc = 14
GOTO shipcolour

threechoose:
CLS 1
CLS 2
PRINT
PRINT "Choose Player 3 colour:"
PRINT
PRINT "1) ";
COLOR 4: PRINT "G";
COLOR 25: PRINT "reen"

PRINT "2) ";
COLOR 4: PRINT "B";
COLOR 25: PRINT "lue"

PRINT "3) ";
COLOR 4: PRINT "R";
COLOR 25: PRINT "ed"

PRINT "4) ";
COLOR 4: PRINT "Y";
COLOR 25: PRINT "ellow"
INPUT ">", pppress$

IF pppress$ = "g" OR pppress$ = "G" THEN bcc = 2
IF pppress$ = "b" OR pppress$ = "B" THEN bcc = 3
IF pppress$ = "r" OR pppress$ = "R" THEN bcc = 4
IF pppress$ = "y" OR pppress$ = "Y" THEN bcc = 14
GOTO shipcolour


restart:
gagne(1) = 0
gagne(2) = 0
shots(1) = 15
shots(2) = 15
miss(1) = 0
miss(2) = 0
x = 150
y = 190
xx = 150
yy = 20
GOTO ender

quit:
END

gravity:
CLS 1
CLS 2
PRINT
5 PRINT "Gravity = "; gravint
INPUT "Change gravity to: ", gravint
IF grav > 100 THEN grav = 100
IF grav < 0 THEN grav = 0
GOTO menu

resumer:
ender:
CLS 1
CLS 2
END SUB

SUB player.one.win

CLS
CLS 1
CLS 2
PRINT
COLOR gc
PRINT "Player 1 wins!!!"
SLEEP 1
SLEEP 1
SLEEP 1
SLEEP 1

END

END SUB

SUB player.three.win


CLS
CLS 1
CLS 2
PRINT
COLOR bcc
PRINT "Player 3 wins!!!"
SLEEP 1
SLEEP 1
SLEEP 1
SLEEP 1
END

END SUB

SUB Player.two.win

CLS
CLS 1
CLS 2
PRINT
COLOR bc
PRINT "Player 2 wins!!!"
SLEEP 1
SLEEP 1
SLEEP 1
SLEEP 1
END

END SUB

SUB score

LINE (1, 1)-(5, 3), 0, BF
LOCATE 2, 2: COLOR 3: PRINT gagne(1); " "; shots(1); " "; ammo(1)
LOCATE 3, 2: COLOR 2: PRINT gagne(2); " "; shots(2); " "; ammo(2)
LOCATE 4, 2: COLOR 43: PRINT gagne(3); " "; shots(3); " "; ammo(3)

IF shots(1) = 0 AND shots(2) = 0 AND shots(3) = 0 THEN
shots(1) = 15
shots(2) = 15
shots(3) = 15
END IF

IF shots(1) < 0 THEN shots(1) = 0
IF shots(2) < 0 THEN shots(2) = 0
IF shots(3) < 0 THEN shots(3) = 0

IF gagne(1) > 49 THEN player.one.win
IF gagne(2) > 49 THEN Player.two.win
IF gagne(3) > 49 THEN player.three.win

END SUB

SUB t.flare


IF angle(2) = 1 THEN
LINE (xx - 5, yy)-(xx + 5, yy), bc
LINE (xx - 5, yy)-(xx, yy + 10), bc
LINE (xx + 5, yy)-(xx, yy + 10), bc
LINE (xx, yy)-(xx, yy - 3), fc
END IF

IF angle(2) = 2 THEN
LINE (xx - 4, yy - 4)-(xx + 4, yy + 4), bc
LINE (xx - 4, yy - 4)-(xx - 8, yy + 8), bc
LINE (xx + 4, yy + 4)-(xx - 8, yy + 8), bc
LINE (xx, yy)-(xx + 2, yy - 2), fc
END IF

IF angle(2) = 3 THEN
LINE (xx, yy - 5)-(xx, yy + 5), bc
LINE (xx, yy - 5)-(xx - 10, yy), bc
LINE (xx, yy + 5)-(xx - 10, yy), bc
LINE (xx, yy)-(xx + 3, yy), fc
END IF

IF angle(2) = 4 THEN
LINE (xx - 4, yy + 4)-(xx + 4, yy - 4), bc
LINE (xx - 4, yy + 4)-(xx - 8, yy - 8), bc
LINE (xx + 4, yy - 4)-(xx - 8, yy - 8), bc
LINE (xx, yy)-(xx + 2, yy + 2), fc
END IF

IF angle(2) = 5 THEN
LINE (xx - 5, yy)-(xx + 5, yy), bc
LINE (xx - 5, yy)-(xx, yy - 10), bc
LINE (xx + 5, yy)-(xx, yy - 10), bc
LINE (xx, yy)-(xx, yy + 3), fc
END IF

IF angle(2) = 6 THEN
LINE (xx - 4, yy - 4)-(xx + 4, yy + 4), bc
LINE (xx - 4, yy - 4)-(xx + 8, yy - 8), bc
LINE (xx + 4, yy + 4)-(xx + 8, yy - 8), bc
LINE (xx, yy)-(xx - 2, yy + 2), fc
END IF

IF angle(2) = 7 THEN
LINE (xx, yy - 5)-(xx, yy + 5), bc
LINE (xx, yy - 5)-(xx + 10, yy), bc
LINE (xx, yy + 5)-(xx + 10, yy), bc
LINE (xx, yy)-(xx - 3, yy), fc
END IF

IF angle(2) = 8 THEN
LINE (xx - 4, yy + 4)-(xx + 4, yy - 4), bc
LINE (xx - 4, yy + 4)-(xx + 8, yy + 8), bc
LINE (xx + 4, yy - 4)-(xx + 8, yy + 8), bc
LINE (xx, yy)-(xx - 2, yy - 2), fc
END IF


END SUB

