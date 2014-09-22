'This is a program that calculates the volume of a sphere.

DIM Radius AS DOUBLE
DIM Pi AS DOUBLE
DIM Volume AS DOUBLE

CLS
INPUT "What is the radius of the sphere (ft.) "; Radius
PRINT
Pi = 4 * ATN(1)
Volume = Pi * Radius * Radius * Radius / 3
PRINT "The volume of the sphere= "; Volume; " cubic feet"
END

