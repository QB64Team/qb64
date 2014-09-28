'Maze of Misery
'By Steve M. (c),May 5,01
'****************

'Please visit my web page at:  www.angelfire.com/bc2/cuebasic/qpage.html
'
'Disclaimer: This program may not be distributed, modified or copied without
'written permission from the author at yochatwitme@yahoo.com.
'Not liable for system or hardware damage. Tho' I can assure you that you
'won't experience any problems. Email me at yochatwitme@yahoo.com about
'any concerns or difficulties you may be having.
'Finally, you have my permission to post the program on your web page.
'Hope you enjoy the game.
'
'Thanks. SM :)
'Gbgames Chatname: QB4ever

DECLARE SUB Cleardotarea ()
DECLARE SUB CopydotPlayer ()
DECLARE SUB Menu ()

dim shared false as single
false=0
dim shared true as single
true=-1
'CONST FALSE = 0
'CONST TRUE = NOT FALSE

'CLEAR 2000, 2000
DIM T$(150), Wall%(1 TO 300), Wall2%(1 TO 300), Wall3%(1 TO 300)
DIM SHARED Player%(1 TO 300), Maze$(768), Object$(20), Door%(1 TO 300)
DIM EDoor%(1 TO 300), Keylock%(1 TO 300), Clrobject%(1 TO 300)
DIM Gold%(1 TO 300), Treasure%(1 TO 300), Diamond%(1 TO 300)
DIM Diamond2%(1 TO 300), Enemy%(1 TO 300), Gem%(1 TO 300)
DIM Enemydotpos(16), Spider%(1 TO 300), Spider2%(1 TO 300)
DIM Spike%(1 TO 300), Spikemask%(1 TO 300), Wallmask%(1 TO 300)
DIM Web%(1 TO 300), Wcs(64, 1), Keyfl(64), Clrkey(64)
DIM Spiderfr2%(1 TO 300), Spiderpfr2%(1 TO 300), Playerdeath%(1 TO 300)
DIM SHARED Reptxt%(1 TO 3000)

Start:
X = 154: Y = 40: MatrixY = 14: MatrixX = 6: Lives = 5: Health = 9000
En = 1: Dx = -30: Lx = -1: Dy = 1: SpacerX = 0: SpacerY = 0: EVL = 11
CIX1 = 275: CIY1 = 145: CIY2 = 90: Rm = 2: Web = 20: Glow = 1: Adv = 0
M2 = -1: V2x = 1: G = 1
Health$ = "Good": M1$ = "Mazes of Misery": TIME$ = "00:00:00"
T$ = CHR$(0) + CHR$(63) + CHR$(48) + CHR$(48) + CHR$(60) + CHR$(48) + CHR$(48) + CHR$(48) + CHR$(0)
RESTORE Wallcols: FOR A = 1 TO 64: READ Wcs(A, 0): NEXT
RESTORE Wallbord: FOR A = 1 TO 64: READ Wcs(A, 1): NEXT

BegindotMaze:

'Setup array picture images

SCREEN 12: CLS : RANDOMIZE TIMER
GOSUB Copydotwall: GOSUB Cleardotplayer
GOSUB Copydotwall2: GOSUB Cleardotplayer
GOSUB Copydotwall3: GOSUB Cleardotplayer
GOSUB CopydotPlayer: GOSUB Cleardotplayer
GOSUB CopydotCleardotObject  'This array clears the current image
GOSUB CopydotDoor: GOSUB Cleardotplayer
GOSUB CopydotKeylock: GOSUB Cleardotplayer
GOSUB CopydotTreasure: GOSUB Cleardotplayer
GOSUB CopydotRing: GOSUB Cleardotplayer
GOSUB CopydotRing2: GOSUB Cleardotplayer
GOSUB CopydotGem: GOSUB Cleardotplayer
GOSUB CopydotSpider: GOSUB Cleardotplayer
GOSUB CopydotSpider2: GOSUB Cleardotplayer
GOSUB CopydotWeb: GOSUB Cleardotplayer
GOSUB CopydotSpike: GOSUB Cleardotplayer
SpacerX = 0: SpacerY = 0: GOSUB Titledotscr
Begin:
frm = 1: SCREEN 12: CLS : GOSUB Builddotmazes
SpacerX = 0: SpacerY = 0: GOSUB RoomdotCheck: GOSUB Gamedotstatus
r = StartdotA: SpacerX = 0: SpacerY = 0

Kyboard:
do: loop while timer=oldtimer!
oldtimer!=timer
FOR i=1 to 100
GOSUB Scandotmaze
NEXT
T$ = MID$(Maze$(MatrixY), MatrixX, 1)
IF T$ = "L" AND (CT >= 1 AND CT <= 20) THEN GOSUB Shocked
i$ = INKEY$: IF i$ = "" THEN GOTO Kyboard

Oldx = X: Oldy = Y: Matrixydotold = MatrixY: Matrixxdotold = MatrixX
  IF Kytapfl < 1 THEN
     IF i$ = CHR$(0) + "M" THEN GOSUB Cleardotman: X = X + 30: MatrixX = MatrixX + 1: IF X > 574 THEN X = 4: Rm = Rm + 8: MatrixY = MatrixY + 96: MatrixX = 1: GOSUB RoomdotCheck
     IF i$ = CHR$(0) + "K" THEN GOSUB Cleardotman: X = X - 30: MatrixX = MatrixX - 1: IF X < 4 THEN X = 574: Rm = Rm - 8: MatrixY = MatrixY - 96: MatrixX = 20: GOSUB RoomdotCheck
     IF i$ = CHR$(0) + "H" THEN GOSUB Cleardotman: Y = Y - 36: MatrixY = MatrixY - 1: IF Y < 4 THEN Rm = Rm - 1: GOSUB RoomdotCheck
     IF i$ = CHR$(0) + "P" THEN GOSUB Cleardotman: Y = Y + 36: MatrixY = MatrixY + 1: IF Y > 400 THEN Rm = Rm + 1: GOSUB RoomdotCheck
  ELSE
     IF i$ = "6" THEN GOSUB Cleardotman: X = X + 30: MatrixX = MatrixX + 1: IF X > 574 THEN X = 4: Rm = Rm + 8: MatrixY = MatrixY + 96: MatrixX = 1: GOSUB RoomdotCheck
     IF i$ = "4" THEN GOSUB Cleardotman: X = X - 30: MatrixX = MatrixX - 1: IF X < 4 THEN X = 574: Rm = Rm - 8: MatrixY = MatrixY - 96: MatrixX = 20: GOSUB RoomdotCheck
     IF i$ = "8" THEN GOSUB Cleardotman: Y = Y - 36: MatrixY = MatrixY - 1: IF Y < 4 THEN Rm = Rm - 1: GOSUB RoomdotCheck
     IF i$ = "2" THEN GOSUB Cleardotman: Y = Y + 36: MatrixY = MatrixY + 1: IF Y > 400 THEN Rm = Rm + 1: GOSUB RoomdotCheck
  END IF
IF i$ = CHR$(27) THEN i$ = "": GOSUB Menulist
T$ = MID$(Maze$(MatrixY), MatrixX, 1)
IF T$ = "#" OR T$ = "@" OR T$ = "%" OR T$ = "W" THEN GOSUB Recalldotolddotposition
IF T$ = "B" AND M > 11 THEN GOSUB Spiderdotbite
IF T$ = "L" AND (CT >= 1 AND CT <= 20) THEN GOSUB Shocked
IF T$ = "k" THEN GOSUB Keyfound
IF T$ = "E" THEN GOTO Escaped
IF T$ = "D" THEN Sx = X: Sy = Y: Svsx = Sx: Svsy = Sy: SMy = MatrixY: SMx = MatrixX: GOSUB Recalldotolddotposition: GOSUB Doordotroutine
IF T$ = "t" THEN GOSUB Treasuredotroutine
IF T$ = "g" THEN GOSUB Gemdotroutine
IF T$ = "r" THEN GOSUB Ringdotroutine
IF Flg THEN GmdotTmr = TIMER: DELAY = CPU * 15 + SQR(2 / 2 + GmdotTmr + .6) + 800: FOR LL = 1 TO DELAY: NEXT
IF frm > 100 THEN frm = 1
GOSUB Displaydotman
GOTO Kyboard

Scandotmaze:
B = B + 1
T$ = MID$(Maze$(r), B, 1): SPK$ = MID$(Maze$(r), B, 1)
GOSUB SkipdotX: Cnt = Cnt + 1
IF T$ = "B" OR T$ = "S" THEN Spx = SpacerX: Spy = SpacerY: GOSUB Spiderdotroutine
IF T$ = "L" THEN Lex = SpacerX: Ley = SpacerY: GOSUB Electricdotroutine
IF T$ = "r" THEN RingdotX = SpacerX: RingdotY = SpacerY + 6: GOSUB Ringdotglow
IF SPK$ = "s" THEN SpikeX = SpacerX: SpikeY = SpacerY + 6: GOSUB SpikedotMoving
IF B < 20 THEN RETURN
B = 1: SpacerX = 0: SpacerY = SpacerY + 36
IF r < FinishdotA THEN r = r + 1: RETURN
r = StartdotA: SpacerX = 0: SpacerY = 0
RETURN

SkipdotX:
SpacerX = SpacerX + 30
RETURN
 
Spiderdotroutine:
frm = frm + 1
IF (T$ = "S") THEN Poisondotspider = 1
T$ = MID$(Maze$(MatrixY), MatrixX, 1)
IF Demo THEN T$ = MID$(A$(Dmx), Dmy, 1)
IF (T$ = "B" OR T$ = "S") AND M > 11 THEN GOSUB Spiderdotbite
IF T$ = "s" AND M2 < 8 THEN GOSUB Spikedotstabb
M = M + Vx: IF M > 31 THEN Vx = -1
GOSUB Showdotspider
IF M < 1 THEN Vx = 1
LINE (Spx + 12, (Spy - Web))-(Spx + 12, (Spy - 10) + M), 8, BF
FOR H = 1 TO 800 - Adv + DELAY: NEXT
RETURN

SpikedotMoving:
SPK$ = MID$(Maze$(r), B, 1)
M2 = M2 + V2x: IF M2 > 25 THEN V2x = -1
IF M2 < 1 THEN V2x = 1
IF Wm < 1 THEN GET (SpikeX, SpikeY + 36)-(SpikeX + 26, SpikeY + 71), Spikemask%: Wm = 1
PUT (SpikeX, (SpikeY) + 11 + M2), Spike%, PSET
IF Wm2 < 1 THEN GET (SpikeX, SpikeY + 5 + M2)-(SpikeX + 18, SpikeY + 36 + M2), Wallmask%: Wm2 = 1
IF T$ = "s" THEN GOSUB Displaydotman
PUT (SpikeX, SpikeY + 5 + M2), Wallmask%, AND 'spike mask
PUT (SpikeX, SpikeY + 36), Spikemask%, PSET   'wall mask
RETURN

Showdotspider:
IF Poisondotspider THEN
   IF INT(frm / 2) = frm / 2 THEN
      PUT (Spx - 1, (Spy - 30) + 10 + M), Spiderpfr2%, PSET: Poisondotspider = 0: RETURN
   ELSE
      PUT (Spx - 1, (Spy - 30) + 10 + M), Spider2%, PSET: Poisondotspider = 0: RETURN
   END IF

ELSE
   IF INT(frm / 4) = frm / 4 THEN
      PUT (Spx - 1, (Spy - 30) + 10 + M), Spiderfr2%, PSET: RETURN
   ELSE
      PUT (Spx - 1, (Spy - 30) + 10 + M), Spider%, PSET
   END IF
END IF
RETURN

Showdotspike:
PUT (SpikeX, SpikeY + M2), Spike%, PSET
RETURN

Electricdotroutine:
CT = CT + 1: IF CT >= 1 AND CT <= 20 THEN GOTO EStart
IF CT > 50 THEN CT = 1
RETURN

EStart:
RANDOMIZE TIMER
IF G < 1 THEN Gv = 1
G = G + Gv: IF G > 5 THEN Gv = -1
E1 = RND(6 * RND(0)): E2 = RND(6 * RND(0)): E3 = FIX(RND(6 * RND(0)))
E4 = FIX(6 * RND(0)): E5 = FIX(6 * RND(0)): E6 = FIX(RND(6 * RND(0)))
E7 = FIX(6 * RND(0)): E8 = FIX(6 * RND(0)): E9 = FIX(RND(6 * RND(0)))
LINE (Lex + E1, Ley + 4)-(Lex + E2 * (G + 3), Ley + 9), 14
LINE -(Lex + E3 + SGN(G + 3), Ley + 15), 14
LINE -(Lex + E4 * (G + 3), Ley + 20), 14
LINE -(Lex + E5 + SGN(G + 3), Ley + 26), 14
LINE -(Lex + E6 * (G + 3), Ley + 32), 14
LINE -(Lex + E7 + SGN(G + 3), Ley + 38), 14
FOR H = 1 TO 150 - Adv / 4: NEXT
Sx = SpacerX + 2: Sy = SpacerY + 4: GOSUB Cleardotarea
RETURN

