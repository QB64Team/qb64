'****************************** ROBORAIDER *********************************
'********************************** by *************************************
'***************************** x.t.r.GRAPHICS (TM) *************************

'**************************** PRESS <F5> TO PLAY!! *************************

'############### Copyright 2004 by Kevin ################

DECLARE SUB Ending ()
DECLARE SUB Mission06 ()
DECLARE SUB Menu9 ()
DECLARE SUB Mission05 ()
DECLARE SUB Menu8 ()
DECLARE SUB Mission04 ()
DECLARE SUB Menu7 ()
DECLARE SUB Mbrief01 ()
DECLARE SUB Mission03 ()
DECLARE SUB Menu6 ()
DECLARE SUB Mission02 ()
DECLARE SUB Menu5 ()
DECLARE SUB Mission01 ()
DECLARE SUB Menu4 ()
DECLARE SUB Test003 ()
DECLARE SUB Menu3 ()
DECLARE SUB Test002 ()
DECLARE SUB Dril ()
DECLARE SUB Drop ()
DECLARE SUB Missionb2 ()
DECLARE SUB Scorp ()
DECLARE SUB Creep ()
DECLARE SUB Tbot1 ()
DECLARE SUB Tbot2 ()
DECLARE SUB Missionb ()
DECLARE SUB Trainerb ()
DECLARE SUB Robopic ()
DECLARE SUB Bonus ()
DECLARE SUB Trailer ()
DECLARE SUB Menu2 ()
DECLARE SUB Test001 ()
DECLARE SUB Levelcode ()
DECLARE SUB Credits ()
DECLARE SUB Help ()
DECLARE SUB Menu ()
DECLARE SUB Intro ()
CALL Intro

SUB Bonus
CLS
SCREEN 13
COLOR 10
PRINT " RoboRaiders: >>BONUS>>"
LOCATE 20, 3: PRINT "Press 'Enter' to select"
LOCATE 22, 2: PRINT "Press 'F1' for Help, Press 'Esc' to Exit"
C = 1
DO
press$ = INKEY$
IF C = 1 THEN LOCATE 10, 15: COLOR 10: PRINT ">>GAME-TRAILER>>": LOCATE 11, 15: COLOR 15: PRINT ">>ROBO-PICS<<": LOCATE 13, 15: COLOR 15: PRINT ">>MENU<<"
IF C = 2 THEN LOCATE 10, 15: COLOR 15: PRINT ">>GAME-TRAILER<<": LOCATE 11, 15: COLOR 9: PRINT ">>ROBO-PICS>>": LOCATE 13, 15: COLOR 15: PRINT ">>MENU<<"
IF C = 3 THEN LOCATE 10, 15: COLOR 15: PRINT ">>GAME-TRAILER<<": LOCATE 11, 15: COLOR 15: PRINT ">>ROBO-PICS<<": LOCATE 13, 15: COLOR 14: PRINT ">>MENU>>"
IF C = 2 THEN IF press$ = CHR$(0) + CHR$(80) THEN C = 3: PLAY "D16"
IF C = 1 THEN IF press$ = CHR$(0) + CHR$(80) THEN C = 2: PLAY "D16"
IF C = 2 THEN IF press$ = CHR$(0) + CHR$(72) THEN C = 1: PLAY "D16"
IF C = 3 THEN IF press$ = CHR$(0) + CHR$(72) THEN C = 2: PLAY "D16"
IF C = 2 THEN IF press$ = "2" THEN C = 3: PLAY "D16"
IF C = 1 THEN IF press$ = "2" THEN C = 2: PLAY "D16"
IF C = 2 THEN IF press$ = "8" THEN C = 1: PLAY "D16"
IF C = 3 THEN IF press$ = "8" THEN C = 2: PLAY "D16"
IF C = 1 THEN IF press$ = CHR$(13) THEN PLAY "B16": CALL Trailer
IF C = 2 THEN IF press$ = CHR$(13) THEN PLAY "B16": CALL Robopic
IF C = 3 THEN IF press$ = CHR$(13) THEN PLAY "B16": CALL Menu
IF press$ = CHR$(0) + ";" THEN CALL Help
LOOP UNTIL press$ = CHR$(27)
END

END SUB

SUB Credits
PLAY "MB O4"
CLS
SCREEN 13
LOCATE 22, 1
'######## Robo Theme #######
PLAY "E16 G E16 C2 C G E E3 G E C3 E16 G E16 C2 C16 C G3 E16 E E16 G F E G C3 E16 G E16 C2"
COLOR 10
PRINT "            Credits"
SLEEP (1)
PRINT
SLEEP (1)
PRINT
SLEEP (1)
PRINT "     Main Programer   Kevin"
SLEEP (1)
PRINT
SLEEP (1)
PRINT "           Graphics   Kevin"
SLEEP (1)
PRINT
SLEEP (1)
PRINT "           Debuging   Kevin"
SLEEP (1)
PRINT
SLEEP (1)
PRINT
COLOR 9
SLEEP (1)
PRINT
SLEEP (1)
PRINT "        Special Thanks"
SLEEP (1)
PRINT
SLEEP (1)
PRINT
SLEEP (1)
PRINT "     Anyone who plays my games :)"
SLEEP (1)
PRINT
SLEEP (1)
PRINT "   Vic's Qbasic Programing Tutorials"
SLEEP (1)
PRINT
SLEEP (1)
PRINT "    Mallard's 'Basic Basic' Tutorials"
SLEEP (1)
PRINT
SLEEP (1)
PRINT "   Qbasic By Exaple (by Greg Perry)"
SLEEP (1)
PRINT
COLOR 14
SLEEP (1)
PRINT
SLEEP (1)
PRINT "          Cool sites "
SLEEP (1)
PRINT
SLEEP (1)
PRINT
SLEEP (1)
PRINT "       www.qbasic.com"
SLEEP (1)
PRINT
SLEEP (1)
PRINT "     www.qbasicnews.com"
SLEEP (1)
PRINT
SLEEP (1)
PRINT "   Those 2 sites link to more"
SLEEP (1)
PRINT
SLEEP (1)
PRINT "   Look out for RoboRaider II"
SLEEP (1)
PRINT
SLEEP (1)
PRINT "   Play all levels for Bonus Levelcode!"
SLEEP (1)
PRINT
SLEEP (1)
PRINT
COLOR 7
SLEEP (1)
PRINT " This is the Classic style of Robo-"
SLEEP (1)
PRINT " Raider, I hope to have a Hi-Def "
SLEEP (1)
PRINT " version of this one and the second"
SLEEP (1)
PRINT " one next year."
SLEEP (1)
PRINT
SLEEP (1)
PRINT
SLEEP (1)
PRINT
SLEEP (1)
PRINT
SLEEP (1)
PRINT
SLEEP (1)
PRINT
SLEEP (1)
PRINT
SLEEP (1)
PRINT
SLEEP (1)
PRINT
SLEEP (1)
PRINT
SLEEP (1)
PRINT
SLEEP (1)
PRINT
SLEEP (1)
PRINT
SLEEP (1)
PRINT
SLEEP (1)
PRINT

CALL Menu
END SUB

SUB Creep
CLS
SCREEN 13
LINE (10, 37)-(20, 45), 8, BF
LINE (20, 35)-(160, 50), 10, BF
LINE (22, 36)-(158, 36), 8
LINE (22, 60)-(158, 60), 8
CIRCLE (22, 48), 15, 7
PAINT (22, 48), 7
PSET (22, 48), 0
CIRCLE (158, 48), 15, 7
PAINT (158, 48), 7
PSET (158, 48), 0
LOCATE 10, 1: PRINT " Creeper: Mission 3:"
LOCATE 12, 1: PRINT "  Did someone step on it? Nope this"
LOCATE 13, 1: PRINT "  Bot is made for tight places. Like"
LOCATE 14, 1: PRINT "  low hanging ceilings."
COLOR 10
LOCATE 17, 1: PRINT " Press SPACEBAR to continue..."
DO
press$ = INKEY$
LOOP UNTIL press$ = " "
CALL Missionb

END SUB

SUB Dril
CLS
SCREEN 13
LINE (60, 20)-(160, 50), 9, BF
LINE (60, 20)-(20, 35), 8
LINE (20, 35)-(60, 50), 8
LINE (60, 50)-(60, 20), 8
PAINT (55, 35), 8
LINE (70, 36)-(158, 36), 8
LINE (70, 60)-(158, 60), 8
CIRCLE (70, 48), 15, 7
PAINT (70, 48), 7
PSET (70, 48), 0
CIRCLE (158, 48), 15, 7
PAINT (158, 48), 7
PSET (158, 48), 0
LOCATE 10, 1: PRINT " Trainer-Bot: Test 1-2:"
LOCATE 12, 1: PRINT "  A simple desinged robot for easy"
LOCATE 13, 1: PRINT "  repairs. Used for the first two"
LOCATE 14, 1: PRINT "  test in case of a crash."
COLOR 10
LOCATE 17, 1: PRINT " Press SPACEBAR to continue..."
DO
press$ = INKEY$
LOOP UNTIL press$ = " "
CALL Missionb2

END
END SUB

SUB Drop
CLS
SCREEN 13
LINE (10, 32)-(20, 45), 8, BF
LINE (20, 30)-(160, 50), 12, BF
LINE (22, 36)-(158, 36), 8
LINE (22, 60)-(158, 60), 8
'** SPIKE **
LINE (130, 29)-(110, 29), 7
LINE (130, 29)-(120, 10), 7: LINE (110, 29)-(120, 10), 7
PAINT (120, 20), 7
LINE (120, 10)-(120, 29), 8
'** WHEELS **
CIRCLE (22, 48), 15, 7
PAINT (22, 48), 7
PSET (22, 48), 0
CIRCLE (158, 48), 15, 7
PAINT (158, 48), 7
PSET (158, 48), 0
LOCATE 10, 1: PRINT " Drop-Bot: Mission 4:"
LOCATE 12, 1: PRINT "  This Bot has a harpoon to raise "
LOCATE 13, 1: PRINT "  and lower itself to different "
LOCATE 14, 1: PRINT "  levels of terrain."
COLOR 10
LOCATE 17, 1: PRINT " Press SPACEBAR to continue..."
DO
press$ = INKEY$
LOOP UNTIL press$ = " "
CALL Missionb2

END SUB

SUB Ending
SCREEN 13
COLOR 15
CLS
PRINT " Dr Robo's Notes:"
PRINT
PRINT "      I inserted all the gems into the"
PRINT " disk. It began to glow, and then "
PRINT " another slot melted into the center. "
PRINT " There is another gem!! I must research,"
PRINT " but until then then, my pilot needs a "
PRINT " break...."
PRINT "      I'll give him a vacation while I "
PRINT " dig up the location of the last gem."
PRINT " Hopefuly the mystery will be solved,"
PRINT " and we can find out what this does..."
PRINT
PRINT
PRINT
PRINT
COLOR 10
PRINT " Press SPACEBAR to continue..."
DO
press$ = INKEY$
LOOP UNTIL press$ = " "
CALL Bonus
END SUB

SUB Help
CLS
PRINT " Help File:"
PRINT
PRINT "     First thing first: to highlight"
PRINT " other menu commands, use the arrow- "
PRINT " keys. Press 'Enter' to select"
PRINT " Robots move with the arrowkeys. The"
PRINT " grip on the collecter bots operate"
PRINT " automaticaly when a item is in their"
PRINT " reach. You can press 'Esc' almost"
PRINT " anywhere in the game to exit."
PRINT " For any more help, open the README.TXT"
PRINT " located with this game."
PRINT
COLOR 10
PRINT " Press any key to return"
DO
LOOP WHILE INKEY$ = ""
CALL Menu
END SUB

SUB Intro
PLAY "MB <"
CLS
SCREEN 13
'######## Robo Theme #######
PLAY "E16 G E16 C2 C G E E3 G E C3 E16 G E16 C2 C16 C G3 E16 E E16 G F E G C3 E16 G E16 C2"
'######## Intro #######
LOCATE 10, 15: COLOR 44: PRINT "xt": LOCATE 10, 17: COLOR 43: PRINT "GRAP": LOCATE 10, 21: COLOR 42: PRINT "HICS(TM)": COLOR 15
SLEEP (3)
CLS
LOCATE 10, 13: COLOR 42: PRINT ">>>": LOCATE 10, 16: COLOR 43: PRINT "PRE": LOCATE 10, 19: COLOR 44: PRINT "SE": LOCATE 10, 21: COLOR 43: PRINT "NTS": LOCATE 10, 23: COLOR 42: PRINT ">>>": COLOR 15
SLEEP (3)
CLS
LOCATE 10, 14: COLOR 7: PRINT "RoboRaider": COLOR 15
SLEEP (3)
CLS
PRINT " Dr. Robo's Notes:"
PRINT
PRINT "      Note to self: My last Robo-Raider,"
PRINT " while exploring a cave, carelessly "
PRINT " hit a trip wire destoring one of my "
PRINT " finest robots. For this run on with "
PRINT " a rolling rock, I myself, slightly "
PRINT " inraged, carelessly fired him. Gee, "
PRINT " that leaves me with without a robot "
PRINT " pilot!"
PRINT "      Note to self: Run ad in paper for "
PRINT " new pilot."
COLOR 10: LOCATE 23, 1: PRINT " Press SPACEBAR to continue...."
DO
press$ = INKEY$
LOOP UNTIL press$ = " "
COLOR 15

PRINT " NewsPaper AD:"
PRINT ""
PRINT "      Dear R/C car fans, do you want to "
PRINT " be well paid for your piloting skills?"
PRINT " If so contact me at (###) ###-ROBO."
PRINT " Callers will have an appoitment setup "
PRINT " to take my tests. If you pass all three"
PRINT " tests completely, you will be hired on "
PRINT " the spot. "
PRINT
PRINT
PRINT
PRINT
PRINT
PRINT
PRINT
PRINT
PRINT
PRINT
PRINT
PRINT
PRINT
PRINT
COLOR 10: LOCATE 23, 1: PRINT " Press SPACEBAR to continue...."
DO
press$ = INKEY$
LOOP UNTIL press$ = " "
CALL Menu
END SUB

SUB Levelcode
CLS
SCREEN 13
COLOR 9
PRINT " Turn on CAPS LOCK to type Levelcode."
PRINT " Press 'Enter' to check code."
PRINT "  Levelcodes take you to levels you "
PRINT "  last left off...."
PRINT
PRINT
INPUT " Insert Levelcode:", lcode$
PRINT "  Checking Levelcode>>"; lcode$
SLEEP (4)

IF lcode$ = "TEST001" THEN GOTO swtch
IF lcode$ = "TEST002" THEN GOTO swtch
IF lcode$ = "TEST003" THEN GOTO swtch
IF lcode$ = "POINTY" THEN GOTO swtch
IF lcode$ = "INDEEP" THEN GOTO swtch
IF lcode$ = "SUBRUINS" THEN GOTO swtch
IF lcode$ = "TOWER" THEN GOTO swtch
IF lcode$ = "WALLDRILL" THEN GOTO swtch
IF lcode$ = "AMAZEME" THEN GOTO swtch
IF lcode$ = "ROBOBONUS" THEN GOTO swtch
IF lcode$ <> "" THEN GOTO err1
IF lcode$ = "" THEN GOTO err1

swtch: COLOR 10
PRINT
PRINT " "; lcode$; " is valid!"
PRINT " Enjoy this level!"
SLEEP (6)
IF lcode$ = "TEST001" THEN CALL Menu
IF lcode$ = "TEST002" THEN CALL Menu2
IF lcode$ = "TEST003" THEN CALL Menu3
IF lcode$ = "POINTY" THEN CALL Menu4
IF lcode$ = "INDEEP" THEN CALL Menu5
IF lcode$ = "SUBRUINS" THEN CALL Menu6
IF lcode$ = "TOWER" THEN CALL Menu7
IF lcode$ = "WALLDRILL" THEN CALL Menu8
IF lcode$ = "AMAZEME" THEN CALL Menu9
IF lcode$ = "ROBOBONUS" THEN CALL Bonus

err1: COLOR 12
PRINT
PRINT " "; lcode$; " does not compute."
PRINT " To get a level's code, defeat"
PRINT " the level before it..."
SLEEP (8)
CALL Menu
END SUB

SUB Mbrief01
CLS
SCREEN 13
COLOR 15
PRINT " Mission Briefing:"
PRINT
PRINT "      In your last mission, you  "
PRINT " collected a round disk. This I  "
PRINT " looked over carefuly, and I found"
PRINT " something... Your first Item, that"
PRINT " was found in the pyramid, the gem,"
PRINT " fits perfecly in one of the slots."
PRINT " There are four more slots to fill."
PRINT " I've looked, and found what I think"
PRINT " are the rest. One of them I hope to"
PRINT " collect myself. Any way, I think "
PRINT " this might be important, lets get "
PRINT " the other gems and find out!"
PRINT
PRINT
COLOR 10
PRINT " Press SPACEBAR to continue..."
DO
press$ = INKEY$
LOOP UNTIL press$ = " "
CALL Mission03
END SUB

SUB Menu
CLS
SCREEN 13
COLOR 10
PRINT " RoboRaiders: >>Test1>>"
LOCATE 20, 3: PRINT "Press 'Enter' to select"
LOCATE 22, 2: PRINT "Press 'F1' for Help, Press 'Esc' to Exit"
C = 1
DO
press$ = INKEY$
IF C = 1 THEN LOCATE 10, 15: COLOR 10: PRINT ">>START>>": LOCATE 11, 15: COLOR 15: PRINT ">>LEVELCODE<<": LOCATE 13, 15: COLOR 15: PRINT ">>CREDITS<<"
IF C = 2 THEN LOCATE 10, 15: COLOR 15: PRINT ">>START<<": LOCATE 11, 15: COLOR 9: PRINT ">>LEVELCODE>>": LOCATE 13, 15: COLOR 15: PRINT ">>CREDITS<<"
IF C = 3 THEN LOCATE 10, 15: COLOR 15: PRINT ">>START<<": LOCATE 11, 15: COLOR 15: PRINT ">>LEVELCODE<<": LOCATE 13, 15: COLOR 14: PRINT ">>CREDITS>>"
IF C = 2 THEN IF press$ = CHR$(0) + CHR$(80) THEN C = 3: PLAY "D16"
IF C = 1 THEN IF press$ = CHR$(0) + CHR$(80) THEN C = 2: PLAY "D16"
IF C = 2 THEN IF press$ = CHR$(0) + CHR$(72) THEN C = 1: PLAY "D16"
IF C = 3 THEN IF press$ = CHR$(0) + CHR$(72) THEN C = 2: PLAY "D16"
IF C = 2 THEN IF press$ = "2" THEN C = 3: PLAY "D16"
IF C = 1 THEN IF press$ = "2" THEN C = 2: PLAY "D16"
IF C = 2 THEN IF press$ = "8" THEN C = 1: PLAY "D16"
IF C = 3 THEN IF press$ = "8" THEN C = 2: PLAY "D16"
IF C = 1 THEN IF press$ = CHR$(13) THEN PLAY "B16": CALL Test001
IF C = 2 THEN IF press$ = CHR$(13) THEN PLAY "B16": CALL Levelcode
IF C = 3 THEN IF press$ = CHR$(13) THEN PLAY "B16": CALL Credits
IF press$ = CHR$(0) + ";" THEN CALL Help
LOOP UNTIL press$ = CHR$(27)
END
END SUB

SUB Menu2
CLS
SCREEN 13
COLOR 10
PRINT " RoboRaiders: >>Test2>>"
LOCATE 20, 3: PRINT "Press 'Enter' to select"
LOCATE 22, 2: PRINT "Press 'F1' for Help, Press 'Esc' to Exit"
C = 1
DO
press$ = INKEY$
IF C = 1 THEN LOCATE 10, 15: COLOR 10: PRINT ">>START>>": LOCATE 11, 15: COLOR 15: PRINT ">>LEVELCODE<<": LOCATE 13, 15: COLOR 15: PRINT ">>CREDITS<<"
IF C = 2 THEN LOCATE 10, 15: COLOR 15: PRINT ">>START<<": LOCATE 11, 15: COLOR 9: PRINT ">>LEVELCODE>>": LOCATE 13, 15: COLOR 15: PRINT ">>CREDITS<<"
IF C = 3 THEN LOCATE 10, 15: COLOR 15: PRINT ">>START<<": LOCATE 11, 15: COLOR 15: PRINT ">>LEVELCODE<<": LOCATE 13, 15: COLOR 14: PRINT ">>CREDITS>>"
IF C = 2 THEN IF press$ = CHR$(0) + CHR$(80) THEN C = 3: PLAY "D16"
IF C = 1 THEN IF press$ = CHR$(0) + CHR$(80) THEN C = 2: PLAY "D16"
IF C = 2 THEN IF press$ = CHR$(0) + CHR$(72) THEN C = 1: PLAY "D16"
IF C = 3 THEN IF press$ = CHR$(0) + CHR$(72) THEN C = 2: PLAY "D16"
IF C = 2 THEN IF press$ = "2" THEN C = 3: PLAY "D16"
IF C = 1 THEN IF press$ = "2" THEN C = 2: PLAY "D16"
IF C = 2 THEN IF press$ = "8" THEN C = 1: PLAY "D16"
IF C = 3 THEN IF press$ = "8" THEN C = 2: PLAY "D16"
IF C = 1 THEN IF press$ = CHR$(13) THEN PLAY "B16": CALL Test002
IF C = 2 THEN IF press$ = CHR$(13) THEN PLAY "B16": CALL Levelcode
IF C = 3 THEN IF press$ = CHR$(13) THEN PLAY "B16": CALL Credits
IF press$ = CHR$(0) + ";" THEN CALL Help
LOOP UNTIL press$ = CHR$(27)
END

END SUB

SUB Menu3
CLS
SCREEN 13
COLOR 10
PRINT " RoboRaiders: >>Test3>>"
LOCATE 20, 3: PRINT "Press 'Enter' to select"
LOCATE 22, 2: PRINT "Press 'F1' for Help, Press 'Esc' to Exit"
C = 1
DO
press$ = INKEY$
IF C = 1 THEN LOCATE 10, 15: COLOR 10: PRINT ">>START>>": LOCATE 11, 15: COLOR 15: PRINT ">>LEVELCODE<<": LOCATE 13, 15: COLOR 15: PRINT ">>CREDITS<<"
IF C = 2 THEN LOCATE 10, 15: COLOR 15: PRINT ">>START<<": LOCATE 11, 15: COLOR 9: PRINT ">>LEVELCODE>>": LOCATE 13, 15: COLOR 15: PRINT ">>CREDITS<<"
IF C = 3 THEN LOCATE 10, 15: COLOR 15: PRINT ">>START<<": LOCATE 11, 15: COLOR 15: PRINT ">>LEVELCODE<<": LOCATE 13, 15: COLOR 14: PRINT ">>CREDITS>>"
IF C = 2 THEN IF press$ = CHR$(0) + CHR$(80) THEN C = 3: PLAY "D16"
IF C = 1 THEN IF press$ = CHR$(0) + CHR$(80) THEN C = 2: PLAY "D16"
IF C = 2 THEN IF press$ = CHR$(0) + CHR$(72) THEN C = 1: PLAY "D16"
IF C = 3 THEN IF press$ = CHR$(0) + CHR$(72) THEN C = 2: PLAY "D16"
IF C = 2 THEN IF press$ = "2" THEN C = 3: PLAY "D16"
IF C = 1 THEN IF press$ = "2" THEN C = 2: PLAY "D16"
IF C = 2 THEN IF press$ = "8" THEN C = 1: PLAY "D16"
IF C = 3 THEN IF press$ = "8" THEN C = 2: PLAY "D16"
IF C = 1 THEN IF press$ = CHR$(13) THEN PLAY "B16": CALL Test003
IF C = 2 THEN IF press$ = CHR$(13) THEN PLAY "B16": CALL Levelcode
IF C = 3 THEN IF press$ = CHR$(13) THEN PLAY "B16": CALL Credits
IF press$ = CHR$(0) + ";" THEN CALL Help
LOOP UNTIL press$ = CHR$(27)
END

END SUB

SUB Menu4
CLS
SCREEN 13
COLOR 10
PRINT " RoboRaiders: >>Mission1>>"
LOCATE 20, 3: PRINT "Press 'Enter' to select"
LOCATE 22, 2: PRINT "Press 'F1' for Help, Press 'Esc' to Exit"
C = 1
DO
press$ = INKEY$
IF C = 1 THEN LOCATE 10, 15: COLOR 10: PRINT ">>START>>": LOCATE 11, 15: COLOR 15: PRINT ">>LEVELCODE<<": LOCATE 13, 15: COLOR 15: PRINT ">>CREDITS<<"
IF C = 2 THEN LOCATE 10, 15: COLOR 15: PRINT ">>START<<": LOCATE 11, 15: COLOR 9: PRINT ">>LEVELCODE>>": LOCATE 13, 15: COLOR 15: PRINT ">>CREDITS<<"
IF C = 3 THEN LOCATE 10, 15: COLOR 15: PRINT ">>START<<": LOCATE 11, 15: COLOR 15: PRINT ">>LEVELCODE<<": LOCATE 13, 15: COLOR 14: PRINT ">>CREDITS>>"
IF C = 2 THEN IF press$ = CHR$(0) + CHR$(80) THEN C = 3: PLAY "D16"
IF C = 1 THEN IF press$ = CHR$(0) + CHR$(80) THEN C = 2: PLAY "D16"
IF C = 2 THEN IF press$ = CHR$(0) + CHR$(72) THEN C = 1: PLAY "D16"
IF C = 3 THEN IF press$ = CHR$(0) + CHR$(72) THEN C = 2: PLAY "D16"
IF C = 2 THEN IF press$ = "2" THEN C = 3: PLAY "D16"
IF C = 1 THEN IF press$ = "2" THEN C = 2: PLAY "D16"
IF C = 2 THEN IF press$ = "8" THEN C = 1: PLAY "D16"
IF C = 3 THEN IF press$ = "8" THEN C = 2: PLAY "D16"
IF C = 1 THEN IF press$ = CHR$(13) THEN PLAY "B16": CALL Mission01
IF C = 2 THEN IF press$ = CHR$(13) THEN PLAY "B16": CALL Levelcode
IF C = 3 THEN IF press$ = CHR$(13) THEN PLAY "B16": CALL Credits
IF press$ = CHR$(0) + ";" THEN CALL Help
LOOP UNTIL press$ = CHR$(27)
END

END SUB

SUB Menu5
CLS
SCREEN 13
COLOR 10
PRINT " RoboRaiders: >>Mission2>>"
LOCATE 20, 3: PRINT "Press 'Enter' to select"
LOCATE 22, 2: PRINT "Press 'F1' for Help, Press 'Esc' to Exit"
C = 1
DO
press$ = INKEY$
IF C = 1 THEN LOCATE 10, 15: COLOR 10: PRINT ">>START>>": LOCATE 11, 15: COLOR 15: PRINT ">>LEVELCODE<<": LOCATE 13, 15: COLOR 15: PRINT ">>CREDITS<<"
IF C = 2 THEN LOCATE 10, 15: COLOR 15: PRINT ">>START<<": LOCATE 11, 15: COLOR 9: PRINT ">>LEVELCODE>>": LOCATE 13, 15: COLOR 15: PRINT ">>CREDITS<<"
IF C = 3 THEN LOCATE 10, 15: COLOR 15: PRINT ">>START<<": LOCATE 11, 15: COLOR 15: PRINT ">>LEVELCODE<<": LOCATE 13, 15: COLOR 14: PRINT ">>CREDITS>>"
IF C = 2 THEN IF press$ = CHR$(0) + CHR$(80) THEN C = 3: PLAY "D16"
IF C = 1 THEN IF press$ = CHR$(0) + CHR$(80) THEN C = 2: PLAY "D16"
IF C = 2 THEN IF press$ = CHR$(0) + CHR$(72) THEN C = 1: PLAY "D16"
IF C = 3 THEN IF press$ = CHR$(0) + CHR$(72) THEN C = 2: PLAY "D16"
IF C = 2 THEN IF press$ = "2" THEN C = 3: PLAY "D16"
IF C = 1 THEN IF press$ = "2" THEN C = 2: PLAY "D16"
IF C = 2 THEN IF press$ = "8" THEN C = 1: PLAY "D16"
IF C = 3 THEN IF press$ = "8" THEN C = 2: PLAY "D16"
IF C = 1 THEN IF press$ = CHR$(13) THEN PLAY "B16": CALL Mission02
IF C = 2 THEN IF press$ = CHR$(13) THEN PLAY "B16": CALL Levelcode
IF C = 3 THEN IF press$ = CHR$(13) THEN PLAY "B16": CALL Credits
IF press$ = CHR$(0) + ";" THEN CALL Help
LOOP UNTIL press$ = CHR$(27)
END

END SUB

SUB Menu6
CLS
SCREEN 13
COLOR 10
PRINT " RoboRaiders: >>Mission3>>"
LOCATE 20, 3: PRINT "Press 'Enter' to select"
LOCATE 22, 2: PRINT "Press 'F1' for Help, Press 'Esc' to Exit"
C = 1
DO
press$ = INKEY$
IF C = 1 THEN LOCATE 10, 15: COLOR 10: PRINT ">>START>>": LOCATE 11, 15: COLOR 15: PRINT ">>LEVELCODE<<": LOCATE 13, 15: COLOR 15: PRINT ">>CREDITS<<"
IF C = 2 THEN LOCATE 10, 15: COLOR 15: PRINT ">>START<<": LOCATE 11, 15: COLOR 9: PRINT ">>LEVELCODE>>": LOCATE 13, 15: COLOR 15: PRINT ">>CREDITS<<"
IF C = 3 THEN LOCATE 10, 15: COLOR 15: PRINT ">>START<<": LOCATE 11, 15: COLOR 15: PRINT ">>LEVELCODE<<": LOCATE 13, 15: COLOR 14: PRINT ">>CREDITS>>"
IF C = 2 THEN IF press$ = CHR$(0) + CHR$(80) THEN C = 3: PLAY "D16"
IF C = 1 THEN IF press$ = CHR$(0) + CHR$(80) THEN C = 2: PLAY "D16"
IF C = 2 THEN IF press$ = CHR$(0) + CHR$(72) THEN C = 1: PLAY "D16"
IF C = 3 THEN IF press$ = CHR$(0) + CHR$(72) THEN C = 2: PLAY "D16"
IF C = 2 THEN IF press$ = "2" THEN C = 3: PLAY "D16"
IF C = 1 THEN IF press$ = "2" THEN C = 2: PLAY "D16"
IF C = 2 THEN IF press$ = "8" THEN C = 1: PLAY "D16"
IF C = 3 THEN IF press$ = "8" THEN C = 2: PLAY "D16"
IF C = 1 THEN IF press$ = CHR$(13) THEN PLAY "B16": CALL Mbrief01
IF C = 2 THEN IF press$ = CHR$(13) THEN PLAY "B16": CALL Levelcode
IF C = 3 THEN IF press$ = CHR$(13) THEN PLAY "B16": CALL Credits
IF press$ = CHR$(0) + ";" THEN CALL Help
LOOP UNTIL press$ = CHR$(27)
END

END SUB

SUB Menu7
CLS
SCREEN 13
COLOR 10
PRINT " RoboRaiders: >>Mission4>>"
LOCATE 20, 3: PRINT "Press 'Enter' to select"
LOCATE 22, 2: PRINT "Press 'F1' for Help, Press 'Esc' to Exit"
C = 1
DO
press$ = INKEY$
IF C = 1 THEN LOCATE 10, 15: COLOR 10: PRINT ">>START>>": LOCATE 11, 15: COLOR 15: PRINT ">>LEVELCODE<<": LOCATE 13, 15: COLOR 15: PRINT ">>CREDITS<<"
IF C = 2 THEN LOCATE 10, 15: COLOR 15: PRINT ">>START<<": LOCATE 11, 15: COLOR 9: PRINT ">>LEVELCODE>>": LOCATE 13, 15: COLOR 15: PRINT ">>CREDITS<<"
IF C = 3 THEN LOCATE 10, 15: COLOR 15: PRINT ">>START<<": LOCATE 11, 15: COLOR 15: PRINT ">>LEVELCODE<<": LOCATE 13, 15: COLOR 14: PRINT ">>CREDITS>>"
IF C = 2 THEN IF press$ = CHR$(0) + CHR$(80) THEN C = 3: PLAY "D16"
IF C = 1 THEN IF press$ = CHR$(0) + CHR$(80) THEN C = 2: PLAY "D16"
IF C = 2 THEN IF press$ = CHR$(0) + CHR$(72) THEN C = 1: PLAY "D16"
IF C = 3 THEN IF press$ = CHR$(0) + CHR$(72) THEN C = 2: PLAY "D16"
IF C = 2 THEN IF press$ = "2" THEN C = 3: PLAY "D16"
IF C = 1 THEN IF press$ = "2" THEN C = 2: PLAY "D16"
IF C = 2 THEN IF press$ = "8" THEN C = 1: PLAY "D16"
IF C = 3 THEN IF press$ = "8" THEN C = 2: PLAY "D16"
IF C = 1 THEN IF press$ = CHR$(13) THEN PLAY "B16": CALL Mission04
IF C = 2 THEN IF press$ = CHR$(13) THEN PLAY "B16": CALL Levelcode
IF C = 3 THEN IF press$ = CHR$(13) THEN PLAY "B16": CALL Credits
IF press$ = CHR$(0) + ";" THEN CALL Help
LOOP UNTIL press$ = CHR$(27)
END


END SUB

SUB Menu8
CLS
SCREEN 13
COLOR 10
PRINT " RoboRaiders: >>Mission5>>"
LOCATE 20, 3: PRINT "Press 'Enter' to select"
LOCATE 22, 2: PRINT "Press 'F1' for Help, Press 'Esc' to Exit"
C = 1
DO
press$ = INKEY$
IF C = 1 THEN LOCATE 10, 15: COLOR 10: PRINT ">>START>>": LOCATE 11, 15: COLOR 15: PRINT ">>LEVELCODE<<": LOCATE 13, 15: COLOR 15: PRINT ">>CREDITS<<"
IF C = 2 THEN LOCATE 10, 15: COLOR 15: PRINT ">>START<<": LOCATE 11, 15: COLOR 9: PRINT ">>LEVELCODE>>": LOCATE 13, 15: COLOR 15: PRINT ">>CREDITS<<"
IF C = 3 THEN LOCATE 10, 15: COLOR 15: PRINT ">>START<<": LOCATE 11, 15: COLOR 15: PRINT ">>LEVELCODE<<": LOCATE 13, 15: COLOR 14: PRINT ">>CREDITS>>"
IF C = 2 THEN IF press$ = CHR$(0) + CHR$(80) THEN C = 3: PLAY "D16"
IF C = 1 THEN IF press$ = CHR$(0) + CHR$(80) THEN C = 2: PLAY "D16"
IF C = 2 THEN IF press$ = CHR$(0) + CHR$(72) THEN C = 1: PLAY "D16"
IF C = 3 THEN IF press$ = CHR$(0) + CHR$(72) THEN C = 2: PLAY "D16"
IF C = 2 THEN IF press$ = "2" THEN C = 3: PLAY "D16"
IF C = 1 THEN IF press$ = "2" THEN C = 2: PLAY "D16"
IF C = 2 THEN IF press$ = "8" THEN C = 1: PLAY "D16"
IF C = 3 THEN IF press$ = "8" THEN C = 2: PLAY "D16"
IF C = 1 THEN IF press$ = CHR$(13) THEN PLAY "B16": CALL Mission05
IF C = 2 THEN IF press$ = CHR$(13) THEN PLAY "B16": CALL Levelcode
IF C = 3 THEN IF press$ = CHR$(13) THEN PLAY "B16": CALL Credits
IF press$ = CHR$(0) + ";" THEN CALL Help
LOOP UNTIL press$ = CHR$(27)
END

END SUB

