DECLARE SUB SCRAMBLE ()
DECLARE SUB GIVEUP ()
DECLARE SUB UP ()
DECLARE SUB DOWN ()
DECLARE SUB ROTATE (ROW%)
DEFINT A-Z
DIM SHARED PUZZLE(0 TO 5, 0 TO 5)
DIM COLORS(-1 TO 5)
CLS
FOR I = 0 TO 5
READ COLORS(I)
FOR J = 0 TO 5
PUZZLE(I, J) = J
NEXT
NEXT
DATA 8, 15, 12, 14, 10, 9
PUZZLE(5, 5) = -1
DO
CLS
FOR I = 0 TO 5
PRINT I + 1;
FOR J = 0 TO 5
COLOR COLORS(PUZZLE(I, J))
PRINT CHR$(219);
NEXT
COLOR 7: PRINT
NEXT
PRINT
PRINT "Instructions:"
PRINT STRING$(13, 196)
PRINT " "; CHR$(254); " The object of the game is to restore the puzzle back to its initial state"
PRINT SPACE$(3); "from a scrambled state."
PRINT " "; CHR$(254); " To scramble the puzzle, press S."
PRINT " "; CHR$(254); " To give up and reset the puzzle, type R."
PRINT " "; CHR$(254); " To shift a row right, press the number of that row."
PRINT " "; CHR$(254); " To move a tile up into the blank space, press the up arrow key."
PRINT " "; CHR$(254); " To move a tile down into the blank space, press the down arrow key."
N$ = ""
WHILE N$ = ""
N$ = INKEY$
WEND
SELECT CASE N$
CASE "R", "r"
CALL GIVEUP
CASE "S", "s"
CALL SCRAMBLE
CASE "1"
CALL ROTATE(0)
CASE "2"
CALL ROTATE(1)
CASE "3"
CALL ROTATE(2)
CASE "4"
CALL ROTATE(3)
CASE "5"
CALL ROTATE(4)
CASE "6"
CALL ROTATE(5)
CASE CHR$(0) + CHR$(72)
CALL UP
CASE CHR$(0) + CHR$(80)
CALL DOWN
CASE CHR$(27)
END
END SELECT
LOOP

SUB DOWN
FOR I = 0 TO 5
FOR J = 0 TO 5
K = PUZZLE(I, J)
IF K = -1 THEN GOTO 2
NEXT
NEXT
2 IF I = 0 THEN EXIT SUB
SWAP PUZZLE(I - 1, J), PUZZLE(I, J)
END SUB

SUB GIVEUP
FOR I = 0 TO 5
FOR J = 0 TO 5
PUZZLE(I, J) = J
NEXT
NEXT
PUZZLE(5, 5) = -1
END SUB

SUB ROTATE (ROW)
FOR I = 1 TO 5
SWAP PUZZLE(ROW, 0), PUZZLE(ROW, I)
NEXT
END SUB

SUB SCRAMBLE
FOR I = 1 TO 1000
J = INT(RND(1) * 8)
SELECT CASE J
CASE 0 TO 5
CALL ROTATE(J)
CASE 6
CALL UP
CASE 7
CALL DOWN
END SELECT
NEXT
END SUB

SUB UP
FOR I = 0 TO 5
FOR J = 0 TO 5
K = PUZZLE(I, J)
IF K = -1 THEN GOTO 1
NEXT
NEXT
1 IF I = 5 THEN EXIT SUB
SWAP PUZZLE(I + 1, J), PUZZLE(I, J)
END SUB
