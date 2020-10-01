@ECHO OFF
SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

CD ".."
SET TIMEX=%TIME: =0%
SET "archive=qb64_%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2%-%TIMEX:~0,2%-%TIMEX:~3,2%-%TIMEX:~6,2%_%GITHUB_SHA:~0,7%_win-%PLATFORM%.7z"
7z a -xr@qb64\.ci\common-exclusion.list -xr@qb64\.ci\win-exclusion.list %archive% qb64

FOR /L %%i IN (1,1,10) DO (
    scp %archive% remote-server:autobuilds/development/
    IF ERRORLEVEL 1 (
        ECHO scp %archive% failed - attempt %%i/10
    ) ELSE (
        GOTO :doversion
    )
)

:doversion

SET "archive=versioninfo.txt"
ECHO Dev build generated on %DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2%, from git ^<a href="https://github.com/QB64Team/qb64/commits/development" target="_blank"^>%GITHUB_SHA:~0,7%^</a^> > %archive%

FOR /L %%i IN (1,1,10) DO (
    scp %archive% remote-server:autobuilds/development/
    IF ERRORLEVEL 1 (
        ECHO scp %archive% failed - attempt %%i/10
    ) ELSE (
        EXIT /B 0
    )
)
