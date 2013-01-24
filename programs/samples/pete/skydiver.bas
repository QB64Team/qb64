menu:
CLS
LOCATE 10, 30
PRINT "1) Try first two levels"
LOCATE 12, 30
PRINT "2) See New Features"
LOCATE 14, 30
PRINT "3) Quit"
PRINT
PRINT "Select your choice"
DO
i$ = INKEY$
IF i$ = "1" THEN GOTO beginning
IF i$ = "2" THEN GOTO newfeatures
IF i$ = "3" THEN END
LOOP

beginning:
DIM ambulance(20, 10)
SCREEN 13
FOR y = 1 TO 10
FOR x = 1 TO 20
READ clr
IF clr = 1 THEN PSET (x, y), 15
IF clr = 2 THEN PSET (x, y), 4
IF clr = 3 THEN PSET (x, y), 3
IF clr = 4 THEN PSET (x, y), 4
IF clr = 7 THEN PSET (x, y), 7
NEXT x
NEXT y
GET (1, 1)-(20, 10), ambulance

RANDOMIZE TIMER / 3
lives = 5 'NUMBER OF TIMES PLAYER IS ALLOWED TO MISS POOL+++++DEFAULT = 5
score = 0 'SCORE THE PLAYER STARTS OUT WITH+++++DEFAULT = 0
poolwidth = 100 'WIDTH OF GOAL IN PIXELS+++++DEFAULT = 100
speed = 2000 'SPEED OF AIRPLANE+++++DEFAULT = 2000

CLS
PRINT "Welcome to Skydiver!"
PRINT "The object of the game is to"
PRINT "jump out of your airplane and"
PRINT "land in the pool. If you think"
PRINT "that you aren't going to make"
PRINT "it then you can use the arrow keys"
PRINT "when you are falling in the air."
PRINT "You must press space bar to jump."
PRINT "The pool will get smaller each time."
PRINT "You need 20 successful jumps for this"
PRINT "level."
PRINT
PRINT "Good Luck! Press enter."
DO
LOOP UNTIL INKEY$ = CHR$(13)
GOTO more


level2start:
score = 0
lives = 5
speed = 1000
poolwidth = 100


more:
CLS
x = 1 'STARTING LOCATION OF AIRPLANE AND SKYDIVER+++++DEFAULT = 1
y = 5 'STARTING LOCATION OF AIRPLANE AND SKYDIVER+++++DEFAULT = 5
poolx = INT(RND(1) * (320 - poolwidth)) + 1'RANDOM LOCATION OF POOL
LINE (1, 190)-(320, 200), 6, BF 'DRAW GRAVEL
LINE (1, 189)-(320, 189), 10 'DRAW GRASS
LINE (poolx, 189)-(poolx + poolwidth, 194), 1, BF 'DRAW POOL
LOCATE 3, 1
PRINT "Score: "; score
PRINT "Lives: "; lives
DO
        i$ = INKEY$
        x = x + 1
        CIRCLE (x, y), 5, 15
        PSET (x, y), 14
        IF x = 300 THEN x = 1
        FOR nothing = 1 TO speed
            nothing2 = nothing2 + 1
            IF nothing2 > 10000 THEN WAIT &H3DA, 8: WAIT &H3DA, 8, 8: nothing2 = 0
        NEXT nothing
        CIRCLE (x, y), 5, 0
        PSET (x, y), 0
        IF i$ = " " THEN GOTO drop
        LINE (295, 1)-(305, 10), 0, BF
LOOP UNTIL i$ = CHR$(27)
END

drop:
CIRCLE (x, y), 5, 15
FOR skyy = y TO 190 - y
        i$ = INKEY$
        IF i$ = CHR$(0) + CHR$(77) AND x <> 320 AND x <> 319 AND x <> 318 THEN x = x + 2
        IF i$ = CHR$(0) + CHR$(75) AND x <> 1 AND x <> 2 AND x <> 3 THEN x = x - 2
        PSET (x, skyy), 14
        FOR nothing = 1 TO speed
        NEXT nothing
        PSET (x, skyy), 0
NEXT skyy
FOR poolcheck = poolx TO poolx + poolwidth
        IF x = poolcheck THEN GOTO win
NEXT poolcheck

FOR amb = 300 TO x STEP -1
        PUT (amb, 179), ambulance
        FOR nothing = 1 TO speed: NEXT nothing
        LINE (amb, 179)-(amb + 20, 179 + 10), 0, BF
NEXT amb
PUT (amb, 179), ambulance
SLEEP 1
FOR amb = x TO 1 STEP -1
        PUT (amb, 179), ambulance
        FOR nothing = 1 TO speed: NEXT nothing
        LINE (amb, 179)-(amb + 20, 179 + 10), 0, BF
NEXT amb
lives = lives - 1
IF lives = 0 THEN GOTO lose
GOTO more

win:
score = score + 1
poolwidth = poolwidth - 5
IF score >= 20 THEN GOTO level2
GOTO more

lose:
LOCATE 12, 10
PRINT "Sorry, you have lost!"
LOCATE 13, 10
PRINT "You ended up with "; score
LOCATE 14, 10
PRINT "successful dives!"
LOCATE 15, 10
PRINT "Congratulations!"
DO
LOOP UNTIL INKEY$ = CHR$(13)
END

level2:
IF speed = 1000 THEN GOTO level3
CLS
PRINT "Congratulations! You made it!"
PRINT "Now you can go to level 2!"
PRINT "This time you fall faster, and"
PRINT "still need 20 successful jumps!"
PRINT
PRINT "Press enter to start."
DO
LOOP UNTIL INKEY$ = CHR$(13)
GOTO level2start


level3:
CLS
PRINT "Congratulations! You have finished"
PRINT "the first 2 levels in this game demo!"
PRINT "Sorry, but that's all that is included"
PRINT "in this demo! I'm making more levels"
PRINT "and new features though!!"
PRINT
PRINT "Press escape to quit or press enter"
PRINT "to see the new features that are coming"
DO
i$ = INKEY$
IF i$ = CHR$(27) THEN END
IF i$ = CHR$(13) THEN GOTO newfeatures
LOOP



ambulence:
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,2,2,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,0
DATA 0,0,0,0,0,0,0,1,3,3,1,1,1,1,1,1,1,1,1,0
DATA 0,1,1,1,1,1,1,1,3,3,1,1,4,4,1,1,1,1,1,0
DATA 0,1,1,1,1,1,1,1,1,1,1,4,4,4,4,1,1,1,1,0
DATA 0,1,1,1,1,1,1,1,1,1,1,1,4,4,1,1,1,1,1,0
DATA 0,1,1,7,1,1,1,1,1,1,1,1,1,1,1,1,7,1,1,0
DATA 0,1,7,0,7,1,1,1,1,1,1,1,1,1,1,7,0,7,1,0
DATA 0,0,0,7,0,0,0,0,0,0,0,0,0,0,0,0,7,0,0,0





newfeatures:
CLS
PRINT "- Wind that pushes you while you're in the air"
PRINT "- High Scores"
PRINT "- Automatic Speed Checker"
PRINT "- Cheats and Passwords"
PRINT "- A system where you earn money and lose money"
PRINT "- Buy new and better equipment"
PRINT "- Save/Load Game (Money Version)"
PRINT "- Gravity/parachutes"
PRINT "- Better Graphics (i.e. airplane and skydiver)"
PRINT
PRINT "E-mail me for more suggestions!"
PRINT "jeremy.ruten@gmail.com"
PRINT
PRINT "Press enter"
DO
i$ = INKEY$
LOOP UNTIL i$ = CHR$(13)
GOTO menu

