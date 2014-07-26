DEFINT A-Z
DECLARE SUB SQUARE (A, B, C)
DECLARE SUB SHOWMAN (A, B, FLAG)
DECLARE SUB SHOWBD ()
DECLARE SUB IO (A, B, X, Y, RESULT)
DECLARE FUNCTION INCHECK (X)
DECLARE SUB MAKEMOVE (A, B, X, Y)
DECLARE SUB KNIGHT (A, B, XX(), YY(), NDX)
DECLARE SUB KING (A, B, XX(), YY(), NDX)
DECLARE SUB QUEEN (A, B, XX(), YY(), NDX)
DECLARE SUB ROOK (A, B, XX(), YY(), NDX)
DECLARE SUB BISHOP (A, B, XX(), YY(), NDX)
DECLARE SUB MOVELIST (A, B, XX(), YY(), NDX)
DECLARE SUB PAWN (A, B, XX(), YY(), NDX)
DECLARE FUNCTION EVALUATE (ID, PRUNE)
DIM SHARED BOARD(0 TO 7, 0 TO 7)
DIM SHARED BESTA(0 TO 7), BESTB(0 TO 7), BESTX(0 TO 7), BESTY(0 TO 7)
DIM SHARED LEVEL, MAXLEVEL, SCORE
DIM SHARED WCKSFLAG, WCQSFLAG, INTFLAG
DIM SHARED WCKSOLD, WCQSOLD
LEVEL = 0
MAXLEVEL = 5 'change this to higher to make it think ahead more
DATA -500,-270,-300,-900,-7500,-300,-270,-500
DATA -100,-100,-100,-100, -100,-100,-100,-100
DATA 0, 0, 0, 0, 0, 0, 0, 0
DATA 0, 0, 0, 0, 0, 0, 0, 0
DATA 0, 0, 0, 0, 0, 0, 0, 0
DATA 0, 0, 0, 0, 0, 0, 0, 0
DATA 100, 100, 100, 100, 100, 100, 100, 100
DATA 500, 270, 300, 900, 5000,300, 270, 500
FOR X = 0 TO 7
 FOR Y = 0 TO 7
  READ Z
  BOARD(X, Y) = Z
 NEXT Y
NEXT X
A = -1
RESULT = 0
CLS
LOCATE , 34
PRINT "QBASIC CHESS"
PRINT
PRINT "    CHESS is a game played between two players on a board of 64 squares."
PRINT " Chess was first invented in its current form in Europe during the late"
PRINT " fifteenth century.  It evolved from much earlier forms invented in India"
PRINT " and Persia."
PRINT "    The pieces are divided into Black and White.  Each player has 16 pieces:"
PRINT " 1 king, 1 queen, 2 rooks, 2 bishops, 2 knights, and 8 pawns.  White makes"
PRINT " the first move.  The players alternate moving one piece at a time.  Pieces"
PRINT " are moved to an unoccupied square, or moved onto a square occupied by an"
PRINT " opponent's piece, capturing it.  When the king is under attack, he is in"
PRINT " CHECK.  The player cannot put his king in check.  The object is to CHECKMATE"
PRINT " the opponent.  This occurs when the king is in check and there is no way to"
PRINT " remove the king from attack."
PRINT "   To move the pieces on the chessboard, type in your move in coordinate"
PRINT " notation, e.g. E2-E4 (not in English notation like P-K4).  To castle, type O-O"
PRINT " to castle kingside or O-O-O to castle queenside like in English notation."
PRINT " To exit the game, type QUIT."
PRINT
PRINT "Press any key to continue."
Z$ = INPUT$(1)
DO
 SCORE = 0
 CALL IO(A, B, X, Y, RESULT)
 CLS
 CALL SHOWBD
 RESULT = EVALUATE(-1, 10000)
 A = BESTA(1)
 B = BESTB(1)
 X = BESTX(1)
 Y = BESTY(1)
LOOP

