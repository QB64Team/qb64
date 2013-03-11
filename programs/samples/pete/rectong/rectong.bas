CHDIR ".\programs\samples\pete\rectong"

DECLARE SUB AdvanceRound ()
DECLARE SUB SelectRounds ()
DECLARE SUB ShowControls ()
DECLARE SUB SelectDifficulty ()
DECLARE SUB DoAI ()
DECLARE SUB Player1Miss ()
DECLARE SUB Player2Miss ()
DECLARE SUB MoveBall ()
DECLARE SUB LaunchBall ()
DECLARE SUB DispStats ()
DECLARE SUB DrawBall ()
DECLARE SUB StartGame ()
DECLARE SUB InitCoord ()
DECLARE SUB DrawP2 ()
DECLARE SUB DrawP1 ()
DECLARE SUB LoadGFX ()
DECLARE SUB WipeEffect ()
DECLARE SUB Start2P ()
DECLARE SUB Start1P ()
DECLARE SUB ExitGame ()
DECLARE SUB MeltDown ()
DECLARE SUB FadePAL255 (fadetype!)
DECLARE SUB CenterText (sline!, Text AS STRING)
DECLARE SUB LoadPAL (filename AS STRING)
DECLARE SUB LoadFullBMP (filename AS STRING)

DIM SHARED AIserve
DIM SHARED butt(4, 32, 48)
DIM SHARED ball(12, 12)
DIM SHARED buttdir(1)
DIM SHARED balldir(1)
DIM SHARED rounds, cround
DIM SHARED p1score, p2score
DIM SHARED p1(1)
DIM SHARED p2(1)
DIM SHARED ballcor(1)
DIM SHARED players
DIM SHARED hasball
DIM SHARED difflevel

CLS : SCREEN 13: PALETTE: PALETTE 255, 63 + 256 * 63 + 65536 * 63: COLOR 255

LoadGFX

DO
InitCoord
LoadPAL "gfx\title01.pal"
LoadFullBMP "gfx\title01.rec"
DO: LOOP UNTIL INKEY$ = ""
menusel = 1
DO
cround = 1
SELECT CASE menusel
CASE 1
        CenterText 2, CHR$(16) + "   1 Player  "
        CenterText 4, "    2 Player  "
        CenterText 6, "    Controls  "
        CenterText 8, "  Exit Rectong"
CASE 2
        CenterText 2, "    1 Player  "
        CenterText 4, CHR$(16) + "   2 Player  "
        CenterText 6, "    Controls  "
        CenterText 8, "  Exit Rectong"
CASE 3
        CenterText 2, "    1 Player  "
        CenterText 4, "    2 Player  "
        CenterText 6, CHR$(16) + "   Controls  "
        CenterText 8, "  Exit Rectong"
CASE 4
        CenterText 2, "    1 Player  "
        CenterText 4, "    2 Player  "
        CenterText 6, "    Controls  "
        CenterText 8, CHR$(16) + " Exit Rectong"
END SELECT

key$ = INKEY$
SELECT CASE key$
CASE CHR$(0) + CHR$(72) 'Up
        IF menusel > 1 THEN menusel = menusel - 1
CASE CHR$(0) + CHR$(80) 'Down
        IF menusel < 4 THEN menusel = menusel + 1
CASE CHR$(13) 'Enter
        SELECT CASE menusel
        CASE 1
                players = 1: difflevel = 0: SelectDifficulty: IF difflevel = 0 THEN EXIT DO
                StartGame
                EXIT DO
        CASE 2
                players = 2: StartGame: EXIT DO
        CASE 3: ShowControls: EXIT DO
        CASE 4
                ExitGame
        END SELECT
END SELECT
LOOP
LOOP

SUB AdvanceRound
cround = cround + 1
IF cround > rounds THEN
CLS
IF p1score > p2score THEN winner = 1 ELSE winner = 2
IF p1score = p2score THEN winner = -1
IF winner <> -1 THEN
        CenterText 11, "GAME OVER! Player" + STR$(winner) + " is the winner!"
ELSE
        CenterText 11, "GAME OVER! Both players tied!"
END IF
CenterText 13, "Press Enter to continue..."
DO: LOOP UNTIL INKEY$ = CHR$(13)
END IF
END SUB

SUB CenterText (sline, Text AS STRING)
LOCATE sline, 20 - (LEN(Text) / 2)
PRINT Text;
END SUB

