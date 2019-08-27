
'special codes:

'-1 Any numeric variable (will be made explicit by a C cast)
'   Typically, these are used when multiple C functions exist

'-2 Offset+Size(in bytes)
'   Size is the largest safe memory block available from the offset
'   used for: CALL INTERRUPT[X]

'-3 Offset+Size(in bytes)
'   Size is the largest safe memory block available from the offset
'   *Like -2, but restrictions apply
'   used for: GET/PUT(graphics)

'-4 Offset+Size(in bytes)
'   Size is the size of the element referenced
'   used for: GET/PUT(file)
' -5 Offset only
' -6 Size only

'-7 '_MEM' structure referring to the passed variable

'special return codes:
'none

'stubs for internally handled commands:
clearid
id.n = "ASC": id.subfunc = 2: id.callname = "sub_stub": regid
clearid
id.n = "END": id.subfunc = 2: id.callname = "sub_stub": regid
clearid
id.n = "LSET": id.subfunc = 2: id.callname = "sub_stub": regid
clearid
id.n = "RSET": id.subfunc = 2: id.callname = "sub_stub": regid
clearid
id.n = "MID": id.subfunc = 2: id.callname = "sub_stub": id.musthave = "$": regid
clearid
id.n = "PRINT": id.subfunc = 2: id.callname = "sub_stub": regid
clearid
id.n = "OPTION": id.subfunc = 2: id.callname = "sub_stub": regid
clearid
id.n = "SWAP": id.subfunc = 2: id.callname = "sub_stub": regid
clearid
id.n = "SYSTEM": id.subfunc = 2: id.callname = "sub_stub": regid
clearid
id.n = "WRITE": id.subfunc = 2: id.callname = "sub_stub": regid
clearid
id.n = "READ": id.subfunc = 2: id.callname = "sub_stub": regid
clearid
id.n = "CLOSE": id.subfunc = 2: id.callname = "sub_stub": regid
clearid
id.n = "RESET": id.subfunc = 2: id.callname = "sub_stub": regid
clearid
id.n = "INPUT": id.subfunc = 2: id.callname = "sub_stub": regid
'stubs for unimplemented commands:
clearid
id.n = "TRON": id.subfunc = 2: id.callname = "sub_stub": regid
clearid
id.n = "TROFF": id.subfunc = 2: id.callname = "sub_stub": regid
clearid
id.n = "LIST": id.subfunc = 2: id.callname = "sub_stub": regid
clearid
id.n = "DEF": id.subfunc = 2: id.callname = "sub_stub": id.secondargcantbe = "SEG": regid
clearid
id.n = "IOCTL": id.subfunc = 2: id.callname = "sub_stub": regid
clearid
id.n = "IOCTL": id.subfunc = 1: id.callname = "func_stub": id.musthave = "$": id.args = 1: id.arg = MKL$(LONGTYPE - ISPOINTER): id.ret = STRINGTYPE - ISPOINTER: regid
clearid
id.n = "FRE": id.subfunc = 1: id.callname = "func_stub": id.args = 1: id.arg = MKL$(LONGTYPE - ISPOINTER): id.ret = LONGTYPE - ISPOINTER: regid
clearid
id.n = "SETMEM": id.subfunc = 1: id.callname = "func_stub": id.args = 1: id.arg = MKL$(LONGTYPE - ISPOINTER): id.ret = LONGTYPE - ISPOINTER: regid
clearid
id.n = "FILEATTR": id.subfunc = 1: id.callname = "func_stub": id.args = 2: id.arg = MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER): id.ret = LONGTYPE - ISPOINTER: regid
clearid
id.n = "_MEMGET": id.subfunc = 2: id.callname = "sub_stub": regid
clearid
id.n = "_MEMPUT": id.subfunc = 2: id.callname = "sub_stub": regid
clearid
id.n = "_MEMFILL": id.subfunc = 2: id.callname = "sub_stub": regid
clearid
id.n = "_CONTINUE": id.subfunc = 2: id.callname = "sub_stub": regid


clearid
id.n = "_RESIZE"
id.subfunc = 2
id.callname = "sub__resize"
id.args = 2
id.arg = MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "[{ON|OFF}][,{_STRETCH|_SMOOTH}]"
regid

clearid
id.n = "_RESIZE"
id.subfunc = 1
id.callname = "func__resize"
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_RESIZEWIDTH"
id.subfunc = 1
id.callname = "func__resizewidth"
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_RESIZEHEIGHT"
id.subfunc = 1
id.callname = "func__resizeheight"
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_SCALEDWIDTH"
id.subfunc = 1
id.callname = "func__scaledwidth"
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_SCALEDHEIGHT"
id.subfunc = 1
id.callname = "func__scaledheight"
id.ret = LONGTYPE - ISPOINTER
regid


clearid
id.n = "_GLRENDER"
id.subfunc = 2
id.callname = "sub__glrender"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "{_BEHIND|_ONTOP|_ONLY}"
regid

clearid
id.n = "_DISPLAYORDER"
id.subfunc = 2
id.callname = "sub__displayorder"
id.args = 4
id.arg = MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "[{_SOFTWARE|_HARDWARE|_HARDWARE1|_GLRENDER}[,{_SOFTWARE|_HARDWARE|_HARDWARE1|_GLRENDER}[,{_SOFTWARE|_HARDWARE|_HARDWARE1|_GLRENDER}[,{_SOFTWARE|_HARDWARE|_HARDWARE1|_GLRENDER}]]]]"
regid

clearid
id.n = "_MEMGET"
id.subfunc = 1
id.callname = "func__memget"
id.args = 3
id.arg = MKL$(UDTTYPE + (1)) + MKL$(OFFSETTYPE - ISPOINTER) + MKL$(-1) 'x = _MEMGET(block, offset, type)
id.ret = -1
regid

clearid
id.n = "_MEM"
id.subfunc = 1
id.callname = "func__mem"
'id.args = 1
'id.arg = MKL$(-7)
id.args = 2
id.arg = MKL$(OFFSETTYPE - ISPOINTER) + MKL$(OFFSETTYPE - ISPOINTER)
id.specialformat = "?[,?]"
id.ret = ISUDT + (1) 'the _MEM type is the first TYPE defined
regid
'---special case---

clearid
id.n = "_MEMELEMENT"
id.subfunc = 1
id.callname = "func__mem"
id.args = 1
id.arg = MKL$(-8)
id.ret = ISUDT + (1) 'the _MEM type is the first TYPE defined
regid
'---special case---



clearid
id.n = "_MEMFREE"
id.subfunc = 2
id.callname = "sub__memfree"
id.args = 1
id.arg = MKL$(UDTTYPE + (1))
regid

clearid
id.n = "_MEMEXISTS"
id.subfunc = 1
id.callname = "func__memexists"
id.args = 1
id.arg = MKL$(UDTTYPE + (1))
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_MEMNEW"
id.subfunc = 1
id.callname = "func__memnew"
id.args = 1
id.arg = MKL$(OFFSETTYPE - ISPOINTER)
id.ret = ISUDT + (1) 'the _MEM type is the first TYPE defined
regid

clearid
id.n = "_MEMIMAGE"
id.subfunc = 1
id.callname = "func__memimage"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "[?]" 'dest is default
id.ret = ISUDT + (1) 'the _MEM type is the first TYPE defined
regid

clearid '_MEMCOPY a, aoffset, bytes TO b, boffset
id.n = "_MEMCOPY"
id.subfunc = 2
id.callname = "sub__memcopy"
id.args = 5
id.arg = MKL$(UDTTYPE + (1)) + MKL$(OFFSETTYPE - ISPOINTER) + MKL$(OFFSETTYPE - ISPOINTER) + MKL$(UDTTYPE + (1)) + MKL$(OFFSETTYPE - ISPOINTER)
id.specialformat = "?,?,?{TO}?,?" 'dest is default
regid

clearid
id.n = "_CONSOLETITLE"
id.subfunc = 2
id.callname = "sub__consoletitle"
id.args = 1
id.arg = MKL$(STRINGTYPE - ISPOINTER)
regid

clearid
id.n = "_SCREENSHOW"
id.subfunc = 2
id.callname = "sub__screenshow"
regid

clearid
id.n = "_SCREENHIDE"
id.subfunc = 2
id.callname = "sub__screenhide"
regid

clearid
id.n = "_SCREENHIDE"
id.subfunc = 1
id.callname = "func__screenhide"
id.ret = LONGTYPE - ISPOINTER
regid


clearid
id.n = "_CONSOLE"
id.subfunc = 1
id.callname = "func__console"
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_CONSOLE"
id.subfunc = 2
id.callname = "sub__console"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "{ON|OFF}"
regid

clearid
id.n = "_CONTROLCHR"
id.subfunc = 2
id.callname = "sub__controlchr"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "{ON|OFF}"
regid

clearid
id.n = "_BLINK"
id.subfunc = 2
id.callname = "sub__blink"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "{ON|OFF}"
regid

clearid
id.n = "_BLINK"
id.subfunc = 1
id.callname = "func__blink"
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_FILEEXISTS"
id.subfunc = 1
id.callname = "func__fileexists"
id.args = 1
id.arg = MKL$(STRINGTYPE - ISPOINTER)
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_DIREXISTS"
id.subfunc = 1
id.callname = "func__direxists"
id.args = 1
id.arg = MKL$(STRINGTYPE - ISPOINTER)
id.ret = LONGTYPE - ISPOINTER
regid

'QB64 DEVICE interface

clearid
id.n = "STICK": id.Dependency=DEPENDENCY_DEVICEINPUT
id.subfunc = 1
id.callname = "func_stick"
id.args = 2
id.arg = MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
id.ret = LONGTYPE - ISPOINTER
id.specialformat = "?[,?]"
regid

clearid
id.n = "STRIG": id.Dependency=DEPENDENCY_DEVICEINPUT
id.subfunc = 1
id.callname = "func_strig"
id.args = 2
id.arg = MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
id.ret = LONGTYPE - ISPOINTER
id.specialformat = "?[,?]"
regid

clearid
id.n = "STRIG": id.Dependency=DEPENDENCY_DEVICEINPUT
id.subfunc = 2
id.callname = "sub_strig"
id.args = 3
id.arg = MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "[(?[,?])]{ON|OFF|STOP}"
'In previous versions of BASIC, the statement STRIG ON enables testing of the joystick triggers; STRIG OFF disables joystick trigger testing. QuickBASIC ignores STRIG ON and STRIG OFF statements--the statements are provided for compatibility with earlier versions.
regid



clearid
id.n = "_DEVICES": id.Dependency=DEPENDENCY_DEVICEINPUT
id.subfunc = 1
id.callname = "func__devices"
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_DEVICE": id.Dependency=DEPENDENCY_DEVICEINPUT
id.musthave = "$"
id.subfunc = 1
id.callname = "func__device"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.ret = STRINGTYPE - ISPOINTER
id.specialformat = "[?]"
regid

