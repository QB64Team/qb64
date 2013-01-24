DIM SHARED AllowSubGL 'we'll set this after we finish our setup immediately below, just in case
'there is anything here (there isn't currently though) that SUB _GL will depend on

TYPE DONT_USE_GLH_Handle_TYPE
    in_use AS _BYTE
END TYPE
REDIM SHARED DONT_USE_GLH_Handle(1000) AS DONT_USE_GLH_Handle_TYPE


SCREEN _NEWIMAGE(1024, 768, 32)


backdrop = _LOADIMAGE("xcom_backdrop.jpg")
_PUTIMAGE , backdrop
_FREEIMAGE backdrop

_DONTBLEND
LINE (200, 200)-(500, 500), _RGBA(0, 255, 255, 0), BF 'create a see-through window (press 1)
_BLEND

AllowSubGL = 1

DO
    'This is our program's main loop
    _LIMIT 100
    LOCATE 1, 1
    c = c + 1: PRINT "Mainloop has done nothing"; c; "times"
    PRINT "Press 1[GL behind], 2[GL on top] or 3[GL only, good for speed] to switch rendering order."
    k$ = INKEY$
    IF k$ = "1" THEN _GLRENDER _BEHIND
    IF k$ = "2" THEN _GLRENDER _ONTOP
    IF k$ = "3" THEN _GLRENDER _ONLY
LOOP UNTIL k$ = CHR$(27)
END

'this specially named sub "_GL" is detected by QB64 and adds support for OpenGL commands
'it is called automatically whenever the underlying software deems an update is possible
'usually/ideally, this is in sync with your monitor's refresh rate
SUB _GL STATIC
'STATIC was used above to make all variables in this sub maintain their values between calls to this sub

IF AllowSubGL = 0 THEN EXIT SUB 'we aren't ready yet!

'timing is everything, we don't know how fast the 3D renderer will call this sub to we use timers to smooth things out
T# = TIMER(0.001)
IF ETT# = 0 THEN ETT# = T#
ET# = T# - ETT#
ETT# = T#

IF sub_gl_called = 0 THEN
    sub_gl_called = 1 'we only need to perform the following code once
    i = _LOADIMAGE("xcom256.png", 32)
    mytex = GLH_Image_to_Texture(i) 'this helper function converts the image to a texture
    _FREEIMAGE i
END IF

'These settings affect how OpenGL will render our content
'!!! THESE SETTINGS ARE TO SHOW HOW ALPHA CAN WORK, BUT IT IS 10x FASTER WHEN ALPHA OPTIONS ARE DISABLED !!!
'*** every setting must be reset because SUB _GL cannot guarantee settings have not changed since last time ***
_glMatrixMode _GL_PROJECTION 'Select The Projection Matrix
_glLoadIdentity 'Reset The Projection Matrix
_gluPerspective 45, _WIDTH(0) / _HEIGHT(0), 1, 100 'QB64 internally supports this GLU command for convenience sake, but does not support GLU
_glEnable _GL_TEXTURE_2D
_glEnable _GL_BLEND
_glBlendFunc _GL_SRC_ALPHA, _GL_ONE_MINUS_SRC_ALPHA 'how alpha values are interpretted
_glEnable _GL_DEPTH_TEST 'use the zbuffer
_glDepthMask _GL_TRUE
_glAlphaFunc _GL_GREATER, 0.5 'dont do anything if alpha isn't greater than 0.5 (or 128)
_glEnable _GL_ALPHA_TEST
_glTexParameteri _GL_TEXTURE_2D, _GL_TEXTURE_MAG_FILTER, _GL_LINEAR
_glTexParameteri _GL_TEXTURE_2D, _GL_TEXTURE_MIN_FILTER, _GL_LINEAR
'**************************************************************************************************************


GLH_Select_Texture mytex

_glMatrixMode _GL_MODELVIEW 'Select The Modelview Matrix
_glLoadIdentity 'Reset The Modelview Matrix
_glTranslatef 0, 0, -10 'Translate Into The Screen

_glRotatef rotation1, 0, 1, 0 'spin, spin, spin...
_glRotatef rotation2, 1, 0, 0

_glBegin _GL_QUADS 'we will be drawing rectangles aka. QUADs
_glTexCoord2f 0, 0: _glVertex3f 0, 0, 4 'the texture position and the position in 3D space of a vertex
_glTexCoord2f 1, 0: _glVertex3f 5, 0, 4
_glTexCoord2f 1, 1: _glVertex3f 5, -5, 4
_glTexCoord2f 0, 1: _glVertex3f 0, -5, 4
_glEnd

RANDOMIZE USING 1 'generate the same set of random numbers each time
_glBegin _GL_TRIANGLES 'the png (almost) only consumes a triangular region of its rectangle
FOR t = 1 TO 10
    _glTexCoord2f 0, 0: _glVertex3f RND * 6 - 3, RND * 6 - 3, RND * 6 - 3
    _glTexCoord2f 1, 0: _glVertex3f RND * 6 - 3, RND * 6 - 3, RND * 6 - 3
    _glTexCoord2f 0.5, 1: _glVertex3f RND * 6 - 3, RND * 6 - 3, RND * 6 - 3
NEXT
_glEnd

rotation1 = rotation1 + 100 * ET#
rotation2 = rotation2 + 200 * ET#

END SUB



'QB64 OPEN-GL HELPER MACROS (aka. GLH macros)

SUB GLH_Select_Texture (texture_handle AS LONG) 'turn an image handle into a texture handle
IF texture_handle < 1 OR texture_handle > UBOUND(DONT_USE_GLH_HANDLE) THEN ERROR 258: EXIT FUNCTION
IF DONT_USE_GLH_Handle(texture_handle).in_use = 0 THEN ERROR 258: EXIT FUNCTION
_glBindTexture _GL_TEXTURE_2D, texture_handle
END SUB

FUNCTION GLH_Image_to_Texture (image_handle AS LONG) 'turn an image handle into a texture handle
IF image_handle >= 0 THEN ERROR 258: EXIT FUNCTION 'don't allow screen pages
DIM m AS _MEM
m = _MEMIMAGE(image_handle)
DIM h AS LONG
h = DONT_USE_GLH_New_Texture_Handle
GLH_Image_to_Texture = h
_glBindTexture _GL_TEXTURE_2D, h
_glTexImage2D _GL_TEXTURE_2D, 0, _GL_RGBA, _WIDTH(image_handle), _HEIGHT(image_handle), 0, &H80E1&&, _GL_UNSIGNED_BYTE, m.OFFSET
_MEMFREE m
END FUNCTION

FUNCTION DONT_USE_GLH_New_Texture_Handle
FOR h = 1 TO UBOUND(DONT_USE_GLH_Handle)
    IF DONT_USE_GLH_Handle(h).in_use = 0 THEN
        DONT_USE_GLH_Handle(h).in_use = 1
        DONT_USE_GLH_New_Texture_Handle = h
        EXIT FUNCTION
    END IF
NEXT
DONT_USE_GLH_Handle(h).in_use = 1
DONT_USE_GLH_New_Texture_Handle = h
REDIM _PRESERVE DONT_USE_GLH_HANDLE(UBOUND(DONT_USE_GLH_HANDLE) * 2)
END FUNCTION
