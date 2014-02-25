'             +--+   +----    +    --+--  +--+    +-+   |   |  |   |
'             |   +  |       | |     |    |   +  +   +  |   |  ||  |
'             |   +  +      +   +    |    |   |  |   |  |   |  | | |
'             +--+   +---   +---+    |    |   |  |   |  | | |  | | |
'             |   +  |      |   |    |    |   |  |   |  | | |  |  ||
'             |   +  |      |   |    |    |   +  +   +  | | |  |  ||
'             +--+   +----  |   |    |    +--+    +-+   +-+-+  |   |
'                                    Beat Down
'                                  1998 MicroTrip
'                       Version T1.0 Origanally availible on
'                          
'                                   12-14-98
'                              Made in the U.S.A.
'                             Visit our Web Site At
'                                     At
'      http://www.geocities.com/SiliconValley/Platform/8409/qbasic.html
'                E-Mail me at       microtrip@geocities.com
'                         ***Hit `F5' to play!!***





DECLARE SUB title ()
title:
CALL title

COLOR 14
LOCATE 24, 32: PRINT "Beat Down V1T"


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

'MicroTrip's Title
 CLS
 FOR i = 1 TO 15
  COLOR i
  LOCATE 12, 35: PRINT "MicroTrip"
  FOR ii = 1 TO 100000
  NEXT ii
 NEXT i
'/MicroTrip's Title
   GOSUB intro
   IF nn = 0 GOTO you
   IF nn = 1 GOTO title

you:
'Main Menu
snd$ = "on"
speed$ = "normale"
num = 9
oldnum = 9
mainmenu:
COLOR 14
CLS
LINE (50, 45)-(550, 150), 14, B
LOCATE 5, 33: PRINT "Menu Principale"
LINE (60, 55)-(540, 140), 14, B
PAINT (51, 46), 10, 14
LOCATE 9, 15: PRINT "Comincia il gioco"
LOCATE 10, 15: PRINT "Veiw Controls"  '*******************
LOCATE 11, 15: PRINT "Vilocita"
LOCATE 12, 15: PRINT "Suani"
LOCATE 13, 15: PRINT "Crediti"
LOCATE 14, 15: PRINT "Esci"

LISTEN$ = "mb T180 o2 P2 P8 L8 GGG L2 E-"
FATE$ = "mb P24 P8 L8 FFF L2 D"
PLAY LISTEN$ + FATE$

mm2:
   LOCATE 11, 24: PRINT "               ": LOCATE 11, 24: PRINT speed$
   LOCATE 12, 21: PRINT "      ": LOCATE 12, 21: PRINT snd$; ""
   IF oldnum <> num THEN LOCATE 14, 13: PRINT " ": LOCATE 9, 13: PRINT " ": LOCATE 10, 13: PRINT " ": LOCATE 11, 13: PRINT " ": LOCATE 12, 13: PRINT " ": LOCATE 13, 13: PRINT " ": oldnum = num
   LOCATE num, 13: PRINT "o"
     DO
      a$ = INKEY$
     LOOP UNTIL a$ <> ""
     IF a$ = "" THEN GOTO mm2
    IF a$ = "8" AND num = 9 THEN num = 14: GOTO mm2
    IF a$ = "8" THEN num = num - 1: GOTO mm2
    IF a$ = "2" AND num = 14 THEN num = 9: GOTO mm2
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
     IF speed$ = "malto veloce" THEN speed$ = "veloce": GOTO mm2
     IF speed$ = "veloce" THEN speed$ = "normale": GOTO mm2
     IF speed$ = "normale" THEN speed$ = "molto lento": GOTO mm2
     IF speed$ = "molto lento" THEN speed$ = "lento": GOTO mm2
     IF speed$ = "lento" THEN speed$ = "malto veloce": GOTO mm2
    END IF
    IF a$ = "6" AND num = 11 THEN
     IF speed$ = "malto veloce" THEN speed$ = "malto lento": GOTO mm2
     IF speed$ = "veloce" THEN speed$ = "malto veloce": GOTO mm2
     IF speed$ = "normale" THEN speed$ = "veloce": GOTO mm2
     IF speed$ = "lento" THEN speed$ = "normale": GOTO mm2
     IF speed$ = "malto lento" THEN speed$ = "lento": GOTO mm2
    END IF
    IF a$ = "5" AND num = 13 THEN GOTO credits
    IF a$ = "5" AND num = 10 THEN GOTO controls
    IF a$ = "5" AND num = 14 THEN GOTO 666
   GOTO mm2

