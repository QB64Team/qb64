DIM SHARED Version AS STRING
DIM SHARED DevChannel AS STRING
DIM SHARED AutoBuildMsg AS STRING

Version$ = "2.1"
DevChannel$ = "Development Build"
IF _FILEEXISTS("internal/version.txt") THEN
    versionfile = FREEFILE
    OPEN "internal/version.txt" FOR INPUT AS #versionfile
    LINE INPUT #versionfile, AutoBuildMsg
    AutoBuildMsg = LEFT$(_TRIM$(AutoBuildMsg), 16) 'From git 1234567
    IF LEFT$(AutoBuildMsg, 9) <> "From git " THEN AutoBuildMsg = ""
    CLOSE #versionfile
END IF

