SUB AryAddStr (Ary() AS STRING, value AS STRING) 'create new entry and return its index
IF LEN(Ary(0)) = 0 THEN Ary(0) = "0"
index = VAL(Ary(0)) + 1
lastIndex = UBOUND(Ary)
IF index > lastIndex THEN
    lastIndex = index * 2
    REDIM _PRESERVE Ary(lastIndex) AS STRING
END IF
Ary(0) = STR$(index)
Ary(index) = value
AryNewStr = index
END SUB

FUNCTION AryLastStr (Ary() AS STRING) 'get last used index or 0 if none used
IF LEN(Ary(0)) = 0 THEN Ary(0) = "0"
AryLastStr = VAL(Ary(0))
END FUNCTION

SUB CreateAndroidProject_ReplaceInFile (thisFile$, find$, replaceWith$)
fh = FREEFILE
OPEN thisFile$ FOR BINARY AS #fh
a$ = SPACE$(LOF(fh))
GET #fh, , a$
starti=1
DO WHILE INSTR(starti, a$, find$) > 0
    i = INSTR(starti, a$, find$)
    a$ = LEFT$(a$, i - 1) + replaceWith$ + RIGHT$(a$, LEN(a$) - i - LEN(find$) + 1)
    starti=i+len(replaceWith$)
LOOP
CLOSE #fh
KILL thisFile$
OPEN thisFile$ FOR BINARY AS #fh
PUT #1, , a$
CLOSE #fh
END SUB

FUNCTION CreateAndroidProject_EscapeFileName$ (a$, method)
a2$ = ""
FOR i = 1 TO LEN(a$)
    c$ = CHR$(ASC(a$, i))
    IF method <> 2 THEN
        IF c$ = ":" THEN c$ = "\:"
    END IF
    IF c$ = "\" THEN c$ = "\\"
    a2$ = a2$ + c$
NEXT
CreateAndroidProject_EscapeFileName$ = a2$
END FUNCTION

FUNCTION CreateAndroidProject_FindFile$ (thisFile$)
fh = FREEFILE
OPEN "programs\android\template\located_files.txt" FOR BINARY AS #fh: CLOSE #fh
OPEN "programs\android\template\located_files.txt" FOR INPUT AS #fh
DO UNTIL EOF(fh)
    LINE INPUT #fh, a2$
    IF RIGHT$(a2$, LEN(thisFile$)) = thisFile$ THEN
        IF _FILEEXISTS(a2$) THEN 'verify file exists
            CreateAndroidProject_FindFile$ = a2$
            CLOSE #fh
            EXIT FUNCTION
        END IF
    END IF
LOOP
CLOSE #fh
SHELL _HIDE "cmd /c dir /s /b " + CHR$(34) + "c:\" + thisFile$ + CHR$(34) + " >internal\temp\files.txt"
OPEN "internal\temp\files.txt" FOR INPUT AS #fh
a$ = ""
IF NOT EOF(fh) THEN
    LINE INPUT #fh, a$
END IF
CLOSE #fh
IF a$ <> "" THEN
    inLocatedFiles = 0
    OPEN "programs\android\template\located_files.txt" FOR INPUT AS #fh
    DO UNTIL EOF(fh)
        LINE INPUT #fh, a2$
        IF a2$ = a$ THEN
            inLocatedFiles = 1
        END IF
    LOOP
    CLOSE #fh
    IF inLocatedFiles = 0 THEN
        OPEN "programs\android\template\located_files.txt" FOR APPEND AS #fh
        PRINT #fh, a$
        CLOSE #fh
    END IF
END IF
CreateAndroidProject_FindFile$ = a$
END FUNCTION


FUNCTION CreateAndroidProject_GetNdkPath$
CreateAndroidProject_Message "Locating NDK in filesystem (this could take a while the first time)"
thisFile$ = CreateAndroidProject_FindFile$("ndk-build")
IF thisFile$ <> "" THEN
    CreateAndroidProject_Message "NDK located at '" + thisFile$ + "'"
END IF
IF thisFile$ = "" THEN
    CreateAndroidProject_Message "NDK not found. Assuming 'c:\ndk\ndk-build'"
    thisFile$ = "c:\ndk\ndk-build" 'use default path
