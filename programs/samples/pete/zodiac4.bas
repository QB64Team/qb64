SCREEN 7
WIDTH 80
CLS
not$ = "Not enough magic"
title:
DO
CLS
RANDOMIZE TIMER
LOCATE 20, 20
PRINT "Zodiac Battles"
PRINT "Press 'i' for instructions"
PRINT "Press 's' to start game"
PRINT "Press 'z' to view animal data"
PRINT "Press 'w' to view weapon info"
PRINT "Press 'x' to quit now(you cannot quit during a game)"
DO
key$ = INKEY$
LOOP UNTIL key$ = "i" OR key$ = "s" OR key$ = "z" OR key$ = "w" OR key$ = "x"
SELECT CASE key$
 CASE IS = "s"
 GOSUB options
 CASE IS = "i"
 GOSUB instructions
 CASE IS = "z"
 GOSUB animaldata
 CASE IS = "w"
 GOSUB weapond
 CASE IS = "x"
 GOSUB endsection
END SELECT

options:
DO
CLS
DIM r$(13)
RESTORE rDATA
FOR count = 1 TO 13
READ r$(count)
NEXT count
DIM weapon$(7)
RESTORE weaponDATA
FOR count = 1 TO 7
READ weapon$(count)
NEXT count
DO
INPUT "Weapons ON/OFF(y/n):", weaponanswer$
LOOP UNTIL weaponanswer$ = "y" OR weaponanswer$ = "n"
CLS
INPUT "Enter code:", rnumber
IF rnumber < 13 THEN
rname$ = LEFT$(r$(rnumber), 4)
END IF
LOOP WHILE rnumber > 12
IF rnumber <= 0 THEN
rnumber = INT(RND * 13 + 1)
rname$ = LEFT$(r$(rnumber), 4)
END IF
LOCATE 10, 1
PRINT rname$
LOCATE 1, 1
PRINT SPACE$(79)
DO
LOCATE 1, 10
INPUT "Enter code:", rnumber2
IF rnumber2 < 13 THEN
rname2$ = LEFT$(r$(rnumber2), 4)
END IF
LOOP WHILE rnumber2 > 12
IF rnumber2 <= 0 THEN
rnumber2 = INT(RND * 13 + 1)
rname2$ = LEFT$(r$(rnumber2), 4)
END IF
LOCATE 10, 10
PRINT rname2$
LOCATE 1, 1
PRINT SPACE$(79)
LOCATE 10, 6.5
PRINT "vs."
SLEEP
CLS
DO
INPUT "P1 Enter weapon number:", weaponnumber
LOOP UNTIL weaponnumber >= 1 AND weaponnumber <= 7
DO
INPUT "P2 Enter weapon number:", weaponnumber2
LOOP UNTIL weaponnumber2 >= 1 AND weaponnumber2 <= 7
CLS
LOCATE 10, 1
PRINT SPACE$(79)
LOCATE 5, 5
PRINT rname$
LOCATE 5, 20
PRINT rname2$
IF weaponanswer$ = "y" THEN
weaponname$ = LEFT$(weapon$(weaponnumber), 5)
weaponlife = VAL(MID$(weapon$(weaponnumber), 7, 2))
weaponmagic = VAL(MID$(weapon$(weaponnumber), 10, 2))
weaponattack1 = VAL(MID$(weapon$(weaponnumber), 13, 2))
weapondefense = VAL(MID$(weapon$(weaponnumber), 16, 2))
weaponmagdef = VAL(MID$(weapon$(weaponnumber), 19, 2))
weaponname2$ = LEFT$(weapon$(weaponnumber2), 5)
weaponlife2 = VAL(MID$(weapon$(weaponnumber2), 7, 2))
weaponmagic2 = VAL(MID$(weapon$(weaponnumber2), 10, 2))
weaponattack2 = VAL(MID$(weapon$(weaponnumber2), 13, 2))
weapondefense2 = VAL(MID$(weapon$(weaponnumber2), 16, 2))
weaponmagdef2 = VAL(MID$(weapon$(weaponnumber2), 19, 2))
ELSE
weaponname$ = "None"
weaponlife = 0
weaponmagic = 0
weaponattack1 = 0
weapondefense = 0
weaponmagdef = 0
weaponname2$ = "None"
weaponlife2 = 0
weaponmagic2 = 0
weaponattack2 = 0
weapondefense2 = 0
weaponmagdef2 = 0
END IF

LOCATE 1, 1
PRINT "Player 1 use q/w/e/r.............Player 2 use u/i/o/p"


LOCATE 6, 5
PRINT "Weapon:", weaponname$
LOCATE 6, 20
PRINT "Weapon:", weaponname2$

rhp1 = VAL(MID$(r$(rnumber), 5, 3)) + weaponlife
rhp2 = VAL(MID$(r$(rnumber2), 5, 3)) + weaponlife2
magic1 = VAL(MID$(r$(rnumber), 9, 2)) + weaponmagic
magic2 = VAL(MID$(r$(rnumber2), 9, 2)) + weaponmagic2
hattack1 = VAL(MID$(r$(rnumber), 12, 2)) + weaponattack1
hattack2 = VAL(MID$(r$(rnumber2), 12, 2)) + weaponattack2
lattack1 = VAL(MID$(r$(rnumber), 15, 2))
lattack2 = VAL(MID$(r$(rnumber2), 15, 2))
phydef1 = VAL(MID$(r$(rnumber), 18, 1)) + weapondefense
phydef2 = VAL(MID$(r$(rnumber2), 18, 1)) + weapondefense2
magdef1 = VAL(MID$(r$(rnumber), 20, 1)) + weaponmagdef
magdef2 = VAL(MID$(r$(rnumber2), 20, 1)) + weaponmagdef2

