CHDIR ".\programs\samples\n54\big\3dsviewer"

'----sub declarations
'--file stuff
DECLARE SUB ReadChunkInfo (ChunkInfoHolder AS ANY, BytePosition AS LONG)
DECLARE SUB SkipChunk (ChunkInfoHolder AS ANY, BytePosition AS LONG)
DECLARE SUB SearchForChunk (ChunkInfoHolder AS ANY)
DECLARE SUB ReadObject ()
'--3D engine stuff
DECLARE SUB multiplyMatrices (matrixA(), matrixB(), result())
DECLARE SUB getScalingMatrix (sX, sY, sZ, result())
DECLARE SUB getRotationXMatrix (rX, result())
DECLARE SUB getRotationYMatrix (rY, result())
DECLARE SUB getRotationZMatrix (rZ, result())
DECLARE SUB getTranslationMatrix (tX, tY, tZ, result())
DECLARE SUB getCombinedMatrix (sX, sY, sZ, rX, rY, rZ, tX, tY, tZ, temp(), temp2(), result())
DECLARE SUB getNewXYZ (X, Y, Z, combinedMatrix())
DECLARE SUB getScreenXY (X, Y, Z)

'----global declarations
REM $DYNAMIC
DIM SHARED PointsArray(0, 0) AS SINGLE
DIM SHARED NewPointsArray(0, 0) AS LONG
DIM SHARED FaceArray(0, 0) AS INTEGER
REM $STATIC
DIM SHARED numberVertices AS INTEGER
DIM SHARED numberFaces AS INTEGER
DIM SHARED CurrentBytePosition AS LONG
DIM SHARED FindChunk$

'----type definitions
TYPE ChunkInfo
ID AS INTEGER
Size AS LONG
Position AS LONG
END TYPE

'----open file
CLS
PRINT "Would you like to view car.3ds (y/n)?"
DO
k$ = INKEY$
LOOP UNTIL k$<>""
IF UCASE$(k$) = "N" THEN
INPUT "Please input the file you wish to load:", fileName$
ELSE
fileName$="car.3ds"
END IF
OPEN fileName$ FOR BINARY AS #1

'----initialise variables
sX = 5
sY = 5
sZ = 5
rX = 0
rY = 0
rZ = 0
tX = 0
tY = 0
tZ = 500
currentFrame = 0

'----allocate space for matrix calcs
DIM temp(3, 3)
DIM temp2(3, 3)
DIM result(3, 3)

'----MAIN PROGRAM
CLS
PRINT "3DS Object Viewer 0.5"
PRINT "---------------------"
PRINT "By David Llewellyn"
PRINT "24/10/2004"
PRINT ""
CALL ReadObject
PRINT ""
PRINT "Press any key to continue"
DO
LOOP UNTIL INKEY$ > CHR$(0)

'3D-Section
SCREEN 7, , 0, 1
Colour = 4
oldTime = TIMER

DO

CALL getCombinedMatrix(sX, sY, sZ, rX, rY, rZ, tX, tY, tZ, temp(), temp2(), result())
CLS

FOR i = 0 TO numberVertices'load screen coordinates into new array
X = PointsArray(0, i)
Y = PointsArray(1, i)
Z = PointsArray(2, i)
CALL getNewXYZ(X, Y, Z, result())
CALL getScreenXY(X, Y, Z)
NewPointsArray(0, i) = X
NewPointsArray(1, i) = Y
NEXT i'load screen coordinates into new array

