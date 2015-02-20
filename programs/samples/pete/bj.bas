REM M-AZN BLACKJACK
REM May 27, 2005
REM by M-AZN
REM
REM dealer hits on 16, stands on 17.
REM bet*0.5 bonus for blackjack (Ace and value-10 card)
REM when betting, you can press ENTER to bid last bet--
REM unless you cant afford it. double-down doubles your bet for that play.
REM to quit, enter -1 when betting, or enter q or Q at hit/stand/double.
REM ENTER is same as stand. S to stand. H to hit. D to double down.
REM can't split (yet).

startgame:
   'INITIALIZE

   RANDOMIZE TIMER
   heart$ = CHR$(3): diamond$ = CHR$(4): club$ = CHR$(5): spade$ = CHR$(6)
   playerquit = 0
   oldbet = 10
   maxhand = 13
   DIM playercards(maxhand), dealercards(maxhand), deck(52)

   'MAIN LOOP
   DO
      CLS
      playermoney = 500
      GOSUB splashscreen
      GOSUB shuffledeck
      'deckindex = 1
      GOSUB rungame
   LOOP
END

rungame:
   'GAME LOOP
   DO
      COLOR 4: PRINT " "; heart$;
      COLOR 2: PRINT " "; club$;
      COLOR 5: PRINT " "; diamond$;
      COLOR 3: PRINT " "; spade$
      COLOR 7
      playercardindex = 0
      dealercardindex = 0
      done = 0
      BLACKJACK = 0
      GOSUB getbet
      GOSUB getnewhand
      GOSUB printhand
      GOSUB printdealerhand
      GOSUB checkplayerhand
      GOSUB getcommand
      GOSUB comparehands
      IF playermoney = 0 THEN
         GOSUB playerlost
         EXIT DO
      END IF
   LOOP
RETURN

getbet:
   IF oldbet > playermoney THEN oldbet = playermoney
   IF oldbet = 0 THEN oldbet = -1
   DO
      COLOR 10
      PRINT "You have $"; playermoney
      COLOR 7
      PRINT "Your bet (-1 to quit) (ENTER = $"; oldbet; ")";
      INPUT playerbet
      IF playerbet = 0 THEN playerbet = oldbet
   LOOP UNTIL playerbet <= playermoney
   IF playerbet = -1 THEN END
   oldbet = playerbet
   playermoney = playermoney - playerbet
RETURN

getcommand:
   WHILE done = 0
      PRINT "Your hand value: "; playerhandvalue
      PRINT "[H]it [S]tand ";
      IF playercardindex = 2 THEN PRINT "[D]ouble";
      INPUT nkey$
      SELECT CASE nkey$
         CASE "quit", "q", "Q"
            END
         CASE "h"
            GOSUB getnewplayercard
         CASE "s", ""
            done = 1
         CASE "d"
            IF playercardindex = 2 THEN
               IF playermoney >= playerbet THEN
                  playermoney = playermoney - playerbet
                  playerbet = playerbet * 2
                  done = 1
                  GOSUB getnewplayercard
               ELSE
                  PRINT "Not enough money to double down."
               END IF
            END IF
      END SELECT
      GOSUB printhand
      GOSUB checkplayerhand
   WEND
RETURN

shuffledeck:
   'first card
   deck(1) = INT(RND * 52)
   deckindex = 2
   DO
      DO
         cardok = 1
         newcard = INT(RND * 52)
         FOR j = 1 TO (deckindex - 1) STEP 1
            IF newcard = deck(j) THEN
               cardok = 0
               EXIT FOR
            END IF
         NEXT j
      LOOP UNTIL cardok = 1
      deck(deckindex) = newcard
      deckindex = deckindex + 1
   LOOP UNTIL deckindex > 52
   deckindex = 1
   PRINT "* * * DECK SHUFFLED * * *"
RETURN

getnewcard:
   IF deckindex > 52 THEN
      GOSUB shuffledeck
      deckindex = 1
   END IF
   newcard = deck(deckindex)
   deckindex = deckindex + 1
RETURN

getnewplayercard:
   GOSUB getnewcard
   playercardindex = playercardindex + 1
   playercards(playercardindex) = newcard
RETURN

getnewdealercard:
   GOSUB getnewcard
   dealercardindex = dealercardindex + 1
   dealercards(dealercardindex) = newcard
RETURN

getnewhand:
   IF (deckindex > 42) THEN GOSUB shuffledeck
   GOSUB getnewplayercard
   GOSUB getnewdealercard
   GOSUB getnewplayercard
   GOSUB getnewdealercard
RETURN

printhand:
   PRINT "Your cards:"
   FOR i = 1 TO playercardindex
      d = playercards(i) MOD 13 + 1
      s% = playercards(i) \ 13
      GOSUB printcard
   NEXT i
RETURN

printdealerhand:
   PRINT "Dealer cards:"
   FOR i = 1 TO dealercardindex
      d = dealercards(i) MOD 13 + 1
      s% = dealercards(i) \ 13
      IF done = 0 AND i > 1 THEN
      ELSE GOSUB printcard
      END IF
   NEXT i
RETURN

