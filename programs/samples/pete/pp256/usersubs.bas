'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'  PIXELplus 256 User Subroutines & Functions
'  FREEWARE version 1.0 - (C)1995 Chris Chadwick. All rights reserved.
'  For QBASIC, QuickBASIC and Visual BASIC for MS-DOS
'
'  Consult your PIXELplus 256 User's Manual for full details on how to
'  incorporate and use the routines contained in this file.
'
'  Note: The routines contained in this file do not contain error
'        checking. This makes the code easier to understand.
'
'  *** BEFORE RUNNING THE DEMONSTRATION ***
'  Running the demonstration requires access to four files which should have
'  been supplied with this FREEWARE version of PIXELplus 256. They are:
'
'  CHARSET1.PUT
'  CHARSET2.PUT
'  CHARSET3.PUT
'  STANDARD.PAL
'
'  In your PIXELplus 256 directory (usually C:\PP256), the three .PUT files
'  should be located in the IMAGES subdirectory, and the .PAL file should be
'  located in the PALETTES subdirectory. If you have PIXELplus 256
'  installed in a directory other than C:\PP256 then the value of Path$
'  (see (*) below) should be altered appropriately before running the
'  demonstration.
'
'  Note that CHARSET2.PUT is only a partial character set image file that
'  does not include lower case letters so text to be displayed using it
'  should only contain upper case letters.
'
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

'Variable type to hold screen design item data.
TYPE DesignType
ImageNo AS INTEGER
Xpos AS INTEGER
Ypos AS INTEGER
DisAct AS INTEGER
END TYPE

DECLARE SUB InitPaletteData (FileName$, PaletteArray&())
DECLARE SUB InitDesignData (FileName$, DesignArray() AS DesignType)
DECLARE SUB InitImageData (FileName$, ImageArray%())
DECLARE SUB MakeImageIndex (ImageArray%(), IndexArray%())
DECLARE SUB DisplayDesign (DesignArray() AS DesignType, ImageArray%(), ImageIndex%(), ClsAction%)
DECLARE SUB ChangePalette (PaletteArray&())
DECLARE SUB FadePalette (Direction%, PaletteArray&())
DECLARE SUB RotatePalette (StartAttr%, EndAttr%, Direction%, PaletteArray&())
DECLARE SUB CharPrint (Text$, Fore%, Back%, CursorPos%, ImageArray%())
DECLARE SUB CharPrintXY (x%, y%, Text$, Fore%, Back%, CursorPos%, ImageArray%())
DECLARE SUB Scroller (ScrollAct%, ImageArray%(), IndexArray%())
DECLARE SUB WizzText (Text$, TopLine%, ImageArray%(), IndexArray%())
DECLARE SUB GraphicText (x%, y%, Text$, CursorPos%, ImageArray%(), IndexArray%())
DECLARE FUNCTION GetDepth% (ImNo%, ImageArray%(), IndexArray%())
DECLARE FUNCTION GetWidth% (ImNo%, ImageArray%(), IndexArray%())

DEFINT A-Z

'Constants for subroutine parameters.
CONST INITSCROLL = 0, UPDATESCROLL = 1
CONST OVERPRINT = -1
CONST CENTRETEXT = -1, FROMCURSOR = -2
CONST FADEDOWN = 0, FADEUP = 1
CONST ROTATELEFT = 0, ROTATERIGHT = 1
CONST NEWLINE = 0, TEXTEND = 1

'Change to 320x200, 256 colour VGA screen mode.
SCREEN 13
CLS

'(*) If necessary, change Path$ to the path where
'    you have PIXELplus 256 installed.
Path$ = ".\programs\samples\pete\pp256\"

'Load standard palette.
REDIM StandardPal&(1 TO 1)
CALL InitPaletteData(Path$ + "\palettes\standard.pal", StandardPal&())
CALL ChangePalette(StandardPal&())

'Load character set used by CharPrint() and CharPrintXY() routines.
REDIM Set1Data(1 TO 1)
CALL InitImageData(Path$ + "\images\charset1.put", Set1Data())

'Load bitmapped character set used by WizzText() and Scroller() routines.
'This is a partial character set containing ASCII characters 32 (space)
'to 90 (Z) only.
REDIM Set2Data(1 TO 1)
REDIM Set2Index(1 TO 1)
CALL InitImageData(Path$ + "\images\charset2.put", Set2Data())
CALL MakeImageIndex(Set2Data(), Set2Index())

'Load bitmapped character set used by GraphicText() routine.
REDIM Set3Data(1 TO 1)
REDIM Set3Index(1 TO 1)
CALL InitImageData(Path$ + "\images\charset3.put", Set3Data())
CALL MakeImageIndex(Set3Data(), Set3Index())

'Initialize images used in GAME OVER screen design.
REDIM ImageData(1 TO 1)
REDIM ImageIndex(1 TO 1)
RESTORE SDImageData
CALL InitImageData("", ImageData())
CALL MakeImageIndex(ImageData(), ImageIndex())

'Initialize alternative palette.
REDIM NewPal&(1 TO 1)
RESTORE NewPaletteData
CALL InitPaletteData("", NewPal&())

'Initialize GAME OVER screen design.
REDIM GODesign(1 TO 1) AS DesignType
RESTORE DesignData
CALL InitDesignData("", GODesign())

'*** Draw page 1 of demonstration ***

'Draw a background image so overprinting can be demonstrated properly.
FOR n = 1 TO 12
    LINE (0, 51 + n)-STEP(318, 0), 30 - n
    LINE (0, 53 - n)-STEP(318, 0), 30 - n
NEXT n

'Demonstrate CharPrint() subroutine.
CALL CharPrint("CharPrint() can be used as an", 40, 0, Newline, Set1Data())
CALL CharPrint("alternative to BASIC's own PRINT", 40, 0, Newline, Set1Data())
CALL CharPrint("statement. A user-defined character set", 40, 0, Newline, Set1Data())
CALL CharPrint("is used and text can either be displayed", 40, 0, Newline, Set1Data())
CALL CharPrint("with a ", 40, 0, Textend, Set1Data())
CALL CharPrint("BACKGROUND", 40, 44, Textend, Set1Data())
CALL CharPrint(" colour or...", 40, 0, Newline, Set1Data())
LOCATE 7, 10
CALL CharPrint("O V E R P R I N T E D", 40, Overprint, Newline, Set1Data())
LOCATE 9
CALL CharPrint("on the existing screen image.", 40, 0, Newline, Set1Data())

'Demonstrate CharPrintXY() subroutine.
CALL CharPrintXY(0, 90, "CharPrintXY() is the same as", 33, 44, Newline, Set1Data())
CALL CharPrintXY(2, 99, "CharPrint() except it allows text", 33, 44, Newline, Set1Data())
CALL CharPrintXY(5, 109, "to be displayed at a graphics", 33, 44, Newline, Set1Data())
CALL CharPrintXY(9, 120, "screen coordinate.", 33, 44, Newline, Set1Data())
CALL CharPrintXY(Centretext, 135, "Single lines of", 33, 0, Newline, Set1Data())
CALL CharPrintXY(Centretext, Fromcursor, "text can", 33, 0, Newline, Set1Data())
CALL CharPrintXY(Centretext, Fromcursor, "also be automatically", 33, 0, Newline, Set1Data())
CALL CharPrintXY(Centretext, Fromcursor, "centred on-screen", 33, 0, Newline, Set1Data())
CALL CharPrintXY(Centretext, Fromcursor, "by using CharPrintXY()", 33, 0, Newline, Set1Data())

