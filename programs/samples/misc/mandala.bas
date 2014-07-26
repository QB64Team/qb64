'Mandala by Antoni gual
'for Rel's 9 LINER contest at QBASICNEWS.COM  1/2003
'------------------------------------------------------------------------

1 SCREEN 12
2  v% = RND * 20 + 10
3 REDIM VX%(v%), VY%(v%)
4 FOR d1% = -1 TO v%
5 FOR d2% = d1% + 1 TO v%
6  IF d1% = -1 THEN VX%(d2%) = 320 + (SIN(6.283185 * (d2% / v%)) * 239) ELSE LINE (VX%(d1%), VY%(d1%))-(VX%(d2%), VY%(d2%)), (v% MOD 16) + 1
7  IF d1% = -1 THEN VY%(d2%) = 240 + (COS(6.283185 * (d2% / v%)) * 239)
8 NEXT d2%, d1%
9 IF LEN(INKEY$) = 0 THEN GOTO 2

