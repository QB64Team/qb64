DEFSNG A-Z


SUB VkResetMenu 'clears internal keys and rebuilds primary menu

VkRemoveInternal

i = VkByRole("ROOT")

c = 0
'add menu

IF VkHide <> 0 THEN
    c = c + 1
    i2 = VkNew
    VkReLabel i2, "Show"
    VK(i2).parent = i
    VK(i2).offsetX = VkDefaultWidth * c
    VK(i2).internal = 1
    VK(i2).role = "SHOW"
    VK(i2).w = VkNewKeySize
ELSE
    c = c + 1
    i2 = VkNew
    VkReLabel i2, "Hide"
    VK(i2).parent = i
    VK(i2).offsetX = VkDefaultWidth * c
    VK(i2).internal = 1
    VK(i2).role = "HIDE"
    VK(i2).w = VkNewKeySize
END IF


c = c + 1
i2 = VkNew
VkReLabel i2, "File"
VK(i2).parent = i
VK(i2).offsetX = VkDefaultWidth * c
VK(i2).internal = 1
VK(i2).role = "FILE"
VK(i2).w = VkNewKeySize
VK(i2).locks = 1

c = c + 1
i2 = VkNew
VkReLabel i2, "Edit"
VK(i2).parent = i
VK(i2).offsetX = VkDefaultWidth * c
VK(i2).internal = 1
VK(i2).role = "EDIT"
VK(i2).w = VkNewKeySize
VK(i2).locks = 1

c = c + 1
i2 = VkNew
VkReLabel i2, "Size"
VK(i2).parent = i
VK(i2).offsetX = VkDefaultWidth * c
VK(i2).internal = 1
VK(i2).role = "SIZE"
VK(i2).w = VkNewKeySize
VK(i2).locks = 1

c = c + 1
i2 = VkNew
VkReLabel i2, "Abc.."
VK(i2).parent = i
VK(i2).offsetX = VkDefaultWidth * c
VK(i2).internal = 1
VK(i2).role = "ABC."
VK(i2).w = VkNewKeySize
VK(i2).locks = 1

'POSTPONED UNTIL 2ND RELEASE
'c = c + 1
'i2 = VkNew
'VkReLabel i2, "Type"
'VK(i2).parent = i
'VK(i2).offsetX = VkDefaultWidth * c
'VK(i2).internal = 1
'VK(i2).role = "TYPE"
'VK(i2).w = VkNewKeySize
'VK(i2).locks = 1

'DEPRECATED (MOUSE PIPES REMOVED THE REQUIREMENT FOR INPUT MODE SELECTION)
'c = c + 1
'i2 = VkNew
'VkReLabel i2, "Input Mode"
'VK(i2).parent = i
'VK(i2).offsetX = VkDefaultWidth * c
'VK(i2).internal = 1
'VK(i2).role = "IMOD"
'VK(i2).w = VkNewKeySize
'VK(i2).locks = 1

END SUB


SUB VkSelectKey (page)

VkDefaultSelectKeyPage = page

VkRemoveInternal

rt = VkByRole("ROOT")

i2 = VkNew
VK(i2).offsetX = 0
VK(i2).offsetY = -1 * VkUnitStepY
VK(i2).parent = rt
VkReLabel i2, CHR$(26)
VK(i2).internal = 1
VK(i2).role = "NSET"
p = page + 1
VK(i2).state = p

i2 = VkNew
VK(i2).offsetX = 0
VK(i2).offsetY = -2 * VkUnitStepY
VK(i2).parent = rt
VkReLabel i2, CHR$(27)
VK(i2).internal = 1
VK(i2).role = "PSET"
p = page - 1
IF p < 1 THEN p = 1
VK(i2).state = p


'a = -1000

DIM range(100, 1 TO 2) AS LONG

r = 0

'key groups (first because they are more useful than individual keys)

r = r + 1: range(r, 1) = -1001: range(r, 2) = range(r, 1) 'Set: Full KB
r = r + 1: range(r, 1) = -1000: range(r, 2) = range(r, 1) 'Set: F1-F12
r = r + 1: range(r, 1) = -1002: range(r, 2) = range(r, 1) 'Set: Game Controller
r = r + 1: range(r, 1) = -1003: range(r, 2) = range(r, 1) 'Set: Arrow Pad
r = r + 1: range(r, 1) = -1004: range(r, 2) = range(r, 1) 'Set: WASD Pad
r = r + 1: range(r, 1) = -1005: range(r, 2) = range(r, 1) 'Set: Ins-Home-PageUp Del-End-PageDown
r = r + 1: range(r, 1) = -1006: range(r, 2) = range(r, 1) 'Set: Num Pad




'D-Pad
r = r + 1: range(r, 1) = 1000: range(r, 2) = 1004 'D-Pad

'"safe"/essential ASCII (reordered for convenience)
r = r + 1: range(r, 1) = 97: range(r, 2) = 122 'a-z
r = r + 1: range(r, 1) = 48: range(r, 2) = 57 '0-9
r = r + 1: range(r, 1) = 65: range(r, 2) = 90 'A-Z
r = r + 1: range(r, 1) = 32: range(r, 2) = 32 'SPACE
r = r + 1: range(r, 1) = 13: range(r, 2) = 13 'ENTER
r = r + 1: range(r, 1) = 8: range(r, 2) = 8 'BACKSPACE
r = r + 1: range(r, 1) = 9: range(r, 2) = 9 'TAB
r = r + 1: range(r, 1) = 33: range(r, 2) = 47 '" "-"/"
r = r + 1: range(r, 1) = 58: range(r, 2) = 64 '":"-"@"
r = r + 1: range(r, 1) = 91: range(r, 2) = 96 '"["-"`"
r = r + 1: range(r, 1) = 123: range(r, 2) = 126 '"{"-"~"
r = r + 1: range(r, 1) = 27: range(r, 2) = 27 'ESCAPE
r = r + 1: range(r, 1) = 1005: range(r, 2) = 1035 '(see below)
'arrow keys
'INSERT, etc
'F1-F12
'standard modifier keys (SHIFT, ALT, etc)
'other special keys (Windows key, ...)

'extended ASCII
r = r + 1: range(r, 1) = 127: range(r, 2) = 255

'"unsafe" ASCII (placed after all content to avoid confusion with arrows)
r = r + 1: range(r, 1) = 1: range(r, 2) = 7
r = r + 1: range(r, 1) = 10: range(r, 2) = 12
r = r + 1: range(r, 1) = 14: range(r, 2) = 26
'r = r + 1: range(r, 1) = 28: range(r, 2) = 31-4



ranges = r
a = range(1, 1)

FOR cpage = 1 TO page
    FOR y = 0 TO -3 STEP -1
        FOR x = 1 TO 7


            IF cpage = page THEN
                i2 = VkNew
                VK(i2).offsetX = x * VkDefaultWidth + 1
                VK(i2).offsetY = y * VkUnitStepY
                VK(i2).parent = rt
            END IF

            IF a <= 255 AND a >= 0 THEN

                IF cpage = page THEN
                    VkReLabel i2, CHR$(a)
                    IF a = 32 THEN VkReLabel i2, "Space"
                    IF a = 13 THEN VkReLabel i2, "Enter"
                    IF a = 8 THEN VkReLabel i2, "Back Space"
                    IF a = 9 THEN VkReLabel i2, "Tab"
                    IF a = 0 THEN VkReLabel i2, "Null"
                    IF a = 7 THEN VkReLabel i2, "Bell"
                    IF a = 10 THEN VkReLabel i2, "Line Feed"
                    IF a = 11 THEN VkReLabel i2, "Vert Tab"
                    IF a = 12 THEN VkReLabel i2, "Form Feed"
                    IF a = 27 THEN VkReLabel i2, "Esc"
                    IF a = 255 THEN VkReLabel i2, "Nbsp"
                    VK(i2).event.keydown = a
                END IF



            ELSE

                label$ = "?"
                code = 63
                lockIsTemporary = 0
                locks = 0


                'key sets
                IF a = -1000 THEN label$ = "F1-F12": code = a
                IF a = -1001 THEN label$ = "Full KB": code = a
                IF a = -1002 THEN label$ = "Game Controller": code = a
                IF a = -1003 THEN label$ = "Arrow Pad": code = a
                IF a = -1004 THEN label$ = "WASD Pad": code = a
                IF a = -1005 THEN label$ = "Ins-Home-PageUp Del-End-PageDown": code = a
                IF a = -1006 THEN label$ = "Num Pad": code = a



                n = 1000 - 1

                n = n + 1: IF a = n THEN label$ = "Virtual Joystick": code = -1

                'n = n + 1: IF a = n THEN label$ = CHR$(24) + "[UP-ARROW]": code = VK_KEY_UP
                'n = n + 1: IF a = n THEN label$ = CHR$(25) + "[DOWN-ARROW]": code = VK_KEY_DOWN
                'n = n + 1: IF a = n THEN label$ = CHR$(27) + "[LEFT-ARROW]": code = VK_KEY_LEFT
                'n = n + 1: IF a = n THEN label$ = CHR$(26) + "[RIGHT-ARROW]": code = VK_KEY_RIGHT
                n = n + 1: IF a = n THEN label$ = CHR$(24): code = VK_KEY_UP
                n = n + 1: IF a = n THEN label$ = CHR$(25): code = VK_KEY_DOWN
                n = n + 1: IF a = n THEN label$ = CHR$(27): code = VK_KEY_LEFT
                n = n + 1: IF a = n THEN label$ = CHR$(26): code = VK_KEY_RIGHT

                n = n + 1: IF a = n THEN label$ = "Ins": code = VK_KEY_INSERT
                n = n + 1: IF a = n THEN label$ = "Del": code = VK_KEY_DELETE
                n = n + 1: IF a = n THEN label$ = "Home": code = VK_KEY_HOME
                n = n + 1: IF a = n THEN label$ = "End": code = VK_KEY_END
                n = n + 1: IF a = n THEN label$ = "Page Up": code = VK_KEY_PAGE_UP
                n = n + 1: IF a = n THEN label$ = "Page Down": code = VK_KEY_PAGE_DOWN


                n = n + 1: IF a = n THEN label$ = "F1": code = VK_KEY_F1
                n = n + 1: IF a = n THEN label$ = "F2": code = VK_KEY_F2
                n = n + 1: IF a = n THEN label$ = "F3": code = VK_KEY_F3
                n = n + 1: IF a = n THEN label$ = "F4": code = VK_KEY_F4
                n = n + 1: IF a = n THEN label$ = "F5": code = VK_KEY_F5
                n = n + 1: IF a = n THEN label$ = "F6": code = VK_KEY_F6
                n = n + 1: IF a = n THEN label$ = "F7": code = VK_KEY_F7
                n = n + 1: IF a = n THEN label$ = "F8": code = VK_KEY_F8
                n = n + 1: IF a = n THEN label$ = "F9": code = VK_KEY_F9
                n = n + 1: IF a = n THEN label$ = "F10": code = VK_KEY_F10
                n = n + 1: IF a = n THEN label$ = "F11": code = VK_KEY_F11
                n = n + 1: IF a = n THEN label$ = "F12": code = VK_KEY_F12

                n = n + 1
                IF a = n THEN
                    label$ = "Shift (Left)"
                    code = VK_KEY_LSHIFT
                    locks = 1: lockIsTemporary = 1
                END IF
                n = n + 1
                IF a = n THEN
                    label$ = "Shift (Right)"
                    code = VK_KEY_RSHIFT
                    locks = 1: lockIsTemporary = 1
                END IF
                n = n + 1
                IF a = n THEN
                    label$ = "Ctrl (Left)"
                    code = VK_KEY_LCTRL
                    locks = 1: lockIsTemporary = 1
                END IF
                n = n + 1
                IF a = n THEN
                    label$ = "Ctrl (Right)"
                    code = VK_KEY_RCTRL
                    locks = 1: lockIsTemporary = 1
                END IF

                n = n + 1
                IF a = n THEN
                    label$ = "Alt (Left)"
                    code = VK_KEY_LALT
                    locks = 1: lockIsTemporary = 1
                END IF
                n = n + 1
                IF a = n THEN
                    label$ = "Alt (Right)"
                    code = VK_KEY_RALT
                    locks = 1: lockIsTemporary = 1
                END IF

                n = n + 1
                IF a = n THEN
                    label$ = "Caps Lock"
                    code = VK_KEY_CAPSLOCK
                    locks = 1
                END IF
                n = n + 1
                IF a = n THEN
                    label$ = "Num Lock"
                    code = VK_KEY_NUMLOCK
                    locks = 1
                END IF
                n = n + 1
                IF a = n THEN
                    label$ = "Scr Lock"
                    code = VK_KEY_SCROLLOCK
                    locks = 1
                END IF

                n = n + 1: IF a = n THEN label$ = "Win (Left)": code = VK_KEY_LSUPER
                n = n + 1: IF a = n THEN label$ = "Win (Right)": code = VK_KEY_RSUPER
                n = n + 1: IF a = n THEN label$ = "Apple (Left)": code = VK_KEY_LMETA
                n = n + 1: IF a = n THEN label$ = "Apple (Right)": code = VK_KEY_RMETA

                'SCREEN 2
                'PRINT n-1



                'CONST KEY_KP0& = 100256
                'CONST KEY_KP1& = 100257
                'CONST KEY_KP2& = 100258
                'CONST KEY_KP3& = 100259
                'CONST KEY_KP4& = 100260
                'CONST KEY_KP5& = 100261
                'CONST KEY_KP6& = 100262
                'CONST KEY_KP7& = 100263
                'CONST KEY_KP8& = 100264
                'CONST KEY_KP9& = 100265
                'CONST KEY_KP_PERIOD& = 100266
                'CONST KEY_KP_DIVIDE& = 100267
                'CONST KEY_KP_MULTIPLY& = 100268
                'CONST KEY_KP_MINUS& = 100269
                'CONST KEY_KP_PLUS& = 100270
                'CONST KEY_KP_ENTER& = 100271
                'CONST KEY_KP_INSERT& = 200000
                'CONST KEY_KP_END& = 200001
                'CONST KEY_KP_DOWN& = 200002
                'CONST KEY_KP_PAGE_DOWN& = 200003
                'CONST KEY_KP_LEFT& = 200004
                'CONST KEY_KP_MIDDLE& = 200005
                'CONST KEY_KP_RIGHT& = 200006
                'CONST KEY_KP_HOME& = 200007
                'CONST KEY_KP_UP& = 200008
                'CONST KEY_KP_PAGE_UP& = 200009
                'CONST KEY_KP_DELETE& = 200010

                size = LEN(label$)

                text$ = label$
                IF INSTR(text$, " ") THEN
                    text2$ = RIGHT$(text$, LEN(text$) - INSTR(text$, " "))
                    text$ = LEFT$(text$, INSTR(text$, " ") - 1)
                    IF LEN(text2$) > LEN(text$) THEN size = LEN(text2$) ELSE size = LEN(text$)
                END IF


                IF size > 5 THEN
                    x = x + (size - 5) \ 5 + 1
                    IF cpage = page THEN VK(i2).w = VkDefaultWidth + ((size - 5) \ 5 + 1) * VkDefaultWidth
                END IF

                IF cpage = page THEN
                    VkReLabel i2, label$
                    VK(i2).event.keydown = code
                    VK(i2).lockIsTemporary = lockIsTemporary
                    VK(i2).locks = locks
                END IF
            END IF

            IF cpage = page THEN
                VK(i2).internal = 1
                VK(i2).role = "VALU"
            END IF

            'END IF

            a = a + 1

            FOR r = 0 TO ranges
                IF range(r, 2) + 1 = a THEN
                    IF r = ranges THEN noMore = 1 ELSE a = range(r + 1, 1)
                    EXIT FOR
                END IF
            NEXT

            IF noMore THEN EXIT SUB

        NEXT
    NEXT
NEXT
END SUB




SUB VkPress (i)


role$ = VK(i).role

IF role$ = "ROOT" THEN
    VkAddShiftedKey = 0
    IF VK(i).locked = 0 THEN
        VK(i).held = 1
        VK(i).locked = 1

        VkResetMenu

    ELSE
        'remove all internal keys
        VkRemoveInternal
        VK(i).locked = 0
    END IF
    EXIT SUB