'Demonstrate Scroller() subroutine and wait for a key press.
RESTORE ScrollMess1
CALL Scroller(Initscroll, Set2Data(), Set2Index())
DO
    CALL Scroller(Updatescroll, Set2Data(), Set2Index())
LOOP WHILE INKEY$ = ""

'*** Draw page 2 of demonstration ***
CLS

'Demonstrate GraphicText() subroutine.
CALL GraphicText(0, 0, "The GraphicText() subroutine is used to display", Newline, Set3Data(), Set3Index())
CALL GraphicText(Fromcursor, Fromcursor, "text that uses a bitmapped character set...", Newline, Set3Data(), Set3Index())
CALL GraphicText(Centretext, 32, "WHICH CAN BE ANY", Newline, Set2Data(), Set2Index())
CALL GraphicText(Centretext, 48, "SIZE YOU LIKE!", Newline, Set2Data(), Set2Index())
CALL GraphicText(0, 72, "Use GraphicText() to display", Newline, Set3Data(), Set3Index())
CALL GraphicText(1, 81, "fancy text at any position", Newline, Set3Data(), Set3Index())
CALL GraphicText(5, 91, "on the screen by using", Newline, Set3Data(), Set3Index())
CALL GraphicText(9, 102, "graphics screen coordinates.", Newline, Set3Data(), Set3Index())
CALL GraphicText(0, 120, "Notice how text is displayed proportionally so", Newline, Set3Data(), Set3Index())
CALL GraphicText(Fromcursor, Fromcursor, "narrow characters like 'i' are still displayed with", Newline, Set3Data(), Set3Index())
CALL GraphicText(Fromcursor, Fromcursor, "the same spacing as wide characters like 'm'.", Newline, Set3Data(), Set3Index())
CALL GraphicText(Centretext, 156, "There's an automatic", Newline, Set3Data(), Set3Index())
CALL GraphicText(Centretext, Fromcursor, "centring option", Newline, Set3Data(), Set3Index())
CALL GraphicText(Centretext, Fromcursor, "too!", Newline, Set3Data(), Set3Index())

'Demonstrate Scroller() subroutine and wait for a key press.
RESTORE ScrollMess2
CALL Scroller(Initscroll, Set2Data(), Set2Index())
DO
    CALL Scroller(Updatescroll, Set2Data(), Set2Index())
LOOP WHILE INKEY$ = ""

'*** Draw page 3 of demonstration ***
CLS

'Demonstrate WizzText() subroutine.
CALL WizzText("THE WIZZTEXT()", 30, Set2Data(), Set2Index())
CALL WizzText("SUBROUTINE CAN BE", 50, Set2Data(), Set2Index())
CALL WizzText("USED TO DISPLAY", 70, Set2Data(), Set2Index())
CALL WizzText("AND CENTRE SINGLE", 90, Set2Data(), Set2Index())
CALL WizzText("LINES OF BITMAPPED", 110, Set2Data(), Set2Index())
CALL WizzText("TEXT IN A MORE", 130, Set2Data(), Set2Index())
CALL WizzText("EXCITING WAY!", 150, Set2Data(), Set2Index())

'Demonstrate Scroller() subroutine and wait for a key press.
RESTORE ScrollMess2
CALL Scroller(Initscroll, Set2Data(), Set2Index())
DO
    CALL Scroller(Updatescroll, Set2Data(), Set2Index())
LOOP WHILE INKEY$ = ""

'*** Draw page 4 of demonstration ***
CLS

'Draw a palette grid showing all 256 available colours.
FOR rr = 0 TO 15
    FOR cc = 0 TO 15
        LINE (32 + cc * 16, 40 + rr * 8)-STEP(14, 6), (rr * 16) + cc, BF
    NEXT cc
NEXT rr

'Display explanation text.
CALL GraphicText(0, 8, "Using the ChangePalette() subroutine allows you", Newline, Set3Data(), Set3Index())
CALL GraphicText(Fromcursor, Fromcursor, "to quickly change palettes...", Newline, Set3Data(), Set3Index())

'Demonstrate ChangePalette() subroutine.
FOR n = 1 TO 5
    SLEEP 1
    CALL ChangePalette(StandardPal&())
    SLEEP 1
    CALL ChangePalette(NewPal&())
NEXT n

'Clear old text from top of screen.
LINE (0, 0)-(319, 38), 0, BF

'Display explanation text.
CALL GraphicText(0, 8, "Use the RotatePalette() subroutine to shift a", Newline, Set3Data(), Set3Index())
CALL GraphicText(Fromcursor, Fromcursor, "range of colours to the left or right...", Newline, Set3Data(), Set3Index())

'Demonstrate RotatePalette() subroutine.
FOR n = 1 TO 8
    SLEEP 1
    CALL RotatePalette(32, 47, Rotateright, NewPal&())
NEXT n
FOR n = 1 TO 8
    SLEEP 1
    CALL RotatePalette(32, 47, Rotateleft, NewPal&())
NEXT n

'Clear old text from top of screen.
LINE (0, 0)-(319, 38), 0, BF

'Display explanation text.
CALL GraphicText(0, 8, "Use the FadePalette() subroutine to gradually", Newline, Set3Data(), Set3Index())
CALL GraphicText(Fromcursor, Fromcursor, "fade out the display...", Newline, Set3Data(), Set3Index())

'Demonstrate FadePalette() subroutine.
SLEEP 3
CALL FadePalette(Fadedown, NewPal&())
LINE (0, 0)-(319, 38), 0, BF
CALL GraphicText(0, 8, "...then gradually fade it back in!", Newline, Set3Data(), Set3Index())
SLEEP 1
CALL FadePalette(Fadeup, NewPal&())

'Demonstrate Scroller() subroutine and wait for a key press.
RESTORE ScrollMess2
CALL Scroller(Initscroll, Set2Data(), Set2Index())
DO
    CALL Scroller(Updatescroll, Set2Data(), Set2Index())
LOOP WHILE INKEY$ = ""

'*** Draw page 5 of demonstration ***
CLS

'Display explanation text.
CALL GraphicText(0, 0, "This is a simple screen design and shows how", Newline, Set3Data(), Set3Index())
CALL GraphicText(Fromcursor, Fromcursor, "RotatePalette() can be used to create", Newline, Set3Data(), Set3Index())
CALL GraphicText(Fromcursor, Fromcursor, "very colourful effects...", Newline, Set3Data(), Set3Index())

'Display GAME OVER screen design.
CALL DisplayDesign(GODesign(), ImageData(), ImageIndex(), 0)

'Demonstrate Scroller() and RotatePalette() subroutines
'while waiting for a key press.
RESTORE ScrollMess2
CALL Scroller(Initscroll, Set2Data(), Set2Index())
DO
    'Scroller() is called more often than RotatePalette() so that
    'the palette isn't rotated too quickly.
    CALL Scroller(Updatescroll, Set2Data(), Set2Index())
    CALL Scroller(Updatescroll, Set2Data(), Set2Index())
    CALL RotatePalette(176, 255, Rotateright, NewPal&())
LOOP WHILE INKEY$ = ""

'Fade and blank screen before ending.
CALL FadePalette(Fadedown, NewPal&())
CLS

'Restore standard palette.
CALL ChangePalette(StandardPal&())