IF rname$ = "hors" AND weaponname$ = "bow  " THEN
lattack1 = lattack1 + 1
END IF
IF rname2$ = "hors" AND weaponname2$ = "bow  " THEN
lattack2 = lattack2 + 1
END IF


PLAY "f8 f8 f8 e2"
SELECT CASE rname$
 CASE IS = "ram "
  attack20$ = "/Highrage /Rest /Normal attack"
 CASE IS = "drag"
  attack20$ = "/Rage /DragonCall /Fireball"
 CASE IS = "hors"
  attack20$ = "/Heal /Restore /Race"
 CASE IS = "rat "
  attack20$ = "/Supercharge /Rattack1 /Rattack2"
 CASE IS = "ox  "
  attack20$ = "/Charge /Restore /Highrage"
 CASE IS = "snak"
  attack20$ = "/Venombite /WeakeningPoison /Poison"
 CASE IS = "mnky"
  attack20$ = "/Defend /Defensetrick /Dodge"
 CASE IS = "dog "
  attack20$ = "/Defend /Bark /Followup"
 CASE IS = "tigr"
  attack20$ = "/Rage /Highrage /Catrest"
 CASE IS = "boar"
  attack20$ = "/Rage /Eat /FatSlam"
 CASE IS = "roos"
  attack20$ = "/Call /HyperRoos /Sunrise"
 CASE IS = "hare"
  attack20$ = "/LS1 /LS2 /LS3"
 CASE IS = "ZodM"
  attack20$ = "/Zodiac's Power /Skip Turn /Skip Turn"

END SELECT
SELECT CASE rname2$
 CASE IS = "ram "
  attack21$ = "/Highrage /Rest /Normal attack"
 CASE IS = "drag"
  attack21$ = "/Rage /DragonCall /Fireball"
 CASE IS = "hors"
  attack21$ = "/Heal /Restore /Race"
 CASE IS = "rat "
  attack21$ = "/Supercharge /Rattack1 /Rattack2"
 CASE IS = "ox  "
  attack21$ = "/Charge /Restore /Highrage"
 CASE IS = "snak"
  attack21$ = "/Venombite /WeakeningPoison /Poison"
 CASE IS = "mnky"
  attack21$ = "/Defend /Defensetrick /Dodge"
 CASE IS = "dog "
  attack21$ = "/Defend /Bark /Followup"
 CASE IS = "tigr"
  attack21$ = "/Rage /Highrage /Catrest"
 CASE IS = "boar"
  attack21$ = "/Rage /Eat /FatSlam"
 CASE IS = "roos"
  attack21$ = "/Call /HyperRoos /Sunrise"
 CASE IS = "hare"
  attack21$ = "/LS1 /LS2 /LS3"
 CASE IS = "ZodM"
  attack21$ = "/Zodiac's Power /SkipTurn /SkipTurn"
 END SELECT

DO UNTIL rhp1 < 1 OR rhp2 < 1

LOCATE 20, 5
PRINT "PLAYER 1:normal attack", attack20$
DO
key$ = INKEY$
LOOP UNTIL key$ = "q" OR key$ = "w" OR key$ = "e" OR key$ = "r"
LOCATE 17, 1
PRINT SPACE$(120)

