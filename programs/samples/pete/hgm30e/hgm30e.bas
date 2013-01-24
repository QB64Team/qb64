chdir ".\samples\pete\hgm30e"

'HEGEMONY 3.0.e
'Copyright: Akos Ivanyi (21.07.2003)


'-----=====GENERAL GAMEFLOW=====-----

'     variables:
'         |
'      opening:
'         |
'   choosecontrol:<----O
'      /      \        |
'    human:   ai:      |
'      \      /        |
'      nextturn:------>O

'      (gosubs)


'-----=====THE GAME=====-----

variables:
'------------------------------------------------
DECLARE FUNCTION fixcolor (col AS INTEGER)
DIM rca AS STRING * 1

'$DYNAMIC
DIM pic(32000) AS INTEGER
'$STATIC

DIM control$(9)
DIM c$(9)
DIM name$(9)
DIM land%(9)
DIM sea(9)
DIM navy%(9)
DIM seaarmy%(9)
DIM seamoved%(9)
DIM money&(9)
DIM population&(9)
DIM tax(9)
DIM morale(9)
DIM trust(9)
DIM science(6, 9)
DIM sciencename$(6)
DIM sciencemoney&(6)
DIM ownercolor%(9)
DIM peasant&(9)
DIM fisher&(9)
DIM worker&(9)
DIM merchant&(9)
DIM soldier&(9)
DIM unemployed&(9)
DIM fo%(9)
DIM chu%(9)
DIM uni%(9)
DIM mil%(9)
DIM allfood&(9)
DIM spy%(9)
DIM spycost%(9)
DIM landtrade(9)
DIM value(9)
DIM lostvalue(9)
DIM diplinterest(9)
DIM hate(9)
DIM fear(9)
DIM diplplan(9)
DIM property&(9)
DIM level(9)
DIM bestname$(9)
DIM bestturn(9)
DIM bestcontrol$(9)
DIM bestdate$(9)

DIM dipl%(9, 9)
DIM diplaction%(9, 9)
DIM border%(9, 9)

DIM owner%(15, 15)
DIM original%(15, 15)
DIM terrain%(15, 15)
DIM fort%(15, 15)
DIM church%(15, 15)
DIM university%(15, 15)
DIM mill%(15, 15)
DIM army%(15, 15)
DIM moved%(16, 16)
DIM localmorale(15, 15)
DIM threat(16, 16)
DIM ed%(15, 15)

DIM tername$(9)
DIM foodpot(9)
DIM prodpot(9)
DIM terdefense(9)
DIM tercolor(9)
DIM size%(7)

DIM i AS INTEGER
DIM j AS INTEGER
DIM x AS INTEGER
DIM y AS INTEGER

ownercolor%(0) = 0
ownercolor%(1) = 2
ownercolor%(2) = 4
ownercolor%(3) = 1
ownercolor%(4) = 14
ownercolor%(5) = 8
ownercolor%(6) = 15
ownercolor%(7) = 11
ownercolor%(8) = 13
ownercolor%(9) = 12

sciencename$(1) = "agriculture"
sciencename$(2) = "industry"
sciencename$(3) = "trade"
sciencename$(4) = "sailing"
sciencename$(5) = "military"
sciencename$(6) = "medicine"

size%(1) = 1
size%(2) = 2
size%(3) = 5
size%(4) = 10
size%(5) = 20
size%(6) = 50
size%(7) = 100

tername$(0) = "sea"
tercolor(0) = 1
x = 8
y = 8
BF = 700: mf = 30: sf = 70
bc = 100: mc = 3: sc = 10
bu = 500: mu = 25: su = 250
bm = 200: mm = -20: sm = 180
bn = 200: mn = 20: sn = 180
ba = 150: ma = 30: sa = 75
message$ = "Welcome, Majesty."


opening:
'------------------------------------------------
save% = 1
code% = 1
SCREEN 12
CLS

LOCATE 1, 1
OPEN "motto.txt" FOR INPUT AS #1
 WHILE NOT EOF(1)
  LINE INPUT #1, text$
  PRINT text$
 WEND
CLOSE
GOSUB press

CLS
OPEN "hgm.bmp" FOR BINARY AS #1
SEEK #1, 119
FOR i = 299 TO 0 STEP -1
 FOR j = 0 TO 399 STEP 2
  GET #1, , rca
  PSET (j + 120, i + 90), fixcolor(FIX(ASC(rca) / 16))
  PSET (j + 121, i + 90), fixcolor(ASC(rca) - FIX(ASC(rca) / 16) * 16)
 NEXT j
NEXT i
CLOSE #1
LINE (0, 0)-(639, 479), 2, B
rca = INPUT$(1)

RANDOMIZE TIMER
CLS
GOSUB title
LOCATE 7, 1: PRINT "(Press 'ENTER' for default.)"
LOCATE 6, 1
scen$ = "default.scn"
INPUT "Which scenario do you wish to play"; scen$
IF scen$ = "" THEN scen$ = "default.scn"
LOCATE 9, 1
PRINT "Opening file..."
OPEN scen$ FOR INPUT AS #1
 INPUT #1, players%
 INPUT #1, player%
 INPUT #1, turn%
 FOR i = 1 TO 6
  INPUT #1, sciencemoney&(i)
 NEXT i
 FOR i = 1 TO players%
  LINE INPUT #1, name$(i)
  INPUT #1, control$(i)
  INPUT #1, population&(i)
  INPUT #1, money&(i)
  INPUT #1, navy%(i)
  INPUT #1, seaarmy%(i)
  INPUT #1, seamoved%(i)
  INPUT #1, tax(i)
  INPUT #1, trust(i)
  FOR j = 1 TO 6
   INPUT #1, science(j, i)
  NEXT j
  FOR j = 1 TO players%
   INPUT #1, dipl%(i, j)
  NEXT j
  FOR j = 1 TO players%
   INPUT #1, diplaction%(i, j)
  NEXT j
 NEXT i
 FOR k = 1 TO 9
  FOR i = 1 TO 15
   FOR j = 1 TO 15
    SELECT CASE k
    CASE 1
     INPUT #1, owner%(i, j)
    CASE 2
     INPUT #1, original%(i, j)
    CASE 3
     INPUT #1, terrain%(i, j)
    CASE 4
     INPUT #1, fort%(i, j)
    CASE 5
     INPUT #1, church%(i, j)
    CASE 6
     INPUT #1, university%(i, j)
    CASE 7
     INPUT #1, mill%(i, j)
    CASE 8
     INPUT #1, army%(i, j)
    CASE 9
     INPUT #1, moved%(i, j)
    END SELECT
   NEXT j
  NEXT i
 NEXT k
CLOSE
OPEN "terrain.typ" FOR INPUT AS #1
 FOR i = 1 TO 9
  LINE INPUT #1, tername$(i)
  INPUT #1, foodpot(i)
  INPUT #1, prodpot(i)
  INPUT #1, terdefense(i)
  INPUT #1, tercolor(i)
 NEXT i
CLOSE
PRINT
GOSUB spy
GOSUB chooseplayer
GOSUB enemydistance


choosecontrol:
'------------------------------------------------
GOSUB countproperties:
active% = 0
human% = 0
FOR i = 1 TO players%
 IF land%(i) > 0 THEN active% = active% + 1
 IF control$(i) = "human" THEN human% = human% + 1
NEXT i
IF human% = 0 THEN GOTO aicombat
IF active% = 1 THEN GOTO victory
IF land%(player%) = 0 THEN
 WHILE land%(player%) = 0
  IF player% < players% THEN
   player% = player% + 1
  ELSE
   player% = 1
   turn% = turn% + 1
   revoltnation = INT(RND * players%) + 1
   revoltlevel = RND * RND * 10
  END IF
  FOR i = 1 TO players%
   diplaction%(player%, i) = 0
  NEXT i
 WEND
END IF
GOSUB spy
IF control$(player%) = "human" THEN
 BEEP
 IF human% > 1 THEN
  CLS
  COLOR ownercolor%(player%)
  LOCATE player% * 3, player% * 6
  PRINT name$(player%); "'s turn!"
  BEEP
  GOSUB press
  CLS
 END IF
 GOSUB countproperties
 GOTO human
ELSE
 GOTO ai
END IF


human:
'------------------------------------------------
LOCATE 1, 1
GOSUB title
GOSUB see
GOSUB morale
GOSUB drawmap
LINE (450, 100)-(640, 360), 0, BF
LINE (129 + x * 20, 79 + y * 20)-(151 + x * 20, 101 + y * 20), 0, B
RESTORE eye
FOR i = 1 TO 7
 FOR j = 1 TO 12
  READ pixel%
  IF pixel% < 16 THEN PSET (134 + x * 20 + j, 83 + y * 20 + i), pixel%
 NEXT j
NEXT i
LINE (455, 380)-(639, 404), 7, B
LOCATE 5, 29
COLOR ownercolor%(player%)
PRINT name$(player%); "'s turn:"; turn%
COLOR 7
LOCATE 5, 1
PRINT "Empires"
PRINT "-------"
PRINT "i = Information"
PRINT "t = Treasury"
PRINT "s = Science"
PRINT "d = Diplomacy"
PRINT
PRINT "Territories"
PRINT "-----------"
PRINT "Examine: numbers"
PRINT "Move army: arrows"
PRINT "Build:"
PRINT " f = Fort"
PRINT " c = Church"
PRINT " u = University"
PRINT " m = Mills, Mines"
PRINT "      Mints..."
PRINT " a = Army"
PRINT " n = Navy"
PRINT "Sell/Destroy:"
PRINT " F, C, U, M, A, N"
PRINT
PRINT "Military unit size:         + = increase,  - = decrease"
PRINT "E = End turn,   g = save Game,   h = Help,   Q = Quit";
COLOR 14
PRINT "     Gold:"; money&(player%); "  "
COLOR 7
LOCATE 5, 59
PRINT "Territory info"
LOCATE 6, 59
PRINT "--------------"
LOCATE 7, 59
PRINT "Location:"; x; y; "    "
COLOR ownercolor%(owner%(y, x))
IF terrain%(y, x) <> 0 THEN
 LOCATE 8, 59
 PRINT "Province of..."
 LOCATE 9, 61
 PRINT name$(owner%(y, x))
 LOCATE 10, 59
 COLOR ownercolor%(original%(y, x))
 PRINT "Original owner:"
 LOCATE 11, 61
 PRINT name$(original%(y, x))
END IF
LOCATE 12, 59
COLOR tercolor(terrain%(y, x))
PRINT "Terrain: "; tername$(terrain%(y, x))
IF terrain%(y, x) <> 0 THEN
 LOCATE 13, 61
 PRINT "food:"; foodpot(terrain%(y, x))
 LOCATE 14, 61
 PRINT "resources:"; prodpot(terrain%(y, x))
 LOCATE 15, 61
 PRINT "defence bonus:"; terdefense(terrain%(y, x)) * 100; "%"
 LOCATE 16, 59
 COLOR ownercolor%(owner%(y, x))
 PRINT "Forts:";
 IF see% = 1 THEN PRINT fort%(y, x)
 LOCATE 17, 59
 PRINT "Churches:";
 IF see% = 1 THEN PRINT church%(y, x)
 LOCATE 18, 59
 PRINT "Universities:";
 IF see% = 1 THEN PRINT university%(y, x)
 LOCATE 19, 59
 PRINT "Mills, etc.:";
 IF see% = 1 THEN PRINT mill%(y, x)
END IF
LOCATE 20, 59
IF owner%(y, x) <> 0 THEN
 PRINT "Army:";
 IF see% = 1 THEN PRINT army%(y, x)
ELSE
 COLOR ownercolor%(player%)
 PRINT "Army:"; seaarmy%(player%)
END IF
LOCATE 21, 59
PRINT "Morale:";
IF see% = 1 THEN PRINT INT(localmorale(y, x) * 100 + .5); "%   "
LOCATE 22, 59
COLOR ownercolor%(player%)
IF owner%(y, x) = player% THEN
 PRINT "Reinforcement:"; moved%(y, x)
ELSEIF owner%(y, x) <> 0 THEN
 PRINT "Attackers:"; moved%(y, x)
ELSE
 PRINT "Just embarked:"; seamoved%(player%)
END IF
LOCATE 23, 59
IF terrain%(y, x) = 0 THEN
 PRINT "Navy:"; navy%(player%); "   "
ELSE
 PRINT "                   "
END IF
COLOR 7
LOCATE 25, 59
PRINT message$
LOCATE 27, 20
IF code% > 1 THEN COLOR ownercolor%(player%)
PRINT size%(code%); " "
COLOR 7

k$ = ""
WHILE k$ = ""
 k$ = INKEY$
