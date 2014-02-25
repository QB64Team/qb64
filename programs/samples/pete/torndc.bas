'
'                               FGR SOFTWARE
'                                Torneo NDC
'
'=============================================================================
'Torneo NDC:
'Este juego intenta ser un juego al estilo galaxian, solo que muy pobre...
'Tiene 14 o 15 niveles, y es casi siemprelo mismo, solo que cambia el color
'de las naves enemigas (X), la dificultad, y se van acumulando las vidas y
'los puntajes...
'Las teclas son: A (para movernos a la izquierda)
'=============== S (para la derecha)
'                X (para disparar).
'
'=============================================================================
'
'Ya se que los comandos son un poco malos, pero sinceramente ya me canse de
'moverme con las flechas, y disparar con barra. Mi barra ya esta destrozada!
'Bueno, si tienen algun comentario o critica constructiva (no agresiones)
'escribanmen a fernandogastonramirez@yahoo.com.ar
'Visiten www.fgrqbasic.co.nr
'
'==============================================================================






DECLARE SUB menu ()
DECLARE SUB instrucciones ()
DECLARE SUB historia ()
DECLARE SUB estrellas ()
DECLARE SUB ganador ()
DECLARE SUB CentrarTexto (t$, y%)


vida = 4
vel = 10000
cd:
CALL menu

DO
SELECT CASE INKEY$
CASE "j"
GOTO post
CASE "d"
GOTO dificultad
CASE "i"
CALL instrucciones
GOTO cd
CASE "s"
GOTO salir
END SELECT
LOOP

salir:
CLS
COLOR 30
CentrarTexto "!Gracias Por Jugar TORNEO NDC!", 12
SLEEP 5
END

dificultad:
CLS
COLOR 10
CentrarTexto "(F)acil", 11
CentrarTexto "(N)ormal", 12
CentrarTexto "(D)ificil", 13
DO
SELECT CASE INKEY$
CASE "f"
vel = 10000
www = 0
GOTO cd
CASE "n"
www = 1
d = 10
vel = 9000
vida = 3
GOTO cd
CASE "d"
www = 1
d = 15
vel = 1585
vida = 2
GOTO cd
END SELECT
LOOP

CALL menu


post:
CLS
fgr = 1
puntos = 0
fx = 20000
www = 0

'INICIO DEL JUEGO
'----------------

CALL historia
inicio:
CLS
X = 1
y = 45
z = 40

DO
RANDOMIZE TIMER


'MOSTRAR VIDA, NIVEL Y PUNTOS
'-----------------------------
LOCATE 1, 70
COLOR 10
PRINT "Nvl:"
LOCATE 1, 76
PRINT fgr
COLOR 9
LOCATE 2, 70
PRINT "vida:"
LOCATE 2, 76
PRINT vida
LOCATE 3, 70
COLOR 4
PRINT "Puntos:"
LOCATE 3, 76
PRINT puntos


'CREACION Y MOVIMIENTO DE LA NAVE
'--------------------------------

CALL estrellas

LOCATE X, y
COLOR fgr
PRINT "X"
LOCATE 23, z
COLOR 9
PRINT "W"

SELECT CASE INKEY$
CASE "a"
z = z - 1
f = z + 1
LOCATE 23, f
COLOR 0
PRINT "W"
CASE "s"
z = z + 1
f = z - 1
LOCATE 23, f
COLOR 0
PRINT "W"
CASE "k"
BEEP
FOR m = 23 TO 2 STEP -1
LOCATE m, z
COLOR 15
PRINT "."
NEXT m
FOR I = 1 TO 10000
NEXT I

FOR m = 23 TO 2 STEP -1
LOCATE m, z
COLOR 0
PRINT "."
NEXT m


IF z = y THEN
LOCATE X, y
COLOR 4
PRINT "X"
FOR I = 1 TO 15
FOR S = 850 TO 810 STEP -1
SOUND (RND * 100 + S / 10 + 30), .1
NEXT
NEXT I
GOTO punto
END IF
FOR m = 23 TO 2 STEP -1
LOCATE m, z
COLOR 0
PRINT "."
NEXT m
CASE CHR$(27)
GOTO cd
END SELECT


IF z >= 81 THEN
z = z - 1
END IF

IF z = 0 THEN
z = z + 1
END IF



'ENEMIGO, MOVIMIENTOS Y DISPAROS
'-------------------------------

S = INT(RND * 3) + 1

FOR I = 1 TO fx
NEXT I