SUB BISHOP (A, B, XX(), YY(), NDX)
 ID = SGN(BOARD(B, A))
 FOR DXY = 1 TO 7
  X = A - DXY
  Y = B + DXY
  IF X < 0 OR X > 7 OR Y < 0 OR Y > 7 THEN EXIT FOR
  GOSUB 3
  IF BOARD(Y, X) <> 0 THEN EXIT FOR
 NEXT
 FOR DXY = 1 TO 7
  X = A + DXY
  Y = B + DXY
  IF X < 0 OR X > 7 OR Y < 0 OR Y > 7 THEN EXIT FOR
  GOSUB 3
  IF BOARD(Y, X) <> 0 THEN EXIT FOR
 NEXT
 FOR DXY = 1 TO 7
  X = A - DXY
  Y = B - DXY
  IF X < 0 OR X > 7 OR Y < 0 OR Y > 7 THEN EXIT FOR
  GOSUB 3
  IF BOARD(Y, X) <> 0 THEN EXIT FOR
 NEXT
 FOR DXY = 1 TO 7
  X = A + DXY
  Y = B - DXY
  IF X < 0 OR X > 7 OR Y < 0 OR Y > 7 THEN EXIT FOR
  GOSUB 3
  IF BOARD(Y, X) <> 0 THEN EXIT FOR
 NEXT
 EXIT SUB
3 REM
 IF ID <> SGN(BOARD(Y, X)) THEN
  NDX = NDX + 1
  XX(NDX) = X
  YY(NDX) = Y
 END IF
 RETURN
END SUB

FUNCTION EVALUATE (ID, PRUNE)
 DIM XX(0 TO 26), YY(0 TO 26)
 LEVEL = LEVEL + 1
 BESTSCORE = 10000 * ID
 FOR B = 7 TO 0 STEP -1
  FOR A = 7 TO 0 STEP -1
   IF SGN(BOARD(B, A)) <> ID THEN GOTO 1
   IF (LEVEL = 1) THEN CALL SHOWMAN(A, B, 8)
   CALL MOVELIST(A, B, XX(), YY(), NDX)
   FOR I = 0 TO NDX
    X = XX(I)
    Y = YY(I)
    IF LEVEL = 1 THEN
     LOCATE 1, 1
     PRINT "TRYING: "; CHR$(65 + A); 8 - B; "-"; CHR$(65 + X); 8 - Y
     CALL SHOWMAN(X, Y, 8)
    END IF
    OLDSCORE = SCORE
    MOVER = BOARD(B, A)
    TARGET = BOARD(Y, X)
    CALL MAKEMOVE(A, B, X, Y)
    IF (LEVEL < MAXLEVEL) THEN SCORE = SCORE + EVALUATE(-ID, BESTSCORE - TARGET + ID * (8 - ABS(4 - X) - ABS(4 - Y)))
    SCORE = SCORE + TARGET - ID * (8 - ABS(4 - X) - ABS(4 - Y))
    IF (ID < 0 AND SCORE > BESTSCORE) OR (ID > 0 AND SCORE < BESTSCORE) THEN
     BESTA(LEVEL) = A
     BESTB(LEVEL) = B
     BESTX(LEVEL) = X
     BESTY(LEVEL) = Y
     BESTSCORE = SCORE
     IF (ID < 0 AND BESTSCORE >= PRUNE) OR (ID > 0 AND BESTSCORE <= PRUNE) THEN
      BOARD(B, A) = MOVER
      BOARD(Y, X) = TARGET
      SCORE = OLDSCORE
      IF (LEVEL = 1) THEN CALL SHOWMAN(X, Y, 0)
      IF (LEVEL = 1) THEN CALL SHOWMAN(A, B, 0)
      LEVEL = LEVEL - 1
      EVALUATE = BESTSCORE
      EXIT FUNCTION
     END IF
    END IF
    BOARD(B, A) = MOVER
    BOARD(Y, X) = TARGET
    SCORE = OLDSCORE
    IF (LEVEL = 1) THEN CALL SHOWMAN(X, Y, 0)
   NEXT
   IF (LEVEL = 1) THEN CALL SHOWMAN(A, B, 0)
