'                         Taito Space Invaders
'                                 ллл
'                               ллллллл
'                             ллллллллллл
'                             л   ллл   л
'                           ллллллл ллллллл
'                              лл     лл
'                            лл  лл лл  лл
'                           лл  лл   лл  лл
'                                  v1
'                      anarky - anarky.tk, 2005

DEFINT A-Z

DECLARE FUNCTION ArrayBytes (x, y)
DECLARE SUB DefineGraphics ()
DECLARE SUB SetColour (colour, r, g, b)
DECLARE SUB Display (x, y, a$)
DECLARE SUB DisplayLife (life, visible)
DECLARE SUB DisplayScore ()
DECLARE SUB DrawPlanet (visible)
DECLARE SUB DrawShelters (visible)
DECLARE SUB Delay (seconds!)
DECLARE SUB ClearScreen ()
DECLARE SUB ClearScreenToCRT ()
DECLARE SUB IncScore (scoregain)
DECLARE SUB ErodeShelter (x, y)

DECLARE FUNCTION sbvoicetoreg (voice)
DECLARE SUB sbwritereg (register, byte)
DECLARE SUB sbresetcard ()
DECLARE SUB sbsetupvoice (voice)
DECLARE SUB sbvoiceoff (voice)
DECLARE SUB sbplaynote (voice, octave, note)
DECLARE SUB sbvolume (voice, volume)
DECLARE SUB sbmodulate (voice, volume)

DEF SEG = 0
RANDOMIZE TIMER
SCREEN 13

true = -1
false = NOT true

screenwidth = 256
screenorgx = 32
shipwidth = 15
shipheight = 8
shipminx = 50
shipmaxx = 270 - shipwidth
bulletheight = 3
bulletd = 3
invwidth = 12
invheight = 8
invbombheight = 5
invdiry = 7
invzaptime = 15
saucerwidth = 16
saucerheight = 7
saucery = 28
sheltery = 156
shelterwidth = 24
shelterheight = 16

shipcolour = 255
bulletcolour = 254
bombcolour = 253
shipexplodecolour = 252
sheltercolour = 251
textcolour = 250
invexplodewhitecolour = 249
invexplodegreencolour = 248
planetcolour = 247
saucercolour = 246
crtcolour = 245

SetColour shipcolour, 0, 63, 0
SetColour bulletcolour, 63, 63, 63
SetColour bombcolour, 63, 63, 63
SetColour shipexplodecolour, 0, 63, 0
SetColour sheltercolour, 0, 63, 0
SetColour textcolour, 63, 63, 63
SetColour invexplodewhitecolour, 63, 63, 63
SetColour invexplodegreencolour, 0, 63, 0
SetColour planetcolour, 0, 63, 0
SetColour saucercolour, 63, 0, 0
SetColour crtcolour, 14, 14, 14

shipgsize = ArrayBytes(shipwidth - 4, shipheight - 4)
DIM shipg(shipgsize)
DIM shipexpg(2 * shipgsize)
invgsize = ArrayBytes(invwidth - 3, invheight - 3)
DIM invg(4 * 55 * invgsize)
DIM invg2(4 * 55 * invgsize)
invbombgsize = ArrayBytes(1, 3)
DIM invbombg(2 * invbombgsize)
DIM invexpg(3 * invgsize)
DIM saucerg(ArrayBytes(saucerwidth - 3, saucerheight - 3))
DIM shelterg(ArrayBytes(shelterwidth - 6, shelterheight - 6))
chargsize = ArrayBytes(2, 5)
DIM charset(chargsize * 39)

DIM damagex(255), damagey(255)
FOR i = 0 TO 255
  damagex(i) = RND * 4
  damagey(i) = RND * 6
NEXT

invvoice = 1
bulletvoice = 2
invzapvoice = 3
saucervoice = 4
shipexpvoice = 5

DIM invnote(3)
FOR i = 0 TO 3
  READ invnote(i)
NEXT
DATA &H2AE,&H287,&H263,&H241
sbresetcard
FOR i = 1 TO 5
  sbsetupvoice i
NEXT
sbmodulate invvoice, 40
sbmodulate bulletvoice, 45
sbvolume bulletvoice, 45
sbmodulate invzapvoice, 20
sbvolume invzapvoice, 53
sbvolume saucervoice, 55
sbmodulate shipexpvoice, 63

DefineGraphics
DIM invx(55), invy(55), invs(55)
DIM bombx(20), bomby(20), bombs(20), bombtype(20)

speedtest = false
score = 0

