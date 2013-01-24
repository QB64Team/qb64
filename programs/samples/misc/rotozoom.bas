' OPTIMIZED  :) rotozoomer in 9 lines by Antoni Gual
'for Rel's 9 LINER contest at QBASICNEWS.COM  1/2003
'------------------------------------------------------------------------

1 SCREEN 13
2 ANG = ANG + .08
3 CS% = COS(ANG) * ABS(SIN(ANG)) * 128
4 ss% = SIN(ANG) * ABS(SIN(ANG)) * 128
5 FOR Y% = -100 TO 99
6 FOR X% = -160 TO 159
7 PSET (X% + 160, Y% + 100), (((X% * CS% - Y% * ss%) AND (Y% * CS% + X% * ss%)) \ 128)
8 NEXT X%, Y%
9 IF LEN(INKEY$) = 0 THEN 2

