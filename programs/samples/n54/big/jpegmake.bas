'JPEG Encoder v2 by Artelius 
'WARNING: OVERWRITES TEST.JPG
DECLARE FUNCTION Atan2! (X AS SINGLE, Y AS SINGLE)
DECLARE SUB PutChar (FileNo AS INTEGER, Char AS INTEGER)

DECLARE SUB JPEG.Precalc ()
DECLARE SUB JPEG.Begin (FileNo AS INTEGER, W AS INTEGER, H AS INTEGER, Sampling() AS INTEGER, State AS ANY, QT() AS INTEGER, Huff() AS INTEGER)
DECLARE SUB JPEG.Block.Output (B() AS INTEGER, State AS ANY, QT() AS INTEGER, Huff() AS INTEGER)
DECLARE SUB JPEG.StandardQT (quality AS SINGLE, QT() AS INTEGER)
DECLARE SUB JPEG.Finish (State AS ANY)
DECLARE FUNCTION JPEG.Category% (X AS INTEGER)
DECLARE FUNCTION JPEG.Cb% (R AS INTEGER, G AS INTEGER, B AS INTEGER)
DECLARE FUNCTION JPEG.Cr% (R AS INTEGER, G AS INTEGER, B AS INTEGER)
DECLARE FUNCTION JPEG.Y% (R AS INTEGER, G AS INTEGER, B AS INTEGER)

TYPE JPEGState
FileNo AS INTEGER
YCount AS INTEGER
CbCount AS INTEGER
CrCount AS INTEGER
YDC AS INTEGER
CbDC AS INTEGER
CrDC AS INTEGER
Position AS INTEGER
Leftover AS INTEGER
LeftoverBits AS INTEGER
END TYPE

'The following are internal to JPEG.
DECLARE SUB JPEG.ACHuff (RLE AS INTEGER, AC AS INTEGER, Huff() AS INTEGER, A AS INTEGER, State AS ANY)
DECLARE SUB JPEG.Block.Huffman (B() AS INTEGER, LastDC AS INTEGER, Huff() AS INTEGER, A AS INTEGER, State AS ANY)
DECLARE SUB JPEG.Block.Transform (B() AS INTEGER, O() AS INTEGER, QT() AS INTEGER, A AS INTEGER)
DECLARE SUB JPEG.DCHuff (DC AS INTEGER, Huff() AS INTEGER, A AS INTEGER, State AS ANY)
DECLARE SUB JPEG.GenerateHuffmanTable (Huff() AS INTEGER, A AS INTEGER, B AS INTEGER)
DECLARE SUB JPEG.PutBinString (BS AS INTEGER, Length AS INTEGER, State AS ANY)
DECLARE SUB JPEG.PutByte (FileNo AS INTEGER, Byte AS INTEGER)
DECLARE SUB JPEG.PutRightBinString (BS AS INTEGER, Length AS INTEGER, State AS ANY)
DECLARE SUB JPEG.PutWord (FileNo AS INTEGER, Word AS INTEGER)
DECLARE FUNCTION JPEG.Shift% (I AS INTEGER, N AS INTEGER)

DEFINT A-Z

DIM SHARED Pow2(0 TO 15) AS LONG
DIM SHARED Cosine(0 TO 7, 0 TO 7) AS SINGLE
DIM SHARED ZigZagX(0 TO 63) AS INTEGER, ZigZagY(0 TO 63) AS INTEGER
JPEG.Precalc

DIM Huff(0 TO 255, 0 TO 1, 0 TO 1, 0 TO 1) AS INTEGER
DIM QT(0 TO 7, 0 TO 7, 0 TO 1) AS INTEGER
DIM State AS JPEGState

DIM Sampling(0 TO 2, 0 TO 1) AS INTEGER
Sampling(0, 0) = 2 'Sampling factor (x then y) for luminance
Sampling(0, 1) = 2
Sampling(1, 0) = 1 'Sampling factor for "blue" chrominance
Sampling(1, 1) = 1
Sampling(2, 0) = 1 'Sampling factor for "red" chrominance
Sampling(2, 1) = 1