Spiderdotbite:
GOSUB Displaydotman: M$ = "Yow! I've been bitten!": PS = 40 - LEN(M$) / 2
LOCATE 30, PS: PRINT M$; : GOSUB Hold: GOSUB Clearline
PUT (X, Y), Playerdeath%, PSET: SLEEP 1: PUT (X, Y), Clrobject%, PSET
Health = Health - ABS(75 * (T$ = "S") - 55)
IF Health < 1 THEN LOCATE 30, PS + 4: PRINT "You died!"; : SLEEP 2: GOSUB Clearline: GOTO Fin
GOSUB Gamedotstatus
RETURN

Spikedotstabb:
GOSUB Displaydotman: M$ = "Yarrgghh! I've been sheared!": PS = 40 - LEN(M$) / 2
LOCATE 30, PS: PRINT M$; : GOSUB Hold: GOSUB Clearline
PUT (X, Y), Playerdeath%, PSET: SLEEP 1: PUT (X, Y), Clrobject%, PSET
Health = Health - ABS(75 * (T$ = "S") - 55)
IF Health < 1 THEN LOCATE 30, PS + 4: PRINT "You died!"; : SLEEP 2: GOSUB Clearline: GOTO Fin
GOSUB Gamedotstatus
RETURN

Shocked:
GOSUB Displaydotman: M$ = "Arrggghh! I've been shocked!": PS = 40 - LEN(M$) / 2
LOCATE 30, PS: PRINT M$; : GOSUB Hold: GOSUB Clearline
PUT (X, Y), Playerdeath%, PSET: SLEEP 1: PUT (X, Y), Clrobject%, PSET
Health = Health - 25
IF Health < 1 THEN LOCATE 30, 30: PRINT "You died!"; : SLEEP 2: GOSUB Clearline: GOTO Fin
GOSUB Gamedotstatus
RETURN

Treasuredotroutine:
GOSUB Replacedotchar: GOSUB Openeddotchest
RETURN

Ringdotroutine:
LOCATE 30, 20: PRINT "You have found a diamond ring!"; : GOSUB Displaydotman
SLEEP 2: GOSUB Replacedotchar: GOSUB Clearline: GOSUB Cleardotarea
Fortune = 200: GOSUB Tallydotpnts: GOSUB Gamedotstatus
RETURN

Gemdotroutine:
LOCATE 30, 20: PRINT "You have found a valuable gem!!"; : GOSUB Displaydotman
SLEEP 2: GOSUB Replacedotchar: GOSUB Clearline: GOSUB Cleardotarea
Fortune = 400: GOSUB Tallydotpnts: GOSUB Gamedotstatus
RETURN

Ringdotglow:
IF Glow THEN PUT (RingdotX, RingdotY), Diamond2%, PSET: Glow = 0
IF RIGHT$(TIME$, 2) < "01" THEN RETURN
Glow = 1
IF Glow THEN PUT (RingdotX, RingdotY), Diamond%, PSET: Glow = 0
IF RIGHT$(TIME$, 2) < "02" THEN RETURN
TIME$ = "00:00:00": Glow = 1
RETURN

Replacedotchar:
IF T$ = "D" THEN Sx = Svsx: Sy = Svsy: GOSUB Cleardotarea
Showy = SMy: Showx = SMx
Sx = X: Sy = Y: SMy = MatrixY: SMx = MatrixX
IF (T$ <> "r" AND T$ <> "g") THEN GOSUB Recalldotolddotposition: GOSUB Displaydotman
IF T$ = "D" THEN SMy = Showy: SMx = Showx
MID$(Maze$(SMy), SMx, 1) = CHR$(32)
RETURN
 
Displaydotman:
PUT (X, Y), Player%, PSET: RETURN

Recalldotolddotposition:
X = Oldx: Y = Oldy: FOR A = 1 TO 64
Barrier = 1 * (T$ = "D" AND Unl AND Rm = A AND Keyfl(Rm))
IF Barrier THEN A = 1: RETURN
NEXT

Oldpl:
MatrixX = Matrixxdotold: MatrixY = Matrixydotold
RETURN

Keyfound:
FOR A = 1 TO 64
Keyfl(Rm) = ABS(1 * (Rm = A)): Unl = 1
IF Keyfl(Rm) AND Unl THEN A = 1: GOTO Keymes
NEXT
  
Keymes:
COLOR 15: LOCATE 30, 9: PRINT "You have found the key. ";
PRINT "Use it to unlock the door in this room."; :
GOSUB Replacedotchar: GOSUB Cleardotarea
SLEEP 3: GOSUB Clearline: Keys = Keys + 1: GOSUB Gamedotstatus: RETURN

Doordotroutine:
FOR A = 1 TO 64
Kyfd = 1 * (Rm = A AND Keyfl(Rm)): IF Kyfd THEN A = 1: GOTO Available
NEXT: RETURN

Available:
FOR A = 1 TO 64
Clrkey = 1 * (Rm = A AND Keyfl(Rm)): IF Clrkey > 0 THEN Keyfl(Rm) = 0: A = 1: GOTO DOpen
NEXT

DOpen:
GOSUB Displaydotman
LOCATE 30, 20: PRINT "Good Job! You have opened the door."; : SLEEP 3:
GOSUB Clearline: GOSUB Replacedotchar: Unl = 0
Keys = Keys - 1: GOSUB Gamedotstatus
RETURN

Openeddotchest:
COLOR 14: Tr = 1: LOCATE 29, 1: PRINT SPACE$(79);
LOCATE 30, 20: PRINT "You have found a treasure chest!";
SLEEP 2: GOSUB Clearline
RANDOMIZE TIMER: Length = FIX(16 * RND(1)) + 1: RESTORE Makedotobj
N = FIX(50 * RND(1)) + 2
FOR T = 1 TO Length: READ Object$(T): NEXT
L = LEN(Object$(Length)): O$ = MID$(Object$(Length), 3, L)
  IF LEFT$(O$, 2) = "No" OR LEFT$(O$, 3) = "Wat" THEN
     Message$ = ""
  ELSE
     Message$ = "a "
  END IF

LOCATE 30, 20: PRINT "It contains "; Message$; ""; O$; SPACE$(2); addon$;
SLEEP 2: GOSUB ObjectdotProperties: Message$ = "": addon$ = ""
O$ = "": Message$ = O$
IF LO$ = "~" THEN GOSUB Clearline: LOCATE 30, 20: PRINT "There are " + STR$(N) + " of them."; : SLEEP 2
GOSUB Gamedotstatus: Tr = 0: addon$ = "": GOSUB Clearline: GOSUB Cleardotarea
RETURN

Clearline:
LOCATE 30, 1: PRINT SPACE$(79); : RETURN

Hold:
H$ = INKEY$: IF H$ = "" THEN GOTO Hold
RETURN

Escaped:
COLOR 15
LINE (110, 190)-(510, 255), 10, BF: LINE (115, 200)-(500, 245), 14, BF
LINE (115, 200)-(500, 245), 1, B
LOCATE 14, 25: PRINT "Congratulations Adventurer!"
LOCATE 15, 19: PRINT "You have escaped from this maze for now.": SLEEP 4: SYSTEM

'CopydotPlayer:
LINE (CIX1 + 15, CIY1 + 23)-(CIX1 + 37, CIY1 + 45), 0, BF
CIRCLE (CIX1 + 28, CIY1 + 35), 10, 15: PAINT (CIX1 + 28, CIY1 + 35), 15
CIRCLE (CIX1 + 28, CIY1 + 35), 10, 6: CIRCLE (CIX1 + 28, CIY1 + 35), 9, 6
FOR E = 1 TO 5: CIRCLE (CIX1 + 28, CIY1 + 35), E, 0: NEXT
CIRCLE (CIX1 + 28, CIY1 + 35), 1, 0
GET (CIX1 + 15, CIY1 + 23)-(CIX1 + 37, CIY1 + 45), Player%
RETURN

CopydotPlayer:
X1 = 20: Y1 = 40: c = 1
CIRCLE (X1, Y1), 9, 6: PAINT (X1, Y1), 6: CIRCLE (X1, Y1), 10, 4 'Body
CIRCLE (X1 - 5, Y1 - 5), 3, 15: PAINT (X1 - 5, Y1 - 5), 15 'left eye
CIRCLE (X1 - 5, Y1 - 5), 3, c, -6.28, -3.14: PAINT (X1 - 5, Y1 - 6), c
CIRCLE (X1 - 5, Y1 - 5), 1, 0: PAINT (X1 - 5, Y1 - 5), 0   'outline
CIRCLE (X1 + 5, Y1 - 5), 3, 15: PAINT (X1 + 5, Y1 - 5), 15 'right eye
CIRCLE (X1 + 5, Y1 - 5), 3, c, -6.28, -3.14: PAINT (X1 + 5, Y1 - 6), c
CIRCLE (X1 + 5, Y1 - 5), 1, 0: PAINT (X1 + 5, Y1 - 5), 0
CIRCLE (X1, Y1), 2, 4: PAINT (X1, Y1), 4: CIRCLE (X1, Y1), 3, 1 'nose
LINE (X1 - 2, Y1 + 5)-(X1 + 2, Y1 + 5), 5 'mouth(top)
LINE (X1 - 1, Y1 + 6)-(X1 + 1, Y1 + 6), 5 'mouth(bottom)
GET (X1 - 10, Y1 - 10)-(X1 + 10, Y1 + 10), Player%
GOSUB CopydotPlayerdeath
RETURN

CopydotPlayerdeath:
X1 = 20: Y1 = 40: c = 4
CIRCLE (X1, Y1), 9, 6: PAINT (X1, Y1), 6: CIRCLE (X1, Y1), 10, 4 'Body
CIRCLE (X1 - 5, Y1 - 5), 5, 15: PAINT (X1 - 5, Y1 - 5), 15 'left eye
CIRCLE (X1 - 5, Y1 - 5), 1, 0: PAINT (X1 - 5, Y1 - 5), 0   'outline
CIRCLE (X1 + 5, Y1 - 5), 5, 15: PAINT (X1 + 5, Y1 - 5), 15 'right eye
CIRCLE (X1 + 5, Y1 - 5), 1, 0: PAINT (X1 + 5, Y1 - 5), 0
CIRCLE (X1, Y1), 2, 4: PAINT (X1, Y1), 4: CIRCLE (X1, Y1), 3, 1 'nose
LINE (X1 - 2, Y1 + 5)-(X1 + 2, Y1 + 5), 5 'mouth(top)
LINE (X1 - 1, Y1 + 6)-(X1 + 1, Y1 + 6), 5 'mouth(bottom)
CIRCLE (X1, Y1 + 6), 2, c, , , .32: PAINT (X1, Y1 + 6), c
CIRCLE (X1, Y1 + 6), 3, 1, , , .32
GET (X1 - 10, Y1 - 10)-(X1 + 10, Y1 + 10), Playerdeath%
RETURN

Copydotwall:
LINE (CIX1 + 11, CIY1 + 21)-(CIX1 + 34, CIY1 + 50), Wcs(Rm, 0), BF
LINE (CIX1 + 12, CIY1 + 20)-(CIX1 + 35, CIY1 + 51), Wcs(Rm, 1), B
LINE (CIX1 + 36, CIY1 + 20)-(CIX1 + 36, CIY1 + 50), 10
FOR A = CIX1 + 12 TO CIX1 + 34 STEP 2: LINE (A, CIY1 + 21)-(A, CIY1 + 50), 6
NEXT: LINE (CIX1 + 11, CIY1 + 50)-(CIX1 + 34, CIY1 + 50), 1
LINE (CIX1 + 11, CIY1 + 21)-(CIX1 + 11, CIY1 + 50), 8
'FOR A = CIY1 + 11 TO CIY1 + 50 STEP 2: LINE (CIX1 + 11, A)-(CIX1 + 35, A), 5: NEXT
GET (CIX1 + 11, CIY1 + 19)-(CIX1 + 36, CIY1 + 51), Wall%
RETURN

Copydotwall2:
LINE (CIX1 + 11, CIY1 + 20)-(CIX1 + 34, CIY1 + 50), Wcs(Rm, 0), BF
LINE (CIX1 + 12, CIY1 + 19)-(CIX1 + 35, CIY1 + 51), Wcs(Rm, 1), B
LINE (CIX1 + 36, CIY1 + 19)-(CIX1 + 36, CIY1 + 50), 10
FOR A = 0 TO 41 STEP 2
LINE (CIX1 + 11, CIY1 + 20 + A)-(CIX1 + 33, CIY1 + A), 1: NEXT
GET (CIX1 + 11, CIY1 + 19)-(CIX1 + 42, CIY1 + 51), Wall2%
RETURN

Copydotwall3:
WX = 26: WY = 32
LINE (100, 75)-(100 + WX, 75 + WY), , B
T$ = T$ + CHR$(200) + CHR$(130) + CHR$(146) + CHR$(48) + CHR$(8) + CHR$(2) + CHR$(144) + CHR$(152) + CHR$(2)
PAINT (102, 76), T$
LINE (100, 75)-(100 + WX, 75 + WY), 4, B
GET (100, 75)-(100 + WX, 75 + WY), Wall3%
RETURN

CopydotCleardotObject:
LINE (CIX1 + 16, CIY1 + 50)-(CIX1 + 60, CIY1 + 80), 0, BF
GET (265, CIY1 + 20)-(290, CIY1 + 54), Clrobject%
RETURN

