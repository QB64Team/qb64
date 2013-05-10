'                ****  *****   *   ***** ****   ***  *   * *   *
'                *   * *      * *    *   *   * *   * *   * **  *
'                *   * *      * *    *   *   * *   * *   * **  *
'                ****  ****  *****   *   *   * *   * * * * * * *
'                *   * *     *   *   *   *   * *   * * * * * * *
'                *   * *     *   *   *   *   * *   * * * * *  **
'                ****  ***** *   *   *   ****   ***  ***** *  **
'                                   Beat Down
'                                1998 MicroTrip
'                        V1.1 Origanally availible on
'                                   12-14-98
'
'                              Visit our Web Site At
'                                      At
'       http://www.geocities.com/SiliconValley/Platform/8409/qbasic.html
'                    E-Mail me at       microtrip@geocities.com
'                            ***Hit `F5' to play!!***





title:
'Beat Down Title Screen
'By Brian Murphy of MicroTrip

SCREEN 8
CLS
LINE (50, 50)-(50, 100), 14
LINE (50, 50)-(70, 50), 14
LINE (50, 100)-(70, 100), 14
LINE (70, 50)-(80, 55), 14
LINE (70, 100)-(80, 95), 14
LINE (80, 55)-(80, 70), 14
LINE (80, 95)-(80, 80), 14
LINE (80, 70)-(75, 75), 14
LINE (80, 80)-(75, 75), 14
LINE (75, 75)-(50, 75), 14

'**************E*************
LINE (90, 50)-(90, 100), 14
LINE (90, 50)-(120, 50), 14
LINE (90, 75)-(110, 75), 14
LINE (90, 100)-(120, 100), 14

'**************A*************
LINE (145, 50)-(130, 100), 14
LINE (145, 50)-(160, 100), 14
LINE (137.5, 75)-(152.5, 75), 14

'*************T**************
LINE (170, 50)-(200, 50), 14
LINE (185, 50)-(185, 100), 14

'***************D************
LINE (260, 50)-(260, 100), 14
LINE (260, 50)-(280, 50), 14
LINE (260, 100)-(280, 100), 14
LINE (280, 50)-(290, 55), 14
LINE (280, 100)-(290, 95), 14
LINE (290, 55)-(290, 95), 14

'***************O************
LINE (300, 55)-(300, 95), 14
LINE (300, 55)-(310, 50), 14
LINE (300, 95)-(310, 100), 14
LINE (330, 55)-(330, 95), 14
LINE (320, 50)-(330, 55), 14
LINE (320, 100)-(330, 95), 14
LINE (320, 100)-(310, 100), 14
LINE (310, 50)-(320, 50), 14

'**************W*************
LINE (340, 50)-(340, 100), 14
LINE (370, 50)-(370, 100), 14
LINE (340, 100)-(355, 75), 14
LINE (370, 100)-(355, 75), 14

'**************N*************
LINE (380, 50)-(380, 100), 14
LINE (410, 50)-(410, 100), 14
LINE (380, 50)-(410, 100), 14

'************************All done


COLOR 14
LOCATE 24, 32: PRINT "Beat Down V1.1"


FOR i = 1 TO 2
 FOR x = 550 TO 37 STEP -5
 SOUND x + 5, .2
  a$ = INKEY$: IF a$ <> "" THEN LET d = 1: EXIT FOR
 NEXT x
  IF d = 1 THEN EXIT FOR
 FOR x = 37 TO 550 STEP 5
 SOUND x + 5, .2
  a$ = INKEY$: IF a$ <> "" THEN LET d = 1: EXIT FOR
 NEXT x
  IF d = 1 THEN EXIT FOR
NEXT i
  IF d = 1 THEN GOTO you

'/Title


GOSUB intro
   IF nn = 0 GOTO you
   IF nn = 1 GOTO title

you:
'Main Menu
snd$ = "on"
speed$ = "normal"
num = 9
oldnum = 9
colour1 = 1
colour2 = 1
mainmenu:
COLOR 14
CLS
LINE (50, 45)-(550, 150), 14, B
LOCATE 5, 33: PRINT "Main Menu"
LINE (60, 55)-(540, 140), 14, B
PAINT (51, 46), 10, 14
LOCATE 9, 15: PRINT "Start Game"
LOCATE 10, 15: PRINT "Veiw Controls"
LOCATE 11, 15: PRINT "Speed"
LOCATE 12, 15: PRINT "Sound"
LOCATE 13, 15: PRINT "Credits"
LOCATE 14, 15: PRINT "Color of player 1"
LOCATE 15, 15: PRINT "Color of player 2"
LOCATE 16, 15: PRINT "Quit"