END IF
FOR i = LEN(thisFile$) TO 1 STEP -1
    IF ASC(thisFile$, i) = 92 THEN
        thisFile$ = LEFT$(thisFile$, i - 1)
        EXIT FOR
    END IF
NEXT
CreateAndroidProject_GetNdkPath$ = thisFile$
END FUNCTION

FUNCTION CreateAndroidProject_GetSdkPath$
CreateAndroidProject_Message "Locating SDK in filesystem (this could take a while the first time)"
thisFile$ = CreateAndroidProject_FindFile$("AVD Manager.exe")
IF thisFile$ <> "" THEN
    CreateAndroidProject_Message "SDK located at '" + thisFile$ + "'"
END IF
IF thisFile$ = "" THEN
    CreateAndroidProject_Message "SDK not found. Assuming '%appdata%\..\local\android\sdk\AVD Manager.exe'"
    thisFile$ = "%appdata%\..\local\android\sdk\AVD Manager.exe" 'use default path
END IF
FOR i = LEN(thisFile$) TO 1 STEP -1
    IF ASC(thisFile$, i) = 92 THEN
        thisFile$ = LEFT$(thisFile$, i - 1)
        EXIT FOR
    END IF
NEXT
CreateAndroidProject_GetSdkPath$ = thisFile$
END FUNCTION

FUNCTION CreateAndroidProject_GetGradlePath$
CreateAndroidProject_Message "Locating Gradle in filesystem (this could take a while the first time)"
thisFile$ = CreateAndroidProject_FindFile$("gradle.bat")
IF thisFile$ <> "" THEN
    CreateAndroidProject_Message "Gradle located at '" + thisFile$ + "'"
END IF
IF thisFile$ = "" THEN
    thisFile$ = "C:\Program Files\Android\Android Studio\gradle\gradle-2.2.1\bin\gradle.bat"
    CreateAndroidProject_Message "Gradle not found. Assuming '+thisFile$+" '"
END IF
FOR i = LEN(thisFile$) TO 1 STEP -1
    IF ASC(thisFile$, i) = 92 THEN
        thisFile$ = LEFT$(thisFile$, i - 1)
        EXIT FOR
    END IF
NEXT
CreateAndroidProject_GetGradlePath$ = thisFile$
END FUNCTION

SUB CreateAndroidProject_Message (message AS STRING)
statusWindowX=2
statusWindowY=idewy - 3
statusWindowHeight=3
statusWindowWidth=idewx - 2
'clear status window
for y=statusWindowY to statusWindowY+statusWindowHeight-1
locate y,statusWindowX: PRINT SPACE$(statusWindowWidth);
next
for y=statusWindowY to statusWindowY+statusWindowHeight-1
messageLength=len(message)
if messageLength>0 then
if messageLength>statusWindowWidth then messageLength=statusWindowWidth
locate y,statusWindowX: print left$(message,messageLength);
message=right$(message,len(message)-messageLength)
end if
next
PCOPY 3, 0
END SUB

SUB CreateAndroidProject_RestoreFile (file AS STRING, projectFolder AS STRING)
SHELL _HIDE "cmd /c copy programs\android\template\untitled\" + file + " " + projectFolder + "\" + file
END SUB

FUNCTION CreateAndroidProject_PathReference$ (path AS STRING)
a$ = path
FOR i = 1 TO LEN(a$)
    IF ASC(a$, i) = 92 THEN ASC(a$, i) = 47
NEXT
CreateAndroidProject_PathReference$ = a$
END FUNCTION

SUB CreateAndroidProject_AddDir (code AS STRING, dir AS STRING)
'mkdir("subfolder",0770);
code = code + "mkdir(" + CHR$(34) + CreateAndroidProject_PathReference$(dir) + CHR$(34) + ",0770);" + CHR$(13) + CHR$(10)
END SUB

SUB CreateAndroidProject_AddFile (code AS STRING, file AS STRING)
'android_get_file_asset(mgr, "subfolder/subfolderfile.txt");
code = code + "android_get_file_asset(mgr," + CHR$(34) + CreateAndroidProject_PathReference$(file) + CHR$(34) + ");" + CHR$(13) + CHR$(10)
END SUB