1 NEXT
  NEXT
  LEVEL = LEVEL - 1
  EVALUATE = BESTSCORE
 END FUNCTION

FUNCTION INCHECK (X)
 DIM XX(27), YY(27), NDX
 FOR B = 0 TO 7
  FOR A = 0 TO 7
   IF BOARD(B, A) >= 0 THEN GOTO 6
   CALL MOVELIST(A, B, XX(), YY(), NDX)
   FOR I = 0 TO NDX STEP 1
    X = XX(I)
    Y = YY(I)
    IF BOARD(Y, X) = 5000 THEN
     PRINT "YOU ARE IN CHECK!"
     PRINT " "
     PRINT " "
     INCHECK = 1
     EXIT FUNCTION
    END IF
   NEXT
6 NEXT
  NEXT
  INCHECK = 0
 END FUNCTION

SUB IO (A, B, X, Y, RESULT)
 DIM XX(0 TO 26), YY(0 TO 26)
 CLS
 IF A >= 0 THEN
  IF RESULT < -2500 THEN
   PRINT "I RESIGN"
   SLEEP
   SYSTEM
  END IF
  PIECE = BOARD(Y, X)
  CALL MAKEMOVE(A, B, X, Y)
  PRINT "MY MOVE: "; CHR$(65 + A); 8 - B; "-"; CHR$(65 + X); 8 - Y
  IF PIECE <> 0 THEN
   PRINT "I TOOK YOUR ";
   IF PIECE = 100 THEN PRINT "PAWN"
   IF PIECE = 270 THEN PRINT "KNIGHT"
   IF PIECE = 300 THEN PRINT "BISHOP"
   IF PIECE = 500 THEN PRINT "ROOK"
   IF PIECE = 900 THEN PRINT "QUEEN"
   IF PIECE = 5000 THEN PRINT "KING"
  END IF
  NULL = INCHECK(0)
 END IF
 DO
  CALL SHOWBD
  VIEW PRINT 24 TO 24
  INPUT "YOUR MOVE: ", IN$
  IF UCASE$(IN$) = "QUIT" THEN CLS : END
  IF UCASE$(IN$) = "O-O" OR IN$ = "0-0" THEN
   IF WCKSFLAG <> 0 THEN GOTO 16
   IF BOARD(7, 7) <> 500 THEN GOTO 16
   IF BOARD(7, 6) <> 0 OR BOARD(7, 5) <> 0 THEN GOTO 16
   BOARD(7, 6) = 5000
   BOARD(7, 4) = 0
   BOARD(7, 5) = 500
   BOARD(7, 7) = 0
   WCKSFLAG = -1
   EXIT SUB
  END IF
  IF UCASE$(IN$) = "O-O-O" OR IN$ = "0-0-0" THEN
   IF WCQSFLAG <> 0 THEN GOTO 16
   IF BOARD(7, 0) <> 500 THEN GOTO 16
   IF BOARD(7, 1) <> 0 OR BOARD(7, 2) <> 0 OR BOARD(7, 3) <> 0 THEN GOTO 16
   BOARD(7, 2) = 5000
   BOARD(7, 4) = 0
   BOARD(7, 3) = 500
   BOARD(7, 0) = 0
   WCQSFLAG = -1
   EXIT SUB
  END IF
  IF LEN(IN$) < 5 THEN GOTO 16
  B = 8 - (ASC(MID$(IN$, 2, 1)) - 48)
  A = ASC(UCASE$(MID$(IN$, 1, 1))) - 65
  X = ASC(UCASE$(MID$(IN$, 4, 1))) - 65
  Y = 8 - (ASC(MID$(IN$, 5, 1)) - 48)
  IF B > 7 OR B < 0 OR A > 7 OR A < 0 OR X > 7 OR X < 0 OR Y > 7 OR Y < 0 THEN GOTO 16
  IF BOARD(B, A) <= 0 THEN GOTO 16
  IF Y = 2 AND B = 3 AND (X = A - 1 OR X = A + 1) THEN
    IF BOARD(B, A) = 100 AND BOARD(Y, X) = 0 AND BOARD(Y + 1, X) = -100 THEN
      IF BESTB(1) = 1 AND BESTA(1) = X THEN
        MOVER = BOARD(B, A)
        TARGET = BOARD(Y, X)
        CALL MAKEMOVE(A, B, X, Y)
        BOARD(Y + 1, X) = 0
        ENPASSANT = -1
        GOTO 15
      END IF
    END IF
  END IF
  CALL MOVELIST(A, B, XX(), YY(), NDX)
  FOR K = 0 TO NDX STEP 1
   IF X = XX(K) AND Y = YY(K) THEN
    MOVER = BOARD(B, A)
    TARGET = BOARD(Y, X)
    INTFLAG = -1
    CALL MAKEMOVE(A, B, X, Y)
    IF MOVER = 5000 THEN
      WCQSOLD = WCQSFLAG
      WCKSOLD = WCKSFLAG
      WCKSFLAG = -1
      WCQSFLAG = -1
    END IF
    IF (A = 0) AND (B = 7) AND (MOVER = 500) THEN
      WCQSOLD = WCQSFLAG
      WCQSFLAG = -1
    END IF
    IF (A = 7) AND (B = 7) AND (MOVER = 500) THEN
      WCKSOLD = WCKSFLAG
      WCKSFLAG = -1
    END IF
    INTFLAG = 0
