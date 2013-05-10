CHDIR ".\programs\samples\pete\tank"

'-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
'
'        ±±    ±± ±±±±±± ±±±±±± ±± ±±±±±  ±±±±±± ±±±   ±± ±±±±±±
'        ±±    ±± ±±  ±± ±±  ±± ±±    ±±  ±±  ±± ±± ±± ±± ±±
'        ±±±±±±±± ±±  ±± ±±±±±± ±±   ±±   ±±  ±± ±±  ±±±±  ±±±±
'        ±±    ±± ±±  ±± ±± ±±  ±±  ±±    ±±  ±± ±±   ±±±     ±±
'        ±±    ±± ±±±±±± ±±  ±± ±± ±±±±±± ±±±±±± ±±    ±± ±±±±±
'
'     I N T E R A C T I V E    E N T E R T A I N M E N T  -  1 9 9 9
'
'
'               Game Name:  Qbasic TANK COMMANDER version 2
'                   Programmer:  Matthew River Knight
'                     Completed:  August 15, 1999
'
'
'This game is a remake of the last TANK COMMANDER, having been improved and
'modified a great deal. The sprites now move very fluidly and without any
'flicker on 286 PCs and up. The code is also alot smaller than the last
'version and has been made as readable and easy to edit as possible.
'
'                               * * * *
'
'This is a two player game in which you and a friend drive about the arena
'in tanks trying to blow eachother up. You both have very powerfull tanks
'capable of driving through anything in your path. Even the most secure of
'fortresses stands no chance against these armoured beasts. Each of the tanks
'is equipt with powerfull bomb launchers, capable of blowing up the other
'tank beyond repair, with a single strike.
'
'The keys for the game are pretty standard, and have been designed to allow
'both players to play at the same keyboard without getting in eachothers way.
'You MUST ensure that NUMLOCK is ON before running the game !!! The keys
'are as follows:
'
'BLUE TANK  - up:  8
'             down:  2
'             left:  4
'             right:  6
'             brakes:  5
'             shoot:  0
'
'GREEN TANK - up:  Q
'             down:  A
'             left:  O
'             right:  P
'             brakes:  S
'             shoot:  SPACE BAR
'
'                               * * * *
'
'The graphics for this game have been BSAVEd, and thus have to be loaded
'directly into memory to be drawn. This presents quite a problem because
'Qbasic often has quite a bit of trouble locating files that need to be
'BLOADed. This problem may be corrected by reffering to line 122 where there
'is a CHDIR. All you have to do is type the directory in which this game
'resides into the "" marks.
'
'Another potential problem with this game is the delay loop, which controls
'how fast the program runs. This game was designed on a computer using a
'CYRIX MII300 CPU, a 4MB graphics accelerator card and 512K cache - your
'computer may be faster or slower, and thus, for example, if you have a
'PENTIUM III, clocked at 500MHZ, this game will run so fast that it will be
'unplayable.
'
'This problem could have been eliminated by adding a CPU independant delay
'into the code by testing how fast your CPU is, however this presents us with
'another problem: different versions of Qbasic tend to give different results
'for these kinds of tests, and thus the game would have run inconsistantly
'on different platforms, even if they were being run on exactly the same
'kind of system. Since I wanted this game to be playable on any version of
'Qbasic, I chose to let everybody set the delay loop themselves.
'
'The delay loop variable is on line 125, under the name of Speed. All you
'have to do is change what it is = to. The default setting is 550 which is
'perfect for my system when running the game under WINDOWS 95 and on a Qbasic
'4.5 platform. Just experiment with the setting until the game runs at a
'speed with which you are satisfied. Just remember that the lower the number
'Speed is = to, the faster the game is going to run!
'
'                               * * * *
'
'This game has been programmed from scratch by Matthew River Knight. All the
'code here is my own, with the exception of the FADE IN/OUT code which was
'kindly provided by Manny Najera of FLASH GAMES, on his web site. Any code
'that you find usefull in this game may be taken. The graphics files used
'in this game may not be taken, however. Please give this game to anybody,
'and everybody, though if you do, please DO NOT give them a modified version,
'and DO NOT remove this text! I spent ages making the code the way it is and
'personally I am very proud of it. Please leave it as it is!
'
'File list for Qbasic TANK COMMANDER v2:
'
'*  TCV2.BAS....................Game code file.
'*  ARENA.BSV...................BSAVEd graphics file for game arena.
'*  SPRITES.BSV.................BSAVEd graphics file for sprites.
'
'-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