SUB CreateAndroidProject (projectName2 AS STRING)

'sanitise project name
dim projectName as string
for projectNameI=1 to len(projectName2)
        projectNameA$=LCASE$(mid$(projectName2,projectNameI,1))
        projectNameAsc=ASC(projectNameA$)
        projectNameAValid=0
        if projectNameAsc>=97 and projectNameAsc<122 then projectNameAValid=1
        if len(projectName)>=1 then
                if projectNameAsc>=48 and projectNameAsc<=57 then projectNameAValid=1
        end if
        if projectNameAValid then projectName=projectName+projectNameA$
next
if projectName="" then projectName="untitled"

projectVersion$ = "QB64_ANDROID_1.5"

DIM projectFolder AS STRING

DIM cFolder AS STRING
cFolder = "internal\c"

projectFolder = "programs\android\" + projectName

versionFile$ = projectFolder + "\qb64_android_version.txt"

sameVersion = 0
newProject = 1
IF _DIREXISTS(projectFolder) THEN
    'check version
    IF _FILEEXISTS(versionFile$) THEN
        fh = FREEFILE
        OPEN versionFile$ FOR INPUT AS #fh
        LINE INPUT #fh, a$
        IF a$ = projectVersion$ THEN sameVersion = 1: newProject = 0
        CLOSE #fh
    END IF
    IF sameVersion = 0 THEN
        'existing project incompatible, remove it
        CreateAndroidProject_Message "Removing existing project"
        SHELL _HIDE "cmd /c rmdir /s /q " + projectFolder
    ELSE
        CreateAndroidProject_Message "Updating existing project"
    END IF
END IF

IF newProject THEN
    CreateAndroidProject_Message "Creating new project"
    CreateAndroidProject_Message "Copying project template"

    IF _DIREXISTS(projectFolder) = 0 THEN MKDIR projectFolder

    SHELL _HIDE "cmd /c xcopy /e programs\android\template\untitled\*.* " + projectFolder

    'copy c folder (without unnecessary files)
    CreateAndroidProject_Message "Copying C folder"
    fh = FREEFILE
    OPEN "internal\temp\xcopy_exclude.txt" FOR OUTPUT AS #fh
    PRINT #fh, "c_compiler\"
    PRINT #fh, "os\"
    PRINT #fh, "download\"
    PRINT #fh, ".bat"
    PRINT #fh, ".command"
    PRINT #fh, ".sh"
    PRINT #fh, ".o"
    PRINT #fh, ".a"
    PRINT #fh, ".lib"
    PRINT #fh, ".txt"
    PRINT #fh, ".bin"
    CLOSE fh
    SHELL _HIDE "cmd /c xcopy /e /EXCLUDE:internal\temp\xcopy_exclude.txt " + cFolder + "\*.* " + projectFolder + "\app\src\main\jni\c"

    'set version
    fh = FREEFILE
    OPEN versionFile$ FOR OUTPUT AS #fh
    PRINT #fh, projectVersion$
    CLOSE #fh
ELSE
    CreateAndroidProject_Message "Cleaning project"
    SHELL _HIDE "cmd /c del /q " + projectFolder + "\app\src\main\jni\temp\*.*" 'must be unindexed temp folder

    'restore key files
    CreateAndroidProject_Message "Restoring setting files"
    CreateAndroidProject_RestoreFile "local.properties", projectFolder
    CreateAndroidProject_RestoreFile "untitled.iml", projectFolder
    CreateAndroidProject_RestoreFile ".idea\modules.xml", projectFolder
    CreateAndroidProject_RestoreFile ".idea\name", projectFolder
    CreateAndroidProject_RestoreFile "app\app.iml", projectFolder
    CreateAndroidProject_RestoreFile "app\build.gradle", projectFolder
    CreateAndroidProject_RestoreFile "add\src\main\AndroidManifest.xml", projectFolder
    CreateAndroidProject_RestoreFile "app\src\main\res\values\strings.xml", projectFolder
END IF