WEND
message$ = "                    "
SELECT CASE k$
 CASE "q"
  message$ = "'Q' instead of 'q'. "
 CASE "Q"
  GOTO bye
 CASE "1" TO "9"
  IF VAL(k$) < 4 THEN
   IF y < 15 THEN y = y + 1
  END IF
  IF k$ = "1" OR k$ = "4" OR k$ = "7" THEN
   IF x > 1 THEN x = x - 1
  END IF
  IF k$ = "3" OR k$ = "6" OR k$ = "9" THEN
   IF x < 15 THEN x = x + 1
  END IF
  IF VAL(k$) > 6 THEN
   IF y > 1 THEN y = y - 1
  END IF
 CASE CHR$(0) + "H"
  IF y > 1 THEN
   IF owner%(y, x) = player% AND army%(y, x) >= size%(code%) THEN
    IF terrain%(y - 1, x) <> 0 THEN
     moved%(y - 1, x) = moved%(y - 1, x) + size%(code%)
     army%(y, x) = army%(y, x) - size%(code%)
    ELSE
     IF seamoved%(player%) + seaarmy%(player%) + size%(code%) <= navy%(player%) THEN
      seamoved%(player%) = seamoved%(player%) + size%(code%)
      army%(y, x) = army%(y, x) - size%(code%)
     ELSE
      message$ = "Not enough ships.   "
     END IF
    END IF
   ELSEIF terrain%(y, x) = 0 AND terrain%(y - 1, x) <> 0 AND seaarmy%(player%) >= size%(code%) THEN
    seaarmy%(player%) = seaarmy%(player%) - size%(code%)
    moved%(y - 1, x) = moved%(y - 1, x) + size%(code%)
   END IF
  END IF
 CASE CHR$(0) + "P"
  IF y < 15 THEN
   IF owner%(y, x) = player% AND army%(y, x) >= size%(code%) THEN
    IF terrain%(y + 1, x) <> 0 THEN
     moved%(y + 1, x) = moved%(y + 1, x) + size%(code%)
     army%(y, x) = army%(y, x) - size%(code%)
    ELSE
     IF seamoved%(player%) + seaarmy%(player%) + size%(code%) <= navy%(player%) THEN
      seamoved%(player%) = seamoved%(player%) + size%(code%)
      army%(y, x) = army%(y, x) - size%(code%)
     ELSE
      message$ = "Not enough ships.   "
     END IF
    END IF
   ELSEIF terrain%(y, x) = 0 AND terrain%(y + 1, x) <> 0 AND seaarmy%(player%) >= size%(code%) THEN
    seaarmy%(player%) = seaarmy%(player%) - size%(code%)
    moved%(y + 1, x) = moved%(y + 1, x) + size%(code%)
   END IF
  END IF
 CASE CHR$(0) + "K"
  IF x > 1 THEN
   IF owner%(y, x) = player% AND army%(y, x) >= size%(code%) THEN
    IF terrain%(y, x - 1) <> 0 THEN
     moved%(y, x - 1) = moved%(y, x - 1) + size%(code%)
     army%(y, x) = army%(y, x) - size%(code%)
    ELSE
     IF seamoved%(player%) + seaarmy%(player%) + size%(code%) <= navy%(player%) THEN
      seamoved%(player%) = seamoved%(player%) + size%(code%)
      army%(y, x) = army%(y, x) - size%(code%)
     ELSE
      message$ = "Not enough ships.   "
     END IF
    END IF
   ELSEIF terrain%(y, x) = 0 AND terrain%(y, x - 1) <> 0 AND seaarmy%(player%) >= size%(code%) THEN
    seaarmy%(player%) = seaarmy%(player%) - size%(code%)
    moved%(y, x - 1) = moved%(y, x - 1) + size%(code%)
   END IF
  END IF
 CASE CHR$(0) + "M"
  IF x < 15 THEN
   IF owner%(y, x) = player% AND army%(y, x) >= size%(code%) THEN
    IF terrain%(y, x + 1) <> 0 THEN
     moved%(y, x + 1) = moved%(y, x + 1) + size%(code%)
     army%(y, x) = army%(y, x) - size%(code%)
    ELSE
     IF seamoved%(player%) + seaarmy%(player%) + size%(code%) <= navy%(player%) THEN
      seamoved%(player%) = seamoved%(player%) + size%(code%)
      army%(y, x) = army%(y, x) - size%(code%)
     ELSE
      message$ = "Not enough ships.   "
     END IF
    END IF
   ELSEIF terrain%(y, x) = 0 AND terrain%(y, x + 1) <> 0 AND seaarmy%(player%) >= size%(code%) THEN
    seaarmy%(player%) = seaarmy%(player%) - size%(code%)
    moved%(y, x + 1) = moved%(y, x + 1) + size%(code%)
   END IF
  END IF
 CASE "f"
  IF owner%(y, x) = player% THEN
   fort%(y, x) = fort%(y, x) + 1
   money&(player%) = money&(player%) - BF
   message$ = "Cost:" + STR$(BF) + "            "
  END IF
 CASE "c"
  IF owner%(y, x) = player% THEN
   church%(y, x) = church%(y, x) + 1
   money&(player%) = money&(player%) - bc
   message$ = "Cost:" + STR$(bc) + "            "
  END IF
 CASE "u"
  IF owner%(y, x) = player% THEN
   university%(y, x) = university%(y, x) + 1
   money&(player%) = money&(player%) - bu
   message$ = "Cost:" + STR$(bu) + "            "
  END IF
 CASE "m"
  IF owner%(y, x) = player% AND prodpot(terrain%(y, x)) > mill%(y, x) THEN
   mill%(y, x) = mill%(y, x) + 1
   money&(player%) = money&(player%) - bm
   message$ = "Cost:" + STR$(bm) + "            "
  ELSEIF owner%(y, x) = player% THEN
   message$ = "No more resources.  "
  END IF
 CASE "n"
  IF owner%(y, x) = 0 THEN
   navy%(player%) = navy%(player%) + size%(code%)
   money&(player%) = money&(player%) - bn * size%(code%)
   message$ = "Cost:" + STR$(bn * size%(code%)) + "     "
  END IF
 CASE "a"
  IF owner%(y, x) = player% THEN
   GOSUB countproperties
   IF soldier&(player%) >= population&(player%) THEN
    message$ = "No more people!     "
   ELSE
    moved%(y, x) = moved%(y, x) + size%(code%)
    money&(player%) = money&(player%) - ba * size%(code%)
   message$ = "Cost:" + STR$(ba * size%(code%)) + "     "
   END IF
  END IF
 CASE "F"
  IF owner%(y, x) = player% AND fort%(y, x) > 0 THEN
   fort%(y, x) = fort%(y, x) - 1
   money&(player%) = money&(player%) + sf
   message$ = "Income:" + STR$(sf) + "          "
  END IF
 CASE "C"
  IF owner%(y, x) = player% AND church%(y, x) > 0 THEN
   church%(y, x) = church%(y, x) - 1
   money&(player%) = money&(player%) + sc
   message$ = "Income:" + STR$(sc) + "          "
  END IF
 CASE "U"
  IF owner%(y, x) = player% AND university%(y, x) > 0 THEN
   university%(y, x) = university%(y, x) - 1
   money&(player%) = money&(player%) + su
   message$ = "Income:" + STR$(su) + "          "
  END IF
 CASE "M"
  IF owner%(y, x) = player% AND mill%(y, x) > 0 THEN
   mill%(y, x) = mill%(y, x) - 1
   money&(player%) = money&(player%) + sm
   message$ = "Income:" + STR$(sm) + "          "
  END IF
 CASE "N"
  IF owner%(y, x) = 0 AND navy%(player%) > 0 THEN
   IF seamoved%(player%) + seaarmy%(player%) < navy%(player%) THEN
    navy%(player%) = navy%(player%) - 1
    money&(player%) = money&(player%) + sn
    message$ = "Income:" + STR$(sn) + "          "
   ELSE
    message$ = "Disembark first.    "
   END IF
  END IF
 CASE "A"
  IF owner%(y, x) = player% AND army%(y, x) > 0 THEN
   army%(y, x) = army%(y, x) - 1
   money&(player%) = money&(player%) + sa
   message$ = "Income:" + STR$(sa) + "          "
  END IF
 CASE "i"
  GOSUB info
 CASE "s"
  GOSUB science
 CASE "t"
  GOSUB treasury
 CASE "d"
  GOSUB diplomacy
 CASE "E"
  GOTO nextturn
 CASE "e"
  message$ = "'E' instead of 'e'. "
 CASE "g"
  GOSUB savegame
 CASE "h"
  GOSUB help
 CASE "+"
  IF code% < 7 THEN code% = code% + 1
 CASE "-"
  IF code% > 1 THEN code% = code% - 1
END SELECT
GOTO human


ai:
'------------------------------------------------
IF human% > 0 THEN PRINT name$(player%); "'s turn..."
'-- ai load variables --
OPEN control$(player%) FOR INPUT AS #1
 INPUT #1, foodweight
 INPUT #1, prodweight
 INPUT #1, hateweight
 INPUT #1, diplweight
 INPUT #1, friendliness
 INPUT #1, chance
 INPUT #1, trustweight
 INPUT #1, remoteweight
 INPUT #1, mintrust
 INPUT #1, aitrade
 INPUT #1, aifriend
 INPUT #1, aially
 INPUT #1, minmorale
 INPUT #1, mintax
 FOR i = 1 TO 5
  INPUT #1, feardipl(i)
 NEXT i
 INPUT #1, warmilitary
 INPUT #1, peacemilitary
 INPUT #1, aibuilding
 INPUT #1, aichurch
 INPUT #1, aimill
 INPUT #1, ainavy
 INPUT #1, aiuni
 FOR i = 1 TO 6
  INPUT #1, aiscience(i)
 NEXT i
 INPUT #1, landorsea
 INPUT #1, planning
 INPUT #1, myfactor
 INPUT #1, avgfactor
CLOSE

'-- ai tax --
GOSUB countproperties
GOSUB professions
limit = minmorale * (1 - unemployed&(player%) / (population&(player%) + .001))
besttax = 0
FOR try = 1 TO 25
 tax(player%) = try / 100
 GOSUB morale
 IF morale(player%) > limit THEN besttax = try / 100
NEXT try
IF besttax < mintax THEN besttax = mintax
tax(player%) = besttax
GOSUB morale

'-- ai diplomacy --
FOR i = 1 TO players%
 value(i) = 0
 lostvalue(i) = 0
 diplaction%(player%, i) = 0
NEXT i
origvalue = 0
FOR i = 1 TO 15
 FOR j = 1 TO 15
  value(owner%(i, j)) = value(owner%(i, j)) + foodpot(terrain%(i, j)) * foodweight + prodpot(terrain%(i, j)) * prodweight
  IF original%(i, j) = player% THEN
   origvalue = origvalue + foodpot(terrain%(i, j)) * foodweight + prodpot(terrain%(i, j)) * prodweight
   IF owner%(i, j) <> player% THEN lostvalue(owner%(i, j)) = lostvalue(owner%(i, j)) + foodpot(terrain%(i, j)) * foodweight + prodpot(terrain%(i, j)) * prodweight
  END IF
 NEXT j
NEXT i

maxvalue = 0
maxcountry = 0
FOR i = 1 TO players%
 IF value(i) > maxvalue THEN
  maxvalue = value(i)
  maxcountry = i
 END IF
 diplinterest(i) = 0
 hate(i) = 0
 modifyme = 0
 modifytarget = 0
 allvalue = 0
 enemyvalue = 0
 tradevalue = value(player%)
 friendvalue = value(player%)
 allyvalue = 0
 FOR j = 1 TO players%
  IF j <> player% AND j <> i THEN diplinterest(i) = diplinterest(i) + (dipl%(player%, j) - 3) * (dipl%(j, i) - 3) / 2 + 3
  IF dipl%(player%, j) = 5 THEN modifyme = modifyme + value(j)
  IF dipl%(player%, j) = 1 THEN modifyme = modifyme - value(j)
  IF dipl%(i, j) = 5 THEN modifytarget = modifytarget + value(j)
  IF dipl%(i, j) = 1 THEN modifytarget = modifytarget - value(j)
  allvalue = allvalue + value(j)
  IF dipl%(player%, j) = 1 THEN enemyvalue = enemyvalue + value(j)
  IF dipl%(player%, j) = 3 THEN tradevalue = tradevalue + value(j)
  IF dipl%(player%, j) = 4 THEN friendvalue = friendvalue + value(j)
  IF dipl%(player%, j) = 5 THEN allyvalue = allyvalue + value(j)
 NEXT j
 diplinterest(i) = diplinterest(i) / (players% - 2)
 IF active% < 3 THEN diplinterest(i) = 2
 hate(i) = lostvalue(i) / origvalue
 IF dipl%(player%, i) = 4 THEN hate(i) = -lostvalue(i) / origvalue
 fear(i) = (value(i) + modifytarget) / (value(player%) + modifyme)
NEXT i
avgvalue = allvalue / players%
target% = 0
min = 999
FOR i = 1 TO players%
 diplplan(i) = fear(i) * (1 - hate(i) * hateweight) * (1 + (diplinterest(i) - dipl%(player%, i)) / 10 * diplweight) * (1 - (1 - trust(i)) * trustweight)
 IF diplplan(i) < 0 THEN diplplan(i) = 0
 IF border%(player%, i) = 0 AND navy%(player%) < soldier&(player%) THEN diplplan(i) = diplplan(i) * soldier&(player%) / (navy%(player%) + .001)
 IF border%(player%, i) = 0 THEN diplplan(i) = diplplan(i) * (1 + remoteweight)
 diplplan(i) = diplplan(i) * (1 + friendliness) * (1 - chance + RND * 2 * chance) - 1
 IF diplplan(i) < min AND i <> player% AND land%(i) > 0 THEN
  min = diplplan(i)
  target% = i
 END IF
NEXT i

overlimit = 0
IF maxvalue > value(player%) * myfactor AND maxvalue > avgvalue * avgfactor THEN
 overlimit = 1
 IF dipl%(player%, maxcountry) > 2 OR allyvalue > maxvalue / 2 THEN target% = maxcountry
END IF

IF trust(player%) > mintrust THEN diplaction%(player%, target%) = -1

FOR i = 1 TO players%
 IF (min > 0 OR money&(player%) < 0 OR enemyvalue > allyvalue) AND (overlimit = 0 OR target% <> i) THEN diplaction%(player%, i) = 1
 IF overlimit = 1 AND i <> maxcountry THEN diplaction%(player%, i) = 1
 IF dipl%(player%, i) = 2 AND diplaction%(player%, i) > -1 AND diplplan(i) > 0 AND aitrade * (1 - (1 - trust(i)) * trustweight) / (value(player%) / avgvalue) / (tradevalue / avgvalue) * (1 + friendliness) > RND THEN diplaction%(player%, i) = 1
 IF dipl%(player%, i) = 3 AND diplaction%(player%, i) > -1 AND diplplan(i) > 0 AND aifriend * (1 - (1 - trust(i)) * trustweight) / (value(player%) / avgvalue) / (friendvalue / avgvalue) * (1 + friendliness) > RND THEN diplaction%(player%, i) = 1
 IF dipl%(player%, i) = 4 AND diplaction%(player%, i) > -1 AND diplplan(i) > 0 AND aially * (1 - (1 - trust(i)) * trustweight) / (value(player%) / avgvalue) / (allyvalue / avgvalue) * (1 + friendliness) > RND THEN diplaction%(player%, i) = 1
 IF overlimit = 1 AND i = maxcountry AND diplaction%(player%, i) > -1 THEN diplaction%(player%, i) = 0