WHILE NOT switchoff
  ClearScreen
  WHILE INKEY$ > ""
  WEND
  Display 0, 0, "SCORE"
  DisplayScore
  a$ = ""
  WHILE a$ = ""
    WAIT &H3DA, 8
    WAIT &H3DA, 8, 8
    Display 11 * 8, 10 * 9, "GAME OVER"
    FOR i = 1 TO 2
      WAIT &H3DA, 8
      WAIT &H3DA, 8, 8
    NEXT
    Display 11 * 8, 10 * 9, "         "
    a$ = INKEY$
    switchoff = (a$ = CHR$(27))
  WEND

  '------------------ Next Game ---------------

  IF NOT switchoff THEN
    score = 0
    lives = 3
    level = 1
    damagecounter = RND * 200
    maxbombs = 12
    bombchance = 95
    gameover = false
    ClearScreen
    Display 0, 0, "SCORE"
    DisplayScore
    Display 16 * 8, 0, "LIVES"
    FOR i = 1 TO lives
      DisplayLife i, true
    NEXT
  END IF

  '------------------ Next Level --------------

  WHILE NOT gameover AND NOT switchoff
    DrawPlanet true
    IF level < 5 THEN
      DrawShelters true
    END IF
    maxbombs = maxbombs - (maxbombs < 20)
    bombchance = bombchance + (bombchance > 80)
    shipx = shipminx
    shipy = 199 - shipheight * 2
    canfire = false
    saucers = false
    inv = 1
    FOR y = 0 TO 4
      FOR x = 0 TO 10
        invx(inv) = shipminx + shipwidth + x * 16
        invy(inv) = shipy - 2 - invheight - (6 - level) * 14 - y * 14
        invs(inv) = true
        inv = inv + 1
      NEXT
    NEXT
    invleft = 55
    inv = 0
    invanim = 0
    invnote = 0
    invnotelength = 12
    invnoted = 1
    invnotes = true
    invdirx = 2
    changedir = 0
    numbombs = 0
    FOR i = 1 TO maxbombs
      bombs(i) = false
    NEXT
    endinglevel = false
    Delay .6
    saucercycles = 0
    shots = 0
    saucercount = 0

    '------------------ Next Cycle --------------

    WHILE NOT endlevel AND NOT gameover AND NOT switchoff
      WAIT &H3DA, 8
      WAIT &H3DA, 8, 8
      IF speedtest THEN
        SetColour 0, 32, 16, 16
      END IF

      'move invaders

      IF (NOT dying) AND (NOT endinglevel) AND (invzapticks = 0) THEN
        inv = inv + 1
        oldinvanim = invanim
        IF inv = 56 THEN
          inv = 1
          invanim = invanim XOR 1
          SELECT CASE changedir
            CASE 1
            changedir = 2
            CASE 2
            invdirx = -invdirx
            changedir = 0
          END SELECT
        END IF
        WHILE invs(inv) = false
          inv = inv + 1
          IF inv = 56 THEN
            inv = 1
            invanim = invanim XOR 1
            SELECT CASE changedir
              CASE 1
              changedir = 2
              CASE 2
              invdirx = -invdirx
              changedir = 0
            END SELECT
          END IF
        WEND
        LINE (invx(inv), invy(inv))-STEP(invwidth - 1, invheight - 1), crtcolour, BF
        IF changedir = 2 THEN
          invy(inv) = invy(inv) + invdiry
          IF invy(inv) > shipy - invheight THEN
            lives = 1
            LINE (shipx, shipy)-STEP(shipwidth - 1, shipheight - 1), crtcolour, BF
            dying = true
            deathroes = 0
          END IF
          ELSE
          invx(inv) = invx(inv) + invdirx
          IF invx(inv) <= shipminx - invwidth OR invx(inv) >= shipmaxx + shipwidth THEN
            changedir = 1
          END IF
        END IF
        IF invy(inv) < sheltery - invheight THEN
          PUT (invx(inv), invy(inv)), invg((inv - 1) * invgsize * 4 + invanim * 2 * invgsize), PSET
          ELSEIF invy(inv) < sheltery THEN
          PUT (invx(inv), invy(inv)), invg((inv - 1) * invgsize * 4 + invanim * 2 * invgsize + invgsize), PSET
          ELSE
          PUT (invx(inv), invy(inv)), invg2((inv - 1) * invgsize * 4 + invanim * 2 * invgsize), PSET
        END IF
      END IF

      'invader move sound

      invnoted = invnoted - 1
      IF invnoted = 0 THEN
        IF invnotes THEN
          IF invleft > 11 THEN
            sbvoiceoff invvoice
          END IF
          invnoted = invleft - invnotelength
          IF invnoted < 1 THEN
            invnoted = 1
          END IF
          ELSE
          IF invleft > 0 AND NOT dying AND NOT endinglevel THEN
            sbplaynote invvoice, 1, invnote(invnote)
            invnote = (invnote + 1) AND 3
          END IF
          invnoted = invnotelength
        END IF
        invnotes = NOT invnotes
      END IF

      'drop bomb

      IF NOT dying AND NOT endinglevel THEN
        IF numbombs < maxbombs AND RND * 100 > bombchance THEN
          obstructed = false
          FOR i = inv - 11 TO 1 STEP -11
            IF invs(i) THEN
              obstructed = true
              i = 1
            END IF
          NEXT
          IF NOT obstructed THEN
            i = 1
            WHILE bombs(i)
              i = i + 1
            WEND
            bombx(i) = invx(inv) + 5
            bomby(i) = invy(inv) + 8
            bombs(i) = true
            IF RND * 100 > 85 THEN
              bombtype(i) = 1
              ELSE
              bombtype(i) = 0
            END IF
            numbombs = numbombs + 1
          END IF
        END IF
      END IF

      'move bombs

      FOR i = 1 TO maxbombs
        IF bombs(i) THEN
          LINE (bombx(i), bomby(i))-STEP(2, 4), crtcolour, BF
          IF bombtype(i) = 0 THEN
            bomby(i) = bomby(i) + 1
            ELSE
            bomby(i) = bomby(i) + 2
          END IF
          a = POINT(bombx(i), bomby(i) + 5)
          b = POINT(bombx(i) + 2, bomby(i) + 5)
          IF bomby(i) > 194 THEN
            bombs(i) = false
            numbombs = numbombs - 1
            ELSEIF a = sheltercolour OR b = sheltercolour THEN
            ErodeShelter bombx(i), bomby(i) + 7
            bombs(i) = false
            numbombs = numbombs - 1
            ELSEIF a = shipcolour OR b = shipcolour THEN
            bombs(i) = false
            numbombs = numbombs - 1
            DisplayLife lives, false
            LINE (shipx, shipy)-STEP(shipwidth - 1, shipheight - 1), crtcolour, BF
            sbvoiceoff invvoice
            dying = true
            deathroes = 0
            ELSE
            PUT (bombx(i), bomby(i)), invbombg(bombtype(i) * invbombgsize), PSET
          END IF
        END IF
      NEXT

      'launch saucer

      IF NOT saucers AND NOT saucerdying THEN
        IF saucercycles = 25 * 70 AND invleft > 9 THEN
          IF RND > .5 THEN
            saucerx = screenorgx
            saucerdx = 1
            ELSE
            saucerx = screenorgx + screenwidth - saucerwidth
            saucerdx = -1
          END IF
          saucernote = &H202
          saucerd = 1
          saucers = true
          saucercount = saucercount + 1
        END IF
      END IF

      'move saucer

      IF saucers THEN
        saucerd = saucerd - 1
        IF saucerd = 0 THEN
          LINE (saucerx, saucery)-STEP(saucerwidth - 1, saucerheight - 1), crtcolour, BF
          saucerx = saucerx + saucerdx
          IF saucerx > screenorgx + screenwidth - saucerwidth OR saucerx < screenorgx THEN
            sbvoiceoff saucervoice
            saucers = false
            saucercycles = 0
            ELSE
            PUT (saucerx, saucery), saucerg(0), PSET
            saucernote = saucernote - 15
            IF saucernote < &H1B0 THEN
              saucernote = &H202
            END IF
            sbplaynote saucervoice, 5, saucernote
            saucerd = 2
          END IF
        END IF
      END IF

      'explode saucer

      IF saucerdying THEN
        saucerdeathroes = saucerdeathroes - 1
        IF saucerdeathroes = 0 THEN
          LINE (saucerx, saucery)-STEP(3 * 8, 1 * 9), crtcolour, BF
          sbvoiceoff saucervoice
          saucercycles = 0
          saucerdying = false
          ELSE
          saucernote = saucernote + 4
          IF saucernote > &H202 THEN
            saucernote = &H1B0
          END IF
          sbplaynote saucervoice, 4, saucernote
        END IF
      END IF

      'move player and fire bullet

      IF NOT dying THEN
        k = PEEK(&H417)
        LINE (shipx, shipy)-STEP(14, 7), crtcolour, BF
        IF (k AND 4) AND shipx > shipminx THEN shipx = shipx - 1
        IF (k AND 8) AND shipx < shipmaxx THEN shipx = shipx + 1
        PUT (shipx, shipy), shipg, PSET
        IF canfire AND (k AND 1) AND (bullets = false) AND (invzapticks = 0) THEN
          bulletx = shipx + 7
          bullety = shipy - bulletheight
          bulletsound = true
          bulletsoundd = 10
          bullets = true
          shots = shots + 1
        END IF
        canfire = (bullets = false) AND (invzapticks = 0) AND (k AND 1) = 0
      END IF

      'move bullet

      IF bullets THEN
        LINE (bulletx, bullety)-STEP(0, bulletheight), crtcolour
        bullety = bullety - bulletd
        IF bulletsound THEN
          bulletsoundd = bulletsoundd - 1
          IF bulletsoundd = 0 THEN
            sbvoiceoff bulletvoice
            bulletsound = false
            ELSE
            sbplaynote bulletvoice, 5, RND * 255 + 256
          END IF
        END IF
        IF bullety < saucery THEN
          bullets = false
          ELSE
          a = POINT(bulletx, bullety)
          b = POINT(bulletx, bullety + 2)
          IF (a > 0 AND a < 111) OR (b > 0 AND b < 111) THEN
            bulletsound = false
            sbvoiceoff bulletvoice
            IF a = crtcolour THEN a = b
            a = (a - 1) \ 2 + 1
            invs(a) = false
            invleft = invleft - 1
            invzapx = invx(a)
            invzapy = invy(a)
            LINE (invzapx, invzapy)-STEP(invwidth - 1, invheight - 1), crtcolour, BF
            IF invzapy < sheltery - invheight THEN
              PUT (invzapx, invzapy), invexpg(0), PSET
              ELSEIF invzapy < sheltery THEN
              PUT (invzapx, invzapy), invexpg(invgsize), PSET
              ELSE
              PUT (invzapx, invzapy), invexpg(2 * invgsize), PSET
            END IF
            invzapticks = invzaptime
            IF invleft > 11 THEN
              invnotelength = 12
              ELSEIF invleft > 0 THEN
              invnotelength = VAL("&H" + MID$("6778899AABB", invleft, 1))
              ELSE
              sbvoiceoff invvoice
            END IF
            SELECT CASE a
              CASE 1 TO 22
              IncScore 10
              CASE 23 TO 44
              IncScore 20
              CASE ELSE
              IncScore 30
            END SELECT
            bullets = false
            ELSEIF a = sheltercolour THEN
            ErodeShelter bulletx, bullety
            bulletsound = false
            sbvoiceoff bulletvoice
            bullets = false
            ELSEIF a = saucercolour OR b = saucercolour THEN
            LINE (saucerx, saucery)-STEP(saucerwidth - 1, saucerheight - 1), crtcolour, BF
            IF (shots = 23 AND saucercount = 1) OR (shots = 15 AND saucercount >= 2) THEN
              saucerscore = 300
              ELSE
              saucerscore = INT(RND * 3 + 1) * 50
            END IF
            Display saucerx - screenorgx, saucery, MID$(STR$(saucerscore), 2)
            IncScore saucerscore
            saucers = false
            saucerdying = true
            saucerdeathroes = 120
            saucernote = &H1B0
            bullets = false
            shots = 0
            ELSE
            LINE (bulletx, bullety)-STEP(0, bulletheight), bulletcolour
          END IF
        END IF
      END IF

      'explode ship

      IF dying THEN
        deathroes = deathroes + 1
        IF deathroes < 130 OR numbombs > 0 THEN
          LINE (shipx, shipy)-STEP(shipwidth - 1, shipheight - 1), crtcolour, BF
          PUT (shipx, shipy), shipexpg((deathroes AND 4) / 4 * shipgsize), PSET
          sbplaynote shipexpvoice, 1, RND * 255 + &H100
          ELSE
          sbvoiceoff shipexpvoice
          sbvoiceoff saucervoice
          LINE (shipx, shipy)-STEP(shipwidth - 1, shipheight - 1), crtcolour, BF
          dying = false
          lives = lives - 1
          IF lives = 0 THEN
            sbvoiceoff invvoice
            gameover = true
            ELSE
            shipx = shipminx
            shipy = 199 - shipheight * 2
            Delay 1
          END IF
        END IF
      END IF

      'count down exploding invader

      IF invzapticks THEN
        invzapticks = invzapticks - 1
        sbplaynote invzapvoice, 6, &H280 + invzapticks * 40
        IF invzapticks = 0 THEN
          sbvoiceoff invzapvoice
          LINE (invzapx, invzapy)-STEP(invwidth - 1, invheight - 1), crtcolour, BF
          IF invleft = 0 THEN
            endinglevel = true
            endingleveld = 0
          END IF
        END IF
      END IF

      'counting down at end of level

      IF endinglevel THEN
        endingleveld = endingleveld + 1
        IF endingleveld > 200 AND numbombs = 0 AND NOT bullets AND dying = false THEN
          LINE (shipx, shipy)-STEP(shipwidth - 1, shipheight - 1), crtcolour, BF
          endinglevel = false
          endlevel = true
        END IF
      END IF

      IF speedtest THEN
        SetColour 0, 0, 0, 0
      END IF

      key$ = INKEY$
      switchoff = (key$ = CHR$(27))
      IF key$ = "=" THEN
        speedtest = NOT speedtest
      END IF
      saucercycles = saucercycles + 1

    WEND '(cycle)

    IF gameover THEN
      a$ = "GAME OVER"
      FOR i = 1 TO LEN(a$)
        Display 10 * 8 + i * 8, 4 * 9, MID$(a$, i, 1)
        Delay .15
      NEXT
      Delay 3
    END IF

    IF endlevel THEN
      DrawPlanet true
      DrawShelters false
      Delay .9
      level = level + 1
      IF level > 6 THEN
        level = 6
      END IF
      endlevel = false
    END IF

  WEND '(level)

