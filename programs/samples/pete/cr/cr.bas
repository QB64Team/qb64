' ***************************************
' *                                     *
' * CAVE RAIDER             Version 1.4 *
' * ===========                         *
' * Copyright (c) 2004 by Paul  Redling *
' *                                     *
' ***************************************

DEFINT A-Z

DECLARE SUB TextBlink ()
DECLARE SUB Initialize ()
DECLARE SUB Story ()
DECLARE SUB Instructions ()
DECLARE SUB HallOfFame ()
DECLARE SUB Options ()
DECLARE SUB Game ()
DECLARE SUB NextCave ()
DECLARE SUB MoveCR ()
DECLARE SUB MoveLGM ()
DECLARE SUB MoveLRM ()
DECLARE SUB MoveBM ()
DECLARE SUB NewPositions ()
DECLARE SUB HitDetection ()
DECLARE SUB Explosion ()
DECLARE SUB SetTimers ()
DECLARE SUB QuickStop ()
DECLARE SUB TheEnd ()
DECLARE SUB EndScreen ()
DECLARE SUB Highscore ()
DECLARE SUB Pause ()
DECLARE SUB Grenade (direction)
DECLARE SUB Quicksand (fields)
DECLARE SUB SetSound (number)
DECLARE SUB PCSound (number)
DECLARE SUB Delay (seconds!)
DECLARE SUB Center (row, text$)
DECLARE FUNCTION MainMenu ()
DECLARE FUNCTION RandomInt (low, high)

DIM SHARED table, cr!(3), crname$(3), hscore!(3), cave!(3), hscore, nohscore
DIM SHARED cr, ds, speaker, fe, crname$, rq1, rq2, rq3, dy, dx, y, x, oldy
DIM SHARED oldx, sy, sx, fields, lgmonsters, lrmonsters, bmonsters, health
DIM SHARED score, hit, gy, gx, ftime, trigger, mcounter, explode, xcounter
DIM SHARED tlgm!, tlrm!, tbm!, ts!, tq!, te!, tb!, grenades, magic, stone
DIM SHARED treasure, pgold, gem, scroll, death, cave, newcave, dkey$

RANDOMIZE TIMER
SCREEN 13          'Fullscreen mode in Windows
SCREEN 0
WIDTH 40, 43
PALETTE 1, 56
PALETTE 9, 6
Initialize

DO
  choice = MainMenu
  IF choice = 1 THEN Game
  IF choice = 2 THEN Story
  IF choice = 3 THEN Instructions
  IF choice = 4 THEN HallOfFame
  IF choice = 5 THEN Options
  IF choice = 6 THEN EXIT DO
LOOP

SCREEN 13
SCREEN 0
WIDTH 80, 25
COLOR 7, 0
END

FileError:
fe = 1
RESUME NEXT

SUB Center (row, text$)

LOCATE row, (40 - LEN(text$)) \ 2 + 1
PRINT text$;

END SUB

SUB Delay (seconds!)

'Delays the program or sleeps
' If seconds! > 0, then it delays the program
' If seconds! <= 0, then it sleeps
' Delay 0 = Sleep, Delay -1 = Sleep 1, Delay -1.5 = Sleep 1.5
' Unlike the SLEEP statement, the keyboard buffer is cleared after a key is
' pressed.

secs! = ABS(seconds!)
IF secs! = 0 THEN secs! = 86400
t! = TIMER
DO
  IF seconds! > 0 THEN                 'Delay
    WHILE INKEY$ <> "": WEND           'Clear the keyboard buffer (no beeps!)
  ELSE                                 'Sleep
    dkey$ = INKEY$                     'To read a keystroke, make "dkey$" DIM
    IF dkey$ <> "" THEN EXIT DO        'SHARED in the main module.
  END IF
LOOP UNTIL ABS(TIMER - t!) >= secs!    'No endless loop at midnight!

END SUB

SUB EndScreen

COLOR 8, 0
FOR row = 1 TO 43: LOCATE row, 1: PRINT STRING$(40, 170); : NEXT row
FOR row = 10 TO 35: LOCATE row, 11: PRINT STRING$(20, 177): NEXT row
FOR row = 11 TO 34: LOCATE row, 12: PRINT SPACE$(18): NEXT row

PALETTE 5, 57
IF cave <> 7 THEN
  COLOR 5
  FOR row = 12 TO 19: LOCATE row, 13: PRINT STRING$(16, 219); : NEXT row
  COLOR 0, 2
  FOR row = 20 TO 21: LOCATE row, 13: PRINT STRING$(16, 177); : NEXT row
  COLOR 0, 1
  LOCATE 13, 18: PRINT STRING$(6, 176)
  FOR row = 14 TO 20: LOCATE row, 17: PRINT STRING$(8, 176); : NEXT row
  COLOR 1
  FOR row = 15 TO 20: LOCATE row, 18: PRINT STRING$(6, 219); : NEXT row
  COLOR 0
  LOCATE 15, 19: PRINT "REST"
  LOCATE 17, 20: PRINT "IN"
  LOCATE 19, 19: PRINT "PEACE"
  COLOR 15, 0: Center 23, "A Hero!"
  COLOR 7
  Center 25, "On " + DATE$ + ", "
  Center 27, "at " + TIME$ + ",   "
  LOCATE 29, 13: PRINT crname$
  LOCATE 29, 14 + LEN(RTRIM$(crname$)): PRINT "fell."
  COLOR 3: Center 31, "Score:" + LTRIM$(STR$(score))
ELSE
  COLOR 5
  FOR row = 12 TO 19: LOCATE row, 13: PRINT STRING$(16, 219); : NEXT row
  COLOR 0, 2
  FOR row = 20 TO 21: LOCATE row, 13: PRINT STRING$(16, 177); : NEXT row
  IF cr = 1 THEN COLOR 14 ELSE COLOR 13
  LOCATE 13, 16: PRINT STRING$(6, 219)
  FOR row = 14 TO 19: LOCATE row, 15: PRINT STRING$(8, 219); : NEXT row
  LOCATE 20, 16: PRINT STRING$(6, 219)
  COLOR 0, 0
  LOCATE 15, 17: PRINT " ": LOCATE 15, 20: PRINT " "
  LOCATE 17, 17: PRINT "    "
  LOCATE 18, 18: PRINT "  "
  COLOR 9, 5
  LOCATE 18, 25: PRINT "$"
  LOCATE 19, 24: PRINT "$$$"
  COLOR 15, 0: Center 23, "A Legend!"
  COLOR 7
  Center 25, "On " + DATE$ + ", "
  Center 27, "at " + TIME$ + ",   "
  LOCATE 29, 13: PRINT crname$
  LOCATE 29, 14 + LEN(RTRIM$(crname$)): PRINT "escaped."
  COLOR 3: Center 31, "Score:" + LTRIM$(STR$(score))
END IF
COLOR 8: Center 33, "Press any key"
LOCATE 33, 27: COLOR 24: PRINT "_"

Delay 0

END SUB

SUB Explosion STATIC

IF firsttime = 0 THEN check = SCREEN(gy, gx): firsttime = 1
LOCATE gy, gx
IF RND > .5 THEN COLOR 14 ELSE COLOR 4
SELECT CASE check
  CASE 249, 234, 36, 42, 254, 178, 176, 177: PRINT CHR$(15)
  CASE ELSE
END SELECT
te! = TIMER
xcounter = xcounter + 1

IF xcounter = 10 THEN
  explode = 0: xcounter = 0: firsttime = 0
  LOCATE gy, gx: COLOR 7
  SELECT CASE check
    CASE 249: COLOR 7, 5: PRINT CHR$(42): COLOR 7, 1    'White star
    CASE 234, 36, 42, 254: PRINT " "
    CASE 178, 176: PRINT CHR$(176)
    CASE 177: COLOR 15: PRINT CHR$(177)
    CASE ELSE
  END SELECT
  IF check = 178 THEN
    up = SCREEN(gy - 1, gx)
    down = SCREEN(gy + 1, gx)
    IF up <> 178 AND up <> 176 AND down <> 178 AND down <> 176 THEN LOCATE gy, gx: PRINT " "
  END IF
  gy = 1: gx = 1
END IF

END SUB

SUB Game

DO

SCREEN 0, , 0, 0

IF cave = 7 THEN          'You've escaped from the cave system
  EndScreen
  Highscore
  cave = 1
  EXIT SUB
END IF

NextCave
PALETTE 5, 25

cheat$ = "cave6"

newcave = 1
oldcave = cave
health = 100
treasure = 0
gem = 0
magic = 0
stone = 0
scroll = 0
Quicksand -1
SELECT CASE ds
  CASE 1: grenades = 5    'Easy
  CASE 2: grenades = 3    'Normal
  CASE 3: grenades = 2    'Hard
END SELECT
IF cave = 1 THEN
  PALETTE 12, 60
  score = 0
  pgold = 10
  lgmonsters = 6
  lrmonsters = 4
ELSEIF cave MOD 3 = 0 THEN
  PALETTE 12, 0
  pgold = 15
  IF cave = 3 THEN bmonsters = 10
  IF cave = 6 THEN bmonsters = 15
ELSE
  PALETTE 12, 60
  pgold = 10
  IF lgmonsters <= 8 THEN lgmonsters = lgmonsters + 2
  IF lrmonsters <= 8 THEN lrmonsters = lrmonsters + 2
