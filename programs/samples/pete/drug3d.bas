DECLARE SUB DrawBackGround (Maps!(), GroundColor!, LevelPos!)
DECLARE SUB Fall (Jump$, Dead$)
DECLARE SUB coolPrint (CP$, LineNumber!)
DECLARE SUB die ()
DECLARE SUB CheckDead (Dead$)
DECLARE SUB BUSCheck (Bus$)
DECLARE SUB DrawSquare (X!, Y!, Z!, ColorOfSquare!)
DECLARE SUB LoadMap (Level!)
DECLARE SUB Move (Movement$, GY!, Jump$)
DECLARE SUB DrawShip (ShipColor!)
DECLARE SUB Game ()
DECLARE SUB Menu (ChoiceCounter!, Movement$)
DIM SHARED Maps(5, 5, 106)
DIM SHARED PX(4)
DIM SHARED PY(4)
DIM SHARED PZ(4)
DIM SHARED LevelPos
DIM SHARED Level
DIM SHARED Speed
DIM SHARED GY
DIM SHARED JumpAgain$
DIM SHARED Score

SCREEN 12
COLOR 4
PRINT "      Canibal Gopher inc. presents "
PRINT "          Drug Runner 3d demo"
PRINT "           Demo version 1.00      "
PRINT "        Copyright Kevin B. Kohler "
PRINT "                  1998            "
PRINT
PRINT
PRINT "            Arrow keys move"
PRINT
PRINT "              Escape quits"
PRINT
PRINT "              Space jumps"
PRINT
PRINT "       <Press any key to continue>"
DO
LOOP UNTIL INKEY$ <> ""
CLS
SCREEN 12
LOCATE 5, 40
PRINT "Start Game"
LOCATE 10, 40
PRINT "Veiw high Scores"
LOCATE 15, 40
PRINT "Veiw intro"
LOCATE 20, 40
PRINT "quit game"
ChoiceCounter = 1
CIRCLE (180, ChoiceCounter * 80 - 10), 20, 1
PAINT (180, ChoiceCounter * 80 - 10), 1
DO
  Level = 1
  Menu ChoiceCounter, Movement$
  IF ChoiceCounter = 1 AND Movement$ = CHR$(13) THEN
    Game
    SCREEN 9
    SCREEN 12
    LOCATE 5, 40
    PRINT "Start Game"
    LOCATE 10, 40
    PRINT "Veiw high Scores"
    LOCATE 15, 40
    PRINT "Veiw intro"
    LOCATE 20, 40
    PRINT "quit game"
    ChoiceCounter = 1
    CIRCLE (180, ChoiceCounter * 80 - 10), 20, 1
    PAINT (180, ChoiceCounter * 80 - 10), 1
  END IF
LOOP UNTIL (ChoiceCounter = 4 AND Movement$ = CHR$(13))
CLS
PRINT "         Thank you for playing"
PRINT "          Drug Runner 3d demo"
PRINT "           Demo version 1.00      "
PRINT "        Copyright Kevin B. Kohler "
PRINT "                  1998            "
PRINT
PRINT "For more shareware games by cginc go to"
PRINT "www.geocities.com/silconvalley/bay/8360"
PRINT
PRINT "  if you liked this game feel free to"
PRINT " send money to 17 #6 road Leverett MA"
PRINT " 01054.  help me get to and through College"
PRINT "       <Press escape to continue>"
DO
LOOP UNTIL INKEY$ = CHR$(27)
END

SUB BUSCheck (Bus$)
  ZCheck = 1 + (INT(LevelPos))
  FOR Times = 1 TO 5
    X = Times * 128 - 384
    IF X - 64 < PX(3) AND X + 64 > PX(3) THEN
      FOR Times2 = 1 TO 4
	Y = Times2 * 24 + 240 - (Times2 * 100)
	IF Y - 30 < (PY(1) + 10) AND Y + 30 > (PY(1) + 10) THEN
	  IF Maps(Times, Times2, ZCheck) = 1 THEN
	    Bus$ = "y"
	    JumpAgain$ = "y"
	  END IF
	END IF
      NEXT Times2
    END IF
  NEXT Times
