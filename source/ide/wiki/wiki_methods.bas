FUNCTION Back2BackName$ (a$)
    IF a$ = "Keyword Reference - Alphabetical" THEN Back2BackName$ = "Alphabetical": EXIT FUNCTION
    IF a$ = "Keyword Reference - By usage" THEN Back2BackName$ = "By Usage": EXIT FUNCTION
    IF a$ = "QB64 Help Menu" THEN Back2BackName$ = "Help": EXIT FUNCTION
    IF a$ = "QB64 FAQ" THEN Back2BackName$ = "FAQ": EXIT FUNCTION
    Back2BackName$ = a$
END FUNCTION

FUNCTION Wiki$ (PageName$)
    Help_PageLoaded$ = PageName$
    PageName2$ = PageName$

    DO WHILE INSTR(PageName2$, " ")
        ASC(PageName2$, INSTR(PageName2$, " ")) = 95
    LOOP
    DO WHILE INSTR(PageName2$, "&")
        i = INSTR(PageName2$, "&")
        PageName2$ = LEFT$(PageName2$, i - 1) + "%26" + RIGHT$(PageName2$, LEN(PageName2$) - i)
    LOOP
    DO WHILE INSTR(PageName2$, "/")
        i = INSTR(PageName2$, "/")
        PageName2$ = LEFT$(PageName2$, i - 1) + "%2F" + RIGHT$(PageName2$, LEN(PageName2$) - i)
    LOOP

    'Is this page in the cache?
    IF Help_IgnoreCache = 0 THEN
        IF _FILEEXISTS(Cache_Folder$ + "/" + PageName2$ + ".txt") THEN
            fh = FREEFILE
            OPEN Cache_Folder$ + "/" + PageName2$ + ".txt" FOR BINARY AS #fh
            a$ = SPACE$(LOF(fh))
            GET #fh, , a$
            CLOSE #fh
            chr13 = INSTR(a$, CHR$(13))
            removedchr13 = 0
            DO WHILE chr13 > 0
                removedchr13 = -1
                a$ = LEFT$(a$, chr13 - 1) + MID$(a$, chr13 + 1)
                chr13 = INSTR(a$, CHR$(13))
            LOOP
            IF removedchr13 THEN
                fh = FREEFILE
                OPEN Cache_Folder$ + "/" + PageName2$ + ".txt" FOR OUTPUT AS #fh: CLOSE #fh
                OPEN Cache_Folder$ + "/" + PageName2$ + ".txt" FOR BINARY AS #fh
                PUT #fh, 1, a$
                CLOSE #fh
            END IF
            Wiki$ = a$
            EXIT FUNCTION
        END IF
    END IF

    IF Help_Recaching = 0 THEN
        a$ = "Downloading '" + PageName$ + "' page..."
        IF LEN(a$) > 60 THEN a$ = LEFT$(a$, 57) + STRING$(3, 250)
        IF LEN(a$) < 60 THEN a$ = a$ + SPACE$(60 - LEN(a$))

        COLOR 0, 3: LOCATE idewy + idesubwindow, 2
        PRINT a$;

        PCOPY 3, 0
    END IF

    url$ = "www.qb64.org/wiki/index.php?title=" + PageName2$ + "&action=edit"
    'when fetching from .org, look for name="wpTextbox1">
    s1$ = "name=" + CHR$(34) + "wpTextbox1" + CHR$(34) + ">"
    url2$ = url$
    x = INSTR(url2$, "/")
    IF x THEN url2$ = LEFT$(url$, x - 1)
    c = _OPENCLIENT("TCP/IP:80:" + url2$)
    IF c = 0 THEN
        EXIT FUNCTION
    END IF
    e$ = CHR$(13) + CHR$(10)
    url3$ = RIGHT$(url$, LEN(url$) - x + 1)
    x$ = "GET " + url3$ + " HTTP/1.1" + e$
    x$ = x$ + "Host: " + url2$ + e$ + e$
    PUT #c, , x$
    t! = TIMER

    DO
        GET #c, , a2$
        IF LEN(a2$) THEN
            a$ = a$ + a2$
            IF INSTR(a$, "</body>") THEN
                CLOSE #c
                s2$ = "</textarea>"
                s1 = INSTR(a$, s1$): IF s1 = 0 THEN EXIT FUNCTION
                s1 = s1 + LEN(s1$)
                s2 = INSTR(a$, s2$): IF s2 = 0 THEN EXIT FUNCTION
                s2 = s2 - 1
                IF s1 > s2 THEN EXIT FUNCTION
                a$ = MID$(a$, s1, s2 - s1 + 1)
                fh = FREEFILE
                E = 0
                ON ERROR GOTO qberror_test
                OPEN Cache_Folder$ + "/" + PageName2$ + ".txt" FOR OUTPUT AS #fh 'clear old content
                ON ERROR GOTO qberror
                IF E = 0 THEN
                    CLOSE #fh
                    ON ERROR GOTO qberror_test
                    OPEN Cache_Folder$ + "/" + PageName2$ + ".txt" FOR BINARY AS #fh
                    ON ERROR GOTO qberror
                    IF E = 0 THEN
                        PUT #fh, , a$
                        CLOSE #fh
                    END IF
                END IF
                Wiki$ = a$
                EXIT FUNCTION
            END IF
        END IF
        _LIMIT 100
    LOOP UNTIL ABS(TIMER - t!) > 20
    CLOSE #c
