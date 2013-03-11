CHDIR ".\programs\samples\pete\wetspot"

' WETSPOT v0.9
' by Angelo Mottola (C) 1996
'
' --------------------------------------------------------------------------
' Well, this is my first game written in QBASIC.
' Sorry, but I haven't so much time to add comments to this source, but
' I think it's pretty simple to understand.
' The target of this game is to kill every monster in less than 90 seconds
' to gain next level. You control a little crab, and you must push bricks
' towards your enemies to kill them. If you push a brick and besides it
' there is another one, the block you pushed on will be destroyed, maybe
' dropping a bonus. Bonuses are various, and someone has a particular
' function (For example: Lightning will destroy every monster on the screen).
' Not all bricks can be moved. Each level has three special blocks, and when
' you put them together, you gain a special multiplier bonus (2x or 3x if
' you put together two or three blocks).
' Look out for monsters that follow you and good luck!!
'
' Controls are:
'
'        Player One              Player Two                 General
'         Left:  4                Left:  A                  Pause: P
'         Right: 6                Right: D                  Quit:  ESC
'         Up:    8                Up:    W      
'         Down:  5                Down:  S
'         Fire:  \                Fire:  ENTER
'
' Since this is not the final version, it contains only 21 levels.
' Final version will contain:
'
' - 100 levels (I hope so...)
' - 8 different enemies
' - Sound Blaster music and sound effects
'
' If you have any suggestion, mail me at
'                           
'                                ----------
'                                eri@cdc.it
'                                ----------
'
' --------------------------------------------------------------------------
'
'$DYNAMIC
DEFINT A-Z
DECLARE SUB Intro ()
DECLARE SUB MainMenu ()
DECLARE SUB GetSprites ()
DECLARE SUB PlayGame ()
DECLARE SUB OutText (x, y, t$)
DECLARE SUB PrintStatBar ()
DECLARE SUB LoadLevel ()
DECLARE SUB DrawScreen ()
DECLARE SUB Center (y, t$)
DECLARE SUB Message (t$)
DECLARE SUB CheckBlocks ()
DECLARE SUB CheckObjects ()
DECLARE SUB MoveEnemies ()
DECLARE SUB KillPlayer (num)
DECLARE SUB PrintValue (xv, yv, va)
DECLARE SUB Delay (sbDT!)
DECLARE FUNCTION PlayAgain ()

TYPE BlockType
  Status AS INTEGER
  JustMoved AS INTEGER
  MovedBy AS INTEGER
  x AS INTEGER
  y AS INTEGER
END TYPE
TYPE PlayerType
  Score AS LONG
  Lives AS INTEGER
  NextLife AS LONG
  BonusE AS INTEGER
  BonusX AS INTEGER
  BonusT AS INTEGER
  BonusR AS INTEGER
  BonusA AS INTEGER
  Bonus AS INTEGER
  x AS INTEGER
  y AS INTEGER
  dir AS INTEGER
  NextDir AS INTEGER
  Spd AS INTEGER
  Cutter AS INTEGER
  Action AS INTEGER
  Frame AS INTEGER
  FrameDir AS INTEGER
  Special AS INTEGER
  Trapped AS INTEGER
END TYPE
TYPE ObjectType
  Typ AS INTEGER
  Time AS INTEGER
  x AS INTEGER
  y AS INTEGER
  Alone AS INTEGER
END TYPE
TYPE EnemyType
  Typ AS INTEGER
  dir AS INTEGER
  x AS INTEGER
  y AS INTEGER
  Flag1 AS INTEGER
  Flag2 AS INTEGER
  Flag3 AS INTEGER
  Changed AS INTEGER
END TYPE

CONST NONE = 0, MOVE = 1, FIRE = 2, NORMAL = 0, POTION = 1, WEB = -1
CONST INACTIVE = 0, FIXEDBLOCK = 1, NORMALBLOCK = 2, SPECIALBLOCK = 3
CONST NMOVINGDOWN = 4, NMOVINGRIGHT = 5, NMOVINGUP = 6, NMOVINGLEFT = 7
CONST SMOVINGDOWN = 8, SMOVINGRIGHT = 9, SMOVINGUP = 10, SMOVINGLEFT = 11
CONST FALSE = 0, TRUE = NOT FALSE

DIM SHARED Cel(18, 12), Player(2) AS PlayerType, Block(170) AS BlockType
DIM SHARED Object(60) AS ObjectType, Enemy(20) AS EnemyType
DIM SHARED Crab&(100 * 40), Expl&(100 * 3), Wall&(100), CutHole&(100)
DIM SHARED Hole&(100), Life&(20 * 2), Clock&(20), Flag&(20)
DIM SHARED Number&(10 * 10), Disapp&(4 * 100), Null&(100)
DIM SHARED Char&(20 * 46), FBlock&(100), NBlock&(100), SBlock&(100)
DIM SHARED Obj&(100 * 27), Ball&(100 * 6), Ghost&(100 * 4), Slug&(100 * 10)
DIM SHARED Robot&(100 * 16), Shadow&(100 * 12), Worm&(100 * 16)
DIM SHARED Putty&(100 * 20), Spider&(100 * 19), Box&(1000), Killed
DIM SHARED NumPlayer, Fx, Speed, Level, TimeLeft, s$(2), Pass, Value(10)
DIM SHARED NumBlock, NumEnemy, NumObject, AbortGame, xA(4), yA(4)
DIM SHARED Bonus(20), PotNum, Freezed, GameMode, Multi#, LastTime$
DIM SHARED BonusAlone, Change, NumChange, NumWeb, MaxLevel

xA(0) = 0: yA(0) = 0
xA(1) = 0: yA(1) = 1
xA(2) = 1: yA(2) = 0
xA(3) = 0: yA(3) = -1
xA(4) = -1: yA(4) = 0
RESTORE
FOR i = 1 TO 4: READ xA(i), yA(i): NEXT i
FOR i = 1 TO 8: READ Value(i): NEXT i


'ON ERROR GOTO ErrorHandle

SCREEN 13
GetSprites
Intro
DO
  MainMenu
  PlayGame
  IF NOT PlayAgain THEN EXIT DO
LOOP

SCREEN 0: WIDTH 80
PRINT "WetSpot v0.9"
PRINT "(C) by Angelo Mottola soft 1996"
  PRINT : PRINT "Final release will include:"
  PRINT " - 100 levels (I hope so...)"
  PRINT " - 8 different enemies"
  PRINT " - Sound Blaster Music and sound effects"
  PRINT " - More and more fun !!"
  PRINT : PRINT "Coming soon..."
  PRINT : END

ErrorHandle:
SCREEN 0: WIDTH 80: CLS
COLOR 15, 1: LOCATE 1, 1: PRINT SPACE$(80);
LOCATE 1, 1: PRINT "ERROR: ";
SELECT CASE ERR
CASE 53: PRINT "Game file not found !";
CASE 61: PRINT "Disk full or error accessing disk.";
CASE 70: PRINT "Disk access denied !";
CASE 71: PRINT "Error accessing disk !";
CASE ELSE: PRINT "Abnormal program termination (error code:", ERR, ").";
END SELECT
COLOR 7, 0: LOCATE 2, 1: PRINT "Coming back to system ..."
END

DATA 0,1,1,0,0,-1,-1,0,100,150,200,250,200,350,300,400,20,20

REM $STATIC
SUB Center (y, t$)
x = (320 - (LEN(t$) * 7)) / 2
OutText x, y, t$
END SUB