END IF

'Build the screen
SCREEN 0, , 1, 0
COLOR 7, 0: CLS
COLOR 15, 1
FOR row = 1 TO 40: LOCATE row, 1: PRINT STRING$(40, 177); : NEXT row
FOR row = 2 TO 39: LOCATE row, 2: PRINT SPACE$(38); : NEXT row
COLOR 3, 0
LOCATE 41, 2: PRINT "Health:100"
LOCATE 41, 18: PRINT "Score:" + LTRIM$(STR$(score));
LOCATE 41, 34: PRINT "Cave:" + LTRIM$(STR$(cave));
LOCATE 42, 2: PRINT "Grenades:" + LTRIM$(STR$(grenades));
LOCATE 42, 15: PRINT "Gem:" + LTRIM$(STR$(gem));
LOCATE 42, 22: PRINT "Scroll:" + LTRIM$(STR$(scroll));
LOCATE 42, 33: PRINT "Magic:" + LTRIM$(STR$(magic));

'Starting positions
COLOR 11, 1
gmy = RandomInt(2, 39)
gmx = RandomInt(2, 39)
LOCATE gmy, gmx: PRINT CHR$(4)                      'Magic gem

DO
  sy = RandomInt(3, 38)
  sx = RandomInt(3, 38)
  IF sy > gmy + 15 OR sy < gmy - 15 THEN
    IF SCREEN(sy, sx) = 32 THEN EXIT DO
  END IF
LOOP
LOCATE sy, sx: PRINT CHR$(236)                      'Magic scroll

COLOR 9
LOCATE sy - 1, sx - 1: PRINT STRING$(3, 250)
LOCATE sy, sx - 1: PRINT CHR$(250)                  'Magic wall around scroll
LOCATE sy, sx + 1: PRINT CHR$(250)
LOCATE sy + 1, sx - 1: PRINT STRING$(3, 250)

rq1 = RandomInt(1, 4)     'Random quadrant of lgmonsters
rq2 = RandomInt(1, 4)     'Random quadrant of lrmonsters
rq3 = RandomInt(1, 4)     'Random quadrant of bmonsters

COLOR 15
DO
  rq = RandomInt(1, 4)    'Random quadrant of magic door
  IF cave MOD 3 <> 0 THEN
    IF rq <> rq1 AND rq <> rq2 THEN EXIT DO
  ELSE
    IF rq <> rq3 THEN EXIT DO
  END IF
LOOP
DO
  SELECT CASE rq
    CASE 1: dy = RandomInt(2, 20): dx = RandomInt(4, 20)
    CASE 2: dy = RandomInt(21, 39): dx = RandomInt(4, 20)
    CASE 3: dy = RandomInt(2, 20): dx = RandomInt(23, 39)
    CASE 4: dy = RandomInt(21, 39): dx = RandomInt(23, 39)
  END SELECT
  IF SCREEN(dy, dx) = 32 AND SCREEN(dy, dx - 2) = 32 THEN EXIT DO
LOOP
LOCATE dy, dx: PRINT "X"                            'Magic door

y = dy
x = dx - 2
IF cr = 1 THEN COLOR 14                             'Male CR
IF cr = 2 THEN COLOR 13                             'Female CR
LOCATE y, x: PRINT CHR$(2)

COLOR 7
FOR n = 1 TO 22                                     'Rock formations
  DO
    ry = RandomInt(2, 35)
    rx = RandomInt(4, 36)
    IF SCREEN(ry, rx) = 32 THEN
      FOR rfx = rx - 3 TO rx + 3
        FOR rfy = ry TO ry + 4
          IF SCREEN(rfy, rfx) = 32 THEN counter = counter + 1
        NEXT rfy
      NEXT rfx
    END IF
    IF counter = 35 THEN EXIT DO
    counter = 0
  LOOP
  LOCATE ry, rx: PRINT CHR$(178)
  LOCATE ry + 1, rx - 1: PRINT STRING$(3, 178)
  LOCATE ry + 2, rx - 2: PRINT STRING$(5, 178)
  rn = RandomInt(1, 2)
  IF rn = 2 THEN LOCATE ry + 3, rx - 3: PRINT STRING$(7, 178)
  counter = 0
NEXT n

IF cave MOD 3 <> 0 THEN
  COLOR 2
  DO
    cy = RandomInt(2, 39)
    cx = RandomInt(2, 39)
    IF SCREEN(cy, cx) = 32 THEN EXIT DO
  LOOP
  LOCATE cy, cx: PRINT CHR$(254)                    'Chest of grenades
END IF

COLOR 9
FOR n = 1 TO pgold                                  'Pieces of gold
  DO
    pgy = RandomInt(2, 39)
    pgx = RandomInt(2, 39)
    IF SCREEN(pgy, pgx) = 32 THEN EXIT DO
  LOOP
  LOCATE pgy, pgx: PRINT "$"
NEXT n

IF cave MOD 3 <> 0 THEN
  MoveLGM                                           'Monsters
  MoveLRM
ELSE
  MoveBM
END IF

gy = 1: gx = 1
hit = 1: mcounter = 0: ftime = 0
newcave = 0

PCOPY 1, 0
Pause
tq! = TIMER

'Main loop
DO
  k$ = UCASE$(INKEY$)
  IF k$ <> "" THEN
    k = k + 1
    IF MID$(cheat$, k, 1) = LCASE$(k$) THEN cheat = cheat + 1 ELSE k = 0: cheat = 0
    IF cheat = 5 THEN cave = 6: score = 0: nohscore = 1: EXIT DO
  END IF
  oldy = y: oldx = x
  COLOR 7, 1
  SELECT CASE k$
    CASE CHR$(0) + CHR$(75)                                         'Left
      LOCATE y, x: PRINT " ": x = x - 1: MoveCR
    CASE CHR$(0) + CHR$(77)                                         'Right
      LOCATE y, x: PRINT " ": x = x + 1: MoveCR
    CASE CHR$(0) + CHR$(72)                                         'Up
      LOCATE y, x: PRINT " ": y = y - 1: MoveCR
    CASE CHR$(0) + CHR$(80)                                         'Down
      LOCATE y, x: PRINT " ": y = y + 1: MoveCR
    CASE CHR$(32)                                                   'Spacebar
      IF hit = 0 THEN
        trigger = 1: Grenade (direction)
      ELSEIF hit = 1 THEN
        IF grenades > 0 THEN
          hit = 0
          COLOR 2, 0
          LOCATE 43, 1: PRINT SPACE$(40);
          Center 43, "Which direction?"
          COLOR 2, 1
          PCOPY 1, 0
          DO
            d$ = UCASE$(INKEY$)
            IF d$ = CHR$(0) + CHR$(72) THEN direction = 1: EXIT DO
            IF d$ = CHR$(0) + CHR$(80) THEN direction = 2: EXIT DO
            IF d$ = CHR$(0) + CHR$(75) THEN direction = 3: EXIT DO
            IF d$ = CHR$(0) + CHR$(77) THEN direction = 4: EXIT DO
            IF explode = 1 AND ABS(TIMER - te!) >= .01 AND xcounter < 10 THEN Explosion
            NewPositions
            PCOPY 1, 0
            IF d$ = CHR$(32) THEN hit = 1: EXIT DO
            IF death = 1 THEN death = 0: EXIT SUB
          LOOP
          IF explode = 1 THEN xcounter = 9: Explosion
          IF d$ <> CHR$(32) THEN
            PCSound 7
            Grenade (direction)
            IF grenades > 0 THEN grenades = grenades - 1
            COLOR 3, 0
            LOCATE 42, 2: PRINT "Grenades:" + LTRIM$(STR$(grenades)) + " ";
            tg! = TIMER
          END IF
          SetSound 1
        ELSE
          COLOR 3, 7: LOCATE 42, 11: PRINT "0";
          PCOPY 1, 0
          Delay .1
          COLOR 3, 0: LOCATE 42, 11: PRINT "0";
          COLOR 3, 1
        END IF
      END IF
    CASE "M"                                               'Magic
      IF magic > 0 THEN
        PCSound 9
        magic = magic - 1
        ts! = TIMER
        stone = 1
        COLOR 3, 0
        LOCATE 42, 33: PRINT "Magic:" + LTRIM$(STR$(magic));
        COLOR 3, 1
        PALETTE 1, 7: Delay .1: PALETTE 1, 56
        PALETTE 12, 7
      ELSE
        COLOR 3, 7
        LOCATE 42, 39: PRINT "0";
        PCOPY 1, 0
        Delay .1
        COLOR 3, 0
        LOCATE 42, 39: PRINT "0";
        COLOR 3, 1
      END IF
    CASE "S"                                               'Sound on/off
      SetSound 2
    CASE "P"                                               'Pause
      Pause
    CASE "H"                                               'Help
      QuickStop
      PCOPY 1, 0
      Instructions
      PCOPY 0, 1
      SCREEN 0, , 1, 0
      PALETTE 5, 25
      COLOR 7, 1
      SetTimers
    CASE "Q"                                               'Quit game
      QuickStop
      COLOR 7, 0
      LOCATE 43, 1: PRINT SPACE$(40);
      Center 43, "Do you really want to quit? (Y/N)"
      LOCATE 43, 37: COLOR 23: PRINT "_";
      PCOPY 1, 0
      COLOR 7
      DO
        q$ = UCASE$(INKEY$)
        IF q$ = "Y" THEN cave = 1: score = 0: nohscore = 0: EXIT SUB
        IF q$ = "N" THEN SetSound 1: SetTimers: EXIT DO
      LOOP
    CASE ELSE
  END SELECT
  IF gy = y AND gx = x THEN TheEnd
  IF death = 1 THEN death = 0: EXIT SUB
  IF cave <> oldcave AND death = 0 THEN EXIT DO
  IF hit = 0 AND ABS(TIMER - tg!) >= .01 THEN Grenade (direction): tg! = TIMER
  IF explode = 1 AND ABS(TIMER - te!) >= .01 AND xcounter < 10 THEN Explosion
  IF (TIMER AND 3) = 0 THEN LOCATE dy, dx: COLOR 0: PRINT "X" ELSE LOCATE dy, dx: COLOR 15: PRINT "X"
  IF score <> oldscore THEN
    LOCATE 41, 18: COLOR 3, 0: PRINT "Score:" + LTRIM$(STR$(score)); : COLOR 7, 1
    oldscore = score
  END IF
  NewPositions
  PCOPY 1, 0
