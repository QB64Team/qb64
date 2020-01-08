SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

echo From git %GITHUB_SHA:~0,7% > internal\version.txt
qb64_bootstrap.exe -x source\qb64.bas -o qb64.exe
IF ERRORLEVEL 1 exit /b 1