'Delete file then open for binary
OPEN "test.jpg" FOR OUTPUT AS #1
CLOSE
OPEN "test.jpg" FOR BINARY AS #1

'Set quality tables
'The smaller the paramter, the higher the quality
'0.01 is 100% quality
JPEG.StandardQT .5, QT()

'Start image (64x64)
JPEG.Begin 1, 128, 128, Sampling(), State, QT(), Huff()


DIM B(0 TO 7, 0 TO 7) AS INTEGER

FOR SuperY = 0 TO 127 STEP 16
FOR SuperX = 0 TO 127 STEP 16

'Output the luminance blocks

FOR BlockY = 0 TO 15 STEP 8
FOR BlockX = 0 TO 15 STEP 8
FOR OffY = 0 TO 7: FOR OffX = 0 TO 7
X! = OffX + BlockX + SuperX - 63.5
Y! = OffY + BlockY + SuperY - 63.5
D! = SQR(X! * X! + Y! * Y!) / 6 + Atan2(X!, Y!)
R = 255
G = 255 - (COS(D!) + 1) * 127.5
B = 255 - (COS(D!) + 1) * 127.5
B(OffX, OffY) = JPEG.Y(R, G, B)
NEXT OffX, OffY
JPEG.Block.Output B(), State, QT(), Huff()
NEXT BlockX, BlockY

'Output the blue chrominance block

FOR OffY = 0 TO 7: FOR OffX = 0 TO 7
X! = OffX * 2 + SuperX - 63
Y! = OffY * 2 + SuperY - 63
D! = SQR(X! * X! + Y! * Y!) / 6 + Atan2(X!, Y!)
R = 255
G = 255 - (COS(D!) + 1) * 127.5
B = 255 - (COS(D!) + 1) * 127.5
B(OffX, OffY) = JPEG.Cb(R, G, B)
NEXT OffX, OffY
JPEG.Block.Output B(), State, QT(), Huff()

'Output the red chrominance block

FOR OffY = 0 TO 7: FOR OffX = 0 TO 7
X! = OffX * 2 + SuperX - 63
Y! = OffY * 2 + SuperY - 63
D! = SQR(X! * X! + Y! * Y!) / 6 + Atan2(X!, Y!)
R = 255
G = 255 - (COS(D!) + 1) * 127.5
B = 255 - (COS(D!) + 1) * 127.5
B(OffX, OffY) = JPEG.Cr(R, G, B)
NEXT OffX, OffY
JPEG.Block.Output B(), State, QT(), Huff()

NEXT SuperX, SuperY


JPEG.Finish State

CLOSE

END

Huff0:
DATA 0
DATA 1, 0
DATA 5, 1, 2, 3, 4, 5
DATA 1, 6
DATA 1, 7
DATA 1, 8
DATA 1, 9
DATA 1, 10
DATA 1, 11
DATA 0, 0, 0, 0, 0, 0, 0

Huff1:
DATA 0
DATA 3, 0, 1, 2
DATA 1, 3
DATA 1, 4
DATA 1, 5
DATA 1, 6
DATA 1, 7
DATA 1, 8
DATA 1, 9
DATA 1, 10
DATA 1, 11
DATA 0, 0, 0, 0, 0

