$CHECKING:OFF
DIM SHARED AS LONG vwatch_linenumber, vwatch_sublevel, vwatch_goto
DIM SHARED AS STRING vwatch_subname, vwatch_internalsubname, vwatch_callstack
REDIM SHARED vwatch_breakpoints(0) AS _BYTE
REDIM SHARED vwatch_skiplines(0) AS _BYTE
REDIM SHARED vwatch_stack(1000) AS STRING
'next lines are just to avoid "unused variable" warnings:
vwatch_linenumber = 0
vwatch_sublevel = 0
vwatch_goto = 0
vwatch_breakpoints(0) = 0
vwatch_skiplines(0) = 0
vwatch_stack(0) = ""
vwatch_subname = ""
vwatch_internalsubname = ""
vwatch_callstack = ""
$CHECKING:ON
