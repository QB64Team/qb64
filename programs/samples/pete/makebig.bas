'MakeBig.bas:
'This program reads data statements and uses pset to draw the
'pixel color they represent.This is familiar to a few people
'but I altered it to make the image twice as large as it is normaly
CLS : SCREEN 12
DATA 00,00,00,14,14,14,14,00,00,00
DATA 00,14,14,14,14,14,14,14,14,00
DATA 00,14,00,00,14,14,00,00,14,00
DATA 14,14,00,00,14,14,00,00,14,14
DATA 14,14,00,00,14,14,00,00,14,14
DATA 14,00,14,14,14,14,14,14,00,14
DATA 14,00,00,14,14,14,14,00,00,14
DATA 00,14,00,00,00,00,00,00,14,00
DATA 00,14,14,00,00,00,00,14,14,00
DATA 00,00,00,14,14,14,14,00,00,00
FOR y = 1 TO 20 STEP 2
        FOR x = 1 TO 20 STEP 2
                READ z
                PSET (x, y), z
                PSET (x + 1, y), z
                PSET (x, y + 1), z
                PSET (x + 1, y + 1), z
        NEXT
NEXT
DIM g%(200)
GET (0, 0)-(20, 20), g%
LOCATE 1, 5
INPUT "File: "; file$
IF file$ = "" THEN END
OPEN file$ FOR BINARY AS #1
FOR I = 0 TO 200
        PUT #1, , g%(I)
NEXT
CLOSE #1