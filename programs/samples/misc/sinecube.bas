'sinecube 2006 mennonite
'public domain

DIM blox(40, 40, 40) AS INTEGER

SCREEN 12: LINE (0, 0)-(639, 479), , B

l = 8

B$ = B$ + "00000000..."
B$ = B$ + "llnnnnnnl.."
B$ = B$ + "l8lnnnnnnl."
B$ = B$ + "l88llllllll"
B$ = B$ + "l88l000000l"
B$ = B$ + "l88l000000l"
B$ = B$ + "l88l000000l"
B$ = B$ + "l88l000000l"
B$ = B$ + ".l8l000000l"
B$ = B$ + "..ll000000l"
B$ = B$ + "...llllllll"

blox(2, 3, 32) = 1

FOR l = 8 * 32 TO 1 STEP -8

FOR y = 4 TO 4 * 32 STEP 4
FOR x = 8 * 32 TO 1 STEP -8

mm = SIN(x * y * l * 3.14): if mm<0 then mm=-1 else if mm>0 then mm=1
IF blox(x / 8, y / 4, l / 8) = mm + 1 THEN
FOR by = 1 TO 11
FOR bx = 1 TO 11
IF right$(left$(b$,(by - 1) * 11 + bx),1) <> "." THEN
z = 11
PSET (x + bx - 1 + y - 3, by - 1 + y + l + 4), ASC(right$(left$(b$,(by - 1) * 11 + bx),1)) MOD 16 + (y MOD 2)
END IF

NEXT bx
NEXT by

END IF
IF INKEY$ = CHR$(27) THEN END

NEXT x

t = TIMER: DO: LOOP UNTIL t <> TIMER

NEXT y

NEXT l