'***********Credits**************
credits:
CLS
PRINT "Direttore della grafica...........Jacob Suckow"
PRINT "  Titoli..........................Jacob Suckow"
PRINT "  Menu Principale.................Brian Murphy"
PRINT "  Sezione combattimento...........Brian Murphy"
PRINT "  Ending..........................Brian Murphy"
PRINT "Direttore della programmazione....Brian Murphy"
PRINT "  Motore..........................Brian Murphy"
PRINT "  Menu di systema.................Brian Murphy"
PRINT "  Altro...........................Brian Murphy"
PRINT "Direttore del suono...............Jeremy Suckow"
PRINT "  Immagine della schermata........Brian Murphy"
PRINT "  Combattere......................Brian Murphy"
PRINT "Traduzione"
PRINT "  Traduzione in italiano..........Marco Motenelli"
PRINT
PRINT "             1998  MicroTrip"
PRINT "         Premu un tasto percontinuare..."
WHILE INKEY$ = "": WEND
GOTO mainmenu
'***********/Credits*************

'***********Controls*************
controls:
CLS
PRINT "Giocatore 1"
PRINT "Sposta a Sinistra...........................................a"
PRINT "Sposta a Destra.............................................s"
PRINT "Pugno.......................................................q"
PRINT "Calcio......................................................w"
PRINT
PRINT "Giocatore 2"
PRINT "Sposta a Sinistra...........................................4"
PRINT "Sposta a Destra.............................................6"
PRINT "Pugno.......................................................8"
PRINT "Calcio......................................................2"
PRINT
PRINT "Premere Esc in ogni momento per uscire dal combattimeno.....Esc"
PRINT
PRINT "                  Premu un tasto percontinuare..."
WHILE INKEY$ = "": WEND
GOTO mainmenu
'************/Controls*************

start:
IF speed$ = "malto lento" THEN speed = 100000
IF speed$ = "lento" THEN speed = 50000
IF speed$ = "normale" THEN speed = 25000
IF speed$ = "veloce" THEN speed = 10000
IF speed$ = "malto veloce" THEN speed = 1000

IF snd$ = "on" THEN snd = 1
IF snd$ = "off" THEN snd = 0

CLS
SCREEN 8
DEFINT A-F
LET a = 20
LET B = 20
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

1
10 IF a <= 0 THEN GOTO 600
20 IF B <= 0 THEN GOTO 610

30 LINE (c, 110)-(c, 130)                   'body
   LINE (c, 130)-(c - 20, 150)              'leg
   LINE (c, 130)-(c + 20, 150)              'other leg
   IF c < e THEN LINE (c, 120)-(c + 15, 110)'arm
   IF c > e THEN LINE (c, 120)-(c - 15, 110)'arm other
   CIRCLE (c, 105), 10                      'head
60 LINE (e, 110)-(e, 130)
   LINE (e, 130)-(e - 20, 150)
   LINE (e, 130)-(e + 20, 150)
   IF e > c THEN LINE (e, 120)-(e - 15, 110)
   IF e < c THEN LINE (e, 120)-(e + 15, 110)
   CIRCLE (e, 105), 10

90 LINE (1, 1)-(a * 5, 7), 14, BF             'Life Bar
   LINE ((a * 5) + 1, 1)-(100, 7), 4, BF

   LINE (540, 1)-((B * 5) + 540, 7), 14, BF         'Life Bar P2
   LINE ((B * 5) + 540 + 1, 1)-(640, 7), 4, BF

130 a$ = INKEY$
140 IF a$ = "" THEN GOTO 1
150 IF a$ = "q" THEN GOTO 200 'punch 1
160 IF a$ = "w" THEN GOTO 210 'kick 1
170 IF a$ = "a" THEN GOTO 220 'left 1
175 IF a$ = "s" THEN GOTO 270 'right 1
180 IF a$ = "4" THEN GOTO 230 'left 2
185 IF a$ = "6" THEN GOTO 240 'right 2
190 IF a$ = "8" THEN GOTO 250 'punch 2
195 IF a$ = "2" THEN GOTO 260 'kick 2
196 IF a$ = CHR$(27) THEN GOTO 616
197 GOTO 1

200 IF c > e THEN GOTO 205
    LINE (c, 120)-(c + 15, 110), 0
    LINE (c, 120)-(c + 30, 120)
    FOR i = 1 TO speed
    NEXT i
    LINE (c, 120)-(c + 15, 110)
    LINE (c, 120)-(c + 30, 120), 0
    GOTO 209