'Define variables A-Z as integers.
DEFINT A-Z

'Define the data TYPE, PaletteType.
TYPE PaletteType
Red AS INTEGER
Green AS INTEGER
Blue AS INTEGER
END TYPE

'SHAREing of certain variables.
DIM SHARED Pal AS PaletteType
DIM SHARED pData(0 TO 255, 1 TO 3)

'Declaration of various SUBs.
DECLARE SUB Palette.Set (nColor%, pInfo AS PaletteType)
DECLARE SUB Palette.Get (nColor%, pInfo AS PaletteType)
DECLARE SUB Palette.FadeOut ()
DECLARE SUB Palette.FadeIn ()

'Change the default directory to the one being used for TANK COMMANDER. When
'setting this, remember to uncomment it.
'CHDIR ""

'Initial values of various variables.
D1 = 2: D2 = 4: T1H = 6: T1V = 87: T2H = 300: T2V = 102: Speed = 550

'Customise the VGA color palette for the introductory text.
SCREEN 13
C = 16: FOR A = 16 TO 61 STEP 3: PALETTE C, (256 ^ 2 * A) + (256 * 0) + 0: C = C + 1: NEXT
C = 32: FOR A = 16 TO 61 STEP 3: PALETTE C, (256 ^ 2 * 0) + (256 * A) + 0: C = C + 1: NEXT
C = 48: FOR A = 16 TO 61 STEP 3: PALETTE C, (256 ^ 2 * 0) + (256 * 0) + A: C = C + 1: NEXT
C = 64: FOR A = 16 TO 61 STEP 3: PALETTE C, (256 ^ 2 * A) + (256 * A) + 0: C = C + 1: NEXT
C = 80: FOR A = 16 TO 61 STEP 3: PALETTE C, (256 ^ 2 * A) + (256 * 0) + A: C = C + 1: NEXT
C = 96: FOR A = 16 TO 61 STEP 3: PALETTE C, (256 ^ 2 * 0) + (256 * A) + A: C = C + 1: NEXT
C = 112: B = 0: FOR A = 16 TO 61 STEP 3: PALETTE C, (256 ^ 2 * A) + (256 * B) + 0: B = B + 3: C = C + 1: NEXT
C = 128: B = 0: FOR A = 16 TO 61 STEP 3: PALETTE C, (256 ^ 2 * B) + (256 * 0) + A: B = B + 3: C = C + 1: NEXT
C = 144: B = 0: FOR A = 16 TO 61 STEP 3: PALETTE C, (256 ^ 2 * B) + (256 * A) + 0: B = B + 3: C = C + 1: NEXT
C = 160: B = 0: FOR A = 16 TO 61 STEP 3: PALETTE C, (256 ^ 2 * B) + (256 * A) + A: B = B + 3: C = C + 1: NEXT
C = 176: B = 0: FOR A = 16 TO 61 STEP 3: PALETTE C, (256 ^ 2 * A) + (256 * A) + A: C = C + 1: NEXT
C = 192: B = 12: AA = 0: FOR A = 30 TO 62 STEP 2: PALETTE C, (256 ^ 2 * B) + (256 * AA) + A: B = B + 2: C = C + 1: NEXT
C = 208: B = 12: AA = 0: FOR A = 30 TO 62 STEP 2: PALETTE C, (256 ^ 2 * B) + (256 * B) + A: B = B + 2: C = C + 1: NEXT
C = 224: B = 12: AA = 0: FOR A = 30 TO 62 STEP 2: PALETTE C, (256 ^ 2 * AA) + (256 * B) + A: B = B + 2: C = C + 1: NEXT

'Do presentation text.
Palette.FadeOut
COLOR 1
LOCATE 9, 16: PRINT "  HORIZONS Interactive Entertainment"
LOCATE 13, 13: PRINT "P R E S E N T S"

