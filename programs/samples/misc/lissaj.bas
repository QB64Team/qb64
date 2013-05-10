'Lissajous by Antoni Gual
'for Rel's 9 LINER contest at QBASICNEWS.COM  1/2003
'------------------------------------------------------------------------

1 IF k = 0 THEN SCREEN 12 ELSE CLS
2 i& = (i& + 1) AND &HFFFFF
3 k = 6.3 * RND
4 l = 6.3 * RND
5 n% = (n% + 1) MOD 15
6 FOR j& = 0 TO 100000
7 PSET (320 + 300 * SIN(.01 * SIN(k) + j&), 240 + 200 * SIN(.01 * SIN(l) * j&)), n% + 1
8 NEXT
9 IF LEN(INKEY$) = 0 THEN GOTO 1