SUB Menu9
CLS
SCREEN 13
COLOR 10
PRINT " RoboRaiders: >>Mission6>>"
LOCATE 20, 3: PRINT "Press 'Enter' to select"
LOCATE 22, 2: PRINT "Press 'F1' for Help, Press 'Esc' to Exit"
C = 1
DO
press$ = INKEY$
IF C = 1 THEN LOCATE 10, 15: COLOR 10: PRINT ">>START>>": LOCATE 11, 15: COLOR 15: PRINT ">>LEVELCODE<<": LOCATE 13, 15: COLOR 15: PRINT ">>CREDITS<<"
IF C = 2 THEN LOCATE 10, 15: COLOR 15: PRINT ">>START<<": LOCATE 11, 15: COLOR 9: PRINT ">>LEVELCODE>>": LOCATE 13, 15: COLOR 15: PRINT ">>CREDITS<<"
IF C = 3 THEN LOCATE 10, 15: COLOR 15: PRINT ">>START<<": LOCATE 11, 15: COLOR 15: PRINT ">>LEVELCODE<<": LOCATE 13, 15: COLOR 14: PRINT ">>CREDITS>>"
IF C = 2 THEN IF press$ = CHR$(0) + CHR$(80) THEN C = 3: PLAY "D16"
IF C = 1 THEN IF press$ = CHR$(0) + CHR$(80) THEN C = 2: PLAY "D16"
IF C = 2 THEN IF press$ = CHR$(0) + CHR$(72) THEN C = 1: PLAY "D16"
IF C = 3 THEN IF press$ = CHR$(0) + CHR$(72) THEN C = 2: PLAY "D16"
IF C = 2 THEN IF press$ = "2" THEN C = 3: PLAY "D16"
IF C = 1 THEN IF press$ = "2" THEN C = 2: PLAY "D16"
IF C = 2 THEN IF press$ = "8" THEN C = 1: PLAY "D16"
IF C = 3 THEN IF press$ = "8" THEN C = 2: PLAY "D16"
IF C = 1 THEN IF press$ = CHR$(13) THEN PLAY "B16": CALL Mission06
IF C = 2 THEN IF press$ = CHR$(13) THEN PLAY "B16": CALL Levelcode
IF C = 3 THEN IF press$ = CHR$(13) THEN PLAY "B16": CALL Credits
IF press$ = CHR$(0) + ";" THEN CALL Help
LOOP UNTIL press$ = CHR$(27)
END

END SUB

SUB Mission01
CLS
SCREEN 7, 0, 1, 0
DIM sch1(100), sch2(100), scv1(100), scv2(100), mask(100)
PLAY "MB L64 <<<"
COLOR 15
PRINT " Mission Status:"
PRINT
PRINT "      Mission 1: There has been"
PRINT " a recent discovery in a pyramid"
PRINT " over in Egypt of a small passage."
PRINT " It's to small for humans, but one"
PRINT " of my finest robots 'Scorpian' "
PRINT " can make the trip. My scans show"
PRINT " a object at the end of the shaft,"
PRINT " and something else beyond it. "
PRINT " What ever that is you must find "
PRINT " out, good luck."
PRINT
PRINT
PRINT
COLOR 10
PRINT " Press SPACEBAR to continue..."
PCOPY 1, 0
DO
press$ = INKEY$
LOOP UNTIL press$ = " "

CLS
'############# ROBOT ##########
LINE (1, 1)-(2, 10), 8, BF
LINE (10, 1)-(9, 10), 8, BF
LINE (3, 2)-(8, 9), 14, BF
LINE (5, 1)-(6, 7), 12, BF
LINE (5, 5)-(6, 8), 4, BF
PCOPY 1, 0
GET (1, 1)-(10, 10), sch1
CLS
LINE (1, 1)-(2, 10), 8, BF
LINE (10, 1)-(9, 10), 8, BF
LINE (3, 2)-(8, 9), 14, BF
LINE (5, 3)-(6, 10), 12, BF
LINE (5, 7)-(6, 10), 4, BF
PCOPY 1, 0
GET (1, 1)-(10, 10), sch2
CLS
LINE (1, 1)-(10, 2), 8, BF
LINE (1, 10)-(10, 9), 8, BF
LINE (2, 3)-(9, 8), 14, BF
LINE (1, 5)-(7, 6), 12, BF
LINE (5, 5)-(8, 6), 4, BF
GET (1, 1)-(10, 10), scv1
PCOPY 1, 0
CLS
LINE (1, 1)-(10, 2), 8, BF
LINE (1, 10)-(10, 9), 8, BF
LINE (2, 3)-(9, 8), 14, BF
LINE (3, 5)-(10, 6), 12, BF
LINE (7, 5)-(10, 6), 4, BF
GET (1, 1)-(10, 10), scv2
PCOPY 1, 0
CLS
GET (1, 1)-(10, 10), mask
'######## LEVEL ########
LINE (150, 200)-(150, 50), 12
LINE (170, 200)-(170, 50), 12
LINE (150, 50)-(170, 50), 12
CIRCLE (160, 60), 2, 9: PAINT (160, 60), 9
PCOPY 1, 0
'######## Level INTRO ####
x = 155: y = 180
stat$ = "Hmm, Scorpian's video feed shows a      smaller shaft than my scans did. Never   mind that, get that item."
PUT (x, y), sch1, PSET
DO
press$ = INKEY$
LOCATE 1, 1: PRINT stat$
PCOPY 1, 0
LOOP WHILE press$ = ""
CLS
stat$ = "Collect Item:"
'######## LEVEL ########
LINE (150, 200)-(150, 50), 12
LINE (170, 200)-(170, 50), 12
LINE (150, 50)-(170, 50), 12
PCOPY 1, 0
d = 1
DO
press$ = INKEY$
LOCATE 1, 1: PRINT stat$
'######## Item Code #######
IF i = 0 THEN CIRCLE (160, 60), 2, 9: PAINT (160, 60), 9 ELSE CIRCLE (160, 60), 2, 0: PAINT (160, 60), 0
IF i = 1 THEN LINE (120, 50)-(200, 10), 12, B: PUT (155, 46), mask, PSET: CIRCLE (160, 23), 10, 1: PAINT (160, 23), 1: CIRCLE (160, 23), 10, 7: stat$ = "Do not enter, there's a trip line on the door!"
IF y = 62 THEN IF x = 155 OR x = 156 THEN i = 1
'######## Graphics Code #######
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), sch1, PSET
IF d = 2 THEN PUT (x, y), scv1, PSET
IF d = 3 THEN PUT (x, y), sch2, PSET
IF d = 4 THEN PUT (x, y), scv2, PSET
IF press$ = CHR$(0) + CHR$(75) THEN d = 2
IF press$ = CHR$(0) + CHR$(72) THEN d = 1
IF press$ = CHR$(0) + CHR$(77) THEN d = 4
IF press$ = CHR$(0) + CHR$(80) THEN d = 3
IF press$ = CHR$(0) + CHR$(72) THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(80) THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(75) THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(77) THEN x = x + 1: PLAY "A"
IF press$ = "4" THEN d = 2
IF press$ = "8" THEN d = 1
IF press$ = "2" THEN d = 3
IF press$ = "6" THEN d = 4
IF press$ = "8" THEN y = y - 1: PLAY "A"
IF press$ = "2" THEN y = y + 1: PLAY "A"
IF press$ = "4" THEN x = x - 1: PLAY "A"
IF press$ = "6" THEN x = x + 1: PLAY "A"
'####### Wall codes #######
IF x = 150 THEN GOTO mcrash1
IF x = 161 THEN GOTO mcrash1
IF y = 50 THEN GOTO mcrash1
IF i = 0 AND y = 188 THEN y = 187: stat$ = "Finish The Mission First!"
IF i = 0 AND y < 187 THEN stat$ = "Collect Item:                     "
IF i = 1 AND y = 188 THEN GOTO mfinish1
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END

mfinish1: CLS
COLOR 10
PRINT " You completed your first mission!"
PRINT
PRINT " Now for the next one!"
PRINT
COLOR 9
PRINT
PRINT " This level's code is: POINTY"
PRINT " Next level's code is: INDEEP"
PRINT
PRINT " Press SPACEBAR to continue..."
PCOPY 1, 0
DO
press$ = INKEY$
LOOP UNTIL press$ = " "
CLS
SCREEN 13
CALL Menu5

mcrash1: CLS
COLOR 12
PRINT " You Crashed My Robot!"
PRINT
PRINT " Sorry, You are fired!"
PRINT
COLOR 9
PRINT
PRINT " This level's code is: POINTY"
PRINT " Next level's code is: >>did not pass<<"
PRINT
PRINT " Press SPACEBAR to continue..."
PCOPY 1, 0
DO
press$ = INKEY$
LOOP UNTIL press$ = " "
CLS
SCREEN 13
CALL Menu

END SUB

SUB Mission02
SCREEN 7, 0, 1, 0
DIM sch1(100), sch2(100), scv1(100), scv2(100), mask(100)
PLAY "MB L64 <<<"
COLOR 15
PRINT " Mission Status:"
PRINT
PRINT "      Mission 2: Your next mission"
PRINT " takes you to a cave with, you "
PRINT " guessed, a entrance to small for"
PRINT " humans. My scans show a maze of "
PRINT " paths leading to a object. You "
PRINT " will be using Scorpian again, it's"
PRINT " more tactical than the others."
PRINT " You must watch your battery life,"
PRINT " my bot has one of 30 minutes. But"
PRINT " be careful, I have towing bots,"
PRINT " made just for pulling back a "
PRINT " stranded robot. Just don't crash!"
COLOR 9
PRINT "  NOTE: If the robot stops, its a "
PRINT "        dead end, try a new direction"
PRINT
PRINT
COLOR 10
PRINT " Press SPACEBAR to continue..."
PCOPY 1, 0
DO
press$ = INKEY$
LOOP UNTIL press$ = " "
CLS
'############# ROBOT ##########
LINE (1, 1)-(2, 10), 8, BF
LINE (10, 1)-(9, 10), 8, BF
LINE (3, 2)-(8, 9), 14, BF
LINE (5, 1)-(6, 7), 12, BF
LINE (5, 5)-(6, 8), 4, BF
PCOPY 1, 0
GET (1, 1)-(10, 10), sch1
CLS
LINE (1, 1)-(2, 10), 8, BF
LINE (10, 1)-(9, 10), 8, BF
LINE (3, 2)-(8, 9), 14, BF
LINE (5, 3)-(6, 10), 12, BF
LINE (5, 7)-(6, 10), 4, BF
PCOPY 1, 0
GET (1, 1)-(10, 10), sch2
CLS
LINE (1, 1)-(10, 2), 8, BF
LINE (1, 10)-(10, 9), 8, BF
LINE (2, 3)-(9, 8), 14, BF
LINE (1, 5)-(7, 6), 12, BF
LINE (5, 5)-(8, 6), 4, BF
GET (1, 1)-(10, 10), scv1
PCOPY 1, 0
CLS
LINE (1, 1)-(10, 2), 8, BF
LINE (1, 10)-(10, 9), 8, BF
LINE (2, 3)-(9, 8), 14, BF
LINE (3, 5)-(10, 6), 12, BF
LINE (7, 5)-(10, 6), 4, BF
GET (1, 1)-(10, 10), scv2
PCOPY 1, 0
CLS
GET (1, 1)-(10, 10), mask

m2seg1: CLS '                  >>>SEGMENT #01<<<<
'######### LEVEL ########
LINE (150, 200)-(150, 100), 2
LINE (170, 200)-(170, 100), 2
LINE (0, 100)-(150, 100), 2
LINE (320, 100)-(170, 100), 2
LINE (0, 80)-(320, 80), 2
PCOPY 1, 0
'######### PROGRAM ######
IF segm = 0 THEN x = 155: y = 180: d = 1
IF segm = 1 THEN x = 299: d = 2
btt$ = "Batt: [||||||||||]": C = 10
IF i = 0 THEN stat$ = "Collect Item:"
IF i = 1 THEN stat$ = "Exit Cave:Got Item"
DO
press$ = INKEY$
LOCATE 1, 1: COLOR C: PRINT btt$
LOCATE 2, 1: COLOR 9: PRINT stat$
'######## Graphics Code #######
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), sch1, PSET
IF d = 2 THEN PUT (x, y), scv1, PSET
IF d = 3 THEN PUT (x, y), sch2, PSET
IF d = 4 THEN PUT (x, y), scv2, PSET
IF press$ = CHR$(0) + CHR$(75) THEN d = 2
IF press$ = CHR$(0) + CHR$(72) THEN d = 1
IF press$ = CHR$(0) + CHR$(77) THEN d = 4
IF press$ = CHR$(0) + CHR$(80) THEN d = 3
IF press$ = CHR$(0) + CHR$(72) THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(80) THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(75) THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(77) THEN x = x + 1: PLAY "A"
IF press$ = "4" THEN d = 2
IF press$ = "8" THEN d = 1
IF press$ = "2" THEN d = 3
IF press$ = "6" THEN d = 4
IF press$ = "8" THEN y = y - 1: PLAY "A"
IF press$ = "2" THEN y = y + 1: PLAY "A"
IF press$ = "4" THEN x = x - 1: PLAY "A"
IF press$ = "6" THEN x = x + 1: PLAY "A"
'########### BATTERY CODE ############
btt = btt + 1
IF (btt / 100) > 1800 THEN GOTO dbtt
IF y < 189 AND (btt / 100) THEN btt$ = "Batt: [||||||||||]"
IF (btt / 100) > 180 THEN btt$ = "Batt: [||||||||| ]": C = 10
IF (btt / 100) > 360 THEN btt$ = "Batt: [||||||||  ]": C = 10
IF (btt / 100) > 540 THEN btt$ = "Batt: [|||||||   ]": C = 10
IF (btt / 100) > 720 THEN btt$ = "Batt: [||||||    ]": C = 14
IF (btt / 100) > 900 THEN btt$ = "Batt: [|||||     ]": C = 14
IF (btt / 100) > 1080 THEN btt$ = "Batt: [||||      ]": C = 14
IF (btt / 100) > 1260 THEN btt$ = "Batt: [|||       ]": C = 12
IF (btt / 100) > 1440 THEN btt$ = "Batt: [||        ]": C = 12
IF (btt / 100) > 1620 THEN btt$ = "Batt: [|         ]": C = 12
'########## BARRIER CODES #######
IF x < 151 AND y > 90 THEN GOTO mcrash2
IF x > 160 AND y > 90 THEN GOTO mcrash2
IF y = 80 THEN GOTO mcrash2
IF x = 10 THEN x = 11
'########## DOOR CODES ###########
IF i = 0 THEN IF y < 189 THEN stat$ = "Collect Item:"
IF i = 0 THEN IF y = 190 THEN y = 189: stat$ = "Not Finished "
IF i = 1 THEN IF y = 190 THEN GOTO mfinish2
IF x = 305 THEN segm = 0: GOTO m2seg2
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END

m2seg2: CLS '                     >>>SEGMENT #02<<<
'######### LEVEL ########
LINE (150, 0)-(150, 80), 2
LINE (170, 0)-(170, 80), 2
LINE (0, 80)-(150, 80), 2
LINE (320, 80)-(170, 80), 2
LINE (0, 100)-(320, 100), 2
PCOPY 1, 0
'######### PROGRAM ######
IF segm = 0 THEN x = 10: d = 4
IF segm = 1 THEN y = 10: d = 3
IF i = 0 THEN stat$ = "Collect Item:"
IF i = 1 THEN stat$ = "Exit Cave:Got Item"
DO
press$ = INKEY$
LOCATE 1, 1: COLOR C: PRINT btt$
LOCATE 2, 1: COLOR 9: PRINT stat$
'######## Graphics Code #######
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), sch1, PSET
IF d = 2 THEN PUT (x, y), scv1, PSET
IF d = 3 THEN PUT (x, y), sch2, PSET
IF d = 4 THEN PUT (x, y), scv2, PSET
IF press$ = CHR$(0) + CHR$(75) THEN d = 2
IF press$ = CHR$(0) + CHR$(72) THEN d = 1
IF press$ = CHR$(0) + CHR$(77) THEN d = 4
IF press$ = CHR$(0) + CHR$(80) THEN d = 3
IF press$ = CHR$(0) + CHR$(72) THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(80) THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(75) THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(77) THEN x = x + 1: PLAY "A"
IF press$ = "4" THEN d = 2
IF press$ = "8" THEN d = 1
IF press$ = "2" THEN d = 3
IF press$ = "6" THEN d = 4
IF press$ = "8" THEN y = y - 1: PLAY "A"
IF press$ = "2" THEN y = y + 1: PLAY "A"
IF press$ = "4" THEN x = x - 1: PLAY "A"
IF press$ = "6" THEN x = x + 1: PLAY "A"
'########### BATTERY CODE ############
btt = btt + 1
IF (btt / 100) > 1800 THEN GOTO dbtt
IF (btt / 100) > 180 THEN btt$ = "Batt: [||||||||| ]": C = 10
IF (btt / 100) > 360 THEN btt$ = "Batt: [||||||||  ]": C = 10
IF (btt / 100) > 540 THEN btt$ = "Batt: [|||||||   ]": C = 10
IF (btt / 100) > 720 THEN btt$ = "Batt: [||||||    ]": C = 14
IF (btt / 100) > 900 THEN btt$ = "Batt: [|||||     ]": C = 14
IF (btt / 100) > 1080 THEN btt$ = "Batt: [||||      ]": C = 14
IF (btt / 100) > 1260 THEN btt$ = "Batt: [|||       ]": C = 12
IF (btt / 100) > 1440 THEN btt$ = "Batt: [||        ]": C = 12
IF (btt / 100) > 1620 THEN btt$ = "Batt: [|         ]": C = 12
'########## BARRIER CODES #######
IF x < 151 AND y < 81 THEN GOTO mcrash2
IF x > 160 AND y < 81 THEN GOTO mcrash2
IF y = 91 THEN GOTO mcrash2
IF x = 300 THEN x = 299
'########## DOOR CODES ########
IF x = 5 THEN segm = 1: GOTO m2seg1
IF y = 5 THEN segm = 0: GOTO m2seg3
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END

m2seg3: CLS '                     >>>SEGMENT #03<<<
'######### LEVEL ########
LINE (150, 0)-(150, 80), 2
LINE (170, 0)-(170, 80), 2
LINE (0, 80)-(150, 80), 2
LINE (320, 80)-(170, 80), 2
LINE (150, 200)-(150, 100), 2
LINE (170, 200)-(170, 100), 2
LINE (0, 100)-(150, 100), 2
LINE (320, 100)-(170, 100), 2
PCOPY 1, 0
'######### PROGRAM ######
IF segm = 0 THEN y = 180: d = 1
IF segm = 1 THEN x = 299: d = 2
IF segm = 2 THEN y = 10
IF i = 0 THEN stat$ = "Collect Item:"
IF i = 1 THEN stat$ = "Exit Cave:Got Item"
DO
press$ = INKEY$
LOCATE 1, 1: COLOR C: PRINT btt$
LOCATE 2, 1: COLOR 9: PRINT stat$
'######## Graphics Code #######
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), sch1, PSET
IF d = 2 THEN PUT (x, y), scv1, PSET
IF d = 3 THEN PUT (x, y), sch2, PSET
IF d = 4 THEN PUT (x, y), scv2, PSET
IF press$ = CHR$(0) + CHR$(75) THEN d = 2
IF press$ = CHR$(0) + CHR$(72) THEN d = 1
IF press$ = CHR$(0) + CHR$(77) THEN d = 4
IF press$ = CHR$(0) + CHR$(80) THEN d = 3
IF press$ = CHR$(0) + CHR$(72) THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(80) THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(75) THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(77) THEN x = x + 1: PLAY "A"
IF press$ = "4" THEN d = 2
IF press$ = "8" THEN d = 1
IF press$ = "2" THEN d = 3
IF press$ = "6" THEN d = 4
IF press$ = "8" THEN y = y - 1: PLAY "A"
IF press$ = "2" THEN y = y + 1: PLAY "A"
IF press$ = "4" THEN x = x - 1: PLAY "A"
IF press$ = "6" THEN x = x + 1: PLAY "A"
'########### BATTERY CODE ############
btt = btt + 1
IF (btt / 100) > 1800 THEN GOTO dbtt
IF (btt / 100) > 180 THEN btt$ = "Batt: [||||||||| ]": C = 10
IF (btt / 100) > 360 THEN btt$ = "Batt: [||||||||  ]": C = 10
IF (btt / 100) > 540 THEN btt$ = "Batt: [|||||||   ]": C = 10
IF (btt / 100) > 720 THEN btt$ = "Batt: [||||||    ]": C = 14
IF (btt / 100) > 900 THEN btt$ = "Batt: [|||||     ]": C = 14
IF (btt / 100) > 1080 THEN btt$ = "Batt: [||||      ]": C = 14
IF (btt / 100) > 1260 THEN btt$ = "Batt: [|||       ]": C = 12
IF (btt / 100) > 1440 THEN btt$ = "Batt: [||        ]": C = 12
IF (btt / 100) > 1620 THEN btt$ = "Batt: [|         ]": C = 12
'########## BARRIER CODES #######
IF x < 151 AND y < 81 THEN GOTO mcrash2
IF x > 160 AND y < 81 THEN GOTO mcrash2
IF x < 151 AND y > 90 THEN GOTO mcrash2
IF x > 160 AND y > 90 THEN GOTO mcrash2
IF x = 10 THEN x = 11
'########## DOOR CODES ##########
IF y = 185 THEN segm = 1: GOTO m2seg2
IF x = 305 THEN segm = 0: GOTO m2seg4
IF y = 5 THEN segm = 0: GOTO m2seg15
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END

m2seg4: CLS '                   >>> SEGMENT04 <<<
'######### LEVEL #############
LINE (0, 80)-(320, 80), 2
LINE (0, 100)-(320, 100), 2
PCOPY 1, 0
'######### PROGRAM ######
IF segm = 0 THEN x = 10: d = 4
IF segm = 1 THEN x = 299: d = 2
IF i = 0 THEN stat$ = "Collect Item:"
IF i = 1 THEN stat$ = "Exit Cave:Got Item"
DO
press$ = INKEY$
LOCATE 1, 1: COLOR C: PRINT btt$
LOCATE 2, 1: COLOR 9: PRINT stat$
'######## Graphics Code #######
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), sch1, PSET
IF d = 2 THEN PUT (x, y), scv1, PSET
IF d = 3 THEN PUT (x, y), sch2, PSET
IF d = 4 THEN PUT (x, y), scv2, PSET
IF press$ = CHR$(0) + CHR$(75) THEN d = 2
IF press$ = CHR$(0) + CHR$(72) THEN d = 1
IF press$ = CHR$(0) + CHR$(77) THEN d = 4
IF press$ = CHR$(0) + CHR$(80) THEN d = 3
IF press$ = CHR$(0) + CHR$(72) THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(80) THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(75) THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(77) THEN x = x + 1: PLAY "A"
IF press$ = "4" THEN d = 2
IF press$ = "8" THEN d = 1
IF press$ = "2" THEN d = 3
IF press$ = "6" THEN d = 4
IF press$ = "8" THEN y = y - 1: PLAY "A"
IF press$ = "2" THEN y = y + 1: PLAY "A"
IF press$ = "4" THEN x = x - 1: PLAY "A"
IF press$ = "6" THEN x = x + 1: PLAY "A"
'########### BATTERY CODE ############
btt = btt + 1
IF (btt / 100) > 1800 THEN GOTO dbtt
IF (btt / 100) > 180 THEN btt$ = "Batt: [||||||||| ]": C = 10
IF (btt / 100) > 360 THEN btt$ = "Batt: [||||||||  ]": C = 10
IF (btt / 100) > 540 THEN btt$ = "Batt: [|||||||   ]": C = 10
IF (btt / 100) > 720 THEN btt$ = "Batt: [||||||    ]": C = 14
IF (btt / 100) > 900 THEN btt$ = "Batt: [|||||     ]": C = 14
IF (btt / 100) > 1080 THEN btt$ = "Batt: [||||      ]": C = 14
IF (btt / 100) > 1260 THEN btt$ = "Batt: [|||       ]": C = 12
IF (btt / 100) > 1440 THEN btt$ = "Batt: [||        ]": C = 12
IF (btt / 100) > 1620 THEN btt$ = "Batt: [|         ]": C = 12
'########## BARRIER CODES #######
IF y = 80 OR y = 91 THEN GOTO mcrash2
'########## DOOR CODES #######
IF x = 5 THEN segm = 1: GOTO m2seg3
IF x = 305 THEN segm = 0: GOTO m2seg5
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END

m2seg5: CLS '                   >>> SEGMENT #05 <<<
'######### LEVEL ########
LINE (150, 0)-(150, 80), 2
LINE (170, 0)-(170, 80), 2
LINE (0, 80)-(150, 80), 2
LINE (320, 80)-(170, 80), 2
LINE (150, 200)-(150, 100), 2
LINE (170, 200)-(170, 100), 2
LINE (0, 100)-(150, 100), 2
LINE (320, 100)-(170, 100), 2
PCOPY 1, 0
'######### PROGRAM ######
IF segm = 0 THEN x = 10
IF segm = 1 THEN y = 10
IF segm = 2 THEN y = 180
IF segm = 3 THEN x = 300
IF i = 0 THEN stat$ = "Collect Item:"
IF i = 1 THEN stat$ = "Exit Cave:Got Item"
DO
press$ = INKEY$
LOCATE 1, 1: COLOR C: PRINT btt$
LOCATE 2, 1: COLOR 9: PRINT stat$
'######## Graphics Code #######
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), sch1, PSET
IF d = 2 THEN PUT (x, y), scv1, PSET
IF d = 3 THEN PUT (x, y), sch2, PSET
IF d = 4 THEN PUT (x, y), scv2, PSET
IF press$ = CHR$(0) + CHR$(75) THEN d = 2
IF press$ = CHR$(0) + CHR$(72) THEN d = 1
IF press$ = CHR$(0) + CHR$(77) THEN d = 4
IF press$ = CHR$(0) + CHR$(80) THEN d = 3
IF press$ = CHR$(0) + CHR$(72) THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(80) THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(75) THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(77) THEN x = x + 1: PLAY "A"
IF press$ = "4" THEN d = 2
IF press$ = "8" THEN d = 1
IF press$ = "2" THEN d = 3
IF press$ = "6" THEN d = 4
IF press$ = "8" THEN y = y - 1: PLAY "A"
IF press$ = "2" THEN y = y + 1: PLAY "A"
IF press$ = "4" THEN x = x - 1: PLAY "A"
IF press$ = "6" THEN x = x + 1: PLAY "A"
'########### BATTERY CODE ############
btt = btt + 1
IF (btt / 100) > 1800 THEN GOTO dbtt
IF (btt / 100) > 180 THEN btt$ = "Batt: [||||||||| ]": C = 10
IF (btt / 100) > 360 THEN btt$ = "Batt: [||||||||  ]": C = 10
IF (btt / 100) > 540 THEN btt$ = "Batt: [|||||||   ]": C = 10
IF (btt / 100) > 720 THEN btt$ = "Batt: [||||||    ]": C = 14
IF (btt / 100) > 900 THEN btt$ = "Batt: [|||||     ]": C = 14
IF (btt / 100) > 1080 THEN btt$ = "Batt: [||||      ]": C = 14
IF (btt / 100) > 1260 THEN btt$ = "Batt: [|||       ]": C = 12
IF (btt / 100) > 1440 THEN btt$ = "Batt: [||        ]": C = 12
IF (btt / 100) > 1620 THEN btt$ = "Batt: [|         ]": C = 12
'########## BARRIER CODES #######
IF x < 151 AND y < 81 THEN GOTO mcrash2
IF x > 160 AND y < 81 THEN GOTO mcrash2
IF x < 151 AND y > 90 THEN GOTO mcrash2
IF x > 160 AND y > 90 THEN GOTO mcrash2
'########## DOOR CODES ##########
IF x = 5 THEN segm = 1: GOTO m2seg4
IF y = 5 THEN segm = 0: GOTO m2seg17
IF x = 305 THEN segm = 1: GOTO m2seg14
IF y = 185 THEN segm = 0: GOTO m2seg6
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END

m2seg6: CLS '                   >>> SEGMENT #06 <<<
'######### LEVEL ########
LINE (150, 0)-(150, 80), 2
LINE (170, 0)-(170, 80), 2
LINE (0, 80)-(150, 80), 2
LINE (320, 80)-(170, 80), 2
LINE (150, 200)-(150, 100), 2
LINE (170, 200)-(170, 100), 2
LINE (0, 100)-(150, 100), 2
LINE (320, 100)-(170, 100), 2
PCOPY 1, 0
'######### PROGRAM ######
IF segm = 0 THEN y = 10
IF segm = 1 THEN x = 10
IF segm = 2 THEN x = 300
IF i = 0 THEN stat$ = "Collect Item:"
IF i = 1 THEN stat$ = "Exit Cave:Got Item"
DO
press$ = INKEY$
LOCATE 1, 1: COLOR C: PRINT btt$
LOCATE 2, 1: COLOR 9: PRINT stat$
'######## Graphics Code #######
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), sch1, PSET
IF d = 2 THEN PUT (x, y), scv1, PSET
IF d = 3 THEN PUT (x, y), sch2, PSET
IF d = 4 THEN PUT (x, y), scv2, PSET
IF press$ = CHR$(0) + CHR$(75) THEN d = 2
IF press$ = CHR$(0) + CHR$(72) THEN d = 1
IF press$ = CHR$(0) + CHR$(77) THEN d = 4
IF press$ = CHR$(0) + CHR$(80) THEN d = 3
IF press$ = CHR$(0) + CHR$(72) THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(80) THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(75) THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(77) THEN x = x + 1: PLAY "A"
IF press$ = "4" THEN d = 2
IF press$ = "8" THEN d = 1
IF press$ = "2" THEN d = 3
IF press$ = "6" THEN d = 4
IF press$ = "8" THEN y = y - 1: PLAY "A"
IF press$ = "2" THEN y = y + 1: PLAY "A"
IF press$ = "4" THEN x = x - 1: PLAY "A"
IF press$ = "6" THEN x = x + 1: PLAY "A"
'########### BATTERY CODE ############
btt = btt + 1
IF (btt / 100) > 1800 THEN GOTO dbtt
IF (btt / 100) > 180 THEN btt$ = "Batt: [||||||||| ]": C = 10
IF (btt / 100) > 360 THEN btt$ = "Batt: [||||||||  ]": C = 10
IF (btt / 100) > 540 THEN btt$ = "Batt: [|||||||   ]": C = 10
IF (btt / 100) > 720 THEN btt$ = "Batt: [||||||    ]": C = 14
IF (btt / 100) > 900 THEN btt$ = "Batt: [|||||     ]": C = 14
IF (btt / 100) > 1080 THEN btt$ = "Batt: [||||      ]": C = 14
IF (btt / 100) > 1260 THEN btt$ = "Batt: [|||       ]": C = 12
IF (btt / 100) > 1440 THEN btt$ = "Batt: [||        ]": C = 12
IF (btt / 100) > 1620 THEN btt$ = "Batt: [|         ]": C = 12
'########## BARRIER CODES #######
IF x < 151 AND y < 81 THEN GOTO mcrash2
IF x > 160 AND y < 81 THEN GOTO mcrash2
IF x < 151 AND y > 90 THEN GOTO mcrash2
IF x > 160 AND y > 90 THEN GOTO mcrash2
'########## DOOR CODES ##########
IF x = 5 THEN segm = 0: GOTO m2seg16
IF y = 5 THEN segm = 2: GOTO m2seg5
IF x = 305 THEN segm = 0: GOTO m2seg7
IF y = 185 THEN y = 184
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END

m2seg7: CLS '                   >>> SEGMENT #07 <<<
'######### LEVEL #############
LINE (0, 80)-(320, 80), 2
LINE (0, 100)-(320, 100), 2
PCOPY 1, 0
'######### PROGRAM ######
IF segm = 0 THEN x = 10: d = 4
IF segm = 1 THEN x = 299: d = 2
IF i = 0 THEN stat$ = "Collect Item:"
IF i = 1 THEN stat$ = "Exit Cave:Got Item"
DO
press$ = INKEY$
LOCATE 1, 1: COLOR C: PRINT btt$
LOCATE 2, 1: COLOR 9: PRINT stat$
'######## Graphics Code #######
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), sch1, PSET
IF d = 2 THEN PUT (x, y), scv1, PSET
IF d = 3 THEN PUT (x, y), sch2, PSET
IF d = 4 THEN PUT (x, y), scv2, PSET
IF press$ = CHR$(0) + CHR$(75) THEN d = 2
IF press$ = CHR$(0) + CHR$(72) THEN d = 1
IF press$ = CHR$(0) + CHR$(77) THEN d = 4
IF press$ = CHR$(0) + CHR$(80) THEN d = 3
IF press$ = CHR$(0) + CHR$(72) THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(80) THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(75) THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(77) THEN x = x + 1: PLAY "A"
IF press$ = "4" THEN d = 2
IF press$ = "8" THEN d = 1
IF press$ = "2" THEN d = 3
IF press$ = "6" THEN d = 4
IF press$ = "8" THEN y = y - 1: PLAY "A"
IF press$ = "2" THEN y = y + 1: PLAY "A"
IF press$ = "4" THEN x = x - 1: PLAY "A"
IF press$ = "6" THEN x = x + 1: PLAY "A"
'########### BATTERY CODE ############
btt = btt + 1
IF (btt / 100) > 1800 THEN GOTO dbtt
IF (btt / 100) > 180 THEN btt$ = "Batt: [||||||||| ]": C = 10
IF (btt / 100) > 360 THEN btt$ = "Batt: [||||||||  ]": C = 10
IF (btt / 100) > 540 THEN btt$ = "Batt: [|||||||   ]": C = 10
IF (btt / 100) > 720 THEN btt$ = "Batt: [||||||    ]": C = 14
IF (btt / 100) > 900 THEN btt$ = "Batt: [|||||     ]": C = 14
IF (btt / 100) > 1080 THEN btt$ = "Batt: [||||      ]": C = 14
IF (btt / 100) > 1260 THEN btt$ = "Batt: [|||       ]": C = 12
IF (btt / 100) > 1440 THEN btt$ = "Batt: [||        ]": C = 12
IF (btt / 100) > 1620 THEN btt$ = "Batt: [|         ]": C = 12
'########## BARRIER CODES #######
IF y = 80 OR y = 91 THEN GOTO mcrash2
'########## DOOR CODES #######
IF x = 5 THEN segm = 2: GOTO m2seg6
IF x = 305 THEN segm = 0: GOTO m2seg8
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END

m2seg8: CLS '                   >>> SEGMENT #08 <<<
'######## LEVEL #########
LINE (0, 80)-(150, 80), 2
LINE (150, 80)-(150, 0), 2
LINE (0, 100)-(170, 100), 2
LINE (170, 100)-(170, 0), 2
PCOPY 1, 0
'######### PROGRAM ######
IF segm = 0 THEN x = 10
IF segm = 1 THEN y = 10
IF i = 0 THEN stat$ = "Collect Item:"
IF i = 1 THEN stat$ = "Exit Cave:Got Item"
DO
press$ = INKEY$
LOCATE 1, 1: COLOR C: PRINT btt$
LOCATE 2, 1: COLOR 9: PRINT stat$
'######## Graphics Code #######
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), sch1, PSET
IF d = 2 THEN PUT (x, y), scv1, PSET
IF d = 3 THEN PUT (x, y), sch2, PSET
IF d = 4 THEN PUT (x, y), scv2, PSET
IF press$ = CHR$(0) + CHR$(75) THEN d = 2
IF press$ = CHR$(0) + CHR$(72) THEN d = 1
IF press$ = CHR$(0) + CHR$(77) THEN d = 4
IF press$ = CHR$(0) + CHR$(80) THEN d = 3
IF press$ = CHR$(0) + CHR$(72) THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(80) THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(75) THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(77) THEN x = x + 1: PLAY "A"
IF press$ = "4" THEN d = 2
IF press$ = "8" THEN d = 1
IF press$ = "2" THEN d = 3
IF press$ = "6" THEN d = 4
IF press$ = "8" THEN y = y - 1: PLAY "A"
IF press$ = "2" THEN y = y + 1: PLAY "A"
IF press$ = "4" THEN x = x - 1: PLAY "A"
IF press$ = "6" THEN x = x + 1: PLAY "A"
'########### BATTERY CODE ############
btt = btt + 1
IF (btt / 100) > 1800 THEN GOTO dbtt
IF (btt / 100) > 180 THEN btt$ = "Batt: [||||||||| ]": C = 10
IF (btt / 100) > 360 THEN btt$ = "Batt: [||||||||  ]": C = 10
IF (btt / 100) > 540 THEN btt$ = "Batt: [|||||||   ]": C = 10
IF (btt / 100) > 720 THEN btt$ = "Batt: [||||||    ]": C = 14
IF (btt / 100) > 900 THEN btt$ = "Batt: [|||||     ]": C = 14
IF (btt / 100) > 1080 THEN btt$ = "Batt: [||||      ]": C = 14
IF (btt / 100) > 1260 THEN btt$ = "Batt: [|||       ]": C = 12
IF (btt / 100) > 1440 THEN btt$ = "Batt: [||        ]": C = 12
IF (btt / 100) > 1620 THEN btt$ = "Batt: [|         ]": C = 12
'########## BARRIER CODES #######
IF x < 151 AND y < 81 THEN GOTO mcrash2
IF x = 161 OR y = 91 THEN GOTO mcrash2
'########## DOOR CODES #########
IF x = 5 THEN segm = 1: GOTO m2seg7
IF y = 5 THEN segm = 0: GOTO m2seg9
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END

