CHDIR ".\samples\pete\su2"

' Interesting facts
' Programmed on windows 95 that runs at 50-60 Mhz
' Had to remake all movement just for the bullets
' listen to music while programming
' All remade in a few hours( don't know how long, just one afternoon-not that long)
' Made BY me - Nixon
' Rewrite most of it for a better editor which can load any color and any ASCII char (almost)
' Only spent a few days to finish everything
DECLARE SUB loadmap ()
DECLARE SUB instructions ()
DIM SHARED map$(100, 100), bullet(100), bx(100), by(100), bd(100)
DECLARE SUB center (text$)
DECLARE SUB border ()
ON ERROR GOTO fixfile
PRINT "calculating speed"
maximum = 1D+18
oldtime = TIMER
FOR i = 1 TO maximum
LOCATE 2, 1: PRINT TIMER
IF TIMER >= oldtime + 1 THEN speed = i: GOTO speed
NEXT
speed:

SCREEN 13
menu:
CLS
COLOR 4
PRINT " S H O O T   U P   V 2  "
PRINT "   ‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€    "
PRINT "  €€€€€€€€€€€€€€€€€›    "
PRINT " ≤≤≤≤≤‹‹ﬂ               "
PRINT "‹≤≤≤≤                 "
PRINT "≤≤≤≤               "
PRINT ""
PRINT ""
PRINT ""
COLOR 12
PRINT "1) The Game"
PRINT "2) Instructions"
PRINT "3) Exit"
DO: P$ = INKEY$: LOOP UNTIL P$ <> ""
IF P$ = "1" THEN GOTO top
IF P$ = "2" THEN CALL instructions
IF P$ = "3" THEN CLS : END
GOTO menu
top:
CLS
U$ = CHR$(0) + "H"
D$ = CHR$(0) + "P"
R$ = CHR$(0) + "M"
L$ = CHR$(0) + "K"
COLOR 15
PRINT "1)Map 1"
COLOR 7
PRINT "2)Map 2"
COLOR 8
PRINT "3)Map 3"
PRINT "4)Map 4"
COLOR 7
PRINT "5)Custom"
COLOR 15
INPUT "Choice"; pick
IF pick = 1 THEN file$ = "map"
IF pick = 2 THEN file$ = "map2"
IF pick = 3 THEN file$ = "map3"
IF pick = 4 THEN file$ = "map4"
IF pick = 5 THEN INPUT "Map to load(no extensions)"; file$
choice:
OPEN file$ + ".dat" FOR INPUT AS #1
CLS
CALL border
players = 0
FOR yy = 1 TO 12
FOR xx = 1 TO 27
INPUT #1, map$(xx, yy)
FOR i = 1 TO 5
IF MID$(map$(xx, yy), i, 1) = "-" THEN B$ = MID$(map$(xx, yy), 1, i - 1): item2 = VAL(MID$(map$(xx, yy), i + 1, 10))
NEXT
c = VAL(B$)
IF c = 0 OR item2 = 0 OR item2 = 255 OR item2 = 32 THEN map$(xx, yy) = "0-0"
COLOR c: LOCATE yy + 4, xx + 6: PRINT CHR$(item2)
'IF players = 2 AND item2 = 2 THEN map$(xx, yy) = "0-0": LOCATE yy + 4, xx + 6: PRINT " "
IF item2 = 2 THEN COLOR c: LOCATE yy + 4, xx + 6: PRINT CHR$(2): c2 = c: p2x = xx: p2y = yy: map$(xx, yy) = "0-0": players = players + 1
IF item2 = 1 THEN COLOR c: LOCATE yy + 4, xx + 6: PRINT CHR$(1): c1 = c: p1x = xx: p1y = yy: map$(xx, yy) = "0-0": players = players + 1
NEXT: NEXT
CLOSE #1