LOOP

LOOP

END SUB

SUB Grenade (direction)

COLOR 2

'Manual explosion of grenade
IF trigger = 1 THEN
  trigger = 0
  IF SCREEN(gy, gx) = 32 THEN LOCATE gy, gx: PRINT CHR$(249)
  HitDetection
  EXIT SUB
END IF

'Move the grenade
mcounter = mcounter + 1
SELECT CASE direction
  CASE 1
    IF ftime = 0 THEN gy = y - 1: gx = x: ftime = 1
    IF mcounter = 1 THEN
      HitDetection
    ELSE
      IF SCREEN(gy, gx) = 249 THEN LOCATE gy, gx: PRINT " "
      gy = gy - 1
      mcounter = 0
    END IF
  CASE 2
    IF ftime = 0 THEN gy = y + 1: gx = x: ftime = 1
    IF mcounter = 1 THEN
      HitDetection
    ELSE
      IF SCREEN(gy, gx) = 249 THEN LOCATE gy, gx: PRINT " "
      gy = gy + 1
      mcounter = 0
    END IF
  CASE 3
    IF ftime = 0 THEN gy = y: gx = x - 1: ftime = 1
    IF mcounter = 1 THEN
      HitDetection
    ELSE
      IF SCREEN(gy, gx) = 249 THEN LOCATE gy, gx: PRINT " "
      gx = gx - 1
      mcounter = 0
    END IF
  CASE 4
    IF ftime = 0 THEN gy = y: gx = x + 1: ftime = 1
    IF mcounter = 1 THEN
      HitDetection
    ELSE
      IF SCREEN(gy, gx) = 249 THEN LOCATE gy, gx: PRINT " "
      gx = gx + 1
      mcounter = 0
    END IF
END SELECT

END SUB

SUB HallOfFame

DO

SCREEN 0, , 1, 0

'Title
PALETTE 6, 48
COLOR 15, 6
FOR row = 1 TO 14: LOCATE row, 1: PRINT STRING$(40, 177); : NEXT row
FOR row = 2 TO 13: LOCATE row, 2: PRINT SPACE$(38); : NEXT row
COLOR 7
Center 8, "H A L L   O F   F A M E"

'Dots
COLOR 15, 0
FOR row = 15 TO 43: LOCATE row, 1: PRINT STRING$(40, 176); : NEXT row
FOR row = 20 TO 34: LOCATE row, 1: PRINT SPACE$(40); : NEXT row

'Table
COLOR 7, 0
FOR i = 1 TO 3
  IF i = 1 THEN yi = 22: ds$ = "Easy"
  IF i = 2 THEN yi = 25: ds$ = "Normal"
  IF i = 3 THEN yi = 28: ds$ = "Hard"
  LOCATE yi, 2: IF cr!(i) = 1 THEN COLOR 14: PRINT CHR$(2) ELSE COLOR 13: PRINT CHR$(2)
  COLOR 7
  LOCATE yi, 4: PRINT crname$(i)
  LOCATE yi, 14: PRINT "Score:" + LTRIM$(STR$(hscore!(i)))
  IF cave!(i) <> 7 THEN
    LOCATE yi, 26: PRINT "Cave:" + LTRIM$(STR$(cave!(i)))
  ELSE
    LOCATE yi, 26: PRINT "Cave:" + "X"
  END IF
  LOCATE yi, 34: PRINT ds$
NEXT i

SELECT CASE hscore
  CASE 0
  CASE 1: LOCATE 22, 1: COLOR 22: PRINT "V"
  CASE 2: LOCATE 25, 1: COLOR 22: PRINT "V"
  CASE 3: LOCATE 28, 1: COLOR 22: PRINT "V"
END SELECT
IF hscore <> 0 THEN
  COLOR 6
  Center 31, "CONGRATULATIONS,"
  Center 32, "you're among the victors."
  PCOPY 1, 0
  hscore = 0
  IF speaker = 0 THEN Delay -10
  PCSound 13
  SOUND 0, 0
  LOCATE 22, 1: PRINT " "
  LOCATE 25, 1: PRINT " "
  LOCATE 28, 1: PRINT " "
  LOCATE 31, 1: PRINT SPACE$(40)
  LOCATE 32, 1: PRINT SPACE$(40)
END IF

COLOR 8
Center 31, "Press F1 to clear the table or any"
Center 32, "other key to return to the main menu"
LOCATE 32, 39: COLOR 24: PRINT "_"
PCOPY 1, 0
Delay 0
IF dkey$ = CHR$(0) + CHR$(59) THEN
  fe = 1: table = 1: Initialize: table = 0
ELSE
  EXIT DO
END IF

LOOP

PALETTE 6, 20

END SUB

SUB Highscore

'If a new highscore has been achieved, then save the HoF data
IF nohscore = 1 THEN score = 0: nohscore = 0
ON ERROR GOTO FileError
SELECT CASE ds
  CASE 1
    IF score > hscore!(1) THEN
      cr!(1) = cr: crname$(1) = crname$
      hscore!(1) = score: cave!(1) = cave: hscore = 1
      OPEN "cr.dat" FOR BINARY AS #1
      SEEK #1, 15
      PUT #1, , cr!(1)
      FOR n = 1 TO 8
        letter! = ASC(MID$(crname$(1), n, 1)) / 4
        PUT #1, , letter!
      NEXT n
      PUT #1, , hscore!(1)
      PUT #1, , cave!(1)
      CLOSE #1
      HallOfFame
    END IF
  CASE 2
    IF score > hscore!(2) THEN
      cr!(2) = cr: crname$(2) = crname$
      hscore!(2) = score: cave!(2) = cave: hscore = 2
      OPEN "cr.dat" FOR BINARY AS #1
      SEEK #1, 59
      PUT #1, , cr!(2)
      FOR n = 1 TO 8
        letter! = ASC(MID$(crname$(2), n, 1)) / 4
        PUT #1, , letter!
      NEXT n
      PUT #1, , hscore!(2)
      PUT #1, , cave!(2)
      CLOSE #1
      HallOfFame
    END IF
  CASE 3
    IF score > hscore!(3) THEN
      cr!(3) = cr: crname$(3) = crname$
      hscore!(3) = score: cave!(3) = cave: hscore = 3
      OPEN "cr.dat" FOR BINARY AS #1
      SEEK #1, 103
      PUT #1, , cr!(3)
      FOR n = 1 TO 8
        letter! = ASC(MID$(crname$(3), n, 1)) / 4
        PUT #1, , letter!
      NEXT n
      PUT #1, , hscore!(3)
      PUT #1, , cave!(3)
      CLOSE #1
      HallOfFame
    END IF
END SELECT
ON ERROR GOTO 0

END SUB

SUB HitDetection

check = SCREEN(gy, gx)
IF check <> 32 THEN
  hit = 1: mcounter = 0: ftime = 0
  SELECT CASE check
    CASE 234
      IF cave MOD 3 <> 0 THEN
        PCSound 8
        check = SCREEN(gy, gx, 1)
        IF check = 26 THEN
          score = score + 60: MoveLGM
        ELSE
          score = score + 80: MoveLRM
        END IF
      END IF
    CASE 249, 36, 42, 254, 178, 177, 176
      PCSound 8
    CASE ELSE
  END SELECT
  IF cave MOD 3 = 0 AND check = 234 THEN gy = 1: gx = 1 ELSE explode = 1
ELSE
  LOCATE gy, gx: PRINT CHR$(249)
END IF

END SUB

SUB Initialize

ON ERROR GOTO FileError

OPEN "cr.dat" FOR BINARY AS #1
GET #1, 1, check
IF check <> 1234 THEN fe = 1
GET #1, 5, cr
GET #1, 9, ds
GET #1, 13, speaker
FOR i = 1 TO 3
  GET #1, , cr!(i)
  FOR n = 1 TO 8
    GET #1, , letter!
    crname$(i) = crname$(i) + CHR$(letter! * 4)
  NEXT n
  GET #1, , hscore!(i)
  GET #1, , cave!(i)
NEXT i
CLOSE #1