m2seg9: CLS '                   >>> SEGMENT #09 <<<
'######## LEVEL #########
LINE (150, 200)-(150, 80), 2
LINE (150, 80)-(320, 80), 2
LINE (170, 200)-(170, 100), 2
LINE (170, 100)-(320, 100), 2
PCOPY 1, 0
'######### PROGRAM ######
IF segm = 0 THEN y = 180
IF segm = 1 THEN x = 300
IF i = 0 THEN stat$ = "Collect Item:"
IF i = 1 THEN stat$ = "Exit Cave:Got Item"
DO
press$ = INKEY$
LOCATE 1, 1: COLOR C: PRINT btt$
LOCATE 2, 1: COLOR 9: PRINT stat$
'######## Graphics Code #######
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), sch1, PSET
IF d = 2 THEN PUT (x, y), scv1, PSET
IF d = 3 THEN PUT (x, y), sch2, PSET
IF d = 4 THEN PUT (x, y), scv2, PSET
IF press$ = CHR$(0) + CHR$(75) THEN d = 2
IF press$ = CHR$(0) + CHR$(72) THEN d = 1
IF press$ = CHR$(0) + CHR$(77) THEN d = 4
IF press$ = CHR$(0) + CHR$(80) THEN d = 3
IF press$ = CHR$(0) + CHR$(72) THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(80) THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(75) THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(77) THEN x = x + 1: PLAY "A"
IF press$ = "4" THEN d = 2
IF press$ = "8" THEN d = 1
IF press$ = "2" THEN d = 3
IF press$ = "6" THEN d = 4
IF press$ = "8" THEN y = y - 1: PLAY "A"
IF press$ = "2" THEN y = y + 1: PLAY "A"
IF press$ = "4" THEN x = x - 1: PLAY "A"
IF press$ = "6" THEN x = x + 1: PLAY "A"
'########### BATTERY CODE ############
btt = btt + 1
IF (btt / 100) > 1800 THEN GOTO dbtt
IF (btt / 100) > 180 THEN btt$ = "Batt: [||||||||| ]": C = 10
IF (btt / 100) > 360 THEN btt$ = "Batt: [||||||||  ]": C = 10
IF (btt / 100) > 540 THEN btt$ = "Batt: [|||||||   ]": C = 10
IF (btt / 100) > 720 THEN btt$ = "Batt: [||||||    ]": C = 14
IF (btt / 100) > 900 THEN btt$ = "Batt: [|||||     ]": C = 14
IF (btt / 100) > 1080 THEN btt$ = "Batt: [||||      ]": C = 14
IF (btt / 100) > 1260 THEN btt$ = "Batt: [|||       ]": C = 12
IF (btt / 100) > 1440 THEN btt$ = "Batt: [||        ]": C = 12
IF (btt / 100) > 1620 THEN btt$ = "Batt: [|         ]": C = 12
'########## BARRIER CODES #######
IF x = 150 OR y = 80 THEN GOTO mcrash2
IF x > 160 AND y > 90 THEN GOTO mcrash2
'########## DOOR CODES #########
IF x = 305 THEN segm = 0: GOTO m2seg10
IF y = 185 THEN segm = 1: GOTO m2seg8
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END

m2seg10: CLS '                  >>> SEGMENT #10 <<<
'######## LEVEL #########
LINE (0, 80)-(150, 80), 2
LINE (150, 80)-(150, 0), 2
LINE (0, 100)-(170, 100), 2
LINE (170, 100)-(170, 0), 2
PCOPY 1, 0
'######### PROGRAM ######
IF segm = 0 THEN x = 10
IF segm = 1 THEN y = 10
IF i = 0 THEN stat$ = "Collect Item:"
IF i = 1 THEN stat$ = "Exit Cave:Got Item"
DO
press$ = INKEY$
LOCATE 1, 1: COLOR C: PRINT btt$
LOCATE 2, 1: COLOR 9: PRINT stat$
'######## Graphics Code #######
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), sch1, PSET
IF d = 2 THEN PUT (x, y), scv1, PSET
IF d = 3 THEN PUT (x, y), sch2, PSET
IF d = 4 THEN PUT (x, y), scv2, PSET
IF press$ = CHR$(0) + CHR$(75) THEN d = 2
IF press$ = CHR$(0) + CHR$(72) THEN d = 1
IF press$ = CHR$(0) + CHR$(77) THEN d = 4
IF press$ = CHR$(0) + CHR$(80) THEN d = 3
IF press$ = CHR$(0) + CHR$(72) THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(80) THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(75) THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(77) THEN x = x + 1: PLAY "A"
IF press$ = "4" THEN d = 2
IF press$ = "8" THEN d = 1
IF press$ = "2" THEN d = 3
IF press$ = "6" THEN d = 4
IF press$ = "8" THEN y = y - 1: PLAY "A"
IF press$ = "2" THEN y = y + 1: PLAY "A"
IF press$ = "4" THEN x = x - 1: PLAY "A"
IF press$ = "6" THEN x = x + 1: PLAY "A"
'########### BATTERY CODE ############
btt = btt + 1
IF (btt / 100) > 1800 THEN GOTO dbtt
IF (btt / 100) > 180 THEN btt$ = "Batt: [||||||||| ]": C = 10
IF (btt / 100) > 360 THEN btt$ = "Batt: [||||||||  ]": C = 10
IF (btt / 100) > 540 THEN btt$ = "Batt: [|||||||   ]": C = 10
IF (btt / 100) > 720 THEN btt$ = "Batt: [||||||    ]": C = 14
IF (btt / 100) > 900 THEN btt$ = "Batt: [|||||     ]": C = 14
IF (btt / 100) > 1080 THEN btt$ = "Batt: [||||      ]": C = 14
IF (btt / 100) > 1260 THEN btt$ = "Batt: [|||       ]": C = 12
IF (btt / 100) > 1440 THEN btt$ = "Batt: [||        ]": C = 12
IF (btt / 100) > 1620 THEN btt$ = "Batt: [|         ]": C = 12
'########## BARRIER CODES #######
IF x < 151 AND y < 81 THEN GOTO mcrash2
IF x = 161 OR y = 91 THEN GOTO mcrash2
'########## DOOR CODES #########
IF x = 5 THEN segm = 1: GOTO m2seg9
IF y = 5 THEN segm = 0: GOTO m2seg11
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END

m2seg11: CLS '                  >>> SEGMENT #11 <<<
'########## LEVEL #########
LINE (150, 200)-(150, 100), 2
LINE (170, 200)-(170, 80), 2
LINE (150, 100)-(0, 100), 2
LINE (170, 80)-(0, 80), 2
PCOPY 1, 0
'######### PROGRAM ######
IF segm = 0 THEN y = 180
IF segm = 1 THEN x = 10
IF i = 0 THEN stat$ = "Collect Item:"
IF i = 1 THEN stat$ = "Exit Cave:Got Item"
DO
press$ = INKEY$
LOCATE 1, 1: COLOR C: PRINT btt$
LOCATE 2, 1: COLOR 9: PRINT stat$
'######## Graphics Code #######
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), sch1, PSET
IF d = 2 THEN PUT (x, y), scv1, PSET
IF d = 3 THEN PUT (x, y), sch2, PSET
IF d = 4 THEN PUT (x, y), scv2, PSET
IF press$ = CHR$(0) + CHR$(75) THEN d = 2
IF press$ = CHR$(0) + CHR$(72) THEN d = 1
IF press$ = CHR$(0) + CHR$(77) THEN d = 4
IF press$ = CHR$(0) + CHR$(80) THEN d = 3
IF press$ = CHR$(0) + CHR$(72) THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(80) THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(75) THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(77) THEN x = x + 1: PLAY "A"
IF press$ = "4" THEN d = 2
IF press$ = "8" THEN d = 1
IF press$ = "2" THEN d = 3
IF press$ = "6" THEN d = 4
IF press$ = "8" THEN y = y - 1: PLAY "A"
IF press$ = "2" THEN y = y + 1: PLAY "A"
IF press$ = "4" THEN x = x - 1: PLAY "A"
IF press$ = "6" THEN x = x + 1: PLAY "A"
'########### BATTERY CODE ############
btt = btt + 1
IF (btt / 100) > 1800 THEN GOTO dbtt
IF (btt / 100) > 180 THEN btt$ = "Batt: [||||||||| ]": C = 10
IF (btt / 100) > 360 THEN btt$ = "Batt: [||||||||  ]": C = 10
IF (btt / 100) > 540 THEN btt$ = "Batt: [|||||||   ]": C = 10
IF (btt / 100) > 720 THEN btt$ = "Batt: [||||||    ]": C = 14
IF (btt / 100) > 900 THEN btt$ = "Batt: [|||||     ]": C = 14
IF (btt / 100) > 1080 THEN btt$ = "Batt: [||||      ]": C = 14
IF (btt / 100) > 1260 THEN btt$ = "Batt: [|||       ]": C = 12
IF (btt / 100) > 1440 THEN btt$ = "Batt: [||        ]": C = 12
IF (btt / 100) > 1620 THEN btt$ = "Batt: [|         ]": C = 12
'########## BARRIER CODES #######
IF x < 151 AND y > 90 THEN GOTO mcrash2
IF x = 161 OR y = 80 THEN GOTO mcrash2
'########## DOOR CODES ##########
IF y = 185 THEN segm = 1: GOTO m2seg10
IF x = 5 THEN segm = 0: GOTO m2seg12
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END

m2seg12: CLS '                  >>> SEGMENT #12 <<<
'######### LEVEL #############
LINE (0, 80)-(320, 80), 2
LINE (0, 100)-(320, 100), 2
PCOPY 1, 0
'######### PROGRAM ######
IF segm = 0 THEN x = 300
IF segm = 1 THEN x = 10
IF i = 0 THEN stat$ = "Collect Item:"
IF i = 1 THEN stat$ = "Exit Cave:Got Item"
DO
press$ = INKEY$
LOCATE 1, 1: COLOR C: PRINT btt$
LOCATE 2, 1: COLOR 9: PRINT stat$
'######## Graphics Code #######
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), sch1, PSET
IF d = 2 THEN PUT (x, y), scv1, PSET
IF d = 3 THEN PUT (x, y), sch2, PSET
IF d = 4 THEN PUT (x, y), scv2, PSET
IF press$ = CHR$(0) + CHR$(75) THEN d = 2
IF press$ = CHR$(0) + CHR$(72) THEN d = 1
IF press$ = CHR$(0) + CHR$(77) THEN d = 4
IF press$ = CHR$(0) + CHR$(80) THEN d = 3
IF press$ = CHR$(0) + CHR$(72) THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(80) THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(75) THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(77) THEN x = x + 1: PLAY "A"
IF press$ = "4" THEN d = 2
IF press$ = "8" THEN d = 1
IF press$ = "2" THEN d = 3
IF press$ = "6" THEN d = 4
IF press$ = "8" THEN y = y - 1: PLAY "A"
IF press$ = "2" THEN y = y + 1: PLAY "A"
IF press$ = "4" THEN x = x - 1: PLAY "A"
IF press$ = "6" THEN x = x + 1: PLAY "A"
'########### BATTERY CODE ############
btt = btt + 1
IF (btt / 100) > 1800 THEN GOTO dbtt
IF (btt / 100) > 180 THEN btt$ = "Batt: [||||||||| ]": C = 10
IF (btt / 100) > 360 THEN btt$ = "Batt: [||||||||  ]": C = 10
IF (btt / 100) > 540 THEN btt$ = "Batt: [|||||||   ]": C = 10
IF (btt / 100) > 720 THEN btt$ = "Batt: [||||||    ]": C = 14
IF (btt / 100) > 900 THEN btt$ = "Batt: [|||||     ]": C = 14
IF (btt / 100) > 1080 THEN btt$ = "Batt: [||||      ]": C = 14
IF (btt / 100) > 1260 THEN btt$ = "Batt: [|||       ]": C = 12
IF (btt / 100) > 1440 THEN btt$ = "Batt: [||        ]": C = 12
IF (btt / 100) > 1620 THEN btt$ = "Batt: [|         ]": C = 12
'########## BARRIER CODES #######
IF y = 80 OR y = 91 THEN GOTO mcrash2
'########## DOOR CODES #######
IF x = 5 THEN segm = 0: GOTO m2seg13
IF x = 305 THEN segm = 1: GOTO m2seg11
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END

m2seg13: CLS '                  >>> SEGMENT #13 <<<
'######## LEVEL #########
LINE (150, 200)-(150, 80), 2
LINE (150, 80)-(320, 80), 2
LINE (170, 200)-(170, 100), 2
LINE (170, 100)-(320, 100), 2
PCOPY 1, 0
'######### PROGRAM ######
IF segm = 1 THEN y = 180
IF segm = 0 THEN x = 300
IF i = 0 THEN stat$ = "Collect Item:"
IF i = 1 THEN stat$ = "Exit Cave:Got Item"
DO
press$ = INKEY$
LOCATE 1, 1: COLOR C: PRINT btt$
LOCATE 2, 1: COLOR 9: PRINT stat$
'######## Graphics Code #######
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), sch1, PSET
IF d = 2 THEN PUT (x, y), scv1, PSET
IF d = 3 THEN PUT (x, y), sch2, PSET
IF d = 4 THEN PUT (x, y), scv2, PSET
IF press$ = CHR$(0) + CHR$(75) THEN d = 2
IF press$ = CHR$(0) + CHR$(72) THEN d = 1
IF press$ = CHR$(0) + CHR$(77) THEN d = 4
IF press$ = CHR$(0) + CHR$(80) THEN d = 3
IF press$ = CHR$(0) + CHR$(72) THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(80) THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(75) THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(77) THEN x = x + 1: PLAY "A"
IF press$ = "4" THEN d = 2
IF press$ = "8" THEN d = 1
IF press$ = "2" THEN d = 3
IF press$ = "6" THEN d = 4
IF press$ = "8" THEN y = y - 1: PLAY "A"
IF press$ = "2" THEN y = y + 1: PLAY "A"
IF press$ = "4" THEN x = x - 1: PLAY "A"
IF press$ = "6" THEN x = x + 1: PLAY "A"
'########### BATTERY CODE ############
btt = btt + 1
IF (btt / 100) > 1800 THEN GOTO dbtt
IF (btt / 100) > 180 THEN btt$ = "Batt: [||||||||| ]": C = 10
IF (btt / 100) > 360 THEN btt$ = "Batt: [||||||||  ]": C = 10
IF (btt / 100) > 540 THEN btt$ = "Batt: [|||||||   ]": C = 10
IF (btt / 100) > 720 THEN btt$ = "Batt: [||||||    ]": C = 14
IF (btt / 100) > 900 THEN btt$ = "Batt: [|||||     ]": C = 14
IF (btt / 100) > 1080 THEN btt$ = "Batt: [||||      ]": C = 14
IF (btt / 100) > 1260 THEN btt$ = "Batt: [|||       ]": C = 12
IF (btt / 100) > 1440 THEN btt$ = "Batt: [||        ]": C = 12
IF (btt / 100) > 1620 THEN btt$ = "Batt: [|         ]": C = 12
'########## BARRIER CODES #######
IF x = 150 OR y = 80 THEN GOTO mcrash2
IF x > 160 AND y > 90 THEN GOTO mcrash2
'########## DOOR CODES #########
IF x = 305 THEN segm = 1: GOTO m2seg12
IF y = 185 THEN segm = 0: GOTO m2seg14
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END


m2seg14: CLS '                  >>> SEGMENT #14 <<<
'######## LEVEL #########
LINE (0, 80)-(150, 80), 2
LINE (150, 80)-(150, 0), 2
LINE (0, 100)-(170, 100), 2
LINE (170, 100)-(170, 0), 2
LINE (151, 70)-(169, 60), 1, BF
PCOPY 1, 0
'######### PROGRAM ######
IF segm = 0 THEN y = 10
IF segm = 1 THEN x = 10
IF i = 0 THEN stat$ = "Passage Blocked:"
IF segm = 0 THEN stat$ = "There it is!!"
IF i = 1 THEN stat$ = "Exit Cave:Got Item"
DO
press$ = INKEY$
LOCATE 1, 1: COLOR C: PRINT btt$
LOCATE 2, 1: COLOR 9: PRINT stat$
'######## ITEM CODE ######
IF i = 0 THEN CIRCLE (160, 40), 3, 6: PAINT (160, 40), 6 ELSE CIRCLE (160, 40), 3, 0: PAINT (160, 40), 0
IF x > 152 AND x < 159 THEN IF y = 29 OR y = 42 THEN i = 1: stat$ = "Exit Cave:Got Item"
'######## Graphics Code #######
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), sch1, PSET
IF d = 2 THEN PUT (x, y), scv1, PSET
IF d = 3 THEN PUT (x, y), sch2, PSET
IF d = 4 THEN PUT (x, y), scv2, PSET
IF press$ = CHR$(0) + CHR$(75) THEN d = 2
IF press$ = CHR$(0) + CHR$(72) THEN d = 1
IF press$ = CHR$(0) + CHR$(77) THEN d = 4
IF press$ = CHR$(0) + CHR$(80) THEN d = 3
IF press$ = CHR$(0) + CHR$(72) THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(80) THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(75) THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(77) THEN x = x + 1: PLAY "A"
IF press$ = "4" THEN d = 2
IF press$ = "8" THEN d = 1
IF press$ = "2" THEN d = 3
IF press$ = "6" THEN d = 4
IF press$ = "8" THEN y = y - 1: PLAY "A"
IF press$ = "2" THEN y = y + 1: PLAY "A"
IF press$ = "4" THEN x = x - 1: PLAY "A"
IF press$ = "6" THEN x = x + 1: PLAY "A"
'########### BATTERY CODE ############
btt = btt + 1
IF (btt / 100) > 1800 THEN GOTO dbtt
IF (btt / 100) > 180 THEN btt$ = "Batt: [||||||||| ]": C = 10
IF (btt / 100) > 360 THEN btt$ = "Batt: [||||||||  ]": C = 10
IF (btt / 100) > 540 THEN btt$ = "Batt: [|||||||   ]": C = 10
IF (btt / 100) > 720 THEN btt$ = "Batt: [||||||    ]": C = 14
IF (btt / 100) > 900 THEN btt$ = "Batt: [|||||     ]": C = 14
IF (btt / 100) > 1080 THEN btt$ = "Batt: [||||      ]": C = 14
IF (btt / 100) > 1260 THEN btt$ = "Batt: [|||       ]": C = 12
IF (btt / 100) > 1440 THEN btt$ = "Batt: [||        ]": C = 12
IF (btt / 100) > 1620 THEN btt$ = "Batt: [|         ]": C = 12
'########## BARRIER CODES #######
IF x < 151 AND y < 81 THEN GOTO mcrash2
IF x = 161 OR y = 91 THEN GOTO mcrash2
IF y = 51 OR y = 70 THEN GOTO mcrash2
'########## DOOR CODES #########
IF x = 5 THEN segm = 3: GOTO m2seg5
IF y = 5 THEN segm = 1: GOTO m2seg13
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END

m2seg15: CLS '                  >>> SEGMENT #15 <<<
'######## LEVEL #########
LINE (150, 200)-(150, 80), 2
LINE (150, 80)-(320, 80), 2
LINE (170, 200)-(170, 100), 2
LINE (170, 100)-(320, 100), 2
PCOPY 1, 0
'######### PROGRAM ######
IF segm = 0 THEN y = 180: d = 1
IF i = 0 THEN stat$ = "Collect Item:"
IF i = 1 THEN stat$ = "Exit Cave:Got Item"
DO
press$ = INKEY$
LOCATE 1, 1: COLOR C: PRINT btt$
LOCATE 2, 1: COLOR 9: PRINT stat$
'######## Graphics Code #######
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), sch1, PSET
IF d = 2 THEN PUT (x, y), scv1, PSET
IF d = 3 THEN PUT (x, y), sch2, PSET
IF d = 4 THEN PUT (x, y), scv2, PSET
IF press$ = CHR$(0) + CHR$(75) THEN d = 2
IF press$ = CHR$(0) + CHR$(72) THEN d = 1
IF press$ = CHR$(0) + CHR$(77) THEN d = 4
IF press$ = CHR$(0) + CHR$(80) THEN d = 3
IF press$ = CHR$(0) + CHR$(72) THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(80) THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(75) THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(77) THEN x = x + 1: PLAY "A"
IF press$ = "4" THEN d = 2
IF press$ = "8" THEN d = 1
IF press$ = "2" THEN d = 3
IF press$ = "6" THEN d = 4
IF press$ = "8" THEN y = y - 1: PLAY "A"
IF press$ = "2" THEN y = y + 1: PLAY "A"
IF press$ = "4" THEN x = x - 1: PLAY "A"
IF press$ = "6" THEN x = x + 1: PLAY "A"
'########### BATTERY CODE ############
btt = btt + 1
IF (btt / 100) > 1800 THEN GOTO dbtt
IF (btt / 100) > 180 THEN btt$ = "Batt: [||||||||| ]": C = 10
IF (btt / 100) > 360 THEN btt$ = "Batt: [||||||||  ]": C = 10
IF (btt / 100) > 540 THEN btt$ = "Batt: [|||||||   ]": C = 10
IF (btt / 100) > 720 THEN btt$ = "Batt: [||||||    ]": C = 14
IF (btt / 100) > 900 THEN btt$ = "Batt: [|||||     ]": C = 14
IF (btt / 100) > 1080 THEN btt$ = "Batt: [||||      ]": C = 14
IF (btt / 100) > 1260 THEN btt$ = "Batt: [|||       ]": C = 12
IF (btt / 100) > 1440 THEN btt$ = "Batt: [||        ]": C = 12
IF (btt / 100) > 1620 THEN btt$ = "Batt: [|         ]": C = 12
'########## BARRIER CODES #######
IF x = 150 OR y = 80 THEN GOTO mcrash2
IF x > 160 AND y > 90 THEN GOTO mcrash2
IF x = 305 THEN x = 304
'########## DOOR CODES #########
IF y = 185 THEN segm = 2: GOTO m2seg3
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END

m2seg16: CLS '                  >>> SEGMENT #16 <<<
'######## LEVEL #########
LINE (320, 100)-(150, 100), 2
LINE (320, 80)-(170, 80), 2
LINE (150, 100)-(150, 0), 2
LINE (170, 80)-(170, 0), 2
PCOPY 1, 0
'######### PROGRAM ######
IF segm = 0 THEN x = 300
IF i = 0 THEN stat$ = "Collect Item:"
IF i = 1 THEN stat$ = "Exit Cave:Got Item"
DO
press$ = INKEY$
LOCATE 1, 1: COLOR C: PRINT btt$
LOCATE 2, 1: COLOR 9: PRINT stat$
'######## Graphics Code #######
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), sch1, PSET
IF d = 2 THEN PUT (x, y), scv1, PSET
IF d = 3 THEN PUT (x, y), sch2, PSET
IF d = 4 THEN PUT (x, y), scv2, PSET
IF press$ = CHR$(0) + CHR$(75) THEN d = 2
IF press$ = CHR$(0) + CHR$(72) THEN d = 1
IF press$ = CHR$(0) + CHR$(77) THEN d = 4
IF press$ = CHR$(0) + CHR$(80) THEN d = 3
IF press$ = CHR$(0) + CHR$(72) THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(80) THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(75) THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(77) THEN x = x + 1: PLAY "A"
IF press$ = "4" THEN d = 2
IF press$ = "8" THEN d = 1
IF press$ = "2" THEN d = 3
IF press$ = "6" THEN d = 4
IF press$ = "8" THEN y = y - 1: PLAY "A"
IF press$ = "2" THEN y = y + 1: PLAY "A"
IF press$ = "4" THEN x = x - 1: PLAY "A"
IF press$ = "6" THEN x = x + 1: PLAY "A"
'########### BATTERY CODE ############
btt = btt + 1
IF (btt / 100) > 1800 THEN GOTO dbtt
IF (btt / 100) > 180 THEN btt$ = "Batt: [||||||||| ]": C = 10
IF (btt / 100) > 360 THEN btt$ = "Batt: [||||||||  ]": C = 10
IF (btt / 100) > 540 THEN btt$ = "Batt: [|||||||   ]": C = 10
IF (btt / 100) > 720 THEN btt$ = "Batt: [||||||    ]": C = 14
IF (btt / 100) > 900 THEN btt$ = "Batt: [|||||     ]": C = 14
IF (btt / 100) > 1080 THEN btt$ = "Batt: [||||      ]": C = 14
IF (btt / 100) > 1260 THEN btt$ = "Batt: [|||       ]": C = 12
IF (btt / 100) > 1440 THEN btt$ = "Batt: [||        ]": C = 12
IF (btt / 100) > 1620 THEN btt$ = "Batt: [|         ]": C = 12
'########## BARRIER CODES #######
IF x > 160 AND y < 81 THEN GOTO mcrash2
IF x = 150 OR y = 90 THEN GOTO mcrash2
IF y = 10 THEN y = 11
'########## DOOR CODES ##########
IF x = 305 THEN segm = 1: GOTO m2seg6
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END

m2seg17: CLS '                  >>> SEGMENT #17 <<<
'######## LEVEL #########
LINE (150, 200)-(150, 80), 2
LINE (150, 80)-(320, 80), 2
LINE (170, 200)-(170, 100), 2
LINE (170, 100)-(320, 100), 2
PCOPY 1, 0
'######### PROGRAM ######
IF segm = 0 THEN y = 180: d = 1
IF i = 0 THEN stat$ = "Collect Item:"
IF i = 1 THEN stat$ = "Exit Cave:Got Item"
DO
press$ = INKEY$
LOCATE 1, 1: COLOR C: PRINT btt$
LOCATE 2, 1: COLOR 9: PRINT stat$
'######## Graphics Code #######
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), sch1, PSET
IF d = 2 THEN PUT (x, y), scv1, PSET
IF d = 3 THEN PUT (x, y), sch2, PSET
IF d = 4 THEN PUT (x, y), scv2, PSET
IF press$ = CHR$(0) + CHR$(75) THEN d = 2
IF press$ = CHR$(0) + CHR$(72) THEN d = 1
IF press$ = CHR$(0) + CHR$(77) THEN d = 4
IF press$ = CHR$(0) + CHR$(80) THEN d = 3
IF press$ = CHR$(0) + CHR$(72) THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(80) THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(75) THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(77) THEN x = x + 1: PLAY "A"
IF press$ = "4" THEN d = 2
IF press$ = "8" THEN d = 1
IF press$ = "2" THEN d = 3
IF press$ = "6" THEN d = 4
IF press$ = "8" THEN y = y - 1: PLAY "A"
IF press$ = "2" THEN y = y + 1: PLAY "A"
IF press$ = "4" THEN x = x - 1: PLAY "A"
IF press$ = "6" THEN x = x + 1: PLAY "A"
'########### BATTERY CODE ############
btt = btt + 1
IF (btt / 100) > 1800 THEN GOTO dbtt
IF (btt / 100) > 180 THEN btt$ = "Batt: [||||||||| ]": C = 10
IF (btt / 100) > 360 THEN btt$ = "Batt: [||||||||  ]": C = 10
IF (btt / 100) > 540 THEN btt$ = "Batt: [|||||||   ]": C = 10
IF (btt / 100) > 720 THEN btt$ = "Batt: [||||||    ]": C = 14
IF (btt / 100) > 900 THEN btt$ = "Batt: [|||||     ]": C = 14
IF (btt / 100) > 1080 THEN btt$ = "Batt: [||||      ]": C = 14
IF (btt / 100) > 1260 THEN btt$ = "Batt: [|||       ]": C = 12
IF (btt / 100) > 1440 THEN btt$ = "Batt: [||        ]": C = 12
IF (btt / 100) > 1620 THEN btt$ = "Batt: [|         ]": C = 12
'########## BARRIER CODES #######
IF x = 150 OR y = 80 THEN GOTO mcrash2
IF x > 160 AND y > 90 THEN GOTO mcrash2
IF x = 305 THEN x = 304
'########## DOOR CODES #########
IF y = 185 THEN segm = 1: GOTO m2seg5
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END

mfinish2: CLS
COLOR 10
PRINT " You completed the mission!"
PRINT
PRINT " Now for the next one!"
PRINT
COLOR 9
PRINT
PRINT " This level's code is: INDEEP"
PRINT " Next level's code is: SUBRUINS"
PRINT
PRINT " Press SPACEBAR to continue..."
PCOPY 1, 0
DO
press$ = INKEY$
LOOP UNTIL press$ = " "
CLS
SCREEN 13
CALL Menu6

dbtt: CLS
COLOR 14
PRINT " Your battery ran out!"
PRINT
PRINT " Esc. = Exit| Try again?"
PRINT
COLOR 9
PRINT
PRINT " This level's code is: INDEEP"
PRINT " Next level's code is: >>did not pass<<"
PRINT
PRINT " Press SPACEBAR to Retry..."
PCOPY 1, 0
btt = 0
DO
press$ = INKEY$
IF press$ = CHR$(27) THEN END
LOOP UNTIL press$ = " "
segm = 0
GOTO m2seg1

END

mcrash2: CLS
COLOR 12
PRINT " You Crashed My Robot!"
PRINT
PRINT " Sorry, You are fired!"
PRINT
COLOR 9
PRINT
PRINT " This level's code is: INDEEP"
PRINT " Next level's code is: >>did not pass<<"
PRINT
PRINT " Press SPACEBAR to continue..."
PCOPY 1, 0
DO
press$ = INKEY$
LOOP UNTIL press$ = " "
CLS
SCREEN 13
CALL Menu

END SUB

SUB Mission03
SCREEN 7, 0, 1, 0
DIM crh1(100), crh2(100), crv1(100), crv2(100), mask(100)
PLAY "MB L64 <<<"
COLOR 15
PRINT " Mission Status:"
PRINT
PRINT "      Mission 3: In this mission, you"
PRINT " will be exploring a collapsed ruin. "
PRINT " My scans show me that my flat robot,"
PRINT " 'Creeper' designed for getting under"
PRINT " things, should be able to retreive  "
PRINT " the gem located there. It also has a"
PRINT " 30 minute battery life, this is     "
PRINT " plenty of time to clear this level. "
PRINT " Take your time, and be careful. I   "
PRINT " made a flat towing bot for any dead "
PRINT " batteries. Just don't crash!"
PRINT
COLOR 9
PRINT "  NOTE: If the robot stops, its a "
PRINT "        dead end, try a new direction"
PRINT
PRINT
COLOR 10
PRINT " Press SPACEBAR to continue..."
PCOPY 1, 0
DO
press$ = INKEY$
LOOP UNTIL press$ = " "
CLS

'######### ROBOT ##########
LINE (1, 1)-(2, 10), 8, BF
LINE (10, 1)-(9, 10), 8, BF
LINE (3, 2)-(8, 9), 9, BF
PSET (4, 1), 7: PSET (7, 1), 7
PCOPY 1, 0
GET (1, 1)-(10, 10), crh1
CLS
LINE (1, 1)-(2, 10), 8, BF
LINE (10, 1)-(9, 10), 8, BF
LINE (3, 2)-(8, 9), 9, BF
PSET (4, 10), 7: PSET (7, 10), 7
PCOPY 1, 0
GET (1, 1)-(10, 10), crh2
CLS
LINE (1, 1)-(10, 2), 8, BF
LINE (1, 10)-(10, 9), 8, BF
LINE (2, 3)-(9, 8), 9, BF
PSET (1, 4), 7: PSET (1, 7), 7
GET (1, 1)-(10, 10), crv1
PCOPY 1, 0
CLS
LINE (1, 1)-(10, 2), 8, BF
LINE (1, 10)-(10, 9), 8, BF
LINE (2, 3)-(9, 8), 9, BF
PSET (10, 4), 7: PSET (10, 7), 7
GET (1, 1)-(10, 10), crv2
PCOPY 1, 0
CLS
GET (1, 1)-(10, 10), mask
 
m3seg1: CLS '                    >>> SEGMENT #01 <<<
'######### LEVEL ########
LINE (150, 200)-(150, 0), 6
LINE (170, 200)-(170, 0), 6
PCOPY 1, 0
'######### PROGRAM ######
IF segm = 0 THEN x = 155: y = 180: d = 1
IF segm = 1 THEN y = 10
btt$ = "Batt: [||||||||||]": C = 10
IF i = 0 THEN stat$ = "Collect Item:"
IF i = 1 THEN stat$ = "Exit Ruin: Got Gem"
DO
press$ = INKEY$
LOCATE 1, 1: COLOR C: PRINT btt$
LOCATE 2, 1: COLOR 9: PRINT stat$
'######## Graphics Code #######
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), crh1, PSET
IF d = 2 THEN PUT (x, y), crv1, PSET
IF d = 3 THEN PUT (x, y), crh2, PSET
IF d = 4 THEN PUT (x, y), crv2, PSET
IF press$ = CHR$(0) + CHR$(75) THEN d = 2
IF press$ = CHR$(0) + CHR$(72) THEN d = 1
IF press$ = CHR$(0) + CHR$(77) THEN d = 4
IF press$ = CHR$(0) + CHR$(80) THEN d = 3
IF press$ = CHR$(0) + CHR$(72) THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(80) THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(75) THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(77) THEN x = x + 1: PLAY "A"
IF press$ = "4" THEN d = 2
IF press$ = "8" THEN d = 1
IF press$ = "2" THEN d = 3
IF press$ = "6" THEN d = 4
IF press$ = "8" THEN y = y - 1: PLAY "A"
IF press$ = "2" THEN y = y + 1: PLAY "A"
IF press$ = "4" THEN x = x - 1: PLAY "A"
IF press$ = "6" THEN x = x + 1: PLAY "A"
'########### BATTERY CODE ############
btt = btt + 1
IF (btt / 100) > 1800 THEN GOTO dbtt3
IF y < 184 AND (btt / 100) THEN btt$ = "Batt: [||||||||||]"
IF (btt / 100) > 180 THEN btt$ = "Batt: [||||||||| ]": C = 10
IF (btt / 100) > 360 THEN btt$ = "Batt: [||||||||  ]": C = 10
IF (btt / 100) > 540 THEN btt$ = "Batt: [|||||||   ]": C = 10
IF (btt / 100) > 720 THEN btt$ = "Batt: [||||||    ]": C = 14
IF (btt / 100) > 900 THEN btt$ = "Batt: [|||||     ]": C = 14
IF (btt / 100) > 1080 THEN btt$ = "Batt: [||||      ]": C = 14
IF (btt / 100) > 1260 THEN btt$ = "Batt: [|||       ]": C = 12
IF (btt / 100) > 1440 THEN btt$ = "Batt: [||        ]": C = 12
IF (btt / 100) > 1620 THEN btt$ = "Batt: [|         ]": C = 12
'########## BARRIER CODES #######
IF x = 161 THEN GOTO mcrash3
IF x = 150 THEN GOTO mcrash3
'########## DOOR CODES ##########
IF i = 0 AND y = 185 THEN y = 184: stat$ = "Not Finished "' ELSE GOTO mfinish3
IF i = 0 AND y < 184 THEN stat$ = "Collect Item:"
IF y = 5 THEN segm = 0: GOTO m3seg2
IF i = 1 AND y = 185 THEN GOTO mfinish3
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END

