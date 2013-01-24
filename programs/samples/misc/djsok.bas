CHDIR ".\samples\qb64\original"

'/=================================================================\
'  (C) David Joffe 1997                   e-mail: djoffe@icon.co.za
'  DJ Software; April '97               http://www.scorpioncity.com/
'-------------------------------------------------------------------
'  VGA Sokoban v1.0, for QBasic!
'-------------------------------------------------------------------
'  -[ The object of the game: ]----------------------------------
'  You are a Pacman derivative; you must push all the crate-type
'  blocks onto the destination-type blocks. There are 90 levels,
'  which I got from XSokoban, a sokoban for the X Window System.
'  --------------------------------------------------------------
'
'  You can do whatever you want with this program, on the single
'  preferred condition that if you create any derivative works,
'  I would like to be credited, at minimum with a link to my
'  website.
'
'  Please send me bug-reports and any other feedback; i.e. tell
'  me you like it or hate it or have no opinion about it, but just
'  tell me something!
'
'  New levels: I would love it if you create new levels (or even
'  new sprites) if you would send them to me; they will probably
'  be included in later versions, in which case you will get credit.
'
'  The savegame file format is a really tough one to crack, but
'  see if you can give it a go ;-)
'\=================================================================/

' Draw a rectangle with highlights.
DECLARE SUB DrawBox (x1%, y1%, x2%, y2%, col1%, col2%, bgfill%)

' Default data type to integer for fastest processing
DEFINT A-Z

' To hold sprites
DIM Graphics(1 TO 2000)

' The following piece of code first tries for VGA; if that fails,
' it tries EGA. If that fails, it leaves.
ON ERROR GOTO TryEGA
SCREEN 13
GOTO GraphicsSuccess

TryEGA:
ON ERROR GOTO NoGraphics
SCREEN 7
GOTO GraphicsSuccess

NoGraphics:
COLOR 15, 0: CLS
PRINT "You don't seem to have graphics capable hardware."
PRINT "There is a text version available though."
PRINT
GOTO ContactMessage

GraphicsSuccess:
ON ERROR GOTO 0

' Draw the graphics and GET it
RESTORE GraphicsData
FOR i = 0 TO 23
  FOR j = 0 TO 10
    FOR k = 0 TO 10
      READ n
      PSET (k, j), n
    NEXT k
  NEXT j
  GET (0, 0)-(10, 10), Graphics(i * 80 + 1)
NEXT i

' Constants
DIM SHARED NUMLEVELS
NUMLEVELS = 90

DIM SHARED LEVELFILENAME AS STRING
LEVELFILENAME$ = "djsok.dat"
DIM SHARED OFSX
OFSX = 6
DIM SHARED OFSY
OFSY = 6

' Dimensions of playing area
DIM SHARED MAXX
MAXX = 20
DIM SHARED MAXY
MAXY = 17
' Set this to 1 to enable cheats; then pressing "$" advances a level
DIM SHARED CHEATSENABLED
CHEATSENABLED = 0

' Search string: position of a character in string is used as the
' index for Colour array dereferencing and for how to handle that
' type of character in the game
GameData$ = "€–∆»“∫…ÃµºÕ ªπÀŒ Ë≤"

' Offsets into GameData$ of certain important character types
DIM SHARED POSCRATE
POSCRATE = 19
DIM SHARED POSSPACE
POSSPACE = 18
DIM SHARED POSCRATEATDEST
POSCRATEATDEST = 20
DIM SHARED POSDEST
POSDEST = 17
DIM SHARED POSHERO
POSHERO = 21

' Certain important character types
CharCrate$ = MID$(GameData$, POSCRATE, 1)
CharCrateAtDest$ = MID$(GameData$, POSCRATEATDEST, 1)
CharDest$ = MID$(GameData$, POSDEST, 1)

' Data structures
DIM TempMap(0 TO MAXY + 1) AS STRING * 22
DIM Map(0 TO MAXY + 1) AS STRING * 22

' Initialize screen
COLOR 15: CLS

' Level should be set to 0 here to make entry point level 1
Level = 0
Won = 1

'===========================================================[ BEGIN MAIN ]==
MainLoop:
  ' Get keypress
  a$ = INKEY$

  ' Reset level or advance level
  IF Won = 1 OR UCASE$(a$) = "R" THEN
    IF (UCASE$(a$) <> "R") AND (Level >= 1) THEN
      COLOR 15
      LOCATE 19, 2: PRINT "Press a key ...";
      WHILE INKEY$ = "": WEND
    END IF
    IF (UCASE$(a$) <> "R") THEN Level = Level + 1
    IF (Level > NUMLEVELS) THEN GOTO FinishedGame
    GOSUB LoadLevel
    GOSUB Drawlevel
    GOTO MovePlayer
  END IF
 
  ' Player pressed nothing
  IF a$ = "" THEN GOTO MainLoop

  ' Player pressed escape
  IF a$ = CHR$(27) THEN GOTO EndGame
 
  ' Save game
  IF UCASE$(a$) = "S" THEN GOSUB SaveGame

  ' Cheat to advance to next level
  IF a$ = "$" AND CHEATSENABLED = 1 THEN Won = 1: GOTO MainLoop

  ' Load game
  IF UCASE$(a$) = "L" THEN GOSUB LoadGame

  ' About
  IF UCASE$(a$) = "A" THEN GOSUB About

  ' Up, down, left and right respectively
  IF a$ = CHR$(0) + "H" THEN xd = 0: yd = -1: GOTO MovePlayer
  IF a$ = CHR$(0) + "P" THEN xd = 0: yd = 1: GOTO MovePlayer
  IF a$ = CHR$(0) + "K" THEN xd = -1: yd = 0: GOTO MovePlayer
  IF a$ = CHR$(0) + "M" THEN xd = 1: yd = 0: GOTO MovePlayer