'If a file error has occurred, then use the standard settings
IF fe = 1 THEN
  fe = 0
  check = 1234
  IF table = 0 THEN    'Not F1 from the HoF
    cr = 1             'Male CR
    ds = 2             'Normal
    speaker = 1        'Sound on
  END IF
  OPEN "cr.dat" FOR BINARY AS #1
  PUT #1, 1, check
  PUT #1, 5, cr
  PUT #1, 9, ds
  PUT #1, 13, speaker
  FOR i = 1 TO 3
    cr!(i) = 1
    PUT #1, , cr!(i)
    FOR n = 1 TO 8
      crname$(i) = "........"
      letter! = ASC(MID$(crname$(i), n, 1)) / 4
      PUT #1, , letter!
    NEXT n
    hscore!(i) = 0
    PUT #1, , hscore!(i)
    cave!(i) = 0
    PUT #1, , cave!(i)
  NEXT i
  CLOSE #1
END IF

ON ERROR GOTO 0
PLAY "mb"
cave = 1

END SUB

SUB Instructions

SCREEN 0, , 1, 1
COLOR 8, 0
FOR row = 1 TO 43: LOCATE row, 1: PRINT STRING$(40, 242); : NEXT row
FOR row = 3 TO 41: LOCATE row, 9: PRINT STRING$(24, 177): NEXT row
FOR row = 4 TO 40: LOCATE row, 10: PRINT SPACE$(22): NEXT row
COLOR 3
Center 5, "How to Play the Game"
Center 6, "--------------------"

COLOR 7
Center 8, "Objective: Get the  "
Center 10, "magic gem, all the  "
Center 12, "gold in the cave and"
Center 14, "finally the magic   "
Center 16, "scroll. Then head   "
Center 18, "for the magic door. "
Center 20, "Don't forget to pick"
Center 22, "up the green chest  "
Center 24, "of grenades because "
Center 26, "you're not alone.   "
Center 28, "Those cave monsters "
Center 30, "not only love their "
Center 32, "gold but also fresh "
Center 34, "meat. Therefore, be "
Center 36, "careful.            "
LOCATE 8, 11: COLOR 15: PRINT "Objective:"
COLOR 8
Center 39, "Press any key  (1/6)"
LOCATE 39, 24: COLOR 24: PRINT "_"

Delay 0
IF dkey$ = CHR$(27) THEN EXIT SUB

PALETTE 5, 5
COLOR 7
Center 8, "Keys: You move the  "
Center 10, "cave raider with the"
Center 12, "arrow keys. If you  "
Center 14, "press Spacebar,     "
Center 16, "you'll be asked in  "
Center 18, "which direction you "
Center 20, "want to launch a    "
Center 22, "grenade. Press an   "
Center 24, "arrow key to fire a "
Center 26, "grenade or Spacebar "
Center 28, "if you changed your "
Center 30, "mind. If you press  "
Center 32, "Spacebar while a    "
Center 34, "grenade is flying   "
Center 36, "through the air, the"
LOCATE 8, 11: COLOR 15: PRINT "Keys:"
COLOR 5
LOCATE 12, 11: PRINT "arrow keys"
LOCATE 14, 17: PRINT "Spacebar"
COLOR 8
Center 39, "Press any key  (2/6)"
LOCATE 39, 24: COLOR 24: PRINT "_"

Delay 0
IF dkey$ = CHR$(27) THEN EXIT SUB

COLOR 7
Center 8, "grenade will explode"
Center 10, "immediately and     "
Center 12, "leave a sign (a     "
Center 14, "white star) on the  "
Center 16, "ground. The magic   "
Center 18, "gem gives you two   "
Center 20, "spells. If you press"
Center 22, "M, the red monsters "
Center 24, "will temporarily    "
Center 26, "turn into stone.    "
Center 28, "The same is true for"
Center 30, "the black monsters  "
Center 32, "that can't be killed"
Center 34, "by grenades due to  "
Center 36, "their magic origin. "
LOCATE 22, 11: COLOR 5: PRINT "M"
COLOR 8
Center 39, "Press any key  (3/6)"
LOCATE 39, 24: COLOR 24: PRINT "_"

Delay 0
IF dkey$ = CHR$(27) THEN EXIT SUB

PALETTE 5, 25
COLOR 7
Center 8, "ASCII characters:   "
Center 10, "  - Male CR         "
Center 12, "  - Female CR       "
Center 14, "  - Rock            "
Center 16, "    (-80 health)    "
Center 18, "  - Rock            "
Center 20, "    (-60 health)    "
Center 22, "  - Rock            "
Center 24, "    (-40 health)    "
Center 26, "  - Gold (50 points)"
Center 28, "  - Chest of        "
Center 30, "    grenades        "
Center 32, "  - Grenade         "
Center 34, "  - Explosion       "
Center 36, "  - Sign            "
LOCATE 8, 11: COLOR 15: PRINT "ASCII characters:"
LOCATE 10, 11: COLOR 14: PRINT CHR$(2)
LOCATE 12, 11: COLOR 13: PRINT CHR$(2)
LOCATE 14, 11: COLOR 15: PRINT CHR$(177)
LOCATE 18, 11: COLOR 7: PRINT CHR$(178)
LOCATE 22, 11: PRINT CHR$(176)
LOCATE 26, 11: COLOR 9: PRINT CHR$(36)
LOCATE 28, 11: COLOR 2: PRINT CHR$(254)
LOCATE 32, 11: PRINT CHR$(249)
LOCATE 34, 11: COLOR 4: PRINT CHR$(15)
LOCATE 36, 11: COLOR 7, 5: PRINT CHR$(42)
COLOR 8, 0
Center 39, "Press any key  (4/6)"
LOCATE 39, 24: COLOR 24: PRINT "_"

Delay 0
IF dkey$ = CHR$(27) THEN EXIT SUB

PALETTE 5, 60
COLOR 7
Center 8, "  - Magic gem       "
Center 10, "    (100 points)    "
Center 12, "  - Magic scroll    "
Center 14, "    (100 points)    "
Center 16, "  - Magic wall      "
Center 18, "  - Magic field of  "
Center 20, "    quicksand       "
Center 22, "  - Cave monster    "
Center 24, "    (60 points)     "
Center 26, "  - Cave monster    "
Center 28, "    (80 points)     "
Center 30, "  - Cave monster    "
Center 32, "    (100 points)    "
Center 34, "  - Magic door      "
Center 36, "    (200 points)    "
LOCATE 8, 11: COLOR 11: PRINT CHR$(4)
LOCATE 12, 11: PRINT CHR$(236)
LOCATE 16, 11: COLOR 9: PRINT CHR$(250)
LOCATE 18, 11: COLOR 6: PRINT CHR$(247)
LOCATE 22, 11: COLOR 10, 1: PRINT CHR$(234)
LOCATE 26, 11: COLOR 5: PRINT CHR$(234)
LOCATE 30, 11: COLOR 0: PRINT CHR$(234)
LOCATE 34, 11: COLOR 15, 0: PRINT "X"
COLOR 8
Center 39, "Press any key  (5/6)"
LOCATE 39, 24: COLOR 24: PRINT "_"

Delay 0
IF dkey$ = CHR$(27) THEN EXIT SUB

COLOR 7
Center 8, "Hints: Analyze each "
Center 10, "cave before you     "
Center 12, "begin. Remember that"
Center 14, "you can't leave a   "
Center 16, "cave if there's a   "
Center 18, "monster at the magic"
Center 20, "door. This is the   "
Center 22, "aim of the green    "
Center 24, "monsters. The others"
Center 26, "will hunt you. It   "
Center 28, "can be a good idea  "
Center 30, "to use one or two   "
Center 32, "signs as barriers.  "
Center 34, "                    "
Center 36, "           Have fun!"
COLOR 15
LOCATE 8, 11: PRINT "Hints:"
LOCATE 36, 22: PRINT "Have fun!"
COLOR 8
Center 39, "Press any key  (6/6)"
LOCATE 39, 24: COLOR 24: PRINT "_"

Delay 0

END SUB

FUNCTION MainMenu

SCREEN 0, , 0, 0

'Title
COLOR 15, 1
FOR row = 1 TO 21: LOCATE row, 1: PRINT STRING$(40, 177): NEXT row
FOR row = 2 TO 20: LOCATE row, 2: PRINT SPACE$(38): NEXT row

COLOR 7
Center 4, " @@@@  @@@  @   @ @@@@@"
Center 5, "@     @   @ @   @ @    "
Center 6, "@     @@@@@ @   @ @@@@ "
Center 7, "@     @   @  @ @  @    "
Center 8, " @@@@ @   @   @   @@@@@"

Center 11, "@@@@   @@@  @ @@@@  @@@@@ @@@@ "
Center 12, "@   @ @   @ @ @   @ @     @   @"
Center 13, "@@@@  @@@@@ @ @   @ @@@@  @@@@ "
Center 14, "@  @  @   @ @ @   @ @     @  @ "
Center 15, "@   @ @   @ @ @@@@  @@@@@ @   @"

COLOR 0
Center 18, "Copyright (c) 2004 by paul redling"

'Main menu
COLOR 8, 0
FOR row = 22 TO 43: LOCATE row, 1: PRINT STRING$(40, 242); : NEXT row
FOR row = 25 TO 39: LOCATE row, 13: PRINT STRING$(16, 177): NEXT row
FOR row = 26 TO 38: LOCATE row, 14: PRINT SPACE$(14): NEXT row