WEND '(game/attract)

FOR i = 1 TO 5
  sbvoiceoff i
NEXT
sbresetcard

SYSTEM


DATA "       #       "
DATA "      ###      "
DATA "      ###      "
DATA " ############# "
DATA "###############"
DATA "###############"
DATA "###############"
DATA "###############"

DATA "    #          "
DATA "  #     #    # "
DATA "    #  #  #    "
DATA "  #      # #   "
DATA "     # ##   #  "
DATA "#  ########    "
DATA "  ##########   "
DATA " ############  "

DATA " #     #    #  "
DATA "    #          "
DATA "  #    #    #  "
DATA "      #   #    "
DATA " #   ## #     #"
DATA "    ######  #  "
DATA "   ########    "
DATA " ############  "

DATA "    ####    "
DATA " ########## "
DATA "############"
DATA "###  ##  ###"
DATA "############"
DATA "   ##  ##   "
DATA "  ## ## ##  "
DATA "##        ##"

DATA "    ####    "
DATA " ########## "
DATA "############"
DATA "###  ##  ###"
DATA "############"
DATA "  ###  ###  "
DATA " ##  ##  ## "
DATA "  ##    ##  "

DATA "  #     #   "
DATA "#  #   #  # "
DATA "# ####### # "
DATA "### ### ### "
DATA "########### "
DATA " #########  "
DATA "  #     #   "
DATA " #       #  "

