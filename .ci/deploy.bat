@ECHO OFF
SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
cd ..
set BUCKET=qb64-dev-builds
set TIMEX=%TIME: =0%
set archive=qb64_%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2%-%TIMEX:~0,2%-%TIMEX:~3,2%-%TIMEX:~6,2%_%GITHUB_SHA:~0,7%_win-%PLATFORM%.7z
7z a -xr@qb64\.ci\common-exclusion.list -xr@qb64\.ci\win-exclusion.list %archive% qb64

aws s3 cp %archive% s3://%BUCKET%/win-%PLATFORM%/
