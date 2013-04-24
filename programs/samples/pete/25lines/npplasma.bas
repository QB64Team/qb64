'///Non Palette rotated plasma 
'///Relsoft 2003 
'///Compile and see the speed.  Didn't optimize it as much as I want though... 

1 SCREEN 13 
2 DIM Lsin1%(-1024 TO 1024), Lsin2%(-1024 TO 1024), Lsin3%(-1024 TO 1024) 
3 FOR I% = -1024 TO 1024 
4   Lsin1%(I%) = SIN(I% / (128)) * 256      'Play with these values 
5   Lsin2%(I%) = SIN(I% / (64)) * 128       'for different types of fx 
6   Lsin3%(I%) = SIN(I% / (32)) * 64        ';*) 
7   IF I% > -1 AND I% < 256 THEN PALETTE I%, 65536 * (INT(32 - 31 * SIN(I% * 3.14151693# / 128))) + 256 * (INT(32 - 31 * SIN(I% * 3.14151693# / 64))) + (INT(32 - 31 * SIN(I% * 3.14151693# / 32))) 
8 NEXT I% 
9 DEF SEG = &HA000 
10 Dir% = 1 
11 DO 
12    Counter& = (Counter& + Dir%) 
13    IF Counter& > 600 THEN Dir% = -Dir% 
14    IF Counter& < -600 THEN Dir% = -Dir% 
15    Rot% = 64 * (((Counter& AND 1) = 1) OR 1) 
16    StartOff& = 0 
17    FOR y% = 0 TO 199 
18        FOR x% = 0 TO 318 
19            Rot% = -Rot% 
20            C% = Lsin3%(x% + Rot% - Counter&) + Lsin1%(x% + Rot% + Counter&) + Lsin2%(y% + Rot%) 
21            POKE StartOff& + x%, C% 
22        NEXT x% 
23        StartOff& = StartOff& + 320 
24    NEXT y% 
25  LOOP UNTIL INKEY$ <> "" 