END FUNCTION

SUB Help_AddTxt (t$, col, link)

    IF t$ = CHR$(13) THEN Help_NewLine: EXIT SUB

    FOR i = 1 TO LEN(t$)

        c = ASC(t$, i)


        IF Help_BG_Col = 0 AND Help_LockWrap = 0 THEN

            'addtxt handles all wrapping issues
            IF c = 32 THEN

                IF Help_Pos = Help_ww THEN Help_NewLine: GOTO special

                Help_Txt_Len = Help_Txt_Len + 1: ASC(Help_Txt$, Help_Txt_Len) = 32
                Help_Txt_Len = Help_Txt_Len + 1: ASC(Help_Txt$, Help_Txt_Len) = col + Help_BG_Col * 16
                Help_Txt_Len = Help_Txt_Len + 1: ASC(Help_Txt$, Help_Txt_Len) = link AND 255
                Help_Txt_Len = Help_Txt_Len + 1: ASC(Help_Txt$, Help_Txt_Len) = link \ 256

                Help_Wrap_Pos = Help_Txt_Len 'pos to backtrack to when wrapping content
                Help_Pos = Help_Pos + 1
                GOTO special
            END IF

            IF Help_Pos > Help_ww THEN
                IF Help_Wrap_Pos THEN 'attempt to wrap
                    'backtrack, insert new line, continue

                    b$ = MID$(Help_Txt$, Help_Wrap_Pos + 1, Help_Txt_Len - Help_Wrap_Pos)

                    Help_Txt_Len = Help_Wrap_Pos

                    Help_NewLine

                    MID$(Help_Txt$, Help_Txt_Len + 1, LEN(b$)) = b$: Help_Txt_Len = Help_Txt_Len + LEN(b$)

                    Help_Pos = Help_Pos + LEN(b$) \ 4
                END IF
            END IF

        END IF 'bg_col=0

        c = ASC(t$, i)
        Help_Txt_Len = Help_Txt_Len + 1: ASC(Help_Txt$, Help_Txt_Len) = c
        Help_Txt_Len = Help_Txt_Len + 1: ASC(Help_Txt$, Help_Txt_Len) = col + Help_BG_Col * 16
        Help_Txt_Len = Help_Txt_Len + 1: ASC(Help_Txt$, Help_Txt_Len) = link AND 255
        Help_Txt_Len = Help_Txt_Len + 1: ASC(Help_Txt$, Help_Txt_Len) = link \ 256

        Help_Pos = Help_Pos + 1
        special:
    NEXT

END SUB