Huff2:
DATA 0
DATA 2, 1, 2
DATA 1, 3
DATA 3, 0, 4, &H11
DATA 3, 5, &H12, &H21
DATA 2, &H31, &H41
DATA 4, 6, &H13, &H51, &H61
DATA 3, 7, &H22, &H71
DATA 5, &H14, &H32, &H81, &H91, &HA1
DATA 5, &H08, &H23, &H42, &HB1, &HC1
DATA 4, &H15, &H52, &HD1, &HF0
DATA 4, &H24, &H33, &H62, &H72
DATA 0
DATA 0
DATA 1, &H82
DATA 125, &H09, &H0A, &H16, &H17, &H18, &H19, &H1A, &H25, &H26, &H27, &H28, &H29, &H2A, &H34, &H35, &H36
DATA &H37, &H38, &H39, &H3A, &H43, &H44, &H45, &H46, &H47, &H48, &H49, &H4A, &H53, &H54, &H55, &H56
DATA &H57, &H58, &H59, &H5A, &H63, &H64, &H65, &H66, &H67, &H68, &H69, &H6A, &H73, &H74, &H75, &H76
DATA &H77, &H78, &H79, &H7A, &H83, &H84, &H85, &H86, &H87, &H88, &H89, &H8A, &H92, &H93, &H94, &H95
DATA &H96, &H97, &H98, &H99, &H9A, &HA2, &HA3, &HA4, &HA5, &HA6, &HA7, &HA8, &HA9, &HAA, &HB2, &HB3
DATA &HB4, &HB5, &HB6, &HB7, &HB8, &HB9, &HBA, &HC2, &HC3, &HC4, &HC5, &HC6, &HC7, &HC8, &HC9, &HCA
DATA &HD2, &HD3, &HD4, &HD5, &HD6, &HD7, &HD8, &HD9, &HDA, &HE1, &HE2, &HE3, &HE4, &HE5, &HE6, &HE7
DATA &HE8, &HE9, &HEA, &HF1, &HF2, &HF3, &HF4, &HF5, &HF6, &HF7, &HF8, &HF9, &HFA

Huff3:
DATA 0
DATA 2, 0, 1
DATA 1, 2
DATA 2, 3, &H11
DATA 4, 4, 5, &H21, &H31
DATA 4, 6, &H12, &H41, &H51
DATA 3, 7, &H61, &H71
DATA 4, &H13, &H22, &H32, &H81
DATA 7, 8, &H14, &H42, &H91, &HA1, &HB1, &HC1
DATA 5, 9, &H23, &H33, &H52, &HF0
DATA 4, &H15, &H62, &H72, &HD1
DATA 4, &HA, &H16, &H24, &H34
DATA 0
DATA 1, &HE1
DATA 2, &H25, &HF1
DATA 119, &H17, &H18, &H19, &H1A, &H26, &H27, &H28, &H29, &H2A, &H35, &H36, &H37, &H38, &H39, &H3A, &H43
DATA &H44, &H45, &H46, &H47, &H48, &H49, &H4A, &H53, &H54, &H55, &H56, &H57, &H58, &H59, &H5A, &H63
DATA &H64, &H65, &H66, &H67, &H68, &H69, &H6A, &H73, &H74, &H75, &H76, &H77, &H78, &H79, &H7A, &H82
DATA &H83, &H84, &H85, &H86, &H87, &H88, &H89, &H8A, &H92, &H93, &H94, &H95, &H96, &H97, &H98, &H99
DATA &H9A, &HA2, &HA3, &HA4, &HA5, &HA6, &HA7, &HA8, &HA9, &HAA, &HB2, &HB3, &HB4, &HB5, &HB6, &HB7
DATA &HB8, &HB9, &HBA, &HC2, &HC3, &HC4, &HC5, &HC6, &HC7, &HC8, &HC9, &HCA, &HD2, &HD3, &HD4, &HD5
DATA &HD6, &HD7, &HD8, &HD9, &HDA, &HE2, &HE3, &HE4, &HE5, &HE6, &HE7, &HE8, &HE9, &HEA, &HF2, &HF3
DATA &HF4, &HF5, &HF6, &HF7, &HF8, &HF9, &HFA

StandardQT:
DATA 16, 11, 10, 16, 24, 40, 51, 61
DATA 12, 12, 14, 19, 26, 58, 60, 55
DATA 14, 13, 16, 24, 40, 57, 69, 56
DATA 14, 17, 22, 29, 51, 87, 80, 62
DATA 18, 22, 37, 56, 68, 109, 103, 77
DATA 24, 35, 55, 64, 81, 104, 113, 92
DATA 49, 64, 78, 87, 103, 121, 120, 101
DATA 72, 92, 95, 98, 112, 100, 103, 99