SELECT CASE key$
  CASE IS = "q"
  rhp2 = rhp2 - INT(RND * hattack1 + lattack1 - phydef2)
  LOCATE 17, 1
  PRINT "Normal attack"
  CASE IS = "w"
   SELECT CASE rname$
    CASE IS = "ram "
    hattack1 = hattack1 + 2
    LOCATE 17, 1
    PRINT "Max attack + 2"
    CASE IS = "drag"
     IF magic1 < 4 THEN
     rhp2 = rhp2 - 1
     LOCATE 17, 1
     PRINT "Not enough magic"
     ELSE
    hattack1 = hattack1 + 1
    rhp1 = rhp1 - 3
    magic1 = magic1 - 4
    LOCATE 17, 1
    PRINT "Max atttack + 1"
    
    IF weaponname$ = "wand " THEN
    rhp1 = rhp1 + 4
    END IF

    END IF
    CASE IS = "hors"
     IF magic1 < 5 THEN
     rhp2 = rhp2 - 1
     LOCATE 17, 1
     PRINT "Not enough magic"
     ELSE
    rhp1 = rhp1 + 7
    magic1 = magic1 - 5
    IF weaponname$ = "cape " THEN
    rhp1 = rhp1 + 3
    END IF
    LOCATE 17, 1
    PRINT "Recover 7"
    END IF
    CASE IS = "rat "
     IF magic1 < 50 THEN
     rhp2 = rhp2 - 1
     LOCATE 17, 1
     PRINT "Not enough magic"
     ELSE
    LOCATE 17, 1
    PRINT "Super charge: max attack + 3 and min. attack + 1"
    hattack1 = hattack1 + 3
    lattack1 = lattack1 + 1
    magic1 = magic1 - 50
    END IF
    CASE IS = "ox  "
     IF magic1 < 5 THEN
     rhp2 = rhp2 - 1
     LOCATE 17, 1
     PRINT "Not enough magic"
     ELSE
    LOCATE 17, 1
    PRINT "Min. attack + 1"
    magic1 = magic1 - 5
    lattack1 = lattack1 + 1
    IF weaponname$ = "shiel" THEN
    magic1 = magic1 + 5
    END IF
    END IF
    CASE IS = "snak"
     IF magic1 < 20 THEN
     rhp2 = rhp2 - 1
     LOCATE 17, 1
     PRINT "Not enough magic"
     ELSE
    LOCATE 17, 1
    PRINT "Venom bite. -1 max and min. attack to itself"
    magic1 = magic1 - 20
    lattack1 = lattack1 - 1
    hattack1 = hattack1 - 1
    rhp2 = rhp2 - 15 + magdef2
    IF weaponname$ = "cape " THEN
    hattack1 = hattack1 + 1
    END IF
    END IF
    CASE IS = "mnky"
     IF magic1 < 5 THEN
     rhp2 = rhp2 - 1
     LOCATE 17, 1
     PRINT "Not enough magic"
     ELSE
    magic1 = magic1 - 5
    phydef1 = phydef1 + 1
    rhp1 = rhp1 + 7 - magdef2
    LOCATE 17, 1
    PRINT "Defense +1; Recovers 7 - ", magdef2
    IF weaponname$ = "glove" THEN
    rhp1 = rhp1 + magdef2
    END IF

    END IF
    CASE IS = "dog "
    phydef1 = phydef1 + 2
    LOCATE 17, 1
    PRINT "Defense +2"
    CASE IS = "tigr"
     IF magic1 < 5 THEN
     rhp2 = rhp2 - 1
     LOCATE 17, 1
     PRINT "Not enough magic"
     ELSE
    magic1 = magic1 - 5
    hattack1 = hattack1 + 1
    LOCATE 17, 1
    PRINT "Max attack + 1"
    END IF
    CASE IS = "boar"
     IF magic1 < 2 THEN
     rhp2 = rhp2 - 1
     LOCATE 17, 1
     PRINT "Not enough magic"
     ELSE
    magic1 = magic1 - 2
    hattack1 = hattack1 + 1
    LOCATE 17, 1
    PRINT "Max attack + 1"
    END IF
    CASE IS = "roos"
     IF magic1 < 2 THEN
     rhp2 = rhp2 - 1
     LOCATE 17, 1
     PRINT "Not enough magic"
     ELSE
    magic1 = magic1 - 2
    hattack1 = hattack1 + 1
    phydef1 = phydef1 + 1
    LOCATE 17, 1
    PRINT "Max attack + 1; Defense +1"
    END IF
    CASE IS = "hare"
     IF magic1 < 7 THEN
     rhp2 = rhp2 - 1
     LOCATE 17, 1
     PRINT "Not enough magic"
     ELSE
    magic1 = magic1 - 7
    rhp2 = rhp2 - 7 + magdef2
    LOCATE 17, 1
    END IF
    PRINT "Lucky Strike"
   CASE IS = "ZodM"
    IF magic1 < 10 THEN
    rhp2 = rhp2 - 1
    LOCATE 17, 1
    PRINT "Not enough magic"
    ELSE
   magic1 = magic1 - 10
   e = INT(RND * 4 + 1)
    SELECT CASE e
     CASE IS = 1
     rhp2 = rhp2 - 17 + magdef1
     LOCATE 17, 1
     PRINT "Thunder strikes enemy"
     CASE IS = 2
     IF magdef2 > hattack1 THEN
      LOCATE 17, 1
      PRINT "Opponent's magic defense is too high. Need higher max attack."
      ELSE
    magic1 = magic1 - 10
    rhp2 = rhp2 - hattack1 + magdef2
    phydef1 = phydef1 + 1
    phydef2 = phydef2 - 1
    rhp1 = rhp1 + (hattack1 - magdef2) * 2
    LOCATE 17, 1
    PRINT "Stole defense. Stole hp."
    END IF
     CASE IS = 3
     rhp1 = rhp1 + 12
     LOCATE 17, 1
     PRINT "Recover 12"
     CASE IS = 4
     phydef1 = phydef1 + 2
     PRINT "Defense +2"
     END SELECT
   END IF
   END SELECT


 CASE IS = "e"
  SELECT CASE rname$
   CASE IS = "ram "
    hattack1 = hattack1 - 1
    rhp1 = rhp1 + 10
    LOCATE 17, 1
    PRINT "Recover 10 hp but -1 max attack"
   CASE IS = "drag"
    IF magic1 < 5 THEN
    rhp2 = rhp2 - 1
    LOCATE 17, 1
    PRINT not$
    ELSE
    rhp1 = rhp1 - 10
    magic1 = magic1 - 8
    rain = INT(RND * 3)
       SELECT CASE rain
       CASE IS = 0
       rhp2 = rhp2 + 10 + magdef2
       LOCATE 17, 1
       PRINT "Rain heals opponent"
       CASE IS = 1
       rhp1 = rhp1 + 25 - magdef2
       LOCATE 17, 1
       PRINT "Dragon recovers life"
       CASE IS = 2
       rhp2 = rhp2 - 17 + magdef2
       LOCATE 17, 1
       PRINT "Thunder strikes opponent"
       END SELECT
       END IF
    CASE IS = "hors"
    IF magic1 = 0 THEN
     magic1 = magic1 + 10
     ELSE magic1 = magic1 + 1
     END IF
     LOCATE 17, 1
     PRINT "Magic restore"
    CASE IS = "rat "
    IF magic1 < 10 THEN
    rhp2 = rhp2 - 1
    LOCATE 17, 1
    PRINT not$
    ELSE
     IF magdef2 > hattack1 THEN
      LOCATE 17, 1
      PRINT "Opponent's magic defense is too high. Need higher max attack."
      ELSE
    magic1 = magic1 - 10
    rhp2 = rhp2 - hattack1 + magdef2
    phydef1 = phydef1 + 1
    phydef2 = phydef2 - 1
    rhp1 = rhp1 + (hattack1 - magdef2) * 2
    LOCATE 17, 1
    PRINT "Rat attack 1: Stole defense. Stole hp."
    END IF
    END IF
   CASE IS = "ox  "
   IF magic1 = 0 THEN
   magic1 = magic1 + 5
   LOCATE 17, 1
   PRINT "Magic restore"
   ELSE
   LOCATE 17, 1
   PRINT "Magic restore best works when magic is 0"
   END IF
   CASE IS = "snak"
   IF magic1 < 6 THEN
   LOCATE 17, 1
   PRINT not$
   ELSE
   magic2 = magic2 - 10
   rhp2 = rhp2 - 1
   magic1 = magic1 - 6
   LOCATE 17, 1
   PRINT "Weakening poison"
   END IF
   CASE IS = "mnky"
   IF magic1 < 5 THEN
   LOCATE 17, 1
   PRINT not$
   ELSE
   magic1 = magic1 - 5
   rhp2 = rhp2 - phydef2 - phydef1
   LOCATE 17, 1
   PRINT "Defense trick"
   END IF
   CASE IS = "dog "
   phydef2 = phydef2 - 2
   LOCATE 17, 1
   PRINT "Bark: Opponent's defense drop by 2"
   CASE IS = "tigr"
   IF magic1 < 15 THEN
   LOCATE 17, 1
   PRINT not$
   ELSE
   magic1 = magic1 - 15
   hattack1 = hattack1 + 2
   LOCATE 17, 1
   PRINT "High rage: max attack + 2"
   END IF
   CASE IS = "boar"
   LOCATE 17, 1
   PRINT "EAT"
   rhp1 = rhp1 + 5
   magic1 = magic1 + 5
   CASE IS = "roos"
   IF magic1 < 20 THEN
   LOCATE 17, 1
   PRINT not$
   ELSE
   hattack1 = hattack1 * 2
   LOCATE 17, 1
   PRINT "Hyper Rooster: max attack * 2"
   magic1 = magic1 - 20
   END IF
   CASE IS = "hare"
   IF magic1 < 7 THEN
   LOCATE 17, 1
   PRINT not$
   ELSE
    IF magdef2 < 4 THEN
    LOCATE 17, 1
   PRINT "Lucky Strike2"
   magic1 = magic1 - 7
   rhp2 = rhp2 - 3 + magdef2
   SLEEP 1
   rhp2 = rhp2 - 3 + magdef2
   SLEEP 1
   rhp2 = rhp2 - 3 + magdef2
   ELSE
   LOCATE 17, 1
   PRINT "Opponent's magic defense is too high"
   END IF
   END IF
  END SELECT
  CASE IS = "r"
   SELECT CASE rname$
   CASE IS = "ram "
   LOCATE 17, 1
   PRINT "Normal attack"
   rhp2 = rhp2 - INT(RND * hattack1 + lattack1 - phydef2)
   CASE IS = "drag"
   LOCATE 17, 1
   PRINT "Fireball"
   rhp2 = rhp2 - 9 + magdef2
   rhp1 = rhp1 - 5
   CASE IS = "hors"
    IF magic1 < 10 THEN
    LOCATE 17, 1
    PRINT not$
    ELSE
    LOCATE 17, 1
    PRINT "Race"
    magic1 = magic1 - 10
    rhp2 = rhp2 - 13 + magdef2
    END IF
   CASE IS = "rat "
   IF magic2 < 10 THEN
    LOCATE 17, 1
    PRINT "Opponent have too little magic."
    ELSE
    rhp1 = rhp1 - 10
    magic2 = magic2 - 10 + magdef2
    magic1 = magic1 + 10 - magdef2
    magdef2 = magdef2 - 1
    LOCATE 17, 1
    PRINT "Stole magic; Lower opponent's magic defense"
    END IF
   CASE IS = "ox  "
    IF magic1 < 5 THEN
    LOCATE 17, 1
    PRINT not$
    ELSE
    magic1 = magic1 - 5
    hattack1 = hattack1 + 2
    LOCATE 17, 1
    PRINT "Max attack +2"
    END IF
   CASE IS = "snak"
    IF magic1 < 4 THEN
    LOCATE 17, 1
    PRINT not$
    ELSE
    magic1 = magic1 - 4
     poison = INT(RND * 2 + 1)
     IF poison = 1 THEN
     phydef2 = phydef2 - 1
     LOCATE 17, 1
     PRINT "Poison: Opponent's defense -1"
      ELSE
     magdef2 = magdef2 - 1
     LOCATE 17, 1
     PRINT "Poison: Opponent's magic defense -1"
     END IF
     END IF
    CASE IS = "mnky"
    IF magic1 < 5 THEN
    LOCATE 17, 1
    PRINT not$
    ELSE
    magic1 = magic1 - 5
    LOCATE 17, 1
    PRINT "Dodge: Defense +1; Magic defense +1; Max attack -1"
    phydef1 = phydef1 + 1
    magdef1 = magdef1 + 1
    hattack1 = hattack1 - 1
    END IF
    CASE IS = "dog "
    LOCATE 17, 1
    PRINT "Follower: Copy opponent's normal attack"
    rhp2 = rhp2 - INT(RND * hattack2 + lattack2 - phydef2)
    CASE IS = "tigr"
    hattack1 = hattack1 - 1
    magic1 = magic1 + 8
    LOCATE 17, 1
    PRINT "Cat rest: -1 max attack to itself"
    CASE IS = "boar"
    IF magic1 < 2 THEN
    LOCATE 17, 1
    PRINT not$
    ELSE
    LOCATE 17, 1
    PRINT "Fat Slam: magic cut in half and damage = half of magic"
    rhp2 = rhp2 - INT(magic1 / 2) + magdef2
    magic1 = INT(magic1 / 2)
    END IF
    CASE IS = "roos"
    IF magic1 < 5 THEN
    LOCATE 17, 1
    PRINT not$
    ELSE
     IF rhp1 > 10 THEN
     LOCATE 17, 1
     PRINT "Not sunrise time yet"
     ELSE
     LOCATE 17, 1
     PRINT "Sunrise"
     magic1 = magic1 - 5
     rhp1 = rhp1 - rhp1 + 25
     END IF
     END IF
   CASE IS = "hare"
   luck = INT(RND * 8 + 5)
   IF luck > magic1 THEN
   LOCATE 17, 1
   PRINT not$
   ELSE
   magic1 = magic1 - luck
   rhp2 = rhp2 - luck + magdef2
   END IF

  END SELECT
