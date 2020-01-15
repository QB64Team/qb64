FUNCTION gl2qb_type_convert$ (a$, symbol$, typ, ctyp$)
    symbol$ = ""

    'unsigned int
    IF a$ = "GLenum" THEN b$ = "_UNSIGNED LONG": symbol$ = "~&": typ = ULONGTYPE - ISPOINTER: ctyp$ = "uint32"
    IF a$ = "GLbitfield" THEN b$ = "_UNSIGNED LONG": symbol$ = "~&": typ = ULONGTYPE - ISPOINTER: ctyp$ = "uint32"
    IF a$ = "GLuint" THEN b$ = "_UNSIGNED LONG": symbol$ = "~&": typ = ULONGTYPE - ISPOINTER: ctyp$ = "uint32"

    'int
    IF a$ = "GLint" THEN b$ = "LONG": symbol$ = "&": typ = LONGTYPE - ISPOINTER: ctyp$ = "int32"
    IF a$ = "GLsizei" THEN b$ = "LONG": symbol$ = "&": typ = LONGTYPE - ISPOINTER: ctyp$ = "int32"

    'unsigned char
    IF a$ = "GLboolean" THEN b$ = "_UNSIGNED _BYTE": symbol$ = "~%%": typ = UBYTETYPE - ISPOINTER: ctyp$ = "uint8"
    IF a$ = "GLubyte" THEN b$ = "_UNSIGNED _BYTE": symbol$ = "~%%": typ = UBYTETYPE - ISPOINTER: ctyp$ = "uint8"

    'char
    IF a$ = "GLbyte" THEN b$ = "_BYTE": symbol$ = "%%": typ = BYTETYPE - ISPOINTER: ctyp$ = "int8"

    'unsigned short
    IF a$ = "GLushort" THEN b$ = "_UNSIGNED INTEGER": symbol$ = "~%": typ = UINTEGERTYPE - ISPOINTER: ctyp$ = "uint16"

    'short
    IF a$ = "GLshort" THEN b$ = "INTEGER": symbol$ = "%": typ = INTEGERTYPE - ISPOINTER: ctyp$ = "int16"

    'float
    IF a$ = "GLfloat" THEN b$ = "SINGLE": symbol$ = "!": typ = SINGLETYPE - ISPOINTER: ctyp$ = "float"
    IF a$ = "GLclampf" THEN b$ = "SINGLE": symbol$ = "!": typ = SINGLETYPE - ISPOINTER: ctyp$ = "float"

    'double
    IF a$ = "GLdouble" THEN b$ = "DOUBLE": symbol$ = "#": typ = DOUBLETYPE - ISPOINTER: ctyp$ = "double"
    IF a$ = "GLclampd" THEN b$ = "DOUBLE": symbol$ = "#": typ = DOUBLETYPE - ISPOINTER: ctyp$ = "double"

    'void
    IF a$ = "GLvoid" THEN b$ = "_OFFSET": symbol$ = "%&": typ = OFFSETTYPE - ISPOINTER: ctyp$ = "ptrszint"

    'typedef unsigned int GLenum;
    'typedef unsigned char GLboolean;
    'typedef unsigned int GLbitfield;
    'typedef signed char GLbyte;
    'typedef short GLshort;
    'typedef int GLint;
    'typedef int GLsizei;
    'typedef unsigned char GLubyte;
    'typedef unsigned short GLushort;
    'typedef unsigned int GLuint;
    'typedef float GLfloat;
    'typedef float GLclampf;
    'typedef double GLdouble;
    'typedef double GLclampd;
    'typedef void GLvoid;

    IF b$ = "" THEN PRINT "Unknown type:" + a$: END
    gl2qb_type_convert$ = b$
END FUNCTION

FUNCTION readchunk$ (a$, last_character$)
    a$ = LTRIM$(RTRIM$(a$))
    FOR x = 1 TO LEN(a$)
        c = ASC(a$, x)
        IF c = 32 OR c = 44 OR c = 40 OR c = 41 THEN last_character$ = CHR$(c): readchunk$ = LEFT$(a$, x - 1): a$ = LTRIM$(RIGHT$(a$, LEN(a$) - x)): EXIT FUNCTION
    NEXT
    readchunk$ = a$: last_character$ = "": a$ = ""
END FUNCTION


