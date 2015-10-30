'#################### QB-FRAMEWORK: Environment ####################
DEFLNG A-Z
'DEFLNG A-Z isn't required, but certain functions require LONG type variables
'as their parameters and return data in them, for example QB_NODE_each(...)
'##################################################

'#################### QB-FRAMEWORK: Global ####################
DIM SHARED QB_DEBUG AS LONG '1 or 0
DIM SHARED QB_DEBUG_VERBOSE AS LONG '1 or 0
QB_DEBUG = 0
QB_DEBUG_VERBOSE = 0 'set in conjunction with QB_DEBUG for more detailed debug infromation
IF QB_DEBUG_VERBOSE THEN QB_DEBUG = 1
'Quick copy-paste references:
'    QB_DEBUG_VERBOSE = 1: QB_DEBUG = 1
'    QB_DEBUG_VERBOSE = 0: QB_DEBUG = 0
'##################################################

'#################### EACH: Global ####################
'Handle Handlers (used to manage a set of handles)
CONST QB_EACH_NO_BLANK& = 0 'the default, blank entries will not be returned
CONST QB_EACH_ALLOW_BLANK& = 1 'captures implied blanks in adjacent, leading & trailing separators
CONST QB_EACH_ALLOW_ALL_BLANK& = 2 'also captures blank if entire parent is blank (not captured by default)

'#################### HANDLE: Global ####################
'Handle Handlers (used to manage a set of handles)
TYPE __QB_HANDLE_HANDLER
    lastFreedListIndex AS LONG '0=none
    lastHandle AS LONG
    count AS LONG
END TYPE
REDIM SHARED __QB_HANDLE_handler(1 + 0) AS __QB_HANDLE_HANDLER
'manually setup the first handle handler to maintain handles to our handle handlers
__QB_HANDLE_handler(1).lastHandle = 1
__QB_HANDLE_handler(1).lastFreedListIndex = 0
'Freed List
TYPE __QB_HANDLE_FREEDLIST
    handle AS LONG
    prevFreedListIndex AS LONG 'of same owner
END TYPE
REDIM SHARED __QB_HANDLE_freedList(1 + 0) AS __QB_HANDLE_FREEDLIST
DIM SHARED __QB_HANDLE_freedList_Last AS LONG: __QB_HANDLE_freedList_Last = 1
DIM SHARED __QB_HANDLE_freedList_Next AS LONG: __QB_HANDLE_freedList_Next = 1
'Freed-Freed List
REDIM SHARED __QB_HANDLE_freedFreedList(1 + 0) AS LONG
DIM SHARED __QB_HANDLE_freedFreedList_Last AS LONG: __QB_HANDLE_freedFreedList_Last = 1
DIM SHARED __QB_HANDLE_freedFreedList_Next AS LONG: __QB_HANDLE_freedFreedList_Next = 1
'##################################################

'#################### DATETIME: Global ####################
CONST QB_DATETIME_TYPE_LOCAL = 1 'local time
CONST QB_DATETIME_TYPE_OFFSET = 3
CONST QB_DATETIME_TYPE_DURATION = 4
'For duration:
'   1 day=24 hours regardless of timezone
'   1 year=366 days regardless of year
'   1 month=31 days regardless of month
TYPE QB_DATETIME
    reserved AS LONG
    days AS LONG '1-31
    months AS LONG '1-12
    years AS LONG 'eg. 2015
    hours AS LONG '0-23
    minutes AS LONG '0-59
    seconds AS LONG '0-59
    milliseconds AS LONG '0-999
    microseconds AS LONG '0-999 (a microsecond is 1/1000th of a millisecond)
    type AS LONG
END TYPE
DIM SHARED __QB_DATETIME_TYPE_EMPTY AS QB_DATETIME
REDIM SHARED __QB_DATETIME(0 + 1) AS QB_DATETIME
DIM SHARED __QB_DATETIME_ubound AS LONG: __QB_DATETIME_ubound = 1
DIM SHARED __QB_DATETIME_handleSet AS LONG: __QB_DATETIME_handleSet = QB_HANDLE_newSet
'##################################################

'#################### STRING: Global ####################
REDIM SHARED __QB_STR_string(1 + 0) AS STRING
REDIM SHARED __QB_STR_stringValid(1 + 0) AS LONG
DIM SHARED __QB_STR_stringUbound AS LONG: __QB_STR_stringUbound = 1
DIM SHARED __QB_STR_handleSet AS LONG: __QB_STR_handleSet = QB_HANDLE_newSet
DIM SHARED QB_STR_QUOTE AS STRING: QB_STR_QUOTE = CHR$(34)
'##################################################

