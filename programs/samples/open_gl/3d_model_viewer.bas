CHDIR "programs\samples\open_gl"

' This example shows how models with textures or materials can be displayed with OpenGL using QB64
'
'IMPORTANT:
' Whilst the .X file loader is optimized for speed, it is very incomplete:
'  -only .X files in text file format
'  -only one object, not a cluster of objects
'  -if using a texture, use a single texture which will be applied to all materials
'  -all the 3D models in this example were exported from Blender, a free 3D creation tool
'   Blender tips: CTRL+J to amalgamate objects, select object to export first, in the UV/image-editor
'                 window you can export the textures built into your .blend file, apply the decimate
'                 modifier to reduce your polygon count to below 10000, preferably ~3000 or less
' This program is not a definitive guide to OpenGL in any way
' The GLH functions are something I threw together to stop people crashing their code by making
'  calls to OpenGL with incorrectly sized memory regions. The GLH... prefixed commands are not mandatory or
'  part of QB64, nor do they represent a complete library of helper commands.
' Lighting is not this example's strongest point, there's probably some work to do on light positioning
'  and vertex normals
'
'Finally, I hope you enjoy this program as much as I enjoyed piecing it together,
' Galleon

'###################################### GLH SETUP #############################################

'Used to manage textures
TYPE DONT_USE_GLH_Handle_TYPE
    in_use AS _BYTE
END TYPE

'Used by GLH RGB/etc helper functions
DIM SHARED DONT_USE_GLH_COL_RGBA(1 TO 4) AS SINGLE

REDIM SHARED DONT_USE_GLH_Handle(1000) AS DONT_USE_GLH_Handle_TYPE

'.X Format Model Loading Data
TYPE VERTEX_TYPE
    X AS DOUBLE
    Y AS DOUBLE
    Z AS DOUBLE
    NX AS DOUBLE
    NY AS DOUBLE
    NZ AS DOUBLE
END TYPE
REDIM SHARED VERTEX(1) AS VERTEX_TYPE
DIM SHARED VERTICES AS LONG
TYPE FACE_CORNER_TYPE
    V AS LONG 'the vertex index
    TX AS SINGLE 'texture X coordinate
    TY AS SINGLE 'texture Y coordinate
END TYPE
TYPE FACE_TYPE
    V1 AS FACE_CORNER_TYPE
    V2 AS FACE_CORNER_TYPE
    V3 AS FACE_CORNER_TYPE
    Material AS LONG
    Index AS LONG
END TYPE
REDIM SHARED FACE(1) AS FACE_TYPE
DIM SHARED FACES AS LONG
TYPE MATERIAL_RGBAI_TYPE
    R AS SINGLE
    G AS SINGLE
    B AS SINGLE
    A AS SINGLE
    Intensity AS SINGLE
END TYPE
TYPE MATERIAL_TYPE
    Diffuse AS MATERIAL_RGBAI_TYPE 'regular col
    Specular AS MATERIAL_RGBAI_TYPE 'hightlight/shine col
    Texture_Image AS LONG 'both an image and a texture handle are held
    Texture AS LONG 'if 0, there is no texture
END TYPE
REDIM SHARED MATERIAL(1) AS MATERIAL_TYPE
DIM SHARED MATERIALS AS LONG

'##############################################################################################

DIM SHARED AllowSubGL

SCREEN _NEWIMAGE(1024, 768, 32)

backdrop = _LOADIMAGE("backdrop_tron.png")

DIM SHARED rot1
DIM SHARED rot2, rot3
DIM SHARED scale: scale = 1

'Load (default) model
GLH_Load_Model_Format_X "marty.x", "marty_tmap.png"
'draw backdrop
_PUTIMAGE , backdrop: _DONTBLEND: LINE (200, 200)-(500, 500), _RGBA(0, 255, 255, 0), BF: _BLEND

AllowSubGL = 1

