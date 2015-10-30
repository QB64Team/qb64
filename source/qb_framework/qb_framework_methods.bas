DEFLNG A-Z

'#################### NODESET: Methods ####################

FUNCTION QB_FRAMEWORK_leakInfo$
DIM QB__handlesets AS LONG
QB__handlesets = QB_HANDLE_count(1)
DIM QB__nodes AS LONG
QB__nodes = QB_HANDLE_count(__QB_NODE_handleSet)
DIM QB__datetimes AS LONG
QB__datetimes = QB_HANDLE_count(__QB_DATETIME_handleSet)
DIM QB__strings AS LONG
QB__strings = QB_HANDLE_count(__QB_STR_handleSet)
DIM QB__leakInfo AS LONG
QB__leakInfo = QB_NODE_newDictionary
QB_NODE_assign QB__leakInfo, QB_NODE_newValueWithLabel_long("HANDLE_set_count", QB__handlesets)
QB_NODE_assign QB__leakInfo, QB_NODE_newValueWithLabel_long("STR_count", QB__strings)
QB_NODE_assign QB__leakInfo, QB_NODE_newValueWithLabel_long("NODE_count", QB__nodes)
QB_NODE_assign QB__leakInfo, QB_NODE_newValueWithLabel_long("DATETIME_count", QB__datetimes)
QB_NODE_assign QB__leakInfo, QB_NODE_newValueWithLabel_long("global_hash_table_size", (UBOUND(__QB_NODE_hashLists) + 1) * 4)
QB_FRAMEWORK_leakInfo$ = QB_NODESET_serialize(QB__leakInfo, "json")
QB_NODE_destroy QB__leakInfo
END FUNCTION

SUB QB_NODESET_free (QB__selIn AS LONG)
IF QB__selIn < 0 THEN
    QB_NODE_destroy -QB__selIn 'destroy this list/hashset of nodes
END IF
END SUB

FUNCTION QB_NODESET_count& (QB__selIn AS LONG)
QB_NODESET_count& = QB_NODESET_count_PRESERVE&(QB__selIn)
QB_NODESET_free QB__selIn
END FUNCTION
FUNCTION QB_NODESET_count_PRESERVE& (QB__selIn AS LONG)
IF QB__selIn < 0 THEN
    QB_NODESET_count_PRESERVE& = __QB_NODE(-QB__selIn).count
ELSE
    IF QB__selIn <> 0 THEN
        QB_NODESET_count_PRESERVE& = 1
    ELSE
        QB_NODESET_count_PRESERVE& = 0
    END IF
END IF
END FUNCTION

FUNCTION QB_NODESET_equal& (QB__selIn AS LONG, value AS STRING)
DIM QB__selOut AS LONG: QB__selOut = QB_NODE_new(QB_NODE_TYPE_HASHSET, 0)
DIM QB__SelInI AS LONG: DIM QB__SelInIterator AS LONG
DIM QB__sel AS LONG
DIM QB__newSel AS LONG
IF QB__selIn < 0 THEN
    DO WHILE QB_NODE_each(QB__SelInI, -QB__selIn, QB__SelInIterator)
        QB__sel = __QB_NODE(QB__SelInI).label
        IF __QB_NODE(QB__sel).valueFormat = QB_NODE_FORMAT_STR THEN
            IF QB_STR_get(__QB_NODE(QB__sel).value) = value THEN
                QB__newSel = QB_NODE_newLabel_long(QB__sel)
                QB_NODE_assign QB__selOut, QB__newSel
            END IF
        END IF
    LOOP
ELSE
    QB__sel = QB__selIn
    IF __QB_NODE(QB__sel).valueFormat = QB_NODE_FORMAT_STR THEN
        IF QB_STR_get(__QB_NODE(QB__sel).value) = value THEN
            QB__newSel = QB_NODE_newLabel_long(QB__sel)
            QB_NODE_assign QB__selOut, QB__newSel
        END IF
    END IF
END IF
QB_NODESET_equal& = -QB__selOut
QB_NODESET_free QB__selIn
END FUNCTION

FUNCTION QB_NODESET_label_equal& (QB__selIn AS LONG, value AS STRING)
DIM QB__selOut AS LONG: QB__selOut = QB_NODE_new(QB_NODE_TYPE_HASHSET, 0)
DIM QB__SelInI AS LONG: DIM QB__SelInIterator AS LONG
DIM QB__sel AS LONG
DIM QB__newSel AS LONG
IF QB__selIn < 0 THEN
    DO WHILE QB_NODE_each(QB__SelInI, -QB__selIn, QB__SelInIterator)
        QB__sel = __QB_NODE(QB__SelInI).label
        IF __QB_NODE(QB__sel).labelFormat = QB_NODE_FORMAT_STR THEN
            IF QB_STR_get(__QB_NODE(QB__sel).label) = value THEN
                QB__newSel = QB_NODE_newLabel_long(QB__sel)
                QB_NODE_assign QB__selOut, QB__newSel
            END IF
        END IF
    LOOP
ELSE
    QB__sel = QB__selIn
    IF __QB_NODE(QB__sel).labelFormat = QB_NODE_FORMAT_STR THEN
        IF QB_STR_get(__QB_NODE(QB__sel).label) = value THEN
            QB__newSel = QB_NODE_newLabel_long(QB__sel)
            QB_NODE_assign QB__selOut, QB__newSel
        END IF
    END IF
END IF
QB_NODESET_label_equal& = -QB__selOut
QB_NODESET_free QB__selIn
END FUNCTION

FUNCTION QB_NODESET_allChildren& (QB__selIn AS LONG) 'all decendants, all depths
DIM QB__selOut AS LONG: QB__selOut = QB_NODE_new(QB_NODE_TYPE_HASHSET, 0)
DIM QB__SelInI AS LONG: DIM QB__SelInIterator AS LONG
DIM QB__sel AS LONG
IF QB__selIn < 0 THEN
    DO WHILE QB_NODE_each(QB__SelInI, -QB__selIn, QB__SelInIterator)
        QB__sel = __QB_NODE(QB__SelInI).label
        IF __QB_NODE(QB__sel).count THEN
            __QB_NODESET_addChildren QB__sel, QB__selOut
        END IF
    LOOP
ELSE
    QB__sel = QB__selIn
    IF __QB_NODE(QB__sel).count THEN
        __QB_NODESET_addChildren QB__sel, QB__selOut
    END IF
END IF
QB_NODESET_allChildren& = -QB__selOut
QB_NODESET_free QB__selIn
END FUNCTION

FUNCTION QB_NODESET_children& (QB__selIn AS LONG) 'only 1st level decendants
DIM QB__selOut AS LONG: QB__selOut = QB_NODE_new(QB_NODE_TYPE_HASHSET, 0)
DIM QB__SelInI AS LONG: DIM QB__SelInIterator AS LONG
DIM QB__sel AS LONG
IF QB__selIn < 0 THEN
    DO WHILE QB_NODE_each(QB__SelInI, -QB__selIn, QB__SelInIterator)
        QB__sel = __QB_NODE(QB__SelInI).label
        IF __QB_NODE(QB__sel).count THEN
            __QB_NODESET_addChildrenWithDepth QB__sel, QB__selOut, 1, 1, 1
        END IF
    LOOP
ELSE
    QB__sel = QB__selIn
    IF __QB_NODE(QB__sel).count THEN
        __QB_NODESET_addChildrenWithDepth QB__sel, QB__selOut, 1, 1, 1
    END IF
END IF
QB_NODESET_children& = -QB__selOut
QB_NODESET_free QB__selIn
END FUNCTION

FUNCTION QB_NODESET_parent& (QB__selIn AS LONG)
DIM QB__selOut AS LONG: QB__selOut = QB_NODE_new(QB_NODE_TYPE_HASHSET, 0)
DIM QB__SelInI AS LONG: DIM QB__SelInIterator AS LONG
DIM QB__sel AS LONG
DIM QB__newSel AS LONG
IF QB__selIn < 0 THEN
    DO WHILE QB_NODE_each(QB__SelInI, -QB__selIn, QB__SelInIterator)
        QB__sel = __QB_NODE(QB__SelInI).label
        IF __QB_NODE(QB__sel).parent THEN
            QB__newSel = QB_NODE_newLabel_long(__QB_NODE(QB__sel).parent)
            QB_NODE_assign QB__selOut, QB__newSel
        END IF
    LOOP
ELSE
    QB__sel = QB__selIn
    IF __QB_NODE(QB__sel).parent THEN
        QB__newSel = QB_NODE_newLabel_long(__QB_NODE(QB__sel).parent)
        QB_NODE_assign QB__selOut, QB__newSel
    END IF
END IF
QB_NODESET_parent& = -QB__selOut
QB_NODESET_free QB__selIn
END FUNCTION

FUNCTION QB_NODESET_node& (QB__selIn AS LONG)
IF QB__selIn >= 0 THEN
    QB_NODESET_node& = QB__selIn
    'note: not a nodeset, no need to call nodeset free
    EXIT FUNCTION
END IF
DIM QB__sel AS LONG
QB__sel = __QB_NODE(-QB__selIn).firstChild
IF QB__sel <> 0 THEN
    QB__sel = __QB_NODE(QB__sel).label
END IF
QB_NODESET_node& = QB__sel
QB_NODESET_free QB__selIn
END FUNCTION

FUNCTION QB_NODESET_parents& (QB__selIn AS LONG)
DIM QB__selOut AS LONG: QB__selOut = QB_NODE_new(QB_NODE_TYPE_HASHSET, 0)
DIM QB__SelInI AS LONG: DIM QB__SelInIterator AS LONG
DIM QB__sel AS LONG
DIM QB__newSel AS LONG
IF QB__selIn < 0 THEN
    DO WHILE QB_NODE_each(QB__SelInI, -QB__selIn, QB__SelInIterator)
        QB__sel = __QB_NODE(QB__SelInI).label
        QB__sel = __QB_NODE(QB__sel).parent
        DO WHILE QB__sel
            QB__newSel = QB_NODE_newLabel_long(QB__sel)
            QB_NODE_assign QB__selOut, QB__newSel
            QB__sel = __QB_NODE(QB__sel).parent
        LOOP
    LOOP
ELSE
    QB__sel = QB__selIn
    QB__sel = __QB_NODE(QB__sel).parent
    DO WHILE QB__sel
        QB__newSel = QB_NODE_newLabel_long(QB__sel)
        QB_NODE_assign QB__selOut, QB__newSel
        QB__sel = __QB_NODE(QB__sel).parent
    LOOP
END IF
QB_NODESET_parents& = -QB__selOut
QB_NODESET_free QB__selIn
END FUNCTION

FUNCTION QB_NODESET_each& (QB__SelInI AS LONG, QB__selIn AS LONG, QB__selInIterator AS LONG)
DIM QB__ret AS LONG
QB__ret = QB_NODESET_each_PRESERVE(QB__SelInI, QB__selIn, QB__selInIterator)
IF QB__ret = 0 THEN QB_NODESET_free QB__selIn
QB_NODESET_each& = QB__ret
END FUNCTION
FUNCTION QB_NODESET_each_PRESERVE& (QB__SelInI AS LONG, QB__selIn AS LONG, QB__selInIterator AS LONG)
IF QB__selIn > 0 THEN
    IF QB__selInIterator = 0 THEN
        QB_NODESET_each_PRESERVE& = -1
        QB__SelInI = QB__selIn
    ELSE
        QB__selInIterator = 1
        QB_NODESET_each_PRESERVE& = 0
        QB__SelInI = 0
    END IF
ELSE
    DIM QB__ret AS LONG
    QB_NODESET_each_PRESERVE = QB_NODE_each(QB__SelInI, -QB__selIn, QB__selInIterator)
    IF QB__SelInI <> 0 THEN QB__SelInI = __QB_NODE(QB__SelInI).label
END IF
END FUNCTION