hp1 = 5
hp2 = 5
DO
P$ = INKEY$: IF P$ = CHR$(27) THEN END
  FOR find = 1 TO 20
  IF MID$(map$(p1x, p1y), find, 1) = "-" THEN legn = find
  NEXT
 IF MID$(map$(p1x, p1y), legn + 2, 4) = "178" THEN LOCATE p1y + 4, p1x + 6: COLOR VAL(MID$(map$(p1x, p1y), 1, legn)): PRINT CHR$(178)
 IF P$ <> "" AND map$(p1x, p1y) = "0-0" THEN LOCATE p1y + 4, p1x + 6: PRINT " "
IF P$ = U$ AND map$(p1x, p1y - 1) = "0-0" AND p1y <> 1 OR P$ = U$ AND MID$(map$(p1x, p1y - 1), legn + 2, 3) = "178" AND p1y <> 1 THEN COLOR 15: p1y = p1y - 1: COLOR c1: LOCATE p1y + 4, p1x + 6: PRINT CHR$(1)
IF P$ = D$ AND map$(p1x, p1y + 1) = "0-0" AND p1y <> 12 OR P$ = D$ AND MID$(map$(p1x, p1y + 1), legn + 2, 3) = "178" AND p1y <> 12 THEN COLOR 15:  p1y = p1y + 1: COLOR c1: LOCATE p1y + 4, p1x + 6: PRINT CHR$(1)
IF P$ = R$ AND map$(p1x + 1, p1y) = "0-0" AND p1x <> 27 OR P$ = R$ AND MID$(map$(p1x + 1, p1y), legn + 2, 3) = "178" AND p1x <> 27 THEN COLOR 15: p1x = p1x + 1: COLOR c1: LOCATE p1y + 4, p1x + 6: PRINT CHR$(1)
IF P$ = L$ AND map$(p1x - 1, p1y) = "0-0" AND p1x <> 1 OR P$ = L$ AND MID$(map$(p1x - 1, p1y), legn + 2, 3) = "178" AND p1x <> 1 THEN COLOR 15: p1x = p1x - 1: COLOR c1: LOCATE p1y + 4, p1x + 6: PRINT CHR$(1)
COLOR c1: LOCATE p1y + 4, p1x + 6: PRINT CHR$(1)

IF P$ = "p" AND map$(p1x, p1y - 1) = "0-0" OR P$ = "p" AND MID$(map$(p1x, p1y - 1), legn + 2, 3) = "178" THEN
 FOR i = 1 TO 100
 IF bullet(i) = 0 THEN bullet(i) = 1: bd(i) = 0: by(i) = p1y: bx(i) = p1x: GOTO continue
 NEXT
END IF

IF P$ = ";" AND map$(p1x, p1y + 1) = "0-0" OR P$ = ";" AND MID$(map$(p1x, p1y + 1), legn + 2, 3) = "178" THEN
 FOR i = 1 TO 100
 IF bullet(i) = 0 THEN bullet(i) = 1: bd(i) = 1: by(i) = p1y: bx(i) = p1x: GOTO continue
 NEXT
END IF

IF P$ = "'" AND map$(p1x + 1, p1y) = "0-0" OR P$ = "'" AND MID$(map$(p1x + 1, p1y), legn + 2, 3) = "178" THEN
 FOR i = 1 TO 100
 IF bullet(i) = 0 THEN bullet(i) = 1: bd(i) = 2: by(i) = p1y: bx(i) = p1x: GOTO continue
 NEXT
END IF

IF P$ = "l" AND map$(p1x - 1, p1y) = "0-0" OR P$ = "l" AND MID$(map$(p1x - 1, p1y), legn + 2, 3) = "178" THEN
 FOR i = 1 TO 100
 IF bullet(i) = 0 THEN bullet(i) = 1: bd(i) = 3: by(i) = p1y: bx(i) = p1x: GOTO continue
 NEXT
