RANDOMIZE TIMER
start:
CLS
PRINT "Welcome to the ultimate ASCII-player game: MOVE!"
PRINT "v.1.0                       by mxmm"
SLEEP 5
CLS
PRINT "Choose one of the following:"
PRINT " 1. Play the Game!"
PRINT " 2. View the instructions!"
INPUT "         So what is it going to be"; choice
CLS
IF (choice = 1) THEN
GOTO game
ELSEIF (choice = 2) THEN
GOTO instructions
ELSE
SOUND 1000, 15
PRINT "ERROR: YOU HAVE NOT TYPED IN A VALID CHARACTER. GAME WILL RESTART IN 5 SECONDS  OR WHEN YOU PRESS A KEY"
SLEEP 5
CLS
GOTO start
END IF
instructions:
PRINT "The controls of this game are simple:"
PRINT "         W: Move up"
PRINT "         S: Move down"
PRINT "         A: Move left"
PRINT "         D: Move right"
PRINT "         Q: Quit"
PRINT " Collect Items and avoid enemies"
PRINT "ITEMS:"
PRINT "         T: Gives more time"
PRINT "         F: Freezes the enemy"
PRINT "         O: The enemy"
PRINT ""
PRINT "PRESS ANY BUTTON TO GO BACK TO THE MAIN SCREEN"
SLEEP
CLS
GOTO start
END
game:
INPUT "How much freeze to you want to start out with"; x
CLS
INPUT "What do you want the handicap to be (Higher is easier)"; y
CLS
freezel = 10 * y
freeze = 0
freezer = INT(RND * 21 + 1)
freezec = INT(RND * 71 + 1)
hurt = 1
playerc = 1    'Main player's column
playerr = 1    'Main player's row
enemyc = 20    'Enemy's column
enemyr = 20    'Enemy's row
turns = 35 * y'The starting amount of turns
turnitemr = INT(RND * 21 + 1)
turnitemc = INT(RND * 71 + 1)
compturn = 1
die = 0
death:
IF (die = 1) THEN
PRINT "GAME OVER!"
SOUND 500, 3
SOUND 250, 3
SOUND 90, 3
INPUT "Continue(y/n)"; cont$
IF (cont$ = "y") THEN
CLS
GOTO start
ELSEIF (cont$ = "n") THEN
CLS
END
END IF
END IF
DO
in$ = INKEY$
IF (compturn = 1) THEN
compturn = 0
ELSEIF (compturn = 0) THEN
compturn = 1
END IF
IF (playerr = enemyr) AND (playerc = enemyc) AND (hurt = 1) THEN
die = 1
GOTO death
END IF
IF (in$ = "a") AND (playerc > 1) THEN      'input
playerc = playerc - 1
turns = turns - 1
ELSEIF (in$ = "d") AND (playerc < 79) THEN
playerc = playerc + 1
turns = turns - 1
ELSEIF (in$ = "s") AND (playerr < 24) THEN
playerr = playerr + 1
turns = turns - 1
ELSEIF (in$ = "w") AND (playerr > 1) THEN
playerr = playerr - 1
turns = turns - 1
ELSEIF (in$ = "q") THEN
die = 1
GOTO death
END IF
IF (playerr = turnitemr) AND (playerc = turnitemc) THEN
turns = turns + 25 * y
turnitemr = INT(RND * 21 + 1)
turnitemc = INT(RND * 71 + 1)
END IF
IF (freezer = playerr) AND (freezec = playerc) THEN
freezel = freezel + 5 * y
freezer = INT(RND * 21 + 1)
freezec = INT(RND * 71 + 1)
END IF
IF (freeze = 0) THEN
IF (compturn = 1) THEN
IF (enemyc > playerc) THEN
enemyc = enemyc - 1
ELSEIF (enemyc < playerc) THEN
enemyc = enemyc + 1
END IF
IF (enemyr > playerr) THEN
enemyr = enemyr - 1
ELSEIF (enemyr < playerr) THEN
enemyr = enemyr + 1
END IF
END IF
END IF
CLS
LOCATE 25, 1
IF (turns = 0) THEN
GOTO death
END IF
freezer2 = freezer + 2
LOCATE freezer2, freezec
PRINT "F"
LOCATE 25, 1
PRINT "Freeze: "; freezel
LOCATE 24, 1
PRINT "Turns: "; turns
LOCATE turnitemr, turnitemc
PRINT "T"
LOCATE playerr, playerc
PRINT "X"
LOCATE enemyr, enemyc
PRINT "O"
IF (freezel > 0) THEN
freezel = freezel - 1
freeze = 1
END IF
IF (freezel = 0) THEN
freeze = 0
END IF
SLEEP 1
LOOP UNTIL (in$ = "q")
END














