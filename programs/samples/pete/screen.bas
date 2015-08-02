' PQBC Screen Tester
'-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
' This program looks big, but it is actually quite small. Run it through a
' decommenter to see how small it is. Anyway, this program tests what screen
' modes your graphics adapter supports. You can find one included with the
' QuickBasic 4.5 examples, but this one is easier to manipulate and more
' effective. This lists all the screen modes your computer supports, instead
' of just a few. The REMs show the variables that can be manipulated.
' This program is free to distribute as long as these first 12 lines of
' comments are NOT removed and/or changed.
' If you have questions/comments/suggestions, contact me at:
' patz2009@yahoo.com
REM    Variables
REM  ------------------------
REM  works >  a supported screen mode
REM  nogo  >  error handling variable
REM  test  >  the screen mode being tested
REM  list$ >  list of supported modes


'-------------------START-OF-PROGRAM---------------------------------
ON ERROR GOTO handler
works = 50                        ' Later replaced by the first working mode
test = 1                          ' Activates first mode to test (start at
                                  '            1 to test all screen modes)
starttest:
IF test = 14 THEN GOTO ender      ' Ends since there is no SCREEN 14
IF nogo = 0 THEN SCREEN test      ' Core tester - activates a screen mode
IF nogo = 0 THEN LET list$ = list$ + "," + STR$(test) ' Creates a list of
                                                      ' working screen modes.
IF nogo = 0 AND works = 50 THEN LET works = test ' Generates a working screen
                                                 ' mode to display working
                                                 ' mode numbers.
nogo = 0                               ' Replaces error handler.
test = test + 1                        ' Tests a new screen mode.
GOTO starttest                         ' Restarts the test.


'----------------Display-working-screen-modes----------------------
ender:
SCREEN works                                  ' Uses a working graphics mode.
PRINT "Your graphics adapter supports screen"      ' Displays your working
PRINT "modes 0"; list$; "."                      ' screen modes.
' NOTE: All graphics adapters support SCREEN 0
END


'------------------Error-handling-variable-activater---------------
handler:
LET nogo = 1          ' Activates the error handling variable.
RESUME NEXT
'-----------------------------------------------------------------