'***************************************************************************
'*
'*  Keyboard input parsing routine
'*
'*  The idea here was to create a program that will capture input from the
'*  keyboard and convert it into a list of words as individual strings as
'*  the user enters text from the keyboard. Exit from the program occurs
'*  when a carraige return is encountered.
'*
'*  Using the backspace key will back up thru the text that was entered, but
'*  for some reason it takes three key presses of backspace to go past a word
'*  boundry.  The function works so I didn't worry about it.
'* 
'* 
'* 
'* Placed in the public domain by
'* William W. Sindel
'* April 6, 2005
'* Version 1.0
'*
'***************************************************************************



PRGSTART:
        DIM word$(30)                   '* Max number of words we can parse
        CLS                             '*
        PRINT "start": PRINT            '* Just show us where we start
        WX = 1                          '* Set word counter var to 1

GETKEY:
        IF WX < 1 THEN WX = 1           '* To many backspaces would push
                                        '* would push wx out of range
        KB$ = INKEY$                    '*
        IF KB$ <> "" THEN GOTO printit  '* Loop here until a key is pressed
        GOTO GETKEY

printit:
        TESTNUM = ASC(KB$)               '* Find the numeric value of the
        IF TESTNUM = 13 THEN GOTO ENDGET '* key that was pressed.  This will
                                         '* let us identify carraige returns
                                         '* 13 = carraige return

        
                                         '* Check for backspace key
        IF TESTNUM <> 8 THEN GOTO SKIPBACK

                                         '*
                                         '* When backspace key pushes past a
                                         '* word boundry
        IF word$(WX) = "" THEN WX = WX - 1: GOTO GETKEY

        WL = LEN(word$(WX))              '* Find the length of the word
        WL = WL - 1                      '* Shorten the wordlength by one char
        TW$ = word$(WX)                  '* Get string out of the array
        TW$ = LEFT$(TW$, WL)             '* Shorten the string
        word$(WX) = TW$                  '* Put the string back in the array
        KB$ = ""                         '* Get rid of the backspace char
        GOTO RFRSH                       '* Update the screen
        
        
SKIPBACK:                                 '* Don't accept special characters
        IF TESTNUM < 32 OR TESTNUM > 122 THEN GOTO GETKEY


                                          '* Convert lower case to upper
        IF KB$ >= "a" AND KB$ <= "z" THEN KB$ = CHR$(ASC(KB$) - 32)

        word$(WX) = word$(WX) + KB$       '* Build the word
                                          '* 13 = no leading spaces
        IF word$(1) = " " THEN word$(1) = "": GOTO GETKEY
                                          '* Start the next word
        IF KB$ = " " THEN WX = WX + 1: GOTO GETKEY
        
                                         
RFRSH:                                    '* Loop thru the array to display
        FOR J = 1 TO WX                   '* the words as they are parsed
        LOCATE 10 + J, 1
        PRINT SPC(78);
        LOCATE 10 + J, 1
        PRINT word$(J)
        NEXT J
        
        
        
        GOTO GETKEY                        '* Go get another character



ENDGET:

        LOCATE 35, 1                       '* When a carraige return is
        FOR J = 1 TO WX                    '* detected print out the words
        PRINT word$(J);                    '* as a sentence
        NEXT J

        INPUT KB$                          '* This will leave the results on
                                           '* the screen until a carraige
                                           '* is entered


        END

        