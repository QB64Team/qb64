SCREEN 12
title:
CLS
LOCATE 15, 25
PRINT "Welcome to Square Counter 2"
LOCATE 16, 23
PRINT "Press 's' for counting squares only."
LOCATE 17, 23
PRINT "Press 'r' for counting rectangles."
LOCATE 18, 23
PRINT "Press 'i' for explanation."
LOCATE 19, 23
PRINT "Press 'x' to quit."
DO
key$ = INKEY$
LOOP UNTIL key$ = "s" OR key$ = "r" OR key$ = "x" OR key$ = "i"
SELECT CASE key$
 CASE IS = "s"
 GOSUB squares
 CASE IS = "r"
 GOSUB rectangles
 CASE IS = "i"
 GOSUB explain
 CASE IS = "x"
 GOSUB ending
END SELECT

squares:
CLS
oldxsquare = 0
xsquare = 0
LOCATE 15, 25
INPUT "Enter the length of a side:", x
LOCATE 16, 25
INPUT "Enter the length of other side:", y
x = x + 1
y = y + 1
DO
oldxsquare = xsquare
x = x - 1
y = y - 1
xsquare = x * y
xsquare = xsquare + oldxsquare
LOOP UNTIL x = 1 OR y = 1
LOCATE 17, 24
PRINT xsquare
SLEEP
GOSUB title

rectangles:
CLS
oldxsquare2 = 0
xsquare2 = 0
LOCATE 15, 25
INPUT "Enter the length of a side:", x2
LOCATE 16, 25
INPUT "Enter the length of other side:", y2
x2 = x2 + 1
y2 = y2 + 1
DO
oldxsquare2 = xsquare2
x2 = x2 - 1
y2 = y2 - 1
xy = x2 + y2
xsquare2 = x2 * y2 * (xy / 2)
xsquare2 = xsquare2 + oldxsquare2
LOOP UNTIL x2 = 1 OR y2 = 1
LOCATE 17, 24
PRINT xsquare2
SLEEP
GOSUB title

explain:
CLS
LOCATE 5, 5
PRINT "    This is a program used to count squares or rectangles for"
PRINT " people who don't want to waste their time on solving annoying"
PRINT " long puzzles where they need to count how many squares or rectangles"
PRINT " are in a certain grid. NOTE: A 3 by 3 grid don't just have 9, it also"
PRINT " count the bigger ones (like the grid itself). So a 3 by 3 have 14"
PRINT " squares in total."
SLEEP
GOSUB title

ending:
CLS
LOCATE 1, 1
PRINT " I hope this will help with your puzzles."
PRINT " Please give me comments on this."
PRINT ""
PRINT "  By Paulunknown, creator of 'Zodiac'"
END