LISTEN$ = "mb T180 o2 P2 P8 L8 GGG L2 E-"
FATE$ = "mb P24 P8 L8 FFF L2 D"
PLAY LISTEN$ + FATE$

mm2:
   LOCATE 11, 21: PRINT "         ": LOCATE 11, 21: PRINT speed$
   LOCATE 12, 21: PRINT "      ": LOCATE 12, 21: PRINT snd$; ""
   LOCATE 14, 33: PRINT "      ": LOCATE 14, 33: COLOR colour1: PRINT colour1
   LOCATE 15, 33: PRINT "       ": LOCATE 15, 33: COLOR colour2: PRINT colour2
   COLOR 14
   IF oldnum <> num THEN LOCATE 14, 13: PRINT " ": LOCATE 9, 13: PRINT " ": LOCATE 10, 13: PRINT " ": LOCATE 11, 13: PRINT " ": LOCATE 12, 13: PRINT " ": LOCATE 13, 13: PRINT " ": LOCATE 15, 13: PRINT " ": LOCATE 16, 13: PRINT " ": oldnum = num
   LOCATE num, 13: PRINT "o"
     DO
      a$ = INKEY$
     LOOP UNTIL a$ <> ""
     IF a$ = "" THEN GOTO mm2
    IF a$ = "8" AND num = 9 THEN num = 16: GOTO mm2
    IF a$ = "8" THEN num = num - 1: GOTO mm2
    IF a$ = "2" AND num = 16 THEN num = 9: GOTO mm2
    IF a$ = "2" THEN num = num + 1: GOTO mm2
    IF a$ = "5" AND num = 9 THEN GOTO start
    IF a$ = "4" AND num = 12 THEN
     IF snd$ = "on" THEN snd$ = "off": GOTO mm2
     IF snd$ = "off" THEN snd$ = "on": GOTO mm2
     END IF
    IF a$ = "6" AND num = 12 THEN
     IF snd$ = "on" THEN snd$ = "off": GOTO mm2
     IF snd$ = "off" THEN snd$ = "on": GOTO mm2
    END IF
    IF a$ = "4" AND num = 11 THEN
     IF speed$ = "fastest" THEN speed$ = "mid-fast": GOTO mm2
     IF speed$ = "mid-fast" THEN speed$ = "normal": GOTO mm2
     IF speed$ = "normal" THEN speed$ = "mid-slow": GOTO mm2
     IF speed$ = "mid-slow" THEN speed$ = "slow": GOTO mm2
     IF speed$ = "slow" THEN speed$ = "fastest": GOTO mm2
    END IF
    IF a$ = "6" AND num = 11 THEN
     IF speed$ = "fastest" THEN speed$ = "slow": GOTO mm2
     IF speed$ = "mid-fast" THEN speed$ = "fastest": GOTO mm2
     IF speed$ = "normal" THEN speed$ = "mid-fast": GOTO mm2
     IF speed$ = "mid-slow" THEN speed$ = "normal": GOTO mm2
     IF speed$ = "slow" THEN speed$ = "mid-slow": GOTO mm2
    END IF
    IF a$ = "6" AND num = 14 THEN
     IF colour1 = 15 THEN colour1 = 0: GOTO mm2
     IF colour1 = 10 THEN colour1 = 12: GOTO mm2
     colour1 = colour1 + 1
    END IF
    IF a$ = "4" AND num = 14 THEN
     IF colour1 = 0 THEN colour1 = 15: GOTO mm2
     IF colour1 = 12 THEN colour1 = 10: GOTO mm2
     colour1 = colour1 - 1
    END IF
    IF a$ = "6" AND num = 15 THEN
     IF colour2 = 15 THEN colour2 = 0: GOTO mm2
     IF colour2 = 10 THEN colour2 = 12: GOTO mm2
     colour2 = colour2 + 1
    END IF
    IF a$ = "4" AND num = 15 THEN
     IF colour2 = 0 THEN colour2 = 15: GOTO mm2
     IF colour2 = 12 THEN colour2 = 10: GOTO mm2
     colour2 = colour2 - 1
    END IF
    IF a$ = "5" AND num = 13 THEN GOTO credits
    IF a$ = "5" AND num = 10 THEN GOTO controls
    IF a$ = "5" AND num = 16 THEN GOTO 666
   GOTO mm2