SUB gl_scan_header

    IF GL_KIT THEN hk = FREEFILE: OPEN "internal\c\parts\core\gl_header_for_parsing\temp\gl_kit.bas" FOR OUTPUT AS #hk
    IF GL_KIT THEN PRINT #hk, "DECLARE LIBRARY"

    d = 0: a2$ = ""
    h = FREEFILE
    OPEN "internal\c\parts\core\gl_header_for_parsing\gl.h" FOR BINARY AS #h
    DO UNTIL EOF(h)
        LINE INPUT #h, a$
        IF LEN(a$) THEN
            a$ = LTRIM$(RTRIM$(a$))
            IF LEFT$(a$, 8) = "#define " THEN
                a2$ = ""
                a$ = a$ + " "
                FOR x = 1 TO LEN(a$)
                    c = ASC(a$, x)
                    IF c = 32 THEN
                        FOR x2 = 1 TO LEN(a2$)
                            c2 = ASC(a2$, x2)
                            IF c2 >= 65 AND c2 <= 90 THEN GOTO define_ok
                            IF c2 >= 48 AND c2 <= 57 AND x2 <> 1 THEN GOTO define_ok
                            IF c2 = 95 THEN GOTO define_ok
                            GOTO define_not_ok
                            define_ok:
                        NEXT
                        value$ = LTRIM$(RTRIM$(RIGHT$(a$, LEN(a$) - x)))
                        IF LEN(value$) = 0 THEN GOTO define_not_ok

                        IF LEFT$(value$, 2) = "0x" THEN
                            value&& = VAL("&H" + RIGHT$(value$, LEN(value$) - 2) + "&&")
                            'PRINT a2$, value&&
                            d = d + 1: GL_DEFINES(d) = a2$: GL_DEFINES_VALUE(d) = value&&
                        ELSEIF ASC(value$) >= 48 AND ASC(value$) <= 57 THEN
                            value&& = VAL(value$)
                            'PRINT a2$, value&&
                            d = d + 1: GL_DEFINES(d) = a2$: GL_DEFINES_VALUE(d) = value&&
                        ELSE
                            'PRINT a2$, value$, "?"
                            FOR i = 1 TO d
                                IF GL_DEFINES(i) = value$ THEN
                                    d = d + 1: GL_DEFINES(d) = a2$: GL_DEFINES_VALUE(d) = GL_DEFINES_VALUE(i)
                                    'PRINT a2$, GL_DEFINES_VALUE(i)
                                    EXIT FOR
                                END IF
                            NEXT
                        END IF
                        GOTO got_define
                        define_not_ok:
                        a2$ = ""
                    ELSE
                        a2$ = a2$ + CHR$(c)
                    END IF
                NEXT
                got_define:
            END IF '#define


            IF RIGHT$(a$, 1) = ";" THEN
                a2$ = readchunk(a$, l$): IF a2$ <> "WINGDIAPI" GOTO discard
                ret_type$ = readchunk(a$, l$)
                IF ret_type$ = "const" THEN ret_type$ = readchunk(a$, l$)

                is_func = 0: IF ret_type$ <> "void" THEN is_func = 1

                a2$ = readchunk(a$, l$)
                IF a2$ = "*APIENTRY" THEN ret_type$ = ret_type$ + "*": a2$ = "APIENTRY"
                IF a2$ <> "APIENTRY" THEN GOTO discard

                GL_COMMANDS_LAST = GL_COMMANDS_LAST + 1
                c = GL_COMMANDS_LAST

                hc$ = ""
                hd$ = ""
                need_helper_function = 0

                IF is_func THEN
                    GL_COMMANDS(c).subfunc = 1
                    IF GL_KIT THEN PRINT #hk, "FUNCTION ";
                ELSE
                    GL_COMMANDS(c).subfunc = 2
                    IF GL_KIT THEN PRINT #hk, "SUB ";
                END IF

                proc_name$ = readchunk(a$, l$)

                GL_COMMANDS(c).cn = "_" + proc_name$: IF GL_KIT THEN PRINT #hk, proc_name$;
                GL_COMMANDS(c).callname = proc_name$

                GL_COMMANDS(c).ret = 0
                IF is_func THEN
                    pointer = 0: IF RIGHT$(ret_type$, 1) = "*" THEN pointer = 1
                    IF pointer THEN
                        t$ = "_OFFSET": s$ = "&&"
                        GL_COMMANDS(c).ret = OFFSETTYPE - ISPOINTER
                        hd$ = hd$ + "ptrszint "
                        need_helper_function = 1
                    ELSE
                        t$ = gl2qb_type_convert(ret_type$, s$, typ, ctyp$)
                        GL_COMMANDS(c).ret = typ
                        hd$ = hd$ + ctyp$ + " "
                    END IF
                    IF GL_KIT THEN PRINT #hk, s$;
                    hc$ = hc$ + "return (" + ctyp$ + ")(" + ret_type$ + ")"
                ELSE
                    hd$ = hd$ + "void "
                END IF

                IF GL_KIT THEN PRINT #hk, "(";

                hc$ = hc$ + proc_name$ + "("
                hd$ = hd$ + "call_" + proc_name$ + "("


                GL_COMMANDS(c).args = 0
                GL_COMMANDS(c).arg = ""

                DO

                    var_type$ = readchunk(a$, l$)
                    IF var_type$ = "" AND l$ = "(" THEN var_type$ = readchunk(a$, l$) 'space between fun name and "("?
                    IF var_type$ = "const" THEN var_type$ = readchunk(a$, l$)
                    IF var_type$ = "void" OR var_type$ = "" THEN GOTO no_arguments
                    IF l$ <> "," AND l$ <> ")" THEN
                        var_name$ = readchunk(a$, l$)
                        IF LEFT$(var_name$, 1) = "*" THEN var_type$ = var_type$ + "*": var_name$ = RIGHT$(var_name$, LEN(var_name$) - 1)
                        IF LEFT$(var_name$, 1) = "*" THEN var_type$ = var_type$ + "*": var_name$ = RIGHT$(var_name$, LEN(var_name$) - 1)
                        'Note: could be a poiner to a pointer
                    ELSE
                        var_name$ = "no_name"
                    END IF

                    var_type_backup$ = var_type$

                    pointer = 0

                    IF RIGHT$(var_type$, 1) = "*" THEN
                        var_type$ = LEFT$(var_type$, LEN(var_type$) - 1)
                        pointer = 1
                    END IF
                    IF RIGHT$(var_type$, 1) = "*" THEN
                        var_type$ = LEFT$(var_type$, LEN(var_type$) - 1)
                        pointer = 2
                    END IF

                    IF pointer = 2 THEN
                        qb_type$ = "_OFFSET" 'it's the offset of an offset
                    ELSE
                        qb_type$ = gl2qb_type_convert$(var_type$, s$, typ, ctyp$)
                    END IF

                    'IF pointer THEN need_helper_function = 1
                    need_helper_function = 1

                    IF GL_KIT THEN
                        IF pointer = 0 THEN PRINT #hk, "BYVAL ";
                        PRINT #hk, var_name$ + " AS " + qb_type$;
                        IF l$ <> ")" THEN PRINT #hk, ",";
                    END IF

                    IF pointer = 0 THEN
                        arg$ = MKL$(typ)
                    END IF
                    IF pointer = 1 THEN 'all pointers convert to BYVAL _OFFSET
                        arg$ = MKL$(OFFSETTYPE - ISPOINTER)
                        ctyp$ = "ptrszint"
                    END IF
                    IF pointer = 2 THEN 'all pointers-to-pointers convert to xxx"BYREF"xxx BYVAL _OFFSET
                        arg$ = MKL$(OFFSETTYPE - ISPOINTER)
                        ctyp$ = "ptrszint"
                        '***this is important or you lose the ability to specify any offset, only the offset of a variable of type
                        '   _OFFSET
                        '                   arg$ = MKL$(OFFSETTYPE)
                        '                    ctyp$ = "ptrszint*"
                    END IF

                    GL_COMMANDS(c).args = GL_COMMANDS(c).args + 1

                    MID$(GL_COMMANDS(c).arg, (GL_COMMANDS(c).args - 1) * 4 + 1, 4) = arg$
                    'z$ = GL_COMMANDS(c).arg
                    'MID$(z$, (GL_COMMANDS(c).args - 1) * 4 + 1, 4) = arg$
                    'GL_COMMANDS(c).arg = z$

                    letter$ = CHR$(96 + GL_COMMANDS(c).args)

                    hc$ = hc$ + "(" + var_type_backup$ + ")" + letter$
                    hd$ = hd$ + ctyp$ + " " + letter$



                    IF l$ <> ")" THEN hc$ = hc$ + ",": hd$ = hd$ + ","

                LOOP UNTIL l$ = ")"
                no_arguments:


                hd$ = hd$ + "){"
                hc$ = hc$ + ");"
                IF GL_KIT THEN PRINT #hk, ")"
                h$ = hd$ + CRLF + "if (!sub_gl_called) error(270);" + CRLF + hc$ + CRLF + "}" + CRLF

                IF need_helper_function THEN 'do we need the helper function for this command?
                    GL_HELPER_CODE = GL_HELPER_CODE + h$
                    GL_COMMANDS(c).callname = "call_" + proc_name$
                END IF


                IF proc_name$ = "glGetString" THEN
                    GL_COMMANDS(c).ret = STRINGTYPE
                    GL_COMMANDS(c).callname = "(  char*  )" + RTRIM$(GL_COMMANDS(c).callname)
                END IF




            END IF

        END IF





        discard:
    LOOP
    CLOSE #h

    IF GL_KIT THEN PRINT #hk, "END DECLARE"

    GL_DEFINES_LAST = d
    REDIM _PRESERVE GL_DEFINES(d) AS STRING
    'PRINT "Defines:"; GL_DEFINES_LAST

    REDIM _PRESERVE GL_COMMANDS(GL_COMMANDS_LAST) AS GL_idstruct
    'PRINT "Commands:"; GL_COMMANDS_LAST

    IF GL_KIT THEN
        FOR i = 1 TO GL_DEFINES_LAST
            PRINT #hk, "CONST " + GL_DEFINES(i) + "="; GL_DEFINES_VALUE(i)
        NEXT
    END IF

    'FOR i = 1 TO GL_COMMANDS_LAST
    '    PRINT ".cn="; GL_COMMANDS(i).cn
    '    PRINT ".callname="; GL_COMMANDS(i).callname
    '    PRINT ".subfunc="; GL_COMMANDS(i).subfunc
    '    PRINT ".args="; GL_COMMANDS(i).args
    '    _CONTROLCHR OFF
    '    PRINT ".arg=[" + RTRIM$(GL_COMMANDS(i).arg) + "]"
    '    _CONTROLCHR ON
    '    PRINT ".ret="; GL_COMMANDS(i).ret
    'NEXT

    IF GL_KIT THEN CLOSE #hk


    fh = FREEFILE
    OPEN "internal\c\parts\core\gl_header_for_parsing\temp\gl_helper_code.h" FOR OUTPUT AS #fh
    PRINT #fh, GL_HELPER_CODE
    CLOSE #fh