'*** Message text for Scroller() subroutine (upper case only) ***
ScrollMess1:
DATA "THIS IS A SCROLLING MESSAGE DISPLAYED USING THE SCROLLER() ROUTINE..."
DATA "                    "
ScrollMess2:
DATA "PRESS A KEY TO CONTINUE..."
DATA "                    "
DATA ""

'*** Data for images used in GAME OVER screen design ***
SDImageData:
DATA 360
DATA 128,16,0,0,-8448,-8225,-8225,223,0,0,0,-8448,-8225,-8739,-8739,-8225,223,0,0,-8225
DATA -8739,-9253,-9253,-8739,-8225,0,-8448,-8737,-9253,-9767,-9767,-9253,-8227,223,-8448,-9251,-9767,-10538,-10538,-9767
DATA -8741,223,-8225,-9251,-10535,-11052,-11052,-9770,-8741,-8225,-8737,-9765,-11050,-11564,-11054,-10540,-9255,-8227,-8737,-9765
DATA -11050,-12078,-11568,-10540,-9255,-8227,-8737,-9765,-11050,-12078,-11568,-10540,-9255,-8227,-8737,-9765,-11050,-11564,-11054,-10540
DATA -9255,-8227,-8225,-9251,-10535,-11052,-11052,-9770,-8741,-8225,-8448,-9251,-9767,-10538,-10538,-9767,-8741,223,-8448,-8737
DATA -9253,-9767,-9767,-9253,-8227,223,0,-8225,-8739,-9253,-9253,-8739,-8225,0,0,-8448,-8225,-8739,-8739,-8225
DATA 223,0,0,0,-8448,-8225,-8225,223,0,0,128,16,-1,-1,255,0,0,-256,-1,-1
DATA -1,255,0,0,0,0,-256,-1,-1,0,0,0,0,0,0,-1,255,0,0,0
DATA 0,0,0,-256,255,0,0,0,0,0,0,-256,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 255,0,0,0,0,0,0,-256,255,0,0,0,0,0,0,-256,-1,0,0,0
DATA 0,0,0,-1,-1,255,0,0,0,0,-256,-1,-1,-1,255,0,0,-256,-1,-1
DATA 112,14,-8996,-11563,-9772,-8740,-10533,-11310,-9769,-10021,-11053,-9255,-9765,-10794,-11053,-9255,-10793,-10283,-10792,-11309
DATA -10027,-11050,-9000,-10796,-11050,-11309,-10797,-9254,-11563,-9003,-11309,-11821,-10542,-8998,-9250,-11308,-9002,-11049,-11566,-10798
DATA -8228,-9762,-10540,-8741,-9507,-10537,-10797,-8484,-11046,-10798,-8996,-8996,-9509,-9512,-9507,-11820,-10799,-9765,-9514,-8997
DATA -8483,-10788,-12079,-10029,-10791,-9517,-8996,-8226,-11301,-11311,-10283,-10795,-9259,-10022,-8484,-11303,-10541,-11306,-10029,-9255
DATA -10538,-9509,-10795,-10793,-11309,-9770,-8996,-9768,-10791,-9515,-10533,-9771,-10021,-8482,-9251,-11307,-8487,-10018,-10536,-11046

'*** Alternative palette data ***
NewPaletteData:
DATA 0,2752512,10752,2763264,42,2752554,5418,2763306
DATA 1381653,4134165,1392405,4144917,1381695,4134207,1392447,4144959
DATA 8751,271408,534065,862258,1124915,1387572,1650229,1912886
DATA 2240824,2503481,2766138,3028795,3291452,3619645,3882302,4144959
DATA 4128768,4128784,4128799,4128815,4128831,3080255,2031679,1048639
DATA 63,4159,7999,12095,16191,16175,16159,16144
DATA 16128,1064704,2047744,3096320,4144896,4140800,4136704,4132864
DATA 4136735,4136743,4136751,4136759,4136767,3612479,3088191,2563903
DATA 2039615,2041663,2043711,2045759,2047807,2047799,2047791,2047783
DATA 2047775,2572063,3096351,3620639,4144927,4142879,4140831,4138783
DATA 4140333,4140337,4140342,4140346,4140351,3812671,3550527,3222847
DATA 2960703,2961727,2963007,2964031,2965311,2965306,2965302,2965297
DATA 2965293,3227437,3555117,3817261,4144941,4143661,4142637,4141357
DATA 1835008,1835015,1835022,1835029,1835036,1376284,917532,458780
DATA 921130,986666,986667,1052203,1052459,1117996,1183532,1183532
DATA 1249069,1249069,1314605,1314606,1380398,1445934,1445935,1511471
DATA 1511471,1577008,1642544,1642544,1708337,1708337,1773873,1839410
DATA 1839410,1904946,1904947,1970483,1970739,2036276,2101812,2101812
DATA 2167349,2167349,2232885,2298422,2298678,2364214,2364215,2429751
DATA 2429751,2495288,2560824,2560824,2626617,2626617,2692153,2757690
DATA 2757690,2823226,2823227,2888763,2954555,2954556,3020092,3020092
DATA 3085629,3085629,3151165,3216702,3216958,3282494,3282495,3348031
DATA 4128768,3867648,3606528,3280128,3019008,2757888,2496768,2235648
DATA 1909248,1648128,1387008,1125888,864768,538368,277248,16128
DATA 16132,16136,16140,16144,16148,16152,16156,16160
DATA 16163,16167,16171,16175,16179,16183,16187,16191
DATA 15167,14143,13119,12095,11071,10047,9023,7999
DATA 7231,6207,5183,4159,3135,2111,1087,63
DATA 262207,524351,786495,1048639,1310783,1572927,1835071,2097215
DATA 2293823,2555967,2818111,3080255,3342399,3604543,3866687,4128831
DATA 4128827,4128823,4128819,4128815,4128811,4128807,4128803,4128799
DATA 4128796,4128792,4128788,4128784,4128780,4128776,4128772,4128768