NEXT i

'-- ai movements --
'- analysing -
seafear = 0
FOR i = 1 TO players%
 a = soldier&(player%) / land%(player%) ^ 2 * land%(i) * feardipl(dipl%(player%, i)) * (1 - sea(player%))
 IF a > seafear THEN seafear = a
NEXT i
ownmill% = 1
maxrnd = 0
unii = 0
unij = 0
max2rnd = 0
disi = 0
disj = 0
FOR i = 1 TO 15
 FOR j = 1 TO 15
  IF owner%(i, j) = player% AND original%(i, j) = player% AND prodpot(terrain%(i, j)) > mill%(i, j) THEN ownmill% = 0
  threat(i, j) = 0
  coast = 0
  a = 1
  IF owner%(i, j) = player% THEN
   IF i > 1 AND i < 15 AND j > 1 AND j < 15 THEN a = (dipl%(player%, owner%(i - 1, j)) - 1) * (dipl%(player%, owner%(i + 1, j)) - 1) * (dipl%(player%, owner%(i, j - 1)) - 1) * (dipl%(player%, owner%(i, j + 1)) - 1)
   IF original%(i, j) <> player% THEN
    threat(i, j) = (population&(player%) / (allfood&(player%) + .001) * foodpot(terrain%(i, j)) / 40) * (1 - morale(player%) ^ 2)
    IF threat(i, j) < foodpot(terrain%(i, j)) THEN threat(i, j) = foodpot(terrain%(i, j))
    IF threat(i, j) < 1 THEN threat(i, j) = 1
   END IF
   threat(i, j) = threat(i, j) - army%(i, j) * (1 + terdefense(terrain%(i, j)) + fort%(i, j) * .3)
   currentrnd = RND
   IF original%(i, j) = player% AND currentrnd > maxrnd THEN
    maxrnd = currentrnd
    unii = i
    unij = j
   END IF
   IF i > 1 THEN
    IF owner%(i - 1, j) = 0 THEN
     coast = 1
    ELSEIF owner%(i - 1, j) <> player% THEN
     threat(i, j) = threat(i, j) + army%(i - 1, j) * feardipl(dipl%(player%, owner%(i - 1, j)))
    END IF
   END IF
   IF i < 15 THEN
    IF owner%(i + 1, j) = 0 THEN
     coast = 1
    ELSEIF owner%(i + 1, j) <> player% THEN
     threat(i, j) = threat(i, j) + army%(i + 1, j) * feardipl(dipl%(player%, owner%(i + 1, j)))
    END IF
   END IF
   IF j > 1 THEN
    IF owner%(i, j - 1) = 0 THEN
     coast = 1
     ELSEIF owner%(i, j - 1) <> player% THEN
     threat(i, j) = threat(i, j) + army%(i, j - 1) * feardipl(dipl%(player%, owner%(i, j - 1)))
    END IF
   END IF
   IF j < 15 THEN
    IF owner%(i, j + 1) = 0 THEN
     coast = 1
    ELSEIF owner%(i, j + 1) <> player% THEN
     threat(i, j) = threat(i, j) + army%(i, j + 1) * feardipl(dipl%(player%, owner%(i, j + 1)))
    END IF
   END IF
   IF coast = 1 THEN threat(i, j) = threat(i, j) + seafear
  ELSEIF dipl%(owner%(i, j), player%) = 1 THEN
   IF i > 1 THEN
    current2rnd = RND
    IF owner%(i - 1, j) = 0 AND current2rnd > max2rnd THEN
     max2rnd = current2rnd
     disi = i
     disj = j
    END IF
   END IF
   IF i < 15 THEN
    current2rnd = RND
    IF owner%(i + 1, j) = 0 AND current2rnd > max2rnd THEN
     max2rnd = current2rnd
     disi = i
     disj = j
    END IF
   END IF
   IF j > 1 THEN
    current2rnd = RND
    IF owner%(i, j - 1) = 0 AND current2rnd > max2rnd THEN
     maxrnd = current2rnd
     disi = i
     disj = j
    END IF
   END IF
   IF j < 15 THEN
    current2rnd = RND
    IF owner%(i, j + 1) = 0 AND current2rnd > maxrnd THEN
     max2rnd = current2rnd
     disi = i
     disj = j
    END IF
   END IF
  END IF
 NEXT j
NEXT i
'- reinforcing and attacking -
maxthreat = 0
threati = 0
threatj = 0
FOR i = 1 TO 15
 FOR j = 1 TO 15
  IF owner%(i, j) = player% THEN
   IF threat(i, j) > maxthreat THEN
    maxthreat = threat(i, j)
    threati = i
    threatj = j
   END IF
  END IF
  max = 1
  coast = 0
  a = 0: ' help neighbouring zone
  minforce = 9999
  minarmy = 9999
  B = 0: ' attack enemy
  c = 0: ' concentrate forces next to enemy
  excess = INT(-threat(i, j) / (1 + terdefense(terrain%(i, j)) + fort%(i, j) * .3)) - 1
  IF excess > army%(i, j) THEN excess = army%(i, j)
  IF excess >= 1 THEN
   IF i > 1 THEN
    IF threat(i - 1, j) > max THEN
     max = threat(i - 1, j)
     a = 1
    END IF
    force = army%(i - 1, j) * (1 + terdefense(terrain%(i - 1, j)) + fort%(i - 1, j) * .3)
    IF dipl%(player%, owner%(i - 1, j)) = 1 AND force < minforce THEN
     minforce = force
     minarmy = army%(i - 1, j)
     B = 1
    END IF
    IF ed%(i - 1, j) < ed%(i, j) AND owner%(i - 1, j) = player% THEN c = 1
    IF owner%(i - 1, j) = 0 THEN coast = 1
   END IF
   IF i < 15 THEN
    IF threat(i + 1, j) > max THEN
     max = threat(i + 1, j)
     a = 2
    END IF
    force = army%(i + 1, j) * (1 + terdefense(terrain%(i + 1, j)) + fort%(i + 1, j) * .3)
    IF dipl%(player%, owner%(i + 1, j)) = 1 AND force < minforce THEN
     minforce = force
     minarmy = army%(i + 1, j)
     B = 2
    END IF
    IF ed%(i + 1, j) < ed%(i, j) AND owner%(i + 1, j) = player% THEN c = 2
    IF owner%(i + 1, j) = 0 THEN coast = 1
   END IF
   IF j > 1 THEN
    IF threat(i, j - 1) > max THEN
     max = threat(i, j - 1)
     a = 3
    END IF
    force = army%(i, j - 1) * (1 + terdefense(terrain%(i, j - 1)) + fort%(i, j - 1) * .3)
    IF dipl%(player%, owner%(i, j - 1)) = 1 AND force < minforce THEN
     minforce = force
     minarmy = army%(i, j - 1)
     B = 3
    END IF
    IF ed%(i, j - 1) < ed%(i, j) AND owner%(i, j - 1) = player% THEN c = 3
    IF owner%(i, j - 1) = 0 THEN coast = 1
   END IF
   IF j < 15 THEN
    IF threat(i, j + 1) > max THEN
     max = threat(i, j + 1)
     a = 4
    END IF
    force = army%(i, j + 1) * (1 + terdefense(terrain%(i, j + 1)) + fort%(i, j + 1) * .3)
    IF dipl%(player%, owner%(i, j + 1)) = 1 AND force < minforce THEN
     minforce = force
     minarmy = army%(i, j + 1)
     B = 4
    END IF
    IF ed%(i, j + 1) < ed%(i, j) AND owner%(i, j + 1) = player% THEN c = 4
    IF owner%(i, j + 1) = 0 THEN coast = 1
   END IF
  END IF
  'first round to help neighbours
  d = a
  IF max > excess THEN send = excess ELSE send = INT(max)
  excess = excess - send
  round = 1
movements:
  IF send < 1 THEN d = 0
  SELECT CASE d
   CASE 0
    'embark if you don't know where to go
    IF round = 2 AND send > 0 AND coast = 1 THEN
     emb = navy%(player%) - seaarmy%(player%) - seamoved%(player%)
     IF emb > send THEN emb = send
     army%(i, j) = army%(i, j) - emb
     seamoved%(player%) = seamoved%(player%) + emb
    END IF
   CASE 1
    moved%(i - 1, j) = moved%(i - 1, j) + send
    army%(i, j) = army%(i, j) - send
   CASE 2
    moved%(i + 1, j) = moved%(i + 1, j) + send
    army%(i, j) = army%(i, j) - send
   CASE 3
    moved%(i, j - 1) = moved%(i, j - 1) + send
    army%(i, j) = army%(i, j) - send
   CASE 4
    moved%(i, j + 1) = moved%(i, j + 1) + send
    army%(i, j) = army%(i, j) - send
  END SELECT
  'second round to attack enemy or concentrate forces
  round = round + 1
  send = excess
  d = 0
  IF c > 0 THEN d = c
  IF B > 0 AND minforce < excess THEN
   d = B
   send = send + INT(minarmy / (1 + terdefense(terrain%(i, j)) + fort%(i, j) * .3))
  END IF
  IF send >= 1 AND round = 2 THEN GOTO movements
 NEXT j
NEXT i
'- embarking -
landenemy% = 0
seaenemy% = 0
enemyvalue = 0
FOR i = 1 TO players%
 IF dipl%(player%, i) = 1 THEN
  IF border%(player%, i) > 0 THEN landenemy% = landenemy% + 1
  IF border%(i, 0) > 0 AND border%(player%, 0) > 0 THEN seaenemy% = seaenemy% + 1
  enemyvalue = enemyvalue + value(i)
 END IF
NEXT i
IF allyvalue / (enemyvalue + .01) > RND AND landenemy% = 0 AND seaenemy% > 0 AND sea(player%) * active% > RND THEN
 FOR i = 1 TO 15
  FOR j = 1 TO 15
   emb = 0
   IF i > 1 THEN
    IF owner%(i - 1, j) = 0 THEN emb = 1
   END IF
   IF i < 15 THEN
    IF owner%(i + 1, j) = 0 THEN emb = 1
   END IF
   IF j > 1 THEN
    IF owner%(i, j - 1) = 0 THEN emb = 1
   END IF
   IF j < 15 THEN
    IF owner%(i, j + 1) = 0 THEN emb = 1
   END IF
   IF owner%(i, j) = player% AND emb = 1 THEN
    emb = navy%(player%) - seaarmy%(player%) - seamoved%(player%)
   ELSE
    emb = 0
   END IF
   IF army%(i, j) - 5 < emb THEN emb = army%(i, j) - 5
   IF emb > 0 THEN
    army%(i, j) = army%(i, j) - emb
    seamoved%(player%) = seamoved%(player%) + emb
   END IF
  NEXT j
 NEXT i
END IF
'- disembarking -
IF disi > 0 AND disj > 0 AND seaarmy%(player%) > 5 AND seaarmy%(player%) > soldier&(player%) / land%(player%) * 2 THEN
 moved%(disi, disj) = seaarmy%(player%)
 seaarmy%(player%) = 0
 IF human% > 0 THEN
  COLOR ownercolor%(player%)
  PRINT name$(player%);
  COLOR 7
  PRINT " disembarks on"; disj; disi
  GOSUB press
 END IF
END IF

'-- ai money spending --
IF money&(player%) < -population&(player%) / 3 THEN GOSUB debt
IF money&(player%) > 0 THEN
 IF enemyvalue > 0 THEN
  spend& = INT(money&(player%) * warmilitary)
 ELSE
  spend& = INT(money&(player%) * peacemilitary)
 END IF
 GOSUB military
END IF
IF money&(player%) > 0 THEN
 IF aibuilding > RND OR morale(player%) < RND THEN
  GOSUB building
 ELSE
  GOSUB developscience
 END IF
END IF


nextturn:
'------------------------------------------------
GOSUB countproperties
GOSUB morale
IF human% > 0 THEN CLS

'-- science --
FOR i = 1 TO 6
 aa& = INT(science(i, player%) ^ 3 * 1000)
 IF sciencemoney&(i) > aa& THEN sciencemoney&(i) = aa&
 IF uni%(player%) / 100 > RND AND population&(player%) > 0 THEN sciencemoney&(i) = sciencemoney&(i) + RND * 1000 * (1 + (uni%(player%) / population&(player%) * 50))
 IF population&(player%) < 100 THEN
  plus = 0
 ELSE
  plus = sciencemoney&(i) / 10000 / science(i, player%) ^ 3 * (1 + uni%(player%) / population&(player%) * 50)
 END IF
 IF plus > .3 THEN plus = .3
 science(i, player%) = science(i, player%) + plus
 IF control$(player%) = "human" AND plus > 0 THEN
  PRINT "Your level of "; sciencename$(i); " has increased by:";
  PRINT USING "##.###"; plus
  GOSUB press
 END IF
NEXT i

