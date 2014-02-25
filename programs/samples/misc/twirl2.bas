'Twirl by Antoni Gual, from an idea  by Steve Nunnaly
'for Rel's 9 LINER contest at QBASICNEWS.COM  1/2003
'------------------------------------------------------------------------

1 IF i THEN CIRCLE (160, 100), i, (i MOD 16) + 32, , , .8 ELSE SCREEN 13
2 i = i + 1
3 IF i < 200 THEN GOTO 1 ELSE DIM b2%(5000)
4 w = (w + .3)
5 xmid = 140 + SIN(7 * w / 1000) * 110
6 ymid = 80 + SIN(11 * w / 1000) * 59
7 GET ((xmid - (SIN(w) * 28)), (ymid - (COS(w) * 20)))-((xmid - (SIN(w) * 28)) + 40, (ymid - (COS(w) * 20)) + 40), b2%
8 PUT ((xmid - (SIN(w - .04) * 27.16)), (ymid - (COS(w - .04) * 19.4))), b2%, PSET
9 IF LEN(INKEY$) = 0 THEN GOTO 4