FOR i = 0 TO numberFaces - 1'draw faces
'line from point 0 to 1
LINE (NewPointsArray(0, FaceArray(0, i)), NewPointsArray(1, FaceArray(0, i)))-(NewPointsArray(0, FaceArray(1, i)), NewPointsArray(1, FaceArray(1, i))), Colour
'line from point 1 to 2
LINE (NewPointsArray(0, FaceArray(1, i)), NewPointsArray(1, FaceArray(1, i)))-(NewPointsArray(0, FaceArray(2, i)), NewPointsArray(1, FaceArray(2, i))), Colour
'line from point 2 to 0
LINE (NewPointsArray(0, FaceArray(2, i)), NewPointsArray(1, FaceArray(2, i)))-(NewPointsArray(0, FaceArray(0, i)), NewPointsArray(1, FaceArray(0, i))), Colour
NEXT i'draw faces

PCOPY 0, 1
frames = frames + 1

A$ = INKEY$
rX = rX + .00065
rY = rY + .00545
IF A$ = "=" THEN tZ = tZ - 5
IF A$ = "-" THEN tZ = tZ + 5

LOOP UNTIL A$ = CHR$(27)

newTime = TIMER
timeTaken = newTime - oldTime
SCREEN 13
PRINT USING "##.##"; frames / timeTaken
PRINT "frames per second"
DO
LOOP UNTIL INKEY$ > CHR$(0)

SYSTEM

SUB getCombinedMatrix (sX, sY, sZ, rX, rY, rZ, tX, tY, tZ, temp(), temp2(), result())

ERASE temp2
CALL getScalingMatrix(sX, sY, sZ, result())
CALL getRotationXMatrix(rX, temp())
CALL multiplyMatrices(result(), temp(), temp2())'combine with x rotation

CALL getRotationYMatrix(rY, temp())
ERASE result
CALL multiplyMatrices(temp2(), temp(), result())'combine with y rotation

CALL getRotationZMatrix(rZ, temp())
ERASE temp2
CALL multiplyMatrices(result(), temp(), temp2())'combine with z rotation

CALL getTranslationMatrix(tX, tY, tZ, temp())
ERASE result
CALL multiplyMatrices(temp2(), temp(), result())'combine with translation

END SUB

SUB getNewXYZ (X, Y, Z, combinedMatrix())

newX = (combinedMatrix(0, 0) * X) + (combinedMatrix(0, 1) * Y) + (combinedMatrix(0, 2) * Z) + combinedMatrix(0, 3)'new X point
newY = (combinedMatrix(1, 0) * X) + (combinedMatrix(1, 1) * Y) + (combinedMatrix(1, 2) * Z) + combinedMatrix(1, 3)'new Y point
newZ = (combinedMatrix(2, 0) * X) + (combinedMatrix(2, 1) * Y) + (combinedMatrix(2, 2) * Z) + combinedMatrix(2, 3)'new Z point

X = newX
Y = newY
Z = newZ

END SUB

SUB getRotationXMatrix (rX, result())

result(0, 0) = 1
result(1, 0) = 0
result(2, 0) = 0
result(3, 0) = 0

result(0, 1) = 0
result(1, 1) = COS(rX)
result(2, 1) = SIN(rX)
result(3, 1) = 0

result(0, 2) = 0
result(1, 2) = -SIN(rX)
result(2, 2) = COS(rX)
result(3, 2) = 0

result(0, 3) = 0
result(1, 3) = 0
result(2, 3) = 0
result(3, 3) = 1

END SUB

SUB getRotationYMatrix (rY, result())

result(0, 0) = COS(rY)
result(1, 0) = 0
result(2, 0) = -SIN(rY)
result(3, 0) = 0

result(0, 1) = 0
result(1, 1) = 1
result(2, 1) = 0
result(3, 1) = 0

result(0, 2) = SIN(rY)
result(1, 2) = 0
result(2, 2) = COS(rY)
result(3, 2) = 0

result(0, 3) = 0
result(1, 3) = 0
result(2, 3) = 0
result(3, 3) = 1

END SUB

SUB getRotationZMatrix (rZ, result())

result(0, 0) = COS(rZ)
result(1, 0) = SIN(rZ)
result(2, 0) = 0
result(3, 0) = 0

