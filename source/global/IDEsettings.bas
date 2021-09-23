DIM SHARED IDECommentColor AS _UNSIGNED LONG, IDEMetaCommandColor AS _UNSIGNED LONG
DIM SHARED IDEQuoteColor AS _UNSIGNED LONG, IDETextColor AS _UNSIGNED LONG
DIM SHARED IDEBackgroundColor AS _UNSIGNED LONG
DIM SHARED IDEBackgroundColor2 AS _UNSIGNED LONG, IDEBracketHighlightColor AS _UNSIGNED LONG
DIM SHARED IDEKeywordColor AS _UNSIGNED LONG, IDENumbersColor AS _UNSIGNED LONG
DIM SHARED IDE_AutoPosition AS _BYTE, IDE_TopPosition AS INTEGER, IDE_LeftPosition AS INTEGER
DIM SHARED IDE_BypassAutoPosition AS _BYTE, idesortsubs AS _BYTE, IDESubsLength AS _BYTE
DIM SHARED IDENormalCursorStart AS LONG, IDENormalCursorEnd AS LONG
DIM SHARED MouseButtonSwapped AS _BYTE
DIM SHARED PasteCursorAtEnd AS _BYTE
DIM SHARED SaveExeWithSource AS _BYTE, EnableQuickNav AS _BYTE
DIM SHARED IDEShowErrorsImmediately AS _BYTE
DIM SHARED ShowLineNumbersSeparator AS _BYTE, ShowLineNumbersUseBG AS _BYTE
DIM SHARED IgnoreWarnings AS _BYTE, qb64versionprinted AS _BYTE
DIM SHARED DisableSyntaxHighlighter AS _BYTE, ExeToSourceFolderFirstTimeMsg AS _BYTE
DIM SHARED WhiteListQB64FirstTimeMsg AS _BYTE, ideautolayoutkwcapitals AS _BYTE
DIM SHARED WatchListToConsole AS _BYTE
DIM SHARED windowSettingsSection$, colorSettingsSection$, customDictionarySection$
DIM SHARED mouseSettingsSection$, generalSettingsSection$, displaySettingsSection$
DIM SHARED colorSchemesSection$, debugSettingsSection$, iniFolderIndex$, DebugInfoIniWarning$, ConfigFile$
DIM SHARED idebaseTcpPort AS LONG, AutoAddDebugCommand AS _BYTE

ConfigFile$ = "internal/config.ini"
iniFolderIndex$ = STR$(tempfolderindex)
DebugInfoIniWarning$ = " 'Do not change manually. Use 'qb64 -s', or Options->Advanced in the IDE"

windowSettingsSection$ = "IDE WINDOW" + iniFolderIndex$
colorSettingsSection$ = "IDE COLOR SETTINGS" + iniFolderIndex$
colorSchemesSection$ = "IDE COLOR SCHEMES"
customDictionarySection$ = "CUSTOM DICTIONARIES"
mouseSettingsSection$ = "MOUSE SETTINGS"
generalSettingsSection$ = "GENERAL SETTINGS"
displaySettingsSection$ = "IDE DISPLAY SETTINGS"
debugSettingsSection$ = "DEBUG SETTINGS"

IniSetAddQuotes 0
IniSetForceReload -1
IniSetAllowBasicComments -1
IniSetAutoCommit -1

'General settings -------------------------------------------------------------
result = ReadConfigSetting(generalSettingsSection$, "DisableSyntaxHighlighter", value$)
IF UCASE$(value$) = "TRUE" OR VAL(value$) = -1 THEN
    DisableSyntaxHighlighter = -1
    WriteConfigSetting generalSettingsSection$, "DisableSyntaxHighlighter", "True"
ELSE
    DisableSyntaxHighlighter = 0
    WriteConfigSetting generalSettingsSection$, "DisableSyntaxHighlighter", "False"
END IF

IF ReadConfigSetting(generalSettingsSection$, "PasteCursorAtEnd", value$) THEN
    IF UCASE$(value$) = "TRUE" OR VAL(value$) = -1 THEN
        PasteCursorAtEnd = -1
    ELSE
        PasteCursorAtEnd = 0
        WriteConfigSetting generalSettingsSection$, "PasteCursorAtEnd", "False"
    END IF
ELSE
    PasteCursorAtEnd = -1
    WriteConfigSetting generalSettingsSection$, "PasteCursorAtEnd", "True"
END IF