SUB Help_NewLine
    IF Help_Pos > help_w THEN help_w = Help_Pos

    Help_Txt_Len = Help_Txt_Len + 1: ASC(Help_Txt$, Help_Txt_Len) = 13
    Help_Txt_Len = Help_Txt_Len + 1: ASC(Help_Txt$, Help_Txt_Len) = col + Help_BG_Col * 16
    Help_Txt_Len = Help_Txt_Len + 1: ASC(Help_Txt$, Help_Txt_Len) = 0
    Help_Txt_Len = Help_Txt_Len + 1: ASC(Help_Txt$, Help_Txt_Len) = 0

    help_h = help_h + 1
    Help_Line$ = Help_Line$ + MKL$(Help_Txt_Len + 1)
    Help_Wrap_Pos = 0

    IF Help_Underline THEN
        Help_Underline = 0
        w = Help_Pos
        Help_Pos = 1
        Help_AddTxt STRING$(w - 1, 196), Help_Col, 0
        Help_NewLine
    END IF
    Help_Pos = 1

    IF Help_NewLineIndent THEN
        Help_AddTxt SPACE$(Help_NewLineIndent), Help_Col, 0
    END IF


END SUB

SUB Help_PreView

    OPEN "help_preview.txt" FOR OUTPUT AS #1
    FOR i = 1 TO LEN(Help_Txt$) STEP 4
        c = ASC(Help_Txt$, i)
        c$ = CHR$(c)
        IF c = 13 THEN c$ = CHR$(13) + CHR$(10)
        PRINT #1, c$;
    NEXT
    CLOSE #1

    CLS
    FOR i = 1 TO LEN(Help_Txt$) STEP 4
        c = ASC(Help_Txt$, i)
        col = ASC(Help_Txt$, i + 1)
        IF c = 13 THEN
            COLOR col AND 15, col \ 16
            PRINT SPACE$(help_w - POS(0));
            COLOR 7, 0
            PRINT SPACE$(_WIDTH - POS(0) + 1);
            COLOR col AND 15, col \ 16
            SLEEP
        ELSE
            COLOR col AND 15, col \ 16
            PRINT CHR$(c);
        END IF
    NEXT
END SUB


FUNCTION Help_Col 'helps to calculate the default color
    col = Help_Col_Normal
    IF Help_Italic THEN col = Help_Col_Italic
    IF Help_Bold THEN col = Help_Col_Bold 'Note: Bold overrides italic
    Help_Col = col
END FUNCTION