CopydotDoor:
LINE (CIX1 + 11, CIY1 + 20)-(CIX1 + 36, CIY1 + 52), 6, BF
LINE (CIX1 + 13, CIY1 + 22)-(CIX1 + 33, CIY1 + 31), 12, BF
LINE (CIX1 + 13, CIY1 + 40)-(CIX1 + 33, CIY1 + 48), 12, BF
LINE (CIX1 + 13, CIY1 + 22)-(CIX1 + 33, CIY1 + 31), 0, B
LINE (CIX1 + 13, CIY1 + 40)-(CIX1 + 33, CIY1 + 48), 0, B
LINE (CIX1 + 10, CIY1 + 19)-(CIX1 + 37, CIY1 + 53), 1, B
LINE (CIX1 + 37, CIY1 + 20)-(CIX1 + 37, CIY1 + 52), 12
CIRCLE (CIX1 + 34, CIY1 + 36), 2, 14: PAINT (CIX1 + 34, CIY1 + 36), 14
CIRCLE (CIX1 + 34, CIY1 + 36), 2, 0
GET (CIX1 + 11, CIY1 + 20)-(CIX1 + 40, CIY1 + 53), Door%
GOSUB CopydotEDoor
RETURN

CopydotEDoor:
LINE (CIX1 + 11, CIY1 + 20)-(CIX1 + 36, CIY1 + 52), 13, BF
LINE (CIX1 + 13, CIY1 + 22)-(CIX1 + 33, CIY1 + 31), 2, BF
LINE (CIX1 + 13, CIY1 + 40)-(CIX1 + 33, CIY1 + 48), 2, BF
LINE (CIX1 + 13, CIY1 + 22)-(CIX1 + 33, CIY1 + 31), 0, B
LINE (CIX1 + 13, CIY1 + 40)-(CIX1 + 33, CIY1 + 48), 0, B
LINE (CIX1 + 10, CIY1 + 19)-(CIX1 + 37, CIY1 + 53), 1, B
LINE (CIX1 + 37, CIY1 + 20)-(CIX1 + 37, CIY1 + 52), 12
CIRCLE (CIX1 + 34, CIY1 + 36), 2, 14: PAINT (CIX1 + 34, CIY1 + 36), 14
CIRCLE (CIX1 + 34, CIY1 + 36), 2, 0
GET (CIX1 + 11, CIY1 + 20)-(CIX1 + 40, CIY1 + 53), EDoor%
RETURN

CopydotKeylock:
CIRCLE (CIX1 + 24, CIY1 + 35), 4, 7
CIRCLE (CIX1 + 27, CIY1 + 40), 4, 7
COLOR 4: LINE (CIX1 + 26, CIY1 + 39)-(CIX1 + 44, CIY1 + 21)
LINE (CIX1 + 26, CIY1 + 40)-(CIX1 + 44, CIY1 + 22)
COLOR 6: LINE (CIX1 + 34, CIY1 + 20)-(CIX1 + 39, CIY1 + 28)
LINE (CIX1 + 35, CIY1 + 20)-(CIX1 + 40, CIY1 + 28)
LINE (CIX1 + 35, CIY1 + 32)-(CIX1 + 31, CIY1 + 27)
GET (CIX1 + 15, CIY1 + 16)-(CIX1 + 39, CIY1 + 47), Keylock%
RETURN

CopydotTreasure:
LINE (CIX1 + 16, CIY1 + 65)-(CIX1 + 35, CIY1 + 80), 14, B
LINE -(CIX1 + 40, CIY1 + 75), 14: LINE -(CIX1 + 40, CIY1 + 60), 14
LINE -(CIX1 + 35, CIY1 + 65), 14
LINE (CIX1 + 16, CIY1 + 65)-(CIX1 + 21, CIY1 + 60), 14
LINE -(CIX1 + 40, CIY1 + 60), 14
LINE (CIX1 + 17, CIY1 + 66)-(CIX1 + 34, CIY1 + 79), 6, BF
PAINT (CIX1 + 38, CIY1 + 68), 14
LINE (CIX1 + 22, CIY1 + 60)-(CIX1 + 40, CIY1), 6, BF
LINE (CIX1 + 40, CIY1 + 60)-(CIX1 + 40, CIY1), 12
LINE (CIX1 + 22, CIY1 + 50)-(CIX1 + 40, CIY1 + 50), 12
GET (CIX1 + 16, CIY1 + 50)-(CIX1 + 40, CIY1 + 80), Treasure%
RETURN

CopydotRing:
CIRCLE (CIX1 + 28, CIY1 + 35), 5, 15: CIRCLE (CIX1 + 28, CIY1 + 35), 6, 8
CIRCLE (CIX1 + 28, CIY1 + 26), 3, 1: PAINT (CIX1 + 28, CIY1 + 26), 13, 1
LINE (CIX1 + 26, CIY1 + 24)-(CIX1 + 30, CIY1 + 24), 11
CIRCLE (CIX1 + 28, CIY1 + 26), 2, 1: CIRCLE (CIX1 + 28, CIY1 + 35), 4, 9
GET (CIX1 + 15, CIY1 + 20)-(CIX1 + 38, CIY1 + 45), Diamond%
RETURN

CopydotRing2:
CIRCLE (CIX1 + 28, CIY1 + 35), 5, 15: CIRCLE (CIX1 + 28, CIY1 + 35), 6, 8
CIRCLE (CIX1 + 28, CIY1 + 26), 3, 12: PAINT (CIX1 + 28, CIY1 + 26), 13, 12
LINE (CIX1 + 26, CIY1 + 24)-(CIX1 + 30, CIY1 + 24), 14
CIRCLE (CIX1 + 28, CIY1 + 26), 2, 1: CIRCLE (CIX1 + 28, CIY1 + 35), 4, 9
GET (CIX1 + 15, CIY1 + 20)-(CIX1 + 38, CIY1 + 47), Diamond2%
RETURN

CopydotGem:
CIRCLE (CIX1 + 28, CIY1 + 35), 5, 10: 'CIRCLE (CIX1 + 28, CIY1 + 35), 10, 8
CIRCLE (CIX1 + 28, CIY1 + 26), 2: PAINT (CIX1 + 28, CIY1 + 26), T$
LINE (CIX1 + 26, CIY1 + 24)-(CIX1 + 30, CIY1 + 24), 1
CIRCLE (CIX1 + 28, CIY1 + 35), 4, 9
GET (CIX1 + 15, CIY1 + 20)-(CIX1 + 38, CIY1 + 45), Gem%
RETURN

CopydotSpider:
CIRCLE (CIX1 + 28, CIY1 + 27), 3, 8: PAINT (CIX1 + 28, CIY1 + 27), 8
CIRCLE (CIX1 + 28, CIY1 + 20), 6, 8: PAINT (CIX1 + 28, CIY1 + 20), 8
CIRCLE (CIX1 + 28, CIY1 + 25), 6, 0
LINE (CIX1 + 24, CIY1 + 25)-(CIX1 + 19, CIY1 + 30), 7: LINE -(CIX1 + 22, CIY1 + 33), 7
LINE (CIX1 + 32, CIY1 + 25)-(CIX1 + 37, CIY1 + 30), 7: LINE -(CIX1 + 34, CIY1 + 33), 7
LINE (CIX1 + 23, CIY1 + 22)-(CIX1 + 20, CIY1 + 25), 7
LINE (CIX1 + 23, CIY1 + 16)-(CIX1 + 18, CIY1 + 21), 7
LINE -(CIX1 + 18, CIY1 + 23), 7
LINE (CIX1 + 33, CIY1 + 22)-(CIX1 + 36, CIY1 + 25), 7
LINE (CIX1 + 33, CIY1 + 16)-(CIX1 + 38, CIY1 + 21), 7
LINE -(CIX1 + 38, CIY1 + 23), 7
LINE (CIX1 + 27, CIY1 + 29)-(CIX1 + 27, CIY1 + 31), 4
LINE (CIX1 + 30, CIY1 + 29)-(CIX1 + 30, CIY1 + 31), 4
GET (CIX1 + 15, CIY1 + 10)-(CIX1 + 42, CIY1 + 40), Spider%
GOSUB CopydotSpiderfr2
RETURN

CopydotSpiderfr2:
CLS
CIRCLE (CIX1 + 28, CIY1 + 27), 5, 8: PAINT (CIX1 + 28, CIY1 + 27), 8
CIRCLE (CIX1 + 28, CIY1 + 20), 6, 8: PAINT (CIX1 + 28, CIY1 + 20), 8
CIRCLE (CIX1 + 28, CIY1 + 25), 6, 0
LINE (CIX1 + 24, CIY1 + 25)-(CIX1 + 19, CIY1 + 20), 7: LINE -(CIX1 + 17, CIY1 + 24), 7
LINE (CIX1 + 32, CIY1 + 25)-(CIX1 + 37, CIY1 + 20), 7: LINE -(CIX1 + 40, CIY1 + 25), 7
LINE (CIX1 + 24, CIY1 + 25)-(CIX1 + 22, CIY1 + 30), 7: LINE -(CIX1 + 24, CIY1 + 33), 7
LINE (CIX1 + 32, CIY1 + 25)-(CIX1 + 34, CIY1 + 30), 7: LINE -(CIX1 + 32, CIY1 + 33), 7
LINE (CIX1 + 27, CIY1 + 29)-(CIX1 + 27, CIY1 + 31), 4
LINE (CIX1 + 30, CIY1 + 29)-(CIX1 + 30, CIY1 + 31), 4
GET (CIX1 + 14, CIY1 + 10)-(CIX1 + 44, CIY1 + 40), Spiderfr2%
RETURN

CopydotSpider2:
CIRCLE (CIX1 + 28, CIY1 + 27), 3, 10: PAINT (CIX1 + 28, CIY1 + 27), 10
CIRCLE (CIX1 + 28, CIY1 + 20), 6, 10: PAINT (CIX1 + 28, CIY1 + 20), 10
CIRCLE (CIX1 + 28, CIY1 + 25), 6, 0
LINE (CIX1 + 24, CIY1 + 25)-(CIX1 + 19, CIY1 + 30), 7: LINE -(CIX1 + 22, CIY1 + 33), 7
LINE (CIX1 + 32, CIY1 + 25)-(CIX1 + 37, CIY1 + 30), 7: LINE -(CIX1 + 34, CIY1 + 33), 7
LINE (CIX1 + 23, CIY1 + 22)-(CIX1 + 20, CIY1 + 25), 7
LINE (CIX1 + 33, CIY1 + 22)-(CIX1 + 36, CIY1 + 25), 7
LINE (CIX1 + 23, CIY1 + 22)-(CIX1 + 20, CIY1 + 25), 7
LINE (CIX1 + 23, CIY1 + 16)-(CIX1 + 18, CIY1 + 21), 7
LINE -(CIX1 + 18, CIY1 + 23), 7
LINE (CIX1 + 33, CIY1 + 22)-(CIX1 + 36, CIY1 + 25), 7
LINE (CIX1 + 33, CIY1 + 16)-(CIX1 + 38, CIY1 + 21), 7
LINE -(CIX1 + 38, CIY1 + 23), 7
LINE (CIX1 + 27, CIY1 + 29)-(CIX1 + 27, CIY1 + 31), 4
LINE (CIX1 + 30, CIY1 + 29)-(CIX1 + 30, CIY1 + 31), 4
GET (CIX1 + 15, CIY1 + 10)-(CIX1 + 43, CIY1 + 40), Spider2%
GOSUB CopydotSpiderpfr2
RETURN

CopydotSpiderpfr2:
CLS
CIRCLE (CIX1 + 28, CIY1 + 27), 3, 10: PAINT (CIX1 + 28, CIY1 + 27), 10
CIRCLE (CIX1 + 28, CIY1 + 20), 6, 10: PAINT (CIX1 + 28, CIY1 + 20), 10
CIRCLE (CIX1 + 28, CIY1 + 25), 6, 0
LINE (CIX1 + 24, CIY1 + 25)-(CIX1 + 19, CIY1 + 20), 7: LINE -(CIX1 + 17, CIY1 + 24), 7
LINE (CIX1 + 32, CIY1 + 25)-(CIX1 + 37, CIY1 + 20), 7: LINE -(CIX1 + 40, CIY1 + 25), 7
LINE (CIX1 + 23, CIY1 + 22)-(CIX1 + 20, CIY1 + 25), 7
LINE (CIX1 + 33, CIY1 + 22)-(CIX1 + 36, CIY1 + 25), 7
LINE (CIX1 + 23, CIY1 + 22)-(CIX1 + 20, CIY1 + 25), 7
LINE (CIX1 + 23, CIY1 + 16)-(CIX1 + 18, CIY1 + 21), 7
LINE (CIX1 + 24, CIY1 + 25)-(CIX1 + 23, CIY1 + 30), 7
LINE (CIX1 + 32, CIY1 + 25)-(CIX1 + 34, CIY1 + 30), 7
LINE (CIX1 + 33, CIY1 + 16)-(CIX1 + 38, CIY1 + 21), 7
LINE (CIX1 + 27, CIY1 + 29)-(CIX1 + 27, CIY1 + 31), 4
LINE (CIX1 + 30, CIY1 + 29)-(CIX1 + 30, CIY1 + 31), 4
GET (CIX1 + 15, CIY1 + 10)-(CIX1 + 42, CIY1 + 40), Spiderpfr2%
RETURN