GOTO MainLoop
'=============================================================[ END MAIN ]==

MovePlayer:
  ' read character directly in front of player
  character$ = MID$(Map$(y + yd), x + xd + 1, 1)
  n = INSTR(GameData$, character$)
 
  ' If it's a wall, then leave
  graphicsOffset = 0
  IF n <= 16 THEN graphicsOffset = -1: GOTO DrawHero

  ' If there is a crate in front of us, find the character two positions
  ' away in front of us
  IF ((character$ = CharCrate$) OR (character$ = CharCrateAtDest$)) THEN
    character2$ = MID$(Map$(y + yd + yd), x + xd + xd + 1, 1)
    n2 = INSTR(GameData$, character2$)
    ' If the character 2 away from us is a wall or a crate, leave
    IF n2 <= 16 OR character2$ = CharCrate$ OR character2$ = CharCrateAtDest$ THEN GOTO MainLoop
   
    ' Else we can move the crate in front of us
    LOCATE y + yd + yd + 1, x + xd + xd + 1
    ' If we're moving a crate onto a destination-type block
    IF (character2$ = CharDest$) THEN
      MID$(Map$(y + yd + yd), x + xd + xd + 1, 1) = CharCrateAtDest$
      PUT ((x + xd + xd - 1) * 11 + OFSX, (y + yd + yd - 1) * 11 + OFSY), Graphics((POSCRATEATDEST - 1) * 80 + 1), PSET
      NumPushes = NumPushes + 1: GOSUB ShowNumPushes
      ' If we're moving it from a destination-type block onto another dest-type
      IF character$ = CharCrateAtDest$ THEN
        MID$(Map$(y + yd), x + xd + 1, 1) = CharDest$
      ELSE ' we're moving it onto a dest-type from a space
        MID$(Map$(y + yd), x + xd + 1, 1) = " "
        NumPlaced = NumPlaced + 1
      END IF
      IF (NumPlaced = NumCrates) THEN Won = 1
    ELSE ' We're moving the crate onto a blank space
      MID$(Map$(y + yd + yd), x + xd + xd + 1, 1) = CharCrate$
      PUT ((x + xd + xd - 1) * 11 + OFSX, (y + yd + yd - 1) * 11 + OFSY), Graphics((POSCRATE - 1) * 80 + 1), PSET
      NumPushes = NumPushes + 1: GOSUB ShowNumPushes
      ' If we're moving a crate off of a destination block
      IF character$ = CharCrateAtDest$ THEN
        MID$(Map$(y + yd), x + xd + 1, 1) = CharDest$
        NumPlaced = NumPlaced - 1
      ELSE ' we're moving a crate off of a space
        MID$(Map$(y + yd), x + xd + 1, 1) = " "
      END IF
    END IF
  END IF

DrawHero:
  ' Erase our hero
  PUT ((x - 1) * 11 + OFSX, (y - 1) * 11 + OFSY), Graphics(((INSTR(GameData$, MID$(Map$(y), x + 1, 1))) - 1) * 80 + 1), PSET
  ' Update hero's location
  IF (graphicsOffset <> -1) THEN
    x = x + xd
    y = y + yd
  END IF
  ' Update NumMoves counter
  IF NOT (xd = 0 AND yd = 0) THEN NumMoves = NumMoves + 1: GOSUB ShowNumMoves
  ' Re-draw our hero
  graphicsOffset = 0
  IF (xd = 0 AND yd = 1) THEN graphicsOffset = 1
  IF (xd = -1 AND yd = 0) THEN graphicsOffset = 2
  IF (xd = 0 AND yd = -1) THEN graphicsOffset = 3
  PUT ((x - 1) * 11 + OFSX, (y - 1) * 11 + OFSY), Graphics((POSHERO + graphicsOffset - 1) * 80 + 1), PSET
GOTO MainLoop

SaveGame:
  GOSUB InputFileName
  IF filename$ <> "" THEN
    filename$ = filename$ + ".sok"
    OPEN filename$ FOR OUTPUT AS #1
    PRINT #1, Level
    CLOSE
    LOCATE 19, 1: PRINT "File "; filename$; " saved ...";
    SLEEP 1
    GOSUB Drawlevel
  END IF
  GOSUB Drawlevel
RETURN

LoadGame:
  GOSUB InputFileName
  IF filename$ <> "" THEN
    filename$ = filename$ + ".sok"
    Level = 0
    ' The following error handler is used to determine if a given file
    ' exists.
    ON ERROR GOTO NoFile
    OPEN filename$ FOR INPUT AS #1
    ' If file exists:
    IF filename$ <> "" THEN
      INPUT #1, Level
      CLOSE
      GOSUB LoadLevel
    END IF
  END IF
  ' Disable the error handler
  ON ERROR GOTO 0
  GOSUB Drawlevel
RETURN

NoFile:
  LOCATE 19, 1: PRINT "File not found! Press a key ...";
  ' Set filename$ to "" so that we know the file doesn't exist
  filename$ = ""
  ' Clear keyboard buffer and wait for keypress
  WHILE INKEY$ <> "": WEND
  WHILE INKEY$ = "": WEND