'Color in company name with various shades of green.
Y = 72: C = 32
DO
FOR X = 1 TO 300
IF POINT(X, Y) > 0 THEN PSET (X, Y), C + RND * 15
NEXT
Y = Y + 1
LOOP UNTIL Y = 79

'Color in "PRESENTS" with various shades of red. Once this has been done,
'fade in the screen, melt it, and then fade out.
Y = 96: C = 49
DO
FOR X = 1 TO 300
IF POINT(X, Y) > 0 THEN PSET (X, Y), C + RND * 14
NEXT
Y = Y + 1
LOOP UNTIL Y = 103
Palette.FadeIn
NOW! = TIMER: WHILE (TIMER - 1) < NOW!: WEND
DIM Melt%(1500)
FOR R = 1 TO 1500
  RANDOMIZE TIMER
  X = INT(RND * 271)
  RANDOMIZE TIMER
  Y = INT(RND * 150)
  GET (X, Y)-(X + 48, Y + 18), Melt%
  PUT (X, Y + 1), Melt%, PSET
  IF INKEY$ = CHR$(27) THEN END
NEXT
Palette.FadeOut
CLS : PALETTE: Palette.FadeOut

'GET the sprite data.
DEF SEG = 40960: BLOAD "sprites.bsv"
DIM Tank1(150): GET (1, 1)-(15, 10), Tank1
DIM Tank2(150): GET (1, 14)-(15, 23), Tank2
DIM Tank3(150): GET (1, 27)-(15, 36), Tank3
DIM Tank4(150): GET (1, 40)-(15, 49), Tank4
DIM Tank5(150): GET (20, 1)-(34, 10), Tank5
DIM Tank6(150): GET (20, 14)-(34, 23), Tank6
DIM Tank7(150): GET (20, 27)-(34, 36), Tank7
DIM Tank8(150): GET (20, 40)-(34, 49), Tank8

'Load the file ARENA.BSV, which is the graphics data for the arena, into the
'video memory segment (segment 40960).
BLOAD "arena.bsv"

'Place both tanks in their initial positions and fade in the completed arena.
PUT (T1H, T1V), Tank1, PSET
PUT (T2H, T2V), Tank6, PSET
Palette.FadeIn

'Main program loop.
DO

'IF Count < Speed THEN Count = Count + 1 ELSE Count = 0
WAIT &H3DA, 8: WAIT &H3DA, 8, 8

IF Go1 = 1 AND Count = 0 THEN
  IF D1 = 1 AND T1V > 26 THEN T1V = T1V - 1: PUT (T1H, T1V), Tank3, PSET
  IF D1 = 2 AND T1H < 305 THEN T1H = T1H + 1: PUT (T1H, T1V), Tank1, PSET
  IF D1 = 3 AND T1V < 190 THEN T1V = T1V + 1: PUT (T1H, T1V), Tank4, PSET
  IF D1 = 4 AND T1H > 0 THEN T1H = T1H - 1: PUT (T1H, T1V), Tank2, PSET
END IF
IF Go2 = 1 AND Count = 0 THEN
  IF D2 = 1 AND T2V > 26 THEN T2V = T2V - 1: PUT (T2H, T2V), Tank7, PSET
  IF D2 = 2 AND T2H < 305 THEN T2H = T2H + 1: PUT (T2H, T2V), Tank5, PSET
  IF D2 = 3 AND T2V < 190 THEN T2V = T2V + 1: PUT (T2H, T2V), Tank8, PSET
  IF D2 = 4 AND T2H > 0 THEN T2H = T2H - 1: PUT (T2H, T2V), Tank6, PSET
END IF
IF St1 = 30 THEN St1 = 0: Fire1 = 0: PSET (B1H, B1V), Col
IF St2 = 30 THEN St2 = 0: Fire2 = 0: PSET (B2H, B2V), Col2
IF Fire1 = 1 AND St1 < 30 AND Count = 0 THEN
  PSET (B1H, B1V), Col
  IF BD1 = 1 THEN B1V = B1V - 2
  IF BD1 = 2 THEN B1H = B1H + 2
  IF BD1 = 3 THEN B1V = B1V + 2
  IF BD1 = 4 THEN B1H = B1H - 2
  Col = POINT(B1H, B1V)
  PSET (B1H, B1V), 14
  St1 = St1 + 1
  GOSUB CheckBullet1