CopydotWeb:
T$ = CHR$(200) + CHR$(130) + CHR$(146) + CHR$(48) + CHR$(8) + CHR$(2) + CHR$(144) + CHR$(152) + CHR$(2)
LINE (CIX1 + 8, CIY1 + 15)-(CIX1 + 35, CIY1 + 25), 1, B
PAINT (CIX1 + 8, CIY1 + 15), T$
LINE (CIX1 + 31, CIY1 + 15)-(CIX1 + 35, CIY1 + 30), 8
GET (CIX1 + 8, CIY1 + 15)-(CIX1 + 36, CIY1 + 25), Web%
RETURN

CopydotSpike:
X1 = 10: Y1 = 15: CLS
LINE (X1, Y1)-(X1 + 5, Y1 - 10), 7: LINE -(X1 + 10, Y1), 7
LINE -(X1, Y1), 7: PAINT (X1 + 5, Y1 - 5), 7
LINE (X1 - 1, Y1)-(X1 + 4, Y1 - 10), 14
LINE (X1 - 1, Y1 + 1)-(X1 + 10, Y1 + 12), 7, BF
LINE (X1 - 1, Y1 + 1)-(X1 - 1, Y1 + 12), 14, BF
CIRCLE (X1 + 12, Y1 + 6), 5, 0: PAINT (X1 + 10, Y1 + 6), 0
LINE (X1 + 5, Y1 - 11)-(X1 + 5, Y1 - 10), 14, BF
GET (X1 - 5, Y1 - 12)-(X1 + 12, Y1 + 12), Spike%
RETURN

ObjectdotProperties:
LO$ = MID$(Object$(Length), 1, 1): HL = INSTR(Object$(Length), "@")
IF LO$ = "!" THEN Health = Health + 25: Ob = Ob + 1
IF LO$ = "$" THEN Fortune = Fortune + 20
IF LO$ = "%" THEN Health = Health + 200 + (200 * (HL = 64))
GOSUB Gamedotstatus: Objects = Objects + Ob: Ob = 0
Tallydotpnts:
Score = Score + Fortune: Fortune = 0
RETURN

Cleardotobject:
PUT (Sx, Sy), Clrobject%, PSET: RETURN

Cleardotplayer:
LINE (265, 145)-(345, 215), 0, BF
RETURN

Cleardotman:
PUT (X, Y), Clrobject%, PSET: RETURN

Cleardotarea:
LINE (Sx - 4, Sy)-(Sx + 23, Sy + 35), 0, BF
RETURN

Placedotwall:
IF T$ = "@" THEN PUT (1 + SpacerX, 6 + SpacerY), Wall3%, PSET: GOTO Skipdotover
IF T$ = "%" THEN PUT (1 + SpacerX, 6 + SpacerY), Wall2%, PSET: GOTO Skipdotover
COLOR 2: PUT (1 + SpacerX, 6 + SpacerY), Wall%, PSET
Skipdotover:
SpacerX = SpacerX + 30:
RETURN

Placedotdoor:
PUT (SpacerX, 36 + SpacerY - 36 + 6), Door%
SpacerX = SpacerX + 30
RETURN

PlacedotEdoor:
PUT (SpacerX, 36 + SpacerY - 36 + 6), EDoor%
SpacerX = SpacerX + 30
RETURN

Placedotkey:
PUT (SpacerX, 36 + SpacerY - 36 + 6), Keylock%, PSET
SpacerX = SpacerX + 30
RETURN

Placedotchest:
PUT (SpacerX, 36 + SpacerY - 36 + 6), Treasure%, PSET
SpacerX = SpacerX + 30
RETURN

Placedotring:
PUT (SpacerX, 36 + SpacerY - 36 + 6), Diamond%, PSET
SpacerX = SpacerX + 30
RETURN

Placedotgem:
PUT (SpacerX, 36 + SpacerY - 36 + 6), Gem%, PSET
SpacerX = SpacerX + 30
RETURN

Placedotweb:
PUT (SpacerX, 36 + SpacerY - 36 + 6), Web%, PSET
SpacerX = SpacerX + 30
RETURN

PlacedotSpike:
PUT (SpacerX + 5, SpacerY + 36), Spike%, PSET
SpacerX = SpacerX + 30
RETURN

Fin:
SCREEN 7: CLS : LOCATE 10, 15: PRINT "GAME": LOCATE 10, 20: PRINT "OVER"
IF slc <> 4 THEN LOCATE 13, 12: PRINT "SPACE - RESTART"
LOCATE 16, 15: PRINT "ESC - END"
WtdotKey:
T$ = INKEY$: IF T$ = "" THEN GOTO WtdotKey
IF T$ = CHR$(27) THEN CLS : SCREEN 0: PRINT "THANKS FOR PLAYING!": SYSTEM
IF slc <> 4 THEN IF INKEY$ = " " THEN GOTO Start
IF INKEY$ = "" THEN GOTO WtdotKey
GOTO WtdotKey

Checkdotkey:
i$ = INKEY$
SELECT CASE INKEY$
  CASE CHR$(27)
    CLS : SYSTEM
  CASE CHR$(32)
    GOTO Start

IF INKEY$ = "" THEN GOTO Checkdotkey
END SELECT
GOTO Checkdotkey

RoomdotCheck:
CLS : L = 0: LL = 0: SpacerX = 0: SpacerY = 0: Adv = 0: Wm = 0: Wm2 = 0
Eny = 0: Stringdotpnt = 0: Count = 0: EndotTally = 0
StartdotA = (12 * Rm) - 11: FinishdotA = 12 * Rm
IF Y > 400 THEN Y = 4
IF Y < 4 THEN Y = 400

Confirmdotrm:
GOSUB Copydotwall: GOSUB Cleardotplayer
FOR A = StartdotA TO FinishdotA: FOR B = 1 TO 20  'Height x Width
T$ = MID$(Maze$(A), B, 1)
IF T$ = " " OR T$ = "." OR T$ = "L" THEN GOSUB SkipdotX
IF T$ = "#" THEN GOSUB Placedotwall
IF T$ = "B" OR T$ = "S" OR T$ = "w" THEN GOSUB SkipdotX
IF T$ = "D" THEN GOSUB Placedotdoor
IF T$ = "E" THEN GOSUB PlacedotEdoor
IF T$ = "W" THEN GOSUB Placedotweb
IF T$ = "g" THEN GOSUB Placedotgem
IF T$ = "k" THEN GOSUB Placedotkey
IF T$ = "r" THEN GOSUB Placedotring
IF T$ = "s" THEN GOSUB PlacedotSpike
IF T$ = "t" THEN GOSUB Placedotchest
NEXT B: SpacerX = 0: SpacerY = SpacerY + 36: NEXT A: GOSUB Displaydotman
T = 0: L = 0: SpacerX = 0: SpacerY = 0
IF Rm = 0 OR Rm = 33 OR Rm = 64 THEN Adv = 500
IF Rm = 1 OR Rm = 5 OR Rm = 9 OR Rm = 17 OR Rm = 18 OR Rm = 19 THEN Adv = 300
IF Rm = 7 OR Rm = 8 OR Rm = 12 OR Rm = 16 OR Rm = 25 OR Rm = 28 THEN Adv = 400
IF Rm = 29 OR Rm = 31 OR Rm = 35 OR Rm = 39 OR Rm = 40 OR Rm = 41 THEN Adv = 500
IF Rm = 6 OR Rm = 10 OR Rm = 15 OR Rm = 20 OR Rm = 30 THEN Adv = 450
IF Rm = 42 OR Rm = 43 OR Rm = 44 THEN Adv = 450
IF Rm = 45 OR Rm = 46 OR Rm = 47 OR Rm = 54 OR Rm = 53 OR Rm = 55 THEN Adv = 500
IF Rm = 60 OR Rm = 61 OR Rm = 62 THEN Adv = 500
r = StartdotA: B = 1: GOSUB Gamedotstatus: RETURN

Gamedotstatus:
COLOR 2: LOCATE 29, 5: PRINT "LIVES:"; : COLOR 15: PRINT Lives;
COLOR 2: PRINT SPACE$(4); "SCORE:"; : COLOR 15: PRINT Score;
COLOR 2: PRINT SPACE$(5); "WEAPONS:"; : COLOR 15: PRINT Objects;
COLOR 2: PRINT SPACE$(4); "HEALTH: "; : COLOR 15: PRINT Health;
COLOR 2: PRINT SPACE$(4); "KEYS:"; : COLOR 15: PRINT Keys;
RETURN

Titledotscr:
SCREEN 12: CLS
W = (600 / 4) + 50: H = (400 / 4) + 40: CL = 1: Dmx = 1: Dmy = 1
CIX1 = 106: CIY1 = 279: Spx = 60: Spy = 243
SpacerX = Spx: SpacerY = Spy
Demo = TRUE: Plx% = CIX1 - 12: Ply% = CIY1 + (36 * 2)

Scandotmes:
COLOR 8: LOCATE 1, 1:
IF (T < 1 OR T > 0) THEN PRINT M1$
FOR A = 0 TO 133: FOR B = 0 TO 15

Rand:
RANDOMIZE TIMER
c = FIX(15 * RND(1)): IF c = 8 THEN GOTO Rand
cx = W - 190 + A * 5: cy = H + 20 + (B * 5) - 80
Pt = POINT(A, B)
IF Pt = 8 AND T < 1 THEN GOSUB CircdotFont: GOTO SkipdotPt
IF Pt = 8 AND T > 0 THEN GOSUB Message

SkipdotPt:
NEXT B, A: ht = CSRLIN - 1: LOCATE ht, 1: PRINT SPACE$(16)
T = T + 1: M1$ = "ANY KEY TO START"
IF T < 2 THEN GOTO Scandotmes
GOSUB Drawdotwall: PUT (Plx%, Ply%), Player%, PSET: A = 0: B = A: M = 5:
Aax = 30: BBx = 36: Playdotdemo = TRUE
LOCATE 10, 25: PRINT "Version 2.1: Trapped Forever"

Checkdotpress:
GOSUB Spiderdotroutine: GOSUB Ringdotglow: IF Playdotdemo THEN GOSUB Demodotroutine
IF INKEY$ = "" THEN GOTO Checkdotpress
CIX1 = 275: CIY1 = 145: CL = 0: Web = 5: Demo = FALSE
RingdotX = 0: RingdotY = 0: RETURN

Demodotroutine:
IF A = (30 * 3) THEN GOSUB Listdotmes
IF A = (30 * 5) THEN GOSUB Listdotmes2
IF A = (30 * 9) AND NOT (Unlockeddotdoor) AND Tr < 1 THEN GOSUB Listdotmes3
IF A = (30 * 12) AND Unlockeddotdoor < 1 AND Tr < 1 THEN GOSUB Listdotmes4: Unlockeddotdoor = TRUE
PUT (Plx% + A, Ply% - B), Player%, PSET
FOR H = 1 TO 1000: NEXT
PUT (Plx% + A, Ply% - B), Player%
IF (A < 30 * 12) THEN A = A + Aax
IF (A <= (30 * 9)) AND Tr THEN GOSUB Plotdotdemdotplr: GOSUB Listdotmes5: Playdotdemo = FALSE: RETURN
IF (A > (30 * 10) AND Tr) THEN A = A + Aax

IF Unlockeddotdoor AND NOT (Tr) THEN B = B + BBx: IF B >= (36 * 2) THEN GOSUB Plotdotdemdotplr: Aax = -30: Tr = 1: Unlockeddotdoor = FALSE: SLEEP 1
Null:
RETURN

Plotdotdemdotplr:
PUT (Plx% + A, Ply% - B), Player%, PSET: RETURN

Listdotmes:
GOSUB Plotdotdemdotplr: GOSUB Dmes1: RETURN

Listdotmes2:
GOSUB Plotdotdemdotplr: GOSUB Dmes2: RETURN

Listdotmes3:
GOSUB Plotdotdemdotplr: GOSUB Dmes3: RETURN

Listdotmes4:
GOSUB Plotdotdemdotplr: GOSUB Dmes4: RETURN

Listdotmes5:
GOSUB Plotdotdemdotplr: GOSUB Dmes5: RETURN

Dmes1:
A$ = "Avoid getting bit by the hanging spiders.": L = (80 - LEN(A$)) * .5
A$(2) = "and don't touch the flashing electric pulses."
COLOR 15: LOCATE 12, L: PRINT A$
L2 = (80 - LEN(A$(2))) * .5: COLOR 15: LOCATE 14, L2: PRINT A$(2): SLEEP 6
LOCATE 12, L: PRINT SPACE$(LEN(A$)):
LOCATE 14, L2: PRINT SPACE$(LEN(A$(2)))
RETURN

Dmes2:
LINE (Plx% + A - 4, Ply%)-(Plx% + A + 23, Ply% + 35), 0, BF
PUT (Plx% + A, Ply%), Player%
A$ = "Only the key you see in the same room as the door."
A$(2) = "will unlock that door."
L = (80 - LEN(A$)) * .5: COLOR 15: LOCATE 12, L: PRINT A$
L2 = (80 - LEN(A$(2))) * .5: COLOR 15: LOCATE 14, L2: PRINT A$(2): SLEEP 6
LOCATE 12, L: PRINT SPACE$(LEN(A$))
LOCATE 14, L2: PRINT SPACE$(LEN(A$(2)))
RETURN

Dmes3:
A$ = "Collect rings, gems and treasures on your journey."
L = (80 - LEN(A$)) * .5: COLOR 15: LOCATE 12, L: PRINT A$: SLEEP 6
LOCATE 12, L: PRINT SPACE$(LEN(A$)): RETURN