'#################### NODE: Global ####################
CONST QB_NODE_TYPE_HASHSET& = 1
CONST QB_NODE_TYPE_LIST& = 2
CONST QB_NODE_TYPE_DICTIONARY& = 4
CONST QB_NODE_TYPE_VALUE& = 8 'a simple value, optionally with a label

CONST QB_NODE_ALLOW_DUPLICATE_KEYS& = 256
CONST QB_NODE_CASE_SENSITIVE& = 512
CONST QB_NODE_AVOID_DUPLICATE_VALUES_PER_KEY& = 1024 'new entries will not be added to a key if it already contains the value unless nTh is specified
CONST QB_NODE_DUPLICATE_VALUES_CASE_SENSITIVE& = 2048 'duplicate values check is case sensitive
CONST QB_NODE_DESTROY_ORPHANED_CHILDNODES& = 4096

CONST QB_NODE_FORMAT_LONG& = 1
CONST QB_NODE_FORMAT_STR& = 2
CONST QB_NODE_FORMAT_BOOL& = 4
CONST QB_NODE_FORMAT_NULL& = 8

CONST QB_TRUE& = -1
CONST QB_FALSE& = 0
CONST QB_NULL& = -2

TYPE QB_NODE_TYPE
    valid AS LONG
    type AS LONG
    flags AS LONG
    'linkage
    parent AS LONG
    firstChild AS LONG
    lastChild AS LONG
    count AS LONG
    next AS LONG
    prev AS LONG
    owner AS LONG 'optional
    'label & value
    label AS LONG
    labelFormat AS LONG 'eg. QB_NODE_FORMAT_STR
    value AS LONG
    valueFormat AS LONG
    'hashsets & dictionaries
    hashOffset AS LONG 'added to all keys to increase the chance of uniqueness against other KVP sets with different owners
    hashReference AS LONG 'handle/value of the hashtable reference which points to this node
END TYPE

DIM SHARED QB_NODE_TYPE_EMPTY AS QB_NODE_TYPE
QB_NODE_TYPE_EMPTY.labelFormat = QB_NODE_FORMAT_NULL
QB_NODE_TYPE_EMPTY.valueFormat = QB_NODE_FORMAT_NULL
REDIM SHARED __QB_NODE(0 + 1) AS QB_NODE_TYPE
REDIM SHARED __QB_NODE_hashLists(0 + 16777215) AS LONG
DIM SHARED __QB_NODE_ubound: __QB_NODE_ubound = 1
DIM SHARED __QB_NODE_handleSet AS LONG: __QB_NODE_handleSet = QB_HANDLE_newSet

'##################################################

'#################### __JSON: Global ####################
CONST QB_JSON_STRING& = 1
CONST QB_JSON_NUMBER& = 2
CONST QB_JSON_BOOL& = 3
CONST QB_JSON_NULL& = 4
'http://www.ecma-international.org/publications/files/ECMA-ST/ECMA-404.pdf
'\b  Backspace CHR$(8)
'\f  Form feed CHR$(12)
'\n  New line CHR$(10)
'\r  Carriage return CHR$(13)
'\t  Tab CHR$(9)
'\"  Double quote CHR$(34)
'\\  Backslash caracter CHR$(92)
DIM SHARED __QB_JSON_escape_lookup(255) AS LONG
__QB_JSON_escape_lookup(8) = ASC("b")
__QB_JSON_escape_lookup(12) = ASC("f")
__QB_JSON_escape_lookup(10) = ASC("n")
__QB_JSON_escape_lookup(13) = ASC("r")
__QB_JSON_escape_lookup(9) = ASC("t")
__QB_JSON_escape_lookup(34) = 34
__QB_JSON_escape_lookup(92) = ASC("\")
DIM SHARED __QB_JSON_escape_lookup_reversed(255) AS LONG
__QB_JSON_escape_lookup_reversed(ASC("b")) = 8
__QB_JSON_escape_lookup_reversed(ASC("f")) = 12
__QB_JSON_escape_lookup_reversed(ASC("n")) = 10
__QB_JSON_escape_lookup_reversed(ASC("r")) = 13
__QB_JSON_escape_lookup_reversed(ASC("t")) = 9
__QB_JSON_escape_lookup_reversed(34) = 34
__QB_JSON_escape_lookup_reversed(ASC("\")) = 92
__QB_JSON_escape_lookup_reversed(ASC("B")) = 8
__QB_JSON_escape_lookup_reversed(ASC("F")) = 12
__QB_JSON_escape_lookup_reversed(ASC("N")) = 10
__QB_JSON_escape_lookup_reversed(ASC("R")) = 13
__QB_JSON_escape_lookup_reversed(ASC("T")) = 9
__QB_JSON_escape_lookup_reversed(ASC("'")) = 39 'allow for escaping single quotes \'
_MAPUNICODE &H00A0~& TO 255
'##################################################