m3seg2: CLS '                    >>> SEGMENT #02 <<<
'######## LEVEL #########
LINE (150, 0)-(150, 80), 6
LINE (170, 0)-(170, 80), 6
LINE (0, 80)-(150, 80), 6
LINE (320, 80)-(170, 80), 6
LINE (150, 200)-(150, 100), 6
LINE (170, 200)-(170, 100), 6
LINE (0, 100)-(150, 100), 6
LINE (320, 100)-(170, 100), 6
PCOPY 1, 0
'######### PROGRAM ######
IF segm = 0 THEN y = 180
IF segm = 1 THEN x = 10
IF segm = 2 THEN x = 300
btt$ = "Batt: [||||||||||]": C = 10
IF i = 0 THEN stat$ = "Collect Item:"
IF i = 1 THEN stat$ = "Exit Ruin: Got Gem"
DO
press$ = INKEY$
LOCATE 1, 1: COLOR C: PRINT btt$
LOCATE 2, 1: COLOR 9: PRINT stat$
'######## Graphics Code #######
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), crh1, PSET
IF d = 2 THEN PUT (x, y), crv1, PSET
IF d = 3 THEN PUT (x, y), crh2, PSET
IF d = 4 THEN PUT (x, y), crv2, PSET
IF press$ = CHR$(0) + CHR$(75) THEN d = 2
IF press$ = CHR$(0) + CHR$(72) THEN d = 1
IF press$ = CHR$(0) + CHR$(77) THEN d = 4
IF press$ = CHR$(0) + CHR$(80) THEN d = 3
IF press$ = CHR$(0) + CHR$(72) THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(80) THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(75) THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(77) THEN x = x + 1: PLAY "A"
IF press$ = "4" THEN d = 2
IF press$ = "8" THEN d = 1
IF press$ = "2" THEN d = 3
IF press$ = "6" THEN d = 4
IF press$ = "8" THEN y = y - 1: PLAY "A"
IF press$ = "2" THEN y = y + 1: PLAY "A"
IF press$ = "4" THEN x = x - 1: PLAY "A"
IF press$ = "6" THEN x = x + 1: PLAY "A"
'########### BATTERY CODE ############
btt = btt + 1
IF (btt / 100) > 1800 THEN GOTO dbtt3
IF y < 184 AND (btt / 100) THEN btt$ = "Batt: [||||||||||]"
IF (btt / 100) > 180 THEN btt$ = "Batt: [||||||||| ]": C = 10
IF (btt / 100) > 360 THEN btt$ = "Batt: [||||||||  ]": C = 10
IF (btt / 100) > 540 THEN btt$ = "Batt: [|||||||   ]": C = 10
IF (btt / 100) > 720 THEN btt$ = "Batt: [||||||    ]": C = 14
IF (btt / 100) > 900 THEN btt$ = "Batt: [|||||     ]": C = 14
IF (btt / 100) > 1080 THEN btt$ = "Batt: [||||      ]": C = 14
IF (btt / 100) > 1260 THEN btt$ = "Batt: [|||       ]": C = 12
IF (btt / 100) > 1440 THEN btt$ = "Batt: [||        ]": C = 12
IF (btt / 100) > 1620 THEN btt$ = "Batt: [|         ]": C = 12
'########## BARRIER CODES #######
IF x < 151 AND y < 81 THEN GOTO mcrash3
IF x > 160 AND y < 81 THEN GOTO mcrash3
IF x < 151 AND y > 90 THEN GOTO mcrash3
IF x > 160 AND y > 90 THEN GOTO mcrash3
IF y = 5 THEN y = 6
'########## DOOR CODES ##########
IF x = 5 THEN segm = 0: GOTO m3seg13
IF x = 305 THEN segm = 0: GOTO m3seg3
IF y = 185 THEN segm = 1: GOTO m3seg1
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END

m3seg3: CLS '                    >>> SEGMENT #03 <<<
'######### LEVEL ########
LINE (150, 0)-(150, 80), 6
LINE (170, 0)-(170, 80), 6
LINE (0, 80)-(150, 80), 6
LINE (320, 80)-(170, 80), 6
LINE (0, 100)-(320, 100), 6
PCOPY 1, 0
'######### PROGRAM ######
IF segm = 0 THEN x = 10
IF segm = 1 THEN y = 10
IF i = 0 THEN stat$ = "Collect Item:"
IF i = 1 THEN stat$ = "Exit Ruin: Got Gem"
DO
press$ = INKEY$
LOCATE 1, 1: COLOR C: PRINT btt$
LOCATE 2, 1: COLOR 9: PRINT stat$
'######## Graphics Code #######
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), crh1, PSET
IF d = 2 THEN PUT (x, y), crv1, PSET
IF d = 3 THEN PUT (x, y), crh2, PSET
IF d = 4 THEN PUT (x, y), crv2, PSET
IF press$ = CHR$(0) + CHR$(75) THEN d = 2
IF press$ = CHR$(0) + CHR$(72) THEN d = 1
IF press$ = CHR$(0) + CHR$(77) THEN d = 4
IF press$ = CHR$(0) + CHR$(80) THEN d = 3
IF press$ = CHR$(0) + CHR$(72) THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(80) THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(75) THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(77) THEN x = x + 1: PLAY "A"
IF press$ = "4" THEN d = 2
IF press$ = "8" THEN d = 1
IF press$ = "2" THEN d = 3
IF press$ = "6" THEN d = 4
IF press$ = "8" THEN y = y - 1: PLAY "A"
IF press$ = "2" THEN y = y + 1: PLAY "A"
IF press$ = "4" THEN x = x - 1: PLAY "A"
IF press$ = "6" THEN x = x + 1: PLAY "A"
'########### BATTERY CODE ############
btt = btt + 1
IF (btt / 100) > 1800 THEN GOTO dbtt3
IF (btt / 100) > 180 THEN btt$ = "Batt: [||||||||| ]": C = 10
IF (btt / 100) > 360 THEN btt$ = "Batt: [||||||||  ]": C = 10
IF (btt / 100) > 540 THEN btt$ = "Batt: [|||||||   ]": C = 10
IF (btt / 100) > 720 THEN btt$ = "Batt: [||||||    ]": C = 14
IF (btt / 100) > 900 THEN btt$ = "Batt: [|||||     ]": C = 14
IF (btt / 100) > 1080 THEN btt$ = "Batt: [||||      ]": C = 14
IF (btt / 100) > 1260 THEN btt$ = "Batt: [|||       ]": C = 12
IF (btt / 100) > 1440 THEN btt$ = "Batt: [||        ]": C = 12
IF (btt / 100) > 1620 THEN btt$ = "Batt: [|         ]": C = 12
'########## BARRIER CODES #######
IF x < 151 AND y < 81 THEN GOTO mcrash3
IF x > 160 AND y < 81 THEN GOTO mcrash3
IF y = 91 THEN GOTO mcrash3
IF x = 300 THEN x = 299
'########## DOOR CODES ########
IF x = 5 THEN segm = 2: GOTO m3seg2
IF y = 5 THEN segm = 0: GOTO m3seg4
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END

m3seg4: CLS '                    >>> SEGMENT #04 <<<
'######### LEVEL ########
LINE (150, 200)-(150, 100), 6
LINE (170, 200)-(170, 100), 6
LINE (0, 100)-(150, 100), 6
LINE (320, 100)-(170, 100), 6
LINE (0, 80)-(320, 80), 6
PCOPY 1, 0
'######### PROGRAM ######
IF segm = 0 THEN y = 180
IF segm = 1 THEN x = 300
IF segm = 2 THEN x = 10
btt$ = "Batt: [||||||||||]": C = 10
IF i = 0 THEN stat$ = "Collect Item:"
IF i = 1 THEN stat$ = "Exit Ruin: Got Gem"
DO
press$ = INKEY$
LOCATE 1, 1: COLOR C: PRINT btt$
LOCATE 2, 1: COLOR 9: PRINT stat$
'######## Graphics Code #######
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), crh1, PSET
IF d = 2 THEN PUT (x, y), crv1, PSET
IF d = 3 THEN PUT (x, y), crh2, PSET
IF d = 4 THEN PUT (x, y), crv2, PSET
IF press$ = CHR$(0) + CHR$(75) THEN d = 2
IF press$ = CHR$(0) + CHR$(72) THEN d = 1
IF press$ = CHR$(0) + CHR$(77) THEN d = 4
IF press$ = CHR$(0) + CHR$(80) THEN d = 3
IF press$ = CHR$(0) + CHR$(72) THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(80) THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(75) THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(77) THEN x = x + 1: PLAY "A"
IF press$ = "4" THEN d = 2
IF press$ = "8" THEN d = 1
IF press$ = "2" THEN d = 3
IF press$ = "6" THEN d = 4
IF press$ = "8" THEN y = y - 1: PLAY "A"
IF press$ = "2" THEN y = y + 1: PLAY "A"
IF press$ = "4" THEN x = x - 1: PLAY "A"
IF press$ = "6" THEN x = x + 1: PLAY "A"
'########### BATTERY CODE ############
btt = btt + 1
IF (btt / 100) > 1800 THEN GOTO dbtt3
IF (btt / 100) > 180 THEN btt$ = "Batt: [||||||||| ]": C = 10
IF (btt / 100) > 360 THEN btt$ = "Batt: [||||||||  ]": C = 10
IF (btt / 100) > 540 THEN btt$ = "Batt: [|||||||   ]": C = 10
IF (btt / 100) > 720 THEN btt$ = "Batt: [||||||    ]": C = 14
IF (btt / 100) > 900 THEN btt$ = "Batt: [|||||     ]": C = 14
IF (btt / 100) > 1080 THEN btt$ = "Batt: [||||      ]": C = 14
IF (btt / 100) > 1260 THEN btt$ = "Batt: [|||       ]": C = 12
IF (btt / 100) > 1440 THEN btt$ = "Batt: [||        ]": C = 12
IF (btt / 100) > 1620 THEN btt$ = "Batt: [|         ]": C = 12
'########## BARRIER CODES #######
IF x < 151 AND y > 90 THEN GOTO mcrash3
IF x > 160 AND y > 90 THEN GOTO mcrash3
IF y = 80 THEN GOTO mcrash3
'########## DOOR CODES ###########
IF y = 185 THEN segm = 1: GOTO m3seg3
IF x = 5 THEN segm = 1: GOTO m3seg15
IF x = 305 THEN segm = 0: GOTO m3seg5
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END

m3seg5: CLS '                    >>> SEGMENT #05 <<<
'########## LEVEL ########
LINE (0, 80)-(150, 80), 6
LINE (0, 100)-(150, 100), 6
LINE (150, 0)-(150, 80), 6
LINE (150, 100)-(150, 200), 6
LINE (170, 0)-(170, 200), 6
PCOPY 1, 0
'######### PROGRAM ######
IF segm = 0 THEN x = 10
IF segm = 1 THEN y = 10
IF segm = 2 THEN y = 180
btt$ = "Batt: [||||||||||]": C = 10
IF i = 0 THEN stat$ = "Collect Item:"
IF i = 1 THEN stat$ = "Exit Ruin: Got Gem"
DO
press$ = INKEY$
LOCATE 1, 1: COLOR C: PRINT btt$
LOCATE 2, 1: COLOR 9: PRINT stat$
'######## Graphics Code #######
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), crh1, PSET
IF d = 2 THEN PUT (x, y), crv1, PSET
IF d = 3 THEN PUT (x, y), crh2, PSET
IF d = 4 THEN PUT (x, y), crv2, PSET
IF press$ = CHR$(0) + CHR$(75) THEN d = 2
IF press$ = CHR$(0) + CHR$(72) THEN d = 1
IF press$ = CHR$(0) + CHR$(77) THEN d = 4
IF press$ = CHR$(0) + CHR$(80) THEN d = 3
IF press$ = CHR$(0) + CHR$(72) THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(80) THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(75) THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(77) THEN x = x + 1: PLAY "A"
IF press$ = "4" THEN d = 2
IF press$ = "8" THEN d = 1
IF press$ = "2" THEN d = 3
IF press$ = "6" THEN d = 4
IF press$ = "8" THEN y = y - 1: PLAY "A"
IF press$ = "2" THEN y = y + 1: PLAY "A"
IF press$ = "4" THEN x = x - 1: PLAY "A"
IF press$ = "6" THEN x = x + 1: PLAY "A"
'########### BATTERY CODE ############
btt = btt + 1
IF (btt / 100) > 1800 THEN GOTO dbtt3
IF (btt / 100) > 180 THEN btt$ = "Batt: [||||||||| ]": C = 10
IF (btt / 100) > 360 THEN btt$ = "Batt: [||||||||  ]": C = 10
IF (btt / 100) > 540 THEN btt$ = "Batt: [|||||||   ]": C = 10
IF (btt / 100) > 720 THEN btt$ = "Batt: [||||||    ]": C = 14
IF (btt / 100) > 900 THEN btt$ = "Batt: [|||||     ]": C = 14
IF (btt / 100) > 1080 THEN btt$ = "Batt: [||||      ]": C = 14
IF (btt / 100) > 1260 THEN btt$ = "Batt: [|||       ]": C = 12
IF (btt / 100) > 1440 THEN btt$ = "Batt: [||        ]": C = 12
IF (btt / 100) > 1620 THEN btt$ = "Batt: [|         ]": C = 12
'########## BARRIER CODES #######
IF x < 151 AND y < 81 THEN GOTO mcrash3
IF x < 151 AND y > 90 THEN GOTO mcrash3
IF x = 161 THEN GOTO mcrash3
'########## DOOR CODES ##########
IF x = 5 THEN segm = 1: GOTO m3seg4
IF y = 5 THEN segm = 0: GOTO m3seg6
IF y = 185 THEN segm = 0: GOTO m3seg16
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END

m3seg6: CLS '                    >>> SEGMENT #06 <<<
'########## LEVEL #########
LINE (150, 200)-(150, 100), 6
LINE (170, 200)-(170, 80), 6
LINE (150, 100)-(0, 100), 6
LINE (170, 80)-(0, 80), 6
PCOPY 1, 0
'######### PROGRAM ######
IF segm = 0 THEN y = 180
IF segm = 1 THEN x = 10
IF i = 0 THEN stat$ = "Collect Item:"
IF i = 1 THEN stat$ = "Exit Ruin: Got Gem"
DO
press$ = INKEY$
LOCATE 1, 1: COLOR C: PRINT btt$
LOCATE 2, 1: COLOR 9: PRINT stat$
'######## Graphics Code #######
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), crh1, PSET
IF d = 2 THEN PUT (x, y), crv1, PSET
IF d = 3 THEN PUT (x, y), crh2, PSET
IF d = 4 THEN PUT (x, y), crv2, PSET
IF press$ = CHR$(0) + CHR$(75) THEN d = 2
IF press$ = CHR$(0) + CHR$(72) THEN d = 1
IF press$ = CHR$(0) + CHR$(77) THEN d = 4
IF press$ = CHR$(0) + CHR$(80) THEN d = 3
IF press$ = CHR$(0) + CHR$(72) THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(80) THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(75) THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(77) THEN x = x + 1: PLAY "A"
IF press$ = "4" THEN d = 2
IF press$ = "8" THEN d = 1
IF press$ = "2" THEN d = 3
IF press$ = "6" THEN d = 4
IF press$ = "8" THEN y = y - 1: PLAY "A"
IF press$ = "2" THEN y = y + 1: PLAY "A"
IF press$ = "4" THEN x = x - 1: PLAY "A"
IF press$ = "6" THEN x = x + 1: PLAY "A"
'########### BATTERY CODE ############
btt = btt + 1
IF (btt / 100) > 1800 THEN GOTO dbtt3
IF (btt / 100) > 180 THEN btt$ = "Batt: [||||||||| ]": C = 10
IF (btt / 100) > 360 THEN btt$ = "Batt: [||||||||  ]": C = 10
IF (btt / 100) > 540 THEN btt$ = "Batt: [|||||||   ]": C = 10
IF (btt / 100) > 720 THEN btt$ = "Batt: [||||||    ]": C = 14
IF (btt / 100) > 900 THEN btt$ = "Batt: [|||||     ]": C = 14
IF (btt / 100) > 1080 THEN btt$ = "Batt: [||||      ]": C = 14
IF (btt / 100) > 1260 THEN btt$ = "Batt: [|||       ]": C = 12
IF (btt / 100) > 1440 THEN btt$ = "Batt: [||        ]": C = 12
IF (btt / 100) > 1620 THEN btt$ = "Batt: [|         ]": C = 12
'########## BARRIER CODES #######
IF x < 151 AND y > 90 THEN GOTO mcrash3
IF x = 161 OR y = 80 THEN GOTO mcrash3
'########## DOOR CODES ##########
IF y = 185 THEN segm = 1: GOTO m3seg5
IF x = 5 THEN segm = 1: GOTO m3seg7
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END

m3seg7: CLS '                    >>> SEGMENT #07 <<<
'######### LEVEL #############
LINE (0, 80)-(320, 80), 6
LINE (0, 100)-(320, 100), 6
PCOPY 1, 0
'######### PROGRAM ######
IF segm = 0 THEN x = 10
IF segm = 1 THEN x = 300
IF i = 0 THEN stat$ = "Collect Item:"
IF i = 1 THEN stat$ = "Exit Ruin: Got Gem"
DO
press$ = INKEY$
LOCATE 1, 1: COLOR C: PRINT btt$
LOCATE 2, 1: COLOR 9: PRINT stat$
'######## Graphics Code #######
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), crh1, PSET
IF d = 2 THEN PUT (x, y), crv1, PSET
IF d = 3 THEN PUT (x, y), crh2, PSET
IF d = 4 THEN PUT (x, y), crv2, PSET
IF press$ = CHR$(0) + CHR$(75) THEN d = 2
IF press$ = CHR$(0) + CHR$(72) THEN d = 1
IF press$ = CHR$(0) + CHR$(77) THEN d = 4
IF press$ = CHR$(0) + CHR$(80) THEN d = 3
IF press$ = CHR$(0) + CHR$(72) THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(80) THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(75) THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(77) THEN x = x + 1: PLAY "A"
IF press$ = "4" THEN d = 2
IF press$ = "8" THEN d = 1
IF press$ = "2" THEN d = 3
IF press$ = "6" THEN d = 4
IF press$ = "8" THEN y = y - 1: PLAY "A"
IF press$ = "2" THEN y = y + 1: PLAY "A"
IF press$ = "4" THEN x = x - 1: PLAY "A"
IF press$ = "6" THEN x = x + 1: PLAY "A"
'########### BATTERY CODE ############
btt = btt + 1
IF (btt / 100) > 1800 THEN GOTO dbtt3
IF (btt / 100) > 180 THEN btt$ = "Batt: [||||||||| ]": C = 10
IF (btt / 100) > 360 THEN btt$ = "Batt: [||||||||  ]": C = 10
IF (btt / 100) > 540 THEN btt$ = "Batt: [|||||||   ]": C = 10
IF (btt / 100) > 720 THEN btt$ = "Batt: [||||||    ]": C = 14
IF (btt / 100) > 900 THEN btt$ = "Batt: [|||||     ]": C = 14
IF (btt / 100) > 1080 THEN btt$ = "Batt: [||||      ]": C = 14
IF (btt / 100) > 1260 THEN btt$ = "Batt: [|||       ]": C = 12
IF (btt / 100) > 1440 THEN btt$ = "Batt: [||        ]": C = 12
IF (btt / 100) > 1620 THEN btt$ = "Batt: [|         ]": C = 12
'########## BARRIER CODES #######
IF y = 80 OR y = 91 THEN GOTO mcrash3
'########## DOOR CODES #######
IF x = 5 THEN segm = 1: GOTO m3seg8
IF x = 305 THEN segm = 1: GOTO m3seg6
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END

m3seg8: CLS '                    >>> SEGMENT #08 <<<
'######### LEVEL #############
LINE (0, 80)-(320, 80), 6
LINE (0, 100)-(320, 100), 6
PCOPY 1, 0
'######### PROGRAM ######
IF segm = 0 THEN x = 10
IF segm = 1 THEN x = 300
IF i = 0 THEN stat$ = "Collect Item:"
IF i = 1 THEN stat$ = "Exit Ruin: Got Gem"
DO
press$ = INKEY$
LOCATE 1, 1: COLOR C: PRINT btt$
LOCATE 2, 1: COLOR 9: PRINT stat$
'######## Graphics Code #######
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), crh1, PSET
IF d = 2 THEN PUT (x, y), crv1, PSET
IF d = 3 THEN PUT (x, y), crh2, PSET
IF d = 4 THEN PUT (x, y), crv2, PSET
IF press$ = CHR$(0) + CHR$(75) THEN d = 2
IF press$ = CHR$(0) + CHR$(72) THEN d = 1
IF press$ = CHR$(0) + CHR$(77) THEN d = 4
IF press$ = CHR$(0) + CHR$(80) THEN d = 3
IF press$ = CHR$(0) + CHR$(72) THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(80) THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(75) THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(77) THEN x = x + 1: PLAY "A"
IF press$ = "4" THEN d = 2
IF press$ = "8" THEN d = 1
IF press$ = "2" THEN d = 3
IF press$ = "6" THEN d = 4
IF press$ = "8" THEN y = y - 1: PLAY "A"
IF press$ = "2" THEN y = y + 1: PLAY "A"
IF press$ = "4" THEN x = x - 1: PLAY "A"
IF press$ = "6" THEN x = x + 1: PLAY "A"
'########### BATTERY CODE ############
btt = btt + 1
IF (btt / 100) > 1800 THEN GOTO dbtt3
IF (btt / 100) > 180 THEN btt$ = "Batt: [||||||||| ]": C = 10
IF (btt / 100) > 360 THEN btt$ = "Batt: [||||||||  ]": C = 10
IF (btt / 100) > 540 THEN btt$ = "Batt: [|||||||   ]": C = 10
IF (btt / 100) > 720 THEN btt$ = "Batt: [||||||    ]": C = 14
IF (btt / 100) > 900 THEN btt$ = "Batt: [|||||     ]": C = 14
IF (btt / 100) > 1080 THEN btt$ = "Batt: [||||      ]": C = 14
IF (btt / 100) > 1260 THEN btt$ = "Batt: [|||       ]": C = 12
IF (btt / 100) > 1440 THEN btt$ = "Batt: [||        ]": C = 12
IF (btt / 100) > 1620 THEN btt$ = "Batt: [|         ]": C = 12
'########## BARRIER CODES #######
IF y = 80 OR y = 91 THEN GOTO mcrash3
'########## DOOR CODES #######
IF x = 5 THEN segm = 1: GOTO m3seg9
IF x = 305 THEN segm = 0: GOTO m3seg7
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END

m3seg9: CLS '                    >>> SEGMENT #09 <<<
'######### LEVEL ########
LINE (150, 200)-(150, 100), 6
LINE (170, 200)-(170, 100), 6
LINE (0, 100)-(150, 100), 6
LINE (320, 100)-(170, 100), 6
LINE (0, 80)-(320, 80), 6
PCOPY 1, 0
'######### PROGRAM ######
IF segm = 0 THEN y = 180
IF segm = 1 THEN x = 300
IF segm = 2 THEN x = 10
btt$ = "Batt: [||||||||||]": C = 10
IF i = 0 THEN stat$ = "Collect Item:"
IF i = 1 THEN stat$ = "Exit Ruin: Got Gem"
DO
press$ = INKEY$
LOCATE 1, 1: COLOR C: PRINT btt$
LOCATE 2, 1: COLOR 9: PRINT stat$
'######## Graphics Code #######
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), crh1, PSET
IF d = 2 THEN PUT (x, y), crv1, PSET
IF d = 3 THEN PUT (x, y), crh2, PSET
IF d = 4 THEN PUT (x, y), crv2, PSET
IF press$ = CHR$(0) + CHR$(75) THEN d = 2
IF press$ = CHR$(0) + CHR$(72) THEN d = 1
IF press$ = CHR$(0) + CHR$(77) THEN d = 4
IF press$ = CHR$(0) + CHR$(80) THEN d = 3
IF press$ = CHR$(0) + CHR$(72) THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(80) THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(75) THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(77) THEN x = x + 1: PLAY "A"
IF press$ = "4" THEN d = 2
IF press$ = "8" THEN d = 1
IF press$ = "2" THEN d = 3
IF press$ = "6" THEN d = 4
IF press$ = "8" THEN y = y - 1: PLAY "A"
IF press$ = "2" THEN y = y + 1: PLAY "A"
IF press$ = "4" THEN x = x - 1: PLAY "A"
IF press$ = "6" THEN x = x + 1: PLAY "A"
'########### BATTERY CODE ############
btt = btt + 1
IF (btt / 100) > 1800 THEN GOTO dbtt3
IF (btt / 100) > 180 THEN btt$ = "Batt: [||||||||| ]": C = 10
IF (btt / 100) > 360 THEN btt$ = "Batt: [||||||||  ]": C = 10
IF (btt / 100) > 540 THEN btt$ = "Batt: [|||||||   ]": C = 10
IF (btt / 100) > 720 THEN btt$ = "Batt: [||||||    ]": C = 14
IF (btt / 100) > 900 THEN btt$ = "Batt: [|||||     ]": C = 14
IF (btt / 100) > 1080 THEN btt$ = "Batt: [||||      ]": C = 14
IF (btt / 100) > 1260 THEN btt$ = "Batt: [|||       ]": C = 12
IF (btt / 100) > 1440 THEN btt$ = "Batt: [||        ]": C = 12
IF (btt / 100) > 1620 THEN btt$ = "Batt: [|         ]": C = 12
'########## BARRIER CODES #######
IF x < 151 AND y > 90 THEN GOTO mcrash3
IF x > 160 AND y > 90 THEN GOTO mcrash3
IF y = 80 THEN GOTO mcrash3
'########## DOOR CODES ###########
IF y = 185 THEN segm = 0: GOTO m3seg14
IF x = 5 THEN segm = 0: GOTO m3seg10
IF x = 305 THEN segm = 0: GOTO m3seg8
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END

m3seg10: CLS '                   >>> SEGMENT #10 <<<
'######## LEVEL #########
LINE (150, 200)-(150, 80), 6
LINE (150, 80)-(320, 80), 6
LINE (170, 200)-(170, 100), 6
LINE (170, 100)-(320, 100), 6
PCOPY 1, 0
'######### PROGRAM ######
IF segm = 0 THEN x = 300
IF segm = 1 THEN y = 180
IF i = 0 THEN stat$ = "Collect Item:"
IF i = 1 THEN stat$ = "Exit Ruin: Got Gem"
DO
press$ = INKEY$
LOCATE 1, 1: COLOR C: PRINT btt$
LOCATE 2, 1: COLOR 9: PRINT stat$
'######## Graphics Code #######
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), crh1, PSET
IF d = 2 THEN PUT (x, y), crv1, PSET
IF d = 3 THEN PUT (x, y), crh2, PSET
IF d = 4 THEN PUT (x, y), crv2, PSET
IF press$ = CHR$(0) + CHR$(75) THEN d = 2
IF press$ = CHR$(0) + CHR$(72) THEN d = 1
IF press$ = CHR$(0) + CHR$(77) THEN d = 4
IF press$ = CHR$(0) + CHR$(80) THEN d = 3
IF press$ = CHR$(0) + CHR$(72) THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(80) THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(75) THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(77) THEN x = x + 1: PLAY "A"
IF press$ = "4" THEN d = 2
IF press$ = "8" THEN d = 1
IF press$ = "2" THEN d = 3
IF press$ = "6" THEN d = 4
IF press$ = "8" THEN y = y - 1: PLAY "A"
IF press$ = "2" THEN y = y + 1: PLAY "A"
IF press$ = "4" THEN x = x - 1: PLAY "A"
IF press$ = "6" THEN x = x + 1: PLAY "A"
'########### BATTERY CODE ############
btt = btt + 1
IF (btt / 100) > 1800 THEN GOTO dbtt3
IF (btt / 100) > 180 THEN btt$ = "Batt: [||||||||| ]": C = 10
IF (btt / 100) > 360 THEN btt$ = "Batt: [||||||||  ]": C = 10
IF (btt / 100) > 540 THEN btt$ = "Batt: [|||||||   ]": C = 10
IF (btt / 100) > 720 THEN btt$ = "Batt: [||||||    ]": C = 14
IF (btt / 100) > 900 THEN btt$ = "Batt: [|||||     ]": C = 14
IF (btt / 100) > 1080 THEN btt$ = "Batt: [||||      ]": C = 14
IF (btt / 100) > 1260 THEN btt$ = "Batt: [|||       ]": C = 12
IF (btt / 100) > 1440 THEN btt$ = "Batt: [||        ]": C = 12
IF (btt / 100) > 1620 THEN btt$ = "Batt: [|         ]": C = 12
'########## BARRIER CODES #######
IF x = 150 OR y = 80 THEN GOTO mcrash3
IF x > 160 AND y > 90 THEN GOTO mcrash3
'########## DOOR CODES #########
IF y = 185 THEN segm = 1: GOTO m3seg11
IF x = 305 THEN segm = 2: GOTO m3seg9
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END

m3seg11: CLS '                    >>> SEGMENT #11 <<<
'######### LEVEL ########
LINE (150, 200)-(150, 0), 6
LINE (170, 200)-(170, 0), 6
PCOPY 1, 0
'######### PROGRAM ######
IF segm = 0 THEN y = 180
IF segm = 1 THEN y = 10
btt$ = "Batt: [||||||||||]": C = 10
IF i = 0 THEN stat$ = "Collect Item:"
IF i = 1 THEN stat$ = "Exit Ruin: Got Gem"
DO
press$ = INKEY$
LOCATE 1, 1: COLOR C: PRINT btt$
LOCATE 2, 1: COLOR 9: PRINT stat$
'######## Graphics Code #######
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), crh1, PSET
IF d = 2 THEN PUT (x, y), crv1, PSET
IF d = 3 THEN PUT (x, y), crh2, PSET
IF d = 4 THEN PUT (x, y), crv2, PSET
IF press$ = CHR$(0) + CHR$(75) THEN d = 2
IF press$ = CHR$(0) + CHR$(72) THEN d = 1
IF press$ = CHR$(0) + CHR$(77) THEN d = 4
IF press$ = CHR$(0) + CHR$(80) THEN d = 3
IF press$ = CHR$(0) + CHR$(72) THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(80) THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(75) THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(77) THEN x = x + 1: PLAY "A"
IF press$ = "4" THEN d = 2
IF press$ = "8" THEN d = 1
IF press$ = "2" THEN d = 3
IF press$ = "6" THEN d = 4
IF press$ = "8" THEN y = y - 1: PLAY "A"
IF press$ = "2" THEN y = y + 1: PLAY "A"
IF press$ = "4" THEN x = x - 1: PLAY "A"
IF press$ = "6" THEN x = x + 1: PLAY "A"
'########### BATTERY CODE ############
btt = btt + 1
IF (btt / 100) > 1800 THEN GOTO dbtt3
IF y < 184 AND (btt / 100) THEN btt$ = "Batt: [||||||||||]"
IF (btt / 100) > 180 THEN btt$ = "Batt: [||||||||| ]": C = 10
IF (btt / 100) > 360 THEN btt$ = "Batt: [||||||||  ]": C = 10
IF (btt / 100) > 540 THEN btt$ = "Batt: [|||||||   ]": C = 10
IF (btt / 100) > 720 THEN btt$ = "Batt: [||||||    ]": C = 14
IF (btt / 100) > 900 THEN btt$ = "Batt: [|||||     ]": C = 14
IF (btt / 100) > 1080 THEN btt$ = "Batt: [||||      ]": C = 14
IF (btt / 100) > 1260 THEN btt$ = "Batt: [|||       ]": C = 12
IF (btt / 100) > 1440 THEN btt$ = "Batt: [||        ]": C = 12
IF (btt / 100) > 1620 THEN btt$ = "Batt: [|         ]": C = 12
'########## BARRIER CODES #######
IF x = 161 THEN GOTO mcrash3
IF x = 150 THEN GOTO mcrash3
'########## DOOR CODES ##########
IF y = 5 THEN segm = 1: GOTO m3seg10
IF y = 185 THEN segm = 1: GOTO m3seg12
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END

m3seg12: CLS '                   >>> SEGMENT #12 <<<
'######## LEVEL #########
LINE (320, 100)-(150, 100), 6
LINE (320, 80)-(170, 80), 6
LINE (150, 100)-(150, 0), 6
LINE (170, 80)-(170, 0), 6
PCOPY 1, 0
'######### PROGRAM ######
IF segm = 0 THEN x = 300
IF segm = 1 THEN y = 10
IF i = 0 THEN stat$ = "Collect Item:"
IF i = 1 THEN stat$ = "Exit Ruin: Got Gem"
DO
press$ = INKEY$
LOCATE 1, 1: COLOR C: PRINT btt$
LOCATE 2, 1: COLOR 9: PRINT stat$
'######## Graphics Code #######
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), crh1, PSET
IF d = 2 THEN PUT (x, y), crv1, PSET
IF d = 3 THEN PUT (x, y), crh2, PSET
IF d = 4 THEN PUT (x, y), crv2, PSET
IF press$ = CHR$(0) + CHR$(75) THEN d = 2
IF press$ = CHR$(0) + CHR$(72) THEN d = 1
IF press$ = CHR$(0) + CHR$(77) THEN d = 4
IF press$ = CHR$(0) + CHR$(80) THEN d = 3
IF press$ = CHR$(0) + CHR$(72) THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(80) THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(75) THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(77) THEN x = x + 1: PLAY "A"
IF press$ = "4" THEN d = 2
IF press$ = "8" THEN d = 1
IF press$ = "2" THEN d = 3
IF press$ = "6" THEN d = 4
IF press$ = "8" THEN y = y - 1: PLAY "A"
IF press$ = "2" THEN y = y + 1: PLAY "A"
IF press$ = "4" THEN x = x - 1: PLAY "A"
IF press$ = "6" THEN x = x + 1: PLAY "A"
'########### BATTERY CODE ############
btt = btt + 1
IF (btt / 100) > 1800 THEN GOTO dbtt3
IF y < 184 AND (btt / 100) THEN btt$ = "Batt: [||||||||||]"
IF (btt / 100) > 180 THEN btt$ = "Batt: [||||||||| ]": C = 10
IF (btt / 100) > 360 THEN btt$ = "Batt: [||||||||  ]": C = 10
IF (btt / 100) > 540 THEN btt$ = "Batt: [|||||||   ]": C = 10
IF (btt / 100) > 720 THEN btt$ = "Batt: [||||||    ]": C = 14
IF (btt / 100) > 900 THEN btt$ = "Batt: [|||||     ]": C = 14
IF (btt / 100) > 1080 THEN btt$ = "Batt: [||||      ]": C = 14
IF (btt / 100) > 1260 THEN btt$ = "Batt: [|||       ]": C = 12
IF (btt / 100) > 1440 THEN btt$ = "Batt: [||        ]": C = 12
IF (btt / 100) > 1620 THEN btt$ = "Batt: [|         ]": C = 12
'########## BARRIER CODES #######
IF x > 160 AND y < 81 THEN GOTO mcrash3
IF x = 150 OR y = 91 THEN GOTO mcrash3
'########## DOOR CODES ##########
IF x = 305 THEN segm = 1: GOTO m3seg13
IF y = 5 THEN segm = 0: GOTO m3seg11
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END


