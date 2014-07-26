' QBasic Beautifier by  Kewbie_newbie, found at Aliphas page
'
' THIS PROGRAM USED FEATURES AVAILABLE ONLY IN QuickBasic 7.1 (as far as
'   I know) (Tested in Qb 4.5 by Antoni Gual)
'
'  The 'Quick Basic Beautifier' program performs the following actions:
'
'    1.  Indents program lines according to control flow structures
'    2.  Removes stupid, useless, unnecessary 'LET' statements (unless
'        overridden)
'    3.  Changes 'REM' keyword to ' (unless overridden)
'    4.  Optionally re-aligns trailing comments
'    5.  Optionally removes all comments
'    6.  Optionally allows a left margin and/or line length to be set (for
'        output to a printer, perhaps
'
'                         Quick Basic Beautifier
'
' Usage:
'
'  qbb InFile[.Ext] [OutFile[.Ext]] [/C:A|B|#] /F [/L] [/M:#[,#]] [/R:?] [/T:#]
'   [/Q]
'
'   File extentions are optional.  If the InFile extension is omitted,
'   'BAS' is assumed.  If the OutFile extension is omitted, 'QBB' is
'   assumed.  If the OutFile is omitted, 'InFile.QBB' is assumed.
'   If the OutFile starts with a '.', OutFile will being 'InFile.<specified ext>'.
'
'   The colons on the switches are optional.  Switches are not case sensitive
'
'   /C:A|B|T - move trailing comments to the line above or below.
'              Default = leave trailing
'   /C:#     - align trailing comments to column #
'              (See note below)
'   /F       - include OPEN/CLOSE in nesting
'              (a word of caution: MOST of the time, you probably will NOT
'               be happy with the results of using this switch)
'   /L       - do not remove useless 'LET' statements.
'              Default = whack 'em
'   /M:#[,#] - left Margin width [and line length] (possibly to format
'              output for a printer -- see note below)
'              Default = leave as is
'   /R:?     - controls comment keyword.
'      '     - use ' keyword (default)
'      N     - do not change keyword
'      D     - delete all comments
'   /S:L     - keep only 'looping' statements on a single line
'              ('LOOPING' mode - see note below)
'   /S:#     - controls handling of multi-statement lines
'              # is the number of statements to keep on a line
'              Default = 0 (no multi-statement line splitting)
'              1 = put every statement on a separate line
'              2 - infinity = leave up to 'n' statements on a line
'              (see note below)
'   /T:#     - # is the number of columns per tab.
'              Default = 2 columns
'   /Q       - quiet mode, no info or pause to reflect, just do it
'
' Notes:
'
'   The input to QBB must be parsable by qbasic, and the keywords must be
'   in upper case.  If you download something that was entered in lower
'   case, load and save it with qbasic first to adjust the case of the
'   keywords
'
'   I have included a new feature in this version: if there is a particular
'   sequence of switches that you always use, say "/T3 /C40 /Q", you can
'   set the environment variable "QBBOPT" to specify those switches and
'   QBB will operate as if those switches had been specified at invocation.
'   These default settings can be overridden.  Simply specify a new value
'   on the command line when invoking QBB.  The /F /L and /Q switches
'   act as toggles, so to turn off /Q in the above example, to turn quiet
'   mode OFF, you would invoke QBB with "QBB infile.bas outfile.qbb /Q".
'   And of course you can add additional switches if you need to
'
'   The input and output files can not be the same.  QBB checks for this
'   and wont allow it
'
'   If a comment column is specified and a line is too long, the trailing
'   comment will be separated from the end of the line by one space
'
'   If a line length is specified (with or without a margin), comment
'   alignment is forced to "ABOVE".  It just made things easier. Also,
'   the output will almost certainly not interpret or compile properly,
'   I added this feature only because a printer I sometimes use doesn't
'   wrap long lines to the next line, it truncates them!  (I use it be-
'   cause it's FAST.  A couple of people have asked me 'How fast?'.  It
'   was a laser printer that was channel attached to an IBM mainframe,
'   and at a guess, I'd say it printed 80 to 100 pages a minute.  All I
'   can tell you is that the paper went by too fast for me to be able
'   to read.  Alas, it wasn't being used enough to justify keeping it,
'   so it was taken away :(..... )
'
'   Qbasic breaks long program lines into shorter pieces and stores them
'   in the source file with a continuation character at the end (" _"). QBB
'   concatenates these continued lines together in the output file.  The
'   first time the program is saved by qbasic, it will store the lines the
'   way it was designed to.  If you load a source file that has one of
'   these long lines and try to compile it under qbasic 4.5 or 7.1 (the
'   only ones I've tried, it will fail with 'line too long' errors, and
'   other errors probably unrelated to any actual errors in the program.
'   To fix this, save the program before compiling
'
'   The output is indented the way I like it!
'
'   If the /S switch is omitted, or '/S:0' is specified, QBB will handle
'   multiple statement lines as it did prior to this version, i.e., not
'   very well.  Especially if there are embeded structuring keywords.  It
'   does handle a few common cases
'
'   With the addition of the '/S' switch, QBB now handles multiple state-
'   ment lines more effectively.  There are essentially ?? modes for split-
'   ting lines with multiple statments.  'LOOPING' mode causes QBB to
'   leave multiple statements on lines that have both a 'DO' and a 'LOOP'
'   statement, or 'FOR' and 'NEXT' or 'WHILE' and 'WEND'.
'
'   qbasic always seems to move labels to column 1.  QBB will indent any
'   labels which are placed inside control-flow structures.  qbasic will
'   move them to column 1 the first time the program is loaded
'
'   All three qbasic help files indicate that a label can have blanks
'   and tabs between the label and the colon.  When such a line is
'   added to a program, qbasic moves the colon to the end of the label.
'   QBB always places the colon at the end of the label
'
' "NO PROBLEM IS INSOLUBLE IN ALL CONCIEVABLE CIRCUMSTANCES"
' (Cosmic AC in "The Last Question" by Isaac Asimov)