'-- war --
FOR i = 1 TO 15
 FOR j = 1 TO 15
  IF owner%(i, j) <> 0 THEN
   attack = 0
   defend = 0
   IF owner%(i, j) = player% THEN
    army%(i, j) = army%(i, j) + moved%(i, j)
    moved%(i, j) = 0
   END IF
   rebels% = INT(population&(owner%(i, j)) / (allfood&(owner%(i, j)) + .001) * foodpot(terrain%(i, j)) / 20 * RND * morale(original%(i, j)) ^ 2)
   IF owner%(i, j) <> player% AND moved%(i, j) > 0 THEN
    attack = attack + moved%(i, j) * science(5, player%) * (.9 + RND / 5)
    IF human% > 0 THEN
     PRINT
     PRINT "Location:"; j; i
     COLOR ownercolor%(player%)
     PRINT name$(player%);
     COLOR 7
     PRINT " starts an attack against ";
     COLOR ownercolor%(owner%(i, j))
     PRINT name$(owner%(i, j));
     COLOR 7
     PRINT " with"; moved%(i, j); "soldiers."
    END IF
    IF dipl%(player%, owner%(i, j)) > 1 THEN
     IF diplaction%(player%, owner%(i, j)) = -1 AND dipl%(player%, owner%(i, j)) = 2 THEN
      IF human% > 0 THEN PRINT "...shortly after a declaration of war."
     ELSE
      IF human% > 0 THEN PRINT "...WITHOUT A DECLARATION OF WAR!    (Diplomatic trust: ";
      penalty = -2 * ((dipl%(player%, owner%(i, j)) - 1) ^ 2) - 5
      trust(player%) = trust(player%) + penalty / 100 + .05
      diplaction%(player%, owner%(i, j)) = -1
      dipl%(player%, owner%(i, j)) = 2
      dipl%(owner%(i, j), player%) = 2
      IF human% > 0 THEN PRINT INT(penalty + .5); "%)"
     END IF
    END IF
    IF human% > 0 THEN
     PRINT name$(owner%(i, j)); " defends the territory with"; army%(i, j); "soldiers."
     PRINT "Defence bonuses:"; INT(terdefense(terrain%(i, j)) * 100 + .5); "% for terrain,"; fort%(i, j) * 30; "% for forts."
    END IF
   END IF
   GOSUB revolt
   IF owner%(i, j) <> original%(i, j) AND RND < (revoltbonus / 5 / players%) AND INT(rebels% * (1 - morale(owner%(i, j)) ^ 2)) > 0 AND attack = 0 THEN
    attack = rebels% * science(5, original%(i, j)) * revoltbonus * (1 - morale(owner%(i, j)) ^ 2) * (.9 + RND / 5)
    IF human% > 0 THEN
     PRINT
     PRINT "Location:"; j; i; "  ";
     COLOR ownercolor%(owner%(i, j))
     PRINT name$(owner%(i, j));
     COLOR 7
     PRINT "  (Original owner: ";
     COLOR ownercolor%(original%(i, j))
     PRINT name$(original%(i, j));
     COLOR 7
     PRINT ")"
     PRINT "A rebellion breakes out in the occupied territory:"; INT(attack + .5); "rebels!"
     PRINT name$(owner%(i, j)); " defends with"; army%(i, j); "soldiers."
     PRINT "Defence bonuses:"; INT(terdefense(terrain%(i, j)) * 100 + .5); "% for terrain,"; fort%(i, j) * 30; "% for forts."
    END IF
   END IF
   IF attack > 0 THEN
    defend = army%(i, j) * science(5, owner%(i, j)) * (1 + terdefense(terrain%(i, j)) + fort%(i, j) * .3) * (.9 + RND / 5) + .001
    IF owner%(i, j) = original%(i, j) THEN
     defend = defend + rebels%
     army%(i, j) = army%(i, j) + rebels%
     IF human% > 0 AND rebels% > 0 THEN PRINT "The defender army is reinforced by"; rebels%; "volunteers."
    END IF
    IF attack > defend THEN
     IF moved%(i, j) = 0 THEN
      IF allfood&(player%) < 1 THEN allfood&(player%) = foodpot(terrain%(i, j)) * 2
      pop% = INT(population&(player%) * foodpot(terrain%(i, j)) / (allfood&(player%) + .001))
      IF human% > 0 THEN
       PRINT name$(owner%(i, j)); " loses the fight against the rebels.";
       COLOR ownercolor%(original%(i, j))
       PRINT " The territory is liberated."
       COLOR 7
       PRINT "Lost population:"; pop%
       GOSUB press
      END IF
      owner%(i, j) = original%(i, j)
      population&(player%) = population&(player%) - pop%
      population&(owner%(i, j)) = population&(owner%(i, j)) + pop%
      army%(i, j) = INT(attack - defend)
     ELSE
      IF allfood&(owner%(i, j)) < 1 THEN allfood&(owner%(i, j)) = foodpot(terrain%(i, j)) * 2
      pop% = INT(population&(owner%(i, j)) * foodpot(terrain%(i, j)) / (allfood&(owner%(i, j)) + .001))
      IF human% > 0 THEN
       COLOR ownercolor%(player%)
       PRINT name$(player%);
       COLOR 7
       PRINT " wins the battle, and conqueres the territory."
       PRINT "Gained population:"; pop%
       GOSUB press
      END IF
      population&(owner%(i, j)) = population&(owner%(i, j)) - pop%
      population&(player%) = population&(player%) + pop%
      army%(i, j) = INT(moved%(i, j) * (1 - defend / attack))
      moved%(i, j) = 0
      owner%(i, j) = player%
     END IF
    ELSE
     IF moved%(i, j) = 0 THEN
      IF human% > 0 THEN
       PRINT "The guarding forces manage to supress the rebellion."
       GOSUB press
      END IF
      army%(i, j) = INT(army%(i, j) * (1 - attack / defend))
     ELSE
      IF human% > 0 THEN
       PRINT "The attacking forces lose the battle."
       GOSUB press
      END IF
      army%(i, j) = INT(army%(i, j) * (1 - attack / defend))
      moved%(i, j) = 0
     END IF
    END IF
    IF defend > 1 AND attack > defend / 4 THEN
     a = INT(fort%(i, j) / 2 * RND + .5)
     fort%(i, j) = fort%(i, j) - a
     IF human% > 0 AND a > 0 THEN
      PRINT a; "forts are destroyed in the battle."
      GOSUB press
     END IF
    END IF
   END IF
  END IF
 NEXT j
NEXT i
' sea battles
FOR i = 1 TO players%
 IF RND > .9 AND dipl%(player%, i) = 1 AND navy%(i) > 0 AND navy%(player%) > 0 THEN
  attack = navy%(player%) * science(5, player%) * science(4, player%) * (.9 + RND / 5)
  defend = navy%(i) * science(5, i) * science(4, i) * (.9 + RND / 5)
  IF attack > defend THEN
   navy%(player%) = INT(navy%(player%) * (1 - (defend / attack) ^ 2 / 3))
   navy%(i) = INT(navy%(i) * (1 - 1 / 3))
   IF human% > 0 THEN
    COLOR ownercolor%(player%)
    PRINT
    PRINT name$(player%);
    COLOR 7
    PRINT " wins a naval battle against "; name$(i); "."
    IF control$(player%) = "human" THEN PRINT "Losses:"; INT(100 * (defend / attack) ^ 2 / 3); "%"
    GOSUB press
   END IF
  ELSE
   navy%(i) = INT(navy%(i) * (1 - (attack / defend) ^ 2 / 3))
   navy%(player%) = INT(navy%(player%) * (1 - 1 / 3))
   IF human% > 0 THEN
    PRINT
    PRINT name$(player%); " loses a third of her fleet in a naval battle against ";
    COLOR ownercolor%(i)
    PRINT name$(i); "."
    COLOR 7
    GOSUB press
   END IF
  END IF
  IF seamoved%(player%) + seaarmy%(player%) > navy%(player%) THEN
   seamoved%(player%) = 0
   seaarmy%(player%) = navy%(player%)
  END IF
  IF seamoved%(i) + seaarmy%(i) > navy%(i) THEN
   seamoved%(i) = 0
   seaarmy%(i) = navy%(i)
  END IF
 END IF
 seaarmy%(i) = seaarmy%(i) + seamoved%(i)
 seamoved%(i) = 0
 IF seaarmy%(i) > navy%(i) THEN seaarmy%(i) = navy%(i)
NEXT i

'-- diplomacy --
FOR i = 1 TO players%
 dipl%(i, i) = 5
 IF land%(i) = 0 THEN
  FOR j = 1 TO players%
   dipl%(i, j) = 2
   dipl%(j, i) = 2
   dipl%(i, i) = 5
  NEXT j
 END IF
 IF diplaction%(player%, i) = -1 AND dipl%(player%, i) > 1 AND i <> player% THEN
  dipl%(player%, i) = dipl%(player%, i) - 1
  dipl%(i, player%) = dipl%(player%, i)
  diplaction%(player%, i) = 0
  diplaction%(i, player%) = 0
  trust(player%) = trust(player%) - .05
  IF human% > 0 THEN
   PRINT
   PRINT name$(player%); " spoils her relationship with "; name$(i); " to: ";
   SELECT CASE dipl%(player%, i)
    CASE 1
     PRINT "war!"
    CASE 2
     PRINT "neutrality."
    CASE 3
     PRINT "trade."
    CASE 4
     PRINT "friendship."
   END SELECT
   GOSUB press
  END IF
  IF trust(player%) < 0 THEN trust(player%) = 0
  IF dipl%(player%, i) = 1 THEN
   FOR j = 1 TO players%
    IF dipl%(i, j) = 5 AND j <> i AND dipl%(player%, j) > 1 THEN
     IF human% > 0 THEN
      PRINT name$(j); ", as an ally of "; name$(i); ", declares war to "; name$(player%); "."
      GOSUB press
     END IF
     dipl%(player%, j) = 1
     dipl%(j, player%) = 1
    END IF
    IF dipl%(player%, j) = 5 AND j <> player% AND dipl%(i, j) > 1 THEN
     IF human% > 0 THEN
      PRINT name$(j); ", as an ally of "; name$(player%); ", declares war to "; name$(i); "."
      GOSUB press
     END IF
     dipl%(i, j) = 1
     dipl%(j, i) = 1
    END IF
   NEXT j
  END IF
 END IF
 prevent = 0
 FOR j = 1 TO players%
  IF dipl%(player%, j) = 1 AND dipl%(i, j) = 5 THEN prevent = 1
  IF dipl%(player%, j) = 5 AND dipl%(i, j) = 1 THEN prevent = 1
 NEXT j
 IF diplaction%(player%, i) = 1 AND diplaction%(i, player%) = 1 AND prevent = 0 AND dipl%(player%, i) < 5 THEN
  dipl%(player%, i) = dipl%(player%, i) + 1
  dipl%(i, player%) = dipl%(player%, i)
  diplaction%(player%, i) = 0
  diplaction%(i, player%) = 0
  IF human% > 0 THEN
   PRINT
   PRINT name$(player%); " and "; name$(i); " improve their relationship to: ";
   SELECT CASE dipl%(player%, i)
    CASE 2
     PRINT "neutrality."
    CASE 3
     PRINT "trade."
    CASE 4
     PRINT "friendship."
    CASE 5
     PRINT "alliance!"
   END SELECT
   GOSUB press
  END IF
  IF dipl%(player%, i) = 5 THEN
   FOR j = 1 TO players%
    IF dipl%(i, j) = 1 AND player% <> i AND dipl%(player%, j) > 1 THEN
     IF human% > 0 THEN
      PRINT name$(player%); ", as an ally of "; name$(i); ", declares war to "; name$(j); "."
      GOSUB press
     END IF
     dipl%(player%, j) = 1
     dipl%(j, player%) = 1
    END IF
    IF dipl%(player%, j) = 1 AND i <> player% AND dipl%(i, j) > 1 THEN
     IF human% > 0 THEN
      PRINT name$(i); ", as an ally of "; name$(player%); ", declares war to "; name$(j); "."
      GOSUB press
     END IF
     dipl%(i, j) = 1
     dipl%(j, i) = 1
    END IF
   NEXT j
  END IF
 END IF
 IF dipl%(player%, i) = 1 THEN
  FOR j = 1 TO players%
   IF dipl%(player%, j) = 5 AND dipl%(i, j) > 1 AND j <> player% THEN
    IF human% > 0 THEN
     PRINT
     PRINT name$(j); ", as an ally of "; name$(player%); ", declares war to "; name$(i); "."
     GOSUB press
    END IF
    dipl%(i, j) = 1
    dipl%(j, i) = 1
   END IF
   IF dipl%(i, j) = 5 AND dipl%(player%, j) > 1 AND j <> i THEN
    IF human% > 0 THEN
     PRINT
     PRINT name$(j); ", as an ally of "; name$(i); ", declares war to "; name$(player%); "."
     GOSUB press
    END IF
    dipl%(player%, j) = 1
    dipl%(j, player%) = 1
   END IF
  NEXT j
 END IF
NEXT i

FOR i = 1 TO 15
 FOR j = 1 TO 15
  IF dipl%(owner%(i, j), original%(i, j)) = 5 AND owner%(i, j) <> original%(i, j) THEN
   IF allfood&(owner%(i, j)) < 1 THEN allfood&(owner%(i, j)) = foodpot(terrain%(i, j)) * 2
   pop% = INT(population&(owner%(i, j)) * foodpot(terrain%(i, j)) / allfood&(owner%(i, j)))
   population&(owner%(i, j)) = population&(owner%(i, j)) - pop%
   population&(original%(i, j)) = population&(original%(i, j)) + pop%
   popmoney% = INT(pop% * RND * 3)
   money&(owner%(i, j)) = money&(owner%(i, j)) + popmoney%
   IF human% > 0 THEN
    PRINT
    PRINT "Location:"; j; i
    PRINT name$(owner%(i, j)); " liberates a territory of her ally, ";
    COLOR ownercolor%(original%(i, j))
    PRINT name$(original%(i, j)); "!"
    COLOR 7
    PRINT "The grateful population sends "; popmoney%; "golds to "; name$(owner%(i, j)); "."
    GOSUB press
   END IF
   owner%(i, j) = original%(i, j)
  END IF
 NEXT j
NEXT i


