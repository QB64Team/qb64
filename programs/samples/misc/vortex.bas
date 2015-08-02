' Vortex  Antoni Gual 2003
' for Rel's 9 liners contest at QBASICNEWS.COM
'------------------------------------------------------------------------
1 SCREEN 13
2 PALETTE LEN(a$) / 3, 0
3 a$ = a$ + CHR$(32 - 31 * SIN((LEN(a$) - 60 * ((LEN(a$) MOD 3) = 2) + 60 * ((LEN(a$) MOD 3) = 1)) * 3.14151693# / 128))
4 CIRCLE (160, 290 - LEN(a$) ^ .8), LEN(a$) / 2.8, LEN(a$) \ 3, , , .5
5 CIRCLE (160, 290 - LEN(a$) ^ .8 + 1), LEN(a$) / 2.8, LEN(a$) \ 3, , , .5
6 IF LEN(a$) < 256 * 3 THEN 2 ELSE OUT &H3C8, 0
7 J = (J + 1) MOD (LEN(a$) - 3)
8 OUT &H3C9, ASC(MID$(a$, J + 1, 1))
9 IF LEN(INKEY$) = 0 THEN 7