BeginProgram:

' This function is executed once at the beginning of the program to determine
'   input and output files, and other command line switches described above
'   to control source formatting
DECLARE SUB ParseInputParameters ()

' These two functions are used during input parameter parsing for extracting
'   file names and parameter values
DECLARE FUNCTION GetParm$ (parm$)
DECLARE FUNCTION GetFile$ ()

' If the user doesn't know what to do, this subroutine will give him/her
'   some SIMPLIFIED instructions
DECLARE SUB Usage ()

' All but one of the "do" functions are the handlers for the named qbasic
'   program flow keywords.
' Two of these functions handle two keywords:
'   doCASEELSE and doFUNCSUB.
' All of these functions deal with input and output via 'global' variables
DECLARE SUB doCASEELSE ()
DECLARE SUB doDECLARE ()
DECLARE SUB doDEFFN ()
DECLARE SUB doDO ()           ' be careful not to step in it!
DECLARE SUB doENDSEL ()
DECLARE SUB doFOR ()
DECLARE SUB doFUNCSUB ()
DECLARE SUB doIF ()
DECLARE SUB doNEXT ()
DECLARE SUB doSELECT ()
DECLARE SUB doTYPE ()
DECLARE SUB doWHILE ()

' This one "do" function does not handle a qbasic keyword.  It controls the
'   level of indentation by manipulating 'global' variables.  It's counter-
'   part is "unNest"
DECLARE SUB doNest ()
DECLARE SUB unNest ()

' This function takes care of putting the formatted source code to the
'   appropriate output device
DECLARE SUB PrintLine (Text$)

' This function looks for and removes "LET" statements
DECLARE FUNCTION DeLETify$ (Text$)

' This function looks for comments
DECLARE FUNCTION FindComment% (Text$)

' This function returns a boolean value to indicate whether or not a given
'   token is a qbasic keyword
DECLARE FUNCTION KeyWord% (Text$)

' This function breaks each line up into individual tokens
DECLARE FUNCTION LocateKeyWord% (Text$, CmntKyWd$)

' These two functions and a sub form the main loop that reads the input file
'   and produces the output file.  The functions are both boolean
DECLARE FUNCTION ParseProgramLine% ()
DECLARE FUNCTION StructureProgramLine% ()
DECLARE SUB PrintProgramLine ()

' This function removes leading whitspace characters from the input source
'   lines
DECLARE FUNCTION TrimWhite$ (Text$)

' This function is simply a loop that reads data into the "Structure$" array
DECLARE SUB SetStructure (Max%)

' This function is simply a loop that reads data into the "Reserved$" array
DECLARE SUB SetReserved ()

' The following five constants deal with comment handling
CONST CmtABOVE% = -1
CONST CmtBELOW% = -2
CONST CmtASIS% = 2
CONST CmtNONE% = 1
CONST CmtTICK% = 3

' There are twenty-eight program control flow statements handled by QBB
CONST MaxStruct% = 28

' This program uses nineteen 'global' variables
' Nine of them are integer variables
DIM SHARED CmtCol%
DIM SHARED CmtKey%
DIM SHARED Length%

DIM SHARED Margin%
DIM SHARED TabWidth%
DIM SHARED TabLevel%

DIM SHARED CmtFlag%
DIM SHARED LetFlag%
DIM SHARED PrintFlag%

' Eight of them are string variables
DIM SHARED Cmd$           ' working copy of COMMAND$
DIM SHARED Comment$
DIM SHARED InputStatement$
DIM SHARED Margin$
DIM SHARED Statement$
DIM SHARED TabLevel$