printcard:
   SELECT CASE d
      CASE 1: PRINT "  A ";
      CASE 2 TO 9: PRINT " "; d;
      CASE 10: PRINT d;
      CASE 11: PRINT "  J ";
      CASE 12: PRINT "  Q ";
      CASE 13: PRINT "  K ";
   END SELECT
   REM PRINT "s"; s%
   SELECT CASE s%
      CASE 0
         COLOR 4
         PRINT heart$;
         COLOR 7
      CASE 1
         COLOR 5
         PRINT diamond$;
         COLOR 7
      CASE 2
         COLOR 2
         PRINT club$;
         COLOR 7
      CASE 3
         COLOR 3
         PRINT spade$;
         COLOR 7
   END SELECT
   PRINT
RETURN

checkplayerhand:
   rerun = 0
   acefound = 0
   playerdone = 0
   WHILE playerdone = 0
      playerhandvalue = 0
      FOR i = 1 TO playercardindex
         cardvalue = playercards(i) MOD 13 + 1
         IF cardvalue > 10 THEN cardvalue = 10
         IF cardvalue = 1 AND acefound = 0 THEN
            cardvalue = 11
            acefound = 1
         END IF
         playerhandvalue = playerhandvalue + cardvalue
      NEXT i
      playerdone = 1
      IF playerhandvalue > 21 AND acefound = 0 THEN done = 1
      IF playerhandvalue = 21 THEN
         done = 1
         IF playercardindex = 2 THEN
            COLOR 15: PRINT "BLACKJACK ";
            COLOR 13: PRINT "BLACKJACK ";
            COLOR 11: PRINT "BLACKJACK ";
            COLOR 9: PRINT "BLACKJACK "
            COLOR 7
            BLACKJACK = 1
         END IF
      END IF
      IF playerhandvalue > 21 AND acefound = 1 THEN playerdone = 0
      IF rerun = 1 THEN
         IF playerhandvalue > 21 THEN done = 1
         playerdone = 1
      END IF
      rerun = 1
   WEND
RETURN

checkdealerhand:
   rerun = 0
   acefound = 0
   donehere = 0
   WHILE donehere = 0
      dealerhandvalue = 0
      FOR i = 1 TO dealercardindex
         cardvalue = dealercards(i) MOD 13 + 1
         IF cardvalue > 10 THEN cardvalue = 10
         IF cardvalue = 1 AND acefound = 0 THEN
            cardvalue = 11
            acefound = 1
         END IF
         dealerhandvalue = dealerhandvalue + cardvalue
      NEXT i
      donehere = 1
      IF acefound = 1 AND dealerhandvalue > 21 THEN donehere = 0
      IF rerun = 1 THEN donehere = 1
      rerun = 1
   WEND
RETURN

comparehands:
   GOSUB checkdealerhand
   WHILE dealerhandvalue < 17 AND playerhandvalue <= 21 AND BLACKJACK = 0
      GOSUB getnewdealercard
      GOSUB checkdealerhand
   WEND
   GOSUB printdealerhand
   PRINT "Your hand value "; playerhandvalue
   PRINT "Dealer hand value "; dealerhandvalue
   IF playerhandvalue > 21 THEN
      COLOR 6
      PRINT "You busted"
      COLOR 7
   ELSEIF dealerhandvalue > 21 THEN
      PRINT "Dealer busted"
      GOSUB playerwins
   ELSEIF BLACKJACK = 1 THEN
         COLOR 15
         PRINT "You have Blackjack!"
         COLOR 7
      IF dealerhandvalue = 21 AND dealercardindex = 2 THEN
         COLOR 15
         PRINT "Dealer has Blackjack!"
         COLOR 14
         PRINT "Push"
         COLOR 7
      ELSE
         GOSUB playerwins
      END IF
   ELSEIF dealerhandvalue > playerhandvalue THEN
      COLOR 6
      PRINT "You lost"
      COLOR 7
   ELSEIF dealerhandvalue < playerhandvalue THEN
      PRINT "You won"
      GOSUB playerwins
   ELSEIF dealerhandvalue = playerhandvalue THEN
      COLOR 14
      PRINT "Push"
      COLOR 7
      playermoney = playermoney + playerbet
   END IF
RETURN

playerwins:
   bonus = 0
   IF BLACKJACK = 1 THEN bonus = playerbet / 2
   COLOR 13
   PRINT "You win $"; playerbet + bonus
   IF bonus THEN PRINT " ($"; bonus; "bonus)"
   COLOR 7
   playermoney = playermoney + 2 * playerbet + bonus
RETURN

playerlost:
   PRINT : PRINT "ALL YOUR MONEY ARE BELONG TO US"
   DO
      INPUT "Do you want to play again"; nkey$
      SELECT CASE nkey$
         CASE "n", "N", "no"
            END
         CASE "y", "Y", "yes"
            playerquit = 1
            EXIT DO
      END SELECT
   LOOP
RETURN

splashscreen:
   LOCATE 3, 38
   COLOR 13: PRINT "M-AZN"
   LOCATE 5, 36
   COLOR 1: PRINT "B";
   COLOR 2: PRINT "L";
   COLOR 3: PRINT "A";
   COLOR 4: PRINT "C";
   COLOR 5: PRINT "K";
   COLOR 6: PRINT "J";
   COLOR 7: PRINT "A";
   COLOR 8: PRINT "C";
   COLOR 9: PRINT "K";
   COLOR 7
   PRINT : PRINT
RETURN