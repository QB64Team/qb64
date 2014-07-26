'MANDELBROT by Antoni Gual 2003  
'for Rel's 9 LINER contest at QBASICNEWS.COM  1/2003
'------------------------------------------------------------------------

'DECLARE SUB ffix
'ffix
1 IF x& = 0 THEN SCREEN 13 ELSE iter% = 0
2 x& = (x& + 123) MOD 64000
3 im2 = im * im
4 IF iter% THEN im = 2 * re * im + (CSNG(x& \ 320) / 100 - 1) ELSE im = 0
5 IF iter% THEN re = re * re - im2 + (CSNG(x& MOD 320) / 120 - 1.9) ELSE re = 0
6 iter% = iter% + 1
7 IF ABS(re) + ABS(im) > 2 OR iter% > 254 THEN PSET (x& MOD 320, x& \ 320), iter% ELSE GOTO 3
8 IF LEN(INKEY$) = 0 THEN GOTO 1