DO
    'This is our program's main loop
    _LIMIT 100
    LOCATE 1, 1
    PRINT "Mouse Input:"
    PRINT "{Horizonal Movement}Spin"
    PRINT "{Vertical Movement}Flip"
    PRINT "{Wheel}Scale"
    PRINT
    PRINT "Keyboard comands:"
    PRINT "Switch rendering order: {1}GL behind, {2}GL on top, {3}GL only, good for speed"
    PRINT "Switch/Load model: {A}Zebra, {B}Pig, {C}Car"

    k$ = INKEY$
    IF k$ = "1" THEN _GLRENDER _BEHIND
    IF k$ = "2" THEN _GLRENDER _ONTOP
    IF k$ = "3" THEN _GLRENDER _ONLY


    PRINT "Angles:"; rot1, rot2, rot3


    IF UCASE$(k$) = "A" THEN
        AllowSubGL = 0
        GLH_Load_Model_Format_X "marty.x", "marty_tmap.png"
        _PUTIMAGE , backdrop: _DONTBLEND: LINE (200, 200)-(500, 500), _RGBA(0, 255, 255, 0), BF: _BLEND
        AllowSubGL = 1
    END IF

    IF UCASE$(k$) = "B" THEN
        AllowSubGL = 0
        GLH_Load_Model_Format_X "piggy_mini3.x", ""
        _PUTIMAGE , backdrop: _DONTBLEND: LINE (200, 200)-(500, 500), _RGBA(0, 255, 255, 0), BF: _BLEND
        AllowSubGL = 1
    END IF

    IF UCASE$(k$) = "C" THEN
        AllowSubGL = 0
        GLH_Load_Model_Format_X "gasprin.x", "gasprin_tmap.png"
        _PUTIMAGE , backdrop: _DONTBLEND: LINE (200, 200)-(500, 500), _RGBA(0, 255, 255, 0), BF: _BLEND
        AllowSubGL = 1
    END IF

    DO WHILE _MOUSEINPUT
        scale = scale * (1 - (_MOUSEWHEEL * .1))
        rot1 = _MOUSEX
        rot2 = _MOUSEY
    LOOP

    IF k$ = "." THEN rot3 = rot3 + 1
    IF k$ = "," THEN rot3 = rot3 - 1




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
    '...
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

_glMatrixMode _GL_MODELVIEW 'Select The Modelview Matrix
_glLoadIdentity 'Reset The Modelview Matrix



'setup our light
_glEnable _GL_LIGHTING
_glEnable _GL_LIGHT0
_glLightfv _GL_LIGHT0, _GL_DIFFUSE, GLH_RGB(.8, .8, .8)
_glLightfv _GL_LIGHT0, _GL_AMBIENT, GLH_RGB(0.1, 0.1, 0.1)
_glLightfv _GL_LIGHT0, _GL_SPECULAR, GLH_RGB(0.3, 0.3, 0.3)

light_rot = light_rot + ET#
_glLightfv _GL_LIGHT0, _GL_POSITION, GLH_RGBA(SIN(light_rot) * 20, COS(light_rot) * 20, 20, 1)


_glTranslatef 0, 0, -20 'Translate Into The Screen
_glRotatef rot1, 0, 1, 0
_glRotatef rot2, 1, 0, 0
_glRotatef rot3, 0, 0, 1