DATA 17, 18, 24, 47, 99, 99, 99, 99
DATA 18, 24, 26, 66, 99, 99, 99, 99
DATA 24, 26, 56, 99, 99, 99, 99, 99
DATA 47, 66, 99, 99, 99, 99, 99, 99
DATA 99, 99, 99, 99, 99, 99, 99, 99
DATA 99, 99, 99, 99, 99, 99, 99, 99
DATA 99, 99, 99, 99, 99, 99, 99, 99
DATA 99, 99, 99, 99, 99, 99, 99, 99

DEFSNG A-Z
FUNCTION Atan2! (X AS SINGLE, Y AS SINGLE)

'Code borrowed from London
Atan2 = ATN(Y / X) - ATN(1) * 4 * (X < 0 - 2 * (X < 0 AND Y < 0))

END FUNCTION

SUB JPEG.ACHuff (RLE AS INTEGER, AC AS INTEGER, Huff() AS INTEGER, A AS INTEGER, State AS JPEGState)
DIM C AS INTEGER, X AS INTEGER
C = JPEG.Category(AC)
X = RLE * 16 + C
JPEG.PutBinString Huff(X, 1, A, 0), Huff(X, 1, A, 1), State
JPEG.PutRightBinString AC + (AC < 0), C, State
END SUB

SUB JPEG.Begin (FileNo AS INTEGER, W AS INTEGER, H AS INTEGER, Sampling() AS INTEGER, State AS JPEGState, QT() AS INTEGER, Huff() AS INTEGER)

DIM I AS INTEGER, J AS INTEGER, X AS INTEGER, Y AS INTEGER, T AS INTEGER

State.FileNo = FileNo

RESTORE Huff0
JPEG.GenerateHuffmanTable Huff(), 0, 0
JPEG.GenerateHuffmanTable Huff(), 0, 1
JPEG.GenerateHuffmanTable Huff(), 1, 0
JPEG.GenerateHuffmanTable Huff(), 1, 1


State.YCount = Sampling(0, 0) * Sampling(0, 1)
State.CbCount = Sampling(1, 0) * Sampling(1, 1)
State.CrCount = Sampling(2, 0) * Sampling(2, 1)
State.YDC = 0
State.CbDC = 0
State.CrDC = 0

State.Position = 0

State.Leftover = 0
State.LeftoverBits = 0


'SOI
PutChar FileNo, 255
PutChar FileNo, 216
'APP0
PutChar FileNo, 255
PutChar FileNo, 224
JPEG.PutWord FileNo, 16
S$ = "JFIF" + CHR$(0): PUT FileNo, , S$
PutChar FileNo, 1
PutChar FileNo, 2
PutChar FileNo, 0
PutChar FileNo, 0
PutChar FileNo, 1
PutChar FileNo, 0
PutChar FileNo, 1
PutChar FileNo, 0
PutChar FileNo, 0

'DQT
PutChar FileNo, 255
PutChar FileNo, 219
JPEG.PutWord FileNo, 132

PutChar FileNo, 0
FOR I = 0 TO 63
PutChar FileNo, QT(ZigZagX(I), ZigZagY(I), 0)
NEXT



PutChar FileNo, 1
FOR I = 0 TO 63
PutChar FileNo, QT(ZigZagX(I), ZigZagY(I), 1)
NEXT



'DHT
PutChar FileNo, 255
PutChar FileNo, 196
T = 2 + 4 * (16 + 1)
RESTORE Huff0
FOR I = 1 TO 16 * 4
READ X
FOR J = 1 TO X
READ Y
T = T + 1
NEXT
NEXT

JPEG.PutWord FileNo, T

PutChar FileNo, 0
RESTORE Huff0
FOR I = 1 TO 16
READ X
PutChar FileNo, X
FOR J = 1 TO X
READ Y
NEXT
NEXT
RESTORE Huff0
FOR I = 1 TO 16
READ X
FOR J = 1 TO X
READ Y
PutChar FileNo, Y
NEXT
NEXT