15  IF INCHECK(0) = 0 THEN EXIT SUB
    BOARD(B, A) = MOVER
    BOARD(Y, X) = TARGET
    IF ENPASSANT THEN BOARD(Y + 1, X) = -100: ENPASSANT = 0
    IF (A = 0) AND (B = 7) AND (MOVER = 500) THEN WCQSFLAG = WCQSOLD
    IF (A = 7) AND (B = 7) AND (MOVER = 500) THEN WCKSFLAG = WCKSOLD
    IF MOVER = 5000 THEN WCQSFLAG = WCQSOLD
    GOTO 16
   END IF
  NEXT
16 CLS
 LOOP
END SUB

SUB KING (A, B, XX(), YY(), NDX)
 ID = SGN(BOARD(B, A))
 FOR DY = -1 TO 1
  IF B + DY < 0 OR B + DY > 7 THEN GOTO 12
  FOR DX = -1 TO 1
   IF A + DX < 0 OR A + DX > 7 THEN GOTO 11
   IF ID <> SGN(BOARD(B + DY, A + DX)) THEN
    NDX = NDX + 1
    XX(NDX) = A + DX
    YY(NDX) = B + DY
   END IF
11 NEXT
12 NEXT
END SUB

SUB KNIGHT (A, B, XX(), YY(), NDX)
 ID = SGN(BOARD(B, A))
 X = A - 1
 Y = B - 2
 GOSUB 5
 X = A - 2
 Y = B - 1
 GOSUB 5
 X = A + 1
 Y = B - 2
 GOSUB 5
 X = A + 2
 Y = B - 1
 GOSUB 5
 X = A - 1
 Y = B + 2
 GOSUB 5
 X = A - 2
 Y = B + 1
 GOSUB 5
 X = A + 1
 Y = B + 2
 GOSUB 5
 X = A + 2
 Y = B + 1
 GOSUB 5
 EXIT SUB
5 REM
 IF X < 0 OR X > 7 OR Y < 0 OR Y > 7 THEN RETURN
 IF ID <> SGN(BOARD(Y, X)) THEN NDX = NDX + 1: XX(NDX) = X: YY(NDX) = Y
 RETURN
END SUB

