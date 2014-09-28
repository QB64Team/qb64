DECLARE SUB roteron (vinkel!)
DECLARE SUB roterhv (vinkel!)
DECLARE SUB angpunkt (nr%, x%, y%, z%)
DECLARE SUB tegnpunkt (nr%)
TYPE vektor
x AS SINGLE
y AS SINGLE
z AS SINGLE
END TYPE

TYPE poin
x AS INTEGER
y AS INTEGER
z AS INTEGER
END TYPE


PRINT "Welcome to my second go at displaying"
PRINT "points in a threedimentional space."
PRINT
PRINT "This program uses vectorcalculations"
PRINT "to calculate where a given point in"
PRINT "a virtual space should be placed on the"
PRINT "screen.  The math behind the program"
PRINT "could be disciphered by someone with a"
PRINT "lot of experience with math, and if you"
PRINT "are one, please feel free to do so and"
PRINT "use it in a program of your own."
PRINT
PRINT "I can't copyright math, after all."
PRINT
PRINT "But do give me credits...  :)"
PRINT
PRINT "Press any key to see instructions"
WHILE INKEY$ = "": WEND
CLS
PRINT "How to navigate in the virtual space:"
PRINT
PRINT "  w      These control your direction"
PRINT "a s d    of view."
PRINT
PRINT "u i o    These are used to move the"
PRINT "j k l    point of view in the space."
PRINT
PRINT "q        This is the most useful key"
PRINT "         in the program.  It makes it"
PRINT "         go away."
PRINT
PRINT "Press any key to enter the chamber of horrors!"
WHILE INKEY$ = "": WEND


SCREEN 7, 0, 1, 0

pnkt% = 49
DIM SHARED punkt(1 TO pnkt%) AS poin
DIM SHARED perspunkt AS vektor
DIM SHARED retning AS vektor
DIM SHARED nedad AS vektor
DIM SHARED vinkel

perspunkt.x = 50
perspunkt.y = 50
perspunkt.z = 3

vinkel = 3.8
retning.x = SIN(vinkel)
retning.y = COS(vinkel)
retning.z = 0

angpunkt 1, 10, 5, 1
angpunkt 2, 10, 5, 2
angpunkt 3, 10, 5, 3
angpunkt 4, 10, 5, 4
angpunkt 5, 10, 5, 5
angpunkt 6, 10, 4, 1
angpunkt 7, 10, 4, 2
angpunkt 8, 10, 4, 3
angpunkt 9, 10, 4, 4
angpunkt 10, 10, 4, 5
angpunkt 11, 10, 3, 1
angpunkt 12, 10, 3, 2
angpunkt 13, 10, 3, 3
angpunkt 14, 10, 3, 4
angpunkt 15, 10, 3, 5
angpunkt 16, 10, 2, 1
angpunkt 17, 10, 2, 2
angpunkt 18, 10, 2, 3
angpunkt 19, 10, 2, 4
angpunkt 20, 10, 2, 5
angpunkt 21, 10, 1, 1
angpunkt 22, 10, 1, 2
angpunkt 23, 10, 1, 3
angpunkt 24, 10, 1, 4
angpunkt 25, 10, 1, 5
angpunkt 26, 10, 0, 1
angpunkt 27, 10, 0, 2
angpunkt 28, 10, 0, 3
angpunkt 29, 10, 0, 4
angpunkt 30, 10, 0, 5
angpunkt 31, 10, 1, 6
angpunkt 32, 10, 2, 6
angpunkt 33, 10, 3, 6
angpunkt 34, 10, 4, 6
angpunkt 35, 10, 5, 6
angpunkt 36, 10, -1, 1
angpunkt 37, 10, -1, 2
angpunkt 38, 10, -1, 3
angpunkt 39, 10, -1, 4
angpunkt 40, 10, -1, 5
angpunkt 41, 10, -1, 6
angpunkt 42, 10, 0, 7
angpunkt 43, 10, 1, 7
angpunkt 44, 10, 2, 7
angpunkt 45, 10, 3, 7
angpunkt 46, 10, 4, 7
angpunkt 47, 10, 5, 7
angpunkt 48, 10, -1, 7
angpunkt 49, 10, 0, 6