'*** GAME OVER screen design data ***
DesignData:
DATA 346
DATA 2,72,40,5,1,72,40,3,2,64,32,5,1,64,32,3,2,56,32,5
DATA 1,56,32,3,2,48,32,5,1,48,32,3,2,40,32,5,1,40,32,3
DATA 2,32,40,5,1,32,40,3,2,32,48,5,1,32,48,3,2,32,56,5
DATA 1,32,56,3,2,32,64,5,1,32,64,3,2,32,72,5,1,32,72,3
DATA 2,32,80,5,1,32,80,3,2,40,88,5,1,40,88,3,2,48,88,5
DATA 1,48,88,3,2,56,88,5,1,56,88,3,2,64,88,5,1,64,88,3
DATA 2,72,80,5,1,72,80,3,2,72,72,5,1,72,72,3,2,72,64,5
DATA 1,72,64,3,2,64,64,5,1,64,64,3,2,56,64,5,1,56,64,3
DATA 2,96,88,5,1,96,88,3,2,96,80,5,1,96,80,3,2,96,72,5
DATA 1,96,72,3,2,96,64,5,1,96,64,3,2,96,56,5,1,96,56,3
DATA 2,96,48,5,1,96,48,3,2,104,40,5,1,104,40,3,2,112,32,5
DATA 1,112,32,3,2,120,32,5,1,120,32,3,2,128,40,5,1,128,40,3
DATA 2,136,48,5,1,136,48,3,2,136,56,5,1,136,56,3,2,136,64,5
DATA 1,136,64,3,2,136,72,5,1,136,72,3,2,136,80,5,1,136,80,3
DATA 2,136,88,5,1,136,88,3,2,128,64,5,1,128,64,3,2,120,64,5
DATA 1,120,64,3,2,112,64,5,1,112,64,3,2,104,64,5,1,104,64,3
DATA 2,160,88,5,1,160,88,3,2,160,80,5,1,160,80,3,2,160,72,5
DATA 1,160,72,3,2,160,64,5,1,160,64,3,2,160,56,5,1,160,56,3
DATA 2,160,48,5,1,160,48,3,2,160,40,5,1,160,40,3,2,160,32,5
DATA 1,160,32,3,2,168,40,5,1,168,40,3,2,176,48,5,1,176,48,3
DATA 2,184,56,5,1,184,56,3,2,192,48,5,1,192,48,3,2,200,40,5
DATA 1,200,40,3,2,208,32,5,1,208,32,3,2,208,40,5,1,208,40,3
DATA 2,208,48,5,1,208,48,3,2,208,56,5,1,208,56,3,2,208,64,5
DATA 1,208,64,3,2,208,72,5,1,208,72,3,2,208,80,5,1,208,80,3
DATA 2,208,88,5,1,208,88,3,2,232,32,5,1,232,32,3,2,232,40,5
DATA 1,232,40,3,2,232,48,5,1,232,48,3,2,232,56,5,1,232,56,3
DATA 2,232,64,5,1,232,64,3,2,232,72,5,1,232,72,3,2,232,80,5
DATA 1,232,80,3,2,232,88,5,1,232,88,3,2,240,88,5,1,240,88,3
DATA 2,248,88,5,1,248,88,3,2,256,88,5,1,256,88,3,2,264,88,5
DATA 1,264,88,3,2,272,88,5,1,272,88,3,2,240,32,5,1,240,32,3
DATA 2,248,32,5,1,248,32,3,2,256,32,5,1,256,32,3,2,264,32,5
DATA 1,264,32,3,2,272,32,5,1,272,32,3,2,240,64,5,1,240,64,3
DATA 2,248,64,5,1,248,64,3,2,256,64,5,1,256,64,3,2,264,64,5
DATA 1,264,64,3,2,68,112,5,1,68,112,3,2,60,112,5,1,60,112,3
DATA 2,52,112,5,1,52,112,3,2,44,112,5,1,44,112,3,2,36,120,5
DATA 1,36,120,3,2,36,128,5,1,36,128,3,2,36,136,5,1,36,136,3
DATA 2,36,144,5,1,36,144,3,2,36,152,5,1,36,152,3,2,36,160,5
DATA 1,36,160,3,2,44,168,5,1,44,168,3,2,52,168,5,1,52,168,3
DATA 2,60,168,5,1,60,168,3,2,68,168,5,1,68,168,3,2,76,160,5
DATA 1,76,160,3,2,76,152,5,1,76,152,3,2,76,144,5,1,76,144,3
DATA 2,76,136,5,1,76,136,3,2,76,128,5,1,76,128,3,2,76,120,5
DATA 1,76,120,3,2,100,112,5,1,100,112,3,2,100,120,5,1,100,120,3
DATA 2,100,128,5,1,100,128,3,2,100,136,5,1,100,136,3,2,100,144,5
DATA 1,100,144,3,2,100,152,5,1,100,152,3,2,108,160,5,1,108,160,3
DATA 2,116,168,5,1,116,168,3,2,124,168,5,1,124,168,3,2,132,160,5
DATA 1,132,160,3,2,140,152,5,1,140,152,3,2,140,144,5,1,140,144,3
DATA 2,140,136,5,1,140,136,3,2,140,128,5,1,140,128,3,2,140,120,5
DATA 1,140,120,3,2,140,112,5,1,140,112,3,2,164,112,5,1,164,112,3
DATA 2,164,120,5,1,164,120,3,2,164,128,5,1,164,128,3,2,164,136,5
DATA 1,164,136,3,2,164,144,5,1,164,144,3,2,164,152,5,1,164,152,3
DATA 2,164,160,5,1,164,160,3,2,164,168,5,1,164,168,3,2,172,168,5
DATA 1,172,168,3,2,180,168,5,1,180,168,3,2,188,168,5,1,188,168,3
DATA 2,196,168,5,1,196,168,3,2,204,168,5,1,204,168,3,2,172,112,5
DATA 1,172,112,3,2,180,112,5,1,180,112,3,2,188,112,5,1,188,112,3
DATA 2,196,112,5,1,196,112,3,2,204,112,5,1,204,112,3,2,172,144,5
DATA 1,172,144,3,2,180,144,5,1,180,144,3,2,188,144,5,1,188,144,3
DATA 2,196,144,5,1,196,144,3,2,236,112,5,1,236,112,3,2,244,112,5
DATA 1,244,112,3,2,252,112,5,1,252,112,3,2,260,112,5,1,260,112,3
DATA 2,268,120,5,1,268,120,3,2,268,128,5,1,268,128,3,2,268,136,5
DATA 1,268,136,3,2,260,144,5,1,260,144,3,2,252,144,5,1,252,144,3
DATA 2,244,144,5,1,244,144,3,2,236,144,5,1,236,144,3,2,268,168,5
DATA 1,268,168,3,2,260,160,5,1,260,160,3,2,252,152,5,1,252,152,3
DATA 2,228,112,5,1,228,112,3,2,228,120,5,1,228,120,3,2,228,128,5
DATA 1,228,128,3,2,228,136,5,1,228,136,3,2,228,144,5,1,228,144,3
DATA 2,228,152,5,1,228,152,3,2,228,160,5,1,228,160,3,2,228,168,5
DATA 1,228,168,3,3,0,38,1,3,0,52,1,3,0,66,1,3,0,80,1
DATA 3,0,94,1,3,0,108,1,3,0,122,1,3,0,136,1,3,0,150,1
DATA 3,0,164,1,3,306,38,1,3,306,52,1,3,306,66,1,3,306,80,1
DATA 3,306,94,1,3,306,108,1,3,306,122,1,3,306,136,1,3,306,150,1
DATA 3,306,164,1

'* ChangePalette() subroutine:
'* Quickly changes the current colour palette to the colours held in
'* a palette array.
'*
'* Parameters:
'* PaletteArray&() - Long integer array holding the colours to be used as
'*                   the new colour palette. This array must have previously
'*                   been initialized by calling InitPaletteData().
'*
SUB ChangePalette (PaletteArray&())

'Break down all 256 colours into their RGB values.
DIM RGBval(0 TO 255, 0 TO 2)
FOR n = 0 TO 255
    c& = PaletteArray&(n)
    b = c& \ 65536: c& = c& - b * 65536
    g = c& \ 256: c& = c& - g * 256
    r = c&
    RGBval(n, 0) = r
    RGBval(n, 1) = g
    RGBval(n, 2) = b
NEXT n

'Write colours directly to the video card.
WAIT &H3DA, &H8, &H8: WAIT &H3DA, &H8
FOR n = 0 TO 255
    OUT &H3C8, n 'Select attribute.
    OUT &H3C9, RGBval(n, 0) 'Write red.
    OUT &H3C9, RGBval(n, 1) 'Write green.
    OUT &H3C9, RGBval(n, 2) 'Write blue.
NEXT n

END SUB