FUNCTION QB_NODESET_deserialize& (json AS STRING, format AS STRING) 'only "json" is supported
'prepass to make deserializing by scanning (INSTR) for : { } [ ] , work
DIM json2 AS STRING
json2 = SPACE$(LEN(json) * 6) 'the maximum size preparsed content can grow is 6x
i2 = 0
inblock = 0
lastA = 0
lastLastA = 0
FOR i1 = 1 TO LEN(json)
    a = ASC(json, i1)
    IF inblock THEN
        IF a = 58 OR a = 123 OR a = 125 OR a = 91 OR a = 93 OR a = 44 THEN 'escape... : { } [ ] ,
            IF a = 58 THEN i2 = i2 + 6: MID$(json2, i2 - 5, 6) = "\u003A"
            IF a = 123 THEN i2 = i2 + 6: MID$(json2, i2 - 5, 6) = "\u007B"
            IF a = 125 THEN i2 = i2 + 6: MID$(json2, i2 - 5, 6) = "\u007D"
            IF a = 91 THEN i2 = i2 + 6: MID$(json2, i2 - 5, 6) = "\u005B"
            IF a = 93 THEN i2 = i2 + 6: MID$(json2, i2 - 5, 6) = "\u005D"
            IF a = 44 THEN i2 = i2 + 6: MID$(json2, i2 - 5, 6) = "\u002C"
        ELSE
            i2 = i2 + 1: ASC(json2, i2) = a
        END IF
        IF a = inblock AND ((lastA <> 92) OR (lastA = 92 AND lastLastA = 92)) THEN inblock = 0 'note: we allow \'
    ELSE
        IF a = 34 THEN inblock = 34
        IF a = 39 THEN inblock = 39
        i2 = i2 + 1: ASC(json2, i2) = a
    END IF
    lastLastA = lastA
    lastA = a
NEXT
json2 = LEFT$(json2, i2)
json2 = LTRIM$(RTRIM$(json2))
DIM QB__index AS LONG
QB__index = 1
QB_NODESET_deserialize& = __QB_JSON_deserialize(json2, QB__index, 0)
END FUNCTION

FUNCTION QB_NODESET_serialize$ (QB__selIn AS LONG, format AS STRING) 'only "json" is supported
QB_NODESET_serialize$ = QB_NODESET_serialize_PRESERVE$(QB__selIn, format)
QB_NODESET_free QB__selIn
END FUNCTION
FUNCTION QB_NODESET_serialize_PRESERVE$ (QB__selIn AS LONG, format AS STRING) 'only "json" is supported
DIM QB__ret AS STRING
DIM QB__SelInI AS LONG: DIM QB__SelInIterator AS LONG
DIM QB__sel AS LONG
IF QB__selIn < 0 THEN
    DIM QB__n AS LONG
    DO WHILE QB_NODE_each(QB__SelInI, -QB__selIn, QB__SelInIterator)
        QB__sel = __QB_NODE(QB__SelInI).label
        QB__n = QB__n + 1
        __QB_JSON_serialize QB__ret, QB__sel, 0
        IF __QB_NODE(-QB__selIn).count <> QB__n THEN QB__ret = QB__ret + ","
    LOOP
ELSE
    QB__sel = QB__selIn
    __QB_JSON_serialize QB__ret, QB__sel, 0
END IF
QB_NODESET_serialize_PRESERVE$ = QB__ret
END FUNCTION

'########################################

'#################### DATETIME: Methods ####################
FUNCTION QB_DATETIME_new (dateTimeType AS LONG)
DIM QB__handle AS LONG
QB__handle = QB_HANDLE_new(__QB_DATETIME_handleSet)
IF QB__handle > __QB_DATETIME_ubound THEN
    __QB_DATETIME_ubound = QB__handle * 2
    REDIM _PRESERVE __QB_DATETIME(__QB_DATETIME_ubound) AS QB_DATETIME
END IF
__QB_DATETIME(QB__handle) = __QB_DATETIME_TYPE_EMPTY
__QB_DATETIME(QB__handle).reserved = 1
__QB_DATETIME(QB__handle).type = dateTimeType
QB_DATETIME_new& = QB__handle
END FUNCTION

SUB QB_DATETIME_get (QB__handle AS LONG, dateTimeToPopulate AS QB_DATETIME)
dateTimeToPopulate = __QB_DATETIME(QB__handle)
END SUB

SUB QB_DATETIME_set (QB__handle AS LONG, dateTimeToPopulate AS QB_DATETIME)
__QB_DATETIME(QB__handle) = dateTimeToPopulate
END SUB

SUB QB_DATETIME_free (QB__handle AS LONG)
IF QB__handle > __QB_DATETIME_ubound OR QB__handle <= 0 THEN ERROR 258: EXIT SUB 'invalid handle
IF __QB_DATETIME(QB__handle).reserved = 0 THEN ERROR 258: EXIT SUB
__QB_DATETIME(QB__handle).reserved = 0
QB_HANDLE_free QB__handle, __QB_DATETIME_handleSet
END SUB

FUNCTION QB_DATETIME_now
DIM QB__handle AS LONG
QB__handle = QB_DATETIME_new(QB_DATETIME_TYPE_LOCAL)
DIM QB__date AS STRING
QB__date = DATE$ 'mm-dd-yyyy
DIM QB__time AS STRING
QB__time = TIME$ 'hh:mm:ss
DIM QB__timer AS DOUBLE
QB__timer = TIMER(0.001)
__QB_DATETIME(QB__handle).months = VAL(MID$(QB__date, 1, 2))
__QB_DATETIME(QB__handle).days = VAL(MID$(QB__date, 4, 2))
__QB_DATETIME(QB__handle).years = VAL(MID$(QB__date, 7, 4))
__QB_DATETIME(QB__handle).hours = VAL(MID$(QB__time, 1, 2))
__QB_DATETIME(QB__handle).minutes = VAL(MID$(QB__time, 4, 2))
__QB_DATETIME(QB__handle).seconds = VAL(MID$(QB__time, 7, 2))
DIM QB__msStr AS STRING
DIM QB__ms AS LONG
QB__msStr = LTRIM$(STR$(QB__timer - INT(QB__timer)))
IF LEN(QB__msStr) > 4 THEN QB__msStr = LEFT$(QB__msStr, 4)
QB__ms = VAL(QB__msStr) * 1000
IF QB__ms >= 1000 THEN QB__ms = 0
__QB_DATETIME(QB__handle).milliseconds = QB__ms
QB_DATETIME_now& = QB__handle
END FUNCTION

FUNCTION QB_DATETIME_format$ (QB__handle AS LONG, format AS STRING)
'Example:
'   PRINT QB_DATETIME_format(myDateHandle, "D/M/YYYY H:mm:ss {AM}") 'could print "31/3/2012 5:02:05 PM"
'
'YYYY - 4 digit year
'YY   - 2 digit year
'MM   - 2 digit month
'M    - 1 or 2 digit month
'DD   - 2 digit day
'D    - 1 or 2 digit day
'{TH},{Th},{th}
'{JAN},{jan},{Jan}
'{JANUARY},{january},{January}
'{MONDAY},{Monday},{monday}
'hh   - 2 digit hour (24 hour time)
'HH   - 2 digit hour (12 hour time)
'h    - 1 or 2 digit hour (24 hour time)
'H    - 1 or 2 digit hour (12 hour time)
'mm   - 2 digit minutes
'm    - 1 or 2 digit minutes
'ss   - 2 digit seconds
's    - 1 or 2 digit seconds
'zzz  - 3 digit milliseconds
'z    - 1, 2 or 3 digit milliseconds
'{AM},{am}
DIM QB__out AS STRING
QB__out = ""
DIM QB__i AS LONG
DIM QB__fi AS LONG
DIM QB__s AS STRING
DIM QB__i1 AS LONG

DIM QB__minDigits AS LONG
DIM QB__value AS STRING

DIM QB__rhs AS STRING

DIM QB__n AS LONG
DIM QB__x AS LONG

DIM QB__smartCase AS LONG

