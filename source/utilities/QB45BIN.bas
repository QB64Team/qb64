'QB45BIN.BAS - written by qarnos
'Used by permission: http://www.qb64.net/forum/index.php?topic=1771.msg16215#msg16215
'Command line interface adapted by FellippeHeitor

REM $DYNAMIC

DEFINT A-Z
'----------------------------------------------------------------------------
' Used for sorting alphabetically.
'----------------------------------------------------------------------------
DIM SHARED QBBinProcedureIndex AS STRING

'----------------------------------------------------------------------------
' Internal constants used by parse rule decoder
'----------------------------------------------------------------------------
CONST TagType.Recursive = 1
CONST TagType.TokenData = 2
CONST TagType.StackABS = 3
CONST TagType.StackREL = 4

'----------------------------------------------------------------------------
' Constants returned by the Meta field of QBBinReadLine. I will probably
' use the high 16-bits for flags, so best to mask them out for now.
'----------------------------------------------------------------------------
CONST QBBinMeta.SUB = 1
CONST QBBinMeta.FUNCTION = 2

'----------------------------------------------------------------------------
' Not yet used since it only supports QB45 atm.
'----------------------------------------------------------------------------
CONST QBBinFileMode.QB45 = 1

'----------------------------------------------------------------------------
' Option variable declarations
'----------------------------------------------------------------------------
DIM SHARED QBBinOption.OmitIncludedLines AS INTEGER
DIM SHARED QBBinOption.SortProceduresAZ AS INTEGER

'----------------------------------------------------------------------------
' Option variable initialisation
'----------------------------------------------------------------------------
QBBinOption.OmitIncludedLines = -1
QBBinOption.SortProceduresAZ = -1

'----------------------------------------------------------------------------
' Errors only half-implemented so far.
'----------------------------------------------------------------------------
CONST QBErrBadFormat = 255
CONST QBErrBadToken = 254
CONST QBErrInsane = 253

'----------------------------------------------------------------------------
' You may use QBBinEOF, for now, to determine when EOF has been reached.
' QBBinDefType contains the current DEFxxx setting for each letter of the
' alphabet (1 = INT, 2 = LNG, 3 = SNG, 4 = DBL, 5 = STR).
'----------------------------------------------------------------------------
DIM SHARED QBBinDefType(1 TO 26) AS INTEGER
DIM SHARED QBBinLineReady AS INTEGER ' get rid of this
DIM SHARED QBBinProgramLine AS STRING ' and this
DIM SHARED QBBinFile AS INTEGER
DIM SHARED QBBinEOF AS INTEGER

'----------------------------------------------------------------------------
' A hash table is used for symbols defined in the parse rules. There aren't
' many of them, so a small table will do.
'----------------------------------------------------------------------------
CONST SymbolHashBuckets = 43
DIM SHARED SymbolHashTable(0 TO SymbolHashBuckets - 1) AS STRING
DIM SHARED SymbolHashEntries AS INTEGER

'----------------------------------------------------------------------------
' Not worth commenting on... oops.
'----------------------------------------------------------------------------
DIM SHARED TypeSpecifiers(0 TO 5, 1 TO 3) AS STRING
DIM SHARED ParseRules(0) AS STRING

'----------------------------------------------------------------------------
' We don't need a very big stack. I haven't seen it go beyond 8 or 9 entries
' so 255 is plenty. Also, STACK(0) is a special entry. IF SP = 0 then there
' is nothing on the stack.
'----------------------------------------------------------------------------
DIM SHARED STACK(0 TO 255) AS STRING
DIM SHARED SP AS INTEGER

'----------------------------------------------------------------------------
' Define global symbol table, code space and instruction pointer
'----------------------------------------------------------------------------
DIM SHARED SYMTBL(0) AS INTEGER
DIM SHARED CODE(0) AS INTEGER
DIM SHARED IP AS LONG

'----------------------------------------------------------------------------
' PCODE always contains the ID of the current token (the low 10 bits of the
'       input word.
'
' HPARAM contains the high 6 bits of the input word and is used by some
'        tokens. IE: Identifiers use it for the type suffix and integers
'        smaller than 10 are encoded this way.
'
' TOKEN is a string containing the binary data for the current token (PCODE
'       and HPARAM in the first word, the rest of the data follows). All the
'       FetchXXX functions work on this variable
'----------------------------------------------------------------------------
DIM SHARED PCODE AS INTEGER
DIM SHARED HPARAM AS INTEGER
DIM SHARED TOKEN AS STRING

'----------------------------------------------------------------------------
' LastProcType is just a hack to keep track of the current SUB or FUNCTION
' status since END SUB and END FUNCTION share the same token.
'----------------------------------------------------------------------------
DIM SHARED LastProcType AS STRING ' Current procedure type
DIM SHARED QBTxtFile AS INTEGER

'----------------------------------------------------------------------------
' These variables contain the current prodecure name and type the parser
' is decoding.
'
' QBBinProcedureType = MAIN | SUB | FUNCTON | DEF
'----------------------------------------------------------------------------
DIM SHARED QBBinProcedureName AS STRING
DIM SHARED QBBinProcedureType AS STRING


'----------------------------------------------------------------------------
' Variables used to store common token codes referenced in the code. Faster
' than doing GetHashedSymbol("tokenname") every time, and flexible since the
' QB40 token codes are different from QB45.
'----------------------------------------------------------------------------
DIM SHARED QBBinTok.SUBDEF AS INTEGER
DIM SHARED QBBinTok.FUNCDEF AS INTEGER
DIM SHARED QBBinTok.DEFTYPE AS INTEGER

DIM SHARED OutputContents$

$CONSOLE:ONLY
_DEST _CONSOLE

'----------------------------------------------------------------------------
' Initialisation will eventually be automatic in QBBinOpenFile
'----------------------------------------------------------------------------
RESTORE TSPECS
FOR i = 0 TO 17: READ TypeSpecifiers(i \ 3, i MOD 3 + 1): NEXT i

'----------------------------------------------------------------------------
' Get file names, etc.
'----------------------------------------------------------------------------
'ON ERROR GOTO ErrorHandler

GetInputFileName:

IF _COMMANDCOUNT = 0 THEN
    PRINT "QB45BIN"
    PRINT
    PRINT "Conversion utility from QuickBASIC 4.5 binary to plain text."
    PRINT "by qarnos"
    PRINT
    PRINT "    Syntax: QB45BIN <source.bas> [-o output.bas]"
    PRINT
    PRINT "If no output is specified, a backup file is saved and the original"
    PRINT "file is overwritten."
    PRINT
    SYSTEM 1
END IF

IF _FILEEXISTS(COMMAND$(1)) = 0 THEN
    IF INSTR(InputFile$, ".") = 0 THEN InputFile$ = InputFile$ + ".BAS"

    PRINT "File not found: "; COMMAND$(1)
    SYSTEM 1
ELSE
    InputFile$ = COMMAND$(1)
END IF

IF LCASE$(COMMAND$(2)) = "-o" THEN
    IF LEN(COMMAND$(3)) THEN
        OutputFile$ = COMMAND$(3)
    END IF
END IF

