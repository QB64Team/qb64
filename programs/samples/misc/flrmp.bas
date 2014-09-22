'Floormaper by Antoni Gual
'for Rel's 9 LINER contest at QBASICNEWS.COM  1/2003
'------------------------------------------------------------------------
1 SCREEN 13
2 r% = (r% + 1) AND 15
3 FOR y% = 1 TO 99
4   y1% = ((1190 / y% + r%) AND 15)
5   y2 = 6 / y%
6   FOR x% = 0 TO 319
7    PSET (x%, y% + 100), CINT((159 - x%) * y2) AND 15 XOR y1% + 16
8 NEXT x%, y%
9 IF LEN(INKEY$) = 0 THEN 2