'-- other variables --
IF trust(player%) <= .99 THEN trust(player%) = trust(player%) + .01
GOSUB countproperties
IF control$(player%) = "human" AND landtrade(player%) > land%(player%) THEN
 PRINT
 PRINT "Thanks to your diplomatic relations with other empires, you can trade on"
 PRINT INT(landtrade(player%) / land%(player%) * 100); "% of the area of your own country."
 GOSUB press
END IF
FOR i = 1 TO players%
 IF dipl%(player%, i) > 2 AND player% <> i THEN
  FOR j = 1 TO 6
   IF (RND < ((dipl%(player%, i) - 2) ^ 2) * science(3, player%) / 100) AND science(j, player%) < science(j, i) THEN
    a = (science(j, i) - science(j, player%)) / 10
    science(j, player%) = science(j, player%) + a
    IF control$(player%) = "human" THEN
     PRINT
     PRINT "By copying an invention from "; name$(i); " your "; sciencename$(j); " develops by:";
     PRINT USING "##.###"; a
     GOSUB press
    END IF
   END IF
  NEXT j
 END IF
NEXT i
GOSUB morale
GOSUB professions
i = player%
GOSUB finances
money&(player%) = money&(player%) + total&
IF control$(player%) = "human" AND human% > 0 THEN
 PRINT
 PRINT "Change in your treasury:"; total&; "gold"
 PRINT
 GOSUB press
END IF

'-- reproduction --
allfood&(player%) = INT(allfood&(player%) * science(1, player%) + border%(player%, 0) * (1 + sea(player%)) * science(4, player%))
a = allfood&(player%) * 50 / (population&(player%) + .001)
IF a > 2 THEN a = 2
population&(player%) = INT(population&(player%) * (.9 + (a / 10)))
IF control$(player%) = "human" THEN
 IF a > 1 THEN
  PRINT "Your empire produced enough food for the population to grow by"; INT((a - 1) * 10); "%."
 ELSE
  PRINT "There is not enough food in your empire."; INT((1 - a) * 10); "% fell victim of starvation!"
 END IF
END IF
IF morale(player%) < 1 THEN
 population&(player%) = INT(population&(player%) * (1 - (1 - morale(player%)) ^ 2))
 IF control$(player%) = "human" THEN
  PRINT INT(((1 - morale(player%)) ^ 2) * 100); "% of the population leaves your land because of discontent."
 END IF
END IF
epidemic = 0
IF land%(player%) > 0 THEN epidemic = (RND / 10) * (population&(player%) / 250 / land%(player%)) / science(6, player%)
population&(player%) = INT(population&(player%) * (1 - epidemic))
IF control$(player%) = "human" THEN
 PRINT "Epidemics have"; INT(epidemic * 100); "% death toll in the country."
 GOSUB press
END IF
IF population&(player%) < 0 THEN population&(player%) = 0
IF population&(player%) = 0 THEN
 peasant&(player%) = 0
 fisher&(player%) = 0
 worker&(player%) = 0
 merchant&(player%) = 0
 soldier&(player%) = 0
 unemployed&(player%) = 0
 money&(player%) = 0
END IF

'-- human player eliminated --
IF control$(player%) = "human" THEN
 IF land%(player%) = 0 THEN
  CLS
  PRINT "The last remains of your empire are conquered by the enemy,"
  PRINT "so the struggle for hegemony continues without you."
  control$(player%) = "default.ai"
  GOSUB death
  GOSUB press
 ELSEIF population&(player%) <= 0 THEN
  CLS
  PRINT "You have run out of population."
  PRINT "Hmmm, a rather funny way of political suicide..."
  control$(player%) = "default.ai"
  population&(player%) = 0
  GOSUB death
  GOSUB press
 ELSEIF morale(player%) < .33 THEN
  CLS
  PRINT "The discontent masses don't endure your tyranny any more."
  PRINT "A great revolution breaks out and sweeps your evil regime away."
  PRINT "The new leader begins with a neutral relationship to all empires."
  control$(player%) = "default.ai"
  GOSUB neutral
  GOSUB death
  GOSUB press
 END IF
ELSE
 IF morale(player%) < .33 THEN
  COLOR ownercolor%(player%)
  IF human% > 0 THEN
   PRINT
   PRINT "There is a revolution in "; name$(player%); "!"
   COLOR 7
   PRINT "The new leader begins with a neutral relationship to all empires."
   GOSUB beethoven
   GOSUB press
  END IF
  GOSUB neutral
 END IF
END IF
human% = 0
FOR i = 1 TO players%
 IF control$(i) = "human" THEN human% = human% + 1
NEXT i

FOR i = 1 TO players%
 IF land%(i) = 0 THEN
  navy%(i) = 0
  money&(i) = 0
  population&(i) = 0
  peasant&(i) = 0
  fisher&(i) = 0
  worker&(i) = 0
  merchant&(i) = 0
  soldier&(i) = 0
  seaarmy%(i) = 0
  unemployed&(i) = 0
 ELSE
  IF population&(i) <= 0 THEN population&(i) = allfood&(i) * 50
  IF population&(i) <= 0 THEN population&(i) = 1
  IF soldier&(i) > population&(i) THEN soldier&(i) = population&(i)
 END IF
NEXT i

FOR i = 1 TO 6
 sciencemoney&(i) = 0
NEXT i
message$ = "Welcome, Majesty."
IF player% < players% THEN
 player% = player% + 1
ELSE
 player% = 1
 turn% = turn% + 1
 revoltnation = INT(RND * players%) + 1
 revoltlevel = RND * RND * 10
END IF
FOR i = 1 TO players%
 diplaction%(player%, i) = 0
NEXT i
GOSUB spy
IF human% > 0 THEN CLS
GOSUB enemydistance
GOTO choosecontrol


'-----=====GOSUBS=====-----


chooseplayer:
FOR i = 1 TO players%
 c$(i) = control$(i)
NEXT i
cprefresh:
LOCATE 12, 1
PRINT "Choose control for the empires."
PRINT : PRINT "     Empire   / Control             Best results      Turns          Date"
LINE (0, 222)-(640, 222), 7
OPEN "bestturn.txt" FOR INPUT AS #1
FOR i = 1 TO players%
 PRINT i; "- "; name$(i); SPC(8 - LEN(name$(i)));
 IF c$(i) = "human" THEN COLOR 15
 PRINT " / "; c$(i); "          "
 COLOR 7
 INPUT #1, bestname$(i)
 INPUT #1, bestturn(i)
 INPUT #1, bestcontrol$(i)
 INPUT #1, bestdate$(i)
 LOCATE (14 + i), 37
 PRINT bestcontrol$(i)
 LOCATE (14 + i), 55
 PRINT bestturn(i)
 LOCATE (14 + i), 67
 PRINT bestdate$(i)
NEXT i
CLOSE
PRINT : PRINT " 0 - Let the game begin!"
PRINT : PRINT "Press a number."
k$ = ""
WHILE k$ = ""
 k$ = INKEY$
WEND
k = VAL(k$)
IF k <= players% THEN
 IF c$(k) = "human" THEN
  c$(k) = control$(k)
  IF c$(k) = "human" THEN c$(k) = "default.ai"
 ELSE
  c$(k) = "human"
 END IF
END IF
IF k$ <> "0" THEN GOTO cprefresh
human% = 0
FOR i = 1 TO players%
 IF c$(i) = "human" THEN human% = human% + 1
 control$(i) = c$(i)
NEXT i
CLS
RETURN


title:
COLOR 4
PRINT "HEGEMONY 3.0.e                             Copyright: Akos Ivanyi (21.07.2003)"
COLOR 15
PRINT "==============                                        ivanyiakos@hotmail.com"
COLOR 2
PRINT "The Game of the Middle Ages                           www.angelfire.com/ego/akos"
COLOR 7
LINE (0, 50)-(640, 50), 7
FOR i = 1 TO 15
 FOR j = 1 TO 15
  LINE (280 + j * 3, i * 3)-(281 + j * 3, 1 + i * 3), ownercolor%(owner%(i, j)), BF
 NEXT j
NEXT i
RETURN


countproperties:
allsea% = 0
allship% = 0
FOR i = 0 TO players%
 land%(i) = 0
 fo%(i) = 0
 chu%(i) = 0
 uni%(i) = 0
 mil%(i) = 0
 allfood&(i) = 0
 soldier&(i) = 0
 sea(i) = 0
 FOR j = 0 TO players%
  border%(i, j) = 0
 NEXT j
 allship% = allship% + navy%(i)
NEXT i

FOR i = 1 TO 15
 FOR j = 1 TO 15
  IF owner%(i, j) = 0 THEN allsea% = allsea% + 1
  land%(owner%(i, j)) = land%(owner%(i, j)) + 1
  fo%(owner%(i, j)) = fo%(owner%(i, j)) + fort%(i, j)
  chu%(owner%(i, j)) = chu%(owner%(i, j)) + church%(i, j)
  uni%(owner%(i, j)) = uni%(owner%(i, j)) + university%(i, j)
  mil%(owner%(i, j)) = mil%(owner%(i, j)) + mill%(i, j)
  allfood&(owner%(i, j)) = allfood&(owner%(i, j)) + foodpot(terrain%(i, j))
  soldier&(owner%(i, j)) = soldier&(owner%(i, j)) + army%(i, j)
  soldier&(player%) = soldier&(player%) + moved%(i, j)
  FOR k = 0 TO players%
   a = 0
   IF i > 1 THEN
    IF owner%(i - 1, j) = k THEN a = a + 1
   END IF
   IF i < 15 THEN
    IF owner%(i + 1, j) = k THEN a = a + 1
   END IF
   IF j > 1 THEN
    IF owner%(i, j - 1) = k THEN a = a + 1
   END IF
   IF j < 15 THEN
    IF owner%(i, j + 1) = k THEN a = a + 1
   END IF
   border%(owner%(i, j), k) = border%(owner%(i, j), k) + a
  NEXT k
 NEXT j
NEXT i
FOR i = 1 TO players%
 IF allsea% = 0 OR allship% = 0 THEN
  sea(i) = 0
 ELSE
  sea(i) = navy%(i) / allship%
 END IF
 soldier&(i) = soldier&(i) + seaarmy%(i) + seamoved%(i)
 IF land%(i) = 0 THEN navy%(i) = 0
NEXT i

FOR i = 1 TO players%
 landtrade(i) = 0
 FOR j = 1 TO players%
  IF dipl%(i, j) > 2 THEN
   IF border%(i, j) > 0 THEN
    landtrade(i) = landtrade(i) + land%(j)
   ELSE
    landtrade(i) = landtrade(i) + land%(j) * sea(i)
   END IF
  END IF
 NEXT j
NEXT i
RETURN


professions:
FOR i = 1 TO players%
 IF land%(i) > 0 THEN
  merchant&(i) = INT(population&(i) / 50 * science(3, i) * landtrade(i) / land%(i))
  IF merchant&(i) > population&(i) / 5 THEN merchant&(i) = INT(population&(i) / 5)
  worker&(i) = INT(population&(i) / 10 * science(2, i))
  IF worker&(i) > population&(i) * .5 THEN worker&(i) = INT(population&(i) * .5)
  peasant&(i) = INT((population&(i) - soldier&(i) - merchant&(i) - worker&(i)) / (allfood&(i) * science(1, i) + border%(i, 0) * (1 + sea(i)) * science(4, i) + .0001) * allfood&(i) * science(1, i))
  IF peasant&(i) > allfood&(i) * science(1, i) * 80 THEN peasant&(i) = INT(allfood&(i) * science(1, i) * 80)
  fisher&(i) = INT(population&(i) - soldier&(i) - merchant&(i) - worker&(i) - peasant&(i))
  IF fisher&(i) > border%(i, 0) * (1 + sea(i)) * science(4, i) * 25 THEN fisher&(i) = INT(border%(i, 0) * (1 + sea(i)) * science(4, i) * 25)
  unemployed&(i) = population&(i) - soldier&(i) - merchant&(i) - worker&(i) - peasant&(i) - fisher&(i)
  IF unemployed&(i) < 0 THEN unemployed&(i) = 0
 END IF
NEXT i
RETURN


morale:
FOR i = 1 TO players%
 morale(i) = 0
NEXT i
FOR i = 1 TO 15
 FOR j = 1 TO 15
  IF owner%(i, j) <> 0 THEN
   pop% = INT(population&(owner%(i, j)) * foodpot(terrain%(i, j)) / (allfood&(owner%(i, j)) + .001))
   bonus = church%(i, j) * 20 / (pop% + .001)
   IF bonus > 1 THEN bonus = 1
   localmorale(i, j) = (1 - tax(owner%(i, j)) * 2) * (1 - unemployed&(owner%(i, j)) / (population&(owner%(i, j)) + .001)) * (1 + bonus) * (.5 + trust(owner%(i, j)) / 2)
   IF money&(owner%(i, j)) < 0 THEN localmorale(i, j) = localmorale(i, j) + money&(owner%(i, j)) / 10 / (population&(owner%(i, j)) + .001)
   IF localmorale(i, j) > 1 THEN localmorale(i, j) = 1
   IF original%(i, j) <> owner%(i, j) THEN localmorale(i, j) = localmorale(i, j) - .1
   IF localmorale(i, j) < 0 THEN localmorale(i, j) = 0
   morale(owner%(i, j)) = morale(owner%(i, j)) + localmorale(i, j)
  END IF
 NEXT j
NEXT i
FOR i = 1 TO players%
 IF land%(i) = 0 THEN morale(i) = 1 ELSE morale(i) = morale(i) / land%(i)
NEXT i
RETURN


science:
sciencerefresh:
CLS
GOSUB title
LOCATE 7, 1
PRINT "Agricult"
PRINT "Industry"
PRINT "Trade"
PRINT "Sailing"
PRINT "Military"
PRINT "Medicine"
FOR i = 1 TO players%
 COLOR ownercolor%(i)
 a = 1 + i * 8
 LOCATE 5, a
 PRINT name$(i)
 IF spy%(i) > 0 THEN
  FOR j = 1 TO 6
   LOCATE (6 + j), a
   PRINT INT(science(j, i) * 1000) / 1000;
  NEXT j
 END IF
