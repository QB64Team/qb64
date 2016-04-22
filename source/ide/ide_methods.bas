FUNCTION ide (ignore)
'Note: ide is a function which optimizes the interaction between the IDE and compiler (ide2)
'      by avoiding unnecessary bloat associated with entering the main IDE function 'ide2'

IF ASC(idecommand$) = 3 THEN 'request next line (compiler->ide)
    IF idecompiledline < iden THEN
        IF idecompiledline < idesy OR idecompiledline > idesy + (idewy - 9) THEN 'off screen?
            IF _EXIT AND 1 THEN ideexit = 1
            IF ideexit = 0 THEN
                GetInput 'check for new input
                IF iCHANGED = 0 AND mB = 0 THEN

                    '-------------------- layout considerations --------------------
                    'previous line was OK, so use layout if available
                    IF ideautolayout <> 0 OR ideautoindent <> 0 THEN
                        IF LEN(layout$) THEN

                            'calculate recommended indent level
                            l = LEN(layout$)
                            FOR i = 1 TO l
                                IF ASC(layout$, i) <> 32 OR i = l THEN
                                    IF ASC(layout$, i) = 32 THEN
                                        layout$ = "": indent = i
                                    ELSE
                                        indent = i - 1
                                        layout$ = RIGHT$(layout$, LEN(layout$) - i + 1)
                                    END IF
                                    EXIT FOR
                                END IF
                            NEXT

                            IF ideautolayout THEN
                                layout2$ = layout$: i2 = 1
                                ignoresp = 0
                                FOR i = 1 TO LEN(layout$)
                                    a = ASC(layout$, i)
                                    IF a = 34 THEN
                                        ignoresp = ignoresp + 1: IF ignoresp = 2 THEN ignoresp = 0
                                    END IF
                                    IF ignoresp = 0 THEN
                                        IF a = sp_asc THEN ASC(layout2$, i2) = 32: i2 = i2 + 1: GOTO skipchar
                                        IF a = sp2_asc THEN GOTO skipchar
                                    END IF
                                    ASC(layout2$, i2) = a: i2 = i2 + 1
                                    skipchar:
                                NEXT
                                layout$ = LEFT$(layout2$, i2 - 1)
                            END IF

                            IF ideautoindent = 0 THEN
                                'note: can assume auto-format
                                'calculate old indent (if any)
                                indent = 0
                                l = LEN(idecompiledline$)
                                FOR i = 1 TO l
                                    IF ASC(idecompiledline$, i) <> 32 OR i = l THEN
                                        indent = i - 1
                                        EXIT FOR
                                    END IF
                                NEXT
                                indent$ = SPACE$(indent)
                            ELSE
                                indent$ = SPACE$(indent * ideautoindentsize)
                            END IF

                            IF ideautolayout = 0 THEN
                                'note: can assume auto-indent
                                l = LEN(idecompiledline$)
                                layout$ = ""
                                FOR i = 1 TO l
                                    IF ASC(idecompiledline$, i) <> 32 OR i = l THEN
                                        layout$ = RIGHT$(idecompiledline$, l - i + 1)
                                        EXIT FOR
                                    END IF
                                NEXT
                            END IF

                            IF LEN(layout$) THEN
                                layout$ = indent$ + layout$
                                IF idecompiledline$ <> layout$ THEN
                                    idesetline idecompiledline, layout$
                                END IF
                            END IF 'len(layout$) after modification

                        END IF 'len(layout$)

                    END IF 'using layout/indent
                    '---------------------------------------------------------------

                    idecompiledline = idecompiledline + 1
                    idecompiledline$ = idegetline(idecompiledline)
                    ide = 4
                    idereturn$ = idecompiledline$
                    EXIT FUNCTION
                END IF
                IF iCHANGED THEN iCHECKLATER = 1
            END IF 'ideexit
        END IF 'not on screen
    END IF 'idecompiledline<iden
END IF

ide = ide2(0)
END FUNCTION

FUNCTION ide2 (ignore)
STATIC MenuLocations as STRING
STATIC idesystem2.issel AS _BYTE
STATIC idesystem2.sx1 AS LONG
STATIC idesystem2.v1 AS LONG
STATIC AttemptToLoadRecent AS _BYTE

CONST idesystem2.w = 20

c$ = idecommand$

'report any IDE errors which have occurred
IF ideerror THEN
    mustdisplay = 1
    IF ideerror = 1 THEN ideerrormessageTITLE$ = "IDE module error"
    IF ideerror = 2 THEN ideerrormessageTITLE$ = "File not found"
    IF ideerror = 3 THEN ideerrormessageTITLE$ = "File access error": CLOSE #150
    IF ideerror = 4 THEN ideerrormessageTITLE$ =  "Path not found"
    errorat$ = "On line: " + str2$(_errorline)
    inclerrorline = _inclerrorline
    if inclerrorline then errorat$ = errorat$ + " (included line: " + str2$(inclerrorline) + ")"
    qberrorcode = err
    if qberrorcode then
        ideerrormessageTITLE$ = "Error " + str2$(qberrorcode) + ": " + ideerrormessageTITLE$
    else
        ideerrormessageTITLE$ = "Error: " + ideerrormessageTITLE$
    endif
    PCOPY 3, 0
    idemessagebox ideerrormessageTITLE$, errorat$
END IF

IF (ideerror = 2 or ideerror = 3 or ideerror = 4) AND (AttemptToLoadRecent = -1) THEN
    'Offer to cleanup recent file list, removing invalid entries
    PCOPY 2, 0
    r$ = ideclearhistory$("INVALID")
    IF r$ = "Y" THEN
        GOSUB CleanUpRecentList
    END IF
    PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
END IF

ideerror = 1 'unknown IDE error
AttemptToLoadRecent = 0

IF LEFT$(c$, 1) = CHR$(12) THEN
    f$ = RIGHT$(c$, LEN(c$) - 1)
    LOCATE , , 0
    COLOR 7, 1: LOCATE idewy - 3, 2: PRINT SPACE$(idewx - 2);: LOCATE idewy - 2, 2: PRINT SPACE$(idewx - 2);: LOCATE idewy - 1, 2: PRINT SPACE$(idewx - 2); 'clear status window
    LOCATE idewy - 3, 2

    IF os$ = "LNX" THEN
        PRINT "Creating executable file named " + CHR$(34) + f$ + extension$ + CHR$(34) + "..."
    ELSE
        PRINT "Creating .EXE file named " + CHR$(34) + f$ + extension$ + CHR$(34) + "..."
    END IF

    PCOPY 3, 0
    ide2 = 9: idereturn$ = f$
    EXIT FUNCTION
END IF

IF c$ = CHR$(100) THEN 'special call for next line (usually for the purpose of line continuation)
    idecompiledline = idecompiledline + 1 'must increment (to trigger no more lines avail. message later)
    IF idecompiledline < iden THEN
        idecompiledline$ = idegetline(idecompiledline)
        idereturn$ = idecompiledline$
    ELSE
        idecompiledline$ = ""
        idereturn$ = idecompiledline$ 'no more lines
    END IF
    EXIT FUNCTION
END IF

IF idelaunched = 0 THEN
    idelaunched = 1

    WIDTH idewx, idewy
    _FONT 16

    'change codepage
    IF idecpindex THEN
        FOR x = 128 TO 255
            u = VAL("&H" + MID$(idecp(idecpindex), x * 8 + 1, 8) + "&")
            IF u = 0 THEN u = 9744
            _MAPUNICODE u TO x
        NEXT
    END IF

    IF idecustomfont THEN
        idecustomfonthandle = _LOADFONT(idecustomfontfile$, idecustomfontheight, "MONOSPACE")
        IF idecustomfonthandle = -1 THEN
            'failed! - revert to default settings
            idecustomfont = 0: idecustomfontfile$ = "c:\windows\fonts\lucon.ttf": idecustomfontheight = 21
        ELSE
            _FONT idecustomfonthandle
        END IF
    END IF

    m = 1: i = 0
    IdeMakeFileMenu

    m = m + 1: i = 0
    ideeditmenuID = m
    IdeMakeEditMenu

    m = m + 1: i = 0
    menu$(m, i) = "View": i = i + 1
    menu$(m, i) = "#SUBs...  F2": i = i + 1
    menusize(m) = i - 1

    m = m + 1: i = 0
    menu$(m, i) = "Search": i = i + 1
    menu$(m, i) = "#Find...  Ctrl+F3": i = i + 1
    menu$(m, i) = "#Repeat Last Find  (Shift+) F3": i = i + 1
    menu$(m, i) = "#Change...": i = i + 1
    menu$(m, i) = "-": i = i + 1
    menu$(m, i) = "Clear search #history...": i = i + 1
    menu$(m, i) = "-": i = i + 1
    menu$(m, i) = "Add/Remove #Bookmark  Alt+Left": i = i + 1
    menu$(m, i) = "#Next Bookmark  Alt+Down": i = i + 1
    menu$(m, i) = "#Previous Bookmark  Alt+Up": i = i + 1
    menu$(m, i) = "-": i = i + 1
    menu$(m, i) = "#Go to line...": i = i + 1

    menusize(m) = i - 1

    m = m + 1: i = 0
    menu$(m, i) = "Run": i = i + 1
    menu$(m, i) = "#Start  F5": i = i + 1
    menu$(m, i) = "Modify #COMMAND$...": i = i + 1
    menu$(m, i) = "-": i = i + 1
    menu$(m, i) = "Start (#Detached)  Ctrl+F5": i = i + 1
    IF os$ = "LNX" THEN
        menu$(m, i) = "Make E#xecutable Only  F11": i = i + 1
    ELSE
        menu$(m, i) = "Make E#XE Only  F11": i = i + 1
    END IF

    IF IdeAndroidMenu = 0 THEN menusize(m) = i - 1
    menu$(m, i) = "-": i = i + 1
    '    menu$(m, i) = "Start #Android Project": i = i + 1
    '    menu$(m, i) = "Make Android #Project Only": i = i + 1
    menu$(m, i) = "Make #Android Project": i = i + 1
    IF IdeAndroidMenu THEN menusize(m) = i - 1


    m = m + 1: i = 0
    menu$(m, i) = "Options": i = i + 1
    menu$(m, i) = "#Display...": i = i + 1
    menu$(m, i) = "C#olors...": i = i + 1
    menu$(m, i) = "#Language...": i = i + 1
    menu$(m, i) = "#Code layout...": i = i + 1
    menu$(m, i) = "#Backup/Undo...": i = i + 1
    menu$(m, i) = "-": i = i + 1
    menu$(m, i) = "#Advanced...": i = i + 1
    menu$(m, i) = "#Swap Mouse Buttons": i = i + 1
    menu$(m, i) = "-": i = i + 1
    menu$(m, i) = "#Google Android...": i = i + 1

    menusize(m) = i - 1

    m = m + 1: i = 0
    menu$(m, i) = "Help": i = i + 1
    menu$(m, i) = "#View  Shift+F1": i = i + 1
    menu$(m, i) = "#Contents page": i = i + 1
    menu$(m, i) = "Keyword #index": i = i + 1
    menu$(m, i) = "#Keywords by usage": i = i + 1
    menu$(m, i) = "ASCII c#hart": i = i + 1
    menu$(m, i) = "#Math": i = i + 1
    menu$(m, i) = "-": i = i + 1
    menu$(m, i) = "#Update current page": i = i + 1
    menu$(m, i) = "Update all #pages": i = i + 1
    menu$(m, i) = "-": i = i + 1
    menu$(m, i) = "#About...": i = i + 1
    menusize(m) = i - 1

    menus = m

    'Hidden contextual menu (ID is retrieved for later use; allows expansion of the original menu system above):
    m = m + 1
    idecontextualmenuID = m

    IF os$ = "WIN" THEN
        idepathsep$ = "\"
    END IF
    IF os$ = "LNX" THEN
        idepathsep$ = "/"
    END IF

    initmouse
    a$ = "QWERTYUIOP????ASDFGHJKL?????ZXCVBNM": x = 16: FOR i = 1 TO LEN(a$): idealtcode(ASC(MID$(a$, i, 1))) = x: x = x + 1: NEXT

    ideroot$ = idezgetroot$
    idepath$ = ideroot$

    'new blank text field
    idet$ = MKL$(0) + MKL$(0): idel = 1: ideli = 1: iden = 1: IdeBmkN = 0
    ideunsaved = -1
    idechangemade = 1

    redraweverything:

    idesx = 1
    idesy = 1
    idecx = 1
    idecy = 1

    redraweverything2:


    menubar$ = "   "
    MenuLocations = ""
    FOR i = 1 TO menus - 1
        MenuLocations = MenuLocations + MKI$(LEN(menubar$))
        menubar$ = menubar$ + menu$(i, 0) + "  "
    NEXT
    menubar$ = menubar$ + SPACE$(idewx - LEN(menubar$) - LEN(menu$(i, 0)) - 2)
    MenuLocations = MenuLocations + MKI$(LEN(menubar$))
    menubar$ = menubar$ + menu$(i, 0) + "  "


    SCREEN , , 3, 0
    VIEW PRINT 1 TO idewy + idesubwindow
    'VIEW PRINT 1 TO _HEIGHT(0)



    LOCATE , , , 8, 8

    'static background
    COLOR 0, 7: LOCATE 1, 1: PRINT menubar$;
    COLOR 7, 1: idebox 1, 2, idewx, idewy - 5


    COLOR 7, 1: idebox 1, idewy - 4, idewx, 5
    'edit corners
    COLOR 7, 1: LOCATE idewy - 4, 1: PRINT chr$(195);: LOCATE idewy - 4, idewx: PRINT chr$(180);

    IF idehelp = 1 THEN
        COLOR 7, 0: idebox 1, idewy, idewx, idesubwindow + 1
        COLOR 7, 0: LOCATE idewy, 1: PRINT chr$(195);: LOCATE idewy, idewx: PRINT chr$(180);
        COLOR 7, 0: LOCATE idewy, idewx - 3: PRINT chr$(180) + "X" + chr$(195);
    END IF

    'add status title
    COLOR 7, 1: LOCATE idewy - 4, (idewx - 8) / 2: PRINT " Status "
    'status bar
    COLOR 0, 3: LOCATE idewy + idesubwindow, 1: PRINT SPACE$(idewx);
    q = idevbar(idewx, idewy - 3, 3, 1, 1)
    q = idevbar(idewx, 3, idewy - 8, 1, 1)
    q = idehbar(2, idewy - 5, idewx - 2, 1, 1)


    DEF SEG = 0
    ideshowtext

    IF retval = 1 THEN GOTO skipload

    'restore autosave?
    'undo/redo
    OPEN tmpdir$ + "autosave.bin" FOR BINARY AS #150
    IF LOF(150) = 1 THEN
        CLOSE #150
        r$ = iderestore$
        PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
        IF r$ = "Y" THEN
            'restore
            OPEN tmpdir$ + "undo2.bin" FOR BINARY AS #150
            IF LOF(150) THEN
                ideunsaved = 1
                h$ = SPACE$(12): GET #150, , h$: p1 = CVL(MID$(h$, 1, 4)): p2 = CVL(MID$(h$, 5, 4)): plast = CVL(MID$(h$, 9, 4))
                'get backup
                SEEK #150, p2
                GET #150, , l&
                GET #150, , idesx: GET #150, , idesy
                GET #150, , idecx: GET #150, , idecy
                GET #150, , ideselect: GET #150, , ideselectx1: GET #150, , ideselecty1
                GET #150, , iden
                GET #150, , idel
                GET #150, , ideli
                'bookmark info [v2]
                GET #150, , IdeBmkN: REDIM IdeBmk(IdeBmkN + 1) AS IdeBmkType
                FOR bi = 1 TO IdeBmkN: GET #150, , IdeBmk(bi).y: GET #150, , IdeBmk(bi).x: NEXT
                GET #150, , x&: idet$ = SPACE$(x&): GET #150, , idet$
            END IF
            CLOSE #150
        END IF
    ELSE
        CLOSE #150
    END IF

    IF ideunsaved <> 1 THEN 'no file restored (takes priority over loading file from command line)
        IF LEFT$(c$, 1) = CHR$(1) THEN 'load file
            f$ = RIGHT$(c$, LEN(c$) - 1)
            IF FileHasExtension(f$) = 0 THEN f$ = f$ + ".bas"
            path$ = idezgetfilepath$(ideroot$, f$)

            '(copied from ideopen)
            ideerror = 2
            OPEN path$ + idepathsep$ + f$ FOR INPUT AS #150: CLOSE #150
            ideerror = 3
            idepath$ = path$
            lineinput3load path$ + idepathsep$ + f$
            idet$ = SPACE$(LEN(lineinput3buffer) * 8)
            i2 = 1
            n = 0
            chrtab$ = CHR$(9)
            space1$ = " ": space2$ = "  ": space3$ = "   ": space4$ = "    "
            chr7$ = CHR$(7): chr11$ = CHR$(11): chr12$ = CHR$(12): chr28$ = CHR$(28): chr29$ = CHR$(29): chr30$ = CHR$(30): chr31$ = CHR$(31)
            DO
                a$ = lineinput3$
                l = LEN(a$)
                IF l THEN asca = ASC(a$) ELSE asca = -1
                IF asca <> 13 THEN
                    IF asca <> -1 THEN
                        'fix tabs
                        ideopenfixtabsx:
                        x = INSTR(a$, chrtab$)
                        IF x THEN
                            x2 = (x - 1) MOD 4
                            IF x2 = 0 THEN a$ = LEFT$(a$, x - 1) + space4$ + RIGHT$(a$, l - x): l = l + 3: GOTO ideopenfixtabsx
                            IF x2 = 1 THEN a$ = LEFT$(a$, x - 1) + space3$ + RIGHT$(a$, l - x): l = l + 2: GOTO ideopenfixtabsx
                            IF x2 = 2 THEN a$ = LEFT$(a$, x - 1) + space2$ + RIGHT$(a$, l - x): l = l + 1: GOTO ideopenfixtabsx
                            IF x2 = 3 THEN a$ = LEFT$(a$, x - 1) + space1$ + RIGHT$(a$, l - x): GOTO ideopenfixtabsx
                        END IF
                    END IF 'asca<>-1
                    MID$(idet$, i2, l + 8) = MKL$(l) + a$ + MKL$(l): i2 = i2 + l + 8: n = n + 1
                END IF
            LOOP UNTIL asca = 13
            lineinput3buffer = ""
            iden = n: IF n = 0 THEN idet$ = MKL$(0) + MKL$(0): iden = 1 ELSE idet$ = LEFT$(idet$, i2 - 1)
            IdeBmkN = 0
            ideerror = 1
            ideprogname = f$: _TITLE ideprogname + " - QB64"
            IdeImportBookmarks idepath$ + idepathsep$ + ideprogname$
            IdeAddRecent idepath$ + idepathsep$ + ideprogname$
        END IF 'message 1

    END IF 'no restore

    skipload:











END IF 'idelaunched

IF c$ = CHR$(3) THEN
    skipdisplay = 1 'assume .../starting already displayed
    sendnextline = 1

    'previous line was OK, so use layout if available

    IF ideautolayout = 0 AND ideautoindent = 0 THEN

        layout$ = ""
        idelayoutallow = 0

    ELSE

        IF LEN(layout$) THEN

            'calculate recommended indent level
            FOR i = 1 TO LEN(layout$)
                IF ASC(layout$, i) <> 32 OR i = LEN(layout$) THEN
                    indent = i - 1
                    layout$ = RIGHT$(layout$, LEN(layout$) - i + 1)
                    EXIT FOR
                END IF
            NEXT

            IF ideautolayout THEN
                spacelayout:
                ignoresp = 0
                FOR i = 1 TO LEN(layout$)
                    IF ASC(layout$, i) = 34 THEN
                        ignoresp = ignoresp + 1: IF ignoresp = 2 THEN ignoresp = 0
                    END IF
                    IF ignoresp = 0 THEN
                        IF MID$(layout$, i, 1) = sp THEN MID$(layout$, i, 1) = " "
                        IF MID$(layout$, i, 1) = sp2 THEN layout$ = LEFT$(layout$, i - 1) + RIGHT$(layout$, LEN(layout$) - i): GOTO spacelayout
                    END IF
                NEXT
            END IF

            IF ideautoindent = 0 THEN
                'note: can assume auto-format
                'calculate old indent (if any)
                a$ = idecompiledline$
                indent = 0
                FOR i = 1 TO LEN(a$)
                    IF ASC(a$, i) <> 32 OR i = LEN(a$) THEN
                        indent = i - 1
                        EXIT FOR
                    END IF
                NEXT
                indent$ = SPACE$(indent)
            ELSE
                indent$ = SPACE$(indent * ideautoindentsize)
            END IF

            IF ideautolayout = 0 THEN
                'note: can assume auto-indent
                a$ = idecompiledline$
                layout$ = ""
                FOR i = 1 TO LEN(a$)
                    IF ASC(a$, i) <> 32 OR i = LEN(a$) THEN
                        layout$ = RIGHT$(a$, LEN(a$) - i + 1)
                        EXIT FOR
                    END IF
                NEXT
            END IF

            layout$ = indent$ + layout$

            IF idecy <> idecompiledline OR idelayoutallow <> 0 THEN
                idelayoutallow = 0

                IF idecompiledline$ <> layout$ THEN
                    idesetline idecompiledline, layout$
                    IF idecompiledline >= idesy AND idecompiledline <= (idesy + 16) THEN skipdisplay = 0
                END IF

            ELSE

                IF idecompiledline$ <> layout$ THEN
                    idecurrentlinelayout = layout$
                    idecurrentlinelayouti = idecy
                END IF

            END IF

        END IF 'len(layout$)

    END IF 'using layout/indent

END IF '3

IF c$ = CHR$(6) THEN
    idecompiling = 0
    ready = 1
    IF ideautorun THEN ideautorun = 0: GOTO idemrunspecial
END IF

IF c$ = CHR$(11) THEN
    idecompiling = 0
    ready = 1
    ideautorun = 0
    showexecreated = 1
END IF

IF c$ = CHR$(7) THEN
    skipdisplay = 1 'assume .../starting already displayed
    idecompiledline = 0
    sendnextline = 1
END IF

IF LEFT$(c$, 1) = CHR$(8) THEN
    idecompiling = 0
    failed = 1
    ideautorun = 0
END IF

passback = 0
IF LEFT$(c$, 1) = CHR$(10) THEN 'passback
    skipdisplay = 1 'assume .../starting already displayed
    sendnextline = 1
    idecompiledline = idecompiledline - 1
    passback = 1
    passback$ = RIGHT$(c$, LEN(c$) - 1)
END IF

IF mustdisplay THEN skipdisplay = 0

IF skipdisplay = 0 THEN

    LOCATE , , 0

    'note: menu bar shouldn't need repairing!
    'COLOR 0, 7: LOCATE 1, 1: PRINT menubar$; 'repair menu bar

    IF c$ <> CHR$(3) THEN
        COLOR 7, 1: LOCATE idewy - 3, 2: PRINT SPACE$(idewx - 2);: LOCATE idewy - 2, 2: PRINT SPACE$(idewx - 2);: LOCATE idewy - 1, 2: PRINT SPACE$(idewx - 2); 'clear status window
        IF ready THEN LOCATE idewy - 3, 2: PRINT "OK"; 'report OK status
        IF showexecreated THEN
            showexecreated = 0
            LOCATE idewy - 3, 2

            IF MakeAndroid THEN
                PRINT "Project [programs\android\" + file$ + "] created";
            ELSE
                IF os$ = "LNX" THEN
                    PRINT "Executable file created";
                ELSE
                    PRINT ".EXE file created";
                END IF
            END IF

        END IF
    END IF

END IF 'skipdisplay

idefocusline = 0





























'main loop
DO
    ideloop:
    idecontextualmenu = 0
    idedeltxt 'removes temporary strings (typically created by guibox commands) by setting an index to 0
    STATIC ForceResize
    if IDE_AutoPosition then
     'if _SCreenhide = 0 then  'Screenhide currently does not work in Linux, so we need a different check
        IF IDE_TopPosition <> _SCREENY OR IDE_LeftPosition <> _SCREENX THEN
            IF _SCREENY => -_height * _fontheight AND _SCREENX => -_width * _fontwidth THEN 'Don't record the position if it's off the screen, past the point where we can drag it back into a different position.
                WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_TopPosition" , str$(_SCREENY)
                WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_LeftPosition" , str$(_SCREENX)
                IDE_TopPosition = _SCREENY: IDE_LeftPosition = _SCREENX
            END IF
        END IF
     'end if
    end if

    IF _RESIZE or ForceResize THEN
      IF idesubwindow <> 0  THEN      'If there's a subwindow up, don't resize as it screws all sorts of things up.
        ForceResize = -1
      ELSE
        ForceResize = 0
        v% = _RESIZEWIDTH \ _FONTWIDTH: IF v% < 80 OR v% > 1000 THEN v% = 80
        IF v% <> idewx THEN retval = 1: idewx = v%
        v% = _RESIZEHEIGHT \ _FONTHEIGHT: IF v% < 25 OR v% > 1000 THEN v% = 25
        IF v% <> idewy THEN retval = 1: idewy = v%

        IF retval = 1 THEN 'screen dimensions have changed and everything must be redrawn/reapplied
            WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_Width", str$(idewx)
            WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_Height", str$(idewy)

            tempf& = _font
            WIDTH idewx, idewy + idesubwindow
            _font tempf&
            GOTO redraweverything
        END IF
      END IF
    END IF

    IF skipdisplay = 0 THEN

        LOCATE , , 0

        'Get the currently being edited SUB/FUNCTION name to show after the main window title
        '(standard QB4.5 behavior). The FOR...NEXT loop was taken and adapted from FUNCTION
        'idesubs$, but it goes backwards from the current line to the start of the program
        'to see if we're inside a SUB/FUNCTION. EXITs FOR once that is figured.
        sfname$ = ""
        FOR currSF_CHECK = idecy to 1 STEP -1
            thisline$ = idegetline(currSF_CHECK)
            thisline$ = LTRIM$(RTRIM$(thisline$))
            isSF = 0
            ncthisline$ = UCASE$(thisline$)
            IF LEFT$(ncthisline$, 4) = "SUB " THEN isSF = 1
            IF LEFT$(ncthisline$, 9) = "FUNCTION " THEN isSF = 2
            IF LEFT$(ncthisline$, 7) = "END SUB" and currSF_CHECK < idecy THEN EXIT FOR
            IF LEFT$(ncthisline$, 12) = "END FUNCTION" and currSF_CHECK < idecy THEN EXIT FOR
            IF isSF THEN
                IF RIGHT$(ncthisline$, 7) = " STATIC" THEN
                    thisline$ = RTRIM$(LEFT$(thisline$, LEN(thisline$) - 7))
                END IF

                IF isSF = 1 THEN
                    thisline$ = RIGHT$(thisline$, LEN(thisline$) - 4)
                ELSE
                    thisline$ = RIGHT$(thisline$, LEN(thisline$) - 9)
                END IF
                thisline$ = LTRIM$(RTRIM$(thisline$))
                checkargs = INSTR(thisline$, "(")
                IF checkargs THEN
                    sfname$ = RTRIM$(LEFT$(thisline$, checkargs - 1))
                ELSE
                    sfname$ = thisline$
                END IF

                'It could be that SUB or FUNCTION is inside a DECLARE LIBRARY.
                'In such case, it must be ignored:
                InsideDECLARE = 0
                for declib_CHECK = currSF_CHECK to 1 step -1
                    thisline$ = idegetline(declib_CHECK)
                    thisline$ = LTRIM$(RTRIM$(thisline$))
                    ncthisline$ = UCASE$(thisline$)
                    IF LEFT$(ncthisline$, 8) = "DECLARE " and INSTR(ncthisline$, " LIBRARY") > 0 THEN InsideDECLARE = -1: EXIT FOR
                    IF LEFT$(ncthisline$, 11) = "END DECLARE" THEN EXIT FOR
                next

                if InsideDECLARE = -1 then
                    sfname$ = ""
                else
                    'Ok, we're not inside a DECLARE LIBRARY.
                    'But what if we're past the end of this module's SUBs and FUNCTIONs,
                    'and all that's left is a bunch of comments or $INCLUDES?
                    'We'll also check for that:
                    endedSF = 0
                    for endSF_CHECK = idecy to iden
                        thisline$ = idegetline(endSF_CHECK)
                        thisline$ = LTRIM$(RTRIM$(thisline$))
                        ncthisline$ = UCASE$(thisline$)
                        IF LEFT$(ncthisline$, 7) = "END SUB" THEN endedSF = 1: EXIT FOR
                        IF LEFT$(ncthisline$, 12) = "END FUNCTION" THEN endedSF = 2: EXIT FOR
                        IF LEFT$(ncthisline$, 4) = "SUB " AND endSF_CHECK = idecy THEN endedSF = 1: EXIT FOR
                        IF LEFT$(ncthisline$, 9) = "FUNCTION " AND endSF_CHECK = idecy THEN endedSF = 2: EXIT FOR
                        IF LEFT$(ncthisline$, 4) = "SUB " AND InsideDECLARE = 0 THEN EXIT FOR
                        IF LEFT$(ncthisline$, 9) = "FUNCTION " AND InsideDECLARE = 0 THEN EXIT FOR
                        IF LEFT$(ncthisline$, 8) = "DECLARE " and INSTR(ncthisline$, " LIBRARY") > 0 THEN InsideDECLARE = -1
                        IF LEFT$(ncthisline$, 11) = "END DECLARE" THEN InsideDECLARE = 0
                    next
                    if endedSF = 0 then sfname$ = "" else exit for
                end if
            END IF
        NEXT

        'attempt to cleanse sfname$, just in case there are any comments or other unwanted stuff
        for CleanseSFNAME = 1 to len(sfname$)
            select case mid$(sfname$, CleanseSFNAME, 1)
                case " ", "'", ":"
                    sfname$ = left$(sfname$, CleanseSFNAME - 1)
                    exit for
            end select
        next

        'update title of main window
        COLOR 7, 1: LOCATE 2, 2: PRINT STRING$(idewx - 2, chr$(196));
        IF LEN(ideprogname) THEN a$ = ideprogname ELSE a$ = "Untitled" + tempfolderindexstr$
        a$ = " " + a$
        if LEN(sfname$) > 0 then a$ = a$ + ":" + sfname$
        a$ = a$ + " "
        if len(a$) > idewx - 5 then a$ = left$(a$, idewx - 11) + string$(3, 250) + " "
        COLOR 1, 7: LOCATE 2, ((idewx / 2) - 1) - (LEN(a$) - 1) \ 2: PRINT a$;

        'Draw navigation buttons (QuickNav)
        GOSUB DrawQuickNav

        'update search bar
        GOSUB UpdateSearchBar

        'alter cursor style to match insert mode
        IF ideinsert THEN LOCATE , , , 0, 31 ELSE LOCATE , , , 8, 8

        'display error message (if necessary)
        IF failed THEN
            COLOR 7, 1: LOCATE idewy - 3, 2: PRINT SPACE$(idewx - 2);: LOCATE idewy - 2, 2: PRINT SPACE$(idewx - 2);: LOCATE idewy - 1, 2: PRINT SPACE$(idewx - 2); 'clear status window

            'scrolling unavailable, but may span multiple lines
            a$ = MID$(c$, 2, LEN(c$) - 5)


            l = CVL(RIGHT$(c$, 4)): IF l <> 0 THEN idefocusline = l

            x = 1
            y = idewy - 3

            IF l <> 0 AND idecy = l THEN a$ = a$ + " on current line"

            FOR i = 1 TO LEN(a$)
                x = x + 1: IF x = idewx THEN x = 2: y = y + 1
                IF y > idewy - 1 THEN EXIT FOR
                LOCATE y, x
                PRINT CHR$(ASC(a$, i));
            NEXT

            IF l <> 0 AND idecy <> l THEN
                a$ = " on line" + STR$(l)
                COLOR 11, 1
                FOR i = 1 TO LEN(a$)
                    x = x + 1: IF x = idewx THEN x = 2: y = y + 1
                    IF y > idewy - 1 THEN EXIT FOR
                    LOCATE y, x
                    PRINT CHR$(ASC(a$, i));
                NEXT
            END IF

        END IF

        IF idechangemade THEN
            COLOR 7, 1: LOCATE idewy - 3, 2: PRINT SPACE$(idewx - 2);: LOCATE idewy - 2, 2: PRINT SPACE$(idewx - 2);: LOCATE idewy - 1, 2: PRINT SPACE$(idewx - 2); 'clear status window


            LOCATE idewy - 3, 2: PRINT "..."; 'assume new compilation will begin
        END IF

        ideshowtext

        IF idehelp THEN




            Help_ShowText

            q = idehbar(2, idewy + idesubwindow - 1, idewx - 2, Help_cx, help_w + 1)
            q = idevbar(idewx, idewy + 1, idesubwindow - 2, Help_cy, help_h + 1)

            'COLOR 0, 7: LOCATE idewy, (idewx - 6) / 2: PRINT " Help "
            'create and draw back string
            Back_Str$ = STRING$(1000, 0)
            Back_Str_I$ = STRING$(4000, 0)
            top = UBOUND(back$)
            FOR x = 1 TO top
                n$ = Back_Name$(x)
                IF x = Help_Back_Pos THEN p = LEN(Back_Str$)
                Back_Str$ = Back_Str$ + " "
                Back_Str_I$ = Back_Str_I$ + MKL$(x)
                FOR x2 = 1 TO LEN(n$)
                    Back_Str$ = Back_Str$ + CHR$(ASC(n$, x2))
                    Back_Str_I$ = Back_Str_I$ + MKL$(x)
                NEXT
                Back_Str$ = Back_Str$ + " "
                Back_Str_I$ = Back_Str_I$ + MKL$(x)

                IF x <> top THEN
                    Back_Str$ = Back_Str$ + CHR$(0)
                    Back_Str_I$ = Back_Str_I$ + MKL$(0)
                END IF
            NEXT
            Back_Str$ = Back_Str$ + STRING$(1000, 0)
            Back_Str_I$ = Back_Str_I$ + STRING$(4000, 0)
            Back_Str_Pos = p - idewx \ 2 + (LEN(Back_Name$(Help_Back_Pos)) + 2) \ 2 + 3
            'COLOR 1, 2
            'LOCATE idewy, 2: PRINT MID$(Back_Str$, Back_Str_Pos, idewx - 5)
            LOCATE idewy, 2
            FOR x = Back_Str_Pos TO Back_Str_Pos + idewx - 6
                i = CVL(MID$(Back_Str_I$, (x - 1) * 4 + 1, 4))
                a = ASC(Back_Str$, x)
                IF a THEN
                    COLOR 0, 7
                    IF i < Help_Back_Pos THEN COLOR 9, 7
                    IF i > Help_Back_Pos THEN COLOR 9, 7
                    PRINT CHR$(a);
                ELSE
                    COLOR 7, 0
                    PRINT chr$(196);
                END IF
            NEXT
            'Help_Search_Str
            a$ = ""
            IF LEN(Help_Search_Str) THEN
                a$ = Help_Search_Str
                IF LEN(a$) > 20 THEN a$ = string$(3, 250) + RIGHT$(a$, 17)
                a$ = "[" + a$ + "](DELETE=next)"
            END IF
            IdeInfo$ = a$
        END IF

        IF IdeSystem = 2 THEN 'override cursor position
            SCREEN , , 0, 0
            tx = idesystem2.v1
            IF LEN(idefindtext) > idesystem2.w THEN
                IF idesystem2.v1 > idesystem2.w THEN
                    tx = idesystem2.w
                ELSE
                    tx = idesystem2.v1
                END IF
            END IF
            LOCATE idewy - 4, idewx - (idesystem2.w + 8) + 4 + tx
            SCREEN , , 3, 0
        END IF

        IF IdeSystem = 3 THEN 'override cursor position
            SCREEN , , 0, 0
            _PALETTECOLOR 2, _RGB32(24, 24, 24)
            LOCATE Help_cy - Help_sy + Help_wy1, Help_cx - Help_sx + Help_wx1
            SCREEN , , 3, 0
        END IF


        IF IdeSystem <> 3 THEN IdeInfo$ = ""

        'show info message (if any)
        a$ = IdeInfo$
        IF LEN(a$) > 60 THEN a$ = LEFT$(a$, 57) + string$(3, 250)
        IF LEN(a$) < 60 THEN a$ = a$ + SPACE$(60 - LEN(a$))
        COLOR 0, 3: LOCATE idewy + idesubwindow, 2
        PRINT a$;

        LOCATE , , 1


        PCOPY 3, 0

    END IF 'skipdisplay



    IF idechangemade THEN

        IF idelayoutallow THEN idelayoutallow = idelayoutallow - 1

        idecurrentlinelayouti = 0 'invalidate

        idechangemade = 0
        IF ideunsaved = -1 THEN ideunsaved = 0 ELSE ideunsaved = 1

        IF idenoundo = 0 THEN

            'undo/redo
            'build data so it can be written in a single write (a backup requirement)
            a$ = ""
            a$ = a$ + MKL$(idesx) + MKL$(idesy) 'screen position
            a$ = a$ + MKL$(idecx) + MKL$(idecy) 'cursor position
            a$ = a$ + MKL$(ideselect) + MKL$(ideselectx1) + MKL$(ideselecty1) 'selection state & position
            a$ = a$ + MKL$(iden) 'number of lines
            a$ = a$ + MKL$(idel) 'selected line in buffer
            a$ = a$ + MKL$(ideli) 'selected line offset in buffer
            'bookmark info [v2]
            a$ = a$ + MKL$(IdeBmkN)
            FOR bi = 1 TO IdeBmkN: a$ = a$ + MKL$(IdeBmk(bi).y) + MKL$(IdeBmk(bi).x): NEXT
            l& = LEN(idet$)
            a$ = a$ + MKL$(l&) 'data size
            a$ = MKL$(l& + LEN(a$)) + a$ + idet$ + MKL$(l& + LEN(a$)) 'header, data & encapsulation (reverse navigatable list)

            'add undo event

            OPEN tmpdir$ + "undo2.bin" FOR BINARY AS #150
            '[oldest state entry][newest state entry][top-most entry(ignore if no wrapping required)]
            h$ = SPACE$(12): GET #150, , h$: p1 = CVL(MID$(h$, 1, 4)): p2 = CVL(MID$(h$, 5, 4)): plast = CVL(MID$(h$, 9, 4))

            IF idemergeundo THEN
                idemergeundo = 0
                IF p2 <> p1 THEN 'can it be moved back?
                    IF p2 = 13 THEN
                        p2 = plast
                    ELSE
                        'get offset of previous message
                        GET #150, p2 - 4, pp2l
                        p2 = p2 - 4 - pp2l - 4
                    END IF
                END IF
            END IF

            IF p1 = 0 THEN 'not init
                p1 = 13: p2 = 13
            ELSE
                IF p2 >= p1 THEN
                    'no wrap
                    'should we extend?
                    IF p2 >= idebackupsize * 1000000 THEN
                        'can't extend
                        'set p2 as top-most
                        plast = p2
                        p2 = 13
                        'can new state (a$) fit before p1?
                        DO WHILE (p2 + LEN(a$) - 1) >= p1
                            IF p1 = ideundobase THEN ideundobase = -1
                            'no, so move p1 to next entry
                            'note: it can be assumed that p1, being near/at beginning, won't have to wrap when being moved forward
                            GET #150, p1, p1l
                            p1 = p1 + 4 + p1l + 4
                        LOOP
                        'p1 & p2 ready
                    ELSE
                        'extend
                        'find size of p2 event
                        GET #150, p2, p2l
                        p2 = p2 + 4 + p2l + 4
                        'p1 & p2 ready
                    END IF
                ELSE
                    'wrap
                    'find size of p2 event
                    GET #150, p2, p2l
                    op2 = p2
                    p2 = p2 + 4 + p2l + 4
                    'can new state (a$) fit before p1?
                    DO WHILE (p2 + LEN(a$) - 1) >= p1
                        IF p1 = ideundobase THEN ideundobase = -1
                        'no, so move p1 to next entry
                        IF p1 = plast THEN
                            p1 = 13
                            EXIT DO
                        ELSE
                            GET #150, p1, p1l
                            p1 = p1 + 4 + p1l + 4
                        END IF
                    LOOP
                    'should we extend?
                    IF p2 >= idebackupsize * 1000000 THEN
                        'can't extend
                        'set op2 as top-most
                        plast = op2
                        p2 = 13
                        'can new state (a$) fit before p1?
                        DO WHILE (p2 + LEN(a$) - 1) >= p1
                            IF p1 = ideundobase THEN ideundobase = -1
                            'no, so move p1 to next entry
                            'note: it can be assumed that p1, being near/at beginning, won't have to wrap when being moved forward
                            GET #150, p1, p1l
                            p1 = p1 + 4 + p1l + 4
                        LOOP
                    END IF
                    'p1 & p2 ready
                END IF
            END IF

            'update p1,p2,plast
            h$ = MKL$(p1) + MKL$(p2) + MKL$(plast)
            PUT #150, 1, h$

            'add new state
            PUT #150, p2, a$

            CLOSE #150

            ideundopos = p2
            IF ideundobase = 0 THEN ideundobase = ideundopos



            'set undo flag once
            IF ideundoflag = 0 THEN
                ideundoflag = 1
                OPEN tmpdir$ + "autosave.bin" FOR BINARY AS #150: a$ = CHR$(1): PUT #150, , a$: CLOSE #150 'set flag
            END IF

        ELSE
            idenoundo = 0
        END IF

        'begin new compilation
        IF IDEBuildModeChanged = 0 THEN
            ideautorun = 0
        END IF
        IDEBuildModeChanged = 0

        IF MakeAndroid THEN
            'Cleanup excess files in temp folder
            SHELL _HIDE "cmd /c del /q " + tmpdir$ + "ret*.txt " + tmpdir$ + "data*.txt " + tmpdir$ + "free*.txt"
        END IF

        idecompiling = 1
        ide2 = 2
        idecompiledline$ = idegetline(1)
        idereturn$ = idecompiledline$
        idecompiledline = 1
        EXIT FUNCTION
    END IF 'idechangemade
















    change = 0
    waitforinput:

    IF idecurrentlinelayouti THEN
        IF idecy <> idecurrentlinelayouti THEN
            idesetline idecurrentlinelayouti, idecurrentlinelayout$
            idecurrentlinelayouti = 0
            change = 1 'simulate a change to force a screen update
        END IF
    END IF

    exitvalue = _EXIT
    IF (exitvalue AND 1) <> 0 OR ideexit <> 0 THEN ideexit = 0: GOTO quickexit

    GetInput
    IF iCHANGED THEN
        IF (mX <> mox OR mY <> moy) AND mB <> 0 THEN change = 1 'dragging mouse
        IF mB <> mOB THEN change = 1 'button changed
        IF mB2 <> mOB2 THEN change = 1 'button changed
        IF mCLICK <> 0 OR mCLICK2 <> 0 THEN change = 1
        IF mWHEEL THEN change = 1
        IF KB THEN change = 1
        IF KSTATECHANGED THEN change = 1
    END IF
    IF mB <> 0 AND idembmonitor = 1 THEN change = 1
    IF mB = 0 THEN idemouseselect = 0: idembmonitor = 0

    'Hover/click (QuickNav)
    IF IdeSystem = 1 AND QuickNavTotal > 0 THEN
        IF mY = 2 THEN
            IF mX >= 4 AND mX <= 6 THEN
                QuickNavHover = -1
                LOCATE 2, 4
                COLOR 15, 3
                PRINT " " + CHR$(17) + " ";
                PCOPY 3, 0
                IF mB THEN
                    idecy = QuickNavHistory(QuickNavTotal)
                    QuickNavTotal = QuickNavTotal - 1
                    _DELAY .2
                    GOTO waitforinput
                END IF
            ELSE
                IF QuickNavHover = -1 THEN QuickNavHover = 0: GOSUB DrawQuickNav: PCOPY 3, 0
            END IF
        ELSE
            IF QuickNavHover = -1 THEN QuickNavHover = 0: GOSUB DrawQuickNav: PCOPY 3, 0
        END IF
    END IF

    IF KALT THEN 'alt held

        IF idealthighlight = 0 AND KALTPRESS = -1 THEN
            'highlist first letter of each menu item
            idealthighlight = 1
            LOCATE , , 0: COLOR 15, 7: x = 4
            FOR i = 1 TO menus
                LOCATE 1, x: PRINT LEFT$(menu$(i, 0), 1);
                x = x + LEN(menu$(i, 0)) + 2
                IF i = menus - 1 THEN x = idewx - LEN(menu$(menus, 0)) - 1
            NEXT
            ideentermenu = 1 'alt has just been pressed, so any next keystroke could enter a menu)
            'IF change = 0 THEN
            skipdisplay = 0: GOTO ideloop 'force update so cursor will be restored to correct position
        END IF

    ELSE 'alt not held
        IF idealthighlight = 1 THEN
            'remove highlight
            idealthighlight = 0
            LOCATE , , 0: COLOR 0, 7: LOCATE 1, 1: PRINT menubar$;
            IF ideentermenu = 1 AND KCONTROL = 0 THEN 'alt was pressed then released
                LOCATE , , , 8, 8: skipdisplay = 0: ideentermenu = 0: GOTO startmenu
            END IF
        END IF

    END IF 'alt not held

    IF change = 0 THEN

        'continue compilation?
        IF idecompiling THEN
            IF sendnextline THEN
                IF idecompiledline < iden THEN
                    idecompiledline = idecompiledline + 1
                    ide2 = 4
                    IF passback THEN
                        idecompiledline$ = passback$
                        idereturn$ = idecompiledline$
                    ELSE
                        idecompiledline$ = idegetline(idecompiledline)
                        idereturn$ = idecompiledline$
                    END IF
                    EXIT FUNCTION
                ELSE
                    'finished compilation
                    ide2 = 5 'end of program reached, what next?
                    'could return:
                    'i) 6 code ready for export/run
                    'ii) 7 repass required (if so send data from the beginning again)
                    EXIT FUNCTION
                END IF
            END IF
        END IF

        _LIMIT 16

        GOTO waitforinput
    END IF 'change=0

    ideentermenu = 0

    ideundocombo = ideundocombo - 1
    IF ideundocombo < 0 THEN ideundocombo = 0

    skipdisplay = 0

    'IdeSystem independent routines

    IF mCLICK THEN
        IF mX >= 2 AND mX <= idewx AND mY >= idewy - 3 AND mY <= idewy - 1 THEN
            IF SCREEN(mY, mX, 1) = 11 + 1 * 16 THEN
                IF idefocusline THEN idecx = 1: AddQuickNavHistory idecy: idecy = idefocusline: ideselect = 0: GOTO specialchar
            END IF
        END IF
    END IF

    IF KB = KEY_F5 AND KCTRL THEN 'run detached
        UseAndroid 0
        idemdetached:
        iderunmode = 1
        GOTO idemrunspecial
    END IF

    IF KB = KEY_F11 THEN 'make exe only
        UseAndroid 0
        idemexe:
        iderunmode = 2
        GOTO idemrunspecial
    END IF

    IF KB = KEY_F5 THEN 'Note: F5 or SHIFT+F5 accepted
        UseAndroid 0
        idemrun:
        iderunmode = 0 'standard run
        idemrunspecial:

        'run program
        IF ready <> 0 AND idechangemade = 0 THEN

            LOCATE , , 0
            COLOR 7, 1: LOCATE idewy - 3, 2: PRINT SPACE$(idewx - 2);: LOCATE idewy - 2, 2: PRINT SPACE$(idewx - 2);: LOCATE idewy - 1, 2: PRINT SPACE$(idewx - 2); 'clear status window

            IF idecompiled THEN

                IF iderunmode = 2 THEN
                    LOCATE idewy - 3, 2

                    IF os$ = "LNX" THEN
                        PRINT "Already created executable file!";
                    ELSE
                        PRINT "Already created .EXE file!";
                    END IF

                    GOTO specialchar
                END IF

                LOCATE idewy - 3, 2: PRINT "Starting program...";
            ELSE

                IF os$ = "LNX" THEN
                    LOCATE idewy - 3, 2: PRINT "Creating executable file...";
                ELSE
                    LOCATE idewy - 3, 2: PRINT "Creating .EXE file...";
                END IF

            END IF
            PCOPY 3, 0

            'send run request
            'prepare name
            IF ideprogname$ = "" THEN
                f$ = "untitled" + tempfolderindexstr$
            ELSE
                f$ = ideprogname$
                f$ = RemoveFileExtension$(f$)
            END IF
            ide2 = 9: idereturn$ = f$
            EXIT FUNCTION
        END IF
        'not ready!
        IF failed = 1 THEN GOTO specialchar
        'assume still compiling ...
        ideautorun = 1

        'correct status message
        LOCATE , , 0
        COLOR 7, 1: LOCATE idewy - 3, 2: PRINT SPACE$(idewx - 2);: LOCATE idewy - 2, 2: PRINT SPACE$(idewx - 2);: LOCATE idewy - 1, 2: PRINT SPACE$(idewx - 2); 'clear status window


        LOCATE idewy - 3, 2: PRINT "Checking program... (editing program will cancel request)";

        'must move the cursor back to its correct location
        ideshowtext
        LOCATE , , 1
        PCOPY 3, 0

        GOTO specialchar
    END IF

    LOCATE , , 0
    LOCATE , , , 8, 8

    IF mCLICK AND idemouseselect = 0 THEN
        IF mY = 1 THEN
            x = 3
            FOR i = 1 TO menus
                x2 = LEN(menu$(i, 0)) + 2
                IF mX >= x AND mX < x + x2 THEN
                    m = i
                    GOTO showmenu
                END IF
                x = x + x2
                IF i = menus - 1 THEN x = idewx - LEN(menu$(menus, 0)) - 2
            NEXT
        END IF
    END IF

    FOR i = 1 TO menus
        a$ = UCASE$(LEFT$(menu$(i, 0), 1))
        IF KALT AND UCASE$(K$) = a$ THEN
            m = i
            LOCATE 1, 1: COLOR 0, 7: PRINT menubar$;
            PCOPY 3, 0
            GOTO showmenu
        END IF
    NEXT

    IF KCTRL AND UCASE$(K$) = "F" THEN
        K$ = ""
        IdeSystem = 2
        if len(idefindtext) then idesystem2.issel = -1: idesystem2.sx1 = 0: idesystem2.v1 = len(idefindtext)
    END IF

    IF KCTRL AND KB = KEY_F3 THEN
        IF IdeSystem = 3 THEN IdeSystem = 1
        GOTO idefindjmp
    END IF

    IF KB = KEY_F3 THEN
        IF IdeSystem = 3 THEN IdeSystem = 1
        idemf3:
        IF idefindtext <> "" THEN
            if IdeSystem = 2 then
                idesystem2.sx1 = 0
                idesystem2.v1 = len(idefindtext)
                idesystem2.issel = -1
            end if
            GOSUB UpdateSearchBar
            IF KSHIFT THEN idefindinvert = 1
            IdeAddSearched idefindtext
            idefindagain
        ELSE
            GOTO idefindjmp
        END IF
        GOTO specialchar
    END IF

    IF KSHIFT AND KB = KEY_F1 THEN
        IF idehelp = 0 THEN
            idesubwindow = idewy \ 2: idewy = idewy - idesubwindow
            Help_wx1 = 2: Help_wy1 = idewy + 1: Help_wx2 = idewx - 1: Help_wy2 = idewy + idesubwindow - 2: Help_ww = Help_wx2 - Help_wx1 + 1: Help_wh = Help_wy2 - Help_wy1 + 1
            idehelp = 1
            skipdisplay = 0
            IdeSystem = 3
            retval = 1: GOTO redraweverything2
        END IF
        IdeSystem = 3
        GOTO specialchar
    END IF


    'Scroll bar code goes here
    STATIC Help_Scrollbar, Help_Scrollbar_Method
    '1=arrow less, 2=arrow more, 3=dragging 'bit', 4=clicking in space
    IF mB = 0 THEN Help_Scrollbar = 0
    IF idehelp THEN
        IF IdeSystem = 3 THEN
            'q = idehbar(2, idewy + idesubwindow - 1, idewx - 2, Help_cx, help_w + 1)
            'q = idevbar(idewx, idewy + 1, idesubwindow - 2, Help_cy, help_h + 1)
            IF mCLICK THEN
                IF mX >= 2 AND mX <= idewx - 1 AND mY = idewy + idesubwindow - 1 THEN
                    Help_Scrollbar = 1
                    v = idehbar(2, idewy + idesubwindow - 1, idewx - 2, Help_cx, help_w + 1)
                    IF v <> mX THEN Help_Scrollbar_Method = 3 ELSE Help_Scrollbar_Method = 4
                    IF mX = 2 THEN Help_Scrollbar_Method = 1
                    IF mX = idewx - 1 THEN Help_Scrollbar_Method = 2
                END IF
                IF mY >= idewy + 1 AND mY <= idewy + idesubwindow - 2 AND mX = idewx THEN
                    Help_Scrollbar = 2
                    v = idevbar(idewx, idewy + 1, idesubwindow - 2, Help_cy, help_h + 1)
                    IF v <> mY THEN Help_Scrollbar_Method = 3 ELSE Help_Scrollbar_Method = 4
                    IF mY = idewy + 1 THEN Help_Scrollbar_Method = 1
                    IF mY = idewy + idesubwindow - 2 THEN Help_Scrollbar_Method = 2
                END IF
            END IF 'mclick

            IF Help_Scrollbar THEN
                idembmonitor = 1
                IF Help_Scrollbar_Method = 1 THEN
                    IF Help_Scrollbar = 1 THEN KB = KEY_LEFT: idewait 'fall through...
                    IF Help_Scrollbar = 2 THEN KB = KEY_UP: idewait 'fall through...
                END IF
                IF Help_Scrollbar_Method = 2 THEN
                    IF Help_Scrollbar = 1 THEN KB = KEY_RIGHT: idewait 'fall through...
                    IF Help_Scrollbar = 2 THEN KB = KEY_DOWN: idewait 'fall through...
                END IF
                IF Help_Scrollbar_Method = 3 THEN
                    IF Help_Scrollbar = 1 THEN
                        v = idehbar(2, idewy + idesubwindow - 1, idewx - 2, Help_cx, help_w + 1)
                        IF mX < v THEN
                            Help_cx = Help_cx - 8
                            IF Help_cx < 1 THEN Help_cx = 1
                            IF Help_sx > Help_cx THEN Help_sx = Help_cx
                            idewait
                        END IF
                        IF mX > v THEN
                            Help_cx = Help_cx + 8
                            IF Help_cx > help_w + 1 THEN Help_cx = help_w + 1
                            idewait
                        END IF
                    END IF
                    IF Help_Scrollbar = 2 THEN
                        v = idevbar(idewx, idewy + 1, idesubwindow - 2, Help_cy, help_h + 1)
                        IF mY < v THEN KB = KEY_PAGEUP: idewait 'fall through...
                        IF mY > v THEN KB = KEY_PAGEDOWN: idewait 'fall through...
                    END IF

                END IF



                IF Help_Scrollbar_Method = 4 THEN
                    IF Help_Scrollbar = 1 THEN
                        IF help_w > 1 THEN
                            IF mX <= 3 THEN
                                Help_sx = 1: Help_cx = 1
                            ELSEIF mX >= idewx - 2 THEN
                                Help_sx = help_w + 1: Help_cx = help_w + 1
                            ELSE
                                x = mX
                                p! = x - 4 + .5 '4 (the min pos) becomes .5
                                p! = p! / (idewx - 3 - 3)
                                i = p! * (help_w) + 1
                                Help_sx = i: Help_cx = i
                            END IF
                        END IF
                    END IF
                    IF Help_Scrollbar = 2 THEN
                        IF help_h > 1 THEN

                            IF mY <= idewy + 2 THEN
                                Help_cy = 1
                            ELSEIF mY >= idewy + idesubwindow - 3 THEN
                                Help_cy = help_h + 1
                            ELSE
                                y = mY
                                p! = y - idewy - 3 + .5
                                p! = p! / (idesubwindow - 3 - 3)
                                i = p! * (help_h) + 1
                                Help_cy = i
                            END IF
                            'fix cursor
                            IF Help_cx < 1 THEN Help_cx = 1
                            IF Help_cx > help_w + 1 THEN Help_cx = help_w + 1
                            IF Help_cy < 1 THEN Help_cy = 1
                            IF Help_cy > help_h + 1 THEN Help_cy = help_h + 1
                            'screen follows cursor
                            IF Help_cx < Help_sx THEN Help_sx = Help_cx
                            IF Help_cx >= Help_sx + Help_ww THEN Help_sx = Help_cx - Help_ww + 1
                            IF Help_cy < Help_sy THEN Help_sy = Help_cy
                            IF Help_cy >= Help_sy + Help_wh THEN Help_sy = Help_cy - Help_wh + 1
                            'fix screen
                            IF Help_sx < 1 THEN Help_sx = 1
                            IF Help_sy < 1 THEN Help_sy = 1
                        END IF
                    END IF
                END IF

                'IF mB AND idemouseselect = 2 THEN
                '    'move vbar scroller (idecy) to appropriate position
                '    IF iden > 1 THEN
                '        IF mY <= 4 THEN idecy = 1
                '        IF mY >= idewy - 7 THEN idecy = iden
                '        IF mY > 4 AND mY < idewy - 7 THEN
                '            y = mY
                '            p! = y - 3 - 2 + .5
                '            p! = p! / ((idewy - 8) - 4)
                '            i = p! * (iden - 1) + 1
                '            idecy = i
                '        END IF
                '    END IF
                'END IF


                IF mCLICK THEN mCLICK = 0
            END IF

        END IF 'system=3
    END IF 'idehelp




    'IdeSystem specific code goes here

    IF mCLICK THEN 'Find [...] search field (IdeSystem = 2)
        IF mY = idewy - 4 AND mX > idewx - (idesystem2.w + 10) AND mX < idewx - 1 THEN 'inside text box
            IF mX <= idewx - (idesystem2.w + 8) + 2 THEN
                IF LEN(idefindtext) = 0 THEN
                    IdeSystem = 2 'no search string, so begin editing
                    idesystem2.issel = 0: idesystem2.v1 = 0
                ELSE
                    IdeAddSearched idefindtext
                    IdeSystem = 1: GOTO idemf3 'F3 functionality
                END IF
            ELSE
                IF mX = idewx - 3 THEN
                    showrecentlysearchedbox:
                    PCOPY 0, 3
                    GOSUB UpdateSearchBar
                    f$ = idesearchedbox
                    IF LEN(f$) THEN idefindtext = f$
                    PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                    idealthighlight = 0
                    LOCATE , , 0: COLOR 0, 7: LOCATE 1, 1: PRINT menubar$;
                    IdeSystem = 1
                    IF LEN(f$) THEN GOTO idemf3 'F3 functionality
                    GOTO ideloop
                ELSE
                    IF IdeSystem = 2 THEN
                        if idesystem2.issel then idesystem2.issel = 0

                        if len(idefindtext) <= idesystem2.w THEN
                            idesystem2.v1 = mX - (idewx - (idesystem2.w + 4))
                        else
                            if idesystem2.v1 > idesystem2.w then
                                idesystem2.v1 = (mX - (idewx - (idesystem2.w + 4))) + (idesystem2.v1 - idesystem2.w)
                            else
                                idesystem2.v1 = mX - (idewx - (idesystem2.w + 4))
                            end if
                        END IF
                    ELSE
                        IdeSystem = 2
                        if len(idefindtext) then idesystem2.issel = -1: idesystem2.sx1 = 0: idesystem2.v1 = len(idefindtext)
                    END IF
                END IF
            END IF
        END IF
    END IF

    'IdeSystem

    IF KB = KEY_F6 THEN 'switch windows
        IF idehelp = 1 THEN
            IF IdeSystem = 3 THEN
                IdeSystem = 1
            ELSE
                IdeSystem = 3
            END IF
        END IF
    END IF

    IF idehelp = 1 THEN 'switch windows?
        IF mCLICK OR mCLICK2 THEN
            IF IdeSystem = 3 THEN
                IF mY >= 2 AND mY < idewy THEN
                    IdeSystem = 1
                END IF
            ELSE
                IF mY >= idewy AND mY < idewy + idesubwindow THEN
                    IdeSystem = 3
                END IF
            END IF
        END IF
    END IF

    IF IdeSystem = 2 THEN 'certain keys transfer control
        z = 0
        IF (KALT AND KB = KEY_UP) OR (KALT AND KB = KEY_DOWN) THEN GOTO showrecentlysearchedbox
        IF KB = KEY_UP THEN z = 1
        IF KB = KEY_DOWN THEN z = 1
        IF KB = KEY_PAGEUP THEN z = 1
        IF KB = KEY_PAGEDOWN THEN z = 1
        IF mWHEEL THEN z = 1
        IF z = 1 THEN IdeSystem = 1
    END IF

    IF IdeSystem = 2 THEN
        a$ = idefindtext
        IF LEN(K$) = 1 THEN
            k = ASC(K$)
            IF (KSHIFT AND KB = KEY_INSERT) OR (KCONTROL AND UCASE$(K$) = "V") THEN 'paste from clipboard
                clip$ = _CLIPBOARD$ 'read clipboard
                x = INSTR(clip$, CHR$(13))
                IF x THEN clip$ = LEFT$(clip$, x - 1)
                x = INSTR(clip$, CHR$(10))
                IF x THEN clip$ = LEFT$(clip$, x - 1)
                IF LEN(clip$) THEN
                    IF idesystem2.issel THEN
                        sx1 = idesystem2.sx1: sx2 = idesystem2.v1
                        IF sx1 > sx2 THEN SWAP sx1, sx2
                        IF sx2 - sx1 > 0 THEN
                            a$ = LEFT$(a$, sx1) + clip$ + RIGHT$(a$, LEN(a$) - sx2)
                            idesystem2.v1 = sx1
                            idesystem2.issel = 0
                        END IF
                    ELSE
                        a$ = LEFT$(a$, idesystem2.v1) + clip$ + RIGHT$(a$, LEN(a$) - idesystem2.v1)
                    END IF
                END IF
                k = 255
            END IF

            IF (KCONTROL AND UCASE$(K$) = "A") THEN 'select all
                IF LEN(a$) > 0 THEN
                    idesystem2.issel = -1
                    idesystem2.sx1 = 0
                    idesystem2.v1 = LEN(a$)
                END IF
                k = 255
            END IF

            IF ((KCTRL AND KB = KEY_INSERT) OR (KCONTROL AND UCASE$(K$) = "C")) THEN 'copy to clipboard
                IF idesystem2.issel THEN
                    sx1 = idesystem2.sx1: sx2 = idesystem2.v1
                    IF sx1 > sx2 THEN SWAP sx1, sx2
                    IF sx2 - sx1 > 0 THEN _CLIPBOARD$ = MID$(a$, sx1 + 1, sx2 - sx1)
                END IF
                k = 255
            END IF

            IF ((KSHIFT AND KB = KEY_DELETE) OR (KCONTROL AND UCASE$(K$) = "X")) THEN 'cut to clipboard
                IF idesystem2.issel THEN
                    sx1 = idesystem2.sx1: sx2 = idesystem2.v1
                    IF sx1 > sx2 THEN SWAP sx1, sx2
                    IF sx2 - sx1 > 0 THEN
                        _CLIPBOARD$ = MID$(a$, sx1 + 1, sx2 - sx1)
                        'delete selection
                        a$ = LEFT$(a$, sx1) + RIGHT$(a$, LEN(a$) - sx2)
                        idesystem2.v1 = sx1
                        idesystem2.issel = 0
                    END IF
                END IF
                k = 255
            END IF

            IF k = 8 THEN
                IF idesystem2.issel THEN
                    sx1 = idesystem2.sx1: sx2 = idesystem2.v1
                    IF sx1 > sx2 THEN SWAP sx1, sx2
                    IF sx2 - sx1 > 0 THEN
                        'delete selection
                        a$ = LEFT$(a$, sx1) + RIGHT$(a$, LEN(a$) - sx2)
                        idefindtext = a$
                        idesystem2.v1 = sx1
                        idesystem2.issel = 0
                    END IF
                ELSEIF idesystem2.v1 > 0 THEN
                    a1$ = LEFT$(a$, idesystem2.v1 - 1)
                    IF idesystem2.v1 <= LEN(a$) THEN a2$ = RIGHT$(a$, LEN(a$) - idesystem2.v1) ELSE a2$ = ""
                    a$ = a1$ + a2$: idesystem2.v1 = idesystem2.v1 - 1
                    idefindtext = a$
                END IF
            END IF
            IF k = 27 THEN
                IdeSystem = 1
                GOTO specialchar
            END IF
            IF k = 9 THEN
                IdeSystem = 1
                GOTO specialchar
            END IF
            IF k = 13 THEN
                IF LEN(idefindtext) THEN
                    IdeAddSearched idefindtext
                    GOTO idemf3 'F3 functionality
                END IF
                GOTO specialchar
            END IF
            IF k <> 8 AND k <> 9 AND k <> 0 AND k <> 10 AND k <> 13 AND k <> 26 AND k <> 255 THEN
                IF idesystem2.issel THEN
                    sx1 = idesystem2.sx1: sx2 = idesystem2.v1
                    IF sx1 > sx2 THEN SWAP sx1, sx2
                    IF sx2 - sx1 > 0 THEN
                        'replace selection
                        a$ = LEFT$(a$, sx1) + RIGHT$(a$, LEN(a$) - sx2)
                        idefindtext = a$
                        idesystem2.issel = 0
                        idesystem2.v1 = sx1
                    end if
                end if
                IF idesystem2.v1 > 0 THEN a1$ = LEFT$(a$, idesystem2.v1) ELSE a1$ = ""
                IF idesystem2.v1 <= LEN(a$) THEN a2$ = RIGHT$(a$, LEN(a$) - idesystem2.v1) ELSE a2$ = ""
                a$ = a1$ + K$ + a2$: idesystem2.v1 = idesystem2.v1 + 1
            END IF
            idefindtext = a$
        END IF

        IF K$ = CHR$(0) + "S" THEN 'DEL
            if idesystem2.issel THEN
                sx1 = idesystem2.sx1: sx2 = idesystem2.v1
                if sx1 > sx2 then SWAP sx1, sx2
                if sx2 - sx1 > 0 then
                    'delete selection
                    a$ = left$(a$, sx1) + right$(a$, len(a$) - sx2)
                    idefindtext = a$
                    idesystem2.v1 = sx1
                    idesystem2.issel = 0
                end if
            else
                IF idesystem2.v1 > 0 THEN a1$ = LEFT$(a$, idesystem2.v1) ELSE a1$ = ""
                IF idesystem2.v1 < LEN(a$) THEN a2$ = RIGHT$(a$, LEN(a$) - idesystem2.v1 - 1) ELSE a2$ = ""
                a$ = a1$ + a2$
                idefindtext = a$
            end if
        END IF

        'cursor control
        if K$ = CHR$(0) + "K" THEN GOSUB selectcheck: idesystem2.v1 = idesystem2.v1 - 1
        IF K$ = CHR$(0) + "M" THEN GOSUB selectcheck: idesystem2.v1 = idesystem2.v1 + 1
        IF K$ = CHR$(0) + "G" THEN GOSUB selectcheck: idesystem2.v1 = 0
        IF K$ = CHR$(0) + "O" THEN GOSUB selectcheck: idesystem2.v1 = LEN(a$)
        IF idesystem2.v1 < 0 THEN idesystem2.v1 = 0
        IF idesystem2.v1 > LEN(a$) THEN idesystem2.v1 = LEN(a$)
        IF idesystem2.v1 = idesystem2.sx1 then idesystem2.issel = 0

        IF mCLICK or mCLICK2 THEN
            IF mX > 1 AND mX < idewx AND mY > 2 AND mY < (idewy - 5) THEN 'inside text box
                IdeSystem = 1
                if mCLICK2 THEN goto invokecontextualmenu ELSE goto ideloop
            END IF
        END IF

        GOTO specialchar
    END IF

    IF IdeSystem = 3 THEN

        IF mCLICK OR K$ = CHR$(27) THEN
            IF (mY = idewy AND mX = idewx - 2) OR K$ = CHR$(27) THEN 'close help


                'IF idesubwindow THEN PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt: GOTO ideloop
                'idesubwindow = idewy \ 2: idewy = idewy - idesubwindow

                idewy = idewy + idesubwindow
                idehelp = 0
                idesubwindow = 0
                skipdisplay = 0
                IdeSystem = 1
                retval = 1: GOTO redraweverything2

            END IF
        END IF


        IF mCLICK THEN
            IF mY = idewy THEN

                sx = 2
                FOR x = Back_Str_Pos TO Back_Str_Pos + idewx - 6
                    IF mX = sx THEN
                        i = CVL(MID$(Back_Str_I$, (x - 1) * 4 + 1, 4))
                        a = ASC(Back_Str$, x)
                        IF a <> 0 AND i <> Help_Back_Pos THEN
                            Help_Back(Help_Back_Pos).sx = Help_sx 'update position
                            Help_Back(Help_Back_Pos).sy = Help_sy
                            Help_Back(Help_Back_Pos).cx = Help_cx
                            Help_Back(Help_Back_Pos).cy = Help_cy
                            Help_Back_Pos = i
                            Help_Select = 0: Help_MSelect = 0
                            Help_sx = Help_Back(Help_Back_Pos).sx
                            Help_sy = Help_Back(Help_Back_Pos).sy
                            Help_cx = Help_Back(Help_Back_Pos).cx
                            Help_cy = Help_Back(Help_Back_Pos).cy
                            a$ = Wiki(Back$(Help_Back_Pos))
                            WikiParse a$
                            GOTO newpageparsed
                        END IF
                    END IF
                    sx = sx + 1
                NEXT

                'LOCATE idewy, 2
                'FOR x = Back_Str_Pos TO Back_Str_Pos + idewx - 5
                '    i = CVL(MID$(Back_Str_I$, (x - 1) * 4 + 1, 4))
                '    a = ASC(Back_Str$, x)
                '    IF a THEN
                '        COLOR 0, 7
                '        IF i < Help_Back_Pos THEN COLOR 9, 7
                '        IF i > Help_Back_Pos THEN COLOR 9, 7
                '        PRINT CHR$(a);
                '    ELSE
                '        COLOR 7, 0
                '        PRINT chr$(196);
                '    END IF
                'NEXT


            END IF
        END IF

        IF KCONTROL AND UCASE$(K$) = "A" THEN 'select all
            IF help_h THEN
                Help_Select = 2
                Help_SelX1 = 1
                Help_SelY1 = 1
                Help_SelX2 = 10000000
                Help_SelY2 = help_h
                Help_cx = 1: Help_cy = help_h + 1
                GOTO keep_select
            END IF
        END IF

        IF ((KCTRL AND KB = KEY_INSERT) OR (KCONTROL AND UCASE$(K$) = "C")) AND Help_Select = 2 THEN 'copy to clipboard
            clip$ = ""
            FOR y = Help_SelY1 TO Help_SelY2
                IF y <> Help_SelY1 THEN clip$ = clip$ + CHR$(13) + CHR$(10)
                a$ = ""
                IF y <= help_h THEN
                    l = CVL(MID$(Help_Line$, (y - 1) * 4 + 1, 4))
                    x = l
                    x3 = 1
                    c = ASC(Help_Txt$, x)
                    DO UNTIL c = 13
                        IF Help_Select = 2 THEN
                            IF y >= Help_SelY1 AND y <= Help_SelY2 THEN
                                IF x3 >= Help_SelX1 AND x3 <= Help_SelX2 THEN
                                    a$ = a$ + CHR$(c)
                                END IF
                            END IF
                        END IF
                        x3 = x3 + 1: x = x + 4: c = ASC(Help_Txt$, x)
                    LOOP
                END IF
                clip$ = clip$ + a$
            NEXT
            IF Help_SelY1 = Help_SelY2 AND Help_cy > Help_cy1 THEN clip$ = clip$ + CHR$(13) + CHR$(10)
            IF clip$ <> "" THEN _CLIPBOARD$ = clip$
            GOTO keep_select
        END IF


        IF mX >= Help_wx1 AND mY >= Help_wy1 AND mX <= Help_wx2 AND mY <= Help_wy2 THEN
            IF mCLICK THEN
                Help_cx = Help_sx + (mX - Help_wx1)
                Help_cy = Help_sy + (mY - Help_wy1)
                Help_Select = 1
                Help_MSelect = 1
                Help_cx1 = Help_cx: Help_cy1 = Help_cy
                GOTO keep_select
            END IF
            IF (mB AND Help_Scrollbar = 0) THEN
                Help_cx = Help_sx + (mX - Help_wx1)
                Help_cy = Help_sy + (mY - Help_wy1)
                IF Help_Select THEN GOTO keep_select
            END IF
        ELSE
            'outside field
            IF (mB AND Help_Scrollbar = 0) AND Help_MSelect = 1 AND Help_Select = 2 THEN
                IF mX < Help_wx1 THEN Help_cx = Help_cx - 1
                IF mX > Help_wx2 THEN Help_cx = Help_cx + 1
                IF mY < Help_wy1 THEN Help_cy = Help_cy - 1
                IF mY > Help_wy2 THEN Help_cy = Help_cy + 1
                GOTO keep_select
            END IF
        END IF

        IF KSHIFT THEN
            IF Help_Select = 0 THEN
                Help_Select = 1
                Help_MSelect = 0
                Help_cx1 = Help_cx: Help_cy1 = Help_cy
            END IF
        ELSE
            IF (KB > 0 OR mWHEEL <> 0) AND KSTATECHANGED = 0 THEN Help_Select = 0
        END IF
        keep_select:

        IF KB = KEY_DELETE THEN
            IF LEN(Help_Search_Str) THEN norep = 1: GOTO delsrchagain
        END IF

        IF LEN(K$) = 1 AND KCONTROL = 0 THEN
            k = ASC(K$)
            IF alphanumeric(k) OR k = 36 OR k = 32 THEN
                norep = 0
                t# = TIMER(0.001)
                oldk = 0: IF LEN(Help_Search_Str) THEN oldk = ASC(Help_Search_Str, LEN(Help_Search_Str))
                IF t# > Help_Search_Time + 1 OR t# < Help_Search_Time OR (k = oldk AND LEN(Help_Search_Str) = 1) THEN
                    IF k = oldk THEN norep = 1
                    Help_Search_Str = K$
                ELSE
                    Help_Search_Str = Help_Search_Str + K$
                END IF
                Help_Search_Time = t#
                'search for next appropriate link
                delsrchagain:
                ox = Help_cx
                oy = Help_cy
                IF oy > help_h THEN oy = 1
                cy = oy
                cx = ox
                IF norep = 1 THEN cx = cx + 1
                looped = 0
                DO
                    'build the line
                    l = CVL(MID$(Help_Line$, (cy - 1) * 4 + 1, 4))
                    x = l
                    a$ = ""
                    c = ASC(Help_Txt$, x)
                    DO UNTIL c = 13
                        lnk = CVI(MID$(Help_Txt$, x + 2, 2))
                        IF lnk THEN a$ = a$ + CHR$(c) ELSE a$ = a$ + CHR$(0) 'only add text with links
                        x = x + 4: c = ASC(Help_Txt$, x)
                    LOOP

                    helpscanrow:
                    px = INSTR(cx, UCASE$(a$), UCASE$(Help_Search_Str))
                    px2 = INSTR(cx, UCASE$(a$), UCASE$("_" + Help_Search_Str))
                    IF px2 < px AND px2 <> 0 AND LEFT$(Help_Search_Str, 1) <> "_" THEN px = px2

                    IF looped = 1 AND cy = oy AND px = 0 THEN GOTO strnotfound
                    IF px THEN
                        'isolate and REVERSE select link
                        l = CVL(MID$(Help_Line$, (cy - 1) * 4 + 1, 4))
                        x = l
                        x2 = 1
                        a$ = ""
                        c = ASC(Help_Txt$, x)
                        oldlnk = 0
                        lnkx1 = 0: lnkx2 = 0
                        DO UNTIL c = 13
                            lnk = CVI(MID$(Help_Txt$, x + 2, 2))
                            IF lnkx1 = 0 AND lnk <> 0 AND oldlnk = 0 AND px = x2 THEN lnkx1 = x2
                            IF lnkx1 <> 0 AND lnk = 0 AND lnkx2 = 0 THEN lnkx2 = x2 - 1
                            x = x + 4: c = ASC(Help_Txt$, x)
                            x2 = x2 + 1
                            oldlnk = lnk
                        LOOP

                        IF Back_Name$(Help_Back_Pos) = "Alphabetical" OR Back_Name$(Help_Back_Pos) = "By Usage" THEN
                            IF lnkx1 <> 3 THEN
                                cx = px + 1
                                GOTO helpscanrow
                            END IF
                        END IF

                        IF lnkx1 THEN
                            IF lnkx2 = 0 THEN lnkx2 = x2 - 1
                            Help_Select = 2
                            Help_cx1 = lnkx2 + 1
                            Help_cx = lnkx1
                            Help_cy = cy
                            Help_cy1 = cy
                            GOTO foundsstr
                        END IF

                        cx = px + 1
                        GOTO helpscanrow
                    END IF
                    cx = 1
                    cy = cy + 1
                    IF cy > help_h THEN cy = 1: looped = 1
                LOOP
            END IF
        END IF
        foundsstr:
        strnotfound:

        IF KB = KEY_HOME AND KCONTROL THEN
            Help_cx = 1: Help_cy = 1
        END IF
        IF KB = KEY_END AND KCONTROL THEN
            Help_cx = 1: Help_cy = help_h + 1
        END IF

        IF KB = KEY_HOME AND KCONTROL = 0 THEN Help_cx = 1
        IF KB = KEY_END AND KCONTROL = 0 THEN
            Help_cx = Help_LineLen(Help_cy - Help_sy) + 1
        END IF

        IF KB = KEY_PAGEUP THEN
            Help_cy = Help_cy - (Help_wh - 1)
        END IF

        IF KB = KEY_PAGEDOWN THEN
            Help_cy = Help_cy + (Help_wh - 1)
        END IF

        IF KB = KEY_DOWN THEN Help_cy = Help_cy + 1
        IF KB = KEY_UP THEN Help_cy = Help_cy - 1
        IF KB = KEY_LEFT THEN Help_cx = Help_cx - 1
        IF KB = KEY_RIGHT THEN Help_cx = Help_cx + 1

        'move relative to top/bottom
        IF mWHEEL < 0 THEN Help_cy = Help_sy
        IF mWHEEL > 0 THEN Help_cy = Help_sy + (Help_wh - 1)
        Help_cy = Help_cy + mWHEEL * 3

        'fix cursor
        IF Help_cx < 1 THEN Help_cx = 1
        IF Help_cx > help_w + 1 THEN Help_cx = help_w + 1
        IF Help_cy < 1 THEN Help_cy = 1
        IF Help_cy > help_h + 1 THEN Help_cy = help_h + 1

        'screen follows cursor
        IF Help_cx < Help_sx THEN Help_sx = Help_cx
        IF Help_cx >= Help_sx + Help_ww THEN Help_sx = Help_cx - Help_ww + 1

        IF Help_cy < Help_sy THEN Help_sy = Help_cy
        IF Help_cy >= Help_sy + Help_wh THEN Help_sy = Help_cy - Help_wh + 1

        'fix screen
        IF Help_sx < 1 THEN Help_sx = 1
        IF Help_sy < 1 THEN Help_sy = 1

        IF K$ = CHR$(8) THEN
            IF Help_Back_Pos > 1 THEN
                Help_Back(Help_Back_Pos).sx = Help_sx 'update position
                Help_Back(Help_Back_Pos).sy = Help_sy
                Help_Back(Help_Back_Pos).cx = Help_cx
                Help_Back(Help_Back_Pos).cy = Help_cy
                Help_Back_Pos = Help_Back_Pos - 1
                Help_Select = 0: Help_MSelect = 0
                Help_sx = Help_Back(Help_Back_Pos).sx
                Help_sy = Help_Back(Help_Back_Pos).sy
                Help_cx = Help_Back(Help_Back_Pos).cx
                Help_cy = Help_Back(Help_Back_Pos).cy
                a$ = Wiki(Back$(Help_Back_Pos))
                WikiParse a$
                GOTO newpageparsed
            END IF
        END IF

        IF Help_cy >= 1 AND Help_cy <= help_h THEN
            l = CVL(MID$(Help_Line$, (Help_cy - 1) * 4 + 1, 4))
            x = l
            x2 = 1
            c = ASC(Help_Txt$, x)
            DO UNTIL c = 13

                IF x2 = Help_cx THEN
                    lnk = CVI(MID$(Help_Txt$, x + 2, 2))
                    IF lnk THEN
                        'retrieve lnk info
                        l1 = 1
                        FOR lx = 1 TO lnk - 1
                            l1 = INSTR(l1, Help_Link$, Help_Link_Sep$) + 1
                        NEXT
                        l2 = INSTR(l1, Help_Link$, Help_Link_Sep$) - 1
                        l$ = MID$(Help_Link$, l1, l2 - l1 + 1)
                        'assume PAGE
                        l$ = RIGHT$(l$, LEN(l$) - 5)

                        IF mCLICK OR K$ = CHR$(13) THEN
                            mCLICK = 0

                            IF Back$(Help_Back_Pos) <> l$ THEN
                                Help_Select = 0: Help_MSelect = 0
                                'COLOR 7, 0

                                Help_Back(Help_Back_Pos).sx = Help_sx 'update position
                                Help_Back(Help_Back_Pos).sy = Help_sy
                                Help_Back(Help_Back_Pos).cx = Help_cx
                                Help_Back(Help_Back_Pos).cy = Help_cy

                                top = UBOUND(back$)

                                IF Help_Back_Pos < top THEN
                                    IF Back$(Help_Back_Pos + 1) = l$ THEN
                                        GOTO usenextentry
                                    END IF
                                END IF

                                top = top + 1
                                REDIM _PRESERVE Back(top) AS STRING
                                REDIM _PRESERVE Help_Back(top) AS Help_Back_Type
                                REDIM _PRESERVE Back_Name(top) AS STRING
                                'Shuffle array upwards after current pos
                                FOR x = top - 1 TO Help_Back_Pos + 1 STEP -1
                                    Back_Name$(x + 1) = Back_Name$(x)
                                    Back$(x + 1) = Back$(x)
                                    Help_Back(x + 1).sx = Help_Back(x).sx
                                    Help_Back(x + 1).sy = Help_Back(x).sy
                                    Help_Back(x + 1).cx = Help_Back(x).cx
                                    Help_Back(x + 1).cy = Help_Back(x).cy
                                NEXT
                                usenextentry:
                                Help_Back_Pos = Help_Back_Pos + 1
                                Back$(Help_Back_Pos) = l$
                                Back_Name$(Help_Back_Pos) = Back2BackName$(l$)
                                Help_Back(Help_Back_Pos).sx = 1
                                Help_Back(Help_Back_Pos).sy = 1
                                Help_Back(Help_Back_Pos).cx = 1
                                Help_Back(Help_Back_Pos).cy = 1
                                Help_sx = 1: Help_sy = 1: Help_cx = 1: Help_cy = 1
                                a$ = Wiki(l$)
                                WikiParse a$
                                GOTO newpageparsed
                            END IF
                        END IF

                    END IF
                END IF
                x = x + 4: c = ASC(Help_Txt$, x)
                x2 = x2 + 1
            LOOP
        END IF

        IF Help_Select THEN
            Help_Select = 1 'revert to non-selected if cursor moved to neutral pos
            IF Help_cx <> Help_cx1 OR Help_cy <> Help_cy1 THEN Help_Select = 2
        END IF

        'Determine the exact region selected
        IF Help_Select = 2 THEN
            IF Help_cy = Help_cy1 THEN
                Help_SelY1 = Help_cy: Help_SelY2 = Help_cy
                IF Help_cx > Help_cx1 THEN
                    Help_SelX1 = Help_cx1: Help_SelX2 = Help_cx - 1
                ELSE
                    Help_SelX1 = Help_cx: Help_SelX2 = Help_cx1 - 1
                END IF
            ELSE
                Help_SelX1 = 1: Help_SelX2 = 10000000
                IF Help_cy > Help_cy1 THEN
                    Help_SelY1 = Help_cy1: Help_SelY2 = Help_cy
                    IF Help_cx = 1 THEN Help_SelY2 = Help_cy - 1
                ELSE
                    Help_SelY1 = Help_cy: Help_SelY2 = Help_cy1
                END IF
            END IF
        END IF

        newpageparsed:
        GOTO specialchar
    END IF



    IF KB = KEY_F1 THEN
        contextualhelp:
        'identify word or character at current cursor position
        a$ = idegetline(idecy)
        x = idecx
        IF x <= LEN(a$) THEN
            IF alphanumeric(ASC(a$, x)) THEN
                x1 = x
                DO WHILE x1 > 1
                    IF alphanumeric(ASC(a$, x1 - 1)) OR ASC(a$, x1 - 1) = 36 THEN x1 = x1 - 1 ELSE EXIT DO
                LOOP
                x2 = x
                DO WHILE x2 < LEN(a$)
                    IF alphanumeric(ASC(a$, x2 + 1)) OR ASC(a$, x2 + 1) = 36 THEN x2 = x2 + 1 ELSE EXIT DO
                LOOP
                a2$ = MID$(a$, x1, x2 - x1 + 1)
            ELSE
                a2$ = CHR$(ASC(a$, x))
            END IF
            a2$ = UCASE$(a2$)
            'check if F1 is in help links
            fh = FREEFILE
            OPEN "internal\help\links.bin" FOR INPUT AS #fh
            lnks = 0: lnks$ = CHR$(0)
            DO UNTIL EOF(fh)
                LINE INPUT #fh, l$
                c = INSTR(l$, ","): l1$ = LEFT$(l$, c - 1): l2$ = RIGHT$(l$, LEN(l$) - c)
                IF a2$ = UCASE$(l1$) THEN
                    IF INSTR(lnks$, CHR$(0) + l2$ + CHR$(0)) = 0 THEN
                        lnks = lnks + 1
                        IF l2$ = l1$ THEN
                            lnks$ = CHR$(0) + l2$ + lnks$
                        ELSE
                            lnks$ = lnks$ + l2$ + CHR$(0)
                        END IF
                    END IF
                END IF
            LOOP
            CLOSE #fh

            IF lnks THEN
                lnks$ = MID$(lnks$, 2, LEN(lnks$) - 2)
                lnk$ = lnks$
                IF lnks > 1 THEN
                    'clarify context
                    lnk$ = idef1box$(lnks$, lnks)
                    if lnk$ = "C" then goto ideloop
                END IF


                OpenHelpLnk:


                Help_Back(Help_Back_Pos).sx = Help_sx 'update position
                Help_Back(Help_Back_Pos).sy = Help_sy
                Help_Back(Help_Back_Pos).cx = Help_cx
                Help_Back(Help_Back_Pos).cy = Help_cy

                top = UBOUND(back$)


                IF Back$(Help_Back_Pos) = lnk$ THEN Help_Back_Pos = Help_Back_Pos - 1: GOTO usenextentry2
                IF Help_Back_Pos < top THEN
                    IF Back$(Help_Back_Pos + 1) = lnk$ THEN
                        GOTO usenextentry2
                    END IF
                END IF


                top = top + 1
                REDIM _PRESERVE Back(top) AS STRING
                REDIM _PRESERVE Help_Back(top) AS Help_Back_Type
                REDIM _PRESERVE Back_Name(top) AS STRING
                'Shuffle array upwards after current pos
                FOR x = top - 1 TO Help_Back_Pos + 1 STEP -1
                    Back_Name$(x + 1) = Back_Name$(x)
                    Back$(x + 1) = Back$(x)
                    Help_Back(x + 1).sx = Help_Back(x).sx
                    Help_Back(x + 1).sy = Help_Back(x).sy
                    Help_Back(x + 1).cx = Help_Back(x).cx
                    Help_Back(x + 1).cy = Help_Back(x).cy
                NEXT
                usenextentry2:
                Help_Back_Pos = Help_Back_Pos + 1
                Back$(Help_Back_Pos) = lnk$
                Back_Name$(Help_Back_Pos) = Back2BackName$(lnk$)
                Help_Back(Help_Back_Pos).sx = 1
                Help_Back(Help_Back_Pos).sy = 1
                Help_Back(Help_Back_Pos).cx = 1
                Help_Back(Help_Back_Pos).cy = 1
                Help_sx = 1: Help_sy = 1: Help_cx = 1: Help_cy = 1

                a$ = Wiki(lnk$)

                IF idehelp = 0 THEN
                    IF idesubwindow THEN PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt: GOTO ideloop
                    idesubwindow = idewy \ 2: idewy = idewy - idesubwindow
                    Help_wx1 = 2: Help_wy1 = idewy + 1: Help_wx2 = idewx - 1: Help_wy2 = idewy + idesubwindow - 2: Help_ww = Help_wx2 - Help_wx1 + 1: Help_wh = Help_wy2 - Help_wy1 + 1
                    WikiParse a$
                    idehelp = 1
                    skipdisplay = 0
                    IdeSystem = 3 'Standard qb45 behaviour. Allows for quick peek at help then ESC.
                    retval = 1: GOTO redraweverything2
                END IF

                WikiParse a$
                IdeSystem = 3 'Standard qb45 behaviour. Allows for quick peek at help then ESC.
                GOTO specialchar

            END IF 'lnks

        END IF
        GOTO specialchar
    END IF



    IF KALT AND KB = KEY_LEFT THEN
        bmkremoved = 0
        bmkremove:
        FOR b = 1 TO IdeBmkN
            IF IdeBmk(b).y = idecy THEN
                FOR b2 = b TO IdeBmkN - 1
                    IdeBmk(b2) = IdeBmk(b2 + 1)
                NEXT
                IdeBmkN = IdeBmkN - 1
                bmkremoved = 1
                ideunsaved = 1
                GOTO bmkremove
            END IF
        NEXT
        IF bmkremoved = 0 THEN
            IdeBmkN = IdeBmkN + 1
            IF IdeBmkN > UBOUND(IdeBmk) THEN x = UBOUND(IdeBmk) * 2: REDIM _PRESERVE IdeBmk(x) AS IdeBmkType
            IdeBmk(IdeBmkN).y = idecy
            IdeBmk(IdeBmkN).x = idecx
            IdeBmk(IdeBmkN).reserved = 0: IdeBmk(IdeBmkN).reserved2 = 0
            ideunsaved = 1
        END IF
        GOTO specialchar
    END IF

    IF KALT AND (KB = KEY_DOWN OR KB = KEY_UP) THEN
        IF IdeBmkN = 0 THEN
            idemessagebox "Bookmarks", "No bookmarks exist (Use Alt+Left to create a bookmark)"
            SCREEN , , 3, 0: idewait4mous: idewait4alt
            idealthighlight = 0
            LOCATE , , 0: COLOR 0, 7: LOCATE 1, 1: PRINT menubar$;
            GOTO specialchar
        END IF
        IF IdeBmkN = 1 THEN
            IF idecy = IdeBmk(1).y THEN
                idemessagebox "Bookmarks", "No other bookmarks exist"
                SCREEN , , 3, 0: idewait4mous: idewait4alt
                idealthighlight = 0
                LOCATE , , 0: COLOR 0, 7: LOCATE 1, 1: PRINT menubar$;
                GOTO specialchar
            END IF
        END IF
        l = idecy
        DO
            IF KB = KEY_DOWN THEN l = l + 1 ELSE l = l - 1
            IF l < 1 THEN l = iden
            IF l > iden THEN l = 1
            FOR b = 1 TO IdeBmkN
                IF IdeBmk(b).y = l THEN EXIT DO
            NEXT
        LOOP
        AddQuickNavHistory idecy
        idecy = l
        idecx = IdeBmk(b).x
        ideselect = 0
        GOTO specialchar
    END IF

    IF KALT AND KB = KEY_RIGHT THEN
        '***RESERVED***
        GOTO specialchar
    END IF


    IF KALT AND KB >= 48 AND KB <= 57 THEN GOTO specialchar ' Steve Edit on 07-04-2014 to add support for ALT-numkey combos to produce ASCII codes

    IF mCLICK THEN
        IF mX > 1 AND mX < idewx AND mY > 2 AND mY < (idewy - 5) THEN 'inside text box
            ideselect = 1
            idecx = mX - 1 + idesx - 1
            idecy = mY - 2 + idesy - 1
            IF idecy > iden THEN idecy = iden
            ideselect = 1: ideselectx1 = idecx: ideselecty1 = idecy
            idemouseselect = 1
        END IF
    END IF

    IF mCLICK2 THEN 'Second mouse button pressed.
        invokecontextualmenu:
        IF mX > 1 AND mX < idewx AND mY > 2 AND mY < (idewy - 5) THEN 'inside text box
            if ideselect = 0 then 'Right click only positions the cursor if no selection is active
                idecx = mX - 1 + idesx - 1
                idecy = mY - 2 + idesy - 1
                IF idecy > iden THEN idecy = iden
            else 'A selection is reported but it may be that the user only clicked the screen. Let's check:
                IF ideselecty1 = idecy THEN 'single line selected
                    a$ = idegetline(idecy)
                    a2$ = ""
                    sx1 = ideselectx1: sx2 = idecx
                    IF sx2 < sx1 THEN SWAP sx1, sx2
                    FOR x = sx1 TO sx2 - 1
                        IF x <= LEN(a$) THEN a2$ = a2$ + MID$(a$, x, 1) ELSE a2$ = a2$ + " "
                    NEXT
                    IF a2$ = "" THEN
                        'Told ya.
                        ideselect = 0
                        idecx = mX - 1 + idesx - 1
                        idecy = mY - 2 + idesy - 1
                        IF idecy > iden THEN idecy = iden
                    ELSE
                        'Ok, there is a selection. But we'll override it if the click was outside it
                        IF mX - 1 + idesx - 1 < sx1 OR mX - 1 + idesx - 1 > sx2 THEN
                            ideselect = 0
                            idecx = mX - 1 + idesx - 1
                            idecy = mY - 2 + idesy - 1
                            IF idecy > iden THEN idecy = iden
                            ideshowtext
                            PCOPY 3, 0
                        END IF
                        IF mY - 2 + idesy - 1 < idecy OR mY - 2 + idesy - 1 > idecy THEN
                            ideselect = 0
                            idecx = mX - 1 + idesx - 1
                            idecy = mY - 2 + idesy - 1
                            IF idecy > iden THEN idecy = iden
                            ideshowtext
                            PCOPY 3, 0
                        END IF
                    END IF
                ELSE 'Multiple lines selected
                    'We'll override the selection if the click was outside it
                    sy1 = ideselecty1
                    sy2 = idecy
                    IF sy1 > sy2 THEN SWAP sy1, sy2
                    IF mY - 2 + idesy - 1 < sy1 OR mY - 2 + idesy - 1 > sy2 THEN
                        ideselect = 0
                        idecx = mX - 1 + idesx - 1
                        idecy = mY - 2 + idesy - 1
                        IF idecy > iden THEN idecy = iden
                        ideshowtext
                        PCOPY 3, 0
                    END IF
                END IF
            end if
            idecontextualmenu = 1
            IdeMakeContextualMenu
            GOTO showmenu
        END IF
    END IF

    IF mCLICK THEN
        IF mX = idewx THEN
            IF iden > 1 THEN 'take no action if not slider available
                y = idevbar(idewx, 3, idewy - 8, idecy, iden)
                IF y = mY THEN
                    idemouseselect = 2
                    ideselect = 0
                END IF
            END IF
        END IF
    END IF

    IF mCLICK THEN
        IF mY = idewy - 5 THEN
            x = idehbar(2, idewy - 5, idewx - 2, idesx, 608)
            IF x = mX THEN
                idemouseselect = 3
                ideselect = 0
            END IF
        END IF
    END IF

    IF mB AND idemouseselect = 0 THEN
        IF mX = idewx AND mY > 2 AND mY < idewy - 5 THEN 'inside vbar
            ideselect = 0
            IF mY = 3 THEN KB = KEY_UP: idewait: idembmonitor = 1
            IF mY = idewy - 6 THEN KB = KEY_DOWN: idewait: idembmonitor = 1
            IF mY > 3 AND mY < (idewy - 6) THEN
                'assume not on slider
                IF iden > 1 THEN 'take no action if not slider available
                    y = idevbar(idewx, 3, idewy - 8, idecy, iden)
                    IF y <> mY THEN
                        IF mY < y THEN
                            KB = KEY_PAGEUP: idewait: idembmonitor = 1
                        ELSE
                            KB = KEY_PAGEDOWN: idewait: idembmonitor = 1
                        END IF
                    END IF
                END IF
            END IF
        END IF
    END IF

    IF mB AND idemouseselect = 0 THEN
        IF mY = idewy - 5 AND mX > 1 AND mX < idewx THEN 'inside hbar
            ideselect = 0
            IF mX = 2 THEN KB = KEY_LEFT: idewait: idembmonitor = 1
            IF mX = idewx - 1 THEN KB = KEY_RIGHT: idewait: idembmonitor = 1
            IF mX > 2 AND mX < idewx - 1 THEN
                'assume not on slider
                x = idehbar(2, idewy - 5, idewx - 2, idesx, 608)
                IF x <> mX THEN
                    IF mX < x THEN
                        idecx = idecx - 8
                        IF idecx < 1 THEN idecx = 1
                        idewait: idembmonitor = 1
                    ELSE
                        idecx = idecx + 8
                        idewait: idembmonitor = 1
                    END IF
                END IF

            END IF
        END IF
    END IF

    IF mB AND idemouseselect = 2 THEN
        'move vbar scroller (idecy) to appropriate position
        IF iden > 1 THEN
            IF mY <= 4 THEN idecy = 1
            IF mY >= idewy - 7 THEN idecy = iden
            IF mY > 4 AND mY < idewy - 7 THEN
                y = mY
                p! = y - 3 - 2 + .5
                p! = p! / ((idewy - 8) - 4)
                i = p! * (iden - 1) + 1
                idecy = i
            END IF
        END IF
    END IF

    IF mB AND idemouseselect = 3 THEN
        'move hbar scroller (idecx) to appropriate position
        IF mX <= 3 THEN idesx = 1: idecx = idesx
        IF mX >= idewx - 2 THEN idesx = 608: idecx = idesx
        IF mX > 3 AND mX < idewx - 2 THEN
            x = mX
            p! = x - 2 - 2 + .5
            p! = p! / ((idewx - 2) - 4)
            i = p! * (608 - 1) + 1
            idesx = i
            idecx = idesx
        END IF
    END IF

    IF mB AND idemouseselect <= 1 THEN
        IF mX > 1 AND mX < idewx AND mY > 2 AND mY < idewy - 5 THEN 'inside text box
            IF idemouseselect = 1 THEN
                idecx = mX - 1 + idesx - 1
                idecy = mY - 2 + idesy - 1
                IF idecy > iden THEN idecy = iden
            END IF
        END IF
    END IF

    IF mB THEN
        IF mX = 1 OR mX = idewx OR mY <= 2 OR mY >= idewy - 5 THEN 'off text window area
            IF idemouseselect = 1 THEN

                'scroll window
                IF mY >= idewy - 5 THEN idecy = idecy + 1: IF idecy > iden THEN idecy = iden
                IF mY <= 2 THEN idecy = idecy - 1: IF idecy < 1 THEN idecy = 1
                IF mX = 1 THEN idecx = idecx - 1: IF idecx < 1 THEN idecx = 1
                IF mX = idewx THEN idecx = idecx + 1
                idewait
            END IF
        END IF
    END IF







    IF KCONTROL AND UCASE$(K$) = "A" THEN 'select all
        idemselectall:
        ideselect = 1: ideselectx1 = 1: ideselecty1 = 1
        idecy = iden
        a$ = idegetline(idecy)
        idecx = LEN(a$) + 1
        GOTO specialchar
    END IF

    IF K$ = CHR$(0) + CHR$(60) THEN 'F2
        GOTO idesubsjmp
    END IF

    IF KCONTROL AND UCASE$(K$) = "Z" THEN 'undo (CTRL+Z)
        idemundo:
        IF ideundopos THEN
            OPEN tmpdir$ + "undo2.bin" FOR BINARY AS #150
            h$ = SPACE$(12): GET #150, , h$: p1 = CVL(MID$(h$, 1, 4)): p2 = CVL(MID$(h$, 5, 4)): plast = CVL(MID$(h$, 9, 4))

            'does something exist to undo?
            u = 0
            IF p2 >= p1 THEN
                'linear
                IF ideundopos > p1 THEN
                    GET #150, ideundopos - 4, upl
                    u = ideundopos - 4 - upl - 4
                END IF
            ELSE
                'wrapped
                IF ideundopos > p1 THEN
                    GET #150, ideundopos - 4, upl
                    u = ideundopos - 4 - upl - 4
                END IF
                IF ideundopos <= p2 THEN
                    IF ideundopos = 13 THEN
                        u = plast
                    ELSE
                        GET #150, ideundopos - 4, upl
                        u = ideundopos - 4 - upl - 4
                    END IF
                END IF
            END IF

            IF u THEN

                IF ideundopos = ideundobase THEN
                    'if not untitled, then we MUST switch to a special state
                    'warn
                    PCOPY 3, 0
                    what$ = ideyesnobox("Undo", "Undo through previous program content?")
                    PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                    IF what$ = "N" THEN
                        CLOSE #150
                        GOTO skipundo
                    END IF
                    IF ideunsaved = 1 AND ideprogname <> "" THEN
                        PCOPY 3, 0
                        r$ = idesavenow
                        PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                        IF r$ = "C" THEN CLOSE #150: GOTO skipundo
                        IF r$ = "Y" THEN
                            idesave idepath$ + idepathsep$ + ideprogname$
                        END IF
                    END IF
                    ideunsaved = 1
                    ideprogname$ = ""
                    _TITLE "QB64"
                    ideundobase = -1 'release base restriction
                END IF

                ideundopos = u 'set new current state

                'get backup
                SEEK #150, u
                GET #150, , l2& 'should be the same as l&
                GET #150, , idesx: GET #150, , idesy
                GET #150, , idecx: GET #150, , idecy
                GET #150, , ideselect: GET #150, , ideselectx1: GET #150, , ideselecty1
                GET #150, , iden
                GET #150, , idel
                GET #150, , ideli
                'bookmark info [v2]
                GET #150, , IdeBmkN: REDIM IdeBmk(IdeBmkN + 1) AS IdeBmkType
                FOR bi = 1 TO IdeBmkN: GET #150, , IdeBmk(bi).y: GET #150, , IdeBmk(bi).x: NEXT
                GET #150, , x&: idet$ = SPACE$(x&): GET #150, , idet$

                idechangemade = 1: idenoundo = 1

            END IF 'u

            skipundo:
            CLOSE #150
        END IF
        GOTO specialchar

    END IF


    IF KCONTROL AND UCASE$(K$) = "Y" THEN 'redo (CTRL+Y)
        idemredo:
        IF ideundopos THEN
            OPEN tmpdir$ + "undo2.bin" FOR BINARY AS #150
            h$ = SPACE$(12): GET #150, , h$: p1 = CVL(MID$(h$, 1, 4)): p2 = CVL(MID$(h$, 5, 4)): plast = CVL(MID$(h$, 9, 4))

            'does something exist to redo?
            u = 0
            IF p2 >= p1 THEN
                'linear
                IF ideundopos < p2 THEN
                    GET #150, ideundopos, upl
                    u = ideundopos + 4 + upl + 4
                END IF
            ELSE
                'wrapped
                IF ideundopos >= p1 THEN
                    IF ideundopos = plast THEN
                        u = 13
                    ELSE
                        GET #150, ideundopos, upl
                        u = ideundopos + 4 + upl + 4
                    END IF
                ELSE
                    IF ideundopos < p2 THEN
                        GET #150, ideundopos, upl
                        u = ideundopos + 4 + upl + 4
                    END IF
                END IF
            END IF

            IF u THEN

                ideundopos = u 'set new current state

                'get backup
                SEEK #150, u
                GET #150, , l2& 'should be the same as l&
                GET #150, , idesx: GET #150, , idesy
                GET #150, , idecx: GET #150, , idecy
                GET #150, , ideselect: GET #150, , ideselectx1: GET #150, , ideselecty1
                GET #150, , iden
                GET #150, , idel
                GET #150, , ideli
                'bookmark info [v2]
                GET #150, , IdeBmkN: REDIM IdeBmk(IdeBmkN + 1) AS IdeBmkType
                FOR bi = 1 TO IdeBmkN: GET #150, , IdeBmk(bi).y: GET #150, , IdeBmk(bi).x: NEXT
                GET #150, , x&: idet$ = SPACE$(x&): GET #150, , idet$

                idechangemade = 1: idenoundo = 1

            END IF 'u

            CLOSE #150
        END IF
        GOTO specialchar
    END IF


    IF ((KSHIFT AND KB = KEY_DELETE) OR (KCONTROL AND UCASE$(K$) = "X")) AND ideselect = 1 THEN 'cut to clipboard
        idemcut:
        idechangemade = 1
        GOTO copy2clip
    END IF

    IF (KB = KEY_DELETE OR KB = 8) AND ideselect = 1 THEN 'delete selection
        IF ideselecty1 <> idecy OR ideselectx1 <> idecx THEN
            idechangemade = 1
            GOSUB delselect
            GOTO specialchar
        ELSE
            ideselect = 0
        END IF
    END IF


    IF (KSHIFT AND KB = KEY_INSERT) OR (KCONTROL AND UCASE$(K$) = "V") THEN 'paste from clipboard
        idempaste:

        clip$ = _CLIPBOARD$ 'read clipboard

        IF LEN(clip$) THEN
            IF ideselect THEN GOSUB delselect
            IF INSTR(clip$, CHR$(13)) OR INSTR(clip$, CHR$(10)) THEN

                'full lines paste

                idelayoutallow = 2
                a$ = clip$
                x3 = 1 'scan from position
                i = 0 'lines counter

                fullpastenextline:

                x = INSTR(x3, a$, CHR$(13))
                x2 = INSTR(x3, a$, CHR$(10))
                IF x = 0 THEN x = x2
                IF x2 = 0 THEN x2 = x
                IF x2 < x THEN SWAP x, x2
                IF x2 > x + 1 THEN x2 = x 'if seperated by more than one character, they are seperate line terminators
                'x to x2 is the range of the next line terminator (1 or 2 characters)

                IF x THEN
                    ideinsline idecy + i, converttabs$(MID$(a$, x3, x - x3))
                    i = i + 1
                    x3 = x2 + 1
                ELSE
                    ideinsline idecy + i, converttabs$(MID$(a$, x3, LEN(a$) - x3 + 1))
                    i = i + 1
                    x3 = LEN(a$) + 1
                END IF

                IF x3 <= LEN(a$) GOTO fullpastenextline

            ELSE

                'insert single line paste
                a$ = idegetline(idecy)
                IF LEN(a$) < idecx - 1 THEN a$ = a$ + SPACE$(idecx - 1 - LEN(a$))
                a$ = LEFT$(a$, idecx - 1) + clip$ + RIGHT$(a$, LEN(a$) - idecx + 1)
                idesetline idecy, converttabs$(a$)

            END IF

            idechangemade = 1
        END IF
        GOTO specialchar
    END IF

    IF ((KCTRL AND KB = KEY_INSERT) OR (KCONTROL AND UCASE$(K$) = "C")) AND ideselect = 1 THEN 'copy to clipboard
        copy2clip:
        clip$ = ""
        sy1 = ideselecty1
        sy2 = idecy
        IF sy1 > sy2 THEN SWAP sy1, sy2
        sx1 = ideselectx1
        sx2 = idecx
        IF sx1 > sx2 THEN SWAP sx1, sx2
        FOR y = sy1 TO sy2
            IF y <= iden THEN
                a$ = idegetline(y)
                IF sy1 = sy2 THEN 'single line select
                    FOR x = sx1 TO sx2 - 1
                        IF x <= LEN(a$) THEN clip$ = clip$ + MID$(a$, x, 1) ELSE clip$ = clip$ + " "
                    NEXT
                ELSE 'multiline select
                    IF idecx = 1 AND y = sy2 AND idecy > sy1 THEN clip$ = clip$ + CHR$(13) + CHR$(10): GOTO nofinalcopy
                    IF clip$ = "" THEN clip$ = a$ ELSE clip$ = clip$ + CHR$(13) + CHR$(10) + a$
                    nofinalcopy:
                END IF
            END IF
        NEXT
        IF clip$ <> "" THEN _CLIPBOARD$ = clip$
        IF (K$ = CHR$(0) + "S") OR (KSHIFT AND KB = KEY_DELETE) OR (KCONTROL AND UCASE$(K$) = "X") THEN GOSUB delselect
        GOTO specialchar
    END IF

    IF KB = KEY_INSERT THEN 'toggle INSERT mode
        ideinsert = ideinsert + 1
        IF ideinsert = 2 THEN ideinsert = 0
    END IF

    IF KB = KEY_UP THEN
        IF KCONTROL THEN 'scroll the window, instead of moving the cursor
            idesy = idesy - 1
            if idesy < 1 then idesy = 1
            if idecy > idesy + (idewy - 9) then idecy = idesy + (idewy - 9)
        ELSE
            GOSUB selectcheck
            idecy = idecy - 1
            IF idecy < 1 THEN idecy = 1
            GOTO specialchar
        END IF
    END IF

    IF KB = KEY_DOWN THEN
        IF KCONTROL THEN 'scroll the window, instead of moving the cursor
            idesy = idesy + 1
            if idesy > iden then idesy = iden
            if idecy < idesy then idecy = idesy
        ELSE
            GOSUB selectcheck
            idecy = idecy + 1
            IF idecy > iden THEN idecy = iden
            GOTO specialchar
        END IF
    END IF

    IF mWHEEL THEN
        GOSUB selectcheck
        'move relative to top/bottom
        IF mWHEEL < 0 THEN idecy = idesy
        IF mWHEEL > 0 THEN idecy = idesy + (idewy - 9)
        idecy = idecy + mWHEEL * 3
        IF idecy < 1 THEN idecy = 1
        IF idecy > iden THEN idecy = iden
        GOTO specialchar
    END IF

    IF KB = KEY_LEFT THEN
        GOSUB selectcheck

        IF KCONTROL THEN 'move forward to next beginning alphanumeric

            a$ = idegetline(idecy)
            IF idecx > LEN(a$) THEN idecx = LEN(a$) + 1

            skipping = 1
            DO
                'move
                idecx = idecx - 1
                'latch onto prev character
                IF idecx < 1 THEN
                    DO
                        IF idecy = 1 THEN idecx = 1: GOTO specialchar
                        idecy = idecy - 1
                        a$ = idegetline(idecy)
                        idecx = LEN(a$)
                    LOOP UNTIL LEN(a$)
                END IF
                'check character
                IF alphanumeric(ASC(a$, idecx)) THEN
                    IF idecx = 1 THEN GOTO specialchar
                    x = idecx: y = idecy
                    skipping = 0
                ELSE
                    IF skipping = 0 THEN idecx = x: idecy = y: GOTO specialchar
                END IF
            LOOP

        ELSE

            idecx = idecx - 1
            IF idecx < 1 THEN idecx = 1

        END IF

        GOTO specialchar
    END IF

    IF KB = KEY_RIGHT THEN
        GOSUB selectcheck

        IF KCONTROL THEN 'move forward to next beginning alphanumeric

            a$ = idegetline(idecy)
            skipping = 0
            first = 1
            DO
                'move
                IF first = 0 THEN idecx = idecx + 1
                'latch onto next character
                IF idecx > LEN(a$) THEN
                    DO
                        IF idecy = iden THEN GOTO specialchar
                        idecy = idecy + 1: idecx = 1
                        a$ = idegetline(idecy)
                    LOOP UNTIL LEN(a$)
                    skipping = 0
                    first = 0
                END IF
                'check character
                IF alphanumeric(ASC(a$, idecx)) THEN
                    IF first THEN
                        skipping = 1
                    ELSE
                        IF skipping = 0 THEN GOTO specialchar
                    END IF
                ELSE
                    skipping = 0
                END IF
                first = 0
            LOOP

        ELSE

            idecx = idecx + 1

        END IF

        GOTO specialchar
    END IF

    IF KCONTROL AND KB = KEY_HOME THEN
        GOSUB selectcheck
        idecx = 1
        idecy = 1
        GOTO specialchar
    END IF

    IF KCONTROL AND KB = KEY_END THEN
        GOSUB selectcheck
        idecy = iden
        a$ = idegetline(idecy)
        idecx = LEN(a$) + 1
        GOTO specialchar
    END IF

    IF KB = KEY_HOME THEN
        GOSUB selectcheck
        IF idecx <> 1 THEN
            idecx = 1
        ELSE
            a$ = idegetline(idecy)
            idecx = 1
            FOR x = 1 TO LEN(a$)
                IF ASC(a$, x) <> 32 THEN idecx = x: EXIT FOR
            NEXT
        END IF
        GOTO specialchar
    END IF

    IF KB = KEY_END THEN
        GOSUB selectcheck
        a$ = idegetline(idecy)
        idecx = LEN(a$) + 1
        GOTO specialchar
    END IF

    IF KB = KEY_PAGEUP THEN
        GOSUB selectcheck
        idecy = idecy - (idewy - 9)
        IF idecy < 1 THEN idecy = 1
        GOTO specialchar
    END IF

    IF KB = KEY_PAGEDOWN THEN
        GOSUB selectcheck
        idecy = idecy + (idewy - 9)
        IF idecy > iden THEN idecy = iden
        GOTO specialchar
    END IF

    GOTO skipgosubs

    selectcheck:
    IF IdeSystem = 1 THEN
        IF KSHIFT AND ideselect = 0 THEN ideselect = 1: ideselectx1 = idecx: ideselecty1 = idecy
        IF KSHIFT = 0 THEN ideselect = 0
    ELSEIF IdeSystem = 2 THEN
        IF KSHIFT AND idesystem2.issel = 0 THEN idesystem2.issel = -1: idesystem2.sx1 = idesystem2.v1
        IF KSHIFT = 0 THEN idesystem2.issel = 0
    END IF
    RETURN

    delselect:
    sy1 = ideselecty1
    sy2 = idecy
    IF sy1 > sy2 THEN SWAP sy1, sy2
    sx1 = ideselectx1
    sx2 = idecx
    IF sx1 > sx2 THEN SWAP sx1, sx2
    nolastlinedel = 0
    IF sy1 <> sy2 AND idecx = 1 AND idecy > sy1 THEN sy2 = sy2 - 1: nolastlinedel = 1 'ignore last line of multi-line select?








    FOR y = sy2 TO sy1 STEP -1
        IF sy1 = sy2 AND nolastlinedel = 0 THEN 'single line select
            a$ = idegetline(y)
            a2$ = ""
            IF sx1 <= LEN(a$) THEN a2$ = LEFT$(a$, sx1 - 1) ELSE a2$ = a$
            IF sx2 <= LEN(a$) THEN a2$ = a2$ + RIGHT$(a$, LEN(a$) - sx2 + 1)
            idesetline y, a2$
        ELSE 'multiline select


            IF iden = 1 AND y = 1 THEN idesetline y, "" ELSE idedelline y


        END IF
    NEXT


    idecx = sx1: IF sy1 <> sy2 OR nolastlinedel = 1 THEN idecx = 1
    idecy = sy1
    ideselect = 0
    RETURN

    skipgosubs:

    IF K$ = CHR$(13) THEN
        ideselect = 0
        idechangemade = 1

        a$ = idegetline(idecy)
        IF idecx > LEN(a$) THEN
            ideinsline idecy + 1, ""
        ELSE
            idesetline idecy, LEFT$(a$, idecx - 1)
            ideinsline idecy + 1, RIGHT$(a$, LEN(a$) - idecx + 1)
        END IF

        IF idecx = 1 THEN
            FOR b = 1 TO IdeBmkN
                IF IdeBmk(b).y = idecy THEN IdeBmk(b).y = IdeBmk(b).y + 1
            NEXT
        END IF

        idecy = idecy + 1
        idecx = 1
        GOTO specialchar
    END IF

    IF KB = KEY_DELETE THEN
        idechangemade = 1
        a$ = idegetline(idecy)
        IF idecx <= LEN(a$) THEN
            a$ = LEFT$(a$, idecx - 1) + RIGHT$(a$, LEN(a$) - idecx)
            idesetline idecy, a$
        ELSE
            a$ = a$ + SPACE$(idecx - LEN(a$) - 1)
            a$ = a$ + idegetline(idecy + 1)
            idesetline idecy, a$
            idedelline idecy + 1
        END IF
        GOTO specialchar
    END IF

    IF K$ = CHR$(8) THEN
        ideselect = 0
        idechangemade = 1

        'undocombos
        IF ideundocombochr <> 8 THEN
            ideundocombo = 2
        ELSE
            ideundocombo = ideundocombo + 1
            IF ideundocombo = 2 THEN idemergeundo = 1
        END IF
        ideundocombochr = 8

        a$ = idegetline(idecy)
        IF idecx = 1 THEN
            IF idecy > 1 THEN
                a2$ = idegetline(idecy - 1)
                idesetline idecy - 1, a2$ + a$
                idedelline idecy
                idecx = LEN(a2$) + 1
                idecy = idecy - 1
            END IF
            GOTO specialchar
        END IF
        IF idecx > LEN(a$) + 1 THEN
            idecx = LEN(a$) + 1
        ELSE
            a$ = LEFT$(a$, idecx - 2) + RIGHT$(a$, LEN(a$) - idecx + 1)
            idesetline idecy, a$
            idecx = idecx - 1
        END IF
        GOTO specialchar
    END IF









    'patch#1
    IF LEN(K$) <> 1 THEN GOTO specialchar
    IF K$ = CHR$(9) THEN GOTO ideforceinput
    IF block_chr(ASC(K$)) THEN GOTO specialchar
    ideforceinput:

    IF K$ = CHR$(9) OR (K$ = CHR$(25) AND INSTR(_OS$, "MAC") > 0) THEN
        IF ideselect AND ideautoindent = 0 THEN
            'Block indentation code copied/adapted from block comment/uncomment:
            IF KSHIFT OR K$ = CHR$(25) THEN
                IdeBlockDecreaseIndent:
                BlockIndentLevel = 4
                IF ideautoindentsize <> 0 THEN BlockIndentLevel = ideautoindentsize
                y1 = idecy
                y2 = ideselecty1

                IF y1 = y2 THEN 'single line selected
                    a$ = idegetline(idecy)
                    a2$ = ""
                    sx1 = ideselectx1: sx2 = idecx
                    IF sx2 < sx1 THEN SWAP sx1, sx2
                    FOR x = sx1 TO sx2 - 1
                        IF x <= LEN(a$) THEN a2$ = a2$ + MID$(a$, x, 1) ELSE a2$ = a2$ + " "
                    NEXT
                    IF a2$ = "" THEN
                        GOTO SkipBlockIndent
                    END IF
                END IF

                IF y1 > y2 THEN SWAP y1, y2
                IF idecy > ideselecty1 AND idecx = 1 THEN y2 = y2 - 1
                'calculate lhs
                lhs = 10000000
                FOR y = y1 TO y2
                    a$ = idegetline(y)
                    IF LEN(a$) THEN
                        ta$ = LTRIM$(a$)
                        t = LEN(a$) - LEN(ta$)
                        IF t < lhs THEN lhs = t
                    END IF
                NEXT
                'edit lines
                'Unless any of the block lines already starts at the beginning of the line
                IF lhs > 0 THEN
                    IF lhs < BlockIndentLevel then BlockIndentLevel = lhs
                    FOR y = y1 TO y2
                        a$ = idegetline(y)
                        IF LEN(a$) THEN
                            a$ = right$(a$, LEN(a$) - BlockIndentLevel)
                            idesetline y, a$
                            idechangemade = 1
                        END IF
                    NEXT
                END IF
                if (y1 = y2) AND idechangemade then
                    ideselectx1 = ideselectx1 - BlockIndentLevel
                    idecx = idecx - BlockIndentLevel
                    if idecx < 1 then idecx = 1: ideselectx1 = idecx
                end if
                PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                GOTO ideloop
            ELSE
                IdeBlockIncreaseIndent:
                BlockIndentLevel = 4
                IF ideautoindentsize <> 0 THEN BlockIndentLevel = ideautoindentsize
                y1 = idecy
                y2 = ideselecty1

                IF y1 = y2 THEN 'single line selected
                    a$ = idegetline(idecy)
                    a2$ = ""
                    sx1 = ideselectx1: sx2 = idecx
                    IF sx2 < sx1 THEN SWAP sx1, sx2
                    FOR x = sx1 TO sx2 - 1
                        IF x <= LEN(a$) THEN a2$ = a2$ + MID$(a$, x, 1) ELSE a2$ = a2$ + " "
                    NEXT
                    IF a2$ = "" THEN
                        GOTO SkipBlockIndent
                    END IF
                END IF

                IF y1 > y2 THEN SWAP y1, y2
                IF idecy > ideselecty1 AND idecx = 1 THEN y2 = y2 - 1
                'calculate lhs
                lhs = 10000000
                FOR y = y1 TO y2
                    a$ = idegetline(y)
                    IF LEN(a$) THEN
                        ta$ = LTRIM$(a$)
                        t = LEN(a$) - LEN(ta$)
                        IF t < lhs THEN lhs = t
                    END IF
                NEXT
                'edit lines
                FOR y = y1 TO y2
                    a$ = idegetline(y)
                    IF LEN(a$) THEN
                        a$ = LEFT$(a$, lhs) + SPACE$(BlockIndentLevel) + RIGHT$(a$, LEN(a$) - lhs)
                        idesetline y, a$
                        idechangemade = 1
                    END IF
                NEXT
                if (y1 = y2) AND idechangemade then
                    ideselectx1 = ideselectx1 + BlockIndentLevel
                    idecx = idecx + BlockIndentLevel
                end if
                PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                GOTO ideloop
            END IF
        ELSE
            SkipBlockIndent:
            IF KSHIFT = 0 THEN
                x = 4
                IF ideautoindent <> 0 AND ideautoindentsize <> 0 THEN x = ideautoindentsize
                K$ = SPACE$(x - ((idecx - 1) MOD x))
            ELSE
                K$ = ""
            END IF
        END IF
    END IF

    IF K$ = CHR$(27) AND NOT AltSpecial THEN GOTO specialchar 'Steve edit 07-04-2014 to stop ESC from printing chr$(27) in the IDE

    'standard character
    IF ideselect THEN GOSUB delselect
    idechangemade = 1

    'undocombos
    IF LEN(K$) = 1 THEN
        asck = ASC(K$)
        IF alphanumeric(asck) OR ideundocombochr = asck THEN
            IF ideundocombochr = 8 THEN ideundocombo = 0
            IF ideundocombo = 0 THEN
                ideundocombo = 2
            ELSE
                ideundocombo = ideundocombo + 1
                IF ideundocombo = 2 THEN idemergeundo = 1
            END IF
        END IF
        ideundocombochr = asck
    END IF

    a$ = idegetline(idecy)
    IF LEN(a$) < idecx - 1 THEN a$ = a$ + SPACE$(idecx - 1 - LEN(a$))

    IF ideinsert THEN
        a2$ = RIGHT$(a$, LEN(a$) - idecx + 1)
        IF LEN(a2$) THEN a2$ = RIGHT$(a$, LEN(a$) - idecx)
        a$ = LEFT$(a$, idecx - 1) + K$ + a2$
    ELSE
        a$ = LEFT$(a$, idecx - 1) + K$ + RIGHT$(a$, LEN(a$) - idecx + 1)
    END IF

    idesetline idecy, a$
    idecx = idecx + LEN(K$)
    specialchar:

    IF AltSpecial THEN
        AltSpecial = 0
        ideentermenu = 0
        KALT = 0
        LOCATE 1, 1: COLOR 0, 7: PRINT menubar$
    END IF
LOOP

'--------------------------------------------------------------------------------

startmenu:
m = 1
startmenu2:
altheld = 1
if IdeSystem = 2 then IdeSystem = 1: GOSUB UpdateSearchBar

DO

    LOCATE 1, 3
    FOR i = 1 TO menus
        IF m = i THEN COLOR 15, 0 ELSE COLOR 15, 7
        PRINT " " + LEFT$(menu$(i, 0), 1);
        IF m = i THEN COLOR 7, 0 ELSE COLOR 0, 7
        PRINT RIGHT$(menu$(i, 0), LEN(menu$(i, 0)) - 1) + " ";
        IF i = menus - 1 THEN LOCATE 1, idewx - LEN(menu$(menus, 0)) - 2
    NEXT

    PCOPY 3, 0
    DO

        lastaltheld = altheld

        GetInput
            if oldmx <> mX or oldmy <> mY then
                IF mY = 1 and idecontextualmenu = 0 THEN 'Check if we're hovering on menu bar
                    lastm = m
                    FOR i = 1 to menus
                        x = CVI(MID$(MenuLocations, i * 2 - 1, 2))
                        x2 = CVI(MID$(MenuLocations, i * 2 - 1, 2)) + len(menu$(i, 0))
                        IF mX >= x and mX < x2 THEN
                            m = i
                            if m <> lastm then EXIT DO 'Update the menu bar to reflect the current mouse hover
                        END IF
                    NEXT
                END IF
                oldmx = mX: oldmy = mY
            end if
        IF iCHANGED = 0 THEN _LIMIT 100

        IF KALT THEN altheld = 1 ELSE altheld = 0

        IF altheld <> 0 AND lastaltheld = 0 THEN
            DO: _LIMIT 1000: GetInput: LOOP UNTIL KALT = 0
            KB = KEY_ESC
        END IF

        IF mCLICK THEN
            IF mY = 1 THEN
                FOR i = 1 to menus
                    x = CVI(MID$(MenuLocations, i * 2 - 1, 2))
                    x2 = CVI(MID$(MenuLocations, i * 2 - 1, 2)) + len(menu$(i, 0))
                    IF mX >= x and mX < x2 THEN
                        m = i
                        LOCATE 1, 1: COLOR 0, 7: PRINT menubar$;
                        PCOPY 3, 0
                        GOTO showmenu
                    END IF
                NEXT
            END IF 'my=1
            KB = KEY_ESC 'exit menu selection
        END IF

    LOOP UNTIL KB

    K$ = UCASE$(K$)
    FOR i = 1 TO menus
        a$ = UCASE$(LEFT$(menu$(i, 0), 1))
        IF K$ = a$ THEN
            m = i
            LOCATE 1, 1: COLOR 0, 7: PRINT menubar$;
            PCOPY 3, 0
            GOTO showmenu
        END IF
    NEXT

    IF KB = KEY_LEFT THEN m = m - 1
    IF KB = KEY_RIGHT THEN m = m + 1
    IF KB = KEY_ESC THEN
        LOCATE 1, 1: COLOR 0, 7: PRINT menubar$;
        GOTO ideloop
    END IF
    IF m < 1 THEN m = menus
    IF m > menus and idecontextualmenu = 0 THEN m = 1
    IF KB = KEY_UP OR KB = KEY_DOWN OR KB = KEY_ENTER THEN
        LOCATE 1, 1: COLOR 0, 7: PRINT menubar$;
        PCOPY 3, 0
        GOTO showmenu
    END IF

    'possible ALT+??? code?
    IF KB > 0 AND KB <= 255 THEN
        IF KALT = 0 THEN
            iCHECKLATER = 1
            LOCATE 1, 1: COLOR 0, 7: PRINT menubar$;
            GOTO ideloop
        END IF
    END IF

LOOP

'--------------------------------------------------------------------------------

showmenu:
altheld = 1
if IdeSystem = 2 then IdeSystem = 1: GOSUB UpdateSearchBar
PCOPY 0, 2
SCREEN , , 1, 0
r = 1
IF idecontextualmenu = 1 THEN idectxmenuX = mX: idectxmenuY = mY: m = idecontextualmenuID
IdeMakeEditMenu
oldmy = mY: oldmx = mX
DO
    PCOPY 2, 1

    if idecontextualmenu = 0 then
        'find pos of menu m
        x = 4: FOR i = 1 TO m - 1: x = x + LEN(menu$(i, 0)) + 2
            IF i = menus - 1 THEN x = idewx - LEN(menu$(menus, 0)) - 1
        NEXT: xx = x
        LOCATE 1, xx - 1: COLOR 7, 0: PRINT " " + menu$(m, 0) + " "
    END IF
    COLOR 0, 7
    'calculate menu width
    w = 0
    FOR i = 1 TO menusize(m)
        m$ = menu$(m, i)
        l = LEN(m$)
        IF INSTR(m$, "#") THEN l = l - 1
        IF LEFT$(m$, 1) = "~" THEN l = l - 1
        IF INSTR(m$, "  ") THEN l = l + 2 'min 4 spacing
        IF l > w THEN w = l
    NEXT
    yy = 2
    IF idecontextualmenu = 1 THEN
        actual.idewy = idewy
        if idesubwindow <> 0 then
            actual.idewy = idewy + idesubwindow
        end if
        xx = idectxmenuX
        if xx < 3 then xx = 3
        yy = idectxmenuY
        if yy + menusize(m) + 2 > actual.idewy then yy = actual.idewy - 2 - menusize(m)
    END IF
    IF xx > idewx - w - 3 THEN xx = idewx - w - 3

    ideboxshadow xx - 2, yy, w + 4, menusize(m) + 2

    'draw menu items
    FOR i = 1 TO menusize(m)
        m$ = menu$(m, i)
        IF m$ = "-" THEN
            COLOR 0, 7: LOCATE i + yy, xx - 2: PRINT chr$(195) + STRING$(w + 2, chr$(196)) + chr$(180);
        ELSEIF left$(m$, 1) = "~" THEN
            m$ = right$(m$, len(m$) - 1) 'Remove the tilde before printing
            IF r = i THEN LOCATE i + yy, xx - 1: COLOR 7, 0: PRINT SPACE$(w + 2);
            LOCATE i + yy, xx
            h = -1: x = INSTR(m$, "#"): IF x THEN h = x: m$ = LEFT$(m$, x - 1) + RIGHT$(m$, LEN(m$) - x)
            x = INSTR(m$, "  "): IF x THEN m1$ = LEFT$(m$, x - 1): m2$ = RIGHT$(m$, LEN(m$) - x - 1): m$ = m1$ + SPACE$(w - LEN(m1$) - LEN(m2$)) + m2$
            FOR x = 1 TO LEN(m$)
                IF r = i THEN COLOR 8, 0 ELSE COLOR 8, 7
                PRINT MID$(m$, x, 1);
            NEXT
        ELSE
            IF r = i THEN LOCATE i + yy, xx - 1: COLOR 7, 0: PRINT SPACE$(w + 2);
            LOCATE i + yy, xx
            h = -1: x = INSTR(m$, "#"): IF x THEN h = x: m$ = LEFT$(m$, x - 1) + RIGHT$(m$, LEN(m$) - x)
            x = INSTR(m$, "  "): IF x THEN m1$ = LEFT$(m$, x - 1): m2$ = RIGHT$(m$, LEN(m$) - x - 1): m$ = m1$ + SPACE$(w - LEN(m1$) - LEN(m2$)) + m2$
            FOR x = 1 TO LEN(m$)
                IF x = h THEN
                    IF r = i THEN COLOR 15, 0 ELSE COLOR 15, 7
                ELSE
                    IF r = i THEN COLOR 7, 0 ELSE COLOR 0, 7
                END IF
                PRINT MID$(m$, x, 1);
            NEXT



        END IF

    NEXT

    PCOPY 1, 0

    change = 0
    DO
        mousedown = 0: mouseup = 0
        GetInput
        lastaltheld = altheld: IF KALT THEN altheld = 1 ELSE altheld = 0
        IF iCHANGED THEN
            IF KB THEN change = 1
            IF mCLICK THEN change = 1: mousedown = 1
            IF mCLICK2 THEN change = 1
            IF mRELEASE THEN change = 1: mouseup = 1
            IF mWHEEL THEN change = 1
            IF mX THEN change = 1
            IF mY THEN change = 1
        END IF
        IF mB THEN change = 1
        'revert to previous menuwhen alt pressed again
        IF altheld <> 0 AND lastaltheld = 0 THEN
            DO: _LIMIT 1000: GetInput: LOOP UNTIL KALT = 0 'wait till alt is released
            PCOPY 3, 0: SCREEN , , 3, 0
            GOTO startmenu2
        END IF
        _LIMIT 100
    LOOP UNTIL change

    s = 0

    IF mWHEEL THEN
        PCOPY 3, 0: SCREEN , , 3, 0
        GOTO ideloop
    END IF

    IF mCLICK2 AND idecontextualmenu THEN 'A new right click in the text area repositions the contextual menu
        IF mX > 1 AND mX < idewx AND mY > 2 AND mY < (idewy - 5) THEN
            PCOPY 3, 0: SCREEN , , 3, 0
            GOTO invokecontextualmenu
        ELSE
            PCOPY 3, 0: SCREEN , , 3, 0
            GOTO ideloop
        END IF
    END IF

    'mouse selection
    IF mouseup THEN
        IF mX >= xx - 2 AND mX < xx - 2 + w + 4 THEN
            IF mY > yy AND mY <= menusize(m) + yy THEN
                y = mY - yy
                IF menu$(m, y) <> "-" THEN
                    s = r
                END IF
            END IF
        END IF

        IF mX < xx - 2 OR mX >= xx - 2 + w + 4 OR mY > yy + menusize(m) + 1 or (mY < yy and idecontextualmenu) THEN
            PCOPY 3, 0: SCREEN , , 3, 0
            GOTO ideloop
        END IF
    END IF
    IF not mouseup and not mousedown THEN 'Check if we're hovering on menu options
      if oldmy <> mY then
        IF mX >= xx - 2 AND mX < xx - 2 + w + 4 THEN
            IF mY > yy AND mY <= menusize(m) + yy THEN
                y = mY - yy
                IF menu$(m, y) <> "-" THEN
                    r = y
                END IF
            END IF
        ELSE
            IF mY = 1 THEN GOTO checkmenubarhover
        END IF
        oldmy = mY
      end if
      if oldmx <> mX then
        checkmenubarhover:
        IF mY = 1 and idecontextualmenu = 0 THEN 'Check if we're hovering on menu bar
            lastm = m
            FOR i = 1 to menus
                x = CVI(MID$(MenuLocations, i * 2 - 1, 2))
                x2 = CVI(MID$(MenuLocations, i * 2 - 1, 2)) + len(menu$(i, 0))
                IF mX >= x and mX < x2 THEN
                    m = i
                    r = 1
                    EXIT FOR
                END IF
            NEXT
        END IF
        oldmx = mX
      end if
    END IF

    IF mB THEN

        'top row
        IF mY = 1 THEN
            idecontextualmenu = 0
            lastm = m
            x = 3
            FOR i = 1 TO menus
                x2 = LEN(menu$(i, 0)) + 2
                IF mX >= x AND mX < x + x2 THEN
                    m = i
                    r = 1
                    IF lastm = m AND mousedown = 1 THEN PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: GOTO ideloop
                    EXIT FOR
                END IF
                x = x + x2
                IF i = menus - 1 THEN x = idewx - LEN(menu$(menus, 0)) - 2
            NEXT
        END IF

        'uses pre-calc xx & w
        IF mX >= xx - 2 AND mX < xx - 2 + w + 4 THEN
            IF mY > yy AND mY <= menusize(m) + yy THEN
                y = mY - yy
                IF menu$(m, y) <> "-" THEN r = y
            END IF
        END IF

    END IF 'mb

    IF KB = KEY_LEFT AND idecontextualmenu = 0 THEN m = m - 1: r = 1
    IF KB = KEY_RIGHT AND idecontextualmenu = 0 THEN m = m + 1: r = 1
    IF m < 1 THEN m = menus
    IF m > menus AND idecontextualmenu = 0 THEN m = 1
    IF KB = KEY_ESC THEN
        PCOPY 3, 0: SCREEN , , 3, 0
        GOTO ideloop
    END IF
    IF KB = KEY_DOWN THEN
        r = r + 1
        IF menu$(m, r) = "-" THEN r = r + 1
        IF r > menusize(m) THEN r = 1
    END IF

    IF KB = KEY_UP THEN
        r = r - 1
        IF menu$(m, r) = "-" THEN r = r - 1
        IF r < 1 THEN r = menusize(m)
    END IF

    'select?

    'with enter
    IF KB = KEY_ENTER THEN
        s = r
    END IF

    'with hotkey
    K$ = UCASE$(K$)
    FOR r2 = 1 TO menusize(m)
        x = INSTR(menu$(m, r2), "#")
        IF x THEN
            a$ = UCASE$(MID$(menu$(m, r2), x + 1, 1))
            IF K$ = a$ THEN s = r2: EXIT FOR
        END IF
    NEXT

    IF s THEN

        IF KALT THEN idehl = 1 ELSE idehl = 0 'set idehl, a shared variable used by various dialogue boxes

        IF menu$(m, s) = "Comment (add ')" THEN
            y1 = idecy: y2 = y1
            IF ideselect = 1 THEN
                y1 = ideselecty1
                IF idecy > ideselecty1 AND idecx = 1 THEN y2 = y2 - 1
                IF y1 > y2 THEN SWAP y1, y2
            END IF
            'calculate lhs
            lhs = 10000000
            FOR y = y1 TO y2
                a$ = idegetline(y)
                IF LEN(a$) THEN
                    ta$ = LTRIM$(a$)
                    t = LEN(a$) - LEN(ta$)
                    IF t < lhs THEN lhs = t
                END IF
            NEXT
            'edit lines
            FOR y = y1 TO y2
                a$ = idegetline(y)
                IF LEN(a$) THEN
                    a$ = LEFT$(a$, lhs) + "'" + RIGHT$(a$, LEN(a$) - lhs)
                    idesetline y, a$
                    idechangemade = 1
                END IF
            NEXT
            PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
            GOTO ideloop
        END IF

        IF menu$(m, s) = "Uncomment (remove ')" THEN
            PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
            y1 = idecy: y2 = y1
            IF ideselect = 1 THEN
                y1 = ideselecty1
                IF idecy > ideselecty1 AND idecx = 1 THEN y2 = y2 - 1
                IF y1 > y2 THEN SWAP y1, y2
            END IF
            'edit lines
            FOR y = y1 TO y2
                a$ = idegetline(y)
                IF LEN(a$) THEN
                    a2$ = LTRIM$(a$)
                    IF LEN(a2$) THEN
                        IF ASC(a2$, 1) = 39 THEN
                            a$ = SPACE$(LEN(a$) - LEN(a2$)) + RIGHT$(a2$, LEN(a2$) - 1)
                            idesetline y, a$
                            idechangemade = 1
                        END IF
                    END IF
                END IF
            NEXT
            PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
            GOTO ideloop
        END IF

        IF menu$(m, s) = "Increase indent  TAB" THEN
            IF ideselect AND ideautoindent = 0 THEN GOTO IdeBlockIncreaseIndent
        END IF

        IF LEFT$(menu$(m, s), 15) = "Decrease indent" THEN
            IF ideselect AND ideautoindent = 0 THEN GOTO IdeBlockDecreaseIndent
        END IF

        IF LEFT$(menu$(m, s), 16) = "~Decrease indent" OR menu$(m, s) = "~Increase indent  TAB" THEN
            IF ideautoindent <> 0 THEN
                ideerrormessage "Not available when auto indent is active (Options/Code Layout)."
                PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                GOTO ideloop
            ELSE
                PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                GOTO ideloop
            END IF
        END IF

        IF menu$(m, s) = "#Language..." THEN
            PCOPY 2, 0
            retval = idelanguagebox
            PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
            GOTO ideloop
        END IF

        IF menu$(m, s) = "#Google Android..." THEN
            PCOPY 2, 0
            retval = ideandroidbox
            'retval is ignored
            PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
            GOTO ideloop
        END IF

        IF menu$(m, s) = "#Display..." THEN
            PCOPY 2, 0
            IF idehelp = 0 THEN
                retval = idedisplaybox
                IF retval = 1 THEN
                    'screen dimensions have changed and everything must be redrawn/reapplied
                    WIDTH idewx, idewy + idesubwindow
                    IF idecustomfont THEN
                        _FONT idecustomfonthandle
                    ELSE
                        _FONT 16
                    END IF
                    skipdisplay = 0
                    GOTO redraweverything
                END IF
            END IF
            PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
            GOTO ideloop
        END IF

        IF menu$(m, s) = "C#olors..." THEN
            PCOPY 2, 0
            retval = idechoosecolorsbox 'retval is ignored
            PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
            GOTO ideloop
        END IF


        IF menu$(m, s) = "#Advanced..." THEN
            PCOPY 2, 0
            retval = ideadvancedbox
            'retval is ignored
            PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
            GOTO ideloop
        END IF


        IF menu$(m, s) = "#Swap Mouse Buttons" THEN
            PCOPY 2, 0
            MouseButtonSwapped = NOT MouseButtonSwapped
            if MouseButtonSwapped then
                WriteConfigSetting "'[MOUSE SETTINGS]", "SwapMouseButton", "TRUE"
            else
                WriteConfigSetting "'[MOUSE SETTINGS]", "SwapMouseButton", "FALSE"
            end if
            PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
            GOTO ideloop
        END IF


        IF menu$(m, s) = "#Code layout..." THEN
            PCOPY 2, 0
            retval = idelayoutbox
            IF retval THEN idechangemade = 1: idelayoutallow = 2 'recompile if options changed
            PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
            GOTO ideloop
        END IF

        IF menu$(m, s) = "Add/Remove #Bookmark  Alt+Left" THEN
            PCOPY 2, 0
            bmkremoved = 0
            bmkremoveb:
            FOR b = 1 TO IdeBmkN
                IF IdeBmk(b).y = idecy THEN
                    FOR b2 = b TO IdeBmkN - 1
                        IdeBmk(b2) = IdeBmk(b2 + 1)
                    NEXT
                    IdeBmkN = IdeBmkN - 1
                    bmkremoved = 1
                    ideunsaved = 1
                    GOTO bmkremoveb
                END IF
            NEXT
            IF bmkremoved = 0 THEN
                IdeBmkN = IdeBmkN + 1
                IF IdeBmkN > UBOUND(IdeBmk) THEN x = UBOUND(IdeBmk) * 2: REDIM _PRESERVE IdeBmk(x) AS IdeBmkType
                IdeBmk(IdeBmkN).y = idecy
                IdeBmk(IdeBmkN).x = idecx
                ideunsaved = 1
            END IF
            SCREEN , , 3, 0: idewait4mous: idewait4alt
            GOTO ideloop
        END IF

        IF menu$(m, s) = "#Next Bookmark  Alt+Down" OR menu$(m, s) = "#Previous Bookmark  Alt+Up" THEN
            PCOPY 2, 0
            IF IdeBmkN = 0 THEN
                idemessagebox "Bookmarks", "No bookmarks exist (Use Alt+Left to create a bookmark)"
                PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                GOTO ideloop
            END IF
            IF IdeBmkN = 1 THEN
                IF idecy = IdeBmk(1).y THEN
                    idemessagebox "Bookmarks", "No other bookmarks exist"
                    PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                    GOTO ideloop
                END IF
            END IF
            l = idecy
            z = 0: IF menu$(m, s) = "#Next Bookmark  Alt+Down" THEN z = 1
            DO
                IF z = 1 THEN l = l + 1 ELSE l = l - 1
                IF l < 1 THEN l = iden
                IF l > iden THEN l = 1
                FOR b = 1 TO IdeBmkN
                    IF IdeBmk(b).y = l THEN EXIT DO
                NEXT
            LOOP
            AddQuickNavHistory idecy
            idecy = l
            idecx = IdeBmk(b).x
            ideselect = 0
            SCREEN , , 3, 0: idewait4mous: idewait4alt
            GOTO ideloop
        END IF






        IF menu$(m, s) = "#Go to line..." THEN
            PCOPY 2, 0
            retval = idegotobox
            'retval is ignored
            PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
            GOTO ideloop
        END IF

        IF menu$(m, s) = "#Backup/Undo..." THEN
            PCOPY 2, 0
            retval = idebackupbox
            'retval is ignored
            PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
            GOTO ideloop
        END IF

        IF menu$(m, s) = "#About..." THEN
            PCOPY 2, 0
            idemessagebox "About", "QB64 Version " + Version$ + " (" + BuildNum$ + ")"
            PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
            GOTO ideloop
        END IF


        IF menu$(m, s) = "ASCII c#hart" THEN
            PCOPY 2, 0
            ideASCIIbox
            PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
            retval = 1
            GOTO redraweverything2
            GOTO ideloop
        END IF

        IF left$(menu$(m, s), 10) = "#Help on '" THEN  'Contextual menu Help
            PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
            GOTO contextualhelp
        END IF

        IF left$(menu$(m, s), 10) = "#Go to SUB" OR left$(menu$(m, s), 15) = "#Go to FUNCTION" THEN  'Contextual menu Goto
            PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
            AddQuickNavHistory idecy
            idecy = CVL(MID$(SubFuncLIST(1), 1, 4))
            idesy = idecy
            idecx = 1
            idesx = 1
            ideselect = 0
            GOTO ideloop
        END IF

        IF left$(menu$(m, s), 12) = "Go to #label" THEN  'Contextual menu Goto label
            PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
            AddQuickNavHistory idecy
            idecy = CVL(MID$(SubFuncLIST(ubound(SubFuncLIST)), 1, 4))
            idesy = idecy
            idecx = 1
            idesx = 1
            ideselect = 0
            GOTO ideloop
        END IF

        IF menu$(m, s) = "#Contents page" THEN
            PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
            lnk$ = "QB64 Help Menu"
            GOTO OpenHelpLnk
        END IF
        IF menu$(m, s) = "Keyword #index" THEN
            PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
            lnk$ = "Keyword Reference - Alphabetical"
            GOTO OpenHelpLnk
        END IF
        IF menu$(m, s) = "#Keywords by usage" THEN
            PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
            lnk$ = "Keyword Reference - By usage"
            GOTO OpenHelpLnk
        END IF

        IF menu$(m, s) = "#View  Shift+F1" THEN

            IF idehelp = 0 THEN
                IF idesubwindow THEN PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt: GOTO ideloop
                idesubwindow = idewy \ 2: idewy = idewy - idesubwindow
                Help_wx1 = 2: Help_wy1 = idewy + 1: Help_wx2 = idewx - 1: Help_wy2 = idewy + idesubwindow - 2: Help_ww = Help_wx2 - Help_wx1 + 1: Help_wh = Help_wy2 - Help_wy1 + 1
                idehelp = 1
                skipdisplay = 0
                IdeSystem = 3
                retval = 1: GOTO redraweverything2
            END IF

            GOTO ideloop
        END IF

        IF menu$(m, s) = "#Update current page" THEN
            PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
            IF idehelp THEN
                Help_IgnoreCache = 1
                a$ = Wiki$(Back$(Help_Back_Pos))
                Help_IgnoreCache = 0
                WikiParse a$
            END IF
            GOTO ideloop
        END IF


        IF menu$(m, s) = "#Math" THEN
            Mathbox
            PCOPY 3, 0: SCREEN , , 3, 0
            GOTO ideloop
        END IF

        IF menu$(m, s) = "Update all #pages" THEN
            PCOPY 2, 0
            q$ = ideyesnobox("Update Help", "Redownload all cached help content? (~10 min)")
            PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
            IF q$ = "Y" THEN

                IF idehelp = 0 THEN
                    old_idesubwindow = idesubwindow: old_idewy = idewy
                    idesubwindow = idewy \ 2: idewy = idewy - idesubwindow
                    Help_wx1 = 2: Help_wy1 = idewy + 1: Help_wx2 = idewx - 1: Help_wy2 = idewy + idesubwindow - 2: Help_ww = Help_wx2 - Help_wx1 + 1: Help_wh = Help_wy2 - Help_wy1 + 1
                    idesubwindow = old_idesubwindow: idewy = old_idewy
                END IF

                SCREEN , , 4, 4
                COLOR 7, 1
                CLS

                PRINT "Generating list of cached content..."

                'Create a list of all files to be recached
                f$ = CHR$(0) + idezfilelist$("internal/help", 1) + CHR$(0)
                IF LEN(f$) = 2 THEN f$ = CHR$(0)

                'Prepend core pages to list
                f$ = CHR$(0) + "Keyword_Reference_-_By_usage.txt" + f$
                f$ = CHR$(0) + "QB64_Help_Menu.txt" + f$
                f$ = CHR$(0) + "QB64_FAQ.txt" + f$
                PRINT "Adding core help pages added to list..."

                'Download and PARSE alphabetical index to build required F1 help links
                PRINT "Regenerating keyword list..."
                Help_Recaching = 1: Help_IgnoreCache = 1
                a$ = Wiki$("Keyword Reference - Alphabetical")
                Help_Recaching = 0: Help_IgnoreCache = 0
                WikiParse a$

                'Add all linked pages to download list (if not already in list)
                fh = FREEFILE
                OPEN "internal\help\links.bin" FOR INPUT AS #fh
                DO UNTIL EOF(fh)
                    LINE INPUT #fh, l$
                    IF LEN(l$) THEN
                        c = INSTR(l$, ","): PageName2$ = RIGHT$(l$, LEN(l$) - c)
                        DO WHILE INSTR(PageName2$, " ")
                            ASC(PageName2$, INSTR(PageName2$, " ")) = 95
                        LOOP
                        DO WHILE INSTR(PageName2$, "&")
                            i = INSTR(PageName2$, "&")
                            PageName2$ = LEFT$(PageName2$, i - 1) + "%26" + RIGHT$(PageName2$, LEN(PageName2$) - i)
                        LOOP
                        DO WHILE INSTR(PageName2$, "/")
                            i = INSTR(PageName2$, "/")
                            PageName2$ = LEFT$(PageName2$, i - 1) + "%2F" + RIGHT$(PageName2$, LEN(PageName2$) - i)
                        LOOP
                        PageName2$ = PageName2$ + ".txt"
                        IF INSTR(f$, CHR$(0) + PageName2$ + CHR$(0)) = 0 THEN
                            f$ = f$ + PageName2$ + CHR$(0)
                        END IF
                    END IF
                LOOP
                CLOSE #fh

                'Redownload all listed files
                IF f$ <> CHR$(0) THEN
                    c = 0 'count files to download
                    FOR x = 2 TO LEN(f$)
                        IF ASC(f$, x) = 0 THEN c = c + 1
                    NEXT
                    c = c - 1
                    PRINT "Updating"; c; "help content files: (Press ESC to cancel)"

                    f$ = RIGHT$(f$, LEN(f$) - 1)
                    z$ = CHR$(0)
                    n = 0
                    DO UNTIL LEN(f$) = 0
                        x2 = INSTR(f$, z$)
                        f2$ = LEFT$(f$, x2 - 1): f$ = RIGHT$(f$, LEN(f$) - x2)

                        IF RIGHT$(f2$, 4) = ".txt" THEN
                            f2$ = LEFT$(f2$, LEN(f2$) - 4)
                            n = n + 1
                            PRINT "(" + str2$(n) + "/" + str2$(c) + ") " + f2$

                            Help_IgnoreCache = 1: Help_Recaching = 1: ignore$ = Wiki(f2$): Help_Recaching = 0: Help_IgnoreCache = 0
                        END IF

                        GetInput
                        DO WHILE iCHANGED
                            IF K$ = CHR$(27) THEN GOTO stoprecache
                            GetInput
                        LOOP
                    LOOP
                END IF
                stoprecache:
                PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
            END IF
            GOTO ideloop
        END IF

        IF LEFT$(menu$(m, s), 8) = "New #SUB" THEN
            PCOPY 2, 0
            idenewsf "SUB"
            ideselect = 0
            PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
            GOTO ideloop
        END IF
        IF LEFT$(menu$(m, s), 13) = "New #FUNCTION" THEN
            PCOPY 2, 0
            idenewsf "FUNCTION"
            ideselect = 0
            PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
            GOTO ideloop
        END IF

        IF menu$(m, s) = "#SUBs...  F2" THEN
            PCOPY 2, 0
            idesubsjmp:
            r$ = idesubs
            IF r$ <> "C" THEN ideselect = 0
            PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
            GOTO ideloop
        END IF

        IF menu$(m, s) = "#Find...  Ctrl+F3" THEN
            PCOPY 2, 0
            idefindjmp:
            r$ = idefind
            PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
            '...
            GOTO ideloop
        END IF

        IF left$(menu$(m, s), 6) = "Find '" THEN  'Contextual menu Find
            idefindtext = idecontextualSearch$
            IdeAddSearched idefindtext
            PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
            GOTO idemf3
        END IF

        IF menu$(m, s) = "#Change..." THEN
            PCOPY 2, 0
            r$ = idechange
            PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
            IF r$ = "C" OR r$ = "" THEN GOTO ideloop
            'assume "V", verify changes
            IdeAddSearched idefindtext

            oldcx = idecx: oldcy = idecy
            found = 0: looped = 0

            s$ = idefindtext$
            IF idefindcasesens = 0 THEN s$ = UCASE$(s$)
            start = idecy: y = start
            startx = idecx: x1 = startx
            first = 1
            idefindnext2:

            l$ = idegetline(y)
            IF idefindcasesens = 0 THEN l$ = UCASE$(l$)

            IF first = 1 THEN
                first = 0
            ELSE
                x1 = 1
                IF idefindbackwards THEN
                    x1 = LEN(l$) - LEN(s$) + 1
                END IF
            END IF
            IF x1 < 0 THEN x1 = 0

            idefindagain2:

            IF idefindbackwards THEN
                x = 0
                FOR xx = x1 TO 1 STEP -1
                    IF ASC(l$, xx) = ASC(s$) THEN 'first char
                        xxo = xx - 1
                        FOR xx2 = xx TO xx + LEN(s$) - 1
                            IF ASC(l$, xx2) <> ASC(s$, xx2 - xxo) THEN EXIT FOR
                        NEXT
                        IF xx2 = xx + LEN(s$) THEN
                            'matched!
                            x = xx
                            EXIT FOR
                        END IF
                    END IF 'first char
                NEXT
                IF y = start AND looped = 1 AND x <= startx THEN x = 0
            ELSE
                x = INSTR(x1, l$, s$)
                IF y = start AND looped = 1 AND x >= startx THEN x = 0
            END IF

            IF x THEN
                IF idefindwholeword THEN
                    whole = 1
                    IF x > 1 THEN
                        c = ASC(UCASE$(MID$(l$, x - 1, 1)))
                        IF c >= 65 AND c <= 90 THEN whole = 0
                        IF c >= 48 AND c <= 57 THEN whole = 0
                    END IF
                    IF x + LEN(s$) <= LEN(l$) THEN
                        c = ASC(UCASE$(MID$(l$, x + LEN(s$), 1)))
                        IF c >= 65 AND c <= 90 THEN whole = 0
                        IF c >= 48 AND c <= 57 THEN whole = 0
                    END IF
                    IF whole = 0 THEN
                        x1 = x + 1: IF idefindbackwards THEN x1 = x - 1
                        x = 0
                        IF x1 > 0 AND x1 <= LEN(l$) THEN GOTO idefindagain2
                    END IF
                END IF
            END IF

            IF x THEN
                ideselect = 1
                idecx = x: idecy = y
                ideselectx1 = x + LEN(s$): ideselecty1 = y

                found = 1
                ideshowtext
                SCREEN , , 0, 0: LOCATE , , 1: SCREEN , , 3, 0
                PCOPY 3, 0
                r$ = idechangeit
                idedeltxt
                PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                ideselect = 0
                IF r$ = "C" THEN idecx = oldcx: idecy = oldcy: GOTO ideloop
                IF r$ = "Y" THEN
                    l$ = idegetline(idecy)
                    idechangemade = 1
                    IF LEN(l$) >= ideselectx1 THEN
                        l$ = LEFT$(l$, idecx - 1) + idechangeto$ + RIGHT$(l$, LEN(l$) - ideselectx1 + 1)
                    ELSE
                        l$ = LEFT$(l$, idecx - 1) + idechangeto$
                    END IF
                    idesetline idecy, l$
                    IF idefindcasesens = 0 THEN l$ = UCASE$(l$)

                    IF idefindbackwards THEN
                        IF x <= startx AND y = start THEN startx = startx - LEN(s$) + LEN(idechangeto$) 'move startx according to the difference
                    ELSE
                        IF x <= startx AND y = start AND looped = 1 THEN startx = startx - LEN(s$) + LEN(idechangeto$) 'move startx according to the difference
                        x = x + LEN(idechangeto$) - 1 'skip changed portion
                    END IF
                ELSE
                    '"N"
                    '(no action)
                END IF
                IF idefindbackwards THEN x1 = x - 1 ELSE x1 = x + 1
                GOTO idefindagain2
            END IF

            IF idefindbackwards THEN
                y = y - 1
                IF y = start - 1 AND looped = 1 THEN
                    GOTO finishedchange
                END IF
                IF y < 1 THEN y = iden: looped = 1
                GOTO idefindnext2
            ELSE
                y = y + 1
                IF y = start + 1 AND looped = 1 THEN
                    GOTO finishedchange
                END IF
                IF y > iden THEN y = 1: looped = 1
                GOTO idefindnext2
            END IF

            '-------------------------------------------------

            finishedchange:
            idecx = oldcx: idecy = oldcy
            IF found THEN
                ideshowtext
                SCREEN , , 0, 0: LOCATE , , 1: SCREEN , , 3, 0
                PCOPY 3, 0
                idechanged
            ELSE
                idenomatch
            END IF
            PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
            GOTO ideloop
        END IF '#Change...

        IF menu$(m, s) = "Clear search #history..." THEN
            PCOPY 2, 0
            r$ = ideclearhistory$("SEARCH")
            IF r$ = "Y" THEN
                fh = FREEFILE
                OPEN ".\internal\temp\searched.bin" FOR OUTPUT AS #fh: CLOSE #fh
                idefindtext = ""
            END IF
            PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
            GOTO ideloop
        END IF

        IF menu$(m, s) = "#Repeat Last Find  (Shift+) F3" THEN
            PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
            GOTO idemf3
        END IF

        IF menu$(m, s) = "Cl#ear  Del" THEN
            PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
            IF ideselect = 1 THEN
                idechangemade = 1
                GOSUB delselect
            END IF
            GOTO ideloop
        END IF

        IF menu$(m, s) = "#Paste  Shift+Ins or Ctrl+V" THEN
            PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
            GOTO idempaste
        END IF

        IF menu$(m, s) = "#Copy  Ctrl+Ins or Ctrl+C" THEN
            PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
            IF ideselect = 1 THEN GOTO copy2clip
            GOTO ideloop
        END IF

        IF menu$(m, s) = "Cu#t  Shift+Del or Ctrl+X" THEN
            PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
            IF ideselect = 1 THEN
                K$ = CHR$(0) + "S" 'tricks handler into del after copy
                GOTO idemcut
            END IF
            GOTO ideloop
        END IF

        IF menu$(m, s) = "#Undo  Ctrl+Z" THEN
            PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
            GOTO idemundo
        END IF

        IF menu$(m, s) = "#Redo  Ctrl+Y" THEN
            PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
            GOTO idemredo
        END IF


        IF menu$(m, s) = "Select #All  Ctrl+A" THEN
            PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
            GOTO idemselectall
        END IF

        menu$(m, i) = "Select #All  Ctrl+A": i = i + 1

        IF menu$(m, s) = "#Start  F5" THEN
            PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
            UseAndroid 0
            GOTO idemrun
        END IF

        IF menu$(m, s) = "Modify #COMMAND$..." THEN
            PCOPY 2, 0
            retval = idemodifycommandbox
            'retval is ignored
            PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
            GOTO ideloop
        END IF

        IF menu$(m, s) = "Make #Android Project" THEN
            PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
            UseAndroid 1
            GOTO idemrun
        END IF

        IF menu$(m, s) = "Start (#Detached)  Ctrl+F5" THEN
            PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
            UseAndroid 0
            GOTO idemdetached
        END IF

        IF menu$(m, s) = "Make E#XE Only  F11" OR menu$(m, s) = "Make E#xecutable Only  F11" THEN
            PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
            UseAndroid 0
            GOTO idemexe
        END IF

        IF menu$(m, s) = "E#xit" THEN
            PCOPY 2, 0
            quickexit:
            IF ideunsaved = 1 THEN
                r$ = idesavenow
                PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                IF r$ = "C" THEN GOTO ideloop
                IF r$ = "Y" THEN
                    IF ideprogname = "" THEN
                        ProposedTitle$ = FindProposedTitle$
                        IF ProposedTitle$ = "" THEN
                            r$ = idesaveas$("untitled" + tempfolderindexstr$ + ".bas")
                        ELSE
                            r$ = idesaveas$(ProposedTitle$ + ".bas")
                        END IF
                        IF r$ = "C" THEN
                            PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt: GOTO ideloop
                        END IF
                    ELSE
                        idesave idepath$ + idepathsep$ + ideprogname$
                    END IF
                END IF

            END IF
            fh = FREEFILE: OPEN tmpdir$ + "autosave.bin" FOR OUTPUT AS #fh: CLOSE #fh
            SYSTEM
        END IF

        IF menu$(m, s) = "#New" THEN
            PCOPY 2, 0
            IF ideunsaved = 1 THEN
                r$ = idesavenow
                PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                IF r$ = "C" THEN GOTO ideloop
                IF r$ = "Y" THEN
                    IF ideprogname = "" THEN
                        ProposedTitle$ = FindProposedTitle$
                        IF ProposedTitle$ = "" THEN
                            r$ = idesaveas$("untitled" + tempfolderindexstr$ + ".bas")
                        ELSE
                            r$ = idesaveas$(ProposedTitle$ + ".bas")
                        END IF
                        PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                        IF r$ = "C" THEN GOTO ideloop
                    ELSE
                        idesave idepath$ + idepathsep$ + ideprogname$
                    END IF
                END IF
            END IF
            ideunsaved = -1
            'new blank text field
            idet$ = MKL$(0) + MKL$(0): idel = 1: ideli = 1: iden = 1: IdeBmkN = 0
            idesx = 1
            idesy = 1
            idecx = 1
            idecy = 1
            ideselect = 0
            ideprogname$ = ""
            QuickNavTotal = 0
            ModifyCOMMAND$ = ""
            _TITLE "QB64"
            idechangemade = 1
            ideundobase = 0 'reset
            GOTO ideloop
        END IF

        AttemptToLoadRecent = 0
        FOR ml = 1 TO 4
            IF LEN(IdeRecentLink(ml, 1)) THEN
                IF menu$(m, s) = IdeRecentLink(ml, 1) THEN
                    IdeOpenFile$ = IdeRecentLink(ml, 2)
                    AttemptToLoadRecent = -1
                    GOTO directopen
                END IF
            END IF
        NEXT


        IF menu$(m, s) = "#Recent..." THEN
            PCOPY 2, 0
            ideshowrecentbox:
            f$ = iderecentbox
            IF f$ = "<C>" THEN
                f$ = ""
                r$ = ideclearhistory$("FILES")
                IF r$ = "Y" THEN
                    fh = FREEFILE
                    OPEN ".\internal\temp\recent.bin" FOR OUTPUT AS #fh: CLOSE #fh
                    IdeMakeFileMenu
                    PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                    GOTO ideloop
                ELSE
                    goto ideshowrecentbox
                END IF
            ELSEIF f$ = "<R>" THEN
                GOSUB CleanUpRecentList
                GOTO ideshowrecentbox
            END IF
            IF LEN(f$) THEN
                IdeOpenFile$ = f$
                AttemptToLoadRecent = -1
                GOTO directopen
            END IF
            PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
            GOTO ideloop
        END IF

        IF menu$(m, s) = "Clear #recent..." THEN
            PCOPY 2, 0
            r$ = ideclearhistory$("FILES")
            IF r$ = "Y" THEN
                fh = FREEFILE
                OPEN ".\internal\temp\recent.bin" FOR OUTPUT AS #fh: CLOSE #fh
                IdeMakeFileMenu
                PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                GOTO ideloop
            END IF
            PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
            GOTO ideloop
        END IF

        IF menu$(m, s) = "#Open..." THEN
            IdeOpenFile$ = ""
            directopen:
            PCOPY 2, 0
            IF ideunsaved THEN
                r$ = idesavenow
                PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                IF r$ = "C" THEN GOTO ideloop
                IF r$ = "Y" THEN
                    IF ideprogname = "" THEN
                        ProposedTitle$ = FindProposedTitle$
                        IF ProposedTitle$ = "" THEN
                            r$ = idesaveas$("untitled" + tempfolderindexstr$ + ".bas")
                        ELSE
                            r$ = idesaveas$(ProposedTitle$ + ".bas")
                        END IF
                        IF r$ = "C" THEN GOTO ideloop
                    ELSE
                        idesave idepath$ + idepathsep$ + ideprogname$
                    END IF
                    PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                END IF '"Y"
            END IF 'unsaved
            r$ = ideopen
            IF r$ <> "C" THEN ideunsaved = -1: idechangemade = 1: idelayoutallow = 2: ideundobase = 0: QuickNavTotal = 0: ModifyCOMMAND$ = ""
            PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt: GOTO ideloop
        END IF

        IF menu$(m, s) = "#Save" THEN
            PCOPY 2, 0
            IF ideprogname = "" THEN
                ProposedTitle$ = FindProposedTitle$
                IF ProposedTitle$ = "" THEN
                    a$ = idesaveas$("untitled" + tempfolderindexstr$ + ".bas")
                ELSE
                    a$ = idesaveas$(ProposedTitle$ + ".bas")
                END IF
            ELSE
                idesave idepath$ + idepathsep$ + ideprogname$
            END IF
            PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt: GOTO ideloop
        END IF


        IF menu$(m, s) = "Save #As..." THEN
            PCOPY 2, 0
            IF ideprogname = "" THEN
                ProposedTitle$ = FindProposedTitle$
                IF ProposedTitle$ = "" THEN
                    a$ = idesaveas$("untitled" + tempfolderindexstr$ + ".bas")
                ELSE
                    a$ = idesaveas$(ProposedTitle$ + ".bas")
                END IF
            ELSE
                a$ = idesaveas$(ideprogname$)
            END IF
            PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt: GOTO ideloop
        END IF

        IF left$(menu$(m, s),1) = "~" THEN 'Ignore disabled items (starting with "~")
            PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt: GOTO ideloop
        END IF


        SCREEN , , 0, 0
        CLS: PRINT "MENU ITEM [" + menu$(m, s) + "] NOT IMPLEMENTED!": END
    END IF


    _LIMIT 100

LOOP

'--------------------------------------------------------------------------------
EXIT FUNCTION
DrawQuickNav:
IF IdeSystem = 1 AND QuickNavTotal > 0 THEN
    LOCATE 2, 4
    COLOR 15, 7
    PRINT " " + CHR$(17) + " ";
ELSE
    COLOR 7, 1
    LOCATE 2, 4
    PRINT STRING$(3, 196);
END IF
RETURN

UpdateSearchBar:
        LOCATE idewy - 4, idewx - (idesystem2.w + 10)
        COLOR 7, 1: PRINT chr$(180);
        COLOR 3, 1: PRINT "Find[" + SPACE$(idesystem2.w + 1) + chr$(18) + "]";
        COLOR 7, 1: PRINT chr$(195);

        a$ = idefindtext
        tx = 1
        IF LEN(a$) > idesystem2.w THEN
            IF IdeSystem = 2 THEN
                tx = idesystem2.v1 - idesystem2.w + 1
                IF tx < 1 THEN tx = 1
                a$ = MID$(a$, tx, idesystem2.w)
            ELSE
                a$ = LEFT$(a$, idesystem2.w)
            END IF
        END IF

        sx1 = idesystem2.sx1: sx2 = idesystem2.v1
        if sx1 > sx2 then SWAP sx1, sx2

        x = x + 2
        'apply selection color change if necessary
        IF idesystem2.issel = 0 or IdeSystem <> 2 THEN
            COLOR 3, 1
            LOCATE idewy - 4, idewx - (idesystem2.w + 8) + 4: PRINT a$;
        ELSE
            FOR ColorCHAR = 1 to len(a$)
                if ColorCHAR + tx - 2 >= sx1 AND ColorCHAR + tx - 2 < sx2 THEN COLOR 1, 3 ELSE COLOR 3, 1
                LOCATE idewy - 4, idewx - (idesystem2.w + 8) + 4 - 1 + ColorCHAR
                PRINT mid$(a$, ColorCHAR, 1);
            NEXT
        END IF
RETURN

CleanUpRecentList:
l$ = "": ln = 0
REDIM RecentFilesList(0) AS STRING
fh = FREEFILE
OPEN ".\internal\temp\recent.bin" FOR BINARY AS #fh: a$ = SPACE$(LOF(fh)): GET #fh, , a$
CLOSE #fh
a$ = RIGHT$(a$, LEN(a$) - 2)
FoundBrokenLink = 0
DO WHILE LEN(a$)
    ai = INSTR(a$, CRLF)
    IF ai THEN
        f$ = LEFT$(a$, ai - 1): IF ai = LEN(a$) - 1 THEN a$ = "" ELSE a$ = RIGHT$(a$, LEN(a$) - ai - 3)
        IF _FILEEXISTS(f$) THEN
            ln = ln + 1
            REDIM _PRESERVE RecentFilesList(1 to ln)
            RecentFilesList(ln) = f$
        ELSE
            FoundBrokenLink = -1
        END IF
    END IF
LOOP

If not FoundBrokenLink THEN
    ideerrormessage "All files in the list are accessible."
END IF

If ln > 0 AND FoundBrokenLink THEN
    fh = FREEFILE
    OPEN ".\internal\temp\recent.bin" FOR OUTPUT AS #fh: CLOSE #fh
    f$ = ""
    for ln = 1 to ubound(RecentFilesList)
        f$ = f$ + CRLF + RecentFilesList(ln) + CRLF
    next
    fh = FREEFILE
    OPEN ".\internal\temp\recent.bin" FOR BINARY AS #fh
    PUT #fh, 1, f$
    CLOSE #fh
END IF

ERASE RecentFilesList
IdeMakeFileMenu
RETURN
END FUNCTION

SUB idebox (x, y, w, h)
LOCATE y, x: PRINT chr$(218) + STRING$(w - 2, 196) + chr$(191);
FOR y2 = y + 1 TO y + h - 2
    LOCATE y2, x: PRINT chr$(179) + SPACE$(w - 2) + chr$(179);
NEXT
LOCATE y + h - 1, x: PRINT chr$(192) + STRING$(w - 2, 196) + chr$(217);
END SUB

SUB ideboxshadow (x, y, w, h)

LOCATE y, x: PRINT chr$(218) + STRING$(w - 2, 196) + chr$(191);
FOR y2 = y + 1 TO y + h - 2
    LOCATE y2, x: PRINT chr$(179) + SPACE$(w - 2) + chr$(179);
NEXT
LOCATE y + h - 1, x: PRINT chr$(192) + STRING$(w - 2, 196) + chr$(217);
'shadow
COLOR 8, 0
FOR y2 = y + 1 TO y + h - 1
    FOR x2 = x + w TO x + w + 1
        IF x2 <= idewx AND y2 <= idewy THEN
            LOCATE y2, x2: PRINT CHR$(SCREEN(y2, x2));
        END IF
    NEXT
NEXT

y2 = y + h
IF y2 <= idewy THEN
    FOR x2 = x + 2 TO x + w + 1
        IF x2 <= idewx THEN
            LOCATE y2, x2: PRINT CHR$(SCREEN(y2, x2));
        END IF
    NEXT
END IF


END SUB

FUNCTION idechange$
REDIM SearchHistory(0) AS STRING

'-------- generic dialog box header --------
PCOPY 0, 2
PCOPY 0, 1
SCREEN , , 1, 0
focus = 1
DIM p AS idedbptype
DIM o(1 TO 100) AS idedbotype
DIM oo AS idedbotype
DIM sep AS STRING * 1
sep = CHR$(0)
'-------- end of generic dialog box header --------

'-------- init --------

'built initial search strings
IF ideselect THEN
    IF ideselecty1 = idecy THEN 'single line selected
        a$ = idegetline(idecy)
        a2$ = ""
        sx1 = ideselectx1: sx2 = idecx
        IF sx2 < sx1 THEN SWAP sx1, sx2
        FOR x = sx1 TO sx2 - 1
            IF x <= LEN(a$) THEN a2$ = a2$ + MID$(a$, x, 1) ELSE a2$ = a2$ + " "
        NEXT
    END IF
END IF
IF a2$ = "" THEN
    a2$ = idefindtext
END IF

'retrieve search history
ln = 0
fh = FREEFILE
OPEN ".\internal\temp\searched.bin" FOR BINARY AS #fh: a$ = SPACE$(LOF(fh)): GET #fh, , a$
CLOSE #fh
a$ = RIGHT$(a$, LEN(a$) - 2)
DO WHILE LEN(a$)
    ai = INSTR(a$, CRLF)
    IF ai THEN
        f$ = LEFT$(a$, ai - 1): IF ai = LEN(a$) - 1 THEN a$ = "" ELSE a$ = RIGHT$(a$, LEN(a$) - ai - 3)
        ln = ln + 1
        REDIM _PRESERVE SearchHistory(1 to ln)
        SearchHistory(ln) = f$
    END IF
LOOP
ln = 0

i = 0
idepar p, 60, 12, "Change"
i = i + 1
o(i).typ = 1
o(i).y = 2
o(i).nam = idenewtxt("#Find What")
o(i).txt = idenewtxt(a2$)
if len(a2$) > 0 then
    o(i).issel = -1
    o(i).sx1 = 0
end if
o(i).v1 = LEN(a2$)

i = i + 1
o(i).typ = 1
o(i).y = 5
o(i).nam = idenewtxt("Change #To")
o(i).txt = idenewtxt(idechangeto)
if len(idechangeto) > 0 then
    o(i).issel = -1
    o(i).sx1 = 0
end if
o(i).v1 = LEN(idechangeto)

i = i + 1
o(i).typ = 4 'check box
o(i).y = 8
o(i).nam = idenewtxt("#Match Upper/Lowercase")
o(i).sel = idefindcasesens
i = i + 1
o(i).typ = 4 'check box
o(i).y = 9
o(i).nam = idenewtxt("#Whole Word")
o(i).sel = idefindwholeword
i = i + 1
o(i).typ = 4 'check box
o(i).y = 10
o(i).nam = idenewtxt("#Search Backwards")
o(i).sel = idefindbackwards

i = i + 1
o(i).typ = 3
o(i).y = 11
o(i).txt = idenewtxt("Find and #Verify" + sep + "#Change All" + sep + "Cancel")
o(i).dft = 1
'-------- end of init --------

'-------- generic init --------
FOR i = 1 TO 100: o(i).par = p: NEXT 'set parent info of objects
'-------- end of generic init --------

DO 'main loop

    '-------- generic display dialog box & objects --------

    idedrawpar p
    f = 1: cx = 0: cy = 0
    FOR i = 1 TO 100

        IF o(i).typ THEN

            'prepare object
            o(i).foc = focus - f 'focus offset

            o(i).cx = 0: o(i).cy = 0

            idedrawobj o(i), f 'display object

            IF o(i).cx THEN cx = o(i).cx: cy = o(i).cy

        END IF
    NEXT i
    lastfocus = f - 1
    '-------- end of generic display dialog box & objects --------

    '-------- custom display changes --------
    '-------- end of custom display changes --------

    'update visual page and cursor position
    PCOPY 1, 0
    IF cx THEN SCREEN , , 0, 0: LOCATE cy, cx, 1: SCREEN , , 1, 0

    '-------- read input --------
    change = 0
    DO
        GetInput
        IF mWHEEL THEN change = 1
        IF KB THEN change = 1
        IF mCLICK THEN mousedown = 1: change = 1
        IF mRELEASE THEN mouseup = 1: change = 1
        IF mB THEN change = 1
        alt = KALT: IF alt <> oldalt THEN change = 1
        oldalt = alt
        _LIMIT 100
    LOOP UNTIL change
    IF alt THEN idehl = 1 ELSE idehl = 0
    'convert "alt+letter" scancode to letter's ASCII character
    altletter$ = ""
    IF alt THEN
        IF LEN(K$) = 1 THEN
            k = ASC(UCASE$(K$))
            IF k >= 65 AND k <= 90 THEN altletter$ = CHR$(k)
        END IF
    END IF
    SCREEN , , 0, 0: LOCATE , , 0: SCREEN , , 1, 0
    '-------- end of read input --------

    '-------- generic input response --------
    info = 0
    IF K$ = "" THEN K$ = CHR$(255)
    IF KSHIFT = 0 AND K$ = CHR$(9) THEN focus = focus + 1
    IF KSHIFT AND K$ = CHR$(9) THEN focus = focus - 1
    IF focus < 1 THEN focus = lastfocus
    IF focus > lastfocus THEN focus = 1
    f = 1
    FOR i = 1 TO 100
        t = o(i).typ
        IF t THEN
            focusoffset = focus - f
            ideobjupdate o(i), focus, f, focusoffset, K$, altletter$, mB, mousedown, mouseup, mX, mY, info, mWHEEL
        END IF
    NEXT
    '-------- end of generic input response --------

    'specific post controls

    IF K$ = CHR$(27) OR (focus = 8 AND info <> 0) THEN
        idechange$ = "C"
        EXIT FUNCTION
    END IF

    if ubound(SearchHistory) > 0 then
        IF K$ = CHR$(0) + CHR$(72) AND focus = 1 THEN 'Up
            IF ln < ubound(SearchHistory) THEN
                ln = ln + 1
            END IF
            idetxt(o(1).txt) = SearchHistory(ln)
            o(1).issel = -1: o(1).sx1 = 0: o(1).v1 = len(idetxt(o(1).txt))
        END IF

        IF K$ = CHR$(0) + CHR$(80) AND focus = 1 THEN 'Down
            IF ln > 1 THEN
                ln = ln - 1
            ELSE
                ln = 1
            END IF
            idetxt(o(1).txt) = SearchHistory(ln)
            o(1).issel = -1: o(1).sx1 = 0: o(1).v1 = len(idetxt(o(1).txt))
        END IF
    end if

    IF focus = 7 AND info <> 0 THEN 'change all
        idefindcasesens = o(3).sel
        idefindwholeword = o(4).sel
        idefindbackwards = o(5).sel

        s$ = idetxt(o(1).txt)
        idefindtext$ = s$
        idechangeto$ = idetxt(o(2).txt)
        IdeAddSearched idefindtext

        changed = 0

        s$ = idefindtext$
        IF idefindcasesens = 0 THEN s$ = UCASE$(s$)

        FOR y = 1 TO iden
            l$ = idegetline(y)
            l2$ = ""

            x1 = 1
            idechangeall:
            IF idefindcasesens = 0 THEN l3$ = UCASE$(l$) ELSE l3$ = l$
            x = INSTR(x1, l3$, s$)

            IF x THEN
                IF idefindwholeword THEN
                    whole = 1
                    IF x > 1 THEN
                        c = ASC(UCASE$(MID$(l$, x - 1, 1)))
                        IF c >= 65 AND c <= 90 THEN whole = 0
                        IF c >= 48 AND c <= 57 THEN whole = 0
                    END IF
                    IF x + LEN(s$) <= LEN(l$) THEN
                        c = ASC(UCASE$(MID$(l$, x + LEN(s$), 1)))
                        IF c >= 65 AND c <= 90 THEN whole = 0
                        IF c >= 48 AND c <= 57 THEN whole = 0
                    END IF
                    IF whole = 0 THEN
                        IF x1 <= LEN(l$) THEN
                            l2$ = l2$ + MID$(l$, x1, x - x1 + 1)
                            x1 = x + 1
                            GOTO idechangeall
                        END IF
                        x = 0
                    END IF
                END IF
            END IF

            IF x THEN
                l2$ = l2$ + MID$(l$, x1, x - x1) + idechangeto$
                x1 = x + LEN(s$)
                IF x1 <= LEN(l$) THEN GOTO idechangeall
            END IF

            l2$ = l2$ + MID$(l$, x1, LEN(l$) - x1 + 1)

            IF l2$ <> l$ THEN idesetline y, l2$: changed = 1

        NEXT

        IF changed = 0 THEN idenomatch ELSE idechanged: idechangemade = 1
        EXIT FUNCTION

    END IF 'change all


    IF (focus = 6 AND info <> 0) OR K$ = CHR$(13) THEN
        idefindcasesens = o(3).sel
        idefindwholeword = o(4).sel
        idefindbackwards = o(5).sel
        idefindtext$ = idetxt(o(1).txt)
        idechangeto$ = idetxt(o(2).txt)
        idechange$ = "V"
        EXIT FUNCTION
    END IF


    'end of custom controls



    mousedown = 0
    mouseup = 0
LOOP


END FUNCTION

SUB idechanged

'-------- generic dialog box header --------
PCOPY 3, 0
PCOPY 0, 2
PCOPY 0, 1
SCREEN , , 1, 0
focus = 1
DIM p AS idedbptype
DIM o(1 TO 100) AS idedbotype
DIM oo AS idedbotype
DIM sep AS STRING * 1
sep = CHR$(0)
'-------- end of generic dialog box header --------

'-------- init --------
i = 0
idepar p, 19, 4, ""
i = i + 1
o(i).typ = 3
o(i).y = 4
o(i).txt = idenewtxt("OK")
o(i).dft = 1
'-------- end of init --------

'-------- generic init --------
FOR i = 1 TO 100: o(i).par = p: NEXT 'set parent info of objects
'-------- end of generic init --------

DO 'main loop

    '-------- generic display dialog box & objects --------
    idedrawpar p
    f = 1: cx = 0: cy = 0
    FOR i = 1 TO 100
        IF o(i).typ THEN
            'prepare object
            o(i).foc = focus - f 'focus offset
            o(i).cx = 0: o(i).cy = 0
            idedrawobj o(i), f 'display object
            IF o(i).cx THEN cx = o(i).cx: cy = o(i).cy
        END IF
    NEXT i
    lastfocus = f - 1
    '-------- end of generic display dialog box & objects --------

    '-------- custom display changes --------
    COLOR 0, 7: LOCATE p.y + 2, p.x + 3: PRINT "Change Complete";
    '-------- end of custom display changes --------

    'update visual page and cursor position
    PCOPY 1, 0
    IF cx THEN SCREEN , , 0, 0: LOCATE cy, cx, 1: SCREEN , , 1, 0

    '-------- read input --------
    change = 0
    DO
        GetInput
        IF mWHEEL THEN change = 1
        IF KB THEN change = 1
        IF mCLICK THEN mousedown = 1: change = 1
        IF mRELEASE THEN mouseup = 1: change = 1
        IF mB THEN change = 1
        alt = KALT: IF alt <> oldalt THEN change = 1
        oldalt = alt
        _LIMIT 100
    LOOP UNTIL change
    IF alt THEN idehl = 1 ELSE idehl = 0
    'convert "alt+letter" scancode to letter's ASCII character
    altletter$ = ""
    IF alt THEN
        IF LEN(K$) = 1 THEN
            k = ASC(UCASE$(K$))
            IF k >= 65 AND k <= 90 THEN altletter$ = CHR$(k)
        END IF
    END IF
    SCREEN , , 0, 0: LOCATE , , 0: SCREEN , , 1, 0
    '-------- end of read input --------

    IF UCASE$(K$) = "Y" THEN altletter$ = "Y"
    IF UCASE$(K$) = "N" THEN altletter$ = "N"

    '-------- generic input response --------
    info = 0
    IF K$ = "" THEN K$ = CHR$(255)
    IF KSHIFT = 0 AND K$ = CHR$(9) THEN focus = focus + 1
    IF KSHIFT AND K$ = CHR$(9) THEN focus = focus - 1
    IF focus < 1 THEN focus = lastfocus
    IF focus > lastfocus THEN focus = 1
    f = 1
    FOR i = 1 TO 100
        t = o(i).typ
        IF t THEN
            focusoffset = focus - f
            ideobjupdate o(i), focus, f, focusoffset, K$, altletter$, mB, mousedown, mouseup, mX, mY, info, mWHEEL
        END IF
    NEXT
    '-------- end of generic input response --------

    IF K$ = CHR$(27) THEN
        EXIT SUB
    END IF

    IF info THEN
        EXIT SUB
    END IF

    'end of custom controls

    mousedown = 0
    mouseup = 0
LOOP

END SUB

FUNCTION idechangeit$

'-------- generic dialog box header --------
PCOPY 3, 0
PCOPY 0, 2
PCOPY 0, 1
SCREEN , , 1, 0
focus = 1
DIM p AS idedbptype
DIM o(1 TO 100) AS idedbotype
DIM oo AS idedbotype
DIM sep AS STRING * 1
sep = CHR$(0)
'-------- end of generic dialog box header --------

'-------- init --------
i = 0
w = 45
p.x = 40 - w \ 2
p.y = 21
p.w = w
p.h = 2
p.nam = idenewtxt("Change")

i = i + 1
o(i).typ = 3
o(i).y = 2
o(i).txt = idenewtxt("#Change" + sep + "#Skip" + sep + "Cancel")
o(i).dft = 1
'-------- end of init --------

'-------- generic init --------
FOR i = 1 TO 100: o(i).par = p: NEXT 'set parent info of objects
'-------- end of generic init --------

DO 'main loop

    '-------- generic display dialog box & objects --------
    idedrawpar p
    f = 1: cx = 0: cy = 0
    FOR i = 1 TO 100
        IF o(i).typ THEN
            'prepare object
            o(i).foc = focus - f 'focus offset
            o(i).cx = 0: o(i).cy = 0
            idedrawobj o(i), f 'display object
            IF o(i).cx THEN cx = o(i).cx: cy = o(i).cy
        END IF
    NEXT i
    lastfocus = f - 1
    '-------- end of generic display dialog box & objects --------

    '-------- custom display changes --------
    '-------- end of custom display changes --------

    'update visual page and cursor position
    PCOPY 1, 0
    IF cx THEN SCREEN , , 0, 0: LOCATE cy, cx, 1: SCREEN , , 1, 0

    '-------- read input --------
    change = 0
    DO
        GetInput
        IF mWHEEL THEN change = 1
        IF KB THEN change = 1
        IF mCLICK THEN mousedown = 1: change = 1
        IF mRELEASE THEN mouseup = 1: change = 1
        IF mB THEN change = 1
        alt = KALT: IF alt <> oldalt THEN change = 1
        oldalt = alt
        _LIMIT 100
    LOOP UNTIL change
    IF alt THEN idehl = 1 ELSE idehl = 0
    'convert "alt+letter" scancode to letter's ASCII character
    altletter$ = ""
    IF alt THEN
        IF LEN(K$) = 1 THEN
            k = ASC(UCASE$(K$))
            IF k >= 65 AND k <= 90 THEN altletter$ = CHR$(k)
        END IF
    END IF
    SCREEN , , 0, 0: LOCATE , , 0: SCREEN , , 1, 0
    '-------- end of read input --------

    IF UCASE$(K$) = "C" THEN altletter$ = "C"
    IF UCASE$(K$) = "S" THEN altletter$ = "S"

    '-------- generic input response --------
    info = 0
    IF K$ = "" THEN K$ = CHR$(255)
    IF KSHIFT = 0 AND K$ = CHR$(9) THEN focus = focus + 1
    IF KSHIFT AND K$ = CHR$(9) THEN focus = focus - 1
    IF focus < 1 THEN focus = lastfocus
    IF focus > lastfocus THEN focus = 1
    f = 1
    FOR i = 1 TO 100
        t = o(i).typ
        IF t THEN
            focusoffset = focus - f
            ideobjupdate o(i), focus, f, focusoffset, K$, altletter$, mB, mousedown, mouseup, mX, mY, info, mWHEEL
        END IF
    NEXT
    '-------- end of generic input response --------

    IF K$ = CHR$(27) THEN
        idechangeit$ = "C"
        EXIT FUNCTION
    END IF

    IF info THEN
        IF info = 1 THEN idechangeit$ = "Y"
        IF info = 2 THEN idechangeit$ = "N"
        IF info = 3 THEN idechangeit$ = "C"
        EXIT FUNCTION
    END IF

    'end of custom controls
    mousedown = 0
    mouseup = 0
LOOP


END FUNCTION

SUB idedelline (i)

FOR b = 1 TO IdeBmkN
    IF IdeBmk(b).y >= i THEN
        y = IdeBmk(b).y - 1: IF y = 0 THEN y = 1
        IdeBmk(b).y = y
    END IF
NEXT

idegotoline i
textlen = CVL(MID$(idet$, ideli, 4))
idet$ = LEFT$(idet$, ideli - 1) + RIGHT$(idet$, LEN(idet$) - ideli + 1 - 8 - textlen)
iden = iden - 1

IF i > iden THEN idegotoline iden '[2013] if last line was removed, move to previous line

END SUB

SUB idedeltxt
idetxtlast = 0
END SUB

SUB idedrawobj (o AS idedbotype, f)
DIM sep AS STRING * 1
sep = CHR$(0)

'#1: SINGLE LINE TEXT INPUT BOX
IF o.typ = 1 THEN
    IF o.x = 0 THEN o.x = 2
    x = o.par.x + o.x: y = o.par.y + o.y
    COLOR 0, 7
    IF o.nam THEN
        a$ = idetxt(o.nam)
        LOCATE y, x: idehPRINT a$ + ":"
        x = x + idehlen(a$) + 2
    END IF
    IF o.w = 0 THEN x2 = o.par.x + o.par.w - 1: o.w = x2 - x - 3
    idebox x, y - 1, o.w + 4, 3
    IF o.txt = 0 THEN o.txt = idenewtxt("")
    a$ = idetxt(o.txt)
    IF o.v1 > LEN(a$) THEN o.v1 = LEN(a$) 'new
    cx = o.v1

    tx = 1
    IF LEN(a$) > o.w THEN
        IF o.foc = 0 THEN
            tx = o.v1 - o.w + 1
            IF tx < 1 THEN tx = 1
            a$ = MID$(a$, tx, o.w)
            cx = cx - tx + 1
        ELSE
            a$ = LEFT$(a$, o.w)
        END IF
    END IF

    sx1 = o.sx1: sx2 = o.v1
    if sx1 > sx2 then SWAP sx1, sx2

    x = x + 2
    'apply selection color change if necessary
    IF o.issel = 0 or o.foc <> 0 THEN
        LOCATE y, x: PRINT a$;
    ELSE
        FOR ColorCHAR = 1 to len(a$)
            if ColorCHAR + tx - 2 >= sx1 AND ColorCHAR + tx - 2 < sx2 THEN COLOR 7, 0 ELSE COLOR 0,7
            LOCATE y, x - 1 + ColorCHAR
            PRINT mid$(a$, ColorCHAR, 1);
        NEXT
    END IF

    IF o.foc = 0 THEN o.cx = x + cx: o.cy = y
    f = f + 1
END IF '#1

'#2: VERTICAL SCROLLING SELECTION BOX
IF o.typ = 2 THEN
    IF o.x = 0 THEN o.x = 2
    IF o.w = 0 THEN o.w = o.par.w - 2 - o.x
    IF o.h = 0 THEN o.h = o.par.h - 1 - o.y
    x = o.par.x + o.x: y = o.par.y + o.y
    COLOR 0, 7
    idebox x, y, o.w + 2, o.h + 2
    IF o.nam THEN
        a$ = idetxt(o.nam)
        w = o.w + 2
        m = w \ 2: IF w AND 1 THEN m = m + 1
        LOCATE y, x + m - 1 - ((idehlen(a$) + 2) - 1) \ 2: idehPRINT " " + a$ + " "
    END IF 'nam
    'display list items
    IF o.sel = 0 THEN o.sel = -1
    IF o.txt = 0 THEN o.txt = idenewtxt("")
    IF o.stx = 0 THEN o.stx = idenewtxt("")
    IF o.v1 = 0 THEN o.v1 = 1
    s = ABS(o.sel)
    IF s >= o.v1 + o.h THEN o.v1 = s - o.h + 1
    IF s < o.v1 THEN o.v1 = s
    IF o.foc <> 0 AND o.sel > 0 THEN o.sel = -o.sel
    a$ = idetxt(o.txt)
    n = 1
    y = 1
    v1 = o.v1
    a3$ = ""
    FOR i2 = 1 TO LEN(a$)
        a2$ = MID$(a$, i2, 1)
        IF a2$ <> sep THEN a3$ = a3$ + a2$
        IF a2$ = sep OR i2 = LEN(a$) THEN
            IF n < v1 THEN
                'skip
            ELSE
                IF y <= o.h THEN
                    IF o.sel = n THEN COLOR 7, 0 ELSE COLOR 0, 7
                    IF (o.sel = n OR -o.sel = n) AND o.foc = 0 THEN o.cx = o.par.x + o.x + 2: o.cy = o.par.y + o.y + y
                    LOCATE o.par.y + o.y + y, o.par.x + o.x + 1
                    a3$ = " " + a3$ + SPACE$(o.w)
                    a3$ = LEFT$(a3$, o.w)
                    PRINT a3$;
                    'customization specific for the SUBs list, when there are external procedures:
                    if instr(a3$, chr$(196)+"*") > 0 THEN
                        IF o.sel = n THEN COLOR 8, 0 ELSE COLOR 8, 7
                        LOCATE o.par.y + o.y + y, o.par.x + o.x + 4
                        PRINT "*";
                    end if
                    y = y + 1
                END IF
            END IF
            n = n + 1
            a3$ = ""
        END IF
    NEXT
    o.num = n - 1

    tnum = o.num
    tsel = ABS(o.sel)

    q = idevbar(o.par.x + o.x + o.w + 1, o.par.y + o.y + 1, o.h, tsel, tnum)

    f = f + 1
END IF '#2

'#3: ACTION BUTTONS
IF o.typ = 3 THEN
    IF o.x = 0 THEN o.x = 2
    IF o.w = 0 THEN o.w = o.par.w - o.x 'spanable width
    IF o.txt = 0 THEN o.txt = idenewtxt("OK")
    a$ = idetxt(o.txt)
    n = 1
    c = 0
    FOR i2 = 1 TO LEN(a$)
        a2$ = MID$(a$, i2, 1)
        IF a2$ = CHR$(0) THEN
            n = n + 1
        ELSE
            IF a$ <> "#" THEN c = c + 1
        END IF
    NEXT
    w = o.w
    c = c + n * 4 'add characters for bracing < > buttons
    whitespace = w - c
    spacing = whitespace \ (n + 1)
    f2 = o.foc + 1
    IF f2 < 1 OR f2 > n THEN
        IF o.dft THEN f2 = o.dft
    END IF
    n2 = 1
    a3$ = ""
    LOCATE o.par.y + o.y, o.par.x + o.x
    x = o.par.x + o.x
    COLOR 0, 7
    FOR i2 = 1 TO LEN(a$)
        a2$ = MID$(a$, i2, 1)
        IF a2$ <> CHR$(0) THEN a3$ = a3$ + a2$
        IF a2$ = CHR$(0) OR i2 = LEN(a$) THEN
            PRINT SPACE$(spacing);
            x = x + spacing
            IF f2 = n2 THEN COLOR 15, 7 ELSE COLOR 0, 7
            PRINT "< ";
            COLOR 0, 7: idehPRINT a3$
            IF f2 = n2 THEN COLOR 15, 7 ELSE COLOR 0, 7
            IF n2 = o.foc + 1 THEN
                o.cx = x + 2: o.cy = o.par.y + o.y
            END IF
            PRINT " >";
            COLOR 0, 7
            x = x + idehlen(a3$) + 4
            a3$ = ""
            n2 = n2 + 1
        END IF
    NEXT
    f = f + n
END IF '#3

'#4: CHECK BOX
IF o.typ = 4 THEN
    IF o.x = 0 THEN o.x = 2
    x = o.par.x + o.x: y = o.par.y + o.y
    LOCATE y, x
    COLOR 0, 7
    IF o.sel THEN
        PRINT "[X] ";
    ELSE
        PRINT "[ ] ";
    END IF
    IF o.nam THEN
        a$ = idetxt(o.nam)
        idehPRINT a$
    END IF
    IF o.foc = 0 THEN o.cx = x + 1: o.cy = y
    f = f + 1
END IF '#4

END SUB

SUB idedrawpar (p AS idedbptype)
COLOR 0, 7: ideboxshadow p.x, p.y, p.w + 2, p.h + 2
IF p.nam THEN
    x = LEN(idetxt(p.nam)) + 2
    COLOR 0, 7: LOCATE p.y, p.x + (p.w \ 2) - (x - 1) \ 2: PRINT " " + idetxt(p.nam) + " ";
END IF
END SUB

SUB ideerrormessage (mess$)


'-------- generic dialog box header --------
PCOPY 3, 0
PCOPY 0, 2
PCOPY 0, 1
SCREEN , , 1, 0
focus = 1
DIM p AS idedbptype
DIM o(1 TO 100) AS idedbotype
DIM oo AS idedbotype
DIM sep AS STRING * 1
sep = CHR$(0)
'-------- end of generic dialog box header --------

'-------- init --------
i = 0
idepar p, LEN(mess$) + 4, 4, ""
i = i + 1
o(i).typ = 3
o(i).y = 4
o(i).txt = idenewtxt("OK")
o(i).dft = 1
'-------- end of init --------

'-------- generic init --------
FOR i = 1 TO 100: o(i).par = p: NEXT 'set parent info of objects
'-------- end of generic init --------

DO 'main loop

    '-------- generic display dialog box & objects --------
    idedrawpar p
    f = 1: cx = 0: cy = 0
    FOR i = 1 TO 100
        IF o(i).typ THEN
            'prepare object
            o(i).foc = focus - f 'focus offset
            o(i).cx = 0: o(i).cy = 0
            idedrawobj o(i), f 'display object
            IF o(i).cx THEN cx = o(i).cx: cy = o(i).cy
        END IF
    NEXT i
    lastfocus = f - 1
    '-------- end of generic display dialog box & objects --------

    '-------- custom display changes --------
    COLOR 0, 7: LOCATE p.y + 2, p.x + 3: PRINT mess$;
    '-------- end of custom display changes --------

    'update visual page and cursor position
    PCOPY 1, 0
    IF cx THEN SCREEN , , 0, 0: LOCATE cy, cx, 1: SCREEN , , 1, 0

    '-------- read input --------
    change = 0
    DO
        GetInput
        IF mWHEEL THEN change = 1
        IF KB THEN change = 1
        IF mCLICK THEN mousedown = 1: change = 1
        IF mRELEASE THEN mouseup = 1: change = 1
        IF mB THEN change = 1
        alt = KALT: IF alt <> oldalt THEN change = 1
        oldalt = alt
        _LIMIT 100
    LOOP UNTIL change
    IF alt THEN idehl = 1 ELSE idehl = 0
    'convert "alt+letter" scancode to letter's ASCII character
    altletter$ = ""
    IF alt THEN
        IF LEN(K$) = 1 THEN
            k = ASC(UCASE$(K$))
            IF k >= 65 AND k <= 90 THEN altletter$ = CHR$(k)
        END IF
    END IF
    SCREEN , , 0, 0: LOCATE , , 0: SCREEN , , 1, 0
    '-------- end of read input --------

    IF UCASE$(K$) = "Y" THEN altletter$ = "Y"
    IF UCASE$(K$) = "N" THEN altletter$ = "N"

    '-------- generic input response --------
    info = 0
    IF K$ = "" THEN K$ = CHR$(255)
    IF KSHIFT = 0 AND K$ = CHR$(9) THEN focus = focus + 1
    IF KSHIFT AND K$ = CHR$(9) THEN focus = focus - 1
    IF focus < 1 THEN focus = lastfocus
    IF focus > lastfocus THEN focus = 1
    f = 1
    FOR i = 1 TO 100
        t = o(i).typ
        IF t THEN
            focusoffset = focus - f
            ideobjupdate o(i), focus, f, focusoffset, K$, altletter$, mB, mousedown, mouseup, mX, mY, info, mWHEEL
        END IF
    NEXT
    '-------- end of generic input response --------

    IF K$ = CHR$(27) THEN
        EXIT SUB
    END IF

    IF info THEN
        EXIT SUB
    END IF

    'end of custom controls

    mousedown = 0
    mouseup = 0
LOOP


END SUB

FUNCTION idefileexists$
'-------- generic dialog box header --------
PCOPY 3, 0
PCOPY 0, 2
PCOPY 0, 1
SCREEN , , 1, 0
focus = 1
DIM p AS idedbptype
DIM o(1 TO 100) AS idedbotype
DIM oo AS idedbotype
DIM sep AS STRING * 1
sep = CHR$(0)
'-------- end of generic dialog box header --------

'-------- init --------
i = 0
'idepar p, 30, 6, "File already exists. Overwrite?"
idepar p, 35, 4, ""
i = i + 1
o(i).typ = 3
o(i).y = 4
o(i).txt = idenewtxt("#Yes" + sep + "#No")
o(i).dft = 1
'-------- end of init --------

'-------- generic init --------
FOR i = 1 TO 100: o(i).par = p: NEXT 'set parent info of objects
'-------- end of generic init --------

DO 'main loop

    '-------- generic display dialog box & objects --------
    idedrawpar p
    f = 1: cx = 0: cy = 0
    FOR i = 1 TO 100
        IF o(i).typ THEN
            'prepare object
            o(i).foc = focus - f 'focus offset
            o(i).cx = 0: o(i).cy = 0
            idedrawobj o(i), f 'display object
            IF o(i).cx THEN cx = o(i).cx: cy = o(i).cy
        END IF
    NEXT i
    lastfocus = f - 1
    '-------- end of generic display dialog box & objects --------

    '-------- custom display changes --------
    COLOR 0, 7: LOCATE p.y + 2, p.x + 3: PRINT "File already exists. Overwrite?";
    '-------- end of custom display changes --------

    'update visual page and cursor position
    PCOPY 1, 0
    IF cx THEN SCREEN , , 0, 0: LOCATE cy, cx, 1: SCREEN , , 1, 0

    '-------- read input --------
    change = 0
    DO
        GetInput
        IF mWHEEL THEN change = 1
        IF KB THEN change = 1
        IF mCLICK THEN mousedown = 1: change = 1
        IF mRELEASE THEN mouseup = 1: change = 1
        IF mB THEN change = 1
        alt = KALT: IF alt <> oldalt THEN change = 1
        oldalt = alt
        _LIMIT 100
    LOOP UNTIL change
    IF alt THEN idehl = 1 ELSE idehl = 0
    'convert "alt+letter" scancode to letter's ASCII character
    altletter$ = ""
    IF alt THEN
        IF LEN(K$) = 1 THEN
            k = ASC(UCASE$(K$))
            IF k >= 65 AND k <= 90 THEN altletter$ = CHR$(k)
        END IF
    END IF
    SCREEN , , 0, 0: LOCATE , , 0: SCREEN , , 1, 0
    '-------- end of read input --------

    IF UCASE$(K$) = "Y" THEN altletter$ = "Y"
    IF UCASE$(K$) = "N" THEN altletter$ = "N"

    '-------- generic input response --------
    info = 0
    IF K$ = "" THEN K$ = CHR$(255)
    IF KSHIFT = 0 AND K$ = CHR$(9) THEN focus = focus + 1
    IF KSHIFT AND K$ = CHR$(9) THEN focus = focus - 1
    IF focus < 1 THEN focus = lastfocus
    IF focus > lastfocus THEN focus = 1
    f = 1
    FOR i = 1 TO 100
        t = o(i).typ
        IF t THEN
            focusoffset = focus - f
            ideobjupdate o(i), focus, f, focusoffset, K$, altletter$, mB, mousedown, mouseup, mX, mY, info, mWHEEL
        END IF
    NEXT
    '-------- end of generic input response --------

    IF K$ = CHR$(27) THEN
        idefileexists$ = "N"
        EXIT FUNCTION
    END IF

    IF info THEN
        IF info = 1 THEN idefileexists$ = "Y" ELSE idefileexists$ = "N"
        EXIT FUNCTION
    END IF

    'end of custom controls
    mousedown = 0
    mouseup = 0
LOOP


END FUNCTION




FUNCTION idefind$

REDIM SearchHistory(0) AS STRING
'-------- generic dialog box header --------
PCOPY 0, 2
PCOPY 0, 1
SCREEN , , 1, 0
focus = 1
DIM p AS idedbptype
DIM o(1 TO 100) AS idedbotype
DIM oo AS idedbotype
DIM sep AS STRING * 1
sep = CHR$(0)
'-------- end of generic dialog box header --------

'-------- init --------

'built initial search string
IF ideselect THEN
    IF ideselecty1 = idecy THEN 'single line selected
        a$ = idegetline(idecy)
        a2$ = ""
        sx1 = ideselectx1: sx2 = idecx
        IF sx2 < sx1 THEN SWAP sx1, sx2
        FOR x = sx1 TO sx2 - 1
            IF x <= LEN(a$) THEN a2$ = a2$ + MID$(a$, x, 1) ELSE a2$ = a2$ + " "
        NEXT
    END IF
END IF
IF a2$ = "" THEN
    a2$ = idefindtext
END IF

'retrieve search history
ln = 0
fh = FREEFILE
OPEN ".\internal\temp\searched.bin" FOR BINARY AS #fh: a$ = SPACE$(LOF(fh)): GET #fh, , a$
CLOSE #fh
a$ = RIGHT$(a$, LEN(a$) - 2)
DO WHILE LEN(a$)
    ai = INSTR(a$, CRLF)
    IF ai THEN
        f$ = LEFT$(a$, ai - 1): IF ai = LEN(a$) - 1 THEN a$ = "" ELSE a$ = RIGHT$(a$, LEN(a$) - ai - 3)
        ln = ln + 1
        REDIM _PRESERVE SearchHistory(1 to ln)
        SearchHistory(ln) = f$
    END IF
LOOP
ln = 0

i = 0
idepar p, 60, 9, "Find"
i = i + 1
o(i).typ = 1
o(i).y = 2
o(i).nam = idenewtxt("#Find What")
o(i).txt = idenewtxt(a2$)
if len(a2$) > 0 then
    o(i).issel = -1
    o(i).sx1 = 0
end if
o(i).v1 = LEN(a2$)



i = i + 1
o(i).typ = 4 'check box
o(i).y = 5
o(i).nam = idenewtxt("#Match Upper/Lowercase")
o(i).sel = idefindcasesens

i = i + 1
o(i).typ = 4 'check box
o(i).y = 6
o(i).nam = idenewtxt("#Whole Word")
o(i).sel = idefindwholeword

i = i + 1
o(i).typ = 4 'check box
o(i).y = 7
o(i).nam = idenewtxt("#Search Backwards")
o(i).sel = idefindbackwards

i = i + 1
o(i).typ = 3
o(i).y = 9
o(i).txt = idenewtxt("OK" + sep + "#Cancel")
o(i).dft = 1
'-------- end of init --------

'-------- generic init --------
FOR i = 1 TO 100: o(i).par = p: NEXT 'set parent info of objects
'-------- end of generic init --------

DO 'main loop


    '-------- generic display dialog box & objects --------
    idedrawpar p
    f = 1: cx = 0: cy = 0
    FOR i = 1 TO 100
        IF o(i).typ THEN

            'prepare object
            o(i).foc = focus - f 'focus offset
            o(i).cx = 0: o(i).cy = 0
            idedrawobj o(i), f 'display object
            IF o(i).cx THEN cx = o(i).cx: cy = o(i).cy
        END IF
    NEXT i
    lastfocus = f - 1
    '-------- end of generic display dialog box & objects --------

    '-------- custom display changes --------
    '-------- end of custom display changes --------

    'update visual page and cursor position
    PCOPY 1, 0
    IF cx THEN SCREEN , , 0, 0: LOCATE cy, cx, 1: SCREEN , , 1, 0

    '-------- read input --------
    change = 0
    DO
        GetInput
        IF mWHEEL THEN change = 1
        IF KB THEN change = 1
        IF mCLICK THEN mousedown = 1: change = 1
        IF mRELEASE THEN mouseup = 1: change = 1
        IF mB THEN change = 1
        alt = KALT: IF alt <> oldalt THEN change = 1
        oldalt = alt
        _LIMIT 100
    LOOP UNTIL change
    IF alt THEN idehl = 1 ELSE idehl = 0
    'convert "alt+letter" scancode to letter's ASCII character
    altletter$ = ""
    IF alt THEN
        IF LEN(K$) = 1 THEN
            k = ASC(UCASE$(K$))
            IF k >= 65 AND k <= 90 THEN altletter$ = CHR$(k)
        END IF
    END IF
    SCREEN , , 0, 0: LOCATE , , 0: SCREEN , , 1, 0
    '-------- end of read input --------

    '-------- generic input response --------
    info = 0
    IF K$ = "" THEN K$ = CHR$(255)
    IF KSHIFT = 0 AND K$ = CHR$(9) THEN focus = focus + 1
    IF KSHIFT AND K$ = CHR$(9) THEN focus = focus - 1
    IF focus < 1 THEN focus = lastfocus
    IF focus > lastfocus THEN focus = 1
    f = 1
    FOR i = 1 TO 100
        t = o(i).typ
        IF t THEN
            focusoffset = focus - f
            ideobjupdate o(i), focus, f, focusoffset, K$, altletter$, mB, mousedown, mouseup, mX, mY, info, mWHEEL
        END IF
    NEXT
    '-------- end of generic input response --------

    'specific post controls

    IF K$ = CHR$(27) OR (focus = 6 AND info <> 0) THEN
        idefind$ = "C"
        EXIT FUNCTION
    END IF

    IF K$ = CHR$(13) OR (focus = 5 AND info <> 0) THEN
        idefindcasesens = o(2).sel
        idefindwholeword = o(3).sel
        idefindbackwards = o(4).sel
        s$ = idetxt(o(1).txt)
        idefindtext$ = s$
        IdeAddSearched idefindtext
        idefindagain
        EXIT FUNCTION
    END IF

    if ubound(SearchHistory) > 0 then
        IF K$ = CHR$(0) + CHR$(72) AND focus = 1 THEN 'Up
            IF ln < ubound(SearchHistory) THEN
                ln = ln + 1
            END IF
            idetxt(o(1).txt) = SearchHistory(ln)
            o(1).issel = -1: o(1).sx1 = 0: o(1).v1 = len(idetxt(o(1).txt))
        END IF

        IF K$ = CHR$(0) + CHR$(80) AND focus = 1 THEN 'Down
            IF ln > 1 THEN
                ln = ln - 1
            ELSE
                ln = 1
            END IF
            idetxt(o(1).txt) = SearchHistory(ln)
            o(1).issel = -1: o(1).sx1 = 0: o(1).v1 = len(idetxt(o(1).txt))
        END IF
    end if
    'end of custom controls



    mousedown = 0
    mouseup = 0
LOOP
END FUNCTION

SUB idefindagain

IF idefindinvert THEN
    IF idefindbackwards = 0 THEN idefindbackwards = 1 ELSE idefindbackwards = 0
END IF

s$ = idefindtext$
IF idefindcasesens = 0 THEN s$ = UCASE$(s$)
start = idecy
y = start

idefindnext2:
l$ = idegetline(y)
IF idefindcasesens = 0 THEN l$ = UCASE$(l$)

IF y = start THEN
    'retrieve the unscanned portion of this line only
    IF looped = 1 THEN
        IF idefindbackwards THEN
            IF LEN(l$) > idecx THEN l$ = STRING$(idecx, 255) + RIGHT$(l$, LEN(l$) - idecx) ELSE l$ = ""
        ELSE
            IF LEN(l$) > idecx THEN l$ = LEFT$(l$, idecx)
        END IF
    ELSE
        IF idefindbackwards THEN
            IF LEN(l$) > idecx THEN l$ = LEFT$(l$, idecx - 1 + (LEN(s$) - 1))
        ELSE
            IF LEN(l$) > idecx THEN l$ = STRING$(idecx, 255) + RIGHT$(l$, LEN(l$) - idecx) ELSE l$ = ""
        END IF
    END IF
END IF

x1 = 1
IF idefindbackwards THEN
    x1 = LEN(l$) - LEN(s$) + 1
    IF x1 < 0 THEN x1 = 0
END IF

idefindagain2:

IF idefindbackwards THEN
    x = 0
    FOR xx = x1 TO 1 STEP -1
        IF ASC(l$, xx) = ASC(s$) THEN 'first char
            xxo = xx - 1
            FOR xx2 = xx TO xx + LEN(s$) - 1
                IF ASC(l$, xx2) <> ASC(s$, xx2 - xxo) THEN EXIT FOR
            NEXT
            IF xx2 = xx + LEN(s$) THEN
                'matched!
                x = xx
                EXIT FOR
            END IF
        END IF 'first char
    NEXT
ELSE
    x = INSTR(x1, l$, s$)
END IF


IF x THEN
    IF idefindwholeword THEN
        whole = 1
        IF x > 1 THEN
            c = ASC(UCASE$(MID$(l$, x - 1, 1)))
            IF c >= 65 AND c <= 90 THEN whole = 0
            IF c >= 48 AND c <= 57 THEN whole = 0
        END IF
        IF x + LEN(s$) <= LEN(l$) THEN
            c = ASC(UCASE$(MID$(l$, x + LEN(s$), 1)))
            IF c >= 65 AND c <= 90 THEN whole = 0
            IF c >= 48 AND c <= 57 THEN whole = 0
        END IF
        IF whole = 0 THEN
            x1 = x + 1: IF idefindbackwards THEN x1 = x - 1
            x = 0
            IF x1 > 0 AND x1 <= LEN(l$) THEN GOTO idefindagain2
        END IF
    END IF
END IF

IF x THEN
    ideselect = 1
    idecx = x: idecy = y
    ideselectx1 = x + LEN(s$): ideselecty1 = y

    IF idefindinvert THEN
        IF idefindbackwards = 0 THEN idefindbackwards = 1 ELSE idefindbackwards = 0
        idefindinvert = 0
    END IF
    EXIT SUB
END IF

IF idefindbackwards THEN
    y = y - 1
    IF y = start - 1 AND looped = 1 THEN
        idenomatch
        IF idefindinvert THEN
            IF idefindbackwards = 0 THEN idefindbackwards = 1 ELSE idefindbackwards = 0
            idefindinvert = 0
        END IF
        EXIT SUB
    END IF
    IF y < 1 THEN y = iden: looped = 1
    GOTO idefindnext2
ELSE
    y = y + 1
    IF y = start + 1 AND looped = 1 THEN
        idenomatch
        IF idefindinvert THEN
            IF idefindbackwards = 0 THEN idefindbackwards = 1 ELSE idefindbackwards = 0
            idefindinvert = 0
        END IF
        EXIT SUB
    END IF
    IF y > iden THEN y = 1: looped = 1
    GOTO idefindnext2
END IF

END SUB

FUNCTION idegetline$ (i)
IF i <> -1 THEN idegotoline i
idegetline$ = MID$(idet$, ideli + 4, CVL(MID$(idet$, ideli, 4)))
END FUNCTION

SUB idegotoline (i)
IF idel = i THEN EXIT SUB
IF i < 1 THEN ERROR 5
'scan backwards
IF i < idel THEN
    DO
        idel = idel - 1
        ideli = ideli - CVL(MID$(idet$, ideli - 4, 4)) - 8
    LOOP UNTIL idel = i
    EXIT SUB
END IF
'assume scan forwards
DO
    IF idel = iden THEN idet$ = idet$ + MKL$(0) + MKL$(0): iden = iden + 1 'insert blank line at end?
    idel = idel + 1
    ideli = ideli + CVL(MID$(idet$, ideli, 4)) + 8
LOOP UNTIL idel = i
END SUB

FUNCTION idehbar (x, y, h, i2, n2)
i = i2: n = n2

'COLOR 0, 7
'LOCATE y, x: PRINT CHR$(27);
'LOCATE y, x + w - 1: PRINT CHR$(26);
'FOR x2 = x + 1 TO x + w - 2
'LOCATE y, x2: PRINT chr$(176);
'NEXT
'IF w > 3 THEN
'p2! = w - 2 - .00001
'x2 = x + 1 + INT(p2! * p!)
'LOCATE y, x2: PRINT chr$(219);
'END IF


'h is size in characters (inc. arrows)

'draw background & arrows
COLOR 0, 7
LOCATE y, x: PRINT CHR$(27);
LOCATE y, x + h - 1: PRINT CHR$(26);
FOR x2 = x + 1 TO x + h - 2
    LOCATE y, x2: PRINT chr$(176);
NEXT

'draw slider

IF n < 1 THEN n = 1
IF i < 1 THEN i = 1
IF i > n THEN i = n

IF h = 2 THEN
    idehbar = x 'not position for slider exists
    EXIT FUNCTION
END IF

IF h = 3 THEN
    idehbar = x + 1 'dummy value
    'no slider
    EXIT FUNCTION
END IF

IF h = 4 THEN
    IF n = 1 THEN
        idehbar = x + 1 'dummy value
        'no slider required for 1 item
        EXIT FUNCTION
    ELSE
        'show whichever is closer of the two positions
        p! = (i - 1) / (n - 1)
        IF p! < .5 THEN x2 = x + 1 ELSE x2 = x + 2
        LOCATE y, x2: PRINT chr$(219);
        idehbar = x2
        EXIT FUNCTION
    END IF
END IF

IF h > 4 THEN
    IF n = 1 THEN
        idehbar = x + h \ 4 'dummy value
        'no slider required for 1 item
        EXIT FUNCTION
    END IF
    IF i = 1 THEN
        x2 = x + 1
        LOCATE y, x2: PRINT chr$(219);
        idehbar = x2
        EXIT FUNCTION
    END IF
    IF i = n THEN
        x2 = x + h - 2
        LOCATE y, x2: PRINT chr$(219);
        idehbar = x2
        EXIT FUNCTION
    END IF
    'between i=1 and i=n
    p! = (i - 1) / (n - 1)
    p! = p! * (h - 4)
    x2 = x + 2 + INT(p!)
    LOCATE y, x2: PRINT chr$(219);
    idehbar = x2
    EXIT FUNCTION
END IF


END FUNCTION

FUNCTION idehlen (a$)
IF INSTR(a$, "#") THEN idehlen = LEN(a$) - 1 ELSE idehlen = LEN(a$)
END FUNCTION

SUB idehPRINT (a$)
COLOR 0, 7
FOR i = 1 TO LEN(a$)
    c$ = MID$(a$, i, 1)
    IF c$ = "#" THEN
        IF idehl THEN COLOR 15, 7
    ELSE
        PRINT c$;: COLOR 0, 7
    END IF
NEXT
END SUB

SUB ideinsline (i, text$)
'note: cursor remains on line i

FOR b = 1 TO IdeBmkN
    IF IdeBmk(b).y >= i THEN
        y = IdeBmk(b).y + 1
        IdeBmk(b).y = y
    END IF
NEXT

text$ = RTRIM$(text$)

IF i = -1 THEN i = idel
'if at end, use idesetline
IF i > iden THEN
    idesetline i, text$
    EXIT SUB
END IF
idegotoline i
'insert line
textlen = LEN(text$)
idet$ = LEFT$(idet$, ideli - 1) + MKL$(textlen) + text$ + MKL$(textlen) + RIGHT$(idet$, LEN(idet$) - ideli + 1)
iden = iden + 1
END SUB

SUB idenewsf (sf AS STRING)


'-------- generic dialog box header --------
PCOPY 0, 2
PCOPY 0, 1
SCREEN , , 1, 0
focus = 1
DIM p AS idedbptype
DIM o(1 TO 100) AS idedbotype
DIM oo AS idedbotype
DIM sep AS STRING * 1
sep = CHR$(0)
'-------- end of generic dialog box header --------

'-------- init --------

'built initial name if word selected
IF ideselect THEN
    IF ideselecty1 = idecy THEN 'single line selected
        a$ = idegetline(idecy)
        a2$ = ""
        sx1 = ideselectx1: sx2 = idecx
        IF sx2 < sx1 THEN SWAP sx1, sx2
        FOR x = sx1 TO sx2 - 1
            IF x <= LEN(a$) THEN a2$ = a2$ + MID$(a$, x, 1) ELSE a2$ = a2$ + " "
        NEXT
    END IF
END IF

i = 0

idepar p, 60, 5, "New " + sf$

i = i + 1
o(i).typ = 1
o(i).y = 2
o(i).nam = idenewtxt("#Name")
o(i).txt = idenewtxt(a2$)
if len(a2$) > 0 then o(i).issel = -1
o(i).sx1 = 0
o(i).v1 = LEN(a2$)

i = i + 1
o(i).typ = 3
o(i).y = 5
o(i).txt = idenewtxt("OK" + sep + "#Cancel")
o(i).dft = 1
'-------- end of init --------

'-------- generic init --------
FOR i = 1 TO 100: o(i).par = p: NEXT 'set parent info of objects
'-------- end of generic init --------

DO 'main loop


    '-------- generic display dialog box & objects --------
    idedrawpar p
    f = 1: cx = 0: cy = 0
    FOR i = 1 TO 100
        IF o(i).typ THEN

            'prepare object
            o(i).foc = focus - f 'focus offset
            o(i).cx = 0: o(i).cy = 0
            idedrawobj o(i), f 'display object
            IF o(i).cx THEN cx = o(i).cx: cy = o(i).cy
        END IF
    NEXT i
    lastfocus = f - 1
    '-------- end of generic display dialog box & objects --------

    '-------- custom display changes --------
    '-------- end of custom display changes --------

    'update visual page and cursor position
    PCOPY 1, 0
    IF cx THEN SCREEN , , 0, 0: LOCATE cy, cx, 1: SCREEN , , 1, 0

    '-------- read input --------
    change = 0
    DO
        GetInput
        IF mWHEEL THEN change = 1
        IF KB THEN change = 1
        IF mCLICK THEN mousedown = 1: change = 1
        IF mRELEASE THEN mouseup = 1: change = 1
        IF mB THEN change = 1
        alt = KALT: IF alt <> oldalt THEN change = 1
        oldalt = alt
        _LIMIT 100
    LOOP UNTIL change
    IF alt THEN idehl = 1 ELSE idehl = 0
    'convert "alt+letter" scancode to letter's ASCII character
    altletter$ = ""
    IF alt THEN
        IF LEN(K$) = 1 THEN
            k = ASC(UCASE$(K$))
            IF k >= 65 AND k <= 90 THEN altletter$ = CHR$(k)
        END IF
    END IF
    SCREEN , , 0, 0: LOCATE , , 0: SCREEN , , 1, 0
    '-------- end of read input --------

    '-------- generic input response --------
    info = 0
    IF K$ = "" THEN K$ = CHR$(255)
    IF KSHIFT = 0 AND K$ = CHR$(9) THEN focus = focus + 1
    IF KSHIFT AND K$ = CHR$(9) THEN focus = focus - 1
    IF focus < 1 THEN focus = lastfocus
    IF focus > lastfocus THEN focus = 1
    f = 1
    FOR i = 1 TO 100
        t = o(i).typ
        IF t THEN
            focusoffset = focus - f
            ideobjupdate o(i), focus, f, focusoffset, K$, altletter$, mB, mousedown, mouseup, mX, mY, info, mWHEEL
        END IF
    NEXT
    '-------- end of generic input response --------

    'specific post controls

    IF K$ = CHR$(27) OR (focus = 3 AND info <> 0) THEN
        EXIT SUB
    END IF

    IF K$ = CHR$(13) OR (focus = 2 AND info <> 0) THEN
        y = iden
        y = y + 1: idesetline y, ""
        y = y + 1: idesetline y, sf$ + " " + idetxt(o(1).txt)
        idesy = y
        y = y + 1: idesetline y, ""
        idecy = y
        y = y + 1: idesetline y, "END " + sf$
        idecx = 1: idesx = 1
        idechangemade = 1
        EXIT SUB
    END IF

    'end of custom controls

    mousedown = 0
    mouseup = 0
LOOP



END SUB

FUNCTION idenewtxt (a$)
idetxtlast = idetxtlast + 1
idetxt$(idetxtlast) = a$
idenewtxt = idetxtlast
END FUNCTION

SUB idenomatch

'-------- generic dialog box header --------
PCOPY 3, 0
PCOPY 0, 2
PCOPY 0, 1
SCREEN , , 1, 0
focus = 1
DIM p AS idedbptype
DIM o(1 TO 100) AS idedbotype
DIM oo AS idedbotype
DIM sep AS STRING * 1
sep = CHR$(0)
'-------- end of generic dialog box header --------

'-------- init --------
i = 0
idepar p, 19, 4, ""
i = i + 1
o(i).typ = 3
o(i).y = 4
o(i).txt = idenewtxt("OK")
o(i).dft = 1
'-------- end of init --------

'-------- generic init --------
FOR i = 1 TO 100: o(i).par = p: NEXT 'set parent info of objects
'-------- end of generic init --------

DO 'main loop

    '-------- generic display dialog box & objects --------
    idedrawpar p
    f = 1: cx = 0: cy = 0
    FOR i = 1 TO 100
        IF o(i).typ THEN
            'prepare object
            o(i).foc = focus - f 'focus offset
            o(i).cx = 0: o(i).cy = 0
            idedrawobj o(i), f 'display object
            IF o(i).cx THEN cx = o(i).cx: cy = o(i).cy
        END IF
    NEXT i
    lastfocus = f - 1
    '-------- end of generic display dialog box & objects --------

    '-------- custom display changes --------
    COLOR 0, 7: LOCATE p.y + 2, p.x + 3: PRINT "Match not found";
    '-------- end of custom display changes --------

    'update visual page and cursor position
    PCOPY 1, 0
    IF cx THEN SCREEN , , 0, 0: LOCATE cy, cx, 1: SCREEN , , 1, 0

    '-------- read input --------
    change = 0
    DO
        GetInput
        IF mWHEEL THEN change = 1
        IF KB THEN change = 1
        IF mCLICK THEN mousedown = 1: change = 1
        IF mRELEASE THEN mouseup = 1: change = 1
        IF mB THEN change = 1
        alt = KALT: IF alt <> oldalt THEN change = 1
        oldalt = alt
        _LIMIT 100
    LOOP UNTIL change
    IF alt THEN idehl = 1 ELSE idehl = 0
    'convert "alt+letter" scancode to letter's ASCII character
    altletter$ = ""
    IF alt THEN
        IF LEN(K$) = 1 THEN
            k = ASC(UCASE$(K$))
            IF k >= 65 AND k <= 90 THEN altletter$ = CHR$(k)
        END IF
    END IF
    SCREEN , , 0, 0: LOCATE , , 0: SCREEN , , 1, 0
    '-------- end of read input --------

    IF UCASE$(K$) = "Y" THEN altletter$ = "Y"
    IF UCASE$(K$) = "N" THEN altletter$ = "N"

    '-------- generic input response --------
    info = 0
    IF K$ = "" THEN K$ = CHR$(255)
    IF KSHIFT = 0 AND K$ = CHR$(9) THEN focus = focus + 1
    IF KSHIFT AND K$ = CHR$(9) THEN focus = focus - 1
    IF focus < 1 THEN focus = lastfocus
    IF focus > lastfocus THEN focus = 1
    f = 1
    FOR i = 1 TO 100
        t = o(i).typ
        IF t THEN
            focusoffset = focus - f
            ideobjupdate o(i), focus, f, focusoffset, K$, altletter$, mB, mousedown, mouseup, mX, mY, info, mWHEEL
        END IF
    NEXT
    '-------- end of generic input response --------

    IF K$ = CHR$(27) THEN
        EXIT SUB
    END IF

    IF info THEN
        EXIT SUB
    END IF

    'end of custom controls

    mousedown = 0
    mouseup = 0
LOOP

END SUB

FUNCTION ideopen$
STATIC AllFiles

'-------- generic dialog box header --------
PCOPY 0, 2
PCOPY 0, 1
SCREEN , , 1, 0
focus = 1
DIM p AS idedbptype
DIM o(1 TO 100) AS idedbotype
DIM oo AS idedbotype
DIM sep AS STRING * 1
sep = CHR$(0)
'-------- end of generic dialog box header --------

'-------- init --------
path$ = idepath$
filelist$ = idezfilelist$(path$, AllFiles)
pathlist$ = idezpathlist$(path$)

i = 0
idepar p, 70, idewy + idesubwindow - 7, "Open"
i = i + 1
o(i).typ = 1
o(i).y = 2
o(i).nam = idenewtxt("File #Name")
i = i + 1
o(i).typ = 2
o(i).y = 5
o(i).w = 32: o(i).h = idewy + idesubwindow - 14
o(i).nam = idenewtxt("#Files")
o(i).txt = idenewtxt(filelist$): filelist$ = ""
i = i + 1
o(i).typ = 2
o(i).x = 37: o(i).y = 5
o(i).w = 31: o(i).h = idewy + idesubwindow - 16
o(i).nam = idenewtxt("#Paths")
o(i).txt = idenewtxt(pathlist$): pathlist$ = ""
i = i + 1
o(i).typ = 4 'check box
o(i).x = 37
o(i).y = idewy + idesubwindow - 9
o(i).nam = idenewtxt(".BAS Only")
IF AllFiles THEN o(i).sel = 0 ELSE o(i).sel = 1
i = i + 1
o(i).typ = 3
o(i).y = idewy + idesubwindow - 7
o(i).txt = idenewtxt("OK" + sep + "#Cancel")
o(i).dft = 1
'-------- end of init --------

'-------- generic init --------
FOR i = 1 TO 100: o(i).par = p: NEXT 'set parent info of objects
'-------- end of generic init --------

IF LEN(IdeOpenFile) THEN f$ = IdeOpenFile: GOTO DirectLoad

DO 'main loop

    '-------- generic display dialog box & objects --------
    idedrawpar p
    f = 1: cx = 0: cy = 0
    FOR i = 1 TO 100
        IF o(i).typ THEN
            'prepare object
            o(i).foc = focus - f 'focus offset
            o(i).cx = 0: o(i).cy = 0
            idedrawobj o(i), f 'display object
            IF o(i).cx THEN cx = o(i).cx: cy = o(i).cy
        END IF
    NEXT i
    lastfocus = f - 1
    '-------- end of generic display dialog box & objects --------

    '-------- custom display changes --------
    COLOR 0, 7: LOCATE p.y + 4, p.x + 2: PRINT "Path: ";
    a$ = path$
    w = p.w - 8
    IF LEN(a$) > w - 3 THEN a$ = string$(3, 250) + RIGHT$(a$, w - 3)
    PRINT a$;
    '-------- end of custom display changes --------


    'update visual page and cursor position
    PCOPY 1, 0
    IF cx THEN SCREEN , , 0, 0: LOCATE cy, cx, 1: SCREEN , , 1, 0

    '-------- read input --------
    change = 0
    DO
        GetInput
        IF mWHEEL THEN change = 1
        IF KB THEN change = 1
        IF mCLICK THEN mousedown = 1: change = 1
        IF mRELEASE THEN mouseup = 1: change = 1
        IF mB THEN change = 1
        alt = KALT: IF alt <> oldalt THEN change = 1
        oldalt = alt
        _LIMIT 100
    LOOP UNTIL change
    IF alt THEN idehl = 1 ELSE idehl = 0
    'convert "alt+letter" scancode to letter's ASCII character
    altletter$ = ""
    IF alt THEN
        IF LEN(K$) = 1 THEN
            k = ASC(UCASE$(K$))
            IF k >= 65 AND k <= 90 THEN altletter$ = CHR$(k)
        END IF
    END IF
    SCREEN , , 0, 0: LOCATE , , 0: SCREEN , , 1, 0
    '-------- end of read input --------

    '-------- generic input response --------
    info = 0
    IF K$ = "" THEN K$ = CHR$(255)
    IF KSHIFT = 0 AND K$ = CHR$(9) THEN focus = focus + 1
    IF KSHIFT AND K$ = CHR$(9) THEN focus = focus - 1
    IF focus < 1 THEN focus = lastfocus
    IF focus > lastfocus THEN focus = 1
    f = 1
    FOR i = 1 TO 100
        t = o(i).typ
        IF t THEN
            focusoffset = focus - f
            ideobjupdate o(i), focus, f, focusoffset, K$, altletter$, mB, mousedown, mouseup, mX, mY, info, mWHEEL
        END IF
    NEXT
    '-------- end of generic input response --------










    'specific post controls

    IF AllFiles = 1 AND o(4).sel <> 0 THEN
        AllFiles = 0
        idetxt(o(2).txt) = idezfilelist$(path$, AllFiles)
        o(2).sel = -1
        GOTO ideopenloop
    END IF
    IF AllFiles = 0 AND o(4).sel = 0 THEN
        AllFiles = 1
        idetxt(o(2).txt) = idezfilelist$(path$, AllFiles)
        o(2).sel = -1
        GOTO ideopenloop
    END IF

    IF K$ = CHR$(27) OR (focus = 6 AND info <> 0) THEN
        ideopen$ = "C"
        EXIT FUNCTION
    END IF

    IF idetxt(o(2).stx) <> "" THEN
        idetxt(o(1).txt) = idetxt(o(2).stx)
        o(1).v1 = LEN(idetxt(o(1).txt))
    END IF

    IF focus = 3 THEN
        IF K$ = CHR$(13) OR info = 1 THEN

            path$ = idezchangepath(path$, idetxt(o(3).stx))
            idetxt(o(2).txt) = idezfilelist$(path$, AllFiles)
            idetxt(o(3).txt) = idezpathlist$(path$)

            o(2).sel = -1
            o(3).sel = 1
            IF info = 1 THEN o(3).sel = -1
            GOTO ideopenloop
        END IF
    END IF

    'load file
    IF K$ = CHR$(13) OR (info = 1 AND focus = 2) OR (focus = 5 AND info <> 0) THEN
        f$ = idetxt(o(1).txt)

        'change path?
        IF f$ = ".." OR f$ = "." THEN f$ = f$ + idepathsep$
        IF RIGHT$(f$, 1) = idepathsep$ THEN
            path$ = idezgetfilepath$(path$, f$) 'note: path ending with pathsep needn't contain a file
            idetxt(o(1).txt) = ""
            idetxt(o(2).txt) = idezfilelist$(path$, AllFiles)
            o(2).sel = -1
            idetxt(o(3).txt) = idezpathlist$(path$)
            o(3).sel = -1
            GOTO ideopenloop
        END IF

        'add .bas if not given
        IF (LCASE$(RIGHT$(f$, 4)) <> ".bas") AND AllFiles = 0 THEN f$ = f$ + ".bas"

        DirectLoad:

        'check/acquire file path
        path$ = idezgetfilepath$(path$, f$)
        'check file exists
        ideerror = 2
        OPEN path$ + idepathsep$ + f$ FOR INPUT AS #150: CLOSE #150
        'load file
        ideerror = 3
        idet$ = MKL$(0) + MKL$(0): idel = 1: ideli = 1: iden = 1: IdeBmkN = 0
        idesx = 1
        idesy = 1
        idecx = 1
        idecy = 1
        ideselect = 0
        lineinput3load path$ + idepathsep$ + f$
        idet$ = SPACE$(LEN(lineinput3buffer) * 8)
        i2 = 1
        n = 0
        chrtab$ = CHR$(9)
        space1$ = " ": space2$ = "  ": space3$ = "   ": space4$ = "    "
        chr7$ = CHR$(7): chr11$ = CHR$(11): chr12$ = CHR$(12): chr28$ = CHR$(28): chr29$ = CHR$(29): chr30$ = CHR$(30): chr31$ = CHR$(31)
        DO
            a$ = lineinput3$
            l = LEN(a$)
            IF l THEN asca = ASC(a$) ELSE asca = -1
            IF asca <> 13 THEN
                IF asca <> -1 THEN
                    'fix tabs
                    ideopenfixtabs:
                    x = INSTR(a$, chrtab$)
                    IF x THEN
                        x2 = (x - 1) MOD 4
                        IF x2 = 0 THEN a$ = LEFT$(a$, x - 1) + space4$ + RIGHT$(a$, l - x): l = l + 3: GOTO ideopenfixtabs
                        IF x2 = 1 THEN a$ = LEFT$(a$, x - 1) + space3$ + RIGHT$(a$, l - x): l = l + 2: GOTO ideopenfixtabs
                        IF x2 = 2 THEN a$ = LEFT$(a$, x - 1) + space2$ + RIGHT$(a$, l - x): l = l + 1: GOTO ideopenfixtabs
                        IF x2 = 3 THEN a$ = LEFT$(a$, x - 1) + space1$ + RIGHT$(a$, l - x): GOTO ideopenfixtabs
                    END IF
                END IF 'asca<>-1
                MID$(idet$, i2, l + 8) = MKL$(l) + a$ + MKL$(l): i2 = i2 + l + 8: n = n + 1
            END IF
        LOOP UNTIL asca = 13
        lineinput3buffer = ""
        iden = n: IF n = 0 THEN idet$ = MKL$(0) + MKL$(0): iden = 1 ELSE idet$ = LEFT$(idet$, i2 - 1)
        ideerror = 1
        ideprogname = f$: _TITLE ideprogname + " - QB64"
        idepath$ = path$
        IdeAddRecent idepath$ + idepathsep$ + ideprogname$
        IdeImportBookmarks idepath$ + idepathsep$ + ideprogname$
        EXIT FUNCTION
    END IF

    ideopenloop:

    'end of custom controls
    mousedown = 0
    mouseup = 0
LOOP
END FUNCTION

SUB idepar (par AS idedbptype, w, h, title$)
par.x = (idewx \ 2) - w \ 2
par.y = ((idewy + idesubwindow) \ 2) - h \ 2
par.w = w
par.h = h
IF LEN(title$) THEN par.nam = idenewtxt(title$)
END SUB

FUNCTION iderestore$

'-------- generic dialog box header --------
PCOPY 3, 0
PCOPY 0, 2
PCOPY 0, 1
SCREEN , , 1, 0
focus = 1
DIM p AS idedbptype
DIM o(1 TO 100) AS idedbotype
DIM oo AS idedbotype
DIM sep AS STRING * 1
sep = CHR$(0)
'-------- end of generic dialog box header --------

'-------- init --------
i = 0
'idepar p, 30, 6, "File already exists. Overwrite?"
idepar p, 43, 4, ""
i = i + 1
o(i).typ = 3
o(i).y = 4
o(i).txt = idenewtxt("#Yes" + sep + "#No")
o(i).dft = 1
'-------- end of init --------

'-------- generic init --------
FOR i = 1 TO 100: o(i).par = p: NEXT 'set parent info of objects
'-------- end of generic init --------

DO 'main loop

    '-------- generic display dialog box & objects --------
    idedrawpar p
    f = 1: cx = 0: cy = 0
    FOR i = 1 TO 100
        IF o(i).typ THEN
            'prepare object
            o(i).foc = focus - f 'focus offset
            o(i).cx = 0: o(i).cy = 0
            idedrawobj o(i), f 'display object
            IF o(i).cx THEN cx = o(i).cx: cy = o(i).cy
        END IF
    NEXT i
    lastfocus = f - 1
    '-------- end of generic display dialog box & objects --------

    '-------- custom display changes --------
    COLOR 0, 7: LOCATE p.y + 2, p.x + 3: PRINT "Recover program from auto-saved backup?";
    '-------- end of custom display changes --------

    'update visual page and cursor position
    PCOPY 1, 0
    IF cx THEN SCREEN , , 0, 0: LOCATE cy, cx, 1: SCREEN , , 1, 0

    '-------- read input --------
    change = 0
    DO
        GetInput
        IF mWHEEL THEN change = 1
        IF KB THEN change = 1
        IF mCLICK THEN mousedown = 1: change = 1
        IF mRELEASE THEN mouseup = 1: change = 1
        IF mB THEN change = 1
        alt = KALT: IF alt <> oldalt THEN change = 1
        oldalt = alt
        _LIMIT 100
    LOOP UNTIL change
    IF alt THEN idehl = 1 ELSE idehl = 0
    'convert "alt+letter" scancode to letter's ASCII character
    altletter$ = ""
    IF alt THEN
        IF LEN(K$) = 1 THEN
            k = ASC(UCASE$(K$))
            IF k >= 65 AND k <= 90 THEN altletter$ = CHR$(k)
        END IF
    END IF
    SCREEN , , 0, 0: LOCATE , , 0: SCREEN , , 1, 0
    '-------- end of read input --------

    IF UCASE$(K$) = "Y" THEN altletter$ = "Y"
    IF UCASE$(K$) = "N" THEN altletter$ = "N"

    '-------- generic input response --------
    info = 0
    IF K$ = "" THEN K$ = CHR$(255)
    IF KSHIFT = 0 AND K$ = CHR$(9) THEN focus = focus + 1
    IF KSHIFT AND K$ = CHR$(9) THEN focus = focus - 1
    IF focus < 1 THEN focus = lastfocus
    IF focus > lastfocus THEN focus = 1
    f = 1
    FOR i = 1 TO 100
        t = o(i).typ
        IF t THEN
            focusoffset = focus - f
            ideobjupdate o(i), focus, f, focusoffset, K$, altletter$, mB, mousedown, mouseup, mX, mY, info, mWHEEL
        END IF
    NEXT
    '-------- end of generic input response --------

    IF info THEN
        IF info = 1 THEN iderestore$ = "Y" ELSE iderestore$ = "N"
        EXIT FUNCTION
    END IF

    'end of custom controls
    mousedown = 0
    mouseup = 0
LOOP

END FUNCTION

FUNCTION ideclearhistory$(WhichHistory$)

'-------- generic dialog box header --------
PCOPY 3, 0
PCOPY 0, 2
PCOPY 0, 1
SCREEN , , 1, 0
focus = 1
DIM p AS idedbptype
DIM o(1 TO 100) AS idedbotype
DIM oo AS idedbotype
DIM sep AS STRING * 1
sep = CHR$(0)
'-------- end of generic dialog box header --------

'-------- init --------
i = 0
'idepar p, 30, 6, "File already exists. Overwrite?"
idepar p, 48, 4, ""
i = i + 1
o(i).typ = 3
o(i).y = 4
o(i).txt = idenewtxt("#Yes" + sep + "#No")
o(i).dft = 1
'-------- end of init --------

'-------- generic init --------
FOR i = 1 TO 100: o(i).par = p: NEXT 'set parent info of objects
'-------- end of generic init --------

DO 'main loop

    '-------- generic display dialog box & objects --------
    idedrawpar p
    f = 1: cx = 0: cy = 0
    FOR i = 1 TO 100
        IF o(i).typ THEN
            'prepare object
            o(i).foc = focus - f 'focus offset
            o(i).cx = 0: o(i).cy = 0
            idedrawobj o(i), f 'display object
            IF o(i).cx THEN cx = o(i).cx: cy = o(i).cy
        END IF
    NEXT i
    lastfocus = f - 1
    '-------- end of generic display dialog box & objects --------

    '-------- custom display changes --------
    COLOR 0, 7: LOCATE p.y + 2, p.x + 3
    SELECT CASE WhichHistory$
        CASE "SEARCH": PRINT  "This cannot be undone. Clear search history?";
        CASE "FILES": PRINT   " This cannot be undone. Clear recent files?";
        CASE "INVALID": PRINT "  Remove broken links from recent files?";
    END SELECT
    '-------- end of custom display changes --------

    'update visual page and cursor position
    PCOPY 1, 0
    IF cx THEN SCREEN , , 0, 0: LOCATE cy, cx, 1: SCREEN , , 1, 0

    '-------- read input --------
    change = 0
    DO
        GetInput
        IF mWHEEL THEN change = 1
        IF KB THEN change = 1
        IF mCLICK THEN mousedown = 1: change = 1
        IF mRELEASE THEN mouseup = 1: change = 1
        IF mB THEN change = 1
        alt = KALT: IF alt <> oldalt THEN change = 1
        oldalt = alt
        _LIMIT 100
    LOOP UNTIL change
    IF alt THEN idehl = 1 ELSE idehl = 0
    'convert "alt+letter" scancode to letter's ASCII character
    altletter$ = ""
    IF alt THEN
        IF LEN(K$) = 1 THEN
            k = ASC(UCASE$(K$))
            IF k >= 65 AND k <= 90 THEN altletter$ = CHR$(k)
        END IF
    END IF
    SCREEN , , 0, 0: LOCATE , , 0: SCREEN , , 1, 0
    '-------- end of read input --------

    IF UCASE$(K$) = "Y" THEN altletter$ = "Y"
    IF UCASE$(K$) = "N" THEN altletter$ = "N"

    '-------- generic input response --------
    info = 0
    IF K$ = "" THEN K$ = CHR$(255)
    IF KSHIFT = 0 AND K$ = CHR$(9) THEN focus = focus + 1
    IF KSHIFT AND K$ = CHR$(9) THEN focus = focus - 1
    IF focus < 1 THEN focus = lastfocus
    IF focus > lastfocus THEN focus = 1
    f = 1
    FOR i = 1 TO 100
        t = o(i).typ
        IF t THEN
            focusoffset = focus - f
            ideobjupdate o(i), focus, f, focusoffset, K$, altletter$, mB, mousedown, mouseup, mX, mY, info, mWHEEL
        END IF
    NEXT
    '-------- end of generic input response --------

    IF info THEN
        IF info = 1 THEN ideclearhistory$ = "Y" ELSE ideclearhistory$ = "N"
        EXIT FUNCTION
    END IF

    IF K$ = CHR$(27) THEN
        ideclearhistory$ = "N"
        EXIT FUNCTION
    END IF

    'end of custom controls
    mousedown = 0
    mouseup = 0
LOOP

END FUNCTION

SUB idesave (f$)
OPEN f$ FOR OUTPUT AS #151
FOR i = 1 TO iden
    a$ = idegetline(i)
    PRINT #151, a$
NEXT
CLOSE #151
IdeSaveBookmarks f$
ideunsaved = 0
END SUB

FUNCTION idesaveas$ (programname$)
'-------- generic dialog box header --------
PCOPY 0, 2
PCOPY 0, 1
SCREEN , , 1, 0
focus = 1
DIM p AS idedbptype
DIM o(1 TO 100) AS idedbotype
DIM oo AS idedbotype
DIM sep AS STRING * 1
sep = CHR$(0)
'-------- end of generic dialog box header --------

'-------- init --------
path$ = idepath$
pathlist$ = idezpathlist$(path$)

i = 0
idepar p, 48, idewy + idesubwindow - 7, "Save As"

i = i + 1
o(i).typ = 1
o(i).y = 2
o(i).nam = idenewtxt("File #Name")
o(i).txt = idenewtxt(programname$)
o(i).issel = -1
o(i).sx1 = 0
o(i).v1 = LEN(programname$)

'i = i + 1
'o(i).typ = 2
'o(i).y = 5
'o(i).w = 32: o(i).h = 11
'o(i).nam = idenewtxt("#Files")
'o(i).txt = idenewtxt(filelist$): filelist$ = ""

i = i + 1
o(i).typ = 2
'o(i).x = 10:
o(i).y = 5
o(i).w = 44: o(i).h = idewy + idesubwindow - 14
o(i).nam = idenewtxt("#Paths")
o(i).txt = idenewtxt(pathlist$): pathlist$ = ""

i = i + 1
o(i).typ = 3
o(i).y = idewy + idesubwindow - 7
o(i).txt = idenewtxt("OK" + sep + "#Cancel")
o(i).dft = 1
'-------- end of init --------

'-------- generic init --------
FOR i = 1 TO 100: o(i).par = p: NEXT 'set parent info of objects
'-------- end of generic init --------

DO 'main loop

    '-------- generic display dialog box & objects --------
    idedrawpar p
    f = 1: cx = 0: cy = 0
    FOR i = 1 TO 100
        IF o(i).typ THEN
            'prepare object
            o(i).foc = focus - f 'focus offset
            o(i).cx = 0: o(i).cy = 0
            idedrawobj o(i), f 'display object
            IF o(i).cx THEN cx = o(i).cx: cy = o(i).cy
        END IF
    NEXT i
    lastfocus = f - 1
    '-------- end of generic display dialog box & objects --------

    '-------- custom display changes --------
    COLOR 0, 7: LOCATE p.y + 4, p.x + 2: PRINT "Path: ";
    a$ = path$
    w = p.w - 8
    IF LEN(a$) > w - 3 THEN a$ = string$(3, 250) + RIGHT$(a$, w - 3)
    PRINT a$;
    '-------- end of custom display changes --------

    'update visual page and cursor position
    PCOPY 1, 0
    IF cx THEN SCREEN , , 0, 0: LOCATE cy, cx, 1: SCREEN , , 1, 0

    '-------- read input --------
    change = 0
    DO
        GetInput
        IF mWHEEL THEN change = 1
        IF KB THEN change = 1
        IF mCLICK THEN mousedown = 1: change = 1
        IF mRELEASE THEN mouseup = 1: change = 1
        IF mB THEN change = 1
        alt = KALT: IF alt <> oldalt THEN change = 1
        oldalt = alt
        _LIMIT 100
    LOOP UNTIL change
    IF alt THEN idehl = 1 ELSE idehl = 0
    'convert "alt+letter" scancode to letter's ASCII character
    altletter$ = ""
    IF alt THEN
        IF LEN(K$) = 1 THEN
            k = ASC(UCASE$(K$))
            IF k >= 65 AND k <= 90 THEN altletter$ = CHR$(k)
        END IF
    END IF
    SCREEN , , 0, 0: LOCATE , , 0: SCREEN , , 1, 0
    '-------- end of read input --------

    '-------- generic input response --------
    info = 0
    IF K$ = "" THEN K$ = CHR$(255)
    IF KSHIFT = 0 AND K$ = CHR$(9) THEN focus = focus + 1
    IF KSHIFT AND K$ = CHR$(9) THEN focus = focus - 1
    IF focus < 1 THEN focus = lastfocus
    IF focus > lastfocus THEN focus = 1
    f = 1
    FOR i = 1 TO 100
        t = o(i).typ
        IF t THEN
            focusoffset = focus - f
            ideobjupdate o(i), focus, f, focusoffset, K$, altletter$, mB, mousedown, mouseup, mX, mY, info, mWHEEL
        END IF
    NEXT
    '-------- end of generic input response --------


    IF K$ = CHR$(27) OR (focus = 4 AND info <> 0) THEN
        idesaveas$ = "C"
        EXIT FUNCTION
    END IF

    IF focus = 2 THEN
        IF K$ = CHR$(13) OR info = 1 THEN
            path$ = idezchangepath(path$, idetxt(o(2).stx))
            idetxt(o(2).txt) = idezpathlist$(path$)
            o(2).sel = 1
            IF info = 1 THEN o(2).sel = -1
        END IF
    END IF

    IF (K$ = CHR$(13) AND focus <> 2) OR (focus = 3 AND info <> 0) THEN
        f$ = idetxt(o(1).txt)

        'change path?
        IF f$ = ".." OR f$ = "." THEN f$ = f$ + idepathsep$
        IF RIGHT$(f$, 1) = idepathsep$ THEN
            path$ = idezgetfilepath$(path$, f$) 'note: path ending with pathsep needn't contain a file
            idetxt(o(1).txt) = ""
            idetxt(o(2).txt) = idezpathlist$(path$)
            o(2).sel = -1
            GOTO idesaveasloop
        END IF

        IF FileHasExtension(f$) = 0 THEN f$ = f$ + ".bas"

        path$ = idezgetfilepath$(path$, f$)
        ideerror = 3
        OPEN path$ + idepathsep$ + f$ FOR BINARY AS #150
        ideerror = 1
        IF LOF(150) THEN
            CLOSE #150
            a$ = idefileexists
            IF a$ = "N" THEN
                idesaveas$ = "C"
                EXIT FUNCTION 'user didn't agree to overwrite
            END IF
        ELSE
            CLOSE #150
        END IF
        ideprogname$ = f$: _TITLE ideprogname + " - QB64"
        idesave path$ + idepathsep$ + f$
        idepath$ = path$
        IdeAddRecent idepath$ + idepathsep$ + ideprogname$
        IdeSaveBookmarks idepath$ + idepathsep$ + ideprogname$
        EXIT FUNCTION
    END IF

    idesaveasloop:

    'end of custom controls
    mousedown = 0
    mouseup = 0
LOOP

END FUNCTION

FUNCTION idesavenow$

'-------- generic dialog box header --------
PCOPY 3, 0
PCOPY 0, 2
PCOPY 0, 1
SCREEN , , 1, 0
focus = 1
DIM p AS idedbptype
DIM o(1 TO 100) AS idedbotype
DIM oo AS idedbotype
DIM sep AS STRING * 1
sep = CHR$(0)
'-------- end of generic dialog box header --------

'-------- init --------
i = 0
idepar p, 40, 4, ""
i = i + 1
o(i).typ = 3
o(i).y = 4
o(i).txt = idenewtxt("#Yes" + sep + "#No" + sep + "#Cancel")
o(i).dft = 1
'-------- end of init --------

'-------- generic init --------
FOR i = 1 TO 100: o(i).par = p: NEXT 'set parent info of objects
'-------- end of generic init --------

DO 'main loop

    '-------- generic display dialog box & objects --------
    idedrawpar p
    f = 1: cx = 0: cy = 0
    FOR i = 1 TO 100
        IF o(i).typ THEN
            'prepare object
            o(i).foc = focus - f 'focus offset
            o(i).cx = 0: o(i).cy = 0
            idedrawobj o(i), f 'display object
            IF o(i).cx THEN cx = o(i).cx: cy = o(i).cy
        END IF
    NEXT i
    lastfocus = f - 1
    '-------- end of generic display dialog box & objects --------

    '-------- custom display changes --------
    COLOR 0, 7: LOCATE p.y + 2, p.x + 4: PRINT "Program is not saved. Save it now?";
    '-------- end of custom display changes --------

    'update visual page and cursor position
    PCOPY 1, 0
    IF cx THEN SCREEN , , 0, 0: LOCATE cy, cx, 1: SCREEN , , 1, 0


    '-------- read input --------
    change = 0
    DO
        GetInput
        IF mWHEEL THEN change = 1
        IF KB THEN change = 1
        IF mCLICK THEN mousedown = 1: change = 1
        IF mRELEASE THEN mouseup = 1: change = 1
        IF mB THEN change = 1
        alt = KALT: IF alt <> oldalt THEN change = 1
        oldalt = alt
        _LIMIT 100
    LOOP UNTIL change
    IF alt THEN idehl = 1 ELSE idehl = 0
    'convert "alt+letter" scancode to letter's ASCII character
    altletter$ = ""
    IF alt THEN
        IF LEN(K$) = 1 THEN
            k = ASC(UCASE$(K$))
            IF k >= 65 AND k <= 90 THEN altletter$ = CHR$(k)
        END IF
    END IF
    SCREEN , , 0, 0: LOCATE , , 0: SCREEN , , 1, 0
    '-------- end of read input --------

    IF UCASE$(K$) = "Y" THEN altletter$ = "Y"
    IF UCASE$(K$) = "N" THEN altletter$ = "N"
    IF UCASE$(K$) = "C" THEN altletter$ = "C"

    '-------- generic input response --------
    info = 0
    IF K$ = "" THEN K$ = CHR$(255)
    IF KSHIFT = 0 AND K$ = CHR$(9) THEN focus = focus + 1
    IF KSHIFT AND K$ = CHR$(9) THEN focus = focus - 1
    IF focus < 1 THEN focus = lastfocus
    IF focus > lastfocus THEN focus = 1
    f = 1
    FOR i = 1 TO 100
        t = o(i).typ
        IF t THEN
            focusoffset = focus - f
            ideobjupdate o(i), focus, f, focusoffset, K$, altletter$, mB, mousedown, mouseup, mX, mY, info, mWHEEL
        END IF
    NEXT
    '-------- end of generic input response --------

    IF K$ = CHR$(27) THEN
        idesavenow$ = "C"
        EXIT FUNCTION
    END IF

    IF info THEN
        IF info = 1 THEN idesavenow$ = "Y"
        IF info = 2 THEN idesavenow$ = "N"
        IF info = 3 THEN idesavenow$ = "C"
        EXIT FUNCTION
    END IF

    'end of custom controls
    mousedown = 0
    mouseup = 0
LOOP

END FUNCTION

SUB idesetline (i, text$)

text$ = RTRIM$(text$)

IF i <> -1 THEN idegotoline i
textlen = LEN(text$)
idet$ = LEFT$(idet$, ideli - 1) + MKL$(textlen) + text$ + MKL$(textlen) + RIGHT$(idet$, LEN(idet$) - ideli + 1 - CVL(MID$(idet$, ideli, 4)) - 8)

END SUB

SUB ideshowtext

_palettecolor 1, IDEBackgroundColor, 0
_palettecolor 6, IDEBackgroundColor2, 0
_palettecolor 11, IDECommentColor, 0
_palettecolor 10, IDEMetaCommandColor, 0
_palettecolor 14, IDEQuoteColor, 0
_palettecolor 13, IDETextColor, 0

cc = -1

IF idecx < idesx THEN idesx = idecx
IF idecy < idesy THEN idesy = idecy
IF idecx - idesx >= (idewx - 2) THEN idesx = idecx - (idewx - 3)
IF idecy - idesy >= (idewy - 8) THEN idesy = idecy - (idewy - 9)

sy1 = ideselecty1
sy2 = idecy
IF sy1 > sy2 THEN SWAP sy1, sy2
sx1 = ideselectx1
sx2 = idecx
IF sx1 > sx2 THEN SWAP sx1, sx2

l = idesy

idecy_multilinestart = 0
idecy_multilineend = 0
a$ = idegetline(idecy)
IF RIGHT$(a$, 1) = "_" THEN
    'Find the beginning of the multiline
    FOR idecy_i = idecy - 1 TO 1 STEP -1
        b$ = idegetline(idecy_i)
        IF RIGHT$(b$, 1) <> "_" THEN idecy_multilinestart = idecy_i + 1: EXIT FOR
    NEXT
    IF idecy_multilinestart = 0 THEN idecy_multilinestart = 1

    'Find the end of the multiline
    FOR idecy_i = idecy + 1 TO iden
        b$ = idegetline(idecy_i)
        IF RIGHT$(b$, 1) <> "_" THEN idecy_multilineend = idecy_i: EXIT FOR
    NEXT
    IF idecy_multilineend = 0 THEN idecy_multilinestart = iden
ELSE
    IF idecy > 1 THEN b$ = idegetline(idecy - 1) ELSE b$ = ""
    IF RIGHT$(b$, 1) = "_" THEN
        idecy_multilineend = idecy

        'Find the beginning of the multiline
        FOR idecy_i = idecy - 1 TO 1 STEP -1
            b$ = idegetline(idecy_i)
            IF RIGHT$(b$, 1) <> "_" THEN idecy_multilinestart = idecy_i + 1: EXIT FOR
        NEXT
        IF idecy_multilinestart = 0 THEN idecy_multilinestart = 1
    END IF
END IF

IF idecy > 1 THEN b$ = idegetline(idecy - 1) ELSE b$ = ""

FOR y = 0 TO (idewy - 9)
    LOCATE y + 3, 1
    COLOR 7, 1
    PRINT CHR$(179); 'clear prev bookmarks from lhs
    IF l = idefocusline AND idecy <> l THEN
        COLOR 7, 4
    ELSEIF idecy = l OR (l >= idecy_multilinestart AND l <= idecy_multilineend) THEN
        COLOR 7, 6
    ELSE
        COLOR 7, 1
    END IF

    IF l <= iden THEN
        a$ = idegetline(l)
        IF l = idecy THEN
            IF idecx <= LEN(a$) THEN
                cc = ASC(a$, idecx)
                IF cc = 32 THEN
                    IF LTRIM$(LEFT$(a$, idecx)) = "" THEN cc = -1
                END IF
            END IF
        END IF

        a2$ = SPACE$(idesx + (idewx - 3))
        MID$(a2$, 1) = a$
        a2$ = RIGHT$(a2$, (idewx - 2))
    ELSE
        a2$ = SPACE$((idewx - 2))
    END IF

    ' ### STEVE EDIT TO MAKE QUOTES AND COMMENTS STAND OUT WITH MINOR COLOR ADJUSTMENTS ###

    'FOR x = 1 TO LEN(a2$)
    '    PRINT CHR$(ASC(a2$, x));
    'NEXT

    inquote = 0
    comment = 0
    metacommand = 0
    FOR k = 1 TO idesx 'First check the part of the line that's off screen to the left
        SELECT CASE MID$(a$, k, 1)
            CASE CHR$(34)
                inquote = NOT inquote
            CASE "'"
                IF inquote = 0 THEN comment = -1
        END SELECT
    NEXT k
    FOR m = 1 TO LEN(a2$) 'continue checking, while printing to the screen
        SELECT CASE MID$(a$, m + idesx - 1, 1)
            CASE CHR$(34): inquote = NOT inquote
            CASE "'": IF inquote = 0 THEN comment = -1
        END SELECT
        IF left$(ltrim$(a$),2) = "'$" or left$(ltrim$(a$),1) = "$" THEN metacommand = -1  : comment = 0
        COLOR 13

        IF comment THEN
            COLOR 11
        ELSEIF metacommand THEN
            COLOR 10
        ELSEIF inquote OR MID$(a2$, m, 1) = CHR$(34) THEN
            COLOR 14
        END IF
        DO UNTIL l < UBOUND(InValidLine) 'make certain we have enough InValidLine elements to cover us in case someone scrolls QB64
            REDIM _PRESERVE InValidLine(UBOUND(InValidLine) + 1000) AS _BIT '   to the end of a program before the IDE has finished
        LOOP '                                                      verifying the code and growing the array during the IDE passes.
        If InValidLine(l) and 1 then color 7

        LOCATE y + 3, 2 + m - 1
        PRINT MID$(a2$, m, 1);
    NEXT m

    '### END OF STEVE EDIT

    'apply selection color change if necessary
    IF ideselect THEN
        IF l >= sy1 AND l <= sy2 THEN
            IF sy1 = sy2 THEN 'single line select
                COLOR 1, 7
                x2 = idesx
                FOR x = 2 TO (idewx - 2)
                    IF x2 >= sx1 AND x2 < sx2 THEN
                        a = SCREEN(y + 3, x)

                        IF a = 63 THEN '"?"
                            c = SCREEN(y + 3, x, 1)
                        ELSE
                            c = 1
                        END IF
                        IF (c AND 15) = 0 THEN 'black background
                            COLOR 0, 7
                            LOCATE y + 3, x: PRINT "?";
                            COLOR 1, 7
                        ELSE
                            LOCATE y + 3, x: PRINT CHR$(a);
                        END IF


                    END IF
                    x2 = x2 + 1
                NEXT
                COLOR 7, 1
            ELSE 'multiline select
                IF idecx = 1 AND l = sy2 AND idecy > sy1 THEN GOTO nofinalselect
                LOCATE y + 3, 2
                COLOR 1, 7

                FOR x = 1 TO LEN(a2$)
                    PRINT CHR$(ASC(a2$, x));
                NEXT

                COLOR 7, 1
                nofinalselect:
            END IF
        END IF
    END IF

    l = l + 1
NEXT

COLOR 7, 1
FOR b = 1 TO IdeBmkN
    y = IdeBmk(b).y
    IF y >= idesy AND y <= idesy + (idewy - 9) THEN
        LOCATE 3 + y - idesy, 1: PRINT chr$(197);
    END IF
NEXT

q = idevbar(idewx, 3, (idewy - 8), idecy, iden)
q = idehbar(2, (idewy - 5), (idewx - 2), idesx, 608)

'update cursor pos in status bar
COLOR 0, 3
LOCATE idewy + idesubwindow, idewx - 20: PRINT "          :          ";
IF idecx < 100000 THEN
    LOCATE idewy + idesubwindow, idewx - 9
    a$ = LTRIM$(STR$(idecx))
    PRINT a$;
    IF cc <> -1 THEN PRINT "(" + str2$(cc) + ")";
END IF
a$ = LTRIM$(STR$(idecy))
LOCATE idewy + idesubwindow, (idewx - 10) - LEN(a$)
PRINT a$;

SCREEN , , 0, 0: LOCATE idecy - idesy + 3, idecx - idesx + 2: SCREEN , , 3, 0

END SUB

FUNCTION idesubs$

'-------- generic dialog box header --------
PCOPY 0, 2
PCOPY 0, 1
SCREEN , , 1, 0
focus = 1
DIM p AS idedbptype
DIM o(1 TO 100) AS idedbotype
DIM oo AS idedbotype
DIM sep AS STRING * 1
sep = CHR$(0)
'-------- end of generic dialog box header --------

'------- identify word or character at current cursor position - copied/adapted from FUNCTION ide2:
a$ = idegetline(idecy)
x = idecx
IF x <= LEN(a$) THEN
    IF alphanumeric(ASC(a$, x)) THEN
        x1 = x
        DO WHILE x1 > 1
            IF alphanumeric(ASC(a$, x1 - 1)) OR ASC(a$, x1 - 1) = 36 THEN x1 = x1 - 1 ELSE EXIT DO
        LOOP
        x2 = x
        DO WHILE x2 < LEN(a$)
            IF alphanumeric(ASC(a$, x2 + 1)) OR ASC(a$, x2 + 1) = 36 THEN x2 = x2 + 1 ELSE EXIT DO
        LOOP
        a2$ = MID$(a$, x1, x2 - x1 + 1)
    ELSE
        a2$ = CHR$(ASC(a$, x))
    END IF
    a2$ = UCASE$(a2$) 'a2$ now holds the word or character at current cursor position
    if len(a2$) > 1 then
        do until alphanumeric(asc(right$(a2$, 1)))
            a2$ = left$(a2$, len(a2$) - 1)  'removes sigil, if any
        loop
    end if
END IF

'-------- init --------

ly$ = MKL$(1)
lySorted$ = ly$
CurrentlyViewingWhichSUBFUNC = 1
PreferCurrentCursorSUBFUNC = 0
InsideDECLARE = 0
FoundExternalSUBFUNC = 0
l$ = ideprogname$
IF l$ = "" THEN l$ = "Untitled" + tempfolderindexstr$
lSorted$ = l$

TotalSUBs = 0
SortedSubsFlag = idesortsubs

FOR y = 1 TO iden
    a$ = idegetline(y)
    a$ = LTRIM$(RTRIM$(a$))
    sf = 0
    nca$ = UCASE$(a$)
    IF LEFT$(nca$, 8) = "DECLARE " and INSTR(nca$, " LIBRARY") > 0 THEN InsideDECLARE = -1
    IF LEFT$(nca$, 11) = "END DECLARE" THEN InsideDECLARE = 0
    IF LEFT$(nca$, 4) = "SUB " THEN sf = 1: sf$ = "SUB  "
    IF LEFT$(nca$, 9) = "FUNCTION " THEN sf = 2: sf$ = "FUNC "
    IF sf THEN
        IF RIGHT$(nca$, 7) = " STATIC" THEN
            a$ = RTRIM$(LEFT$(a$, LEN(a$) - 7))
        END IF
        ly$ = ly$ + MKL$(y)

        'Check if the cursor is currently inside this SUB/FUNCTION to position the
        'selection properly in the list.
        IF idecy >= y AND NOT InsideDECLARE THEN
            CurrentlyViewingWhichSUBFUNC = (LEN(ly$) / 4)
        END IF
        'End of current SUB/FUNCTION check

        IF sf = 1 THEN
            a$ = RIGHT$(a$, LEN(a$) - 4)
        ELSE
            a$ = RIGHT$(a$, LEN(a$) - 9)
        END IF
        a$ = LTRIM$(RTRIM$(a$))
        x = INSTR(a$, "(")
        IF x THEN
            n$ = RTRIM$(LEFT$(a$, x - 1))
            args$ = RIGHT$(a$, LEN(a$) - x + 1)
        ELSE
            n$ = a$
            args$ = ""
        END IF

        'attempt to cleanse n$, just in case there are any comments or other unwanted stuff
        for CleanseN = 1 to len(n$)
            select case mid$(n$, CleanseN, 1)
                case " ", "'", ":"
                    n$ = left$(n$, CleanseN - 1)
                    exit for
            end select
        next

        'If the user currently has the cursor over a SUB/FUNC name, let's highlight it
        'instead of the currently in edition, for a quick link functionality:
        n2$ = n$
        if len(n2$) > 1 then
            do until alphanumeric(asc(right$(n2$, 1)))
                n2$ = left$(n$, len(n2$) - 1)  'removes sigil, if any
            loop
        end if
        IF a2$ = UCASE$(n2$) THEN PreferCurrentCursorSUBFUNC = (LEN(ly$) / 4)

        IF InsideDECLARE = -1 THEN n$ = "*" + n$: FoundExternalSUBFUNC = -1

        IF LEN(n$) <= 20 THEN
            n$ = n$ + SPACE$(20 - LEN(n$))
        ELSE
            n$ = LEFT$(n$, 17) + string$(3, 250)
        END IF
        IF LEN(args$) <= (idewx - 41) THEN
            args$ = args$ + SPACE$((idewx - 41) - LEN(args$))
        ELSE
            args$ = LEFT$(args$, (idewx - 44)) + string$(3, 250)
        END IF
        l$ = l$ + sep + chr$(195) + chr$(196) + n$ + " " + sf$ + args$

        'Populate SortedSubsList()
        TotalSUBs = TotalSUBs + 1
        ListItemLength = LEN(n$ + " " + sf$ + args$)
        REDIM _PRESERVE SortedSubsList(1 to TotalSUBs) as string * 998
        REDIM _PRESERVE CaseBkpSubsList(1 to TotalSUBs) as string * 998
        CaseBkpSubsList(TotalSUBs) = n$ + " " + sf$ + args$
        SortedSubsList(TotalSUBs) = UCASE$(CaseBkpSubsList(TotalSUBs))
        MID$(CaseBkpSubsList(TotalSUBs), 992, 6) = MKL$(y) + MKI$(ListItemLength)
        MID$(SortedSubsList(TotalSUBs), 992, 6) = MKL$(y) + MKI$(ListItemLength)
    END IF
NEXT

FOR x = LEN(l$) TO 1 STEP -1
    a$ = MID$(l$, x, 1)
    IF a$ = chr$(195) THEN MID$(l$, x, 1) = chr$(192): EXIT FOR
NEXT

if TotalSUBs > 1 then
    DIM m as _MEM
    m = _MEM(SortedSubsList())
    IF INSTR(_OS$, "64BIT") = 0 THEN Sort m 'Steve's sorting routine
    FOR x = 1 to TotalSUBs
        ListItemLength = CVI(MID$(SortedSubsList(x), LEN(SortedSubsList(x)) - 2, 2))
        lySorted$ = lySorted$ + MID$(SortedSubsList(x), LEN(SortedSubsList(x)) - 6, 4)
        for RestoreCaseBkp = 1 to TotalSUBs
            IF MID$(SortedSubsList(x), LEN(SortedSubsList(x)) - 6, 4) = MID$(CaseBkpSubsList(RestoreCaseBkp), LEN(CaseBkpSubsList(RestoreCaseBkp)) - 6, 4) THEN
                lSorted$ = lSorted$ + sep + chr$(195) + chr$(196) + left$(CaseBkpSubsList(RestoreCaseBkp), ListItemLength)
                EXIT FOR
            END IF
        next
    NEXT

    FOR x = LEN(lSorted$) TO 1 STEP -1
        a$ = MID$(lSorted$, x, 1)
        IF a$ = chr$(195) THEN MID$(lSorted$, x, 1) = chr$(192): EXIT FOR
    NEXT
    SortedSubsFlag = idesortsubs
else
    SortedSubsFlag = 0 'Override idesortsubs if the current program doesn't have more than 1 subprocedure
end if

'72,19
i = 0
idepar p, idewx - 8, idewy + idesubwindow - 6, "SUBs"

i = i + 1
o(i).typ = 2
o(i).y = 1
'68
o(i).w = idewx - 12: o(i).h = idewy + idesubwindow - 9
o(i).txt = idenewtxt(l$)
IF SortedSubsFlag = 0 THEN
    IF PreferCurrentCursorSUBFUNC <> 0 THEN
        o(i).sel = PreferCurrentCursorSUBFUNC
    ELSE
        o(i).sel = CurrentlyViewingWhichSUBFUNC
    END IF
ELSE
    idetxt(o(i).txt) = lSorted$
    IF PreferCurrentCursorSUBFUNC <> 0 THEN
        for x = 1 to TotalSUBs
            if MID$(ly$, PreferCurrentCursorSUBFUNC * 4 - 3, 4) = MID$(SortedSubsList(x), LEN(SortedSubsList(x)) - 6, 4) THEN
                o(i).sel = x + 1 'The sorted list items array doesn't contain the first line (ideprogname$)
                EXIT FOR
            END IF
        NEXT
    ELSE
        for x = 1 to TotalSUBs
            if MID$(ly$, CurrentlyViewingWhichSUBFUNC * 4 - 3, 4) = MID$(SortedSubsList(x), LEN(SortedSubsList(x)) - 6, 4) THEN
                o(i).sel = x + 1 'The sorted list items array doesn't contain the first line (ideprogname$)
                EXIT FOR
            END IF
        NEXT
    END IF
END IF
o(i).nam = idenewtxt("Program Items")


i = i + 1
o(i).typ = 3
o(i).y = idewy + idesubwindow - 6
o(i).txt = idenewtxt("#Edit" + sep + "#Cancel")
o(i).dft = 1

If TotalSUBs > 1 AND INSTR(_OS$, "64BIT") = 0 then
    i = i + 1
    o(i).typ = 4 'check box
    o(i).x = idewx - 22
    o(i).y = idewy + idesubwindow - 6
    o(i).nam = idenewtxt("#Sorted A-Z")
    o(i).sel = SortedSubsFLAG
END IF


'-------- end of init --------

'-------- generic init --------
FOR i = 1 TO 100: o(i).par = p: NEXT 'set parent info of objects
'-------- end of generic init --------

DO 'main loop

    '-------- generic display dialog box & objects --------
    idedrawpar p
    f = 1: cx = 0: cy = 0
    FOR i = 1 TO 100
        IF o(i).typ THEN
            'prepare object

            o(i).foc = focus - f 'focus offset
            o(i).cx = 0: o(i).cy = 0
            idedrawobj o(i), f 'display object
            IF o(i).cx THEN cx = o(i).cx: cy = o(i).cy
        END IF
    NEXT i
    lastfocus = f - 1
    '-------- end of generic display dialog box & objects --------

    '-------- custom display changes --------
    IF FoundExternalSUBFUNC = -1 THEN
        COLOR 8, 7: LOCATE idewy + idesubwindow - 3, p.x + 2: PRINT "* external";
    END IF
    '-------- end of custom display changes --------

    'update visual page and cursor position
    PCOPY 1, 0
    IF cx THEN SCREEN , , 0, 0: LOCATE cy, cx, 1: SCREEN , , 1, 0

    '-------- read input --------
    change = 0
    DO
        GetInput
        IF mWHEEL THEN change = 1
        IF KB THEN change = 1
        IF mCLICK THEN mousedown = 1: change = 1
        IF mRELEASE THEN mouseup = 1: change = 1
        IF mB THEN change = 1
        alt = KALT: IF alt <> oldalt THEN change = 1
        oldalt = alt
        _LIMIT 100
    LOOP UNTIL change
    IF alt THEN idehl = 1 ELSE idehl = 0
    'convert "alt+letter" scancode to letter's ASCII character
    altletter$ = ""
    IF alt THEN
        IF LEN(K$) = 1 THEN
            k = ASC(UCASE$(K$))
            IF k >= 65 AND k <= 90 THEN altletter$ = CHR$(k)
        END IF
    END IF
    SCREEN , , 0, 0: LOCATE , , 0: SCREEN , , 1, 0
    '-------- end of read input --------

    '-------- generic input response --------
    info = 0
    IF K$ = "" THEN K$ = CHR$(255)
    IF KSHIFT = 0 AND K$ = CHR$(9) THEN focus = focus + 1
    IF KSHIFT AND K$ = CHR$(9) THEN focus = focus - 1
    IF focus < 1 THEN focus = lastfocus
    IF focus > lastfocus THEN focus = 1
    f = 1
    FOR i = 1 TO 100
        t = o(i).typ
        IF t THEN
            focusoffset = focus - f
            ideobjupdate o(i), focus, f, focusoffset, K$, altletter$, mB, mousedown, mouseup, mX, mY, info, mWHEEL
        END IF
    NEXT
    '-------- end of generic input response --------

    IF K$ = CHR$(27) OR (focus = 3 AND info <> 0) THEN
        idesubs$ = "C"
        GOSUB SaveSortSettings
        EXIT FUNCTION
    END IF

    IF K$ = CHR$(13) OR (focus = 2 AND info <> 0) OR (info = 1 AND focus = 1) THEN
        y = o(1).sel
        IF y < 1 THEN y = -y
        AddQuickNavHistory idecy
        if SortedSubsFLAG = 0 THEN
            idecy = CVL(MID$(ly$, y * 4 - 3, 4))
        ELSE
            idecy = CVL(MID$(lySorted$, y * 4 - 3, 4))
        END IF
        idesy = idecy
        idecx = 1
        idesx = 1

        GOSUB SaveSortSettings
        EXIT FUNCTION
    END IF

    if TotalSUBs > 1 THEN
        if o(3).sel <> SortedSubsFLAG then
            SortedSubsFLAG = o(3).sel

            IF SortedSubsFLAG = 0 THEN
                'Replace list contents with unsorted version while mantaining current selection.
                PreviousSelection = -1
                IF o(1).sel > 0 THEN
                    TargetSourceLine$ = MID$(lySorted$, o(1).sel * 4 - 3, 4)
                    for x = 1 to TotalSUBs
                        if MID$(ly$, x * 4 - 3, 4) = TargetSourceLine$ then
                            PreviousSelection = x
                        end if
                    next
                END IF

                idetxt(o(1).txt) = l$
                o(1).sel = PreviousSelection
                focus = 1
            ELSE
                'Replace list contents with sorted version while mantaining current selection.
                PreviousSelection = -1
                IF o(1).sel > 0 THEN
                    TargetSourceLine$ = MID$(ly$, o(1).sel * 4 - 3, 4)
                    for x = 1 to TotalSUBs
                        if MID$(lySorted$, x * 4 - 3, 4) = TargetSourceLine$ then
                            PreviousSelection = x
                        end if
                    next
                END IF

                idetxt(o(1).txt) = lSorted$
                o(1).sel = PreviousSelection
                focus = 1
            END IF
        end if
    end if

    'end of custom controls
    mousedown = 0
    mouseup = 0
LOOP

EXIT FUNCTION
SaveSortSettings:
If TotalSUBs > 1 and idesortsubs <> SortedSubsFLAG THEN
    idesortsubs = SortedSubsFLAG
    if idesortsubs then
        WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_SortSUBs", "TRUE"
    else
        WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_SortSUBs", "FALSE"
    end if
END IF
RETURN

END FUNCTION


FUNCTION idelanguagebox

'-------- generic dialog box header --------
PCOPY 0, 2
PCOPY 0, 1
SCREEN , , 1, 0
focus = 1
DIM p AS idedbptype
DIM o(1 TO 100) AS idedbotype
DIM oo AS idedbotype
DIM sep AS STRING * 1
sep = CHR$(0)
'-------- end of generic dialog box header --------

'-------- init --------

'generate list of available code pages
l$ = idecpname(1)
FOR x = 2 TO idecpnum
    l$ = l$ + sep + idecpname(x)
NEXT
l$ = UCASE$(l$)

i = 0
idepar p, idewx - 8, idewy + idesubwindow - 6, "Language"

i = i + 1
o(i).typ = 2
o(i).y = 2
o(i).w = idewx - 12: o(i).h = idewy + idesubwindow - 10
o(i).txt = idenewtxt(l$)
o(i).sel = 1: IF idecpindex THEN o(i).sel = idecpindex
o(i).nam = idenewtxt("Code Pages")

i = i + 1
o(i).typ = 3
o(i).y = idewy + idesubwindow - 6
o(i).txt = idenewtxt("#OK" + sep + "#Cancel")
o(i).dft = 1





'-------- end of init --------

'-------- generic init --------
FOR i = 1 TO 100: o(i).par = p: NEXT 'set parent info of objects
'-------- end of generic init --------

DO 'main loop

    '-------- generic display dialog box & objects --------
    idedrawpar p
    f = 1: cx = 0: cy = 0
    FOR i = 1 TO 100
        IF o(i).typ THEN
            'prepare object
            o(i).foc = focus - f 'focus offset
            o(i).cx = 0: o(i).cy = 0
            idedrawobj o(i), f 'display object
            IF o(i).cx THEN cx = o(i).cx: cy = o(i).cy
        END IF
    NEXT i
    lastfocus = f - 1
    '-------- end of generic display dialog box & objects --------

    '-------- custom display changes --------
    COLOR 0, 7: LOCATE p.y + 1, p.x + 2: PRINT "Code-page for ASCII-UNICODE mapping: (Default: CP437)"

    '-------- end of custom display changes --------

    'update visual page and cursor position
    PCOPY 1, 0
    IF cx THEN SCREEN , , 0, 0: LOCATE cy, cx, 1: SCREEN , , 1, 0

    '-------- read input --------
    change = 0
    DO
        GetInput
        IF mWHEEL THEN change = 1
        IF KB THEN change = 1
        IF mCLICK THEN mousedown = 1: change = 1
        IF mRELEASE THEN mouseup = 1: change = 1
        IF mB THEN change = 1
        alt = KALT: IF alt <> oldalt THEN change = 1
        oldalt = alt
        _LIMIT 100
    LOOP UNTIL change
    IF alt THEN idehl = 1 ELSE idehl = 0
    'convert "alt+letter" scancode to letter's ASCII character
    altletter$ = ""
    IF alt THEN
        IF LEN(K$) = 1 THEN
            k = ASC(UCASE$(K$))
            IF k >= 65 AND k <= 90 THEN altletter$ = CHR$(k)
        END IF
    END IF
    SCREEN , , 0, 0: LOCATE , , 0: SCREEN , , 1, 0
    '-------- end of read input --------

    '-------- generic input response --------
    info = 0
    IF K$ = "" THEN K$ = CHR$(255)
    IF KSHIFT = 0 AND K$ = CHR$(9) THEN focus = focus + 1
    IF KSHIFT AND K$ = CHR$(9) THEN focus = focus - 1
    IF focus < 1 THEN focus = lastfocus
    IF focus > lastfocus THEN focus = 1
    f = 1
    FOR i = 1 TO 100
        t = o(i).typ
        IF t THEN
            focusoffset = focus - f
            ideobjupdate o(i), focus, f, focusoffset, K$, altletter$, mB, mousedown, mouseup, mX, mY, info, mWHEEL
        END IF
    NEXT
    '-------- end of generic input response --------

    IF K$ = CHR$(27) OR (focus = 3 AND info <> 0) THEN
        '        idesubs$ = "C"
        EXIT FUNCTION
    END IF

    IF K$ = CHR$(13) OR (focus = 2 AND info <> 0) OR (info = 1 AND focus = 1) THEN
        y = o(1).sel
        IF y < 1 THEN y = -y

        FOR x = 128 TO 255
            u = VAL("&H" + MID$(idecp(y), x * 8 + 1, 8) + "&")
            IF u = 0 THEN u = 9744
            _MAPUNICODE u TO x
        NEXT

        'save changes
        v% = y: idecpindex = v%
        WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_CodePage", str$(idecpindex)
        EXIT FUNCTION
    END IF


    'end of custom controls
    mousedown = 0
    mouseup = 0
LOOP



END FUNCTION

SUB ideobjupdate (o AS idedbotype, focus, f, focusoffset, kk$, altletter$, mb, mousedown, mouseup, mx, my, info, mw)
STATIC SearchTerm$, LastKeybInput as single
DIM sep AS STRING * 1
sep = CHR$(0)

t = o.typ

IF t = 1 THEN 'text field
    IF mousedown THEN
        x1 = o.par.x + o.x: y = o.par.y + o.y
        x2 = x1
        IF o.nam THEN
            x2 = x2 + idehlen(idetxt(o.nam)) + 2
        END IF
        IF my >= y - 1 AND my <= y + 1 THEN
            IF mx >= x1 AND mx <= x2 + o.w + 3 THEN
                focus = f
                'change cursor location?
                IF my = y THEN
                    IF mx > x2 + 1 AND mx < x2 + o.w + 2 THEN
                        a$ = idetxt(o.txt)
                        x = mx - x2 - 2 '0-?
                        IF x = o.v1 AND x <> LEN(a$) THEN 'dbl-click text=clear field text
                            a$ = ""
                            idetxt(o.txt) = a$
                            o.v1 = 0
                        ELSE
                            IF x <= LEN(a$) THEN o.v1 = x ELSE o.v1 = LEN(a$)
                            o.issel = 0
                        END IF
                    END IF
                END IF
            END IF
        END IF
    END IF 'mousedown

    a$ = idetxt(o.txt)
    IF focusoffset = 0 THEN
        IF LEN(kk$) = 1 THEN
            k = ASC(kk$)
            IF (KSHIFT AND KB = KEY_INSERT) OR (KCONTROL AND UCASE$(kk$) = "V") THEN 'paste from clipboard
                clip$ = _CLIPBOARD$ 'read clipboard
                x = INSTR(clip$, CHR$(13))
                IF x THEN clip$ = LEFT$(clip$, x - 1)
                x = INSTR(clip$, CHR$(10))
                IF x THEN clip$ = LEFT$(clip$, x - 1)
                IF LEN(clip$) THEN
                    IF o.issel THEN
                        sx1 = o.sx1: sx2 = o.v1
                        if sx1 > sx2 then SWAP sx1, sx2
                        if sx2 - sx1 > 0 then
                            a$ = left$(a$, sx1) + clip$ + right$(a$, len(a$) - sx2)
                            o.v1 = sx1
                            o.issel = 0
                        end if
                    ELSE
                        a$ = left$(a$, o.v1) + clip$ + right$(a$, len(a$) - o.v1)
                    END IF
                END IF
                k = 255
            END IF

            IF (KCONTROL AND UCASE$(kk$) = "A") THEN 'select all
                if len(a$) > 0 then
                    o.issel = -1
                    o.sx1 = 0
                    o.v1 = len(a$)
                END IF
                k = 255
            END IF

            IF ((KCTRL AND KB = KEY_INSERT) OR (KCONTROL AND UCASE$(kk$) = "C")) THEN 'copy to clipboard
                IF o.issel THEN
                    sx1 = o.sx1: sx2 = o.v1
                    if sx1 > sx2 then SWAP sx1, sx2
                    if sx2 - sx1 > 0 then _CLIPBOARD$ = mid$(a$, sx1 + 1, sx2 - sx1)
                END IF
                k = 255
            END IF

            IF ((KSHIFT AND KB = KEY_DELETE) OR (KCONTROL AND UCASE$(kk$) = "X")) THEN 'cut to clipboard
                IF o.issel THEN
                    sx1 = o.sx1: sx2 = o.v1
                    if sx1 > sx2 then SWAP sx1, sx2
                    if sx2 - sx1 > 0 then
                        _CLIPBOARD$ = mid$(a$, sx1 + 1, sx2 - sx1)
                        'delete selection
                        a$ = left$(a$, sx1) + right$(a$, len(a$) - sx2)
                        o.v1 = sx1
                        o.issel = 0
                    end if
                END IF
                k = 255
            END IF

            IF k = 8 AND o.v1 > 0 THEN
                if o.issel THEN
                    sx1 = o.sx1: sx2 = o.v1
                    if sx1 > sx2 then SWAP sx1, sx2
                    if sx2 - sx1 > 0 then
                        'delete selection
                        a$ = left$(a$, sx1) + right$(a$, len(a$) - sx2)
                        o.issel = 0
                    end if
                else
                    a1$ = LEFT$(a$, o.v1 - 1)
                    IF o.v1 <= LEN(a$) THEN a2$ = RIGHT$(a$, LEN(a$) - o.v1) ELSE a2$ = ""
                    a$ = a1$ + a2$: o.v1 = o.v1 - 1
                end if
            ELSEIF k = 8 and o.issel THEN
                sx1 = o.sx1: sx2 = o.v1
                if sx1 > sx2 then SWAP sx1, sx2
                if sx2 - sx1 > 0 then
                    'delete selection
                    a$ = left$(a$, sx1) + right$(a$, len(a$) - sx2)
                    o.issel = 0
                end if
            END IF
            IF k <> 8 AND k <> 9 AND k <> 0 AND k <> 10 AND k <> 13 AND k <> 26 AND k <> 255 THEN
                if o.issel THEN
                    sx1 = o.sx1: sx2 = o.v1
                    if sx1 > sx2 then SWAP sx1, sx2
                    if sx2 - sx1 > 0 then
                        'replace selection
                        a$ = left$(a$, sx1) + right$(a$, len(a$) - sx2)
                        idetxt(o.txt) = a$
                        o.issel = 0
                        o.v1 = sx1
                    end if
                end if
                IF o.v1 > 0 THEN a1$ = LEFT$(a$, o.v1) ELSE a1$ = ""
                IF o.v1 <= LEN(a$) THEN a2$ = RIGHT$(a$, LEN(a$) - o.v1) ELSE a2$ = ""
                a$ = a1$ + kk$ + a2$: o.v1 = o.v1 + 1
            END IF
            idetxt(o.txt) = a$
        END IF
        IF kk$ = CHR$(0) + "S" THEN 'DEL
            if o.issel THEN
                sx1 = o.sx1: sx2 = o.v1
                if sx1 > sx2 then SWAP sx1, sx2
                if sx2 - sx1 > 0 then
                    'delete selection
                    a$ = left$(a$, sx1) + right$(a$, len(a$) - sx2)
                    idetxt(o.txt) = a$
                    o.v1 = sx1
                    o.issel = 0
                end if
            else
                IF o.v1 > 0 THEN a1$ = LEFT$(a$, o.v1) ELSE a1$ = ""
                IF o.v1 < LEN(a$) THEN a2$ = RIGHT$(a$, LEN(a$) - o.v1 - 1) ELSE a2$ = ""
                a$ = a1$ + a2$
                idetxt(o.txt) = a$
            end if
        END IF

        'cursor control
        if kk$ = CHR$(0) + "K" THEN GOSUB selectcheck: o.v1 = o.v1 - 1
        IF kk$ = CHR$(0) + "M" THEN GOSUB selectcheck: o.v1 = o.v1 + 1
        IF kk$ = CHR$(0) + "G" THEN GOSUB selectcheck: o.v1 = 0
        IF kk$ = CHR$(0) + "O" THEN GOSUB selectcheck: o.v1 = LEN(a$)
        IF o.v1 < 0 THEN o.v1 = 0
        IF o.v1 > LEN(a$) THEN o.v1 = LEN(a$)
        IF o.v1 = o.sx1 then o.issel = 0
    END IF
    'hot-key focus
    IF LEN(altletter$) THEN
        IF o.nam THEN
            x = INSTR(idetxt(o.nam), "#")
            IF x THEN
                IF UCASE$(MID$(idetxt(o.nam), x + 1, 1)) = altletter$ THEN focus = f
            END IF
        END IF
    END IF
    f = f + 1
END IF '1

IF t = 2 THEN 'list box
    idetxt(o.stx) = ""

    IF mousedown THEN
        x1 = o.par.x + o.x: y1 = o.par.y + o.y
        x2 = x1 + o.w + 1: y2 = y1 + o.h + 1
        IF mx >= x1 AND mx <= x2 AND my >= y1 AND my <= y2 THEN
            focus = f
            IF mx > x1 AND mx < x2 AND my > y1 AND my < y2 THEN
                y = my - y1 - 1
                y = y + o.v1
                IF o.sel = y THEN info = 1
                o.sel = y
                IF o.sel > o.num THEN o.sel = o.num
            END IF
        END IF

    END IF 'mousedown

    IF mb THEN
        IF focusoffset = 0 THEN

            x1 = o.par.x + o.x: y1 = o.par.y + o.y
            x2 = x1 + o.w + 1: y2 = y1 + o.h + 1
            IF mx >= x1 AND mx <= x2 AND my >= y1 AND my <= y2 THEN

                IF mx = x2 AND my > y1 + 1 AND my < y2 - 1 THEN

                    tsel = ABS(o.sel)
                    tnum = o.num
                    q = idevbar(x2, y1 + 1, o.h, tsel, tnum)

                    IF my < q THEN
                        kk$ = CHR$(0) + CHR$(73)
                        idewait
                    END IF
                    IF my > q THEN
                        kk$ = CHR$(0) + CHR$(81)
                        idewait
                    END IF
                END IF

                IF mx = x2 AND my = y1 + 1 THEN
                    kk$ = CHR$(0) + CHR$(72)
                    idewait
                END IF
                IF mx = x2 AND my = y2 - 1 THEN
                    kk$ = CHR$(0) + CHR$(80)
                    idewait
                END IF

            END IF
        END IF
    END IF 'mb


    IF focusoffset = 0 THEN
        IF mw THEN
            'move to top or bottom
            IF mw < 0 THEN
                IF o.sel > o.v1 THEN o.sel = o.v1
            ELSE
                o.sel = o.v1 + o.h - 1
            END IF
            o.sel = o.sel + mw * 3
            IF o.sel < 1 THEN o.sel = 1
            IF o.sel > o.num THEN o.sel = o.num
        END IF

        IF kk$ = CHR$(0) + CHR$(72) THEN
            IF o.sel < 0 THEN
                o.sel = -o.sel
            ELSE
                o.sel = o.sel - 1
                IF o.sel < 1 THEN o.sel = 1
            END IF
        END IF

        IF kk$ = CHR$(0) + CHR$(80) THEN
            IF o.sel < 0 THEN
                o.sel = -o.sel
            ELSE
                o.sel = o.sel + 1
                IF o.sel > o.num THEN o.sel = o.num
            END IF
        END IF

        IF kk$ = CHR$(0) + CHR$(73) THEN
            IF o.sel < 0 THEN
                o.sel = -o.sel
            END IF
            o.sel = o.sel - o.h + 1
            IF o.sel < 1 THEN o.sel = 1
        END IF

        IF kk$ = CHR$(0) + CHR$(81) THEN
            IF o.sel < 0 THEN
                o.sel = -o.sel
            END IF
            o.sel = o.sel + o.h - 1
            IF o.sel > o.num THEN o.sel = o.num
        END IF

        IF kk$ = CHR$(0) + "w" THEN
            o.sel = 1
        END IF

        IF kk$ = CHR$(0) + "u" THEN
            o.sel = o.num
        END IF

        IF LEN(kk$) = 1 THEN
            ResetKeybTimer = 0
            IF TIMER - LastKeybInput > 1 THEN SearchTerm$ = "": ResetKeybTimer = -1
            LastKeybInput = TIMER
            k = ASC(UCASE$(kk$)): IF k < 32 OR k > 126 THEN k = 255

            'Populate ListBoxITEMS:
            a$ = idetxt(o.txt)
            redim ListBoxITEMS(0) as string
            if len(a$) > 0 then
                n = 0: x = 1
                do
                    x2 = INSTR(x, a$, sep)
                    if x2 > 0 then
                        n = n + 1
                        redim _preserve ListBoxITEMS(1 to n) as string
                        ListBoxITEMS(n) = mid$(a$, x, x2 - x)
                    else
                        n = n + 1
                        redim _preserve ListBoxITEMS(1 to n) as string
                        ListBoxITEMS(n) = right$(a$, len(a$) - x + 1)
                        exit do
                    end if
                    x = x2 + 1
                loop
            end if

            if k = 255 then
                if o.sel > 0 then idetxt(o.stx) = ListBoxITEMS(o.sel)
                goto selected 'Search is not performed if kk$ isn't a printable character
            else
                SearchTerm$ = SearchTerm$ + UCASE$(kk$)
            END IF

            if len(SearchTerm$) = 2 and left$(SearchTerm$, 1) = right$(SearchTerm$, 1) then
                'if the user is pressing the same letter again, we deduce the search
                'is only for the initials
                ResetKeybTimer = -1
                SearchTerm$ = ucase$(kk$)
            end if

            SearchPass = 1
            if not ResetKeybTimer then StartSearch = abs(o.sel) else StartSearch = abs(o.sel) + 1
            if StartSearch < 1 or StartSearch > n then StartSearch = 1
            retryfind:
            if SearchPass > 2 then goto selected
            for findMatch = StartSearch to n
                validCHARS$ = ""
                FOR ai = 1 TO LEN(ListBoxITEMS(FindMatch))
                    aa = ASC(ucase$(ListBoxITEMS(findMatch)), ai)
                    IF aa > 126 OR (k <> 95 AND aa = 95) OR (k <> 42 AND aa = 42) THEN
                        'ignore
                    ELSE
                        validCHARS$ = validCHARS$ + CHR$(aa)
                    END IF
                NEXT
                if findMatch = o.sel then idetxt(o.stx) = ListBoxITEMS(FindMatch)
                IF left$(validCHARS$, len(SearchTerm$)) = SearchTerm$ THEN
                    o.sel = findMatch
                    GOTO selected
                end if
            next findMatch
            'No match, try again:
            StartSearch = 1
            SearchPass = SearchPass + 1
            goto retryfind
            selected:
        END IF

    END IF

    'hot-key focus
    IF LEN(altletter$) THEN
        IF o.nam THEN
            x = INSTR(idetxt(o.nam), "#")
            IF x THEN
                IF UCASE$(MID$(idetxt(o.nam), x + 1, 1)) = altletter$ THEN focus = f
            END IF
        END IF
    END IF
    f = f + 1
END IF '2

IF t = 3 THEN 'buttons (eg. OK, Cancel)

    'count buttons & check for hotkey(s)
    a$ = idetxt(o.txt)
    n = 1
    x = 0
    FOR i2 = 1 TO LEN(a$)
        a2$ = MID$(a$, i2, 1)
        IF a2$ = CHR$(0) THEN n = n + 1
        IF x = 1 THEN
            IF UCASE$(a2$) = altletter$ THEN
                focus = f + n - 1
                info = n
            END IF
        END IF
        IF a2$ = "#" THEN x = 1 ELSE x = 0
    NEXT

    'check for mouse click on button(s)
    IF mousedown THEN
        IF my = o.par.y + o.y THEN
            a$ = idetxt(o.txt)
            n = 1
            c = 0
            FOR i2 = 1 TO LEN(a$)
                a2$ = MID$(a$, i2, 1)
                IF a2$ = CHR$(0) THEN
                    n = n + 1
                ELSE
                    IF a$ <> "#" THEN c = c + 1
                END IF
            NEXT
            w = o.w
            c = c + n * 4 'add characters for bracing < > buttons
            whitespace = w - c
            spacing = whitespace \ (n + 1)
            'f2 = o.foc + 1
            'IF f2 < 1 OR f2 > n THEN
            'IF o.dft THEN f2 = o.dft
            'END IF
            n2 = 1
            a3$ = ""
            'LOCATE o.par.y + o.y, o.par.x + o.x
            x = o.par.x + o.x
            'COLOR 0, 7
            FOR i2 = 1 TO LEN(a$)
                a2$ = MID$(a$, i2, 1)
                IF a2$ <> CHR$(0) THEN a3$ = a3$ + a2$
                IF a2$ = CHR$(0) OR i2 = LEN(a$) THEN
                    'PRINT SPACE$(spacing);
                    x = x + spacing
                    'IF f2 = n2 THEN COLOR 15, 7 ELSE COLOR 0, 7
                    'PRINT "< ";
                    'COLOR 0, 7: idehPRINT a3$
                    'IF f2 = n2 THEN COLOR 15, 7 ELSE COLOR 0, 7
                    'IF n2 = o.foc + 1 THEN
                    'o.cx = x + 2: o.cy = o.par.y + o.y
                    'END IF
                    'PRINT " >";
                    'COLOR 0, 7
                    x2 = idehlen(a3$) + 4
                    IF mx >= x AND mx < x + x2 THEN info = n2: focus = f + n2 - 1


                    x = x + x2
                    a3$ = ""
                    n2 = n2 + 1
                END IF
            NEXT

        END IF 'my
    END IF 'mousedown

    IF focusoffset >= 0 AND focusoffset < n THEN
        f2 = f + focusoffset
        IF kk$ = CHR$(13) or kk$ = " " THEN
            info = focusoffset + 1
        END IF
    END IF

    f = f + n
END IF '3

IF t = 4 THEN 'checkbox

    IF mousedown THEN
        y = o.par.y + o.y
        x1 = o.par.x + o.x: x2 = x1 + 2
        IF o.nam THEN
            x2 = x2 + 1 + idehlen(idetxt(o.nam))
        END IF
        IF my = y THEN
            IF mx >= x1 AND mx <= x2 THEN
                focus = f
                o.sel = o.sel + 1: IF o.sel > 1 THEN o.sel = 0 'toggle
            END IF
        END IF
    END IF 'mousedown
    IF focusoffset = 0 THEN

        'a$ = idetxt(o.txt)
        'IF LEN(kk$) = 1 THEN
        'k = ASC(kk$)
        'IF k = 8 AND o.v1 > 0 THEN
        'a1$ = LEFT$(a$, o.v1 - 1)
        'IF o.v1 <= LEN(a$) THEN a2$ = RIGHT$(a$, LEN(a$) - o.v1) ELSE a2$ = ""
        'a$ = a1$ + a2$: o.v1 = o.v1 - 1
        'END IF
        'IF k >= 32 AND k <= 126 THEN
        'IF o.v1 > 0 THEN a1$ = LEFT$(a$, o.v1) ELSE a1$ = ""
        'IF o.v1 <= LEN(a$) THEN a2$ = RIGHT$(a$, LEN(a$) - o.v1) ELSE a2$ = ""
        'a$ = a1$ + kk$ + a2$: o.v1 = o.v1 + 1
        'END IF
        'idetxt(o.txt) = a$
        'END IF
        'IF kk$ = CHR$(0) + "S" THEN 'DEL
        'IF o.v1 > 0 THEN a1$ = LEFT$(a$, o.v1) ELSE a1$ = ""
        'IF o.v1 < LEN(a$) THEN a2$ = RIGHT$(a$, LEN(a$) - o.v1 - 1) ELSE a2$ = ""
        'a$ = a1$ + a2$
        'idetxt(o.txt) = a$
        'END IF
        ''cursor control
        'IF kk$ = CHR$(0) + "K" THEN o.v1 = o.v1 - 1
        'IF kk$ = CHR$(0) + "M" THEN o.v1 = o.v1 + 1
        'IF kk$ = CHR$(0) + "G" THEN o.v1 = 0
        'IF kk$ = CHR$(0) + "O" THEN o.v1 = LEN(a$)
        'IF o.v1 < 0 THEN o.v1 = 0
        'IF o.v1 > LEN(a$) THEN o.v1 = LEN(a$)

        IF kk$ = CHR$(0) + "H" THEN o.sel = 1
        IF kk$ = CHR$(0) + "P" THEN o.sel = 0
        IF kk$ = " " THEN
            o.sel = o.sel + 1: IF o.sel > 1 THEN o.sel = 0 'toggle
        END IF

    END IF 'in focus
    'hot-key focus
    IF LEN(altletter$) THEN
        IF o.nam THEN
            x = INSTR(idetxt(o.nam), "#")
            IF x THEN
                IF UCASE$(MID$(idetxt(o.nam), x + 1, 1)) = altletter$ THEN focus = f
            END IF
        END IF
    END IF
    f = f + 1
END IF '4

EXIT SUB
    selectcheck:
    IF KSHIFT AND o.issel = 0 THEN o.issel = -1: o.sx1 = o.v1
    IF KSHIFT = 0 THEN o.issel = 0
    RETURN
END SUB

FUNCTION idevbar (x, y, h, i2, n2)
i = i2: n = n2

'h is height in charatcers (inc. arrows)

'draw background & arrows
COLOR 0, 7
LOCATE y, x: PRINT CHR$(24);
LOCATE y + h - 1, x: PRINT CHR$(25);
FOR y2 = y + 1 TO y + h - 2
    LOCATE y2, x: PRINT chr$(176);
NEXT

'draw slider

IF n < 1 THEN n = 1
IF i < 1 THEN i = 1
IF i > n THEN i = n

IF h = 2 THEN
    idevbar = y 'not position for slider exists
    EXIT FUNCTION
END IF

IF h = 3 THEN
    idevbar = y + 1 'dummy value
    'no slider
    EXIT FUNCTION
END IF

IF h = 4 THEN
    IF n = 1 THEN
        idevbar = y + 1 'dummy value
        'no slider required for 1 item
        EXIT FUNCTION
    ELSE
        'show whichever is closer of the two positions
        p! = (i - 1) / (n - 1)
        IF p! < .5 THEN y2 = y + 1 ELSE y2 = y + 2
        LOCATE y2, x: PRINT chr$(219);
        idevbar = y2
        EXIT FUNCTION
    END IF
END IF

IF h > 4 THEN
    IF n = 1 THEN
        idevbar = y + h \ 4 'dummy value
        'no slider required for 1 item
        EXIT FUNCTION
    END IF
    IF i = 1 THEN
        y2 = y + 1
        LOCATE y2, x: PRINT chr$(219);
        idevbar = y2
        EXIT FUNCTION
    END IF
    IF i = n THEN
        y2 = y + h - 2
        LOCATE y2, x: PRINT chr$(219);
        idevbar = y2
        EXIT FUNCTION
    END IF
    'between i=1 and i=n
    p! = (i - 1) / (n - 1)
    p! = p! * (h - 4)
    y2 = y + 2 + INT(p!)
    LOCATE y2, x: PRINT chr$(219);
    idevbar = y2
    EXIT FUNCTION
END IF
END FUNCTION

SUB idewait
_DELAY 0.1
END SUB

SUB idewait4alt
'stub
END SUB

SUB idewait4mous
'stub
END SUB

FUNCTION idezchangepath$ (path$, newpath$)

idezchangepath$ = path$ 'default (for unsuccessful cases)

IF os$ = "WIN" THEN
    'go back a path
    IF newpath$ = ".." THEN
        FOR x = LEN(path$) TO 1 STEP -1
            a$ = MID$(path$, x, 1)
            IF a$ = "\" THEN
                idezchangepath$ = LEFT$(path$, x - 1)
                EXIT FOR
            END IF
        NEXT
        EXIT FUNCTION
    END IF
    'change drive
    IF LEN(newpath$) = 2 AND RIGHT$(newpath$, 1) = ":" THEN
        idezchangepath$ = newpath$
        EXIT FUNCTION
    END IF
    idezchangepath$ = path$ + "\" + newpath$
    EXIT FUNCTION
END IF

IF os$ = "LNX" THEN

    'go back a path
    IF newpath$ = ".." THEN
        FOR x = LEN(path$) TO 1 STEP -1
            a$ = MID$(path$, x, 1)
            IF a$ = "/" THEN
                idezchangepath$ = LEFT$(path$, x - 1)
                IF x = 1 THEN idezchangepath$ = "/" 'root path cannot be ""
                EXIT FOR
            END IF
        NEXT
        EXIT FUNCTION
    END IF
    IF path$ = "/" THEN idezchangepath$ = "/" + newpath$ ELSE idezchangepath$ = path$ + "/" + newpath$
    EXIT FUNCTION
END IF

END FUNCTION

FUNCTION idezfilelist$ (path$, method) 'method0=*.bas, method1=*.*
DIM sep AS STRING * 1
sep = CHR$(0)

IF os$ = "WIN" THEN
    OPEN ".\internal\temp\files.txt" FOR OUTPUT AS #150: CLOSE #150
    IF method = 0 THEN SHELL _HIDE "dir /b /ON /A-D " + QuotedFilename$(path$) + "\*.bas >.\internal\temp\files.txt"
    IF method = 1 THEN SHELL _HIDE "dir /b /ON /A-D " + QuotedFilename$(path$) + "\*.* >.\internal\temp\files.txt"
    filelist$ = ""
    OPEN ".\internal\temp\files.txt" FOR INPUT AS #150
    DO UNTIL EOF(150)
        LINE INPUT #150, a$
        IF LEN(a$) THEN 'skip blank entries
            IF filelist$ = "" THEN filelist$ = a$ ELSE filelist$ = filelist$ + sep + a$
        END IF
    LOOP
    CLOSE #150
    idezfilelist$ = filelist$
    EXIT FUNCTION
END IF

IF os$ = "LNX" THEN
    filelist$ = ""
    FOR i = 1 TO 2 - method
        OPEN "./internal/temp/files.txt" FOR OUTPUT AS #150: CLOSE #150
        IF method = 0 THEN
            IF i = 1 THEN SHELL _HIDE "find " + QuotedFilename$(path$) + " -maxdepth 1 -type f -name " + CHR$(34) + "*.bas" + CHR$(34) + " >./internal/temp/files.txt"
            IF i = 2 THEN SHELL _HIDE "find " + QuotedFilename$(path$) + " -maxdepth 1 -type f -name " + CHR$(34) + "*.BAS" + CHR$(34) + " >./internal/temp/files.txt"
        END IF
        IF method = 1 THEN
            IF i = 1 THEN SHELL _HIDE "find " + QuotedFilename$(path$) + " -maxdepth 1 -type f -name " + CHR$(34) + "*" + CHR$(34) + " >./internal/temp/files.txt"
        END IF
        OPEN "./internal/temp/files.txt" FOR INPUT AS #150
        DO UNTIL EOF(150)
            LINE INPUT #150, a$
            IF LEN(a$) = 0 THEN EXIT DO
            FOR x = LEN(a$) TO 1 STEP -1
                a2$ = MID$(a$, x, 1)
                IF a2$ = "/" THEN
                    a$ = RIGHT$(a$, LEN(a$) - x)
                    EXIT FOR
                END IF
            NEXT
            IF filelist$ = "" THEN filelist$ = a$ ELSE filelist$ = filelist$ + sep + a$
        LOOP
        CLOSE #150
    NEXT
    idezfilelist$ = filelist$
    EXIT FUNCTION
END IF

END FUNCTION

FUNCTION idezgetroot$
'note: does NOT including a trailing / or \ on the right

IF os$ = "WIN" THEN
    SHELL _HIDE "cd >.\internal\temp\root.txt"
    OPEN ".\internal\temp\root.txt" FOR INPUT AS #150
    LINE INPUT #150, a$
    idezgetroot$ = a$
    CLOSE #150
    EXIT FUNCTION
END IF

IF os$ = "LNX" THEN
    SHELL _HIDE "pwd >./internal/temp/root.txt"
    OPEN "./internal/temp/root.txt" FOR INPUT AS #150
    LINE INPUT #150, a$
    idezgetroot$ = a$
    CLOSE #150
    EXIT FUNCTION
END IF

END FUNCTION

FUNCTION idezpathlist$ (path$)
DIM sep AS STRING * 1
sep = CHR$(0)

IF os$ = "WIN" THEN
    OPEN ".\internal\temp\paths.txt" FOR OUTPUT AS #150: CLOSE #150
    a$ = "": IF RIGHT$(path$, 1) = ":" THEN a$ = "\" 'use a \ after a drive letter
    SHELL _HIDE "dir /b /ON /AD " + QuotedFilename$(path$ + a$) + " >.\internal\temp\paths.txt"
    pathlist$ = ""
    OPEN ".\internal\temp\paths.txt" FOR INPUT AS #150
    DO UNTIL EOF(150)
        LINE INPUT #150, a$
        IF pathlist$ = "" THEN pathlist$ = a$ ELSE pathlist$ = pathlist$ + sep + a$
    LOOP
    CLOSE #150
    'count instances of / or \
    c = 0
    FOR x = 1 TO LEN(path$)
        b$ = MID$(path$, x, 1)
        IF b$ = idepathsep$ THEN c = c + 1
    NEXT
    IF c >= 1 THEN
        IF LEN(pathlist$) THEN pathlist$ = ".." + sep + pathlist$ ELSE pathlist$ = ".."
    END IF
    'add drive paths
    FOR i = 0 TO 25
        IF LEN(pathlist$) THEN pathlist$ = pathlist$ + sep
        pathlist$ = pathlist$ + CHR$(65 + i) + ":"
    NEXT
    idezpathlist$ = pathlist$
    EXIT FUNCTION
END IF

IF os$ = "LNX" THEN
    pathlist$ = ""
    OPEN "./internal/temp/paths.txt" FOR OUTPUT AS #150: CLOSE #150
    SHELL _HIDE "find " + QuotedFilename$(path$) + " -maxdepth 1 -mindepth 1 -type d >./internal/temp/paths.txt"
    OPEN "./internal/temp/paths.txt" FOR INPUT AS #150
    DO UNTIL EOF(150)
        LINE INPUT #150, a$
        IF LEN(a$) = 0 THEN EXIT DO
        FOR x = LEN(a$) TO 1 STEP -1
            a2$ = MID$(a$, x, 1)
            IF a2$ = "/" THEN
                a$ = RIGHT$(a$, LEN(a$) - x)
                EXIT FOR
            END IF
        NEXT
        IF pathlist$ = "" THEN pathlist$ = a$ ELSE pathlist$ = pathlist$ + sep + a$
    LOOP
    CLOSE #150

    IF path$ <> "/" THEN
        a$ = ".."

        IF pathlist$ = "" THEN pathlist$ = a$ ELSE pathlist$ = a$ + sep + pathlist$
    END IF

    idezpathlist$ = pathlist$
    EXIT FUNCTION
END IF

END FUNCTION

FUNCTION ideztakepath$ (f$) 'assume f$ contains a filename with an optional path
p$ = ""

IF os$ = "WIN" THEN
    FOR i = LEN(f$) TO 1 STEP -1
        a$ = MID$(f$, i, 1)
        IF a$ = "\" THEN
            p$ = LEFT$(f$, i - 1)
            f$ = RIGHT$(f$, LEN(f$) - i)
            EXIT FOR
        END IF
    NEXT
    ideztakepath$ = p$
    EXIT FUNCTION
END IF

IF os$ = "LNX" THEN
    FOR i = LEN(f$) TO 1 STEP -1
        a$ = MID$(f$, i, 1)
        IF a$ = "/" THEN
            p$ = LEFT$(f$, i - 1)
            f$ = RIGHT$(f$, LEN(f$) - i)
            EXIT FOR
        END IF
    NEXT
    ideztakepath$ = p$
    EXIT FUNCTION
END IF

END FUNCTION

'file f$ exists, and may contain a path
'return the FULL path (even if it was passed as a relative path)
'f$ is altered to only contain the name of the actual file
'root$ is the path to apply relative paths to
FUNCTION idezgetfilepath$ (root$, f$)
'step #1: seperate file's name from its path (if any)
p$ = ideztakepath$(f$) 'note: this is a simple seperation of the string
'step #2: if path was undefined, set it to root
IF LEN(p$) = 0 THEN p$ = root$
'step #3: if path is relative, make it relative to root$
IF LEFT$(p$, 1) = "." THEN p$ = root$ + idepathsep$ + p$
'step #4: attempt a CHDIR to the path to (i)  validate its existance
'                                      & (ii) allow listing the paths full name
ideerror = 4 'path not found
p2$ = p$
IF os$ = "WIN" THEN
    IF RIGHT$(p2$, 1) = ":" THEN p2$ = p2$ + "\" 'force change to root of drive
END IF
CHDIR p2$
ideerror = 1
'step #5: get the path's full name (assume success)
IF os$ = "WIN" THEN
    SHELL _HIDE "cd >" + QuotedFilename$(ideroot$) + "\internal\temp\root.txt"
    OPEN ideroot$ + "\internal\temp\root.txt" FOR INPUT AS #150
    LINE INPUT #150, p$
    IF RIGHT$(p$, 1) = "\" THEN p$ = LEFT$(p$, LEN(p$) - 1) 'strip trailing \ after root drive path
    CLOSE #150
END IF
IF os$ = "LNX" THEN
    SHELL _HIDE "pwd >" + QuotedFilename$(ideroot$) + "/internal/temp/root.txt"
    OPEN ideroot$ + "/internal/temp/root.txt" FOR INPUT AS #150
    LINE INPUT #150, p$
    CLOSE #150
END IF
'step #6: restore root path (assume success)
CHDIR ideroot$
'important: no validation of f$ necessary
idezgetfilepath$ = p$
END FUNCTION

SUB initmouse
_MOUSESHOW
END SUB






FUNCTION idelayoutbox

'-------- generic dialog box header --------
PCOPY 0, 2
PCOPY 0, 1
SCREEN , , 1, 0
focus = 1
DIM p AS idedbptype
DIM o(1 TO 100) AS idedbotype
DIM oo AS idedbotype
DIM sep AS STRING * 1
sep = CHR$(0)
'-------- end of generic dialog box header --------

'-------- init --------
i = 0
idepar p, 60, 7, "Code Layout"

i = i + 1
o(i).typ = 4 'check box
o(i).y = 2
o(i).nam = idenewtxt("#Auto Spacing & Upper/Lowercase Formatting")
o(i).sel = ideautolayout

i = i + 1
o(i).typ = 4 'check box
o(i).y = 4
o(i).nam = idenewtxt("Auto #Indent -")
o(i).sel = ideautoindent

a2$ = str2$(ideautoindentsize)
i = i + 1
o(i).typ = 1
o(i).x = 20
o(i).y = 4
o(i).nam = idenewtxt("#Spacing")
o(i).txt = idenewtxt(a2$)
o(i).v1 = LEN(a2$)

i = i + 1
o(i).typ = 4
o(i).y = 6
o(i).nam = idenewtxt("Indent #SUBs and FUNCTIONs")
o(i).sel = ideindentsubs

i = i + 1
o(i).typ = 3
o(i).y = 7
o(i).txt = idenewtxt("OK" + sep + "#Cancel")
o(i).dft = 1
'-------- end of init --------

'-------- generic init --------
FOR i = 1 TO 100: o(i).par = p: NEXT 'set parent info of objects
'-------- end of generic init --------

DO 'main loop


    '-------- generic display dialog box & objects --------
    idedrawpar p
    f = 1: cx = 0: cy = 0
    FOR i = 1 TO 100
        IF o(i).typ THEN

            'prepare object
            o(i).foc = focus - f 'focus offset
            o(i).cx = 0: o(i).cy = 0
            idedrawobj o(i), f 'display object
            IF o(i).cx THEN cx = o(i).cx: cy = o(i).cy
        END IF
    NEXT i
    lastfocus = f - 1
    '-------- end of generic display dialog box & objects --------

    '-------- custom display changes --------
    '-------- end of custom display changes --------

    'update visual page and cursor position
    PCOPY 1, 0
    IF cx THEN SCREEN , , 0, 0: LOCATE cy, cx, 1: SCREEN , , 1, 0

    '-------- read input --------
    change = 0
    DO
        GetInput
        IF mWHEEL THEN change = 1
        IF KB THEN change = 1
        IF mCLICK THEN mousedown = 1: change = 1
        IF mRELEASE THEN mouseup = 1: change = 1
        IF mB THEN change = 1
        alt = KALT: IF alt <> oldalt THEN change = 1
        oldalt = alt
        _LIMIT 100
    LOOP UNTIL change
    IF alt THEN idehl = 1 ELSE idehl = 0
    'convert "alt+letter" scancode to letter's ASCII character
    altletter$ = ""
    IF alt THEN
        IF LEN(K$) = 1 THEN
            k = ASC(UCASE$(K$))
            IF k >= 65 AND k <= 90 THEN altletter$ = CHR$(k)
        END IF
    END IF
    SCREEN , , 0, 0: LOCATE , , 0: SCREEN , , 1, 0
    '-------- end of read input --------

    '-------- generic input response --------
    info = 0
    IF K$ = "" THEN K$ = CHR$(255)
    IF KSHIFT = 0 AND K$ = CHR$(9) THEN focus = focus + 1
    IF KSHIFT AND K$ = CHR$(9) THEN focus = focus - 1
    IF focus < 1 THEN focus = lastfocus
    IF focus > lastfocus THEN focus = 1
    f = 1
    FOR i = 1 TO 100
        t = o(i).typ
        IF t THEN
            focusoffset = focus - f
            ideobjupdate o(i), focus, f, focusoffset, K$, altletter$, mB, mousedown, mouseup, mX, mY, info, mWHEEL
        END IF
    NEXT
    '-------- end of generic input response --------

    'specific post controls

    a$ = idetxt(o(3).txt)
    IF LEN(a$) > 2 THEN a$ = LEFT$(a$, 2) '2 character limit
    FOR i = 1 TO LEN(a$)
        a = ASC(a$, i)
        IF i = 2 AND ASC(a$, 1) = 48 THEN a$ = "0": EXIT FOR
        IF a < 48 OR a > 57 THEN a$ = "": EXIT FOR
    NEXT
    IF LEN(a$) THEN
        a = VAL(a$)
        IF a > 64 THEN a$ = "64"
    END IF
    idetxt(o(3).txt) = a$

    IF K$ = CHR$(27) OR (focus = 6 AND info <> 0) THEN EXIT FUNCTION
    IF K$ = CHR$(13) OR (focus = 5 AND info <> 0) THEN
        'save changes
        v% = o(1).sel: IF v% <> 0 THEN v% = 1 'ideautolayout

        IF ideautolayout <> v% THEN ideautolayout = v%: idelayoutbox = 1
        v% = o(2).sel: IF v% <> 0 THEN v% = 1 'ideautoindent

        IF ideautoindent <> v% THEN ideautoindent = v%: idelayoutbox = 1
        v$ = idetxt(o(3).txt) 'ideautoindentsize
        IF v$ = "" THEN v$ = "4"
        v% = VAL(v$)
        IF v% < 0 OR v% > 64 THEN v% = 4
        IF ideautoindentsize <> v% THEN
            ideautoindentsize = v%
            IF ideautoindent <> 0 THEN idelayoutbox = 1
        END IF

    v% = o(4).sel: IF v% <> 0 THEN v% = 1 'ideindentsubs
    IF ideindentsubs <> v% THEN ideindentsubs = v%: idelayoutbox = 1

if ideautolayout then
        WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_AutoFormat", "TRUE"
else
        WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_AutoFormat", "FALSE"
end if
if ideautoindent then
        WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_AutoIndent", "TRUE"
else
        WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_AutoIndent", "FALSE"
end if
        WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_IndentSize", str$(ideautoindentsize)
if ideindentsubs then
    WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_IndentSUBs", "TRUE"
else
    WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_IndentSUBs", "FALSE"
end if
        EXIT FUNCTION
    END IF

    'end of custom controls

    mousedown = 0
    mouseup = 0
LOOP
END FUNCTION






FUNCTION idebackupbox

'-------- generic dialog box header --------
PCOPY 0, 2
PCOPY 0, 1
SCREEN , , 1, 0
focus = 1
DIM p AS idedbptype
DIM o(1 TO 100) AS idedbotype
DIM oo AS idedbotype
DIM sep AS STRING * 1
sep = CHR$(0)
'-------- end of generic dialog box header --------

'-------- init --------
i = 0
idepar p, 50, 5, "Backup/Undo"

a2$ = str2$(idebackupsize)
i = i + 1
o(i).typ = 1
o(i).y = 2
o(i).nam = idenewtxt("#Undo buffer limit (10-2000MB)")
o(i).txt = idenewtxt(a2$)
o(i).v1 = LEN(a2$)

i = i + 1
o(i).typ = 3
o(i).y = 5
o(i).txt = idenewtxt("OK" + sep + "#Cancel")
o(i).dft = 1
'-------- end of init --------

'-------- generic init --------
FOR i = 1 TO 100: o(i).par = p: NEXT 'set parent info of objects
'-------- end of generic init --------

DO 'main loop


    '-------- generic display dialog box & objects --------
    idedrawpar p
    f = 1: cx = 0: cy = 0
    FOR i = 1 TO 100
        IF o(i).typ THEN

            'prepare object
            o(i).foc = focus - f 'focus offset
            o(i).cx = 0: o(i).cy = 0
            idedrawobj o(i), f 'display object
            IF o(i).cx THEN cx = o(i).cx: cy = o(i).cy
        END IF
    NEXT i
    lastfocus = f - 1
    '-------- end of generic display dialog box & objects --------

    '-------- custom display changes --------
    '-------- end of custom display changes --------

    'update visual page and cursor position
    PCOPY 1, 0
    IF cx THEN SCREEN , , 0, 0: LOCATE cy, cx, 1: SCREEN , , 1, 0

    '-------- read input --------
    change = 0
    DO
        GetInput
        IF mWHEEL THEN change = 1
        IF KB THEN change = 1
        IF mCLICK THEN mousedown = 1: change = 1
        IF mRELEASE THEN mouseup = 1: change = 1
        IF mB THEN change = 1
        alt = KALT: IF alt <> oldalt THEN change = 1
        oldalt = alt
        _LIMIT 100
    LOOP UNTIL change
    IF alt THEN idehl = 1 ELSE idehl = 0
    'convert "alt+letter" scancode to letter's ASCII character
    altletter$ = ""
    IF alt THEN
        IF LEN(K$) = 1 THEN
            k = ASC(UCASE$(K$))
            IF k >= 65 AND k <= 90 THEN altletter$ = CHR$(k)
        END IF
    END IF
    SCREEN , , 0, 0: LOCATE , , 0: SCREEN , , 1, 0
    '-------- end of read input --------

    '-------- generic input response --------
    info = 0
    IF K$ = "" THEN K$ = CHR$(255)
    IF KSHIFT = 0 AND K$ = CHR$(9) THEN focus = focus + 1
    IF KSHIFT AND K$ = CHR$(9) THEN focus = focus - 1
    IF focus < 1 THEN focus = lastfocus
    IF focus > lastfocus THEN focus = 1
    f = 1
    FOR i = 1 TO 100
        t = o(i).typ
        IF t THEN
            focusoffset = focus - f
            ideobjupdate o(i), focus, f, focusoffset, K$, altletter$, mB, mousedown, mouseup, mX, mY, info, mWHEEL
        END IF
    NEXT
    '-------- end of generic input response --------

    'specific post controls

    a$ = idetxt(o(1).txt)
    IF LEN(a$) > 4 THEN a$ = LEFT$(a$, 4) '4 character limit
    FOR i = 1 TO LEN(a$)
        a = ASC(a$, i)
        IF i = 2 AND ASC(a$, 1) = 48 THEN a$ = "0": EXIT FOR
        IF a < 48 OR a > 57 THEN a$ = LEFT$(a$, i - 1): EXIT FOR
    NEXT
    IF focus <> 1 THEN
        a = VAL(a$)
        IF a < 10 THEN a$ = "10"
        IF a > 2000 THEN a$ = "2000"
    END IF
    idetxt(o(1).txt) = a$



    IF K$ = CHR$(27) OR (focus = 3 AND info <> 0) THEN EXIT FUNCTION

    IF K$ = CHR$(13) OR (focus = 2 AND info <> 0) THEN
        'save changes
        v$ = idetxt(o(1).txt) 'idebackupsize
        v& = VAL(v$)
        IF v& < 10 THEN v& = 10
        IF v& > 2000 THEN v& = 2000

        IF v& < idebackupsize THEN
            OPEN tmpdir$ + "undo2.bin" FOR OUTPUT AS #151: CLOSE #151
            ideundobase = 0
            ideundopos = 0
        END IF

        idebackupsize = v&
        WriteConfigSetting "'[GENERAL SETTINGS]", "BackupSize", str$(v&) + " 'in MB"
        idebackupbox = 1
        EXIT FUNCTION
    END IF

    'end of custom controls

    mousedown = 0
    mouseup = 0
LOOP
END FUNCTION




FUNCTION idemodifycommandbox
'-------- generic dialog box header --------
PCOPY 0, 2
PCOPY 0, 1
SCREEN , , 1, 0
focus = 1
DIM p AS idedbptype
DIM o(1 TO 100) AS idedbotype
DIM oo AS idedbotype
DIM sep AS STRING * 1
sep = CHR$(0)
'-------- end of generic dialog box header --------

'-------- init --------
i = 0
idepar p, 65, 5, "Modify COMMAND$"

a2$ = ModifyCOMMAND$
if len(a2$) > 0 then a2$ = MID$(a2$, 2)
i = i + 1
o(i).typ = 1
o(i).y = 2
o(i).nam = idenewtxt("#Enter text for COMMAND$")
o(i).txt = idenewtxt(a2$)
o(i).v1 = LEN(a2$)
if o(i).v1 > 0 then
    o(i).issel = -1
    o(i).sx1 = 0
end if

i = i + 1
o(i).typ = 3
o(i).y = 5
o(i).txt = idenewtxt("OK" + sep + "#Cancel")
o(i).dft = 1
'-------- end of init --------

'-------- generic init --------
FOR i = 1 TO 100: o(i).par = p: NEXT 'set parent info of objects
'-------- end of generic init --------

DO 'main loop


    '-------- generic display dialog box & objects --------
    idedrawpar p
    f = 1: cx = 0: cy = 0
    FOR i = 1 TO 100
        IF o(i).typ THEN

            'prepare object
            o(i).foc = focus - f 'focus offset
            o(i).cx = 0: o(i).cy = 0
            idedrawobj o(i), f 'display object
            IF o(i).cx THEN cx = o(i).cx: cy = o(i).cy
        END IF
    NEXT i
    lastfocus = f - 1
    '-------- end of generic display dialog box & objects --------

    '-------- custom display changes --------
    '-------- end of custom display changes --------

    'update visual page and cursor position
    PCOPY 1, 0
    IF cx THEN SCREEN , , 0, 0: LOCATE cy, cx, 1: SCREEN , , 1, 0

    '-------- read input --------
    change = 0
    DO
        GetInput
        IF mWHEEL THEN change = 1
        IF KB THEN change = 1
        IF mCLICK THEN mousedown = 1: change = 1
        IF mRELEASE THEN mouseup = 1: change = 1
        IF mB THEN change = 1
        alt = KALT: IF alt <> oldalt THEN change = 1
        oldalt = alt
        _LIMIT 100
    LOOP UNTIL change
    IF alt THEN idehl = 1 ELSE idehl = 0
    'convert "alt+letter" scancode to letter's ASCII character
    altletter$ = ""
    IF alt THEN
        IF LEN(K$) = 1 THEN
            k = ASC(UCASE$(K$))
            IF k >= 65 AND k <= 90 THEN altletter$ = CHR$(k)
        END IF
    END IF
    SCREEN , , 0, 0: LOCATE , , 0: SCREEN , , 1, 0
    '-------- end of read input --------

    '-------- generic input response --------
    info = 0
    IF K$ = "" THEN K$ = CHR$(255)
    IF KSHIFT = 0 AND K$ = CHR$(9) THEN focus = focus + 1
    IF KSHIFT AND K$ = CHR$(9) THEN focus = focus - 1
    IF focus < 1 THEN focus = lastfocus
    IF focus > lastfocus THEN focus = 1
    f = 1
    FOR i = 1 TO 100
        t = o(i).typ
        IF t THEN
            focusoffset = focus - f
            ideobjupdate o(i), focus, f, focusoffset, K$, altletter$, mB, mousedown, mouseup, mX, mY, info, mWHEEL
        END IF
    NEXT
    '-------- end of generic input response --------

    'specific post controls

    IF K$ = CHR$(27) OR (focus = 3 AND info <> 0) THEN EXIT FUNCTION

    IF K$ = CHR$(13) OR (focus = 2 AND info <> 0) THEN
        ModifyCOMMAND$ = " " + idetxt(o(1).txt)
        IF LTRIM$(RTRIM$(ModifyCOMMAND$)) = "" THEN ModifyCOMMAND$ = ""
        EXIT FUNCTION
    END IF

    'end of custom controls

    mousedown = 0
    mouseup = 0
LOOP
END FUNCTION

FUNCTION idegotobox
STATIC idegotobox_LastLineNum AS LONG

'-------- generic dialog box header --------
PCOPY 0, 2
PCOPY 0, 1
SCREEN , , 1, 0
focus = 1
DIM p AS idedbptype
DIM o(1 TO 100) AS idedbotype
DIM oo AS idedbotype
DIM sep AS STRING * 1
sep = CHR$(0)
'-------- end of generic dialog box header --------

'-------- init --------
i = 0
idepar p, 30, 5, "Go To Line"

IF idegotobox_LastLineNum > 0 THEN a2$ = str2$(idegotobox_LastLineNum) ELSE a2$ = ""
i = i + 1
o(i).typ = 1
o(i).y = 2
o(i).nam = idenewtxt("#Line")
o(i).txt = idenewtxt(a2$)
o(i).v1 = LEN(a2$)
if o(i).v1 > 0 then
    o(i).issel = -1
    o(i).sx1 = 0
end if

i = i + 1
o(i).typ = 3
o(i).y = 5
o(i).txt = idenewtxt("OK" + sep + "#Cancel")
o(i).dft = 1
'-------- end of init --------

'-------- generic init --------
FOR i = 1 TO 100: o(i).par = p: NEXT 'set parent info of objects
'-------- end of generic init --------

DO 'main loop


    '-------- generic display dialog box & objects --------
    idedrawpar p
    f = 1: cx = 0: cy = 0
    FOR i = 1 TO 100
        IF o(i).typ THEN

            'prepare object
            o(i).foc = focus - f 'focus offset
            o(i).cx = 0: o(i).cy = 0
            idedrawobj o(i), f 'display object
            IF o(i).cx THEN cx = o(i).cx: cy = o(i).cy
        END IF
    NEXT i
    lastfocus = f - 1
    '-------- end of generic display dialog box & objects --------

    '-------- custom display changes --------
    '-------- end of custom display changes --------

    'update visual page and cursor position
    PCOPY 1, 0
    IF cx THEN SCREEN , , 0, 0: LOCATE cy, cx, 1: SCREEN , , 1, 0

    '-------- read input --------
    change = 0
    DO
        GetInput
        IF mWHEEL THEN change = 1
        IF KB THEN change = 1
        IF mCLICK THEN mousedown = 1: change = 1
        IF mRELEASE THEN mouseup = 1: change = 1
        IF mB THEN change = 1
        alt = KALT: IF alt <> oldalt THEN change = 1
        oldalt = alt
        _LIMIT 100
    LOOP UNTIL change
    IF alt THEN idehl = 1 ELSE idehl = 0
    'convert "alt+letter" scancode to letter's ASCII character
    altletter$ = ""
    IF alt THEN
        IF LEN(K$) = 1 THEN
            k = ASC(UCASE$(K$))
            IF k >= 65 AND k <= 90 THEN altletter$ = CHR$(k)
        END IF
    END IF
    SCREEN , , 0, 0: LOCATE , , 0: SCREEN , , 1, 0
    '-------- end of read input --------

    '-------- generic input response --------
    info = 0
    IF K$ = "" THEN K$ = CHR$(255)
    IF KSHIFT = 0 AND K$ = CHR$(9) THEN focus = focus + 1
    IF KSHIFT AND K$ = CHR$(9) THEN focus = focus - 1
    IF focus < 1 THEN focus = lastfocus
    IF focus > lastfocus THEN focus = 1
    f = 1
    FOR i = 1 TO 100
        t = o(i).typ
        IF t THEN
            focusoffset = focus - f
            ideobjupdate o(i), focus, f, focusoffset, K$, altletter$, mB, mousedown, mouseup, mX, mY, info, mWHEEL
        END IF
    NEXT
    '-------- end of generic input response --------

    'specific post controls

    a$ = idetxt(o(1).txt)
    IF LEN(a$) > 8 THEN a$ = LEFT$(a$, 8) '8 character limit
    FOR i = 1 TO LEN(a$)
        a = ASC(a$, i)
        IF i = 2 AND ASC(a$, 1) = 48 THEN a$ = "0": EXIT FOR
        IF a < 48 OR a > 57 THEN a$ = LEFT$(a$, i - 1): EXIT FOR
    NEXT
    IF focus <> 1 THEN
        a = VAL(a$)
        IF a < 1 THEN a$ = "1"
    END IF
    idetxt(o(1).txt) = a$

    IF K$ = CHR$(27) OR (focus = 3 AND info <> 0) THEN EXIT FUNCTION

    IF K$ = CHR$(13) OR (focus = 2 AND info <> 0) THEN
        v$ = idetxt(o(1).txt)
        v& = VAL(v$)
        IF v& < 1 THEN v& = 1
        IF v& > iden THEN v& = iden
        idegotobox_LastLineNum = v&
        AddQuickNavHistory idecy
        idecy = v&
        ideselect = 0
        EXIT FUNCTION
    END IF

    'end of custom controls

    mousedown = 0
    mouseup = 0
LOOP
END FUNCTION





FUNCTION ideadvancedbox

'-------- generic dialog box header --------
PCOPY 0, 2
PCOPY 0, 1
SCREEN , , 1, 0
focus = 1
DIM p AS idedbptype
DIM o(1 TO 100) AS idedbotype
DIM oo AS idedbotype
DIM sep AS STRING * 1
sep = CHR$(0)
'-------- end of generic dialog box header --------

'-------- init --------
DIM Direct_Text$(100)

i = 0

i = i + 1
o(i).typ = 3 '
'o(i).y = y
o(i).txt = idenewtxt("#OK" + sep + "#Cancel")
o(i).dft = 1

y = 2 '2nd blank line

i = i + 1
o(i).typ = 4 'check box --- focus=3
o(i).y = y
o(i).nam = idenewtxt("Embed C++ debug information into executable")
o(i).sel = idedebuginfo
y = y + 1: Direct_Text$(y) = "     " + CHR$(254) + " Investigate crashes/freezes at C++ (not QB64) code level"
y = y + 1: Direct_Text$(y) = "     " + CHR$(254) + " Use internal/temp/debug batch file to debug your executable"
y = y + 1: Direct_Text$(y) = "     " + CHR$(254) + " Increases executable size"
y = y + 1: Direct_Text$(y) = "     " + CHR$(254) + " Makes public the names of variables in your program's code"
y = y + 1: Direct_Text$(y) = "     " + CHR$(254) + " QB64 libraries will be purged then rebuilt"
y = y + 1: Direct_Text$(y) = "     " + CHR$(254) + " This setting also affects command line compilation"

y = y + 2

o(1).y = y 'close button

'-------- end of init --------

idepar p, 75, y, "Advanced Options"

'-------- generic init --------
FOR i = 1 TO 100: o(i).par = p: NEXT 'set parent info of objects
'-------- end of generic init --------

DO 'main loop


    '-------- generic display dialog box & objects --------
    idedrawpar p
    f = 1: cx = 0: cy = 0
    FOR i = 1 TO 100
        IF o(i).typ THEN

            'prepare object
            o(i).foc = focus - f 'focus offset
            o(i).cx = 0: o(i).cy = 0
            idedrawobj o(i), f 'display object
            IF o(i).cx THEN cx = o(i).cx: cy = o(i).cy
        END IF
    NEXT i
    lastfocus = f - 1
    '-------- end of generic display dialog box & objects --------

    '-------- custom display changes --------
    FOR y = 1 TO 100
        IF LEN(Direct_Text$(y)) THEN
            COLOR 0, 7: LOCATE p.y + y, p.x + 1: PRINT Direct_Text$(y)
        END IF
    NEXT
    '-------- end of custom display changes --------

    'update visual page and cursor position
    PCOPY 1, 0
    IF cx THEN SCREEN , , 0, 0: LOCATE cy, cx, 1: SCREEN , , 1, 0

    '-------- read input --------
    change = 0
    DO
        GetInput
        IF mWHEEL THEN change = 1
        IF KB THEN change = 1
        IF mCLICK THEN mousedown = 1: change = 1
        IF mRELEASE THEN mouseup = 1: change = 1
        IF mB THEN change = 1
        alt = KALT: IF alt <> oldalt THEN change = 1
        oldalt = alt
        _LIMIT 100
    LOOP UNTIL change
    IF alt THEN idehl = 1 ELSE idehl = 0
    'convert "alt+letter" scancode to letter's ASCII character
    altletter$ = ""
    IF alt THEN
        IF LEN(K$) = 1 THEN
            k = ASC(UCASE$(K$))
            IF k >= 65 AND k <= 90 THEN altletter$ = CHR$(k)
        END IF
    END IF
    SCREEN , , 0, 0: LOCATE , , 0: SCREEN , , 1, 0
    '-------- end of read input --------

    '-------- generic input response --------
    info = 0
    IF K$ = "" THEN K$ = CHR$(255)
    IF KSHIFT = 0 AND K$ = CHR$(9) THEN focus = focus + 1
    IF KSHIFT AND K$ = CHR$(9) THEN focus = focus - 1
    IF focus < 1 THEN focus = lastfocus
    IF focus > lastfocus THEN focus = 1
    f = 1
    FOR i = 1 TO 100
        t = o(i).typ
        IF t THEN
            focusoffset = focus - f
            ideobjupdate o(i), focus, f, focusoffset, K$, altletter$, mB, mousedown, mouseup, mX, mY, info, mWHEEL
        END IF
    NEXT
    '-------- end of generic input response --------

    'specific post controls

    IF K$ = CHR$(27) OR (focus = 2 AND info <> 0) THEN EXIT FUNCTION

    IF K$ = CHR$(13) OR (focus = 1 AND info <> 0) THEN 'close
        'save changes

        'update idedebuginfo?
        v% = o(2).sel: IF v% <> 0 THEN v% = 1
        IF v% <> idedebuginfo THEN
            idedebuginfo = v%
        if idedebuginfo then
                 WriteConfigSetting "'[GENERAL SETTINGS]", "DebugInfo", "TRUE 'INTERNAL VARIABLE USE ONLY!! DO NOT MANUALLY CHANGE!"
        else
                 WriteConfigSetting "'[GENERAL SETTINGS]", "DebugInfo", "FALSE 'INTERNAL VARIABLE USE ONLY!! DO NOT MANUALLY CHANGE!"
        end if
            Include_GDB_Debugging_Info = idedebuginfo
            IF os$ = "WIN" THEN
                CHDIR "internal\c"
                SHELL _HIDE "cmd /c purge_all_precompiled_content_win.bat"
                CHDIR "..\.."
            END IF
            IF os$ = "LNX" THEN
                CHDIR "./internal/c"

                IF INSTR(_OS$, "[MACOSX]") THEN
                    SHELL _HIDE "./purge_all_precompiled_content_osx.command"
                ELSE
                    SHELL _HIDE "./purge_all_precompiled_content_lnx.sh"
                END IF
                CHDIR "../.."
            END IF
            idechangemade = 1 'force recompilation
        END IF

        '...


        EXIT FUNCTION
    END IF













    'end of custom controls

    mousedown = 0
    mouseup = 0
LOOP
END FUNCTION







SUB idemessagebox (titlestr$, messagestr$)

'-------- generic dialog box header --------
PCOPY 0, 2
PCOPY 0, 1
SCREEN , , 1, 0
focus = 1
DIM p AS idedbptype
DIM o(1 TO 100) AS idedbotype
DIM oo AS idedbotype
DIM sep AS STRING * 1
sep = CHR$(0)
'-------- end of generic dialog box header --------

'-------- init --------
i = 0
w = LEN(messagestr$) + 2
w2 = LEN(titlestr$) + 4
IF w < w2 THEN w = w2
idepar p, w, 4, titlestr$

i = i + 1
o(i).typ = 3
o(i).y = 4
o(i).txt = idenewtxt("OK")
o(i).dft = 1
'-------- end of init --------

'-------- generic init --------
FOR i = 1 TO 100: o(i).par = p: NEXT 'set parent info of objects
'-------- end of generic init --------

DO 'main loop


    '-------- generic display dialog box & objects --------
    idedrawpar p
    f = 1: cx = 0: cy = 0
    FOR i = 1 TO 100
        IF o(i).typ THEN

            'prepare object
            o(i).foc = focus - f 'focus offset
            o(i).cx = 0: o(i).cy = 0
            idedrawobj o(i), f 'display object
            IF o(i).cx THEN cx = o(i).cx: cy = o(i).cy
        END IF
    NEXT i
    lastfocus = f - 1
    '-------- end of generic display dialog box & objects --------

    '-------- custom display changes --------
    COLOR 0, 7: LOCATE p.y + 2, p.x + 2: PRINT messagestr$;
    '-------- end of custom display changes --------

    'update visual page and cursor position
    PCOPY 1, 0
    IF cx THEN SCREEN , , 0, 0: LOCATE cy, cx, 1: SCREEN , , 1, 0

    '-------- read input --------
    change = 0
    DO
        GetInput
        IF mWHEEL THEN change = 1
        IF KB THEN change = 1
        IF mCLICK THEN mousedown = 1: change = 1
        IF mRELEASE THEN mouseup = 1: change = 1
        IF mB THEN change = 1
        alt = KALT: IF alt <> oldalt THEN change = 1
        oldalt = alt
        _LIMIT 100
    LOOP UNTIL change
    IF alt THEN idehl = 1 ELSE idehl = 0
    'convert "alt+letter" scancode to letter's ASCII character
    altletter$ = ""
    IF alt THEN
        IF LEN(K$) = 1 THEN
            k = ASC(UCASE$(K$))
            IF k >= 65 AND k <= 90 THEN altletter$ = CHR$(k)
        END IF
    END IF
    SCREEN , , 0, 0: LOCATE , , 0: SCREEN , , 1, 0
    '-------- end of read input --------

    '-------- generic input response --------
    info = 0
    IF K$ = "" THEN K$ = CHR$(255)
    IF KSHIFT = 0 AND K$ = CHR$(9) THEN focus = focus + 1
    IF KSHIFT AND K$ = CHR$(9) THEN focus = focus - 1
    IF focus < 1 THEN focus = lastfocus
    IF focus > lastfocus THEN focus = 1
    f = 1
    FOR i = 1 TO 100
        t = o(i).typ
        IF t THEN
            focusoffset = focus - f
            ideobjupdate o(i), focus, f, focusoffset, K$, altletter$, mB, mousedown, mouseup, mX, mY, info, mWHEEL
        END IF
    NEXT
    '-------- end of generic input response --------

    'specific post controls
    IF K$ = CHR$(27) OR K$ = CHR$(13) OR (focus = 1 AND info <> 0) THEN EXIT SUB
    'end of custom controls

    mousedown = 0
    mouseup = 0
LOOP
END SUB



FUNCTION ideyesnobox$ (titlestr$, messagestr$) 'returns "Y" or "N"
'-------- generic dialog box header --------
PCOPY 3, 0
PCOPY 0, 2
PCOPY 0, 1
SCREEN , , 1, 0
focus = 1
DIM p AS idedbptype
DIM o(1 TO 100) AS idedbotype
DIM oo AS idedbotype
DIM sep AS STRING * 1
sep = CHR$(0)
'-------- end of generic dialog box header --------

'-------- init --------
i = 0
w = LEN(messagestr$) + 2
w2 = LEN(titlestr$) + 4
IF w < w2 THEN w = w2
idepar p, w, 4, titlestr$

i = i + 1
o(i).typ = 3
o(i).y = 4
o(i).txt = idenewtxt("#Yes" + sep + "#No")
o(i).dft = 1
'-------- end of init --------

'-------- generic init --------
FOR i = 1 TO 100: o(i).par = p: NEXT 'set parent info of objects
'-------- end of generic init --------

DO 'main loop

    '-------- generic display dialog box & objects --------
    idedrawpar p
    f = 1: cx = 0: cy = 0
    FOR i = 1 TO 100
        IF o(i).typ THEN
            'prepare object
            o(i).foc = focus - f 'focus offset
            o(i).cx = 0: o(i).cy = 0
            idedrawobj o(i), f 'display object
            IF o(i).cx THEN cx = o(i).cx: cy = o(i).cy
        END IF
    NEXT i
    lastfocus = f - 1
    '-------- end of generic display dialog box & objects --------

    '-------- custom display changes --------
    COLOR 0, 7: LOCATE p.y + 2, p.x + 2: PRINT messagestr$;
    '-------- end of custom display changes --------

    'update visual page and cursor position
    PCOPY 1, 0

    IF cx THEN SCREEN , , 0, 0: LOCATE cy, cx, 1: SCREEN , , 1, 0

    '-------- read input --------
    change = 0
    DO
        GetInput
        IF mWHEEL THEN change = 1
        IF KB THEN change = 1
        IF mCLICK THEN mousedown = 1: change = 1
        IF mRELEASE THEN mouseup = 1: change = 1
        IF mB THEN change = 1
        alt = KALT: IF alt <> oldalt THEN change = 1
        oldalt = alt
        _LIMIT 100
    LOOP UNTIL change
    IF alt THEN idehl = 1 ELSE idehl = 0
    'convert "alt+letter" scancode to letter's ASCII character
    altletter$ = ""
    IF alt THEN
        IF LEN(K$) = 1 THEN
            k = ASC(UCASE$(K$))
            IF k >= 65 AND k <= 90 THEN altletter$ = CHR$(k)
        END IF
    END IF
    SCREEN , , 0, 0: LOCATE , , 0: SCREEN , , 1, 0
    '-------- end of read input --------

    IF UCASE$(K$) = "Y" THEN altletter$ = "Y"
    IF UCASE$(K$) = "N" THEN altletter$ = "N"

    '-------- generic input response --------
    info = 0
    IF K$ = "" THEN K$ = CHR$(255)
    IF KSHIFT = 0 AND K$ = CHR$(9) THEN focus = focus + 1
    IF KSHIFT AND K$ = CHR$(9) THEN focus = focus - 1
    IF focus < 1 THEN focus = lastfocus
    IF focus > lastfocus THEN focus = 1
    f = 1
    FOR i = 1 TO 100
        t = o(i).typ
        IF t THEN
            focusoffset = focus - f
            ideobjupdate o(i), focus, f, focusoffset, K$, altletter$, mB, mousedown, mouseup, mX, mY, info, mWHEEL
        END IF
    NEXT
    '-------- end of generic input response --------

    IF K$ = CHR$(27) THEN
        ideyesnobox$ = "N"
        EXIT FUNCTION
    END IF

    IF info THEN
        IF info = 1 THEN ideyesnobox$ = "Y" ELSE ideyesnobox$ = "N"
        EXIT FUNCTION
    END IF

    'end of custom controls
    mousedown = 0
    mouseup = 0
LOOP

END FUNCTION 'yes/no box



FUNCTION ideandroidbox

'-------- generic dialog box header --------
PCOPY 0, 2
PCOPY 0, 1
SCREEN , , 1, 0
focus = 1
DIM p AS idedbptype
DIM o(1 TO 100) AS idedbotype
DIM oo AS idedbotype
DIM sep AS STRING * 1
sep = CHR$(0)
'-------- end of generic dialog box header --------

'-------- init --------
i = 0

idepar p, 75, 15 - 4 - 4, "Google Android Options"

i = i + 1
o(i).typ = 4 'check box
o(i).y = 2
o(i).nam = idenewtxt("Enable #Run Menu Commands")
o(i).sel = IdeAndroidMenu

'a2$ = IdeAndroidStartScript
'IF a2$ = "" THEN a2$ = "programs\android\start_android.bat"
'i = i + 1
'o(i).typ = 1
'o(i).y = 7
'o(i).nam = idenewtxt(CHR$(34) + "Start Android Project" + CHR$(34) + " Script")
'o(i).txt = idenewtxt(a2$)
'o(i).v1 = LEN(a2$)


'a2$ = IdeAndroidMakeScript
'IF a2$ = "" THEN a2$ = "programs\android\make_android.bat"
'i = i + 1
'o(i).typ = 1
'o(i).y = 11 - 4
'o(i).nam = idenewtxt(CHR$(34) + "Make Android Project Only" + CHR$(34) + " Script")
'o(i).txt = idenewtxt(a2$)
'o(i).v1 = LEN(a2$)

i = i + 1
o(i).typ = 3
o(i).y = 15 - 4 - 4
o(i).txt = idenewtxt("OK" + sep + "#Cancel")
o(i).dft = 1
'-------- end of init --------

'-------- generic init --------
FOR i = 1 TO 100: o(i).par = p: NEXT 'set parent info of objects
'-------- end of generic init --------

DO 'main loop


    '-------- generic display dialog box & objects --------
    idedrawpar p
    f = 1: cx = 0: cy = 0
    FOR i = 1 TO 100
        IF o(i).typ THEN

            'prepare object
            o(i).foc = focus - f 'focus offset
            o(i).cx = 0: o(i).cy = 0
            idedrawobj o(i), f 'display object
            IF o(i).cx THEN cx = o(i).cx: cy = o(i).cy
        END IF
    NEXT i
    lastfocus = f - 1
    '-------- end of generic display dialog box & objects --------

    '-------- custom display changes --------
    COLOR 8, 7: LOCATE p.y + 3, p.x + 4: PRINT "Projects are created at:";
    COLOR 8, 7: LOCATE p.y + 4, p.x + 6: PRINT "qb64\programs\android\";
    COLOR 3, 7
    PRINT "bas_file_name_without_extension";
    COLOR 8, 7: PRINT "\";
    '    COLOR 8, 7: LOCATE p.y + 9, p.x + 4: PRINT "Script file is launched from within project's folder";
    'COLOR 8, 7: LOCATE p.y + 13 - 4, p.x + 4: PRINT "Script file is launched from within project's folder";

    '-------- end of custom display changes --------

    'update visual page and cursor position
    PCOPY 1, 0
    IF cx THEN SCREEN , , 0, 0: LOCATE cy, cx, 1: SCREEN , , 1, 0

    '-------- read input --------
    change = 0
    DO
        GetInput
        IF mWHEEL THEN change = 1
        IF KB THEN change = 1
        IF mCLICK THEN mousedown = 1: change = 1
        IF mRELEASE THEN mouseup = 1: change = 1
        IF mB THEN change = 1
        alt = KALT: IF alt <> oldalt THEN change = 1
        oldalt = alt
        _LIMIT 100
    LOOP UNTIL change
    IF alt THEN idehl = 1 ELSE idehl = 0
    'convert "alt+letter" scancode to letter's ASCII character
    altletter$ = ""
    IF alt THEN
        IF LEN(K$) = 1 THEN
            k = ASC(UCASE$(K$))
            IF k >= 65 AND k <= 90 THEN altletter$ = CHR$(k)
        END IF
    END IF
    SCREEN , , 0, 0: LOCATE , , 0: SCREEN , , 1, 0
    '-------- end of read input --------

    '-------- generic input response --------
    info = 0
    IF K$ = "" THEN K$ = CHR$(255)
    IF KSHIFT = 0 AND K$ = CHR$(9) THEN focus = focus + 1
    IF KSHIFT AND K$ = CHR$(9) THEN focus = focus - 1
    IF focus < 1 THEN focus = lastfocus
    IF focus > lastfocus THEN focus = 1
    f = 1
    FOR i = 1 TO 100
        t = o(i).typ
        IF t THEN
            focusoffset = focus - f
            ideobjupdate o(i), focus, f, focusoffset, K$, altletter$, mB, mousedown, mouseup, mX, mY, info, mWHEEL
        END IF
    NEXT
    '-------- end of generic input response --------

    'specific post controls

    a$ = idetxt(o(2).txt)
    IF LEN(a$) > 256 THEN a$ = LEFT$(a$, 256)
    idetxt(o(2).txt) = a$
    a$ = idetxt(o(3).txt)
    IF LEN(a$) > 256 THEN a$ = LEFT$(a$, 256)
    idetxt(o(3).txt) = a$

    IF K$ = CHR$(27) OR (focus = 3 AND info <> 0) THEN EXIT FUNCTION
    IF K$ = CHR$(13) OR (focus = 2 AND info <> 0) THEN
        v% = o(1).sel
        IF v% < IdeAndroidMenu THEN
            menusize(5) = menusize(5) - 2
        END IF
        IF v% > IdeAndroidMenu THEN
            menusize(5) = menusize(5) + 2
        END IF
    if v% then
            WriteConfigSetting "'[ANDROID MENU]", "IDE_AndroidMenu", "TRUE"
        ELSE
            WriteConfigSetting "'[ANDROID MENU]", "IDE_AndroidMenu", "FALSE"
        end if

        'v$ = ""
        'IF LEN(v$) > 256 THEN v$ = LEFT$(v$, 256)
        'IF LEN(v$) < 256 THEN v$ = v$ + SPACE$(256 - LEN(v$))
        'v3$ = idetxt(o(3 - 1).txt)
        'IF LEN(v3$) > 256 THEN v3$ = LEFT$(v3$, 256)
        'IF LEN(v3$) < 256 THEN v3$ = v3$ + SPACE$(256 - LEN(v3$))
        '    WriteConfigSetting "'[ANDROID MENU]", "IDE_AndroidMakeScript$",  v3$
        '    WriteConfigSetting "'[ANDROID MENU]", "IDE_AndroidStartScript$", v$

        IdeAndroidMenu = o(1).sel
        'IdeAndroidStartScript = "" 'idetxt(o(2).txt)
        'IdeAndroidMakeScript = idetxt(o(3 - 1).txt)

        EXIT FUNCTION
    END IF

    'end of custom controls

    mousedown = 0
    mouseup = 0
LOOP
END FUNCTION





FUNCTION idedisplaybox

'-------- generic dialog box header --------
PCOPY 0, 2
PCOPY 0, 1
SCREEN , , 1, 0
focus = 1
DIM p AS idedbptype
DIM o(1 TO 100) AS idedbotype
DIM oo AS idedbotype
DIM sep AS STRING * 1
sep = CHR$(0)
'-------- end of generic dialog box header --------

'-------- init --------
i = 0

'idepar p, 60, 16, "Display"
'note: manually set window position in case display to set too large by accident
p.x = (80 \ 2) - 60 \ 2
p.y = (25 \ 2) - 16 \ 2
p.w = 60
p.h = 18
p.nam = idenewtxt("Display")

a2$ = str2$(idewx)
i = i + 1
o(i).typ = 1
o(i).x = 16
o(i).y = 2
o(i).nam = idenewtxt("#Width")
o(i).txt = idenewtxt(a2$)
o(i).v1 = LEN(a2$)

a2$ = str2$(idewy + idesubwindow)
i = i + 1
o(i).typ = 1
o(i).x = 15
o(i).y = 5
o(i).nam = idenewtxt("#Height")
o(i).txt = idenewtxt(a2$)
o(i).v1 = LEN(a2$)

i = i + 1
o(i).typ = 4 'check box
o(i).y = 8
o(i).nam = idenewtxt("Restore window #position at startup")
if IDE_AutoPosition then o(i).sel = 1

i = i + 1
o(i).typ = 4 'check box
o(i).y = 10
o(i).nam = idenewtxt("Custom #Font:")
o(i).sel = idecustomfont

a2$ = idecustomfontfile$
i = i + 1
o(i).typ = 1
o(i).x = 10
o(i).y = 12
o(i).nam = idenewtxt("File #Name")
o(i).txt = idenewtxt(a2$)
o(i).v1 = LEN(a2$)

a2$ = str2$(idecustomfontheight)
i = i + 1
o(i).typ = 1
o(i).x = 10
o(i).y = 15
o(i).nam = idenewtxt("#Row Height (Pixels)")
o(i).txt = idenewtxt(a2$)
o(i).v1 = LEN(a2$)

i = i + 1
o(i).typ = 3
o(i).y = 18
o(i).txt = idenewtxt("OK" + sep + "#Cancel")
o(i).dft = 1
'-------- end of init --------

'-------- generic init --------
FOR i = 1 TO 100: o(i).par = p: NEXT 'set parent info of objects
'-------- end of generic init --------

DO 'main loop


    '-------- generic display dialog box & objects --------
    idedrawpar p
    f = 1: cx = 0: cy = 0
    FOR i = 1 TO 100
        IF o(i).typ THEN

            'prepare object
            o(i).foc = focus - f 'focus offset
            o(i).cx = 0: o(i).cy = 0
            idedrawobj o(i), f 'display object
            IF o(i).cx THEN cx = o(i).cx: cy = o(i).cy
        END IF
    NEXT i
    lastfocus = f - 1
    '-------- end of generic display dialog box & objects --------

    '-------- custom display changes --------
    COLOR 0, 7: LOCATE p.y + 2, p.x + 2: PRINT "Window Size -";
    COLOR 0, 7: LOCATE p.y + 10, p.x + 29: PRINT " Monospace TTF Font ";
    '-------- end of custom display changes --------

    'update visual page and cursor position
    PCOPY 1, 0
    IF cx THEN SCREEN , , 0, 0: LOCATE cy, cx, 1: SCREEN , , 1, 0

    '-------- read input --------
    change = 0
    DO
        GetInput
        IF mWHEEL THEN change = 1
        IF KB THEN change = 1
        IF mCLICK THEN mousedown = 1: change = 1
        IF mRELEASE THEN mouseup = 1: change = 1
        IF mB THEN change = 1
        alt = KALT: IF alt <> oldalt THEN change = 1
        oldalt = alt
        _LIMIT 100
    LOOP UNTIL change
    IF alt THEN idehl = 1 ELSE idehl = 0
    'convert "alt+letter" scancode to letter's ASCII character
    altletter$ = ""
    IF alt THEN
        IF LEN(K$) = 1 THEN
            k = ASC(UCASE$(K$))
            IF k >= 65 AND k <= 90 THEN altletter$ = CHR$(k)
        END IF
    END IF
    SCREEN , , 0, 0: LOCATE , , 0: SCREEN , , 1, 0
    '-------- end of read input --------

    '-------- generic input response --------
    info = 0
    IF K$ = "" THEN K$ = CHR$(255)
    IF KSHIFT = 0 AND K$ = CHR$(9) THEN focus = focus + 1
    IF KSHIFT AND K$ = CHR$(9) THEN focus = focus - 1
    IF focus < 1 THEN focus = lastfocus
    IF focus > lastfocus THEN focus = 1
    f = 1
    FOR i = 1 TO 100
        t = o(i).typ
        IF t THEN
            focusoffset = focus - f
            ideobjupdate o(i), focus, f, focusoffset, K$, altletter$, mB, mousedown, mouseup, mX, mY, info, mWHEEL
        END IF
    NEXT
    '-------- end of generic input response --------

    'specific post controls

    a$ = idetxt(o(1).txt)
    IF LEN(a$) > 3 THEN a$ = LEFT$(a$, 3) '3 character limit
    FOR i = 1 TO LEN(a$)
        a = ASC(a$, i)
        IF a < 48 OR a > 57 THEN a$ = "": EXIT FOR
        IF i = 2 AND ASC(a$, 1) = 48 THEN a$ = "0": EXIT FOR
    NEXT
    IF focus <> 1 THEN
        IF LEN(a$) THEN a = VAL(a$) ELSE a = 0
        IF a < 80 THEN a$ = "80"
    END IF
    idetxt(o(1).txt) = a$

    a$ = idetxt(o(2).txt)
    IF LEN(a$) > 3 THEN a$ = LEFT$(a$, 3) '3 character limit
    FOR i = 1 TO LEN(a$)
        a = ASC(a$, i)
        IF a < 48 OR a > 57 THEN a$ = "": EXIT FOR
        IF i = 2 AND ASC(a$, 1) = 48 THEN a$ = "0": EXIT FOR
    NEXT
    IF focus <> 2 THEN
        IF LEN(a$) THEN a = VAL(a$) ELSE a = 0
        IF a < 25 THEN a$ = "25"
    END IF
    idetxt(o(2).txt) = a$

    a$ = idetxt(o(5).txt)
    IF LEN(a$) > 1024 THEN a$ = LEFT$(a$, 1024)
    idetxt(o(5).txt) = a$

    a$ = idetxt(o(6).txt)
    IF LEN(a$) > 2 THEN a$ = LEFT$(a$, 2) '2 character limit
    FOR i = 1 TO LEN(a$)
        a = ASC(a$, i)
        IF a < 48 OR a > 57 THEN a$ = "": EXIT FOR
        IF i = 2 AND ASC(a$, 1) = 48 THEN a$ = "0": EXIT FOR
    NEXT
    IF focus <> 5 THEN
        IF LEN(a$) THEN a = VAL(a$) ELSE a = 0
        IF a < 8 THEN a$ = "8"
    END IF
    idetxt(o(6).txt) = a$



    IF K$ = CHR$(27) OR (focus = 8 AND info <> 0) THEN EXIT FUNCTION
    IF K$ = CHR$(13) OR (focus = 7 AND info <> 0) THEN

        x = 0 'change to custom font

        'get size in v%
        v$ = idetxt(o(6).txt): IF v$ = "" THEN v$ = "0"
        v% = VAL(v$)
        IF v% < 8 THEN v% = 8
        IF v% > 99 THEN v% = 99
        IF v% <> idecustomfontheight THEN x = 1

        IF o(4).sel <> idecustomfont THEN
            IF o(4).sel = 0 THEN
                _FONT 16
                _FREEFONT idecustomfonthandle
            ELSE
                x = 1
            END IF
        END IF


        v$ = idetxt(o(5).txt): IF v$ <> idecustomfontfile$ THEN x = 1

        IF o(4).sel = 1 AND x = 1 THEN
            oldhandle = idecustomfonthandle
            idecustomfonthandle = _LOADFONT(v$, v%, "MONOSPACE")
            IF idecustomfonthandle = -1 THEN
                'failed! - revert to default settings
                o(4).sel = 0: idetxt(o(5).txt) = "c:\windows\fonts\lucon.ttf": idetxt(o(6).txt) = "21": _FONT 16
            ELSE
                _FONT idecustomfonthandle
            END IF
            IF idecustomfont = 1 THEN _FREEFONT oldhandle
        END IF

        'save changes
        v$ = idetxt(o(1).txt): IF v$ = "" THEN v$ = "0"
        v% = VAL(v$)
        IF v% < 80 THEN v% = 80
        IF v% > 999 THEN v% = 999
        IF v% <> idewx THEN idedisplaybox = 1
        idewx = v%


        v$ = idetxt(o(2).txt): IF v$ = "" THEN v$ = "0"
        v% = VAL(v$)
        IF v% < 25 THEN v% = 25
        IF v% > 999 THEN v% = 999
        IF v% <> idewy THEN idedisplaybox = 1
        idewy = v% - idesubwindow

        v% = o(3).sel
        IF v% <> 0 THEN v% = -1
        IDE_AutoPosition = v%

        v% = o(4).sel
        IF v% <> 0 THEN v% = 1
        idecustomfont = v%

        v$ = idetxt(o(5).txt)
        IF LEN(v$) > 1024 THEN v$ = LEFT$(v$, 1024)
        idecustomfontfile$ = v$
        v$ = v$ + SPACE$(1024 - LEN(v$))

        v$ = idetxt(o(6).txt): IF v$ = "" THEN v$ = "0"
        v% = VAL(v$)
        IF v% < 8 THEN v% = 8
        IF v% > 99 THEN v% = 99
        idecustomfontheight = v%


        WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_Width", str$(idewx)
        WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_Height", str$(idewy)
        IF idecustomfont THEN
            WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_CustomFont", "TRUE"
        ELSE
            WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_CustomFont", "FALSE"
        END IF
        IF IDE_AutoPosition THEN
            WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_AutoPosition", "TRUE"
        ELSE
            WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_AutoPosition", "FALSE"
        END IF
        WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_CustomFont$", idecustomfontfile$
        WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_CustomFontSize", str$(idecustomfontheight)


        EXIT FUNCTION
    END IF

    'end of custom controls

    mousedown = 0
    mouseup = 0
LOOP
END FUNCTION

FUNCTION idechoosecolorsbox
DIM bkpIDECommentColor AS _UNSIGNED LONG, bkpIDEMetaCommandColor AS _UNSIGNED LONG
DIM bkpIDEQuoteColor AS _UNSIGNED LONG, bkpIDETextColor AS _UNSIGNED LONG
DIM bkpIDEBackgroundColor AS _UNSIGNED LONG
DIM bkpIDEBackgroundColor2 AS _UNSIGNED LONG
DIM SelectionIndicator$(1 to 6)

bkpIDECommentColor = IDECommentColor
bkpIDEMetaCommandColor = IDEMetaCommandColor
bkpIDEQuoteColor = IDEQuoteColor
bkpIDETextColor = IDETextColor
bkpIDEBackgroundColor = IDEBackgroundColor
bkpIDEBackgroundColor2 = IDEBackgroundColor2

clipBefore$ = _CLIPBOARD$

'-------- generic dialog box header --------
PCOPY 0, 2
PCOPY 0, 1
SCREEN , , 1, 0
focus = 1
DIM p AS idedbptype
DIM o(1 TO 100) AS idedbotype
DIM oo AS idedbotype
DIM sep AS STRING * 1
sep = CHR$(0)
'-------- end of generic dialog box header --------

'-------- init --------
i = 0
idepar p, 45, 13, "Colors"

l$ = CHR$(16) + "Normal Text"
l$ = l$ + sep + " Strings"
l$ = l$ + sep + " Metacommands"
l$ = l$ + sep + " Comments"
l$ = l$ + sep + " Background"
l$ = l$ + sep + " Current line background"

i = i + 1
o(i).typ = 2
o(i).y = 1
o(i).w = 27: o(i).h = 7
o(i).txt = idenewtxt(l$)
o(i).sel = 1
SelectedITEM = 1
PrevFocus = 1
o(i).nam = idenewtxt("#Item:")

a2$ = str2$(_RED32(IDETextColor))
i = i + 1
o(i).typ = 1
o(i).x = 33
o(i).y = 2
o(i).nam = idenewtxt("#R")
o(i).txt = idenewtxt(a2$)
o(i).v1 = LEN(a2$)
o(i).issel = -1
o(i).sx1 = 0

a2$ = str2$(_GREEN32(IDETextColor))
i = i + 1
o(i).typ = 1
o(i).x = 33
o(i).y = 5
o(i).nam = idenewtxt("#G")
o(i).txt = idenewtxt(a2$)
o(i).v1 = LEN(a2$)
o(i).issel = -1
o(i).sx1 = 0

a2$ = str2$(_BLUE32(IDETextColor))
i = i + 1
o(i).typ = 1
o(i).x = 33
o(i).y = 8
o(i).nam = idenewtxt("#B")
o(i).txt = idenewtxt(a2$)
o(i).v1 = LEN(a2$)
o(i).issel = -1
o(i).sx1 = 0

i = i + 1
o(i).typ = 3
o(i).y = 13
o(i).txt = idenewtxt("#OK" + sep + "Restore #defaults" + sep + "#Cancel")
o(i).dft = 1
'-------- end of init --------

'-------- generic init --------
FOR i = 1 TO 100: o(i).par = p: NEXT 'set parent info of objects
'-------- end of generic init --------

DO 'main loop

    '-------- generic display dialog box & objects --------
    idedrawpar p
    f = 1: cx = 0: cy = 0
    FOR i = 1 TO 100
        IF o(i).typ THEN

            'prepare object
            o(i).foc = focus - f 'focus offset
            o(i).cx = 0: o(i).cy = 0
            idedrawobj o(i), f 'display object
            IF o(i).cx THEN cx = o(i).cx: cy = o(i).cy
        END IF
    NEXT i
    lastfocus = f - 1
    '-------- end of generic display dialog box & objects --------

    '-------- custom display changes --------
    _palettecolor 1, IDEBackgroundColor, 0
    _palettecolor 6, IDEBackgroundColor2, 0
    _palettecolor 11, IDECommentColor, 0
    _palettecolor 10, IDEMetaCommandColor, 0
    _palettecolor 14, IDEQuoteColor, 0
    _palettecolor 13, IDETextColor, 0

    SELECT CASE SelectedITEM
        CASE 1: COLOR 13, 1 'Normal text
        CASE 2: COLOR 14, 1 'Strings
        CASE 3: COLOR 10, 1 'Metacommands
        CASE 4: COLOR 11, 1 'Comments
        CASE 5: COLOR 1, 1 'Background
        CASE 6: COLOR 6, 6 'Current line background
    END SELECT

    LOCATE p.y + 11, p.x + 5: PRINT " Enter new RGB values for the item ";
    '-------- end of custom display changes --------

    'update visual page and cursor position
    PCOPY 1, 0
    IF cx THEN SCREEN , , 0, 0: LOCATE cy, cx, 1: SCREEN , , 1, 0

    '-------- read input --------
    change = 0
    DO
        GetInput
        IF mWHEEL THEN change = 1
        IF KB THEN change = 1
        IF mCLICK THEN mousedown = 1: change = 1
        IF mRELEASE THEN mouseup = 1: change = 1
        IF mB THEN change = 1
        alt = KALT: IF alt <> oldalt THEN change = 1
        oldalt = alt

        'Monitor _CLIPBOARD$; If a new RGB value is copied to memory in a format
        'like (0, 0, 0) it'll be used for the current item (useful for copying
        'from color pickers elsewhere, like http://www.w3schools.com/colors/colors_picker.asp)
        clipNow$ = _CLIPBOARD$
        IF clipNow$ <> clipBefore$ THEN
            clipBefore$ = clipNow$
            'Parse new clipboard contents for ###, ###, ###
            FindComma1 = INSTR(clipNow$, ",")
            IF FindComma1 > 0 THEN
                FindComma2 = INSTR(FindComma1 + 1, clipNow$, ",")
                IF FindComma2 > 0 THEN
                    r$ = "": g$ = "": b$ = ""
                    FOR i = FindComma1 - 1 TO 1 STEP -1
                        IF ASC(clipNow$, i) >= 48 AND ASC(clipNow$, i) <= 57 THEN
                            r$ = MID$(clipNow$, i, 1) + r$
                        ELSE
                            EXIT FOR
                        END IF
                    NEXT i

                    FOR i = FindComma1 + 1 TO FindComma2 - 1
                        IF ASC(clipNow$, i) = 32 OR (ASC(clipNow$, i) >= 48 AND ASC(clipNow$, i) <= 57) THEN
                            g$ = g$ + MID$(clipNow$, i, 1)
                        ELSE
                            EXIT FOR
                        END IF
                    NEXT i

                    FOR i = FindComma2 + 1 TO LEN(clipNow$)
                        IF ASC(clipNow$, i) = 32 OR (ASC(clipNow$, i) >= 48 AND ASC(clipNow$, i) <= 57) THEN
                            b$ = b$ + MID$(clipNow$, i, 1)
                        ELSE
                            EXIT FOR
                        END IF
                    NEXT i

                    idetxt(o(2).txt) = str2$(VAL(r$))
                    idetxt(o(3).txt) = str2$(VAL(g$))
                    idetxt(o(4).txt) = str2$(VAL(b$))
                    change = 1
                END IF
            END IF
        END IF
        _LIMIT 100
    LOOP UNTIL change
    IF alt THEN idehl = 1 ELSE idehl = 0
    'convert "alt+letter" scancode to letter's ASCII character
    altletter$ = ""
    IF alt THEN
        IF LEN(K$) = 1 THEN
            k = ASC(UCASE$(K$))
            IF k >= 65 AND k <= 90 THEN altletter$ = CHR$(k)
        END IF
    END IF
    SCREEN , , 0, 0: LOCATE , , 0: SCREEN , , 1, 0
    '-------- end of read input --------

    '-------- generic input response --------
    info = 0
    IF K$ = "" THEN K$ = CHR$(255)
    IF KSHIFT = 0 AND K$ = CHR$(9) THEN focus = focus + 1
    IF KSHIFT AND K$ = CHR$(9) THEN focus = focus - 1
    IF focus < 1 THEN focus = lastfocus
    IF focus > lastfocus THEN focus = 1
    f = 1
    FOR i = 1 TO 100
        t = o(i).typ
        IF t THEN
            focusoffset = focus - f
            ideobjupdate o(i), focus, f, focusoffset, K$, altletter$, mB, mousedown, mouseup, mX, mY, info, mWHEEL
        END IF
    NEXT
    '-------- end of generic input response --------

    'specific post controls
    IF focus <> PrevFocus THEN
        'Always start with RGB values selected upon getting focus
        PrevFocus = focus
        IF focus >= 2 AND focus <= 4 THEN
            o(focus).v1 = LEN(idetxt(o(focus).txt))
            o(focus).issel = -1
            o(focus).sx1 = 0
        END IF
    END IF

    ChangedWithKeys = 0
    IF K$ = CHR$(0) + CHR$(72) AND (focus = 2 OR focus = 3 OR focus = 4) THEN 'Up
        idetxt(o(focus).txt) = str2$(VAL(idetxt(o(focus).txt)) + 1)
        o(focus).issel = -1: o(focus).sx1 = 0: o(focus).v1 = LEN(idetxt(o(focus).txt))
        ChangedWithKeys = -1
    END IF

    IF K$ = CHR$(0) + CHR$(80) AND (focus = 2 OR focus = 3 OR focus = 4) THEN 'Down
        idetxt(o(focus).txt) = str2$(VAL(idetxt(o(focus).txt)) - 1)
        o(focus).issel = -1: o(focus).sx1 = 0: o(focus).v1 = LEN(idetxt(o(focus).txt))
        ChangedWithKeys = -1
    END IF

    IF SelectedITEM <> o(1).sel AND o(1).sel > 0 THEN
        SelectedITEM = o(1).sel
        FOR i = 1 to 6: SelectionIndicator$(i) = " ": NEXT i
        SelectionIndicator$(SelectedITEM) = CHR$(16)

        i = 0
        i = i + 1: l$ = SelectionIndicator$(i) + "Normal Text"
        i = i + 1: l$ = l$ + sep + SelectionIndicator$(i) + "Strings"
        i = i + 1: l$ = l$ + sep + SelectionIndicator$(i) + "Metacommands"
        i = i + 1: l$ = l$ + sep + SelectionIndicator$(i) + "Comments"
        i = i + 1: l$ = l$ + sep + SelectionIndicator$(i) + "Background"
        i = i + 1: l$ = l$ + sep + SelectionIndicator$(i) + "Current line background"
        idetxt(o(1).txt) = l$

        ChangeTextBoxes:
        SELECT CASE SelectedITEM
            CASE 1: CurrentColor~& = IDETextColor
            CASE 2: CurrentColor~& = IDEQuoteColor
            CASE 3: CurrentColor~& = IDEMetaCommandColor
            CASE 4: CurrentColor~& = IDECommentColor
            CASE 5: CurrentColor~& = IDEBackgroundColor
            CASE 6: CurrentColor~& = IDEBackgroundColor2
        END SELECT
        idetxt(o(2).txt) = str2$(_RED32(CurrentColor~&))
        idetxt(o(3).txt) = str2$(_GREEN32(CurrentColor~&))
        idetxt(o(4).txt) = str2$(_BLUE32(CurrentColor~&))
    END IF

    'Check RGB values range (0-255)
    FOR checkRGB = 2 to 4
        a$ = idetxt(o(checkRGB).txt)
        IF LEN(a$) > 3 THEN a$ = LEFT$(a$, 3) '3 character limit
        FOR i = 1 TO LEN(a$)
            a = ASC(a$, i)
            IF i = 2 AND ASC(a$, 1) = 48 THEN a$ = "0": EXIT FOR
            IF a < 48 OR a > 57 THEN a$ = "": EXIT FOR
        NEXT
        IF LEN(a$) THEN
            a = VAL(a$)
            IF a > 255 THEN a$ = "255"
            IF a < 0 THEN a$ = "0"
        ELSE
            IF ChangedWithKeys = -1 THEN a$ = "0"
        END IF
        idetxt(o(checkRGB).txt) = a$
    NEXT checkRGB

    CurrentColor~& = _RGB32(VAL(idetxt(o(2).txt)), VAL(idetxt(o(3).txt)), VAL(idetxt(o(4).txt)))
    SELECT CASE SelectedITEM
        CASE 1: IDETextColor = CurrentColor~& 'Normal text
        CASE 2: IDEQuoteColor = CurrentColor~& 'Strings
        CASE 3: IDEMetaCommandColor = CurrentColor~& 'Metacommands
        CASE 4: IDECommentColor = CurrentColor~& 'Comments
        CASE 5: IDEBackgroundColor = CurrentColor~& 'Background
        CASE 6: IDEBackgroundColor2 = CurrentColor~& 'Current line background
    END SELECT

    IF K$ = CHR$(27) OR (focus = 7 AND info <> 0) THEN
        IDECommentColor = bkpIDECommentColor
        IDEMetaCommandColor = bkpIDEMetaCommandColor
        IDEQuoteColor = bkpIDEQuoteColor
        IDETextColor = bkpIDETextColor
        IDEBackgroundColor = bkpIDEBackgroundColor
        IDEBackgroundColor2 = bkpIDEBackgroundColor2
        EXIT FUNCTION
    END IF

    IF (focus = 6 AND info <> 0) THEN
        IDECommentColor = _RGB32(85, 255, 255)
        IDEMetaCommandColor = _RGB32(85, 255, 85)
        IDEQuoteColor = _RGB32(255, 255, 85)
        IDETextColor = _RGB32(255, 255, 255)
        IDEBackgroundColor = _RGB32(0, 0, 170)
        IDEBackgroundColor2 = _RGB32(0, 0, 128)
        info = 0
        GOTO ChangeTextBoxes
    END IF

    IF (focus = 5 AND info <> 0) OR _
       (focus = 1 AND K$ = CHR$(13)) OR _
       (focus = 2 AND K$ = CHR$(13)) OR _
       (focus = 3 AND K$ = CHR$(13)) OR _
       (focus = 4 AND K$ = CHR$(13)) OR _
       (focus = 5 AND K$ = CHR$(13)) THEN
        'save changes
        FOR i = 1 TO 6
            SELECT CASE i
                CASE 1: CurrentColor~& = IDETextColor: colorid$ = "TextColor"
                CASE 2: CurrentColor~& = IDEQuoteColor: colorid$ = "QuoteColor"
                CASE 3: CurrentColor~& = IDEMetaCommandColor: colorid$ = "MetaCommandColor"
                CASE 4: CurrentColor~& = IDECommentColor: colorid$ = "CommentColor"
                CASE 5: CurrentColor~& = IDEBackgroundColor: colorid$ = "BackgroundColor"
                CASE 6: CurrentColor~& = IDEBackgroundColor2: colorid$ = "BackgroundColor2"
            END SELECT
            r$ = str2$(_RED32(CurrentColor~&))
            g$ = str2$(_GREEN32(CurrentColor~&))
            b$ = str2$(_BLUE32(CurrentColor~&))

            RGBString$ = "_RGB32(" + r$ + "," + g$ + "," + b$ + ")"
            WriteConfigSetting "'[IDE COLOR SETTINGS]", colorid$, RGBString$
        NEXT i
        EXIT FUNCTION
    END IF

    'end of custom controls

    mousedown = 0
    mouseup = 0
LOOP
END FUNCTION



SUB iderestrict417 (p417)
x = 0
IF p417 AND 4 THEN x = x + 1
IF p417 AND 8 THEN x = x + 1
IF x > 1 THEN p417 = p417 AND 243
END SUB










FUNCTION CTRL2
IF MacOSX THEN
    IF _KEYDOWN(100309) THEN CTRL2 = 1
    IF _KEYDOWN(100310) THEN CTRL2 = 1
END IF
END FUNCTION



SUB GetInput
STATIC ASCvalue$

IF iCHECKLATER THEN iCHECKLATER = 0: EXIT SUB
'Clear/Update immediate return values
iCHANGED = 0
KSTATECHANGED = 0
mCLICK = 0: mCLICK2 = 0: mRELEASE = 0: mRELEASE2 = 0
mWHEEL = 0
K$ = "": KB = 0
mOB = mB: mOB2 = mB2
KOALT = KALT: KALTPRESS = 0: KALTRELEASE = 0
'Flush INKEY$ buffer (for good measure)
DO: LOOP UNTIL INKEY$ = ""
'Keyboard event?
k = _KEYHIT

'Steve Edit on 07-04-2014 to add extended ASCII creation with ALT-plus numkeys
IF (_KEYDOWN(100307) OR _KEYDOWN(100308)) AND (k >= -57 AND k <= -48) THEN
    ASCvalue$ = ASCvalue$ + CHR$(-k)
END IF
IF NOT _KEYDOWN(100307) AND NOT _KEYDOWN(100308) THEN
    IF LEN(ASCvalue$) THEN
        KB = VAL(RIGHT$(ASCvalue$, 3))
        IF KB > 0 AND KB < 256 THEN
            K$ = CHR$(KB)
            k = KB
            iCHANGED = -1
            AltSpecial = -1
        END IF
        ASCvalue$ = ""
        EXIT SUB
    END IF
END IF
'End of Edit





IF k THEN
    IF k < 0 THEN k = -k: release = 1
    'modifiers
    IF k = KEY_LSHIFT OR k = KEY_RSHIFT THEN
        IF release = 1 THEN KSHIFT = 0 ELSE KSHIFT = -1
        iCHANGED = -1: KSTATECHANGED = -1
    END IF
    IF k = KEY_LALT OR k = KEY_RALT THEN
        IF release = 1 THEN
            KALT = 0: KALTRELEASE = -1
        ELSE
            KALT = -1: KALTPRESS = -1
        END IF
        iCHANGED = -1: KSTATECHANGED = -1
    END IF
    IF k = KEY_LCTRL OR k = KEY_RCTRL THEN
        IF release = 1 THEN KCTRL = 0: KCONTROL = 0 ELSE KCTRL = -1: KCONTROL = -1
        iCHANGED = -1: KSTATECHANGED = -1
    END IF
    IF k = KEY_LAPPLE OR k = KEY_RAPPLE THEN
        IF release = 1 THEN KCONTROL = 0 ELSE KCONTROL = -1
        iCHANGED = -1: KSTATECHANGED = -1
    END IF
    'presses
    IF release = 0 THEN
        iCHANGED = -1
        IF k <= 255 THEN K$ = CHR$(k)
        IF k >= 256 AND k <= 65535 AND ((k AND 255) = 0) THEN K$ = CHR$(0) + CHR$(k \ 256)
        KB = k
    END IF
    IF iCHANGED THEN EXIT SUB
END IF
DO WHILE _MOUSEINPUT
    iCHANGED = 1
    if MouseButtonSwapped then
        mB = _MOUSEBUTTON(2): mB2 = _MOUSEBUTTON(1)
    else
        mB = _MOUSEBUTTON(1): mB2 = _MOUSEBUTTON(2)
    end if
    mWHEEL = mWHEEL + _MOUSEWHEEL
    mX = _MOUSEX: mY = _MOUSEY
    IF mB <> 0 AND mOB = 0 THEN mCLICK = -1: EXIT SUB
    IF mB2 <> 0 AND mOB2 = 0 THEN mCLICK2 = -1: EXIT SUB
    IF mB = 0 AND mOB <> 0 THEN mRELEASE = -1: EXIT SUB
    IF mB2 = 0 AND mOB2 <> 0 THEN mRELEASE2 = -1: EXIT SUB
LOOP
END SUB




SUB Help_ShowText

STATIC setup
IF setup = 0 AND UBOUND(back$) = 1 THEN
    setup = 1
    a$ = Wiki(Back$(1))
    WikiParse a$
END IF

REDIM Help_LineLen(Help_wh)

COLOR 7, 0

'CLS
'FOR y = Help_wy1 - 1 TO Help_wy2 + 1
'    FOR x = Help_wx1 - 1 TO Help_wx2 + 1
'        LOCATE y, x: PRINT chr$(219);
'    NEXT
'NEXT

sy = Help_wy1
FOR y = Help_sy TO Help_sy + Help_wh - 1
    IF y <= help_h THEN
        'PRINT CVL(MID$(Help_Line$, (y - 1) * 4 + 1, 4)), LEN(Help_Txt$)
        l = CVL(MID$(Help_Line$, (y - 1) * 4 + 1, 4))
        x = l
        x3 = 1

        sx = Help_wx1
        c = ASC(Help_Txt$, x): col = ASC(Help_Txt$, x + 1)
        LOCATE sy, sx
        DO UNTIL c = 13
            COLOR col AND 15, col \ 16
            IF Help_Select = 2 THEN
                IF y >= Help_SelY1 AND y <= Help_SelY2 THEN
                    IF x3 >= Help_SelX1 AND x3 <= Help_SelX2 THEN
                        COLOR 0, 7
                    END IF
                END IF
            END IF
            IF x3 >= Help_sx THEN
                IF sx <= Help_wx2 THEN
                    PRINT CHR$(c);
                    sx = sx + 1
                END IF
            END IF
            x3 = x3 + 1: x = x + 4: c = ASC(Help_Txt$, x): col = ASC(Help_Txt$, x + 1)
        LOOP

        Help_LineLen(y - Help_sy) = x3 - 1

        FOR x4 = 1 TO Help_wx2 - POS(0) + 1
            IF col = 0 THEN col = 7
            COLOR col AND 15, col \ 16
            IF Help_Select = 2 THEN
                IF y >= Help_SelY1 AND y <= Help_SelY2 THEN
                    IF x3 >= Help_SelX1 AND x3 <= Help_SelX2 THEN
                        COLOR 0, 7
                    END IF
                END IF
            END IF
            PRINT " ";
            x3 = x3 + 1
        NEXT

    ELSE

        sx = Help_wx1
        LOCATE sy, sx
        x3 = Help_sx
        FOR x4 = 1 TO Help_ww
            COLOR 7, 0
            IF Help_Select = 2 THEN
                IF y >= Help_SelY1 AND y <= Help_SelY2 THEN
                    IF x3 >= Help_SelX1 AND x3 <= Help_SelX2 THEN
                        COLOR 0, 7
                    END IF
                END IF
            END IF
            PRINT " ";
            x3 = x3 + 1
        NEXT
        Help_LineLen(y - Help_sy) = 0

    END IF
    sy = sy + 1
NEXT

'LOCATE Help_cy - Help_sy + Help_wy1, Help_cx - Help_sx + Help_wx1
'COLOR 15, 4
'PRINT CHR$(SCREEN(CSRLIN, POS(0)));

'c = 0
'DO
'    old_kcontrol = KCONTROL
'    GetInput
'    IF KB > 0 THEN c = 1
'    IF mCLICK THEN c = 1
'    IF mWHEEL THEN c = 1
'    IF KCONTROL AND old_kcontrol = 0 THEN c = 0
'    IF mB THEN c = 1
'LOOP UNTIL c

END SUB


FUNCTION idesearchedbox$

'-------- generic dialog box header --------
PCOPY 0, 2
PCOPY 0, 1
SCREEN , , 1, 0
focus = 1
DIM p AS idedbptype
DIM o(1 TO 100) AS idedbotype
DIM oo AS idedbotype
DIM sep AS STRING * 1
sep = CHR$(0)
'-------- end of generic dialog box header --------

'-------- init --------






ln = 0
l$ = ""
fh = FREEFILE
OPEN ".\internal\temp\searched.bin" FOR BINARY AS #fh: a$ = SPACE$(LOF(fh)): GET #fh, , a$
a$ = RIGHT$(a$, LEN(a$) - 2)
DO WHILE LEN(a$)
    ai = INSTR(a$, CRLF)
    IF ai THEN
        f$ = LEFT$(a$, ai - 1): IF ai = LEN(a$) - 1 THEN a$ = "" ELSE a$ = RIGHT$(a$, LEN(a$) - ai - 3)
        IF LEN(l$) THEN l$ = l$ + sep + f$ ELSE l$ = f$
        ln = ln + 1
    END IF
LOOP
CLOSE #fh

if ln = 0 then
    l$ = sep
end if

'72,19

h = idewy + idesubwindow - 9
IF ln < h THEN h = ln
IF h < 3 THEN h = 3

i = 0
idepar p, 20, h, ""
p.x = idewx - 24
p.y = idewy - 6 - h

i = i + 1
o(i).typ = 2
o(i).x = -1: o(i).y = 0

o(i).w = 22: o(i).h = h
o(i).txt = idenewtxt(l$)
o(i).sel = 1
o(i).nam = idenewtxt("Find")

'i = i + 1
'o(i).typ = 3
'o(i).y = idewy - 6
'o(i).txt = idenewtxt("#OK" + sep + "#Cancel")
'o(i).dft = 1

'-------- end of init --------

'-------- generic init --------
FOR i = 1 TO 100: o(i).par = p: NEXT 'set parent info of objects
'-------- end of generic init --------

DO 'main loop

    '-------- generic display dialog box & objects --------
    idedrawpar p
    f = 1: cx = 0: cy = 0
    FOR i = 1 TO 100
        IF o(i).typ THEN
            'prepare object

            o(i).foc = focus - f 'focus offset
            o(i).cx = 0: o(i).cy = 0
            idedrawobj o(i), f 'display object
            IF o(i).cx THEN cx = o(i).cx: cy = o(i).cy
        END IF
    NEXT i
    lastfocus = f - 1
    '-------- end of generic display dialog box & objects --------

    '-------- custom display changes --------
    '-------- end of custom display changes --------

    'update visual page and cursor position
    PCOPY 1, 0
    IF cx THEN SCREEN , , 0, 0: LOCATE cy, cx, 1: SCREEN , , 1, 0

    '-------- read input --------
    change = 0
    DO
        GetInput
        IF mWHEEL THEN change = 1
        IF KB THEN change = 1
        IF mCLICK THEN mousedown = 1: change = 1
        IF mRELEASE THEN mouseup = 1: change = 1
        IF mB THEN change = 1
        alt = KALT: IF alt <> oldalt THEN change = 1
        oldalt = alt
        _LIMIT 100
    LOOP UNTIL change
    IF alt THEN idehl = 1 ELSE idehl = 0
    'convert "alt+letter" scancode to letter's ASCII character
    altletter$ = ""
    IF alt THEN
        IF LEN(K$) = 1 THEN
            k = ASC(UCASE$(K$))
            IF k >= 65 AND k <= 90 THEN altletter$ = CHR$(k)
        END IF
    END IF
    SCREEN , , 0, 0: LOCATE , , 0: SCREEN , , 1, 0
    '-------- end of read input --------

    '-------- generic input response --------
    info = 0
    IF K$ = "" THEN K$ = CHR$(255)
    IF KSHIFT = 0 AND K$ = CHR$(9) THEN focus = focus + 1
    IF KSHIFT AND K$ = CHR$(9) THEN focus = focus - 1
    IF focus < 1 THEN focus = lastfocus
    IF focus > lastfocus THEN focus = 1
    f = 1
    FOR i = 1 TO 100
        t = o(i).typ
        IF t THEN
            focusoffset = focus - f
            ideobjupdate o(i), focus, f, focusoffset, K$, altletter$, mB, mousedown, mouseup, mX, mY, info, mWHEEL
        END IF
    NEXT
    '-------- end of generic input response --------

    'quick exit
    IF mCLICK THEN
        IF mX < p.x - 1 OR mY < p.y OR mX > p.x + p.w + 2 OR mY > p.y + p.h + 1 THEN
            idesearchedbox$ = ""
            EXIT FUNCTION
        END IF
    END IF

    IF K$ = CHR$(27) THEN
        idesearchedbox$ = ""
        EXIT FUNCTION
    END IF

    IF mCLICK THEN
        IF mX > p.x - 1 AND mY > p.y AND mX < p.x + p.w + 2 AND mY < p.y + p.h + 1 THEN
            f$ = idetxt(o(1).stx)
            idesearchedbox$ = f$
            EXIT FUNCTION
        END IF
    END IF

    IF K$ = CHR$(13) OR (info = 1 AND focus = 1) THEN
        f$ = idetxt(o(1).stx)
        idesearchedbox$ = f$
        EXIT FUNCTION
    END IF

    'end of custom controls
    mousedown = 0
    mouseup = 0
LOOP



END FUNCTION


SUB IdeImportBookmarks (f2$)
IdeBmkN = 0
f$ = CRLF + f2$ + CRLF
fh = FREEFILE: OPEN ".\internal\temp\bookmarks.bin" FOR BINARY AS #fh: a$ = SPACE$(LOF(fh)): GET #fh, , a$: CLOSE #fh
x = INSTR(UCASE$(a$), UCASE$(f$))
IF x THEN 'retrieve bookmark data
    l = CVL(MID$(a$, x + LEN(f$), 4))
    x1 = x + LEN(f$) + 4
    d$ = MID$(a$, x1, l)
    n = l \ 16
    FOR i = 1 TO n
        by = CVL(MID$(d$, (i - 1) * 16 + 1, 4))
        bx = CVL(MID$(d$, (i - 1) * 16 + 1 + 4, 4))
        IF by <= iden THEN
            IdeBmkN = IdeBmkN + 1
            IF IdeBmkN > UBOUND(IdeBmk) THEN x = UBOUND(IdeBmk) * 2: REDIM _PRESERVE IdeBmk(x) AS IdeBmkType
            IdeBmk(IdeBmkN).y = by
            IdeBmk(IdeBmkN).x = bx
            IdeBmk(IdeBmkN).reserved = 0: IdeBmk(IdeBmkN).reserved2 = 0
        END IF
    NEXT
END IF
END SUB

SUB IdeSaveBookmarks (f2$)
f$ = CRLF + f2$ + CRLF
fh = FREEFILE: OPEN ".\internal\temp\bookmarks.bin" FOR BINARY AS #fh: a$ = SPACE$(LOF(fh)): GET #fh, , a$: CLOSE #fh
x = INSTR(UCASE$(a$), UCASE$(f$))
IF x THEN 'remove any old bookmark data
    l = CVL(MID$(a$, x + LEN(f$), 4))
    x2 = x + LEN(f$) + 4 + l - 1
    a$ = LEFT$(a$, x - 1) + RIGHT$(a$, LEN(a$) - x2)
END IF
'add new bookmark data
'build bookmark data
d$ = ""
FOR i = 1 TO IdeBmkN
    d$ = d$ + MKL$(IdeBmk(i).y) + MKL$(IdeBmk(i).x) + MKL$(IdeBmk(i).reserved) + MKL$(IdeBmk(i).reserved2)
NEXT
a$ = f$ + MKL$(LEN(d$)) + d$ + a$
fh = FREEFILE: OPEN ".\internal\temp\bookmarks.bin" FOR OUTPUT AS #fh: CLOSE #fh
fh = FREEFILE: OPEN ".\internal\temp\bookmarks.bin" FOR BINARY AS #fh: PUT #fh, , a$: CLOSE #fh
END SUB

FUNCTION iderecentbox$

'-------- generic dialog box header --------
PCOPY 0, 2
PCOPY 0, 1
SCREEN , , 1, 0
focus = 1
DIM p AS idedbptype
DIM o(1 TO 100) AS idedbotype
DIM oo AS idedbotype
DIM sep AS STRING * 1
sep = CHR$(0)
'-------- end of generic dialog box header --------

'-------- init --------






l$ = ""
fh = FREEFILE
OPEN ".\internal\temp\recent.bin" FOR BINARY AS #fh: a$ = SPACE$(LOF(fh)): GET #fh, , a$
a$ = RIGHT$(a$, LEN(a$) - 2)
DO WHILE LEN(a$)
    ai = INSTR(a$, CRLF)
    IF ai THEN
        f$ = LEFT$(a$, ai - 1): IF ai = LEN(a$) - 1 THEN a$ = "" ELSE a$ = RIGHT$(a$, LEN(a$) - ai - 3)
        IF LEN(l$) THEN l$ = l$ + sep + f$ ELSE l$ = f$
    END IF
LOOP
CLOSE #fh

'72,19
i = 0
idepar p, idewx - 8, idewy + idesubwindow - 6, "Open"

i = i + 1
o(i).typ = 2
o(i).y = 1
'68
o(i).w = idewx - 12: o(i).h = idewy + idesubwindow - 9
o(i).txt = idenewtxt(l$)
o(i).sel = 1
o(i).nam = idenewtxt("Recent Programs")

i = i + 1
o(i).typ = 3
o(i).y = idewy + idesubwindow - 6
o(i).txt = idenewtxt("#OK" + sep + "#Cancel" + sep + "Clea#r list" + sep + "#Remove broken links")
o(i).dft = 1

'-------- end of init --------

'-------- generic init --------
FOR i = 1 TO 100: o(i).par = p: NEXT 'set parent info of objects
'-------- end of generic init --------

DO 'main loop

    '-------- generic display dialog box & objects --------
    idedrawpar p
    f = 1: cx = 0: cy = 0
    FOR i = 1 TO 100
        IF o(i).typ THEN
            'prepare object

            o(i).foc = focus - f 'focus offset
            o(i).cx = 0: o(i).cy = 0
            idedrawobj o(i), f 'display object
            IF o(i).cx THEN cx = o(i).cx: cy = o(i).cy
        END IF
    NEXT i
    lastfocus = f - 1
    '-------- end of generic display dialog box & objects --------

    '-------- custom display changes --------
    '-------- end of custom display changes --------

    'update visual page and cursor position
    PCOPY 1, 0
    IF cx THEN SCREEN , , 0, 0: LOCATE cy, cx, 1: SCREEN , , 1, 0

    '-------- read input --------
    change = 0
    DO
        GetInput
        IF mWHEEL THEN change = 1
        IF KB THEN change = 1
        IF mCLICK THEN mousedown = 1: change = 1
        IF mRELEASE THEN mouseup = 1: change = 1
        IF mB THEN change = 1
        alt = KALT: IF alt <> oldalt THEN change = 1
        oldalt = alt
        _LIMIT 100
    LOOP UNTIL change
    IF alt THEN idehl = 1 ELSE idehl = 0
    'convert "alt+letter" scancode to letter's ASCII character
    altletter$ = ""
    IF alt THEN
        IF LEN(K$) = 1 THEN
            k = ASC(UCASE$(K$))
            IF k >= 65 AND k <= 90 THEN altletter$ = CHR$(k)
        END IF
    END IF
    SCREEN , , 0, 0: LOCATE , , 0: SCREEN , , 1, 0
    '-------- end of read input --------

    '-------- generic input response --------
    info = 0
    IF K$ = "" THEN K$ = CHR$(255)
    IF KSHIFT = 0 AND K$ = CHR$(9) THEN focus = focus + 1
    IF KSHIFT AND K$ = CHR$(9) THEN focus = focus - 1
    IF focus < 1 THEN focus = lastfocus
    IF focus > lastfocus THEN focus = 1
    f = 1
    FOR i = 1 TO 100
        t = o(i).typ
        IF t THEN
            focusoffset = focus - f
            ideobjupdate o(i), focus, f, focusoffset, K$, altletter$, mB, mousedown, mouseup, mX, mY, info, mWHEEL
        END IF
    NEXT
    '-------- end of generic input response --------

    IF K$ = CHR$(27) OR (focus = 3 AND info <> 0) THEN
        iderecentbox$ = ""
        EXIT FUNCTION
    END IF

    IF (K$ = CHR$(13) AND focus = 1) OR (focus = 2 AND info <> 0) OR (info = 1 AND focus = 1) THEN
        f$ = idetxt(o(1).stx)
        iderecentbox$ = f$
        EXIT FUNCTION
    END IF

    IF (K$ = CHR$(13) AND focus = 4) OR (focus = 4 AND info <> 0) OR (info = 1 AND focus = 4) THEN
        iderecentbox$ = "<C>"
        EXIT FUNCTION
    END IF

    IF (K$ = CHR$(13) AND focus = 5) OR (focus = 5 AND info <> 0) OR (info = 1 AND focus = 5) THEN
        iderecentbox$ = "<R>"
        EXIT FUNCTION
    END IF

    'end of custom controls
    mousedown = 0
    mouseup = 0
LOOP



END FUNCTION



SUB IdeMakeFileMenu
m = 1: i = 0
menu$(m, i) = "File": i = i + 1
menu$(m, i) = "#New": i = i + 1
menu$(m, i) = "#Open...": i = i + 1
menu$(m, i) = "#Save": i = i + 1
menu$(m, i) = "Save #As...": i = i + 1
fh = FREEFILE
OPEN ".\internal\temp\recent.bin" FOR BINARY AS #fh: a$ = SPACE$(LOF(fh)): GET #fh, , a$
a$ = RIGHT$(a$, LEN(a$) - 2)
FOR r = 1 TO 5
    IF r <= 4 THEN IdeRecentLink(r, 1) = ""
    ai = INSTR(a$, CRLF)
    IF ai THEN
        IF r = 1 THEN menu$(m, i) = "-": i = i + 1
        f$ = LEFT$(a$, ai - 1): IF ai = LEN(a$) - 1 THEN a$ = "" ELSE a$ = RIGHT$(a$, LEN(a$) - ai - 3)
        IF r <= 4 THEN IdeRecentLink(r, 2) = f$
        IF r = 5 THEN f$ = "#Recent..."
        IF LEN(f$) > 25 THEN f$ = string$(3, 250) + RIGHT$(f$, 22)
        IF r <= 4 THEN IdeRecentLink(r, 1) = f$
        menu$(m, i) = f$: i = i + 1
    END IF
NEXT
CLOSE #fh
IF menu$(m, i - 1) <> "#Recent..." and menu$(m, i - 1) <> "Save #As..." THEN
    menu$(m, i) = "Clear #recent...": i = i + 1
END IF
menu$(m, i) = "-": i = i + 1
menu$(m, i) = "E#xit": i = i + 1
menusize(m) = i - 1
END SUB

SUB IdeMakeContextualMenu
    REDIM SubFuncLIST(0) AS STRING
    DIM Selection$

    m = idecontextualmenuID: i = 0
    menu$(m, i) = "Contextual": i = i + 1

    'Figure out if the user wants to search for a selected term -- copied from idefind$
    IF ideselect THEN
        IF ideselecty1 = idecy THEN 'single line selected
            a$ = idegetline(idecy)
            a2$ = ""
            sx1 = ideselectx1: sx2 = idecx
            IF sx2 < sx1 THEN SWAP sx1, sx2
            FOR x = sx1 TO sx2 - 1
                IF x <= LEN(a$) THEN a2$ = a2$ + MID$(a$, x, 1) ELSE a2$ = a2$ + " "
            NEXT
        END IF
        IF len(a2$) > 0 THEN
            sela2$ = ucase$(a2$)
            idecontextualSearch$ = a2$
            IF LEN(a2$) > 22 THEN
                a2$ = LEFT$(a2$, 19) + string$(3, 250)
            END IF
            menu$(m, i) = "Find '" + a2$ + "'": i = i + 1
            Selection$ = a2$
        END IF
    END IF
        'build SUB/FUNCTION list:
        TotalSF = 0
        FOR y = 1 TO iden
            a$ = idegetline(y)
            a$ = LTRIM$(RTRIM$(a$))
            sf = 0
            nca$ = UCASE$(a$)
            IF LEFT$(nca$, 4) = "SUB " THEN sf = 1: sf$ = "SUB  "
            IF LEFT$(nca$, 9) = "FUNCTION " THEN sf = 2: sf$ = "FUNC "
            IF sf THEN
                IF RIGHT$(nca$, 7) = " STATIC" THEN
                    a$ = RTRIM$(LEFT$(a$, LEN(a$) - 7))
                END IF

                IF sf = 1 THEN
                    a$ = RIGHT$(a$, LEN(a$) - 4)
                ELSE
                    a$ = RIGHT$(a$, LEN(a$) - 9)
                END IF

                a$ = LTRIM$(RTRIM$(a$))
                x = INSTR(a$, "(")
                IF x THEN
                    n$ = RTRIM$(LEFT$(a$, x - 1))
                ELSE
                    n$ = a$
                END IF

                'attempt to cleanse n$, just in case there are any comments or other unwanted stuff
                for CleanseN = 1 to len(n$)
                    select case mid$(n$, CleanseN, 1)
                        case " ", "'", ":"
                            n$ = left$(n$, CleanseN - 1)
                            exit for
                    end select
                next

                n2$ = n$
                if len(n2$) > 1 then
                    do until alphanumeric(asc(right$(n2$, 1)))
                        n2$ = left$(n$, len(n2$) - 1)  'removes sigil, if any
                    loop
                end if

                'Populate SubFuncLIST()
                TotalSF = TotalSF + 1
                REDIM _PRESERVE SubFuncLIST(1 to TotalSF) AS STRING
                SubFuncLIST(TotalSF) = MKL$(y) + CHR$(sf) + n2$
            END IF
        NEXT

        'identify if word or character at current cursor position is in the help system OR a sub/func
        '(copied/adapted from ide2)
        a$ = idegetline(idecy)
        a2$ = ""
        x = idecx
        IF x <= LEN(a$) THEN
            IF alphanumeric(ASC(a$, x)) THEN
                x1 = x
                DO WHILE x1 > 1
                    IF alphanumeric(ASC(a$, x1 - 1)) OR ASC(a$, x1 - 1) = 36 THEN x1 = x1 - 1 ELSE EXIT DO
                LOOP
                x2 = x
                DO WHILE x2 < LEN(a$)
                    IF alphanumeric(ASC(a$, x2 + 1)) OR ASC(a$, x2 + 1) = 36 THEN x2 = x2 + 1 ELSE EXIT DO
                LOOP
                a2$ = MID$(a$, x1, x2 - x1 + 1)
            ELSE
                a2$ = CHR$(ASC(a$, x))
            END IF
            a2$ = UCASE$(a2$)
        END IF

        'check if cursor is on sub/func/label name
        if len(Selection$) > 0 then
            do until alphanumeric(asc(right$(Selection$, 1)))
                Selection$ = left$(Selection$, len(Selection$) - 1)  'removes sigil, if any
            loop
            Selection$ = ltrim$(rtrim$(Selection$))
        end if

        if right$(a2$, 1) = "$" then a3$ = left$(a2$, len(a2$) - 1) else a3$ = a2$ 'creates a new version without $

        if len(a3$) > 0 or len(Selection$) > 0 THEN

            for CheckSF = 1 to TotalSF
                if a3$ = ucase$(mid$(SubFuncLIST(CheckSF), 6)) or ucase$(Selection$) = ucase$(mid$(SubFuncLIST(CheckSF),6)) then
                    CurrSF$ = FindCurrentSF$(idecy)
                    if len(CurrSF$) = 0 then goto SkipCheckCurrSF

                    do until alphanumeric(asc(right$(CurrSF$, 1)))
                        CurrSF$ = left$(CurrSF$, len(CurrSF$) - 1)  'removes sigil, if any
                    loop
                    CurrSF$ = ucase$(CurrSF$)

                    SkipCheckCurrSF:
                    if asc(SubFuncLIST(CheckSF), 5) = 1 THEN
                        CursorSF$ = "SUB "
                    else
                        CursorSF$ = "FUNCTION "
                    end if
                    CursorSF$ = CursorSF$ + mid$(SubFuncLIST(CheckSF),6)

                    if ucase$(CursorSF$) = CurrSF$ THEN
                        exit for
                    else
                        menu$(m, i) = "#Go to " + CursorSF$: i = i + 1
                        SubFuncLIST(1) = SubFuncLIST(CheckSF)
                        exit for
                    end if
                end if
            next CheckSF

            v = 0
            CurrSF$ = FindCurrentSF$(idecy)
            if not Error_Happened then v = HashFind(a2$, HASHFLAG_LABEL, ignore, r)
            CheckThisLabel:
            if v then
                LabelLineNumber = Labels(r).SourceLineNumber
                ThisLabelScope$ = FindCurrentSF$(LabelLineNumber)
                if ThisLabelScope$ <> CurrSF$ AND v = 2 then
                    v = HashFindCont(ignore, r)
                    goto CheckThisLabel
                end if
                if LabelLineNumber > 0 and LabelLineNumber <> idecy then
                    menu$(m, i) = "Go to #label " + rtrim$(Labels(r).cn): i = i + 1
                    REDIM _PRESERVE SubFuncLIST(1 to ubound(SubFuncLIST) + 1) AS STRING
                    SubFuncLIST(ubound(SubFuncLIST)) = MKL$(Labels(r).SourceLineNumber)
                end if
            end if
        end if

        if len(a2$) > 0 then
            'check if F1 is in help links
            fh = FREEFILE
            OPEN "internal\help\links.bin" FOR INPUT AS #fh
            lnks = 0: lnks$ = CHR$(0)
            DO UNTIL EOF(fh)
                LINE INPUT #fh, l$
                c = INSTR(l$, ","): l1$ = LEFT$(l$, c - 1): l2$ = RIGHT$(l$, LEN(l$) - c)
                IF a2$ = UCASE$(l1$) THEN
                    IF INSTR(lnks$, CHR$(0) + l2$ + CHR$(0)) = 0 THEN
                        lnks = lnks + 1
                        EXIT DO
                    END IF
                END IF
            LOOP
            CLOSE #fh

            IF lnks THEN
                IF LEN(l2$) > 15 THEN
                    l2$ = LEFT$(l2$, 12) + string$(3, 250)
                END IF
                if instr(l2$, "Parenthesis") = 0 then
                    menu$(m, i) = "#Help on '" + l2$ + "'": i = i + 1
                end if
            END IF
        end if

    IF i > 1 THEN
        menu$(m, i) = "-": i = i + 1
    END IF

    if ideselect then menu$(m, i) = "Cu#t  Shift+Del or Ctrl+X": i = i + 1
    if ideselect then menu$(m, i) = "#Copy  Ctrl+Ins or Ctrl+C": i = i + 1

    clip$ = _CLIPBOARD$ 'read clipboard
    IF LEN(clip$) THEN menu$(m, i) = "#Paste  Shift+Ins or Ctrl+V": i = i + 1

    if ideselect then menu$(m, i) = "Cl#ear  Del": i = i + 1
    menu$(m, i) = "Select #All  Ctrl+A": i = i + 1
    menu$(m, i) = "-": i = i + 1
    menu$(m, i) = "#Undo  Ctrl+Z": i = i + 1
    menu$(m, i) = "#Redo  Ctrl+Y": i = i + 1
    menu$(m, i) = "-": i = i + 1
    menu$(m, i) = "Comment (add ')": i = i + 1
    menu$(m, i) = "Uncomment (remove ')": i = i + 1
    IF ideselect AND ideautoindent = 0 THEN
        y1 = idecy
        y2 = ideselecty1
        IF y1 = y2 THEN 'single line selected
            a$ = idegetline(idecy)
            a2$ = ""
            sx1 = ideselectx1: sx2 = idecx
            IF sx2 < sx1 THEN SWAP sx1, sx2
            FOR x = sx1 TO sx2 - 1
                IF x <= LEN(a$) THEN a2$ = a2$ + MID$(a$, x, 1) ELSE a2$ = a2$ + " "
            NEXT
            IF a2$ <> "" THEN
                menu$(m, i) = "Increase indent  TAB": i = i + 1
                menu$(m, i) = "Decrease indent"
                IF INSTR(_OS$, "WIN") OR INSTR(_OS$, "MAC") THEN menu$(m, i) = menu$(m, i) + "  Shift+TAB"
                i = i + 1
                menu$(m, i) = "-": i = i + 1
            END IF
        ELSE
            menu$(m, i) = "Increase indent  TAB": i = i + 1
            menu$(m, i) = "Decrease indent"
            IF INSTR(_OS$, "WIN") OR INSTR(_OS$, "MAC") THEN menu$(m, i) = menu$(m, i) + "  Shift+TAB"
            i = i + 1
            menu$(m, i) = "-": i = i + 1
        END IF
    else
        menu$(m, i) = "-": i = i + 1
    end if
    menu$(m, i) = "New #SUB...": i = i + 1
    menu$(m, i) = "New #FUNCTION...": i = i + 1
    menusize(m) = i - 1
END SUB

SUB IdeMakeEditMenu
    m = ideeditmenuID: i = 0
    menu$(m, i) = "Edit": i = i + 1

    if ideselect then
        menu$(m, i) = "Cu#t  Shift+Del or Ctrl+X": i = i + 1
        menu$(m, i) = "#Copy  Ctrl+Ins or Ctrl+C": i = i + 1
    else
        menu$(m, i) = "~Cu#t  Shift+Del or Ctrl+X": i = i + 1
        menu$(m, i) = "~#Copy  Ctrl+Ins or Ctrl+C": i = i + 1
    end if

    clip$ = _CLIPBOARD$ 'read clipboard
    IF LEN(clip$) THEN
        menu$(m, i) = "#Paste  Shift+Ins or Ctrl+V": i = i + 1
    else
        menu$(m, i) = "~#Paste  Shift+Ins or Ctrl+V": i = i + 1
    end if

    if ideselect then
        menu$(m, i) = "Cl#ear  Del": i = i + 1
    else
        menu$(m, i) = "~Cl#ear  Del": i = i + 1
    end if

    menu$(m, i) = "Select #All  Ctrl+A": i = i + 1
    menu$(m, i) = "-": i = i + 1
    menu$(m, i) = "#Undo  Ctrl+Z": i = i + 1
    menu$(m, i) = "#Redo  Ctrl+Y": i = i + 1
    menu$(m, i) = "-": i = i + 1
    menu$(m, i) = "Comment (add ')": i = i + 1
    menu$(m, i) = "Uncomment (remove ')": i = i + 1
    IF ideselect AND ideautoindent = 0 THEN
        y1 = idecy
        y2 = ideselecty1
        IF y1 = y2 THEN 'single line selected
            a$ = idegetline(idecy)
            a2$ = ""
            sx1 = ideselectx1: sx2 = idecx
            IF sx2 < sx1 THEN SWAP sx1, sx2
            FOR x = sx1 TO sx2 - 1
                IF x <= LEN(a$) THEN a2$ = a2$ + MID$(a$, x, 1) ELSE a2$ = a2$ + " "
            NEXT
            IF a2$ = "" THEN
                menu$(m, i) = "~Increase indent  TAB": i = i + 1
                menu$(m, i) = "~Decrease indent"
                IF INSTR(_OS$, "WIN") OR INSTR(_OS$, "MAC") THEN menu$(m, i) = menu$(m, i) + "  Shift+TAB"
                i = i + 1
            ELSE
                menu$(m, i) = "Increase indent  TAB": i = i + 1
                menu$(m, i) = "Decrease indent"
                IF INSTR(_OS$, "WIN") OR INSTR(_OS$, "MAC") THEN menu$(m, i) = menu$(m, i) + "  Shift+TAB"
                i = i + 1
            END IF
        ELSE
            menu$(m, i) = "Increase indent  TAB": i = i + 1
            menu$(m, i) = "Decrease indent"
            IF INSTR(_OS$, "WIN") OR INSTR(_OS$, "MAC") THEN menu$(m, i) = menu$(m, i) + "  Shift+TAB"
            i = i + 1
        END IF
    else
        menu$(m, i) = "~Increase indent  TAB": i = i + 1
        menu$(m, i) = "~Decrease indent"
        IF INSTR(_OS$, "WIN") OR INSTR(_OS$, "MAC") THEN menu$(m, i) = menu$(m, i) + "  Shift+TAB"
        i = i + 1
    end if
    menu$(m, i) = "-": i = i + 1
    menu$(m, i) = "New #SUB...": i = i + 1
    menu$(m, i) = "New #FUNCTION...": i = i + 1
    menusize(m) = i - 1
END SUB

SUB IdeAddRecent (f2$)
f$ = CRLF + f2$ + CRLF
fh = FREEFILE
OPEN ".\internal\temp\recent.bin" FOR BINARY AS #fh: a$ = SPACE$(LOF(fh)): GET #fh, , a$
x = INSTR(UCASE$(a$), UCASE$(f$))
IF x THEN
    a$ = f$ + LEFT$(a$, x - 1) + RIGHT$(a$, LEN(a$) - (x + LEN(f$) - 1))
ELSE
    a$ = f$ + a$
END IF
PUT #fh, 1, a$
CLOSE #fh
IdeMakeFileMenu
END SUB

SUB IdeAddSearched (s2$)
s$ = CRLF + s2$ + CRLF
fh = FREEFILE
OPEN ".\internal\temp\searched.bin" FOR BINARY AS #fh: a$ = SPACE$(LOF(fh)): GET #fh, , a$
x = INSTR(UCASE$(a$), UCASE$(s$))
IF x THEN
    a$ = s$ + LEFT$(a$, x - 1) + RIGHT$(a$, LEN(a$) - (x + LEN(s$) - 1))
ELSE
    a$ = s$ + a$
END IF
PUT #fh, 1, a$
CLOSE #fh
END SUB

SUB ideASCIIbox
'IF INSTR(_OS$, "WIN") THEN ret% = SHELL("internal\ASCII-Picker.exe") ELSE ret% = SHELL("internal/ASCII-Picker")
'(code to fix font and arrow keys also written by Steve)
w = _WIDTH: h = _HEIGHT
font = _FONT
temp = _NEWIMAGE(640, 480, 32)
temp1 = _NEWIMAGE(640, 480, 32)
ws = _NEWIMAGE(640, 480, 32)
SCREEN temp
DIM CurrentASC(1 TO 16, 1 TO 16)
DIM CurrentOne AS INTEGER
CLS , _RGB(0, 0, 170)
COLOR , _RGB(0, 0, 170)
FOR y = 1 TO 16
    FOR x = 1 TO 16
        LINE (x * 40, 0)-(x * 40, 480), _RGB32(255, 255, 0)
        LINE (0, y * 30)-(640, y * 30), _RGB32(255, 255, 0)
        IF counter THEN _PRINTSTRING (x * 40 - 28, y * 30 - 23), CHR$(counter)
        counter = counter + 1
    NEXT
NEXT

_DEST temp1
CLS , _RGB(0, 0, 170)
COLOR , _RGB(0, 0, 170)
counter = 0
FOR y = 1 TO 16
    FOR x = 1 TO 16
        LINE (x * 40, 0)-(x * 40, 480), _RGB32(255, 255, 0)
        LINE (0, y * 30)-(640, y * 30), _RGB32(255, 255, 0)
        text$ = LTRIM$(STR$(counter))
        IF counter THEN _PRINTSTRING (x * 40 - 24 - (LEN(text$)) * 4, y * 30 - 23), text$
        counter = counter + 1
    NEXT
NEXT
_DEST temp

x = 1: y = 1
_PUTIMAGE , temp, ws
DO: LOOP WHILE _MOUSEINPUT 'clear the mouse input buffer
oldmousex = _MOUSEX: oldmousey = _MOUSEY

DO
    _LIMIT 60
    DO: LOOP WHILE _MOUSEINPUT
    if oldx <> _mousex and oldy <> _mousey then
        x = _MOUSEX \ 40 + 1 'If mouse moved, where are we now?
        y = _MOUSEY \ 30 + 1
    end if
    oldx = _mousex: oldy = _mousey

    num = (y - 1) * 16 + x - 1
    IF num = 0 THEN
        text$ = ""
    ELSE
        flashcounter = flashcounter + 1
        IF flashcounter > 30 THEN
            COLOR _RGB32(255, 255, 255), _RGB(0, 0, 170)
            text$ = CHR$(num)
            IF LEN(text$) = 1 THEN text$ = " " + text$ + " "
        ELSE
            COLOR _RGB32(255, 255, 255), _RGB(0, 0, 170)
            text$ = RTRIM$(LTRIM$(STR$(num)))
        END IF
    END IF
    IF flashcounter = 60 THEN flashcounter = 1
    CLS
    IF toggle THEN _PUTIMAGE , temp1, temp ELSE _PUTIMAGE , ws, temp
    _PRINTSTRING (x * 40 - 24 - (LEN(text$)) * 4, y * 30 - 23), text$
    LINE (x * 40 - 40, y * 30 - 30)-(x * 40, y * 30), _RGBA32(255, 255, 255, 150), BF

    k1 = _KEYHIT
    MouseClick = 0: MouseExit = 0
    if MouseButtonSwapped then
        mouseclick = _mousebutton(2): mouseexit = _mousebutton(1)
    else
        mouseclick = _mousebutton(1): mouseexit = _mousebutton(2)
    end if
    SELECT CASE k1
        CASE 13: EXIT DO
        CASE 27
            _AUTODISPLAY
            SCREEN 0: WIDTH w, h: _FONT font: _DEST 0: _DELAY .2
            IF _RESIZE THEN donothing = atall
            EXIT SUB
        CASE 32: toggle = NOT toggle
        CASE 18432: y = y - 1
        CASE 19200: x = x - 1
        CASE 20480: y = y + 1
        CASE 19712: x = x + 1
    END SELECT

    IF x < 1 THEN x = 1
    IF x > 16 THEN x = 16
    IF y < 1 THEN y = 1
    IF y > 16 THEN y = 16
    _DISPLAY
    Ex = _EXIT
    IF Ex THEN
        _AUTODISPLAY
        SCREEN 0: WIDTH w, h: _FONT font: _DEST 0: _DELAY .2
        IF _RESIZE THEN donothing = atall
        EXIT FUNCTION
    END IF
    IF MouseExit THEN
        _AUTODISPLAY
        SCREEN 0: WIDTH w, h: _FONT font: _DEST 0: _DELAY .2
        IF _RESIZE THEN donothing = atall
        EXIT FUNCTION
    END IF

LOOP UNTIL mouseclick

ret% = (y - 1) * 16 + x - 1
IF ret% > 0 AND ret% < 255 THEN
    l = idecy
    a$ = idegetline(l)
    l$ = LEFT$(a$, idecx - 1): r$ = RIGHT$(a$, LEN(a$) - idecx + 1)
    text$ = l$ + CHR$(ret%) + r$
    textlen = LEN(text$)
    l$ = LEFT$(idet$, ideli - 1)
    m$ = MKL$(textlen) + text$ + MKL$(textlen)
    r$ = RIGHT$(idet$, LEN(idet$) - ideli - LEN(a$) - 7)
    idet$ = l$ + m$ + r$
    idecx = idecx + 1
END IF

_AUTODISPLAY

SCREEN 0: WIDTH w, h
_FONT font
_DEST 0: _DELAY .2
IF _RESIZE THEN donothing = atall

END FUNCTION


FUNCTION idef1box$ (lnks$, lnks)

'-------- generic dialog box header --------
PCOPY 0, 2
PCOPY 0, 1
SCREEN , , 1, 0
focus = 1
DIM p AS idedbptype
DIM o(1 TO 100) AS idedbotype
DIM oo AS idedbotype
DIM sep AS STRING * 1
sep = CHR$(0)
'-------- end of generic dialog box header --------

'-------- init --------


'72,19
i = 0
idepar p, 40, lnks + 3, "F1"

i = i + 1
o(i).typ = 2
o(i).y = 1
'68
o(i).w = 36: o(i).h = lnks
o(i).txt = idenewtxt(lnks$)
o(i).sel = 1
o(i).nam = idenewtxt("Which?")

i = i + 1
o(i).typ = 3
o(i).y = lnks + 3
o(i).txt = idenewtxt("#OK")
o(i).dft = 1

'-------- end of init --------

'-------- generic init --------
FOR i = 1 TO 100: o(i).par = p: NEXT 'set parent info of objects
'-------- end of generic init --------

DO 'main loop

    '-------- generic display dialog box & objects --------
    idedrawpar p
    f = 1: cx = 0: cy = 0
    FOR i = 1 TO 100
        IF o(i).typ THEN
            'prepare object

            o(i).foc = focus - f 'focus offset
            o(i).cx = 0: o(i).cy = 0
            idedrawobj o(i), f 'display object
            IF o(i).cx THEN cx = o(i).cx: cy = o(i).cy
        END IF
    NEXT i
    lastfocus = f - 1
    '-------- end of generic display dialog box & objects --------

    '-------- custom display changes --------
    '-------- end of custom display changes --------

    'update visual page and cursor position
    PCOPY 1, 0
    IF cx THEN SCREEN , , 0, 0: LOCATE cy, cx, 1: SCREEN , , 1, 0

    '-------- read input --------
    change = 0
    DO
        GetInput
        IF mWHEEL THEN change = 1
        IF KB THEN change = 1
        IF mCLICK THEN mousedown = 1: change = 1
        IF mRELEASE THEN mouseup = 1: change = 1
        IF mB THEN change = 1
        alt = KALT: IF alt <> oldalt THEN change = 1
        oldalt = alt
        _LIMIT 100
    LOOP UNTIL change
    IF alt THEN idehl = 1 ELSE idehl = 0
    'convert "alt+letter" scancode to letter's ASCII character
    altletter$ = ""
    IF alt THEN
        IF LEN(K$) = 1 THEN
            k = ASC(UCASE$(K$))
            IF k >= 65 AND k <= 90 THEN altletter$ = CHR$(k)
        END IF
    END IF
    SCREEN , , 0, 0: LOCATE , , 0: SCREEN , , 1, 0
    '-------- end of read input --------

    '-------- generic input response --------
    info = 0
    IF K$ = "" THEN K$ = CHR$(255)
    IF KSHIFT = 0 AND K$ = CHR$(9) THEN focus = focus + 1
    IF KSHIFT AND K$ = CHR$(9) THEN focus = focus - 1
    IF focus < 1 THEN focus = lastfocus
    IF focus > lastfocus THEN focus = 1
    f = 1
    FOR i = 1 TO 100
        t = o(i).typ
        IF t THEN
            focusoffset = focus - f
            ideobjupdate o(i), focus, f, focusoffset, K$, altletter$, mB, mousedown, mouseup, mX, mY, info, mWHEEL
        END IF
    NEXT
    '-------- end of generic input response --------

    IF K$ = CHR$(13) OR (focus = 2 AND info <> 0) OR (info = 1 AND focus = 1) THEN
        f$ = idetxt(o(1).stx)
        idef1box$ = f$
        EXIT FUNCTION
    ELSEIF K$ = CHR$(27) THEN
        idef1box$ = "C"
        EXIT FUNCTION
    END IF

    'end of custom controls
    mousedown = 0
    mouseup = 0
LOOP



END FUNCTION

SUB Mathbox
'Draw a box

'-------- generic dialog box header --------
PCOPY 0, 2
PCOPY 0, 1
SCREEN , , 1, 0
focus = 1
DIM p AS idedbptype
DIM o(1 TO 100) AS idedbotype
DIM oo AS idedbotype
DIM sep AS STRING * 1
sep = CHR$(0)
'-------- end of generic dialog box header --------

DoAnother:
titlestr$ = "          Give me a Math Equation          "
messagestr$ = ""

'-------- init --------
i = 0
w = LEN(messagestr$) + 2
w2 = LEN(titlestr$) + 4
IF w < w2 THEN w = w2
idepar p, w, 4, titlestr$

i = i + 1
o(i).typ = 3
o(i).y = 4
o(i).txt = idenewtxt("OK")
o(i).dft = 1
'-------- end of init --------

'-------- generic init --------
FOR i = 1 TO 100: o(i).par = p: NEXT 'set parent info of objects
'-------- end of generic init --------

DO 'main loop


    '-------- generic display dialog box & objects --------
    idedrawpar p
    f = 1: cx = 0: cy = 0
    FOR i = 1 TO 100
        IF o(i).typ THEN

            'prepare object
            o(i).foc = focus - f 'focus offset
            o(i).cx = 0: o(i).cy = 0
            idedrawobj o(i), f 'display object
            IF o(i).cx THEN cx = o(i).cx: cy = o(i).cy
        END IF
    NEXT i
    lastfocus = f - 1
    '-------- end of generic display dialog box & objects --------

    '-------- custom display changes --------
    COLOR 0, 7: LOCATE p.y + 2, p.x + 2: PRINT messagestr$;
    '-------- end of custom display changes --------

    'update visual page and cursor position
    PCOPY 1, 0
    IF cx THEN SCREEN , , 0, 0: LOCATE cy, cx, 1: SCREEN , , 1, 0

    '-------- read input --------
    change = 0
    DO
        GetInput
        IF mWHEEL THEN change = 1
        IF KB THEN change = 1
        IF mCLICK THEN mousedown = 1: change = 1
        IF mRELEASE THEN mouseup = 1: change = 1
        IF mB THEN change = 1
        alt = KALT: IF alt <> oldalt THEN change = 1
        oldalt = alt
        _LIMIT 100
    LOOP UNTIL change
    IF alt THEN idehl = 1 ELSE idehl = 0
    'convert "alt+letter" scancode to letter's ASCII character
    altletter$ = ""
    IF alt THEN
        IF LEN(K$) = 1 THEN
            k = ASC(UCASE$(K$))
            IF k >= 65 AND k <= 90 THEN altletter$ = CHR$(k)
            IF K$ = CHR$(27) THEN EXIT SUB
        END IF
    END IF
    SCREEN , , 0, 0: LOCATE , , 0: SCREEN , , 1, 0
    '-------- end of read input --------

    '-------- generic input response --------
    info = 0
    IF K$ = "" THEN K$ = CHR$(255)
    IF KSHIFT = 0 AND K$ = CHR$(9) THEN focus = focus + 1
    IF KSHIFT AND K$ = CHR$(9) THEN focus = focus - 1
    IF focus < 1 THEN focus = lastfocus
    IF focus > lastfocus THEN focus = 1
    IF K$ > CHR$(31) AND K$ < CHR$(123) THEN messagestr$ = messagestr$ + K$
    IF K$ = CHR$(8) THEN messagestr$ = LEFT$(messagestr$, LEN(messagestr$) - 1)
    f = 1
    FOR i = 1 TO 100
        t = o(i).typ
        IF t THEN
            focusoffset = focus - f
            ideobjupdate o(i), focus, f, focusoffset, K$, altletter$, mB, mousedown, mouseup, mX, mY, info, mWHEEL
        END IF
    NEXT
    '-------- end of generic input response --------

    'specific post controls
    IF K$ = CHR$(27) OR K$ = CHR$(13) OR (focus = 1 AND info <> 0) THEN EXIT DO
    'end of custom controls

    mousedown = 0
    mouseup = 0
LOOP


temp$ = messagestr$ 'Make a back up of our user return
titlestr$ = "(H)ex/(D)ec  (U)n(C)omment  (ESC)ape/(R)edo"
ev$ = Evaluate_Expression$(messagestr$)
messagestr$ = ev$

'-------- init --------
i = 0
w = LEN(messagestr$) + 2
w2 = LEN(titlestr$) + 4
IF w < w2 THEN w = w2
idepar p, w, 4, titlestr$

i = i + 1
o(i).typ = 3
o(i).y = 4
o(i).txt = idenewtxt("OK")
o(i).dft = 1
'-------- end of init --------

'-------- generic init --------
FOR i = 1 TO 100: o(i).par = p: NEXT 'set parent info of objects
'-------- end of generic init --------




DO 'main loop


    '-------- generic display dialog box & objects --------
    idedrawpar p
    f = 1: cx = 0: cy = 0
    FOR i = 1 TO 100
        IF o(i).typ THEN

            'prepare object
            o(i).foc = focus - f 'focus offset
            o(i).cx = 0: o(i).cy = 0
            idedrawobj o(i), f 'display object
            IF o(i).cx THEN cx = o(i).cx: cy = o(i).cy
        END IF
    NEXT i
    lastfocus = f - 1
    '-------- end of generic display dialog box & objects --------

    '-------- custom display changes --------
    COLOR 0, 7: LOCATE p.y + 2, p.x + 2: PRINT messagestr$;
    '-------- end of custom display changes --------

    'update visual page and cursor position
    PCOPY 1, 0
    IF cx THEN SCREEN , , 0, 0: LOCATE cy, cx, 1: SCREEN , , 1, 0

    '-------- read input --------
    change = 0
    DO
        GetInput
        IF mWHEEL THEN change = 1
        IF KB THEN change = 1
        IF mCLICK THEN mousedown = 1: change = 1
        IF mRELEASE THEN mouseup = 1: change = 1
        IF mB THEN change = 1
        alt = KALT: IF alt <> oldalt THEN change = 1
        oldalt = alt
        _LIMIT 100
    LOOP UNTIL change
    IF alt THEN idehl = 1 ELSE idehl = 0
    'convert "alt+letter" scancode to letter's ASCII character
    altletter$ = ""
    IF alt THEN
        IF LEN(K$) = 1 THEN
            k = ASC(UCASE$(K$))
            IF k >= 65 AND k <= 90 THEN altletter$ = CHR$(k)
        END IF
    END IF
    SCREEN , , 0, 0: LOCATE , , 0: SCREEN , , 1, 0
    '-------- end of read input --------

    '-------- generic input response --------
    info = 0
    IF K$ = "" THEN K$ = CHR$(255)
    IF KSHIFT = 0 AND K$ = CHR$(9) THEN focus = focus + 1
    IF KSHIFT AND K$ = CHR$(9) THEN focus = focus - 1
    IF focus < 1 THEN focus = lastfocus
    IF focus > lastfocus THEN focus = 1
    IF K$ = "H" OR K$ = "h" THEN ev$ = "&H" + HEX$(VAL(ev$))
    IF K$ = "D" OR K$ = "d" THEN ev$ = STR$(VAL(ev$))
    IF K$ = "U" OR K$ = "u" THEN comment = 0
    IF K$ = "C" OR K$ = "c" THEN comment = -1
    IF K$ = "R" OR K$ = "r" THEN GOTO DoAnother
    IF K$ = CHR$(27) THEN EXIT SUB
    IF comment THEN messagestr$ = ev$ + " ' " + temp$ ELSE messagestr$ = ev$

    f = 1
    FOR i = 1 TO 100
        t = o(i).typ
        IF t THEN
            focusoffset = focus - f
            ideobjupdate o(i), focus, f, focusoffset, K$, altletter$, mB, mousedown, mouseup, mX, mY, info, mWHEEL
        END IF
    NEXT
    '-------- end of generic input response --------

    'specific post controls
    IF K$ = CHR$(27) OR K$ = CHR$(13) OR (focus = 1 AND info <> 0) THEN EXIT DO
    'end of custom controls

    mousedown = 0
    mouseup = 0
LOOP

IF INSTR(messagestr$, " LINES INSERTED") THEN EXIT SUB

l = idecy
a$ = idegetline(l)
l$ = LEFT$(a$, idecx - 1): r$ = RIGHT$(a$, LEN(a$) - idecx + 1)
text$ = l$ + messagestr$ + r$
textlen = LEN(text$)
l$ = LEFT$(idet$, ideli - 1)
m$ = MKL$(textlen) + text$ + MKL$(textlen)
r$ = RIGHT$(idet$, LEN(idet$) - ideli - LEN(a$) - 7)
idet$ = l$ + m$ + r$
idecx = idecx + LEN(messagestr$)
END SUB

SUB Sort (m AS _MEM) 'Provided by Steve McNeill
DIM t AS LONG: t = m.TYPE
DIM i AS _UNSIGNED LONG
DIM ES AS LONG, EC AS LONG

IF NOT t AND 65536 THEN EXIT SUB 'We won't work without an array
IF t AND 1024 THEN DataType = 10
IF t AND 1 THEN DataType = DataType + 1
IF t AND 2 THEN DataType = DataType + 2
IF t AND 4 THEN IF t AND 128 THEN DataType = DataType + 4 ELSE DataType = 3
IF t AND 8 THEN IF t AND 128 THEN DataType = DataType + 8 ELSE DataType = 5
IF t AND 32 THEN DataType = 6
IF t AND 512 THEN DataType = 7

'Convert our offset data over to something we can work with
DIM m1 AS _MEM: m1 = _MEMNEW(8)
_MEMPUT m1, m1.OFFSET, m.ELEMENTSIZE: _MEMGET m1, m1.OFFSET, ES 'Element Size
_MEMPUT m1, m1.OFFSET, m.SIZE: _MEMGET m1, m1.OFFSET, EC 'Element Count will temporily hold the WHOLE array size
_MEMFREE m1
EC = EC / ES - 1 'Now we take the whole element size / the size of the elements and get our actual element count.  We subtract 1 so our arrays start at 0 and not 1.
'And work with it!
DIM o AS _OFFSET, o1 AS _OFFSET, counter AS _UNSIGNED LONG

SELECT CASE DataType
    CASE 1 'BYTE
        DIM temp1(-128 TO 127) AS _UNSIGNED LONG
        DIM t1 AS _BYTE
        i = 0
        DO
            _MEMGET m, m.OFFSET + i, t1
            temp1(t1) = temp1(t1) + 1
            i = i + 1
        LOOP UNTIL i > EC
        i1 = -128
        DO
            DO UNTIL temp1(i1) = 0
                _MEMPUT m, m.OFFSET + counter, i1 AS _BYTE
                counter = counter + 1
                temp1(i1) = temp1(i1) - 1
                IF counter > EC THEN EXIT SUB
            LOOP
            i1 = i1 + 1
        LOOP UNTIL i1 > 127
    CASE 2: 'INTEGER
        DIM temp2(-32768 TO 32767) AS _UNSIGNED LONG
        DIM t2 AS INTEGER
        i = 0
        DO
            _MEMGET m, m.OFFSET + i * 2, t2
            temp2(t2) = temp2(t2) + 1
            i = i + 1
        LOOP UNTIL i > EC
        i1 = -32768
        DO
            DO UNTIL temp2(i1) = 0
                _MEMPUT m, m.OFFSET + counter * 2, i1 AS INTEGER
                counter = counter + 1
                temp2(i1) = temp2(i1) - 1
                IF counter > EC THEN EXIT SUB
            LOOP
            i1 = i1 + 1
        LOOP UNTIL i1 > 32767
    CASE 3 'SINGLE
        DIM T3a AS SINGLE, T3b AS SINGLE
        gap = EC
        DO
            gap = 10 * gap \ 13
            IF gap < 1 THEN gap = 1
            i = 0
            swapped = 0
            DO
                o = m.OFFSET + i * 4
                o1 = m.OFFSET + (i + gap) * 4
                IF _MEMGET(m, o, SINGLE) > _MEMGET(m, o1, SINGLE) THEN
                    _MEMGET m, o1, T3a
                    _MEMGET m, o, T3b
                    _MEMPUT m, o1, T3b
                    _MEMPUT m, o, T3a
                    swapped = -1
                END IF
                i = i + 1
            LOOP UNTIL i + gap > EC
        LOOP UNTIL gap = 1 AND swapped = 0
    CASE 4 'LONG
        DIM T4a AS LONG, T4b AS LONG
        gap = EC
        DO
            gap = 10 * gap \ 13
            IF gap < 1 THEN gap = 1
            i = 0
            swapped = 0
            DO
                o = m.OFFSET + i * 4
                o1 = m.OFFSET + (i + gap) * 4
                IF _MEMGET(m, o, LONG) > _MEMGET(m, o1, LONG) THEN
                    _MEMGET m, o1, T4a
                    _MEMGET m, o, T4b
                    _MEMPUT m, o1, T4b
                    _MEMPUT m, o, T4a
                    swapped = -1
                END IF
                i = i + 1
            LOOP UNTIL i + gap > EC
        LOOP UNTIL gap = 1 AND swapped = 0
    CASE 5 'DOUBLE
        DIM T5a AS DOUBLE, T5b AS DOUBLE
        gap = EC
        DO
            gap = 10 * gap \ 13
            IF gap < 1 THEN gap = 1
            i = 0
            swapped = 0
            DO
                o = m.OFFSET + i * 8
                o1 = m.OFFSET + (i + gap) * 8
                IF _MEMGET(m, o, DOUBLE) > _MEMGET(m, o1, DOUBLE) THEN
                    _MEMGET m, o1, T5a
                    _MEMGET m, o, T5b
                    _MEMPUT m, o1, T5b
                    _MEMPUT m, o, T5a
                    swapped = -1
                END IF
                i = i + 1
            LOOP UNTIL i + gap > EC
        LOOP UNTIL gap = 1 AND swapped = 0
    CASE 6 ' _FLOAT
        DIM T6a AS _FLOAT, T6b AS _FLOAT
        gap = EC
        DO
            gap = 10 * gap \ 13
            IF gap < 1 THEN gap = 1
            i = 0
            swapped = 0
            DO
                o = m.OFFSET + i * 32
                o1 = m.OFFSET + (i + gap) * 32
                IF _MEMGET(m, o, _FLOAT) > _MEMGET(m, o1, _FLOAT) THEN
                    _MEMGET m, o1, T6a
                    _MEMGET m, o, T6b
                    _MEMPUT m, o1, T6b
                    _MEMPUT m, o, T6a
                    swapped = -1
                END IF
                i = i + 1
            LOOP UNTIL i + gap > EC
        LOOP UNTIL gap = 1 AND swapped = 0
    CASE 7 'String
        DIM T7a AS STRING, T7b AS STRING, T7c AS STRING
        T7a = SPACE$(ES): T7b = SPACE$(ES): T7c = SPACE$(ES)
        gap = EC
        DO
            gap = INT(gap / 1.247330950103979)
            IF gap < 1 THEN gap = 1
            i = 0
            swapped = 0
            DO
                o = m.OFFSET + i * ES
                o1 = m.OFFSET + (i + gap) * ES
                _MEMGET m, o, T7a
                _MEMGET m, o1, T7b
                IF T7a > T7b THEN
                    T7c = T7b
                    _MEMPUT m, o1, T7a
                    _MEMPUT m, o, T7c
                    swapped = -1
                END IF
                i = i + 1
            LOOP UNTIL i + gap > EC
        LOOP UNTIL gap = 1 AND swapped = false
    CASE 8 '_INTEGER64
        DIM T8a AS _INTEGER64, T8b AS _INTEGER64
        gap = EC
        DO
            gap = 10 * gap \ 13
            IF gap < 1 THEN gap = 1
            i = 0
            swapped = 0
            DO
                o = m.OFFSET + i * 8
                o1 = m.OFFSET + (i + gap) * 8
                IF _MEMGET(m, o, _INTEGER64) > _MEMGET(m, o1, _INTEGER64) THEN
                    _MEMGET m, o1, T8a
                    _MEMGET m, o, T8b
                    _MEMPUT m, o1, T8b
                    _MEMPUT m, o, T8a
                    swapped = -1
                END IF
                i = i + 1
            LOOP UNTIL i + gap > EC
        LOOP UNTIL gap = 1 AND swapped = 0
    CASE 11: '_UNSIGNED _BYTE
        DIM temp11(0 TO 255) AS _UNSIGNED LONG
        DIM t11 AS _UNSIGNED _BYTE
        i = 0
        DO
            _MEMGET m, m.OFFSET + i, t11
            temp11(t11) = temp11(t11) + 1
            i = i + 1
        LOOP UNTIL i > EC
        i1 = 0
        DO
            DO UNTIL temp11(i1) = 0
                _MEMPUT m, m.OFFSET + counter, i1 AS _UNSIGNED _BYTE
                counter = counter + 1
                temp11(i1) = temp11(i1) - 1
                IF counter > EC THEN EXIT SUB
            LOOP
            i1 = i1 + 1
        LOOP UNTIL i1 > 255
    CASE 12 '_UNSIGNED INTEGER
        DIM temp12(0 TO 65535) AS _UNSIGNED LONG
        DIM t12 AS _UNSIGNED INTEGER
        i = 0
        DO
            _MEMGET m, m.OFFSET + i * 2, t12
            temp12(t12) = temp12(t12) + 1
            i = i + 1
        LOOP UNTIL i > EC
        i1 = 0
        DO
            DO UNTIL temp12(i1) = 0
                _MEMPUT m, m.OFFSET + counter * 2, i1 AS _UNSIGNED INTEGER
                counter = counter + 1
                temp12(i1) = temp12(i1) - 1
                IF counter > EC THEN EXIT SUB
            LOOP
            i1 = i1 + 1
        LOOP UNTIL i1 > 65535
    CASE 14 '_UNSIGNED LONG
        DIM T14a AS _UNSIGNED LONG, T14b AS _UNSIGNED LONG
        gap = EC
        DO
            gap = 10 * gap \ 13
            IF gap < 1 THEN gap = 1
            i = 0
            swapped = 0
            DO
                o = m.OFFSET + i * 4
                o1 = m.OFFSET + (i + gap) * 4
                IF _MEMGET(m, o, _UNSIGNED LONG) > _MEMGET(m, o1, _UNSIGNED LONG) THEN
                    _MEMGET m, o1, T14a
                    _MEMGET m, o, T14b
                    _MEMPUT m, o1, T14b
                    _MEMPUT m, o, T14a
                    swapped = -1
                END IF
                i = i + 1
            LOOP UNTIL i + gap > EC
        LOOP UNTIL gap = 1 AND swapped = 0
    CASE 18: '_UNSIGNED _INTEGER64
        DIM T18a AS _UNSIGNED _INTEGER64, T18b AS _UNSIGNED _INTEGER64
        gap = EC
        DO
            gap = 10 * gap \ 13
            IF gap < 1 THEN gap = 1
            i = 0
            swapped = 0
            DO
                o = m.OFFSET + i * 8
                o1 = m.OFFSET + (i + gap) * 8
                IF _MEMGET(m, o, _UNSIGNED _INTEGER64) > _MEMGET(m, o1, _UNSIGNED _INTEGER64) THEN
                    _MEMGET m, o1, T18a
                    _MEMGET m, o, T18b
                    _MEMPUT m, o1, T18b
                    _MEMPUT m, o, T18a
                    swapped = -1
                END IF
                i = i + 1
            LOOP UNTIL i + gap > EC
        LOOP UNTIL gap = 1 AND swapped = 0
END SELECT
END SUB

FUNCTION FindProposedTitle$
    'Finds the first occurence of _TITLE to suggest a file name
    'when saving for the first time or saving as.

    FOR find_TITLE = 1 TO iden
        thisline$ = idegetline(find_TITLE)
        thisline$ = LTRIM$(RTRIM$(thisline$))
        found_TITLE = INSTR(UCASE$(thisline$), "_TITLE " + CHR$(34))
        IF found_TITLE > 0 THEN
            InQuote%% = 0
            FOR check_quotes = 1 to found_TITLE
                IF MID$(thisline$, check_quotes, 1) = CHR$(34) THEN InQuote%% = NOT InQuote%%
            NEXT check_quotes
            IF NOT InQuote%% THEN
                Find_ClosingQuote = INSTR(found_TITLE + 8, thisline$, CHR$(34))
                IF Find_ClosingQuote > 0 THEN
                    TempFound_TITLE$ = MID$(thisline$, found_TITLE + 8, (Find_ClosingQuote - found_TITLE) - 8)
                END IF
                EXIT FOR
            END IF
        END IF
    NEXT

    InvalidChars$ = ":/\?*><|" + CHR$(34)
    FOR wipe_INVALID = 1 to LEN(TempFound_TITLE$)
        ThisChar$ = MID$(TempFound_TITLE$, wipe_INVALID, 1)
        IF INSTR(InvalidChars$, ThisChar$) = 0 THEN
            Found_TITLE$ = Found_TITLE$ + ThisChar$
        END IF
    NEXT wipe_INVALID

    FindProposedTitle$ = LTRIM$(RTRIM$(Found_TITLE$))
END FUNCTION

FUNCTION FindCurrentSF$(whichline)
    'Get the name of the SUB/FUNCTION whichline is in.

    sfname$ = ""
    IF whichline > 0 THEN
        FOR currSF_CHECK = whichline TO 1 STEP -1
            thisline$ = idegetline(currSF_CHECK)
            thisline$ = ltrim$(RTRIM$(thisline$))
            isSF = 0
            ncthisline$ = UCASE$(thisline$)
            IF LEFT$(ncthisline$, 4) = "SUB " THEN isSF = 1
            IF LEFT$(ncthisline$, 9) = "FUNCTION " THEN isSF = 2
            IF isSF > 0 THEN
                IF RIGHT$(ncthisline$, 7) = " STATIC" THEN
                    thisline$ = RTRIM$(LEFT$(thisline$, LEN(thisline$) - 7))
                END IF

                thisline$ = RTRIM$(LTRIM$(thisline$))
                checkargs = INSTR(thisline$, "(")
                IF checkargs > 0 THEN
                    sfname$ = RTRIM$(LEFT$(thisline$, checkargs - 1))
                ELSE
                    sfname$ = thisline$
                END IF

                'It could be that SUB or FUNCTION is inside a DECLARE LIBRARY.
                'In such case, it must be ignored:
                InsideDECLARE = 0
                FOR declib_CHECK = currSF_CHECK TO 1 STEP -1
                    thisline$ = idegetline(declib_CHECK)
                    thisline$ = rtrim$(lTRIM$(thisline$))
                    ncthisline$ = UCASE$(thisline$)
                    IF LEFT$(ncthisline$, 8) = "DECLARE " AND INSTR(ncthisline$, " LIBRARY") > 0 THEN InsideDECLARE = -1: EXIT FOR
                    IF LEFT$(ncthisline$, 11) = "END DECLARE" THEN EXIT FOR
                NEXT

                IF InsideDECLARE = -1 THEN
                    sfname$ = ""
                END IF
                EXIT FOR
            END IF
        NEXT
    END IF

    FindCurrentSF$ = sfname$
END FUNCTION

SUB AddQuickNavHistory(LineNumber&)

    IF QuickNavTotal > 0 THEN
        IF QuickNavHistory(QuickNavTotal) = LineNumber& THEN EXIT SUB
    END IF

    QuickNavTotal = QuickNavTotal + 1
    REDIM _PRESERVE QuickNavHistory(1 TO QuickNavTotal) AS LONG

    QuickNavHistory(QuickNavTotal) = LineNumber&
END SUB

'$INCLUDE:'wiki\wiki_methods.bas'

