REM This is a program that converts Fahrenheit temperatures to Celsius
REM temperatures.

CONST SHIFT# = 32#
CONST SCALE = 1.8#
CONST TFChar = "F "
CONST TCchar = "C "

DIM TF AS DOUBLE
DIM TC AS DOUBLE
CLS
INPUT "Enter the temperature in Fahrenheit "; TF
TC = (TF - SHIFT) / SCALE
PRINT TF; TFChar; "="; TC; TCchar
END

