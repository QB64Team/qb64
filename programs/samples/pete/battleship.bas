RANDOMIZE TIMER
DIM playerbd(0 TO 9, 0 TO 9) AS STRING
DIM compbd(0 TO 9, 0 TO 9) AS STRING
DIM comphits(0 TO 9, 0 TO 9) AS STRING
PRINT "Co-ordinates range from 0 to 9"
PRINT "* represents part of ship"
PRINT "+ represents hit part of ship."
PRINT "------------------------------"
PRINT "PLACE SHIP [LENGTH 2]"
INPUT "X CO-ORDINATE [0-9]:", x
INPUT "Y CO-ORDINATE [0-9]:", y
INPUT "DIRECTION [N,S,E,W]:", DIRECTION$
playerbd(x, y) = "*"
IF LCASE$(DIRECTION$) = "w" THEN
playerbd(x - 1, y) = "*"
END IF
IF LCASE$(DIRECTION$) = "e" THEN
playerbd(x + 1, y) = "*"
END IF
IF LCASE$(DIRECTION$) = "s" THEN
playerbd(x, y + 1) = "*"
END IF
IF LCASE$(DIRECTION$) = "n" THEN
playerbd(x, y - 1) = "*"
END IF
PRINT "PLACE SHIP [LENGTH 3]"
INPUT "X CO-ORDINATE [0-9]:", x
INPUT "Y CO-ORDINATE [0-9]:", y
INPUT "DIRECTION [N,S,E,W]:", DIRECTION$
playerbd(x, y) = "*"
IF LCASE$(DIRECTION$) = "w" THEN
playerbd(x - 1, y) = "*"
playerbd(x - 2, y) = "*"
END IF
IF LCASE$(DIRECTION$) = "e" THEN
playerbd(x + 1, y) = "*"
playerbd(x + 2, y) = "*"
END IF
IF LCASE$(DIRECTION$) = "s" THEN
playerbd(x, y + 1) = "*"
playerbd(x, y + 2) = "*"
END IF
IF LCASE$(DIRECTION$) = "n" THEN
playerbd(x, y - 1) = "*"
playerbd(x, y - 2) = "*"
END IF
PRINT "PLACE SHIP [LENGTH 3]"
INPUT "X CO-ORDINATE [0-9]:", x
INPUT "Y CO-ORDINATE [0-9]:", y
INPUT "DIRECTION [N,S,E,W]:", DIRECTION$
playerbd(x, y) = "*"
IF LCASE$(DIRECTION$) = "w" THEN
playerbd(x - 1, y) = "*"
playerbd(x - 2, y) = "*"
END IF
IF LCASE$(DIRECTION$) = "e" THEN
playerbd(x + 1, y) = "*"
playerbd(x + 2, y) = "*"
END IF
IF LCASE$(DIRECTION$) = "s" THEN
playerbd(x, y + 1) = "*"
playerbd(x, y + 2) = "*"
END IF
IF LCASE$(DIRECTION$) = "n" THEN
playerbd(x, y - 1) = "*"
playerbd(x, y - 2) = "*"
END IF
PRINT "PLACE SHIP [LENGTH 4]"
INPUT "X CO-ORDINATE [0-9]:", x
INPUT "Y CO-ORDINATE [0-9]:", y
INPUT "DIRECTION [N,S,E,W]:", DIRECTION$
playerbd(x, y) = "*"
IF LCASE$(DIRECTION$) = "W" THEN
playerbd(x - 1, y) = "*"
playerbd(x - 2, y) = "*"
playerbd(x - 3, y) = "*"
END IF
IF LCASE$(DIRECTION$) = "E" THEN
playerbd(x + 1, y) = "*"
playerbd(x + 2, y) = "*"
playerbd(x + 3, y) = "*"
END IF
IF LCASE$(DIRECTION$) = "S" THEN
playerbd(x, y + 1) = "*"
playerbd(x, y + 2) = "*"
playerbd(x, y + 3) = "*"
END IF
IF LCASE$(DIRECTION$) = "N" THEN
playerbd(x, y - 1) = "*"
playerbd(x, y - 2) = "*"
playerbd(x, y - 3) = "*"
END IF
PRINT "PLACE SHIP [LENGTH 5]"
INPUT "X CO-ORDINATE [0-9]:", x
INPUT "Y CO-ORDINATE [0-9]:", y
INPUT "DIRECTION [N,S,E,W]:", DIRECTION$
playerbd(x, y) = "*"
IF LCASE$(DIRECTION$) = "w" THEN
playerbd(x - 1, y) = "*"
playerbd(x - 2, y) = "*"
playerbd(x - 3, y) = "*"
playerbd(x - 4, y) = "*"
END IF
IF LCASE$(DIRECTION$) = "e" THEN
playerbd(x + 1, y) = "*"
playerbd(x + 2, y) = "*"
playerbd(x + 3, y) = "*"
playerbd(x + 4, y) = "*"
END IF
IF LCASE$(DIRECTION$) = "s" THEN
playerbd(x, y + 1) = "*"
playerbd(x, y + 2) = "*"
playerbd(x, y + 3) = "*"
playerbd(x, y + 4) = "*"
END IF
IF LCASE$(DIRECTION$) = "n" THEN
playerbd(x, y - 1) = "*"
playerbd(x, y - 2) = "*"
playerbd(x, y - 3) = "*"
playerbd(x, y - 4) = "*"
END IF
a = INT(RND(1) * 10)
b = INT(RND(1) * 10)
FOR c = 1 TO 4
compbd(a, b) = "*"
DO
x = INT(RND(1) * 4)
IF x = 0 AND a - c >= 0 THEN
FOR d = 1 TO c
compbd(a - c, b) = "*"
NEXT
EXIT DO
END IF
IF x = 1 AND a + c <= 9 THEN
FOR d = 1 TO c
compbd(a + c, b) = "*"
NEXT
EXIT DO
END IF
IF x = 2 AND b - c >= 0 THEN
FOR d = 1 TO c
compbd(a, b - c) = "*"
NEXT
EXIT DO
END IF
IF x = 3 AND b + c <= 9 THEN
FOR d = 1 TO c
compbd(a, b + c) = "*"
NEXT
EXIT DO
END IF
LOOP
NEXT
c = 2
compbd(a, b) = "*"
DO
x = INT(RND(1) * 4)
IF x = 0 AND a - c >= 0 THEN
FOR d = 1 TO c
compbd(a - c, b) = "*"
NEXT
EXIT DO
END IF
IF x = 1 AND a + c <= 9 THEN
FOR d = 1 TO c
compbd(a + c, b) = "*"
NEXT
EXIT DO
END IF
IF x = 2 AND b - c >= 0 THEN
FOR d = 1 TO c
compbd(a, b - c) = "*"
NEXT
EXIT DO
END IF
IF x = 3 AND b + c <= 9 THEN
FOR d = 1 TO c
compbd(a, b + c) = "*"
NEXT
EXIT DO
END IF
LOOP
DO
PRINT " 0123456789"
FOR a = 0 TO 9
PRINT a;
FOR b = 0 TO 9
IF b < 9 AND playerbd(b, a) = "*" THEN PRINT "*";
IF b < 9 AND playerbd(b, a) = "+" THEN PRINT "+";
IF b < 9 AND playerbd(b, a) = "" THEN PRINT " ";
IF b = 9 AND playerbd(b, a) = "*" THEN PRINT "*"
IF b = 9 AND playerbd(b, a) = "" THEN PRINT " "
IF b = 9 AND playerbd(b, a) = "+" THEN PRINT "+"
NEXT
NEXT
PRINT "-----------"
PRINT " 0123456789"
FOR a = 0 TO 9
PRINT a,
FOR b = 0 TO 9
IF b < 9 AND comphits(b, a) = "+" THEN PRINT "+";
IF b < 9 AND comphits(b, a) = "" THEN PRINT " ";
IF b = 9 AND comphits(b, a) = "" THEN PRINT " "
IF b = 9 AND comphits(b, a) = "+" THEN PRINT "+"
NEXT
NEXT
INPUT "FIRE X CO-ORDINATE [0-9]:", x
INPUT "FIRE Y CO-ORDINATE [0-9]:", y
IF compbd(x, y) = "*" THEN
compbd(x, y) = "+"
comphits(x, y) = "+"
END IF
a = INT(RND(1) * 10)
b = INT(RND(1) * 10)
IF playerbd(a, b) = "*" THEN
playerbd(a, b) = "+"
END IF
countera = 0
counterb = 0
FOR a = 0 TO 9
FOR b = 0 TO 9
IF compbd(a, b) = "*" THEN countera = countera + 1
NEXT
NEXT
IF countera = 0 THEN
PRINT "YOU WIN"
EXIT DO
END IF
FOR a = 0 TO 9
FOR b = 0 TO 9
IF playerbd(a, b) = "*" THEN counterb = counterb + 1
NEXT
NEXT
IF counterb = 0 THEN
PRINT "YOU LOSE"
EXIT DO
END IF
LOOP