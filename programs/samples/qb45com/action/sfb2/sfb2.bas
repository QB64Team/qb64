CHDIR ".\programs\samples\qb45com\action\sfb2"

'                           SFB2:Vector Warriors                             `
'                              by Kevin Reems                                `
'                                1997--1998                                  `
'                              Created Using,                                `
'                  The Slash Engine by Kevin Reems 1997-1998                 `
'----------------------------------------------------------------------------`
'Press F5 To Play                                                            `
'                                                                            `
'Kevin Reems a.k.a. LBt1st - lbt1st@cyberdude.com                            `
'              Please View SFB2 Guide Part-A.html                            `
'                                                                            `
'                                                                            `
'                                                                            `
'                                                                            `
'                                                                            `
'                                                                            `
'                                                                            `
'----------------------------------------------------------------------- SFB2

DECLARE SUB AIsuper (pc%, po%)
DECLARE SUB AIfighter (pc%)
DECLARE SUB AIspecial (pc%, po%)
DECLARE SUB AI (pc%)
DECLARE SUB fightername (n%)
DECLARE SUB options ()
DECLARE SUB settings ()
DECLARE SUB setdetails ()
DECLARE SUB ringout (n)
DECLARE SUB floors ()
DECLARE SUB splash (n)
DECLARE SUB fighterpop (n)
DECLARE SUB fightergoo (wee, d)
DECLARE SUB fighterfreeze (wee)
DECLARE SUB fightercompress (n%)
DECLARE SUB fighterpositions ()
DECLARE SUB fighterinit ()
DECLARE SUB fighterender ()
DECLARE SUB fightermove ()
DECLARE SUB ringoutext (n)
DECLARE SUB fighterlimits ()
DECLARE SUB projectiles ()
DECLARE SUB projectilerender ()
DECLARE SUB setdelay ()
DECLARE SUB smear (x%, y%, Z, c%)
DECLARE SUB smearender ()
DECLARE SUB stagewindow (mode%)
DECLARE SUB ocasional ()
DECLARE SUB camtracking ()
DECLARE SUB newmatch ()
DECLARE SUB Conclusion ()
DECLARE SUB setfightercpu ()
DECLARE SUB setfighter ()
DECLARE SUB fall (n)
DECLARE SUB nokey ()
DECLARE SUB jump (n%, T%)
DECLARE SUB setbody (n%)
DECLARE SUB setko (n)
DECLARE SUB keycheck ()
DECLARE SUB decap (n%)
DECLARE SUB fades ()
DECLARE SUB fighterdirect ()
DECLARE SUB rain2d (c1%, c2%, c3%, l!)
DECLARE SUB rain3d (x1!, y1!, z1!, x2!, y2!, z2!, c1%, c2%, c3%, l!)
DECLARE SUB setstagename (n%)
DECLARE SUB AIgetclose (pc%, po%)
DECLARE SUB AIdefend (pc%, po%)
DECLARE SUB AIattack (pc%, po%)



'------------------------------------------------- Perspective Space Commands

DECLARE SUB pspoint (x, y, Z) : '                                  Point

DECLARE SUB pspset (x, y, Z, c%) : '                               Pset

DECLARE SUB psdpset (x, y, z1, z2, c%) : '                         Deep Pset
                                                                  
DECLARE SUB psline (x1, y1, z1, x2, y2, z2, c%, B%) : '            Line

DECLARE SUB psdline (x1, y1, z1, x2, y2, z2, c1%, c2%, c3%, B%) : 'Deep Line

DECLARE SUB pscline (x1, y1, z1, x5, y5, z5, r, c%) : '            Circle Line

DECLARE SUB pslightning (x1, y1, z1, x5, y5, z5, r, c%) : '        Lightning

DECLARE SUB pscircle (x, y, Z, r1, c%) : '                         Circle

DECLARE SUB pscube (x1, y1, z1, x2, y2, z2, c1%, c2%, c3%) : '     Cube

DECLARE SUB psmark1 (x, y, Z, c1%, c2%, c3%) : '                   Mark1

DECLARE SUB psmark2 (x, y, c1%, c2%, c3%) : '                      Mark2

DECLARE SUB particle (x, y, Z, T%, Q%) : '               Spawn particle(s)
DECLARE SUB particle2 (x, y, Z, T%, Q%) : '              Continued Spawning
DECLARE SUB particlerender () : '                        Render particles%

DECLARE SUB setparticles () : '                          Particle Options
DECLARE SUB particlerender () : '                        Renders particles%
DECLARE SUB particlemove () : '                          Moves them
DECLARE SUB particleclear () : '                         Clears them
DECLARE SUB decay () : '                                 Kill them


'------------------------------------------------------------- Slash Commands

'Sound
DECLARE FUNCTION DetectCard% ()
DECLARE SUB sbinit ()
DECLARE SUB SBplay (Freq%, Wave%, Feedback%, Modl%, Clen%)
DECLARE SUB SBWrite (Reg%, Value%)
DECLARE SUB sbfx (fxx%)

'Set Sound Options
DECLARE SUB setsound ()

'Clear Space For Text
'open
DECLARE SUB smallwindow ()
DECLARE SUB bigwindow ()
'close
DECLARE SUB csmallwindow ()
DECLARE SUB cbigwindow ()

'Let User Load/Save/Reset
DECLARE SUB loadsave ()

'n = 1 Load   n = 2 Save   n = 3 Reset Defaults
'mode% = n: CALL file
DECLARE SUB file ()

'Change Screen Resolution
DECLARE SUB setrez ()

'Change Clear Method
DECLARE SUB setcmethod ()

'Change frameskip%
DECLARE SUB setframeskip ()

'Change Stage%
DECLARE SUB setstage ()

'Apply Movement to Camera
DECLARE SUB movecam ()

'Exit the Program
DECLARE SUB quit ()

'Window x/y
DECLARE SUB winxwiny ()

'Slash Mud
DECLARE SUB mud ()

'Temporary Blur
DECLARE SUB blur (l%)

'Reset Camera Defaults
DECLARE SUB camdefaults ()

'Page Flip
DECLARE SUB pflip ()

'Clear Screen
DECLARE SUB clearscreen ()

'Block Clearing
DECLARE SUB clsblock (n)

'Pauses
DECLARE SUB pause ()

'Waits for Input After an Error Trap
DECLARE SUB errorkey ()

'2D Stars
DECLARE SUB stars2d (c1%, c2%, c3%)

'3D Stars
DECLARE SUB stars3d (x1, y1, z1, x2, y2, z2, c1%, c2%, c3%)

'Offset the Stars
DECLARE SUB starsoffset (x, y)

'Randomize Stars
DECLARE SUB starsrnd ()

'Set Number of Stars
DECLARE SUB setstars ()

'Sets defaults for the current stage
DECLARE SUB stageinit ()

'Stage Shifting
DECLARE SUB stageshifting ()

'Render current stage
DECLARE SUB stagebackground ()
DECLARE SUB stageforground ()

'Display i16 Image
DECLARE SUB i16 (x, y, x2, y2, F$)
DECLARE SUB seti16 ()

'Get path$ from file
DECLARE SUB getpath ()

'Set path$
DECLARE SUB setpath ()

'Render Something on Page 2
DECLARE SUB page2 ()

'Test the Video Pages
DECLARE SUB pagetest ()

'Define Window for 2D or 3D Mode
DECLARE SUB window2d ()
DECLARE SUB window3d ()

'----------------------------------------------------------- Shared Variables

COMMON SHARED stars1x, stars1y, stars1z, stars2x, stars2y, stars2z, stars3x, stars3y, stars3z
COMMON SHARED zoom, zoomd, zoomt, panx, pany, panh, panv, midx%, midy%, winx, winy, rez%, xx1, xx2, yy1, yy2, wx, wy, wz, ringoutt%, ringoutp%, victory%, control%, pointc%, refreash, flimits%, dist%, dif%, AImoved%
COMMON SHARED restart%, frameskip%, cmethod%, cfreq%, blurr%, csave%, nstars%, stage%, bob, flash1%, flash2%, flash3%, ver$, trigger1, trigger2, trigger3, solidc%, tpause%, bgcolor%
COMMON SHARED gravity, particles%, floor1, floor2, floor3, fault$, setback%, mode%, odds%, ticker%, bobm, midstage, camode%, i16m%, smears%, stagemode%, stages%, delay%, walkx, stagename$
COMMON SHARED sbsound%, P1d, P2d, soundticker%, soundwait%, path$, wee$, hfade%, ctime%, clsb%, pflip1%, pflip2%, ring%, startfight%, stageset%, stagedetail%, fighterdetail%, hudetail%

ON ERROR GOTO 8
fault$ = "dim"

'------------------------------------------------------------------- Fighters
DIM SHARED hairt%(1 TO 2)
DIM SHARED hairl%(1 TO 2)
DIM SHARED hairc%(1 TO 2)
DIM SHARED hairx(1 TO 10)
DIM SHARED hairy(1 TO 10)

DIM SHARED projectile%(1 TO 6)
DIM SHARED projectilex(1 TO 6)
DIM SHARED projectiley(1 TO 6)
DIM SHARED projectileh(1 TO 6)
DIM SHARED projectilev(1 TO 6)
DIM SHARED projectilet%(1 TO 6)

DIM SHARED name$(1 TO 2)
DIM SHARED walkx(1 TO 2)
DIM walkh(1 TO 2)
DIM SHARED health%(1 TO 2)
DIM SHARED maxhp%(1 TO 2)
DIM SHARED hpslide%(1 TO 2)
DIM SHARED sdelay%(1 TO 2)
DIM SHARED ko(1 TO 2)
DIM SHARED koslide%(1 TO 2)
DIM SHARED AIactive%(1 TO 2)
DIM SHARED AIhs%(1 TO 2)
DIM SHARED AIhm%(1 TO 2)
DIM SHARED AIhl%(1 TO 2)
DIM SHARED AIhh%(1 TO 2)
DIM SHARED AIfs%(1 TO 2)
DIM SHARED AIfm%(1 TO 2)
DIM SHARED AIfl%(1 TO 2)
DIM SHARED AIfh%(1 TO 2)

DIM SHARED ahpow%(1 TO 2)
DIM SHARED akpow%(1 TO 2)
DIM SHARED lhpow%(1 TO 2)
DIM SHARED lkpow%(1 TO 2)

DIM SHARED hc%(1 TO 2)
DIM SHARED kc%(1 TO 2)

DIM SHARED attackok%(1 TO 2)
DIM SHARED rage(1 TO 2)
DIM SHARED vexed%(1 TO 2)
DIM SHARED ragecharge(1 TO 2)
DIM SHARED razers%(1 TO 2)
DIM SHARED kocharge(1 TO 2)
DIM SHARED win%(1 TO 2)
DIM SHARED combo%(1 TO 2)
DIM SHARED combol%(1 TO 2)
DIM SHARED Special%(1 TO 2)

DIM SHARED headless%(1 TO 2)
DIM SHARED hx(1 TO 2)
DIM SHARED hy(1 TO 2)
DIM SHARED hh(1 TO 2)
DIM SHARED hv(1 TO 2)

DIM SHARED canjump%(1 TO 2)
DIM SHARED position%(1 TO 2)
DIM SHARED d%(1 TO 2)
DIM SHARED ds%(1 TO 2)
DIM SHARED pticker%(1 TO 2)
DIM SHARED psaver%(1 TO 2)

DIM SHARED fighterz(1 TO 2)
DIM SHARED fighterd(1 TO 2)

DIM SHARED headx(1 TO 4)
DIM SHARED neckx(1 TO 4)
DIM SHARED buttx(1 TO 4)
DIM SHARED elbow1x(1 TO 4)
DIM SHARED elbow2x(1 TO 4)
DIM SHARED hand1x(1 TO 4)
DIM SHARED hand2x(1 TO 4)
DIM SHARED nee1x(1 TO 4)
DIM SHARED nee2x(1 TO 4)
DIM SHARED foot1x(1 TO 4)
DIM SHARED foot2x(1 TO 4)

DIM SHARED heady(1 TO 4)
DIM SHARED necky(1 TO 4)
DIM SHARED butty(1 TO 4)
DIM SHARED elbow1y(1 TO 4)
DIM SHARED elbow2y(1 TO 4)
DIM SHARED hand1y(1 TO 4)
DIM SHARED hand2y(1 TO 4)
DIM SHARED nee1y(1 TO 4)
DIM SHARED nee2y(1 TO 4)
DIM SHARED foot1y(1 TO 4)
DIM SHARED foot2y(1 TO 4)

DIM SHARED headh(1 TO 2)
DIM SHARED neckh(1 TO 2)
DIM SHARED butth(1 TO 2)
DIM SHARED elbow1h(1 TO 2)
DIM SHARED elbow2h(1 TO 2)
DIM SHARED hand1h(1 TO 2)
DIM SHARED hand2h(1 TO 2)
DIM SHARED nee1h(1 TO 2)
DIM SHARED nee2h(1 TO 2)
DIM SHARED foot1h(1 TO 2)
DIM SHARED foot2h(1 TO 2)

DIM SHARED headv(1 TO 2)
DIM SHARED neckv(1 TO 2)
DIM SHARED buttv(1 TO 2)
DIM SHARED elbow1v(1 TO 2)
DIM SHARED elbow2v(1 TO 2)
DIM SHARED hand1v(1 TO 2)
DIM SHARED hand2v(1 TO 2)
DIM SHARED nee1v(1 TO 2)
DIM SHARED nee2v(1 TO 2)
DIM SHARED foot1v(1 TO 2)
DIM SHARED foot2v(1 TO 2)

'Body Part Types
DIM SHARED head%(1 TO 2)
DIM SHARED body%(1 TO 2)
DIM SHARED arms%(1 TO 2)
DIM SHARED hands%(1 TO 2)
DIM SHARED legs%(1 TO 2)
DIM SHARED feet%(1 TO 2)

'Body Part Colors
DIM SHARED headc%(1 TO 2)
DIM SHARED bodyc%(1 TO 2)
DIM SHARED armsc%(1 TO 2)
DIM SHARED handsc%(1 TO 2)
DIM SHARED legsc%(1 TO 2)
DIM SHARED feetc%(1 TO 2)

'------------------------------------------------------------------ Particles
DIM SHARED p%(1 TO 90)
DIM SHARED pk%(1 TO 90)
DIM SHARED pg%(1 TO 90)
DIM SHARED pf%(1 TO 90)
DIM SHARED px(1 TO 90)
DIM SHARED py(1 TO 90)
DIM SHARED pz(1 TO 90)
DIM SHARED ph(1 TO 90)
DIM SHARED pv(1 TO 90)
DIM SHARED pd(1 TO 90)
DIM SHARED pc1%(1 TO 90)
DIM SHARED pc2%(1 TO 90)
DIM SHARED pc3%(1 TO 90)

'---------------------------------------------------------------------- Stars
DIM SHARED stars1x(1 TO 20)
DIM SHARED stars1y(1 TO 20)
DIM SHARED stars1z(1 TO 20)
DIM SHARED stars2x(1 TO 20)
DIM SHARED stars2y(1 TO 20)
DIM SHARED stars2z(1 TO 20)
DIM SHARED stars3x(1 TO 20)
DIM SHARED stars3y(1 TO 20)
DIM SHARED stars3z(1 TO 20)

'--------------------------------------------------------------- Blood Smears
DIM SHARED smearl%(1 TO 10)
DIM SHARED smearx%(1 TO 10)
DIM SHARED smeary%(1 TO 10)
DIM SHARED smearz(1 TO 10)
DIM SHARED smearc%(1 TO 10)




'----------------------------------------------------------------------------
'Begin the Program                                         Begin the Program`
'----------------------------------------------------------------------------



'----------------------------------------------------------------- Disclaimer
SCREEN 8
COLOR , 0
c% = 4
FOR wee = 1 TO 6
COLOR c%, 0
LOCATE 10, 36
PRINT "WARNING:"
PRINT ""
PRINT "SFB2: Vector Warriors Contains Graphic Violence And Gore That May Be Offending."
LOCATE 14, 27: PRINT "Player Discretion Advised."

SELECT CASE wee
CASE IS = 1: c% = 12
CASE IS = 2: c% = 15
CASE IS = 3: c% = 12: SLEEP 3
CASE IS = 4: c% = 4
CASE IS = 5: c% = 0
END SELECT
FOR d% = 0 TO 15000: NEXT d%
NEXT wee



'---------------------------------------------------------------------------`
'Init ----------------------------------------------------------------- Init`
'---------------------------------------------------------------------------`

4
CLEAR
fault$ = "init"

'------------------------------------+                                      *
'Error And Version Information
ON ERROR GOTO 8: e% = 1
ver$ = "1.00"
'------------------------------------+                                      *

'Show Error Detection Message
IF e% = 0 THEN
LOCATE 1, 1
COLOR 15
PRINT "Error Detection is OFF"
SLEEP
END IF

RANDOMIZE (TIMER)

'Set NumLock to ON
DEF SEG = 0
KeyFlags = PEEK(1047)
POKE 1047, KeyFlags OR 32
IF (KeyFlags AND 32) = 0 THEN DEF SEG : DEF SEG = 0



'---------------------------------------------------------------------------`
'Defaults -=======================================================- Defaults`
'---------------------------------------------------------------------------`



'-------------------------+ Required by Slash
getpath
mode% = 1: file
setback% = 0
starsrnd
pflip1% = 1
flash1% = 1
mud
camdefaults
IF sbsound% = 1 THEN sbinit

'-------------------------+ Required by Program
stagemode% = 1
stages% = 15
setfightercpu
stageinit
walkh(1) = .5
walkh(2) = .5

'---------------------------------------------------------------------------`
'End Defaults -===============================================- End Defaults`
'---------------------------------------------------------------------------`


'-------------------------- Ready Screen for Slash
IF rez% <> 1 AND rez% <> 7 AND rez% <> 9 AND rez% <> 12 THEN rez% = 9
SCREEN rez%
window3d


'--------------------- Clear Vars.
fault$ = ""
wee$ = ""
neckx(3) = -50
neckx(4) = 50



'----------------------------------------------------------------------------
'Start Loop ===================================================== Start Loop`
'----------------------------------------------------------------------------
DO





'---------------------
IF restart% = 1 THEN
restart% = 0
SCREEN , 1, 1
CLS
SCREEN , 0, 0
CLS
GOTO 4
END IF


'---------------------------------------------------------- Alternating Vars.
IF odds% = 0 THEN odds% = 1 ELSE odds% = 0

FOR pc1 = 1 TO 2
IF walkx(pc1) < 0 THEN walkh(pc1) = .8
IF walkx(pc1) > 4 THEN walkh(pc1) = -.8
walkx(pc1) = walkx(pc1) + walkh(pc1)
NEXT pc1
 

'---------------------
SELECT CASE flash1%

CASE IS = 9
flash1% = 1
flash2% = 9
flash3% = 4

CASE IS = 1
flash1% = 9
flash2% = 15
flash3% = 12
END SELECT

'---------------------
IF bob < 0 THEN bobm = bobm + .01 ELSE bobm = bobm - .01
bob = bob + bobm

'---------------------
IF soundticker% > 0 THEN soundticker% = soundticker% - 1



'----------------------------------------------------------- Keyboard Control
IF wee$ <> "" THEN
DEF SEG = &H40
POKE &H1A, PEEK(&H1C)
END IF

wee$ = UCASE$(INKEY$)

'Disable Kicks for Demize
IF legs%(1) = 666 THEN
IF wee$ = "A" THEN wee$ = "Q"
IF wee$ = "S" THEN wee$ = "W"
END IF

SELECT CASE wee$

'Game Functions
CASE IS = CHR$(27): options
CASE IS = "P": pause

END SELECT

'-------------------------------------------------------------------- Control
IF position%(1) = 1 OR position%(1) = 12 THEN attackok%(1) = 1 ELSE attackok%(1) = 0
IF position%(2) = 1 OR position%(2) = 12 THEN attackok%(2) = 1 ELSE attackok%(2) = 0

IF control% = 1 AND AIactive%(1) = 0 AND wee$ <> "" THEN

'Convert Extra Keys To Standard Commands
SELECT CASE wee$
CASE IS = CHR$(0) + "H": wee$ = "8"
CASE IS = CHR$(0) + "K": wee$ = "4"
CASE IS = CHR$(0) + "P": wee$ = "5"
CASE IS = CHR$(0) + "M": wee$ = "6"
CASE IS = "2": wee$ = "5"
END SELECT

'Standard Commands

IF Special%(1) = 0 THEN
'Normal Moves
 SELECT CASE wee$
 CASE IS = "Q": IF attackok%(1) = 1 AND pticker%(1) > 2 THEN position%(1) = 2
 CASE IS = "W": IF position%(1) = 1 AND pticker%(1) > 5 THEN position%(1) = 3 ELSE IF position%(1) = 12 THEN position%(1) = 13
 CASE IS = "A": IF attackok%(1) = 1 AND pticker%(1) > 2 THEN position%(1) = 5
 CASE IS = "S": IF attackok%(1) = 1 THEN position%(1) = 6
 END SELECT
ELSE
'Special Moves
 SELECT CASE wee$
 CASE IS = "Q"
  SELECT CASE hands%(1)
  CASE 1, 666: IF projectile%(1) = 0 THEN position%(1) = 30
  CASE 2: position%(1) = 31
  CASE 3: position%(1) = 32
  CASE 4, 1998: position%(1) = 33
  CASE 5: IF projectile%(1) = 0 THEN position%(1) = 34
  END SELECT
 CASE IS = "W"
  SELECT CASE hands%(1)
  CASE 1, 666: IF projectile%(2) = 0 THEN position%(1) = 35
  CASE 2: position%(1) = 36
  CASE 3: position%(1) = 37
  CASE 4: position%(1) = 38
  CASE 5: position%(1) = 39
  CASE 1998: position%(1) = 82
  END SELECT
 CASE IS = "A"
  SELECT CASE feet%(1)
  CASE 1: position%(1) = 40
  CASE 2: position%(1) = 41
  CASE 3: position%(1) = 42
  CASE 4: position%(1) = 43
  CASE 5: position%(1) = 44
  END SELECT
 CASE IS = "S"
  SELECT CASE feet%(1)
  CASE 1: position%(1) = 45
  CASE 2: IF pticker%(1) > 25 THEN position%(1) = 46
  CASE 3: IF canjump%(1) = 1 THEN position%(1) = 47
  CASE 4: position%(1) = 48
  CASE 5: position%(1) = 49
  END SELECT
 END SELECT
END IF

'Supers
IF wee$ = "D" AND rage(1) >= 100 AND attackok%(1) = 1 AND pticker%(1) > 5 THEN
  SELECT CASE body%(1)
  CASE 1: position%(1) = 81
  CASE 2: position%(1) = 82
  CASE 3: position%(1) = 83
  CASE 4: position%(1) = 84
  CASE 5: position%(1) = 85
  CASE 6: IF position%(1) = 1 THEN position%(1) = 86
  CASE 7: IF position%(1) = 1 THEN position%(1) = 87
  CASE 8: position%(1) = 88
  CASE 666: position%(1) = 36
  END SELECT
END IF

SELECT CASE wee$
CASE IS = "4": IF canjump%(1) = 1 THEN butth(1) = butth(1) - .5: IF butth(1) > 0 THEN butth(1) = 0
CASE IS = "6": IF canjump%(1) = 1 THEN butth(1) = butth(1) + .5: IF butth(1) < 0 THEN butth(1) = 0
CASE IS = "7": jump (1), 1
CASE IS = "8": jump (1), 2
CASE IS = "9": jump (1), 3
CASE IS = "5": IF canjump%(1) = 1 THEN position%(1) = 12
CASE IS = "E": IF Special%(1) = 0 THEN Special%(1) = 1 ELSE Special%(1) = 0
CASE IS = "R", " ": IF attackok%(1) = 1 AND pticker%(1) > 10 THEN position%(1) = 99

END SELECT
END IF


'---------- AI
IF control% = 1 THEN
 dist% = ABS(buttx(1) - buttx(2))
 IF AIactive%(1) = 1 AND attackok%(1) = 1 THEN AI 1
 IF AIactive%(2) = 1 AND attackok%(2) = 1 THEN AI 2
END IF




'----------------------------------------------------------------------- Misc

'Show Ready, Begin Stuff
IF ticker% = startfight% AND stage% <> 1000 THEN showbegin% = 50
IF showbegin% > 0 THEN showbegin% = showbegin% - 1: COLOR 15: LOCATE 22, 1: PRINT stagename$
IF showbegin% > 30 THEN COLOR 4: LOCATE 4, 38: PRINT "Ready"
IF showbegin% > 0 AND showbegin% < 25 THEN COLOR 12: LOCATE 4, 38: PRINT "Begin!": control% = 1


'Run the Ocasional SUB
occ% = occ% + 1: IF occ% > 5 THEN occ% = 0: ocasional

'------------------------------------+
FOR wee = 1 TO 2

'Bleed when low on health
IF health%(wee) < RND * 50 AND RND < .5 THEN particle (headx(wee + 2)), (heady(wee + 2) + (RND * 30)), (fighterz(wee)), 0, 1


'Gush blood when headless
IF headless%(wee) = 1 THEN
IF ABS(butty(wee) - necky(wee + 2)) > 5 THEN particle (neckx(wee + 2)), (necky(wee + 2) - 5), fighterz(wee), 2, 1
END IF


'Fall When KO or Dead
IF health%(wee) <= 0 OR ko(wee) <= 0 THEN
ocasional
Conclusion
IF position%(wee) < 8 OR position%(wee) > 11 THEN fall (wee)
END IF

'Keep health & ko within limits
IF health%(wee) < 0 THEN health%(wee) = 0
IF ko(wee) < 0 THEN ko(wee) = 0
IF rage(wee) > 100 THEN rage(wee) = 100

'-------------------------------------------------------------+
IF ticker% = 1 THEN
SELECT CASE stage%
CASE 1
fighterfreeze (wee)
position%(wee) = 0
CASE 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 1000
position%(wee) = 1
END SELECT
END IF
'-------------------------------------------------------------+

'Combo Life
IF combol%(wee) > 0 THEN
 combol%(wee) = combol%(wee) - 1
 IF combol%(wee) = 0 THEN combo%(wee) = 0
END IF

NEXT wee



'-------------------------------------------------------------- Get Framerate
cyc% = cyc% + 1
IF TIMER - time > .6 THEN
refreash = cyc%
cyc% = 0
time = TIMER

END IF


'--------------------------------------------------------------------- Camera
camtracking
movecam

'----------------------------------------------------------------- Move Stuff
fighterpositions
floors
fightermove
projectiles
IF odds% = 1 THEN particlemove




'---------------------------------------------------------------------------`
'==================================================================== Display
'---------------------------------------------------------------------------`

'Color Fades
fades

'Stage Shifting
stageshifting

'Page Flipping
IF newdisplay% = 1 THEN newdisplay% = 0: pflip

'Temporary Pausing
IF tpause% > 0 THEN tpause% = tpause% - 1: COLOR , 0: SLEEP 1

'Object Life Decaying
decay

'Frame Skipping
'norender% = norender% + 1
'IF norender% < frameskip% AND blurr% = 0 THEN 3 ELSE norender% = 0

'Delays
'FOR wee = 0 TO delay%: NEXT wee
'flicker = TIMER: DO UNTIL TIMER - flicker > .00001: LOOP
_LIMIT 25

'Clear Screen
clearscreen


'============================================================ Render Graphics

'Draw Background Image If In Screen 8
'IF rez% = 8 THEN PCOPY 2, pflip1%

'Background
stagebackground

'Render Smears
IF smears% = 1 THEN smearender

'Render Fighters
fighterender

'Render projectiles
projectilerender

'Render particals
IF particles% > 0 THEN particlerender

'Forground
stageforground

newdisplay% = 1

3 : '-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- End of 3D Graphics


'------------------------------------------------------------------------ HUD
fault$ = "hud"
window2d

'Show VS. Info
IF ticker% < startfight% + 50 THEN
COLOR 15
IF rez% > 7 THEN
LOCATE 3: PRINT name$(1)
 LOCATE 3, 40: PRINT "VS."
LOCATE 3, 70: PRINT name$(2)
ELSE
LOCATE 4: PRINT name$(1)
LOCATE 4, 20: PRINT "VS."
LOCATE 4, 30: PRINT name$(2)
END IF
END IF

'refreash rate
LINE (15, 0)-(30, 0), 7, , &H1010
LINE (20, 0)-(25, 0), 7, , &H101
IF refreash < 15 OR refreash > 30 THEN c% = 12 ELSE c% = 9
LINE (refreash - .5, 0)-(refreash + .5, 0), c%
PSET (refreash, 0), 15

'--------------------------------------+
hs1% = 45 - (hpslide%(1) / 4.66)
ks1% = 45 - (koslide%(1) / 2.33)
h1% = 45 - (health%(1) / 4.66)
k1 = 45 - (ko(1) / 2.33)

hs2% = 55 + (hpslide%(2) / 4.66)
ks2% = 55 + (koslide%(2) / 2.33)
h2% = 55 + (health%(2) / 4.66)
k2 = 55 + (ko(2) / 2.33)


'--------------------------------------- Damage Bars

'Health
IF h1% < 45 THEN
LINE (hs1%, 2.5)-(h1%, 3.3), flash3%, BF
LINE (h1%, 2)-(45, 4), hc%(1), BF
END IF

IF h2% > 55 THEN
LINE (h2%, 2.5)-(hs2%, 3.3), flash3%, BF
LINE (55, 2)-(h2%, 4), hc%(2), BF
END IF

'KO
IF k1 < 45 THEN
LINE (ks1%, 5.5)-(k1, 6.3), flash3%, BF
LINE (k1, 5)-(45, 7), kc%(1), BF
END IF

IF k2 > 55 THEN
LINE (ks2%, 5.5)-(k2, 6.3), flash3%, BF
LINE (55, 5)-(k2, 7), kc%(2), BF
END IF

'--------------------------------------- Eye Candy
IF hudetail% = 1 THEN
LINE (45, 1)-(55, 8), 15
LINE (45, 8)-(55, 1), 15

LINE (0, 1.2)-(44, 1.2), 8
LINE (0, 8.3)-(44, 8.3), 8
LINE (56, 1.2)-(100, 1.2), 8
LINE (56, 8.3)-(100, 8.3), 8

LINE (0, 1)-(45, 1), 7
LINE (0, 8)-(45, 8), 7
LINE (55, 1)-(100, 1), 7
LINE (55, 8)-(100, 8), 7

LINE (0, .7)-(44, .7), 15
LINE (0, 7.7)-(44, 7.7), 15
LINE (56, .7)-(100, .7), 15
LINE (56, 7.7)-(100, 7.7), 15
END IF


'Rage
IF hudetail% = 1 THEN
LINE (45 - (rage(1) / 2.5), 97.5)-(55 + (rage(2) / 2.5), 97.5), flash1%
IF rage(1) = 100 THEN LINE (5, 96.8)-(45, 96.8), flash2%
IF rage(2) = 100 THEN LINE (55, 96.8)-(95, 96.8), flash2%
LINE (45, 96.5)-(55, 96.5), 8
LINE (45, 97.5)-(55, 97.5), 7
LINE (45, 97.8)-(55, 97.8), 8

'Health Overlays
LINE (44 - (maxhp%(1) / 4.66), 2)-(45, 4), 7, B
LINE (55, 2)-(56 + (maxhp%(2) / 4.66), 4), 7, B

'KO Overlays
LINE (2, 5)-(45, 7), 7, B
LINE (55, 5)-(98, 7), 7, B

END IF

'Rage Meter
LINE (45, 96.8)-(55, 96.8), 7
LINE (45 - (rage(1) / 2.5), 97)-(55 + (rage(2) / 2.5), 97), 15


'Special Boxes
IF Special%(1) = 1 THEN LINE (0, 96)-(5, 98), flash1%, BF
LINE (0, 96)-(5, 98), 7, B
IF Special%(2) = 1 THEN LINE (95, 96)-(100, 98), flash1%, BF
LINE (95, 96)-(100, 98), 7, B


'Win Icons
IF win%(1) > 0 THEN
LINE (47, 3.5)-(47, 5.5), 12
LINE (46.3, 5)-(47.5, 5), 12
END IF

IF win%(2) > 0 THEN
LINE (52.7, 3.5)-(52.7, 5.5), 12
LINE (52.1, 5)-(53.3, 5), 12
END IF

'Display Ringout
IF ringoutt% > 0 THEN ringoutt% = ringoutt% - 1: ringoutext (ringoutp%)

window3d
fault$ = ""
'-------------------------------------------------------------------- End HUD


LOOP
'+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+ End Loop









'================================================================= Error Code
8
DO UNTIL INKEY$ = ""
wee$ = INKEY$
LOOP

IF fault$ <> "file" AND fault$ <> "ps" AND fault$ <> "save1" AND fault$ <> "nokey" THEN
CLOSE #1
SCREEN 9, , 0, 0
CLS
COLOR 15
SOUND 1000, 1: SOUND 500, 1
LOCATE 1, 1: PRINT "SLASH ERROR:                                                                          "
             PRINT "                                                                                      "
             PRINT "                                                                                      "
             PRINT "                                                                                      "
             PRINT "Esc - Terminate Program"
             PRINT "D   - Delete SLASH.DAT (If the File is Corrupt it May Cause Errors)"
             PRINT "Any Other Key will Attempt to Continue"

LOCATE 1, 14

END IF

SELECT CASE fault$

'----------------------------------------------
CASE IS = "load"

PRINT "File " + path$ + "\SLASH.DAT is Bad or Missing."
PRINT "Slash Will Attempt to Recover Using Default Settings."
PRINT "By Saving the Current Settings a New SLASH.DAT May Be Created."
setback% = 1
errorkey
RESUME NEXT


'----------------------------------------------
CASE IS = "save1"
CHDIR "\"
MKDIR path$
CLOSE #1
setback% = 1
RESUME NEXT

'----------------------------------------------
CASE IS = "save2"
PRINT "Could Not Write File " + path$ + "\SLASH.DAT"
PRINT "Slash Will Attempt to Recover Without Saving."
mode% = 0
setback% = 2
 errorkey
RESUME NEXT

'----------------------------------------------
CASE IS = "mud"
PRINT "There Was a Problem While Displaying The Opening Mud."
PRINT "Slash Will Attempt to Bypass It."
setback% = 1
 errorkey
RESUME NEXT

'----------------------------------------------
CASE IS = "init"
PRINT "Could Not Initalize."
PRINT "There is Probably a Memory or Video Problem."
PRINT "Slash Can Not Recover From This Error."
SLEEP
SYSTEM
RESUME NEXT

'----------------------------------------------
CASE IS = "pflip"
PRINT "Clearing or Flipping Video"
 errorkey
RESUME NEXT

'----------------------------------------------
CASE IS = "hud"
PRINT "There Was a Problem While Displaying The HUD."
PRINT "Slash Will Attempt to Continue Anyway"
 errorkey
RESUME NEXT

'----------------------------------------------
CASE IS = "file"
setback% = 1
RESUME NEXT

'----------------------------------------------
CASE IS = "ps"
COLOR 15
LOCATE 21
PRINT "PS ERROR"
RESUME NEXT

'----------------------------------------------
CASE IS = "ss"
PRINT "Problem With Sound Blaster Sound"
PRINT "Slash Will Attempt to Continue With Sound Disabled."
sbsound% = 0
 errorkey
RESUME NEXT

'----------------------------------------------
CASE IS = "particles"
PRINT "Problem Spawning/Rendering Particle(s)"
PRINT "Slash Will Attempt to Continue With The Particle Engine Disabled."
setback% = 1
 errorkey
RESUME NEXT

'----------------------------------------------
CASE IS = "pagetest"
PRINT "Current Screen Mode Does Not Not Support Page " + wee$
PRINT "Slash Will Switch Back to Page 0 and Continue Page Test Mode."
 errorkey
SCREEN , 0, 0
RESUME NEXT


'----------------------------------------------
CASE IS = "dim"
PRINT "Problem Allocating Variables"
PRINT "You Have Probably Run Out of Conventional Memory"
PRINT "Slash Can Not Recover From This Error."
SLEEP
RESUME NEXT

'----------------------------------------------
CASE IS = "nokey"
RESUME NEXT


'----------------------------------------------
END SELECT







'----------------------------------------------
PRINT "Unknown"
 errorkey
zoom = zoom + .01
zoomd = 0
RESUME NEXT

SUB AI (pc%)

IF pc% = 2 THEN po% = 1 ELSE po% = 2
AImoved% = 0


'--------------------------------------------- Move Away From Downed Opponent
IF position%(po%) > 7 AND position%(po%) < 12 AND dist% < 25 AND pticker%(pc%) > 5 AND pticker%(po%) > 15 THEN
 IF canjump%(pc%) = 1 THEN
 AImoved% = 1
 IF buttx(pc%) > 0 THEN jump (pc%), (1) ELSE jump (pc%), (3)
 END IF
END IF



'------------------------------------------------------------ Maintain Action
wee = 0
IF AImoved% = 0 THEN
IF pticker%(pc%) > 75 OR position%(po%) = 81 OR dist% < 2 THEN wee = 1
END IF
IF wee = 1 THEN IF RND < .5 THEN AIgetclose pc%, po% ELSE AIattack pc%, po%




 
'-------------------------------------------------------- Normal AI Functions
'Determine if in air and deside move accordingly

IF ABS(buttv(pc%)) > .5 THEN
 AIattack pc%, po%

ELSE
 'Defend
 IF AImoved% = 0 AND ko(pc%) + health%(pc%) < RND * dif% * 10 THEN
  AIdefend pc%, po%
 ELSE
  'Attack
  wee = 0
  IF buttx(pc%) < buttx(po%) AND d%(pc%) = -1 THEN wee = 1
  IF buttx(pc%) > buttx(po%) AND d%(pc%) = 1 THEN wee = 1
  IF wee = 0 AND AImoved% = 0 AND dif% > RND * 25 THEN AIattack pc%, po%
 END IF
 'Get Close
 IF AImoved% = 0 AND ABS(buttx(po%)) < ring% - 50 AND canjump%(pc%) = 1 AND dif% > RND * 30 AND dist% > 18 THEN AIgetclose pc%, po%



'----------------------------------------------------------- Avoid Projectile
 IF dif% > RND * 25 THEN

  IF pc% = 2 THEN
   IF dif% > RND * 25 THEN
    IF projectile%(1) > 0 AND position%(2) = 1 AND projectilex(1) > buttx(2) - 75 AND projectilex(1) < buttx(2) + 75 THEN
     IF RND < .5 THEN
     jump 2, 2
     ELSE
     IF RND < .5 THEN position%(2) = 99 ELSE position%(2) = 12
     END IF
    END IF
   END IF
  ELSE
   IF projectile%(4) > 0 AND position%(1) = 1 AND projectilex(4) > buttx(1) - 75 AND projectilex(4) < buttx(1) + 75 THEN
    IF RND < .5 THEN
     jump 1, 2
     ELSE
     IF RND < .5 THEN position%(1) = 99 ELSE position%(1) = 12
    END IF
   END IF
  END IF
 END IF





END IF
END SUB

SUB AIattack (pc%, po%)

IF rage(pc%) >= 100 THEN
 'Super
 AIsuper pc%, po%
ELSE
 'Special
 IF ko(pc%) > 25 AND dif% > RND * 30 AND pticker%(pc%) > 20 THEN AImoved% = 1: AIspecial pc%, po%
END IF

'Normal Attack
IF AImoved% = 0 AND butty(po%) > butty(pc%) - 15 THEN
 IF dist% < 18 THEN
  'Attack with Normal Move
  AImoved% = 1
  IF position%(pc%) = 12 AND RND < .5 THEN
  IF RND < .5 AND dist% < 10 THEN position%(pc%) = 13 ELSE IF head%(pc%) <> 666 THEN position%(pc%) = 6
  ELSE
   IF pticker%(pc%) > 15 THEN
    SELECT CASE INT(RND * 5)
    CASE 0: position%(pc%) = 12
    CASE 1: position%(pc%) = 2
    CASE 2: position%(pc%) = 3
    CASE 3: IF stage% <> 15 THEN position%(pc%) = 5
    CASE 4: IF stage% <> 15 THEN position%(pc%) = 6
    END SELECT
   END IF
  END IF
 END IF
END IF

END SUB

SUB AIdefend (pc%, po%)

'Jump or Block if close
IF dist% < 25 THEN
 IF attackok%(pc%) = 1 AND RND < .5 AND pticker%(pc%) > 10 THEN
 position%(pc%) = 99: AImoved% = 1
 ELSE
 IF ABS(buttx(pc%)) < ring% - 50 THEN jump (pc%), (INT(RND * 3) + 1): AImoved% = 1
 END IF
END IF



END SUB

SUB AIfighter (pc%)

'Determine which moves to use for short/long range etc.

'Hand Attacks
SELECT CASE hands%(pc%)
CASE 1
AIhs%(pc%) = 35
AIhm%(pc%) = 35
AIhl%(pc%) = 30
AIhh%(pc%) = 12
CASE 2
IF RND < .5 THEN AIhs%(pc%) = 31 ELSE AIhs%(pc%) = 36
AIhm%(pc%) = 1
AIhl%(pc%) = 1
AIhh%(pc%) = 12
CASE 3
IF RND < .5 THEN AIhs%(pc%) = 32 ELSE AIhs%(pc%) = 37
AIhm%(pc%) = 1
AIhl%(pc%) = 1
AIhh%(pc%) = 37
CASE 4
AIhs%(pc%) = 38
AIhm%(pc%) = 33
AIhl%(pc%) = 33
AIhh%(pc%) = 38
CASE 5
AIhs%(pc%) = 39
AIhm%(pc%) = 34
AIhl%(pc%) = 34
AIhh%(pc%) = 12
END SELECT

'Foot Attacks
SELECT CASE feet%(pc%)
CASE 1
AIfs%(pc%) = 45
AIfm%(pc%) = 40
AIfl%(pc%) = 1
AIfh%(pc%) = 40
CASE 2
IF RND < .5 THEN AIfs%(pc%) = 41 ELSE AIfs%(pc%) = 46
AIfm%(pc%) = 41
AIfl%(pc%) = 1
AIfh%(pc%) = 12
CASE 3
IF RND < .5 THEN AIfs%(pc%) = 42 ELSE AIfs%(pc%) = 47
AIfm%(pc%) = 42
AIfl%(pc%) = 1
AIfh%(pc%) = 47
CASE 4
AIfs%(pc%) = 48
AIfm%(pc%) = 43
AIfl%(pc%) = 48
AIfh%(pc%) = 43
CASE 5
IF RND < .5 THEN AIfs%(pc%) = 44 ELSE AIfs%(pc%) = 49
AIfm%(pc%) = 44
AIfl%(pc%) = 1
AIfh%(pc%) = 49
END SELECT


IF stage% = 15 THEN
AIhs%(pc%) = 35
AIhm%(pc%) = 35
AIhl%(pc%) = 30
AIhh%(pc%) = 13

AIfs%(pc%) = 3
AIfm%(pc%) = 30
AIfl%(pc%) = 30
AIfh%(pc%) = 2
END IF


END SUB

SUB AIgetclose (pc%, po%)

IF RND > .1 THEN

 'Walk
 IF canjump%(pc%) = 1 THEN
 AImoved% = 1
 IF buttx(po%) < buttx(pc%) THEN butth(pc%) = butth(pc%) - .5 ELSE butth(pc%) = butth(pc%) + .5
 END IF

ELSE

 'Jump
 IF dist% > 50 AND canjump%(pc%) = 1 THEN
 AImoved% = 1
 IF buttx(po%) < buttx(pc%) THEN jump (pc%), (1) ELSE jump (pc%), (3)
 END IF

END IF
END SUB

SUB AIspecial (pc%, po%)

IF RND < .5 THEN
 IF butty(po%) > butty(pc%) - 15 THEN
  SELECT CASE dist%
  CASE IS < 20: position%(pc%) = AIhs%(pc%)
  CASE IS >= 20 <= 75: position%(pc%) = AIhm%(pc%)
  CASE IS > 75: position%(pc%) = AIhl%(pc%)
  END SELECT
 ELSE
  IF dist% < 20 THEN position%(pc%) = AIhh%(pc%)
 END IF
ELSE
 IF butty(po%) > butty(pc%) - 15 THEN
  SELECT CASE dist%
  CASE IS < 25: position%(pc%) = AIfs%(pc%)
  CASE IS >= 25 <= 75: position%(pc%) = AIfm%(pc%)
  CASE IS > 75: position%(pc%) = AIfl%(pc%)
  END SELECT
 ELSE
  IF butty(po%) < heady(pc% + 2) AND dist% < 20 THEN position%(pc%) = AIfh%(pc%)
 END IF
END IF


END SUB

SUB AIsuper (pc%, po%)
SELECT CASE body%(pc%)

CASE 1
IF canjump%(pc%) = 1 THEN
IF dist% > 75 THEN position%(pc%) = 81: AImoved% = 1
IF position%(po%) >= 8 AND position%(po%) <= 11 THEN position%(pc%) = 81: AImoved% = 1
END IF

CASE 2
IF dist% > 75 AND position%(po%) < 8 THEN position%(pc%) = 82: AImoved% = 1

CASE 3
IF dist% < 50 AND position%(po%) < 8 THEN position%(pc%) = 83: AImoved% = 1

CASE 4
IF health%(pc%) < 100 THEN position%(pc%) = 84: AImoved% = 1

CASE 5
IF dist% < 100 THEN position%(pc%) = 85: AImoved% = 1

CASE 6
IF dist% < 125 AND canjump%(pc%) = 1 THEN position%(pc%) = 86: AImoved% = 1

CASE 7
IF dist% < 25 AND canjump%(pc%) = 1 THEN position%(pc%) = 87: AImoved% = 1

CASE 8
IF dist% < 20 AND canjump%(pc%) = 1 THEN position%(pc%) = 88: AImoved% = 1

CASE 666
IF dist% < 20 AND canjump%(pc%) = 1 THEN position%(pc%) = 36: AImoved% = 1

END SELECT
END SUB

SUB bigwindow
SCREEN , , 0, 0: COLOR 12, 0

LOCATE 1, 29: PRINT " SFB2: Vector Warriors "

FOR wee = 0 TO 248 STEP 2
LINE (midx% - wee, midy% - 200)-(midy% + wee, midy% + 200), INT((RND * 2) + 7)
NEXT wee

LINE (midx% - wee, midy% - 200)-(midy% + wee, midy% + 200), 0, BF
LINE (midx% - wee, midy% - 200)-(midy% + wee, midy% + 200), 7, B
COLOR 4
IF rez% = 7 THEN LOCATE 22, 35 ELSE LOCATE 22, 75
PRINT ver$
wee$ = ""
END SUB

SUB blur (l%)
IF blurr% = 0 THEN
blurr% = l%
csave% = cfreq%
END IF
END SUB

SUB camdefaults

panx = 0
panh = 0
pany = 0
panv = 0
zoom = .1
zoomd = 0
midx% = 250
midy% = 250

winx = 250
winy = 250

 winxwiny

END SUB

SUB camtracking

SELECT CASE camode%

CASE 0
EXIT SUB

CASE 1
trackx% = (neckx(3) + neckx(4)) / 2
tracky% = ((necky(3) + necky(4)) / 2) - 10

CASE 2
trackx% = (buttx(1) + neckx(3)) / 2
tracky% = ((butty(1) + necky(3)) / 2)

CASE 3
trackx% = (buttx(2) + neckx(4)) / 2
tracky% = ((butty(2) + necky(4)) / 2)

END SELECT

'----------------------------------------------------------------------------

IF panx > trackx% + 30 THEN panh = panh - .5
IF panx < trackx% - 30 THEN panh = panh + .5
IF pany > tracky% + 20 THEN panv = panv - 1
IF pany < tracky% - 20 THEN panv = panv + 1
IF ABS(panh) > 10 THEN panh = panh / 1.1
IF ABS(panv) > 10 THEN panv = panv / 1.1
IF panx > trackx% - 25 AND panx < trackx% + 25 THEN panh = panh / 1.1
IF pany > tracky% - 25 AND pany < tracky% + 25 THEN panv = panv / 1.5


'Zoom Control
IF camode% = 1 THEN
 IF buttx(1) < buttx(2) THEN x = (buttx(2) - buttx(1)) / 1000 ELSE x = (buttx(1) - buttx(2)) / 1000
 IF butty(1) < butty(2) THEN y = (butty(2) - butty(1)) / 1000 ELSE y = (butty(1) - butty(2)) / 1000
 F = (x + y) / 2
 IF zoom < zoomt + F - .001 THEN zoom = zoom + .001
 IF zoom > zoomt + F + .001 THEN zoom = zoom - .001
 IF zoom < zoomt + F - .1 THEN zoomd = zoomd + .001
 IF zoom > zoomt + F + .1 THEN zoomd = zoomd - .001
 IF zoomd < -.005 THEN zoomd = -.005
END IF

'------------------
IF zoom < .0000001 THEN zoom = .0000001
END SUB

SUB cbigwindow

SCREEN , 0, 0
FOR wee = 0 TO 248 STEP 15
LINE (midx% - 248 + wee, midy% - 200)-(midy% + 248 - wee, midy% + 200), INT((RND * 2) + 7)
LINE (midx% - 248, midy% - 200)-(midy% + 248, midy% + 200), 15, B
NEXT wee

wee$ = ""
END SUB

SUB clearscreen
'Blur
IF blurr% > 0 THEN
blurr% = blurr% - 1
IF blurr% = 0 THEN cfreq% = csave% ELSE cfreq% = 1
END IF

IF ctime% > cfreq% THEN
ctime% = 0
SELECT CASE cmethod%

CASE IS = 1
LINE (xx1, yy1)-(xx2, yy2), 0, BF

CASE IS = 2
CLS

CASE IS = 3
window2d
hfade% = hfade% + 5: IF hfade% = 15 THEN hfade% = 0
FOR wee = hfade% TO 95 STEP 15
LINE (0, wee)-(100, wee + 5), 0, BF
NEXT wee
window3d

CASE IS = 4
IF clsb% = 5 THEN clsb% = 0
clsblock (clsb%)
clsb% = clsb% + 1
END SELECT
ELSE ctime% = ctime% + 1
END IF

END SUB

SUB clsblock (n)
window2d
SELECT CASE n

CASE IS = 1
FOR y = 0 TO 90 STEP 10
FOR x = 0 TO 90 STEP 10
LINE (x, y)-(x + 5, y + 5), 0, BF
NEXT x
NEXT y

CASE IS = 2
FOR y = 5 TO 95 STEP 10
FOR x = 5 TO 95 STEP 10
LINE (x, y)-(x + 5, y + 5), 0, BF
NEXT x
NEXT y

CASE IS = 3
FOR y = 0 TO 90 STEP 10
FOR x = 5 TO 95 STEP 10
LINE (x, y)-(x + 5, y + 5), 0, BF
NEXT x
NEXT y

CASE IS = 4
FOR y = 5 TO 95 STEP 10
FOR x = 0 TO 90 STEP 10
LINE (x, y)-(x + 5, y + 5), 0, BF
NEXT x
NEXT y

END SELECT
 window3d
END SUB

SUB Conclusion

'------------------------------------------------------------ Determine Flash
IF victory% = 0 THEN
victory% = 1

 IF health%(1) <= 0 OR health%(2) <= 0 THEN
 soundticker% = 0: sbfx 14
 COLOR , 12
 flicker = TIMER: DO UNTIL TIMER - flicker > .1: LOOP
 COLOR , 0
 END IF
 
 IF ko(1) <= 0 OR ko(2) <= 0 THEN
 soundticker% = 0: sbfx 15
 COLOR , 9
 flicker = TIMER: DO UNTIL TIMER - flicker > .1: LOOP
 COLOR , 0
 END IF

IF frameskip% < 3 THEN tpause% = 2
END IF


'------------------------------- Determine When to Figure Round / Match Info.
IF position%(1) = 8 AND pticker%(1) >= 75 THEN victory% = 2
IF position%(2) = 8 AND pticker%(2) >= 75 THEN victory% = 2
IF position%(1) = 10 AND pticker%(1) >= 75 THEN victory% = 2
IF position%(2) = 10 AND pticker%(2) >= 75 THEN victory% = 2

IF victory% = 2 THEN
victory% = 0

'------------------------------------------------------ Determine Round Info.
SCREEN , , 0, 0
LOCATE 5
COLOR 9
IF ko(1) <= 0 AND health%(1) > 0 THEN PRINT name$(1) + " - KO": win%(2) = win%(2) + 1
IF ko(2) <= 0 AND health%(2) > 0 THEN PRINT name$(2) + " - KO": win%(1) = win%(1) + 1
IF ko(1) <= 0 AND ko(2) <= 0 THEN PRINT "Double KO"
COLOR 12
IF health%(1) <= 0 THEN PRINT name$(1) + " - Dead": win%(2) = 2
IF health%(2) <= 0 THEN PRINT name$(2) + " - Dead": win%(1) = 2

'------------------------------------------------------ Determine Match Info.
COLOR 15

IF win%(1) > 1 AND win%(2) > 1 THEN
PRINT "Tie Match": win%(1) = 1: win%(2) = 1
 IF health%(1) <= 0 AND health%(2) <= 0 THEN
  IF ringoutp% <> 1 AND ringoutp% <> 3 THEN
  PRINT "Resurrecting Players To Continue"
  decap 3
  health%(1) = 100
  health%(2) = 100
  particle (headx(3)), (heady(3)), (fighterz(1)), 5, 10
  particle (headx(4)), (heady(4)), (fighterz(2)), 5, 10
  ELSE
  PRINT name$(2) + " Takes Win"
  newmatch
  END IF
 END IF

ELSE

IF win%(1) > 1 OR win%(2) > 1 THEN
 IF win%(1) > 1 AND win%(2) < 2 THEN PRINT name$(1) + " Wins the Match": stage% = stage% + 1: setfightercpu
 IF win%(2) > 1 AND win%(1) < 2 THEN PRINT name$(2) + " Wins the Match": IF stage% > stages% THEN setfightercpu
 newmatch
END IF
END IF

'----------------------------------------------------------------------------

wee = TIMER
34 IF TIMER - wee < 3 THEN 34

setko (1): setko (2)

END IF
END SUB

SUB csmallwindow


SCREEN , 0, 0
FOR wee = 0 TO 248 STEP 3
LINE (midx% - 248 + wee, midy% - 75)-(midy% + 248 - wee, midy% + 75), INT((RND * 2) + 7)
LINE (midx% - 248, midy% - 75)-(midy% + 248, midy% + 75), 15, B
NEXT wee

wee$ = ""
END SUB

SUB decap (n%)

IF n% = 3 THEN
 headless%(1) = 0: headless%(2) = 0
ELSE
 IF headless%(n%) = 0 THEN
 bgcolor% = 15
 camode% = n% + 1
 zoomd = zoomd + .001
 headless%(n%) = 1
 hx(n%) = headx(n% + 2)
 hy(n%) = heady(n% + 2)
 hh(n%) = (RND - .5) * 2
 hv(n%) = -12
 END IF
END IF
END SUB

SUB decay
FOR wee = 1 TO particles%

IF p%(wee) > 0 THEN
p%(wee) = p%(wee) - 1
IF p%(wee) = 15 THEN pc1%(wee) = pc2%(wee)
IF p%(wee) = 5 THEN pc1%(wee) = pc3%(wee)

IF pk%(wee) = 1 AND py(wee) > floor1 - pv(wee) AND ABS(px(wee)) < ring% - 8 THEN
  IF py(wee) < floor1 + 15 AND RND < .4 THEN smear (px(wee) + ((RND - .5) * 8)), (floor1), (pz(wee) + (RND - .5)), (pc1%(wee))
  p%(wee) = 0
  END IF

 IF pk%(wee) = 2 AND py(wee) > floor2 - pv(wee) THEN p%(wee) = 0
END IF
NEXT wee

FOR wee = 1 TO 10
IF smearl%(wee) > 0 THEN
 smearl%(wee) = smearl%(wee) + 1
 IF smearl%(wee) = 60 AND smearc%(wee) = 12 THEN smearc%(wee) = 4
END IF
NEXT wee

'Razer Arms
FOR wee = 1 TO 2
IF razers%(wee) > 0 THEN
 razers%(wee) = razers%(wee) - 1
 IF razers%(wee) = 1 THEN
  pc2 = wee + 2
  particle (hand1x(pc2)), (hand1y(pc2)), (fighterz(wee) + .2), 15, 5
  particle (hand2x(pc2)), (hand2y(pc2)), (fighterz(wee) - .2), 15, 5
 END IF
END IF
NEXT wee

END SUB

DEFINT A-Z
FUNCTION DetectCard%

'Returns -1 (true) if detected and 0 (false) if not.
                                                        
CALL SBWrite(&H4, &H60)
CALL SBWrite(&H4, &H80)
B = INP(&H388)
CALL SBWrite(&H2, &HFF)
CALL SBWrite(&H4, &H21)
FOR x = 0 TO 130
a = INP(&H388)
NEXT x
c = INP(&H388)
CALL SBWrite(&H4, &H60)
CALL SBWrite(&H4, &H80)
SUCCESS = 0
IF (B AND &HE0) = &H0 THEN
IF (c AND &HE0) = &HC0 THEN
SUCCESS = -1
END IF
END IF
DetectCard% = SUCCESS
END FUNCTION

DEFSNG A-Z
SUB errorkey
wee = 2
wee$ = ""

LOCATE 21, 1
PRINT "E-mail lbt1st@cyberdude.com if problem persist. SFB2 Version " + ver$
PRINT "[                  ] - System may be halted if inanimate"
24
wee$ = UCASE$(INKEY$)

wee = wee + .005
IF INT(wee) = 20 THEN wee = 2: LOCATE 22, 19: PRINT " "
LOCATE 22, INT(wee): PRINT "*"
IF INT(wee) > 2 THEN LOCATE 22, INT(wee) - 1: PRINT " "

IF wee$ = "" THEN 24
IF wee$ = CHR$(27) THEN SYSTEM

IF UCASE$(wee$) = "D" THEN
SHELL "del slash.dat"
SHELL "echo Slash Attempted to Delete SLASH.DAT"
SHELL "echo You May Now Try to Restart the Program."
SYSTEM
END IF


END SUB

SUB fades
IF bgcolor% <> 0 THEN

SELECT CASE bgcolor%
CASE 19
COLOR , 15
bgcolor% = 9

CASE 15
COLOR , 15
bgcolor% = 12

CASE 12
COLOR , 12
bgcolor% = 4

CASE 9
COLOR , 9
bgcolor% = 1

CASE 4
COLOR , 4
bgcolor% = -1

CASE 1
COLOR , 1
bgcolor% = -1

CASE -1
COLOR , 0
bgcolor% = 0

END SELECT
END IF
END SUB

SUB fall (n)

IF d%(n) = 1 AND butth(n) < 0 THEN position%(n) = 10
IF d%(n) = -1 AND butth(n) < 0 THEN position%(n) = 8
IF d%(n) = 1 AND butth(n) > 0 THEN position%(n) = 8
IF d%(n) = -1 AND butth(n) > 0 THEN position%(n) = 10
IF position%(n) < 8 OR position%(n) > 11 THEN position%(n) = 10

END SUB

SUB fightercompress (n%)
headx(n%) = 0
neckx(n%) = 0

elbow1x(n%) = 0
elbow2x(n%) = 0
hand1x(n%) = 0
hand2x(n%) = 0

nee1x(n%) = 0
nee2x(n%) = 0
foot1x(n%) = 0
foot2x(n%) = 0

heady(n%) = 0
necky(n%) = 0

elbow1y(n%) = 0
elbow2y(n%) = 0
hand1y(n%) = 0
hand2y(n%) = 0

nee1y(n%) = 0
nee2y(n%) = 0
foot1y(n%) = 0
foot2y(n%) = 0

END SUB

SUB fighterdirect

'------------------------------------------------------------- Flip Direction
FOR wee = 1 TO 2

IF wee = 1 AND position%(1) = 1 AND pticker%(1) > 20 AND canjump%(1) = 1 THEN
IF buttx(1) > buttx(2) THEN d%(wee) = -1 ELSE d%(wee) = 1
END IF

IF wee = 2 AND position%(2) = 1 AND pticker%(2) > 20 AND canjump%(2) = 1 THEN
IF buttx(1) < buttx(2) THEN d%(wee) = -1 ELSE d%(wee) = 1
END IF

NEXT wee
END SUB

SUB fighterender

FOR wee = 1 TO 2
wee2 = wee + 2
fm1 = fighterz(wee) - .1
fp1 = fighterz(wee) + .1

IF position%(wee) = 0 THEN 36

'----------------------------------------------- High Detail Fighter Graphics
IF fighterdetail% = 1 THEN

midbodx = buttx(wee) + ((neckx(wee2) - buttx(wee)) / 2)
midbody = necky(wee2) + ((butty(wee) - necky(wee2)) / 2)


'---------------------------------------------------------------- Render Hair
'P1
IF position%(1) > 0 AND hairl%(1) > 0 AND wee = 1 THEN
FOR n% = 1 TO 4
SELECT CASE hairt%(1)
CASE 1: psline (hairx(n%)), (hairy(n%)), (fighterz(1)), (hairx(n% + 1)), (hairy(n% + 1)), (fighterz(1)), (hairc%(1)), 0
CASE 2: pscline (hairx(n%)), (hairy(n%)), (fighterz(1)), (hairx(n% + 1)), (hairy(n% + 1)), (fighterz(1)), .2, (hairc%(1))
END SELECT
NEXT n%
END IF

'P2
IF position%(2) > 0 AND hairl%(2) > 0 AND wee = 2 THEN
FOR n% = 6 TO 9
SELECT CASE hairt%(2)
CASE 1: psline (hairx(n%)), (hairy(n%)), (fighterz(2)), (hairx(n% + 1)), (hairy(n% + 1)), (fighterz(2)), (hairc%(2)), 0
CASE 2: pscline (hairx(n%)), (hairy(n%)), (fighterz(2)), (hairx(n% + 1)), (hairy(n% + 1)), (fighterz(2)), .2, (hairc%(2))
END SELECT
NEXT n%
END IF



'---------------------------------------------------------------- Razer Arm-1
IF razers%(wee) > 0 THEN
IF razers%(wee) > 50 THEN c% = flash3% ELSE c% = 4
psline (elbow1x(wee2) + (hand1x(wee) / 2) * d%(wee)), (elbow1y(wee2) + (hand1y(wee) / 2)), (fp1 + .1), (elbow1x(wee2) + (hand1x(wee) * 2) * d%(wee)), (elbow1y(wee2) + (hand1y(wee) * 2)), (fp1 + .1), c%, 0
END IF


'---------------------------------------------------------------------- Heads
IF headless%(wee) = 1 THEN headx(wee2) = hx(wee): heady(wee2) = hy(wee)

SELECT CASE head%(wee)
CASE 1
pscircle (headx(wee2)), (heady(wee2)), (fighterz(wee)), 1.5, headc%(wee)

CASE 2
psline (headx(wee2) + 1 * d%(wee)), (heady(wee2) - 1), (fighterz(wee)), (headx(wee2) + 1 * d%(wee)), (heady(wee2) + 2), (fighterz(wee)), headc%(wee), 0
psline (headx(wee2) + 1 * d%(wee)), (heady(wee2) - 1), (fighterz(wee)), (headx(wee2) - 2 * d%(wee)), (heady(wee2) - 3), (fighterz(wee)), headc%(wee), 0
psline (headx(wee2) - 2 * d%(wee)), (heady(wee2) - 3), (fighterz(wee)), (headx(wee2) + 1 * d%(wee)), (heady(wee2) + 2), (fighterz(wee)), headc%(wee), 0
psline (headx(wee2) - 1 * d%(wee)), (heady(wee2) + 2), (fighterz(wee)), (headx(wee2) + 1 * d%(wee)), (heady(wee2) + 2), (fighterz(wee)), headc%(wee), 0
psline (headx(wee2) - 2 * d%(wee)), (heady(wee2) - 3), (fighterz(wee)), (headx(wee2) - 1 * d%(wee)), (heady(wee2) + 2), (fighterz(wee)), headc%(wee), 0


CASE 3
psline (headx(wee2) - 1 * d%(wee)), (heady(wee2) - 2), (fighterz(wee)), (headx(wee2) + 2 * d%(wee)), (heady(wee2) + 1), (fighterz(wee)), headc%(wee), 0
psline (headx(wee2) - 2 * d%(wee)), (heady(wee2) + 1), (fighterz(wee)), (headx(wee2) + 2 * d%(wee)), (heady(wee2) + 1), (fighterz(wee)), headc%(wee), 0
psline (headx(wee2) - 2 * d%(wee)), (heady(wee2) + 1), (fighterz(wee)), (headx(wee2) - 1 * d%(wee)), (heady(wee2) - 2), (fighterz(wee)), headc%(wee), 0

CASE 4
pscircle (headx(wee2)), (heady(wee2)), (fighterz(wee)), 1.5, headc%(wee)
psline (headx(wee2) - 3 * d%(wee)), (heady(wee2)), (fighterz(wee)), (headx(wee2)), (heady(wee2)), (fighterz(wee)), headc%(wee), 0
psline (headx(wee2)), (heady(wee2)), (fighterz(wee)), (headx(wee2) + 2 * d%(wee)), (heady(wee2) + 2), (fighterz(wee)), headc%(wee), 0

CASE 5
psline (headx(wee2)), (heady(wee2) - 2), (fighterz(wee)), (headx(wee2) + 1 * d%(wee)), (heady(wee2) + 2), (fighterz(wee)), headc%(wee), 0
psline (headx(wee2) - 2 * d%(wee)), (heady(wee2) - 2), (fighterz(wee)), (headx(wee2) + 1 * d%(wee)), (heady(wee2) + 2), (fighterz(wee)), headc%(wee), 0
psline (headx(wee2) - 3 * d%(wee)), (heady(wee2)), (fighterz(wee)), (headx(wee2) + 1 * d%(wee)), (heady(wee2) + 2), (fighterz(wee)), headc%(wee), 0
psline (headx(wee2) - 3 * d%(wee)), (heady(wee2) + 2), (fighterz(wee)), (headx(wee2) + 1 * d%(wee)), (heady(wee2) + 2), (fighterz(wee)), headc%(wee), 0

CASE 666
psline (headx(wee2) - 2 * d%(wee)), (heady(wee2) - 1), (fighterz(wee) + .05), (headx(wee2) - 3 * d%(wee)), (heady(wee2) - 3), (fighterz(wee) + .3), 7, 0

psline (headx(wee2) - 2 * d%(wee)), (heady(wee2) - 2), (fp1), (headx(wee2) + 1 * d%(wee)), (heady(wee2) + 2), (fighterz(wee)), 12, 0
psline (headx(wee2) - 2 * d%(wee)), (heady(wee2) - 2), (fm1), (headx(wee2) + 1 * d%(wee)), (heady(wee2) + 2), (fighterz(wee)), 12, 0
psline (headx(wee2) - 3 * d%(wee)), (heady(wee2) + 2), (fighterz(wee)), (headx(wee2) + 1 * d%(wee)), (heady(wee2) + 2), (fighterz(wee)), 12, 0
pscircle (headx(wee2) - 2.5 * d%(wee)), (heady(wee2) + .1), (fighterz(wee)), 1.5, 12

psline (headx(wee2) - 2 * d%(wee)), (heady(wee2) - 1), (fighterz(wee) - .05), (headx(wee2) - 3 * d%(wee)), (heady(wee2) - 3), (fighterz(wee) - .3), 15, 0


CASE 1998
pslightning (headx(wee2) + (RND - .5) * 3), (heady(wee2) + (RND - .5) * 3), (fighterz(wee)), (headx(wee2) + (RND - .5) * 3), (heady(wee2) + (RND - .5) * 3), (fighterz(wee)), 5, flash2%



CASE 2000
pscircle (headx(wee2)), (heady(wee2)), (fighterz(wee)), RND, headc%(wee)
pscircle (headx(wee2)), (heady(wee2)), (fighterz(wee)), 1.5, headc%(wee)

END SELECT


'---------------------------------------------------------------------- Arm-1
SELECT CASE arms%(wee)
CASE 1
psline (neckx(wee2)), (necky(wee2)), (fighterz(wee)), (elbow1x(wee2)), (elbow1y(wee2)), (fp1), armsc%(wee), 0
psline (neckx(wee2)), (necky(wee2) + 1), (fighterz(wee)), (elbow1x(wee2)), (elbow1y(wee2)), (fp1), armsc%(wee), 0
psline (elbow1x(wee2)), (elbow1y(wee2)), (fp1), (hand1x(wee2)), (hand1y(wee2)), (fp1), armsc%(wee), 0

CASE 2
psline (neckx(wee2)), (necky(wee2)), (fighterz(wee)), (elbow1x(wee2)), (elbow1y(wee2)), (fp1), armsc%(wee), 0
psline (elbow1x(wee2)), (elbow1y(wee2)), (fp1), (hand1x(wee2)), (hand1y(wee2)), (fp1), armsc%(wee), 0
psline (neckx(wee2)), (necky(wee2) + 2), (fighterz(wee)), (elbow1x(wee2)), (elbow1y(wee2)), (fp1), armsc%(wee), 0
psline (elbow1x(wee2)), (elbow1y(wee2) + 1), (fp1), (hand1x(wee2)), (hand1y(wee2)), (fp1), armsc%(wee), 0

CASE 3
psline (neckx(wee2)), (necky(wee2)), (fighterz(wee)), (elbow1x(wee2)), (elbow1y(wee2)), (fp1), armsc%(wee), 0
psline (elbow1x(wee2)), (elbow1y(wee2)), (fp1), (hand1x(wee2)), (hand1y(wee2)), (fp1), armsc%(wee), 0
psline (midbodx), (necky(wee2) + 1), (fighterz(wee)), (elbow1x(wee2)), (elbow1y(wee2) + 1), (fp1), armsc%(wee), 0
psline (elbow1x(wee2)), (elbow1y(wee2) + 1), (fp1), (hand1x(wee2)), (hand1y(wee2) + .5), (fp1), armsc%(wee), 0

CASE 4
psline (neckx(wee2) - .5 * d%(wee)), (necky(wee2) - .5), (fighterz(wee)), (elbow1x(wee2)), (elbow1y(wee2)), (fp1), armsc%(wee), 0
psline (neckx(wee2) + .8 * d%(wee)), (necky(wee2) + .5), (fighterz(wee)), (elbow1x(wee2)), (elbow1y(wee2)), (fp1), armsc%(wee), 0
psline (elbow1x(wee2) - .3 * d%(wee)), (elbow1y(wee2) - .5), (fp1), (hand1x(wee2)), (hand1y(wee2)), (fp1), armsc%(wee), 0
psline (elbow1x(wee2) + .3 * d%(wee)), (elbow1y(wee2) + .5), (fp1), (hand1x(wee2)), (hand1y(wee2)), (fp1), armsc%(wee), 0
pscircle (neckx(wee2) + elbow1x(wee) / 2 * d%(wee)), (necky(wee2) + elbow1y(wee) / 2), (fp1), .8, armsc%(wee)
pscircle (elbow1x(wee2) + hand1x(wee) / 2 * d%(wee)), (elbow1y(wee2) + hand1y(wee) / 2), (fp1), .5, armsc%(wee)

CASE 5
psline (neckx(wee2) - .5 * d%(wee)), (necky(wee2) - .5), (fighterz(wee)), (elbow1x(wee2) + .5 * d%(wee)), (elbow1y(wee2) + .5), (fp1), armsc%(wee), 0
psline (neckx(wee2) + .8 * d%(wee)), (necky(wee2) + .5), (fighterz(wee)), (elbow1x(wee2) - .5 * d%(wee)), (elbow1y(wee2) - .5), (fp1), armsc%(wee), 0
psline (elbow1x(wee2) - .3 * d%(wee)), (elbow1y(wee2) - .5), (fp1), (hand1x(wee2)), (hand1y(wee2)), (fp1), armsc%(wee), 0
psline (elbow1x(wee2) + .3 * d%(wee)), (elbow1y(wee2) + .5), (fp1), (hand1x(wee2)), (hand1y(wee2)), (fp1), armsc%(wee), 0
psline (elbow1x(wee2) - .7), (elbow1y(wee2) - .7), (fp1), (elbow1x(wee2) + .7), (elbow1y(wee2) + .7), (fp1), armsc%(wee), 1

CASE 666
psline (neckx(wee2) - 3 * d%(wee)), (necky(wee2) + 2), (fp1), (elbow1x(wee2)), (elbow1y(wee2)), (fighterz(wee) + .2), 4, 0
psline (neckx(wee2)), (necky(wee2)), (fighterz(wee)), (elbow1x(wee2)), (elbow1y(wee2)), (fighterz(wee) + .2), 4, 0
psline (elbow1x(wee2) - .8 * d%(wee)), (elbow1y(wee2) - .8), (fighterz(wee) + .2), (hand1x(wee2)), (hand1y(wee2)), (fighterz(wee) + .2), 4, 0
psline (elbow1x(wee2)), (elbow1y(wee2) + .8), (fighterz(wee) + .2), (hand1x(wee2)), (hand1y(wee2)), (fighterz(wee) + .2), 4, 0

CASE 1998
pslightning (neckx(wee2)), (necky(wee2)), (fighterz(wee)), (elbow1x(wee2)), (elbow1y(wee2)), (fp1), 1, flash2%
pslightning (elbow1x(wee2)), (elbow1y(wee2)), (fp1), (hand1x(wee2)), (hand1y(wee2)), (fp1), 1, flash2%

CASE 2000
pscline (neckx(wee2)), (necky(wee2)), (fighterz(wee)), (elbow1x(wee2)), (elbow1y(wee2)), (fp1), .8, armsc%(wee)
pscline (elbow1x(wee2)), (elbow1y(wee2)), (fp1), (hand1x(wee2)), (hand1y(wee2)), (fp1), .5, armsc%(wee)

END SELECT



'--------------------------------------------------------------------- Hand-1
SELECT CASE hands%(wee)
CASE 1
psline (hand1x(wee2) - .6), (hand1y(wee2) - .6), (fp1), (hand1x(wee2) + .6), (hand1y(wee2) + .6), (fp1), handsc%(wee), 0
psline (hand1x(wee2) + .6), (hand1y(wee2) - .6), (fp1), (hand1x(wee2) - .6), (hand1y(wee2) + .6), (fp1), handsc%(wee), 0

CASE 2
psline (hand1x(wee2) - .6), (hand1y(wee2) - .6), (fp1), (hand1x(wee2) + .6), (hand1y(wee2) + .6), (fp1), handsc%(wee), 1

CASE 3
IF position%(wee) = 13 OR position%(wee) = 37 OR position%(wee) = 88 THEN
psline (hand1x(wee2) - .5), (hand1y(wee2) - 1), (fp1), (hand1x(wee2)), (hand1y(wee2) + 2), (fp1), handsc%(wee), 0
psline (hand1x(wee2) + .5), (hand1y(wee2) - 1), (fp1), (hand1x(wee2)), (hand1y(wee2) + 2), (fp1), handsc%(wee), 0
ELSE
psline (hand1x(wee2) + 2 * d%(wee)), (hand1y(wee2)), (fp1), (hand1x(wee2) - .5 * d%(wee)), (hand1y(wee2) - .6), (fp1), handsc%(wee), 0
psline (hand1x(wee2) + 2 * d%(wee)), (hand1y(wee2)), (fp1), (hand1x(wee2) - .5 * d%(wee)), (hand1y(wee2) + .6), (fp1), handsc%(wee), 0
END IF

CASE 4, 2000
pscircle (hand1x(wee2)), (hand1y(wee2)), (fp1), .5, handsc%(wee)

CASE 5
psline (hand1x(wee2)), (hand1y(wee2) - .8), (fp1), (hand1x(wee2) - .8), (hand1y(wee2)), (fp1), handsc%(wee), 0
psline (hand1x(wee2)), (hand1y(wee2) + .8), (fp1), (hand1x(wee2) - .8), (hand1y(wee2)), (fp1), handsc%(wee), 0
psline (hand1x(wee2)), (hand1y(wee2) - .8), (fp1), (hand1x(wee2) + .8), (hand1y(wee2)), (fp1), handsc%(wee), 0
psline (hand1x(wee2)), (hand1y(wee2) + .8), (fp1), (hand1x(wee2) + .8), (hand1y(wee2)), (fp1), handsc%(wee), 0

CASE 666
psline (hand1x(wee2) - 1), (hand1y(wee2) - 1), (fp1), (hand1x(wee2) + 1), (hand1y(wee2) + 1), (fp1), 6, 1



END SELECT


'---------------------------------------------------------------------- Bodys
SELECT CASE body%(wee)
CASE 1
psline (buttx(wee)), (butty(wee)), (fighterz(wee)), (neckx(wee2)), (necky(wee2)), (fighterz(wee)), bodyc%(wee), 0
psline (buttx(wee)), (butty(wee) + 1), (fighterz(wee)), (neckx(wee2)), (necky(wee2) + 2), (fighterz(wee)), bodyc%(wee), 0

CASE 2
psline (buttx(wee)), (butty(wee)), (fighterz(wee)), (neckx(wee2)), (necky(wee2)), (fighterz(wee)), bodyc%(wee), 0
psline (buttx(wee)), (butty(wee)), (fighterz(wee)), (neckx(wee2)), (midbody), (fighterz(wee)), bodyc%(wee), 0
psline (neckx(wee2)), (necky(wee2)), (fighterz(wee)), (neckx(wee2)), (midbody), (fighterz(wee)), bodyc%(wee), 0

CASE 3
psline (buttx(wee)), (butty(wee)), (fighterz(wee)), (midbodx), (midbody), (fighterz(wee)), bodyc%(wee), 0
psline (neckx(wee2) + 2 * d%(wee)), (necky(wee2)), (fighterz(wee)), (midbodx - 1 * d%(wee)), (midbody), (fighterz(wee)), bodyc%(wee), 0
psline (neckx(wee2) - 1 * d%(wee)), (necky(wee2)), (fighterz(wee)), (midbodx + 1 * d%(wee)), (midbody), (fighterz(wee)), bodyc%(wee), 0

CASE 4
psline (buttx(wee)), (butty(wee)), (fighterz(wee)), (midbodx - 1), (midbody), (fighterz(wee)), bodyc%(wee), 0
psline (buttx(wee)), (butty(wee)), (fighterz(wee)), (midbodx + 1), (midbody), (fighterz(wee)), bodyc%(wee), 0
pscircle (neckx(wee2) - (ABS(neckx(wee) / 10) * d%(wee))), (midbody - ABS(necky(wee) / 4)), (fighterz(wee)), 1.3, bodyc%(wee)

CASE 5
psline (buttx(wee)), (butty(wee)), (fighterz(wee)), (neckx(wee2)), (necky(wee2)), (fighterz(wee)), bodyc%(wee), 0
psline (buttx(wee)), (butty(wee)), (fighterz(wee)), (midbodx), (necky(wee2)), (fighterz(wee)), bodyc%(wee), 0
psline (neckx(wee2)), (necky(wee2)), (fighterz(wee)), (midbodx), (necky(wee2)), (fighterz(wee)), bodyc%(wee), 0
psline (neckx(wee2)), (necky(wee2)), (fighterz(wee)), buttx(wee), (necky(wee2) - 2), (fighterz(wee)), bodyc%(wee), 0
psline (neckx(wee2)), (necky(wee2)), (fighterz(wee)), (neckx(wee2)), (midbody), (fighterz(wee)), bodyc%(wee), 0

CASE 6
psline (buttx(wee)), (butty(wee)), (fighterz(wee)), (midbodx), (midbody), (fighterz(wee)), bodyc%(wee), 0
psline (neckx(wee2) - 3 * d%(wee)), (necky(wee2) - 1), (fighterz(wee)), (neckx(wee2)), (necky(wee2) + 1), (fighterz(wee)), bodyc%(wee), 0
psline (neckx(wee2) - 2.5 * d%(wee)), (necky(wee2) + ABS(necky(wee) / 4)), (fighterz(wee)), (neckx(wee2)), (necky(wee2) + ABS(necky(wee) / 4) + 1), (fighterz(wee)), bodyc%(wee), 0
psline (neckx(wee2) - 2 * d%(wee)), (necky(wee2) + ABS(necky(wee) / 2)), (fighterz(wee)), (neckx(wee2)), (necky(wee2) + ABS(necky(wee) / 2) + 1), (fighterz(wee)), bodyc%(wee), 0

CASE 7
psline (buttx(wee) - 1 * d%(wee)), (butty(wee)), (fighterz(wee)), (neckx(wee2)), (necky(wee2)), (fighterz(wee)), bodyc%(wee), 0
psline (buttx(wee) + 1 * d%(wee)), (butty(wee)), (fighterz(wee)), (midbodx), (necky(wee2)), (fighterz(wee)), bodyc%(wee), 0
psline (neckx(wee2)), (necky(wee2)), (fighterz(wee)), (midbodx), (necky(wee2)), (fighterz(wee)), bodyc%(wee), 0
psline (neckx(wee2)), (necky(wee2)), (fighterz(wee)), buttx(wee), (necky(wee2) - 2), (fighterz(wee)), bodyc%(wee), 0
psline (neckx(wee2)), (necky(wee2)), (fighterz(wee)), (neckx(wee2)), (midbody), (fighterz(wee)), bodyc%(wee), 0

CASE 8
psline (buttx(wee)), (butty(wee)), (fighterz(wee)), (neckx(wee2)), (midbody), (fighterz(wee)), bodyc%(wee), 0
psline (neckx(wee2)), (necky(wee2)), (fighterz(wee)), (neckx(wee2)), (midbody), (fighterz(wee)), bodyc%(wee), 0
psline (buttx(wee)), (butty(wee)), (fighterz(wee)), (midbodx), (necky(wee2)), (fighterz(wee)), bodyc%(wee), 0
psline (neckx(wee2)), (necky(wee2)), (fighterz(wee)), (midbodx), (necky(wee2)), (fighterz(wee)), bodyc%(wee), 0

CASE 666
psline (buttx(wee)), (butty(wee)), (fighterz(wee)), (neckx(wee2)), (midbody), (fighterz(wee)), 12, 0
psline (neckx(wee2)), (necky(wee2)), (fighterz(wee)), (neckx(wee2)), (midbody), (fighterz(wee)), 12, 0
psline (buttx(wee)), (butty(wee)), (fighterz(wee)), (midbodx - 2 * d%(wee)), (necky(wee2) - 2), (fighterz(wee)), 12, 0
psline (neckx(wee2)), (necky(wee2)), (fighterz(wee)), (midbodx - 2 * d%(wee)), (necky(wee2) - 2), (fighterz(wee)), 12, 0
pscube (buttx(wee) - 1 * d%(wee)), (butty(wee) - 3), (fm1), (buttx(wee) + 2 * d%(wee)), (butty(wee)), (fp1), 12, 6, 4

CASE 1998
pslightning (buttx(wee)), (butty(wee)), (fighterz(wee)), (neckx(wee2)), (necky(wee2)), (fighterz(wee)), 3, flash1%

CASE 2000
pscline (buttx(wee)), (butty(wee)), (fighterz(wee)), (neckx(wee2)), (necky(wee2)), (fighterz(wee)), 1, bodyc%(wee)

END SELECT

'---------------------------------------------------------------------- Arm-2
c% = armsc%(wee) + 8

SELECT CASE arms%(wee)
CASE 1
psline (neckx(wee2)), (necky(wee2)), (fighterz(wee)), (elbow2x(wee2)), (elbow2y(wee2)), (fm1), c%, 0
psline (neckx(wee2)), (necky(wee2) + 1), (fighterz(wee)), (elbow2x(wee2)), (elbow2y(wee2)), (fm1), c%, 0
psline (elbow2x(wee2)), (elbow2y(wee2)), (fm1), (hand2x(wee2)), (hand2y(wee2)), (fm1), c%, 0

CASE 2
psline (neckx(wee2)), (necky(wee2)), (fighterz(wee)), (elbow2x(wee2)), (elbow2y(wee2)), (fm1), c%, 0
psline (elbow2x(wee2)), (elbow2y(wee2)), (fm1), (hand2x(wee2)), (hand2y(wee2)), (fm1), c%, 0
psline (neckx(wee2)), (necky(wee2) + 2), (fighterz(wee)), (elbow2x(wee2)), (elbow2y(wee2)), (fm1), c%, 0
psline (elbow2x(wee2)), (elbow2y(wee2) + 1), (fm1), (hand2x(wee2)), (hand2y(wee2)), (fm1), c%, 0

CASE 3
psline (neckx(wee2)), (necky(wee2)), (fighterz(wee)), (elbow2x(wee2)), (elbow2y(wee2)), (fm1), c%, 0
psline (elbow2x(wee2)), (elbow2y(wee2)), (fm1), (hand2x(wee2)), (hand2y(wee2)), (fm1), c%, 0
psline (midbodx), (necky(wee2) - 1), (fighterz(wee)), (elbow2x(wee2)), (elbow2y(wee2) + 1), (fm1), c%, 0
psline (elbow2x(wee2)), (elbow2y(wee2) - 1), (fm1), (hand2x(wee2)), (hand2y(wee2) + .5), (fm1), c%, 0

CASE 4
psline (neckx(wee2) - .5 * d%(wee)), (necky(wee2) - .5), (fighterz(wee)), (elbow2x(wee2)), (elbow2y(wee2)), (fm1), c%, 0
psline (neckx(wee2) + .8 * d%(wee)), (necky(wee2) + .5), (fighterz(wee)), (elbow2x(wee2)), (elbow2y(wee2)), (fm1), c%, 0
psline (elbow2x(wee2) - .3 * d%(wee)), (elbow2y(wee2) - .5), (fm1), (hand2x(wee2)), (hand2y(wee2)), (fm1), c%, 0
psline (elbow2x(wee2) + .3 * d%(wee)), (elbow2y(wee2) + .5), (fm1), (hand2x(wee2)), (hand2y(wee2)), (fm1), c%, 0
pscircle (neckx(wee2) + elbow2x(wee) / 2 * d%(wee)), (necky(wee2) + elbow2y(wee) / 2), (fm1), .8, c%
pscircle (elbow2x(wee2) + hand2x(wee) / 2 * d%(wee)), (elbow2y(wee2) + hand2y(wee) / 2), (fm1), .5, c%

CASE 5
psline (neckx(wee2) - .5 * d%(wee)), (necky(wee2) - .5), (fighterz(wee)), (elbow2x(wee2) + .5 * d%(wee)), (elbow2y(wee2) + .5), (fm1), c%, 0
psline (neckx(wee2) + .8 * d%(wee)), (necky(wee2) + .5), (fighterz(wee)), (elbow2x(wee2) - .5 * d%(wee)), (elbow2y(wee2) - .5), (fm1), c%, 0
psline (elbow2x(wee2) - .3 * d%(wee)), (elbow2y(wee2) - .5), (fm1), (hand2x(wee2)), (hand2y(wee2)), (fm1), c%, 0
psline (elbow2x(wee2) + .3 * d%(wee)), (elbow2y(wee2) + .5), (fm1), (hand2x(wee2)), (hand2y(wee2)), (fm1), c%, 0
psline (elbow2x(wee2) - .7), (elbow2y(wee2) - .7), (fm1), (elbow2x(wee2) + .7), (elbow2y(wee2) + .7), (fm1), c%, 1

CASE 666
psline (neckx(wee2) - 3 * d%(wee)), (necky(wee2) + 2), (fm1), (elbow2x(wee2)), (elbow2y(wee2)), (fighterz(wee) - .2), 12, 0
psline (neckx(wee2)), (necky(wee2)), (fighterz(wee)), (elbow2x(wee2)), (elbow2y(wee2)), (fighterz(wee) - .2), 12, 0
psline (elbow2x(wee2) - .8 * d%(wee)), (elbow2y(wee2) - .8), (fighterz(wee) - .2), (hand2x(wee2)), (hand2y(wee2)), (fighterz(wee) - .2), 12, 0
psline (elbow2x(wee2)), (elbow2y(wee2) + .8), (fighterz(wee) - .2), (hand2x(wee2)), (hand2y(wee2)), (fighterz(wee) - .2), 12, 0

CASE 1998
pslightning (neckx(wee2)), (necky(wee2)), (fighterz(wee)), (elbow2x(wee2)), (elbow2y(wee2)), (fm1), 1, flash2%
pslightning (elbow2x(wee2)), (elbow2y(wee2)), (fm1), (hand2x(wee2)), (hand2y(wee2)), (fm1), 1, flash2%

CASE 2000
pscline (neckx(wee2)), (necky(wee2)), (fighterz(wee)), (elbow2x(wee2)), (elbow2y(wee2)), (fm1), .8, c%
pscline (elbow2x(wee2)), (elbow2y(wee2)), (fm1), (hand2x(wee2)), (hand2y(wee2)), (fm1), .5, c%

END SELECT

'--------------------------------------------------------------------- Hand-2
c% = handsc%(wee) + 8

SELECT CASE hands%(wee)
CASE 1
psline (hand2x(wee2) - .6), (hand2y(wee2) - .6), (fm1), (hand2x(wee2) + .6), (hand2y(wee2) + .6), (fm1), c%, 0
psline (hand2x(wee2) + .6), (hand2y(wee2) - .6), (fm1), (hand2x(wee2) - .6), (hand2y(wee2) + .6), (fm1), c%, 0

CASE 2
psline (hand2x(wee2) - .6), (hand2y(wee2) - .6), (fm1), (hand2x(wee2) + .6), (hand2y(wee2) + .6), (fm1), c%, 1

CASE 3
IF position%(wee) = 13 OR position%(wee) = 37 OR position%(wee) = 88 THEN
psline (hand2x(wee2)), (hand2y(wee2) - 2), (fm1), (hand2x(wee2) - .5), (hand2y(wee2) + 1), (fm1), c%, 0
psline (hand2x(wee2)), (hand2y(wee2) - 2), (fm1), (hand2x(wee2) + .5), (hand2y(wee2) + 1), (fm1), c%, 0
ELSE
psline (hand2x(wee2) + 2 * d%(wee)), (hand2y(wee2)), (fm1), (hand2x(wee2) - .5 * d%(wee)), (hand2y(wee2) - .6), (fm1), c%, 0
psline (hand2x(wee2) + 2 * d%(wee)), (hand2y(wee2)), (fm1), (hand2x(wee2) - .5 * d%(wee)), (hand2y(wee2) + .6), (fm1), c%, 0
END IF

CASE 4, 2000
pscircle (hand2x(wee2)), (hand2y(wee2)), (fm1), .5, c%

CASE 5
psline (hand2x(wee2)), (hand2y(wee2) - .8), (fm1), (hand2x(wee2) - .8), (hand2y(wee2)), (fm1), c%, 0
psline (hand2x(wee2)), (hand2y(wee2) + .8), (fm1), (hand2x(wee2) - .8), (hand2y(wee2)), (fm1), c%, 0
psline (hand2x(wee2)), (hand2y(wee2) - .8), (fm1), (hand2x(wee2) + .8), (hand2y(wee2)), (fm1), c%, 0
psline (hand2x(wee2)), (hand2y(wee2) + .8), (fm1), (hand2x(wee2) + .8), (hand2y(wee2)), (fm1), c%, 0

CASE 666
psline (hand2x(wee2) - 1), (hand2y(wee2) - 1), (fm1), (hand2x(wee2) + 1), (hand2y(wee2) + 1), (fm1), 6, 1

END SELECT


'---------------------------------------------------------------- Razer Arm-2
IF razers%(wee) > 0 THEN
IF razers%(wee) > 50 THEN c% = flash3% ELSE c% = 4
psline (elbow2x(wee2) + (hand2x(wee) / 2) * d%(wee)), (elbow2y(wee2) + (hand2y(wee) / 2)), (fm1 - .1), (elbow2x(wee2) + (hand2x(wee) * 2) * d%(wee)), (elbow2y(wee2) + (hand2y(wee) * 2)), (fm1 - .1), c%, 0
END IF



'---------------------------------------------------------------------- Legs
c% = legsc%(wee) + 8

SELECT CASE legs%(wee)
CASE 1
psline (buttx(wee)), (butty(wee)), (fighterz(wee)), (nee1x(wee2)), (nee1y(wee2)), (fp1), legsc%(wee), 0
psline (buttx(wee)), (butty(wee) + 2), (fighterz(wee)), (nee1x(wee2)), (nee1y(wee2) - 1), (fp1), legsc%(wee), 0
psline (nee1x(wee2)), (nee1y(wee2)), (fp1), (foot1x(wee2)), (foot1y(wee2)), (fp1), legsc%(wee), 0

psline (buttx(wee)), (butty(wee)), (fighterz(wee)), (nee2x(wee2)), (nee2y(wee2)), (fm1), c%, 0
psline (buttx(wee)), (butty(wee) + 2), (fighterz(wee)), (nee2x(wee2)), (nee2y(wee2) - 1), (fm1), c%, 0
psline (nee2x(wee2)), (nee2y(wee2)), (fm1), (foot2x(wee2)), (foot2y(wee2)), (fm1), c%, 0


CASE 2
psline (buttx(wee)), (butty(wee)), (fighterz(wee)), (nee1x(wee2)), (nee1y(wee2)), (fp1), legsc%(wee), 0
psline (nee1x(wee2)), (nee1y(wee2)), (fp1), (foot1x(wee2)), (foot1y(wee2)), (fp1), legsc%(wee), 0
psline (buttx(wee)), (butty(wee) + 2), (fighterz(wee)), (nee1x(wee2)), (nee1y(wee2)), (fp1), legsc%(wee), 0
psline (nee1x(wee2)), (nee1y(wee2) - 1), (fp1), (foot1x(wee2)), (foot1y(wee2)), (fp1), legsc%(wee), 0

psline (buttx(wee)), (butty(wee)), (fighterz(wee)), (nee2x(wee2)), (nee2y(wee2)), (fm1), c%, 0
psline (nee2x(wee2)), (nee2y(wee2)), (fm1), (foot2x(wee2)), (foot2y(wee2)), (fm1), c%, 0
psline (buttx(wee)), (butty(wee) + 2), (fighterz(wee)), (nee2x(wee2)), (nee2y(wee2)), (fm1), c%, 0
psline (nee2x(wee2)), (nee2y(wee2) - 1), (fm1), (foot2x(wee2)), (foot2y(wee2)), (fm1), c%, 0


CASE 3
psline (buttx(wee)), (butty(wee) + 2), (fighterz(wee)), (nee1x(wee2)), (nee1y(wee2) + 2), (fp1), legsc%(wee), 0
psline (nee1x(wee2)), (nee1y(wee2) - 1), (fp1), (foot1x(wee2)), (foot1y(wee2)), (fp1), legsc%(wee), 0
psline (buttx(wee)), (butty(wee) - 2), (fighterz(wee)), (nee1x(wee2)), (nee1y(wee2)), (fp1), legsc%(wee), 0
psline (nee1x(wee2)), (nee1y(wee2) + 2), (fp1), (foot1x(wee2)), (foot1y(wee2)), (fp1), legsc%(wee), 0

psline (buttx(wee)), (butty(wee) + 2), (fighterz(wee)), (nee2x(wee2)), (nee2y(wee2) + 2), (fm1), c%, 0
psline (nee2x(wee2)), (nee2y(wee2) - 1), (fm1), (foot2x(wee2)), (foot2y(wee2)), (fm1), c%, 0
psline (buttx(wee)), (butty(wee) - 2), (fighterz(wee)), (nee2x(wee2)), (nee2y(wee2)), (fm1), c%, 0
psline (nee2x(wee2)), (nee2y(wee2) + 2), (fm1), (foot2x(wee2)), (foot2y(wee2)), (fm1), c%, 0

CASE 4
psline (buttx(wee) - 1 * d%(wee)), (butty(wee) + 1), (fighterz(wee)), (nee1x(wee2)), (nee1y(wee2)), (fp1), legsc%(wee), 0
psline (buttx(wee) + 1 * d%(wee)), (butty(wee)), (fighterz(wee)), (nee1x(wee2)), (nee1y(wee2)), (fp1), legsc%(wee), 0
psline (nee1x(wee2) - .5 * d%(wee)), (nee1y(wee2)), (fp1), (foot1x(wee2)), (foot1y(wee2)), (fp1), legsc%(wee), 0
psline (nee1x(wee2) + .5 * d%(wee)), (nee1y(wee2) + .5), (fp1), (foot1x(wee2)), (foot1y(wee2)), (fp1), legsc%(wee), 0
pscircle (buttx(wee) + (nee1x(wee) / 2) * d%(wee)), (butty(wee) + nee1y(wee) / 2), (fighterz(wee) + .05), 1, legsc%(wee)
pscircle (nee1x(wee2) + (foot1x(wee) / 2) * d%(wee)), (nee1y(wee + 2) + foot1y(wee) / 2), (fp1), .8, legsc%(wee)

psline (buttx(wee) - 1 * d%(wee)), (butty(wee) + 1), (fighterz(wee)), (nee2x(wee2)), (nee2y(wee2)), (fm1), c%, 0
psline (buttx(wee) + 1 * d%(wee)), (butty(wee)), (fighterz(wee)), (nee2x(wee2)), (nee2y(wee2)), (fm1), c%, 0
psline (nee2x(wee2) - .5 * d%(wee)), (nee2y(wee2)), (fm1), (foot2x(wee2)), (foot2y(wee2)), (fm1), c%, 0
psline (nee2x(wee2) + .5 * d%(wee)), (nee2y(wee2) + .5), (fm1), (foot2x(wee2)), (foot2y(wee2)), (fm1), c%, 0
pscircle (buttx(wee) + (nee2x(wee) / 2) * d%(wee)), (butty(wee) + nee2y(wee) / 2), (fighterz(wee) - .05), 1, c%
pscircle (nee2x(wee2) + (foot2x(wee) / 2) * d%(wee)), (nee2y(wee + 2) + foot2y(wee) / 2), (fm1), .8, c%

CASE 5
psline (buttx(wee)), (butty(wee)), (fighterz(wee)), (nee1x(wee2)), (nee1y(wee2)), (fp1), legsc%(wee), 0
psline (nee1x(wee2)), (nee1y(wee2)), (fp1), (foot1x(wee2)), (foot1y(wee2)), (fp1), legsc%(wee), 0
psline (buttx(wee)), (butty(wee) + 2), (fighterz(wee)), (nee1x(wee2)), (nee1y(wee2)), (fp1), legsc%(wee), 0
psline (nee1x(wee2)), (nee1y(wee2) + 2), (fp1), (foot1x(wee2)), (foot1y(wee2)), (fp1), legsc%(wee), 0
psline (nee1x(wee2) - 2 * d%(wee)), (nee1y(wee2) - (nee1y(wee) / 3)), (fp1), (nee1x(wee2) + 1 * d%(wee)), (nee1y(wee2)), (fp1), legsc%(wee), 0
psline (nee1x(wee2) - 2 * d%(wee)), (nee1y(wee2) + (nee1y(wee) / 3)), (fp1), (nee1x(wee2) + 1 * d%(wee)), (nee1y(wee2)), (fp1), legsc%(wee), 0

psline (buttx(wee)), (butty(wee)), (fighterz(wee)), (nee2x(wee2)), (nee2y(wee2)), (fm1), c%, 0
psline (nee2x(wee2)), (nee2y(wee2)), (fm1), (foot2x(wee2)), (foot2y(wee2)), (fm1), c%, 0
psline (buttx(wee)), (butty(wee) + 2), (fighterz(wee)), (nee2x(wee2)), (nee2y(wee2)), (fm1), c%, 0
psline (nee2x(wee2)), (nee2y(wee2) + 2), (fm1), (foot2x(wee2)), (foot2y(wee2)), (fm1), c%, 0
psline (nee2x(wee2) - 2 * d%(wee)), (nee2y(wee2) - (nee2y(wee) / 3)), (fm1), (nee2x(wee2) + 1 * d%(wee)), (nee2y(wee2)), (fm1), c%, 0
psline (nee2x(wee2) - 2 * d%(wee)), (nee2y(wee2) + (nee2y(wee) / 3)), (fm1), (nee2x(wee2) + 1 * d%(wee)), (nee2y(wee2)), (fm1), c%, 0


CASE 666
psline (buttx(wee) + 2 * d%(wee)), (butty(wee) - 2), (fp1), (nee1x(wee2)), (nee1y(wee2) + 2), (fighterz(wee) + .2), 4, 0
psline (nee1x(wee2)), (nee1y(wee2) - 1), (fighterz(wee) + .2), (foot1x(wee2)), (foot1y(wee2)), (fighterz(wee) + .2), 4, 0
psline (buttx(wee) - 1 * d%(wee)), (butty(wee)), (fp1), (nee1x(wee2)), (nee1y(wee2)), (fighterz(wee) + .2), 4, 0
psline (nee1x(wee2)), (nee1y(wee2) + 2), (fighterz(wee) + .2), (foot1x(wee2)), (foot1y(wee2)), (fighterz(wee) + .2), 4, 0

psline (buttx(wee) + 2 * d%(wee)), (butty(wee) - 2), (fm1), (nee2x(wee2)), (nee2y(wee2) + 2), (fighterz(wee) - .2), 6, 0
psline (nee2x(wee2)), (nee2y(wee2) - 1), (fighterz(wee) - .2), (foot2x(wee2)), (foot2y(wee2)), (fighterz(wee) - .2), 6, 0
psline (buttx(wee) - 1 * d%(wee)), (butty(wee)), (fm1), (nee2x(wee2)), (nee2y(wee2)), (fighterz(wee) - .2), 6, 0
psline (nee2x(wee2)), (nee2y(wee2) + 2), (fighterz(wee) - .2), (foot2x(wee2)), (foot2y(wee2)), (fighterz(wee) - .2), 6, 0


CASE 1998
pslightning (buttx(wee)), (butty(wee)), (fighterz(wee)), (nee1x(wee2)), (nee1y(wee2)), (fp1), 1, flash2%
pslightning (nee1x(wee2)), (nee1y(wee2)), (fp1), (foot1x(wee2)), (foot1y(wee2)), (fp1), 1, flash2%

pslightning (buttx(wee)), (butty(wee)), (fighterz(wee)), (nee2x(wee2)), (nee2y(wee2)), (fm1), 1, flash2%
pslightning (nee2x(wee2)), (nee2y(wee2)), (fm1), (foot2x(wee2)), (foot1y(wee2)), (fm1), 1, flash2%


CASE 2000
pscline (buttx(wee)), (butty(wee)), (fighterz(wee)), (nee1x(wee2)), (nee1y(wee2)), (fp1), .8, legsc%(wee)
pscline (nee1x(wee2)), (nee1y(wee2)), (fp1), (foot1x(wee2)), (foot1y(wee2)), (fp1), .5, legsc%(wee)

pscline (buttx(wee)), (butty(wee)), (fighterz(wee)), (nee2x(wee2)), (nee2y(wee2)), (fm1), .8, c%
pscline (nee2x(wee2)), (nee2y(wee2)), (fm1), (foot2x(wee2)), (foot2y(wee2)), (fm1), .5, c%

END SELECT

'---------------------------------------------------------------------- Feet
c% = feetc%(wee) + 8
tip = 2 * d%(wee)

IF position%(wee) = 49 THEN

psline (foot2x(wee2)), (foot2y(wee2)), (fm1), (foot2x(wee2)), (foot2y(wee2) + 2), (fm1), c%, 0
psline (foot1x(wee2)), (foot1y(wee2)), (fp1), (foot1x(wee2) - tip), (foot1y(wee2) - 2), (fp1), feetc%(wee), 0


ELSE

SELECT CASE feet%(wee)
CASE 1
psline (foot2x(wee2)), (foot2y(wee2)), (fm1), (foot2x(wee2) + tip), (foot2y(wee2)), (fm1), c%, 0
psline (foot1x(wee2)), (foot1y(wee2)), (fp1), (foot1x(wee2) + tip), (foot1y(wee2)), (fp1), feetc%(wee), 0


CASE 2
psline (foot2x(wee2)), (foot2y(wee2) - 1), (fm1), (foot2x(wee2) + tip), (foot2y(wee2)), (fm1), c%, 1
psline (foot1x(wee2)), (foot1y(wee2) - 1), (fp1), (foot1x(wee2) + tip), (foot1y(wee2)), (fp1), feetc%(wee), 1


CASE 3
psline (foot2x(wee2)), (foot2y(wee2)), (fm1), (foot2x(wee2) + tip), (foot2y(wee2)), (fm1), c%, 0
psline (foot2x(wee2)), (foot2y(wee2) - 1), (fm1), (foot2x(wee2) + tip), (foot2y(wee2)), (fm1), c%, 0

psline (foot1x(wee2)), (foot1y(wee2)), (fp1), (foot1x(wee2) + tip), (foot1y(wee2)), (fp1), feetc%(wee), 0
psline (foot1x(wee2)), (foot1y(wee2) - 1), (fp1), (foot1x(wee2) + tip), (foot1y(wee2)), (fp1), feetc%(wee), 0


CASE 4, 2000
pscircle (foot1x(wee2) + 1 * d%(wee)), (foot1y(wee2)), (fp1), .5, feetc%(wee)
pscircle (foot2x(wee2) + 1 * d%(wee)), (foot2y(wee2)), (fm1), .5, c%

CASE 5
pscircle (foot1x(wee2)), (foot1y(wee2) - .5), (fp1), .5, feetc%(wee)
psline (foot1x(wee2)), (foot1y(wee2) - 1), (fp1), (foot1x(wee2) + 2 * d%(wee)), (foot1y(wee2)), (fp1), feetc%(wee), 0

pscircle (foot2x(wee2)), (foot2y(wee2) - .5), (fm1), .5, c%
psline (foot2x(wee2)), (foot2y(wee2) - 1), (fm1), (foot2x(wee2) + 2 * d%(wee)), (foot2y(wee2)), (fm1), c%, 0


CASE 666
psline (foot1x(wee2) - .4), (foot1y(wee2) - 1), (fighterz(wee) + .2), (foot1x(wee2) + .4), (foot1y(wee2)), (fighterz(wee) + .2), 8, 1
psline (foot1x(wee2) + .4 * d%(wee)), (foot1y(wee2) - 1), (fighterz(wee) + .2), (foot1x(wee2) + 1 * d%(wee)), (foot1y(wee2)), (fighterz(wee) + .2), 8, 0

psline (foot2x(wee2) - .4), (foot2y(wee2) - 1), (fighterz(wee) - .2), (foot2x(wee2) + .4), (foot2y(wee2)), (fighterz(wee) - .2), 8, 1
psline (foot2x(wee2) + .4 * d%(wee)), (foot2y(wee2) - 1), (fighterz(wee) - .2), (foot2x(wee2) + 1 * d%(wee)), (foot2y(wee2)), (fighterz(wee) - .2), 8, 0

END SELECT

END IF

'============================================================================
'------------------------------------------------ Low Detail Fighter Graphics
ELSE

'head
pscircle (headx(wee2)), (heady(wee2)), (fighterz(wee)), 1.5, headc%(wee)

'body
psline (buttx(wee)), (butty(wee)), (fighterz(wee)), (neckx(wee2)), (necky(wee2)), (fighterz(wee)), bodyc%(wee), 0

'arms
psline (neckx(wee2)), (necky(wee2)), (fighterz(wee)), (elbow1x(wee2)), (elbow1y(wee2)), (fp1), armsc%(wee), 0
psline (neckx(wee2)), (necky(wee2)), (fighterz(wee)), (elbow2x(wee2)), (elbow2y(wee2)), (fm1), armsc%(wee) + 8, 0

psline (elbow1x(wee2)), (elbow1y(wee2)), (fp1), (hand1x(wee2)), (hand1y(wee2)), (fp1), armsc%(wee), 0
psline (elbow2x(wee2)), (elbow2y(wee2)), (fm1), (hand2x(wee2)), (hand2y(wee2)), (fm1), armsc%(wee) + 8, 0

'legs
psline (buttx(wee)), (butty(wee)), (fighterz(wee)), (nee1x(wee2)), (nee1y(wee2)), (fp1), legsc%(wee), 0
psline (nee1x(wee2)), (nee1y(wee2)), (fp1), (foot1x(wee2)), (foot1y(wee2)), (fp1), legsc%(wee), 0

psline (buttx(wee)), (butty(wee)), (fighterz(wee)), (nee2x(wee2)), (nee2y(wee2)), (fm1), legsc%(wee) + 8, 0
psline (nee2x(wee2)), (nee2y(wee2)), (fm1), (foot2x(wee2)), (foot2y(wee2)), (fm1), legsc%(wee) + 8, 0

'----------------------------------------------------------------------------
END IF
36
NEXT wee


END SUB

SUB fighterfreeze (n)
IF canjump%(n) = 1 OR ticker% < 1 THEN butth(n) = 0: buttv(n) = 0
headh(n) = 0
neckh(n) = 0
elbow1h(n) = 0
elbow2h(n) = 0
hand1h(n) = 0
hand2h(n) = 0
nee1h(n) = 0
nee2h(n) = 0
foot1h(n) = 0
foot2h(n) = 0

headv(n) = 0
neckv(n) = 0
elbow1v(n) = 0
elbow2v(n) = 0
hand1v(n) = 0
hand2v(n) = 0
nee1v(n) = 0
nee2v(n) = 0
foot1v(n) = 0
foot2v(n) = 0
END SUB

SUB fightergoo (wee, d)

headh(wee) = headh(wee) / d
neckh(wee) = neckh(wee) / d
elbow1h(wee) = elbow1h(wee) / d
elbow2h(wee) = elbow2h(wee) / d
hand1h(wee) = hand1h(wee) / d
hand2h(wee) = hand2h(wee) / d
nee1h(wee) = nee1h(wee) / d
nee2h(wee) = nee2h(wee) / d
foot1h(wee) = foot1h(wee) / d
foot2h(wee) = foot2h(wee) / d

headv(wee) = headv(wee) / d
neckv(wee) = neckv(wee) / d
elbow1v(wee) = elbow1v(wee) / d
elbow2v(wee) = elbow2v(wee) / d
hand1v(wee) = hand1v(wee) / d
hand2v(wee) = hand2v(wee) / d
nee1v(wee) = nee1v(wee) / d
nee2v(wee) = nee2v(wee) / d
foot1v(wee) = foot1v(wee) / d
foot2v(wee) = foot2v(wee) / d
END SUB

SUB fighterinit


IF stage% = 12 THEN
FOR wee = 1 TO 2
particle (buttx(wee) + ((RND - .5) * 15)), (butty(wee) + ((RND - .5) * 15)), fighterz(wee), 15, 20
NEXT wee
END IF

buttx(1) = -ring% / 3
buttx(2) = ring% / 3
d%(1) = 1
d%(2) = -1
FOR wee = 1 TO 2
 IF AIactive%(wee) = 1 THEN AIfighter (wee)
 vexed%(wee) = 0
 razers%(wee) = 0
 Special%(wee) = 0
 decap 3
 pticker%(wee) = 0
 butty(wee) = floor1 - 20
 fightercompress (wee)
 fighterz(wee) = midstage
 fighterfreeze (wee)
 koslide%(wee) = ko(wee)
 hpslide%(wee) = health%(wee)

 SELECT CASE arms%(wee)
 CASE 1
 ahpow%(wee) = 0
 akpow%(wee) = 5
 CASE 2
 ahpow%(wee) = 2
 akpow%(wee) = 3
 CASE 3
 ahpow%(wee) = 3
 akpow%(wee) = 2
 CASE 4
 ahpow%(wee) = 1
 akpow%(wee) = 4
 CASE 5
 ahpow%(wee) = 4
 akpow%(wee) = 1
 CASE 1998
 ahpow%(wee) = 4
 akpow%(wee) = 2
 CASE 666
 ahpow%(wee) = 5
 akpow%(wee) = 7
 CASE 2000
 ahpow%(wee) = 4
 akpow%(wee) = 5
 END SELECT

 SELECT CASE legs%(wee)
 CASE 1
 lhpow%(wee) = 0
 lkpow%(wee) = 5
 CASE 2
 lhpow%(wee) = 2
 lkpow%(wee) = 3
 CASE 3
 lhpow%(wee) = 3
 lkpow%(wee) = 2
 CASE 4
 lhpow%(wee) = 3
 lkpow%(wee) = 1
 CASE 5
 lhpow%(wee) = 2
 lkpow%(wee) = 2
 CASE 1998
 lhpow%(wee) = 7
 lkpow%(wee) = 3
 CASE 2000
 lhpow%(wee) = 7
 lkpow%(wee) = 7
 END SELECT

 SELECT CASE head%(wee)
 CASE 1: kocharge(wee) = .2: ragecharge(wee) = .4
 CASE 2: kocharge(wee) = .3: ragecharge(wee) = .3
 CASE 3: kocharge(wee) = .4: ragecharge(wee) = .2
 CASE 4: kocharge(wee) = .1: ragecharge(wee) = .5
 CASE 5: kocharge(wee) = .5: ragecharge(wee) = .1
 CASE 666: kocharge(wee) = .5: ragecharge(wee) = .7
 CASE 2000: kocharge(wee) = .8: ragecharge(wee) = 1
 END SELECT
NEXT wee

END SUB

SUB fighterlimits
FOR wee = 1 TO 2

IF ABS(elbow1x(wee)) > 10 THEN elbow1x(wee) = 0
IF ABS(hand1x(wee)) > 10 THEN hand1x(wee) = 0
IF ABS(nee1x(wee)) > 10 THEN nee1x(wee) = 0
IF ABS(foot1x(wee)) > 10 THEN foot1x(wee) = 0

IF ABS(elbow2x(wee)) > 10 THEN elbow2x(wee) = 0
IF ABS(hand2x(wee)) > 10 THEN hand2x(wee) = 0
IF ABS(nee2x(wee)) > 10 THEN nee2x(wee) = 0
IF ABS(foot2x(wee)) > 10 THEN foot2x(wee) = 0



IF ABS(elbow1y(wee)) > 10 THEN elbow1y(wee) = 0
IF ABS(hand1y(wee)) > 10 THEN hand1y(wee) = 0
IF ABS(nee1y(wee)) > 10 THEN nee1y(wee) = 0
IF ABS(foot1y(wee)) > 10 THEN foot1y(wee) = 0

IF ABS(elbow2y(wee)) > 10 THEN elbow2y(wee) = 0
IF ABS(hand2y(wee)) > 10 THEN hand2y(wee) = 0
IF ABS(nee2y(wee)) > 10 THEN nee2y(wee) = 0
IF ABS(foot2y(wee)) > 10 THEN foot2y(wee) = 0

NEXT wee
END SUB

SUB fightermove

FOR pc1 = 1 TO 2

pc2 = pc1 + 2

'--------------------------------------------------------------- Misc Physics
'Push Appart

IF position%(1) = 1 AND position%(2) = 1 AND butty(1) > floor1 - 25 AND butty(2) > floor1 - 25 THEN
 IF fighterz(1) < fighterz(2) + .1 AND fighterz(1) > fighterz(2) - .1 THEN
  IF neckx(3) > neckx(4) - 1 AND neckx(3) < neckx(4) + 1 THEN
   IF buttx(1) < buttx(2) THEN butth(1) = butth(1) - .5: butth(2) = butth(2) + .5 ELSE butth(1) = butth(1) + .5: butth(2) = butth(2) - .5
  END IF
 END IF
END IF

'------------------------------------------------------------- Apply Movement
buttx(pc1) = buttx(pc1) + butth(pc1)
headx(pc1) = headx(pc1) + headh(pc1)
neckx(pc1) = neckx(pc1) + neckh(pc1)
elbow1x(pc1) = elbow1x(pc1) + elbow1h(pc1)
elbow2x(pc1) = elbow2x(pc1) + elbow2h(pc1)
hand1x(pc1) = hand1x(pc1) + hand1h(pc1)
hand2x(pc1) = hand2x(pc1) + hand2h(pc1)
nee1x(pc1) = nee1x(pc1) + nee1h(pc1)
nee2x(pc1) = nee2x(pc1) + nee2h(pc1)
foot1x(pc1) = foot1x(pc1) + foot1h(pc1)
foot2x(pc1) = foot2x(pc1) + foot2h(pc1)

butty(pc1) = butty(pc1) + buttv(pc1)
heady(pc1) = heady(pc1) + headv(pc1)
necky(pc1) = necky(pc1) + neckv(pc1)
elbow1y(pc1) = elbow1y(pc1) + elbow1v(pc1)
elbow2y(pc1) = elbow2y(pc1) + elbow2v(pc1)
hand1y(pc1) = hand1y(pc1) + hand1v(pc1)
hand2y(pc1) = hand2y(pc1) + hand2v(pc1)
nee1y(pc1) = nee1y(pc1) + nee1v(pc1)
nee2y(pc1) = nee2y(pc1) + nee2v(pc1)
foot1y(pc1) = foot1y(pc1) + foot1v(pc1)
foot2y(pc1) = foot2y(pc1) + foot2v(pc1)

fighterz(pc1) = fighterz(pc1) + fighterd(pc1)
hx(pc1) = hx(pc1) + hh(pc1)
hy(pc1) = hy(pc1) + hv(pc1)

'------------------------------------------------------------- Flip Direction
IF pc1 = 1 AND position%(1) = 1 AND pticker%(1) > 20 AND canjump%(1) = 1 THEN
IF buttx(1) > buttx(2) THEN d%(pc1) = -1 ELSE d%(pc1) = 1
END IF

IF pc1 = 2 AND position%(2) = 1 AND pticker%(2) > 20 AND canjump%(2) = 1 THEN
IF buttx(1) < buttx(2) THEN d%(pc1) = -1 ELSE d%(pc1) = 1
END IF


'----------------------------------------------------------- Create X/Y Cords
neckx(pc2) = buttx(pc1) + neckx(pc1) * d%(pc1)
necky(pc2) = butty(pc1) + necky(pc1)

headx(pc2) = neckx(pc2) + headx(pc1) * d%(pc1)
heady(pc2) = necky(pc2) + heady(pc1)

elbow1x(pc2) = neckx(pc2) + elbow1x(pc1) * d%(pc1)
elbow1y(pc2) = necky(pc2) + elbow1y(pc1)
elbow2x(pc2) = neckx(pc2) + elbow2x(pc1) * d%(pc1)
elbow2y(pc2) = necky(pc2) + elbow2y(pc1)

hand1x(pc2) = elbow1x(pc2) + hand1x(pc1) * d%(pc1)
hand1y(pc2) = elbow1y(pc2) + hand1y(pc1)
hand2x(pc2) = elbow2x(pc2) + hand2x(pc1) * d%(pc1)
hand2y(pc2) = elbow2y(pc2) + hand2y(pc1)

nee1x(pc2) = buttx(pc1) + nee1x(pc1) * d%(pc1)
nee1y(pc2) = butty(pc1) + nee1y(pc1)
nee2x(pc2) = buttx(pc1) + nee2x(pc1) * d%(pc1)
nee2y(pc2) = butty(pc1) + nee2y(pc1)

foot1x(pc2) = nee1x(pc2) + foot1x(pc1) * d%(pc1)
foot1y(pc2) = nee1y(pc2) + foot1y(pc1)
foot2x(pc2) = nee2x(pc2) + foot2x(pc1) * d%(pc1)
foot2y(pc2) = nee2y(pc2) + foot2y(pc1)

'----------------------------------------------------------------------------
NEXT pc1


'----------------------------------------------------------------------- Hair

'P1
IF hairl%(1) > 0 THEN
IF headless%(1) = 1 THEN headx(3) = hx(1): heady(3) = hy(1)
hairx(1) = headx(3) - 2 * d%(1)
hairy(1) = heady(3) + 1

FOR n% = 2 TO 5
hairy(n%) = hairy(n%) + gravity
IF hairx(n%) < hairx(n% - 1) - hairl%(1) THEN hairx(n%) = hairx(n% - 1) - hairl%(1)
IF hairy(n%) < hairy(n% - 1) - hairl%(1) THEN hairy(n%) = hairy(n% - 1) - hairl%(1)
IF hairx(n%) > hairx(n% - 1) + hairl%(1) THEN hairx(n%) = hairx(n% - 1) + hairl%(1)
IF hairy(n%) > hairy(n% - 1) + hairl%(1) THEN hairy(n%) = hairy(n% - 1) + hairl%(1)

NEXT n%

FOR n% = 2 TO 5
IF hairx(n%) < hairx(n% - 1) THEN hairx(n%) = hairx(n%) + .5
IF hairx(n%) > hairx(n% - 1) THEN hairx(n%) = hairx(n%) - .5
NEXT n%
END IF


'P2
IF hairl%(2) > 0 THEN
IF headless%(2) = 1 THEN headx(4) = hx(2): heady(4) = hy(2)
hairx(6) = headx(4) - 2 * d%(2)
hairy(6) = heady(4) + 1

FOR n% = 7 TO 10
hairy(n%) = hairy(n%) + gravity
IF hairx(n%) < hairx(n% - 1) - hairl%(2) THEN hairx(n%) = hairx(n% - 1) - hairl%(2)
IF hairy(n%) < hairy(n% - 1) - hairl%(2) THEN hairy(n%) = hairy(n% - 1) - hairl%(2)
IF hairx(n%) > hairx(n% - 1) + hairl%(2) THEN hairx(n%) = hairx(n% - 1) + hairl%(2)
IF hairy(n%) > hairy(n% - 1) + hairl%(2) THEN hairy(n%) = hairy(n% - 1) + hairl%(2)
NEXT n%

FOR n% = 7 TO 10
IF hairx(n%) < hairx(n% - 1) THEN hairx(n%) = hairx(n%) + .5
IF hairx(n%) > hairx(n% - 1) THEN hairx(n%) = hairx(n%) - .5

NEXT n%
END IF


END SUB

SUB fightername (n%)

'-------------------------------------------------------------- Generate Name

SELECT CASE body%(n%)
CASE 1: n1$ = "Th"
CASE 2: n1$ = "S"
CASE 3: n1$ = "K"
CASE 4: n1$ = "V"
CASE 5: n1$ = "R"
CASE 6: n1$ = "L"
CASE 7: n1$ = "D"
CASE 8: n1$ = "Br"
END SELECT

SELECT CASE head%(n%)
CASE 1: n2$ = "a"
CASE 2: n2$ = "e"
CASE 3: n2$ = "i"
CASE 4: n2$ = "o"
CASE 5: n2$ = "u"
END SELECT

SELECT CASE hands%(n%)
CASE 1: n4$ = "kk"
CASE 2: n4$ = "t"
CASE 3: n4$ = "n"
CASE 4: n4$ = "t"
CASE 5: n4$ = "l"
END SELECT

SELECT CASE feet%(n%)
CASE 1: n6$ = "n"
CASE 2: n6$ = "ly"
CASE 3: n6$ = "th"
CASE 4: n6$ = "ra"
CASE 5: n6$ = "cha"
END SELECT

name$(n%) = n1$ + n2$ + n3$ + n4$ + n5$ + n6$

IF head%(n%) = 666 THEN name$(n%) = "Demize"
IF head%(n%) = 1998 THEN name$(n%) = "Magnissa"
IF head%(n%) = 2000 THEN name$(n%) = "MasterBean"

END SUB

SUB fighterpop (n)
position%(n) = 1
buttv(n) = -gravity * 10
END SUB

SUB fighterpositions

fighterdirect

FOR pc1 = 1 TO 2

'------------------------------------------- Player Current / Player Opponent
IF pc1 = 2 THEN po1 = 1 ELSE po1 = 2
pc2 = pc1 + 2
po2 = po1 + 2


'------------------------------------------------------------ position ticker
IF psaver%(pc1) = position%(pc1) THEN
IF pticker%(pc1) < 32767 THEN pticker%(pc1) = pticker%(pc1) + 1
ELSE
psaver%(pc1) = position%(pc1)
pticker%(pc1) = 1
END IF





'======================================================= Position Replacement
'-------------------------------------------------------------- Punch 2 Elbow
 IF pticker%(pc1) = 1 THEN
 IF neckx(3) > neckx(4) - 6 AND neckx(3) < neckx(4) + 6 THEN
 IF position%(pc1) = 2 OR position%(pc1) = 3 THEN position%(pc1) = 4
 END IF
'---------------------------------------------------------------- Short 2 Nee
 IF canjump%(pc1) = 1 AND neckx(3) > neckx(4) - 3 AND neckx(3) < neckx(4) + 3 THEN
 IF position%(pc1) = 5 THEN position%(pc1) = 7
 END IF
'--------------------------------------------------- Roundhouse 2 In-Air Kick
 IF position%(pc1) = 6 AND canjump%(pc1) = 0 AND ABS(butth(pc1)) > .5 THEN
 position%(pc1) = 14
 END IF
'-------------------------------------------------------------- ---- --- -- -
END IF


'------------------------------------------------------ Opponent Target Areas

IF headless%(po1) = 0 THEN
h1x = headx(po2) - 2
h1y = heady(po2) - 4
h2x = headx(po2) + 2
h2y = heady(po2) + 4
ELSE
h1x = neckx(po2)
h1y = necky(po2)
h2x = neckx(po2)
h2y = necky(po2)
END IF
'psline (h1x), (h1y), (fighterz(po1)), (h2x), (h2y), (fighterz(po1)), 12, 1

m1x = neckx(po2) - 2
m1y = h2y
m2x = neckx(po2) + 2
m2y = butty(po1)
'psline (m1x), (m1y), (fighterz(po1)), (m2x), (m2y), (fighterz(po1)), 9, 1

l1x = buttx(po1) - 5
l1y = butty(po1)
l2x = buttx(po1) + 5
IF foot1y(po2) > foot2y(po2) THEN l2y = foot1y(po2) ELSE l2y = foot2y(po2)
'psline (l1x), (l1y), (fighterz(po1)), (l2x), (l2y), (fighterz(po1)), 14, 1


'Save Health/KO for Blocking
IF position%(po1) = 99 THEN healths% = health%(po1): kos = ko(po1) ELSE healths% = 0


'---------------------------------------------------- Turn Off Special Switch
IF position%(pc1) > 29 AND position%(pc1) < 81 THEN Special%(1) = 0

'------------------------------------------------------------------ positions
SELECT CASE position%(pc1)

'------------------------------------------------------------------- Standing
CASE IS = 1
droop = (ko(pc1) / 50) + (health%(pc1) / 200)
IF neckx(pc1) > 3 THEN neckh(pc1) = neckh(pc1) - .05 ELSE neckh(pc1) = neckh(pc1) + .05
IF headx(pc1) > 1 THEN headh(pc1) = headh(pc1) - .01 ELSE headh(pc1) = headh(pc1) + .05
IF elbow1x(pc1) > .5 THEN elbow1h(pc1) = elbow1h(pc1) - .08 ELSE elbow1h(pc1) = elbow1h(pc1) + .08
IF elbow2x(pc1) > -3 THEN elbow2h(pc1) = elbow2h(pc1) - .08 ELSE elbow2h(pc1) = elbow2h(pc1) + .08
IF hand1x(pc1) > 2 THEN hand1h(pc1) = hand1h(pc1) - .08 ELSE hand1h(pc1) = hand1h(pc1) + .08
IF hand2x(pc1) > 3 THEN hand2h(pc1) = hand2h(pc1) - .08 ELSE hand2h(pc1) = hand2h(pc1) + .08

IF legs%(pc1) = 666 THEN
  IF canjump%(pc1) = 1 AND ABS(butth(pc1)) > .05 AND ABS(butth(pc1)) < 5 THEN
  nee1x(pc1) = -2 + (walkx(pc1) * ABS(butth(pc1) / 1.8))
  nee2x(pc1) = 0 - (walkx(pc1) * ABS(butth(pc1) / 1.8))
  ELSE
  IF nee1x(pc1) > -3 THEN nee1h(pc1) = nee1h(pc1) - .05 ELSE nee1h(pc1) = nee1h(pc1) + .01
  IF nee2x(pc1) > -3 THEN nee2h(pc1) = nee2h(pc1) - .05 ELSE nee2h(pc1) = nee2h(pc1) + .01
  END IF
 IF foot1x(pc1) > 5 THEN foot1h(pc1) = foot1h(pc1) - .1 ELSE foot1h(pc1) = foot1h(pc1) + .01
 IF foot2x(pc1) > 5 THEN foot2h(pc1) = foot2h(pc1) - .05 ELSE foot2h(pc1) = foot2h(pc1) + .01
ELSE
  IF canjump%(pc1) = 1 AND ABS(butth(pc1)) > .05 AND ABS(butth(pc1)) < 5 THEN
  nee1x(pc1) = -1 + (walkx(pc1) * ABS(butth(pc1) / 1.8))
  nee2x(pc1) = 3 - (walkx(pc1) * ABS(butth(pc1) / 1.8))
  ELSE
  IF nee1x(pc1) > 5 THEN nee1h(pc1) = nee1h(pc1) - .05 ELSE nee1h(pc1) = nee1h(pc1) + .05
  IF nee2x(pc1) > -1 THEN nee2h(pc1) = nee2h(pc1) - .05 ELSE nee2h(pc1) = nee2h(pc1) + .05
  END IF
 IF foot1x(pc1) > -1 THEN foot1h(pc1) = foot1h(pc1) - .1 ELSE foot1h(pc1) = foot1h(pc1) + .01
 IF foot2x(pc1) > -3 THEN foot2h(pc1) = foot2h(pc1) - .01 ELSE foot2h(pc1) = foot2h(pc1) + .05
END IF

IF necky(pc1) > -7 - droop THEN neckv(pc1) = neckv(pc1) - .05 ELSE neckv(pc1) = neckv(pc1) + .05
IF heady(pc1) > -1 - droop THEN headv(pc1) = headv(pc1) - .01 ELSE headv(pc1) = headv(pc1) + .01
IF elbow1y(pc1) > 6 THEN elbow1v(pc1) = elbow1v(pc1) - .08 ELSE elbow1v(pc1) = elbow1v(pc1) + .08
IF elbow2y(pc1) > 5 THEN elbow2v(pc1) = elbow2v(pc1) - .08 ELSE elbow2v(pc1) = elbow2v(pc1) + .08
IF hand1y(pc1) > -2 - droop THEN hand1v(pc1) = hand1v(pc1) - .08 ELSE hand1v(pc1) = hand1v(pc1) + .08
IF hand2y(pc1) > 2.5 - droop THEN hand2v(pc1) = hand2v(pc1) - .08 ELSE hand2v(pc1) = hand2v(pc1) + .08
IF nee1y(pc1) > 8 THEN nee1v(pc1) = nee1v(pc1) - .01 ELSE nee1v(pc1) = nee1v(pc1) + .1
IF nee2y(pc1) > 8 THEN nee2v(pc1) = nee2v(pc1) - .01 ELSE nee2v(pc1) = nee2v(pc1) + .1
IF foot1y(pc1) > 7 THEN foot1v(pc1) = foot1v(pc1) - .01 ELSE foot1v(pc1) = foot1v(pc1) + .05
IF foot2y(pc1) > 7 THEN foot2v(pc1) = foot2v(pc1) - .01 ELSE foot2v(pc1) = foot2v(pc1) + .1


fightergoo (pc1), 1.3

'------------------------------------------------------------------------ Jab

CASE IS = 2
IF pticker%(pc1) = 1 THEN sbfx 1
fighterfreeze (pc1)
IF neckx(pc1) < 3.5 THEN neckx(pc1) = neckx(pc1) + .5
elbow1x(pc1) = 4
elbow1y(pc1) = 0
hand1x(pc1) = 3
hand1y(pc1) = 0
elbow2y(pc1) = 2


'Momontary Pause / Detect hit
IF pticker%(pc1) = 2 THEN
fighterfreeze (pc1)

IF razers%(pc1) > 0 THEN ahpow%(pc1) = ahpow%(pc1) + 5

 'High/Head
 IF hand1x(pc2) > h1x AND hand1x(pc2) < h2x AND hand1y(pc2) > h1y AND hand1y(pc2) < h2y THEN
 health%(po1) = health%(po1) - ahpow%(pc1) * 2
 ko(po1) = ko(po1) - akpow%(pc1) * 2
 position%(po1) = 1
 IF headx(po1) > 0 THEN headx(po1) = headx(po1) - 1
  IF position%(po1) < 99 THEN
  IF buttx(pc1) < buttx(po1) THEN particle (hand1x(pc2)), (hand1y(pc2)), (fighterz(pc1)), 4, 3: butth(po1) = butth(po1) + .5 ELSE particle (hand1x(pc2)), (hand1y(pc2)), (fighterz(pc1)), 3, 3: butth(po1) = butth(po1) - .5
  END IF
 IF razers%(pc1) > 0 THEN soundticker% = 0: sbfx 17 ELSE soundticker% = 0: sbfx 10
 END IF

 'Medium/Low
 IF hand1x(pc2) > m1x AND hand1x(pc2) < m2x AND hand1y(pc2) > m1y AND hand1y(pc2) < l2y THEN
 health%(po1) = health%(po1) - ahpow%(pc1)
 ko(po1) = ko(po1) - akpow%(pc1)
 position%(po1) = 1
 neckx(po1) = neckx(po1) + 1
 necky(po1) = necky(po1) + 1
 IF position%(po1) < 99 THEN particle (hand1x(pc2)), (hand1y(pc2)), (fighterz(pc1)), 1, 5
 IF razers%(pc1) > 0 THEN soundticker% = 0: sbfx 17 ELSE soundticker% = 0: sbfx 9
 END IF

IF razers%(pc1) > 0 THEN ahpow%(pc1) = ahpow%(pc1) - 5

END IF

'Return Position
IF pticker%(pc1) > 3 THEN
 elbow1x(pc1) = 2
 elbow1h(pc1) = -.5
 elbow1y(pc1) = 1
 elbow1v(pc1) = 1
 hand1h(pc1) = -.5
 hand1v(pc1) = -.5
 position%(pc1) = 1
 END IF

'--------------------------------------------------------------------- Strong
CASE IS = 3
IF pticker%(pc1) = 1 THEN sbfx 2
fighterfreeze (pc1)
IF neckx(pc1) < 3 THEN neckx(pc1) = neckx(pc1) + 1
elbow2x(pc1) = 4
elbow2y(pc1) = -1
hand2x(pc1) = 3
hand2y(pc1) = -1.5

'Momontary Pause / Detect hit
IF pticker%(pc1) = 2 THEN
 fighterfreeze (pc1)

IF razers%(pc1) > 0 THEN ahpow%(pc1) = ahpow%(pc1) + 5

 'High/Head
 IF hand2x(pc2) > h1x AND hand2x(pc2) < h2x AND hand2y(pc2) > h1y AND hand2y(pc2) < h2y THEN
 health%(po1) = health%(po1) - ahpow%(pc1) * 2
 ko(po1) = ko(po1) - akpow%(pc1)
 position%(po1) = 1
 IF headx(po1) > 0 THEN headx(po1) = headx(po1) - 1
 IF neckx(po1) > 0 THEN neckx(po1) = neckx(po1) - 1
  IF position%(po1) < 99 THEN
  IF buttx(pc1) < buttx(po1) THEN particle (hand2x(pc2)), (hand2y(pc2)), (fighterz(pc1)), 4, 3: butth(po1) = butth(po1) + 1 ELSE particle (hand2x(pc2)), (hand2y(pc2)), (fighterz(pc1)), 3, 3: butth(po1) = butth(po1) - 1
  END IF
 IF razers%(pc1) > 0 THEN soundticker% = 0: sbfx 17 ELSE soundticker% = 0: sbfx 11
 END IF

 'Medium/Low
IF hand2x(pc2) > m1x AND hand2x(pc2) < m2x AND hand2y(pc2) > m1y AND hand2y(pc2) < l2y THEN
 health%(po1) = health%(po1) - ahpow%(pc1) * 3
 ko(po1) = ko(po1) - akpow%(pc1) * 2
 position%(po1) = 1
 neckx(po1) = neckx(po1) + 1
 necky(po1) = necky(po1) + 1
 IF position%(po1) < 99 THEN particle (hand2x(pc2)), (hand2y(pc2)), (fighterz(pc1)), 1, 5
 IF razers%(pc1) > 0 THEN soundticker% = 0: sbfx 17 ELSE soundticker% = 0: sbfx 10
END IF

IF razers%(pc1) > 0 THEN ahpow%(pc1) = ahpow%(pc1) - 5

END IF

'Return Position
IF pticker%(pc1) > 3 THEN
 elbow2x(pc1) = 2
 elbow2h(pc1) = -1.5
 elbow2v(pc1) = 1
 hand2h(pc1) = 0
 hand2v(pc1) = .5
 position%(pc1) = 1
 END IF


'---------------------------------------------------------------------- Elbow
CASE IS = 4
IF pticker%(pc1) = 1 THEN sbfx 3
fighterfreeze (pc1)
elbow1x(pc1) = 5
elbow1y(pc1) = 0
hand1x(pc1) = -3
hand1y(pc1) = 1.5

'Momontary Pause / Detect hit
IF pticker%(pc1) = 2 THEN
 fighterfreeze (pc1)

 IF elbow1x(pc2) > l1x AND elbow1x(pc2) < l2x AND elbow1y(pc2) > h1y AND elbow1y(pc2) < l2y THEN
 health%(po1) = health%(po1) - ahpow%(pc1)
 ko(po1) = ko(po1) - akpow%(pc1) * 2
 IF buttx(pc1) > buttx(po1) THEN butth(po1) = butth(po1) - .3 ELSE butth(po1) = butth(po1) + .3
 IF position%(po1) < 99 THEN particle (elbow1x(pc2)), (elbow1y(pc2)), (fighterz(pc1)), 1, 3
 soundticker% = 0: sbfx 9
 position%(po1) = 1
 END IF
END IF

'Return Position
IF pticker%(pc1) > 3 THEN
 elbow1v(pc1) = 1
 position%(pc1) = 1
 END IF


'---------------------------------------------------------------------- Short
CASE IS = 5

fighterfreeze (pc1)

SELECT CASE combo%(pc1)
'----------------------------+
CASE 0
sbfx 2
nee1x(pc1) = 6
nee1y(pc1) = -1
foot1x(pc1) = 6
foot1y(pc1) = -1


'----------------------------+
CASE 1
sbfx 1
neckx(pc1) = neckx(pc1) + 1
nee1x(pc1) = 5
nee1y(pc1) = 5
foot1x(pc1) = 5
foot1y(pc1) = 5


'----------------------------+
CASE 2
sbfx 2
combo%(pc1) = -1

buttx(pc1) = buttx(pc1) + (2 * d%(pc1))
buttv(pc1) = buttv(pc1) - 3

neckx(pc1) = -1
nee1x(pc1) = 6
nee1y(pc1) = -6
foot1x(pc1) = 6
foot1y(pc1) = -6

nee2x(pc1) = 0
foot2x(pc1) = 0

nee1v(pc1) = 1
foot1v(pc1) = 2

elbow1x(pc1) = elbow1x(pc1) + 2
elbow1y(pc1) = elbow1y(pc1) - 2
hand2x(pc1) = hand2x(pc1) - 2
hand2y(pc1) = hand2y(pc1) + 2

END SELECT


tx = buttx(pc1) + nee1x(pc1) * d%(pc1)
ty = butty(pc1) + nee1y(pc1)
tx = tx + foot1x(pc1) * d%(pc1)
ty = ty + foot1y(pc1)

'Detect Hit
IF tx > l1x AND tx < l2x AND ty > h1y AND ty < l2y THEN
 soundticker% = 0: sbfx 9
  IF position%(po1) < 99 THEN
  health%(po1) = health%(po1) - lhpow%(pc1)
  ko(po1) = ko(po1) - lkpow%(pc1)
  position%(po1) = 1
  IF combo%(pc1) = -1 THEN particle (tx), (ty), (fighterz(pc1)), 2, 5: buttv(po1) = -8: butth(po1) = d%(pc1): fall (po1) ELSE IF position%(po1) < 99 THEN particle (tx), (ty), (fighterz(pc1)), 1, 5
  combo%(pc1) = combo%(pc1) + 1: combol%(pc1) = 30
  END IF
END IF

'Return Position
position%(pc1) = 1
IF foot1x(pc1) > 0 THEN foot1h(pc1) = -2


'----------------------------------------------------------------- Roundhouse
CASE IS = 6

IF pticker%(pc1) = 1 THEN
fighterfreeze (pc1)
neckx(pc1) = 0
buttx(pc1) = buttx(pc1) + (d%(pc1) * 2)

nee1x(pc1) = 0
foot1x(pc1) = 0

 IF foot1y(pc1) < 1 OR nee1y(pc1) > 3 THEN
 nee1y(pc1) = 8
 foot1y(pc1) = 7
 END IF

elbow1h(pc1) = -.5
elbow2h(pc1) = .5
elbow2v(pc1) = -.5
END IF

IF pticker%(pc1) = 3 THEN
 IF buttx(pc1) > buttx(po1) THEN
 d%(pc1) = -1
 ELSE
 d%(pc1) = 1
 END IF
END IF

IF pticker%(pc1) = 5 THEN
nee2h(pc1) = 2
nee2v(pc1) = -2

foot2h(pc1) = -1
foot2v(pc1) = -1
END IF

IF pticker%(pc1) = 8 THEN
sbfx 4
fighterfreeze (pc1)

elbow1x(pc1) = elbow1x(pc1) + 2
elbow1y(pc1) = elbow1y(pc1) - 2

hand2y(pc1) = hand2y(pc1) + 2
elbow2y(pc1) = elbow2y(pc1) + 2

nee2x(pc1) = 5
nee2y(pc1) = -1


foot2x(pc1) = 5
foot2y(pc1) = -1
END IF


'Detect Hit
IF pticker%(pc1) = 9 AND foot2x(pc2) > l1x AND foot2x(pc2) < l2x AND foot2y(pc2) > h1y AND foot2y(pc2) < l2y THEN
combol%(pc1) = 30
 IF position%(po1) < 99 THEN
 health%(po1) = health%(po1) - lhpow%(pc1) * 2
 soundticker% = 0: sbfx 11
 ko(po1) = ko(po1) - lkpow%(pc1) * 2
 particle (foot2x(pc2)), (foot2y(pc2)), (fighterz(pc1)), 1, 5
 position%(po1) = 1
  IF nee1y(pc1) < 5 THEN
  fall po1
  buttv(po1) = buttv(po1) - 5
  ELSE
  fighterz(po1) = midstage + .5
  END IF
 ELSE
 soundticker% = 0: sbfx 9
 END IF
END IF


IF pticker%(pc1) > 9 THEN
fighterfreeze (pc1)

nee2h(pc1) = -1
nee2v(pc1) = 1
foot2h(pc1) = -2
foot2v(pc1) = 1

position%(pc1) = 1
END IF


'------------------------------------------------------------------------ Nee
CASE IS = 7
IF pticker%(pc1) = 1 THEN sbfx 3
fighterfreeze (pc1)
buttx(pc1) = buttx(pc1) + d%(pc1)
buttv(pc1) = buttv(pc1) - 2
nee1x(pc1) = 0
nee1y(pc1) = 6
foot1x(pc1) = -1
foot1y(pc1) = 5
nee2x(pc1) = 5
nee2y(pc1) = -4
elbow1x(pc1) = -2
elbow1y(pc1) = 3
elbow2x(pc1) = -2
elbow2y(pc1) = 3

'Momontary Pause / Detect hit
IF pticker%(pc1) = 2 THEN
 fighterfreeze (pc1)

 IF nee2x(pc2) > l1x AND nee2x(pc2) < l2x AND nee2y(pc2) > h1y AND nee2y(pc2) < l2y THEN
 soundticker% = 0: sbfx 10
 health%(po1) = health%(po1) - lhpow%(pc1) * 2
 ko(po1) = ko(po1) - lkpow%(pc1)
 combol%(pc1) = 30
 neckx(po1) = 2
 heady(po1) = 2
 position%(po1) = 1
 IF buttx(pc1) > buttx(po1) THEN butth(po1) = butth(po1) - .3: particle (nee2x(pc2)), (nee2y(pc2)), (fighterz(pc1)), 3, 3 ELSE butth(po1) = butth(po1) + .3: particle (nee2x(pc2)), (nee2y(pc2)), (fighterz(pc1)), 4, 3
 END IF
END IF

'Return Position
IF pticker%(pc1) > 3 THEN
 nee2v(pc1) = 1
 position%(pc1) = 1
 END IF



'--------------------------------------------------------------- Fall Forward
CASE IS = 8
IF pticker%(pc1) = 1 THEN buttv(pc1) = buttv(pc1) - 3

IF neckx(pc1) > 7 THEN neckh(pc1) = neckh(pc1) - .05 ELSE neckh(pc1) = neckh(pc1) + .1
IF headx(pc1) > 3 THEN headh(pc1) = headh(pc1) - .01 ELSE headh(pc1) = headh(pc1) + .1
elbow1h(pc1) = 0
elbow2h(pc1) = 0
hand1h(pc1) = 0
hand2h(pc1) = 0
IF nee1x(pc1) > -5 THEN nee1h(pc1) = nee1h(pc1) - .2 ELSE nee1h(pc1) = nee1h(pc1) + .1
IF nee2x(pc1) > -2 THEN nee2h(pc1) = nee2h(pc1) - .2 ELSE nee2h(pc1) = nee2h(pc1) + .1
IF foot1x(pc1) > -4 THEN foot1h(pc1) = foot1h(pc1) - .1 ELSE foot1h(pc1) = foot1h(pc1) + .05
IF foot2x(pc1) > -3 THEN foot2h(pc1) = foot2h(pc1) - .1 ELSE foot2h(pc1) = foot2h(pc1) + .05

IF necky(pc1) > -3 THEN neckv(pc1) = neckv(pc1) - .05 ELSE neckv(pc1) = neckv(pc1) + .05
IF heady(pc1) > 2 THEN headv(pc1) = headv(pc1) - .01 ELSE headv(pc1) = headv(pc1) + .05
IF elbow1y(pc2) > butty(pc1) THEN elbow1v(pc1) = elbow1v(pc1) - .1 ELSE elbow1v(pc1) = elbow1v(pc1) + .05
IF elbow2y(pc2) > butty(pc1) THEN elbow2v(pc1) = elbow2v(pc1) - .1 ELSE elbow2v(pc1) = elbow2v(pc1) + .05
IF hand1y(pc2) > butty(pc1) THEN hand1v(pc1) = hand1v(pc1) - .05 ELSE hand1v(pc1) = hand1v(pc1) + .05
IF hand2y(pc2) > butty(pc1) THEN hand2v(pc1) = hand2v(pc1) - .05 ELSE hand2v(pc1) = hand2v(pc1) + .05
nee1y(pc1) = 0
foot1y(pc1) = 0
nee2y(pc1) = 0
foot2y(pc1) = 0
fightergoo (pc1), 1.3

IF ABS(butth(pc1)) < .05 AND ABS(buttv(pc1)) < .1 AND pticker%(pc1) > sdelay%(pc1) AND necky(pc2) > butty(pc1) - 3 THEN
fighterfreeze (pc1)
 IF ko(pc1) > 0 AND health%(pc1) > 0 THEN
 position%(pc1) = 9
 neckx(pc1) = 3
 necky(pc1) = -5
 elbow1x(pc1) = 3
 elbow1y(pc1) = 4
 hand1x(pc1) = 2
 hand1y(pc1) = 3
 elbow2x(pc1) = 3
 elbow2y(pc1) = 4
 hand2x(pc1) = 2
 hand2y(pc1) = 3
 END IF
END IF


'------------------------------------------------------------------- Get Up 1
CASE IS = 9

IF heady(pc1) > -1 - droop THEN headv(pc1) = headv(pc1) - .1 ELSE headv(pc1) = headv(pc1) + .05
nee1h(pc1) = 1.5
neckh(pc1) = -.2
neckv(pc1) = -.4

fightergoo (pc1), 1.05

IF pticker%(pc1) > 5 THEN

position%(pc1) = 1

headx(pc1) = 1
neckh(pc1) = 0
neckv(pc1) = 0
buttv(pc1) = -5
nee2x(pc1) = 2
foot1x(pc1) = 1
foot2x(pc1) = -2
nee1h(pc1) = 0
nee1y(pc1) = 0
nee2y(pc1) = 4
foot1y(pc1) = 4
foot2y(pc1) = 4
END IF



'------------------------------------------------------------------ Fall Back
CASE IS = 10
IF neckx(pc1) > -7 THEN neckh(pc1) = neckh(pc1) - .1 ELSE neckh(pc1) = neckh(pc1) + .05
IF headx(pc1) > -3 THEN headh(pc1) = headh(pc1) - .1 ELSE headh(pc1) = headh(pc1) + .01
elbow1h(pc1) = 0
elbow2h(pc1) = 0
hand1h(pc1) = 0
hand2h(pc1) = 0
IF nee1x(pc1) > 5 THEN nee1h(pc1) = nee1h(pc1) - .01 ELSE nee1h(pc1) = nee1h(pc1) + .1
IF nee2x(pc1) > 2 THEN nee2h(pc1) = nee2h(pc1) - .01 ELSE nee2h(pc1) = nee2h(pc1) + .1
IF foot1x(pc1) > 4 THEN foot1h(pc1) = foot1h(pc1) - .05 ELSE foot1h(pc1) = foot1h(pc1) + .1
IF foot2x(pc1) > 3 THEN foot2h(pc1) = foot2h(pc1) - .05 ELSE foot2h(pc1) = foot2h(pc1) + .1

IF necky(pc1) > 0 THEN neckv(pc1) = neckv(pc1) - .05 ELSE neckv(pc1) = neckv(pc1) + .1
IF heady(pc1) > -2 THEN headv(pc1) = headv(pc1) - .01 ELSE headv(pc1) = headv(pc1) + .01
IF elbow1y(pc1 + 2) > butty(pc1) THEN elbow1v(pc1) = elbow1v(pc1) - .1 ELSE elbow1v(pc1) = elbow1v(pc1) + .05
IF elbow2y(pc1 + 2) > butty(pc1) THEN elbow2v(pc1) = elbow2v(pc1) - .1 ELSE elbow2v(pc1) = elbow2v(pc1) + .05
IF hand1y(pc1 + 2) > butty(pc1) THEN hand1v(pc1) = hand1v(pc1) - .05 ELSE hand1v(pc1) = hand1v(pc1) + .05
IF hand2y(pc1 + 2) > butty(pc1) THEN hand2v(pc1) = hand2v(pc1) - .05 ELSE hand2v(pc1) = hand2v(pc1) + .05
IF nee1y(pc1) > -1 THEN nee1v(pc1) = nee1v(pc1) - .2 ELSE nee1v(pc1) = nee1v(pc1) + .05
IF foot1y(pc1) > 1 THEN foot1v(pc1) = foot1v(pc1) - .1 ELSE foot1v(pc1) = foot1v(pc1) + .1
IF nee2y(pc1) > -3 THEN nee2v(pc1) = nee2v(pc1) - .2 ELSE nee2v(pc1) = nee2v(pc1) + .05
IF foot2y(pc1) > 3 THEN foot2v(pc1) = foot2v(pc1) - .1 ELSE foot2v(pc1) = foot2v(pc1) + .1
fightergoo (pc1), 1.3

IF ABS(butth(pc1)) < .05 AND ABS(buttv(pc1)) < .1 AND pticker%(pc1) > sdelay%(pc1) AND necky(pc2) >= butty(pc1) THEN
fighterfreeze (pc1)
IF ko(pc1) > 0 AND health%(pc1) > 0 THEN position%(pc1) = 11
END IF

'------------------------------------------------------------------- Get Up 2
CASE IS = 11

neckv(pc1) = neckv(pc1) + .005

IF nee1x(pc1) > -5 THEN nee1h(pc1) = nee1h(pc1) - .1
IF nee2x(pc1) > -5 THEN nee2h(pc1) = nee2h(pc1) - .1
IF foot1x(pc1) > 4 THEN foot1h(pc1) = foot1h(pc1) - .1
IF foot2x(pc1) > 4 THEN foot2h(pc1) = foot2h(pc1) - .1

IF nee1y(pc1) > -3 THEN nee1v(pc1) = nee1v(pc1) - .01
IF nee2y(pc1) > -3 THEN nee2v(pc1) = nee2v(pc1) - .01
IF foot1y(pc1) > -2 THEN foot1v(pc1) = foot1v(pc1) - .1
IF foot2y(pc1) > -2 THEN foot2v(pc1) = foot2v(pc1) - .1

fightergoo (pc1), 1.3


IF pticker%(pc1) > 25 THEN

position%(pc1) = 1
headx(pc1) = 1

neckh(pc1) = 2
neckv(pc1) = -2

buttv(pc1) = -5

nee1x(pc1) = 5
nee2x(pc1) = 2
foot1x(pc1) = 1
foot2x(pc1) = -2

nee1y(pc1) = 0
nee2y(pc1) = 4
foot1y(pc1) = 4
foot2y(pc1) = 4
END IF


'--------------------------------------------------------------------- Crouch
CASE IS = 12
IF pticker%(pc1) = 1 THEN fighterfreeze (pc1)
nee1y(pc1) = 0
nee2y(pc1) = 0

IF pticker%(pc1) > 15 THEN
position%(pc1) = 1
END IF


'------------------------------------------------------------------ Upper Cut
CASE IS = 13
IF pticker%(pc1) = 1 THEN sbfx 4
fighterfreeze (pc1)

elbow2x(pc1) = 3
elbow2y(pc1) = -5
hand2x(pc1) = 0
hand2y(pc1) = -4

elbow1x(pc1) = -3
elbow1y(pc1) = 5
hand1x(pc1) = 0
hand1y(pc1) = 4

headx(pc1) = 0
necky(pc1) = -10
neckx(pc1) = 1

IF legs%(pc1) <> 666 THEN
nee1x(pc1) = 5
nee2x(pc1) = -1
foot1x(pc1) = -1
foot2x(pc1) = -3
END IF

nee1y(pc1) = 8
nee2y(pc1) = 8
foot1y(pc1) = 7
foot2y(pc1) = 7

'Detect Hit
IF pticker%(pc1) = 2 THEN


 IF hand2x(pc2) > m1x - 5 AND hand2x(pc2) < m2x + 5 AND hand2y(pc2) > h1y - 10 AND hand2y(pc2) < l2y THEN
 soundticker% = 0: sbfx 11
 IF razers%(pc1) > 0 THEN n% = 10: bgcolor% = 12: soundticker% = 0: sbfx 17
 health%(po1) = health%(po1) - ((ahpow%(pc1) + n%) * 3)
 IF health%(po1) <= 0 THEN decap (po1)

  IF position%(po1) <> 99 THEN
  butth(po1) = d%(pc1) / 2
  ko(po1) = ko(po1) - akpow%(pc1) * 3
  necky(po1) = necky(po1) + 1
  buttv(po1) = -(ahpow%(pc1) * 3) - 5
  position%(po1) = 10
  FOR wee = 1 TO 50 STEP 5: particle (hand2x(pc2) + ((RND - .5) * 5)), (butty(pc1) - wee), (fighterz(pc1)), 2, 1: NEXT wee
  ELSE
  particle (hand2x(pc2)), (hand2y(pc2)), (fighterz(pc1)), 6, 3
  END IF
 END IF

END IF


IF pticker%(pc1) > 9 THEN
position%(pc1) = 1
elbow2v(pc1) = 2
END IF


'---------------------------------------------------------------- In-Air Kick
CASE IS = 14

IF pticker%(pc1) = 1 THEN
sbfx 3
fighterfreeze (pc1)
neckx(pc1) = -5

nee1x(pc1) = -5
foot1x(pc1) = 5
nee1y(pc1) = 1
foot1y(pc1) = 1

elbow1x(pc1) = -4
elbow1y(pc1) = 2
hand1x(pc1) = 3
hand1y(pc1) = 1

elbow2x(pc1) = 4
elbow2y(pc1) = 2

nee2h(pc1) = 2
nee2v(pc1) = -2
foot2h(pc1) = -1
foot2v(pc1) = -2
END IF

IF pticker%(pc1) = 3 THEN
fighterfreeze (pc1)

hand2y(pc1) = hand2y(pc1) + 2
elbow2y(pc1) = elbow2y(pc1) + 2
nee2x(pc1) = 5
nee2y(pc1) = 0
foot2x(pc1) = 5
foot2y(pc1) = 0
END IF


IF pticker%(pc1) > 3 AND nee2x(pc2) > l1x - 5 AND nee2x(pc2) < l2x + 5 AND foot2y(pc2) > h1y AND foot2y(pc2) < l2y THEN
soundticker% = 0: sbfx 10
health%(po1) = health%(po1) - lhpow%(pc1) * 3
ko(po1) = ko(po1) - lkpow%(pc1) * 2
particle (nee2x(pc2)), (foot2y(pc2)), (fighterz(pc1)), 1, 5
combol%(pc1) = 30
END IF


IF pticker%(pc1) = 5 THEN
fighterfreeze (pc1)

neckh(pc1) = 1

nee1h(pc1) = 1
nee1v(pc1) = 1
foot1h(pc1) = -2
foot1v(pc1) = 1

nee2v(pc1) = 1
foot2h(pc1) = -2
foot2v(pc1) = 1
position%(pc1) = 1
END IF

'--------------------------------------------------------------- Delayed Fall
CASE IS = 15
fighterfreeze (pc1)
IF pticker%(pc1) > sdelay%(pc1) * 2 THEN position%(pc1) = 8: buttv(pc1) = buttv(pc1) + 3






'SPECIALS ========================================================== SPECIALS`


'-------------------------------------------------------------- One Fire Ball
CASE IS = 30
fighterfreeze (pc1)
IF neckx(pc1) > 2 THEN neckv(pc1) = -.2 ELSE neckv(pc1) = .2
IF necky(pc1) > -7 THEN neckv(pc1) = -.2 ELSE neckv(pc1) = .2
IF hand1x(pc1) > -1 THEN hand1h(pc1) = -.2 ELSE hand1h(pc1) = .2
IF hand2x(pc1) > 1 THEN hand2h(pc1) = -.2 ELSE hand2h(pc1) = .2
IF hand1y(pc1) > 2 THEN hand1v(pc1) = -.2 ELSE hand1v(pc1) = .2
IF hand2y(pc1) > 3 THEN hand2v(pc1) = -.2 ELSE hand2v(pc1) = .2
IF elbow2x(pc1) > -5 THEN elbow2h(pc1) = -.2 ELSE elbow2h(pc1) = .2

IF pticker%(pc1) > 3 THEN
soundticker% = 0: sbfx 4
IF ko(pc1) > 5 THEN
ko(pc1) = ko(pc1) - 3
IF pc1 = 2 THEN n% = 3
projectile%(1 + n%) = 25
projectilex(1 + n%) = hand1x(pc2)
projectiley(1 + n%) = necky(pc2)
projectileh(1 + n%) = d%(pc1) * 10
projectilev(1 + n%) = 0
projectilet%(1 + n%) = 2

position%(pc1) = 1
neckx(pc1) = 5
necky(pc1) = -6

elbow1x(pc1) = 5
hand1x(pc1) = 4
elbow1y(pc1) = 0
hand1y(pc1) = 0

butth(pc1) = butth(pc1) - (d%(pc1) / 2)
ELSE
position%(pc1) = 1
particle (hand1x(pc2)), (hand1y(pc2)), fighterz(pc1), 15, 20
END IF
END IF


x = (hand1x(pc2) + hand2x(pc2)) / 2
y = (hand1y(pc2) + hand2y(pc2)) / 2

pscircle (x), (y), (fighterz(pc1)), 1, flash3%
psline (x), (y), (fighterz(pc1)), (x + ((RND - .5) * 75)), (y + ((RND - .5) * 75)), (fighterz(pc1)), 12, 0


'------------------------------------------------------------------ Power Jab
CASE IS = 31

'Draw Back
IF pticker%(pc1) < 6 THEN
elbow1h(pc1) = -1
elbow1v(pc1) = -.5
hand1x(pc1) = 1
hand1y(pc1) = -1
END IF

'Jab
IF pticker%(pc1) = 6 THEN
 IF ko(pc1) > 10 THEN
 ko(pc1) = ko(pc1) - 5
 fighterfreeze (pc1)
 elbow1x(pc1) = 3
 elbow1y(pc1) = 4
 hand1x(pc1) = 3
 hand1y(pc1) = -2
 neckx(pc1) = 4
 necky(pc1) = -7
 neckv(pc1) = -.2
 ELSE
 fighterfreeze (pc1)
 position%(pc1) = 1
 END IF
END IF

'Detect hit
IF pticker%(pc1) = 7 THEN
 fighterfreeze (pc1)

 IF hand1x(pc2) > m1x - 4 AND hand1x(pc2) < m2x + 4 AND hand1y(pc2) > h1y AND hand1y(pc2) < l2y THEN
  IF razers%(pc1) > 0 THEN
  particle (hand1x(pc2)), (hand1y(pc2)), (fighterz(pc1)), 2, 10
  particle (hand1x(pc2)), (hand1y(pc2)), (fighterz(pc1)), 3, 10
  n% = 10
  bgcolor% = 15
  soundticker% = 0: sbfx 17
  ELSE
  bgcolor% = 4
  soundticker% = 0: sbfx 11
  END IF

 IF position%(po1) <> 99 THEN
 health%(po1) = health%(po1) - ((ahpow%(pc1) + n%) * 2)
 ko(po1) = ko(po1) - akpow%(pc1) * 3
 particle (hand1x(pc2)), (hand1y(pc2)), (fighterz(pc1)), 9, 10
 position%(po1) = 1
 ELSE
 ko(po1) = ko(po1) - akpow%(pc1)
 END IF
 particle (hand1x(pc2)), (hand1y(pc2)), (fighterz(pc1)), 1, 10

 heady(po1) = heady(po1) + 1
 butty(po1) = butty(po1) - 10
 END IF
END IF

'Return Position
IF pticker%(pc1) = 8 THEN
position%(pc1) = 1
elbow1h(pc1) = -1
hand1v(pc1) = 1
END IF


'Effects
IF pticker%(pc1) > 6 THEN
psline (neckx(pc2) - (8 * d%(pc1))), (necky(pc2) + 5), (fighterz(pc1)), (neckx(pc2) + (6 * d%(pc1))), (necky(pc2) + 3), (fighterz(pc1)), (15), 3
END IF




'------------------------------------------------------------------- Neck Jab
CASE IS = 32

'Draw Back
IF pticker%(pc1) < 6 THEN
elbow1h(pc1) = -1
elbow1v(pc1) = -.5
hand1x(pc1) = 1
hand1y(pc1) = -1
END IF

'Jab
IF pticker%(pc1) = 6 THEN
 IF ko(pc1) > 10 AND neckx(pc2) > m1x - 10 AND neckx(pc2) < m2x + 10 AND necky(pc2) > h1y - 7 THEN
 IF buttx(pc1) > buttx(po1) THEN d%(pc1) = -1 ELSE d%(pc1) = 1
 ko(pc1) = ko(pc1) - 5
 fighterfreeze (pc1)
 hand1x(pc1) = (neckx(po2) - neckx(pc2)) / (2 * d%(pc1))
 elbow1x(pc1) = (neckx(po2) - neckx(pc2)) / (2 * d%(pc1))
 hand1y(pc1) = -1
 elbow1y(pc1) = -1
 neckx(pc1) = 4
 ELSE
 fighterfreeze (pc1)
 position%(pc1) = 1
 END IF
END IF

'Detect hit
IF pticker%(pc1) = 7 AND position%(po1) <> 99 THEN
 fighterfreeze (pc1)

 IF hand1x(pc2) > m1x - 2 AND hand1x(pc2) < m2x + 2 AND hand1y(pc2) > h1y - 1 AND hand1y(pc2) < h2y + 1 THEN
  IF razers%(pc1) > 0 THEN
  particle (hand1x(pc2)), (hand1y(pc2)), (fighterz(pc1)), 2, 10
  particle (hand1x(pc2)), (hand1y(pc2)), (fighterz(pc1)), 3, 10
  n% = 10
  bgcolor% = 15
  health%(po1) = health%(po1) - 50
  IF health%(po1) < 50 THEN decap (po1)
  IF razers%(pc1) > 15 THEN razers%(pc1) = 15
  soundticker% = 0: sbfx 17
  ELSE
  bgcolor% = 4
  soundticker% = 0: sbfx 1
  END IF

 ko(po1) = ko(po1) - 10

 position%(po1) = 15
 fighterfreeze (po1)
 particle (hand1x(pc2)), (hand1y(pc2)), (fighterz(pc1)), 9, 10

 ELSE
 position%(pc1) = 1
 END IF

END IF

'Return Position
IF pticker%(pc1) >= sdelay%(po1) + 5 THEN
position%(pc1) = 1
elbow1h(pc1) = -3
elbow1v(pc1) = 2
END IF





'------------------------------------------------------------- Ball Lightning
CASE IS = 33
fighterfreeze (pc1)


IF neckx(pc1) > 2 THEN neckv(pc1) = -.2 ELSE neckv(pc1) = .2
IF necky(pc1) > -7 THEN neckv(pc1) = -.2 ELSE neckv(pc1) = .2
IF hand1x(pc1) > -1 THEN hand1h(pc1) = -.2 ELSE hand1h(pc1) = .2
IF hand2x(pc1) > 1 THEN hand2h(pc1) = -.2 ELSE hand2h(pc1) = .2
IF hand1y(pc1) > 2 THEN hand1v(pc1) = -.2 ELSE hand1v(pc1) = .2
IF hand2y(pc1) > 3 THEN hand2v(pc1) = -.2 ELSE hand2v(pc1) = .2
IF elbow2x(pc1) > -6 THEN elbow2h(pc1) = -.2 ELSE elbow2h(pc1) = .2

IF pticker%(pc1) > sdelay%(pc1) AND projectile%(1 * pc1) = 0 THEN
IF pc1 = 2 THEN n% = 3
IF ko(pc1) > 5 THEN
soundticker% = 0: sbfx 6
ko(pc1) = ko(pc1) - 5
projectile%(1 + n%) = 50
projectilex(1 + n%) = hand1x(pc2)
projectiley(1 + n%) = necky(pc2)
projectileh(1 + n%) = d%(pc1) * 10
projectilev(1 + n%) = 0
projectilet%(1 + n%) = 1

position%(pc1) = 1
neckx(pc1) = 5
necky(pc1) = -6

elbow1x(pc1) = 5
hand1x(pc1) = 4
elbow1y(pc1) = 0
hand1y(pc1) = 0

elbow2x(pc1) = 5
hand2x(pc1) = 4
elbow2y(pc1) = 0
hand2y(pc1) = 0

butth(pc1) = butth(pc1) - d%(pc1)
bgcolor% = 1
ELSE
position%(pc1) = 1
particle (hand1x(pc2)), (hand1y(pc2)), fighterz(pc1), 15, 20
END IF
END IF


x = (hand1x(pc2) + hand2x(pc2)) / 2
y = (hand1y(pc2) + hand2y(pc2)) / 2

'Effects
sbfx 13
psline (x), (y), (fighterz(pc1)), (x - (RND * 75)), (y + ((RND - .5) * 150)), (fighterz(pc1)), 15, 0
psline (x), (y), (fighterz(pc1)), (x + (RND * 75)), (y + ((RND - .5) * 150)), (fighterz(pc1)), 15, 0
pslightning (x), (y), (fighterz(pc1)), (x - (RND * 100)), (y + ((RND - .5) * 200)), (fighterz(pc1)), 50, (flash2%)
pslightning (x), (y), (fighterz(pc1)), (x + (RND * 100)), (y + ((RND - .5) * 200)), (fighterz(pc1)), 30, (flash2%)
pscircle (x), (y), (fighterz(pc1)), RND * 2, flash2%
pscircle (x), (y), (fighterz(pc1)), 1, 15


'------------------------------------------------------------ Triple Sheroken
CASE IS = 34

IF pc1 = 2 THEN n% = 3
FOR wee = 1 TO 3
IF pc1 = 2 THEN n% = 3
projectile%(wee + n%) = 15
projectilex(wee + n%) = hand1x(pc2)
projectiley(wee + n%) = necky(pc2)
projectileh(wee + n%) = (d%(pc1) * (8 * (RND + 1)))
projectilev(wee + n%) = (RND - .5) * 20
projectilet%(wee + n%) = 4
NEXT wee

position%(pc1) = 1
soundticker% = 0: sbfx 13
elbow2x(pc1) = 3
elbow2y(pc1) = 2



'------------------------------------------------------------- Two Fire Balls
CASE IS = 35
fighterfreeze (pc1)
IF neckx(pc1) > 2 THEN neckv(pc1) = -.2 ELSE neckv(pc1) = .2
IF necky(pc1) > -7 THEN neckv(pc1) = -.2 ELSE neckv(pc1) = .2
IF hand1x(pc1) > -1 THEN hand1h(pc1) = -.2 ELSE hand1h(pc1) = .2
IF hand2x(pc1) > 1 THEN hand2h(pc1) = -.2 ELSE hand2h(pc1) = .2
IF hand1y(pc1) > 2 THEN hand1v(pc1) = -.2 ELSE hand1v(pc1) = .2
IF hand2y(pc1) > 3 THEN hand2v(pc1) = -.2 ELSE hand2v(pc1) = .2
IF elbow2x(pc1) > -5 THEN elbow2h(pc1) = -.2 ELSE elbow2h(pc1) = .2

IF pticker%(pc1) > 3 THEN
soundticker% = 0: sbfx 4
IF pc1 = 2 THEN n% = 3
FOR wee = 2 TO 3
projectile%(wee + n%) = 25
projectilex(wee + n%) = hand1x(pc2)
projectiley(wee + n%) = necky(pc2)
projectilev(wee + n%) = (RND - .5) * 10
projectileh(wee + n%) = (d%(pc1) * 10)
projectilet%(wee + n%) = 3
NEXT wee

position%(pc1) = 1
neckx(pc1) = 5
necky(pc1) = -6

elbow1x(pc1) = 5
hand1x(pc1) = 4
elbow1y(pc1) = 0
hand1y(pc1) = 0

elbow2x(pc1) = 5
hand2x(pc1) = 4
elbow2y(pc1) = 0
hand2y(pc1) = 0

butth(pc1) = butth(pc1) - (d%(pc1) / 2)
END IF


x = (hand1x(pc2) + hand2x(pc2)) / 2
y = (hand1y(pc2) + hand2y(pc2)) / 2

pscircle (x), (y), (fighterz(pc1)), 1, flash3%
psline (x), (y), (fighterz(pc1)), (x + ((RND - .5) * 75)), (y + ((RND - .5) * 75)), (fighterz(pc1)), 12, 0


'--------------------------------------------------------------- Hammer Punch
CASE IS = 36

'Draw Up
IF pticker%(pc1) < 8 THEN
elbow2h(pc1) = 0
elbow2v(pc1) = -1.5
hand2x(pc1) = 3
hand2y(pc1) = -2
neckh(pc1) = -.3
END IF

'Hammer
IF pticker%(pc1) = 8 THEN
 IF ko(pc1) > 10 THEN
 IF body%(pc1) = 666 THEN rage(pc1) = 0
 ko(pc1) = ko(pc1) - 5
 fighterfreeze (pc1)
 elbow2x(pc1) = 3
 elbow2y(pc1) = 5
 hand2x(pc1) = 4
 hand2y(pc1) = 0
 neckx(pc1) = 4
 necky(pc1) = -7
 neckv(pc1) = -.2
 ELSE
 fighterfreeze (pc1)
 position%(pc1) = 1
 END IF
END IF

'Detect hit
IF pticker%(pc1) = 9 THEN
 fighterfreeze (pc1)

 IF hand2x(pc2) > m1x - 4 AND hand2x(pc2) < m2x + 4 AND hand2y(pc2) > h1y AND hand2y(pc2) < l2y THEN
  IF razers%(pc1) > 0 THEN
  n% = 10
  bgcolor% = 15
  ELSE
  bgcolor% = 4
  END IF
 IF position%(po1) <> 99 THEN health%(po1) = health%(po1) - ((ahpow%(pc1) + n%) * 3)
 ko(po1) = ko(po1) - akpow%(pc1) * 2

 buttv(po1) = 2
 neckh(po1) = -d%(pc1)
 necky(po1) = necky(po1) + 3
 heady(po1) = 4
 position%(po1) = 8
 IF body%(pc1) = 666 THEN particle (hand2x(pc2)), (hand2y(pc2)), (fighterz(pc1)), 21, 5: health%(po1) = health%(po1) - 50
 particle (hand2x(pc2)), (hand2y(pc2)), (fighterz(pc1)), 3, 5
 particle (hand2x(pc2)), (hand2y(pc2)), (fighterz(pc1)), 4, 5
 particle (hand2x(pc2)), (hand2y(pc2)), (fighterz(pc1)), 9, 5
 END IF
END IF

'Return Position
IF pticker%(pc1) = 10 THEN
position%(pc1) = 1
elbow2h(pc1) = -1
hand2v(pc1) = 1
END IF


'Effects
IF pticker%(pc1) > 8 THEN
psline (neckx(pc2) + (7 * d%(pc1))), (necky(pc2) + 5), (fighterz(pc1)), (neckx(pc2) + (4 * d%(pc1))), (necky(pc2) - 7), (fighterz(pc1)), (15), 3
psline (neckx(pc2) + (5 * d%(pc1))), (necky(pc2) - 3), (fighterz(pc1)), (neckx(pc2) - (4 * d%(pc1))), (necky(pc2) - 10), (fighterz(pc1)), (15), 3
END IF

'---------------------------------------------------------------- Thrust Slam
CASE IS = 37

'Draw Back
IF pticker%(pc1) < 6 THEN
elbow1h(pc1) = -1
elbow1v(pc1) = -.5
hand1x(pc1) = 1
hand1y(pc1) = -1
END IF

'Jab
IF pticker%(pc1) = 6 THEN
 IF ko(pc1) > 10 THEN
 ko(pc1) = ko(pc1) - 5
 fighterfreeze (pc1)
 elbow1x(pc1) = 3
 elbow1y(pc1) = 6
 hand1x(pc1) = 4
 hand1y(pc1) = 0
 neckx(pc1) = 4
 necky(pc1) = -7
 neckv(pc1) = -.2
 ELSE
 fighterfreeze (pc1)
 position%(pc1) = 1
 END IF
END IF

elbow2x(pc1) = elbow1x(pc1)
elbow2y(pc1) = elbow1y(pc1) - 4
hand2x(pc1) = hand1x(pc1)
hand2y(pc1) = hand1y(pc1)


'Detect hit
IF pticker%(pc1) = 7 THEN
 fighterfreeze (pc1)

 IF hand1x(pc2) > m1x - 4 AND hand1x(pc2) < m2x + 4 AND hand1y(pc2) > h1y AND hand1y(pc2) < l2y THEN
  IF razers%(pc1) > 0 THEN
  particle (hand1x(pc2)), (hand1y(pc2)), (fighterz(pc1)), 23, 20
  health%(po1) = health%(po1) - 25
  bgcolor% = 15
  soundticker% = 0: sbfx 17
  ELSE
  bgcolor% = 1
  sbfx 11
  END IF

 IF position%(po1) <> 99 THEN
 ko(po1) = ko(po1) - akpow%(pc1) * 3
 canjump%(po1) = 0
 butth(po1) = d%(pc1) * (akpow%(pc1) * 2)
 position%(po1) = 15
 ELSE
 canjump%(pc1) = 0
 butth(pc1) = -d%(pc1) * (akpow%(pc1) * 1.5)
 position%(pc1) = 1
 END IF

 particle (hand1x(pc2)), (hand1y(pc2)), (fighterz(pc1)), 22, 10
 END IF
END IF

'Return Position
IF pticker%(pc1) >= 12 THEN
position%(pc1) = 1
elbow1h(pc1) = -1
hand1v(pc1) = 1
END IF


'Effects
IF pticker%(pc1) > 6 AND pticker%(pc1) < 8 THEN
psline (neckx(pc2) - (8 * d%(pc1))), (necky(pc2) + 2), (fighterz(pc1)), (neckx(pc2) + (6 * d%(pc1))), (necky(pc2) + 3), (fighterz(pc1)), (15), 3
psline (neckx(pc2) - (8 * d%(pc1))), (necky(pc2) + 7), (fighterz(pc1)), (neckx(pc2) + (6 * d%(pc1))), (necky(pc2) + 6), (fighterz(pc1)), (15), 3
END IF






'-------------------------------------------------------------- Rising Dragon
CASE IS = 38
IF pticker%(pc1) = 1 THEN
fighterfreeze (pc1)
neckx(pc1) = 5
necky(pc1) = -5
elbow2x(pc1) = 1

elbow1x(pc1) = -3
elbow1y(pc1) = 5
hand1x(pc1) = 0
hand1y(pc1) = 4

nee1x(pc1) = 4
foot1x(pc1) = -1
nee1y(pc1) = 1
foot1y(pc1) = 7
nee1v(pc1) = -.5
END IF


IF pticker%(pc1) > 1 AND buttv(pc1) <= 0 THEN

IF neckx(pc1) > 0 THEN neckh(pc1) = -2 ELSE neckx(pc1) = 0: neckh(pc1) = 0
nee2x(pc1) = 0
foot2x(pc1) = -1
nee2y(pc1) = 8
foot2y(pc1) = 7

headx(pc1) = 0
elbow2x(pc1) = 3
hand2x(pc1) = 0
hand2y(pc1) = -3
IF elbow2y(pc1) > -5 THEN elbow2v(pc1) = -2 ELSE elbow2v(pc1) = 0
butth(pc1) = butth(pc1) / 1.5
END IF

IF pticker%(pc1) = 4 THEN
canjump%(pc1) = 1
jump (pc1), (1)
butth(pc1) = d%(pc1) * 5
END IF

'Detect Hit(s)
IF pticker%(pc1) = 4 OR pticker%(pc1) = 7 OR pticker%(pc1) = 9 OR pticker%(pc1) = 12 OR pticker%(pc1) = 15 THEN

 IF ko(pc1) < 5 THEN
  fall (pc1)
  butth(pc1) = 0
  buttv(pc1) = 0
 ELSE
 ko(pc1) = ko(pc1) - 1
 IF hand2x(pc2) > m1x - 7 AND hand2x(pc2) < m2x + 7 AND hand2y(pc2) > h1y - 10 AND hand2y(pc2) < l2y + 10 THEN

 IF position%(po1) = 99 THEN
 pticker%(po1) = 1
 ELSE
 soundticker% = 0: sbfx 11
 IF razers%(pc1) > 0 THEN n% = 10: bgcolor% = 4: particle (hand2x(pc2)), (hand2y(pc2)), (fighterz(pc1)), 21, 15: soundticker% = 0: sbfx 17
 health%(po1) = health%(po1) - (ahpow%(pc1) + n%)
 position%(po1) = 10
 particle (hand2x(pc2)), (hand2y(pc2)), (fighterz(pc1)), 2, 5
 ko(po1) = ko(po1) - (akpow%(pc1) * 2)
 END IF


 IF health%(po1) <= 0 THEN decap (po1)
 butth(pc1) = d%(pc1) / 3
 buttv(po1) = buttv(pc1) - 1
 particle (hand2x(pc2)), (hand2y(pc2)), (fighterz(pc1)), 6, 5
 IF pticker%(pc1) = 15 THEN IF position%(po1) <> 99 THEN fall (po1) ELSE butth(po1) = butth(po1) - d%(po1)
 END IF
 END IF
END IF

'Effects
particle (hand2x(pc2)), (hand2y(pc2)), (fighterz(pc1)), 19, 1
psline (hand2x(pc2)), (hand2y(pc2)), (fighterz(pc1)), (hand2x(pc2) - (butth(pc1) * 5)), (hand2y(pc2) - (buttv(pc1) * 5)), (fighterz(pc1)), flash1%, 0

'Return Position
IF pticker%(pc1) >= 15 THEN
position%(pc1) = 1
nee1v(pc1) = 2
END IF


'--------------------------------------------------------------- Stun Knuckle
CASE IS = 39

'Draw Back
IF pticker%(pc1) < 6 THEN
elbow1h(pc1) = -1
elbow1v(pc1) = -.5
hand1x(pc1) = 1
hand1y(pc1) = -1
END IF

'Stun Knuckle
IF pticker%(pc1) = 6 THEN
 IF ko(pc1) > 6 THEN
 ko(pc1) = ko(pc1) - 4
 fighterfreeze (pc1)
 hand1x(pc1) = 4
 elbow1x(pc1) = 4
 hand1y(pc1) = 1
 elbow1y(pc1) = -1
 neckx(pc1) = 4
 ELSE
 fighterfreeze (pc1)
 position%(pc1) = 1
 END IF
END IF

'Detect hit
IF pticker%(pc1) = 7 THEN
 fighterfreeze (pc1)

 IF hand1x(pc2) > m1x - 2 AND hand1x(pc2) < m2x + 2 AND hand1y(pc2) > h1y - 4 AND hand1y(pc2) < l2y THEN
  IF razers%(pc1) > 0 THEN
  n% = 10
  bgcolor% = 12
  health%(po1) = health%(po1) - (ahpow%(pc1) * 5)
  ELSE
  bgcolor% = 4
  END IF

  IF position%(po1) <> 99 THEN
  ko(po1) = ko(po1) - (akpow%(pc1) * 4)
  position%(po1) = 15
  fighterfreeze (po1)
  particle (hand1x(pc2)), (hand1y(pc2)), (fighterz(pc1)), 6, 10
  sbfx 8
  ELSE
  bgcolor% = 0
  END IF
 ELSE
 position%(pc1) = 1
 END IF

END IF

'Return Position
IF pticker%(pc1) >= 8 THEN
position%(pc1) = 1
elbow1x(pc1) = 2
END IF

'Effects
IF pticker%(pc1) > 4 THEN
pscircle (hand1x(pc2)), (hand1y(pc2)), (fighterz(pc1) + .1), 2, flash1%
pscircle (hand1x(pc2)), (hand1y(pc2)), (fighterz(pc1) + .1), 1, flash2%
END IF


'----------------------------------------------------------------- Plant Kick
CASE IS = 40

IF pticker%(pc1) = 1 THEN
 IF canjump%(pc1) = 1 THEN
 fighterfreeze (pc1)
 nee1y(pc1) = -2
 nee2y(pc1) = 0
 hand2h(pc1) = -1
 hand2v(pc1) = 1
 ELSE
 position%(pc1) = 1
 END IF
END IF


IF pticker%(pc1) = 4 THEN
 IF ko(pc1) > 10 THEN
 ko(pc1) = ko(pc1) - 10
 sbfx 4
 ELSE
 fighterfreeze (pc1)
 position%(pc1) = 1
 END IF
END IF

IF pticker%(pc1) > 3 THEN
psline (foot1x(pc2)), (foot1y(pc2)), (fighterz(pc1)), (neckx(pc2) + ((RND - .5) * 5)), (butty(pc1) + RND * 5), (fighterz(pc1)), (flash1%), 0
psline (foot1x(pc2)), (foot1y(pc2)), (fighterz(pc1)), (neckx(pc2) + ((RND - .5) * 5)), (butty(pc1) + RND * 5), (fighterz(pc1)), (flash2%), 0
END IF


IF pticker%(pc1) = 5 THEN

IF buttx(pc1) > buttx(po1) THEN d%(pc1) = -1 ELSE d%(pc1) = 1
fighterfreeze (pc1)

headx(pc1) = headx(pc1) - 2

IF foot1y(pc1) > foot2y(pc1) THEN elbow2y(pc1) = foot1y(pc1) / 2 ELSE elbow2y(pc1) = foot2y(pc1) / 2
hand2y(pc1) = elbow2y(pc1) + 1

elbow1x(pc1) = 1
elbow1y(pc1) = -6
hand1x(pc1) = 5
hand1y(pc1) = -2

elbow2x(pc1) = -3
hand2x(pc1) = -2

buttx(pc1) = buttx(pc1) + 7 * d%(pc1)
butty(pc1) = butty(pc1) - (elbow2y(pc1) * 2)
neckx(pc1) = -7
necky(pc1) = 7

nee1x(pc1) = 5
nee1y(pc1) = -7
foot1x(pc1) = 5
foot1y(pc1) = -6

nee2x(pc1) = 0
nee2y(pc1) = 5
foot2x(pc1) = 5
foot2y(pc1) = -6
END IF

'Detect Hit
IF pticker%(pc1) = 6 AND buttx(pc1) > neckx(po2) - 13 AND buttx(pc1) < neckx(po2) + 13 AND heady(po2) - 4 < foot2y(pc2) AND foot2y(pc2) < l2y THEN
IF position%(po1) <> 99 THEN
 soundticker% = 0: sbfx 11
 health%(po1) = health%(po1) - lhpow%(pc1) * 2
 ko(po1) = ko(po1) - lkpow%(pc1) * 7
 particle (foot1x(pc2)), (foot1y(pc2)), (fighterz(pc1)), 1, 5
 fall (po1)
 END IF
buttv(po1) = -10
butth(po1) = (1 + lhpow%(pc1) * d%(pc1))
particle (foot1x(pc2)), (foot1y(pc2)), (fighterz(pc1)), 5, 8
END IF


'return position
IF pticker%(pc1) >= 12 THEN
position%(pc1) = 1
nee2y(pc1) = hand2y(pc1)
foot2y(pc1) = hand2y(pc1)
foot2h(pc1) = -2
neckh(pc1) = 2
neckv(pc1) = -3
elbow1h(pc1) = -1
elbow1v(pc1) = 1
nee1v(pc1) = 1
foot1h(pc1) = -2
foot1v(pc1) = 2
hand2h(pc1) = .5
END IF


'Zero G
IF pticker%(pc1) > 4 THEN buttv(pc1) = -gravity





'------------------------------------------------------------------- Axe Kick
CASE IS = 41

IF pticker%(pc1) = 1 THEN
 fighterfreeze (pc1)
 IF ko(pc1) > 10 AND canjump%(pc1) = 1 THEN
 ko(pc1) = ko(pc1) - 5
 butth(pc1) = d%(pc1)
 sbfx 2
 neckh(pc1) = -1
 ELSE
 position%(pc1) = 1
 END IF
END IF


SELECT CASE pticker%(pc1)

CASE 2
sbfx 2
nee2x(pc1) = 1
foot2x(pc1) = -1
neckx(pc1) = -1
foot1v(pc1) = 3

nee1x(pc1) = 3
nee1y(pc1) = -6
foot1x(pc1) = 3
foot1y(pc1) = -6

CASE 4
neckh(pc1) = 0
nee1x(pc1) = 6
nee1y(pc1) = -1
foot1x(pc1) = 6
foot1y(pc1) = -1

CASE 6
foot1v(pc1) = 0
nee1x(pc1) = 5
nee1y(pc1) = 5
foot1x(pc1) = 5
foot1y(pc1) = 5
END SELECT


'Detect Hit
IF pticker%(pc1) > 2 AND pticker%(pc1) < 7 THEN
IF foot1x(pc2) > l1x AND foot1x(pc2) < l2x AND foot1y(pc2) > h1y AND foot1y(pc2) < l2y THEN
soundticker% = 0: sbfx 11
health%(po1) = health%(po1) - lhpow%(pc1)
ko(po1) = ko(po1) - lkpow%(pc1)
particle (foot1x(pc2) + 5), (foot1y(pc2)), (fighterz(pc1)), 1, 5
butth(po1) = butth(pc1)
position%(po1) = 1
END IF
END IF



'Return Position
IF pticker%(pc1) = 7 THEN
foot1x(pc1) = -1
position%(pc1) = 1
END IF

'Effects
particle (foot1x(pc2)), (foot1y(pc2)), (fighterz(pc1)), 19, 1


'---------------------------------------------------------- Stunning Gut Stab
CASE IS = 42

IF pticker%(pc1) = 1 THEN
d%(pc1) = -d%(pc1)
sbfx 3
 IF ko(pc1) > 10 THEN
 ko(pc1) = ko(pc1) - 5
 ELSE
 position%(pc1) = 1
 END IF
END IF

IF pticker%(pc1) > 1 AND pticker%(pc1) < 8 THEN
nee1x(pc1) = -6
nee1y(pc1) = -1
foot1x(pc1) = -6
foot1y(pc1) = -1
nee2x(pc1) = 0
foot2x(pc1) = 0
END IF

IF foot1x(pc2) > l1x AND foot1x(pc2) < l2x AND foot1y(pc2) > h1y AND foot1y(pc2) < l2y THEN
sbfx 11
health%(po1) = health%(po1) - 1
ko(po1) = ko(po1) - 1
IF buttx(pc1) < buttx(po1) THEN particle (foot1x(pc2) + 5), (foot1y(pc2)), (fighterz(pc1)), 4, 3 ELSE particle (foot1x(pc2) - 5), (foot1y(pc2)), (fighterz(pc1)), 3, 3
position%(po1) = 15
END IF


IF pticker%(pc1) = 8 THEN
nee1h(pc1) = 1
nee1v(pc1) = .5
neckx(pc1) = .5

END IF


'Return Position
IF pticker%(pc1) = 15 THEN
d%(pc1) = -d%(pc1)
position%(pc1) = 1
sbfx 1
END IF

'---------------------------------------------------------- Thrust Roundhouse
CASE IS = 43

'Draw Back
IF pticker%(pc1) = 1 THEN

fighterfreeze (pc1)
combo%(pc1) = 0

IF ko(pc1) > 10 THEN
butth(pc1) = butth(pc1) + (d%(pc1) * 3)
buttv(pc1) = buttv(pc1) - 1.5
END IF

elbow1y(pc1) = elbow1y(pc1) - 4
elbow2y(pc1) = elbow2y(pc1) - 4

neckx(pc1) = 5
necky(pc1) = -5
buttx(pc1) = buttx(pc1) + (d%(pc1) * 2)

nee1x(pc1) = 5
nee1y(pc1) = 4
foot1x(pc1) = -4
foot1y(pc1) = 3

END IF


'Begin Kick
IF pticker%(pc1) = 5 THEN

IF ko(pc1) > 10 THEN
ko(pc1) = ko(pc1) - 6
nee2h(pc1) = 2
nee2v(pc1) = -2
foot2h(pc1) = -1
foot2v(pc1) = -1
ELSE
position%(pc1) = 1
END IF
END IF

IF pticker%(pc1) = 8 THEN
fighterfreeze (pc1)

elbow1x(pc1) = elbow1x(pc1) + 2

hand2y(pc1) = hand2y(pc1) + 2
elbow2y(pc1) = elbow2y(pc1) + 2

nee2x(pc1) = 6
nee2y(pc1) = 1

foot2x(pc1) = 5
foot2y(pc1) = 1
END IF

'Detect Hit
IF pticker%(pc1) > 7 AND combo%(pc1) = 0 AND foot2x(pc2) > l1x AND foot2x(pc2) < l2x AND foot2y(pc2) > h1y AND foot2y(pc2) < l2y THEN
health%(po1) = health%(po1) - lhpow%(pc1) * 3
ko(po1) = ko(po1) - lkpow%(pc1) * 4
particle (foot2x(pc2)), (foot2y(pc2)), (fighterz(pc1)), 3, 5
particle (foot2x(pc2)), (foot2y(pc2)), (fighterz(pc1)), 4, 5
soundticker% = 0: sbfx 11
butth(po1) = butth(pc1) / 2
fall po1
END IF

IF pticker%(pc1) > 9 THEN
fighterfreeze (pc1)

nee2h(pc1) = -1
nee2v(pc1) = 1
foot2h(pc1) = -2
foot2v(pc1) = 1

position%(pc1) = 1
END IF


'Zero G
buttv(pc1) = buttv(pc1) - gravity


'Effects
particle (foot2x(pc2)), (foot2y(pc2)), (fighterz(pc1)), 19, 1


'------------------------------------------------------------- Slasher Strike
CASE IS = 44

IF pticker%(pc1) = 1 THEN
fighterfreeze (pc1)
neckx(pc1) = 0
neckh(pc1) = -.5
buttx(pc1) = buttx(pc1) + (d%(pc1) * 2)

nee1x(pc1) = 0
foot1x(pc1) = 0

 IF foot1y(pc1) < 1 OR nee1y(pc1) > 3 THEN
 nee1y(pc1) = 8
 foot1y(pc1) = 7
 END IF

elbow1h(pc1) = -.5
elbow2h(pc1) = .5
elbow2v(pc1) = -.5
END IF


IF pticker%(pc1) = 5 THEN
 IF ko(pc1) > 20 THEN
 ko(pc1) = ko(pc1) - 15
 nee2h(pc1) = 2
 nee2v(pc1) = -2
 foot2h(pc1) = -1
 foot2v(pc1) = -1
 ELSE
 position%(pc1) = 10
 END IF
END IF



IF pticker%(pc1) = 8 THEN
sbfx 4
fighterfreeze (pc1)

elbow1x(pc1) = elbow1x(pc1) + 2
elbow1y(pc1) = elbow1y(pc1) - 2

hand2y(pc1) = hand2y(pc1) + 2
elbow2y(pc1) = elbow2y(pc1) + 2

nee2x(pc1) = 5
nee2y(pc1) = 0


foot2x(pc1) = 5
foot2y(pc1) = 0
END IF

'Slash Effect
IF pticker%(pc1) > 8 THEN
psline (foot2x(pc2) - 15), (foot2y(pc2)), (fighterz(pc1)), (foot2x(pc2) + 15), (foot2y(pc2)), (fighterz(pc1)), (flash2%), 0
END IF


'Detect Hit
IF pticker%(pc1) = 9 AND foot2x(pc2) > l1x - 10 AND foot2x(pc2) < l2x + 10 AND foot2y(pc2) > h1y AND foot2y(pc2) < l2y THEN
psline (buttx(po1) - 100), (foot2y(pc2)), (fighterz(pc1)), (buttx(po1) + 100), (foot2y(pc2)), (fighterz(pc1)), (15), 0
health%(po1) = health%(po1) - lhpow%(pc1) * 4
soundticker% = 0: sbfx 17
ko(po1) = ko(po1) - lkpow%(pc1) * 4
particle (buttx(po1)), (foot2y(pc2)), (fighterz(pc1)), 21, 10
position%(po1) = 15
END IF


IF pticker%(pc1) > 9 THEN
fighterfreeze (pc1)

neckh(pc1) = .5
nee2h(pc1) = -1
nee2v(pc1) = 1
foot2h(pc1) = -2
foot2v(pc1) = 1

position%(pc1) = 1
END IF

'Effects
psline (foot2x(pc2) - 1), (foot2y(pc2)), (fighterz(pc1) - .1), (foot2x(pc2) + 1), (foot2y(pc2)), (fighterz(pc1) - .1), (flash2%), 0



'------------------------------------------------------------------- Nee Bash
CASE IS = 45

'Attempt head grab
IF pticker%(pc1) = 1 THEN
fighterfreeze (pc1)
elbow1x(pc1) = 3
elbow1y(pc1) = -1
hand1x(pc1) = 3
hand1y(pc1) = -2
END IF

'Detect head grab
IF pticker%(pc1) = 2 THEN
 IF position%(po1) <> 99 AND ko(pc1) > 15 AND hand1x(pc2) > h1x AND hand1x(pc2) < h2x AND hand1y(pc2) > h1y AND hand1y(pc2) < h2y THEN
 sbfx 13
 ko(pc1) = ko(pc1) - 10
 combol%(pc1) = sdelay%(po1) * 3
 fighterfreeze (po1)
 ELSE
 position%(pc1) = 1
 END IF
END IF


'Bashing
IF pticker%(pc1) > 2 THEN
position%(po1) = 1
elbow1v(pc1) = -.6
hand1v(pc1) = -.8

 'hit
 IF elbow1y(pc1) < -2 THEN
 elbow1y(pc1) = 4: hand1y(pc1) = 5
 health%(po1) = health%(po1) - ahpow%(pc1)
 ko(po1) = ko(po1) - akpow%(pc1)
 health%(po1) = health%(po1) - lhpow%(pc1)
 ko(po1) = ko(po1) - lkpow%(pc1)
 soundticker% = 0: sbfx 9
 IF buttx(pc1) < buttx(po1) THEN particle (hand1x(pc2)), (butty(pc1)), (fighterz(po1)), 3, 3 ELSE particle (hand1x(pc2)), (butty(pc1)), (fighterz(po1)), 4, 3
 END IF

elbow2y(pc1) = 3 - elbow1y(pc1) / 2
necky(pc1) = -10 + elbow1y(pc1) / 5
nee2x(pc1) = elbow1y(pc1) + 2
nee2y(pc1) = -elbow1y(pc1)
neckx(po1) = nee2x(pc1)
necky(po1) = -7 + elbow1y(pc1) + hand1y(pc1)


 'Return position
 IF combol%(pc1) <= 0 THEN
 position%(pc1) = 1
 butth(pc1) = -d%(pc1)
 elbow1h(pc1) = -.5
 elbow1y(pc1) = .5
 END IF
END IF



'------------------------------------------------------- Lightning Kick Blast
CASE IS = 46

IF pticker%(pc1) = 1 THEN
fighterfreeze (pc1)
END IF

IF pticker%(pc1) < 10 THEN
sbfx 16
neckx(pc1) = -3 - RND
necky(pc1) = -7 + RND

r1 = (RND * 3) + 2
r2 = (RND - .5) * 15
nee1x(pc1) = r1
nee1y(pc1) = r2
foot1x(pc1) = r1
foot1y(pc1) = r2

'Detect Hit(s)
IF foot1x(pc2) > l1x AND foot1x(pc2) < l2x AND foot1y(pc2) > h1y AND foot1y(pc2) < l2y THEN
ko(po1) = ko(po1) - lkpow%(pc1)
position%(po1) = 1
particle (foot1x(pc2)), (foot1y(pc2)), (fighterz(pc1)), 9, 5
END IF
END IF



IF pticker%(pc1) = 10 THEN
soundticker% = 0: sbfx 11
d%(pc1) = -d%(pc1)
neckx(pc1) = 5
necky(pc1) = -2
nee1x(pc1) = -6
nee1y(pc1) = 0
foot1x(pc1) = -6
foot1y(pc1) = 0
END IF

'Detect Blast
IF pticker%(pc1) = 11 AND foot1x(pc2) > l1x AND foot1x(pc2) < l2x AND foot1y(pc2) > h1y AND foot1y(pc2) < l2y THEN
health%(po1) = health%(po1) - lhpow%(pc1) * 5
ko(po1) = ko(po1) - lkpow%(pc1) * 2
particle (foot1x(pc2)), (foot1y(pc2)), (fighterz(pc1)), 1, 5
butth(po1) = (lkpow%(pc1) * -d%(pc1))
neckx(po1) = 5
necky(po1) = -5
nee1x(po1) = 5
foot1x(po1) = 5
fall (po1)
END IF


'Effects
IF pticker%(pc1) > 9 THEN
psline (foot1x(pc2)), (foot1y(pc2)), (fighterz(pc1)), (neckx(pc2) + ((RND - .5) * 5)), (butty(pc1) + (RND - .5) * 8), (fighterz(pc1)), (flash1%), 0
psline (foot1x(pc2)), (foot1y(pc2)), (fighterz(pc1)), (neckx(pc2) + ((RND - .5) * 5)), (butty(pc1) + (RND - .5) * 5), (fighterz(pc1)), (flash2%), 0
END IF


'Return position
IF pticker%(pc1) = 13 THEN
position%(pc1) = 1
END IF

'--------------------------------------------------------------------- 6-Slip
CASE IS = 47
IF ko(pc1) < 15 THEN position%(pc1) = 1

IF pticker%(pc1) = 1 THEN ds%(pc1) = d%(pc1): ds%(po1) = d%(po1)

IF pticker%(pc1) < 5 THEN fighterz(pc1) = fighterz(pc1) - .1

butth(pc1) = d%(pc1) * 2

IF buttx(pc1) > buttx(po1) - 10 AND buttx(pc1) < buttx(po1) + 10 AND canjump%(po1) = 1 THEN
d%(po1) = ds%(po1)
pticker%(po1) = 0
END IF

'return position
IF pticker%(pc1) = 8 THEN position%(pc1) = 1: d%(pc1) = -ds%(pc1): ko(pc1) = ko(pc1) - 5


'------------------------------------------------------------------ Skip Kick
CASE IS = 48

IF pticker%(pc1) = 1 THEN
sbfx 3
 IF ko(pc1) > 10 AND canjump%(pc1) = 1 THEN
 ko(pc1) = ko(pc1) - 5
 buttv(pc1) = -5
 butth(pc1) = d%(pc1) * 2
 ELSE
 position%(pc1) = 1
 END IF
END IF

IF pticker%(pc1) = 9 THEN d%(pc1) = -d%(pc1)

IF pticker%(pc1) > 10 AND pticker%(pc1) < 13 THEN
nee1x(pc1) = -6
nee1y(pc1) = -1
foot1x(pc1) = -6
foot1y(pc1) = -1
nee2x(pc1) = 0
foot2x(pc1) = 0
END IF

'Detect Hit
IF pticker%(pc1) > 9 AND pticker%(pc1) < 13 THEN
IF foot1x(pc2) > l1x AND foot1x(pc2) < l2x AND foot1y(pc2) > h1y AND foot1y(pc2) < l2y THEN
sbfx 11
health%(po1) = health%(po1) - akpow%(pc1) * 3
ko(po1) = ko(po1) - lkpow%(pc1) * 3
IF buttx(pc1) < buttx(po1) THEN particle (foot1x(pc2) + 5), (foot1y(pc2)), (fighterz(pc1)), 4, 3 ELSE particle (foot1x(pc2) - 5), (foot1y(pc2)), (fighterz(pc1)), 3, 3
butth(po1) = butth(pc1)
END IF
END IF

IF pticker%(pc1) = 13 THEN
nee1h(pc1) = 1
nee1v(pc1) = .5
neckx(pc1) = .5
END IF


'Return Position
IF pticker%(pc1) = 18 THEN
d%(pc1) = -d%(pc1)
position%(pc1) = 1
sbfx 1
END IF






'-------------------------------------------------------------- Upper Assault
CASE IS = 49
IF pticker%(pc1) = 1 THEN
fighterfreeze (pc1)
neckx(pc1) = 5
necky(pc1) = -5
elbow2x(pc1) = 1

elbow1x(pc1) = -3
elbow1y(pc1) = 5
hand1x(pc1) = 0
hand1y(pc1) = 4

nee1x(pc1) = 4
foot1x(pc1) = -1
nee1y(pc1) = 1
foot1y(pc1) = 7
nee1v(pc1) = -.5

nee2x(pc1) = 4
nee2v(pc1) = -.5

END IF


IF pticker%(pc1) > 1 AND buttv(pc1) <= 0 THEN

IF neckx(pc1) > 0 THEN neckh(pc1) = -2 ELSE neckx(pc1) = 0: neckh(pc1) = 0
nee2x(pc1) = 0
foot2x(pc1) = -1
nee2y(pc1) = 8
foot2y(pc1) = 7

nee1x(pc1) = 2
nee1y(pc1) = -4
foot1x(pc1) = 2
foot1y(pc1) = -5


headx(pc1) = 0
elbow1x(pc1) = -1
elbow2x(pc1) = -1
elbow1y(pc1) = 3
elbow2y(pc1) = 3
hand1x(pc1) = 2
hand2x(pc1) = 2
hand1y(pc1) = 3
hand2y(pc1) = 3

butth(pc1) = butth(pc1) / 1.5
END IF

IF pticker%(pc1) = 4 THEN
canjump%(pc1) = 1
jump (pc1), (1)
butth(pc1) = d%(pc1) * 5
END IF


'Detect Hit(s)
IF pticker%(pc1) = 4 OR pticker%(pc1) = 7 OR pticker%(pc1) = 9 OR pticker%(pc1) = 12 OR pticker%(pc1) = 15 THEN

 IF ko(pc1) < 5 THEN
  fall (pc1)
  butth(pc1) = 0
  buttv(pc1) = 0
 ELSE
 ko(pc1) = ko(pc1) - 1
 IF foot1x(pc2) > m1x - 7 AND foot1x(pc2) < m2x + 7 AND foot1y(pc2) > h1y - 10 AND foot1y(pc2) < l2y + 10 THEN

 IF position%(po1) = 99 THEN
 pticker%(po1) = 1
 ELSE
 soundticker% = 0: sbfx 11
 position%(po1) = 10
 particle (foot1x(pc2)), (foot1y(pc2)), (fighterz(pc1)), 2, 5
 ko(po1) = ko(po1) - (lkpow%(pc1) * 2)
 health%(po1) = health%(po1) - (lhpow%(pc1) + n%)
 END IF


 butth(pc1) = d%(pc1) / 3
 buttv(po1) = buttv(pc1) - 1
 particle (hand2x(pc2)), (hand2y(pc2)), (fighterz(pc1)), 6, 5
 IF pticker%(pc1) = 15 THEN IF position%(po1) <> 99 THEN fall (po1) ELSE butth(po1) = butth(po1) - d%(po1)
 END IF
 END IF
END IF

'Effects
particle (foot1x(pc2)), (foot1y(pc2)), (fighterz(pc1)), 19, 1
psline (foot1x(pc2)), (foot1y(pc2)), (fighterz(pc1)), (foot1x(pc2) - (butth(pc1) * 5)), (foot1y(pc2) - (buttv(pc1) * 5)), (fighterz(pc1)), flash1%, 0

'Return Position
IF pticker%(pc1) = 15 THEN
position%(pc1) = 1
nee1v(pc1) = 2
END IF





'SUPERS ============================================================== SUPERS`

'---------------------------------------------------------------- Vex of Evil
CASE IS = 81

IF pticker%(pc1) = 1 THEN
 IF canjump%(pc1) = 1 THEN
 fighterfreeze (pc1)

 hand1h(pc1) = (RND - .5) / 10
 hand1v(pc1) = (RND - .5) / 10
 hand2h(pc1) = (RND - .5) / 10
 hand2v(pc1) = (RND - .5) / 10
 elbow1h(pc1) = (RND - .5) / 10
 elbow1v(pc1) = (RND - .5) / 10
 elbow2h(pc1) = (RND - .5) / 10
 elbow2v(pc1) = (RND - .5) / 10
 ELSE
 position%(pc1) = 1
 END IF
END IF

rage(pc1) = rage(pc1) - 1.5
IF pticker%(pc1) < 40 THEN
particle (hand1x(pc2)), (hand1y(pc2)), (fighterz(pc1)), 19, 1
particle (hand2x(pc2)), (hand2y(pc2)), (fighterz(pc1)), 19, 1
END IF

IF elbow1x(pc1) > 1 THEN elbow1h(pc1) = elbow1h(pc1) - .2 ELSE elbow1h(pc1) = elbow1h(pc1) + .2
IF elbow1y(pc1) > 4 THEN elbow1v(pc1) = elbow1v(pc1) - .2 ELSE elbow1v(pc1) = elbow1v(pc1) + .2
IF elbow2x(pc1) > 1 THEN elbow2h(pc1) = elbow2h(pc1) - .2 ELSE elbow2h(pc1) = elbow2h(pc1) + .2
IF elbow2y(pc1) > 4 THEN elbow2v(pc1) = elbow2v(pc1) - .2 ELSE elbow2v(pc1) = elbow2v(pc1) + .2

IF hand1x(pc1) > 1 THEN hand1h(pc1) = hand1h(pc1) - .2 ELSE hand1h(pc1) = hand1h(pc1) + .2
IF hand1y(pc1) > -2 THEN hand1v(pc1) = hand1v(pc1) - .2 ELSE hand2v(pc1) = hand1v(pc1) + .2
IF hand2x(pc1) > 1 THEN hand2h(pc1) = hand2h(pc1) - .2 ELSE hand2h(pc1) = hand2h(pc1) + .2
IF hand2y(pc1) > -2 THEN hand2v(pc1) = hand2v(pc1) - .2 ELSE hand2v(pc1) = hand2v(pc1) + .2


'Vex and Return Position
IF pticker%(pc1) >= 75 THEN
rage(po1) = rage(po1) * .75
vexed%(po1) = 1
position%(pc1) = 1
particle (neckx(po2)), (necky(po2)), fighterz(po1), 26, 25
END IF




'--------------------------------------------------------------- Energy Blast
CASE IS = 82

fighterfreeze (pc1)
IF head%(pc1) <> 1998 THEN rage(pc1) = 0

IF neckx(pc1) > 2 THEN neckv(pc1) = -.2 ELSE neckv(pc1) = .2
IF necky(pc1) > -7 THEN neckv(pc1) = -.2 ELSE neckv(pc1) = .2
IF hand1x(pc1) > -1 THEN hand1h(pc1) = -.2 ELSE hand1h(pc1) = .2
IF hand2x(pc1) > 1 THEN hand2h(pc1) = -.2 ELSE hand2h(pc1) = .2
IF hand1y(pc1) > 2 THEN hand1v(pc1) = -.2 ELSE hand1v(pc1) = .2
IF hand2y(pc1) > 3 THEN hand2v(pc1) = -.2 ELSE hand2v(pc1) = .2
IF elbow2x(pc1) > -6 THEN elbow2h(pc1) = -.2 ELSE elbow2h(pc1) = .2

IF pticker%(pc1) > sdelay%(pc1) AND projectile%(1 * pc1) = 0 THEN
IF buttx(pc1) > buttx(po1) THEN d%(pc1) = -1 ELSE d%(pc1) = 1
IF pc1 = 2 THEN n% = 3
soundticker% = 0: sbfx 8
projectile%(1 + n%) = 50
projectilex(1 + n%) = hand1x(pc2)
projectiley(1 + n%) = necky(pc2)
projectileh(1 + n%) = d%(pc1) * 10
projectilev(1 + n%) = 0
projectilet%(1 + n%) = 5

position%(pc1) = 1
neckx(pc1) = 5
necky(pc1) = -6

elbow1x(pc1) = 5
hand1x(pc1) = 4
elbow1y(pc1) = 0
hand1y(pc1) = 0

elbow2x(pc1) = 5
hand2x(pc1) = 4
elbow2y(pc1) = 0
hand2y(pc1) = 0

butth(pc1) = butth(pc1) - d%(pc1)
bgcolor% = 19
END IF


x = (hand1x(pc2) + hand2x(pc2)) / 2
y = (hand1y(pc2) + hand2y(pc2)) / 2

'Effects
sbfx 7
psline (x), (y), (fighterz(pc1)), (x - (RND * 75)), (y + ((RND - .5) * 250)), (fighterz(pc1)), 15, 0
psline (x), (y), (fighterz(pc1)), (x + (RND * 75)), (y + ((RND - .5) * 250)), (fighterz(pc1)), 15, 0
pslightning (x), (y), (fighterz(pc1)), (x - (RND * 100)), (y + ((RND - .5) * 200)), (fighterz(pc1)), 75, (flash2%)
pslightning (x), (y), (fighterz(pc1)), (x + (RND * 100)), (y + ((RND - .5) * 200)), (fighterz(pc1)), 50, (flash2%)
IF pticker%(pc1) < 10 THEN pscircle (x), (y), (fighterz(pc1)), 200 - (pticker%(pc1) * 20), flash1%
pscircle (x), (y), (fighterz(pc1)), RND * 5, flash2%
pscircle (x), (y), (fighterz(pc1)), 2, 15






'----------------------------------------------------------------- Spear Kick
CASE IS = 83

IF pticker%(pc1) = 1 THEN
fighterfreeze (pc1)
rage(pc1) = 0
blur 10
sbfx 2
neckx(pc1) = -3
nee1x(pc1) = 6
nee1y(pc1) = -1
foot1x(pc1) = 6
foot1y(pc1) = -1
butth(pc1) = d%(pc1) * 5
END IF

IF nee1x(pc2) > l1x AND nee1x(pc2) < l2x AND foot1y(pc2) > h1y AND foot1y(pc2) < l2y THEN
butth(pc1) = 0
health%(po1) = health%(po1) - 1
ko(po1) = ko(po1) - .5
particle (nee1x(pc2)), (nee1y(pc2)), (fighterz(po1)), 18, 1
buttx(po1) = nee1x(pc2)
neckx(po1) = ((RND - .5) * 2)
necky(po1) = -5 - (RND * 3)
elbow1x(po1) = -3 - (RND * 2)
elbow2x(po1) = -3 - (RND * 2)
elbow1y(po1) = 3 - (RND * 2)
elbow2y(po1) = 3 - (RND * 2)

hand1x(po1) = -3 + (RND * 2)
hand2x(po1) = -3 + (RND * 2)
hand1y(po1) = 3
hand2y(po1) = 3
IF pticker%(pc1) < 50 THEN position%(po1) = 15: pticker%(po1) = 1 ELSE butth(po1) = d%(pc1): fall (po1)


ELSE
IF pticker%(pc1) > 15 THEN pticker%(pc1) = 50

END IF


IF pticker%(pc1) = 50 THEN
position%(pc1) = 1
nee1x(pc1) = 2
foot1x(pc1) = -4
END IF


'------------------------------------------------------------------ Health Up
CASE IS = 84
rage(pc1) = 0
health%(pc1) = health%(pc1) + ko(pc1)
particle (headx(pc2)), (heady(pc2)), (fighterz(pc1)), 25, 25
position%(pc1) = 1


'----------------------------------------------------------------- Razer Arms
CASE IS = 85
soundticker% = 0: sbfx 16
particle (hand1x(pc2)), (hand1y(pc2)), (fighterz(pc1) + .2), 6, 5
particle (hand1x(pc2)), (hand1y(pc2)), (fighterz(pc1) + .2), 5, 5

particle (hand2x(pc2)), (hand2y(pc2)), (fighterz(pc1) - .2), 6, 5
particle (hand2x(pc2)), (hand2y(pc2)), (fighterz(pc1) - .2), 5, 5
razers%(pc1) = 200
position%(pc1) = 1
rage(pc1) = 0
bgcolor% = 19

'--------------------------------------------------------------- Neck Snapper
CASE IS = 86

IF pticker%(pc1) = 1 THEN
 IF canjump%(pc1) = 1 THEN
 nee1x(pc1) = 2
 nee2x(pc1) = 2
 foot1x(pc1) = -2
 foot2x(pc1) = -2
 nee1y(pc1) = 5
 nee2y(pc1) = 5

 camode% = po1 + 1
 rage(pc1) = 0
 buttv(pc1) = -12
 butth(pc1) = (buttx(po1) - buttx(pc1)) / 20
 ELSE
 position%(pc1) = 1
 END IF
END IF


IF foot1y(pc2) > butty(po1) AND buttv(pc1) > -1 THEN position%(pc1) = 1: camode% = 1

'Snap
IF foot1y(pc2) > heady(po2) - 5 AND foot1y(pc2) < necky(po2) + 5 AND buttx(pc1) > neckx(po2) - 5 AND buttx(pc1) < neckx(po2) + 5 THEN
fighterfreeze (po1)
buttx(pc1) = neckx(po2)
butty(pc1) = necky(po2) - 15 + ABS(buttv(pc1))
elbow2x(pc1) = -5
elbow1y(pc1) = 0
elbow2y(pc1) = 0
hand1y(pc1) = 0
hand2y(pc1) = 0
nee1x(pc1) = 4
nee2x(pc1) = -4
foot2x(pc1) = -4
nee1y(pc1) = 8
nee2y(pc1) = 8
foot1y(pc1) = 7
foot2y(pc1) = 7
buttv(pc1) = -10
position%(pc1) = 1
camode% = 1

IF position%(po1) <> 99 THEN
health%(po1) = health%(po1) - 75
soundticker% = 0: sbfx 8
IF health%(po1) <= 0 THEN decap (po1) ELSE bgcolor% = 15
particle (neckx(po2)), (necky(po2)), fighterz(po1), 20, 15
particle (neckx(po2)), (necky(po2)), fighterz(po1), 21, 10
position%(po1) = 15
d%(pc1) = -d%(pc1)
butth(pc1) = butth(pc1) / 5
buttv(pc1) = -10
ELSE
particle (neckx(po2)), (necky(po2)), fighterz(po1), 8, 25
buttv(pc1) = -5
END IF

END IF



'-------------------------------------------------------------- Swizz Punches
CASE IS = 87
IF pticker%(pc1) = 1 THEN
fighterfreeze (pc1)
rage(pc1) = 0
hand1x(pc1) = 5
hand2x(pc1) = 5
hand1y(pc1) = 0
hand2y(pc1) = 0
neckx(pc1) = 5
END IF

psline (hand1x(pc2)), (hand1y(pc2)), (fighterz(pc1)), (hand1x(pc2) - (pticker%(pc1) * 1.5 * d%(pc1))), (hand1y(pc2)), (fighterz(pc1) + .5), (flash1%), 0
psline (hand2x(pc2)), (hand2y(pc2)), (fighterz(pc1)), (hand2x(pc2) - (pticker%(pc1) * 1.5 * d%(pc1))), (hand2y(pc2)), (fighterz(pc1) - .5), (flash2%), 0


'detect hit(s)
IF hand1x(pc2) > m1x AND hand1x(pc2) < m2x AND hand1y(pc2) > h1y AND hand1y(pc2) < l2y THEN
 IF position%(po1) = 99 THEN butth(po1) = d%(pc1)
 health%(po1) = health%(po1) - 2
 ko(po1) = ko(po1) - 2
 neckx(po1) = 0
 IF health%(po1) > 0 AND ko(po1) > 0 AND pticker%(pc1) < 20 THEN fighterfreeze (po1): position%(po1) = 15 ELSE butth(po1) = d%(pc1)
 IF buttx(pc1) < buttx(po1) THEN particle (hand1x(pc2)), (hand1y(pc2)), (fighterz(pc1)), 4, 3 ELSE particle (hand1x(pc2)), (hand1y(pc2)), (fighterz(pc1)), 3, 3
 soundticker% = 0: sbfx INT(RND * 3) + 9
ELSE
 sbfx 25
END IF

IF hand2x(pc2) > m1x AND hand2x(pc2) < m2x AND hand2y(pc2) > h1y AND hand2y(pc2) < l2y THEN
 IF position%(po1) = 99 THEN butth(po1) = d%(pc1)
 health%(po1) = health%(po1) - 3
 ko(po1) = ko(po1) - 3
 neckx(po1) = 0
 IF health%(po1) > 0 AND ko(po1) > 0 AND pticker%(pc1) < 20 THEN fighterfreeze (po1): position%(po1) = 15 ELSE butth(po1) = d%(pc1)
 IF buttx(pc1) < buttx(po1) THEN particle (hand2x(pc2)), (hand2y(pc2)), (fighterz(pc1)), 4, 3 ELSE particle (hand2x(pc2)), (hand2y(pc2)), (fighterz(pc1)), 3, 3
 soundticker% = 0: sbfx INT(RND * 3) + 9
ELSE
 sbfx 25
END IF


elbow1x(pc1) = (RND - .5) * 12
elbow2x(pc1) = (RND - .5) * 12
elbow1y(pc1) = (RND - .4) * 12
elbow2y(pc1) = (RND - .4) * 12


IF pticker%(pc1) = 10 THEN blur 15

IF pticker%(pc1) = 25 THEN position%(pc1) = 1

'----------------------------------------------------------------- Upper Bust
CASE IS = 88

IF pticker%(pc1) = 1 THEN soundticker% = 0: sbfx 25

fighterfreeze (pc1)
rage(pc1) = 0

elbow2x(pc1) = 3
elbow2y(pc1) = -5
hand2x(pc1) = 0
hand2y(pc1) = -4

elbow1x(pc1) = -3
elbow1y(pc1) = 5
hand1x(pc1) = 0
hand1y(pc1) = 4

headx(pc1) = 0
necky(pc1) = -10
neckx(pc1) = 1

nee1x(pc1) = 5
nee2x(pc1) = -1
foot1x(pc1) = -1
foot2x(pc1) = -3

nee1y(pc1) = 8
nee2y(pc1) = 8
foot1y(pc1) = 7
foot2y(pc1) = 7


'Detect Hit
IF pticker%(pc1) = 2 THEN
 particle (hand2x(pc2)), (necky(pc2)), fighterz(pc1), 22, 10
 
 IF hand2x(pc2) > m1x - 8 AND hand2x(pc2) < m2x + 8 AND hand2y(pc2) > h1y - 15 AND hand2y(pc2) < l2y THEN
 camode% = 0
 bgcolor% = 15
 blur 5
 panh = d%(pc1)
 panv = 0
 health%(po1) = health%(po1) - (ahpow%(pc1) * 5)
 ko(po1) = ko(po1) - 50
 IF health%(po1) <= 0 THEN decap (po1)
 buttv(po1) = -31
 butth(po1) = d%(pc1)
 position%(po1) = 10
 COLOR , 15: COLOR , 0
 particle (hand2x(pc2)), (necky(pc2)), fighterz(pc1), 23, 10
 FOR wee = 1 TO 80 STEP 5: particle (hand2x(pc2) + ((RND - .5) * 5)), (butty(pc1) - wee), (fighterz(pc1)), 2, 1: NEXT wee
 soundticker% = 0: sbfx 11
 END IF

END IF


IF pticker%(pc1) > 9 AND butty(po1) > butty(pc1) - 25 THEN
camode% = 1
position%(pc1) = 1
elbow2v(pc1) = 2
END IF


'---------------------------------------------------------------------- Block
CASE IS = 99

fighterfreeze (pc1)

elbow1x(pc1) = 4
elbow1y(pc1) = 2
hand1x(pc1) = 0
elbow2x(pc1) = 0
nee1y(pc1) = nee2y(pc1) - 8
foot1x(pc1) = 0
neckx(pc1) = 1


IF pticker%(pc1) > 10 THEN position%(pc1) = 1


'----------------------------------------------------------------------------
END SELECT

IF healths% > 0 AND position%(pc1) < 30 THEN health%(po1) = healths%: ko(po1) = kos

NEXT pc1
END SUB

SUB file

20
SELECT CASE mode%

'----------------------------------------------------------------------- Load
CASE IS = 1
fault$ = "load"
OPEN path$ + "\slash.dat" FOR INPUT AS #1
IF setback% = 1 THEN mode% = 3: GOTO 20
INPUT #1, cmethod%, cfreq%, frameskip%, particles%, nstars%, rez%, delay%, stage%, sbsound%, soundwait%, i16m%, smears%, stagedetail%, fighterdetail%, hudetail%, solidc%, name$(1), flimits%
IF setback% = 1 THEN mode% = 3: GOTO 20
INPUT #1, head%(1), body%(1), arms%(1), hands%(1), legs%(1), feet%(1), hairl%(1), hairc%(1), hairt%(1)
INPUT #1, headc%(1), bodyc%(1), armsc%(1), handsc%(1), legsc%(1), feetc%(1)
CLOSE #1
IF stage% > stages% THEN stage% = 1: setfightercpu

LOCATE 12, 27: PRINT "Loaded"
LOCATE 13, 27: PRINT "     "
LOCATE 14, 27: PRINT "         "

'----------------------------------------------------------------------- Save
38
CASE IS = 2
fault$ = "save1"
OPEN path$ + "\slash.dat" FOR OUTPUT AS #1
IF setback% = 1 THEN setback% = 0: GOTO 38
IF setback% = 2 THEN setback% = 0: GOTO 20
WRITE #1, cmethod%, cfreq%, frameskip%, particles%, nstars%, rez%, delay%, stage%, sbsound%, soundwait%, i16m%, smears%, stagedetail%, fighterdetail%, hudetail%, solidc%, name$(1), flimits%
IF setback% = 2 THEN setback% = 0: GOTO 20
WRITE #1, head%(1), body%(1), arms%(1), hands%(1), legs%(1), feet%(1), hairl%(1), hairc%(1), hairt%(1)
WRITE #1, headc%(1), bodyc%(1), armsc%(1), handsc%(1), legsc%(1), feetc%(1)
CLOSE #1

LOCATE 12, 27: PRINT "      "
LOCATE 13, 27: PRINT "Saved"
LOCATE 14, 27: PRINT "         "
COLOR 7
IF rez% <> 7 THEN LOCATE 15, 27: PRINT "<" + UCASE$(path$) + "\SLASH.DAT>"
LOCATE 16, 27: PRINT "<C:\SFB2.PTH>"


'------------------------------------------------------------- Reset Defaults
CASE IS = 3
cmethod% = 1
cfreq% = -1
frameskip% = 3
particles% = 30
nstars% = 4
rez% = 9
delay% = 0
stage% = 1
soundwait% = 5
sbsound% = 0
i16m% = 0
stagedetail% = 1
fighterdetail% = 1
hudetail% = 1
smears% = 1
flimits% = 1
solidc% = 0

head%(1) = 1
body%(1) = 2
arms%(1) = 2
hands%(1) = 4
legs%(1) = 2
feet%(1) = 1

headc%(1) = 7
bodyc%(1) = 6
armsc%(1) = 1
handsc%(1) = 7
legsc%(1) = 1
feetc%(1) = 4
hairl%(1) = 1
hairc%(1) = 4
hairt%(1) = 1

name$(1) = "Mortal"

LOCATE 12, 27: PRINT "      "
LOCATE 13, 27: PRINT "     "
LOCATE 14, 27: PRINT "Defaulted"

END SELECT

fault$ = ""
mode% = 0
END SUB

SUB floors
'---------------------------------------------------------- Floors / RingOuts
FOR wee = 1 TO 2
wee2 = wee + 2

'Default Settings
floor3 = floor1
canjump%(wee) = 0

SELECT CASE stage%

'----------------------------------------------------------------------------
CASE IS = 1
IF ABS(buttx(wee)) > ring% OR butty(wee) > floor1 THEN floor3 = floor2
IF butty(wee) > 70 THEN ringout (wee)


'----------------------------------------------------------------------------
CASE IS = 2
IF ABS(buttx(wee)) > ring% THEN buttv(wee) = buttv(wee) - gravity - .05: ringout (wee)

'----------------------------------------------------------------------------
CASE IS = 3, 8, 15
IF ABS(buttx(wee)) > ring% THEN
floor3 = floor2
IF foot1y(wee2) >= floor2 - 1 OR foot2y(wee2) >= floor2 - 1 THEN ringout (wee): EXIT SUB
END IF

'----------------------------------------------------------------------------
CASE IS = 4
IF ABS(buttx(wee)) > ring% OR butty(wee) > floor1 + 25 THEN floor3 = floor2 ELSE floor3 = (buttx(wee) * bob) / 200
IF heady(wee2) > 30 THEN ringout (wee)

'----------------------------------------------------------------------------
CASE IS = 9
IF ABS(buttx(wee)) > ring% THEN floor3 = floor2: ringout (wee) ELSE floor3 = (buttx(wee) * trigger1) / 300

'----------------------------------------------------------------------------
CASE IS = 12
IF ABS(buttx(wee)) > ring% OR butty(wee) > floor1 THEN floor3 = floor2: camode% = wee + 1

'----------------------------------------------------------------------------
CASE IS = 14
IF ABS(buttx(wee)) > 100 THEN floor3 = floor2
IF ticker% < 60 AND wee = 1 THEN floor3 = -100

END SELECT

'-------------------------------------------------------------------- CanJump
IF position%(wee) = 1 THEN
 IF foot1y(wee2) >= (floor3 - buttv(wee)) - 2 OR foot2y(wee2) >= (floor3 - buttv(wee)) - 2 THEN canjump%(wee) = 1
END IF


'---------------------------------------------- Gravity, Traction and Landing

buttv(wee) = buttv(wee) + gravity

IF foot1y(wee2) >= (floor3 - buttv(wee)) OR foot2y(wee2) >= (floor3 - buttv(wee)) OR butty(wee) >= (floor3 - buttv(wee)) THEN
 butth(wee) = butth(wee) / 1.1

 'bounce
 IF position%(wee) >= 8 AND position%(wee) <= 11 AND ABS(buttv(wee)) > 3 AND ABS(buttv(wee)) < 25 THEN buttv(wee) = -buttv(wee) / 3: butty(wee) = floor3

 IF buttv(wee) > 0 THEN buttv(wee) = 0
 IF foot1y(wee2) > (floor3) THEN
  butty(wee) = butty(wee) - (foot1y(wee2) - (floor3))
 ELSE
  IF foot2y(wee2) > floor3 THEN butty(wee) = butty(wee) - (foot2y(wee2) - (floor3))
 END IF
 
END IF


'-------------------------------------------------------------- Landing Heads
IF hy(wee) + hv(wee) >= floor3 - 2 THEN
hv(wee) = 0
hy(wee) = floor3 - 2
hh(wee) = hh(wee) / 2
ELSE
hv(wee) = hv(wee) + gravity
END IF


'----------------------------------------------------------------------- Hair
IF wee = 1 THEN
FOR n% = 1 TO 5
IF hairy(n%) > floor3 THEN hairy(n%) = floor3
NEXT n%
ELSE
FOR n% = 6 TO 10
IF hairy(n%) > floor3 THEN hairy(n%) = floor3
NEXT n%
END IF

'-------------------------------------------------------------------


'Slamming on Ground Sound
IF butty(wee) >= floor3 - 5 AND buttv(wee) > .5 THEN sbfx 20

'Skidding on Ground Sound
IF butty(wee) >= floor3 - 1 AND buttv(wee) > -1 AND ABS(butth(wee)) > .3 THEN sbfx 5

'Smoke
IF ABS(butth(wee)) > 4 AND foot1y(wee2) > floor3 - 1 THEN particle foot1x(wee2), foot1y(wee2), fighterz(wee), 16, 1
IF ABS(butth(wee)) > 3 AND foot1y(wee2) > floor3 - 1 THEN particle foot1x(wee2), foot1y(wee2), fighterz(wee), 15, 1


NEXT wee


END SUB

SUB getpath
fault$ = "file"
OPEN "c:\sfb2.pth" FOR INPUT AS #1
IF setback% = 1 THEN window3d:  setpath: GOTO 28
INPUT #1, path$
CLOSE #1
28
fault$ = ""
END SUB

SUB i16 (x, y, x2, y2, F$)
fault$ = "file"
OPEN path$ + "\" + F$ + ".i16" FOR INPUT AS #1

IF setback% = 1 THEN
setback% = 0
LINE (x, y)-(x + 18.5, y + 18), 0, BF
LINE (x, y)-(x + 18, y + 17.5), 4
LINE (x + 18, y)-(x, y + 17.5), 4
GOTO 13
END IF

x1 = x
y1 = y

DO WHILE NOT EOF(1)
INPUT #1, c%
IF c% = 16 THEN
x1 = x
y1 = y1 + y2
ELSE
LINE (x1, y1)-(x1 + x2, y1 + y2), c%, BF
x1 = x1 + x2
END IF
LOOP
13
fault$ = ""
CLOSE #1
END SUB

SUB jump (n%, T%)

IF canjump%(n%) = 1 THEN
SELECT CASE legs%(n%)
CASE 1: buttv(n%) = -7
CASE 2, 2000: buttv(n%) = -10
CASE 3, 666: buttv(n%) = -8
CASE 4: buttv(n%) = -14
CASE 5, 1998: buttv(n%) = -9
END SELECT


IF T% = 1 THEN
SELECT CASE legs%(n%)
CASE 1, 666: butth(n%) = butth(n%) - 1.6
CASE 2: butth(n%) = butth(n%) - 1.4
CASE 3: butth(n%) = butth(n%) - 1.2
CASE 4: butth(n%) = butth(n%) - 1
CASE 5, 2000: butth(n%) = butth(n%) - 2.5
CASE 1998: butth(n%) = butth(n%) - 3
END SELECT
END IF

IF T% = 3 THEN
SELECT CASE legs%(n%)
CASE 1, 666: butth(n%) = butth(n%) + 1.6
CASE 2: butth(n%) = butth(n%) + 1.4
CASE 3: butth(n%) = butth(n%) + 1.2
CASE 4: butth(n%) = butth(n%) + 1
CASE 5, 2000: butth(n%) = butth(n%) + 2.5
CASE 1998: butth(n%) = butth(n%) + 3
END SELECT
END IF

END IF
END SUB

SUB keycheck

fault$ = "nokey"
OPEN path$ + "\sfb2.key" FOR INPUT AS #1
INPUT #1, wee$
CLOSE #1

END SUB

SUB loadsave
39 rezs% = rez%
setback% = 0
smallwindow

COLOR 15
LOCATE 10, 2: PRINT "File Options"
LOCATE 12, 2: PRINT "1 Load"
LOCATE 13, 2: PRINT "2 Save"
LOCATE 14, 2: PRINT "3 Defaults"
LOCATE 15, 2: PRINT "4 Delete Settings File"
LOCATE 16, 2: PRINT "5 Reset Path File"

COLOR 7
IF rez% <> 7 THEN LOCATE 15, 27: PRINT "<" + UCASE$(path$) + "\SLASH.DAT>"
LOCATE 16, 27: PRINT "<C:\SFB2.PTH>"


22 wee$ = INKEY$
IF setback% = 1 THEN 39
IF wee$ = "" THEN 22

IF wee$ = "1" THEN
mode% = 1:  file
newmatch
END IF

IF wee$ = "2" THEN
mode% = 2:  file
END IF

IF wee$ = "3" THEN
mode% = 3:  file
newmatch
END IF

IF wee$ = "4" THEN
LOCATE 15, 27
IF rez% = 7 THEN PRINT "Deleted      ": LOCATE 15, 26 ELSE PRINT "Deleted                                              ": LOCATE 15, 27
SHELL "DEL " + path$ + "\SLASH.DAT"
LOCATE 12, 27: PRINT "      "
LOCATE 13, 27: PRINT "     "
LOCATE 14, 27: PRINT "         "
END IF

IF wee$ = "5" THEN
setpath
restart% = 1
GOTO 23
END IF

IF rez% <> rezs% THEN SCREEN rez%: window3d: GOTO 39
IF wee$ <> CHR$(27) THEN 22

23
csmallwindow
IF wee$ = "3" THEN SCREEN rez%
wee$ = ""
END SUB

SUB movecam

'-------------------------------------------------------------Camera Movement
zoom = zoom + zoomd
panx = panx + panh
pany = pany + panv
zoomd = zoomd / 1.1
panh = panh / 1.01
panv = panv / 1.01
END SUB

SUB mud

SCREEN 9
COLOR , 0

fault$ = "mud"
IF setback% = 1 THEN setback% = 0: GOTO 21
'------------------------------------------------------------------- Show Mud
CLS

camdefaults
zoom = .5
panx = -500

s$ = "  SFB2: Vector Warriors, Powered by Slash - Created by Kevin Reems 1997-1998"

window3d


FOR miniloop = 0 TO 75
IF INKEY$ <> "" THEN 21

panh = 25

 movecam
'page flipping
pflip

flicker = TIMER: DO UNTIL TIMER - flicker > .000001: LOOP

'Clear Screen
CLS

'-------------------------------------------------------------------
IF miniloop = 1 THEN c% = 15
IF miniloop = 3 THEN c% = 9
IF miniloop = 5 THEN c% = 1
IF miniloop = 74 THEN c% = 0

FOR wee = n TO n + 20
psline -1500, -150, (wee + .5), 1500, -150, (wee + .5), c%, 3
psline -1500, 150, (wee + .5), 1500, 150, (wee + .5), c%, 3
psline -500, -150, (wee), 500, -150, (wee), c%, 0
psline -500, 150, (wee), 500, 150, (wee), c%, 0
NEXT wee

IF n > 0 THEN n = n - .2 ELSE n = 1

IF miniloop > 60 THEN
window2d
LINE (0, (miniloop * 10) - 750)-(100, (miniloop * 10) - 650), 0, BF
window3d
END IF

'-------------------------------------------------------------------

psdpset -200, -100, 0, 10, 8
psdpset -100, -75, 0, 5, 8
psdpset 0, 10, 0, 7, 8
psdpset 100, -25, 0, 3, 8
psdpset 400, 75, 0, 6, 8
psdpset 500, -100, 0, 5, 8
psdpset 200, 25, 0, 6, 8
psdpset 300, -75, 0, 5, 8
psdpset 600, 100, 0, 5, 8

'---------S
psdline 150, -50, 1, 100, 0, 4, 15, 7, 8, 0
psdline 100, 0, 1, 150, 0, 4, 15, 7, 8, 0
psdline 150, 0, 1, 100, 50, 4, 15, 7, 8, 0

'---------L
psdline 160, 50, 1, 200, 50, 4, 15, 7, 8, 0
psdline 160, 50, 1, 180, -50, 4, 15, 7, 8, 0

'---------A
psdline 210, 50, 1, 250, -50, 4, 15, 7, 8, 0
psdline 250, -50, 1, 250, 50, 4, 15, 7, 8, 0
psdline 240, 0, 1, 250, 0, 4, 15, 7, 8, 0

'---------S
psdline 310, -50, 1, 260, 0, 4, 15, 7, 8, 0
psdline 260, 0, 1, 310, 0, 4, 15, 7, 8, 0
psdline 310, 0, 1, 260, 50, 4, 15, 7, 8, 0

'---------H
psdline 320, 50, 1, 340, -50, 4, 15, 7, 8, 0
psdline 330, 0, 1, 370, 0, 4, 15, 7, 8, 0
psdline 360, 50, 1, 380, -50, 4, 15, 7, 8, 0

'-------------------------------------------------------------------

IF miniloop < 5 THEN LOCATE 23, 1: COLOR 8: PRINT s$
IF miniloop > 4 AND miniloop < 10 THEN LOCATE 23, 1: COLOR 7: PRINT s$
IF miniloop > 9 THEN LOCATE 23, 1: COLOR 15: PRINT s$
NEXT miniloop

IF i16m% = 2 THEN 21
window2d
SCREEN , , 0, 0
i16 0, 0, .88, .85, "slash"
SCREEN , , 1, 0
i16 0, 0, .54, .73, "sfb2"
SCREEN , , 0, 1
CLS
SLEEP 3

21
fault$ = ""
END SUB

SUB newmatch
'Start a New Match
   
   '-----------------------
   IF stage% > stages% THEN
   stage% = 1
   keycheck

   IF wee$ <> "´œ‘·ðE=666ÛÈåÃGenerated Key File: Do Not Edit" THEN
    fault$ = "writekey"
    wee$ = "´œ‘·ðE=666ÛÈåÃGenerated Key File: Do Not Edit"
    OPEN path$ + "\sfb2.key" FOR OUTPUT AS #1
    WRITE #1, wee$
    CLOSE #1
   
'----------------------------------------------------------------------------
smallwindow
COLOR 15
LOCATE 10, 2: PRINT "STAGE SELECT ENABLED"
COLOR 12

IF rez% > 7 THEN
LOCATE 12, 2: PRINT "Congratulations, You've Earned The Stage Select Option."
ELSE
LOCATE 12, 2: PRINT "Congratulations!"
LOCATE 13, 2: PRINT "You've Earned The Stage Select Option."
END IF


'----------------------------------------------------------------------------
   END IF
   END IF

 stageinit
END SUB

SUB nokey
smallwindow
COLOR 15
LOCATE 10, 2: PRINT "DISABLED"
COLOR 12

IF rez% > 7 THEN
LOCATE 12, 2: PRINT "You Must Complete Every Stage To Enable This Option."
LOCATE 13, 2: PRINT "Don't Forget To Save Your Progress."

ELSE

LOCATE 12, 2: PRINT "You Must Complete Every Stage"
LOCATE 13, 2: PRINT "To Enable This Option."
LOCATE 14, 2: PRINT "Don't Forget To Save Your Progress."

END IF


COLOR 4
LOCATE 16, 2: PRINT "Press Esc"

40 IF INKEY$ <> CHR$(27) THEN 40
csmallwindow
END SUB

SUB ocasional

IF flimits% = 1 THEN fighterlimits

FOR wee = 1 TO 2

'recharge KO & Rage
IF Special%(wee) = 0 AND ko(wee) > 0 AND ko(wee) < 100 AND health%(wee) > 0 THEN ko(wee) = ko(wee) + kocharge(wee)
IF rage(wee) < 100 AND health%(wee) > 0 THEN rage(wee) = rage(wee) + ragecharge(wee)

IF vexed%(wee) > 0 THEN health%(wee) = health%(wee) - 1

'---------------------------+

'Headless Stuff
IF headless%(wee) = 1 THEN
health%(wee) = health%(wee) - 20
particle (hx(wee)), (hy(wee)), fighterz(wee), 0, 1
END IF

'---------------------------+

'Damage Bar Stuff
IF health%(wee) > maxhp%(wee) THEN health%(wee) = maxhp%(wee)

IF health%(wee) < hpslide%(wee) THEN
hpslide%(wee) = hpslide%(wee) - 4
ELSE
hpslide%(wee) = health%(wee)
END IF

IF ko(wee) < koslide%(wee) THEN
koslide%(wee) = koslide%(wee) - 2
ELSE
koslide%(wee) = ko(wee)
END IF


IF health%(wee) >= maxhp%(wee) THEN hc%(wee) = 10 ELSE hc%(wee) = 14
IF vexed%(wee) > 0 THEN hc%(wee) = 9
IF ko(wee) >= 100 THEN kc%(wee) = 10 ELSE kc%(wee) = 14

'---------------------------+

IF rage(wee) < 0 THEN rage(wee) = 0
IF rage(wee) = 100 THEN vexed%(wee) = 0

IF fighterz(wee) > midstage THEN fighterz(wee) = fighterz(wee) - .1
IF fighterz(wee) < midstage THEN fighterz(wee) = fighterz(wee) + .1
IF fighterz(wee) > midstage + .5 THEN fighterz(wee) = fighterz(wee) - .5
IF fighterz(wee) < midstage - .5 THEN fighterz(wee) = fighterz(wee) + .5

NEXT wee

'----------------------------------------------------------------------------
END SUB

SUB options

IF AIactive%(1) = 1 THEN AIactive%(1) = 0: stage% = 1: stageinit

1 redraw% = 0
fault$ = ""
bigwindow
COLOR 15, 0
IF rez% = 7 THEN
LOCATE 4, 17: PRINT "OPTIONS"
ELSE
LOCATE 4, 37: PRINT "OPTIONS"
END IF

LOCATE 6, 6:  PRINT "Select Stage"
LOCATE 8, 6: PRINT "Build Fighter"
LOCATE 10, 6:  PRINT "Visit Dojo"
LOCATE 12, 6:  PRINT "Settings"
LOCATE 14, 6: PRINT "Load/Save Options"
LOCATE 16, 6: PRINT "Demo Mode"
LOCATE 18, 6: PRINT "Restart"
LOCATE 20, 6: PRINT "Quit"

IF ptoptions% = 0 THEN ptoptions% = 6

DO
wee$ = UCASE$(INKEY$)
'----------------------------------------------------------------- Move Arrow
SELECT CASE wee$
CASE IS = "8", CHR$(0) + "H"
LOCATE ptoptions%, 2: PRINT " "
IF ptoptions% > 6 THEN ptoptions% = ptoptions% - 2 ELSE ptoptions% = 20

CASE IS = "5", "2", CHR$(0) + "P"
LOCATE ptoptions%, 2: PRINT " "
IF ptoptions% < 20 THEN ptoptions% = ptoptions% + 2 ELSE ptoptions% = 6
END SELECT
LOCATE ptoptions%, 2: PRINT CHR$(16)

'--------------------------------------------------------------------- Select
IF wee$ = " " OR wee$ = CHR$(13) THEN
redraw% = 1
wee$ = ""

SELECT CASE ptoptions%

CASE IS = 6
wee$ = ""
keycheck
IF wee$ = "´œ‘·ðE=666ÛÈåÃGenerated Key File: Do Not Edit" THEN setstage ELSE nokey
wee$ = ""

CASE IS = 8
setfighter

CASE IS = 10
smallwindow
LOCATE 10, 31: PRINT "Master Bean's Dojo"
LOCATE 12, 2: PRINT "Leave Current Stage to Visit Dojo ?"
window2d
i16 76, 41, .363, .355, "dojo"
LINE (75, 40)-(95, 60), 7, B
window3d
LOCATE 13, 2: PRINT "<Y/N>"
DO: wee$ = INKEY$: LOOP UNTIL wee$ <> ""
IF UCASE$(wee$) = "Y" THEN
stage% = 1000
stageinit
setfightercpu
END IF

CASE IS = 12
settings

CASE IS = 14
loadsave

CASE IS = 16
AIactive%(1) = 1
AIactive%(2) = 1
dif% = 7
stage% = (RND * 3) + 1
newmatch
EXIT SUB

CASE IS = 18
restart% = 1

CASE IS = 20
quit

END SELECT
END IF

IF restart% = 1 THEN wee$ = CHR$(27)
IF redraw% = 1 THEN 1
LOOP UNTIL wee$ = CHR$(27)
cbigwindow
END SUB

SUB page2
SCREEN , 0, 0
LOCATE 1, 1: COLOR 4: PRINT "Loading..."
SCREEN , 2, 0
window2d

SELECT CASE stage%

CASE IS = 1
wee = 1
DO WHILE wee < 50
LINE (0, 100 - wee)-(100, 100 - wee), 4
wee = wee * 2
LOOP

CASE IS = 2
stars2d 8, 15, 15

CASE IS = 3
i16 0, 0, .88, .85, "slash"

CASE IS = 4
i16 0, 0, .88, .85, "slash"


END SELECT
 window3d
END SUB

SUB pagetest
32 fault$ = "pagetest"
wee$ = UCASE$(INKEY$)
IF wee$ = "0" THEN SCREEN , 0, 0
IF wee$ = "1" THEN SCREEN , 1, 1
IF wee$ = "2" THEN SCREEN , 2, 2
IF wee$ = "3" THEN SCREEN , 3, 3
IF wee$ = "4" THEN SCREEN , 4, 4
IF wee$ = "5" THEN SCREEN , 5, 5
IF wee$ <> "Q" THEN 32
wee$ = "": fault$ = ""

END SUB

SUB particle (x, y, Z, T%, Q%)
fault$ = "particles"

FOR wee = 1 TO particles%

IF p%(wee) = 0 AND Q% > 0 THEN
Q% = Q% - 1
px(wee) = x
py(wee) = y
pz(wee) = Z

SELECT CASE T%

CASE IS = 0: 'Blood Down
p%(wee) = 20
ph(wee) = (RND - .5)
pv(wee) = RND
pg%(wee) = 1
pc1%(wee) = 12
pc2%(wee) = 12
pc3%(wee) = 4
pf%(wee) = 0
pk%(wee) = 1

CASE IS = 1: 'Normal Blood
p%(wee) = 30
ph(wee) = (RND - .5) * 3
pv(wee) = -RND * 5
pg%(wee) = 2
pc1%(wee) = 12
pc2%(wee) = 4
pc3%(wee) = 4
pf%(wee) = 1
pk%(wee) = 1

CASE IS = 2: 'Blood Spurting Up
p%(wee) = 60
ph(wee) = (RND - .5)
pv(wee) = -8 + (RND * 2)
pg%(wee) = 2
pc1%(wee) = 12
pc2%(wee) = 4
pc3%(wee) = 4
pf%(wee) = 1
pk%(wee) = 1

CASE IS = 3: 'Blood Left
p%(wee) = 30
ph(wee) = -RND * 3
pv(wee) = -RND * 3
pg%(wee) = 2
pc1%(wee) = 12
pc2%(wee) = 4
pc3%(wee) = 4
pf%(wee) = 1
pk%(wee) = 1

CASE IS = 4: 'Blood Right
p%(wee) = 30
ph(wee) = RND * 3
pv(wee) = -RND * 3
pg%(wee) = 2
pc1%(wee) = 12
pc2%(wee) = 4
pc3%(wee) = 4
pf%(wee) = 1
pk%(wee) = 1
pk%(wee) = 1

CASE IS = 5: 'Large Omni Spark (Blue)
p%(wee) = 30
ph(wee) = (RND - .5) * 15
pv(wee) = (RND - .5) * 15
pg%(wee) = 1
pc1%(wee) = 15
pc2%(wee) = 9
pc3%(wee) = 1
pf%(wee) = 0
pk%(wee) = 1

CASE IS = 6: 'Small Omni Spark (Blue)
p%(wee) = 4
ph(wee) = (RND - .5) * 30
pv(wee) = (RND - .5) * 30
pg%(wee) = 1
pc1%(wee) = 15
pc2%(wee) = 15
pc3%(wee) = 15
pf%(wee) = 0
pk%(wee) = 0

CASE IS = 8: 'Blue Spark Shower
p%(wee) = 30
ph(wee) = (RND - .5) * 4
pv(wee) = (-RND) * 3
pg%(wee) = 1
pc1%(wee) = 15
pc2%(wee) = 9
pc3%(wee) = 1
pf%(wee) = 1
pk%(wee) = 1

CASE IS = 9: 'Red Spark Shower
p%(wee) = 40
ph(wee) = (RND - .5)
pv(wee) = RND
pg%(wee) = 1
pc1%(wee) = 15
pc2%(wee) = 12
pc3%(wee) = 4
pf%(wee) = 0
pk%(wee) = 1

CASE IS = 11: 'Normal Water
p%(wee) = 30
ph(wee) = (RND - .5) * 3
pv(wee) = -RND * 5
pg%(wee) = 2
pc1%(wee) = 15
pc2%(wee) = 9
pc3%(wee) = 1
pf%(wee) = 1
pk%(wee) = 2

CASE IS = 12: 'Water Spurting Up
p%(wee) = 40
ph(wee) = (RND - .5)
pv(wee) = -7 / (1 + RND)
pg%(wee) = 2
pc1%(wee) = 15
pc2%(wee) = 9
pc3%(wee) = 1
pf%(wee) = 1
pk%(wee) = 2

CASE IS = 13: 'Water Left
p%(wee) = 30
ph(wee) = -RND * 3
pv(wee) = -RND * 3
pg%(wee) = 2
pc1%(wee) = 15
pc2%(wee) = 9
pc3%(wee) = 1
pf%(wee) = 1
pk%(wee) = 2

CASE IS = 14: 'Water Right
p%(wee) = 30
ph(wee) = RND * 3
pv(wee) = -RND * 3
pg%(wee) = 2
pc1%(wee) = 15
pc2%(wee) = 9
pc3%(wee) = 1
pf%(wee) = 1
pk%(wee) = 2

CASE IS = 15: 'Smoke
p%(wee) = 60
ph(wee) = (RND - .5) * 2
pv(wee) = -RND * 1.5
pg%(wee) = 2
pc1%(wee) = 7
pc2%(wee) = 8
pc3%(wee) = 8
pf%(wee) = 3
pk%(wee) = 0

CASE IS = 16: 'Fire
p%(wee) = 30
ph(wee) = (RND - .5) * 2
pv(wee) = -RND
pg%(wee) = 1
pc1%(wee) = 14
pc2%(wee) = 12
pc3%(wee) = 4
pf%(wee) = 3
pk%(wee) = 0

CASE IS = 17: 'Flame
p%(wee) = 40
ph(wee) = (RND - .5) * 2
pv(wee) = -RND * 4
pg%(wee) = 1
pc1%(wee) = 15
pc2%(wee) = 14
pc3%(wee) = 12
pf%(wee) = 3
pk%(wee) = 0

CASE IS = 18: 'Bloody Mess!
p%(wee) = 30
ph(wee) = (RND - .5) * 8
pv(wee) = -RND * 8
pg%(wee) = 2
pc1%(wee) = 12
pc2%(wee) = 12
pc3%(wee) = 4
pf%(wee) = 1
pk%(wee) = 2

CASE IS = 19: 'Grayscale Dot
p%(wee) = 18
ph(wee) = 0
pv(wee) = 0
pg%(wee) = 1
pc1%(wee) = 15
pc2%(wee) = 7
pc3%(wee) = 8
pf%(wee) = 0
pk%(wee) = 2


CASE IS = 20: 'Horizontal Snap Spark White
p%(wee) = 15
ph(wee) = (RND - .5) * 50
pv(wee) = (RND - .5) * 5
pg%(wee) = 1
pc1%(wee) = 15
pc2%(wee) = 15
pc3%(wee) = 7
pf%(wee) = 0
pk%(wee) = 0


CASE IS = 21: 'Horizontal Snap Spark Red
p%(wee) = 15
ph(wee) = (RND - .5) * 50
pv(wee) = (RND - .5) * 5
pg%(wee) = 1
pc1%(wee) = 15
pc2%(wee) = 12
pc3%(wee) = 4
pf%(wee) = 0
pk%(wee) = 0


CASE IS = 22: 'Vertical Snap Spark White
p%(wee) = 15
ph(wee) = (RND - .5) * 5
pv(wee) = (RND - .5) * 50
pg%(wee) = 1
pc1%(wee) = 15
pc2%(wee) = 15
pc3%(wee) = 7
pf%(wee) = 0
pk%(wee) = 0


CASE IS = 23: 'Vertical Snap Spark Red
p%(wee) = 15
ph(wee) = (RND - .5) * 5
pv(wee) = (RND - .5) * 50
pg%(wee) = 1
pc1%(wee) = 15
pc2%(wee) = 12
pc3%(wee) = 4
pf%(wee) = 0
pk%(wee) = 0


CASE IS = 24: 'Volcanic Chunks (Brown)
p%(wee) = 60
ph(wee) = (RND - .5) * 2
pv(wee) = RND * -10
pg%(wee) = 3
pc1%(wee) = 6
pc2%(wee) = 6
pc3%(wee) = 6
pf%(wee) = 1
pk%(wee) = 1


CASE IS = 25: 'Large Omni Spark (Green)
p%(wee) = 18
ph(wee) = (RND - .5) * 50
pv(wee) = (RND - .5) * 50
pg%(wee) = 1
pc1%(wee) = 15
pc2%(wee) = 10
pc3%(wee) = 2
pf%(wee) = 0
pk%(wee) = 1


CASE IS = 26: 'Volcanic Chunks (Blue)
p%(wee) = 30
ph(wee) = (RND - .5) * 2
pv(wee) = RND * -10
pg%(wee) = 3
pc1%(wee) = 9
pc2%(wee) = 1
pc3%(wee) = 1
pf%(wee) = 1
pk%(wee) = 1

CASE IS = 27: 'Candle-Like Flame
p%(wee) = 15
ph(wee) = (RND - .5) / 3
pv(wee) = -RND
pg%(wee) = 1
pc1%(wee) = 14
pc2%(wee) = 12
pc3%(wee) = 4
pf%(wee) = 3
pk%(wee) = 0


END SELECT
END IF

'----------------------------------------------------------------------------
NEXT wee
END SUB

SUB particleclear
FOR wee = 1 TO particles%
p%(wee) = 0
py(wee) = -5000
NEXT wee

FOR wee = 1 TO 10
smearl%(wee) = 0
NEXT wee

END SUB

SUB particlemove

FOR wee = 1 TO particles%
px(wee) = px(wee) + ph(wee)
py(wee) = py(wee) + pv(wee)
SELECT CASE pf%(wee)
CASE IS = 1: pv(wee) = pv(wee) + gravity
CASE IS = 2: pv(wee) = pv(wee) - gravity
CASE IS = 3: ph(wee) = ph(wee) / 1.3
END SELECT
NEXT wee
END SUB

SUB particlerender

fault$ = "particles"

18
FOR wee = 1 TO particles%

IF setback% = 1 THEN setback% = 0: particles% = 0: GOTO 18
'----------------------------------------------------------------------------
IF p%(wee) > 0 THEN

IF pg%(wee) < 3 THEN psline (px(wee)), (py(wee)), (pz(wee)), (px(wee) - ph(wee)), (py(wee) - pv(wee)), (pz(wee) - pd(wee)), (pc1%(wee)), 0
IF pg%(wee) > 1 THEN pscircle (px(wee)), (py(wee)), (pz(wee)), (.3), (pc1%(wee))

END IF

'----------------------------------------------------------------------------
NEXT wee
fault$ = ""
END SUB

SUB pause

SCREEN , , 0, 0

COLOR 4
LOCATE 22, 38
PRINT "Pause"

COLOR 15
LOCATE 21, 1: PRINT name$(1) + " VS. " + name$(2)
LOCATE 22, 1: PRINT stagename$

DO WHILE INKEY$ = ""
LOOP

END SUB

SUB pflip
fault$ = "pflip"
IF rez% <> 1 AND rez% <> 12 THEN
SWAP pflip1%, pflip2%
SCREEN , , pflip1%, pflip2%
END IF
fault$ = ""

END SUB

SUB projectilerender
FOR n% = 1 TO 6
IF projectile%(n%) > 0 THEN
 IF projectile%(n%) < 4 THEN Z = fighterz(1) ELSE Z = fighterz(2)

'----------------
SELECT CASE projectilet%(n%)


'------------------------------------------------------------- Ball Lightning
CASE 1
pscircle (projectilex(n%)), (projectiley(n%)), (Z), (RND * 4), (flash1%)
pscircle (projectilex(n%)), (projectiley(n%)), (Z), (4), (flash2%)
pslightning (projectilex(n%)), (projectiley(n%)), (Z), (projectilex(n%) - projectileh(n%)), (projectiley(n%) + ((RND - .5) * 25)), (Z), (20), (flash2%)
particle (projectilex(n%)), (projectiley(n%)), (Z), 5, 1


'------------------------------------------------------------ Large Fire Ball
CASE 2
s = projectile%(n%)
IF s > 6 THEN s = 6
pscircle (projectilex(n%)), (projectiley(n%)), (Z), (s), (flash3%)

FOR wee = 1 TO 3
y = projectiley(n%) + ((RND - .5) * 10)
psline (projectilex(n%)), (y), (Z), (projectilex(n%) - (projectileh(n%) + ((RND - .5) * s * 5))), (y), (Z), flash3%, 0
particle (projectilex(n%) - ((RND * projectileh(n%)) * 5)), (projectiley(n%) + ((RND - .5) * 10)), (Z), 16, 1
NEXT wee

'------------------------------------------------------------ Small Fire Ball
CASE 3
s = projectile%(n%)
IF s > 3 THEN s = 3
pscircle (projectilex(n%)), (projectiley(n%)), (Z), (s), (flash3%)
FOR wee = 1 TO 3
y = projectiley(n%) + ((RND - .5) * 5)
psline (projectilex(n%)), (y), (Z), (projectilex(n%) - (projectileh(n%) + ((RND - .5) * s))), (y), (Z), 4, 0
particle (projectilex(n%) - ((RND * projectileh(n%)) * 5)), (projectiley(n%) + ((RND - .5) * 5)), (Z), 16, 1
NEXT wee


'------------------------------------------------------------------- Nin-Star
CASE 4
particle (projectilex(n%)), (projectiley(n%)), (Z), 19, 1
psline (projectilex(n%) - RND), (projectiley(n%) - RND), (Z), (projectilex(n%) + RND), (projectiley(n%) + RND), (Z), 15, 0
psline (projectilex(n%) + RND), (projectiley(n%) - RND), (Z), (projectilex(n%) - RND), (projectiley(n%) + RND), (Z), 15, 0


'--------------------------------------------------------------- Energy Blast
CASE 5
pscline (projectilex(n%) - projectileh(n%)), (projectiley(n%)), (Z), (projectilex(n%) - (projectileh(n%) * 3)), (projectiley(n%)), (Z), (4), (flash1%)
pscircle (projectilex(n%) - projectileh(n%)), (projectiley(n%)), (Z), (15), (flash1%)
pscircle (projectilex(n%)), (projectiley(n%)), (Z), (RND * 5), (flash1%)
pscircle (projectilex(n%)), (projectiley(n%)), (Z), (5), (flash2%)
pslightning (projectilex(n%)), (projectiley(n%)), (Z), (projectilex(n%) - (projectileh(n%) * 5)), (projectiley(n%) + ((RND - .5) * 25)), (Z), (20), (flash2%)
FOR wee = 1 TO 3: particle (projectilex(n%) + ((RND - .5) * 20)), (projectiley(n%) + ((RND - .5) * 15)), (Z), 19, 1: NEXT wee



END SELECT
END IF
NEXT n%

END SUB

SUB projectiles

'Ball-1/4 Collision Detection
IF projectile%(1) > 0 AND projectile%(4) > 0 AND projectilex(1) > projectilex(1) - 5 AND projectilex(1) < projectilex(1) + 5 AND projectiley(1) > projectiley(1) - 5 AND projectiley(1) < projectiley(1) + 5 THEN
IF projectilet%(1) = 1 OR projectilet%(4) = 1 THEN particle ((projectilex(1) + projectilex(2)) / 2), (projectiley(1)), (fighterz(1)), 5, 15
IF projectilet%(1) = 2 OR projectilet%(4) = 2 THEN particle ((projectilex(1) + projectilex(2)) / 2), (projectiley(1)), (fighterz(1)), 17, 15
projectile%(1) = 0
projectile%(4) = 0
END IF

FOR n% = 1 TO 6
IF projectile%(n%) > 0 THEN
 projectile%(n%) = projectile%(n%) - 1
 projectilex(n%) = projectilex(n%) + projectileh(n%)
 projectiley(n%) = projectiley(n%) + projectilev(n%)

IF n% < 4 THEN pc1% = 1: po1% = 2 ELSE pc1% = 2: po1% = 1
pc2% = pc1% + 2
po2% = po1% + 2
IF foot1y(po2%) > foot2y(po2%) THEN footy = foot1y(po2%) ELSE footy = foot2y(po2%)


'---------------- Detect Hit
IF projectilex(n%) > buttx(po1%) - 5 AND projectilex(n%) < buttx(po1%) + 5 AND projectiley(n%) > heady(po2%) AND projectiley(n%) < footy THEN

SELECT CASE projectilet%(n%)
'------------------------------------------------------------- Ball Lightning
CASE 1
butth(po1%) = butth(po1%) + (projectileh(n%) / 5)
pscircle (projectilex(n%)), (projectiley(n%)), (fighterz(po1%)), (10), (1)
IF position%(po1%) = 99 THEN
particle (projectilex(n%)), (projectiley(n%)), (fighterz(po1%)), 6, 25
ELSE
soundticker% = 0: sbfx 19
particle (projectilex(n%)), (projectiley(n%)), (fighterz(po1%)), 15, 10
particle (projectilex(n%)), (projectiley(n%)), (fighterz(po1%)), 5, 25
health%(po1%) = health%(po1%) - (ahpow%(pc1%) * 5)
ko(po1%) = ko(po1%) - (akpow%(pc1%) * 5)
IF ko(po1%) < 25 OR projectiley(n%) > butty(po1%) THEN fall (po1%)
END IF

'-------------------------------------------------------------------- L. Fire
CASE 2
butth(po1%) = butth(po1%) + (projectileh(n%) / 10)
pscircle (projectilex(n%)), (projectiley(n%)), (fighterz(po1%)), (10), (4)
IF position%(po1%) = 99 THEN
particle (projectilex(n%)), (projectiley(n%)), (fighterz(po1%)), 9, 25
ELSE
soundticker% = 0: sbfx 25
particle (projectilex(n%)), (projectiley(n%)), (fighterz(po1%)), 17, 20
particle (projectilex(n%)), (projectiley(n%)), (fighterz(po1%)), 15, 10
health%(po1%) = health%(po1%) - (ahpow%(pc1%) * 2)
ko(po1%) = ko(po1%) - (akpow%(pc1%) * 2)
IF ko(po1%) < 15 THEN fall (po1%)
END IF

'-------------------------------------------------------------------- S. Fire
CASE 3
butth(po1%) = butth(po1%) + (projectileh(n%) / 10)
pscircle (projectilex(n%)), (projectiley(n%)), (fighterz(po1%)), (8), (4)
IF position%(po1%) = 99 THEN
particle (projectilex(n%)), (projectiley(n%)), (fighterz(po1%)), 9, 15
ELSE
soundticker% = 0: sbfx 25
particle (projectilex(n%)), (projectiley(n%)), (fighterz(po1%)), 17, 10
particle (projectilex(n%)), (projectiley(n%)), (fighterz(po1%)), 15, 5
ko(po1%) = ko(po1%) - akpow%(pc1%)
butth(po1%) = butth(po1%) + (projectileh(n%) / 10)
END IF

'------------------------------------------------------------------- Nin-Star
CASE 4
IF position%(po1%) = 99 THEN
particle (projectilex(n%)), (projectiley(n%)), (fighterz(po1%)), 6, 15
ELSE
particle (projectilex(n%)), (projectiley(n%)), (fighterz(po1%)), 0, 10
health%(po1%) = health%(po1%) - ahpow%(pc1%)
ko(po1%) = ko(po1%) - akpow%(pc1%)
END IF


'------------------------------------------------------------------- E. Blast
CASE 5
pscircle (projectilex(n%)), (projectiley(n%)), (fighterz(po1%)), (20), (15)
particle (projectilex(n%)), (projectiley(n%)), (fighterz(po1%)), 5, 25
health%(po1%) = health%(po1%) - 10
ko(po1%) = ko(po1%) - 10
butth(po1%) = butth(po1%) + (projectileh(n%) / 2)

IF position%(po1%) = 99 THEN
bgcolor% = 1
ELSE
soundticker% = 0: sbfx 21
particle (projectilex(n%)), (projectiley(n%)), (fighterz(po1%)), 20, 10
particle (projectilex(n%)), (projectiley(n%)), (fighterz(po1%)), 22, 10
bgcolor% = 9
health%(po1%) = health%(po1%) / 2
ko(po1%) = ko(po1%) / 2
fall (po1%)
END IF


'---------------------------------------------------------------------------+
END SELECT
projectile%(n%) = 0
END IF
END IF
NEXT n%
END SUB

SUB pscircle (x, y, Z, r1, c%)

'-------------------------------------------------------------------PS-Circle
Z = Z + 1
IF Z = 0 THEN Z = .000001

x = (midx% + ((x - panx) / (Z * zoom)))
y = (midy% + ((y - pany) / (Z * zoom)))

r2 = r1 / (Z * zoom)

fault$ = "ps"
CIRCLE (x, y), r2, c%
fault$ = ""
END SUB

SUB pscline (x1, y1, z1, x5, y5, z5, r, c%)

x3 = ((x1 + x5) / 2)
x2 = ((x1 + x3) / 2)
x4 = ((x3 + x5) / 2)

y3 = ((y1 + y5) / 2)
y2 = ((y1 + y3) / 2)
y4 = ((y3 + y5) / 2)

z3 = ((z1 + z5) / 2)
z2 = ((z1 + z3) / 2)
z4 = ((z3 + z5) / 2)

pscircle (x1), (y1), (z1), (r), (c%)
pscircle (x2), (y2), (z2), (r), (c%)
pscircle (x3), (y3), (z3), (r), (c%)
pscircle (x4), (y4), (z4), (r), (c%)
pscircle (x5), (y5), (z5), (r), (c%)
END SUB

SUB pscube (x1, y1, z1, x2, y2, z2, c1%, c2%, c3%)


'---------------------------------------------------------------------PS-Cube

'---------far face
psline (x1), (y1), (z2), (x2), (y2), (z2), (c3%), 1

'---------connect faces
'top/left
psdpset (x1), (y1), (z1), (z2), (c2%)

'top/right
psdpset (x2), (y1), (z1), (z2), (c2%)

'bottom/left
psdpset (x1), (y2), (z1), (z2), (c2%)

'bottom/right
psdpset (x2), (y2), (z1), (z2), (c2%)

'---------near face
psline (x1), (y1), (z1), (x2), (y2), (z1), (c1%), 1

END SUB

SUB psdline (x1, y1, z1, x2, y2, z2, c1%, c2%, c3%, B%)


'----------------------------------------------------------------PS Deep-Line
'---------far line
psline (x1), (y1), (z2), (x2), (y2), (z2), (c3%), 0

'---------connect lines
IF B% = 1 THEN psdpset (x1), (y1), (z1), (z2), (c2%): psdpset (x2), (y2), (z1), (z2), (c2%)

'---------near line
psline (x1), (y1), (z1), (x2), (y2), (z1), (c1%), 0

END SUB

SUB psdpset (x, y, z1, z2, c%)


'---------------------------------------------------------------PS-Deep Point
z1 = z1 + 1
7 z2 = z2 + 1
IF z1 = 0 THEN z1 = .000001
IF z2 = 0 THEN z2 = .000001

x3 = (midx% + ((x - panx) / (z1 * zoom)))
y3 = (midy% + ((y - pany) / (z1 * zoom)))

x4 = (midx% + ((x - panx) / (z2 * zoom)))
y4 = (midy% + ((y - pany) / (z2 * zoom)))

fault$ = "ps"
LINE (x3, y3)-(x4, y4), c%
fault$ = ""
END SUB

SUB pslightning (x1, y1, z1, x5, y5, z5, r, c%)

x3 = ((x1 + x5) / 2) + ((RND - .5) * r)
x2 = ((x1 + x3) / 2) + ((RND - .5) * r)
x4 = ((x3 + x5) / 2) + ((RND - .5) * r)

y3 = ((y1 + y5) / 2) + ((RND - .5) * r)
y2 = ((y1 + y3) / 2) + ((RND - .5) * r)
y4 = ((y3 + y5) / 2) + ((RND - .5) * r)

z3 = ((z1 + z5) / 2)
z2 = ((z1 + z3) / 2)
z4 = ((z3 + z5) / 2)

psline (x1), (y1), (z1), (x2), (y2), (z2), (c%), 0
psline (x2), (y2), (z2), (x3), (y3), (z3), (c%), 0
psline (x3), (y3), (z3), (x4), (y4), (z4), (c%), 0
psline (x4), (y4), (z4), (x5), (y5), (z5), (c%), 0
END SUB

SUB psline (x1, y1, z1, x2, y2, z2, c%, B%)

'---------------------------------------------------------------------PS-Line
z1 = z1 + 1
z2 = z2 + 1
IF z1 = 0 THEN z1 = .000001
IF z2 = 0 THEN z2 = .000001

x3 = (midx% + ((x1 - panx) / (z1 * zoom)))
y3 = (midy% + ((y1 - pany) / (z1 * zoom)))

x4 = (midx% + ((x2 - panx) / (z2 * zoom)))
y4 = (midy% + ((y2 - pany) / (z2 * zoom)))

fault$ = "ps"
SELECT CASE B%
CASE 0: LINE (x3, y3)-(x4, y4), c%
CASE 1: LINE (x3, y3)-(x4, y4), c%, B
CASE 2: LINE (x3, y3)-(x4, y4), c%, BF
CASE 3: LINE (x3, y3)-(x4, y4), c%, , &H1111
CASE 4: LINE (x3, y3)-(x4, y4), c%, B, &H1111
END SELECT

fault$ = ""
END SUB

SUB psmark1 (x, y, Z, c1%, c2%, c3%)


pspset (x), (y), (Z), (c3%)
pspset (x), (y), (Z - .5), (c2%)
pspset (x), (y), (Z - 1), (c1%)

END SUB

SUB psmark2 (x, y, c1%, c2%, c3%)


pspset (x), (y), (1), (c3%)
pspset (x), (y), (.5), (c2%)
pspset (x), (y), (0), (c1%)

END SUB

SUB pspoint (x, y, Z)

'------------------------------------------------------------------- PS-Point
Z = Z + 1

IF Z = 0 THEN Z = .000001

x1 = (midx% + ((x - panx) / (Z * zoom)))
y1 = (midy% + ((y - pany) / (Z * zoom)))

fault$ = "ps"
pointc% = POINT(x1, y1)
fault$ = ""

END SUB

SUB pspset (x, y, Z, c%)


'------------------------------------------------------------------- PS-Pset
Z = Z + 1

IF Z = 0 THEN Z = .000001

x1 = (midx% + ((x - panx) / (Z * zoom)))
y1 = (midy% + ((y - pany) / (Z * zoom)))

fault$ = "ps"
PSET (x1, y1), c%
fault$ = ""
END SUB

SUB quit

 smallwindow
LOCATE 10, 2: PRINT "Quit SFB2: Vector Warriors ?"
LOCATE 11, 2: PRINT "<Y/N>"
5 wee$ = UCASE$(INKEY$)
IF wee$ = "" THEN 5

IF wee$ = "Y" THEN
IF sbsound% = 1 THEN sbinit
SYSTEM
END IF

 csmallwindow
wee$ = ""
END SUB

SUB rain2d (c1%, c2%, c3%, l)
REM-----------------------------------------------Draw Rain

WINDOW SCREEN (0, 0)-(1, 1)

FOR wee = 1 TO nstars%
LINE (stars1x(wee), stars1y(wee))-(stars1x(wee), stars1y(wee) - l), c1%
LINE (stars2x(wee), stars2y(wee))-(stars2x(wee), stars2y(wee) - l), c2%
LINE (stars3x(wee), stars3y(wee))-(stars3x(wee), stars3y(wee) - l), c3%
NEXT wee

CALL window3d

END SUB

SUB rain3d (x1, y1, z1, x2, y2, z2, c1%, c2%, c3%, l)
REM-----------------------------------------------Draw Rain

x2 = x2 - x1
y2 = y2 - y1
z2 = z2 - z1

FOR wee = 1 TO nstars%
x3 = x1 + (stars1x(wee) * x2)
y3 = y1 + (stars1y(wee) * y2)
z3 = z1 + (stars1z(wee) * z2)
psline (x3), (y3), (z3), (x3), (y3 - l), (z3), c1%, 0
'IF y3 > floor1 THEN psline (x3 - 1), (y3), (z3), (x3 + 1), (y3), (z3), 1, 0

x3 = x1 + (stars2x(wee) * x2)
y3 = y1 + (stars2y(wee) * y2)
z3 = z1 + (stars2z(wee) * z2)
psline (x3), (y3), (z3), (x3), (y3 - l), (z3), c2%, 0
'IF y3 > floor1 THEN psline (x3 - 1), (y3), (z3), (x3 + 1), (y3), (z3), 9, 0

x3 = x1 + (stars3x(wee) * x2)
y3 = y1 + (stars3y(wee) * y2)
z3 = z1 + (stars3z(wee) * z2)
psline (x3), (y3), (z3), (x3), (y3 - l), (z3), c3%, 0
'IF y3 > floor1 THEN psline (x3 - 2), (y3), (z3), (x3 + 2), (y3), (z3), 15, 0

NEXT wee


END SUB

SUB ringout (n)

ringoutt% = 50
IF ringoutp% = 1 AND n = 2 THEN ringoutp% = 3 ELSE ringoutp% = n


SELECT CASE stage%
'----------------------------------------------------------------------------
CASE IS = 1, 2, 4
health%(n) = health%(n) - 5

'----------------------------------------------------------------------------
CASE IS = 3, 8, 15
IF buttx(n) > 0 THEN buttx(n) = ring% - 10 ELSE buttx(n) = -ring% + 10
butth(n) = 0
FOR wee = 1 TO particles%
particle ((RND - .5) * 10), (floor1 - RND * 25), (midstage), 15, 1
NEXT wee

IF n = 2 THEN
win%(1) = win%(1) + 1
buttx(1) = 0
butty(1) = floor1 - 20
fighterfreeze 1
ELSE
win%(2) = win%(2) + 1
buttx(2) = 0
butty(2) = floor1 - 20
fighterfreeze 2
END IF

'------------
SCREEN , , 0, 0
IF win%(1) > 1 THEN PRINT name$(1) + " Wins the Match By Ringout": stage% = stage% + 1: setfightercpu
IF win%(2) > 1 THEN PRINT name$(2) + " Wins the Match By Ringout"

IF win%(1) > 1 OR win%(2) > 1 THEN
wee = TIMER
35 IF TIMER - wee < 3 THEN 35
newmatch
END IF

'----------------------------------------------------------------------------
CASE IS = 9
IF butty(n) > 80 THEN
health%(n) = health%(n) - 10
butth(n) = butth(n) / 2
pslightning buttx(n) + ((RND - .5) * 25), floor2, fighterz(n), neckx(n + 2), heady(n + 2) + (RND * 15), fighterz(n), 25, flash2%
IF ABS(buttx(n)) < ring% + 25 THEN butth(n) = 0: health%(n) = 0
END IF

'----------------------------------------------------------------------------
END SELECT
END SUB

SUB ringoutext (n)
IF ticker% > 50 THEN
IF ringoutt% < 3 THEN COLOR 4 ELSE COLOR 12
IF ringoutt% > 47 THEN COLOR 15
IF n = 3 THEN
IF rez% > 7 THEN LOCATE 5, 30 ELSE LOCATE 5, 20
PRINT "Both Fighters Ringout"
ELSE
IF rez% > 7 THEN
LOCATE 5, 30: PRINT name$(n)
LOCATE 5, 45: PRINT "Ringout"
ELSE
LOCATE 5, 30: PRINT name$(n)
LOCATE 6, 30: PRINT "Ringout"
END IF
END IF

END IF
END SUB

DEFINT A-Z
SUB sbfx (fxx%)

IF soundticker% < 1 AND sbsound = 1 THEN
soundticker% = soundwait%

'Freq%, Wave%, FEEDBACK%, Modl%, CLEN%

SELECT CASE fxx%

'Jab
CASE IS = 1
FOR wee = 1 TO 40
SBplay 100, 1, 1, 0, 1
NEXT wee
CALL SBWrite(&HB0, &H0)

'Strong
CASE IS = 2
FOR wee = 1 TO 60
SBplay 50, 1, 1, 0, 1
NEXT wee
CALL SBWrite(&HB0, &H0)

'Short
CASE IS = 3
FOR wee = 1 TO 45
SBplay 25, 1, 1, 0, 1
NEXT wee
CALL SBWrite(&HB0, &H0)

'Round House
CASE IS = 4
FOR wee = 1 TO 40
SBplay 1, 1, 1, 0, 1
NEXT wee
CALL SBWrite(&HB0, &H0)

'Skidding on Ground
CASE IS = 5
FOR wee = 1 TO 45
SBplay 150, 0, 14, 500, 150
NEXT wee
CALL SBWrite(&HB0, &H0)

'Throw Fire/Dragon
CASE IS = 6
FOR wee = 1 TO 45
SBplay 25, 0, 1000, 10, 261
NEXT wee
CALL SBWrite(&HB0, &H0)

'Charge
CASE IS = 7
FOR wee = 1 TO 45
SBplay 255, 0, 14, 16, 9
NEXT wee
CALL SBWrite(&HB0, &H0)

'Burning
CASE IS = 8
FOR wee = 1 TO 45
SBplay 25, 0, 1000, 10, 259
NEXT wee
CALL SBWrite(&HB0, &H0)

'Hit 1
CASE IS = 9
FOR wee = 1 TO 45
SBplay 50, 0, 12, 100, 262
NEXT wee
CALL SBWrite(&HB0, &H0)

'Hit 2
CASE IS = 10
FOR wee = 1 TO 45
SBplay 150, 0, 12, 100, 262
NEXT wee
CALL SBWrite(&HB0, &H0)

'Hit 3
CASE IS = 11
FOR wee = 1 TO 45
SBplay 250, 0, 12, 100, 262
NEXT wee
CALL SBWrite(&HB0, &H0)


'Gong 1
CASE IS = 12
FOR wee = 1 TO 45
SBplay 50, 2, 0, 13, 258
NEXT wee
CALL SBWrite(&HB0, &H0)

'Tick
CASE IS = 13
FOR wee = 1 TO 45
SBplay 0, 1, 10, 1, 15
NEXT wee
CALL SBWrite(&HB0, &H0)

'Gong 2
CASE IS = 14
FOR wee = 1 TO 45
SBplay 100, 2, 16, 135, 258
NEXT wee
CALL SBWrite(&HB0, &H0)

'Gong 3
CASE IS = 15
FOR wee = 1 TO 45
SBplay 50, 2, 0, 13, 259
NEXT wee
CALL SBWrite(&HB0, &H0)

'Fan
CASE IS = 16
FOR wee = 1 TO 45
SBplay 14, 1, 14, 15, 260
NEXT wee
CALL SBWrite(&HB0, &H0)

'Chopping
CASE IS = 17
FOR wee = 1 TO 45
SBplay 69, 1, 14, 5, 4
NEXT wee
CALL SBWrite(&HB0, &H0)

'Laser 1
CASE IS = 18
FOR wee = 1 TO 45
SBplay 35, -1, 62, 0, 260
NEXT wee
CALL SBWrite(&HB0, &H0)

'Shock 1
CASE IS = 19
FOR wee = 1 TO 45
SBplay 60, 3, 14, 15, 19
NEXT wee
CALL SBWrite(&HB0, &H0)

'Slamming on Ground
CASE IS = 20
FOR wee = 1 TO 45
SBplay 150, 0, 14, 500, 200
NEXT wee
CALL SBWrite(&HB0, &H0)


'Shock 2
CASE IS = 21
FOR wee = 1 TO 45
SBplay 30, 3, 14, 15, 19
NEXT wee
CALL SBWrite(&HB0, &H0)


'Button 1
CASE IS = 22
FOR wee = 1 TO 45
SBplay 200, 0, 1, 100, 262
NEXT wee
CALL SBWrite(&HB0, &H0)


'Button 2
CASE IS = 23
FOR wee = 1 TO 45
SBplay 50, 1, 0, 50, 259
NEXT wee
CALL SBWrite(&HB0, &H0)


'Button 3
CASE IS = 24
FOR wee = 1 TO 45
SBplay 100, 0, 10, 25, 262
NEXT wee
CALL SBWrite(&HB0, &H0)


'Swizz Punches
CASE IS = 25
FOR wee = 1 TO 45
SBplay 14, 0, 14, 15, 260
NEXT wee
CALL SBWrite(&HB0, &H0)


'Conclusion
CASE IS = 26
FOR wee = 1 TO 45
SBplay 200, 0, 0, 131, 2
NEXT wee
CALL SBWrite(&HB0, &H0)



END SELECT
END IF

END SUB

SUB sbinit
fault$ = "sb"
LOCATE 1, 1
COLOR 15

PRINT "Initializing Sound Card"
FOR Q = 1 TO &HF5
CALL SBWrite(Q, 0)
NEXT Q

LOCATE 1, 1
PRINT "                       "

fault$ = ""
END SUB

SUB SBplay (Freq%, Wave%, Feedback%, Modl%, Clen%)
                               'Channel 1
                               'Operator 1
CALL SBWrite(&H20, Modl%)      '&H51
CALL SBWrite(&H40, 10)         '49
CALL SBWrite(&H60, &H40)       '&HF0
CALL SBWrite(&H80, &H240)      '&H77
CALL SBWrite(&HA0, Freq%)      'Freq%
                                'Operator 2
CALL SBWrite(&H23, 1)          '
CALL SBWrite(&H43, 0)          '49
CALL SBWrite(&H63, &HF0)       '
CALL SBWrite(&H83, Clen%)      'CLEN%
CALL SBWrite(&HB0, &H31)       '&H31
                                                   
CALL SBWrite(&HE0, Wave%)      '0 or 1
CALL SBWrite(&HC0, Feedback%)  '

END SUB

SUB SBWrite (Reg%, Value%)
fault$ = "sb"
OUT &H220, Reg%
FOR x = 0 TO SBWrite.delay1
   a = INP(&H220)
NEXT x
OUT &H223, Value%
FOR x = 0 TO SBWrite.delay2
   a = INP(&H220)
NEXT x
fault$ = ""
END SUB

DEFSNG A-Z
SUB setbody (n%)

SELECT CASE body%(n%)
CASE 1: maxhp%(n%) = 150: sdelay%(n%) = 5
CASE 2: maxhp%(n%) = 160: sdelay%(n%) = 8
CASE 3: maxhp%(n%) = 170: sdelay%(n%) = 9
CASE 4: maxhp%(n%) = 180: sdelay%(n%) = 15
CASE 5: maxhp%(n%) = 190: sdelay%(n%) = 18
CASE 6: maxhp%(n%) = 175: sdelay%(n%) = 10
CASE 7: maxhp%(n%) = 175: sdelay%(n%) = 11
CASE 8: maxhp%(n%) = 200: sdelay%(n%) = 20
CASE 666: maxhp%(n%) = 200: sdelay%(n%) = 5
CASE 2000: maxhp%(n%) = 200: sdelay%(n%) = 10
END SELECT

health%(n%) = maxhp%(n%)
END SUB

SUB setcmethod

CALL smallwindow
LOCATE 10, 2: PRINT "Clear Method - Type"

IF cmethod% = 0 THEN mark = 15 ELSE mark = 7
COLOR mark: LOCATE 12, 2: PRINT "1 No Clearing"

IF cmethod% = 1 THEN mark = 15 ELSE mark = 7
COLOR mark: LOCATE 13, 2: PRINT "2 LINE BF"

IF cmethod% = 2 THEN mark = 15 ELSE mark = 7
COLOR mark: LOCATE 14, 2: PRINT "3 CLS"

IF cmethod% = 3 THEN mark = 15 ELSE mark = 7
COLOR mark: LOCATE 15, 2: PRINT "4 Horizontal Fade"

IF cmethod% = 4 THEN mark = 15 ELSE mark = 7
COLOR mark: LOCATE 16, 2: PRINT "5 Block Fade"

16 wee$ = INKEY$
SELECT CASE wee$
CASE IS = "": GOTO 16
CASE IS = "1": cmethod% = 0
CASE IS = "2": cmethod% = 1
CASE IS = "3": cmethod% = 2
CASE IS = "4": cmethod% = 3
CASE IS = "5": cmethod% = 4
END SELECT

'---------------------------------------------------------
IF cmethod% > 0 AND wee$ <> CHR$(27) THEN
CALL csmallwindow
CALL smallwindow

LOCATE 10, 2: PRINT "Clear Method - Frequency"

IF cfreq% = -1 THEN mark = 15 ELSE mark = 7
COLOR mark: LOCATE 12, 2: PRINT "1 Always"

IF cfreq% = 1 THEN mark = 15 ELSE mark = 7
COLOR mark: LOCATE 13, 2: PRINT "2 Often"

IF cfreq% = 5 THEN mark = 15 ELSE mark = 7
COLOR mark: LOCATE 14, 2: PRINT "3 Rarely"

17 wee$ = INKEY$: IF wee$ = "" THEN 17
IF wee$ = "1" THEN cfreq% = -1
IF wee$ = "2" THEN cfreq% = 1
IF wee$ = "3" THEN cfreq% = 5
END IF
CALL csmallwindow
wee$ = ""
END SUB

SUB setdelay
SCREEN , 0, 0
CALL smallwindow
COLOR 15
LOCATE 10, 2: PRINT "Game Speed"

IF rez% = 7 THEN
LOCATE 12, 2: PRINT " LOW 00 10 20 30 40 50 60 70 80 90 HI"
ELSE
LOCATE 12, 2: PRINT "Slow 00 10 20 30 40 50 60 70 80 90 Fast"
END IF

COLOR 4
LOCATE 16, 2: PRINT "Press Spacebar To Save."
d = delay%
15
wee$ = INKEY$

IF d = delay% THEN
COLOR 15
LOCATE 13, 35 - INT(d / 2000): PRINT "^"

ELSE
COLOR 7
LOCATE 13, 35 - INT(d / 2000): PRINT "^"
COLOR 9
LOCATE 13, 35 - INT(delay% / 2000): PRINT "^"
END IF

IF wee$ = "6" OR wee$ = CHR$(0) + "M" OR wee$ = "+" OR wee$ = "=" THEN LOCATE 13, 35 - INT(d / 2000): PRINT " ": d = d - 2000
IF wee$ = "4" OR wee$ = CHR$(0) + "K" OR wee$ = "-" THEN LOCATE 13, 35 - INT(d / 2000): PRINT " ": d = d + 2000
IF d < 0 THEN d = 0
IF d > 56000 THEN d = 56000
IF wee$ = " " OR wee$ = CHR$(13) THEN LOCATE 13, 35 - INT(delay% / 2000): PRINT " ": delay% = d
IF wee$ <> CHR$(27) THEN 15

CALL csmallwindow
wee$ = ""
END SUB

SUB setdetails
smallwindow

COLOR 15
LOCATE 10, 2: PRINT "Graphic Details"

IF rez% > 7 THEN
LOCATE 12, 2: PRINT "Stages"
LOCATE 12, 12: PRINT "Fighters"
LOCATE 12, 22: PRINT "HUD"
LOCATE 12, 32: PRINT "Smears"
LOCATE 12, 42: PRINT "Fighter Limits"
n% = 10
ELSE
LOCATE 12, 2:  PRINT "Stgs"
LOCATE 12, 10: PRINT "Ftrs"
LOCATE 12, 18: PRINT "HUD"
LOCATE 12, 26: PRINT "Smrs"
LOCATE 12, 34: PRINT "FLim"
n% = 8
END IF


33

'---

wee = 2

IF stagedetail% = 0 THEN mark = 15 ELSE mark = 7
COLOR mark: LOCATE 14, wee: PRINT "1 Low"

IF stagedetail% = 1 THEN mark = 15 ELSE mark = 7
COLOR mark: LOCATE 15, wee: PRINT "2 High"

wee = wee + n%

'---
IF fighterdetail% = 0 THEN mark = 15 ELSE mark = 7
COLOR mark: LOCATE 14, wee: PRINT "3 Low"

IF fighterdetail% = 1 THEN mark = 15 ELSE mark = 7
COLOR mark: LOCATE 15, wee: PRINT "4 High"

wee = wee + n%

'---
IF hudetail% = 0 THEN mark = 15 ELSE mark = 7
COLOR mark: LOCATE 14, wee: PRINT "5 Low"

IF hudetail% = 1 THEN mark = 15 ELSE mark = 7
COLOR mark: LOCATE 15, wee: PRINT "6 High"

wee = wee + n%

'---
IF smears% = 0 THEN mark = 15 ELSE mark = 7
COLOR mark: LOCATE 14, wee: PRINT "7 Off"

IF smears% = 1 THEN mark = 15 ELSE mark = 7
COLOR mark: LOCATE 15, wee: PRINT "8 On"

wee = wee + n%

'---
IF flimits% = 0 THEN mark = 15 ELSE mark = 7
COLOR mark: LOCATE 14, wee: PRINT "9 Off"

IF flimits% = 1 THEN mark = 15 ELSE mark = 7
COLOR mark: LOCATE 15, wee: PRINT "0 On"


wee$ = INKEY$
SELECT CASE wee$
CASE IS = "1": stagedetail% = 0
CASE IS = "2": stagedetail% = 1
CASE IS = "3": fighterdetail% = 0
CASE IS = "4": fighterdetail% = 1
CASE IS = "5": hudetail% = 0
CASE IS = "6": hudetail% = 1
CASE IS = "7": smears% = 0
CASE IS = "8": smears% = 1
CASE IS = "9": flimits% = 0
CASE IS = "0": flimits% = 1
END SELECT

IF wee$ <> CHR$(27) THEN 33


'----------------------------------------------------------------------------
smallwindow
wee$ = ""
END SUB

SUB setfighter
bigwindow

changed% = 0
zoomsave = zoom
panxsave = panx
panysave = pany

zoom = fighterz(1) / 150
pany = butty(1)
wee = 0
IF rez% = 7 THEN x% = -15

37 redraw% = 0

'----------------------------------------------------------------------------
IF head%(1) >= 100 THEN
body%(1) = head%(1)
arms%(1) = head%(1)
hands%(1) = head%(1)
legs%(1) = head%(1)
feet%(1) = head%(1)
END IF

'-------------------------------------------------------------- Fighter Info.
window2d
LINE (5, 15.5)-(99, 89), 0, BF
window3d

IF rez% > 7 THEN

'Red Text (Titles)
COLOR 4

'Left Panel

LOCATE 6, 30: PRINT "Specials:"
LOCATE 7, 30: PRINT "Q"
LOCATE 8, 30: PRINT "W"
LOCATE 10, 30: PRINT "A"
LOCATE 11, 30: PRINT "S"

LOCATE 13, 30: PRINT "Super:"
LOCATE 14, 30: PRINT "D"

LOCATE 16, 30: PRINT "Recharges:"
LOCATE 17, 30: PRINT "RG:"
LOCATE 18, 30: PRINT "AW:"

'Right Panel

LOCATE 6, 55: PRINT "Arm Power Ratings:"
LOCATE 7, 55: PRINT "HP:"
LOCATE 8, 55: PRINT "AW:"

LOCATE 9, 55: PRINT "Leg Power Ratings:"
LOCATE 10, 55: PRINT "HP:"
LOCATE 11, 55: PRINT "AW:"

LOCATE 13, 55: PRINT "Jumping:"
LOCATE 14, 55: PRINT "Alt       Dis"


LOCATE 16, 55: PRINT "Starting Conditions"
LOCATE 17, 55: PRINT "HP:"
LOCATE 18, 55: PRINT "AW:"

LOCATE 20, 55: PRINT "Stun Duration"

LOCATE 20, 30: PRINT "Name"



'Gray Text (Stats)
COLOR 8

LOCATE 18, 59
SELECT CASE head%(1)
CASE 1
PRINT "50%"
LOCATE 17, 34: PRINT "4"
LOCATE 18, 34: PRINT "2"

CASE 2
PRINT "40%"
LOCATE 17, 34: PRINT "3"
LOCATE 18, 34: PRINT "3"

CASE 3
PRINT "30%"
LOCATE 17, 34: PRINT "2"
LOCATE 18, 34: PRINT "4"

CASE 4
PRINT "60%"
LOCATE 17, 34: PRINT "5"
LOCATE 18, 34: PRINT "1"

CASE 5
PRINT "20%"
LOCATE 17, 34: PRINT "1"
LOCATE 18, 34: PRINT "5"
END SELECT


'Hands
LOCATE 7, 32
SELECT CASE hands%(1)
CASE 1
PRINT "Fire Ball"
LOCATE 8, 32
PRINT "Twin Mini Balls"

CASE 2
PRINT "Power Jab"
LOCATE 8, 32
PRINT "Hammer Punch"

CASE 3
PRINT "Neck Jab"
LOCATE 8, 32
PRINT "Thrust Slam"

CASE 4
PRINT "Ball Lightning"
LOCATE 8, 32
PRINT "Rising Dragon"

CASE 5
PRINT "Triple Shrokken"
LOCATE 8, 32
PRINT "Stun Knuckle"
END SELECT


'Feet
LOCATE 10, 32
SELECT CASE feet%(1)
CASE 1
PRINT "Plant Kick"
LOCATE 11, 32
PRINT "Nee Bash"

CASE 2
PRINT "Axe Kick"
LOCATE 11, 32
PRINT "Lightning Kick Blast"

CASE 3
PRINT "Stunning Gut Stab"
LOCATE 11, 32
PRINT "6-Slip"

CASE 4
PRINT "Thrust Kick"
LOCATE 11, 32
PRINT "Skip Kick"

CASE 5
PRINT "Slasher Strike"
LOCATE 11, 32
PRINT "Upper Assault"
END SELECT


LOCATE 7, 59
SELECT CASE arms%(1)
CASE 1
PRINT "0"
LOCATE 8, 59: PRINT "5"

CASE 2
PRINT "2"
LOCATE 8, 59: PRINT "3"

CASE 3
PRINT "3"
LOCATE 8, 59: PRINT "2"

CASE 4
PRINT "1"
LOCATE 8, 59: PRINT "4"

CASE 5
PRINT "4"
LOCATE 8, 59: PRINT "1"

END SELECT




LOCATE 14, 59
SELECT CASE legs%(1)
CASE 1
PRINT "7"
LOCATE 10, 59: PRINT "0"
LOCATE 11, 59: PRINT "5"
LOCATE 14, 69: PRINT "16"

CASE 2
PRINT "10"
LOCATE 10, 59: PRINT "2"
LOCATE 11, 59: PRINT "3"
LOCATE 14, 69: PRINT "14"

CASE 3
PRINT "8"
LOCATE 10, 59: PRINT "3"
LOCATE 11, 59: PRINT "2"
LOCATE 14, 69: PRINT "12"

CASE 4
PRINT "14"
LOCATE 10, 59: PRINT "3"
LOCATE 11, 59: PRINT "1"
LOCATE 14, 69: PRINT "10"

CASE 5
PRINT "9"
LOCATE 10, 59: PRINT "2"
LOCATE 11, 59: PRINT "2"
LOCATE 14, 69: PRINT "25"
END SELECT


LOCATE 17, 59
SELECT CASE body%(1)
CASE 1
PRINT "150"
LOCATE 14, 32: PRINT "Vex of Evil"
LOCATE 21, 55: PRINT "5"

CASE 2
PRINT "160"
LOCATE 14, 32: PRINT "Energy Blast"
LOCATE 21, 55: PRINT "8"

CASE 3
PRINT "170"
LOCATE 14, 32: PRINT "Spear Kick"
LOCATE 21, 55: PRINT "9"

CASE 4
PRINT "180"
LOCATE 14, 32: PRINT "Health Up"
LOCATE 21, 55: PRINT "15"

CASE 5
PRINT "190"
LOCATE 14, 32: PRINT "Razer Arms"
LOCATE 21, 55: PRINT "18"

CASE 6
PRINT "175"
LOCATE 14, 32: PRINT "Neck Snapper"
LOCATE 21, 55: PRINT "10"

CASE 7
PRINT "175"
LOCATE 14, 32: PRINT "Swizz Punches"
LOCATE 21, 55: PRINT "11"

CASE 8
PRINT "200"
LOCATE 14, 32: PRINT "Upper Bust"
LOCATE 21, 55: PRINT "20"

END SELECT

LOCATE 21, 30: PRINT name$(1)


END IF
'--------------------------------------------------------------- End of Stats

'----------------------------------------------------------------- 3D Display
panx = buttx(1) + x%
smearender
fighterender
particlerender

'--------------------------------------------------------------- Info Display
COLOR 15
IF rez% > 7 THEN LOCATE 4, 34 ELSE LOCATE 4, 2
PRINT "BUILD FIGHTER"
LOCATE 22, 6: COLOR 15: PRINT "MORE"

'------------------------------------- Mode 0 (Info Display)
IF sfmode% = 0 THEN

COLOR 12
LOCATE 6, 6: PRINT "PART       TYPE"
COLOR 15
LOCATE 7, 6: PRINT "Head      "; head%(1); "    "
LOCATE 8, 6: PRINT "Body      "; body%(1); "    "
LOCATE 9, 6: PRINT "Arms      "; arms%(1); "    "
LOCATE 10, 6: PRINT "Hands     "; hands%(1); "    "
LOCATE 11, 6: PRINT "Legs      "; legs%(1); "    "
LOCATE 12, 6: PRINT "Feet      "; feet%(1); "    "

COLOR 12
LOCATE 14, 6: PRINT "PART       COLOR"
COLOR 15
LOCATE 15, 6: PRINT "Head"
LOCATE 16, 6: PRINT "Body"
LOCATE 17, 6: PRINT "Arms"
LOCATE 18, 6: PRINT "Hands"
LOCATE 19, 6: PRINT "Legs"
LOCATE 20, 6: PRINT "Feet"

LOCATE 15, 17: COLOR headc%(1): PRINT CHR$(219); CHR$(178); CHR$(177); CHR$(176)
LOCATE 16, 17: COLOR bodyc%(1): PRINT CHR$(219); CHR$(178); CHR$(177); CHR$(176)
LOCATE 17, 17: COLOR armsc%(1) + 8: PRINT CHR$(219); CHR$(178); CHR$(177); CHR$(176)
LOCATE 18, 17: COLOR handsc%(1) + 8: PRINT CHR$(219); CHR$(178); CHR$(177); CHR$(176)
LOCATE 19, 17: COLOR legsc%(1) + 8: PRINT CHR$(219); CHR$(178); CHR$(177); CHR$(176)
LOCATE 20, 17: COLOR feetc%(1) + 8: PRINT CHR$(219); CHR$(178); CHR$(177); CHR$(176)

COLOR 15

'------------------------------------- Mode 1 (Info Display)
ELSE

COLOR 12
LOCATE 6, 6: PRINT "NAME"
COLOR 15
LOCATE 7, 6: PRINT "Enter     "
LOCATE 8, 6: PRINT "Generate  "

COLOR 12
LOCATE 10, 6: PRINT "HAIR"
COLOR 15
SELECT CASE hairt%(1)
CASE 1: hairt$ = "Strait"
CASE 2: hairt$ = "Braid "
END SELECT
LOCATE 11, 6: PRINT "Style      "; hairt$
SELECT CASE hairl%(1)
CASE 0: hairl$ = "Bald  "
CASE 1: hairl$ = "Short "
CASE 2: hairl$ = "Medium"
CASE 3: hairl$ = "Long  "
END SELECT
LOCATE 12, 6: PRINT "Length     "; hairl$
LOCATE 13, 6: PRINT "Color     ": LOCATE 13, 17: COLOR hairc%(1): PRINT CHR$(219); CHR$(178); CHR$(177); CHR$(176)

COLOR 12
LOCATE 15, 6: PRINT "MISC."
COLOR 15

IF solidc% = 1 THEN wee$ = "Solid" ELSE wee$ = "Multi"
LOCATE 16, 6: PRINT "Opponent Colors - "; wee$


END IF


'----------------------------------------------------------------------------

IF ptfighter% < 7 THEN ptfighter% = 7


DO
wee$ = UCASE$(INKEY$)

'Shift 3D Display
IF wee$ = "4" OR wee$ = CHR$(0) + "K" THEN x% = 0: redraw% = 1
IF wee$ = "6" OR wee$ = CHR$(0) + "M" THEN x% = -15: redraw% = 1

IF head%(1) < 100 THEN
SELECT CASE wee$

CASE "š"
changed% = 1
head%(1) = 666
nee1x(3) = buttx(1) - 3 * d%(1)
nee2x(3) = buttx(1) - 3 * d%(1)
foot1x(3) = nee1x(3) + 5 * d%(1)
foot2x(3) = nee2x(3) + 5 * d%(1)
name$(1) = "Demize"
GOTO 37

CASE "Î": head%(1) = 1998: changed% = 1: GOTO 37
CASE "Ð": head%(1) = 2000: changed% = 1: GOTO 37
END SELECT
END IF


'----------------------------------------------------------------- Move Arrow

SELECT CASE wee$

CASE IS = "8", CHR$(0) + "H"
LOCATE ptfighter%, 2: PRINT " ": ptfighter% = ptfighter% - 1
IF ptfighter% = 6 THEN ptfighter% = 7
IF sfmode% = 0 THEN
IF ptfighter% = 14 THEN ptfighter% = 12
IF ptfighter% = 21 THEN ptfighter% = 20
ELSE
IF ptfighter% = 10 THEN ptfighter% = 8
IF ptfighter% = 15 THEN ptfighter% = 13
IF ptfighter% = 21 THEN ptfighter% = 16
END IF


'--------------+

CASE IS = "5", "2", CHR$(0) + "P"
LOCATE ptfighter%, 2: PRINT " ": ptfighter% = ptfighter% + 1
IF ptfighter% = 23 THEN ptfighter% = 22
IF sfmode% = 0 THEN
IF ptfighter% = 13 THEN ptfighter% = 15
IF ptfighter% = 21 THEN ptfighter% = 22
ELSE
IF ptfighter% = 9 THEN ptfighter% = 11
IF ptfighter% = 14 THEN ptfighter% = 16
IF ptfighter% = 17 THEN ptfighter% = 22
END IF



END SELECT

LOCATE ptfighter%, 2: PRINT CHR$(16)



'--------------------------------------------------------------------- Select
IF wee$ = " " OR wee$ = CHR$(13) THEN

redraw% = 1
wee$ = ""

'------------------------------------- Mode 0 (Selection)
IF sfmode% = 0 THEN

IF ptfighter% <= 12 THEN changed% = 1

SELECT CASE ptfighter%

CASE IS = 7
IF head%(1) >= 100 THEN
 head%(1) = 1
 body%(1) = 1
 arms%(1) = 1
 hands%(1) = 1
 legs%(1) = 1
 feet%(1) = 1
 nee1x(3) = buttx(1) + 5
 nee2x(3) = buttx(1) - 1
 foot1x(3) = nee1x(3) - 1
 foot2x(3) = nee2x(3) - 3
ELSE
 IF head%(1) < 5 THEN head%(1) = head%(1) + 1 ELSE head%(1) = 1
END IF

CASE IS = 9
IF arms%(1) < 5 THEN arms%(1) = arms%(1) + 1 ELSE arms%(1) = 1

CASE IS = 10
IF hands%(1) < 5 THEN hands%(1) = hands%(1) + 1 ELSE hands%(1) = 1

CASE IS = 8
IF body%(1) < 8 THEN body%(1) = body%(1) + 1 ELSE body%(1) = 1

CASE IS = 11
IF legs%(1) < 5 THEN legs%(1) = legs%(1) + 1 ELSE legs%(1) = 1

CASE IS = 12
IF feet%(1) < 5 THEN feet%(1) = feet%(1) + 1 ELSE feet%(1) = 1

'--------------------

CASE IS = 15
IF headc%(1) < 15 THEN headc%(1) = headc%(1) + 1 ELSE headc%(1) = 1

CASE IS = 16
IF bodyc%(1) < 15 THEN bodyc%(1) = bodyc%(1) + 1 ELSE bodyc%(1) = 1

CASE IS = 17
IF armsc%(1) < 7 THEN armsc%(1) = armsc%(1) + 1 ELSE armsc%(1) = 1

CASE IS = 18
IF handsc%(1) < 7 THEN handsc%(1) = handsc%(1) + 1 ELSE handsc%(1) = 1

CASE IS = 19
IF legsc%(1) < 7 THEN legsc%(1) = legsc%(1) + 1 ELSE legsc%(1) = 1

CASE IS = 20
IF feetc%(1) < 7 THEN feetc%(1) = feetc%(1) + 1 ELSE feetc%(1) = 1

'--------------------

CASE IS = 22
sfmode% = 1: redraw% = 1
LOCATE ptfighter%, 2: PRINT " "
ptfighter% = 7

END SELECT


'------------------------------------- Mode 1 (Selection)
ELSE

SELECT CASE ptfighter%

CASE IS = 7
LOCATE 21, 30: PRINT "                         "
LOCATE 21, 30
COLOR 15
INPUT ; "", name$(1)

CASE IS = 8
fightername (1)

CASE IS = 11
IF hairt%(1) = 1 THEN hairt%(1) = 2 ELSE hairt%(1) = 1

CASE IS = 12
IF hairl%(1) < 3 THEN hairl%(1) = hairl%(1) + 1 ELSE hairl%(1) = 0

CASE IS = 13
IF hairc%(1) < 15 THEN hairc%(1) = hairc%(1) + 1 ELSE hairc%(1) = 1

CASE IS = 16
IF solidc% = 1 THEN solidc% = 0 ELSE solidc% = 1

CASE IS = 22
sfmode% = 0: redraw% = 1
LOCATE ptfighter%, 2: PRINT " "
ptfighter% = 7

END SELECT
END IF
END IF

'----------------------------------------------------------------------------
IF redraw% = 1 THEN 37
LOOP UNTIL wee$ = CHR$(27)

cbigwindow
wee$ = ""

zoom = zoomsave
panx = panxsave
pany = panysave

IF changed% = 1 THEN stageinit

'----------------------------------------------------------------------------
END SUB

SUB setfightercpu

IF stage% < 1000 THEN
'Normal
hairt%(2) = INT(RND * 2) + 1
hairl%(2) = INT(RND * 4)
hairc%(2) = INT(RND * 15) + 1
head%(2) = INT(RND * 5) + 1
arms%(2) = INT(RND * 5) + 1
hands%(2) = INT(RND * 4) + 1
body%(2) = INT(RND * 8) + 1
legs%(2) = INT(RND * 5) + 1
feet%(2) = INT(RND * 5) + 1
ELSE
'Master Bean
hairl%(2) = 3
hairt%(2) = 1
head%(2) = 2000
arms%(2) = 2000
hands%(2) = 2000
body%(2) = 2000
legs%(2) = 2000
feet%(2) = 2000
END IF

IF stage% < 1000 THEN
IF solidc% = 1 THEN
'Solid Colors
c% = INT(RND * 7) + 1
headc%(2) = c% + 8
bodyc%(2) = c% + 8
armsc%(2) = c%
handsc%(2) = c%
legsc%(2) = c%
feetc%(2) = c%

ELSE
'Normal Colors
headc%(2) = INT(RND * 15) + 1
bodyc%(2) = INT(RND * 15) + 1
armsc%(2) = INT(RND * 7) + 1
handsc%(2) = INT(RND * 7) + 1
legsc%(2) = INT(RND * 7) + 1
feetc%(2) = INT(RND * 7) + 1
END IF

ELSE
'Master Bean's Colors
hairc%(2) = 4
headc%(2) = 9
bodyc%(2) = 1
armsc%(2) = 4
handsc%(2) = 1
legsc%(2) = 4
feetc%(2) = 1
END IF



IF stage% = 15 THEN
hairl%(2) = 0
head%(2) = 666
arms%(2) = 666
hands%(2) = 666
body%(2) = 666
legs%(2) = 666
feet%(2) = 666
headc%(2) = 4
bodyc%(2) = 4
armsc%(2) = 4
handsc%(2) = 4
legsc%(2) = 4
feetc%(2) = 8
END IF



END SUB

SUB setframeskip


CALL smallwindow
LOCATE 10, 2: PRINT "Change Frame Skip Value"

IF frameskip% = 0 THEN mark = 15 ELSE mark = 7
COLOR mark: LOCATE 12, 2: PRINT "1 Render Everything"

IF frameskip% = 1 THEN mark = 15 ELSE mark = 7
COLOR mark: LOCATE 13, 2: PRINT "2 Skip Some Frames"

IF frameskip% = 3 THEN mark = 15 ELSE mark = 7
COLOR mark: LOCATE 14, 2: PRINT "3 Skip Many Frames"

IF frameskip% = 5 THEN mark = 15 ELSE mark = 7
COLOR mark: LOCATE 15, 2: PRINT "4 Skip Most Frames"

10 wee$ = INKEY$: IF wee$ = "" THEN 10
IF wee$ = "1" THEN frameskip% = 0
IF wee$ = "2" THEN frameskip% = 1
IF wee$ = "3" THEN frameskip% = 3
IF wee$ = "4" THEN frameskip% = 5

CALL csmallwindow
wee$ = ""
END SUB

SUB seti16
smallwindow
LOCATE 10, 2: PRINT "i16 Options"

IF i16m% = 0 THEN mark = 15 ELSE mark = 7
COLOR mark: LOCATE 12, 2: PRINT "1 Show All i16"

IF i16m% = 1 THEN mark = 15 ELSE mark = 7
COLOR mark: LOCATE 13, 2: PRINT "2 No i16 in Stage Select"

IF i16m% = 2 THEN mark = 15 ELSE mark = 7
COLOR mark: LOCATE 14, 2: PRINT "3 Don't Show any i16"

12 wee$ = INKEY$: IF wee$ = "" THEN 12
SELECT CASE wee$
CASE IS = "1": i16m% = 0
CASE IS = "2": i16m% = 1
CASE IS = "3": i16m% = 2
END SELECT

csmallwindow
END SUB

SUB setko (n)

SELECT CASE head%(n)
CASE 1: ko(n) = 50
CASE 2: ko(n) = 40
CASE 3: ko(n) = 30
CASE 4: ko(n) = 60
CASE 5: ko(n) = 20
CASE 666: ko(n) = 100
END SELECT
END SUB

SUB setparticles

particleclear

zoomsave = zoom
panxsave = panx
panysave = pany
ringsave% = ring%

zoom = .35
panx = 0
pany = 0
ring% = 0


CALL smallwindow
LOCATE 10, 2: PRINT "Max Number of Particles to Display"

IF rez% = 7 THEN
LOCATE 12, 2: PRINT " LOW 00 10 20 30 40 50 60 70 80 90 HI"
ELSE
LOCATE 12, 2: PRINT "None 00 10 20 30 40 50 60 70 80 90 Many"
END IF
COLOR 4
LOCATE 16, 2: PRINT "Press Spacebar To Save."


p% = particles%

PCOPY 0, 1

25
wee$ = INKEY$

'------------------------
IF rez% > 7 THEN
pflip

'Delay
flicker = TIMER: DO UNTIL TIMER - flicker > .000005: LOOP

 window2d
 LINE (60, 37)-(70, 63), 0, BF
 LINE (5, 48)-(45, 49), 0, BF
 window3d

 particle 50, 45, 1, 16, 2
 particle 50, 45, 1, 15, 1
 decay
 particlemove
 particlerender
END IF
'------------------------

IF p% = particles% THEN
COLOR 15
LOCATE 13, 7 + INT(p% / 3.3): PRINT "^"

ELSE
COLOR 7
LOCATE 13, 7 + INT(p% / 3.3): PRINT "^"
COLOR 9
LOCATE 13, 7 + INT(particles% / 3.3): PRINT "^"
END IF

IF wee$ = "6" OR wee$ = CHR$(0) + "M" OR wee$ = "+" OR wee$ = "=" THEN LOCATE 13, 7 + INT(p% / 3.3): PRINT " ": p% = p% + 10
IF wee$ = "4" OR wee$ = CHR$(0) + "K" OR wee$ = "-" THEN LOCATE 13, 7 + INT(p% / 3.3): PRINT " ": p% = p% - 10
IF p% < 0 THEN p% = 0
IF p% > 90 THEN p% = 90
IF wee$ = " " OR wee$ = CHR$(13) THEN LOCATE 13, 7 + INT(particles% / 3.3): PRINT " ": particles% = p%

IF wee$ <> CHR$(27) THEN 25

particleclear
CALL csmallwindow
wee$ = ""
zoom = zoomsave
panx = panxsave
pany = panysave
ring% = ringsave%
SCREEN , , 0, 0
END SUB

SUB setpath
SCREEN 9
IF rez% > 0 THEN
smallwindow
END IF

LOCATE 10, 2: PRINT "SET PATH"
LOCATE 11, 2: PRINT "Please give the working directory of this program."
LOCATE 12, 2: PRINT "Ex.  C:\SFB2"
LOCATE 13, 2: INPUT "", path$
path$ = UCASE$(path$)

LOCATE 14, 2: PRINT "Would you like save this info as C:\SFB2.PTH [Y/N]?"

30 wee$ = UCASE$(INKEY$): IF wee$ = "" THEN 30
IF wee$ = "Y" THEN
OPEN "c:\sfb2.pth" FOR OUTPUT AS #1
WRITE #1, path$
CLOSE #1
END IF
IF rez% > 0 THEN csmallwindow
CLS
END SUB

SUB setrez

CALL smallwindow
LOCATE 10, 2: PRINT "Change Screen Resolution"

IF rez% = 7 THEN mark = 15 ELSE mark = 7
COLOR mark: LOCATE 13, 2: PRINT "1 (320x200)"

IF rez% = 8 THEN mark = 15 ELSE mark = 7
COLOR mark: LOCATE 14, 2: PRINT "2 (640x200)"

IF rez% = 9 THEN mark = 15 ELSE mark = 7
COLOR mark: LOCATE 15, 2: PRINT "3 (640x350)"


6 wee$ = INKEY$: IF wee$ = "" THEN 6
IF wee$ = "1" THEN rez% = 7
IF wee$ = "2" THEN rez% = 8
IF wee$ = "3" THEN rez% = 9

IF wee$ = CHR$(27) THEN 11

IF wee$ <> "1" AND wee$ <> "2" AND wee$ <> "3" AND wee$ <> "4" AND wee$ <> "5" THEN 6


11
CALL csmallwindow
SCREEN rez%
CALL window3d

'IF rez% = 8 THEN CALL page2
wee$ = ""
END SUB

SUB setsound

smallwindow
LOCATE 10, 2: PRINT "Sound Quality Options"

IF sbsound% = 1 AND soundwait% = 3 THEN mark = 15 ELSE mark = 7
COLOR mark: LOCATE 12, 2: PRINT "1 Best"

IF sbsound% = 1 AND soundwait% = 4 THEN mark = 15 ELSE mark = 7
COLOR mark: LOCATE 13, 2: PRINT "2 Good"

IF sbsound% = 1 AND soundwait% = 6 THEN mark = 15 ELSE mark = 7
COLOR mark: LOCATE 14, 2: PRINT "3 Ok"

IF sbsound% = 1 AND soundwait% = 10 THEN mark = 15 ELSE mark = 7
COLOR mark: LOCATE 15, 2: PRINT "4 Chunky"

IF sbsound% = 0 THEN mark = 15 ELSE mark = 7
COLOR mark: LOCATE 16, 2: PRINT "5 No Sound"


29 wee$ = INKEY$: IF wee$ = "" THEN 29
IF wee$ = "1" THEN sbsound% = 1: soundwait% = 3
IF wee$ = "2" THEN sbsound% = 1: soundwait% = 4
IF wee$ = "3" THEN sbsound% = 1: soundwait% = 6
IF wee$ = "4" THEN sbsound% = 1: soundwait% = 10
IF wee$ = "5" THEN sbsound% = 0

IF sbsound% = 1 THEN sbinit

csmallwindow
wee$ = ""
END SUB

SUB setstage
CALL bigwindow
COLOR 15: LOCATE 4, 2: PRINT "Select Stage"
COLOR 7: LOCATE 21, 2: PRINT "Press Spacebar To Select"
COLOR 4
window2d
stagewindow 0
x% = 20: y% = 35

27
IF x% > 0 AND x% < 100 THEN LINE (x% - 9.5, y% - 9.5)-(x% + 9.5, y% + 9.5), 12, B
IF x% = 20 AND y% = 35 THEN Slot% = 1
IF x% = 50 AND y% = 35 THEN Slot% = 2
IF x% = 80 AND y% = 35 THEN Slot% = 3
IF x% = 20 AND y% = 65 THEN Slot% = 4
IF x% = 50 AND y% = 65 THEN Slot% = 5
IF x% = 80 AND y% = 65 THEN Slot% = 6

SELECT CASE stageset%
CASE IS = 0: stagepage% = 1
CASE IS = 6: stagepage% = 2
CASE IS = 12: stagepage% = 3
CASE IS = 18: stagepage% = 4

END SELECT
IF rez% > 7 THEN
LOCATE 4, 64: PRINT "Page"; stagepage%; "Stage"; stageset% + Slot%
ELSE
LOCATE 4, 32: PRINT stagepage%; "/"; stageset% + Slot%
END IF

'Display Stage Name
setstagename (Slot% + stageset%)
LOCATE 22, 2: PRINT stagename$


wee$ = INKEY$
IF wee$ <> "" THEN LINE (x% - 9.5, y% - 9.5)-(x% + 9.5, y% + 9.5), 0, B

IF stageset% > 0 THEN arrow1% = 1: c% = 12 ELSE arrow1% = 0: c% = 0
LINE (5, 50)-(8, 40), c%
LINE (5, 50)-(8, 60), c%
LINE (8, 40)-(8, 60), c%

IF stageset% < 12 THEN arrow2% = 1: c% = 12 ELSE arrow2% = 0: c% = 0
LINE (95, 50)-(92, 40), c%
LINE (95, 50)-(92, 60), c%
LINE (92, 40)-(92, 60), c%


IF wee$ = CHR$(0) + "K" OR wee$ = "4" THEN
 IF x% = 20 THEN
 IF arrow1% = 1 THEN stageset% = stageset% - 6: x% = 80: stagewindow 1
 ELSE
 x% = x% - 30
 END IF
END IF

IF wee$ = CHR$(0) + "M" OR wee$ = "6" THEN
 IF x% = 80 THEN
 IF arrow2% = 1 THEN stageset% = stageset% + 6: x% = 20: stagewindow 2
 ELSE
 x% = x% + 30
 END IF
END IF

IF wee$ = CHR$(0) + "P" OR wee$ = "5" OR wee$ = "2" THEN IF y% = 35 THEN y% = 65
IF wee$ = CHR$(0) + "H" OR wee$ = "8" THEN IF y% = 65 THEN y% = 35


IF y% < 35 THEN y% = 35
IF y% > 65 THEN y% = 65

IF wee$ = " " OR wee$ = CHR$(13) THEN
stage% = stageset% + Slot%
stageinit
setfightercpu
END IF

IF wee$ <> CHR$(27) AND wee$ <> " " AND wee$ <> CHR$(13) THEN 27

window3d
cbigwindow
setstagename (stage%)
END SUB

SUB setstagename (n%)
SELECT CASE n%
CASE 1:    stagename$ = "Demon's Alter           "
CASE 2:    stagename$ = "V-Wing Class B-01       "
CASE 3:    stagename$ = "Elky's Arena            "
CASE 4:    stagename$ = "Jungle Raft Ride        "
CASE 5:    stagename$ = "Defence Complex 10      "
CASE 6:    stagename$ = "Picketed Claustrophobia "
CASE 7:    stagename$ = "Crushing Casket         "
CASE 8:    stagename$ = "Silence                 "
CASE 9:    stagename$ = "Extended Altitude 1     "
CASE 10:   stagename$ = "Pain By The Inch        "
CASE 11:   stagename$ = "79th Street             "
CASE 12:   stagename$ = "Extended Altitude 2     "
CASE 13:   stagename$ = "Rest In Pieces          "
CASE 14:   stagename$ = "Endangered              "
CASE 15:   stagename$ = "Lair Of Demize          "
CASE 16:   stagename$ = "Empty Slot (Stage 16)   "
CASE 17:   stagename$ = "Empty Slot (Stage 17)   "
CASE 18:   stagename$ = "Empty Slot (Stage 18)   "
CASE 1000: stagename$ = "Master Bean's Dojo      "
CASE 1001: stagename$ = "Dojo (Tutorial)         "
CASE 1002: stagename$ = "Dojo (Training)         "
END SELECT
END SUB

SUB setstars

zoomsave = zoom
panxsave = panx
panysave = pany

zoom = 1
panx = 0
pany = 0


CALL smallwindow
LOCATE 10, 2: PRINT "Number of Stars to Display"

LOCATE 12, 2: PRINT "Min | | | |  Med  | | | | Max"

COLOR 4
LOCATE 16, 2: PRINT "Press Spacebar To Save."
s% = nstars%

26
wee$ = INKEY$
IF rez% <> 7 THEN
stars3d 50, -50, 0, 230, 50, .5, 15, 15, 15
stars3d 50, -50, 0, 230, 50, .5, 0, 0, 0
starsoffset -.001, .001
pscube 50, -50, 0, 230, 50, .5, 12, 4, 4
END IF

IF s% = nstars% THEN
COLOR 15
LOCATE 13, 6 + s%: PRINT "^"

ELSE
COLOR 7
LOCATE 13, 6 + s%: PRINT "^"
COLOR 9
LOCATE 13, 6 + nstars%: PRINT "^"
END IF

IF wee$ = "6" OR wee$ = CHR$(0) + "M" OR wee$ = "+" OR wee$ = "=" THEN LOCATE 13, 6 + s%: PRINT " ": s% = s% + 2
IF wee$ = "4" OR wee$ = CHR$(0) + "K" OR wee$ = "-" THEN LOCATE 13, 6 + s%: PRINT " ": s% = s% - 2
IF s% < 0 THEN s% = 0
IF s% > 20 THEN s% = 20
IF wee$ = " " OR wee$ = CHR$(13) THEN LOCATE 13, 6 + nstars%: PRINT " ": nstars% = s%
IF wee$ <> CHR$(27) THEN 26


CALL csmallwindow
wee$ = ""
zoom = zoomsave
panx = panxsave
pany = panysave

END SUB

SUB settings

2 redraw% = 0
bigwindow
COLOR 15, 0
IF rez% = 7 THEN
LOCATE 4, 17: PRINT "SETTINGS"
ELSE
LOCATE 4, 37: PRINT "SETTINGS"
END IF

LOCATE 6, 6: PRINT "Screen Resolution"
LOCATE 8, 6: PRINT "Frame Skipping"
LOCATE 10, 6: PRINT "Game Speed"
LOCATE 12, 6: PRINT "Clear Method"
LOCATE 14, 6: PRINT "Stars"
LOCATE 16, 6: PRINT "Particles"
LOCATE 18, 6: PRINT "i16 Images"
LOCATE 20, 6: PRINT "Graphic Details"
LOCATE 22, 6: PRINT "Sound"

IF ptsettings% = 0 THEN ptsettings% = 6

DO
wee$ = UCASE$(INKEY$)
'----------------------------------------------------------------- Move Arrow
SELECT CASE wee$
CASE IS = "8", CHR$(0) + "H"
LOCATE ptsettings%, 2: PRINT " "
IF ptsettings% > 6 THEN ptsettings% = ptsettings% - 2 ELSE ptsettings% = 22

CASE IS = "5", "2", CHR$(0) + "P"
LOCATE ptsettings%, 2: PRINT " "
IF ptsettings% < 22 THEN ptsettings% = ptsettings% + 2 ELSE ptsettings% = 6
END SELECT
LOCATE ptsettings%, 2: PRINT CHR$(16)

'--------------------------------------------------------------------- Select
IF wee$ = " " OR wee$ = CHR$(13) THEN
redraw% = 1
wee$ = ""

SELECT CASE ptsettings%

CASE IS = 6
setrez

CASE IS = 8
setframeskip

CASE IS = 10
setdelay

CASE IS = 12
setcmethod

CASE IS = 14
setstars

CASE IS = 16
setparticles

CASE IS = 18
seti16

CASE IS = 20
setdetails

CASE IS = 22
setsound

END SELECT
END IF

IF redraw% = 1 THEN 2
LOOP UNTIL wee$ = CHR$(27)
cbigwindow
wee$ = ""
END SUB

SUB smallwindow

SCREEN , 0, 0
COLOR , 0
FOR wee = 0 TO 248 STEP 1
LINE (midx% - wee, midy% - 75)-(midy% + wee, midy% + 75), INT((RND * 2) + 7)
NEXT wee

LINE (midx% - wee, midy% - 75)-(midy% + wee, midy% + 75), 0, BF
LINE (midx% - wee, midy% - 75)-(midy% + wee, midy% + 75), 15, B
END SUB

SUB smear (x%, y%, Z, c%)

IF stage% = 4 THEN EXIT SUB

DO UNTIL exitloop% = 1 OR wee = 10
wee = wee + 1
IF smearl%(wee) = 0 OR smearl%(wee) > 300 THEN
exitloop% = 1
smearl%(wee) = 1
smearc%(wee) = c%
smearx%(wee) = x%
smeary%(wee) = y%
smearz(wee) = Z
END IF
LOOP
END SUB

SUB smearender
FOR wee = 1 TO 10

IF smearl%(wee) > 0 THEN
l = smearl%(wee) / 10
IF l > 5 THEN l = 5
psline (smearx%(wee) - l), (smeary%(wee)), (smearz(wee)), (smearx%(wee) + l), (smeary%(wee)), (smearz(wee)), smearc%(wee), 0
END IF

NEXT wee
END SUB

SUB splash (n)
particle (buttx(n)), (butty(n) + (RND * 20)), (fighterz(n)), 11, 1
particle (buttx(n)), (butty(n) + 20), (fighterz(n)), 12, 1
END SUB

SUB stagebackground

SELECT CASE stage%
'----------------------------------------------------------------------------
CASE IS = 1


'lava
psdline -500, 100, 2, 500, 100, 13, 4, 12, 4, 1
IF stagedetail% = 1 THEN
psdline -375, 100 + bob, 3, 375, 100 - bob, 12, 4, 12, 4, 1
psdline -250, 100 - bob, 4, 250, 100 + bob, 11, 12, 4, 12, 1
psdline -125, 100 + bob, 5, 125, 100 - bob, 10, 4, 12, 4, 1
END IF

'pillar
pscube -15, 15, 7, 15, 100, 8, 7, 8, 8

'steam
stars3d -500, 50, 2, 500, 100, 13, 5, (flash3%), 12
starsoffset 0, -.01

'ring
pscube -200, 0, 5, 200, 15, 10, 7, 7, 7

FOR wee = -100 TO 100 STEP 100
psdpset (wee), 0, 5.1, 9.9, 8
NEXT wee
FOR wee = 6.25 TO 9.75 STEP 1.25
psline -199, 0, (wee), 199, 0, (wee), 8, 0
NEXT wee

'alter
pscube -15, -50, 7, 15, 0, 8, 6, 4, 4
IF stagedetail% = 1 THEN
psline -9, -20, 7, 9, -20, 7, 6, 0
psline -6, -35, 7, 0, -12, 7, 6, 0
psline 6, -35, 7, 0, -12, 7, 6, 0
psline -6, -35, 7, 9, -20, 7, 6, 0
psline 6, -35, 7, -9, -20, 7, 6, 0
END IF
pscircle 0, -25, 7, 10, 4

'----------------------------------------------------------------------------
CASE IS = 2

stars2d 7, 7, 15
starsoffset -.01, 0

'far wing
psline -500, -75, 4.5, 100, -75, 6.5, 8, 0
psline -250, -75, 4.5, 100, -75, 6.5, 7, 0

'nose
psline 200, 0, 4, 400, 40, 3.5, 8, 0
psline 200, 0, 3, 400, 40, 3.5, 15, 0

'exhaust
stars3d -900, -25, 2.5, -625, 75, 4, 9, (flash1%), 15

'hull
psdline -600, 75, 2.5, -300, 75, 4.5, 15, 7, 8, 1
psline -300, 75, 4.5, -200, 40, 3.5, 8, 0
psline -300, 75, 2.5, -200, 40, 3.5, 15, 0
psline -200, 40, 3.5, 400, 40, 3.5, 7, 0
FOR wee = -150 TO 150 STEP 50
psdpset (wee), 0, 3, 4, 7
NEXT wee
psdline -200, 0, 3, 200, 0, 4, 15, 7, 8, 1

'cargo area
IF stagedetail% = 1 THEN
psline -800, -150, 3.5, -650, -75, 4.5, 8, 0
psline -800, -150, 3.5, -650, -75, 2.5, 15, 0
psline -800, -150, 3.5, -350, -150, 3.5, 7, 0
psline -350, -150, 3.5, -250, -75, 4.5, 8, 0
psline -350, -150, 3.5, -250, -75, 2.5, 15, 0
END IF
psdline -650, -75, 2.5, -250, -75, 4.5, 15, 7, 8, 1
psdline -650, -75, 2.5, -600, 75, 4.5, 15, 7, 8, 1
psline -250, -75, 4.5, -200, 0, 4, 8, 0
psline -250, -75, 2.5, -200, 0, 3, 15, 0


'----------------------------------------------------------------------------
CASE IS = 3

'horizon
window2d
LINE (0, 50)-(100, 50), 8
window3d


'Ground
psdline -500, 115, 1, 500, 115, 20, 0, 7, 8, 1

'Ceiling
pscube -150, -45, 3, 150, -50, 8, 15, 7, 8

'Floor
pscube -150, 110, 3, 150, 115, 8, 15, 7, 8

'Back Struts
IF stagedetail% = 1 THEN
pscube -145, -45, 7, -125, 110, 7.5, 15, 7, 8
pscube 145, -45, 7, 125, 110, 7.5, 15, 7, 8
END IF

'Ring
pscube -100, 100, 4, 100, 110, 7, 15, 7, 8


FOR wee = -60 TO 60 STEP 40
psdpset (wee), 100, 4, 7, 7
NEXT wee

FOR wee = 4.5 TO 6.5 STEP 1
psline -100, 100, (wee), 100, 100, (wee), 7, 0
NEXT wee

'----------------------------------------------------------------------------
CASE IS = 4

starsoffset -.002, 0

'Trees
IF stagedetail% = 1 THEN

FOR wee = -2000 TO 1000 STEP 1500
psdline wee + wx, -500, 5, wee + wx, 10, 15, 6, 0, 4, 0
NEXT wee

FOR wee = -4000 TO -2000 STEP 1000
psdline wee + 250 + wx, -400, 10, wee + 250 + wx, 0, 20, 6, 0, 4, 0
NEXT wee

FOR wee = -3000 TO 1000 - ticker% STEP 500
psline wee + wx, -400, 25, wee + wx, -700, 1, 2, 0
NEXT wee

FOR wee = -5000 TO 1000 - ticker% STEP 1000
psline wee + wx, -400, 15, wee + wx, -1000, 1, 2, 0
NEXT wee
END IF
'end trees


IF ticker% < 1000 THEN
stars3d -1000 + wx, wy, 2, -500 + wx, 1 + wy, 6, 9, (flash1%), 15
psline -1000 + wx, wy, 6, -1100 + wx, 100 + wy, 6, 1, 0
psline -1000 + wx, wy, 6, 500 + wx, wy, 6, 1, 0
psline 500 + wx, wy, 6, 1000 + wx, wy, 4, 1, 0
psline -2000 + wx, 100 + wy, 6, -1100 + wx, 100 + wy, 6, 1, 0
psline -3000 + wx, 200 + wy, 6, -2000 + wx, 100 + wy, 6, 1, 0
ELSE
psline -2000 + wx, 100 + wy, 6, -1100 + wx, 100 + wy, 6, 1, 0
psline -3000 + wx, 200 + wy, 6, -2000 + wx, 100 + wy, 6, 1, 0
psline -5000 + wx, 200 + wy, 6, -3000 + wx, 200 + wy, 6, 1, 0
psline -6500 + wx, 950 + wy, 4, -6000 + wx, 950 + wy, 6, 1, 0
psline -6000 + wx, 950 + wy, 6, -5000 + wx, 950 + wy, 6, 1, 0
psline -5000 + wx, 200 + wy, 6, -5000 + wx, 950 + wy, 6, 1, 0
stars3d -5000 + wx, 200 + wy, 2, -4500 + wx, 201 + wy, 6, 9, (flash1%), 15
stars3d -5700 + wx, 950 + wy, 2, -5000 + wx, 951 + wy, 6, 15, (flash1%), 15
END IF

'raft
psdline -200 - (bob / 5), 30 - bob, 3, 200 - (bob / 5), 30 + bob, 5, 4, 4, 4, 1
psdline -200 + (bob / 5), -bob, 3, -200 - (bob / 5), 30 - bob, 5, 4, 4, 4, 0
psdline 200 - (bob / 5), 30 + bob, 3, 200 + (bob / 5), bob, 5, 4, 4, 4, 0
psdline -200 + (bob / 5), -bob, 3, 200 + (bob / 5), bob, 5, 6, 6, 6, 1
psdline -200 + (bob / 5), -bob, 3.5, 200 + (bob / 5), bob, 4.5, 6, 6, 6, 0
psline -200 + (bob / 5), -bob, 4, 200 + (bob / 5), bob, 4, 6, 0

IF ticker% < 1000 THEN
psline -3000 + wx, 200 + wy, 2, -2000 + wx, 100 + wy, 2, 9, 0
psline -2000 + wx, 100 + wy, 2, -1100 + wx, 100 + wy, 2, 9, 0
psline -1000 + wx, wy, 2, -1100 + wx, 100 + wy, 2, 9, 0
psline -1000 + wx, wy, 2, 500 + wx, wy, 2, 9, 0
psline 500 + wx, wy, 2, 1000 + wx, wy, 4, 9, 0
ELSE
psline -3000 + wx, 200 + wy, 2, -2000 + wx, 100 + wy, 2, 9, 0
psline -2000 + wx, 100 + wy, 2, -1100 + wx, 100 + wy, 2, 9, 0
psline -6500 + wx, 950 + wy, 4, -6000 + wx, 950 + wy, 2, 9, 0
psline -6000 + wx, 950 + wy, 2, -5000 + wx, 950 + wy, 2, 9, 0
psline -5000 + wx, 200 + wy, 2, -5000 + wx, 950 + wy, 2, 9, 0
psline -5000 + wx, 200 + wy, 2, -3000 + wx, 200 + wy, 2, 9, 0
END IF


'----------------------------------------------------------------------------
CASE IS = 5

'horizon
window2d
LINE (0, 50)-(100, 50), 8
window3d

'pads
psdline -200, 0, 5, 200, 0, 15, 15, 7, 8, 1
psdline 400, 0, 5, 800, 0, 15, 15, 7, 8, 1

'-----Ship
IF ticker% < 2100 THEN
'landing gear
psline -60, -25 + wy, 13, -70, wy + trigger1, 13.5, 8, 0
psline 60, -25 + wy, 13, 70, wy + trigger1, 13.5, 8, 0
psline 0, -25 + wy, 10, 0, wy + trigger1, 9 + trigger2, 7, 0

'exhaust
stars3d -90, -85 + wy, 12, -80, -30 + wy, 13, flash1%, 9, flash1%
stars3d 80, -85 + wy, 12, 90, -30 + wy, 13, flash1%, 9, flash1%
starsoffset 0, .005

'left wing
psline -75, -100 + wy, 14, -175, -50 + wy, 14, 8, 0
psline -75, -100 + wy, 10, -175, -50 + wy, 13, 7, 0
psdline -75, -75 + wy, 12, -90, -92.5 + wy, 14, 7, 8, 8, 1
psdpset -175, -50 + wy, 11, 15, 7

'right wing
psline 75, -100 + wy, 14, 175, -50 + wy, 14, 8, 0
psline 75, -100 + wy, 10, 175, -50 + wy, 13, 7, 0
psdline 75, -75 + wy, 12, 90, -92.5 + wy, 14, 7, 8, 8, 1
psdpset 175, -50 + wy, 11, 15, 7

'hull
pscube -75, -100 + wy, 10, 75, -25 + wy, 14, 7, 7, 8

'nose
psline -75, -25 + wy, 10, -25, -40 + wy, 6, 8, 0
psline 75, -25 + wy, 10, 25, -40 + wy, 6, 8, 0
psline -75, -100 + wy, 10, -25, -40 + wy, 6, 7, 0
psline 75, -100 + wy, 10, 25, -40 + wy, 6, 7, 0
psline -25, -40 + wy, 6, 25, -40 + wy, 6, 7, 0
END IF

'building
pscube -800, -300, 2, -400, 0, 15, 15, 7, 8



'----------------------------------------------------------------------------
CASE IS = 6

'Back Wall "X"
IF stagedetail% = 1 THEN
psline -200, -300, 10, 200, 0, 10, 8, 0
psline 200, -300, 10, -200, 0, 10, 8, 0

'Ceiling
pscube -200, -315, 5, 200, -300, 10, 7, 7, 8

'floor
pscube -200, 0, 5, 200, 15, 10, 7, 7, 8

ELSE
'Low detail
'Ceiling
psdline -200, -300, 5, 200, -300, 10, 7, 7, 8, 1
'Floor
psdline -200, 0, 5, 200, 0, 10, 7, 7, 8, 1
END IF

FOR wee = -150 TO 150 STEP 50
psdpset wee, 0, 5, 10, 7
NEXT wee


'Walls and Spikes
IF panx < 0 OR zoom > .07 THEN
 pscube -196, -300, 5.5, -185, -.5, 9.5, 6, 4, 4
 FOR wee = -155 TO -10 STEP 30
 psline -185, (wee) + 15, 8.5, -175, (wee) + 10, 8.5, 8, 0
 psline -185, (wee + 30), 8, -175, (wee) + 25, 8, 7, 0
 NEXT wee
END IF

IF panx >= 0 OR zoom > .07 THEN
 pscube 196, -300, 5.5, 185, -.5, 9.5, 6, 4, 4
 FOR wee = -155 TO -10 STEP 30
 psline 185, (wee) + 15, 8.5, 175, (wee) + 10, 8.5, 8, 0
 psline 185, (wee + 30), 8, 175, (wee) + 25, 8, 7, 0
 NEXT wee
END IF


'----------------------------------------------------------------------------
CASE IS = 7

'Back Wall
IF stagedetail% = 1 THEN
FOR wee = -400 TO 400 STEP 200
psline wee, -300, 10, wee, 0, 10, 8, 0
NEXT wee
END IF

'Ceiling
psdline -400, -300, 5, 400, -300, 10, 15, 7, 8, 0
FOR wee = -400 TO 400 STEP 200
psdpset wee, -300, 5, 10, 7
NEXT wee

'floor
psdline -400, 0, 5, 400, 0, 10, 15, 7, 8, 0
FOR wee = -400 TO 400 STEP 200
psdpset wee, 0, 5, 10, 7
NEXT wee

'Crush Walls
pscube -10 - wx, -300, 5.5, -wx, -.5, 9.5, 6, 4, 4
pscube wx, -300, 5.5, 10 + wx, -.5, 9.5, 6, 4, 4
IF stagedetail% = 1 THEN
psline -wx, -300, 5.5, -wx, -.5, 9.5, 4, 0
psline -wx, -300, 9.5, -wx, -.5, 5.5, 4, 0
psline wx, -300, 5.5, wx, -.5, 9.5, 4, 0
psline wx, -300, 9.5, wx, -.5, 5.5, 4, 0
END IF

'----------------------------------------------------------------------------
CASE IS = 8

'Sky
window2d
LINE (0, 30)-(100, 30), 4
LINE (0, 40)-(100, 40), 4
LINE (0, 46)-(100, 46), 12
LINE (0, 50)-(100, 50), 14
window3d


'Ring
pscube -400, 0, 1, 400, 25, 21, 15, 7, 8

IF stagedetail% = 1 THEN
psdline -320, 0, 3, 320, 0, 19, 8, 7, 8, 1
psdline -240, 0, 5, 240, 0, 17, 8, 7, 8, 1
psdline -160, 0, 7, 160, 0, 15, 8, 7, 8, 1
psdline -80, 0, 9, 80, 0, 13, 8, 7, 8, 1
END IF

'----------------------------------------------------------------------------
CASE IS = 9

'Shocker
psdline -500, 100, 4, 500, 100, 12, flash1%, flash1%, flash1%, 1


'Rear Support
pscube -20, -25, 10, 20, 100, 11, 7, 7, 8

IF stagedetail% = 1 THEN
pscircle 0, 0, 10, 10, 8
psline -300, -trigger1, 6, 300, trigger1, 10, 7, 0
psline -300, -trigger1, 10, 300, trigger1, 6, 7, 0
END IF

'Tilting Ring
psdline -300, -trigger1, 6, 300, trigger1, 10, 15, 7, 8, 1


'----------------------------------------------------------------------------
CASE IS = 10

'Walls
pscube -225, -300, 6, -200, 15, 8, 15, 7, 8
pscube 200, -300, 6, 225, 15, 8, 15, 7, 8

'Top Bar
psdline -200, -300, 6.8, 200, -300, 7.2, 15, 0, 8, 0

'Rear Pendulum
psline wx, -300, 7, wx, -20 - (trigger1 * 10), 7 + trigger1, 7, 0
psline wx, -15 - (trigger1 * 10), 7 + trigger1, wx, -20 - (trigger1 * 10), 6.5 + trigger1, (trigger3), 0
psline wx, -15 - (trigger1 * 10), 7 + trigger1, wx, -20 - (trigger1 * 12), 7.5 + trigger1, (trigger3), 0

'ring
pscube -200, 0, 6, 200, 15, 8, 9, 9, 1
psline -200, 0, 6, 200, 0, 8, 1, 0
psline -200, 0, 8, 200, 0, 6, 1, 0


'----------------------------------------------------------------------------
CASE IS = 11, 12

'rear building
psline -1500, -700, 23, 1500, 0, 23, 8, 1
IF stagedetail% = 1 THEN
FOR wee = -1000 TO 1000 STEP 500
psline wee, -700, 23, wee, 0, 23, 8, 0
NEXT wee
END IF

'Left building
IF stagedetail% = 1 AND panx <= 0 THEN
FOR wee = -15 TO -800 STEP -150
psdline -1000, wee, 9, -400, wee, 17, 9, 1, 1, 1
NEXT wee
END IF
pscube -1000, -800, 9, -400, 0, 17, 15, 7, 8

'Right building
IF panx > -200 THEN pscube 400, -1000, 9, 1500, 0, 17, 9, 1, 1

'center building
pscube -200, -500, 9, 200, 0, 17, 7, 7, 8
'windows
IF stagedetail% = 1 THEN
FOR wee = -15 TO -450 STEP -100
psline -190, wee - 60, 9, 190, wee, 9, 9, 1
psline -200, wee, 10, -200, wee, 16, 1, 0
psline 200, wee, 10, 200, wee, 16, 1, 0
NEXT wee
END IF

psline -200, -500, 9, 200, -500, 17, 7, 0
psline 200, -500, 9, -200, -500, 17, 7, 0



'----------------------------------------------------------------------------
CASE IS = 13, 14

IF trigger1 = 0 OR trigger1 = 15 THEN

'Rear fence
FOR wee = -175 TO 175 STEP 25
psline (wee), (0), (15), (wee), (-35), (15), 7, 0
NEXT wee

'Side fences
FOR wee = 2.5 TO 15 STEP 1
psline (-200), (0), (wee), (-200), (-35), (wee), 7, 0
psline (200), (0), (wee), (200), (-35), (wee), 7, 0
NEXT wee


'High Detail Stuff
IF stagedetail% = 1 THEN
psline (-200), (-20), (15), (200), (-20), (15), 8, 0

psline (-200), (-20), (2.5), (-200), (-20), (3.5), 8, 0
psline (200), (-20), (2.5), (200), (-20), (3.5), 8, 0

psline (-200), (-20), (4.5), (-200), (-20), (15), 8, 0
psline (200), (-20), (4.5), (200), (-20), (15), 8, 0
END IF


'Graves
FOR wee = -165 TO 35 STEP 200
pscube wee, -15, 5, wee + 10, 0, 5.1, 7, 7, 8

'Far Cross
psline wee + 72, -27, 9, wee + 76, 0, 9, 4, 0
psline wee + 80, -20, 9, wee + 66, -19, 9, 4, 0

'Near Cross
psline wee - 22, -27, 7, wee - 26, 0, 7, 4, 0
psline wee - 30, -20, 7, wee - 16, -19, 7, 4, 0

pscube wee + 100, -15, 8, wee + 110, 0, 8.1, 7, 8, 8
psline wee + 50, -15, 10, wee + 60, 0, 10, 7, 1
psline wee + 150, -15, 12, wee + 160, 0, 12, 8, 1
NEXT wee



'---------- Dead Tree
'trunk
psline 120, 0, 4.8, 125, -23, 5, 4, 0
psline 130, 0, 4.2, 120, -60, 5, (trigger2), 0
psline 145, 0, 4.5, 125, -50, 4.9, 4, 0
psline 150, 0, 5, 125, -75, 5, 4, 0
psline 50, (-150 + trigger1), 5, 125, -75, 5, 4, 0
psline 60, (-135 + trigger1), 5, 120, -60, 5, (trigger2), 0
psline 90, (-100 + trigger1), 4.8, 120, -70, 4.5, 4, 0

'Incomming branch
psline 140, (-80 + trigger1), 4, 120, -70, 4.5, 4, 0
psline 150, (-85 + trigger1), 3, 120, -63, 4.9, 4, 0
psline 150, (-85 + trigger1), 3, 128, -65, 5, (trigger2), 0


END IF

'--------------------+


IF stage% = 14 THEN

IF stagedetail% = 1 THEN
'--- Crucifix
'Body
psline -10, 325, 7, 8, 390, 7, 8, 0
psline 10, 325, 7, -8, 390, 7, 8, 0
'Legs
psline -5, 470, 7, 8, 390, 7, 8, 0
psline 5, 470, 7, -8, 390, 7, 8, 0
'Feet
psline 0, 470, 7, 0, 495, 7, 8, 0
'arms
psline -9, 355, 7, -55, 370, 7, 8, 0
psline -100, 345, 7, -30, 370, 7, 8, 0
psline 9, 355, 7, 55, 370, 7, 8, 0
psline 100, 345, 7, 30, 370, 7, 8, 0
END IF

'Room/Ring
psdline -175, 300, 3, -100, 250, 7, 4, 0, 4, 0
psdline 175, 300, 3, 100, 250, 7, 4, 0, 4, 0
pscube -175, 300, 1.5, 175, 500, 7, 12, 4, 4
pscube -100, 495, 3, 100, 500, 5, 15, 7, 8


'Steam
particle (-175 + (RND * 350)), (500), (1.5 + (RND * 1.5)), 15, 1
particle (-175 + (RND * 350)), (500), (5 + (RND * 2)), 15, 1
stars3d -175, 450, 1.5, 175, 500, 7, 7, 8, 7
starsoffset 0, -.005
END IF



'----------------------------------------------------------------------------
CASE IS = 15

IF ticker% < 175 THEN
pscube -250, -300, 1.5, 300, 0, 7, 7, 8, 8
psline -100.5, -100, 7, -99.5, -80, 7, 8, 1
psline -101.5, -100, 7, -98.5, -100, 7, 8, 1
particle -100, -102, 7, 16, 1
ELSE


'Back Room
IF stagedetail% = 1 THEN

FOR wee = -100 TO 100 STEP 50
psline (wee), -40, 30, (wee), 0, 30, 4, 0
NEXT wee
psline 0, -140, 30, 0, -50, 30, 4, 0
psline -25, -70, 30, 25, -70, 30, 4, 0

'Hall and Mats
psline -100, -100, 15, -50, 0, 15, 0, 2
psline 50, -100, 15, 100, 0, 15, 0, 2
psline -50, -100, 15, 50, 0, 15, 4, 1
pscube -50, -100, 10, 50, 0, 15, 4, 4, 8
IF ticker% < 300 THEN psline -400, -100, 10, -175, 0, 10, 0, 2
psline -175, -100, 10, -50, 0, 10, 0, 2
psline 50, -100, 10, 175, 0, 10, 0, 2
psline -50, -100, 10, 50, 0, 10, 4, 1
END IF


'Hallway
IF ticker% < 350 THEN FOR wee = -700 TO -300 STEP 75: psdpset (wee), 0, 3, 6, 8: NEXT wee
pscube -800, -100, 3, -200, 0, 6, 4, 4, 4

'Gate
psdline -202, trigger3, 3.4, -202, trigger3 - 100, 3.8, 8, 8, 8, 0
psdline -202, trigger3, 4.2, -202, trigger3 - 100, 4.6, 8, 8, 8, 0
psdline -203, trigger3, 5, -203, trigger3 - 100, 5.4, 8, 8, 8, 0
psdpset -201.5, trigger3 - 25, 3, 6, 7
psdpset -201.5, trigger3 - 75, 3, 6, 7


'Rear Wall
psline -100, 0, 10, 100, 0, 10, 4, 0
psline -200, -200, 10, 200, -200, 10, 4, 0
psline -100, 0, 10, -200, -200, 10, 4, 0
psline 100, 0, 10, 200, -200, 10, 4, 0


'Rear Corners
psline -100, 0, 10, -200, 0, 6, 4, 0
psline 100, 0, 10, 200, 0, 6, 4, 0
psline -200, -200, 10, -200, 0, 6, 4, 0
psline 200, -200, 10, 200, 0, 6, 4, 0


'Sides
psline -200, -200, 2, -200, -200, 10, 4, 0
psline 200, -200, 2, 200, -200, 10, 4, 0
psline 200, 0, 3, 200, 0, 6, 4, 0


IF stagedetail% = 1 THEN
'--- Circle Symbol
'Outer Circle
psdline -25, 0, 3.5, 25, 0, 6.5, 4, 0, 4, 0
psline -25, 0, 3.5, -50, 0, 4, 4, 0
psline -60, 0, 4.5, -50, 0, 4, 4, 0
psline -60, 0, 4.5, -60, 0, 5.5, 4, 0
psline -25, 0, 6.5, -50, 0, 6, 4, 0
psline -60, 0, 5.5, -50, 0, 6, 4, 0
psline 25, 0, 3.5, 50, 0, 4, 4, 0
psline 60, 0, 4.5, 50, 0, 4, 4, 0
psline 60, 0, 4.5, 60, 0, 5.5, 4, 0
psline 25, 0, 6.5, 50, 0, 6, 4, 0
psline 60, 0, 5.5, 50, 0, 6, 4, 0
'Inner Design
'NS Points
psline 0, 0, 6.5, -20, 0, 5, 4, 0
psline 0, 0, 3.5, -20, 0, 5, 4, 0
psline 0, 0, 6.5, 20, 0, 5, 4, 0
psline 0, 0, 3.5, 20, 0, 5, 4, 0
'EW Points
psline -60, 0, 5, 0, 0, 5.5, 4, 0
psline -60, 0, 5, 0, 0, 4.5, 4, 0
psline 60, 0, 5, 0, 0, 5.5, 4, 0
psline 60, 0, 5, 0, 0, 4.5, 4, 0
END IF

'Ring of Fire
IF RND < .3 THEN
particle -63, -2, 5, 27, 1
particle 63, -2, 5, 27, 1

particle -45, -2, 6.2, 27, 1
particle 45, -2, 6.2, 27, 1
particle -45, -2, 3.7, 27, 1
particle 45, -2, 3.7, 27, 1

particle 0, -2, 7, 27, 1
particle 0, -2, 3, 27, 1

particle -20, -2, 6.8, 27, 1
particle 20, -2, 6.8, 27, 1
particle -20, -2, 3.2, 27, 1
particle 20, -2, 3.2, 27, 1

END IF

END IF

'----------------------------------------------------------------------- Dojo
CASE IS = 1000, 1001, 1002

'Walls
pscube -200, -300, 3, 200, 0, 10, 12, 4, 4

'Weapon Racks
FOR wee = 0 TO 50 STEP 10
psline (-75 - wee), -55, 10, (-75 - wee), -10, 10, 8, 0
psline (75 + wee), -55, 10, (75 + wee), -10, 10, 8, 0
NEXT wee
psline -125, -45, 9.8, -75, -45, 9.8, 7, 0
psline -125, -15, 9.8, -75, -15, 9.8, 7, 0
psline 125, -45, 9.8, 75, -45, 9.8, 7, 0
psline 125, -15, 9.8, 75, -15, 9.8, 7, 0


'Torch Posts
pscube -150, -35, 7, -154, 0, 7.2, 15, 7, 8
pscube 150, -35, 7, 154, 0, 7.2, 15, 7, 8


'fire Pit
starsoffset 0, -.01
psdline -25, 0, 8, 25, 0, 9, 7, 8, 8, 1
stars3d -25, -50, 8, 25, 0, 9, 8, 7, 8

'Fire
particle ((RND - .5) * 25), -5, 8 + RND, 17, 1
particle -152, -40, 7.1, 16, 1
particle 152, -40, 7.1, 16, 1



'----------------------------------------------------------------------------
END SELECT
END SUB

SUB stageforground
SELECT CASE stage%

'----------------------------------------------------------------------------
CASE IS = 2

'far wing
psline -500, -75, 2.5, 100, -75, .5, 7, 0
psline -250, -75, 2.5, 100, -75, .5, 15, 0


'----------------------------------------------------------------------------
CASE IS = 3

'Near Struts
IF stagedetail% = 1 THEN
pscube -145, -45, 3.5, -125, 110, 4, 15, 7, 8
pscube 145, -45, 3.5, 125, 110, 4, 15, 7, 8
END IF

'----------------------------------------------------------------------------
CASE IS = 5

'Missle Launcher
IF stagedetail% = 1 THEN
pscircle 1015 + wx, -7, 3.1, 5, 8
pscircle 1050 + wx, -7, 3, 5, 8
pscircle 1135 + wx, -7, 3, 5, 8
pscube 1125 + wx, -15, 2.3, 1145 + wx, -5, 2.7, 15, 7, 8
pscube 1026 + wx, -15, 2, 1060 + wx, -5, 3, 15, 7, 8
pscube 1035 + wx, -30, 2, 1150 + wx, -16, 3, 15, 7, 8
psline 1015 + wx, -42, 2.5, 1135 + wx, -42, 2.5, 8, 0
psline 1015 + wx, -42, 2.5, 980 + wx, -47.5, 2.5, 8, 0
pscube 1000 + wx, -40, 2, 1025 + wx, -5, 3, 15, 7, 8
pscube 1135 + wx, -55, 2.1, 1145 + wx, -30, 2.9, 15, 7, 8
pscircle 1015 + wx, -7, 1.9, 5, 15
pscircle 1050 + wx, -7, 2, 5, 15
pscircle 1135 + wx, -7, 2, 5, 15

psline 1015 + wx, -47.5, 2.6, 1135 + wx, -47.5, 2.6, 7, 0
psline 1015 + wx, -47.5, 2.6, 980 + wx, -47.5, 2.5, 7, 0
psline 1015 + wx, -54, 2.5, 1135 + wx, -54, 2.5, 15, 0
psline 1015 + wx, -54, 2.5, 980 + wx, -47.5, 2.5, 15, 0
psline 1015 + wx, -47.5, 2.4, 1135 + wx, -47.5, 2.4, 15, 0
psline 1015 + wx, -47.5, 2.4, 980 + wx, -47.5, 2.5, 15, 0
END IF

'----------------------------------------------------------------------------
CASE IS = 6

'Spikes
IF panx < 0 OR zoom > .07 THEN
FOR wee = -155 TO -10 STEP 30
psline -185, (wee) + 15, 7.5, -175, (wee) + 10, 7.5, 7, 0
psline -185, (wee + 30), 7, -175, (wee) + 25, 7, 7, 0
psline -185, (wee) + 15, 6.5, -175, (wee) + 10, 6.5, 15, 0
NEXT wee
END IF

IF panx >= 0 OR zoom > .07 THEN
FOR wee = -155 TO -10 STEP 30
psline 185, (wee) + 15, 7.5, 175, (wee) + 10, 7.5, 7, 0
psline 185, (wee + 30), 7, 175, (wee) + 25, 7, 7, 0
psline 185, (wee) + 15, 6.5, 175, (wee) + 10, 6.5, 15, 0
NEXT wee
END IF



'----------------------------------------------------------------------------
CASE IS = 9

'Near Support
IF stagedetail% = 1 THEN pscircle 0, 0, 6, 10, 8
pscube -20, -25, 5, 20, 100, 6, 15, 7, 8

'----------------------------------------------------------------------------
CASE IS = 10

'Near Pendulum
psline -wx, -300, 7, -wx, -20 - (trigger1 * 10), 7 - trigger1, 7, 0
psline -wx, -15 - (trigger1 * 10), 7 - trigger1, -wx, -20 - (trigger1 * 12), 6.5 - trigger1, (trigger3), 0
psline -wx, -15 - (trigger1 * 10), 7 - trigger1, -wx, -20 - (trigger1 * 10), 7.5 - trigger1, (trigger3), 0


'----------------------------------------------------------------------------
CASE IS = 11

IF zoom > .12 AND stagedetail% = 1 THEN
'Left building
pscube -1500, -800, .1, -400, 0, 3, 15, 7, 8

'center "building"
pscube -200, -500, .1, 200, 0, 3, 15, 7, 8

'Right building
pscube 400, -1000, .1, 800, 0, 3, 15, 7, 8
END IF



'----------------------------------------------------------------------------
CASE IS = 13, 14

IF trigger1 = 0 OR trigger1 = 15 THEN

IF ticker% < 25 AND stage% = 13 THEN psline -100, 0, 4, 100, 55, 4, 0, 2

IF stagedetail% = 1 THEN psline (-200), (-20), (2.5), (200), (-20), (2.5), 8, 0

'rain
rain3d -200, -150, .1, 200, 5, 15, 7, 9, 15, 5
IF ticker% > 400 AND stage% = 13 THEN rain2d 1, 9, 1, .02

'Near fence
FOR wee = -175 TO 175 STEP 25
psline (wee), (0), (2.5), (wee), (-35), (2.5), 15, 0
NEXT wee

END IF



'----------------------------------------------------------------------------
CASE IS = 15

IF ticker% >= 175 THEN
psline -100, 0, 2, 100, 0, 2, 4, 0
psline -200, -200, 2, 200, -200, 2, 4, 0
psline -100, 0, 2, -200, -200, 2, 4, 0
psline 100, 0, 2, 200, -200, 2, 4, 0


'Near Corners
psline -100, 0, 2, -200, 0, 3, 4, 0
psline 100, 0, 2, 200, 0, 3, 4, 0
psline -200, -200, 2, -200, 0, 3, 4, 0
psline 200, -200, 2, 200, 0, 3, 4, 0

END IF

'----------------------------------------------------------------------------
END SELECT
END SUB

SUB stageinit
IF stage% <> 1000 THEN IF stage% < 1 OR stage% > stages% THEN stage% = 1
IF stage% < 50 THEN dif% = stage%: AIactive%(2) = 1 ELSE dif% = 7: AIactive%(2) = 0
IF AIactive%(1) = 1 AND AIactive%(2) = 1 THEN dif% = 5: stage% = INT(RND * 3) + 1: setfightercpu
IF stage% = 15 THEN dif% = 7

ticker% = 0
soundticker% = 20
control% = 0
victory% = 0
camode% = 0
bobm = 0
rebirth% = 0
particleclear

FOR wee = 1 TO 10
smearl%(wee) = 0
NEXT wee

FOR wee = 1 TO 6
projectile%(wee) = 0
NEXT wee

FOR wee = 1 TO 2
setbody (wee)
setko (wee)
win%(wee) = 0
rage(wee) = 0
NEXT wee


SELECT CASE stage%

'---------------------------------------------------------------- Init Stages
CASE IS = 1
startfight% = 100
ring% = 200
midstage = 6

zoom = 1
panx = 0
pany = 75
panh = 0
panv = -1.4
zoomd = -.084
zoomt = .02: 'Smaller = Zoom More

floor1 = 0
floor2 = 120
bob = 15
gravity = 1

wx = 0
wy = 25
wz = 0

trigger1 = 100
trigger2 = 0
trigger3 = 0

fightercompress (1)
fightercompress (2)

setfightercpu

'----------------------------------------------------------------------------
CASE IS = 2
startfight% = 200
ring% = 200
midstage = 3.5

zoom = .3
panx = -1000
pany = 10
panh = 9.9
panv = 0
zoomd = 0
zoomt = .1

floor1 = 0
floor2 = 100
bob = 5

gravity = .5

wx = 0
wy = 25
wz = 0

trigger1 = 0
trigger2 = 0
trigger3 = 0


'----------------------------------------------------------------------------
CASE IS = 3
startfight% = 100
ring% = 100
midstage = 5.5

zoom = .3
panx = 0
pany = -500
panh = 0
panv = 15
zoomd = 0
zoomt = .04

floor1 = 100
floor2 = 110
bob = 5

gravity = 1

wx = 0
wy = 25
wz = 0

trigger1 = 0
trigger2 = 0
trigger3 = 0


'----------------------------------------------------------------------------
CASE IS = 4
startfight% = 125
ring% = 200
midstage = 4

zoom = .6
panx = -2000
pany = 0
panh = 25
panv = 0
zoomd = 0
zoomt = .1

floor1 = 0
floor2 = 500
bob = 3

gravity = 1

wx = 0
wy = 25
wz = 0

trigger1 = 0
trigger2 = 0
trigger3 = 0


'----------------------------------------------------------------------------
CASE IS = 5
startfight% = 100
ring% = 400
midstage = 3.5

zoom = .1
panx = 900
pany = -50
panh = 0
panv = 0
zoomd = .005
zoomt = .045

floor1 = 0
floor2 = 0
bob = 15
gravity = 1

wx = 0
wy = 0
wz = 0

trigger1 = 0
trigger2 = 0
trigger3 = 0


'----------------------------------------------------------------------------
CASE IS = 6
startfight% = 100
ring% = 180
midstage = 7.5

zoom = .01
panx = -175
pany = -100
panh = 0
panv = 2
zoomd = 0
zoomt = .015

floor1 = 0
floor2 = 0
bob = 15
gravity = 1

wx = 0
wy = 0
wz = 0

trigger1 = 0
trigger2 = 0
trigger3 = 0


'----------------------------------------------------------------------------
CASE IS = 7
startfight% = 125
ring% = 100
midstage = 7.5

zoom = .01
panx = 380
pany = -10
panh = 0
panv = 0
zoomd = .001
zoomt = .02

floor1 = 0
floor2 = 0
bob = 0
gravity = 1

wx = 390
wy = -.1
wz = 0

trigger1 = 0
trigger2 = 0
trigger3 = 0


'----------------------------------------------------------------------------
CASE IS = 8
startfight% = 10
ring% = 400
midstage = 10

zoom = .1
panx = 0
pany = -300
panh = 0
panv = 0
zoomd = 0
zoomt = .01

floor1 = 0
floor2 = 25
bob = 0
gravity = 1

wx = 0
wy = 0
wz = 0

trigger1 = 0
trigger2 = 0
trigger3 = 0


'----------------------------------------------------------------------------
CASE IS = 9
startfight% = 50
ring% = 300
midstage = 8

zoom = .08
panx = -400
pany = 50
panh = 20
panv = 0
zoomd = 0
zoomt = .015

floor1 = 100
floor2 = 100
bob = 15
gravity = 1

wx = 0
wy = 0
wz = 0

trigger1 = 0
trigger2 = 0
trigger3 = 0


'----------------------------------------------------------------------------
CASE IS = 10
startfight% = 100
ring% = 200
midstage = 7

zoom = .07
panx = 100
pany = -250
panh = 0
panv = 0
zoomd = 0
zoomt = .015

floor1 = 0
floor2 = 0
bob = 15
gravity = 1

wx = 5
wy = 0
wz = 0

trigger1 = 0
trigger2 = 0
trigger3 = 15



'----------------------------------------------------------------------------
CASE IS = 11
startfight% = 75
ring% = 200
midstage = 7

zoom = .8
panx = 0
pany = -1000
panh = 0
panv = 10
zoomd = -.06
zoomt = .02

floor1 = 0
floor2 = 0
bob = 15
gravity = 1

wx = 0
wy = 0
wz = 0

trigger1 = 0
trigger2 = 0
trigger3 = 0




'----------------------------------------------------------------------------
CASE IS = 12
startfight% = 25
ring% = 200
midstage = 13

'zoom = .8
'panx = 0
'pany = -1000
'panh = 0
'panv = 10
'zoomd = -.06
zoomt = .015

floor1 = -500
floor2 = 0
bob = 15
gravity = 1

wx = 0
wy = 0
wz = 0

trigger1 = 0
trigger2 = 0
trigger3 = 0



'----------------------------------------------------------------------------
CASE IS = 13
startfight% = 25
ring% = 100
midstage = 4

zoom = .1
panx = 0
pany = 0
panh = 0
panv = -2
zoomd = 0
zoomt = .045

floor1 = 50
floor2 = 50
bob = 10
gravity = 1

wx = 0
wy = 0
wz = 0

trigger1 = 0
trigger2 = 12
trigger3 = .001



'----------------------------------------------------------------------------
CASE IS = 14
startfight% = 100
ring% = 100
midstage = 4

'zoom = .1
'panx = 0
'pany = 0
panh = 0
panv = 5
zoomd = .005
zoomt = .045

floor1 = 495
floor2 = 500
bob = 10
gravity = 1

wx = 0
wy = 0
wz = 0

trigger1 = 15
trigger2 = 0
trigger3 = 0



'----------------------------------------------------------------------------
CASE IS = 15

startfight% = 500
ring% = 650
midstage = 4

zoom = .01
panx = -200
pany = -50
panh = 0
panv = 0
zoomd = .01
zoomt = .003

floor1 = -400
floor2 = -400
bob = 10
gravity = 1

wx = 0
wy = 0
wz = 0

trigger1 = 0
trigger2 = 0
trigger3 = -100







'----------------------------------------------------------------------------

'Dojo
CASE IS = 1000
startfight% = 1
ring% = 200
midstage = 6

zoom = .1
panx = 0
pany = -100
panh = 0
panv = .5
zoomd = 0
zoomt = .03

floor1 = 0
floor2 = 0
bob = 15
gravity = 1

wx = 0
wy = 0
wz = 0

trigger1 = 0
trigger2 = 0
trigger3 = 0



'----------------------------------------------------------------------------
END SELECT

fighterinit


END SUB

SUB stageshifting
IF ticker% < 32767 THEN ticker% = ticker% + 1
IF ticker% = 1 OR ticker% = 10 THEN setstagename (stage%): fightername (2)
SELECT CASE stage%


'----------------------------------------------------------------------------
CASE IS = 1

IF trigger1 > 0 THEN trigger1 = trigger1 - 1

IF ticker% = 150 THEN camode% = 1
IF headless%(1) = 0 AND headless%(2) = 0 THEN
 IF health%(2) = 0 THEN camode% = 2
 IF health%(1) = 0 THEN camode% = 3
END IF

FOR wee = 1 TO 2
IF butty(wee) > 75 THEN particle (buttx(wee) + ((RND - .5) * 10)), (foot1y(wee + 2)), (fighterz(wee)), 17, 1: particle (buttx(wee)), (butty(wee) - (RND * 10)), (fighterz(wee)), 18, 1
NEXT wee

'lightning
IF RND < .01 THEN trigger1 = 5
IF trigger1 > 0 THEN
IF RND > .5 THEN pslightning 0, -25, 7, ((RND - .5) * 200), -500, 0, 75, flash1% ELSE pslightning 0, -25, 7, ((RND - .5) * 200), -500, 0, 75, flash2%
END IF

'Pop Fighters
IF ticker% = 100 THEN fighterpop 1: fighterpop 2
IF ticker% < 100 THEN
psline -9 + (RND - .5), -20 + (RND - .5), 7, 9, -20, 7, flash2%, 0
psline -6 + (RND - .5), -35 + (RND - .5), 7, 0, -12, 7, flash2%, 0
psline 6 + (RND - .5), -35 + (RND - .5), 7, 0, -12, 7, flash2%, 0
psline -6 + (RND - .5), -35 + (RND - .5), 7, 9, -20, 7, flash2%, 0
psline 6 + (RND - .5), -35 + (RND - .5), 7, -9, -20, 7, flash2%, 0
pscircle 0 + (RND - .5), -25 + (RND - .5), 7, 10, flash2%
END IF

IF ticker% > 70 AND ticker% < 100 THEN
FOR wee = 1 TO 2
particle headx(wee + 2), heady(wee + 2), fighterz(wee), 15, 3
pslightning 0, -25, 7, headx(wee + 2), heady(wee + 2), fighterz(wee), 25, flash2%
NEXT wee
END IF

'----------------------------------------------------------------------------
CASE IS = 2
IF ticker% = 200 THEN camode% = 1


'----------------------------------------------------------------------------
CASE IS = 3

IF ticker% = 45 THEN camode% = 1
FOR wee = 1 TO 2
IF heady(wee + 2) < -45 THEN heady(wee) = 0: buttv(wee) = 1: health%(wee) = health%(wee) - 5: particle (headx(wee + 2)), (heady(wee + 2)), (fighterz(wee)), 1, 5
NEXT wee

'----------------------------------------------------------------------------
CASE IS = 4

'Camera stuff
IF ticker% = 50 THEN
 camode% = 1
ELSE
 IF butty(2) > 50 THEN camode% = 2
 IF butty(1) > 50 THEN camode% = 3
END IF

'Raft moves with current
IF ticker% < 2637 THEN wx = wx + 2 ELSE wx = wx + .2: wy = wy - .4

'Water splashes
FOR wee = 1 TO 2
IF ticker% < 2300 AND butty(wee) > 25 AND butty(wee) < 35 THEN splash (wee)
IF foot1y(wee + 2) > 950 + wy AND foot1y(wee + 2) < 975 + wy THEN splash wee
NEXT wee

'Raft Splashes when hits water
IF ticker% = 576 OR ticker% = 2626 THEN
gravity = 1
FOR wee = -200 TO 200 STEP 25
particle wee, 0, 5, 11, 1
particle wee, 10, 3, 11, 2
NEXT wee
END IF


'----------------+
IF ticker% < 1500 THEN
'----1st Half

'First drop
IF ticker% > 550 AND ticker% < 575 THEN
wy = wy - 4
IF odds% = 1 THEN particle 100 + (RND * 100), 20, 3, 13, 1: particle 100 + (RND * 100), 20, 5, 13, 2
END IF


'Slope
IF ticker% > 1000 THEN
wy = wy - .2
IF RND < .05 THEN particle (RND * 200), 20, 3, 11, 1: particle (RND * 200), 20, 5, 11, 2
END IF

'----------------+
ELSE
'----2nd Half

'Tilt raft at waterfall
IF ticker% > 2450 AND ticker% < 2625 THEN bobm = 0: bob = bob - .14

'Low G and effects of waterfall
IF ticker% > 2550 AND ticker% < 2625 THEN
gravity = .5
wy = wy - 10
IF RND < .2 THEN particle 200, 0, 3, 12, 1: particle 200, 0, 5, 12, 1
END IF

'Drown PLayers at end
IF foot1y(3) > 1000 + wy AND foot1y(3) > 1000 + wy THEN health%(1) = health%(1) - 1: health%(2) = health%(2) - 1: gravity = .5


'----------------+
END IF
'----------------------------------------------------------------------------
CASE IS = 5

IF ticker% < 75 THEN wx = wx - 10: panh = -8.05 ELSE IF ticker% > 75 AND ticker% < 100 THEN wx = wx - 3
IF ticker% > 100 AND ticker% < 125 THEN panh = panh / 1.06
IF ticker% = 175 THEN camode% = 1

IF ticker% > 1600 THEN wy = wy - .1
IF ticker% > 1625 AND ticker% < 1675 THEN trigger2 = trigger2 + .04
IF ticker% > 1650 AND ticker% < 1700 THEN trigger1 = trigger1 - .5
IF stagedetail% = 1 THEN
IF ticker% > 1800 AND ticker% < 2080 THEN wy = wy - 2: IF RND < .4 THEN particle -85, -85 + wy, 12.5, 8, 1: particle 85, -85 + wy, 12.5, 8, 1
IF ticker% = 2100 THEN particle 0, -85 + wy, 13, 5, 50
END IF

'Wall Stopping
FOR wee = 1 TO 2
IF (buttx(wee)) < -400 THEN buttx(wee) = -400: neckx(wee) = 0: butth(wee) = 0
NEXT wee


'----------------------------------------------------------------------------
CASE IS = 6

IF ticker% = 50 THEN camode% = 1
IF headless%(1) = 0 AND headless%(2) = 0 THEN
 IF health%(2) = 0 THEN camode% = 2
 IF health%(1) = 0 THEN camode% = 3
END IF


FOR wee = 1 TO 2
IF (buttx(wee)) < -ring% THEN buttx(wee) = -ring%: butth(wee) = 0

IF (buttx(wee)) < -ring% + 10 AND butty(wee) > -165 THEN
health%(wee) = health%(wee) - 1
fighterfreeze (wee)
buttv(wee) = -gravity
butth(wee) = butth(wee) + .01
particle (buttx(wee)), (butty(wee) + (RND * necky(wee))), (fighterz(wee)), 4, 1
END IF

IF (buttx(wee)) > ring% THEN buttx(wee) = ring%: butth(wee) = 0

IF (buttx(wee)) > ring% - 10 AND butty(wee) > -165 THEN
health%(wee) = health%(wee) - 1
fighterfreeze (wee)
buttv(wee) = -gravity
butth(wee) = butth(wee) - .01
particle (buttx(wee)), (butty(wee) + (RND * necky(wee))), (fighterz(wee)), 3, 1
END IF

IF heady(wee + 2) < -300 THEN heady(wee) = 0: buttv(wee) = 1: health%(wee) = health%(wee) - 5: particle (headx(wee + 2)), (heady(wee + 2)), (fighterz(wee)), 1, 5
NEXT wee


'----------------------------------------------------------------------------
CASE IS = 7

IF ticker% = 100 THEN camode% = 1
IF wx <= 0 THEN trigger1 = .5
IF wx > ring% THEN trigger1 = -.1
wx = wx + trigger1

FOR wee = 1 TO 2
IF ABS(buttx(wee)) > ABS(wx) AND ABS(butth(wee)) > 1 THEN health%(wee) = health%(wee) - ABS(butth(wee) * 5): particle (buttx(wee)), (heady(wee + 2)), (fighterz(wee)), 1, 5

IF (buttx(wee)) < -wx THEN buttx(wee) = -wx: butth(wee) = 0: neckx(wee) = 0
IF (buttx(wee)) > wx THEN buttx(wee) = wx: butth(wee) = 0: neckx(wee) = 0

'Crush
IF wx < 3 THEN
health%(wee) = health%(wee) - 2
position%(wee) = 1
buttv(wee) = -gravity
IF RND < .5 THEN butty(wee) = butty(wee) + ((RND - .5) * 10)
particle (headx(wee + 2)), (butty(wee)), (fighterz(wee)), 2, 3
particle (headx(wee + 2)), (heady(wee + 2) + (RND * 20)), (fighterz(wee)), 1, 1
END IF

IF heady(wee + 2) < -300 THEN heady(wee) = 0: buttv(wee) = 1: health%(wee) = health%(wee) - 5: particle (headx(wee + 2)), (heady(wee + 2)), (fighterz(wee)), 1, 5
NEXT wee

'----------------------------------------------------------------------------
CASE IS = 8
IF ticker% = 1 THEN camode% = 1
IF ticker% = 40 THEN panv = 0

'----------------------------------------------------------------------------
CASE IS = 9

IF ticker% = 45 THEN : panh = -35: panv = -5
IF ticker% = 55 THEN panh = 0: camode% = 1
IF headless%(1) = 0 AND headless%(2) = 0 THEN
 IF health%(2) = 0 THEN camode% = 2
 IF health%(1) = 0 THEN camode% = 3
END IF

'Shock Jumping
IF butty(1) > 80 OR butty(2) > 80 THEN
 IF buttx(1) - buttx(2) < 100 AND buttx(2) - buttx(1) < 100 THEN
 health%(1) = health%(1) - 2
 health%(2) = health%(2) - 2
 pslightning neckx(3), heady(3) + (RND * 25), fighterz(1), neckx(4), heady(4) + (RND * 25), fighterz(2), 50, flash2%
 END IF
END IF


FOR wee = 1 TO 2
IF position%(wee) < 8 OR position%(wee) > 11 THEN
IF ABS(buttx(wee)) < ABS(ring%) AND foot1y(wee + 2) > ((buttx(wee) * trigger1) / 300) - 2 THEN trigger2 = trigger2 + buttx(wee) / 5000: butth(wee) = butth(wee) + (trigger1 / 2500)
END IF
NEXT wee

trigger2 = trigger2 / 1.05

IF ABS(trigger1) > 75 THEN trigger2 = 0:  IF trigger1 > 0 THEN trigger1 = 75 ELSE trigger1 = -75

trigger1 = trigger1 + trigger2


'----------------------------------------------------------------------------
CASE IS = 10

IF ticker% < 75 THEN panv = 1
IF ticker% = 75 THEN camode% = 1
IF headless%(1) = 0 AND headless%(2) = 0 THEN
 IF health%(2) = 0 THEN camode% = 2
 IF health%(1) = 0 THEN camode% = 3
END IF

trigger2 = trigger2 - .01
trigger1 = trigger1 + trigger2
IF trigger1 < 0 THEN trigger2 = .25: wx = -wx

'Color Change
IF RND < .05 THEN
 SELECT CASE trigger3
 CASE IS = 4: trigger3 = 12
 CASE IS = 12: trigger3 = 15
 END SELECT
END IF

'Hack
IF trigger1 < .5 THEN
 FOR wee = 1 TO 2
  IF butty(wee) > -35 AND ABS(buttx(wee)) < 10 AND position%(wee) <> 8 AND position%(wee) <> 10 THEN
  soundticker% = 0: sbfx 17
  health%(wee) = health%(wee) - 15
  ko(wee) = ko(wee) - 3
  particle (headx(wee + 2)), -20, 7, 1, 10
  particle (headx(wee + 2)), -20, 7, 18, 10
  trigger3 = 4
  buttv(wee) = buttv(wee) - (RND * 3)
  neckx(wee) = neckx(wee) + ((RND - .5) * 5)
  END IF
 NEXT wee
END IF

'Wall Stopping
FOR wee = 1 TO 2
IF ABS(buttx(wee)) > ABS(ring%) AND ABS(butth(wee)) > 1 THEN health%(wee) = health%(wee) - ABS(butth(wee) * 5): particle (buttx(wee)), (heady(wee + 2)), (fighterz(wee)), 1, 5

IF (buttx(wee)) < -ring% THEN buttx(wee) = -ring%: butth(wee) = 0: neckx(wee) = 0
IF (buttx(wee)) > ring% THEN buttx(wee) = ring%: butth(wee) = 0: neckx(wee) = 0
NEXT wee


'----------------------------------------------------------------------------
CASE IS = 11
IF ticker% = 1 THEN ring% = 1500
IF ticker% = 50 THEN camode% = 1
FOR wee = 1 TO 2
IF buttx(wee) < -1500 THEN buttx(wee) = -1500
IF buttx(wee) > 1500 THEN buttx(wee) = 1500
NEXT wee

'----------------------------------------------------------------------------
CASE IS = 12
IF ticker% = 1 THEN camode% = 1

FOR wee = 1 TO 2
IF buttx(wee) < -1500 THEN buttx(wee) = -1500
IF buttx(wee) > 1500 THEN buttx(wee) = 1500
NEXT wee


'Fall Off Building
IF floor1 < 0 THEN
FOR wee = 1 TO 2
IF ABS(buttx(wee)) > 400 THEN butth(wee) = -butth(wee)
IF butty(wee) > floor1 AND ABS(buttx(wee)) < ring% THEN butth(wee) = -butth(wee)

IF butty(wee) > -450 AND butty(wee) < -400 THEN fall (wee)
 IF butty(wee) > -50 THEN
 health%(wee) = 0
 butty(wee) = 0
 buttv(wee) = 0
  decap (wee)
  FOR n% = 1 TO 10
  particle buttx(wee) + ((RND - .5) * 20), -5, fighterz(wee), 2, 1
  smear buttx(wee) + ((RND - .5) * 30), 0, fighterz(wee) + (RND - .5), 12
  NEXT n%
 END IF
NEXT wee

IF butty(1) = 0 AND butty(2) = 0 THEN camode% = 1: floor1 = 0: ring% = 1500
END IF

IF floor1 = 0 AND health%(1) = 100 AND health%(2) = 100 THEN midstage = 7


'----------------------------------------------------------------------------
CASE IS = 13

IF ticker% = 10 THEN
buttv(1) = -15
buttv(2) = -15
FOR wee = -10 TO 10 STEP 2
particle (buttx(1) + wee), 0, 4, 24, 1
particle (buttx(2) + wee), 0, 4, 24, 1
NEXT wee
END IF

IF ticker% = 25 THEN
floor1 = 0
floor2 = 0
camode% = 1
END IF

'Lightning strikes tree
IF ticker% > 399 AND ticker% < 415 THEN
IF ticker% = 400 THEN bgcolor% = 19: trigger1 = 15: trigger2 = 8: blur 5: soundticker% = 0: sbfx 17
pslightning 100 + (RND * 15), -90, 5, 135 + (RND * 15), RND * 5, 5, 50, flash1%
pslightning -300, -200, 5, 140, 0, 5, 50, flash2%
particle 105 + (RND * 35), -(RND * 70), 4.5, 9, 1
particle 115 + (RND * 30), -(RND * 30), 4.5, 15, 1
particle 115 + (RND * 30), -(RND * 50), 4.5, 16, 1
END IF

'Normal Lightning
IF RND < .1 THEN
 IF RND < .3 THEN
  bgcolor% = 1
  n% = ((RND - .5) * 500)
  pslightning (n%), (-300), (5 + (RND * 20)), (n%), (0), (5 + (RND * 20)), (100), (flash2%)
  ELSE
  pslightning ((RND - .5) * 800), (-200), (10 + (RND * 10)), ((RND - .5) * 800), (-200), (10 + (RND * 10)), (75), (flash2%)
 END IF
END IF


'Rain
IF trigger3 < .02 THEN trigger3 = trigger3 + .00001
starsoffset (trigger3 / 8), (trigger3)


'----------------------------------------------------------------------------
CASE IS = 14

IF ticker% < 60 THEN
camode% = 0
panh = -panx / 1000
IF pany > 475 THEN panv = 0
END IF

IF ticker% = 75 THEN camode% = 1
IF ticker% = 75 THEN trigger1 = 1


FOR wee = 1 TO 2
'Burning Feet
IF ABS(buttx(wee)) > 110 AND foot1y(wee + 2) > 495 THEN
IF RND < .1 THEN health%(wee) = health%(wee) - 1
IF RND < .5 THEN particle (buttx(wee) + ((RND - .5) * 5)), (500), (fighterz(wee)), 16, 1
END IF

'Wall Stopping
IF ABS(buttx(wee)) > 175 AND ABS(butth(wee)) > 1 THEN health%(wee) = health%(wee) - ABS(butth(wee) * 5): particle (buttx(wee)), (heady(wee + 2)), (fighterz(wee)), 1, 5
IF (buttx(wee)) < -175 THEN buttx(wee) = -175: butth(wee) = 0: neckx(wee) = 0
IF (buttx(wee)) > 175 THEN buttx(wee) = 175: butth(wee) = 0: neckx(wee) = 0

NEXT wee





'----------------------------------------------------------------------------
CASE IS = 15

IF ticker% <= 450 THEN

IF ticker% = 1 THEN floor1 = 0: floor2 = 0
IF ticker% > 50 AND ticker% < 100 THEN LOCATE 10: COLOR 15: PRINT "This place is rank!"
IF ticker% > 125 AND ticker% < 150 THEN butth(1) = 8
IF ticker% > 175 AND ticker% < 225 THEN LOCATE 10, 65: COLOR 4: PRINT "I smell blood!"
IF ticker% = 175 THEN
midstage = 4.5
panx = -500
panh = 5
buttx(1) = -375
butth(1) = 30
fighterz(1) = 5.5
buttx(2) = 75
END IF
IF ticker% = 400 THEN camode% = 3: zoomd = -.008
IF ticker% > 200 AND ticker% <= 300 THEN trigger3 = trigger3 + 1
IF ticker% > 250 AND ticker% < 350 THEN LOCATE 10, 50: COLOR 4: PRINT "I don't know who you are..."
IF ticker% > 350 AND ticker% < 400 THEN LOCATE 10, 60: COLOR 4: PRINT "But your dead!"
IF ticker% = 450 THEN camode% = 1: zoomt = .02



ELSE

FOR wee = 1 TO 2
'Hit Head On Roof
IF heady(wee + 2) < -200 THEN heady(wee) = 0: buttv(wee) = 2: health%(wee) = health%(wee) - 8: particle (headx(wee + 2)), (heady(wee + 2)), (fighterz(wee)), 18, 20

'Wall Stopping
IF ABS(buttx(wee)) > 200 AND ABS(butth(wee)) > 1 THEN health%(wee) = health%(wee) - ABS(butth(wee) * 5): particle (buttx(wee)), (heady(wee + 2)), (fighterz(wee)), 1, 5
IF (buttx(wee)) < -200 THEN buttx(wee) = -200: butth(wee) = 0: neckx(wee) = 0
IF (buttx(wee)) > 200 THEN buttx(wee) = 200: butth(wee) = 0: neckx(wee) = 0

NEXT wee

END IF

'----------------------------------------------------------------------- Dojo
CASE IS = 1000

IF ticker% = 1 THEN health%(2) = maxhp%(2): ko(2) = 75

IF ticker% >= 0 AND ticker% < 100 THEN
COLOR 15: LOCATE 4
PRINT "Welcome to Master Bean's Dojo."
END IF

IF ticker% = 100 THEN control% = 1

IF ticker% >= 100 AND ticker% < 300 THEN
COLOR 15: LOCATE 4
PRINT "If you would like to learn to fight"
PRINT "come over here and hit me!"
PRINT "Otherwise I'm giving you a tutorial."
END IF

IF ticker% = 300 THEN
 ticker% = 2
 IF health%(2) < maxhp%(2) THEN
 stage% = 1002
 ELSE
 stage% = 1001
 END IF
END IF



'------------------------------------------------------------------- Tutorial
CASE IS = 1001

IF ticker% = 3 THEN hands%(1) = 4: feet%(1) = 1: body%(1) = 2: head%(1) = 4

IF ticker% < 200 THEN
COLOR 15: LOCATE 4
PRINT "Tutorial it is. You're wise to seek"
PRINT "guidance before getting your head removed."
END IF

IF ticker% = 200 THEN panh = 1: zoomd = -.005

IF ticker% >= 200 AND ticker% < 300 THEN
COLOR 15: LOCATE 4
PRINT "My name is Master Bean. I intend to"
PRINT "to teach some basics or kill you trying."
END IF

IF ticker% = 300 THEN panh = 0

IF ticker% >= 300 AND ticker% < 400 THEN
COLOR 15: LOCATE 4
PRINT "Let us begin."
END IF

IF ticker% = 400 THEN panh = -2: control% = 1
IF ticker% = 450 THEN camode% = 2

IF ticker% >= 400 AND ticker% < 500 THEN
COLOR 15: LOCATE 4
PRINT "Try moving around using the Number Pad."
END IF

IF ticker% >= 500 AND ticker% < 700 THEN
COLOR 15: LOCATE 4
PRINT "Try pressing Q or W."
END IF

IF ticker% >= 700 AND ticker% < 900 THEN
COLOR 15: LOCATE 4
PRINT "These are your Punches."
END IF

IF ticker% >= 900 AND ticker% < 1100 THEN
COLOR 15: LOCATE 4
PRINT "A and S are Kicks."
END IF

IF ticker% >= 1100 AND ticker% < 1300 THEN
COLOR 15: LOCATE 4
PRINT "Note that keys 5 and 2 both Crouch."
END IF

IF ticker% >= 1300 AND ticker% < 1500 THEN
COLOR 15: LOCATE 4
PRINT "Try pressing 5 then immediately"
PRINT "press S. This will do a Sweep."
END IF

IF ticker% = 1500 THEN camode% = 1

IF ticker% >= 1500 AND ticker% < 1700 THEN
COLOR 15: LOCATE 4
PRINT "Go ahead and try to sweep me."
PRINT "I won't kill you just yet."
END IF

IF ticker% = 1700 THEN trigger1 = health%(2)

IF ticker% >= 1700 AND ticker% < 1900 THEN
COLOR 15: LOCATE 4
PRINT "Okay, Now I want you to try an Uppercut."
PRINT "Get close and Press 5 then W."
END IF

IF ticker% >= 1900 AND ticker% < 2000 THEN
COLOR 15: LOCATE 4
 IF health%(2) = trigger1 THEN
 PRINT "Come on, hit me!"
 ELSE
 PRINT "Very Nice!"
 END IF
END IF


IF ticker% >= 2000 AND ticker% < 2200 THEN
COLOR 15: LOCATE 4
PRINT "Now I want you to press E."
PRINT "This will put you in Special Mode."
END IF

IF ticker% >= 2200 AND ticker% < 2400 THEN
COLOR 15: LOCATE 4
PRINT "Notice the indicator in the corner"
PRINT "of the screen when you press E."
END IF

IF ticker% >= 2400 AND ticker% < 2600 THEN
COLOR 15: LOCATE 4
PRINT "Now try pressing Q while in"
PRINT "Special Mode to throw Ball Lightning."
END IF

IF ticker% >= 2600 AND ticker% < 3000 THEN
COLOR 15: LOCATE 4
PRINT "Remember that when you do a"
PRINT "Special move you exit Special Mode."
PRINT "Try your other Special Moves by"
PRINT "using other attack keys."
END IF

IF ticker% >= 3000 AND ticker% < 3200 THEN
COLOR 15: LOCATE 4
PRINT "Try doing a Nee Bash."
PRINT "Get close to me and press E then S."
END IF

IF ticker% = 3150 THEN control% = 0: fighterfreeze (1)

IF ticker% = 3200 THEN position%(2) = 86

IF ticker% >= 3250 AND ticker% < 3400 THEN
COLOR 15: LOCATE 4
PRINT "That's for kicking my ass so bad!"
control% = 1
END IF

IF ticker% >= 3400 AND ticker% < 3500 THEN
COLOR 15: LOCATE 4
PRINT "Stand back and watch."
END IF

IF ticker% = 3480 THEN position%(2) = 82: trigger1 = health%(1)

IF ticker% >= 3500 AND ticker% < 3600 THEN
COLOR 15: LOCATE 4
 IF trigger1 > health%(1) THEN
 PRINT "I told you to sand back!"
 ELSE
 PRINT "I'm glad you didn't eat that."
 END IF
END IF

IF ticker% = 3600 THEN rage(1) = 100

IF ticker% >= 3600 AND ticker% < 3800 THEN
COLOR 15: LOCATE 4
PRINT "That was an Energy Blast."
PRINT "I want you to try now. Press D"
END IF

IF ticker% = 3900 THEN control% = 0: camode% = 2

IF ticker% >= 3800 AND ticker% < 4000 THEN
COLOR 15: LOCATE 4
PRINT "The Energy Blast is a type of Super"
PRINT "move. See the bar at the bottom left?"
END IF

IF ticker% >= 4000 AND ticker% < 4200 THEN
COLOR 15: LOCATE 4
PRINT "That is your level of Rage."
PRINT "Your Rage builds at a constant rate."
END IF

IF ticker% >= 4200 AND ticker% < 4400 THEN
COLOR 15: LOCATE 4
PRINT "When your Rage is at it's full you"
PRINT "may release it as a Super like the"
PRINT "Energy Blast."
END IF

IF ticker% >= 4400 AND ticker% < 4600 THEN
COLOR 15: LOCATE 4
PRINT "At the top of the screen are your"
PRINT "Health and Awareness bars."
END IF

IF ticker% >= 4600 AND ticker% < 4800 THEN
COLOR 15: LOCATE 4
PRINT "When your out of Health your Dead."
PRINT "If the Awareness is gone your KO."
END IF

IF ticker% >= 4800 AND ticker% < 5000 THEN
COLOR 15: LOCATE 4
PRINT "...and remember dead people don't"
PRINT "have a chance at Round Two."
END IF

IF ticker% >= 5000 AND ticker% < 5200 THEN
COLOR 15: LOCATE 4
PRINT "At the very top of the screen is"
PRINT "the current cycles per second."
END IF

IF ticker% >= 5200 AND ticker% < 5400 THEN
COLOR 15: LOCATE 4
PRINT "If the indicator is Red, the game"
PRINT "is going too slow or too fast."
END IF

IF ticker% >= 5400 AND ticker% < 5600 THEN
COLOR 15: LOCATE 4
PRINT "You can adjust this by changing"
PRINT "settings in the options menus."
END IF

IF ticker% >= 5600 AND ticker% < 5800 THEN
COLOR 15: LOCATE 4
PRINT "A true warrior knows when to be offensive"
PRINT "and when to be defensive."
END IF

IF ticker% = 5800 THEN control% = 1

IF ticker% >= 5800 AND ticker% < 6200 THEN
COLOR 15: LOCATE 4
PRINT "When you are in Special Mode your"
PRINT "awareness level does not recharge."
PRINT "Futher more, when you preform most"
PRINT "special moves your awareness drops."
END IF

IF ticker% >= 6200 AND ticker% < 6400 THEN
COLOR 15: LOCATE 4
PRINT "A failed attack may actually benefit"
PRINT "your opponent! Be wise choosing your"
PRINT "attacks."
END IF

IF ticker% >= 6400 AND ticker% < 6600 THEN
COLOR 15: LOCATE 4
PRINT "This is the end of the lesson."
PRINT "Prepare for a real fight!"
END IF

IF ticker% = 6600 THEN setfighter: camode% = 1

IF ticker% > 6600 THEN
IF ticker% < 6650 THEN COLOR 15: LOCATE 4: PRINT "End of Lesson!"
elbow1x(2) = 0
elbow1y(2) = -5
hand1x(2) = 0
hand1y(2) = -4
pslightning (hand1x(4)), (hand1y(4)), (midstage), (headx(3)), (heady(3)), (midstage), 50, flash2%
health%(1) = health%(1) - 5
END IF




'Death's and KO's
IF health%(1) <= 0 AND ticker% < 6600 THEN LOCATE 10: PRINT "Shit! Your no better then the rest!": PRINT "Get out of here!"
IF health%(2) <= 0 THEN LOCATE 10: PRINT "Damn the dishonor! I've been beat by my own student!"

IF ko(1) <= 0 THEN
 LOCATE 10
 IF win%(2) < 2 THEN
 PRINT "Get up you wuss! Your better then that!"
 ELSE
 PRINT "Your no fighter! Get out of my dojo!"
 END IF
END IF


'Avoid Projectile
IF projectile%(1) > 0 AND position%(2) = 1 AND projectilex(1) > buttx(2) - 75 AND projectilex(1) < buttx(2) + 75 THEN jump 2, 2


'P2 Health/KO
IF health%(2) < 25 AND position%(1) = 1 THEN position%(2) = 84
IF ko(2) < 25 THEN ko(2) = 25

'Wall Stopping
IF ticker% < 6400 THEN
FOR wee = 1 TO 2
IF ABS(buttx(wee)) > ABS(ring%) AND ABS(butth(wee)) > 1 THEN health%(wee) = health%(wee) - ABS(butth(wee) * 5): particle (buttx(wee)), (heady(wee + 2)), (fighterz(wee)), 1, 5

IF (buttx(wee)) < -ring% THEN buttx(wee) = -ring%: butth(wee) = 0: neckx(wee) = 0
IF (buttx(wee)) > ring% THEN buttx(wee) = ring%: butth(wee) = 0: neckx(wee) = 0
NEXT wee
END IF

'------------------------------------------------------------------- Training
CASE IS = 1002

IF ticker% < 100 THEN
COLOR 15: LOCATE 4
 IF position%(1) > 1 THEN
 IF position%(2) = 1 AND pticker%(2) > 75 THEN position%(2) = 37
 PRINT "Calm Yourself!"
 ELSE
 PRINT "Training Begins."
 END IF
END IF

IF ticker% = 200 THEN camode% = 1: zoomd = -.006: AIactive%(2) = 1

IF ticker% >= 200 AND ticker% < 400 THEN
COLOR 15: LOCATE 4
PRINT "Press Esc when you've had enough."
END IF

'Inc. difficulty
trigger1 = trigger1 + 1
IF trigger1 = 1000 THEN
SCREEN , , 0, 0
trigger1 = 0: LOCATE 4
IF dif% < 10 THEN
dif% = dif% + 1
SELECT CASE INT(RND * 5) + 1
CASE 1: PRINT "I see you didn't come to play games."
CASE 2: PRINT "Alright, let's see what you got!"
CASE 3: PRINT "Your advancing well."
CASE 4: PRINT "Don't back down now."
CASE 5: PRINT "Let me teach you about pain!"
END SELECT
PRINT "(Difficulty Increase)"
ELSE
PRINT "You've had enough training."
END IF
FOR wee = 0 TO 10: wee$ = INKEY$: NEXT wee: wee$ = ""
SLEEP
END IF

'Health/KO
IF health%(1) < 50 AND position%(1) = 1 THEN position%(1) = 84
IF health%(2) < 50 AND position%(2) = 1 THEN position%(2) = 84
IF ko(2) < 25 THEN ko(2) = 25

'Wall Stopping
FOR wee = 1 TO 2
IF ABS(buttx(wee)) > ABS(ring%) AND ABS(butth(wee)) > 1 THEN health%(wee) = health%(wee) - ABS(butth(wee) * 5): particle (buttx(wee)), (heady(wee + 2)), (fighterz(wee)), 1, 5

IF (buttx(wee)) < -ring% THEN buttx(wee) = -ring%: butth(wee) = 0: neckx(wee) = 0
IF (buttx(wee)) > ring% THEN buttx(wee) = ring%: butth(wee) = 0: neckx(wee) = 0
NEXT wee

'Death's and KO's
IF health%(1) <= 5 THEN LOCATE 10: PRINT "Your good for nothing when your dead!"
IF health%(2) <= 5 THEN LOCATE 10: PRINT "The gods must be with you..."

IF ko(1) <= 0 THEN
 LOCATE 10
PRINT "C'Mon grandma throw some punches!"
END IF


'----------------------------------------------------------------------------
END SELECT
END SUB

SUB stagewindow (mode%)

IF mode% = 1 THEN
FOR wee = 10 TO 90 STEP 2
LINE (wee, 25)-(wee + 2, 45), 7, BF
LINE (wee, 65)-(wee + 2, 75), 7, BF
LINE (wee, 25)-(wee - 2, 75), 0, BF
NEXT wee
LINE (wee, 25)-(wee - 2, 75), 0, BF
END IF


IF mode% = 2 THEN
FOR wee = 90 TO 10 STEP -2
LINE (wee, 25)-(wee - 2, 45), 7, BF
LINE (wee, 65)-(wee - 2, 75), 7, BF
LINE (wee, 25)-(wee + 2, 75), 0, BF
NEXT wee
LINE (wee, 25)-(wee + 2, 75), 0, BF
END IF


wee = 0
FOR y = 20 TO 50 STEP 30
FOR x = 5 TO 65 STEP 30
wee = wee + 1
LINE (x + 5, y + 5)-(x + 25, y + 25), 7, B
IF i16m% = 0 THEN i16 x + 6, y + 6, .363, .355, "stage" + STR$((wee + stageset%) * -1)
NEXT x
NEXT y
END SUB

SUB stars2d (c1%, c2%, c3%)
REM-----------------------------------------------Draw stars

WINDOW SCREEN (0, 0)-(1, 1)

FOR wee = 1 TO nstars%
PSET (stars1x(wee), stars1y(wee)), c1%
PSET (stars2x(wee), stars2y(wee)), c2%
PSET (stars3x(wee), stars3y(wee)), c3%
NEXT wee

CALL window3d
END SUB

SUB stars3d (x1, y1, z1, x2, y2, z2, c1%, c2%, c3%)
REM-----------------------------------------------Draw stars

x2 = x2 - x1
y2 = y2 - y1
z2 = z2 - z1

FOR wee = 1 TO nstars%
x3 = x1 + (stars1x(wee) * x2)
y3 = y1 + (stars1y(wee) * y2)
z3 = z1 + (stars1z(wee) * z2)
pspset (x3), (y3), (z3), c1%

x3 = x1 + (stars2x(wee) * x2)
y3 = y1 + (stars2y(wee) * y2)
z3 = z1 + (stars2z(wee) * z2)
pspset (x3), (y3), (z3), c2%

x3 = x1 + (stars3x(wee) * x2)
y3 = y1 + (stars3y(wee) * y2)
z3 = z1 + (stars3z(wee) * z2)
pspset (x3), (y3), (z3), c3%
NEXT wee

END SUB

SUB starsoffset (x, y)
FOR wee = 1 TO nstars%
stars1x(wee) = stars1x(wee) + x
stars2x(wee) = stars2x(wee) + (x + x + x)
stars3x(wee) = stars3x(wee) + (x + x + x + x + x)
stars1y(wee) = stars1y(wee) + y
stars2y(wee) = stars2y(wee) + (y + y + y)
stars3y(wee) = stars3y(wee) + (y + y + y + y + y)

IF x < 0 THEN
 IF stars1x(wee) < 0 THEN stars1x(wee) = 1
 IF stars2x(wee) < 0 THEN stars2x(wee) = 1
 IF stars3x(wee) < 0 THEN stars3x(wee) = 1
ELSE
 IF stars1x(wee) > 1 THEN stars1x(wee) = 0
 IF stars2x(wee) > 1 THEN stars2x(wee) = 0
 IF stars3x(wee) > 1 THEN stars3x(wee) = 0
END IF

IF y < 0 THEN
 IF stars1y(wee) < 0 THEN stars1y(wee) = 1
 IF stars2y(wee) < 0 THEN stars2y(wee) = 1
 IF stars3y(wee) < 0 THEN stars3y(wee) = 1
ELSE
 IF stars1y(wee) > 1 THEN stars1y(wee) = 0
 IF stars2y(wee) > 1 THEN stars2y(wee) = 0
 IF stars3y(wee) > 1 THEN stars3y(wee) = 0
END IF
NEXT wee

END SUB

SUB starsrnd
'-------------------------- Randomize Stars
FOR wee = 1 TO 20
stars1x(wee) = RND
stars1y(wee) = RND
stars1z(wee) = RND
stars2x(wee) = RND
stars2y(wee) = RND
stars2z(wee) = RND
stars3x(wee) = RND
stars3y(wee) = RND
stars3z(wee) = RND
NEXT wee

END SUB

SUB window2d
WINDOW SCREEN (0, 0)-(100, 100)
END SUB

SUB window3d
WINDOW SCREEN (xx1, yy1)-(xx2, yy2)
END SUB

SUB winxwiny

xx1 = midx% - winx
yy1 = midy% - winy
xx2 = midx% + winx
yy2 = midy% + winy
END SUB