DATA "  #     #   "
DATA "   #   #    "
DATA "  #######   "
DATA " ## ### ##  "
DATA "########### "
DATA "# ####### # "
DATA "# #     # # "
DATA "   ## ##    "

DATA "     ##     "
DATA "    ####    "
DATA "   ######   "
DATA "  ## ## ##  "
DATA "  ########  "
DATA "    #  #    "
DATA "   # ## #   "
DATA "  # #  # #  "

DATA "     ##     "
DATA "    ####    "
DATA "   ######   "
DATA "  ## ## ##  "
DATA "  ########  "
DATA "   # ## #   "
DATA "  #      #  "
DATA "   #    #   "

DATA "     #  #   "
DATA "  #  #  #  #"
DATA "   #   #  # "
DATA "###         "
DATA "    #     ##"
DATA "  ##    #   "
DATA " #    #  #  "
DATA "      #   # "

DATA " # "
DATA " # "
DATA " # "
DATA "###"
DATA " # "

DATA " # "
DATA "#  "
DATA " # "
DATA "  #"
DATA " # "

DATA "     ######     "
DATA "   ##########   "
DATA "  ############  "
DATA " ## ## ## ## ## "
DATA "################"
DATA "  ###  ##  ###  "
DATA "   #        #   "


DATA "    ################    "
DATA "   ##################   "
DATA "  ####################  "
DATA " ###################### "
DATA "########################"
DATA "########################"
DATA "########################"
DATA "########################"
DATA "########################"
DATA "########################"
DATA "########################"
DATA "########################"
DATA "#######          #######"
DATA "######            ######"
DATA "#####              #####"
DATA "#####              #####"