PutChar FileNo, 1
RESTORE Huff1
FOR I = 1 TO 16
READ X
PutChar FileNo, X
FOR J = 1 TO X
READ Y
NEXT
NEXT
RESTORE Huff1
FOR I = 1 TO 16
READ X
FOR J = 1 TO X
READ Y
PutChar FileNo, Y
NEXT
NEXT

PutChar FileNo, 16
RESTORE Huff2
FOR I = 1 TO 16
READ X
PutChar FileNo, X
FOR J = 1 TO X
READ Y
NEXT
NEXT
RESTORE Huff2
FOR I = 1 TO 16
READ X
FOR J = 1 TO X
READ Y
PutChar FileNo, Y
NEXT
NEXT

PutChar FileNo, 17
RESTORE Huff3
FOR I = 1 TO 16
READ X
PutChar FileNo, X
FOR J = 1 TO X
READ Y
NEXT
NEXT
RESTORE Huff3
FOR I = 1 TO 16
READ X
FOR J = 1 TO X
READ Y
PutChar FileNo, Y
NEXT
NEXT

'SOF0
PutChar FileNo, 255
PutChar FileNo, 192
JPEG.PutWord FileNo, 8 + 9
PutChar FileNo, 8
JPEG.PutWord FileNo, H
JPEG.PutWord FileNo, W

PutChar FileNo, 3

PutChar FileNo, 1
PutChar FileNo, Sampling(0, 0) * 16 + Sampling(0, 1)
PutChar FileNo, 0
PutChar FileNo, 2
PutChar FileNo, Sampling(1, 0) * 16 + Sampling(1, 1)
PutChar FileNo, 1
PutChar FileNo, 3
PutChar FileNo, Sampling(2, 0) * 16 + Sampling(2, 1)
PutChar FileNo, 1

'SOS

PutChar FileNo, 255
PutChar FileNo, 218
JPEG.PutWord FileNo, 12

PutChar FileNo, 3

PutChar FileNo, 1
PutChar FileNo, &H0
PutChar FileNo, 2
PutChar FileNo, &H11
PutChar FileNo, 3
PutChar FileNo, &H11

PutChar FileNo, 0
PutChar FileNo, 63
PutChar FileNo, 0

END SUB

SUB JPEG.Block.Huffman (B() AS INTEGER, LastDC AS INTEGER, Huff() AS INTEGER, A AS INTEGER, State AS JPEGState)
DIM DC AS INTEGER, I AS INTEGER
DIM C AS INTEGER
DC = B(0) - LastDC
JPEG.DCHuff DC, Huff(), A, State
B(64) = -1

I = 1
DO
C = 0
IF B(I) = 0 THEN

DO
I = I + 1
C = C + 1
LOOP WHILE B(I) = 0
IF I = 64 THEN

JPEG.PutBinString Huff(0, 1, A, 0), Huff(0, 1, A, 1), State
EXIT DO
END IF
WHILE C >= 16

JPEG.PutBinString Huff(&HF0, 1, A, 0), Huff(&HF0, 1, A, 1), State
C = C - 16
WEND

END IF


JPEG.ACHuff C, B(I), Huff(), A, State
I = I + 1
LOOP WHILE I < 64
END SUB

SUB JPEG.Block.Output (B() AS INTEGER, State AS JPEGState, QT() AS INTEGER, Huff() AS INTEGER)

DIM O(0 TO 64) AS INTEGER
State.Position = State.Position + 1
IF State.Position > State.YCount + State.CbCount + State.CrCount THEN State.Position = 1
IF State.Position <= State.YCount THEN
JPEG.Block.Transform B(), O(), QT(), 0
JPEG.Block.Huffman O(), State.YDC, Huff(), 0, State
State.YDC = O(0)
ELSE
JPEG.Block.Transform B(), O(), QT(), 1
IF State.Position <= State.YCount + State.CbCount THEN
JPEG.Block.Huffman O(), State.CbDC, Huff(), 1, State
State.CbDC = O(0)
ELSE
JPEG.Block.Huffman O(), State.CrDC, Huff(), 1, State
State.CrDC = O(0)
END IF
END IF