current_m = -1
FOR F = 1 TO FACES

    m = FACE(F).Material
    IF m <> current_m THEN 'we don't switch materials unless we have to
        IF current_m <> -1 THEN _glEnd 'stop rendering triangles so we can change some settings
        current_m = m
        IF MATERIAL(m).Texture_Image THEN

            _glEnable _GL_TEXTURE_2D
            _glDisable _GL_COLOR_MATERIAL
            _glTexParameteri _GL_TEXTURE_2D, _GL_TEXTURE_MAG_FILTER, _GL_LINEAR 'seems these need to be respecified
            _glTexParameteri _GL_TEXTURE_2D, _GL_TEXTURE_MIN_FILTER, _GL_LINEAR


            IF MATERIAL(m).Texture = 0 THEN
                MATERIAL(m).Texture = GLH_Image_to_Texture(MATERIAL(m).Texture_Image)
            END IF
            GLH_Select_Texture MATERIAL(m).Texture

            _glMaterialfv _GL_FRONT, _GL_DIFFUSE, GLH_RGBA(1, 1, 1, 1)

        ELSE
            'use materials, disable textures
            _glDisable _GL_TEXTURE_2D
            _glDisable _GL_COLOR_MATERIAL

            mult = MATERIAL(m).Diffuse.Intensity 'otherwise known as "power"
            r = MATERIAL(m).Diffuse.R * mult
            g = MATERIAL(m).Diffuse.G * mult
            b = MATERIAL(m).Diffuse.B * mult
            '            _glColor3f r, g, b
            _glMaterialfv _GL_FRONT, _GL_DIFFUSE, GLH_RGBA(r, g, b, 1)

            mult = MATERIAL(m).Specular.Intensity
            r = MATERIAL(m).Specular.R * mult
            g = MATERIAL(m).Specular.G * mult
            b = MATERIAL(m).Specular.B * mult
            _glMaterialfv _GL_FRONT, _GL_SPECULAR, GLH_RGBA(r, g, b, 1)

        END IF

        _glBegin _GL_TRIANGLES

    END IF

    FOR s = 1 TO 3

        IF s = 1 THEN v = FACE(F).V1.V
        IF s = 2 THEN v = FACE(F).V2.V
        IF s = 3 THEN v = FACE(F).V3.V
        v = v + 1

        'vertex
        x = (VERTEX(v).X + 0) * scale
        y = (VERTEX(v).Y + 0) * scale
        z = (VERTEX(v).Z + 0) * scale
        'normal direction from vertex
        nx = VERTEX(v).NX: ny = VERTEX(v).NY: nz = VERTEX(v).NZ


        'corner's texture coordinates
        IF MATERIAL(m).Texture THEN
            IF s = 1 THEN tx = FACE(F).V1.TX: ty = FACE(F).V1.TY
            IF s = 2 THEN tx = FACE(F).V2.TX: ty = FACE(F).V2.TY
            IF s = 3 THEN tx = FACE(F).V3.TX: ty = FACE(F).V3.TY
            _glTexCoord2f tx, ty
        END IF

        _glNormal3d nx, my, nz
        _glVertex3f x, y, z

    NEXT

NEXT
_glEnd

END SUB



'QB64 OPEN-GL HELPER MACROS (aka. GLH macros) #######################################################################

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




SUB GLH_Load_Model_Format_X (Filename$, Optional_Texture_Filename$)

_AUTODISPLAY 'so loading messages can be seen

DEFLNG A-Z

IF LEN(Optional_Texture_Filename$) THEN
    texture_image = _LOADIMAGE(Optional_Texture_Filename$, 32)
    IF texure_image = -1 THEN texure_image = 0
END IF

'temporary arrays
DIM SIDE_LIST(10000) AS LONG 'used for wrangling triangle-fans/triangle-strips
REDIM TEXCO_TX(1) AS SINGLE
REDIM TEXCO_TY(1) AS SINGLE
REDIM POLY_FACE_INDEX_FIRST(1) AS LONG
REDIM POLY_FACE_INDEX_LAST(1) AS LONG

'buffer file
fh = FREEFILE: OPEN Filename$ FOR BINARY AS #fh: file_data$ = SPACE$(LOF(fh)): GET #fh, , file_data$: CLOSE #fh

file_x = 1
file_data$ = UCASE$(file_data$)

ASC_COMMA = 44
ASC_SEMICOLON = 59
ASC_LBRAC = 123
ASC_RBRAC = 125
ASC_SPACE = 32
ASC_TAB = 9
ASC_CR = 13
ASC_LF = 10
ASC_FSLASH = 47
ASC_DOT = 46
ASC_MINUS = 45

DIM WhiteSpace(255) AS LONG
WhiteSpace(ASC_LF) = -1
WhiteSpace(ASC_CR) = -1
WhiteSpace(ASC_SPACE) = -1
WhiteSpace(ASC_TAB) = -1

DIM FormattingCharacter(255) AS LONG
FormattingCharacter(ASC_COMMA) = -1
FormattingCharacter(ASC_SEMICOLON) = -1
FormattingCharacter(ASC_LBRAC) = -1
FormattingCharacter(ASC_RBRAC) = -1

DIM Numeric(255) AS LONG
FOR a = 48 TO 57
    Numeric(a) = -1
NEXT
Numeric(ASC_DOT) = -1
Numeric(ASC_MINUS) = -1

PRINT "Loading model:"

