DIM SHARED Cache_Folder AS STRING
Cache_Folder$ = "internal\help"
IF _DIREXISTS("internal") = 0 THEN GOTO NoInternalFolder
IF _DIREXISTS(Cache_Folder$) = 0 THEN MKDIR Cache_Folder$
DIM SHARED Help_sx, Help_sy, Help_cx, Help_cy
DIM SHARED Help_Select, Help_cx1, Help_cy1, Help_SelX1, Help_SelX2, Help_SelY1, Help_SelY2
DIM SHARED Help_MSelect
Help_sx = 1: Help_sy = 1: Help_cx = 1: Help_cy = 1
DIM SHARED Help_wx1, Help_wy1, Help_wx2, Help_wy2 'defines the text section of the help window on-screen
DIM SHARED Help_ww, Help_wh 'width & height of text region
DIM SHARED help_h, help_w 'width & height
DIM SHARED Help_Txt$ '[chr][col][link-byte1][link-byte2]
DIM SHARED Help_Txt_Len
DIM SHARED Help_Line$ 'index of first txt element of a line
DIM SHARED Help_Link$ 'the link info [sep][type:]...[sep]
DIM SHARED Help_Link_Sep$: Help_Link_Sep$ = CHR$(13)
DIM SHARED Help_LinkN
DIM SHARED Help_NewLineIndent
DIM SHARED Help_Underline
'Link Types:
' PAGE:wikipagename
DIM SHARED Help_Pos, Help_Wrap_Pos
DIM SHARED Help_BG_Col
DIM SHARED Help_Col_Normal: Help_Col_Normal = 7
DIM SHARED Help_Col_Link: Help_Col_Link = 9
DIM SHARED Help_Col_Bold: Help_Col_Bold = 15
DIM SHARED Help_Col_Italic: Help_Col_Italic = 15
DIM SHARED Help_Col_Section: Help_Col_Section = 8
DIM SHARED Help_Bold, Help_Italic
DIM SHARED Help_LockWrap
REDIM SHARED Help_LineLen(1)
REDIM SHARED Back$(1)
REDIM SHARED Back_Name$(1)
TYPE Help_Back_Type
    sx AS LONG
    sy AS LONG
    cx AS LONG
    cy AS LONG
END TYPE
REDIM SHARED Help_Back(1) AS Help_Back_Type
Back$(1) = "QB64 Help Menu"
Back_Name$(1) = Back2BackName$(Back$(1))
Help_Back(1).sx = 1: Help_Back(1).sy = 1: Help_Back(1).cx = 1: Help_Back(1).cy = 1
DIM SHARED Help_Back_Pos
Help_Back_Pos = 1
DIM SHARED Help_Search_Time AS DOUBLE
DIM SHARED Help_Search_Str AS STRING
DIM SHARED Help_PageLoaded AS STRING
DIM SHARED Help_Recaching, Help_IgnoreCache