FOR QB__fi = 1 TO LEN(format)

    FOR QB__i = 1 TO 100

        QB__minDigits = -1 'N/A
        QB__smartCase = 0 'match case exactly

        QB__s = ""

        QB__n = 0

        QB__n = QB__n + 1: IF QB__i = QB__n THEN
            QB__s = "{am}"
            QB__smartCase = 1
            IF __QB_DATETIME(QB__handle).hours > 11 THEN QB__value = "pm" ELSE QB__value = "am"
        END IF

        QB__n = QB__n + 1: IF QB__i = QB__n THEN
            QB__s = "{th}"
            QB__smartCase = 1
            QB__value = "th"
            IF __QB_DATETIME(QB__handle).days MOD 10 = 1 THEN QB__value = "st"
            IF __QB_DATETIME(QB__handle).days MOD 10 = 2 THEN QB__value = "nd"
            IF __QB_DATETIME(QB__handle).days MOD 10 = 3 THEN QB__value = "rd"
            IF __QB_DATETIME(QB__handle).days > 10 AND __QB_DATETIME(QB__handle).days < 14 THEN QB__value = "th"
        END IF

        QB__n = QB__n + 1: IF QB__i = QB__n THEN
            QB__s = "{monday}"
            QB__smartCase = 1
            DIM QB__month AS LONG
            DIM QB__year AS LONG
            DIM QB__day AS LONG
            DIM QB__newYear AS STRING
            DIM QB__century AS LONG
            DIM QB__dmy AS LONG
            'http://brisray.com/qbasic/qdate.htm
            QB__day = __QB_DATETIME(QB__handle).days
            QB__month = __QB_DATETIME(QB__handle).months
            QB__year = __QB_DATETIME(QB__handle).years
            IF QB__month < 3 THEN
                QB__month = QB__month + 12
                QB__year = QB__year - 1
            END IF
            '*** Add 1 to the month and multiply by 2.61
            '*** Drop the fraction (not round) afterwards
            QB__month = QB__month + 1
            QB__month = FIX(QB__month * 2.61)
            '*** Add Day, Month and the last two digits of the year
            QB__newYear = LTRIM$(STR$(QB__year))
            QB__year = VAL(RIGHT$(QB__newYear, 2))
            QB__dmy = QB__day + QB__month + QB__year
            QB__century = VAL(LEFT$(QB__newYear, 2))
            '*** Add a quarter of the last two digits of the year
            '*** (truncated not rounded)
            QB__year = FIX(QB__year / 4)
            QB__dmy = QB__dmy + QB__year
            '*** Add the following factors for the year
            IF QB__century = 18 THEN QB__century = 2
            IF QB__century = 19 THEN QB__century = 0
            IF QB__century = 20 THEN QB__century = 6
            IF QB__century = 21 THEN QB__century = 4
            QB__dmy = QB__dmy + QB__century
            '*** The day of the week is the modulus of DMY divided by 7
            QB__dmy = QB__dmy MOD 7
            IF QB__dmy = 0 THEN QB__value = "sunday"
            IF QB__dmy = 1 THEN QB__value = "monday"
            IF QB__dmy = 2 THEN QB__value = "tuesday"
            IF QB__dmy = 3 THEN QB__value = "wednesday"
            IF QB__dmy = 4 THEN QB__value = "thursday"
            IF QB__dmy = 5 THEN QB__value = "friday"
            IF QB__dmy = 6 THEN QB__value = "saturday"
        END IF

        QB__n = QB__n + 1: IF QB__i = QB__n THEN
            QB__s = "{mon}"
            QB__smartCase = 1
            'http://brisray.com/qbasic/qdate.htm
            QB__day = __QB_DATETIME(QB__handle).days
            QB__month = __QB_DATETIME(QB__handle).months
            QB__year = __QB_DATETIME(QB__handle).years
            IF QB__month < 3 THEN
                QB__month = QB__month + 12
                QB__year = QB__year - 1
            END IF
            '*** Add 1 to the month and multiply by 2.61
            '*** Drop the fraction (not round) afterwards
            QB__month = QB__month + 1
            QB__month = FIX(QB__month * 2.61)
            '*** Add Day, Month and the last two digits of the year
            QB__newYear = LTRIM$(STR$(QB__year))
            QB__year = VAL(RIGHT$(QB__newYear, 2))
            QB__dmy = QB__day + QB__month + QB__year
            QB__century = VAL(LEFT$(QB__newYear, 2))
            '*** Add a quarter of the last two digits of the year
            '*** (truncated not rounded)
            QB__year = FIX(QB__year / 4)
            QB__dmy = QB__dmy + QB__year
            '*** Add the following factors for the year
            IF QB__century = 18 THEN QB__century = 2
            IF QB__century = 19 THEN QB__century = 0
            IF QB__century = 20 THEN QB__century = 6
            IF QB__century = 21 THEN QB__century = 4
            QB__dmy = QB__dmy + QB__century
            '*** The day of the week is the modulus of DMY divided by 7
            QB__dmy = QB__dmy MOD 7
            IF QB__dmy = 0 THEN QB__value = "sun"
            IF QB__dmy = 1 THEN QB__value = "mon"
            IF QB__dmy = 2 THEN QB__value = "tue"
            IF QB__dmy = 3 THEN QB__value = "wed"
            IF QB__dmy = 4 THEN QB__value = "thu"
            IF QB__dmy = 5 THEN QB__value = "fri"
            IF QB__dmy = 6 THEN QB__value = "sat"
        END IF

        QB__n = QB__n + 1: IF QB__i = QB__n THEN
            QB__s = "{jan}"
            QB__smartCase = 1
            IF __QB_DATETIME(QB__handle).months = 1 THEN QB__value = "jan"
            IF __QB_DATETIME(QB__handle).months = 2 THEN QB__value = "feb"
            IF __QB_DATETIME(QB__handle).months = 3 THEN QB__value = "mar"
            IF __QB_DATETIME(QB__handle).months = 4 THEN QB__value = "apr"
            IF __QB_DATETIME(QB__handle).months = 5 THEN QB__value = "may"
            IF __QB_DATETIME(QB__handle).months = 6 THEN QB__value = "jun"
            IF __QB_DATETIME(QB__handle).months = 7 THEN QB__value = "jul"
            IF __QB_DATETIME(QB__handle).months = 8 THEN QB__value = "aug"
            IF __QB_DATETIME(QB__handle).months = 9 THEN QB__value = "sep"
            IF __QB_DATETIME(QB__handle).months = 10 THEN QB__value = "oct"
            IF __QB_DATETIME(QB__handle).months = 11 THEN QB__value = "nov"
            IF __QB_DATETIME(QB__handle).months = 12 THEN QB__value = "dec"
        END IF




        QB__n = QB__n + 1: IF QB__i = QB__n THEN
            QB__s = "{january}"
            QB__smartCase = 1
            IF __QB_DATETIME(QB__handle).months = 1 THEN QB__value = "january"
            IF __QB_DATETIME(QB__handle).months = 2 THEN QB__value = "february"
            IF __QB_DATETIME(QB__handle).months = 3 THEN QB__value = "march"
            IF __QB_DATETIME(QB__handle).months = 4 THEN QB__value = "april"
            IF __QB_DATETIME(QB__handle).months = 5 THEN QB__value = "may"
            IF __QB_DATETIME(QB__handle).months = 6 THEN QB__value = "june"
            IF __QB_DATETIME(QB__handle).months = 7 THEN QB__value = "july"
            IF __QB_DATETIME(QB__handle).months = 8 THEN QB__value = "august"
            IF __QB_DATETIME(QB__handle).months = 9 THEN QB__value = "september"
            IF __QB_DATETIME(QB__handle).months = 10 THEN QB__value = "october"
            IF __QB_DATETIME(QB__handle).months = 11 THEN QB__value = "november"
            IF __QB_DATETIME(QB__handle).months = 12 THEN QB__value = "december"
        END IF

        QB__n = QB__n + 1: IF QB__i = QB__n THEN QB__s = "YYYY": QB__minDigits = 4: QB__value = QB_STR_long(__QB_DATETIME(QB__handle).years)
        QB__n = QB__n + 1: IF QB__i = QB__n THEN QB__s = "YY": QB__minDigits = 2: QB__value = QB_STR_long(__QB_DATETIME(QB__handle).years MOD 100)

        QB__n = QB__n + 1: IF QB__i = QB__n THEN QB__s = "MM": QB__minDigits = 2: QB__value = QB_STR_long(__QB_DATETIME(QB__handle).months)
        QB__n = QB__n + 1: IF QB__i = QB__n THEN QB__s = "M": QB__minDigits = 1: QB__value = QB_STR_long(__QB_DATETIME(QB__handle).months)

        QB__n = QB__n + 1: IF QB__i = QB__n THEN QB__s = "DD": QB__minDigits = 2: QB__value = QB_STR_long(__QB_DATETIME(QB__handle).days)
        QB__n = QB__n + 1: IF QB__i = QB__n THEN QB__s = "D": QB__minDigits = 1: QB__value = QB_STR_long(__QB_DATETIME(QB__handle).days)

        QB__n = QB__n + 1: IF QB__i = QB__n THEN QB__s = "hh": QB__minDigits = 2: QB__value = QB_STR_long(__QB_DATETIME(QB__handle).hours)
        QB__n = QB__n + 1: IF QB__i = QB__n THEN QB__s = "h": QB__minDigits = 1: QB__value = QB_STR_long(__QB_DATETIME(QB__handle).hours)

        QB__n = QB__n + 1: IF QB__i = QB__n THEN
            QB__s = "HH": QB__minDigits = 2:
            QB__x = __QB_DATETIME(QB__handle).hours
            IF QB__x > 12 THEN QB__x = QB__x - 12
            IF QB__x = 0 THEN QB__x = 12
            QB__value = QB_STR_long(QB__x)
        END IF
        QB__n = QB__n + 1: IF QB__i = QB__n THEN
            QB__s = "H": QB__minDigits = 1
            QB__x = __QB_DATETIME(QB__handle).hours
            IF QB__x > 12 THEN QB__x = QB__x - 12
            IF QB__x = 0 THEN QB__x = 12
            QB__value = QB_STR_long(QB__x)
        END IF

        QB__n = QB__n + 1: IF QB__i = QB__n THEN QB__s = "mm": QB__minDigits = 2: QB__value = QB_STR_long(__QB_DATETIME(QB__handle).minutes)
        QB__n = QB__n + 1: IF QB__i = QB__n THEN QB__s = "m": QB__minDigits = 1: QB__value = QB_STR_long(__QB_DATETIME(QB__handle).minutes)

        QB__n = QB__n + 1: IF QB__i = QB__n THEN QB__s = "ss": QB__minDigits = 2: QB__value = QB_STR_long(__QB_DATETIME(QB__handle).seconds)
        QB__n = QB__n + 1: IF QB__i = QB__n THEN QB__s = "s": QB__minDigits = 1: QB__value = QB_STR_long(__QB_DATETIME(QB__handle).seconds)

        QB__n = QB__n + 1: IF QB__i = QB__n THEN QB__s = "zzz": QB__minDigits = 3: QB__value = QB_STR_long(__QB_DATETIME(QB__handle).milliseconds)
        QB__n = QB__n + 1: IF QB__i = QB__n THEN QB__s = "z": QB__minDigits = 1: QB__value = QB_STR_long(__QB_DATETIME(QB__handle).milliseconds)


        IF QB__s <> "" THEN

            IF QB__smartCase THEN
                QB__rhs = LCASE$(RIGHT$(format, LEN(format) - QB__fi + 1)) + "                    "
            ELSE
                QB__rhs = RIGHT$(format, LEN(format) - QB__fi + 1) + "                    "
            END IF

            IF LEFT$(QB__rhs, LEN(QB__s)) = QB__s THEN
                IF QB__minDigits <> -1 THEN
                    IF LEN(QB__value) < QB__minDigits THEN
                        QB__value = STRING$(QB__minDigits - LEN(QB__value), "0") + QB__value
                    END IF
                END IF
                IF QB__smartCase THEN
                    QB__rhs = RIGHT$(format, LEN(format) - QB__fi + 1) + "                    "
                    QB__value = __QB_DATETIME_format_smartCase$(QB__rhs, QB__value)
                END IF

                QB__out = QB__out + QB__value
                QB__fi = QB__fi + LEN(QB__s) - 1
                EXIT FOR
            END IF
        END IF
    NEXT
    IF QB__i = 101 THEN QB__out = QB__out + MID$(format, QB__fi, 1)
NEXT
QB_DATETIME_format$ = QB__out
END FUNCTION

'########################################


'#################### STRING: Methods ####################

FUNCTION QB_STR_empty&
DIM QB__handle AS LONG
QB__handle = QB_HANDLE_new(__QB_STR_handleSet)
IF QB__handle > __QB_STR_stringUbound THEN
    __QB_STR_stringUbound = QB__handle * 2
    REDIM _PRESERVE __QB_STR_string(__QB_STR_stringUbound) AS STRING
    REDIM _PRESERVE __QB_STR_stringValid(__QB_STR_stringUbound) AS LONG
END IF
__QB_STR_stringValid(QB__handle) = 1
IF LEN(__QB_STR_string(QB__handle)) <> 0 THEN __QB_STR_string(QB__handle) = ""
QB_STR_empty& = QB__handle
END FUNCTION

FUNCTION QB_STR_new& (Value AS STRING)
DIM QB__handle AS LONG
QB__handle = QB_HANDLE_new(__QB_STR_handleSet)
IF QB__handle > __QB_STR_stringUbound THEN
    __QB_STR_stringUbound = QB__handle * 2
    REDIM _PRESERVE __QB_STR_string(__QB_STR_stringUbound) AS STRING
    REDIM _PRESERVE __QB_STR_stringValid(__QB_STR_stringUbound) AS LONG
END IF
__QB_STR_stringValid(QB__handle) = 1
__QB_STR_string(QB__handle) = Value
QB_STR_new& = QB__handle
END FUNCTION

FUNCTION QB_STR_get$ (handle AS LONG)
IF handle > __QB_STR_stringUbound OR handle <= 0 THEN
    $CHECKING:OFF
    ERROR 258 'invalid handle
    EXIT SUB
    $CHECKING:ON
END IF
IF __QB_STR_stringValid(handle) = 0 THEN
    $CHECKING:OFF
    ERROR 258 'invalid handle
    EXIT SUB
    $CHECKING:ON
END IF
QB_STR_get$ = __QB_STR_string(handle)
END FUNCTION

SUB QB_STR_set (handle AS LONG, value AS STRING)
IF handle > __QB_STR_stringUbound OR handle <= 0 THEN ERROR 258: EXIT SUB 'invalid handle
IF __QB_STR_stringValid(handle) = 0 THEN ERROR 258: EXIT SUB
__QB_STR_string(handle) = value
END SUB

SUB QB_STR_free (handle AS LONG)
IF handle > __QB_STR_stringUbound OR handle <= 0 THEN ERROR 258: EXIT SUB 'invalid handle
IF __QB_STR_stringValid(handle) = 0 THEN ERROR 258: EXIT SUB
__QB_STR_stringValid(handle) = 0
QB_HANDLE_free handle, __QB_STR_handleSet
END SUB

FUNCTION QB_STR_long$ (value AS LONG) 'returns a string representation of a long value
QB_STR_long$ = LTRIM$(STR$(value))
END FUNCTION

'##################################################


'#################### HANDLE: Methods ####################

FUNCTION QB_HANDLE_newSet&
DIM QB__context AS LONG
QB__context = QB_HANDLE_new(1)
IF UBOUND(__QB_HANDLE_handler) < QB__context THEN
    REDIM _PRESERVE __QB_HANDLE_handler(QB__context * 2) AS __QB_HANDLE_HANDLER
END IF
__QB_HANDLE_handler(QB__context).lastFreedListIndex = 0
__QB_HANDLE_handler(QB__context).lastHandle = 0
__QB_HANDLE_handler(QB__context).count = 0
QB_HANDLE_newSet& = QB__context
END FUNCTION

SUB QB_HANDLE_freeSet (context AS LONG)
QB_HANDLE_free context, 1
END SUB

FUNCTION QB_HANDLE_count& (context AS LONG)
QB_HANDLE_count& = __QB_HANDLE_handler(context).count
END FUNCTION

