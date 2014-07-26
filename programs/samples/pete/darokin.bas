'simple program in qbasic
'02/01/99
'if you want to tell me something on my prog or something else
'e mail me
'darokin@infonie.fr
'darokin        use it free and learn  (i know you can't learn
'                                       whith this but if that could help
'                                       someone ....)
'darokin '99

SCREEN 13

etoile% = 150
DIM x%(1 TO etoile%)
DIM y%(1 TO etoile%)
DIM c%(1 TO etoile%)
DIM v%(1 TO etoile%)
FOR i% = 1 TO etoile%
x%(i%) = INT(RND * 320)
y%(i%) = INT(RND * 129) + 40
c%(i%) = INT(RND * 15) + 15
v%(i%) = INT(RND * 3) + 2
NEXT i%

DIM txt(97)
PRINT "darokin"
GET (0, 0)-(54, 6), txt

CLS

DIM balle(120)
DATA 00,00,00,00,04,04,04,00,00,00,00
DATA 00,00,04,04,04,04,04,04,04,00,00
DATA 00,04,04,15,15,04,04,04,04,04,00
DATA 00,04,04,15,15,04,04,04,04,04,00
DATA 04,04,04,04,04,04,04,04,04,04,04
DATA 04,04,04,04,04,04,04,04,04,04,04
DATA 00,04,04,04,04,04,04,04,04,04,00
DATA 00,04,04,04,04,04,04,04,04,04,00
DATA 00,00,04,04,04,04,04,04,04,00,00
DATA 00,00,00,00,04,04,04,00,00,00,00

xlenght = 11
ylenght = 10

FOR y% = 1 TO ylenght
    FOR x% = 1 TO xlenght
        READ z
        PSET (x%, y%), z
    NEXT x%
NEXT y%


x = 15: y = 55: xtxt = 35: ytxt = 3
 xmax = 305: ymax = 160: xtxtmax = 200: ytxtmax = 15
  a = 1: b = 1: c = 1: d = 1: e = 1
   xmin = 5: ymin = 39: xtxtmin = 30: ytxtmin = 1
GET (0, 0)-(11, 10), balle
CLS
PUT (20, 5), txt
RANDOMIZE TIMER
DO
PUT (x, y), balle
  FOR i% = 1 TO etoile%
    PSET (x%(i%), y%(i%)), c%(i%)
    PSET (x%(i%), y%(i%)), 0
    x%(i%) = x%(i%) + v%(i%)
    IF x%(i%) >= 320 THEN
        x%(i%) = 1
        y%(i%) = INT(RND * 129) + 40
        c%(i%) = INT(RND * 15) + 15
        v%(i%) = INT(RND * 3) + 2
     END IF
     PSET (x%(i%), y%(i%)), c%(i%)
  NEXT i%
  PUT (xtxt, ytxt), txt
  IF c = 1 THEN CLS
  c = c + 1
  IF xtxt < xtxtmin THEN d = -d
  IF x < xmin THEN a = -a
  IF xtxt > xtxtmax THEN d = -d
  IF x > xmax THEN a = -a
  IF ytxt < ytxtmin THEN e = -e
  IF y < ymin THEN b = -b
  IF ytxt > ytxtmax THEN e = -e
  IF y > ymax THEN b = -b
  x = x + a
  y = y + b
  xtxt = xtxt + d
  ytxt = ytxt + e
 PUT (x, y), balle
 PUT (xtxt, ytxt), txt
    FOR i = 1 TO 5000
    NEXT i
LOOP WHILE INKEY$ = ""