'* CharPrint() subroutine:
'* Displays a text string using a character set designed with PIXELplus 256.
'* Text can be displayed using both a foreground and background colour, or
'* can be overprinted on the existing screen image using the foreground
'* colour.
'*
'* Parameters:
'*        Text$ - The text string to be displayed.
'*         Fore - The foreground colour to display text in.
'*         Back - The background colour to display text in or use OVERPRINT
'*                to have the text overprinted on the existing screen image.
'*    CursorPos - Dictates where the text cursor should be left after
'*                the text has been displayed:
'*                Use NEWLINE to move the cursor to the start of a new line.
'*                Use TEXTEND to leave the cursor directly after the last
'*                character displayed.
'* ImageArray() - Image array holding the character set to be used. Each
'*                character must be an 8x8 image and be in the standard
'*                ASCII order, starting with the space character.
'*
SUB CharPrint (Text$, Fore, Back, CursorPos, ImageArray())

'Create an 8x8 image array to build a character in.
DIM NewChar(1 TO 34)
NewChar(1) = 64: NewChar(2) = 8
   
'Convert text cursor position to graphics (x,y) coordinates.
x = (POS(0) - 1) * 8: y = (CSRLIN - 1) * 8

'Get high byte equivalent of Fore & Back colours.
HighFore = 0: HighBack = 0
DEF SEG = VARSEG(HighFore)
POKE VARPTR(HighFore) + 1, Fore
DEF SEG = VARSEG(HighBack)
POKE VARPTR(HighBack) + 1, Back
DEF SEG

IF Back = Overprint THEN
    '*** Overprint text onto existing screen image ***

    'Loop to build and display each character of Text$.
    FOR j = 1 TO LEN(Text$)
        GET (x, y)-STEP(7, 7), NewChar(1)

        BasePtr = (ASC(MID$(Text$, j, 1)) - 32) * 34

        'Build new character image in NewChar().
        FOR n = 3 TO 34
            PixPair = ImageArray(BasePtr + n)

            IF (PixPair AND &HFF) THEN
                LowByte = Fore
            ELSE
                LowByte = NewChar(n) AND &HFF
            END IF

            IF (PixPair AND &HFF00) THEN
                NewChar(n) = HighFore OR LowByte
            ELSE
                NewChar(n) = (NewChar(n) AND &HFF00) OR LowByte
            END IF
        NEXT n

        'Display the character.
        PUT (x, y), NewChar(1), PSET

        'Find screen coordinates for next character.
        IF x = 312 THEN
            x = 0
            IF y <> 192 THEN y = y + 8
        ELSE
            x = x + 8
        END IF
    NEXT j
ELSE
    '*** Display text using foreground & background colours ***

    'Loop to build and display each character of Text$.
    FOR j = 1 TO LEN(Text$)
        BasePtr = (ASC(MID$(Text$, j, 1)) - 32) * 34

        'Build new character image in NewChar().
        FOR n = 3 TO 34
            PixPair = ImageArray(BasePtr + n)

            IF (PixPair AND &HFF) THEN
                LowByte = Fore
            ELSE
                LowByte = Back
            END IF

            IF (PixPair AND &HFF00) THEN
                NewChar(n) = HighFore OR LowByte
            ELSE
                NewChar(n) = HighBack OR LowByte
            END IF
        NEXT n

        'Display the character.
        PUT (x, y), NewChar(1), PSET

        'Find screen coordinates for next character.
        IF x = 312 THEN
            x = 0
            IF y <> 192 THEN y = y + 8
        ELSE
            x = x + 8
        END IF
    NEXT j
END IF

'Update text cursor to required position before exiting.
c = (x \ 8) + 1: r = (y \ 8) + 1
IF CursorPos = Newline THEN
    'Check a new line is actually required.
    IF c <> 1 THEN
        c = 1
        IF r < 25 THEN r = r + 1
    END IF
END IF
LOCATE r, c

END SUB

'* CharPrintXY() subroutine:
'* Displays a text string at a graphics screen coordinate, using a character
'* set designed with PIXELplus 256. Text can be displayed using both a
'* foreground and background colour, or can be overprinted on the existing
'* screen image using the foreground colour.
'*
'* Parameters:
'*            x - Horizontal coordinate of where printing should start or:
'*                Use FROMCURSOR to use the current graphics cursor X
'*                coordinate.
'*                Use CENTRETEXT to have the text centred.
'*            y - Vertical coordinate of where printing should start or
'*                use FROMCURSOR to use the current graphics cursor Y
'*                coordinate.
'*        Text$ - The text string to be displayed.
'*         Fore - The foreground colour to display text in.
'*         Back - The background colour to display text in or use OVERPRINT
'*                to have the text overprinted on the existing screen image.
'*    CursorPos - Dictates where the graphics cursor should be left after
'*                the text has been displayed:
'*                Use NEWLINE to move the cursor to the start of a new line.
'*                Use TEXTEND to leave the cursor directly after the last
'*                character displayed.
'* ImageArray() - Image array holding the character set to be used. Each
'*                character must be an 8x8 image and be in the standard
'*                ASCII order, starting with the space character.
'*
SUB CharPrintXY (x, y, Text$, Fore, Back, CursorPos, ImageArray())

MessLen = LEN(Text$)
IF x = Centretext THEN
    'Find start X coordinate for centred text.
    w = MessLen * 8
    x = (320 - w) \ 2
ELSEIF x = Fromcursor THEN
    'Use current X coordinate.
    x = POINT(0)
END IF

'Use current Y coordinate if requested.
IF y = Fromcursor THEN y = POINT(1)

'Create an 8x8 image array to build a character in.
DIM NewChar(1 TO 34)
NewChar(1) = 64: NewChar(2) = 8

'Get high byte equivalent of Fore & Back colours.
HighFore = 0: HighBack = 0
DEF SEG = VARSEG(HighFore)
POKE VARPTR(HighFore) + 1, Fore
DEF SEG = VARSEG(HighBack)
POKE VARPTR(HighBack) + 1, Back
DEF SEG

IF Back = Overprint THEN
    '*** Overprint text onto existing screen image ***

    'Loop to build and display each character of Text$.
    FOR j = 1 TO LEN(Text$)
        GET (x, y)-STEP(7, 7), NewChar(1)

        BasePtr = (ASC(MID$(Text$, j, 1)) - 32) * 34

        'Build new character image in NewChar().
        FOR n = 3 TO 34
            PixPair = ImageArray(BasePtr + n)

            IF (PixPair AND &HFF) THEN
                LowByte = Fore
            ELSE
                LowByte = NewChar(n) AND &HFF
            END IF

            IF (PixPair AND &HFF00) THEN
                NewChar(n) = HighFore OR LowByte
            ELSE
                NewChar(n) = (NewChar(n) AND &HFF00) OR LowByte
            END IF
        NEXT n

        'Display the character.
        PUT (x, y), NewChar(1), PSET

        'Find screen coordinates for next character.
        IF x >= 305 THEN
            x = 0
            IF y >= 185 THEN y = 192 ELSE y = y + 8
        ELSE
            x = x + 8
        END IF
    NEXT j
ELSE
    '*** Display text using foreground & background colours ***

    'Loop to build and display each character of Text$.
    FOR j = 1 TO LEN(Text$)
        BasePtr = (ASC(MID$(Text$, j, 1)) - 32) * 34

        'Build new character image in NewChar().
        FOR n = 3 TO 34
            PixPair = ImageArray(BasePtr + n)

            IF (PixPair AND &HFF) THEN
                LowByte = Fore
            ELSE
                LowByte = Back
            END IF

            IF (PixPair AND &HFF00) THEN
                NewChar(n) = HighFore OR LowByte
            ELSE
                NewChar(n) = HighBack OR LowByte
            END IF
        NEXT n

        'Display the character.
        PUT (x, y), NewChar(1), PSET

        'Find screen coordinates for next character.
        IF x >= 305 THEN
            x = 0
            IF y >= 185 THEN y = 192 ELSE y = y + 8
        ELSE
            x = x + 8
        END IF
    NEXT j