END SELECT


 LOCATE 10, 1
  PRINT SPACE$(120)
  LOCATE 10, 20
  PRINT "Hp", rhp2
  LOCATE 10, 5
  PRINT "Hp", rhp1
  LOCATE 15, 5
  PRINT "Magic", magic1
  LOCATE 15, 20
  PRINT "Magic", magic2
  IF rhp1 <= 0 OR rhp2 <= 0 THEN EXIT DO


LOCATE 20, 5
PRINT "PLAYER 2:normal attack", attack21$
DO
key2$ = INKEY$
LOOP UNTIL key2$ = "u" OR key2$ = "i" OR key2$ = "o" OR key2$ = "p"
LOCATE 17, 1
PRINT SPACE$(99)

SELECT CASE key2$
  CASE IS = "u"
  rhp1 = rhp1 - INT(RND * hattack2 + lattack2 - phydef1)
  LOCATE 17, 1
  PRINT "Normal attack"
  CASE IS = "i"
   SELECT CASE rname2$
    CASE IS = "ram "
    hattack2 = hattack2 + 2
    LOCATE 17, 1
    PRINT "Max attack + 2"
    CASE IS = "drag"
     IF magic2 < 4 THEN
     rhp1 = rhp1 - 1
     LOCATE 17, 1
     PRINT "Not enough magic"
     ELSE
    hattack2 = hattack2 + 1
    rhp2 = rhp2 - 3
    magic2 = magic2 - 4
    LOCATE 17, 1
    PRINT "Max atttack + 1"
    IF weaponname2$ = "wand " THEN
    rhp2 = rhp2 + 4
    END IF
    END IF
    CASE IS = "hors"
     IF magic2 < 5 THEN
     rhp1 = rhp1 - 1
     LOCATE 17, 1
     PRINT "Not enough magic"
     ELSE
    rhp2 = rhp2 + 7
    magic2 = magic2 - 5
    IF weaponname2$ = "cape " THEN
    rhp1 = rhp1 + 3
    END IF

    LOCATE 17, 1
    PRINT "Recover 7"
    END IF
    CASE IS = "rat "
     IF magic2 < 50 THEN
     rhp1 = rhp1 - 1
     LOCATE 17, 1
     PRINT "Not enough magic"
     ELSE
    LOCATE 17, 1
    PRINT "Super charge: max attack + 3 and min. attack + 1"
    hattack2 = hattack2 + 3
    lattack2 = lattack2 + 1
    magic2 = magic2 - 50
    END IF
    CASE IS = "ox  "
     IF magic2 < 5 THEN
     rhp1 = rhp1 - 1
     LOCATE 17, 1
     PRINT "Not enough magic"
     ELSE
    LOCATE 17, 1
    PRINT "Min. attack + 1"
    magic2 = magic2 - 5
    lattack2 = lattack2 + 1
    IF weaponname$ = "shiel" THEN
    magic1 = magic1 + 5
    END IF

    END IF
    CASE IS = "snak"
     IF magic2 < 20 THEN
     rhp1 = rhp1 - 1
     LOCATE 17, 1
     PRINT "Not enough magic"
     ELSE
    LOCATE 17, 1
    PRINT "Venom bite. -1 max and min. attack to itself"
    magic2 = magic2 - 20
    lattack2 = lattack2 - 1
    hattack2 = hattack2 - 1
    rhp1 = rhp1 - 15 + magdef2
    IF weaponname2$ = "cape " THEN
    hattack2 = hattack2 + 1
    END IF

    END IF
    CASE IS = "mnky"
     IF magic2 < 5 THEN
     rhp1 = rhp1 - 1
     LOCATE 17, 1
     PRINT "Not enough magic"
     ELSE
    magic2 = magic2 - 5
    phydef2 = phydef2 + 1
    rhp2 = rhp2 + 7 - magdef1
    LOCATE 17, 1
    PRINT "Defense +1;Recovers 7 -", magdef1
    IF weaponname2$ = "glove" THEN
    rhp2 = rhp2 + magdef1
    END IF
    END IF
    CASE IS = "dog "
    phydef2 = phydef2 + 2
    LOCATE 17, 1
    PRINT "Defense +2"
    CASE IS = "tigr"
     IF magic2 < 5 THEN
     rhp1 = rhp1 - 1
     LOCATE 17, 1
     PRINT "Not enough magic"
     ELSE
    magic2 = magic2 - 5
    hattack2 = hattack2 + 1
    LOCATE 17, 1
    PRINT "Max attack + 1"
    END IF
    CASE IS = "boar"
     IF magic2 < 2 THEN
     rhp1 = rhp1 - 1
     LOCATE 17, 1
     PRINT "Not enough magic"
     ELSE
    magic2 = magic2 - 2
    hattack2 = hattack2 + 1
    LOCATE 17, 1
    PRINT "Max attack + 1"
    END IF
    CASE IS = "roos"
     IF magic2 < 2 THEN
     rhp1 = rhp1 - 1
     LOCATE 17, 1
     PRINT "Not enough magic"
     ELSE
    magic2 = magic2 - 2
    hattack2 = hattack2 + 1
    phydef2 = phydef2 + 1
    LOCATE 17, 1
    PRINT "Max attack + 1;Defense +1"
    END IF
    CASE IS = "hare"
     IF magic2 < 7 THEN
     rhp1 = rhp1 - 1
     LOCATE 17, 1
     PRINT "Not enough magic"
     ELSE
    magic2 = magic2 - 7
    rhp1 = rhp1 - 7 + magdef1
    LOCATE 17, 1
    PRINT "Lucky Strike"
    END IF
   CASE IS = "ZodM"
    IF magic2 < 10 THEN
    rhp1 = rhp1 - 1
    LOCATE 17, 1
    PRINT "Not enough magic"
    ELSE
   magic2 = magic2 - 10
   e = INT(RND * 4 + 1)
    SELECT CASE e
     CASE IS = 1
     rhp1 = rhp1 - 17 + magdef1
     LOCATE 17, 1
     PRINT "Thunder strikes enemy"
     CASE IS = 2
     IF magdef1 > hattack2 THEN
      LOCATE 17, 1
      PRINT "Opponent's magic defense is too high. Need higher max attack."
      ELSE
    magic2 = magic2 - 10
    rhp1 = rhp1 - hattack2 + magdef1
    phydef2 = phydef2 + 1
    phydef1 = phydef1 - 1
    rhp2 = rhp2 + (hattack2 - magdef1) * 2
    LOCATE 17, 1
    PRINT "Stole defense. Stole hp."
    END IF
     CASE IS = 3
     rhp2 = rhp2 + 12
     LOCATE 17, 1
     PRINT "Recover 12"
     CASE IS = 4
     phydef1 = phydef1 + 2
     PRINT "Defense +2"
     END SELECT
     END IF
      
     
 END SELECT

 CASE IS = "o"
  SELECT CASE rname2$
   CASE IS = "ram "
    hattack2 = hattack2 - 1
    rhp2 = rhp2 + 10
    LOCATE 17, 1
    PRINT "Recover 10 hp but -1 max attack"
   CASE IS = "drag"
    IF magic2 < 5 THEN
    rhp1 = rhp1 - 1
    LOCATE 17, 1
    PRINT not$
    ELSE
    rhp2 = rhp2 - 10
    magic2 = magic2 - 8
    rain = INT(RND * 3)
       SELECT CASE rain
       CASE IS = 0
       rhp1 = rhp1 + 10 + magdef1
       LOCATE 17, 1
       PRINT "Rain heals opponent"
       CASE IS = 1
       rhp2 = rhp2 + 25 - magdef1
       LOCATE 17, 1
       PRINT "Dragon recovers life"
       CASE IS = 2
       rhp1 = rhp1 - 17 + magdef1
       LOCATE 17, 1
       PRINT "Thunder strikes opponent"
       END SELECT
       END IF
    CASE IS = "hors"
    IF magic2 = 0 THEN
     magic2 = magic2 + 10
     ELSE magic2 = magic2 + 1
     END IF
     LOCATE 17, 1
     PRINT "Magic restore"
    CASE IS = "rat "
    IF magic2 < 10 THEN
    rhp1 = rhp1 - 1
    LOCATE 17, 1
    PRINT not$
    ELSE
     IF magdef1 > hattack2 THEN
      LOCATE 17, 1
      PRINT "Opponent's magic defense is too high. Need higher max attack."
      ELSE
    magic2 = magic2 - 10
    rhp1 = rhp1 - hattack2 + magdef1
    phydef2 = phydef2 + 1
    phydef1 = phydef1 - 1
    rhp2 = rhp2 + (hattack2 - magdef1) * 2
    LOCATE 17, 1
    PRINT "Rat attack 1: Stole defense. Stole hp."
    END IF
    END IF
   CASE IS = "ox  "
   IF magic2 = 0 THEN
   magic2 = magic2 + 5
   LOCATE 17, 1
   PRINT "Magic restore"
   ELSE
   LOCATE 17, 1
   PRINT "Magic restore best works when magic is 0"
   END IF
   CASE IS = "snak"
   IF magic2 < 6 THEN
   LOCATE 17, 1
   PRINT not$
   ELSE
   magic1 = magic1 - 10
   rhp1 = rhp1 - 1
   magic2 = magic2 - 6
   LOCATE 17, 1
   PRINT "Weakening poison"
   END IF
   CASE IS = "mnky"
   IF magic2 < 5 THEN
   LOCATE 17, 1
   PRINT not$
   ELSE
   magic2 = magic2 - 5
   rhp1 = rhp1 - phydef1 - phydef2
   LOCATE 17, 1
   PRINT "Defense trick"
   END IF
   CASE IS = "dog "
   phydef1 = phydef1 - 1
   LOCATE 17, 1
   PRINT "Bark: Opponent's defense drop by 2"
   CASE IS = "tigr"
   IF magic2 < 15 THEN
   LOCATE 17, 1
   PRINT not$
   ELSE
   magic2 = magic2 - 15
   hattack2 = hattack2 + 2
   LOCATE 17, 1
   PRINT "High rage: max attack + 2"
   END IF
   CASE IS = "boar"
   LOCATE 17, 1
   PRINT "EAT"
   rhp2 = rhp2 + 5
   magic2 = magic2 + 5
   CASE IS = "roos"
   IF magic2 < 20 THEN
   LOCATE 17, 1
   PRINT not$
   ELSE
   hattack2 = hattack2 * 2
   LOCATE 17, 1
   PRINT "Hyper Rooster: max attack * 2"
   magic2 = magic2 - 20
   END IF
   CASE IS = "hare"
   IF magic2 < 7 THEN
   LOCATE 17, 1
   PRINT not$
   ELSE
    IF magdef1 < 4 THEN
    LOCATE 17, 1
   PRINT "Lucky Strike2"
   magic2 = magic2 - 7
   rhp1 = rhp1 - 3 + magdef1
   SLEEP 1
   rhp1 = rhp1 - 3 + magdef1
   SLEEP 1
   rhp1 = rhp1 - 3 + magdef1
   ELSE
   LOCATE 17, 1
   PRINT "Opponent's magic defense is too high"
   END IF
   END IF
  END SELECT
  CASE IS = "p"
   SELECT CASE rname2$
   CASE IS = "ram "
   LOCATE 17, 1
   PRINT "Normal attack"
   rhp1 = rhp1 - INT(RND * hattack2 + lattack2 - phydef1)
   CASE IS = "drag"
   LOCATE 17, 1
   PRINT "Fireball"
   rhp1 = rhp1 - 9 + magdef1
   rhp2 = rhp2 - 5
   CASE IS = "hors"
    IF magic2 < 10 THEN
    LOCATE 17, 1
    PRINT not$
    ELSE
    LOCATE 17, 1
    PRINT "Race"
    magic2 = magic2 - 10
    rhp1 = rhp1 - 13 + magdef1
    END IF
   CASE IS = "rat "
   IF magic1 < 10 THEN
    LOCATE 17, 1
    PRINT "Opponent have too little magic."
    ELSE

    rhp2 = rhp2 - 10
    magic1 = magic1 - 10 + magdef1
    magic2 = magic2 + 10 - magdef1
    magdef1 = magdef1 - 1
    LOCATE 17, 1
    PRINT "Stole magic; Lower opponent's magic defense"
    END IF
   CASE IS = "ox  "
    IF magic2 < 5 THEN
    LOCATE 17, 1
    PRINT not$
    ELSE
    magic2 = magic2 - 5
    hattack2 = hattack2 + 2
    LOCATE 17, 1
    PRINT "Max attack +2"
    END IF
   CASE IS = "snak"
    IF magic2 < 4 THEN
    LOCATE 17, 1
    PRINT not$
    ELSE
    magic2 = magic2 - 4
     poison = INT(RND * 2 + 1)
     IF poison = 1 THEN
     phydef1 = phydef1 - 1
     LOCATE 17, 1
     PRINT "Poison: Opponent's defense -1"
      ELSE
     magdef1 = magdef1 - 1
     LOCATE 17, 1
     PRINT "Poison: Opponent's magic defense -1"
     END IF
     END IF
    CASE IS = "mnky"
    IF magic2 < 5 THEN
    LOCATE 17, 1
    PRINT not$
    ELSE
    magic2 = magic2 - 5
    LOCATE 17, 1
    PRINT "Dodge: Defense +1; Magic defense +1; Max attack -1"
    phydef2 = phydef2 + 1
    magdef2 = magdef2 + 1
    hattack2 = hattack2 - 1
    END IF
    CASE IS = "dog "
    LOCATE 17, 1
    PRINT "Follower: Copy opponent's normal attack"
    rhp1 = rhp1 - INT(RND * hattack1 + lattack1 - phydef1)
    CASE IS = "tigr"
    hattack2 = hattack2 - 1
    magic2 = magic2 + 8
    LOCATE 17, 1
    PRINT "Cat rest: -1 max attack to itself"
    CASE IS = "boar"
    IF magic2 < 2 THEN
    LOCATE 17, 1
    PRINT not$
    ELSE
    LOCATE 17, 1
    PRINT "Fat Slam: magic cut in half and damage = half of magic"
    rhp1 = rhp1 - INT(magic2 / 2) + magdef1
    magic2 = INT(magic2 / 2)
    END IF
    CASE IS = "roos"
    IF magic2 < 5 THEN
    LOCATE 17, 1
    PRINT not$
    ELSE
     IF rhp2 > 10 THEN
     LOCATE 17, 1
     PRINT "Not sunrise time yet"
     ELSE
     LOCATE 17, 1
     PRINT "Sunrise"
     magic2 = magic2 - 5
     rhp2 = rhp2 - rhp2 + 25
     END IF
     END IF
   CASE IS = "hare"
   luck = INT(RND * 8 + 5)
   IF luck > magic2 THEN
   LOCATE 17, 1
   PRINT not$
   ELSE
   magic2 = magic2 - luck
   rhp1 = rhp1 - luck + magdef1
   END IF

  END SELECT
 