FUNCTION QB_HANDLE_new& (context AS LONG)
__QB_HANDLE_handler(context).count = __QB_HANDLE_handler(context).count + 1
DIM QB__handle AS LONG
IF __QB_HANDLE_handler(context).lastFreedListIndex = 0 THEN
    QB__handle = __QB_HANDLE_handler(context).lastHandle + 1
    __QB_HANDLE_handler(context).lastHandle = QB__handle
    QB_HANDLE_new& = QB__handle
    EXIT FUNCTION
END IF
DIM __QB_HANDLE_lastIndex AS LONG
__QB_HANDLE_lastIndex = __QB_HANDLE_handler(context).lastFreedListIndex
QB__handle = __QB_HANDLE_freedList(__QB_HANDLE_lastIndex).handle
__QB_HANDLE_handler(context).lastFreedListIndex = __QB_HANDLE_freedList(__QB_HANDLE_lastIndex).prevFreedListIndex
'add to freed-freed list so the freed structure can be reused
IF __QB_HANDLE_freedFreedList_Next > __QB_HANDLE_freedFreedList_Last THEN
    __QB_HANDLE_freedFreedList_Last = __QB_HANDLE_freedFreedList_Next * 2
    REDIM _PRESERVE __QB_HANDLE_freedFreedList(__QB_HANDLE_freedFreedList_Last) AS LONG
END IF
__QB_HANDLE_freedFreedList(__QB_HANDLE_freedFreedList_Next) = __QB_HANDLE_lastIndex
__QB_HANDLE_freedFreedList_Next = __QB_HANDLE_freedFreedList_Next + 1
QB_HANDLE_new& = QB__handle
END FUNCTION

SUB QB_HANDLE_free (handle AS LONG, context AS LONG) 'MUST pass a valid handle
__QB_HANDLE_handler(context).count = __QB_HANDLE_handler(context).count - 1
'add handle to freed list
DIM QB__index AS LONG
IF __QB_HANDLE_freedFreedList_Next > 1 THEN 'recover from freed-freed list?
    __QB_HANDLE_freedFreedList_Next = __QB_HANDLE_freedFreedList_Next - 1
    QB__index = __QB_HANDLE_freedFreedList(__QB_HANDLE_freedFreedList_Next)
ELSE
    IF __QB_HANDLE_freedList_Next > __QB_HANDLE_freedList_Last THEN
        __QB_HANDLE_freedList_Last = __QB_HANDLE_freedList_Next * 2
        REDIM _PRESERVE __QB_HANDLE_freedList(__QB_HANDLE_freedList_Last) AS __QB_HANDLE_FREEDLIST
    END IF
    QB__index = __QB_HANDLE_freedList_Next
    __QB_HANDLE_freedList_Next = __QB_HANDLE_freedList_Next + 1
END IF
__QB_HANDLE_freedList(QB__index).prevFreedListIndex = __QB_HANDLE_handler(context).lastFreedListIndex
__QB_HANDLE_freedList(QB__index).handle = handle
__QB_HANDLE_handler(context).lastFreedListIndex = QB__index
END SUB

'##################################################


'#################### EACH: Methods ####################

FUNCTION QB_EACH_str_in_str& (value AS STRING, parent AS STRING, separator AS STRING, flags AS LONG, i AS LONG)
'requirements:
'   iterator must be a LONG, initially set to 0
'notes:
'   refer to constants for available flags (0 is default)
DIM QB__byteValue AS LONG
DIM QB__parentLen AS LONG
DIM QB__sepValue AS LONG
DIM QB__i1 AS LONG
DIM QB__retry AS LONG
QB__sepValue = ASC(separator)
QB__parentLen = LEN(parent)
DO
    i = i + 1
    IF i > QB__parentLen THEN
        value = ""
        IF i = QB__parentLen + 1 THEN
            IF QB__parentLen <> 0 THEN
                IF ASC(parent, i - 1) = QB__sepValue THEN
                    IF (flags AND (QB_EACH_ALLOW_BLANK OR QB_EACH_ALLOW_ALL_BLANK)) <> 0 THEN QB_EACH_str_in_str& = -1
                END IF
            ELSE
                IF (flags AND QB_EACH_ALLOW_ALL_BLANK) <> 0 THEN QB_EACH_str_in_str& = -1
            END IF
        END IF
        EXIT FUNCTION
    END IF
    QB__i1 = i
    byteValue = ASC(parent, i)
    $CHECKING:OFF
    DO WHILE byteValue <> QB__sepValue
        i = i + 1
        IF i > QB__parentLen THEN EXIT DO
        byteValue = ASC(parent, i)
    LOOP
    $CHECKING:ON
    value = MID$(parent, QB__i1, i - QB__i1)
    IF LEN(value) = 0 AND (flags AND (QB_EACH_ALLOW_BLANK OR QB_EACH_ALLOW_ALL_BLANK)) = 0 THEN
        QB__retry = 1
    ELSE
        QB__retry = 0
    END IF
LOOP WHILE QB__retry
QB_EACH_str_in_str& = -1
END FUNCTION

FUNCTION QB_EACH_long_in_str& (value AS LONG, parent AS STRING, separator AS STRING, i AS LONG)
'requirements:
'   a comma separated list of valid LONG values
'   no whitespace
'   no leading, trailing or adjacent commas
'   iterator must be a LONG
'   value must be a LONG
DIM QB__byteValue AS LONG
DIM QB__parentLen AS LONG
DIM QB__negate AS LONG
DIM QB__sepValue AS LONG
QB__sepValue = ASC(separator)
QB__parentLen = LEN(parent)
value = 0 'reset value (avoids undefined results)
i = i + 1
IF i > QB__parentLen THEN EXIT FUNCTION
QB__byteValue = ASC(parent, i)
IF QB__byteValue = 45 THEN
    QB__negate = 1
    i = i + 1
    QB__byteValue = ASC(parent, i)
END IF
DO WHILE QB__byteValue <> QB__sepValue
    value = value * 10 + QB__byteValue - 48
    i = i + 1
    IF i > QB__parentLen THEN EXIT DO
    QB__byteValue = ASC(parent, i)
LOOP
IF QB__negate THEN value = -value
QB_EACH_long_in_str& = -1
END FUNCTION

'##################################################


'#################### Key Value Pair Dictionary Look-Ups: Methods ####################



FUNCTION QB_NODE_newValueWithLabel& (label AS STRING, value AS STRING) 'assume str_str
DIM QB__handle AS LONG
QB__handle = __QB_NODE_new&(QB_NODE_TYPE_VALUE)
__QB_NODE(QB__handle).labelFormat = QB_NODE_FORMAT_STR
__QB_NODE(QB__handle).label = QB_STR_new(label)
__QB_NODE(QB__handle).valueFormat = QB_NODE_FORMAT_STR
__QB_NODE(QB__handle).value = QB_STR_new(value)
QB_NODE_newValueWithLabel& = QB__handle
END FUNCTION


FUNCTION QB_NODE_newValueWithLabel_long& (label AS STRING, value AS LONG) 'assume str_long
DIM QB__handle AS LONG
QB__handle = __QB_NODE_new&(QB_NODE_TYPE_VALUE)
__QB_NODE(QB__handle).labelFormat = QB_NODE_FORMAT_STR
__QB_NODE(QB__handle).label = QB_STR_new(label)
__QB_NODE(QB__handle).valueFormat = QB_NODE_FORMAT_LONG
__QB_NODE(QB__handle).value = value
QB_NODE_newValueWithLabel_long& = QB__handle
END FUNCTION

FUNCTION QB_NODE_newValueWithLabel_bool& (label AS STRING, value AS LONG) 'assume str_bool
DIM QB__handle AS LONG
QB__handle = __QB_NODE_new&(QB_NODE_TYPE_VALUE)
__QB_NODE(QB__handle).labelFormat = QB_NODE_FORMAT_STR
__QB_NODE(QB__handle).label = QB_STR_new(label)
__QB_NODE(QB__handle).valueFormat = QB_NODE_FORMAT_BOOL
IF value = 0 THEN
    __QB_NODE(QB__handle).value = QB_FALSE
ELSE
    __QB_NODE(QB__handle).value = QB_TRUE
END IF
QB_NODE_newValueWithLabel_bool& = QB__handle
END FUNCTION

FUNCTION QB_NODE_newLabel& (label AS STRING) 'assume str
DIM QB__handle AS LONG
QB__handle = __QB_NODE_new&(QB_NODE_TYPE_VALUE)
__QB_NODE(QB__handle).labelFormat = QB_NODE_FORMAT_STR
__QB_NODE(QB__handle).label = QB_STR_new(label)
QB_NODE_newLabel& = QB__handle
END FUNCTION

FUNCTION QB_NODE_newValue& (value AS STRING) 'assume str
DIM QB__handle AS LONG
QB__handle = __QB_NODE_new&(QB_NODE_TYPE_VALUE)
__QB_NODE(QB__handle).valueFormat = QB_NODE_FORMAT_STR
__QB_NODE(QB__handle).value = QB_STR_new(value)
QB_NODE_newValue& = QB__handle
END FUNCTION

FUNCTION QB_NODE_newLabel_long& (label AS LONG)
DIM QB__handle AS LONG
QB__handle = __QB_NODE_new&(QB_NODE_TYPE_VALUE)
__QB_NODE(QB__handle).labelFormat = QB_NODE_FORMAT_LONG
__QB_NODE(QB__handle).label = label
QB_NODE_newLabel_long& = QB__handle
END FUNCTION

FUNCTION QB_NODE_typeName$ (nodeType AS LONG)
IF nodeType = 1 THEN QB_NODE_typeName$ = "HASHSET"
IF nodeType = 2 THEN QB_NODE_typeName$ = "LIST"
IF nodeType = 4 THEN QB_NODE_typeName$ = "DICTIONARY"
IF nodeType = 8 THEN QB_NODE_typeName$ = "VALUE"
END FUNCTION

FUNCTION QB_NODE_new& (nodeType AS LONG, flags AS LONG)
IF QB_DEBUG_VERBOSE THEN PRINT "QB_NODE_new()"
DIM QB__handle AS LONG
QB__handle = QB_HANDLE_new(__QB_NODE_handleSet)
IF QB__handle > __QB_NODE_ubound THEN
    __QB_NODE_ubound = QB__handle * 2
    REDIM _PRESERVE __QB_NODE(__QB_NODE_ubound) AS QB_NODE_TYPE
END IF
__QB_NODE(QB__handle) = QB_NODE_TYPE_EMPTY
__QB_NODE(QB__handle).valid = 1
__QB_NODE(QB__handle).type = nodeType
__QB_NODE(QB__handle).flags = flags
IF nodeType AND (QB_NODE_TYPE_HASHSET + QB_NODE_TYPE_DICTIONARY) THEN
    __QB_NODE(QB__handle).hashOffset = INT(RND * 16777215)
END IF
IF QB_DEBUG THEN PRINT "Created node type"; nodeType
QB_NODE_new& = QB__handle
END FUNCTION


FUNCTION QB_NODE_newDictionary&
QB_NODE_newDictionary& = QB_NODE_new(QB_NODE_TYPE_DICTIONARY, 0)
END FUNCTION

FUNCTION QB_NODE_newList&
QB_NODE_newList& = QB_NODE_new(QB_NODE_TYPE_LIST, 0)
END FUNCTION

FUNCTION QB_NODE_newHashSet&
QB_NODE_newHashSet& = QB_NODE_new(QB_NODE_TYPE_HASHSET, 0)
END FUNCTION

SUB QB_NODE_setValue_format (QB__handle AS LONG, value AS LONG, format AS LONG)
$CHECKING:OFF
IF __QB_NODE_validateHandle(QB__handle, QB_NODE_TYPE_VALUE) = -1 THEN EXIT FUNCTION
$CHECKING:ON
'format-specific validation here
__QB_NODE(QB__handle).value = value
__QB_NODE(QB__handle).valueFormat = format
END SUB

SUB QB_NODE_setLabel_format (QB__handle AS LONG, label AS LONG, format AS LONG)
$CHECKING:OFF
IF __QB_NODE_validateHandle(QB__handle, QB_NODE_TYPE_VALUE + QB_NODE_TYPE_HASHSET + QB_NODE_TYPE_LIST + QB_NODE_TYPE_DICTIONARY) = -1 THEN EXIT FUNCTION
$CHECKING:ON
'format-specific validation here
__QB_NODE(QB__handle).label = label
__QB_NODE(QB__handle).labelFormat = format
END SUB