END IF

'Update graphics cursor to required position before exiting.
IF CursorPos = Newline THEN
    'Check a new line is actually required.
    IF x <> 0 THEN
        x = 0
        IF y < 185 THEN y = y + 8
    END IF
END IF
PSET (x, y), POINT(x, y)

END SUB

'* DisplayDesign() subroutine:
'* Displays the screen design held in DesignArray() using the images held
'* in ImageArray().
'*
'* Parameters:
'* DesignArray() - Dynamic, DesignType array holding screen design data.
'*  ImageArray() - Dynamic, integer array holding the images to use for
'*                 displaying the screen design.
'*  IndexArray() - Dynamic, integer array holding the index for images in
'*                 ImageArray().
'*     ClsAction - A non-zero value causes the screen to be cleared before
'*                 the screen design is displayed.
'*
SUB DisplayDesign (DesignArray() AS DesignType, ImageArray(), ImageIndex(), ClsAction)

'Only clear the screen if requested to.
IF ClsAction THEN CLS

LastItem = UBOUND(DesignArray)

'Loop to display all items in the screen design.
FOR n = 1 TO LastItem
    ImageNo = DesignArray(n).ImageNo
    Xpos = DesignArray(n).Xpos
    Ypos = DesignArray(n).Ypos
    DisAct = DesignArray(n).DisAct

    'Mask-out high byte of DisAct to find display action code.
    SELECT CASE (DisAct AND &HFF)
        CASE 1
            PUT (Xpos, Ypos), ImageArray(ImageIndex(ImageNo)), PSET
        CASE 2
            PUT (Xpos, Ypos), ImageArray(ImageIndex(ImageNo)), PRESET
        CASE 3
            PUT (Xpos, Ypos), ImageArray(ImageIndex(ImageNo)), OR
        CASE 4
            PUT (Xpos, Ypos), ImageArray(ImageIndex(ImageNo)), XOR
        CASE 5
            PUT (Xpos, Ypos), ImageArray(ImageIndex(ImageNo)), AND
    END SELECT
NEXT n

END SUB

'* FadePalette() subroutine:
'* Gradually fades the current display in or out by fading all the colours in
'* the currently active palette down (fade to black) or up (restore colours).
'*
'* Parameters:
'*       Direction - Dictates what direction the currently active colour
'*                   palette should be faded in:
'*                   Use FADEDOWN to fade down all colours to black.
'*                   Use FADEUP to fade up all colours from black to their
'*                   true colours.
'* PaletteArray&() - Palette array holding the colours of the currently
'*                   active colour palette.
'*
SUB FadePalette (Direction, PaletteArray&())

IF Direction = Fadedown THEN
    '*** Fade palette down ***

    'Break down all 256 colours into their RGB values and
    'calculate how much each will need fading down by.
    DIM RGBval!(0 TO 255, 0 TO 2)
    DIM SubVal!(0 TO 255, 0 TO 2)
    FOR n = 0 TO 255
        c& = PaletteArray&(n)
        b = c& \ 65536: c& = c& - b * 65536
        g = c& \ 256: c& = c& - g * 256
        r = c&
        RGBval!(n, 0) = r
        RGBval!(n, 1) = g
        RGBval!(n, 2) = b
        SubVal!(n, 0) = r / 63
        SubVal!(n, 1) = g / 63
        SubVal!(n, 2) = b / 63
    NEXT n

    'Fade down all 256 colours in 63 steps.
    FOR j = 1 TO 63
        'Calculate new faded down RGB values.
        FOR n = 0 TO 255
            RGBval!(n, 0) = RGBval!(n, 0) - SubVal!(n, 0)
            RGBval!(n, 1) = RGBval!(n, 1) - SubVal!(n, 1)
            RGBval!(n, 2) = RGBval!(n, 2) - SubVal!(n, 2)
        NEXT n

        'Write faded down colours directly to the video card.
        WAIT &H3DA, &H8, &H8: WAIT &H3DA, &H8
        FOR n = 0 TO 255
            OUT &H3C8, n 'Select attribute.
            OUT &H3C9, RGBval!(n, 0) 'Write red.
            OUT &H3C9, RGBval!(n, 1) 'Write green.
            OUT &H3C9, RGBval!(n, 2) 'Write blue.
        NEXT n
    NEXT j
ELSE
    '*** Fade palette up ***

    'Break down all 256 colours into their RGB values and
    'calculate how much each will need fading up by.
    DIM RGBval!(0 TO 255, 0 TO 2)
    DIM AddVal!(0 TO 255, 0 TO 2)
    FOR n = 0 TO 255
        c& = PaletteArray&(n)
        b = c& \ 65536: c& = c& - b * 65536
        g = c& \ 256: c& = c& - g * 256
        r = c&
        AddVal!(n, 0) = r / 63
        AddVal!(n, 1) = g / 63
        AddVal!(n, 2) = b / 63
    NEXT n

    'Fade up all 256 colours in 63 steps.
    FOR j = 1 TO 63
        'Calculate new faded up RGB values.
        FOR n = 0 TO 255
            RGBval!(n, 0) = RGBval!(n, 0) + AddVal!(n, 0)
            RGBval!(n, 1) = RGBval!(n, 1) + AddVal!(n, 1)
            RGBval!(n, 2) = RGBval!(n, 2) + AddVal!(n, 2)
        NEXT n

        'Write faded up colours directly to the video card.
        WAIT &H3DA, &H8, &H8: WAIT &H3DA, &H8
        FOR n = 0 TO 255
            OUT &H3C8, n 'Select attribute.
            OUT &H3C9, RGBval!(n, 0) 'Write red.
            OUT &H3C9, RGBval!(n, 1) 'Write green.
            OUT &H3C9, RGBval!(n, 2) 'Write blue.
        NEXT n
    NEXT j
END IF

END SUB

'* GetDepth() function:
'* Returns the depth (in pixels) of any image contained in an image array.
'*
'* Parameters:
'*         ImNo - The number of the image to return the depth of.
'* ImageArray() - Image array that contains the image.
'* IndexArray() - Index array for the images in ImageArray().
'*
FUNCTION GetDepth (ImNo, ImageArray(), IndexArray())

GetDepth = ImageArray(IndexArray(ImNo) + 1)

END FUNCTION

'* GetWidth() function:
'* Returns the width (in pixels) of any image contained in an image array.
'*
'* Parameters:
'*         ImNo - The number of the image to return the width of.
'* ImageArray() - Image array that contains the image.
'* IndexArray() - Index array for the images in ImageArray().
'*
FUNCTION GetWidth (ImNo, ImageArray(), IndexArray())

GetWidth = ImageArray(IndexArray(ImNo)) \ 8

END FUNCTION