END SUB

SUB gl_include_content

    'add constants
    FOR d = 1 TO GL_DEFINES_LAST
        'IF ASC(GL_DEFINES(d)) <> 95 THEN
        '    GL_DEFINES(d) = "_" + GL_DEFINES(d)
        'END IF
        constlast = constlast + 1
        IF constlast > constmax THEN
            constmax = constmax * 2
            REDIM _PRESERVE constname(constmax) AS STRING
            REDIM _PRESERVE constcname(constmax) AS STRING
            REDIM _PRESERVE constnamesymbol(constmax) AS STRING 'optional name symbol
            REDIM _PRESERVE consttype(constmax) AS LONG 'variable type number
            REDIM _PRESERVE constinteger(constmax) AS _INTEGER64
            REDIM _PRESERVE constuinteger(constmax) AS _UNSIGNED _INTEGER64
            REDIM _PRESERVE constfloat(constmax) AS _FLOAT
            REDIM _PRESERVE conststring(constmax) AS STRING
            REDIM _PRESERVE constsubfunc(constmax) AS LONG
            REDIM _PRESERVE constdefined(constmax) AS LONG
        END IF
        i = constlast
        constname(i) = qb64prefix$ + GL_DEFINES(d)
        constcname(i) = qb64prefix$ + GL_DEFINES(d)
        constnamesymbol(i) = "&&"
        consttype(i) = INTEGER64TYPE - ISPOINTER
        constinteger(i) = GL_DEFINES_VALUE(d)
        constsubfunc(i) = 0 'global
        constdefined(i) = 1
        'add to hash table
        HashAdd constcname(i), HASHFLAG_CONSTANT, i
    NEXT


    'add subs/functions
    FOR c = 1 TO GL_COMMANDS_LAST
        DIM g AS GL_idstruct
        ' TYPE GL_idstruct
        '     cn AS STRING * 64 'case sensitive version of n
        '     subfunc AS INTEGER 'if function=1, sub=2
        '     callname AS STRING * 64
        '     args AS INTEGER
        '     arg AS STRING * 80 'similar to t
        '     ret AS LONG 'the value it returns if it is a function (again like t)
        ' END TYPE
        g = GL_COMMANDS(c)

        reginternalsubfunc = 1
        clearid
        id.ccall = 1 '*** important for handling string returns correctly ***
        id.n = RTRIM$(g.cn)
        IF qb64prefix_set = 1 THEN id.n = MID$(RTRIM$(g.cn), 2)
        s = g.subfunc
        id.subfunc = s
        id.callname = RTRIM$(g.callname)
        id.args = g.args
        id.arg = g.arg
        id.ret = g.ret
        regid
        reginternalsubfunc = 0
    NEXT

    'add inline function definitions

    'SUB gluPerspective (BYVAL fovy#, BYVAL aspect#, BYVAL zNear#, BYVAL zFar#)
    reginternalsubfunc = 1
    clearid
    id.n = qb64prefix$ + "gluPerspective"
    id.subfunc = 2 'sub
    id.callname = "gluPerspective"
    id.args = 4
    id.arg = MKL$(DOUBLETYPE - ISPOINTER) + MKL$(DOUBLETYPE - ISPOINTER) + MKL$(DOUBLETYPE - ISPOINTER) + MKL$(DOUBLETYPE - ISPOINTER)
    regid
    reginternalsubfunc = 0

END SUB