END SELECT
 LOCATE 10, 1
  PRINT SPACE$(120)
  LOCATE 10, 20
  PRINT "Hp", rhp2
  LOCATE 10, 5
  PRINT "Hp", rhp1
  LOCATE 15, 5
  PRINT "Magic", magic1
  LOCATE 15, 20
  PRINT "Magic", magic2
LOOP
IF rhp1 < 1 THEN
LOCATE 18, 1
PRINT "PLAYER 2 wins with", rname2$
ELSE
IF rhp2 < 1 THEN
LOCATE 18, 1
PRINT "PLAYER 1 wins with", rname$
END IF
END IF
SLEEP
LOOP
rDATA:
DATA "ram  40 00 03 04 1 3"
DATA "drag 90 40 02 02 1 1"
DATA "hors 40 10 05 03 1 1"
DATA "rat  20 90 04 02 0 5"
DATA "ox   60  5 07 02 2 1"
DATA "snak 30 30 05 05 0 1"
DATA "mnky 25 50 03 02 3 2"
DATA "dog  35 00 04 04 0 0"
DATA "tigr 50 40 02 06 0 1"
DATA "boar 55 10 03 05 2 0"
DATA "roos 25 40 03 02 1 2"
DATA "hare 22 77 11 00 3 3"
DATA "ZodM 60 50 17 05 2 2"