'* GraphicText() subroutine:
'* Displays a text string at a graphics screen coordinate, using a bitmapped
'* character set.
'*
'* Parameters:
'*            x - Horizontal coordinate of where printing should start or:
'*                Use FROMCURSOR to use the current graphics cursor X
'*                coordinate.
'*                Use CENTRETEXT to have the text centred.
'*            y - Vertical coordinate of where printing should start or
'*                use FROMCURSOR to use the current graphics cursor Y
'*                coordinate.
'*        Text$ - The text string to be displayed.
'*    CursorPos - Dictates where the graphics cursor should be left after
'*                the text has been displayed:
'*                Use NEWLINE to move the cursor to the start of a new line.
'*                Use TEXTEND to leave the cursor directly after the last
'*                character displayed.
'* ImageArray() - Image array holding the character set to be used. Each
'*                character must in the standard ASCII order, starting with
'*                the space character.
'* IndexArray() - Index array for the character images in ImageArray().
'*
SUB GraphicText (x, y, Text$, CursorPos, ImageArray(), IndexArray())

MessLen = LEN(Text$)
IF x = Centretext THEN
    'Find start X coordinate for centred text.
    w = 0
    FOR n = 1 TO MessLen
        CharNo = ASC(MID$(Text$, n, 1)) - 31
        w = w + GetWidth(CharNo, ImageArray(), IndexArray())
    NEXT n
    x = (320 - w) \ 2
ELSEIF x = Fromcursor THEN
    'Use current X coordinate.
    x = POINT(0)
END IF

'Use current Y coordinate if requested.
IF y = Fromcursor THEN y = POINT(1)

CharDepth = GetDepth(1, ImageArray(), IndexArray())

'Loop to display each character of Text$.
FOR n = 1 TO MessLen
    CharNo = ASC(MID$(Text$, n, 1)) - 31
    CharWidth = GetWidth(CharNo, ImageArray(), IndexArray())

    'Screen coordinate management for current character.
    IF x + CharWidth > 320 THEN
        x = 0
        IF (y + CharDepth + CharDepth - 1) > 199 THEN
            y = 200 - CharDepth
        ELSE
            y = y + CharDepth
        END IF
    END IF

    PUT (x, y), ImageArray(IndexArray(CharNo)), PSET
    x = x + CharWidth
NEXT n

'Ensure x and y are valid screen coordinates.
IF x > 319 THEN
    x = 0
    IF (y + CharDepth + CharDepth - 1) > 199 THEN
        y = 200 - CharDepth
    ELSE
        y = y + CharDepth
    END IF
END IF

'Update graphics cursor to required position before exiting.
IF CursorPos = Newline THEN
    'Check a new line is actually required.
    IF x <> 0 THEN
        x = 0
        IF (y + CharDepth + CharDepth - 1) > 199 THEN
            y = 200 - CharDepth
        ELSE
            y = y + CharDepth
        END IF
    END IF
END IF
PSET (x, y), POINT(x, y)

END SUB

'* InitDesignData() subroutine:
'* Initializes a DesignType array with screen design data - this must be done
'* before displaying a screen design using the DisplayDesign() routine. The
'* calling value of FileName$ dictates whether the data should be read
'* directly from a screen design file or from DATA statements (see below).
'*
'* Parameters:
'*     FileName$ - The name of the screen design file to load. This must
'*                 include the path to the file if it does not reside in the
'*                 current directory. If FileName$ is an empty string (""),
'*                 screen design data is read from DATA statements.
'* DesignArray() - Dynamic, DesignType array to hold the screen design data.
'*
'* Note: Before calling InitDesignData() to initialize a screen design from
'*       DATA statements, use an appropriate RESTORE statement to ensure the
'*       correct DATA statements are read.
'*
SUB InitDesignData (FileName$, DesignArray() AS DesignType)

IF FileName$ <> "" THEN
    '***** Read screen design data from file *****

    'Establish size of DesignType array required.
    FileNo = FREEFILE
    OPEN FileName$ FOR BINARY AS #FileNo
    ItemCount = (LOF(FileNo) - 7) \ 8
    CLOSE #FileNo
    REDIM DesignArray(0 TO ItemCount) AS DesignType

    'Load screen design data directly into array memory.
    DEF SEG = VARSEG(DesignArray(0))
    BLOAD FileName$, 0
    DEF SEG
ELSE
    '***** Read screen design data from DATA statements *****

    'Establish size of DesignType array required.
    READ ItemCount
    REDIM DesignArray(0 TO ItemCount) AS DesignType

    'READ screen design DATA into array.
    FOR n = 1 TO ItemCount
        READ ImageNo, Xpos, Ypos, DisAct
        DesignArray(n).ImageNo = ImageNo
        DesignArray(n).Xpos = Xpos
        DesignArray(n).Ypos = Ypos
        DesignArray(n).DisAct = DisAct
    NEXT n
END IF

END SUB

'* InitImageData() subroutine:
'* Initializes an integer array with image data - this must be done before
'* displaying an image using the PUT(graphics) statement. The calling value
'* of FileName$ dictates whether the data should be read directly from an
'* image file or from DATA statements (see below).
'*
'* Parameters:
'*    FileName$ - The name of the image file to load. This must include the
'*                path to the file if it does not reside in the current
'*                directory. If FileName$ is an empty string (""), image
'*                data is read from DATA statements.
'* ImageArray() - Dynamic, integer array to hold the image data.
'*
'* Note: Before calling InitImageData() to initialize images from DATA
'*       statements, use an appropriate RESTORE statement to ensure the
'*       correct DATA statements are read.
'*
SUB InitImageData (FileName$, ImageArray())

IF FileName$ <> "" THEN
    '***** Read image data from file *****

    'Establish size of integer array required.
    FileNo = FREEFILE
    OPEN FileName$ FOR BINARY AS #FileNo
    Ints = (LOF(FileNo) - 7) \ 2
    CLOSE #FileNo
    REDIM ImageArray(1 TO Ints)

    'Load image data directly into array memory.
    DEF SEG = VARSEG(ImageArray(1))
    BLOAD FileName$, 0
    DEF SEG
ELSE
    '***** Read image data from DATA statements *****

    'Establish size of integer array required.
    READ IntCount
    REDIM ImageArray(1 TO IntCount)

    'READ image DATA into array.
    FOR n = 1 TO IntCount
        READ x
        ImageArray(n) = x
    NEXT n
END IF

END SUB

'* InitPaletteData() subroutine:
'* Initializes a long integer array with palette colour data - this must be
'* done before changing palettes with the PALETTE USING statement. The
'* calling value of FileName$ dictates whether the data should be read
'* directly from a palette file or from DATA statements (see below).
'*
'* Parameters:
'*       FileName$ - The name of the palette file to load. This must include
'*                   the path to the file if it does not reside in the
'*                   current directory. If FileName$ is an empty string (""),
'*                   palette data is read from DATA statements.
'* PaletteArray&() - Dynamic, long integer array to hold palette data.
'*
'* Note: Before calling InitPaletteData() to initialize a palette from DATA
'*       statements, use an appropriate RESTORE statement to ensure the
'*       correct DATA statements are read.
'*
SUB InitPaletteData (FileName$, PaletteArray&())

'Size array to hold all 256 colours.
REDIM PaletteArray&(0 TO 255)

IF FileName$ <> "" THEN
    '*** Read palette data from file ***
    FileNo = FREEFILE
    OPEN FileName$ FOR BINARY AS #FileNo
    FOR n = 0 TO 255
        GET #FileNo, , colour&
        PaletteArray&(n) = colour&
    NEXT n
    CLOSE #FileNo
ELSE
    '*** Read palette data from DATA statements ***
    FOR n = 0 TO 255
        READ colour&
        PaletteArray&(n) = colour&
    NEXT n