DIM SHARED iFile$
DIM SHARED oFile$

DIM SHARED UserNames$

' Two of them are string arrays
DIM SHARED Reserved$(ASC("A") TO ASC("Z"))
DIM SHARED Structure$(0 TO MaxStruct%, 1 TO 2)

' Enough with the preparation stuff, time to start really doing something
CLS : PRINT                   ' clean up any leftover junk

ParseInputParameters          ' find out what the user wants to do

ON ERROR GOTO MissingInput    ' if the user goofed, try to tell him
                              '   what he did
OPEN iFile$ FOR INPUT AS #1   ' if you don't know what this does, this
                              '   program is probably too complex for you
ON ERROR GOTO 0               ' don't try to be too helpful
OPEN oFile$ FOR OUTPUT AS #2  ' ditto input comment

SetReserved                   ' populate the reserved word array
SetStructure (MaxStruct%)     ' populate the program control keyword/
                              '   handler routine array
TabLevel% = 0                 ' start out at left margin
TabLevel$ = ""
UserNames$ = " "              ' clear the "symbol table"

' This is the main program loop.  It loops through all of the input source
'   file lines.  Originally, the code for the two functions and subroutine
'   was included in this loop.  It wasn't a huge loop, but it took more that
'   one screen, so I decided to break it down according to what was happen-
'   ing functionally.  In the original loop, PrintProgramLine was inside
'   StructureProgramLine, which was inside ParseProgramLine (as I remember
'   it, that is).
DO UNTIL EOF(1) AND InputStatement$ = ""
  IF ParseProgramLine% THEN IF StructureProgramLine% THEN PrintProgramLine
LOOP

' Since the screen was cleared, remind the user of what s/he did
PRINT CURDIR$ + ">" + COMMAND$
END ' all done

' Error handling routine for missing input file
MissingInput:
PRINT "Input file not found"
END

' The following data statements contain all of the reserved words for
'   qbasic 1.1, QuickBasic 4.5 and QuickBasic 7.1
'
ReservedData:
DATA " ABS ABSOLUTE ACCESS ALIAS ALL AND ANY APPEND AS ASC ATN "
DATA " BASE BASIC BEEP BEGINTRANS BINARY BLOAD BOF BSAVE BYVAL "
DATA " CALL CALLS CASE CCUR CDBL CDECL CHAIN CHDIR CHDRIVE CHECKPOINT CINT CIRCLE CLEAR CLNG CLOSE CLS COLOR COM COMMITTRANS COMMON CONST COS CREATEINDEX CSNG CSRLIN CURRENCY CVC CVD CVDMBF CVI CVL CVS CVSMBF "
DATA " DATA  DECLARE DEF DEFCUR DEFDBL DEFINT DEFLNG DEFSNG DEFSTR DELETE DELETEINDEX DELETETABLE DIM DO DOUBLE DRAW "
DATA " ELSE ELSEIF END ENDIF ENVIRON EOF EQV ERASE ERDEV ERL ERR ERROR EVENT EXIT EXP "
DATA " FIELD FILEATTR FILES FIX FN FOR FRE FREEFILE FUNCTION "
DATA " GET GO GOSUB GOTO "
DATA " -H- "
DATA " IF IMP INP INPUT INSERT INSTR INT INTEGER INTERRUPT IOCTL IS ISAM "
DATA " -J- "
DATA " KEY KILL "
DATA " LBOUND LEN LET LINE LIST LOC LOCAL LOCATE LOCK LOF LOG LONG LOOP LPOS LPRINT LSET "
DATA " MKDIR MOD MOVEFIRST MOVELAST MOVENEXT MOVEPREVIOUS "
DATA " NAME NEXT NOT "
DATA " OFF ON OPEN OPTION OR OUT OUTPUT "
DATA " PAINT PALETTE PCOPY PEEK PEN PLAY PMAP POINT POKE POS PRESET PRINT PSET PUT "
DATA " -Q- "
DATA " RANDOM RANDOMIZE READ REDIM REM RESET RESTORE RESUME RETRIEVE RETURN RMDIR RND ROLLBACK RSET RUN "
DATA " SADD SAVEPOINT SCREEN SEEK SEEKEQ SEEKGE SEEKGT SEG SELECT SETINDEX SETMEM SGN SHARED SHELL SIGNAL SIN SINGLE SLEEP SOUND SPC SQR SSEG SSEGADD STACK STATIC STEP STICK STOP STRIG STRING SUB SWAP SYSTEM "
DATA " TAB TAN THEN TIMER TO TROFF TRON TYPE "
DATA " UBOUND UEVENT UNLOCK UNTIL UPDATE USING "
DATA " VAL VARPTR VARSEG VIEW "
DATA " WAIT WEND WHILE WIDTH WINDOW WRITE "
DATA " XOR "
DATA " -Y- "
DATA " -Z- "