END IF
IF Fire2 = 1 AND St2 < 30 AND Count = 0 THEN
  PSET (B2H, B2V), Col2
  IF BD2 = 1 THEN B2V = B2V - 2
  IF BD2 = 2 THEN B2H = B2H + 2
  IF BD2 = 3 THEN B2V = B2V + 2
  IF BD2 = 4 THEN B2H = B2H - 2
  Col2 = POINT(B2H, B2V)
  PSET (B2H, B2V), 14
  St2 = St2 + 1
  GOSUB CheckBullet2
END IF
Key$ = INKEY$
IF Key$ = CHR$(27) THEN Palette.FadeOut: GOTO Results
IF Key$ = "4" THEN Go1 = 1: D1 = 4
IF Key$ = "6" THEN Go1 = 1: D1 = 2
IF Key$ = "8" THEN Go1 = 1: D1 = 1
IF Key$ = "2" THEN Go1 = 1: D1 = 3
IF Key$ = "0" THEN IF Fire1 = 0 THEN GOSUB Shoot1
IF Key$ = "5" THEN Go1 = 0
IF Key$ = "O" OR Key$ = "o" THEN Go2 = 1: D2 = 4
IF Key$ = "P" OR Key$ = "p" THEN Go2 = 1: D2 = 2
IF Key$ = "Q" OR Key$ = "q" THEN Go2 = 1: D2 = 1
IF Key$ = "A" OR Key$ = "a" THEN Go2 = 1: D2 = 3
IF Key$ = "S" OR Key$ = "s" THEN Go2 = 0
IF Key$ = CHR$(32) THEN IF Fire2 = 0 THEN GOSUB Shoot2
LOOP

Shoot1:  'Initiates the shooting from Tank 1.
BD1 = D1
IF BD1 = 0 THEN RETURN
IF BD1 = 1 THEN B1H = (T1H + 7): B1V = (T1V - 1)
IF BD1 = 2 THEN B1H = (T1H + 14): B1V = (T1V + 5)
IF BD1 = 3 THEN B1H = (T1H + 7): B1V = (T1V + 11)
IF BD1 = 4 THEN B1H = (T1H - 1): B1V = (T1V + 5)
St1 = 1: Fire1 = 1: Col = POINT(B1H, B1V)
RETURN

Shoot2:  'Initiates the shooting from Tank 2.
BD2 = D2
IF BD2 = 0 THEN RETURN
IF BD2 = 1 THEN B2H = (T2H + 7): B2V = (T2V - 1)
IF BD2 = 2 THEN B2H = (T2H + 14): B2V = (T2V + 5)
IF BD2 = 3 THEN B2H = (T2H + 7): B2V = (T2V + 11)
IF BD2 = 4 THEN B2H = (T2H - 1): B2V = (T2V + 5)
St2 = 1: Fire2 = 1: Col2 = POINT(B2H, B2V)
RETURN

CheckBullet1:  'Hit detection from Tank 1 bullet.
T2V = T2V + 2: T2H = T2H + 3
FOR ScanTank2 = 1 TO 7
FOR Scan = 1 TO 9
  IF B1H = T2H AND B1V = T2V THEN Crash = 2: GOTO Explode
  T2H = T2H + 1
NEXT
  T2H = T2H - 9: T2V = T2V + 1
NEXT
T2V = T2V - 9: T2H = T2H - 3
RETURN

CheckBullet2:  'Hit detection from Tank 2 bullet.
T1V = T1V + 2: T1H = T1H + 3
FOR ScanTank1 = 1 TO 7
FOR Scan = 1 TO 9
  IF B2H = T1H AND B2V = T1V THEN Crash = 1: GOTO Explode
  T1H = T1H + 1
NEXT
  T1H = T1H - 9: T1V = T1V + 1
NEXT
T1V = T1V - 9: T1H = T1H - 3
RETURN

Explode:  'Create very cheap graphic explosion.
IF Crash = 1 THEN ExplodeH = T1H: ExplodeV = T1V: T2Wins = 1
IF Crash = 2 THEN ExplodeH = T2H: ExplodeV = T2V: T1Wins = 1
FOR Explode = 1 TO 9
  IF Explode = 1 THEN Col = 14
  IF Explode = 5 THEN Col = 12
  IF Explode = 7 THEN Col = 4
  CIRCLE (ExplodeH, ExplodeV), Explode, Col
  NOW! = TIMER: WHILE (TIMER - .01) < NOW!: WEND