nedad.x = 0
nedad.y = 0
nedad.z = -1



DO

SELECT CASE INKEY$

CASE "a"
roterhv 3.141593 / 90

CASE "d"
roterhv -3.141593 / 90

CASE "w"
roteron -3.141593 / 90

CASE "s"
roteron 3.141593 / 90

CASE "i"
perspunkt.x = perspunkt.x + retning.x
perspunkt.y = perspunkt.y + retning.y
perspunkt.z = perspunkt.z + retning.z

CASE "k"
perspunkt.x = perspunkt.x - retning.x
perspunkt.y = perspunkt.y - retning.y
perspunkt.z = perspunkt.z - retning.z

CASE "l"
r1 = retning.x: r2 = retning.y: r3 = retning.z
n1 = nedad.x: n2 = nedad.y: n3 = nedad.z
x1 = n2 * r3 - n3 * r2
x2 = n3 * r1 - n1 * r3
x3 = n1 * r2 - n2 * r1
l = SQR(x1 ^ 2 + x2 ^ 2 + x3 ^ 2)
x1 = x1 / l
x2 = x2 / l
x3 = x3 / l
perspunkt.x = perspunkt.x - x1
perspunkt.y = perspunkt.y - x2
perspunkt.z = perspunkt.z - x3

CASE "j"
r1 = retning.x: r2 = retning.y: r3 = retning.z
n1 = nedad.x: n2 = nedad.y: n3 = nedad.z
x1 = n2 * r3 - n3 * r2
x2 = n3 * r1 - n1 * r3
x3 = n1 * r2 - n2 * r1
l = SQR(x1 ^ 2 + x2 ^ 2 + x3 ^ 2)
x1 = x1 / l
x2 = x2 / l
x3 = x3 / l
perspunkt.x = perspunkt.x + x1
perspunkt.y = perspunkt.y + x2
perspunkt.z = perspunkt.z + x3

CASE "u"
perspunkt.x = perspunkt.x - nedad.x
perspunkt.y = perspunkt.y - nedad.y
perspunkt.z = perspunkt.z - nedad.z

CASE "o"
perspunkt.x = perspunkt.x + nedad.x
perspunkt.y = perspunkt.y + nedad.y
perspunkt.z = perspunkt.z + nedad.z


CASE "q"
GOTO endscreen
CASE ELSE
END SELECT

FOR i% = 1 TO pnkt% STEP 1
tegnpunkt (i%)
NEXT
PCOPY 1, 0


CLS
LOOP

endscreen:
CLS
SCREEN 9
PRINT "That was my latest program."
PRINT "Programmed 10-14-05 and 10-15-05"
PRINT "Please do not use any of the program code without giving me credit"
PRINT "That's a ¯Thanks to Firngrod for ...® in your programs...  :)"
PRINT "I hope you enjoyed it."
PRINT
PRINT "Kindly yours:"
PRINT "Firngrod"
PRINT "Firngrod@hotmail.com"
PRINT
PRINT
PRINT "Press any key to quit."
WHILE INKEY$ = "": WEND

SUB angpunkt (nr%, x%, y%, z%)
punkt(nr%).x = x%
punkt(nr%).y = y%
punkt(nr%).z = z%

END SUB

SUB roterhv (vinkel)

r1 = retning.x
r2 = retning.y
r3 = retning.z

n1 = nedad.x
n2 = nedad.y
n3 = nedad.z

x1 = n2 * r3 - n3 * r2
x2 = n3 * r1 - n1 * r3
x3 = n1 * r2 - n2 * r1
l = SQR(x1 ^ 2 + x2 ^ 2 + x3 ^ 2)
x1 = x1 / l
x2 = x2 / l
x3 = x3 / l