' The following data statements are used to build the
'   "program control flow keyword/handler function" table
StructureData:
DATA "","NoS"
DATA "DATA" , "NoS"
DATA "END IF" , "unN"
DATA "ELSE" , "doC"
DATA "ELSEIF" , "doC"
DATA "IF" , "doI"
DATA "LOOP" , "unN"
DATA "EXIT DO" , "NoS"
DATA "DO" , "doDO"
DATA "NEXT" , "doN"
DATA "EXIT FOR" , "NoS"
DATA "FOR" , "doFO"
DATA "END SELECT" , "doE"
DATA "SELECT" , "doS"
DATA "CASE" , "doC"
DATA "END TYPE" , "unN"
DATA "TYPE" , "doT"
DATA "END FUNCTION" , "unN"
DATA "EXIT FUNCTION" , "NoS"
DATA "DECLARE FUNCTION" , "doDEC"
DATA "FUNCTION" , "doFU"
DATA "END SUB" , "unN"
DATA "EXIT SUB" , "NoS"
DATA "DECLARE SUB" , "doDEC"
DATA "SUB" , "doFU"
DATA "END DEF" , "unN"
DATA "EXIT DEF" , "NoS"
DATA "DEF FN" , "doDEF"
DATA "WEND" , "unN"
DATA "WHILE" , "doW"

FUNCTION DeLETify$ (Text$)
  Done% = 0
  Work$ = " " + Text$

  DO
    LetLoc% = LocateKeyWord%(Work$, "LET ")

    IF LetLoc% THEN
      Work$ = LEFT$(Work$, LetLoc% - 1) + MID$(Work$, LetLoc% + 4)
    ELSE
      Done% = -1
    END IF
  LOOP UNTIL Done%

  DeLETify$ = MID$(Work$, 2)
END FUNCTION

SUB doCASEELSE
  IF LEFT$(Statement$, 4) = "ELSE" OR LEFT$(Statement$, 6) = "ELSEIF" OR LEFT$(Statement$, 4) = "CASE" THEN
    IF TabLevel% THEN
      unNest
      PrintProgramLine
      doNest
      PrintFlag% = 0
    END IF
  END IF
END SUB

SUB doDECLARE
  nSta% = INSTR(10, Statement$, " ") + 1
  nEnd% = INSTR(nSta%, Statement$, " ")
  UserNames$ = UserNames$ + MID$(Statement$, nSta%, nEnd% - nSta%) + " "
END SUB

SUB doDEFFN
  IF INSTR(Statement$, "=") = 0 THEN
    PrintProgramLine
    doNest
    PrintFlag% = 0
  END IF
END SUB

SUB doDO
  IF INSTR(Statement$, "LOOP") = 0 THEN
    PrintProgramLine
    doNest
    PrintFlag% = 0
  END IF
END SUB

SUB doENDSEL
  unNest
  unNest
END SUB

SUB doFOR
  IF INSTR(Statement$, "NEXT") THEN EXIT SUB
  opn% = INSTR(Statement$, "OPEN")
  IF opn% AND opn% < INSTR(Statement$, "FOR") THEN EXIT SUB

  PrintProgramLine
  doNest
  PrintFlag% = 0
END SUB

SUB doFUNCSUB
  TabLevel$ = ""
  PrintProgramLine
  TabLevel% = TabWidth%
  TabLevel$ = STRING$(TabLevel%, " ")
  PrintFlag% = 0
END SUB

SUB doIF
  IF RIGHT$(Statement$, 4) = "THEN" THEN
    PrintProgramLine
    doNest
    PrintFlag% = 0
  END IF
END SUB

SUB doNest
  TabLevel% = TabLevel% + TabWidth%
  TabLevel$ = STRING$(TabLevel%, " ")
END SUB

SUB doNEXT
' This subroutine is called when QBB encounters the 'NEXT'
'   keyword in the source code it's formatting
' It causes the level of indentation to be decreased by the
'   appropriate number of tabs

  ' Frankly, I don't know why this check is in here.  This
  '   subroutine SHOULD only get called when 'NEXT' is found
  '   I can only guess that at some point in my 'code as you
  '   go' design, I found it necessary to put this here to
  '   handle some situation
  IF LEFT$(Statement$, 4) = "NEXT" THEN
    unNest  ' <-- performs the actual indent level adjustment

    ' Check for multi-statement line.  I cheated and misused Comma% to save
    '  creating an additional variable
    Comma% = INSTR(Statement$, ":")
    ' Only concerned with commas associated with the 'NEXT'
    IF Comma% THEN Text$ = LEFT$(Statement$, Comma% - 1) ELSE Text$ = Statement$

    ' This loop takes care of programs that do nested
    ' FOR/NEXT loops like:
    ' FOR Idx = 1 TO 5
    '   FOR Jdx = 1 TO 5
    '     A$(Idx, Jdx) = ""
    ' NEXT Jdx, Idx
    ' Personally, I never code this way, I prefer to use discrete 'NEXT'
    ' statements.
    Comma% = INSTR(Text$, ",") ' look for a comma
    DO WHILE Comma%            ' if none were found, loop is skipped
      unNest                   '   otherwise adjust indent for each var on
                               '   the 'NEXT' statement.  Remember that by
                               '   the time this loop is reached, the 1st
                               '   variable is already accounted for
      Comma% = INSTR(Comma% + 1, Text$, ",") ' find the next comma
      ' 'INSTR' returns zero (false) when it doesn't find the text being
      ' searched for, so after the last comma is found, the loop ends
    LOOP
  END IF