m3seg13: CLS '                   >>> SEGMENT #13 <<<
'######### LEVEL #############
LINE (0, 80)-(320, 80), 6
LINE (0, 100)-(320, 100), 6
LINE (140, 50)-(180, 150), 6, BF
PCOPY 1, 0
'######### PROGRAM ######
IF segm = 0 THEN x = 300
IF segm = 1 THEN x = 10
IF i = 0 THEN stat$ = "Collect Item:"
IF segm = 0 THEN stat$ = "Passage Blocked:"
IF i = 1 THEN stat$ = "Exit Ruin:Got Item"
DO
press$ = INKEY$
LOCATE 1, 1: COLOR C: PRINT btt$
LOCATE 2, 1: COLOR 9: PRINT stat$
'######## ITEM CODE ###########
IF i = 0 THEN CIRCLE (90, 90), 2, 10: PAINT (90, 90), 10 ELSE CIRCLE (90, 90), 2, 0: PAINT (90, 90), 0
IF i = 0 THEN IF x = 79 OR x = 92 THEN IF y > 84 AND y < 87 THEN i = 1: stat$ = "Exit Ruin:Got Item"
'######## Graphics Code #######
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), crh1, PSET
IF d = 2 THEN PUT (x, y), crv1, PSET
IF d = 3 THEN PUT (x, y), crh2, PSET
IF d = 4 THEN PUT (x, y), crv2, PSET
IF press$ = CHR$(0) + CHR$(75) THEN d = 2
IF press$ = CHR$(0) + CHR$(72) THEN d = 1
IF press$ = CHR$(0) + CHR$(77) THEN d = 4
IF press$ = CHR$(0) + CHR$(80) THEN d = 3
IF press$ = CHR$(0) + CHR$(72) THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(80) THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(75) THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(77) THEN x = x + 1: PLAY "A"
IF press$ = "4" THEN d = 2
IF press$ = "8" THEN d = 1
IF press$ = "2" THEN d = 3
IF press$ = "6" THEN d = 4
IF press$ = "8" THEN y = y - 1: PLAY "A"
IF press$ = "2" THEN y = y + 1: PLAY "A"
IF press$ = "4" THEN x = x - 1: PLAY "A"
IF press$ = "6" THEN x = x + 1: PLAY "A"
'########### BATTERY CODE ############
btt = btt + 1
IF (btt / 100) > 1800 THEN GOTO dbtt3
IF (btt / 100) > 180 THEN btt$ = "Batt: [||||||||| ]": C = 10
IF (btt / 100) > 360 THEN btt$ = "Batt: [||||||||  ]": C = 10
IF (btt / 100) > 540 THEN btt$ = "Batt: [|||||||   ]": C = 10
IF (btt / 100) > 720 THEN btt$ = "Batt: [||||||    ]": C = 14
IF (btt / 100) > 900 THEN btt$ = "Batt: [|||||     ]": C = 14
IF (btt / 100) > 1080 THEN btt$ = "Batt: [||||      ]": C = 14
IF (btt / 100) > 1260 THEN btt$ = "Batt: [|||       ]": C = 12
IF (btt / 100) > 1440 THEN btt$ = "Batt: [||        ]": C = 12
IF (btt / 100) > 1620 THEN btt$ = "Batt: [|         ]": C = 12
'########## BARRIER CODES #######
IF y = 80 OR y = 91 THEN GOTO mcrash3
IF x = 180 OR x = 131 THEN GOTO mcrash3
'########## DOOR CODES #######
IF x = 305 THEN segm = 1: GOTO m3seg2
IF x = 5 THEN segm = 0: GOTO m3seg12
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END

m3seg14: CLS '                    >>> SEGMENT #14 <<<
'######### LEVEL ########
LINE (150, 0)-(150, 80), 6
LINE (170, 0)-(170, 80), 6
LINE (0, 80)-(150, 80), 6
LINE (320, 80)-(170, 80), 6
LINE (0, 100)-(320, 100), 6
PCOPY 1, 0
'######### PROGRAM ######
IF segm = 0 THEN y = 10
IF segm = 1 THEN x = 300
IF i = 0 THEN stat$ = "Collect Item:"
IF i = 1 THEN stat$ = "Exit Ruin: Got Gem"
DO
press$ = INKEY$
LOCATE 1, 1: COLOR C: PRINT btt$
LOCATE 2, 1: COLOR 9: PRINT stat$
'######## Graphics Code #######
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), crh1, PSET
IF d = 2 THEN PUT (x, y), crv1, PSET
IF d = 3 THEN PUT (x, y), crh2, PSET
IF d = 4 THEN PUT (x, y), crv2, PSET
IF press$ = CHR$(0) + CHR$(75) THEN d = 2
IF press$ = CHR$(0) + CHR$(72) THEN d = 1
IF press$ = CHR$(0) + CHR$(77) THEN d = 4
IF press$ = CHR$(0) + CHR$(80) THEN d = 3
IF press$ = CHR$(0) + CHR$(72) THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(80) THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(75) THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(77) THEN x = x + 1: PLAY "A"
IF press$ = "4" THEN d = 2
IF press$ = "8" THEN d = 1
IF press$ = "2" THEN d = 3
IF press$ = "6" THEN d = 4
IF press$ = "8" THEN y = y - 1: PLAY "A"
IF press$ = "2" THEN y = y + 1: PLAY "A"
IF press$ = "4" THEN x = x - 1: PLAY "A"
IF press$ = "6" THEN x = x + 1: PLAY "A"
'########### BATTERY CODE ############
btt = btt + 1
IF (btt / 100) > 1800 THEN GOTO dbtt3
IF (btt / 100) > 180 THEN btt$ = "Batt: [||||||||| ]": C = 10
IF (btt / 100) > 360 THEN btt$ = "Batt: [||||||||  ]": C = 10
IF (btt / 100) > 540 THEN btt$ = "Batt: [|||||||   ]": C = 10
IF (btt / 100) > 720 THEN btt$ = "Batt: [||||||    ]": C = 14
IF (btt / 100) > 900 THEN btt$ = "Batt: [|||||     ]": C = 14
IF (btt / 100) > 1080 THEN btt$ = "Batt: [||||      ]": C = 14
IF (btt / 100) > 1260 THEN btt$ = "Batt: [|||       ]": C = 12
IF (btt / 100) > 1440 THEN btt$ = "Batt: [||        ]": C = 12
IF (btt / 100) > 1620 THEN btt$ = "Batt: [|         ]": C = 12
'########## BARRIER CODES #######
IF x < 151 AND y < 81 THEN GOTO mcrash3
IF x > 160 AND y < 81 THEN GOTO mcrash3
IF y = 91 THEN GOTO mcrash3
IF x = 10 THEN x = 11
'########## DOOR CODES ########
IF x = 305 THEN segm = 0: GOTO m3seg15
IF y = 5 THEN segm = 0: GOTO m3seg9
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END

m3seg15: CLS '                    >>> SEGMENT #15 <<<
'######### LEVEL #############
LINE (0, 80)-(320, 80), 6
LINE (0, 100)-(320, 100), 6
LINE (140, 50)-(180, 150), 6, BF
PCOPY 1, 0
'######### PROGRAM ######
IF segm = 0 THEN x = 10: d = 4
IF segm = 1 THEN x = 299: d = 2
IF i = 0 THEN stat$ = "Passage Blocked:"
IF i = 1 THEN stat$ = "Exit Ruin: Got Gem"
DO
press$ = INKEY$
LOCATE 1, 1: COLOR C: PRINT btt$
LOCATE 2, 1: COLOR 9: PRINT stat$
'######## Graphics Code #######
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), crh1, PSET
IF d = 2 THEN PUT (x, y), crv1, PSET
IF d = 3 THEN PUT (x, y), crh2, PSET
IF d = 4 THEN PUT (x, y), crv2, PSET
IF press$ = CHR$(0) + CHR$(75) THEN d = 2
IF press$ = CHR$(0) + CHR$(72) THEN d = 1
IF press$ = CHR$(0) + CHR$(77) THEN d = 4
IF press$ = CHR$(0) + CHR$(80) THEN d = 3
IF press$ = CHR$(0) + CHR$(72) THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(80) THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(75) THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(77) THEN x = x + 1: PLAY "A"
IF press$ = "4" THEN d = 2
IF press$ = "8" THEN d = 1
IF press$ = "2" THEN d = 3
IF press$ = "6" THEN d = 4
IF press$ = "8" THEN y = y - 1: PLAY "A"
IF press$ = "2" THEN y = y + 1: PLAY "A"
IF press$ = "4" THEN x = x - 1: PLAY "A"
IF press$ = "6" THEN x = x + 1: PLAY "A"
'########### BATTERY CODE ############
btt = btt + 1
IF (btt / 100) > 1800 THEN GOTO dbtt3
IF (btt / 100) > 180 THEN btt$ = "Batt: [||||||||| ]": C = 10
IF (btt / 100) > 360 THEN btt$ = "Batt: [||||||||  ]": C = 10
IF (btt / 100) > 540 THEN btt$ = "Batt: [|||||||   ]": C = 10
IF (btt / 100) > 720 THEN btt$ = "Batt: [||||||    ]": C = 14
IF (btt / 100) > 900 THEN btt$ = "Batt: [|||||     ]": C = 14
IF (btt / 100) > 1080 THEN btt$ = "Batt: [||||      ]": C = 14
IF (btt / 100) > 1260 THEN btt$ = "Batt: [|||       ]": C = 12
IF (btt / 100) > 1440 THEN btt$ = "Batt: [||        ]": C = 12
IF (btt / 100) > 1620 THEN btt$ = "Batt: [|         ]": C = 12
'########## BARRIER CODES #######
IF y = 80 OR y = 91 THEN GOTO mcrash3
IF x = 180 OR x = 131 THEN GOTO mcrash3
'########## DOOR CODES #######
IF x = 5 THEN segm = 1: GOTO m3seg14
IF x = 305 THEN segm = 2: GOTO m3seg4
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END

m3seg16: CLS '               >>> SEGMENT #16 <<<
'######## LEVEL #########
LINE (0, 80)-(150, 80), 6
LINE (150, 80)-(150, 0), 6
LINE (0, 100)-(170, 100), 6
LINE (170, 100)-(170, 0), 6
LINE (0, 50)-(35, 150), 6, BF
PCOPY 1, 0
'######### PROGRAM ######
IF segm = 0 THEN y = 10
IF i = 0 THEN stat$ = "Passage Blocked:"
IF i = 1 THEN stat$ = "Exit Ruin: Got Gem"
DO
press$ = INKEY$
LOCATE 1, 1: COLOR C: PRINT btt$
LOCATE 2, 1: COLOR 9: PRINT stat$
'######## Graphics Code #######
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), crh1, PSET
IF d = 2 THEN PUT (x, y), crv1, PSET
IF d = 3 THEN PUT (x, y), crh2, PSET
IF d = 4 THEN PUT (x, y), crv2, PSET
IF press$ = CHR$(0) + CHR$(75) THEN d = 2
IF press$ = CHR$(0) + CHR$(72) THEN d = 1
IF press$ = CHR$(0) + CHR$(77) THEN d = 4
IF press$ = CHR$(0) + CHR$(80) THEN d = 3
IF press$ = CHR$(0) + CHR$(72) THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(80) THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(75) THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(77) THEN x = x + 1: PLAY "A"
IF press$ = "4" THEN d = 2
IF press$ = "8" THEN d = 1
IF press$ = "2" THEN d = 3
IF press$ = "6" THEN d = 4
IF press$ = "8" THEN y = y - 1: PLAY "A"
IF press$ = "2" THEN y = y + 1: PLAY "A"
IF press$ = "4" THEN x = x - 1: PLAY "A"
IF press$ = "6" THEN x = x + 1: PLAY "A"
'########### BATTERY CODE ############
btt = btt + 1
IF (btt / 100) > 1800 THEN GOTO dbtt3
IF (btt / 100) > 180 THEN btt$ = "Batt: [||||||||| ]": C = 10
IF (btt / 100) > 360 THEN btt$ = "Batt: [||||||||  ]": C = 10
IF (btt / 100) > 540 THEN btt$ = "Batt: [|||||||   ]": C = 10
IF (btt / 100) > 720 THEN btt$ = "Batt: [||||||    ]": C = 14
IF (btt / 100) > 900 THEN btt$ = "Batt: [|||||     ]": C = 14
IF (btt / 100) > 1080 THEN btt$ = "Batt: [||||      ]": C = 14
IF (btt / 100) > 1260 THEN btt$ = "Batt: [|||       ]": C = 12
IF (btt / 100) > 1440 THEN btt$ = "Batt: [||        ]": C = 12
IF (btt / 100) > 1620 THEN btt$ = "Batt: [|         ]": C = 12
'########## BARRIER CODES #######
IF x < 151 AND y < 81 THEN GOTO mcrash3
IF x = 161 OR y = 91 THEN GOTO mcrash3
IF x = 35 THEN GOTO mcrash3
'########## DOOR CODES #########
IF y = 5 THEN segm = 2: GOTO m3seg5
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END

mfinish3: CLS
COLOR 10
PRINT " You completed the mission!"
PRINT
PRINT " Now for the next one!"
PRINT
COLOR 9
PRINT
PRINT " This level's code is: SUBRUINS"
PRINT " Next level's code is: TOWER"
PRINT
PRINT " Press SPACEBAR to continue..."
PCOPY 1, 0
DO
press$ = INKEY$
LOOP UNTIL press$ = " "
CLS
SCREEN 13
CALL Menu7

dbtt3: CLS
COLOR 14
PRINT " Your battery ran out!"
PRINT
PRINT " Esc. = Exit| Try again?"
PRINT
COLOR 9
PRINT
PRINT " This level's code is: SUBRUINS"
PRINT " Next level's code is: >>did not pass<<"
PRINT
PRINT " Press SPACEBAR to Retry..."
PCOPY 1, 0
btt = 0
DO
press$ = INKEY$
IF press$ = CHR$(27) THEN END
LOOP UNTIL press$ = " "
segm = 0
GOTO m3seg1

mcrash3: CLS
COLOR 12
PRINT " You Crashed My Robot!"
PRINT
PRINT " Sorry, You are fired!"
PRINT
COLOR 9
PRINT
PRINT " This level's code is: SUBRUINS"
PRINT " Next level's code is: >>did not pass<<"
PRINT
PRINT " Press SPACEBAR to continue..."
PCOPY 1, 0
DO
press$ = INKEY$
LOOP UNTIL press$ = " "
CLS
SCREEN 13
CALL Menu

END SUB

SUB Mission04
SCREEN 7, 0, 1, 0
DIM drh1(100), drh2(100), drv1(100), drv2(100), mask(100)
PLAY "MB L64 <<<"
COLOR 15
PRINT " Mission Status:"
PRINT
PRINT "      Mission 4: I was successful in"
PRINT " retreaving the third gem. But I was "
PRINT " ambushed, and the gem stolen. It did"
PRINT " not go far. It was taken by the     "
PRINT " Peditron Science Lab. Never fear,   "
PRINT " you're getting it back with the help"
PRINT " of 'Drop Bot'. He can take on the   "
PRINT " air-ducks to the lab where the gem  "
PRINT " is being held. Get in and out fast, "
PRINT " I don't want my tecnology in their  "
PRINT " hands. Good luck!"
PRINT
COLOR 9
PRINT "  NOTE: You have Three Minutes to get"
PRINT "        in and out undetected!"
PRINT
PRINT
COLOR 10
PRINT " Press SPACEBAR to continue..."
PCOPY 1, 0
DO
press$ = INKEY$
LOOP UNTIL press$ = " "
CLS
'######### ROBOT ##########
LINE (1, 1)-(2, 10), 8, BF
LINE (10, 1)-(9, 10), 8, BF
LINE (3, 2)-(8, 9), 12, BF
LINE (5, 5)-(6, 6), 7, BF
PSET (4, 1), 7: PSET (7, 1), 7
PCOPY 1, 0
GET (1, 1)-(10, 10), drh1
CLS
LINE (1, 1)-(2, 10), 8, BF
LINE (10, 1)-(9, 10), 8, BF
LINE (3, 2)-(8, 9), 12, BF
LINE (5, 5)-(6, 4), 7, BF
PSET (4, 10), 7: PSET (7, 10), 7
PCOPY 1, 0
GET (1, 1)-(10, 10), drh2
CLS
LINE (1, 1)-(10, 2), 8, BF
LINE (1, 10)-(10, 9), 8, BF
LINE (2, 3)-(9, 8), 12, BF
LINE (5, 5)-(6, 6), 7, BF
PSET (1, 4), 7: PSET (1, 7), 7
GET (1, 1)-(10, 10), drv1
PCOPY 1, 0
CLS
LINE (1, 1)-(10, 2), 8, BF
LINE (1, 10)-(10, 9), 8, BF
LINE (2, 3)-(9, 8), 12, BF
LINE (5, 5)-(4, 6), 7, BF
PSET (10, 4), 7: PSET (10, 7), 7
GET (1, 1)-(10, 10), drv2
PCOPY 1, 0
CLS
GET (1, 1)-(10, 10), mask
m4seg1: CLS '                  >>> SEGMENT #01 <<<
'######## LEVEL ########
LINE (2, 20)-(310, 190), 7, B
LINE (20, 30)-(40, 50), 7, B
LINE (20, 30)-(25, 35), 7: LINE (40, 30)-(35, 35), 7
LINE (25, 35)-(35, 35), 7
LINE (25, 35)-(25, 50), 7: LINE (35, 35)-(35, 50), 7
PCOPY 1, 0
'######### PROGRAM ######
IF segm = 0 THEN x = 290: y = 180: d = 1
IF segm = 1 THEN x = 26: y = 60: d = 3
btt$ = "Time: [||||||||||]": C = 10
IF i = 0 THEN stat$ = "Collect Item:"
IF i = 1 THEN stat$ = "Press SPACEBAR to pick up bot:"
DO
press$ = INKEY$
LOCATE 1, 1: COLOR C: PRINT btt$
LOCATE 2, 1: COLOR 9: PRINT stat$
'######## Graphics Code #######
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), drh1, PSET
IF d = 2 THEN PUT (x, y), drv1, PSET
IF d = 3 THEN PUT (x, y), drh2, PSET
IF d = 4 THEN PUT (x, y), drv2, PSET
IF press$ = CHR$(0) + CHR$(75) THEN d = 2
IF press$ = CHR$(0) + CHR$(72) THEN d = 1
IF press$ = CHR$(0) + CHR$(77) THEN d = 4
IF press$ = CHR$(0) + CHR$(80) THEN d = 3
IF press$ = CHR$(0) + CHR$(72) THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(80) THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(75) THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(77) THEN x = x + 1: PLAY "A"
IF press$ = "4" THEN d = 2
IF press$ = "8" THEN d = 1
IF press$ = "2" THEN d = 3
IF press$ = "6" THEN d = 4
IF press$ = "8" THEN y = y - 1: PLAY "A"
IF press$ = "2" THEN y = y + 1: PLAY "A"
IF press$ = "4" THEN x = x - 1: PLAY "A"
IF press$ = "6" THEN x = x + 1: PLAY "A"
IF i = 1 THEN IF press$ = " " THEN GOTO mfinish4
'########### THREE MIN CODE ############
btt = btt + 1
IF (btt / 100) > 180 THEN GOTO dbtt4
IF y < 184 AND (btt / 100) THEN btt$ = "Time: [||||||||||]"
IF (btt / 100) > 18 THEN btt$ = "Time: [||||||||| ]": C = 10
IF (btt / 100) > 36 THEN btt$ = "Time: [||||||||  ]": C = 10
IF (btt / 100) > 54 THEN btt$ = "Time: [|||||||   ]": C = 10
IF (btt / 100) > 72 THEN btt$ = "Time: [||||||    ]": C = 14
IF (btt / 100) > 90 THEN btt$ = "Time: [|||||     ]": C = 14
IF (btt / 100) > 108 THEN btt$ = "Time: [||||      ]": C = 14
IF (btt / 100) > 125 THEN btt$ = "Time: [|||       ]": C = 12
IF (btt / 100) > 144 THEN btt$ = "Time: [||        ]": C = 12
IF (btt / 100) > 162 THEN btt$ = "Time: [|         ]": C = 12
'########## BARRIER CODES #######
IF y = 181 OR y = 20 THEN GOTO mcrash4
IF x = 301 OR x = 2 THEN GOTO mcrash4
'########## DOOR CODES ##########
IF x > 10 AND x < 41 THEN IF y = 21 OR y = 50 THEN segm = 0: GOTO m4seg2
IF x = 40 OR x = 11 THEN IF y > 21 AND y < 51 THEN segm = 0: GOTO m4seg2
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END

m4seg2: CLS '                  >>> SEGMENT #02 <<<
'######## LEVEL ########
LINE (2, 20)-(2, 190), 7
LINE (22, 20)-(22, 50), 7
LINE (2, 20)-(22, 20), 7
LINE (22, 70)-(22, 170), 7
LINE (22, 70)-(280, 70), 7
LINE (280, 70)-(280, 170), 7
LINE (2, 190)-(300, 190), 7
LINE (300, 190)-(300, 50), 7
LINE (300, 50)-(22, 50), 7
LINE (22, 170)-(150, 170), 7
LINE (280, 170)-(170, 170), 7
LINE (150, 170)-(150, 100), 7
LINE (170, 170)-(170, 100), 7
LINE (150, 100)-(170, 100), 7
'**DOOR**
LINE (150, 100)-(155, 105), 7
LINE (170, 100)-(165, 105), 7
LINE (150, 120)-(170, 120), 7
LINE (150, 120)-(155, 115), 7
LINE (170, 120)-(165, 115), 7
LINE (155, 105)-(165, 115), 7, B
PCOPY 1, 0
'######### PROGRAM ######
IF segm = 0 THEN x = 8: y = 35: d = 3
IF segm = 1 THEN x = 155: y = 125: d = 3
btt$ = "Time: [||||||||||]": C = 10
IF i = 0 THEN stat$ = "Collect Item:"
IF i = 1 THEN stat$ = "Get Out Quick:"
DO
press$ = INKEY$
LOCATE 1, 1: COLOR C: PRINT btt$
LOCATE 2, 1: COLOR 9: PRINT stat$
'######## Graphics Code #######
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), drh1, PSET
IF d = 2 THEN PUT (x, y), drv1, PSET
IF d = 3 THEN PUT (x, y), drh2, PSET
IF d = 4 THEN PUT (x, y), drv2, PSET
IF press$ = CHR$(0) + CHR$(75) THEN d = 2
IF press$ = CHR$(0) + CHR$(72) THEN d = 1
IF press$ = CHR$(0) + CHR$(77) THEN d = 4
IF press$ = CHR$(0) + CHR$(80) THEN d = 3
IF press$ = CHR$(0) + CHR$(72) THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(80) THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(75) THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(77) THEN x = x + 1: PLAY "A"
IF press$ = "4" THEN d = 2
IF press$ = "8" THEN d = 1
IF press$ = "2" THEN d = 3
IF press$ = "6" THEN d = 4
IF press$ = "8" THEN y = y - 1: PLAY "A"
IF press$ = "2" THEN y = y + 1: PLAY "A"
IF press$ = "4" THEN x = x - 1: PLAY "A"
IF press$ = "6" THEN x = x + 1: PLAY "A"
'########### THREE MIN CODE ############
btt = btt + 1
IF (btt / 100) > 180 THEN GOTO dbtt4
IF (btt / 100) > 18 THEN btt$ = "Time: [||||||||| ]": C = 10
IF (btt / 100) > 36 THEN btt$ = "Time: [||||||||  ]": C = 10
IF (btt / 100) > 54 THEN btt$ = "Time: [|||||||   ]": C = 10
IF (btt / 100) > 72 THEN btt$ = "Time: [||||||    ]": C = 14
IF (btt / 100) > 90 THEN btt$ = "Time: [|||||     ]": C = 14
IF (btt / 100) > 108 THEN btt$ = "Time: [||||      ]": C = 14
IF (btt / 100) > 125 THEN btt$ = "Time: [|||       ]": C = 12
IF (btt / 100) > 144 THEN btt$ = "Time: [||        ]": C = 12
IF (btt / 100) > 162 THEN btt$ = "Time: [|         ]": C = 12
'########## BARRIER CODES #######
IF y = 181 OR y = 20 THEN GOTO mcrash4
IF x = 301 OR x = 2 THEN GOTO mcrash4
IF x = 13 THEN IF y > 20 AND y < 51 THEN GOTO mcrash4
IF y = 50 THEN IF x > 12 AND x < 300 THEN GOTO mcrash4
IF y = 61 THEN IF x > 12 AND x < 280 THEN GOTO mcrash4
IF x = 13 THEN IF y > 60 AND y < 171 THEN GOTO mcrash4
IF x = 280 THEN IF y > 60 AND y < 171 THEN GOTO mcrash4
IF y = 170 THEN IF x > 160 AND x < 281 THEN GOTO mcrash4
IF y = 170 THEN IF x > 12 AND x < 151 THEN GOTO mcrash4
IF x = 150 THEN IF y > 100 AND y < 171 THEN GOTO mcrash4
IF x = 161 THEN IF y > 100 AND y < 171 THEN GOTO mcrash4
'########## DOOR CODES ##########
IF y = 25 THEN segm = 1: GOTO m4seg1
IF y = 120 THEN IF x > 150 AND x < 161 THEN segm = 0: GOTO m4seg3
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END

m4seg3: CLS '                       >>> SEGMENT #03 <<<
'######## LEVEL ########
LINE (130, 100)-(190, 190), 6, B
LINE (3, 100)-(53, 190), 6, B
LINE (299, 100)-(249, 190), 6, B
LINE (2, 20)-(300, 190), 7, B
PCOPY 1, 0
'######### PROGRAM ######
IF segm = 0 THEN x = 155: y = 120: d = 3
btt$ = "Time: [||||||||||]": C = 10
IF i = 0 THEN stat$ = "Collect Item:"
IF i = 1 THEN stat$ = "Get Out Quick:"
DO
press$ = INKEY$
LOCATE 1, 1: COLOR C: PRINT btt$
LOCATE 2, 1: COLOR 9: PRINT stat$
'######## ITEM CODE ########
IF i = 0 THEN CIRCLE (160, 180), 2, 14: PAINT (160, 180), 14 ELSE CIRCLE (160, 180), 2, 0: PAINT (160, 180), 0
IF i = 0 THEN IF x > 154 AND x < 157 AND y = 169 THEN i = 1: stat$ = "Get Out Quick:"
IF i = 0 THEN IF y > 174 AND y < 177 THEN IF x = 162 OR x = 149 THEN i = 1: stat$ = "Get Out Quick:"
'######## Graphics Code #######
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), drh1, PSET
IF d = 2 THEN PUT (x, y), drv1, PSET
IF d = 3 THEN PUT (x, y), drh2, PSET
IF d = 4 THEN PUT (x, y), drv2, PSET
IF press$ = CHR$(0) + CHR$(75) THEN d = 2
IF press$ = CHR$(0) + CHR$(72) THEN d = 1
IF press$ = CHR$(0) + CHR$(77) THEN d = 4
IF press$ = CHR$(0) + CHR$(80) THEN d = 3
IF press$ = CHR$(0) + CHR$(72) THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(80) THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(75) THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(77) THEN x = x + 1: PLAY "A"
IF press$ = "4" THEN d = 2
IF press$ = "8" THEN d = 1
IF press$ = "2" THEN d = 3
IF press$ = "6" THEN d = 4
IF press$ = "8" THEN y = y - 1: PLAY "A"
IF press$ = "2" THEN y = y + 1: PLAY "A"
IF press$ = "4" THEN x = x - 1: PLAY "A"
IF press$ = "6" THEN x = x + 1: PLAY "A"
'########### THREE MIN CODE ############
btt = btt + 1
IF (btt / 100) > 180 THEN GOTO dbtt4
IF (btt / 100) > 18 THEN btt$ = "Time: [||||||||| ]": C = 10
IF (btt / 100) > 36 THEN btt$ = "Time: [||||||||  ]": C = 10
IF (btt / 100) > 54 THEN btt$ = "Time: [|||||||   ]": C = 10
IF (btt / 100) > 72 THEN btt$ = "Time: [||||||    ]": C = 14
IF (btt / 100) > 90 THEN btt$ = "Time: [|||||     ]": C = 14
IF (btt / 100) > 108 THEN btt$ = "Time: [||||      ]": C = 14
IF (btt / 100) > 125 THEN btt$ = "Time: [|||       ]": C = 12
IF (btt / 100) > 144 THEN btt$ = "Time: [||        ]": C = 12
IF (btt / 100) > 162 THEN btt$ = "Time: [|         ]": C = 12
'########## BARRIER CODES #######
IF y = 181 OR y = 20 THEN GOTO mcrash4
IF x = 130 OR x = 181 THEN GOTO mcrash4
'########## DOOR CODES ##########
IF y = 105 THEN segm = 1: GOTO m4seg2
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END

mfinish4: CLS
COLOR 10
PRINT " You completed the mission!"
PRINT
PRINT " Now for the next one!"
PRINT
COLOR 9
PRINT
PRINT " This level's code is: TOWER"
PRINT " Next level's code is: WALLDRILL"
PRINT
PRINT " Press SPACEBAR to continue..."
PCOPY 1, 0
DO
press$ = INKEY$
LOOP UNTIL press$ = " "
CLS
SCREEN 13
CALL Menu8


dbtt4: CLS
COLOR 12
PRINT " You Lost My Robot!"
PRINT
PRINT " Sorry, You are fired!"
PRINT
COLOR 9
PRINT
PRINT " This level's code is: TOWER"
PRINT " Next level's code is: >>did not pass<<"
PRINT
PRINT " Press SPACEBAR to continue..."
PCOPY 1, 0
DO
press$ = INKEY$
LOOP UNTIL press$ = " "
CLS
SCREEN 13
CALL Menu

END

mcrash4: CLS
COLOR 12
PRINT " You Crashed My Robot!"
PRINT
PRINT " Sorry, You are fired!"
PRINT
COLOR 9
PRINT
PRINT " This level's code is: TOWER"
PRINT " Next level's code is: >>did not pass<<"
PRINT
PRINT " Press SPACEBAR to continue..."
PCOPY 1, 0
DO
press$ = INKEY$
LOOP UNTIL press$ = " "
CLS
SCREEN 13
CALL Menu

END SUB

SUB Mission05
SCREEN 7, 0, 1, 0
DIM dbh1(100), dbh2(100), dbv1(100), dbv2(100), mask(100)
PLAY "MB L64 <<<"
COLOR 15
PRINT " Mission Status:"
PRINT
PRINT "      Mission 5: You're next mission "
PRINT " takes you back to a pyramid, but    "
PRINT " this time a 1-inch thick wall is    "
PRINT " keeping you from our goal. Have no  "
PRINT " fear, I have designed a drilling bot"
PRINT " just right for the job. 'Drill-Bot' "
PRINT " is its model name. You activate the "
PRINT " drill by pressing the PageUp. But"
PRINT " be careful, the drill burns the     "
PRINT " battery faster. So turn it on only  "
PRINT " when you're going to drill the wall."
PRINT
COLOR 9
PRINT " PS: Pressing PageDown turns off the "
PRINT "     Drill"
PRINT
PRINT
COLOR 10
PRINT " Press SPACEBAR to continue..."
PCOPY 1, 0
DO
press$ = INKEY$
LOOP UNTIL press$ = " "
CLS
'######### ROBOT ##########
LINE (1, 4)-(2, 10), 8, BF
LINE (10, 4)-(9, 10), 8, BF
LINE (3, 4)-(8, 9), 9, BF
LINE (2, 3)-(9, 3), 7: LINE (2, 3)-(5, 1), 7: LINE (9, 3)-(7, 1), 7
PSET (6, 1), 7
PAINT (5, 2), 7
PCOPY 1, 0
GET (1, 1)-(10, 10), dbh1
CLS
LINE (1, 1)-(2, 7), 8, BF
LINE (10, 1)-(9, 7), 8, BF
LINE (3, 2)-(8, 7), 9, BF
LINE (2, 8)-(9, 8), 7: LINE (2, 8)-(5, 10), 7: LINE (9, 8)-(7, 10), 7
PSET (6, 10), 7: PAINT (5, 9), 7
PCOPY 1, 0
GET (1, 1)-(10, 10), dbh2
CLS
LINE (4, 1)-(10, 2), 8, BF
LINE (4, 10)-(10, 9), 8, BF
LINE (4, 3)-(9, 8), 9, BF
LINE (3, 2)-(3, 9), 7: LINE (3, 2)-(1, 5), 7: LINE (3, 9)-(1, 6), 7
PAINT (2, 5), 7
GET (1, 1)-(10, 10), dbv1
PCOPY 1, 0
CLS
LINE (1, 1)-(7, 2), 8, BF
LINE (1, 10)-(7, 9), 8, BF
LINE (2, 3)-(7, 8), 9, BF
LINE (8, 2)-(8, 9), 7: LINE (8, 2)-(10, 5), 7: LINE (8, 9)-(10, 7), 7
PSET (10, 6), 7: PAINT (9, 5), 7
GET (1, 1)-(10, 10), dbv2
PCOPY 1, 0
CLS
GET (1, 1)-(10, 10), mask
m5seg1: CLS
'######## LEVEL ######
LINE (150, 10)-(150, 200), 12
LINE (170, 10)-(170, 200), 12
LINE (150, 10)-(170, 10), 12
LINE (150, 100)-(170, 100), 12
PCOPY 1, 0
'######### PROGRAM ######
x = 155: y = 180: d = 1
btt$ = "Batt: [||||||||||]": C = 10
IF i = 0 THEN stat$ = "Collect Item:"
IF i = 1 THEN stat$ = "Exit Pyramid:"
DO
press$ = INKEY$
LOCATE 1, 1: COLOR C: PRINT btt$
LOCATE 2, 1: COLOR 9: PRINT stat$
'######## ITEM CODE ###########
IF i = 0 THEN CIRCLE (160, 16), 2, 13: PAINT (160, 16), 13 ELSE CIRCLE (160, 16), 2, 0: PAINT (160, 16), 0
IF x > 153 AND x < 159 AND y = 18 THEN i = 1: stat$ = "Exit Pyramid:"
'######## Graphics Code #######
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), dbh1, PSET
IF d = 2 THEN PUT (x, y), dbv1, PSET
IF d = 3 THEN PUT (x, y), dbh2, PSET
IF d = 4 THEN PUT (x, y), dbv2, PSET
IF press$ = CHR$(0) + CHR$(75) THEN d = 2
IF press$ = CHR$(0) + CHR$(72) THEN d = 1
IF press$ = CHR$(0) + CHR$(77) THEN d = 4
IF press$ = CHR$(0) + CHR$(80) THEN d = 3
IF press$ = CHR$(0) + CHR$(72) THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(80) THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(75) THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(77) THEN x = x + 1: PLAY "A"
IF press$ = "4" THEN d = 2
IF press$ = "8" THEN d = 1
IF press$ = "2" THEN d = 3
IF press$ = "6" THEN d = 4
IF press$ = "8" THEN y = y - 1: PLAY "A"
IF press$ = "2" THEN y = y + 1: PLAY "A"
IF press$ = "4" THEN x = x - 1: PLAY "A"
IF press$ = "6" THEN x = x + 1: PLAY "A"
IF press$ = CHR$(0) + "I" THEN dr = 1
IF press$ = CHR$(0) + "Q" THEN dr = 0
'########### DRILL CODE ##############
IF dr = 1 THEN btt = btt + 100
IF y = 101 AND dr = 1 THEN w = 1
'########### BATTERY CODE ############
btt = btt + 1
IF (btt / 100) > 1800 THEN GOTO dbtt5
IF y < 184 AND (btt / 100) THEN btt$ = "Batt: [||||||||||]"
IF (btt / 100) > 180 THEN btt$ = "Batt: [||||||||| ]": C = 10
IF (btt / 100) > 360 THEN btt$ = "Batt: [||||||||  ]": C = 10
IF (btt / 100) > 540 THEN btt$ = "Batt: [|||||||   ]": C = 10
IF (btt / 100) > 720 THEN btt$ = "Batt: [||||||    ]": C = 14
IF (btt / 100) > 900 THEN btt$ = "Batt: [|||||     ]": C = 14
IF (btt / 100) > 1080 THEN btt$ = "Batt: [||||      ]": C = 14
IF (btt / 100) > 1260 THEN btt$ = "Batt: [|||       ]": C = 12
IF (btt / 100) > 1440 THEN btt$ = "Batt: [||        ]": C = 12
IF (btt / 100) > 1620 THEN btt$ = "Batt: [|         ]": C = 12
'########## BARRIER CODES #######
IF x = 161 THEN GOTO mcrash5
IF x = 150 THEN GOTO mcrash5
IF y = 10 THEN GOTO mcrash5
IF w = 0 AND y = 100 THEN GOTO mcrash5
'########## DOOR CODES ##########
IF i = 0 AND y = 185 THEN y = 184: stat$ = "Not Finished "' ELSE GOTO mfinish3
IF i = 0 AND y < 184 THEN stat$ = "Collect Item:"
IF i = 0 AND dr = 1 THEN stat$ = "  Drill On!!!"
IF i = 1 AND y = 185 THEN GOTO mfinish5
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END