SUB QB_NODE_setValue (QB__handle AS LONG, value AS STRING) 'assume str
$CHECKING:OFF
IF __QB_NODE_validateHandle(QB__handle, QB_NODE_TYPE_VALUE) = -1 THEN EXIT FUNCTION
$CHECKING:ON
__QB_NODE(QB__handle).value = QB_STR_new(value)
__QB_NODE(QB__handle).valueFormat = QB_NODE_FORMAT_STR
END SUB

SUB QB_NODE_setLabel (QB__handle AS LONG, label AS STRING) 'assume str
$CHECKING:OFF
IF __QB_NODE_validateHandle(QB__handle, QB_NODE_TYPE_VALUE + QB_NODE_TYPE_HASHSET + QB_NODE_TYPE_LIST + QB_NODE_TYPE_DICTIONARY) = -1 THEN EXIT FUNCTION
$CHECKING:ON
'TODO: If parent is a dictionary/hashset detach then reattach
__QB_NODE(QB__handle).label = QB_STR_new(label)
__QB_NODE(QB__handle).labelFormat = QB_NODE_FORMAT_STR
END SUB

FUNCTION QB_NODE_value$ (QB__handle AS LONG) 'assume str
$CHECKING:OFF
IF __QB_NODE_validateHandle(QB__handle, QB_NODE_TYPE_VALUE) = -1 THEN EXIT FUNCTION
$CHECKING:ON
'format-specific validation here
IF __QB_NODE(QB__handle).valueFormat = QB_NODE_FORMAT_STR THEN
    QB_NODE_value$ = QB_STR_get(__QB_NODE(QB__handle).value)
    EXIT FUNCTION
END IF
IF __QB_NODE(QB__handle).valueFormat = QB_NODE_FORMAT_LONG THEN
    QB_NODE_value$ = QB_STR_long(__QB_NODE(QB__handle).value)
    EXIT FUNCTION
END IF
IF __QB_NODE(QB__handle).valueFormat = QB_NODE_FORMAT_NULL THEN
    QB_NODE_value$ = "null"
    EXIT FUNCTION
END IF
IF __QB_NODE(QB__handle).valueFormat = QB_NODE_FORMAT_BOOL THEN
    IF __QB_NODE(QB__handle).value <> 0 THEN
        QB_NODE_value$ = "true"
    ELSE
        QB_NODE_value$ = "false"
    END IF
    EXIT FUNCTION
END IF
QB_NODE_value$ = "undefined"
END SUB

FUNCTION QB_NODE_label$ (QB__handle AS LONG) 'assume str
$CHECKING:OFF
IF __QB_NODE_validateHandle(QB__handle, QB_NODE_TYPE_VALUE) = -1 THEN EXIT FUNCTION
$CHECKING:ON
'format-specific validation here
IF __QB_NODE(QB__handle).labelFormat = QB_NODE_FORMAT_STR THEN
    QB_NODE_label$ = QB_STR_get(__QB_NODE(QB__handle).label)
    EXIT FUNCTION
END IF
IF __QB_NODE(QB__handle).labelFormat = QB_NODE_FORMAT_LONG THEN
    QB_NODE_label$ = QB_STR_long(__QB_NODE(QB__handle).label)
    EXIT FUNCTION
END IF
IF __QB_NODE(QB__handle).labelFormat = QB_NODE_FORMAT_NULL THEN
    QB_NODE_label$ = "null"
    EXIT FUNCTION
END IF
IF __QB_NODE(QB__handle).labelFormat = QB_NODE_FORMAT_BOOL THEN
    IF __QB_NODE(QB__handle).label <> 0 THEN
        QB_NODE_label$ = "true"
    ELSE
        QB_NODE_label$ = "false"
    END IF
    EXIT FUNCTION
END IF
QB_NODE_label$ = "undefined"
END SUB

FUNCTION QB_NODE_count& (QB__handle AS LONG)
$CHECKING:OFF
IF __QB_NODE_validateHandle(QB__handle, QB_NODE_TYPE_HASHSET + QB_NODE_TYPE_DICTIONARY + QB_NODE_TYPE_LIST) = -1 THEN EXIT FUNCTION
$CHECKING:ON
QB_NODE_count& = __QB_NODE(QB__handle).count
END FUNCTION

FUNCTION QB_NODE_each& (child AS LONG, parent AS LONG, i AS LONG)
$CHECKING:OFF
IF i = 0 THEN
    IF __QB_NODE_validateHandle(parent, QB_NODE_TYPE_LIST + QB_NODE_TYPE_HASHSET + QB_NODE_TYPE_DICTIONARY) = -1 THEN EXIT FUNCTION
END IF
$CHECKING:ON
'i is either 0(on first call), -1(end of set reached) or the NEXT node
IF i = -1 THEN
    child = 0
    EXIT FUNCTION
END IF
IF i = 0 THEN
    child = __QB_NODE(parent).firstChild
ELSE
    child = i
END IF
IF child = 0 THEN 'node does not exist
    i = -1
    EXIT FUNCTION
END IF
i = __QB_NODE(child).next
IF i = 0 THEN
    i = -1
END IF
QB_NODE_each& = -1
END FUNCTION

FUNCTION QB_NODE_eachWithLabel_format& (child AS LONG, parent AS LONG, label AS LONG, labelFormat AS LONG, i AS LONG)
$CHECKING:OFF
IF i = 0 THEN
    IF __QB_NODE_validateHandle(parent, QB_NODE_TYPE_DICTIONARY + QB_NODE_TYPE_HASHSET) = -1 THEN EXIT FUNCTION
END IF
$CHECKING:ON
IF __QB_NODE(parent).type AND (QB_NODE_TYPE_DICTIONARY + QB_NODE_TYPE_HASHSET) THEN
    'i is either 0(on first call), -1(end of set reached) or the NEXT node
    IF i = -1 THEN
        child = 0
        EXIT FUNCTION
    END IF
    DIM QB__label AS STRING
    IF i = 0 THEN
        DIM QB__hashValue AS LONG
        IF labelFormat = QB_NODE_FORMAT_LONG THEN
            QB__hashValue = __QB_NODE_hashLong(label, __QB_NODE(parent).hashOffset)
        ELSE
            IF labelFormat = QB_NODE_FORMAT_STR THEN
                QB__label = QB_STR_get(label)
                IF (__QB_NODE(parent).flags AND QB_NODE_CASE_SENSITIVE) = 0 THEN
                    QB__label = LCASE$(QB__label)
                END IF
                QB__hashValue = __QB_NODE_hashStr(QB__label, __QB_NODE(parent).hashOffset)
            END IF
        END IF
        DIM QB__hashList AS LONG
        QB__hashList = __QB_NODE_hashLists(QB__hashValue)
        IF QB__hashList = 0 THEN
            'no hash list exists
            i = -1
            EXIT FUNCTION
        END IF
        i = __QB_NODE(QB__hashList).firstChild
    ELSE
        IF labelFormat = QB_NODE_FORMAT_STR THEN
            QB__label = QB_STR_get(label)
            IF (__QB_NODE(parent).flags AND QB_NODE_CASE_SENSITIVE) = 0 THEN
                QB__label = LCASE$(QB__label)
            END IF
        END IF
    END IF
    DO
        IF i = 0 THEN
            i = -1
            EXIT FUNCTION
        END IF
        'check if current node matches label
        IF __QB_NODE(i).owner = parent THEN 'same owner
            IF __QB_NODE(i).labelFormat = labelFormat THEN 'same label format
                DIM QB__same AS LONG
                QB__same = 0
                IF labelFormat = QB_NODE_FORMAT_LONG THEN
                    IF __QB_NODE(i).label = label THEN QB__same = 1
                ELSE
                    IF QB_STR_get(__QB_NODE(i).label) = QB__label THEN QB__same = 1
                END IF
                IF QB__same THEN 'same label
                    child = __QB_NODE(i).value
                    i = __QB_NODE(i).next
                    IF i = 0 THEN
                        i = -1
                    END IF
                    QB_NODE_eachWithLabel_format& = -1
                    EXIT FUNCTION
                END IF
            END IF
        END IF
        i = __QB_NODE(i).next
    LOOP
END IF 'DICTIONARY
END FUNCTION

FUNCTION QB_NODE_withLabel_format& (parent AS LONG, label AS LONG, labelFormat AS LONG)
$CHECKING:OFF
IF __QB_NODE_validateHandle(parent, QB_NODE_TYPE_DICTIONARY + QB_NODE_TYPE_HASHSET) = -1 THEN EXIT FUNCTION
$CHECKING:ON
IF __QB_NODE(parent).type AND (QB_NODE_TYPE_DICTIONARY + QB_NODE_TYPE_HASHSET) THEN
    DIM QB__label AS STRING
    DIM QB__hashValue AS LONG
    IF labelFormat = QB_NODE_FORMAT_LONG THEN
        QB__hashValue = __QB_NODE_hashLong(label, __QB_NODE(parent).hashOffset)
    ELSE
        IF labelFormat = QB_NODE_FORMAT_STR THEN
            QB__label = QB_STR_get(label)
            IF (__QB_NODE(parent).flags AND QB_NODE_CASE_SENSITIVE) = 0 THEN
                QB__label = LCASE$(QB__label)
            END IF
            QB__hashValue = __QB_NODE_hashStr(QB__label, __QB_NODE(parent).hashOffset)
        END IF
    END IF
    DIM QB__hashList AS LONG
    QB__hashList = __QB_NODE_hashLists(QB__hashValue)
    IF QB__hashList = 0 THEN EXIT FUNCTION
    DIM QB__i AS LONG
    QB__i = __QB_NODE(QB__hashList).firstChild
    DO WHILE QB__i <> 0
        IF __QB_NODE(QB__i).owner = parent THEN 'same owner
            IF __QB_NODE(QB__i).labelFormat = labelFormat THEN 'same label format
                DIM QB__same AS LONG
                QB__same = 0
                IF labelFormat = QB_NODE_FORMAT_LONG THEN
                    IF __QB_NODE(QB__i).label = label THEN QB__same = 1
                ELSE
                    IF QB_STR_get(__QB_NODE(QB__i).label) = QB__label THEN QB__same = 1
                END IF
                IF QB__same THEN 'same label
                    QB_NODE_withLabel_format& = __QB_NODE(QB__i).value
                    EXIT FUNCTION
                END IF
            END IF
        END IF
        QB__i = __QB_NODE(QB__i).next
    LOOP
    EXIT FUNCTION 'not found
END IF 'DICTIONARY
END FUNCTION

FUNCTION QB_NODE_valueOfLabel$ (parent AS LONG, label AS STRING) 'assume str-label, str-value
DIM QB__i AS LONG
QB__i = QB_NODE_withLabel&(parent, label)
IF QB__i THEN
    QB_NODE_valueOfLabel$ = QB_NODE_value(QB__i)
END IF
END FUNCTION

FUNCTION QB_NODE_valueOfLabel_long& (parent AS LONG, label AS STRING) 'assume str-label
DIM QB__i AS LONG
QB__i = QB_NODE_withLabel&(parent, label)
IF QB__i THEN
    QB_NODE_valueOfLabel_long& = __QB_NODE(QB__i).value
END IF
END FUNCTION

FUNCTION QB_NODE_valueOfLabel_bool& (parent AS LONG, label AS STRING) 'assume str-label
DIM QB__i AS LONG
QB__i = QB_NODE_withLabel&(parent, label)
IF QB__i THEN
    QB_NODE_valueOfLabel_bool& = __QB_NODE(QB__i).value
END IF
END FUNCTION