DATA A
DATA "  #  "
DATA " # # "
DATA "#   #"
DATA "#####"
DATA "#   #"
DATA "#   #"
DATA "#   #"

DATA C
DATA " ### "
DATA "#   #"
DATA "#    "
DATA "#    "
DATA "#    "
DATA "#   #"
DATA " ### "

DATA E
DATA "#####"
DATA "#    "
DATA "#    "
DATA "#### "
DATA "#    "
DATA "#    "
DATA "#####"

DATA G
DATA " ### "
DATA "#   #"
DATA "#    "
DATA "# ###"
DATA "#   #"
DATA "#   #"
DATA " ### "

DATA I
DATA " ### "
DATA "  #  "
DATA "  #  "
DATA "  #  "
DATA "  #  "
DATA "  #  "
DATA " ### "

DATA L
DATA "#    "
DATA "#    "
DATA "#    "
DATA "#    "
DATA "#    "
DATA "#    "
DATA "#####"

DATA M
DATA "#   #"
DATA "## ##"
DATA "# # #"
DATA "# # #"
DATA "#   #"
DATA "#   #"
DATA "#   #"

DATA O
DATA " ### "
DATA "#   #"
DATA "#   #"
DATA "#   #"
DATA "#   #"
DATA "#   #"
DATA " ### "