mfinish5: CLS
COLOR 10
PRINT " You completed the mission!"
PRINT
PRINT " Now for the last one!"
PRINT
COLOR 9
PRINT
PRINT " This level's code is: WALLDRILL"
PRINT " Next level's code is: AMAZEME"
PRINT
PRINT " Press SPACEBAR to continue..."
PCOPY 1, 0
DO
press$ = INKEY$
LOOP UNTIL press$ = " "
CLS
SCREEN 13
CALL Menu9

END

dbtt5: CLS
COLOR 14
PRINT " Your battery ran out!"
PRINT
PRINT " Esc. = Exit| Try again?"
PRINT
COLOR 9
PRINT
PRINT " This level's code is: WALLDRILL"
PRINT " Next level's code is: >>did not pass<<"
PRINT
PRINT " Press SPACEBAR to Retry..."
PCOPY 1, 0
btt = 0
DO
press$ = INKEY$
IF press$ = CHR$(27) THEN END
LOOP UNTIL press$ = " "
segm = 0: dr = 0
GOTO m5seg1
END

mcrash5: CLS
COLOR 12
PRINT " You Crashed My Robot!"
PRINT
PRINT " Sorry, You are fired!"
PRINT
COLOR 9
PRINT
PRINT " This level's code is: WALLDRILL"
PRINT " Next level's code is: >>did not pass<<"
PRINT
PRINT " Press SPACEBAR to continue..."
PCOPY 1, 0
DO
press$ = INKEY$
LOOP UNTIL press$ = " "
CLS
SCREEN 13
CALL Menu


END
END SUB

SUB Mission06
CLS
SCREEN 7, 0, 1, 0
PLAY "MB L64 <<<"
DIM sch1(100), sch2(100), scv1(100), scv2(100), mask(100)
PLAY "MB L64 <<<"
COLOR 15
PRINT " Mission Status:"
PRINT
PRINT "      Mission 6: I have the location"
PRINT " of the last gem. It has shown up in"
PRINT " a cave which seems to be a maze of "
PRINT " rooms. You're piloting Scorpian again"
PRINT " to collect the gem. Keep in mind the"
PRINT " the 30 minute battery life. Also keep"
PRINT " mind that this maze of rooms are quite"
PRINT " complex. So keep up with where you are"
PRINT " going. Good luck!"
PRINT
PRINT
PRINT
PRINT
COLOR 10
PRINT " Press SPACEBAR to continue..."
PCOPY 1, 0
DO
press$ = INKEY$
LOOP UNTIL press$ = " "

CLS
'############# ROBOT ##########
LINE (1, 1)-(2, 10), 8, BF
LINE (10, 1)-(9, 10), 8, BF
LINE (3, 2)-(8, 9), 14, BF
LINE (5, 1)-(6, 7), 12, BF
LINE (5, 5)-(6, 8), 4, BF
PCOPY 1, 0
GET (1, 1)-(10, 10), sch1
CLS
LINE (1, 1)-(2, 10), 8, BF
LINE (10, 1)-(9, 10), 8, BF
LINE (3, 2)-(8, 9), 14, BF
LINE (5, 3)-(6, 10), 12, BF
LINE (5, 7)-(6, 10), 4, BF
PCOPY 1, 0
GET (1, 1)-(10, 10), sch2
CLS
LINE (1, 1)-(10, 2), 8, BF
LINE (1, 10)-(10, 9), 8, BF
LINE (2, 3)-(9, 8), 14, BF
LINE (1, 5)-(7, 6), 12, BF
LINE (5, 5)-(8, 6), 4, BF
GET (1, 1)-(10, 10), scv1
PCOPY 1, 0
CLS
LINE (1, 1)-(10, 2), 8, BF
LINE (1, 10)-(10, 9), 8, BF
LINE (2, 3)-(9, 8), 14, BF
LINE (3, 5)-(10, 6), 12, BF
LINE (7, 5)-(10, 6), 4, BF
GET (1, 1)-(10, 10), scv2
PCOPY 1, 0
CLS
GET (1, 1)-(10, 10), mask
PCOPY 1, 0

m6seg1: CLS '                  >>> SEGMENT #01 <<<
'######### LEVEL ###########
LINE (5, 20)-(5, 190), 14
LINE (5, 190)-(310, 190), 14
LINE (310, 190)-(310, 20), 14
LINE (5, 20)-(310, 20), 14
LINE (5, 30)-(5, 60), 0: LINE (310, 30)-(310, 60), 0
LINE (140, 190)-(170, 190), 0
PCOPY 1, 0
'######### PROGRAM ######
IF segm = 0 THEN x = 150: y = 175: d = 1
IF segm = 1 THEN x = 290
IF segm = 2 THEN x = 10
btt$ = "Batt: [||||||||||]": C = 10
IF i = 0 THEN stat$ = "Collect Item:"
IF i = 1 THEN stat$ = "Exit Cave:Got Item"
DO
press$ = INKEY$
LOCATE 1, 1: COLOR C: PRINT btt$
LOCATE 2, 1: COLOR 9: PRINT stat$
'######## Graphics Code #######
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), sch1, PSET
IF d = 2 THEN PUT (x, y), scv1, PSET
IF d = 3 THEN PUT (x, y), sch2, PSET
IF d = 4 THEN PUT (x, y), scv2, PSET
IF press$ = CHR$(0) + CHR$(75) THEN d = 2
IF press$ = CHR$(0) + CHR$(72) THEN d = 1
IF press$ = CHR$(0) + CHR$(77) THEN d = 4
IF press$ = CHR$(0) + CHR$(80) THEN d = 3
IF press$ = CHR$(0) + CHR$(72) THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(80) THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(75) THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(77) THEN x = x + 1: PLAY "A"
IF press$ = "4" THEN d = 2
IF press$ = "8" THEN d = 1
IF press$ = "2" THEN d = 3
IF press$ = "6" THEN d = 4
IF press$ = "8" THEN y = y - 1: PLAY "A"
IF press$ = "2" THEN y = y + 1: PLAY "A"
IF press$ = "4" THEN x = x - 1: PLAY "A"
IF press$ = "6" THEN x = x + 1: PLAY "A"
'########### BATTERY CODE ############
btt = btt + 1
IF (btt / 100) > 1800 THEN GOTO dbtt6
IF y < 189 AND (btt / 100) THEN btt$ = "Batt: [||||||||||]"
IF (btt / 100) > 180 THEN btt$ = "Batt: [||||||||| ]": C = 10
IF (btt / 100) > 360 THEN btt$ = "Batt: [||||||||  ]": C = 10
IF (btt / 100) > 540 THEN btt$ = "Batt: [|||||||   ]": C = 10
IF (btt / 100) > 720 THEN btt$ = "Batt: [||||||    ]": C = 14
IF (btt / 100) > 900 THEN btt$ = "Batt: [|||||     ]": C = 14
IF (btt / 100) > 1080 THEN btt$ = "Batt: [||||      ]": C = 14
IF (btt / 100) > 1260 THEN btt$ = "Batt: [|||       ]": C = 12
IF (btt / 100) > 1440 THEN btt$ = "Batt: [||        ]": C = 12
IF (btt / 100) > 1620 THEN btt$ = "Batt: [|         ]": C = 12
'########## BARRIER CODES #######
IF x = 5 OR x = 301 THEN GOTO mcrash6
IF y = 20 OR y = 181 THEN GOTO mcrash6
'########## DOOR CODES ###########
IF i = 1 AND x > 139 AND x < 170 THEN IF y = 180 THEN GOTO mfinish6
IF i = 0 AND x > 139 AND x < 170 THEN IF y = 180 THEN y = 179: stat$ = "Not Finished!"
IF i = 0 AND y < 178 THEN stat$ = "Collect Item:"
IF y > 29 AND y < 51 THEN IF x = 300 THEN segm = 0: GOTO m6seg2
IF y > 29 AND y < 51 THEN IF x = 6 THEN segm = 0: GOTO m6seg13
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END

m6seg2: CLS '                 >>> SEGMENT #02 <<<
'######### LEVEL ###########
LINE (5, 20)-(5, 190), 14
LINE (5, 190)-(310, 190), 14
LINE (310, 190)-(310, 20), 14
LINE (5, 20)-(310, 20), 14
LINE (5, 30)-(5, 60), 0
LINE (140, 20)-(170, 20), 0
PCOPY 1, 0
'######### PROGRAM ######
IF segm = 0 THEN x = 10
IF segm = 1 THEN y = 22
btt$ = "Batt: [||||||||||]": C = 10
IF i = 0 THEN stat$ = "Collect Item:"
IF i = 1 THEN stat$ = "Exit Cave:Got Item"
DO
press$ = INKEY$
LOCATE 1, 1: COLOR C: PRINT btt$
LOCATE 2, 1: COLOR 9: PRINT stat$
'######## Graphics Code #######
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), sch1, PSET
IF d = 2 THEN PUT (x, y), scv1, PSET
IF d = 3 THEN PUT (x, y), sch2, PSET
IF d = 4 THEN PUT (x, y), scv2, PSET
IF press$ = CHR$(0) + CHR$(75) THEN d = 2
IF press$ = CHR$(0) + CHR$(72) THEN d = 1
IF press$ = CHR$(0) + CHR$(77) THEN d = 4
IF press$ = CHR$(0) + CHR$(80) THEN d = 3
IF press$ = CHR$(0) + CHR$(72) THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(80) THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(75) THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(77) THEN x = x + 1: PLAY "A"
IF press$ = "4" THEN d = 2
IF press$ = "8" THEN d = 1
IF press$ = "2" THEN d = 3
IF press$ = "6" THEN d = 4
IF press$ = "8" THEN y = y - 1: PLAY "A"
IF press$ = "2" THEN y = y + 1: PLAY "A"
IF press$ = "4" THEN x = x - 1: PLAY "A"
IF press$ = "6" THEN x = x + 1: PLAY "A"
'########### BATTERY CODE ############
btt = btt + 1
IF (btt / 100) > 1800 THEN GOTO dbtt6
IF y < 189 AND (btt / 100) THEN btt$ = "Batt: [||||||||||]"
IF (btt / 100) > 180 THEN btt$ = "Batt: [||||||||| ]": C = 10
IF (btt / 100) > 360 THEN btt$ = "Batt: [||||||||  ]": C = 10
IF (btt / 100) > 540 THEN btt$ = "Batt: [|||||||   ]": C = 10
IF (btt / 100) > 720 THEN btt$ = "Batt: [||||||    ]": C = 14
IF (btt / 100) > 900 THEN btt$ = "Batt: [|||||     ]": C = 14
IF (btt / 100) > 1080 THEN btt$ = "Batt: [||||      ]": C = 14
IF (btt / 100) > 1260 THEN btt$ = "Batt: [|||       ]": C = 12
IF (btt / 100) > 1440 THEN btt$ = "Batt: [||        ]": C = 12
IF (btt / 100) > 1620 THEN btt$ = "Batt: [|         ]": C = 12
'########## BARRIER CODES #######
IF x = 5 OR x = 301 THEN GOTO mcrash6
IF y = 20 OR y = 181 THEN GOTO mcrash6
'########## DOOR CODES ###########
IF x > 139 AND x < 170 THEN IF y = 21 THEN segm = 0: GOTO m6seg3
IF y > 29 AND y < 51 THEN IF x = 6 THEN segm = 1: GOTO m6seg1
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END

m6seg3: CLS '                  >>> SEGMENT #03 <<<
'######### LEVEL ###########
LINE (5, 20)-(5, 190), 14
LINE (5, 190)-(310, 190), 14
LINE (310, 190)-(310, 20), 14
LINE (5, 20)-(310, 20), 14
LINE (5, 30)-(5, 60), 0
LINE (140, 190)-(170, 190), 0
PCOPY 1, 0
'######### PROGRAM ######
IF segm = 0 THEN y = 170
IF segm = 1 THEN x = 7
btt$ = "Batt: [||||||||||]": C = 10
IF i = 0 THEN stat$ = "Collect Item:"
IF i = 1 THEN stat$ = "Exit Cave:Got Item"
DO
press$ = INKEY$
LOCATE 1, 1: COLOR C: PRINT btt$
LOCATE 2, 1: COLOR 9: PRINT stat$
'######## Graphics Code #######
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), sch1, PSET
IF d = 2 THEN PUT (x, y), scv1, PSET
IF d = 3 THEN PUT (x, y), sch2, PSET
IF d = 4 THEN PUT (x, y), scv2, PSET
IF press$ = CHR$(0) + CHR$(75) THEN d = 2
IF press$ = CHR$(0) + CHR$(72) THEN d = 1
IF press$ = CHR$(0) + CHR$(77) THEN d = 4
IF press$ = CHR$(0) + CHR$(80) THEN d = 3
IF press$ = CHR$(0) + CHR$(72) THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(80) THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(75) THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(77) THEN x = x + 1: PLAY "A"
IF press$ = "4" THEN d = 2
IF press$ = "8" THEN d = 1
IF press$ = "2" THEN d = 3
IF press$ = "6" THEN d = 4
IF press$ = "8" THEN y = y - 1: PLAY "A"
IF press$ = "2" THEN y = y + 1: PLAY "A"
IF press$ = "4" THEN x = x - 1: PLAY "A"
IF press$ = "6" THEN x = x + 1: PLAY "A"
'########### BATTERY CODE ############
btt = btt + 1
IF (btt / 100) > 1800 THEN GOTO dbtt6
IF y < 189 AND (btt / 100) THEN btt$ = "Batt: [||||||||||]"
IF (btt / 100) > 180 THEN btt$ = "Batt: [||||||||| ]": C = 10
IF (btt / 100) > 360 THEN btt$ = "Batt: [||||||||  ]": C = 10
IF (btt / 100) > 540 THEN btt$ = "Batt: [|||||||   ]": C = 10
IF (btt / 100) > 720 THEN btt$ = "Batt: [||||||    ]": C = 14
IF (btt / 100) > 900 THEN btt$ = "Batt: [|||||     ]": C = 14
IF (btt / 100) > 1080 THEN btt$ = "Batt: [||||      ]": C = 14
IF (btt / 100) > 1260 THEN btt$ = "Batt: [|||       ]": C = 12
IF (btt / 100) > 1440 THEN btt$ = "Batt: [||        ]": C = 12
IF (btt / 100) > 1620 THEN btt$ = "Batt: [|         ]": C = 12
'########## BARRIER CODES #######
IF x = 5 OR x = 301 THEN GOTO mcrash6
IF y = 20 OR y = 181 THEN GOTO mcrash6
'########## DOOR CODES ###########
IF x > 139 AND x < 170 THEN IF y = 180 THEN segm = 1: GOTO m6seg2
IF y > 29 AND y < 51 THEN IF x = 6 THEN segm = 0: GOTO m6seg4
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END

m6seg4: CLS '                 >>> SEGMENT #04 <<<
'######### LEVEL ###########
LINE (5, 20)-(5, 190), 14
LINE (5, 190)-(310, 190), 14
LINE (310, 190)-(310, 20), 14
LINE (5, 20)-(310, 20), 14
LINE (310, 30)-(310, 60), 0
LINE (140, 20)-(170, 20), 0
PCOPY 1, 0
'######### PROGRAM ######
IF segm = 0 THEN x = 290
IF segm = 1 THEN y = 22
btt$ = "Batt: [||||||||||]": C = 10
IF i = 0 THEN stat$ = "Collect Item:"
IF i = 1 THEN stat$ = "Exit Cave:Got Item"
DO
press$ = INKEY$
LOCATE 1, 1: COLOR C: PRINT btt$
LOCATE 2, 1: COLOR 9: PRINT stat$
'######## Graphics Code #######
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), sch1, PSET
IF d = 2 THEN PUT (x, y), scv1, PSET
IF d = 3 THEN PUT (x, y), sch2, PSET
IF d = 4 THEN PUT (x, y), scv2, PSET
IF press$ = CHR$(0) + CHR$(75) THEN d = 2
IF press$ = CHR$(0) + CHR$(72) THEN d = 1
IF press$ = CHR$(0) + CHR$(77) THEN d = 4
IF press$ = CHR$(0) + CHR$(80) THEN d = 3
IF press$ = CHR$(0) + CHR$(72) THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(80) THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(75) THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(77) THEN x = x + 1: PLAY "A"
IF press$ = "4" THEN d = 2
IF press$ = "8" THEN d = 1
IF press$ = "2" THEN d = 3
IF press$ = "6" THEN d = 4
IF press$ = "8" THEN y = y - 1: PLAY "A"
IF press$ = "2" THEN y = y + 1: PLAY "A"
IF press$ = "4" THEN x = x - 1: PLAY "A"
IF press$ = "6" THEN x = x + 1: PLAY "A"
'########### BATTERY CODE ############
btt = btt + 1
IF (btt / 100) > 1800 THEN GOTO dbtt6
IF y < 189 AND (btt / 100) THEN btt$ = "Batt: [||||||||||]"
IF (btt / 100) > 180 THEN btt$ = "Batt: [||||||||| ]": C = 10
IF (btt / 100) > 360 THEN btt$ = "Batt: [||||||||  ]": C = 10
IF (btt / 100) > 540 THEN btt$ = "Batt: [|||||||   ]": C = 10
IF (btt / 100) > 720 THEN btt$ = "Batt: [||||||    ]": C = 14
IF (btt / 100) > 900 THEN btt$ = "Batt: [|||||     ]": C = 14
IF (btt / 100) > 1080 THEN btt$ = "Batt: [||||      ]": C = 14
IF (btt / 100) > 1260 THEN btt$ = "Batt: [|||       ]": C = 12
IF (btt / 100) > 1440 THEN btt$ = "Batt: [||        ]": C = 12
IF (btt / 100) > 1620 THEN btt$ = "Batt: [|         ]": C = 12
'########## BARRIER CODES #######
IF x = 5 OR x = 301 THEN GOTO mcrash6
IF y = 20 OR y = 181 THEN GOTO mcrash6
'########## DOOR CODES ###########
IF x > 139 AND x < 170 THEN IF y = 21 THEN segm = 0: GOTO m6seg5
IF y > 29 AND y < 51 THEN IF x = 299 THEN segm = 1: GOTO m6seg3
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END

m6seg5: CLS '                 >>> SEGMENT #05 <<<
'######### LEVEL ###########
LINE (5, 20)-(5, 190), 14
LINE (5, 190)-(310, 190), 14
LINE (310, 190)-(310, 20), 14
LINE (5, 20)-(310, 20), 14
LINE (310, 30)-(310, 60), 0
LINE (140, 190)-(170, 190), 0
PCOPY 1, 0
'######### PROGRAM ######
IF segm = 0 THEN y = 175
IF segm = 1 THEN x = 290
btt$ = "Batt: [||||||||||]": C = 10
IF i = 0 THEN stat$ = "Collect Item:"
IF i = 1 THEN stat$ = "Exit Cave:Got Item"
DO
press$ = INKEY$
LOCATE 1, 1: COLOR C: PRINT btt$
LOCATE 2, 1: COLOR 9: PRINT stat$
'######## Graphics Code #######
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), sch1, PSET
IF d = 2 THEN PUT (x, y), scv1, PSET
IF d = 3 THEN PUT (x, y), sch2, PSET
IF d = 4 THEN PUT (x, y), scv2, PSET
IF press$ = CHR$(0) + CHR$(75) THEN d = 2
IF press$ = CHR$(0) + CHR$(72) THEN d = 1
IF press$ = CHR$(0) + CHR$(77) THEN d = 4
IF press$ = CHR$(0) + CHR$(80) THEN d = 3
IF press$ = CHR$(0) + CHR$(72) THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(80) THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(75) THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(77) THEN x = x + 1: PLAY "A"
IF press$ = "4" THEN d = 2
IF press$ = "8" THEN d = 1
IF press$ = "2" THEN d = 3
IF press$ = "6" THEN d = 4
IF press$ = "8" THEN y = y - 1: PLAY "A"
IF press$ = "2" THEN y = y + 1: PLAY "A"
IF press$ = "4" THEN x = x - 1: PLAY "A"
IF press$ = "6" THEN x = x + 1: PLAY "A"
'########### BATTERY CODE ############
btt = btt + 1
IF (btt / 100) > 1800 THEN GOTO dbtt6
IF y < 189 AND (btt / 100) THEN btt$ = "Batt: [||||||||||]"
IF (btt / 100) > 180 THEN btt$ = "Batt: [||||||||| ]": C = 10
IF (btt / 100) > 360 THEN btt$ = "Batt: [||||||||  ]": C = 10
IF (btt / 100) > 540 THEN btt$ = "Batt: [|||||||   ]": C = 10
IF (btt / 100) > 720 THEN btt$ = "Batt: [||||||    ]": C = 14
IF (btt / 100) > 900 THEN btt$ = "Batt: [|||||     ]": C = 14
IF (btt / 100) > 1080 THEN btt$ = "Batt: [||||      ]": C = 14
IF (btt / 100) > 1260 THEN btt$ = "Batt: [|||       ]": C = 12
IF (btt / 100) > 1440 THEN btt$ = "Batt: [||        ]": C = 12
IF (btt / 100) > 1620 THEN btt$ = "Batt: [|         ]": C = 12
'########## BARRIER CODES #######
IF x = 5 OR x = 301 THEN GOTO mcrash6
IF y = 20 OR y = 181 THEN GOTO mcrash6
'########## DOOR CODES ###########
IF x > 139 AND x < 170 THEN IF y = 180 THEN segm = 1: GOTO m6seg4
IF y > 29 AND y < 51 THEN IF x = 300 THEN segm = 0: GOTO m6seg6
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END

m6seg6: CLS '                 >>> SEGMENT #06 <<<
'######### LEVEL ###########
LINE (5, 20)-(5, 190), 14
LINE (5, 190)-(310, 190), 14
LINE (310, 190)-(310, 20), 14
LINE (5, 20)-(310, 20), 14
LINE (5, 30)-(5, 60), 0
LINE (310, 30)-(310, 60), 0
PCOPY 1, 0
'######### PROGRAM ######
IF segm = 0 THEN x = 10
IF segm = 1 THEN x = 290
btt$ = "Batt: [||||||||||]": C = 10
IF i = 0 THEN stat$ = "Collect Item:"
IF i = 1 THEN stat$ = "Exit Cave:Got Item"
DO
press$ = INKEY$
LOCATE 1, 1: COLOR C: PRINT btt$
LOCATE 2, 1: COLOR 9: PRINT stat$
'######## Graphics Code #######
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), sch1, PSET
IF d = 2 THEN PUT (x, y), scv1, PSET
IF d = 3 THEN PUT (x, y), sch2, PSET
IF d = 4 THEN PUT (x, y), scv2, PSET
IF press$ = CHR$(0) + CHR$(75) THEN d = 2
IF press$ = CHR$(0) + CHR$(72) THEN d = 1
IF press$ = CHR$(0) + CHR$(77) THEN d = 4
IF press$ = CHR$(0) + CHR$(80) THEN d = 3
IF press$ = CHR$(0) + CHR$(72) THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(80) THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(75) THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(77) THEN x = x + 1: PLAY "A"
IF press$ = "4" THEN d = 2
IF press$ = "8" THEN d = 1
IF press$ = "2" THEN d = 3
IF press$ = "6" THEN d = 4
IF press$ = "8" THEN y = y - 1: PLAY "A"
IF press$ = "2" THEN y = y + 1: PLAY "A"
IF press$ = "4" THEN x = x - 1: PLAY "A"
IF press$ = "6" THEN x = x + 1: PLAY "A"
'########### BATTERY CODE ############
btt = btt + 1
IF (btt / 100) > 1800 THEN GOTO dbtt6
IF y < 189 AND (btt / 100) THEN btt$ = "Batt: [||||||||||]"
IF (btt / 100) > 180 THEN btt$ = "Batt: [||||||||| ]": C = 10
IF (btt / 100) > 360 THEN btt$ = "Batt: [||||||||  ]": C = 10
IF (btt / 100) > 540 THEN btt$ = "Batt: [|||||||   ]": C = 10
IF (btt / 100) > 720 THEN btt$ = "Batt: [||||||    ]": C = 14
IF (btt / 100) > 900 THEN btt$ = "Batt: [|||||     ]": C = 14
IF (btt / 100) > 1080 THEN btt$ = "Batt: [||||      ]": C = 14
IF (btt / 100) > 1260 THEN btt$ = "Batt: [|||       ]": C = 12
IF (btt / 100) > 1440 THEN btt$ = "Batt: [||        ]": C = 12
IF (btt / 100) > 1620 THEN btt$ = "Batt: [|         ]": C = 12
'########## BARRIER CODES #######
IF x = 5 OR x = 301 THEN GOTO mcrash6
IF y = 20 OR y = 181 THEN GOTO mcrash6
'########## DOOR CODES ###########
IF y > 29 AND y < 51 THEN IF x = 300 THEN segm = 0: GOTO m6seg7
IF y > 29 AND y < 51 THEN IF x = 6 THEN segm = 1: GOTO m6seg5
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END

m6seg7: CLS '                 >>> SEGMENT #07 <<<
'######### LEVEL ###########
LINE (5, 20)-(5, 190), 14
LINE (5, 190)-(310, 190), 14
LINE (310, 190)-(310, 20), 14
LINE (5, 20)-(310, 20), 14
LINE (5, 30)-(5, 60), 0
LINE (140, 190)-(170, 190), 0
PCOPY 1, 0
'######### PROGRAM ######
IF segm = 0 THEN x = 7
IF segm = 1 THEN y = 175
btt$ = "Batt: [||||||||||]": C = 10
IF i = 0 THEN stat$ = "Collect Item:"
IF i = 1 THEN stat$ = "Exit Cave:Got Item"
DO
press$ = INKEY$
LOCATE 1, 1: COLOR C: PRINT btt$
LOCATE 2, 1: COLOR 9: PRINT stat$
'######## Graphics Code #######
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), sch1, PSET
IF d = 2 THEN PUT (x, y), scv1, PSET
IF d = 3 THEN PUT (x, y), sch2, PSET
IF d = 4 THEN PUT (x, y), scv2, PSET
IF press$ = CHR$(0) + CHR$(75) THEN d = 2
IF press$ = CHR$(0) + CHR$(72) THEN d = 1
IF press$ = CHR$(0) + CHR$(77) THEN d = 4
IF press$ = CHR$(0) + CHR$(80) THEN d = 3
IF press$ = CHR$(0) + CHR$(72) THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(80) THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(75) THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(77) THEN x = x + 1: PLAY "A"
IF press$ = "4" THEN d = 2
IF press$ = "8" THEN d = 1
IF press$ = "2" THEN d = 3
IF press$ = "6" THEN d = 4
IF press$ = "8" THEN y = y - 1: PLAY "A"
IF press$ = "2" THEN y = y + 1: PLAY "A"
IF press$ = "4" THEN x = x - 1: PLAY "A"
IF press$ = "6" THEN x = x + 1: PLAY "A"
'########### BATTERY CODE ############
btt = btt + 1
IF (btt / 100) > 1800 THEN GOTO dbtt6
IF y < 189 AND (btt / 100) THEN btt$ = "Batt: [||||||||||]"
IF (btt / 100) > 180 THEN btt$ = "Batt: [||||||||| ]": C = 10
IF (btt / 100) > 360 THEN btt$ = "Batt: [||||||||  ]": C = 10
IF (btt / 100) > 540 THEN btt$ = "Batt: [|||||||   ]": C = 10
IF (btt / 100) > 720 THEN btt$ = "Batt: [||||||    ]": C = 14
IF (btt / 100) > 900 THEN btt$ = "Batt: [|||||     ]": C = 14
IF (btt / 100) > 1080 THEN btt$ = "Batt: [||||      ]": C = 14
IF (btt / 100) > 1260 THEN btt$ = "Batt: [|||       ]": C = 12
IF (btt / 100) > 1440 THEN btt$ = "Batt: [||        ]": C = 12
IF (btt / 100) > 1620 THEN btt$ = "Batt: [|         ]": C = 12
'########## BARRIER CODES #######
IF x = 5 OR x = 301 THEN GOTO mcrash6
IF y = 20 OR y = 181 THEN GOTO mcrash6
'########## DOOR CODES ###########
IF x > 139 AND x < 170 THEN IF y = 180 THEN segm = 0: GOTO m6seg8
IF y > 29 AND y < 51 THEN IF x = 6 THEN segm = 1: GOTO m6seg6
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END

m6seg8: CLS '                 >>> SEGMENT #08 <<<
'######### LEVEL ###########
LINE (5, 20)-(5, 190), 14
LINE (5, 190)-(310, 190), 14
LINE (310, 190)-(310, 20), 14
LINE (5, 20)-(310, 20), 14
LINE (310, 30)-(310, 60), 0
LINE (140, 190)-(170, 190), 0: LINE (140, 20)-(170, 20), 0
PCOPY 1, 0
'######### PROGRAM ######
IF segm = 0 THEN y = 22
IF segm = 1 THEN x = 290
IF segm = 2 THEN y = 175
btt$ = "Batt: [||||||||||]": C = 10
IF i = 0 THEN stat$ = "Collect Item:"
IF i = 1 THEN stat$ = "Exit Cave:Got Item"
DO
press$ = INKEY$
LOCATE 1, 1: COLOR C: PRINT btt$
LOCATE 2, 1: COLOR 9: PRINT stat$
'######## Graphics Code #######
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), sch1, PSET
IF d = 2 THEN PUT (x, y), scv1, PSET
IF d = 3 THEN PUT (x, y), sch2, PSET
IF d = 4 THEN PUT (x, y), scv2, PSET
IF press$ = CHR$(0) + CHR$(75) THEN d = 2
IF press$ = CHR$(0) + CHR$(72) THEN d = 1
IF press$ = CHR$(0) + CHR$(77) THEN d = 4
IF press$ = CHR$(0) + CHR$(80) THEN d = 3
IF press$ = CHR$(0) + CHR$(72) THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(80) THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(75) THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(77) THEN x = x + 1: PLAY "A"
IF press$ = "4" THEN d = 2
IF press$ = "8" THEN d = 1
IF press$ = "2" THEN d = 3
IF press$ = "6" THEN d = 4
IF press$ = "8" THEN y = y - 1: PLAY "A"
IF press$ = "2" THEN y = y + 1: PLAY "A"
IF press$ = "4" THEN x = x - 1: PLAY "A"
IF press$ = "6" THEN x = x + 1: PLAY "A"
'########### BATTERY CODE ############
btt = btt + 1
IF (btt / 100) > 1800 THEN GOTO dbtt6
IF y < 189 AND (btt / 100) THEN btt$ = "Batt: [||||||||||]"
IF (btt / 100) > 180 THEN btt$ = "Batt: [||||||||| ]": C = 10
IF (btt / 100) > 360 THEN btt$ = "Batt: [||||||||  ]": C = 10
IF (btt / 100) > 540 THEN btt$ = "Batt: [|||||||   ]": C = 10
IF (btt / 100) > 720 THEN btt$ = "Batt: [||||||    ]": C = 14
IF (btt / 100) > 900 THEN btt$ = "Batt: [|||||     ]": C = 14
IF (btt / 100) > 1080 THEN btt$ = "Batt: [||||      ]": C = 14
IF (btt / 100) > 1260 THEN btt$ = "Batt: [|||       ]": C = 12
IF (btt / 100) > 1440 THEN btt$ = "Batt: [||        ]": C = 12
IF (btt / 100) > 1620 THEN btt$ = "Batt: [|         ]": C = 12
'########## BARRIER CODES #######
IF x = 5 OR x = 301 THEN GOTO mcrash6
IF y = 20 OR y = 181 THEN GOTO mcrash6
'########## DOOR CODES ###########
IF x > 139 AND x < 170 THEN IF y = 21 THEN segm = 1: GOTO m6seg7
IF y > 29 AND y < 51 THEN IF x = 300 THEN segm = 0: GOTO m6seg9
IF x > 139 AND x < 170 THEN IF y = 180 THEN segm = 0: GOTO m6seg15
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END

m6seg9: CLS '                 >>> SEGMENT #09 <<<
'######### LEVEL ###########
LINE (5, 20)-(5, 190), 14
LINE (5, 190)-(310, 190), 14
LINE (310, 190)-(310, 20), 14
LINE (5, 20)-(310, 20), 14
LINE (5, 30)-(5, 60), 0
LINE (140, 190)-(170, 190), 0
PCOPY 1, 0
'######### PROGRAM ######
IF segm = 0 THEN x = 7
IF segm = 1 THEN y = 175
btt$ = "Batt: [||||||||||]": C = 10
IF i = 0 THEN stat$ = "Collect Item:"
IF i = 1 THEN stat$ = "Exit Cave:Got Item"
DO
press$ = INKEY$
LOCATE 1, 1: COLOR C: PRINT btt$
LOCATE 2, 1: COLOR 9: PRINT stat$
'######## Graphics Code #######
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), sch1, PSET
IF d = 2 THEN PUT (x, y), scv1, PSET
IF d = 3 THEN PUT (x, y), sch2, PSET
IF d = 4 THEN PUT (x, y), scv2, PSET
IF press$ = CHR$(0) + CHR$(75) THEN d = 2
IF press$ = CHR$(0) + CHR$(72) THEN d = 1
IF press$ = CHR$(0) + CHR$(77) THEN d = 4
IF press$ = CHR$(0) + CHR$(80) THEN d = 3
IF press$ = CHR$(0) + CHR$(72) THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(80) THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(75) THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(77) THEN x = x + 1: PLAY "A"
IF press$ = "4" THEN d = 2
IF press$ = "8" THEN d = 1
IF press$ = "2" THEN d = 3
IF press$ = "6" THEN d = 4
IF press$ = "8" THEN y = y - 1: PLAY "A"
IF press$ = "2" THEN y = y + 1: PLAY "A"
IF press$ = "4" THEN x = x - 1: PLAY "A"
IF press$ = "6" THEN x = x + 1: PLAY "A"
'########### BATTERY CODE ############
btt = btt + 1
IF (btt / 100) > 1800 THEN GOTO dbtt6
IF y < 189 AND (btt / 100) THEN btt$ = "Batt: [||||||||||]"
IF (btt / 100) > 180 THEN btt$ = "Batt: [||||||||| ]": C = 10
IF (btt / 100) > 360 THEN btt$ = "Batt: [||||||||  ]": C = 10
IF (btt / 100) > 540 THEN btt$ = "Batt: [|||||||   ]": C = 10
IF (btt / 100) > 720 THEN btt$ = "Batt: [||||||    ]": C = 14
IF (btt / 100) > 900 THEN btt$ = "Batt: [|||||     ]": C = 14
IF (btt / 100) > 1080 THEN btt$ = "Batt: [||||      ]": C = 14
IF (btt / 100) > 1260 THEN btt$ = "Batt: [|||       ]": C = 12
IF (btt / 100) > 1440 THEN btt$ = "Batt: [||        ]": C = 12
IF (btt / 100) > 1620 THEN btt$ = "Batt: [|         ]": C = 12
'########## BARRIER CODES #######
IF x = 5 OR x = 301 THEN GOTO mcrash6
IF y = 20 OR y = 181 THEN GOTO mcrash6
'########## DOOR CODES ###########
IF y > 29 AND y < 51 THEN IF x = 6 THEN segm = 1: GOTO m6seg8
IF x > 139 AND x < 170 THEN IF y = 180 THEN segm = 0: GOTO m6seg10
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END

