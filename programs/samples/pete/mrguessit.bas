RANDOMIZE TIMER
a = INT(RND * 50)
CLS
PRINT "This is a guessing game between the numbers 0 and 50."
PRINT "I will tell you if you are higher orlower."
PRINT "Now lets begin!"
PRINT "type 999 to end (just in case...)"
WHILE iput <> a
INPUT "Type in a number please. ", iput
IF iput = 999 GOTO loser
IF iput < a THEN PRINT "You are below sea level (that means you're too low!)"
IF iput > a THEN PRINT "You are burning in the sun! (That means too high!)"
WEND
PRINT "Great job! You got it! The number was "; a
END
loser:
PRINT "The number was "; a
PRINT "Come back and play again soon! :-)"
PRINT
PRINT
PRINT
PRINT
PRINT "(C) 2004 John Mendoza"
PRINT "ALL RIGHTS RESERVED"
END