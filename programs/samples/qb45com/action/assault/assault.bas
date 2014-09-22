CHDIR ".\programs\samples\qb45com\action\assault"

'Assault v2
'By Glenn Powell
'( powell98@pacbell.net )
'(c) 1999

'General Procedure Definitions
DECLARE FUNCTION KeyName$ (k$)
DECLARE FUNCTION KeyMark% (k$)
DECLARE FUNCTION TPoint% (tx%, ty%, pn%)
DECLARE FUNCTION BPoint% (tx%, ty%, pn%)
DECLARE FUNCTION TurfHit% (tb%, tx%, ty%)
DECLARE FUNCTION TurfBump$ (tx%, ty%, pn%)
DECLARE SUB TPset (tx%, ty%, tp%)
DECLARE SUB InitGame ()
DECLARE SUB Title ()
DECLARE SUB LoadCfg (file$)
DECLARE SUB LoadKey (file$)
DECLARE SUB InitScr ()
DECLARE SUB InitGamePal ()
DECLARE SUB SetBlastPal ()
DECLARE SUB LoadSprites (file$)
DECLARE SUB DrawPlayer (pn%)
DECLARE SUB ErasePlayer (pn%)
DECLARE SUB DrawSpr (x%, y%, sn%)
DECLARE SUB EraseSpr (x%, y%, sn%)
DECLARE SUB InitBullet (c%, x%, y%, a#, d%, p%, s%)
DECLARE SUB DrawBar ()
DECLARE SUB DrawHealth (pn%, c%)
DECLARE SUB DrawSmallNum (x%, y%, n%, c%)
DECLARE SUB LoadLevel (file$)
DECLARE SUB BuildLevel ()
DECLARE SUB FadePal (fr%, fg%, fb%, i%, c1%, c2%)
DECLARE SUB DefaultPal ()
DECLARE SUB Intro ()
DECLARE SUB Configure ()
DECLARE SUB Menu (mnum%)
DECLARE SUB InitPlayers ()
DECLARE SUB EarthQuake (x%)
DECLARE SUB Damage (pn%, dam%)
DECLARE SUB Win (pnum%)
DECLARE SUB Configure ()
DECLARE SUB Main ()
DECLARE SUB PlayerFall ()
DECLARE SUB PlayerKey ()
DECLARE SUB BulletMove ()
DECLARE SUB DoneTurn ()
DECLARE SUB Pause ()

'Font Procedure Definitions
DECLARE SUB Font (text$, xstart%, ystart%, xscale!, yscale!, style%, tclr%)
DECLARE SUB LoadFont (file$)

'Audio Procedure Definitions
DECLARE FUNCTION DSPRead% ()
DECLARE FUNCTION SpeakerStatus% ()
DECLARE FUNCTION DMAStatus% ()
DECLARE FUNCTION DMADone% ()
DECLARE FUNCTION DSPReset% ()
DECLARE SUB MasterVolume (Right%, Left%, GetVol%)
DECLARE SUB DSPWrite (byte%)
DECLARE FUNCTION ReadDSP% ()
DECLARE SUB SpeakerState (state%)
DECLARE SUB DMAState (state%)
DECLARE FUNCTION ReadDAC% ()
DECLARE SUB DMAPlay (segment&, offset&, length&, freq&)
DECLARE SUB GetBlaster (dma%, baseport%, irq%)
DECLARE FUNCTION DSPVersion! ()
DECLARE SUB WAVPlay (file$, freq&)

'Type Definitions
TYPE gametype
 cfgfile AS STRING * 12
 keyfile AS STRING * 12
 fntfile AS STRING * 12
 sprfile AS STRING * 12
END TYPE
TYPE packtype
 ammo AS INTEGER
 set AS INTEGER
END TYPE
TYPE bullettype
 class AS INTEGER
 xi AS INTEGER
 yi AS INTEGER
 x AS INTEGER
 y AS INTEGER
 a AS DOUBLE
 dir AS INTEGER
 p AS INTEGER
 tim AS DOUBLE
 set AS INTEGER
END TYPE
TYPE teamtype
 nam AS STRING * 11
 act AS INTEGER
 clr AS INTEGER
END TYPE
TYPE playertype
 nam AS STRING * 10
 tnum AS INTEGER
 xi AS INTEGER
 yi AS INTEGER
 x AS INTEGER
 y AS INTEGER
 a AS DOUBLE
 bul AS INTEGER
 dir AS INTEGER
 health AS INTEGER
 dam AS INTEGER
 jump AS INTEGER
 aj AS SINGLE
 pj AS INTEGER
 tim AS DOUBLE
 glued AS DOUBLE
END TYPE
TYPE leveltype
 nam AS STRING * 10
 turn AS INTEGER
 wind AS INTEGER
 jag AS INTEGER
 rise AS SINGLE
 grav AS SINGLE
 sndb AS STRING * 12
 nofly AS INTEGER
 fire AS INTEGER
 tim AS DOUBLE
 quit AS INTEGER
END TYPE
TYPE paltype
 r AS INTEGER
 g AS INTEGER
 B AS INTEGER
END TYPE
TYPE polartype
 r AS SINGLE
 a AS SINGLE
END TYPE
TYPE configtype
 snd AS INTEGER
 sndb AS INTEGER
 ammodrop AS SINGLE
END TYPE

'Global Variable Definitions
COMMON SHARED baseport%, lenport%, channel%
CONST pi# = 3.1415, bulletspd% = 2, maxpower% = 150, maxplayers% = 8
CONST menuclr% = 17, maxweapons% = 7, maxsparks% = 60, maxbullets% = 10
CONST playerstep% = 4, playeraim! = .1, playeraimsize% = 20, gunlen% = 3
DIM SHARED player(maxplayers%) AS playertype, level AS leveltype, bullet(1 TO maxbullets%) AS bullettype
DIM SHARED turfbuf(32001) AS INTEGER, backbuf(32001) AS INTEGER, playerspr(7 + 8 * 7) AS INTEGER
DIM SHARED ammospr(0 TO maxweapons%, 7 + 8 * 7) AS INTEGER, team(maxplayers%) AS teamtype
DIM SHARED config AS configtype, playpack(maxplayers%, 1 TO maxweapons%) AS packtype, spark(1 TO maxsparks%) AS polartype
DIM SHARED smallnum(9, 2 + 3 * 4) AS INTEGER, barbuf(2561) AS INTEGER, pal(1 TO 3) AS paltype
DIM SHARED keycode(1 TO 11 + maxweapons%) AS STRING, keyact(1 TO 11 + maxweapons%) AS STRING
DIM SHARED fontbuf(0) AS STRING * 10368, menuitem(10) AS STRING, game AS gametype
DIM SHARED gamepal(0 TO 255) AS paltype, defpal(0 TO 255) AS paltype

'Set Game Data Files
game.cfgfile = "assault.cfg"
game.keyfile = "assault.key"
game.fntfile = "assault.fnt"
game.sprfile = "assault.spr"

'Initialize Game
InitGame
InitScr
IF config.snd THEN
 GetBlaster channel%, baseport%, irq%
 IF DSPReset% THEN
  SpeakerState 1
  MasterVolume config.snd, config.snd, 0
 ELSE
  PRINT "DSP failed to reset."
  PRINT "Sound disabled."
  config.snd = 0
 END IF
END IF
Title

mainmenu:
pal(1).r = 10
pal(1).g = 10
pal(1).B = 10
DefaultPal
SetBlastPal
FadePal 0, 0, 0, 100, 200, 220
FadePal 0, 0, 0, 0, 0, 31
menuitem(0) = "ASSAULT"
menuitem(1) = "Play"
menuitem(2) = "Play Custom"
menuitem(3) = "Configure"
menuitem(4) = "Quit"
mnum% = 4
Menu mnum%
SELECT CASE mnum%
 CASE 1
  menuitem(0) = "ENVIRONMENT"
  menuitem(1) = "Jungle"
  menuitem(2) = "Arctic"
  menuitem(3) = "Plains"
  menuitem(4) = "Volcano"
  menuitem(5) = "Moon"
  mnum% = 5
  Menu mnum%
  SELECT CASE mnum%
   CASE -1
    GOTO mainmenu
   CASE 1
    level.nam = "Jungle"
    pal(1).r = 20
    pal(1).g = 10
    pal(1).B = 0
    pal(2).r = 10
    pal(2).g = 25
    pal(2).B = 0
    pal(3).r = 20
    pal(3).g = 10
    pal(3).B = 0
    level.jag = 4
    level.rise = .8
    level.grav = 1
    level.sndb = "jungle.wav"
   CASE 2
    level.nam = "Arctic"
    pal(1).r = 20
    pal(1).g = 10
    pal(1).B = 20
    pal(2).r = 50
    pal(2).g = 50
    pal(2).B = 60
    pal(3).r = 15
    pal(3).g = 10
    pal(3).B = 0
    level.jag = 5
    level.rise = .5
    level.grav = 1
    level.sndb = "arctic.wav"
   CASE 3
    level.nam = "Plains"
    pal(1).r = 20
    pal(1).g = 20
    pal(1).B = 20
    pal(2).r = 0
    pal(2).g = 30
    pal(2).B = 0
    pal(3).r = 50
    pal(3).g = 50
    pal(3).B = 40
    level.jag = 5
    level.rise = .15
    level.grav = 1
    level.sndb = "plains.wav"
   CASE 4
    level.nam = "Volcano"
    pal(1).r = 30
    pal(1).g = 10
    pal(1).B = 0
    pal(2).r = 40
    pal(2).g = 10
    pal(2).B = 0
    pal(3).r = 5
    pal(3).g = 0
    pal(3).B = 0
    level.jag = 5
    level.rise = .8
    level.grav = 1
    level.sndb = "volcano.wav"
   CASE 5
    level.nam = "Moon"
    pal(1).r = 0
    pal(1).g = 0
    pal(1).B = 0
    pal(2).r = 30
    pal(2).g = 30
    pal(2).B = 30
    pal(3).r = 10
    pal(3).g = 10
    pal(3).B = 10
    level.jag = 3
    level.rise = .3
    level.grav = .3
    level.sndb = "moon.wav"
  END SELECT
  FadePal 0, 0, 0, 0, 0, 255
  InitGamePal
  DEF SEG = VARSEG(backbuf(0))
  BLOAD "backgrnd\" + RTRIM$(level.nam) + ".bck", 0
  DEF SEG
  BuildLevel
  Main
  GOTO mainmenu
 CASE 2
  LINE (0, 30)-(319, 199), 0, BF
  Font "Custom Level", 160 - (LEN("Custom Level") / 2) * 8, 50, 1, 1, 2, menuclr% + 5
  Font "(Enter Cancels)", 160 - (LEN("(Enter Cancels)") / 2) * 8, 65, 1, 1, 2, menuclr% + 5
  FOR c% = 0 TO 100
   FadePal 0, 0, 0, c%, 0, 31
  NEXT c%
  LOCATE 11, 15
  INPUT "", l$
  IF l$ = "" THEN GOTO mainmenu
  pal(1).r = 10
  pal(1).g = 10
  pal(1).B = 10
  FadePal 0, 0, 0, 0, 0, 255
  InitGamePal
  LoadLevel l$ + ".lvl"
  Main
  GOTO mainmenu
 CASE 3
  Configure
  GOTO mainmenu
 CASE 4
  IF config.snd THEN
   SpeakerState 0
   DMAState 0
  END IF
  SYSTEM
 CASE ELSE
  GOTO mainmenu
END SELECT

'Various Game Data
teaminfo:
DATA "None",0
DATA "Red Team",4
DATA "White Team",15
DATA "Blue Team",1
DATA "Yellow Team",14
DATA "Green Team",2
DATA "Brown Team",6
DATA "Purple Team",5
DATA "Black Team",16

'Small Number Data
smallnums:
DATA 0,1,0
DATA 1,0,1
DATA 1,0,1
DATA 1,0,1
DATA 0,1,0

DATA 0,0,1
DATA 0,1,1
DATA 0,0,1
DATA 0,0,1
DATA 0,0,1

DATA 0,1,0
DATA 1,0,1
DATA 0,0,1
DATA 0,1,0
DATA 1,1,1

DATA 1,1,0
DATA 0,0,1
DATA 0,1,0
DATA 0,0,1
DATA 1,1,0

DATA 1,0,1
DATA 1,0,1
DATA 1,1,1
DATA 0,0,1
DATA 0,0,1

DATA 1,1,1
DATA 1,0,0
DATA 1,1,0
DATA 0,0,1
DATA 1,1,0

DATA 0,1,1
DATA 1,0,0
DATA 1,1,0
DATA 1,0,1
DATA 0,1,1

DATA 1,1,1
DATA 0,0,1
DATA 0,1,0
DATA 0,1,0
DATA 0,1,0

DATA 0,1,0
DATA 1,0,1
DATA 0,1,0
DATA 1,0,1
DATA 0,1,0

DATA 0,1,1
DATA 1,0,1
DATA 1,1,1
DATA 0,0,1
DATA 0,0,1

FUNCTION BPoint% (tx%, ty%, pn%)
'Returns the pixel that should be displayed as background behind any
'sprite at any time in the game. (241 represents a pixel of the background image)
'tx% and ty% are the coordinates.
'pn% is the number of player who is being "looked behind" (1-4) or
'0 if it is a bullet sprite and you want to be able to "see" all the players.
'You can also use -1 to not see any players.

pp% = 241
IF tx% >= 0 AND tx% <= 319 THEN
 IF ty% >= 0 AND ty% <= 15 THEN
  DEF SEG = VARSEG(barbuf(0))
  pp% = PEEK(tx% + 320& * ty% + 4)
  DEF SEG
 ELSEIF ty% >= 16 AND ty% <= 199 THEN
  DEF SEG = VARSEG(turfbuf(0))
  pp% = PEEK(tx% + 320& * ty% + 4)
  DEF SEG
 END IF
 FOR i% = 1 TO maxplayers%
  IF player(i%).health > 0 AND pn% <> i% THEN
   IF tx% >= player(i%).x AND tx% <= player(i%).x + 7 AND ty% >= player(i%).y AND ty% <= player(i%).y + 7 THEN
    pp% = playerspr((player(i%).dir - 1) * -3.5 + player(i%).dir * (tx% - player(i%).x) + 8 * (ty% - player(i%).y))
    IF pp% = -1 THEN
     pp% = team(player(i%).tnum).clr
    ELSEIF pp% = -10 THEN
     IF player(i%).dir = 1 THEN
      pp% = 25 - INT((tx% - player(i%).x) / 2)
     ELSE
      pp% = 25 - INT((7 - (tx% - player(i%).x)) / 2)
     END IF
    END IF
    IF pp% > 0 THEN
     IF player(i%).glued > 0 THEN pp% = 92
    ELSE
     pp% = 241
    END IF
    FOR ii% = 0 TO gunlen%
     x% = player(i%).x + 3 + (1 - player(i%).dir) / 2 + COS(player(i%).a) * ii% * player(i%).dir
     y% = player(i%).y + 4 + SIN(player(i%).a) * ii%
     IF tx% = x% AND ty% = y% THEN pp% = 25
    NEXT ii%
   END IF
  END IF
 NEXT i%
 IF ty% >= 0 AND ty% <= 199 THEN
  IF pp% = 241 THEN
   DEF SEG = VARSEG(backbuf(0))
   pp% = PEEK(tx% + 320& * ty%)
   DEF SEG
  END IF
 END IF
END IF
BPoint% = pp%
END FUNCTION

SUB BuildLevel
'Builds the level's turf map.
'It uses the LEVEL variable's data to create the map according to the
'environment chosen. (level.jag and level.rise)

'This is for the environment sprites
DIM backspr(1 TO 2, 29 + 30 * 29) AS INTEGER

'Loads the environment sprites
DEF SEG = &HA000
BLOAD "backgrnd\" + RTRIM$(level.nam) + ".spr", 0
DEF SEG
FOR y% = 0 TO 29
 FOR x% = 0 TO 29
  p% = POINT(x%, y%)
  backspr(1, x% + 30 * y%) = p%
 NEXT x%
NEXT y%
FOR y% = 0 TO 29
 FOR x% = 30 TO 59
  p% = POINT(x%, y%)
  backspr(2, x% - 30 + 30 * y%) = p%
 NEXT x%
NEXT y%

'Draws the terrain outline
CLS
LINE (0, 0)-(319, 199), 240, BF
x1% = 0
y1% = RND * 100 + 30
a# = RND * 2 - 1
buildloop:
x2% = x1%
y2% = y1%
x1% = x2% + COS(a#) * level.jag
y1% = y2% + SIN(a#) * level.jag
LINE (x1%, y1%)-(x2%, y2%), 231
IF y1% <= 30 THEN
 a# = RND * 1
ELSEIF y1% >= 190 THEN
 a# = RND * -1
ELSE
 a# = a# + RND * (level.rise * 2) - level.rise
 IF a# > 3 * pi# / 4 THEN a# = 3 * pi# / 4
 IF a# < 3 * -pi# / 4 THEN a# = 3 * -pi# / 4
END IF
IF x1% >= 319 THEN GOTO paintbuild
GOTO buildloop

'Paints in the terrain outline
paintbuild:
PAINT (0, 0), 241, 231
FOR x% = 0 TO 319
 FOR y% = 0 TO 199
  p% = POINT(x%, y%)
  IF p% = 240 THEN
   p% = POINT(x%, y% - 1) + RND * 3 - 1
   IF p% < 231 THEN p% = 231
   IF p% > 240 THEN p% = 240
   PSET (x%, y%), p%
  END IF
 NEXT y%
NEXT x%

'Places environment sprites
FOR i% = 1 TO 5
 IF RND < .8 THEN
  x% = RND * 280 + 20
  ly% = 0
  FOR y% = 0 TO 199
   FOR xx% = x% - 15 TO x% + 15
    p% = POINT(xx%, y%)
    IF p% = 241 THEN
     IF y% > ly% THEN ly% = y%
    END IF
   NEXT xx%
  NEXT y%
  x% = x% - 15
  y% = ly% - 29
  s% = RND + 1
  d% = CINT(RND) * 2 - 1
  FOR xx% = x% TO x% + 29
   FOR yy% = y% TO y% + 29
    p% = backspr(s%, (d% + 1) / 2 * 29 + -d% * (xx% - x%) + 30 * (yy% - y%))
    bp% = POINT(xx%, yy%)
    IF bp% = 241 AND p% > 0 THEN PSET (xx%, yy%), p%
   NEXT yy%
  NEXT xx%
 END IF
NEXT i%

'Stores in Turf Buffer
GET (0, 0)-(319, 199), turfbuf
END SUB

SUB BulletMove
'Moves any and all bullets that are in action on the playfield.

FOR i% = 1 TO maxbullets%

 'Explosion
 '==========
 'bullet variables:
 'x = x xoordinate
 'y = y xoordinate
 'a = current flame size (set to 0 at initialization)
 'dir = size of final explosion (set this at initialization)
 'p = direction of flame growth (set to 1 at initialization)
 'set = sparks setting (set at initialization)
 '                     0 = no sparks
 '                     1 = sparks
 '                     2 = sparks and nuclear flash
 'tim = flash timer (set to 0 at initialization)
 IF bullet(i%).class = -1 THEN
  level.nofly = 0
  x% = bullet(i%).x
  y% = bullet(i%).y
  IF bullet(i%).p = 1 AND bullet(i%).a = 0 THEN
   FOR pn% = 1 TO maxplayers%
    IF player(pn%).health > 0 THEN
     pd% = SQR((player(pn%).x - x%) ^ 2 + (player(pn%).y - y%) ^ 2)
     IF pd% < bullet(i%).dir + 3 THEN
      ph% = bullet(i%).dir * 2 * (1 - pd% / (bullet(i%).dir + 3))
      Damage pn%, ph%
     END IF
     IF pd% < bullet(i%).dir + 13 THEN
      ErasePlayer pn%
      player(pn%).jump = 1
      player(pn%).xi = player(pn%).x
      player(pn%).yi = player(pn%).y
      IF player(pn%).x - x% <> 0 THEN
       pa# = ATN((player(pn%).y - y%) / ABS(player(pn%).x - x%))
      ELSE
       pa# = 40
      END IF
      player(pn%).aj = pa#
      pp% = 40 * (1 - pd% / (bullet(i%).dir + 13))
      player(pn%).pj = pp%
      IF player(pn%).x > x% THEN
       player(pn%).dir = 1
      ELSE
       player(pn%).dir = -1
      END IF
      player(pn%).tim = TIMER - .1
      t# = (TIMER - player(pn%).tim) * bulletspd%
      player(pn%).x = player(pn%).xi + t# * COS(player(pn%).aj) * player(pn%).pj * player(pn%).dir
      player(pn%).y = player(pn%).yi + t# * SIN(player(pn%).aj) * player(pn%).pj + 16 * t# ^ 2
      DrawPlayer pn%
     END IF
    END IF
   NEXT pn%
  END IF
  FOR r! = 0 TO pi# * 2 STEP .05 / (bullet(i%).dir / 10)
   c% = 220 - (bullet(i%).a / bullet(i%).dir) * 20 + RND * 4 - 2
   IF c% < 200 THEN c% = 200
   IF c% > 220 THEN c% = 220
   IF bullet(i%).p = -1 THEN c% = 241
   TPset x% + COS(r!) * bullet(i%).a + 3, y% + SIN(r!) * bullet(i%).a + 3, 241
   bp% = c%
   IF c% = 241 THEN
    bp% = BPoint%(x% + COS(r!) * bullet(i%).a + 3, y% + SIN(r!) * bullet(i%).a + 3, 0)
   END IF
   PSET (x% + COS(r!) * bullet(i%).a + 3, y% + SIN(r!) * bullet(i%).a + 3), bp%
  NEXT r!
  bullet(i%).a = bullet(i%).a + .5 * bullet(i%).p
  IF bullet(i%).p = 1 AND bullet(i%).a >= bullet(i%).dir THEN
   bullet(i%).p = -1
  END IF
  IF bullet(i%).set = 2 THEN
   cc% = -1
   IF bullet(i%).p = 1 AND bullet(i%).a < 10 THEN cc% = 1
   bullet(i%).tim = bullet(i%).tim + cc%
   IF bullet(i%).tim < 0 THEN bullet(i%).tim = 0
   IF bullet(i%).tim > 20 THEN bullet(i%).tim = 20
   ci% = 100 - (bullet(i%).tim * 3)
   IF ci% < 0 THEN ci% = 0
   IF ci% > 100 THEN ci% = 100
   FadePal gamepal(bullet(i%).tim + 200).r, gamepal(bullet(i%).tim + 200).g, gamepal(bullet(i%).tim + 200).B, ci%, 0, 255
  END IF
  IF bullet(i%).set >= 1 THEN
   FOR ii% = 1 TO maxsparks%
    sx% = bullet(i%).x + 3 + spark(ii%).r * COS(spark(ii%).a)
    sy% = bullet(i%).y + 3 + .3 * (spark(ii%).r * SIN(spark(ii%).a))
    PSET (sx%, sy%), BPoint%(sx%, sy%, 0)
    spark(ii%).r = spark(ii%).r + 2
    sx% = bullet(i%).x + 3 + spark(ii%).r * COS(spark(ii%).a)
    sy% = bullet(i%).y + 3 + .3 * (spark(ii%).r * SIN(spark(ii%).a))
    c% = 220 - spark(ii%).r / 3
    IF c% < 200 THEN c% = 200
    IF bullet(i%).p = -1 AND bullet(i%).a < 0 THEN c% = BPoint%(sx%, sy%, 0)
    PSET (sx%, sy%), c%
   NEXT ii%
  END IF
  IF bullet(i%).p = -1 AND bullet(i%).a < 0 THEN
   bullet(i%).class = 0
   GOTO nextbul
  END IF
  x% = (bullet(i%).dir / 10 - 1) * 3000 + 1000
  EarthQuake x%
 END IF

 'Ammo crate on the ground
 '==========
 'bullet variables:
 'x = x xoordinate
 'y = y xoordinate
 'a = null
 'dir = ammo amount
 'p = null
 'set = ammo class
 'tim = null
 IF bullet(i%).class = 100 THEN
  x% = bullet(i%).x
  y% = bullet(i%).y
  FOR ii% = 1 TO maxplayers%
   pd% = SQR((player(ii%).x - x%) ^ 2 + (player(ii%).y - y%) ^ 2)
   IF pd% <= 7 THEN
    EraseSpr x%, y%, 0
    bullet(i%).class = 0
    playpack(ii%, bullet(i%).set).ammo = playpack(ii%, bullet(i%).set).ammo + bullet(i%).dir
    InitBullet 101, x%, y%, 0, bullet(i%).dir, 0, bullet(i%).set
    IF config.snd THEN
     WAVPlay "bounce.wav", 11000
    END IF
    GOTO nextbul
   END IF
  NEXT ii%
  FOR ii% = 1 TO maxbullets%
   IF i% <> ii% AND bullet(ii%).class = -1 THEN
    pd% = SQR((bullet(ii%).x - x%) ^ 2 + (bullet(ii%).y - y%) ^ 2)
    IF pd% <= bullet(ii%).a THEN
     bullet(i%).class = -1
     bullet(i%).a = 0
     bullet(i%).dir = 15
     bullet(i%).p = 1
     bullet(i%).set = 0
     IF config.snd THEN
      WAVPlay "explode.wav", 11000
     END IF
     GOTO nextbul
    END IF
   END IF
  NEXT ii%
  DrawSpr x%, y%, 0
 END IF

 'Ammo crate falling from sky
 '==========
 'bullet variables:
 'x = x xoordinate
 'y = y xoordinate (should be 0 at initializtion)
 'a = null
 'dir = ammo amount
 'p = null
 'set = ammo class
 'tim = fall timer (set to TIMER at initializtion)
 IF bullet(i%).class = -100 THEN
  level.nofly = 0
  x% = bullet(i%).x
  y% = bullet(i%).y
  t# = (level.tim - bullet(i%).tim) * bulletspd%
  EraseSpr x%, y%, 0
  y% = bullet(i%).yi + 16 * t# ^ 2 * level.grav
  IF x% < -7 OR x% > 326 OR y% > 206 THEN
   bullet(i%).class = 0
   GOTO nextbul
  END IF
  bullet(i%).y = y%
  IF TurfHit%(0, x%, y%) THEN
   bullet(i%).class = 100
   IF config.snd THEN
    WAVPlay "crash.wav", 11000
   END IF
   GOTO nextbul
  END IF
  DrawSpr x%, y%, 0
 END IF

 'Ammo displayed from ammo crate
 '==========
 'bullet variables:
 'xi = initial x xoordinate
 'yi = initial y xoordinate
 'x = current x xoordinate
 'y = current y xoordinate
 'a = null
 'dir = ammo amount
 'p = null
 'set = ammo class
 'tim = timer (set to 0 at initialization)
 IF bullet(i%).class = 101 THEN
  level.nofly = 0
  FOR ii% = 1 TO bullet(i%).dir
   IF bullet(i%).dir = 1 THEN
    xc% = 0
   ELSEIF bullet(i%).dir = 2 THEN
    xc% = -1
    IF ii% = 2 THEN xc% = 1
   ELSEIF bullet(i%).dir = 2 THEN
    xc% = -1
    IF ii% = 2 THEN xc% = 0
    IF ii% = 3 THEN xc% = 1
   END IF
   x% = bullet(i%).xi + xc% * bullet(i%).a
   y% = bullet(i%).yi - bullet(i%).a
   EraseSpr x%, y%, bullet(i%).set
  NEXT ii%
  IF level.tim - bullet(i%).tim >= 1 THEN
   bullet(i%).class = 0
   GOTO nextbul
  END IF
  bullet(i%).a = bullet(i%).a + .03
  FOR ii% = 1 TO bullet(i%).dir
   IF bullet(i%).dir = 1 THEN
    xc% = 0
   ELSEIF bullet(i%).dir = 2 THEN
    xc% = -1
    IF ii% = 2 THEN xc% = 1
   ELSEIF bullet(i%).dir = 2 THEN
    xc% = -1
    IF ii% = 2 THEN xc% = 0
    IF ii% = 3 THEN xc% = 1
   END IF
   x% = bullet(i%).xi + xc% * bullet(i%).a
   y% = bullet(i%).yi - bullet(i%).a
   DrawSpr x%, y%, bullet(i%).set
  NEXT ii%
 END IF

 'Basic cannon ball
 '==========
 'bullet variables:
 'xi = initial x xoordinate
 'yi = initial y xoordinate
 'x = current x xoordinate
 'y = current y xoordinate
 'a = launch angle
 'dir = launch direction
 'p = launch power
 'set = multiple bullets
 'tim = fly timer (set to TIMER at initialization)
 IF bullet(i%).class = 1 THEN
  level.nofly = 0
  x% = bullet(i%).x
  y% = bullet(i%).y
  a# = bullet(i%).a
  p% = bullet(i%).p
  d% = bullet(i%).dir
  t# = (level.tim - bullet(i%).tim) * bulletspd%
  EraseSpr x%, y%, 1
  x% = bullet(i%).xi + t# * COS(a#) * p% * d% + level.wind * t#
  y% = bullet(i%).yi + t# * SIN(a#) * p% + 16 * t# ^ 2 * level.grav
  IF x% < -7 OR x% > 326 OR y% > 206 THEN
   bullet(i%).class = 0
   GOTO nextbul
  END IF
  bullet(i%).x = x%
  bullet(i%).y = y%
  IF TurfHit%(1, x%, y%) THEN
   bullet(i%).class = -1
   bullet(i%).a = 0
   bullet(i%).dir = (4 - bullet(i%).set) * 3 + 7
   bullet(i%).p = 1
   bullet(i%).set = 0
   IF config.snd THEN
    WAVPlay "blast.wav", 11000
   END IF
   GOTO nextbul
  END IF
  DrawSpr x%, y%, 1
 END IF

 'Grenade
 '==========
 'bullet variables:
 'xi = initial x xoordinate
 'yi = initial y xoordinate
 'x = current x xoordinate
 'y = current y xoordinate
 'a = launch angle
 'dir = launch direction
 'p = launch power
 'set = explosion timer
 'tim = fly timer (set to TIMER at initialization)
 IF bullet(i%).class = 2 THEN
  level.nofly = 0
  x% = bullet(i%).x
  y% = bullet(i%).y
  a# = bullet(i%).a
  p% = bullet(i%).p
  d% = bullet(i%).dir
  t# = (level.tim - bullet(i%).tim) * bulletspd%
  EraseSpr x%, y%, 2
  x% = bullet(i%).xi + t# * COS(a#) * p% * d% + level.wind * t#
  y% = bullet(i%).yi + t# * SIN(a#) * p% + 16 * t# ^ 2 * level.grav
  IF x% < -7 OR x% > 326 OR y% > 206 THEN
   bullet(i%).class = 0
   GOTO nextbul
  END IF
  bump$ = TurfBump$(x%, y%, level.turn)
  SELECT CASE bump$
  
   CASE "00000000"
  
   CASE "11111111"
    x% = bullet(i%).x
    y% = bullet(i%).y
    bullet(i%).xi = bullet(i%).x
    bullet(i%).yi = bullet(i%).y
    bullet(i%).tim = TIMER
  
   CASE "11100011", "11000001", "10000000", "00000010", "00000001", "00000011", "10000011", "00000111", "10000111", "11001111", "10001111", "11000111", "10000001", "11001111", "11101111", "11000001", "11000011"
    IF bullet(i%).dir = -1 THEN
     xc% = t# * COS(a#) * p% * -d% + level.wind * t#
     bullet(i%).xi = x% - xc%
     bullet(i%).dir = 1
     IF config.snd THEN
      WAVPlay "bounce.wav", 11000
     END IF
    END IF
  
   CASE "11110001", "11100000", "01000000", "00100000", "00010000", "00110000", "01110000", "00111000", "01111000", "11111100", "01111100", "11111000", "01100000", "11111100", "11111110", "11100000", "11110000"
    IF bullet(i%).dir = 1 THEN
     xc% = t# * COS(a#) * p% * -d% + level.wind * t#
     bullet(i%).xi = x% - xc%
     bullet(i%).dir = -1
     IF config.snd THEN
      WAVPlay "bounce.wav", 11000
     END IF
    END IF

   CASE "00000110", "00001111", "10011111"
    IF y% > bullet(i%).y THEN
     bullet(i%).xi = x%
     bullet(i%).yi = y%
     bullet(i%).p = p% / 1.5
     bullet(i%).dir = 1
     bullet(i%).tim = TIMER - .1
     IF config.snd THEN
      WAVPlay "bounce.wav", 11000
     END IF
    END IF

   CASE "00011000", "00111100", "01111110"
    IF y% > bullet(i%).y THEN
     bullet(i%).xi = x%
     bullet(i%).yi = y%
     bullet(i%).p = p% / 1.5
     bullet(i%).dir = -1
     bullet(i%).tim = TIMER - .1
     IF config.snd THEN
      WAVPlay "bounce.wav", 11000
     END IF
    END IF
  
   CASE ELSE
    IF y% > bullet(i%).y THEN
     bullet(i%).xi = x%
     bullet(i%).yi = y%
     bullet(i%).p = p% / 1.5
     bullet(i%).tim = TIMER - .1
     IF config.snd THEN
      WAVPlay "bounce.wav", 11000
     END IF
    END IF

  END SELECT
  bullet(i%).x = x%
  bullet(i%).y = y%
  IF bullet(i%).set <= 0 THEN
   bullet(i%).class = -1
   bullet(i%).a = 0
   bullet(i%).dir = 20
   bullet(i%).p = 1
   bullet(i%).set = 0
   IF config.snd THEN
    WAVPlay "blast.wav", 7000
   END IF
   GOTO nextbul
  END IF
  DrawSpr x%, y%, 2
  bullet(i%).set = bullet(i%).set - 15
 END IF

 'Mine
 '==========
 'bullet variables:
 'x = current x xoordinate
 'y = current y xoordinate
 'a = null
 'dir = null
 'p = null
 'set = trip distance setting
 'tim = null
 IF bullet(i%).class = 3 THEN
  IF level.tim - bullet(i%).tim < 4 THEN level.nofly = 0
  IF level.tim - bullet(i%).tim > 3 THEN
   x% = bullet(i%).x
   y% = bullet(i%).y
   FOR ii% = 1 TO maxplayers%
    pd% = SQR((player(ii%).x - x%) ^ 2 + (player(ii%).y - y%) ^ 2)
    IF pd% <= 5 * bullet(i%).set THEN
     bullet(i%).class = -1
     bullet(i%).a = 0
     bullet(i%).dir = 15
     bullet(i%).p = 1
     bullet(i%).y = bullet(i%).y + 3
     bullet(i%).set = 0
     IF ii% = level.turn THEN level.fire = 1
     IF config.snd THEN
      WAVPlay "explode.wav", 11000
     END IF
     GOTO nextbul
    END IF
   NEXT ii%
   FOR ii% = 1 TO maxbullets%
    IF i% <> ii% AND bullet(ii%).class = -1 THEN
     pd% = SQR((bullet(ii%).x - x%) ^ 2 + (bullet(ii%).y - y%) ^ 2)
     IF pd% <= bullet(ii%).a THEN
      bullet(i%).class = -1
      bullet(i%).a = 0
      bullet(i%).dir = 15
      bullet(i%).p = 1
      bullet(i%).set = 0
      IF config.snd THEN
       WAVPlay "explode.wav", 11000
      END IF
      GOTO nextbul
     END IF
    END IF
   NEXT ii%
  END IF
  DrawSpr bullet(i%).x, bullet(i%).y, 3
 END IF

 'Gluer
 '==========
 'bullet variables:
 'xi = initial x xoordinate
 'yi = initial y xoordinate
 'x = current x xoordinate
 'y = current y xoordinate
 'a = launch angle
 'dir = launch direction
 'p = launch power
 'set = multiple bullets
 'tim = fly timer (set to TIMER at initialization)
 IF bullet(i%).class = 4 THEN
  level.nofly = 0
  x% = bullet(i%).x
  y% = bullet(i%).y
  a# = bullet(i%).a
  p% = bullet(i%).p
  d% = bullet(i%).dir
  t# = (level.tim - bullet(i%).tim) * bulletspd%
  EraseSpr x%, y%, 4
  x% = bullet(i%).xi + t# * COS(a#) * p% * d% + level.wind * t#
  y% = bullet(i%).yi + t# * SIN(a#) * p% + 16 * t# ^ 2 * level.grav
  IF x% < -7 OR x% > 326 OR y% > 206 THEN
   bullet(i%).class = 0
   GOTO nextbul
  END IF
  bullet(i%).x = x%
  bullet(i%).y = y%
  IF TurfHit%(1, x%, y%) THEN
   bullet(i%).class = -4
   bullet(i%).a = 1
   bullet(i%).dir = (5 - bullet(i%).set) * 5
   bullet(i%).p = 1
   bullet(i%).tim = 0
   IF config.snd THEN
    WAVPlay "glue.wav", 11000
   END IF
   GOTO nextbul
  END IF
  DrawSpr x%, y%, 4
 END IF

 'Gluer Explosion
 '==========
 'bullet variables:
 'x = x xoordinate
 'y = y xoordinate
 'a = current blob size (set to 1 at initialization)
 'dir = size of final blob (set this at initialization)
 'p = direction of blob growth (set to 1 at initialization)
 'set = null
 'tim = blob timer (set to 0 at initialization)
 IF bullet(i%).class = -4 THEN
  level.nofly = 0
  x% = bullet(i%).x
  y% = bullet(i%).y
  a# = bullet(i%).a
  d% = bullet(i%).dir
  FOR pn% = 1 TO maxplayers%
   IF player(pn%).health > 0 THEN
    pd% = SQR((player(pn%).x - x%) ^ 2 + (player(pn%).y - y%) ^ 2)
    IF pd% < a# THEN
     player(pn%).glued = 4 - bullet(i%).set
    END IF
   END IF
  NEXT pn%
  FOR ap# = .05 TO pi# * 2 STEP .05
   xp% = x% + 3 + (a# - bullet(i%).p) * COS(ap#)
   yp% = y% + 3 + (a# - bullet(i%).p) * SIN(ap#)
   PSET (xp%, yp%), BPoint%(xp%, yp%, 0)
   xp% = x% + 3 + a# * COS(ap#)
   yp% = y% + 3 + a# * SIN(ap#)
   c% = 92
   PSET (xp%, yp%), c%
  NEXT ap#
  IF a# = 0 THEN
   bullet(i%).p = 1
   bullet(i%).tim = bullet(i%).tim + 1
   IF bullet(i%).tim = 5 THEN
    bullet(i%).class = 0
    PSET (x% + 3, y% + 3), BPoint%(x%, y%, 0)
    GOTO nextbul
   END IF
  END IF
  IF a# = (5 - bullet(i%).set) * 5 THEN
   bullet(i%).p = -1
  END IF
  bullet(i%).a = bullet(i%).a + bullet(i%).p
 END IF

 'Cluster bomb
 '==========
 'bullet variables:
 'xi = initial x xoordinate
 'yi = initial y xoordinate
 'x = current x xoordinate
 'y = current y xoordinate
 'a = launch angle
 'dir = launch direction
 'p = launch power
 'set = # of bombs
 'tim = fly timer (set to TIMER at initialization)
 IF bullet(i%).class = 7 THEN
  level.nofly = 0
  x% = bullet(i%).x
  y% = bullet(i%).y
  a# = bullet(i%).a
  p% = bullet(i%).p
  d% = bullet(i%).dir
  t# = (level.tim - bullet(i%).tim) * bulletspd%
  EraseSpr x%, y%, 7
  x% = bullet(i%).xi + t# * COS(a#) * p% * d% + level.wind * t#
  y% = bullet(i%).yi + t# * SIN(a#) * p% + 16 * t# ^ 2 * level.grav
  IF x% < -7 OR x% > 326 OR y% > 206 THEN
   bullet(i%).class = 0
   GOTO nextbul
  END IF
  bullet(i%).x = x%
  bullet(i%).y = y%
  IF TurfHit%(7, x%, y%) OR t# >= 2 THEN
   bullet(i%).class = -1
   bullet(i%).a = 0
   bullet(i%).dir = (4 - bullet(i%).set) * 10
   bullet(i%).p = 1
   IF bullet(i%).set = 1 THEN
    InitBullet 1, x%, y%, 1.6, -1, 50, bullet(i%).set
   ELSEIF bullet(i%).set = 2 THEN
    InitBullet 1, x%, y%, .5, -1, 50, bullet(i%).set
    InitBullet 1, x%, y%, .5, 1, 50, bullet(i%).set
   ELSEIF bullet(i%).set = 3 THEN
    InitBullet 1, x%, y%, .5, -1, 50, bullet(i%).set
    InitBullet 1, x%, y%, 1.6, -1, 50, bullet(i%).set
    InitBullet 1, x%, y%, .5, 1, 50, bullet(i%).set
   END IF
   bullet(i%).set = 2
   bullet(i%).tim = 0
   FOR ii% = 1 TO maxsparks%
    spark(ii%).r = 0
    spark(ii%).a = ((2 * pi#) / maxsparks%) * ii%
   NEXT ii%
   IF config.snd THEN
    WAVPlay "explode.wav", 11000
   END IF
   GOTO nextbul
  END IF
  DrawSpr x%, y%, 7
 END IF

nextbul:
NEXT i%
END SUB

SUB Configure
'The Configuration SUB.

startcfg:
menuitem(0) = "CONFIGURE"
menuitem(1) = "Players"
menuitem(2) = "Starting Pack"
menuitem(3) = "Keyboard"
menuitem(4) = "Options"
menuitem(5) = "Save"
mnum% = 5
Menu mnum%
SELECT CASE mnum%
 CASE -1
  EXIT SUB
 CASE 1
  GOTO players
 CASE 2
  GOTO startpack
 CASE 3
  GOTO keyboard
 CASE 4
  GOTO options
 CASE 5
  GOTO savecfg
END SELECT

players:
menuitem(0) = "PLAYERS"
menuitem(1) = "Health:" + STR$(player(0).health)
FOR i% = 1 TO maxplayers%
 menuitem(i% + 1) = player(i%).nam + ": " + team(player(i%).tnum).nam
NEXT i%
mnum% = maxplayers% + 1
Menu mnum%
SELECT CASE mnum%
 CASE -1
  GOTO startcfg
 CASE 1
  LINE (0, 30)-(319, 199), 0, BF
  Font menuitem(mnum%), 160 - (LEN(menuitem(mnum%)) / 2) * 8, 50, 1, 1, 2, menuclr% + 5
  FOR c% = 0 TO 100
   FadePal 0, 0, 0, c%, 0, 31
  NEXT c%
  LOCATE 10, 20
  INPUT "", i%
  IF i% < 1 THEN i% = 1
  IF i% > 100 THEN i% = 100
  player(0).health = i%
  FOR c% = 100 TO 0 STEP -1
   FadePal 0, 0, 0, c%, 0, 31
  NEXT c%
  GOTO players
 CASE 2 TO maxplayers% + 1
  LINE (0, 30)-(319, 199), 0, BF
  Font menuitem(mnum%), 160 - (LEN(menuitem(mnum%)) / 2) * 8, 50, 1, 1, 2, menuclr% + 5
  Font "New Name", 160 - (LEN("New Name") / 2) * 8, 65, 1, 1, 2, menuclr% + 5
  Font "(Enter Makes No Change)", 160 - (LEN("(Enter Makes No Change)") / 2) * 8, 90, 1, 1, 2, menuclr% + 5
  FOR c% = 0 TO 100
   FadePal 0, 0, 0, c%, 0, 31
  NEXT c%
  LOCATE 11, 15
  INPUT "", l$
  i% = mnum% - 1
  IF l$ <> "" THEN
   player(i%).nam = l$
  END IF
  FOR c% = 100 TO 0 STEP -1
   FadePal 0, 0, 0, c%, 0, 31
  NEXT c%

  menuitem(0) = "TEAM SELECT"
  menuitem(1) = team(0).nam
  FOR ii% = 1 TO maxplayers%
   menuitem(ii% + 1) = team(ii%).nam
  NEXT ii%
  mnum% = maxplayers% + 1
  Menu mnum%
  SELECT CASE mnum%
   CASE -1
    GOTO startcfg
   CASE 1
    player(i%).tnum = 0
   CASE 2 TO maxplayers% + 1
    player(i%).tnum = mnum% - 1
  END SELECT
  GOTO players
END SELECT

startpack:
menuitem(0) = "STARTING PACK"
menuitem(1) = "Cannons:" + STR$(playpack(0, 1).ammo)
menuitem(2) = "Grenades:" + STR$(playpack(0, 2).ammo)
menuitem(3) = "Mines:" + STR$(playpack(0, 3).ammo)
menuitem(4) = "Gluers:" + STR$(playpack(0, 4).ammo)
menuitem(5) = "Flamers:" + STR$(playpack(0, 5).ammo)
menuitem(6) = "Boosters:" + STR$(playpack(0, 6).ammo)
menuitem(7) = "Clusters:" + STR$(playpack(0, 7).ammo)
mnum% = 7
Menu mnum%
SELECT CASE mnum%
 CASE -1
  GOTO startcfg
 CASE 1, 2, 3, 4, 5, 6, 7
  LINE (0, 30)-(319, 199), 0, BF
  Font menuitem(mnum%), 160 - (LEN(menuitem(mnum%)) / 2) * 8, 50, 1, 1, 2, menuclr% + 5
  FOR c% = 0 TO 100
   FadePal 0, 0, 0, c%, 0, 31
  NEXT c%
  LOCATE 10, 20
  INPUT "", i%
  IF mnum% = 1 THEN
   IF i% < 0 THEN i% = 0
   IF i% > 99 THEN i% = 99
   playpack(0, 1).ammo = i%
  END IF
  IF mnum% = 2 THEN
   IF i% < 0 THEN i% = 0
   IF i% > 99 THEN i% = 99
   playpack(0, 2).ammo = i%
  END IF
  IF mnum% = 3 THEN
   IF i% < 0 THEN i% = 0
   IF i% > 99 THEN i% = 99
   playpack(0, 3).ammo = i%
  END IF
  IF mnum% = 4 THEN
   IF i% < 0 THEN i% = 0
   IF i% > 99 THEN i% = 99
   playpack(0, 4).ammo = i%
  END IF
  IF mnum% = 5 THEN
   IF i% < 0 THEN i% = 0
   IF i% > 99 THEN i% = 99
   playpack(0, 5).ammo = i%
  END IF
  IF mnum% = 6 THEN
   IF i% < 0 THEN i% = 0
   IF i% > 99 THEN i% = 99
   playpack(0, 6).ammo = i%
  END IF
  IF mnum% = 7 THEN
   IF i% < 0 THEN i% = 0
   IF i% > 99 THEN i% = 99
   playpack(0, 7).ammo = i%
  END IF
  FOR c% = 100 TO 0 STEP -1
   FadePal 0, 0, 0, c%, 0, 31
  NEXT c%
  GOTO startpack
END SELECT

keyboard:
menuitem(0) = "KEYBOARD"
menuitem(1) = keyact(1) + SPACE$(10 - LEN(keyact(1))) + ": " + KeyName$(keycode(1))
menuitem(2) = keyact(2) + SPACE$(10 - LEN(keyact(2))) + ": " + KeyName$(keycode(2))
menuitem(3) = keyact(3) + SPACE$(10 - LEN(keyact(3))) + ": " + KeyName$(keycode(3))
menuitem(4) = keyact(4) + SPACE$(10 - LEN(keyact(4))) + ": " + KeyName$(keycode(4))
menuitem(5) = keyact(5) + SPACE$(10 - LEN(keyact(5))) + ": " + KeyName$(keycode(5))
menuitem(6) = keyact(6) + SPACE$(10 - LEN(keyact(6))) + ": " + KeyName$(keycode(6))
mnum% = 6
Menu mnum%
SELECT CASE mnum%
 CASE -1
  GOTO startcfg
 CASE 1, 2, 3, 4, 5, 6
  LINE (0, 30)-(319, 199), 0, BF
  Font menuitem(mnum%), 160 - (LEN(menuitem(mnum%)) / 2) * 8, 50, 1, 1, 2, menuclr% + 5
  Font "Press new key", 160 - (LEN("Press new key") / 2) * 8, 70, 1, 1, 2, menuclr% + 5
  FOR c% = 0 TO 100
   FadePal 0, 0, 0, c%, 0, 31
  NEXT c%
  DO
   key$ = INKEY$
  LOOP UNTIL key$ = ""
  DO
   key$ = INKEY$
  LOOP UNTIL key$ <> ""
  keycheck% = 1
  FOR i% = 1 TO 10 + maxweapons%
   IF i% <> mnum% AND key$ = keycode(i%) THEN keycheck% = 0
  NEXT i%
  IF keycheck% THEN
   keycode(mnum%) = key$
  ELSE
   Font "Key already assigned", 160 - (LEN("Key already assigned") / 2) * 8, 90, 1, 1, 2, menuclr% + 5
   IF config.snd THEN
    WAVPlay "buzzer.wav", 11000
    DO
    LOOP UNTIL DMADone%
   END IF
  END IF
  FOR c% = 100 TO 0 STEP -1
   FadePal 0, 0, 0, c%, 0, 31
  NEXT c%
  GOTO keyboard
END SELECT

options:
menuitem(0) = "OPTIONS"
IF config.ammodrop = 0 THEN ad$ = "Never"
IF config.ammodrop = .1 THEN ad$ = "Low"
IF config.ammodrop = .2 THEN ad$ = "Medium"
IF config.ammodrop = .3 THEN ad$ = "High"
menuitem(1) = "Ammo Drops: " + ad$
menuitem(2) = "Sound Volume:" + RTRIM$(STR$(config.snd))
IF config.sndb = 0 THEN ad$ = "Off"
IF config.sndb = 1 THEN ad$ = "On"
menuitem(3) = "Background Sound: " + ad$
mnum% = 3
Menu mnum%
SELECT CASE mnum%
 CASE -1
  GOTO startcfg
 CASE 1
  menuitem(0) = "AMMO DROPS"
  menuitem(1) = "Never"
  menuitem(2) = "Low"
  menuitem(3) = "Medium"
  menuitem(4) = "High"
  mnum% = 4
  Menu mnum%
  config.ammodrop = (mnum% - 1) * .1
  GOTO options
 CASE 2
  LINE (0, 30)-(319, 199), 0, BF
  Font menuitem(1), 160 - (LEN(menuitem(1)) / 2) * 8, 50, 1, 1, 2, menuclr% + 5
  FOR c% = 0 TO 100
   FadePal 0, 0, 0, c%, 0, 31
  NEXT c%
  LOCATE 10, 20
  INPUT "", i%
  IF i% < 0 THEN i% = 0
  IF i% > 15 THEN i% = 15
  IF config.snd = 0 THEN
   GetBlaster channel%, baseport%, irq%
   IF DSPReset% THEN
    SpeakerState 1
    MasterVolume config.snd, config.snd, 0
   ELSE
    PRINT "DSP failed to reset."
    PRINT "Sound disabled."
    config.snd = 0
   END IF
  END IF
  config.snd = i%
  MasterVolume config.snd, config.snd, 0
  FOR c% = 100 TO 0 STEP -1
   FadePal 0, 0, 0, c%, 0, 31
  NEXT c%
  GOTO options
 CASE 3
  menuitem(0) = "BACKGROUND SOUND"
  menuitem(1) = "On"
  menuitem(2) = "Off"
  mnum% = 2
  Menu mnum%
  IF mnum% = 1 THEN
   config.sndb = 1
  ELSE
   config.sndb = 0
  END IF
  GOTO options
END SELECT

savecfg:
KILL game.cfgfile
OPEN game.cfgfile FOR OUTPUT AS #1
l$ = ""
FOR i% = 1 TO maxplayers%
 PRINT #1, "player" + STR$(i%) + " " + player(i%).nam
 l$ = l$ + " " + LTRIM$(STR$(player(i%).tnum))
NEXT i%
PRINT #1, "teams" + l$
PRINT #1, "health" + STR$(player(0).health)
PRINT #1, "pack.cannon" + STR$(playpack(0, 1).ammo)
PRINT #1, "pack.grenade" + STR$(playpack(0, 2).ammo)
PRINT #1, "pack.mine" + STR$(playpack(0, 3).ammo)
PRINT #1, "pack.gluer" + STR$(playpack(0, 4).ammo)
PRINT #1, "pack.flamer" + STR$(playpack(0, 5).ammo)
PRINT #1, "pack.booster" + STR$(playpack(0, 6).ammo)
PRINT #1, "pack.cluster" + STR$(playpack(0, 7).ammo)
PRINT #1, "ammo.drops" + STR$(config.ammodrop)
PRINT #1, "sound.volume" + STR$(config.snd)
PRINT #1, "sound.back" + STR$(config.sndb)
PRINT #1, "/end"
CLOSE #1

KILL game.keyfile
OPEN game.keyfile FOR RANDOM AS #1
FOR i% = 1 TO 6
 PUT #1, i%, keycode(i%)
NEXT i%
CLOSE #1
END SUB

SUB Damage (pn%, dam%)
'Applies damage to players.
'pn% = player number
'dam% = damage amount

ErasePlayer pn%
player(pn%).health = player(pn%).health - dam%
IF player(pn%).health <= 0 THEN player(pn%).health = 0
DrawPlayer pn%
player(pn%).dam = 1
END SUB

SUB DefaultPal
'Sets the default palette.

FOR c% = 0 TO 255
 gamepal(c%).r = defpal(c%).r
 gamepal(c%).g = defpal(c%).g
 gamepal(c%).B = defpal(c%).B
NEXT c%
END SUB

FUNCTION DMADone%
'Checks if the DMA is done with a WAV.

Count% = INP(lenport%)
Count2% = INP(lenport%)
Count& = CLNG(Count% + 1) * CLNG(Count2% + 1)
IF (Count& - 1) >= &HFFFF& THEN
 junk% = INP(DSPDataAvail%)
 DMADone% = -1
END IF
END FUNCTION

SUB DMAPlay (segment&, offset&, length&, freq&)
'Makes the DMA play sounds.

length& = length& - 1
page% = 0
memloc& = segment& * 16 + offset&
SELECT CASE channel%
 CASE 0
  pgport% = &H87
  addport% = &H0
  lenport% = &H1
  modereg% = &H48
 CASE 1
  pgport% = &H83
  addport% = &H2
  lenport% = &H3
  modereg% = &H49
 CASE 2
  pgport% = &H81
  addport% = &H4
  lenport% = &H5
  modereg% = &H4A
 CASE 3
  pgport% = &H82
  addport% = &H6
  lenport% = &H7
  modereg% = &H4B
END SELECT

OUT &HA, &H4 + channel%
OUT &HC, &H0
OUT &HB, modereg%
OUT addport%, memloc& AND &HFF
OUT addport%, (memloc& AND &HFFFF&) \ &H100
IF (memloc& AND 65536) THEN page% = page% + 1
IF (memloc& AND 131072) THEN page% = page% + 2
IF (memloc& AND 262144) THEN page% = page% + 4
IF (memloc& AND 524288) THEN page% = page% + 8
OUT pgport%, page%
OUT lenport%, length& AND &HFF
OUT lenport%, (length& AND &HFFFF&) \ &H100
OUT &HA, channel%

TimeConst% = 256 - 1000000 \ freq&
DSPWrite &H40
DSPWrite TimeConst%
DSPWrite &H14
DSPWrite (length& AND &HFF)
DSPWrite ((length& AND &HFFFF&) \ &H100)
END SUB

SUB DMAState (state%)
'Can set the state of the DMA. (1 = on, 0 = off)

IF state% THEN
 DSPWrite &HD4
ELSE
 DSPWrite &HD0
END IF
END SUB

SUB DoneTurn
'This SUB occurs at the end of every players turn.
'Displays the turns damage and checks if player is dead.

FOR i% = 1 TO maxplayers%
 IF level.turn = i% AND player(i%).glued > 0 THEN player(i%).glued = player(i%).glued - 1
 IF player(i%).dam THEN
  DrawPlayer i%
 END IF
NEXT i%
FOR ii% = 1 TO 5
 FOR c% = 0 TO 20
  FOR i% = 1 TO maxplayers%
   IF player(i%).dam = 1 THEN
    OUT &H3C8, 220 + i%
    OUT &H3C9, c% * 3
    OUT &H3C9, c% * 2
    OUT &H3C9, 0
    FOR z% = -32000 TO 32000
    NEXT z%
   END IF
  NEXT i%
 NEXT c%
 FOR c% = 20 TO 0 STEP -1
  FOR i% = 1 TO maxplayers%
   IF player(i%).dam = 1 THEN
    OUT &H3C8, 220 + i%
    OUT &H3C9, c% * 3
    OUT &H3C9, c% * 2
    OUT &H3C9, 0
    FOR z% = -32000 TO 32000
    NEXT z%
   END IF
  NEXT i%
 NEXT c%
NEXT ii%
FadePal 0, 0, 0, 100, 221, 230
FOR i% = 1 TO maxplayers%
 IF player(i%).dam THEN
  player(i%).dam = 0
  IF player(i%).health = 0 THEN
   ErasePlayer i%
   IF config.snd THEN
    WAVPlay "death.wav", 11000
   END IF
   FOR r! = 0 TO 15 STEP .5
    FOR x% = 0 TO 7
     FOR y% = 0 TO 7
      p% = playerspr(x% + 8 * y%)
      IF p% <> 0 THEN
       IF x% <= 3 THEN
        xc% = x% - 4
       ELSE
        xc% = x% - 3
       END IF
       IF y% <= 3 THEN
        yc% = y% - 4
       ELSE
        yc% = y% - 3
       END IF
       FOR ii% = 0 TO 5
        nr! = (r! - ii%)
        IF nr! < 0 THEN nr! = 0
        IF nr! <= 10 THEN
         px% = player(i%).x + x% + xc% * nr!
         py% = player(i%).y + y% + (yc% - 3) * nr! + 16 * (nr! / 10) ^ 2
         IF p% = -1 THEN
          p% = team(player(i%).tnum).clr
         ELSEIF p% = -10 THEN
          IF player(i%).dir = 1 THEN
           p% = 25 - INT(x% / 2)
          ELSE
           p% = 25 - INT((7 - x%) / 2)
          END IF
         END IF
         IF ii% > 0 THEN p% = 220 - ii% * 3
         IF ii% = 5 THEN p% = BPoint%(px%, py%, 0)
         PSET (px%, py%), p%
        END IF
       NEXT ii%
       FOR z% = 0 TO 32000
       NEXT z%
      END IF
     NEXT y%
    NEXT x%
   NEXT r!
  END IF
 END IF
NEXT i%
END SUB

SUB DrawBar
'Redraws the Infobar for each turn.

FOR y% = 0 TO 15
 FOR x% = 0 TO 319
  p% = TPoint%(x%, y%, 0)
  IF p% = 241 THEN
   DEF SEG = VARSEG(backbuf(0))
   p% = PEEK(x% + 320 * y%)
   DEF SEG
  END IF
  PSET (x%, y%), p%
 NEXT x%
NEXT y%
Font player(level.turn).nam, 8, 4, 1, 1, 3, 24
LINE (109, 3)-(211, 12), team(player(level.turn).tnum).clr, B
FOR i% = 4 TO 11
 LINE (110, i%)-(210, i%), i% + 12
NEXT i%
FOR i% = 4 TO 11
 LINE (110, i%)-(110 + player(level.turn).health, i%), 28 - i% + 4
NEXT i%
LINE (219, 4)-(281, 7), team(player(level.turn).tnum).clr, B
Font LTRIM$(STR$(playpack(level.turn, player(level.turn).bul).ammo)), 288, 4, 1, 1, 3, 24
DrawSpr 308, 1, player(level.turn).bul
DrawSmallNum 311, 10, playpack(level.turn, player(level.turn).bul).set, 15
IF level.wind = 0 THEN
 CIRCLE (250, 11), 2, 78
ELSEIF level.wind > 0 THEN
 LINE (250 - level.wind / 2, 11)-(250 + level.wind / 2, 11), 78
 LINE (250 + level.wind / 2, 11)-(248 + level.wind / 2, 9), 78
 LINE (250 + level.wind / 2, 11)-(248 + level.wind / 2, 13), 78
ELSEIF level.wind < 0 THEN
 LINE (250 - level.wind / 2, 11)-(250 + level.wind / 2, 11), 78
 LINE (250 + level.wind / 2, 11)-(252 + level.wind / 2, 9), 78
 LINE (250 + level.wind / 2, 11)-(252 + level.wind / 2, 13), 78
END IF
LINE (0, 0)-(319, 15), team(player(level.turn).tnum).clr, B
GET (0, 0)-(319, 15), barbuf
END SUB

SUB DrawHealth (pn%, c%)
'Displays a players health.
'pn% = player number
'c% = display color

n% = player(pn%).health
nn$ = LTRIM$(RTRIM$(STR$(n%)))
x% = player(pn%).x + 3 - LEN(LTRIM$(RTRIM$(STR$(player(pn%).health)))) * 2
y% = player(pn%).y - 6
FOR i% = 1 TO LEN(nn$)
 d$ = MID$(nn$, i%, 1)
 FOR yy% = 0 TO 4
  FOR xx% = 0 TO 2
   p% = smallnum(VAL(d$), xx% + 3 * yy%)
   IF p% = 1 THEN
    IF c% = -1 THEN
     p% = BPoint%(x% + xx% + (i% - 1) * 4, y% + yy%, pn%)
    ELSE
     p% = c%
    END IF
    PSET (x% + xx% + (i% - 1) * 4, y% + yy%), p%
   END IF
  NEXT xx%
 NEXT yy%
NEXT i%
END SUB

SUB DrawPlayer (pn%)
'Draws the player's sprite.

x% = player(pn%).x
y% = player(pn%).y
FOR yy% = 0 TO 7
 FOR xx% = 0 TO 7
  p% = playerspr(xx% + 8 * yy%)
  IF p% = -1 THEN
   p% = team(player(pn%).tnum).clr
  ELSEIF p% = -10 THEN
   IF player(pn%).dir = 1 THEN
    p% = 25 - INT(xx% / 2)
   ELSE
    p% = 25 - INT((7 - xx%) / 2)
   END IF
  END IF
  IF p% > 0 THEN
   IF player(pn%).glued > 0 THEN p% = 92
   PSET (x% + (player(pn%).dir - 1) * -3.5 + player(pn%).dir * xx%, y% + yy%), p%
  END IF
 NEXT xx%
NEXT yy%

DrawHealth pn%, pn% + 220
FOR i% = 0 TO gunlen%
 x% = player(pn%).x + 3 + (1 - player(pn%).dir) / 2 + COS(player(pn%).a) * i% * player(pn%).dir
 y% = player(pn%).y + 4 + SIN(player(pn%).a) * i%
 PSET (x%, y%), 25
NEXT i%
IF level.turn = pn% THEN
 PSET (player(pn%).x + 3 + COS(player(pn%).a) * playeraimsize% * player(pn%).dir, player(pn%).y + 3 + SIN(player(pn%).a) * playeraimsize%), 8
 PSET (player(pn%).x + 1 + COS(player(pn%).a) * playeraimsize% * player(pn%).dir, player(pn%).y + 3 + SIN(player(pn%).a) * playeraimsize%), 7
 PSET (player(pn%).x + 5 + COS(player(pn%).a) * playeraimsize% * player(pn%).dir, player(pn%).y + 3 + SIN(player(pn%).a) * playeraimsize%), 7
 PSET (player(pn%).x + 3 + COS(player(pn%).a) * playeraimsize% * player(pn%).dir, player(pn%).y + 1 + SIN(player(pn%).a) * playeraimsize%), 7
 PSET (player(pn%).x + 3 + COS(player(pn%).a) * playeraimsize% * player(pn%).dir, player(pn%).y + 5 + SIN(player(pn%).a) * playeraimsize%), 7
END IF
END SUB

SUB DrawSmallNum (x%, y%, n%, c%)
'Draws a small number.

nn$ = LTRIM$(RTRIM$(STR$(n%)))
FOR i% = 1 TO LEN(nn$)
 d$ = MID$(nn$, i%, 1)
 FOR yy% = 0 TO 4
  FOR xx% = 0 TO 2
   p% = smallnum(VAL(d$), xx% + 3 * yy%)
   IF p% = 1 THEN
    PSET (x% + xx% + (i% - 1) * 4, y% + yy%), c%
   END IF
  NEXT xx%
 NEXT yy%
NEXT i%
END SUB

SUB DrawSpr (x%, y%, sn%)
'Draws a sprite such as a bullet.
'x% and y% are coordinates.
'sn% is the sprite number to be drawn.

FOR yy% = 0 TO 7
 FOR xx% = 0 TO 7
  p% = ammospr(sn%, xx% + 8 * yy%)
  IF p% > 0 THEN
   PSET (x% + xx%, y% + yy%), p%
  END IF
 NEXT xx%
NEXT yy%
END SUB

FUNCTION DSPRead%
'Reads from the DSP.

DO
LOOP UNTIL INP(baseport% + 14) AND &H80
DSPRead% = INP(baseport% + 10)
END FUNCTION

FUNCTION DSPReset%
'Resets the DSP.

OUT baseport% + 6, 1
FOR Count% = 1 TO 4
 junk% = INP(baseport% + 6)
NEXT
OUT baseport% + 6, 0
IF INP(baseport% + 14) AND &H80 = &H80 AND INP(baseport% + 10) = &HAA THEN
 DSPReset% = -1
ELSE
 DSPReset% = 0
END IF
END FUNCTION

FUNCTION DSPVersion!
'Returns the DSP version.

DSPWrite &HE1
Temp% = DSPRead%
Temp2% = DSPRead%
DSPVersion! = VAL(STR$(Temp%) + "." + STR$(Temp2%))
END FUNCTION

SUB DSPWrite (byte%)
'Writes to the DSP.

DO
LOOP WHILE INP(baseport% + 12) AND &H80
OUT baseport% + 12, byte%
END SUB

SUB EarthQuake (x%)
'Makes the screen shake.

FOR i% = 1 TO x%
 OUT &H3D4, 8
 OUT &H3D5, i%
NEXT i%
OUT &H3D4, 8
OUT &H3D5, 0
END SUB

SUB ErasePlayer (pn%)
'Erases the player's sprite.

x% = player(pn%).x
y% = player(pn%).y
FOR yy% = 0 TO 7
 FOR xx% = 0 TO 7
  p% = playerspr(xx% + 8 * yy%)
  IF p% <> 0 THEN
   p% = BPoint%(x% + (player(pn%).dir - 1) * -3.5 + player(pn%).dir * xx%, y% + yy%, pn%)
   PSET (x% + (player(pn%).dir - 1) * -3.5 + player(pn%).dir * xx%, y% + yy%), p%
  END IF
 NEXT xx%
NEXT yy%

DrawHealth pn%, -1
FOR i% = 0 TO gunlen%
 x% = player(pn%).x + 3 + (1 - player(pn%).dir) / 2 + COS(player(pn%).a) * i% * player(pn%).dir
 y% = player(pn%).y + 4 + SIN(player(pn%).a) * i%
 p% = BPoint%(x%, y%, pn%)
 PSET (x%, y%), p%
NEXT i%
PSET (player(pn%).x + 3 + COS(player(pn%).a) * playeraimsize% * player(pn%).dir, player(pn%).y + 3 + SIN(player(pn%).a) * playeraimsize%), BPoint%(player(pn%).x + 3 + COS(player(pn%).a) * playeraimsize% * player(pn%).dir, player(pn%).y + 3 + SIN( _
player(pn%).a) * playeraimsize%, pn%)
PSET (player(pn%).x + 1 + COS(player(pn%).a) * playeraimsize% * player(pn%).dir, player(pn%).y + 3 + SIN(player(pn%).a) * playeraimsize%), BPoint%(player(pn%).x + 1 + COS(player(pn%).a) * playeraimsize% * player(pn%).dir, player(pn%).y + 3 + SIN( _
player(pn%).a) * playeraimsize%, pn%)
PSET (player(pn%).x + 5 + COS(player(pn%).a) * playeraimsize% * player(pn%).dir, player(pn%).y + 3 + SIN(player(pn%).a) * playeraimsize%), BPoint%(player(pn%).x + 5 + COS(player(pn%).a) * playeraimsize% * player(pn%).dir, player(pn%).y + 3 + SIN( _
player(pn%).a) * playeraimsize%, pn%)
PSET (player(pn%).x + 3 + COS(player(pn%).a) * playeraimsize% * player(pn%).dir, player(pn%).y + 1 + SIN(player(pn%).a) * playeraimsize%), BPoint%(player(pn%).x + 3 + COS(player(pn%).a) * playeraimsize% * player(pn%).dir, player(pn%).y + 1 + SIN( _
player(pn%).a) * playeraimsize%, pn%)
PSET (player(pn%).x + 3 + COS(player(pn%).a) * playeraimsize% * player(pn%).dir, player(pn%).y + 5 + SIN(player(pn%).a) * playeraimsize%), BPoint%(player(pn%).x + 3 + COS(player(pn%).a) * playeraimsize% * player(pn%).dir, player(pn%).y + 5 + SIN( _
player(pn%).a) * playeraimsize%, pn%)
END SUB

SUB EraseSpr (x%, y%, sn%)
'Erases a sprite from the screen.

FOR yy% = 0 TO 7
 FOR xx% = 0 TO 7
  p% = ammospr(sn%, xx% + 8 * yy%)
  IF p% > 0 THEN
   p% = BPoint%(x% + xx%, y% + yy%, 0)
   PSET (x% + xx%, y% + yy%), p%
  END IF
 NEXT xx%
NEXT yy%
END SUB

SUB FadePal (fr%, fg%, fb%, i%, c1%, c2%)
'Create the screen's palette as a blend between the current Game Palette
'and a given color.
'fr%, fg%, and fb% are the values for the color to blend with.
'i% is a number from 0 to 100 that sets the amount of true
'Game Palette (so 0 would be 100% blend color and 100 would be 100% Game Palette).
'c1% and c2% set the range of colors to be affected by the blend.

FOR c% = c1% TO c2%
 r% = (gamepal(c%).r / 100) * i% + (fr% / 100) * (100 - i%)
 g% = (gamepal(c%).g / 100) * i% + (fg% / 100) * (100 - i%)
 B% = (gamepal(c%).B / 100) * i% + (fb% / 100) * (100 - i%)
 OUT &H3C8, c%
 OUT &H3C9, r%
 OUT &H3C9, g%
 OUT &H3C9, B%
NEXT c%
END SUB

SUB Font (text$, xstart%, ystart%, xscale!, yscale!, style%, tclr%)
'Draws font to the screen.
'The styles can be seen below, more can be added easily.

DEF SEG = VARSEG(fontbuf(0))
FOR h% = 1 TO LEN(text$)
 fptr% = 81 * (ASC(MID$(text$, h%, 1)) - 1)
 FOR y% = 0 TO 8
  FOR x% = 0 TO 8
   col% = PEEK(VARPTR(fontbuf(0)) + fptr% + x% + 9 * y%)
   IF col% THEN
    px% = xstart% + x% * xscale! + (h% - 1) * 8 * xscale!
    py% = ystart% + y% * yscale!
    SELECT CASE style%

     CASE 1
      LINE (px%, py%)-(px% + xscale! - 1, py% + yscale! - 1), (py% - ystart%) / yscale! + tclr%, BF

     CASE 2
      LINE (px%, py%)-(px% + xscale! - 1, py% + yscale! - 1), (py% - ystart%) / yscale! + tclr%, BF
      x2% = x% + 1
      y2% = y% + 1
      col2% = PEEK(VARPTR(fontbuf(0)) + fptr% + x2% + 9 * y2%)
      IF x2% < 0 OR x2% > 8 OR y2% < 0 OR y2% > 8 THEN col2% = 0
      IF col2% = 0 THEN
       px% = xstart% + x2% * xscale! + (h% - 1) * 8 * xscale!
       py% = ystart% + y2% * yscale!
       LINE (px%, py%)-(px% + xscale! - 1, py% + yscale! - 1), (py% - ystart%) / yscale! + tclr% - 4, BF
      END IF
      x2% = x% + 2
      y2% = y% + 2
      col2% = PEEK(VARPTR(fontbuf(0)) + fptr% + x2% + 9 * y2%)
      IF x2% < 0 OR x2% > 8 OR y2% < 0 OR y2% > 8 THEN col2% = 0
      IF col2% = 0 THEN
       px% = xstart% + x2% * xscale! + (h% - 1) * 8 * xscale!
       py% = ystart% + y2% * yscale!
       LINE (px%, py%)-(px% + xscale! - 1, py% + yscale! - 1), (py% - ystart%) / yscale! + tclr% - 8, BF
      END IF
    
     CASE 3
      LINE (px%, py%)-(px% + xscale! - 1, py% + yscale! - 1), (py% - ystart%) / yscale! + tclr%, BF
      FOR yc% = -1 TO 1
       FOR xc% = -1 TO 1
        x2% = x% + xc%
        y2% = y% + yc%
        col2% = PEEK(VARPTR(fontbuf(0)) + fptr% + x2% + 9 * y2%)
        IF x2% < 0 OR x2% > 8 OR y2% < 0 OR y2% > 8 THEN col2% = 0
        IF col2% = 0 THEN
         px% = xstart% + x2% * xscale! + (h% - 1) * 8 * xscale!
         py% = ystart% + y2% * yscale!
         LINE (px%, py%)-(px% + xscale! - 1, py% + yscale! - 1), (py% - ystart%) / yscale! + tclr% - 6, BF
        END IF
       NEXT xc%
      NEXT yc%
     
     CASE 4
      LINE (px%, py%)-(px% + xscale! - 1, py% + yscale! - 1), (py% - ystart%) / yscale! + tclr% - 6, BF
      FOR yc% = -1 TO 1
       FOR xc% = -1 TO 1
        x2% = x% + xc%
        y2% = y% + yc%
        col2% = PEEK(VARPTR(fontbuf(0)) + fptr% + x2% + 9 * y2%)
        IF x2% < 0 OR x2% > 8 OR y2% < 0 OR y2% > 8 THEN col2% = 0
        IF col2% = 0 THEN
         px% = xstart% + x2% * xscale! + (h% - 1) * 8 * xscale!
         py% = ystart% + y2% * yscale!
         LINE (px%, py%)-(px% + xscale! - 1, py% + yscale! - 1), 7 - 2 * yscale! - (py% - ystart%) / yscale! + tclr%, BF
        END IF
       NEXT xc%
      NEXT yc%
    
    END SELECT
   END IF
   py! = py! + yscale!
  NEXT
  px! = px! + xscale!
  py! = ystart%
 NEXT
NEXT h%
DEF SEG
END SUB

SUB GetBlaster (dma%, baseport%, irq%)
'Gets the Sound Blaster information.

IF LEN(ENVIRON$("BLASTER")) = 0 THEN
 PRINT "BLASTER environment variable not set."
 EXIT SUB
END IF
FOR length% = 1 TO LEN(ENVIRON$("BLASTER"))
 SELECT CASE MID$(ENVIRON$("BLASTER"), length%, 1)
  CASE "A"
   baseport% = VAL("&H" + MID$(ENVIRON$("BLASTER"), length% + 1, 3))
  CASE "I"
   irq% = VAL(MID$(ENVIRON$("BLASTER"), length% + 1, 1))
  CASE "D"
   dma% = VAL(MID$(ENVIRON$("BLASTER"), length% + 1, 1))
 END SELECT
NEXT
END SUB

SUB InitBullet (c%, x%, y%, a#, d%, p%, s%)
'Inititializes a bullet object.
'c% = bullet class
'x% and y% are coordinates
'a# = angle
'd% = direction
'p% = power
's% = setting

FOR i% = 1 TO maxbullets%
 IF bullet(i%).class = 0 THEN
  bullet(i%).class = c%
  bullet(i%).xi = x%
  bullet(i%).yi = y%
  bullet(i%).x = x%
  bullet(i%).y = y%
  bullet(i%).a = a#
  bullet(i%).dir = d%
  bullet(i%).p = p%
  bullet(i%).tim = TIMER - .1
  bullet(i%).set = s%
  EXIT FOR
 END IF
NEXT i%
END SUB

SUB InitGame
'Initializes the game.

RANDOMIZE TIMER
LoadCfg game.cfgfile
LoadKey game.keyfile
RESTORE teaminfo
FOR i% = 0 TO maxplayers%
 READ l$
 team(i%).nam = l$
 READ x%
 team(i%).clr = x%
NEXT i%
END SUB

SUB InitGamePal
'Initializes the Game Palette.

FOR c% = 221 TO 230
 gamepal(c%).r = 62
 gamepal(c%).g = 62
 gamepal(c%).B = 62
NEXT c%
FOR c% = 231 TO 240
 gamepal(c%).r = pal(2).r + (c% - 231) * (pal(3).r - pal(2).r) / 10
 gamepal(c%).g = pal(2).g + (c% - 231) * (pal(3).g - pal(2).g) / 10
 gamepal(c%).B = pal(2).B + (c% - 231) * (pal(3).B - pal(2).B) / 10
NEXT c%
gamepal(241).B = pal(1).r
gamepal(241).B = pal(1).g
gamepal(241).B = pal(1).B
SetBlastPal
END SUB

SUB InitPlayers
'Initializes the players.

DIM playeract(1 TO maxplayers%) AS INTEGER

player(0).aj = -1.2
player(0).pj = 30
mnum% = 0
FOR i% = 1 TO maxplayers%
 playeract(i%) = 0
 player(i%).health = 0
 IF player(i%).tnum > 0 THEN
  mnum% = mnum% + 1
  playeract(mnum%) = i%
 END IF
NEXT i%
FOR i% = 1 TO mnum%
 IF player(playeract(i%)).tnum > 0 THEN
  x% = 320 / (mnum% + 1) * i%
  player(playeract(i%)).x = x%
  FOR y% = 0 TO 200
   FOR xx% = x% TO x% + 7
    IF TPoint%(xx%, y% + 7, i%) <> 241 THEN
     GOTO playerland
    END IF
   NEXT xx%
  NEXT y%
playerland:
  player(playeract(i%)).y = y%
  player(playeract(i%)).a = 0
  player(playeract(i%)).bul = 1
  player(playeract(i%)).dir = 1
  player(playeract(i%)).health = player(0).health
  player(playeract(i%)).dam = 0
  player(playeract(i%)).jump = 0
  FOR ii% = 1 TO maxweapons%
   playpack(playeract(i%), ii%).ammo = playpack(0, ii%).ammo
   playpack(playeract(i%), ii%).set = playpack(0, ii%).set
  NEXT ii%
 END IF
NEXT i%
END SUB

SUB InitScr
'Initializes the screen.

SCREEN 13
COLOR 28
FOR c% = 0 TO 255
 OUT &H3C7, c%
 defpal(c%).r = INP(&H3C9)
 defpal(c%).g = INP(&H3C9)
 defpal(c%).B = INP(&H3C9)
NEXT c%
FadePal 0, 0, 0, 0, 0, 255
LoadSprites game.sprfile
LoadFont game.fntfile
END SUB

FUNCTION KeyMark% (k$)
'Returns the code for the key pressed.

ii% = 0
FOR i% = 1 TO 11 + maxweapons%
 IF k$ = keycode(i%) THEN
  ii% = i%
  EXIT FOR
 END IF
NEXT i%
KeyMark% = ii%
END FUNCTION

FUNCTION KeyName$ (k$)
'Returns the common name for the keycode.

DIM kn AS STRING * 10

SELECT CASE UCASE$(k$)
 CASE CHR$(0) + "H"
  kn = "Up"
 CASE CHR$(0) + "P"
  kn = "Down"
 CASE CHR$(0) + "K"
  kn = "Left"
 CASE CHR$(0) + "M"
  kn = "Right"
 CASE CHR$(13)
  kn = "Enter"
 CASE CHR$(27)
  kn = "Esc"
 CASE CHR$(32)
  kn = "Space"
 CASE CHR$(0) + CHR$(59)
  kn = "F1"
 CASE CHR$(0) + CHR$(60)
  kn = "F2"
 CASE CHR$(0) + CHR$(61)
  kn = "F3"
 CASE CHR$(0) + CHR$(62)
  kn = "F4"
 CASE CHR$(0) + CHR$(63)
  kn = "F5"
 CASE CHR$(0) + CHR$(64)
  kn = "F6"
 CASE CHR$(0) + CHR$(65)
  kn = "F7"
 CASE CHR$(0) + CHR$(66)
  kn = "F8"
 CASE ELSE
  kn = UCASE$(k$)

END SELECT
KeyName$ = kn
END FUNCTION

SUB LoadCfg (file$)
'Loads the Configuration file.

OPEN file$ FOR INPUT AS #1
CLS
nextline:
LINE INPUT #1, l$
IF LCASE$(l$) = "/end" THEN GOTO lastline
s1% = INSTR(l$, " ")
c1$ = LEFT$(l$, s1% - 1)
SELECT CASE LCASE$(c1$)

 CASE "player"
  c2$ = MID$(l$, s1% + 1, 1)
  c3$ = RIGHT$(l$, LEN(l$) - s1% - 2)
  player(VAL(c2$)).nam = c3$

 CASE "teams"
  c2$ = RIGHT$(l$, LEN(l$) - s1%)
  player(1).tnum = VAL(MID$(c2$, 1, 1))
  player(2).tnum = VAL(MID$(c2$, 3, 1))
  player(3).tnum = VAL(MID$(c2$, 5, 1))
  player(4).tnum = VAL(MID$(c2$, 7, 1))
  player(5).tnum = VAL(MID$(c2$, 9, 1))
  player(6).tnum = VAL(MID$(c2$, 11, 1))
  player(7).tnum = VAL(MID$(c2$, 13, 1))
  player(8).tnum = VAL(MID$(c2$, 15, 1))

 CASE "health"
  c2$ = RIGHT$(l$, LEN(l$) - s1%)
  player(0).health = VAL(c2$)

 CASE "pack.cannon"
  c2$ = RIGHT$(l$, LEN(l$) - s1%)
  playpack(0, 1).ammo = VAL(c2$)
  playpack(0, 1).set = 1

 CASE "pack.grenade"
  c2$ = RIGHT$(l$, LEN(l$) - s1%)
  playpack(0, 2).ammo = VAL(c2$)
  playpack(0, 2).set = 2

 CASE "pack.mine"
  c2$ = RIGHT$(l$, LEN(l$) - s1%)
  playpack(0, 3).ammo = VAL(c2$)
  playpack(0, 3).set = 1

 CASE "pack.gluer"
  c2$ = RIGHT$(l$, LEN(l$) - s1%)
  playpack(0, 4).ammo = VAL(c2$)
  playpack(0, 4).set = 1

 CASE "pack.flamer"
  c2$ = RIGHT$(l$, LEN(l$) - s1%)
  playpack(0, 5).ammo = VAL(c2$)
  playpack(0, 5).set = 1

 CASE "pack.booster"
  c2$ = RIGHT$(l$, LEN(l$) - s1%)
  playpack(0, 6).ammo = VAL(c2$)
  playpack(0, 6).set = 1

 CASE "pack.cluster"
  c2$ = RIGHT$(l$, LEN(l$) - s1%)
  playpack(0, 7).ammo = VAL(c2$)
  playpack(0, 7).set = 3

 CASE "ammo.drops"
  c2$ = RIGHT$(l$, LEN(l$) - s1%)
  config.ammodrop = VAL(c2$)

 CASE "sound.volume"
  c2$ = RIGHT$(l$, LEN(l$) - s1%)
  config.snd = VAL(c2$)

 CASE "sound.back"
  c2$ = RIGHT$(l$, 1)
  config.sndb = VAL(c2$)

END SELECT
GOTO nextline:
lastline:
CLOSE #1
END SUB

SUB LoadFont (file$)
'Loads the Font file.

OPEN file$ FOR BINARY AS #1
IF LOF(1) < 2 THEN
 NoFile% = 1
END IF
IF NoFile% <> 1 THEN GET #1, , fontbuf(0)
CLOSE #1
IF NoFile% THEN
 KILL file$
 CLS
 PRINT "The font data file couldn't be found!"
 PRINT
 PRINT "Would you like to create one? (Y/N)"
 INPUT "> ", Choice$
 IF UCASE$(Choice$) = "N" THEN
  PRINT "The program cannot run without this file!"
  SYSTEM
 ELSE
  PRINT "Hit a key to make the file."
  PRINT "You will hear a beep if it is working."
  Pause
 
  OPEN file$ FOR BINARY AS #1
  COLOR 16
  FOR ascii% = 1 TO 128
   CLS
   PRINT CHR$(ascii%)
   FOR x = 0 TO 8
    FOR y = 0 TO 8
     pnt$ = CHR$(POINT(x, y))
     PUT #1, , pnt$
     pnt$ = ""
    NEXT
   NEXT
  NEXT
  CLOSE #1
  OPEN file$ FOR BINARY AS #1
  GET #1, , fontbuf(0)
  CLOSE #1
 END IF
END IF
END SUB

SUB LoadKey (file$)
'Loads the Key file.

OPEN file$ FOR RANDOM AS #1
FOR i% = 1 TO 6
 GET #1, i%, k$
 keycode(i%) = k$
NEXT i%
keyact(1) = "Walk Left"
keyact(2) = "Walk Right"
keyact(3) = "Aim Up"
keyact(4) = "Aim Down"
keyact(5) = "Fire"
keyact(6) = "Jump"

keyact(7) = "Set 1"
keycode(7) = "1"
keyact(8) = "Set 2"
keycode(8) = "2"
keyact(9) = "Set 3"
keycode(9) = "3"
keyact(10) = "Quit"
keycode(10) = CHR$(27)
keyact(11) = "Skip Turn"
keycode(11) = CHR$(8)

keyact(12) = "Cannon"
keycode(12) = CHR$(0) + CHR$(&H3B)
keyact(13) = "Grenade"
keycode(13) = CHR$(0) + CHR$(&H3C)
keyact(14) = "Mine"
keycode(14) = CHR$(0) + CHR$(&H3D)
keyact(15) = "Gluer"
keycode(15) = CHR$(0) + CHR$(&H3E)
keyact(16) = "Flamer"
keycode(16) = CHR$(0) + CHR$(&H3F)
keyact(17) = "Booster"
keycode(17) = CHR$(0) + CHR$(&H40)
keyact(18) = "Cluster"
keycode(18) = CHR$(0) + CHR$(&H41)
CLOSE #1
END SUB

SUB LoadLevel (file$)
'Loads a Level file.

OPEN file$ FOR INPUT AS #1
LINE INPUT #1, l$
level.nam = l$
LINE INPUT #1, l$
turffile$ = l$
LINE INPUT #1, l$
backfile$ = l$
LINE INPUT #1, l$
level.grav = VAL(l$)
LINE INPUT #1, l$
level.sndb = l$
CLOSE #1
DEF SEG = &HA000
BLOAD turffile$, 0
DEF SEG
GET (0, 0)-(319, 199), turfbuf
DEF SEG = VARSEG(backbuf(0))
BLOAD "backgrnd\" + backfile$, 0
DEF SEG
END SUB

SUB LoadSprites (file$)
'Loads the Sprite file.

OPEN file$ FOR INPUT AS #1
nextsprite:
INPUT #1, n%
IF n% = -1 THEN GOTO endsprite
FOR y% = 0 TO 7
 FOR x% = 0 TO 7
  INPUT #1, p%
  IF n% = 0 THEN
   playerspr(x% + 8 * y%) = p%
  ELSEIF n% = 100 THEN
   ammospr(0, x% + 8 * y%) = p%
  ELSE
   ammospr(n%, x% + 8 * y%) = p%
  END IF
 NEXT x%
NEXT y%
GOTO nextsprite
endsprite:
CLOSE #1

RESTORE smallnums
FOR i% = 0 TO 9
 FOR y% = 0 TO 4
  FOR x% = 0 TO 2
   READ p%
   smallnum(i%, x% + 3 * y%) = p%
  NEXT x%
 NEXT y%
NEXT i%
END SUB

SUB Main
'Main game procedure.

FOR y% = 0 TO 199
 FOR x% = 0 TO 319
  DEF SEG = VARSEG(turfbuf(0))
  p% = PEEK(x% + 320& * y% + 4)
  DEF SEG
  IF p% = 241 THEN
   DEF SEG = VARSEG(backbuf(0))
   p% = PEEK(x% + 320& * y%)
   DEF SEG
  END IF
  PSET (x%, y%), p%
 NEXT x%
NEXT y%

InitPlayers
FOR i% = 1 TO maxbullets%
 bullet(i%).class = 0
NEXT i%
FOR c% = 0 TO 100
 FadePal 0, 0, 0, c%, 0, 255
NEXT c%

level.turn = 0
level.wind = RND * 40 - 20
level.quit = 0

newloop:
nextcheck:
level.turn = level.turn + 1
IF level.turn > maxplayers% THEN
 level.turn = 1
 level.wind = RND * 40 - 20
END IF
IF player(level.turn).health = 0 THEN GOTO nextcheck

level.fire = 0
FOR i% = 1 TO maxplayers%
 IF player(i%).health > 0 THEN
  DrawPlayer i%
 END IF
NEXT i%
DrawBar
IF RND < config.ammodrop THEN
 x% = RND * 300 + 10
 i% = CINT(RND * (maxweapons% - 1)) + 1
 ii% = RND * 2 + 1
 IF config.snd THEN
  WAVPlay "jet.wav", 11000
  DO
  LOOP UNTIL DMADone%
 END IF
 InitBullet -100, x%, 0, 0, ii%, 0, i%
END IF
FOR i% = 1 TO 4
 key$ = INKEY$
NEXT i%

startloop:
IF config.snd AND config.sndb THEN
 IF DMADone% THEN
  WAVPlay level.sndb, 11000
 END IF
END IF

level.nofly = 1
PlayerKey
level.tim = TIMER
PlayerFall
BulletMove

IF level.quit = 1 THEN
 EXIT SUB
END IF
IF level.nofly AND (level.fire OR player(level.turn).health = 0) THEN GOTO nextplayer

GOTO startloop

nextplayer:
DoneTurn
y% = 0
FOR i% = 1 TO maxplayers%
 team(i%).act = 0
 FOR ii% = 1 TO maxplayers%
  IF player(ii%).tnum = i% AND player(ii%).health > 0 THEN
   team(i%).act = 1
   y% = i%
  END IF
 NEXT ii%
NEXT i%
x% = 0
FOR i% = 1 TO maxplayers%
 x% = x% + team(i%).act
NEXT i%
IF x% = 1 THEN
 Win y%
 EXIT SUB
ELSEIF x% = 0 THEN
 Win 0
 EXIT SUB
END IF

ErasePlayer level.turn
GOTO newloop
END SUB

SUB MasterVolume (Right%, Left%, GetVol%)
'Sets the volume for the Sound Blaster.

OUT baseport% + 4, &H22
IF GetVol% THEN
 Left% = INP(baseport% + 5) \ 16
 Right% = INP(baseport% + 5) AND &HF
 EXIT SUB
ELSE
 OUT baseport% + 5, (Right% + Left% * 16) AND &HFF
END IF
END SUB

SUB Menu (mnum%)
'Creates a menu.
'The menuitem variables (1 up to 10) are strings which are the menu items.
'menuitem(0) is the menu title.
'When Menu is called, mnum% should be the largest number of menuitem that
'is used for that menu.  It will return mnum% as the menu item chosen.

moff% = 0
CLS
Font menuitem(0), 160 - (LEN(menuitem(0)) / 2) * 16, 10, 2, 2, 3, menuclr% + 8
mmax% = mnum%
IF mmax% > 7 THEN mmax% = 7
FOR i% = 0 TO 5
 LINE (i%, 45 + i%)-(319 - i%, mmax% * 20 + 63 - i%), menuclr% + i%, B
NEXT i%

i% = 1
FOR c% = 0 TO 100
 FadePal 0, 0, 0, c%, 0, 31
NEXT c%
drawmenu:
LINE (6, 51)-(313, mmax% * 20 + 57), 0, BF
FOR ii% = moff% + 1 TO moff% + mmax%
 c% = menuclr%
 IF ii% = i% THEN c% = menuclr% + 5
 Font menuitem(ii%), 160 - (LEN(menuitem(ii%)) / 2) * 8, (ii% - moff%) * 20 + 40, 1, 1, 1, c%
NEXT ii%
IF moff% > 0 THEN
 FOR ii% = 0 TO 5
  LINE (300 - (5 - ii%), 60 - ii%)-(300 + (5 - ii%), 60 - ii%), 18 + ii% * 2
 NEXT ii%
END IF
IF moff% + mmax% < mnum% THEN
 FOR ii% = 0 TO 5
  LINE (300 - (5 - ii%), ii% + 190)-(300 + (5 - ii%), ii% + 190), 18 + ii% * 2
 NEXT ii%
END IF
DO
 key$ = INKEY$
 SELECT CASE key$
  CASE CHR$(27)
   IF config.snd THEN
    WAVPlay "menua.wav", 11000
   END IF
   i% = -1
   EXIT DO
 
  CASE CHR$(0) + "H"
   i% = i% - 1
   IF i% = 0 THEN i% = mnum%
   moff% = i% - 4
   IF moff% + 7 > mnum% THEN moff% = mnum% - 7
   IF moff% < 0 THEN moff% = 0
   IF config.snd THEN
    WAVPlay "menub.wav", 11000
   END IF
   GOTO drawmenu

  CASE CHR$(0) + "P"
   i% = i% + 1
   IF i% = mnum% + 1 THEN i% = 1
   moff% = i% - 4
   IF moff% + 7 > mnum% THEN moff% = mnum% - 7
   IF moff% < 0 THEN moff% = 0
   IF config.snd THEN
    WAVPlay "menub.wav", 11000
   END IF
   GOTO drawmenu
  
  CASE CHR$(13)
   IF config.snd THEN
    WAVPlay "menua.wav", 11000
   END IF
   EXIT DO

 END SELECT
 IF RND < .00005 THEN
  x% = RND * 250 + 60
  y% = RND * 40
  d% = RND * 10 + 10
  IF RND < .1 THEN
   s% = 1
   FOR ii% = 1 TO maxsparks%
    spark(ii%).r = 0
    spark(ii%).a = ((2 * pi#) / maxsparks%) * ii%
   NEXT ii%
  ELSE
   s% = 0
  END IF
  FOR ii% = 1 TO maxbullets%
   IF bullet(ii%).class = 0 THEN
    bullet(ii%).class = -1
    bullet(ii%).x = x%
    bullet(ii%).y = y%
    bullet(ii%).a = 0
    bullet(ii%).dir = d%
    bullet(ii%).p = 1
    bullet(ii%).set = s%
    IF config.snd THEN
     IF RND < .5 THEN
      WAVPlay "explode.wav", 11000
     ELSE
      WAVPlay "blast.wav", 11000
     END IF
    END IF
    EXIT FOR
   END IF
  NEXT ii%
 END IF
 FOR B% = 1 TO maxbullets%
  IF bullet(B%).class = -1 THEN
   level.nofly = 0
   x% = bullet(B%).x
   y% = bullet(B%).y
   c% = 220 - (bullet(B%).a / bullet(B%).dir) * 20
   IF bullet(B%).p = -1 THEN c% = 0
   FOR r! = 0 TO pi# * 2 STEP .05
    p% = POINT(x% + COS(r!) * bullet(B%).a + 3, y% + SIN(r!) * bullet(B%).a + 3)
    IF p% = 0 OR p% >= 200 THEN
     PSET (x% + COS(r!) * bullet(B%).a + 3, y% + SIN(r!) * bullet(B%).a + 3), c%
    END IF
   NEXT r!
   bullet(B%).a = bullet(B%).a + .5 * bullet(B%).p
   IF bullet(B%).p = 1 AND bullet(B%).a >= bullet(B%).dir THEN
    bullet(B%).p = -1
   END IF
   IF bullet(B%).set = 1 THEN
    FOR ii% = 1 TO maxsparks%
     sx% = bullet(B%).x + 3 + spark(ii%).r * COS(spark(ii%).a)
     sy% = bullet(B%).y + 3 + .3 * (spark(ii%).r * SIN(spark(ii%).a))
     p% = POINT(sx%, sy%)
     IF p% >= 200 THEN
      PSET (sx%, sy%), 0
     END IF
     spark(ii%).r = spark(ii%).r + 2
     sx% = bullet(B%).x + 3 + spark(ii%).r * COS(spark(ii%).a)
     sy% = bullet(B%).y + 3 + .3 * (spark(ii%).r * SIN(spark(ii%).a))
     c% = 220 - spark(ii%).r / 3
     IF c% < 200 THEN c% = 200
     IF bullet(B%).p = -1 AND bullet(B%).a < 0 THEN c% = 0
     p% = POINT(sx%, sy%)
     IF p% = 0 THEN
      PSET (sx%, sy%), c%
     END IF
    NEXT ii%
   END IF
   IF bullet(B%).p = -1 AND bullet(B%).a < 0 THEN
    bullet(B%).class = 0
   END IF
  END IF
 NEXT B%
LOOP
mnum% = i%
FOR c% = 100 TO 0 STEP -1
 FadePal 0, 0, 0, c%, 0, 31
NEXT c%
END SUB

SUB Pause
'Pauses the game until enter is pressed.

DO
 key$ = INKEY$
LOOP UNTIL key$ = ""
DO
 key$ = INKEY$
LOOP UNTIL key$ = CHR$(13)
DO
 key$ = INKEY$
LOOP UNTIL key$ = ""
END SUB

SUB PlayerFall
'Makes a player fall if necessary.

FOR pn% = 1 TO maxplayers%
 IF player(pn%).health > 0 OR player(pn%).dam THEN
  t# = (level.tim - player(pn%).tim) * bulletspd%
  x% = player(pn%).x
  y% = player(pn%).y
  IF player(pn%).jump > 0 THEN
   level.nofly = 0
   ErasePlayer pn%
   player(pn%).x = player(pn%).xi + t# * COS(player(pn%).aj) * player(pn%).pj * player(pn%).dir
   player(pn%).y = player(pn%).yi + t# * SIN(player(pn%).aj) * player(pn%).pj + 16 * t# ^ 2 * level.grav
   DrawPlayer pn%
   IF player(pn%).jump = 2 THEN
    c% = 220 - t# * 20
    LINE (player(pn%).x + 1, player(pn%).y + 7)-(player(pn%).x + 6, player(pn%).y + 7), c%
    IF t# >= 1 THEN player(pn%).jump = 1
   END IF
  END IF
  IF player(pn%).x < -7 OR player(pn%).x > 320 OR player(pn%).y > 205 THEN
   IF config.snd THEN
    WAVPlay "fall.wav", 11000
   END IF
   player(pn%).dam = 0
   player(pn%).health = 0
  END IF
 
  bump$ = TurfBump$(x%, y%, -1)
  'Uncomment this to help you see where the player is colliding with turf
  'IF pn% = level.turn THEN
  '  LINE (10, 180)-(14, 180), 18
  '  IF MID$(bump$, 1, 1) = "1" THEN LINE (10, 180)-(14, 180), 15
  '  LINE (16, 180)-(20, 180), 18
  '  IF MID$(bump$, 2, 1) = "1" THEN LINE (16, 180)-(20, 180), 15
  '  LINE (21, 181)-(21, 184), 18
  '  IF MID$(bump$, 3, 1) = "1" THEN LINE (21, 181)-(21, 184), 15
  '  LINE (21, 186)-(21, 189), 18
  '  IF MID$(bump$, 4, 1) = "1" THEN LINE (21, 186)-(21, 189), 15
  '  LINE (16, 190)-(20, 190), 18
  '  IF MID$(bump$, 5, 1) = "1" THEN LINE (16, 190)-(20, 190), 15
  '  LINE (10, 190)-(14, 190), 18
  '  IF MID$(bump$, 6, 1) = "1" THEN LINE (10, 190)-(14, 190), 15
  '  LINE (9, 186)-(9, 189), 18
  '  IF MID$(bump$, 7, 1) = "1" THEN LINE (9, 186)-(9, 189), 15
  '  LINE (9, 181)-(9, 184), 18
  '  IF MID$(bump$, 8, 1) = "1" THEN LINE (9, 181)-(9, 184), 15
  'END IF
 
  SELECT CASE bump$
   CASE "00000000"
    IF player(pn%).jump = 0 THEN
     player(pn%).tim = level.tim - .2
     player(pn%).jump = 1
     player(pn%).xi = x%
     player(pn%).yi = y%
     player(pn%).pj = 0
     t# = (level.tim - player(pn%).tim) * bulletspd%
    END IF

   CASE "11100011", "11000001", "10000000", "00000010", "00000001", "00000011", "10000011", "00000111", "10000111", "11001111", "10001111", "11000111", "10000001", "11001111", "11101111", "11000001", "11000011"
    IF player(pn%).jump > 0 AND player(pn%).dir = -1 THEN
     xc% = t# * COS(player(pn%).aj) * player(pn%).pj * -player(pn%).dir
     player(pn%).xi = x% - xc%
     ErasePlayer pn%
     player(pn%).dir = 1
     DrawPlayer pn%
     IF config.snd THEN
      WAVPlay "bounce.wav", 11000
     END IF
    END IF

   CASE "11110001", "11100000", "01000000", "00100000", "00010000", "00110000", "01110000", "00111000", "01111000", "11111100", "01111100", "11111000", "01100000", "11111100", "11111110", "11100000", "11110000"
    IF player(pn%).jump > 0 AND player(pn%).dir = 1 THEN
     xc% = t# * COS(player(pn%).aj) * player(pn%).pj * -player(pn%).dir
     player(pn%).xi = x% - xc%
     ErasePlayer pn%
     player(pn%).dir = -1
     DrawPlayer pn%
     IF config.snd THEN
      WAVPlay "bounce.wav", 11000
     END IF
    END IF
  
   CASE "11000000", "11100001", "11110011"
   ' IF player(pn%).jump > 0 THEN
   '  nt# = 2 * p% * SIN(player(pn%).aj) / (2 * (16 * level.grav))
   '  xc% = t# * COS(player(pn%).aj) * player(pn%).pj * player(pn%).dir
   '  player(pn%).xi = x% - xc%
   '  IF config.snd THEN
   '   WAVPlay "bounce.wav", 11000
   '  END IF
   ' END IF
  
   'CASE "11111111", "01111111", "10111111", "00000100", "00000010", "00000110", "00001110", "00011100", "00011110", "00111111", "00011111", "00111110", "00001111", "10011111", "00011000", "00111100", "01111110", "11011111", "11111110"
   CASE ELSE
    IF player(pn%).jump > 0 THEN
     player(pn%).jump = 0
     IF 16 * t# ^ 2 * level.grav > 140 THEN
      Damage pn%, (16 * t# ^ 2 * level.grav - 140) / 2
      IF pn% = level.turn THEN level.fire = 1
      IF config.snd THEN
       WAVPlay "crash.wav", 11000
      END IF
     ELSEIF 16 * t# ^ 2 * level.grav > 10 THEN
      IF config.snd THEN
       WAVPlay "land.wav", 11000
      END IF
     END IF
    END IF
  END SELECT
 END IF
NEXT pn%
END SUB

SUB PlayerKey
'Gets the key that was pressed and processes it.

key$ = INKEY$
k% = KeyMark%(key$)
SELECT CASE k%
 CASE 1
  IF player(level.turn).glued = 0 THEN
   IF player(level.turn).jump THEN
    IF player(level.turn).dir = 1 THEN
     ErasePlayer level.turn
     player(level.turn).xi = player(level.turn).xi + 2 * (player(level.turn).x - player(level.turn).xi)
     player(level.turn).dir = -1
     DrawPlayer level.turn
    END IF
   ELSE
    FOR y% = 0 TO playerstep%
     IF TPoint%(player(level.turn).x - 1, player(level.turn).y + 7 - y%, level.turn) = 241 THEN EXIT FOR
    NEXT y%
    IF y% <= playerstep% THEN
     IF config.snd THEN
      IF DMADone% AND config.sndb = 0 THEN
       WAVPlay "crawl.wav", 11000
      END IF
     END IF
     ErasePlayer level.turn
     player(level.turn).x = player(level.turn).x - 1
     player(level.turn).y = player(level.turn).y - y%
     player(level.turn).dir = -1
     DrawPlayer level.turn
    END IF
   END IF
  END IF

 CASE 2
  IF player(level.turn).glued = 0 THEN
   IF player(level.turn).jump THEN
    IF player(level.turn).dir = -1 THEN
     ErasePlayer level.turn
     player(level.turn).xi = player(level.turn).xi + 2 * (player(level.turn).x - player(level.turn).xi)
     player(level.turn).dir = 1
     DrawPlayer level.turn
    END IF
   ELSE
    FOR y% = 0 TO playerstep%
     IF TPoint%(player(level.turn).x + 8, player(level.turn).y + 7 - y%, level.turn) = 241 THEN EXIT FOR
    NEXT y%
    IF y% <= playerstep% THEN
     IF config.snd THEN
      IF DMADone% AND config.sndb = 0 THEN
       WAVPlay "crawl.wav", 11000
      END IF
     END IF
     ErasePlayer level.turn
     player(level.turn).x = player(level.turn).x + 1
     player(level.turn).y = player(level.turn).y - y%
     player(level.turn).dir = 1
     DrawPlayer level.turn
    END IF
   END IF
  END IF
 
 CASE 3
  IF config.snd THEN
   IF DMADone% AND config.sndb = 0 THEN
    WAVPlay "aim.wav", 11000
   END IF
  END IF
  ErasePlayer level.turn
  player(level.turn).a = player(level.turn).a - playeraim!
  IF player(level.turn).a < -pi# / 2 THEN player(level.turn).a = -pi# / 2
  DrawPlayer level.turn

 CASE 4
  IF config.snd THEN
   IF DMADone% AND config.sndb = 0 THEN
    WAVPlay "aim.wav", 11000
   END IF
  END IF
  ErasePlayer level.turn
  player(level.turn).a = player(level.turn).a + playeraim!
  IF player(level.turn).a > pi# / 2 THEN player(level.turn).a = pi# / 2
  DrawPlayer level.turn

 CASE 5
  IF level.fire = 0 AND player(level.turn).jump = 0 THEN
   IF player(level.turn).bul = 1 THEN
    IF playpack(level.turn, 1).ammo >= playpack(level.turn, 1).set THEN
     playpack(level.turn, 1).ammo = playpack(level.turn, 1).ammo - playpack(level.turn, 1).set
     power% = 0
     IF config.snd THEN
      WAVPlay "power.wav", 11000
     END IF
     DO
      key$ = INKEY$
      IF KeyMark%(key$) = 5 THEN EXIT DO
      LINE (220 + power%, 5)-(220 + power%, 6), 200 + power% / 3
      power% = power% + 1
      FOR z& = -32000 TO 32000
      NEXT z&
      IF power% = 60 THEN EXIT DO
     LOOP
     LINE (220, 5)-(280, 6), 0, BF
     power% = maxpower% * (power% / 60)
     FOR i% = 1 TO playpack(level.turn, 1).set
      InitBullet 1, player(level.turn).x, player(level.turn).y, player(level.turn).a - ((1 / playpack(level.turn, 1).set - 1) * .05) + ((i% - 1) * .1), player(level.turn).dir, power%, playpack(level.turn, 1).set
      DrawSpr player(level.turn).x, player(level.turn).y, 1
     NEXT i%
     IF config.snd THEN
      WAVPlay "launch.wav", 11000
     END IF
     level.fire = 1
    ELSE
     IF config.snd THEN
      WAVPlay "buzzer.wav", 11000
     END IF
    END IF
   END IF
 
   IF player(level.turn).bul = 2 THEN
    IF playpack(level.turn, 2).ammo > 0 THEN
     playpack(level.turn, 2).ammo = playpack(level.turn, 2).ammo - 1
     power% = 0
     IF config.snd THEN
      WAVPlay "power.wav", 11000
     END IF
     DO
      key$ = INKEY$
      IF KeyMark%(key$) = 5 THEN EXIT DO
      LINE (220 + power%, 5)-(220 + power%, 6), 200 + power% / 3
      power% = power% + 1
      FOR z& = -32000 TO 32000
      NEXT z&
      IF power% = 60 THEN EXIT DO
     LOOP
     LINE (220, 5)-(280, 6), 0, BF
     power% = maxpower% * (power% / 60)
     InitBullet 2, player(level.turn).x, player(level.turn).y, player(level.turn).a, player(level.turn).dir, power%, playpack(level.turn, 2).set * 2500
     DrawSpr player(level.turn).x, player(level.turn).y, 2
     IF config.snd THEN
      WAVPlay "launch.wav", 11000
     END IF
     level.fire = 1
    ELSE
     IF config.snd THEN
      WAVPlay "buzzer.wav", 11000
     END IF
    END IF
   END IF
    
   IF player(level.turn).bul = 3 THEN
    IF playpack(level.turn, 3).ammo > 0 THEN
     playpack(level.turn, 3).ammo = playpack(level.turn, 3).ammo - 1
     InitBullet 3, player(level.turn).x, player(level.turn).y, 0, 0, 0, playpack(level.turn, 3).set
     DrawSpr player(level.turn).x, player(level.turn).y, 3
     IF config.snd THEN
      WAVPlay "mine.wav", 11000
     END IF
     level.fire = 1
    ELSE
     IF config.snd THEN
      WAVPlay "buzzer.wav", 11000
     END IF
    END IF
   END IF

   IF player(level.turn).bul = 4 THEN
    IF playpack(level.turn, 4).ammo >= playpack(level.turn, 4).set THEN
     playpack(level.turn, 4).ammo = playpack(level.turn, 4).ammo - playpack(level.turn, 4).set
     power% = 0
     IF config.snd THEN
      WAVPlay "power.wav", 11000
     END IF
     DO
      key$ = INKEY$
      IF KeyMark%(key$) = 5 THEN EXIT DO
      LINE (220 + power%, 5)-(220 + power%, 6), 200 + power% / 3
      power% = power% + 1
      FOR z& = -32000 TO 32000
      NEXT z&
      IF power% = 60 THEN EXIT DO
     LOOP
     LINE (220, 5)-(280, 6), 0, BF
     power% = maxpower% * (power% / 60)
     FOR i% = 1 TO playpack(level.turn, 4).set
      InitBullet 4, player(level.turn).x, player(level.turn).y, player(level.turn).a - ((1 / playpack(level.turn, 4).set - 1) * .05) + ((i% - 1) * .1), player(level.turn).dir, power%, playpack(level.turn, 4).set
      DrawSpr player(level.turn).x, player(level.turn).y, 4
     NEXT i%
     IF config.snd THEN
      WAVPlay "launch.wav", 11000
     END IF
     level.fire = 1
    ELSE
     IF config.snd THEN
      WAVPlay "buzzer.wav", 11000
     END IF
    END IF
   END IF

   IF player(level.turn).bul = 5 THEN
    IF playpack(level.turn, 5).ammo > 0 THEN
     playpack(level.turn, 5).ammo = playpack(level.turn, 5).ammo - 1
     IF config.snd THEN
      WAVPlay "flamer.wav", 11000
     END IF
     FOR i% = 1 TO 20
      FOR a# = -.5 * (4 - playpack(level.turn, 5).set) TO .5 * (4 - playpack(level.turn, 5).set) STEP .05
       FOR r! = 0 TO 1 STEP .01 * (4 - playpack(level.turn, 5).set)
        rr! = r! * 15 * playpack(level.turn, 5).set * (1 - ABS(a# / (.5 * (4 - playpack(level.turn, 5).set))))
        c% = (1 - r! / 1) * 16 + 202 + RND * 4 - 2
        IF i% = 20 THEN c% = 241
        fx% = player(level.turn).x - 1 + 4 * (player(level.turn).dir + 1) + COS(a#) * rr! * player(level.turn).dir
        fy% = player(level.turn).y + 4 + SIN(a#) * rr!
        TPset fx%, fy%, 241
        IF c% = 241 THEN
         c% = BPoint%(fx%, fy%, 0)
        END IF
        PSET (fx%, fy%), c%
       NEXT r!
      NEXT a#
     NEXT i%
     FOR pn% = 1 TO maxplayers%
      IF player(pn%).health > 0 AND pn% <> level.turn THEN
       IF ABS(player(pn%).y - player(level.turn).y) <= 7 THEN
        IF player(level.turn).dir * (player(pn%).x - player(level.turn).x) > 0 AND player(level.turn).dir * (player(pn%).x - player(level.turn).x) <= playpack(level.turn, 5).set * 15 THEN
         ph% = 5000 * (1 / (player(level.turn).dir * (player(pn%).x - player(level.turn).x)) ^ 2)
         IF ph% > 50 THEN ph% = 50
         Damage pn%, ph%
        END IF
       END IF
      END IF
     NEXT pn%
     level.fire = 1
     level.nofly = 0
    ELSE
     IF config.snd THEN
      WAVPlay "buzzer.wav", 11000
     END IF
    END IF
   END IF

   IF player(level.turn).bul = 7 THEN
    IF playpack(level.turn, 7).ammo > 0 THEN
     playpack(level.turn, 7).ammo = playpack(level.turn, 7).ammo - 1
     power% = 0
     IF config.snd THEN
      WAVPlay "power.wav", 11000
     END IF
     DO
      key$ = INKEY$
      IF KeyMark%(key$) = 5 THEN EXIT DO
      LINE (220 + power%, 5)-(220 + power%, 6), 200 + power% / 3
      power% = power% + 1
      FOR z& = -32000 TO 32000
      NEXT z&
      IF power% = 60 THEN EXIT DO
     LOOP
     LINE (220, 5)-(280, 6), 0, BF
     power% = maxpower% * (power% / 60)
     InitBullet 7, player(level.turn).x, player(level.turn).y, player(level.turn).a, player(level.turn).dir, power%, playpack(level.turn, 7).set
     DrawSpr player(level.turn).x, player(level.turn).y, 7
     IF config.snd THEN
      WAVPlay "launch.wav", 11000
     END IF
     level.fire = 1
    ELSE
     IF config.snd THEN
      WAVPlay "buzzer.wav", 11000
     END IF
    END IF
   END IF

   DrawBar
  END IF

 CASE 6
  IF player(level.turn).glued = 0 THEN
   IF player(level.turn).jump > 0 THEN
    IF player(level.turn).bul = 6 THEN
     IF playpack(level.turn, 6).ammo > 0 THEN
      player(level.turn).jump = 2
      playpack(level.turn, 6).ammo = playpack(level.turn, 6).ammo - 1
      IF config.snd THEN
       WAVPlay "booster.wav", 11000
      END IF
     DrawBar
     ELSE
      IF config.snd THEN
        WAVPlay "buzzer.wav", 11000
      END IF
      GOTO nojump
     END IF
    ELSE
     GOTO nojump
    END IF
   ELSE
    player(level.turn).jump = 1
    IF config.snd THEN
     WAVPlay "jump.wav", 11000
    END IF
   END IF
   player(level.turn).xi = player(level.turn).x
   player(level.turn).yi = player(level.turn).y
   player(level.turn).aj = player(0).aj
   player(level.turn).pj = player(0).pj
   player(level.turn).tim = TIMER - .1
   t# = (TIMER - player(level.turn).tim) * bulletspd%
   ErasePlayer level.turn
   player(level.turn).x = player(level.turn).xi + t# * COS(player(level.turn).aj) * player(level.turn).pj * player(level.turn).dir
   player(level.turn).y = player(level.turn).yi + t# * SIN(player(level.turn).aj) * player(level.turn).pj + 16 * t# ^ 2
   DrawPlayer level.turn
nojump:
  END IF

 CASE 7, 8, 9
  playpack(level.turn, player(level.turn).bul).set = k% - 6
  DrawBar
  IF config.snd THEN
   WAVPlay "menua.wav", 11000
  END IF

 CASE 10
  level.quit = 1

 CASE 11
  level.fire = 1

 CASE 12 TO 11 + maxweapons%
  player(level.turn).bul = k% - 11
  DrawBar
  IF config.snd THEN
   WAVPlay "menub.wav", 11000
  END IF

END SELECT
END SUB

SUB SetBlastPal
'Sets the fire palette.

FOR c% = 200 TO 220
 s% = (210 - c%) / 10 * pal(1).r
 IF s% < 0 THEN s% = 0
 rr% = (c% - 200) * 124 / 20 + s%
 IF rr% < 0 THEN rr% = 0
 IF rr% > 62 THEN rr% = 62
 gamepal(c%).r = rr%
 s% = (210 - c%) / 10 * pal(1).g
 IF s% < 0 THEN s% = 0
 gg% = (c% - 200) * 60 / 20 + s%
 IF gg% < 0 THEN gg% = 0
 IF gg% > 62 THEN gg% = 62
 gamepal(c%).g = gg%
 s% = (210 - c%) / 10 * pal(1).B
 IF s% < 0 THEN s% = 0
 bb% = -40 + (c% - 200) * 80 / 20 + s%
 IF bb% < 0 THEN bb% = 0
 IF bb% > 62 THEN bb% = 62
 gamepal(c%).B = bb%
NEXT c%
END SUB

SUB SpeakerState (state%)
'Sets the state of the speakers. (1 = on, 0 = off)

IF state% THEN
 DSPWrite &HD1
ELSE
 DSPWrite &HD3
END IF
END SUB

SUB Title
'Displays the title screen.

DIM s AS STRING * 1

OPEN "title.pal" FOR BINARY AS #1
FOR i% = 0 TO 255
 GET #1, , s
 r% = ASC(s)
 GET #1, , s
 g% = ASC(s)
 GET #1, , s
 B% = ASC(s)
 gamepal(i%).r = r%
 gamepal(i%).g = g%
 gamepal(i%).B = B%
NEXT i%
CLOSE #1
PALETTE 0, 0

IF config.snd > 0 THEN
 WAVPlay "title1.wav", 11000
END IF
DEF SEG = &HA000
BLOAD "title.img", 0
DEF SEG
FOR i% = 0 TO 100
 key$ = INKEY$
 IF key$ = CHR$(13) THEN GOTO donetitle1
 FadePal 0, 0, 0, i%, 0, 255
 FOR z% = -32000 TO 32000
  FOR zz% = 0 TO 3
  NEXT zz%
 NEXT z%
NEXT i%
donetitle1:
IF config.snd > 0 THEN
 WAVPlay "title2.wav", 11000
END IF
FOR i% = 0 TO 100
 key$ = INKEY$
 IF key$ = CHR$(13) THEN GOTO donetitle2
 c% = RND * 100
 FadePal 40, 50, 60, c%, 0, 255
NEXT i%
FadePal 0, 0, 0, 100, 0, 255
Pause
donetitle2:
END SUB

FUNCTION TPoint% (tx%, ty%, pn%)
'Returns the pixel on the turf map to see if a collision occured.
'(241 represents a pixel of sky)
'tx% and ty% are the coordinates.
'pn% is the number of player who is being "looked behind" (1-4) or
'0 if it is a bullet sprite and you want to be able to "see" all the players.
'You can also use -1 to not see any players.

pp% = 241
IF tx% >= 0 AND tx% <= 319 AND ty% >= 0 AND ty% <= 199 THEN
 DEF SEG = VARSEG(turfbuf(0))
 pp% = PEEK(tx% + 320& * ty% + 4)
 DEF SEG
 FOR i% = 1 TO maxplayers%
  IF player(i%).health > 0 AND pn% <> i% AND pn% <> -1 THEN
   IF tx% >= player(i%).x AND tx% <= player(i%).x + 7 AND ty% >= player(i%).y AND ty% <= player(i%).y + 7 THEN
    pp% = playerspr((player(i%).dir - 1) * -3.5 + player(i%).dir * (tx% - player(i%).x) + 8 * (ty% - player(i%).y))
    IF pp% = -1 THEN
     pp% = team(player(i%).tnum).clr
    ELSEIF pp% = -10 THEN
     IF player(i%).dir = 1 THEN
      pp% = 25 - INT((tx% - player(i%).x) / 2)
     ELSE
      pp% = 25 - INT((7 - (tx% - player(i%).x)) / 2)
     END IF
    END IF
    IF pp% > 0 THEN
     IF player(i%).glued > 0 THEN pp% = 92
    ELSE
     pp% = 241
    END IF
    FOR ii% = 0 TO gunlen%
     x% = player(i%).x + 3 + (1 - player(i%).dir) / 2 + COS(player(i%).a) * ii% * player(i%).dir
     y% = player(i%).y + 4 + SIN(player(i%).a) * ii%
     IF tx% = x% AND ty% = y% THEN pp% = 25
    NEXT ii%
   END IF
  END IF
 NEXT i%
END IF
TPoint% = pp%
END FUNCTION

SUB TPset (tx%, ty%, tp%)
'PSETs to the turf map.

IF tx% >= 0 AND tx% <= 319 AND ty% >= 0 AND ty% <= 199 THEN
 DEF SEG = VARSEG(turfbuf(0))
 POKE tx% + 320& * ty% + 4, tp%
 DEF SEG
END IF
END SUB

FUNCTION TurfBump$ (tx%, ty%, pn%)
'Checks collision with turf map and bounces the sprite accordingly.
'tx% and ty% are the coordinates of the sprite.
'pn% is the number of player who is being "looked behind" (1-4) or
'0 if it is a bullet sprite and you want to be able to "see" all the players.
'You can also use -1 to not see any players.

bstr$ = "00000000"
FOR cy% = ty% + 1 TO ty% + 3
 IF TPoint%(tx%, cy%, pn%) <> 241 THEN
  MID$(bstr$, 8) = "1"
 END IF
NEXT cy%
FOR cy% = ty% + 4 TO ty% + 6
 IF TPoint%(tx%, cy%, pn%) <> 241 THEN
  MID$(bstr$, 7) = "1"
 END IF
NEXT cy%
FOR cy% = ty% + 1 TO ty% + 3
 IF TPoint%(tx% + 7, cy%, pn%) <> 241 THEN
  MID$(bstr$, 3) = "1"
 END IF
NEXT cy%
FOR cy% = ty% + 4 TO ty% + 6
 IF TPoint%(tx% + 7, cy%, pn%) <> 241 THEN
  MID$(bstr$, 4) = "1"
 END IF
NEXT cy%
FOR cx% = tx% TO tx% + 3
 IF TPoint%(cx%, ty%, pn%) <> 241 THEN
  MID$(bstr$, 1) = "1"
 END IF
NEXT cx%
FOR cx% = tx% + 4 TO tx% + 7
 IF TPoint%(cx%, ty%, pn%) <> 241 THEN
  MID$(bstr$, 2) = "1"
 END IF
NEXT cx%
FOR cx% = tx% TO tx% + 3
 IF TPoint%(cx%, ty% + 7, pn%) <> 241 THEN
  MID$(bstr$, 6) = "1"
 END IF
NEXT cx%
FOR cx% = tx% + 4 TO tx% + 7
 IF TPoint%(cx%, ty% + 7, pn%) <> 241 THEN
  MID$(bstr$, 5) = "1"
 END IF
NEXT cx%

TurfBump$ = bstr$
END FUNCTION

FUNCTION TurfHit% (tb%, tx%, ty%)
'Checks collision with turf map of a sprite.
'tb% is the sprite number.
'tx% and ty% are the coordinates of the sprite.

hit% = 0
FOR cx% = tx% TO tx% + 7
 FOR cy% = ty% TO ty% + 7
  cp% = ammospr(tb%, cx% - tx% + 8 * (cy% - ty%))
  IF cp% <> 0 THEN
   IF TPoint%(cx%, cy%, level.turn) <> 241 THEN
    hit% = 1
    GOTO donehit
   END IF
  END IF
 NEXT cy%
NEXT cx%
donehit:
TurfHit% = hit%
END FUNCTION

SUB WAVPlay (file$, freq&)
'Plays a WAV file.
'file$ = WAV file in "/sound/" subdirectory
'freq& = frequency to be played at (normal = 11000)

DIM WavBuffer(1 TO 1) AS STRING * 32767
OPEN "sound\" + file$ FOR BINARY AS #1
DO
 GET #1, 44, WavBuffer(1)
 length& = LOF(1) - 44
 IF length& > 32767 THEN length& = 32767
 DMAPlay VARSEG(WavBuffer(1)), VARPTR(WavBuffer(1)), length&, freq&
LOOP UNTIL EOF(1)
CLOSE #1
END SUB

SUB Win (pnum%)
'Displays winning screen.
'pnum% = team number that won. (Can be 0 if everyone died)

IF pnum% = 0 THEN
 l$ = "Nobody wins!"
 IF config.snd THEN
  WAVPlay "lose.wav", 11000
 END IF
 c% = 23
ELSE
 l$ = RTRIM$(team(pnum%).nam) + " wins!"
 IF config.snd THEN
  WAVPlay "win.wav", 11000
 END IF
 c% = team(pnum%).clr
END IF
LINE (30, 90)-(290, 110), c%, B
Font l$, 160 - LEN(l$) * 4, 95, 1, 1, 3, 24
Pause
FOR c% = 100 TO 0 STEP -1
 FadePal 0, 0, 0, c%, 0, 255
NEXT c%
END SUB