SELECT CASE S
CASE 1
y = y - 1
IF y = 1 THEN
y = y + 1
END IF
j = y + 1
LOCATE 1, j
COLOR 0
PRINT "X"
CASE 2
y = y + 1
IF y = 80 THEN
y = y - 1
END IF
j = y - 1
LOCATE 1, j
COLOR 0
PRINT "X"
END SELECT

'DISPAROS ENEMIGOS
'-----------------

d = INT(RND * 10) + 1
b = X
b = b + 2

SELECT CASE d
CASE 3
BEEP
FOR b = 1 TO 23
LOCATE b, y
COLOR 15
PRINT "."
NEXT b
FOR I = 1 TO vel
NEXT I
FOR b = 1 TO 23
LOCATE b, y
COLOR 0
PRINT "."
NEXT b


IF z = y THEN
LOCATE 23, z
COLOR 4
PRINT "W"
 
FOR I = 1 TO 15
FOR S = 850 TO 810 STEP -1
SOUND (RND * 100 + S / 10 + 30), .1
NEXT
NEXT I

GOTO vida
END IF

END SELECT





LOOP



vida:
CLS
vida = vida - 1
IF vida = 0 THEN
GOTO gameover
END IF
COLOR 9
CentrarTexto "Numero de vida:", 12
LOCATE 12, 48
PRINT vida
PLAY "o2 c4 c4 c8 c4 d+4 d8 d4 c8 c4 o1 b8 o2 c4"
SLEEP 1
GOTO inicio

'JUEGO TERMINADO
'---------------

gameover:
COLOR 15
CLS
SLEEP 1
BEEP
CentrarTexto "Perdiste!", 10
BEEP
SLEEP 2
COLOR 8
CentrarTexto "Puntos:  ", 12
LOCATE 12, 43
PRINT puntos
BEEP
SLEEP 2
COLOR 30
CentrarTexto "Gracias por Jugar!", 14
'Perder
PLAY "MnT250L4O2GG+FF+L2EP1A+L1G"
BEEP
GOTO cd
SLEEP 7


'FIN DEL JUEGO
'-------------

END

punto:
IF fgr = 16 THEN
CALL ganador
GOTO cd
END IF
CLS
COLOR 10
CentrarTexto "Nave enemiga DERROTADA!!", 12
COLOR 10
CentrarTexto "Ahora al siguiente nivel!", 13
PLAY "o4l10 dcdedefefgp10g o5 c5 o4"
puntos = puntos + 5
fgr = fgr + 1
IF fgr = 3 THEN
vida = vida + 1
'Juego
PLAY "MB L5 n0 L8 n55 n0 n50 n50 L5 n0 L8 n54 n54 L12 n0 L8 n55 L4 n0"
PLAY "MB l8 n55 n0 n50 n50  L4 n0 L8 n54 n54 L13 n0 L6 n55 "
IF www = 1 THEN
fx = 17000
END IF
END IF
IF fgr = 5 THEN
vida = vida + 1
IF www = 1 THEN
fx = 15000
END IF
'Juego
PLAY "MB L5 n0 L8 n55 n0 n50 n50 L5 n0 L8 n54 n54 L12 n0 L8 n55 L4 n0"
PLAY "MB l8 n55 n0 n50 n50  L4 n0 L8 n54 n54 L13 n0 L6 n55 "
END IF
IF fgr = 10 THEN
vida = vida + 1
IF www = 1 THEN
fx = 10000
END IF
'Juego
PLAY "MB L5 n0 L8 n55 n0 n50 n50 L5 n0 L8 n54 n54 L12 n0 L8 n55 L4 n0"
PLAY "MB l8 n55 n0 n50 n50  L4 n0 L8 n54 n54 L13 n0 L6 n55 "
END IF
SLEEP 7

IF fgr = 16 THEN
CLS
COLOR 15
IF www = 1 THEN
fx = 7000
END IF
CentrarTexto "!!NAVE FINAL!!", 11
PLAY "o3 l13 t150 eegeeaeebeegeefe t125"
PLAY "o3 l13 t150 eegeeaeebeegeefe t125"
COLOR 4
CentrarTexto "!!TE ENFRENTARAS CONTRA LA NAVE INVISIBLE!!", 12
PLAY "o3 l13 t150 eegeeaeebeegeefe t125"
PLAY "o3 l13 t150 eegeeaeebeegeefe t125"
COLOR 30
CentrarTexto "Podras Vencerla?", 13
'Pelea
PLAY "o3 l13 t150 eegeeaeebeegeefe t125"
PLAY "o3 l13 t150 eegeeaeebeegeefe t125"
'Pelea
PLAY "o3 l13 t150 eegeeaeebeegeefe t125"
PLAY "o3 l13 t150 eegeeaeebeegeefe t125"
END IF
GOTO inicio