FUNCTION QB_NODE_withLabel& (parent AS LONG, label AS STRING)
$CHECKING:OFF
IF __QB_NODE_validateHandle(parent, QB_NODE_TYPE_DICTIONARY + QB_NODE_TYPE_HASHSET) = -1 THEN EXIT FUNCTION
$CHECKING:ON
IF __QB_NODE(parent).type AND (QB_NODE_TYPE_DICTIONARY + QB_NODE_TYPE_HASHSET) THEN
    DIM QB__label AS STRING
    DIM QB__hashValue AS LONG
    QB__label = label
    IF (__QB_NODE(parent).flags AND QB_NODE_CASE_SENSITIVE) = 0 THEN
        QB__label = LCASE$(QB__label)
    END IF
    QB__hashValue = __QB_NODE_hashStr(QB__label, __QB_NODE(parent).hashOffset)
    DIM QB__hashList AS LONG
    QB__hashList = __QB_NODE_hashLists(QB__hashValue)
    IF QB__hashList = 0 THEN EXIT FUNCTION
    DIM QB__i AS LONG
    QB__i = __QB_NODE(QB__hashList).firstChild
    DO WHILE QB__i <> 0
        IF __QB_NODE(QB__i).owner = parent THEN 'same owner
            IF __QB_NODE(QB__i).labelFormat = QB_NODE_FORMAT_STR THEN 'same label format
                DIM QB__same AS LONG
                QB__same = 0
                IF QB_STR_get(__QB_NODE(QB__i).label) = QB__label THEN QB__same = 1
                IF QB__same THEN 'same label
                    QB_NODE_withLabel& = __QB_NODE(QB__i).value
                    EXIT FUNCTION
                END IF
            END IF
        END IF
        QB__i = __QB_NODE(QB__i).next
    LOOP
    EXIT FUNCTION 'not found
END IF 'DICTIONARY
END FUNCTION


SUB QB_NODE_assign (parent AS LONG, child AS LONG)
$CHECKING:OFF
IF __QB_NODE_validateHandle(child, QB_NODE_TYPE_VALUE + QB_NODE_TYPE_HASHSET + QB_NODE_TYPE_LIST + QB_NODE_TYPE_DICTIONARY) = -1 THEN EXIT FUNCTION
IF __QB_NODE_validateHandle(parent, QB_NODE_TYPE_HASHSET + QB_NODE_TYPE_LIST + QB_NODE_TYPE_DICTIONARY) = -1 THEN EXIT FUNCTION
$CHECKING:ON

IF __QB_NODE(parent).type AND (QB_NODE_TYPE_LIST) THEN
    QB_NODE_detach child
    __QB_NODE_append parent, child
END IF

IF __QB_NODE(parent).type AND (QB_NODE_TYPE_DICTIONARY + QB_NODE_TYPE_HASHSET) THEN
    QB_NODE_detach child

    DIM QB__label AS STRING
    DIM QB__hashValue AS LONG

    IF __QB_NODE(child).labelFormat = QB_NODE_FORMAT_LONG THEN
        QB__hashValue = __QB_NODE_hashLong(__QB_NODE(child).label, __QB_NODE(parent).hashOffset)
    ELSE
        IF __QB_NODE(child).labelFormat = QB_NODE_FORMAT_STR THEN
            QB__label = QB_STR_get(__QB_NODE(child).label)
            IF (__QB_NODE(parent).flags AND QB_NODE_CASE_SENSITIVE) = 0 THEN
                QB__label = LCASE$(QB__label)
            END IF
            QB__hashValue = __QB_NODE_hashStr(QB__label, __QB_NODE(parent).hashOffset)
        END IF
    END IF
    DIM QB__hashList AS LONG
    QB__hashList = __QB_NODE_hashLists(QB__hashValue)
    DIM QB__canReplace AS LONG
    QB__canReplace = 1
    IF (__QB_NODE(parent).flags AND QB_NODE_ALLOW_DUPLICATE_KEYS) <> 0 THEN
        QB__canReplace = 0
        IF (__QB_NODE(parent).flags AND QB_NODE_AVOID_DUPLICATE_VALUES_PER_KEY) <> 0 THEN QB__canReplace = 1
    END IF

    DIM QB__childValue AS STRING
    IF (__QB_NODE(parent).flags AND QB_NODE_AVOID_DUPLICATE_VALUES_PER_KEY) <> 0 AND __QB_NODE(child).labelFormat = QB_NODE_FORMAT_STR THEN
        QB__childValue = QB_STR_get(__QB_NODE(child).value)
        IF (__QB_NODE(parent).flags AND QB_NODE_DUPLICATE_VALUES_CASE_SENSITIVE) = 0 THEN QB__childValue = LCASE$(QB__childValue)
    END IF

    IF QB__hashList = 0 OR QB__canReplace = 0 THEN
        IF QB__hashList = 0 THEN
            QB__hashList = QB_NODE_new(QB_NODE_TYPE_LIST, 0)
            __QB_NODE_hashLists(QB__hashValue) = QB__hashList
            __QB_NODE(QB__hashList).hashReference = QB__hashValue
        END IF
    ELSE
        DIM QB__this AS LONG
        DIM QB__i AS LONG
        DO WHILE QB_NODE_each(QB__this, QB__hashList, QB__i)
            IF __QB_NODE(QB__this).owner = parent THEN 'same owner
                IF __QB_NODE(QB__this).labelFormat = __QB_NODE(child).labelFormat THEN 'same label format
                    DIM QB__same AS LONG
                    QB__same = 0
                    IF __QB_NODE(child).labelFormat = QB_NODE_FORMAT_LONG THEN
                        IF __QB_NODE(QB__this).label = __QB_NODE(child).label THEN QB__same = 1
                    ELSE
                        IF QB_STR_get(__QB_NODE(QB__this).label) = QB__label THEN QB__same = 1
                    END IF
                    IF QB__same THEN 'same label
                        IF (__QB_NODE(parent).flags AND QB_NODE_ALLOW_DUPLICATE_KEYS) <> 0 THEN
                            IF (__QB_NODE(parent).flags AND QB_NODE_AVOID_DUPLICATE_VALUES_PER_KEY) <> 0 THEN
                                IF __QB_NODE(QB__this).valueFormat = __QB_NODE(child).valueFormat THEN 'same value format
                                    IF __QB_NODE(child).labelFormat = QB_NODE_FORMAT_LONG THEN
                                        IF __QB_NODE(child).value = __QB_NODE(QB__this).value THEN
                                            'optionally, destroy this child
                                            IF __QB_NODE(parent).flags AND QB_NODE_DESTROY_ORPHANED_CHILDNODES THEN
                                                QB_NODE_destroy child
                                            END IF
                                            EXIT SUB 'entry already exists
                                        END IF
                                    ELSE
                                        IF (__QB_NODE(parent).flags AND QB_NODE_DUPLICATE_VALUES_CASE_SENSITIVE) <> 0 THEN
                                            IF QB_STR_get(__QB_NODE(QB__this).value) = QB__childValue THEN
                                                'optionally, destroy this child
                                                IF __QB_NODE(parent).flags AND QB_NODE_DESTROY_ORPHANED_CHILDNODES THEN
                                                    QB_NODE_destroy child
                                                END IF
                                                EXIT SUB 'entry already exists
                                            END IF
                                        ELSE
                                            IF LCASE$(QB_STR_get(__QB_NODE(QB__this).value)) = QB__childValue THEN
                                                'optionally, destroy this child
                                                IF __QB_NODE(parent).flags AND QB_NODE_DESTROY_ORPHANED_CHILDNODES THEN
                                                    QB_NODE_destroy child
                                                END IF
                                                EXIT SUB 'entry already exists
                                            END IF
                                        END IF
                                    END IF
                                END IF
                            END IF
                        ELSE
                            'duplicate keys not allowed
                            __QB_NODE_append parent, child
                            'update existing reference to child
                            DIM QB__oldChild AS LONG
                            QB__oldChild = __QB_NODE(QB__this).value
                            __QB_NODE_detach QB__oldChild 'generic detach must be used (reference will be re-used)
                            'optionally, destroy old child
                            IF __QB_NODE(parent).flags AND QB_NODE_DESTROY_ORPHANED_CHILDNODES THEN
                                QB_NODE_destroy QB__oldChild
                            END IF
                            __QB_NODE(QB__this).value = child
                            __QB_NODE(child).hashReference = QB__this
                            EXIT SUB
                        END IF
                    END IF
                END IF
            END IF
        LOOP
    END IF
    'create new reference to child
    __QB_NODE_append parent, child
    DIM QB__ref AS LONG
    QB__ref = QB_NODE_new(QB_NODE_TYPE_VALUE, 0)
    IF __QB_NODE(child).labelFormat = QB_NODE_FORMAT_LONG THEN
        QB_NODE_setLabel_format QB__ref, __QB_NODE(child).label, QB_NODE_FORMAT_LONG
    ELSE
        QB_NODE_setLabel_format QB__ref, QB_STR_new(QB__label), QB_NODE_FORMAT_STR
    END IF
    QB_NODE_setValue_format QB__ref, child, QB_NODE_FORMAT_LONG
    __QB_NODE(QB__ref).owner = parent 'owner allows searching elimination of conflicting hash entries from other sets
    'add reference to list
    __QB_NODE_append QB__hashList, QB__ref
    __QB_NODE(child).hashReference = QB__ref
END IF 'dictionary








END SUB 'assign

SUB QB_NODE_detach (QB__handle AS LONG)
IF QB_DEBUG_VERBOSE THEN
    PRINT "QB_NODE_detach: Node"; QB__handle; "of type: " + QB_NODE_typeName(__QB_NODE(QB__handle).type)
END IF
$CHECKING:OFF
IF __QB_NODE_validateHandle(QB__handle, 0) = -1 THEN EXIT FUNCTION
$CHECKING:ON
DIM QB__parent AS LONG
DIM QB__ref AS LONG
DIM QB__ref_parent AS LONG
'dictionaries & hashsets require removal of their hash table reference link
QB__parent = __QB_NODE(QB__handle).parent
IF QB__parent THEN 'has parent
    IF __QB_NODE(QB__parent).type AND (QB_NODE_TYPE_HASHSET + QB_NODE_TYPE_DICTIONARY) THEN
        QB__ref = __QB_NODE(QB__handle).hashReference
        QB__ref_parent = __QB_NODE(QB__ref).parent
        IF __QB_NODE(QB__ref_parent).count = 1 THEN
            'last reference
            IF QB_DEBUG_VERBOSE THEN
                PRINT "QB_NODE_detach: Calling destroy on parent hashreference-list node"; QB__ref_parent; "of type: " + QB_NODE_typeName(__QB_NODE(QB__ref_parent).type) + " (no more entries)"
            END IF
            'clear the hash entry pointing to this list
            __QB_NODE_hashLists(__QB_NODE(QB__ref_parent).hashReference) = 0 'step 1 (must happen before step 2)
            __QB_NODE_destroy QB__ref_parent 'step 2
        ELSE
            __QB_NODE_destroy QB__ref
        END IF
        IF __QB_NODE(QB__parent).flags AND QB_NODE_DESTROY_ORPHANED_CHILDNODES THEN
            __QB_NODE_detach QB__handle 'perform generic detach
            __QB_NODE_destroy QB__handle
            EXIT FUNCTION
        END IF
        __QB_NODE_detach QB__handle 'perform generic detach
        EXIT FUNCTION
    END IF
END IF
__QB_NODE_detach QB__handle 'perform generic detach
END SUB

SUB QB_NODE_destroy (QB__handle AS LONG)
$CHECKING:OFF
IF __QB_NODE_validateHandle(QB__handle, 0) = -1 THEN EXIT FUNCTION
$CHECKING:ON
'destroy this node and all its children recursively
__QB_NODE_destroy QB__handle
END SUB

SUB __QB_NODE_destroy (QB__handle AS LONG)

IF QB_DEBUG_VERBOSE THEN
    PRINT "__QB_NODE_destroy: Will destroy node"; QB__handle; "of type: " + QB_NODE_typeName(__QB_NODE(QB__handle).type)
END IF

'when a collection is being destroyed, prevent QB_NODE_DESTROY_ORPHANED_CHILDNODES from firing a delete operation twice
IF __QB_NODE(QB__handle).flags AND QB_NODE_DESTROY_ORPHANED_CHILDNODES THEN
    __QB_NODE(QB__handle).flags = __QB_NODE(QB__handle).flags - QB_NODE_DESTROY_ORPHANED_CHILDNODES
END IF