END IF

IF role$ = "AA.." THEN
    IF VkSelectedKey <> 0 THEN
        IF VK(VkSelectedKey).event.keydown >= 0 THEN
            VkAddShiftedKey = 0
            VkSelectKey VkDefaultSelectKeyPage
        END IF
    END IF
    EXIT SUB
END IF

IF role$ = "^AA." THEN
    IF VkSelectedKey <> 0 THEN
        IF VK(VkSelectedKey).event.keydown >= 0 THEN
            VkAddShiftedKey = 1
            VkSelectKey VkDefaultSelectKeyPage
        END IF
    END IF
    EXIT SUB
END IF

IF role$ = "ADDK" THEN
    VkSelectedKey = 0
    VkAddShiftedKey = 0
    VkSelectKey VkDefaultSelectKeyPage
    EXIT SUB
END IF

IF role$ = "DELK" THEN
    i2 = VkSelectedKey
    IF i2 <> 0 THEN
        'if this is a parent handle, all children need to be detached first
        IF VK(i2).event.keydown = -2 THEN 'keyset handle
            FOR i3 = 1 TO VkLast
                IF VK(i3).active THEN
                    IF VK(i3).parent = i2 THEN
                        VK(i3).parent = 0
                        VK(i3).offsetX = 0
                        VK(i3).offsetY = 0
                    END IF
                END IF
            NEXT
        END IF
        VkRemove i2
        VkSelectedKey = 0
        VkResetMenu
    END IF
    EXIT SUB
END IF


IF role$ = "DSET" THEN
    i2 = VkSelectedKey
    hasChildren = 0
    IF i2 <> 0 THEN
        'if this is a parent handle, all children need to be deleted first
        IF VK(i2).event.keydown = -2 THEN 'keyset handle
            FOR i3 = 1 TO VkLast
                IF VK(i3).active THEN
                    IF VK(i3).parent = i2 THEN
                        VkRemove i3
                        hasChildren = 1
                    END IF
                END IF
            NEXT
        END IF
        IF hasChildren THEN
            VkRemove i2
            VkSelectedKey = 0
            VkResetMenu
        END IF
    END IF
    EXIT SUB
END IF

IF role$ = "DALL" THEN
    FOR i3 = 1 TO VkLast
        IF VK(i3).active THEN
            IF VK(i3).internal = 0 THEN
                VkRemove i3
            END IF
        END IF
    NEXT
    VkSelectedKey = 0
    VkResetMenu
    EXIT SUB
END IF

IF role$ = "EDIT" THEN
    IF VK(i).locked = 1 THEN
        VkResetMenu
    ELSE
        VkHide = 0 'do not hide keybaord when editing
        VkResetMenu
        i = VkByRole(role$)
        VK(i).locked = 1

        ox = VK(i).offsetX

        oy = 0

        oy = oy + 1
        i2 = VkNew
        VkReLabel i2, "Add Keys"
        VK(i2).parent = VK(i).parent
        VK(i2).offsetX = ox
        VK(i2).offsetY = -oy * VkUnitStepY
        VK(i2).internal = 1
        VK(i2).role = "ADDK"
        VK(i2).w = VkNewKeySize

        oy = oy + 1
        i2 = VkNew
        VkReLabel i2, "Del Key"
        VK(i2).parent = VK(i).parent
        VK(i2).offsetX = ox
        VK(i2).offsetY = -oy * VkUnitStepY
        VK(i2).internal = 1
        VK(i2).role = "DELK"
        VK(i2).w = VkNewKeySize

        oy = oy + 1
        i2 = VkNew
        VkReLabel i2, "Del Set"
        VK(i2).parent = VK(i).parent
        VK(i2).offsetX = ox
        VK(i2).offsetY = -oy * VkUnitStepY
        VK(i2).internal = 1
        VK(i2).role = "DSET"
        VK(i2).w = VkNewKeySize

        oy = oy + 1
        i2 = VkNew
        VkReLabel i2, "Del All"
        VK(i2).parent = VK(i).parent
        VK(i2).offsetX = ox
        VK(i2).offsetY = -oy * VkUnitStepY
        VK(i2).internal = 1
        VK(i2).role = "DALL"
        VK(i2).w = VkNewKeySize


    END IF
    VkReDraw = 1
    EXIT SUB
END IF 'edit

IF role$ = "HIDE" THEN
    VkHide = -1
    VkResetMenu
    VkPress VkByRole("ROOT")
    EXIT SUB
END IF
IF role$ = "SHOW" THEN
    VkHide = 0
    VkResetMenu
    VkPress VkByRole("ROOT")
    EXIT SUB
END IF

IF role$ = "SAVE" THEN    
    VkSave
    VkResetMenu
END IF

IF role$ = "FILE" THEN
    IF VK(i).locked = 1 THEN
        VkResetMenu
    ELSE
        VkHide = 0 'do not hide keybaord when editing
        VkResetMenu
        i = VkByRole(role$)
        VK(i).locked = 1

        ox = VK(i).offsetX
        oy = 0

        oy = oy + 1
        i2 = VkNew
        VkReLabel i2, "Save"
        VK(i2).parent = VK(i).parent
        VK(i2).offsetX = ox
        VK(i2).offsetY = -oy * VkUnitStepY
        VK(i2).internal = 1
        VK(i2).role = "SAVE"
        VK(i2).w = VkNewKeySize

        oy = oy + 1
        i2 = VkNew
        VkReLabel i2, "Reset"
        VK(i2).parent = VK(i).parent
        VK(i2).offsetX = ox
        VK(i2).offsetY = -oy * VkUnitStepY
        VK(i2).internal = 1
        VK(i2).role = "RSET"
        VK(i2).w = VkNewKeySize

        oy = oy + 1
        i2 = VkNew
        VkReLabel i2, "Exit"
        VK(i2).parent = VK(i).parent
        VK(i2).offsetX = ox
        VK(i2).offsetY = -oy * VkUnitStepY
        VK(i2).internal = 1
        VK(i2).role = "EXIT"
        VK(i2).w = VkNewKeySize

    END IF
    VkReDraw = 1
    EXIT SUB
END IF 'FILE

IF role$ = "EXIT" THEN
    'remove ALL keys, even root keys
    FOR i3 = 1 TO VkLast
        IF VK(i3).active THEN
                VkRemove i3
        END IF
    NEXT
    VkSelectedKey = 0
    VkExiting=1
    EXIT SUB
END IF

IF role$ = "RSET" THEN
    'remove all keys
    FOR i3 = 1 TO VkLast
        IF VK(i3).active THEN
            IF VK(i3).internal = 0 THEN
                VkRemove i3
            END IF
        END IF
    NEXT
    VkSelectedKey = 0
    'load default layout (if one exists)
    VkFile$=""
    if _FILEEXISTS(appRootPath$+"virtual_keyboard_layout_default.txt") then VkFile$=appRootPath$+"virtual_keyboard_layout_default.txt"
    if VkFile$<>"" then
    fh = FREEFILE
    OPEN VkFile$ FOR INPUT AS #fh
    LINE INPUT #fh, json$
    CLOSE #fh
    root = QB_NODESET_deserialize(json$, "json")
    DIM oldVkWidthInUnits AS LONG
        oldVkWidthInUnits=VkWidthInUnits
        VkWidthInUnits=90
    DIM rootValueNode AS LONG
        rootValueNode=QB_NODE_withLabel(root, "width")
    if rootValueNode then VkWidthInUnits=QB_NODE_valueOfLabel_long(root, "width")
        if VkWidthInUnits<>oldVkWidthInUnits then
            FOR i3 = 1 TO VkLast
                IF VK(i3).active THEN
                    VK(i3).reDraw = 1
                END IF
            NEXT
            VkReset = 1
        END IF
    VkLoadKeys QB_NODESET_node(QB_NODESET_label_equal(QB_NODESET_children(root), "keys")), 0
    QB_NODE_destroy root
    end if
    VkResetMenu
    EXIT SUB
END IF

IF role$ = "SCUP" THEN
    VkWidthInUnits=VkWidthInUnits-6
    if VkWidthInUnits<90-6*7 then VkWidthInUnits=90-6*7
    'force all keys to be redrawn
    FOR i3 = 1 TO VkLast
        IF VK(i3).active THEN
            VK(i3).reDraw = 1
        END IF
    NEXT
    VkReset = 1
    EXIT SUB
END IF

IF role$ = "SCDN" THEN
    VkWidthInUnits=VkWidthInUnits+6
    if VkWidthInUnits>90+6*20 then VkWidthInUnits=90+6*20
    'force all keys to be redrawn
    FOR i3 = 1 TO VkLast
        IF VK(i3).active THEN
                VK(i3).reDraw = 1
        END IF
    NEXT
    VkReset = 1
    EXIT SUB
END IF

IF role$ = "BIGR" THEN
    i2 = VkSelectedKey
    IF i2 <> 0 THEN
        IF VK(i2).event.keydown >= 0 THEN
            VK(i2).w = VK(i2).w + 1
            VK(i2).reDraw = 1
        END IF
    END IF
    EXIT SUB
END IF

IF role$ = "SMLR" THEN
    i2 = VkSelectedKey
    IF i2 <> 0 THEN
        IF VK(i2).event.keydown >= 0 THEN
            VK(i2).w = VK(i2).w - 1
            IF VK(i2).w < 2 THEN VK(i2).w = 2
            VK(i2).reDraw = 1
        END IF
    END IF
    EXIT SUB
END IF

IF role$ = "SIZE" THEN
    IF VK(i).locked = 1 THEN
        VkResetMenu
    ELSE
        VkHide = 0 'do not hide keybaord when editing
        VkResetMenu
        i = VkByRole(role$)
        VK(i).locked = 1

        ox = VK(i).offsetX

        oy = 0

        oy = oy + 1
        i2 = VkNew
        VkReLabel i2, chr$(17) + chr$(196) + chr$(196) + chr$(16)
        VK(i2).parent = VK(i).parent
        VK(i2).offsetX = ox
        VK(i2).offsetY = -oy * VkUnitStepY
        VK(i2).internal = 1
        VK(i2).role = "BIGR"
        VK(i2).w = VkNewKeySize

        oy = oy + 1
        i2 = VkNew
        VkReLabel i2, chr$(196) + chr$(16) + chr$(17) + chr$(196)
        VK(i2).parent = VK(i).parent
        VK(i2).offsetX = ox
        VK(i2).offsetY = -oy * VkUnitStepY
        VK(i2).internal = 1
        VK(i2).role = "SMLR"
        VK(i2).w = VkNewKeySize

        oy = oy + 1
        i2 = VkNew
        VkReLabel i2, "Scale Up"
        VK(i2).parent = VK(i).parent
        VK(i2).offsetX = ox
        VK(i2).offsetY = -oy * VkUnitStepY
        VK(i2).internal = 1
        VK(i2).role = "SCUP"
        VK(i2).w = VkNewKeySize

        oy = oy + 1
        i2 = VkNew
        VkReLabel i2, "Scale Down"
        VK(i2).parent = VK(i).parent
        VK(i2).offsetX = ox
        VK(i2).offsetY = -oy * VkUnitStepY
        VK(i2).internal = 1
        VK(i2).role = "SCDN"
        VK(i2).w = VkNewKeySize

    END IF
    VkReDraw = 1
    EXIT SUB
END IF 'SIZE



IF role$ = "ABC." THEN
    IF VK(i).locked = 1 THEN
        VkResetMenu
    ELSE
        VkHide = 0 'do not hide keybaord when editing
        VkResetMenu
        i = VkByRole(role$)
        VK(i).locked = 1

        ox = VK(i).offsetX

        oy = 0

        oy = oy + 1
        i2 = VkNew
        VkReLabel i2, "Aa..."
        VK(i2).parent = VK(i).parent
        VK(i2).offsetX = ox
        VK(i2).offsetY = -oy * VkUnitStepY
        VK(i2).internal = 1
        VK(i2).role = "AA.."
        VK(i2).w = VkNewKeySize

        oy = oy + 1
        i2 = VkNew
        VkReLabel i2, "Aa... ^^"
        VK(i2).parent = VK(i).parent
        VK(i2).offsetX = ox
        VK(i2).offsetY = -oy * VkUnitStepY
        VK(i2).internal = 1
        VK(i2).role = "^AA."
        VK(i2).w = VkNewKeySize

    END IF
    VkReDraw = 1
    EXIT SUB
END IF 'ABC.


IF role$ = "TYPE" THEN
    IF VK(i).locked = 1 THEN
        VkResetMenu
    ELSE
        VkHide = 0 'do not hide keybaord when editing
        VkResetMenu
        i = VkByRole(role$)
        VK(i).locked = 1

        ox = VK(i).offsetX

        oy = 0

        oy = oy + 1
        i2 = VkNew
        VkReLabel i2, "Locks"
        VK(i2).parent = VK(i).parent
        VK(i2).offsetX = ox
        VK(i2).offsetY = -oy * VkUnitStepY
        VK(i2).internal = 1
        VK(i2).role = "LOCK"
        VK(i2).w = VkNewKeySize

        oy = oy + 1
        i2 = VkNew
        VkReLabel i2, "Waits Press"
        VK(i2).parent = VK(i).parent
        VK(i2).offsetX = ox
        VK(i2).offsetY = -oy * VkUnitStepY
        VK(i2).internal = 1
        VK(i2).role = "STKY"
        VK(i2).w = VkNewKeySize

    END IF
    VkReDraw = 1
    EXIT SUB
END IF 'TYPE



'IF role$ = "IMOD" THEN
'    IF VK(i).locked = 1 THEN
'        VkResetMenu
'    ELSE
'        VkResetMenu
'        i = VkByRole(role$)
'        VK(i).locked = 1
'        ox = VK(i).offsetX
'        oy = 0
'
'        oy = oy + 1
'        i2 = VkNew
'        VkReLabel i2, "Share Input"
'        VK(i2).parent = VK(i).parent
'        VK(i2).offsetX = ox
'        VK(i2).offsetY = -oy * VkUnitStepY
'        VK(i2).internal = 1
'        VK(i2).locks = 1
'        IF VkSharedInputMode <> 0 THEN VK(i2).locked = 1
'        VK(i2).role = "IMSH"
'        VK(i2).w = VkNewKeySize
'
'        oy = oy + 1
'        i2 = VkNew
'        VkReLabel i2, "Excl- usive"
'        VK(i2).parent = VK(i).parent
'        VK(i2).offsetX = ox
'        VK(i2).offsetY = -oy * VkUnitStepY
'        VK(i2).internal = 1
'        VK(i2).locks = 1
'        IF VkSharedInputMode = 0 THEN VK(i2).locked = 1
'        VK(i2).role = "IMEX"
'        VK(i2).w = VkNewKeySize
'
'    END IF
'    VkReDraw = 1
'    EXIT SUB
'END IF 'TYPE

'IF role$ = "IMSH" THEN
'    i3 = VkByRole("IMSH")
'    VK(i3).locked = 1
'    i3 = VkByRole("IMEX")
'    VK(i3).locked = 0
'    VkSharedInputMode = -1
'    VkReDraw = 1
'    DO WHILE func__mouseinput_exclusive: LOOP
'    DO WHILE _MOUSEINPUT: LOOP
'    mouseinput_mode 0
'    EXIT SUB
'END IF

'IF role$ = "IMEX" THEN
'    i3 = VkByRole("IMSH")
'    VK(i3).locked = 0
'    i3 = VkByRole("IMEX")
'    VK(i3).locked = 1
'    VkSharedInputMode = 0
'    VkReDraw = 1
'    DO WHILE func__mouseinput_exclusive: LOOP
'    DO WHILE _MOUSEINPUT: LOOP
'    mouseinput_mode 1
'    EXIT SUB
'END IF

IF VK(i).role = "NSET" OR VK(i).role = "PSET" THEN
    page = VK(i).state
    VkSelectKey page
    EXIT SUB
END IF

IF VK(i).role = "USER" THEN
    rt = VkByRole("ROOT")
    IF VK(rt).locked <> 0 THEN

        'select key
        VkSelectedKey = i
        VkReDraw = 1
        EXIT SUB

    END IF

    EXIT SUB
