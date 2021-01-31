DIM SHARED IDECommentColor AS _UNSIGNED LONG, IDEMetaCommandColor AS _UNSIGNED LONG
DIM SHARED IDEQuoteColor AS _UNSIGNED LONG, IDETextColor AS _UNSIGNED LONG
DIM SHARED IDEBackgroundColor AS _UNSIGNED LONG
DIM SHARED IDEBackgroundColor2 AS _UNSIGNED LONG, IDEBracketHighlightColor AS _UNSIGNED LONG
DIM SHARED IDEKeywordColor AS _UNSIGNED LONG, IDENumbersColor AS _UNSIGNED LONG
DIM SHARED IDE_AutoPosition AS _BYTE, IDE_TopPosition AS INTEGER, IDE_LeftPosition AS INTEGER
DIM SHARED IDE_BypassAutoPosition AS _BYTE, idesortsubs AS _BYTE, IDESubsLength AS _BYTE
DIM SHARED IDENormalCursorStart AS LONG, IDENormalCursorEnd AS LONG
DIM SHARED IDE_Index$
DIM SHARED LoadedIDESettings AS INTEGER
DIM SHARED MouseButtonSwapped AS _BYTE
DIM SHARED PasteCursorAtEnd AS _BYTE
DIM SHARED SaveExeWithSource AS _BYTE, EnableQuickNav AS _BYTE
DIM SHARED IDEShowErrorsImmediately AS _BYTE
DIM SHARED ShowLineNumbersSeparator AS _BYTE, ShowLineNumbersUseBG AS _BYTE
DIM SHARED IgnoreWarnings AS _BYTE, qb64versionprinted AS _BYTE
DIM SHARED DisableSyntaxHighlighter AS _BYTE, ExeToSourceFolderFirstTimeMsg AS _BYTE
DIM SHARED WhiteListQB64FirstTimeMsg AS _BYTE, ideautolayoutkwcapitals AS _BYTE