IF OutputFile$ = "" THEN
    IF INSTR(InputFile$, "\") > 0 OR INSTR(InputFile$, "/") > 0 THEN
        FOR i = LEN(InputFile$) TO 1 STEP -1
            IF MID$(InputFile$, i, 1) = "/" OR MID$(InputFile$, i, 1) = "\" THEN
                path$ = LEFT$(InputFile$, i)
                InputFile$ = MID$(InputFile$, i + 1)
                EXIT FOR
            END IF
        NEXT
    END IF
    OutputFile$ = path$ + InputFile$ + ".converted.bas"
END IF

PRINT UCASE$(InputFile$)

PRINT
PRINT "Loading parse rules... ";
LoadParseRules
PRINT "Done!": PRINT

QBBinOpenFile path$ + InputFile$

'---------------------------------------------------------------------------
' The main loop is pretty straight-forward these days.
'---------------------------------------------------------------------------
StartProcessing! = TIMER
DO WHILE NOT QBBinEOF

    ProgramLine$ = QBBinReadLine$(Meta&)

    '-----------------------------------------------------------------------
    ' Just an example of meta-data usage. Pretty limited at the moment,
    ' but could be helpful to QB64 IDE when building SUB/FUNCTION list.
    '-----------------------------------------------------------------------
    'IF Meta& = QBBinMeta.SUB THEN PRINT "----- SUBROUTINE -----"
    'IF Meta& = QBBinMeta.FUNCTION THEN PRINT "----- FUNCTION -----"

    '-----------------------------------------------------------------------
    ' AOutput has become a pretty-print function. All program lines are now
    ' retrieved by calling QBBinReadLine.
    '-----------------------------------------------------------------------
    AOutput ProgramLine$

    'Quit after a number of seconds - likely an invalid file causing an endless loop
    CONST TIMEOUT = 30
    IF StartProcessing! > TIMER THEN StartProcessing! = StartProcessing! - 86400
    IF TIMER - StartProcessing! > TIMEOUT THEN PRINT "Conversion failed.": SYSTEM 1

LOOP

'If we've made it this far, output the resulting file:
QBTxtFile = FREEFILE
OPEN OutputFile$ FOR BINARY AS #QBTxtFile
PUT #QBTxtFile, 1, OutputContents$
CLOSE #QBTxtFile

RESET

PRINT "Finished!"

SYSTEM 0

TSPECS:
DATA ANY,,
DATA INTEGER,INT,%
DATA LONG,LNG,&
DATA SINGLE,SNG,!
DATA DOUBLE,DBL,#
DATA STRING,STR,$


QB45TOKENS:
'
' Most of the tokens for QB45 are defined here, along with the length of the
' token (or '*' for variable length) and some parse rules.
'
' The first column determined the PCODE (the low 10 bits of the token)
' which the rule responds to. This is followed by the length of the token
' *data*, which may be omitted if the token has no data, or an asterisk to
' indicate a variable length token. Variable length tokens are always
' followed by a word indicating the length of the token.
'
' The final column is the parse rule itself. A token may have multiple
' parse rules. Multiple parse rules may be specified on a seperate line
' (without a PCODE or LENGTH field), or seperated by a pipe ('|') symbol.
'
' There is one important difference between the two methods. Some rules
' define a symbol which can be used to reference the rule, such as:
'
'   declmod::=SHARED
'
' If a pipe symbol is used, the next rule will inherit the "declmod" (or
' whatever symbol), unless it exlicitly defines it's own. Rules defined
' on seperate lines use the default symbol which, initially, is nothing, but
' may be overridden using the ".default" directive. This is only really used
' in the second half of the rule list, where almost every token is an
' expression ('expr').
'
' Rules are matched on a first-come first-served basis. The first rule which
' can be successfully applied (see below) is accepted.
'
' The rules can have {tags} embedded in them. There are basically two types
' of tags - stack and data/format tags. I will discuss them briefly here:
'
' STACK tags can take these basic forms:
'
'  {1}
'  {*:1}
'  {rulename:1}
'  {$+1}
'  {$-1}
'  {rulename:$+1}
'
' The first type will be substituded for the text located 1 item from the
' top of the parse stack. If the stack isn't that deep, it will be replaced
' with the null string.
'
' The second type is just like the first, except the rule will be rejected
' if the stack item doesn't exist.
'
' The third type will only accept a rule if the stack item at the specified
' offset is of the correct rule type. So {declmod:1} will reject the rule
' if the stack entry at offset 1 is not a "declemod". There is also a special
' rule name, "self", which always refers to the current rule.
'
' The final three forms, use the '$' symbol. This symbol refers to a
' "relative" stack offset - an offset from the deepest stack item referenced
' in a normal tag. This is really a bit of a hack, due to me trying to avoid
' writing a full LALR(1) parser! This feature is rarely used.
'
' DATA/FORMAT tags
'
' Data and format tags being with a '#', such as {#id:2}. These tags are used
' either to interpret data from the token or to generate a dynamic parse
' rule (another hack).
'
' In the case of data tokens, the number refers to the offset into the token
' data on which the tag is to work.
'
' Format tokens usually have two '#' symbols, such as {##id(decl)}. The
' extra '#' causes the parser to re-scan the tag for other tags once it
' has been subsituted, allowing these tags to generate stack tags which can
' then be parsed.
'
' See the function GetTaggedItem for a list of tag names which can be used.
'
'
'


REM     Token   Length  Rule(s)
REM     -------+-------+-------

DATA 0x000,"newline::=.{#newline}{#tabh}"
DATA 0x001,2,"newline::=.{#newline}{#tabi}"
DATA 0x002,2,"newline::=.{#newline-include}"
DATA 0x003,4,"newline::=.{#newline-include}{#indent:2} "
DATA 0x004,4,".{#newline}{#thaddr:0}{#label:2}"
DATA 0x005,6,".{#newline}{#thaddr:0}{#label:2} {#indent:4}"
DATA 0x006,": "
DATA 0x007,2,":{#tabi}"

'----------------------------------------------------------------------------
' 0x008 = End of procedure/module code (watch list follows)
' 0x009 = End of watch list
'----------------------------------------------------------------------------
DATA 0x008,"."
DATA 0x009,

DATA 0x00a,*,"{#raw:2}"
DATA 0x00b,2,"expr::={#id+}"
DATA 0x00c,2,"consts::={const:1} {#id+} = {0}"
DATA "consts::={consts:1}, {#id+} = {0}"
DATA "{#id+} = {0}"
DATA 0x00d,2,"decls::={decls:1}, {#id+:0} {astype:0}"
DATA "decls::={decls:0}, {#id+:0}"
DATA "decls::={decl:1} {#id+:0} {astype:0}"
DATA "decls::={decl:0} {#id+:0}"
DATA "{#id+:0} {astype:0}"
DATA "{#id+:0}"
DATA 0x00e,4,"expr::={##id(expr)}"
DATA 0x00f,4,"{##id(expr)} = {$+0}"
DATA 0x010,4,"decls::={##id(decl)}"
DATA 0x011,2,"expr::={0}.{#id}"
DATA 0x012,2,"{0}.{#id} = {1}"

' 0x015 = AS USERTYPE
' 0x016 = AS BUILTINTYPE?
DATA 0x015,4,"astype::={#tabi:2}AS {#type:0}"
DATA 0x016,4,"astype::={#tabi:2}AS {#type:0}"

' 0x017 - used for unkown type assignments?
DATA 0x017,0,""

DATA 0x018,""

'----------------------------------------------------------------------------
' 0x019 = user-type field declaration.
'----------------------------------------------------------------------------
DATA 0x019,2,"{#id}"
DATA 0x01a,"declmod::=SHARED"
DATA 0x01b,6,"deftype::={#thaddr:0}{#DEFxxx}"
DATA 0x01c,"{self:1}, {0}|REDIM {declmod:1} {0}|REDIM {0}"
DATA 0x01d,2,"END TYPE"
DATA 0x01e,2,"decl::=SHARED"
DATA 0x01f,2,"decl::=STATIC"
DATA 0x020,4,"TYPE {#id:2}"
DATA 0x021,*,"$STATIC{#raw}"
DATA 0x022,*,"$DYNAMIC{#raw}"
DATA 0x023,"const::=CONST"

'----------------------------------------------------------------------------
' 0x024 = IDE breakpoint
'----------------------------------------------------------------------------
DATA 0x024,

DATA 0x025,"BYVAL {0}"
DATA 0x026,*,"{deffn:1} = {0}"
DATA 0x027,"COM({0})"
DATA 0x028,2,"ON {0} GOSUB {#id}"
DATA 0x029,"KEY({0})"
DATA 0x02a,"{0} OFF"
DATA 0x02b,"{0} ON"
DATA 0x02c,"{0} STOP"
DATA 0x02d,"PEN"
DATA 0x02e,"PLAY"
DATA 0x02f,"PLAY({0})"
DATA 0x030,"SIGNAL({0})"
DATA 0x031,"STRIG({0})"
DATA 0x032,"TIMER"
DATA 0x033,"TIMER({0})"

'----------------------------------------------------------------------------
' Labels used in $INCLUDEd lines
'----------------------------------------------------------------------------
DATA 0x034,4,"newline::={#thaddr:0}{#label:2} "
DATA 0x035,6,"newline::={#thaddr:0}{#label:2} {#indent:4}"

DATA 0x037,4,"CALL {#id:2}{##call()}"
DATA 0x038,4,"{#id:2}{##call}"
DATA 0x039,4,"CALLS {#id:2}{##call()}"
DATA 0x03a,"CASE ELSE"
DATA 0x03b,"case::={case:1}, {0}|CASE {0}"
DATA 0x03c,"case::={case:2}, {1} TO {0}|CASE {1} TO {0}"
DATA 0x03d,"case::={case:1}, IS = {0}|CASE IS = {0}"
DATA 0x03e,"case::={case:1}, IS < {0}|CASE IS < {0}"
DATA 0x03f,"case::={case:1}, IS > {0}|CASE IS > {0}"
DATA 0x040,"case::={case:1}, IS <= {0}|CASE IS <= {0}"
DATA 0x041,"case::={case:1}, IS >= {0}|CASE IS >= {0}"
DATA 0x042,"case::={case:1}, IS <> {0}|CASE IS <> {0}"

DATA 0x043,"ON"
DATA 0x044,*,"DECLARE {#procdecl()}"
DATA 0x045,*,"deffn::={#procdecl:2}"
DATA 0x046,"DO"
DATA 0x047,"DO UNTIL {0}"
DATA 0x048,2,"DO WHILE {0}"
DATA 0x049,2,"{newline:0}ELSE | ELSE "

' 0x04a = implicit GOTO linenumber used in 0x04c ELSE
DATA 0x04a,2,"{#id}"
DATA 0x04c," ELSE "

DATA 0x04d,2,"ELSEIF {0} THEN"
DATA 0x04e,"END"
DATA 0x04f,*,"END DEF"
DATA 0x050,"END IF"
DATA 0x051,"END {#proctype}"
DATA 0x052,"END SELECT"
DATA 0x053,2,"EXIT DO"
DATA 0x054,2,"EXIT FOR"
DATA 0x055,2,"EXIT {#proctype}"
DATA 0x056,4,"FOR {2} = {1} TO {0}"
DATA 0x057,4,"FOR {3} = {2} TO {1} STEP {0}"
DATA 0x058,*,"funcdef::={#procdecl}"
DATA 0x059,2,"GOSUB {#id}"
'       0x05a   2,      "GOSUB {#id}"
DATA 0x05b,2,"GOTO {#id}"
'       0x05c   2,      "GOTO {#id}"
DATA 0x05d,2,"IF {0} THEN "
DATA 0x05e,2,"IF {0} THEN {#id}"
'       0x05f,  2,      "IF {0} THEN "
DATA 0x060,2,"IF {0} GOTO {#id}"
DATA 0x061,2,"IF {0} THEN"
DATA 0x062,2,"LOOP"
DATA 0x063,2,"LOOP UNTIL {0}"
DATA 0x064,2,"LOOP WHILE {0}"
DATA 0x065,4,"NEXT"
DATA 0x066,4,"{self:1}, {0}|NEXT {0}"
DATA 0x067,2,"ON ERROR GOTO {#id}"
DATA 0x068,*,"ON {0} GOSUB {#id-list}"
DATA 0x069,*,"ON {0} GOTO {#id-list}"
DATA 0x06a,"RESTORE"
DATA 0x06b,2,"RESTORE {#id}"
DATA 0x06c,"RESUME"
DATA 0x06d,2,"RESUME {#id}"
DATA 0x06e,"RESUME NEXT"
DATA 0x06f,"RETURN"
DATA 0x070,2,"RETURN {#id}"
DATA 0x071,"RUN {0}"
DATA 0x072,2,"RUN {#id}"
DATA 0x073,"RUN"
DATA 0x074,2,"SELECT CASE {0}"
DATA 0x075,2,"STOP"
DATA 0x076,*,"subdef::={#procdecl}"
DATA 0x077,"WAIT {1}, {0}"
DATA 0x078,"WAIT {2}, {1}, {0}"
DATA 0x079,2,"WEND"
DATA 0x07a,2,"WHILE {0}"

'----------------------------------------------------------------------------
' 0x07b used in IDE watch mode. Probably 0x07c, too.
'----------------------------------------------------------------------------
DATA 0x07b,
DATA 0x07c,

DATA 0x07d,"prnmod::={prnmod:1} {0},|PRINT {0},"

'----------------------------------------------------------------------------
' 3 dummy tokens used in LINE statements
'----------------------------------------------------------------------------
DATA 0x07e,"{0}"
DATA 0x07f,"{0}"
DATA 0x080,"{0}"

'----------------------------------------------------------------------------
' graphics co-ordinates
'----------------------------------------------------------------------------
DATA 0x081,"1st-coord::=({1}, {0})"
DATA 0x082,"1st-coord::=STEP({1}, {0})"
DATA 0x083,"{1st-coord:2}-({1}, {0})|({1}, {0})"
DATA 0x084,"{1st-coord:2}-STEP({1}, {0})|-STEP({1}, {0})"

DATA 0x085,"FIELD {0}"
DATA 0x086,", {1} AS {0}"
DATA 0x087,"finput::=INPUT {0},"
DATA 0x088,"{input:1} {inputs:0}"
DATA 0x089,*,"input::=INPUT {##input-args}"
DATA 0x08a,"#{0}"

'----------------------------------------------------------------------------
' These two consume data, but I have no idea what they do. I haven't seen
' one in the wild.
'----------------------------------------------------------------------------
DATA 0x08c,2,""
'       0x08d,  4,      ""

'----------------------------------------------------------------------------
' Most of the PRINT stuff is here. The rules are pretty finicky. These
' sequences also apply to LPRINT and WRITE.
'----------------------------------------------------------------------------
DATA 0x08f,"prnsmc::={self|prncma|prnsrl:1} SPC({0});"
DATA "prnsmc::=SPC({0});"
DATA 0x090,"prnsmc::={self|prncma|prnsrl:1} TAB({0});"
DATA "prnsmc::=TAB({0});"

DATA 0x091,"prncma::={self|prnsmc|prnsrl:0} ,|,"

DATA 0x092,"prnsmc::={self:0}|{prncma|prnsrl:0} ;|;"

DATA 0x093,"{prnmod:2} {prnuse:1} {prnsrl|prnsmc|prncma:0}"
DATA "{prnmod:1} {prnsrl|prnsmc|prncma:0}"
DATA "{prnmod:1} {prnuse:0}"
DATA "{prnmod:1}"
DATA "PRINT {prnuse:1} {prnsrl|prnsmc|prncma:0}"
DATA "PRINT {prnsrl|prnsmc|prncma:0}"
DATA "PRINT {prnuse:0}"
DATA "PRINT"

DATA 0x094,"prnsrl::={prncma|prnsmc|self:1} {expr:0},|{expr:0},"
DATA 0x095,"prnsrl::={prncma|prnsmc|self:1} {expr:0};|{expr:0};"

DATA 0x096,"{prnmod:3} {prnuse:2} {prnsmc|prncma|prnsrl:1} {expr:0}"
DATA "{prnmod:2} {prnsmc|prncma|prnsrl:1} {expr:0}"
DATA "{prnmod:1} {prnsmc|prncma|prnsrl|expr:0}"
DATA "PRINT {prnuse:2} {prnsmc|prncma|prnsrl:1} {expr:0}"
DATA "PRINT {prnsmc|prncma|prnsrl:1} {expr:0}"
DATA "PRINT {prnsmc|prncma|prnsrl|expr:0}"


DATA 0x097,*,"{#tabi:0}'{#raw:2}"
'       0x098           nothing?
DATA 0x099,*,"$INCLUDE: '{#raw:0}"
DATA 0x09a,"BEEP"
DATA 0x09b,"BLOAD {0}"
DATA 0x09c,"BLOAD {1}, {0}"
DATA 0x09d,"BSAVE {2}, {1}, {0}"
DATA 0x09e,"CHDIR {0}"
DATA 0x09f,"CIRCLE {##circle-args}"
DATA 0x0a0,"CIRCLE {##circle-args}"
DATA 0x0a1,2,"CLEAR{##varargs}"
DATA 0x0a2,2,"CLOSE{##varargs}"
DATA 0x0a3,"CLS {expr:0}|CLS "
DATA 0x0a4,2,"COLOR{##varargs}"

DATA 0x0a5,4,"decl::=COMMON {declmod:0}{#blockname:2}"
DATA "decl::=COMMON{#blockname:2}"

DATA 0x0a6,*,"DATA{#cstr:2}"
DATA 0x0a7,"DATE$ = {0}"
DATA 0x0a8,"DEF SEG"
DATA 0x0a9,"DEF SEG = {0}"

DATA 0x0aa,"DRAW {0}"
DATA 0x0ab,"ENVIRON {0}"
DATA 0x0ac,2,"ERASE{##varargs}"
DATA 0x0ad,"ERROR {0}"
DATA 0x0ae,"FILES"
DATA 0x0af,"FILES {0}"

DATA 0x0b0,"GET {0}"
DATA 0x0b1,"GET {1}, {0}"
DATA 0x0b2,2,"GET {1}, , {0}"
DATA 0x0b3,2,"GET {2}, {1}, {0}"
DATA 0x0b4,"GET {1}, {0}"
DATA 0x0b5,2,"PUT {1}, {0}, {#action-verb}"


DATA 0x0b6,"inputs::={inputs:1}, {0}|{0}"
DATA 0x0b7,"IOCTL {1}, {0}"
DATA 0x0b8,2,"KEY {#keymode}"
DATA 0x0b9,"KEY {1}, {0}"
DATA 0x0ba,"KILL {0}"
DATA 0x0bb,2,"LINE {##line-args}"
DATA 0x0bc,2,"LINE {##line-args}"
DATA 0x0bd,2,"LINE {##line-args}"
DATA 0x0be,2,"LINE {##line-args}"
DATA 0x0bf,"LET "

DATA 0x0c0,2,"input::=LINE {finput:1} {0}"
DATA "input::=LINE INPUT {##input-args} {0}"

DATA 0x0c1,2,"LOCATE{##varargs}"
DATA 0x0c2,2,"LOCK {##lock-args}"
DATA 0x0c3,"prnmod::=LPRINT"
DATA 0x0c4,"LSET {0} = {1}"
DATA 0x0c5,"MID$({0}, {2}) = {1}"
DATA 0x0c6,"MID$({0}, {3}, {2}) = {1}"
DATA 0x0c7,"MKDIR {0}"
DATA 0x0c8,"NAME {1} AS {0}"

DATA 0x0c9,2,"OPEN {1} {#open-args} AS {0}"
DATA 0x0ca,2,"OPEN {2} {#open-args} AS {1} LEN = {0}"
DATA 0x0cb,"OPEN {2}, {1}, {0}"
DATA 0x0cc,"OPEN {3}, {2}, {1}, {0}"
DATA 0x0cd,"OPTION BASE 0"
DATA 0x0ce,"OPTION BASE 1"
DATA 0x0cf,"OUT {1}, {0}"



DATA 0x0d0,"PAINT {2}{nularg:1}{nularg:0}"
DATA "PAINT {2}, {nularg:1}, {0}"
DATA "PAINT {2}, {1}{nularg:0}"
DATA "PAINT {2}, {1}, {0}"
DATA 0x0d1,"PAINT {3}, {2}, {1}, {0}"
DATA 0x0d2,"PALETTE"
DATA 0x0d3,"PALETTE {1}, {0}"
DATA 0x0d4,"PALETTE {0}"
DATA 0x0d5,"PCOPY {1}, {0}"
DATA 0x0d6,"PLAY {0}"

DATA 0x0d7,"POKE {1}, {0}"
DATA 0x0d8,"PRESET {0}"
DATA 0x0d9,"PRESET {0}, {1}"
DATA 0x0da,"PSET {0}"
DATA 0x0db,"PSET {1}, {0}"
DATA 0x0dd,"PUT {1}, {0}"
DATA 0x0de,2,"PUT {1}, , {0}"
DATA 0x0df,2,"PUT {2}, {1}, {0}"

DATA 0x0e0,"RANDOMIZE"
DATA 0x0e1,"RANDOMIZE {0}"
DATA 0x0e2,"{self:1}, {0}|READ {0}"
DATA 0x0e3,*,"REM{#raw}"
DATA 0x0e4,"RESET"
DATA 0x0e5,"RMDIR {0}"
DATA 0x0e6,"RSET {0} = {1}"

DATA 0x0e7,2,"SCREEN{##varargs}"
DATA 0x0e8,"SEEK {1}, {0}"
DATA 0x0e9,"SHELL"
DATA 0x0ea,"SHELL {0}"
DATA 0x0eb,"SLEEP"
DATA 0x0ec,"SOUND {1}, {0}"
DATA 0x0ed,2,"SWAP {1}, {0}"
DATA 0x0ee,"SYSTEM"
DATA 0x0ef,"TIME$ = {0}"
DATA 0x0f0,"TROFF"
DATA 0x0f1,"TRON"
DATA 0x0f2,2,"UNLOCK {##lock-args}"
DATA 0x0f3,"VIEW ({5}, {4})-({3}, {2}){nularg:1}{nularg:0}"
DATA "VIEW ({5}, {4})-({3}, {2}), {nularg:1}, {0}"
DATA "VIEW ({5}, {4})-({3}, {2}), {1}{nularg:0}"
DATA "VIEW ({5}, {4})-({3}, {2})"
DATA 0x0f4,"VIEW"

DATA 0x0f5,"VIEW PRINT"
DATA 0x0f6,"VIEW PRINT {1} TO {0}"

DATA 0x0f7,"VIEW SCREEN ({5}, {4})-({3}, {2}){nularg:1}{nularg:0}"
DATA "VIEW SCREEN ({5}, {4})-({3}, {2}), {nularg:1}, {0}"
DATA "VIEW SCREEN ({5}, {4})-({3}, {2}), {1}{nularg:0}"
DATA "VIEW SCREEN ({5}, {4})-({3}, {2})"
DATA 0x0f8,"WIDTH {1}{nularg:0}|WIDTH {1}, {0}"
DATA 0x0f9,"WIDTH LPRINT {0}"
DATA 0x0fa,"WIDTH {1}, {0}"
DATA 0x0fb,"WINDOW ({3}, {2})-({1}, {0})"
DATA 0x0fc,"WINDOW"
DATA 0x0fd,"WINDOW SCREEN ({3}, {2})-({1}, {0})"
DATA 0x0fe,"prnmod::=WRITE"
DATA 0x0ff,"prnuse::=USING {0};"

DATA .default expr

DATA 0x100,"{1} + {0}"
DATA 0x101,"{1} AND {0}"
DATA 0x102,"{1} / {0}"
DATA 0x103,"{1} = {0}"
DATA 0x104,"{1} EQV {0}"
DATA 0x105,"ABS({0})"
DATA 0x106,"ASC({0})"
DATA 0x107,"ATN({0})"
DATA 0x108,"C{#type-abbr}({0})"
DATA 0x109,"CHR$({0})"
DATA 0x10a,"COMMAND$"
DATA 0x10b,"COS({0})"
DATA 0x10c,"CSRLIN"
DATA 0x10d,"CVD({0})"
DATA 0x10e,"CVDMBD({0})"
DATA 0x10f,"CVI({0})"
DATA 0x110,"CVL({0})"
DATA 0x111,"CVS({0})"
DATA 0x112,"CVSMBF({0})"
DATA 0x113,"DATE$"
DATA 0x114,"ENVIRON$({0})"
DATA 0x115,"EOF({0})"
DATA 0x116,"ERDEV"
DATA 0x117,"ERDEV$"
DATA 0x118,"ERL"
DATA 0x119,"ERR"
DATA 0x11a,"EXP({0})"
DATA 0x11b,"FILEATTR({1}, {0})"
DATA 0x11c,"FIX({0})"
DATA 0x11d,"FRE({0})"
DATA 0x11e,"FREEFILE"
DATA 0x11f,"HEX$({0})"
DATA 0x120,"INKEY$"
DATA 0x121,"INP({0})"
DATA 0x122,"INPUT$({0})"
DATA 0x123,"INPUT$({1}, {0})"
DATA 0x124,"INSTR({1}, {0})"
DATA 0x125,"INSTR({2}, {1}, {0})"
DATA 0x126,"INT({0})"
DATA 0x127,"IOCTL$({0})"
DATA 0x128,"LBOUND({0})"
DATA 0x129,"LBOUND({1}, {0})"
DATA 0x12a,"LCASE$({0})"
DATA 0x12b,"LTRIM$({0})"
DATA 0x12c,"LEFT$({1}, {0})"
DATA 0x12d,2,"LEN({0})"
DATA 0x12e,"LOC({0})"
DATA 0x12f,"LOF({0})"
DATA 0x130,"LOG({0})"
DATA 0x131,"LPOS({0})"
DATA 0x132,"MID$({1}, {0})"
DATA 0x133,"MID$({2}, {1}, {0})"
DATA 0x134,"MKD$({0})"
DATA 0x135,"MKDMBF$({0})"
DATA 0x136,"MKI$({0})"
DATA 0x137,"MKL$({0})"
DATA 0x138,"MKS$({0})"
DATA 0x139,"MKSMBF({0})"
DATA 0x13a,"OCT$({0})"
DATA 0x13b,"PEEK({0})"
DATA 0x13c,"PEN"
DATA 0x13d,"PLAY"
DATA 0x13e,"PMAP({1}, {0})"
DATA 0x13f,"POINT({0})"
DATA 0x140,"POINT({1}, {0})"
DATA 0x141,"POS({0})"
DATA 0x142,"RIGHT$({1}, {0})"
DATA 0x143,"RND"
DATA 0x144,"RND({0})"
DATA 0x145,"RTRIM$({0})"
DATA 0x146,"SADD({0})"
DATA 0x147,"SCREEN({1}, {0})"
DATA 0x148,"SCREEN({2}, {1}, {0})"
DATA 0x149,"SEEK({0})"
DATA 0x14a,"SETMEM({0})"
DATA 0x14b,"SGN({0})"
DATA 0x14c,"SHELL({0})"
DATA 0x14d,"SIN({0})"
DATA 0x14e,"SPACE$({0})"
DATA 0x14f,"SQR({0})"
DATA 0x150,"STICK({0})"
DATA 0x151,"STR$({0})"
DATA 0x152,"STRIG({0})"
DATA 0x153,"STRING$({1}, {0})"
DATA 0x154,"TAN({0})"
DATA 0x155,"TIME$"
DATA 0x156,"TIMER"
DATA 0x157,"UBOUND({0})"
DATA 0x158,"UBOUND({1}, {0})"
DATA 0x159,"UCASE$({0})"
DATA 0x15a,"VAL({0})"
DATA 0x15b,"VARPTR({0})"
DATA 0x15c,2,"VARPTR$({0})"
DATA 0x15d,"VARSEG({0})"
DATA 0x15e,"{1} >= {0}"
DATA 0x15f,"{1} > {0}"
DATA 0x160,"{1} \ {0}"
DATA 0x161,"{1} IMP {0}"
DATA 0x162,"{1} <= {0}"
DATA 0x163,"{1} < {0}"
DATA 0x164,"{#hprm}"
DATA 0x165,2,"{#int}"
DATA 0x166,4,"{#lng}"
DATA 0x167,2,"{#int&h}"
DATA 0x168,4,"{#lng&h}"
DATA 0x169,2,"{#int&o}"
DATA 0x16a,4,"{#lng&o}"
DATA 0x16b,4,"{#sng}"
DATA 0x16c,8,"{#dbl}"
DATA 0x16d,*,"{#qstr}"
DATA 0x16e,"({0})"
DATA 0x16f,"{1} MOD {0}"
DATA 0x170,"{1} * {0}"
DATA 0x171,"{1} <> {0}"
DATA 0x172,"{#nul}"
DATA 0x173,"nularg::={#nul}"
DATA 0x174,"NOT {0}"
DATA 0x175,"{1} OR {0}"
DATA 0x176,"{1} ^ {0}"
DATA 0x177,"{1} - {0}"
DATA 0x178,"-{0}"
DATA 0x179,"{1} XOR {0}"

DATA .default

DATA 0x17a,"UEVENT"
DATA 0x17b,"SLEEP {0}"
DATA 0x17c,6,"astype::={#tabi:4}AS STRING * {#int:2}"
DATA 0x17d,2,"decl::=DIM {declmod:0}|DIM"

DATA .

REM $STATIC
'
' This subroutine is called whenever a program line has been decoded.
'
SUB AOutput (ProgramLine AS STRING)

    STATIC OutputLines

    OutputLines = OutputLines + 1

    IF LEN(OutputContents$) THEN
        OutputContents$ = OutputContents$ + CHR$(10) + ProgramLine
    ELSE
        OutputContents$ = ProgramLine
    END IF

END SUB

SUB DbgOutput (DbgTxt AS STRING)

    EXIT SUB

    PRINT #5, DbgTxt

END SUB

FUNCTION DbgPlainText$ (Txt2$)

    Txt$ = Txt2$

    DO
        Marker = INSTR(Txt$, MKL$(0))
        IF Marker = 0 THEN EXIT DO

        TagTxtLen = CVI(MID$(Txt$, Marker + 4, 2))
        TagParam = CVI(MID$(Txt$, Marker + 6, 2))
        TagTxt$ = MID$(Txt$, Marker + 8, TagTxtLen)

        TagParam$ = ITOA(TagParam)
        IF TagParam > 0 THEN TagParam$ = "+" + TagParam$
        TagParam$ = "$" + TagParam$
        IF TagTxt$ <> "" THEN TagParam$ = TagTxt$ + ":" + TagParam$


        Txt$ = LEFT$(Txt$, Marker - 1) + "{" + TagParam$ + "}" + MID$(Txt$, Marker + 8 + TagTxtLen)

    LOOP


    DO
        Marker = INSTR(Txt$, CHR$(&HD))
        IF Marker = 0 THEN EXIT DO

        IF CVI(MID$(Txt$, Marker, 2)) = &HD THEN
            Txt$ = LEFT$(Txt$, Marker - 1) + "®newline¯" + MID$(Txt$, Marker + 2)
        ELSEIF CVI(MID$(Txt$, Marker, 2)) = &H10D THEN
            Txt$ = LEFT$(Txt$, Marker - 1) + "®indent¯" + MID$(Txt$, Marker + 4)
        ELSE
            Txt$ = LEFT$(Txt$, Marker - 1) + "®rle¯" + MID$(Txt$, Marker + 3)
        END IF

    LOOP

    DbgPlainText$ = Txt$

END FUNCTION

'
' Iterates through the various rules for a token contained in the ParseRules
' array and stops when one of them works.
'
SUB DefaultParseRule

    DIM ParseRule AS STRING

    IF PCODE < LBOUND(ParseRules) OR PCODE > UBOUND(ParseRules) THEN EXIT SUB
    ParseRule = ParseRules(PCODE)

    IF ParseRule = "" THEN EXIT SUB

    DbgOutput ""
    DbgOutput "PCODE = 0x" + HEX$(PCODE)
    DbgOutput "HPARAM = 0x" + HEX$(HPARAM)
    DbgOutput ""
    'DumpStack

    FOR RuleBegin = 3 TO LEN(ParseRule) STEP 4

        RuleLn = CVI(MID$(ParseRule, RuleBegin + 0, 2))
        RuleID = CVI(MID$(ParseRule, RuleBegin + 2, 2))

        RuleTxt$ = MID$(ParseRule, RuleBegin + 4, RuleLn)

        IF ExecuteParseRule(RuleID, RuleTxt$) THEN EXIT FOR

        RuleBegin = RuleBegin + RuleLn

    NEXT RuleBegin

END SUB

'
' Returns the string of the first rule in a compound|parse|rule, and removes
' it from the input string.
'
' If the rule does not have a rule id (ident::=), DefaultRuleID is assigned.
'
FUNCTION DelimitParseRule$ (ParseRule AS STRING, DefaultRuleID AS STRING)

    DIM FirstRule AS STRING

    '----------------------------------------------------------------------------
    ' Locate the first instance of the rule delimiter "|" that does not occur
    ' inside a rule {tag}
    '----------------------------------------------------------------------------
    RuleOffset = 1
    RuleEnd = LEN(ParseRule) + 1

    DO

        BraceOffset = INSTR(RuleOffset, ParseRule, "{")
        IF BraceOffset = 0 THEN BraceOffset = RuleEnd

        PipeOffset = INSTR(RuleOffset, ParseRule, "|")

        RuleOffset = INSTR(BraceOffset, ParseRule, "}")
        IF RuleOffset = 0 THEN RuleOffset = RuleEnd

    LOOP UNTIL PipeOffset < BraceOffset

    IF PipeOffset = 0 THEN PipeOffset = RuleEnd


    '----------------------------------------------------------------------------
    ' Extract the first rule and return if there is nothing left.
    '----------------------------------------------------------------------------
    FirstRule = LEFT$(ParseRule, PipeOffset - 1)
    ParseRule = MID$(ParseRule, PipeOffset + 1)


    '----------------------------------------------------------------------------
    ' If the first rule has a symbol on the left-hand side and the next rule
    ' does not, the next rule inherits the symbol.
    '----------------------------------------------------------------------------
    RuleLHS$ = GetParseRuleLHS(FirstRule)

    IF RuleLHS$ = "" AND DefaultRuleID <> "" THEN
        RuleLHS$ = DefaultRuleID
        FirstRule = DefaultRuleID + "::=" + FirstRule
    END IF

    DelimitParseRule = FirstRule
    IF ParseRule = "" THEN EXIT FUNCTION

    IF RuleLHS$ <> "" AND GetParseRuleLHS(ParseRule) = "" THEN
        ParseRule = RuleLHS$ + "::=" + ParseRule
    END IF

END FUNCTION

'
' For debugging only
'
SUB DumpStack

    PRINT #5, "The stack has"; SP; "entries"

    FOR i = 1 TO SP
        ID = CVI(LEFT$(STACK(i), 2))
        Txt$ = MID$(STACK(i), 3)


        DO
            Marker = INSTR(Txt$, CHR$(&HD))
            IF Marker = 0 THEN EXIT DO

            IF CVI(MID$(Txt$, Marker, 2)) = &HD THEN
                Txt$ = LEFT$(Txt$, Marker - 1) + "®newline¯" + MID$(Txt$, Marker + 2)
            ELSEIF CVI(MID$(Txt$, Marker, 2)) = &H10D THEN
                Txt$ = LEFT$(Txt$, Marker - 1) + "®indent¯" + MID$(Txt$, Marker + 4)
            ELSE
                Txt$ = LEFT$(Txt$, Marker - 1) + "®rle¯" + MID$(Txt$, Marker + 3)
            END IF

        LOOP

        PRINT #5, ITOA$(i); ": 0x"; HEX$(ID),

        TRIM = 76 - POS(0) - LEN(Txt$)
        IF TRIM < 0 THEN PRINT #5, LEFT$(Txt$, LEN(Txt$) + TRIM); " ..." ELSE PRINT #5, Txt$
        '80-60-19=1



    NEXT i
END SUB

FUNCTION ExecuteParseRule% (RuleID AS INTEGER, ParseRule AS STRING)

    DIM RuleTxt AS STRING
    DIM TagTxt AS STRING
    DIM OutTxt AS STRING

    RuleOffset = 1

    '
    ' NOTE: Since the stack is flushed immediately upon seeing a leading period,
    ' rules should not have non-flushing alternatives.
    '
    IF LEFT$(ParseRule, 1) = "." THEN
        FlushStack
        RuleOffset = 2
    END IF

    InitialSP = SP
    FinalSP = SP
    RuleTxt = ParseRule

    DbgOutput "Trying rule: " + Quote(ParseRule)

    DO

        DbgOutput "Rule: " + ParseRule
        DbgOutput "Output: " + OutTxt

        TagBegin = INSTR(RuleOffset, RuleTxt, "{")
        IF TagBegin = 0 THEN TagBegin = LEN(RuleTxt) + 1

        TagEnd = INSTR(TagBegin, RuleTxt, "}") + 1

        OutTxt = OutTxt + MID$(RuleTxt, RuleOffset, TagBegin - RuleOffset)

        IF TagEnd <= TagBegin THEN EXIT DO

        TagTxt = MID$(RuleTxt, TagBegin + 1, TagEnd - TagBegin - 2)

        SELECT CASE TokenizeTag(TagTxt, TagParam)

            '------------------------------------------------------------------------
            ' If a relative stack tag is used, we will need to wait until all the
            ' absolute tags have been processed before we can calculate the tag
            ' offset, so we insert a marker into OutTxt.
            '------------------------------------------------------------------------
            CASE TagType.StackREL
                OutTxt = OutTxt + MKL$(0) + MKI$(LEN(TagTxt)) + MKI$(TagParam) + TagTxt
                RuleOffset = TagEnd


            CASE TagType.StackABS

                IF NOT ValidateStackTag(RuleID, TagTxt, TagParam) THEN
                    ExecuteParseRule = 0
                    DbgOutput "Rule REJECTED!"
                    EXIT FUNCTION
                ELSE
                    IF OffsetSP < SP THEN OutTxt = OutTxt + MID$(STACK(SP - TagParam), 3)
                    IF SP - TagParam - 1 < FinalSP THEN FinalSP = SP - TagParam - 1
                END IF

                RuleOffset = TagEnd


            CASE TagType.Recursive
                RuleTxt = LEFT$(RuleTxt, TagBegin - 1) + GetTaggedItem(TagTxt, TagParam) + MID$(RuleTxt, TagEnd)
                RuleOffset = TagBegin


            CASE TagType.TokenData
                OutTxt = OutTxt + GetTaggedItem(TagTxt, TagParam)
                RuleOffset = TagEnd


        END SELECT




    LOOP WHILE RuleOffset <= LEN(RuleTxt)

    DbgOutput "Rule: " + ParseRule
    DbgOutput "Output: " + OutTxt

    SP = FinalSP

    DO
        Marker = INSTR(OutTxt, MKL$(0))
        IF Marker = 0 THEN EXIT DO

        TagTxtLen = CVI(MID$(OutTxt, Marker + 4, 2))
        TagParam = CVI(MID$(OutTxt, Marker + 6, 2))
        TagTxt = MID$(OutTxt, Marker + 8, TagTxtLen)

        IF NOT (ValidateStackTag(RuleID, TagTxt, TagParam)) THEN
            SP = InitialSP
            ExecuteParseRule = 0
            DbgOutput "Rule REJECTED!"
            EXIT FUNCTION
        END IF

        OutTxt = LEFT$(OutTxt, Marker - 1) + MID$(STACK(SP - TagParam), 3) + MID$(OutTxt, Marker + 8 + TagTxtLen)
        IF SP - TagParam - 1 < FinalSP THEN FinalSP = SP - TagParam - 1
    LOOP

    FOR SP = InitialSP TO FinalSP + 1 STEP -1: STACK(SP) = "": NEXT SP
    SP = FinalSP

    PUSH RuleID, OutTxt
    ExecuteParseRule = -1

    DbgOutput "Rule ACCEPTED!"

    'PCODE = RuleID

END FUNCTION

FUNCTION ExtractProgramLine% (ProgramLine AS STRING)

END FUNCTION

'
' Generates a /blockname/ as used in COMMON statements, using the ID at
' CODE(DP)
'
FUNCTION FetchBlockName$ (DP AS INTEGER)

    ID = FetchINT(DP)
    IF ID <> -1 THEN x$ = " /" + GetID(ID) + "/" ELSE x$ = ""

END FUNCTION

'
' Reads a null-terminate string. These are only found in DATA statements
' and the null always seems to be at the end of the string anyway, but we
' will process it properly to be sure.
'
FUNCTION FetchCSTR$ (DP AS INTEGER)

    CSTR$ = FetchRAW(DP)

    null = INSTR(CSTR$, CHR$(0))

    IF null THEN CSTR$ = LEFT$(CSTR$, null - 1)

    FetchCSTR$ = CSTR$

END FUNCTION

'
' Fetches an identifier from the current TOKEN data by performing a symbol
' table lookup on the word at the specified offset.
'
FUNCTION FetchID$ (Offset AS INTEGER)

    FetchID$ = ""

    IF Offset < 0 OR Offset > LEN(TOKEN) - 4 THEN EXIT FUNCTION

    FetchID$ = GetID(CVI(MID$(TOKEN, Offset + 3, 2)))

END FUNCTION

FUNCTION FetchIDList$ (DP AS INTEGER)


    TkLen = LEN(TOKEN)
    IF DP < 0 OR DP > TkLen - 2 THEN EXIT FUNCTION

    FOR i = DP + 3 TO TkLen - 1 STEP 2

        ID$ = GetID(CVI(MID$(TOKEN, i, 2)))

        IF IdList$ <> "" THEN IdList$ = IdList$ + ", "
        IdList$ = IdList$ + ID$

    NEXT i

    FetchIDList = IdList$

END FUNCTION

'
' Returns the integer at the specified zero-based offset from the start
' of the token data.
'
FUNCTION FetchINT% (Offset AS INTEGER)

    FetchINT = -1

    IF Offset < 0 OR Offset > LEN(TOKEN) - 4 THEN EXIT FUNCTION

    FetchINT = CVI(MID$(TOKEN, Offset + 3, 2))

END FUNCTION

'
' Returns the integer at the specified zero-based offset from the start
' of the token data as a LONG value.
'
FUNCTION FetchINTASLONG& (Offset AS INTEGER)

    FetchINTASLONG = -1

    IF Offset < 0 OR Offset > LEN(TOKEN) - 4 THEN EXIT FUNCTION

    FetchINTASLONG = CVI(MID$(TOKEN, Offset + 3, 2)) AND &HFFFF&

END FUNCTION

'
' Reads a literal 64-bit float from the p-code and returns its string
' representation. Using the "{dbl}" tag in the SHIFT procedure is a more
' convienient method to extract literals.
'
' The IP is passed by reference, and will be incremented to the code
' following the literal. There is no radix option for floating point values.
'
FUNCTION FetchLiteralDBL$ (DP)

    IF DP > UBOUND(CODE) THEN
        FetchLiteralDBL$ = "0#"
        EXIT FUNCTION
    END IF

    Value# = CVD(MID$(TOKEN, DP + 3, 8))
    Txt$ = LTRIM$(STR$(Value#))


    ' If the single and double precision representations are equal, we will
    ' insert a # to indicate double precision.

    IF Value# = CSNG(Value#) THEN Txt$ = Txt$ + "#"

    FetchLiteralDBL$ = Txt$

END FUNCTION

'
' Reads a literal 16-bit integer from the code and returns its string
' representation. Using the "{int}" tag in ExecuteParseRule is a more
' convienient method to extract literals.
'
' The Radix parameter may be 8, 10 or 16 to produce
' the desired number format, or use the "{int&o}" and "{int&h}" tags.
'
FUNCTION FetchLiteralINT$ (Offset AS INTEGER, Radix AS INTEGER)

    DIM Value AS INTEGER

    IF Offset < 0 OR Offset > LEN(TOKEN) - 4 THEN
        FetchLiteralINT$ = "0"
        EXIT FUNCTION
    END IF

    Value = CVI(MID$(TOKEN, Offset + 3, 2))

    SELECT CASE Radix

        CASE 8: Txt$ = "&O" + OCT$(Value)
        CASE 10: Txt$ = ITOA$(Value)
        CASE 16: Txt$ = "&H" + HEX$(Value)

        CASE ELSE: Txt$ = "[bad radix]"

    END SELECT

    FetchLiteralINT$ = Txt$

END FUNCTION

'
' Reads a literal 32-bit integer from the code and returns its string
' representation. Using the "{lng}" tag in ExecuteParseRule is a more
' convienient method to extract literals.
'
' The Radix parameter may be 8, 10 or 16 to produce the desired number
' format, or use the "{lng&o}" and "{lng&h}" tags.
'
FUNCTION FetchLiteralLNG$ (Offset AS INTEGER, Radix AS INTEGER)

    DIM Value AS LONG

    IF Offset < 0 OR Offset > LEN(TOKEN) - 6 THEN
        FetchLiteralLNG$ = "0"
        EXIT FUNCTION
    END IF

    Value = CVL(MID$(TOKEN, Offset + 3, 4))

    SELECT CASE Radix

        CASE 8: Txt$ = "&O" + OCT$(Value)
        CASE 10: Txt$ = LTOA$(Value)
        CASE 16: Txt$ = "&H" + HEX$(Value)

        CASE ELSE: Txt$ = "[bad radix]"

    END SELECT

    IF Value < 65536 THEN Txt$ = Txt$ + "&"

    FetchLiteralLNG$ = Txt$

END FUNCTION

'
' Reads a literal 32-bit float from the p-code and returns its string
' representation. Using the "{sng}" tag in the SHIFT procedure is a more
' convienient method to extract literals.
'
' The IP is passed by reference, and will be incremented to the code
' following the literal. There is no radix option for floating point values.
'
FUNCTION FetchLiteralSNG$ (DP)

    IF OffsetIP > UBOUND(CODE) THEN
        FetchLiteralSNG$ = "0"
        EXIT FUNCTION
    END IF

    Value! = CVS(MID$(TOKEN, DP + 3, 4))

    Txt$ = LTRIM$(STR$(Value!))

    FetchLiteralSNG$ = Txt$

END FUNCTION

FUNCTION FetchLNG& (Offset AS INTEGER)

    FetchLNG = -1

    IF Offset < 0 OR Offset > LEN(TOKEN) - 6 THEN EXIT FUNCTION

    FetchLNG = CVL(MID$(TOKEN, Offset + 3, 4))

END FUNCTION

FUNCTION FetchRAW$ (Offset AS INTEGER)

    IF Offset < 0 OR Offset > LEN(TOKEN) - 2 THEN EXIT FUNCTION

    FetchRAW$ = MID$(TOKEN, 3 + Offset)

END FUNCTION

FUNCTION FindRuleDelimiter% (ParseRule AS STRING)

    RuleOffset = 1
    RuleEnd = LEN(ParseRule) + 1

    DO WHILE RuleOffset < RuleEnd

        BraceOffset = INSTR(RuleOffset, ParseRule, "{")
        PipeOffset = INSTR(RuleOffset, ParseRule, "|")

        IF BraceOffset = 0 OR PipeOffset <= BraceOffset THEN EXIT DO

        RuleOffset = INSTR(BraceOffset + 1, ParseRule, "}")
        IF RuleOffset = 1 THEN EXIT DO

    LOOP

    FindRuleDelimiter = PipeOffset

END FUNCTION

'
' Flushes all stack entries to STACK(0), ready for final processing into
' a program line.
'
SUB FlushStack

    FOR i = 1 TO SP
        STACK(0) = STACK(0) + MID$(STACK(i), 3)
        STACK(i) = ""
    NEXT i

    SP = 0

END SUB

'
' Returns an integer identifier for a parse rule symbol
'
FUNCTION GetHashedSymbol (ParseRuleSymbol AS STRING)
    DIM LookupSymbol AS STRING

    SymbolID$ = LTRIM$(RTRIM$(ParseRuleSymbol))

    '----------------------------------------------------------------------------
    ' Parse rule symbols my be literal integers
    '----------------------------------------------------------------------------
    IF StringToINT(SymbolID$, SymbolID%) THEN
        GetHashedSymbol% = SymbolID%
        EXIT FUNCTION
    END IF

    Hash = HashPJW(SymbolID$)

    LookupSymbol = "[" + SymbolID$ + "]"

    SymbolOffset = INSTR(SymbolHashTable(Hash), LookupSymbol)

    IF SymbolOffset = 0 THEN

        SymbolID% = SymbolHashEntries
        SymbolID% = SymbolID% + UBOUND(ParseRules) + 1
        SymbolID$ = RIGHT$(SymbolHashTable(Hash), 2)
        IF SymbolID$ <> "" THEN SymbolID% = CVI(SymbolID$) + 1

        SymbolID$ = MKI$(SymbolID%)

        SymbolHashTable(Hash) = SymbolHashTable(Hash) + LookupSymbol + SymbolID$

        SymbolHashEntries = SymbolHashEntries + 1

    ELSE

        SymbolOffset = SymbolOffset + LEN(LookupSymbol)

        SymbolID$ = MID$(SymbolHashTable(Hash), SymbolOffset, 2)
        SymbolID% = CVI(SymbolID$)

    END IF

    GetHashedSymbol% = SymbolID% '+ UBOUND(ParseRules) + 1


END FUNCTION

'
' Reads an identifier from the symbol table data stored in the SYMTBL
' array.
'
FUNCTION GetID$ (SymTblOffset AS INTEGER)

    '----------------------------------------------------------------------------
    ' Convert offset to LONG to we can read above 32767
    '----------------------------------------------------------------------------
    SymTblOfs& = SymTblOffset AND &HFFFF&

    '----------------------------------------------------------------------------
    ' offset FFFF is used as a shortcut for "0" in statements such as
    ' ON ERROR GOTO 0
    '----------------------------------------------------------------------------
    IF SymTblOfs& = &HFFFF& THEN
        GetID$ = "0"
        EXIT FUNCTION
    END IF


    '----------------------------------------------------------------------------
    ' Make sure we can at least read the first 4 bytes
    '----------------------------------------------------------------------------
    IF SymTblOfs& \ 2 > UBOUND(SYMTBL) - 2 THEN
        GetID$ = "®QB45BIN:SymbolTableError¯"
        EXIT FUNCTION
    END IF

    DEF SEG = VARSEG(SYMTBL(1))
    Offset = VARPTR(SYMTBL(1))

    Symbol& = (Offset AND &HFFFF&) + SymTblOfs&

    SymbolFlags = PEEK(Symbol& + 2)

    IF SymbolFlags AND 2 THEN

        ' Short line numbers are stored as integers.

        NumericID& = PEEK(Symbol& + 4) OR PEEK(Symbol& + 5) * &H100&
        GetID$ = LTRIM$(STR$(NumericID&))
    ELSE

        ' Identifier is a text string - extract it. Note the string may be
        ' a line number.

        Length = PEEK(Symbol& + 3)

        IF SymTblOfs& \ 2 > UBOUND(SYMTBL) - (Length + 1) \ 2 THEN
            GetID$ = "SymbolTableError"
            EXIT FUNCTION
        END IF

        ID$ = STRING$(Length, CHR$(0))
        FOR i = 1 TO Length
            MID$(ID$, i, 1) = CHR$(PEEK(Symbol& + 3 + i))
        NEXT i

        GetID$ = ID$
    END IF


END FUNCTION

'
' Removes the parse rule id::= from a string and returns its numeric ID.
'
FUNCTION GetParseRuleID% (ParseRule AS STRING, TokenID AS INTEGER)

    '----------------------------------------------------------------------------
    ' The default rule ID is always the PCODE
    '----------------------------------------------------------------------------

    FOR i = 1 TO LEN(ParseRule)

        IF INSTR("{}|", MID$(ParseRule, i, 1)) THEN EXIT FOR

        IF MID$(ParseRule, i, 3) = "::=" THEN
            GetParseRuleID = SetHashedSymbol(LEFT$(ParseRule, i - 1), TokenID)
            ParseRule = MID$(ParseRule, i + 3)
            EXIT FUNCTION
        END IF

    NEXT i

    GetParseRuleID = -1

END FUNCTION

FUNCTION GetParseRuleLHS$ (ParseRule AS STRING)

    FOR i = 1 TO LEN(ParseRule)

        IF INSTR("{}|", MID$(ParseRule, i, 1)) THEN EXIT FOR

        IF MID$(ParseRule, i, 3) = "::=" THEN
            GetParseRuleLHS = LEFT$(ParseRule, i - 1)
            EXIT FUNCTION
        END IF

    NEXT i

END FUNCTION

FUNCTION GetTaggedItem$ (TagTxt AS STRING, DP AS INTEGER)
 
    DIM SubstTxt AS STRING

    SELECT CASE LCASE$(TagTxt)
     
        CASE "blockname": SubstTxt = FetchBlockName(DP)
        CASE "circle-args": SubstTxt = SubstTagCIRCLE
        CASE "input-args": SubstTxt = SubstTagINPUT
        CASE "line-args": SubstTxt = SubstTagLINE
        CASE "lock-args": SubstTxt = SubstTagLOCK

        CASE "open-args": SubstTxt = SubstTagOPEN
        CASE "action-verb": SubstTxt = SubstTagVERB
        CASE "keymode": SubstTxt = SubstTagKEY
        CASE "type-abbr": SubstTxt = GetTypeAbbr(HPARAM)

        CASE "call": SubstTxt = ParseCALL(0)
        CASE "call()": SubstTxt = ParseCALL(-1)

        CASE "defxxx": SubstTxt = SubstTagDEFxxx(QBBinDefType())
        CASE "newline": SubstTxt = MKI$(&H10D)

        CASE "newline-include": SubstTxt = MKI$(&H20D)

        CASE "tabh": SubstTxt = MKI$(&HD) + MKI$(HPARAM)
        CASE "tabi": SubstTxt = MKI$(&HD) + MKI$(FetchINT(DP))
        CASE "indent": SubstTxt = SPACE$(FetchINT(DP) AND &HFFFF&)
        CASE "type": SubstTxt = GetTypeName$(FetchINT(DP))
        CASE "id": SubstTxt = GetID(FetchINT(DP))
        CASE "id+": SubstTxt = GetID(FetchINT(DP)) + GetTypeSuffix(HPARAM)
        CASE "id-list": SubstTxt = FetchIDList(DP)
        CASE "id(decl)": SubstTxt = ParseArrayDecl
        CASE "id(expr)": SubstTxt = ParseArrayExpr

        CASE "hprm": SubstTxt = ITOA$(HPARAM)
        CASE "int": SubstTxt = FetchLiteralINT(DP, 10)
        CASE "int&h": SubstTxt = FetchLiteralINT(DP, 16)
        CASE "int&o": SubstTxt = FetchLiteralINT(DP, 8)
        CASE "label": SubstTxt = FetchID(DP): IF IsLineNumber(SubstTxt) THEN SubstTxt = SubstTxt + " " ELSE SubstTxt = SubstTxt + ":"

        CASE "lng": SubstTxt = FetchLiteralLNG(DP, 10)
        CASE "lng&h": SubstTxt = FetchLiteralLNG(DP, 16)
        CASE "lng&o": SubstTxt = FetchLiteralLNG(DP, 8)
        CASE "nul": SubstTxt = ""
        CASE "sng": SubstTxt = FetchLiteralSNG(DP)
        CASE "dbl": SubstTxt = FetchLiteralDBL(DP)
        CASE "qstr": SubstTxt = Quote(FetchRAW(DP))
        CASE "cstr": SubstTxt = FetchCSTR(DP)
        CASE "raw": SubstTxt = FetchRAW(DP)
        CASE "varargs": SubstTxt = ParseVarArgs
        CASE "optargs":
        CASE "procdecl": SubstTxt = ParseProcDecl$(DP, 0)
        CASE "procdecl()": SubstTxt = ParseProcDecl$(DP, -1)
        CASE "proctype": SubstTxt = QBBinProcedureType

        CASE "thaddr": SanityCheck DP

        CASE ELSE:
            SubstTxt = "®QB45BIN:bad tag¯"
    END SELECT

    GetTaggedItem$ = SubstTxt

END FUNCTION

FUNCTION GetTotalLines%

    DIM TotalLines AS LONG
    DIM IncludeLines AS LONG

    TotalLines = 0
    IncludeLines = 0

    FTell& = LOC(QBBinFile) + 1

    GET #QBBinFile, 27, SymTblLen%
    ModuleLOC& = LOC(QBBinFile) + (SymTblLen% AND &HFFFF&) + 1

    SEEK #QBBinFile, ModuleLOC&

    DO
        GET #QBBinFile, , ModuleLen%
        SEEK #QBBinFile, LOC(QBBinFile) + (ModuleLen% AND &HFFFF&) + 9

        GET #QBBinFile, , NumTotLines%
        GET #QBBinFile, , NumIncLines%

        TotalLines = TotalLines + (NumTotLines% AND &HFFFF&)
        IncludeLines = IncludeLines + (NumIncLines% AND &HFFFF&)


        SEEK #QBBinFile, LOC(QBBinFile) + 5
        Byte$ = CHR$(0)
        GET #QBBinFile, , Byte$

        IF EOF(QBBinFile) THEN EXIT DO

        ProcedureCOUNT = ProcedureCOUNT + 1

        GET #QBBinFile, , NameLen%
        SEEK #QBBinFile, LOC(QBBinFile) + (NameLen% AND &HFFFF&) + 4

    LOOP

    REDIM ProcedureNAME(1 TO ProcedureCOUNT + 1) AS STRING
    REDIM ProcedureLOC(1 TO ProcedureCOUNT + 1) AS LONG

    SEEK #QBBinFile, ModuleLOC&

    FOR i = 1 TO ProcedureCOUNT

        GET #QBBinFile, , ModuleLen%

        ProcedureLOC(i) = LOC(QBBinFile) + (ModuleLen% AND &HFFFF&) + 17
        SEEK #QBBinFile, ProcedureLOC(i) + 1

        GET #QBBinFile, , ProcedureNameLEN%
        ProcedureNAME(i) = STRING$(ProcedureNameLEN%, 0)
        GET #QBBinFile, , ProcedureNAME(i)
        ProcedureNAME(i) = UCASE$(ProcedureNAME(i))

        '------------------------------------------------------------------------
        ' Incremental bubble sort of procedure names
        '------------------------------------------------------------------------
        IF QBBinOption.SortProceduresAZ THEN
            FOR j = i - 1 TO 1 STEP -1
                IF ProcedureNAME(j + 1) > ProcedureNAME(j) THEN EXIT FOR
                SWAP ProcedureNAME(j + 1), ProcedureNAME(j)
                SWAP ProcedureLOC(j + 1), ProcedureLOC(j)
            NEXT j
        END IF

        SEEK #QBBinFile, LOC(QBBinFile) + 4
    NEXT i

    FOR i = 1 TO ProcedureCOUNT
        'PRINT ProcedureNAME(i)
        QBBinProcedureIndex = QBBinProcedureIndex + MKL$(ProcedureLOC(i))
    NEXT i

    ERASE ProcedureNAME, ProcedureLOC

    SEEK #QBBinFile, FTell&

    IF QBBinOption.OmitIncludedLines THEN
        GetTotalLines = TotalLines - IncludedLines
    ELSE
        GetTotalLines = TotalLines
    END IF

END FUNCTION

'
' Returns the abbreviated name for a built-in type (ie: LNG or DBL).
'
FUNCTION GetTypeAbbr$ (TypeID AS INTEGER)

    GetTypeAbbr$ = TypeSpecifiers(LIMIT(TypeID, 0, 5), 2)

END FUNCTION

FUNCTION GetTypeName$ (TypeID AS INTEGER)

    LTypeID& = TypeID AND &HFFFF&

    IF LTypeID& > 5 THEN
        GetTypeName$ = GetID$(TypeID) ' User-define type
    ELSE
        GetTypeName$ = TypeSpecifiers(LTypeID&, 1)
    END IF

END FUNCTION

FUNCTION GetTypeSuffix$ (TypeID AS INTEGER)

    GetTypeSuffix$ = TypeSpecifiers(LIMIT(TypeID, 0, 5), 3)

END FUNCTION

'
' Implementation of PJW hash, written to avoid 32-bit overflow.
'
FUNCTION HashPJW% (Identifier AS STRING)

    DIM h AS LONG, g AS LONG, k AS LONG


    FOR i = 1 TO LEN(Identifier)

        k = ASC(MID$(Identifier, i, 1))

        h = h + (k \ 16)

        g = (h AND &HF000000) \ 2 ^ 20

        h = (h AND &HFFFFFF) * 16 + (k AND 15)

        IF g THEN h = h XOR (g \ 2 ^ 20)

    NEXT i

    HashPJW% = h MOD SymbolHashBuckets

END FUNCTION

FUNCTION IsLineNumber (ID AS STRING)

    Ch$ = LEFT$(ID, 1)
    IF Ch$ = "" THEN EXIT FUNCTION
    IF ASC(Ch$) >= 48 AND ASC(Ch$) < 57 THEN IsLineNumber = -1

END FUNCTION

FUNCTION ITOA$ (Value AS INTEGER)

    ITOA$ = LTRIM$(RTRIM$(STR$(Value)))

END FUNCTION

FUNCTION LIMIT (x, xMin, xMax)

    IF x < xMin THEN
        LIMIT = xMin

    ELSEIF x > xMax THEN
        LIMIT = xMax

    ELSE
        LIMIT = x
    END IF

END FUNCTION

FUNCTION LoadMainModule

    '----------------------------------------------------------------------------
    ' Read module size and convert to long to lose sign bit. Note that modules
    ' should always be a multiple of two in size since all the tokens are 16
    ' bits.
    '----------------------------------------------------------------------------
    IF EOF(QBBinFile) THEN EXIT FUNCTION

    GET #QBBinFile, , szModule%
    szModule& = (szModule% AND &HFFFF&)
    szModule% = (szModule& + 1) \ 2

    REDIM CODE(1 TO szModule%) AS INTEGER
    ReadToArrayINT QBBinFile, CODE(), szModule&

    '----------------------------------------------------------------------------
    ' There is always 16 bytes of data after a code block
    '----------------------------------------------------------------------------
    DIM Footer AS STRING * 16
    GET #QBBinFile, , Footer

    IF EOF(QBBinFile) THEN
        QBBinCloseFile
        EXIT FUNCTION
    END IF

    LoadMainModule = -1
    IP = LBOUND(CODE)

END FUNCTION

FUNCTION LoadNextProcedure


    IF QBBinProcedureIndex = "" THEN
        QBBinCloseFile
        EXIT FUNCTION
    END IF

    
    
    ProcedureLOC& = CVL(LEFT$(QBBinProcedureIndex, 4))
    QBBinProcedureIndex = MID$(QBBinProcedureIndex, 5)
    SEEK #QBBinFile, ProcedureLOC&

    DIM Junk AS STRING



    Junk = CHR$(0)
    GET #QBBinFile, , Junk

    IF EOF(QBBinFile) THEN
        QBBinCloseFile
        EXIT FUNCTION
    END IF
    
    GET #QBBinFile, , ProcNameLen%

    QBBinProcedureName = STRING$(ProcNameLen% AND &HFFFF&, 0)
    GET #QBBinFile, , QBBinProcedureName
    Junk = STRING$(3, 0)
    GET #QBBinFile, , Junk

    GET #QBBinFile, , ProcCodeLen%

    ReadToArrayINT QBBinFile, CODE(), ProcCodeLen% AND &HFFFF&

    DIM Footer AS STRING * 16
    GET #QBBinFile, , Footer

    LoadNextProcedure = -1
    IP = LBOUND(CODE)

END FUNCTION

SUB LoadParseRules

    DIM ParseRule AS STRING

    TokenLBound = &H7FFF
    TokenUBound = 0
    TokenLength = 0

    '----------------------------------------------------------------------------
    ' Clear the symbol hash table
    '----------------------------------------------------------------------------
    FOR i = 0 TO SymbolHashBuckets - 1: SymbolHashTable(i) = "": NEXT i
    SymbolHashEntries = 0

    '----------------------------------------------------------------------------
    ' PASS 1: Enumerate all tokens
    '----------------------------------------------------------------------------
    RestoreParseRules

    DO WHILE ReadParseRule(TokenPCODE, TokenLength, ParseRule)

        TokenLBound = MIN(TokenPCODE, TokenLBound)
        TokenUBound = MAX(TokenPCODE, TokenLBound)

    LOOP

    REDIM ParseRules(TokenLBound TO TokenUBound) AS STRING


    '----------------------------------------------------------------------------
    ' PASS 2: Generate token strings
    '----------------------------------------------------------------------------
    RestoreParseRules

    DO WHILE ReadParseRule(TokenPCODE, TokenLength, ParseRule)

        '------------------------------------------------------------------------
        ' If this is the first rule for this PCODE, then we'll write the
        ' length of the token data as the first word.
        '------------------------------------------------------------------------
        IF ParseRules(TokenPCODE) = "" THEN
            ParseRules(TokenPCODE) = MKI$(TokenLength)
        END IF

        RuleID = GetParseRuleID(ParseRule, TokenPCODE)
        IF RuleID = -1 THEN RuleID = TokenPCODE

        ParseRule = MKI$(LEN(ParseRule)) + MKI$(RuleID) + ParseRule
        ParseRules(TokenPCODE) = ParseRules(TokenPCODE) + ParseRule

    LOOP

    QBBinTok.SUBDEF = GetHashedSymbol("subdef")
    QBBinTok.FUNCDEF = GetHashedSymbol("funcdef")
    QBBinTok.DEFTYPE = GetHashedSymbol("deftype")

END SUB

'
' Returns the token id of the next unprocessed token without modifying IP.
' Neccessary for REDIM, which causes an array expression to behave like
' an array declaration, for reasons best known to the QB45 dev team.
'
FUNCTION LookAhead


    IF IP < LBOUND(CODE) OR IP > UBOUND(CODE) THEN
        LookAhead = -1
    ELSE
        LookAhead = CODE(IP) AND &H3FF
    END IF

END FUNCTION

FUNCTION LTOA$ (Value AS LONG)

    LTOA$ = LTRIM$(RTRIM$(STR$(Value)))

END FUNCTION

FUNCTION MAX% (x AS INTEGER, Y AS INTEGER)

    IF x > Y THEN MAX = x ELSE MAX = Y

END FUNCTION

FUNCTION MIN% (x AS INTEGER, Y AS INTEGER)

    IF x < Y THEN MIN = x ELSE MIN = Y

END FUNCTION

FUNCTION ParseArrayDecl$

    STATIC RuleIDLoaded AS INTEGER
    STATIC RuleAsTypeID AS INTEGER
    STATIC RuleDeclID AS INTEGER
    STATIC RuleDeclsID AS INTEGER

    IF NOT RuleIDLoaded THEN
        RuleAsTypeID = GetHashedSymbol("astype")
        RuleDeclID = GetHashedSymbol("decl")
        RuleDeclsID = GetHashedSymbol("decls")
    END IF


    nElmts = FetchINT(0)
    ID$ = FetchID(2) + GetTypeSuffix(HPARAM)

    IF StackPeek(0) = RuleAsTypeID THEN
        ArgC = 1
        AsType$ = "{0}"
    END IF

    WHILE nElmts > 0

        nElmts = nElmts - 1

        Indices$ = STAG(ArgC) + Indices$
        ArgC = ArgC + 1

        IF nElmts AND 1 THEN
            IF StackPeek(ArgC) <> &H18 THEN Indices$ = " TO " + Indices$
        ELSE
            IF nElmts THEN Indices$ = ", " + Indices$
        END IF

    WEND

    IF Indices$ <> "" THEN Indices$ = "(" + Indices$ + ")"

    IF StackPeek(ArgC) = RuleDeclsID THEN
        ParseArrayDecl$ = STAG(ArgC) + ", " + ID$ + Indices$ + AsType$
    ELSEIF StackPeek(ArgC) = RuleDeclID THEN
        ParseArrayDecl$ = STAG(ArgC) + " " + ID$ + Indices$ + AsType$
    ELSE
        ParseArrayDecl$ = ID$ + Indices$ + AsType$
    END IF

END FUNCTION

'
' Generates a parse rule for an array expression.
'
FUNCTION ParseArrayExpr$

    IF LookAhead = 28 THEN
        ParseArrayExpr = ParseArrayDecl
        EXIT FUNCTION
    END IF

    'IF PCODE = 15 THEN ArgC = 1

    nElmts = FetchINT(0)
    ID$ = FetchID(2) + GetTypeSuffix(HPARAM)

    IF NOT nElmts AND &H8000 THEN

        FOR i = nElmts - 1 TO 0 STEP -1

            IF i THEN
                Indices$ = ", " + STAG(ArgC) + Indices$
            ELSE
                Indices$ = STAG(ArgC) + Indices$
            END IF

            ArgC = ArgC + 1

        NEXT i

        Indices$ = "(" + Indices$ + ")"

    END IF

    ParseArrayExpr = ID$ + Indices$

END FUNCTION

'
' Generates parse rule fragment for a procedure call
'
FUNCTION ParseCALL$ (Parenthesis AS INTEGER)

    ArgC = FetchINT(0)

    FOR ArgI = 0 TO ArgC - 1

        IF ArgI THEN
            ArgV$ = STAG(ArgI) + ", " + ArgV$
        ELSE
            ArgV$ = STAG(ArgI) + ArgV$
        END IF

    NEXT ArgI

    IF ArgC > 0 THEN
        IF Parenthesis THEN ArgV$ = "(" + ArgV$ + ")" ELSE ArgV$ = " " + ArgV$
    END IF

    ParseCALL$ = ArgV$

END FUNCTION

'
' This helper function parses a SUB or FUNCTION declaration, or a
' SUB/FUNCTION/DEF FN definition.
'
FUNCTION ParseProcDecl$ (DP AS INTEGER, Parenthesis AS INTEGER)

    DIM Flags AS LONG
    DIM ArgC AS LONG

    CONST fCDECL = &H8000
    CONST fALIAS = &H400

    ID$ = GetID(FetchINT(DP + 0))
    Flags = FetchINTASLONG(DP + 2)
    ArgC = FetchINTASLONG(DP + 4)

    LenALIAS = Flags \ &H400 AND &H1F

    IF Flags AND &H80 THEN TS$ = GetTypeSuffix(Flags AND 7)
    Arguments$ = ""

    ProcType = (Flags AND &H300) \ 256

    SELECT CASE ProcType
        CASE 1: ID$ = "SUB " + ID$ + TS$: QBBinProcedureType = "SUB"
        CASE 2: ID$ = "FUNCTION " + ID$ + TS$: QBBinProcedureType = "FUNCTION"
        CASE 3: ID$ = "DEF " + ID$ + TS$: QBBinProcedureType = "DEF"
    END SELECT


    '
    ' Process arguments list
    '
    FOR ArgI = 1 TO ArgC

        ArgName$ = GetID(FetchINT(DP + ArgI * 6 + 0))
        ArgFlags = FetchINT(DP + ArgI * 6 + 2)
        ArgType = FetchINT(DP + ArgI * 6 + 4)

        '------------------------------------------------------------------------
        ' Process special argument flags. Not all of these can be combined,
        ' but we'll just assume the file contains a valid combination.
        '------------------------------------------------------------------------
        IF ArgFlags AND &H200 THEN ArgName$ = ArgName$ + GetTypeSuffix(ArgType)
        IF ArgFlags AND &H400 THEN ArgName$ = ArgName$ + "()"
        IF ArgFlags AND &H800 THEN ArgName$ = "SEG " + ArgName$
        IF ArgFlags AND &H1000 THEN ArgName$ = "BYVAL " + ArgName$
        IF ArgFlags AND &H2000 THEN ArgName$ = ArgName$ + " AS " + GetTypeName(ArgType)

        IF ArgI = 1 THEN
            Arguments$ = ArgName$
        ELSE
            Arguments$ = Arguments$ + ", " + ArgName$
        END IF

    NEXT ArgI

    IF Parenthesis OR Arguments$ <> "" THEN Arguments$ = " (" + Arguments$ + ")"


    '
    ' Process CDECL and ALIAS modifiers
    '
    IF Flags AND fCDECL THEN ID$ = ID$ + " CDECL"

    AliasName$ = LEFT$(FetchRAW(DP + ArgI * 6), LenALIAS)
    IF LenALIAS THEN ID$ = ID$ + " ALIAS " + AliasName$

    ParseProcDecl$ = ID$ + Arguments$

END FUNCTION

'
'
'
FUNCTION ParseVarArgs$

    ArgC = FetchINT(0)

    STATIC NULARG

    IF NULARG = 0 THEN NULARG = GetHashedSymbol("nularg")

    FOR ArgI = 0 TO ArgC - 1

        IF StackPeek(ArgI) <> NULARG THEN ArgV$ = ", " + ArgV$

        ArgV$ = STAG(ArgI) + ArgV$

    NEXT ArgI


    '----------------------------------------------------------------------------
    ' Trim trailing commas
    '----------------------------------------------------------------------------
    FOR i = LEN(ArgV$) TO 1 STEP -1
        Ch$ = MID$(ArgV$, i, 1)
        IF Ch$ <> " " AND Ch$ <> "," THEN EXIT FOR
    NEXT i

    ArgV$ = LEFT$(ArgV$, i)

    IF ArgV$ <> "" THEN ArgV$ = " " + ArgV$

    ParseVarArgs$ = ArgV$

END FUNCTION

FUNCTION POP$

    IF SP = LBOUND(STACK) THEN EXIT FUNCTION

    POP$ = MID$(STACK(SP), 3)
    SP = SP - 1

END FUNCTION

'
' The following special codes may be embedded in a string:
'
' 0xccnn0D      - RLE encoding (used by QB45 comments)
' 0xnnnn000D    - Indentation marker
' 0x101D        - NEWLINE marker 1
' 0x201D        - NEWLINE marker 2
'
SUB PostProcess

    DIM OutText AS STRING
    DIM OutTxt AS STRING
    DIM Marker AS LONG
    DIM LineColumn AS LONG
    DIM OffsetFromNewline AS LONG
    DIM TextBegin AS LONG

    TextBegin = 1

    DO
        '------------------------------------------------------------------------
        ' Look for special symbol marker
        '------------------------------------------------------------------------
        Marker = INSTR(TextBegin, STACK(0), CHR$(&HD))
        IF Marker = 0 THEN Marker = LEN(STACK(0)) + 1

        '------------------------------------------------------------------------
        ' Copy leading text to output string
        '------------------------------------------------------------------------
        OutTxt = OutTxt + MID$(STACK(0), TextBegin, Marker - TextBegin)
        IF Marker > LEN(STACK(0)) THEN
            TextBegin = Marker
            EXIT DO
        END IF

        OffsetFromNewline = OffsetFromNewline + Marker - TextBegin

        SELECT CASE MID$(STACK(0), Marker + 1, 1)
       
            CASE CHR$(0):
                '----------------------------------------------------------------
                ' Indentation
                '----------------------------------------------------------------
                RunLn& = CVI(MID$(STACK(0), Marker + 2)) AND &HFFFF&
                RunLn& = RunLn& - CLNG(OffsetFromNewline)

                IF (RunLn& < 0) THEN RunLn& = 1

                OffsetFromNewline = OffsetFromNewline + RunLn&
                OutTxt = OutTxt + SPACE$(RunLn&)
                TextBegin = Marker + 4
        
            CASE CHR$(1):
                '----------------------------------------------------------------
                ' Newline
                '----------------------------------------------------------------
                IF FlushToOutput THEN EXIT DO
                DiscardLine = 0
                FlushToOutput = -1
                OffsetFromNewline = 0
                TextBegin = Marker + 2

            CASE CHR$(2):
                '----------------------------------------------------------------
                ' Newline - $INCLUDEd file
                '----------------------------------------------------------------
                DiscardLine = QBBinOption.OmitIncludedLines
                          
                FlushToOutput = -1
                OffsetFromNewline = 0
                TextBegin = Marker + 2

            CASE ELSE:
                '----------------------------------------------------------------
                ' RLE encoded comment
                '----------------------------------------------------------------
                RunLn& = ASC(MID$(STACK(0), Marker + 1))
                RunCh$ = MID$(STACK(0), Marker + 2)

                OutTxt = OutTxt + STRING$(RunLn&, RunCh$)

                OffsetFromNewline = OffsetFromNewline + RunLn&
                TextBegin = Marker + 3
   
        END SELECT

    LOOP

    IF FlushToOutput THEN
        IF OutTxt <> SPACE$(LEN(OutTxt)) THEN OutTxt = RTRIM$(OutTxt)
        QBBinProgramLine = OutTxt
        QBBinLineReady = NOT DiscardLine
    
        OutTxt = ""
    END IF

    STACK(0) = OutTxt + MID$(STACK(0), Marker)

END SUB

SUB ProcessProcDefType

    ' Procedure DEFTYPE defaults to SINGLE

    DIM ProcDefType(1 TO 26) AS INTEGER
    DIM OutTxt AS STRING

    FOR i = 1 TO 26: ProcDefType(i) = 3: NEXT i

    DO WHILE LookAhead = 0
        IF NOT ReadToken THEN EXIT SUB

        IF LookAhead <> QBBinTok.DEFTYPE THEN
            IP = IP - 1
            EXIT DO
        END IF

        IF NOT ReadToken THEN EXIT DO

        UnwantedReturnValue$ = SubstTagDEFxxx(ProcDefType())
    
    LOOP

    'FOR i = 1 TO 26: PRINT GetTypeSuffix(ProcDefType(i)); : NEXT i: PRINT

    'PRINT QBBinProcedureName

    FOR i = 1 TO 5
   
        'IF i = 3 THEN i = i + 1

        AnythingOutput = 0
        InitialLetter = 0
        OutTxt = ""

        FOR j = 1 TO 27


            BITSET = 0

            IF j < 27 THEN
                BITSET = ProcDefType(j) = i
                BITSET = BITSET AND QBBinDefType(j) <> i
            END IF

            IF BITSET AND InitialLetter = 0 THEN

                InitialLetter = j + 64

            ELSEIF InitialLetter AND NOT BITSET THEN

                IF AnythingOutput THEN OutTxt = OutTxt + ", "

                OutTxt = OutTxt + CHR$(InitialLetter)

                Range = j + 64 - InitialLetter
                IF Range > 1 THEN OutTxt = OutTxt + "-" + CHR$(j + 63)

                AnythingOutput = -1
                InitialLetter = 0
            END IF
        NEXT j

        IF AnythingOutput THEN
            PUSH 0, MKI$(&H10D)
            PUSH QBBinTok.DEFTYPE, "DEF" + GetTypeAbbr(i) + " " + OutTxt
            FlushStack
        END IF
    
    NEXT i

    FOR i = 1 TO 26: QBBinDefType(i) = ProcDefType(i): NEXT i

END SUB

FUNCTION ProcessToken

    ProcessToken = 0
    IF NOT ReadToken THEN EXIT FUNCTION

    IF PCODE = 8 THEN EXIT FUNCTION

    ProcessToken = -1
    DefaultParseRule

END FUNCTION

SUB PUSH (ID AS INTEGER, Txt AS STRING)

    IF SP = UBOUND(STACK) THEN EXIT SUB

    SP = SP + 1
    STACK(SP) = MKI$(ID) + Txt

END SUB

SUB QBBinCloseFile

    CLOSE #QBBinFile
    QBBinFile = 0
    QBBinEOF = -1

END SUB

DEFSNG A-Z
FUNCTION QBBinGetFileType

END FUNCTION

DEFINT A-Z
'
FUNCTION QBBinGetProcName$

END FUNCTION

SUB QBBinOpenFile (FileName AS STRING)

    QBBinFile = FREEFILE
    QBBinEOF = 0

    OPEN FileName FOR BINARY AS #QBBinFile

    GET #QBBinFile, , Magic%
    GET #QBBinFile, , Version%

    '----------------------------------------------------------------------------
    ' Only QB45 is currently supported
    '----------------------------------------------------------------------------
    IF (Magic% <> &HFC) OR (Version% <> 1) THEN
        RESET
        PRINT "ERROR: The file you provided does not have a valid QB45 header."
        SYSTEM 1
    END IF

    ' Don't delete this - alpha sorter needs it!
    x = GetTotalLines

    '----------------------------------------------------------------------------
    ' Read symbol table size and convert to long to lose sign bit
    '----------------------------------------------------------------------------
    GET #QBBinFile, 27, szSymTbl%
    szSymTbl& = szSymTbl% AND &HFFFF&

    '----------------------------------------------------------------------------
    ' Load symbol table to memory and return file number
    '----------------------------------------------------------------------------
    REDIM SYMTBL(1 TO (szSymTbl& + 1) \ 2) AS INTEGER
    ReadToArrayINT QBBinFile, SYMTBL(), szSymTbl&

    IF NOT LoadMainModule THEN EXIT SUB

    '----------------------------------------------------------------------------
    ' If main module is empty, look for non-empty procedure
    '----------------------------------------------------------------------------
    WHILE CODE(IP) = 8
        IF NOT LoadNextProcedure THEN EXIT SUB
    WEND

END SUB

FUNCTION QBBinReadLine$ (Meta AS LONG)


    STATIC NewProc

    Meta = 0

    PostProcess

    IF QBBinLineReady THEN
        QBBinReadLine = QBBinProgramLine
        QBBinLineReady = 0
        QBBinProgramLine = ""
        EXIT FUNCTION
    END IF

    IF QBBinEOF THEN EXIT FUNCTION

    DO
        IF NoMoreTokens THEN
            QBBinCloseFile
            EXIT FUNCTION
        END IF

        IF NOT ReadToken THEN EXIT FUNCTION
        DefaultParseRule

        '------------------------------------------------------------------------
        ' Trap some special tokens
        '------------------------------------------------------------------------
        SELECT CASE PCODE
                                                                       
            '------------------------------------------------------------------------
            ' Token 0x008 appears at the end of the code (before the watch list)
            '------------------------------------------------------------------------
            CASE 8:
                IF NOT LoadNextProcedure THEN
                    NoMoreTokens = -1
                ELSE
                    PUSH 0, MKI$(&H10D) ' Force blank line before SUB/FUNCTION
                    ProcessProcDefType
                    NewProc = -1

            
                    'ProcessProcDefType

                END IF

                'END SELECT

                'SELECT CASE StackPeek(0)
       
            CASE QBBinTok.SUBDEF: Meta = QBBinMeta.SUB
            CASE QBBinTok.FUNCDEF: Meta = QBBinMeta.FUNCTION

        END SELECT

        PostProcess

    LOOP WHILE NOT QBBinLineReady

    QBBinReadLine = QBBinProgramLine
    QBBinLineReady = 0
    QBBinProgramLine = ""

END FUNCTION

SUB QBBinSetOption (OptionName AS STRING, OptionValue AS INTEGER)
END SUB

FUNCTION Quote$ (Txt AS STRING)

    Quote$ = CHR$(34) + Txt + CHR$(34)

END FUNCTION

FUNCTION ReadKey$
    DO: LOOP WHILE INKEY$ <> ""
    DO: Key$ = INKEY$: LOOP WHILE Key$ = ""

    ReadKey = UCASE$(Key$)

END FUNCTION

FUNCTION ReadParseRule (TokenID AS INTEGER, OpLen AS INTEGER, ParseRule AS STRING)

    '------------------------------------------------------------------------
    ' Ugh... static. I'm being lazy.
    '------------------------------------------------------------------------
    STATIC RuleItem AS STRING
    STATIC DefaultRuleID AS STRING

    '------------------------------------------------------------------------
    ' If RuleItem isn't empty, extract the next rule.
    '------------------------------------------------------------------------
    IF RuleItem <> "" THEN
        ParseRule = DelimitParseRule(RuleItem, DefaultRuleID)
        ReadParseRule = -1
        EXIT FUNCTION
    END IF

    ReadParseRule = 0

    READ RuleItem

    '------------------------------------------------------------------------
    ' Loop until we have something which isn't the .default directive
    '------------------------------------------------------------------------
    WHILE MID$(RuleItem, 1, 8) = ".default"

        DefaultRuleID = LTRIM$(RTRIM$(MID$(RuleItem, 9)))
        READ RuleItem

    WEND

    '------------------------------------------------------------------------
    ' The rule list is terminated by a period.
    '------------------------------------------------------------------------
    IF RuleItem = "." THEN
        RuleItem = ""
        DefaultRuleID = ""
        EXIT FUNCTION
    END IF

    '------------------------------------------------------------------------
    ' If RuleItem is a number, then assume it is the start of a new token.
    ' Otherwise, we assume it is an additional rule of the previous token.
    '------------------------------------------------------------------------
    IF (StringToINT(RuleItem, TokenID)) THEN

        READ RuleItem

        '--------------------------------------------------------------------
        ' If the token length is not omitted, then we need to read again
        ' to fetch the token parse rule. Also, an asterisk may be used to
        ' represent a variable length token, so we need to check for that.
        '--------------------------------------------------------------------
        IF StringToINT(RuleItem, OpLen) THEN
            READ RuleItem

        ELSEIF RuleItem$ = "*" THEN
            OpLen = -1
            READ RuleItem

        ELSE
            OpLen = 0
        END IF

    END IF


    '------------------------------------------------------------------------
    ' Extract rule and return
    '------------------------------------------------------------------------
    ParseRule = DelimitParseRule(RuleItem, DefaultRuleID)
    ReadParseRule = -1

END FUNCTION

SUB ReadToArrayINT (FileNumber AS INTEGER, Array() AS INTEGER, ByteCount AS LONG)

    CONST BlockReadSize = 1024 ' must be a multiple of 2

    IF BlockReadSize AND 1 THEN PRINT "BlockReadSize error.": SYSTEM 1 'ERROR 255

    DIM i AS LONG
    DIM BytesToRead AS LONG

    '----------------------------------------------------------------------------
    ' REDIM the array if necessary, but keep the lower bound in place
    '----------------------------------------------------------------------------
    IF (UBOUND(Array) - LBOUND(Array)) * 2 < ByteCount THEN
        REDIM Array(LBOUND(Array) TO LBOUND(Array) + (ByteCount + 1) \ 2) AS INTEGER
    END IF

    FOR i = 0 TO ByteCount - 1 STEP BlockReadSize

        BytesToRead = ByteCount - i

        IF BytesToRead > BlockReadSize THEN BytesToRead = BlockReadSize

        Buffer$ = STRING$(BytesToRead, 0)
        GET FileNumber, , Buffer$

        '------------------------------------------------------------------------
        ' Copy data from string to integer array (even number of bytes only)
        '------------------------------------------------------------------------
        FOR j = 1 TO BytesToRead - 1 STEP 2
            Index = LBOUND(Array) + i \ 2 + j \ 2
            Array(Index) = CVI(MID$(Buffer$, j, 2))
        NEXT j

        '------------------------------------------------------------------------
        ' The final block may have had an odd number of bytes
        '------------------------------------------------------------------------
        IF BytesToRead AND 1 THEN
            Index = LBOUND(Array) + i \ 2 + j \ 2
            Array(Index) = ASC(RIGHT$(Buffer$, 1))
        END IF

    NEXT i


END SUB

'
' Reads a token into the globals PCODE and HPARAM. IP is updated to point
' To the next token, and DP points to the start of the token data.
'
FUNCTION ReadToken

    DIM TokLen AS LONG

    ReadToken = 0

    IF IP < LBOUND(CODE) OR IP > UBOUND(CODE) THEN EXIT FUNCTION

    '----------------------------------------------------------------------------
    ' Fetch basic token information
    '----------------------------------------------------------------------------
    TOKEN = MKI$(CODE(IP))
    PCODE = CODE(IP) AND &H3FF
    HPARAM = (CODE(IP) AND &HFC00&) \ 1024
    ReadToken = -1


    '----------------------------------------------------------------------------
    ' If the token is outside the known token range, we have a problem.
    '----------------------------------------------------------------------------
    IF PCODE < LBOUND(ParseRules) OR PCODE > UBOUND(ParseRules) THEN
        IP = IP + 1
        'PRINT "Bad token found.": SYSTEM 1 'ERROR QBErrBadToken
        PCODE = 0: HPARAM = 0: TOKEN = MKI$(0)
        EXIT FUNCTION
    END IF

    '----------------------------------------------------------------------------
    ' If the token has no information in the parse rules, then we clearly don't
    ' understand what it does, so increment IP and return. We will try to
    ' soldier on and parse the rest of the file
    '----------------------------------------------------------------------------
    IF ParseRules(PCODE) = "" THEN
        AOutput "REM ®QB45BIN¯ Unkown token - " + HEX$(PCODE)
        IP = IP + 1
        EXIT FUNCTION
    END IF

    '----------------------------------------------------------------------------
    ' Fetch the token data length from the parse rules to determine if the token
    ' is fixed or variable length
    '----------------------------------------------------------------------------
    IF PCODE >= LBOUND(ParseRules) AND PCODE <= UBOUND(ParseRules) THEN
        IF LEN(ParseRules(PCODE)) > 2 THEN
            TokLen = CVI(LEFT$(ParseRules(PCODE), 2)) AND &HFFFF&
        END IF
    END IF

    '----------------------------------------------------------------------------
    ' If the token is variable length it will be followed by the size word, so
    ' read it now.
    '----------------------------------------------------------------------------
    IF TokLen = &HFFFF& THEN
        IP = IP + 1
        TokLen = CODE(IP) AND &HFFFF&
    END IF

    '----------------------------------------------------------------------------
    ' Read the token data into the TOKEN string. Note that due to a bug in QB64,
    ' we can not use IP as the control variable.
    '----------------------------------------------------------------------------
    FOR DP = IP + 1 TO IP + (TokLen + 1) \ 2
        TOKEN = TOKEN + MKI$(CODE(DP))
    NEXT DP
    IP = DP

    TOKEN = LEFT$(TOKEN, TokLen + 2)

END FUNCTION

SUB RestoreParseRules

    '
    ' This is so I can change parse rules later if I add QB40 support.
    '
    RESTORE QB45TOKENS

END SUB

SUB SanityCheck (DP AS INTEGER)

    DIM ThAddr AS LONG

    ThAddr = FetchINTASLONG(DP)

    IF ThAddr = &HFFFF& THEN EXIT SUB

    ThAddr = ThAddr \ 2 - 1

    IF ThAddr >= LBOUND(CODE) AND ThAddr <= UBOUND(CODE) - 1 THEN

        IF (CODE(LBOUND(CODE) + ThAddr) AND &H1FF) = PCODE THEN EXIT SUB

    END IF

    'ERROR QBBinErrInsane
END SUB

FUNCTION SetHashedSymbol% (ParseRuleSymbol AS STRING, SymbolID AS INTEGER)
    DIM LookupSymbol AS STRING

    SymbolName$ = LTRIM$(RTRIM$(ParseRuleSymbol))

    '----------------------------------------------------------------------------
    ' Parse rule symbols my be literal integers
    '----------------------------------------------------------------------------
    IF StringToINT(SymbolName$, SymbolID%) THEN EXIT FUNCTION

    Hash = HashPJW(SymbolName$)

    LookupSymbol = "[" + SymbolName$ + "]"

    SymbolOffset = INSTR(SymbolHashTable(Hash), LookupSymbol)

    IF SymbolOffset = 0 THEN

        SymbolHashTable(Hash) = SymbolHashTable(Hash) + LookupSymbol + MKI$(SymbolID)

        SetHashedSymbol = SymbolID

    ELSE

        SymbolOffset = SymbolOffset + LEN(LookupSymbol)

        ID$ = MID$(SymbolHashTable(Hash), SymbolOffset, 2)
        SetHashedSymbol = CVI(ID$)

    END IF

    'GetHashedSymbol% = SymbolID% + UBOUND(ParseRules) + 1



END FUNCTION

'
' Peeks at the ID of a stack item
'
FUNCTION StackPeek (OffsetSP)

    StackPeek = -1

    IF OffsetSP < 0 OR OffsetSP >= SP THEN EXIT FUNCTION

    StackPeek = CVI(LEFT$(STACK(SP - OffsetSP), 2))

END FUNCTION

'
' STAG is a shortcut function for creating numeric stack tags dynamically
' such as {1}.
'
FUNCTION STAG$ (n)

    STAG$ = "{" + LTRIM$(RTRIM$(STR$(n))) + "}"

END FUNCTION

'
' Parses a STRING into an INTEGER, returning 0 if the string contained
' any invalid characters (not including leading and trailing whitespace).
' Only positive integers are recognised (no negative numbers!).
'
' The actual numeric value is returned in OutVal
'
FUNCTION StringToINT (Txt AS STRING, OutVal AS INTEGER)

    x$ = UCASE$(LTRIM$(RTRIM$(Txt)))

    SignCharacter$ = LEFT$(x$, 1)
    SignMultiplier = 1

    IF (SignCharacter$ = "+" OR SignCharacter$ = "-") THEN
        SignMultiplier = 45 - ASC(SignCharacter$)
        x$ = MID$(x$, 2)
    END IF

    FoundBadDigit = LEN(x$) = 0

    SELECT CASE LEFT$(x$, 2)
        CASE "&H", "0X": nBase = 16: FirstDigitPos = 3
        CASE "&O": nBase = 8: FirstDigitPos = 3
        CASE ELSE: nBase = 10: FirstDigitPos = 1
    END SELECT

    IF nBase THEN

        FOR i = FirstDigitPos TO LEN(x$)
            Digit = ASC(MID$(x$, i, 1)) - 48
            IF Digit > 16 THEN Digit = Digit - 7
            IF Digit < 0 OR Digit >= nBase THEN FoundBadDigit = -1

            IF NOT FoundBadDigit THEN
                Value = Value * nBase
                Value = Value + Digit
            END IF

        NEXT i
    END IF

    StringToINT = NOT FoundBadDigit
    IF NOT FoundBadDigit THEN OutVal = Value * SignMultiplier

END FUNCTION

FUNCTION SubstTagCIRCLE$

    DIM ParseRule AS STRING

    ParseRule = "{?}, {?}, {?}, {?}, {?}, {?}"

    ArgC = 0
    ArgI = 0

    '
    ' The last 3 arguments are optional.
    '
    FOR i = 0 TO 2

        IF StackPeek(ArgC) = &H7E + i THEN

            IF ArgI = 0 THEN ArgI = 28 - i * 5

            MID$(ParseRule, 27 - i * 5, 1) = CHR$(ArgC + 48)
            ArgC = ArgC + 1

        END IF

    NEXT i

    ' PCODE 0x09f means no colour argument
    IF PCODE <> &H9F THEN
        IF ArgI = 0 THEN ArgI = 13
        MID$(ParseRule, 12, 1) = CHR$(ArgC + 48)
        ArgC = ArgC + 1
    END IF

    ' The last 3 arguments are required
    IF ArgI = 0 THEN ArgI = 8
    MID$(ParseRule, 7, 1) = CHR$(ArgC + 48): ArgC = ArgC + 1
    MID$(ParseRule, 2, 1) = CHR$(ArgC + 48): ArgC = ArgC + 1

    ' Remove unused arguments

    ParseRule = LEFT$(ParseRule, ArgI)

    DO
        ArgI = INSTR(ParseRule, "?")
        IF ArgI <= 1 THEN EXIT DO
        ParseRule = LEFT$(ParseRule, ArgI - 2) + MID$(ParseRule, ArgI + 2)
    LOOP

    SubstTagCIRCLE = ParseRule

END FUNCTION

'
' 0x01B : DEF(INT|LNG|SNG|DBL|STR) letterrange
'
' The DEFxxx token is followed by 6 bytes of data. The first two bytes give
' the absolute offset in the p-code to the correspdoning bytes of the next
' DEFxxx statement (!), or 0xFFFF if there are no more DEFxxx statements.
'
' Naturally, we can ignore these two bytes.
'
' The next 4 bytes form a 32-bit integer. The low 3 bits give the data-type
' for the DEFxxx. The upper 26 bits represent each letter or the alphabet,
' with A occupying the highest bit, and Z the lowest.
'
FUNCTION SubstTagDEFxxx$ (DefTypeArray() AS INTEGER)

    DIM AlphaMask AS LONG
    DIM OutTxt AS STRING

    AlphaMask = FetchLNG(2)
    DefType = LIMIT(AlphaMask AND 7, 0, 5)
    OutTxt = "DEF" + GetTypeAbbr(DefType) + " "

    ' Shift the mask right once to avoid overflow problems.
    AlphaMask = AlphaMask \ 2
    InitialLetter = 0
    AnythingOutput = 0

    ' We will loop one extra time to avoid code redendancy after the loop to
    ' clean up the Z. To ensure everything works out, we just need to make
    ' sure the bit after the Z is clear. We also need to clear the high 2 bits
    ' every time to avoid overflow ploblems.

    FOR i = 0 TO 26

        ' Get the next bit and shift the mask
        BITSET = (AlphaMask AND &H40000000) <> 0
        AlphaMask = AlphaMask AND &H3FFFFFE0
        AlphaMask = AlphaMask * 2

        '------------------------------------------------------------------------
        ' Update current DEFtype state
        '------------------------------------------------------------------------
        IF i < 26 AND BITSET THEN DefTypeArray(i + 1) = DefType

        IF BITSET AND InitialLetter = 0 THEN

            InitialLetter = i + 65

        ELSEIF InitialLetter AND NOT BITSET THEN

            IF AnythingOutput THEN OutTxt = OutTxt + ", "

            OutTxt = OutTxt + CHR$(InitialLetter)

            Range = i + 65 - InitialLetter
            IF Range > 1 THEN OutTxt = OutTxt + "-" + CHR$(i + 64)

            AnythingOutput = -1
            InitialLetter = 0
        END IF

    NEXT i

    SubstTagDEFxxx$ = OutTxt

END FUNCTION

FUNCTION SubstTagINPUT$

    CONST fPrompt = &H4
    CONST fSemiColon = &H2
    CONST fComma = &H1

    Flags = ASC(MID$(TOKEN, 3, 1))

    IF Flags AND fSemiColon THEN OutTxt$ = "; "

    IF Flags AND fPrompt THEN
        Tail = 59 - (((Flags AND fComma) = 1) AND 15)
        OutTxt$ = OutTxt$ + "{$+0}" + CHR$(Tail)
    END IF

    SubstTagINPUT = OutTxt$

END FUNCTION

FUNCTION SubstTagKEY$

    SELECT CASE CVI(MID$(TOKEN, 3, 2))
        CASE 1: SubstTagKEY$ = "ON"
        CASE 2: SubstTagKEY$ = "LIST"
        CASE ELSE: SubstTagKEY$ = "OFF"
    END SELECT

END FUNCTION

FUNCTION SubstTagLINE$

    LineForm = PCODE - &HBB

    SELECT CASE FetchINT(0) AND 3

        CASE 1: BF$ = "B"
        CASE 2: BF$ = "BF"
        CASE ELSE: BF$ = ""

    END SELECT

    ' 0x0bb : LINE x-x, ,[b[f]]
    ' 0x0bc : LINE x-x,n,[b[f]]
    ' 0x0bd : LINE x-x,n,[b[f]],n
    ' 0x0be : LINE x-x, ,[b[f]],n


    IF BF$ <> "" THEN

        SELECT CASE LineForm

            CASE 0: Rule$ = "{0}, , " + BF$
            CASE 1: Rule$ = "{1}, {0}, " + BF$
            CASE 2: Rule$ = "{2}, {1}, " + BF$ + ", {0}"
            CASE 3: Rule$ = "{1}, , " + BF$ + ", {0}"

        END SELECT

    ELSE

        SELECT CASE LineForm

            CASE 0: Rule$ = "{0}"
            CASE 1: Rule$ = "{1}, {0}"
            CASE 2: Rule$ = "{2}, {1}, , {0}"
            CASE 3: Rule$ = "{1}, , , {0}"

        END SELECT

    END IF

    SubstTagLINE = Rule$

END FUNCTION

FUNCTION SubstTagLOCK$

    DIM Flags AS LONG

    Flags = FetchINTASLONG(0) AND &HFFFF&

    IF (Flags AND 2) = 0 THEN
        SubstTagLOCK$ = "{0}"
    ELSE
    
        ' check high 2 bits
        SELECT CASE Flags \ &H4000
            CASE 0: SubstTagLOCK$ = "{2}, {1} TO {0}"
            CASE 1: SubstTagLOCK$ = "{2}, TO {0}"
            CASE 2: SubstTagLOCK$ = "{1}, {0}"
        END SELECT

    END IF

END FUNCTION

FUNCTION SubstTagOPEN$

    DIM ModeFlags AS LONG
    DIM ForMode AS STRING
    DIM AccessMode AS STRING
    DIM LockMode AS STRING
    DIM OutTxt AS STRING

    ModeFlags = FetchINT(0) AND &HFFFF&

    SELECT CASE ModeFlags AND &H3F
        CASE &H1: ForMode = "FOR INPUT"
        CASE &H2: ForMode = "FOR OUTPUT"
        CASE &H4: ForMode = "FOR RANDOM"
        CASE &H8: ForMode = "FOR APPEND"
        CASE &H20: ForMode = "FOR BINARY"
    END SELECT

    SELECT CASE ModeFlags \ 256 AND 3
        CASE 1: AccessMode = "ACCESS READ"
        CASE 2: AccessMode = "ACCESS WRITE"
        CASE 3: AccessMode = "ACCESS READ WRITE"
    END SELECT

    SELECT CASE ModeFlags \ &H1000 AND &H7
        CASE 1: LockMode = "LOCK READ WRITE"
        CASE 2: LockMode = "LOCK WRITE"
        CASE 3: LockMode = "LOCK READ"
        CASE 4: LockMode = "SHARED"
    END SELECT

    OutTxt = ForMode
    IF (OutTxt <> "" AND AccessMode <> "") THEN OutTxt = OutTxt + " "
    OutTxt = OutTxt + AccessMode
    IF (OutTxt <> "" AND LockMode <> "") THEN OutTxt = OutTxt + " "
    OutTxt = OutTxt + LockMode

    SubstTagOPEN = OutTxt

END FUNCTION

FUNCTION SubstTagVERB$

    Verbs$ = "0OR|1AND|2PRESET|3PSET|4XOR|"

    VerbBegin = INSTR(Verbs$, CHR$(48 + LIMIT(FetchINT(0), 0, 4))) + 1
    VerbEnd = INSTR(VerbBegin, Verbs$, "|")

    SubstTagVERB$ = MID$(Verbs$, VerbBegin, VerbEnd - VerbBegin)

END FUNCTION

'
' Splits a {ruletag} into it's constituent components.
'
FUNCTION TokenizeTag (TagTxt AS STRING, TagParam AS INTEGER)

    DIM ParamTxt AS STRING

    Delimiter = INSTR(TagTxt, ":")

    ParamTxt = LTRIM$(MID$(TagTxt, Delimiter + 1))

    IF LEFT$(ParamTxt, 1) = "$" THEN

        TokenizeTag = TagType.StackREL

        IF NOT StringToINT(MID$(ParamTxt, 2), TagParam) THEN
            Delimiter = LEN(TagTxt) + 1
            TagParam = 0
        END IF

    ELSE

        TokenizeTag = TagType.StackABS

        IF NOT StringToINT(MID$(ParamTxt, 1), TagParam) THEN
            Delimiter = LEN(TagTxt) + 1
            TagParam = 0
        END IF

    END IF

    IF Delimiter THEN Delimiter = Delimiter - 1

    TagTxt = LTRIM$(RTRIM$(LEFT$(TagTxt, Delimiter)))

    IF LEFT$(TagTxt, 2) = "##" THEN

        TokenizeTag = TagType.Recursive
        TagTxt = MID$(TagTxt, 3)

    ELSEIF LEFT$(TagTxt, 1) = "#" THEN

        TokenizeTag = TagType.TokenData
        TagTxt = MID$(TagTxt, 2)

    END IF


END FUNCTION

FUNCTION ValidateStackTag (RuleID AS INTEGER, TagTxt AS STRING, OffsetSP AS INTEGER)


    DIM RuleSymbol AS STRING

    '------------------------------------------------------------------------
    ' If the specified stack offset is invalid, only the null tag will do.
    '------------------------------------------------------------------------
    IF (OffsetSP < 0 OR OffsetSP >= SP) THEN
        ValidateStackTag = (TagTxt = "")
        EXIT FUNCTION
    END IF

    TagLen = LEN(TagTxt)
    TagOffset = 1

    DO WHILE TagOffset <= TagLen
     
        Delimiter = INSTR(TagOffset, TagTxt, "|")
        IF Delimiter = 0 THEN Delimiter = TagLen + 1

        RuleSymbol = MID$(TagTxt, TagOffset, Delimiter - TagOffset)
        RuleSymbol = LTRIM$(RTRIM$(RuleSymbol))

        IF NOT StringToINT(RuleSymbol, RuleSymbolID) THEN
            RuleSymbolID = GetHashedSymbol(RuleSymbol)
        END IF

        IF RuleSymbol = "*" THEN EXIT DO
        IF RuleSymbol = "self" THEN RuleSymbolID = RuleID

        IF StackPeek(OffsetSP) = RuleSymbolID THEN EXIT DO

        TagOffset = Delimiter + 1

    LOOP

    ValidateStackTag = NOT (TagLen AND TagOffset > TagLen)

    IF TagLen AND TagOffset > TagLen THEN
        ValidateStackTag = 0
    ELSE
        ValidateStackTag = -1
    END IF


END FUNCTION