m6seg10: CLS '                >>> SEGMENT #10 <<<
'######### LEVEL ###########
LINE (5, 20)-(5, 190), 14
LINE (5, 190)-(310, 190), 14
LINE (310, 190)-(310, 20), 14
LINE (5, 20)-(310, 20), 14
LINE (310, 30)-(310, 60), 0
LINE (140, 190)-(170, 190), 0: LINE (140, 20)-(170, 20), 0
PCOPY 1, 0
'######### PROGRAM ######
IF segm = 0 THEN y = 22
IF segm = 1 THEN x = 290
IF segm = 2 THEN y = 175
btt$ = "Batt: [||||||||||]": C = 10
IF i = 0 THEN stat$ = "Collect Item:"
IF i = 1 THEN stat$ = "Exit Cave:Got Item"
DO
press$ = INKEY$
LOCATE 1, 1: COLOR C: PRINT btt$
LOCATE 2, 1: COLOR 9: PRINT stat$
'######## Graphics Code #######
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), sch1, PSET
IF d = 2 THEN PUT (x, y), scv1, PSET
IF d = 3 THEN PUT (x, y), sch2, PSET
IF d = 4 THEN PUT (x, y), scv2, PSET
IF press$ = CHR$(0) + CHR$(75) THEN d = 2
IF press$ = CHR$(0) + CHR$(72) THEN d = 1
IF press$ = CHR$(0) + CHR$(77) THEN d = 4
IF press$ = CHR$(0) + CHR$(80) THEN d = 3
IF press$ = CHR$(0) + CHR$(72) THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(80) THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(75) THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(77) THEN x = x + 1: PLAY "A"
IF press$ = "4" THEN d = 2
IF press$ = "8" THEN d = 1
IF press$ = "2" THEN d = 3
IF press$ = "6" THEN d = 4
IF press$ = "8" THEN y = y - 1: PLAY "A"
IF press$ = "2" THEN y = y + 1: PLAY "A"
IF press$ = "4" THEN x = x - 1: PLAY "A"
IF press$ = "6" THEN x = x + 1: PLAY "A"
'########### BATTERY CODE ############
btt = btt + 1
IF (btt / 100) > 1800 THEN GOTO dbtt6
IF y < 189 AND (btt / 100) THEN btt$ = "Batt: [||||||||||]"
IF (btt / 100) > 180 THEN btt$ = "Batt: [||||||||| ]": C = 10
IF (btt / 100) > 360 THEN btt$ = "Batt: [||||||||  ]": C = 10
IF (btt / 100) > 540 THEN btt$ = "Batt: [|||||||   ]": C = 10
IF (btt / 100) > 720 THEN btt$ = "Batt: [||||||    ]": C = 14
IF (btt / 100) > 900 THEN btt$ = "Batt: [|||||     ]": C = 14
IF (btt / 100) > 1080 THEN btt$ = "Batt: [||||      ]": C = 14
IF (btt / 100) > 1260 THEN btt$ = "Batt: [|||       ]": C = 12
IF (btt / 100) > 1440 THEN btt$ = "Batt: [||        ]": C = 12
IF (btt / 100) > 1620 THEN btt$ = "Batt: [|         ]": C = 12
'########## BARRIER CODES #######
IF x = 5 OR x = 301 THEN GOTO mcrash6
IF y = 20 OR y = 181 THEN GOTO mcrash6
'########## DOOR CODES ###########
IF x > 139 AND x < 170 THEN IF y = 21 THEN segm = 1: GOTO m6seg9
IF y > 29 AND y < 51 THEN IF x = 300 THEN segm = 0: GOTO m6seg11
IF x > 139 AND x < 170 THEN IF y = 180 THEN segm = 0: GOTO m6seg18
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END

m6seg11: CLS '                >>> SEGMENT #11 <<<
'######### LEVEL ###########
LINE (5, 20)-(5, 190), 14
LINE (5, 190)-(310, 190), 14
LINE (310, 190)-(310, 20), 14
LINE (5, 20)-(310, 20), 14
LINE (5, 30)-(5, 60), 0
LINE (140, 190)-(170, 190), 0
PCOPY 1, 0
'######### PROGRAM ######
IF segm = 0 THEN x = 7
IF segm = 1 THEN y = 175
btt$ = "Batt: [||||||||||]": C = 10
IF i = 0 THEN stat$ = "Collect Item:"
IF i = 1 THEN stat$ = "Exit Cave:Got Item"
DO
press$ = INKEY$
LOCATE 1, 1: COLOR C: PRINT btt$
LOCATE 2, 1: COLOR 9: PRINT stat$
'######## Graphics Code #######
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), sch1, PSET
IF d = 2 THEN PUT (x, y), scv1, PSET
IF d = 3 THEN PUT (x, y), sch2, PSET
IF d = 4 THEN PUT (x, y), scv2, PSET
IF press$ = CHR$(0) + CHR$(75) THEN d = 2
IF press$ = CHR$(0) + CHR$(72) THEN d = 1
IF press$ = CHR$(0) + CHR$(77) THEN d = 4
IF press$ = CHR$(0) + CHR$(80) THEN d = 3
IF press$ = CHR$(0) + CHR$(72) THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(80) THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(75) THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(77) THEN x = x + 1: PLAY "A"
IF press$ = "4" THEN d = 2
IF press$ = "8" THEN d = 1
IF press$ = "2" THEN d = 3
IF press$ = "6" THEN d = 4
IF press$ = "8" THEN y = y - 1: PLAY "A"
IF press$ = "2" THEN y = y + 1: PLAY "A"
IF press$ = "4" THEN x = x - 1: PLAY "A"
IF press$ = "6" THEN x = x + 1: PLAY "A"
'########### BATTERY CODE ############
btt = btt + 1
IF (btt / 100) > 1800 THEN GOTO dbtt6
IF y < 189 AND (btt / 100) THEN btt$ = "Batt: [||||||||||]"
IF (btt / 100) > 180 THEN btt$ = "Batt: [||||||||| ]": C = 10
IF (btt / 100) > 360 THEN btt$ = "Batt: [||||||||  ]": C = 10
IF (btt / 100) > 540 THEN btt$ = "Batt: [|||||||   ]": C = 10
IF (btt / 100) > 720 THEN btt$ = "Batt: [||||||    ]": C = 14
IF (btt / 100) > 900 THEN btt$ = "Batt: [|||||     ]": C = 14
IF (btt / 100) > 1080 THEN btt$ = "Batt: [||||      ]": C = 14
IF (btt / 100) > 1260 THEN btt$ = "Batt: [|||       ]": C = 12
IF (btt / 100) > 1440 THEN btt$ = "Batt: [||        ]": C = 12
IF (btt / 100) > 1620 THEN btt$ = "Batt: [|         ]": C = 12
'########## BARRIER CODES #######
IF x = 5 OR x = 301 THEN GOTO mcrash6
IF y = 20 OR y = 181 THEN GOTO mcrash6
'########## DOOR CODES ###########
IF y > 29 AND y < 51 THEN IF x = 6 THEN segm = 1: GOTO m6seg10
IF x > 139 AND x < 170 THEN IF y = 180 THEN segm = 0: GOTO m6seg12
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END

m6seg12: CLS '                >>> SEGMENT #12 <<<
'######### LEVEL ###########
LINE (5, 20)-(5, 190), 14
LINE (5, 190)-(310, 190), 14
LINE (310, 190)-(310, 20), 14
LINE (5, 20)-(310, 20), 14
LINE (140, 20)-(170, 20), 0
PCOPY 1, 0
'######### PROGRAM ######
IF segm = 0 THEN y = 22
btt$ = "Batt: [||||||||||]": C = 10
IF i = 0 THEN stat$ = "Collect Item:"
IF i = 1 THEN stat$ = "Exit Cave:Got Item"
DO
press$ = INKEY$
LOCATE 1, 1: COLOR C: PRINT btt$
LOCATE 2, 1: COLOR 9: PRINT stat$
'######## ITEM CODE ###########
IF i = 0 THEN CIRCLE (160, 187), 2, 15: PAINT (160, 187), 15 ELSE CIRCLE (160, 187), 2, 0: PAINT (160, 187), 0
IF x > 154 AND x < 157 AND y = 176 THEN i = 1: stat$ = "Exit Cave:Got Item"
'######## Graphics Code #######
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), sch1, PSET
IF d = 2 THEN PUT (x, y), scv1, PSET
IF d = 3 THEN PUT (x, y), sch2, PSET
IF d = 4 THEN PUT (x, y), scv2, PSET
IF press$ = CHR$(0) + CHR$(75) THEN d = 2
IF press$ = CHR$(0) + CHR$(72) THEN d = 1
IF press$ = CHR$(0) + CHR$(77) THEN d = 4
IF press$ = CHR$(0) + CHR$(80) THEN d = 3
IF press$ = CHR$(0) + CHR$(72) THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(80) THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(75) THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(77) THEN x = x + 1: PLAY "A"
IF press$ = "4" THEN d = 2
IF press$ = "8" THEN d = 1
IF press$ = "2" THEN d = 3
IF press$ = "6" THEN d = 4
IF press$ = "8" THEN y = y - 1: PLAY "A"
IF press$ = "2" THEN y = y + 1: PLAY "A"
IF press$ = "4" THEN x = x - 1: PLAY "A"
IF press$ = "6" THEN x = x + 1: PLAY "A"
'########### BATTERY CODE ############
btt = btt + 1
IF (btt / 100) > 1800 THEN GOTO dbtt6
IF y < 189 AND (btt / 100) THEN btt$ = "Batt: [||||||||||]"
IF (btt / 100) > 180 THEN btt$ = "Batt: [||||||||| ]": C = 10
IF (btt / 100) > 360 THEN btt$ = "Batt: [||||||||  ]": C = 10
IF (btt / 100) > 540 THEN btt$ = "Batt: [|||||||   ]": C = 10
IF (btt / 100) > 720 THEN btt$ = "Batt: [||||||    ]": C = 14
IF (btt / 100) > 900 THEN btt$ = "Batt: [|||||     ]": C = 14
IF (btt / 100) > 1080 THEN btt$ = "Batt: [||||      ]": C = 14
IF (btt / 100) > 1260 THEN btt$ = "Batt: [|||       ]": C = 12
IF (btt / 100) > 1440 THEN btt$ = "Batt: [||        ]": C = 12
IF (btt / 100) > 1620 THEN btt$ = "Batt: [|         ]": C = 12
'########## BARRIER CODES #######
IF x = 5 OR x = 301 THEN GOTO mcrash6
IF y = 20 OR y = 181 THEN GOTO mcrash6
'########## DOOR CODES ###########
IF x > 139 AND x < 170 THEN IF y = 21 THEN segm = 1: GOTO m6seg11
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END


m6seg13: CLS '                >>> SEGMENT #13 <<<
'######### LEVEL ###########
LINE (5, 20)-(5, 190), 14
LINE (5, 190)-(310, 190), 14
LINE (310, 190)-(310, 20), 14
LINE (5, 20)-(310, 20), 14
LINE (310, 30)-(310, 60), 0
LINE (140, 20)-(170, 20), 0
PCOPY 1, 0
'######### PROGRAM ######
IF segm = 0 THEN x = 290
IF segm = 1 THEN y = 23
btt$ = "Batt: [||||||||||]": C = 10
IF i = 0 THEN stat$ = "Collect Item:"
IF i = 1 THEN stat$ = "Exit Cave:Got Item"
DO
press$ = INKEY$
LOCATE 1, 1: COLOR C: PRINT btt$
LOCATE 2, 1: COLOR 9: PRINT stat$
'######## Graphics Code #######
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), sch1, PSET
IF d = 2 THEN PUT (x, y), scv1, PSET
IF d = 3 THEN PUT (x, y), sch2, PSET
IF d = 4 THEN PUT (x, y), scv2, PSET
IF press$ = CHR$(0) + CHR$(75) THEN d = 2
IF press$ = CHR$(0) + CHR$(72) THEN d = 1
IF press$ = CHR$(0) + CHR$(77) THEN d = 4
IF press$ = CHR$(0) + CHR$(80) THEN d = 3
IF press$ = CHR$(0) + CHR$(72) THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(80) THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(75) THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(77) THEN x = x + 1: PLAY "A"
IF press$ = "4" THEN d = 2
IF press$ = "8" THEN d = 1
IF press$ = "2" THEN d = 3
IF press$ = "6" THEN d = 4
IF press$ = "8" THEN y = y - 1: PLAY "A"
IF press$ = "2" THEN y = y + 1: PLAY "A"
IF press$ = "4" THEN x = x - 1: PLAY "A"
IF press$ = "6" THEN x = x + 1: PLAY "A"
'########### BATTERY CODE ############
btt = btt + 1
IF (btt / 100) > 1800 THEN GOTO dbtt6
IF y < 189 AND (btt / 100) THEN btt$ = "Batt: [||||||||||]"
IF (btt / 100) > 180 THEN btt$ = "Batt: [||||||||| ]": C = 10
IF (btt / 100) > 360 THEN btt$ = "Batt: [||||||||  ]": C = 10
IF (btt / 100) > 540 THEN btt$ = "Batt: [|||||||   ]": C = 10
IF (btt / 100) > 720 THEN btt$ = "Batt: [||||||    ]": C = 14
IF (btt / 100) > 900 THEN btt$ = "Batt: [|||||     ]": C = 14
IF (btt / 100) > 1080 THEN btt$ = "Batt: [||||      ]": C = 14
IF (btt / 100) > 1260 THEN btt$ = "Batt: [|||       ]": C = 12
IF (btt / 100) > 1440 THEN btt$ = "Batt: [||        ]": C = 12
IF (btt / 100) > 1620 THEN btt$ = "Batt: [|         ]": C = 12
'########## BARRIER CODES #######
IF x = 5 OR x = 301 THEN GOTO mcrash6
IF y = 20 OR y = 181 THEN GOTO mcrash6
'########## DOOR CODES ###########
IF y > 29 AND y < 51 THEN IF x = 300 THEN segm = 2: GOTO m6seg1
IF x > 139 AND x < 170 THEN IF y = 21 THEN segm = 0: GOTO m6seg14
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END

m6seg14: CLS '                  >>> SEGMENT #14 <<<
'######### LEVEL ###########
LINE (5, 20)-(5, 190), 14
LINE (5, 190)-(310, 190), 14
LINE (310, 190)-(310, 20), 14
LINE (5, 20)-(310, 20), 14
LINE (140, 190)-(170, 190), 0
PCOPY 1, 0
'######### PROGRAM ######
IF segm = 0 THEN y = 170
btt$ = "Batt: [||||||||||]": C = 10
IF i = 0 THEN stat$ = "Collect Item:"
IF i = 1 THEN stat$ = "Exit Cave:Got Item"
DO
press$ = INKEY$
LOCATE 1, 1: COLOR C: PRINT btt$
LOCATE 2, 1: COLOR 9: PRINT stat$
'######## Graphics Code #######
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), sch1, PSET
IF d = 2 THEN PUT (x, y), scv1, PSET
IF d = 3 THEN PUT (x, y), sch2, PSET
IF d = 4 THEN PUT (x, y), scv2, PSET
IF press$ = CHR$(0) + CHR$(75) THEN d = 2
IF press$ = CHR$(0) + CHR$(72) THEN d = 1
IF press$ = CHR$(0) + CHR$(77) THEN d = 4
IF press$ = CHR$(0) + CHR$(80) THEN d = 3
IF press$ = CHR$(0) + CHR$(72) THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(80) THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(75) THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(77) THEN x = x + 1: PLAY "A"
IF press$ = "4" THEN d = 2
IF press$ = "8" THEN d = 1
IF press$ = "2" THEN d = 3
IF press$ = "6" THEN d = 4
IF press$ = "8" THEN y = y - 1: PLAY "A"
IF press$ = "2" THEN y = y + 1: PLAY "A"
IF press$ = "4" THEN x = x - 1: PLAY "A"
IF press$ = "6" THEN x = x + 1: PLAY "A"
'########### BATTERY CODE ############
btt = btt + 1
IF (btt / 100) > 1800 THEN GOTO dbtt6
IF y < 189 AND (btt / 100) THEN btt$ = "Batt: [||||||||||]"
IF (btt / 100) > 180 THEN btt$ = "Batt: [||||||||| ]": C = 10
IF (btt / 100) > 360 THEN btt$ = "Batt: [||||||||  ]": C = 10
IF (btt / 100) > 540 THEN btt$ = "Batt: [|||||||   ]": C = 10
IF (btt / 100) > 720 THEN btt$ = "Batt: [||||||    ]": C = 14
IF (btt / 100) > 900 THEN btt$ = "Batt: [|||||     ]": C = 14
IF (btt / 100) > 1080 THEN btt$ = "Batt: [||||      ]": C = 14
IF (btt / 100) > 1260 THEN btt$ = "Batt: [|||       ]": C = 12
IF (btt / 100) > 1440 THEN btt$ = "Batt: [||        ]": C = 12
IF (btt / 100) > 1620 THEN btt$ = "Batt: [|         ]": C = 12
'########## BARRIER CODES #######
IF x = 5 OR x = 301 THEN GOTO mcrash6
IF y = 20 OR y = 181 THEN GOTO mcrash6
'########## DOOR CODES ###########
IF x > 139 AND x < 170 THEN IF y = 180 THEN segm = 1: GOTO m6seg13
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)

m6seg15: CLS '                 >>> SEGMENT #15 <<<
'######### LEVEL ###########
LINE (5, 20)-(5, 190), 14
LINE (5, 190)-(310, 190), 14
LINE (310, 190)-(310, 20), 14
LINE (5, 20)-(310, 20), 14
LINE (140, 190)-(170, 190), 0: LINE (140, 20)-(170, 20), 0
PCOPY 1, 0
'######### PROGRAM ######
IF segm = 0 THEN y = 22
IF segm = 1 THEN y = 175
btt$ = "Batt: [||||||||||]": C = 10
IF i = 0 THEN stat$ = "Collect Item:"
IF i = 1 THEN stat$ = "Exit Cave:Got Item"
DO
press$ = INKEY$
LOCATE 1, 1: COLOR C: PRINT btt$
LOCATE 2, 1: COLOR 9: PRINT stat$
'######## Graphics Code #######
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), sch1, PSET
IF d = 2 THEN PUT (x, y), scv1, PSET
IF d = 3 THEN PUT (x, y), sch2, PSET
IF d = 4 THEN PUT (x, y), scv2, PSET
IF press$ = CHR$(0) + CHR$(75) THEN d = 2
IF press$ = CHR$(0) + CHR$(72) THEN d = 1
IF press$ = CHR$(0) + CHR$(77) THEN d = 4
IF press$ = CHR$(0) + CHR$(80) THEN d = 3
IF press$ = CHR$(0) + CHR$(72) THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(80) THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(75) THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(77) THEN x = x + 1: PLAY "A"
IF press$ = "4" THEN d = 2
IF press$ = "8" THEN d = 1
IF press$ = "2" THEN d = 3
IF press$ = "6" THEN d = 4
IF press$ = "8" THEN y = y - 1: PLAY "A"
IF press$ = "2" THEN y = y + 1: PLAY "A"
IF press$ = "4" THEN x = x - 1: PLAY "A"
IF press$ = "6" THEN x = x + 1: PLAY "A"
'########### BATTERY CODE ############
btt = btt + 1
IF (btt / 100) > 1800 THEN GOTO dbtt6
IF y < 189 AND (btt / 100) THEN btt$ = "Batt: [||||||||||]"
IF (btt / 100) > 180 THEN btt$ = "Batt: [||||||||| ]": C = 10
IF (btt / 100) > 360 THEN btt$ = "Batt: [||||||||  ]": C = 10
IF (btt / 100) > 540 THEN btt$ = "Batt: [|||||||   ]": C = 10
IF (btt / 100) > 720 THEN btt$ = "Batt: [||||||    ]": C = 14
IF (btt / 100) > 900 THEN btt$ = "Batt: [|||||     ]": C = 14
IF (btt / 100) > 1080 THEN btt$ = "Batt: [||||      ]": C = 14
IF (btt / 100) > 1260 THEN btt$ = "Batt: [|||       ]": C = 12
IF (btt / 100) > 1440 THEN btt$ = "Batt: [||        ]": C = 12
IF (btt / 100) > 1620 THEN btt$ = "Batt: [|         ]": C = 12
'########## BARRIER CODES #######
IF x = 5 OR x = 301 THEN GOTO mcrash6
IF y = 20 OR y = 181 THEN GOTO mcrash6
'########## DOOR CODES ###########
IF x > 139 AND x < 170 THEN IF y = 21 THEN segm = 2: GOTO m6seg8
IF x > 139 AND x < 170 THEN IF y = 180 THEN segm = 0: GOTO m6seg16
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END

m6seg16: CLS '                 >>> SEGMENT #16 <<<
'######### LEVEL ###########
LINE (5, 20)-(5, 190), 14
LINE (5, 190)-(310, 190), 14
LINE (310, 190)-(310, 20), 14
LINE (5, 20)-(310, 20), 14
LINE (5, 30)-(5, 60), 0
LINE (140, 20)-(170, 20), 0
PCOPY 1, 0
'######### PROGRAM ######
IF segm = 0 THEN y = 22
IF segm = 1 THEN x = 7
btt$ = "Batt: [||||||||||]": C = 10
IF i = 0 THEN stat$ = "Collect Item:"
IF i = 1 THEN stat$ = "Exit Cave:Got Item"
DO
press$ = INKEY$
LOCATE 1, 1: COLOR C: PRINT btt$
LOCATE 2, 1: COLOR 9: PRINT stat$
'######## Graphics Code #######
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), sch1, PSET
IF d = 2 THEN PUT (x, y), scv1, PSET
IF d = 3 THEN PUT (x, y), sch2, PSET
IF d = 4 THEN PUT (x, y), scv2, PSET
IF press$ = CHR$(0) + CHR$(75) THEN d = 2
IF press$ = CHR$(0) + CHR$(72) THEN d = 1
IF press$ = CHR$(0) + CHR$(77) THEN d = 4
IF press$ = CHR$(0) + CHR$(80) THEN d = 3
IF press$ = CHR$(0) + CHR$(72) THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(80) THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(75) THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(77) THEN x = x + 1: PLAY "A"
IF press$ = "4" THEN d = 2
IF press$ = "8" THEN d = 1
IF press$ = "2" THEN d = 3
IF press$ = "6" THEN d = 4
IF press$ = "8" THEN y = y - 1: PLAY "A"
IF press$ = "2" THEN y = y + 1: PLAY "A"
IF press$ = "4" THEN x = x - 1: PLAY "A"
IF press$ = "6" THEN x = x + 1: PLAY "A"
'########### BATTERY CODE ############
btt = btt + 1
IF (btt / 100) > 1800 THEN GOTO dbtt6
IF y < 189 AND (btt / 100) THEN btt$ = "Batt: [||||||||||]"
IF (btt / 100) > 180 THEN btt$ = "Batt: [||||||||| ]": C = 10
IF (btt / 100) > 360 THEN btt$ = "Batt: [||||||||  ]": C = 10
IF (btt / 100) > 540 THEN btt$ = "Batt: [|||||||   ]": C = 10
IF (btt / 100) > 720 THEN btt$ = "Batt: [||||||    ]": C = 14
IF (btt / 100) > 900 THEN btt$ = "Batt: [|||||     ]": C = 14
IF (btt / 100) > 1080 THEN btt$ = "Batt: [||||      ]": C = 14
IF (btt / 100) > 1260 THEN btt$ = "Batt: [|||       ]": C = 12
IF (btt / 100) > 1440 THEN btt$ = "Batt: [||        ]": C = 12
IF (btt / 100) > 1620 THEN btt$ = "Batt: [|         ]": C = 12
'########## BARRIER CODES #######
IF x = 5 OR x = 301 THEN GOTO mcrash6
IF y = 20 OR y = 181 THEN GOTO mcrash6
'########## DOOR CODES ###########
IF x > 139 AND x < 170 THEN IF y = 21 THEN segm = 1: GOTO m6seg15
IF y > 29 AND y < 51 THEN IF x = 6 THEN segm = 0: GOTO m6seg17
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END

m6seg17: CLS ' >>> SEGMENT #17 <<<
'######### LEVEL ###########
LINE (5, 20)-(5, 190), 14
LINE (5, 190)-(310, 190), 14
LINE (310, 190)-(310, 20), 14
LINE (5, 20)-(310, 20), 14
LINE (310, 30)-(310, 60), 0
PCOPY 1, 0
'######### PROGRAM ######
IF segm = 0 THEN x = 290
btt$ = "Batt: [||||||||||]": C = 10
IF i = 0 THEN stat$ = "Collect Item:"
IF i = 1 THEN stat$ = "Exit Cave:Got Item"
DO
press$ = INKEY$
LOCATE 1, 1: COLOR C: PRINT btt$
LOCATE 2, 1: COLOR 9: PRINT stat$
'######## Graphics Code #######
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), sch1, PSET
IF d = 2 THEN PUT (x, y), scv1, PSET
IF d = 3 THEN PUT (x, y), sch2, PSET
IF d = 4 THEN PUT (x, y), scv2, PSET
IF press$ = CHR$(0) + CHR$(75) THEN d = 2
IF press$ = CHR$(0) + CHR$(72) THEN d = 1
IF press$ = CHR$(0) + CHR$(77) THEN d = 4
IF press$ = CHR$(0) + CHR$(80) THEN d = 3
IF press$ = CHR$(0) + CHR$(72) THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(80) THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(75) THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(77) THEN x = x + 1: PLAY "A"
IF press$ = "4" THEN d = 2
IF press$ = "8" THEN d = 1
IF press$ = "2" THEN d = 3
IF press$ = "6" THEN d = 4
IF press$ = "8" THEN y = y - 1: PLAY "A"
IF press$ = "2" THEN y = y + 1: PLAY "A"
IF press$ = "4" THEN x = x - 1: PLAY "A"
IF press$ = "6" THEN x = x + 1: PLAY "A"
'########### BATTERY CODE ############
btt = btt + 1
IF (btt / 100) > 1800 THEN GOTO dbtt6
IF y < 189 AND (btt / 100) THEN btt$ = "Batt: [||||||||||]"
IF (btt / 100) > 180 THEN btt$ = "Batt: [||||||||| ]": C = 10
IF (btt / 100) > 360 THEN btt$ = "Batt: [||||||||  ]": C = 10
IF (btt / 100) > 540 THEN btt$ = "Batt: [|||||||   ]": C = 10
IF (btt / 100) > 720 THEN btt$ = "Batt: [||||||    ]": C = 14
IF (btt / 100) > 900 THEN btt$ = "Batt: [|||||     ]": C = 14
IF (btt / 100) > 1080 THEN btt$ = "Batt: [||||      ]": C = 14
IF (btt / 100) > 1260 THEN btt$ = "Batt: [|||       ]": C = 12
IF (btt / 100) > 1440 THEN btt$ = "Batt: [||        ]": C = 12
IF (btt / 100) > 1620 THEN btt$ = "Batt: [|         ]": C = 12
'########## BARRIER CODES #######
IF x = 5 OR x = 301 THEN GOTO mcrash6
IF y = 20 OR y = 181 THEN GOTO mcrash6
'########## DOOR CODES ###########
IF y > 29 AND y < 51 THEN IF x = 300 THEN segm = 1: GOTO m6seg16
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END

m6seg18: CLS '               >>> SEGMENT #18 <<<
'######### LEVEL ###########
LINE (5, 20)-(5, 190), 14
LINE (5, 190)-(310, 190), 14
LINE (310, 190)-(310, 20), 14
LINE (5, 20)-(310, 20), 14
LINE (140, 20)-(170, 20), 0
PCOPY 1, 0
'######### PROGRAM ######
IF segm = 0 THEN y = 22
btt$ = "Batt: [||||||||||]": C = 10
IF i = 0 THEN stat$ = "Collect Item:"
IF i = 1 THEN stat$ = "Exit Cave:Got Item"
DO
press$ = INKEY$
LOCATE 1, 1: COLOR C: PRINT btt$
LOCATE 2, 1: COLOR 9: PRINT stat$
'######## Graphics Code #######
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), sch1, PSET
IF d = 2 THEN PUT (x, y), scv1, PSET
IF d = 3 THEN PUT (x, y), sch2, PSET
IF d = 4 THEN PUT (x, y), scv2, PSET
IF press$ = CHR$(0) + CHR$(75) THEN d = 2
IF press$ = CHR$(0) + CHR$(72) THEN d = 1
IF press$ = CHR$(0) + CHR$(77) THEN d = 4
IF press$ = CHR$(0) + CHR$(80) THEN d = 3
IF press$ = CHR$(0) + CHR$(72) THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(80) THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(75) THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(77) THEN x = x + 1: PLAY "A"
IF press$ = "4" THEN d = 2
IF press$ = "8" THEN d = 1
IF press$ = "2" THEN d = 3
IF press$ = "6" THEN d = 4
IF press$ = "8" THEN y = y - 1: PLAY "A"
IF press$ = "2" THEN y = y + 1: PLAY "A"
IF press$ = "4" THEN x = x - 1: PLAY "A"
IF press$ = "6" THEN x = x + 1: PLAY "A"
'########### BATTERY CODE ############
btt = btt + 1
IF (btt / 100) > 1800 THEN GOTO dbtt6
IF y < 189 AND (btt / 100) THEN btt$ = "Batt: [||||||||||]"
IF (btt / 100) > 180 THEN btt$ = "Batt: [||||||||| ]": C = 10
IF (btt / 100) > 360 THEN btt$ = "Batt: [||||||||  ]": C = 10
IF (btt / 100) > 540 THEN btt$ = "Batt: [|||||||   ]": C = 10
IF (btt / 100) > 720 THEN btt$ = "Batt: [||||||    ]": C = 14
IF (btt / 100) > 900 THEN btt$ = "Batt: [|||||     ]": C = 14
IF (btt / 100) > 1080 THEN btt$ = "Batt: [||||      ]": C = 14
IF (btt / 100) > 1260 THEN btt$ = "Batt: [|||       ]": C = 12
IF (btt / 100) > 1440 THEN btt$ = "Batt: [||        ]": C = 12
IF (btt / 100) > 1620 THEN btt$ = "Batt: [|         ]": C = 12
'########## BARRIER CODES #######
IF x = 5 OR x = 301 THEN GOTO mcrash6
IF y = 20 OR y = 181 THEN GOTO mcrash6
'########## DOOR CODES ###########
IF x > 139 AND x < 170 THEN IF y = 21 THEN segm = 2: GOTO m6seg10
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END


mfinish6: CLS
COLOR 10
PRINT " You completed the mission!"
PRINT
PRINT " You completed the game!"
PRINT
COLOR 9
PRINT
PRINT " This level's code is: AMAZEME"
PRINT " Bonus Menu code is: ROBOBONUS"
PRINT
PRINT " Press SPACEBAR to continue..."
PCOPY 1, 0
DO
press$ = INKEY$
LOOP UNTIL press$ = " "
CLS
SCREEN 13
CALL Ending

END

dbtt6: CLS
COLOR 14
PRINT " Your battery ran out!"
PRINT
PRINT " Esc. = Exit| Try again?"
PRINT
COLOR 9
PRINT
PRINT " This level's code is: AMAZEME"
PRINT " Next level's code is: >>did not pass<<"
PRINT
PRINT " Press SPACEBAR to Retry..."
PCOPY 1, 0
btt = 0
DO
press$ = INKEY$
IF press$ = CHR$(27) THEN END
LOOP UNTIL press$ = " "
segm = 0: dr = 0
GOTO m6seg1
END

mcrash6: CLS
COLOR 12
PRINT " You Crashed My Robot!"
PRINT
PRINT " Sorry, You are fired!"
PRINT
COLOR 9
PRINT
PRINT " This level's code is: AMAZEME"
PRINT " Next level's code is: >>did not pass<<"
PRINT
PRINT " Press SPACEBAR to continue..."
PCOPY 1, 0
DO
press$ = INKEY$
LOOP UNTIL press$ = " "
CLS
SCREEN 13
CALL Menu

END
END SUB

SUB Missionb
CLS
SCREEN 13
COLOR 10
PRINT " RoboRaiders: >>Mission-Bots>>"
LOCATE 20, 3: PRINT "Press 'Enter' to select"
LOCATE 22, 2: PRINT "Press 'F1' for Help, Press 'Esc' to Exit"
C = 1
DO
press$ = INKEY$
IF C = 1 THEN LOCATE 10, 15: COLOR 10: PRINT ">>SCORPIAN>>": LOCATE 11, 15: COLOR 15: PRINT ">>CREEPER<<": LOCATE 13, 15: COLOR 15: PRINT ">>PAGE-2<<"
IF C = 2 THEN LOCATE 10, 15: COLOR 15: PRINT ">>SCORPIAN<<": LOCATE 11, 15: COLOR 9: PRINT ">>CREEPER>>": LOCATE 13, 15: COLOR 15: PRINT ">>PAGE-2<<"
IF C = 3 THEN LOCATE 10, 15: COLOR 15: PRINT ">>SCORPIAN<<": LOCATE 11, 15: COLOR 15: PRINT ">>CREEPER<<": LOCATE 13, 15: COLOR 14: PRINT ">>PAGE-2>>"
IF C = 2 THEN IF press$ = CHR$(0) + CHR$(80) THEN C = 3: PLAY "D16"
IF C = 1 THEN IF press$ = CHR$(0) + CHR$(80) THEN C = 2: PLAY "D16"
IF C = 2 THEN IF press$ = CHR$(0) + CHR$(72) THEN C = 1: PLAY "D16"
IF C = 3 THEN IF press$ = CHR$(0) + CHR$(72) THEN C = 2: PLAY "D16"
IF C = 2 THEN IF press$ = "2" THEN C = 3: PLAY "D16"
IF C = 1 THEN IF press$ = "2" THEN C = 2: PLAY "D16"
IF C = 2 THEN IF press$ = "8" THEN C = 1: PLAY "D16"
IF C = 3 THEN IF press$ = "8" THEN C = 2: PLAY "D16"
IF C = 1 THEN IF press$ = CHR$(13) THEN PLAY "B16": CALL Scorp
IF C = 2 THEN IF press$ = CHR$(13) THEN PLAY "B16": CALL Creep
IF C = 3 THEN IF press$ = CHR$(13) THEN PLAY "B16": CALL Missionb2
IF press$ = CHR$(0) + ";" THEN CALL Help
LOOP UNTIL press$ = CHR$(27)
END

END SUB

SUB Missionb2
CLS
SCREEN 13
COLOR 10
PRINT " RoboRaiders: >>Mission-Bots>>"
LOCATE 20, 3: PRINT "Press 'Enter' to select"
LOCATE 22, 2: PRINT "Press 'F1' for Help, Press 'Esc' to Exit"
C = 1
DO
press$ = INKEY$
IF C = 1 THEN LOCATE 10, 15: COLOR 10: PRINT ">>DRILL-BOT>>": LOCATE 11, 15: COLOR 15: PRINT ">>DROP-BOT<<": LOCATE 13, 15: COLOR 15: PRINT ">>BONUS-MENU<<"
IF C = 2 THEN LOCATE 10, 15: COLOR 15: PRINT ">>DRILL-BOT<<": LOCATE 11, 15: COLOR 9: PRINT ">>DROP-BOT>>": LOCATE 13, 15: COLOR 15: PRINT ">>BONUS-MENU<<"
IF C = 3 THEN LOCATE 10, 15: COLOR 15: PRINT ">>DRILL-BOT<<": LOCATE 11, 15: COLOR 15: PRINT ">>DROP-BOT<<": LOCATE 13, 15: COLOR 14: PRINT ">>BONUS-MENU>>"
IF C = 2 THEN IF press$ = CHR$(0) + CHR$(80) THEN C = 3: PLAY "D16"
IF C = 1 THEN IF press$ = CHR$(0) + CHR$(80) THEN C = 2: PLAY "D16"
IF C = 2 THEN IF press$ = CHR$(0) + CHR$(72) THEN C = 1: PLAY "D16"
IF C = 3 THEN IF press$ = CHR$(0) + CHR$(72) THEN C = 2: PLAY "D16"
IF C = 2 THEN IF press$ = "2" THEN C = 3: PLAY "D16"
IF C = 1 THEN IF press$ = "2" THEN C = 2: PLAY "D16"
IF C = 2 THEN IF press$ = "8" THEN C = 1: PLAY "D16"
IF C = 3 THEN IF press$ = "8" THEN C = 2: PLAY "D16"
IF C = 1 THEN IF press$ = CHR$(13) THEN PLAY "B16": CALL Dril
IF C = 2 THEN IF press$ = CHR$(13) THEN PLAY "B16": CALL Drop
IF C = 3 THEN IF press$ = CHR$(13) THEN PLAY "B16": CALL Bonus
IF press$ = CHR$(0) + ";" THEN CALL Help
LOOP UNTIL press$ = CHR$(27)
END

