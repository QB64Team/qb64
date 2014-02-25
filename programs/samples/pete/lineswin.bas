'************************************************
'*
'*  This program simulates a swinging motion
'*
'*                              "04 PMG
'*

SCREEN 12

'    VIEW (10, 10)-(300, 180), , 1       '341
'    PRINT "A big graphics viewport";
'    cnt1 = cnt1 + 1
'    VIEW SCREEN (80, 80)-(200, 125), , 1
'    LOCATE 11, 11: PRINT "A small graphics viewport";

'SCREEN 12

x = 100
y = 0
radii = 10
cnt = 1
cnt2 = 0
delay = 10000000

WHILE cnt > 0
cnt2 = 0
x = 0
cnt = 0
WHILE cnt2 < 5010

cnt2 = cnt2 + 1

xw = 200 * SIN(2 * pi + cnt2 / 50)
yw = 200 * SIN(2 * pi + cnt2 / 50)

'PRINT "xw = ", xw
'WINDOW (0, 0)-(500 + xw, 400 + yw)

VIEW (100, 100)-(500, 450), , 1
LINE (200, 100)-(200, 100)

WHILE delcnt > 0
delcnt = delay - 1
WEND

CLS

LINE (200, 100)-(posx, posy), 1
CIRCLE (posx, posy), 20
LINE (200, 100)-(posx2, posy), 2
CIRCLE (posx2, posy), radii
LINE (200, 100)-(posx3, posy), 4
CIRCLE (posx3, posy), 40

posx = 200 + (50 - x / 100) * SIN(2 * pi + x / 50)
posx2 = 200 + (100 - x / 100) * SIN(2 * pi + x / 60)
posx3 = 200 + (50 - x / 100) * SIN(2 * pi + x / 70)
posy = 300 + 10 * SIN(2 * pi + x / 100)
radii = 10 + 10 * SIN(2 * pi + x / 100)

'PRINT "x = ", posx

x = x + 1
cnt = cnt + 1

WEND

WEND