result(0, 1) = -SIN(rZ)
result(1, 1) = COS(rZ)
result(2, 1) = 0
result(3, 1) = 0

result(0, 2) = 0
result(1, 2) = 0
result(2, 2) = 1
result(3, 2) = 0

result(0, 3) = 0
result(1, 3) = 0
result(2, 3) = 0
result(3, 3) = 1

END SUB

SUB getScalingMatrix (sX, sY, sZ, result())

result(0, 0) = sX
result(1, 0) = 0
result(2, 0) = 0
result(3, 0) = 0

result(0, 1) = 0
result(1, 1) = sY
result(2, 1) = 0
result(3, 1) = 0

result(0, 2) = 0
result(1, 2) = 0
result(2, 2) = sZ
result(3, 2) = 0

result(0, 3) = 0
result(1, 3) = 0
result(2, 3) = 0
result(3, 3) = 1

END SUB

SUB getScreenXY (X, Y, Z)

IF Z = 0 THEN
X = X * 280
Y = Y * 240
ELSE
X = (X * 280) / Z
Y = (Y * 240) / Z
END IF

X = INT(X + 160)
Y = INT(Y + 100)

END SUB

SUB getTranslationMatrix (tX, tY, tZ, result())

result(0, 0) = 1
result(1, 0) = 0
result(2, 0) = 0
result(3, 0) = 0

result(0, 1) = 0
result(1, 1) = 1
result(2, 1) = 0
result(3, 1) = 0

result(0, 2) = 0
result(1, 2) = 0
result(2, 2) = 1
result(3, 2) = 0

result(0, 3) = tX
result(1, 3) = tY
result(2, 3) = tZ
result(3, 3) = 1

END SUB

SUB multiplyMatrices (matrixA(), matrixB(), result())

FOR i = 0 TO 3
FOR j = 0 TO 3
FOR k = 0 TO 3
result(j, i) = result(j, i) + (matrixB(j, k) * matrixA(k, i))
NEXT k
NEXT j
NEXT i

END SUB

SUB ReadChunkInfo (ChunkInfoHolder AS ChunkInfo, BytePosition AS LONG)

GET #1, BytePosition, ChunkInfoHolder.ID
GET #1, BytePosition + 2, ChunkInfoHolder.Size
ChunkInfoHolder.Position = BytePosition

END SUB

SUB ReadObject