END SUB

SUB JPEG.Block.Transform (B() AS INTEGER, O() AS INTEGER, QT() AS INTEGER, A AS INTEGER)
DIM U AS INTEGER, V AS INTEGER, X AS INTEGER, Y AS INTEGER
DIM B2(0 TO 7, 0 TO 7) AS SINGLE
DIM T AS SINGLE

FOR V = 0 TO 7: FOR U = 0 TO 7
T = 0
FOR X = 0 TO 7
T = T + B(X, V) * Cosine(X, U)
NEXT X
B2(U, V) = T
NEXT U, V

FOR U = 0 TO 7: FOR V = 0 TO 7
T = 0
FOR Y = 0 TO 7
T = T + B2(U, Y) * Cosine(Y, V)
NEXT Y
T = T / 4
IF U = 0 THEN T = T / SQR(2)
IF V = 0 THEN T = T / SQR(2)
B(U, V) = CINT(T / QT(U, V, A))
NEXT V, U

FOR U = 0 TO 63
O(U) = B(ZigZagX(U), ZigZagY(U))
NEXT

END SUB

FUNCTION JPEG.Category% (X AS INTEGER)
DIM T AS INTEGER, I AS INTEGER
T = ABS(X)
WHILE T
T = T \ 2
I = I + 1
WEND
JPEG.Category = I
END FUNCTION

FUNCTION JPEG.Cb% (R AS INTEGER, G AS INTEGER, B AS INTEGER)

JPEG.Cb = -.1687 * R - .3313 * G + .5 * B

END FUNCTION

FUNCTION JPEG.Cr% (R AS INTEGER, G AS INTEGER, B AS INTEGER)

JPEG.Cr = .5 * R - .4187 * G - .0813 * B

END FUNCTION

SUB JPEG.DCHuff (DC AS INTEGER, Huff() AS INTEGER, A AS INTEGER, State AS JPEGState)
DIM C AS INTEGER
C = JPEG.Category(DC)
JPEG.PutBinString Huff(C, 0, A, 0), Huff(C, 0, A, 1), State
JPEG.PutRightBinString DC + (DC < 0), C, State
END SUB

SUB JPEG.Finish (State AS JPEGState)

DEF SEG = VARSEG(State.Leftover)
IF State.LeftoverBits > 8 THEN
JPEG.PutByte State.FileNo, PEEK(VARPTR(State.Leftover) + 1)
POKE VARPTR(State.Leftover) + 1, State.Leftover AND 255
State.LeftoverBits = State.LeftoverBits - 8
END IF

IF State.LeftoverBits THEN
JPEG.PutByte State.FileNo, PEEK(VARPTR(State.Leftover) + 1) OR (Pow2(8 - State.LeftoverBits) - 1)
END IF
DEF SEG

'EOF marker
PutChar State.FileNo, 255
PutChar State.FileNo, 217

END SUB

SUB JPEG.GenerateHuffmanTable (Huff() AS INTEGER, A AS INTEGER, B AS INTEGER)
DIM S AS LONG, I AS INTEGER, J AS INTEGER, T AS INTEGER
DIM X AS INTEGER, Y AS INTEGER
S = -1

FOR I = 1 TO 16
READ X
FOR J = 1 TO X

IF S = -1 THEN
S = 0
ELSE
S = S + Pow2(T)
END IF


READ Y
IF S AND 32768 THEN Huff(Y, A, B, 0) = CINT(S AND 32767&) OR -32768 ELSE Huff(Y, A, B, 0) = S
Huff(Y, A, B, 1) = I
T = 16 - I

NEXT
NEXT
END SUB

SUB JPEG.Precalc
DIM X AS INTEGER, Y AS INTEGER, T AS INTEGER, Dir AS INTEGER, L AS LONG