END SUB

SUB Robopic
CLS
SCREEN 13
COLOR 10
PRINT " RoboRaiders: >>Robo-Pics>>"
LOCATE 20, 3: PRINT "Press 'Enter' to select"
LOCATE 22, 2: PRINT "Press 'F1' for Help, Press 'Esc' to Exit"
C = 1
DO
press$ = INKEY$
IF C = 1 THEN LOCATE 10, 15: COLOR 10: PRINT ">>TRAINER-BOTS>>": LOCATE 11, 15: COLOR 15: PRINT ">>MISSION-BOTS<<": LOCATE 13, 15: COLOR 15: PRINT ">>BONUS-MENU<<"
IF C = 2 THEN LOCATE 10, 15: COLOR 15: PRINT ">>TRAINER-BOTS<<": LOCATE 11, 15: COLOR 9: PRINT ">>MISSION-BOTS>>": LOCATE 13, 15: COLOR 15: PRINT ">>BONUS-MENU<<"
IF C = 3 THEN LOCATE 10, 15: COLOR 15: PRINT ">>TRAINER-BOTS<<": LOCATE 11, 15: COLOR 15: PRINT ">>MISSION-BOTS<<": LOCATE 13, 15: COLOR 14: PRINT ">>BONUS-MENU>>"
IF C = 2 THEN IF press$ = CHR$(0) + CHR$(80) THEN C = 3: PLAY "D16"
IF C = 1 THEN IF press$ = CHR$(0) + CHR$(80) THEN C = 2: PLAY "D16"
IF C = 2 THEN IF press$ = CHR$(0) + CHR$(72) THEN C = 1: PLAY "D16"
IF C = 3 THEN IF press$ = CHR$(0) + CHR$(72) THEN C = 2: PLAY "D16"
IF C = 2 THEN IF press$ = "2" THEN C = 3: PLAY "D16"
IF C = 1 THEN IF press$ = "2" THEN C = 2: PLAY "D16"
IF C = 2 THEN IF press$ = "8" THEN C = 1: PLAY "D16"
IF C = 3 THEN IF press$ = "8" THEN C = 2: PLAY "D16"
IF C = 1 THEN IF press$ = CHR$(13) THEN PLAY "B16": CALL Trainerb
IF C = 2 THEN IF press$ = CHR$(13) THEN PLAY "B16": CALL Missionb
IF C = 3 THEN IF press$ = CHR$(13) THEN PLAY "B16": CALL Bonus
IF press$ = CHR$(0) + ";" THEN CALL Help
LOOP UNTIL press$ = CHR$(27)
END

END SUB

SUB Scorp
CLS
SCREEN 13
LINE (20, 30)-(160, 50), 14, BF
LINE (22, 36)-(158, 36), 8
LINE (22, 60)-(158, 60), 8
'*** ARM ***
LINE (150, 29)-(60, 5), 12
LINE (130, 29)-(60, 10), 12
LINE (60, 5)-(10, 20), 12
LINE (60, 10)-(14, 24), 12
LINE (150, 29)-(130, 29), 12
LINE (10, 20)-(14, 24), 12
PAINT (60, 7), 12
'*** GRIP ***
LINE (15, 18)-(0, 24), 7
LINE (19, 22)-(4, 28), 7
LINE (15, 18)-(19, 22), 7
LINE (0, 24)-(4, 28), 7
PAINT (4, 26), 7
'*** WHEELS ***
CIRCLE (22, 48), 15, 7
PAINT (22, 48), 7
PSET (22, 48), 0
CIRCLE (158, 48), 15, 7
PAINT (158, 48), 7
PSET (158, 48), 0
'**TEXT**
LOCATE 10, 1: PRINT " Scorpian: Mission 1-2 & 6:"
LOCATE 12, 1: PRINT "  This robot has a grip mounted on a"
LOCATE 13, 1: PRINT "  boom which gives it the appearance"
LOCATE 14, 1: PRINT "  of a scorpian. Its design allows it"
LOCATE 15, 1: PRINT "  to pick up larger items and move   "
LOCATE 16, 1: PRINT "  over rough terrain."
COLOR 10
LOCATE 20, 1: PRINT " Press SPACEBAR to continue..."
DO
press$ = INKEY$
LOOP UNTIL press$ = " "
CALL Missionb

END SUB

SUB Tbot1
CLS
SCREEN 13
LINE (20, 20)-(160, 50), 10, BF
LINE (22, 36)-(158, 36), 8
LINE (22, 60)-(158, 60), 8
CIRCLE (22, 48), 15, 7
PAINT (22, 48), 7
PSET (22, 48), 0
CIRCLE (158, 48), 15, 7
PAINT (158, 48), 7
PSET (158, 48), 0
LOCATE 10, 1: PRINT " Trainer-Bot: Test 1-2:"
LOCATE 12, 1: PRINT "  A simple desinged robot for easy"
LOCATE 13, 1: PRINT "  repairs. Used for the first two"
LOCATE 14, 1: PRINT "  test in case of a crash."
COLOR 10
LOCATE 17, 1: PRINT " Press SPACEBAR to continue..."
DO
press$ = INKEY$
LOOP UNTIL press$ = " "
CALL Trainerb
END SUB

SUB Tbot2
CLS
SCREEN 13
LINE (10, 25)-(20, 45), 8, BF
LINE (20, 20)-(160, 50), 10, BF
LINE (22, 36)-(158, 36), 8
LINE (22, 60)-(158, 60), 8
CIRCLE (22, 48), 15, 7
PAINT (22, 48), 7
PSET (22, 48), 0
CIRCLE (158, 48), 15, 7
PAINT (158, 48), 7
PSET (158, 48), 0
LOCATE 10, 1: PRINT " Trainer-Bot: Test 3:"
LOCATE 12, 1: PRINT "  A simple desinged robot for easy"
LOCATE 13, 1: PRINT "  repairs. Has small grip on front"
LOCATE 14, 1: PRINT "  for picking up small items."
COLOR 10
LOCATE 17, 1: PRINT " Press SPACEBAR to continue..."
DO
press$ = INKEY$
LOOP UNTIL press$ = " "
CALL Trainerb

END SUB

SUB Test001
DIM hor(100), vert(100), mask(100)
PLAY "MB L64 <<<"
CLS
SCREEN 7, 0, 1, 0
COLOR 15
PRINT " Test Status:"
PRINT
PRINT "      This test is for Navigation."
PRINT " My fine robots are powered by none"
PRINT " than very two powerful 550-Can R/C"
PRINT " car motors. This can leave a great"
PRINT " deal of damage to them or whatever"
PRINT " they hit. So to pass this test, "
PRINT " make it to the other side of the "
PRINT " maze unharmed."
PRINT
PRINT
PRINT
COLOR 10
PRINT " Press SPACEBAR to continue..."
PCOPY 1, 0
DO
press$ = INKEY$
LOOP UNTIL press$ = " "

test1: CLS
'############# ROBOT ##########
LINE (1, 1)-(2, 10), 8, BF
LINE (10, 1)-(9, 10), 8, BF
LINE (3, 2)-(8, 9), 10, BF
PCOPY 1, 0
GET (1, 1)-(10, 10), hor
CLS
LINE (1, 1)-(10, 2), 8, BF
LINE (1, 10)-(10, 9), 8, BF
LINE (2, 3)-(9, 8), 10, BF
GET (1, 1)-(10, 10), vert
PCOPY 1, 0
CLS
GET (1, 1)-(10, 10), mask
'############# LEVEL ##########
'vertseg1
LINE (150, 200)-(150, 150), 9
LINE (170, 200)-(170, 170), 9
'horseg1
LINE (170, 170)-(250, 170), 9
LINE (150, 150)-(230, 150), 9
'vertseg2
LINE (250, 170)-(250, 100), 9
LINE (230, 150)-(230, 120), 9
'horseg2
LINE (250, 100)-(100, 100), 9
LINE (230, 120)-(80, 120), 9
'vertseg3
LINE (100, 100)-(100, 80), 9
LINE (80, 120)-(80, 60), 9
'horseg3
LINE (100, 80)-(170, 80), 9
LINE (80, 60)-(150, 60), 9
'vertseg4
LINE (170, 80)-(170, 0), 9
LINE (150, 60)-(150, 0), 9
PCOPY 1, 0
'######## PROGRAM #######
d = 1
x = 155: y = 180
oldx = x: oldy = y
seg1:
DO
press$ = INKEY$
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), hor, PSET
IF d = 2 THEN PUT (x, y), vert, PSET
'####### Arrowkeys #########
IF d = 1 THEN IF press$ = CHR$(0) + "K" THEN d = 2
IF d = 2 THEN IF press$ = CHR$(0) + "H" THEN d = 1
IF d = 1 THEN IF press$ = CHR$(0) + "M" THEN d = 2
IF d = 2 THEN IF press$ = CHR$(0) + "P" THEN d = 1
IF press$ = CHR$(0) + "H" THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + "P" THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + "K" THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + "M" THEN x = x + 1: PLAY "A"
IF y > 160 AND x = 150 THEN GOTO tcrash1
IF y > 160 AND x = 161 THEN GOTO tcrash1
IF y > 160 AND y = 190 THEN GOTO tcrash1
IF x < 230 AND y < 160 AND y >= 150 AND y = 150 THEN GOTO tcrash1
IF x < 230 AND y < 160 AND y >= 150 AND x = 150 THEN GOTO tcrash1
IF x > 160 AND x < 230 AND y = 150 THEN GOTO tcrash1
IF x > 160 AND x < 230 AND y = 161 THEN GOTO tcrash1
IF x = 241 THEN GOTO tcrash1
IF x > 230 AND x < 240 AND y = 161 THEN GOTO tcrash1
IF y > 111 AND y < 150 AND x = 230 THEN GOTO tcrash1
IF x < 230 AND x > 81 AND y = 111 THEN GOTO tcrash1
IF x = 80 THEN GOTO tcrash1
IF x < 240 AND x > 91 AND y = 100 THEN GOTO tcrash1
IF y < 100 AND y > 71 AND x = 91 THEN GOTO tcrash1
IF x < 160 AND x > 91 AND y = 71 THEN GOTO tcrash1
IF x < 150 AND x > 81 AND y = 60 THEN GOTO tcrash1
IF y < 70 AND x = 161 THEN GOTO tcrash1
IF y < 60 AND x = 150 THEN GOTO tcrash1
IF y = 2 THEN GOTO tfinish1
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END

tfinish1: CLS
COLOR 10
PRINT " You Passed!"
PRINT
PRINT " You can take Test2"
PRINT
COLOR 9
PRINT
PRINT " This level's code is: TEST001"
PRINT " Next level's code is: TEST002"
PRINT
PRINT " Press SPACEBAR to continue..."
PCOPY 1, 0
DO
press$ = INKEY$
LOOP UNTIL press$ = " "
CLS
SCREEN 13
CALL Menu2

tcrash1: CLS
COLOR 12
PRINT " You Crashed!"
PRINT
PRINT " Sorry, You do not pass."
PRINT
COLOR 9
PRINT
PRINT " This level's code is: TEST001"
PRINT " Next level's code is: >>did not pass<<"
PRINT
PRINT " Press SPACEBAR to continue..."
PCOPY 1, 0
DO
press$ = INKEY$
LOOP UNTIL press$ = " "
CLS
SCREEN 13
CALL Menu
END SUB

SUB Test002
DIM hor(100), vert(100), mask(100)
PLAY "MB L64 <<<"
CLS
SCREEN 7, 0, 1, 0
COLOR 15
PRINT " Test Status:"
PRINT
PRINT "      This test is for Balance."
PRINT " In order to work your way though"
PRINT " the many dangers of a robot, you"
PRINT " must be well balanced and on gaurd."
PRINT " This level includes two water pools "
PRINT " that can destoy robots in a blink"
PRINT " of an eye. To pass, Don't hit the  "
PRINT " walls, or water."
PRINT
PRINT
PRINT
COLOR 10
PRINT " Press SPACEBAR to continue..."
PCOPY 1, 0
DO
press$ = INKEY$
LOOP UNTIL press$ = " "

test2: CLS
'############# ROBOT ##########
LINE (1, 1)-(2, 10), 8, BF
LINE (10, 1)-(9, 10), 8, BF
LINE (3, 2)-(8, 9), 10, BF
PCOPY 1, 0
GET (1, 1)-(10, 10), hor
CLS
LINE (1, 1)-(10, 2), 8, BF
LINE (1, 10)-(10, 9), 8, BF
LINE (2, 3)-(9, 8), 10, BF
GET (1, 1)-(10, 10), vert
PCOPY 1, 0
CLS
GET (1, 1)-(10, 10), mask
'############# LEVEL ##########
'vertseg1
LINE (150, 200)-(150, 150), 9
LINE (170, 200)-(170, 170), 9
'horseg1
LINE (170, 170)-(250, 170), 9
LINE (150, 150)-(230, 150), 9
'vertseg2
LINE (250, 170)-(250, 100), 9
LINE (230, 150)-(230, 120), 9
'horseg2
LINE (250, 100)-(100, 100), 9
LINE (230, 120)-(80, 120), 9
'vertseg3
LINE (100, 100)-(100, 80), 9
LINE (80, 120)-(80, 60), 9
'horseg3
LINE (100, 80)-(170, 80), 9
LINE (80, 60)-(150, 60), 9
'vertseg4
LINE (170, 80)-(170, 0), 9
LINE (150, 60)-(150, 0), 9
'pools
LINE (150, 150)-(230, 120), 1, BF
LINE (170, 80)-(100, 100), 1, BF
PCOPY 1, 0
'######## PROGRAM #######
d = 1
x = 155: y = 180
oldx = x: oldy = y
DO
press$ = INKEY$
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), hor, PSET
IF d = 2 THEN PUT (x, y), vert, PSET
'######## ARROWKEYS ######
IF d = 1 THEN IF press$ = CHR$(0) + "K" THEN d = 2
IF d = 2 THEN IF press$ = CHR$(0) + "H" THEN d = 1
IF d = 1 THEN IF press$ = CHR$(0) + "M" THEN d = 2
IF d = 2 THEN IF press$ = CHR$(0) + "P" THEN d = 1
IF press$ = CHR$(0) + "H" THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + "P" THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + "K" THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + "M" THEN x = x + 1: PLAY "A"
IF y > 160 AND x = 150 THEN GOTO tcrash2
IF y > 160 AND x = 161 THEN GOTO tcrash2
IF y > 160 AND y = 190 THEN GOTO tcrash2
IF x < 230 AND y < 160 AND y >= 150 AND y = 150 THEN GOTO tcrash2
IF x < 230 AND y < 160 AND y >= 150 AND x = 150 THEN GOTO tcrash2
IF x > 160 AND x < 230 AND y = 150 THEN GOTO tcrash2
IF x > 160 AND x < 230 AND y = 161 THEN GOTO tcrash2
IF x = 241 THEN GOTO tcrash2
IF x > 230 AND x < 240 AND y = 161 THEN GOTO tcrash2
IF y > 111 AND y < 150 AND x = 230 THEN GOTO tcrash2
IF x < 230 AND x > 81 AND y = 111 THEN GOTO tcrash2
IF x = 80 THEN GOTO tcrash2
IF x < 240 AND x > 91 AND y = 100 THEN GOTO tcrash2
IF y < 100 AND y > 71 AND x = 91 THEN GOTO tcrash2
IF x < 160 AND x > 91 AND y = 71 THEN GOTO tcrash2
IF x < 150 AND x > 81 AND y = 60 THEN GOTO tcrash2
IF y < 70 AND x = 161 THEN GOTO tcrash2
IF y < 60 AND x = 150 THEN GOTO tcrash2
IF y = 2 THEN GOTO tfinish2
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END

tfinish2: CLS
COLOR 10
PRINT " You Passed!"
PRINT
PRINT " You can take Test3"
PRINT
COLOR 9
PRINT
PRINT " This level's code is: TEST002"
PRINT " Next level's code is: TEST003"
PRINT
PRINT " Press SPACEBAR to continue..."
PCOPY 1, 0
DO
press$ = INKEY$
LOOP UNTIL press$ = " "
CLS
SCREEN 13
CALL Menu3

tcrash2: CLS
COLOR 12
PRINT " You Crashed!"
PRINT
PRINT " Sorry, You do not pass."
PRINT
COLOR 9
PRINT
PRINT " This level's code is: TEST002"
PRINT " Next level's code is: >>did not pass<<"
PRINT
PRINT " Press SPACEBAR to continue..."
PCOPY 1, 0
DO
press$ = INKEY$
LOOP UNTIL press$ = " "
CLS
SCREEN 13
CALL Menu

END SUB

SUB Test003
DIM hor1(100), hor2(100), vert1(100), vert2(100), mask(100)
PLAY "MB L64 <<<"
CLS
SCREEN 7, 0, 1, 0
COLOR 15
PRINT " Test Status:"
PRINT
PRINT "      This test is for Collecting."
PRINT " One of the main jobs of a Robo-"
PRINT " Raider is collecting objects from"
PRINT " ruins. This is the same level you"
PRINT " last piloted, but with objets to"
PRINT " pick up.(this Robot picks up an"
PRINT " item automaticly, just by bump "
PRINT " into it) To pass, collect all "
PRINT " items (HINT: Get the items to"
PRINT " hit center of the grip)"
PRINT
PRINT
PRINT
COLOR 10
PRINT " Press SPACEBAR to continue..."
PCOPY 1, 0
DO
press$ = INKEY$
LOOP UNTIL press$ = " "

test3: CLS
'############# ROBOT ##########
LINE (1, 1)-(2, 10), 8, BF
LINE (10, 1)-(9, 10), 8, BF
LINE (3, 2)-(8, 9), 10, BF
PSET (4, 1), 7: PSET (7, 1), 7
PCOPY 1, 0
GET (1, 1)-(10, 10), hor1
CLS
LINE (1, 1)-(2, 10), 8, BF
LINE (10, 1)-(9, 10), 8, BF
LINE (3, 2)-(8, 9), 10, BF
PSET (4, 10), 7: PSET (7, 10), 7
PCOPY 1, 0
GET (1, 1)-(10, 10), hor2
CLS
LINE (1, 1)-(10, 2), 8, BF
LINE (1, 10)-(10, 9), 8, BF
LINE (2, 3)-(9, 8), 10, BF
PSET (1, 4), 7: PSET (1, 7), 7
GET (1, 1)-(10, 10), vert1
PCOPY 1, 0
CLS
LINE (1, 1)-(10, 2), 8, BF
LINE (1, 10)-(10, 9), 8, BF
LINE (2, 3)-(9, 8), 10, BF
PSET (10, 4), 7: PSET (10, 7), 7
GET (1, 1)-(10, 10), vert2
PCOPY 1, 0
CLS

GET (1, 1)-(10, 10), mask
'############# LEVEL ##########
'vertseg1
LINE (150, 200)-(150, 150), 9
LINE (170, 200)-(170, 170), 9
'horseg1
LINE (170, 170)-(250, 170), 9
LINE (150, 150)-(230, 150), 9
'vertseg2
LINE (250, 170)-(250, 100), 9
LINE (230, 150)-(230, 120), 9
'horseg2
LINE (250, 100)-(100, 100), 9
LINE (230, 120)-(80, 120), 9
'vertseg3
LINE (100, 100)-(100, 80), 9
LINE (80, 120)-(80, 60), 9
'horseg3
LINE (100, 80)-(170, 80), 9
LINE (80, 60)-(150, 60), 9
'vertseg4
LINE (170, 80)-(170, 0), 9
LINE (150, 60)-(150, 0), 9
'pools
LINE (150, 150)-(230, 120), 1, BF
LINE (170, 80)-(100, 100), 1, BF
PCOPY 1, 0
'######## PROGRAM #######
d = 1
x = 155: y = 180
oldx = x: oldy = y
DO
press$ = INKEY$
LOCATE 1, 1: PRINT "Items:"; i
'######## Items Code ######
IF i1 = 0 THEN CIRCLE (160, 153), 1, 12 ELSE CIRCLE (160, 153), 1, 0
IF i2 = 0 THEN CIRCLE (236, 165), 1, 12 ELSE CIRCLE (236, 165), 1, 0
IF i3 = 0 THEN CIRCLE (240, 120), 1, 12 ELSE CIRCLE (240, 120), 1, 0
IF i4 = 0 THEN CIRCLE (90, 100), 1, 12 ELSE CIRCLE (90, 100), 1, 0
IF i5 = 0 THEN CIRCLE (130, 69), 1, 12 ELSE CIRCLE (130, 69), 1, 0
IF i6 = 0 THEN CIRCLE (159, 50), 1, 12 ELSE CIRCLE (159, 50), 1, 0

IF i1 = 0 THEN IF x = 155 OR x = 156 THEN IF y = 154 THEN i1 = 1: i = i + 1
IF i2 = 0 THEN IF x = 225 OR x = 237 THEN IF y = 160 THEN i2 = 1: i = i + 1
IF i2 = 0 THEN IF x = 231 OR x = 232 THEN IF y = 155 THEN i2 = 1: i = i + 1
IF i3 = 0 THEN IF x = 235 OR x = 236 THEN IF y = 121 OR y = 110 THEN i3 = 1: i = i + 1
IF i4 = 0 THEN IF x = 85 OR x = 86 THEN IF y = 101 OR y = 90 THEN i4 = 1: i = i + 1
IF i5 = 0 THEN IF y = 65 OR y = 64 THEN IF x = 120 OR x = 131 THEN i5 = 1: i = i + 1
IF i6 = 0 THEN IF x = 154 OR x = 155 THEN IF y = 51 OR y = 40 THEN i6 = 1: i = i + 1
'######## Graphics Code #######
PUT (oldx, oldy), mask, PSET
oldx = x: oldy = y
IF d = 1 THEN PUT (x, y), hor1, PSET
IF d = 2 THEN PUT (x, y), vert1, PSET
IF d = 3 THEN PUT (x, y), hor2, PSET
IF d = 4 THEN PUT (x, y), vert2, PSET
IF press$ = CHR$(0) + CHR$(75) THEN d = 2
IF press$ = CHR$(0) + CHR$(72) THEN d = 1
IF press$ = CHR$(0) + CHR$(77) THEN d = 4
IF press$ = CHR$(0) + CHR$(80) THEN d = 3
IF press$ = CHR$(0) + CHR$(72) THEN y = y - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(80) THEN y = y + 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(75) THEN x = x - 1: PLAY "A"
IF press$ = CHR$(0) + CHR$(77) THEN x = x + 1: PLAY "A"
IF press$ = "4" THEN d = 2
IF press$ = "8" THEN d = 1
IF press$ = "2" THEN d = 3
IF press$ = "6" THEN d = 4
IF press$ = "8" THEN y = y - 1: PLAY "A"
IF press$ = "2" THEN y = y + 1: PLAY "A"
IF press$ = "4" THEN x = x - 1: PLAY "A"
IF press$ = "6" THEN x = x + 1: PLAY "A"
'######## Barrier Code #######
IF y > 160 AND x = 150 THEN GOTO tcrash3
IF y > 160 AND x = 161 THEN GOTO tcrash3
IF y > 160 AND y = 190 THEN GOTO tcrash3
IF x < 230 AND y < 160 AND y >= 150 AND y = 150 THEN GOTO tcrash3
IF x < 230 AND y < 160 AND y >= 150 AND x = 150 THEN GOTO tcrash3
IF x > 160 AND x < 230 AND y = 150 THEN GOTO tcrash3
IF x > 160 AND x < 230 AND y = 161 THEN GOTO tcrash3
IF x = 241 THEN GOTO tcrash3
IF x > 230 AND x < 240 AND y = 161 THEN GOTO tcrash3
IF y > 111 AND y < 150 AND x = 230 THEN GOTO tcrash3
IF x < 230 AND x > 81 AND y = 111 THEN GOTO tcrash3
IF x = 80 THEN GOTO tcrash3
IF x < 240 AND x > 91 AND y = 100 THEN GOTO tcrash3
IF y < 100 AND y > 71 AND x = 91 THEN GOTO tcrash3
IF x < 160 AND x > 91 AND y = 71 THEN GOTO tcrash3
IF x < 150 AND x > 81 AND y = 60 THEN GOTO tcrash3
IF y < 70 AND x = 161 THEN GOTO tcrash3
IF y < 60 AND x = 150 THEN GOTO tcrash3
IF i < 6 AND y = 2 THEN GOTO tfail3
IF i = 6 AND y = 2 THEN GOTO tfinish3
PCOPY 1, 0
LOOP UNTIL press$ = CHR$(27)
END

tfinish3: CLS
COLOR 10
PRINT " You Passed!"
PRINT
PRINT " You are hired!"
PRINT
COLOR 9
PRINT
PRINT " This level's code is: TEST003"
PRINT " Next level's code is: POINTY"
PRINT
PRINT " Press SPACEBAR to continue..."
PCOPY 1, 0
DO
press$ = INKEY$
LOOP UNTIL press$ = " "
CLS
SCREEN 13
CALL Menu4

tcrash3: CLS
COLOR 12
PRINT " You Crashed!"
PRINT
PRINT " Sorry, You do not pass."
PRINT
COLOR 9
PRINT
PRINT " This level's code is: TEST003"
PRINT " Next level's code is: >>did not pass<<"
PRINT
PRINT " Press SPACEBAR to continue..."
PCOPY 1, 0
DO
press$ = INKEY$
LOOP UNTIL press$ = " "
CLS
SCREEN 13
CALL Menu

tfail3: CLS
COLOR 12
PRINT " You did not get all six items!"
PRINT
PRINT " Sorry, You do not pass."
PRINT
COLOR 9
PRINT
PRINT " This level's code is: TEST003"
PRINT " Next level's code is: >>did not pass<<"
PRINT
PRINT " Press SPACEBAR to continue..."
PCOPY 1, 0
DO
press$ = INKEY$
LOOP UNTIL press$ = " "
CLS
SCREEN 13
CALL Menu

END SUB

SUB Trailer
SCREEN 9
CLS
LOCATE 11, 20: PRINT "xtrGRAPHICS (TM)"
SLEEP (2)
CLS
LOCATE 11, 25: PRINT "xtrGRAPHICS Presents....."
SLEEP (4)
CLS
LOCATE 11, 30: PRINT "In a game where the need for speed is always great"
SLEEP (3)
SCREEN 7, 0, 1, 0
FOR i = 1 TO 100
x = INT(RND * 320) + 1
y = INT(RND * 200) + 1
PSET (x, y)
NEXT
CIRCLE (100, 100), 40, 14
PAINT (100, 100), 14
CIRCLE (130, 150), 30, 12
PAINT (130, 150), 12
CIRCLE (320, 200), 60, 9
PAINT (319, 198), 9
PCOPY 1, 0
FOR i = 1 TO 50000: NEXT

CLS
FOR i = 1 TO 100
x = INT(RND * 320) + 1
y = INT(RND * 200) + 1
PSET (x, y)
NEXT
CIRCLE (0, 100), 160, 12
PAINT (0, 100), 12

x1 = 160: y1 = 100
DO
press$ = INKEY$
CLS
FOR i = 1 TO 100
x = INT(RND * 320) + 1
y = INT(RND * 200) + 1
PSET (x, y)
NEXT
CIRCLE (0, 100), 160, 12
PAINT (0, 100), 12
PSET (x1, y1), 9
x1 = x1 + 1
PCOPY 1, 0
IF press$ <> "" THEN CALL Bonus
FOR i = 1 TO 1000: NEXT
LOOP UNTIL x1 >= 300

SCREEN 9
LOCATE 11, 20: PRINT "Where you travel faster than the speed  of light."
SLEEP (3)
CLS
SCREEN 9
LOCATE 11, 20: PRINT "And planet travel is all you know."
SLEEP (3)

SCREEN 7, 0, 1, 0
x1 = 160: y1 = 190:
DO
press$ = INKEY$
CLS
FOR i = 1 TO 100
x = INT(RND * 320) + 1
y = INT(RND * 200) + 1
PSET (x, y)
NEXT
PSET (x1, y1), 9
y1 = y1 - 1
IF y1 <= 100 THEN GOTO iwarp
PCOPY 1, 0
IF press$ <> "" THEN CALL Bonus
FOR i = 1 TO 1000: NEXT
LOOP
iwarp: cr = 1:
DO
press$ = INKEY$
CLS
FOR i = 1 TO 100
x = INT(RND * 320) + 1
y = INT(RND * 200) + 1
PSET (x, y)
NEXT
CIRCLE (160, 100), cr, 10
LINE (160, 100)-(160, y1), 9
y1 = y1 - 5
cr = cr + 1
PCOPY 1, 0
IF press$ <> "" THEN CALL Bonus
FOR i = 1 TO 500: NEXT
LOOP UNTIL cr = 20

SCREEN 9
LOCATE 11, 20: PRINT "Hold on thight for this one...."
SLEEP (3)

SCREEN 7, 0, 1, 0
x1 = 1: y1 = 100
DO
press$ = INKEY$
CLS
FOR i = 1 TO 100
x = INT(RND * 320) + 1
y = INT(RND * 200) + 1
PSET (x, y)
NEXT
CIRCLE (320, 100), 160, 10
PAINT (300, 100), 10
PSET (x1, y1), 9
x1 = x1 + 1
PCOPY 1, 0
IF press$ <> "" THEN CALL Bonus
FOR i = 1 TO 1000: NEXT
LOOP UNTIL x1 >= 160

SCREEN 9
LOCATE 11, 20: PRINT "There are more planets than you think..."
SLEEP (3)

SCREEN 7, 0, 1, 0
x1 = 1: y1 = 30
DO
press$ = INKEY$
CLS
press$ = INKEY$
LINE (0, 0)-(320, 200), 1, BF
LINE (0, 175)-(320, 200), 8, BF
LINE (1, 100)-(40, 200), 7, BF
LINE (42, 50)-(90, 200), 7, BF
LINE (92, 70)-(140, 200), 7, BF
LINE (142, 90)-(190, 200), 7, BF
LINE (192, 110)-(260, 200), 7, BF
LINE (262, 20)-(320, 200), 7, BF
PSET (x1, y1), 9
x1 = x1 + 1
PCOPY 1, 0
IF press$ <> "" THEN CALL Bonus
FOR i = 1 TO 1000: NEXT
LOOP UNTIL x1 >= 262

CLS
DIM ship(1000)
LINE (1, 1)-(20, 35), 7, BF
LINE (10, 1)-(1, 10), 9
LINE (10, 1)-(20, 10), 9
LINE (1, 10)-(1, 30), 9
LINE (20, 10)-(20, 30), 9
LINE (1, 30)-(20, 30), 9
PAINT (10, 10), 9
LINE (10, 30)-(10, 35), 7
LINE (1, 30)-(1, 35), 7
LINE (20, 30)-(20, 35), 7
CIRCLE (10, 10), 5, 8
PAINT (10, 10), 8
PCOPY 1, 0
GET (1, 1)-(20, 35), ship
y1 = 160
DO
press$ = INKEY$
CLS
LINE (0, 0)-(320, 200), 7, BF
PUT (160, y1), ship, PSET
y1 = y1 - 1
PCOPY 1, 0
IF press$ <> "" THEN CALL Bonus
LOOP UNTIL y1 = 50

CLS
SCREEN 7, 0, 1, 0

FOR i = 1 TO 100
x = INT(RND * 320) + 1
y = INT(RND * 200) + 1
PSET (x, y)
NEXT
CIRCLE (100, 100), 40, 14
PAINT (100, 100), 14
CIRCLE (130, 150), 30, 12
PAINT (130, 150), 12
CIRCLE (320, 200), 60, 9
PAINT (319, 198), 9


LINE (60, 40)-(30, 60), 9
LINE (30, 60)-(60, 60), 9
LINE (60, 60)-(30, 80), 9

LINE (63, 50)-(63, 80), 9
LINE (63, 50)-(73, 55), 9
LINE (73, 55)-(63, 65), 9

CIRCLE (83, 50), 6, 9
LINE (88, 45)-(89, 55), 9

LINE (93, 48)-(100, 40), 9
LINE (93, 48)-(105, 50), 9

LINE (107, 45)-(117, 40), 9
LINE (107, 45)-(110, 35), 9
LINE (110, 35)-(117, 40), 9
LINE (107, 45)-(117, 45), 9

LINE (25, 85)-(147, 37), 9

'*************************

LINE (70, 90)-(75, 110), 9
LINE (75, 110)-(80, 88), 9
LINE (80, 88)-(85, 109), 9
LINE (85, 109)-(90, 86), 9

CIRCLE (100, 95), 6, 9
LINE (107, 98)-(102, 88), 9

LINE (109, 87)-(111, 98), 9
LINE (109, 87)-(116, 84), 9

LINE (119, 83)-(119, 101), 9
LINE (119, 83)-(129, 88), 9
LINE (129, 88)-(119, 92), 9

LINE (50, 121)-(140, 100), 9

PCOPY 1, 0
SLEEP (4)
CLS
SCREEN 13
CALL Bonus
END SUB

SUB Trainerb
CLS
SCREEN 13
COLOR 10
PRINT " RoboRaiders: >>Trainer-Bots>>"
LOCATE 20, 3: PRINT "Press 'Enter' to select"
LOCATE 22, 2: PRINT "Press 'F1' for Help, Press 'Esc' to Exit"
C = 1
DO
press$ = INKEY$
IF C = 1 THEN LOCATE 10, 15: COLOR 10: PRINT ">>TEST 1-2>>": LOCATE 11, 15: COLOR 15: PRINT ">>TEST 3<<": LOCATE 13, 15: COLOR 15: PRINT ">>BONUS-MENU<<"
IF C = 2 THEN LOCATE 10, 15: COLOR 15: PRINT ">>TEST 1-2<<": LOCATE 11, 15: COLOR 9: PRINT ">>TEST 3>>": LOCATE 13, 15: COLOR 15: PRINT ">>BONUS-MENU<<"
IF C = 3 THEN LOCATE 10, 15: COLOR 15: PRINT ">>TEST 1-2<<": LOCATE 11, 15: COLOR 15: PRINT ">>TEST 3<<": LOCATE 13, 15: COLOR 14: PRINT ">>BONUS-MENU>>"
IF C = 2 THEN IF press$ = CHR$(0) + CHR$(80) THEN C = 3: PLAY "D16"
IF C = 1 THEN IF press$ = CHR$(0) + CHR$(80) THEN C = 2: PLAY "D16"
IF C = 2 THEN IF press$ = CHR$(0) + CHR$(72) THEN C = 1: PLAY "D16"
IF C = 3 THEN IF press$ = CHR$(0) + CHR$(72) THEN C = 2: PLAY "D16"
IF C = 2 THEN IF press$ = "2" THEN C = 3: PLAY "D16"
IF C = 1 THEN IF press$ = "2" THEN C = 2: PLAY "D16"
IF C = 2 THEN IF press$ = "8" THEN C = 1: PLAY "D16"
IF C = 3 THEN IF press$ = "8" THEN C = 2: PLAY "D16"
IF C = 1 THEN IF press$ = CHR$(13) THEN PLAY "B16": CALL Tbot1
IF C = 2 THEN IF press$ = CHR$(13) THEN PLAY "B16": CALL Tbot2
IF C = 3 THEN IF press$ = CHR$(13) THEN PLAY "B16": CALL Bonus
IF press$ = CHR$(0) + ";" THEN CALL Help
LOOP UNTIL press$ = CHR$(27)
END

END SUB

