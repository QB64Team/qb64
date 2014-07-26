'patterns
'for Rel's 9 LINER contest at QBASICNEWS.COM  1/2003
'------------------------------------------------------------------------
1 SCREEN 13
2 t% = RND * 345
3 WAIT &H3DA, 8
4 FOR i% = 0 TO 199
5 FOR j% = 0 TO 319
6 k% = ((k% + t% XOR j% XOR i%)) AND &HFF
7 PSET (j%, i%), k%
8 NEXT j%, i%
9 IF LEN(INKEY$) THEN END ELSE GOTO 2