SUB CentrarTexto (t$, y%)
xnum% = (80 - LEN(t$)) / 2
xspc% = INT((80 - LEN(t$)) / 2)
IF y% = 0 THEN PRINT TAB(xspc%); t$: EXIT SUB
LOCATE y%, xnum%: PRINT t$
'

END SUB

SUB estrellas

e = INT(RND * 23) + 1
S = INT(RND * 80) + 1
xc = INT(RND * 5) + 1

SELECT CASE xc
CASE 1
v = 15
CASE 2
v = 9
CASE ELSE
v = 0
END SELECT

COLOR v
LOCATE e, S
PRINT "."

END SUB

SUB ganador

COLOR 4
CentrarTexto "!GANASTE!", 12
PLAY "o4l10 dcdedefefgp10g o5 c5 o4"
SLEEP 3

CLS
COLOR 10
CentrarTexto "Pensaste alguna vez que podrias ganar el torneo NDC?", 3
SLEEP 3
BEEP
CentrarTexto "Seguro que si... O tal vez no!", 4
SLEEP 3
BEEP
CentrarTexto "Pero aqui est s, disfrutando de la victoria con tus amigos,", 5
SLEEP 3
BEEP
CentrarTexto "de la gloria, y de los $ 100.000 dolares ganados...", 6
SLEEP 3
BEEP
CentrarTexto "No es hermoso? No es hermoso que de aqui en mas seas visto", 7
SLEEP 3
BEEP
CentrarTexto "como un heroe en el planeta? No es hermoso haber ganado", 8
SLEEP 3
BEEP
CentrarTexto "al comandante de la nave mas temida y nunca derrotada en los", 9
SLEEP 3
BEEP
CentrarTexto "ultimos 20 a¤os? Bueno... Aqui est s, lo has hecho...", 10
SLEEP 5

CLS
CentrarTexto "Pero que hay con la libertad de las personas?", 3
SLEEP 3
BEEP
CentrarTexto "Ahora todos son libres!! El comandante Garri nunca se ", 4
SLEEP 3
BEEP
CentrarTexto "hubiese imaginado que alguna persona en el mundo", 5
SLEEP 3
BEEP
CentrarTexto "podria haberlo derrotado, pero la realidad es totalmente otra...", 6
SLEEP 3
BEEP
CentrarTexto "El est  muerto, y sin opresor hay libertad... La libertad y democracia", 7
SLEEP 3
BEEP
CentrarTexto "manda ahora... Pero necesitamos de alguien que nos gobierne!", 8
SLEEP 3
BEEP
CentrarTexto "(es lo que todos piden)", 9
SLEEP 3
BEEP
CentrarTexto "La gente necesita a alguien con grandes valores, honor y respeto", 10
SLEEP 3
BEEP
CentrarTexto "por la vida... Y ese alguien sos vos!", 11
SLEEP 5
BEEP
COLOR 4
CLS
BEEP

