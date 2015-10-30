DEFSNG A-Z

DECLARE LIBRARY
    SUB requestKeyboardOverlayImage (BYVAL handle AS LONG)
    SUB mouseinput_mode (BYVAL exclusive AS LONG)
    FUNCTION func__mouseinput_exclusive&
END DECLARE

'VK Constants
'$include:'virtual_keyboard_keycodes.bas'
'$include:'virtual_keyboard_keypush.bas'

'VK Types
TYPE VKEY_EVENT
    keydown AS LONG
END TYPE

TYPE VKEY_DPAD
    up AS VKEY_EVENT
    down AS VKEY_EVENT
    left AS VKEY_EVENT
    right AS VKEY_EVENT
    x AS SINGLE '-1 to 1
    y AS SINGLE '-1 to 1
    dx AS LONG '-1, 0, 1
    dy AS LONG '-1, 0, 1
    lastKeyDx AS LONG '-1, 0, 1
    lastKeyDy AS LONG '-1, 0, 1
END TYPE

TYPE VKEY_TYPE
    active AS LONG '1=in use
    internal AS LONG
    role AS STRING * 4
    state AS LONG
    label AS STRING * 100
    x AS LONG 'left hand side
    y AS LONG 'from base of screen
    w AS LONG 'width
    h AS LONG 'height (default is 10)
    parent AS LONG
    offsetX AS LONG
    offsetY AS LONG
    held AS LONG
    event AS VKEY_EVENT

    hasShiftedEvent AS LONG
    shiftedEvent AS VKEY_EVENT 'eg. when shifted or caps lock is on
    shiftedLabel AS STRING * 100

    locks AS LONG '1 or 0 eg. num lock, scroll lock, caps lock
    lockIsTemporary AS LONG 'eg shift key, locks till next press
    locked AS LONG
    dpad AS VKEY_DPAD


    subImage AS LONG

    image AS LONG
    highlightImage AS LONG
    selectedImage AS LONG
    shiftedImage AS LONG
    shiftedHighlightImage AS LONG
    shiftedSelectedImage AS LONG

    reDraw AS LONG

    'key repeat
    lastKeydownTime AS SINGLE
    keyRepeatCount AS LONG
    keyRepeatKeyCode AS LONG

END TYPE

'VK Global Variables
DIM SHARED VK(1000) AS VKEY_TYPE
DIM SHARED VkLast

DIM SHARED VkEmpty AS VKEY_TYPE
VkEmpty.label = ""

DIM SHARED VkHide: VkHide = 1

DIM SHARED VkUnitStepY: VkUnitStepY = 6
DIM SHARED VkNewKeySize: VkNewKeySize = 6
DIM SHARED VkDefaultWidth: VkDefaultWidth = 6
DIM SHARED VkLastSelectionPage: VkLastSelectionPage = 1
DIM SHARED VkUnitSize 'size of a unit in pixels (floating point)

DIM SHARED VkDefaultSelectKeyPage: VkDefaultSelectKeyPage = 1
DIM SHARED VkFont
DIM SHARED VkFontSmall
DIM SHARED VkKeyNameLookup AS LONG
DIM SHARED VkKeyCodeLookup AS LONG
VkAddKeyNames

'fonts are loaded on startup, not all sizes are available and the system will
'find/use the best match
DIM SHARED vkFonts(1000) AS LONG
DIM SHARED vkFontAllow(1000) AS LONG
vkFontAllow(8)=1
vkFontAllow(9)=1
vkFontAllow(10)=1
vkFontAllow(11)=1
vkFontAllow(12)=1
vkFontAllow(14)=1
vkFontAllow(16)=1
vkFontAllow(18)=1
vkFontAllow(20)=1
vkFontAllow(24)=1
vkFontAllow(28)=1
vkFontAllow(32)=1
vkFontAllow(36)=1
vkFontAllow(48)=1
vkFontAllow(72)=1
vkFontAllow(100)=1

DIM SHARED VkBgTex
DIM SHARED VkBorderTex
DIM SHARED VkInternalBgTex
DIM SHARED VkInternalBorderTex
DIM SHARED VkClearTex

DIM SHARED VkSelectedKey
DIM SHARED VkAddShiftedKey

DIM SHARED VkWinX
DIM SHARED VkWinY
DIM SHARED VkOverlay 'an image overlayed over the other content
DIM SHARED VkBackbuffer 'backbuffer of overlay

DIM SHARED VkExiting
DIM SHARED VkExited

DIM SHARED VkReset

DIM SHARED VkDelayStartTime AS DOUBLE
DIM SHARED VkDelay AS DOUBLE
VkDelayStartTime=TIMER(0.001)
VkDelay=1 'programs typically set their screen resolution on start, so wait a second before trying to build a keyboard which matches that resolution
DIM SHARED VkDelayedReset

DIM SHARED VkWidthInUnits

DIM SHARED VkTimer
VkTimer = _FREETIMER

DIM SHARED VkReDraw AS LONG: VkReDraw = 1

DIM SHARED VkDelayUntilFirstRepeat AS SINGLE: VkDelayUntilFirstRepeat = 0.75
DIM SHARED VkDelayUntilFollowingRepeats AS SINGLE: VkDelayUntilFollowingRepeats = 0.025 '40 per sec

TYPE VkRegTypeX
    ax AS INTEGER
    bx AS INTEGER
    cx AS INTEGER
    dx AS INTEGER
    bp AS INTEGER
    si AS INTEGER
    di AS INTEGER
    flags AS INTEGER
    ds AS INTEGER
    es AS INTEGER
END TYPE
DIM SHARED VkReg AS VkRegTypeX

DIM SHARED VkSharedMouseMx AS LONG
DIM SHARED VkSharedMouseMy AS LONG
DIM SHARED VkSharedMouseMb AS LONG

DIM SHARED VkSharedInputMode AS LONG: VkSharedInputMode = -1

ON TIMER(VkTimer, .01) VkUpdate
TIMER(VkTimer) ON

DIM SHARED VkMousePipe AS LONG
DIM SHARED VkMousePipeCapture AS LONG