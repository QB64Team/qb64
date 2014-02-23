
DECLARE SUB CentrarTexto (t$, y%)


menu:
COLOR 10, 0
CLS
CentrarTexto "€€€€€€ª           €€€€€€€ª €€ª €€ª", 2
CentrarTexto "€€…ÕÕ€€ª €€ª  €€ª €€…ÕÕÕÕº €€∫ €€∫", 3
CentrarTexto "€€€€€€…º €€∫  €€∫ €€€€€€€ª €€€€€€∫", 4
CentrarTexto "€€…ÕÕ€€ª €€∫  €€∫ »ÕÕÕÕ€€∫ €€… €€∫", 5
CentrarTexto "€€€€€€…º €€€€€€€∫ €€€€€€€∫ €€∫ €€∫", 6
CentrarTexto "»ÕÕÕÕÕº  »ÕÕÕÕÕÕº »ÕÕÕÕÕÕº »Õº »Õº", 7
COLOR 30
CentrarTexto "BOMBER - BOMBER - BOMBER - BOMBER", 8
COLOR 9
CentrarTexto "Ayuda a Bush en su mision de matar inocentes por el mundo!", 10
CentrarTexto "Pero ten cuidado! La gente cada vez corre mas rapido...", 11
CentrarTexto "Y tu helicoptero tambien!", 12

CentrarTexto "La unica tecla necesaria es Arriba (para dejar bombas).", 13
CentrarTexto "Este programa esta hecho 100% en Qbasic, y es un poco aburrido...", 14

COLOR 15
PLAY "o2 l16 df+af+df+af+df+af+df+af+eac+aeac+aeac+aeac+adf+bf+df+bf+df+bf+df+bf+d-f+ap16 d-f+ap16 d-f+ap16 d-f+aa"
CentrarTexto "(Presione cualquier tecla para continuar, ESC para salir)", 20

DO WHILE INKEY$ = ""
SELECT CASE INKEY$
CASE CHR$(27)
END
END SELECT
LOOP

RANDOMIZE TIMER
CLS
bombas = 50
ac = 16000
columna = 1
linea = 3
lineaa = 3
x = 0
mn = 30
op = 4
dd = 1
we = 0

DO

IF dd = 1 THEN
COLOR 31
CentrarTexto "Afghanistan", 10
END IF

IF dd = 2 THEN
COLOR 31
CentrarTexto "Irak", 10
END IF

IF dd = 3 THEN
COLOR 31
CentrarTexto "Iran", 10
END IF

IF dd = 4 THEN
COLOR 31
CentrarTexto "Arabia Saudita", 10
END IF

IF dd = 5 THEN
COLOR 31
CentrarTexto "Venezuela", 10
END IF

IF dd = 6 THEN
COLOR 31
CentrarTexto "Colombia", 10
END IF

IF dd = 7 THEN
COLOR 31
CentrarTexto "Brasil", 10
END IF

IF dd = 8 THEN
COLOR 31
CentrarTexto "Cuba", 10
END IF

IF dd = 9 THEN
COLOR 31
CentrarTexto "Uruguay", 10
END IF

IF dd = 10 THEN
COLOR 31
CentrarTexto "India", 10
END IF

IF dd = 11 THEN
COLOR 31
CentrarTexto "Libia", 10
END IF

IF dd = 12 THEN
COLOR 31
CentrarTexto "Sudafrica", 10
END IF

IF dd = 13 THEN
COLOR 31
CentrarTexto "Alemania", 10
END IF

IF dd = 14 THEN
COLOR 31
CentrarTexto "Japon", 10
END IF

IF dd = 15 THEN
COLOR 31
CentrarTexto "Rusia", 10
END IF


IF bombas = 0 THEN
COLOR 4
CentrarTexto "Sin municiones!", 12
op = op - 1
bombas = 50
DO WHILE INKEY$ = ""
LOOP
END IF

COLOR 12
LOCATE 1, 1
PRINT "Nivel: "
LOCATE 1, 8
PRINT dd

IF op = 0 THEN
COLOR 2, 0
CLS
CentrarTexto "Perdiste!", 12
DO WHILE INKEY$ = ""
LOOP
SLEEP
GOTO menu
END IF

LOCATE 1, 30
COLOR 9
PRINT "Oportunidades:"
LOCATE 1, 45
PRINT op

LOCATE 1, 60
COLOR 10
PRINT "Bombas:"
LOCATE 1, 69
PRINT bombas

IF we = 15 THEN
COLOR 30
CentrarTexto "Ultimo Nivel!", 12
END IF