END IF
 
  FOR find = 1 TO 20
  IF MID$(map$(p1x, p1y), find, 1) = "-" THEN legn = find
  NEXT

 IF MID$(map$(p2x, p2y), legn + 2, 4) = "178" THEN LOCATE p2y + 4, p2x + 6: COLOR VAL(MID$(map$(p2x, p2y), 1, legn)): PRINT CHR$(178)
 IF P$ <> "" AND map$(p2x, p2y) = "0-0" THEN LOCATE p2y + 4, p2x + 6: PRINT " "
IF P$ = "t" AND map$(p2x, p2y - 1) = "0-0" AND p2y <> 1 OR P$ = "t" AND MID$(map$(p2x, p2y - 1), legn + 2, 3) = "178" AND p2y <> 1 THEN COLOR 7: p2y = p2y - 1: COLOR c2: LOCATE p2y + 4, p2x + 6: PRINT CHR$(2)
IF P$ = "g" AND map$(p2x, p2y + 1) = "0-0" AND p2y <> 12 OR P$ = "g" AND MID$(map$(p2x, p2y + 1), legn + 2, 3) = "178" AND p2y <> 12 THEN COLOR 7: p2y = p2y + 1: COLOR c2: LOCATE p2y + 4, p2x + 6: PRINT CHR$(2)
IF P$ = "h" AND map$(p2x + 1, p2y) = "0-0" AND p2x <> 27 OR P$ = "h" AND MID$(map$(p2x + 1, p2y), legn + 2, 3) = "178" AND p2x <> 27 THEN COLOR 7: : p2x = p2x + 1: COLOR c2: LOCATE p2y + 4, p2x + 6: PRINT CHR$(2)
IF P$ = "f" AND map$(p2x - 1, p2y) = "0-0" AND p2x <> 1 OR P$ = "f" AND MID$(map$(p2x - 1, p2y), legn + 2, 3) = "178" AND p2x <> 1 THEN COLOR 7: : p2x = p2x - 1: COLOR c2: LOCATE p2y + 4, p2x + 6: PRINT CHR$(2)
COLOR c2: LOCATE p2y + 4, p2x + 6: PRINT CHR$(2)

IF P$ = "w" AND map$(p2x, p2y - 1) = "0-0" OR P$ = "w" AND MID$(map$(p2x, p2y - 1), legn + 2, 3) = "178" THEN
 FOR i = 1 TO 100
 IF bullet(i) = 0 THEN bullet(i) = 1: bd(i) = 0: by(i) = p2y: bx(i) = p2x: GOTO continue
 NEXT
END IF

IF P$ = "s" AND map$(p2x, p2y + 1) = "0-0" OR P$ = "s" AND MID$(map$(p2x, p2y + 1), legn + 2, 3) = "178" THEN
 FOR i = 1 TO 100
 IF bullet(i) = 0 THEN bullet(i) = 1: bd(i) = 1: by(i) = p2y: bx(i) = p2x: GOTO continue
 NEXT
END IF

IF P$ = "d" AND map$(p2x + 1, p2y) = "0-0" OR P$ = "d" AND MID$(map$(p2x + 1, p2y), legn + 2, 3) = "178" THEN
 FOR i = 1 TO 100
 IF bullet(i) = 0 THEN bullet(i) = 1: bd(i) = 2: by(i) = p2y: bx(i) = p2x: GOTO continue
 NEXT
END IF

IF P$ = "a" AND map$(p2x - 1, p2y) = "0-0" OR P$ = "a" AND MID$(map$(p2x - 1, p2y), legn + 2, 3) = "178" THEN
 FOR i = 1 TO 100
 IF bullet(i) = 0 THEN bullet(i) = 1: bd(i) = 3: by(i) = p2y: bx(i) = p2x: GOTO continue
 NEXT
END IF