DO

    skip_comment:

    'find start of element
    x1 = -1
    FOR x = file_x TO LEN(file_data$)
        IF WhiteSpace(ASC(file_data$, x)) = 0 THEN x1 = x: EXIT FOR
    NEXT
    IF x1 = -1 THEN EXIT DO 'no more data

    a = ASC(file_data$, x1)
    IF a = ASC_FSLASH THEN 'commend
        IF ASC(file_data$, x1 + 1) = ASC_FSLASH THEN
            FOR x = x1 TO LEN(file_data$)
                a = ASC(file_data$, x)
                IF a = ASC_CR OR a = ASC_LF THEN file_x = x + 1: GOTO skip_comment '//.....
            NEXT
        END IF
    END IF

    'find end of element
    x2 = x1
    FOR x = x1 TO LEN(file_data$)
        a = ASC(file_data$, x)
        IF WhiteSpace(a) THEN
            IF a = ASC_CR OR a = ASC_LF THEN EXIT FOR 'it is the end
        ELSE
            'not whitespace
            IF FormattingCharacter(a) THEN EXIT FOR
            x2 = x
        END IF
    NEXT
    file_x = x2 + 1

    a2$ = MID$(file_data$, x1, x2 - x1 + 1)

    IF LEN(skip_until$) THEN
        IF a2$ <> skip_until$ THEN GOTO skip_comment
        skip_until$ = ""
    END IF



    a = ASC(a2$)

    IF Numeric(a) AND a <> ASC_DOT THEN 'faster than VAL, value conversion
        v = 0
        dp = 0
        div = 1
        IF a = ASC_MINUS THEN neg = 1: x1 = 2 ELSE neg = 0: x1 = 1
        FOR x = x1 TO LEN(a2$)
            a2 = ASC(a2$, x)
            IF a2 = ASC_DOT THEN
                dp = 1
            ELSE
                v = v * 10 + (a2 - 48)
                IF dp THEN div = div * 10
            END IF
        NEXT

        IF dp = 1 THEN
            v# = v
            div# = div
            IF neg THEN value# = (-v#) / div# ELSE value# = v# / div#
        ELSE
            IF neg THEN value# = -v ELSE value# = v
        END IF

    END IF

    IF face_input THEN
        IF face_input = 3 THEN
            IF a2$ = ";" THEN
                IF last_a2$ = ";" THEN face_input = 0
                SLI = SLI + 1
            ELSEIF a2$ = "," THEN
                face_input = 2
                polygon = polygon + 1
            ELSE
                SIDE_LIST(SLI) = value#
                IF SLI >= 3 THEN
                    FACES = FACES + 1
                    IF FACES > UBOUND(FACE) THEN REDIM _PRESERVE FACE(UBOUND(FACE) * 2) AS FACE_TYPE
                    FACE(FACES).V1.V = SIDE_LIST(1)
                    FACE(FACES).V2.V = SIDE_LIST(SLI - 1)
                    FACE(FACES).V3.V = SIDE_LIST(SLI)
                    IF POLY_FACE_INDEX_FIRST(polygon) = 0 THEN POLY_FACE_INDEX_FIRST(polygon) = FACES
                    POLY_FACE_INDEX_LAST(polygon) = FACES
                    FACE(FACES).Index = polygon
                END IF

                file_x = file_x + 1: a2$ = ";": a = ASC_SEMICOLON: SLI = SLI + 1


            END IF
            GOTO done
        END IF
        IF face_input = 2 THEN
            SIDES = value#
            SLI = 0
            face_input = 3
            GOTO done
        END IF
        IF face_input = 1 THEN
            POLYGONS = value#
            REDIM _PRESERVE FACE(POLYGONS * 4) AS FACE_TYPE 'estimate triangles in polygons
            REDIM POLY_FACE_INDEX_FIRST(POLYGONS) AS LONG
            REDIM POLY_FACE_INDEX_LAST(POLYGONS) AS LONG
            polygon = 1
            face_input = 2
            FACES = 0
            GOTO done
        END IF
    END IF

    IF mesh_input THEN
        IF mesh_input = 5 THEN
            IF a = ASC_SEMICOLON THEN
                mesh_input = 0: face_input = 1
                IF normals_input = 1 THEN
                    face_input = 0 'face input is unrequired on 2nd pass
                    skip_until$ = "MESHMATERIALLIST"
                END IF
            END IF
            GOTO done
        END IF
        IF mesh_input = 4 THEN
            IF a = ASC_SEMICOLON THEN
                'ignore
            ELSEIF a = ASC_COMMA THEN
                vertex = vertex + 1
            ELSE
                IF normals_input = 1 THEN
                    IF plane = 1 THEN VERTEX(vertex).NX = value#
                    IF plane = 2 THEN VERTEX(vertex).NY = value#
                    IF plane = 3 THEN VERTEX(vertex).NZ = value#
                ELSE
                    IF plane = 1 THEN VERTEX(vertex).X = value#
                    IF plane = 2 THEN VERTEX(vertex).Y = value#
                    IF plane = 3 THEN VERTEX(vertex).Z = value#
                END IF

                plane = plane + 1
                IF plane = 4 THEN
                    plane = 1
                    IF vertex = VERTICES THEN mesh_input = 5
                END IF

                file_x = file_x + 1 'skip next character (semicolon)

            END IF
            GOTO done
        END IF
        IF mesh_input = 3 THEN
            IF a2$ = ";" THEN mesh_input = 4
            GOTO done
        END IF
        IF mesh_input = 2 THEN
            VERTICES = value#
            IF normals_input = 0 THEN
                REDIM VERTEX(VERTICES) AS VERTEX_TYPE
                REDIM TEXCO_TX(VERTICES) AS SINGLE
                REDIM TEXCO_TY(VERTICES) AS SINGLE
            END IF
            mesh_input = 3
            GOTO done
        END IF
        IF mesh_input = 1 THEN
            IF a2$ = "{" THEN mesh_input = 2: plane = 1: vertex = 1
            GOTO done
        END IF
        GOTO done
    END IF

    IF matlist_input THEN
        IF matlist_input = 6 THEN
            IF a2$ = "," THEN
                'do nothing
            ELSEIF a2$ = ";" THEN
                matlist_input = 0
            ELSE
                polygon = polygon + 1: m = value#
                FOR f = POLY_FACE_INDEX_FIRST(polygon) TO POLY_FACE_INDEX_LAST(polygon)
                    FACE(f).Material = m + 1
                NEXT
            END IF
            GOTO done
        END IF
        IF matlist_input = 5 AND a2$ = ";" THEN matlist_input = 6: polygon = 0: face_search_start = 1: GOTO done
        IF matlist_input = 4 THEN matlist_input = 5: GOTO done
        IF matlist_input = 3 AND a2$ = ";" THEN matlist_input = 4: GOTO done
        IF matlist_input = 2 THEN MATERIALS = value#: REDIM MATERIAL(MATERIALS) AS MATERIAL_TYPE: matlist_input = 3: GOTO done
        IF matlist_input = 1 AND a2$ = "{" THEN matlist_input = 2: GOTO done
        GOTO done
    END IF

    IF material_input THEN
        IF material_input = 2 THEN
            IF a2$ = ";" THEN
                'do nothing
            ELSEIF a2$ = "}" THEN
                material_input = 0
            ELSE
                N = material_n
                IF N = 1 THEN MATERIAL(MATERIAL).Diffuse.R = value#
                IF N = 2 THEN MATERIAL(MATERIAL).Diffuse.G = value#
                IF N = 3 THEN MATERIAL(MATERIAL).Diffuse.B = value#
                IF N = 4 THEN MATERIAL(MATERIAL).Diffuse.A = value#
                IF N = 5 THEN MATERIAL(MATERIAL).Diffuse.Intensity = value# / 100
                IF N = 6 THEN MATERIAL(MATERIAL).Specular.R = value#
                IF N = 7 THEN MATERIAL(MATERIAL).Specular.G = value#
                IF N = 8 THEN MATERIAL(MATERIAL).Specular.B = value#
                IF N = 9 THEN MATERIAL(MATERIAL).Specular.A = value#
                IF N = 10 THEN MATERIAL(MATERIAL).Specular.Intensity = MATERIAL(MATERIAL).Diffuse.Intensity

                'if texture_image
                material_n = N + 1

            END IF
            GOTO done
        END IF
        IF material_input = 1 AND a2$ = "{" THEN material_input = 2: material_n = 1: GOTO done
        GOTO done
    END IF

    IF texco_input THEN
        IF texco_input = 4 THEN
            IF a2$ = ";" THEN
                IF last_a2$ = ";" THEN
                    texco_input = 0
                    GOTO finished
                END IF
                plane = plane + 1: IF plane = 3 THEN plane = 1
            ELSEIF a2$ = "," THEN
                vertex = vertex + 1
            ELSE
                IF plane = 1 THEN
                    TEXCO_TX(vertex) = value#
                ELSE
                    TEXCO_TY(vertex) = value#
                END IF
            END IF
            GOTO done
        END IF
        IF texco_input = 3 THEN
            IF a2$ = ";" THEN texco_input = 4: plane = 1: vertex = 1
            GOTO done
        END IF
        IF texco_input = 2 THEN
            'vertices already known
            texco_input = 3
            GOTO done
        END IF
        IF texco_input = 1 THEN
            IF a2$ = "{" THEN texco_input = 2
            GOTO done
        END IF

        GOTO done
    END IF

    'mode switch?
    IF a2$ = "MESHTEXTURECOORDS" THEN texco_input = 1: PRINT "[Texture Coordinates]";: GOTO done
    IF a2$ = "MESHNORMALS" THEN normals_input = 1: mesh_input = 1: face_input = 0: PRINT "[Normals]";: GOTO done
    IF a2$ = "MESH" THEN mesh_input = 1: PRINT "[Mesh Vertices & Faces]";: GOTO done
    IF a2$ = "MESHMATERIALLIST" THEN matlist_input = 1: PRINT "[Face Material Indexes]";: GOTO done
    IF LEFT$(a2$, 9) = "MATERIAL " THEN
        material_input = 1: MATERIAL = MATERIAL + 1
        MATERIAL(MATERIAL).Texture = 0: MATERIAL(MATERIAL).Texture_Image = texture_image
        PRINT "[Material]";: GOTO done
    END IF
    done:

    progress = progress + 1: IF progress > 5000 THEN PRINT ".";: progress = 0

    IF a = ASC_SEMICOLON THEN
        last_a2$ = a2$
    ELSE
        IF LEN(last_a2$) THEN last_a2$ = ""
    END IF