' Go back to the line after the error occured
RESUME NEXT

' Routine to allow user to enter a string of length at most 8 for
' getting filenames
InputFileName:
  COLOR 15
  xval = 17
  filename$ = ""
  LOCATE 19, 1: PRINT "Enter filename: _";
EnternameLoop:
    s$ = INKEY$
    IF s$ = "" THEN GOTO EnternameLoop
    ' Escape
    IF s$ = CHR$(27) THEN filename$ = "": GOTO sReturn
    ' Enter
    IF s$ = CHR$(13) THEN GOTO sReturn
    ' Backspace
    IF filename$ <> "" AND s$ = CHR$(8) THEN
      filename$ = LEFT$(filename$, LEN(filename$) - 1)
      LOCATE 19, xval: PRINT filename$ + "_ ";
    END IF
    IF s$ < "0" THEN GOTO EnternameLoop
    IF s$ > "9" THEN
      IF s$ < "A" THEN GOTO EnternameLoop
      IF s$ > "Z" THEN
        IF s$ < "a" OR s$ > "z" THEN GOTO EnternameLoop
      END IF
    END IF
    IF LEN(filename$) = 8 THEN GOTO EnternameLoop
    filename$ = filename$ + s$
    LOCATE 19, xval: PRINT filename$ + "_ ";
GOTO EnternameLoop
sReturn:
RETURN

' Loads levels from the file as it needs them because all the levels
' in memory at once might place a bit of strain on QBasic :-)
LoadLevel:
  x = 0
  y = 0
  xd = 0
  yd = 0
  NumCrates = 0
  NumDestinations = 0
  NumPlaced = 0
  NumMoves = 0
  NumPushes = 0
  Won = 0

  ' Blank out the strings
  FOR i = 0 TO MAXY + 1
    TempMap$(i) = STRING$(MAXX + 2, " ")
    Map$(i) = STRING$(MAXX + 2, " ")
  NEXT i

  OPEN LEVELFILENAME FOR INPUT AS #1
  LINE INPUT #1, f$
  LevelString$ = RTRIM$(LTRIM$(STR$(Level)))
  ' Read until we find the string corresponding to the current Level number
  WHILE (f$ <> LevelString$) AND NOT EOF(1)
    LINE INPUT #1, f$
  WEND
  ' If we didn't find it, something went wrong
  IF f$ <> LevelString$ THEN CLOSE : GOTO lReturn

  ' Read in the level
  LINE INPUT #1, f$
  count = 1
  WHILE f$ <> "~"
    TempMap$(count) = " " + f$
    LINE INPUT #1, f$
    count = count + 1
  WEND
  CLOSE

  ' Centre the level vertically
  ' Adding 0.5 and doing an integer divide effectively rounds upwards
  extra = ((MAXY - count) + .5) \ 2
  FOR i = count TO 1 STEP -1
    TempMap$(i + extra) = TempMap$(i)
  NEXT i
  FOR i = 1 TO extra
    TempMap$(i) = STRING$(MAXX + 2, " ")
  NEXT i
  FOR i = count + extra TO MAXY
    TempMap$(i) = STRING$(MAXX + 2, " ")
  NEXT i
 
  ' Black out the area outside of the playing arena
  FOR i = 1 TO MAXX + 2
    c = 0
    ch$ = MID$(TempMap$(c), i, 1)
    WHILE ((ch$ = " ") OR (ch$ = "%")) AND (c <= MAXY)
      MID$(TempMap$(c), i, 1) = "%"
      c = c + 1
      ch$ = MID$(TempMap$(c), i, 1)
    WEND
    c = MAXY + 1
    ch$ = MID$(TempMap$(c), i, 1)
    WHILE ((ch$ = " ") OR (ch$ = "%")) AND (c >= 1)
      MID$(TempMap$(c), i, 1) = "%"
      c = c - 1
      ch$ = MID$(TempMap$(c), i, 1)
    WEND
  NEXT i
  FOR i = 0 TO MAXY + 1
    c = 1
    ch$ = MID$(TempMap$(i), c, 1)
    WHILE ((ch$ = " ") OR (ch$ = "%")) AND (c <= MAXX + 1)
      MID$(TempMap$(i), c, 1) = "%"
      c = c + 1
      ch$ = MID$(TempMap$(i), c, 1)
    WEND
    c = MAXX + 2
    ch$ = MID$(TempMap$(i), c, 1)
    WHILE ((ch$ = " ") OR (ch$ = "%")) AND (c >= 2)
      MID$(TempMap$(i), c, 1) = "%"
      c = c - 1
      ch$ = MID$(TempMap$(i), c, 1)
    WEND
  NEXT i

  ' Interpret the raw data and convert to our own format
  FOR i = 1 TO MAXY
    Map$(i) = TempMap$(i)
    FOR j = 2 TO MAXX + 1
      IF (MID$(Map$(i), j, 1) = "@") THEN
        MID$(Map$(i), j, 1) = " "
        x = j - 1
        y = i
      END IF
      IF (MID$(Map$(i), j, 1) = "$") THEN
        MID$(Map$(i), j, 1) = CharCrate$
        NumCrates = NumCrates + 1
      END IF
      IF (MID$(Map$(i), j, 1) = "*") THEN
        MID$(Map$(i), j, 1) = CharCrateAtDest$
        NumCrates = NumCrates + 1
        NumDestinations = NumDestinations + 1
        NumPlaced = NumPlaced + 1
      END IF
      IF (MID$(Map$(i), j, 1) = ".") THEN
        MID$(Map$(i), j, 1) = CharDest$
        NumDestinations = NumDestinations + 1
      END IF
     
      ' This is used when the walls look different depending on what walls
      ' are adjacent to them, e.g. ≥,≈,ø, etc.
      ' A binary code is used XXXX where each of the four digits corresponds
      ' to above, right-of, below, and left-of. This will generate a number
      ' from 0 to 15 that is used as the offset into GameData$ to determine
      ' the character used.
      IF (MID$(Map$(i), j, 1) = "#") THEN
        code = 0
        IF (MID$(TempMap$(i - 1), j, 1) = "#") THEN code = code + 1
        IF (MID$(TempMap$(i), j + 1, 1) = "#") THEN code = code + 2
        IF (MID$(TempMap$(i + 1), j, 1) = "#") THEN code = code + 4
        IF (MID$(TempMap$(i), j - 1, 1) = "#") THEN code = code + 8
        MID$(Map$(i), j, 1) = MID$(GameData$, code + 1, 1)
      END IF
    NEXT j
  NEXT i

  ' If the level is impossible, generate an error message.
  IF NumCrates < NumDestinations THEN
    SCREEN 0: WIDTH 80, 25
    COLOR 15, 0: CLS
    PRINT "Error: Level"; Level; "impossible!"
    PRINT "Did you fiddle with the level file?"
    PRINT "Is the level file there?"
    PRINT "If this wasn't your fault please contact me."
    PRINT
    GOTO ContactMessage
  END IF