clearid
id.n = "_DEVICEINPUT": id.Dependency=DEPENDENCY_DEVICEINPUT
id.subfunc = 1
id.callname = "func__deviceinput"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.ret = LONGTYPE - ISPOINTER
id.specialformat = "[?]"
regid

clearid
id.n = "_LASTBUTTON": id.Dependency=DEPENDENCY_DEVICEINPUT
id.subfunc = 1
id.callname = "func__lastbutton"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.ret = LONGTYPE - ISPOINTER
id.specialformat = "[?]"
regid

clearid
id.n = "_LASTAXIS": id.Dependency=DEPENDENCY_DEVICEINPUT
id.subfunc = 1
id.callname = "func__lastaxis"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.ret = LONGTYPE - ISPOINTER
id.specialformat = "[?]"
regid

clearid
id.n = "_LASTWHEEL": id.Dependency=DEPENDENCY_DEVICEINPUT
id.subfunc = 1
id.callname = "func__lastwheel"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.ret = LONGTYPE - ISPOINTER
id.specialformat = "[?]"
regid

clearid
id.n = "_BUTTON": id.Dependency=DEPENDENCY_DEVICEINPUT
id.subfunc = 1
id.callname = "func__button"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.ret = LONGTYPE - ISPOINTER
id.specialformat = "[?]"
regid

clearid
id.n = "_BUTTONCHANGE": id.Dependency=DEPENDENCY_DEVICEINPUT
id.subfunc = 1
id.callname = "func__buttonchange"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.ret = LONGTYPE - ISPOINTER
id.specialformat = "[?]"
regid

clearid
id.n = "_AXIS": id.Dependency=DEPENDENCY_DEVICEINPUT
id.subfunc = 1
id.callname = "func__axis"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.ret = SINGLETYPE - ISPOINTER
id.specialformat = "[?]"
regid


clearid
id.n = "_WHEEL": id.Dependency=DEPENDENCY_DEVICEINPUT
id.subfunc = 1
id.callname = "func__wheel"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.ret = SINGLETYPE - ISPOINTER
id.specialformat = "[?]"
regid










clearid
id.n = "KEY"
id.subfunc = 2
id.callname = "sub_key"
id.args = 2
id.arg = MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "(?){ON|OFF|STOP}"
regid

clearid
id.n = "_SCREENX"
id.subfunc = 1
id.callname = "func__screenx"
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_SCREENY"
id.subfunc = 1
id.callname = "func__screeny"
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_SCREENMOVE"
id.subfunc = 2
id.callname = "sub__screenmove"
id.args = 2
id.arg = MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "[{_MIDDLE}][?,?]"
regid

clearid
id.n = "_MOUSEMOVE"
id.subfunc = 2
id.callname = "sub__mousemove"
id.args = 2
id.arg = MKL$(SINGLETYPE - ISPOINTER) + MKL$(SINGLETYPE - ISPOINTER)
regid

clearid
id.n = "_OS"
id.musthave = "$"
id.subfunc = 1
id.callname = "func__os"
id.ret = STRINGTYPE - ISPOINTER
regid

clearid
id.n = "_TITLE"
id.musthave = "$"
id.subfunc = 1
id.callname = "func__title"
id.ret = STRINGTYPE - ISPOINTER
regid

clearid
id.n = "_MAPUNICODE"
id.subfunc = 2
id.callname = "sub__mapunicode"
id.args = 2
id.arg = MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "?{TO}?"
regid

clearid
id.n = "_MAPUNICODE"
id.subfunc = 1
id.callname = "func__mapunicode"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_KEYDOWN"
id.subfunc = 1
id.callname = "func__keydown"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_KEYHIT"
id.subfunc = 1
id.callname = "func__keyhit"
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_WINDOWHANDLE"
id.subfunc = 1
id.callname = "func__handle"
id.ret = INTEGER64TYPE - ISPOINTER
regid

clearid
id.n = "FILES"
id.subfunc = 2
id.callname = "sub_files"
id.args = 1
id.arg = MKL$(STRINGTYPE - ISPOINTER)
id.specialformat = "[?]"
regid

clearid
id.n = "_PRINTIMAGE": id.Dependency = DEPENDENCY_PRINTER
id.subfunc = 2
id.callname = "sub__printimage"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
''proposed version:
''id.specialformat = "[_SQUAREPIXELS][?][,(?,?)-(?,?)]"
regid

'remote desktop

clearid
id.n = "_SCREENCLICK"
id.subfunc = 2
id.callname = "sub__screenclick"
id.args = 3
id.arg = MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "?,?[,?]"
regid

clearid
id.n = "_SCREENPRINT"
id.subfunc = 2
id.callname = "sub__screenprint"
id.args = 1
id.arg = MKL$(STRINGTYPE - ISPOINTER)
regid

clearid
id.n = "_SCREENIMAGE": id.Dependency = DEPENDENCY_SCREENIMAGE
id.subfunc = 1
id.callname = "func__screenimage"
id.args = 4
id.arg = MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "[?,?,?,?]"
id.ret = LONGTYPE - ISPOINTER
regid





clearid
id.n = "LOCK"
id.subfunc = 2
id.callname = "sub_lock"
id.args = 3
id.arg = MKL$(LONGTYPE - ISPOINTER) + MKL$(INTEGER64TYPE - ISPOINTER) + MKL$(INTEGER64TYPE - ISPOINTER)
id.specialformat = "[#]?[,[?][{TO}?]]"
regid

clearid
id.n = "UNLOCK"
id.subfunc = 2
id.callname = "sub_unlock"
id.args = 3
id.arg = MKL$(LONGTYPE - ISPOINTER) + MKL$(INTEGER64TYPE - ISPOINTER) + MKL$(INTEGER64TYPE - ISPOINTER)
id.specialformat = "[#]?[,[?][{TO}?]]"
regid

clearid
id.n = "_FREETIMER"
id.subfunc = 1
id.callname = "func__freetimer"
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "TIMER"
id.subfunc = 2
id.callname = "sub_timer"
id.args = 2
id.arg = MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "[(?)]{ON|OFF|STOP|FREE}"
regid

clearid
id.n = "_FULLSCREEN"
id.subfunc = 2
id.callname = "sub__fullscreen"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "[{_OFF|_STRETCH|_SQUAREPIXELS|OFF}][,{_SMOOTH}]"
regid

clearid
id.n = "_ALLOWFULLSCREEN"
id.subfunc = 2
id.callname = "sub__allowfullscreen"
id.args = 2
id.arg = MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "[{_STRETCH|_SQUAREPIXELS|_OFF|_ALL|OFF}][,{_SMOOTH|_OFF|_ALL|OFF}]"
regid

clearid
id.n = "_FULLSCREEN"
id.subfunc = 1
id.callname = "func__fullscreen"
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_SMOOTH"
id.subfunc = 1
id.callname = "func__fullscreensmooth"
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_WINDOWHASFOCUS"
id.subfunc = 1
id.callname = "func__hasfocus"
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_CLIPBOARD"
id.musthave = "$"
id.subfunc = 2
id.callname = "sub__clipboard"
id.args = 1
id.arg = MKL$(STRINGTYPE - ISPOINTER)
id.specialformat = "=?"
regid

clearid
id.n = "_CLIPBOARD"
id.musthave = "$"
id.subfunc = 1
id.callname = "func__clipboard"
id.ret = STRINGTYPE - ISPOINTER
regid

clearid
id.n = "_CLIPBOARDIMAGE": id.Dependency = DEPENDENCY_SCREENIMAGE
id.subfunc = 1
id.callname = "func__clipboardimage"
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_CLIPBOARDIMAGE": id.Dependency = DEPENDENCY_SCREENIMAGE
id.subfunc = 2
id.callname = "sub__clipboardimage"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "=?"
regid

clearid
id.n = "_EXIT"
id.subfunc = 1
id.callname = "func__exit"
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_OPENHOST": id.Dependency = DEPENDENCY_SOCKETS
id.subfunc = 1
id.callname = "func__openhost"
id.args = 1
id.arg = MKL$(STRINGTYPE - ISPOINTER)
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_CONNECTED"
id.subfunc = 1
id.callname = "func__connected"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_CONNECTIONADDRESS"
id.mayhave = "$"
id.subfunc = 1
id.callname = "func__connectionaddress"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.ret = STRINGTYPE - ISPOINTER
regid

clearid
id.n = "_OPENCONNECTION"
id.subfunc = 1
id.callname = "func__openconnection"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_OPENCLIENT": id.Dependency = DEPENDENCY_SOCKETS
id.subfunc = 1
id.callname = "func__openclient"
id.args = 1
id.arg = MKL$(STRINGTYPE - ISPOINTER)
id.ret = LONGTYPE - ISPOINTER
regid


clearid
id.n = "ENVIRON"
id.musthave = "$"
id.subfunc = 1
id.callname = "func_environ"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.ret = STRINGTYPE - ISPOINTER
regid

clearid
id.n = "ENVIRON"
id.subfunc = 2
id.callname = "sub_environ"
id.args = 1
id.arg = MKL$(STRINGTYPE - ISPOINTER)
regid

clearid
id.n = "_ERRORLINE"
id.subfunc = 1
id.callname = "func__errorline"
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_INCLERRORLINE"
id.subfunc = 1
id.callname = "func__inclerrorline"
id.ret = LONGTYPE - ISPOINTER
regid


clearid
id.n = "_DISPLAY"
id.subfunc = 2
id.callname = "sub__display"
regid

clearid
id.n = "_AUTODISPLAY"
id.subfunc = 2
id.callname = "sub__autodisplay"
regid

clearid
id.n = "_LIMIT"
id.subfunc = 2
id.callname = "sub__limit"
id.args = 1
id.arg = MKL$(DOUBLETYPE - ISPOINTER)
regid

clearid
id.n = "_FPS"
id.subfunc = 2
id.callname = "sub__fps"
id.args = 1
id.arg = MKL$(DOUBLETYPE - ISPOINTER)
id.specialformat = "[{_AUTO}][?]"
regid

clearid
id.n = "_DELAY"
id.subfunc = 2
id.callname = "sub__delay"
id.args = 1
id.arg = MKL$(DOUBLETYPE - ISPOINTER)
regid

clearid
id.n = "_ICON": id.Dependency = DEPENDENCY_ICON
id.subfunc = 2
id.callname = "sub__icon"
id.args = 2
id.arg = MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "[?[,?]]"
regid

clearid
id.n = "_TITLE"
id.subfunc = 2
id.callname = "sub__title"
id.args = 1
id.arg = MKL$(STRINGTYPE - ISPOINTER)
regid

clearid
id.n = "_ECHO"
id.subfunc = 2
id.callname = "sub__echo"
id.args = 1
id.arg = MKL$(STRINGTYPE - ISPOINTER)
regid

clearid
id.n = "_ACCEPTFILEDROP"
id.subfunc = 2
id.callname = "sub__filedrop"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "[{ON|OFF}]"
regid