END SUB

SUB doSELECT
  PrintProgramLine
  doNest
  doNest
  PrintFlag% = 0
END SUB

SUB doTYPE
  PrintProgramLine
  doNest
  PrintFlag% = 0
END SUB

SUB doWHILE
  IF LEFT$(Statement$, 5) = "WHILE" THEN
    PrintProgramLine
    doNest
    PrintFlag% = 0
  END IF
END SUB

FUNCTION FindComment% (Text$)
  CmntREM% = LocateKeyWord%(Text$, "REM ")
  CmntQUO% = LocateKeyWord%(Text$, "'")

  IF CmntQUO% OR CmntREM% THEN
    IF CmntQUO% > 0 AND CmntREM% > 0 THEN
      IF CmntQUO% < CmntREM% THEN
        FindComment% = CmntQUO%
      ELSE
        FindComment% = -CmntREM%
      END IF
    ELSE
      FindComment% = CmntQUO% + -CmntREM%
    END IF
  ELSE
    FindComment% = 0
  END IF
END FUNCTION

FUNCTION GetFile$
' This function looks for a file name in the command line parameters

  pSpace% = INSTR(Cmd$, " ")        ' parms are separated by spaces
                                    ' the input parms are set up so
                                    ' there'll always be a space
  File$ = LEFT$(Cmd$, pSpace% - 1)  ' get the file name (and possible
                                    ' extension
  IF LEFT$(File$, 1) <> "/" THEN    ' is it a switch?
    Cmd$ = MID$(Cmd$, pSpace% + 1)  ' no, so gobble this file name
    GetFile$ = File$                ' set the return value
  ELSE                              ' it wasn't a file name, so
    GetFile$ = ""                   ' return null
  END IF
END FUNCTION

FUNCTION GetParm$ (parm$)
' This function returns the value associated with parms passed on the command
'   line
'   All parameters start with a '/'
'   The parm name MAY end with a colon
'   The parm value MUST be terminated by a space or newline
  pParm% = INSTR(Cmd$, "/" + parm$)

  IF pParm% THEN
    pSpace% = INSTR(pParm%, Cmd$, " ")
    Temp$ = MID$(Cmd$, pParm% + 2, pSpace% - (pParm% + 2))
    IF LEFT$(Temp$, 1) = ":" THEN Temp$ = MID$(Temp$, 2)
    IF Temp$ = "" THEN Temp$ = " "
  ELSE
    Temp$ = ""
  END IF

  GetParm$ = Temp$
END FUNCTION

FUNCTION KeyWord% (Text$)
  Char% = INSTR(UserNames$, " " + Text$ + " ") <> 0

  IF NOT Char% THEN
    Char% = ASC(Text$)

    IF Char% >= ASC("A") AND Char% <= ASC("Z") THEN
      KeyWord% = INSTR(Reserved$(Char%), " " + Text$ + " ") <> 0
    ELSE
      KeyWord% = 0
    END IF
  ELSE
    KeyWord% = -1
  END IF
END FUNCTION

FUNCTION LocateKeyWord% (Text$, QBKyWd$)
  Last% = 0
  Known% = 0

  DO
    QBKeyWd% = INSTR(Last% + 1, Text$, QBKyWd$)
    Last% = QBKeyWd%

    IF QBKeyWd% THEN
      Done% = 0
      lq% = 0
      DO
        fq% = INSTR(lq% + 1, Text$, CHR$(34))
        IF fq% AND fq% < QBKeyWd% THEN ' found ", gotta check
          lq% = INSTR(fq% + 1, Text$, CHR$(34))
          IF lq% > QBKeyWd% THEN
            QBKeyWd% = 0
            Done% = -1
          END IF
        ELSE ' no "s or "s >> ', it's a QBasci KeyWord
          Done% = -1
          Known% = -1
        END IF
      LOOP UNTIL Done%
    ELSE
      Known% = -1
    END IF
  LOOP UNTIL Known%

  LocateKeyWord% = QBKeyWd%