instructions:
CLS
PLAY "MB<<e4 c4 e4 f8 f8>>"
LOCATE 2, 2
PRINT "INSTRUCTIONS"
PRINT " SELECT animal"
PRINT "  Enter a number from 0 to 12 (0 = random)"
PRINT "  Player 2 select animal"
PRINT " Battling"
PRINT "  For Player 1, use q,w,e,r to select a move for your animal"
PRINT "  For Player 2, use u,i,o,p to select a move for your animal"
PRINT "  q and u is the normal attack for all animals"
PRINT " Damage Calculations"
PRINT "  Normal attack: max. attack * random number(0-1) + min.attack"
PRINT "  - opponent's defense"
PRINT "  Special attacks depend on the move subtract opponent's magic defense"
PRINT "  Most specials cost magic. If not enough magic, does nothing or does"
PRINT "  1 damage"
PRINT " Weapons"
PRINT "  You can select weapons using the numbers 1 - 7. Go to weapon section"
PRINT "  for more details."
PRINT " Winning"
PRINT "  Lower your opponents hp to 0 or less"
PRINT " To Quit"
PRINT "  Press 'x'"
DO
key$ = INKEY$
LOOP UNTIL key$ <> ""
IF key$ <> "" THEN
GOSUB title
END IF

weapond:
CLS
PRINT "WEAPONS"
PRINT "  Here is the weapon data chart:"
PRINT "sword 00 -5 04 02 00"
PRINT "mace  00 -5 03 03 00"
PRINT "wand  10 10 00 00 03"
PRINT "glove 05 05 02 02 02"
PRINT "shiel 05 -9 00 04 02"
PRINT "cape  20 05 00 01 01"
PRINT "bow   10 05 02 01 01"
PRINT "  Here is how you read the chart:"
PRINT "name,+life,+magic,+max attack,+defense,+magicdefense"
PRINT "Weapons don't just do what you see here. There are more secrets"
PRINT "that'll be kept hidden. See if you could NOTICE some of the secrets"
PRINT "during battle. Secrets only work to certain animals and certain weapons"
PRINT "Clue: Usually a secret ativates when you use the first special move(w or i)"
DO
wkey$ = INKEY$
LOOP UNTIL wkey$ <> ""
GOSUB title
animaldata:
DO
DO
CLS
RESTORE rDATA
FOR count = 1 TO 13
READ r$(count)
NEXT count