Dmes4:
A$ = "Now open the door with the key you found."
L = (80 - LEN(A$)) * .5: COLOR 15: LOCATE 12, L: PRINT A$: SLEEP 6
LOCATE 12, L: PRINT SPACE$(LEN(A$)):
LINE (Plx% + A - 4, (Ply%) - 36)-(Plx% + A + 23, (Ply% + 35) - 36), 0, BF
RETURN

Dmes5:
A$ = "Search for items and health potions in the treasure chests."
L = (80 - LEN(A$)) * .5: COLOR 15: LOCATE 12, L: PRINT A$: SLEEP 6
LOCATE 12, L: PRINT SPACE$(LEN(A$)):
RETURN

CircdotFont:
CIRCLE (cx, cy), 3, c: PAINT (cx, cy), c: CIRCLE (cx, cy), 1, 14
PSET (cx, cy), 0
RETURN

Message:
msx = W - 80 + A * 3: msy = H + 280 + B * 2
CIRCLE (msx, msy), 2, CL
Inc = Inc + 1: IF FIX(Inc / 45) = Inc / 45 THEN CL = CL + 1
IF CL = 8 THEN CL = CL + 1
RETURN

Drawdotwall:
GOSUB Demodotmaze: FOR A = 1 TO 5: FOR L = 1 TO 15
S$ = MID$(A$(A), L, 1)
IF S$ = "#" THEN PUT (SpacerX, SpacerY), Wall%, PSET
IF S$ = "t" THEN PUT (SpacerX, SpacerY), Treasure%, PSET
IF S$ = "D" THEN PUT (SpacerX, SpacerY), Door%, PSET
IF S$ = "k" THEN PUT (SpacerX, SpacerY), Keylock%, PSET
IF S$ = "r" THEN RingdotX = SpacerX: RingdotY = SpacerY: PUT (SpacerX, SpacerY), Diamond%, PSET
IF S$ = "g" THEN PUT (SpacerX, SpacerY), Gem%, PSET
IF S$ = "W" THEN PUT (SpacerX, SpacerY), Web%, PSET
IF (S$ = "B" OR S$ = "S") THEN Spx = SpacerX: Spy = SpacerY - 6: GOSUB Spiderdotroutine
SpacerX = SpacerX + 30
NEXT L: SpacerX = 60: SpacerY = SpacerY + 36: NEXT A
SpacerX = 60: SpacerY = 0
RETURN

Menulist:
CLS : Ky$(1) = "ARROW KEYS IN USE": Ky$(2) = "NUMPAD IN USE" + SPACE$(4)
Pntr = 190: SvspX = Spx: SvspY = Spy: slc = 1
Indent = 30: Dnx = 182: Bot = 410
'LINE (120, 100)-(490, 320), 7, BF
FOR O = 120 TO 490 STEP 2.1: LINE (O, 100)-(O, Bot), 8: NEXT
LINE (120 + Indent, 100 + Indent)-(490 - Indent, Bot - Indent), 7, BF
LINE (120 + Indent + 10, 100 + Indent + 10)-(490 - Indent - 10, Bot - Indent - 10), 0, BF
LINE (120 + Indent, 100 + Indent)-(490 - Indent, 320 - Indent), 14, B
LINE (120 + Indent + 1, 100 + Indent + 1)-(490 - Indent - 1, Bot - Indent - 1), 4, B
CIRCLE (190, 182), 6, 4: PAINT (190, 182), 4: CIRCLE (190, 182), 7, 14

Options:
COLOR 14
LOCATE 10, 26: PRINT "Use SPACE-BAR to select": COLOR 9
LOCATE 12, 28: PRINT "HELP (Game tips)"
LOCATE 14, 28: PRINT "GAME SPEED"
LOCATE 16, 28: PRINT Ky$(Kytapfl + 1)
LOCATE 18, 28: PRINT "ABORT THE GAME"
'LINE (120 + Indent + 10, 262 + Indent)-(490 - Indent - 10, Bot - Indent - 10), 15, BF
FOR O = 120 + Indent + 10 TO 490 - Indent - 10 STEP 2
LINE (O, 262 + Indent)-(O, Bot - Indent - 10), 15: NEXT
COLOR 5: LOCATE 22, 26: PRINT "Press ESC to return to game"

OptiondotSel:
T$ = INKEY$: IF T$ = "" THEN GOTO OptiondotSel
IF T$ = CHR$(0) + "P" THEN GOSUB ErasedotPntr: Dnx = Dnx + 30: IF Dnx > 272 THEN Dnx = 272
IF T$ = CHR$(0) + "H" THEN GOSUB ErasedotPntr: Dnx = Dnx - 30: IF Dnx < 182 THEN Dnx = 182
IF T$ = CHR$(27) THEN GOSUB RoomdotCheck: Spx = SvspX: Spy = SvspY: RETURN
  IF T$ = CHR$(32) THEN
     IF slc = 1 THEN
        GOSUB Helpdotscr: GOTO Menulist
     ELSE
        IF slc = 2 THEN
           T$ = "": GOSUB Alterdotdelay: GOTO Menulist
        ELSE
           IF slc = 3 THEN
              Kytapfl = Kytapfl + 1: IF Kytapfl > 1 THEN Kytapfl = 0
              Actiondotkey = (Kytapfl)
              GOTO Options
           ELSE
              IF slc = 4 THEN
                 CLS : GOTO Fin
              END IF
           END IF
        END IF
     END IF
  END IF
GOSUB MovedotPntr
GOTO OptiondotSel

MovedotPntr:
slc = INT(Dnx / 30) - 5
CIRCLE (190, Dnx), 6, 4: PAINT (190, Dnx), 4: CIRCLE (190, Dnx), 7, 14
RETURN

ErasedotPntr:
IF Dnx >= 182 OR Dnx <= 242 THEN CIRCLE (190, Dnx), 7, 0: PAINT (190, Dnx), 0
RETURN

Helpdotscr:
CLS : Far = 600: LINE (0, 0)-(Far, 478), 15, BF
LINE (40, 0)-(40, 478), 12, B: c = 0
FOR E = 0 TO 478 STEP 15.2: LINE (0, E)-(Far, E), 3: NEXT
CIRCLE (15, 10), 7, c: PAINT (16, 11), c
CIRCLE (15, 140), 7, c: PAINT (16, 141), c: CIRCLE (15, 270), 7, c
PAINT (16, 271), c: CIRCLE (15, 400), 7, c: PAINT (16, 401), c
COLOR 6: LOCATE 5, 17: PRINT "You must navigate through a 64-room maze,"
LOCATE 7, 17: PRINT "all while avoiding dangling spiders, electric shocks"
LOCATE 9, 17: PRINT "and large knives that move up from the floor."
LOCATE 12, 17: PRINT "A word of advice: Time yourself when passing beyond"
LOCATE 14, 17: PRINT "spiders, electric shocks and moving knives."
LOCATE 17, 17: PRINT "Also make a hand-made map of the maze as you start"
LOCATE 19, 17: PRINT "advancing further and further into the labyrinth."
LOCATE 21, 17: PRINT "Finally, take advantage of the treasure chests and"
LOCATE 23, 17: PRINT "the helpful items inside."
COLOR 2: LOCATE 26, 23: PRINT "PRESS SPACE-BAR TO RETURN TO MENU"
Holddothelp:
T$ = INKEY$: IF T$ = "" THEN GOTO Holddothelp
IF T$ = CHR$(32) THEN RETURN
GOTO Holddothelp


Demodotmaze:
A$(1) = "###############"
A$(2) = "#    r   t    #"
A$(3) = "####W########D#"
A$(4) = "#   S k   g   #"
A$(5) = "###############"
RETURN

Alterdotdelay:
SCREEN 12: CLS
LINE (0, 0)-(600, 300), 8, BF: LINE (0, 301)-(600, 315), 4, BF
FOR L = 2 TO 598 STEP 2.8: LINE (L, 302)-(L, 314), 1: NEXT
FOR L = 1 TO 598 STEP 2.36: LINE (L, 1)-(L, 298), 7: NEXT
CPU = 106: T = 1: c = 1
COLOR 15: LOCATE 10, 22: PRINT "GAME DELAY PERFORMANCE METER"
COLOR 2: LOCATE 22, 2: PRINT "USE THE LEFT & RIGHT ARROW KEYS TO SET A DELAY CHANNEL ";
PRINT "FOR THIS GAME."
LOCATE 23, 2: PRINT "YOU WILL THEN SEE A NUMERICAL COUNTER INCREMENTING ";
PRINT "OR DECREMENTING."
LOCATE 24, 2: PRINT "WHEN YOU HAVE THE DELAY YOU NEED, PRESS THE ";
COLOR 14: PRINT "SPACE BAR "; : COLOR 2: PRINT "TO EXIT."
LOCATE 25, 2: PRINT "USE CHANNEL "; : COLOR 14: PRINT "0 ";
COLOR 2: PRINT "FOR FASTEST SPEED."
LINE (94, 100 + 80 - 6)-(456, 150 + 80 + 6), 0, B
LINE (95, 100 + 80 - 5)-(455, 150 + 80 + 5), 9, BF
LINE (100, 100 + 80)-(450, 150 + 80), 14, BF
LINE (107, 190)-(107, 220), 6, BF
'Counter
LINE (240, 245)-(300, 290), 0, BF: LINE (239, 244)-(301, 291), 15, B
LINE (241, 246)-(299, 289), 6, B: LINE (243, 246)-(298, 288), 6, B
GOSUB Cntr

Pskey:
i$ = INKEY$: IF i$ = "" THEN GOTO Pskey
IF i$ = CHR$(0) + "M" THEN Flg = 1: T = 1: SL = 6: GOSUB DrwMtr: GOSUB Cntr: CPU = CPU + T: IF CPU > 443 THEN CPU = 443
IF i$ = CHR$(0) + "K" THEN T = -1: SL = 14: GOSUB DrwMtr: CPU = CPU + T: GOSUB DrwMtr: GOSUB Cntr: IF CPU < 105 THEN CPU = 105
IF i$ = CHR$(27) THEN GOTO BegdotGame
IF i$ = CHR$(32) THEN RETURN
GOTO Pskey

Cntr:
c = c + T
IF c < 1 THEN c = 1: Flg = 0
IF c > 340 THEN c = 340
COLOR 7: LOCATE 17, 32: PRINT c - 1;
RETURN

BegdotGame:
IF c - 1 < 2 THEN Flg = 0: CPU = 0
RETURN

DrwMtr:
LINE (CPU, 190)-(CPU, 220), SL, BF
RETURN

Builddotmazes:
'M:1   Maze 1
Maze$(1) = "######W#W#W#########"
Maze$(2) = "#t### S B S    #####"
Maze$(3) = "#t# # # ######   LL#"
Maze$(4) = "#t# # # ###### ###W#"
Maze$(5) = "#t# # # #         S."
Maze$(6) = "#r# # # # # ###W####"
Maze$(7) = "#g#t# # # #    SLk ."
Maze$(8) = "#t# # # # ##########"
Maze$(9) = "# # # # # #      # ."
Maze$(10) = "# W # # # ########W#"
Maze$(11) = "# B D # #         B."
Maze$(12) = "#######.############"

'M:9     Maze 2
Maze$(13) = "#######.############"
Maze$(14) = "#t #  # ####W#W###W#"
Maze$(15) = "#r #  # # # B B ttS."
Maze$(16) = "#r #  # # ##W#######"
Maze$(17) = "#  #  # # #kB      ."
Maze$(18) = "#  #  # # ##########"
Maze$(19) = "#  #  # #          ."
Maze$(20) = "#  #  # #######W####"
Maze$(21) = "#  #  # D    #rB   ."
Maze$(22) = "#  #  # #### #######"
Maze$(23) = "#  #  # #          ."
Maze$(24) = "#.##.##.######.#####"

'M:17
Maze$(25) = "#.##.##.######.#W###"
Maze$(26) = "#  #  # #gtrr   Brk#"
Maze$(27) = "#  #  # ############"
Maze$(28) = "#  #  #            ."
Maze$(29) = "#  #  ##############"
Maze$(30) = "#  #               #"
Maze$(31) = "#  #####D######### #"
Maze$(32) = "#  ####W W#     ## #"
Maze$(33) = "#  ##ttBgBt#    ## #"
Maze$(34) = "# ################ #"
Maze$(35) = "# #                ."
Maze$(36) = "#.#.################"

'M:25
Maze$(37) = "#.#.################"
Maze$(38) = "#                  ."
Maze$(39) = "# ##################"
Maze$(40) = "#                  ."
Maze$(41) = "# ################W#"
Maze$(42) = "#                 B."
Maze$(43) = "##W###W#############"
Maze$(44) = "#tBtttB    tt #    ."
Maze$(45) = "#rB r B       # ####"
Maze$(46) = "#######D##.W### ##W#"
Maze$(47) = "# rr  # #  B  # #kB."
Maze$(48) = "##..###.##.## #.####"

'M:33
Maze$(49) = "##..###.##.## #.####"
Maze$(50) = "#     # #  # k#    ."
Maze$(51) = "#W# ### ###W###W####"
Maze$(52) = "#B         B   B   ."
Maze$(53) = "# ##### ##### # ####"
Maze$(54) = "# #   # #   # # #  #"
Maze$(55) = "# #   # # r   # #  #"
Maze$(56) = "# #   # #   # # #  #"
Maze$(57) = "# #   # W#### # #  #"
Maze$(58) = "# #   # B     # #  #"
Maze$(59) = "#D#   # ##### # #  #"
Maze$(60) = "#.#####.#####.#.####"

