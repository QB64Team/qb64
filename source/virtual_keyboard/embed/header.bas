'$include:'..\..\qb_framework\qb_framework_global.bas'
'$include:'..\virtual_keyboard_global.bas'
DEFSNG A-Z
$INSTALLFILES "..\..\..\cyberbit.ttf"
$INSTALLFILES "..\layouts\virtual_keyboard_layout_default.txt"
dim shared appRootPath as string
appRootPath$=_CWD$+"\" '_CWD$ is the application root when the program launches, preserve this value for later use before client program changes the path