COLOR 9
LOCATE 29, 8: PRINT "$"
LOCATE 30, 7: PRINT "$$$$"
LOCATE 31, 6: PRINT "$"
LOCATE 31, 8: PRINT "$"
LOCATE 32, 7: PRINT "$$$"
LOCATE 33, 8: PRINT "$"
LOCATE 33, 10: PRINT "$"
LOCATE 34, 6: PRINT "$$$$"
LOCATE 35, 8: PRINT "$"

LOCATE 29, 33: PRINT "$"
LOCATE 30, 32: PRINT "$$$$"
LOCATE 31, 31: PRINT "$"
LOCATE 31, 33: PRINT "$"
LOCATE 32, 32: PRINT "$$$"
LOCATE 33, 33: PRINT "$"
LOCATE 33, 35: PRINT "$"
LOCATE 34, 31: PRINT "$$$$"
LOCATE 35, 33: PRINT "$"

COLOR 3
ty = 27
DO
  IF ty = 27 THEN TextBlink: Center 27, "Play        ": COLOR 3 ELSE Center 27, "Play        "
  IF ty = 29 THEN TextBlink: Center 29, "Story       ": COLOR 3 ELSE Center 29, "Story       "
  IF ty = 31 THEN TextBlink: Center 31, "Instructions": COLOR 3 ELSE Center 31, "Instructions"
  IF ty = 33 THEN TextBlink: Center 33, "Hall of Fame": COLOR 3 ELSE Center 33, "Hall of Fame"
  IF ty = 35 THEN TextBlink: Center 35, "Options     ": COLOR 3 ELSE Center 35, "Options     "
  IF ty = 37 THEN TextBlink: Center 37, "Quit        ": COLOR 3 ELSE Center 37, "Quit        "
  IF k$ <> "" THEN Delay .1
  k$ = INKEY$
  IF k$ = CHR$(0) + CHR$(72) THEN ty = ty - 2                      'Up
  IF k$ = CHR$(0) + CHR$(80) THEN ty = ty + 2                      'Down
  IF k$ = CHR$(13) AND ty = 27 THEN MainMenu = 1: EXIT FUNCTION    'Play
  IF k$ = CHR$(13) AND ty = 29 THEN MainMenu = 2: EXIT FUNCTION    'Story
  IF k$ = CHR$(13) AND ty = 31 THEN MainMenu = 3: EXIT FUNCTION    'Instructions
  IF k$ = CHR$(13) AND ty = 33 THEN MainMenu = 4: EXIT FUNCTION    'HallOfFame
  IF k$ = CHR$(13) AND ty = 35 THEN MainMenu = 5: EXIT FUNCTION    'Options
  IF k$ = CHR$(13) AND ty = 37 THEN MainMenu = 6: EXIT FUNCTION    'Quit
  IF ty > 37 THEN ty = 27
  IF ty < 27 THEN ty = 37
LOOP

END FUNCTION

SUB MoveBM STATIC

DIM y(15), x(15), oldy(15), oldx(15)

COLOR 12
IF newcave THEN
  FOR i = 1 TO bmonsters       'The initial positions of the invincible black
    DO                         'monsters that hunt the cave raider.
      SELECT CASE rq3
        CASE 1: y(i) = RandomInt(2, 20): x(i) = RandomInt(2, 20)
        CASE 2: y(i) = RandomInt(21, 39): x(i) = RandomInt(2, 20)
        CASE 3: y(i) = RandomInt(2, 20): x(i) = RandomInt(21, 39)
        CASE 4: y(i) = RandomInt(21, 39): x(i) = RandomInt(21, 39)
      END SELECT
      IF SCREEN(y(i), x(i)) = 32 THEN EXIT DO
    LOOP
    LOCATE y(i), x(i): PRINT CHR$(234)
    oldy(i) = y(i): oldx(i) = x(i)
  NEXT i
  EXIT SUB
END IF

IF scroll = 1 THEN             'If the scroll has been taken, the magic black
  COLOR 0                      'monsters will turn into gems.
  FOR i = 1 TO bmonsters
    LOCATE y(i), x(i): PRINT CHR$(4)
  NEXT i
  EXIT SUB
END IF

'The movements of the black monsters
FOR i = 1 TO bmonsters
  left = SCREEN(y(i), x(i) - 1)                 'Look for possible directions
  right = SCREEN(y(i), x(i) + 1)
  up = SCREEN(y(i) - 1, x(i))
  down = SCREEN(y(i) + 1, x(i))
  IF left = 32 OR left = 2 THEN left = 0
  IF right = 32 OR right = 2 THEN right = 0
  IF up = 32 OR up = 2 THEN up = 0
  IF down = 32 OR down = 2 THEN down = 0
  FOR try = 1 TO 2               'Try to pick a direction towards cave raider
    IF y(i) < y OR y(i) > y THEN
      IF RND > .7 THEN
        IF left = 0 AND x(i) > x THEN x(i) = x(i) - 1: EXIT FOR
        IF right = 0 AND x(i) < x THEN x(i) = x(i) + 1: EXIT FOR
      ELSE
        IF up = 0 AND y(i) > y THEN y(i) = y(i) - 1: EXIT FOR
        IF down = 0 AND y(i) < y THEN y(i) = y(i) + 1: EXIT FOR
      END IF
    ELSE
      IF left = 0 AND x(i) > x THEN x(i) = x(i) - 1: EXIT FOR
      IF right = 0 AND x(i) < x THEN x(i) = x(i) + 1: EXIT FOR
    END IF
  NEXT try
  IF y(i) = oldy(i) AND x(i) = oldx(i) THEN             'If you didn't pick a
    FOR try = 1 TO 8                                    'direction already,
      rn = RandomInt(1, 4)                              'then try to pick a
      IF rn = 1 AND left = 0 THEN x(i) = x(i) - 1: EXIT FOR     'random
      IF rn = 2 AND right = 0 THEN x(i) = x(i) + 1: EXIT FOR    'direction.
      IF rn = 3 AND up = 0 THEN y(i) = y(i) - 1: EXIT FOR
      IF rn = 4 AND down = 0 THEN y(i) = y(i) + 1: EXIT FOR
    NEXT try
  END IF
  IF y(i) <> oldy(i) OR x(i) <> oldx(i) THEN
    LOCATE oldy(i), oldx(i): PRINT " "                  'Erase old position
    LOCATE y(i), x(i): PRINT CHR$(234)                  'Move to new position
    oldy(i) = y(i): oldx(i) = x(i)
  END IF
  IF y(i) = y AND x(i) = x THEN TheEnd: EXIT SUB        'You got cave raider
NEXT i

tbm! = TIMER

END SUB

SUB MoveCR

check = SCREEN(y, x)
IF check = 234 THEN TheEnd                            'Monster
IF check = 178 OR check = 177 OR check = 176 THEN     'Rock
  SELECT CASE check
    CASE 178: health = health - 60
    CASE 177: health = health - 80
    CASE 176: health = health - 40
  END SELECT
  IF health < 0 THEN health = 0
  COLOR 3, 0
  LOCATE 41, 2: PRINT "Health:" + LTRIM$(STR$(health)) + " ";
  COLOR 3, 1
  IF health > 0 THEN
    PCSound 10
    y = oldy: x = oldx
    PCOPY 1, 0
    Delay .5
  ELSE
    TheEnd
  END IF
END IF
IF check = 247 THEN TheEnd                            'Quicksand
IF check = 15 THEN xcounter = 9: Explosion: TheEnd    'Explosion
IF check = 88 THEN                                    'Magic door
  IF SCREEN(y, x - 1) <> 234 AND SCREEN(y, x + 1) <> 234 AND SCREEN(y - 1, x) <> 234 AND SCREEN(y + 1, x) <> 234 AND gem = 1 AND scroll = 1 THEN
    QuickStop
    LOCATE dy, dx: COLOR 11: PRINT "X"
    IF cave < 6 THEN PCSound 11 ELSE PCSound 12
    IF cave < 6 THEN score = score + 200 ELSE score = score + 1000
    LOCATE 41, 18: COLOR 3, 0: PRINT "Score:" + LTRIM$(STR$(score)); : COLOR 7, 1
    IF SCREEN(gy, gx) = 249 THEN LOCATE gy, gx: PRINT " "
    PCOPY 1, 0
    Delay 2
    cave = cave + 1
    EXIT SUB
  ELSE
    TheEnd
  END IF
END IF
IF check = 36 THEN                                    'Piece of gold
  PCSound 1
  score = score + 50
  treasure = treasure + 1
  IF treasure = pgold THEN               'If all the gold has been collected,
    LOCATE sy - 1, sx - 1: PRINT SPACE$(3)         'then erase the magic wall
    LOCATE sy, sx - 1: PRINT " "                   'around the scroll.
    LOCATE sy, sx + 1: PRINT " "
    LOCATE sy + 1, sx - 1: PRINT SPACE$(3)
    PCSound 6
  END IF
END IF
IF check = 254 THEN                                   'Chest of grenades
  PCSound 2
  SELECT CASE ds
    CASE 1: grenades = grenades + 5
    CASE 2: grenades = grenades + 3
    CASE 3: grenades = grenades + 2
  END SELECT
  COLOR 3, 0
  LOCATE 42, 2: PRINT "Grenades:" + LTRIM$(STR$(grenades));
  COLOR 3, 1