END IF


IF VK(i).role = "VALU" THEN


    i3 = VkByRole("ROOT")

    IF VK(i).event.keydown <= -1000 THEN 'Full KB
        'add parent (handle) key
        i2 = VkNew
        VK(i2).x = VK(i3).x + VkDefaultWidth * 0 + 1
        VK(i2).y = VK(i3).y - VkDefaultWidth * 1
        VkReLabel i2, CHR$(240)
        VK(i2).role = "USER"
        VK(i2).h = CINT(VkUnitStepY / 2)
        VK(i2).event.keydown = -2 'a "keySet"
    END IF


    IF VK(i).event.keydown = -1004 THEN 'WASD Pad
        json$ = "{\qkeys\q:[{\qtype\q:\qkey\q,\qoffsetX\q:0,\qoffsetY\q:0,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qa\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCASE_A\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:12,\qoffsetY\q:0,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qd\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCASE_D\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:6,\qoffsetY\q:6,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qw\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCASE_W\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:6,\qoffsetY\q:0,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qs\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCASE_S\q}}}]}"
        keyset = QB_NODESET_deserialize(VkGetQuotedString(json$), "json")
        VkLoadKeys QB_NODESET_node(QB_NODESET_label_equal(QB_NODESET_children(keyset), "keys")), i2
        FOR i3 = 1 TO VkLast
            IF VK(i2).active THEN
                IF VK(i3).parent = i2 THEN
                    VK(i3).offsetY = VK(i3).offsetY - VkDefaultWidth * 1
                END IF
            END IF
        NEXT
        VkPress (VkByRole("ROOT"))
        VkPress (VkByRole("ROOT"))
        VkSelectedKey = i2
        EXIT SUB
    END IF



    IF VK(i).event.keydown = -1003 THEN 'Arrow Pad
        json$ = "{\qkeys\q:[{\qtype\q:\qkey\q,\qoffsetX\q:12,\qoffsetY\q:0,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q\u2192\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_RIGHT\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:0,\qoffsetY\q:0,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q\u2190\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LEFT\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:6,\qoffsetY\q:0,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q\u2193\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_DOWN\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:6,\qoffsetY\q:6,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q\u2191\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_UP\q}}}]}"
        keyset = QB_NODESET_deserialize(VkGetQuotedString(json$), "json")
        VkLoadKeys QB_NODESET_node(QB_NODESET_label_equal(QB_NODESET_children(keyset), "keys")), i2
        FOR i3 = 1 TO VkLast
            IF VK(i2).active THEN
                IF VK(i3).parent = i2 THEN
                    VK(i3).offsetY = VK(i3).offsetY - VkDefaultWidth * 1
                END IF
            END IF
        NEXT
        VkPress (VkByRole("ROOT"))
        VkPress (VkByRole("ROOT"))
        VkSelectedKey = i2
        EXIT SUB
    END IF


    'Ins-Home-PageUp Del-End-PageDown
    IF VK(i).event.keydown = -1005 THEN 'Ins-Home-PageUp Del-End-PageDown
        json$ = "{\qkeys\q:[{\qtype\q:\qkey\q,\qoffsetX\q:12,\qoffsetY\q:0,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qPage Down\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_PAGE_DOWN\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:12,\qoffsetY\q:6,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qPage Up\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_PAGE_UP\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:6,\qoffsetY\q:0,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qEnd\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_END\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:6,\qoffsetY\q:6,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qHome\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_HOME\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:0,\qoffsetY\q:0,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qDel\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_DELETE\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:0,\qoffsetY\q:6,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qIns\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_INSERT\q}}}]}"
        keyset = QB_NODESET_deserialize(VkGetQuotedString(json$), "json")
        VkLoadKeys QB_NODESET_node(QB_NODESET_label_equal(QB_NODESET_children(keyset), "keys")), i2
        FOR i3 = 1 TO VkLast
            IF VK(i2).active THEN
                IF VK(i3).parent = i2 THEN
                    VK(i3).offsetY = VK(i3).offsetY - VkDefaultWidth * 2
                END IF
            END IF
        NEXT
        VkPress (VkByRole("ROOT"))
        VkPress (VkByRole("ROOT"))
        VkSelectedKey = i2
        EXIT SUB
    END IF

    IF VK(i).event.keydown = -1006 THEN 'Num Pad
        json$ = "{\qkeys\q:[{\qtype\q:\qkey\q,\qoffsetX\q:6,\qoffsetY\q:12,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q5\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_5\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:0,\qoffsetY\q:12,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q4\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_4\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:12,\qoffsetY\q:6,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q3\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_3\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:6,\qoffsetY\q:6,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q2\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_2\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:0,\qoffsetY\q:6,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q1\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_1\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:0,\qoffsetY\q:0,\qwidth\q:12,\qheight\q:6,\qlabel\q:\q0\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_0\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:12,\qoffsetY\q:12,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q6\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_6\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:0,\qoffsetY\q:18,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q7\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_7\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:6,\qoffsetY\q:18,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q8\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_8\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:6,\qoffsetY\q:24,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q/\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_FORWARD_SLASH\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:12,\qoffsetY\q:24,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q*\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_STAR\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:18,\qoffsetY\q:12,\qwidth\q:6,\qheight\q:12,\qlabel\q:\q+\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_PLUS\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:18,\qoffsetY\q:24,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q-\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_MINUS\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:0,\qoffsetY\q:24,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qBack Space\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_BACKSPACE\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:18,\qoffsetY\q:0,\qwidth\q:6,\qheight\q:12,\qlabel\q:\qEnter\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_ENTER\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:12,\qoffsetY\q:18,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q9\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_9\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:12,\qoffsetY\q:0,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q.\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_DOT\q}}}]}"
        keyset = QB_NODESET_deserialize(VkGetQuotedString(json$), "json")
        VkLoadKeys QB_NODESET_node(QB_NODESET_label_equal(QB_NODESET_children(keyset), "keys")), i2
        FOR i3 = 1 TO VkLast
            IF VK(i2).active THEN
                IF VK(i3).parent = i2 THEN
                    VK(i3).offsetY = VK(i3).offsetY - VkDefaultWidth * 5
                END IF
            END IF
        NEXT
        VkPress (VkByRole("ROOT"))
        VkPress (VkByRole("ROOT"))
        VkSelectedKey = i2
        EXIT SUB
    END IF





    IF VK(i).event.keydown = -1002 THEN 'Game Controller
        json$ = "{\qkeys\q:[{\qtype\q:\qkey\q,\qoffsetX\q:70,\qoffsetY\q:18,\qwidth\q:20,\qheight\q:6,\qlabel\q:\qR\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_UCASE_R\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:0,\qoffsetY\q:18,\qwidth\q:20,\qheight\q:6,\qlabel\q:\qL\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_UCASE_L\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:75,\qoffsetY\q:0,\qwidth\q:10,\qheight\q:6,\qlabel\q:\qB\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_UCASE_B\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:80,\qoffsetY\q:6,\qwidth\q:10,\qheight\q:6,\qlabel\q:\qA\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_UCASE_A\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:75,\qoffsetY\q:12,\qwidth\q:10,\qheight\q:6,\qlabel\q:\qX\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_UCASE_X\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:70,\qoffsetY\q:6,\qwidth\q:10,\qheight\q:6,\qlabel\q:\qY\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_UCASE_Y\q}}},{\qtype\q:\qjoystick\q,\qoffsetX\q:6,\qoffsetY\q:6,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qVirtual Joystick\q,\qevents\q:{\qup\q:{\qkeyCode\q:\qKEY_UP\q},\qdown\q:{\qkeyCode\q:\qKEY_DOWN\q},\qleft\q:{\qkeyCode\q:\qKEY_LEFT\q},\qright\q:{\qkeyCode\q:\qKEY_RIGHT\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:33,\qoffsetY\q:6,\qwidth\q:10,\qheight\q:6,\qlabel\q:\qSpace\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_SPACE\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:48,\qoffsetY\q:6,\qwidth\q:10,\qheight\q:6,\qlabel\q:\qEnter\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_ENTER\q}}}]}"
        keyset = QB_NODESET_deserialize(VkGetQuotedString(json$), "json")
        VkLoadKeys QB_NODESET_node(QB_NODESET_label_equal(QB_NODESET_children(keyset), "keys")), i2
        FOR i3 = 1 TO VkLast
            IF VK(i2).active THEN
                IF VK(i3).parent = i2 THEN
                    VK(i3).offsetY = VK(i3).offsetY - VkDefaultWidth * 4
                END IF
            END IF
        NEXT
        VkPress (VkByRole("ROOT"))
        VkPress (VkByRole("ROOT"))
        VkSelectedKey = i2
        EXIT SUB
    END IF


    IF VK(i).event.keydown = -1001 THEN 'Full KB
        'no shifted characters:
        'json$ = "{\qkeys\q:[{\qtype\q:\qkey\q,\qoffsetX\q:0,\qoffsetY\q:24,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q`\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_REVERSE_APOSTROPHE\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:6,\qoffsetY\q:24,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q1\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_1\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:9,\qoffsetY\q:18,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qq\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCASE_Q\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:15,\qoffsetY\q:18,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qw\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCASE_W\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:21,\qoffsetY\q:18,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qe\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCASE_E\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:27,\qoffsetY\q:18,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qr\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCASE_R\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:33,\qoffsetY\q:18,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qt\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCASE_T\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:39,\qoffsetY\q:18,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qy\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCASE_Y\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:45,\qoffsetY\q:18,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qu\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCASE_U\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:51,\qoffsetY\q:18,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qi\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCASE_I\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:57,\qoffsetY\q:18,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qo\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCASE_O\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:63,\qoffsetY\q:18,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qp\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCASE_P\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:69,\qoffsetY\q:18,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q[\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_OPEN_BRACKET_SQUARE\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:75,\qoffsetY\q:18,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q]\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_CLOSE_BRACKET_SQUARE\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:12,\qoffsetY\q:24,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q2\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_2\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:11,\qoffsetY\q:12,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qa\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCASE_A\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:17,\qoffsetY\q:12,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qs\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCASE_S\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:23,\qoffsetY\q:12,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qd\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCASE_D\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:29,\qoffsetY\q:12,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qf\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCASE_F\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:35,\qoffsetY\q:12,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qg\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCASE_G\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:41,\qoffsetY\q:12,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qh\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCASE_H\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:47,\qoffsetY\q:12,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qj\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCASE_J\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:53,\qoffsetY\q:12,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qk\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCASE_K\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:59,\qoffsetY\q:12,\qwidth\q:6,\qheight\q:6,\qlabel\q:\ql\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCASE_L\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:65,\qoffsetY\q:12,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q;\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_SEMICOLON\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:71,\qoffsetY\q:12,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q'\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_APOSTROPHE\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:81,\qoffsetY\q:18,\qwidth\q:9,\qheight\q:6,\qlabel\q:\q\\\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_BACK_SLASH\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:77,\qoffsetY\q:12,\qwidth\q:13,\qheight\q:6,\qlabel\q:\qEnter\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_ENTER\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:14,\qoffsetY\q:6,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qz\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCASE_Z\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:20,\qoffsetY\q:6,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qx\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCASE_X\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:26,\qoffsetY\q:6,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qc\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCASE_C\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:32,\qoffsetY\q:6,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qv\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCASE_V\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:38,\qoffsetY\q:6,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qb\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCASE_B\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:44,\qoffsetY\q:6,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qn\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCASE_N\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:50,\qoffsetY\q:6,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qm\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCASE_M\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:56,\qoffsetY\q:6,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q,\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_COMMA\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:62,\qoffsetY\q:6,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q.\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_DOT\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:68,\qoffsetY\q:6,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q/\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_FORWARD_SLASH\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:74,\qoffsetY\q:6,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q\u2191\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_UP\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:80,\qoffsetY\q:0,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q\u2192\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_RIGHT\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:68,\qoffsetY\q:0,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q\u2190\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LEFT\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:74,\qoffsetY\q:0,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q\u2193\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_DOWN\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:80,\qoffsetY\q:6,\qwidth\q:10,\qheight\q:6,\qlabel\q:\qShift\q,\qlocks\q:true,\qlockIsTemporary\q:true,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_RSHIFT\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:59,\qoffsetY\q:0,\qwidth\q:9,\qheight\q:6,\qlabel\q:\qAlt\q,\qlocks\q:true,\qlockIsTemporary\q:true,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_RALT\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:17,\qoffsetY\q:0,\qwidth\q:8,\qheight\q:6,\qlabel\q:\qAlt\q,\qlocks\q:true,\qlockIsTemporary\q:true,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LALT\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:9,\qoffsetY\q:0,\qwidth\q:8,\qheight\q:6,\qlabel\q:\q\u2302\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LSUPER\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:0,\qoffsetY\q:0,\qwidth\q:9,\qheight\q:6,\qlabel\q:\qCtrl\q,\qlocks\q:true,\qlockIsTemporary\q:true,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCTRL\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:24,\qoffsetY\q:24,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q4\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_4\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:18,\qoffsetY\q:24,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q3\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_3\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:30,\qoffsetY\q:24,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q5\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_5\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:36,\qoffsetY\q:24,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q6\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_6\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:42,\qoffsetY\q:24,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q7\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_7\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:48,\qoffsetY\q:24,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q8\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_8\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:54,\qoffsetY\q:24,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q9\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_9\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:60,\qoffsetY\q:24,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q0\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_0\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:66,\qoffsetY\q:24,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q-\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_MINUS\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:72,\qoffsetY\q:24,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q=\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_EQUAL\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:84,\qoffsetY\q:24,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qBack Space\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_BACKSPACE\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:78,\qoffsetY\q:24,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q+\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_PLUS\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:0,\qoffsetY\q:18,\qwidth\q:9,\qheight\q:6,\qlabel\q:\qTab\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_TAB\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:0,\qoffsetY\q:12,\qwidth\q:11,\qheight\q:6,\qlabel\q:\qCaps Lock\q,\qlocks\q:true,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_CAPSLOCK\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:0,\qoffsetY\q:6,\qwidth\q:14,\qheight\q:6,\qlabel\q:\qShift\q,\qlocks\q:true,\qlockIsTemporary\q:true,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LSHIFT\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:86,\qoffsetY\q:0,\qwidth\q:4,\qheight\q:6,\qlabel\q:\qEsc\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_ESCAPE\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:25,\qoffsetY\q:0,\qwidth\q:34,\qheight\q:6,\qlabel\q:\q\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_SPACE\q}}}]}"
        'with shifted characters:
        json$ = "{\qkeys\q:[{\qtype\q:\qkey\q,\qoffsetX\q:0,\qoffsetY\q:24,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q`\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_REVERSE_APOSTROPHE\q},\qkeydownWithShift\q:{\qkeyCode\q:\qKEY_TILDE\q,\qlabel\q:\q~\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:6,\qoffsetY\q:24,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q1\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_1\q},\qkeydownWithShift\q:{\qkeyCode\q:\qKEY_EXCLAMATION\q,\qlabel\q:\q!\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:9,\qoffsetY\q:18,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qq\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCASE_Q\q},\qkeydownWithShift\q:{\qkeyCode\q:\qKEY_UCASE_Q\q,\qlabel\q:\qQ\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:15,\qoffsetY\q:18,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qw\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCASE_W\q},\qkeydownWithShift\q:{\qkeyCode\q:\qKEY_UCASE_W\q,\qlabel\q:\qW\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:21,\qoffsetY\q:18,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qe\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCASE_E\q},\qkeydownWithShift\q:{\qkeyCode\q:\qKEY_UCASE_E\q,\qlabel\q:\qE\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:27,\qoffsetY\q:18,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qr\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCASE_R\q},\qkeydownWithShift\q:{\qkeyCode\q:\qKEY_UCASE_R\q,\qlabel\q:\qR\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:33,\qoffsetY\q:18,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qt\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCASE_T\q},\qkeydownWithShift\q:{\qkeyCode\q:\qKEY_UCASE_T\q,\qlabel\q:\qT\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:39,\qoffsetY\q:18,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qy\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCASE_Y\q},\qkeydownWithShift\q:{\qkeyCode\q:\qKEY_UCASE_Y\q,\qlabel\q:\qY\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:45,\qoffsetY\q:18,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qu\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCASE_U\q},\qkeydownWithShift\q:{\qkeyCode\q:\qKEY_UCASE_U\q,\qlabel\q:\qU\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:51,\qoffsetY\q:18,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qi\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCASE_I\q},\qkeydownWithShift\q:{\qkeyCode\q:\qKEY_UCASE_I\q,\qlabel\q:\qI\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:57,\qoffsetY\q:18,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qo\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCASE_O\q},\qkeydownWithShift\q:{\qkeyCode\q:\qKEY_UCASE_O\q,\qlabel\q:\qO\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:63,\qoffsetY\q:18,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qp\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCASE_P\q},\qkeydownWithShift\q:{\qkeyCode\q:\qKEY_UCASE_P\q,\qlabel\q:\qP\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:69,\qoffsetY\q:18,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q[\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_OPEN_BRACKET_SQUARE\q},\qkeydownWithShift\q:{\qkeyCode\q:\qKEY_OPEN_BRACKET_CURLY\q,\qlabel\q:\q{\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:75,\qoffsetY\q:18,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q]\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_CLOSE_BRACKET_SQUARE\q},\qkeydownWithShift\q:{\qkeyCode\q:\qKEY_CLOSE_BRACKET_CURLY\q,\qlabel\q:\q}\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:12,\qoffsetY\q:24,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q2\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_2\q},\qkeydownWithShift\q:{\qkeyCode\q:\qKEY_AT\q,\qlabel\q:\q@\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:11,\qoffsetY\q:12,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qa\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCASE_A\q},\qkeydownWithShift\q:{\qkeyCode\q:\qKEY_UCASE_A\q,\qlabel\q:\qA\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:17,\qoffsetY\q:12,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qs\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCASE_S\q},\qkeydownWithShift\q:{\qkeyCode\q:\qKEY_UCASE_S\q,\qlabel\q:\qS\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:23,\qoffsetY\q:12,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qd\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCASE_D\q},\qkeydownWithShift\q:{\qkeyCode\q:\qKEY_UCASE_D\q,\qlabel\q:\qD\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:29,\qoffsetY\q:12,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qf\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCASE_F\q},\qkeydownWithShift\q:{\qkeyCode\q:\qKEY_UCASE_F\q,\qlabel\q:\qF\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:35,\qoffsetY\q:12,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qg\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCASE_G\q},\qkeydownWithShift\q:{\qkeyCode\q:\qKEY_UCASE_G\q,\qlabel\q:\qG\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:41,\qoffsetY\q:12,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qh\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCASE_H\q},\qkeydownWithShift\q:{\qkeyCode\q:\qKEY_UCASE_H\q,\qlabel\q:\qH\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:47,\qoffsetY\q:12,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qj\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCASE_J\q},\qkeydownWithShift\q:{\qkeyCode\q:\qKEY_UCASE_J\q,\qlabel\q:\qJ\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:53,\qoffsetY\q:12,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qk\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCASE_K\q},\qkeydownWithShift\q:{\qkeyCode\q:\qKEY_UCASE_K\q,\qlabel\q:\qK\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:59,\qoffsetY\q:12,\qwidth\q:6,\qheight\q:6,\qlabel\q:\ql\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCASE_L\q},\qkeydownWithShift\q:{\qkeyCode\q:\qKEY_UCASE_L\q,\qlabel\q:\qL\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:65,\qoffsetY\q:12,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q;\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_SEMICOLON\q},\qkeydownWithShift\q:{\qkeyCode\q:\qKEY_COLON\q,\qlabel\q:\q:\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:71,\qoffsetY\q:12,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q'\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_APOSTROPHE\q},\qkeydownWithShift\q:{\qkeyCode\q:\qKEY_QUOTE\q,\qlabel\q:\q\\q\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:81,\qoffsetY\q:18,\qwidth\q:9,\qheight\q:6,\qlabel\q:\q\\\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_BACK_SLASH\q},\qkeydownWithShift\q:{\qkeyCode\q:\qKEY_VERTICAL_BAR\q,\qlabel\q:\q|\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:77,\qoffsetY\q:12,\qwidth\q:13,\qheight\q:6,\qlabel\q:\qEnter\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_ENTER\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:14,\qoffsetY\q:6,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qz\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCASE_Z\q},\qkeydownWithShift\q:{\qkeyCode\q:\qKEY_UCASE_Z\q,\qlabel\q:\qZ\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:20,\qoffsetY\q:6,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qx\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCASE_X\q},\qkeydownWithShift\q:{\qkeyCode\q:\qKEY_UCASE_X\q,\qlabel\q:\qX\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:26,\qoffsetY\q:6,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qc\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCASE_C\q},\qkeydownWithShift\q:{\qkeyCode\q:\qKEY_UCASE_C\q,\qlabel\q:\qC\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:32,\qoffsetY\q:6,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qv\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCASE_V\q},\qkeydownWithShift\q:{\qkeyCode\q:\qKEY_UCASE_V\q,\qlabel\q:\qV\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:38,\qoffsetY\q:6,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qb\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCASE_B\q},\qkeydownWithShift\q:{\qkeyCode\q:\qKEY_UCASE_B\q,\qlabel\q:\qB\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:44,\qoffsetY\q:6,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qn\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCASE_N\q},\qkeydownWithShift\q:{\qkeyCode\q:\qKEY_UCASE_N\q,\qlabel\q:\qN\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:50,\qoffsetY\q:6,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qm\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCASE_M\q},\qkeydownWithShift\q:{\qkeyCode\q:\qKEY_UCASE_M\q,\qlabel\q:\qM\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:56,\qoffsetY\q:6,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q,\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_COMMA\q},\qkeydownWithShift\q:{\qkeyCode\q:\qKEY_LESS_THAN\q,\qlabel\q:\q<\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:62,\qoffsetY\q:6,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q.\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_DOT\q},\qkeydownWithShift\q:{\qkeyCode\q:\qKEY_GREATER_THAN\q,\qlabel\q:\q>\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:68,\qoffsetY\q:6,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q/\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_FORWARD_SLASH\q},\qkeydownWithShift\q:{\qkeyCode\q:\qKEY_QUESTION\q,\qlabel\q:\q?\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:74,\qoffsetY\q:6,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q\u2191\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_UP\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:80,\qoffsetY\q:0,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q\u2192\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_RIGHT\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:68,\qoffsetY\q:0,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q\u2190\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LEFT\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:74,\qoffsetY\q:0,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q\u2193\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_DOWN\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:80,\qoffsetY\q:6,\qwidth\q:10,\qheight\q:6,\qlabel\q:\qShift\q,\qlocks\q:true,\qlockIsTemporary\q:true,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_RSHIFT\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:59,\qoffsetY\q:0,\qwidth\q:9,\qheight\q:6,\qlabel\q:\qAlt\q,\qlocks\q:true,\qlockIsTemporary\q:true,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_RALT\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:17,\qoffsetY\q:0,\qwidth\q:8,\qheight\q:6,\qlabel\q:\qAlt\q,\qlocks\q:true,\qlockIsTemporary\q:true,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LALT\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:9,\qoffsetY\q:0,\qwidth\q:8,\qheight\q:6,\qlabel\q:\q\u2302\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LSUPER\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:0,\qoffsetY\q:0,\qwidth\q:9,\qheight\q:6,\qlabel\q:\qCtrl\q,\qlocks\q:true,\qlockIsTemporary\q:true,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LCTRL\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:24,\qoffsetY\q:24,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q4\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_4\q},\qkeydownWithShift\q:{\qkeyCode\q:\qKEY_DOLLAR\q,\qlabel\q:\q$\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:18,\qoffsetY\q:24,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q3\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_3\q},\qkeydownWithShift\q:{\qkeyCode\q:\qKEY_HASH\q,\qlabel\q:\q#\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:30,\qoffsetY\q:24,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q5\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_5\q},\qkeydownWithShift\q:{\qkeyCode\q:\qKEY_PERCENT\q,\qlabel\q:\q%\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:36,\qoffsetY\q:24,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q6\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_6\q},\qkeydownWithShift\q:{\qkeyCode\q:\qKEY_CARET\q,\qlabel\q:\q^\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:42,\qoffsetY\q:24,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q7\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_7\q},\qkeydownWithShift\q:{\qkeyCode\q:\qKEY_AND\q,\qlabel\q:\q&\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:48,\qoffsetY\q:24,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q8\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_8\q},\qkeydownWithShift\q:{\qkeyCode\q:\qKEY_STAR\q,\qlabel\q:\q*\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:54,\qoffsetY\q:24,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q9\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_9\q},\qkeydownWithShift\q:{\qkeyCode\q:\qKEY_OPEN_BRACKET\q,\qlabel\q:\q(\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:60,\qoffsetY\q:24,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q0\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_0\q},\qkeydownWithShift\q:{\qkeyCode\q:\qKEY_CLOSE_BRACKET\q,\qlabel\q:\q)\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:66,\qoffsetY\q:24,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q-\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_MINUS\q},\qkeydownWithShift\q:{\qkeyCode\q:\qKEY_UNDERSCORE\q,\qlabel\q:\q_\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:72,\qoffsetY\q:24,\qwidth\q:6,\qheight\q:6,\qlabel\q:\q=\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_EQUAL\q},\qkeydownWithShift\q:{\qkeyCode\q:\qKEY_PLUS\q,\qlabel\q:\q+\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:78,\qoffsetY\q:24,\qwidth\q:12,\qheight\q:6,\qlabel\q:\qBack Space\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_BACKSPACE\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:0,\qoffsetY\q:18,\qwidth\q:9,\qheight\q:6,\qlabel\q:\qTab\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_TAB\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:0,\qoffsetY\q:12,\qwidth\q:11,\qheight\q:6,\qlabel\q:\qCaps Lock\q,\qlocks\q:true,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_CAPSLOCK\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:0,\qoffsetY\q:6,\qwidth\q:14,\qheight\q:6,\qlabel\q:\qShift\q,\qlocks\q:true,\qlockIsTemporary\q:true,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_LSHIFT\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:86,\qoffsetY\q:0,\qwidth\q:4,\qheight\q:6,\qlabel\q:\qEsc\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_ESCAPE\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:25,\qoffsetY\q:0,\qwidth\q:34,\qheight\q:6,\qlabel\q:\q\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_SPACE\q}}}]}"
        keyset = QB_NODESET_deserialize(VkGetQuotedString(json$), "json")
        VkLoadKeys QB_NODESET_node(QB_NODESET_label_equal(QB_NODESET_children(keyset), "keys")), i2
        FOR i3 = 1 TO VkLast
            IF VK(i2).active THEN
                IF VK(i3).parent = i2 THEN
                    VK(i3).offsetY = VK(i3).offsetY - VkDefaultWidth * 5
                END IF
            END IF
        NEXT
        VkPress (VkByRole("ROOT"))
        VkPress (VkByRole("ROOT"))
        VkSelectedKey = i2
        EXIT SUB
    END IF

    IF VK(i).event.keydown = -1000 THEN 'F1-F12
        json$ = "{\qkeys\q:[{\qtype\q:\qkey\q,\qoffsetX\q:66,\qoffsetY\q:0,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qF12\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_F12\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:60,\qoffsetY\q:0,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qF11\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_F11\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:54,\qoffsetY\q:0,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qF10\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_F10\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:48,\qoffsetY\q:0,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qF9\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_F9\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:42,\qoffsetY\q:0,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qF8\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_F8\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:36,\qoffsetY\q:0,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qF7\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_F7\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:30,\qoffsetY\q:0,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qF6\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_F6\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:24,\qoffsetY\q:0,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qF5\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_F5\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:18,\qoffsetY\q:0,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qF4\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_F4\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:12,\qoffsetY\q:0,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qF3\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_F3\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:6,\qoffsetY\q:0,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qF2\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_F2\q}}},{\qtype\q:\qkey\q,\qoffsetX\q:0,\qoffsetY\q:0,\qwidth\q:6,\qheight\q:6,\qlabel\q:\qF1\q,\qlocks\q:false,\qlockIsTemporary\q:false,\qevents\q:{\qkeydown\q:{\qkeyCode\q:\qKEY_F1\q}}}]}"
        keyset = QB_NODESET_deserialize(VkGetQuotedString(json$), "json")
        VkLoadKeys QB_NODESET_node(QB_NODESET_label_equal(QB_NODESET_children(keyset), "keys")), i2
        FOR i3 = 1 TO VkLast
            IF VK(i2).active THEN
                IF VK(i3).parent = i2 THEN
                    VK(i3).offsetY = VK(i3).offsetY - VkDefaultWidth * 1
                END IF
            END IF
        NEXT
        VkPress (VkByRole("ROOT"))
        VkPress (VkByRole("ROOT"))
        VkSelectedKey = i2
        EXIT SUB
    END IF

    addingNewKey = 0
    IF VkSelectedKey <> 0 THEN
        i2 = VkSelectedKey
    ELSE
        addingNewKey = 1
        i2 = VkNew
        VK(i2).x = VK(i3).x + VkDefaultWidth * 0 + 1
        VK(i2).y = VK(i3).y - VkDefaultWidth * 1
    END IF



    '    hasShiftedEvent AS LONG
    '    shiftedEvent AS VKEY_EVENT 'eg. when shifted or caps lock is on
    '    shiftedLabel AS STRING * 100
    'VkAddShiftedKey

    label$ = RTRIM$(VK(i).label)
    IF INSTR(label$, " (") > 1 AND INSTR(label$, ")") > 1 THEN
        'strip meta info
        label$ = LEFT$(label$, INSTR(label$, " (") - 1)
    END IF

    IF VkAddShiftedKey THEN
        VkAddShiftedKey = 0
        VK(i2).hasShiftedEvent = 1
        VkReLabelShifted i2, label$
        VK(i2).shiftedEvent.keydown = VK(i).event.keydown
    ELSE
        VkReLabel i2, label$
        VK(i2).event.keydown = VK(i).event.keydown
        VK(i2).locks = VK(i).locks
        VK(i2).lockIsTemporary = VK(i).lockIsTemporary
    END IF

    'for a-z & A-Z automatically add their shifted key codes
    IF addingNewKey <> 0 AND VkAddShiftedKey = 0 THEN
        keyCode = VK(i).event.keydown
        shiftedKeyCode = keyCode
        IF keyCode >= 97 AND keyCode <= 122 THEN shiftedKeyCode = keyCode - 32
        IF keyCode >= 65 AND keyCode <= 90 THEN shiftedKeyCode = keyCode + 32
        IF shiftedKeyCode <> keyCode THEN
            VK(i2).hasShiftedEvent = 1
            VK(i2).shiftedEvent.keydown = shiftedKeyCode
            VK(i2).shiftedLabel = CHR$(shiftedKeyCode)
        END IF
    END IF

    VK(i2).role = "USER"

    VkPress (VkByRole("ROOT"))
    VkPress (VkByRole("ROOT"))

    VkSelectedKey = i2
    EXIT SUB