END IF

END SUB

'* MakeImageIndex() subroutine:
'* Constructs an image position index for the images held in an image array.
'*
'* Parameters:
'* ImageArray() - Dynamic, integer array holding images to be indexed.
'* IndexArray() - Dynamic, integer array to hold the index for images in
'*                ImageArray().
'*
SUB MakeImageIndex (ImageArray(), IndexArray())

'The index will initially be built in a temporary array, allowing
'for the maximum 1000 images per file.
DIM Temp(1 TO 1000)
Ptr& = 1: IndexNo = 1: LastInt = UBOUND(ImageArray)
DO
    Temp(IndexNo) = Ptr&
    IndexNo = IndexNo + 1

    'Evaluate descriptor of currently referenced image to
    'calculate the beginning of the next image.
    x& = (ImageArray(Ptr&) \ 8) * (ImageArray(Ptr& + 1)) + 4
    IF x& MOD 2 THEN x& = x& + 1
    Ptr& = Ptr& + (x& \ 2)
LOOP WHILE Ptr& < LastInt

LastImage = IndexNo - 1

'Copy the image index values into the actual index array.
REDIM IndexArray(1 TO LastImage)
FOR n = 1 TO LastImage
    IndexArray(n) = Temp(n)
NEXT n

END SUB

'* RotatePalette() subroutine:
'* Rotates a contiguous range of colour attributes in the currently
'* active palette to the left or right.
'*
'* Parameters:
'*       StartAttr - First attribute of the range to be rotated.
'*         EndAttr - Last attribute of the range to be rotated.
'*       Direction - Dictates what direction the selected colours should
'*                   be rotated in:
'*                   Use ROTATELEFT to rotate colours to the left.
'*                   Use ROTATERIGHT to rotate colours to the right.
'* PaletteArray&() - Palette array holding the colours of the currently
'*                   active colour palette.
'*
SUB RotatePalette (StartAttr, EndAttr, Direction, PaletteArray&())

'Rotate affected colours in PaletteArray&() in the requested direction.
IF Direction = Rotateright THEN
    '*** Rotate right ***
    Lastc& = PaletteArray&(EndAttr)
    FOR n = EndAttr TO StartAttr + 1 STEP -1
        PaletteArray&(n) = PaletteArray&(n - 1)
    NEXT n
    PaletteArray&(StartAttr) = Lastc&
ELSE
    '*** Rotate left ***
    Lastc& = PaletteArray&(StartAttr)
    FOR n = StartAttr TO EndAttr - 1
        PaletteArray&(n) = PaletteArray&(n + 1)
    NEXT n
    PaletteArray&(EndAttr) = Lastc&
END IF

'Break down the colours into their RGB values.
DIM RGBval(StartAttr TO EndAttr, 0 TO 2)
FOR n = StartAttr TO EndAttr
    c& = PaletteArray&(n)
    b = c& \ 65536: c& = c& - b * 65536
    g = c& \ 256: c& = c& - g * 256
    r = c&
    RGBval(n, 0) = r
    RGBval(n, 1) = g
    RGBval(n, 2) = b
NEXT n

'Write colours directly to the video card.
WAIT &H3DA, &H8, &H8: WAIT &H3DA, &H8
FOR n = StartAttr TO EndAttr
    OUT &H3C8, n 'Select attribute.
    OUT &H3C9, RGBval(n, 0) 'Write red.
    OUT &H3C9, RGBval(n, 1) 'Write green.
    OUT &H3C9, RGBval(n, 2) 'Write blue.
NEXT n
    
END SUB

'* Scroller() subroutine:
'* Displays a scrolling message along the bottom of the screen, using a
'* bitmapped character set.
'*
'* Parameters:
'*    ScrollAct - Dictates what action should be done:
'*                Use INITSCROLL to initialize a new scroller message.
'*                Use UPDATESCROLL to update the scroller display.
'* ImageArray() - Image array holding the character set to be used. Each
'*                character must be a 16x8 image and be in the standard
'*                ASCII order, starting with the space character.
'* IndexArray() - Index array for the character images in ImageArray().
'*
'* Note: Before calling Scroller() to initialize a new scrolling message
'*       from DATA statements, use an appropriate RESTORE statement to
'*       ensure the correct DATA statements are read.
'*
SUB Scroller (ScrollAct, ImageArray(), IndexArray())

'Retain variable settings between calls.
STATIC MessChar(), FirstX, CharPtr, MessLen, ScrollMess$

IF ScrollAct = Initscroll THEN
    '*** Initialize scroller ***
    REDIM MessChar(1 TO 19)
    FOR n = 1 TO 19: MessChar(n) = 1: NEXT n

    'Read entire scroller text into ScrollMess$ from module-level DATA.
    ScrollMess$ = ""
    DO
        READ x$
        ScrollMess$ = ScrollMess$ + x$
    LOOP UNTIL x$ = ""

    MessLen = LEN(ScrollMess$)
    CharPtr = 1
    FirstX = 16
ELSE
    '*** Update scroller message display ***
    x = FirstX
    WAIT &H3DA, &H8, &H8: WAIT &H3DA, &H8
    FOR n = 1 TO 19
        PUT (x, 192), ImageArray(MessChar(n)), PSET
        x = x + 16
    NEXT n

    'Display two end characters (spaces) to tidy up message appearance.
    PUT (0, 192), ImageArray(IndexArray(1)), PSET
    PUT (304, 192), ImageArray(IndexArray(1)), PSET

    'Variable management ready for next Scroller(UPDATESCROLL) call.
    FirstX = FirstX - 2
    IF FirstX = 0 THEN
        FirstX = 16
        FOR n = 1 TO 18
            MessChar(n) = MessChar(n + 1)
        NEXT n

        IF CharPtr > MessLen THEN CharPtr = 1
        MessChar(19) = IndexArray(ASC(MID$(ScrollMess$, CharPtr, 1)) - 31)
        CharPtr = CharPtr + 1
    END IF
END IF

END SUB

'* WizzText() subroutine:
'* Centres a single line of text on the screen using a bitmapped character
'* set. Each character is whizzed across the screen in turn (from right to
'* left) to it's destination position.
'*
'* Parameters:
'*        Text$ - The single line text message to be displayed.
'*      TopLine - Screen Y coordinate to be the top line for the displayed
'*                text message.
'* ImageArray() - Image array holding the character set to be used. Each
'*                character must be a 16x8 image and be in the standard
'*                ASCII order, starting with the space character.
'* IndexArray() - Index array for the character images in ImageArray().
'*
SUB WizzText (Text$, TopLine, ImageArray(), IndexArray())

'Calculate X coordinate for first character.
MessLen = LEN(Text$)
HomeX = (320 - (MessLen * 16)) \ 2

'Loop to display each character of Text$.
FOR n = 1 TO MessLen
    x$ = MID$(Text$, n, 1)

    'Ignore space characters.
    IF x$ <> CHR$(32) THEN
        CharIdx = IndexArray(ASC(x$) - 31)
        OldX = 304

        'Move character across the screen to destination position.
        FOR x = 304 TO HomeX STEP -8
            WAIT &H3DA, &H8, &H8: WAIT &H3DA, &H8
            LINE (OldX, TopLine)-STEP(15, 7), 0, BF
            PUT (x, TopLine), ImageArray(CharIdx), PSET
            OldX = x
        NEXT x
    END IF

    HomeX = HomeX + 16
NEXT n
    
END SUB