DATA R
DATA "#### "
DATA "#   #"
DATA "#   #"
DATA "#### "
DATA "# #  "
DATA "#  # "
DATA "#   #"

DATA S
DATA " ### "
DATA "#   #"
DATA "#    "
DATA " ### "
DATA "    #"
DATA "#   #"
DATA " ### "

DATA V
DATA "#   #"
DATA "#   #"
DATA "#   #"
DATA "#   #"
DATA "#   #"
DATA " # # "
DATA "  #  "

DATA 0
DATA " ### "
DATA "#   #"
DATA "#  ##"
DATA "# # #"
DATA "##  #"
DATA "#   #"
DATA " ### "

DATA 1
DATA "  #  "
DATA " ##  "
DATA "  #  "
DATA "  #  "
DATA "  #  "
DATA "  #  "
DATA " ### "

DATA 2
DATA " ### "
DATA "#   #"
DATA "    #"
DATA " ### "
DATA "#    "
DATA "#    "
DATA "#####"

DATA 3
DATA " ### "
DATA "#   #"
DATA "    #"
DATA "  ## "
DATA "    #"
DATA "#   #"
DATA " ### "

DATA 4
DATA "#    "
DATA "#    "
DATA "#  # "
DATA "#####"
DATA "   # "
DATA "   # "
DATA "   # "

DATA 5
DATA "#####"
DATA "#    "
DATA "#### "
DATA "    #"
DATA "    #"
DATA "#   #"
DATA " ### "

DATA 6
DATA " ### "
DATA "#   #"
DATA "#    "
DATA "#### "
DATA "#   #"
DATA "#   #"
DATA " ### "

DATA 7
DATA "#####"
DATA "    #"
DATA "   # "
DATA "  #  "
DATA " #   "
DATA " #   "
DATA " #   "

DATA 8
DATA " ### "
DATA "#   #"
DATA "#   #"
DATA " ### "
DATA "#   #"
DATA "#   #"
DATA " ### "

DATA 9
DATA " ### "
DATA "#   #"
DATA "#   #"
DATA " ####"
DATA "    #"
DATA "#   #"
DATA " ### "

FUNCTION ArrayBytes (x, y)

ArrayBytes = 4 + INT(((PMAP(x, 0) - PMAP(0, 0) + 1) * 8 + 7) / 8) * (PMAP(y, 1) - PMAP(0, 1) + 1)

END FUNCTION

SUB ClearScreen

SHARED screenwidth, screenorgx, crtcolour

LINE (0, 0)-(319, 199), 0, BF
LINE (screenorgx, 0)-STEP(screenwidth, 199), crtcolour, BF

END SUB

SUB ClearScreenToCRT

SHARED crtcolour

LINE (0, 0)-(319, 199), crtcolour, BF

END SUB

SUB DefineGraphics

SHARED shipwidth, shipheight, shipgsize, shipg(), shipexpg()
SHARED invwidth, invheight, invgsize, invg(), invg2()
SHARED invexpg(), invbombheight, invbombgsize, invbombg()
SHARED saucerwidth, saucerheight, saucerg()
SHARED shelterwidth, shelterheight, shelterg()
SHARED chargsize, charset()

SHARED shipcolour, bulletcolour, bombcolour, shipexplodecolour
SHARED sheltercolour, textcolour, invexplodewhitecolour
SHARED invexplodegreencolour, saucercolour, crtcolour

'define ship

ClearScreenToCRT
FOR y = 1 TO shipheight
  READ a$
  FOR x = 1 TO shipwidth
    IF MID$(a$, x, 1) = "#" THEN PSET (x, y), shipcolour
  NEXT
NEXT
GET (1, 1)-STEP(shipwidth - 1, shipheight - 1), shipg(0)

'define ship explosion

FOR i = 1 TO 2
  LINE (1, 1)-STEP(shipwidth - 1, shipheight - 1), crtcolour, BF
  FOR y = 1 TO shipheight
    READ a$
    FOR x = 1 TO shipwidth
      IF MID$(a$, x, 1) = "#" THEN PSET (x, y), shipexplodecolour
    NEXT
  NEXT
  GET (1, 1)-STEP(shipwidth - 1, shipheight - 1), shipexpg((i - 1) * shipgsize)
NEXT

'define invaders