IF we = 16 THEN
COLOR 4, 0
CLS
COLOR 15
CentrarTexto "»=XO", 10
COLOR 4
CentrarTexto "*", 14
COLOR 10
LOCATE 23, 45
PRINT ""
LOCATE 23, 46
PRINT ""
LOCATE 23, 33
PRINT ""
LOCATE 23, 34
PRINT ""
COLOR 9
CentrarTexto "…ÕÕÕÕÕÕª", 16
CentrarTexto "∫Õ˛Õ˛Õ˛∫", 17
CentrarTexto "∫˛Õ˛Õ˛Õ∫", 18
CentrarTexto "∫Õ˛Õ˛Õ˛∫", 19
CentrarTexto "∫˛Õ˛Õ˛Õ∫", 20
CentrarTexto "∫Õ˛Õ˛Õ˛∫", 21
CentrarTexto "∫˛Õ˛Õ˛Õ∫", 22
CentrarTexto "∫Õ˛Õ€Õ˛∫", 23
COLOR 28
CentrarTexto "Congratulations!", 1
COLOR 2
CentrarTexto "Lo has hecho, ahora todo el petroleo del mundo es de Bush!", 3
CentrarTexto "Los Bush vuelven a ganar... Pero no se si felicitarte", 4
CentrarTexto "por matar gente... Que deberia hacer?", 5
CentrarTexto "Ganaste! GRACIAS POR JUGAR!", 6
PLAY "T120 O2 L4"
PLAY "F8 D8 <B- >D F B-2 >D8 C8 <B- D E F2 F8 F8 >D. C8 <B-"
PLAY "A2 G8 A8 B- B- F D <B- >F8 D8 <B- >D F B-2 >D8 C8"
PLAY "<B- D E F2 F8 F8 >D. C8 <B- A2 G8 A8 B- B- F D <B-"
PLAY ">>D8 D8 D D E- F2. E-8 D8 C C D E-2 E- D2 C8 <B-8"
PLAY "A2 G8 A8 B- D E F2 F B- B- B-8 A8 G G G"
PLAY ">C E-8 D8 C8 <B-8 B- A2 P4"
PLAY "F8 F8 B-. >C8 D8 E-8 F2 <B-8 >C8 D. E-8 C <B-2"

GOTO menu
END IF

IF m = 1 THEN
lineaa = lineaa + 1


IF lineaa = 23 THEN
IF tipitoc = mn THEN
COLOR 9
CentrarTexto "                                    ", 10
COLOR 4
CentrarTexto "Le diste!", 10
PLAY "o3 l15 cc < b > cc < b > cc < b > cc < b > c < b > c < bffeffeffeffefefg"
dd = dd + 1
we = we + 1
bombas = 50
END IF

IF tipitoc = sd THEN
we = we + 1
dd = dd + 1
ac = ac - 1000
COLOR 9
CentrarTexto "                                    ", 10
COLOR 4
CentrarTexto "Le diste!", 10
bombas = 50
PLAY "o3 l15 cc < b > cc < b > cc < b > cc < b > c < b > c < bffeffeffeffefefg"
END IF

IF tipitoc = fd THEN
COLOR 4
ac = ac - 1000
COLOR 9
CentrarTexto "                                    ", 10
COLOR 4
CentrarTexto "Le diste!", 10
dd = dd + 1
we = we + 1
PLAY "o3 l15 cc < b > cc < b > cc < b > cc < b > c < b > c < bffeffeffeffefefg"
bombas = 50
END IF


m = 2
lineaa = 2
END IF

LOCATE lineaa, tipitoc
COLOR 4
PRINT "*"
END IF

COLOR 15, 9
columna = columna + 1
IF columna = 78 THEN
columna = 1
END IF
LOCATE linea, columna
PRINT "»=XO"
BEEP

FOR i = 1 TO ac
NEXT i

CLS
vuelta:

IF we = 1 THEN
we = 2
END IF

IF x = 1 THEN
COLOR x
LOCATE 23, z
PRINT ""
LOCATE 23, zy
PRINT ""
LOCATE 23, zu
PRINT ""
LOCATE 23, zi
PRINT ""
LOCATE 23, zo
PRINT ""
END IF

SELECT CASE INKEY$
CASE CHR$(0) + CHR$(72)
tipitoc = columna
m = 1
bombas = bombas - 1
CASE CHR$(27)
END
END SELECT


RANDOMIZE TIMER
h = INT(RND * 2) + 1
sd = mn + 1
fd = mn + 2

IF h = 1 THEN
mn = mn + 1
sd = sd + 1
fd = fd + 1
END IF
IF h = 2 THEN
mn = mn - 1
END IF

IF mn = 0 THEN
mn = mn + 1
END IF

COLOR we
LOCATE 23, mn
PRINT ""

IF mn = 0 THEN
mn = mn + 1
END IF

IF mn = 70 THEN
mn = mn - 1
END IF

LOOP

SUB CentrarTexto (t$, y%)
xnum% = (80 - LEN(t$)) / 2
xspc% = INT((80 - LEN(t$)) / 2)
IF y% = 0 THEN PRINT TAB(xspc%); t$: EXIT SUB
LOCATE y%, xnum%: PRINT t$
'

END SUB