L = 1
FOR X = 0 TO 15
Pow2(X) = L
L = L + L
NEXT
FOR Y = 0 TO 7
FOR X = 0 TO 7
Cosine(X, Y) = COS((2 * X + 1) * Y * .1963495)
NEXT X, Y

X = 0: Y = 0
T = 0
Dir = 0
DO
ZigZagX(T) = X
ZigZagY(T) = Y
T = T + 1
IF T = 64 THEN EXIT DO
IF Dir THEN
IF Y = 7 THEN
X = X + 1
Dir = 0
ELSEIF X = 0 THEN
Y = Y + 1
Dir = 0
ELSE
X = X - 1
Y = Y + 1
END IF

ELSE
IF Y = 0 THEN
X = X + 1
Dir = 1
ELSEIF X = 7 THEN
Y = Y + 1
Dir = 1
ELSE
X = X + 1
Y = Y - 1
END IF
END IF
LOOP



END SUB

SUB JPEG.PutBinString (BS AS INTEGER, Length AS INTEGER, State AS JPEGState)
DIM Temp AS INTEGER

Temp = BS
State.Leftover = State.Leftover OR JPEG.Shift(Temp, State.LeftoverBits)
State.LeftoverBits = State.LeftoverBits + Length
IF State.LeftoverBits >= 16 THEN
DEF SEG = VARSEG(State.Leftover)
JPEG.PutByte State.FileNo, PEEK(VARPTR(State.Leftover) + 1)
DEF SEG
JPEG.PutByte State.FileNo, State.Leftover AND 255
State.LeftoverBits = State.LeftoverBits - 16
State.Leftover = Temp
END IF

END SUB

SUB JPEG.PutByte (FileNo AS INTEGER, Byte AS INTEGER)
DIM C AS STRING * 1
C = CHR$(Byte)
PUT FileNo, , C
IF Byte = 255 THEN C = CHR$(0): PUT FileNo, , C
END SUB

SUB JPEG.PutRightBinString (BS AS INTEGER, Length AS INTEGER, State AS JPEGState)

DIM Temp AS LONG
IF Length THEN
Temp = (CLNG(BS) AND Pow2(Length) - 1) * Pow2(16 - Length)
IF Temp AND 32768 THEN Temp = Temp OR -65536
JPEG.PutBinString CINT(Temp), Length, State
END IF

END SUB

SUB JPEG.PutWord (FileNo AS INTEGER, Word AS INTEGER)
DIM C AS STRING * 1
C = CHR$(Word \ 256)
PUT FileNo, , C
C = CHR$(Word AND 255)
PUT FileNo, , C
END SUB

FUNCTION JPEG.Shift% (I AS INTEGER, N AS INTEGER)
DIM T AS LONG

IF N = 0 THEN
JPEG.Shift = I
I = 0
EXIT FUNCTION
END IF
T = CLNG(I) AND 65535

JPEG.Shift = T \ Pow2(N)

T = (T AND (Pow2(N) - 1)) * Pow2((16 - N) AND 15)
IF T AND 32768 THEN I = CINT(T AND 32767&) OR -32768 ELSE I = CINT(T)
END FUNCTION

SUB JPEG.StandardQT (quality AS SINGLE, QT() AS INTEGER)

DIM I AS INTEGER, X AS INTEGER, Y AS INTEGER, T AS INTEGER
RESTORE StandardQT

FOR I = 0 TO 1: FOR Y = 0 TO 7: FOR X = 0 TO 7
READ T

QT(X, Y, I) = T * quality

IF QT(X, Y, I) = 0 THEN QT(X, Y, I) = 1
NEXT X, Y, I

END SUB

FUNCTION JPEG.Y% (R AS INTEGER, G AS INTEGER, B AS INTEGER)

JPEG.Y = .299 * R + .587 * G + .114 * B - 128

END FUNCTION

SUB PutChar (FileNo AS INTEGER, Char AS INTEGER)
DIM C AS STRING * 1
C = CHR$(Char)
PUT FileNo, , C
END SUB