END IF

END SUB

FUNCTION VkNew
VkReDraw = 1
i2 = 0
FOR i = 1 TO VkLast
    IF VK(i).active = 0 THEN
        i2 = i
    END IF
NEXT
IF i2 = 0 THEN i2 = i: VkLast = i
i = i2
VK(i) = VkEmpty
VK(i).active = 1
VK(i).x = 0
VK(i).y = 0
VK(i).w = VkDefaultWidth
VK(i).h = VkUnitStepY
VK(i).role = "UNKN"
VkNew = i
END FUNCTION

SUB VkRemove (i)
VkReDraw = 1
VK(i).active = 0
IF VK(i).image THEN _FREEIMAGE VK(i).image
IF VK(i).subImage THEN _FREEIMAGE VK(i).subImage
IF VK(i).highlightImage THEN _FREEIMAGE VK(i).highlightImage
IF VK(i).selectedImage THEN _FREEIMAGE VK(i).selectedImage
END SUB

SUB VkRemoveInternal
FOR i = 1 TO VkLast
    IF VK(i).active THEN
        IF VK(i).internal THEN
            IF VK(i).role <> "ROOT" THEN
                VkRemove i
            END IF
        END IF
    END IF
NEXT
END SUB

FUNCTION VkByRole (role$)
FOR i = 1 TO VkLast
    IF VK(i).active = 1 THEN
        IF VK(i).role = role$ THEN VkByRole = i: EXIT FUNCTION
    END IF