clearid
id.n = "_ACCEPTFILEDROP"
id.subfunc = 1
id.callname = "func__filedrop"
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_FINISHDROP"
id.subfunc = 2
id.callname = "sub__finishdrop"
regid

clearid
id.n = "_TOTALDROPPEDFILES"
id.subfunc = 1
id.callname = "func__totaldroppedfiles"
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_DROPPEDFILE"
id.mayhave = "$"
id.subfunc = 1
id.callname = "func__droppedfile"
id.ret = STRINGTYPE - ISPOINTER
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "[?]"
regid

clearid
id.n = "CLEAR"
id.subfunc = 2
id.callname = "sub_clear"
id.args = 3
id.arg = MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "[?][,[?][,?]]"
regid

'IMAGE CREATION/FREEING

clearid
id.n = "_NEWIMAGE"
id.subfunc = 1
id.callname = "func__newimage"
id.args = 3
id.arg = MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "?,?[,?]"
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_LOADIMAGE": id.Dependency = DEPENDENCY_IMAGE_CODEC
id.subfunc = 1
id.callname = "func__loadimage"
id.args = 2
id.arg = MKL$(STRINGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "?[,?]"
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_FREEIMAGE"
id.subfunc = 2
id.callname = "sub__freeimage"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "[?]"
regid

clearid
id.n = "_COPYIMAGE"
id.subfunc = 1
id.callname = "func__copyimage"
id.args = 2
id.arg = MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "?[,?]"
id.ret = LONGTYPE - ISPOINTER
regid

'IMAGE SELECTION

clearid
id.n = "_SOURCE"
id.subfunc = 2
id.callname = "sub__source"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "?"
regid

clearid
id.n = "_DEST"
id.subfunc = 2
id.callname = "sub__dest"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "?"
regid

clearid
id.n = "_SOURCE"
id.subfunc = 1
id.callname = "func__source"
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_DEST"
id.subfunc = 1
id.callname = "func__dest"
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_DISPLAY"
id.subfunc = 1
id.callname = "func__display"
id.ret = LONGTYPE - ISPOINTER
regid

'IMAGE SETTINGS

clearid
id.n = "_BLEND"
id.subfunc = 2
id.callname = "sub__blend"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "[?]"
regid

clearid
id.n = "_DONTBLEND"
id.subfunc = 2
id.callname = "sub__dontblend"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "[?]"
regid

clearid
id.n = "_CLEARCOLOR"
id.subfunc = 2
id.callname = "sub__clearcolor"
id.args = 2
id.arg = MKL$(ULONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "[{_NONE}][?][,?]"
regid

'USING/CHANGING A SURFACE

clearid
id.n = "_PUTIMAGE"
id.subfunc = 2
id.callname = "sub__putimage"
id.args = 10
id.arg = MKL$(DOUBLETYPE - ISPOINTER) + MKL$(DOUBLETYPE - ISPOINTER) + MKL$(DOUBLETYPE - ISPOINTER) + MKL$(DOUBLETYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER) + MKL$(DOUBLETYPE - ISPOINTER) + MKL$(DOUBLETYPE - ISPOINTER) + MKL$(DOUBLETYPE - ISPOINTER) + MKL$(DOUBLETYPE - ISPOINTER)
id.specialformat = "[[{STEP}](?,?)[-[{STEP}](?,?)]][,[?][,[?][,[[{STEP}](?,?)[-[{STEP}](?,?)]][,{_SMOOTH}]]]]"
regid

clearid
id.n = "_MAPTRIANGLE"
id.subfunc = 2
id.callname = "sub__maptriangle"
id.args = 19
id.arg = MKL$(LONGTYPE - ISPOINTER)+MKL$(SINGLETYPE - ISPOINTER) + MKL$(SINGLETYPE - ISPOINTER) + MKL$(SINGLETYPE - ISPOINTER) + MKL$(SINGLETYPE - ISPOINTER) + MKL$(SINGLETYPE - ISPOINTER) + MKL$(SINGLETYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER) + MKL$(SINGLETYPE - ISPOINTER) + MKL$(SINGLETYPE - ISPOINTER) + MKL$(SINGLETYPE - ISPOINTER) + MKL$(SINGLETYPE - ISPOINTER) + MKL$(SINGLETYPE - ISPOINTER) + MKL$(SINGLETYPE - ISPOINTER) + MKL$(SINGLETYPE - ISPOINTER) + MKL$(SINGLETYPE - ISPOINTER) + MKL$(SINGLETYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "[{_CLOCKWISE|_ANTICLOCKWISE}][{_SEAMLESS}](?,?)-(?,?)-(?,?)[,?]{TO}(?,?[,?])-(?,?[,?])-(?,?[,?])[,[?][,{_SMOOTH|_SMOOTHSHRUNK|_SMOOTHSTRETCHED}]]"
regid

clearid
id.n = "_DEPTHBUFFER"
id.subfunc = 2
id.callname = "sub__depthbuffer"
id.args = 2
id.arg = MKL$(LONGTYPE - ISPOINTER)+MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "{ON|OFF|LOCK|_CLEAR}[,?]"
regid

clearid
id.n = "_SETALPHA"
id.subfunc = 2
id.callname = "sub__setalpha"
id.args = 4
id.arg = MKL$(ULONGTYPE - ISPOINTER) + MKL$(ULONGTYPE - ISPOINTER) + MKL$(ULONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "?[,[?[{TO}?]][,?]]"
regid

'IMAGE INFO

clearid
id.n = "_WIDTH"
id.subfunc = 1
id.callname = "func__width"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "[?]"
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_HEIGHT"
id.subfunc = 1
id.callname = "func__height"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "[?]"
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_PIXELSIZE"
id.subfunc = 1
id.callname = "func__pixelsize"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "[?]"
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_CLEARCOLOR"
id.subfunc = 1
id.callname = "func__clearcolor"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "[?]"
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_BLEND"
id.subfunc = 1
id.callname = "func__blend"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "[?]"
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_DEFAULTCOLOR"
id.subfunc = 1
id.callname = "func__defaultcolor"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "[?]"
id.ret = ULONGTYPE - ISPOINTER
regid

clearid
id.n = "_BACKGROUNDCOLOR"
id.subfunc = 1
id.callname = "func__backgroundcolor"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "[?]"
id.ret = ULONGTYPE - ISPOINTER
regid

'256 COLOR PALETTES

clearid
id.n = "_PALETTECOLOR"
id.subfunc = 1
id.callname = "func__palettecolor"
id.args = 2
id.arg = MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "?[,?]"
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_PALETTECOLOR"
id.subfunc = 2
id.callname = "sub__palettecolor"
id.args = 3
id.arg = MKL$(LONGTYPE - ISPOINTER) + MKL$(ULONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "?,?[,?]"
regid

clearid
id.n = "_COPYPALETTE"
id.subfunc = 2
id.callname = "sub__copypalette"
id.args = 2
id.arg = MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "[?][,?]"
regid

'FONT SUPPORT

clearid
id.n = "_LOADFONT": id.Dependency = DEPENDENCY_LOADFONT
id.subfunc = 1
id.callname = "func__loadfont"
id.args = 3
id.arg = MKL$(STRINGTYPE - ISPOINTER) + MKL$(DOUBLETYPE - ISPOINTER) + MKL$(STRINGTYPE - ISPOINTER)
id.specialformat = "?,?[,?]"
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_FONT"
id.subfunc = 2
id.callname = "sub__font"
id.args = 2
id.arg = MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "?[,?]"
regid

clearid
id.n = "_FONTWIDTH"
id.subfunc = 1
id.callname = "func__fontwidth"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "[?]"
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_FONTHEIGHT"
id.subfunc = 1
id.callname = "func__fontheight"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "[?]"
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_FONT"
id.subfunc = 1
id.callname = "func__font"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "[?]"
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_PRINTSTRING"
id.subfunc = 2
id.callname = "sub__printstring"
id.args = 4
id.arg = MKL$(DOUBLETYPE - ISPOINTER) + MKL$(DOUBLETYPE - ISPOINTER) + MKL$(STRINGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "[{STEP}](?,?),?[,?]"
regid

clearid
id.n = "_PRINTWIDTH"
id.subfunc = 1
id.callname = "func__printwidth"
id.args = 2
id.arg = MKL$(STRINGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "?[,?]"
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_FREEFONT"
id.subfunc = 2
id.callname = "sub__freefont"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "?"
regid

clearid
id.n = "_PRINTMODE"
id.subfunc = 2
id.callname = "sub__printmode"
id.args = 2
id.arg = MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "{_FILLBACKGROUND|_KEEPBACKGROUND|_ONLYBACKGROUND}[,?]"
regid

clearid
id.n = "_PRINTMODE"
id.subfunc = 1
id.callname = "func__printmode"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "[?]"
id.ret = LONGTYPE - ISPOINTER
regid

'WORKING WITH COLORS

clearid
id.n = "_RGBA"
id.subfunc = 1
id.callname = "func__rgba"
id.args = 5
id.arg = MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "?,?,?,?[,?]"
id.ret = ULONGTYPE - ISPOINTER
regid

clearid
id.n = "_RGB"
id.subfunc = 1
id.callname = "func__rgb"
id.args = 4
id.arg = MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "?,?,?[,?]"
id.ret = ULONGTYPE - ISPOINTER
regid

clearid
id.n = "_RED"
id.subfunc = 1
id.callname = "func__red"
id.args = 2
id.arg = MKL$(ULONGTYPE - ISPOINTER) + MKL$(ULONGTYPE - ISPOINTER)
id.specialformat = "?[,?]"
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_GREEN"
id.subfunc = 1
id.callname = "func__green"
id.args = 2
id.arg = MKL$(ULONGTYPE - ISPOINTER) + MKL$(ULONGTYPE - ISPOINTER)
id.specialformat = "?[,?]"
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_BLUE"
id.subfunc = 1
id.callname = "func__blue"
id.args = 2
id.arg = MKL$(ULONGTYPE - ISPOINTER) + MKL$(ULONGTYPE - ISPOINTER)
id.specialformat = "?[,?]"
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_ALPHA"
id.subfunc = 1
id.callname = "func__alpha"
id.args = 2
id.arg = MKL$(ULONGTYPE - ISPOINTER) + MKL$(ULONGTYPE - ISPOINTER)
id.specialformat = "?[,?]"
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_RGBA32"
id.subfunc = 1
id.callname = "func__rgba32"
id.args = 4
id.arg = MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
id.ret = ULONGTYPE - ISPOINTER
regid

clearid
id.n = "_RGB32"
id.subfunc = 1
id.callname = "func__rgb32"
id.overloaded = -1
id.minargs = 1
id.args = 4
id.arg = MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
id.ret = ULONGTYPE - ISPOINTER
regid

clearid
id.n = "_RED32"
id.subfunc = 1
id.callname = "func__red32"
id.args = 1
id.arg = MKL$(ULONGTYPE - ISPOINTER)
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_GREEN32"
id.subfunc = 1
id.callname = "func__green32"
id.args = 1
id.arg = MKL$(ULONGTYPE - ISPOINTER)
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_BLUE32"
id.subfunc = 1
id.callname = "func__blue32"
id.args = 1
id.arg = MKL$(ULONGTYPE - ISPOINTER)
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_ALPHA32"
id.subfunc = 1
id.callname = "func__alpha32"
id.args = 1
id.arg = MKL$(ULONGTYPE - ISPOINTER)
id.ret = LONGTYPE - ISPOINTER
regid


clearid
id.n = "DRAW"
id.subfunc = 2
id.callname = "sub_draw"
id.args = 1
id.arg = MKL$(STRINGTYPE - ISPOINTER)
regid

clearid
id.n = "PLAY": id.Dependency = DEPENDENCY_AUDIO_OUT
id.subfunc = 2
id.callname = "sub_play"
id.args = 1
id.arg = MKL$(STRINGTYPE - ISPOINTER)
regid

clearid
id.n = "PLAY": id.Dependency = DEPENDENCY_AUDIO_OUT
id.subfunc = 1
id.callname = "func_play"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.ret = LONGTYPE - ISPOINTER
regid

'QB64 MOUSE
clearid
id.n = "_MOUSESHOW"
id.subfunc = 2
id.callname = "sub__mouseshow"
id.args = 1
id.arg = MKL$(STRINGTYPE - ISPOINTER)
id.specialformat = "[?]"
regid

clearid
id.n = "_MOUSEHIDE"
id.subfunc = 2
id.callname = "sub__mousehide"
regid

clearid
id.n = "_MOUSEINPUT"
id.subfunc = 1
id.callname = "func__mouseinput"
id.ret = LONGTYPE - ISPOINTER
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "[?]"
regid

clearid
id.n = "_MOUSEX"
id.subfunc = 1
id.callname = "func__mousex"
id.ret = SINGLETYPE - ISPOINTER
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "[?]"
regid

clearid
id.n = "_MOUSEY"
id.subfunc = 1
id.callname = "func__mousey"
id.ret = SINGLETYPE - ISPOINTER
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "[?]"
regid

clearid
id.n = "_MOUSEMOVEMENTX"
id.subfunc = 1
id.callname = "func__mousemovementx"
id.ret = SINGLETYPE - ISPOINTER
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "[?]"
regid

clearid
id.n = "_MOUSEMOVEMENTY"
id.subfunc = 1
id.callname = "func__mousemovementy"
id.ret = SINGLETYPE - ISPOINTER
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "[?]"
regid

clearid
id.n = "_MOUSEBUTTON"
id.subfunc = 1
id.callname = "func__mousebutton"
id.args = 2
id.arg = MKL$(LONGTYPE - ISPOINTER)+MKL$(LONGTYPE - ISPOINTER)
id.ret = LONGTYPE - ISPOINTER
id.specialformat = "?[,?]"
regid

clearid
id.n = "_MOUSEWHEEL"
id.subfunc = 1
id.callname = "func__mousewheel"
id.ret = LONGTYPE - ISPOINTER
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "[?]"
regid


clearid
id.n = "_MOUSEPIPEOPEN"
id.subfunc = 1
id.callname = "func__mousepipeopen"
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_MOUSEINPUTPIPE"
id.subfunc = 2
id.callname = "sub__mouseinputpipe"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
regid

clearid
id.n = "_MOUSEPIPECLOSE"
id.subfunc = 2
id.callname = "sub__mousepipeclose"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
regid

clearid
id.n = "FREEFILE"
id.subfunc = 1
id.callname = "func_freefile"
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "NAME"
id.subfunc = 2
id.callname = "sub_name"
id.args = 2
id.arg = MKL$(STRINGTYPE - ISPOINTER) + MKL$(STRINGTYPE - ISPOINTER)
id.specialformat = "?{AS}?"
regid

clearid
id.n = "KILL"
id.subfunc = 2
id.callname = "sub_kill"
id.args = 1
id.arg = MKL$(STRINGTYPE - ISPOINTER)
regid

clearid
id.n = "CHDIR"
id.subfunc = 2
id.callname = "sub_chdir"
id.args = 1
id.arg = MKL$(STRINGTYPE - ISPOINTER)
regid

clearid
id.n = "MKDIR"
id.subfunc = 2
id.callname = "sub_mkdir"
id.args = 1
id.arg = MKL$(STRINGTYPE - ISPOINTER)
regid

clearid
id.n = "RMDIR"
id.subfunc = 2
id.callname = "sub_rmdir"
id.args = 1
id.arg = MKL$(STRINGTYPE - ISPOINTER)
regid

clearid
id.n = "CHAIN"
id.subfunc = 2
id.callname = "sub_chain"
id.args = 1
id.arg = MKL$(STRINGTYPE - ISPOINTER)
regid

clearid
id.n = "SHELL"
id.subfunc = 2
id.callname = "sub_shell"
id.args = 1
id.arg = MKL$(STRINGTYPE - ISPOINTER)
id.specialformat = "[?]"
'id.secondargcantbe = "_HIDE"
regid

clearid
id.n = "SHELL"
id.subfunc = 2
id.callname = "sub_shell2"
id.args = 1
id.arg = MKL$(STRINGTYPE - ISPOINTER)
id.specialformat = "{_HIDE}[{_DONTWAIT}][?]"
id.secondargmustbe = "_HIDE"
regid

clearid
id.n = "SHELL"
id.subfunc = 2
id.callname = "sub_shell3"
id.args = 1
id.arg = MKL$(STRINGTYPE - ISPOINTER)
id.specialformat = "{_DONTWAIT}[{_HIDE}][?]"
id.secondargmustbe = "_DONTWAIT"
regid

clearid
id.n = "SHELL"
id.subfunc = 1
id.callname = "func_shell"
id.args = 1
id.arg = MKL$(STRINGTYPE - ISPOINTER)
id.ret = INTEGER64TYPE - ISPOINTER
regid

clearid
id.n = "_SHELLHIDE"
id.subfunc = 1
id.callname = "func__shellhide"
id.args = 1
id.arg = MKL$(STRINGTYPE - ISPOINTER)
id.ret = INTEGER64TYPE - ISPOINTER
regid

clearid
id.n = "COMMAND"
id.musthave = "$"
id.subfunc = 1
id.callname = "func_command"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.ret = STRINGTYPE - ISPOINTER
id.specialformat = "[?]"
regid

clearid
id.n = "_COMMANDCOUNT"
id.subfunc = 1
id.callname = "func__commandcount"
id.ret = LONGTYPE - ISPOINTER
regid


'QB64 AUDIO

clearid
id.n = "_SNDRATE": id.Dependency = DEPENDENCY_AUDIO_OUT
id.subfunc = 1
id.callname = "func__sndrate"
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_SNDRAW": id.Dependency = DEPENDENCY_AUDIO_OUT
id.subfunc = 2
id.callname = "sub__sndraw"
id.args = 3
id.arg = MKL$(SINGLETYPE - ISPOINTER) + MKL$(SINGLETYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "?[,[?][,?]]"
regid

clearid
id.n = "_SNDRAWDONE": id.Dependency = DEPENDENCY_AUDIO_OUT
id.subfunc = 2
id.callname = "sub__sndrawdone"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "[?]"
regid

clearid
id.n = "_SNDOPENRAW": id.Dependency = DEPENDENCY_AUDIO_OUT
id.subfunc = 1
id.callname = "func__sndopenraw"
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_SNDRAWLEN": id.Dependency = DEPENDENCY_AUDIO_OUT
id.subfunc = 1
id.callname = "func__sndrawlen"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "[?]"
id.ret = DOUBLETYPE - ISPOINTER
regid

clearid
id.n = "_SNDLEN": id.Dependency = DEPENDENCY_AUDIO_OUT
id.subfunc = 1
id.callname = "func__sndlen"
id.args = 1
id.arg = MKL$(ULONGTYPE - ISPOINTER)
id.ret = SINGLETYPE - ISPOINTER
regid

clearid
id.n = "_SNDPAUSED": id.Dependency = DEPENDENCY_AUDIO_OUT
id.subfunc = 1
id.callname = "func__sndpaused"
id.args = 1
id.arg = MKL$(ULONGTYPE - ISPOINTER)
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_SNDPLAYFILE": id.Dependency = DEPENDENCY_AUDIO_DECODE
id.subfunc = 2
id.callname = "sub__sndplayfile"
id.args = 3
id.arg = MKL$(STRINGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER) + MKL$(FLOATTYPE - ISPOINTER)
id.specialformat = "?[,[?][,?]]"
regid

clearid
id.n = "_SNDPLAYCOPY": id.Dependency = DEPENDENCY_AUDIO_OUT
id.subfunc = 2
id.callname = "sub__sndplaycopy"
id.args = 2
id.arg = MKL$(ULONGTYPE - ISPOINTER) + MKL$(FLOATTYPE - ISPOINTER)
id.specialformat = "?[,?]"
regid

clearid
id.n = "_SNDSTOP": id.Dependency = DEPENDENCY_AUDIO_OUT
id.subfunc = 2
id.callname = "sub__sndstop"
id.args = 1
id.arg = MKL$(ULONGTYPE - ISPOINTER)
regid

clearid
id.n = "_SNDLOOP": id.Dependency = DEPENDENCY_AUDIO_OUT
id.subfunc = 2
id.callname = "sub__sndloop"
id.args = 1
id.arg = MKL$(ULONGTYPE - ISPOINTER)
regid

clearid
id.n = "_SNDLIMIT": id.Dependency = DEPENDENCY_AUDIO_OUT
id.subfunc = 2
id.callname = "sub__sndlimit"
id.args = 2
id.arg = MKL$(ULONGTYPE - ISPOINTER) + MKL$(FLOATTYPE - ISPOINTER)
regid

clearid
id.n = "_SNDOPEN": id.Dependency = DEPENDENCY_AUDIO_DECODE
id.subfunc = 1
id.callname = "func__sndopen"
id.args = 2
id.arg = MKL$(STRINGTYPE - ISPOINTER) + MKL$(STRINGTYPE - ISPOINTER)
id.specialformat = "?[,?]"
id.ret = ULONGTYPE - ISPOINTER
regid

clearid
id.n = "_SNDSETPOS": id.Dependency = DEPENDENCY_AUDIO_OUT
id.subfunc = 2
id.callname = "sub__sndsetpos"
id.args = 2
id.arg = MKL$(ULONGTYPE - ISPOINTER) + MKL$(DOUBLETYPE - ISPOINTER)
regid

clearid
id.n = "_SNDGETPOS": id.Dependency = DEPENDENCY_AUDIO_OUT
id.subfunc = 1
id.callname = "func__sndgetpos"
id.args = 1
id.arg = MKL$(ULONGTYPE - ISPOINTER)
id.ret = SINGLETYPE - ISPOINTER
regid

clearid
id.n = "_SNDPLAYING": id.Dependency = DEPENDENCY_AUDIO_OUT
id.subfunc = 1
id.callname = "func__sndplaying"
id.args = 1
id.arg = MKL$(ULONGTYPE - ISPOINTER)
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_SNDPAUSE": id.Dependency = DEPENDENCY_AUDIO_OUT
id.subfunc = 2
id.callname = "sub__sndpause"
id.args = 1
id.arg = MKL$(ULONGTYPE - ISPOINTER)
regid

clearid
id.n = "_SNDBAL": id.Dependency = DEPENDENCY_AUDIO_OUT
id.subfunc = 2
id.callname = "sub__sndbal"
id.args = 5
id.arg = MKL$(ULONGTYPE - ISPOINTER) + MKL$(FLOATTYPE - ISPOINTER) + MKL$(FLOATTYPE - ISPOINTER) + MKL$(FLOATTYPE - ISPOINTER) + MKL$(ULONGTYPE - ISPOINTER)
id.specialformat = "?,[?][,[?][,[?][,[?]]]]"
regid


clearid
id.n = "_SNDVOL": id.Dependency = DEPENDENCY_AUDIO_OUT
id.subfunc = 2
id.callname = "sub__sndvol"
id.args = 2
id.arg = MKL$(ULONGTYPE - ISPOINTER) + MKL$(FLOATTYPE - ISPOINTER)
regid

clearid
id.n = "_SNDPLAY": id.Dependency = DEPENDENCY_AUDIO_OUT
id.subfunc = 2
id.callname = "sub__sndplay"
id.args = 1
id.arg = MKL$(ULONGTYPE - ISPOINTER)
regid

clearid
id.n = "_SNDCOPY": id.Dependency = DEPENDENCY_AUDIO_OUT
id.subfunc = 1
id.callname = "func__sndcopy"
id.args = 1
id.arg = MKL$(ULONGTYPE - ISPOINTER)
id.ret = ULONGTYPE - ISPOINTER
regid

clearid
id.n = "_SNDCLOSE": id.Dependency = DEPENDENCY_AUDIO_OUT
id.subfunc = 2
id.callname = "sub__sndclose"
id.args = 1
id.arg = MKL$(ULONGTYPE - ISPOINTER)
regid

clearid
id.n = "INPUT"
id.musthave = "$"
id.subfunc = 1
id.callname = "func_input"
id.args = 2
id.arg = MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "?[,?]"
id.ret = STRINGTYPE - ISPOINTER
regid

clearid
id.n = "SEEK"
id.subfunc = 2
id.callname = "sub_seek"
id.args = 2
id.arg = MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "[#]?,?"
regid

clearid
id.n = "SEEK"
id.subfunc = 1
id.callname = "func_seek"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "LOC"
id.subfunc = 1
id.callname = "func_loc"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "EOF"
id.subfunc = 1
id.callname = "func_eof"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "LOF"
id.subfunc = 1
id.callname = "func_lof"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.ret = LONGTYPE - ISPOINTER
regid


clearid
id.n = "SCREEN"
id.subfunc = 1
id.callname = "func_screen"
id.args = 3
id.arg = MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "?,?[,?]"
id.ret = ULONGTYPE - ISPOINTER
regid

clearid
id.n = "PMAP"
id.subfunc = 1
id.callname = "func_pmap"
id.args = 2
id.arg = MKL$(SINGLETYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
id.ret = SINGLETYPE - ISPOINTER
regid


clearid
id.n = "POINT"
id.subfunc = 1
id.callname = "func_point"
id.args = 2
id.arg = MKL$(SINGLETYPE - ISPOINTER) + MKL$(SINGLETYPE - ISPOINTER)
id.specialformat = "?[,?]"
id.ret = DOUBLETYPE - ISPOINTER
regid


clearid
id.n = "TAB"
id.subfunc = 1
id.callname = "func_tab"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.ret = STRINGTYPE - ISPOINTER
regid

clearid
id.n = "SPC"
id.subfunc = 1
id.callname = "func_spc"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.ret = STRINGTYPE - ISPOINTER
regid


clearid
id.n = "WAIT"
id.subfunc = 2
id.callname = "sub_wait"
id.args = 3
id.arg = MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "?,?[,?]"
regid

clearid
id.n = "INP"
id.subfunc = 1
id.callname = "func_inp"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "POS"
id.subfunc = 1
id.callname = "func_pos"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "SGN"
id.subfunc = 1
id.callname = "func_sgn"
id.args = 1
id.arg = MKL$(-1)
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "LBOUND"
id.subfunc = 1
id.args = 2
id.arg = MKL$(-1) + MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "?,[?]"
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "UBOUND"
id.subfunc = 1
id.args = 2
id.arg = MKL$(-1) + MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "?,[?]"
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "OCT"
id.musthave = "$"
id.subfunc = 1
id.args = 1
id.arg = MKL$(-1)
id.ret = STRINGTYPE - ISPOINTER
regid

clearid
id.n = "HEX"
id.musthave = "$"
id.subfunc = 1
id.args = 1
id.arg = MKL$(-1)
id.ret = STRINGTYPE - ISPOINTER
regid

clearid
id.n = "SLEEP"
id.subfunc = 2
id.callname = "sub_sleep"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "[?]"
regid

clearid
id.n = "EXP"
id.subfunc = 1
id.args = 1
id.arg = MKL$(-1)
id.ret = -1
regid

clearid
id.n = "FIX"
id.subfunc = 1
id.args = 1
id.arg = MKL$(-1)
id.ret = -1
regid

clearid
id.n = "INT"
id.subfunc = 1
id.args = 1
id.arg = MKL$(-1)
id.ret = -1
regid

clearid
id.n = "CDBL"
id.subfunc = 1
id.args = 1
id.arg = MKL$(-1)
id.ret = DOUBLETYPE - ISPOINTER
regid

clearid
id.n = "CSNG"
id.subfunc = 1
id.args = 1
id.arg = MKL$(-1)
id.ret = SINGLETYPE - ISPOINTER
regid

clearid
id.n = "_ROUND"
id.subfunc = 1
id.args = 1
id.arg = MKL$(-1)
id.ret = INTEGER64TYPE - ISPOINTER
regid

clearid
id.n = "CINT"
id.subfunc = 1
id.args = 1
id.arg = MKL$(-1)
id.ret = INTEGERTYPE - ISPOINTER
regid

clearid
id.n = "CLNG"
id.subfunc = 1
id.args = 1
id.arg = MKL$(-1)
id.ret = INTEGERTYPE - ISPOINTER
regid



clearid
id.n = "TIME"
id.musthave = "$"
id.subfunc = 2
id.callname = "sub_time"
id.args = 1
id.arg = MKL$(STRINGTYPE - ISPOINTER)
id.specialformat = "=?"
regid

clearid
id.n = "TIME"
id.musthave = "$"
id.subfunc = 1
id.callname = "func_time"
id.ret = STRINGTYPE - ISPOINTER
regid



clearid
id.n = "DATE"
id.musthave = "$"
id.subfunc = 2
id.callname = "sub_date"
id.args = 1
id.arg = MKL$(STRINGTYPE - ISPOINTER)
id.specialformat = "=?"
regid

clearid
id.n = "DATE"
id.musthave = "$"
id.subfunc = 1
id.callname = "func_date"
id.ret = STRINGTYPE - ISPOINTER
regid

clearid
id.n = "CSRLIN"
id.subfunc = 1
id.callname = "func_csrlin"
id.ret = LONGTYPE - ISPOINTER
regid


clearid
id.n = "PAINT"
id.subfunc = 2
id.callname = "sub_paint"
id.args = 5
id.arg = MKL$(FLOATTYPE - ISPOINTER) + MKL$(FLOATTYPE - ISPOINTER) + MKL$(ULONGTYPE - ISPOINTER) + MKL$(ULONGTYPE - ISPOINTER) + MKL$(STRINGTYPE - ISPOINTER)
id.specialformat = "[{STEP}](?,?)[,[?][,[?][,?]]]"
'PAINT [STEP] (x!,y!)[,[paint] [,[bordercolor&] [,background$]]]
regid

clearid
id.n = "CIRCLE"
id.subfunc = 2
id.callname = "sub_circle"
id.args = 7
id.arg = MKL$(FLOATTYPE - ISPOINTER) + MKL$(FLOATTYPE - ISPOINTER) + MKL$(FLOATTYPE - ISPOINTER) + MKL$(ULONGTYPE - ISPOINTER) + MKL$(FLOATTYPE - ISPOINTER) + MKL$(FLOATTYPE - ISPOINTER) + MKL$(FLOATTYPE - ISPOINTER)
id.specialformat = "[{STEP}](?,?),?[,[?][,[?][,[?][,?]]]]"
'CIRCLE [STEP] (x!,y!),radius![,[color&] [,[start!] [,[end!] [,aspect!]]]]
regid

clearid
id.n = "BLOAD"
id.subfunc = 2
id.callname = "sub_bload"
id.args = 2
id.arg = MKL$(STRINGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "?[,?]"
regid

clearid
id.n = "BSAVE"
id.subfunc = 2
id.callname = "sub_bsave"
id.args = 3
id.arg = MKL$(STRINGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
regid

clearid
id.n = "GET"
id.subfunc = 2
id.callname = "sub_get"
id.args = 3
id.arg = MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER) + MKL$(-4)
'id.specialformat = "[#]?,[?],?" 'non field complient definition
id.specialformat = "[#]?[,[?][,?]]" 'field complient definition
regid

clearid
id.n = "PUT"
id.subfunc = 2
id.callname = "sub_put"
id.args = 3
id.arg = MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER) + MKL$(-4)
'id.specialformat = "[#]?,[?],?" 'non field complient definition
id.specialformat = "[#]?[,[?][,?]]" 'field complient definition
regid

'double definition
clearid
id.n = "GET"
id.subfunc = 2
id.callname = "sub_graphics_get"
id.args = 6
id.arg = MKL$(FLOATTYPE - ISPOINTER) + MKL$(FLOATTYPE - ISPOINTER) + MKL$(FLOATTYPE - ISPOINTER) + MKL$(FLOATTYPE - ISPOINTER) + MKL$(-3) + MKL$(ULONGTYPE - ISPOINTER)
id.specialformat = "[{STEP}](?,?)-[{STEP}](?,?),?[,?]"
id.secondargmustbe = "STEP"
regid

clearid
id.n = "GET"
id.subfunc = 2
id.callname = "sub_graphics_get"
id.args = 6
id.arg = MKL$(FLOATTYPE - ISPOINTER) + MKL$(FLOATTYPE - ISPOINTER) + MKL$(FLOATTYPE - ISPOINTER) + MKL$(FLOATTYPE - ISPOINTER) + MKL$(-3) + MKL$(ULONGTYPE - ISPOINTER)
id.specialformat = "[{STEP}](?,?)-[{STEP}](?,?),?[,?]"
id.secondargmustbe = "("
regid

'double definition
clearid
id.n = "PUT"
id.subfunc = 2
id.callname = "sub_graphics_put"
id.args = 5
id.arg = MKL$(FLOATTYPE - ISPOINTER) + MKL$(FLOATTYPE - ISPOINTER) + MKL$(-3) + MKL$(LONGTYPE - ISPOINTER) + MKL$(ULONGTYPE - ISPOINTER)
id.specialformat = "[{STEP}](?,?),?[,[{_CLIP}][{PSET|PRESET|AND|OR|XOR}][,?]]"
'PUT [STEP] (x!,y!),arrayname# [(indexes%)] [,actionverb]
'PUT (10, 10), myimage, _CLIP, 0
id.secondargmustbe = "STEP"
regid
clearid
id.n = "PUT"
id.subfunc = 2
id.callname = "sub_graphics_put"
id.args = 5
id.arg = MKL$(FLOATTYPE - ISPOINTER) + MKL$(FLOATTYPE - ISPOINTER) + MKL$(-3) + MKL$(LONGTYPE - ISPOINTER) + MKL$(ULONGTYPE - ISPOINTER)
id.specialformat = "[{STEP}](?,?),?[,[{_CLIP}][{PSET|PRESET|AND|OR|XOR}][,?]]"
'PUT [STEP] (x!,y!),arrayname# [(indexes%)] [,actionverb]
'PUT (10, 10), myimage, _CLIP, 0
id.secondargmustbe = "("
regid

clearid
id.n = "OPEN"
id.subfunc = 2
id.callname = "sub_open_gwbasic"
id.args = 4
id.arg = MKL$(STRINGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER) + MKL$(STRINGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "?,[#]?,?[,?]"
regid
clearid
id.n = "OPEN"
id.subfunc = 2
id.callname = "sub_open"
id.args = 6
id.arg = MKL$(STRINGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "?[{FOR RANDOM|FOR BINARY|FOR INPUT|FOR OUTPUT|FOR APPEND}][{ACCESS READ WRITE|ACCESS READ|ACCESS WRITE}][{SHARED|LOCK READ WRITE|LOCK READ|LOCK WRITE}]{AS}[#]?[{LEN =}?]"
regid

clearid
id.n = "VAL"
id.subfunc = 1
id.callname = "func_val"
id.args = 1
id.arg = MKL$(STRINGTYPE - ISPOINTER)
id.ret = FLOATTYPE - ISPOINTER
regid

clearid
id.n = "MKSMBF"
id.musthave = "$"
id.subfunc = 1
id.callname = "func_mksmbf"
id.args = 1
id.arg = MKL$(SINGLETYPE - ISPOINTER)
id.ret = STRINGTYPE - ISPOINTER
regid
clearid
id.n = "MKDMBF"
id.musthave = "$"
id.subfunc = 1
id.callname = "func_mkdmbf"
id.args = 1
id.arg = MKL$(DOUBLETYPE - ISPOINTER)
id.ret = STRINGTYPE - ISPOINTER
regid

clearid
id.n = "MKI"
id.musthave = "$"
id.subfunc = 1
id.callname = ""
id.args = 1
id.arg = MKL$(INTEGERTYPE - ISPOINTER)
id.ret = STRINGTYPE - ISPOINTER
regid
clearid
id.n = "MKL"
id.musthave = "$"
id.subfunc = 1
id.callname = ""
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.ret = STRINGTYPE - ISPOINTER
regid
clearid
id.n = "MKS"
id.musthave = "$"
id.subfunc = 1
id.callname = ""
id.args = 1
id.arg = MKL$(SINGLETYPE - ISPOINTER)
id.ret = STRINGTYPE - ISPOINTER
regid
clearid
id.n = "MKD"
id.musthave = "$"
id.subfunc = 1
id.callname = ""
id.args = 1
id.arg = MKL$(DOUBLETYPE - ISPOINTER)
id.ret = STRINGTYPE - ISPOINTER
regid
clearid
id.n = "_MK"
id.musthave = "$"
id.subfunc = 1
id.callname = ""
id.args = 2
id.arg = MKL$(-1) + MKL$(-1)
id.ret = STRINGTYPE - ISPOINTER
regid

clearid
id.n = "CVSMBF"
id.subfunc = 1
id.callname = "func_cvsmbf"
id.args = 1
id.arg = MKL$(STRINGTYPE - ISPOINTER)
id.ret = SINGLETYPE - ISPOINTER
regid
clearid
id.n = "CVDMBF"
id.subfunc = 1
id.callname = "func_cvdmbf"
id.args = 1
id.arg = MKL$(STRINGTYPE - ISPOINTER)
id.ret = DOUBLETYPE - ISPOINTER
regid

clearid
id.n = "CVI"
id.subfunc = 1
id.callname = ""
id.args = 1
id.arg = MKL$(STRINGTYPE - ISPOINTER)
id.ret = INTEGERTYPE - ISPOINTER
regid
clearid
id.n = "CVL"
id.subfunc = 1
id.callname = ""
id.args = 1
id.arg = MKL$(STRINGTYPE - ISPOINTER)
id.ret = LONGTYPE - ISPOINTER
regid
clearid
id.n = "CVS"
id.subfunc = 1
id.callname = ""
id.args = 1
id.arg = MKL$(STRINGTYPE - ISPOINTER)
id.ret = SINGLETYPE - ISPOINTER
regid
clearid
id.n = "CVD"
id.subfunc = 1
id.callname = ""
id.args = 1
id.arg = MKL$(STRINGTYPE - ISPOINTER)
id.ret = DOUBLETYPE - ISPOINTER
regid
clearid
id.n = "_CV"
id.subfunc = 1
id.callname = ""
id.args = 2
id.arg = MKL$(-1) + MKL$(STRINGTYPE - ISPOINTER)
id.ret = -1
regid

clearid
id.n = "STRING"
id.musthave = "$"
id.subfunc = 1
id.callname = "func_string"
id.args = 2
id.arg = MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
id.ret = STRINGTYPE - ISPOINTER
regid

clearid
id.n = "SPACE"
id.musthave = "$"
id.subfunc = 1
id.callname = "func_space"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.ret = STRINGTYPE - ISPOINTER
regid

clearid
id.n = "INSTR"
id.subfunc = 1
id.callname = "func_instr"
id.args = 3
id.arg = MKL$(LONGTYPE - ISPOINTER) + MKL$(STRINGTYPE - ISPOINTER) + MKL$(STRINGTYPE - ISPOINTER)
id.ret = LONGTYPE - ISPOINTER
id.specialformat = "[?],?,?" 'checked!
regid

clearid
id.n = "_INSTRREV"
id.subfunc = 1
id.callname = "func__instrrev"
id.args = 3
id.arg = MKL$(LONGTYPE - ISPOINTER) + MKL$(STRINGTYPE - ISPOINTER) + MKL$(STRINGTYPE - ISPOINTER)
id.ret = LONGTYPE - ISPOINTER
id.specialformat = "[?],?,?" 'checked!
regid

clearid
id.n = "MID"
id.musthave = "$"
id.subfunc = 1
id.callname = "func_mid"
id.args = 3
id.arg = MKL$(STRINGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
id.ret = STRINGTYPE - ISPOINTER
id.specialformat = "?,?,[?]" 'checked!
regid

clearid
id.n = "SADD"
id.subfunc = 1
id.callname = ""
id.args = 1
id.arg = MKL$(-1) '!this value is ignored, the qb64 compiler handles this function
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "CLS"
id.subfunc = 2
id.callname = "sub_cls"
id.args = 2
id.arg = MKL$(LONGTYPE - ISPOINTER) + MKL$(ULONGTYPE - ISPOINTER)
id.specialformat = "[?][,?]"
regid

clearid
id.n = "SQR"
id.subfunc = 1
id.callname = "func_sqr"
id.args = 1
id.arg = MKL$(FLOATTYPE - ISPOINTER)
id.ret = FLOATTYPE - ISPOINTER
regid

clearid
id.n = "CHR"
id.musthave = "$"
id.subfunc = 1
id.callname = "func_chr"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.ret = STRINGTYPE - ISPOINTER
regid

clearid
id.n = "VARPTR"
id.subfunc = 1
id.callname = ""
id.args = 1
id.arg = MKL$(-1) '!this value is ignored, the qb64 compiler handles this function
id.ret = STRINGTYPE - ISPOINTER
id.musthave = "$"
regid

clearid
id.n = "VARPTR"
id.subfunc = 1
id.callname = ""
id.args = 1
id.arg = MKL$(-1) '!this value is ignored, the qb64 compiler handles this function
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_OFFSET"
id.subfunc = 1
id.callname = ""
id.args = 1
id.arg = MKL$(-1) '!this value is ignored, the qb64 compiler handles this function
id.ret = UOFFSETTYPE - ISPOINTER
regid

clearid
id.n = "VARSEG"
id.subfunc = 1
id.callname = ""
id.args = 1
id.arg = MKL$(-1) '!this value is ignored, the qb64 compiler handles this function
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "POKE"
id.subfunc = 2
id.callname = "sub_poke"
id.args = 2
id.arg = MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
regid

clearid
id.n = "PEEK"
id.subfunc = 1
id.callname = "func_peek"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "DEF"
id.subfunc = 2
id.callname = "sub_defseg"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "{SEG}[=?]" 'checked!
id.secondargmustbe = "SEG"
regid

clearid
id.n = "SIN"
id.subfunc = 1
id.callname = "sin"
id.args = 1
id.arg = MKL$(FLOATTYPE - ISPOINTER)
id.ret = FLOATTYPE - ISPOINTER
regid

clearid
id.n = "COS"
id.subfunc = 1
id.callname = "cos"
id.args = 1
id.arg = MKL$(FLOATTYPE - ISPOINTER)
id.ret = FLOATTYPE - ISPOINTER
regid

clearid
id.n = "TAN"
id.subfunc = 1
id.callname = "tan"
id.args = 1
id.arg = MKL$(FLOATTYPE - ISPOINTER)
id.ret = FLOATTYPE - ISPOINTER
regid

clearid
id.n = "ATN"
id.subfunc = 1
id.callname = "atan"
id.args = 1
id.arg = MKL$(FLOATTYPE - ISPOINTER)
id.ret = FLOATTYPE - ISPOINTER
regid

clearid
id.n = "LOG"
id.subfunc = 1
id.callname = "func_log"
id.args = 1
id.arg = MKL$(FLOATTYPE - ISPOINTER)
id.ret = FLOATTYPE - ISPOINTER
regid

clearid
id.n = "ABS"
id.subfunc = 1
id.callname = "func_abs"
id.args = 1
id.arg = MKL$(-1) 'takes anything numerical
id.ret = FLOATTYPE - ISPOINTER '***overridden by function evaluatefunc***
regid

clearid
id.n = "ERL"
id.subfunc = 1
id.callname = "get_error_erl"
id.args = 0
id.ret = DOUBLETYPE - ISPOINTER
regid

clearid
id.n = "ERR"
id.subfunc = 1
id.callname = "get_error_err"
id.args = 0
id.ret = ULONGTYPE - ISPOINTER
regid

clearid
id.n = "ERROR"
id.subfunc = 2
id.callname = "error"
id.args = 1
id.arg = MKL$(ULONGTYPE - ISPOINTER)
regid

clearid
id.n = "LINE"
id.subfunc = 2
id.callname = "sub_line"
id.args = 7
id.arg = MKL$(FLOATTYPE - ISPOINTER) + MKL$(FLOATTYPE - ISPOINTER) + MKL$(FLOATTYPE - ISPOINTER) + MKL$(FLOATTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "[[{STEP}](?,?)]-[{STEP}](?,?)[,[?][,[{B|BF}][,?]]]"
regid

clearid
id.n = "SOUND": id.Dependency = DEPENDENCY_AUDIO_OUT
id.subfunc = 2
id.callname = "sub_sound"
id.args = 2
id.arg = MKL$(DOUBLETYPE - ISPOINTER) + MKL$(DOUBLETYPE - ISPOINTER)
regid

clearid
id.n = "BEEP": id.Dependency = DEPENDENCY_AUDIO_OUT
id.subfunc = 2
id.callname = "sub_beep"
id.args = 0
regid

clearid
id.n = "TIMER"
id.subfunc = 1
id.callname = "func_timer"
id.args = 1
id.arg = MKL$(DOUBLETYPE - ISPOINTER)
id.ret = SINGLETYPE - ISPOINTER
id.specialformat = "[?]"
regid

clearid
id.n = "RND"
id.subfunc = 1
id.callname = "func_rnd"
id.args = 1
id.arg = MKL$(FLOATTYPE - ISPOINTER)
id.ret = SINGLETYPE - ISPOINTER
id.specialformat = "[?]" 'checked!
regid

clearid
id.n = "RANDOMIZE"
id.subfunc = 2
id.callname = "sub_randomize"
id.args = 1
id.arg = MKL$(DOUBLETYPE - ISPOINTER)
id.specialformat = "[[{USING}]?]" 'checked!
regid

clearid
id.n = "OUT"
id.subfunc = 2
id.callname = "sub_out"
id.args = 2
id.arg = MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
regid

clearid
id.n = "PCOPY"
id.subfunc = 2
id.callname = "sub_pcopy"
id.args = 2
id.arg = MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
regid

clearid
id.n = "VIEW"
id.subfunc = 2
id.callname = "qbg_sub_view"
id.args = 6
id.arg = MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "[[{SCREEN}](?,?)-(?,?)[,[?][,?]]]"
id.secondargcantbe = "PRINT"
regid

clearid
id.n = "VIEW"
id.subfunc = 2
id.callname = "qbg_sub_view_print"
id.args = 2
id.arg = MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "{PRINT}[?{TO}?]" 'new!
id.secondargmustbe = "PRINT"
regid

clearid
id.n = "WINDOW"
id.subfunc = 2
id.callname = "qbg_sub_window"
id.args = 4
id.arg = MKL$(FLOATTYPE - ISPOINTER) + MKL$(FLOATTYPE - ISPOINTER) + MKL$(FLOATTYPE - ISPOINTER) + MKL$(FLOATTYPE - ISPOINTER)
id.specialformat = "[[{SCREEN}](?,?)-(?,?)]"
regid

clearid
id.n = "LOCATE"
id.subfunc = 2
id.callname = "qbg_sub_locate"
id.args = 5
id.arg = MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "[?][,[?][,[?][,[?][,?]]]]"
regid

clearid
id.n = "COLOR"
id.subfunc = 2
id.callname = "qbg_sub_color"
id.args = 3
id.arg = MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "[?][,[?][,?]]"
regid

clearid
id.n = "PALETTE"
id.subfunc = 2
id.callname = "qbg_palette"
id.args = 2
id.arg = MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "[?,?]"
regid

clearid
id.n = "WIDTH"
id.subfunc = 2
id.callname = "qbsub_width"
id.args = 5
id.arg = MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "[{#|LPRINT}][?][,[?][,[?][,[?]]]]" 'new!
'id.specialformat = "[{#|LPRINT}][?][,?]" 'new!
regid


clearid
id.n = "SCREEN"
id.subfunc = 2
id.callname = "qbg_screen"
id.args = 5
id.arg = MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
'id.specialformat = "[?][,[?][,[?][,?]]]" 'new!
'id.specialformat = "[?][,[?][,[?][,[?][,{_MANUALDISPLAY}]]]]" 'breaks compilation!
'id.specialformat = "[?][,[?][,[?][,[?][,[{_MANUALDISPLAY}]]]]]" <-pre-bulletproofing
id.specialformat = "[?][,[?][,[?][,[?][,[{_MANUALDISPLAY}?]]]]]" 'a temp format for transition reasons"
regid

clearid
id.n = "PSET"
id.subfunc = 2
id.callname = "sub_pset"
id.args = 3
id.arg = MKL$(FLOATTYPE - ISPOINTER) + MKL$(FLOATTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "[{STEP}](?,?)[,?]"
regid

clearid
id.n = "PRESET"
id.subfunc = 2
id.callname = "sub_preset"
id.args = 3
id.arg = MKL$(FLOATTYPE - ISPOINTER) + MKL$(FLOATTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "[{STEP}](?,?)[,?]"
regid

clearid
id.n = "ASC"
id.subfunc = 1
id.callname = "qbs_asc"
id.args = 1
id.arg = MKL$(STRINGTYPE - ISPOINTER)
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "LEN"
id.subfunc = 1
id.callname = "" 'callname is not used
id.args = 1
id.arg = MKL$(STRINGTYPE - ISPOINTER) 'note: LEN is a special case, any input is actually accepted
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "INKEY"
id.musthave = "$"
id.subfunc = 1
id.callname = "qbs_inkey"
id.ret = STRINGTYPE - ISPOINTER
regid

clearid
id.n = "STR"
id.musthave = "$"
id.subfunc = 1
id.callname = "qbs_str"
id.args = 1
id.arg = MKL$(-1)
id.ret = STRINGTYPE - ISPOINTER
regid

clearid
id.n = "UCASE"
id.musthave = "$"
id.subfunc = 1
id.callname = "qbs_ucase"
id.args = 1
id.arg = MKL$(STRINGTYPE - ISPOINTER)
id.ret = STRINGTYPE - ISPOINTER
regid

clearid
id.n = "LCASE"
id.musthave = "$"
id.subfunc = 1
id.callname = "qbs_lcase"
id.args = 1
id.arg = MKL$(STRINGTYPE - ISPOINTER)
id.ret = STRINGTYPE - ISPOINTER
regid

clearid
id.n = "LEFT"
id.musthave = "$"
id.subfunc = 1
id.callname = "qbs_left"
id.args = 2
id.arg = MKL$(STRINGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
id.ret = STRINGTYPE - ISPOINTER
regid

clearid
id.n = "RIGHT"
id.musthave = "$"
id.subfunc = 1
id.callname = "qbs_right"
id.args = 2
id.arg = MKL$(STRINGTYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
id.ret = STRINGTYPE - ISPOINTER
regid

clearid
id.n = "LTRIM"
id.musthave = "$"
id.subfunc = 1
id.callname = "qbs_ltrim"
id.args = 1
id.arg = MKL$(STRINGTYPE - ISPOINTER)
id.ret = STRINGTYPE - ISPOINTER
regid

clearid
id.n = "RTRIM"
id.musthave = "$"
id.subfunc = 1
id.callname = "qbs_rtrim"
id.args = 1
id.arg = MKL$(STRINGTYPE - ISPOINTER)
id.ret = STRINGTYPE - ISPOINTER
regid

clearid
id.n = "_TRIM"
id.musthave = "$"
id.subfunc = 1
id.callname = "qbs__trim"
id.args = 1
id.arg = MKL$(STRINGTYPE - ISPOINTER)
id.ret = STRINGTYPE - ISPOINTER
regid

clearid
id.n = "PRINT"
id.subfunc = 2
id.callname = "qbs_print" 'not called directly
id.args = 1
id.arg = MKL$(STRINGTYPE - ISPOINTER)
regid

clearid
id.n = "LPRINT": id.Dependency = DEPENDENCY_PRINTER
id.subfunc = 2
id.callname = "qbs_lprint" 'not called directly
id.args = 1
id.arg = MKL$(STRINGTYPE - ISPOINTER)
regid

clearid
id.n = "LPOS": id.Dependency = DEPENDENCY_PRINTER
id.subfunc = 1
id.callname = "func_lpos"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.ret = LONGTYPE - ISPOINTER
regid

'Get Current Working Directory
clearid
id.n = "_CWD"
id.musthave = "$"
id.subfunc = 1
id.callname = "func__cwd"
id.ret = STRINGTYPE - ISPOINTER
regid

'Get the directory the program was started from (before the currenct directory is automatically changed to the executables directory)
clearid
id.n = "_STARTDIR"
id.musthave = "$"
id.subfunc = 1
id.callname = "func__startdir"
id.ret = STRINGTYPE - ISPOINTER
regid

'Return a path that best represents the context provided e.g. _DIR$("DESKTOP")
clearid
id.n = "_DIR"
id.musthave = "$"
id.subfunc = 1
id.callname = "func__dir"
id.args = 1
id.arg = MKL$(STRINGTYPE - ISPOINTER)
id.ret = STRINGTYPE - ISPOINTER
regid

'Return the name of the included file in which the last error occurred
clearid
id.n = "_INCLERRORFILE"
id.musthave = "$"
id.subfunc = 1
id.callname = "func__inclerrorfile"
id.ret = STRINGTYPE - ISPOINTER
regid

clearid
id.n = "_KEYCLEAR"
id.subfunc = 2
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "[?]"
id.callname = "sub__keyclear"
regid

clearid
id.n = "_D2R"
id.subfunc =  1
id.callname = "func_deg2rad"
id.args = 1
id.arg = MKL$(FLOATTYPE - ISPOINTER)
id.ret = FLOATTYPE - ISPOINTER
regid

clearid
id.n = "_D2G"
id.subfunc =  1
id.callname = "func_deg2grad"
id.args = 1
id.arg = MKL$(FLOATTYPE - ISPOINTER)
id.ret = FLOATTYPE - ISPOINTER
regid

clearid
id.n = "_R2D"
id.subfunc =  1
id.callname = "func_rad2deg"
id.args = 1
id.arg = MKL$(FLOATTYPE - ISPOINTER)
id.ret = FLOATTYPE - ISPOINTER
regid

clearid
id.n = "_R2G"
id.subfunc =  1
id.callname = "func_rad2grad"
id.args = 1
id.arg = MKL$(FLOATTYPE - ISPOINTER)
id.ret = FLOATTYPE - ISPOINTER
regid

clearid
id.n = "_G2D"
id.subfunc =  1
id.callname = "func_grad2deg"
id.args = 1
id.arg = MKL$(FLOATTYPE - ISPOINTER)
id.ret = FLOATTYPE - ISPOINTER
regid

clearid
id.n = "_G2R"
id.subfunc =  1
id.callname = "func_grad2rad"
id.args = 1
id.arg = MKL$(FLOATTYPE - ISPOINTER)
id.ret = FLOATTYPE - ISPOINTER
regid

clearid   'Clear the old id info so we set the slate for a new one
id.n = "_ATAN2" 'The name of our new one
id.subfunc = 1 'And this is a function
id.callname = "atan2" 'The C name of the function
id.args = 2 'It takes 2 parameters to work
id.arg = MKL$(FLOATTYPE - ISPOINTER) + MKL$(FLOATTYPE - ISPOINTER) 'These simply add up to represent the 2 patameters from what I can tell
id.ret = FLOATTYPE - ISPOINTER 'we want it to return to us a nice _FLOAT value
regid 'and we're finished with ID registration

clearid   'Clear the old id info so we set the slate for a new one
id.n = "_HYPOT" 'The name of our new one
id.subfunc = 1 'And this is a function
id.callname = "hypot" 'The C name of the function
id.args = 2 'It takes 2 parameters to work
id.arg = MKL$(FLOATTYPE - ISPOINTER) + MKL$(FLOATTYPE - ISPOINTER) 'These simply add up to represent the 2 patameters from what I can tell
id.ret = FLOATTYPE - ISPOINTER 'we want it to return to us a nice _FLOAT value
regid 'and we're finished with ID registration

clearid
id.n = "_ASIN"
id.subfunc =  1
id.callname = "asin"
id.args = 1
id.arg = MKL$(FLOATTYPE - ISPOINTER)
id.ret = FLOATTYPE - ISPOINTER
regid

clearid
id.n = "_ACOS"
id.subfunc =  1
id.callname = "acos"
id.args = 1
id.arg = MKL$(FLOATTYPE - ISPOINTER)
id.ret = FLOATTYPE - ISPOINTER
regid

clearid
id.n = "_SINH"
id.subfunc =  1
id.callname = "sinh"
id.args = 1
id.arg = MKL$(FLOATTYPE - ISPOINTER)
id.ret = FLOATTYPE - ISPOINTER
regid

clearid
id.n = "_COSH"
id.subfunc =  1
id.callname = "cosh"
id.args = 1
id.arg = MKL$(FLOATTYPE - ISPOINTER)
id.ret = FLOATTYPE - ISPOINTER
regid

clearid
id.n = "_TANH"
id.subfunc =  1
id.callname = "tanh"
id.args = 1
id.arg = MKL$(FLOATTYPE - ISPOINTER)
id.ret = FLOATTYPE - ISPOINTER
regid

clearid
id.n = "_ASINH"
id.subfunc =  1
id.callname = "asinh"
id.args = 1
id.arg = MKL$(FLOATTYPE - ISPOINTER)
id.ret = FLOATTYPE - ISPOINTER
regid

clearid
id.n = "_ACOSH"
id.subfunc =  1
id.callname = "acosh"
id.args = 1
id.arg = MKL$(FLOATTYPE - ISPOINTER)
id.ret = FLOATTYPE - ISPOINTER
regid

clearid
id.n = "_ATANH"
id.subfunc =  1
id.callname = "atanh"
id.args = 1
id.arg = MKL$(FLOATTYPE - ISPOINTER)
id.ret = FLOATTYPE - ISPOINTER
regid

clearid
id.n = "_CEIL"
id.subfunc =  1
id.callname = "ceil"
id.args = 1
id.arg = MKL$(FLOATTYPE - ISPOINTER)
id.ret = FLOATTYPE - ISPOINTER
regid

clearid
id.n = "_PI"
id.subfunc = 1
id.callname = "func_pi"
id.args = 1
id.arg = MKL$(DOUBLETYPE - ISPOINTER)
id.ret = DOUBLETYPE - ISPOINTER
id.specialformat = "[?]"
regid

clearid
id.n = "_DESKTOPHEIGHT"
id.subfunc = 1
id.callname = "func_screenheight"
id.args = 0
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_DESKTOPWIDTH"
id.subfunc = 1
id.callname = "func_screenwidth"
id.args = 0
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_SCREENICON"     'name change to from _ICONIFYWINDOW to _SCREENICON to match the screenshow and screenhide
id.subfunc = 2
id.callname = "sub_screenicon"
regid

clearid
id.n = "_SCREENEXISTS"
id.subfunc = 1
id.callname = "func_windowexists"
regid

clearid
id.n = "_CONTROLCHR"
id.subfunc = 1
id.callname = "func__controlchr"
id.args = 0
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_STRICMP"
id.subfunc = 1
id.callname = "func__str_nc_compare"
id.args = 2
id.arg = MKL$(STRINGTYPE - ISPOINTER) + MKL$(STRINGTYPE - ISPOINTER)
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_STRCMP"
id.subfunc = 1
id.callname = "func__str_compare"
id.args = 2
id.arg = MKL$(STRINGTYPE - ISPOINTER) + MKL$(STRINGTYPE - ISPOINTER)
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_ARCSEC"
id.subfunc =  1
id.callname = "func_arcsec"
id.args = 1
id.arg = MKL$(FLOATTYPE - ISPOINTER)
id.ret = FLOATTYPE - ISPOINTER
regid

clearid
id.n = "_ARCCSC"
id.subfunc =  1
id.callname = "func_arccsc"
id.args = 1
id.arg = MKL$(FLOATTYPE - ISPOINTER)
id.ret = FLOATTYPE - ISPOINTER
regid

clearid
id.n = "_ARCCOT"
id.subfunc =  1
id.callname = "func_arccot"
id.args = 1
id.arg = MKL$(FLOATTYPE - ISPOINTER)
id.ret = FLOATTYPE - ISPOINTER
regid

clearid
id.n = "_SECH"
id.subfunc =  1
id.callname = "func_sech"
id.args = 1
id.arg = MKL$(FLOATTYPE - ISPOINTER)
id.ret = FLOATTYPE - ISPOINTER
regid

clearid
id.n = "_CSCH"
id.subfunc =  1
id.callname = "func_csch"
id.args = 1
id.arg = MKL$(FLOATTYPE - ISPOINTER)
id.ret = FLOATTYPE - ISPOINTER
regid

clearid
id.n = "_COTH"
id.subfunc =  1
id.callname = "func_coth"
id.args = 1
id.arg = MKL$(FLOATTYPE - ISPOINTER)
id.ret = FLOATTYPE - ISPOINTER
regid

clearid
id.n = "_SEC"
id.subfunc =  1
id.callname = "func_sec"
id.args = 1
id.arg = MKL$(FLOATTYPE - ISPOINTER)
id.ret = FLOATTYPE - ISPOINTER
regid

clearid
id.n = "_CSC"
id.subfunc =  1
id.callname = "func_csc"
id.args = 1
id.arg = MKL$(FLOATTYPE - ISPOINTER)
id.ret = FLOATTYPE - ISPOINTER
regid

clearid
id.n = "_COT"
id.subfunc =  1
id.callname = "func_cot"
id.args = 1
id.arg = MKL$(FLOATTYPE - ISPOINTER)
id.ret = FLOATTYPE - ISPOINTER
regid

clearid
id.n = "_SCREENICON"
id.subfunc =  1
id.callname = "func_screenicon"
id.args = 0
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_AUTODISPLAY"
id.subfunc = 1
id.callname = "func__autodisplay"
id.args = 0
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_SHR"
id.subfunc = 1
id.callname = "func__shr"
id.args = 2
id.arg = MKL$(INTEGER64TYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
id.ret = INTEGER64TYPE - ISPOINTER
regid

clearid
id.n = "_SHL"
id.subfunc = 1
id.callname = "func__shl"
id.args = 2
id.arg = MKL$(INTEGER64TYPE - ISPOINTER) + MKL$(LONGTYPE - ISPOINTER)
id.ret = INTEGER64TYPE - ISPOINTER
regid

clearid
id.n = "_DEFLATE"
id.Dependency=DEPENDENCY_ZLIB
id.musthave = "$"
id.subfunc = 1
id.callname = "func__deflate"
id.args = 1
id.arg = MKL$(STRINGTYPE - ISPOINTER)
id.ret = STRINGTYPE - ISPOINTER
regid

clearid
id.n = "_INFLATE"
id.Dependency=DEPENDENCY_ZLIB
id.musthave = "$"
id.subfunc = 1
id.callname = "func__inflate"
id.args = 2
id.arg = MKL$(STRINGTYPE - ISPOINTER) + MKL$(INTEGER64TYPE - ISPOINTER)
id.specialformat = "?[,?]"
id.ret = STRINGTYPE - ISPOINTER
regid

clearid
id.n = "_BORDERWIDTH"
id.subfunc =  1
id.callname = "func__borderwidth"
id.args = 0
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_TITLEBARHEIGHT"
id.subfunc =  1
id.callname = "func__titlebarheight"
id.args = 0
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_CINP"
id.subfunc =  1
id.callname = "func__CInp"
id.args = 1
id.arg = MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "[?]"
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_CAPSLOCK"
id.subfunc =  1
id.callname = "func__capslock"
id.args = 0
id.ret = INTEGERTYPE - ISPOINTER
regid

clearid
id.n = "_SCROLLOCK"
id.subfunc =  1
id.callname = "func__scrollock"
id.args = 0
id.ret = INTEGERTYPE - ISPOINTER
regid

clearid
id.n = "_NUMLOCK"
id.subfunc =  1
id.callname = "func__numlock"
id.args = 0
id.ret = INTEGERTYPE - ISPOINTER
regid

clearid
id.n = "_TOGGLE_CAPSLOCK"
id.subfunc = 2
id.callname = "sub__toggle_capslock"
id.args = 0
regid

clearid
id.n = "_TOGGLE_SCROLLOCK"
id.subfunc = 2
id.callname = "sub__toggle_scrollock"
id.args = 0
regid

clearid
id.n = "_TOGGLE_NUMLOCK"
id.subfunc = 2
id.callname = "sub__toggle_numlock"
id.args = 0
regid

clearid
id.n = "_CONSOLEFONT"
id.subfunc = 2
id.callname = "CFont"
id.args = 2
id.arg = MKL$(STRINGTYPE - ISPOINTER) + MKL$(INTEGERTYPE - ISPOINTER)
regid

clearid
id.n = "_CONSOLECURSOR"
id.subfunc = 2
id.callname = "sub__console_cursor"
id.args = 2
id.arg = MKL$(LONGTYPE - ISPOINTER)  + MKL$(LONGTYPE - ISPOINTER)
id.specialformat = "[{_SHOW|_HIDE}][,?]"
regid

clearid
id.n = "_CONSOLEMOUSEX"
id.subfunc =  1
id.callname = "func__consolemousex"
id.args = 0
id.ret = LONGTYPE - ISPOINTER
regid

clearid
id.n = "_CONSOLEINPUT"
id.subfunc =  1
id.callname = "func__getconsoleinput"
id.args = 0
id.ret = LONGTYPE - ISPOINTER
regid