IF ReadConfigSetting(generalSettingsSection$, "ExeToSourceFolderFirstTimeMsg", value$) THEN
    IF UCASE$(value$) = "TRUE" OR VAL(value$) = -1 THEN
        ExeToSourceFolderFirstTimeMsg = -1
    ELSE
        ExeToSourceFolderFirstTimeMsg = 0
        WriteConfigSetting generalSettingsSection$, "ExeToSourceFolderFirstTimeMsg", "False"
    END IF
ELSE
    ExeToSourceFolderFirstTimeMsg = 0
    WriteConfigSetting generalSettingsSection$, "ExeToSourceFolderFirstTimeMsg", "False"
END IF

IF ReadConfigSetting(generalSettingsSection$, "WhiteListQB64FirstTimeMsg", value$) THEN
    IF UCASE$(value$) = "TRUE" OR VAL(value$) = -1 THEN
        WhiteListQB64FirstTimeMsg = -1
    ELSE
        WhiteListQB64FirstTimeMsg = 0
        WriteConfigSetting generalSettingsSection$, "WhiteListQB64FirstTimeMsg", "False"
    END IF
ELSE
    WhiteListQB64FirstTimeMsg = 0
    WriteConfigSetting generalSettingsSection$, "WhiteListQB64FirstTimeMsg", "False"
END IF

IF ReadConfigSetting(generalSettingsSection$, "SaveExeWithSource", value$) THEN
    IF UCASE$(value$) = "TRUE" OR VAL(value$) = -1 THEN
        SaveExeWithSource = -1
    ELSE
        SaveExeWithSource = 0
        WriteConfigSetting generalSettingsSection$, "SaveExeWithSource", "False"
    END IF
ELSE
    SaveExeWithSource = 0
    WriteConfigSetting generalSettingsSection$, "SaveExeWithSource", "False"
END IF

IF ReadConfigSetting(generalSettingsSection$, "EnableQuickNav", value$) THEN
    IF UCASE$(value$) = "TRUE" OR VAL(value$) = -1 THEN
        EnableQuickNav = -1
    ELSE
        EnableQuickNav = 0
        WriteConfigSetting generalSettingsSection$, "EnableQuickNav", "False"
    END IF
ELSE
    EnableQuickNav = -1
    WriteConfigSetting generalSettingsSection$, "EnableQuickNav", "True"
END IF

IF ReadConfigSetting(generalSettingsSection$, "ShowErrorsImmediately", value$) THEN
    IF UCASE$(value$) = "TRUE" OR VAL(value$) = -1 THEN
        IDEShowErrorsImmediately = -1
    ELSE
        IDEShowErrorsImmediately = 0
        WriteConfigSetting generalSettingsSection$, "ShowErrorsImmediately", "False"
    END IF
ELSE
    IDEShowErrorsImmediately = -1
    WriteConfigSetting generalSettingsSection$, "ShowErrorsImmediately", "True"
END IF

IF ReadConfigSetting(generalSettingsSection$, "ShowLineNumbers", value$) THEN
    IF UCASE$(value$) = "TRUE" OR VAL(value$) = -1 THEN
        ShowLineNumbers = -1
    ELSE
        ShowLineNumbers = 0
        WriteConfigSetting generalSettingsSection$, "ShowLineNumbers", "False"
    END IF
ELSE
    ShowLineNumbers = -1
    WriteConfigSetting generalSettingsSection$, "ShowLineNumbers", "True"
END IF

IF ReadConfigSetting(generalSettingsSection$, "ShowLineNumbersSeparator", value$) THEN
    IF UCASE$(value$) = "TRUE" OR VAL(value$) = -1 THEN
        ShowLineNumbersSeparator = -1
    ELSE
        ShowLineNumbersSeparator = 0
        WriteConfigSetting generalSettingsSection$, "ShowLineNumbersSeparator", "False"
    END IF
ELSE
    ShowLineNumbersSeparator = -1
    WriteConfigSetting generalSettingsSection$, "ShowLineNumbersSeparator", "True"
END IF

IF ReadConfigSetting(generalSettingsSection$, "ShowLineNumbersUseBG", value$) THEN
    IF UCASE$(value$) = "TRUE" OR VAL(value$) = -1 THEN
        ShowLineNumbersUseBG = -1
    ELSE
        ShowLineNumbersUseBG = 0
        WriteConfigSetting generalSettingsSection$, "ShowLineNumbersUseBG", "False"
    END IF
ELSE
    ShowLineNumbersUseBG = -1
    WriteConfigSetting generalSettingsSection$, "ShowLineNumbersUseBG", "True"
