mv setup_win.bat internal\

$filename = "qb64_" + (get-date -uformat "%Y-%m-%d-%H-%M-%S") + "_" + $Env:APPVEYOR_REPO_COMMIT.Substring(0,7) + "-" + $Env:APPVEYOR_REPO_BRANCH + "_win_" + $Env:PLATFORM + ".7z"
cd ..
7z a '-xr@qb64\.travis\common-exclusion.list' '-xr@qb64\.travis\win-exclusion.list' $filename qb64

scp -q -o StrictHostKeyChecking=no $filename m6rosupy1q2t@qb64.org:autobuilds/$Env:APPVEYOR_REPO_BRANCH/