lReturn:
RETURN

Drawlevel:
  'COLOR 10, 0: CLS
  LINE (0, 0)-(319, 199), 7, BF

  DrawBox 0, 0, 319, 199, 15, 8, -1       ' Entire screen
  DrawBox 5, 5, 226, 193, 0, 15, 0        ' Game play arena
  DrawBox 232, 5, 316, 193, 15, 8, -1     ' Info area
  DrawBox 240, 13, 308, 26, 4, 12, 0      ' Title
  DrawBox 234, 35, 314, 58, 8, 15, 0      ' Level number
  DrawBox 234, 67, 314, 106, 8, 15, 0     ' Moves/pushes
  DrawBox 234, 115, 314, 188, 8, 15, 0    ' Keys
  LINE (238, 164)-(310, 164), 13
 
  COLOR 12
  LOCATE 3, 32: PRINT "Sokoban";
 
  COLOR 11
  LOCATE 6, 32: PRINT "Level:";
  COLOR 9
  LOCATE 10, 32: PRINT "Moves:";
  COLOR 10
  LOCATE 12, 32: PRINT "Pushes:";
  GOSUB ShowNumMoves
  GOSUB ShowNumPushes
  GOSUB ShowLevel

  COLOR 14
  LOCATE 16, 31: PRINT "R  :Reset";
  LOCATE 17, 31: PRINT "L  :Load";
  LOCATE 18, 31: PRINT "S  :Save";
  LOCATE 19, 31: PRINT "A  :About";
  LOCATE 20, 31: PRINT "Esc:Quit";

  LOCATE 22, 31
  COLOR 12: PRINT "D";
  COLOR 14: PRINT "J";
  LOCATE 23, 31
  COLOR 10: PRINT "S";
  COLOR 11: PRINT "o";
  COLOR 9:  PRINT "f";
  COLOR 13: PRINT "t";
  COLOR 12: PRINT "w";
  COLOR 14: PRINT "a";
  COLOR 10: PRINT "r";
  COLOR 11: PRINT "e";
  COLOR 15
 
  ' Draw the playing arena
  FOR i = 1 TO MAXY
    FOR j = 2 TO MAXX + 1
      ' Ignore "%" signs - they indicate pure black background
      IF MID$(Map$(i), j, 1) <> "%" THEN
        PUT ((j - 2) * 11 + OFSX, (i - 1) * 11 + OFSY), Graphics((INSTR(GameData$, MID$(Map$(i), j, 1)) - 1) * 80 + 1), PSET
      END IF
    NEXT j
  NEXT i
  ' Draw the hero, taking into account the direction he's facing
  graphicsOffset = 0
  IF (xd = 0 AND yd = 1) THEN graphicsOffset = 1
  IF (xd = -1 AND yd = 0) THEN graphicsOffset = 2
  IF (xd = 0 AND yd = -1) THEN graphicsOffset = 3
  PUT ((x - 1) * 11 + OFSX, (y - 1) * 11 + OFSY), Graphics((POSHERO + graphicsOffset - 1) * 80 + 1), PSET
RETURN

ShowLevel:
  COLOR 11
  LOCATE 7, 32: PRINT Level;
RETURN

ShowNumMoves:
  COLOR 9
  LOCATE 11, 32: PRINT NumMoves;
RETURN

ShowNumPushes:
  COLOR 10
  LOCATE 13, 32: PRINT NumPushes;
RETURN