LOOP
finished:
'change texture coords (with are organised per vertex to be organised by face side
'that way one vertex can share multiple materials without duplicating the vertex
PRINT "[Attaching Texture Coordinates to Face Cornders]";
f = 1
DO UNTIL f > FACES
    v = FACE(f).V1.V + 1: FACE(f).V1.TX = TEXCO_TX(v): FACE(f).V1.TY = TEXCO_TY(v)
    v = FACE(f).V2.V + 1: FACE(f).V2.TX = TEXCO_TX(v): FACE(f).V2.TY = TEXCO_TY(v)
    v = FACE(f).V3.V + 1: FACE(f).V3.TX = TEXCO_TX(v): FACE(f).V3.TY = TEXCO_TY(v)
    f = f + 1
LOOP
PRINT
PRINT "Model loaded!"

DEFSNG A-Z

END SUB

FUNCTION GLH_RGB%& (r AS SINGLE, g AS SINGLE, b AS SINGLE)
DONT_USE_GLH_COL_RGBA(1) = r
DONT_USE_GLH_COL_RGBA(2) = g
DONT_USE_GLH_COL_RGBA(3) = b
DONT_USE_GLH_COL_RGBA(4) = 1
GLH_RGB = _OFFSET(DONT_USE_GLH_COL_RGBA())
END FUNCTION

FUNCTION GLH_RGBA%& (r AS SINGLE, g AS SINGLE, b AS SINGLE, a AS SINGLE)
DONT_USE_GLH_COL_RGBA(1) = r
DONT_USE_GLH_COL_RGBA(2) = g
DONT_USE_GLH_COL_RGBA(3) = b
DONT_USE_GLH_COL_RGBA(4) = a
GLH_RGBA = _OFFSET(DONT_USE_GLH_COL_RGBA())
END FUNCTION