NEXT
NOW! = TIMER: WHILE (TIMER - 1) < NOW!: WEND
Palette.FadeOut

Results:  'Announce the winning tank and display credits.
SCREEN 0: WIDTH 80, 25
COLOR 12, 4
PRINT " G A M E    R E S U L T S "
PRINT
COLOR 4, 0
PRINT "Blue tank wins:"
COLOR 2
LOCATE 3, 17: PRINT T1Wins
COLOR 4
PRINT "Green tank wins:"
COLOR 2
LOCATE 4, 18: PRINT T2Wins
PRINT
COLOR 12, 4
PRINT " C R E D I T S "
PRINT
COLOR 4, 0
PRINT "Concept:"
PRINT "Programming:"
PRINT "Game art:"
PRINT "Fade effect:"
PRINT "Testing:"
PRINT "Debugging:"
COLOR 2
LOCATE 8, 11: PRINT "About a million other un-origional programmers ;)"
LOCATE 9, 15: PRINT "Matthew Knight"
LOCATE 10, 12: PRINT "Matthew Knight"
LOCATE 11, 15: PRINT "Manny Najera"
LOCATE 12, 11: PRINT "Matthew Knight"
LOCATE 13, 13: PRINT "Matthew Knight"
PRINT
COLOR 9
PRINT "All code in this game was programmed from scratch by Matthew Knight, with"
PRINT "exception of the fade effect which was kindly supplied by Manny Najera."
PRINT "No code was taken from any other games. Any similarity to another game is"
PRINT "purely coincidental."
PRINT
COLOR 4
PRINT "Thank you for trying Qbasic TANK COMMANDER v2 !!!"
PRINT "Hope you liked it :)"
COLOR 7

SUB Palette.FadeIn
DIM tT(1 TO 3)
FOR I = 1 TO 64
  WAIT &H3DA, 8, 8
  FOR O = 0 TO 255
    Palette.Get O, Pal
    tT(1) = Pal.Red
    tT(2) = Pal.Green
    tT(3) = Pal.Blue
    IF tT(1) < pData(O, 1) THEN tT(1) = tT(1) + 1
    IF tT(2) < pData(O, 2) THEN tT(2) = tT(2) + 1
    IF tT(3) < pData(O, 3) THEN tT(3) = tT(3) + 1
    Pal.Red = tT(1)
    Pal.Green = tT(2)
    Pal.Blue = tT(3)
    Palette.Set O, Pal
  NEXT
NEXT
END SUB

SUB Palette.FadeOut
DIM tT(1 TO 3)
FOR I = 0 TO 255
  Palette.Get I, Pal
  pData(I, 1) = Pal.Red
  pData(I, 2) = Pal.Green
  pData(I, 3) = Pal.Blue
NEXT
FOR I = 1 TO 64
  WAIT &H3DA, 8, 8
  FOR O = 0 TO 255
    Palette.Get O, Pal
    tT(1) = Pal.Red
    tT(2) = Pal.Green
    tT(3) = Pal.Blue
    IF tT(1) > 0 THEN tT(1) = tT(1) - 1
    IF tT(2) > 0 THEN tT(2) = tT(2) - 1
    IF tT(3) > 0 THEN tT(3) = tT(3) - 1
    Pal.Red = tT(1)
    Pal.Green = tT(2)
    Pal.Blue = tT(3)
    Palette.Set O, Pal
  NEXT
NEXT
END SUB

SUB Palette.Get (nColor%, pInfo AS PaletteType)
OUT &H3C6, &HFF
OUT &H3C7, nColor%
pInfo.Red = INP(&H3C9)
pInfo.Green = INP(&H3C9)
pInfo.Blue = INP(&H3C9)
END SUB

SUB Palette.Set (nColor%, pInfo AS PaletteType)
OUT &H3C6, &HFF
OUT &H3C8, nColor%
OUT &H3C9, pInfo.Red
OUT &H3C9, pInfo.Green
OUT &H3C9, pInfo.Blue
END SUB

