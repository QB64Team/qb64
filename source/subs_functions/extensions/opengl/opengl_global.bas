TYPE GL_idstruct
    cn AS STRING * 64 'case sensitive version of n
    subfunc AS INTEGER 'if function=1, sub=2
    callname AS STRING * 64
    args AS INTEGER
    arg AS STRING * 80 'similar to t
    ret AS LONG 'the value it returns if it is a function (again like t)
END TYPE
REDIM SHARED GL_COMMANDS(2000) AS GL_idstruct
DIM SHARED GL_HELPER_CODE AS STRING
DIM SHARED GL_COMMANDS_LAST
REDIM SHARED GL_DEFINES(2000) AS STRING 'average ~600 entries
REDIM SHARED GL_DEFINES_VALUE(2000) AS _INTEGER64
DIM SHARED GL_DEFINES_LAST
DIM SHARED GL_KIT: GL_KIT = 0