continue:
FOR i = 1 TO 100
IF bullet(i) = 1 THEN
 LOCATE by(i) + 4, bx(i) + 6: PRINT " "
  FOR find = 1 TO 20
  IF MID$(map$(bx(i), by(i)), find, 1) = "-" THEN leg = find
  NEXT
  IF MID$(map$(bx(i), by(i)), leg + 2, 4) = "178" THEN LOCATE by(i) + 4, bx(i) + 6: COLOR VAL(MID$(map$(bx(i), by(i)), 1, leg)): PRINT CHR$(178)

  IF MID$(map$(bx(i), by(i)), leg + 2, 4) = "176" THEN LOCATE by(i) + 4, bx(i) + 6: COLOR VAL(MID$(map$(bx(i), by(i)), 1, leg)): PRINT CHR$(VAL(MID$(map$(bx(i), by(i)), leg + 1, LEN(map$(bx(i), by(i))))))
 IF bd(i) = 0 THEN by(i) = by(i) - 1
 IF bd(i) = 1 THEN by(i) = by(i) + 1
 IF bd(i) = 2 THEN bx(i) = bx(i) + 1
 IF bd(i) = 3 THEN bx(i) = bx(i) - 1
 IF by(i) = 0 OR by(i) = 13 THEN bullet(i) = 0
 IF bx(i) = 0 OR bx(i) = 28 THEN bullet(i) = 0
 IF map$(bx(i), by(i)) <> "0-0" THEN
  bullet(i) = 0
  FOR find = 1 TO 20
  IF MID$(map$(bx(i), by(i)), find, 1) = "-" THEN leg = find
  NEXT
  IF MID$(map$(bx(i), by(i)), leg + 2, 4) = "177" THEN map$(bx(i), by(i)) = "0-0": LOCATE by(i) + 4, bx(i) + 6: PRINT " "
  IF MID$(map$(bx(i), by(i)), leg + 2, 4) = "176" THEN bullet(i) = 1
  IF MID$(map$(bx(i), by(i)), leg + 2, 4) = "178" THEN bullet(i) = 1

 END IF
 IF bx(i) = p1x AND by(i) = p1y THEN bullet(i) = 0: hp1 = hp1 - 1
 IF bx(i) = p2x AND by(i) = p2y THEN bullet(i) = 0: hp2 = hp2 - 1
 IF bullet(i) = 1 THEN LOCATE by(i) + 4, bx(i) + 6: COLOR 15: PRINT CHR$(248)
END IF
NEXT

COLOR c1: LOCATE p1y + 4, p1x + 6: PRINT CHR$(1): COLOR c2: LOCATE p2y + 4, p2x + 6: PRINT CHR$(2)
LOCATE 19, 6: COLOR 12: PRINT "P1 Health"
IF hp1 = 5 THEN LOCATE 20, 6: COLOR 4: PRINT "    "
IF hp1 = 4 THEN LOCATE 20, 6: COLOR 4: PRINT "    ∞"
IF hp1 = 3 THEN LOCATE 20, 6: COLOR 4: PRINT "   ∞ ∞"
IF hp1 = 2 THEN LOCATE 20, 6: COLOR 4: PRINT "  ∞ ∞ ∞"
IF hp1 = 1 THEN LOCATE 20, 6: COLOR 4: PRINT " ∞ ∞ ∞ ∞"
IF hp1 = 0 THEN LOCATE 20, 6: COLOR 4: PRINT "∞ ∞ ∞ ∞ ∞": GOTO again

LOCATE 19, 26: COLOR 12: PRINT "P2 Health"
IF hp2 = 5 THEN LOCATE 20, 26: COLOR 4: PRINT "    "
IF hp2 = 4 THEN LOCATE 20, 26: COLOR 4: PRINT "    ∞"
IF hp2 = 3 THEN LOCATE 20, 26: COLOR 4: PRINT "   ∞ ∞"
IF hp2 = 2 THEN LOCATE 20, 26: COLOR 4: PRINT "  ∞ ∞ ∞"
IF hp2 = 1 THEN LOCATE 20, 26: COLOR 4: PRINT " ∞ ∞ ∞ ∞"
IF hp2 = 0 THEN LOCATE 20, 26: COLOR 4: PRINT "∞ ∞ ∞ ∞ ∞": GOTO again