SUB DispStats
LOCATE 25, 1: COLOR 255
PRINT " 1P:" + LEFT$(STR$(p1score) + " goals  ", 8) + SPACE$(4) + "Round:" + STR$(cround) + SPACE$(3) + " 2P:" + LEFT$(STR$(p2score) + " Goals  ", 8);
LINE (0, 190)-(320, 190), 255
END SUB

SUB DoAI
SELECT CASE hasball
CASE 2
        IF p2(1) < AIserve THEN buttdir(1) = 2
        IF p2(1) > AIserve THEN buttdir(1) = 1
        IF FIX(p2(1)) = FIX(AIserve) THEN buttdir(1) = 0
        ballcor(1) = p2(1) + 24
        ballcor(0) = 280
        EXIT SUB
CASE 1
        EXIT SUB
END SELECT

'THIS LINE DOES PERFECT AI, JUST FOR DEBUGGING:
'p2(1) = ballcor(1) - 6

factor = ABS(ballcor(1) - (p2(1) - 24))
difficulty = FIX(difflevel - (factor / 50))
IF difficulty < 0 THEN difficulty = 0

IF INT(RND * difficulty) = 0 THEN
        IF FIX(p2(1)) + 24 > ballcor(1) THEN buttdir(1) = 1
        IF FIX(p2(1)) + 24 < ballcor(1) THEN buttdir(1) = 2
        IF FIX(p2(1)) + 24 = ballcor(1) THEN buttdir(1) = 0
ELSE
        buttdir(1) = 0
END IF
END SUB

SUB DrawBall
FOR y = 1 TO 12
FOR x = 1 TO 12
        colr = ball(x, y)
        'IF colr <> 4 THEN
        PSET (ballcor(0) + x - 6, ballcor(1) + y - 6), colr
NEXT x
NEXT y
LINE (ballcor(0) - 10, ballcor(1) - 13)-(ballcor(0) - 7, ballcor(1) + 15), 0, BF
LINE (ballcor(0) + 7, ballcor(1) - 7)-(ballcor(0) + 10, ballcor(1) + 7), 0, BF
'LINE (ballcor(0) - 7, ballcor(1) - 15)-(ballcor(0) + 7, ballcor(1) - 13), 0, BF
'LINE (ballcor(0) - 7, ballcor(1) + 13)-(ballcor(0) + 7, ballcor(1) + 15), 0, BF
LINE (ballcor(0) - 10, 0)-(ballcor(0) + 10, ballcor(1) - 7), 0, BF
LINE (ballcor(0) - 10, ballcor(1) + 7)-(ballcor(0) + 10, 189), 0, BF
END SUB

SUB DrawP1
LINE (0, 0)-(32, p1(1)), 0, BF
LINE (0, p1(1) + 49)-(32, 189), 0, BF
FOR y = 1 TO 48
FOR x = 1 TO 32
        colr = butt(p1(0), x, y)
        'IF colr <> 4 THEN
        PSET (x, y + p1(1)), colr
NEXT x
NEXT y
END SUB

SUB DrawP2
LINE (288, 0)-(320, p2(1)), 0, BF
LINE (288, p2(1) + 49)-(320, 189), 0, BF
FOR y = 1 TO 48
FOR x = 1 TO 32
        PSET (320 - x, y + p2(1)), butt(p2(0), x, y)
NEXT x
NEXT y
END SUB

SUB ExitGame
SCREEN 0: WIDTH 80: COLOR 7, 0: CLS
PRINT "Rectong v1.0 (c)2005 Mike Chambers"
PRINT "E-mail: half-eaten@yahoo.com"
PRINT
PRINT "Thanks for playing!"
END
END SUB

SUB FadePAL255 (fadetype)
SELECT CASE fadetype
CASE 1
FOR fader1 = 0 TO 63
        PALETTE 255, fader1 + 256 * fader1 + 65536 * fader1
        t! = TIMER: DO: LOOP UNTIL TIMER - t! > 0
NEXT fader1
CASE 0
FOR fader1 = 63 TO 0 STEP -1
        PALETTE 255, fader1 + 256 * fader1 + 65536 * fader1
        t! = TIMER: DO: LOOP UNTIL TIMER - t! > 0
NEXT fader1
END SELECT
END SUB

SUB InitCoord
p1(0) = 1: p2(0) = 1
p1(1) = 68: p2(1) = 68
ballcor(0) = 160: ballcor(1) = 92
buttdir(0) = 0: buttdir(1) = 0
END SUB

