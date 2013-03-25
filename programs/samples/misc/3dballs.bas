'balls by Antoni Gual    agual@eic.ictnet.es
'for Rel's 9 LINER contest at QBASICNEWS.COM  1/2003
'------------------------------------------------------------------------
1 IF p% >= 16 THEN 3 ELSE IF p% = 0 THEN SCREEN 12 ELSE PALETTE p% - 1, b&
2 READ p%, b&
3 IF p% < 16 THEN GOTO 9 ELSE a$ = MKI$(RND * 640 + 1) + MKI$(RND * 480) + MKS$((RND * 60) + 20) + MKI$(INT(RND * 4) * 4) + MKS$(RND * 3.141592) + MKS$(RND * 3.141592 / 1.5)
4 FOR i% = -INT(CVS(MID$(a$, 5))) TO INT(CVS(MID$(a$, 5)))
    5 FOR j% = -INT(SQR(CVS(MID$(a$, 5)) ^ 2 - i% ^ 2)) TO INT(SQR(CVS(MID$(a$, 5)) ^ 2 - i% ^ 2))
6   c! = 3 * (COS(CVS(MID$(a$, 11))) * SIN(CVS(MID$(a$, 15))) * i% / CVS(MID$(a$, 5)) + SIN(CVS(MID$(a$, 11))) * SIN(CVS(MID$(a$, 15))) * j% / CVS(MID$(a$, 5)) + COS(CVS(MID$(a$, 15))) * SQR(1.11 - (i% / CVS(MID$(a$, 5))) ^ 2 - (j% / CVS(MID$(a$, 5) _
)) ^ 2))
        7 PSET (CVI(MID$(a$, 1)) + i%, CVI(MID$(a$, 3)) + j%), 1 + CVI(MID$(a$, 9)) + INT(c!) + (RND > (c! - INT(c!)))
8 NEXT j%, i%
9 IF LEN(INKEY$) = 0 THEN GOTO 1 ELSE DATA 1,&h5,2,&h10,3,&h20,4,&h30,5,&h500,6,&h1000,7,&h2000,8,&h3000,9,&h50000,10,&h100000,11,&h200000,12,&h300000,13,&h50505,14,&h101010,15,&h202020,16,&h303030,17,0
 