LOCATE 2, 2
INPUT "Enter Code:", dnumber
LOOP UNTIL 0 < dnumber AND dnumber < 14

dname$ = LEFT$(r$(dnumber), 4)
rhp = VAL(MID$(r$(dnumber), 5, 3))

magic = VAL(MID$(r$(dnumber), 9, 2))

hattack = VAL(MID$(r$(dnumber), 12, 2))

lattack = VAL(MID$(r$(dnumber), 15, 2))

phydef = VAL(MID$(r$(dnumber), 18, 1))

magdef = VAL(MID$(r$(dnumber), 20, 1))

SELECT CASE dname$
 CASE IS = "ram "
  description$ = "Can charge up max attack fast and could heal too."
 CASE IS = "dragon"
  description$ = "Have highest life but low attack. Wide range of magic but hurts itself."
 CASE IS = "hors"
  description$ = "Have good healing skills and a powerful move too."
 CASE IS = "rat "
  description$ = "Really low life but could steal life and stats from opponent."
 CASE IS = "ox  "
  description$ = "High life and depend only on its normal attack."
 CASE IS = "snak"
  description$ = "Great range of poisonous attacks that'll surprise the opponent."
 CASE IS = "mnky"
  description$ = "Very defensive and could use the opponents' defense against them."
 CASE IS = "dog "
  description$ = "Lots of moves that changes defense."
 CASE IS = "tigr"
 description$ = "Start out strong but could get stronger."
 CASE IS = "boar"
 description$ = "The more you eat, the better is your Fat Slam!"
 CASE IS = "roos"
 description$ = "Start out weak but could charge up and could restore full life."
 CASE IS = "hare"
 description$ = "Highest defense and depends on luck"
 CASE IS = "ZodM"
 description$ = "Can only be used if you chose random. Have the strongest moves from animals."
 END SELECT