'***********Credits**************
credits:
CLS
PRINT "Graphics Director...........Jacob Suckow"
PRINT "  Title Screen Picture......Brian Murphy"
PRINT "  Main Menu.................Brian Murphy"
PRINT "  Fighting Section..........Brian Murphy"
PRINT "  Ending (Circle)...........Brian Murphy"
PRINT "Programming Director........Brian Murphy"
PRINT "  Engine....................Brian Murphy"
PRINT "  Menu System...............Brian Murphy"
PRINT "  Other.....................Brian Murphy"
PRINT "Sound Director..............Jeremy Suckow"
PRINT "  Title Screen..............Brian Murphy"
PRINT "  MicroTrip Screen..........Brian Murphy"
PRINT "  Fighting..................Brian Murphy"
PRINT
PRINT "             1998  MicroTrip"
PRINT "          Any key to continue..."
WHILE INKEY$ = "": WEND
GOTO mainmenu
'***********/Credits*************

'***********Controls*************
controls:
CLS
PRINT "Player One"
PRINT "Move left.....a"
PRINT "Move right....s"
PRINT "Punch.........q"
PRINT "High Punch....z"
PRINT "Kick..........w"
PRINT "Low Kick.....x"
PRINT
PRINT "Player Two"
PRINT "Move Left.....4"
PRINT "Move Right....6"
PRINT "Punch.........8"
PRINT "High Punch..../"
PRINT "Kick..........2"
PRINT "Low Kick......0"
PRINT
PRINT "To quit.....Esc"
PRINT
PRINT "Any key to continue..."
WHILE INKEY$ = "": WEND
GOTO mainmenu
'************/Controls*************

start:
IF speed$ = "slow" THEN speed = 100000
IF speed$ = "mid-slow" THEN speed = 50000
IF speed$ = "normal" THEN speed = 25000
IF speed$ = "mid-fast" THEN speed = 10000
IF speed$ = "fastest" THEN speed = 1000

IF snd$ = "on" THEN snd = 1
IF snd$ = "off" THEN snd = 0

CLS
SCREEN 8

LET a = 50
LET B = 50
LET c = 20
LET d = c
LET e = 600
LET f = e

COLOR 15

'********Ground********
LINE (0, 151)-(640, 161), 2, BF
LINE (0, 161)-(640, 171), 10, BF
LINE (0, 171)-(640, 200), 6, BF
'********/Ground*******

'********Top Thing*****
LINE (0, 0)-(640, 20), 13, B
PAINT (2, 2), 13, 13
'********/Top Thing****
'********Background****
LINE (0, 150)-(640, 21), 11, BF
'********/BackGround***

1
10 IF a <= 0 THEN GOTO 600
20 IF B <= 0 THEN GOTO 610

30 LINE (c, 110)-(c, 130), colour1                   'body
   LINE (c, 130)-(c - 20, 150), colour1              'leg
   LINE (c, 130)-(c + 20, 150), colour1              'other leg
   IF c < e THEN LINE (c, 120)-(c + 15, 110), colour1'arm
   IF c > e THEN LINE (c, 120)-(c - 15, 110), colour1'arm other
   CIRCLE (c, 105), 10, colour1                      'head
60 LINE (e, 110)-(e, 130), colour2
   LINE (e, 130)-(e - 20, 150), colour2
   LINE (e, 130)-(e + 20, 150), colour2
   IF e > c THEN LINE (e, 120)-(e - 15, 110), colour2
   IF e < c THEN LINE (e, 120)-(e + 15, 110), colour2
   CIRCLE (e, 105), 10, colour2

90 LINE (5, 4)-((a * 5) + 5, 10), 14, BF           'Life Bar
   IF a <> 50 THEN LINE ((a * 5) + 1 + 5, 4)-(255, 10), 4, BF
   LINE (4, 3)-((a * 5) + 6, 11), 14, B

   LINE (390, 4)-((B * 5) + 390, 10), 14, BF         'Life Bar P2
   LINE ((B * 5) + 390 + 1, 4)-(640, 10), 4, BF
   LINE (389, 3)-((B * 5) + 390 + 1, 11), 14, B

