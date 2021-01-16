FUNCTION ide (ignore)
    'Note: ide is a function which optimizes the interaction between the IDE and compiler (ide2)
    '      by avoiding unnecessary bloat associated with entering the main IDE function 'ide2'
    ignore = ignore 'just to clear warnings of unused variables
    IF idecommand$ <> "" THEN cmd = ASC(idecommand$)
    IF cmd = 3 THEN 'request next line (compiler->ide)
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

                        'Update compilation progress on the status bar
                        IF ideautorun <> 0 THEN
                            IF prepass THEN
                                status.progress$ = str2$(INT((idecompiledline * 100) / (iden * 2)))
                                status.progress$ = STRING$(3 - LEN(status.progress$), 32) + status.progress$ + "%"
                            ELSE
                                status.progress$ = str2$(INT(((iden + idecompiledline) * 100) / (iden * 2)))
                                status.progress$ = STRING$(3 - LEN(status.progress$), 32) + status.progress$ + "%"
                            END IF
                            IdeInfo = CHR$(0) + status.progress$
                        END IF
                        UpdateIdeInfo

                        EXIT FUNCTION
                    END IF
                    IF iCHANGED THEN iCHECKLATER = 1
                END IF 'ideexit
            END IF 'not on screen
        ELSE
            IF IdeSystem <> 3 OR LEFT$(IdeInfo, 19) <> "Selection length = " THEN IdeInfo = ""
            UpdateIdeInfo
        END IF 'idecompiledline<iden
    END IF

    ide = ide2(0)
END FUNCTION

FUNCTION ide2 (ignore)
    STATIC MenuLocations AS STRING
    STATIC idesystem2.issel AS _BYTE
    STATIC idesystem2.sx1 AS LONG
    STATIC idesystem2.v1 AS LONG
    STATIC AttemptToLoadRecent AS _BYTE
    STATIC old.mX, old.mY
    STATIC last.TBclick#, wholeword.select AS _BYTE
    STATIC wholeword.selectx1, wholeword.idecx
    STATIC wholeword.selecty1, wholeword.idecy
    STATIC ForceResize, IDECompilationRequested AS _BYTE
    STATIC QuickNavHover AS _BYTE, FindFieldHover AS _BYTE

    ignore = ignore 'just to clear warnings of unused variables

    CONST idesystem2.w = 20 '"Find" field width (Status bar)
    char.sep$ = CHR$(34) + " =<>+-/\^:;,*()."

    c$ = idecommand$

    'report any IDE errors which have occurred
    IF ideerror THEN
        mustdisplay = 1
        IF ideerror = 1 THEN errorat$ = "IDE module error"
        IF ideerror = 2 THEN errorat$ = "File not found"
        IF ideerror = 3 THEN errorat$ = "File access error": CLOSE #150
        IF ideerror = 4 THEN errorat$ = "Path not found"
        IF ideerror = 5 THEN errorat$ = "Cannot create folder"
        IF ideerror = 6 THEN errorat$ = "Cannot save file"
        IF ideerror = -1 THEN GOTO errorReportDone 'fail quietly - like ON ERROR RESUME NEXT

        qberrorcode = ERR
        IF qberrorcode THEN
            ideerrormessageTITLE$ = "Error " + str2$(qberrorcode)
        ELSE
            ideerrormessageTITLE$ = "Error"
        END IF

        IF (ideerror > 1) THEN
            'Don't show too much detail if user just tried loading an invalid file
            ideerrormessageTITLE$ = ideerrormessageTITLE$ + " (" + str2$(_ERRORLINE) + "-" + str2$(_INCLERRORLINE) + ")"
            IF AttemptToLoadRecent = -1 THEN
                'Offer to cleanup recent file list, removing invalid entries
                PCOPY 2, 0
                result = idemessagebox(ideerrormessageTITLE$, errorat$ + "." + CHR$(10) + CHR$(10) + "Remove broken links from recent files?", "#Yes;#No")
                IF result = 1 THEN
                    GOSUB CleanUpRecentList
                END IF
                PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                GOTO errorReportDone
            END IF
        ELSE
            'a more serious error; let's report something that'll help bug reporting
            inclerrorline = _INCLERRORLINE
            IF inclerrorline THEN
            errorat$ = errorat$ + CHR$(10) + " " + CHR$(10) + "(module: " + _
                       RemoveFileExtension$(LEFT$(_INCLERRORFILE$, 60))
                errorat$ = errorat$ + ", on line: " + str2$(inclerrorline) + ")"
            ELSE
                errorat$ = errorat$ + CHR$(10) + " " + CHR$(10) + "(on line: " + str2$(_ERRORLINE) + ")"
            END IF
        END IF

        PCOPY 3, 0
        result = idemessagebox(ideerrormessageTITLE$, errorat$, "")
        errorReportDone:
    END IF

    ideerror = 1 'unknown IDE error
    AttemptToLoadRecent = 0

    IF LEFT$(c$, 1) = CHR$(12) THEN
        f$ = RIGHT$(c$, LEN(c$) - 1)
        LOCATE , , 0
        COLOR 7, 1: LOCATE idewy - 3, 2: PRINT SPACE$(idewx - 2);: LOCATE idewy - 2, 2: PRINT SPACE$(idewx - 2);: LOCATE idewy - 1, 2: PRINT SPACE$(idewx - 2); 'clear status window

        dummy = DarkenFGBG(1)
        BkpIdeSystem = IdeSystem: IdeSystem = 2: GOSUB UpdateTitleOfMainWindow: IdeSystem = BkpIdeSystem
        COLOR 1, 7: LOCATE idewy - 4, (idewx - 8) / 2: PRINT " Status "
        COLOR 15, 1

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
        IF IDE_UseFont8 THEN _FONT 8 ELSE _FONT 16

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

        m = m + 1: i = 0: ViewMenuID = m
        menu$(m, i) = "View": i = i + 1
        menu$(m, i) = "#SUBs...  F2": i = i + 1
        menu$(m, i) = "#Line Numbers  " + CHR$(16): i = i + 1
        menu$(m, i) = "-": i = i + 1

        ViewMenuCompilerWarnings = i
        menu$(ViewMenuID, ViewMenuCompilerWarnings) = "Compiler #Warnings...  Ctrl+W": i = i + 1
        menusize(m) = i - 1

        m = m + 1: i = 0: SearchMenuID = m
        menu$(m, i) = "Search": i = i + 1
        menu$(m, i) = "#Find...  Ctrl+F3": i = i + 1
        menu$(m, i) = "#Repeat Last Find  (Shift+) F3": i = i + 1
        menu$(m, i) = "#Change...  Alt+F3": i = i + 1
        menu$(m, i) = "-": i = i + 1
        menu$(m, i) = "Clear Search #History...": i = i + 1
        menu$(m, i) = "-": i = i + 1

        SearchMenuEnableQuickNav = i
        menu$(m, i) = "Enable #Quick Navigation (Back Arrow)": i = i + 1
        IF EnableQuickNav THEN
            menu$(SearchMenuID, SearchMenuEnableQuickNav) = CHR$(7) + menu$(SearchMenuID, SearchMenuEnableQuickNav)
        END IF
        menu$(m, i) = "-": i = i + 1
        menu$(m, i) = "Add/Remove #Bookmark  Alt+Left": i = i + 1
        menu$(m, i) = "#Next Bookmark  Alt+Down": i = i + 1
        menu$(m, i) = "#Previous Bookmark  Alt+Up": i = i + 1
        menu$(m, i) = "-": i = i + 1
        menu$(m, i) = "#Go To Line...  Ctrl+G": i = i + 1

        menusize(m) = i - 1

        m = m + 1: i = 0: RunMenuID = m
        menu$(m, i) = "Run": i = i + 1
        menu$(m, i) = "#Start  F5": i = i + 1
        menu$(m, i) = "Modify #COMMAND$...": i = i + 1
        menu$(m, i) = "-": i = i + 1

        RunMenuSaveExeWithSource = i
        menu$(m, i) = "Output EXE to Source #Folder": i = i + 1
        IF SaveExeWithSource THEN
            menu$(RunMenuID, RunMenuSaveExeWithSource) = CHR$(7) + menu$(RunMenuID, RunMenuSaveExeWithSource)
        END IF
        menu$(m, i) = "-": i = i + 1

        'menu$(m, i) = "Start (#Detached)  Ctrl+F5": i = i + 1
        IF os$ = "LNX" THEN
            menu$(m, i) = "Make E#xecutable Only  F11": i = i + 1
        ELSE
            menu$(m, i) = "Make E#XE Only  F11": i = i + 1
        END IF

        menusize(m) = i - 1

        m = m + 1: i = 0: OptionsMenuID = m
        menu$(m, i) = "Options": i = i + 1
        menu$(m, i) = "#Display...": i = i + 1
        menu$(m, i) = "IDE C#olors...": i = i + 1
        menu$(m, i) = "#Code Layout...": i = i + 1
        menu$(m, i) = "-": i = i + 1
        menu$(m, i) = "#Language...": i = i + 1
        menu$(m, i) = "#Backup/Undo...": i = i + 1
        menu$(m, i) = "#Advanced...": i = i + 1
        menu$(m, i) = "-": i = i + 1

        OptionsMenuDisableSyntax = i
        menu$(m, i) = "Disable Syntax #Highlighter": i = i + 1
        IF DisableSyntaxHighlighter THEN
            menu$(OptionsMenuID, OptionsMenuDisableSyntax) = CHR$(7) + menu$(OptionsMenuID, OptionsMenuDisableSyntax)
        END IF

        OptionsMenuSwapMouse = i
        menu$(m, i) = "#Swap Mouse Buttons": i = i + 1
        IF MouseButtonSwapped THEN
            menu$(OptionsMenuID, OptionsMenuSwapMouse) = CHR$(7) + menu$(OptionsMenuID, OptionsMenuSwapMouse)
        END IF

        OptionsMenuPasteCursor = i
        menu$(m, i) = "Cursor After #Pasted Content": i = i + 1
        IF PasteCursorAtEnd THEN
            menu$(OptionsMenuID, OptionsMenuPasteCursor) = CHR$(7) + menu$(OptionsMenuID, OptionsMenuPasteCursor)
        END IF

        OptionsMenuShowErrorsImmediately = i
        menu$(m, i) = "Show Compilation #Errors Immediately": i = i + 1
        IF IDEShowErrorsImmediately THEN
            menu$(OptionsMenuID, OptionsMenuShowErrorsImmediately) = CHR$(7) + menu$(OptionsMenuID, OptionsMenuShowErrorsImmediately)
        END IF

        OptionsMenuIgnoreWarnings = i
        menu$(m, i) = "Ignore #Warnings": i = i + 1
        IF IgnoreWarnings THEN menu$(OptionsMenuID, OptionsMenuIgnoreWarnings) = CHR$(7) + "Ignore #Warnings"

        menusize(m) = i - 1

        m = m + 1: i = 0
        menu$(m, i) = "Tools": i = i + 1
        menu$(m, i) = "#ASCII Chart...": i = i + 1
        menu$(m, i) = "Insert Quick #Keycode  Ctrl+K": i = i + 1
        menu$(m, i) = "#Math Evaluator...": i = i + 1
        menu$(m, i) = "#RGB Color Mixer...": i = i + 1
        menusize(m) = i - 1


        m = m + 1: i = 0
        menu$(m, i) = "Help": i = i + 1
        menu$(m, i) = "#View  Shift+F1": i = i + 1
        menu$(m, i) = "#Contents Page": i = i + 1
        menu$(m, i) = "Keyword #Index": i = i + 1
        menu$(m, i) = "#Keywords by Usage": i = i + 1
        menu$(m, i) = "-": i = i + 1
        menu$(m, i) = "#Update Current Page": i = i + 1
        menu$(m, i) = "Update All #Pages...": i = i + 1
        menu$(m, i) = "-": i = i + 1
        menu$(m, i) = "#About...": i = i + 1
        menusize(m) = i - 1

        menus = m

        'Hidden contextual menu (ID is retrieved for later use; allows expansion of the original menu system above):
        m = m + 1
        idecontextualmenuID = m

        'View Menu sub menu for Line Numbers options
        m = m + 1: i = 0
        menu$(m, i) = "ViewMenuShowLineNumbersSubMenu": i = i + 1
        ViewMenuShowLineNumbersSubMenuID = m
        IF ShowLineNumbers THEN menu$(m, i) = "#Hide Line Numbers" ELSE menu$(m, i) = "#Show Line Numbers"
        i = i + 1
        menu$(m, i) = "#Background Color": IF ShowLineNumbersUseBG THEN menu$(m, i) = CHR$(7) + menu$(m, i)
        ViewMenuShowBGID = i
        IF ShowLineNumbers = 0 THEN menu$(m, i) = "~" + menu$(m, i)
        i = i + 1
        menu$(m, i) = "Sho#w Separator": IF ShowLineNumbersSeparator THEN menu$(m, i) = CHR$(7) + menu$(m, i)
        ViewMenuShowSeparatorID = i
        IF ShowLineNumbers = 0 THEN menu$(m, i) = "~" + menu$(m, i)
        i = i + 1
        menusize(m) = i - 1

        IF os$ = "WIN" THEN
            idepathsep$ = "\"
        END IF
        IF os$ = "LNX" THEN
            idepathsep$ = "/"
        END IF

        initmouse
        a$ = "QWERTYUIOP????ASDFGHJKL?????ZXCVBNM": x = 16: FOR i = 1 TO LEN(a$): idealtcode(ASC(MID$(a$, i, 1))) = x: x = x + 1: NEXT

        ideroot$ = idezgetroot$
        idepath$ = _STARTDIR$

        'new blank text field
        idet$ = MKL$(0) + MKL$(0): idel = 1: ideli = 1: iden = 1: IdeBmkN = 0
        ideunsaved = -1
        idechangemade = 1

        redraweverything:
        ideselect = 0
        idesx = 1
        idesy = 1
        idecx = 1
        idecy = 1

        redraweverything2:
        GOSUB redrawItAll

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
                PCOPY 3, 0
                IF BinaryFormatCheck%(path$, idepathsep$, f$) > 0 THEN GOTO skipload
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
                IF ideStartAtLine > 0 AND ideStartAtLine <= iden THEN
                    idecy = ideStartAtLine
                    IF idecy - 10 >= 1 THEN idesy = idecy - 10
                    idegotobox_LastLineNum = ideStartAtLine
                    ideStartAtLine = 0
                END IF
                IdeBmkN = 0
                ideerror = 1
                ideprogname = f$: _TITLE ideprogname + " - " + WindowTitle
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
            IF ready THEN
                IF IDEShowErrorsImmediately THEN
                    LOCATE idewy - 3, 2: PRINT "OK"; 'report OK status
                    statusarealink = 0
                    IF totalWarnings > 0 AND showexecreated = 0 THEN
                        COLOR 11, 1
                        PRINT " ("; LTRIM$(STR$(totalWarnings)) + " warning";
                        IF totalWarnings > 1 THEN PRINT "s";
                        PRINT " - click here or Ctrl+W to view)";
                        statusarealink = 4
                    END IF
                END IF
            END IF
            IF showexecreated THEN
                showexecreated = 0
                LOCATE idewy - 3, 2

                IF os$ = "LNX" THEN
                    PRINT "Executable file created";
                ELSE
                    PRINT ".EXE file created";
                END IF

                IF SaveExeWithSource THEN
                    LOCATE idewy - 2, 2
                    PRINT "Location: ";
                    COLOR 11, 1
                    location$ = lastBinaryGenerated$
                    IF path.exe$ = "" THEN location$ = _STARTDIR$ + pathsep$ + location$
                    IF POS(0) + LEN(location$) > idewx THEN
                        PRINT "..."; RIGHT$(location$, idewx - 15);
                    ELSE
                        PRINT location$;
                    END IF
                    statusarealink = 3
                END IF

            END IF
        END IF

    END IF 'skipdisplay

    idefocusline = 0





























    'main loop
    DO
        ideloop:
        IF ShowLineNumbers THEN maxLineNumberLength = LEN(STR$(iden)) + 1 ELSE maxLineNumberLength = 0
        idecontextualmenu = 0
        idedeltxt 'removes temporary strings (typically created by guibox commands) by setting an index to 0
        IF idesubwindow <> 0 THEN _RESIZE OFF ELSE _RESIZE ON

        IF (_RESIZE OR ForceResize) AND timeElapsedSince(QB64_uptime!) > 1.5 THEN
            IF idesubwindow <> 0 THEN 'If there's a subwindow up, don't resize as it screws all sorts of things up.
                ForceResize = -1
            ELSE
                retval = 0
                ForceResize = 0
                DO
                    tooSmall%% = 0
                    v% = _RESIZEWIDTH \ _FONTWIDTH: IF v% < 80 OR v% > 1000 THEN v% = 80: tooSmall%% = -1
                    IF v% <> idewx THEN retval = 1: idewx = v%
                    v% = _RESIZEHEIGHT \ _FONTHEIGHT: IF v% < 25 OR v% > 1000 THEN v% = 25: tooSmall%% = -1
                    IF v% <> idewy THEN retval = 1: idewy = v%

                    tempf& = _FONT
                    WIDTH idewx, idewy
                    _FONT tempf&

                    _PALETTECOLOR 1, IDEBackgroundColor, 0
                    _PALETTECOLOR 2, _RGB32(84, 84, 84), 0 'dark gray - help system and interface details
                    _PALETTECOLOR 5, IDEBracketHighlightColor, 0
                    _PALETTECOLOR 6, IDEBackgroundColor2, 0
                    _PALETTECOLOR 8, IDENumbersColor, 0
                    _PALETTECOLOR 10, IDEMetaCommandColor, 0
                    _PALETTECOLOR 11, IDECommentColor, 0
                    _PALETTECOLOR 12, IDEKeywordColor, 0
                    _PALETTECOLOR 13, IDETextColor, 0
                    _PALETTECOLOR 14, IDEQuoteColor, 0

                    'static background
                    COLOR 0, 7
                    LOCATE 1, 1: PRINT SPACE$(idewx);
                    LOCATE 1, 1: PRINT LEFT$(menubar$, idewx);
                    COLOR 7, 1: idebox 1, 2, idewx, idewy - 5

                    COLOR 7, 1: idebox 1, idewy - 4, idewx, 5
                    'edit corners
                    COLOR 7, 1: LOCATE idewy - 4, 1: PRINT CHR$(195);: LOCATE idewy - 4, idewx: PRINT CHR$(180);

                    GOSUB UpdateSearchBar

                    'status bar
                    COLOR 0, 3: LOCATE idewy + idesubwindow, 1: PRINT SPACE$(idewx);
                    q = idevbar(idewx, idewy - 3, 3, 1, 1)
                    q = idevbar(idewx, 3, idewy - 8, 1, 1)
                    q = idehbar(2, idewy - 5, idewx - 2, 1, 1)

                    GOSUB UpdateTitleOfMainWindow

                    COLOR 7, 1
                    _PRINTSTRING (2, idewy - 3), "Resizing..."
                    IF tooSmall%% THEN
                        COLOR 14, 1
                        _PRINTSTRING (2, 3), "ERROR: Minimum window size is 80x25"
                    ELSE
                        ideshowtext
                    END IF

                    _DISPLAY
                    _LIMIT 30
                LOOP WHILE _RESIZE

                IF retval = 1 THEN 'screen dimensions have changed and everything must be redrawn/reapplied
                    WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_Width", STR$(idewx)
                    WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_Height", STR$(idewy)
                END IF

                retval = 1
                _AUTODISPLAY
                GOSUB redrawItAll
            END IF
        ELSE
            _AUTODISPLAY
        END IF

        IF skipdisplay = 0 THEN

            LOCATE , , 0

            'Get the currently being edited SUB/FUNCTION name to show after the main window title
            '(standard QB4.5 behavior). The FOR...NEXT loop was taken and adapted from FUNCTION
            'idesubs$, but it goes backwards from the current line to the start of the program
            'to see if we're inside a SUB/FUNCTION. EXITs FOR once that is figured.
            sfname$ = ""
            FOR currSF_CHECK = idecy TO 1 STEP -1
                thisline$ = idegetline(currSF_CHECK)
                thisline$ = LTRIM$(RTRIM$(thisline$))
                isSF = 0
                ncthisline$ = UCASE$(thisline$)
                IF LEFT$(ncthisline$, 4) = "SUB " THEN isSF = 1
                IF LEFT$(ncthisline$, 9) = "FUNCTION " THEN isSF = 2
                IF LEFT$(ncthisline$, 7) = "END SUB" AND currSF_CHECK < idecy THEN EXIT FOR
                IF LEFT$(ncthisline$, 12) = "END FUNCTION" AND currSF_CHECK < idecy THEN EXIT FOR
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
                    FOR declib_CHECK = currSF_CHECK TO 1 STEP -1
                        thisline$ = idegetline(declib_CHECK)
                        thisline$ = LTRIM$(RTRIM$(thisline$))
                        ncthisline$ = UCASE$(thisline$)
                        IF LEFT$(ncthisline$, 8) = "DECLARE " AND INSTR(ncthisline$, " LIBRARY") > 0 THEN InsideDECLARE = -1: EXIT FOR
                        IF LEFT$(ncthisline$, 11) = "END DECLARE" THEN EXIT FOR
                    NEXT

                    IF InsideDECLARE = -1 THEN
                        sfname$ = ""
                    ELSE
                        'Ok, we're not inside a DECLARE LIBRARY.
                        'But what if we're past the end of this module's SUBs and FUNCTIONs,
                        'and all that's left is a bunch of comments or $INCLUDES?
                        'We'll also check for that:
                        endedSF = 0
                        FOR endSF_CHECK = idecy TO iden
                            thisline$ = idegetline(endSF_CHECK)
                            thisline$ = LTRIM$(RTRIM$(thisline$))
                            ncthisline$ = UCASE$(thisline$)
                            IF LEFT$(ncthisline$, 7) = "END SUB" THEN endedSF = 1: EXIT FOR
                            IF LEFT$(ncthisline$, 12) = "END FUNCTION" THEN endedSF = 2: EXIT FOR
                            IF LEFT$(ncthisline$, 4) = "SUB " AND endSF_CHECK = idecy THEN endedSF = 1: EXIT FOR
                            IF LEFT$(ncthisline$, 9) = "FUNCTION " AND endSF_CHECK = idecy THEN endedSF = 2: EXIT FOR
                            IF LEFT$(ncthisline$, 4) = "SUB " AND InsideDECLARE = 0 THEN EXIT FOR
                            IF LEFT$(ncthisline$, 9) = "FUNCTION " AND InsideDECLARE = 0 THEN EXIT FOR
                            IF LEFT$(ncthisline$, 8) = "DECLARE " AND INSTR(ncthisline$, " LIBRARY") > 0 THEN InsideDECLARE = -1
                            IF LEFT$(ncthisline$, 11) = "END DECLARE" THEN InsideDECLARE = 0
                        NEXT
                        IF endedSF = 0 THEN sfname$ = "" ELSE EXIT FOR
                    END IF
                END IF
            NEXT

            'attempt to cleanse sfname$, just in case there are any comments or other unwanted stuff
            FOR CleanseSFNAME = 1 TO LEN(sfname$)
                SELECT CASE MID$(sfname$, CleanseSFNAME, 1)
                    CASE " ", "'", ":"
                        sfname$ = LEFT$(sfname$, CleanseSFNAME - 1)
                        EXIT FOR
                END SELECT
            NEXT

            'update title of main window
            GOSUB UpdateTitleOfMainWindow

            'Draw navigation buttons (QuickNav)
            IF EnableQuickNav THEN GOSUB DrawQuickNav

            'update search bar
            GOSUB UpdateSearchBar

            'alter cursor style to match insert mode
            IF ideinsert THEN LOCATE , , , 0, 31 ELSE LOCATE , , , IDENormalCursorStart, IDENormalCursorEnd

            'display error message (if necessary)
            IF failed THEN
                IF IDEShowErrorsImmediately <> 0 OR IDECompilationRequested <> 0 OR compfailed <> 0 THEN
                    IF LEFT$(IdeInfo, 19) <> "Selection length = " THEN IdeInfo = ""
                    UpdateIdeInfo

                    COLOR 7, 1: LOCATE idewy - 3, 2: PRINT SPACE$(idewx - 2);: LOCATE idewy - 2, 2: PRINT SPACE$(idewx - 2);: LOCATE idewy - 1, 2: PRINT SPACE$(idewx - 2); 'clear status window
                    'scrolling unavailable, but may span multiple lines
                    IF compfailed THEN
                        a$ = MID$(c$, 2, LEN(c$) - 5)

                        x = 1
                        y = idewy - 3
                        FOR i = 1 TO LEN(a$)
                            IF ASC(a$, i) = 0 THEN
                                IF _DEFAULTCOLOR = 7 THEN COLOR 11 ELSE COLOR 7
                                _CONTINUE
                            END IF
                            x = x + 1: IF x = idewx THEN x = 2: y = y + 1
                            IF y > idewy - 1 THEN EXIT FOR
                            LOCATE y, x
                            PRINT CHR$(ASC(a$, i));
                        NEXT
                        statusarealink = 1
                    ELSE
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
                            a$ = " on line" + STR$(l) + " (click here or Ctrl+Shift+G to jump there)"
                            COLOR 11, 1
                            FOR i = 1 TO LEN(a$)
                                x = x + 1: IF x = idewx THEN x = 2: y = y + 1
                                IF y > idewy - 1 THEN EXIT FOR
                                LOCATE y, x
                                PRINT CHR$(ASC(a$, i));
                            NEXT
                            statusarealink = 2
                        END IF

                        IF y < idewy - 1 AND linefragment <> "[INFORMATION UNAVAILABLE]" THEN
                            temp$ = linefragment
                            FOR i = 1 TO LEN(temp$)
                                IF MID$(temp$, i, 1) = sp$ THEN MID$(temp$, i, 1) = " "
                            NEXT
                            temp$ = _TRIM$(temp$)
                            IF LEN(temp$) THEN
                                y = y + 1: x = 1
                                temp$ = "Caused by (or after): " + CHR$(1) + temp$

                                COLOR 7, 1
                                FOR i = 1 TO LEN(temp$)
                                    x = x + 1: IF x = idewx THEN x = 2: y = y + 1
                                    IF y > idewy - 1 THEN EXIT FOR
                                    IF ASC(temp$, i) = 1 THEN i = i + 1: COLOR 11, 1
                                    LOCATE y, x
                                    PRINT CHR$(ASC(temp$, i));
                                NEXT
                            END IF
                        END IF

                    END IF
                END IF
            END IF

            IF idechangemade THEN
                IF IDEShowErrorsImmediately OR IDECompilationRequested THEN
                    COLOR 7, 1: LOCATE idewy - 3, 2: PRINT SPACE$(idewx - 2);: LOCATE idewy - 2, 2: PRINT SPACE$(idewx - 2);: LOCATE idewy - 1, 2: PRINT SPACE$(idewx - 2); 'clear status window

                    IdeInfo = ""

                    LOCATE idewy - 3, 2: PRINT "..."; 'assume new compilation will begin
                END IF
            END IF

            ideshowtext

            IF idehelp THEN




                Help_ShowText

                q = idehbar(2, idewy + idesubwindow - 1, idewx - 2, Help_cx, help_w + 1)
                q = idevbar(idewx, idewy + 1, idesubwindow - 2, Help_cy, help_h + 1)

                'COLOR 0, 7: LOCATE idewy, (idewx - 6) / 2: PRINT " Help "
                'create and draw back string
                GOSUB HelpAreaShowBackLinks

                'Help_Search_Str
                IF IdeSystem = 3 AND LEFT$(IdeInfo, 1) <> CHR$(0) THEN
                    a$ = ""
                    IF LEN(Help_Search_Str) THEN
                        a$ = Help_Search_Str
                        IF LEN(a$) > 20 THEN a$ = STRING$(3, 250) + RIGHT$(a$, 17)
                        a$ = "[" + a$ + "](DELETE=next)"
                        IdeInfo = a$
                    ELSE
                        IdeInfo = "Start typing to search for text in this help page"
                    END IF
                    UpdateIdeInfo
                END IF
            ELSE
                Help_Search_Str = ""
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
                LOCATE Help_cy - Help_sy + Help_wy1, Help_cx - Help_sx + Help_wx1
                SCREEN , , 3, 0
            END IF

            LOCATE , , 1


            PCOPY 3, 0

        END IF 'skipdisplay

        IF WhiteListQB64FirstTimeMsg = 0 THEN
            result = idemessagebox("Welcome to QB64", "QB64 is an independently distributed program, and as such" + CHR$(10) + _
                                                      "both 'qb64" + extension$ + "' and the programs you create with it may" + CHR$(10) + _
                                                      "eventually be flagged as false positives by your" + CHR$(10) + _
                                                      "antivirus/antimalware software." + CHR$(10) + CHR$(10) + _
                                                      "It is advisable to whitelist your whole QB64 folder to avoid" + CHR$(10) + _
                                                      "operation errors.", "#OK;#Don't show this again")

            PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
            IF result = 2 THEN
                WriteConfigSetting "'[GENERAL SETTINGS]", "WhiteListQB64FirstTimeMsg", "TRUE"
            END IF
            WhiteListQB64FirstTimeMsg = -1
        END IF

        STATIC idechangedbefore AS _BYTE
        IF idechangemade THEN

            IF idelayoutallow THEN idelayoutallow = idelayoutallow - 1

            idecurrentlinelayouti = 0 'invalidate
            idefocusline = 0
            idechangemade = 0
            idechangedbefore = -1
            IDECompilationRequested = 0
            compfailed = 0
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
        IF mB = 0 THEN idemouseselect = 0: idembmonitor = 0: wholeword.select = 0

        IF _RESIZE THEN
            ForceResize = -1: skipdisplay = 0: GOTO ideloop
        END IF

        IF IDE_AutoPosition THEN
            IF IDE_TopPosition <> _SCREENY OR IDE_LeftPosition <> _SCREENX THEN
                IF _SCREENY >= -_HEIGHT * _FONTHEIGHT AND _SCREENX >= -_WIDTH * _FONTWIDTH THEN 'Don't record the position if it's off the screen, past the point where we can drag it back into a different position.
                    WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_TopPosition", STR$(_SCREENY)
                    WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_LeftPosition", STR$(_SCREENX)
                    IDE_TopPosition = _SCREENY: IDE_LeftPosition = _SCREENX
                END IF
            END IF
        END IF

        IF _TOTALDROPPEDFILES > 0 THEN
            IF _FILEEXISTS(_DROPPEDFILE$(1)) THEN
                IdeOpenFile$ = _DROPPEDFILE$(1)
                _FINISHDROP
                GOTO ctrlOpen
            END IF
            _FINISHDROP
        END IF

        'Hover/click (QuickNav, "Find" field)
        IF QuickNavTotal > 0 THEN
            DO UNTIL QuickNavHistory(QuickNavTotal) <= iden
                'make sure that the line number in history still exists
                QuickNavTotal = QuickNavTotal - 1
                IF QuickNavTotal = 0 THEN EXIT DO
            LOOP
        END IF

        IF IdeSystem = 1 AND QuickNavTotal > 0 AND EnableQuickNav THEN
            IF mY = 2 THEN
                IF mX >= 4 AND mX <= 6 THEN
                    QuickNavHover = -1
                    LOCATE 2, 4
                    COLOR 15, 3
                    popup$ = " " + CHR$(17) + " back to line " + str2$(QuickNavHistory(QuickNavTotal)) + " "
                    PRINT popup$;

                    'shadow
                    COLOR 2, 0
                    FOR x2 = 6 TO 4 + LEN(popup$)
                        LOCATE 3, x2: PRINT CHR$(SCREEN(3, x2));
                    NEXT

                    PCOPY 3, 0

                    IF mB THEN
                        ideselect = 0
                        idecy = QuickNavHistory(QuickNavTotal)
                        QuickNavTotal = QuickNavTotal - 1
                        _DELAY .2
                        GOTO waitforinput
                    END IF
                ELSE
                    IF QuickNavHover = -1 THEN
                        QuickNavHover = 0
                        GOSUB UpdateTitleOfMainWindow
                        GOSUB DrawQuickNav
                        ideshowtext
                        PCOPY 3, 0
                    END IF
                END IF
            ELSE
                IF QuickNavHover = -1 THEN
                    QuickNavHover = 0
                    GOSUB UpdateTitleOfMainWindow
                    GOSUB DrawQuickNav
                    ideshowtext
                    PCOPY 3, 0
                END IF
            END IF
        END IF

        IF mY = idewy - 4 AND mX > idewx - (idesystem2.w + 10) AND mX < idewx - 1 THEN 'inside text box
            IF mX <= idewx - (idesystem2.w + 8) + 2 THEN
                'Highlight "Find"
                LOCATE idewy - 4, idewx - (idesystem2.w + 9)
                COLOR 1, 3
                PRINT "Find";
                PCOPY 3, 0
                FindFieldHover = -1
            ELSE
                GOTO RestoreFindButton
            END IF
        ELSE
            RestoreFindButton:
            IF FindFieldHover = -1 THEN
                'Restore "Find" bg
                FindFieldHover = 0
                LOCATE idewy - 4, idewx - (idesystem2.w + 9)
                COLOR 3, 1
                PRINT "Find";
                PCOPY 3, 0
            END IF
        END IF


        IF os$ = "WIN" OR MacOSX = 1 THEN
            IF _WINDOWHASFOCUS THEN
                LOCATE , , 1
                _PALETTECOLOR 5, IDEBracketHighlightColor, 0
                _PALETTECOLOR 6, IDEBackgroundColor2, 0
            ELSE
                LOCATE , , 0
                _PALETTECOLOR 5, IDEBackgroundColor, 0
                _PALETTECOLOR 6, IDEBackgroundColor, 0
            END IF
        END IF

        IF KALT THEN 'alt held

            IF idealthighlight = 0 AND KALTPRESS = -1 AND NOT KCTRL THEN
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
                    IF _WINDOWHASFOCUS OR os$ = "LNX" THEN
                        LOCATE , , , IDENormalCursorStart, IDENormalCursorEnd
                        skipdisplay = 0
                        ideentermenu = 0
                        GOTO startmenu
                    ELSE
                        GOTO ideloop
                    END IF
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
                IF SCREEN(mY, mX, 1) = 11 + 1 * 16 THEN 'if the text clicked is in COLOR 11 it's a link
                    'Status area links
                    SELECT CASE statusarealink
                        CASE 1
                            '1- Link to compilelog.txt:
                            IF INSTR(_OS$, "WIN") THEN
                                SHELL _DONTWAIT QuotedFilename$(compilelog$)
                            ELSEIF INSTR(_OS$, "MAC") THEN
                                SHELL _DONTWAIT "open " + QuotedFilename$(compilelog$)
                            ELSE
                                SHELL _DONTWAIT "xdg-open " + QuotedFilename$(compilelog$)
                            END IF
                            GOTO specialchar
                        CASE 2
                            '2- Link to the line that has a compiler error:
                            idecx = 1
                            AddQuickNavHistory idecy
                            idecy = idefocusline
                            ideselect = 0
                            GOTO specialchar
                        CASE 3
                            '3- Link to the output folder when "Output EXE to source #folder" is checked:
                            IF INSTR(_OS$, "WIN") THEN
                                SHELL _DONTWAIT "explorer /select," + QuotedFilename$(lastBinaryGenerated$)
                            ELSEIF INSTR(_OS$, "MAC") THEN
                                SHELL _DONTWAIT "open " + QuotedFilename$(path.exe$)
                            ELSE
                                SHELL _DONTWAIT "xdg-open " + QuotedFilename$(path.exe$)
                            END IF
                            GOTO specialchar
                        CASE 4
                            '4- Link to Warnings dialog:
                            retval = idewarningbox
                            'retval is ignored
                            PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                            GOTO specialchar
                    END SELECT
                END IF
            END IF
        END IF

        IF KB = KEY_F11 THEN 'make exe only
            idemexe:
            iderunmode = 2
            GOTO idemrunspecial
        END IF

        IF KB = KEY_F5 THEN 'Note: F5 or SHIFT+F5 accepted
            idemrun:
            iderunmode = 1 'run detached; = 0 'standard run
            idemrunspecial:

            IDECompilationRequested = -1

            IF ExeToSourceFolderFirstTimeMsg = 0 THEN
                IF SaveExeWithSource THEN
                    result = idemessagebox("Run", "Your program will be compiled to the same folder where your" + CHR$(10) + _
                                           "source code is saved. You can change that by unchecking the" + CHR$(10) + _
                                           "option 'Output EXE to Source Folder' in the Run menu.", "#OK;#Don't show this again;#Cancel")
                ELSE
                    result = idemessagebox("Run", "Your program will be compiled to your QB64 folder. You can" + CHR$(10) + _
                                         "change that by checking the option 'Output EXE to Source" + CHR$(10) + _
                                         "Folder' in the Run menu.", "#OK;#Don't show this again;#Cancel")
                END IF
                IF result = 2 THEN
                    WriteConfigSetting "'[GENERAL SETTINGS]", "ExeToSourceFolderFirstTimeMsg", "TRUE"
                    ExeToSourceFolderFirstTimeMsg = -1
                ELSEIF result = 3 THEN
                    PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                    LOCATE , , 0
                    COLOR 7, 1: LOCATE idewy - 3, 2: PRINT SPACE$(idewx - 2);: LOCATE idewy - 2, 2: PRINT SPACE$(idewx - 2);: LOCATE idewy - 1, 2: PRINT SPACE$(idewx - 2); 'clear status window
                    LOCATE idewy - 3, 2
                    PRINT "Compilation request canceled."
                    GOTO specialchar
                END IF
            END IF
            PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt

            'run program
            IF ready <> 0 AND idechangemade = 0 THEN

                LOCATE , , 0
                COLOR 7, 1: LOCATE idewy - 3, 2: PRINT SPACE$(idewx - 2);: LOCATE idewy - 2, 2: PRINT SPACE$(idewx - 2);: LOCATE idewy - 1, 2: PRINT SPACE$(idewx - 2); 'clear status window

                IF idecompiled THEN

                    IF iderunmode = 2 AND _FILEEXISTS(lastBinaryGenerated$) THEN
                        LOCATE idewy - 3, 2

                        IF os$ = "LNX" THEN
                            PRINT "Already created executable file!";
                        ELSE
                            PRINT "Already created .EXE file!";
                        END IF

                        LOCATE idewy - 2, 2
                        PRINT "Location: ";
                        COLOR 11, 1
                        location$ = lastBinaryGenerated$
                        IF path.exe$ = "" THEN location$ = _STARTDIR$ + pathsep$ + location$
                        IF POS(0) + LEN(location$) > idewx THEN
                            PRINT "..."; RIGHT$(location$, idewx - 15);
                        ELSE
                            PRINT location$;
                        END IF
                        statusarealink = 3

                        GOTO specialchar
                    ELSEIF _FILEEXISTS(lastBinaryGenerated$) = 0 THEN
                        idecompiled = 0
                        GOTO mustGenerateExe
                    END IF

                    dummy = DarkenFGBG(1)
                    BkpIdeSystem = IdeSystem: IdeSystem = 2: GOSUB UpdateTitleOfMainWindow: IdeSystem = BkpIdeSystem
                    COLOR 1, 7: LOCATE idewy - 4, (idewx - 8) / 2: PRINT " Status "
                    COLOR 15, 1
                    LOCATE idewy - 3, 2: PRINT "Starting program...";
                ELSE
                    mustGenerateExe:
                    dummy = DarkenFGBG(1)
                    BkpIdeSystem = IdeSystem: IdeSystem = 2: GOSUB UpdateTitleOfMainWindow: IdeSystem = BkpIdeSystem
                    COLOR 1, 7: LOCATE idewy - 4, (idewx - 8) / 2: PRINT " Status "
                    COLOR 15, 1
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
        LOCATE , , , IDENormalCursorStart, IDENormalCursorEnd

        IF (mCLICK OR mCLICK2) AND idemouseselect = 0 THEN
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
            IF LEN(idefindtext) THEN idesystem2.issel = -1: idesystem2.sx1 = 0: idesystem2.v1 = LEN(idefindtext)
        END IF

        IF KCTRL AND UCASE$(K$) = "K" THEN
            K$ = ""
            GOTO ideQuickKeycode
        END IF


        IF KCTRL AND KB = KEY_F3 THEN
            IF IdeSystem = 3 THEN IdeSystem = 1
            GOTO idefindjmp
        END IF

        IF KALT AND KB = KEY_F3 THEN
            IF IdeSystem = 3 THEN IdeSystem = 1
            GOTO idefindchangejmp
        END IF

        IF KB = KEY_F3 THEN
            IF IdeSystem = 3 THEN IdeSystem = 1
            idemf3:
            IF idefindtext <> "" THEN
                IF IdeSystem = 2 THEN
                    idesystem2.sx1 = 0
                    idesystem2.v1 = LEN(idefindtext)
                    idesystem2.issel = -1
                END IF
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
                retval = 1: GOSUB redrawItAll
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
                            IF idesystem2.issel THEN idesystem2.issel = 0

                            IF LEN(idefindtext) <= idesystem2.w THEN
                                idesystem2.v1 = mX - (idewx - (idesystem2.w + 4))
                            ELSE
                                IF idesystem2.v1 > idesystem2.w THEN
                                    idesystem2.v1 = (mX - (idewx - (idesystem2.w + 4))) + (idesystem2.v1 - idesystem2.w)
                                ELSE
                                    idesystem2.v1 = mX - (idewx - (idesystem2.w + 4))
                                END IF
                            END IF
                        ELSE
                            IdeSystem = 2
                            IF LEN(idefindtext) THEN idesystem2.issel = -1: idesystem2.sx1 = 0: idesystem2.v1 = LEN(idefindtext)
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

                IF mCLICK2 THEN
                    GOTO invokecontextualmenu
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
                    pasteIntoSearchField:
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
                                IF PasteCursorAtEnd THEN
                                    idesystem2.v1 = sx1 + LEN(clip$)
                                END IF
                                idesystem2.issel = 0
                            END IF
                        ELSE
                            a$ = LEFT$(a$, idesystem2.v1) + clip$ + RIGHT$(a$, LEN(a$) - idesystem2.v1)
                            IF PasteCursorAtEnd THEN idesystem2.v1 = idesystem2.v1 + LEN(clip$)
                        END IF
                    END IF
                    k = 255
                END IF

                IF (KCONTROL AND UCASE$(K$) = "A") THEN 'select all
                    selectAllInSearchField:
                    IF LEN(a$) > 0 THEN
                        idesystem2.issel = -1
                        idesystem2.sx1 = 0
                        idesystem2.v1 = LEN(a$)
                    END IF
                    k = 255
                END IF

                IF ((KCTRL AND KB = KEY_INSERT) OR (KCONTROL AND UCASE$(K$) = "C")) THEN 'copy to clipboard
                    copysearchterm2clip:
                    IF idesystem2.issel THEN
                        sx1 = idesystem2.sx1: sx2 = idesystem2.v1
                        IF sx1 > sx2 THEN SWAP sx1, sx2
                        IF sx2 - sx1 > 0 THEN _CLIPBOARD$ = MID$(a$, sx1 + 1, sx2 - sx1)
                    END IF
                    k = 255
                END IF

                IF ((KSHIFT AND KB = KEY_DELETE) OR (KCONTROL AND UCASE$(K$) = "X")) THEN 'cut to clipboard
                    cutToClipboardSearchField:
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
                        END IF
                    END IF
                    IF idesystem2.v1 > 0 THEN a1$ = LEFT$(a$, idesystem2.v1) ELSE a1$ = ""
                    IF idesystem2.v1 <= LEN(a$) THEN a2$ = RIGHT$(a$, LEN(a$) - idesystem2.v1) ELSE a2$ = ""
                    a$ = a1$ + K$ + a2$: idesystem2.v1 = idesystem2.v1 + 1
                END IF
                idefindtext = a$
            END IF

            IF K$ = CHR$(0) + CHR$(60) THEN 'F2
                IdeSystem = 1
                GOTO idesubsjmp
            END IF

            IF K$ = CHR$(0) + "S" THEN 'DEL
                deleteSelectionSearchField:
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
                ELSE
                    IF idesystem2.v1 > 0 THEN a1$ = LEFT$(a$, idesystem2.v1) ELSE a1$ = ""
                    IF idesystem2.v1 < LEN(a$) THEN a2$ = RIGHT$(a$, LEN(a$) - idesystem2.v1 - 1) ELSE a2$ = ""
                    a$ = a1$ + a2$
                    idefindtext = a$
                END IF
            END IF

            'cursor control
            IF K$ = CHR$(0) + "K" THEN GOSUB selectcheck: idesystem2.v1 = idesystem2.v1 - 1
            IF K$ = CHR$(0) + "M" THEN GOSUB selectcheck: idesystem2.v1 = idesystem2.v1 + 1
            IF K$ = CHR$(0) + "G" THEN GOSUB selectcheck: idesystem2.v1 = 0
            IF K$ = CHR$(0) + "O" THEN GOSUB selectcheck: idesystem2.v1 = LEN(a$)
            IF idesystem2.v1 < 0 THEN idesystem2.v1 = 0
            IF idesystem2.v1 > LEN(a$) THEN idesystem2.v1 = LEN(a$)
            IF idesystem2.v1 = idesystem2.sx1 THEN idesystem2.issel = 0

            IF mCLICK OR mCLICK2 THEN
                IF mX > 1 AND mX < idewx AND mY > 2 AND mY < (idewy - 5) THEN 'inside text box
                    IdeSystem = 1
                    IF mCLICK2 THEN GOTO invokecontextualmenu ELSE GOTO ideloop
                ELSEIF mY >= idewy AND mY < idewy + idesubwindow THEN 'inside help
                    IdeSystem = 3
                    IF mCLICK2 THEN GOTO invokecontextualmenu ELSE GOTO ideloop
                END IF
            END IF

            GOTO specialchar
        END IF

        IF IdeSystem = 3 THEN

            IF mCLICK OR K$ = CHR$(27) THEN
                IF (mY = idewy AND mX = idewx - 2) OR K$ = CHR$(27) THEN 'close help


                    'IF idesubwindow THEN PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt: GOTO ideloop
                    'idesubwindow = idewy \ 2: idewy = idewy - idesubwindow
                    closeHelp:
                    idewy = idewy + idesubwindow
                    idehelp = 0
                    idesubwindow = 0
                    skipdisplay = 0
                    IdeSystem = 1
                    retval = 1: GOSUB redrawItAll

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
                selectAllInHelp:
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
                copyhelp2clip:
                ideerror = -1 'if it fails, just carry on
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
                ideerror = 1
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
            IdeContextHelpSF = 0
            'identify word or character at current cursor position
            a$ = idegetline(idecy)
            x = idecx
            IF LEN(a$) > 0 AND x = LEN(a$) + 1 THEN x = x - 1
            IF x <= LEN(a$) THEN
                IF (MID$(a$, x, 1) = " " OR MID$(a$, x, 1) = "(") AND x > 1 THEN x = x - 1
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
                    IF a2$ = UCASE$(l1$) OR (qb64prefix_set = 1 AND LEFT$(l1$, 1) = "_" AND a2$ = MID$(l1$, 2)) THEN
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
                        IF lnk$ = "C" THEN GOTO ideloop
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
                        retval = 1
                    END IF

                    WikiParse a$
                    IdeSystem = 3 'Standard qb45 behaviour. Allows for quick peek at help then ESC.
                    GOSUB redrawitall
                    GOTO specialchar

                ELSE
                    'No help found; Does the user want help for a SUB or FUNCTION?
                    a2$ = LTRIM$(RTRIM$(a2$))
                    IF LEN(a2$) THEN
                        DO UNTIL alphanumeric(ASC(RIGHT$(a2$, 1)))
                            a2$ = LEFT$(a2$, LEN(a2$) - 1) 'removes sigil, if any
                            IF LEN(a2$) = 0 THEN GOTO NoKeywordFound
                        LOOP

                        FOR y = 1 TO iden
                            a$ = idegetline(y)
                            a$ = LTRIM$(RTRIM$(a$))
                            sf = 0
                            nca$ = UCASE$(a$)
                            IF LEFT$(nca$, 4) = "SUB " THEN sf = 1: sf$ = "SUB "
                            IF LEFT$(nca$, 9) = "FUNCTION " THEN sf = 2: sf$ = "FUNCTION "
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
                                    args$ = RIGHT$(a$, LEN(a$) - x + 1)
                                ELSE
                                    n$ = a$
                                    args$ = ""
                                END IF

                                'attempt to cleanse n$, just in case there are any comments or other unwanted stuff
                                FOR CleanseN = 1 TO LEN(n$)
                                    SELECT CASE MID$(n$, CleanseN, 1)
                                        CASE " ", "'", ":"
                                            n$ = LEFT$(n$, CleanseN - 1)
                                            EXIT FOR
                                    END SELECT
                                NEXT

                                backupn$ = n$

                                DO UNTIL alphanumeric(ASC(RIGHT$(n$, 1)))
                                    n$ = LEFT$(n$, LEN(n$) - 1) 'removes sigil, if any
                                LOOP

                                IF UCASE$(n$) = a2$ THEN
                                    a$ = "'''" + backupn$ + "''' is a symbol that is used in your program as follows:"
                                    a$ = a$ + CHR$(10) + CHR$(10) + "{{PageSyntax}}" + CHR$(10)
                                    a$ = a$ + ": " + sf$ + "'''" + backupn$ + "''' " + args$
                                    a$ = a$ + CHR$(10) + "{{PageNavigation}}"

                                    IdeContextHelpSF = -1

                                    IF idehelp = 0 THEN
                                        IF idesubwindow THEN PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt: GOTO ideloop
                                        idesubwindow = idewy \ 2: idewy = idewy - idesubwindow
                                        Help_wx1 = 2: Help_wy1 = idewy + 1: Help_wx2 = idewx - 1: Help_wy2 = idewy + idesubwindow - 2: Help_ww = Help_wx2 - Help_wx1 + 1: Help_wh = Help_wy2 - Help_wy1 + 1
                                        WikiParse a$
                                        idehelp = 1
                                        skipdisplay = 0
                                        IdeSystem = 3 'Standard qb45 behaviour. Allows for quick peek at help then ESC.
                                        retval = 1
                                    END IF

                                    WikiParse a$
                                    IdeSystem = 3 'Standard qb45 behaviour. Allows for quick peek at help then ESC.
                                    GOTO specialchar

                                    EXIT FOR
                                END IF
                            END IF
                        NEXT
                    END IF
                    NoKeywordFound:
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
                result = idemessagebox("Bookmarks", "No bookmarks exist (Use Alt+Left to create a bookmark)", "")
                SCREEN , , 3, 0: idewait4mous: idewait4alt
                idealthighlight = 0
                LOCATE , , 0: COLOR 0, 7: LOCATE 1, 1: PRINT menubar$;
                GOTO specialchar
            END IF
            IF IdeBmkN = 1 THEN
                IF idecy = IdeBmk(1).y THEN
                    result = idemessagebox("Bookmarks", "No other bookmarks exist", "")
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

        IF ideselect = 1 AND wholeword.select < 0 AND mY = old.mY THEN
            'Mouse button has been held down since the last double-click word selection
            'and the user has moved the mouse only horizontally. Attempt to keep
            'selecting words to the left or right.
            IF wholeword.select = -2 THEN
                'we had a snap selection but moved up or down.
                'now we're back in the same line.
                wholeword.select = -1
                idemouseselect = 0
                ideselectx1 = wholeword.selectx1
                idecx = wholeword.idecx
                ideselecty1 = wholeword.selecty1
                idecy = wholeword.idecy
            END IF
            newposition = (mX - 1 + idesx - 1) - maxLineNumberLength
            a$ = idegetline$(idecy)
            IF newposition > LEN(a$) THEN idecx = newposition: GOTO DoneWholeWord
            IF newposition = 1 THEN ideselectx1 = 1: GOTO DoneWholeWord
            char.clicked$ = MID$(a$, newposition, 1)
            IF LEN(char.clicked$) > 0 THEN
                IF newposition < wholeword.idecx THEN
                    'To the left, to the left.
                    FOR i = newposition TO 1 STEP -1
                        IF INSTR(char.sep$, MID$(a$, i, 1)) THEN EXIT FOR
                    NEXT i
                    ideselectx1 = i + 1
                ELSEIF newposition > wholeword.selectx1 THEN
                    'To the right.
                    FOR i = newposition TO LEN(a$)
                        IF INSTR(char.sep$, MID$(a$, i, 1)) THEN EXIT FOR
                    NEXT i
                    idecx = i
                END IF
            END IF
        ELSEIF ideselect = 1 AND wholeword.select = -1 AND mY <> old.mY THEN
            idemouseselect = 1
            wholeword.select = -2
        END IF

        IF mCLICK THEN
            IF mX > 1 + maxLineNumberLength AND mX < idewx AND mY > 2 AND mY < (idewy - 5) THEN 'inside text box
                IF old.mX = mX AND old.mY = mY THEN
                    IF timeElapsedSince(last.TBclick#) > .5 THEN GOTO regularTextBox_click
                    'Double-click on text box: attempt to select "word" clicked
                    idecx = (mX - 1 + idesx - 1) - maxLineNumberLength
                    idecy = mY - 2 + idesy - 1
                    IF idecy > iden THEN
                        GOTO regularTextBox_click
                    ELSEIF ActiveINCLUDELink > 0 THEN
                        'Double-click on an $INCLUDE statement launches that file in
                        'a separate instance of QB64:
                        p$ = idepath$ + pathsep$
                        f$ = p$ + ActiveINCLUDELinkFile
                        IF _FILEEXISTS(f$) THEN
                            backupIncludeFile = FREEFILE
                            OPEN f$ FOR BINARY AS #backupIncludeFile
                            tempInclude1$ = SPACE$(LOF(backupIncludeFile))
                            CLOSE #backupIncludeFile

                            WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_AutoPosition", "FALSE"
                            WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_Width", "80"
                            WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_Height", "25"

                            SCREEN , , 3, 0
                            COLOR 7, 1: LOCATE idewy - 3, 2: PRINT SPACE$(idewx - 2);: LOCATE idewy - 2, 2: PRINT SPACE$(idewx - 2);: LOCATE idewy - 1, 2: PRINT SPACE$(idewx - 2); 'clear status window
                            LOCATE idewy - 3, 2
                            COLOR 15, 1
                            PRINT "Editing $INCLUDE file..."
                            dummy = DarkenFGBG(1)
                            PCOPY 3, 0

                            _DELAY .2
                            p$ = QuotedFilename$(COMMAND$(0)) + " " + QuotedFilename$(f$)
                            IF errorLineInInclude > 0 AND idefocusline = idecy THEN
                                p$ = p$ + " -l:" + str2$(errorLineInInclude)
                            ELSEIF warningInIncludeLine > 0 AND warningInInclude = idecy THEN
                                p$ = p$ + " -l:" + str2$(warningInIncludeLine)
                            END IF
                            SHELL p$

                            IF IDE_AutoPosition THEN
                                WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_AutoPosition", "TRUE"
                            END IF
                            WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_Width", STR$(idewx)
                            WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_Height", STR$(idewy)

                            OPEN f$ FOR BINARY AS #backupIncludeFile
                            tempInclude2$ = SPACE$(LOF(backupIncludeFile))
                            CLOSE #backupIncludeFile

                            dummy = DarkenFGBG(0)
                            COLOR 7, 1: LOCATE idewy - 3, 2: PRINT SPACE$(idewx - 2);: LOCATE idewy - 2, 2: PRINT SPACE$(idewx - 2);: LOCATE idewy - 1, 2: PRINT SPACE$(idewx - 2); 'clear status window

                            IF tempInclude1$ = tempInclude2$ THEN
                                IF IDEShowErrorsImmediately THEN
                                    LOCATE idewy - 3, 2
                                    IF idecompiling = 1 THEN
                                        PRINT "...";
                                    ELSE
                                        PRINT "OK"; 'report OK status
                                        statusarealink = 0
                                        IF totalWarnings > 0 THEN
                                            COLOR 11, 1
                                            PRINT " ("; LTRIM$(STR$(totalWarnings)) + " warning";
                                            IF totalWarnings > 1 THEN PRINT "s";
                                            PRINT " - click here or Ctrl+W to view)";
                                            statusarealink = 4
                                        END IF
                                    END IF
                                END IF
                            ELSE
                                idechangemade = 1
                            END IF

                            PCOPY 3, 0

                            tempInclude1$ = ""
                            tempInclude2$ = ""
                        END IF
                    ELSE
                        a$ = idegetline$(idecy)
                        IF LEN(a$) = 0 THEN GOTO regularTextBox_click
                        char.clicked$ = MID$(a$, idecx, 1)
                        ideselect = 1
                        ideselecty1 = idecy
                        IF LEN(char.clicked$) > 0 AND char.clicked$ <> CHR$(32) THEN
                            FOR i = idecx TO 1 STEP -1
                                IF INSTR(char.sep$, MID$(a$, i, 1)) THEN EXIT FOR
                            NEXT i
                            ideselectx1 = i + 1
                            wholeword.selectx1 = ideselectx1
                            FOR i = idecx TO LEN(a$)
                                IF INSTR(char.sep$, MID$(a$, i, 1)) THEN EXIT FOR
                            NEXT i
                            idecx = i
                            wholeword.idecx = idecx
                            wholeword.select = -1
                            wholeword.idecy = idecy
                            wholeword.selecty1 = ideselecty1
                        END IF
                    END IF
                ELSE
                    regularTextBox_click:
                    old.mX = mX: old.mY = mY: last.TBclick# = TIMER
                    ideselect = 1
                    idecx = (mX - 1 + idesx - 1) - maxLineNumberLength
                    idecy = mY - 2 + idesy - 1
                    IF idecy > iden THEN idecy = iden
                    ideselect = 1
                    IF (NOT KSHIFT) THEN ideselectx1 = idecx: ideselecty1 = idecy
                    idemouseselect = 1
                    wholeword.select = 0
                END IF
            ELSEIF mX > 1 AND mX <= 1 + maxLineNumberLength AND mY > 2 AND mY < (idewy - 5) AND ShowLineNumbers THEN
                'line numbers are visible and been clicked
                ideselect = 1
                idecy = mY - 2 + idesy - 1
                IF idecy < iden THEN
                    IF (NOT KSHIFT) THEN ideselectx1 = 1: ideselecty1 = idecy
                    idecy = idecy + 1
                    idecx = 1
                ELSEIF idecy = iden THEN
                    a$ = idegetline$(idecy)
                    IF (NOT KSHIFT) THEN ideselectx1 = 1: ideselecty1 = idecy
                    idecx = LEN(a$) + 1
                ELSEIF idecy > iden THEN
                    idecy = iden
                    ideselect = 0
                    idecx = 1
                END IF
                wholeword.select = 0
                idemouseselect = 0
            END IF
        END IF

        DoneWholeWord:

        IF mCLICK2 THEN 'Second mouse button pressed.
            invokecontextualmenu:
            IF mX > 1 + maxLineNumberLength AND mX < idewx AND mY > 2 AND mY < (idewy - 5) THEN 'inside text box
                IdeSystem = 1
                IF ideselect = 0 THEN 'Right click only positions the cursor if no selection is active
                    idecx = (mX - 1 + idesx - 1) - maxLineNumberLength
                    idecy = mY - 2 + idesy - 1
                    IF idecy > iden THEN idecy = iden
                ELSE 'A selection is reported but it may be that the user only clicked the screen. Let's check:
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
                            idecx = (mX - 1 + idesx - 1) - maxLineNumberLength
                            idecy = mY - 2 + idesy - 1
                            IF idecy > iden THEN idecy = iden
                        ELSE
                            'Ok, there is a selection. But we'll override it if the click was outside it
                            IF (mX - 1 + idesx - 1) - maxLineNumberLength < sx1 OR (mX - 1 + idesx - 1) - maxLineNumberLength > sx2 THEN
                                ideselect = 0
                                idecx = (mX - 1 + idesx - 1) - maxLineNumberLength
                                idecy = mY - 2 + idesy - 1
                                IF idecy > iden THEN idecy = iden
                            END IF
                            IF mY - 2 + idesy - 1 < idecy OR mY - 2 + idesy - 1 > idecy THEN
                                ideselect = 0
                                idecx = (mX - 1 + idesx - 1) - maxLineNumberLength
                                idecy = mY - 2 + idesy - 1
                                IF idecy > iden THEN idecy = iden
                            END IF
                        END IF
                    ELSE 'Multiple lines selected
                        'We'll override the selection if the click was outside it
                        sy1 = ideselecty1
                        sy2 = idecy
                        IF sy1 > sy2 THEN SWAP sy1, sy2
                        IF mY - 2 + idesy - 1 < sy1 OR mY - 2 + idesy - 1 > sy2 THEN
                            ideselect = 0
                            idecx = (mX - 1 + idesx - 1) - maxLineNumberLength
                            idecy = mY - 2 + idesy - 1
                            IF idecy > iden THEN idecy = iden
                        END IF
                    END IF
                END IF
                GOSUB redrawitall
                PCOPY 3, 0
                idecontextualmenu = 1
                IdeMakeContextualMenu
                GOTO showmenu
            ELSEIF idehelp = 1 AND mY >= idewy AND mY < idewy + idesubwindow THEN 'inside help area
                IdeSystem = 3
                GOSUB redrawitall
                PCOPY 3, 0
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
            IF mX > 1 + maxLineNumberLength AND mX < idewx AND mY > 2 AND mY < idewy - 5 THEN 'inside text box
                IF idemouseselect = 1 THEN
                    idecx = (mX - 1 + idesx - 1) - maxLineNumberLength
                    IF idecx < 1 THEN idecx = 1
                    idecy = mY - 2 + idesy - 1
                    IF idecy > iden THEN idecy = iden
                END IF
            END IF
        END IF

        IF mB THEN
            IF ((mX = 1 AND ShowLineNumbers = 0) OR (mX <= 1 + maxLineNumberLength AND ShowLineNumbers)) OR mX = idewx OR mY <= 2 OR mY >= idewy - 5 THEN 'off text window area
                IF idemouseselect = 1 THEN

                    'scroll window
                    IF mY >= idewy - 5 THEN idecy = idecy + 1: IF idecy > iden THEN idecy = iden
                    IF mY <= 2 THEN idecy = idecy - 1: IF idecy < 1 THEN idecy = 1
                    IF ((mX = 1 AND ShowLineNumbers = 0) OR (mX <= 1 + maxLineNumberLength AND ShowLineNumbers)) THEN idecx = idecx - 1: IF idecx < 1 THEN idecx = 1
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

        IF KCONTROL AND UCASE$(K$) = "G" THEN 'goto line
            IF KSHIFT AND idefocusline > 0 THEN
                idecx = 1
                AddQuickNavHistory idecy
                idecy = idefocusline
                ideselect = 0
            ELSE
                idegotobox
                'retval is ignored
                PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
            END IF
            GOTO specialchar
        END IF

        IF KCONTROL AND UCASE$(K$) = "N" THEN 'File -> #New
            GOTO ctrlNew
        END IF

        IF KCONTROL AND UCASE$(K$) = "O" THEN 'File -> #Open
            IdeOpenFile$ = ""
            GOTO ctrlOpen
        END IF

        IF (NOT KSHIFT) AND KCONTROL AND UCASE$(K$) = "R" THEN 'Comment (add ') - R for REMark
            GOTO ctrlAddComment
        END IF

        IF (NOT KSHIFT) AND KCONTROL AND UCASE$(K$) = "T" THEN 'Toggle comment
            GOTO ctrlToggleComment
        END IF

        IF KSHIFT AND KCONTROL AND UCASE$(K$) = "R" THEN 'uncomment (remove ')
            GOTO ctrlRemoveComment
        END IF

        IF KCONTROL AND UCASE$(K$) = "S" THEN 'File -> #Save
            IF ideprogname = "" THEN
                ProposedTitle$ = FindProposedTitle$
                IF ProposedTitle$ = "" THEN
                    a$ = idefiledialog$("untitled" + tempfolderindexstr$ + ".bas", 2)
                ELSE
                    a$ = idefiledialog$(ProposedTitle$ + ".bas", 2)
                END IF
            ELSE
                idesave idepath$ + idepathsep$ + ideprogname$
            END IF
            PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt: GOTO ideloop
        END IF

        IF K$ = CHR$(0) + CHR$(60) THEN 'F2
            IF KCONTROL THEN
                IF QuickNavTotal > 0 THEN
                    ideselect = 0
                    idecy = QuickNavHistory(QuickNavTotal)
                    QuickNavTotal = QuickNavTotal - 1
                    _DELAY .2
                    GOTO waitforinput
                END IF
            ELSE
                GOTO idesubsjmp
            END IF
        END IF

        IF KCONTROL AND UCASE$(K$) = "W" THEN 'goto line
            IF totalWarnings > 0 THEN
                retval = idewarningbox
                'retval is ignored
                PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                GOTO specialchar
            ELSE
                result = idemessagebox("Compilation status", "No warnings to display.", "")
                PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                GOTO ideloop
            END IF
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
                        _TITLE WindowTitle
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

                    IF PasteCursorAtEnd THEN
                        'Place the cursor at the end of the pasted content:
                        idecy = idecy + i - 1
                        idecx = LEN(idegetline(idecy)) + 1
                        IF RIGHT$(clip$, 1) = CHR$(10) THEN
                            idecy = idecy + 1
                            idecx = 1
                        END IF
                    END IF
                ELSE

                    'insert single line paste
                    a$ = idegetline(idecy)
                    IF LEN(a$) < idecx - 1 THEN a$ = a$ + SPACE$(idecx - 1 - LEN(a$))
                    a$ = LEFT$(a$, idecx - 1) + clip$ + RIGHT$(a$, LEN(a$) - idecx + 1)
                    idesetline idecy, converttabs$(a$)

                    IF PasteCursorAtEnd THEN
                        'Place the cursor at the end of the pasted content:
                        idecx = idecx + LEN(clip$)
                    END IF
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
                        IF idecx = 1 AND y = sy2 AND idecy > sy1 THEN GOTO nofinalcopy
                        clip$ = clip$ + a$ + CHR$(13) + CHR$(10)
                        nofinalcopy:
                        IF y = sy2 AND idecx > 1 AND LEN(a$) > 0 THEN clip$ = LEFT$(clip$, LEN(clip$) - 2)
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
                IF idesy < 1 THEN idesy = 1
                IF idecy > idesy + (idewy - 9) THEN idecy = idesy + (idewy - 9)
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
                IF idesy > iden THEN idesy = iden
                IF idecy < idesy THEN idecy = idesy
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
                            idecx = LEN(a$) + 1
                        LOOP UNTIL LEN(a$)
                        GOTO specialchar 'stop at the end of the previous line
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
                    IF first = 0 AND idecx = LEN(a$) + 1 THEN GOTO specialchar 'stop at the end of the line
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
            IF KSHIFT THEN
                retval$ = ""
                IF EnteringRGB THEN 'The "Hit Shift+ENTER" message is being shown
                    oldkeywordHighlight = keywordHighlight
                    keywordHighlight = 0
                    HideBracketHighlight
                    keywordHighlight = oldkeywordHighlight
                    retval$ = idergbmixer$(0)
                ELSE
                    IF ideselect THEN
                        IF ideselecty1 <> idecy THEN GOTO specialchar 'multi line selected
                    END IF

                    a$ = idegetline(idecy)
                    Found_RGB = 0
                    Found_RGB = Found_RGB + INSTR(UCASE$(a$), "RGB(")
                    Found_RGB = Found_RGB + INSTR(UCASE$(a$), "RGB32(")
                    Found_RGB = Found_RGB + INSTR(UCASE$(a$), "RGBA(")
                    Found_RGB = Found_RGB + INSTR(UCASE$(a$), "RGBA32(")
                    IF Found_RGB THEN
                        oldkeywordHighlight = keywordHighlight
                        keywordHighlight = 0
                        HideBracketHighlight
                        keywordHighlight = oldkeywordHighlight
                        retval$ = idergbmixer$(-1)
                    END IF
                END IF
                IF LEN(retval$) THEN
                    tempk$ = retval$

                    'insert
                    IF ideselect THEN GOSUB delselect
                    a$ = idegetline(idecy)
                    IF LEN(a$) < idecx - 1 THEN a$ = a$ + SPACE$(idecx - 1 - LEN(a$))
                    a$ = LEFT$(a$, idecx - 1) + tempk$ + RIGHT$(a$, LEN(a$) - idecx + 1)
                    idesetline idecy, a$

                    IF PasteCursorAtEnd THEN
                        'Place the cursor at the end of the inserted content:
                        idecx = idecx + LEN(tempk$)
                    END IF

                    idechangemade = 1
                END IF
                GOTO specialchar
            ELSE
                ideselect = 0
                desiredcolumn = 1
                idechangemade = 1

                a$ = idegetline(idecy)
                IF idecx > LEN(a$) THEN
                    ideinsline idecy + 1, ""
                    IF LEN(a$) = 0 THEN
                        desiredcolumn = idecx
                    ELSE
                        desiredcolumn = LEN(a$) - LEN(LTRIM$(a$)) + 1
                    END IF
                ELSE
                    a2$ = LEFT$(a$, idecx - 1)
                    idesetline idecy, a2$
                    IF LEN(LTRIM$(a2$)) > 0 THEN
                        IF idecx > 1 THEN desiredcolumn = LEN(a$) - LEN(LTRIM$(a$)) ELSE desiredcolumn = 0
                        ideinsline idecy + 1, SPACE$(desiredcolumn) + RIGHT$(a$, LEN(a$) - idecx + 1)
                        IF desiredcolumn = 0 THEN desiredcolumn = 1 ELSE desiredcolumn = desiredcolumn + 1
                    ELSE
                        desiredcolumn = idecx
                        ideinsline idecy + 1, SPACE$(desiredcolumn - 1) + RIGHT$(a$, LEN(a$) - idecx + 1)
                    END IF
                END IF

                IF idecx = 1 THEN
                    FOR b = 1 TO IdeBmkN
                        IF IdeBmk(b).y = idecy THEN IdeBmk(b).y = IdeBmk(b).y + 1
                    NEXT
                END IF

                idecy = idecy + 1
                idecx = desiredcolumn
                GOTO specialchar
            END IF
        END IF

        IF KB = KEY_DELETE AND KCONTROL = 0 THEN
            idechangemade = 1
            a$ = idegetline(idecy)
            IF idecx <= LEN(a$) THEN
                a$ = LEFT$(a$, idecx - 1) + RIGHT$(a$, LEN(a$) - idecx)
                idesetline idecy, a$
            ELSE
                a$ = a$ + SPACE$(idecx - LEN(a$) - 1)
                a$ = a$ + LTRIM$(idegetline(idecy + 1))
                idesetline idecy, a$
                idedelline idecy + 1
            END IF
            GOTO specialchar
        END IF

        'Ctrl+Backspace erases a word at a time
        'In Windows it's currently reported as Control+Delete;
        'In Mac it's properly delivered as Control+Backspace.
        'Key combo not yet supported in Linux.
        IF (INSTR(_OS$, "WIN") > 0 AND KCONTROL AND K$ = CHR$(0) + CHR$(83)) OR _
            (INSTR(_OS$, "MAC") > 0 AND K$ = CHR$(8) AND KCONTROL) THEN
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

            'Attempt to go back erasing a "word" at a time
            a$ = idegetline(idecy)
            IF idecx = 1 THEN GOTO RegularBackspaceIdecx1
            IF idecx > LEN(a$) + 2 THEN
                idecx = LEN(a$) + 1
                GOTO specialchar
            ELSEIF idecx = LEN(a$) + 2 THEN
                idecx = LEN(a$) + 1
            END IF

            IF LEN(RTRIM$(MID$(a$, 1, idecx - 1))) = 0 THEN
                'Erase all spaces behind at once if no text before the cursor
                a$ = MID$(a$, idecx)
                idesetline idecy, a$
                idecx = 1
                GOTO specialchar
            END IF

            'Go back in a$ and find the first non blank char
            i = idecx
            DO
                i = i - 1
                FirstChar$ = MID$(a$, i, 1)
                IF FirstChar$ <> CHR$(32) THEN EXIT DO
            LOOP
            IF INSTR(char.sep$, FirstChar$) THEN
                DO
                    IF i = 0 THEN EXIT DO
                    IF MID$(a$, i, 1) <> FirstChar$ THEN EXIT DO
                    i = i - 1
                LOOP
            ELSE
                DO
                    IF i = 0 THEN EXIT DO
                    i = i - 1
                    IF INSTR(char.sep$, MID$(a$, i, 1)) THEN EXIT DO
                LOOP
            END IF
            a$ = LEFT$(a$, i) + MID$(a$, idecx)
            idecx = i + 1
            idesetline idecy, a$
            GOTO specialchar
        END IF

        IF K$ = CHR$(8) THEN 'Regular Backspace
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
                RegularBackspaceIdecx1:
                IF idecy > 1 THEN
                    a2$ = idegetline(idecy - 1)
                    IF LEN(a2$) > 0 THEN
                        'If the previous line has any content, let's just append this line to it
                        RegularBackupToPrevLine:
                        idesetline idecy - 1, a2$ + a$
                        idedelline idecy
                        idecx = LEN(a2$) + 1
                        idecy = idecy - 1
                    ELSE
                        'Or else, if it's an empty line, let's try to follow the
                        'next line's indentation.
                        'First, get indentation level of next line, if any.
                        IF idecy < iden THEN
                            a3$ = idegetline(idecy + 1)
                            desiredcolumn = LEN(a3$) - LEN(LTRIM$(a3$))
                            idesetline idecy - 1, SPACE$(desiredcolumn) + a$
                            idedelline idecy
                            idecx = desiredcolumn + 1
                            idecy = idecy - 1
                        ELSE
                            GOTO RegularBackupToPrevLine
                        END IF
                    END IF
                END IF
                GOTO specialchar
            END IF
            IF idecx > LEN(a$) + 1 THEN
                idecx = LEN(a$) + 1
            ELSE
                CheckSpacesBehind:
                IF LEN(RTRIM$(MID$(a$, 1, idecx - 1))) = 0 THEN
                    'Only spaces behind. If we're on a tab stop, let's go back in tabs.
                    x = 4
                    IF ideautoindentsize <> 0 THEN x = ideautoindentsize
                    check.tabstop! = (idecx - 1) / x
                    IF check.tabstop! = FIX(check.tabstop!) THEN
                        IF idecx - x < 1 THEN x = idecx - 1
                        a$ = LEFT$(a$, idecx - (x + 1)) + RIGHT$(a$, LEN(a$) - idecx + 1)
                        idesetline idecy, a$
                        idecx = idecx - x
                    ELSE
                        GOTO onebackspace
                    END IF
                ELSE
                    onebackspace:
                    a$ = LEFT$(a$, idecx - 2) + RIGHT$(a$, LEN(a$) - idecx + 1)
                    idesetline idecy, a$
                    idecx = idecx - 1
                END IF
            END IF
            GOTO specialchar
        END IF









        'patch#1
        IF LEN(K$) <> 1 THEN GOTO specialchar
        IF K$ = CHR$(9) THEN GOTO ideforceinput
        IF block_chr(ASC(K$)) THEN GOTO specialchar
        ideforceinput:

        IF K$ = CHR$(9) OR (K$ = CHR$(25) AND INSTR(_OS$, "MAC") > 0) THEN
            IF ideselect THEN
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
                        IF lhs < BlockIndentLevel THEN BlockIndentLevel = lhs
                        FOR y = y1 TO y2
                            a$ = idegetline(y)
                            IF LEN(a$) THEN
                                a$ = RIGHT$(a$, LEN(a$) - BlockIndentLevel)
                                idesetline y, a$
                                idechangemade = 1
                            END IF
                        NEXT
                    END IF
                    IF (y1 = y2) AND idechangemade THEN
                        ideselectx1 = ideselectx1 - BlockIndentLevel
                        idecx = idecx - BlockIndentLevel
                        IF idecx < 1 THEN idecx = 1: ideselectx1 = idecx
                    END IF
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
                    IF (y1 = y2) AND idechangemade THEN
                        ideselectx1 = ideselectx1 + BlockIndentLevel
                        idecx = idecx + BlockIndentLevel
                    END IF
                    PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                    GOTO ideloop
                END IF
            ELSE
                SkipBlockIndent:
                IF KSHIFT = 0 THEN
                    x = 4
                    IF ideautoindentsize <> 0 THEN x = ideautoindentsize
                    K$ = SPACE$(x - ((idecx - 1) MOD x))
                ELSE
                    K$ = ""
                END IF
            END IF
        END IF

        IF K$ = CHR$(27) AND NOT AltSpecial THEN GOTO specialchar 'Steve edit 07-04-2014 to stop ESC from printing chr$(27) in the IDE

        'alt and ctrl combos have already been processed, so skip inserting
        'K$ if these are still held down:
        IF KCTRL AND NOT KALT THEN GOTO specialchar
        IF KALT AND NOT KCTRL AND NOT AltSpecial THEN GOTO specialchar

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
        'In case there is a selection, let's show the number of
        'selected characters on the status bar:
        IF (IdeInfo = "" OR LEFT$(IdeInfo, 19) = "Selection length = ") THEN
            IF idecy = ideselecty1 THEN 'selection is in only one line
                sx1 = ideselectx1: sx2 = idecx
                IF sx1 > sx2 THEN SWAP sx1, sx2
                IF ideselect = 1 AND (sx2 - sx1) > 0 THEN
                    IF sx2 - sx1 > 0 THEN
                        a$ = idegetline(idecy)
                        ideCurrentSingleLineSelection = MID$(a$, sx1, sx2 - sx1)
                        FOR i = 1 TO LEN(ideCurrentSingleLineSelection)
                            IF INSTR(char.sep$, MID$(ideCurrentSingleLineSelection, i, 1)) > 0 THEN
                                'separators in selection don't trigger multi-highlight
                                IF MID$(ideCurrentSingleLineSelection, i, 1) <> "." THEN
                                    ideCurrentSingleLineSelection = ""
                                    EXIT FOR
                                END IF
                            END IF
                        NEXT i
                    END IF
                    IdeInfo = "Selection length = " + str2$(sx2 - sx1) + " character" + LEFT$("s", ABS(sx2 - sx1 > 1))
                    UpdateIdeInfo
                ELSE
                    IdeInfo = ""
                    ideCurrentSingleLineSelection = ""
                    UpdateIdeInfo
                END IF
            ELSE
                IF ideselect THEN
                    sy1 = ideselecty1
                    sy2 = idecy
                    IF sy1 > sy2 OR idecx > 1 THEN
                        IdeInfo = "Selection length = " + str2$(ABS(sy2 - sy1) + 1) + " line" + LEFT$("s", ABS((ABS(sy2 - sy1) + 1) > 1))
                    ELSE
                        IdeInfo = "Selection length = " + str2$(sy2 - sy1) + " line" + LEFT$("s", ABS(sy2 - sy1 > 1))
                    END IF
                ELSE
                    IdeInfo = ""
                END IF
                ideCurrentSingleLineSelection = ""
                UpdateIdeInfo
            END IF
        END IF

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
    oldmx = mX: oldmy = mY
    startmenu2:
    altheld = 1
    IF IdeSystem = 2 THEN IdeSystem = 1: GOSUB UpdateSearchBar

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
            IF oldmx <> mX OR oldmy <> mY THEN
                IF mY = 1 AND idecontextualmenu <> 1 THEN 'Check if we're hovering on menu bar
                    lastm = m
                    FOR i = 1 TO menus
                        x = CVI(MID$(MenuLocations, i * 2 - 1, 2))
                        x2 = CVI(MID$(MenuLocations, i * 2 - 1, 2)) + LEN(menu$(i, 0))
                        IF mX >= x AND mX < x2 THEN
                            m = i
                            IF m <> lastm THEN EXIT DO 'Update the menu bar to reflect the current mouse hover
                        END IF
                    NEXT
                END IF
                oldmx = mX: oldmy = mY
            END IF
            IF iCHANGED = 0 THEN _LIMIT 100

            IF KALT THEN altheld = 1 ELSE altheld = 0

            IF altheld <> 0 AND lastaltheld = 0 THEN
                DO
                    _LIMIT 1000
                    GetInput
                    IF _WINDOWHASFOCUS = 0 AND (os$ = "WIN" OR MacOSX = 1) THEN
                        LOCATE 1, 1: COLOR 0, 7: PRINT menubar$;
                        SCREEN , , 3, 0: PCOPY 3, 0
                        GOTO ideloop
                    END IF

                    IF _RESIZE THEN
                        ForceResize = -1: skipdisplay = 0: GOTO ideloop
                    END IF
                LOOP UNTIL KALT = 0
                KB = KEY_ESC
            END IF

            IF _WINDOWHASFOCUS = 0 AND (os$ = "WIN" OR MacOSX = 1) THEN
                LOCATE 1, 1: COLOR 0, 7: PRINT menubar$;
                SCREEN , , 3, 0: PCOPY 3, 0
                GOTO ideloop
            END IF

            IF _RESIZE THEN
                ForceResize = -1: skipdisplay = 0: GOTO ideloop
            END IF

            IF mCLICK OR mCLICK2 THEN
                IF mY = 1 THEN
                    FOR i = 1 TO menus
                        x = CVI(MID$(MenuLocations, i * 2 - 1, 2))
                        x2 = CVI(MID$(MenuLocations, i * 2 - 1, 2)) + LEN(menu$(i, 0))
                        IF mX >= x AND mX < x2 THEN
                            m = i
                            LOCATE 1, 1: COLOR 0, 7: PRINT menubar$;
                            PCOPY 3, 0
                            GOTO showmenu
                        END IF
                    NEXT
                END IF 'my=1
                KB = KEY_ESC 'exit menu selection
            END IF

            IF _EXIT THEN ideexit = 1: KB = KEY_ESC
        LOOP UNTIL KB

        K$ = UCASE$(K$)
        IF LEN(K$) > 0 AND KCTRL THEN
            'ctrl+key combos are not valid while a menu is active
            LOCATE 1, 1: COLOR 0, 7: PRINT menubar$;
            SCREEN , , 3, 0: PCOPY 3, 0
            GOTO ideloop
        END IF

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
        IF m > menus AND idecontextualmenu = 0 THEN m = 1
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
    IF IdeSystem = 2 THEN IdeSystem = 1: GOSUB UpdateSearchBar
    PCOPY 0, 2
    SCREEN , , 1, 0
    parentMenuR = r
    r = 1
    s = 0
    parentMenu = 0
    parentMenuSetup%% = 0
    SELECT CASE idecontextualmenu
        CASE 1
            'right-click on text area
            idectxmenuX = mX
            idectxmenuY = mY
            m = idecontextualmenuID
        CASE 2
            'line numbers menu item in View menu
            idectxmenuX = xx + w + 3
            idectxmenuY = yy + r
            parentMenu = m
            m = ViewMenuShowLineNumbersSubMenuID
    END SELECT

    IdeMakeEditMenu

    IF totalWarnings = 0 THEN
        menu$(ViewMenuID, ViewMenuCompilerWarnings) = "~Compiler #Warnings...  Ctrl+W"
    ELSE
        menu$(ViewMenuID, ViewMenuCompilerWarnings) = "Compiler #Warnings...  Ctrl+W"
    END IF

    oldmy = mY: oldmx = mX
    DO
        PCOPY 2, 1

        IF idecontextualmenu = 0 THEN
            'find pos of menu m
            x = 4: FOR i = 1 TO m - 1: x = x + LEN(menu$(i, 0)) + 2
                IF i = menus - 1 THEN x = idewx - LEN(menu$(menus, 0)) - 1
            NEXT: xx = x
            LOCATE 1, xx - 1: COLOR 7, 0: PRINT " " + menu$(m, 0) + " "
        ELSE
            IF parentMenu > 0 AND parentMenuSetup%% = 0 THEN
                parentMenuSetup%% = -1
                backToParent.x1 = xx - 1
                backToParent.x2 = xx + w
                backToParent.y1 = 3
                backToParent.y2 = backToParent.y1 + menusize(parentMenu)
            END IF
        END IF
        COLOR 0, 7
        'calculate menu width
        w = 0
        FOR i = 1 TO menusize(m)
            m$ = menu$(m, i)
            l = LEN(m$)
            IF INSTR(m$, "#") THEN l = l - 1
            IF LEFT$(m$, 1) = "~" THEN l = l - 1
            IF LEFT$(m$, 1) = CHR$(7) THEN l = l - 1
            IF INSTR(m$, "  ") THEN l = l + 2 'min 4 spacing
            IF l > w THEN w = l
        NEXT
        yy = 2
        IF idecontextualmenu > 0 THEN
            actual.idewy = idewy
            IF idesubwindow <> 0 THEN
                actual.idewy = idewy + idesubwindow
            END IF
            xx = idectxmenuX
            IF xx < 3 THEN xx = 3
            yy = idectxmenuY
            IF yy + menusize(m) + 2 > actual.idewy THEN yy = actual.idewy - 2 - menusize(m)
        END IF
        IF xx > idewx - w - 3 THEN xx = idewx - w - 3

        ideboxshadow xx - 2, yy, w + 4, menusize(m) + 2

        'draw menu items
        FOR i = 1 TO menusize(m)
            m$ = menu$(m, i)
            IF m$ = "-" THEN
                COLOR 0, 7: LOCATE i + yy, xx - 2: PRINT CHR$(195) + STRING$(w + 2, CHR$(196)) + CHR$(180);
            ELSEIF LEFT$(m$, 1) = "~" THEN
                m$ = RIGHT$(m$, LEN(m$) - 1) 'Remove the tilde before printing
                IF r = i THEN LOCATE i + yy, xx - 1: COLOR 7, 0: PRINT SPACE$(w + 2);
                IF LEFT$(m$, 1) = CHR$(7) THEN LOCATE i + yy, xx - 1 ELSE LOCATE i + yy, xx
                h = -1: x = INSTR(m$, "#"): IF x THEN h = x: m$ = LEFT$(m$, x - 1) + RIGHT$(m$, LEN(m$) - x)
                x = INSTR(m$, "  "): IF x THEN m1$ = LEFT$(m$, x - 1): m2$ = RIGHT$(m$, LEN(m$) - x - 1): m$ = m1$ + SPACE$(w - LEN(m1$) - LEN(m2$)) + m2$
                FOR x = 1 TO LEN(m$)
                    IF r = i THEN COLOR 2, 0 ELSE COLOR 2, 7
                    PRINT MID$(m$, x, 1);
                NEXT
            ELSE
                IF r = i THEN LOCATE i + yy, xx - 1: COLOR 7, 0: PRINT SPACE$(w + 2);
                IF LEFT$(m$, 1) = CHR$(7) THEN LOCATE i + yy, xx - 1 ELSE LOCATE i + yy, xx
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

        IF s THEN GOTO menuChoiceMade

        updateMenuPanel%% = 0
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
                DO
                    _LIMIT 1000
                    GetInput
                    IF _WINDOWHASFOCUS = 0 AND (os$ = "WIN" OR MacOSX = 1) THEN
                        LOCATE 1, 1: COLOR 0, 7: PRINT menubar$;
                        PCOPY 3, 0: SCREEN , , 3, 0
                        GOTO ideloop
                    END IF

                    IF _RESIZE THEN
                        ForceResize = -1: skipdisplay = 0: GOTO ideloop
                    END IF
                LOOP UNTIL KALT = 0 'wait till alt is released
                PCOPY 3, 0: SCREEN , , 3, 0
                GOTO startmenu2
            END IF
            IF _EXIT THEN ideexit = 1: GOTO ideloop
            IF _WINDOWHASFOCUS = 0 AND (os$ = "WIN" OR MacOSX = 1) THEN
                LOCATE 1, 1: COLOR 0, 7: PRINT menubar$;
                PCOPY 3, 0: SCREEN , , 3, 0
                GOTO ideloop
            END IF
            IF _RESIZE THEN
                ForceResize = -1: skipdisplay = 0: GOTO ideloop
            END IF
            _LIMIT 100
        LOOP UNTIL change

        s = 0

        IF mWHEEL THEN
            PCOPY 3, 0: SCREEN , , 3, 0
            GOTO ideloop
        END IF

        IF mCLICK2 AND idecontextualmenu = 1 THEN 'A new right click in the text area repositions the contextual menu
            IF (mX > 1 AND mX < idewx AND mY > 2 AND mY < (idewy - 5)) OR _
                (mY >= idewy AND mY < idewy + idesubwindow) THEN
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
                    IF menu$(m, y) <> "-" AND LEFT$(menu$(m, y), 1) <> "~" THEN
                        s = r
                    END IF
                END IF
            END IF

            IF parentMenu > 0 AND _
               mX >= backToParent.x1 AND mX =< backToParent.x2 AND _
               mY >= backToParent.y1 AND mY =< backToParent.y2 THEN
                m = parentMenu
                r = parentMenuR
                parentMenu = 0
                parentMenuR = 0
                idecontextualmenu = 0
                PCOPY 3, 2
                _CONTINUE
            END IF

            IF mX < xx - 2 OR mX >= xx - 2 + w + 4 OR mY > yy + menusize(m) + 1 OR (mY < yy AND idecontextualmenu = 1) THEN
                PCOPY 3, 0: SCREEN , , 3, 0
                GOTO ideloop
            END IF
        END IF

        IF NOT mouseup AND NOT mousedown THEN 'Check if we're hovering on menu options
            IF parentMenu > 0 AND oldmy <> mY AND oldmx <> mX AND _
               mX >= backToParent.x1 AND mX =< backToParent.x2 AND _
               mY >= backToParent.y1 AND mY =< backToParent.y2 THEN
                m = parentMenu
                r = parentMenuR
                parentMenu = 0
                parentMenuR = 0
                idecontextualmenu = 0
                PCOPY 3, 2
                _CONTINUE
            END IF
            IF oldmy <> mY THEN
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
            END IF
            IF oldmx <> mX THEN
                checkmenubarhover:
                IF mY = 1 AND idecontextualmenu <> 1 THEN 'Check if we're hovering on menu bar
                    lastm = m
                    FOR i = 1 TO menus
                        x = CVI(MID$(MenuLocations, i * 2 - 1, 2))
                        x2 = CVI(MID$(MenuLocations, i * 2 - 1, 2)) + LEN(menu$(i, 0))
                        IF mX >= x AND mX < x2 THEN
                            m = i
                            r = 1
                            parentMenuR = 0
                            parentMenu = 0
                            IF idecontextualmenu > 1 THEN idecontextualmenu = 0: PCOPY 3, 2
                            EXIT FOR
                        END IF
                    NEXT
                END IF
                oldmx = mX
            END IF
        END IF

        IF mB THEN

            'top row
            IF mY = 1 THEN
                lastm = m
                x = 3
                FOR i = 1 TO menus
                    x2 = LEN(menu$(i, 0)) + 2
                    IF mX >= x AND mX < x + x2 THEN
                        m = i
                        r = 1
                        IF lastm = m AND mousedown = 1 THEN PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: GOTO ideloop
                        idecontextualmenu = 0
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

        IF KB = KEY_LEFT AND idecontextualmenu = 0 THEN
            m = m - 1: r = 1
        ELSEIF KB = KEY_LEFT AND idecontextualmenu > 1 THEN
            idecontextualmenu = 0
            PCOPY 3, 2
            m = parentMenu
            r = parentMenuR
            parentMenu = 0
        END IF
        IF KB = KEY_RIGHT AND idecontextualmenu = 0 THEN
            IF RIGHT$(menu$(m, r), 1) = CHR$(16) THEN
                SELECT CASE LEFT$(menu$(m, r), LEN(menu$(m, r)) - 3)
                    CASE "#Line Numbers"
                        idecontextualmenu = 2
                        GOTO showmenu
                END SELECT
            ELSE
                m = m + 1: r = 1
            END IF
        ELSEIF KB = KEY_RIGHT AND idecontextualmenu > 1 THEN
            idecontextualmenu = 0
            PCOPY 3, 2
            m = parentMenu + 1
            r = 1
        END IF
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
            IF LEFT$(menu$(m, r), 1) <> "~" THEN s = r
        END IF

        'with hotkey
        K$ = UCASE$(K$)
        IF LEN(K$) > 0 AND NOT KCTRL THEN
            FOR r2 = 1 TO menusize(m)
                x = INSTR(menu$(m, r2), "#")
                IF x THEN
                    a$ = UCASE$(MID$(menu$(m, r2), x + 1, 1))
                    IF K$ = a$ AND LEFT$(menu$(m, r2), 1) <> "~" THEN
                        s = r2
                        updateMenuPanel%% = -1
                        EXIT FOR
                    ELSEIF K$ = a$ AND LEFT$(menu$(m, r2), 1) = "~" THEN
                        updateMenuPanel%% = -1
                        EXIT FOR
                    END IF
                END IF
            NEXT
            IF updateMenuPanel%% THEN r = r2: _CONTINUE
        END IF

        IF s THEN
            menuChoiceMade:
            IF KALT THEN idehl = 1 ELSE idehl = 0 'set idehl, a shared variable used by various dialogue boxes

            IF menu$(m, s) = "Add Co#mment (')  Ctrl+R" THEN
                ctrlAddComment:
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

            IF menu$(m, s) = "Remove Comme#nt (')  Ctrl+Shift+R" THEN
                ctrlRemoveComment:
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

            IF menu$(m, s) = "To#ggle Comment  Ctrl+T" THEN
                ctrlToggleComment:
                PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
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
                        a2$ = LTRIM$(a$)
                        IF LEN(a2$) THEN
                            IF ASC(a2$, 1) = 39 THEN
                                a$ = SPACE$(LEN(a$) - LEN(a2$)) + RIGHT$(a2$, LEN(a2$) - 1)
                                idesetline y, a$
                                idechangemade = 1
                            ELSE
                                a$ = LEFT$(a$, lhs) + "'" + RIGHT$(a$, LEN(a$) - lhs)
                                idesetline y, a$
                                idechangemade = 1
                            END IF
                        END IF
                    END IF
                NEXT
                PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                GOTO ideloop
            END IF

            IF menu$(m, s) = "#Increase Indent  TAB" THEN
                IF ideselect THEN GOTO IdeBlockIncreaseIndent
                PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                GOTO ideloop
            END IF

            IF LEFT$(menu$(m, s), 16) = "#Decrease Indent" THEN
                IF ideselect THEN GOTO IdeBlockDecreaseIndent
                PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                GOTO ideloop
            END IF

            IF menu$(m, s) = "#Language..." THEN
                PCOPY 2, 0
                retval = idelanguagebox
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
                            IF IDE_UseFont8 THEN _FONT 8 ELSE _FONT 16
                        END IF
                        skipdisplay = 0
                        GOSUB redrawItAll
                    END IF
                END IF
                PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                GOTO ideloop
            END IF

            IF menu$(m, s) = "IDE C#olors..." THEN
                PCOPY 2, 0
                HideBracketHighlight
                retval = idechoosecolorsbox 'retval is ignored
                PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                GOTO ideloop
            END IF

            IF menu$(m, s) = "#RGB Color Mixer..." THEN
                PCOPY 2, 0
                oldkeywordHighlight = keywordHighlight
                keywordHighlight = 0
                HideBracketHighlight
                keywordHighlight = oldkeywordHighlight
                retval$ = idergbmixer$(-1) 'retval is ignored
                IF LEN(retval$) THEN
                    tempk$ = retval$

                    'insert
                    IF ideselect THEN GOSUB delselect
                    a$ = idegetline(idecy)
                    IF LEN(a$) < idecx - 1 THEN a$ = a$ + SPACE$(idecx - 1 - LEN(a$))
                    a$ = LEFT$(a$, idecx - 1) + tempk$ + RIGHT$(a$, LEN(a$) - idecx + 1)
                    idesetline idecy, a$

                    IF PasteCursorAtEnd THEN
                        'Place the cursor at the end of the inserted content:
                        idecx = idecx + LEN(tempk$)
                    END IF

                    idechangemade = 1
                END IF
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


            IF RIGHT$(menu$(m, s), 19) = "#Swap Mouse Buttons" THEN
                PCOPY 2, 0
                MouseButtonSwapped = NOT MouseButtonSwapped
                IF MouseButtonSwapped THEN
                    WriteConfigSetting "'[MOUSE SETTINGS]", "SwapMouseButton", "TRUE"
                    menu$(OptionsMenuID, OptionsMenuSwapMouse) = CHR$(7) + "#Swap Mouse Buttons"
                ELSE
                    WriteConfigSetting "'[MOUSE SETTINGS]", "SwapMouseButton", "FALSE"
                    menu$(OptionsMenuID, OptionsMenuSwapMouse) = "#Swap Mouse Buttons"
                END IF
                PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                GOTO ideloop
            END IF

            IF RIGHT$(menu$(m, s), 27) = "Disable Syntax #Highlighter" THEN
                PCOPY 2, 0
                DisableSyntaxHighlighter = NOT DisableSyntaxHighlighter
                IF DisableSyntaxHighlighter THEN
                    WriteConfigSetting "'[GENERAL SETTINGS]", "DisableSyntaxHighlighter", "TRUE"
                    menu$(OptionsMenuID, OptionsMenuDisableSyntax) = CHR$(7) + "Disable Syntax #Highlighter"
                ELSE
                    WriteConfigSetting "'[GENERAL SETTINGS]", "DisableSyntaxHighlighter", "FALSE"
                    menu$(OptionsMenuID, OptionsMenuDisableSyntax) = "Disable Syntax #Highlighter"
                END IF
                PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                GOTO ideloop
            END IF

            IF RIGHT$(menu$(m, s), 28) = "Cursor After #Pasted Content" THEN
                PCOPY 2, 0
                PasteCursorAtEnd = NOT PasteCursorAtEnd
                IF PasteCursorAtEnd THEN
                    WriteConfigSetting "'[GENERAL SETTINGS]", "PasteCursorAtEnd", "TRUE"
                    menu$(OptionsMenuID, OptionsMenuPasteCursor) = CHR$(7) + "Cursor After #Pasted Content"
                ELSE
                    WriteConfigSetting "'[GENERAL SETTINGS]", "PasteCursorAtEnd", "FALSE"
                    menu$(OptionsMenuID, OptionsMenuPasteCursor) = "Cursor After #Pasted Content"
                END IF
                PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                GOTO ideloop
            END IF

            IF RIGHT$(menu$(m, s), 36) = "Show Compilation #Errors Immediately" THEN
                PCOPY 2, 0
                IDEShowErrorsImmediately = NOT IDEShowErrorsImmediately
                IF IDEShowErrorsImmediately THEN
                    WriteConfigSetting "'[GENERAL SETTINGS]", "ShowErrorsImmediately", "TRUE"
                    menu$(OptionsMenuID, OptionsMenuShowErrorsImmediately) = CHR$(7) + "Show Compilation #Errors Immediately"
                ELSE
                    WriteConfigSetting "'[GENERAL SETTINGS]", "ShowErrorsImmediately", "FALSE"
                    menu$(OptionsMenuID, OptionsMenuShowErrorsImmediately) = "Show Compilation #Errors Immediately"
                END IF
                idechangemade = 1
                PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                GOTO ideloop
            END IF

            IF RIGHT$(menu$(m, s), 16) = "Ignore #Warnings" THEN
                PCOPY 2, 0
                IF Ignorewarnings = 0 THEN
                    Ignorewarnings = -1
                    WriteConfigSetting "'[GENERAL SETTINGS]", "IgnoreWarnings", "TRUE"
                    menu$(OptionsMenuID, OptionsMenuIgnoreWarnings) = CHR$(7) + "Ignore #Warnings"
                ELSE
                    Ignorewarnings = 0
                    WriteConfigSetting "'[GENERAL SETTINGS]", "IgnoreWarnings", "FALSE"
                    menu$(OptionsMenuID, OptionsMenuIgnoreWarnings) = "Ignore #Warnings"
                END IF
                idechangemade = 1
                PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                GOTO ideloop
            END IF

            IF RIGHT$(menu$(m, s), 28) = "Output EXE to Source #Folder" THEN
                PCOPY 2, 0
                SaveExeWithSource = NOT SaveExeWithSource
                IF SaveExeWithSource THEN
                    WriteConfigSetting "'[GENERAL SETTINGS]", "SaveExeWithSource", "TRUE"
                    menu$(RunMenuID, RunMenuSaveExeWithSource) = CHR$(7) + "Output EXE to Source #Folder"
                ELSE
                    WriteConfigSetting "'[GENERAL SETTINGS]", "SaveExeWithSource", "FALSE"
                    menu$(RunMenuID, RunMenuSaveExeWithSource) = "Output EXE to Source #Folder"
                END IF
                PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                idecompiled = 0
                GOTO ideloop
            END IF

            IF MID$(menu$(m, s), 1, 24) = "Enable #Quick Navigation" OR MID$(menu$(m, s), 2, 24) = "Enable #Quick Navigation" THEN
                PCOPY 2, 0
                EnableQuickNav = NOT EnableQuickNav
                IF EnableQuickNav THEN
                    WriteConfigSetting "'[GENERAL SETTINGS]", "EnableQuickNav", "TRUE"
                    menu$(SearchMenuID, SearchMenuEnableQuickNav) = CHR$(7) + "Enable #Quick Navigation (Back Arrow)"
                ELSE
                    WriteConfigSetting "'[GENERAL SETTINGS]", "EnableQuickNav", "FALSE"
                    menu$(SearchMenuID, SearchMenuEnableQuickNav) = "Enable #Quick Navigation (Back Arrow)"
                END IF
                PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                GOTO ideloop
            END IF

            IF menu$(m, s) = "#Code Layout..." THEN
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
                    result = idemessagebox("Bookmarks", "No bookmarks exist (Use Alt+Left to create a bookmark)", "")
                    PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                    GOTO ideloop
                END IF
                IF IdeBmkN = 1 THEN
                    IF idecy = IdeBmk(1).y THEN
                        result = idemessagebox("Bookmarks", "No other bookmarks exist", "")
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






            IF menu$(m, s) = "#Go To Line...  Ctrl+G" THEN
                PCOPY 2, 0
                idegotobox
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
                m$ = "QB64 Version " + Version$ + CHR$(10) + BuildNum$
                IF LEN(AutoBuildMsg$) THEN m$ = m$ + CHR$(10) + AutoBuildMsg$
                result = idemessagebox("About", m$, "")
                PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                GOTO ideloop
            END IF


            IF menu$(m, s) = "#ASCII Chart..." THEN
                PCOPY 2, 0
                DO
                    retval$ = ideASCIIbox$(relaunch)
                    IF LEN(retval$) THEN
                        tempk$ = retval$

                        'insert
                        IF ideselect THEN GOSUB delselect
                        a$ = idegetline(idecy)
                        IF LEN(a$) < idecx - 1 THEN a$ = a$ + SPACE$(idecx - 1 - LEN(a$))
                        a$ = LEFT$(a$, idecx - 1) + tempk$ + RIGHT$(a$, LEN(a$) - idecx + 1)
                        idesetline idecy, a$

                        IF PasteCursorAtEnd THEN
                            'Place the cursor at the end of the inserted content:
                            idecx = idecx + LEN(tempk$)
                        END IF

                        idechangemade = 1
                    END IF
                    PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                    GOSUB redrawItAll
                    ideshowtext
                    PCOPY 3, 0
                LOOP WHILE relaunch
                retval = 1
                GOTO ideloop
            END IF

            IF menu$(m, s) = "Insert Quick #Keycode  Ctrl+K" THEN
                PCOPY 3, 0: SCREEN , , 3, 0
                ideQuickKeycode:
                dummy = DarkenFGBG(1)
                COLOR 7, 1: LOCATE idewy - 3, 2: PRINT SPACE$(idewx - 2);: LOCATE idewy - 2, 2: PRINT SPACE$(idewx - 2);: LOCATE idewy - 1, 2: PRINT SPACE$(idewx - 2); 'clear status window
                LOCATE idewy - 3, 2
                COLOR 15, 1
                PRINT "Press any key to insert its _KEYHIT/_KEYDOWN code..."
                PCOPY 3, 0

                tempk$ = ""

                DO: tempk = _KEYHIT: _LIMIT 30: LOOP UNTIL tempk = 0 'wait for key release
                DO 'get the next key hit
                    tempk = _KEYHIT
                    IF tempk > 0 THEN tempk$ = STR$(tempk)

                    WHILE _MOUSEINPUT: WEND
                    IF _MOUSEBUTTON(1) OR _MOUSEBUTTON(2) THEN GOTO bypassCtrlK

                    _LIMIT 30
                LOOP UNTIL tempk > 0
                IF tempk = 100303 OR tempk = 100304 THEN 'shift key
                    DO 'get the next key hit
                        tempk = _KEYHIT 'see what the next key is, and use it
                        IF tempk <> 0 THEN tempk$ = STR$(ABS(tempk)) 'if it's the SHFT UP code, then return the value for shift

                        WHILE _MOUSEINPUT: WEND
                        IF _MOUSEBUTTON(1) OR _MOUSEBUTTON(2) THEN GOTO bypassCtrlK

                        _LIMIT 30
                    LOOP UNTIL tempk <> 0
                END IF
                tempk$ = LTRIM$(tempk$)

                'insert
                IF ideselect THEN GOSUB delselect
                a$ = idegetline(idecy)
                IF LEN(a$) < idecx - 1 THEN a$ = a$ + SPACE$(idecx - 1 - LEN(a$))
                a$ = LEFT$(a$, idecx - 1) + tempk$ + RIGHT$(a$, LEN(a$) - idecx + 1)
                idesetline idecy, a$

                IF PasteCursorAtEnd THEN
                    'Place the cursor at the end of the inserted content:
                    idecx = idecx + LEN(tempk$)
                END IF

                idechangemade = 1
                bypassCtrlK:
                dummy = DarkenFGBG(0)
                PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                retval = 1
                KCTRL = 0: KCONTROL = 0
                GOSUB redrawItAll
                GOTO ideloop
            END IF

            IF LEFT$(menu$(m, s), 10) = "#Help On '" THEN 'Contextual menu Help
                PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                GOTO contextualhelp
            END IF

            IF LEFT$(menu$(m, s), 10) = "#Go To SUB" OR LEFT$(menu$(m, s), 15) = "#Go To FUNCTION" THEN 'Contextual menu Goto
                PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                AddQuickNavHistory idecy
                idecy = CVL(MID$(SubFuncLIST(1), 1, 4))
                idesy = idecy
                idecx = 1
                idesx = 1
                ideselect = 0
                GOTO ideloop
            END IF

            IF LEFT$(menu$(m, s), 12) = "Go To #Label" THEN 'Contextual menu Goto label
                PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                AddQuickNavHistory idecy
                idecy = CVL(MID$(SubFuncLIST(UBOUND(SubFuncLIST)), 1, 4))
                idesy = idecy
                idecx = 1
                idesx = 1
                ideselect = 0
                GOTO ideloop
            END IF

            IF menu$(m, s) = "#Contents Page" THEN
                PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                lnk$ = "QB64 Help Menu"
                GOTO OpenHelpLnk
            END IF
            IF menu$(m, s) = "Keyword #Index" THEN
                PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                lnk$ = "Keyword Reference - Alphabetical"
                GOTO OpenHelpLnk
            END IF
            IF menu$(m, s) = "#Keywords by Usage" THEN
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
                    retval = 1: GOSUB redrawItAll
                END IF

                GOTO ideloop
            END IF

            IF menu$(m, s) = "#Update Current Page" THEN
                PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                IF idehelp THEN
                    Help_IgnoreCache = 1
                    a$ = Wiki$(Back$(Help_Back_Pos))
                    Help_IgnoreCache = 0
                    WikiParse a$
                END IF
                GOTO ideloop
            END IF


            IF menu$(m, s) = "#Math Evaluator..." THEN
                STATIC mathEvalExpr$
                'build initial name if word selected
                IF ideselect THEN
                    IF ideselecty1 = idecy THEN 'single line selected
                        a$ = idegetline(idecy)
                        a2$ = ""
                        sx1 = ideselectx1: sx2 = idecx
                        IF sx2 < sx1 THEN SWAP sx1, sx2
                        FOR x = sx1 TO sx2 - 1
                            IF x <= LEN(a$) THEN a2$ = a2$ + MID$(a$, x, 1) ELSE EXIT FOR
                        NEXT
                        a2$ = _TRIM$(a2$)
                        IF LEN(a2$) THEN mathEvalExpr$ = a2$
                    END IF
                END IF

                DO
                    PCOPY 2, 0
                    retval$ = ideinputbox$("Math Evaluator", "#Enter expression", mathEvalExpr$, "", 60, 0)
                    result = 0
                    IF LEN(retval$) THEN
                        mathEvalExpr$ = retval$
                        ev0$ = Evaluate_Expression$(retval$)
                        ev$ = ev0$
                        mathEvalError%% = INSTR(ev$, "ERROR") > 0
                        IF mathEvalError%% = 0 AND mathEvalHEX%% THEN ev$ = "&H" + HEX$(VAL(ev$))
                        DO
                            b1$ = "#Insert;"
                            IF mathEvalHEX%% THEN b2$ = "#Decimal;" ELSE b2$ = "#HEX$;"
                            IF mathEvalError%% = 0 AND mathEvalComment%% THEN
                                mathMsg$ = ev$ + " '" + retval$
                                b3$ = "#Uncomment;"
                            ELSE
                                mathMsg$ = ev$
                                b3$ = "Co#mment;"
                            END IF
                            IF mathEvalError%% THEN b1$ = "": b2$ = "": b3$ = ""
                            PCOPY 2, 0
                            result = idemessagebox("Math Evaluator - Result", mathMsg$, b1$ + b2$ + b3$ + "#Redo;#Cancel")
                            IF mathEvalError%% = 0 THEN
                                SELECT CASE result
                                    CASE 1, 4, 5
                                        EXIT DO
                                    CASE 2
                                        mathEvalHEX%% = NOT mathEvalHEX%%
                                        IF mathEvalHEX%% THEN ev$ = "&H" + HEX$(VAL(ev$)) ELSE ev$ = ev0$
                                    CASE 3
                                        mathEvalComment%% = NOT mathEvalComment%%
                                END SELECT
                            ELSE
                                EXIT DO
                            END IF
                        LOOP
                        IF mathEvalError%% AND result = 2 THEN EXIT DO
                        IF mathEvalError%% = 0 AND (result = 1 OR result = 5) THEN EXIT DO
                    ELSE
                        EXIT DO
                    END IF
                LOOP

                IF mathEvalError%% = 0 AND result = 1 THEN
                    tempk$ = mathMsg$

                    'insert
                    IF ideselect THEN GOSUB delselect
                    a$ = idegetline(idecy)
                    IF LEN(a$) < idecx - 1 THEN a$ = a$ + SPACE$(idecx - 1 - LEN(a$))
                    a$ = LEFT$(a$, idecx - 1) + tempk$ + RIGHT$(a$, LEN(a$) - idecx + 1)
                    idesetline idecy, a$

                    IF PasteCursorAtEnd THEN
                        'Place the cursor at the end of the inserted content:
                        idecx = idecx + LEN(tempk$)
                    END IF

                    idechangemade = 1
                END IF
                PCOPY 3, 0: SCREEN , , 3, 0
                GOTO ideloop
            END IF

            IF menu$(m, s) = "Update All #Pages..." THEN
                PCOPY 2, 0
                q$ = ideyesnobox("Update Help", "This can take up to 10 minutes.\nRedownload all cached help content from the wiki?")
                PCOPY 2, 0
                IF q$ = "Y" THEN ideupdatehelpbox
                PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
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

            IF menu$(m, s) = "#Line Numbers  " + CHR$(16) THEN
                idecontextualmenu = 2
                GOTO showmenu
            END IF

            IF menu$(m, s) = "#Show Line Numbers" THEN
                PCOPY 2, 0
                ShowLineNumbers = -1
                WriteConfigSetting "'[GENERAL SETTINGS]", "ShowLineNumbers", "TRUE"
                menu$(m, s) = "#Hide Line Numbers"
                menu$(m, ViewMenuShowBGID) = MID$(menu$(m, ViewMenuShowBGID), 2)
                menu$(m, ViewMenuShowSeparatorID) = MID$(menu$(m, ViewMenuShowSeparatorID), 2)
                PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                GOTO ideloop
            END IF

            IF menu$(m, s) = "#Hide Line Numbers" THEN
                PCOPY 2, 0
                ShowLineNumbers = 0
                WriteConfigSetting "'[GENERAL SETTINGS]", "ShowLineNumbers", "FALSE"
                menu$(m, s) = "#Show Line Numbers"
                menu$(m, ViewMenuShowBGID) = "~" + menu$(m, ViewMenuShowBGID)
                menu$(m, ViewMenuShowSeparatorID) = "~" + menu$(m, ViewMenuShowSeparatorID)
                PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                GOTO ideloop
            END IF

            IF RIGHT$(menu$(m, s), 17) = "#Background Color" THEN
                IF LEFT$(menu$(m, s), 1) <> "~" THEN
                    PCOPY 2, 0
                    ShowLineNumbersUseBG = NOT ShowLineNumbersUseBG
                    IF ShowLineNumbersUseBG THEN
                        WriteConfigSetting "'[GENERAL SETTINGS]", "ShowLineNumbersUseBG", "TRUE"
                        menu$(m, s) = CHR$(7) + "#Background Color"
                    ELSE
                        WriteConfigSetting "'[GENERAL SETTINGS]", "ShowLineNumbersUseBG", "FALSE"
                        menu$(m, s) = "#Background Color"
                    END IF
                    PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                    GOTO ideloop
                END IF
            END IF

            IF RIGHT$(menu$(m, s), 15) = "Sho#w Separator" THEN
                IF LEFT$(menu$(m, s), 1) <> "~" THEN
                    PCOPY 2, 0
                    ShowLineNumbersSeparator = NOT ShowLineNumbersSeparator
                    IF ShowLineNumbersSeparator THEN
                        WriteConfigSetting "'[GENERAL SETTINGS]", "ShowLineNumbersSeparator", "TRUE"
                        menu$(m, s) = CHR$(7) + "Sho#w Separator"
                    ELSE
                        WriteConfigSetting "'[GENERAL SETTINGS]", "ShowLineNumbersSeparator", "FALSE"
                        menu$(m, s) = "Sho#w Separator"
                    END IF
                    PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                    GOTO ideloop
                END IF
            END IF

            IF menu$(m, s) = "Compiler #Warnings...  Ctrl+W" THEN
                PCOPY 2, 0
                retval = idewarningbox
                'retval is ignored
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

            IF LEFT$(menu$(m, s), 6) = "Find '" THEN 'Contextual menu Find
                idefindtext = idecontextualSearch$
                IdeAddSearched idefindtext
                PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                GOTO idemf3
            END IF

            IF menu$(m, s) = "#Change...  Alt+F3" THEN
                PCOPY 2, 0
                idefindchangejmp:
                r$ = idechange
                PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                idealthighlight = 0
                LOCATE , , 0: COLOR 0, 7: LOCATE 1, 1: PRINT menubar$;
                IF r$ = "C" OR r$ = "" THEN GOTO ideloop
                'assume "V", verify changes
                IdeAddSearched idefindtext

                oldcx = idecx: oldcy = idecy
                found = 0: looped = 0
                changed = 0

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

                DIM comment AS _BYTE, quote AS _BYTE
                IF x THEN
                    FindQuoteComment l$, x, comment, quote
                    IF idefindnocomments <> 0 AND comment THEN x = 0
                    IF idefindnostrings <> 0 AND quote THEN x = 0
                    IF idefindonlycomments <> 0 AND comment = 0 THEN x = 0
                    IF idefindonlystrings <> 0 AND quote = 0 THEN x = 0
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
                        changed = changed + 1
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
                IF changed THEN
                    ideshowtext
                    SCREEN , , 0, 0: LOCATE , , 1: SCREEN , , 3, 0
                    PCOPY 3, 0
                    idechanged changed
                ELSEIF found THEN
                    ideshowtext
                    SCREEN , , 0, 0: LOCATE , , 1: SCREEN , , 3, 0
                    PCOPY 3, 0
                    result = idemessagebox("Search complete", "No changes made.", "")
                ELSE
                    idenomatch
                END IF
                PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                GOTO ideloop
            END IF '#Change...

            IF menu$(m, s) = "Clear Search #History..." THEN
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
                IF IdeSystem = 1 AND ideselect = 1 THEN
                    idechangemade = 1
                    GOSUB delselect
                ELSEIF IdeSystem = 2 THEN
                    GOTO deleteSelectionSearchField
                END IF
                GOTO ideloop
            END IF

            IF menu$(m, s) = "#Paste  Shift+Ins or Ctrl+V" THEN
                PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                IF IdeSystem = 1 THEN GOTO idempaste
                IF IdeSystem = 2 THEN GOTO pasteIntoSearchField
            END IF

            IF menu$(m, s) = "#Copy  Ctrl+Ins or Ctrl+C" THEN
                PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                IF IdeSystem = 1 AND ideselect = 1 THEN GOTO copy2clip
                IF IdeSystem = 2 THEN GOTO copysearchterm2clip
                IF IdeSystem = 3 AND Help_Select = 2 THEN GOTO copyhelp2clip
                GOTO ideloop
            END IF

            IF menu$(m, s) = "Cu#t  Shift+Del or Ctrl+X" THEN
                PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                IF IdeSystem = 1 AND ideselect = 1 THEN
                    K$ = CHR$(0) + "S" 'tricks handler into del after copy
                    GOTO idemcut
                ELSEIF IdeSystem = 2 THEN
                    GOTO cutToClipboardSearchField
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
                IF IdeSystem = 1 THEN GOTO idemselectall
                IF IdeSystem = 2 THEN GOTO selectAllInSearchField
                IF IdeSystem = 3 THEN GOTO selectAllInHelp
            END IF

            IF menu$(m, s) = "Clo#se Help  ESC" THEN
                PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                GOTO closeHelp
            END IF

            IF menu$(m, s) = "#Start  F5" THEN
                PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                GOTO idemrun
            END IF

            IF menu$(m, s) = "Modify #COMMAND$..." THEN
                PCOPY 2, 0
                ModifyCOMMAND$ = " " + ideinputbox$("Modify COMMAND$", "#Enter text for COMMAND$", _TRIM$(ModifyCOMMAND$), "", 60, 0)
                IF _TRIM$(ModifyCOMMAND$) = "" THEN ModifyCOMMAND$ = ""
                'retval is ignored
                PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                GOTO ideloop
            END IF

            IF menu$(m, s) = "Make E#XE Only  F11" OR menu$(m, s) = "Make E#xecutable Only  F11" THEN
                PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
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
                                r$ = idefiledialog$("untitled" + tempfolderindexstr$ + ".bas", 2)
                            ELSE
                                r$ = idefiledialog$(ProposedTitle$ + ".bas", 2)
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

            IF menu$(m, s) = "#New  Ctrl+N" THEN
                PCOPY 2, 0
                ctrlNew:
                IF ideunsaved = 1 THEN
                    r$ = idesavenow
                    PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                    IF r$ = "C" THEN GOTO ideloop
                    IF r$ = "Y" THEN
                        IF ideprogname = "" THEN
                            ProposedTitle$ = FindProposedTitle$
                            IF ProposedTitle$ = "" THEN
                                r$ = idefiledialog$("untitled" + tempfolderindexstr$ + ".bas", 2)
                            ELSE
                                r$ = idefiledialog$(ProposedTitle$ + ".bas", 2)
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
                listOfCustomKeywords$ = LEFT$(listOfCustomKeywords$, customKeywordsLength)
                QuickNavTotal = 0
                ModifyCOMMAND$ = ""
                _TITLE WindowTitle
                idechangemade = 1
                idefocusline = 0
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
                        GOTO ideshowrecentbox
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

            IF menu$(m, s) = "Clear #Recent..." THEN
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

            IF menu$(m, s) = "#Open...  Ctrl+O" THEN
                IdeOpenFile$ = ""
                directopen:
                PCOPY 2, 0
                ctrlOpen:
                IF ideunsaved THEN
                    r$ = idesavenow
                    PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                    IF r$ = "C" THEN GOTO ideloop
                    IF r$ = "Y" THEN
                        IF ideprogname = "" THEN
                            ProposedTitle$ = FindProposedTitle$
                            IF ProposedTitle$ = "" THEN
                                r$ = idefiledialog$("untitled" + tempfolderindexstr$ + ".bas", 2)
                            ELSE
                                r$ = idefiledialog$(ProposedTitle$ + ".bas", 2)
                            END IF
                            IF r$ = "C" THEN GOTO ideloop
                        ELSE
                            idesave idepath$ + idepathsep$ + ideprogname$
                        END IF
                        PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                    END IF '"Y"
                END IF 'unsaved
                r$ = idefiledialog$("", 1)
                IF r$ <> "C" THEN ideunsaved = -1: idechangemade = 1: idelayoutallow = 2: ideundobase = 0: QuickNavTotal = 0: ModifyCOMMAND$ = ""
                PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt
                GOSUB redrawItAll: GOTO ideloop
            END IF

            IF menu$(m, s) = "#Save  Ctrl+S" THEN
                PCOPY 2, 0
                IF ideprogname = "" THEN
                    ProposedTitle$ = FindProposedTitle$
                    IF ProposedTitle$ = "" THEN
                        a$ = idefiledialog$("untitled" + tempfolderindexstr$ + ".bas", 2)
                    ELSE
                        a$ = idefiledialog$(ProposedTitle$ + ".bas", 2)
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
                        a$ = idefiledialog$("untitled" + tempfolderindexstr$ + ".bas", 2)
                    ELSE
                        a$ = idefiledialog$(ProposedTitle$ + ".bas", 2)
                    END IF
                ELSE
                    a$ = idefiledialog$(ideprogname$, 2)
                END IF
                PCOPY 3, 0: SCREEN , , 3, 0: idewait4mous: idewait4alt: GOTO ideloop
            END IF

            IF LEFT$(menu$(m, s), 1) = "~" THEN 'Ignore disabled items (starting with "~")
                _CONTINUE
            END IF

            SCREEN , , 0, 0
            CLS: PRINT "MENU ITEM [" + menu$(m, s) + "] NOT IMPLEMENTED!": END
        END IF


        _LIMIT 100

    LOOP

    '--------------------------------------------------------------------------------
    EXIT FUNCTION
    UpdateTitleOfMainWindow:
    COLOR 7, 1: LOCATE 2, 2: PRINT STRING$(idewx - 2, CHR$(196));
    IF LEN(ideprogname) THEN a$ = ideprogname ELSE a$ = "Untitled" + tempfolderindexstr$
    a$ = " " + a$
    IF ideunsaved THEN a$ = a$ + "*"
    IF LEN(sfname$) > 0 THEN a$ = a$ + ":" + sfname$
    a$ = a$ + " "
    IF LEN(a$) > idewx - 5 THEN a$ = LEFT$(a$, idewx - 11) + STRING$(3, 250) + " "
    IF IdeSystem = 1 THEN COLOR 1, 7 ELSE COLOR 7, 1
    LOCATE 2, ((idewx / 2) - 1) - (LEN(a$) - 1) \ 2: PRINT a$;
    RETURN

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
    COLOR 7, 1: PRINT CHR$(180);
    COLOR 3, 1
    PRINT "Find";
    PRINT "[" + SPACE$(idesystem2.w + 1) + CHR$(18) + "]";
    COLOR 7, 1: PRINT CHR$(195);

    'add status title
    IF IdeSystem = 2 THEN COLOR 1, 7 ELSE COLOR 7, 1
    LOCATE idewy - 4, (idewx - 8) / 2: PRINT " Status "

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
    IF sx1 > sx2 THEN SWAP sx1, sx2

    x = x + 2
    'apply selection color change if necessary
    IF idesystem2.issel = 0 OR IdeSystem <> 2 THEN
        COLOR 3, 1
        LOCATE idewy - 4, idewx - (idesystem2.w + 8) + 4: PRINT a$;
    ELSE
        FOR ColorCHAR = 1 TO LEN(a$)
            IF ColorCHAR + tx - 2 >= sx1 AND ColorCHAR + tx - 2 < sx2 THEN COLOR 1, 3 ELSE COLOR 3, 1
            LOCATE idewy - 4, idewx - (idesystem2.w + 8) + 4 - 1 + ColorCHAR
            PRINT MID$(a$, ColorCHAR, 1);
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
                REDIM _PRESERVE RecentFilesList(1 TO ln)
                RecentFilesList(ln) = f$
            ELSE
                FoundBrokenLink = -1
            END IF
        END IF
    LOOP

    IF NOT FoundBrokenLink THEN
        result = idemessagebox("Remove Broken Links", "All files in the list are accessible.", "#OK")
    END IF

    IF ln > 0 AND FoundBrokenLink THEN
        fh = FREEFILE
        OPEN ".\internal\temp\recent.bin" FOR OUTPUT AS #fh: CLOSE #fh
        f$ = ""
        FOR ln = 1 TO UBOUND(RecentFilesList)
            f$ = f$ + CRLF + RecentFilesList(ln) + CRLF
        NEXT
        fh = FREEFILE
        OPEN ".\internal\temp\recent.bin" FOR BINARY AS #fh
        PUT #fh, 1, f$
        CLOSE #fh
    END IF

    ERASE RecentFilesList
    IdeMakeFileMenu
    RETURN

    redrawItAll:
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



    LOCATE , , , IDENormalCursorStart, IDENormalCursorEnd

    'static background
    COLOR 0, 7: LOCATE 1, 1: PRINT menubar$;
    COLOR 7, 1: idebox 1, 2, idewx, idewy - 5


    COLOR 7, 1: idebox 1, idewy - 4, idewx, 5
    'edit corners
    COLOR 7, 1: LOCATE idewy - 4, 1: PRINT CHR$(195);: LOCATE idewy - 4, idewx: PRINT CHR$(180);

    IF idehelp = 1 THEN
        COLOR 7, 0: idebox 1, idewy, idewx, idesubwindow + 1
        COLOR 7, 0: LOCATE idewy, 1: PRINT CHR$(195);: LOCATE idewy, idewx: PRINT CHR$(180);
        COLOR 7, 0: LOCATE idewy, idewx - 3: PRINT CHR$(180) + "X" + CHR$(195);
    END IF

    GOSUB UpdateSearchBar

    'status bar
    COLOR 0, 3: LOCATE idewy + idesubwindow, 1: PRINT SPACE$(idewx);
    q = idevbar(idewx, idewy - 3, 3, 1, 1)
    q = idevbar(idewx, 3, idewy - 8, 1, 1)
    q = idehbar(2, idewy - 5, idewx - 2, 1, 1)

    GOSUB UpdateTitleOfMainWindow

    DEF SEG = 0
    ideshowtext

    IF idehelp THEN
        Help_ShowText

        q = idehbar(2, idewy + idesubwindow - 1, idewx - 2, Help_cx, help_w + 1)
        q = idevbar(idewx, idewy + 1, idesubwindow - 2, Help_cy, help_h + 1)

        GOSUB HelpAreaShowBackLinks
    END IF

    IF IDEShowErrorsImmediately OR IDECompilationRequested THEN
        COLOR 7, 1: LOCATE idewy - 3, 2: PRINT SPACE$(idewx - 2);: LOCATE idewy - 2, 2: PRINT SPACE$(idewx - 2);: LOCATE idewy - 1, 2: PRINT SPACE$(idewx - 2); 'clear status window

        IdeInfo = ""

        LOCATE idewy - 3, 2
        IF idecompiling = 1 THEN
            PRINT "...";
        ELSE
            IF idefocusline THEN
                PRINT "...";
            ELSE
                PRINT "OK"; 'report OK status
            END IF
            statusarealink = 0
            IF totalWarnings > 0 THEN
                COLOR 11, 1
                PRINT " ("; LTRIM$(STR$(totalWarnings)) + " warning";
                IF totalWarnings > 1 THEN PRINT "s";
                PRINT " - click here or Ctrl+W to view)";
                statusarealink = 4
            END IF
        END IF
    END IF
    RETURN

    HelpAreaShowBackLinks:
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
            IF IdeSystem = 3 THEN COLOR 0, 7 ELSE COLOR 7, 0
            IF i < Help_Back_Pos THEN COLOR 9
            IF i > Help_Back_Pos THEN COLOR 9
            PRINT CHR$(a);
        ELSE
            COLOR 7, 0
            PRINT CHR$(196);
        END IF
    NEXT
    RETURN

END FUNCTION

SUB idebox (x, y, w, h)
    LOCATE y, x: PRINT CHR$(218) + STRING$(w - 2, 196) + CHR$(191);
    FOR y2 = y + 1 TO y + h - 2
        LOCATE y2, x: PRINT CHR$(179) + SPACE$(w - 2) + CHR$(179);
    NEXT
    LOCATE y + h - 1, x: PRINT CHR$(192) + STRING$(w - 2, 196) + CHR$(217);
END SUB

SUB ideboxshadow (x, y, w, h)

    LOCATE y, x: PRINT CHR$(218) + STRING$(w - 2, 196) + CHR$(191);
    FOR y2 = y + 1 TO y + h - 2
        LOCATE y2, x: PRINT CHR$(179) + SPACE$(w - 2) + CHR$(179);
    NEXT
    LOCATE y + h - 1, x: PRINT CHR$(192) + STRING$(w - 2, 196) + CHR$(217);
    'shadow
    COLOR 2, 0
    FOR y2 = y + 1 TO y + h - 1
        FOR x2 = x + w TO x + w + 1
            IF x2 <= idewx AND y2 <= idewy + idesubwindow THEN
                LOCATE y2, x2: PRINT CHR$(SCREEN(y2, x2));
            END IF
        NEXT
    NEXT

    y2 = y + h
    IF y2 <= idewy + idesubwindow THEN
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
            REDIM _PRESERVE SearchHistory(1 TO ln)
            SearchHistory(ln) = f$
        END IF
    LOOP
    ln = 0

    i = 0
    idepar p, 60, 14, "Change"
    i = i + 1
    PrevFocus = 1
    o(i).typ = 1
    o(i).y = 2
    o(i).nam = idenewtxt("#Find What")
    o(i).txt = idenewtxt(a2$)
    IF LEN(a2$) > 0 THEN
        o(i).issel = -1
        o(i).sx1 = 0
    END IF
    o(i).v1 = LEN(a2$)

    i = i + 1
    o(i).typ = 1
    o(i).y = 5
    o(i).nam = idenewtxt("Change #To")
    o(i).txt = idenewtxt(idechangeto)
    IF LEN(idechangeto) > 0 THEN
        o(i).issel = -1
        o(i).sx1 = 0
    END IF
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
    o(i).typ = 4 'check box
    o(i).y = 11
    o(i).nam = idenewtxt("#Ignore 'comments")
    o(i).sel = idefindnocomments

    i = i + 1
    o(i).typ = 4 'check box
    o(i).x = 29
    o(i).y = 11
    o(i).nam = idenewtxt("#Look only in 'comments")
    o(i).sel = idefindonlycomments

    i = i + 1
    o(i).typ = 4 'check box
    o(i).y = 12
    o(i).nam = idenewtxt("Ignore " + CHR$(34) + "#strings" + CHR$(34))
    o(i).sel = idefindnostrings

    i = i + 1
    o(i).typ = 4 'check box
    o(i).x = 29
    o(i).y = 12
    o(i).nam = idenewtxt("Look only in " + CHR$(34) + "st#rings" + CHR$(34))
    o(i).sel = idefindonlystrings

    i = i + 1
    o(i).typ = 3
    o(i).y = 14
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
        IF alt AND NOT KCTRL THEN idehl = 1 ELSE idehl = 0
        'convert "alt+letter" scancode to letter's ASCII character
        altletter$ = ""
        IF alt AND NOT KCTRL THEN
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
        IF (KSHIFT AND K$ = CHR$(9)) OR (INSTR(_OS$, "MAC") AND K$ = CHR$(25)) THEN focus = focus - 1: K$ = ""
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
            'Always start with TextBox values selected upon getting focus
            PrevFocus = focus
            IF focus = 1 OR focus = 2 THEN
                o(focus).v1 = LEN(idetxt(o(focus).txt))
                IF o(focus).v1 > 0 THEN o(focus).issel = -1
                o(focus).sx1 = 0
            END IF
        END IF

        'mutually exclusive options
        IF focus = 6 AND o(6).sel = 1 THEN
            o(7).sel = 0
        ELSEIF focus = 7 AND o(7).sel = 1 THEN
            o(6).sel = 0
            o(8).sel = 0
            o(9).sel = 0
        ELSEIF focus = 8 AND o(8).sel = 1 THEN
            o(9).sel = 0
        ELSEIF focus = 9 AND o(9).sel = 1 THEN
            o(6).sel = 0
            o(7).sel = 0
            o(8).sel = 0
        END IF

        IF K$ = CHR$(27) OR (focus = 12 AND info <> 0) THEN
            idechange$ = "C"
            EXIT FUNCTION
        END IF

        IF UBOUND(SearchHistory) > 0 THEN
            IF K$ = CHR$(0) + CHR$(72) AND focus = 1 THEN 'Up
                IF ln < UBOUND(SearchHistory) THEN
                    ln = ln + 1
                END IF
                idetxt(o(1).txt) = SearchHistory(ln)
                o(1).issel = -1: o(1).sx1 = 0: o(1).v1 = LEN(idetxt(o(1).txt))
            END IF

            IF K$ = CHR$(0) + CHR$(80) AND focus = 1 THEN 'Down
                IF ln > 1 THEN
                    ln = ln - 1
                ELSE
                    ln = 1
                END IF
                idetxt(o(1).txt) = SearchHistory(ln)
                o(1).issel = -1: o(1).sx1 = 0: o(1).v1 = LEN(idetxt(o(1).txt))
            END IF
        END IF

        IF focus = 11 AND info <> 0 THEN 'change all
            idefindcasesens = o(3).sel
            idefindwholeword = o(4).sel
            idefindbackwards = o(5).sel
            idefindnocomments = o(6).sel
            idefindonlycomments = o(7).sel
            idefindnostrings = o(8).sel
            idefindonlystrings = o(9).sel

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

                DIM comment AS _BYTE, quote AS _BYTE
                IF x THEN
                    FindQuoteComment l$, x, comment, quote
                    IF idefindnocomments <> 0 AND comment THEN x = 0
                    IF idefindnostrings <> 0 AND quote THEN x = 0
                    IF idefindonlycomments <> 0 AND comment = 0 THEN x = 0
                    IF idefindonlystrings <> 0 AND quote = 0 THEN x = 0
                END IF

                IF x THEN
                    l2$ = l2$ + MID$(l$, x1, x - x1) + idechangeto$
                    changed = changed + 1
                    x1 = x + LEN(s$)
                    IF x1 <= LEN(l$) THEN GOTO idechangeall
                END IF

                l2$ = l2$ + MID$(l$, x1, LEN(l$) - x1 + 1)

                IF l2$ <> l$ THEN idesetline y, l2$

            NEXT

            IF changed = 0 THEN idenomatch ELSE idechanged changed: idechangemade = 1
            EXIT FUNCTION

        END IF 'change all


        IF (focus = 10 AND info <> 0) OR K$ = CHR$(13) THEN
            idefindcasesens = o(3).sel
            idefindwholeword = o(4).sel
            idefindbackwards = o(5).sel
            idefindnocomments = o(6).sel
            idefindonlycomments = o(7).sel
            idefindnostrings = o(8).sel
            idefindonlystrings = o(9).sel
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

SUB FindQuoteComment (text$, __cursor AS LONG, c AS _BYTE, q AS _BYTE)
    c = 0: q = 0
    cursor = __cursor
    IF cursor > LEN(text$) THEN cursor = LEN(text$)
    FOR find_k = 1 TO cursor
        SELECT CASE MID$(text$, find_k, 1)
            CASE CHR$(34): q = NOT q
            CASE "'": IF q = 0 THEN c = -1: EXIT FOR
            CASE "R", "r"
                IF q = 0 THEN
                    IF UCASE$(MID$(text$, find_k - 1, 5)) = " REM " OR _
                       UCASE$(MID$(text$, find_k - 1, 5)) = ":REM " OR _
                       (find_k + 2 = LEN(text$) AND UCASE$(MID$(text$, find_k - 1, 4)) = " REM") OR _
                       (find_k + 2 = LEN(text$) AND UCASE$(MID$(text$, find_k - 1, 4)) = ":REM") OR _
                       (find_k = 1 AND UCASE$(LEFT$(text$, 4)) = "REM ") OR _
                       (find_k = 1 AND UCASE$(text$) = "REM") THEN
                        c = -1: EXIT FOR
                    END IF
                END IF
        END SELECT
    NEXT find_k
END SUB

SUB idechanged (totalChanges AS LONG)
    result = idemessagebox("Change Complete", LTRIM$(STR$(totalChanges)) + " substitutions.", "")
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
    DIM sep AS STRING * 1
    sep = CHR$(0)
    '-------- end of generic dialog box header --------

    '-------- init --------
    i = 0
    w = 45
    p.x = 40 - w \ 2
    p.y = idewy - 4
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
        IF alt AND NOT KCTRL THEN idehl = 1 ELSE idehl = 0
        'convert "alt+letter" scancode to letter's ASCII character
        altletter$ = ""
        IF alt AND NOT KCTRL THEN
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
        IF (KSHIFT AND K$ = CHR$(9)) OR (INSTR(_OS$, "MAC") AND K$ = CHR$(25)) THEN focus = focus - 1: K$ = ""
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
        IF sx1 > sx2 THEN SWAP sx1, sx2

        x = x + 2
        'apply selection color change if necessary
        IF o.issel = 0 OR o.foc <> 0 THEN
            LOCATE y, x: PRINT a$;
        ELSE
            FOR ColorCHAR = 1 TO LEN(a$)
                IF ColorCHAR + tx - 2 >= sx1 AND ColorCHAR + tx - 2 < sx2 THEN COLOR 7, 0 ELSE COLOR 0, 7
                LOCATE y, x - 1 + ColorCHAR
                PRINT MID$(a$, ColorCHAR, 1);
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
                        a3$ = " " + a3$
                        IF INSTR(a3$, CHR$(16)) THEN
                            'color formatting: CHR$(16) + CHR$(color)
                            '                  CHR$(16) + CHR$(16) restores default
                            position = 0: character = 0
                            FOR cf = POS(1) TO POS(1) + o.w
                                character = character + 1
                                IF character > LEN(a3$) THEN
                                    PRINT SPACE$(o.w - (POS(1) - (o.par.x + o.x)) + 1);
                                    EXIT FOR
                                END IF
                                IF ASC(a3$, character) = 16 AND character < LEN(a3$) THEN
                                    IF ASC(a3$, character + 1) >= 0 AND ASC(a3$, character + 1) <= 15 THEN
                                        COLOR ASC(a3$, character + 1)
                                        character = character + 1
                                        _CONTINUE
                                    ELSEIF ASC(a3$, character + 1) = 16 THEN
                                        IF o.sel = n THEN COLOR 7 ELSE COLOR 0
                                        character = character + 1
                                        _CONTINUE
                                    END IF
                                END IF
                                position = position + 1
                                PRINT MID$(a3$, character, 1);
                            NEXT
                        ELSE
                            a3$ = a3$ + SPACE$(o.w)
                            a3$ = LEFT$(a3$, o.w)
                            PRINT a3$;
                        END IF
                        'customization specific for the SUBs list, when there are external procedures:
                        IF INSTR(a3$, CHR$(196) + "*") > 0 THEN
                            IF o.sel = n THEN COLOR 2, 0 ELSE COLOR 2, 7
                            LOCATE o.par.y + o.y + y, o.par.x + o.x + 4
                            PRINT "*";
                        END IF
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
        IF o.txt = 0 THEN o.txt = idenewtxt("#OK")
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

FUNCTION idefileexists$(f$)
    l = LEN(f$)
    DO
        IF l < LEN(f$) THEN
            m$ = "File " + CHR$(34) + STRING$(3, 250) + RIGHT$(f$, l) + CHR$(34) + " already exists. Overwrite?"
        ELSE
            m$ = "File " + CHR$(34) + f$ + CHR$(34) + " already exists. Overwrite?"
        END IF
        l = l - 1
    LOOP UNTIL LEN(m$) + 4 < (idewx - 6)

    result = idemessagebox("Save", m$, "#Yes;#No")
    IF result = 1 THEN idefileexists$ = "Y" ELSE idefileexists$ = "N"
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
            REDIM _PRESERVE SearchHistory(1 TO ln)
            SearchHistory(ln) = f$
        END IF
    LOOP
    ln = 0

    i = 0
    idepar p, 60, 11, "Find"
    i = i + 1
    PrevFocus = 1
    o(i).typ = 1
    o(i).y = 2
    o(i).nam = idenewtxt("#Find What")
    o(i).txt = idenewtxt(a2$)
    IF LEN(a2$) > 0 THEN
        o(i).issel = -1
        o(i).sx1 = 0
    END IF
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
    o(i).typ = 4 'check box
    o(i).y = 8
    o(i).nam = idenewtxt("#Ignore 'comments")
    o(i).sel = idefindnocomments

    i = i + 1
    o(i).typ = 4 'check box
    o(i).x = 29
    o(i).y = 8
    o(i).nam = idenewtxt("#Look only in 'comments")
    o(i).sel = idefindonlycomments

    i = i + 1
    o(i).typ = 4 'check box
    o(i).y = 9
    o(i).nam = idenewtxt("Ignore " + CHR$(34) + "s#trings" + CHR$(34))
    o(i).sel = idefindnostrings

    i = i + 1
    o(i).typ = 4 'check box
    o(i).x = 29
    o(i).y = 9
    o(i).nam = idenewtxt("Look only in " + CHR$(34) + "st#rings" + CHR$(34))
    o(i).sel = idefindonlystrings

    i = i + 1
    o(i).typ = 3
    o(i).y = 11
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
        IF alt AND NOT KCTRL THEN idehl = 1 ELSE idehl = 0
        'convert "alt+letter" scancode to letter's ASCII character
        altletter$ = ""
        IF alt AND NOT KCTRL THEN
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
        IF (KSHIFT AND K$ = CHR$(9)) OR (INSTR(_OS$, "MAC") AND K$ = CHR$(25)) THEN focus = focus - 1: K$ = ""
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
            'Always start with TextBox values selected upon getting focus
            PrevFocus = focus
            IF focus = 1 THEN
                o(focus).v1 = LEN(idetxt(o(focus).txt))
                IF o(focus).v1 > 0 THEN o(focus).issel = -1
                o(focus).sx1 = 0
            END IF
        END IF

        IF K$ = CHR$(27) OR (focus = 10 AND info <> 0) THEN
            idefind$ = "C"
            EXIT FUNCTION
        END IF

        'mutually exclusive options
        IF focus = 5 AND o(5).sel = 1 THEN
            o(6).sel = 0
        ELSEIF focus = 6 AND o(6).sel = 1 THEN
            o(5).sel = 0
            o(7).sel = 0
            o(8).sel = 0
        ELSEIF focus = 7 AND o(7).sel = 1 THEN
            o(8).sel = 0
        ELSEIF focus = 8 AND o(8).sel = 1 THEN
            o(5).sel = 0
            o(6).sel = 0
            o(7).sel = 0
        END IF

        IF K$ = CHR$(13) OR (focus = 9 AND info <> 0) THEN
            idefindcasesens = o(2).sel
            idefindwholeword = o(3).sel
            idefindbackwards = o(4).sel
            idefindnocomments = o(5).sel
            idefindonlycomments = o(6).sel
            idefindnostrings = o(7).sel
            idefindonlystrings = o(8).sel
            s$ = idetxt(o(1).txt)
            idefindtext$ = s$
            IdeAddSearched idefindtext
            idefindagain
            EXIT FUNCTION
        END IF

        IF UBOUND(SearchHistory) > 0 THEN
            IF K$ = CHR$(0) + CHR$(72) AND focus = 1 THEN 'Up
                IF ln < UBOUND(SearchHistory) THEN
                    ln = ln + 1
                END IF
                idetxt(o(1).txt) = SearchHistory(ln)
                o(1).issel = -1: o(1).sx1 = 0: o(1).v1 = LEN(idetxt(o(1).txt))
            END IF

            IF K$ = CHR$(0) + CHR$(80) AND focus = 1 THEN 'Down
                IF ln > 1 THEN
                    ln = ln - 1
                ELSE
                    ln = 1
                END IF
                idetxt(o(1).txt) = SearchHistory(ln)
                o(1).issel = -1: o(1).sx1 = 0: o(1).v1 = LEN(idetxt(o(1).txt))
            END IF
        END IF
        'end of custom controls



        mousedown = 0
        mouseup = 0
    LOOP
END FUNCTION

SUB idefindagain
    DIM comment AS _BYTE, quote AS _BYTE

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
        FindQuoteComment l$, x, comment, quote
        IF idefindnocomments <> 0 AND comment THEN x = 0
        IF idefindnostrings <> 0 AND quote THEN x = 0
        IF idefindonlycomments <> 0 AND comment = 0 THEN x = 0
        IF idefindonlystrings <> 0 AND quote = 0 THEN x = 0
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
        LOCATE y, x2: PRINT CHR$(176);
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
            LOCATE y, x2: PRINT CHR$(219);
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
            LOCATE y, x2: PRINT CHR$(219);
            idehbar = x2
            EXIT FUNCTION
        END IF
        IF i = n THEN
            x2 = x + h - 2
            LOCATE y, x2: PRINT CHR$(219);
            idehbar = x2
            EXIT FUNCTION
        END IF
        'between i=1 and i=n
        p! = (i - 1) / (n - 1)
        p! = p! * (h - 4)
        x2 = x + 2 + INT(p!)
        LOCATE y, x2: PRINT CHR$(219);
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

FUNCTION ideinputbox$(title$, caption$, initialvalue$, validinput$, boxwidth, maxlength)


    '-------- generic dialog box header --------
    PCOPY 0, 2
    PCOPY 0, 1
    SCREEN , , 1, 0
    focus = 1
    DIM p AS idedbptype
    DIM o(1 TO 100) AS idedbotype
    DIM sep AS STRING * 1
    sep = CHR$(0)
    '-------- end of generic dialog box header --------

    '-------- init --------

    i = 0

    idepar p, boxwidth, 5, title$

    i = i + 1
    PrevFocus = 1
    o(i).typ = 1
    o(i).y = 2
    o(i).nam = idenewtxt(caption$)
    o(i).txt = idenewtxt(initialvalue$)
    IF LEN(initialvalue$) > 0 THEN o(i).issel = -1
    o(i).sx1 = 0
    o(i).v1 = LEN(initialvalue$)

    i = i + 1
    o(i).typ = 3
    o(i).y = 5
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
        IF alt AND NOT KCTRL THEN idehl = 1 ELSE idehl = 0
        'convert "alt+letter" scancode to letter's ASCII character
        altletter$ = ""
        IF alt AND NOT KCTRL THEN
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
        IF (KSHIFT AND K$ = CHR$(9)) OR (INSTR(_OS$, "MAC") AND K$ = CHR$(25)) THEN focus = focus - 1: K$ = ""
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
            'Always start with TextBox values selected upon getting focus
            PrevFocus = focus
            IF focus = 1 THEN
                o(focus).v1 = LEN(idetxt(o(focus).txt))
                IF o(focus).v1 > 0 THEN o(focus).issel = -1
                o(focus).sx1 = 0
            END IF
        END IF

        IF LEN(validinput$) THEN
            a$ = idetxt(o(1).txt)
            tempA$ = ""
            FOR i = 1 TO LEN(a$)
                IF INSTR(validinput$, MID$(a$, i, 1)) > 0 THEN
                    tempA$ = tempA$ + MID$(a$, i, 1)
                END IF
            NEXT
            idetxt(o(1).txt) = tempA$
        END IF

        IF maxlength THEN
            idetxt(o(1).txt) = LEFT$(idetxt(o(1).txt), maxlength)
        END IF

        IF K$ = CHR$(27) OR (focus = 3 AND info <> 0) THEN
            EXIT FUNCTION
        END IF

        IF K$ = CHR$(13) OR (focus = 2 AND info <> 0) THEN
            ideinputbox$ = idetxt(o(1).txt)
            EXIT FUNCTION
        END IF
        'end of custom controls

        mousedown = 0
        mouseup = 0
    LOOP

END FUNCTION

SUB idenewsf (sf AS STRING)
    'build initial name if word selected
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

    newSF$ = ideinputbox$("New " + sf$, "#Name", a2$, "", 60, 40)

    IF LEN(newSF$) THEN
        y = iden
        y = y + 1: idesetline y, ""
        y = y + 1: idesetline y, sf$ + " " + newSF$
        idesy = y
        y = y + 1: idesetline y, ""
        idecy = y
        y = y + 1: idesetline y, "END " + sf$
        idecx = 1: idesx = 1
        idechangemade = 1
    END IF
END SUB

FUNCTION idenewfolder$(thispath$)
    newfolder$ = ideinputbox$("New Folder", "#Name", "", "", 60, 0)

    IF LEN(newfolder$) THEN
        IF _DIREXISTS(thispath$ + idepathsep$ + newfolder$) THEN
            idenewfolder$ = newfolder$
            EXIT SUB
        END IF
        ideerror = 5
        MKDIR thispath$ + idepathsep$ + newfolder$
        ideerror = 1
        idenewfolder$ = newfolder$
    END IF
END SUB


FUNCTION idenewtxt (a$)
    idetxtlast = idetxtlast + 1
    idetxt$(idetxtlast) = a$
    idenewtxt = idetxtlast
END FUNCTION

SUB idenomatch
    result = idemessagebox("Search complete", "Match not found.", "")
END SUB

FUNCTION idefiledialog$(programname$, mode AS _BYTE)
    STATIC AllFiles

    '-------- generic dialog box header --------
    PCOPY 0, 2
    PCOPY 0, 1
    SCREEN , , 1, 0
    focus = 1
    DIM p AS idedbptype
    DIM o(1 TO 100) AS idedbotype
    DIM sep AS STRING * 1
    sep = CHR$(0)
    '-------- end of generic dialog box header --------

    '-------- init --------
    path$ = idepath$
    filelist$ = idezfilelist$(path$, AllFiles, "")
    pathlist$ = idezpathlist$(path$)

    i = 0
    IF mode = 1 THEN
        idepar p, 70, idewy + idesubwindow - 7, "Open"
    ELSEIF mode = 2 THEN
        idepar p, 70, idewy + idesubwindow - 7, "Save As"
    END IF
    i = i + 1
    PrevFocus = 1
    o(i).typ = 1
    o(i).y = 2
    o(i).nam = idenewtxt("File #Name")
    IF mode = 2 THEN
        o(i).txt = idenewtxt(programname$)
        o(i).issel = -1
        o(i).sx1 = 0
        o(i).v1 = LEN(programname$)
    END IF

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
    o(i).nam = idenewtxt(".#BAS Only")
    IF AllFiles THEN o(i).sel = 0 ELSE o(i).sel = 1
    prevBASOnly = o(i).sel
    i = i + 1
    o(i).typ = 3
    o(i).x = 56
    o(i).y = idewy + idesubwindow - 9
    o(i).txt = idenewtxt("Ne#w Folder")
    i = i + 1
    o(i).typ = 3
    o(i).y = idewy + idesubwindow - 7
    o(i).txt = idenewtxt("#OK" + sep + "#Cancel")
    o(i).dft = 1
    '-------- end of init --------

    '-------- generic init --------
    FOR i = 1 TO 100: o(i).par = p: NEXT 'set parent info of objects
    '-------- end of generic init --------

    IF mode = 1 AND LEN(IdeOpenFile) > 0 THEN f$ = IdeOpenFile: GOTO DirectLoad

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
        IF LEN(a$) > w - 3 THEN a$ = STRING$(3, 250) + RIGHT$(a$, w - 3)
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

            IF mode = 1 THEN
                IF _TOTALDROPPEDFILES > 0 THEN
                    idetxt(o(1).txt) = _DROPPEDFILE$(1)
                    o(1).v1 = LEN(idetxt(o(1).txt))
                    focus = 1
                    _FINISHDROP
                    change = 1
                END IF
            END IF

            _LIMIT 100
        LOOP UNTIL change
        IF alt AND NOT KCTRL THEN idehl = 1 ELSE idehl = 0
        'convert "alt+letter" scancode to letter's ASCII character
        altletter$ = ""
        IF alt AND NOT KCTRL THEN
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
        IF (KSHIFT AND K$ = CHR$(9)) OR (INSTR(_OS$, "MAC") AND K$ = CHR$(25)) THEN focus = focus - 1: K$ = ""
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
            'Always start with TextBox values selected upon getting focus
            PrevFocus = focus
            IF focus = 1 THEN
                o(focus).v1 = LEN(idetxt(o(focus).txt))
                IF o(focus).v1 > 0 THEN o(focus).issel = -1
                o(focus).sx1 = 0
            END IF
        END IF

        IF o(4).sel <> prevBASOnly THEN
            prevBASOnly = o(4).sel
            IF o(4).sel = 0 THEN AllFiles = 1 ELSE AllFiles = 0
            idetxt(o(2).txt) = idezfilelist$(path$, AllFiles, "")
            o(2).sel = -1
            GOTO ideopenloop
        END IF

        IF focus = 5 AND info <> 0 THEN
            'create new folder
            newpath$ = idenewfolder(path$)
            IF LEN(newpath$) THEN
                f$ = newpath$
                GOTO changepath
            ELSE
                GOTO ideopenloop
            END IF
        END IF

        IF K$ = CHR$(27) OR (focus = 7 AND info <> 0) THEN
            idefiledialog$ = "C"
            EXIT FUNCTION
        END IF

        IF idetxt(o(2).stx) <> "" THEN
            idetxt(o(1).txt) = idetxt(o(2).stx)
            o(1).v1 = LEN(idetxt(o(1).txt))
        END IF

        IF focus = 3 THEN
            IF (K$ = CHR$(13) OR info = 1) AND o(3).sel >= 1 THEN
                path$ = idezchangepath(path$, idetxt(o(3).stx))
                idetxt(o(2).txt) = idezfilelist$(path$, AllFiles, "")
                idetxt(o(3).txt) = idezpathlist$(path$)

                o(2).sel = -1
                o(3).sel = -1
                GOTO ideopenloop
            END IF
        END IF

        'load or save file
        IF K$ = CHR$(13) OR (info = 1 AND focus = 2) OR (focus = 6 AND info <> 0) THEN
            f$ = idetxt(o(1).txt)

            IF _FILEEXISTS(f$) THEN GOTO DirectLoad

            IF f$ = "" AND focus = 1 AND K$ = CHR$(13) THEN
                'reset filters
                idetxt(o(2).txt) = idezfilelist$(path$, AllFiles, "")
                o(2).sel = -1
                GOTO ideopenloop
            ELSEIF f$ = "" AND focus = 6 AND info <> 0 THEN
                GOTO ideopenloop
            END IF

            'change path?
            changepath:
            IF _DIREXISTS(path$ + idepathsep$ + f$) THEN
                'check/acquire file path
                path$ = idezgetfilepath$(path$, f$ + idepathsep$) 'note: path ending with pathsep needn't contain a file
                IF LEN(newpath$) = 0 THEN
                    idetxt(o(1).txt) = ""
                    focus = 1
                ELSE
                    newpath$ = ""
                END IF
                idetxt(o(2).txt) = idezfilelist$(path$, AllFiles, "")
                o(2).sel = -1
                idetxt(o(3).txt) = idezpathlist$(path$)
                o(3).sel = -1
                GOTO ideopenloop
            END IF

            'wildcards search
            IF INSTR(f$, "?") > 0 OR INSTR(f$, "*") > 0 THEN
                IF INSTR(f$, "/") > 0 OR INSTR(f$, "\") > 0 THEN
                    'path + wildcards
                    path$ = idezgetfilepath$(path$, f$) 'note: path ending with pathsep needn't contain a file
                    idetxt(o(3).txt) = idezpathlist$(path$)
                    o(3).sel = -1
                END IF
                idetxt(o(1).txt) = f$
                idetxt(o(2).txt) = idezfilelist$(path$, 2, f$)
                o(2).sel = -1
                o(1).v1 = LEN(idetxt(o(1).txt))
                o(1).issel = -1
                o(1).sx1 = 0
                IF LCASE$(RIGHT$(f$, 4)) <> ".bas" THEN
                    AllFiles = 0
                    o(4).sel = 0
                    prevBASOnly = o(4).sel
                END IF
                GOTO ideopenloop
            END IF

            DirectLoad:
            path$ = idezgetfilepath$(path$, f$) 'repeat in case of DirectLoad

            IF mode = 1 THEN
                IF _FILEEXISTS(path$ + idepathsep$ + f$) = 0 THEN
                    'add .bas if not given
                    IF (LCASE$(RIGHT$(f$, 4)) <> ".bas") AND AllFiles = 0 THEN f$ = f$ + ".bas"
                END IF

                'check file exists
                ideerror = 2
                OPEN path$ + idepathsep$ + f$ FOR INPUT AS #150: CLOSE #150

                IF BinaryFormatCheck%(path$, idepathsep$, f$) > 0 THEN
                    IF LEN(IdeOpenFile) THEN
                        idefiledialog$ = "C"
                        EXIT FUNCTION
                    ELSE
                        info = 0: GOTO ideopenloop
                    END IF
                END IF

                'load file
                ideerror = 3
                idet$ = MKL$(0) + MKL$(0): idel = 1: ideli = 1: iden = 1: IdeBmkN = 0
                idesx = 1
                idesy = 1
                idecx = 1
                idecy = 1
                ideselect = 0
                idefocusline = 0
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
                ideprogname = f$: _TITLE ideprogname + " - " + WindowTitle
                listOfCustomKeywords$ = LEFT$(listOfCustomKeywords$, customKeywordsLength)
                idepath$ = path$
                IdeAddRecent idepath$ + idepathsep$ + ideprogname$
                IdeImportBookmarks idepath$ + idepathsep$ + ideprogname$
                EXIT FUNCTION
            ELSEIF mode = 2 THEN
                IF FileHasExtension(f$) = 0 THEN f$ = f$ + ".bas"

                ideerror = 3
                OPEN path$ + idepathsep$ + f$ FOR BINARY AS #150
                ideerror = 1
                IF LOF(150) THEN
                    CLOSE #150
                    a$ = idefileexists(f$)
                    IF a$ = "N" THEN
                        idefiledialog$ = "C"
                        EXIT FUNCTION 'user didn't agree to overwrite
                    END IF
                ELSE
                    CLOSE #150
                END IF
                ideprogname$ = f$: _TITLE ideprogname + " - " + WindowTitle
                idesave path$ + idepathsep$ + f$
                idepath$ = path$
                IdeAddRecent idepath$ + idepathsep$ + ideprogname$
                IdeSaveBookmarks idepath$ + idepathsep$ + ideprogname$
                EXIT FUNCTION
            END IF
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
    _RESIZE OFF
END SUB

FUNCTION iderestore$
    PCOPY 3, 0
    PCOPY 0, 2
    PCOPY 0, 1
    SCREEN , , 1, 0
    result = idemessagebox("Backup found", "Recover program from auto-saved backup?", "#Yes;#No")
    IF result = 1 THEN iderestore$ = "Y" ELSE iderestore$ = "N"
END FUNCTION

FUNCTION ideclearhistory$ (WhichHistory$)
    SELECT CASE WhichHistory$
        CASE "SEARCH": t$ = "Clear search history": m$ = "This cannot be undone. Proceed?"
        CASE "FILES": t$ = "Clear recent files": m$ = "This cannot be undone. Proceed?"
    END SELECT
    result = idemessagebox(t$, m$, "#Yes;#No")
    IF result = 1 THEN ideclearhistory$ = "Y" ELSE ideclearhistory$ = "N"
END FUNCTION

SUB idesave (f$)
    ideerror = 6
    OPEN f$ FOR OUTPUT AS #151
    ideerror = 1
    FOR i = 1 TO iden
        a$ = idegetline(i)
        PRINT #151, a$
    NEXT
    CLOSE #151
    IdeSaveBookmarks f$
    ideunsaved = 0
END SUB

FUNCTION idesavenow$
    m$ = "Program is not saved. Save it now?"
    result = idemessagebox("", m$, "#Yes;#No;#Cancel")
    SELECT CASE result
        CASE 1: idesavenow$ = "Y"
        CASE 2: idesavenow$ = "N"
        CASE 0, 3: idesavenow$ = "C"
    END SELECT
END FUNCTION

SUB idesetline (i, text$)

    text$ = RTRIM$(text$)

    IF i <> -1 THEN idegotoline i
    textlen = LEN(text$)
    idet$ = LEFT$(idet$, ideli - 1) + MKL$(textlen) + text$ + MKL$(textlen) + RIGHT$(idet$, LEN(idet$) - ideli + 1 - CVL(MID$(idet$, ideli, 4)) - 8)

END SUB

FUNCTION timeElapsedSince! (startTime!)
    IF startTime! > TIMER THEN startTime! = startTime! - 86400
    timeElapsedSince! = TIMER - startTime!
END FUNCTION

SUB ideshowtext

    _PALETTECOLOR 1, IDEBackgroundColor, 0
    _PALETTECOLOR 2, _RGB32(84, 84, 84), 0 'dark gray - help system and interface details
    _PALETTECOLOR 5, IDEBracketHighlightColor, 0
    _PALETTECOLOR 6, IDEBackgroundColor2, 0
    _PALETTECOLOR 8, IDENumbersColor, 0
    _PALETTECOLOR 10, IDEMetaCommandColor, 0
    _PALETTECOLOR 11, IDECommentColor, 0
    _PALETTECOLOR 12, IDEKeywordColor, 0
    _PALETTECOLOR 13, IDETextColor, 0
    _PALETTECOLOR 14, IDEQuoteColor, 0

    char.sep$ = CHR$(34) + " =<>+-/\^:;,*()'"
    initialNum.char$ = "0123456789-.&"
    num.char$ = "0123456789EDed+-.`%&!#~HBOhboACFacf"

    DIM ideshowtext_comment AS _BYTE, ideshowtext_quote AS _BYTE

    STATIC prevListOfCustomWords$, manualList AS _BYTE
    DIM startTime AS SINGLE

    startTime = TIMER

    IF NOT DisableSyntaxHighlighter THEN
        IF idefocusline <> 0 THEN
            'there's an error and compilation is halted,
            'so we'll build the list of subs/functions
            'for proper highlighting:
            IF idechangemade THEN manualList = 0
            IF manualList = 0 THEN
                manualList = -1
                listOfCustomKeywords$ = LEFT$(listOfCustomKeywords$, customKeywordsLength)
                FOR y = 1 TO iden
                    a$ = UCASE$(LTRIM$(RTRIM$(idegetline(y))))
                    sf = 0
                    IF LEFT$(a$, 4) = "SUB " THEN sf = 1
                    IF LEFT$(a$, 9) = "FUNCTION " THEN sf = 2
                    IF sf THEN
                        IF RIGHT$(a$, 7) = " STATIC" THEN
                            a$ = RTRIM$(LEFT$(a$, LEN(a$) - 7))
                        END IF

                        IF sf = 1 THEN
                            a$ = MID$(a$, 5)
                        ELSE
                            a$ = MID$(a$, 10)
                        END IF

                        a$ = LTRIM$(RTRIM$(a$))
                        x = INSTR(a$, "(")
                        IF x THEN
                            a$ = RTRIM$(LEFT$(a$, x - 1))
                        END IF

                        'attempt to cleanse n$, just in case there are any comments or other unwanted stuff
                        FOR CleanseN = 1 TO LEN(a$)
                            SELECT CASE MID$(a$, CleanseN, 1)
                                CASE " ", "'", ":"
                                    a$ = LEFT$(a$, CleanseN - 1)
                                    EXIT FOR
                            END SELECT
                        NEXT
                        listOfCustomKeywords$ = listOfCustomKeywords$ + "@" + removesymbol2$(a$) + "@"
                    END IF
                NEXT
            END IF
        ELSE
            manualList = 0
        END IF

        IF prevListOfCustomWords$ <> listOfCustomKeywords$ THEN
            IF manualList = 0 THEN
                DO
                    atSign = INSTR(atSign + 1, listOfCustomKeywords$, "@")
                    nextAt = INSTR(atSign + 1, listOfCustomKeywords$, "@")
                    IF nextAt = 0 THEN EXIT DO
                    IF atSign > customKeywordsLength THEN
                        checkKeyword$ = removesymbol2$(MID$(listOfCustomKeywords$, atSign + 1, (nextAt - atSign) - 1))
                        IF LEN(checkKeyword$) THEN
                            hashchkflags = HASHFLAG_RESERVED + HASHFLAG_CONSTANT
                            hashchkflags = hashchkflags + HASHFLAG_FUNCTION
                            hashres1 = HashFind(checkKeyword$, hashchkflags, hashresflags, hashresref)
                            IF hashres1 <> 0 THEN hashres1 = 1
                            hashchkflags = HASHFLAG_RESERVED + HASHFLAG_CONSTANT
                            hashchkflags = hashchkflags + HASHFLAG_SUB
                            hashres2 = HashFind(checkKeyword$, hashchkflags, hashresflags, hashresref)
                            IF hashres2 <> 0 THEN hashres2 = 1
                            IF hashres1 + hashres2 = 0 THEN
                                'remove this custom keyword if not registered
                                MID$(listOfCustomKeywords$, atSign + 1, (nextAt - atSign) - 1) = STRING$(LEN(checkKeyword$), "@")
                            END IF
                        END IF
                    END IF
                LOOP
            END IF

            FOR i = 1 TO LEN(listOfCustomKeywords$)
                checkChar = ASC(listOfCustomKeywords$, i)
                IF checkChar = 64 THEN
                    IF RIGHT$(tempList$, 1) <> "@" THEN tempList$ = tempList$ + "@"
                ELSE
                    tempList$ = tempList$ + CHR$(checkChar)
                END IF
            NEXT
            listOfCustomKeywords$ = tempList$

            DO WHILE INSTR(listOfCustomKeywords$, fix046$)
                x = INSTR(listOfCustomKeywords$, fix046$)
                listOfCustomKeywords$ = LEFT$(listOfCustomKeywords$, x - 1) + "." + RIGHT$(listOfCustomKeywords$, LEN(listOfCustomKeywords$) - x + 1 - LEN(fix046$))
            LOOP

            prevListOfCustomWords$ = listOfCustomKeywords$
        END IF
    END IF


    cc = -1

    IF idecx < idesx THEN idesx = idecx
    IF idecy < idesy THEN idesy = idecy
    IF (idecx + maxLineNumberLength) - idesx >= (idewx - 2) THEN idesx = (idecx + maxLineNumberLength) - (idewx - 3)
    IF idecy - idesy >= (idewy - 8) THEN idesy = idecy - (idewy - 9)

    sy1 = ideselecty1
    sy2 = idecy
    IF sy1 > sy2 THEN SWAP sy1, sy2
    sx1 = ideselectx1
    sx2 = idecx
    IF sx1 > sx2 THEN SWAP sx1, sx2

    l = idesy
    EnteringRGB = 0

    IF NOT DisableSyntaxHighlighter THEN
        idecy_multilinestart = 0
        idecy_multilineend = 0
        a$ = idegetline(idecy)
        FindQuoteComment a$, LEN(a$), ideshowtext_comment, ideshowtext_quote
        IF RIGHT$(a$, 1) = "_" AND ideshowtext_comment = 0 THEN
            'Find the beginning of the multiline
            FOR idecy_i = idecy - 1 TO 1 STEP -1
                b$ = idegetline(idecy_i)
                FindQuoteComment b$, LEN(b$), ideshowtext_comment, ideshowtext_quote
                IF RIGHT$(b$, 1) <> "_" OR ideshowtext_comment = -1 THEN idecy_multilinestart = idecy_i + 1: EXIT FOR
            NEXT
            IF idecy_multilinestart = 0 THEN idecy_multilinestart = 1

            'Find the end of the multiline
            FOR idecy_i = idecy + 1 TO iden
                b$ = idegetline(idecy_i)
                FindQuoteComment b$, LEN(b$), ideshowtext_comment, ideshowtext_quote
                IF RIGHT$(b$, 1) <> "_" OR ideshowtext_comment = -1 THEN idecy_multilineend = idecy_i: EXIT FOR
            NEXT
            IF idecy_multilineend = 0 THEN idecy_multilinestart = iden
        ELSE
            IF idecy > 1 THEN b$ = idegetline(idecy - 1) ELSE b$ = ""
            FindQuoteComment b$, LEN(b$), ideshowtext_comment, ideshowtext_quote
            IF RIGHT$(b$, 1) = "_" AND ideshowtext_comment = 0 THEN
                idecy_multilineend = idecy

                'Find the beginning of the multiline
                FOR idecy_i = idecy - 1 TO 1 STEP -1
                    b$ = idegetline(idecy_i)
                    FindQuoteComment b$, LEN(b$), ideshowtext_comment, ideshowtext_quote
                    IF RIGHT$(b$, 1) <> "_" OR ideshowtext_comment = -1 THEN idecy_multilinestart = idecy_i + 1: EXIT FOR
                NEXT
                IF idecy_multilinestart = 0 THEN idecy_multilinestart = 1
            END IF
        END IF

        IF idecy > 1 THEN b$ = idegetline(idecy - 1) ELSE b$ = ""

        ActiveINCLUDELink = 0

        FOR y = 0 TO (idewy - 9)
            LOCATE y + 3, 1
            COLOR 7, 1
            PRINT CHR$(179); 'clear prev bookmarks from lhs

            IF ShowLineNumbers THEN GOSUB ShowLineNumber

            IF l = idefocusline AND idecy <> l THEN
                COLOR 7, 4 'Line with error gets a red background
            ELSEIF idecy = l OR (l >= idecy_multilinestart AND l <= idecy_multilineend) THEN
                IF HideCurrentLineHighlight = 0 AND IdeSystem = 1 THEN COLOR 7, 6 'Highlight the current line
            ELSE
                COLOR 7, 1 'Regular text color
            END IF

            IF l <= iden THEN
                DO UNTIL l < UBOUND(InValidLine) 'make certain we have enough InValidLine elements to cover us in case someone scrolls QB64
                    REDIM _PRESERVE InValidLine(UBOUND(InValidLine) + 1000) AS _BYTE '   to the end of a program before the IDE has finished
                LOOP '                                                      verifying the code and growing the array during the IDE passes.

                a$ = idegetline(l)
                link_idecx = 0
                rgb_idecx = 0
                IF l = idecy THEN
                    IF idecx <= LEN(a$) AND idecx >= 1 THEN
                        cc = ASC(a$, idecx)
                        IF cc = 32 THEN
                            IF LTRIM$(LEFT$(a$, idecx)) = "" THEN cc = -1
                        END IF
                    END IF

                    'Check if the cursor is positioned inside a comment or
                    'quotation marks:
                    FindQuoteComment a$, idecx, ideshowtext_comment, ideshowtext_quote
                    idecx_comment = ideshowtext_comment
                    idecx_quote = ideshowtext_quote

                    'Check if we're on a bracket, to highlight it and its match
                    brackets = 0
                    bracket1 = 0
                    bracket2 = 0
                    IF idecx_comment + idecx_quote = 0 AND brackethighlight = -1 THEN
                        inquote = 0
                        comment = 0
                        IF MID$(a$, idecx, 1) = "(" THEN
                            brackets = 1
                            bracket1 = idecx
                            ScanBracket2:
                            FOR k = bracket1 + 1 TO LEN(a$)
                                SELECT CASE MID$(a$, k, 1)
                                    CASE CHR$(34)
                                        inquote = NOT inquote
                                    CASE "'"
                                        IF inquote = 0 THEN comment = -1: EXIT FOR
                                END SELECT
                                IF MID$(a$, k, 1) = ")" AND inquote = 0 THEN
                                    brackets = brackets - 1
                                    IF brackets = 0 THEN bracket2 = k: EXIT FOR
                                ELSEIF MID$(a$, k, 1) = "(" AND inquote = 0 THEN
                                    brackets = brackets + 1
                                END IF
                            NEXT
                        ELSEIF MID$(a$, idecx - 1, 1) = "(" AND MID$(a$, idecx, 1) <> CHR$(34) THEN
                            brackets = 1
                            bracket1 = idecx - 1
                            GOTO ScanBracket2
                        ELSEIF MID$(a$, idecx, 1) = ")" THEN
                            brackets = 1
                            bracket2 = idecx
                            ScanBracket1:
                            FOR k = bracket2 - 1 TO 1 STEP -1
                                SELECT CASE MID$(a$, k, 1)
                                    CASE CHR$(34)
                                        inquote = NOT inquote
                                END SELECT
                                IF MID$(a$, k, 1) = "(" AND inquote = 0 THEN
                                    brackets = brackets - 1
                                    IF brackets = 0 THEN bracket1 = k: EXIT FOR
                                ELSEIF MID$(a$, k, 1) = ")" AND inquote = 0 THEN
                                    brackets = brackets + 1
                                END IF
                            NEXT
                        ELSEIF MID$(a$, idecx - 1, 1) = ")" AND MID$(a$, idecx, 1) <> CHR$(34) THEN
                            brackets = 1
                            bracket2 = idecx - 1
                            GOTO ScanBracket1
                        END IF
                    END IF

                    'If the user is typing on the current line and has just inserted
                    'an _RGB(, _RGB32(, _RGBA( or _RGBA32(, we'll offer the RGB
                    'color mixer.
                    a2$ = UCASE$(a$)
                    IF idecx = LEN(a$) + 1 AND idecx_comment + idecx_quote = 0 THEN
                        IF (RIGHT$(a2$, 5) = "_RGB(" OR _
                           RIGHT$(a2$, 7) = "_RGB32(" OR _
                           RIGHT$(a2$, 6) = "_RGBA(" OR _
                           RIGHT$(a2$, 8) = "_RGBA32(") OR _
                           ((RIGHT$(a2$, 4) = "RGB(" OR _
                           RIGHT$(a2$, 6) = "RGB32(" OR _
                           RIGHT$(a2$, 5) = "RGBA(" OR _
                           RIGHT$(a2$, 7) = "RGBA32(") AND qb64prefix_set = 1) THEN
                            rgb_idecx = LEN(a$)
                            a$ = a$ + " --> Hit Shift+ENTER to open the RGB mixer"
                            EnteringRGB = -1
                        END IF
                    ELSEIF idecx_comment + idecx_quote = 0 THEN
                        IF (MID$(a2$, idecx - 5, 5) = "_RGB(" OR _
                           MID$(a2$, idecx - 7, 7) = "_RGB32(" OR _
                           MID$(a2$, idecx - 6, 6) = "_RGBA(" OR _
                           MID$(a2$, idecx - 8, 8) = "_RGBA32(") OR _
                           ((MID$(a2$, idecx - 4, 4) = "RGB(" OR _
                           MID$(a2$, idecx - 6, 6) = "RGB32(" OR _
                           MID$(a2$, idecx - 5, 5) = "RGBA(" OR _
                           MID$(a2$, idecx - 7, 7) = "RGBA32(") AND qb64prefix_set = 1) THEN
                            IF INSTR("0123456789", MID$(a2$, idecx, 1)) = 0 THEN EnteringRGB = -1
                        END IF
                    END IF

                    FindInclude = INSTR(a2$, "$INCLUDE")
                    IF FindInclude > 0 THEN
                        link_idecx = LEN(a$)
                        FindApostrophe1 = INSTR(FindInclude + 8, a2$, "'")
                        FindApostrophe2 = INSTR(FindApostrophe1 + 1, a2$, "'")
                        ActiveINCLUDELinkFile = MID$(a$, FindApostrophe1 + 1, FindApostrophe2 - FindApostrophe1 - 1)
                        p$ = idepath$ + pathsep$
                        f$ = p$ + ActiveINCLUDELinkFile
                        IF _FILEEXISTS(f$) THEN a$ = a$ + " --> Double-click to open": ActiveINCLUDELink = idecy
                    END IF
                END IF 'l = idecy

                a2$ = SPACE$(idesx + (idewx - 3))
                MID$(a2$, 1) = a$
            ELSE
                a2$ = SPACE$((idewx - 2))
            END IF

            'Syntax highlighter
            inquote = 0
            metacommand = 0
            comment = 0
            isKeyword = 0: oldChar$ = ""
            isCustomKeyword = 0
            multiHighlightLength = 0
            prevBG% = _BACKGROUNDCOLOR

            FOR m = 1 TO LEN(a2$) 'print to the screen while checking required color changes
                IF timeElapsedSince(startTime) > 1 THEN
                    result = idemessagebox("Syntax Highlighter Disabled", "Syntax Highlighter has been disabled to avoid locking up the IDE.\nThis may have been caused by lines that are too long.\nYou can reenable the Highlighter in the 'Options' menu.", "")
                    DisableSyntaxHighlighter = -1
                    WriteConfigSetting "'[GENERAL SETTINGS]", "DisableSyntaxHighlighter", "TRUE"
                    menu$(OptionsMenuID, OptionsMenuDisableSyntax) = CHR$(7) + "Disable Syntax #Highlighter"
                    GOTO noSyntaxHighlighting
                END IF
                IF m > idesx + idewx - 2 THEN EXIT FOR 'stop printing when off screen
                IF ideselect = 1 AND LEN(ideCurrentSingleLineSelection) > 0 AND multiHighlightLength = 0 AND multihighlight = -1 THEN
                    IF LCASE$(MID$(a2$, m, LEN(ideCurrentSingleLineSelection))) = LCASE$(ideCurrentSingleLineSelection) THEN
                        'the current selection was found at this spot. Multi-highlight takes place:
                        IF m > 1 THEN
                            IF INSTR(char.sep$, MID$(a2$, m - 1, 1)) > 0 THEN
                                IF m + LEN(ideCurrentSingleLineSelection) < LEN(a2$) AND _
                                    (INSTR(char.sep$, MID$(a2$, m + LEN(ideCurrentSingleLineSelection), 1)) > 0 OR _
                                     MID$(a2$, m + LEN(ideCurrentSingleLineSelection), 1) = ".") THEN
                                    multiHighlightLength = LEN(ideCurrentSingleLineSelection)
                                ELSEIF m + LEN(ideCurrentSingleLineSelection) >= LEN(a2$) THEN
                                    multiHighlightLength = LEN(ideCurrentSingleLineSelection)
                                END IF
                            END IF
                        ELSE
                            IF m + LEN(ideCurrentSingleLineSelection) < LEN(a2$) AND _
                                (INSTR(char.sep$, MID$(a2$, m + LEN(ideCurrentSingleLineSelection), 1)) > 0 OR _
                                 MID$(a2$, m + LEN(ideCurrentSingleLineSelection), 1) = ".") THEN
                                multiHighlightLength = LEN(ideCurrentSingleLineSelection)
                            ELSEIF m + LEN(ideCurrentSingleLineSelection) >= LEN(a2$) THEN
                                multiHighlightLength = LEN(ideCurrentSingleLineSelection)
                            END IF
                        END IF
                    END IF
                END IF

                thisChar$ = MID$(a2$, m, 1)

                IF comment = 0 THEN
                    SELECT CASE thisChar$
                        CASE CHR$(34): inquote = NOT inquote
                        CASE "'": IF inquote = 0 THEN comment = -1
                    END SELECT
                END IF

                COLOR 13

                IF InValidLine(l) THEN COLOR 7: GOTO SkipSyntaxHighlighter

                IF (LEN(oldChar$) > 0 OR m = 1) AND inquote = 0 AND isKeyword = 0 THEN
                    IF INSTR(initialNum.char$, thisChar$) > 0 AND oldChar$ <> ")" AND (INSTR(char.sep$, oldChar$) > 0 OR oldChar$ = "?") THEN
                        'a number literal
                        checkKeyword$ = ""
                        is_Number = 0

                        FOR i = m TO LEN(a2$)
                            IF INSTR(num.char$, MID$(a2$, i, 1)) = 0 THEN EXIT FOR
                            checkKeyword$ = checkKeyword$ + MID$(a2$, i, 1)
                        NEXT

                        IF checkKeyword$ = "-" OR checkKeyword$ = "." OR checkKeyword$ = "&" THEN
                            checkKeyword$ = ""
                        ELSE
                            IF UCASE$(LEFT$(checkKeyword$, 2)) = "&H" OR UCASE$(LEFT$(checkKeyword$, 2)) = "&O" OR UCASE$(LEFT$(checkKeyword$, 2)) = "&B" OR isnumber(checkKeyword$) THEN
                                is_Number = -1
                                isKeyword = LEN(checkKeyword$)
                            END IF
                        END IF
                        GOTO setOldChar
                    END IF

                    IF (INSTR(char.sep$, oldChar$) > 0 OR oldChar$ = "?") AND INSTR(char.sep$, thisChar$) = 0 THEN
                        'a new "word" begins; check if it's an internal keyword
                        checkKeyword$ = ""
                        right.sep$ = ""
                        FOR i = m TO LEN(a2$)
                            IF INSTR(char.sep$, MID$(a2$, i, 1)) > 0 THEN right.sep$ = MID$(a2$, i, 1): EXIT FOR
                            checkKeyword$ = checkKeyword$ + MID$(a2$, i, 1)
                        NEXT
                        IF comment = 0 AND LEFT$(checkKeyword$, 1) = "?" THEN isKeyword = 1: GOTO setOldChar
                        checkKeyword$ = UCASE$(checkKeyword$)
                        IF INSTR(listOfKeywords$, "@" + checkKeyword$ + "@") > 0 OR _
                           (qb64prefix_set = 1 AND INSTR(listOfKeywords$, "@_" + checkKeyword$ + "@") > 0) THEN
                            'special cases
                            IF checkKeyword$ = "$END" THEN
                                IF UCASE$(MID$(a2$, m, 7)) = "$END IF" THEN checkKeyword$ = "$END IF"
                            ELSEIF checkKeyword$ = "THEN" AND _
                                    (UCASE$(LEFT$(LTRIM$(a2$), 3)) = "$IF" OR _
                                    UCASE$(LEFT$(LTRIM$(a2$), 7)) = "$ELSEIF") THEN
                                metacommand = -1
                            ELSEIF checkKeyword$ = "$ASSERTS" THEN
                                IF UCASE$(_TRIM$(a2$)) = "$ASSERTS:CONSOLE" THEN
                                    checkKeyword$ = "$ASSERTS:CONSOLE"
                                END IF
                            END IF
                            isKeyword = LEN(checkKeyword$)
                        ELSEIF INSTR(listOfCustomKeywords$, "@" + removesymbol2$(checkKeyword$) + "@") > 0 THEN
                            isCustomKeyword = -1
                            isKeyword = LEN(checkKeyword$)
                        END IF
                    END IF
                END IF
                setOldChar:
                oldChar$ = thisChar$

                IF isKeyword > 0 AND keywordHighlight THEN
                    IF is_Number THEN
                        COLOR 8
                    ELSEIF isCustomKeyword THEN
                        COLOR 10
                    ELSE
                        COLOR 12
                    END IF
                    IF LEFT$(checkKeyword$, 1) = "$" THEN metacommand = -1
                END IF

                IF comment THEN
                    COLOR 11
                    IF metacommand AND (checkKeyword$ = "$INCLUDE" OR checkKeyword$ = "$DYNAMIC" _
                        OR checkKeyword$ = "$STATIC") THEN COLOR 10
                ELSEIF metacommand THEN
                    COLOR 10
                ELSEIF inquote OR thisChar$ = CHR$(34) THEN
                    COLOR 14
                END IF

                SkipSyntaxHighlighter:

                IF l = idecy AND ((link_idecx > 0 AND m > link_idecx) OR _
                   (rgb_idecx > 0 AND m > rgb_idecx)) THEN COLOR 10

                IF l = idecy AND (m = bracket1 OR m = bracket2) THEN
                    COLOR , 5
                ELSEIF multiHighlightLength > 0 AND multihighlight = -1 THEN
                    multiHighlightLength = multiHighlightLength - 1
                    COLOR , 5
                ELSE
                    COLOR , prevBG%
                END IF

                IF ShowLineNumbers THEN
                    IF (2 + m - idesx) + maxLineNumberLength >= 2 + maxLineNumberLength AND (2 + m - idesx) + maxLineNumberLength < idewx THEN
                        LOCATE y + 3, (2 + m - idesx) + maxLineNumberLength
                        PRINT thisChar$;
                    END IF
                ELSE
                    IF 2 + m - idesx >= 2 AND 2 + m - idesx < idewx THEN
                        LOCATE y + 3, 2 + m - idesx
                        PRINT thisChar$;
                    END IF
                END IF

                'Restore BG color in case a matching bracket was printed with different BG
                IF l = idecy THEN COLOR , 6
                IF isKeyword > 0 THEN isKeyword = isKeyword - 1
                IF isKeyword = 0 THEN checkKeyword$ = "": metacommand = 0: is_Number = 0: isCustomKeyword = 0
            NEXT m

            'apply selection color change if necessary
            IF (IdeSystem = 1 OR IdeSystem = 2) AND ideselect <> 0 THEN
                IF l >= sy1 AND l <= sy2 THEN
                    IF sy1 = sy2 THEN 'single line select
                        COLOR 1, 7
                        x2 = idesx
                        FOR x = 2 + maxLineNumberLength TO (idewx - 2)
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
                        LOCATE y + 3, 2 + maxLineNumberLength
                        COLOR 1, 7

                        FOR x = idesx TO idesx + idewx - (2 + maxLineNumberLength)
                            PRINT MID$(a2$, x, 1);
                        NEXT

                        COLOR 7, 1
                        nofinalselect:
                    END IF
                END IF
            END IF

            l = l + 1
        NEXT
    ELSE
        noSyntaxHighlighting:
        'original SUB ideshowtext routine:
        COLOR 13, 1
        l = idesy
        FOR y = 0 TO (idewy - 9)
            LOCATE y + 3, 1
            COLOR 7, 1
            PRINT CHR$(179); 'clear prev bookmarks from lhs

            IF ShowLineNumbers THEN GOSUB ShowLineNumber

            IF l = idefocusline AND idecy <> l THEN COLOR 13, 4 ELSE COLOR 13, 1
            LOCATE y + 3, 2 + maxLineNumberLength

            IF l <= iden THEN
                a$ = idegetline(l)
                a2$ = SPACE$(idesx + (idewx - 3) - maxLineNumberLength)
                MID$(a2$, 1) = a$
                a2$ = RIGHT$(a2$, (idewx - 2) - maxLineNumberLength)
            ELSE
                a2$ = SPACE$((idewx - 2) - maxLineNumberLength)
            END IF
            PRINT a2$;

            IF l = idecy THEN
                IF idecx <= LEN(a$) AND idecx >= 1 THEN
                    cc = ASC(a$, idecx)
                    IF cc = 32 THEN
                        IF LTRIM$(LEFT$(a$, idecx)) = "" THEN cc = -1
                    END IF
                END IF
            END IF

            'apply selection color change if necessary
            IF ideselect THEN
                IF l >= sy1 AND l <= sy2 THEN
                    IF sy1 = sy2 THEN 'single line select
                        COLOR 1, 7
                        x2 = idesx
                        FOR x = 2 + maxLineNumberLength TO (idewx - 2)
                            IF x2 >= sx1 AND x2 < sx2 THEN
                                a = SCREEN(y + 3, x): LOCATE y + 3, x: PRINT CHR$(a);
                            END IF
                            x2 = x2 + 1
                        NEXT
                        COLOR 7, 1
                    ELSE 'multiline select
                        IF idecx = 1 AND l = sy2 AND idecy > sy1 THEN GOTO nofinalselect0
                        LOCATE y + 3, 2 + maxLineNumberLength
                        COLOR 1, 7: PRINT a2$;
                        COLOR 7, 1
                        nofinalselect0:
                    END IF
                END IF
            END IF

            l = l + 1
        NEXT
    END IF

    COLOR 7, 1
    FOR b = 1 TO IdeBmkN
        y = IdeBmk(b).y
        IF y >= idesy AND y <= idesy + (idewy - 9) THEN
            LOCATE 3 + y - idesy, 1: PRINT CHR$(197);
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

    SCREEN , , 0, 0: LOCATE idecy - idesy + 3, maxLineNumberLength + idecx - idesx + 2: SCREEN , , 3, 0

    EXIT SUB
    ShowLineNumber:
    IF ShowLineNumbersUseBG THEN COLOR , 6
    PRINT SPACE$(maxLineNumberLength);
    IF l <= iden THEN
        l2$ = STR$(l)
        IF POS(1) - (LEN(l2$) + 1) >= 2 THEN
            LOCATE y + 3, POS(1) - (LEN(l2$) + 1)
            PRINT l2$;
        END IF
    END IF
    IF ShowLineNumbersSeparator THEN LOCATE y + 3, 1 + maxLineNumberLength: PRINT CHR$(179);
    COLOR , 1
    RETURN

END SUB

FUNCTION idesubs$

    '-------- generic dialog box header --------
    PCOPY 0, 2
    PCOPY 0, 1
    SCREEN , , 1, 0
    focus = 1
    DIM p AS idedbptype
    DIM o(1 TO 100) AS idedbotype
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
        IF LEN(a2$) > 1 THEN
            DO UNTIL alphanumeric(ASC(RIGHT$(a2$, 1)))
                a2$ = LEFT$(a2$, LEN(a2$) - 1) 'removes sigil, if any
            LOOP
        END IF
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

    IF LEN(l$) <= 22 THEN
        l$ = l$ + SPACE$(22 - LEN(l$))
    ELSE
        l$ = LEFT$(l$, 19) + STRING$(3, 250)
    END IF

    lSized$ = l$
    lSorted$ = l$
    lSortedSized$ = l$

    REDIM TotalLines(0) AS LONG

    TotalSUBs = 0
    ModuleSize = 0 'in lines
    SortedSubsFlag = idesortsubs
    SubClosed = 0

    FOR y = 1 TO iden
        a$ = idegetline(y)
        IF SubClosed = 0 THEN ModuleSize = ModuleSize + 1
        a$ = LTRIM$(RTRIM$(a$))
        sf = 0
        nca$ = UCASE$(a$)
        IF LEFT$(nca$, 8) = "DECLARE " AND INSTR(nca$, " LIBRARY") > 0 THEN InsideDECLARE = -1
        IF LEFT$(nca$, 11) = "END DECLARE" THEN InsideDECLARE = 0
        IF LEFT$(nca$, 4) = "SUB " THEN sf = 1: sf$ = "SUB   "
        IF LEFT$(nca$, 9) = "FUNCTION " THEN sf = 2: sf$ = "FUNC  "
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
            FOR CleanseN = 1 TO LEN(n$)
                SELECT CASE MID$(n$, CleanseN, 1)
                    CASE " ", "'", ":"
                        n$ = LEFT$(n$, CleanseN - 1)
                        EXIT FOR
                END SELECT
            NEXT

            'If the user currently has the cursor over a SUB/FUNC name, let's highlight it
            'instead of the currently in edition, for a quick link functionality:
            n2$ = n$
            IF LEN(n2$) > 1 THEN
                DO UNTIL alphanumeric(ASC(RIGHT$(n2$, 1)))
                    n2$ = LEFT$(n$, LEN(n2$) - 1) 'removes sigil, if any
                LOOP
            END IF
            IF a2$ = UCASE$(n2$) THEN PreferCurrentCursorSUBFUNC = (LEN(ly$) / 4)

            IF InsideDECLARE = -1 THEN
                n$ = "*" + n$
                FoundExternalSUBFUNC = -1
            ELSE
                SubClosed = 0
                ModuleSize = 0
            END IF

            IF TotalSUBs = 0 THEN
                l$ = l$ + "  Type  Arguments"
                lSorted$ = l$
                lSized$ = lSized$ + " Line count  Type  Arguments" + sep
                lSortedSized$ = lSortedSized$ + " Line count  Type  Arguments"
            ELSE
                num$ = LTRIM$(STR$(TotalLines(TotalSUBs)))
                IF pInsideDECLARE THEN num$ = "external"
                lSized$ = lSized$ + CHR$(195) + CHR$(196) + pn$ + "  " + _
                          CHR$(16) + CHR$(2) + SPACE$(9 - LEN(num$)) + num$ + "  " _
                          + psf$ + CHR$(16) + CHR$(16) + pargs$ + sep
            END IF

            IF LEN(n$) <= 20 THEN
                n$ = n$ + SPACE$(20 - LEN(n$))
            ELSE
                n$ = LEFT$(n$, 17) + STRING$(3, 250)
            END IF
            IF LEN(args$) <= (idewx - 41) THEN
                args$ = args$ + SPACE$((idewx - 41) - LEN(args$))
            ELSE
                args$ = LEFT$(args$, (idewx - 44)) + STRING$(3, 250)
            END IF
            l$ = l$ + sep + CHR$(195) + CHR$(196) + n$ + "  " + CHR$(16) + CHR$(2) + _
                 sf$ + CHR$(16) + CHR$(16) + args$
            psf$ = sf$
            pn$ = n$
            pargs$ = args$
            pInsideDECLARE = InsideDECLARE

            'Populate SortedSubsList()
            TotalSUBs = TotalSUBs + 1
            ListItemLength = LEN(n$ + " " + sf$ + args$)
            REDIM _PRESERVE SortedSubsList(1 TO TotalSUBs) AS STRING * 998
            REDIM _PRESERVE CaseBkpSubsList(1 TO TotalSUBs) AS STRING * 998
            REDIM _PRESERVE TotalLines(0 TO TotalSUBs) AS LONG
            CaseBkpSubsList(TotalSUBs) = n$ + "  " + CHR$(1) + CHR$(16) + CHR$(2) + sf$ + CHR$(16) + CHR$(16) + args$
            SortedSubsList(TotalSUBs) = UCASE$(CaseBkpSubsList(TotalSUBs))
            MID$(CaseBkpSubsList(TotalSUBs), 992, 6) = MKL$(y) + MKI$(ListItemLength)
            MID$(SortedSubsList(TotalSUBs), 992, 6) = MKL$(y) + MKI$(ListItemLength)
        ELSE 'no sf
            'remove double spaces
            i = INSTR(nca$, "  ")
            DO WHILE i > 0
                nca$ = LEFT$(nca$, i) + MID$(nca$, i + 2)
                i = INSTR(i, nca$, "  ")
            LOOP

            cursor = 0
            LookForENDSUB:
            sf = INSTR(cursor + 1, nca$, "END SUB")
            IF sf = 0 THEN sf = INSTR(cursor + 1, nca$, "END FUNCTION")

            IF sf THEN
                DIM comment AS _BYTE, quote AS _BYTE
                FindQuoteComment nca$, sf, comment, quote
                IF comment OR quote THEN cursor = sf: GOTO LookForENDSUB
                TotalLines(TotalSUBs) = ModuleSize
                SubClosed = -1
            END IF
        END IF
    NEXT

    TotalLines(TotalSUBs) = ModuleSize
    IF TotalSUBs > 0 THEN
        num$ = LTRIM$(STR$(TotalLines(TotalSUBs)))
        IF pInsideDECLARE THEN num$ = "external"
        lSized$ = lSized$ + CHR$(195) + CHR$(196) + pn$ + "  " + _
                  SPACE$(9 - LEN(num$)) + CHR$(16) + CHR$(2) + num$ + "  " + _
                  psf$ + CHR$(16) + CHR$(16) + pargs$
    END IF

    MID$(l$, _INSTRREV(l$, CHR$(195)), 1) = CHR$(192)
    MID$(lSized$, _INSTRREV(lSized$, CHR$(195)), 1) = CHR$(192)

    IF TotalSUBs > 1 THEN
        sort SortedSubsList()

        FOR x = 1 TO TotalSUBs
            ListItemLength = CVI(MID$(SortedSubsList(x), LEN(SortedSubsList(x)) - 2, 2))
            lySorted$ = lySorted$ + MID$(SortedSubsList(x), LEN(SortedSubsList(x)) - 6, 4)
            FOR RestoreCaseBkp = 1 TO TotalSUBs
                IF MID$(SortedSubsList(x), LEN(SortedSubsList(x)) - 6, 4) = MID$(CaseBkpSubsList(RestoreCaseBkp), LEN(CaseBkpSubsList(RestoreCaseBkp)) - 6, 4) THEN
                    lSorted$ = lSorted$ + sep + CHR$(195) + CHR$(196)
                    temp$ = LEFT$(CaseBkpSubsList(RestoreCaseBkp), ListItemLength)
                    lSorted$ = lSorted$ + LEFT$(temp$, INSTR(temp$, CHR$(1)) - 1) + _
                               MID$(temp$, INSTR(temp$, CHR$(1)) + 1)

                    num$ = LTRIM$(STR$(TotalLines(RestoreCaseBkp)))
                    IF LEFT$(temp$, 1) = "*" THEN num$ = "external"
                    lSortedSized$ = lSortedSized$ + sep + CHR$(195) + CHR$(196)
                    lSortedSized$ = lSortedSized$ + LEFT$(temp$, INSTR(temp$, CHR$(1)) - 1) + _
                                    SPACE$(9 - LEN(num$)) + CHR$(16) + CHR$(2) + num$ + "  " + _
                                    MID$(temp$, INSTR(temp$, CHR$(1)) + 1)
                    EXIT FOR
                END IF
            NEXT
        NEXT

        MID$(lSorted$, _INSTRREV(lSorted$, CHR$(195)), 1) = CHR$(192)
        MID$(lSortedSized$, _INSTRREV(lSortedSized$, CHR$(195)), 1) = CHR$(192)
        SortedSubsFlag = idesortsubs
    ELSE
        SortedSubsFlag = 0 'Override idesortsubs if the current program doesn't have more than 1 subprocedure
    END IF

    '72,19
    i = 0
    idepar p, idewx - 8, idewy + idesubwindow - 6, "SUBs"

    i = i + 1
    o(i).typ = 2
    o(i).y = 1
    '68
    o(i).w = idewx - 12: o(i).h = idewy + idesubwindow - 9
    IF SortedSubsFlag = 0 THEN
        IF IDESubsLength THEN
            o(i).txt = idenewtxt(lSized$)
        ELSE
            o(i).txt = idenewtxt(l$)
        END IF

        IF PreferCurrentCursorSUBFUNC <> 0 THEN
            o(i).sel = PreferCurrentCursorSUBFUNC
        ELSE
            o(i).sel = CurrentlyViewingWhichSUBFUNC
        END IF
    ELSE
        idetxt(o(i).txt) = lSorted$
        IF IDESubsLength THEN
            o(i).txt = idenewtxt(lSortedSized$)
        ELSE
            o(i).txt = idenewtxt(lSorted$)
        END IF
        IF PreferCurrentCursorSUBFUNC <> 0 THEN
            FOR x = 1 TO TotalSUBs
                IF MID$(ly$, PreferCurrentCursorSUBFUNC * 4 - 3, 4) = MID$(SortedSubsList(x), LEN(SortedSubsList(x)) - 6, 4) THEN
                    o(i).sel = x + 1 'The sorted list items array doesn't contain the first line (ideprogname$)
                    EXIT FOR
                END IF
            NEXT
        ELSE
            FOR x = 1 TO TotalSUBs
                IF MID$(ly$, CurrentlyViewingWhichSUBFUNC * 4 - 3, 4) = MID$(SortedSubsList(x), LEN(SortedSubsList(x)) - 6, 4) THEN
                    o(i).sel = x + 1 'The sorted list items array doesn't contain the first line (ideprogname$)
                    EXIT FOR
                END IF
            NEXT
        END IF
    END IF
    o(i).nam = idenewtxt("Program Items")

    i = i + 1
    o(i).typ = 4 'check box
    o(i).x = 2
    o(i).y = idewy + idesubwindow - 6
    o(i).nam = idenewtxt("Show #Line Count")
    o(i).sel = IDESubsLength

    IF TotalSUBs > 1 THEN
        i = i + 1
        o(i).typ = 4 'check box
        o(i).x = 22
        o(i).y = idewy + idesubwindow - 6
        o(i).nam = idenewtxt("#Sorted A-Z")
        o(i).sel = SortedSubsFlag
    END IF

    i = i + 1
    o(i).typ = 3
    o(i).x = p.w - 30
    o(i).y = idewy + idesubwindow - 6
    o(i).txt = idenewtxt("#Edit" + sep + "#Cancel")
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
        IF alt AND NOT KCTRL THEN idehl = 1 ELSE idehl = 0
        'convert "alt+letter" scancode to letter's ASCII character
        altletter$ = ""
        IF alt AND NOT KCTRL THEN
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
        IF (KSHIFT AND K$ = CHR$(9)) OR (INSTR(_OS$, "MAC") AND K$ = CHR$(25)) THEN focus = focus - 1: K$ = ""
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

        IF K$ = CHR$(27) OR (focus = 5 AND info <> 0) THEN
            idesubs$ = "C"
            GOSUB SaveSortSettings
            EXIT FUNCTION
        END IF

        IF K$ = CHR$(13) OR (focus = 4 AND info <> 0) OR (info = 1 AND focus = 1) THEN
            y = o(1).sel
            IF y < 1 THEN y = -y
            AddQuickNavHistory idecy
            IF SortedSubsFlag = 0 THEN
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

        IF o(2).sel <> IDESubsLength THEN
            IDESubsLength = o(2).sel
            IF IDESubsLength THEN
                IF o(3).sel THEN
                    idetxt(o(1).txt) = lSortedSized$
                ELSE
                    idetxt(o(1).txt) = lSized$
                END IF
            ELSE
                IF o(3).sel THEN
                    idetxt(o(1).txt) = lSorted$
                ELSE
                    idetxt(o(1).txt) = l$
                END IF
            END IF
            focus = 1
        END IF

        IF TotalSUBs > 1 THEN
            IF o(3).sel <> SortedSubsFlag THEN
                SortedSubsFlag = o(3).sel

                IF SortedSubsFlag = 0 THEN
                    'Replace list contents with unsorted version while mantaining current selection.
                    PreviousSelection = -1
                    IF o(1).sel > 0 THEN
                        TargetSourceLine$ = MID$(lySorted$, o(1).sel * 4 - 3, 4)
                        FOR x = 1 TO TotalSUBs
                            IF MID$(ly$, x * 4 - 3, 4) = TargetSourceLine$ THEN
                                PreviousSelection = x
                            END IF
                        NEXT
                    END IF

                    IF IDESubsLength THEN
                        idetxt(o(1).txt) = lSized$
                    ELSE
                        idetxt(o(1).txt) = l$
                    END IF
                    o(1).sel = PreviousSelection
                    focus = 1
                ELSE
                    'Replace list contents with sorted version while mantaining current selection.
                    PreviousSelection = -1
                    IF o(1).sel > 0 THEN
                        TargetSourceLine$ = MID$(ly$, o(1).sel * 4 - 3, 4)
                        FOR x = 1 TO TotalSUBs
                            IF MID$(lySorted$, x * 4 - 3, 4) = TargetSourceLine$ THEN
                                PreviousSelection = x
                            END IF
                        NEXT
                    END IF

                    IF IDESubsLength THEN
                        idetxt(o(1).txt) = lSortedSized$
                    ELSE
                        idetxt(o(1).txt) = lSorted$
                    END IF
                    o(1).sel = PreviousSelection
                    focus = 1
                END IF
            END IF
        END IF

        'end of custom controls
        mousedown = 0
        mouseup = 0
    LOOP

    EXIT FUNCTION
    SaveSortSettings:
    idesortsubs = SortedSubsFlag
    IF idesortsubs THEN
        WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_SortSUBs", "TRUE"
    ELSE
        WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_SortSUBs", "FALSE"
    END IF

    IF IDESubsLength THEN
        WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_SUBsLength", "TRUE"
    ELSE
        WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_SUBsLength", "FALSE"
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
        IF alt AND NOT KCTRL THEN idehl = 1 ELSE idehl = 0
        'convert "alt+letter" scancode to letter's ASCII character
        altletter$ = ""
        IF alt AND NOT KCTRL THEN
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
        IF (KSHIFT AND K$ = CHR$(9)) OR (INSTR(_OS$, "MAC") AND K$ = CHR$(25)) THEN focus = focus - 1: K$ = ""
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
            WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_CodePage", STR$(idecpindex)
            EXIT FUNCTION
        END IF


        'end of custom controls
        mousedown = 0
        mouseup = 0
    LOOP

    idelanguagebox = 0

END FUNCTION

FUNCTION idewarningbox

    '-------- generic dialog box header --------
    PCOPY 0, 2
    PCOPY 0, 1
    SCREEN , , 1, 0
    focus = 1
    DIM p AS idedbptype
    DIM o(1 TO 100) AS idedbotype
    DIM sep AS STRING * 1
    sep = CHR$(0)
    '-------- end of generic dialog box header --------

    '-------- init --------

    DIM warningLines(1 TO warningListItems) AS LONG
    DIM warningIncLines(1 TO warningListItems) AS LONG
    DIM warningIncFiles(1 TO warningListItems) AS STRING

    IF LEN(ideprogname) THEN thisprog$ = ideprogname ELSE thisprog$ = "Untitled" + tempfolderindexstr$
    maxModuleNameLen = LEN(thisprog$)

    'fill arrays
    FOR x = 1 TO warningListItems
        warningLines(x) = CVL(LEFT$(warning$(x), 4))
        IF warningLines(x) = 0 THEN _CONTINUE

        warningIncLevel = CVL(MID$(warning$(x), 5, 4))
        IF warningIncLevel > 0 THEN
            warningIncLines(x) = CVL(MID$(warning$(x), 9, 4))
            warningIncFiles(x) = MID$(warning$(x), 13, INSTR(warning$(x), CHR$(2)) - 13)
            IF LEN(warningIncFiles(x)) > maxModuleNameLen THEN
                maxModuleNameLen = LEN(warningIncFiles(x))
            END IF
        END IF
    NEXT

    'build list
    FOR x = 1 TO warningListItems
        IF warningLines(x) = 0 THEN
            l$ = l$ + MID$(warning$(x), INSTR(warning$(x), CHR$(2)) + 1)
            IF x > 1 THEN ASC(l$, treeConnection) = 192
        ELSE
            l3$ = CHR$(16) + CHR$(2) 'dark grey
            IF warningIncLines(x) > 0 THEN
                num$ = SPACE$(maxLineNumberLength)
                RSET num$ = str2$(warningIncLines(x))
                l3$ = l3$ + warningIncFiles(x) + SPACE$(maxModuleNameLen - LEN(warningIncFiles(x))) + ":" + CHR$(16) + CHR$(16) + num$
            ELSE
                num$ = SPACE$(maxLineNumberLength)
                RSET num$ = str2$(warningLines(x))
                l3$ = l3$ + thisprog$ + SPACE$(maxModuleNameLen - LEN(thisprog$)) + ":" + CHR$(16) + CHR$(16) + num$
            END IF
            treeConnection = LEN(l$) + 1
            text$ = MID$(warning$(x), INSTR(warning$(x), CHR$(2)) + 1)
            IF LEN(text$) THEN
                l$ = l$ + CHR$(195) + CHR$(196) + l3$ + ": " + text$
            ELSE
                l$ = l$ + CHR$(195) + CHR$(196) + l3$
            END IF
        END IF
        IF x < warningListItems THEN l$ = l$ + sep
    NEXT

    IF warningLines(warningListItems) > 0 THEN
        ASC(l$, treeConnection) = 192
    END IF

    i = 0
    dialogHeight = warningListItems + 4
    IF dialogHeight > idewy + idesubwindow - 6 THEN
        dialogHeight = idewy + idesubwindow - 6
    END IF

    idepar p, idewx - 8, dialogHeight, "Compilation status"

    i = i + 1
    o(i).typ = 2
    o(i).y = 2
    o(i).w = idewx - 12: o(i).h = dialogHeight - 4
    o(i).txt = idenewtxt(l$)
    o(i).sel = 1: IF idecpindex THEN o(i).sel = idecpindex
    o(i).nam = idenewtxt("Warnings (" + LTRIM$(STR$(totalWarnings)) + ")")

    i = i + 1
    o(i).typ = 3
    o(i).y = dialogHeight
    o(i).txt = idenewtxt("#Go to" + sep + "#Close")
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
        COLOR 0, 7: LOCATE p.y + 1, p.x + 2: PRINT "Double-click on an item to jump to the line indicated"

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
        IF alt AND NOT KCTRL THEN idehl = 1 ELSE idehl = 0
        'convert "alt+letter" scancode to letter's ASCII character
        altletter$ = ""
        IF alt AND NOT KCTRL THEN
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
        IF (KSHIFT AND K$ = CHR$(9)) OR (INSTR(_OS$, "MAC") AND K$ = CHR$(25)) THEN focus = focus - 1: K$ = ""
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
            EXIT FUNCTION
        END IF

        IF K$ = CHR$(13) OR (focus = 2 AND info <> 0) OR (info = 1 AND focus = 1) THEN
            y = ABS(o(1).sel)
            IF y >= 1 AND y <= warningListItems AND warningLines(y) > 0 THEN
                idegotobox_LastLineNum = warningLines(y)
                AddQuickNavHistory idecy
                idecy = idegotobox_LastLineNum
                IF warningIncLines(y) > 0 THEN
                    warningInInclude = idecy
                    warningInIncludeLine = warningIncLines(y)
                END IF
                ideselect = 0
                EXIT FUNCTION
            END IF
        END IF

        'end of custom controls
        mousedown = 0
        mouseup = 0
    LOOP

    idewarningbox = 0
END FUNCTION

SUB ideobjupdate (o AS idedbotype, focus, f, focusoffset, kk$, altletter$, mb, mousedown, mouseup, mx, my, info, mw)
    STATIC SearchTerm$, LastKeybInput AS SINGLE
    DIM sep AS STRING * 1
    sep = CHR$(0)

    t = o.typ
    mouseup = mouseup 'just to clear warnings of unused variables
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
                            IF sx1 > sx2 THEN SWAP sx1, sx2
                            IF sx2 - sx1 > 0 THEN
                                a$ = LEFT$(a$, sx1) + clip$ + RIGHT$(a$, LEN(a$) - sx2)
                                o.v1 = sx1
                                IF PasteCursorAtEnd THEN o.v1 = sx1 + LEN(clip$)
                                o.issel = 0
                            END IF
                        ELSE
                            a$ = LEFT$(a$, o.v1) + clip$ + RIGHT$(a$, LEN(a$) - o.v1)
                            IF PasteCursorAtEnd THEN o.v1 = o.v1 + LEN(clip$)
                        END IF
                    END IF
                    k = 255
                END IF

                IF (KCONTROL AND UCASE$(kk$) = "A") THEN 'select all
                    IF LEN(a$) > 0 THEN
                        o.issel = -1
                        o.sx1 = 0
                        o.v1 = LEN(a$)
                    END IF
                    k = 255
                END IF

                IF ((KCTRL AND KB = KEY_INSERT) OR (KCONTROL AND UCASE$(kk$) = "C")) THEN 'copy to clipboard
                    IF o.issel THEN
                        sx1 = o.sx1: sx2 = o.v1
                        IF sx1 > sx2 THEN SWAP sx1, sx2
                        IF sx2 - sx1 > 0 THEN _CLIPBOARD$ = MID$(a$, sx1 + 1, sx2 - sx1)
                    END IF
                    k = 255
                END IF

                IF ((KSHIFT AND KB = KEY_DELETE) OR (KCONTROL AND UCASE$(kk$) = "X")) THEN 'cut to clipboard
                    IF o.issel THEN
                        sx1 = o.sx1: sx2 = o.v1
                        IF sx1 > sx2 THEN SWAP sx1, sx2
                        IF sx2 - sx1 > 0 THEN
                            _CLIPBOARD$ = MID$(a$, sx1 + 1, sx2 - sx1)
                            'delete selection
                            a$ = LEFT$(a$, sx1) + RIGHT$(a$, LEN(a$) - sx2)
                            o.v1 = sx1
                            o.issel = 0
                        END IF
                    END IF
                    k = 255
                END IF

                IF k = 8 AND o.v1 > 0 THEN
                    IF o.issel THEN
                        sx1 = o.sx1: sx2 = o.v1
                        IF sx1 > sx2 THEN SWAP sx1, sx2
                        IF sx2 - sx1 > 0 THEN
                            'delete selection
                            a$ = LEFT$(a$, sx1) + RIGHT$(a$, LEN(a$) - sx2)
                            o.issel = 0
                        END IF
                    ELSE
                        a1$ = LEFT$(a$, o.v1 - 1)
                        IF o.v1 <= LEN(a$) THEN a2$ = RIGHT$(a$, LEN(a$) - o.v1) ELSE a2$ = ""
                        a$ = a1$ + a2$: o.v1 = o.v1 - 1
                    END IF
                ELSEIF k = 8 AND o.issel THEN
                    sx1 = o.sx1: sx2 = o.v1
                    IF sx1 > sx2 THEN SWAP sx1, sx2
                    IF sx2 - sx1 > 0 THEN
                        'delete selection
                        a$ = LEFT$(a$, sx1) + RIGHT$(a$, LEN(a$) - sx2)
                        o.issel = 0
                    END IF
                END IF
                IF k <> 8 AND k <> 9 AND k <> 0 AND k <> 10 AND k <> 13 AND k <> 26 AND k <> 255 AND ((KALT = 0 AND KCTRL = 0) OR (KALT = -1 AND KCTRL = -1)) THEN
                    IF o.issel THEN
                        sx1 = o.sx1: sx2 = o.v1
                        IF sx1 > sx2 THEN SWAP sx1, sx2
                        IF sx2 - sx1 > 0 THEN
                            'replace selection
                            a$ = LEFT$(a$, sx1) + RIGHT$(a$, LEN(a$) - sx2)
                            idetxt(o.txt) = a$
                            o.issel = 0
                            o.v1 = sx1
                        END IF
                    END IF
                    IF o.v1 > 0 THEN a1$ = LEFT$(a$, o.v1) ELSE a1$ = ""
                    IF o.v1 <= LEN(a$) THEN a2$ = RIGHT$(a$, LEN(a$) - o.v1) ELSE a2$ = ""
                    a$ = a1$ + kk$ + a2$: o.v1 = o.v1 + 1
                END IF
                idetxt(o.txt) = a$
            END IF
            IF kk$ = CHR$(0) + "S" THEN 'DEL
                IF o.issel THEN
                    sx1 = o.sx1: sx2 = o.v1
                    IF sx1 > sx2 THEN SWAP sx1, sx2
                    IF sx2 - sx1 > 0 THEN
                        'delete selection
                        a$ = LEFT$(a$, sx1) + RIGHT$(a$, LEN(a$) - sx2)
                        idetxt(o.txt) = a$
                        o.v1 = sx1
                        o.issel = 0
                    END IF
                ELSE
                    IF o.v1 > 0 THEN a1$ = LEFT$(a$, o.v1) ELSE a1$ = ""
                    IF o.v1 < LEN(a$) THEN a2$ = RIGHT$(a$, LEN(a$) - o.v1 - 1) ELSE a2$ = ""
                    a$ = a1$ + a2$
                    idetxt(o.txt) = a$
                END IF
            END IF

            'cursor control
            IF kk$ = CHR$(0) + "K" THEN GOSUB selectcheck: o.v1 = o.v1 - 1
            IF kk$ = CHR$(0) + "M" THEN GOSUB selectcheck: o.v1 = o.v1 + 1
            IF kk$ = CHR$(0) + "G" THEN GOSUB selectcheck: o.v1 = 0
            IF kk$ = CHR$(0) + "O" THEN GOSUB selectcheck: o.v1 = LEN(a$)
            IF o.v1 < 0 THEN o.v1 = 0
            IF o.v1 > LEN(a$) THEN o.v1 = LEN(a$)
            IF o.v1 = o.sx1 THEN o.issel = 0
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
                IF timeElapsedSince(LastKeybInput) > 1 THEN SearchTerm$ = "": ResetKeybTimer = -1
                LastKeybInput = TIMER
                k = ASC(UCASE$(kk$)): IF k < 32 OR k > 126 THEN k = 255

                'Populate ListBoxITEMS:
                a$ = idetxt(o.txt)
                REDIM ListBoxITEMS(0) AS STRING
                IF LEN(a$) > 0 THEN
                    n = 0: x = 1
                    DO
                        x2 = INSTR(x, a$, sep)
                        IF x2 > 0 THEN
                            n = n + 1
                            REDIM _PRESERVE ListBoxITEMS(1 TO n) AS STRING
                            ListBoxITEMS(n) = MID$(a$, x, x2 - x)
                        ELSE
                            n = n + 1
                            REDIM _PRESERVE ListBoxITEMS(1 TO n) AS STRING
                            ListBoxITEMS(n) = RIGHT$(a$, LEN(a$) - x + 1)
                            EXIT DO
                        END IF
                        x = x2 + 1
                    LOOP
                END IF

                IF k = 255 THEN
                    IF o.sel > 0 AND o.sel <= UBOUND(ListBoxITEMS) THEN idetxt(o.stx) = ListBoxITEMS(o.sel)
                    GOTO selected 'Search is not performed if kk$ isn't a printable character
                ELSE
                    SearchTerm$ = SearchTerm$ + UCASE$(kk$)
                END IF

                IF LEN(SearchTerm$) = 2 AND LEFT$(SearchTerm$, 1) = RIGHT$(SearchTerm$, 1) THEN
                    'if the user is pressing the same letter again, we deduce the search
                    'is only for the initials
                    ResetKeybTimer = -1
                    SearchTerm$ = UCASE$(kk$)
                END IF

                SearchPass = 1
                IF NOT ResetKeybTimer THEN StartSearch = ABS(o.sel) ELSE StartSearch = ABS(o.sel) + 1
                IF StartSearch < 1 OR StartSearch > n THEN StartSearch = 1
                retryfind:
                IF SearchPass > 2 THEN GOTO selected
                FOR findMatch = StartSearch TO n
                    validCHARS$ = ""
                    FOR ai = 1 TO LEN(ListBoxITEMS(findMatch))
                        aa = ASC(UCASE$(ListBoxITEMS(findMatch)), ai)
                        IF aa > 126 OR (k <> 95 AND aa = 95) OR (k <> 42 AND aa = 42) THEN
                            'ignore
                        ELSE
                            validCHARS$ = validCHARS$ + CHR$(aa)
                        END IF
                    NEXT
                    IF findMatch = o.sel THEN idetxt(o.stx) = ListBoxITEMS(findMatch)
                    IF LEFT$(validCHARS$, LEN(SearchTerm$)) = SearchTerm$ THEN
                        o.sel = findMatch
                        GOTO selected
                    END IF
                NEXT findMatch
                'No match, try again:
                StartSearch = 1
                SearchPass = SearchPass + 1
                GOTO retryfind
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
            IF kk$ = CHR$(13) OR kk$ = " " THEN
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
        LOCATE y2, x: PRINT CHR$(176);
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
            LOCATE y2, x: PRINT CHR$(219);
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
            LOCATE y2, x: PRINT CHR$(219);
            idevbar = y2
            EXIT FUNCTION
        END IF
        IF i = n THEN
            y2 = y + h - 2
            LOCATE y2, x: PRINT CHR$(219);
            idevbar = y2
            EXIT FUNCTION
        END IF
        'between i=1 and i=n
        p! = (i - 1) / (n - 1)
        p! = p! * (h - 4)
        y2 = y + 2 + INT(p!)
        LOCATE y2, x: PRINT CHR$(219);
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

FUNCTION idezfilelist$ (path$, method, mask$) 'method0=*.bas, method1=*.*, method2=custom mask
    DIM sep AS STRING * 1
    sep = CHR$(0)

    IF os$ = "WIN" THEN
        OPEN ".\internal\temp\files.txt" FOR OUTPUT AS #150: CLOSE #150
        IF method = 0 THEN SHELL _HIDE "dir /b /ON /A-D " + QuotedFilename$(path$) + "\*.bas >.\internal\temp\files.txt"
        IF method = 1 THEN SHELL _HIDE "dir /b /ON /A-D " + QuotedFilename$(path$) + "\*.* >.\internal\temp\files.txt"
        IF method = 2 THEN SHELL _HIDE "dir /b /ON /A-D " + QuotedFilename$(path$) + "\" + QuotedFilename$(mask$) + " >.\internal\temp\files.txt"
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
        IF method = 0 THEN
            FOR i = 1 TO 2
                OPEN "./internal/temp/files.txt" FOR OUTPUT AS #150: CLOSE #150
                IF i = 1 THEN SHELL _HIDE "find " + QuotedFilename$(path$) + " -maxdepth 1 -type f -name " + CHR$(34) + "*.bas" + CHR$(34) + " | sort >./internal/temp/files.txt"
                IF i = 2 THEN SHELL _HIDE "find " + QuotedFilename$(path$) + " -maxdepth 1 -type f -name " + CHR$(34) + "*.BAS" + CHR$(34) + " | sort >./internal/temp/files.txt"
                GOSUB AddToList
            NEXT
        ELSEIF method = 1 THEN
            SHELL _HIDE "find " + QuotedFilename$(path$) + " -maxdepth 1 -type f -name " + CHR$(34) + "*" + CHR$(34) + " | sort >./internal/temp/files.txt"
            GOSUB AddToList
        ELSEIF method = 2 THEN
            SHELL _HIDE "find " + QuotedFilename$(path$) + " -maxdepth 1 -type f -name " + CHR$(34) + mask$ + CHR$(34) + " | sort >./internal/temp/files.txt"
            GOSUB AddToList
        END IF
        idezfilelist$ = filelist$
        EXIT FUNCTION

        AddToList:
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
        RETURN
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
     ELSE
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
            IF RIGHT$(pathlist$, 1) <> sep AND LEN(pathlist$) > 0 THEN pathlist$ = pathlist$ + sep
            IF _DIREXISTS(CHR$(65 + i) + ":\") THEN
                pathlist$ = pathlist$ + CHR$(65 + i) + ":"
            END IF
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

    FOR i = LEN(f$) TO 1 STEP -1
        a$ = MID$(f$, i, 1)
        IF a$ = "\" OR a$ = "/" THEN
            p$ = LEFT$(f$, i - 1)
            f$ = RIGHT$(f$, LEN(f$) - i)
            EXIT FOR
        END IF
    NEXT
    ideztakepath$ = p$
    EXIT FUNCTION
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
    IF _DIREXISTS(root$ + idepathsep$ + p$) THEN p$ = root$ + idepathsep$ + p$

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
    p$ = _CWD$
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
    DIM sep AS STRING * 1
    sep = CHR$(0)
    '-------- end of generic dialog box header --------

    '-------- init --------
    i = 0
    idepar p, 60, 8, "Code Layout"

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
    o(i).nam = idenewtxt("Indent SUBs and #FUNCTIONs")
    o(i).sel = ideindentsubs

    i = i + 1
    o(i).typ = 3
    o(i).y = 8
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
        IF alt AND NOT KCTRL THEN idehl = 1 ELSE idehl = 0
        'convert "alt+letter" scancode to letter's ASCII character
        altletter$ = ""
        IF alt AND NOT KCTRL THEN
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
        IF (KSHIFT AND K$ = CHR$(9)) OR (INSTR(_OS$, "MAC") AND K$ = CHR$(25)) THEN focus = focus - 1: K$ = ""
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
            'Always start with TextBox values selected upon getting focus
            PrevFocus = focus
            IF focus = 3 THEN
                o(focus).v1 = LEN(idetxt(o(focus).txt))
                IF o(focus).v1 > 0 THEN o(focus).issel = -1
                o(focus).sx1 = 0
            END IF
        END IF

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

            IF ideautolayout THEN
                WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_AutoFormat", "TRUE"
            ELSE
                WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_AutoFormat", "FALSE"
            END IF
            IF ideautoindent THEN
                WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_AutoIndent", "TRUE"
            ELSE
                WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_AutoIndent", "FALSE"
            END IF
            WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_IndentSize", STR$(ideautoindentsize)
            IF ideindentsubs THEN
                WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_IndentSUBs", "TRUE"
            ELSE
                WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_IndentSUBs", "FALSE"
            END IF
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
    DIM sep AS STRING * 1
    sep = CHR$(0)
    '-------- end of generic dialog box header --------

    '-------- init --------
    i = 0
    idepar p, 50, 5, "Backup/Undo"

    a2$ = str2$(idebackupsize)
    i = i + 1
    PrevFocus = 1
    o(i).typ = 1
    o(i).y = 2
    o(i).nam = idenewtxt("#Undo buffer limit (10-2000MB)")
    o(i).txt = idenewtxt(a2$)
    o(i).v1 = LEN(a2$)
    IF o(i).v1 > 0 THEN
        o(i).issel = -1
        o(i).sx1 = 0
    END IF

    i = i + 1
    o(i).typ = 3
    o(i).y = 5
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
        IF alt AND NOT KCTRL THEN idehl = 1 ELSE idehl = 0
        'convert "alt+letter" scancode to letter's ASCII character
        altletter$ = ""
        IF alt AND NOT KCTRL THEN
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
        IF (KSHIFT AND K$ = CHR$(9)) OR (INSTR(_OS$, "MAC") AND K$ = CHR$(25)) THEN focus = focus - 1: K$ = ""
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
            'Always start with TextBox values selected upon getting focus
            PrevFocus = focus
            IF focus = 1 THEN
                o(focus).v1 = LEN(idetxt(o(focus).txt))
                IF o(focus).v1 > 0 THEN o(focus).issel = -1
                o(focus).sx1 = 0
            END IF
        END IF

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
            WriteConfigSetting "'[GENERAL SETTINGS]", "BackupSize", STR$(v&) + " 'in MB"
            idebackupbox = 1
            EXIT FUNCTION
        END IF

        'end of custom controls

        mousedown = 0
        mouseup = 0
    LOOP
END FUNCTION

SUB idegotobox
    IF idegotobox_LastLineNum > 0 THEN a2$ = str2$(idegotobox_LastLineNum) ELSE a2$ = ""
    v$ = ideinputbox$("Go To Line", "#Line", a2$, "0123456789", 30, 8)
    IF v$ = "" THEN EXIT SUB

    v& = VAL(v$)
    IF v& < 1 THEN v& = 1
    IF v& > iden THEN v& = iden
    idegotobox_LastLineNum = v&
    AddQuickNavHistory idecy
    idecy = v&
    ideselect = 0
END SUB





FUNCTION ideadvancedbox

    '-------- generic dialog box header --------
    PCOPY 0, 2
    PCOPY 0, 1
    SCREEN , , 1, 0
    focus = 1
    DIM p AS idedbptype
    DIM o(1 TO 100) AS idedbotype
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
        IF alt AND NOT KCTRL THEN idehl = 1 ELSE idehl = 0
        'convert "alt+letter" scancode to letter's ASCII character
        altletter$ = ""
        IF alt AND NOT KCTRL THEN
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
        IF (KSHIFT AND K$ = CHR$(9)) OR (INSTR(_OS$, "MAC") AND K$ = CHR$(25)) THEN focus = focus - 1: K$ = ""
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
                IF idedebuginfo THEN
                    WriteConfigSetting "'[GENERAL SETTINGS]", "DebugInfo", "TRUE 'INTERNAL VARIABLE USE ONLY!! DO NOT MANUALLY CHANGE!"
                ELSE
                    WriteConfigSetting "'[GENERAL SETTINGS]", "DebugInfo", "FALSE 'INTERNAL VARIABLE USE ONLY!! DO NOT MANUALLY CHANGE!"
                END IF
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

    ideadvancedbox = 0
END FUNCTION







FUNCTION idemessagebox (titlestr$, messagestr$, buttons$)

    '-------- generic dialog box header --------
    PCOPY 0, 2
    PCOPY 0, 1
    SCREEN , , 1, 0
    focus = 1
    DIM p AS idedbptype
    DIM o(1 TO 100) AS idedbotype
    DIM sep AS STRING * 1
    sep = CHR$(0)
    '-------- end of generic dialog box header --------

    '-------- init --------
    messagestr$ = StrReplace$(messagestr$, "\n", CHR$(10))
    MessageLines = 1
    DIM FullMessage$(1 TO 8)
    PrevScan = 1
    DO
        NextScan = INSTR(NextScan + 1, messagestr$, CHR$(10))
        IF NextScan > 0 THEN
            FullMessage$(MessageLines) = MID$(messagestr$, PrevScan, NextScan - PrevScan)
            tw = LEN(FullMessage$(MessageLines)) + 2
            IF tw > w THEN w = tw
            PrevScan = NextScan + 1
            MessageLines = MessageLines + 1
            IF MessageLines > UBOUND(FullMessage$) THEN EXIT DO
        ELSE
            FullMessage$(MessageLines) = MID$(messagestr$, PrevScan)
            tw = LEN(FullMessage$(MessageLines)) + 2
            IF tw > w THEN w = tw
            EXIT DO
        END IF
    LOOP

    IF buttons$ = "" THEN buttons$ = "#OK"
    totalButtons = 1
    FOR i = 1 TO LEN(buttons$)
        IF ASC(buttons$, i) = 59 THEN totalButtons = totalButtons + 1
    NEXT
    buttonsLen = LEN(buttons$) + totalButtons * 6

    i = 0
    w2 = LEN(titlestr$) + 4
    IF w < w2 THEN w = w2
    IF w < buttonsLen THEN w = buttonsLen
    IF w > idewx - 4 THEN w = idewx - 4
    idepar p, w, 3 + MessageLines, titlestr$

    i = i + 1
    o(i).typ = 3
    o(i).y = 3 + MessageLines
    o(i).txt = idenewtxt(StrReplace$(buttons$, ";", sep))
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
        COLOR 0, 7
        FOR i = 1 TO MessageLines
            IF LEN(FullMessage$(i)) > p.w - 2 THEN
                FullMessage$(i) = LEFT$(FullMessage$(i), p.w - 5) + STRING$(3, 250)
            END IF
            LOCATE p.y + 1 + i, p.x + (w \ 2 - LEN(FullMessage$(i)) \ 2) + 1
            PRINT FullMessage$(i);
        NEXT i
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
        IF alt AND NOT KCTRL THEN idehl = 1 ELSE idehl = 0
        'convert "alt+letter" scancode to letter's ASCII character
        altletter$ = ""
        IF alt AND NOT KCTRL THEN
            IF LEN(K$) = 1 THEN
                k = ASC(UCASE$(K$))
                IF k >= 65 AND k <= 90 THEN altletter$ = CHR$(k)
            END IF
        END IF
        SCREEN , , 0, 0: LOCATE , , 0: SCREEN , , 1, 0
        '-------- end of read input --------

        '-------- generic input response --------
        info = 0

        IF UCASE$(K$) >= "A" AND UCASE$(K$) <= "Z" THEN altletter$ = UCASE$(K$)

        IF K$ = "" THEN K$ = CHR$(255)
        IF KSHIFT = 0 AND K$ = CHR$(9) THEN focus = focus + 1
        IF (KSHIFT AND K$ = CHR$(9)) OR (INSTR(_OS$, "MAC") AND K$ = CHR$(25)) THEN focus = focus - 1: K$ = ""
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
        IF K$ = CHR$(27) THEN EXIT FUNCTION

        IF K$ = CHR$(13) OR (info <> 0) THEN idemessagebox = focus: EXIT FUNCTION
        'end of custom controls

        mousedown = 0
        mouseup = 0
    LOOP
END FUNCTION



FUNCTION ideyesnobox$ (titlestr$, messagestr$) 'returns "Y" or "N"
    result = idemessagebox(titlestr$, messagestr$, "#Yes;#No")
    IF result = 1 THEN ideyesnobox$ = "Y" ELSE ideyesnobox$ = "N"
END FUNCTION 'yes/no box



FUNCTION idedisplaybox

    '-------- generic dialog box header --------
    PCOPY 0, 2
    PCOPY 0, 1
    SCREEN , , 1, 0
    focus = 1
    DIM p AS idedbptype
    DIM o(1 TO 100) AS idedbotype
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
    PrevFocus = 1
    o(i).typ = 1
    o(i).x = 16
    o(i).y = 2
    o(i).nam = idenewtxt("#Width")
    o(i).txt = idenewtxt(a2$)
    o(i).v1 = LEN(a2$)
    IF o(i).v1 > 0 THEN
        o(i).issel = -1
        o(i).sx1 = 0
    END IF

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
    IF IDE_AutoPosition THEN o(i).sel = 1

    i = i + 1
    o(i).typ = 4 'check box
    o(i).y = 9
    o(i).nam = idenewtxt("Use _FONT 8")
    o(i).sel = IDE_UseFont8
    prevFont8Setting = o(i).sel

    i = i + 1
    o(i).typ = 4 'check box
    o(i).y = 10
    o(i).nam = idenewtxt("Custom #Font:")
    o(i).sel = idecustomfont
    prevCustomFontSetting = o(i).sel

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
        IF alt AND NOT KCTRL THEN idehl = 1 ELSE idehl = 0
        'convert "alt+letter" scancode to letter's ASCII character
        altletter$ = ""
        IF alt AND NOT KCTRL THEN
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
        IF (KSHIFT AND K$ = CHR$(9)) OR (INSTR(_OS$, "MAC") AND K$ = CHR$(25)) THEN focus = focus - 1: K$ = ""
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
            'Always start with TextBox values selected upon getting focus
            PrevFocus = focus
            IF focus = 1 OR focus = 2 OR focus = 6 OR focus = 7 THEN
                o(focus).v1 = LEN(idetxt(o(focus).txt))
                IF o(focus).v1 > 0 THEN o(focus).issel = -1
                o(focus).sx1 = 0
            END IF
        END IF

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

        IF prevFont8Setting <> o(4).sel THEN
            prevFont8Setting = o(4).sel
            IF o(4).sel THEN o(5).sel = 0: prevCustomFontSetting = 0
        END IF

        IF prevCustomFontSetting <> o(5).sel THEN
            prevCustomFontSetting = o(5).sel
            IF o(5).sel THEN o(4).sel = 0: prevFont8Setting = 0
        END IF

        a$ = idetxt(o(6).txt)
        IF LEN(a$) > 1024 THEN a$ = LEFT$(a$, 1024)
        idetxt(o(6).txt) = a$

        a$ = idetxt(o(7).txt)
        IF LEN(a$) > 2 THEN a$ = LEFT$(a$, 2) '2 character limit
        FOR i = 1 TO LEN(a$)
            a = ASC(a$, i)
            IF a < 48 OR a > 57 THEN a$ = "": EXIT FOR
            IF i = 2 AND ASC(a$, 1) = 48 THEN a$ = "0": EXIT FOR
        NEXT
        IF focus <> 7 THEN
            IF LEN(a$) THEN a = VAL(a$) ELSE a = 0
            IF a < 8 THEN a$ = "8"
        END IF
        idetxt(o(7).txt) = a$


        IF K$ = CHR$(27) OR (focus = 9 AND info <> 0) THEN EXIT FUNCTION
        IF K$ = CHR$(13) OR (focus = 8 AND info <> 0) THEN

            x = 0 'change to custom font

            'get size in v%
            v$ = idetxt(o(7).txt): IF v$ = "" THEN v$ = "0"
            v% = VAL(v$)
            IF v% < 8 THEN v% = 8
            IF v% > 99 THEN v% = 99
            IF v% <> idecustomfontheight THEN x = 1

            IF o(4).sel <> IDE_UseFont8 THEN
                IDE_UseFont8 = o(4).sel
                idedisplaybox = 1
            END IF

            IF o(5).sel <> idecustomfont THEN
                IF o(5).sel = 0 THEN
                    IF IDE_UseFont8 THEN _FONT 8 ELSE _FONT 16
                    _FREEFONT idecustomfonthandle
                ELSE
                    x = 1
                END IF
            END IF


            v$ = idetxt(o(6).txt): IF v$ <> idecustomfontfile$ THEN x = 1

            IF o(5).sel = 1 AND x = 1 THEN
                oldhandle = idecustomfonthandle
                idecustomfonthandle = _LOADFONT(v$, v%, "MONOSPACE")
                IF idecustomfonthandle = -1 THEN
                    'failed! - revert to default settings
                    o(5).sel = 0: idetxt(o(6).txt) = "c:\windows\fonts\lucon.ttf": idetxt(o(7).txt) = "21": IF IDE_UseFont8 THEN _FONT 8 ELSE _FONT 16
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

            v% = o(5).sel
            IF v% <> 0 THEN v% = 1
            idecustomfont = v%

            v$ = idetxt(o(6).txt)
            IF LEN(v$) > 1024 THEN v$ = LEFT$(v$, 1024)
            idecustomfontfile$ = v$
            v$ = v$ + SPACE$(1024 - LEN(v$))

            v$ = idetxt(o(7).txt): IF v$ = "" THEN v$ = "0"
            v% = VAL(v$)
            IF v% < 8 THEN v% = 8
            IF v% > 99 THEN v% = 99
            idecustomfontheight = v%


            WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_Width", STR$(idewx)
            WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_Height", STR$(idewy)
            IF idecustomfont THEN
                WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_CustomFont", "TRUE"
            ELSE
                WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_CustomFont", "FALSE"
            END IF
            IF IDE_UseFont8 THEN
                WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_UseFont8", "TRUE"
            ELSE
                WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_UseFont8", "FALSE"
            END IF
            IF IDE_AutoPosition THEN
                WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_AutoPosition", "TRUE"
            ELSE
                WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_AutoPosition", "FALSE"
            END IF
            WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_CustomFont$", idecustomfontfile$
            WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_CustomFontSize", STR$(idecustomfontheight)


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
    DIM bkpIDEBackgroundColor AS _UNSIGNED LONG, bkpIDEKeywordColor AS _UNSIGNED LONG
    DIM bkpIDEBackgroundColor2 AS _UNSIGNED LONG, bkpIDENumbersColor AS _UNSIGNED LONG
    DIM bkpIDEBracketHighlightColor AS _UNSIGNED LONG

    TotalItems = 9
    DIM SelectionIndicator$(1 TO TotalItems)
    bkpIDECommentColor = IDECommentColor
    bkpIDEMetaCommandColor = IDEMetaCommandColor
    bkpIDEQuoteColor = IDEQuoteColor
    bkpIDETextColor = IDETextColor
    bkpIDEKeywordColor = IDEKeywordColor
    bkpIDENumbersColor = IDENumbersColor
    bkpIDEBackgroundColor = IDEBackgroundColor
    bkpIDEBackgroundColor2 = IDEBackgroundColor2
    bkpIDEBracketHighlightColor = IDEBracketHighlightColor

    '-------- generic dialog box header --------
    PCOPY 0, 2
    PCOPY 0, 1
    SCREEN , , 1, 0
    focus = 1
    DIM p AS idedbptype
    DIM o(1 TO 100) AS idedbotype
    DIM sep AS STRING * 1
    sep = CHR$(0)
    '-------- end of generic dialog box header --------

    '-------- init --------
    LoadColorSchemes
    _PALETTECOLOR 5, &HFF00A800, 0 'Original green may have been changed by the Help System, so 5 is now green

    i = 0
    idepar p, 73, 19, "IDE Colors"

    l$ = CHR$(16) + "Normal Text"
    l$ = l$ + sep + " Keywords"
    l$ = l$ + sep + " Numbers"
    l$ = l$ + sep + " Strings"
    l$ = l$ + sep + " Metacommand/custom keywords"
    l$ = l$ + sep + " Comments"
    l$ = l$ + sep + " Background"
    l$ = l$ + sep + " Current line background"
    l$ = l$ + sep + " Bracket/selection highlight"
    i = i + 1
    o(i).typ = 2
    o(i).y = 4
    o(i).w = 30: o(i).h = 9
    o(i).txt = idenewtxt(l$)
    o(i).sel = 1
    SelectedITEM = 1
    PrevFocus = 1
    o(i).nam = idenewtxt("#Item:")

    a2$ = str2$(_RED32(IDETextColor))
    i = i + 1
    o(i).typ = 1
    o(i).x = 66
    o(i).y = 5
    o(i).txt = idenewtxt(a2$)
    o(i).v1 = LEN(a2$)
    o(i).issel = -1
    o(i).sx1 = 0

    a2$ = str2$(_GREEN32(IDETextColor))
    i = i + 1
    o(i).typ = 1
    o(i).x = 66
    o(i).y = 8
    o(i).txt = idenewtxt(a2$)
    o(i).v1 = LEN(a2$)
    o(i).issel = -1
    o(i).sx1 = 0

    a2$ = str2$(_BLUE32(IDETextColor))
    i = i + 1
    o(i).typ = 1
    o(i).x = 66
    o(i).y = 11
    o(i).txt = idenewtxt(a2$)
    o(i).v1 = LEN(a2$)
    o(i).issel = -1
    o(i).sx1 = 0

    i = i + 1
    o(i).typ = 4 'check box
    o(i).y = 15
    o(i).nam = idenewtxt("#Highlight brackets")
    IF brackethighlight THEN o(i).sel = 1

    i = i + 1
    o(i).typ = 4 'check box
    o(i).y = 16
    o(i).nam = idenewtxt("#Multi-highlight (selection)")
    IF multihighlight THEN o(i).sel = 1

    i = i + 1
    o(i).typ = 4 'check box
    o(i).y = 17
    o(i).nam = idenewtxt("Highlight #keywords and numbers")
    IF keywordHighlight THEN o(i).sel = 1

    i = i + 1
    o(i).typ = 3
    o(i).y = 19
    o(i).txt = idenewtxt("#OK" + sep + "Restore #defaults" + sep + "#Cancel")
    o(i).dft = 1

    result = ReadConfigSetting("SchemeID", value$)
    SchemeID = VAL(value$)
    IF SchemeID > TotalColorSchemes THEN SchemeID = 0

    IF SchemeID = 0 THEN
        a2$ = "User-defined"
    ELSE
        'Validate this scheme first
        FoundPipe = INSTR(ColorSchemes$(SchemeID), "|")
        IF FoundPipe > 0 THEN
            IF LEN(MID$(ColorSchemes$(SchemeID), FoundPipe + 1)) = 81 THEN
                a2$ = LEFT$(ColorSchemes$(SchemeID), FoundPipe - 1)
            ELSE
                SchemeID = 0
                a2$ = "User-defined"
            END IF
        ELSE
            SchemeID = 0
            a2$ = "User-defined"
        END IF
    END IF
    i = i + 1
    o(i).typ = 1
    o(i).x = 9
    o(i).y = 2
    o(i).w = 38
    o(i).nam = idenewtxt("#Scheme")
    o(i).txt = idenewtxt(a2$)
    o(i).v1 = LEN(a2$)

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
        'Color scheme selection arrows:
        LOCATE p.y + 2, p.x + 2
        IF mY = p.y + 2 AND mX >= p.x + 2 AND mX <= p.x + 4 THEN COLOR 15, 0 ELSE COLOR 15, 2
        IF SchemeID <= 1 THEN COLOR 7, 2
        PRINT " " + CHR$(17) + " ";
        IF mY = p.y + 2 AND mX >= p.x + 5 AND mX <= p.x + 7 THEN COLOR 15, 0 ELSE COLOR 15, 2
        IF SchemeID = LastValidColorScheme THEN COLOR 7, 2
        PRINT " " + CHR$(16) + " ";

        'Color scheme Save and Erase buttons:
        LOCATE p.y + 2, p.x + 60
        IF mY = p.y + 2 AND mX >= p.x + 60 AND mX <= p.x + 65 THEN COLOR 15, 0 ELSE COLOR 15, 2
        IF SchemeID > 0 AND SchemeID <= PresetColorSchemes THEN COLOR 7, 2 'Disable if preset scheme
        PRINT " Save ";
        IF mY = p.y + 2 AND mX >= p.x + 66 AND mX <= p.x + 72 THEN COLOR 15, 0 ELSE COLOR 15, 2
        IF SchemeID <= PresetColorSchemes THEN COLOR 7, 2 'Disable if preset scheme or unsaved user-defined
        PRINT " Erase ";

        COLOR , 7

        _PALETTECOLOR 1, IDEBackgroundColor, 0
        _PALETTECOLOR 2, _RGB32(84, 84, 84), 0 'dark gray - help system and interface details
        _PALETTECOLOR 6, IDEBackgroundColor2, 0
        _PALETTECOLOR 8, IDENumbersColor, 0
        _PALETTECOLOR 10, IDEMetaCommandColor, 0
        _PALETTECOLOR 11, IDECommentColor, 0
        _PALETTECOLOR 12, IDEKeywordColor, 0
        _PALETTECOLOR 13, IDETextColor, 0
        _PALETTECOLOR 14, IDEQuoteColor, 0

        COLOR 0: LOCATE p.y + 5, p.x + 36: PRINT "R: ";
        COLOR 4: PRINT STRING$(26, 196);
        slider$ = CHR$(197)
        T = VAL(idetxt(o(2).txt)): r = ((T / 255) * 26)
        IF T = 0 THEN slider$ = CHR$(195)
        IF T = 255 THEN slider$ = CHR$(180)
        LOCATE p.y + 5, p.x + 39 + r: PRINT slider$;

        COLOR 0: LOCATE p.y + 8, p.x + 36: PRINT "G: ";
        COLOR 5: PRINT STRING$(26, 196);
        slider$ = CHR$(197)
        T = VAL(idetxt(o(3).txt)): r = ((T / 255) * 26)
        IF T = 0 THEN slider$ = CHR$(195)
        IF T = 255 THEN slider$ = CHR$(180)
        LOCATE p.y + 8, p.x + 39 + r: PRINT slider$;

        COLOR 0: LOCATE p.y + 11, p.x + 36: PRINT "B: ";
        COLOR 9: PRINT STRING$(26, 196);
        slider$ = CHR$(197)
        T = VAL(idetxt(o(4).txt)): r = ((T / 255) * 26)
        IF T = 0 THEN slider$ = CHR$(195)
        IF T = 255 THEN slider$ = CHR$(180)
        LOCATE p.y + 11, p.x + 39 + r: PRINT slider$;

        COLOR 7, 1
        LOCATE p.y + 13, p.x + 39: PRINT CHR$(218); STRING$(25, 196);
        LOCATE p.y + 14, p.x + 39: PRINT CHR$(179); SPACE$(25);
        LOCATE p.y + 15, p.x + 39: PRINT CHR$(179); SPACE$(25);

        SELECT EVERYCASE SelectedITEM
            CASE 1: COLOR 13, 1: SampleText$ = "myVar% = " 'Normal text
            CASE 2: COLOR 12, 1: SampleText$ = "CLS: PRINT" 'Keywords
            CASE 3: COLOR 13, 1: SampleText$ = "myVar% = " 'Normal text
            CASE 4: COLOR 14, 1: SampleText$ = SPACE$(6) + CHR$(34) + "Hello, world!" + CHR$(34) 'Strings
            CASE 5: COLOR 10, 1: SampleText$ = "'$DYNAMIC" 'Metacommands
            CASE 6: COLOR 11, 1: SampleText$ = "'TODO: review this block" 'Comments
            CASE 7: COLOR 1, 1: SampleText$ = "" 'Background
            CASE 8: COLOR 6, 6: SampleText$ = SPACE$(25) 'Current line background
            CASE 9
                COLOR 6, 6: SampleText$ = "" 'Bracket highlight
                _PALETTECOLOR 6, IDEBracketHighlightColor, 0
        END SELECT

        LOCATE p.y + 14, p.x + 40: PRINT SampleText$;
        IF SelectedITEM = 1 OR SelectedITEM = 3 THEN
            COLOR 8, 1
            LOCATE p.y + 14, p.x + 49: PRINT "5";
        ELSEIF SelectedITEM = 2 THEN
            COLOR 13, 1
            LOCATE p.y + 14, p.x + 51: PRINT "myVar%";
        ELSEIF SelectedITEM = 4 THEN
            COLOR 12, 1
            LOCATE p.y + 14, p.x + 40: PRINT "PRINT";
        ELSEIF SelectedITEM = 5 THEN
            COLOR 11, 1
            LOCATE p.y + 14, p.x + 40: PRINT "'";
        ELSEIF SelectedITEM = 9 THEN
            LOCATE p.y + 14, p.x + 40
            COLOR 13, 1: PRINT "myVar% = ";
            COLOR 12: PRINT "INT RND";
            LOCATE p.y + 14, p.x + 52
            COLOR 13, 6: PRINT "(";
            LOCATE p.y + 14, p.x + 56
            PRINT ")";
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
            IF mX <> prev.mX OR mY <> prev.mY THEN change = 1: prev.mX = mX: prev.mY = mY
            alt = KALT: IF alt <> oldalt THEN change = 1
            oldalt = alt
            _LIMIT 100
        LOOP UNTIL change
        IF alt AND NOT KCTRL THEN idehl = 1 ELSE idehl = 0
        'convert "alt+letter" scancode to letter's ASCII character
        altletter$ = ""
        IF alt AND NOT KCTRL THEN
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
        IF (KSHIFT AND K$ = CHR$(9)) OR (INSTR(_OS$, "MAC") AND K$ = CHR$(25)) THEN focus = focus - 1: K$ = ""
        IF focus < 1 THEN focus = lastfocus
        IF focus > lastfocus THEN focus = 1
        f = 1
        FOR i = 1 TO 100
            T = o(i).typ
            IF T THEN
                focusoffset = focus - f
                ideobjupdate o(i), focus, f, focusoffset, K$, altletter$, mB, mousedown, mouseup, mX, mY, info, mWHEEL
            END IF
        NEXT
        '-------- end of generic input response --------

        'specific post controls
        IF focus <> PrevFocus THEN
            'Always start with RGB values AND scheme name selected upon getting focus
            PrevFocus = focus
            IF (focus >= 2 AND focus <= 4) OR focus = 11 THEN
                IF focus = 11 THEN tfocus = 9 ELSE tfocus = focus
                o(tfocus).v1 = LEN(idetxt(o(tfocus).txt))
                IF o(tfocus).v1 > 0 THEN o(tfocus).issel = -1
                o(tfocus).sx1 = 0
                IF (tfocus >= 2 AND tfocus <= 4) THEN prevTB.value$ = idetxt(o(tfocus).txt)
            END IF
        ELSEIF focus = PrevFocus THEN
            'Check if new values have been entered into textboxes
            IF focus >= 2 AND focus <= 4 THEN
                IF prevTB.value$ <> idetxt(o(focus).txt) THEN
                    GOSUB NewUserScheme
                    prevTB.value$ = idetxt(o(focus).txt)
                END IF
            END IF
        END IF

        'Save and Erase color scheme (Buttons):
        IF (SchemeID = 0 OR SchemeID > PresetColorSchemes) AND mCLICK THEN
            IF mY = p.y + 2 AND mX >= p.x + 60 AND mX <= p.x + 65 THEN
                'Save
                IF SchemeID = 0 THEN
                    SaveNew:
                    SchemeString$ = LTRIM$(RTRIM$(idetxt(o(9).txt)))
                    IF LEN(SchemeString$) = 0 THEN SchemeString$ = "User-defined"
                    'Find the next free scheme index
                    i = 0
                    DO
                        i = i + 1
                        result = ReadConfigSetting("Scheme" + str2$(i) + "$", value$)
                        IF value$ = "" OR value$ = "0" THEN EXIT DO
                    LOOP

                    'Build scheme string
                    SchemeString$ = SchemeString$ + "|"
                    FOR j = 1 TO 9
                        SELECT CASE j
                            CASE 1: CurrentColor~& = IDETextColor
                            CASE 2: CurrentColor~& = IDEKeywordColor
                            CASE 3: CurrentColor~& = IDENumbersColor
                            CASE 4: CurrentColor~& = IDEQuoteColor
                            CASE 5: CurrentColor~& = IDEMetaCommandColor
                            CASE 6: CurrentColor~& = IDECommentColor
                            CASE 7: CurrentColor~& = IDEBackgroundColor
                            CASE 8: CurrentColor~& = IDEBackgroundColor2
                            CASE 9: CurrentColor~& = IDEBracketHighlightColor
                        END SELECT

                        r$ = str2$(_RED32(CurrentColor~&)): r$ = STRING$(3 - LEN(r$), "0") + r$
                        g$ = str2$(_GREEN32(CurrentColor~&)): g$ = STRING$(3 - LEN(g$), "0") + g$
                        b$ = str2$(_BLUE32(CurrentColor~&)): b$ = STRING$(3 - LEN(b$), "0") + b$
                        SchemeString$ = SchemeString$ + r$ + g$ + b$
                    NEXT j

                    'Save user scheme
                    WriteConfigSetting "'[IDE COLOR SCHEMES]", "Scheme" + str2$(i) + "$", SchemeString$
                    LoadColorSchemes
                    SchemeID = PresetColorSchemes + i
                    ChangedScheme = -1
                    GOTO ApplyScheme
                ELSE
                    FoundPipe = INSTR(ColorSchemes$(SchemeID), "|")
                    SchemeString$ = LEFT$(ColorSchemes$(SchemeID), FoundPipe - 1)

                    IF SchemeString$ <> LTRIM$(RTRIM$(idetxt(o(9).txt))) THEN
                        'User wants to save the current SchemeID under a different name
                        GOTO SaveNew
                    END IF

                    i = SchemeID - PresetColorSchemes
                    SchemeString$ = SchemeString$ + "|"

                    'Build scheme string
                    FOR j = 1 TO 9
                        SELECT CASE j
                            CASE 1: CurrentColor~& = IDETextColor
                            CASE 2: CurrentColor~& = IDEKeywordColor
                            CASE 3: CurrentColor~& = IDENumbersColor
                            CASE 4: CurrentColor~& = IDEQuoteColor
                            CASE 5: CurrentColor~& = IDEMetaCommandColor
                            CASE 6: CurrentColor~& = IDECommentColor
                            CASE 7: CurrentColor~& = IDEBackgroundColor
                            CASE 8: CurrentColor~& = IDEBackgroundColor2
                            CASE 9: CurrentColor~& = IDEBracketHighlightColor
                        END SELECT

                        r$ = str2$(_RED32(CurrentColor~&)): r$ = STRING$(3 - LEN(r$), "0") + r$
                        g$ = str2$(_GREEN32(CurrentColor~&)): g$ = STRING$(3 - LEN(g$), "0") + g$
                        b$ = str2$(_BLUE32(CurrentColor~&)): b$ = STRING$(3 - LEN(b$), "0") + b$
                        SchemeString$ = SchemeString$ + r$ + g$ + b$
                    NEXT j

                    'Save user scheme
                    WriteConfigSetting "'[IDE COLOR SCHEMES]", "Scheme" + str2$(i) + "$", SchemeString$
                    LoadColorSchemes
                    SchemeID = PresetColorSchemes + i
                    ChangedScheme = -1
                    GOTO ApplyScheme
                END IF
                o(9).v1 = LEN(idetxt(o(9).txt))
                o(9).issel = -1
                o(9).sx1 = 0
            ELSEIF mY = p.y + 2 AND mX >= p.x + 66 AND mX <= p.x + 72 THEN
                'Erase
                IF SchemeID > PresetColorSchemes THEN
                    what$ = ideyesnobox("Erase color scheme", "This cannot be undone. Erase scheme?")
                    K$ = ""
                    IF what$ = "Y" THEN
                        i = SchemeID - PresetColorSchemes
                        WriteConfigSetting "'[IDE COLOR SCHEMES]", "Scheme" + str2$(i) + "$", "0"
                        LoadColorSchemes
                        SchemeID = SchemeID - 1
                        ChangedScheme = -1
                        SchemeArrow = -1
                        GOTO ValidateScheme
                    END IF
                END IF
            END IF
        END IF

        'Scheme selection arrows:
        ChangedScheme = 0
        SchemeArrow = 0
        IF (mCLICK AND mY = p.y + 2 AND mX >= p.x + 2 AND mX <= p.x + 4) OR _
           (K$ = CHR$(0) + CHR$(75) AND (focus = 1)) THEN
            SchemeArrow = -1
            IF SchemeID = 0 THEN
                ChangedScheme = -1
                GOTO LoadDefaultScheme
            ELSE
                IF SchemeID > 1 THEN SchemeID = SchemeID - 1: ChangedScheme = -1
            END IF
        ELSEIF (mCLICK AND mY = p.y + 2 AND mX >= p.x + 5 AND mX <= p.x + 7) OR _
               (K$ = CHR$(0) + CHR$(77) AND (focus = 1)) THEN
            SchemeArrow = 1
            IF SchemeID = 0 THEN
                ChangedScheme = -1
                GOTO LoadDefaultScheme
            ELSE
                IF SchemeID < TotalColorSchemes THEN SchemeID = SchemeID + 1: ChangedScheme = -1
            END IF
        END IF

        IF ChangedScheme THEN
            'Validate this scheme first
            IF SchemeArrow = 0 THEN SchemeArrow = 1
            ValidateScheme:
            FoundPipe = INSTR(ColorSchemes$(SchemeID), "|")
            IF FoundPipe > 0 THEN
                IF LEN(MID$(ColorSchemes$(SchemeID), FoundPipe + 1)) = 81 THEN
                    a2$ = LEFT$(ColorSchemes$(SchemeID), FoundPipe - 1)
                ELSE
                    SchemeID = SchemeID + SchemeArrow
                    IF SchemeID > TotalColorSchemes THEN SchemeID = TotalColorSchemes: SchemeArrow = -1
                    IF SchemeID < 1 THEN SchemeID = 1
                    GOTO ValidateScheme
                END IF
            ELSE
                SchemeID = SchemeID + SchemeArrow
                IF SchemeID > TotalColorSchemes THEN SchemeID = TotalColorSchemes: SchemeArrow = -1
                IF SchemeID < 1 THEN SchemeID = 1
                GOTO ValidateScheme
            END IF
            ApplyScheme:
            FoundPipe = INSTR(ColorSchemes$(SchemeID), "|")
            idetxt(o(9).txt) = LEFT$(ColorSchemes$(SchemeID), FoundPipe - 1)
            o(9).v1 = LEN(idetxt(o(9).txt))
            o(9).issel = -1
            o(9).sx1 = 0
            ColorData$ = RIGHT$(ColorSchemes$(SchemeID), 81)
            i = 1
            r$ = MID$(ColorData$, i, 3): i = i + 3: g$ = MID$(ColorData$, i, 3): i = i + 3: b$ = MID$(ColorData$, i, 3): i = i + 3
            IDETextColor = _RGB32(VAL(r$), VAL(g$), VAL(b$))
            r$ = MID$(ColorData$, i, 3): i = i + 3: g$ = MID$(ColorData$, i, 3): i = i + 3: b$ = MID$(ColorData$, i, 3): i = i + 3
            IDEKeywordColor = _RGB32(VAL(r$), VAL(g$), VAL(b$))
            r$ = MID$(ColorData$, i, 3): i = i + 3: g$ = MID$(ColorData$, i, 3): i = i + 3: b$ = MID$(ColorData$, i, 3): i = i + 3
            IDENumbersColor = _RGB32(VAL(r$), VAL(g$), VAL(b$))
            r$ = MID$(ColorData$, i, 3): i = i + 3: g$ = MID$(ColorData$, i, 3): i = i + 3: b$ = MID$(ColorData$, i, 3): i = i + 3
            IDEQuoteColor = _RGB32(VAL(r$), VAL(g$), VAL(b$))
            r$ = MID$(ColorData$, i, 3): i = i + 3: g$ = MID$(ColorData$, i, 3): i = i + 3: b$ = MID$(ColorData$, i, 3): i = i + 3
            IDEMetaCommandColor = _RGB32(VAL(r$), VAL(g$), VAL(b$))
            r$ = MID$(ColorData$, i, 3): i = i + 3: g$ = MID$(ColorData$, i, 3): i = i + 3: b$ = MID$(ColorData$, i, 3): i = i + 3
            IDECommentColor = _RGB32(VAL(r$), VAL(g$), VAL(b$))
            r$ = MID$(ColorData$, i, 3): i = i + 3: g$ = MID$(ColorData$, i, 3): i = i + 3: b$ = MID$(ColorData$, i, 3): i = i + 3
            IDEBackgroundColor = _RGB32(VAL(r$), VAL(g$), VAL(b$))
            r$ = MID$(ColorData$, i, 3): i = i + 3: g$ = MID$(ColorData$, i, 3): i = i + 3: b$ = MID$(ColorData$, i, 3): i = i + 3
            IDEBackgroundColor2 = _RGB32(VAL(r$), VAL(g$), VAL(b$))
            r$ = MID$(ColorData$, i, 3): i = i + 3: g$ = MID$(ColorData$, i, 3): i = i + 3: b$ = MID$(ColorData$, i, 3): i = i + 3
            IDEBracketHighlightColor = _RGB32(VAL(r$), VAL(g$), VAL(b$))
            GOTO ChangeTextBoxes
        END IF

        IF mB AND mY = p.y + 5 AND mX >= p.x + 39 AND mX <= p.x + 39 + 26 THEN
            newValue = (mX - p.x - 39) * (255 / 26)
            idetxt(o(2).txt) = str2$(newValue)
            IF _KEYDOWN(100305) OR _KEYDOWN(100306) THEN
                idetxt(o(3).txt) = str2$(newValue)
                idetxt(o(4).txt) = str2$(newValue)
            END IF
            focus = 2
            o(focus).v1 = LEN(idetxt(o(focus).txt))
            o(focus).issel = -1
            o(focus).sx1 = 0
            GOSUB NewUserScheme
        END IF

        IF mB AND mY = p.y + 8 AND mX >= p.x + 39 AND mX <= p.x + 39 + 26 THEN
            newValue = (mX - p.x - 39) * (255 / 26)
            idetxt(o(3).txt) = str2$(newValue)
            IF _KEYDOWN(100305) OR _KEYDOWN(100306) THEN
                idetxt(o(2).txt) = str2$(newValue)
                idetxt(o(4).txt) = str2$(newValue)
            END IF
            focus = 3
            o(focus).v1 = LEN(idetxt(o(focus).txt))
            o(focus).issel = -1
            o(focus).sx1 = 0
            GOSUB NewUserScheme
        END IF

        IF mB AND mY = p.y + 11 AND mX >= p.x + 39 AND mX <= p.x + 39 + 26 THEN
            newValue = (mX - p.x - 39) * (255 / 26)
            idetxt(o(4).txt) = str2$(newValue)
            IF _KEYDOWN(100305) OR _KEYDOWN(100306) THEN
                idetxt(o(2).txt) = str2$(newValue)
                idetxt(o(3).txt) = str2$(newValue)
            END IF
            focus = 4
            o(focus).v1 = LEN(idetxt(o(focus).txt))
            o(focus).issel = -1
            o(focus).sx1 = 0
            GOSUB NewUserScheme
        END IF

        ChangedWithKeys = 0
        IF K$ = CHR$(0) + CHR$(72) AND (focus = 2 OR focus = 3 OR focus = 4) THEN 'Up
            idetxt(o(focus).txt) = str2$(VAL(idetxt(o(focus).txt)) + 1)
            o(focus).issel = -1: o(focus).sx1 = 0: o(focus).v1 = LEN(idetxt(o(focus).txt))
            ChangedWithKeys = -1
            GOSUB NewUserScheme
        END IF

        IF K$ = CHR$(0) + CHR$(80) AND (focus = 2 OR focus = 3 OR focus = 4) THEN 'Down
            idetxt(o(focus).txt) = str2$(VAL(idetxt(o(focus).txt)) - 1)
            o(focus).issel = -1: o(focus).sx1 = 0: o(focus).v1 = LEN(idetxt(o(focus).txt))
            ChangedWithKeys = -1
            GOSUB NewUserScheme
        END IF

        IF SelectedITEM <> o(1).sel AND o(1).sel > 0 THEN
            SelectedITEM = o(1).sel
            FOR i = 1 TO 9: SelectionIndicator$(i) = " ": NEXT i
            SelectionIndicator$(SelectedITEM) = CHR$(16)

            i = 0
            i = i + 1: l$ = SelectionIndicator$(i) + "Normal Text"
            i = i + 1: l$ = l$ + sep + SelectionIndicator$(i) + "Keywords"
            i = i + 1: l$ = l$ + sep + SelectionIndicator$(i) + "Numbers"
            i = i + 1: l$ = l$ + sep + SelectionIndicator$(i) + "Strings"
            i = i + 1: l$ = l$ + sep + SelectionIndicator$(i) + "Metacommand/custom keywords"
            i = i + 1: l$ = l$ + sep + SelectionIndicator$(i) + "Comments"
            i = i + 1: l$ = l$ + sep + SelectionIndicator$(i) + "Background"
            i = i + 1: l$ = l$ + sep + SelectionIndicator$(i) + "Current line background"
            i = i + 1: l$ = l$ + sep + SelectionIndicator$(i) + "Bracket/selection highlight"
            idetxt(o(1).txt) = l$

            ChangeTextBoxes:
            SELECT CASE SelectedITEM
                CASE 1: CurrentColor~& = IDETextColor
                CASE 2: CurrentColor~& = IDEKeywordColor
                CASE 3: CurrentColor~& = IDENumbersColor
                CASE 4: CurrentColor~& = IDEQuoteColor
                CASE 5: CurrentColor~& = IDEMetaCommandColor
                CASE 6: CurrentColor~& = IDECommentColor
                CASE 7: CurrentColor~& = IDEBackgroundColor
                CASE 8: CurrentColor~& = IDEBackgroundColor2
                CASE 9: CurrentColor~& = IDEBracketHighlightColor
            END SELECT
            idetxt(o(2).txt) = str2$(_RED32(CurrentColor~&))
            idetxt(o(3).txt) = str2$(_GREEN32(CurrentColor~&))
            idetxt(o(4).txt) = str2$(_BLUE32(CurrentColor~&))
            IF focus >= 2 AND focus <= 4 AND ChangedScheme THEN
                prevTB.value$ = idetxt(o(focus).txt)
            END IF
        END IF

        'Check RGB values range (0-255)
        FOR checkRGB = 2 TO 4
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

        'Check for valid scheme name
        FoundPipe = INSTR(idetxt(o(9).txt), "|")
        IF FoundPipe > 0 THEN
            a2$ = LEFT$(idetxt(o(9).txt), FoundPipe - 1) + MID$(idetxt(o(9).txt), FoundPipe + 1)
            idetxt(o(9).txt) = a2$
            IF o(9).v1 >= FoundPipe THEN o(9).v1 = o(9).v1 - 1
        END IF

        IF SchemeID > 0 THEN
            FoundPipe = INSTR(ColorSchemes$(SchemeID), "|")
            IF RTRIM$(LTRIM$(idetxt(o(9).txt))) <> LEFT$(ColorSchemes$(SchemeID), FoundPipe - 1) THEN
                'A different scheme name is the beginning of editing a new one
                SchemeID = 0
            END IF
        END IF

        CurrentColor~& = _RGB32(VAL(idetxt(o(2).txt)), VAL(idetxt(o(3).txt)), VAL(idetxt(o(4).txt)))
        SELECT CASE SelectedITEM
            CASE 1: IDETextColor = CurrentColor~& 'Normal text
            CASE 2: IDEKeywordColor = CurrentColor~& 'Keywords
            CASE 3: IDENumbersColor = CurrentColor~& 'Numbers
            CASE 4: IDEQuoteColor = CurrentColor~& 'Strings
            CASE 5: IDEMetaCommandColor = CurrentColor~& 'Metacommands
            CASE 6: IDECommentColor = CurrentColor~& 'Comments
            CASE 7: IDEBackgroundColor = CurrentColor~& 'Background
            CASE 8: IDEBackgroundColor2 = CurrentColor~& 'Current line background
            CASE 9: IDEBracketHighlightColor = CurrentColor~& 'Bracket highlight
        END SELECT

        IF K$ = CHR$(27) OR (focus = 10 AND info <> 0) THEN
            IDECommentColor = bkpIDECommentColor
            IDEMetaCommandColor = bkpIDEMetaCommandColor
            IDEQuoteColor = bkpIDEQuoteColor
            IDETextColor = bkpIDETextColor
            IDEKeywordColor = bkpIDEKeywordColor
            IDEBackgroundColor = bkpIDEBackgroundColor
            IDEBackgroundColor2 = bkpIDEBackgroundColor2
            IDEBracketHighlightColor = bkpIDEBracketHighlightColor
            EXIT FUNCTION
        END IF

        IF (focus = 9 AND info <> 0) THEN
            LoadDefaultScheme:
            GOSUB enableHighlighter
            SchemeID = 1
            FoundPipe = INSTR(ColorSchemes$(SchemeID), "|")
            idetxt(o(9).txt) = LEFT$(ColorSchemes$(SchemeID), FoundPipe - 1)
            info = 0
            GOTO ApplyScheme
        END IF

    IF (focus = 8 AND info <> 0) OR _
       (focus = 1 AND K$ = CHR$(13)) OR _
       (focus = 2 AND K$ = CHR$(13)) OR _
       (focus = 3 AND K$ = CHR$(13)) OR _
       (focus = 4 AND K$ = CHR$(13)) OR _
       (focus = 5 AND K$ = CHR$(13)) OR _
       (focus = 6 AND K$ = CHR$(13)) OR _
       (focus = 7 AND K$ = CHR$(13)) OR _
       (focus = 11 AND K$ = CHR$(13)) THEN
            'save changes
            GOSUB enableHighlighter

            WriteConfigSetting "'[IDE COLOR SETTINGS]", "SchemeID", str2$(SchemeID)
            FOR i = 1 TO 9
                SELECT CASE i
                    CASE 1: CurrentColor~& = IDETextColor: colorid$ = "TextColor"
                    CASE 2: CurrentColor~& = IDEKeywordColor: colorid$ = "KeywordColor"
                    CASE 3: CurrentColor~& = IDENumbersColor: colorid$ = "NumbersColor"
                    CASE 4: CurrentColor~& = IDEQuoteColor: colorid$ = "QuoteColor"
                    CASE 5: CurrentColor~& = IDEMetaCommandColor: colorid$ = "MetaCommandColor"
                    CASE 6: CurrentColor~& = IDECommentColor: colorid$ = "CommentColor"
                    CASE 7: CurrentColor~& = IDEBackgroundColor: colorid$ = "BackgroundColor"
                    CASE 8: CurrentColor~& = IDEBackgroundColor2: colorid$ = "BackgroundColor2"
                    CASE 9: CurrentColor~& = IDEBracketHighlightColor: colorid$ = "HighlightColor"
                END SELECT
                r$ = str2$(_RED32(CurrentColor~&))
                g$ = str2$(_GREEN32(CurrentColor~&))
                b$ = str2$(_BLUE32(CurrentColor~&))

                RGBString$ = "_RGB32(" + r$ + "," + g$ + "," + b$ + ")"
                WriteConfigSetting "'[IDE COLOR SETTINGS]", colorid$, RGBString$
            NEXT i

            v% = o(5).sel
            IF v% <> 0 THEN v% = -1
            brackethighlight = v%

            IF brackethighlight THEN
                WriteConfigSetting "'[GENERAL SETTINGS]", "BracketHighlight", "TRUE"
            ELSE
                WriteConfigSetting "'[GENERAL SETTINGS]", "BracketHighlight", "FALSE"
            END IF

            v% = o(6).sel
            IF v% <> 0 THEN v% = -1
            multihighlight = v%

            IF multihighlight THEN
                WriteConfigSetting "'[GENERAL SETTINGS]", "MultiHighlight", "TRUE"
            ELSE
                WriteConfigSetting "'[GENERAL SETTINGS]", "MultiHighlight", "FALSE"
            END IF

            v% = o(7).sel
            IF v% <> 0 THEN v% = -1
            keywordHighlight = v%

            IF keywordHighlight THEN
                WriteConfigSetting "'[GENERAL SETTINGS]", "KeywordHighlight", "TRUE"
            ELSE
                WriteConfigSetting "'[GENERAL SETTINGS]", "KeywordHighlight", "FALSE"
            END IF

            EXIT FUNCTION
        END IF

        'end of custom controls

        mousedown = 0
        mouseup = 0
    LOOP

    idechoosecolorsbox = 0

    EXIT FUNCTION
    NewUserScheme:
    IF SchemeID > 0 AND SchemeID <= PresetColorSchemes THEN
        'If one of the preset schemes is currently selected,
        'create a new one. User-defined types can be freely
        'edited.
        SchemeID = 0
        idetxt(o(9).txt) = "User-defined"
    END IF
    RETURN

    enableHighlighter:
    IF DisableSyntaxHighlighter THEN
        DisableSyntaxHighlighter = 0
        WriteConfigSetting "'[GENERAL SETTINGS]", "DisableSyntaxHighlighter", "FALSE"
        menu$(OptionsMenuID, OptionsMenuDisableSyntax) = "Disable Syntax #Highlighter"
    END IF
    RETURN
END FUNCTION


FUNCTION idergbmixer$ (editing)
    '-------- generic dialog box header --------
    PCOPY 0, 2
    PCOPY 0, 1
    SCREEN , , 1, 0
    focus = 1
    DIM p AS idedbptype
    DIM o(1 TO 100) AS idedbotype
    DIM sep AS STRING * 1
    sep = CHR$(0)
    '-------- end of generic dialog box header --------

    '-------- init --------
    i = 0

    idepar p, 70, 11, "RGB Color Mixer"

    a2$ = "127"
    i = i + 1
    o(i).typ = 1
    o(i).x = 63
    o(i).y = 2
    o(i).txt = idenewtxt(a2$)
    o(i).v1 = LEN(a2$)
    o(i).issel = -1
    o(i).sx1 = 0

    a2$ = "127"
    i = i + 1
    o(i).typ = 1
    o(i).x = 63
    o(i).y = 5
    o(i).txt = idenewtxt(a2$)
    o(i).v1 = LEN(a2$)
    o(i).issel = -1
    o(i).sx1 = 0

    a2$ = "127"
    i = i + 1
    o(i).typ = 1
    o(i).x = 63
    o(i).y = 8
    o(i).txt = idenewtxt(a2$)
    o(i).v1 = LEN(a2$)
    o(i).issel = -1
    o(i).sx1 = 0

    i = i + 1
    o(i).typ = 3
    o(i).y = 11
    o(i).txt = idenewtxt("#Insert" + sep + "C#opy" + sep + "#Cancel")
    o(i).dft = 1

    prev.ideselect = ideselect

    IF editing THEN
        'Parse selection for RGB values:
        a$ = ""
        a2$ = ""
        IF ideselect THEN
            IF ideselecty1 = idecy THEN 'single line selected
                a$ = idegetline(idecy)
                sx1 = ideselectx1: sx2 = idecx
                IF sx2 < sx1 THEN SWAP sx1, sx2
                FOR x = sx1 TO sx2 - 1
                    IF x <= LEN(a$) THEN a2$ = a2$ + MID$(a$, x, 1) ELSE EXIT FOR
                NEXT
            END IF
        END IF
        a2$ = UCASE$(LTRIM$(RTRIM$(a2$)))

        IF LEN(a2$) = 0 THEN
            RGB_Lookup:
            'No selection found. Let's look for RGB values in the current line
            All_RGB$ = ""
            CurrentLine$ = idegetline(idecy)
            a$ = UCASE$(CurrentLine$)

            'In case there are multiple RGB values, we'll stick to the
            'one closer to the cursor.
            Found_RGB = 0
            DO
                Found_RGB = INSTR(Found_RGB + 1, a$, "RGB")
                IF Found_RGB = 0 THEN EXIT DO
                FindBracket1 = INSTR(Found_RGB, a$, "(")
                FindBracket2 = INSTR(FindBracket1, a$, ")")
                IF FindBracket1 > 0 AND FindBracket2 > 0 THEN
                    ''Check the number of commas in the brackets.
                    ''2 or 3 are accepted.
                    'RGBArgs$ = MID$(a$, FindBracket1 + 1, FindBracket2 - FindBracket1 - 1)
                    'TotalCommas = CountItems(RGBArgs$, ",")
                    'IF TotalCommas = 2 OR TotalCommas = 3 THEN All_RGB$ = All_RGB$ + MKI$(Found_RGB)
                    All_RGB$ = All_RGB$ + MKI$(Found_RGB)
                END IF
            LOOP

            IF LEN(All_RGB$) = 0 THEN GOTO NoRGBFound

            IF LEN(All_RGB$) = 2 THEN
                'IF only one RGB reference was found in the current line, then this is it
                a2$ = MID$(a$, CVI(All_RGB$))
                InsertRGBAt = CVI(All_RGB$)
            ELSE
                Check_RGB = 1
                DO
                    IF idecx >= CVI(MID$(All_RGB$, (Check_RGB + 1) * 2 - 1, 2)) THEN
                        Check_RGB = Check_RGB + 1
                        IF Check_RGB = LEN(All_RGB$) \ 2 THEN EXIT DO
                    ELSE
                        EXIT DO
                    END IF
                LOOP
                a2$ = MID$(a$, CVI(MID$(All_RGB$, Check_RGB * 2 - 1, 2)))
                InsertRGBAt = CVI(MID$(All_RGB$, Check_RGB * 2 - 1, 2))
            END IF
        END IF

        'Read RGB values and fill the textboxes
        DIM newSyntax AS _BYTE
        IF LEFT$(a2$, 4) = "RGB(" OR _
           LEFT$(a2$, 6) = "RGB32(" OR _
           LEFT$(a2$, 5) = "RGBA(" OR _
           LEFT$(a2$, 7) = "RGBA32(" THEN
            IF LEFT$(a2$, 6) = "RGB32(" THEN newSyntax = -1
            IF InsertRGBAt = 0 THEN InsertRGBAt = sx1
            FindComma1 = INSTR(a2$, ",")
            IF FindComma1 > 0 THEN
                FindComma2 = INSTR(FindComma1 + 1, a2$, ",")
                IF FindComma2 > 0 THEN
                    r$ = "": g$ = "": b$ = ""
                    FOR i = FindComma1 - 1 TO 1 STEP -1
                        IF ASC(a2$, i) >= 48 AND ASC(a2$, i) <= 57 THEN
                            r$ = MID$(a2$, i, 1) + r$
                        ELSE
                            EXIT FOR
                        END IF
                    NEXT i

                    FOR i = FindComma1 + 1 TO FindComma2 - 1
                        IF ASC(a2$, i) = 32 OR (ASC(a2$, i) >= 48 AND ASC(a2$, i) <= 57) THEN
                            g$ = g$ + MID$(a2$, i, 1)
                        ELSE
                            EXIT FOR
                        END IF
                    NEXT i

                    FOR i = FindComma2 + 1 TO LEN(a2$)
                        IF ASC(a2$, i) = 32 OR (ASC(a2$, i) >= 48 AND ASC(a2$, i) <= 57) THEN
                            b$ = b$ + MID$(a2$, i, 1)
                        ELSE
                            EXIT FOR
                        END IF
                    NEXT i

                    r = VAL(r$): IF r < 0 THEN r = 0
                    IF r > 255 THEN r = 255
                    g = VAL(g$): IF g < 0 THEN g = 0
                    IF g > 255 THEN g = 255
                    b = VAL(b$): IF b < 0 THEN b = 0
                    IF b > 255 THEN b = 255

                    idetxt(o(1).txt) = str2$(r)
                    idetxt(o(2).txt) = str2$(g)
                    idetxt(o(3).txt) = str2$(b)

                    FOR i = 1 TO 3
                        o(i).sx1 = 0
                        o(i).v1 = LEN(idetxt(o(i).txt))
                        IF o(i).v1 > 0 THEN o(i).issel = -1
                    NEXT i
                ELSEIF newSyntax THEN 'in case it's _RGB32(intensity, alpha)
                    r$ = ""
                    FOR i = FindComma1 - 1 TO 1 STEP -1
                        IF ASC(a2$, i) >= 48 AND ASC(a2$, i) <= 57 THEN
                            r$ = MID$(a2$, i, 1) + r$
                        ELSE
                            EXIT FOR
                        END IF
                    NEXT i

                    r = VAL(r$): IF r < 0 THEN r = 0
                    IF r > 255 THEN r = 255
                    g = r
                    b = r

                    idetxt(o(1).txt) = str2$(r)
                    idetxt(o(2).txt) = str2$(g)
                    idetxt(o(3).txt) = str2$(b)

                    FOR i = 1 TO 3
                        o(i).sx1 = 0
                        o(i).v1 = LEN(idetxt(o(i).txt))
                        IF o(i).v1 > 0 THEN o(i).issel = -1
                    NEXT i
                END IF
            ELSEIF newSyntax THEN
                '_RGB32(intensity)?
                FindComma1 = INSTR(a2$, ")")
                IF FindComma1 THEN
                    r$ = ""
                    FOR i = FindComma1 - 1 TO 1 STEP -1
                        IF ASC(a2$, i) >= 48 AND ASC(a2$, i) <= 57 THEN
                            r$ = MID$(a2$, i, 1) + r$
                        ELSE
                            EXIT FOR
                        END IF
                    NEXT i

                    r = VAL(r$): IF r < 0 THEN r = 0
                    IF r > 255 THEN r = 255
                    g = r
                    b = r

                    idetxt(o(1).txt) = str2$(r)
                    idetxt(o(2).txt) = str2$(g)
                    idetxt(o(3).txt) = str2$(b)

                    FOR i = 1 TO 3
                        o(i).sx1 = 0
                        o(i).v1 = LEN(idetxt(o(i).txt))
                        IF o(i).v1 > 0 THEN o(i).issel = -1
                    NEXT i
                END IF
            END IF
        ELSE
            'If a selection is present, it spans only one line, but
            'no _RGB is selected, let's try to find some _RGB around.
            IF ideselect AND ideselecty1 = idecy THEN
                ideselect = 0
                GOTO RGB_Lookup
            END IF
        END IF
    END IF
    NoRGBFound:
    CurrentColor~& = _RGB32(VAL(idetxt(o(1).txt)), VAL(idetxt(o(2).txt)), VAL(idetxt(o(3).txt)))
    _PALETTECOLOR 12, CurrentColor~&, 0
    _PALETTECOLOR 5, &HFF00A800, 0 'Original green may have been changed by the Help System, so 5 is now green
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
        LOCATE p.y + 2, p.x + 13: PRINT "R: ";
        COLOR 4: PRINT STRING$(46, 196);
        slider$ = CHR$(197)
        T = VAL(idetxt(o(1).txt)): r = ((T / 255) * 46)
        IF T = 0 THEN slider$ = CHR$(195)
        IF T = 255 THEN slider$ = CHR$(180)
        LOCATE p.y + 2, p.x + 15 + r: PRINT slider$;

        COLOR 0: LOCATE p.y + 5, p.x + 13: PRINT "G: ";
        COLOR 5: PRINT STRING$(46, 196);
        slider$ = CHR$(197)
        T = VAL(idetxt(o(2).txt)): r = ((T / 255) * 46)
        IF T = 0 THEN slider$ = CHR$(195)
        IF T = 255 THEN slider$ = CHR$(180)
        LOCATE p.y + 5, p.x + 15 + r: PRINT slider$;

        COLOR 0: LOCATE p.y + 8, p.x + 13: PRINT "B: ";
        COLOR 9: PRINT STRING$(46, 196);
        slider$ = CHR$(197)
        T = VAL(idetxt(o(3).txt)): r = ((T / 255) * 46)
        IF T = 0 THEN slider$ = CHR$(195)
        IF T = 255 THEN slider$ = CHR$(180)
        LOCATE p.y + 8, p.x + 15 + r: PRINT slider$;

        COLOR 0: LOCATE p.y + 9, p.x + 19: PRINT "Hold CTRL to drag all sliders at once.";

        COLOR 12
        FOR i = 2 TO 8
            LOCATE p.y + i, p.x + 2
            PRINT STRING$(10, 219);
        NEXT i
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
        IF alt AND NOT KCTRL THEN idehl = 1 ELSE idehl = 0
        'convert "alt+letter" scancode to letter's ASCII character
        altletter$ = ""
        IF alt AND NOT KCTRL THEN
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
        IF (KSHIFT AND K$ = CHR$(9)) OR (INSTR(_OS$, "MAC") AND K$ = CHR$(25)) THEN focus = focus - 1: K$ = ""
        IF focus < 1 THEN focus = lastfocus
        IF focus > lastfocus THEN focus = 1
        f = 1
        FOR i = 1 TO 100
            T = o(i).typ
            IF T THEN
                focusoffset = focus - f
                ideobjupdate o(i), focus, f, focusoffset, K$, altletter$, mB, mousedown, mouseup, mX, mY, info, mWHEEL
            END IF
        NEXT
        '-------- end of generic input response --------

        'specific post controls
        IF focus <> PrevFocus THEN
            'Always start with RGB values selected upon getting focus
            PrevFocus = focus
            IF focus >= 1 AND focus <= 3 THEN
                o(focus).v1 = LEN(idetxt(o(focus).txt))
                IF o(focus).v1 > 0 THEN o(focus).issel = -1
                o(focus).sx1 = 0
            END IF
        END IF

        IF mB AND mY = p.y + 2 AND mX >= p.x + 15 AND mX <= p.x + 15 + 46 THEN
            newValue = (mX - p.x - 15) * (255 / 46)
            idetxt(o(1).txt) = str2$(newValue)
            IF _KEYDOWN(100305) OR _KEYDOWN(100306) THEN
                idetxt(o(2).txt) = str2$(newValue)
                idetxt(o(3).txt) = str2$(newValue)
            END IF
            focus = 1
            o(focus).v1 = LEN(idetxt(o(focus).txt))
            o(focus).issel = -1
            o(focus).sx1 = 0
        END IF

        IF mB AND mY = p.y + 5 AND mX >= p.x + 15 AND mX <= p.x + 15 + 46 THEN
            newValue = (mX - p.x - 15) * (255 / 46)
            idetxt(o(2).txt) = str2$(newValue)
            IF _KEYDOWN(100305) OR _KEYDOWN(100306) THEN
                idetxt(o(1).txt) = str2$(newValue)
                idetxt(o(3).txt) = str2$(newValue)
            END IF
            focus = 2
            o(focus).v1 = LEN(idetxt(o(focus).txt))
            o(focus).issel = -1
            o(focus).sx1 = 0
        END IF

        IF mB AND mY = p.y + 8 AND mX >= p.x + 15 AND mX <= p.x + 15 + 46 THEN
            newValue = (mX - p.x - 15) * (255 / 46)
            idetxt(o(3).txt) = str2$(newValue)
            IF _KEYDOWN(100305) OR _KEYDOWN(100306) THEN
                idetxt(o(1).txt) = str2$(newValue)
                idetxt(o(2).txt) = str2$(newValue)
            END IF
            focus = 3
            o(focus).v1 = LEN(idetxt(o(focus).txt))
            o(focus).issel = -1
            o(focus).sx1 = 0
        END IF

        ChangedWithKeys = 0
        IF K$ = CHR$(0) + CHR$(72) AND (focus = 1 OR focus = 2 OR focus = 3) THEN 'Up
            idetxt(o(focus).txt) = str2$(VAL(idetxt(o(focus).txt)) + 1)
            o(focus).issel = -1: o(focus).sx1 = 0: o(focus).v1 = LEN(idetxt(o(focus).txt))
            ChangedWithKeys = -1
        END IF

        IF K$ = CHR$(0) + CHR$(80) AND (focus = 1 OR focus = 2 OR focus = 3) THEN 'Down
            idetxt(o(focus).txt) = str2$(VAL(idetxt(o(focus).txt)) - 1)
            o(focus).issel = -1: o(focus).sx1 = 0: o(focus).v1 = LEN(idetxt(o(focus).txt))
            ChangedWithKeys = -1
        END IF

        'Check RGB values range (0-255)
        FOR checkRGB = 1 TO 3
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

        CurrentColor~& = _RGB32(VAL(idetxt(o(1).txt)), VAL(idetxt(o(2).txt)), VAL(idetxt(o(3).txt)))
        IF newSyntax AND (idetxt(o(1).txt) = idetxt(o(2).txt) AND idetxt(o(2).txt) = idetxt(o(3).txt)) THEN
            CurrentRGB$ = idetxt(o(1).txt)
        ELSE
            CurrentRGB$ = idetxt(o(1).txt) + ", " + idetxt(o(2).txt) + ", " + idetxt(o(3).txt)
        END IF
        _PALETTECOLOR 12, CurrentColor~&, 0

        IF K$ = CHR$(27) OR (focus = 6 AND info <> 0) THEN
            ideselect = prev.ideselect
            EXIT FUNCTION
        END IF

        IF (focus = 5 AND info <> 0) THEN
            'Return the current RGB string
            IF (idetxt(o(1).txt) = idetxt(o(2).txt) AND idetxt(o(2).txt) = idetxt(o(3).txt)) THEN
                CurrentRGB$ = "_RGB32(" + idetxt(o(1).txt) + ")"
            ELSE
                CurrentRGB$ = "_RGB32(" + idetxt(o(1).txt) + ", " + idetxt(o(2).txt) + ", " + idetxt(o(3).txt) + ")"
            END IF

            _CLIPBOARD$ = CurrentRGB$
            ideselect = prev.ideselect
            EXIT FUNCTION
        END IF

    IF (focus = 4 AND info <> 0) OR _
       (focus = 1 AND K$ = CHR$(13)) OR _
       (focus = 2 AND K$ = CHR$(13)) OR _
       (focus = 3 AND K$ = CHR$(13)) OR _
       (focus = 4 AND K$ = CHR$(13)) THEN
            IF CurrentLine$ = "" THEN CurrentLine$ = idegetline(idecy)
            IF editing THEN
                'If we're changing an existing statement, let's insert the values
                IF InsertRGBAt > 0 THEN
                    FindBracket1 = INSTR(InsertRGBAt, CurrentLine$, "(")
                    FindBracket2 = INSTR(FindBracket1, CurrentLine$, ")")
                    OldRGB$ = MID$(CurrentLine$, FindBracket1, FindBracket2 - FindBracket1 + 1)
                    IF (newSyntax AND CountItems(OldRGB$, ",") = 1) OR CountItems(OldRGB$, ",") = 3 THEN 'If the current statement has the ALPHA parameter
                        FOR i = FindBracket2 TO FindBracket1 STEP -1
                            IF ASC(CurrentLine$, i) = 44 THEN FindBracket2 = i: EXIT FOR
                        NEXT i
                    END IF
                    NewLine$ = LEFT$(CurrentLine$, FindBracket1)
                    IF FindBracket2 = 0 THEN FindBracket2 = FindBracket1
                    NewLine$ = NewLine$ + CurrentRGB$
                    NewLine$ = NewLine$ + MID$(CurrentLine$, FindBracket2)
                    idechangemade = 1
                    idesetline idecy, NewLine$

                    'Select the inserted bit
                    ideselectx1 = FindBracket1 + 1
                    idecx = ideselectx1 + LEN(CurrentRGB$)
                    ideselecty1 = idecy
                    prev.ideselect = 1
                    CurrentRGB$ = "" 'return nothing since we've already inserted it above
                END IF
            END IF

            IF LEN(CurrentRGB$) THEN
                'Return the current RGB string
                IF (idetxt(o(1).txt) = idetxt(o(2).txt) AND idetxt(o(2).txt) = idetxt(o(3).txt)) THEN
                    CurrentRGB$ = "_RGB32(" + idetxt(o(1).txt) + ")"
                ELSE
                    CurrentRGB$ = "_RGB32(" + idetxt(o(1).txt) + ", " + idetxt(o(2).txt) + ", " + idetxt(o(3).txt) + ")"
                END IF
            END IF

            idergbmixer$ = CurrentRGB$
            ideselect = prev.ideselect
            EXIT FUNCTION
        END IF

        'end of custom controls

        mousedown = 0
        mouseup = 0
    LOOP
END FUNCTION

FUNCTION CountItems (SearchString$, Item$)
    DO
        Found = INSTR(Found + 1, SearchString$, Item$)
        IF Found = 0 THEN EXIT DO
        Total = Total + 1
    LOOP
    CountItems = Total
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
        IF MouseButtonSwapped THEN
            mB = _MOUSEBUTTON(2): mB2 = _MOUSEBUTTON(1)
        ELSE
            mB = _MOUSEBUTTON(1): mB2 = _MOUSEBUTTON(2)
        END IF
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
        IF IdeContextHelpSF = 0 THEN
            a$ = Wiki(Back$(1))
            WikiParse a$
        END IF
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
                IF IdeSystem = 3 AND Help_Select = 2 THEN
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
                IF IdeSystem = 3 AND Help_Select = 2 THEN
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
                IF IdeSystem = 3 AND Help_Select = 2 THEN
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

    IF ln = 0 THEN
        l$ = sep
    END IF

    '72,19

    h = idewy + idesubwindow - 9
    IF ln < h THEN h = ln
    IF h < 3 THEN h = 3

    i = 0
    idepar p, 20, h, ""
    p.x = idewx - 24
    p.y = idewy - 6 - h
    IF p.y < 3 THEN
        p.h = p.h - abs(3 - p.y)
        h = p.h
        p.y = 3
    END IF

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
        IF alt AND NOT KCTRL THEN idehl = 1 ELSE idehl = 0
        'convert "alt+letter" scancode to letter's ASCII character
        altletter$ = ""
        IF alt AND NOT KCTRL THEN
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
        IF (KSHIFT AND K$ = CHR$(9)) OR (INSTR(_OS$, "MAC") AND K$ = CHR$(25)) THEN focus = focus - 1: K$ = ""
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
    o(i).txt = idenewtxt("#OK" + sep + "#Cancel" + sep + "Clear #list" + sep + "#Remove broken links")
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
        IF alt AND NOT KCTRL THEN idehl = 1 ELSE idehl = 0
        'convert "alt+letter" scancode to letter's ASCII character
        altletter$ = ""
        IF alt AND NOT KCTRL THEN
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
        IF (KSHIFT AND K$ = CHR$(9)) OR (INSTR(_OS$, "MAC") AND K$ = CHR$(25)) THEN focus = focus - 1: K$ = ""
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
    menu$(m, i) = "#New  Ctrl+N": i = i + 1
    menu$(m, i) = "#Open...  Ctrl+O": i = i + 1
    menu$(m, i) = "#Save  Ctrl+S": i = i + 1
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
            IF LEN(f$) > 25 THEN f$ = STRING$(3, 250) + RIGHT$(f$, 22)
            IF r <= 4 THEN IdeRecentLink(r, 1) = f$
            menu$(m, i) = f$: i = i + 1
        END IF
    NEXT
    CLOSE #fh
    IF menu$(m, i - 1) <> "#Recent..." AND menu$(m, i - 1) <> "Save #As..." THEN
        menu$(m, i) = "Clear #Recent...": i = i + 1
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

    IF IdeSystem = 1 OR IdeSystem = 2 THEN
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
            IF LEN(a2$) > 0 THEN
                sela2$ = UCASE$(a2$)
                idecontextualSearch$ = a2$
                IF LEN(a2$) > 22 THEN
                    a2$ = LEFT$(a2$, 19) + STRING$(3, 250)
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
                FOR CleanseN = 1 TO LEN(n$)
                    SELECT CASE MID$(n$, CleanseN, 1)
                        CASE " ", "'", ":"
                            n$ = LEFT$(n$, CleanseN - 1)
                            EXIT FOR
                    END SELECT
                NEXT

                n2$ = n$
                IF LEN(n2$) > 1 THEN
                    DO UNTIL alphanumeric(ASC(RIGHT$(n2$, 1)))
                        n2$ = LEFT$(n$, LEN(n2$) - 1) 'removes sigil, if any
                    LOOP
                END IF

                'Populate SubFuncLIST()
                TotalSF = TotalSF + 1
                REDIM _PRESERVE SubFuncLIST(1 TO TotalSF) AS STRING
                SubFuncLIST(TotalSF) = MKL$(y) + CHR$(sf) + n2$
            END IF
        NEXT

        'identify if word or character at current cursor position is in the help system OR a sub/func
        '(copied/adapted from ide2)
        a$ = idegetline(idecy)
        a2$ = ""
        x = idecx
        IF x <= LEN(a$) AND x >= 1 THEN
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
        IF LEN(LTRIM$(RTRIM$(Selection$))) > 0 THEN
            DO UNTIL alphanumeric(ASC(RIGHT$(Selection$, 1)))
                Selection$ = LEFT$(Selection$, LEN(Selection$) - 1) 'removes sigil, if any
                IF LEN(Selection$) = 0 THEN EXIT DO
            LOOP
            Selection$ = LTRIM$(RTRIM$(Selection$))
        END IF

        IF RIGHT$(a2$, 1) = "$" THEN a3$ = LEFT$(a2$, LEN(a2$) - 1) ELSE a3$ = a2$ 'creates a new version without $

        IF LEN(a3$) > 0 OR LEN(Selection$) > 0 THEN

            FOR CheckSF = 1 TO TotalSF
                IF a3$ = UCASE$(MID$(SubFuncLIST(CheckSF), 6)) OR UCASE$(Selection$) = UCASE$(MID$(SubFuncLIST(CheckSF), 6)) THEN
                    CurrSF$ = FindCurrentSF$(idecy)
                    IF LEN(CurrSF$) = 0 THEN GOTO SkipCheckCurrSF

                    DO UNTIL alphanumeric(ASC(RIGHT$(CurrSF$, 1)))
                        CurrSF$ = LEFT$(CurrSF$, LEN(CurrSF$) - 1) 'removes sigil, if any
                        IF LEN(CurrSF$) = 0 THEN EXIT DO
                    LOOP
                    CurrSF$ = UCASE$(CurrSF$)

                    SkipCheckCurrSF:
                    IF ASC(SubFuncLIST(CheckSF), 5) = 1 THEN
                        CursorSF$ = "SUB "
                    ELSE
                        CursorSF$ = "FUNCTION "
                    END IF
                    CursorSF$ = CursorSF$ + MID$(SubFuncLIST(CheckSF), 6)

                    IF UCASE$(CursorSF$) = CurrSF$ THEN
                        EXIT FOR
                    ELSE
                        menu$(m, i) = "#Go To " + CursorSF$: i = i + 1
                        SubFuncLIST(1) = SubFuncLIST(CheckSF)
                        EXIT FOR
                    END IF
                END IF
            NEXT CheckSF

            v = 0
            CurrSF$ = FindCurrentSF$(idecy)
            IF NOT Error_Happened THEN v = HashFind(a2$, HASHFLAG_LABEL, ignore, r)
            CheckThisLabel:
            IF v THEN
                LabelLineNumber = Labels(r).SourceLineNumber
                ThisLabelScope$ = FindCurrentSF$(LabelLineNumber)
                IF ThisLabelScope$ <> CurrSF$ AND v = 2 THEN
                    v = HashFindCont(ignore, r)
                    GOTO CheckThisLabel
                END IF
                IF LabelLineNumber > 0 AND LabelLineNumber <> idecy THEN
                    menu$(m, i) = "Go To #Label " + RTRIM$(Labels(r).cn): i = i + 1
                    REDIM _PRESERVE SubFuncLIST(1 TO UBOUND(SubFuncLIST) + 1) AS STRING
                    SubFuncLIST(UBOUND(SubFuncLIST)) = MKL$(Labels(r).SourceLineNumber)
                END IF
            END IF
        END IF

        IF LEN(a2$) > 0 THEN
            'check if F1 is in help links
            fh = FREEFILE
            OPEN "internal\help\links.bin" FOR INPUT AS #fh
            lnks = 0: lnks$ = CHR$(0)
            DO UNTIL EOF(fh)
                LINE INPUT #fh, l$
                c = INSTR(l$, ","): l1$ = LEFT$(l$, c - 1): l2$ = RIGHT$(l$, LEN(l$) - c)
                IF a2$ = UCASE$(l1$) OR (qb64prefix_set = 1 AND LEFT$(l1$, 1) = "_" AND a2$ = MID$(l1$, 2)) THEN
                    IF INSTR(lnks$, CHR$(0) + l2$ + CHR$(0)) = 0 THEN
                        lnks = lnks + 1
                        EXIT DO
                    END IF
                END IF
            LOOP
            CLOSE #fh

            IF lnks THEN
                IF LEN(l2$) > 15 THEN
                    l2$ = LEFT$(l2$, 12) + STRING$(3, 250)
                END IF
                IF INSTR(l2$, "Parenthesis") = 0 THEN
                    menu$(m, i) = "#Help On '" + l2$ + "'": i = i + 1
                END IF
            END IF
        END IF

        IF i > 1 THEN
            menu$(m, i) = "-": i = i + 1
        END IF

        '--------- Check if _RGB mixer should be offered: -----------------------------------------
        a$ = idegetline(idecy)
        IF ideselect THEN
            IF ideselecty1 <> idecy THEN GOTO NoRGBFound 'multi line selected
        END IF

        Found_RGB = 0
        Found_RGB = Found_RGB + INSTR(UCASE$(a$), "RGB(")
        Found_RGB = Found_RGB + INSTR(UCASE$(a$), "RGB32(")
        Found_RGB = Found_RGB + INSTR(UCASE$(a$), "RGBA(")
        Found_RGB = Found_RGB + INSTR(UCASE$(a$), "RGBA32(")
        IF Found_RGB THEN
            menu$(m, i) = "#RGB Color Mixer...": i = i + 1
            menu$(m, i) = "-": i = i + 1
        END IF
        NoRGBFound:
        '--------- _RGB mixer check done.              --------------------------------------------

        IF (ideselect <> 0) THEN menu$(m, i) = "Cu#t  Shift+Del or Ctrl+X": i = i + 1
        IF (ideselect = 1) THEN
            menu$(m, i) = "#Copy  Ctrl+Ins or Ctrl+C": i = i + 1
        END IF

        clip$ = _CLIPBOARD$ 'read clipboard
        IF LEN(clip$) THEN menu$(m, i) = "#Paste  Shift+Ins or Ctrl+V": i = i + 1

        IF ideselect THEN menu$(m, i) = "Cl#ear  Del": i = i + 1
        menu$(m, i) = "Select #All  Ctrl+A": i = i + 1
        menu$(m, i) = "-": i = i + 1
        menu$(m, i) = "To#ggle Comment  Ctrl+T": i = i + 1
        menu$(m, i) = "Add Co#mment (')  Ctrl+R": i = i + 1
        menu$(m, i) = "Remove Comme#nt (')  Ctrl+Shift+R": i = i + 1
        IF ideselect THEN
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
                    menu$(m, i) = "#Increase Indent  TAB": i = i + 1
                    menu$(m, i) = "#Decrease Indent"
                    IF INSTR(_OS$, "WIN") OR INSTR(_OS$, "MAC") THEN menu$(m, i) = menu$(m, i) + "  Shift+TAB"
                    i = i + 1
                    menu$(m, i) = "-": i = i + 1
                END IF
            ELSE
                menu$(m, i) = "#Increase Indent  TAB": i = i + 1
                menu$(m, i) = "#Decrease Indent"
                IF INSTR(_OS$, "WIN") OR INSTR(_OS$, "MAC") THEN menu$(m, i) = menu$(m, i) + "  Shift+TAB"
                i = i + 1
                menu$(m, i) = "-": i = i + 1
            END IF
        ELSE
            menu$(m, i) = "-": i = i + 1
        END IF
        menu$(m, i) = "New #SUB...": i = i + 1
        menu$(m, i) = "New #FUNCTION...": i = i + 1
    ELSEIF IdeSystem = 3 THEN
        IF (Help_Select = 2) THEN
            menu$(m, i) = "#Copy  Ctrl+Ins or Ctrl+C": i = i + 1
        END IF
        menu$(m, i) = "Select #All  Ctrl+A": i = i + 1
        menu$(m, i) = "-": i = i + 1
        menu$(m, i) = "#Contents Page": i = i + 1
        menu$(m, i) = "Keyword #Index": i = i + 1
        menu$(m, i) = "#Keywords by Usage": i = i + 1
        menu$(m, i) = "-": i = i + 1
        menu$(m, i) = "#Update Current Page": i = i + 1
        menu$(m, i) = "Update All #Pages...": i = i + 1
        menu$(m, i) = "-": i = i + 1
        menu$(m, i) = "Clo#se Help  ESC": i = i + 1
    END IF
    menusize(m) = i - 1
END SUB

SUB IdeMakeEditMenu
    m = ideeditmenuID: i = 0
    menu$(m, i) = "Edit": i = i + 1

    IF IdeSystem = 1 THEN
        menu$(m, i) = "#Undo  Ctrl+Z": i = i + 1
        menu$(m, i) = "#Redo  Ctrl+Y": i = i + 1
    ELSE
        menu$(m, i) = "~#Undo  Ctrl+Z": i = i + 1
        menu$(m, i) = "~#Redo  Ctrl+Y": i = i + 1
    END IF
    menu$(m, i) = "-": i = i + 1

    IF (IdeSystem = 1 AND ideselect = 1) OR IdeSystem = 2 THEN
        menu$(m, i) = "Cu#t  Shift+Del or Ctrl+X": i = i + 1
        menu$(m, i) = "#Copy  Ctrl+Ins or Ctrl+C": i = i + 1
    ELSEIF (IdeSystem = 3 AND Help_Select = 2) THEN
        menu$(m, i) = "~Cu#t  Shift+Del or Ctrl+X": i = i + 1
        menu$(m, i) = "#Copy  Ctrl+Ins or Ctrl+C": i = i + 1
    ELSE
        menu$(m, i) = "~Cu#t  Shift+Del or Ctrl+X": i = i + 1
        menu$(m, i) = "~#Copy  Ctrl+Ins or Ctrl+C": i = i + 1
    END IF

    clip$ = _CLIPBOARD$ 'read clipboard
    IF (LEN(clip$) > 0 AND IdeSystem = 1) OR IdeSystem = 2 THEN
        menu$(m, i) = "#Paste  Shift+Ins or Ctrl+V": i = i + 1
    ELSE
        menu$(m, i) = "~#Paste  Shift+Ins or Ctrl+V": i = i + 1
    END IF

    IF (IdeSystem = 1 AND ideselect = 1) OR IdeSystem = 2 THEN
        menu$(m, i) = "Cl#ear  Del": i = i + 1
    ELSE
        menu$(m, i) = "~Cl#ear  Del": i = i + 1
    END IF

    menu$(m, i) = "Select #All  Ctrl+A": i = i + 1

    IF IdeSystem = 1 THEN
        menu$(m, i) = "-": i = i + 1
        menu$(m, i) = "To#ggle Comment  Ctrl+T": i = i + 1
        menu$(m, i) = "Add Co#mment (')  Ctrl+R": i = i + 1
        menu$(m, i) = "Remove Comme#nt (')  Ctrl+Shift+R": i = i + 1
        IF ideselect THEN
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
                    menu$(m, i) = "~#Increase Indent  TAB": i = i + 1
                    menu$(m, i) = "~#Decrease Indent"
                    IF INSTR(_OS$, "WIN") OR INSTR(_OS$, "MAC") THEN menu$(m, i) = menu$(m, i) + "  Shift+TAB"
                    i = i + 1
                ELSE
                    menu$(m, i) = "#Increase Indent  TAB": i = i + 1
                    menu$(m, i) = "#Decrease Indent"
                    IF INSTR(_OS$, "WIN") OR INSTR(_OS$, "MAC") THEN menu$(m, i) = menu$(m, i) + "  Shift+TAB"
                    i = i + 1
                END IF
            ELSE
                menu$(m, i) = "#Increase Indent  TAB": i = i + 1
                menu$(m, i) = "#Decrease Indent"
                IF INSTR(_OS$, "WIN") OR INSTR(_OS$, "MAC") THEN menu$(m, i) = menu$(m, i) + "  Shift+TAB"
                i = i + 1
            END IF
        ELSE
            menu$(m, i) = "~#Increase Indent  TAB": i = i + 1
            menu$(m, i) = "~#Decrease Indent"
            IF INSTR(_OS$, "WIN") OR INSTR(_OS$, "MAC") THEN menu$(m, i) = menu$(m, i) + "  Shift+TAB"
            i = i + 1
        END IF
        menu$(m, i) = "-": i = i + 1
        menu$(m, i) = "New #SUB...": i = i + 1
        menu$(m, i) = "New #FUNCTION...": i = i + 1
    ELSE
        menu$(m, i) = "-": i = i + 1
        menu$(m, i) = "~To#ggle Comment  Ctrl+T": i = i + 1
        menu$(m, i) = "~Add Co#mment (')  Ctrl+R": i = i + 1
        menu$(m, i) = "~Remove Comme#nt (')  Ctrl+Shift+R": i = i + 1
        menu$(m, i) = "~#Increase Indent  TAB": i = i + 1
        menu$(m, i) = "~#Decrease Indent"
        IF INSTR(_OS$, "WIN") OR INSTR(_OS$, "MAC") THEN menu$(m, i) = menu$(m, i) + "  Shift+TAB"
        i = i + 1
        menu$(m, i) = "-": i = i + 1
        menu$(m, i) = "~New #SUB...": i = i + 1
        menu$(m, i) = "~New #FUNCTION...": i = i + 1
    END IF
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

SUB ideupdatehelpbox
    '-------- generic dialog box header --------
    PCOPY 0, 2
    PCOPY 0, 1
    SCREEN , , 1, 0
    focus = 1
    DIM p AS idedbptype
    DIM o(1 TO 100) AS idedbotype
    DIM sep AS STRING * 1
    sep = CHR$(0)
    '-------- end of generic dialog box header --------

    '-------- init --------
    IF idehelp = 0 THEN
        old_idesubwindow = idesubwindow: old_idewy = idewy
        idesubwindow = idewy \ 2: idewy = idewy - idesubwindow
        Help_wx1 = 2: Help_wy1 = idewy + 1: Help_wx2 = idewx - 1: Help_wy2 = idewy + idesubwindow - 2: Help_ww = Help_wx2 - Help_wx1 + 1: Help_wh = Help_wy2 - Help_wy1 + 1
        idesubwindow = old_idesubwindow: idewy = old_idewy
    END IF

    MessageLines = 2
    DIM FullMessage$(1 TO 2)
    UpdateStep = 1

    i = 0
    w2 = LEN(titlestr$) + 4
    IF w < w2 THEN w = w2
    IF w < buttonsLen THEN w = buttonsLen
    IF w > idewx - 4 THEN w = idewx - 4
    idepar p, 60, 6, "Update Help"

    i = i + 1
    ButtonID = i
    o(i).typ = 3
    o(i).y = 6
    o(i).txt = idenewtxt("#Cancel")
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
        'update steps
        SELECT CASE UpdateStep
            CASE 1
                FullMessage$(2) = "Generating list of cached content..."
            CASE 2
                FullMessage$(2) = "Adding core help pages to list..."
            CASE 3
                FullMessage$(2) = "Regenerating keyword list..."
            CASE 4
                FullMessage$(2) = "Building download queue..."
            CASE 5
                FullMessage$(1) = "Updating help content file " + str2$(n) + "/" + str2$(c) +"..."
        END SELECT

        FOR i = 1 TO MessageLines
            IF i = 1 THEN COLOR 0, 7 ELSE COLOR 2, 7
            IF LEN(FullMessage$(i)) > p.w - 2 THEN
                FullMessage$(i) = LEFT$(FullMessage$(i), p.w - 5) + STRING$(3, 250)
            END IF
            LOCATE p.y + 1 + i, p.x + (p.w \ 2 - LEN(FullMessage$(i)) \ 2) + 1
            PRINT FullMessage$(i);
        NEXT i

        COLOR 0, 7
        IF UpdateStep = 5 THEN
            maxprogresswidth = 52 'arbitrary
            percentage = INT(n / c * 100)
            percentagechars = INT(maxprogresswidth * n / c)
            'percentageMsg$ = "[" + STRING$(percentagechars, 254) + SPACE$(maxprogresswidth - percentagechars) + "]" + STR$(percentage) + "%"
            percentageMsg$ = STRING$(percentagechars, 219) + STRING$(maxprogresswidth - percentagechars, 176) + STR$(percentage) + "%"
            LOCATE p.y + 4, p.x + (p.w \ 2 - LEN(percentageMsg$) \ 2) + 1
            PRINT percentageMsg$;
        ELSEIF UpdateStep = 6 THEN
            percentageMsg$ = STRING$(maxprogresswidth, 219) + " 100%"
            LOCATE p.y + 4, p.x + (p.w \ 2 - LEN(percentageMsg$) \ 2) + 1
            PRINT percentageMsg$;
        END IF
        '-------- end of custom display changes --------

        'update visual page and cursor position
        PCOPY 1, 0
        IF cx THEN SCREEN , , 0, 0: LOCATE cy, cx, 1: SCREEN , , 1, 0

        '-------- read input --------
        GetInput
        IF mCLICK THEN mousedown = 1
        IF mRELEASE THEN mouseup = 1
        alt = KALT
        oldalt = alt

        IF alt AND NOT KCTRL THEN idehl = 1 ELSE idehl = 0
        'convert "alt+letter" scancode to letter's ASCII character
        altletter$ = ""
        IF alt AND NOT KCTRL THEN
            IF LEN(K$) = 1 THEN
                k = ASC(UCASE$(K$))
                IF k >= 65 AND k <= 90 THEN altletter$ = CHR$(k)
            END IF
        END IF
        SCREEN , , 0, 0: LOCATE , , 0: SCREEN , , 1, 0
        '-------- end of read input --------

        '-------- generic input response --------
        info = 0

        IF UCASE$(K$) = "C" THEN altletter$ = UCASE$(K$)

        IF K$ = "" THEN K$ = CHR$(255)
        IF KSHIFT = 0 AND K$ = CHR$(9) THEN focus = focus + 1
        IF (KSHIFT AND K$ = CHR$(9)) OR (INSTR(_OS$, "MAC") AND K$ = CHR$(25)) THEN focus = focus - 1: K$ = ""
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
        IF K$ = CHR$(27) OR K$ = CHR$(13) OR (info <> 0) THEN
            IF UpdateStep < 6 THEN q$ = ideyesnobox("", "Cancel download?") ELSE q$ = "Y"
            IF q$ = "Y" THEN EXIT FUNCTION
        END IF
        'end of custom controls

        '-------- update routine -------------------------------------
        SELECT CASE UpdateStep
            CASE 1
                'Create a list of all files to be recached
                f$ = CHR$(0) + idezfilelist$("internal/help", 1, "") + CHR$(0)
                IF LEN(f$) = 2 THEN f$ = CHR$(0)

                'Prepend core pages to list
                f$ = CHR$(0) + "Keyword_Reference_-_By_usage.txt" + f$
                f$ = CHR$(0) + "QB64_Help_Menu.txt" + f$
                f$ = CHR$(0) + "QB64_FAQ.txt" + f$
                UpdateStep = UpdateStep + 1
            CASE 2
                UpdateStep = UpdateStep + 1
            CASE 3
                'Download and PARSE alphabetical index to build required F1 help links
                FullMessage$(1) = "Regenerating keyword list..."
                Help_Recaching = 1: Help_IgnoreCache = 1
                a$ = Wiki$("Keyword Reference - Alphabetical")
                Help_Recaching = 0: Help_IgnoreCache = 0
                WikiParse a$
                UpdateStep = UpdateStep + 1
            CASE 4
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

                    f$ = RIGHT$(f$, LEN(f$) - 1)
                    z$ = CHR$(0)
                    n = 0
                ELSE
                    GOTO stoprecache
                END IF
                FullMessage$(2) = ""
                UpdateStep = UpdateStep + 1
            CASE 5
                IF LEN(f$) > 0 THEN
                    x2 = INSTR(f$, z$)
                    f2$ = LEFT$(f$, x2 - 1): f$ = RIGHT$(f$, LEN(f$) - x2)

                    IF RIGHT$(f2$, 4) = ".txt" THEN
                        f2$ = LEFT$(f2$, LEN(f2$) - 4)
                        n = n + 1
                        FullMessage$(2) = "Page title: " + f2$
                        Help_IgnoreCache = 1: Help_Recaching = 1: ignore$ = Wiki(f2$): Help_Recaching = 0: Help_IgnoreCache = 0
                    END IF
                ELSE
                    UpdateStep = UpdateStep + 1
                END IF
            CASE 6
                stoprecache:
                FullMessage$(1) = "All pages updated."
                FullMessage$(2) = ""
                idetxt(o(ButtonID).txt) = "#Close"
        END SELECT
        '-------- end of update routine ------------------------------

        mousedown = 0
        mouseup = 0
    LOOP
END SUB

FUNCTION ideASCIIbox$(relaunch)

    '-------- generic dialog box header --------
    PCOPY 0, 2
    PCOPY 0, 1
    SCREEN , , 1, 0
    focus = 1
    DIM p AS idedbptype
    DIM o(1 TO 100) AS idedbotype
    DIM sep AS STRING * 1
    sep = CHR$(0)
    '-------- end of generic dialog box header --------

    '-------- init --------
    i = 0
    relaunch = 0
    idepar p, 56, 21, "ASCII Chart"

    i = i + 1
    o(i).typ = 1 'hidden text box to give focus to the chart
    o(i).y = 3
    o(i).x = 5
    o(i).w = 5

    TYPE position
        x AS INTEGER
        y AS INTEGER
        caption AS STRING
    END TYPE
    DIM asciiTable(1 TO 255) AS position

    a = 0
    x = 5
    y = 2
    FOR i = 0 TO 15
        FOR j = 0 TO 15
            a = a + 1
            IF a > 255 THEN EXIT FOR
            asciiTable(a).x = p.x + x
            asciiTable(a).y = p.y + y
            asciiTable(a).caption = " " + CHR$(a) + " "
            x = x + 3
        NEXT
        IF a > 255 THEN EXIT FOR
        x = 5
        y = y + 1
    NEXT

    i = i + 1
    o(i).typ = 3
    o(i).y = 21
    o(i).txt = idenewtxt("#Insert character" + sep + "Insert C#HR$" + sep + "#Close")
    o(i).dft = 1

    Selected = 1

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
        IF focus = 1 THEN
            idebox p.x + 4, p.y + 1, 50, 18
        END IF

        Hover = 0
        FOR i = 1 TO 255
            IF mX >= asciiTable(i).x AND mX <= asciiTable(i).x + 2 AND mY = asciiTable(i).y THEN
                IF mouseMoved THEN Hover = i: COLOR 7, 0
                IF mCLICK THEN
                    Selected = i
                    focus = 1
                    IF timeElapsedSince(lastClick!) <= .3 and lastClickOn = i THEN
                        'double click on chart
                        relaunch = -1
                        GOTO insertChar
                    END IF
                    lastClick! = TIMER
                    lastClickOn = i
                END IF
            ELSE
                COLOR 2, 7
            END IF
            IF Selected = i THEN COLOR 15, 0
            _PRINTSTRING (asciiTable(i).x, asciiTable(i).y), asciiTable(i).caption
        NEXT

        COLOR 0, 7
        IF Selected > 0 THEN
            _PRINTSTRING (p.x + 5, p.y + 19), "Selected:" + STR$(Selected)
        END IF

        COLOR 2, 7
        IF Hover > 0 AND Hover <> Selected THEN
            _PRINTSTRING (p.x + 5, p.y + 20), "Hovered: " + STR$(Hover)
        END IF

        '-------- end of custom display changes --------

        'update visual page and cursor position
        PCOPY 1, 0
        IF cx THEN
            SCREEN , , 0, 0
            IF focus = 1 THEN
                IF Selected THEN
                    LOCATE asciiTable(Selected).y, asciiTable(Selected).x + 1, 1
                END IF
            ELSE
                LOCATE cy, cx, 1
            END IF
            SCREEN , , 1, 0
        END IF

        '-------- read input --------
        change = 0
        mouseMoved = 0
        DO
            GetInput
            IF mWHEEL THEN change = 1
            IF KB THEN change = 1
            IF mCLICK THEN mousedown = 1: change = 1
            IF mRELEASE THEN mouseup = 1: change = 1
            IF mB THEN change = 1
            IF mX <> prev.mX OR mY <> prev.mY THEN change = 1: prev.mX = mX: prev.mY = mY: mouseMoved = -1
            alt = KALT: IF alt <> oldalt THEN change = 1
            oldalt = alt
            _LIMIT 100
        LOOP UNTIL change
        IF alt AND NOT KCTRL THEN idehl = 1 ELSE idehl = 0
        'convert "alt+letter" scancode to letter's ASCII character
        altletter$ = ""
        IF alt AND NOT KCTRL THEN
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
        IF (KSHIFT AND K$ = CHR$(9)) OR (INSTR(_OS$, "MAC") AND K$ = CHR$(25)) THEN focus = focus - 1: K$ = ""
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

        IF mY > p.y AND mY < p.y + p.h AND mX > p.x AND mX < p.x + p.w THEN
            IF Hover = 0 AND mCLICK THEN focus = 1
        END IF

        IF (K$ = CHR$(13) AND focus = 1) THEN
            ideASCIIbox$ = CHR$(Selected)
            EXIT FUNCTION
        END IF

        IF focus = 2 AND (K$ = CHR$(13) OR info <> 0) THEN
            insertChar:
            ideASCIIbox$ = CHR$(Selected)
            EXIT FUNCTION
        END IF

        IF (focus = 3 AND (info <> 0 OR K$ = CHR$(13))) THEN
            ideASCIIbox$ = "CHR$(" + str2$(Selected) + ")"
            EXIT FUNCTION
        END IF

        'Cancel:
        IF (info <> 0 OR K$ = CHR$(13)) AND focus = 4 THEN EXIT FUNCTION

        IF K$ = CHR$(27) THEN EXIT FUNCTION

        IF focus = 1 THEN 'chart control (keyboard)
            KCTRL = _KEYDOWN(100305) OR _KEYDOWN(100306)
            SELECT CASE KB
                CASE 18176: Selected = 1 'Home
                CASE 20224: Selected = 255 'End
                CASE 19712 'Right
                    IF KCTRL AND Selected > 0 THEN
                        DO UNTIL Selected MOD 16 = 0 OR Selected = 255
                            Selected = Selected + 1
                        LOOP
                    ELSE
                        Selected = Selected + 1
                    END IF
                    IF Selected > 255 THEN Selected = 1
                CASE 19200 'Left
                    IF KCTRL AND Selected > 0 THEN
                        DO UNTIL Selected MOD 16 = 1
                            Selected = Selected - 1
                        LOOP
                    ELSE
                        Selected = Selected - 1
                    END IF
                    IF Selected < 1 THEN Selected = 255
                CASE 20480 'Down
                    IF KCTRL AND Selected > 0 THEN
                        IF Selected = 240 THEN
                            Selected = 255
                        ELSE
                            DO UNTIL Selected >= 240
                                Selected = Selected + 16
                            LOOP
                        END IF
                        IF Selected > 255 THEN Selected = 255
                    ELSE
                        IF Selected = 240 THEN
                            'corner case
                            Selected = 255
                        ELSEIF Selected + 16 <= 255 THEN
                            Selected = Selected + 16
                        ELSE
                            Selected = Selected + 16 - 256
                        END IF
                    END IF
                CASE 18432 'Up
                    IF KCTRL AND Selected > 0 THEN
                        DO UNTIL Selected <= 16
                            Selected = Selected - 16
                        LOOP
                        IF Selected < 1 THEN Selected = 1
                    ELSE
                        IF Selected = 16 THEN
                            'corner case
                            Selected = 240
                        ELSEIF Selected - 16 >= 1 THEN
                            Selected = Selected - 16
                        ELSE
                            Selected = Selected - 16 + 256
                        END IF
                    END IF
            END SELECT
        END IF

        'end of custom controls
        mousedown = 0
        mouseup = 0
    LOOP

END FUNCTION


FUNCTION idef1box$ (lnks$, lnks)

    '-------- generic dialog box header --------
    PCOPY 0, 2
    PCOPY 0, 1
    SCREEN , , 1, 0
    focus = 1
    DIM p AS idedbptype
    DIM o(1 TO 100) AS idedbotype
    DIM sep AS STRING * 1
    sep = CHR$(0)
    '-------- end of generic dialog box header --------

    '-------- init --------


    '72,19
    i = 0
    idepar p, 40, lnks + 3, "Contextual help"

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
        IF alt AND NOT KCTRL THEN idehl = 1 ELSE idehl = 0
        'convert "alt+letter" scancode to letter's ASCII character
        altletter$ = ""
        IF alt AND NOT KCTRL THEN
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
        IF (KSHIFT AND K$ = CHR$(9)) OR (INSTR(_OS$, "MAC") AND K$ = CHR$(25)) THEN focus = focus - 1: K$ = ""
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

'After Cormen, Leiserson, Rivest & Stein "Introduction To Algoritms" via Wikipedia
SUB sort (arr() AS STRING * 998)
    FOR i& = LBOUND(arr) + 1 TO UBOUND(arr)
        x$ = arr(i&)
        j& = i& - 1
        WHILE j& >= LBOUND(arr)
            IF arr(j&) <= x$ THEN EXIT WHILE
            arr$(j& + 1) = arr$(j&)
            j& = j& - 1
        WEND
        arr$(j& + 1) = x$
    NEXT i&
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
            FOR check_quotes = 1 TO found_TITLE
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
    FOR wipe_INVALID = 1 TO LEN(TempFound_TITLE$)
        ThisChar$ = MID$(TempFound_TITLE$, wipe_INVALID, 1)
        IF INSTR(InvalidChars$, ThisChar$) = 0 THEN
            Found_TITLE$ = Found_TITLE$ + ThisChar$
        END IF
    NEXT wipe_INVALID

    FindProposedTitle$ = LTRIM$(RTRIM$(Found_TITLE$))
END FUNCTION

FUNCTION FindCurrentSF$ (whichline)
    'Get the name of the SUB/FUNCTION whichline is in.

    sfname$ = ""
    IF whichline > 0 THEN
        FOR currSF_CHECK = whichline TO 1 STEP -1
            thisline$ = idegetline(currSF_CHECK)
            thisline$ = LTRIM$(RTRIM$(thisline$))
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
                    thisline$ = RTRIM$(LTRIM$(thisline$))
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

SUB AddQuickNavHistory (LineNumber&)

    IF QuickNavTotal > 0 THEN
        IF QuickNavHistory(QuickNavTotal) = LineNumber& THEN EXIT SUB
    END IF

    QuickNavTotal = QuickNavTotal + 1
    REDIM _PRESERVE QuickNavHistory(1 TO QuickNavTotal) AS LONG

    QuickNavHistory(QuickNavTotal) = LineNumber&
END SUB

SUB UpdateIdeInfo
    'show info message (if any)
    IF LEN(IdeInfo) THEN
        IF ASC(IdeInfo, 1) = 0 THEN
            'Show progress bar
            IdeInfo = MID$(IdeInfo, 2)
            Percentage% = VAL(MID$(IdeInfo, 1, 3))
            COLOR 13, 1
            LOCATE idewy - 1, 2
            PRINT STRING$(((idewx - 2) * Percentage%) / 100, "_");
        END IF
    END IF
    a$ = IdeInfo
    IF LEN(a$) > (idewx - 20) THEN a$ = LEFT$(a$, (idewx - 23)) + STRING$(3, 250)
    IF LEN(a$) < (idewx - 20) THEN a$ = a$ + SPACE$((idewx - 20) - LEN(a$))
    COLOR 0, 3: LOCATE idewy + idesubwindow, 2
    PRINT a$;
    PCOPY 3, 0
END SUB

FUNCTION DarkenFGBG (Action AS _BYTE)
    'Darken the interface while compilation is taking place,
    'to give a sense of temporary unavailability:
    IF Action = 1 THEN
        TempDarkerBGColor~& = _RGB32(_RED32(IDEBackgroundColor) * .5, _GREEN32(IDEBackgroundColor) * .5, _BLUE32(IDEBackgroundColor) * .5)
        TempDarkerBG2Color~& = _RGB32(_RED32(IDEBackgroundColor2) * .5, _GREEN32(IDEBackgroundColor2) * .5, _BLUE32(IDEBackgroundColor2) * .5)
        TempDarkerFGColor~& = _RGB32(_RED32(IDETextColor) * .5, _GREEN32(IDETextColor) * .5, _BLUE32(IDETextColor) * .5)
        TempDarkerKWColor~& = _RGB32(_RED32(IDEKeywordColor) * .5, _GREEN32(IDEKeywordColor) * .5, _BLUE32(IDEKeywordColor) * .5)
        TempDarkerNumColor~& = _RGB32(_RED32(IDENumbersColor) * .5, _GREEN32(IDENumbersColor) * .5, _BLUE32(IDENumbersColor) * .5)
        TempDarkerCommentColor~& = _RGB32(_RED32(IDECommentColor) * .5, _GREEN32(IDECommentColor) * .5, _BLUE32(IDECommentColor) * .5)
        TempDarkerMetaColor~& = _RGB32(_RED32(IDEMetaCommandColor) * .5, _GREEN32(IDEMetaCommandColor) * .5, _BLUE32(IDEMetaCommandColor) * .5)
        TempDarkerQuoteColor~& = _RGB32(_RED32(IDEQuoteColor) * .5, _GREEN32(IDEQuoteColor) * .5, _BLUE32(IDEQuoteColor) * .5)
        _PALETTECOLOR 1, TempDarkerBGColor~&, 0
        _PALETTECOLOR 5, TempDarkerBGColor~&, 0
        _PALETTECOLOR 6, TempDarkerBG2Color~&, 0
        _PALETTECOLOR 8, TempDarkerNumColor~&, 0
        _PALETTECOLOR 10, TempDarkerMetaColor~&, 0
        _PALETTECOLOR 11, TempDarkerCommentColor~&, 0
        _PALETTECOLOR 12, TempDarkerKWColor~&, 0
        _PALETTECOLOR 13, TempDarkerFGColor~&, 0
        _PALETTECOLOR 14, TempDarkerQuoteColor~&, 0
    ELSE
        _PALETTECOLOR 1, IDEBackgroundColor, 0
        _PALETTECOLOR 5, IDEBracketHighlightColor, 0
        _PALETTECOLOR 6, IDEBackgroundColor2, 0
        _PALETTECOLOR 8, IDENumbersColor, 0
        _PALETTECOLOR 10, IDEMetaCommandColor, 0
        _PALETTECOLOR 11, IDECommentColor, 0
        _PALETTECOLOR 12, IDEKeywordColor, 0
        _PALETTECOLOR 13, IDETextColor, 0
        _PALETTECOLOR 14, IDEQuoteColor, 0
    END IF

    DarkenFGBG = 0
END SUB

SUB HideBracketHighlight
    'Restore the screen and hide any bracket highlights
    'as we're limited to 16 colors and the highlight
    'color will be used differently in this dialog.
    oldBracketHighlightSetting = brackethighlight
    oldMultiHighlightSetting = multihighlight
    brackethighlight = 0
    multihighlight = 0
    SCREEN , , 0
    HideCurrentLineHighlight = -1
    ideshowtext
    HideCurrentLineHighlight = 0
    brackethighlight = oldBracketHighlightSetting
    multihighlight = oldMultiHighlightSetting
END SUB

SUB LoadColorSchemes
    DIM i AS LONG
    'Preset built-in schemes
    PresetColorSchemes = 10
    REDIM ColorSchemes$(1 TO PresetColorSchemes): i = 0
    i = i + 1: ColorSchemes$(i) = "Super dark blue|216216216069118147216098078255167000085206085098098098000000039000049078000088108"
    i = i + 1: ColorSchemes$(i) = "Dark blue|226226226069147216245128177255177000085255085049196196000000069000068108000147177"
    i = i + 1: ColorSchemes$(i) = "QB64 Original|226226226147196235245128177255255085085255085085255255000000170000108177000147177"
    i = i + 1: ColorSchemes$(i) = "Classic QB4.5|177177177177177177177177177177177177177177177177177177000000170000000170000147177"
    i = i + 1: ColorSchemes$(i) = "CF Dark|226226226115222227255043138255178034185237049157118137043045037010000020088088088"
    i = i + 1: ColorSchemes$(i) = "Dark side|255255255206206000245010098000177000085255085049186245011022029100100100000147177"
    i = i + 1: ColorSchemes$(i) = "Camouflage|196196196255255255245128177255177000137177147147137020000039029098069020000147177"
    i = i + 1: ColorSchemes$(i) = "Plum|186186186255255255245128177255108000085186078085186255059000059088088128000147177"
    i = i + 1: ColorSchemes$(i) = "Light green|051051051000000216245128177255157255147177093206206206234255234206255206000147177"
    i = i + 1: ColorSchemes$(i) = "All white|051051051000000216245128177206147000059177000206206206255255255245245245000147177"
    TotalColorSchemes = PresetColorSchemes
    LastValidColorScheme = TotalColorSchemes

    'Load user color schemes
    i = 0
    DO
        i = i + 1
        result = ReadConfigSetting("Scheme" + str2$(i) + "$", value$)
        IF result THEN
            TotalColorSchemes = TotalColorSchemes + 1
            IF TotalColorSchemes > UBOUND(ColorSchemes$) THEN
                REDIM _PRESERVE ColorSchemes$(1 TO UBOUND(ColorSchemes$) + 10)
            END IF
            ColorSchemes$(TotalColorSchemes) = value$
            FoundPipe = INSTR(value$, "|")
            IF FoundPipe > 0 THEN
                IF LEN(MID$(value$, FoundPipe + 1)) = 81 THEN
                    'Extended schemes (9 colors):
                    LastValidColorScheme = TotalColorSchemes
                ELSEIF LEN(MID$(value$, FoundPipe + 1)) = 54 THEN
                    'Version 1.1 schemes (only 6 colors)
                    'Convert to extended scheme:
                    temp$ = LEFT$(value$, FoundPipe)
                    temp$ = temp$ + MID$(value$, FoundPipe + 1, 9) + "069147216245128177"
                    temp$ = temp$ + MID$(value$, FoundPipe + 10) + "000147177"
                    ColorSchemes$(TotalColorSchemes) = temp$
                    WriteConfigSetting "'[IDE COLOR SCHEMES]", "Scheme" + str2$(i) + "$", temp$
                    LastValidColorScheme = TotalColorSchemes
                ELSE
                    GOTO DiscardInvalid
                END IF
            ELSE
                DiscardInvalid:
                ColorSchemes$(TotalColorSchemes) = "0"
            END IF
        ELSE
            'No more schemes found
            EXIT DO
        END IF
    LOOP
    'End of color schemes
END SUB

FUNCTION BinaryFormatCheck% (pathToCheck$, pathSepToCheck$, fileToCheck$)

    file$ = pathToCheck$ + pathSepToCheck$ + fileToCheck$

    fh = FREEFILE
    OPEN file$ FOR BINARY AS #fh
    a$ = SPACE$(LOF(fh))
    GET #fh, 1, a$
    IF INSTR(a$, CHR$(0)) = 0 THEN CLOSE #fh: EXIT FUNCTION 'not a binary file
    a$ = ""
    GET #fh, 1, Format%
    GET #fh, , Version%
    CLOSE #fh

    SELECT CASE Format%
        CASE 2300 'VBDOS
            result = idemessagebox("Invalid format", "VBDOS binary format not supported.", "")
            BinaryFormatCheck% = 1
        CASE 764 'QBX 7.1
            result = idemessagebox("Invalid format", "QBX 7.1 binary format not supported.", "")
            BinaryFormatCheck% = 1
        CASE 252 'QuickBASIC 4.5
            IF INSTR(_OS$, "WIN") THEN
                convertUtility$ = "internal\utilities\QB45BIN.exe"
            ELSE
                convertUtility$ = "./internal/utilities/QB45BIN"
            END IF
            IF _FILEEXISTS(convertUtility$) THEN
                what$ = ideyesnobox("Binary format", "QuickBASIC 4.5 binary format detected. Convert to plain text?")
                IF what$ = "Y" THEN
                    ConvertIt:
                    IF FileHasExtension(file$) THEN
                        FOR i = LEN(file$) TO 1 STEP -1
                            IF ASC(file$, i) = 46 THEN
                                'keep previous extension
                                ofile$ = LEFT$(file$, i - 1) + " (converted)" + MID$(file$, i)
                                EXIT FOR
                            END IF
                        NEXT
                    ELSE
                        ofile$ = file$ + " (converted).bas"
                    END IF

                    SCREEN , , 3, 0
                    dummy = DarkenFGBG(1)
                    COLOR 7, 1: LOCATE idewy - 3, 2: PRINT SPACE$(idewx - 2);: LOCATE idewy - 2, 2: PRINT SPACE$(idewx - 2);: LOCATE idewy - 1, 2: PRINT SPACE$(idewx - 2); 'clear status window
                    LOCATE idewy - 3, 2
                    COLOR 15, 1
                    PRINT "Converting...          "
                    PCOPY 3, 0

                    convertLine$ = convertUtility$ + " " + QuotedFilename$(file$) + " -o " + QuotedFilename$(ofile$)
                    SHELL _HIDE convertLine$

                    COLOR 7, 1: LOCATE idewy - 3, 2: PRINT SPACE$(idewx - 2);: LOCATE idewy - 2, 2: PRINT SPACE$(idewx - 2);: LOCATE idewy - 1, 2: PRINT SPACE$(idewx - 2); 'clear status window
                    dummy = DarkenFGBG(0)
                    PCOPY 3, 0

                    IF _FILEEXISTS(ofile$) = 0 THEN
                        result = idemessagebox("Binary format", "Conversion failed.", "")
                        BinaryFormatCheck% = 2 'conversion failed
                    ELSE
                        pathToCheck$ = getfilepath$(ofile$)
                        IF LEN(pathToCheck$) THEN
                            fileToCheck$ = MID$(ofile$, LEN(pathToCheck$) + 1)
                            pathToCheck$ = LEFT$(pathToCheck$, LEN(pathToCheck$) - 1) 'remove path separator
                        ELSE
                            fileToCheck$ = ofile$
                        END IF
                    END IF
                ELSE
                    BinaryFormatCheck% = 1
                END IF
            ELSE
                IF _FILEEXISTS("source/utilities/QB45BIN.bas") = 0 THEN
                    result = idemessagebox("Binary format", "Conversion utility not found. Cannot open QuickBASIC 4.5 binary format.", "")
                    BinaryFormatCheck% = 1
                    EXIT FUNCTION
                END IF
                what$ = ideyesnobox("Binary format", "QuickBASIC 4.5 binary format detected. Convert to plain text?")
                IF what$ = "Y" THEN
                    'Compile the utility first, then convert the file
                    IF _DIREXISTS("./internal/utilities") = 0 THEN MKDIR "./internal/utilities"
                    PCOPY 3, 0
                    SCREEN , , 3, 0
                    dummy = DarkenFGBG(1)
                    COLOR 7, 1: LOCATE idewy - 3, 2: PRINT SPACE$(idewx - 2);: LOCATE idewy - 2, 2: PRINT SPACE$(idewx - 2);: LOCATE idewy - 1, 2: PRINT SPACE$(idewx - 2); 'clear status window
                    LOCATE idewy - 3, 2
                    COLOR 15, 1
                    PRINT "Preparing to convert..."
                    PCOPY 3, 0
                    IF INSTR(_OS$, "WIN") THEN
                        SHELL _HIDE "qb64 -x source/utilities/QB45BIN.bas -o internal/utilities/QB45BIN"
                    ELSE
                        SHELL _HIDE "./qb64 -x ./source/utilities/QB45BIN.bas -o ./internal/utilities/QB45BIN"
                    END IF
                    IF _FILEEXISTS(convertUtility$) THEN GOTO ConvertIt
                    COLOR 7, 1: LOCATE idewy - 3, 2: PRINT SPACE$(idewx - 2);: LOCATE idewy - 2, 2: PRINT SPACE$(idewx - 2);: LOCATE idewy - 1, 2: PRINT SPACE$(idewx - 2); 'clear status window
                    dummy = DarkenFGBG(0)
                    PCOPY 3, 0
                    result = idemessagebox("Binary format", "Error launching conversion utility.", "")
                END IF
                BinaryFormatCheck% = 1
            END IF
    END SELECT
END FUNCTION

FUNCTION removesymbol2$ (varname$)
    i = INSTR(varname$, "~"): IF i THEN GOTO foundsymbol
    i = INSTR(varname$, "`"): IF i THEN GOTO foundsymbol
    i = INSTR(varname$, "%"): IF i THEN GOTO foundsymbol
    i = INSTR(varname$, "&"): IF i THEN GOTO foundsymbol
    i = INSTR(varname$, "!"): IF i THEN GOTO foundsymbol
    i = INSTR(varname$, "#"): IF i THEN GOTO foundsymbol
    i = INSTR(varname$, "$"): IF i THEN GOTO foundsymbol
    removesymbol2$ = varname$
    EXIT FUNCTION
    foundsymbol:
    IF i = 1 THEN removesymbol2$ = varname$: EXIT FUNCTION
    removesymbol2$ = LEFT$(varname$, i - 1)
END FUNCTION

'$INCLUDE:'wiki\wiki_methods.bas'