About:
  COLOR 15
  LOCATE 1, 1
  LOCATE 5, 3: PRINT "€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€"
  LOCATE , 3: PRINT "›                                  ﬁ"; : COLOR 8: PRINT "€": COLOR 15
  LOCATE , 3: PRINT "›       ˛ VGA Sokoban v1.0 ˛       ﬁ"; : COLOR 8: PRINT "€": COLOR 15
  LOCATE , 3: PRINT "›                                  ﬁ"; : COLOR 8: PRINT "€": COLOR 15
  LOCATE , 3: PRINT "›         DJ Software 1997         ﬁ"; : COLOR 8: PRINT "€": COLOR 15
  LOCATE , 3: PRINT "›         (C) David Joffe          ﬁ"; : COLOR 8: PRINT "€": COLOR 15
  LOCATE , 3: PRINT "›                                  ﬁ"; : COLOR 8: PRINT "€": COLOR 15
  LOCATE , 3: PRINT "›     Whipped up in a few hours    ﬁ"; : COLOR 8: PRINT "€": COLOR 15
  LOCATE , 3: PRINT "›            for the Net           ﬁ"; : COLOR 8: PRINT "€": COLOR 15
  LOCATE , 3: PRINT "›                                  ﬁ"; : COLOR 8: PRINT "€": COLOR 15
  LOCATE , 3: PRINT "›    http://www.scorpioncity.com/  ﬁ"; : COLOR 8: PRINT "€": COLOR 15
  LOCATE , 3: PRINT "›                                  ﬁ"; : COLOR 8: PRINT "€": COLOR 15
  LOCATE , 3: PRINT "›                                  ﬁ"; : COLOR 8: PRINT "€": COLOR 15
  LOCATE , 3: PRINT "€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€"; : COLOR 8: PRINT "€": COLOR 15
  COLOR 8
  LOCATE , 4: PRINT "€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€";
  WHILE INKEY$ = "": WEND

  ' Restore the contents of the screen
  GOSUB Drawlevel
RETURN

EndGame:
  SCREEN 0: WIDTH 80, 25
  COLOR 15, 0: CLS
  PRINT "*Sniff* .. I hate goodbyes .. *sob* ..."
  PRINT
  PRINT "Feedback (and bug reports :) welcome!"
  PRINT
  GOTO ContactMessage

FinishedGame:
  WIDTH 80, 25
  COLOR 15, 0: CLS
  PRINT "You finished the game. Yay!"
  PRINT "I suppose you were expecting something more spectacular then? You must be"
  PRINT "quite disappointed! :-)"
  PRINT
  PRINT "Actually, I would love to know if anyone actually *did* get this far (with-"
  PRINT "out cheating, of course), so let me know!"
  PRINT
  GOTO ContactMessage

ContactMessage:
  PRINT "Try e-mail me (David Joffe) at "; : COLOR 14: PRINT "djoffe@icon.co.za"; : COLOR 15: PRINT "; if that's become out-"
  PRINT "dated, have a look at:"
  COLOR 14
  PRINT "http://www.scorpioncity.com/"
  COLOR 15
  PRINT
  PRINT "I have other stuff at the above URL, with source code etc, so check it out!"
  PRINT
  PRINT "Also, if you make any new levels, I'd love to see them! Maybe I'll add them"
  PRINT "to the game for for a future re-release/re-write, in which case I'll give"
  PRINT "you appropriate credit; I'll give each level a 'Creator' field."
  PRINT
  PRINT "The 90 default levels in this version I got from XSokoban, a version of"
  PRINT "Sokoban for the X Window System."
  PRINT
  PRINT "Cheers from everyone here (just me :) at ";
  COLOR 12: PRINT "-+ D";
  COLOR 14: PRINT "J";
  PRINT " ";
  COLOR 10: PRINT "S";
  COLOR 11: PRINT "o";
  COLOR 9: PRINT "f";
  COLOR 13: PRINT "t";
  COLOR 12: PRINT "w";
  COLOR 14: PRINT "a";
  COLOR 10: PRINT "r";
  COLOR 11: PRINT "e +-"
  COLOR 15

  PRINT
  PRINT " - David Joffe"
END