END FUNCTION

SUB ParseInputParameters
' This subroutine figures out what the user wants qbb to do for him/her

  Cmd$ = COMMAND$ + "    " ' get a working copy of the input parameters,
                           '   adding a trailing blank
  Temp$ = GetFile$         ' the 1st parm is the input file
                           ' GetFile gobbles file names
  IF Temp$ = "" THEN Usage ' if no parms, tell 'em how to use qbb
                           ' (the program will exit after displaying usage

  iFile$ = Temp$           ' got a good file name so
  dot% = INSTR(Temp$, ".") ' look for the extension

  IF dot% <> 0 THEN                 ' if there was an extension,
    Temp$ = LEFT$(Temp$, dot% - 1)  ' get the base file name
  ELSE
    iFile$ = iFile$ + ".bas"        ' otherwise add the default input ext
  END IF

  oFile$ = Temp$ + ".qbb"           ' preset the default output file name,
                                    ' just in case it wasn't given
  oName$ = Temp$                    ' save the base name, just in case only
                                    ' an extension is given
  Temp$ = GetFile$                  ' see if an output file was given
  IF Temp$ <> "" THEN               ' if it was,
    oFile$ = Temp$                  ' set the output file name
  END IF
  dot% = INSTR(oFile$, ".")         ' look for the extension
  IF dot% = 0 THEN                  ' if there wasn't one,
    oFile$ = oFile$ + ".qbb"        ' add the default
  ELSEIF dot% = 1 THEN              ' but if ONLY an extension was given
    oFile$ = oName$ + oFile$        ' make the name the input file base name
  END IF                            ' and the output file extension

  ' make sure that two different files were specified for input and output
  IF UCASE$(iFile$) = UCASE$(oFile$) THEN
    PRINT "The output file can not be the same as the input file."
    END
  END IF

  ' now start parsing the rest of the input parameters (switches)

  ' The comment switch /C[:#]:
  Temp$ = GetParm$("C")
  IF LEFT$(Temp$, 1) < "A" THEN
    CmtCol% = VAL(Temp$)
  ELSE
    CmtCol% = (ASC("A") - 1) - ASC(Temp$)
  END IF
  IF CmtCol% < CmtBELOW% THEN CmtCol% = 0
  CmtCol$ = LEFT$(Temp$, 1)

  '/L:
  LetFlag% = GetParm$("L") = ""

  '/M:#[,#]
  Temp$ = GetParm("M")
  IF Temp$ <> "" THEN
    Comma% = INSTR(Temp$, ",")
    IF Comma% THEN
      Margin% = VAL(LEFT$(Temp$, Comma% - 1))
      Length% = VAL(MID$(Temp$, Comma% + 1))
    ELSE
      Margin% = VAL(Temp$)
      Length% = 0
    END IF
  ELSE
    Margin% = 0
    Length% = 0
  END IF
  IF Length% <= 0 THEN
    Length% = 0
  ELSE
    CmtCol% = CmtABOVE%
    CmtCol$ = "A"
  END IF
  IF Margin% < 0 THEN Margin% = 0
  Margin$ = SPACE$(Margin%)

  '/R:?:
  Temp$ = GetParm("R")
  IF Temp$ <> "" THEN CmtKey% = INSTR("DN'", GetParm("R")) ELSE CmtKey% = CmtTICK%

  '/T:#:
  TabWidth% = VAL(GetParm$("T"))
  IF TabWidth% < 1 THEN TabWidth% = 2
  IF TabWidth% > 12 THEN TabWidth% = 12

  IF GetParm("Q") <> " " THEN ' if a stand-alone parameter (/q) is entered
    IF CmtCol% >= 0 THEN      ' GetParm returns a space, otherwise a null $
      CmtCol$ = LTRIM$(STR$(CmtCol%))
    ELSEIF CmtCol$ = "A" THEN
      CmtCol$ = "ABOVE"
    ELSE
      CmtCol$ = "BELOW"
    END IF

    DIM CmtKey$(1 TO 3)

    CmtKey$(1) = "REMove"
    CmtKey$(2) = "LEAVE 'AS IS'"
    CmtKey$(3) = "CONVERT REM TO '"

    IF Length% > 0 THEN Length$ = "" ELSE Length$ = " (FULL LENGTH)"

    IF LetFlag% THEN LetFlag$ = "TRUE" ELSE LetFlag$ = "FALSE"

    PRINT " input file: '"; UCASE$(iFile$); "'"
    PRINT "output file: '"; UCASE$(oFile$); "'"
    PRINT "comment col: "; CmtCol$
    PRINT "comment key: "; CmtKey$(CmtKey%)
    PRINT "line length:"; Length%; Length$
    PRINT "     margin:"; Margin%
    PRINT "remove LETs: "; LetFlag$
    PRINT "  tab width:"; TabWidth%
    PRINT

    Temp$ = ""
    PRINT "Proceed (Y/N)? ===> ";
    WHILE Temp$ = "": Temp$ = UCASE$(INKEY$): WEND
    PRINT Temp$
    IF Temp$ <> "Y" THEN END
  END IF
