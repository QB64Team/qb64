DIM SHARED IDECommentColor AS _UNSIGNED LONG, IDEMetaCommandColor AS _UNSIGNED LONG
DIM SHARED IDEQuoteColor AS _UNSIGNED LONG, IDETextColor AS _UNSIGNED LONG
DIM SHARED IDEBackgroundColor AS _UNSIGNED LONG
DIM SHARED IDEBackgroundColor2 AS _UNSIGNED LONG
DIM SHARED IDE_AutoPosition AS _BYTE, IDE_TopPosition AS INTEGER, IDE_LeftPosition AS INTEGER
DIM SHARED IDE_Index$
DIM SHARED LoadedIDESettings AS INTEGER
DIM SHARED MouseButtonSwapped AS _BYTE
DIM SHARED PasteCursorAtEnd AS _BYTE

IF LoadedIDESettings = 0 THEN
  'We only want to load the file once when QB64 first starts
  'Other changes should occur to our settings when we change them in their appropiate routines.
  'There's no reason to open and close and open and close the same file a million times.

  LoadedIDESettings = -1

  ConfigFile$ = "internal/config.txt"
  ConfigBak$ = "internal/config.bak"

  GOSUB CheckConfigFileExists 'make certain the config file exists and if not, create one

  IF INSTR(_OS$, "WIN") THEN

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

    ELSE
        'Linux doesn't offer multiple temp folders and thus can not work properly with independent settings
        'This option is not included on Linux, and if manually inserted will simply be ignored.
        IDE_Index$ = ""
    END IF

    result = ReadConfigSetting("ConfigVersion", value$) 'Not really used for anything at this point, but might be important in the future.
    ConfigFileVersion = VAL(value$) 'We'll get a config file version of 0 if there isn't any in the file

    result = ReadConfigSetting("CommentColor", value$)
    IF result THEN
        IDECommentColor = VRGBS(value$, _RGB32(85, 255, 255))
    ELSE
        IDECommentColor = _RGB32(85, 255, 255)
        WriteConfigSetting "'[IDE COLOR SETTINGS]", "CommentColor", "_RGB32(85,255,255)"
    END IF

    result = ReadConfigSetting("MetaCommandColor", value$)
    IF result THEN
        IDEMetaCommandColor = VRGBS(value$, _RGB32(85, 255, 85))
    ELSE
        IDEMetaCommandColor = _RGB32(85, 255, 85)
        WriteConfigSetting "'[IDE COLOR SETTINGS]", "MetaCommandColor", "_RGB32(85,255,85)"
    END IF

    result = ReadConfigSetting("QuoteColor", value$)
    IF result THEN
        IDEQuoteColor = VRGBS(value$, _RGB32(255, 255, 85))
    ELSE
        IDEQuoteColor = _RGB32(255, 255, 85)
        WriteConfigSetting "'[IDE COLOR SETTINGS]", "QuoteColor", "_RGB32(255,255,85)"
    END IF

    result = ReadConfigSetting("TextColor", value$)
    IF result THEN
        IDETextColor = VRGBS(value$, _RGB32(255, 255, 255))
    ELSE
        IDETextColor = _RGB32(255, 255, 255)
        WriteConfigSetting "'[IDE COLOR SETTINGS]", "TextColor", "_RGB32(255,255,255)"
    END IF

    result = ReadConfigSetting("BackgroundColor", value$)
    IF result THEN
        IDEBackGroundColor = VRGBS(value$, _RGB32(0, 0, 170))
    ELSE
        IDEBackGroundColor = _RGB32(0, 0, 170)
        WriteConfigSetting "'[IDE COLOR SETTINGS]", "BackgroundColor", "_RGB32(0,0,170)"
    END IF

    result = ReadConfigSetting("BackgroundColor2", value$)
    IF result THEN
        IDEBackGroundColor2 = VRGBS(value$, _RGB32(0, 0, 128))
    ELSE
        IDEBackGroundColor2 = _RGB32(0, 0, 128)
        WriteConfigSetting "'[IDE COLOR SETTINGS]", "BackgroundColor2", "_RGB32(0,0,128)"
    END IF

    result = ReadConfigSetting("SwapMouseButton", value$)
    if value$ = "TRUE" or val(value$) = -1 then
        MouseButtonSwapped = -1
        WriteConfigSetting "'[MOUSE SETTINGS]", "SwapMouseButton", "TRUE"
    else
        MouseButtonSwapped = 0
        WriteConfigSetting "'[MOUSE SETTINGS]", "SwapMouseButton", "FALSE"
    end if

    result = ReadConfigSetting("PasteCursorAtEnd", value$)
    IF result THEN
        IF value$ = "TRUE" OR VAL(value$) = -1 THEN
            PasteCursorAtEnd = -1
        ELSE
            PasteCursorAtEnd = 0
            WriteConfigSetting "'[GENERAL SETTINGS]", "PasteCursorAtEnd", "FALSE"
        END IF
    ELSE
        WriteConfigSetting "'[GENERAL SETTINGS]", "PasteCursorAtEnd", "FALSE"
        PasteCursorAtEnd = 0
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
            IDE_Autopostion = 0
            WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_AutoPosition", "FALSE"
        END IF

        result = ReadConfigSetting("IDE_TopPosition", value$)
        IF result THEN
            IDE_TopPosition = VAL(value$)
        ELSE
            IDE_Autopostion = 0 'If there's no position saved in the file, then we certainly don't need to try and auto-position to our last setting.
            WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_AutoPosition", "FALSE"
            WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_TopPosition", "0"
            WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_LeftPosition", "0"
        END IF

        result = ReadConfigSetting("IDE_LeftPosition", value$)
        IF result THEN
            IDE_LeftPosition = VAL(value$)
        ELSE
            IDE_Autopostion = 0 'If there's no position saved in the file, then we certainly don't need to try and auto-position to our last setting.
            WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_AutoPosition", "FALSE"
            WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_TopPosition", "0"
            WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_LeftPosition", "0"
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
    elseif result = 0 then
        WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_IndentSUBs", "FALSE"
        ideindentsubs = 0
    ELSEIF UCASE$(value$) <> "FALSE" AND value$ <> "0" THEN
            WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_IndentSUBs", "TRUE"
            ideindentsubs = 1
    else
            ideindentsubs = 0
    end if

    result = ReadConfigSetting("IDE_SortSUBs", value$)
    idesortsubs = VAL(value$)
    IF UCASE$(value$) = "TRUE" OR idesortsubs <> 0 THEN
        idesortsubs = 1
    elseif result = 0 then
        WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_SortSUBs", "FALSE"
        idesortsubs = 0
    ELSEIF UCASE$(value$) <> "FALSE" AND value$ <> "0" THEN
            WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_SortSUBs", "TRUE"
            idesortsubs = 1
    else
            idesortsubs = 0
    end if

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

    result = ReadConfigSetting("DeBugInfo", value$)
    idedebuginfo = VAL(value$)
    IF UCASE$(LEFT$(value$, 4)) = "TRUE" THEN idedebuginfo = 1
    IF result = 0 OR idedebuginfo <> 1 THEN
        WriteConfigSetting "'[GENERAL SETTINGS]", "DebugInfo", "FALSE 'INTERNAL VARIABLE USE ONLY!! DO NOT MANUALLY CHANGE!"
        idedebuginfo = 0
    END IF
    Include_GDB_Debugging_Info = idedebuginfo

    result = ReadConfigSetting("IDE_AndroidMenu", value$)
    IdeAndroidMenu = ABS(VAL(value$))
    IF UCASE$(value$) = "TRUE" THEN IdeAndroidMenu = 1
    IF IdeAndroidMenu <> 1 THEN ideideandroidmenu = 0: WriteConfigSetting "'[ANDROID MENU]", "IDE_AndroidMenu", "FALSE"

    result = ReadConfigSetting("IDE_AndroidStartScript$", value$)
    IdeAndroidStartScript$ = value$ 'no default values in case this fails??
    IF result = 0 THEN WriteConfigSetting "'[ANDROID MENU]", "IDE_AndroidStartScript$", "programs\android\start_android.bat"

    result = ReadConfigSetting("IDE_AndroidMakeScript$", value$)
    IdeAndroidMakeScript$ = value$ 'no default values in case this fails??
    IF result = 0 THEN WriteConfigSetting "'[ANDROID MENU]", "IDE_AndroidMakeScript$", "programs\android\start_android.bat"
    IF result = 0 THEN WriteConfigSetting "'[ANDROID MENU]", "IDE_AndroidMakeScript$", "programs\android\start_android.bat"


    GOTO SkipCheckConfigFileExists
    CheckConfigFileExists:
    IF _FILEEXISTS(ConfigFile$) = 0 THEN
        'There's no config file in the folder.  Let's make one for future use.
        IF ConfigFile$ = "internal/config.txt" THEN 'It's the main file which we use for default/global settings
            WriteConfigSetting "'[CONFIG VERSION]", "ConfigVersion", "1"
            WriteConfigSetting "'[ANDROID MENU]", "IDE_AndroidMakeScript$", "programs\android\start_android.bat"
            WriteConfigSetting "'[ANDROID MENU]", "IDE_AndroidStartScript$", "programs\android\start_android.bat"
            WriteConfigSetting "'[ANDROID MENU]", "IDE_AndroidMenu", "FALSE"
            IF INSTR(_OS$, "WIN") THEN WriteConfigSetting "'[GENERAL SETTINGS]", "AllowIndependentSettings", "FALSE"
            WriteConfigSetting "'[GENERAL SETTINGS]", "BackupSize", "100 'in MB"
            WriteConfigSetting "'[GENERAL SETTINGS]", "DebugInfo", "FALSE 'INTERNAL VARIABLE USE ONLY!! DO NOT MANUALLY CHANGE!"
            WriteConfigSetting "'[IDE COLOR SETTINGS]", "BackgroundColor", "_RGB32(0,0,170)"
            WriteConfigSetting "'[IDE COLOR SETTINGS]", "CommentColor", "_RGB32(85,255,255)"
            WriteConfigSetting "'[IDE COLOR SETTINGS]", "MetaCommandColor", "_RGB32(85,255,85)"
            WriteConfigSetting "'[IDE COLOR SETTINGS]", "QuoteColor", "_RGB32(255,255,85)"
            WriteConfigSetting "'[IDE COLOR SETTINGS]", "TextColor", "_RGB32(255,255,255)"
            IF INSTR(_OS$, "WIN") THEN
                WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_TopPosition", "0"
                WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_LeftPosition", "0"
                WriteConfigSetting "'[IDE DISPLAY SETTINGS]", "IDE_AutoPosition", "FALSE"
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