SUB WikiParse (a$)
    'PRINT "Parsing...": _DISPLAY

    'wiki page interpret

    'clear info
    help_h = 0: help_w = 0: Help_Line$ = "": Help_Link$ = "": Help_LinkN = 0
    Help_Txt$ = SPACE$(1000000)
    Help_Txt_Len = 0

    Help_Pos = 1: Help_Wrap_Pos = 0
    Help_Line$ = MKL$(1)
    Help_LockWrap = 0
    Help_Bold = 0: Help_Italic = 0
    Help_Underline = 0
    Help_BG_Col = 0

    link = 0: elink = 0: cb = 0

    col = Help_Col

    'Syntax Notes:
    ' '''=bold
    ' ''=italic
    ' {{macroname|macroparam}} or simply {{macroname}}
    '  eg. {{KW|PRINT}}=a key word, a link to a page
    '      {{Cl|PRINT}}=a key word in a code example, will be printed in bold and aqua
    '      {{Parameter|expression}}=a parameter, in italics
    '      {{PageSyntax}} {{PageDescription}} {{PageExamples}}
    '      {{CodeStart}} {{CodeEnd}} {{OutputStart}} {{OutputEnd}}
    '      {{PageSeeAlso}} {{PageNavigation}}
    ' [[SPACE$]]=a link to wikipage called "SPACE$"
    ' [[INTEGER|integer]]=a link, link's name is on left and text to appear is on right
    ' *=a dot point
    ' **=a sub(ie. further indented) dot point
    ' &quot;=a quotation mark
    ' :=indent (if beginning a new line)
    ' CHR$(10)=new line character

    prefetch = 16
    DIM c$(prefetch)
    FOR ii = 1 TO prefetch
        c$(ii) = SPACE$(ii)
    NEXT

    n = LEN(a$)
    i = 1
    DO WHILE i <= n

        c = ASC(a$, i): c$ = CHR$(c)
        FOR i1 = 1 TO prefetch
            ii = i
            FOR i2 = 1 TO i1
                IF ii <= n THEN
                    ASC(c$(i1), i2) = ASC(a$, ii)
                ELSE
                    ASC(c$(i1), i2) = 32
                END IF
                ii = ii + 1
            NEXT
        NEXT

        IF c = 38 THEN '"&"
            s$ = "&quot;"
            IF c$(LEN(s$)) = s$ THEN
                i = i + LEN(s$) - 1
                c$ = CHR$(34): c = ASC(c$)
                GOTO SpecialChr
            END IF

            s$ = "&amp;"
            IF c$(LEN(s$)) = s$ THEN
                i = i + LEN(s$) - 1
                c$ = "&": c = ASC(c$)
                GOTO SpecialChr
            END IF

            s$ = "&gt;"
            IF c$(LEN(s$)) = s$ THEN
                i = i + LEN(s$) - 1
                c$ = ">": c = ASC(c$)
                GOTO SpecialChr
            END IF

            IF c$(2) = CHR$(194) + CHR$(160) THEN 'some kind of white-space formatting unicode combo
                i = i + 1
                GOTO Special
            END IF

            s$ = "&lt;code>": IF c$(LEN(s$)) = s$ THEN i = i + LEN(s$) - 1: GOTO Special
            s$ = "&lt;/code>": IF c$(LEN(s$)) = s$ THEN i = i + LEN(s$) - 1: GOTO Special

            s$ = "&lt;center>"
            IF c$(LEN(s$)) = s$ THEN
                i = i + LEN(s$) - 1
                GOTO Special
            END IF

            s$ = "&lt;/center>"
            IF c$(LEN(s$)) = s$ THEN
                i = i + LEN(s$) - 1
                GOTO Special
            END IF

            s$ = "&lt;p style="
            IF c$(LEN(s$)) = s$ THEN
                i = i + LEN(s$) - 1
                FOR ii = i TO LEN(a$) - 1
                    IF MID$(a$, ii, 1) = ">" THEN i = ii: EXIT FOR
                NEXT
                GOTO Special
            END IF

            s$ = "&lt;/p"
            IF c$(LEN(s$)) = s$ THEN
                i = i + LEN(s$) - 1
                FOR ii = i TO LEN(a$) - 1
                    IF MID$(a$, ii, 1) = ">" THEN i = ii: EXIT FOR
                NEXT
                GOTO Special
            END IF

            s$ = "&lt;div"
            IF c$(LEN(s$)) = s$ THEN
                i = i + LEN(s$) - 1
                FOR ii = i TO LEN(a$) - 1
                    IF MID$(a$, ii, 9) = "&lt;/div>" THEN i = ii + 8: EXIT FOR
                NEXT
                GOTO Special
            END IF

            s$ = "&lt;"
            IF c$(LEN(s$)) = s$ THEN
                i = i + LEN(s$) - 1
                c$ = "<": c = ASC(c$)
                GOTO SpecialChr
            END IF
            SpecialChr:
        END IF 'c=38 '"&"

        'Links
        IF c = 91 THEN '"["
            IF c$(2) = "[[" AND link = 0 THEN
                i = i + 1
                link = 1
                link$ = ""
                GOTO Special
            END IF
        END IF
        IF link = 1 THEN
            IF c$(2) = "]]" OR c$(2) = "}}" THEN
                i = i + 1
                link = 0
                text$ = link$
                i2 = INSTR(link$, "|")
                IF i2 THEN
                    text$ = RIGHT$(link$, LEN(link$) - i2)
                    link$ = LEFT$(link$, i2 - 1)
                END IF

                IF INSTR(link$, "#") THEN 'local page links not supported yet
                    Help_AddTxt text$, 8, 0
                    GOTO Special
                END IF

                Help_LinkN = Help_LinkN + 1
                Help_Link$ = Help_Link$ + "PAGE:" + link$ + Help_Link_Sep$

                IF Help_BG_Col = 0 THEN
                    Help_AddTxt text$, Help_Col_Link, Help_LinkN
                ELSE
                    Help_AddTxt text$, Help_Col_Bold, Help_LinkN
                END IF
                GOTO Special
            END IF
            link$ = link$ + c$
            GOTO Special
        END IF


        'External links
        IF c = 91 THEN '"["
            IF c$(6) = "[http:" AND elink = 0 THEN
                elink = 2
                elink$ = ""
                GOTO Special
            END IF
        END IF
        IF elink = 2 THEN
            IF c$ = " " THEN
                elink = 1
                GOTO Special
            END IF
            elink$ = elink$ + c$
            GOTO Special
        END IF
        IF elink >= 1 THEN
            IF c$ = "]" THEN
                elink = 0
                elink$ = " " + elink$
                Help_LockWrap = 1: Help_Wrap_Pos = 0
                Help_AddTxt elink$, 8, 0
                Help_LockWrap = 0
                elink$ = ""
                GOTO Special
            END IF
        END IF

        IF c = 123 THEN '"{"
            IF c$(5) = "{{KW|" THEN 'this is really a link!
                i = i + 4
                link = 1
                link$ = ""
                GOTO Special
            END IF
            IF c$(5) = "{{Cl|" THEN 'this is really a link too (in code example)
                i = i + 4
                link = 1
                link$ = ""
                GOTO Special
            END IF
            IF c$(2) = "{{" THEN
                i = i + 1
                cb = 1
                cb$ = ""
                GOTO Special
            END IF
        END IF

        IF cb = 1 THEN
            IF c$ = "|" OR c$(2) = "}}" THEN
                IF c$(2) = "}}" THEN i = i + 1
                cb = 0

                IF cb$ = "PageSyntax" THEN Help_AddTxt "Syntax:" + CHR$(13), Help_Col_Section, 0
                IF cb$ = "PageDescription" THEN Help_AddTxt "Description:" + CHR$(13), Help_Col_Section, 0
                IF cb$ = "PageExamples" THEN Help_AddTxt "Code Examples:" + CHR$(13), Help_Col_Section, 0
                IF cb$ = "PageSeeAlso" THEN Help_AddTxt "See also:" + CHR$(13), Help_Col_Section, 0

                IF cb$ = "CodeStart" THEN
                    Help_NewLine
                    Help_BG_Col = 1
                    'Skip non-meaningful content before section begins
                    ws = 1
                    FOR ii = i + 1 TO LEN(a$)
                        IF ASC(a$, ii) = 10 THEN EXIT FOR
                        IF ASC(a$, ii) <> 32 AND ASC(a$, ii) <> 39 THEN ws = 0
                    NEXT
                    IF ws THEN i = ii
                END IF
                IF cb$ = "CodeEnd" THEN Help_BG_Col = 0
                IF cb$ = "OutputStart" THEN
                    Help_NewLine
                    Help_BG_Col = 2
                    'Skip non-meaningful content before section begins
                    ws = 1
                    FOR ii = i + 1 TO LEN(a$)
                        IF ASC(a$, ii) = 10 THEN EXIT FOR
                        IF ASC(a$, ii) <> 32 AND ASC(a$, ii) <> 39 THEN ws = 0
                    NEXT
                    IF ws THEN i = ii
                END IF
                IF cb$ = "OutputEnd" THEN Help_BG_Col = 0

                GOTO Special

            END IF

            cb$ = cb$ + c$ 'reading maro name
            GOTO Special
        END IF 'cb=1

        IF c$(2) = "}}" THEN 'probably the end of a text section of macro'd text
            i = i + 1
            GOTO Special
        END IF



        IF c$(4) = " == " THEN
            i = i + 3
            Help_Underline = 1
            GOTO Special
        END IF
        IF c$(3) = "== " THEN
            i = i + 2
            Help_Underline = 1
            GOTO Special
        END IF
        IF c$(3) = " ==" THEN
            i = i + 2
            GOTO Special
        END IF
        IF c$(2) = "==" THEN
            i = i + 1
            Help_Underline = 1
            GOTO Special
        END IF


        IF c$(3) = "'''" THEN
            i = i + 2
            IF Help_Bold = 0 THEN Help_Bold = 1 ELSE Help_Bold = 0
            col = Help_Col
            GOTO Special
        END IF

        IF c$(2) = "''" THEN
            i = i + 1
            IF Help_Italic = 0 THEN Help_Italic = 1 ELSE Help_Italic = 0
            col = Help_Col
            GOTO Special
        END IF

        IF nl = 1 THEN

            IF c$(3) = "** " THEN
                i = i + 2
                Help_AddTxt "    " + CHR$(254) + " ", col, 0
                Help_NewLineIndent = Help_NewLineIndent + 6
                GOTO Special
            END IF
            IF c$(2) = "* " THEN
                i = i + 1
                Help_AddTxt CHR$(254) + " ", col, 0
                Help_NewLineIndent = Help_NewLineIndent + 2
                GOTO Special
            END IF
            IF c$(2) = "**" THEN
                i = i + 1
                Help_AddTxt "    " + CHR$(254) + " ", col, 0
                Help_NewLineIndent = Help_NewLineIndent + 6
                GOTO Special
            END IF
            IF c$ = "*" THEN
                Help_AddTxt CHR$(254) + " ", col, 0
                Help_NewLineIndent = Help_NewLineIndent + 2
                GOTO Special
            END IF

        END IF

        s$ = "{|"
        IF c$(LEN(s$)) = s$ THEN
            i = i + 1
            FOR ii = i TO LEN(a$) - 1
                IF MID$(a$, ii, 2) = "|}" THEN i = ii + 1: EXIT FOR
            NEXT
            GOTO Special
        END IF

        IF c$(3) = CHR$(226) + CHR$(128) + CHR$(166) THEN '...
            i = i + 2
            Help_AddTxt "...", col, 0
            GOTO Special
        END IF

        IF c$ = CHR$(226) THEN 'UNICODE UTF8 extender, it's a very good bet the following 2 characters will be 2 bytes of UNICODE
            i = i + 2
            GOTO Special
        END IF

        IF c$ = ":" AND nl = 1 THEN
            Help_AddTxt "    ", col, 0
            Help_NewLineIndent = Help_NewLineIndent + 4
            i = i + 1: GOTO special2
        END IF

        s$ = "__NOTOC__" + CHR$(10)
        IF c$(LEN(s$)) = s$ THEN
            i = i + LEN(s$) - 1
            GOTO Special
        END IF
        s$ = "__NOTOC__"
        IF c$(LEN(s$)) = s$ THEN
            i = i + LEN(s$) - 1
            GOTO Special
        END IF

        IF c$(4) = "----" THEN
            i = i + 3
            Help_AddTxt STRING$(100, 196), 8, 0
            GOTO Special
        END IF



        IF c$ = CHR$(10) THEN
            Help_NewLineIndent = 0

            IF Help_Txt_Len >= 8 THEN
                IF ASC(Help_Txt$, Help_Txt_Len - 3) = 13 AND ASC(Help_Txt$, Help_Txt_Len - 7) = 13 THEN GOTO skipdoubleblanks
            END IF

            Help_AddTxt CHR$(13), col, 0

            skipdoubleblanks:
            nl = 1
            i = i + 1: GOTO special2
        END IF

        Help_AddTxt CHR$(c), col, 0

        Special:
        i = i + 1
        nl = 0
        special2:
    LOOP

    'Trim Help_Txt$
    Help_Txt$ = LEFT$(Help_Txt$, Help_Txt_Len) + CHR$(13) 'chr13 stops reads past end of content

    'generate preview file
    'OPEN "help_preview.txt" FOR OUTPUT AS #1
    'FOR i = 1 TO LEN(Help_Txt$) STEP 4
    '    c = ASC(Help_Txt$, i)
    '    c$ = CHR$(c)
    '    IF c = 13 THEN c$ = CHR$(13) + CHR$(10)
    '    PRINT #1, c$;
    'NEXT
    'CLOSE #1

    'PRINT "Finished parsing!": _DISPLAY


    IF Help_PageLoaded$ = "Keyword Reference - Alphabetical" THEN

        fh = FREEFILE
        OPEN "internal\help\links.bin" FOR OUTPUT AS #fh
        a$ = SPACE$(1000)
        FOR cy = 1 TO help_h
            'isolate and REVERSE select link
            l = CVL(MID$(Help_Line$, (cy - 1) * 4 + 1, 4))
            x = l
            x2 = 1
            c = ASC(Help_Txt$, x)
            oldlnk = 0
            lnkx1 = 0: lnkx2 = 0
            DO UNTIL c = 13
                ASC(a$, x2) = c
                lnk = CVI(MID$(Help_Txt$, x + 2, 2))
                IF oldlnk = 0 AND lnk <> 0 THEN lnkx1 = x2
                IF (lnk = 0 OR ASC(Help_Txt$, x + 4) = 13) AND lnkx1 <> 0 THEN
                    lnkx2 = x2: IF lnk = 0 THEN lnkx2 = lnkx2 - 1

                    IF lnkx1 <> 3 THEN GOTO ignorelink
                    IF ASC(a$, 1) <> 254 THEN GOTO ignorelink

                    'retrieve lnk info
                    lnk2 = lnk: IF lnk2 = 0 THEN lnk2 = oldlnk
                    l1 = 1
                    FOR lx = 1 TO lnk2 - 1
                        l1 = INSTR(l1, Help_Link$, Help_Link_Sep$) + 1
                    NEXT
                    l2 = INSTR(l1, Help_Link$, Help_Link_Sep$) - 1
                    l$ = MID$(Help_Link$, l1, l2 - l1 + 1)
                    'assume PAGE
                    l$ = RIGHT$(l$, LEN(l$) - 5)

                    a2$ = MID$(a$, lnkx1, lnkx2 - lnkx1 + 1)

                    IF INSTR(a2$, "(") THEN a2$ = LEFT$(a2$, INSTR(a2$, "(") - 1)
                    IF INSTR(a2$, " ") THEN a2$ = LEFT$(a2$, INSTR(a2$, " ") - 1)
                    IF INSTR(a2$, "...") THEN
                        a3$ = RIGHT$(a2$, LEN(a2$) - INSTR(a2$, "...") - 2)

                        skip = 0

                        IF UCASE$(LEFT$(a3$, 3)) <> "_GL" THEN
                            FOR ci = 1 TO LEN(a3$)
                                ca = ASC(a3$, ci)
                                IF ca >= 97 AND ca <= 122 THEN skip = 1
                                IF ca = 44 THEN skip = 1
                            NEXT
                        END IF

                        IF skip = 0 THEN PRINT #fh, a3$ + "," + l$

                        a2$ = LEFT$(a2$, INSTR(a2$, "...") - 1)
                    END IF


                    skip = 0
                    IF UCASE$(LEFT$(a2$, 3)) <> "_GL" THEN
                        FOR ci = 1 TO LEN(a2$)
                            ca = ASC(a2$, ci)
                            IF ca >= 97 AND ca <= 122 THEN skip = 1
                            IF ca = 44 THEN skip = 1
                        NEXT
                    END IF
                    IF skip = 0 THEN PRINT #fh, a2$ + "," + l$
                    oa2$ = a2$

                    a2$ = l$
                    IF INSTR(a2$, "(") THEN a2$ = LEFT$(a2$, INSTR(a2$, "(") - 1)
                    IF INSTR(a2$, " ") THEN a2$ = LEFT$(a2$, INSTR(a2$, " ") - 1)
                    IF INSTR(a2$, "...") THEN
                        a3$ = RIGHT$(a2$, LEN(a2$) - INSTR(a2$, "...") - 2)

                        skip = 0
                        IF UCASE$(LEFT$(a3$, 3)) <> "_GL" THEN
                            FOR ci = 1 TO LEN(a3$)
                                ca = ASC(a3$, ci)
                                IF ca >= 97 AND ca <= 122 THEN skip = 1
                                IF ca = 44 THEN skip = 1
                            NEXT
                        END IF
                        IF skip = 0 THEN PRINT #fh, a3$ + "," + l$

                        a2$ = LEFT$(a2$, INSTR(a2$, "...") - 1)
                    END IF

                    skip = 0
                    IF UCASE$(LEFT$(a2$, 3)) <> "_GL" THEN
                        FOR ci = 1 TO LEN(a2$)
                            ca = ASC(a2$, ci)
                            IF ca >= 97 AND ca <= 122 THEN skip = 1
                            IF ca = 44 THEN skip = 1
                        NEXT
                    END IF
                    IF skip = 0 AND a2$ <> oa2$ THEN PRINT #fh, a2$ + "," + l$

                    ignorelink:

                    lnkx1 = 0: lnkx2 = 0
                END IF
                x = x + 4: c = ASC(Help_Txt$, x)
                x2 = x2 + 1
                oldlnk = lnk
            LOOP
        NEXT
        CLOSE #fh

    END IF





END SUB