SUB MAKEMOVE (A, B, X, Y)
 BOARD(Y, X) = BOARD(B, A)
 BOARD(B, A) = 0
 IF Y = 0 AND BOARD(Y, X) = 100 THEN
   IF INTFLAG THEN
     DO
       VIEW PRINT 24 TO 24
       INPUT "PROMOTE TO: ", I$
       SELECT CASE UCASE$(I$)
         CASE "KNIGHT", "N", "Kt", "Kt.", "N."
           PROMOTE = 270
         CASE "BISHOP", "B", "B."
           PROMOTE = 300
         CASE "ROOK", "R", "R."
           PROMOTE = 500
         CASE "QUEEN", "Q", "Q."
           PROMOTE = 900
       END SELECT
     LOOP UNTIL PROMOTE <> 0
     BOARD(Y, X) = PROMOTE
   ELSE
     BOARD(Y, X) = -900
   END IF
 END IF
 IF Y = 7 AND BOARD(Y, X) = -100 THEN BOARD(Y, X) = -900
END SUB

SUB MOVELIST (A, B, XX(), YY(), NDX)
 PIECE = INT(ABS(BOARD(B, A)))
 NDX = -1
 IF PIECE = 100 THEN
  CALL PAWN(A, B, XX(), YY(), NDX)
 ELSEIF PIECE = 270 THEN CALL KNIGHT(A, B, XX(), YY(), NDX)
 ELSEIF PIECE = 300 THEN CALL BISHOP(A, B, XX(), YY(), NDX)
 ELSEIF PIECE = 500 THEN CALL ROOK(A, B, XX(), YY(), NDX)
 ELSEIF PIECE = 900 THEN CALL QUEEN(A, B, XX(), YY(), NDX)
 ELSE CALL KING(A, B, XX(), YY(), NDX)
 END IF
 
END SUB

SUB PAWN (A, B, XX(), YY(), NDX)
 ID = SGN(BOARD(B, A))
 IF (A - 1) >= 0 AND (A - 1) <= 7 AND (B - ID) >= 0 AND (B - ID) <= 7 THEN
  IF SGN(BOARD((B - ID), (A - 1))) = -ID THEN
   NDX = NDX + 1
   XX(NDX) = A - 1
   YY(NDX) = B - ID
  END IF
 END IF
 IF (A + 1) >= 0 AND (A + 1) <= 7 AND (B - ID) >= 0 AND (B - ID) <= 7 THEN
  IF SGN(BOARD((B - ID), (A + 1))) = -ID THEN
   NDX = NDX + 1
   XX(NDX) = A + 1
   YY(NDX) = B - ID
  END IF
 END IF
 IF A >= 0 AND A <= 7 AND (B - ID) >= 0 AND (B - ID) <= 7 THEN
  IF BOARD((B - ID), A) = 0 THEN
   NDX = NDX + 1
   XX(NDX) = A
   YY(NDX) = B - ID
   IF (ID < 0 AND B = 1) OR (ID > 0 AND B = 6) THEN
    IF BOARD((B - ID - ID), A) = 0 THEN
     NDX = NDX + 1
     XX(NDX) = A
     YY(NDX) = B - ID - ID
    END IF
   END IF
  END IF
 END IF
 
END SUB

SUB QUEEN (A, B, XX(), YY(), NDX)
 CALL BISHOP(A, B, XX(), YY(), NDX)
 CALL ROOK(A, B, XX(), YY(), NDX)
END SUB