'M:41
Maze$(61) = "#.#####.#####.#.####"
Maze$(62) = "# #   # #   # W##  #"
Maze$(63) = "# # t # #   # Bk#  #"
Maze$(64) = "# #   # #   #####  #"
Maze$(65) = "# #   # # ######## #"
Maze$(66) = "# # r # # #      # #"
Maze$(67) = "# #   # # # rrr  # #"
Maze$(68) = "# #   # # #      # #"
Maze$(69) = "# #     # # ttt  # #"
Maze$(70) = "# ############## #W#"
Maze$(71) = "#  D              B."
Maze$(72) = "####.###############"

'M:49
Maze$(73) = "####.#######W###W###"
Maze$(74) = "#  # #    # B   B  #"
Maze$(75) = "#  # #    # ### #  #"
Maze$(76) = "#  # #    # # # #  #"
Maze$(77) = "#  # #    # # # #  #"
Maze$(78) = "#  # ###  # # # #r #"
Maze$(79) = "#  #   #  # # # #  #"
Maze$(80) = "#  #   #  # # # # t#"
Maze$(81) = "#  # k #  # # # #  #"
Maze$(82) = "#  #####  # # # #W##"
Maze$(83) = "#   #r#   #D  #  B ."
Maze$(84) = "#####.#####.######.#"

'M:57
Maze$(85) = "#####.#####.######.#"
Maze$(86) = "#  t# #   # #    # ."
Maze$(87) = "#   # #   # #    ###"
Maze$(88) = "# ### ##### ##W#####"
Maze$(89) = "#           #kB L  ."
Maze$(90) = "# #######W##########"
Maze$(91) = "#        B         ."
Maze$(92) = "# ##################"
Maze$(93) = "# ## rr ggg ttt tt#."
Maze$(94) = "# #W ggg   tt  rr###"
Maze$(95) = "# DS g ggg ttt ttg #"
Maze$(96) = "####################"

'M:2
Maze$(97) = "####################"
Maze$(98) = "##WW##############W#"
Maze$(99) = "#kBS              SD"
Maze$(100) = "###W               #"
Maze$(101) = ".  B               ."
Maze$(102) = "#####W######W#######"
Maze$(103) = ".    B      B ttt# ."
Maze$(104) = "################## #"
Maze$(105) = ". #r             # #"
Maze$(106) = "################.# #"
Maze$(107) = ".                  #"
Maze$(108) = "####################"

'M:10
Maze$(109) = "####################"
Maze$(110) = "###W#######W######W#"
Maze$(111) = ".  B       S      S."
Maze$(112) = "########### ########"
Maze$(113) = ".         # #      ."
Maze$(114) = "######### # #      #"
Maze$(115) = ".       # #r#  ###W#"
Maze$(116) = "####### # ###  #  B."
Maze$(117) = ".     # #      #   #"
Maze$(118) = "##### # ########   #"
Maze$(119) = ".   # #            #"
Maze$(120) = "##.##.######.#######"

'M:18
Maze$(121) = "##.##.######.#####W#"
Maze$(122) = "#ggg# #   ## #    B."
Maze$(123) = "##W## #   ## #####t#"
Maze$(124) = "D B   #   ##k# r ###"
Maze$(125) = "####  ##   ### r r #"
Maze$(126) = "#  ##  ##    ##    ."
Maze$(127) = "#   ##  ## #########"
Maze$(128) = "#    ##  ##        ."
Maze$(129) = "#     # # # ##W## ##"
Maze$(130) = "####### # # #rB   W#"
Maze$(131) = ".     # # # #rB   B."
Maze$(132) = "#######.###.#.######"

'M:26
Maze$(133) = "#######.###.#.####W#"
Maze$(134) = ".   rr# ##  # ttt#B."
Maze$(135) = "####### ##  # rr # #"
Maze$(136) = ".   rr# ##  ###### #"
Maze$(137) = "######  ##  # rrr t#"
Maze$(138) = ".  #  D##   #### ###"
Maze$(139) = "#  #  #        #   #"
Maze$(140) = ".  #  #### ####W ###"
Maze$(141) = "####    ## #   B #k#"
Maze$(142) = "#W####  ## # #####L#"
Maze$(143) = ".B      ## #     # #"
Maze$(144) = "#######.##.#.#####.#"

'M:34
Maze$(145) = "#######.##.#.#####.#"
Maze$(146) = ".          # # #t# #"
Maze$(147) = "#######.#### # #t# #"
Maze$(148) = ".   L     #  # #r# #"
Maze$(149) = "### ##WW#D#  # # # #"
Maze$(150) = "# # # BB  # B# # # #"
Maze$(151) = "# # #   # # k# # # #"
Maze$(152) = "# # #  ####### # # #"
Maze$(153) = "# # #t #       # # ."
Maze$(154) = "# # #g #  W##### # #"
Maze$(155) = "# # #g #  B      # #"
Maze$(156) = "###.####.#########.#"

'M:42
Maze$(157) = "###.####.#########.#"
Maze$(158) = "# # # #  # #   #   #"
Maze$(159) = "# # # #  # # # # # #"
Maze$(160) = "# # # #t # # # # # #"
Maze$(161) = "# # # #  # # # # # #"
Maze$(162) = "# # # # r# # # # # #"
Maze$(163) = "# # # #  # # # # # #"
Maze$(164) = "# # # #  W## # # # #"
Maze$(165) = "# #k# #  B   #   # #"
Maze$(166) = "#W###############W #"
Maze$(167) = ".B  D            B #"
Maze$(168) = "### ############.###"

'M:50
Maze$(169) = "###.############.###"
Maze$(170) = "# # #         ## # #"
Maze$(171) = "# #L#       ##   # #"
Maze$(172) = "# # #     ##    ## #"
Maze$(173) = "# #k#   #W    ###  #"
Maze$(174) = "# ### ## B  ##  ##W#"
Maze$(175) = "#   ##    ## # t#tB."
Maze$(176) = "#  ##   ##   #L ## #"
Maze$(177) = "# ##  ##     #tt## #"
Maze$(178) = "##   ##  W#### L## #"
Maze$(179) = ".L #     Brr  tt##D#"
Maze$(180) = "##################.#  "

'M:58
Maze$(181) = "#W################.#"
Maze$(182) = ".B #             # #"
Maze$(183) = "# k############### #"
Maze$(184) = "#W#                #"
Maze$(185) = ".B  ############## #"
Maze$(186) = "### #              #"
Maze$(187) = ". # # ##############"
Maze$(188) = "# # ##############W#"
Maze$(189) = ". #               B."
Maze$(190) = "# ################W#"
Maze$(191) = "#                 BD"
Maze$(192) = "####################"

'M:3
Maze$(193) = "####################"
Maze$(194) = "####################"
Maze$(195) = ".                  #"
Maze$(196) = "######W###W#W##  # ."
Maze$(197) = ". L   S   S Sk#  # #"
Maze$(198) = "###############  # #"
Maze$(199) = ".             #  # #"
Maze$(200) = "########### # #  # #"
Maze$(201) = "#r r r      # #  # #"
Maze$(202) = "#  g  t     # #  # #"
Maze$(203) = "#           # #  #D#"
Maze$(204) = "########.####.#.##.#"

'M:11
Maze$(205) = "########.####.#.##.#"
Maze$(206) = "#######  Lt # #  # #"
Maze$(207) = ".     # Lt L# #  # #"
Maze$(208) = "#W### ####W## #  # #"
Maze$(209) = ".SW       B## #  # #"
Maze$(210) = "#kBs######g## #r # #"
Maze$(211) = "######ggt# ## #  # #"
Maze$(212) = ".    #trt# ## #  # #"
Maze$(213) = "#### #rrt# W# # r#D#"
Maze$(214) = "#tW# #   W B# #### #"
Maze$(215) = "# B  #   BsS  #    #"
Maze$(216) = "####.##########.##.#"

'M:19
Maze$(217) = "####.##########.##.#"
Maze$(218) = ".  # #           # ."
Maze$(219) = "## # # ####WW#W# ###"
Maze$(220) = "## # # # D BBsB    ."
Maze$(221) = "## # # # ##W########"
Maze$(222) = "## # # # #kBttL ttt#"
Maze$(223) = "## # # # # LLL LttL#"
Maze$(224) = ".    # # #  L  ttLt#"
Maze$(225) = "###  # # #   L LLtL#"
Maze$(226) = "#r#  # # # L  L   L#"
Maze$(227) = ". #  # # #L L   L  ."
Maze$(228) = "#.####.#.###########"

'M:27
Maze$(229) = "#.####.#.##W#W######"
Maze$(230) = ". ###  # #LStBt#rrr#"
Maze$(231) = "# #   ## # LLLL#   #"
Maze$(232) = "# # #### # r  LWrr #"
Maze$(233) = "# # #    #L  r S   #"
Maze$(234) = "# # # ###W L  L#rrr#"
Maze$(235) = "# # # #ttB r   #   #"
Maze$(236) = "# # # # ######## ###"
Maze$(237) = "# # # # r  g  ## # ."
Maze$(238) = "# # # #  r r t## # #"
Maze$(239) = "# # # # g  t  ## # #"
Maze$(240) = "#.#.#.##########.#.#"

'M:35
Maze$(241) = "#.#.#.##########.#.#"
Maze$(242) = "# #L# #          # #"
Maze$(243) = "# #t# ####W##### # #"
Maze$(244) = "# #g#     B        #"
Maze$(245) = "# ##################"
Maze$(246) = "# ##############W###"
Maze$(247) = "#               B  #"
Maze$(248) = "##W############### #"
Maze$(249) = ". B      rrLrrr k# #"
Maze$(250) = "###W############## #"
Maze$(251) = "#  B              D."
Maze$(252) = "##.#################"

'M:43
Maze$(253) = "##.#################"
Maze$(254) = "## ######W#W########"
Maze$(255) = "## #     SsS       ."
Maze$(256) = "## # ###W#########W#"
Maze$(257) = "## # #kgSs     L  S."
Maze$(258) = "## # ###############"
Maze$(259) = "## #               ."
Maze$(260) = "## #################"
Maze$(261) = "## #    sL        L#"
Maze$(262) = "## # #W#####W##### #"
Maze$(263) = "## # DS     Ss E## #"
Maze$(264) = "##.###############.#"

'M:51
Maze$(265) = "##.###########W###.#"
Maze$(266) = "## #          S  Ds#"
Maze$(267) = "## # ###############"
Maze$(268) = "## #               ."
Maze$(269) = "## ##W#####W###### #"
Maze$(270) = "#W   B     B     # #"
Maze$(271) = ".B #  #####W##L  # #"
Maze$(272) = "####  #    B # L#  #"
Maze$(273) = "#     # #### #k#  ##"
Maze$(274) = "# ttt # #  # ### #W#"
Maze$(275) = "#     # #        #B."
Maze$(276) = "#######.# ########.#"

'M:59
Maze$(277) = "#######.# W#######.#"
Maze$(278) = "#kttt # # S r t g# #"
Maze$(279) = "# tt L# ########D# #"
Maze$(280) = "# ttt # #tttttttt# #"
Maze$(281) = "#L L  # ########## #"
Maze$(282) = "#     #            #"
Maze$(283) = "###.##############W#"
Maze$(284) = "#      W       #  B."
Maze$(285) = ".  #   B  #        #"
Maze$(286) = "####################"
Maze$(287) = ".                  ."
Maze$(288) = "####################"

'M:4
Maze$(289) = "####################"
Maze$(290) = "####################"
Maze$(291) = "#######W###W####WW##"
Maze$(292) = ".      St# S    BBk."
Maze$(293) = "# #W###### #########"
Maze$(294) = "# .B tttt  LtLLtttt#"
Maze$(295) = "# #L ttt L  ttttLtt."
Maze$(296) = "# #  L L L LL LL  L#"
Maze$(297) = "# #L   L   LL  LL  ."
Maze$(298) = "# #####W##########W#"
Maze$(299) = "#     sS D        B."
Maze$(300) = "#########.##########"

'M:12
Maze$(301) = "#########.##########"
Maze$(302) = "#       # #        ."
Maze$(303) = "# ####### # ########"
Maze$(304) = "#         # ###W####"
Maze$(305) = "#L##### # # #ttS   ."
Maze$(306) = "# #     # # #####W##"
Maze$(307) = "# # ##### # # tt S ."
Maze$(308) = "#L# ###W# # # tt ###"
Maze$(309) = "#   L sB# # #      #"
Maze$(310) = "# ##### # # # rrrr #"
Maze$(311) = "#S     k# #D# rrrr #"
Maze$(312) = "#.#######.#.########"

'M:20
Maze$(313) = "#.#######.#.#W######"
Maze$(314) = ".     # # #  Btttts."
Maze$(315) = "### # # # # #WW#####"
Maze$(316) = ". # # # # #D BBLLtt#"
Maze$(317) = "# # # # # # # Bt##W#"
Maze$(318) = "# # # # # # #LWW#kS."
Maze$(319) = "# # # # # # #LBS####"
Maze$(320) = "# # # # # # #ttttt #"
Maze$(321) = "# # # # # # # tttt #"
Maze$(322) = "# # # # # # # tttt #"
Maze$(323) = ". # # # # # # tttt #"
Maze$(324) = "#.#.#.###.#.######.#"