130 a$ = INKEY$
140 IF a$ = "" THEN GOTO 1
150 IF a$ = "q" THEN GOTO 200 'punch 1
155 IF a$ = "z" THEN GOTO highpunch1
160 IF a$ = "w" THEN GOTO 210 'kick 1
165 IF a$ = "x" THEN GOTO highkick1
170 IF a$ = "a" THEN GOTO 220 'left 1
175 IF a$ = "s" THEN GOTO 270 'right 1
180 IF a$ = "4" THEN GOTO 230 'left 2
185 IF a$ = "6" THEN GOTO 240 'right 2
190 IF a$ = "8" THEN GOTO 250 'punch 2
    IF a$ = "/" THEN GOTO highpunch2
195 IF a$ = "2" THEN GOTO 260 'kick 2
    IF a$ = "0" THEN GOTO highkick2
196 IF a$ = CHR$(27) THEN GOTO 616
197 GOTO 1

200 IF c > e THEN GOTO 205
    LINE (c, 120)-(c + 15, 110), 11
    LINE (c, 120)-(c + 30, 120), colour1
    FOR i = 1 TO speed
    NEXT i
    LINE (c, 120)-(c + 15, 110), colour1
    LINE (c, 120)-(c + 30, 120), 11
    GOTO 209
205 LINE (c, 120)-(c - 30, 120), colour1
    LINE (c, 120)-(c - 15, 110), 11
    FOR i = 1 TO speed
    NEXT i
    LINE (c, 120)-(c - 15, 110), colour1
    LINE (c, 120)-(c - 30, 120), 11
    GOTO 209
209 IF c + 29 = e OR c - 29 = e OR c + 30 = e OR c - 30 = e THEN
       B = B - 2
       IF snd = 1 THEN SOUND 50, 1
      END IF
    IF c + 24 = e OR c - 24 = e OR c + 25 = e OR c - 25 = e THEN
       B = B - 3
       IF snd = 1 THEN SOUND 50, 1
      END IF
    IF c + 19 = e OR c - 19 = e OR c + 20 = e OR c - 20 = e THEN
       B = B - 1
       IF snd = 1 THEN SOUND 50, 1
      END IF
    GOTO 1



highkick1:
    IF c > e THEN GOTO hk1
    LINE (c, 130)-(c + 20, 150), 11
    LINE (c, 130)-(c + 30, 140), colour1
    FOR i = 1 TO speed
    NEXT i
    LINE (c, 130)-(c + 20, 150), colour1
    LINE (c, 130)-(c + 30, 140), 11
 GOTO hk1x
hk1:
    LINE (c, 130)-(c - 20, 150), 11
    LINE (c, 130)-(c - 30, 140), colour1
    FOR i = 1 TO speed
    NEXT i
    LINE (c, 130)-(c - 20, 150), colour1
    LINE (c, 130)-(c - 30, 140), 11
 GOTO hk1x
hk1x:
    IF c + 29 = e OR c - 29 = e OR c + 30 = e OR c - 30 = e THEN
       B = B - 2
       IF snd = 1 THEN SOUND 50, 1
      END IF
    IF c + 24 = e OR c - 24 = e OR c + 25 = e OR c - 25 = e THEN
       B = B - 3
       IF snd = 1 THEN SOUND 50, 1
      END IF
    IF c + 19 = e OR c - 19 = e OR c + 20 = e OR c - 20 = e THEN
       B = B - 1
       IF snd = 1 THEN SOUND 50, 1
      END IF
    GOTO 1


highpunch1:
    IF c > e THEN GOTO hp1
    LINE (c, 120)-(c + 15, 110), 11
    LINE (c, 120)-(c + 30, 110), colour1
    FOR i = 1 TO speed
    NEXT i
    LINE (c, 120)-(c + 15, 110), colour1
    LINE (c, 120)-(c + 30, 110), 11
 GOTO hp1x
hp1:
    LINE (c, 120)-(c - 15, 110), 11
    LINE (c, 120)-(c - 30, 110), colour1
    FOR i = 1 TO speed
    NEXT i
    LINE (c, 120)-(c - 15, 110), colour1
    LINE (c, 120)-(c - 30, 110), 11
 GOTO hp1x