IF LoadedIDESettings = 0 THEN
    'We only want to load the file once when QB64 first starts
    'Other changes should occur to our settings when we change them in their appropiate routines.
    'There's no reason to open and close and open and close the same file a million times.

    LoadedIDESettings = -1

    ConfigFile$ = "internal/config.txt"
    ConfigBak$ = "internal/config.bak"

    GOSUB CheckConfigFileExists 'make certain the config file exists and if not, create one

    result = ReadConfigSetting("AllowIndependentSettings", value$)
    IF result THEN
        IF value$ = "TRUE" OR ABS(VAL(value$)) = 1 THEN 'We default to false and only use one set of IDE settings, no matter how many windows we open up
            IDE_Index$ = "(" + LTRIM$(RTRIM$(STR$(tempfolderindex))) + ")"
            ConfigFile$ = "internal/config" + IDE_Index$ + ".txt"
            ConfigBak$ = "internal/config" + IDE_Index$ + ".bak"
            GOSUB CheckConfigFileExists
        ELSE
            WriteConfigSetting "'[GENERAL SETTINGS]", "AllowIndependentSettings", "FALSE"
            IDE_Index$ = ""
        END IF
    ELSE
        WriteConfigSetting "'[GENERAL SETTINGS]", "AllowIndependentSettings", "FALSE"
        IDE_Index$ = ""
    END IF

    result = ReadConfigSetting("ConfigVersion", value$) 'Not really used for anything at this point, but might be important in the future.
    ConfigFileVersion = VAL(value$) 'We'll get a config file version of 0 if there isn't any in the file

    result = ReadConfigSetting("CommentColor", value$)
    IF result THEN
        IDECommentColor = VRGBS(value$, _RGB32(98,98,98))
    ELSE
        IDECommentColor = _RGB32(98,98,98)
        WriteConfigSetting "'[IDE COLOR SETTINGS]", "CommentColor", "_RGB32(98,98,98)"
    END IF

    result = ReadConfigSetting("CustomKeywords$", value$)
    IF result THEN
        tempList$ = ""
        listOfCustomKeywords$ = "@" + UCASE$(value$) + "@"
        FOR i = 1 TO LEN (listOfCustomKeywords$)
            checkChar = ASC(listOfCustomKeywords$, i)
            IF checkChar = 64 THEN
                IF RIGHT$(tempList$, 1) <> "@" THEN tempList$ = tempList$ + "@"
            ELSE
                tempList$ = tempList$ + CHR$(checkChar)
            END IF
        NEXT
        listOfCustomKeywords$ = tempList$
        customKeywordsLength = LEN(listOfCustomKeywords$)
    ELSE
        WriteConfigSetting "'[CUSTOM DICTIONARIES]", "CustomKeywordsSyntax$", "@custom@keywords@separated@by@the@at@sign@"
        WriteConfigSetting "'[CUSTOM DICTIONARIES]", "CustomKeywords$", "@"
    END IF

    result = ReadConfigSetting("MetaCommandColor", value$)
    IF result THEN
        IDEMetaCommandColor = VRGBS(value$, _RGB32(85,206,85))
    ELSE
        IDEMetaCommandColor = _RGB32(85,206,85)
        WriteConfigSetting "'[IDE COLOR SETTINGS]", "MetaCommandColor", "_RGB32(85,206,85)"
    END IF

    result = ReadConfigSetting("KeywordColor", value$)
    IF result THEN
        IDEKeywordColor = VRGBS(value$, _RGB32(69,118,147))
    ELSE
        IDEKeywordColor = _RGB32(69,118,147)
        WriteConfigSetting "'[IDE COLOR SETTINGS]", "KeywordColor", "_RGB32(69,118,147)"
    END IF

    result = ReadConfigSetting("HighlightColor", value$)
    IF result THEN
        IDEBracketHighlightColor = VRGBS(value$, _RGB32(0,88,108))
    ELSE
        IDEBracketHighlightColor = _RGB32(0,88,108)
        WriteConfigSetting "'[IDE COLOR SETTINGS]", "HighlightColor", "_RGB32(0,88,108)"
    END IF

    result = ReadConfigSetting("NumbersColor", value$)
    IF result THEN
        IDENumbersColor = VRGBS(value$, _RGB32(216,98,78))
    ELSE
        IDENumbersColor = _RGB32(216,98,78)
        WriteConfigSetting "'[IDE COLOR SETTINGS]", "NumbersColor", "_RGB32(216,98,78)"
    END IF

    result = ReadConfigSetting("QuoteColor", value$)
    IF result THEN
        IDEQuoteColor = VRGBS(value$, _RGB32(255,167,0))
    ELSE
        IDEQuoteColor = _RGB32(255,167,0)
        WriteConfigSetting "'[IDE COLOR SETTINGS]", "QuoteColor", "_RGB32(255,167,0)"
    END IF

    result = ReadConfigSetting("TextColor", value$)
    IF result THEN
        IDETextColor = VRGBS(value$, _RGB32(216,216,216))
    ELSE
        IDETextColor = _RGB32(216,216,216)
        WriteConfigSetting "'[IDE COLOR SETTINGS]", "TextColor", "_RGB32(216,216,216)"
    END IF

    result = ReadConfigSetting("BackgroundColor", value$)
    IF result THEN
        IDEBackGroundColor = VRGBS(value$, _RGB32(0,0,39))
    ELSE
        IDEBackGroundColor = _RGB32(0,0,39)
        WriteConfigSetting "'[IDE COLOR SETTINGS]", "BackgroundColor", "_RGB32(0,0,39)"
    END IF

    result = ReadConfigSetting("BackgroundColor2", value$)
    IF result THEN
        IDEBackGroundColor2 = VRGBS(value$, _RGB32(0,49,78))
    ELSE
        IDEBackGroundColor2 = _RGB32(0,49,78)
        WriteConfigSetting "'[IDE COLOR SETTINGS]", "BackgroundColor2", "_RGB32(0,49,78)"
    END IF

    result = ReadConfigSetting("SwapMouseButton", value$)
    if value$ = "TRUE" or val(value$) = -1 then
        MouseButtonSwapped = -1
        WriteConfigSetting "'[MOUSE SETTINGS]", "SwapMouseButton", "TRUE"
    else
        MouseButtonSwapped = 0
        WriteConfigSetting "'[MOUSE SETTINGS]", "SwapMouseButton", "FALSE"
    end if

    result = ReadConfigSetting("DisableSyntaxHighlighter", value$)
    IF value$ = "TRUE" OR VAL(value$) = -1 THEN
        DisableSyntaxHighlighter = -1
        WriteConfigSetting "'[GENERAL SETTINGS]", "DisableSyntaxHighlighter", "TRUE"
    ELSE
        DisableSyntaxHighlighter = 0
        WriteConfigSetting "'[GENERAL SETTINGS]", "DisableSyntaxHighlighter", "FALSE"
    END IF

    result = ReadConfigSetting("PasteCursorAtEnd", value$)
    IF result THEN
        IF value$ = "TRUE" OR VAL(value$) = -1 THEN
            PasteCursorAtEnd = -1
        ELSE
            PasteCursorAtEnd = 0
            WriteConfigSetting "'[GENERAL SETTINGS]", "PasteCursorAtEnd", "FALSE"
        END IF
    ELSE
        WriteConfigSetting "'[GENERAL SETTINGS]", "PasteCursorAtEnd", "TRUE"
        PasteCursorAtEnd = -1
    END IF

    result = ReadConfigSetting("ExeToSourceFolderFirstTimeMsg", value$)
    IF result THEN
        IF value$ = "TRUE" OR VAL(value$) = -1 THEN
            ExeToSourceFolderFirstTimeMsg = -1
        ELSE
            ExeToSourceFolderFirstTimeMsg = 0
            WriteConfigSetting "'[GENERAL SETTINGS]", "ExeToSourceFolderFirstTimeMsg", "FALSE"
        END IF
    ELSE
        WriteConfigSetting "'[GENERAL SETTINGS]", "ExeToSourceFolderFirstTimeMsg", "FALSE"
        ExeToSourceFolderFirstTimeMsg = 0
    END IF

    result = ReadConfigSetting("WhiteListQB64FirstTimeMsg", value$)
    IF result THEN
        IF value$ = "TRUE" OR VAL(value$) = -1 THEN
            WhiteListQB64FirstTimeMsg = -1
        ELSE
            WhiteListQB64FirstTimeMsg = 0
            WriteConfigSetting "'[GENERAL SETTINGS]", "WhiteListQB64FirstTimeMsg", "FALSE"
        END IF
    ELSE
        WriteConfigSetting "'[GENERAL SETTINGS]", "WhiteListQB64FirstTimeMsg", "FALSE"
        WhiteListQB64FirstTimeMsg = 0
    END IF

    result = ReadConfigSetting("SaveExeWithSource", value$)
    IF result THEN
        IF value$ = "TRUE" OR VAL(value$) = -1 THEN
            SaveExeWithSource = -1
        ELSE
            SaveExeWithSource = 0
            WriteConfigSetting "'[GENERAL SETTINGS]", "SaveExeWithSource", "FALSE"
        END IF
    ELSE
        WriteConfigSetting "'[GENERAL SETTINGS]", "SaveExeWithSource", "FALSE"
        SaveExeWithSource = 0
    END IF

    result = ReadConfigSetting("EnableQuickNav", value$)
    IF result THEN
        IF value$ = "TRUE" OR VAL(value$) = -1 THEN
            EnableQuickNav = -1
        ELSE
            EnableQuickNav = 0
            WriteConfigSetting "'[GENERAL SETTINGS]", "EnableQuickNav", "FALSE"
        END IF
    ELSE
        WriteConfigSetting "'[GENERAL SETTINGS]", "EnableQuickNav", "TRUE"
        EnableQuickNav = -1
    END IF

    result = ReadConfigSetting("IDE_SortSUBs", value$)
    IF result THEN
        IF value$ = "TRUE" OR VAL(value$) = -1 THEN
            idesortsubs = -1
        ELSE
            idesortsubs = 0
            WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_SortSUBs", "FALSE"
        END IF
    ELSE
        WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_SortSUBs", "FALSE"
        idesortsubs = 0
    END IF

    result = ReadConfigSetting("IDE_KeywordCapital", value$)
    IF result THEN
        IF value$ = "TRUE" OR VAL(value$) = -1 THEN
            ideautolayoutkwcapitals = -1
        ELSE
            ideautolayoutkwcapitals = 0
            WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_KeywordCapital", "FALSE"
        END IF
    ELSE
        WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_KeywordCapital", "FALSE"
        ideautolayoutkwcapitals = 0
    END IF

    result = ReadConfigSetting("IDE_SUBsLength", value$)
    IF result THEN
        IF value$ = "TRUE" OR VAL(value$) = -1 THEN
            IDESubsLength = -1
        ELSE
            IDESubsLength = 0
            WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_SUBsLength", "FALSE"
        END IF
    ELSE
        WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_SUBsLength", "TRUE"
        IDESubsLength = -1
    END IF

    result = ReadConfigSetting("ShowErrorsImmediately", value$)
    IF result THEN
        IF value$ = "TRUE" OR VAL(value$) = -1 THEN
            IDEShowErrorsImmediately = -1
        ELSE
            IDEShowErrorsImmediately = 0
            WriteConfigSetting "'[GENERAL SETTINGS]", "ShowErrorsImmediately", "FALSE"
        END IF
    ELSE
        WriteConfigSetting "'[GENERAL SETTINGS]", "ShowErrorsImmediately", "TRUE"
        IDEShowErrorsImmediately = -1
    END IF

    result = ReadConfigSetting("ShowLineNumbers", value$)
    IF result THEN
        IF value$ = "TRUE" OR VAL(value$) = -1 THEN
            ShowLineNumbers = -1
        ELSE
            ShowLineNumbers = 0
            WriteConfigSetting "'[GENERAL SETTINGS]", "ShowLineNumbers", "FALSE"
        END IF
    ELSE
        WriteConfigSetting "'[GENERAL SETTINGS]", "ShowLineNumbers", "TRUE"
        ShowLineNumbers = -1
    END IF

    result = ReadConfigSetting("ShowLineNumbersSeparator", value$)
    IF result THEN
        IF value$ = "TRUE" OR VAL(value$) = -1 THEN
            ShowLineNumbersSeparator = -1
        ELSE
            ShowLineNumbersSeparator = 0
            WriteConfigSetting "'[GENERAL SETTINGS]", "ShowLineNumbersSeparator", "FALSE"
        END IF
    ELSE
        WriteConfigSetting "'[GENERAL SETTINGS]", "ShowLineNumbersSeparator", "TRUE"
        ShowLineNumbersSeparator = -1
    END IF

    result = ReadConfigSetting("ShowLineNumbersUseBG", value$)
    IF result THEN
        IF value$ = "TRUE" OR VAL(value$) = -1 THEN
            ShowLineNumbersUseBG = -1
        ELSE
            ShowLineNumbersUseBG = 0
            WriteConfigSetting "'[GENERAL SETTINGS]", "ShowLineNumbersUseBG", "FALSE"
        END IF
    ELSE
        WriteConfigSetting "'[GENERAL SETTINGS]", "ShowLineNumbersUseBG", "TRUE"
        ShowLineNumbersUseBG = -1
    END IF

    result = ReadConfigSetting("BracketHighlight", value$)
    IF result THEN
        IF value$ = "TRUE" OR VAL(value$) = -1 THEN
            brackethighlight = -1
        ELSE
            brackethighlight = 0
            WriteConfigSetting "'[GENERAL SETTINGS]", "BracketHighlight", "FALSE"
        END IF
    ELSE
        WriteConfigSetting "'[GENERAL SETTINGS]", "BracketHighlight", "TRUE"
        brackethighlight = -1
    END IF

    result = ReadConfigSetting("KeywordHighlight", value$)
    IF result THEN
        IF value$ = "TRUE" OR VAL(value$) = -1 THEN
            keywordHighlight = -1
        ELSE
            keywordHighlight = 0
            WriteConfigSetting "'[GENERAL SETTINGS]", "KeywordHighlight", "FALSE"
        END IF
    ELSE
        WriteConfigSetting "'[GENERAL SETTINGS]", "KeywordHighlight", "TRUE"
        keywordHighlight = -1
    END IF

    result = ReadConfigSetting("MultiHighlight", value$)
    IF result THEN
        IF value$ = "TRUE" OR VAL(value$) = -1 THEN
            multihighlight = -1
        ELSE
            multihighlight = 0
            WriteConfigSetting "'[GENERAL SETTINGS]", "MultiHighlight", "FALSE"
        END IF
    ELSE
        WriteConfigSetting "'[GENERAL SETTINGS]", "MultiHighlight", "TRUE"
        multihighlight = -1
    END IF

    IF INSTR(_OS$, "WIN") THEN
        result = ReadConfigSetting("IDE_AutoPosition", value$)
        IF result THEN
            IF UCASE$(value$) = "TRUE" OR ABS(VAL(value$)) = 1 THEN
                IDE_AutoPosition = -1
            ELSE
                IDE_AutoPosition = 0
                WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_AutoPosition", "FALSE"
            END IF
        ELSE
            IDE_AutoPosition = -1
            WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_AutoPosition", "TRUE"
        END IF

        result = ReadConfigSetting("IDE_TopPosition", value$)
        IF result THEN
            IDE_TopPosition = VAL(value$)
        ELSE
            IDE_BypassAutoPosition = -1 'If there's no position saved in the file, then we certainly don't need to try and auto-position to our last setting.
            IDE_TopPosition = 0
        END IF

        result = ReadConfigSetting("IDE_LeftPosition", value$)
        IF result THEN
            IDE_LeftPosition = VAL(value$)
        ELSE
            IDE_BypassAutoPosition = -1 'If there's no position saved in the file, then we certainly don't need to try and auto-position to our last setting.
            IDE_LeftPosition = 0
        END IF

        result = ReadConfigSetting("IgnoreWarnings", value$)
        IF result THEN
            IF UCASE$(value$) = "TRUE" OR ABS(VAL(value$)) = 1 THEN
                IgnoreWarnings = -1
            ELSE
                IgnoreWarnings = 0
                WriteConfigSetting "'[GENERAL SETTINGS]", "IgnoreWarnings", "FALSE"
            END IF
        END IF


        'I was going to do some basic error checking for screen position to make certain that we appeared on the monitor,
        'but I decided not to.  Some people (like me) may have multiple monitors set up and may wish for QB64 to pop-up at
        'a coordinate which seems insane at first glance (-1000,0 for instance), but which may move the IDE window to the
        'second monitor instead of the primary one.
        'I'm going to trust that the user doesn't go crazy and enter values like IDE_TopPosition = 123456789 or something insane...

    ELSE 'Linux doesn't work with _SCREENY or _SCREENY, so it's impossible to move the IDE properly.
        'These settings aren't included and are always set FALSE for them.
        IDE_AutoPosition = 0
        IDE_TopPosition = 0
        IDE_LeftPosition = 0
    END IF

    result = ReadConfigSetting("IDE_NormalCursorStart", value$)
    IDENormalCursorStart = VAL(value$)
    IF IDENormalCursorStart < 0 OR IDENormalCursorStart > 31 OR result = 0 THEN IDENormalCursorStart = 8: WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_NormalCursorStart", "8"

    result = ReadConfigSetting("IDE_NormalCursorEnd", value$)
    IDENormalCursorEnd = VAL(value$)
    IF IDENormalCursorEnd < 0 OR IDENormalCursorEnd > 31 OR result = 0 THEN IDENormalCursorEnd = 8: WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_NormalCursorEnd", "8"

    result = ReadConfigSetting("IDE_Width", value$)
    idewx = VAL(value$)
    IF idewx < 80 OR idewx > 1000 THEN idewx = 80: WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_Width", "80"

    result = ReadConfigSetting("IDE_Height", value$)
    idewy = VAL(value$)
    IF idewy < 25 OR idewy > 1000 THEN idewy = 25: WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_Height", "25"

    result = ReadConfigSetting("IDE_AutoFormat", value$)
    ideautolayout = VAL(value$)
    IF UCASE$(value$) = "TRUE" OR ideautolayout <> 0 THEN
        ideautolayout = 1
    ELSE
        IF UCASE$(value$) <> "FALSE" AND value$ <> "0" THEN
            WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_AutoFormat", "TRUE"
            ideautolayout = 1
        else
            ideautolayout = 0
        end if
    END IF

    result = ReadConfigSetting("IDE_AutoIndent", value$)
    ideautoindent = VAL(value$)
    IF UCASE$(value$) = "TRUE" OR ideautoindent <> 0 THEN
        ideautoindent = 1
    ELSE
        IF UCASE$(value$) <> "FALSE" AND value$ <> "0" THEN
            WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_AutoIndent", "TRUE"
            ideautoindent = 1
        else
            ideautoindent = 0
        end if
    END IF

    result = ReadConfigSetting("IDE_IndentSUBs", value$)
    ideindentsubs = VAL(value$)
    IF UCASE$(value$) = "TRUE" OR ideindentsubs <> 0 THEN
        ideindentsubs = 1
    ELSE
        IF UCASE$(value$) <> "FALSE" AND value$ <> "0" THEN
            WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_IndentSUBs", "TRUE"
            ideindentsubs = 1
        else
            ideindentsubs = 0
        end if
    END IF

    result = ReadConfigSetting("IDE_IndentSize", value$)
    ideautoindentsize = VAL(value$)
    if ideautoindentsize < 1 OR ideautoindentsize > 64 then
        ideautoindentsize = 4
        WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_IndentSize", "4"
    end if

    result = ReadConfigSetting("IDE_CustomFont", value$)
    idecustomfont = VAL(value$)
    IF UCASE$(value$) = "TRUE" OR idecustomfont <> 0 THEN
       idecustomfont = 1
    ELSE
       WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_CustomFont", "FALSE"
       idecustomfont = 0
    END IF

    result = ReadConfigSetting("IDE_UseFont8", value$)
    IF UCASE$(value$) = "TRUE" THEN
       IDE_UseFont8 = 1
    ELSE
       WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_UseFont8", "FALSE"
       IDE_UseFont8 = 0
    END IF

    result = ReadConfigSetting("IDE_CustomFont$", value$)
    idecustomfontfile$ = value$
    if result = 0 OR idecustomfontfile$ = "" then
        WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_CustomFont$", "c:\windows\fonts\lucon.ttf"
        idecustomfontfile$ = "c:\windows\fonts\lucon.ttf"
    end if

    result = ReadConfigSetting("IDE_CustomFontSize", value$)
    idecustomfontheight = VAL(value$)
    IF idecustomfontheight < 8 OR idecustomfontheight > 100 THEN idecustomfontheight = 21: WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_CustomFontSize", "21"

    result = ReadConfigSetting("IDE_CodePage", value$)
    idecpindex = VAL(value$)
    IF idecpindex < 0 OR idecpindex > idecpnum THEN idecpindex = 0: WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_CodePage", "0"

    result = ReadConfigSetting("BackupSize", value$)
    idebackupsize = VAL(value$)
    IF idebackupsize < 10 OR idebackupsize > 2000 THEN idebackupsize = 100: WriteConfigSetting "'[GENERAL SETTINGS]", "BackupSize", "100 'in MB"

    result = ReadConfigSetting("DebugInfo", value$)
    idedebuginfo = VAL(value$)
    IF UCASE$(LEFT$(value$, 4)) = "TRUE" THEN idedebuginfo = 1
    IF result = 0 OR idedebuginfo <> 1 THEN
        WriteConfigSetting "'[GENERAL SETTINGS]", "DebugInfo", "FALSE 'INTERNAL VARIABLE USE ONLY!! DO NOT MANUALLY CHANGE!"
        idedebuginfo = 0
    END IF
    Include_GDB_Debugging_Info = idedebuginfo

    GOTO SkipCheckConfigFileExists
    CheckConfigFileExists:
    IF _FILEEXISTS(ConfigFile$) = 0 THEN
        'There's no config file in the folder.  Let's make one for future use.
        IF ConfigFile$ = "internal/config.txt" THEN 'It's the main file which we use for default/global settings
            WriteConfigSetting "'[CONFIG VERSION]", "ConfigVersion", "1"
            IF INSTR(_OS$, "WIN") THEN WriteConfigSetting "'[GENERAL SETTINGS]", "AllowIndependentSettings", "FALSE"
            WriteConfigSetting "'[GENERAL SETTINGS]", "BackupSize", "100 'in MB"
            WriteConfigSetting "'[GENERAL SETTINGS]", "DebugInfo", "FALSE 'INTERNAL VARIABLE USE ONLY!! DO NOT MANUALLY CHANGE!"
            WriteConfigSetting "'[IDE COLOR SETTINGS]", "SchemeID", "1"
            IF INSTR(_OS$, "WIN") THEN
                WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_AutoPosition", "TRUE"
            END IF
            WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_Width", "80"
            WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_Height", "25"
            WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_IndentSize", "4"
            WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_AutoIndent", "TRUE"
            WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_AutoFormat", "TRUE"
            WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_CustomFontSize", "21"
            WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_CustomFont$", "c:\windows\fonts\lucon.ttf"
            WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_CustomFont", "FALSE"
            WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_CodePage", "0"
            WriteConfigSetting "'[MOUSE SETTINGS]", "SwapMouseButton", "FALSE"
        ELSE
            'use the main config file as the default values and just copy it over to the new file
            f = FREEFILE
            OPEN "internal/config.txt" FOR BINARY AS #f
            L = LOF(f): temp$ = SPACE$(L)
            GET #f, 1, temp$
            CLOSE #f
            OPEN ConfigFile$ FOR BINARY AS #f
            PUT #f, 1, temp$
            CLOSE #f
        END IF
    END IF
    RETURN
    SkipCheckConfigFileExists:
END IF