END IF

IF ReadConfigSetting(generalSettingsSection$, "BracketHighlight", value$) THEN
    IF UCASE$(value$) = "TRUE" OR VAL(value$) = -1 THEN
        brackethighlight = -1
    ELSE
        brackethighlight = 0
        WriteConfigSetting generalSettingsSection$, "BracketHighlight", "False"
    END IF
ELSE
    brackethighlight = -1
    WriteConfigSetting generalSettingsSection$, "BracketHighlight", "True"
END IF

IF ReadConfigSetting(generalSettingsSection$, "KeywordHighlight", value$) THEN
    IF UCASE$(value$) = "TRUE" OR VAL(value$) = -1 THEN
        keywordHighlight = -1
    ELSE
        keywordHighlight = 0
        WriteConfigSetting generalSettingsSection$, "KeywordHighlight", "False"
    END IF
ELSE
    keywordHighlight = -1
    WriteConfigSetting generalSettingsSection$, "KeywordHighlight", "True"
END IF

IF ReadConfigSetting(generalSettingsSection$, "MultiHighlight", value$) THEN
    IF UCASE$(value$) = "TRUE" OR VAL(value$) = -1 THEN
        multihighlight = -1
    ELSE
        multihighlight = 0
        WriteConfigSetting generalSettingsSection$, "MultiHighlight", "False"
    END IF
ELSE
    multihighlight = -1
    WriteConfigSetting generalSettingsSection$, "MultiHighlight", "True"
END IF

IF ReadConfigSetting(generalSettingsSection$, "IgnoreWarnings", value$) THEN
    IF UCASE$(value$) = "TRUE" OR ABS(VAL(value$)) = 1 THEN
        IgnoreWarnings = -1
    ELSE
        IgnoreWarnings = 0
        WriteConfigSetting generalSettingsSection$, "IgnoreWarnings", "False"
    END IF
ELSE
    IgnoreWarnings = 0
    WriteConfigSetting generalSettingsSection$, "IgnoreWarnings", "False"
END IF

result = ReadConfigSetting(generalSettingsSection$, "BackupSize", value$)
idebackupsize = VAL(value$)
IF idebackupsize < 10 OR idebackupsize > 2000 THEN idebackupsize = 100: WriteConfigSetting generalSettingsSection$, "BackupSize", "100 'in MB"

result = ReadConfigSetting(generalSettingsSection$, "DebugInfo", value$)
idedebuginfo = VAL(value$)
IF UCASE$(LEFT$(value$, 4)) = "TRUE" THEN idedebuginfo = 1
IF result = 0 OR idedebuginfo <> 1 THEN
    WriteConfigSetting generalSettingsSection$, "DebugInfo", "False" + DebugInfoIniWarning$
    idedebuginfo = 0
END IF
Include_GDB_Debugging_Info = idedebuginfo

'Mouse settings ---------------------------------------------------------------
result = ReadConfigSetting(mouseSettingsSection$, "SwapMouseButton", value$)
IF UCASE$(value$) = "TRUE" OR VAL(value$) = -1 THEN
    MouseButtonSwapped = -1
    WriteConfigSetting mouseSettingsSection$, "SwapMouseButton", "True"
ELSE
    MouseButtonSwapped = 0
    WriteConfigSetting mouseSettingsSection$, "SwapMouseButton", "False"
END IF

'Debug settings ---------------------------------------------------------------
result = ReadConfigSetting(debugSettingsSection$, "BaseTCPPort", value$)
idebaseTcpPort = VAL(value$)
IF idebaseTcpPort = 0 THEN idebaseTcpPort = 9000: WriteConfigSetting debugSettingsSection$, "BaseTCPPort", "9000"

result = ReadConfigSetting(debugSettingsSection$, "WatchListToConsole", value$)
IF UCASE$(value$) = "TRUE" OR VAL(value$) = -1 THEN
    WatchListToConsole = -1
    WriteConfigSetting debugSettingsSection$, "WatchListToConsole", "True"
ELSE
    WatchListToConsole = 0
    WriteConfigSetting debugSettingsSection$, "WatchListToConsole", "False"
END IF

IF ReadConfigSetting(debugSettingsSection$, "AutoAddDebugCommand", value$) THEN
    IF UCASE$(value$) = "TRUE" OR VAL(value$) = -1 THEN
        AutoAddDebugCommand = -1
    ELSE
        AutoAddDebugCommand = 0
        WriteConfigSetting debugSettingsSection$, "AutoAddDebugCommand", "False"
    END IF