END SUB

SUB CheckDead (Dead$)
  ZCheck = 1 + (INT(LevelPos))
  FOR Times = 1 TO 5
    X = Times * 128 - 384
    IF X - 64 < PX(3) AND X + 64 > PX(3) THEN
      FOR Times2 = 1 TO 4
	Y = Times2 * 24 + 240 - (Times2 * 100)
	IF Y - 30 < PY(1) AND Y + 60 > PY(1) THEN
	  IF Maps(Times, Times2, ZCheck) = 1 THEN Dead$ = "y"
	  IF Maps(Times, Times2, ZCheck) = 2 THEN
	    Maps(Times, Times2, ZCheck) = 0
	    Score = Score + 1
	  END IF
	END IF
      NEXT Times2
    END IF
  NEXT Times
END SUB

SUB coolPrint (CP$, LineNumber)
  COLOR 2
  PALETTE 2, 0
  LOCATE 1, 1
  PRINT "                                      "
  LOCATE 1, 1
  PRINT CP$
  FOR Times = 1 TO 300
    FOR Times2 = 1 TO 30
      IF POINT(Times, Times2) = 2 THEN
	CIRCLE (Times * 2 + 50, Times2 * 2 + (LineNumber * 50)), 1, 5
      END IF
    NEXT Times2
  NEXT Times
END SUB

SUB die
  coolPrint " You have failed in your mission", 1
  coolPrint "To suply the world with the finest", 2
  coolPrint "         quality Drugs", 3
  coolPrint "           GAME OVER", 4
  coolPrint "   Press any key to continue", 5
  DO
  LOOP UNTIL INKEY$ <> ""
END SUB

SUB DrawBackGround (Maps(), GroundColor, LevelPos)
  FOR Times = 1 TO 5
    FOR Times2 = 1 TO 4
      FOR Times3 = 1 + (INT(LevelPos)) TO 10 + (INT(LevelPos))
	IF Maps(Times, Times2, Times3) = 1 THEN
	  IF Times2 = 1 THEN GroundColor = 4
	  IF Times2 = 2 THEN GroundColor = 0
	  IF Times2 = 3 THEN GroundColor = 14
	  IF Times2 = 4 THEN GroundColor = 15
	  DrawSquare Times, Times2, Times3 - LevelPos, GroundColor
	END IF
	IF Maps(Times, Times2, Times3) = 2 THEN
	  DrawSquare Times, Times2, Times3 - LevelPos, 10
	END IF
      NEXT Times3
    NEXT Times2
  NEXT Times
END SUB

SUB DrawShip (ShipColor)
  LINE (PX(1) / PZ(1) + 320, PY(1) / PZ(1) + 240)-(PX(2) / PZ(2) + 320, PY(2) / PZ(2) + 240), ShipColor
  LINE -(PX(3) / PZ(3) + 320, PY(3) / PZ(3) + 240), ShipColor
  LINE -(PX(4) / PZ(4) + 320, PY(4) / PZ(4) + 240), ShipColor
  LINE -(PX(1) / PZ(1) + 320, PY(1) / PZ(1) + 240), ShipColor
  LINE (PX(1) / PZ(1) + 320, PY(1) / PZ(1) + 240)-(PX(3) / PZ(3) + 320, PY(3) / PZ(3) + 240), ShipColor
  LINE (PX(4) / PZ(4) + 320, PY(4) / PZ(4) + 240)-(PX(2) / PZ(2) + 320, PY(2) / PZ(2) + 240), ShipColor
END SUB