FOR i = 1 TO speed: NEXT
LOOP

again:
FOR i = 1 TO 100: bullet(i) = 0: NEXT
LOCATE 22, 15: INPUT "Again y/N"; choice$
IF choice$ = "y" THEN GOTO top
IF choice$ = "Y" THEN GOTO top
GOTO menu

fixfile:
COLOR 4
center "File does not exist"
center "Try typing 'map'"
center "Press [Enter]"
DO: P$ = INKEY$: LOOP UNTIL P$ = CHR$(13)
GOTO top

SUB border
COLOR 4
center "Shoot Up V 2"
center ""
center ""
COLOR 7
center "±±±±±±±±±±±±±±±±±±±±±±±±±±±±±"
center "±                           ±"
center "±                           ±"
center "±                           ±"
center "±                           ±"
center "±                           ±"
center "±                           ±"
center "±                           ±"
center "±                           ±"
center "±                           ±"
center "±                           ±"
center "±                           ±"
center "±                           ±"
center "±±±±±±±±±±±±±±±±±±±±±±±±±±±±±"
'LOCATE 5, 7: PRINT "#"
END SUB

SUB center (text$)
PRINT TAB(20 - (INT(LEN(text$) / 2))); text$
END SUB

SUB instructions
CLS
COLOR 4
center " I N S T R U C T I O N S "
COLOR 12
center "- - - - - - - - - - - - -"
PRINT ""
PRINT ""
COLOR 4
PRINT "CONTROLS"
COLOR 12
PRINT "Each player has 8 keys which are used. Four are used for movement and the other used for shooting. The keys are"
PRINT "       Player 1       "
PRINT "Movement      Shooting"
PRINT "                 P     "
PRINT "                         "
PRINT "              l   ' "
PRINT "                         "
PRINT "                 ;   "

PRINT "       Player 2"
PRINT "Movement      Shooting"
PRINT "   t              w   "
PRINT ""
PRINT " f   h          a   d "
PRINT ""
PRINT "   g              s "
COLOR 4
PRINT "Press [Anykey] to continue"
DO: LOOP UNTIL INKEY$ <> ""
COLOR 4
PRINT "WALLS"
COLOR 12
PRINT "These are things that can not be walked through or over. They can be anything other than a fake, breakable, water."
COLOR 8
PRINT "1,f,7,a,A,"; CHR$(4); ","; CHR$(219)
PRINT ""
COLOR 4
PRINT "Players"
COLOR 12
PRINT "They can be any color. but you can tell the difference between each."
COLOR 8
PRINT "Player 1 :"; CHR$(1)
PRINT "Player 2 :"; CHR$(2)
PRINT ""
COLOR 4
PRINT "Fakes"
COLOR 12
PRINT "These can be any color. You can walk over them and shoot over them."
COLOR 8
PRINT "A fake "; CHR$(178)
PRINT ""
COLOR 4
PRINT "Breakables"
COLOR 12
PRINT "These can be any color. You can not walk on them but can be destroyed by"
PRINT "bullets to clear a way."
COLOR 8
PRINT "A Breakable "; CHR$(177)
COLOR 4
PRINT "Press [Anykey] to continue"
DO: LOOP UNTIL INKEY$ <> ""
COLOR 4
PRINT "Water"
COLOR 12
PRINT "Water can be any color. It can not be walked on yet you can shoot a bullet over it without effect to the bullet."
COLOR 8
PRINT "A water "; CHR$(176)
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT ""
PRINT "Press [Anykey] to continue"
DO: LOOP UNTIL INKEY$ <> ""

END SUB

SUB loadmap
'INPUT "open"; file$
'OPEN file$ FOR INPUT AS #1
END SUB