ELSE
    AutoAddDebugCommand = -1
    WriteConfigSetting debugSettingsSection$, "AutoAddDebugCommand", "True"
END IF

'Display settings -------------------------------------------------------------
IF ReadConfigSetting(displaySettingsSection$, "IDE_SortSUBs", value$) THEN
    IF UCASE$(value$) = "TRUE" OR VAL(value$) = -1 THEN
        idesortsubs = -1
    ELSE
        idesortsubs = 0
        WriteConfigSetting displaySettingsSection$, "IDE_SortSUBs", "False"
    END IF
ELSE
    idesortsubs = 0
    WriteConfigSetting displaySettingsSection$, "IDE_SortSUBs", "False"
END IF

IF ReadConfigSetting(displaySettingsSection$, "IDE_KeywordCapital", value$) THEN
    IF UCASE$(value$) = "TRUE" OR VAL(value$) = -1 THEN
        ideautolayoutkwcapitals = -1
    ELSE
        ideautolayoutkwcapitals = 0
        WriteConfigSetting displaySettingsSection$, "IDE_KeywordCapital", "False"
    END IF
ELSE
    ideautolayoutkwcapitals = 0
    WriteConfigSetting displaySettingsSection$, "IDE_KeywordCapital", "False"
END IF

IF ReadConfigSetting(displaySettingsSection$, "IDE_SUBsLength", value$) THEN
    IF UCASE$(value$) = "TRUE" OR VAL(value$) = -1 THEN
        IDESubsLength = -1
    ELSE
        IDESubsLength = 0
        WriteConfigSetting displaySettingsSection$, "IDE_SUBsLength", "False"
    END IF
ELSE
    IDESubsLength = -1
    WriteConfigSetting displaySettingsSection$, "IDE_SUBsLength", "True"
END IF

IF ReadConfigSetting(displaySettingsSection$, "IDE_AutoPosition", value$) THEN
    IF UCASE$(value$) = "TRUE" OR ABS(VAL(value$)) = 1 THEN
        IDE_AutoPosition = -1
    ELSE
        IDE_AutoPosition = 0
        WriteConfigSetting displaySettingsSection$, "IDE_AutoPosition", "False"
    END IF
ELSE
    IDE_AutoPosition = -1
    WriteConfigSetting displaySettingsSection$, "IDE_AutoPosition", "True"
END IF

result = ReadConfigSetting(displaySettingsSection$, "IDE_NormalCursorStart", value$)
IDENormalCursorStart = VAL(value$)
IF IDENormalCursorStart < 0 OR IDENormalCursorStart > 31 OR result = 0 THEN
    IDENormalCursorStart = 6
    WriteConfigSetting displaySettingsSection$, "IDE_NormalCursorStart", "6"
END IF

result = ReadConfigSetting(displaySettingsSection$, "IDE_NormalCursorEnd", value$)
IDENormalCursorEnd = VAL(value$)
IF IDENormalCursorEnd < 0 OR IDENormalCursorEnd > 31 OR result = 0 THEN
    IDENormalCursorEnd = 8
    WriteConfigSetting displaySettingsSection$, "IDE_NormalCursorEnd", "8"
END IF

result = ReadConfigSetting(displaySettingsSection$, "IDE_AutoFormat", value$)
ideautolayout = VAL(value$)
IF UCASE$(value$) = "TRUE" OR ideautolayout <> 0 THEN
    ideautolayout = 1
ELSE
    IF UCASE$(value$) <> "FALSE" AND value$ <> "0" THEN
        WriteConfigSetting displaySettingsSection$, "IDE_AutoFormat", "True"
        ideautolayout = 1
    ELSE
        ideautolayout = 0
    END IF
END IF

result = ReadConfigSetting(displaySettingsSection$, "IDE_AutoIndent", value$)
ideautoindent = VAL(value$)
IF UCASE$(value$) = "TRUE" OR ideautoindent <> 0 THEN
    ideautoindent = 1
ELSE
    IF UCASE$(value$) <> "FALSE" AND value$ <> "0" THEN
        WriteConfigSetting displaySettingsSection$, "IDE_AutoIndent", "True"
        ideautoindent = 1
    ELSE
        ideautoindent = 0
    END IF
END IF

result = ReadConfigSetting(displaySettingsSection$, "IDE_IndentSUBs", value$)
ideindentsubs = VAL(value$)
IF UCASE$(value$) = "TRUE" OR ideindentsubs <> 0 THEN
    ideindentsubs = 1