SUB DrawSquare (TX, TY, Z, ColorOfSquare)
  X = TX * 128 - 384
  Y = TY * 24 + 240 - (TY * 100)
  IF Z <= .1 THEN Z = .1
  'square 1
  LINE ((X - 64) / Z + 320, (Y - 30) / Z + 240)-((X + 64) / Z + 320, (Y - 30) / Z + 240), ColorOfSquare
  LINE -((X + 64) / Z + 320, (Y + 30) / Z + 240), ColorOfSquare
  LINE -((X - 64) / Z + 320, (Y + 30) / Z + 240), ColorOfSquare
  LINE -((X - 64) / Z + 320, (Y - 30) / Z + 240), ColorOfSquare
  'Square 2
  LINE ((X - 64) / (Z + 1) + 320, (Y - 30) / (Z + 1) + 240)-((X + 64) / (Z + 1) + 320, (Y - 30) / (Z + 1) + 240), ColorOfSquare
  LINE -((X + 64) / (Z + 1) + 320, (Y + 30) / (Z + 1) + 240), ColorOfSquare
  LINE -((X - 64) / (Z + 1) + 320, (Y + 30) / (Z + 1) + 240), ColorOfSquare
  LINE -((X - 64) / (Z + 1) + 320, (Y - 30) / (Z + 1) + 240), ColorOfSquare
  'connecting squares
  LINE ((X - 64) / (Z + 1) + 320, (Y - 30) / (Z + 1) + 240)-((X - 64) / Z + 320, (Y - 30) / Z + 240), ColorOfSquare
  LINE ((X + 64) / (Z + 1) + 320, (Y - 30) / (Z + 1) + 240)-((X + 64) / Z + 320, (Y - 30) / Z + 240), ColorOfSquare
  LINE ((X + 64) / (Z + 1) + 320, (Y + 30) / (Z + 1) + 240)-((X + 64) / Z + 320, (Y + 30) / Z + 240), ColorOfSquare
  LINE ((X - 64) / (Z + 1) + 320, (Y + 30) / (Z + 1) + 240)-((X - 64) / Z + 320, (Y + 30) / Z + 240), ColorOfSquare
END SUB

SUB Fall (Jump$, Dead$)
  IF Jump$ = "y" THEN
    FOR Times = 1 TO 4
      PY(Times) = PY(Times) - 10
    NEXT Times
    IF PY(1) < GY - 120 THEN
      Jump$ = "n"
    END IF
  END IF
  IF Jump$ = "n" THEN
    BUSCheck Bus$
    IF PY(1) < 220 AND Bus$ <> "y" THEN
      JumpAgain$ = "n"
      FOR Times = 1 TO 4
	PY(Times) = PY(Times) + 10
      NEXT Times
    END IF
  END IF
  IF PY(1) >= 220 THEN
    JumpAgain$ = "y"
    Dead$ = "y"
  END IF
END SUB