hp1x:
    IF c + 29 = e OR c - 29 = e OR c + 30 = e OR c - 30 = e THEN
       B = B - 2
       IF snd = 1 THEN SOUND 50, 1
      END IF
    IF c + 24 = e OR c - 24 = e OR c + 25 = e OR c - 25 = e THEN
       B = B - 3
       IF snd = 1 THEN SOUND 50, 1
      END IF
    IF c + 19 = e OR c - 19 = e OR c + 20 = e OR c - 20 = e THEN
       B = B - 1
       IF snd = 1 THEN SOUND 50, 1
      END IF
    GOTO 1


210 IF c > e THEN GOTO 215
    LINE (c, 130)-(c + 20, 150), 11
    LINE (c, 130)-(c + 30, 130), colour1
    FOR i = 1 TO speed
    NEXT i
    LINE (c, 130)-(c + 20, 150), colour1
    LINE (c, 130)-(c + 30, 130), 11
    GOTO 219
215 LINE (c, 130)-(c - 20, 150), 11
    LINE (c, 130)-(c - 30, 130), colour1
    FOR i = 1 TO speed
    NEXT i
    LINE (c, 130)-(c - 20, 150), colour1
    LINE (c, 130)-(c - 30, 130), 11
    GOTO 219
219 IF c + 29 = e OR c - 29 = e OR c + 30 = e OR c - 30 = e THEN
      B = B - 2
      IF snd = 1 THEN SOUND 50, 1
     END IF
    IF c + 24 = e OR c - 24 = e OR c + 25 = e OR c - 25 = e THEN
      B = B - 3
      IF snd = 1 THEN SOUND 50, 1
    END IF
    IF c + 19 = e OR c - 19 = e OR c + 20 = e OR c - 20 = e THEN
      B = B - 1
      IF snd = 1 THEN SOUND 50, 1
     END IF
    GOTO 1

220 IF c < 6 THEN GOTO 1
221 c = c - 5
222 LINE (d, 110)-(d, 130), 11
    LINE (d, 130)-(d - 20, 150), 11
    LINE (d, 130)-(d + 20, 150), 11
223 LINE (d, 120)-(d - 15, 110), 11
    LINE (d, 120)-(d + 15, 110), 11
224 CIRCLE (d, 105), 10, 11
225 d = c
226 GOTO 1

270 IF c > 595 THEN GOTO 1
271 c = c + 5
272 LINE (d, 110)-(d, 130), 11
    LINE (d, 130)-(d - 20, 150), 11
    LINE (d, 130)-(d + 20, 150), 11
273 CIRCLE (d, 105), 10, 11
274 LINE (d, 120)-(d - 15, 110), 11
    LINE (d, 120)-(d + 15, 110), 11
275 d = c
276 GOTO 1

230 IF e < 5 THEN GOTO 1
231 e = e - 5
232 LINE (f, 110)-(f, 130), 11
    LINE (f, 130)-(f - 20, 150), 11
    LINE (f, 130)-(f + 20, 150), 11
233 CIRCLE (f, 105), 10, 11
234 LINE (f, 120)-(f - 15, 110), 11
    LINE (f, 120)-(f + 15, 110), 11
235 f = e
236 GOTO 1

240 IF e > 595 THEN GOTO 1
241 e = e + 5
242 LINE (f, 110)-(f, 130), 11
    LINE (f, 130)-(f - 20, 150), 11
    LINE (f, 130)-(f + 20, 150), 11
243 CIRCLE (f, 105), 10, 11
244 LINE (f, 120)-(f - 15, 110), 11
    LINE (f, 120)-(f + 15, 110), 11
245 f = e
246 GOTO 1

250 IF c < e THEN GOTO 255
    LINE (e, 120)-(e + 15, 110), 11
    LINE (e, 120)-(e + 30, 120), colour2
    FOR i = 1 TO speed
    NEXT i
    LINE (e, 120)-(e + 15, 110), colour2
    LINE (e, 120)-(e + 30, 120), 11
    GOTO 259
255 LINE (e, 120)-(e - 30, 120), colour2
    LINE (e, 120)-(e - 15, 110), 11
    FOR i = 1 TO speed
    NEXT i
    LINE (e, 120)-(e - 30, 120), colour2
    LINE (e, 120)-(e - 30, 120), 11
    GOTO 259