GraphicsData:
'0
DATA 15,15,15,15,15,15,15,15,15,15,15
DATA 15,07,07,07,07,07,07,07,07,07,00
DATA 15,07,07,07,07,07,07,07,07,07,00
DATA 15,07,07,07,07,07,07,07,07,07,00
DATA 15,07,07,07,07,07,07,07,07,07,00
DATA 15,07,07,07,07,07,07,07,07,07,00
DATA 15,07,07,07,07,07,07,07,07,07,00
DATA 15,07,07,07,07,07,07,07,07,07,00
DATA 15,07,07,07,07,07,07,07,07,07,00
DATA 15,07,07,07,07,07,07,07,07,07,00
DATA 15,00,00,00,00,00,00,00,00,00,00
'1
DATA 15,07,07,07,07,07,07,07,07,07,00
DATA 15,07,07,07,07,07,07,07,07,07,00
DATA 15,07,07,07,07,07,07,07,07,07,00
DATA 15,07,07,07,07,07,07,07,07,07,00
DATA 15,07,07,07,07,07,07,07,07,07,00
DATA 15,07,07,07,07,07,07,07,07,07,00
DATA 15,07,07,07,07,07,07,07,07,07,00
DATA 15,07,07,07,07,07,07,07,07,07,00
DATA 15,07,07,07,07,07,07,07,07,07,00
DATA 15,07,07,07,07,07,07,07,07,07,00
DATA 15,00,00,00,00,00,00,00,00,00,00
'2
DATA 15,15,15,15,15,15,15,15,15,15,15
DATA 15,07,07,07,07,07,07,07,07,07,07
DATA 15,07,07,07,07,07,07,07,07,07,07
DATA 15,07,07,07,07,07,07,07,07,07,07
DATA 15,07,07,07,07,07,07,07,07,07,07
DATA 15,07,07,07,07,07,07,07,07,07,07
DATA 15,07,07,07,07,07,07,07,07,07,07
DATA 15,07,07,07,07,07,07,07,07,07,07
DATA 15,07,07,07,07,07,07,07,07,07,07
DATA 15,07,07,07,07,07,07,07,07,07,07
DATA 15,00,00,00,00,00,00,00,00,00,00
'3
DATA 15,07,07,07,07,07,07,07,07,07,15
DATA 15,07,07,07,07,07,07,07,07,07,07
DATA 15,07,07,07,07,07,07,07,07,07,07
DATA 15,07,07,07,07,07,07,07,07,07,07
DATA 15,07,07,07,07,07,07,07,07,07,07
DATA 15,07,07,07,07,07,07,07,07,07,07
DATA 15,07,07,07,07,07,07,07,07,07,07
DATA 15,07,07,07,07,07,07,07,07,07,07
DATA 15,07,07,07,07,07,07,07,07,07,07
DATA 15,07,07,07,07,07,07,07,07,07,07
DATA 15,00,00,00,00,00,00,00,00,00,00
'4
DATA 15,15,15,15,15,15,15,15,15,15,15
DATA 15,07,07,07,07,07,07,07,07,07,00
DATA 15,07,07,07,07,07,07,07,07,07,00
DATA 15,07,07,07,07,07,07,07,07,07,00
DATA 15,07,07,07,07,07,07,07,07,07,00
DATA 15,07,07,07,07,07,07,07,07,07,00
DATA 15,07,07,07,07,07,07,07,07,07,00
DATA 15,07,07,07,07,07,07,07,07,07,00
DATA 15,07,07,07,07,07,07,07,07,07,00
DATA 15,07,07,07,07,07,07,07,07,07,00
DATA 15,07,07,07,07,07,07,07,07,07,00
'5
DATA 15,07,07,07,07,07,07,07,07,07,00
DATA 15,07,07,07,07,07,07,07,07,07,00
DATA 15,07,07,07,07,07,07,07,07,07,00
DATA 15,07,07,07,07,07,07,07,07,07,00
DATA 15,07,07,07,07,07,07,07,07,07,00
DATA 15,07,07,07,07,07,07,07,07,07,00
DATA 15,07,07,07,07,07,07,07,07,07,00
DATA 15,07,07,07,07,07,07,07,07,07,00
DATA 15,07,07,07,07,07,07,07,07,07,00
DATA 15,07,07,07,07,07,07,07,07,07,00
DATA 15,07,07,07,07,07,07,07,07,07,00
'6
DATA 15,15,15,15,15,15,15,15,15,15,15
DATA 15,07,07,07,07,07,07,07,07,07,07
DATA 15,07,07,07,07,07,07,07,07,07,07
DATA 15,07,07,07,07,07,07,07,07,07,07
DATA 15,07,07,07,07,07,07,07,07,07,07
DATA 15,07,07,07,07,07,07,07,07,07,07
DATA 15,07,07,07,07,07,07,07,07,07,07
DATA 15,07,07,07,07,07,07,07,07,07,07
DATA 15,07,07,07,07,07,07,07,07,07,07
DATA 15,07,07,07,07,07,07,07,07,07,07
DATA 15,07,07,07,07,07,07,07,07,07,00
'7
DATA 15,07,07,07,07,07,07,07,07,07,15
DATA 15,07,07,07,07,07,07,07,07,07,07
DATA 15,07,07,07,07,07,07,07,07,07,07
DATA 15,07,07,07,07,07,07,07,07,07,07
DATA 15,07,07,07,07,07,07,07,07,07,07
DATA 15,07,07,07,07,07,07,07,07,07,07
DATA 15,07,07,07,07,07,07,07,07,07,07
DATA 15,07,07,07,07,07,07,07,07,07,07
DATA 15,07,07,07,07,07,07,07,07,07,07
DATA 15,07,07,07,07,07,07,07,07,07,07
DATA 15,07,07,07,07,07,07,07,07,07,00
'8
DATA 15,15,15,15,15,15,15,15,15,15,15
DATA 07,07,07,07,07,07,07,07,07,07,00
DATA 07,07,07,07,07,07,07,07,07,07,00
DATA 07,07,07,07,07,07,07,07,07,07,00
DATA 07,07,07,07,07,07,07,07,07,07,00
DATA 07,07,07,07,07,07,07,07,07,07,00
DATA 07,07,07,07,07,07,07,07,07,07,00
DATA 07,07,07,07,07,07,07,07,07,07,00
DATA 07,07,07,07,07,07,07,07,07,07,00
DATA 07,07,07,07,07,07,07,07,07,07,00
DATA 00,00,00,00,00,00,00,00,00,00,00
'9
DATA 15,07,07,07,07,07,07,07,07,07,00
DATA 07,07,07,07,07,07,07,07,07,07,00
DATA 07,07,07,07,07,07,07,07,07,07,00
DATA 07,07,07,07,07,07,07,07,07,07,00
DATA 07,07,07,07,07,07,07,07,07,07,00
DATA 07,07,07,07,07,07,07,07,07,07,00
DATA 07,07,07,07,07,07,07,07,07,07,00
DATA 07,07,07,07,07,07,07,07,07,07,00
DATA 07,07,07,07,07,07,07,07,07,07,00
DATA 07,07,07,07,07,07,07,07,07,07,00
DATA 00,00,00,00,00,00,00,00,00,00,00
'10
DATA 15,15,15,15,15,15,15,15,15,15,15
DATA 07,07,07,07,07,07,07,07,07,07,07
DATA 07,07,07,07,07,07,07,07,07,07,07
DATA 07,07,07,07,07,07,07,07,07,07,07
DATA 07,07,07,07,07,07,07,07,07,07,07
DATA 07,07,07,07,07,07,07,07,07,07,07
DATA 07,07,07,07,07,07,07,07,07,07,07
DATA 07,07,07,07,07,07,07,07,07,07,07
DATA 07,07,07,07,07,07,07,07,07,07,07
DATA 07,07,07,07,07,07,07,07,07,07,07
DATA 00,00,00,00,00,00,00,00,00,00,00
'11
DATA 15,07,07,07,07,07,07,07,07,07,15
DATA 07,07,07,07,07,07,07,07,07,07,07
DATA 07,07,07,07,07,07,07,07,07,07,07
DATA 07,07,07,07,07,07,07,07,07,07,07
DATA 07,07,07,07,07,07,07,07,07,07,07
DATA 07,07,07,07,07,07,07,07,07,07,07
DATA 07,07,07,07,07,07,07,07,07,07,07
DATA 07,07,07,07,07,07,07,07,07,07,07
DATA 07,07,07,07,07,07,07,07,07,07,07
DATA 07,07,07,07,07,07,07,07,07,07,07
DATA 00,00,00,00,00,00,00,00,00,00,00
'12
DATA 15,15,15,15,15,15,15,15,15,15,15
DATA 07,07,07,07,07,07,07,07,07,07,00
DATA 07,07,07,07,07,07,07,07,07,07,00
DATA 07,07,07,07,07,07,07,07,07,07,00
DATA 07,07,07,07,07,07,07,07,07,07,00
DATA 07,07,07,07,07,07,07,07,07,07,00
DATA 07,07,07,07,07,07,07,07,07,07,00
DATA 07,07,07,07,07,07,07,07,07,07,00
DATA 07,07,07,07,07,07,07,07,07,07,00
DATA 07,07,07,07,07,07,07,07,07,07,00
DATA 15,07,07,07,07,07,07,07,07,07,00
'13
DATA 15,07,07,07,07,07,07,07,07,07,00
DATA 07,07,07,07,07,07,07,07,07,07,00
DATA 07,07,07,07,07,07,07,07,07,07,00
DATA 07,07,07,07,07,07,07,07,07,07,00
DATA 07,07,07,07,07,07,07,07,07,07,00
DATA 07,07,07,07,07,07,07,07,07,07,00
DATA 07,07,07,07,07,07,07,07,07,07,00
DATA 07,07,07,07,07,07,07,07,07,07,00
DATA 07,07,07,07,07,07,07,07,07,07,00
DATA 07,07,07,07,07,07,07,07,07,07,00
DATA 15,07,07,07,07,07,07,07,07,07,00
'14
DATA 15,15,15,15,15,15,15,15,15,15,15
DATA 07,07,07,07,07,07,07,07,07,07,07
DATA 07,07,07,07,07,07,07,07,07,07,07
DATA 07,07,07,07,07,07,07,07,07,07,07
DATA 07,07,07,07,07,07,07,07,07,07,07
DATA 07,07,07,07,07,07,07,07,07,07,07
DATA 07,07,07,07,07,07,07,07,07,07,07
DATA 07,07,07,07,07,07,07,07,07,07,07
DATA 07,07,07,07,07,07,07,07,07,07,07
DATA 07,07,07,07,07,07,07,07,07,07,07
DATA 15,07,07,07,07,07,07,07,07,07,00
'15
DATA 15,07,07,07,07,07,07,07,07,07,15
DATA 07,07,07,07,07,07,07,07,07,07,07
DATA 07,07,07,07,07,07,07,07,07,07,07
DATA 07,07,07,07,07,07,07,07,07,07,07
DATA 07,07,07,07,07,07,07,07,07,07,07
DATA 07,07,07,07,07,07,07,07,07,07,07
DATA 07,07,07,07,07,07,07,07,07,07,07
DATA 07,07,07,07,07,07,07,07,07,07,07
DATA 07,07,07,07,07,07,07,07,07,07,07
DATA 07,07,07,07,07,07,07,07,07,07,07
DATA 15,07,07,07,07,07,07,07,07,07,00
' Destination
DATA 00,00,00,00,00,00,00,00,00,00,08
DATA 00,08,08,08,08,08,08,08,08,08,07
DATA 00,08,08,08,08,08,08,08,08,08,07
DATA 00,08,08,00,08,08,08,00,08,08,07
DATA 00,08,08,08,00,08,00,08,08,08,07
DATA 00,08,08,08,08,00,08,08,08,08,07
DATA 00,08,08,08,00,08,00,08,08,08,07
DATA 00,08,08,00,08,08,08,00,08,08,07
DATA 00,08,08,08,08,08,08,08,08,08,07
DATA 00,08,08,08,08,08,08,08,08,08,07
DATA 08,07,07,07,07,07,07,07,07,07,07
' Blank
DATA 08,08,08,08,08,08,08,08,08,08,08
DATA 08,08,08,08,08,08,08,08,08,08,08
DATA 08,08,08,08,08,08,08,08,08,08,08
DATA 08,08,08,08,08,08,08,08,08,08,08
DATA 08,08,08,08,08,08,08,08,08,08,08
DATA 08,08,08,08,08,08,08,08,08,08,08
DATA 08,08,08,08,08,08,08,08,08,08,08
DATA 08,08,08,08,08,08,08,08,08,08,08
DATA 08,08,08,08,08,08,08,08,08,08,08
DATA 08,08,08,08,08,08,08,08,08,08,08
DATA 08,08,08,08,08,08,08,08,08,08,08
' Crate
DATA 08,08,08,08,08,08,08,08,08,08,08
DATA 08,15,15,15,15,15,15,15,15,15,08
DATA 08,15,12,12,12,12,12,12,12,04,08
DATA 08,15,12,12,12,12,12,12,12,04,08
DATA 08,15,12,12,12,12,12,12,12,04,08
DATA 08,15,12,12,12,12,12,12,12,04,08
DATA 08,15,12,12,12,12,12,12,12,04,08
DATA 08,15,12,12,12,12,12,12,12,04,08
DATA 08,15,12,12,12,12,12,12,12,04,08
DATA 08,15,04,04,04,04,04,04,04,04,08
DATA 08,08,08,08,08,08,08,08,08,08,08
'Crate at destination
DATA 0,0,0,0,0,0,0,0,0,0,0
DATA 0,12,12,12,12,12,12,12,12,12,7
DATA 0,12,4,4,4,4,4,4,4,0,7
DATA 0,12,4,4,4,4,4,4,4,0,7
DATA 0,12,4,4,4,4,4,4,4,0,7
DATA 0,12,4,4,4,4,4,4,4,0,7
DATA 0,12,4,4,4,4,4,4,4,0,7
DATA 0,12,4,4,4,4,4,4,4,0,7
DATA 0,12,4,4,4,4,4,4,4,0,7
DATA 0,12,0,0,0,0,0,0,0,0,7
DATA 7,7,7,7,7,7,7,7,7,7,7
'Hero
DATA 08,08,08,14,14,14,14,14,08,08,08
DATA 08,14,14,14,14,14,14,14,14,14,08
DATA 08,14,14,14,14,14,00,00,14,14,08
DATA 14,14,14,14,14,14,00,00,14,14,14
DATA 14,14,14,14,14,14,14,14,14,14,14
DATA 14,14,14,14,08,08,08,08,08,08,08
DATA 14,14,14,14,14,14,08,08,08,08,08
DATA 14,14,14,14,14,14,14,14,08,08,08
DATA 08,14,14,14,14,14,14,14,14,14,08
DATA 08,14,14,14,14,14,14,14,14,08,08
DATA 08,08,08,14,14,14,14,14,08,08,08