END IF
IF check = 4 THEN                                     'Magic gem
  PCSound 3
  score = score + 100
  check = SCREEN(y, x, 1)
  IF check = 27 THEN gem = gem + 1: magic = 2
  COLOR 3, 0
  LOCATE 42, 15: PRINT "Gem:" + LTRIM$(STR$(gem));
  LOCATE 42, 33: PRINT "Magic:" + LTRIM$(STR$(magic));
  COLOR 3, 1
END IF
IF check = 236 THEN                                   'Magic scroll
  PCSound 3
  score = score + 100
  scroll = 1
  Quicksand 0
  COLOR 3, 0
  LOCATE 42, 22: PRINT "Scroll:" + LTRIM$(STR$(scroll));
  COLOR 3, 1
  IF cave MOD 3 = 0 THEN MoveBM
END IF
IF check = 250 THEN TheEnd                          'Magic wall around scroll

IF death = 1 THEN EXIT SUB
IF cr = 1 THEN COLOR 14 ELSE COLOR 13
LOCATE y, x: PRINT CHR$(2)
IF stone = 0 AND cave MOD 3 <> 0 THEN MoveLRM

END SUB

SUB MoveLGM STATIC

DIM y(10), x(10), oldy(10), oldx(10), mdoor(10)

COLOR 10
IF newcave THEN
  FOR i = 1 TO lgmonsters         'The initial positions of the light green
    DO                            'monsters that move towards the magic door.
      SELECT CASE rq1
        CASE 1: y(i) = RandomInt(2, 20): x(i) = RandomInt(2, 20)
        CASE 2: y(i) = RandomInt(21, 39): x(i) = RandomInt(2, 20)
        CASE 3: y(i) = RandomInt(2, 20): x(i) = RandomInt(21, 39)
        CASE 4: y(i) = RandomInt(21, 39): x(i) = RandomInt(21, 39)
      END SELECT
      IF SCREEN(y(i), x(i)) = 32 THEN EXIT DO
    LOOP
    LOCATE y(i), x(i): PRINT CHR$(234)
    oldy(i) = y(i): oldx(i) = x(i)
    mdoor(i) = 0
  NEXT i
  EXIT SUB
END IF

FOR i = 1 TO lgmonsters
  IF y(i) = gy AND x(i) = gx THEN                       'A grenade hit you
    y(i) = 0: x(i) = 0
    EXIT SUB
  END IF
NEXT i

'The movements of the light green monsters
FOR i = 1 TO lgmonsters
  IF y(i) <> 0 AND x(i) <> 0 THEN
    left = SCREEN(y(i), x(i) - 1)               'Look for possible directions
    right = SCREEN(y(i), x(i) + 1)
    up = SCREEN(y(i) - 1, x(i))
    down = SCREEN(y(i) + 1, x(i))
    IF left = 88 OR right = 88 OR up = 88 OR down = 88 THEN mdoor(i) = 1
    IF left = 32 OR left = 2 THEN left = 0
    IF right = 32 OR right = 2 THEN right = 0
    IF up = 32 OR up = 2 THEN up = 0
    IF down = 32 OR down = 2 THEN down = 0
    rn = RandomInt(1, 4)      'Try to pick a direction towards the magic door
    IF rn = 1 AND left = 0 AND x(i) > dx THEN x(i) = x(i) - 1
    IF rn = 2 AND right = 0 AND x(i) < dx THEN x(i) = x(i) + 1
    IF rn = 3 AND up = 0 AND y(i) > dy THEN y(i) = y(i) - 1
    IF rn = 4 AND down = 0 AND y(i) < dy THEN y(i) = y(i) + 1
    IF y(i) = oldy(i) AND x(i) = oldx(i) AND mdoor(i) = 0 THEN    'If you
      IF RND > .7 THEN                                    'didn't pick a
        rn = RandomInt(1, 4)                              'direction already
        IF rn = 1 AND left = 0 THEN x(i) = x(i) - 1       'and you're not at
        IF rn = 2 AND right = 0 THEN x(i) = x(i) + 1      'the magic door,
        IF rn = 3 AND up = 0 THEN y(i) = y(i) - 1         'then pick a random
        IF rn = 4 AND down = 0 THEN y(i) = y(i) + 1       'direction or no
      END IF                                              'direction at all.
    END IF
    IF y(i) <> oldy(i) OR x(i) <> oldx(i) THEN
      LOCATE oldy(i), oldx(i): PRINT " "                'Erase old position
      LOCATE y(i), x(i): PRINT CHR$(234)                'Move to new position
      oldy(i) = y(i): oldx(i) = x(i)
    END IF
    IF y(i) = y AND x(i) = x THEN TheEnd: EXIT SUB      'You got cave raider
  END IF
NEXT i

tlgm! = TIMER

END SUB

SUB MoveLRM STATIC

DIM y(10), x(10), oldy(10), oldx(10)

COLOR 12
IF newcave THEN
  FOR i = 1 TO lrmonsters             'The initial positions of the light red
    DO                                'monsters that hunt the cave raider.
      SELECT CASE rq2
        CASE 1: y(i) = RandomInt(2, 20): x(i) = RandomInt(2, 20)
        CASE 2: y(i) = RandomInt(21, 39): x(i) = RandomInt(2, 20)
        CASE 3: y(i) = RandomInt(2, 20): x(i) = RandomInt(21, 39)
        CASE 4: y(i) = RandomInt(21, 39): x(i) = RandomInt(21, 39)
      END SELECT
      IF SCREEN(y(i), x(i)) = 32 THEN EXIT DO
    LOOP
    LOCATE y(i), x(i): PRINT CHR$(234)
    oldy(i) = y(i): oldx(i) = x(i)
  NEXT i
  EXIT SUB
END IF

FOR i = 1 TO lrmonsters
  IF y(i) = gy AND x(i) = gx THEN                       'A grenade hit you
    y(i) = 0: x(i) = 0
    EXIT SUB
  END IF
NEXT i

'The movements of the light red monsters
FOR i = 1 TO lrmonsters
  IF y(i) <> 0 AND x(i) <> 0 THEN
    left = SCREEN(y(i), x(i) - 1)               'Look for possible directions
    right = SCREEN(y(i), x(i) + 1)
    up = SCREEN(y(i) - 1, x(i))
    down = SCREEN(y(i) + 1, x(i))
    IF left = 32 OR left = 2 THEN left = 0
    IF right = 32 OR right = 2 THEN right = 0
    IF up = 32 OR up = 2 THEN up = 0
    IF down = 32 OR down = 2 THEN down = 0
    FOR try = 1 TO 2             'Try to pick a direction towards cave raider
      IF y(i) < y OR y(i) > y THEN
        IF RND > .7 THEN
          IF left = 0 AND x(i) > x THEN x(i) = x(i) - 1: EXIT FOR
          IF right = 0 AND x(i) < x THEN x(i) = x(i) + 1: EXIT FOR
        ELSE
          IF up = 0 AND y(i) > y THEN y(i) = y(i) - 1: EXIT FOR
          IF down = 0 AND y(i) < y THEN y(i) = y(i) + 1: EXIT FOR
        END IF
      ELSE
        IF left = 0 AND x(i) > x THEN x(i) = x(i) - 1: EXIT FOR
        IF right = 0 AND x(i) < x THEN x(i) = x(i) + 1: EXIT FOR
      END IF
    NEXT try
    IF y(i) = oldy(i) AND x(i) = oldx(i) THEN           'If you didn't pick a
      FOR try = 1 TO 8                                  'direction already,
        rn = RandomInt(1, 4)                            'then try to pick a
        IF rn = 1 AND left = 0 THEN x(i) = x(i) - 1: EXIT FOR     'random
        IF rn = 2 AND right = 0 THEN x(i) = x(i) + 1: EXIT FOR    'direction.
        IF rn = 3 AND up = 0 THEN y(i) = y(i) - 1: EXIT FOR
        IF rn = 4 AND down = 0 THEN y(i) = y(i) + 1: EXIT FOR
      NEXT try
    END IF
    IF y(i) <> oldy(i) OR x(i) <> oldx(i) THEN
      LOCATE oldy(i), oldx(i): PRINT " "                'Erase old position
      LOCATE y(i), x(i): PRINT CHR$(234)                'Move to new position
      oldy(i) = y(i): oldx(i) = x(i)
    END IF
    IF y(i) = y AND x(i) = x THEN TheEnd: EXIT SUB      'You got cave raider
  END IF
NEXT i

tlrm! = TIMER

END SUB

SUB NewPositions

'Checks the TIMER and calls "MoveLGM/MoveLRM/MoveBM" as well as "Quicksand"
IF cave MOD 3 <> 0 THEN
  IF ABS(TIMER - tlgm!) >= .8 THEN MoveLGM
  IF stone = 1 AND ABS(TIMER - ts!) >= 3 THEN PALETTE 12, 60: stone = 0
  IF stone = 0 AND ABS(TIMER - tlrm!) >= 2 THEN MoveLRM
ELSEIF scroll = 0 THEN
  IF stone = 1 AND ABS(TIMER - ts!) >= 3 THEN PALETTE 12, 0: stone = 0
  IF stone = 0 AND ABS(TIMER - tbm!) >= .25 THEN MoveBM