SUB Game
  CLS
  Score = 0
  PX(1) = -40
  PY(1) = 30
  PZ(1) = 1
  PX(2) = 40
  PY(2) = 30
  PZ(2) = 1
  PX(3) = 0
  PY(3) = 0
  PZ(3) = 1
  PX(4) = 0
  PY(4) = 30
  PZ(4) = 1.25
  Start = TIMER
  Jump$ = "n"
  LevelPos = 1
  Speed = .1
  DO
    FOR Times = 1 TO 5
      FOR Times2 = 1 TO 5
	FOR Times3 = 1 TO 106
	  Maps(Times, Times2, Times3) = 0
	NEXT Times3
      NEXT Times2
    NEXT Times
    LoadMap Level
    IF LevelPos >= 94 THEN LevelPos = 1
    IF LevelPos <= 0 THEN LevelPos = 93
    'IF Level = 1 THEN LevelPos = 90
    DO
      StartTurn = TIMER
      Movement$ = INKEY$
      'DrawBackGround Map(), 0, LevelPos
      'DrawShip 0
      IF Movement$ <> "" THEN
	Move Movement$, GY, Jump$
      END IF
      Fall Jump$, Dead$
      LevelPos = LevelPos + Speed
      'cls
      'PSub
      LINE (0, 0)-(640, 240), 9, BF
      LINE (0, 240)-(640, 480), 8, BF
      LOCATE 1, 1
      PRINT Score
      PRINT INT(TIMER - Start)
      DrawShip 1
      DrawBackGround Maps(), 2, LevelPos
      CheckDead Dead$
      DO
      LOOP UNTIL TIMER - StartTurn > .1
    LOOP UNTIL Movement$ = CHR$(27) OR LevelPos >= 90 OR LevelPos <= 0 OR Dead$ = "y"
    IF LevelPos >= 94 THEN Level = Level + 1
    IF LevelPos <= 0 THEN Level = Level - 1
  LOOP UNTIL Movement$ = CHR$(27) OR Dead$ = "y" OR Level > 3
  Time = TIMER - Start
  CLS
  IF Level > 3 THEN
    CLS
    coolPrint "         You Win!!!!", 1
    coolPrint "  Press any key to continue", 3
    DO
    LOOP UNTIL INKEY$ <> ""
    DO
    LOOP UNTIL INKEY$ <> ""
    CLS
    PRINT "Your score Was - "; Score
    PRINT "Your Time Was - "; Time
    DO
    LOOP UNTIL INKEY$ <> ""
  END IF
  IF Dead$ = "y" THEN
    Times = 9.999999999999998#
    CLS
    die
    CLS
  END IF
  PRINT Time
  'ScoreBoard
END SUB

SUB LoadMap (Level)
  Maps(3, 2, 15) = 2
  FOR Times = 1 TO 50
    X = INT(RND * 5) + 1
    Y = INT(RND * 3) + 2
    Z = INT(RND * 80) + 11
    Maps(X, Y, Z) = 2
  NEXT Times
  IF Level = 1 THEN
    FOR Times = 1 TO 5 STEP 3
      FOR Times2 = 1 TO 95 STEP 3
	Maps(Times, 1, Times2) = 1
      NEXT Times2
    NEXT Times
    FOR Times = 1 TO 5 STEP 2
      FOR Times2 = 1 TO 95 STEP 2
	Maps(Times, 1, Times2) = 1
      NEXT Times2
    NEXT Times
    FOR Times2 = 1 TO 95 STEP 13
      Maps(2, 1, Times2) = 1
    NEXT Times2
    FOR Times = 1 TO 5
      FOR Times2 = 1 TO 95 STEP 10
	Maps(Times, 2, Times2) = 1
      NEXT Times2
    NEXT Times
    FOR Times = 1 TO 5 STEP 2
      FOR Times2 = 20 TO 40
	Maps(Times, 2, Times2) = 1
	Maps(Times, 1, Times2) = 1
      NEXT Times2
      FOR Times2 = 30 TO 40
	Maps(Times, 3, Times2) = 1
      NEXT Times2
    NEXT Times
    FOR Times = 1 TO 5
      FOR Times2 = 1 TO 3
	Maps(Times, 1, Times2 + 95) = 1
      NEXT Times2
    NEXT Times
    FOR Times = 90 TO 100
      FOR Times2 = 1 TO 5
	Maps(Times2, 1, Times) = 1
      NEXT Times2
    NEXT Times
  END IF
  IF Level = 2 THEN
    Maps(5, 2, 9) = 1
    FOR Times = 1 TO 5
      FOR Times2 = 1 TO 100
	Maps(Times, 1, Times2) = 1
	'maps(times,3,times2)= 1
      NEXT
    NEXT
    FOR Times = 1 TO 5
      FOR Times2 = 10 TO 50
	Maps(Times, 3, Times2) = 1
      NEXT Times2
    NEXT Times
    FOR Times = 1 TO 5 STEP 2
      FOR Times2 = 10 TO 50 STEP 4
	Maps(Times, 2, Times2) = 1
	'maps (times,3,times2 +2)= 1
      NEXT Times2
    NEXT Times
    FOR Times = 2 TO 5 STEP 2
      FOR Times2 = 12 TO 50 STEP 4
	Maps(Times, 2, Times2) = 1
	'maps(times, 3, Times2 + 2) = 1
      NEXT Times2
    NEXT
    FOR Times = 55 TO 90 STEP 4
      Maps(1, 2, Times) = 1
      Maps(2, 3, Times) = 1
      Maps(3, 2, Times) = 1
      Maps(4, 3, Times) = 1
      Maps(5, 2, Times) = 1
    NEXT Times
    FOR Times = 57 TO 90 STEP 4
      Maps(1, 3, Times) = 1
      Maps(2, 2, Times) = 1
      Maps(3, 3, Times) = 1
      Maps(4, 2, Times) = 1
      Maps(5, 3, Times) = 1
    NEXT Times
  END IF
  IF Level = 3 THEN
    FOR Times = 1 TO 10
      FOR Times2 = 1 TO 5
	Maps(Times2, 1, Times) = 1
      NEXT Times2
    NEXT Times
    FOR Times = 10 TO 50 STEP 5
      FOR Times2 = 1 TO 5
	Maps(Times2, 1, Times + Times2) = 1
	Maps(5 - Times2, 2, Times + Times2) = 1
      NEXT Times2
    NEXT Times
    FOR Times = 90 TO 100
      FOR Times2 = 1 TO 5
	Maps(Times2, 1, Times) = 1
      NEXT Times2
    NEXT Times
    FOR Times = 50 TO 90
      Maps((Times / 5 - INT(Times / 5) * 10), 1, Times) = 1
      Maps((Times / 5 - INT(Times / 5) * 10), 3, Times) = 1
    NEXT Times
  END IF
