DIM points(5)
FromWhere = 63
SCREEN 13
green = 0
blue = 0
red = 0
FOR a = 1 TO 63 * 2
IF red < 63 THEN
IF blue <> 1 THEN
red = red + 1
green = green + 1
ELSE
red = red - 1
green = green - 1
END IF
ELSE
blue = 1
red = red - 1
END IF
PALETTE a, red + green * 256 + blue * 65536
NEXT

FOR a = 63 * 2 TO 254
PALETTE a, 0 + 0 * 256 + 0 * 65536
NEXT

colors = 60
FOR a = 1 TO 50
colors = colors + 1
CIRCLE (38, 40), (a), colors
NEXT
colors = 60
FOR a = 1 TO 50
colors = colors + 1
CIRCLE (39, 40), (a), colors
NEXT
colors = 63
FOR a = 1 TO 15
colors = colors + 1
CIRCLE (39, 40), (a), colors
NEXT

PALETTE 255, 63 + 63 * 256 + 63 * 65536
PALETTE 254, 0 + 0 * 256 + 63 * 65536

sen = 255
DO
PSET (100, 105), sen
PSET (200, 150), sen
GOSUB colors
PSET (120, 45), sen
PSET (280, 20), sen
GOSUB colors
PSET (10, 170), sen
GOSUB colors
PSET (245, 100), sen
GOSUB colors
PSET (290, 150), sen
GOSUB colors
PSET (130, 160), sen
GOSUB colors
PSET (15, 90), sen
PSET (233, 50), sen
GOSUB colors
LOOP UNTIL INKEY$ <> ""

GOSUB BigEnding
END

colors:
SELECT CASE sen
CASE 255
sen = 63
CASE 63
sen = 254
CASE 254
sen = 255
END SELECT
RETURN
END

BigEnding:
FOR a = 256 TO 0 STEP -1
PALETTE a, 0 + 0 * 256 + 0 * 65536
NEXT
END














