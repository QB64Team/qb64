CHDIR ".\programs\samples\misc"

DECLARE SUB ripples (waterheight%, dlay!, amplitude!, wavelength!)
DECLARE FUNCTION LoadPcx% (PCX$)
DECLARE SUB DELAY (x!)
'----------------------------------------------------------------------------
'RIPPLES, by Antoni Gual 26/1/2001   agual@eic.ictnet.es
'Simulates water reflection in a SCREEN 13 image
'----------------------------------------------------------------------------
'Who said QBasic is obsolete?
'This is a remake of the popular LAKE Java applet.
'You can experiment with different images and different values of the
'parameters passed to RIPPLES sub.
'----------------------------------------------------------------------------
'PCX Loader modified from Kurt Kuzba.
'Timber Wolf came with PaintShopPro 5, I rescaned it to fit SCREEN13
'----------------------------------------------------------------------------
'WARNING!: PCX MUST be 256 colors and 320x 200.The loader does'nt check it!!
'----------------------------------------------------------------------------
'Use as you want, only give me credit.
'E-mail me to tell me about!
'----------------------------------------------------------------------------
DEFINT A-Z
SCREEN 13: CLS
dummy = LoadPcx("twolf.pcx")
IF dummy THEN PRINT "File twolf.pcx not Found!": END
ripples 150, .1, 2, 1

SUB DELAY (x!)
'Hope it will not freeze at midnight!
T! = TIMER + x!
DO: LOOP UNTIL TIMER > T! OR TIMER < x!
END SUB

FUNCTION LoadPcx (PCX$)
'LOADS A 320x200x256 PCX. Modified from Kurt Kuzba

bseg& = &HA000


F = FREEFILE
OPEN PCX$ FOR BINARY AS #F
IF LOF(F) = 0 THEN CLOSE #F: KILL PCX$: LoadPcx = 1: EXIT FUNCTION

fin& = LOF(1) - 767: SEEK #F, fin&: p$ = INPUT$(768, 1)
p% = 1: fin& = fin& - 1
OUT &H3C8, 0: DEF SEG = VARSEG(p$)
FOR T& = SADD(p$) TO SADD(p$) + 767: OUT &H3C9, PEEK(T&) \ 4: NEXT


SEEK #F, 129: T& = BOFS&: RLE% = 0
DO
    p$ = INPUT$(256, F): fpos& = SEEK(F): l% = LEN(p$)
    IF fpos& > fin& THEN l% = l% - (fpos& - fin&): done = 1
    FOR p& = SADD(p$) TO SADD(p$) + l% - 1
        DEF SEG = VARSEG(p$): dat% = PEEK(p&): DEF SEG = bseg&
        IF RLE% THEN
            FOR RLE% = RLE% TO 1 STEP -1:
                POKE T&, dat%: T& = T& + 1
            NEXT
        ELSE
            IF (dat% AND 192) = 192 THEN
                RLE% = dat% AND 63
            ELSE
                POKE T&, dat%: T& = T& + 1
            END IF
        END IF
    NEXT
LOOP UNTIL done
CLOSE F
END FUNCTION

SUB ripples (waterheight, dlay!, amplitude!, wavelength!)
'----------------------------------------------------------------------------
'Ripples SUB, by Antoni Gual  26/1/2001   agual@eic.ictnet.es
'Simulates water reflection in a SCREEN 13 image
'----------------------------------------------------------------------------
'PARAMETERS:
'waterheight     in pixels from top
'dlay!           delay between two recalcs in seconds
'amplitude!      amplitude of the distortion in pixels
'wavelength!     distance between two ripples
'----------------------------------------------------------------------------


'these are screen size constants, don't touch it!
widh = 319
height = 199

REDIM a%(162)
DIM r%(0 TO 200)

'precalc a sinus table for speed
FOR i! = 0 TO 200
    r(i!) = CINT(SIN(i! / wavelength!) * amplitude!)
NEXT
j = 0

'the loop!
DO
    'it must be slowed down to look real!
    DELAY dlay!
   
    FOR i = 1 TO height - waterheight
        temp = waterheight - i + r((j + i) MOD 200)
        GET (1, temp)-(widh, temp), a%()
        PUT (1, waterheight + i), a%(), PSET
    NEXT
    IF j = 200 THEN j = 0 ELSE j = j + 1
LOOP UNTIL LEN(INKEY$)

END SUB