CLS
COLOR 4
PRINT "TORNEO NDC"
PRINT
COLOR 15
PRINT "Director del programa: Fernando Ramirez"
PRINT
PRINT "Director artistico: Fernando Ramirez"
PRINT
PRINT "Dise¤o del sistema: Fernando Ramirez"
PRINT
PRINT "Creador del universo: Fernando Ramirez"
PRINT
PRINT "Idea Original: Fernando Ramirez"
PRINT
PRINT "Director de la iglesia catolica: Fernando Ramirez"
PRINT
PRINT "Maquillador: Fernando Ramirez"
PRINT
PRINT "Musica y sonido: Fernando Ramirez"
PRINT
PRINT "Todo: Fernando Ramirez"
PRINT
PRINT "www.fgrqbasic.co.nr - Fernando Ramirez"
PRINT
PRINT "Gracias por jugar mi Juego!... Fernando Ramirez"
    'Canci¢n
    PLAY "MNT200L4O1BL8EBL4>CL8<E>CL4C+L8<E>C+L4CL8<E>CL4<BL8EB"
    PLAY "L4>CL8<E>CL4C+L8<E>C+L4CL8<E>C>EL16F+F+L8F+L4F+.L8<EE"
    PLAY "E>EL16GGL8GL4G.L8<F+F+F+>EL16F+F+L8F+L4F+.L8<EEE>EL16G"
    PLAY "GL8GL4G.L8<F+F+F+>EL16F+F+L8F+L4F+.L8<EEE>EL16GGL8GL4G."
    PLAY "L8<F+F+EO4D+L64<BL8>DL2DL64O2GL8BL64F+L8AL32G.L1B.L8E"
    PLAY "L16F+F+L8F+L4F+.L8>EEE<EL16GGL8GL4G.L8>F+F+F+<EL16F+F+"
    PLAY "L8F+L4F+.L8>EEE<EL16GGL8GL4G.L8>F+F+F+<EL16F+F+L8F+L4F+."
    PLAY "L8>EEE<EL16GGL8GL4G.L8>F+F+E>D+L64<BL8>DL2DL64<GL8BL64F+"
    PLAY "L8AL32G.L1B.L4O1BL8EBL4>CL8<E>CL4C+L8<E>C+L4CL8<E>CL4<B"
    PLAY "L8EBL4>CL8<E>CL4C+L8<E>C+L4CL8<E>C>EL64EL4GL8>D+L64<G"
    PLAY "BL4>D.L8<GL64FL8A+L64GL2B.L8GL32AGL4F+.L8<B>EC+L2C+L64<G"
    PLAY "BL8>F+.P16L64<GBL4>F+L8EL64EL4GL8>D+L64<GBL4>D.L8<GL64F"
    PLAY "L8A+L64GL2B.L8GL32AGL4F+.L8<B>D+EL2EL64<GBL8>C+.P16L64<G"
    PLAY "BL4>C+L8EL64EL4GL8>D+L64<GBL4>D.L8<GL64FL8A+L64GL2B.L8G"
    PLAY "L32AGL4F+.L8<B>EC+L2C+L64<GBL8>F+.P16L64<GBL4>F+L8EL64E"
    PLAY "L4GL8>D+L64<GBL4>D.L8<GL64FL8A+L64GL2B.L8GL32AGL4F+.L8<B"
    PLAY ">D+EL2EL64<GBL8>C+.P16L64<GBL4>C+L64<GBL8>EL64<GBL4>E"
    PLAY "L64<GBL8>EL64<A>D+L8F+.L16EL64<A>D+L4F+L64<B>EL8GL64<B"
    PLAY ">EL4GL64<B>EL8GL64<A>D+L8F+.L16EL64<A>D+L4F+L64<GBL8>E"
    PLAY "L64<GBL4>EL64<GBL8>EL64<A>D+L8F+.L16EL64<A>D+L4F+L64<B"
    PLAY ">EL8GL64<B>EL4GL64<B>EL8GL64<A>D+L8F+.L16EL64<A>D+L4F+"
    PLAY "L64C+EGL8BL64C+EGL8BP8L2O1BL8BL64O3C+EGL8BL64C+EGL8BP8"
    PLAY "L4O1B.BL64O3C+EGL16BL8BL16BL8BL64C+EGL8BL4O1BL8EBL4>C"
    PLAY "L8<E>CL4C+L8<E>C+L4CL8<E>C>EL16F+F+L8F+L4F+.L8EEEEL16G"
    PLAY "GL8GL4G.L8F+F+F+EL16F+F+L8F+L4F+.L8EEEEL16GGL8GL4G.L8F+"
    PLAY "F+F+EL16F+F+L8F+L4F+.L8EEEEL16GGL8GL4G.L8F+F+E>D+L64<B"
    PLAY "L8>DL2DL64GL8BL64F+L8AL32G.L1B.P16L8O2EL4GL8>D+L4DL8<G"
    PLAY "BB>F+L4FL8<BL4>DL8A+L4AL8FAL4AL8D+DDP8P4L64O1EB>GB>C+"
    PLAY "L2F+."
SLEEP 1
CLS
COLOR 4
CentrarTexto "Gracias por jugar!", 12
SLEEP 5
END SUB

SUB historia
CLS
COLOR 9
CentrarTexto "Saltar intro? (S/N)", 12
DO
SELECT CASE INKEY$
CASE "s"
GOTO jaja
CASE "n"
GOTO lol
END SELECT
LOOP