SUB LaunchBall

END SUB

SUB LoadFullBMP (filename AS STRING)
DEF SEG = &HB800
ff = FREEFILE
OPEN filename FOR BINARY AS #ff
FOR sposy = 1 TO 200
aget$ = SPACE$(320): GET #ff, , aget$
FOR sposx = 1 TO 320
PSET (sposx, sposy), ASC(MID$(aget$, sposx, 1))
NEXT sposx
NEXT sposy
CLOSE #ff
END SUB

SUB LoadGFX
FOR loader = 1 TO 4
ff = FREEFILE
nm$ = RIGHT$("0" + MID$(STR$(loader), 2), 2)
OPEN "gfx\butt" + nm$ + ".rec" FOR BINARY AS #ff
        FOR loady = 1 TO 48
        ain$ = SPACE$(32): GET #ff, , ain$
        FOR loadx = 1 TO 32
                butt(loader, loadx, loady) = ASC(MID$(ain$, loadx, 1))
        NEXT loadx
        NEXT loady
CLOSE #ff
NEXT loader

OPEN "gfx\ball00.rec" FOR BINARY AS #ff
        FOR loady = 1 TO 12
        ain$ = SPACE$(12): GET #ff, , ain$
        FOR loadx = 1 TO 12
                ball(loadx, loady) = ASC(MID$(ain$, loadx, 1))
        NEXT loadx
        NEXT loady
CLOSE #ff

END SUB

SUB LoadPAL (filename AS STRING)
ff = FREEFILE
PALETTE 255, 63 + 256 * 63 + 65536 * 63
OPEN filename FOR BINARY AS #ff
S$ = SPACE$(28): GET #ff, , S$
FOR n = 1 TO 255
inpt$ = SPACE$(4)
a$ = SPACE$(1)
B$ = SPACE$(1)
c$ = SPACE$(1)
d$ = SPACE$(1)
GET #ff, , inpt$
a$ = LEFT$(inpt$, 1)
B$ = MID$(inpt$, 2, 1)
c$ = MID$(inpt$, 3, 1)

rat = (255 / 63)
r& = ASC(a$) / rat
g& = ASC(B$) / rat
B& = ASC(c$) / rat
PALETTE n, r& + 256 * g& + 65536 * B&
NEXT n
CLOSE #ff
END SUB

SUB MeltDown
DO
FOR psy = 1 TO 200
FOR psx = 1 TO 320
colr = POINT(psx, psy)
LINE (psx, psy + INT(RND * 3))-(psx, psy + INT(RND * 30) + 8), colr
NEXT psx
LINE (1, psy)-(320, psy), 0
t! = TIMER: DO: LOOP UNTIL TIMER - t! > 0
NEXT psy
LOOP UNTIL INKEY$ <> "" OR which = 4
END SUB

SUB MoveBall
IF hasball <> 0 THEN EXIT SUB

ballcor(0) = ballcor(0) + balldir(0)
ballcor(1) = ballcor(1) + balldir(1)

'Check ball hitting stuff
p1top = p1(1)
p1bot = p1(1) + 48
p2top = p2(1)
p2bot = p2(1) + 48

IF balldir(1) = 0 THEN fact = 1

IF ballcor(0) <= 32 THEN 'if within X range of player 1 butt
IF ballcor(1) >= p1top AND ballcor(1) <= p1bot THEN
        yfactor = ((ballcor(1) - p1top) - 24)
        IF yfactor <> 0 THEN yfactor = yfactor / 25 ELSE yfactor = 0
        IF balldir(1) = 0 THEN fact = 1

        balldir(0) = -balldir(0)
        balldir(1) = yfactor '* fact
END IF
END IF

IF ballcor(0) >= 288 THEN 'if within X range of player 1 butt
IF ballcor(1) >= p2top AND ballcor(1) <= p2bot THEN
        yfactor = ((ballcor(1) - p2top) - 24)
        IF yfactor <> 0 THEN yfactor = yfactor / 25 ELSE yfactor = 0

        balldir(0) = -balldir(0)
        balldir(1) = yfactor '* balldir(1)
END IF
END IF
'End ball checking

IF ballcor(1) <= 7 THEN ballcor(1) = 7: balldir(1) = -balldir(1)
IF ballcor(1) >= 183 THEN ballcor(1) = 183: balldir(1) = -balldir(1)