DATA 08,08,08,14,14,14,14,14,08,08,08
DATA 08,14,14,14,14,14,14,14,14,14,08
DATA 08,14,14,14,14,14,14,14,14,14,08
DATA 14,14,14,14,14,14,14,14,14,14,14
DATA 14,14,14,14,14,08,14,14,14,14,14
DATA 14,14,14,14,14,08,14,14,14,14,14
DATA 14,14,00,00,14,08,08,14,14,14,14
DATA 14,14,00,00,14,08,08,14,14,14,14
DATA 08,14,14,14,14,08,08,08,14,14,08
DATA 08,14,14,14,14,08,08,08,14,08,08
DATA 08,08,08,14,14,08,08,08,08,08,08

DATA 08,08,08,14,14,14,14,14,08,08,08
DATA 08,14,14,14,14,14,14,14,14,14,08
DATA 08,14,14,00,00,14,14,14,14,14,08
DATA 14,14,14,00,00,14,14,14,14,14,14
DATA 14,14,14,14,14,14,14,14,14,14,14
DATA 08,08,08,08,08,08,08,14,14,14,14
DATA 08,08,08,08,08,14,14,14,14,14,14
DATA 08,08,08,14,14,14,14,14,14,14,14
DATA 08,14,14,14,14,14,14,14,14,14,08
DATA 08,08,14,14,14,14,14,14,14,14,08
DATA 08,08,08,14,14,14,14,14,08,08,08

DATA 08,08,08,08,08,08,14,14,08,08,08
DATA 08,08,14,08,08,08,14,14,14,14,08
DATA 08,14,14,08,08,08,14,14,14,14,08
DATA 14,14,14,14,08,08,14,00,00,14,14
DATA 14,14,14,14,08,08,14,00,00,14,14
DATA 14,14,14,14,14,08,14,14,14,14,14
DATA 14,14,14,14,14,08,14,14,14,14,14
DATA 14,14,14,14,14,14,14,14,14,14,14
DATA 08,14,14,14,14,14,14,14,14,14,08
DATA 08,14,14,14,14,14,14,14,14,14,08
DATA 08,08,08,14,14,14,14,14,08,08,08

SUB DrawBox (x1, y1, x2, y2, col1, col2, bgfill)
  IF (bgfill <> -1) THEN
    LINE (x1, y1)-(x2, y2), bgfill, BF
  END IF
  LINE (x1, y1)-(x2, y1), col1
  LINE (x1, y1)-(x1, y2), col1
  LINE (x2, y1)-(x2, y2), col2
  LINE (x1, y2)-(x2, y2), col2
END SUB