NEXT
END FUNCTION

SUB VkLongPress (i)
'avoid using long press for now because Windows delays MOUSEDOWN to MOUSEUP on touch
VkPress i
END SUB

SUB VkKeyRepeat (i)
keydown VK(i).keyRepeatKeyCode
VK(i).lastKeydownTime = TIMER
VK(i).keyRepeatCount = VK(i).keyRepeatCount + 1
END SUB

SUB VkKeyDown (i)
VkReDraw = 1
'called whenever user key down
IF VK(i).internal = 0 THEN
    rt = VkByRole("ROOT")
    IF VK(rt).locked = 0 THEN 'not in edit mode


        keydownvalue = VK(i).event.keydown
        IF VK(i).hasShiftedEvent THEN
            IF VkShiftInEffect THEN keydownvalue = VK(i).shiftedEvent.keydown
        END IF

        IF keydownvalue <> 0 THEN

            IF VK(i).locks <> 0 OR VK(i).lockIsTemporary <> 0 THEN

                IF VK(i).locked <> 0 THEN
                    keyup keydownvalue
                    VK(i).locked = 0
                    VK(i).held = 0
                ELSE
                    keydown keydownvalue
                    VK(i).locked = 1
                    VK(i).held = 1
                END IF
            ELSE
                VK(i).held = 1
                keydown keydownvalue
                VK(i).lastKeydownTime = TIMER
                VK(i).keyRepeatKeyCode = keydownvalue
                VK(i).keyRepeatCount = 0
            END IF
        END IF
    END IF

    IF VK(i).locks = 0 THEN
        FOR i2 = 1 TO VkLast
            IF VK(i2).active THEN
                IF VK(i2).internal = 0 THEN
                    IF i <> i2 THEN
                        IF VK(i2).locks THEN
                            IF VK(i2).locked THEN
                                IF VK(i2).lockIsTemporary THEN
                                    VkKeyDown i2
                                END IF
                            END IF
                        END IF
                    END IF
                END IF
            END IF
        NEXT
    END IF

ELSE
    VK(i).held = 1
END IF






END SUB

SUB VkKeyUp (i)
VkReDraw = 1
'called whenever user key down
IF VK(i).internal = 0 THEN
    rt = VkByRole("ROOT")
    IF VK(rt).locked = 0 THEN 'not in edit mode


        keydownvalue = VK(i).event.keydown
        IF VK(i).hasShiftedEvent THEN
            IF VkShiftInEffect THEN keydownvalue = VK(i).shiftedEvent.keydown
        END IF


        IF keydownvalue <> 0 THEN
            IF VK(i).locks <> 0 OR VK(i).lockIsTemporary <> 0 THEN
                'do nothing
            ELSE
                keyup keydownvalue
                VK(i).held = 0
            END IF
        END IF
    END IF
ELSE
    VK(i).held = 0
END IF
END SUB

SUB VkUpdate

if VkDelay>0 then
    VkTimeNow#=TIMER(0.001)
    if VkTimeNow#<VkDelayStartTime OR VkTimeNow#>=VkDelayStartTime+VkDelay THEN VkDelay=0
    exit sub
end if

if vkExited then
  DO WHILE _MOUSEINPUT(VkMousePipe)
    _MOUSEINPUTPIPE VkMousePipe
  LOOP
  exit sub
end if

if VkExiting=1 then VkExiting=2

subOldDest = _DEST
subOldSource = _SOURCE

reDraw = VkReDraw
VkReDraw = 0

IF reDraw THEN
    'SOUND 1000, .1
END IF

STATIC VkI
STATIC VKoldX
STATIC VKoldY
STATIC VKdragging
STATIC VKstart

STATIC mDownX
STATIC mDownY
STATIC omb

STATIC mb, mx, my

STATIC sx, sy

STATIC VkInit

'theme colors
'for user keys:
textCol& = _RGBA32(255, 255, 255, 192)
borderCol& = _RGBA32(32, 32, 32, 192)
borderSelectedCol& = _RGBA32(255, 255, 255, 192)
bgCol& = _RGBA32(96, 96, 96, 128)
bgHighlightCol& = _RGBA32(128, 128, 128, 128)


'for customization:
InternalTextCol& = _RGBA32(255, 255, 255, 255)
InternalBorderCol& = _RGBA32(255, 255, 255, 192)
InternalBgCol& = _RGBA32(0, 0, 0, 192)
InternalBgHighlightCol& = _RGBA32(128, 128, 128, 128)

'Init is done once
IF VkInit = 0 THEN
    VkWidthInUnits = 90 'default width in units (may be changed by loading a layout)
    VkReset = 1
END IF

winX = _SCALEDWIDTH
winY = _SCALEDHEIGHT

IF winX <> VkWinX OR winY <> VkWinY THEN
    'store new resolution
    VkWinX = winX
    VkWinY = winY
    'clear overlay image (if one exists yet)
    if VkOverlay then
        _PUTIMAGE , VkClearTex, VkOverlay
    end if
    'beging a delay (wait until screen has fully repositioned)
    VkDelayStartTime=TIMER(0.001)
    VkDelay=1
    VkDelayedReset=1
    exit sub
END IF

if VkDelayedReset=1 then
    VkDelayedReset=0
    VkReset = 1
end if

'Reset occurs whenever the screen size changes
IF VkReset = 1 THEN
    VkReset = 0

    'get new dimensions
    VkWinX = winX
    VkWinY = winY

    'PRINT winX, winY
    ' END

    sx = VkWinX: sy = VkWinY 'shortcuts

    'we need to free the old overlay & backbuffer, but because they might be
    'in use we cannot do it immediately
    VkOverlay32 = _NEWIMAGE(VkWinX, VkWinY, 32)
    VkOverlay = _COPYIMAGE(VkOverlay32, 33)
    VkBackbuffer = _COPYIMAGE(VkOverlay32, 33)
    _FREEIMAGE VkOverlay32

    VkUnitSize = sx / VkWidthInUnits

    h = CINT(VkUnitStepY * VkUnitSize * 0.5)


    'VkFont = _LOADFONT("c:\windows\fonts\lucon.ttf", CINT(h))
    'VkFontSmall = _LOADFONT("c:\windows\fonts\lucon.ttf", CINT(h * 0.5))


    'generic textures

    VkReDraw = 1
    FOR i = 1 TO VkLast
        IF VK(i).active THEN
            VK(i).reDraw = 1
        END IF
    NEXT

END IF 'reset

IF VkInit = 0 THEN

    VkClearTex = VkColTex(_RGBA32(0, 0, 0, 0)): _DONTBLEND VkClearTex

    i = VkNew
    VK(i).x = 0 'VkDefaultWidth
    VK(i).y = VkUnitStepY * 4 '*** do not modify or scaled up keybaord will be off screen***
    VK(i).w = VkDefaultWidth
    VK(i).h = VkUnitStepY
    VK(i).role = "ROOT"
    VK(i).internal = 1
    VK(i).locks = 1
    VkReLabel i, "KB" 'CHR$(15)

    VkLoad

END IF

VkInit = 1

IF reDraw THEN

    'clear backbuffer
    _DONTBLEND VkBackbuffer
    _PUTIMAGE , VkClearTex, VkBackbuffer
    _BLEND VkBackbuffer

    'correct offsets of keys relative to parents
    FOR i = 1 TO VkLast
        IF VK(i).active THEN
            p = VK(i).parent
            IF p THEN
                VK(i).x = VK(p).x + VK(i).offsetX
                VK(i).y = VK(p).y + VK(i).offsetY
            END IF
        END IF
    NEXT

    rt = VkByRole("ROOT")

    shiftInEffect = VkShiftInEffect
    'render keys
    FOR internal = 0 TO 1
        FOR i = 1 TO VkLast
            IF VK(i).active THEN
                IF VK(i).internal = internal AND (VK(i).event.keydown <> -2 OR VK(rt).locked <> 0) and (internal=1 or vkHide=0) THEN
                    x = VK(i).x * VkUnitSize
                    y = VK(i).y * VkUnitSize
                    w = VK(i).w
                    h = VK(i).h
                    x1 = INT(x)
                    x2 = INT(x + VkUnitSize * w) - 1
                    y1 = sy - 1 - INT(y)
                    y2 = sy - 1 - INT(y + VkUnitSize * h) + 1
                    w2 = x2 - x1 + 1 'pixel metrics
                    h2 = y1 - y2 + 1

                    'get key colors
                    cText& = textCol&
                    cBorder& = borderCol&
                    cBg& = bgCol&
                    cBgHighlight& = bgHighlightCol&
                    IF VK(i).internal THEN
                        cText& = InternalTextCol&
                        cBorder& = InternalBorderCol&
                        cBg& = InternalBgCol&
                        cBgHighlight& = InternalBgHighlightCol&
                    END IF


                    IF VK(i).event.keydown = -1 AND VK(i).internal = 0 THEN 'D-PAD

                        're-calculate dimensions
                        x = (VK(i).x - VkDefaultWidth) * VkUnitSize
                        y = (VK(i).y - VkUnitStepY) * VkUnitSize
                        w = VK(i).w * 3
                        h = VK(i).h * 3
                        x1 = INT(x)
                        x2 = INT(x + VkUnitSize * w) - 1
                        y1 = sy - 1 - INT(y)
                        y2 = sy - 1 - INT(y + VkUnitSize * h) + 1
                        w2 = x2 - x1 + 1 'pixel metrics
                        h2 = y1 - y2 + 1

                        create = 0

                        IF VK(i).image <> 0 AND create = 0 THEN
                            'has required size changed?
                            iw = _WIDTH(VK(i).image)
                            ih = _HEIGHT(VK(i).image)
                            IF iw <> w2 OR ih <> h2 THEN
                                create = 1
                            END IF
                        END IF

                        IF VK(i).reDraw THEN VK(i).reDraw = 0: create = 1

                        IF create THEN
                            'invalidate
                            IF VK(i).image <> 0 THEN _FREEIMAGE VK(i).image: VK(i).image = 0
                            IF VK(i).subImage <> 0 THEN _FREEIMAGE VK(i).subImage: VK(i).subImage = 0
                        END IF

                        IF VK(i).image = 0 THEN
                            'soft render base
                            defKey = _NEWIMAGE(w2, h2, 32)
                            _DEST defKey
                            _DONTBLEND
                            dpcx = w2 \ 2: dpcy = h2 \ 2
                            dprad = w2 \ 2 - 3
                            CIRCLE (dpcx, dpcy), dprad, _RGBA32(255, 255, 255, 255)
                            PAINT (dpcx, dpcy), cBg&, _RGBA32(255, 255, 255, 255)
                            'CIRCLE (dpcx, dpcy), dprad, _RGBA32(_RED32(cBg&), _GREEN32(cBg&), _BLUE32(cBg&), _ALPHA32(cBg&) * 0.75)
                            a = _ALPHA32(cBg&)
                            FOR r = dprad TO dprad + 10 STEP 0.15
                                a = a - 10
                                IF a < 0 THEN EXIT FOR
                                CIRCLE (dpcx, dpcy), r, _RGBA32(_RED32(cBg&), _GREEN32(cBg&), _BLUE32(cBg&), a)
                            NEXT
                            _BLEND
                            'conv to hw
                            VK(i).image = _COPYIMAGE(defKey, 33)
                            _FREEIMAGE defKey
                            'soft render stick
                            defKey = _NEWIMAGE(w2, h2, 32)
                            _DEST defKey
                            _DONTBLEND
                            dprad = dprad / 2.5
                            CIRCLE (dpcx, dpcy), dprad, _RGBA32(255, 255, 255, 255)
                            PAINT (dpcx, dpcy), _RGBA32(255, 255, 255, 128), _RGBA32(255, 255, 255, 255)
                            a = 128
                            FOR r = dprad TO dprad + 10 STEP 0.15
                                a = a - 10
                                IF a < 0 THEN EXIT FOR
                                CIRCLE (dpcx, dpcy), r, _RGBA32(255, 255, 255, a)
                            NEXT
                            _BLEND
                            'conv to hw
                            VK(i).subImage = _COPYIMAGE(defKey, 33)
                            _FREEIMAGE defKey
                        END IF

                        dpadx = VK(i).dpad.x: dpady = VK(i).dpad.y
                        IF VkHide = 0 OR VK(i).internal <> 0 THEN
                            _PUTIMAGE (x1, y2), VK(i).image, VkBackbuffer
                            _PUTIMAGE (x1 + dpadx * VkUnitSize * VkDefaultWidth * 0.89, y2 + dpady * VkUnitSize * VkDefaultWidth * 0.89), VK(i).subImage, VkBackbuffer
                        END IF

                        GOTO special_key
                    END IF




                    'standard key
                    create = 0

                    IF VK(i).image <> 0 AND create = 0 THEN
                        'has required size changed?
                        iw = _WIDTH(VK(i).image)
                        ih = _HEIGHT(VK(i).image)
                        IF iw <> w2 OR ih <> h2 THEN
                            create = 1
                        END IF
                    END IF

                    IF VK(i).reDraw THEN VK(i).reDraw = 0: create = 1

                    IF create THEN
                        'invalidate
                        IF VK(i).image <> 0 THEN _FREEIMAGE VK(i).image: VK(i).image = 0
                        IF VK(i).highlightImage <> 0 THEN _FREEIMAGE VK(i).highlightImage: VK(i).highlightImage = 0
                        IF VK(i).selectedImage <> 0 THEN _FREEIMAGE VK(i).selectedImage: VK(i).selectedImage = 0
                    END IF

                    IF VK(i).image = 0 THEN
                        'soft render default key

                        FOR shiftedPass = 0 TO 1
                            IF shiftedPass = 0 OR (shiftedPass = 1 AND VK(i).hasShiftedEvent <> 0) THEN
                                FOR pass = 1 TO 3
                                    defKey = _NEWIMAGE(w2, h2, 32)
                                    _DEST defKey
                                    _DONTBLEND

                                    IF pass <> 2 THEN LINE (0, 0)-(w2 - 1, h2 - 1), cBg&, BF
                                    IF pass = 2 THEN LINE (0, 0)-(w2 - 1, h2 - 1), cBgHighlight&, BF

                                    IF pass <> 3 THEN
                                        LINE (0, 0)-(w2 - 1, h2 - 1), cBorder&, B
                                    ELSE
                                        LINE (0, 0)-(w2 - 1, h2 - 1), borderSelectedCol&, B
                                    END IF

                                    _BLEND

                                    'add text

                                    'convert label to image
                                    text$ = RTRIM$(VK(i).label)
                                    IF shiftedPass THEN text$ = RTRIM$(VK(i).shiftedLabel)

                                    text2$ = ""

                                    IF text$ <> "" THEN

                                        lines = 1
                                        IF INSTR(text$, " ") THEN
                                            lines = 2
                                            text2$ = RIGHT$(text$, LEN(text$) - INSTR(text$, " "))
                                            text$ = LEFT$(text$, INSTR(text$, " ") - 1)
                                        END IF

                                        defKeyHeightInPixels = VkUnitStepY * VkUnitSize
                                        '42.6 for screen 0 80x25
                                        font = VkFindFont(INT(defKeyHeightInPixels / 2)) 'ideally 20 for 80x25
                                        IF lines = 2 OR LEN(text$) >= 2 AND text$ <> "KB" THEN
                                            font = VkFindFont(INT(defKeyHeightInPixels / 3.5)) 'ideally 12 for 80x25
                                        END IF

                                        _FONT font

                                        cw = _PRINTWIDTH(text$)
                                        IF lines = 2 THEN
                                            cw2 = _PRINTWIDTH(text2$)
                                            IF cw2 > cw THEN cw = cw2
                                        END IF
                                        ch = _FONTHEIGHT
                                        IF cw <> 0 AND ch <> 0 THEN

                                            ox = w2 \ 2 - cw \ 2
                                            oy = h2 \ 2 - (ch * lines) \ 2

                                            '    _PUTIMAGE ((x1 + x2) / 2 - cw / 2, (y1 + y2) / 2 - ch / 2), ci33, VkBackbuffer

                                            _PRINTMODE _KEEPBACKGROUND
                                            COLOR cText&
                                            _CONTROLCHR OFF
                                            _PRINTSTRING (ox, oy), text$
                                            IF text2$ <> "" THEN _PRINTSTRING (ox, oy + ch), text2$
                                            _CONTROLCHR ON



                                        END IF 'cw <> 0 AND ch <> 0
                                    END IF 'text$<>""



                                    '    _FONT font
                                    '    cw = _PRINTWIDTH(text$)
                                    '    IF lines = 2 THEN
                                    '        cw2 = _PRINTWIDTH(text2$)
                                    '        IF cw2 > cw THEN cw = cw2
                                    '    END IF
                                    '    ch = _FONTHEIGHT




                                    '    '                    GOTO 1
                                    '    IF cw = 0 OR ch = 0 THEN GOTO 1




                                    '    ci = _NEWIMAGE(cw, ch * lines, 32)
                                    '    _DEST ci
                                    '    _FONT font
                                    '    _PRINTMODE _KEEPBACKGROUND
                                    '    COLOR textCol&
                                    '    _CONTROLCHR OFF
                                    '    _PRINTSTRING (0, 0), text$
                                    '    _PRINTSTRING (0, ch), text2$
                                    '    _CONTROLCHR ON



                                    'IF VK(i).held THEN
                                    '    cBg& = cBgHighlight&
                                    'END IF

                                    'bgTex = VkColTex(bgCol&)
                                    'borderTex = VkColTex(borderCol&)

                                    ''PRINT x1, y1, x2, y2
                                    '_PUTIMAGE (x1 + 1, y2 + 1)-(x2 - 1, y1 - 1), bgTex, VkBackbuffer

                                    '_PUTIMAGE (x1, y2)-(x2, y2), borderTex, VkBackbuffer
                                    '_PUTIMAGE (x1, y2 + 1)-(x1, y1), borderTex, VkBackbuffer
                                    '_PUTIMAGE (x2, y2 + 1)-(x2, y1), borderTex, VkBackbuffer
                                    '_PUTIMAGE (x1 + 1, y1)-(x2 - 1, y1), borderTex, VkBackbuffer


                                    ''LINE (x1, y1)-(x2, y2), borderCol&, B
                                    ''                _BLEND
                                    ''               _BLEND bgTex

                                    'IF g = 0 THEN
                                    '    g = 1
                                    '    '    _PUTIMAGE (0, 0)-(100, 100), bgTex
                                    '    '    _PUTIMAGE (50, 50)-(150, 150), borderTex
                                    'END IF
                                    '_FREEIMAGE bgTex
                                    '_FREEIMAGE borderTex

                                    'conv to hw
                                    IF shiftedPass = 0 THEN
                                        IF pass = 1 THEN VK(i).image = _COPYIMAGE(defKey, 33)
                                        IF pass = 2 THEN VK(i).highlightImage = _COPYIMAGE(defKey, 33)
                                        IF pass = 3 THEN VK(i).selectedImage = _COPYIMAGE(defKey, 33)
                                    ELSE
                                        IF pass = 1 THEN VK(i).shiftedImage = _COPYIMAGE(defKey, 33)
                                        IF pass = 2 THEN VK(i).shiftedHighlightImage = _COPYIMAGE(defKey, 33)
                                        IF pass = 3 THEN VK(i).shiftedSelectedImage = _COPYIMAGE(defKey, 33)
                                    END IF
                                    _FREEIMAGE defKey
                                NEXT 'pass
                            END IF
                        NEXT 'shiftedPass
                        'SOUND 1000, 0.1
                    END IF

                    'assume shift in effect
                    shifted = 0
                    IF VK(i).hasShiftedEvent THEN
                        IF shiftInEffect THEN
                            shifted = 1
                        END IF
                    END IF


                    IF VkHide = 0 OR VK(i).internal <> 0 THEN
                        IF shifted THEN
                            IF VkSelectedKey = i AND VK(rt).locked <> 0 THEN
                                _PUTIMAGE (x1, y2), VK(i).shiftedSelectedImage, VkBackbuffer
                            ELSE
                                IF VK(i).locks THEN
                                    IF VK(i).locked THEN
                                        _PUTIMAGE (x1, y2), VK(i).shiftedHighlightImage, VkBackbuffer
                                    ELSE
                                        _PUTIMAGE (x1, y2), VK(i).shiftedImage, VkBackbuffer
                                    END IF
                                ELSE
                                    IF VK(i).held THEN
                                        _PUTIMAGE (x1, y2), VK(i).shiftedHighlightImage, VkBackbuffer
                                    ELSE
                                        _PUTIMAGE (x1, y2), VK(i).shiftedImage, VkBackbuffer
                                    END IF
                                END IF
                            END IF
                        ELSE
                            IF VkSelectedKey = i AND VK(rt).locked <> 0 THEN
                                _PUTIMAGE (x1, y2), VK(i).selectedImage, VkBackbuffer
                            ELSE
                                IF VK(i).locks THEN
                                    IF VK(i).locked THEN
                                        _PUTIMAGE (x1, y2), VK(i).highlightImage, VkBackbuffer
                                    ELSE
                                        _PUTIMAGE (x1, y2), VK(i).image, VkBackbuffer
                                    END IF
                                ELSE
                                    IF VK(i).held THEN
                                        _PUTIMAGE (x1, y2), VK(i).highlightImage, VkBackbuffer
                                    ELSE
                                        _PUTIMAGE (x1, y2), VK(i).image, VkBackbuffer
                                    END IF
                                END IF
                            END IF
                        END IF
                    END IF
                    ''convert label to image
                    'text$ = RTRIM$(VK(i).label)
                    'IF text$ <> "" THEN
                    '    lines = 1
                    '    IF INSTR(text$, " ") THEN
                    '        lines = 2
                    '        text2$ = RIGHT$(text$, LEN(text$) - INSTR(text$, " "))
                    '        text$ = LEFT$(text$, INSTR(text$, " ") - 1)
                    '    END IF


                    '    font = VkFont




                    '    IF lines = 2 OR LEN(text$) > 1 THEN
                    '        font = VkFontSmall
                    '    END IF



                    '    STATIC dummy32
                    '    IF dummy32 = 0 THEN
                    '        dummy32 = _NEWIMAGE(1, 1, 32)
                    '    END IF


                    '    olddest = _DEST
                    '    _DEST dummy32
                    '    _FONT font
                    '    cw = _PRINTWIDTH(text$)
                    '    IF lines = 2 THEN
                    '        cw2 = _PRINTWIDTH(text2$)
                    '        IF cw2 > cw THEN cw = cw2
                    '    END IF
                    '    ch = _FONTHEIGHT




                    '    '                    GOTO 1
                    '    IF cw = 0 OR ch = 0 THEN GOTO 1




                    '    ci = _NEWIMAGE(cw, ch * lines, 32)
                    '    _DEST ci
                    '    _FONT font
                    '    _PRINTMODE _KEEPBACKGROUND
                    '    COLOR textCol&
                    '    _CONTROLCHR OFF
                    '    _PRINTSTRING (0, 0), text$
                    '    _PRINTSTRING (0, ch), text2$
                    '    _CONTROLCHR ON

                    '    ch = ch * lines
                    '    ci33 = _COPYIMAGE(ci, 33)
                    '    _FREEIMAGE ci

                    '    'IF VkFontScale = 1 THEN
                    '    _PUTIMAGE ((x1 + x2) / 2 - cw / 2, (y1 + y2) / 2 - ch / 2), ci33, VkBackbuffer
                    '    'ELSE
                    '    'cw = cw / VkFontScale
                    '    'ch = ch / VkFontScale
                    '    '_PUTIMAGE ((x1 + x2) / 2 - cw / 2, (y1 + y2) / 2 - ch / 2)-((x1 + x2) / 2 + cw / 2 - 1, (y1 + y2) / 2 + ch / 2 - 1), ci33, VkBackbuffer, , _SMOOTH
                    '    'END IF
                    '    _FREEIMAGE ci33

                    '    1
                    '    _DEST olddest

                    special_key:
                    '                    _DEST olddest
                    '            END IF

                END IF
            END IF
        NEXT
    NEXT





    '_PUTIMAGE (mx, my)-(mx + 100, my + 100), borderTex, VkBackbuffer

    '_PUTIMAGE , VkBackbuffer, VkOverlay
    _DONTBLEND VkBackbuffer
    _PUTIMAGE , VkBackbuffer, VkOverlay
    '_PUTIMAGE (0, 0)-(639, 399), VkOverlay
    requestKeyboardOverlayImage VkOverlay
    _BLEND VkBackbuffer