259 IF c + 29 = e OR c - 29 = e OR c + 30 = e OR c - 30 = e THEN
       a = a - 2
       IF snd = 1 THEN SOUND 50, 1
      END IF
    IF c + 24 = e OR c - 24 = e OR c + 25 = e OR c - 25 = e THEN
       a = a - 3
       IF snd = 1 THEN SOUND 50, 1
      END IF
    IF c + 19 = e OR c - 19 = e OR c + 20 = e OR c - 25 = e THEN
       a = a - 1
       IF snd = 1 THEN SOUND 50, 1
      END IF
    GOTO 1

260 IF c < e THEN GOTO 265
    LINE (e, 130)-(e + 20, 150), 11
    LINE (e, 130)-(e + 30, 130), colour2
    FOR i = 1 TO speed
    NEXT i
    LINE (e, 130)-(e + 20, 150), colour2
    LINE (e, 130)-(e + 30, 130), 11
    GOTO 269
265 LINE (e, 130)-(e - 20, 150), 11
    LINE (e, 130)-(e - 30, 130), colour2
    FOR i = 1 TO speed
    NEXT i
    LINE (e, 130)-(e - 20, 150), colour2
    LINE (e, 130)-(e - 30, 130), 11
    GOTO 269
269 IF c + 29 = e OR c - 29 = e OR c + 30 = e OR c - 30 = e THEN
      a = a - 2
      IF snd = 1 THEN SOUND 50, 1
     END IF
    IF c + 24 = e OR c - 24 = e OR c + 25 = e OR c - 25 = e THEN
      a = a - 3
      IF snd = 1 THEN SOUND 50, 1
     END IF
    IF c + 19 = e OR c - 19 = e OR c + 20 = e OR c - 20 = e THEN
       a = a - 1
       IF snd = 1 THEN SOUND 50, 1
      END IF
    GOTO 1


highkick2:
    IF c < e THEN GOTO hk2
    LINE (e, 130)-(e + 20, 150), 11
    LINE (e, 130)-(e + 30, 140), colour2
    FOR i = 1 TO speed
    NEXT i
    LINE (e, 130)-(e + 20, 150), colour2
    LINE (e, 130)-(e + 30, 140), 11
 GOTO hk2x
hk2:
    LINE (e, 130)-(e - 20, 150), 11
    LINE (e, 130)-(e - 30, 140), colour2
    FOR i = 1 TO speed
    NEXT i
    LINE (e, 130)-(e - 20, 150), colour1
    LINE (e, 130)-(e - 30, 140), 11
 GOTO hk2x
hk2x:
    IF e + 29 = c OR e - 29 = c OR e + 30 = c OR e - 30 = c THEN
       a = a - 2
       IF snd = 1 THEN SOUND 50, 1
      END IF
    IF e + 24 = c OR e - 24 = c OR e + 25 = c OR e - 25 = c THEN
       a = a - 3
       IF snd = 1 THEN SOUND 50, 1
      END IF
    IF e + 19 = c OR e - 19 = c OR e + 20 = c OR e - 20 = c THEN
       a = a - 1
       IF snd = 1 THEN SOUND 50, 1
      END IF
    GOTO 1


highpunch2:
    IF c < e THEN GOTO hp2
    LINE (e, 120)-(e + 15, 110), 11
    LINE (e, 120)-(e + 30, 110), colour1
    FOR i = 1 TO speed
    NEXT i
    LINE (e, 120)-(e + 15, 110), colour1
    LINE (e, 120)-(e + 30, 110), 11
 GOTO hp2x
hp2:
    LINE (e, 120)-(e - 15, 110), 11
    LINE (e, 120)-(e - 30, 110), colour1
    FOR i = 1 TO speed
    NEXT i
    LINE (e, 120)-(e - 15, 110), colour1
    LINE (e, 120)-(e - 30, 110), 11
 GOTO hp2x
hp2x:
    IF e + 29 = c OR e - 29 = c OR e + 30 = c OR e - 30 = c THEN
       a = a - 2
       IF snd = 1 THEN SOUND 50, 1
      END IF
    IF e + 24 = c OR e - 24 = c OR e + 25 = c OR e - 25 = c THEN
       a = a - 3
       IF snd = 1 THEN SOUND 50, 1
      END IF
    IF e + 19 = c OR e - 19 = c OR e + 20 = c OR e - 20 = c THEN
       a = a - 1
       IF snd = 1 THEN SOUND 50, 1
      END IF
    GOTO 1
   