ClearScreenToCRT
FOR invtype = 0 TO 2
  FOR anim = 0 TO 1
    LINE (1, 1)-STEP(invwidth - 1, invheight - 1), crtcolour, BF
    FOR y = 1 TO invheight
      READ a$
      FOR x = 1 TO invwidth
        IF MID$(a$, x, 1) = "#" THEN PSET (x, y), 255
      NEXT
    NEXT
    IF invtype = 2 THEN rows = 1 ELSE rows = 2
    FOR inv = invtype * 22 TO invtype * 22 + rows * 11 - 1
      arraypointer = inv * invgsize * 4 + anim * invgsize * 2
      invcolour = inv * 2 + 1
      SetColour invcolour, 63, 63, 63
      SetColour invcolour + 1, 0, 63, 0
      FOR y = 1 TO invheight
        FOR x = 1 TO invwidth
          IF POINT(x, y) <> crtcolour THEN PSET (x, y), invcolour
        NEXT
      NEXT
      GET (1, 1)-STEP(invwidth - 1, invheight - 1), invg(arraypointer)
      FOR y = 5 TO invheight
        FOR x = 1 TO invwidth
          IF POINT(x, y) <> crtcolour THEN PSET (x, y), invcolour + 1
        NEXT
      NEXT
      GET (1, 1)-STEP(invwidth - 1, invheight - 1), invg(arraypointer + invgsize)
      FOR y = 1 TO 4
        FOR x = 1 TO invwidth
          IF POINT(x, y) <> crtcolour THEN PSET (x, y), invcolour + 1
        NEXT
      NEXT
      GET (1, 1)-STEP(invwidth - 1, invheight - 1), invg2(arraypointer)
    NEXT
  NEXT
NEXT

'define invader explosion

ClearScreenToCRT
FOR y = 1 TO invheight
  READ a$
  FOR x = 1 TO invwidth
    IF MID$(a$, x, 1) = "#" THEN PSET (x, y), invexplodewhitecolour
  NEXT
NEXT
GET (1, 1)-STEP(invwidth - 1, invheight - 1), invexpg(0)
FOR y = 5 TO invheight
  FOR x = 1 TO invwidth
    IF POINT(x, y) <> crtcolour THEN PSET (x, y), invexplodegreencolour
  NEXT
NEXT
GET (1, 1)-STEP(invwidth - 1, invheight - 1), invexpg(invgsize)
FOR y = 1 TO 4
  FOR x = 1 TO invwidth
    IF POINT(x, y) <> crtcolour THEN PSET (x, y), invexplodegreencolour
  NEXT
NEXT
GET (1, 1)-STEP(invwidth - 1, invheight - 1), invexpg(2 * invgsize)

'define bombs

ClearScreenToCRT
FOR i = 1 TO 2
  FOR y = 1 TO invbombheight
    READ a$
    FOR x = 1 TO 3
      IF MID$(a$, x, 1) = "#" THEN PSET (x, y), bombcolour
    NEXT
  NEXT
  GET (1, 1)-STEP(2, invbombheight - 1), invbombg((i - 1) * invbombgsize)
  ClearScreenToCRT
NEXT

'define saucer

ClearScreenToCRT
FOR y = 1 TO saucerheight
  READ a$
  FOR x = 1 TO saucerwidth
    IF MID$(a$, x, 1) = "#" THEN PSET (x, y), saucercolour
  NEXT
NEXT
GET (1, 1)-STEP(saucerwidth, saucerheight), saucerg(0)

'define shelter

ClearScreenToCRT
FOR y = 1 TO shelterheight
  READ a$
  FOR x = 1 TO shelterwidth
    IF MID$(a$, x, 1) = "#" THEN PSET (x, y), sheltercolour
  NEXT
NEXT
GET (1, 1)-STEP(shelterwidth - 1, shelterheight - 1), shelterg(0)

'define character set

ClearScreenToCRT
FOR i = 1 TO 21
  READ a$
  a = ASC(a$)
  FOR y = 1 TO 7
    READ a$
    FOR x = 1 TO 5
      IF MID$(a$, x, 1) = "#" THEN PSET (x, y), textcolour
    NEXT
  NEXT
  GET (1, 1)-STEP(4, 7), charset((a - 48) * chargsize)
  LINE (1, 1)-STEP(4, 7), crtcolour, BF
NEXT

ClearScreenToCRT

END SUB

SUB Delay (seconds!)

SHARED true, switchoff

t# = TIMER
DO
  IF INKEY$ = CHR$(27) THEN
    switchoff = true
  END IF
LOOP UNTIL TIMER > t# + seconds! OR switchoff

END SUB

SUB Display (x, y, a$)

SHARED screenorgx, chargsize, charset(), crtcolour

FOR i = 1 TO LEN(a$)
  LINE (screenorgx + x + (i - 1) * 8, y)-STEP(5, 7), crtcolour, BF
  a = ASC(MID$(a$, i))
  IF a <> 32 THEN
    PUT (screenorgx + x + (i - 1) * 8, y), charset((a - 48) * chargsize), PSET
  END IF
NEXT

END SUB