DIM ChunkH AS ChunkInfo
CurrentBytePosition = 1'start of file
CALL ReadChunkInfo(ChunkH, CurrentBytePosition)
FindChunk$ = "3D3D"
CALL SearchForChunk(ChunkH)'CBP should now be 3D3D(EDIT3DS)
CALL ReadChunkInfo(ChunkH, CurrentBytePosition)
FindChunk$ = "4000"
CALL SearchForChunk(ChunkH)'CBP should now be 4000(NAMED_OBJECT)
'\/Read & display object name
i = 0
DO
ObjectName$ = " "
GET #1, CurrentBytePosition + 6 + i, ObjectName$
i = i + 1
LOOP UNTIL ASC(ObjectName$) = 0
ObjectName$ = STRING$(i - 1, " ")
GET #1, CurrentBytePosition + 6, ObjectName$
PRINT "Object Name: "; ObjectName$
'/\Read & display object name
CALL ReadChunkInfo(ChunkH, CurrentBytePosition)
ChunkH.Position = CurrentBytePosition + i'skip past name area
ChunkH.Size = ChunkH.Size - i'skip past name area
FindChunk$ = "4100"
CALL SearchForChunk(ChunkH) 'CBP should now be 4100(OBJ_MESH)
CALL ReadChunkInfo(ChunkH, CurrentBytePosition)
DIM BackupBytePosition AS LONG
BackupBytePosition = CurrentBytePosition
FindChunk$ = "4110"
CALL SearchForChunk(ChunkH)'CBP should now be 4110(MESH_VERTICES)
'\/Read & display vertices
'Number of vertices
CurrentBytePosition = CurrentBytePosition + 6
GET #1, CurrentBytePosition, numberVertices
PRINT "Number of vertices:"; numberVertices
REDIM PointsArray(2, numberVertices) AS SINGLE'allocate space for 3d points
REDIM NewPointsArray(1, numberVertices) AS LONG'allocate space for screen points
CurrentBytePosition = CurrentBytePosition + 2
'Actual vertice data
DIM vertex AS SINGLE
FOR i = 0 TO numberVertices
GET #1, CurrentBytePosition, vertex
'PRINT "X-vertex"; vertex
PointsArray(0, i) = vertex
CurrentBytePosition = CurrentBytePosition + 4
GET #1, CurrentBytePosition, vertex
'PRINT "Y-vertex"; vertex
PointsArray(1, i) = vertex
CurrentBytePosition = CurrentBytePosition + 4
GET #1, CurrentBytePosition, vertex
'PRINT "Z-vertex"; vertex
PointsArray(2, i) = vertex
CurrentBytePosition = CurrentBytePosition + 4
NEXT i
'/\Read & display vertices
CALL ReadChunkInfo(ChunkH, BackupBytePosition)'ChunkH should now be 4100(OBJ_MESH)
FindChunk$ = "4120"
CALL SearchForChunk(ChunkH)'CBP should now be 4120(MESH_FACES)
'\/Read & display faces
'Number of faces
CurrentBytePosition = CurrentBytePosition + 6
GET #1, CurrentBytePosition, numberFaces
PRINT "Number of faces:"; numberFaces
REDIM FaceArray(2, numberFaces) AS INTEGER'allocate space for face points
CurrentBytePosition = CurrentBytePosition + 2
'Actual face data
DIM face AS INTEGER
FOR i = 0 TO numberFaces
GET #1, CurrentBytePosition, face
'PRINT "Face-point 1:"; face
FaceArray(0, i) = face
CurrentBytePosition = CurrentBytePosition + 2
GET #1, CurrentBytePosition, face
'PRINT "Face-point 2:"; face
FaceArray(1, i) = face
CurrentBytePosition = CurrentBytePosition + 2
GET #1, CurrentBytePosition, face
'PRINT "Face-point 3:"; face
FaceArray(2, i) = face
CurrentBytePosition = CurrentBytePosition + 2
GET #1, CurrentBytePosition, face
'PRINT "Face-visibility:"; face
CurrentBytePosition = CurrentBytePosition + 2
NEXT i
'\/Read & display faces


END SUB

SUB SearchForChunk (ChunkInfoHolder AS ChunkInfo)

DIM InnerBytePosition AS LONG
DIM MaxBytePosition AS LONG
InnerBytePosition = ChunkInfoHolder.Position + 6
MaxBytePosition = ChunkInfoHolder.Position + ChunkInfoHolder.Size
ChunkName$ = HEX$(ChunkInfoHolder.ID)

Found = 0

DO

CALL ReadChunkInfo(ChunkInfoHolder, InnerBytePosition)

IF FindChunk$ = HEX$(ChunkInfoHolder.ID) THEN
Found = 1
ELSE
CALL SkipChunk(ChunkInfoHolder, InnerBytePosition)
END IF

LOOP UNTIL InnerBytePosition >= MaxBytePosition OR Found = 1 OR INKEY$ = CHR$(27) OR ChunkInfoHolder.Size = 0

IF Found = 0 THEN
PRINT ""
PRINT FindChunk$; " was not found within "; ChunkName$; "!"
PRINT ""
SYSTEM
ELSE
CurrentBytePosition = ChunkInfoHolder.Position
END IF

END SUB

SUB SkipChunk (ChunkInfoHolder AS ChunkInfo, BytePosition AS LONG)

BytePosition = BytePosition + ChunkInfoHolder.Size

END SUB