CreateAndroidProject_Message "Copying TEMP" + tempfolderindexstr2 + " (program source files) folder"
SHELL _HIDE "cmd /c copy internal\temp" + tempfolderindexstr2 + "\*.txt " + projectFolder + "\app\src\main\jni\temp" 'indexed to unindexed

'remove unrequired files
delStr$ = "cmd /c del /q " + projectFolder + "\app\src\main\jni\temp\"
SHELL _HIDE delStr$ + "xcopy_exclude.txt"
SHELL _HIDE delStr$ + "root.txt"
SHELL _HIDE delStr$ + "paths.txt"
SHELL _HIDE delStr$ + "files.txt"

'prepend fullscreen directive to main.txt
CreateAndroidProject_Message "Prepending _FULLSCREEN _SQUAREPIXELS directive"

thisFile$ = projectFolder + "\app\src\main\jni\temp\main.txt"

fh = FREEFILE
OPEN thisFile$ FOR BINARY AS #fh
a$ = SPACE$(LOF(fh))
GET #fh, , a$
CLOSE #fh
KILL thisFile$
OPEN thisFile$ FOR BINARY AS #fh
a2$ = "sub__fullscreen( 3 ,0);"
PUT #1, , a2$
PUT #1, , a$
CLOSE #fh

CreateAndroidProject_Message "Updating project references"

fh = FREEFILE
OPEN projectFolder + "\local.properties" FOR OUTPUT AS #fh
PRINT #fh, "sdk.dir=" + CreateAndroidProject_EscapeFileName$(CreateAndroidProject_GetSdkPath$, 1)
PRINT #fh, "ndk.dir=" + CreateAndroidProject_EscapeFileName$(CreateAndroidProject_GetNdkPath$, 1)
CLOSE #fh

