'Starfield by Antoni gual
'for Rel's 9 LINER contest at QBASICNEWS.COM  1/2003
'------------------------------------------------------------------------

1 SCREEN 13
2 a$ = STRING$(400 * 6, CHR$(0))
3 IF CVI(MID$(a$, j + 5, 2)) = 0 THEN MID$(a$, j + 1, 6) = MKI$(RND * 20000 - 10000) + MKI$(RND * 20000 - 10000) + MKI$(100 * RND + 1)
4 PSET (160 + CVI(MID$(a$, j + 1, 2)) / CVI(MID$(a$, j + 5, 2)), 100 + CVI(MID$(a$, j + 3, 2)) / CVI(MID$(a$, j + 5, 2))), 0
5 MID$(a$, j + 5, 2) = MKI$(CVI(MID$(a$, j + 5, 2)) - 1)
6 IF CVI(MID$(a$, j + 5, 2)) > 0 THEN PSET (160 + CVI(MID$(a$, j + 1, 2)) / CVI(MID$(a$, j + 5, 2)), 100 + CVI(MID$(a$, j + 3, 2)) / CVI(MID$(a$, j + 5, 2))), 32 - CVI(MID$(a$, j + 5, 2)) \ 8
7 j = (j + 6) MOD (LEN(a$))
8 IF LEN(INKEY$) = 0 THEN 3

