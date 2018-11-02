DIM SHARED Version AS STRING
DIM SHARED BuildNum AS STRING
DIM SHARED AutoBuildMsg AS STRING

Version$ = "1.2"
BuildNum$ = "[dev build]"
IF _FILEEXISTS("internal/version.txt") THEN
    versionfile = FREEFILE
    OPEN "internal/version.txt" FOR INPUT AS #versionfile
    LINE INPUT #versionfile, AutoBuildMsg
    CLOSE #versionfile
END IF