END IF
IF scroll = 0 THEN
  IF ABS(TIMER - tq!) >= 3 THEN LOCATE sy, sx: COLOR 27: PRINT CHR$(236)
  IF ABS(TIMER - tq!) >= 4 THEN
    Quicksand 20
    tq! = TIMER
    LOCATE sy, sx: COLOR 11: PRINT CHR$(236)
  END IF
END IF

END SUB

SUB NextCave

COLOR 8, 0
IF cave = 1 THEN
  FOR row = 1 TO 43: LOCATE row, 1: PRINT STRING$(40, 170); : NEXT row
  FOR row = 10 TO 35: LOCATE row, 11: PRINT STRING$(20, 177): NEXT row
  FOR row = 11 TO 34: LOCATE row, 12: PRINT SPACE$(18): NEXT row
  COLOR 7
  Center 12, "You are about to"
  Center 14, "raid a dangerous"
  Center 16, "cave system.    "
  Center 18, "Fame and riches "
  Center 20, "lie before you. "
  COLOR 3
  Center 24, "What's your     "
  Center 26, "name?           "
  COLOR 7
  LOCATE 26, 19: PRINT "........"
  crname$ = "": column = 19
  DO
    name$ = INKEY$
    IF name$ <> "" AND name$ <> CHR$(8) AND name$ <> CHR$(13) THEN
      SELECT CASE ASC(name$)
        CASE 32: letter = 1
        CASE 65 TO 90: letter = 1
        CASE 97 TO 122: letter = 1
        CASE ELSE
      END SELECT
      IF letter = 1 THEN
        LOCATE 26, column: COLOR 7: PRINT name$: column = column + 1
        LOCATE 26, column: COLOR 23: PRINT "_"
        crname$ = crname$ + name$
        letter = 0
      END IF
    END IF
    IF name$ = CHR$(8) THEN
      IF column > 19 THEN
        LOCATE 26, column: COLOR 7: PRINT "."
        column = column - 1
        LOCATE 26, column: COLOR 23: PRINT "_"
        l = LEN(crname$) - 1
        crname$ = MID$(crname$, 1, l)
      END IF
    END IF
    IF name$ = CHR$(13) THEN
      crname$ = crname$ + SPACE$(8 - LEN(crname$))
      LOCATE 26, 19: COLOR 7: PRINT crname$
      EXIT DO
    END IF
    IF LEN(crname$) = 8 THEN LOCATE 26, 27: PRINT " ": EXIT DO
  LOOP
  IF LEN(LTRIM$(crname$)) = 0 THEN crname$ = "........"
  LOCATE 30, 14: COLOR 7: PRINT "Here's"
  LOCATE 30, 21: COLOR 3: PRINT "Cave:1"
  COLOR 15: Center 33, "Good luck!"
  LOCATE 33, 25: COLOR 31: PRINT "!"
ELSE
  FOR row = 1 TO 43: LOCATE row, 1: PRINT STRING$(40, 170); : NEXT row
  FOR row = 10 TO 35: LOCATE row, 11: PRINT STRING$(20, 177): NEXT row
  FOR row = 11 TO 34: LOCATE row, 12: PRINT SPACE$(18): NEXT row
  COLOR 7
  Center 12, "You're standing "
  Center 14, "at the entrance "
  Center 16, "of              "
  LOCATE 16, 16: COLOR 3: PRINT "Cave:" + LTRIM$(STR$(cave))
  COLOR 7: Center 20, "Your current    "
  COLOR 3: Center 22, "Score:" + LTRIM$(STR$(score))
  COLOR 7
  Center 26, "You're ready to "
  Center 28, "go on.          "
  COLOR 8: Center 33, "Press any key"
  LOCATE 33, 27: COLOR 24: PRINT "_"
END IF

Delay 0
CLS
Delay .5

END SUB

SUB Options

PCOPY 0, 1
SCREEN 0, , 1, 1
COLOR 3, 0
FOR row = 26 TO 38: LOCATE row, 14: PRINT SPACE$(14): NEXT row
Center 27, "Options"
Center 28, "-------"

COLOR 7
IF cr = 1 THEN
  Center 30, "1) CR:Male  "
ELSE
  Center 30, "1) CR:Female"
END IF
IF ds = 2 THEN
  Center 32, "2) DS:Normal"
ELSEIF ds = 3 THEN
  Center 32, "2) DS:Hard  "
ELSEIF ds = 1 THEN
  Center 32, "2) DS:Easy  "
END IF
IF speaker = 1 THEN
  Center 34, "3) Sound on "
ELSE
  Center 34, "3) Sound off"
END IF
COLOR 8: Center 36, "Esc to quit "
LOCATE 36, 26: COLOR 24: PRINT "_"

COLOR 7
DO
  o$ = INKEY$
  SELECT CASE o$
    CASE "1"
      IF cr = 1 THEN
        Center 30, "1) CR:Female"
        cr = 2
      ELSE
        Center 30, "1) CR:Male  "
        cr = 1
      END IF
      change = 1
    CASE "2"
      IF ds = 2 THEN
        Center 32, "2) DS:Hard  "
        ds = 3
      ELSEIF ds = 3 THEN
        Center 32, "2) DS:Easy  "
        ds = 1
      ELSEIF ds = 1 THEN
        Center 32, "2) DS:Normal"
        ds = 2
      END IF
      change = 1
    CASE "3"
      IF speaker = 1 THEN
        Center 34, "3) Sound off"
        speaker = 0
      ELSE
        Center 34, "3) Sound on "
        speaker = 1
      END IF
      change = 1
    CASE CHR$(27)
      IF change = 1 THEN
        COLOR 8: Center 36, "Save (Y/N)  "
        LOCATE 36, 25: COLOR 24: PRINT "_"
        DO
          s$ = UCASE$(INKEY$)
          IF s$ = "N" THEN EXIT DO
          IF s$ = "Y" THEN
            ON ERROR GOTO FileError
            OPEN "cr.dat" FOR BINARY AS #1
            PUT #1, 5, cr
            PUT #1, 9, ds
            PUT #1, 13, speaker
            CLOSE #1
            ON ERROR GOTO 0
            EXIT DO
          END IF
        LOOP
      END IF
      EXIT DO
    CASE ELSE
  END SELECT
LOOP

END SUB

SUB Pause

QuickStop
IF cr = 1 THEN COLOR 30 ELSE COLOR 29
LOCATE y, x: PRINT CHR$(2)
COLOR 7, 0
LOCATE 43, 1: PRINT SPACE$(40);
Center 43, "The game is paused."
PCOPY 1, 0
SLEEP
SetTimers
SetSound 1
IF cr = 1 THEN COLOR 14 ELSE COLOR 13
LOCATE y, x: PRINT CHR$(2)

END SUB

SUB PCSound (number)

IF speaker = 0 THEN EXIT SUB

SELECT CASE number
  CASE 1                                                   'Treasure
    PLAY "mlt80o4l64ce"
  CASE 2                                                   'Chest of grenades
    PLAY "mst120o1l16cl8mlc"
  CASE 3                                                   'Gem/scroll
    PLAY "mlt250o4l64agagag>egg>g"
  CASE 4                                                   'Male CR
    FOR n! = 10.8 TO 8 STEP -.1: SOUND (TAN(n!) + 50) * 25, .5: NEXT n!
  CASE 5                                                   'Female CR
    FOR n! = 10.8 TO 8 STEP -.1: SOUND (TAN(n!) + 50) * 28, .5: NEXT n!
  CASE 6                                                   'Magic wall
    PLAY "mnt180o4l64ed<dc<c<l32f"
  CASE 7                                                   'Grenade launcher
    PLAY "mnt255o1l32ccc"
  CASE 8                                                   'Explosion
    PLAY "mlt255o0l32gbagbagbagbagbabg"
  CASE 9                                                   'Magic
    PLAY "mst255o3l16cdcdg"
  CASE 10                                                  'Rock
    PLAY "mlt255o0l32bagfedc"
  CASE 11                                                  'Exit cave 1-5
    PLAY "mst100o3l16cdel8gp64l16el4mlg"
  CASE 12                                                  'Exit cave 6
    PLAY "mst255o3l4dl8ddl4dl8ddl2mlg"
  CASE 13                                                  'Hall of Fame
    FOR tune = 1 TO 1
      PLAY "mnt190o2l2al4fgafgal2a#l4gaa#gaa#"
      Delay -5: IF dkey$ <> "" THEN EXIT FOR
      PLAY "l2>cl4d.l8<al4aa#fgl2al4gfl1>cl2<a"
      Delay -5: IF dkey$ <> "" THEN EXIT FOR
      PLAY "l4fgafgal2a#l4gaa#gaa#l2>cl4d.l8<a"
      Delay -6: IF dkey$ <> "" THEN EXIT FOR
      PLAY "l4aa#fga>c<a.l8gl1mlf"
      Delay -5
    NEXT tune
END SELECT

END SUB

SUB Quicksand (fields) STATIC

DIM fieldq(2 TO 39, 2 TO 39)

'Erase the magic fields of quicksand and reset the array,
'or simply reset the array.
FOR fqy = 2 TO 39
  FOR fqx = 2 TO 39
    IF fieldq(fqy, fqx) = 1 THEN
      IF fields <> -1 THEN LOCATE fqy, fqx: COLOR 7, 1: PRINT " ";
      fieldq(fqy, fqx) = 0
    END IF
  NEXT fqx