NEXT i
LOCATE 14, 1
COLOR 14
PRINT "Your money:"; money&(player%); "       "
COLOR 7
PRINT
FOR i = 1 TO 6
 aa& = INT(science(i, player%) ^ 3 * 1000)
 IF sciencemoney&(i) < aa& THEN COLOR 7 ELSE COLOR 4
 PRINT "Spent on "; sciencename$(i); ":"; sciencemoney&(i); "    ";
 LOCATE 15 + i, 30
 PRINT i; "= spend 100;  "; CHR$(96 + i); " = spend 1000  (max:"; aa&; ")    "
NEXT i
LOCATE 28, 1
COLOR 7
PRINT "    Agriculture   Industry      Trade       Sailing     Military    Medicine"
max = 0
FOR i = 1 TO players%
 FOR j = 1 TO 6
  IF science(j, i) > max THEN max = science(j, i)
 NEXT j
NEXT i
FOR i = 1 TO players%
 IF spy%(i) > 0 THEN
  FOR j = 1 TO 6
   LINE (-50 + j * 100 + i * 5, 430)-(-50 + j * 100 + i * 5, 430 - science(j, i) / max * 90), ownercolor%(i)
  NEXT j
 END IF
NEXT i
k$ = ""
WHILE k$ = ""
 k$ = INKEY$
WEND
SELECT CASE k$
 CASE "1" TO "6"
  sciencemoney&(VAL(k$)) = sciencemoney&(VAL(k$)) + 100
  money&(player%) = money&(player%) - 100
 CASE "a" TO "f"
  sciencemoney&(ASC(k$) - 96) = sciencemoney&(ASC(k$) - 96) + 1000
  money&(player%) = money&(player%) - 1000
 CASE ELSE
  CLS
  RETURN
END SELECT
GOTO sciencerefresh


treasury:
treasuryrefresh:
CLS
GOSUB countproperties
GOSUB professions
GOSUB morale
GOSUB title
LOCATE 5, 1
PRINT "FLOW OF"
PRINT "COINS:"
PRINT
PRINT "Peasants"
PRINT "Fishers"
PRINT "Workers"
PRINT "Merchant"
PRINT "Mills..."
PRINT
PRINT "Interest"
PRINT
PRINT "Forts"
PRINT "Churches"
PRINT "Univers."
PRINT "Navy"
PRINT "Army"
PRINT
PRINT "Total"
PRINT
PRINT
PRINT "TREASURY"
PRINT
PRINT
COLOR ownercolor%(player%)
PRINT "Tax rate:"; INT(tax(player%) * 100 + .5); "%      Morale:"; INT(morale(player%) * 100 + .5); "%      ";
COLOR 7
PRINT "t = reduce tax      T = raise tax"
FOR i = 1 TO players%
 GOSUB finances
 COLOR ownercolor%(i)
 a = 1 + i * 8
 LOCATE 5, a
 PRINT name$(i)
 IF spy%(i) > 0 THEN
  LOCATE 8, a
  PRINT peas&
  LOCATE 9, a
  PRINT fish&
  LOCATE 10, a
  PRINT work&
  LOCATE 11, a
  PRINT merc&
  LOCATE 12, a
  PRINT mmil&
  LOCATE 14, a
  PRINT interest&
  LOCATE 16, a
  PRINT mfor&
  LOCATE 17, a
  PRINT mchu&
  LOCATE 18, a
  PRINT muni&
  LOCATE 19, a
  PRINT mnav&
  LOCATE 20, a
  PRINT marm&
  LOCATE 22, a
  PRINT total&
  LOCATE 25, a
  PRINT money&(i)
 END IF
NEXT i
COLOR 7
k$ = ""
WHILE k$ = ""
 k$ = INKEY$
WEND
SELECT CASE k$
 CASE "t"
  tax(player%) = tax(player%) - .01
  IF tax(player%) < 0 THEN tax(player%) = 0
 CASE "T"
  tax(player%) = tax(player%) + .01
  IF tax(player%) > 1 THEN tax(player%) = 1
 CASE ELSE
  CLS
  RETURN
END SELECT
GOTO treasuryrefresh


finances:
peas& = INT(peasant&(i) * tax(i) * morale(i) * science(1, i) * 4)
fish& = INT(fisher&(i) * tax(i) * morale(i) * science(4, i) * 4)
work& = INT(worker&(i) * tax(i) * morale(i) * science(2, i) * 8)
merc& = INT(merchant&(i) * tax(i) * morale(i) * science(3, i) * 16)
mmil& = -INT(mil%(i) * science(2, i) * mm)
IF money&(i) > 0 THEN
 interest& = INT(money&(i) * .04)
ELSE
 interest& = INT(money&(i) * .12)
END IF
mfor& = -INT(fo%(i) * mf)
mchu& = -INT(chu%(i) * mc)
muni& = -INT(uni%(i) * mu)
mnav& = -INT(navy%(i) * mn)
marm& = -INT(soldier&(i) * ma)
total& = peas& + fish& + work& + merc& + mmil& + interest& + mfor& + mchu& + muni& + mnav& + marm&
RETURN


diplomacy:
change% = 1
diplomacyrefresh:
CLS
GOSUB title
GOSUB countproperties
GOSUB spycost
LOCATE 5, 1
PRINT "Diplomatic relations"
PRINT "--------------------"
LOCATE 10, 1
FOR i = 1 TO players%
 COLOR ownercolor%(i)
 PRINT name$(i)
NEXT i
COLOR ownercolor%(player%)
PRINT
PRINT "Your"
PRINT "attitude"
PRINT
PRINT "Your"
PRINT "Info"
FOR i = 1 TO players%
 COLOR ownercolor%(i)
 a = 1 + i * 8
 LOCATE 7, a
 PRINT "("; i; ")"
 LOCATE 8, a
 PRINT name$(i)
 FOR j = 1 TO players%
  LOCATE (9 + j), a
  SELECT CASE dipl%(i, j)
   CASE 1
    PRINT "war"
   CASE 2
    PRINT "neutr."
   CASE 3
    PRINT "trade"
   CASE 4
    PRINT "friend"
   CASE 5
    PRINT "ally"
  END SELECT
  LOCATE 21, (a + 2)
   IF diplaction%(player%, i) = -1 THEN PRINT "-";
   IF diplaction%(player%, i) = 0 THEN PRINT "0";
   IF diplaction%(player%, i) = 1 THEN PRINT "+";
  LOCATE 24, a
   IF spy%(i) = 0 THEN PRINT "none"
   IF spy%(i) = 1 THEN PRINT "general"
   IF spy%(i) = 2 THEN PRINT "full"
 NEXT j
NEXT i
COLOR 7
LOCATE 26, 1
PRINT "1-9 = choose target country (currently: ";
COLOR ownercolor%(change%)
PRINT name$(change%);
COLOR 7
PRINT ")"
PRINT "Change attitude:   + = positive,   - = negative,   0 = neutral"
PRINT "Spying:  g = general info ";
SELECT CASE spy%(change%)
 CASE 0
  PRINT "("; INT(spycost%(change%) / 2); " gold)";
 CASE ELSE
  PRINT "(you already have)";
END SELECT
PRINT "   f = full info ";
SELECT CASE spy%(change%)
 CASE 0
  PRINT "("; spycost%(change%); " gold)"
 CASE 1
  PRINT "("; INT(spycost%(change%) / 2); " gold)"
 CASE ELSE
  PRINT "(you already have)"
END SELECT

k$ = ""
WHILE k$ = ""
k$ = INKEY$
WEND
SELECT CASE k$
 CASE "1" TO "9"
  change% = VAL(k$)
 CASE "+"
  diplaction%(player%, change%) = 1
 CASE "0"
  diplaction%(player%, change%) = 0
 CASE "-"
  diplaction%(player%, change%) = -1
 CASE "g"
  IF spy%(change%) = 0 THEN
   money&(player%) = money&(player%) - spycost%(change%) / 2
   spy%(change%) = 1
  END IF
 CASE "f"
  IF spy%(change%) = 0 THEN
   money&(player%) = money&(player%) - spycost%(change%)
  ELSEIF spy%(change%) = 1 THEN
   money&(player%) = money&(player%) - spycost%(change%) / 2
  END IF
  spy%(change%) = 2
 CASE ELSE
  CLS
  RETURN
END SELECT
GOTO diplomacyrefresh


spycost:
FOR i = 1 TO players%
 spycost%(i) = INT((5 - dipl%(i, player%)) ^ 2 * 10 * land%(i))
NEXT i
RETURN


spy:
FOR i = 1 TO players%
 SELECT CASE dipl%(player%, i)
  CASE 1 TO 2
   spy%(i) = 0
  CASE 3 TO 4
   spy%(i) = 1
  CASE 5
   spy%(i) = 2
 END SELECT
NEXT i
RETURN


see:
see% = 0
IF spy%(owner%(y, x)) = 2 THEN see% = 1
IF y > 1 THEN
 IF owner%(y - 1, x) = player% THEN see% = 1
END IF
IF y < 15 THEN
 IF owner%(y + 1, x) = player% THEN see% = 1
END IF
IF x > 1 THEN
 IF owner%(y, x - 1) = player% THEN see% = 1
END IF
IF x < 15 THEN
 IF owner%(y, x + 1) = player% THEN see% = 1
END IF
IF owner%(y, x) = 0 THEN see% = 0
RETURN


press:
WHILE INKEY$ = "": WEND
RETURN


savegame:
save$ = "save" + RIGHT$(STR$(save%), LEN(STR$(save%)) - 1) + ".scn"
OPEN save$ FOR OUTPUT AS #1
 PRINT #1, players%
 PRINT #1, player%
 PRINT #1, turn%
 FOR i = 1 TO 6
  PRINT #1, sciencemoney&(i)
 NEXT i
 FOR i = 1 TO players%
  PRINT #1, name$(i)
  PRINT #1, control$(i)
  PRINT #1, population&(i)
  PRINT #1, money&(i)
  PRINT #1, navy%(i)
  PRINT #1, seaarmy%(i)
  PRINT #1, seamoved%(i)
  PRINT #1, tax(i)
  PRINT #1, trust(i)
  FOR j = 1 TO 6
   PRINT #1, science(j, i)
  NEXT j
  FOR j = 1 TO players%
   PRINT #1, dipl%(i, j)
  NEXT j
  FOR j = 1 TO players%
   PRINT #1, diplaction%(i, j)
  NEXT j
 NEXT i
 FOR k = 1 TO 9
  FOR i = 1 TO 15
   FOR j = 1 TO 15
    SELECT CASE k
    CASE 1
     PRINT #1, owner%(i, j);
    CASE 2
     PRINT #1, original%(i, j);
    CASE 3
     PRINT #1, terrain%(i, j);
    CASE 4
     PRINT #1, fort%(i, j);
    CASE 5
     PRINT #1, church%(i, j);
    CASE 6
     PRINT #1, university%(i, j);
    CASE 7
     PRINT #1, mill%(i, j);
    CASE 8
     PRINT #1, army%(i, j);
    CASE 9
     PRINT #1, moved%(i, j);
    END SELECT
   NEXT j
   PRINT #1,
  NEXT i
 NEXT k
CLOSE
message$ = "Saved as: " + save$
save% = save% + 1
RETURN


help:
helprefresh:
CLS
GOSUB title
LOCATE 6, 1
PRINT "HELP"
PRINT "----"
PRINT "1 - About the game"
PRINT "2 - How to play?"
PRINT "3 - Money matters (income, costs, investments)"
PRINT "4 - Professions"
PRINT "5 - Science and development"
PRINT "6 - Diplomacy"
PRINT "7 - Military and war"
PRINT "8 - Other things to know..."
PRINT "9 - Back to the game"
k = 0
WHILE k = 0
k = VAL(INKEY$)
WEND
CLS
SELECT CASE k
 CASE 1
  help$ = "about.hlp"
 CASE 2
  help$ = "how.hlp"
 CASE 3
  help$ = "money.hlp"
 CASE 4
  help$ = "jobs.hlp"
 CASE 5
  help$ = "science.hlp"
 CASE 6
  help$ = "dipl.hlp"
 CASE 7
  help$ = "military.hlp"
 CASE 8
  help$ = "other.hlp"
 CASE 9
  CLS
  RETURN
END SELECT

IF k <> 9 THEN
 linesmax = 0
 OPEN help$ FOR INPUT AS #1
  DO UNTIL EOF(1)
   LINE INPUT #1, memo$
   linesmax = linesmax + 1
  LOOP
 CLOSE
 memo$ = ""
 upper = 1: lower = 25

hscroll:
 lines = 0
 CLS
 LOCATE 1, 1
 OPEN help$ FOR INPUT AS #1
  DO UNTIL EOF(1)
   lines = lines + 1
   LINE INPUT #1, text$
   IF lines >= upper AND lines <= lower THEN PRINT text$
   IF lines > lower THEN EXIT DO
  LOOP
 CLOSE
 LOCATE 28, 1
 PRINT "Possible keys:  Page up, Page down, Arrow up, Arrow down, Escape..."
 LINE (0, 420)-(640, 420), ownercolor%(player%)
 
waitforkey:
 nothing = 0
 k$ = INKEY$
 IF k$ = (CHR$(0) + "H") THEN
  IF upper > 1 THEN
   upper = upper - 1
   lower = lower - 1
   GOTO hscroll
  END IF
 ELSEIF k$ = (CHR$(0) + "P") THEN
  IF lower < linesmax THEN
   upper = upper + 1
   lower = lower + 1
   GOTO hscroll
  END IF
 ELSEIF k$ = (CHR$(0) + CHR$(73)) THEN
  upper = upper - 24
  lower = lower - 24
  IF upper < 1 THEN upper = 1
  IF lower < 25 THEN lower = 25
 ELSEIF k$ = (CHR$(0) + CHR$(81)) THEN
  upper = upper + 24
  lower = lower + 24
  IF upper > linesmax - 24 THEN upper = linesmax - 24
  IF lower > linesmax THEN lower = linesmax
 ELSE
  nothing = 1
 END IF
 IF k$ = CHR$(27) THEN
  GOTO helprefresh
 ELSEIF nothing = 1 THEN
  GOTO waitforkey
 ELSE
  GOTO hscroll
 END IF