ELSE
    IF UCASE$(value$) <> "FALSE" AND value$ <> "0" THEN
        WriteConfigSetting displaySettingsSection$, "IDE_IndentSUBs", "True"
        ideindentsubs = 1
    ELSE
        ideindentsubs = 0
    END IF
END IF

result = ReadConfigSetting(displaySettingsSection$, "IDE_IndentSize", value$)
ideautoindentsize = VAL(value$)
IF ideautoindentsize < 1 OR ideautoindentsize > 64 THEN
    ideautoindentsize = 4
    WriteConfigSetting displaySettingsSection$, "IDE_IndentSize", "4"
END IF

result = ReadConfigSetting(displaySettingsSection$, "IDE_CustomFont", value$)
idecustomfont = VAL(value$)
IF UCASE$(value$) = "TRUE" OR idecustomfont <> 0 THEN
    idecustomfont = 1
ELSE
    WriteConfigSetting displaySettingsSection$, "IDE_CustomFont", "False"
    idecustomfont = 0
END IF

result = ReadConfigSetting(displaySettingsSection$, "IDE_UseFont8", value$)
IF UCASE$(value$) = "TRUE" THEN
    IDE_UseFont8 = 1
ELSE
    WriteConfigSetting displaySettingsSection$, "IDE_UseFont8", "False"
    IDE_UseFont8 = 0
END IF

result = ReadConfigSetting(displaySettingsSection$, "IDE_CustomFont$", value$)
idecustomfontfile$ = value$
IF result = 0 OR idecustomfontfile$ = "" THEN
    idecustomfontfile$ = "C:\Windows\Fonts\lucon.ttf"
    WriteConfigSetting displaySettingsSection$, "IDE_CustomFont$", idecustomfontfile$
END IF

result = ReadConfigSetting(displaySettingsSection$, "IDE_CustomFontSize", value$)
idecustomfontheight = VAL(value$)
IF idecustomfontheight < 8 OR idecustomfontheight > 100 THEN idecustomfontheight = 21: WriteConfigSetting displaySettingsSection$, "IDE_CustomFontSize", "21"

result = ReadConfigSetting(displaySettingsSection$, "IDE_CodePage", value$)
idecpindex = VAL(value$)
IF idecpindex < 0 OR idecpindex > idecpnum THEN idecpindex = 0: WriteConfigSetting displaySettingsSection$, "IDE_CodePage", "0"

'Custom keywords --------------------------------------------------------------
IF ReadConfigSetting(customDictionarySection$, "CustomKeywords$", value$) THEN
    tempList$ = ""
    listOfCustomKeywords$ = "@" + UCASE$(value$) + "@"
    FOR I = 1 TO LEN(listOfCustomKeywords$)
        checkChar = ASC(listOfCustomKeywords$, I)
        IF checkChar = 64 THEN
            IF RIGHT$(tempList$, 1) <> "@" THEN tempList$ = tempList$ + "@"
        ELSE
            tempList$ = tempList$ + CHR$(checkChar)
        END IF
    NEXT
    listOfCustomKeywords$ = tempList$
    customKeywordsLength = LEN(listOfCustomKeywords$)
ELSE
    IniSetAddQuotes -1
    WriteConfigSetting customDictionarySection$, "Instructions1", "Add custom keywords separated by the 'at' sign."
    WriteConfigSetting customDictionarySection$, "Instructions2", "Useful to colorize constants (eg @true@false@)."
    IniSetAddQuotes 0
    WriteConfigSetting customDictionarySection$, "CustomKeywords$", "@"
END IF

'Color schemes ---------------------------------------------------------------
IniSetAddQuotes -1
WriteConfigSetting colorSchemesSection$, "Instructions1", "Create custom color schemes in the IDE (Options->IDE Colors)."
WriteConfigSetting colorSchemesSection$, "Instructions2", "Custom color schemes will be stored in this section."
IniSetAddQuotes 0

'Individual window settings (different for each running instance) -------------
IF ReadConfigSetting(windowSettingsSection$, "IDE_TopPosition", value$) THEN
    IDE_TopPosition = VAL(value$)
ELSE
    IDE_BypassAutoPosition = -1 'If there's no position saved in the file, then we certainly don't need to try and auto-position to our last setting.
    IDE_TopPosition = 0
END IF

IF ReadConfigSetting(windowSettingsSection$, "IDE_LeftPosition", value$) THEN
    IDE_LeftPosition = VAL(value$)