NEXT fqy

'Put new fields of quicksand randomly around the magic scroll
IF fields > 0 THEN
  COLOR 6
  FOR n = 1 TO fields
    DO
      fqx = RandomInt(sx - 5, sx + 5)
      fqy = RandomInt(sy - 5, sy + 5)
      IF fqx >= 2 AND fqx <= 39 AND fqy >= 2 AND fqy <= 39 THEN
        IF SCREEN(fqy, fqx) = 32 THEN EXIT DO
        counter = counter + 1
        IF counter > 10 THEN EXIT DO
      END IF
    LOOP
    IF counter <= 10 THEN
      LOCATE fqy, fqx: PRINT CHR$(247)
      fieldq(fqy, fqx) = 1
    END IF
    counter = 0
  NEXT n
END IF

END SUB

SUB QuickStop

'If the scroll is blinking, stop it
IF scroll = 0 THEN LOCATE sy, sx: COLOR 11: PRINT CHR$(236)

'If there's an explosion, stop it
IF explode = 1 THEN xcounter = 9: Explosion

'Start the timer for the break
tb! = TIMER

END SUB

FUNCTION RandomInt (low, high)

RandomInt = INT(RND * (high - low + 1)) + low

END FUNCTION

SUB SetSound (number)

IF number = 1 THEN
  COLOR 7, 0
  LOCATE 43, 1: PRINT SPACE$(40);
  IF speaker = 1 THEN
    Center 43, "S)ound off    P)ause    H)elp    Q)uit"
  ELSE
    Center 43, " S)ound on    P)ause    H)elp    Q)uit"
  END IF
  COLOR 7, 1
  PCOPY 1, 0
ELSE
  COLOR 7, 0
  IF speaker = 1 THEN
    speaker = 0
    Center 43, " S)ound on    P)ause    H)elp    Q)uit"
  ELSE
    speaker = 1
    Center 43, "S)ound off    P)ause    H)elp    Q)uit"
  END IF
  COLOR 7, 1
  PCOPY 1, 0
END IF

END SUB

SUB SetTimers

'Monsters
tlgm! = TIMER
tlrm! = TIMER
tbm! = TIMER

'Quicksand
tq! = tq! + ABS(TIMER - tb!)

'Magic
IF stone = 1 THEN ts! = ts! + ABS(TIMER - tb!)

END SUB

SUB Story

SCREEN 0, , 1, 1
COLOR 8, 0
FOR row = 1 TO 43: LOCATE row, 1: PRINT STRING$(40, 242); : NEXT row
FOR row = 3 TO 41: LOCATE row, 9: PRINT STRING$(24, 177): NEXT row
FOR row = 4 TO 40: LOCATE row, 10: PRINT SPACE$(22): NEXT row
COLOR 3
Center 5, "Cave Raider"
Center 6, "-----------"

COLOR 7
Center 8, "You are a young man "
Center 10, "( ) or his young    "
Center 12, "girlfriend ( ). You "
Center 14, "both live in a small"
Center 16, "cave near the Rocky "
Center 18, "Mountains and don't "
Center 20, "mind that people    "
Center 22, "think you are a     "
Center 24, "little bit strange. "
Center 26, "You always tell     "
Center 28, "visitors that you   "
Center 30, "work for the state  "
Center 32, "and explore caves.  "
Center 34, "In reality, however,"
Center 36, "each of you is a    "
LOCATE 10, 12: COLOR 14: PRINT CHR$(2)
LOCATE 12, 23: COLOR 13: PRINT CHR$(2)
COLOR 8
Center 39, "Press any key  (1/6)"
LOCATE 39, 24: COLOR 24: PRINT "_"

Delay 0
IF dkey$ = CHR$(27) THEN EXIT SUB

COLOR 7
Center 8, "skilled cave raider."
Center 10, "Your home is full of"
Center 12, "objects from various"
Center 14, "caves, but none of  "
Center 16, "them is worth a lot "
Center 18, "of money. Therefore,"
Center 20, "you're both nearly  "
Center 22, "broke. One morning, "
Center 24, "you read the        "
Center 26, "following short     "
Center 28, "article in the local"
Center 30, "newspaper:          "
Center 32, "                    "
Center 34, "''Great Discovery in"
Center 36, "the Rocky Mountains!"
COLOR 8
Center 39, "Press any key  (2/6)"
LOCATE 39, 24: COLOR 24: PRINT "_"

Delay 0
IF dkey$ = CHR$(27) THEN EXIT SUB

COLOR 7
Center 8, "Yesterday, a film   "
Center 10, "crew of 20 people   "
Center 12, "found an underground"
Center 14, "cave system right   "
Center 16, "next to the place   "
Center 18, "where a small meteor"
Center 20, "allegedly hit the   "
Center 22, "ground a few days   "
Center 24, "ago. 15 people      "
Center 26, "entered the cave    "
Center 28, "system and never    "
Center 30, "returned. The other "
Center 32, "5 people went back  "
Center 34, "home, informed the  "
Center 36, "police and showed   "
COLOR 8
Center 39, "Press any key  (3/6)"
LOCATE 39, 24: COLOR 24: PRINT "_"

Delay 0
IF dkey$ = CHR$(27) THEN EXIT SUB

COLOR 7
Center 8, "some reporters the  "
Center 10, "big piece of gold   "
Center 12, "that lay in front of"
Center 14, "the cave system. Now"
Center 16, "the military is     "
Center 18, "guarding the entire "
Center 20, "area and making     "
Center 22, "investigations.''   "
Center 24, "                    "
Center 26, "Both of you are     "
Center 28, "skeptical at first, "
Center 30, "but after you watch "
Center 32, "a report about this "
Center 34, "discovery on TV, all"
Center 36, "your doubts are     "
COLOR 8
Center 39, "Press any key  (4/6)"
LOCATE 39, 24: COLOR 24: PRINT "_"

Delay 0
IF dkey$ = CHR$(27) THEN EXIT SUB

COLOR 7
Center 8, "gone. You're eager  "
Center 10, "to raid these caves"
Center 12, "as soon as possible."
Center 14, "With the little     "
Center 16, "money that is left, "
Center 18, "you drive to the    "
Center 20, "city to buy some    "
Center 22, "grenades for your   "
Center 24, "grenade launcher.   "
Center 26, "It's not only your  "
Center 28, "favorite weapon but "
Center 30, "also very useful for"
Center 32, "blowing up big      "
Center 34, "rocks. On your way  "
Center 36, "home, you decide to "
COLOR 8
Center 39, "Press any key  (5/6)"
LOCATE 39, 24: COLOR 24: PRINT "_"

Delay 0
IF dkey$ = CHR$(27) THEN EXIT SUB

COLOR 7
Center 8, "raid the cave system"
Center 10, "in the middle of the"
Center 12, "night to avoid any  "
Center 14, "contact with the    "
Center 16, "military. Secretly, "
Center 18, "however, both of you"
Center 20, "have made plans to  "
Center 22, "try it on your own. "
Center 24, "At dusk, one of you "
Center 26, "grabs the grenade   "
Center 28, "launcher and sets   "
Center 30, "out.                "
FOR row = 32 TO 36
  LOCATE row, 11: PRINT SPACE$(20)
NEXT row
COLOR 8
Center 39, "Press any key  (6/6)"
LOCATE 39, 24: COLOR 24: PRINT "_"

Delay 0

END SUB

SUB TextBlink

'MainMenu
IF (TIMER * 100) MOD 6 = 0 THEN COLOR 7 ELSE COLOR 15

END SUB

SUB TheEnd

QuickStop
COLOR 3, 0
LOCATE 41, 2: PRINT "Health:0  ";
COLOR 15, 1
LOCATE dy, dx: PRINT "X"
IF SCREEN(gy, gx) = 249 THEN LOCATE gy, gx: PRINT " "

check = SCREEN(y, x)
IF check <> 32 AND check <> 42 AND check <> 2 THEN IF cr = 1 THEN PCSound 4 ELSE PCSound 5
SELECT CASE check
  CASE 234                                          'Monster
    check = SCREEN(y, x, 1)
    IF check = 26 THEN
      COLOR 10, 4
    ELSE
      COLOR 12, 4
      IF cave MOD 3 <> 0 THEN PALETTE 12, 60 ELSE PALETTE 12, 0
    END IF
    LOCATE y, x: PRINT CHR$(234)
  CASE 247                                          'Quicksand
  CASE 32, 42, 2                                    '"Explosion" or "grenade"
    IF check = 2 THEN PCSound 8
    LOCATE y, x: COLOR 14: PRINT CHR$(15): PCOPY 1, 0: Delay .2
    LOCATE y, x: COLOR 4: PRINT CHR$(15): PCOPY 1, 0: Delay .2
    LOCATE y, x: PRINT " "
  CASE ELSE                     'Rock, magic door or magic wall around scroll
    PCOPY 1, 0
    Delay .5
    LOCATE oldy, oldx: COLOR 4: PRINT CHR$(2)
END SELECT
PCOPY 1, 0

Delay 2
SCREEN 0, , 0, 0

EndScreen
Highscore

SetTimers
cave = 1
oldcave = cave
score = 0
death = 1

END SUB