END IF
GOTO helprefresh


info:
CLS
GOSUB countproperties
GOSUB professions
GOSUB morale
GOSUB title
LOCATE 7, 1
PRINT "Land"
PRINT "Sea"
PRINT "Popul."
PRINT "Money"
PRINT : PRINT "Tax"
PRINT "Morale"
PRINT "Trust"
PRINT : PRINT "Forts"
PRINT "Church"
PRINT "Univer."
PRINT "Mills"
PRINT "Ships"
PRINT : PRINT "Peasant"
PRINT "Fisher"
PRINT "Worker"
PRINT "Merchant"
PRINT "Soldier"
COLOR 8
PRINT "Embarked"
COLOR 7
PRINT "Unempl."
FOR i = 1 TO players%
 COLOR ownercolor%(i)
 a = 1 + i * 8
 LOCATE 5, a
 PRINT name$(i)
 LOCATE 7, a
 PRINT land%(i)
 IF spy%(i) > 0 THEN
  LOCATE 8, a
  PRINT INT(sea(i) * 100 + .5); "%"
  LOCATE 9, a
  PRINT population&(i)
  LOCATE 10, a
  PRINT money&(i)
  LOCATE 12, a
  PRINT INT(tax(i) * 100 + .5); "%"
  LOCATE 13, a
  PRINT INT(morale(i) * 100 + .5); "%"
 END IF
 LOCATE 14, a
 PRINT INT(trust(i) * 100 + .5); "%"
 IF spy%(i) > 0 THEN
  LOCATE 16, a
  PRINT fo%(i)
  LOCATE 17, a
  PRINT chu%(i)
  LOCATE 18, a
  PRINT uni%(i)
  LOCATE 19, a
  PRINT mil%(i)
  LOCATE 20, a
  PRINT navy%(i)
  LOCATE 22, a
  PRINT peasant&(i)
  LOCATE 23, a
  PRINT fisher&(i)
  LOCATE 24, a
  PRINT worker&(i)
  LOCATE 25, a
  PRINT merchant&(i)
  LOCATE 26, a
  PRINT soldier&(i)
  LOCATE 27, a
  PRINT seaarmy%(i) + seamoved%(i)
  LOCATE 28, a
  PRINT unemployed&(i)
 END IF
NEXT i
GOSUB press
CLS
RETURN


bye:
CLS
LOCATE 14, 24
PRINT "Would you like to play a new game?"
k$ = INKEY$
WHILE k$ <> "y" AND k$ <> "n"
 k$ = INKEY$
WEND
IF k$ = "y" THEN GOTO opening:
CLS
COLOR (RND * 14 + 1)
LOCATE RND * 28 + 1, RND * 74 + 1
PRINT "BYE!"
GOSUB dragnet
SLEEP 1
SYSTEM
END


aicombat:
IF active% = 1 THEN GOTO victory
IF land%(player%) = 0 THEN
 WHILE land%(player%) = 0
  IF player% < players% THEN
   player% = player% + 1
  ELSE
   player% = 1
   turn% = turn% + 1
  END IF
 WEND
END IF
LINE (30, 400)-(110, 100), 0, BF
LINE (510, 400)-(590, 100), 0, BF
LOCATE 1, 1
GOSUB title
GOSUB drawmap
LOCATE 5, 35
PRINT "AI COMBAT"
LOCATE 6, 25
PRINT "Turn:"; turn%
LOCATE 6, 45
COLOR ownercolor%(player%)
PRINT name$(player%); "    "
COLOR 7
maxprop& = 0
maxsc = 0
FOR i = 1 TO players%
 property&(i) = fo%(i) * BF + chu%(i) * bc + uni%(i) * bu + mil%(i) * bm + navy%(i) * bn + soldier&(i) * ba + money&(i)
 level(i) = 0
 FOR j = 1 TO 6
  level(i) = level(i) + science(j, i)
 NEXT j
 level(i) = level(i) / 6
 IF property&(i) > maxprop& THEN maxprop& = property&(i)
 IF level(i) > maxsc THEN maxsc = level(i)
NEXT i
FOR i = 1 TO players%
 LINE (20 + i * 10, 400)-(20 + i * 10, 400 - property&(i) / maxprop& * 300), ownercolor%(i)
 LINE (500 + i * 10, 400)-(500 + i * 10, 400 - level(i) / maxsc * 300), ownercolor%(i)
NEXT i
LOCATE 27, 1
PRINT "Value of properties                                        Average science level"
LOCATE 27, 35
PRINT save$
LOCATE 6, 1
PRINT " max ="; maxprop&; "gold  "
LOCATE 6, 63
PRINT " max ="; INT(maxsc * 1000) / 1000; "   "
LOCATE 28, 21
PRINT "n = next player      N = next turn"
LOCATE 29, 21
PRINT "s = save             q = quit";
IF turn% < nextturn THEN GOTO ai
k$ = INKEY$
WHILE k$ <> "n" AND k$ <> "N" AND k$ <> "s" AND k$ <> "q"
 k$ = INKEY$
WEND
nextturn = 0
IF k$ = "N" THEN nextturn = turn% + 1
IF k$ = "n" OR k$ = "N" THEN GOTO ai
IF k$ = "s" THEN GOSUB savegame
IF k$ = "q" THEN GOTO bye
GOTO aicombat


victory:
FOR i = 1 TO players%
 IF land%(i) > 0 THEN winner% = i
NEXT i
CLS
GOSUB title
GOSUB drawmap
LOCATE 14, 4
PRINT "HEGEMONY!!!"
PRINT "   -----------"
LOCATE 14, 61
PRINT "HEGEMONY!!!"
LOCATE 15, 61
PRINT "-----------"
LOCATE 5, 1
COLOR 15
PRINT "        Eternal glory to the victorious leader of "; name$(winner%); ", the most"
PRINT "    magnificent emperor in history, who brought us unity, peace and wealth!"
LOCATE 26, 1
COLOR 8
PRINT "   (The vicious oppressor shall burn in the flames of hell forever, for all"
PRINT "                    the sorrow and misery he caused us!)"
GOSUB organ
GOSUB press
OPEN "bestturn.txt" FOR INPUT AS #1
 FOR i = 1 TO players%
  INPUT #1, bestname$(i)
  INPUT #1, bestturn(i)
  INPUT #1, bestcontrol$(i)
  INPUT #1, bestdate$(i)
 NEXT i
CLOSE
IF bestturn(winner%) >= turn% THEN
 bestname$(winner%) = name$(winner%)
 bestturn(winner%) = turn%
 bestcontrol$(winner%) = control$(winner%)
 bestdate$(winner%) = DATE$
 OPEN "bestturn.txt" FOR OUTPUT AS #1
  FOR i = 1 TO players%
   WRITE #1, bestname$(i), bestturn(i), bestcontrol$(i), bestdate$(i)
  NEXT i
 CLOSE
END IF
GOTO bye


debt:
FOR i = 1 TO players%
 diplaction%(player%, i) = 1
NEXT i
money&(player%) = money&(player%) + sn * navy%(player%)
navy%(player%) = 0
IF money&(player%) < 0 THEN
 FOR i = 1 TO 15
  FOR j = 1 TO 15
   IF owner%(i, j) = player% AND threat(i, j) = (-1) * army%(i, j) * (1 + terdefense(terrain%(i, j)) + fort%(i, j) * .3) THEN
    money&(player%) = money&(player%) + sf * fort%(i, j)
    fort%(i, j) = 0
   END IF
   IF owner%(i, j) = player% AND army%(i, j) > 1 THEN
    a = INT(army%(i, j) / 10)
    IF enemyvalue = 0 THEN a = a * 3
    IF a = 0 AND army%(i, j) > 1 THEN a = 1
    army%(i, j) = army%(i, j) - a
    money&(player%) = money&(player%) + sa * a
   END IF
   IF owner%(i, j) = player% AND university%(i, j) > 0 THEN
    IF original%(i, j) <> player% OR RND < .5 THEN
     university%(i, j) = university%(i, j) - 1
     money&(player%) = money&(player%) + su
    END IF
   END IF
  NEXT j
 NEXT i
END IF
RETURN


military:
i = player%
GOSUB finances
IF total& < 0 THEN RETURN
IF RND > landorsea AND sea(player%) < .6 AND (navy%(player%) < (10 * (1 - landorsea) * soldier&(player%)) OR sea(player%) < (1 / active%)) AND landenemy% = 0 THEN
 'sea forces
 'effects of a 10000 gold invention: a=navy, b=sailing, c=military
 a = 10000 / (bn + planning * mn) * science(4, player%) * science(5, player%)
 B = (1 + uni%(player%) / (population&(player%) + .001) * 50) / (science(4, player%) ^ 3) * navy%(player%) * science(5, player%)
 c = (1 + uni%(player%) / (population&(player%) + .001) * 50) / (science(5, player%) ^ 3) * navy%(player%) * science(4, player%)
 IF a > B AND a > c THEN
  d = INT(spend& / bn)
  navy%(player%) = navy%(player%) + d
  money&(player%) = money&(player%) - d * bn
 ELSEIF B > a AND B > c THEN
  d = INT(science(4, player%) ^ 3 * 1000)
  IF spend& < d THEN d = spend&
  sciencemoney&(4) = d
  money&(player%) = money&(player%) - d
 ELSE
  d = INT(science(5, player%) ^ 3 * 1000)
  IF spend& < d THEN d = spend&
  sciencemoney&(5) = d
  money&(player%) = money&(player%) - d
 END IF
ELSE
 'land forces
 'effects of a 10000 gold invention: a=forts, b=soldiers, c=military
 a = 10000 / (BF + planning * mf) * .3 * soldier&(player%) * science(5, player%)
 B = 10000 / (ba + planning * ma) * (1 + fo%(player%) * .3) * science(5, player%)
 c = (1 + uni%(player%) / (population&(player%) + .001) * 50) / (science(5, player%) ^ 3) * (1 + fo%(player%) * .3) * soldier&(player%)
 IF c > a AND c > B THEN
  'develop military
  d = INT(science(5, player%) ^ 3 * 1000)
  IF spend& < d THEN d = spend&
  sciencemoney&(5) = d
  money&(player%) = money&(player%) - d
 ELSE
  'build forts
  FOR i = 1 TO 15
   FOR j = 1 TO 15
    a = 10000 / (BF + planning * mf) * .3 * army%(i, j)
    B = 10000 / (ba + planning * ma) * (1 + fort%(i, j) * .3)
    IF a > B AND owner%(i, j) = player% AND threat(i, j) > 0 AND spend& >= BF THEN
     fort%(i, j) = fort%(i, j) + 1
     money&(player%) = money&(player%) - BF
     spend& = spend& - BF
    END IF
   NEXT j
  NEXT i
  'build army
  IF maxthreat > 0 AND spend& >= ba THEN
   IF maxthreat > (spend& / ba) THEN d = INT(spend& / ba) ELSE d = INT(maxthreat)
   e& = population&(player%) - soldier&(player%)
   IF e& < d THEN d = e&
   army%(threati, threatj) = army%(threati, threatj) + d
   money&(player%) = money&(player%) - d * ba
   spend& = spend& - d * ba
  END IF
  FOR i = 1 TO 15
   FOR j = 1 TO 15
    IF owner%(i, j) = player% AND threat(i, j) > 0 AND spend& >= ba THEN
     IF maxthreat > spend& / ba THEN d = INT(spend& / ba) ELSE d = INT(maxthreat)
     army%(i, j) = army%(i, j) + d
     money&(player%) = money&(player%) - d * ba
     spend& = spend& - d * ba
    END IF
   NEXT j
  NEXT i
  FOR i = 1 TO 15
   FOR j = 1 TO 15
    IF owner%(i, j) = player% AND spend& >= ba THEN
     d = INT(spend& / ba / land%(player%)) + 1
     army%(i, j) = army%(i, j) + d
     money&(player%) = money&(player%) - d * ba
     spend& = spend& - d * ba
    END IF
   NEXT j
  NEXT i
 END IF
END IF
RETURN


building:
spendchurch& = money&(player%) * aichurch
spendmill& = money&(player%) * aimill
spendnavy& = money&(player%) * ainavy
round = 0
buildmore:
FOR i = 1 TO 15
 FOR j = 1 TO 15
  IF owner%(i, j) = player% THEN
   IF (ownmill% = 0 AND original%(i, j) = player%) OR ownmill% = 1 THEN
    IF mill%(i, j) < prodpot(terrain%(i, j)) AND spendmill& >= bm THEN
     mill%(i, j) = mill%(i, j) + 1
     spendmill& = spendmill& - bm
     money&(player%) = money&(player%) - bm
    END IF
   END IF
   maxmor = .5 + trust(player%) / 2
   IF money&(player%) < 0 THEN maxmor = maxmor + money&(player%) / 10 / population&(player%)
   IF original%(i, j) <> player% THEN maxmor = maxmor - .1
   IF maxmor < 0 THEN maxmor = 0
   a = (1 - localmorale(i, j)) * 2
   IF original%(i, j) <> player% THEN
    IF localmorale(i, j) + .005 < maxmor THEN
     a = 1
    ELSE
     a = 0
    END IF
   END IF
   IF RND < a THEN
    IF spendchurch& >= bc THEN
     church%(i, j) = church%(i, j) + 1
     spendchurch& = spendchurch& - bc
     money&(player%) = money&(player%) - bc
    END IF
   END IF
  END IF
 NEXT j