END SUB

FUNCTION ParseProgramLine%

  PrintFlag% = -1

  IF InputStatement$ = "" THEN
    LINE INPUT #1, InputStatement$
    DO WHILE RIGHT$(InputStatement$, 2) = " _"
      LINE INPUT #1, Continue$
      InputStatement$ = LEFT$(InputStatement$, LEN(InputStatement$) - 1) + TrimWhite$(Continue$)
    LOOP
    InputStatement$ = TrimWhite$(InputStatement$) 'get rid of any existing indentation
  END IF

  ColonLoc% = LocateKeyWord%(InputStatement$, ":")

  IF ColonLoc% = 0 OR LEFT$(InputStatement$, 3) = "IF " OR LEFT$(InputStatement$, 1) = "'" OR LEFT$(InputStatement$, 7) = "ELSEIF " OR LEFT$(InputStatement$, 4) = "REM " THEN
    Statement$ = InputStatement$
    InputStatement$ = ""
  ELSE
    Statement$ = TrimWhite$(LEFT$(InputStatement$, ColonLoc% - 1))
    InputStatement$ = TrimWhite$(MID$(InputStatement$, ColonLoc% + 1))

    PRINT
    PRINT ColonLoc%
    PRINT Statement$
    PRINT InputStatement$
    'WHILE INKEY$ = "": WEND
  END IF

  Comment$ = ""
  Cmnt% = FindComment%(Statement$) ' look for comments
  CmtFlag% = ABS(Cmnt%) = 1

  IF CmtFlag% AND CmtKey% = CmtNONE% THEN
    PrintFlag% = 0
  ELSE
    IF Cmnt% THEN ' there's a comment
      RemFlag% = Cmnt% < 0
      Cmnt% = ABS(Cmnt%)

      IF CmtKey% <> CmtNONE% THEN
        Comment$ = MID$(Statement$, Cmnt%)
        IF RemFlag% AND CmtKey% <> CmtASIS% THEN Comment$ = "'" + MID$(Comment$, 4)' convert "REM" to "'"
        IF Cmnt% = 1 THEN
          Statement$ = Comment$
          Comment$ = ""
          Cmnt% = LEN(Statement$) + 1
        END IF
      END IF
    ELSE
      Cmnt% = LEN(Statement$) + 1
    END IF

    Statement$ = RTRIM$(LEFT$(Statement$, Cmnt% - 1))
    DO WHILE RIGHT$(Statement$, 1) = ":"
      Statement$ = RTRIM$(LEFT$(Statement$, LEN(Statement$) - 1))
    LOOP
    IF Statement$ <> "" AND LEFT$(Statement$, 1) <> "'" AND INSTR(Statement$, " ") = 0 THEN IF NOT KeyWord%(Statement$) THEN Statement$ = Statement$ + ":"
  END IF

  ParseProgramLine% = PrintFlag%
END FUNCTION

SUB PrintLine (Text$)
  CmntKey$ = LEFT$(Text$, 3)
  IF CmntKey$ = "REM" OR LEFT$(CmntKey$, 1) = "'" THEN
    IF LEFT$(CmntKey$, 1) = "'" THEN CmntKey$ = "'"
  ELSE
    CmntKey$ = ""
  END IF
  CmntSplit$ = ""

  MinLen% = LEN(Margin$ + TabLevel$) + 1

  IF Length% = 0 THEN
    PRINT #2, Margin$ + TabLevel$ + Text$
  ELSE
    IF Text$ = "" THEN Text$ = " " ' allows printing of blank lines
    DO UNTIL Text$ = ""
      Text$ = Margin$ + TabLevel$ + CmntSplit$ + Text$
      split% = LEN(Text$) + 1
      IF split% >= Length% THEN
        FOR split% = Length% TO 1 STEP -1
          IF MID$(Text$, split%, 1) = " " THEN EXIT FOR
        NEXT split%
      END IF
      IF split% < MinLen% THEN
        split% = INSTR(split% + 1, Text$, " ")
        IF split% = 0 THEN split% = LEN(Text$) + 1
      END IF
      PRINT #2, LEFT$(Text$, split% - 1)
      Text$ = MID$(Text$, split% + 1)
      CmntSplit$ = CmntKey$
    LOOP
  END IF
END SUB

