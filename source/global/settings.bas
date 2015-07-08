'Used for debugging the compiler's code (not the code it compiles) [for temporary/advanced usage]
CONST Debug = 0
DIM SHARED IDECommentColor AS _UNSIGNED LONG, IDEMetaCommandColor AS _UNSIGNED LONG
DIM SHARED IDEQuoteColor AS _UNSIGNED LONG, IDETextColor AS _UNSIGNED LONG

ConfigFile$ = "internal/config.txt"
ConfigBak$ = "internal/config.bak"

IF _FILEEXISTS(ConfigFile$) = 0 THEN
    'There's no config file in the folder.  Let's make one for future use.
    WriteConfigSetting "'[CONFIG VERSION]", "ConfigVersion", "1"
    WriteConfigSetting "'[IDE COLOR SETTINGS]", "CommentColor", "_RGB32(85,255,255)"
    WriteConfigSetting "'[IDE COLOR SETTINGS]", "MetaCommandColor", "_RGB32(85,255,85)"
    WriteConfigSetting "'[IDE COLOR SETTINGS]", "QuoteColor", "_RGB32(255,255,85)"
    WriteConfigSetting "'[IDE COLOR SETTINGS]", "TextColor", "_RGB32(255,255,255)"

    'go ahead and set default values automatically
    ConfigFileVersion = 1
    IDECommentColor = _RGB32(85, 255, 255)
    IDEMetaCommandColor = _RGB32(85, 255, 85)
    IDEQuoteColor = _RGB32(255, 255, 85)
    IDETextColor = _RGB32(255, 255, 255)
ELSE

    result = ReadConfigSetting("ConfigVersion", value$) 'Not really used for anything at this point, but might be important in the future.
    ConfigFileVersion = VAL(value$) 'We'll get a config file version of 0 if there isn't any in the file

    result = ReadConfigSetting("CommentColor", value$)
    IF result THEN IDECommentColor = VRGBS(value$, _RGB32(85, 255, 255)) ELSE IDECommentColor = _RGB32(85, 255, 255)

    result = ReadConfigSetting("MetaCommandColor", value$)
    IF result THEN IDEMetaCommandColor = VRGBS(value$, _RGB32(85, 255, 85)) ELSE IDEMetaCommandColor = _RGB32(85, 255, 85)

    result = ReadConfigSetting("QuoteColor", value$)
    IF result THEN IDEQuoteColor = VRGBS(value$, _RGB32(255, 255, 85)) ELSE IDEQuoteColor = _RGB32(255, 255, 85)

    result = ReadConfigSetting("TextColor", value$)
    IF result THEN IDETextColor = VRGBS(value$, _RGB32(255, 255, 2555)) ELSE IDETextColor = _RGB32(255, 255, 255)

END IF
