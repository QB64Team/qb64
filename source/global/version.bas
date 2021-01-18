DIM SHARED Version AS STRING
DIM SHARED BuildNum AS STRING
DIM SHARED AutoBuildMsg AS STRING

Version$ = "1.5"
BuildNum$ = "(development build)"
IF _FILEEXISTS("internal/version.txt") THEN
    versionfile = FREEFILE
    OPEN "internal/version.txt" FOR INPUT AS #versionfile
    LINE INPUT #versionfile, AutoBuildMsg
    AutoBuildMsg = _TRIM$(AutoBuildMsg)
    IF LEFT$(AutoBuildMsg, 9) <> "From git " THEN AutoBuildMsg = ""
    CLOSE #versionfile
END IF

