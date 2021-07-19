$CHECKING:OFF
DIM SHARED AS LONG vwatch_linenumber, vwatch_sublevel
DIM SHARED AS STRING vwatch_subname
REDIM SHARED vwatch_breakpoints(0) AS _BYTE
'next lines are just to avoid "unused variable" warnings:
vwatch_linenumber = 0
vwatch_sublevel = 0
vwatch_breakpoints(0) = 0
vwatch_subname = ""
$CHECKING:ON