END IF 'reDraw


'key repeat
timeNow! = TIMER
FOR i = 1 TO VkLast
    IF VK(i).active THEN
        IF VK(i).internal = 0 THEN
            IF VK(i).lastKeydownTime <> 0 THEN 'only keys which can repeat will have this set
                IF VK(i).held THEN
                    IF VK(i).keyRepeatCount = 0 THEN
                        IF ABS(VK(i).lastKeydownTime - timeNow!) > VkDelayUntilFirstRepeat THEN
                            VkKeyRepeat i
                        END IF
                    ELSE
                        IF ABS(VK(i).lastKeydownTime - timeNow!) > VkDelayUntilFollowingRepeats THEN
                            VkKeyRepeat i
                        END IF
                    END IF
                END IF
            END IF
        END IF
    END IF
NEXT

DO

    mDown = 0
    mUp = 0
    mEvent = 0

if VkMousePipe=0 then   
    VkMousePipe=_MOUSEPIPEOPEN 'create new pipe
end if

'    IF VkSharedInputMode THEN
'        VkGetMouse VkSharedMouseMx, VkSharedMouseMy, VkSharedMouseMb
'        mb = VkSharedMouseMb
'        mb = mb AND 1
'        IF mb <> 0 THEN mb = -1
'        mx = VkSharedMouseMx
'        my = VkSharedMouseMy
'        'CALL INTERRUPT is a problem...
'        'if ((display_page->compatible_mode==1)||(display_page->compatible_mode==7)||(display_page->compatible_mode==13)) cpu.cx*=2;
'        'if (display_page->text){
'        '  //note: a range from 0 to columns*8-1 is returned regardless of the number of actual pixels
'        '  cpu.cx=(mx-0.5)*8.0;
'        '  if (cpu.cx>=(display_page->width*8)) cpu.cx=(display_page->width*8)-1;
'        '  //note: a range from 0 to rows*8-1 is returned regardless of the number of actual pixels
'        '  //obselete line of code: cpu.dx=(((float)cpu.dx)/((float)(display_page->height*fontheight[display_page->font])))*((float)(display_page->height*8));//(mouse_y/height_in_pixels)*(rows*8)
'        '  cpu.dx=(my-0.5)*8.0;
'        '  if (cpu.dx>=(display_page->height*8)) cpu.dx=(display_page->height*8)-1;
'        '}
'        'reverse adjustments made by CALL INTERRUPT
'        IF _PIXELSIZE = 1 THEN 'legacy modes adjustment
'            mx = mx \ 2
'        END IF
'        IF _PIXELSIZE = 0 THEN 'screen 0 adjustment
'            mx = (mx / 8) + 0.5
'            my = (my / 8) + 0.5
'        END IF
'        'apply new adjustments
'        IF _PIXELSIZE = 0 THEN 'screen 0 adjustment
'            mx = mx * 8 - 4
'            my = my * 16 - 8
'        END IF
'        IF mb = -1 AND omb = 0 THEN mDown = -1: mEvent = 1
'        IF mb = 0 AND omb = -1 THEN mUp = -1: mEvent = 1
'        omb = mb
'    ELSE

        DO WHILE _MOUSEINPUT(VkMousePipe)
            mb = _MOUSEBUTTON(1, VkMousePipe)

            mx = _MOUSEX(VkMousePipe)
            my = _MOUSEY(VkMousePipe)

        sw=_width(0)
        sh=_height(0)

            IF _PIXELSIZE = 0 THEN 'screen 0 adjustment
                mx = mx * 8 - 4
                my = my * 16 - 8
        sw=sw*8
        sh=sh*16
            END IF

            mx = CINT(mx*(_SCALEDWIDTH/sw))
            my = CINT(my*(_SCALEDHEIGHT/sh))

            IF mb = -1 AND omb = 0 THEN mDown = -1: mEvent = 1: EXIT DO

        if VkMousePipeCapture=0 then
                _MOUSEINPUTPIPE VkMousePipe
        end if

            IF mb = 0 AND omb = -1 THEN
        VkMousePipeCapture=0
        mUp = -1
        mEvent = 1
        EXIT DO
        end if

        LOOP
        omb = mb
'    END IF

    rootId = VkByRole("ROOT")
    editMode = VK(rootId).locked

    IF mDown THEN   
        mDownX = mx
        mDownY = my
        i2 = 0

        FOR internal = 1 TO 0 STEP -1
            FOR i = VkLast TO 1 STEP -1
                IF VK(i).active THEN
                    IF VK(i).internal = internal THEN
            if internal=1 or VkHide=0 then
                            x = VK(i).x * VkUnitSize
                            y = VK(i).y * VkUnitSize
                            w = VK(i).w
                            h = VK(i).h
                            x1 = INT(x)
                            x2 = INT(x + VkUnitSize * w) - 1
                            y1 = sy - 1 - INT(y)
                            y2 = sy - 1 - INT(y + VkUnitSize * h) + 1
                            IF mx >= x1 AND mx <= x2 AND my >= y2 AND my <= y1 THEN
                                i2 = i
                                EXIT FOR
                            END IF
            end if
                    END IF
                END IF
            NEXT
            IF i2 THEN EXIT FOR
        NEXT
        IF i2 THEN
            VkI = i2
            VKoldX = VK(i2).x
            VKoldY = VK(i2).y
            VKdragging = 0
            VKstart = TIMER(0.001)
            'VK(i2).held = -1
            VkKeyDown i2
        VkMousePipeCapture=1
        END IF
        if VkMousePipeCapture=0 then _MOUSEINPUTPIPE VkMousePipe
    END IF

    IF mUp THEN
        IF VkI THEN

            IF VK(VkI).event.keydown = -1 THEN
                IF editMode = 0 THEN
                    VkUpdateDPAD VkI, 0, 0
                END IF
            END IF

            VkKeyUp VkI
            IF VKdragging = 0 THEN
                VKend = TIMER(0.001)
                duration = VKend - VKstart
                IF duration > 0.5 THEN
                    VkLongPress (VkI)
                ELSE
                    VkPress (VkI)
                END IF
            END IF
            'VK(VKi).held = 0
            VkI = 0
        END IF
    END IF
    rt = VkByRole("ROOT")
    IF mb THEN
        IF VkI THEN

            canMove = 0
            IF VK(rt).locked <> 0 OR VK(VkI).internal = 1 THEN canMove = 1

            IF canMove = 1 THEN
                'calculate distance in units from mouse down location to current location
                nx = VKoldX + CINT((mx - mDownX) / VkUnitSize)
                ny = VKoldY - CINT((my - mDownY) / VkUnitSize / VkUnitStepY) * VkUnitStepY

                distX = ABS(VKoldX - nx)
                distY = ABS(VKoldY - ny)
                IF distY > distX THEN dist = distY ELSE dist = distX

                IF dist >= VkUnitStepY THEN

                    IF VK(rt).locked <> 0 OR VK(VkI).internal = 1 THEN

                        VKdragging = -1
                        'VK(VKi).held = 0
                        IF VK(VkI).parent <> 0 AND VK(VkI).internal <> 0 THEN
                            p = VK(VkI).parent
                            mDownX = mDownX + (VK(VkI).x - VK(p).x) * VkUnitSize
                            mDownY = mDownY + (VK(p).y - VK(VkI).y) * VkUnitSize
                            VkI = p
                        END IF
                    END IF
                END IF
            END IF 'canmove=1

            'dpad
            IF canMove = 0 THEN
                IF VK(rt).locked = 0 AND VK(VkI).event.keydown = -1 THEN
                    'dpad
                    VKdragging = -1
                END IF
            END IF

            IF VKdragging THEN
                IF VK(rt).locked = 0 AND VK(VkI).event.keydown = -1 THEN
                    dpadx = mx - mDownX '(VK(VkI).x * VkUnitSize + VkUnitSize / 2)
                    dpady = my - mDownY '  (sy - VK(VkI).y * VkUnitSize - VkUnitSize / 2)
                    dpadx = dpadx / (VkUnitSize * VkDefaultWidth * 0.9)
                    dpady = dpady / (VkUnitSize * VkDefaultWidth * 0.9)
                    'normalize if greater than 1 unit
                    l = SQR(dpadx * dpadx + dpady * dpady)
                    IF l > 1 THEN
                        dpadx = dpadx / l
                        dpady = dpady / l
                    END IF
                    VkUpdateDPAD VkI, dpadx, dpady
                    'convert dpad value relative to 1/0




                ELSE
                    'prevent off-screen drag
                    IF nx < 0 THEN nx = 0
                    IF ny < 0 THEN ny = 0
                    'prevent covering of other (non-internal) keys
                    ox = VK(VkI).x
                    oy = VK(VkI).y
                    oldOffsetX = VK(VkI).offsetX
                    oldOffsetY = VK(VkI).offsetY
                    IF ox <> nx OR oy <> ny THEN
                        sgnx = SGN(nx - ox): IF sgnx = 0 THEN sgnx = 1
                        sgny = SGN(ny - oy) * VkUnitStepY: IF sgny = 0 THEN sgny = VkUnitStepY
                        bestDist = 10000
                        FOR ix = ox TO nx STEP sgnx
                            FOR iy = oy TO ny STEP sgny
                                blocked = 0
                                IF VK(VkI).event.keydown <> -2 AND VK(VkI).internal = 0 THEN
                                    nw = VK(VkI).w
                                    FOR i = 1 TO VkLast
                                        IF VK(i).internal = 0 AND VK(i).active AND i <> VkI AND VK(i).event.keydown <> -2 THEN
                                            y = VK(i).y: x = VK(i).x: w = VK(i).w
                                            IF iy = y THEN 'same row
                                                ok = 0
                                                IF ix >= x + w THEN ok = 1
                                                IF ix + nw <= x THEN ok = 1
                                                IF ok = 0 THEN blocked = 1
                                            END IF
                                        END IF
                                    NEXT
                                END IF
                                IF blocked = 0 THEN
                                    dist = ABS(nx - ix) + ABS(ny - iy)
                                    IF dist < bestDist THEN
                                        bestDist = dist
                                        IF VK(VkI).parent THEN
                                            VK(VkI).offsetX = oldOffsetX + (ix - ox)
                                            VK(VkI).offsetY = oldOffsetY + (iy - oy)
                                        END IF
                                        VK(VkI).x = ix
                                        VK(VkI).y = iy
                                        VkReDraw = 1
                                    END IF
                                END IF
                            NEXT
                        NEXT
                    END IF
                END IF
            END IF
        END IF
    END IF