lol:
COLOR 10
CentrarTexto "El planeta tierra define a sus mandatarios por medio", 5
CentrarTexto "del torneo NDC (Naves De Combate), en el cual participan", 6
CentrarTexto "16 aspirantes a gobernar el planeta, y de los cuales morir n 15 de ellos...", 7
CentrarTexto "El comandante Garri, un Ingles sin una gota de moral, est ", 8
CentrarTexto "en el poder desde ya hace 20 a¤os, utilizando como herramientas para", 9
CentrarTexto "que su gobierno no decaiga, la tortura y la muerte...", 10
CentrarTexto "Su nave es la mejor de todas, y nadie ha podido ganarle todavia, ya que", 11
CentrarTexto "esta es invisible al ojo humano...", 12
CentrarTexto "Amas las NDC, y piensas morir sobre alguna de ellas, no te interesa", 16
CentrarTexto "el poder, pero si te interesa el campeonato, ya que es una gran oportunidad", 17
CentrarTexto "para mostrar tus habilidades... y una gran oportunidad para deshacerte", 18
CentrarTexto "de ese bastardo inutil... Tienes el deber de llegar a lo mas alto posible", 19
CentrarTexto "para ayudar a tu familia, y al resto del mundo...", 20
CentrarTexto "!Mucha Suerte!", 21

'Viaje a las estrellas
PLAY "t236 l6 o2 ddd l2 ml g o3 dd mn l6 c o2 ba l2 o3 ml gdd"
PLAY "mn l6 c o2 ba ml l2 o3 gdd mn l6 c o2 b o3 c l2 ml o2 a1a4 p4 mn"
PLAY "t236 l6 o2 ddd l2 ml g o3 dd mn l6 c o2 ba l2 o3 ml gdd"
PLAY "mn l6 c o2 ba ml l2 o3 gdd mn l6 c o2 b o3 c l2 ml o2 a1a4 p4 mn"
PLAY "t136 mn o3 l8"
PLAY "p4 mn o2 l8 d4 e4.e o3c o2 bag l12 gab l8 a8. e16f+4d8. d"
PLAY "e4.e o3 c o2 bag o3 d8.o2  a16 ml a4a4 mn d4 e4.e O3 c o2 bag "
PLAY "l12 gaba8. e16 f+4 o3 d8. d16 l16  g8. fe-8. d c8. o2 b-a8. g"
PLAY "o3 d2"
PLAY "t236 l6 o2 ddd l2 ml g o3 dd mn l6 c o2 ba l2 o3 ml gdd"
PLAY "mn l6 c o2 ba ml l2 o3 gdd mn l6 co2 b o3c l2 ml o2a1a4 p4 mn"
PLAY "t236 l6 o2 ddd l2 ml g o3 dd mn l6 c o2 ba l2 o3 ml gdd"
PLAY "mn l6 c o2ba ml l2 o3gdd mn l6 co2bo3c l2 ml o2a1a4 p4 mn"
PLAY "l6 o3 mn ddd ml l1 gggg4 p4 p4 mn l12 dddg2"

jaja:
END SUB

SUB instrucciones
CLS
COLOR 28
CentrarTexto "Teclas", 3
COLOR 9, 0
CentrarTexto "Izquierda: a", 5
CentrarTexto "Derecha:   s", 6
CentrarTexto "Disparos:  k", 7

COLOR 10, 0
CentrarTexto "TENER SIEMPRE DESACTIVADO BLOQ MAYUS (CAPS)", 22
COLOR 30
CentrarTexto "(Presion  cualquier tecla para continuar)", 23
DO WHILE INKEY$ = ""
LOOP
END SUB

SUB menu
CLS
FOR l = 1 TO 100
e = INT(RND * 23) + 1
S = INT(RND * 80) + 1
xc = INT(RND * 5) + 1
SELECT CASE xc
CASE 1
v = 15
CASE 2
v = 9
CASE ELSE
v = 0
END SELECT
COLOR v
LOCATE e, S
PRINT "."
NEXT l

COLOR 10
SLEEP 1
COLOR 30
CentrarTexto "TORNEO NDC", 3
PLAY "d"
SLEEP 1
COLOR 10
CentrarTexto "(J)ugar", 9
PLAY "d"
SLEEP 1
CentrarTexto "(D)ificultad", 10
PLAY "d"
SLEEP 1
CentrarTexto "(I)nstrucciones", 11
PLAY "d"
SLEEP 1
CentrarTexto "(S)alir", 12
PLAY "d"
SLEEP 1
COLOR 4
CentrarTexto "FGR SOFTWARE 2006", 23
PLAY "MfT250L4O5FL8EDEL4EL8DCDEL32AL2G"
END SUB

