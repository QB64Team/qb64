DEFLNG A-Z
WIDTH 80, 50
COLOR 15
CLS
PRINT "QB64 AUDIO (ESC=QUIT, H=SELECT HANDLE)"
PRINT "Basics: O=OPEN  C=CLOSE   ENTER=PLAY   S=STOP    L=LOOP"
PRINT "Extras: V=VOL   B=BAL     SPACE=PAUSE  A=SETPOS  Z=COPY"
PRINT "Info:   Q=PLAYING&GETPOS  W=LEN        P=PAUSED"
PRINT "Macros: F=PLAYFILE        X=PLAYCOPY"
PRINT STRING$(80, "_")
VIEW PRINT 8 TO 50
LOCATE , , 1

DO

SLEEP 'lowers CPU usage
k$ = UCASE$(INKEY$)

IF k$ = CHR$(27) THEN END

IF k$ = "H" THEN
h2 = h
INPUT "handle=", h
IF h = 0 THEN PRINT "Invalid handle": h = h2
END IF

IF k$ = "O" THEN
PRINT "handle=_SNDOPEN(filename$,[requirements$])"
INPUT ; "handle=_SNDOPEN(", f$, r$
PRINT ")"
h2 = h
h=_SNDOPEN(f$, r$)
IF h=0 THEN
IF h2 THEN h = h2
PRINT "Failed"
ELSE
PRINT "handle="; h
END IF
END IF

IF k$ = "C" THEN
PRINT "_SNDCLOSE"; h
_SNDCLOSE h
END IF

IF k$ = CHR$(13) THEN
PRINT "_SNDPLAY"; h
_SNDPLAY h
END IF

IF k$ = "S" THEN
PRINT "_SNDSTOP"; h
_SNDSTOP h
END IF

IF k$ = "L" THEN
PRINT "_SNDLOOP"; h
_SNDLOOP h
END IF

IF k$ = "V" THEN
PRINT "_SNDVOL handle&,volume!{0-1}"
PRINT "_SNDVOL"; h; ",";
INPUT "", volume!
_SNDVOL h, volume!
END IF

IF k$ = "B" THEN
PRINT "_SNDBAL handle&,[x!],[y!],[z!]"
PRINT "_SNDBAL"; h; ",";
INPUT "", x!, y!, z!
_SNDBAL h, x!, y!, z!
END IF

IF k$ = " " THEN
PRINT "_SNDPAUSE"; h
_SNDPAUSE h
END IF

IF k$ = "A" THEN
PRINT "_SNDSETPOS handle&,offsetinseconds!"
PRINT "_SNDSETPOS"; h; ",";
INPUT "", offset!
_SNDSETPOS h, offset!
END IF

IF k$ = "Z" THEN
PRINT "handle=_SNDCOPY("; h; ")"
h2 = _SNDCOPY(h)
if h2 then
h = h2
PRINT "handle="; h
ELSE
PRINT "Failed"
END IF
END IF

IF k$ = "Q" THEN
PRINT "PRINT _PLAYING("; h; ")"
PRINT _SNDPLAYING(h)
PRINT "PRINT _GETPOS("; h; ")"
PRINT _SNDGETPOS(h)
END IF

IF k$ = "W" THEN
PRINT "PRINT _SNDLEN("; h; ")"
PRINT _SNDLEN(h)
END IF

IF k$ = "P" THEN
PRINT "PRINT _SNDPAUSED("; h; ")"
PRINT _SNDPAUSED(h)
END IF

IF k$ = "F" THEN
PRINT "_SNDPLAYFILE filename$,sync%{0/1},volume!{0-1}"
INPUT "_SNDPLAYFILE ", filename$, sync%, volume!
_SNDPLAYFILE filename$, sync%, volume!
END IF

IF k$ = "X" THEN
PRINT "_SNDPLAYCOPY"; h
_SNDPLAYCOPY h
END IF

LOOP