SUB ROOK (A, B, XX(), YY(), NDX)
 ID = SGN(BOARD(B, A))
 FOR X = A - 1 TO 0 STEP -1
  IF ID <> SGN(BOARD(B, X)) THEN
   NDX = NDX + 1
   XX(NDX) = X
   YY(NDX) = B
  END IF
  IF (BOARD(B, X)) <> 0 THEN EXIT FOR
 NEXT
 FOR X = A + 1 TO 7 STEP 1
  IF ID <> SGN(BOARD(B, X)) THEN
   NDX = NDX + 1
   XX(NDX) = X
   YY(NDX) = B
  END IF
  IF (BOARD(B, X)) <> 0 THEN EXIT FOR
 NEXT
 FOR Y = B - 1 TO 0 STEP -1
  IF ID <> SGN(BOARD(Y, A)) THEN
   NDX = NDX + 1
   XX(NDX) = A
   YY(NDX) = Y
  END IF
  IF (BOARD(Y, A)) <> 0 THEN EXIT FOR
 NEXT
 FOR Y = B + 1 TO 7 STEP 1
  IF ID <> SGN(BOARD(Y, A)) THEN
   NDX = NDX + 1
   XX(NDX) = A
   YY(NDX) = Y
  END IF
  IF (BOARD(Y, A)) <> 0 THEN EXIT FOR
 NEXT
END SUB

SUB SHOWBD
 VIEW PRINT
 LOCATE 3, 30
 COLOR 7, 0
 PRINT "A  B  C  D  E  F  G  H"
 FOR K = 0 TO 25
  LOCATE 4, 28 + K
  COLOR 6, 0
  PRINT CHR$(220)
 NEXT
 FOR B = 0 TO 7
  LOCATE 2 * B + 5, 26
  COLOR 7, 0
  PRINT CHR$(56 - B)
  LOCATE 2 * B + 5, 28
  COLOR 6, 0
  PRINT CHR$(219)
  LOCATE 2 * B + 6, 28
  COLOR 6, 0
  PRINT CHR$(219)
  FOR A = 0 TO 7
   IF ((A + B) MOD 2) <> 0 THEN
    COLOUR = 2
   ELSE COLOUR = 15
   END IF
   CALL SQUARE(3 * A + 31, 2 * B + 5, COLOUR)
  NEXT
  LOCATE 2 * B + 5, 53
  COLOR 6, 0
  PRINT CHR$(219)
  LOCATE 2 * B + 6, 53
  COLOR 6, 0
  PRINT CHR$(219)
  LOCATE 2 * B + 6, 55
  COLOR 7, 0
  PRINT CHR$(56 - B)
 NEXT
 FOR K = 0 TO 25
  LOCATE 21, 28 + K
  COLOR 6, 0
  PRINT CHR$(223)
 NEXT
 LOCATE 22, 30
 COLOR 7, 0
 PRINT "A  B  C  D  E  F  G  H"
 FOR B = 0 TO 7
  FOR A = 0 TO 7
   CALL SHOWMAN(A, B, 0)
  NEXT
 NEXT
 COLOR 7, 0
END SUB

SUB SHOWMAN (A, B, FLAG)
 IF BOARD(B, A) < 0 THEN BACK = 0
 IF BOARD(B, A) > 0 THEN BACK = 7
 FORE = 7 - BACK + FLAG
 IF BOARD(B, A) = 0 THEN
  IF ((A + B) MOD 2) <> 0 THEN BACK = 2 ELSE BACK = 15
  FORE = BACK + -1 * (FLAG > 0)
 END IF
 N$ = " "
 PIECE = INT(ABS(BOARD(B, A)))
 IF PIECE = 0 THEN N$ = CHR$(219)
 IF PIECE = 100 THEN N$ = "P"
 IF PIECE = 270 THEN N$ = "N"
 IF PIECE = 300 THEN N$ = "B"
 IF PIECE = 500 THEN N$ = "R"
 IF PIECE = 900 THEN N$ = "Q"
 IF PIECE = 5000 OR PIECE = 7500 THEN N$ = "K"
 LOCATE 2 * B + 5 - (BOARD(B, A) > 0), 3 * A + 30
 COLOR FORE, BACK
 PRINT N$
 LOCATE 1, 1
 COLOR 7, 0
END SUB

SUB SQUARE (A, B, C)
 MT$ = CHR$(219)
 MT$ = MT$ + MT$ + MT$
 LOCATE B, A - 2
 COLOR C, C
 PRINT MT$
 LOCATE B + 1, A - 2
 COLOR C, C
 PRINT MT$
 COLOR 7, 0
END SUB