LOOP UNTIL mEvent = 0



'_DISPLAY
'_LIMIT 30
'k$ = inkey$
'k$ = ""

_DEST subOldDest
_SOURCE subOldSource

if VkExiting=2 then
    VkExiting=0
    VkExited=1  
end if

END SUB





FUNCTION VkColTex& (col&)
i& = _NEWIMAGE(1, 1, 32)
oldDest& = _DEST
_DEST i&
_DONTBLEND
CLS , col&
_BLEND
_DEST oldDest&
VkColTex& = _COPYIMAGE(i&, 33)
_FREEIMAGE i&
END FUNCTION

SUB VkUpdateDPAD (i, x, y)
VkReDraw = 1
ox = VK(i).dpad.x
oy = VK(i).dpad.y
minDist = 0.35 'diagonal max. dist is ~7
odx = VK(i).dpad.dx
ody = VK(i).dpad.dy
dx = 0
IF x <= -minDist THEN dx = -1
IF x >= minDist THEN dx = 1
dy = 0
IF y <= -minDist THEN dy = -1
IF y >= minDist THEN dy = 1
'hardcoded dpad keys
VK(i).dpad.left.keydown = VK_KEY_LEFT
VK(i).dpad.right.keydown = VK_KEY_RIGHT
VK(i).dpad.up.keydown = VK_KEY_UP
VK(i).dpad.down.keydown = VK_KEY_DOWN
IF dx <> odx THEN
    IF odx = -1 THEN keyup VK(i).dpad.left.keydown
    IF odx = 1 THEN keyup VK(i).dpad.right.keydown
    IF dx = -1 THEN keydown VK(i).dpad.left.keydown: VK(i).dpad.lastKeyDx = dx: VK(i).dpad.lastKeyDy = 0
    IF dx = 1 THEN keydown VK(i).dpad.right.keydown: VK(i).dpad.lastKeyDx = dx: VK(i).dpad.lastKeyDy = 0
END IF
IF dy <> ody THEN
    IF ody = -1 THEN keyup VK(i).dpad.up.keydown
    IF ody = 1 THEN keyup VK(i).dpad.down.keydown
    IF dy = -1 THEN keydown VK(i).dpad.up.keydown: VK(i).dpad.lastKeyDy = dy: VK(i).dpad.lastKeyDx = 0
    IF dy = 1 THEN keydown VK(i).dpad.down.keydown: VK(i).dpad.lastKeyDy = dy: VK(i).dpad.lastKeyDx = 0
END IF
'strongest direction must have been represented by last known keydown event fired by dpad
IF dx <> 0 OR dy <> 0 THEN 'has direction
    bestDx = 0: bestDy = 0
    IF ABS(x) > ABS(y) THEN
        bestDx = SGN(x)
    ELSE
        bestDy = SGN(y)
    END IF
    IF bestDx <> VK(i).dpad.lastKeyDx AND bestDx <> 0 THEN
        dx = bestDx
        IF dx = -1 THEN keydown VK(i).dpad.left.keydown: VK(i).dpad.lastKeyDx = dx: VK(i).dpad.lastKeyDy = 0
        IF dx = 1 THEN keydown VK(i).dpad.right.keydown: VK(i).dpad.lastKeyDx = dx: VK(i).dpad.lastKeyDy = 0

    ELSE
        IF bestDy <> VK(i).dpad.lastKeyDy AND bestDy <> 0 THEN
            dy = bestDy
            IF dy = -1 THEN keydown VK(i).dpad.up.keydown: VK(i).dpad.lastKeyDy = dy: VK(i).dpad.lastKeyDx = 0
            IF dy = 1 THEN keydown VK(i).dpad.down.keydown: VK(i).dpad.lastKeyDy = dy: VK(i).dpad.lastKeyDx = 0

        END IF
    END IF
END IF
VK(i).dpad.dx = dx
VK(i).dpad.dy = dy
VK(i).dpad.x = x
VK(i).dpad.y = y
END SUB

SUB VkReLabel (i, label$)
VkReDraw = 1
VK(i).label = label$
VK(i).reDraw = 1
END SUB

SUB VkReLabelShifted (i, label$)
VkReDraw = 1
VK(i).shiftedLabel = label$
VK(i).reDraw = 1
END SUB


SUB VkAddKeyName (keyName AS STRING, keyCode AS LONG)
value = QB_NODE_new(QB_NODE_TYPE_VALUE, 0)
QB_NODE_setLabel_format value, QB_STR_new(keyName), QB_NODE_FORMAT_STR
QB_NODE_setValue_format value, keyCode, QB_NODE_FORMAT_LONG
QB_NODE_assign VkKeyCodeLookup, value
value = QB_NODE_new(QB_NODE_TYPE_VALUE, 0)
QB_NODE_setLabel_format value, keyCode, QB_NODE_FORMAT_LONG
QB_NODE_setValue_format value, QB_STR_new(keyName), QB_NODE_FORMAT_STR
QB_NODE_assign VkKeyNameLookup, value
END SUB

SUB VkAddKeyNames

VkKeyNameLookup = QB_NODE_newDictionary
VkKeyCodeLookup = QB_NODE_newDictionary

VkAddKeyName "KEY_PAUSE", 100019
VkAddKeyName "KEY_NUMLOCK", 100300
VkAddKeyName "KEY_CAPSLOCK", 100301
VkAddKeyName "KEY_SCROLLOCK", 100302
VkAddKeyName "KEY_RSHIFT", 100303
VkAddKeyName "KEY_LSHIFT", 100304
VkAddKeyName "KEY_RCTRL", 100305
VkAddKeyName "KEY_LCTRL", 100306
VkAddKeyName "KEY_RALT", 100307
VkAddKeyName "KEY_LALT", 100308
VkAddKeyName "KEY_RMETA", 100309
VkAddKeyName "KEY_LMETA", 100310
VkAddKeyName "KEY_LSUPER", 100311
VkAddKeyName "KEY_RSUPER", 100312
VkAddKeyName "KEY_MODE", 100313
VkAddKeyName "KEY_COMPOSE", 100314
VkAddKeyName "KEY_HELP", 100315
VkAddKeyName "KEY_PRINT", 100316
VkAddKeyName "KEY_SYSREQ", 100317
VkAddKeyName "KEY_BREAK", 100318
VkAddKeyName "KEY_MENU", 100319
VkAddKeyName "KEY_POWER", 100320
VkAddKeyName "KEY_EURO", 100321
VkAddKeyName "KEY_UNDO", 100322
VkAddKeyName "KEY_KP0", 100256
VkAddKeyName "KEY_KP1", 100257
VkAddKeyName "KEY_KP2", 100258
VkAddKeyName "KEY_KP3", 100259
VkAddKeyName "KEY_KP4", 100260
VkAddKeyName "KEY_KP5", 100261
VkAddKeyName "KEY_KP6", 100262
VkAddKeyName "KEY_KP7", 100263
VkAddKeyName "KEY_KP8", 100264
VkAddKeyName "KEY_KP9", 100265
VkAddKeyName "KEY_KP_PERIOD", 100266
VkAddKeyName "KEY_KP_DIVIDE", 100267
VkAddKeyName "KEY_KP_MULTIPLY", 100268
VkAddKeyName "KEY_KP_MINUS", 100269
VkAddKeyName "KEY_KP_PLUS", 100270
VkAddKeyName "KEY_KP_ENTER", 100271
VkAddKeyName "KEY_KP_INSERT", 200000
VkAddKeyName "KEY_KP_END", 200001
VkAddKeyName "KEY_KP_DOWN", 200002
VkAddKeyName "KEY_KP_PAGE_DOWN", 200003
VkAddKeyName "KEY_KP_LEFT", 200004
VkAddKeyName "KEY_KP_MIDDLE", 200005
VkAddKeyName "KEY_KP_RIGHT", 200006
VkAddKeyName "KEY_KP_HOME", 200007
VkAddKeyName "KEY_KP_UP", 200008
VkAddKeyName "KEY_KP_PAGE_UP", 200009
VkAddKeyName "KEY_KP_DELETE", 200010
VkAddKeyName "KEY_SCROLL_LOCK_MODE", 200011
VkAddKeyName "KEY_INSERT_MODE", 200012

VkAddKeyName "KEY_F1", 15104
VkAddKeyName "KEY_F2", 15360
VkAddKeyName "KEY_F3", 15616
VkAddKeyName "KEY_F4", 15872
VkAddKeyName "KEY_F5", 16128
VkAddKeyName "KEY_F6", 16384
VkAddKeyName "KEY_F7", 16640
VkAddKeyName "KEY_F8", 16896
VkAddKeyName "KEY_F9", 17152
VkAddKeyName "KEY_F10", 17408
VkAddKeyName "KEY_F11", 34048
VkAddKeyName "KEY_F12", 34304

VkAddKeyName "KEY_INSERT", 20992
VkAddKeyName "KEY_DELETE", 21248
VkAddKeyName "KEY_HOME", 18176
VkAddKeyName "KEY_END", 20224
VkAddKeyName "KEY_PAGE_UP", 18688
VkAddKeyName "KEY_PAGE_DOWN", 20736

VkAddKeyName "KEY_UP", 18432
VkAddKeyName "KEY_DOWN", 20480
VkAddKeyName "KEY_LEFT", 19200
VkAddKeyName "KEY_RIGHT", 19712

VkAddKeyName "KEY_BACKSPACE", 8
VkAddKeyName "KEY_TAB", 9

VkAddKeyName "KEY_ENTER", 13
VkAddKeyName "KEY_ESCAPE", 27

VkAddKeyName "KEY_SPACE", 32
VkAddKeyName "KEY_EXCLAMATION", 33
VkAddKeyName "KEY_QUOTE", 34
VkAddKeyName "KEY_HASH", 35
VkAddKeyName "KEY_DOLLAR", 36
VkAddKeyName "KEY_PERCENT", 37
VkAddKeyName "KEY_AND", 38
VkAddKeyName "KEY_APOSTROPHE", 39
VkAddKeyName "KEY_OPEN_BRACKET", 40
VkAddKeyName "KEY_CLOSE_BRACKET", 41
VkAddKeyName "KEY_STAR", 42
VkAddKeyName "KEY_PLUS", 43
VkAddKeyName "KEY_COMMA", 44
VkAddKeyName "KEY_MINUS", 45
VkAddKeyName "KEY_DOT", 46
VkAddKeyName "KEY_FORWARD_SLASH", 47
VkAddKeyName "KEY_0", 48
VkAddKeyName "KEY_1", 49
VkAddKeyName "KEY_2", 50
VkAddKeyName "KEY_3", 51
VkAddKeyName "KEY_4", 52
VkAddKeyName "KEY_5", 53
VkAddKeyName "KEY_6", 54
VkAddKeyName "KEY_7", 55
VkAddKeyName "KEY_8", 56
VkAddKeyName "KEY_9", 57
VkAddKeyName "KEY_COLON", 58
VkAddKeyName "KEY_SEMICOLON", 59
VkAddKeyName "KEY_LESS_THAN", 60
VkAddKeyName "KEY_EQUAL", 61
VkAddKeyName "KEY_GREATER_THAN", 62
VkAddKeyName "KEY_QUESTION", 63
VkAddKeyName "KEY_AT", 64
VkAddKeyName "KEY_A", 65
VkAddKeyName "KEY_B", 66
VkAddKeyName "KEY_C", 67
VkAddKeyName "KEY_D", 68
VkAddKeyName "KEY_E", 69
VkAddKeyName "KEY_F", 70
VkAddKeyName "KEY_G", 71
VkAddKeyName "KEY_H", 72
VkAddKeyName "KEY_I", 73
VkAddKeyName "KEY_J", 74
VkAddKeyName "KEY_K", 75
VkAddKeyName "KEY_L", 76
VkAddKeyName "KEY_M", 77
VkAddKeyName "KEY_N", 78
VkAddKeyName "KEY_O", 79
VkAddKeyName "KEY_P", 80
VkAddKeyName "KEY_Q", 81
VkAddKeyName "KEY_R", 82
VkAddKeyName "KEY_S", 83
VkAddKeyName "KEY_T", 84
VkAddKeyName "KEY_U", 85
VkAddKeyName "KEY_V", 86
VkAddKeyName "KEY_W", 87
VkAddKeyName "KEY_X", 88
VkAddKeyName "KEY_Y", 89
VkAddKeyName "KEY_Z", 90
VkAddKeyName "KEY_UCASE_A", 65
VkAddKeyName "KEY_UCASE_B", 66
VkAddKeyName "KEY_UCASE_C", 67
VkAddKeyName "KEY_UCASE_D", 68
VkAddKeyName "KEY_UCASE_E", 69
VkAddKeyName "KEY_UCASE_F", 70
VkAddKeyName "KEY_UCASE_G", 71
VkAddKeyName "KEY_UCASE_H", 72
VkAddKeyName "KEY_UCASE_I", 73
VkAddKeyName "KEY_UCASE_J", 74
VkAddKeyName "KEY_UCASE_K", 75
VkAddKeyName "KEY_UCASE_L", 76
VkAddKeyName "KEY_UCASE_M", 77
VkAddKeyName "KEY_UCASE_N", 78
VkAddKeyName "KEY_UCASE_O", 79
VkAddKeyName "KEY_UCASE_P", 80
VkAddKeyName "KEY_UCASE_Q", 81
VkAddKeyName "KEY_UCASE_R", 82
VkAddKeyName "KEY_UCASE_S", 83
VkAddKeyName "KEY_UCASE_T", 84
VkAddKeyName "KEY_UCASE_U", 85
VkAddKeyName "KEY_UCASE_V", 86
VkAddKeyName "KEY_UCASE_W", 87
VkAddKeyName "KEY_UCASE_X", 88
VkAddKeyName "KEY_UCASE_Y", 89
VkAddKeyName "KEY_UCASE_Z", 90
VkAddKeyName "KEY_OPEN_BRACKET_SQUARE", 91
VkAddKeyName "KEY_BACK_SLASH", 92
VkAddKeyName "KEY_CLOSE_BRACKET_SQUARE", 93
VkAddKeyName "KEY_CARET", 94
VkAddKeyName "KEY_UNDERSCORE", 95
VkAddKeyName "KEY_REVERSE_APOSTROPHE", 96
VkAddKeyName "KEY_LCASE_A", 97
VkAddKeyName "KEY_LCASE_B", 98
VkAddKeyName "KEY_LCASE_C", 99
VkAddKeyName "KEY_LCASE_D", 100
VkAddKeyName "KEY_LCASE_E", 101
VkAddKeyName "KEY_LCASE_F", 102
VkAddKeyName "KEY_LCASE_G", 103
VkAddKeyName "KEY_LCASE_H", 104
VkAddKeyName "KEY_LCASE_I", 105
VkAddKeyName "KEY_LCASE_J", 106
VkAddKeyName "KEY_LCASE_K", 107
VkAddKeyName "KEY_LCASE_L", 108
VkAddKeyName "KEY_LCASE_M", 109
VkAddKeyName "KEY_LCASE_N", 110
VkAddKeyName "KEY_LCASE_O", 111
VkAddKeyName "KEY_LCASE_P", 112
VkAddKeyName "KEY_LCASE_Q", 113
VkAddKeyName "KEY_LCASE_R", 114
VkAddKeyName "KEY_LCASE_S", 115
VkAddKeyName "KEY_LCASE_T", 116
VkAddKeyName "KEY_LCASE_U", 117
VkAddKeyName "KEY_LCASE_V", 118
VkAddKeyName "KEY_LCASE_W", 119
VkAddKeyName "KEY_LCASE_X", 120
VkAddKeyName "KEY_LCASE_Y", 121
VkAddKeyName "KEY_LCASE_Z", 122
VkAddKeyName "KEY_OPEN_BRACKET_CURLY", 123
VkAddKeyName "KEY_VERTICAL_BAR", 124
VkAddKeyName "KEY_CLOSE_BRACKET_CURLY", 125
VkAddKeyName "KEY_TILDE", 126
VkAddKeyName "KEY_BACKSPACE_ALTERNATE", 127
END SUB

