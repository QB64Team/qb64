$CONSOLE:ONLY
_DEST _CONSOLE: _SOURCE _CONSOLE

COLOR 15
PRINT "Welcome to a demostration of the Windows Console System for QB64,"
PRINT "as overhauled by Steve!"
PRINT
PRINT "First, allow me to illustrate two newly implemented commands: SLEEP and CLS"
Pause
CLS
PRINT "And now, I'll illustrate how to change colors in the console:"
FOR i = 0 TO 15
    COLOR i, 15 - i
    PRINT "COLORS:"; i; "ON"; 15 - i
NEXT
PRINT
Pause
CLS
PRINT "And now, we're going to have fun with the console size."
PRINT "Our original screen should be set at 80x25 for default."
PRINT "Press <ANY KEY> when ready to change modes."
Pause
WIDTH 120, 50
PRINT
PRINT "Here we're set at 120x50."
Pause
WIDTH 120, 50, 120, 50
PRINT
PRINT "And here we no longer have a scroll buffer; it's also 120x50."
PRINT "Notice the vertical scroll bar is gone?"
Pause
WIDTH 100, 33, 300, 150
PRINT "And here we now have both a vertical and a hortizontal scroll bar."
FOR i = 1 TO 50
    PRINT "See? ";
    _LIMIT 10
NEXT
PRINT
PRINT "Be certain to scroll the bar so you can 'See' all the text."
PRINT
Pause
WIDTH 100, 33, 100, 33
CLS
PRINT "And now, prepare as I do something amazing!"
Pause
_CONSOLEFONT "Courier New", 16
PRINT "TaDa!!  Your font is now size 16!"
Pause
_CONSOLEFONT "Courier New", 24
PRINT "And just in case yours was already size 16, it's now size 24!"
Pause
_CONSOLEFONT "Courier New", 16
CLS
PRINT "And now, let's take a look at... MOUSE SUPPORT!!"
LOCATE 10, 10
PRINT "<<CLICK HERE TO CONTINUE>>"
DO
    x = _CONSOLEINPUT
    LOCATE 12, 2: PRINT _MOUSEX, _MOUSEY, _MOUSEBUTTON(1)
    IF _MOUSEX >= 10 AND _MOUSEX <= 38 AND _MOUSEY = 10 AND _MOUSEBUTTON(1) THEN EXIT DO
LOOP
PRINT
PRINT
PRINT "WAAAAAAIIIIIIT A MOMENT!!"
PRINT
PRINT
FOR i = 1 TO 40
    PRINT MID$("THE CONSOLE NOW HAS MOUSE SUPPORT?!!", i, 1);
    _DELAY .1
NEXT
PRINT
PRINT
PRINT "WOOOOOOOO!!!!!"
PRINT
Pause
CLS
PRINT "And, of course, I can now work with LOCATE..."
LOCATE 10, 10: PRINT "LOCATE 10,10"
LOCATE 20: PRINT "LOCATE 20"
LOCATE , 20: PRINT "LOCATE ,20"
Pause
CLS
PRINT "And, of course, I can now get back single character returns..."
PRINT "Press any key, and I'll give you the scan code for it.  <ESC> quits the demo."
PRINT
PRINT
DO
    x = _CONSOLEINPUT
    IF x = 1 THEN 'don't update for mouse input
        c = _CINP
        PRINT c;
    END IF
LOOP UNTIL c = 1
END

SUB Pause
    PRINT
    PRINT "Press <ANY KEY> to continue."
    SLEEP
END SUB