'Check for player missing ball
IF ballcor(0) < 25 THEN Player1Miss 'If player 1 misses the ball
IF ballcor(0) > 295 THEN Player2Miss 'If player 2 misses the ball
'End check
END SUB

SUB Player1Miss
AdvanceRound
IF cround > rounds THEN CLS : EXIT SUB
p2score = p2score + 1
hasball = 2: CLS
CenterText 11, "PLAYER 1 MISSED THE BALL!"
CenterText 13, "Next round: Player 2 starts."
CenterText 14, "Press ENTER when ready."
DO: LOOP UNTIL INKEY$ = CHR$(13)
InitCoord
RANDOMIZE TIMER
AIserve = INT(RND * 130) + 5
CLS
END SUB

SUB Player2Miss
AdvanceRound
IF cround > rounds THEN CLS : EXIT SUB
p1score = p1score + 1
hasball = 1: CLS
CenterText 11, "PLAYER 2 MISSED THE BALL!"
CenterText 13, "Next round: Player 1 starts."
CenterText 14, "Press ENTER when ready."
DO: LOOP UNTIL INKEY$ = CHR$(13)
InitCoord
CLS
END SUB

SUB SelectDifficulty
CLS
menusel = 4
CenterText 6, "Select difficulty"
CenterText 8, " Too simple!"
CenterText 9, "    Easy    "
CenterText 10, " Pretty easy"
CenterText 11, "   Average  "
CenterText 12, "    Hard    "
CenterText 13, "   Harder   "
CenterText 14, " Good luck!!"

DO
key$ = INKEY$
update = 0
SELECT CASE key$
CASE CHR$(0) + CHR$(72) 'Up
        IF menusel > 1 THEN menusel = menusel - 1: update = 1
CASE CHR$(0) + CHR$(80) 'Down
        IF menusel < 7 THEN menusel = menusel + 1: update = 1
CASE CHR$(13) 'Enter
        SELECT CASE menusel
        CASE 1: difflevel = 12
        CASE 2: difflevel = 11
        CASE 3: difflevel = 6
        CASE 4: difflevel = 4
        CASE 5: difflevel = 3
        CASE 6: difflevel = 2
        CASE 7: difflevel = 1
        END SELECT
        EXIT SUB
CASE CHR$(27) 'Return to main menu
        EXIT SUB
END SELECT

LOCATE 6 + menusel, 13: PRINT " ";
LOCATE 7 + menusel, 13: PRINT CHR$(16);
LOCATE 8 + menusel, 13: PRINT " ";
LOOP
END SUB

SUB SelectRounds
CLS
menusel = 1
rounds = 3
CenterText 11, " Rounds: 3"
CenterText 13, " Let's go!"
DO
key$ = INKEY$
update = 0
SELECT CASE key$
CASE CHR$(0) + CHR$(72) 'Up
        IF menusel > 1 THEN menusel = menusel - 1: update = 1
CASE CHR$(0) + CHR$(80) 'Down
        IF menusel < 2 THEN menusel = menusel + 1: update = 1
CASE CHR$(13) 'Enter
        SELECT CASE menusel
        CASE 1
                rounds = rounds + 1
                IF rounds = 10 THEN rounds = 1
                CenterText 11, " Rounds:" + STR$(rounds)
        CASE 2
                EXIT SUB
        END SELECT

CASE CHR$(27) 'Return to main menu
        EXIT SUB
END SELECT

SELECT CASE menusel
CASE 1: LOCATE 11, 14: PRINT CHR$(16); : LOCATE 13, 14: PRINT " ";
CASE 2: LOCATE 13, 14: PRINT CHR$(16); : LOCATE 11, 14: PRINT " ";
END SELECT
LOOP
END SUB

SUB ShowControls
CLS
CenterText 2, "RECTONG CONTROLS"
CenterText 6, "Player 1 controls:"
CenterText 7, "A - Move up"
CenterText 8, "Z - Move down"
CenterText 9, "X - Stop moving"
CenterText 10, "S - Serve ball"
CenterText 12, "Player 2 controls:"
CenterText 13, "Up arrow - Move up"
CenterText 14, "Down arrow - Move down"
CenterText 15, "End - Stop moving"
CenterText 16, "\ - Serve ball"
CenterText 20, "Escape exits an active game."
CenterText 24, "Press ENTER to continue..."
DO: LOOP UNTIL INKEY$ = CHR$(13)
CLS
END SUB