'before any node can be destroyed it must be detached
QB_NODE_detach QB__handle
'destroy this node's children (if any)
DIM QB__child AS LONG
DIM QB__next AS LONG
QB__child = __QB_NODE(QB__handle).firstChild
DO WHILE QB__child
    QB__next = __QB_NODE(QB__child).next
    IF QB_DEBUG_VERBOSE THEN
        PRINT "__QB_NODE_destroy: Calling destroy on child node"; QB__child; "of type: " + QB_NODE_typeName(__QB_NODE(QB__child).type)
    END IF
    __QB_NODE_destroy QB__child
    QB__child = QB__next
LOOP
'destroy this object
IF QB_DEBUG_VERBOSE THEN
    PRINT "__QB_NODE_destroy: Destroying node"; QB__handle; "of type: " + QB_NODE_typeName(__QB_NODE(QB__handle).type)
END IF
$CHECKING:OFF
IF __QB_NODE_validateHandle(QB__handle, 0) = -1 THEN EXIT FUNCTION
$CHECKING:ON
__QB_NODE(QB__handle).valid = 0
'cleanup string references
IF __QB_NODE(QB__handle).valueFormat = QB_NODE_FORMAT_STR THEN
    QB_STR_free __QB_NODE(QB__handle).value
END IF
IF __QB_NODE(QB__handle).labelFormat = QB_NODE_FORMAT_STR THEN
    QB_STR_free __QB_NODE(QB__handle).label
END IF
QB_HANDLE_free QB__handle, __QB_NODE_handleSet
END SUB

FUNCTION __QB_NODE_new& (nodeType AS LONG)
IF QB_DEBUG_VERBOSE THEN PRINT "__QB_NODE_new()"
DIM QB__handle AS LONG
QB__handle = QB_HANDLE_new(__QB_NODE_handleSet)
IF QB__handle > __QB_NODE_ubound THEN
    __QB_NODE_ubound = QB__handle * 2
    REDIM _PRESERVE __QB_NODE(__QB_NODE_ubound) AS QB_NODE_TYPE
END IF
__QB_NODE(QB__handle) = QB_NODE_TYPE_EMPTY
__QB_NODE(QB__handle).valid = 1
__QB_NODE(QB__handle).type = nodeType
IF QB_DEBUG_VERBOSE THEN PRINT "Created node type"; nodeType
__QB_NODE_new& = QB__handle
END FUNCTION

SUB __QB_NODE_append (parent AS LONG, child AS LONG)
'generic append to end of parent list
'assumes child is detached
__QB_NODE(child).parent = parent
IF __QB_NODE(parent).firstChild = 0 THEN
    'is first entry in list
    __QB_NODE(parent).count = 1
    __QB_NODE(parent).firstChild = child
    __QB_NODE(parent).lastChild = child
ELSE
    'add to existing list
    DIM QB__i AS LONG
    QB__i = __QB_NODE(parent).lastChild
    __QB_NODE(parent).count = __QB_NODE(parent).count + 1
    __QB_NODE(parent).lastChild = child
    __QB_NODE(QB__i).next = child
    __QB_NODE(child).prev = QB__i
END IF
END SUB

FUNCTION __QB_NODE_hashLong (value AS LONG, baseOffset AS LONG)
__QB_NODE_hashLong = (value + baseOffset) AND &HFFFFFF~&
END FUNCTION

FUNCTION __QB_NODE_hashStr (value AS STRING, baseOffset AS LONG)
DIM QB__keyNameLen AS LONG
DIM QB__i AS LONG
DIM QB__hashValue AS LONG
QB__keyNameLen = LEN(value)
QB__i = 1
DO WHILE QB__i <= QB__keyNameLen
    QB__hashValue = QB__hashValue + ASC(value, QB__i) * QB__i * 15
    QB__i = QB__i + 1
LOOP
__QB_NODE_hashStr = (QB__hashValue + baseOffset) AND &HFFFFFF~&
END FUNCTION

FUNCTION __QB_NODE_validateHandle (handle AS LONG, optionalRequiredType AS LONG)
$CHECKING:OFF
IF handle > __QB_NODE_ubound OR handle <= 0 THEN ERROR 258: EXIT FUNCTION 'invalid handle
IF __QB_NODE(handle).valid = 0 THEN ERROR 258: EXIT FUNCTION
IF optionalRequiredType <> 0 THEN
    IF (optionalRequiredType AND __QB_NODE(handle).type) = 0 THEN
        ERROR 258
        __QB_NODE_validateHandle = -1
        EXIT FUNCTION
    END IF
END IF
$CHECKING:ON
END FUNCTION

SUB __QB_NODE_detach (handle AS LONG)
IF QB_DEBUG_VERBOSE THEN
    PRINT "__QB_NODE_detach: Node"; handle; "of type: " + QB_NODE_typeName(__QB_NODE(handle).type)
END IF
'generic detach method (regardless of parent type)
DIM QB__i
QB__i = __QB_NODE(handle).next
IF QB__i THEN
    __QB_NODE(QB__i).prev = __QB_NODE(handle).prev
END IF
QB__i = __QB_NODE(handle).prev
IF QB__i THEN
    __QB_NODE(QB__i).next = __QB_NODE(handle).next
END IF
QB__i = __QB_NODE(handle).parent
IF QB__i THEN
    IF __QB_NODE(QB__i).firstChild = handle THEN __QB_NODE(QB__i).firstChild = __QB_NODE(handle).next
    IF __QB_NODE(QB__i).lastChild = handle THEN __QB_NODE(QB__i).lastChild = __QB_NODE(handle).prev
    __QB_NODE(QB__i).count = __QB_NODE(QB__i).count - 1
    __QB_NODE(handle).parent = 0
END IF
__QB_NODE(handle).next = 0
__QB_NODE(handle).prev = 0
__QB_NODE(handle).hashReference = 0
END SUB

'##################################################



SUB __QB_NODESET_addChildren (QB__parent AS LONG, QB__selOut AS LONG)
DIM QB__child AS LONG
DIM QB__newSel AS LONG
QB__child = __QB_NODE(QB__parent).firstChild
DO WHILE QB__child
    QB__newSel = QB_NODE_newLabel_long(QB__child)
    QB_NODE_assign QB__selOut, QB__newSel
    IF __QB_NODE(QB__child).firstChild THEN __QB_NODESET_addChildren QB__child, QB__selOut
    QB__child = __QB_NODE(QB__child).next
LOOP
END SUB

SUB __QB_NODESET_addChildrenWithDepth (QB__parent AS LONG, QB__selOut AS LONG, currentDepth AS LONG, minDepth AS LONG, maxDepth AS LONG)
DIM QB__child AS LONG
DIM QB__newSel AS LONG
QB__child = __QB_NODE(QB__parent).firstChild
DO WHILE QB__child
    IF currentDepth >= minDepth THEN
        QB__newSel = QB_NODE_newLabel_long(QB__child)
        QB_NODE_assign QB__selOut, QB__newSel
    END IF
    IF currentDepth < maxDepth THEN
        IF __QB_NODE(QB__child).firstChild THEN
            __QB_NODESET_addChildrenWithDepth QB__child, QB__selOut, currentDepth + 1, minDepth, maxDepth
        END IF
    END IF
    QB__child = __QB_NODE(QB__child).next
LOOP
END SUB



SUB __QB_NODE_debugInfo (QB__i AS LONG)
PRINT "-------- __QB_NODE_debugInfo:"; QB__i; "--------"
'type
DIM QB__type AS LONG
QB__type = __QB_NODE(QB__i).type
PRINT "TYPE: " + QB_NODE_typeName(QB__type)
'label
IF __QB_NODE(QB__i).labelFormat = QB_NODE_FORMAT_STR THEN
    PRINT "LABEL: " + QB_STR_get(__QB_NODE(QB__i).label)
END IF
'value
IF __QB_NODE(QB__i).valueFormat = QB_NODE_FORMAT_STR THEN
    PRINT "VALUE: " + QB_STR_get(__QB_NODE(QB__i).value)
END IF
IF __QB_NODE(QB__i).parent THEN
    PRINT "Has parent of type " + QB_NODE_typeName(__QB_NODE(__QB_NODE(QB__i).parent).type) + " ["; __QB_NODE(QB__i).parent; "]"
ELSE
    PRINT "This is a root element"
END IF
IF __QB_NODE(QB__i).firstChild THEN
    PRINT "Has child of type " + QB_NODE_typeName(__QB_NODE(__QB_NODE(QB__i).firstChild).type) + " ["; __QB_NODE(QB__i).firstChild; "]"
END IF
IF __QB_NODE(QB__i).next THEN
    PRINT "Has next sibling of type " + QB_NODE_typeName(__QB_NODE(__QB_NODE(QB__i).next).type) + " ["; __QB_NODE(QB__i).next; "]"
END IF
IF __QB_NODE(QB__i).prev THEN
    PRINT "Has previous sibling of type " + QB_NODE_typeName(__QB_NODE(__QB_NODE(QB__i).prev).type) + " ["; __QB_NODE(QB__i).prev; "]"
END IF
PRINT "----------------"
END SUB

'##################################################


'#################### JSON: Private Methods ####################

FUNCTION __QB_JSON_unescape$ (QB__in AS STRING, QB__detectedFormat AS LONG, QB__detectedFormatValue AS LONG)
'-unescapes string
'-strips paired single or double quotes
'-detects data type (string, number, bool, null)
'-very permissive
QB__detectedFormat = 0
QB__detectedFormatValue = 0
DIM QB__out AS STRING
DIM QB__i1 AS LONG
DIM QB__i2 AS LONG
DIM QB__i3 AS LONG
DIM QB__in_len AS LONG
DIM QB__a AS LONG
DIM QB__a2 AS LONG
DIM QB__hex AS STRING
DIM QB__hex_len AS LONG
DIM QB__quoted AS LONG
QB__in_len = LEN(QB__in)
QB__out = SPACE$(QB__in_len) 'output is never longer than input
QB__i1 = 1
QB__i2 = 0
QB__i = 0
'trim
QB__in = LTRIM$(RTRIM$(QB__in))
QB__in_len = LEN(QB__in)
'strip quotes
IF ASC(QB__in) = 34 OR ASC(QB__in) = 39 THEN
    IF ASC(QB__in, QB__in_len) = ASC(QB__in) AND QB__in_len > 1 THEN
        QB__quoted = ASC(QB__in)
        QB__detectedFormat = QB_NODE_FORMAT_STR
        QB__in_len = QB__in_len - 2
        QB__in = MID$(QB__in, 2, QB__in_len)
    END IF
END IF
'detect type if not quoted
IF QB__quoted = 0 THEN
    IF QB__in_len = 4 THEN
        IF LCASE$(QB__in) = "true" THEN QB__in = "true": QB__detectedFormat = QB_NODE_FORMAT_BOOL: QB__detectedFormatValue = QB_TRUE
        IF LCASE$(QB__in) = "null" THEN QB__in = "null": QB__detectedFormat = QB_NODE_FORMAT_NULL: QB__detectedFormatValue = QB_NULL
    END IF
    IF QB__in_len = 5 THEN
        IF LCASE$(QB__in) = "false" THEN QB__in = "false": QB__detectedFormat = QB_NODE_FORMAT_BOOL: QB__detectedFormatValue = QB_FALSE
    END IF
    IF QB__detectedFormat = 0 THEN
        QB__a = ASC(QB__in)
        IF QB__a >= 48 AND QB__a <= 57 THEN '0-9
            IF INSTR(QB__in, ".") = 0 THEN
                QB__detectedFormat = QB_NODE_FORMAT_LONG: QB__detectedFormatValue = VAL(QB__in)
            END IF
        ELSE
            IF QB__a = 45 THEN '-
                IF INSTR(QB__in, ".") = 0 THEN
                    QB__detectedFormat = QB_NODE_FORMAT_LONG: QB__detectedFormatValue = VAL(QB__in)
                END IF
            END IF
            IF QB__a = 46 THEN '.
                'TODO: decimal support
            END IF
        END IF
        IF QB__detectedFormat = 0 THEN QB__detectedFormat = QB_NODE_FORMAT_STR
    END IF