Rx1 = SIN(vinkel) * x1
Rx2 = SIN(vinkel) * x2
Rx3 = SIN(vinkel) * x3

Ry1 = COS(vinkel) * r1
Ry2 = COS(vinkel) * r2
Ry3 = COS(vinkel) * r3

r1 = Rx1 + Ry1
r2 = Rx2 + Ry2
r3 = Rx3 + Ry3

retning.x = r1
retning.y = r2
retning.z = r3

END SUB

SUB roteron (vinkel)

r1 = retning.x
r2 = retning.y
r3 = retning.z

n1 = nedad.x
n2 = nedad.y
n3 = nedad.z

re1 = COS(vinkel) * r1 + SIN(vinkel) * n1
re2 = COS(vinkel) * r2 + SIN(vinkel) * n2
re3 = COS(vinkel) * r3 + SIN(vinkel) * n3

ne1 = -SIN(vinkel) * r1 + COS(vinkel) * n1
ne2 = -SIN(vinkel) * r2 + COS(vinkel) * n2
ne3 = -SIN(vinkel) * r3 + COS(vinkel) * n3

retning.x = re1
retning.y = re2
retning.z = re3

nedad.x = ne1
nedad.y = ne2
nedad.z = ne3

END SUB

SUB tegnpunkt (nr%)

'' The assigning of values

p1 = punkt(nr%).x
p2 = punkt(nr%).y
p3 = punkt(nr%).z

m1 = perspunkt.x
m2 = perspunkt.y
m3 = perspunkt.z

r1 = retning.x
r2 = retning.y
r3 = retning.z

n1 = nedad.x
n2 = nedad.y
n3 = nedad.z


'' The calculation of values

' Vektor from point of view (POV) to point i question
v1 = p1 - m1
v2 = p2 - m2
v3 = p3 - m3

' Projection of this vektor on the vektor that represents the direction of view(the DOV)
k = (v1 * r1 + v2 * r2 + v3 * r3) / (r1 ^ 2 + r2 ^ 2 + r3 ^ 2)
IF k < 0 THEN GOTO nopoint
d1 = k * r1
d2 = k * r2
d3 = k * r3
' The length of this projection-vektor
z = SQR(d1 ^ 2 + d2 ^ 2 + d3 ^ 2)

' The projection of the point on the plane that goes through the POV and is ortogonal with DOV
t = (r1 * m1 + r2 * m2 + r3 * m3 - r1 * p1 - r2 * p2 - r3 * p3) / (r1 ^ 2 + r2 ^ 2 + r3 ^ 2)
s1 = p1 + t * r1
s2 = p2 + t * r2
s3 = p3 + t * r3

' The making of the vektor from POV to (s1,s2,s3)
w1 = s1 - m1
w2 = s2 - m2
w3 = s3 - m3

' The splitting of the W vektor into vektors that represent, in a way, the placing on the dot on the screen
coss = (n1 * w1 + n2 * w2 + n3 * w3) / (SQR((n1 ^ 2 + n2 ^ 2 + n3 ^ 2) * (w1 ^ 2 + w2 ^ 2 + w3 ^ 2)))
h1 = r2 * n3 - r3 * n2
h2 = r3 * n1 - r1 * n3
h3 = r1 * n2 - r2 * n1
sinn = (h1 * w1 + h2 * w2 + h3 * w3) / (SQR((h1 ^ 2 + h2 ^ 2 + h3 ^ 2) * (w1 ^ 2 + w2 ^ 2 + w3 ^ 2)))

x = sinn * SQR(w1 ^ 2 + w2 ^ 2 + w3 ^ 2)
y = coss * SQR(w1 ^ 2 + w2 ^ 2 + w3 ^ 2)

Forsfakt! = -LOG(z / 32000) / LOG(2)

x = x * 2 ^ Forsfakt! / 100
y = y * 2 ^ Forsfakt! / 100

x = x + 320 / 2
y = y + 200 / 2

PSET (x, y), 15
nopoint:
END SUB