SUB CheckBlocks
FOR B = 1 TO 170
  IF Block(B).Status <> 0 THEN
    SELECT CASE Block(B).Status
    CASE IS > 3
      PUT (Block(B).x * 16, -8 + (Block(B).y * 16)), Null&, PSET
      SELECT CASE Block(B).Status
      CASE NMOVINGDOWN
        IF Cel(Block(B).x, Block(B).y + 1) < 1 THEN
          Cel(Block(B).x, Block(B).y) = 0: Block(B).y = Block(B).y + 1
          Cel(Block(B).x, Block(B).y) = NORMALBLOCK
          FOR nb = 1 TO 170
            IF Block(nb).x = Block(B).x AND Block(nb).y = Block(B).y AND nb <> B THEN Block(nb).Status = 0: EXIT FOR
          NEXT nb
          PUT (Block(B).x * 16, -8 + (Block(B).y * 16)), NBlock&, PSET
          Block(B).JustMoved = FALSE
        ELSE
          IF Block(B).JustMoved = FALSE THEN
            Block(B).Status = NORMALBLOCK
            PUT (Block(B).x * 16, -8 + (Block(B).y * 16)), NBlock&, PSET
          ELSE
            FOR o = 1 TO 60
              IF Object(o).Typ = 0 AND Object(o + 1).Typ = 0 THEN EXIT FOR
            NEXT o
            Player(Block(B).MovedBy).Score = Player(Block(B).MovedBy).Score + (10 * Multi#): PrintStatBar
            Object(o).Typ = -3: Object(o).Time = 1: Object(o).Alone = FALSE
            Object(o).x = Block(B).x * 16: Object(o).y = -8 + (Block(B).y * 16)
            Block(B).Status = NONE: Cel(Block(B).x, Block(B).y) = 0
            PUT (Block(B).x * 16, -8 + (Block(B).y * 16)), Null&, PSET
            RANDOMIZE TIMER
            m = INT(RND(1) * 3) + 1
            IF m = 1 THEN
              w = INT(RND(1) * 20) + 1
              IF Bonus(w) = 15 THEN Bonus(w) = 14
              Object(o + 1).Typ = Bonus(w): Object(o + 1).Time = 50
              Object(o + 1).x = Block(B).x * 16: Object(o + 1).y = -8 + (Block(B).y * 16)
            END IF
          END IF
        END IF
      CASE SMOVINGDOWN
        IF Cel(Block(B).x, Block(B).y + 1) < 1 THEN
          Cel(Block(B).x, Block(B).y) = 0: Block(B).y = Block(B).y + 1
          Cel(Block(B).x, Block(B).y) = SPECIALBLOCK
          FOR nb = 1 TO 170
            IF Block(nb).x = Block(B).x AND Block(nb).y = Block(B).y AND nb <> B THEN Block(nb).Status = 0: EXIT FOR
          NEXT nb
          PUT (Block(B).x * 16, -8 + (Block(B).y * 16)), SBlock&, PSET
          Block(B).JustMoved = FALSE
        ELSE
          IF Block(B).JustMoved = FALSE THEN
            Block(B).Status = SPECIALBLOCK
            PUT (Block(B).x * 16, -8 + (Block(B).y * 16)), SBlock&, PSET
          ELSE
            FOR o = 1 TO 60
              IF Object(o).Typ = 0 AND Object(o + 1).Typ = 0 THEN EXIT FOR
            NEXT o
            Player(Block(B).MovedBy).Score = Player(Block(B).MovedBy).Score + (10 * Multi#): PrintStatBar
            Object(o).Typ = -3: Object(o).Time = 1: Object(o).Alone = FALSE
            Object(o).x = Block(B).x * 16: Object(o).y = -8 + (Block(B).y * 16)
            Block(B).Status = NONE: Cel(Block(B).x, Block(B).y) = 0
            PUT (Block(B).x * 16, -8 + (Block(B).y * 16)), Null&, PSET
            RANDOMIZE TIMER
            m = INT(RND(1) * 3) + 1
            IF m = 1 THEN
              w = INT(RND(1) * 20) + 1
              IF Bonus(w) = 15 THEN Bonus(w) = 14
              Object(o + 1).Typ = Bonus(w): Object(o + 1).Time = 50
              Object(o + 1).x = Block(B).x * 16: Object(o + 1).y = -8 + (Block(B).y * 16)
            END IF
          END IF
        END IF
      CASE NMOVINGRIGHT
        IF Cel(Block(B).x + 1, Block(B).y) < 1 THEN
          Cel(Block(B).x, Block(B).y) = 0: Block(B).x = Block(B).x + 1
          Cel(Block(B).x, Block(B).y) = NORMALBLOCK
          FOR nb = 1 TO 170
            IF Block(nb).x = Block(B).x AND Block(nb).y = Block(B).y AND nb <> B THEN Block(nb).Status = 0: EXIT FOR
          NEXT nb
          PUT (Block(B).x * 16, -8 + (Block(B).y * 16)), NBlock&, PSET
          Block(B).JustMoved = FALSE
        ELSE
          IF Block(B).JustMoved = FALSE THEN
            Block(B).Status = NORMALBLOCK
            PUT (Block(B).x * 16, -8 + (Block(B).y * 16)), NBlock&, PSET
          ELSE
            FOR o = 1 TO 60
              IF Object(o).Typ = 0 AND Object(o + 1).Typ = 0 THEN EXIT FOR
            NEXT o
            Player(Block(B).MovedBy).Score = Player(Block(B).MovedBy).Score + (10 * Multi#): PrintStatBar
            Object(o).Typ = -3: Object(o).Time = 1: Object(o).Alone = FALSE
            Object(o).x = Block(B).x * 16: Object(o).y = -8 + (Block(B).y * 16)
            Block(B).Status = NONE: Cel(Block(B).x, Block(B).y) = 0
            PUT (Block(B).x * 16, -8 + (Block(B).y * 16)), Null&, PSET
            RANDOMIZE TIMER
            m = INT(RND(1) * 3) + 1
            IF m = 1 THEN
              w = INT(RND(1) * 20) + 1
              IF Bonus(w) = 15 THEN Bonus(w) = 14
              Object(o + 1).Typ = Bonus(w): Object(o + 1).Time = 50
              Object(o + 1).x = Block(B).x * 16: Object(o + 1).y = -8 + (Block(B).y * 16)
            END IF
          END IF
        END IF
      CASE SMOVINGRIGHT
        IF Cel(Block(B).x + 1, Block(B).y) < 1 THEN
          Cel(Block(B).x, Block(B).y) = 0: Block(B).x = Block(B).x + 1
          Cel(Block(B).x, Block(B).y) = SPECIALBLOCK
          FOR nb = 1 TO 170
            IF Block(nb).x = Block(B).x AND Block(nb).y = Block(B).y AND nb <> B THEN Block(nb).Status = 0: EXIT FOR
          NEXT nb
          PUT (Block(B).x * 16, -8 + (Block(B).y * 16)), SBlock&, PSET
          Block(B).JustMoved = FALSE
        ELSE
          IF Block(B).JustMoved = FALSE THEN
            Block(B).Status = SPECIALBLOCK
            PUT (Block(B).x * 16, -8 + (Block(B).y * 16)), SBlock&, PSET
          ELSE
            FOR o = 1 TO 60
              IF Object(o).Typ = 0 AND Object(o + 1).Typ = 0 THEN EXIT FOR
            NEXT o
            Player(Block(B).MovedBy).Score = Player(Block(B).MovedBy).Score + (10 * Multi#): PrintStatBar
            Object(o).Typ = -3: Object(o).Time = 1: Object(o).Alone = FALSE
            Object(o).x = Block(B).x * 16: Object(o).y = -8 + (Block(B).y * 16)
            Block(B).Status = NONE: Cel(Block(B).x, Block(B).y) = 0
            PUT (Block(B).x * 16, -8 + (Block(B).y * 16)), Null&, PSET
            RANDOMIZE TIMER
            m = INT(RND(1) * 3) + 1
            IF m = 1 THEN
              w = INT(RND(1) * 20) + 1
              IF Bonus(w) = 15 THEN Bonus(w) = 14
              Object(o + 1).Typ = Bonus(w): Object(o + 1).Time = 50
              Object(o + 1).x = Block(B).x * 16: Object(o + 1).y = -8 + (Block(B).y * 16)
            END IF
          END IF
        END IF
      CASE NMOVINGUP
        IF Cel(Block(B).x, Block(B).y - 1) < 1 THEN
          Cel(Block(B).x, Block(B).y) = 0: Block(B).y = Block(B).y - 1
          Cel(Block(B).x, Block(B).y) = NORMALBLOCK
          FOR nb = 1 TO 170
            IF Block(nb).x = Block(B).x AND Block(nb).y = Block(B).y AND nb <> B THEN Block(nb).Status = 0: EXIT FOR
          NEXT nb
          PUT (Block(B).x * 16, -8 + (Block(B).y * 16)), NBlock&, PSET
          Block(B).JustMoved = FALSE
        ELSE
          IF Block(B).JustMoved = FALSE THEN
            Block(B).Status = NORMALBLOCK
            PUT (Block(B).x * 16, -8 + (Block(B).y * 16)), NBlock&, PSET
          ELSE
            FOR o = 1 TO 60
              IF Object(o).Typ = 0 AND Object(o + 1).Typ = 0 THEN EXIT FOR
            NEXT o
            Player(Block(B).MovedBy).Score = Player(Block(B).MovedBy).Score + (10 * Multi#): PrintStatBar
            Object(o).Typ = -3: Object(o).Time = 1: Object(o).Alone = FALSE
            Object(o).x = Block(B).x * 16: Object(o).y = -8 + (Block(B).y * 16)
            Block(B).Status = NONE: Cel(Block(B).x, Block(B).y) = 0
            PUT (Block(B).x * 16, -8 + (Block(B).y * 16)), Null&, PSET
            RANDOMIZE TIMER
            m = INT(RND(1) * 3) + 1
            IF m = 1 THEN
              w = INT(RND(1) * 20) + 1
              IF Bonus(w) = 15 THEN Bonus(w) = 14
              Object(o + 1).Typ = Bonus(w): Object(o + 1).Time = 50
              Object(o + 1).x = Block(B).x * 16: Object(o + 1).y = -8 + (Block(B).y * 16)
            END IF
          END IF
        END IF
      CASE SMOVINGUP
        IF Cel(Block(B).x, Block(B).y - 1) < 1 THEN
          Cel(Block(B).x, Block(B).y) = 0: Block(B).y = Block(B).y - 1
          Cel(Block(B).x, Block(B).y) = SPECIALBLOCK
          FOR nb = 1 TO 170
            IF Block(nb).x = Block(B).x AND Block(nb).y = Block(B).y AND nb <> B THEN Block(nb).Status = 0: EXIT FOR
          NEXT nb
          PUT (Block(B).x * 16, -8 + (Block(B).y * 16)), SBlock&, PSET
          Block(B).JustMoved = FALSE
        ELSE
          IF Block(B).JustMoved = FALSE THEN
            Block(B).Status = SPECIALBLOCK
            PUT (Block(B).x * 16, -8 + (Block(B).y * 16)), SBlock&, PSET
          ELSE
            FOR o = 1 TO 60
              IF Object(o).Typ = 0 AND Object(o + 1).Typ = 0 THEN EXIT FOR
            NEXT o
            Player(Block(B).MovedBy).Score = Player(Block(B).MovedBy).Score + (10 * Multi#): PrintStatBar
            Object(o).Typ = -3: Object(o).Time = 1: Object(o).Alone = FALSE
            Object(o).x = Block(B).x * 16: Object(o).y = -8 + (Block(B).y * 16)
            Block(B).Status = NONE: Cel(Block(B).x, Block(B).y) = 0
            PUT (Block(B).x * 16, -8 + (Block(B).y * 16)), Null&, PSET
            RANDOMIZE TIMER
            m = INT(RND(1) * 3) + 1
            IF m = 1 THEN
              w = INT(RND(1) * 20) + 1
              IF Bonus(w) = 15 THEN Bonus(w) = 14
              Object(o + 1).Typ = Bonus(w): Object(o + 1).Time = 50
              Object(o + 1).x = Block(B).x * 16: Object(o + 1).y = -8 + (Block(B).y * 16)
            END IF
          END IF
        END IF
      CASE NMOVINGLEFT
        IF Cel(Block(B).x - 1, Block(B).y) < 1 THEN
          Cel(Block(B).x, Block(B).y) = 0: Block(B).x = Block(B).x - 1
          Cel(Block(B).x, Block(B).y) = NORMALBLOCK
          FOR nb = 1 TO 170
            IF Block(nb).x = Block(B).x AND Block(nb).y = Block(B).y AND nb <> B THEN Block(nb).Status = 0: EXIT FOR
          NEXT nb
          PUT (Block(B).x * 16, -8 + (Block(B).y * 16)), NBlock&, PSET
          Block(B).JustMoved = FALSE
        ELSE
          IF Block(B).JustMoved = FALSE THEN
            Block(B).Status = NORMALBLOCK
            PUT (Block(B).x * 16, -8 + (Block(B).y * 16)), NBlock&, PSET
          ELSE
            FOR o = 1 TO 60
              IF Object(o).Typ = 0 AND Object(o + 1).Typ = 0 THEN EXIT FOR
            NEXT o
            Player(Block(B).MovedBy).Score = Player(Block(B).MovedBy).Score + (10 * Multi#): PrintStatBar
            Object(o).Typ = -3: Object(o).Time = 1: Object(o).Alone = FALSE
            Object(o).x = Block(B).x * 16: Object(o).y = -8 + (Block(B).y * 16)
            Block(B).Status = NONE: Cel(Block(B).x, Block(B).y) = 0
            PUT (Block(B).x * 16, -8 + (Block(B).y * 16)), Null&, PSET
            RANDOMIZE TIMER
            m = INT(RND(1) * 3) + 1
            IF m = 1 THEN
              w = INT(RND(1) * 20) + 1
              IF Bonus(w) = 15 THEN Bonus(w) = 14
              Object(o + 1).Typ = Bonus(w): Object(o + 1).Time = 50
              Object(o + 1).x = Block(B).x * 16: Object(o + 1).y = -8 + (Block(B).y * 16)
            END IF
          END IF
        END IF
      CASE SMOVINGLEFT
        IF Cel(Block(B).x - 1, Block(B).y) < 1 THEN
          Cel(Block(B).x, Block(B).y) = 0: Block(B).x = Block(B).x - 1
          Cel(Block(B).x, Block(B).y) = SPECIALBLOCK
          FOR nb = 1 TO 170
            IF Block(nb).x = Block(B).x AND Block(nb).y = Block(B).y AND nb <> B THEN Block(nb).Status = 0: EXIT FOR
          NEXT nb
          PUT (Block(B).x * 16, -8 + (Block(B).y * 16)), SBlock&, PSET
          Block(B).JustMoved = FALSE
        ELSE
          IF Block(B).JustMoved = FALSE THEN
            Block(B).Status = SPECIALBLOCK
            PUT (Block(B).x * 16, -8 + (Block(B).y * 16)), SBlock&, PSET
          ELSE
            FOR o = 1 TO 60
              IF Object(o).Typ = 0 AND Object(o + 1).Typ = 0 THEN EXIT FOR
            NEXT o
            Player(Block(B).MovedBy).Score = Player(Block(B).MovedBy).Score + (10 * Multi#): PrintStatBar
            Object(o).Typ = -3: Object(o).Time = 1: Object(o).Alone = FALSE
            Object(o).x = Block(B).x * 16: Object(o).y = -8 + (Block(B).y * 16)
            Block(B).Status = NONE: Cel(Block(B).x, Block(B).y) = 0
            PUT (Block(B).x * 16, -8 + (Block(B).y * 16)), Null&, PSET
            RANDOMIZE TIMER
            m = INT(RND(1) * 3) + 1
            IF m = 1 THEN
              w = INT(RND(1) * 20) + 1
              IF Bonus(w) = 15 THEN Bonus(w) = 14
              Object(o + 1).Typ = Bonus(w): Object(o + 1).Time = 50
              Object(o + 1).x = Block(B).x * 16: Object(o + 1).y = -8 + (Block(B).y * 16)
            END IF
          END IF
        END IF
      END SELECT
      xb = Block(B).x * 16: yb = -8 + (Block(B).y * 16)
      FOR e = 1 TO 20
        IF Enemy(e).Typ <> 0 THEN
          IF Enemy(e).x > xb - 16 AND Enemy(e).x < xb + 16 THEN
            IF Enemy(e).y > yb - 16 AND Enemy(e).y < yb + 16 THEN
              FOR o = 1 TO 60: IF Object(o).Typ = 0 AND Object(o + 1).Typ = 0 THEN EXIT FOR
              NEXT o
              Object(o).Typ = -3: Object(o).Time = 1
              Object(o).x = Enemy(e).x: Object(o).y = -8 + Enemy(e).y
              PUT (Enemy(e).x, -8 + Enemy(e).y), Null&, PSET
              IF Enemy(e).Typ = 3 AND Enemy(e).Flag3 <> 0 THEN PUT (Enemy(e).Flag1, -8 + Enemy(e).Flag2), Null&, PSET
              Object(o + 1).Typ = (Value(Enemy(e).Typ) * Multi#): Object(o + 1).Time = 50
              Object(o + 1).x = Enemy(e).x: Object(o + 1).y = -8 + Enemy(e).y
              NumEnemy = NumEnemy - 1
              Player(Block(B).MovedBy).Score = Player(Block(B).MovedBy).Score + (Value(Enemy(e).Typ) * Multi#)
              Enemy(e).Typ = 0: PrintStatBar
            END IF
          END IF
        END IF
      NEXT e
      FOR u = 1 TO NumPlayer
        IF Player(u).x > xb - 16 AND Player(u).x < xb + 16 THEN
          IF -8 + Player(u).y > yb - 16 AND -8 + Player(u).y < yb + 16 THEN
            KillPlayer u
            Player(u).Lives = Player(u).Lives - 1
            Killed = TRUE: PrintStatBar
          END IF
        END IF
      NEXT u
    CASE FIXEDBLOCK
      PUT (Block(B).x * 16, -8 + (Block(B).y * 16)), FBlock&, PSET
    CASE NORMALBLOCK
      PUT (Block(B).x * 16, -8 + (Block(B).y * 16)), NBlock&, PSET
    CASE SPECIALBLOCK
      PUT (Block(B).x * 16, -8 + (Block(B).y * 16)), SBlock&, PSET
      IF Multi# = 1 THEN
        IF Cel(Block(B).x + 1, Block(B).y) = SPECIALBLOCK THEN Multi# = 2
        IF Cel(Block(B).x - 1, Block(B).y) = SPECIALBLOCK THEN Multi# = 2
        IF Cel(Block(B).x, Block(B).y + 1) = SPECIALBLOCK THEN Multi# = 2
        IF Cel(Block(B).x, Block(B).y - 1) = SPECIALBLOCK THEN Multi# = 2
      END IF
      IF Multi# = 2 THEN
        IF (Cel(Block(B).x, Block(B).y + 1) = SPECIALBLOCK) AND (Cel(Block(B).x, Block(B).y - 1) = SPECIALBLOCK) THEN Multi# = 3
        IF (Cel(Block(B).x + 1, Block(B).y) = SPECIALBLOCK) AND (Cel(Block(B).x - 1, Block(B).y) = SPECIALBLOCK) THEN Multi# = 3
      END IF
    CASE WEB
      PUT (Block(B).x * 16, -8 + (Block(B).y * 16)), Spider&(1600), PSET
    END SELECT
  END IF
NEXT B

END SUB

SUB CheckObjects
FOR o = 1 TO 60
  IF Object(o).Typ <> 0 THEN
    Object(o).Time = Object(o).Time - 1
    SELECT CASE Object(o).Typ
    CASE -7
      PUT (Object(o).x, Object(o).y), Disapp&(0), PSET
      IF Object(o).Time = 0 THEN Object(o).Typ = -6: Object(o).Time = 3
    CASE -6
      PUT (Object(o).x, Object(o).y), Disapp&(100), PSET
      IF Object(o).Time = 0 THEN Object(o).Typ = -5: Object(o).Time = 3
    CASE -5
      PUT (Object(o).x, Object(o).y), Disapp&(200), PSET
      IF Object(o).Time = 0 THEN Object(o).Typ = -4: Object(o).Time = 3
    CASE -4
      PUT (Object(o).x, Object(o).y), Disapp&(300), PSET
      IF Object(o).Time = 0 THEN Object(o).Typ = 0: PUT (Object(o).x, Object(o).y), Null&, PSET
    CASE -3
      PUT (Object(o).x, Object(o).y), Expl&(0), PSET
      IF Object(o).Time = 0 THEN Object(o).Typ = -2: Object(o).Time = 1
    CASE -2
      PUT (Object(o).x, Object(o).y), Expl&(100), PSET
      IF Object(o).Time = 0 THEN Object(o).Typ = -1: Object(o).Time = 1
    CASE -1
      PUT (Object(o).x, Object(o).y), Expl&(200), PSET
      IF Object(o).Time = 0 THEN Object(o).Typ = 0: PUT (Object(o).x, Object(o).y), Null&, PSET
    CASE 1 TO 27
      PUT (Object(o).x, Object(o).y), Obj&((Object(o).Typ - 1) * 100), PSET
      FOR p = 1 TO NumPlayer
        IF Object(o).x > Player(p).x - 16 AND Object(o).x < Player(p).x + 16 THEN
          IF Object(o).y > Player(p).y - 24 AND Object(o).y < Player(p).y + 8 THEN
            SELECT CASE Object(o).Typ
            CASE 1 TO 9
              IF Object(o).Alone = TRUE THEN Object(o).Alone = FALSE: BonusAlone = FALSE
              Player(p).Score = Player(p).Score + ((Object(o).Typ * 100) * Multi#)
              PrintStatBar
              Object(o).Typ = (Object(o).Typ * 100) * Multi#
              Object(o).Time = 50
            CASE 10 TO 12
              IF Object(o).Alone = TRUE THEN Object(o).Alone = FALSE: BonusAlone = FALSE
              Player(p).Score = Player(p).Score + ((1000 + ((Object(o).Typ - 10) * 500)) * Multi#)
              PrintStatBar
              Object(o).Typ = ((1000 + ((Object(o).Typ - 10) * 500)) * Multi#): Object(o).Time = 50
            CASE 13
              Player(p).Score = Player(p).Score + (500 * Multi#)
              PrintStatBar
              Object(o).Typ = (500 * Multi#): Object(o).Time = 50
              Player(p).Cutter = TRUE
              PUT ((304 * (p - 1)), 8), CutHole&, PSET
              PUT ((304 * (p - 1)), 8), Obj&(1200), XOR
            CASE 14
              RANDOMIZE TIMER
              m = INT(RND(1) * 4) + 1
              SELECT CASE m
              CASE 1
                Player(p).Score = Player(p).Score + (3000 * Multi#)
                PrintStatBar
                Object(o).Typ = (3000 * Multi#): Object(o).Time = 50
              CASE 2
                RANDOMIZE TIMER
                g = INT(RND(1) * 5) + 1
                Change = g: NumChange = 0
                FOR r = 1 TO 20
                  IF Enemy(r).Typ <> 0 THEN
                    Enemy(r).Changed = FALSE: NumChange = NumChange + 1
                  END IF
                NEXT r
                Object(o).Typ = (50 * Multi#): Object(o).Time = 50
                Player(p).Score = Player(p).Score + (50 * Multi#): PrintStatBar
              CASE 3
                Player(p).Spd = 1
                Object(o).Typ = (50 * Multi#): Object(o).Time = 50
                Player(p).Score = Player(p).Score + (50 * Multi#): PrintStatBar
              CASE 4
                Player(p).Lives = Player(p).Lives + 1
                Object(o).Typ = (500 * Multi#): Object(o).Time = 50
                Player(p).Score = Player(p).Score + (500 * Multi#): PrintStatBar
              END SELECT
            CASE 15
              GameMode = POTION: NumEnemy = 1: Pass = -1
              FOR f = 1 TO 170: IF Block(f).Status <> 0 THEN Block(f).Status = FIXEDBLOCK: PUT (Block(f).x * 16, -8 + (Block(f).y * 16)), FBlock&, PSET
              NEXT f
              FOR f = 1 TO 20: Enemy(f).Typ = 0: NEXT f
              FOR f = 1 TO 60: Object(f).Typ = 0: NEXT f
              PotNum = 0
              FOR v = 1 TO 12: FOR vv = 1 TO 18
                IF Cel(vv, v) = 0 THEN
                  PUT (vv * 16, -8 + (v * 16)), Null&, PSET
                  RANDOMIZE TIMER * TimeLeft
                  g = INT(RND(1) * 4) + 1
                  IF g = 1 AND PotNum < 50 THEN
                    PotNum = PotNum + 1
                    Object(PotNum).Typ = 21: Object(PotNum).Time = -1
                    Object(PotNum).x = vv * 16: Object(PotNum).y = -8 + (v * 16)
                  END IF
                END IF
              NEXT vv, v
              TimeLeft = PotNum + (PotNum / 8)
              Player(1).Special = 0: Player(2).Special = 0
            CASE 16
              Player(p).Score = Player(p).Score + (500 * Multi#)
              PrintStatBar
              Object(o).Typ = (500 * Multi#): Object(o).Time = 50
              TimeLeft = TimeLeft + 10
            CASE 17
              FOR w = 1 TO 20
                IF Enemy(w).Typ <> 0 THEN
                  Enemy(w).Typ = 0
                  FOR j = 1 TO 60: IF Object(j).Typ = 0 THEN EXIT FOR
                  NEXT j
                  Object(j).Typ = -3: Object(j).Time = 3
                  Object(j).x = Enemy(w).x: Object(j).y = -8 + Enemy(w).y
                END IF
              NEXT w
              NumEnemy = 0
              Player(p).Score = Player(p).Score + (500 * Multi#)
              Object(o).Typ = (500 * Multi#): Object(o).Time = 50
            CASE 18
              Freezed = 500
              Player(p).Score = Player(p).Score + (1000 * Multi#)
              PrintStatBar
              Object(o).Typ = (500 * Multi#): Object(o).Time = 50
            CASE 19
              Pass = 1: Message "YOU ENTERED!": Level = Level + INT(RND(1) * 5)
            CASE 20
              Player(p).Lives = Player(p).Lives + 1
              Player(p).Score = Player(p).Score + (500 * Multi#)
              PrintStatBar
              Object(o).Typ = (500 * Multi#): Object(o).Time = 50
            CASE 21
              Player(p).Special = Player(p).Special + 1
              Object(o).Typ = 200: Object(o).Time = 50
              PotNum = PotNum - 1: IF PotNum = 0 THEN Pass = 1
            CASE 22 TO 26
              Player(p).Score = Player(p).Score + (300 * Multi#)
              PrintStatBar
              SELECT CASE Object(o).Typ
              CASE 22
                IF Player(p).BonusE <> TRUE THEN Player(p).BonusE = TRUE: Player(p).Bonus = Player(p).Bonus + 1
              CASE 23
                IF Player(p).BonusX <> TRUE THEN Player(p).BonusX = TRUE: Player(p).Bonus = Player(p).Bonus + 1
              CASE 24
                IF Player(p).BonusT <> TRUE THEN Player(p).BonusT = TRUE: Player(p).Bonus = Player(p).Bonus + 1
              CASE 25
                IF Player(p).BonusR <> TRUE THEN Player(p).BonusR = TRUE: Player(p).Bonus = Player(p).Bonus + 1
              CASE 26
                IF Player(p).BonusA <> TRUE THEN Player(p).BonusA = TRUE: Player(p).Bonus = Player(p).Bonus + 1
              END SELECT
              PUT ((p - 1) * 304, 64 + ((Object(o).Typ - 22) * 16)), Hole&, PSET
              PUT ((p - 1) * 304, 64 + ((Object(o).Typ - 22) * 16)), Obj&((Object(o).Typ - 1) * 100), XOR
              IF Player(p).Bonus = 5 THEN
                Player(p).Bonus = 0
                Player(p).BonusE = FALSE
                Player(p).BonusX = FALSE
                Player(p).BonusT = FALSE
                Player(p).BonusR = FALSE
                Player(p).BonusA = FALSE
                Player(p).Lives = Player(p).Lives + 1: PrintStatBar
                FOR Z = 0 TO 11: PUT ((p - 1) * 304, 8 + (Z * 16)), Wall&, PSET: NEXT Z
              END IF
              Object(o).Typ = 300: Object(o).Time = 50
            CASE 27
              RANDOMIZE TIMER
              ty = INT(RND(1) * 12) + 1
              FOR bo = 1 TO 15
                FOR sel = 1 TO 60
                  IF Object(sel).Typ = 0 THEN
                    Object(sel).Typ = ty: Object(sel).Time = 500
                    DO
                      RANDOMIZE TIMER
                      xo = INT(RND(1) * 18) + 1: yo = INT(RND(1) * 12) + 1
                      IF Cel(xo, yo) = 0 THEN EXIT DO
                    LOOP
                    Object(sel).x = xo * 16: Object(sel).y = -8 + (yo * 16)
                    EXIT FOR
                  END IF
                NEXT sel
              NEXT bo
              Object(o).Typ = 0: PUT (Object(o).x, Object(o).y), Null&, PSET
            END SELECT
          END IF
        END IF
      NEXT p
      IF Object(o).Time = 0 THEN Object(o).Typ = -7: Object(o).Time = 3
    CASE IS > 30
      PrintValue Object(o).x, Object(o).y, Object(o).Typ
      IF Object(o).Time = 0 THEN Object(o).Typ = 0: PUT (Object(o).x, Object(o).y), Null&, PSET
    END SELECT
  END IF
NEXT o
END SUB

SUB Delay (sbDT!)
IF sbDT! = 0! THEN EXIT SUB
sbstart! = TIMER
DO WHILE TIMER <= (sbstart! + sbDT!): LOOP
END SUB

SUB DrawScreen
FOR i = 1 TO 18: FOR ii = 1 TO 12
  SELECT CASE Cel(i, ii)
  CASE WEB: PUT (i * 16, -8 + (ii * 16)), Spider&(1600), PSET
  CASE FIXEDBLOCK: PUT (i * 16, -8 + (ii * 16)), FBlock&, PSET
  CASE NORMALBLOCK: PUT (i * 16, -8 + (ii * 16)), NBlock&, PSET
  CASE SPECIALBLOCK: PUT (i * 16, -8 + (ii * 16)), SBlock&, PSET
  END SELECT
NEXT ii, i
END SUB

SUB GetSprites
CLS : FOR i = 0 TO 255: PALETTE i, 0: NEXT i
DEF SEG = &HA000: BLOAD "wetspot.p13", 0
FOR i = 0 TO 1: FOR ii = 0 TO 19
GET (ii * 16, i * 16)-((ii * 16) + 15, (i * 16) + 15), Crab&((2000 * i) + (100 * ii))
NEXT ii, i
FOR i = 0 TO 2: GET (i * 16, 32)-((i * 16) + 15, 47), Expl&(i * 100): NEXT i
FOR i = 0 TO 4: GET ((i * 16) + 48, 32)-((i * 16) + 63, 47), Obj&((i * 100) + 2100): NEXT i
GET (128, 32)-(143, 47), Wall&: GET (144, 32)-(159, 47), Hole&
GET (304, 32)-(319, 47), CutHole&
FOR i = 0 TO 1: GET (160 + (i * 8), 32)-(167 + (i * 8), 39), Life&(i * 20): NEXT i
FOR i = 0 TO 9: GET (177 + (i * 4), 32)-(180 + (i * 4), 35), Number&(i * 10): NEXT i
GET (160, 40)-(167, 47), Clock&: GET (168, 40)-(175, 47), Flag&
FOR i = 0 TO 3: GET (224 + (i * 16), 32)-(239 + (i * 16), 47), Disapp&(i * 100): NEXT i
GET (288, 32)-(303, 47), Obj&(2600)
FOR i = 0 TO 44: GET (i * 7, 48)-((i * 7) + 6, 55), Char&(i * 20): NEXT i
GET (0, 190)-(6, 197), Char&(900): GET (0, 180)-(15, 195), Null&
FOR i = 0 TO 19: GET (i * 16, 56)-((i * 16) + 15, 71), Obj&(i * 100): NEXT i
FOR i = 0 TO 5: GET (i * 16, 72)-((i * 16) + 15, 87), Ball&(i * 100): NEXT i
FOR i = 0 TO 3: GET (96 + (i * 16), 72)-(111 + (i * 16), 87), Ghost&(i * 100): NEXT i
FOR i = 0 TO 9: GET (160 + (i * 16), 72)-(175 + (i * 16), 87), Slug&(i * 100): NEXT i
FOR i = 0 TO 15: GET (i * 16, 88)-((i * 16) + 15, 103), Robot&(i * 100): NEXT i
FOR i = 0 TO 15: GET (i * 16, 104)-((i * 16) + 15, 119), Worm&(i * 100): NEXT i
FOR i = 0 TO 19: GET (i * 16, 120)-((i * 16) + 15, 135), Putty&(i * 100): NEXT i
FOR i = 0 TO 18: GET (i * 16, 136)-((i * 16) + 15, 151), Spider&(i * 100): NEXT i
FOR i = 0 TO 11: GET (i * 16, 152)-((i * 16) + 15, 167), Shadow&(i * 100): NEXT i
CLS : PALETTE
END SUB

SUB Intro
' Sorry, but I haven't so much time to do an Intro for this game !!!
END SUB

SUB KillPlayer (num)
'TIMER OFF
PUT (Player(num).x, -8 + Player(num).y), Crab&(((num - 1) * 2000) + 1900), PSET
Delay .08
FOR q = 0 TO 2
  PUT (Player(num).x, -8 + Player(num).y), Expl&(q * 100), PSET
  Delay .08
NEXT q
PUT (Player(num).x, -8 + Player(num).y), Null&, PSET
END SUB

SUB LoadLevel
IF Level > MaxLevel THEN
  SCREEN 0: WIDTH 80
  PRINT "WetSpot v0.9"
  PRINT "(C) by Angelo Mottola soft 1996"
  PRINT : PRINT "Sorry, this demo version supports only" + STR$(MaxLevel) + " levels"
  PRINT : PRINT "Final release will include:"
  PRINT " - 100 levels (I hope so...)"
  PRINT " - 8 different enemies"
  PRINT " - Sound Blaster Music and sound effects"
  PRINT " - More and more fun !!"
  PRINT : PRINT "Coming soon..."
  PRINT : END
END IF
CLS : FOR p = 0 TO 255: PALETTE p, 0: NEXT p
DEF SEG = &HA000: BLOAD "level" + LTRIM$(STR$(Level)) + ".p13", 0
GET (0, 0)-(15, 15), FBlock&: GET (16, 0)-(31, 15), NBlock&
GET (32, 0)-(47, 15), SBlock&: GET (68, 0)-(83, 15), Obj&(2000)
FOR i = 1 TO 18: FOR ii = 1 TO 12: Cel(i, ii) = 0: NEXT ii, i
NumBlock = 0: NumEnemy = 0
FOR i = 1 TO 170: Block(i).Status = INACTIVE: NEXT i
FOR i = 1 TO 20: Enemy(i).Typ = 0: NEXT i
FOR i = 1 TO 60: Object(i).Typ = 0: NEXT i

FOR i = 1 TO 18: FOR ii = 1 TO 12
  SELECT CASE POINT(47 + i, ii - 1)
  CASE 1
    Cel(i, ii) = FIXEDBLOCK: NumBlock = NumBlock + 1
    Block(NumBlock).Status = FIXEDBLOCK
    Block(NumBlock).x = i: Block(NumBlock).y = ii
  CASE 2
    Cel(i, ii) = NORMALBLOCK: NumBlock = NumBlock + 1
    Block(NumBlock).Status = NORMALBLOCK
    Block(NumBlock).x = i: Block(NumBlock).y = ii
  CASE 3
    Cel(i, ii) = SPECIALBLOCK: NumBlock = NumBlock + 1
    Block(NumBlock).Status = SPECIALBLOCK
    Block(NumBlock).x = i: Block(NumBlock).y = ii
  CASE 4
    Player(1).x = i * 16: Player(1).y = ii * 16
  CASE 5
    Player(2).x = i * 16: Player(2).y = ii * 16
  CASE 6, 7, 8, 9, 10, 11, 12, 13
    NumEnemy = NumEnemy + 1
    Enemy(NumEnemy).Typ = POINT(47 + i, ii - 1) - 5
    Enemy(NumEnemy).dir = 1: Enemy(NumEnemy).x = i * 16: Enemy(NumEnemy).y = ii * 16
    SELECT CASE POINT(47 + i, ii - 1)
    CASE 6: Enemy(NumEnemy).Flag1 = 1: Enemy(NumEnemy).dir = 2
    CASE 7: Enemy(NumEnemy).Flag1 = 1: Enemy(NumEnemy).Flag2 = INT(RND(1) * NumPlayer) + 1
    CASE 8: Enemy(NumEnemy).Flag3 = 0
    CASE 9: Enemy(NumEnemy).Flag1 = 1: Enemy(NumEnemy).Flag2 = FALSE: Enemy(NumEnemy).Flag3 = 1
    CASE 10: Enemy(NumEnemy).Flag1 = 2: Enemy(NumEnemy).Flag2 = 1: Enemy(NumEnemy).Flag3 = 0
    CASE 11: Enemy(NumEnemy).Flag1 = 1
    CASE 12: Enemy(NumEnemy).Flag1 = 2
    CASE 13: Enemy(NumEnemy).Flag1 = 4
    END SELECT
  CASE 14
    Cel(i, ii) = WEB: NumBlock = NumBlock + 1
    Block(NumBlock).Status = WEB
    Block(NumBlock).x = i: Block(NumBlock).y = ii
  END SELECT
NEXT ii, i
FOR i = 1 TO 20: Bonus(i) = POINT(47 + i, 12): NEXT i
CLS
PALETTE
END SUB

SUB MainMenu
CLS
DEF SEG = &HA000: BLOAD "title.p13", 0
PALETTE
Center 58, "BY ANGELO MOTTOLA SOFT 1996"
Center 82, "VERSION 0.9"
Center 103, "PRESS 1 FOR 1 PLAYER GAME"
Center 113, "PRESS 2 FOR 2 PLAYERS GAME"
Center 123, "PRESS ESC TO QUIT GAME!"
Center 145, "- FINAL VERSION COMING SOON !! -"
DO
  k$ = INKEY$
  IF k$ = "1" THEN NumPlayer = 1: EXIT DO
  IF k$ = "2" THEN NumPlayer = 2: EXIT DO
  IF k$ = CHR$(27) THEN NumPlayer = 0: EXIT DO
LOOP

IF NumPlayer = 0 THEN
  SCREEN 0: WIDTH 80
  PRINT "WetSpot v0.9"
  PRINT "(C) by Angelo Mottola soft 1996"
  PRINT : PRINT "Final version coming soon!!"
  PRINT : END
END IF

CLS
END SUB

SUB Message (t$)
FOR i = 192 TO 96 STEP -4
  GET (0, i)-(319, i + 7), Box&
  Center i, t$
  FOR t = 0 TO 5000: NEXT t
  PUT (0, i), Box&, PSET
NEXT i
GET (0, 96)-(319, 103), Box&
Center 96, t$
q$ = INKEY$: WHILE (q$ <> CHR$(13) AND q$ <> "\"): q$ = INKEY$: WEND
PUT (0, 96), Box&, PSET
FOR i = 96 TO 8 STEP -4
  GET (0, i)-(319, i + 7), Box&
  Center i, t$
  FOR t = 0 TO 5000: NEXT t
  PUT (0, i), Box&, PSET
NEXT i
END SUB

SUB MoveEnemies
FOR e = 1 TO 20
  IF Enemy(e).Typ <> 0 THEN
    IF Change <> FALSE THEN
      IF Enemy(e).Changed = FALSE THEN
        IF Enemy(e).x MOD 16 = 0 AND Enemy(e).y MOD 16 = 0 THEN
          Enemy(e).Changed = TRUE: Enemy(e).Typ = Change
          NumChange = NumChange - 1
          SELECT CASE Change
          CASE 1
            Enemy(e).Flag1 = 1
            IF Enemy(e).dir = 1 OR Enemy(e).dir = 2 THEN Enemy(e).Flag2 = 1 ELSE Enemy(e).Flag2 = -1
          CASE 2
            Enemy(e).Flag1 = 1: Enemy(e).Flag2 = INT(RND(1) * NumPlayer) + 1
          CASE 3
            Enemy(e).Flag3 = 0
          CASE 4
            Enemy(e).Flag1 = 1: Enemy(e).Flag2 = FALSE: Enemy(e).Flag3 = 1
          CASE 5
            Enemy(e).Flag1 = 2: Enemy(e).Flag2 = 1: Enemy(e).Flag3 = 0
          END SELECT
          IF NumChange = 0 THEN Change = FALSE
        END IF
      END IF
    END IF
    SELECT CASE Enemy(e).Typ
    CASE 1
      IF Freezed = FALSE THEN
        IF Enemy(e).x MOD 16 = 0 AND Enemy(e).y MOD 16 = 0 THEN
          Enemy(e).dir = 0
          FOR h = 1 TO 20
            RANDOMIZE TIMER * TimeLeft
            d = INT(RND(1) * 4) + 1
            IF Cel((Enemy(e).x / 16) + xA(d), (Enemy(e).y / 16) + yA(d)) < 1 THEN
              Enemy(e).dir = d: Enemy(e).Flag1 = 1
              IF Enemy(e).dir = 1 OR Enemy(e).dir = 2 THEN Enemy(e).Flag2 = 1 ELSE Enemy(e).Flag2 = -1
              EXIT FOR
            END IF
            d = 0
          NEXT h
        END IF
        PUT (Enemy(e).x, -8 + Enemy(e).y), Null&, PSET
        Enemy(e).x = Enemy(e).x + xA(Enemy(e).dir)
        Enemy(e).y = Enemy(e).y + yA(Enemy(e).dir)
        Enemy(e).Flag1 = Enemy(e).Flag1 + Enemy(e).Flag2
        IF Enemy(e).Flag1 = 0 THEN
          Enemy(e).Flag1 = 8
        ELSEIF Enemy(e).Flag1 = 9 THEN
          Enemy(e).Flag1 = 1
        END IF
      END IF
      IF Enemy(e).dir = 0 THEN Enemy(e).dir = 2
      IF Enemy(e).dir = 1 OR Enemy(e).dir = 3 THEN h = 0 ELSE h = 1
      PUT (Enemy(e).x, -8 + Enemy(e).y), Worm&((h * 800) + ((Enemy(e).Flag1 - 1) * 100)), PSET
    CASE 2
      IF Freezed = FALSE THEN
        IF Enemy(e).x MOD 16 = 0 AND Enemy(e).y MOD 16 = 0 THEN
          RANDOMIZE TIMER * TimeLeft
          k = INT(RND(1) * 4) + 1
          IF k < 4 THEN
            k = INT(RND(1) * 100) + 1
            IF k = 1 THEN Enemy(e).Flag2 = INT(RND(1) * NumPlayer) + 1
            IF Player(Enemy(e).Flag2).x < Enemy(e).x THEN d = 4
            IF Player(Enemy(e).Flag2).x > Enemy(e).x THEN d = 2
            IF (Cel((Enemy(e).x / 16) + xA(d), (Enemy(e).y / 16) + yA(d)) <> 0) THEN
              IF Player(Enemy(e).Flag2).y < Enemy(e).y THEN d = 3
              IF Player(Enemy(e).Flag2).y > Enemy(e).y THEN d = 1
            END IF
            IF Player(Enemy(e).Flag2).x = Enemy(e).x THEN
              IF Player(Enemy(e).Flag2).y < Enemy(e).y THEN d = 3
              IF Player(Enemy(e).Flag2).y > Enemy(e).y THEN d = 1
            END IF
          ELSE
            d = INT(RND(1) * 4) + 1
          END IF
          IF Cel((Enemy(e).x / 16) + xA(d), (Enemy(e).y / 16) + yA(d)) <> 0 THEN
            FOR h = 1 TO 20
              RANDOMIZE TIMER * TimeLeft
              d = INT(RND(1) * 4) + 1
              IF Cel((Enemy(e).x / 16) + xA(d), (Enemy(e).y / 16) + yA(d)) = 0 THEN
                EXIT FOR
              END IF
              d = 0
            NEXT h
          END IF
          Enemy(e).dir = d
        END IF
        PUT (Enemy(e).x, -8 + Enemy(e).y), Null&, PSET
        Enemy(e).x = Enemy(e).x + (xA(Enemy(e).dir) * 2)
        Enemy(e).y = Enemy(e).y + (yA(Enemy(e).dir) * 2)
        Enemy(e).Flag1 = Enemy(e).Flag1 + 1
        IF Enemy(e).Flag1 = 5 THEN Enemy(e).Flag1 = 1
      END IF
      IF Enemy(e).dir = 0 THEN Enemy(e).dir = 1
      PUT (Enemy(e).x, -8 + Enemy(e).y), Robot&(((Enemy(e).dir - 1) * 400) + ((Enemy(e).Flag1 - 1) * 100)), PSET
    CASE 3
      IF Freezed = FALSE THEN
        IF Enemy(e).Flag3 > 0 THEN
          Enemy(e).Flag3 = Enemy(e).Flag3 - 1
          IF Enemy(e).Flag3 MOD 2 = 0 THEN
            PUT (Enemy(e).x, -8 + Enemy(e).y), Ghost&((Enemy(e).dir - 1) * 100), PSET
            PUT (Enemy(e).Flag1, -8 + Enemy(e).Flag2), Null&, PSET
          ELSE
            PUT (Enemy(e).x, -8 + Enemy(e).y), Null&, PSET
            PUT (Enemy(e).Flag1, -8 + Enemy(e).Flag2), Ghost&((Enemy(e).dir - 1) * 100), PSET
          END IF
        ELSE
          IF Enemy(e).x MOD 16 = 0 AND Enemy(e).y MOD 16 = 0 THEN
            Enemy(e).dir = 0
            IF Cel((Enemy(e).x / 16) + xA(Enemy(e).dir), (Enemy(e).y / 16) + yA(Enemy(e).dir)) < 1 THEN
              FOR h = 1 TO 20
                RANDOMIZE TIMER * TimeLeft
                d = INT(RND(1) * 4) + 1
                IF Cel((Enemy(e).x / 16) + xA(d), (Enemy(e).y / 16) + yA(d)) < 1 THEN
                  Enemy(e).dir = d
                  EXIT FOR
                END IF
                d = 0
              NEXT h
            ELSE
              RANDOMIZE TIMER * TimeLeft
              s = INT(RND(1) * 2) + 1
              IF s = 1 THEN
                k = INT(RND(1) * NunmPlayer) + 1
                IF Player(k).x < Enemy(e).x THEN d = 4
                IF Player(k).x > Enemy(e).x THEN d = 2
                IF Player(k).y < Enemy(e).y THEN d = 3
                IF Player(k).y > Enemy(e).y THEN d = 1
                IF Cel((Enemy(e).x / 16) + xA(d), (Enemy(e).y / 16) + yA(d)) < 1 THEN
                  FOR h = 1 TO 20
                    RANDOMIZE TIMER * TimeLeft
                    d = INT(RND(1) * 4) + 1
                    IF Cel((Enemy(e).x / 16) + xA(d), (Enemy(e).y / 16) + yA(d)) < 1 THEN
                      Enemy(e).dir = d
                      EXIT FOR
                    END IF
                  NEXT h
                ELSE
                  Enemy(e).dir = d
                END IF
              END IF
            END IF
            k = INT(RND(1) * 25) + 1
            IF k = 1 THEN
              DO
                RANDOMIZE TIMER * TimeLeft
                xc = INT(RND(1) * 18) + 1: yc = INT(RND(1) * 12) + 1
                IF Cel(xc, yc) = 0 THEN EXIT DO
              LOOP
              Enemy(e).Flag1 = Enemy(e).x: Enemy(e).Flag2 = Enemy(e).y
              Enemy(e).Flag3 = 50: Enemy(e).dir = INT(RND(1) * 4) + 1
              Enemy(e).x = xc * 16: Enemy(e).y = yc * 16
            END IF
          END IF
          IF Enemy(e).Flag3 = 0 THEN
            PUT (Enemy(e).x, -8 + Enemy(e).y), Null&, PSET
            Enemy(e).x = Enemy(e).x + xA(Enemy(e).dir)
            Enemy(e).y = Enemy(e).y + yA(Enemy(e).dir)
            IF Enemy(e).dir = 0 THEN Enemy(e).dir = 1
            PUT (Enemy(e).x, -8 + Enemy(e).y), Ghost&((Enemy(e).dir - 1) * 100), PSET
          END IF
        END IF
      ELSE
        PUT (Enemy(e).x, -8 + Enemy(e).y), Ghost&((Enemy(e).dir - 1) * 100), PSET
      END IF
    CASE 4
      IF Freezed = FALSE THEN
        IF Enemy(e).Flag2 > FALSE THEN
          Enemy(e).Flag2 = Enemy(e).Flag2 - 1
          IF Enemy(e).Flag2 = 5 THEN
            FOR k = 1 TO 4
              Find = FALSE
              FOR h = 1 TO 20
                IF Enemy(h).Typ < 1 THEN Find = TRUE: EXIT FOR
              NEXT h
              IF Find = TRUE THEN
                IF Cel((Enemy(e).x / 16) + xA(k), (Enemy(e).y / 16) + yA(k)) = 0 THEN
                  Enemy(h).Typ = 9: Enemy(h).dir = k
                  Enemy(h).x = Enemy(e).x + (xA(k) * 16)
                  Enemy(h).y = Enemy(e).y + (yA(k) * 16)
                END IF
              END IF
            NEXT k
          END IF
          PUT (Enemy(e).x, -8 + Enemy(e).y), Slug&(800), PSET
        ELSE
          IF Enemy(e).x MOD 16 = 0 AND Enemy(e).y MOD 16 = 0 THEN
            k = INT(RND(1) * 15) + 1
            IF k = 1 THEN Enemy(e).Flag2 = 40: Enemy(e).dir = 0
            IF k <> 1 THEN
              IF Cel((Enemy(e).x / 16) + xA(Enemy(e).dir), (Enemy(e).y / 16) + yA(Enemy(e).dir)) <> 0 THEN
                RANDOMIZE TIMER * TimeLeft
                s = INT(RND(1) * 2) + 1
                IF s = 1 THEN
                  k = INT(RND(1) * NunmPlayer) + 1
                  IF Player(k).x < Enemy(e).x THEN d = 4
                  IF Player(k).x > Enemy(e).x THEN d = 2
                  IF Player(k).y < Enemy(e).y THEN d = 3
                  IF Player(k).y > Enemy(e).y THEN d = 1
                  IF Cel((Enemy(e).x / 16) + xA(d), (Enemy(e).y / 16) + yA(d)) <> 0 THEN
                    FOR h = 1 TO 20
                      RANDOMIZE TIMER * TimeLeft
                      d = INT(RND(1) * 4) + 1
                      IF Cel((Enemy(e).x / 16) + xA(d), (Enemy(e).y / 16) + yA(d)) = 0 THEN
                        Enemy(e).dir = d
                        EXIT FOR
                      ELSE
                        Enemy(e).dir = 0
                      END IF
                    NEXT h
                  ELSE
                    Enemy(e).dir = d
                  END IF
                ELSE
                  FOR h = 1 TO 20
                    RANDOMIZE TIMER * TimeLeft
                    d = INT(RND(1) * 4) + 1
                    IF Cel((Enemy(e).x / 16) + xA(d), (Enemy(e).y / 16) + yA(d)) = 0 THEN
                      EXIT FOR
                    ELSE
                      d = 0
                    END IF
                  NEXT h
                  Enemy(e).dir = d
                END IF
              ELSE
                FOR h = 1 TO 20
                  RANDOMIZE TIMER * TimeLeft
                  d = INT(RND(1) * 4) + 1
                  IF Cel((Enemy(e).x / 16) + xA(d), (Enemy(e).y / 16) + yA(d)) = 0 THEN
                    Enemy(e).dir = d
                    EXIT FOR
                  ELSE
                    d = 0
                  END IF
                NEXT h
              END IF
            END IF
          END IF
          PUT (Enemy(e).x, -8 + Enemy(e).y), Null&, PSET
          Enemy(e).x = Enemy(e).x + xA(Enemy(e).dir)
          Enemy(e).y = Enemy(e).y + yA(Enemy(e).dir)
          Enemy(e).Flag3 = Enemy(e).Flag3 + 1
          IF Enemy(e).Flag3 = 20 THEN Enemy(e).Flag3 = 1
          IF Enemy(e).Flag3 > 10 THEN j = 1 ELSE j = 0
          IF Enemy(e).dir = 0 THEN Enemy(e).dir = 1
          PUT (Enemy(e).x, -8 + Enemy(e).y), Slug&(((Enemy(e).dir - 1) * 200) + (j * 100)), PSET
          IF Enemy(e).dir = 0 THEN Enemy(e).dir = 1
        END IF
      ELSE
        IF Enemy(e).Flag2 > FALSE THEN
          PUT (Enemy(e).x, -8 + Enemy(e).y), Slug&(800), PSET
        ELSE
          IF Enemy(e).Flag3 > 10 THEN j = 1 ELSE j = 0
          PUT (Enemy(e).x, -8 + Enemy(e).y), Slug&(((Enemy(e).dir - 1) * 200) + (j * 100)), PSET
        END IF
      END IF
    CASE 5
      IF Freezed = FALSE THEN
        IF Enemy(e).Flag3 > 0 THEN
          Enemy(e).Flag3 = Enemy(e).Flag3 - 1
          IF Enemy(e).Flag3 MOD 4 = 0 THEN
            PUT (Enemy(e).x, -8 + Enemy(e).y), Spider&(1200 + ((Enemy(e).dir - 1) * 100)), PSET
          ELSE
            PUT (Enemy(e).x, -8 + Enemy(e).y), Spider&(((Enemy(e).dir - 1) * 300) + 100), PSET
          END IF
          IF Enemy(e).Flag3 = 0 THEN
            FOR nb = 1 TO 170
              IF Block(nb).Status = 0 THEN EXIT FOR
            NEXT nb
            Block(nb).x = Enemy(e).x / 16: Block(nb).y = Enemy(e).y / 16
            Block(nb).Status = WEB: Cel(Enemy(e).x / 16, Enemy(e).y / 16) = WEB
            NumWeb = NumWeb + 1
          END IF
        ELSE
          IF Enemy(e).x MOD 16 = 0 AND Enemy(e).y MOD 16 = 0 THEN
            Enemy(e).dir = 0
            IF Cel((Enemy(e).x / 16) + xA(Enemy(e).dir), (Enemy(e).y / 16) + yA(Enemy(e).dir)) < 1 THEN
              FOR h = 1 TO 20
                RANDOMIZE TIMER * TimeLeft
                d = INT(RND(1) * 4) + 1
                IF Cel((Enemy(e).x / 16) + xA(d), (Enemy(e).y / 16) + yA(d)) < 1 THEN
                  Enemy(e).dir = d
                  EXIT FOR
                END IF
                d = 0
              NEXT h
            ELSE
              RANDOMIZE TIMER * TimeLeft
              s = INT(RND(1) * 4) + 1
              IF s = 1 THEN
                k = INT(RND(1) * NunmPlayer) + 1
                IF Player(k).x < Enemy(e).x THEN d = 4
                IF Player(k).x > Enemy(e).x THEN d = 2
                IF Player(k).y < Enemy(e).y THEN d = 3
                IF Player(k).y > Enemy(e).y THEN d = 1
                IF Cel((Enemy(e).x / 16) + xA(d), (Enemy(e).y / 16) + yA(d)) < 1 THEN
                  FOR h = 1 TO 20
                    RANDOMIZE TIMER * TimeLeft
                    d = INT(RND(1) * 4) + 1
                    IF Cel((Enemy(e).x / 16) + xA(d), (Enemy(e).y / 16) + yA(d)) < 1 THEN
                      Enemy(e).dir = d
                      EXIT FOR
                    END IF
                  NEXT h
                ELSE
                  Enemy(e).dir = d
                END IF
              END IF
            END IF
            k = INT(RND(1) * 20) + 1
            IF k = 1 AND Cel(Enemy(e).x / 16, Enemy(e).y / 16) <> WEB THEN
              IF NumWeb < 11 THEN Enemy(e).Flag3 = 50
            END IF
          END IF
          IF Enemy(e).Flag3 = 0 THEN
            PUT (Enemy(e).x, -8 + Enemy(e).y), Null&, PSET
            Enemy(e).x = Enemy(e).x + xA(Enemy(e).dir)
            Enemy(e).y = Enemy(e).y + yA(Enemy(e).dir)
            Enemy(e).Flag1 = Enemy(e).Flag1 + Enemy(e).Flag2
            IF Enemy(e).Flag1 <> 2 THEN Enemy(e).Flag2 = -Enemy(e).Flag2
            IF Enemy(e).dir = 0 THEN Enemy(e).dir = 1
            PUT (Enemy(e).x, -8 + Enemy(e).y), Spider&(((Enemy(e).dir - 1) * 300) + ((Enemy(e).Flag1 - 1) * 100)), PSET
          END IF
        END IF
      ELSE
        PUT (Enemy(e).x, -8 + Enemy(e).y), Spider&(((Enemy(e).dir - 1) * 300) + ((Enemy(e).Flag1 - 1) * 100)), PSET
      END IF
      IF Enemy(e).dir = 0 THEN Enemy(e).dir = 1
    CASE 9
      IF Freezed = FALSE THEN
        PUT (Enemy(e).x, -8 + Enemy(e).y), Null&, PSET
        IF Enemy(e).x MOD 16 = 0 AND Enemy(e).y MOD 16 = 0 THEN
          IF Cel((Enemy(e).x / 16) + xA(Enemy(e).dir), (Enemy(e).y / 16) + yA(Enemy(e).dir)) < 1 THEN
            Enemy(e).x = Enemy(e).x + (xA(Enemy(e).dir) * 8)
            Enemy(e).y = Enemy(e).y + (yA(Enemy(e).dir) * 8)
            PUT (Enemy(e).x, -8 + Enemy(e).y), Slug&(900), PSET
          ELSE
            Enemy(e).Typ = 0
            FOR h = 1 TO 60
              IF Object(h).Typ = 0 THEN EXIT FOR
            NEXT h
            Object(h).Typ = -3: Object(h).Time = 3
            Object(h).x = Enemy(e).x
            Object(h).y = -8 + Enemy(e).y
          END IF
        ELSE
          Enemy(e).x = Enemy(e).x + (xA(Enemy(e).dir) * 8)
          Enemy(e).y = Enemy(e).y + (yA(Enemy(e).dir) * 8)
          PUT (Enemy(e).x, -8 + Enemy(e).y), Slug&(900), PSET
        END IF
      ELSE
        PUT (Enemy(e).x, -8 + Enemy(e).y), Slug&(900), PSET
      END IF
    END SELECT
    GoOn = FALSE
    FOR C = 1 TO NumPlayer
      IF Enemy(e).x > Player(C).x - 16 AND Enemy(e).x < Player(C).x + 16 THEN
        IF Enemy(e).y > Player(C).y - 16 AND Enemy(e).y < Player(C).y + 16 THEN
          IF Enemy(e).Typ = 3 AND Enemy(e).Flag3 <> 0 THEN GoOn = TRUE
          IF GoOn = FALSE THEN
            KillPlayer C
            Killed = TRUE ': TIMER OFF
            Player(C).Lives = Player(C).Lives - 1: EXIT SUB
          END IF
        END IF
      END IF
    NEXT C
  END IF
NEXT e

END SUB

SUB OutText (x, y, t$)
FOR i = 1 TO LEN(t$)
  ChCode = ASC(MID$(t$, i, 1))
  SELECT CASE ChCode
  CASE 65 TO 90: Ch = ChCode - 65
  CASE 48 TO 57: Ch = ChCode - 22
  CASE 46: Ch = 36
  CASE 58: Ch = 37
  CASE 44: Ch = 38
  CASE 59: Ch = 39
  CASE 33: Ch = 40
  CASE 63: Ch = 41
  CASE 45: Ch = 42
  CASE 43: Ch = 43
  CASE 95: Ch = 44
  CASE 32: Ch = 45
  END SELECT
  PUT (x, y), Char&(Ch * 20), PSET
  x = x + 7
NEXT i
END SUB

FUNCTION PlayAgain
'
Center 96, "PLAY AGAIN ?"
DO
  k$ = INKEY$: k$ = UCASE$(k$)
  IF k$ = "Y" THEN PlayAgain = TRUE: EXIT DO
  IF k$ = "N" THEN PlayAgain = FALSE: EXIT DO
LOOP
  
END FUNCTION

SUB PlayGame

MaxLevel = 21
Level = 1
FOR i = 1 TO 2
  Player(i).Score = 0
  Player(i).Lives = 3
  Player(i).NextLife = 30000
  Player(i).BonusE = FALSE
  Player(i).BonusX = FALSE
  Player(i).BonusT = FALSE
  Player(i).BonusR = FALSE
  Player(i).BonusA = FALSE
  Player(i).Bonus = 0
  Player(i).Cutter = FALSE
  Player(i).Trapped = FALSE
NEXT i
IF NumPlayer = 1 THEN Player(2).Lives = 0
AbortGame = FALSE
DO
  LoadLevel
  FOR i = 0 TO 11: PUT (0, 8 + (i * 16)), Wall&, PSET
  PUT (304, 8 + (i * 16)), Wall&, PSET: NEXT i
  IF Player(1).Cutter = TRUE THEN PUT (0, 8), CutHole&, PSET: PUT (0, 8), Obj&(1200), XOR
  IF Player(2).Cutter = TRUE THEN PUT (304, 8), CutHole&, PSET: PUT (304, 8), Obj&(1200), XOR
  OutText 0, 0, "1UP": OutText 204, 0, "2UP"
  PUT (128, 0), Clock&, PSET: PUT (167, 0), Flag&, PSET
  PrintStatBar
  DrawScreen
  FOR i = 1 TO NumPlayer
    Player(i).dir = 1
    Player(i).NextDir = 0
    Player(i).Frame = 2
    Player(i).FrameDir = 1
    Player(i).Action = NONE
    Player(i).Spd = 2
    IF Player(i).BonusE = TRUE THEN PUT ((i - 1) * 304, 64), Hole&, PSET: PUT ((i - 1) * 304, 64), Obj&(2100), XOR
    IF Player(i).BonusX = TRUE THEN PUT ((i - 1) * 304, 80), Hole&, PSET: PUT ((i - 1) * 304, 80), Obj&(2200), XOR
    IF Player(i).BonusT = TRUE THEN PUT ((i - 1) * 304, 96), Hole&, PSET: PUT ((i - 1) * 304, 96), Obj&(2300), XOR
    IF Player(i).BonusR = TRUE THEN PUT ((i - 1) * 304, 112), Hole&, PSET: PUT ((i - 1) * 304, 112), Obj&(2400), XOR
    IF Player(i).BonusA = TRUE THEN PUT ((i - 1) * 304, 128), Hole&, PSET: PUT ((i - 1) * 304, 128), Obj&(2500), XOR
    PUT (Player(i).x, -8 + Player(i).y), Crab&(((i - 1) * 2000) + ((Player(i).dir - 1) * 300) + ((Player(i).Frame - 1) * 100)), PSET
    Player(i).Trapped = FALSE
  NEXT i
  FOR i = 1 TO 20
    SELECT CASE Enemy(i).Typ
    CASE 1: PUT (Enemy(i).x, -8 + Enemy(i).y), Worm&(800), PSET
    CASE 2: PUT (Enemy(i).x, -8 + Enemy(i).y), Robot&(0), PSET
    CASE 3: PUT (Enemy(i).x, -8 + Enemy(i).y), Ghost&(0), PSET
    CASE 4: PUT (Enemy(i).x, -8 + Enemy(i).y), Slug&(0), PSET
    CASE 5: PUT (Enemy(i).x, -8 + Enemy(i).y), Spider&(100), PSET
    CASE 6: PUT (Enemy(i).x, -8 + Enemy(i).y), Shadow&(0), PSET
    CASE 7: PUT (Enemy(i).x, -8 + Enemy(i).y), Putty&(100), PSET
    CASE 8: PUT (Enemy(i).x, -8 + Enemy(i).y), Ball&(300), PSET
    END SELECT
  NEXT i
  TimeLeft = 90: PrintStatBar
  Message "READY!"
  Pass = -1: Killed = FALSE
  GameMode = NORMAL: Freezed = FALSE: Multi# = 1: Killed = FALSE
  LastTime$ = TIME$: BonusAlone = FALSE: Change = FALSE
  DO
    StartT! = TIMER

    DO: time1! = TIMER: LOOP UNTIL time1! <> time2!
    time2! = time1!

    k$ = INKEY$: k$ = UCASE$(k$)
    SELECT CASE k$
    CASE "2"
      IF Player(1).Action <> FIRE THEN
        IF Player(1).NextDir = 0 AND Player(1).Action = NONE THEN
          Player(1).dir = 1: Player(1).NextDir = 1: Player(1).Action = MOVE
        ELSE
          Player(1).NextDir = 1: Player(1).Action = MOVE
        END IF
      END IF
    CASE "6"
      IF Player(1).Action <> FIRE THEN
        IF Player(1).NextDir = 0 AND Player(1).Action = NONE THEN
          Player(1).dir = 2: Player(1).NextDir = 2: Player(1).Action = MOVE
        ELSE
          Player(1).NextDir = 2: Player(1).Action = MOVE
        END IF
      END IF
    CASE "8"
      IF Player(1).Action <> FIRE THEN
        IF Player(1).NextDir = 0 AND Player(1).Action = NONE THEN
          Player(1).dir = 3: Player(1).NextDir = 3: Player(1).Action = MOVE
        ELSE
          Player(1).NextDir = 3: Player(1).Action = MOVE
        END IF
      END IF
    CASE "4"
      IF Player(1).Action <> FIRE THEN
        IF Player(1).NextDir = 0 AND Player(1).Action = NONE THEN
          Player(1).dir = 4: Player(1).NextDir = 4: Player(1).Action = MOVE
        ELSE
          Player(1).NextDir = 4: Player(1).Action = MOVE
        END IF
      END IF
    CASE "5": IF Player(1).Action <> FIRE THEN Player(1).NextDir = 0: Player(1).Action = MOVE
    CASE CHR$(13)
      IF Player(1).Action = NONE THEN Player(1).Action = FIRE: Player(1).Frame = 1
    CASE "X"
      IF Player(2).Action <> FIRE THEN
        IF Player(2).NextDir = 0 AND Player(2).Action = NONE THEN
          Player(2).dir = 1: Player(2).NextDir = 1: Player(2).Action = MOVE
        ELSE
          Player(2).NextDir = 1: Player(2).Action = MOVE
        END IF
      END IF
    CASE "D"
      IF Player(2).Action <> FIRE THEN
        IF Player(2).NextDir = 0 AND Player(2).Action = NONE THEN
          Player(2).dir = 2: Player(2).NextDir = 2: Player(2).Action = MOVE
        ELSE
          Player(2).NextDir = 2: Player(2).Action = MOVE
        END IF
      END IF
    CASE "W"
      IF Player(2).Action <> FIRE THEN
        IF Player(2).NextDir = 0 AND Player(2).Action = NONE THEN
          Player(2).dir = 3: Player(2).NextDir = 3: Player(2).Action = MOVE
        ELSE
          Player(2).NextDir = 3: Player(2).Action = MOVE
        END IF
      END IF
    CASE "A"
      IF Player(2).Action <> FIRE THEN
        IF Player(2).NextDir = 0 AND Player(2).Action = NONE THEN
          Player(2).dir = 4: Player(2).NextDir = 4: Player(2).Action = MOVE
        ELSE
          Player(2).NextDir = 4: Player(2).Action = MOVE
        END IF
      END IF
    CASE "S": IF Player(2).Action <> FIRE THEN Player(2).NextDir = 0: Player(2).Action = MOVE
    CASE "\"
      IF Player(2).Action = NONE THEN Player(2).Action = FIRE: Player(2).Frame = 1
    CASE "P"
      Message "PAUSE!"
    CASE CHR$(27): AbortGame = TRUE: EXIT DO
    END SELECT
    FOR i = 1 TO NumPlayer
      IF Player(i).Trapped = FALSE THEN
        IF Player(i).Action <> NONE THEN PUT (Player(i).x, -8 + Player(i).y), Null&, PSET
        SELECT CASE Player(i).Action
        CASE MOVE
          SELECT CASE Player(i).NextDir
          CASE 0
            IF Player(i).x MOD 16 = 0 AND Player(i).y MOD 16 = 0 THEN
              Player(i).Action = NONE: Player(i).Frame = 2
            END IF
          CASE 1
            IF Player(i).x MOD 16 = 0 AND Player(i).y MOD 16 = 0 THEN
              IF Cel(Player(i).x / 16, (Player(i).y / 16) + 1) < 1 THEN Player(i).dir = Player(i).NextDir ELSE Player(i).dir = Player(i).NextDir: Player(i).Action = NONE
            END IF
          CASE 2
            IF Player(i).x MOD 16 = 0 AND Player(i).y MOD 16 = 0 THEN
              IF Cel((Player(i).x / 16) + 1, Player(i).y / 16) < 1 THEN Player(i).dir = Player(i).NextDir ELSE Player(i).dir = Player(i).NextDir: Player(i).Action = NONE
            END IF
          CASE 3
            IF Player(i).x MOD 16 = 0 AND Player(i).y MOD 16 = 0 THEN
              IF Cel(Player(i).x / 16, (Player(i).y / 16) - 1) < 1 THEN Player(i).dir = Player(i).NextDir ELSE Player(i).dir = Player(i).NextDir: Player(i).Action = NONE
            END IF
          CASE 4
            IF Player(i).x MOD 16 = 0 AND Player(i).y MOD 16 = 0 THEN
              IF Cel((Player(i).x / 16) - 1, Player(i).y / 16) < 1 THEN Player(i).dir = Player(i).NextDir ELSE Player(i).dir = Player(i).NextDir: Player(i).Action = NONE
            END IF
          END SELECT
          SELECT CASE Player(i).dir
          CASE 1
            IF (Player(i).y) MOD 16 = 0 THEN
              IF Cel(Player(i).x / 16, ((Player(i).y) / 16) + 1) > 0 THEN Player(i).Action = NONE: Player(i).Frame = 2
            END IF
            IF Player(i).Action = MOVE THEN
              Player(i).y = Player(i).y + Player(i).Spd
              Player(i).Frame = Player(i).Frame + Player(i).FrameDir
              IF Player(i).Frame = 3 OR Player(i).Frame = 1 THEN Player(i).FrameDir = -Player(i).FrameDir
            END IF
          CASE 2
            IF (Player(i).x) MOD 16 = 0 THEN
              IF Cel((Player(i).x / 16) + 1, (Player(i).y) / 16) > 0 THEN Player(i).Action = NONE: Player(i).Frame = 2
            END IF
            IF Player(i).Action = MOVE THEN
              Player(i).x = Player(i).x + Player(i).Spd
              Player(i).Frame = Player(i).Frame + Player(i).FrameDir
              IF Player(i).Frame = 3 OR Player(i).Frame = 1 THEN Player(i).FrameDir = -Player(i).FrameDir
            END IF
          CASE 3
            IF (Player(i).y) MOD 16 = 0 THEN
              IF Cel(Player(i).x / 16, ((Player(i).y) / 16) - 1) > 0 THEN Player(i).Action = NONE: Player(i).Frame = 2
            END IF
            IF Player(i).Action = MOVE THEN
              Player(i).y = Player(i).y - Player(i).Spd
              Player(i).Frame = Player(i).Frame + Player(i).FrameDir
              IF Player(i).Frame = 3 OR Player(i).Frame = 1 THEN Player(i).FrameDir = -Player(i).FrameDir
            END IF
          CASE 4
            IF (Player(i).x) MOD 16 = 0 THEN
              IF Cel((Player(i).x / 16) - 1, (Player(i).y) / 16) > 0 THEN Player(i).Action = NONE: Player(i).Frame = 2
            END IF
            IF Player(i).Action = MOVE THEN
              Player(i).x = Player(i).x - Player(i).Spd
              Player(i).Frame = Player(i).Frame + Player(i).FrameDir
              IF Player(i).Frame = 3 OR Player(i).Frame = 1 THEN Player(i).FrameDir = -Player(i).FrameDir
            END IF
          END SELECT
          PUT (Player(i).x, -8 + Player(i).y), Crab&(((i - 1) * 2000) + ((Player(i).dir - 1) * 300) + ((Player(i).Frame - 1) * 100)), PSET
        CASE NONE
          PUT (Player(i).x, -8 + Player(i).y), Crab&(((i - 1) * 2000) + ((Player(i).dir - 1) * 300) + ((Player(i).Frame - 1) * 100)), PSET
        CASE FIRE
          SELECT CASE Player(i).Frame
          CASE 1
            PUT (Player(i).x, -8 + Player(i).y), Crab&(((i - 1) * 2000) + ((Player(i).dir - 1) * 300) + 100), PSET
            Player(i).Frame = Player(i).Frame + 1
          CASE 2, 3, 4
            PUT (Player(i).x, -8 + Player(i).y), Crab&(((i - 1) * 2000) + 1200 + ((Player(i).dir - 1) * 100)), PSET
            Player(i).Frame = Player(i).Frame + 1
          CASE 5
            PUT (Player(i).x, -8 + Player(i).y), Crab&(((i - 1) * 2000) + 1200 + ((Player(i).dir - 1) * 100)), PSET
            IF Player(i).dir = 1 THEN
              FOR B = 1 TO 170
                IF Block(B).Status = NORMALBLOCK OR Block(B).Status = SPECIALBLOCK THEN
                  IF Block(B).x = Player(i).x / 16 AND Block(B).y = (Player(i).y / 16) + 1 THEN
                    Block(B).Status = NMOVINGDOWN + ((Block(B).Status - 2) * 4)
                    Block(B).JustMoved = TRUE: Block(B).MovedBy = i
                  END IF
                END IF
              NEXT B
            END IF
            IF Player(i).dir = 2 THEN
              FOR B = 1 TO 170
                IF Block(B).Status = NORMALBLOCK OR Block(B).Status = SPECIALBLOCK THEN
                  IF Block(B).x = (Player(i).x / 16) + 1 AND Block(B).y = Player(i).y / 16 THEN
                    Block(B).Status = NMOVINGRIGHT + ((Block(B).Status - 2) * 4)
                    Block(B).JustMoved = TRUE: Block(B).MovedBy = i
                  END IF
                END IF
              NEXT B
            END IF
            IF Player(i).dir = 3 THEN
              FOR B = 1 TO 170
                IF Block(B).Status = NORMALBLOCK OR Block(B).Status = SPECIALBLOCK THEN
                  IF Block(B).x = Player(i).x / 16 AND Block(B).y = (Player(i).y / 16) - 1 THEN
                    Block(B).Status = NMOVINGUP + ((Block(B).Status - 2) * 4)
                    Block(B).JustMoved = TRUE: Block(B).MovedBy = i
                  END IF
                END IF
              NEXT B
            END IF
            IF Player(i).dir = 4 THEN
              FOR B = 1 TO 170
                IF Block(B).Status = NORMALBLOCK OR Block(B).Status = SPECIALBLOCK THEN
                  IF Block(B).x = (Player(i).x / 16) - 1 AND Block(B).y = Player(i).y / 16 THEN
                    Block(B).Status = NMOVINGLEFT + ((Block(B).Status - 2) * 4)
                    Block(B).JustMoved = TRUE: Block(B).MovedBy = i
                  END IF
                END IF
              NEXT B
            END IF
            Player(i).Frame = Player(i).Frame + 1
          CASE 6
            PUT (Player(i).x, -8 + Player(i).y), Crab&(((i - 1) * 2000) + ((Player(i).dir - 1) * 300) + 100), PSET
            Player(i).Action = NONE: Player(i).NextDir = 0: Player(i).Frame = 2
          END SELECT
        END SELECT
      ELSE
        Player(i).Trapped = Player(i).Trapped - 1
        IF Player(i).Trapped = 0 THEN Player(i).NextDir = 0
        PUT (Player(i).x, -8 + Player(i).y), Spider&(1700 + ((i - 1) * 100)), PSET
      END IF
      IF Player(i).x MOD 16 = 0 AND Player(i).y MOD 16 = 0 THEN
        IF Cel(Player(i).x / 16, Player(i).y / 16) = -1 THEN
          IF Player(i).Cutter = FALSE THEN Player(i).Trapped = 150
          NumWeb = NumWeb - 1
          FOR nb = 1 TO 170
            IF Block(nb).x = Player(i).x / 16 AND Block(nb).y = Player(i).y / 16 THEN Block(nb).Status = 0: EXIT FOR
          NEXT nb
          Cel(Player(i).x / 16, Player(i).y / 16) = 0
        END IF
      END IF
    NEXT i
    CheckObjects
    MoveEnemies
    CheckBlocks
    IF BonusAlone = FALSE AND GameMode = NORMAL THEN
      RANDOMIZE TIMER
      l = INT(RND(1) * 100) + 1
      IF l = 1 THEN
        FOR k = 1 TO 60: IF Object(k).Typ = 0 THEN EXIT FOR
        NEXT k
        Object(k).Typ = Bonus(INT(RND(1) * 20) + 1)
        DO
          xo = INT(RND(1) * 18) + 1
          yo = INT(RND(1) * 12) + 1
          IF Cel(xo, yo) = 0 THEN EXIT DO
        LOOP
        Object(k).x = xo * 16
        Object(k).y = -8 + (yo) * 16
        Object(k).Time = 400
        Object(k).Alone = TRUE
        BonusAlone = TRUE
      END IF
    END IF
    IF TIME$ <> LastTime$ AND Pass = -1 THEN
      LastTime$ = TIME$
      TimeLeft = TimeLeft - 1
      cl$ = LTRIM$(STR$(TimeLeft))
      IF LEN(cl$) < 3 THEN cl$ = STRING$(3 - LEN(cl$), "0") + cl$
      OutText 137, 0, cl$
    END IF
    IF TimeLeft = 0 THEN
      Pass = 0
      IF GameMode = NORMAL THEN
        FOR q = 1 TO NumPlayer: Player(q).Lives = Player(q).Lives - 1
        PUT (Player(q).x, -8 + Player(q).y), Crab&(((q - 1) * 2000) + 1900), PSET: NEXT q
        Message "TIME UP!"
        FOR i = 1 TO NumPlayer
          KillPlayer i
        NEXT i
        Pass = -1
      END IF
      EXIT DO
    END IF
    IF Freezed > FALSE THEN Freezed = Freezed - 1
    IF Killed = TRUE THEN Pass = -1: EXIT DO
    IF NumEnemy = 0 AND Pass = -1 THEN Pass = 150
    IF Pass <> -1 THEN Pass = Pass - 1: IF Pass = 0 THEN EXIT DO
    DO: LOOP WHILE TIMER < StartT! + .001
  LOOP
  IF AbortGame = TRUE THEN
    Message "GAME ABORTED!"
    SCREEN 0: WIDTH 80
    PRINT "WetSpot v0.9"
    PRINT "(C) by Angelo Mottola soft 1996"
    PRINT : PRINT "Final release will include:"
    PRINT " - 100 levels (I hope so...)"
    PRINT " - 8 different enemies"
    PRINT " - Sound Blaster Music and sound effects"
    PRINT " - More and more fun !!"
    PRINT : PRINT "Coming soon..."
    PRINT : END
  END IF
  IF Pass = 0 THEN
    IF GameMode = NORMAL THEN
      FOR i = 1 TO NumPlayer
        PUT (Player(i).x, -8 + Player(i).y), Crab&(((i - 1) * 2000) + 100), PSET
      NEXT i
      Delay .08
      FOR i = 1 TO NumPlayer
        PUT (Player(i).x, -8 + Player(i).y), Crab&(((i - 1) * 2000) + 1600), PSET
      NEXT i
      Delay .08
      FOR i = 1 TO NumPlayer
        PUT (Player(i).x, -8 + Player(i).y), Crab&(((i - 1) * 2000) + 1700), PSET
      NEXT i
      Delay .08
      FOR i = 1 TO NumPlayer
        PUT (Player(i).x, -8 + Player(i).y), Crab&(((i - 1) * 2000) + 1800), PSET
      NEXT i
      WHILE INKEY$ <> "": WEND
      q$ = INKEY$: WHILE (q$ <> CHR$(13) AND q$ <> "\"): q$ = INKEY$: WEND
      Level = Level + 1
    ELSE
      FOR i = 1 TO NumPlayer
        LINE (((i - 1) * 160) + 20, 50)-(((i - 1) * 160) + 140, 150), 0, BF
        LINE (((i - 1) * 160) + 21, 51)-(((i - 1) * 160) + 139, 149), 27, B
        LINE (((i - 1) * 160) + 22, 52)-(((i - 1) * 160) + 138, 148), 29, B
        LINE (((i - 1) * 160) + 23, 53)-(((i - 1) * 160) + 137, 147), 31, B
        OutText (((i - 1) * 160) + 39), 60, "POTION BONUS"
        LINE (((i - 1) * 160) + 27, 75)-(((i - 1) * 160) + 133, 137), 29, B
        PUT ((((i - 1) * 160) + 30), 79), Obj&(2000), PSET
        te$ = "X " + LTRIM$(STR$(Player(i).Special)) + ": " + LTRIM$(STR$(Player(i).Special * 200))
        OutText (((i - 1) * 160) + 53), 84, te$
        PUT ((((i - 1) * 160) + 30), 97), Obj&(1500), PSET
        te$ = "X " + LTRIM$(STR$(TimeLeft)) + ": " + LTRIM$(STR$(TimeLeft * 1000))
        OutText (((i - 1) * 160) + 53), 102, te$
        OutText (((i - 1) * 160) + 30), 115, "MULTIPLIER X" + LTRIM$(STR$(Multi#))
        Tot# = (((Player(i).Special * 200) + (TimeLeft * 1000))) * Multi#
        OutText (((i - 1) * 160) + 30), 125, "TOTAL : " + LTRIM$(STR$(Tot#))
        Player(i).Score = Player(i).Score + Tot#
        PrintStatBar
      NEXT i
      WHILE INKEY$ <> "": WEND
      q$ = INKEY$: WHILE (q$ <> CHR$(13) AND q$ <> "\"): q$ = INKEY$: WEND
      Level = Level + 1
    END IF
  ELSEIF Pass = -1 THEN
    Player(1).Cutter = FALSE: Player(2).Cutter = FALSE
    WHILE INKEY$ <> "": WEND
    q$ = INKEY$: WHILE (q$ <> CHR$(13) AND q$ <> "\"): q$ = INKEY$: WEND
  ELSE
    WHILE INKEY$ <> "": WEND
    q$ = INKEY$: WHILE (q$ <> CHR$(13) AND q$ <> "\"): q$ = INKEY$: WEND
  END IF
  IF NumPlayer = 2 THEN
    IF Player(1).Lives < 0 OR Player(2).Lives < 0 THEN EXIT DO
  ELSE
    IF Player(1).Lives < 0 THEN EXIT DO
  END IF
LOOP
Message "GAME OVER!"
END SUB

SUB PrintStatBar
FOR i = 1 TO 2
  IF Player(i).Score > Player(i).NextLife THEN Player(i).NextLife = Player(i).NextLife * 2: Player(i).Lives = Player(i).Lives + 1
  s$(i) = LTRIM$(STR$(Player(i).Score))
  IF Player(i).Score = 0 THEN s$(i) = "00"
  IF LEN(s$(i)) < 7 THEN s$(i) = STRING$(7 - LEN(s$(i)), " ") + s$(i)
  OutText (((i - 1) * 204) + 28), 0, s$(i)
  IF Player(i).Lives > 3 THEN
    FOR ii = 0 TO 2: PUT ((((i - 1) * 204) + 91) + (ii * 8), 0), Life&((i - 1) * 20), PSET: NEXT ii
    OutText (((i - 1) * 204) + 85), 0, LTRIM$(STR$(Player(i).Lives))
  ELSE
    FOR ii = 0 TO Player(i).Lives - 1: PUT ((((i - 1) * 204) + 91) + (ii * 8), 0), Life&((i - 1) * 20), PSET: NEXT ii
  END IF
NEXT i
s$(1) = LTRIM$(STR$(TimeLeft))
IF LEN(s$(1)) < 3 THEN s$(1) = STRING$(3 - LEN(s$(1)), "0") + s$(1)
OutText 137, 0, s$(1)
s$(2) = LTRIM$(STR$(Level))
IF LEN(s$(2)) < 2 THEN s$(2) = STRING$(2 - LEN(s$(2)), "0") + s$(2)
OutText 176, 0, s$(2)

END SUB

SUB PrintValue (xv, yv, va)
v$ = LTRIM$(STR$(va))
ad = (16 - (LEN(v$) * 4)) / 2
FOR l = 1 TO LEN(v$)
  PUT (xv + ad, yv + 6), Number&((ASC(MID$(v$, l, 1)) - 48) * 10), PSET
  ad = ad + 4
NEXT l
END SUB