205 LINE (c, 120)-(c - 30, 120)
    LINE (c, 120)-(c - 15, 110), 0
    FOR i = 1 TO speed
    NEXT i
    LINE (c, 120)-(c - 15, 110)
    LINE (c, 120)-(c - 30, 120), 0
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

210 IF c > e THEN GOTO 215
    LINE (c, 130)-(c + 20, 150), 0
    LINE (c, 130)-(c + 30, 130)
    FOR i = 1 TO speed
    NEXT i
    LINE (c, 130)-(c + 20, 150)
    LINE (c, 130)-(c + 30, 130), 0
    GOTO 219
215 LINE (c, 130)-(c - 20, 150), 0
    LINE (c, 130)-(c - 30, 130)
    FOR i = 1 TO speed
    NEXT i
    LINE (c, 130)-(c - 20, 150)
    LINE (c, 130)-(c - 30, 130), 0
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
222 LINE (d, 110)-(d, 130), 0
    LINE (d, 130)-(d - 20, 150), 0
    LINE (d, 130)-(d + 20, 150), 0
223 LINE (d, 120)-(d - 15, 110), 0
    LINE (d, 120)-(d + 15, 110), 0
224 CIRCLE (d, 105), 10, 0
225 d = c
226 GOTO 1

270 IF c > 595 THEN GOTO 1
271 c = c + 5
272 LINE (d, 110)-(d, 130), 0
    LINE (d, 130)-(d - 20, 150), 0
    LINE (d, 130)-(d + 20, 150), 0
273 CIRCLE (d, 105), 10, 0
274 LINE (d, 120)-(d - 15, 110), 0
    LINE (d, 120)-(d + 15, 110), 0
275 d = c
276 GOTO 1

230 IF e < 5 THEN GOTO 1
231 e = e - 5
232 LINE (f, 110)-(f, 130), 0
    LINE (f, 130)-(f - 20, 150), 0
    LINE (f, 130)-(f + 20, 150), 0
233 CIRCLE (f, 105), 10, 0
234 LINE (f, 120)-(f - 15, 110), 0
    LINE (f, 120)-(f + 15, 110), 0
235 f = e
236 GOTO 1

240 IF e > 595 THEN GOTO 1
241 e = e + 5
242 LINE (f, 110)-(f, 130), 0
    LINE (f, 130)-(f - 20, 150), 0
    LINE (f, 130)-(f + 20, 150), 0
243 CIRCLE (f, 105), 10, 0
244 LINE (f, 120)-(f - 15, 110), 0
    LINE (f, 120)-(f + 15, 110), 0
245 f = e
246 GOTO 1

250 IF c < e THEN GOTO 255
    LINE (e, 120)-(e + 15, 110), 0
    LINE (e, 120)-(e + 30, 120)
    FOR i = 1 TO speed
    NEXT i
    LINE (e, 120)-(e + 15, 110)
    LINE (e, 120)-(e + 30, 120), 0
    GOTO 259
255 LINE (e, 120)-(e - 30, 120)
    LINE (e, 120)-(e - 15, 110), 0
    FOR i = 1 TO speed
    NEXT i
    LINE (e, 120)-(e - 30, 120)
    LINE (e, 120)-(e - 30, 120), 0
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
    LINE (e, 130)-(e + 20, 150), 0
    LINE (e, 130)-(e + 30, 130)
    FOR i = 1 TO speed
    NEXT i
    LINE (e, 130)-(e + 20, 150)
    LINE (e, 130)-(e + 30, 130), 0
    GOTO 269
265 LINE (e, 130)-(e - 20, 150), 0
    LINE (e, 130)-(e - 30, 130)
    FOR i = 1 TO speed
    NEXT i
    LINE (e, 130)-(e - 20, 150)
    LINE (e, 130)-(e - 30, 130), 0
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


600 LOCATE 15, 30: PRINT " Player 2 Wins"
    FOR i = 1 TO speed
    NEXT i
    GOTO 615
610 LOCATE 15, 30: PRINT "Player 1 Wins"
    FOR i = 1 TO speed
    NEXT i
    GOTO 615

615
  FOR i = 400 TO 1 STEP -1
  CIRCLE (320, 100), i
  PAINT (1, 1), 0
  CIRCLE (320, 100), i + 1, 0
  FOR ii = 1 TO speed / 10
  NEXT ii
  NEXT i

616 GOTO mainmenu

intro:
  
  'MicroTrip
   CLS
   SCREEN 8
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

666

SUB title

'Beat Down Title Screen 3D
'By Brian Murphy of MicroTrip

SCREEN 8
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

'All done

END SUB