ELSE
    IDE_BypassAutoPosition = -1 'If there's no position saved in the file, then we certainly don't need to try and auto-position to our last setting.
    IDE_LeftPosition = 0
END IF

result = ReadConfigSetting(windowSettingsSection$, "IDE_Width", value$)
idewx = VAL(value$)
IF idewx < 80 OR idewx > 1000 THEN idewx = 80: WriteConfigSetting windowSettingsSection$, "IDE_Width", "80"

result = ReadConfigSetting(windowSettingsSection$, "IDE_Height", value$)
idewy = VAL(value$)
IF idewy < 25 OR idewy > 1000 THEN idewy = 25: WriteConfigSetting windowSettingsSection$, "IDE_Height", "25"

'Color settings ---------------------------------------------------------------
'Defaults: (= Super Dark Blue scheme, as of v1.5)
IDETextColor = _RGB32(216, 216, 216)
IDEKeywordColor = _RGB32(69, 118, 147)
IDENumbersColor = _RGB32(216, 98, 78)
IDEQuoteColor = _RGB32(255, 167, 0)
IDEMetaCommandColor = _RGB32(85, 206, 85)
IDECommentColor = _RGB32(98, 98, 98)
IDEBackgroundColor = _RGB32(0, 0, 39)
IDEBackgroundColor2 = _RGB32(0, 49, 78)
IDEBracketHighlightColor = _RGB32(0, 88, 108)

'Manual/unsaved color settings:
IF ReadConfigSetting(colorSettingsSection$, "SchemeID", value$) = 0 THEN
    WriteConfigSetting colorSettingsSection$, "SchemeID", "1"
END IF

IF ReadConfigSetting(colorSettingsSection$, "TextColor", value$) THEN
    IDETextColor = VRGBS(value$, IDETextColor)
ELSE WriteConfigSetting colorSettingsSection$, "TextColor", rgbs$(IDETextColor)
END IF

IF ReadConfigSetting(colorSettingsSection$, "KeywordColor", value$) THEN
    IDEKeywordColor = VRGBS(value$, IDEKeywordColor)
ELSE WriteConfigSetting colorSettingsSection$, "KeywordColor", rgbs$(IDEKeywordColor)
END IF

IF ReadConfigSetting(colorSettingsSection$, "NumbersColor", value$) THEN
    IDENumbersColor = VRGBS(value$, IDENumbersColor)
ELSE WriteConfigSetting colorSettingsSection$, "NumbersColor", rgbs$(IDENumbersColor)
END IF

IF ReadConfigSetting(colorSettingsSection$, "QuoteColor", value$) THEN
    IDEQuoteColor = VRGBS(value$, IDEQuoteColor)
ELSE WriteConfigSetting colorSettingsSection$, "QuoteColor", rgbs$(IDEQuoteColor)
END IF

IF ReadConfigSetting(colorSettingsSection$, "CommentColor", value$) THEN
    IDECommentColor = VRGBS(value$, IDECommentColor)
ELSE WriteConfigSetting colorSettingsSection$, "CommentColor", rgbs$(IDECommentColor)
END IF

IF ReadConfigSetting(colorSettingsSection$, "MetaCommandColor", value$) THEN
    IDEMetaCommandColor = VRGBS(value$, IDEMetaCommandColor)
ELSE WriteConfigSetting colorSettingsSection$, "MetaCommandColor", rgbs$(IDEMetaCommandColor)
END IF

IF ReadConfigSetting(colorSettingsSection$, "HighlightColor", value$) THEN
    IDEBracketHighlightColor = VRGBS(value$, IDEBracketHighlightColor)
ELSE WriteConfigSetting colorSettingsSection$, "HighlightColor", rgbs$(IDEBracketHighlightColor)
END IF

IF ReadConfigSetting(colorSettingsSection$, "BackgroundColor", value$) THEN
    IDEBackgroundColor = VRGBS(value$, IDEBackgroundColor)
ELSE WriteConfigSetting colorSettingsSection$, "BackgroundColor", rgbs$(IDEBackgroundColor)
END IF

IF ReadConfigSetting(colorSettingsSection$, "BackgroundColor2", value$) THEN
    IDEBackgroundColor2 = VRGBS(value$, IDEBackgroundColor2)
ELSE WriteConfigSetting colorSettingsSection$, "BackgroundColor2", rgbs$(IDEBackgroundColor2)
END IF

'End of initial settings ------------------------------------------------------