SUB StartGame
SelectRounds
p1score = 0
p2score = 0
cround = 0

quitgame = 0
hasball = 1 'who starts with the ball

WipeEffect
LoadPAL "gfx\palette.pal": PALETTE 4, 0: PALETTE 255, 63 + 256 * 63 + 65536 * 63
LaunchBall
DO UNTIL quitgame = 1 OR cround > rounds
SELECT CASE hasball
CASE 1
        ballcor(0) = 40
        ballcor(1) = p1(1) + 24
CASE 2
        ballcor(0) = 280
        ballcor(1) = p2(1) + 24
END SELECT

SELECT CASE hasball
CASE 1
        CenterText 2, "Player 1 has the ball!"
        CenterText 3, "Press S to serve."
        p1(0) = 4
        p2(0) = 1
CASE 2
        CenterText 2, "Player 2 has the ball!"
        IF players = 2 THEN
                CenterText 3, "Press \ to throw."
        ELSE
                CenterText 3, "Get ready, player 1!"
        END IF
        p2(0) = 4
        p1(0) = 1
CASE ELSE
        p1(0) = 1
        p2(0) = 1
END SELECT

DrawP1
DrawP2
IF hasball = 0 THEN DrawBall

DispStats

skip = skip + 1
IF skip AND 1 THEN WAIT &H3DA, 8: WAIT &H3DA, 8, 8

key$ = INKEY$
SELECT CASE key$
CASE CHR$(27) 'Escape key
CenterText 12, "Exit to main menu? (Y/N)"
DO
SELECT CASE LCASE$(INKEY$)
CASE "y"
        quitgame = 1: EXIT DO
CASE "n"
        EXIT DO
END SELECT
LOOP
CenterText 12, "                        "

CASE "a", "A" 'Up P1
IF buttdir(0) = 0 OR buttdir(0) = 2 THEN buttdir(0) = 1 ELSE buttdir(0) = 0

CASE "z", "Z" 'Down P1
IF buttdir(0) = 0 OR buttdir(0) = 1 THEN buttdir(0) = 2 ELSE buttdir(0) = 0

CASE "x", "X" 'Stops P1 movement
buttdir(0) = 0

CASE "s", "S" 'Shoot ball P1
IF hasball = 1 THEN
        CenterText 2, SPACE$(24): CenterText 3, SPACE$(24)
        hasball = 0
        balldir(0) = 1
        balldir(1) = 0
END IF

CASE CHR$(0) + CHR$(79) 'Stops P2 movement
buttdir(1) = 0

CASE "\" 'Shoot ball P2
IF hasball = 2 AND players = 2 THEN
        CenterText 2, SPACE$(24): CenterText 3, SPACE$(24)
        hasball = 0
        balldir(0) = -1
        balldir(1) = 0
END IF

CASE CHR$(0) + CHR$(72) 'Up P2
IF players = 2 THEN IF buttdir(1) = 0 OR buttdir(1) = 2 THEN buttdir(1) = 1 ELSE buttdir(1) = 0

CASE CHR$(0) + CHR$(80) 'Down P2
IF players = 2 THEN IF buttdir(1) = 0 OR buttdir(1) = 1 THEN buttdir(1) = 2 ELSE buttdir(1) = 0
END SELECT

IF players = 1 THEN DoAI
IF hasball = 2 AND players = 1 AND FIX(AIserve) = FIX(p2(1)) THEN
        CenterText 2, SPACE$(24): CenterText 3, SPACE$(24)
        hasball = 0
        balldir(0) = -1
        balldir(1) = 0
END IF

SELECT CASE buttdir(0)
CASE 1
IF p1(1) > 1 THEN p1(1) = p1(1) - 1

CASE 2
IF p1(1) < 138 THEN p1(1) = p1(1) + 1
END SELECT

SELECT CASE buttdir(1)
CASE 1
IF p2(1) > 1 THEN p2(1) = p2(1) - 1

CASE 2
IF p2(1) < 138 THEN p2(1) = p2(1) + 1
END SELECT

MoveBall
LOOP
CLS : EXIT SUB
END SUB

SUB WipeEffect
FOR xeff = 0 TO 160 STEP .01
        LINE (160 + xeff, 0)-(160 + xeff, 200), 0
        LINE (160 - xeff, 0)-(160 - xeff, 200), 0
        't! = TIMER: DO: LOOP UNTIL TIMER - t! > 0
NEXT xeff
END SUB