END IF
'if a string, parse to convert escaped content
IF QB__detectedFormat = QB_NODE_FORMAT_STR THEN
    DO WHILE QB__i1 <= QB__in_len
        QB__a = ASC(QB__in, QB__i1)
        IF QB__a <> 92 OR QB__i1 = QB__in_len THEN 'not \ or at end
            QB__i2 = QB__i2 + 1: ASC(QB__out, QB__i2) = QB__a
        ELSE
            QB__i1 = QB__i1 + 1: QB__a = ASC(QB__in, QB__i1)
            QB__a2 = __QB_JSON_escape_lookup_reversed(QB__a)
            IF QB__a2 THEN
                QB__i2 = QB__i2 + 1: ASC(QB__out, QB__i2) = QB__a2
            ELSE
                IF QB__a = 117 OR QB__a = 85 AND QB__i1 + 4 <= QB__in_len THEN 'u or U
                    QB__a2 = VAL("&H" + MID$(QB__in, QB__i1 + 1, 4) + "~&") 'unicode code point
                    QB__i1 = QB__i1 + 4
                    QB__a = 0
                    IF QB__a2 = 0 THEN
                        QB__i2 = QB__i2 + 1: ASC(QB__out, QB__i2) = 0
                    ELSE
                        'todo: replace with dictionary lookup
                        FOR QB__i3 = 1 TO 255
                            IF QB__a2 = _MAPUNICODE(QB__i3) THEN
                                QB__a = QB__i3
                                QB__i2 = QB__i2 + 1: ASC(QB__out, QB__i2) = QB__a
                                EXIT FOR
                            END IF
                        NEXT
                        IF QB__i3 = 256 THEN 'could not locate a match for the character, show a question mark
                            QB__i2 = QB__i2 + 1: ASC(QB__out, QB__i2) = 63 '?
                        END IF
                    END IF
                ELSE
                    'unknown \??? combination (add as is)
                    QB__i2 = QB__i2 + 1: ASC(QB__out, QB__i2) = 92 '\
                    QB__i2 = QB__i2 + 1: ASC(QB__out, QB__i2) = QB__a '2nd character
                END IF
            END IF
        END IF
        QB__i1 = QB__i1 + 1
    LOOP
    __QB_JSON_unescape$ = LEFT$(QB__out, QB__i2)
ELSE
    __QB_JSON_unescape$ = QB__in
END IF
END FUNCTION

FUNCTION __QB_JSON_escape$ (QB__in AS STRING)
DIM QB__out AS STRING
DIM QB__i1 AS LONG
DIM QB__i2 AS LONG
DIM QB__in_len AS LONG
DIM QB__a AS LONG
DIM QB__a2 AS LONG
DIM QB__hex AS STRING
DIM QB__hex_len AS LONG
QB__in_len = LEN(QB__in)
QB__out = SPACE$(QB__in_len * 6) 'worst possible case is double size (\uXXXX)
QB__i1 = 1
QB__i2 = 0
QB__i = 0
DO WHILE QB__i1 <= QB__in_len
    QB__a = ASC(QB__in, QB__i1)
    IF QB__a <> 92 AND QB__a <> 34 AND (QB__a >= 32 AND QB__a <= 126) THEN 'not \ or " and valid standard ASCII
        QB__i2 = QB__i2 + 1: ASC(QB__out, QB__i2) = QB__a
    ELSE
        QB__i2 = QB__i2 + 1: ASC(QB__out, QB__i2) = 92 '\
        QB__a2 = __QB_JSON_escape_lookup(QB__a)
        IF QB__a2 THEN
            QB__i2 = QB__i2 + 1: ASC(QB__out, QB__i2) = QB__a2
        ELSE
            QB__i2 = QB__i2 + 1: ASC(QB__out, QB__i2) = 117 'u
            IF QB__a = 0 THEN
                QB__hex = "0"
            ELSE
                QB__hex = HEX$(_MAPUNICODE(QB__a))
            END IF
            QB__hex_len = LEN(QB__hex)
            QB__a2 = 48
            FOR QB__i = 1 TO 4
                IF 5 - QB__i <= QB__hex_len THEN
                    QB__a2 = ASC(QB__hex, QB__i - (4 - QB__hex_len))
                END IF
                QB__i2 = QB__i2 + 1: ASC(QB__out, QB__i2) = QB__a2
            NEXT
        END IF
    END IF
    QB__i1 = QB__i1 + 1
LOOP
__QB_JSON_escape$ = LEFT$(QB__out, QB__i2)
END FUNCTION

FUNCTION __QB_JSON_output_string$ (QB__in AS STRING)
__QB_JSON_output_string$ = QB_STR_QUOTE + __QB_JSON_escape$(QB__in) + QB_STR_QUOTE
END FUNCTION

SUB __QB_JSON_serialize (json AS STRING, first AS LONG, addSiblings AS LONG)
DIM QB__i AS LONG
QB__i = first
DO WHILE QB__i
    IF QB__i <> first THEN
        json = json + ","
    END IF
    IF __QB_NODE(QB__i).type = QB_NODE_TYPE_DICTIONARY THEN
        IF __QB_NODE(QB__i).labelFormat = QB_NODE_FORMAT_STR THEN
            json = json + __QB_JSON_output_string(QB_STR_get(__QB_NODE(QB__i).label)) + ":"
        END IF
        json = json + "{"
        __QB_JSON_serialize json, __QB_NODE(QB__i).firstChild, 1
        json = json + "}"
    END IF
    IF __QB_NODE(QB__i).type = QB_NODE_TYPE_LIST THEN
        IF __QB_NODE(QB__i).labelFormat = QB_NODE_FORMAT_STR THEN
            json = json + __QB_JSON_output_string(QB_STR_get(__QB_NODE(QB__i).label)) + ":"
        END IF
        json = json + "["
        __QB_JSON_serialize json, __QB_NODE(QB__i).firstChild, 1
        json = json + "]"
    END IF
    IF __QB_NODE(QB__i).type = QB_NODE_TYPE_VALUE THEN
        IF __QB_NODE(QB__i).labelFormat = QB_NODE_FORMAT_STR THEN
            json = json + __QB_JSON_output_string(QB_STR_get(__QB_NODE(QB__i).label)) + ":"
        END IF
        IF __QB_NODE(QB__i).valueFormat <> QB_NODE_FORMAT_STR THEN
            json = json + QB_NODE_value(QB__i)
        ELSE
            json = json + __QB_JSON_output_string(QB_NODE_value(QB__i))
        END IF
    END IF
    IF addSiblings THEN
        QB__i = __QB_NODE(QB__i).next
    ELSE
        QB__i = 0
    END IF
LOOP
END SUB


FUNCTION __QB_JSON_deserialize (QB__json AS STRING, QB__index AS LONG, QB__parent AS LONG)
'returns the first node created

DIM QB__firstNodeCreated AS LONG
DIM QB__ignore AS LONG

DIM QB__index1 AS LONG
QB__index1 = QB__index

DIM QB__asc AS LONG
DIM QB__labelIndex AS LONG
DIM QB__label AS STRING
DIM QB__value AS STRING
DIM QB__obj AS LONG
DIM QB__objAdded AS LONG
DIM QB__final AS LONG
DIM QB__detectedFormat AS LONG
DIM QB__detectedFormatValue AS LONG
DIM QB__contentExists AS LONG
DO WHILE QB__index <= LEN(QB__json) + 1
    IF QB__index = LEN(QB__json) + 1 THEN
        QB__final = 1
        QB__asc = 32 'whitespace
    ELSE
        QB__asc = ASC(QB__json, QB__index)
    END IF

    IF QB__asc = 44 OR QB__asc = 125 OR QB__asc = 93 OR QB__final <> 0 THEN ', } ] final
        IF QB__objAdded = 0 AND QB__contentExists <> 0 THEN
            QB__value = MID$(QB__json, QB__index1, (QB__index - QB__index1))
            'TODO: derive value format here
            QB__obj = QB_NODE_new(QB_NODE_TYPE_VALUE, 0)
            IF QB__firstNodeCreated = 0 THEN QB__firstNodeCreated = QB__obj
            IF QB__label <> "" THEN
                QB_NODE_setLabel QB__obj, __QB_JSON_unescape$(QB__label, 0, 0)
                QB__label = ""
            END IF
            QB__value = __QB_JSON_unescape$(QB__value, QB__detectedFormat, QB__detectedFormatValue)
            IF QB__detectedFormat = QB_NODE_FORMAT_STR THEN
                QB_NODE_setValue_format QB__obj, QB_STR_new(QB__value), QB__detectedFormat
            ELSE
                QB_NODE_setValue_format QB__obj, QB__detectedFormatValue, QB__detectedFormat
            END IF
            IF QB__parent <> 0 THEN QB_NODE_assign QB__parent, QB__obj
        END IF
        'end of block encountered?
        IF QB__asc = 125 OR QB__asc = 93 OR QB__final <> 0 THEN '} ] final
            __QB_JSON_deserialize = QB__firstNodeCreated
            EXIT FUNCTION
        END IF
        QB__index1 = QB__index + 1
        QB__objAdded = 0
        QB__contentExists = 0
    END IF

    IF QB__asc <> 44 AND QB__asc <> 32 AND QB__asc <> 9 THEN QB__contentExists = 1

    IF QB__asc = 58 THEN ':
        IF LEN(QB__label) THEN
            'already has label
            PRINT "Invalid label separator encountered ':'"
            END
        END IF
        QB__label = MID$(QB__json, QB__index1, (QB__index - QB__index1))
        QB__index1 = QB__index + 1 'move start location
        QB__contentExists = 0
    END IF

    IF QB__asc = 123 THEN '{
        IF QB__objAdded <> 0 THEN
            PRINT "Expected ,"
            END
        END IF
        QB__obj = QB_NODE_newDictionary
        IF QB__firstNodeCreated = 0 THEN QB__firstNodeCreated = QB__obj
        IF QB__label <> "" THEN
            QB_NODE_setLabel QB__obj, __QB_JSON_unescape$(QB__label, 0, 0)
            QB__label = ""
        END IF
        QB__index = QB__index + 1
        QB__ignore = __QB_JSON_deserialize(QB__json, QB__index, QB__obj)
        IF ASC(QB__json, QB__index) <> 125 THEN '}
            PRINT "Expected }"
            END
        END IF
        IF QB__parent <> 0 THEN QB_NODE_assign QB__parent, QB__obj
        QB__objAdded = 1
        QB__contentExists = 0
    END IF

    IF QB__asc = 91 THEN '[
        IF QB__objAdded <> 0 THEN
            PRINT "Expected ,"
        END IF
        QB__obj = QB_NODE_newList
        IF QB__firstNodeCreated = 0 THEN QB__firstNodeCreated = QB__obj
        IF QB__label <> "" THEN
            QB_NODE_setLabel QB__obj, __QB_JSON_unescape$(QB__label, 0, 0)
            QB__label = ""
        END IF
        QB__index = QB__index + 1
        QB__ignore = __QB_JSON_deserialize(QB__json, QB__index, QB__obj)
        IF ASC(QB__json, QB__index) <> 93 THEN ']
            PRINT "Expected ]"
            END
        END IF
        IF QB__parent <> 0 THEN QB_NODE_assign QB__parent, QB__obj
        QB__objAdded = 1
        QB__contentExists = 0
    END IF

    QB__index = QB__index + 1
LOOP
PRINT "Unexpected end of loop encountered"
END

END FUNCTION

'##################################################

'#################### DATETIME: Private Methods ####################

FUNCTION __QB_DATETIME_format_smartCase$ (format AS STRING, value AS STRING)
DIM QB__type AS LONG
DIM QB__a AS LONG
DIM QB__a2 AS LONG
QB__a = ASC(format, 2)
QB__a2 = ASC(format, 3)
IF QB__a >= 65 AND QB__a <= 90 THEN
    IF QB__a2 >= 65 AND QB__a2 <= 90 THEN
        value = UCASE$(value)
    ELSE
        value = UCASE$(LEFT$(value, 1)) + LCASE$(MID$(value, 2))
    END IF
ELSE
    value = LCASE$(value)
END IF
__QB_DATETIME_format_smartCase$ = value
END FUNCTION

'##################################################