END SUB

SUB Menu (ChoiceCounter, Movement$)
  Movement$ = INKEY$
  IF LEN(Movement$) >= 2 THEN Movement$ = MID$(Movement$, 2, 1)
  LOCATE 1, 1
  IF Movement$ = "H" THEN
    PAINT (180, ChoiceCounter * 80 - 10), 0
    ChoiceCounter = ChoiceCounter - 1
    IF ChoiceCounter = 0 THEN ChoiceCounter = 4
    CIRCLE (180, ChoiceCounter * 80 - 10), 20, 1
    PAINT (180, ChoiceCounter * 80 - 10), 1
  END IF
  IF Movement$ = "P" THEN
    PAINT (180, ChoiceCounter * 80 - 10), 0
    ChoiceCounter = ChoiceCounter + 1
    IF ChoiceCounter = 5 THEN ChoiceCounter = 1
    CIRCLE (180, ChoiceCounter * 80 - 10), 20, 1
    PAINT (180, ChoiceCounter * 80 - 10), 1
  END IF
END SUB

SUB Move (Movement$, GY, Jump$)
  IF LEN(Movement$) >= 2 THEN Movement$ = MID$(Movement$, 2, 1)
  IF Movement$ = "K" AND PX(1) > -320 THEN
    FOR Times = 1 TO 4
      PX(Times) = PX(Times) - 40
    NEXT Times
  END IF
  IF Movement$ = "M" AND PX(2) < 320 THEN
    FOR Times = 1 TO 4
      PX(Times) = PX(Times) + 40
    NEXT Times
  END IF
  IF Movement$ = "H" THEN
    IF Speed <= .9 THEN Speed = Speed + .05
  END IF
  IF Movement$ = "P" THEN
    IF Speed >= -.9 THEN Speed = Speed - .05
  END IF
  IF Movement$ = " " AND JumpAgain$ <> "n" THEN
    Jump$ = "y"
    JumpAgain$ = "n"
    GY = PY(1)
  END IF
END SUB