SUB PrintProgramLine
  IF Comment$ <> "" AND CmtCol% >= 0 THEN Comment$ = " " + Comment$

  SELECT CASE CmtCol%
    CASE IS >= 0
      sLen% = LEN(Statement$)
      IF sLen% < CmtCol% THEN Statement$ = Statement$ + SPACE$(CmtCol% - sLen%)
      PrintLine (Statement$ + Comment$)
    CASE CmtABOVE%
      IF NOT CmtFlag% AND Comment$ <> "" THEN PrintLine (Comment$)
      PrintLine (Statement$)
    CASE CmtBELOW%
      PrintLine (Statement$)
      IF NOT CmtFlag% AND Comment$ <> "" THEN PrintLine (Comment$)
  END SELECT
END SUB

SUB SetReserved
  RESTORE ReservedData

  FOR Reserved% = ASC("A") TO ASC("Z")
    READ Reserved$(Reserved%)
  NEXT
END SUB

SUB SetStructure (Max%)
  RESTORE StructureData

  FOR Mdx% = 0 TO Max%
    READ Kwd$, Routine$
    Structure$(Mdx%, 1) = Kwd$
    Structure$(Mdx%, 2) = Routine$
  NEXT Mdx%
END SUB

FUNCTION StructureProgramLine%
  StructureProgramLine% = -1 ' preset for no keyword found
  IF NOT CmtFlag% THEN ' if it's not a full line comment
    IF LetFlag% THEN Statement$ = DeLETify$(Statement$) ' suppress useless "LET"statements

    ' DEF FNx does not follow the rules, so...
    IF INSTR(" " + UCASE$(Statement$), " " + "DEF FN") THEN
      Structure% = 26
    ELSE
      FOR Structure% = 1 TO MaxStruct% ' check for structuring stmts
        IF INSTR(" " + Statement$ + " ", " " + Structure$(Structure%, 1) + " ") THEN EXIT FOR
        IF INSTR(" " + Statement$ + ":", " " + Structure$(Structure%, 1) + ":") THEN EXIT FOR
      NEXT Structure%
    END IF
    IF Structure% > MaxStruct% THEN Structure% = 0

    SELECT CASE Structure$(Structure%, 2)
      CASE "NoS": EXIT FUNCTION
      CASE "unN": unNest
      CASE "doI": doIF
      CASE "doDO": doDO
      CASE "doC": doCASEELSE
      CASE "doFO": doFOR
      CASE "doN": doNEXT
      CASE "doFU": doFUNCSUB
      CASE "doS": doSELECT
      CASE "doE": doENDSEL
      CASE "doT": doTYPE
      CASE "doDEF": doDEFFN
      CASE "doW": doWHILE
      CASE "doDEC": doDECLARE
    END SELECT
  END IF

  StructureProgramLine% = PrintFlag%
END FUNCTION

FUNCTION TrimWhite$ (Text$)
  FOR tdx% = 1 TO LEN(Text$)
    IF MID$(Text$, tdx%, 1) > " " THEN EXIT FOR
  NEXT tdx%

  TrimWhite$ = MID$(Text$, tdx%)
END FUNCTION

SUB unNest
IF LEFT$(Statement$, 6) = "END IF" OR LEFT$(Statement$, 4) = "LOOP" THEN GOTO inside
IF LEFT$(Statement$, 4) = "NEXT" OR LEFT$(Statement$, 4) = "CASE" THEN GOTO inside
IF LEFT$(Statement$, 4) = "ELSE" OR LEFT$(Statement$, 12) = "END FUNCTION" THEN GOTO inside
IF LEFT$(Statement$, 7) = "END SUB" OR LEFT$(Statement$, 10) = "END SELECT" THEN GOTO inside
IF LEFT$(Statement$, 4) = "WEND" THEN GOTO inside
IF LEFT$(Statement$, 8) = "END TYPE" OR LEFT$(Statement$, 7) = "END DEF" THEN GOTO inside
GOTO outside
inside:
    IF TabLevel% THEN
      TabLevel% = TabLevel% - TabWidth%
      TabLevel$ = STRING$(TabLevel%, " ")
    END IF
outside:

END SUB

SUB Usage
  CLS
  PRINT "                         Quick Basic Beautifier"
  PRINT
  PRINT "Usage:"
  PRINT
  PRINT "  qbb InFile[.Ext] [OutFile[.Ext]] [/C:A|B|#] [/L] [/M:#[,#]] [/R:?] [/T:#] [/Q]"
  PRINT
  PRINT "  File extentions are optional.  If the InFile extension is omitted,"
  PRINT "  'BAS' is assumed.  If the OutFile extension is omitted, 'QBB' is"
  PRINT "  assumed.  If the OutFile is omitted, 'InFile.QBB' is assumed."
  PRINT "  If the OutFile starts with a '.', OutFile will end up being"
  PRINT "  'InFile.<specified ext>'."
  PRINT
  PRINT "  The colons on the switches are optional.  See the internal comments"
  PRINT "  for documentation on the switches."

  END
END SUB