LOCATE 3, 3
PRINT "Name of animal:", dname$
PRINT "   Max life:", rhp
PRINT "   Max magic:", magic
PRINT "   Max attack:", hattack
PRINT "   Min attack:", lattack
PRINT "   Defense:", phydef
PRINT "   Magic Defense:", magdef
PRINT "                         "
PRINT description$
LOCATE 20, 10
PRINT "Press 'd' to check another animal"
PRINT "Press 'x' to exit"
SLEEP
key$ = INKEY$
LOOP WHILE key$ = "d"
GOSUB title

weaponDATA:
DATA "sword 00 -5 04 02 00"
DATA "mace  00 -5 03 03 00"
DATA "wand  10 10 00 00 03"
DATA "glove 05 05 02 02 02"
DATA "shiel 05 -9 00 04 02"
DATA "cape  20 05 00 01 01"
DATA "bow   10 05 02 01 01"

endsection:
CLS
PRINT "Game created by Paulunknown"
PRINT "Thanks for playing. Please give me some comments on this."
PRINT "                                                          "
PRINT "Also, I wish I could get some graphics in this game but I barely know"
PRINT "the basics of creating pictures. I really need some help on that."
PRINT "                                                                  "
PRINT "Feel free to tell a friend about this or send it to them. This is "
PRINT "probably my first game."
SLEEP
END