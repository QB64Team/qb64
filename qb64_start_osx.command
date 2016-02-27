cd "$(dirname "$0")"
./qb64 &
osascript -e 'tell application "Terminal" to close (every window whose name contains "qb64_start_osx.command")' &
osascript -e 'if (count the windows of application "Terminal") is 0 then tell application "Terminal" to quit' &
exit