SUB DisplayLife (life, visible)

SHARED screenorgx, shipwidth, shipheight, shipg(), crtcolour

IF visible THEN
  PUT (screenorgx + 16 * 8 + (life - 1) * shipwidth * 1.5, 1.5 * 8), shipg(0), PSET
  ELSE
  LINE (screenorgx + 16 * 8 + (life - 1) * shipwidth * 1.5, 1.5 * 8)-STEP(shipwidth, shipheight), crtcolour, BF
END IF

END SUB

SUB DisplayScore

SHARED score

Display 0, 1 * 9, RIGHT$("000" + MID$(STR$(score), 2), 4)

END SUB

SUB DrawPlanet (visible)

SHARED screenwidth, screenorgx, planetcolour, crtcolour

IF visible THEN
  LINE (screenorgx, 199)-STEP(screenwidth - 1, 0), planetcolour
  ELSE
  LINE (screenorgx, 199)-STEP(screenwidth - 1, 0), crtcolour
END IF

END SUB

SUB DrawShelters (visible)

SHARED shipwidth, sheltery, shelterwidth, shelterheight, shelterg()
SHARED shipminx, shipmaxx, crtcolour

shelterspace = (shipmaxx + shipwidth - shipwidth * .9) - (shipminx + shipwidth * .9)
xstep = (shelterspace - 4 * shelterwidth) / 3 + shelterwidth

FOR i = 0 TO 3
  x = shipminx + shipwidth * .9 + i * xstep
  IF visible THEN
    PUT (x, sheltery), shelterg(0), PSET
    ELSE
    LINE (x, sheltery)-STEP(shelterwidth - 1, shelterheight - 1), crtcolour, BF
  END IF
NEXT

END SUB

SUB ErodeShelter (x, y)

SHARED damagex(), damagey(), damagecounter, crtcolour

FOR i = 1 TO 35
  PSET (x + damagex(damagecounter + i) - 2, y + damagey(damagecounter + i + 1) - 4), crtcolour
NEXT
damagecounter = damagecounter + 20
IF damagecounter > 255 - i THEN
  damagecounter = 0
END IF

END SUB

SUB IncScore (scoregain)

SHARED true, score, lives

score = score + scoregain
IF score >= 1000 AND score < 1000 + scoregain THEN
  lives = lives + 1
  DisplayLife lives, true
END IF

DisplayScore

END SUB

SUB sbmodulate (voice, volume)

sbwritereg &H40 + sbvoicetoreg(voice), &H3F - volume

END SUB

SUB sbplaynote (voice, octave, note)

sbwritereg &HA0 - 1 + voice, note AND 255
sbwritereg &HB0 - 1 + voice, &H20 OR (octave * 4) OR ((note AND &H300) / 256)

END SUB

SUB sbresetcard

FOR i = 1 TO &HF5
  sbwritereg i, 0
NEXT

END SUB

SUB sbsetupvoice (voice)

'Sets up one voice.

'Modulator volume  = silent
'Modulator attack  = fastest
'Modulator decay   = slowest
'Modulator sustain = medium
'Modulator release = medium
'Tone volume       = loudest
'Tone attack       = fastest
'Tone decay        = slowest
'Tone sustain      = medium
'Tone release      = medium

sbwritereg &H20 + sbvoicetoreg(voice), &H1
sbwritereg &H40 + sbvoicetoreg(voice), &H3F
sbwritereg &H60 + sbvoicetoreg(voice), &HF0
sbwritereg &H80 + sbvoicetoreg(voice), &H77
sbwritereg &H23 + sbvoicetoreg(voice), &H1
sbwritereg &H43 + sbvoicetoreg(voice), &H0
sbwritereg &H63 + sbvoicetoreg(voice), &HF0
sbwritereg &H83 + sbvoicetoreg(voice), &H77

END SUB

SUB sbvoiceoff (voice)

sbwritereg &HB0 - 1 + voice, 0

END SUB

FUNCTION sbvoicetoreg (voice)

IF voice <= 3 THEN
  offset = -1
  ELSEIF voice <= 6 THEN
  offset = 4
  ELSE
  offset = 9
END IF

sbvoicetoreg = voice + offset

END FUNCTION

SUB sbvolume (voice, volume)

sbwritereg &H43 + sbvoicetoreg(voice), &H3F - volume

END SUB

SUB sbwritereg (register, byte)

OUT &H388, register
FOR i = 1 TO 6
  a = INP(&H388)
NEXT
OUT &H389, byte
FOR i = 1 TO 35
  a = INP(&H388)
NEXT

END SUB

SUB SetColour (colour, r, g, b)

OUT &H3C6, &HFF
OUT &H3C8, colour
OUT &H3C9, r
OUT &H3C9, g
OUT &H3C9, b

END SUB