'M:28
Maze$(325) = "#.#.#.###.#.######.#"
Maze$(326) = "#L# # #   # DrLrr#g#"
Maze$(327) = "# # #S# ### #rrr##W#"
Maze$(328) = "#L# ### #t# # Lr#kS."
Maze$(329) = "# # # W #t# #S L####"
Maze$(330) = "#L#r# B rt# #BBL   #"
Maze$(331) = "#t# # ##### #Lttt###"
Maze$(332) = "##### #     #LtLt# ."
Maze$(333) = ".  g# # #####LtLt# #"
Maze$(334) = "####W # #tttLttLt# #"
Maze$(335) = "#tttB # #gLtttLtt# #"
Maze$(336) = "#######.##########.#"

'M:36
Maze$(337) = "#######.########W#.#"
Maze$(338) = "# r r   #       Ss #"
Maze$(339) = "#  t  # # ######W# #"
Maze$(340) = "#####W# # #     Bs #"
Maze$(341) = "#    B  # # ###### #"
Maze$(342) = "# ####### # #ktgt# #"
Maze$(343) = "# #       # #L Lt# #"
Maze$(344) = "# #    #  # #r L # #"
Maze$(345) = "# #W## #  # #L   # #"
Maze$(346) = "# sS # #  #    L # #"
Maze$(347) = ".###D# #  # #  L # #"
Maze$(348) = "####.# ####.####.#.#"

'M:44
Maze$(349) = "####.# ####.####.#.#"
Maze$(350) = "#W## # #gg# #tt# #r#"
Maze$(351) = ".Ss  # #tt# #tt#####"
Maze$(352) = "#W#### #Lt# # ttL t#"
Maze$(353) = ".Bs    #tt#k#L   t #"
Maze$(354) = "#W######tt###  BS  #"
Maze$(355) = ".S###ttttL  L tttt #"
Maze$(356) = "# ###tttt L   tttt #"
Maze$(357) = "# ###rrrLr  L rrr  #"
Maze$(358) = "# #WW   rrrr  L  L #"
Maze$(359) = "# DSBrrrLrrL rrrr  #"
Maze$(360) = "#.##################"

'M:52
Maze$(361) = "#.W#################"
Maze$(362) = "# Ss               ."
Maze$(363) = "####W#######D#####W#"
Maze$(364) = ".k# B tttttL #  s B."
Maze$(365) = "###L LL L L  # ### #"
Maze$(366) = "# LL Ltttt   # ### #"
Maze$(367) = "#  L L LL L L# # # #"
Maze$(368) = "#rrLL L ttttL# # # #"
Maze$(369) = "#  rr  rr L L# # # #"
Maze$(370) = "#W############ # # #"
Maze$(371) = ".Sss             # #"
Maze$(372) = "##################.#"

'M:60
Maze$(373) = "################W#.#"
Maze$(374) = "#              sB  #"
Maze$(375) = "# ################L#"
Maze$(376) = "# #ttLL LL L LL L  ."
Maze$(377) = "# #W##############W#"
Maze$(378) = "# sS             sS."
Maze$(379) = "#W################W#"
Maze$(380) = ".B       L        B."
Maze$(381) = "####################"
Maze$(382) = "#W################W#"
Maze$(383) = ".S                S."
Maze$(384) = "####################"

'M:5 (5th row over)
Maze$(385) = "##################W#"
Maze$(386) = "##################S."
Maze$(387) = "####t t rrrrt##### #"
Maze$(388) = ".    B  L r LW##   #"
Maze$(389) = "#   B   L    B   L #"
Maze$(390) = "############### W###"
Maze$(391) = ".#g g         #sB#t#"
Maze$(392) = "############# ## # #"
Maze$(393) = ".  L rr    rr L# # #"
Maze$(394) = "################ # #"
Maze$(395) = ".      L t  ttk# D #"
Maze$(396) = "##################.#"

'M:13
Maze$(397) = "#W################.#"
Maze$(398) = ".B               . #"
Maze$(399) = "################## #"
Maze$(400) = "#W##############W# #"
Maze$(401) = ".S              B  #"
Maze$(402) = "#W###############WD#"
Maze$(403) = ".B L L LL L L LL S #"
Maze$(404) = "# tttttt L ttLtt ###"
Maze$(405) = "#L LL rrrr  rrL  #k#"
Maze$(406) = "#  rrLrr L rrrr L# #"
Maze$(407) = "# LL L L  L   L  #L#"
Maze$(408) = "################.#.#"

'M:21
Maze$(409) = "#W##############.#.#"
Maze$(410) = ".Sk# ttttt  LLt#D# #"
Maze$(411) = "####LLLLttttL##LL# #"
Maze$(412) = "#tttrrrLLLrrLrrL # #"
Maze$(413) = "##W#############W# #"
Maze$(414) = ". Ss           sS  #"
Maze$(415) = "# ################ #"
Maze$(416) = "# #LtLtt tttLL LL# #"
Maze$(417) = "# # LLL  LLLLL L # #"
Maze$(418) = "# #  ttttLLtttt L# #"
Maze$(419) = "# #L LLL   LLL tL# #"
Maze$(420) = "#.#.##############.#"

'M:29
Maze$(421) = "#.#.##############.#"
Maze$(422) = "# #              # #"
Maze$(423) = "# # ############ # #"
Maze$(424) = ". # #         t# # #"
Maze$(425) = "#L# # ## ##  tt# # #"
Maze$(426) = "# # #  # ## #### # #"
Maze$(427) = "# # #  # ## #    # #"
Maze$(428) = ". # #  # ## # ##W# #"
Maze$(429) = "### #  # ## # # Ss #"
Maze$(430) = "#   #  # ## # # ##W#"
Maze$(431) = "#   D  # ## # # #kS#"
Maze$(432) = "#####.##.##.#.#.##.#"

'M:37
Maze$(433) = "#####.##.##.#.#.##.#"
Maze$(434) = "#rrt#  # ## # # #  #"
Maze$(435) = "#LrL#  # ## # # #B #"
Maze$(436) = "#rr #  # ## # # #  #"
Maze$(437) = "# LL #D# ## # # # B#"
Maze$(438) = "# LLLL # ## # # #  #"
Maze$(439) = "# tLt  # ## # # #B #"
Maze$(440) = "#tLLLLL# ## # # #  #"
Maze$(441) = "#tttLLL# ## # # # B#"
Maze$(442) = "#LL###L# ## # # #  #"
Maze$(443) = "# t#k#t# ## # # #  #"
Maze$(444) = "#.##.###.##.#.#.##.#"

'M:45
Maze$(445) = "#.##.###.##.#.#.##.#"
Maze$(446) = "#  # # # ## # # #  #"
Maze$(447) = "#  # # # ## # # #  #"
Maze$(448) = "#  # # # ## # # #  #"
Maze$(449) = "#  # # # ## # # W# #"
Maze$(450) = "#  # # # ## # # Ss #"
Maze$(451) = "#tt# # # ## # #### #"
Maze$(452) = "#tt# # # ## # #### #"
Maze$(453) = "#tt# # # ## # #### #"
Maze$(454) = "#tt# # # ## # #W## #"
Maze$(455) = "#tt# # # ##L#  Ss  #"
Maze$(456) = "####.###.##.######.#"

'M:53
Maze$(457) = "#W##.###.##.######.#"
Maze$(458) = ".Ss  D #k # #rrrr  #"
Maze$(459) = "#### # #### #rrt   #"
Maze$(460) = ".  # # tt #r#rr    #"
Maze$(461) = "#  # #   L#r#tttt  #"
Maze$(462) = "#  # # tt #r#tttt  #"
Maze$(463) = "#  # # L  #r#tttt  #"
Maze$(464) = "# r# # tt #r#t L##W#"
Maze$(465) = "# r# #L L #r#ttt#rS."
Maze$(466) = "#r # # t L#W#   ##W#"
Maze$(467) = "#r # # L  sSs     B."
Maze$(468) = "####.###############"

'M:61
Maze$(469) = "##W#.###############"
Maze$(470) = "#kB# ###############"
Maze$(471) = "#L #      L       L#"
Maze$(472) = ".  ############### #"
Maze$(473) = "#W### tttL  Lrrr # #"
Maze$(474) = ".Bs #Lttt LL ttt # #"
Maze$(475) = "#W# # tttL  Lttt # #"
Maze$(476) = ".S# #L L  LLL L  # #"
Maze$(477) = "# # #L L L L L   # #"
Maze$(478) = "# # #######WD###W# #"
Maze$(479) = ". #       sS   sS  #"
Maze$(480) = "####################"

'M:6
Maze$(481) = "####################"
Maze$(482) = ". ########W#W#W#W###"
Maze$(483) = "# # D #ks B S S B  #"
Maze$(484) = "# # # ############ #"
Maze$(485) = "# # # gLtgtttggg # #"
Maze$(486) = "# # # rttgrrggtt # #"
Maze$(487) = "# # # LgtggLttttg# #"
Maze$(488) = "# # # LtttLLtttr # #"
Maze$(489) = "# # # rttgLLgLttr# #"
Maze$(490) = "# # ############## #"
Maze$(491) = "# #              # #"
Maze$(492) = "#.#.##############.#"

'M:14
Maze$(493) = "#.#.##W#W#W####W##D#"
Maze$(494) = "# # # B S S   LS # #"
Maze$(495) = "# # # # # # t t# # #"
Maze$(496) = "# #L# # # #tLtL#L# #"
Maze$(497) = "# # # # # #LL t# # #"
Maze$(498) = "# # # # # #LL L# # #"
Maze$(499) = "# # # # # #tLLL# #L#"
Maze$(500) = "# # # # # #LLLL# # #"
Maze$(501) = "# #L# # # #LttL# # #"
Maze$(502) = "# # # # ##k s  W # #"
Maze$(503) = "# # # # ## ### S # #"
Maze$(504) = "#.#.#.#.##.###.#.#.#"

'M:22
Maze$(505) = "#.#.#.#.##.###.#.#.#"
Maze$(506) = "# # # ###gggg L# # #"
Maze$(507) = "# # # #gggL ggg#k# #"
Maze$(508) = "# # #.#W########## #"
Maze$(509) = "# #    S         # #"
Maze$(510) = "# ##WL########## #D#"
Maze$(511) = "# # Ss             #"
Maze$(512) = "# # ########W#####W#"
Maze$(513) = "# # #ttttLrrSrrrr S."
Maze$(514) = "# # #############WW#"
Maze$(515) = "# #       s L    BB."
Maze$(516) = "#.##.###############"

'M:30
Maze$(517) = "#.##.###############"
Maze$(518) = "# ##sD             ."
Maze$(519) = "# #t#######W########"
Maze$(520) = "# #g# #r#ttB       ."
Maze$(521) = "# # # #r############"
Maze$(522) = "# # # # #L ttLttt  #"
Maze$(523) = "# # # # #  tttttt  ."
Maze$(524) = "#L# # # # L L rr L #"
Maze$(525) = "# # # # #B L       #"
Maze$(526) = "# # # # #######W####"
Maze$(527) = "# # # # #      Ssk ."
Maze$(528) = "#.#.#.#.#.##########"

'M:38
Maze$(529) = "#.W.#.#.#.W#########"
Maze$(530) = "# S # #   Ss       ."
Maze$(531) = "# # # # ########## #"
Maze$(532) = "# # # # #ttLtgL#k# ."
Maze$(533) = "# # # # #LtgLgt#L# #"
Maze$(534) = "# # # # # gttgL# # #"
Maze$(535) = "# # # # #LgLggL#L# #"
Maze$(536) = "# # # ### gtt t# # #"
Maze$(537) = "# # # ### LLL  # # #"
Maze$(538) = "# # # #W#D#L t #L# #"
Maze$(539) = "# # # sS# # L  # # #"
Maze$(540) = "#.#.#.#.#.######.#.#"

'M:46
Maze$(541) = "#.#.#.#.#.######.#.#"
Maze$(542) = "# # # # # #tttt# # #"
Maze$(543) = "# # # #   #LL L# # #"
Maze$(544) = "# # # # WW## rt# # #"
Maze$(545) = "# # # # SSk#tLL# # #"
Maze$(546) = "# # # # ####LLL# # #"
Maze$(547) = "# # # ###  tggt# # #"
Maze$(548) = "# # # # DLL ttr# # #"
Maze$(549) = "# # # # # gLgtg# # #"
Maze$(550) = "# # # # #LggLgt# # #"
Maze$(551) = "# # # # # gLLtg#   #"
Maze$(552) = "#.#.#.#.############"
 
'M:54
Maze$(553) = "#.#.#.#.W########W##"
Maze$(554) = "# # # # Ss       S ."
Maze$(555) = "# # # # ########## #"
Maze$(556) = "# # # # #LLtttttg# #"
Maze$(557) = "#L# # #L# LtLggt # #"
Maze$(558) = "# # # # #LLgttgLL# #"
Maze$(559) = "# # # # # ttrrt  # #"
Maze$(560) = "# # #L# #LLttLLLL# ."
Maze$(561) = ". # # # # gtrL#D## #"
Maze$(562) = "### # # # rt  #L # #"
Maze$(563) = ".k# # # # rgr # L# #"
Maze$(564) = "#.#.#.#.#######.##.#"

