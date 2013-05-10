'Matrix by Antoni Gual    agual@eic.ictnet.es
'for Rel's 9 LINER contest at QBASICNEWS.COM  1/2003
'------------------------------------------------------------------------
1 DEF SEG = &HB800
2 FOR i% = 0 TO 159 STEP 4
'  adjust this speed constant for optimal effect
'             |    0 no speed ;) .05 should be too fast even for a 386
'             |
3  IF RND < .0005 THEN j% = 3840 ELSE j% = -1
4  IF j% > 0 THEN POKE j% + i%, PEEK(j% - 160 + i%)
5  IF j% > 0 THEN j% = j% - 160
6  IF j% > 0 THEN GOTO 4
7  IF j% = 0 THEN IF RND > .3 THEN POKE i%, 96 * RND + 32 ELSE POKE i%, 32
8 NEXT
9 IF LEN(INKEY$) = 0 THEN GOTO 2

