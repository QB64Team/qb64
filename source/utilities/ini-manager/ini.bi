'INI Manager
'Fellippe Heitor, 2017-2021 - fellippe@qb64.org - @fellippeheitor

'This file isn't required to be at the top of your programs,
'unless you intend to use OPTION _EXPLICIT

'Global variables declaration
DIM currentIniFileName$
DIM currentIniFileLOF AS _UNSIGNED LONG
DIM IniWholeFile$
DIM IniSectionData$
DIM IniPosition AS _UNSIGNED LONG
DIM IniNewFile$
DIM IniLastSection$
DIM IniLastKey$
DIM IniLF$
DIM IniDisableAutoCommit
DIM IniCODE
DIM IniAllowBasicComments
DIM IniForceReload
DIM IniDisableAddQuotes
