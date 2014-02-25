DECLARE SUB DrawInner (delta!)
DECLARE SUB DrawCursor (angle!, delta!)
DECLARE SUB DrawOuter ()
SCREEN 12
DIM SHARED PI
DIM SHARED dialsize
DIM SHARED OldAngle, OldX, OldY, OldDelta
PI = 3.141592654#
dialsize = 200 'This is the coolist part change the size of the clock!
DIM SHARED H(10 TO 99, 4)' History
DIM SHARED HH(6 TO 90, 4)
DIM dD AS SINGLE, dC AS INTEGER: dD = .01: dC = 2
DrawInner .02: DrawCursor .02, .02: CLS
LOCATE 1, 1: PRINT "Log: ";
LOCATE 2, 1: PRINT "D: "
LOCATE 3, 1: PRINT "C: ";
LOCATE 4, 1: PRINT "Sin: ";
LOCATE 5, 1: PRINT "Cos: ";
DO
LOCATE 1, 7: PRINT (angle / (2 * PI)) - INT(angle / (2 * PI))
LOCATE 2, 7: PRINT EXP(((angle / (2 * PI)) - INT(angle / (2 * PI))) * LOG(10))
LOCATE 3, 7: PRINT EXP((((angle - delta) / (2 * PI)) - INT((angle - delta) / (2 * PI))) * LOG(10));
ang = EXP((((angle - delta) / (2 * PI)) - INT((angle - delta) / (2 * PI)) - 1) * LOG(10))
ang2 = 2 * ATN(ang / (1 + SQR(1 - ang * ang))) * 180 / PI
LOCATE 4, 7: PRINT ang2;
ang3 = 90 - ang2
LOCATE 5, 7: PRINT ang3;
DrawOuter
DrawInner delta
DrawCursor angle, delta
WHILE INKEY$ <> "": WEND: DO: k$ = UCASE$(INKEY$): LOOP WHILE k$ = ""
SELECT CASE k$
CASE CHR$(27): SYSTEM
CASE "F", "S": GOSUB AdjustSpeed
CASE CHR$(0) + CHR$(80): delta = delta + dD
CASE CHR$(0) + CHR$(72): delta = delta - dD
CASE CHR$(0) + CHR$(77): angle = angle + dD
CASE CHR$(0) + CHR$(75): angle = angle - dD
END SELECT
LOOP
AdjustSpeed:
SELECT CASE dC
CASE 1: IF k$ = "F" THEN dD = .01: dC = 2
CASE 2: IF k$ = "F" THEN dD = .1: dC = 3 ELSE dD = .001: dC = 1
CASE 3: IF k$ = "F" THEN dD = 1: dC = 4 ELSE dD = .01: dC = 2
CASE ELSE: IF k$ = "S" THEN dD = .1: dC = 3
END SELECT
w$ = "----": MID$(w$, dC, 1) = "o"
LOCATE 6, 1: PRINT w$
RETURN

SUB DrawCursor (angle, delta)
IF OldAngle = angle THEN
LINE (320, 240)-(OldX, OldY), 4
EXIT SUB
END IF
OldAngle = angle
cursorX = COS(angle) * dialsize * 1.18
cursorY = SIN(angle) * dialsize * 1.18
LINE (320, 240)-(OldX, OldY), 0
OldX = 320 + cursorX
OldY = 240 + cursorY
LINE (320, 240)-(OldX, OldY), 4
DrawOuter
DrawInner delta
LINE (320, 240)-(OldX, OldY), 4
END SUB

SUB DrawInner (delta)
innersize = dialsize * .8
sinesize = dialsize * .6
IF delta = OldDelta THEN
FOR T = 10 TO 99
COLOR 7: LINE (H(T, 1), H(T, 2))-(H(T, 3), H(T, 4))
NEXT T
FOR T = 6 TO 90
COLOR 7: LINE (HH(T, 1), HH(T, 2))-(HH(T, 3), HH(T, 4))
NEXT
CIRCLE (320, 240), innersize, 7
CIRCLE (320, 240), sinesize, 7
EXIT SUB
END IF
OldDelta = delta
FOR T = 10 TO 99
cool = LOG(T / 10) / LOG(10) * PI * 2 + delta
coolx = COS(cool) * innersize
cooly = SIN(cool) * innersize
IF T MOD 10 = 0 THEN
hatchsize = 1.15
ELSEIF T MOD 10 = 5 THEN
hatchsize = 1.08
ELSE
hatchsize = 1.05
END IF
cool2y = SIN(cool) * (innersize / hatchsize)
cool2x = COS(cool) * (innersize / hatchsize)
COLOR 0: LINE (H(T, 1), H(T, 2))-(H(T, 3), H(T, 4))
H(T, 1) = coolx + 320: H(T, 2) = cooly + 240
H(T, 3) = cool2x + 320: H(T, 4) = cool2y + 240
COLOR 7: LINE (H(T, 1), H(T, 2))-(H(T, 3), H(T, 4))
NEXT T
FOR T = 6 TO 90
sine = LOG(SIN(T * PI / 180)) / LOG(10) * PI * 2 + delta
sinex = COS(sine) * sinesize
siney = SIN(sine) * sinesize
IF T MOD 10 = 0 THEN
hatchsize = 1.15
ELSEIF T MOD 10 = 5 THEN
hatchsize = 1.08
ELSE
hatchsize = 1.05
END IF
sine2x = COS(sine) * (sinesize / hatchsize)
sine2y = SIN(sine) * (sinesize / hatchsize)
COLOR 0: LINE (HH(T, 1), HH(T, 2))-(HH(T, 3), HH(T, 4))
HH(T, 1) = sinex + 320: HH(T, 2) = siney + 240
HH(T, 3) = sine2x + 320: HH(T, 4) = sine2y + 240
COLOR 7: LINE (HH(T, 1), HH(T, 2))-(HH(T, 3), HH(T, 4))
NEXT
CIRCLE (320, 240), innersize, 7
CIRCLE (320, 240), sinesize, 7
END SUB

SUB DrawOuter
asdfsize = dialsize * 1.18
FOR T = 1 TO 100
asdf = (T / 100) * PI * 2
asdfx = COS(asdf) * asdfsize
asdfy = SIN(asdf) * asdfsize
IF T MOD 10 = 0 THEN
hatchsize = 1.15
ELSEIF T MOD 10 = 5 THEN
hatchsize = 1.08
ELSE
hatchsize = 1.05
END IF
asdf2y = SIN(asdf) * (asdfsize / hatchsize)
asdf2x = COS(asdf) * (asdfsize / hatchsize)
LINE (asdfx + 320, asdfy + 240)-(asdf2x + 320, asdf2y + 240)
NEXT
FOR T = 10 TO 99
dial = LOG(T / 10) / LOG(10) * PI * 2
dialx = COS(dial) * dialsize
dialy = SIN(dial) * dialsize
IF T MOD 10 = 0 THEN
hatchsize = 1.15
ELSEIF T MOD 10 = 5 THEN
hatchsize = 1.08
ELSE
hatchsize = 1.05
END IF
dial2y = SIN(dial) * (dialsize / hatchsize)
dial2x = COS(dial) * (dialsize / hatchsize)
LINE (dialx + 320, dialy + 240)-(dial2x + 320, dial2y + 240)
NEXT T
CIRCLE (320, 240), asdfsize, 7
CIRCLE (320, 240), dialsize, 7
END SUB