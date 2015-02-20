
DECLARE SUB CentrarTexto (t$, y%)


ini:
CLS
COLOR 9
CentrarTexto "L.M.S Calculadora", 3
COLOR 15, 1
CentrarTexto " 1. Sumar      ", 5
CentrarTexto " 2. Restar     ", 6
CentrarTexto " 3. Dividir    ", 7
CentrarTexto " 4. Multiplicar", 8
CentrarTexto " 5. Salir      ", 9

COLOR 4, 0
LOCATE 11, 32
INPUT "Numero de opci¢n:", opci

SELECT CASE opci
CASE 1
CASE 2
CASE 3
CASE 4
CASE 5
END
CASE ELSE
GOTO ini
END SELECT


CLS
COLOR 15
INPUT "Numero 1: ", num1
INPUT "Numero 2: ", num2

SELECT CASE opci
CASE 1
resultado = num1 + num2
CASE 2
resultado = num1 - num2
CASE 3
resultado = num1 / num2
CASE 4
resultado = num1 * num2
CASE 5
END
CASE ELSE
GOTO ini
END SELECT


COLOR 10
PRINT
PRINT "Resultado = ", resultado
DO WHILE INKEY$ = ""
LOOP
GOTO ini

SUB CentrarTexto (t$, y%)
xnum% = (80 - LEN(t$)) / 2
xspc% = INT((80 - LEN(t$)) / 2)
IF y% = 0 THEN PRINT TAB(xspc%); t$: EXIT SUB
LOCATE y%, xnum%: PRINT t$
'

END SUB