NEXT i
round = round + 1
IF (spendmill& > bm OR spendchurch& > bc) AND round < 5 THEN GOTO buildmore
i = player%
GOSUB finances
IF sea(player%) < .6 AND (navy%(player%) < (10 * (1 - landorsea) * soldier&(player%)) OR sea(player%) < (1 / active%)) AND total& > 0 THEN
 a = INT(spendnavy& / bn)
 navy%(player%) = navy%(player%) + a
 money&(player%) = money&(player%) - a * bn
END IF
RETURN


developscience:
IF aiuni > RND THEN
 IF unii > 0 AND unij > 0 THEN
  a = INT(money&(player%) / bu)
  university%(unii, unij) = university%(unii, unij) + a
  money&(player%) = money&(player%) - a * bu
 END IF
ELSE
 FOR i = 1 TO 6
  aa& = INT(science(i, player%) ^ 3 * 1000) - sciencemoney&(i)
  bb& = INT(money&(player%) * aiscience(i))
  IF unemployed&(player%) > 6 AND i = 6 THEN bb& = 0
  IF bb& > aa& THEN
   sciencemoney&(i) = sciencemoney&(i) + aa&
   money&(player%) = money&(player%) - aa&
  ELSE
   sciencemoney&(i) = sciencemoney&(i) + bb&
   money&(player%) = money&(player%) - bb&
  END IF
 NEXT i
END IF
RETURN


drawmap:
FOR i = 1 TO 15
 FOR j = 1 TO 15
  LINE (130 + j * 20, 80 + i * 20)-(150 + j * 20, 100 + i * 20), 0, B
  LINE (131 + j * 20, 81 + i * 20)-(149 + j * 20, 99 + i * 20), tercolor(terrain%(i, j)), BF
  IF owner%(i, j) <> 0 THEN LINE (145 + j * 20, 95 + i * 20)-(150 + j * 20, 100 + i * 20), 0, B
  IF owner%(i, j) <> 0 THEN LINE (146 + j * 20, 96 + i * 20)-(150 + j * 20, 100 + i * 20), ownercolor%(owner%(i, j)), BF
 NEXT j
NEXT i
RETURN


neutral:
FOR i = 1 TO players%
 IF i <> player% THEN
  dipl%(player%, i) = 2
  dipl%(i, player%) = 2
 END IF
NEXT i
IF money&(player%) < 0 THEN
 money&(player%) = money&(player%) + sn * navy%(player%)
 navy%(player%) = 0
END IF
IF money&(player%) < 0 THEN
 FOR i = 1 TO 15
  FOR j = 1 TO 15
   IF owner%(i, j) = player% THEN
    army%(i, j) = INT(army%(i, j) / 2)
    money&(player%) = money&(player%) + sa * army%(i, j)
    university%(i, j) = INT(university%(i, j) / 2)
    money&(player%) = money&(player%) + su * university%(i, j)
    fort%(i, j) = INT(fort%(i, j) / 2)
    money&(player%) = money&(player%) + sf * fort%(i, j)
    IF church%(i, j) > 5 THEN church%(i, j) = church%(i, j) - 1
    money&(player%) = money&(player%) + sc
   END IF
  NEXT j
 NEXT i
END IF
IF money&(player%) < 0 THEN money&(player%) = INT(RND * 1000)
GOSUB countproperties
population&(player%) = allfood&(player%) * 50
RETURN


revolt:
revoltbonus = 1
 a = original%(i, j)
IF i > 1 THEN
 B = owner%(i - 1, j)
 c = original%(i - 1, j)
 IF a = c AND B = c THEN revoltbonus = revoltbonus + 1
END IF
IF i < 15 THEN
 B = owner%(i + 1, j)
 c = original%(i + 1, j)
 IF a = c AND B = c THEN revoltbonus = revoltbonus + 1
END IF
IF j > 1 THEN
 B = owner%(i, j - 1)
 c = original%(i, j - 1)
 IF a = c AND B = c THEN revoltbonus = revoltbonus + 1
END IF
IF j < 15 THEN
 B = owner%(i, j + 1)
 c = original%(i, j + 1)
 IF a = c AND B = c THEN revoltbonus = revoltbonus + 1
END IF
IF revoltnation = original%(i, j) THEN revoltbonus = revoltbonus + revoltlevel
RETURN


enemydistance:
FOR i = 1 TO 15
 FOR j = 1 TO 15
  IF owner%(i, j) = 0 THEN ed%(i, j) = 0 ELSE ed%(i, j) = 99
  IF i > 1 THEN
   IF owner%(i - 1, j) = 0 AND ed%(i, j) > 1 THEN ed%(i, j) = 1
   IF ed%(i, j) > dipl%(owner%(i - 1, j), owner%(i, j)) - 1 AND owner%(i - 1, j) <> 0 AND owner%(i, j) <> 0 THEN ed%(i, j) = dipl%(owner%(i - 1, j), owner%(i, j)) - 1
  END IF
  IF i < 15 THEN
   IF owner%(i + 1, j) = 0 AND ed%(i, j) > 1 THEN ed%(i, j) = 1
   IF ed%(i, j) > dipl%(owner%(i + 1, j), owner%(i, j)) - 1 AND owner%(i + 1, j) <> 0 AND owner%(i, j) <> 0 THEN ed%(i, j) = dipl%(owner%(i + 1, j), owner%(i, j)) - 1
  END IF
  IF j > 1 THEN
   IF owner%(i, j - 1) = 0 AND ed%(i, j) > 1 THEN ed%(i, j) = 1
   IF ed%(i, j) > dipl%(owner%(i, j - 1), owner%(i, j)) - 1 AND owner%(i, j - 1) <> 0 AND owner%(i, j) <> 0 THEN ed%(i, j) = dipl%(owner%(i, j - 1), owner%(i, j)) - 1
  END IF
  IF j < 15 THEN
   IF owner%(i, j + 1) = 0 AND ed%(i, j) > 1 THEN ed%(i, j) = 1
   IF ed%(i, j) > dipl%(owner%(i, j + 1), owner%(i, j)) - 1 AND owner%(i, j + 1) <> 0 AND owner%(i, j) <> 0 THEN ed%(i, j) = dipl%(owner%(i, j + 1), owner%(i, j)) - 1
  END IF
 NEXT j
NEXT i
FOR k = 1 TO 9
 FOR i = 1 TO 15
  FOR j = 1 TO 15
   IF i > 1 THEN
    IF ed%(i - 1, j) + 1 < ed%(i, j) THEN ed%(i, j) = ed%(i - 1, j) + 1
   END IF
   IF i < 15 THEN
    IF ed%(i + 1, j) + 1 < ed%(i, j) THEN ed%(i, j) = ed%(i + 1, j) + 1
   END IF
   IF j > 1 THEN
    IF ed%(i, j - 1) + 1 < ed%(i, j) THEN ed%(i, j) = ed%(i, j - 1) + 1
   END IF
   IF j < 15 THEN
    IF ed%(i, j + 1) + 1 < ed%(i, j) THEN ed%(i, j) = ed%(i, j + 1) + 1
   END IF
  NEXT j
 NEXT i
NEXT k
RETURN


beethoven:
'Beethoven's Fifth
PLAY "T180 o2 P2 P8 L8 GGG L2 E-"
PLAY "P24 P8 L8 FFF L2 D"
RETURN


death:
'Dead March from Saul
PLAY "l8t200mlo1c..p16c.p32cp32c.p8e..dp32d.cp32c.o0bo1c..mn"
RETURN


dragnet:
'Dragnet
PLAY "t255o2l2cl8dd#p8cp8l2f#"
RETURN


organ:
PLAY "T110ML"
PLAY "O2e-16c16e-16g16O3c16e-16d16c16O2b16g16b16O3d16g16f16e-16d16"
IF INKEY$ <> "" THEN RETURN
PLAY "O3e-16c16e-16g16O4c16e-16d16c16d16c16O3b16a16g16f16e-16d16"
IF INKEY$ <> "" THEN RETURN
PLAY "O3e-16c16e-16g16O4c16e-16d16c16O3b16g16b16O4d16g16f16e-16d16"
IF INKEY$ <> "" THEN RETURN
PLAY "O4e-16c16e-16g16O5c16e-16d16c16d16c16O4b16a16g16f16e-16d16"
IF INKEY$ <> "" THEN RETURN
PLAY "O4e-16c16O3g16e-16c16O5c16O4g16e-16a-16O2f16a16O3c16f16a-16"
PLAY "O4c16e-16"
IF INKEY$ <> "" THEN RETURN
PLAY "O4d16O3b-16f16d16O2b-16O4b-16f16d16g16O2e-16g16b-16O3e-16g16b-16"
PLAY "O4d16"
IF INKEY$ <> "" THEN RETURN
PLAY "O4c16O3a16g+16a16O4c16O3a16g+16a16O4e-16c16O3g16a16O4e-16c16O3"
PLAY "g16a16"
IF INKEY$ <> "" THEN RETURN
PLAY "O4d16c16O3f+16a16O4a16c16O3f+16a16O4f+16c16O3d16a16O4c16O3a16"
PLAY "f+16d16"
IF INKEY$ <> "" THEN RETURN
PLAY "O3b-16O1g16b-16O2d16g16b-16a16g16f+16d16f+16a16O3d16c16O2b-16a16"
IF INKEY$ <> "" THEN RETURN
PLAY "O2b-16g16b-16O3d16g16b-16a16g16a16g16f+16e16d16c16O2b-16a16"
IF INKEY$ <> "" THEN RETURN
PLAY "O2b-16g16b-16O3d16g16b-16a16g16f+16d16f+16a16O4d16c16O3b-16a16"
IF INKEY$ <> "" THEN RETURN
PLAY "O3b-16g16b-16O4d16g16b-16a16g16a16g16f+16e16d16c16O3b-16a16"
IF INKEY$ <> "" THEN RETURN
PLAY "O3b-16g16b-16O4d16g16d16O3b-16g16O2f16O4g16d16O3b16g16b16O4d16g16"
IF INKEY$ <> "" THEN RETURN
PLAY "o4c16o3g16o4g16o3g16o4c16o3g16o4g16o3g16b16g16o4f16o3g16b16g16"
IF INKEY$ <> "" THEN RETURN
PLAY "o4f16o3g16"
PLAY "o4e-16c16e-16g16o5c16o4g16e-16c16o2b-16o5c16o4g16e16c16e16g16"
IF INKEY$ <> "" THEN RETURN
PLAY "o5c16"
PLAY "o4f16c16o5c16o4c16f16c16o5c16o4c16e16c16b-16c16e16c16b-16c16"
IF INKEY$ <> "" THEN RETURN
PLAY "o2a-16f16a-16o3c16f16a-16g16f16g16f16e16d16c16o2b-16a-16g16"
IF INKEY$ <> "" THEN RETURN
PLAY "o3a-16f16a-16o4c16f16a-16g16f16g16f16e16d16c16o3b-16a-16g16"
IF INKEY$ <> "" THEN RETURN
PLAY "o3a-16o4f16c16o3a-16f16o4c16o3a-16f16c16a-16f16c16o2a-16o3f16"
PLAY "c16o2a-16"
IF INKEY$ <> "" THEN RETURN
PLAY "o2d-2o4a-16f16e16f16g16f16e16f16"
PLAY "o1b2o5d16o4f16g16a-16g16f16e-16d16"
IF INKEY$ <> "" THEN RETURN
PLAY "o4e-16g16o5c16o4g16b-16a-16g16f16e-4d4"
IF INKEY$ <> "" THEN RETURN
PLAY "o4c16o3g16o4g16o3g16o4c16o3g16o4g16o3g16b16g16o4f16o3g16b16g16"
PLAY "o4g16o3g16"
IF INKEY$ <> "" THEN RETURN
PLAY "o3b-16g16o4e16o3g16b-16g16o4e16o3g16a16o4e-16o5c16o4e-16o3a16"
PLAY "o4e-16o5c16o4e-16"
IF INKEY$ <> "" THEN RETURN
PLAY "o3a-16f16o4d16o3f16a-16f16o4d16o3f16g16o4d-16b-16d-16o3g16o4d-16"
PLAY "b-16d-16"
IF INKEY$ <> "" THEN RETURN
PLAY "o3f+16e-16o4c16o3e-16f+16e-16o4c16o3e-16e-16o4c16o5c16o4c16o3e-16"
IF INKEY$ <> "" THEN RETURN
PLAY "o3e-16o4c16e-16g16o5c16g16e-16c16g16e-16c16o3g16o4f16d16o3b16f16"
IF INKEY$ <> "" THEN RETURN
PLAY "o3e-16c16e-16g16o4c16e-16d16c16d16c16o3b16a16g16f16e-16d16"
IF INKEY$ <> "" THEN RETURN
PLAY "o4e-16c16e-16g16o5c16e-16d16o4b16o5c16o4g16e-16d16c16o3g16e-16d16"
PLAY "o3c16.p4"
RETURN


eye:
DATA 16,16,16,16,00,00,00,00,16,16,16,16
DATA 16,16,00,00,00,15,15,00,00,00,16,16
DATA 16,00,00,15,15,06,06,15,15,00,00,16
DATA 00,00,15,15,06,06,06,06,15,15,00,00
DATA 16,00,00,15,06,06,06,06,15,00,00,16
DATA 16,16,00,00,00,06,06,00,00,00,16,16
DATA 16,16,16,16,00,00,00,00,16,16,16,16


'-----=====END OF GAME=====-----

FUNCTION fixcolor (col AS INTEGER)
  SELECT CASE col
  CASE 1
   fixcolor = 4
  CASE 3
   fixcolor = 6
  CASE 4
   fixcolor = 1
  CASE 6
   fixcolor = 3
  CASE 9
   fixcolor = 12
  CASE 11
   fixcolor = 14
  CASE 12
   fixcolor = 9
  CASE 14
   fixcolor = 11
  CASE ELSE
   fixcolor = col
  END SELECT
END FUNCTION