IF _FILEEXISTS(projectFolder + "\" + projectName$ + ".iml") THEN KILL projectFolder + "\" + projectName$ + ".iml"
NAME projectFolder + "\untitled.iml" AS projectFolder + "\" + projectName$ + ".iml"

CreateAndroidProject_ReplaceInFile projectFolder + "\.idea\modules.xml", "untitled", projectName$
CreateAndroidProject_ReplaceInFile projectFolder + "\.idea\gradle.xml", "$QB64_GRADLE_HOME$", CreateAndroidProject_GetGradlePath$
CreateAndroidProject_ReplaceInFile projectFolder + "\.idea\.name", "untitled", projectName$
CreateAndroidProject_ReplaceInFile projectFolder + "\app\app.iml", "untitled", projectName$
CreateAndroidProject_ReplaceInFile projectFolder + "\app\build.gradle", "untitled", projectName$
CreateAndroidProject_ReplaceInFile projectFolder + "\app\build.gradle", "$QB64_NDK_BUILD_CMD_FILE$", CreateAndroidProject_EscapeFileName$(CreateAndroidProject_GetNdkPath$, 2) + "\\ndk-build.cmd"
CreateAndroidProject_ReplaceInFile projectFolder + "\app\src\main\AndroidManifest.xml", "untitled", projectName$
CreateAndroidProject_ReplaceInFile projectFolder + "\app\src\main\res\values\strings.xml", "untitled", projectName$

'REDIM SHARED installFiles(0) AS STRING
'REDIM SHARED installFilesIn(0) AS STRING
'REDIM SHARED installFolder(0) AS STRING
'REDIM SHARED installFolderIn(0) AS STRING

'IF idemode THEN basPath$ = idepath$ + pathsep$ ELSE basPath$ = getfilepath$(sourcefile$)

'IF LEN(basPath$) > 0 THEN
'    IF RIGHT$(basPath$, 1) = "/" OR RIGHT$(basPath$, 1) = "\" THEN basPath$ = LEFT$(basPath$, LEN(basPath$) - 1)
'END IF
'IF basPath$ = "" THEN basPath$ = "."


'to prevent misunderstanding files will first be moved to an isolation folder
'this isolation folder will be destroyed after work is completed

'create empty assets folder
DO WHILE _DIREXISTS(projectFolder + "\app\src\main\assets") 'just by waiting this problem can sometimes be resolved automatically
    CreateAndroidProject_Message "Waiting to clean open/locked folder '" + projectFolder + "\app\src\main\assets'..."
    _LIMIT 10
    SHELL _HIDE "cmd /c rmdir /s /q " + projectFolder + "\app\src\main\assets"
LOOP
MKDIR projectFolder + "\app\src\main\assets" 'may fail if assets folder is open/locked and this folder MUST be empty before continuing


dirCode$ = ""
fileCode$ = ""

CreateAndroidProject_Message "Adding $INSTALLFOLDER(s)"

FOR f = 1 TO AryLastStr(installFolder())
    p$ = installFolder(f)



    'IF idemode THEN basPath$ = idepath$ + pathsep$ ELSE basPath$ = getfilepath$(sourcefile$)


    'IF LEN(basPath$) > 0 THEN
    '    IF RIGHT$(basPath$, 1) = "/" OR RIGHT$(basPath$, 1) = "\" THEN basPath$ = LEFT$(basPath$, LEN(basPath$) - 1)
    'END IF
    'IF basPath$ = "" THEN basPath$ = "."

    basPath$ = installFolderSourceLocation(f)
    IF LEN(basPath$) > 0 THEN
        IF RIGHT$(basPath$, 1) = "/" OR RIGHT$(basPath$, 1) = "\" THEN basPath$ = LEFT$(basPath$, LEN(basPath$) - 1)
    END IF
    IF basPath$ = "" THEN basPath$ = "."

    path$ = basPath$
    IF p$ <> "" THEN path$ = path$ + "\" + p$

    'purge temp_assets
    IF _DIREXISTS(projectFolder + "\temp_assets") THEN SHELL _HIDE "cmd /c rmdir /s /q " + projectFolder + "\temp_assets"
    MKDIR projectFolder + "\temp_assets"
    'copy to temp_assets
    SHELL _HIDE "cmd /c xcopy /e " + CHR$(34) + path$ + CHR$(34) + " " + projectFolder + "\temp_assets"

    'files are now isolated in a known folder which makes path stripping easier

    p$ = installFolderIn(f)
    destPath$ = projectFolder$ + "\app\src\main\assets"

    'build dest path (it may not exist)
    tp$ = p$
    ii = 0
    DO WHILE INSTR(ii, tp$, "\")
        i = INSTR(ii, tp$, "\")
        IF i THEN
            tp2$ = LEFT$(tp$, i - 1)
            ii = i + 1
            d$ = destPath$ + "\" + tp2$
            IF _DIREXISTS(d$) = 0 THEN
                MKDIR d$
                CreateAndroidProject_AddDir dirCode$, tp2$
            END IF
        END IF
    LOOP
    tp2$ = tp$
    IF tp2$ <> "" THEN
        d$ = destPath$ + "\" + tp2$
        IF _DIREXISTS(d$) = 0 THEN
            MKDIR d$
            CreateAndroidProject_AddDir dirCode$, tp2$
        END IF
    END IF

    IF p$ <> "" THEN destPath$ = destPath$ + "\" + p$

    androidPath$ = p$
    IF LEN(androidPath$) <> 0 THEN androidPath$ = androidPath$ + "/"

    'generate file listing
    'PRINT "cmd /c dir /s /b " + projectFolder + "\temp_assets\*.* >internal\temp\files.txt"
    SHELL _HIDE "cmd /c dir /s /b " + projectFolder + "\temp_assets\*.* >internal\temp\files.txt"
    OPEN "internal\temp\files.txt" FOR INPUT AS #fh
    DO UNTIL EOF(fh)
        LINE INPUT #fh, f$
        'will include files and folders
        i = INSTR(f$, "\temp_assets\")
        lf$ = androidPath$ + RIGHT$(f$, LEN(f$) - i - 12)
        IF _DIREXISTS(f$) THEN
            'it's a folder
            '** add necessary code for building a folder **
            CreateAndroidProject_AddDir dirCode$, lf$
        ELSE
            'it's a file
            '** add necessary code importing an asset file **
            CreateAndroidProject_AddFile fileCode$, lf$
        END IF
    LOOP
    CLOSE #fh

    'copy to assets folder app\src\main\assets
    SHELL _HIDE "cmd /c xcopy /e " + projectFolder + "\temp_assets " + CHR$(34) + destPath$ + CHR$(34)

NEXT




CreateAndroidProject_Message "Adding $INSTALLFILES"

FOR f = 1 TO AryLastStr(installFiles())

    p$ = installFiles(f)

    basPath$ = installFilesSourceLocation(f)
    IF LEN(basPath$) > 0 THEN
        IF RIGHT$(basPath$, 1) = "/" OR RIGHT$(basPath$, 1) = "\" THEN basPath$ = LEFT$(basPath$, LEN(basPath$) - 1)
    END IF
    IF basPath$ = "" THEN basPath$ = "."

    path$ = basPath$
    IF p$ <> "" THEN path$ = path$ + "\" + p$

    'purge temp_assets
    IF _DIREXISTS(projectFolder + "\temp_assets") THEN SHELL _HIDE "cmd /c rmdir /s /q " + projectFolder + "\temp_assets"
    MKDIR projectFolder + "\temp_assets"

    'copy to temp_assets
    SHELL _HIDE "cmd /c copy " + CHR$(34) + path$ + CHR$(34) + " " + projectFolder + "\temp_assets"

    'files are now isolated in a known folder which makes path stripping easier

    p$ = installFilesIn(f)
    destPath$ = projectFolder$ + "\app\src\main\assets"

    'build dest path (it may not exist)
    tp$ = p$
    ii = 0
    DO WHILE INSTR(ii, tp$, "\")
        i = INSTR(ii, tp$, "\")
        IF i THEN
            tp2$ = LEFT$(tp$, i - 1)
            ii = i + 1
            d$ = destPath$ + "\" + tp2$
            IF _DIREXISTS(d$) = 0 THEN
                MKDIR d$
                CreateAndroidProject_AddDir dirCode$, tp2$
            END IF
        END IF
    LOOP
    tp2$ = tp$
    IF tp2$ <> "" THEN
        d$ = destPath$ + "\" + tp2$
        IF _DIREXISTS(d$) = 0 THEN
            MKDIR d$
            CreateAndroidProject_AddDir dirCode$, tp2$
        END IF
    END IF

    IF p$ <> "" THEN destPath$ = destPath$ + "\" + p$

    androidPath$ = p$
    IF LEN(androidPath$) <> 0 THEN androidPath$ = androidPath$ + "/"

    'generate file listing
    'PRINT "cmd /c dir /s /b " + projectFolder + "\temp_assets\*.* >internal\temp\files.txt"
    SHELL _HIDE "cmd /c dir /s /b " + projectFolder + "\temp_assets\*.* >internal\temp\files.txt"
    OPEN "internal\temp\files.txt" FOR INPUT AS #fh
    DO UNTIL EOF(fh)
        LINE INPUT #fh, f$
        'will include files and folders
        i = INSTR(f$, "\temp_assets\")
        lf$ = androidPath$ + RIGHT$(f$, LEN(f$) - i - 12)
        IF _DIREXISTS(f$) THEN
            'it's a folder
            'must be ignored
        ELSE
            'it's a file
            '** add necessary code importing an asset file **
            CreateAndroidProject_AddFile fileCode$, lf$
        END IF
    LOOP
    CLOSE #fh

    'copy to assets folder app\src\main\assets
    SHELL _HIDE "cmd /c copy " + projectFolder + "\temp_assets\*.* " + CHR$(34) + destPath$ + CHR$(34)

NEXT

'purge temp_assets
IF _DIREXISTS(projectFolder + "\temp_assets") THEN SHELL _HIDE "cmd /c rmdir /s /q " + projectFolder + "\temp_assets"

OPEN projectFolder + "\app\src\main\jni\temp\assets.txt" FOR OUTPUT AS #1
PRINT #1, dirCode$
PRINT #1, fileCode$
CLOSE #1

'mkdir("subfolder",0770);
'android_get_file_asset(mgr, "subfolder/subfolderfile.txt");

CreateAndroidProject_Message "Android project generation complete"

END SUB