FUNCTION VkGetKeyName$ (keyCode AS LONG)
VkGetKeyName$ = QB_STR_long(keyCode)
DIM VkChild AS LONG
DIM VkI AS LONG
DO WHILE QB_NODE_eachWithLabel_format(VkChild, VkKeyNameLookup, keyCode, QB_NODE_FORMAT_LONG, VkI)
    VkGetKeyName$ = QB_NODE_value(VkChild)
    EXIT FUNCTION
LOOP
END FUNCTION

FUNCTION VkGetKeyCode& (keyName AS STRING)
DIM i AS LONG
i = QB_NODE_withLabel(VkKeyCodeLookup, keyName)
IF i THEN
    VkGetKeyCode& = VAL(QB_NODE_value(i))
ELSE
    VkGetKeyCode& = VAL(keyName)
END IF
END FUNCTION


SUB VkSaveKeys (parentNode AS LONG, parentKey AS LONG)
FOR i = 1 TO VkLast
    IF VK(i).internal = 0 AND VK(i).active <> 0 AND VK(i).parent = parentKey THEN

        thisKey = QB_NODE_newDictionary
        QB_NODE_assign parentNode, thisKey

        'get type
        keyType$ = "key"
        IF VK(i).event.keydown = -1 THEN
            keyType$ = "joystick"
        END IF
        IF VK(i).event.keydown = -2 THEN
            keyType$ = "keySet"
        END IF

        QB_NODE_assign thisKey, QB_NODE_newValueWithLabel("type", keyType$)

        IF parentKey = 0 THEN
            QB_NODE_assign thisKey, QB_NODE_newValueWithLabel_long("x", VK(i).x)
            QB_NODE_assign thisKey, QB_NODE_newValueWithLabel_long("y", VK(i).y)
        ELSE
            QB_NODE_assign thisKey, QB_NODE_newValueWithLabel_long("offsetX", VK(i).offsetX)
            QB_NODE_assign thisKey, QB_NODE_newValueWithLabel_long("offsetY", VK(i).offsetY)
        END IF

        QB_NODE_assign thisKey, QB_NODE_newValueWithLabel_long("width", VK(i).w)
        QB_NODE_assign thisKey, QB_NODE_newValueWithLabel_long("height", VK(i).h)

        QB_NODE_assign thisKey, QB_NODE_newValueWithLabel("label", RTRIM$(VK(i).label))

        events = QB_NODE_newDictionary: QB_NODE_setLabel events, "events"
        IF keyType$ = "key" THEN
            QB_NODE_assign thisKey, QB_NODE_newValueWithLabel_bool("locks", VK(i).locks)
            QB_NODE_assign thisKey, QB_NODE_newValueWithLabel_bool("lockIsTemporary", VK(i).lockIsTemporary)
            event = QB_NODE_newDictionary: QB_NODE_setLabel event, "keydown": QB_NODE_assign events, event
            QB_NODE_assign event, QB_NODE_newValueWithLabel("keyCode", VkGetKeyName(VK(i).event.keydown))
            IF VK(i).hasShiftedEvent THEN
                event = QB_NODE_newDictionary: QB_NODE_setLabel event, "keydownWithShift": QB_NODE_assign events, event
                QB_NODE_assign event, QB_NODE_newValueWithLabel("keyCode", VkGetKeyName(VK(i).shiftedEvent.keydown))
                QB_NODE_assign event, QB_NODE_newValueWithLabel("label", RTRIM$(VK(i).shiftedLabel))
            END IF
        END IF
        IF keyType$ = "joystick" THEN
            'hardcode keys
            VK(i).dpad.left.keydown = VK_KEY_LEFT
            VK(i).dpad.right.keydown = VK_KEY_RIGHT
            VK(i).dpad.up.keydown = VK_KEY_UP
            VK(i).dpad.down.keydown = VK_KEY_DOWN
            event = QB_NODE_newDictionary: QB_NODE_setLabel event, "up": QB_NODE_assign events, event
            QB_NODE_assign event, QB_NODE_newValueWithLabel("keyCode", VkGetKeyName(VK(i).dpad.up.keydown))
            event = QB_NODE_newDictionary: QB_NODE_setLabel event, "down": QB_NODE_assign events, event
            QB_NODE_assign event, QB_NODE_newValueWithLabel("keyCode", VkGetKeyName(VK(i).dpad.down.keydown))
            event = QB_NODE_newDictionary: QB_NODE_setLabel event, "left": QB_NODE_assign events, event
            QB_NODE_assign event, QB_NODE_newValueWithLabel("keyCode", VkGetKeyName(VK(i).dpad.left.keydown))
            event = QB_NODE_newDictionary: QB_NODE_setLabel event, "right": QB_NODE_assign events, event
            QB_NODE_assign event, QB_NODE_newValueWithLabel("keyCode", VkGetKeyName(VK(i).dpad.right.keydown))
        END IF
        IF keyType$ = "keySet" THEN
        END IF
        IF QB_NODE_count(events) > 0 THEN
            QB_NODE_assign thisKey, events
        ELSE
            QB_NODE_destroy events
        END IF

        childKeys = QB_NODE_newList: QB_NODE_setLabel childKeys, "childKeys"
        VkSaveKeys childKeys, i
        IF QB_NODE_count(childKeys) > 0 THEN
            QB_NODE_assign thisKey, childKeys
        ELSE
            QB_NODE_destroy childKeys
        END IF
    END IF
NEXT
END SUB

SUB VkSave
root = QB_NODE_newDictionary
QB_NODE_assign root, QB_NODE_newValueWithLabel_long("width", VkWidthInUnits)
keys = QB_NODE_newList: QB_NODE_setLabel keys, "keys": QB_NODE_assign root, keys
VkSaveKeys keys, 0
json$ = QB_NODESET_serialize(root, "json")
QB_NODE_destroy root
fh = FREEFILE
OPEN appRootPath$+"virtual_keyboard_layout_current.txt" FOR OUTPUT AS #fh
PRINT #fh, json$
CLOSE #fh
END SUB

SUB VkLoadKeys (parentNode AS LONG, parentKey AS LONG)
DIM iterator AS LONG
DIM keyNode AS LONG
DO WHILE QB_NODE_each(keyNode, parentNode, iterator)
    DIM events AS LONG
    DIM event AS LONG
    events = QB_NODE_withLabel(keyNode, "events")
    keyType$ = QB_NODE_valueOfLabel(keyNode, "type")
    i = VkNew
    VK(i).role = "USER"
    VK(i).parent = parentKey
    IF parentKey THEN
        VK(i).offsetX = QB_NODE_valueOfLabel_long(keyNode, "offsetX")
        VK(i).offsetY = QB_NODE_valueOfLabel_long(keyNode, "offsetY")
    ELSE
        VK(i).x = QB_NODE_valueOfLabel_long(keyNode, "x")
        VK(i).y = QB_NODE_valueOfLabel_long(keyNode, "y")
    END IF
    VK(i).w = QB_NODE_valueOfLabel_long(keyNode, "width")
    VK(i).h = QB_NODE_valueOfLabel_long(keyNode, "height")
    VK(i).label = QB_NODE_valueOfLabel(keyNode, "label")
    IF keyType$ = "key" THEN
        VK(i).locks = QB_NODE_valueOfLabel_bool(keyNode, "locks")
        VK(i).lockIsTemporary = QB_NODE_valueOfLabel_bool(keyNode, "lockIsTemporary")
        VK(i).event.keydown = VkGetKeyCode&(QB_NODE_valueOfLabel(QB_NODE_withLabel(events, "keydown"), "keyCode"))
        shiftedEvent = QB_NODE_withLabel(events, "keydownWithShift")
        IF shiftedEvent THEN
            VK(i).hasShiftedEvent = 1
            VK(i).shiftedEvent.keydown = VkGetKeyCode&(QB_NODE_valueOfLabel(shiftedEvent, "keyCode"))
            VK(i).shiftedLabel = QB_NODE_valueOfLabel(shiftedEvent, "label")
        END IF
    END IF
    IF keyType$ = "keySet" THEN
        VK(i).event.keydown = -2
        VkLoadKeys QB_NODE_withLabel(keyNode, "childKeys"), i
    END IF
    IF keyType$ = "joystick" THEN
        VK(i).event.keydown = -1
        VK(i).dpad.left.keydown = VkGetKeyCode&(QB_NODE_valueOfLabel(QB_NODE_withLabel(events, "left"), "keyCode"))
        VK(i).dpad.right.keydown = VkGetKeyCode&(QB_NODE_valueOfLabel(QB_NODE_withLabel(events, "right"), "keyCode"))
        VK(i).dpad.up.keydown = VkGetKeyCode&(QB_NODE_valueOfLabel(QB_NODE_withLabel(events, "up"), "keyCode"))
        VK(i).dpad.down.keydown = VkGetKeyCode&(QB_NODE_valueOfLabel(QB_NODE_withLabel(events, "down"), "keyCode"))
    END IF
LOOP
END SUB

FUNCTION VkGetQuotedString$ (a$)
a2$ = SPACE$(LEN(a$))
i2 = 0
FOR i = 1 TO LEN(a$)
    a2 = a
    a = ASC(a$, i)
    IF a2 = 92 AND a = 113 THEN
        ASC(a2$, i2) = 34
    ELSE
        i2 = i2 + 1
        ASC(a2$, i2) = a
    END IF
NEXT
a2$ = LEFT$(a2$, i2)
VkGetQuotedString$ = a2$
END FUNCTION

SUB VkLoad
VkFile$=""
if _FILEEXISTS(appRootPath$+"virtual_keyboard_layout_default.txt") then VkFile$=appRootPath$+"virtual_keyboard_layout_default.txt"
if _FILEEXISTS(appRootPath$+"virtual_keyboard_layout_current.txt") then VkFile$=appRootPath$+"virtual_keyboard_layout_current.txt"
if VkFile$<>"" then
    fh = FREEFILE
    OPEN VkFile$ FOR INPUT AS #fh
    LINE INPUT #fh, json$
    CLOSE #fh
    root = QB_NODESET_deserialize(json$, "json")
    DIM oldVkWidthInUnits AS LONG
        oldVkWidthInUnits=VkWidthInUnits
        VkWidthInUnits=90
    DIM rootValueNode AS LONG
        rootValueNode=QB_NODE_withLabel(root, "width")
    if rootValueNode then VkWidthInUnits=QB_NODE_valueOfLabel_long(root, "width")
        if VkWidthInUnits<>oldVkWidthInUnits then
            FOR i3 = 1 TO VkLast
                IF VK(i3).active THEN       
                    VK(i3).reDraw = 1
                END IF
            NEXT
            VkReset = 1
        END IF
    VkLoadKeys QB_NODESET_node(QB_NODESET_label_equal(QB_NODESET_children(root), "keys")), 0
    QB_NODE_destroy root
end if
END SUB

FUNCTION VkShiftInEffect
shiftInEffect = 0
'IF _KEYDOWN(VK_KEY_LSHIFT) OR _KEYDOWN(VK_KEY_RSHIFT) THEN
'    shiftInEffect = 1
'END IF
shiftLockInEffect = 0
FOR i = 1 TO VkLast
    IF VK(i).active THEN
        IF VK(i).internal = 0 THEN
            'is this a caps lock or shift key?
            'is it active?
            IF VK(i).event.keydown = VK_KEY_CAPSLOCK THEN
                IF VK(i).held <> 0 THEN
                    shiftLockInEffect = 1
                END IF
            END IF
        END IF
    END IF
NEXT
shiftKeyHeld = 0
FOR i = 1 TO VkLast
    IF VK(i).active THEN
        IF VK(i).internal = 0 THEN
            'is this a caps lock or shift key?
            'is it active?
            IF VK(i).event.keydown = VK_KEY_LSHIFT OR VK(i).event.keydown = VK_KEY_RSHIFT THEN
                IF VK(i).held <> 0 THEN
                    shiftKeyHeld = 1
                END IF
            END IF
        END IF
    END IF
NEXT
IF shiftLockInEffect + shiftKeyHeld = 1 THEN shiftInEffect = 1
IF VkAddShiftedKey = 1 THEN shiftInEffect = 1
VkShiftInEffect = shiftInEffect
END FUNCTION

SUB VkGetMouse (mx AS LONG, my AS LONG, mb AS LONG)
'DIM SHARED VkReg AS VkRegTypeX
VkReg.ax = 3
CALL INTERRUPT(&H33, VkReg, VkReg)
mb = VkReg.bx AND 1
mx = VkReg.cx
my = VkReg.dx
END SUB

FUNCTION VkFindFont& (idealSize AS LONG)
FOR diff = 0 TO 1000
    FOR negative = 0 TO 1
        IF negative THEN
            size = idealSize - diff
        ELSE
            size = idealSize + diff \ 2 'increase of size is less desirable that decrease of size
        END IF
        IF size >= 0 AND size <= UBOUND(vkfontAllow) THEN
            IF vkFontAllow(size) THEN
        if vkFonts(size)=0 then vkFonts(size)=_LOADFONT(appRootPath$+"cyberbit.ttf", size)
        if vkFonts(size)=0 then 'font failed to load, so use inbuilt font instead
            vkFonts(size)=16
            if size<16 then vkFonts(size)=8
        end if
                VkFindFont& = vkFonts(size)
                EXIT FUNCTION
            END IF
        END IF
    NEXT
NEXT
END FUNCTION
