CLS
'Start of Declarations
DIM num AS INTEGER
DIM code AS STRING
DIM code1 AS INTEGER
DIM num1 AS STRING
'End of Declarations

start:

PRINT "ASCII code ----> ASCII Character & ASCII Character ----> ASCII Code Converter"
PRINT
PRINT "1) ASCII code ----> ASCII Character"
PRINT
PRINT "2) ASCII Character ----> ASCII code"
PRINT
INPUT "Enter your choice"; selection

SELECT CASE selection

   CASE 1
   CLS
   PRINT "ASCII code ----> ASCII Character"
   PRINT
   INPUT "Enter ASCII code"; num
   PRINT
   code = CHR$(num)
   PRINT "The ASCII Character is:"; code

   CASE 2
   CLS
   PRINT "ASCII Character ----> ASCII Code Converter"
   PRINT
   INPUT "Enter ASCII Character"; num1
   PRINT
   code1 = ASC(num1)
   PRINT "The ASCII Code is:"; code1

CASE ELSE

PRINT "Invalid Selection"
GOTO start
END SELECT

