'SUBLIMIAL MESSAGE GENERATOR -- HIDES MESSAGE IN STRANGE BEEPING NOISES
' modify w$ for different subliminal message

CLS
DO WHILE INKEY$ <> CHR$(27)
COLOR INT(RND(1) * 16), INT(RND(1) * 16)
PRINT " ";
w$ = "QB64 RULES"
y% = (y% + 1)
IF y% > LEN(w$) THEN y% = y% MOD LEN(w$)
z% = ASC(MID$(w$, y%, 1))
x% = 9 * z% + 100
SOUND x%, 1
LOOP