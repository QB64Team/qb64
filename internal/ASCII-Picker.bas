temp = _NEWIMAGE(640, 480, 32)
temp1 = _NEWIMAGE(640, 480, 32)
ws = _NEWIMAGE(640, 480, 32)
SCREEN temp
DIM CurrentASC(1 TO 16, 1 TO 16)
DIM CurrentOne AS INTEGER
CLS , _RGB(100, 0, 200)
COLOR , _RGB(100, 0, 200)
FOR x = 1 TO 16
    FOR y = 1 TO 16
        LINE (x * 40, 0)-(x * 40, 480), _RGB32(255, 255, 0)
        LINE (0, y * 30)-(640, y * 30), _RGB32(255, 255, 0)
        IF counter THEN _PRINTSTRING (x * 40 - 28, y * 30 - 23), CHR$(counter)
        counter = counter + 1
    NEXT
NEXT

_DEST temp1
CLS , _RGB(100, 0, 200)
COLOR , _RGB(100, 0, 200)
counter = 0
FOR x = 1 TO 16
    FOR y = 1 TO 16
        LINE (x * 40, 0)-(x * 40, 480), _RGB32(255, 255, 0)
        LINE (0, y * 30)-(640, y * 30), _RGB32(255, 255, 0)
        text$ = LTRIM$(STR$(counter))
        IF counter THEN _PRINTSTRING (x * 40 - 24 - (LEN(text$)) * 4, y * 30 - 23), text$
        counter = counter + 1
    NEXT
NEXT
_DEST temp


x = 1: y = 1
_PUTIMAGE , temp, ws
DO: LOOP WHILE _MOUSEINPUT 'clear the mouse input buffer
oldmousex = _MOUSEX: oldmousey = _MOUSEY

DO
    _LIMIT 60
    DO: LOOP WHILE _MOUSEINPUT
    MB = _MOUSEBUTTON(1) 'Track the first button for us

    x = _MOUSEX \ 40 + 1 'If mouse moved, where are we now?
    y = _MOUSEY \ 30 + 1
    num = (x - 1) * 16 + y - 1
    IF num = 0 THEN
        text$ = ""
    ELSE
        flashcounter = flashcounter + 1
        IF flashcounter > 30 THEN
            COLOR _RGB32(255, 255, 255), _RGB(100, 0, 200)
            text$ = CHR$(num)
            IF LEN(text$) = 1 THEN text$ = " " + text$ + " "
        ELSE
            COLOR _RGB32(255, 0, 0), _RGB(100, 0, 200)
            text$ = RTRIM$(LTRIM$(STR$(num)))
        END IF
    END IF
    IF flashcounter = 60 THEN flashcounter = 1
    CLS
    IF toggle THEN _PUTIMAGE , temp1, temp ELSE _PUTIMAGE , ws, temp

    _PRINTSTRING (x * 40 - 24 - (LEN(text$)) * 4, y * 30 - 23), text$
    LINE (x * 40 - 40, y * 30 - 30)-(x * 40, y * 30), _RGBA32(255, 255, 255, 150), BF
    k = _KEYHIT
    SELECT CASE k
        CASE 13: EXIT DO
        CASE 27: skipit = -1: EXIT DO
        CASE 32: toggle = NOT toggle
        CASE 18432: y = y - 1
        CASE 19200: x = x - 1
        CASE 20480: y = y + 1
        CASE 19712: x = x + 1
    END SELECT
    IF x < 1 THEN x = 1
    IF x > 16 THEN x = 16
    IF y < 1 THEN y = 1
    IF y > 16 THEN y = 16
    _DISPLAY
    IF MB THEN EXIT DO
LOOP
CLS
IF NOT skipit THEN CurrentOne = (x - 1) * 16 + y - 1 ELSE CurrentOne = 0 'check for valid non-zero character
SYSTEM CurrentOne