600 FOR iii = 1 TO 8000
    LOCATE 12, 32: PRINT "Player 1 Losses!"
    NEXT iii
    FOR ii = 10 TO 1 STEP -1
    CIRCLE (c, 105), ii + 1, 11
    CIRCLE (c, 105), ii, colour1
    FOR i = 1 TO speed
    NEXT i
    NEXT ii
    GOTO 615
610 FOR iii = 1 TO 8000
    LOCATE 12, 32: PRINT "Player 2 Losses!"
    NEXT iii
    FOR ii = 10 TO 1 STEP -1
    CIRCLE (e, 105), ii + 1, 11
    CIRCLE (e, 105), ii, colour2
    FOR i = 1 TO speed
    NEXT i
    NEXT ii
    GOTO 615

615
  FOR i = 400 TO 1 STEP -1
  CIRCLE (320, 100), i
  PAINT (1, 1), 11
  CIRCLE (320, 100), i + 1, 11
  FOR ii = 1 TO speed / 10
  NEXT ii
  NEXT i

616 GOTO mainmenu

intro:
  
  'MicroTrip
   CLS
   SCREEN 8
   COLOR 15
   LOCATE 12, 35: PRINT "MicroTrip"
   LINE (260, 85)-(350, 97), 1, B
   PAINT (259, 84), 9, 1
     PLAY "mb L16 ed L4 e P64 L4 <a P4 > L16 fe L32 f P8 e P8 L4 d P4"
     PLAY "mb L16 ed L4 e P64 L4 <a P4 > L17 fe L32 f P8 e P8 L4 d P4"
    IF a$ <> "" THEN RETURN

   'Move Guy
    
   c = 5
   e = 1000
moveguy:
   LINE (c, 110)-(c, 130)                   'body
   LINE (c, 130)-(c - 20, 150)              'leg
   LINE (c, 130)-(c + 20, 150)              'other leg
   IF c < e THEN LINE (c, 120)-(c + 15, 110)'arm
   IF c > e THEN LINE (c, 120)-(c - 15, 110)'arm other
   CIRCLE (c, 105), 10                      'head
   FOR i = 1 TO 9000
   NEXT i
   LINE (c, 110)-(c, 130), 9                  'body
   LINE (c, 130)-(c - 20, 150), 9             'leg
   LINE (c, 130)-(c + 20, 150), 9             'other leg
   IF c < e THEN LINE (c, 120)-(c + 15, 110), 9'arm
   IF c > e THEN LINE (c, 120)-(c - 15, 110), 9'arm other
   CIRCLE (c, 105), 10, 9                     'head
   c = c + 1
    a$ = INKEY$
    IF a$ <> "" THEN LET nn = 0: RETURN
   IF c >= 595 THEN LET nn = 1: RETURN
   GOTO moveguy

'****I have to fill this in later.  It won't work right.****
story:
    CLS
    fart = 0
    PAINT (1, 1), 0
    COLOR 4
    LOCATE 1, 1: PRINT "It was the year 1998 when you and Jake decided to start your"
    GOTO yeah
first:
    PRINT "own 'wrestling' association.  You were sick of how fake all of the "
    GOTO yeah
second:
    PRINT "others including WCW, WWF and NWO, were.  Then, simoultaniously, you both"
    GOTO yeah
third:
    PRINT "had a good idea.  What if your 'wrestling' association wasn't fake?  What"
    GOTO yeah
fourth:
    PRINT "if you had all of the 'wrestlers' sign a Beat Down contract saying that "
    GOTO yeah
fifth:
    PRINT "they would fight to the death?  This was gonna' be a kick @$$ 'fighting'"
    GOTO yeah
sixth:
    PRINT "association!  It would be known as the Beat Down Fighting Association!(BDFA)"
    GOTO yeah
    
endofstory:
    IF nn = 0 THEN RETURN
    LET nn = 1: RETURN

yeah:
    a$ = INKEY$
    IF a$ <> "" THEN nn = 0: GOTO endofstory
    FOR i = 1 TO 1000000
    NEXT i
    fart = fart + 1
    ON poop GOTO first, second, third, fourth, fifth, sixth

666