'M:62
Maze$(565) = "#.#.#.#.W####W#.##.#"
Maze$(566) = "# # # # B    S  #  ."
Maze$(567) = "# # # ####W#####W###"
Maze$(568) = "# # # #tttS     S  ."
Maze$(569) = "# # # ##############"
Maze$(570) = "# # # ############W#"
Maze$(571) = "# #              sS."
Maze$(572) = "# # ################"
Maze$(573) = "# #                ."
Maze$(574) = "# ################W#"
Maze$(575) = "#              L sB."
Maze$(576) = "####################"

'M:7
Maze$(577) = "##W#W##W###W#W#W#W##"
Maze$(578) = "#tB Ss Ss  B S B S #"
Maze$(579) = "### ## ### # # # # #"
Maze$(580) = "# #  # #t# # # # # #"
Maze$(581) = "# #  # # # # # # # #"
Maze$(582) = "# #  # # # # # # # #"
Maze$(583) = "# #  # # # # # # # #"
Maze$(584) = "# #  # # # # # # # #"
Maze$(585) = "# #  # # # # # # # #"
Maze$(586) = "# #  # #L# # # # # #"
Maze$(587) = "# #  # # # # # # # #"
Maze$(588) = "#.#.##.#.#.#.#.#.#.#"

'M:15
Maze$(589) = "#.#.##.#.#.#.#.#.#.#"
Maze$(590) = "# #L # # #L# # #L# #"
Maze$(591) = "# #  # # # # # # #L#"
Maze$(592) = "# # L# # # # # # # #"
Maze$(593) = "# #  # # # # # # # #"
Maze$(594) = "# #L # # # #t# # # #"
Maze$(595) = "# #  # # # #t# # # #"
Maze$(596) = "# # L# # # # # # # #"
Maze$(597) = "# #  # # # # # # # #"
Maze$(598) = "# #L # # # #t# # # #"
Maze$(599) = "# #  #L# # #t#L# # #"
Maze$(600) = "#.#.##.#.#.###.#.#.#"

'M:23
Maze$(601) = "#.#.##.#.#.###.#.#.#"
Maze$(602) = "# #k # # # #r# # # #"
Maze$(603) = "# #### # # #r# # # #"
Maze$(604) = "# #gt# # # # # # # #"
Maze$(605) = "# #gg# # # # # # # #"
Maze$(606) = "# ## # # # # # # # #"
Maze$(607) = "#      # #   #r# # #"
Maze$(608) = "#W###### W####W# # #"
Maze$(609) = ".S       S    B  # #"
Maze$(610) = "#W#######W######W# #"
Maze$(611) = ".S       B  L  sB  #"
Maze$(612) = "################.#D#"

'M:31
Maze$(613) = "#W##############.# #"
Maze$(614) = ".Bs          #t# # #"
Maze$(615) = "#W###### ### #t# # #"
Maze$(616) = ".S       #t# #t# # #"
Maze$(617) = "########## # #t# # #"
Maze$(618) = "#W######## # #t#t# #"
Maze$(619) = ".S      ## # #t#g# #"
Maze$(620) = "## rrgg ## # #t#t# #"
Maze$(621) = "########## #L# #t#L#"
Maze$(622) = "#W######## # # ### #"
Maze$(623) = ".B         # # ## s#"
Maze$(624) = "##########.#.#.##.##"

'M:39
Maze$(625) = "#W########.#.#.##.W#"
Maze$(626) = ".S      #### # #k B."
Maze$(627) = "#W#####    # # #####"
Maze$(628) = ".S     ### # #     ."
Maze$(629) = "####D# #t# # #####W#"
Maze$(630) = "#tttt# # # #     sB."
Maze$(631) = "#tttt# # # #######W#"
Maze$(632) = "#tttt# # # #     sS."
Maze$(633) = "#tttt# # # # #######"
Maze$(634) = "# t# # # # # #####W#"
Maze$(635) = "#tt# # # #   #rrrsS."
Maze$(636) = "######.#.#.#.#######"

'M:47
Maze$(637) = "##W###.#.#.#.####W##"
Maze$(638) = "#kS      # #    sB #"
Maze$(639) = "########W# ####### #"
Maze$(640) = "# r# #L BsD # #    #"
Maze$(641) = "#  # #ttt## # #  # #"
Maze$(642) = "#  # #tttt# # #  # #"
Maze$(643) = "#  # #tttt# # #  # #"
Maze$(644) = "#  # #tLtt# # #  # #"
Maze$(645) = "#  # #tttL# # #  # #"
Maze$(646) = "#  # ###### # #  # #"
Maze$(647) = "#    #    # # #  # #"
Maze$(648) = "####.####.#.#.####.#"

'M:55
Maze$(649) = "##W#.####.#.#.####.#"
Maze$(650) = ". B#          #### #"
Maze$(651) = "# W######## ###    #"
Maze$(652) = "# B       # # # ####"
Maze$(653) = "#     tt  # # # # k#"
Maze$(654) = "########### # # # L#"
Maze$(655) = "#W# rtttg # # # #  #"
Maze$(656) = ".B# tttgg # # # #LL#"
Maze$(657) = "### tgttt  D# # #  #"
Maze$(658) = "# rgttt ### # # # L#"
Maze$(659) = "#gttgtt ###   # #L #"
Maze$(660) = "#########.###.#.##.#"

'M:63
Maze$(661) = "#W#######.###.#.##.#"
Maze$(662) = ".Bs           # #  #"
Maze$(663) = "#W########### # #  #"
Maze$(664) = ".Bs           # #  #"
Maze$(665) = "############# # #  #"
Maze$(666) = "#W########### # #  #"
Maze$(667) = ".Bs           # #  #"
Maze$(668) = "#W############# #  #"
Maze$(669) = ".Bs                ."
Maze$(670) = "#W################W#"
Maze$(671) = ".Bs               B."
Maze$(672) = "####################"

'M:8
Maze$(673) = "#####W#W#W###W#W#W##"
Maze$(674) = "#k## S B B ##S S S #"
Maze$(675) = "# ## # #D# # # # # #"
Maze$(676) = "# ## # # # # # # # #"
Maze$(677) = "# ## # # # # # # # #"
Maze$(678) = "# ## # # # # # # # #"
Maze$(679) = "# ## # # # # # # # #"
Maze$(680) = "# ## # # # # # # # #"
Maze$(681) = "# ## # # # # # # # #"
Maze$(682) = "# ## # # # # # # # #"
Maze$(683) = "# ## # # # # # # # #"
Maze$(684) = "#.##.#.#.#.#.#.#.#.#"

'M:16
Maze$(685) = "#.##.#.#.#.#.#.#.#.#"
Maze$(686) = "# ## # # # # #L# #L#"
Maze$(687) = "# ## # # # # #t# # #"
Maze$(688) = "# ## # # # # #g# # #"
Maze$(689) = "# ## # # # # ### # #"
Maze$(690) = "# ## # # # # ### # #"
Maze$(691) = "# ## # #L# # ### # #"
Maze$(692) = "# ## # # # # ### # #"
Maze$(693) = "# ## # # # # ### # #"
Maze$(694) = "# ## # # # # ### # #"
Maze$(695) = "# ##L# # # # ### # #"
Maze$(696) = "#.##.#.#.#.#.###.#.#"

'M:24
Maze$(697) = "#.##.#.#.#.#.##W.#.#"
Maze$(698) = "# ## # # # # # S # #"
Maze$(699) = "# ## # # # # # # # #"
Maze$(700) = "# ## # # # # # # # #"
Maze$(701) = "# ## # # # # # # # #"
Maze$(702) = "# ## # # #L# # # # #"
Maze$(703) = "# ## #L# # # # # # #"
Maze$(704) = "# ## # # # # # # # #"
Maze$(705) = "# ## # # # # # # # #"
Maze$(706) = "# ## # # # # W # # #"
Maze$(707) = "# ## # # # # S # # #"
Maze$(708) = "#.##.#.#.#.#.###.#.#"

'M:32
Maze$(709) = "#.##.#.#.#.#.###.#.#"
Maze$(710) = "# ## # # # #D# # # #"
Maze$(711) = "# ## # # # # # # # #"
Maze$(712) = "# ## # # # #L# # # #"
Maze$(713) = "# ## #L# # # # # # #"
Maze$(714) = "# ## # # # # # # # #"
Maze$(715) = "# ## # # # # # # # #"
Maze$(716) = "# ## # # # # # # # #"
Maze$(717) = "# ## # # # # # # # #"
Maze$(718) = "# ## # # # W W # # #"
Maze$(719) = "# ##k# # # B S # # #"
Maze$(720) = "#.####.#.#.#.###.#.#"

'M:40
Maze$(721) = "#.####.#.#.#.###.#.#"
Maze$(722) = ". #  #t# # # ### # #"
Maze$(723) = "#W#  #W# # # ### # #"
Maze$(724) = ".S    S  # # ### # #"
Maze$(725) = "####W#W# # # ### # #"
Maze$(726) = ".   BsB  # # ### # #"
Maze$(727) = "#W###### # # ### # #"
Maze$(728) = ".S       # # ### # #"
Maze$(729) = "######## # # ### # #"
Maze$(730) = "##W###r# # # ### # #"
Maze$(731) = ". S k# #D# # ### # #"
Maze$(732) = "#.####.#.#.#.###.#.#"


'M:48
Maze$(733) = "#.####.#.#.#.###.#.#"
Maze$(734) = "#  #   # # # ###L# #"
Maze$(735) = "#  # # # # # ###t# #"
Maze$(736) = "#  # # #L# # ##### #"
Maze$(737) = "#  # # # # # ###t# #"
Maze$(738) = "#  # # #k# # ### # #"
Maze$(739) = "#  # # ### # ### #L#"
Maze$(740) = "#  # # #t# # ### # #"
Maze$(741) = "#  # # #t# # ### # #"
Maze$(742) = "#  # # # # # ### # #"
Maze$(743) = "#  # #L# # # ### #D#"
Maze$(744) = "#.##.#.#.#.#.###.#.#"

'M:56
Maze$(745) = "#.##.#.#.#.#.###.#.#"
Maze$(746) = "# ## # # # #k### # #"
Maze$(747) = "# ## # # # ###W# # #"
Maze$(748) = "# ## # # #    B  # #"
Maze$(749) = "# ## # # ####W##D# #"
Maze$(750) = "# ## #L# #tttBttr# #"
Maze$(751) = "# ## # # #gttt  L# #"
Maze$(752) = "# ## # # # trtSgL# #"
Maze$(753) = "# ## # # #rr rtrt# #"
Maze$(754) = "# #W # # #rtBgggt# #"
Maze$(755) = "# sB # # #gg ttrt# #"
Maze$(756) = "#.##.#.#.#########.#"

'M:64
Maze$(757) = "#.##.#.#.#########.#"
Maze$(758) = "#  # # # #ttt rrt# #"
Maze$(759) = "#  #L# # ####t tt# #"
Maze$(760) = "#  # # # # r rrr # #"
Maze$(761) = "# t# # # #Lrttrt # #"
Maze$(762) = "#t # # # # rrLrrL# #"
Maze$(763) = "# t#k# # #Stt tt # #"
Maze$(764) = "###### # #L     L# #"
Maze$(765) = ".      # #       # #"
Maze$(766) = "######W#.#####W# # #"
Maze$(767) = ".     Ss      SsD  #"
Maze$(768) = "####################"
RETURN

Makedotobj:
DATA !?Short sword, !?Warriors sword, !?Magical sword
DATA $/Amulet, %@Waters of healing, $/statue of a golden eagle
DATA !?Whip, !?Knife, !?Shield
DATA $/Chalice, $/bunch of golden coins, %/Healing potion
DATA !?Iron fist, !?Detonator, %@Spider Antidote
DATA |/Nothing at all

Wallcols:
DATA 12,4,6,2,5,7,8,14,8,11,9,1,4,2,2,1,2,3,10,1,8,8
DATA 2,13,2,5,6,7,9,11,3,3,4,6,12,9,3,5,7,2,4,12,9,4
DATA 5,8,9,7,1,3,6,2,4,5,13,11,12,11,10,9,14,15,13,1

Wallbord:
DATA 4,12,13,14,15,1,14,2,9,2,4,7,3,13,8,9,4,2,14,8,7
DATA 1,13,3,15,4,4,10,2,4,14,1,11,14,1,1,13,12,14,14
DATA 10,2,14,14,12,9,8,11,10,14,12,9,13,14,9,1,2,3,4
DATA 5,8,8,2,14

SUB Cleardotarea
LINE (Sx - 4, Sy)-(Sx + 23, Sy + 35), 0, BF
RETURN
END SUB

SUB CopydotPlayer
LINE (CIX1 + 15, CIY1 + 23)-(CIX1 + 37, CIY1 + 45), 0, BF
CIRCLE (CIX1 + 28, CIY1 + 35), 10, 15: PAINT (CIX1 + 28, CIY1 + 35), 15
CIRCLE (CIX1 + 28, CIY1 + 35), 10, 6: CIRCLE (CIX1 + 28, CIY1 + 35), 9, 6
FOR E = 1 TO 5: CIRCLE (CIX1 + 28, CIY1 + 35), E, 0: NEXT
CIRCLE (CIX1 + 28, CIY1 + 35), 1, 0
GET (CIX1 + 15, CIY1 + 23)-(CIX1 + 37, CIY1 + 45), Player%
RETURN

END SUB
