DIM SHARED X AS INTEGER
DIM SHARED Y AS INTEGER

10 'KEY OFF
15 N = VAL(MID$(TIME$, 7, 2))
20 RANDOMIZE N
30 INPUT "Do you want graphics (Y/N)"; ANS$
40 IF ANS$ = "y" GOTO 70
50 IF ANS$ = "Y" GOTO 70
55 IF ANS$ = "ARIOCH" GOTO 700
60 GOTO 350
70 SCREEN 1: CLS
80  CIRCLE (20, 20), 20
90 PAINT (30, 30), 2, 3
100 CIRCLE (240, 30), 15
110 PAINT (240, 30), 1, 3
120 PSET (60, 125)
130 'DRAW "e100;f100;l199"
140 LINE (360, 125)-(0, 360), , BF
150 PAINT (100, 100), 3
160 LINE (360, 125)-(0, 360), 1, BF
170 LOCATE 16, 19
180 PRINT "   "
190 FOR J = 1 TO 200
200 I = (RND * 360)
210 F = (RND * 120)
220 FOR R = 1 TO 0 STEP -1
230 CIRCLE (I, F), R, 3
240 NEXT
250 NEXT
260 LOCATE 22, 11
270 PRINT "THE TEMPLE OF LOTH"
280 LOCATE 22, 11
290 BEEP
    SLEEP 2
300 FOR X = 200 TO 0 STEP -4
310 CIRCLE (160, 100), X, , , , 1
320 NEXT
330 SCREEN 2
340 SCREEN 0
350 CLS
360 PRINT : COLOR 12, 0, 1
410 PRINT :
420 PRINT
470 PRINT : COLOR 31, 0, 1
480 PRINT "                                 VERSION 4.2"
490 COLOR 3, 0, 1: PRINT "                                July 25, 1984"
500 COLOR 3, 0, 1: PRINT "              Suggested for use with printer and graphics board"
510 PRINT ""
520 PRINT "                               by John Belew"
530 PRINT "                            (Nurruc the Chaotic)"
540 PRINT : COLOR 10, 0, 1
550 PRINT "                         of the Apple Eliminators": COLOR 3, 0, 1
560 SOU = INT(RND * 2 + 1)
570 ON SOU GOTO 580, 600
580 'PLAY "O1MFT155L2DL4EL2FDL1GG#"
    SLEEP 2
590 GOTO 650
600 FOR QWER = 220 TO 196 STEP -1
610 SOUND QWER, 1
620 NEXT
630 'PLAY "O1MLT155L2GP10EP10L1F#"
    SLEEP 2
640 GOTO 650
650 PRINT
660 PRINT "     Make sure that all commands are done in capitals.  For help type `H'."
670 INPUT "                      Do you want instructions (Y/N)"; ANS$
680 IF ANS$ = "Y" GOTO 11570
690 IF ANS$ = "y" GOTO 11570
700 REM
710 REM    ****************************************************
720 REM    *  WRITTEN BY JOHN BELEW FOR USE WITH THE I.B.M.   *
730 REM    *            AND OTHER COMPATIBLE                  *
740 REM    *        THANKS TO TSR FOR THE MONSTERS            *
750 REM    * THANKS TO RECREATIONAL COMPUTING FOR THE ORIGINAL*
760 REM    * PROGRAM          JUNE 29, 1984                   *
770 REM    ****************************************************
780 DEFINT A-Z

790 DIM C$(34), I$(34), R$(4), W$(8), E$(8)
800 DIM L(512), C(3, 4), T(8), O(3), R(3)
'810 DEF FNA (Q) = 1 + INT(RND(1) * Q)
'820 DEF FNB (Q) = Q + 8 * ((Q = 9) - (Q = 0))
'830 DEF FNC (Q) = -Q * (Q < 19) - 18 * (Q > 18)
'840 DEF FND (Q) = 64 * (Q - 1) + 8 * (X - 1) + Y
'850 DEF FNE (Q) = Q + 100 * (Q > 99)
860 COLOR 11, 0, 15: Y$ = "** Please answer yes or no": COLOR 3, 0, 1
870 NG = 0
880 REM
890 REM   INITIALIZE ARRAYS
900 REM
910 NG = NG + 1
920 Q = RND(1)
930 RESTORE
940 FOR Q = 1 TO 34
950 READ C$(Q), I$(Q)
960 NEXT Q
970 FOR Q = 1 TO 512
980 L(Q) = 101
990 NEXT Q
1000 FOR Q = 1 TO 8
1010 READ W$(Q), E$(Q)
1020 NEXT Q
1030 FOR Q = 1 TO 4
1040 READ R$(Q)
1050 NEXT Q
1060 IF NG > 1 GOTO 1420
1070 'INPUT "                   Do you want instructions (Y/N)?";ANS$
1080 'PRINT
1090 'IF ANS$ = "Y" GOTO 12000
1100 'IF ANS$ = "y" GOTO 12000
1110 CLS
1120 PRINT "       ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป"
1130 PRINT "       ฬอออออออออออออออออน"; : COLOR 27, 0, 1: PRINT "* * * THE TEMPLE OF LOTH * * *"; : COLOR 3, 0, 1: PRINT "ฬออออออออออออออออน"
1140 PRINT "       ฬอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออน"
1150 'PRINT  บ                                                                 บ
1160 'PRINT "       บ                                                                 บ
1170 'GOSUB 9060
1180 PRINT "       บ      Many generations ago, during the great Elfin Wars  of the  บ"
1190 PRINT "       บ   first age, there stood the majestic temple of the Drow.  The  บ"
1200 PRINT "       บ   Drow are an evil race of elves dedicated to the  destruction  บ"
1210 PRINT "       บ   of all elves but themselves. During this time they were rul-  บ"
1220 PRINT "       บ   ed by the the evil priestess,Tar-Anclime, a great sorceress.  บ"
1230 PRINT "       บ   Under the aid of her goddess Loth, she created "; : COLOR 11, 0, 1: PRINT "the Amulet of"; : COLOR 3, 0, 1: PRINT "  บ"
1240 PRINT "       บ"; : COLOR 11, 0, 1: PRINT "   Chaos"; : COLOR 3, 0, 1: PRINT " which was to be used to aid her side in the final des-  บ"
1250 PRINT "       บ   truction of their rivals. The Drow massed for The final con-  บ"
1260 PRINT "       บ   flict but they were attacked by their rival forces and there  บ"
1270 PRINT "       บ   they were utterly destroyed. Now thousands of years later it  บ"
1280 PRINT "       บ   is said that in the  kingdom of Rhyl that the descendents of  บ"
1290 PRINT "       บ   the Drow are massing. The Drow plan to return to claim their  บ"
1300 PRINT "       บ   homeland to retrieve "; : COLOR 11, 0, 1: PRINT "the Amulet of Chaos"; : COLOR 3, 0, 1: PRINT " so they can finally  บ"
1310 PRINT "       บ   destroy the elves of good. Living in the village shadowed by  บ"
1320 PRINT "       บ   now crumbling  temple, you have been  chosen to retrieve the  บ"
1330 PRINT "       บ   Amulet  before the Drow  return so that it can be destroyed.  บ"
1340 PRINT "       บ   There are many  dangers that live in the  mazes of the ruins  บ"
1350 PRINT "       บ   such as powerful  and  magic  monsters.  It is even believed  บ"
1360 PRINT "       บ   that the some Drow still live in ruins."; : COLOR 28, 0, 1: PRINT " BEWARE!!!"; : COLOR 3, 0, 1: PRINT "             บ"
1370 'PRINT "       บ                                                                 บ
1380 PRINT "       ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ"
1400 GOTO 1420
1410 PRINT "Wait one moment please while I stock the temple..."
1420 X = 1: Y = 4
1430 L(FND(1)) = 2
1440 FOR Z = 1 TO 7
1450 FOR Q1 = 1 TO 2
1460 Q = 104
1470 GOSUB 10450
1480 L(FND(Z + 1)) = 103
1490 NEXT Q1
1500 NEXT Z
1510 FOR Z = 1 TO 8
1520 FOR Q = 113 TO 124
1530 GOSUB 10450
1540 NEXT Q
1550 FOR Q1 = 1 TO 3
1560 FOR Q = 105 TO 112
1570 GOSUB 10450
1580 NEXT Q
1590 Q = 125
1600 GOSUB 10450
1610 NEXT Q1
1620 NEXT Z
1630 FOR Q = 126 TO 133
1640 Z = FNA(8)
1650 GOSUB 10450
1660 NEXT Q
1670 Q = 101
1680 FOR A = 1 TO 3
1690 Z = FNA(8)
1700 GOSUB 10450
1710 C(A, 1) = X
1720 C(A, 3) = Z
1730 C(A, 2) = Y
1740 C(A, 4) = 0
1750 NEXT A
1760 RC = 0
1770 ST = 2
1780 DX = 8
1790 R$(3) = "Man"
1800 Q = 112 + FNA(12)
1810 Z = FNA(8)
1820 GOSUB 10450
1830 R(1) = X
1840 R(2) = Y
1850 R(3) = Z
1860 Q = 109
1870 Z = FNA(8)
1880 GOSUB 10450
1890 O(1) = X
1900 O(2) = Y
1910 O(3) = Z
1920 BF = 0: OT = 8: AV = 0: HT = 0: T = 1: VF = 0: LF = 0
1930 TC = 0: GP! = 60: RF = 0: OF = 0: BL = 0: IQ = 8: SX = 0
1940 FOR Q = 1 TO 8
1950 T(Q) = 0
1960 NEXT Q
1970 BEEP
1980 CLS
1990 PRINT
2000 PRINT
2010 COLOR 11, 0, 1: PRINT "  You are in large room blinded by a very bright light.  All of the sudden you "
2020 PRINT "hear a booming voice which says, `You have been chosen bold one to be a valiant"
2030 PRINT "and brave  warrior of any race you desire.  You can choose to be an Elf, a Man,"
2040 PRINT "a Dwarf or a Hobbit.' Remember though, you only have 500 turns.": COLOR 3, 0, 1
2050 COLOR 3, 0, 1
2060 GOSUB 10690
2070 FOR Q = 1 TO 4
2080 STR = INT(RND * 10 + 2)
2090 DEX = INT(RND * 10 + 2)
2100 IF LEFT$(R$(Q), 1) = O$ THEN RC = Q: ST = STR * Q: DX = DEX * Q
2110 IF ST > 18 THEN ST = 18
2120 IF DX > 18 THEN DX = 18
2130 NEXT Q
2140 PRINT
2150 OT = OT + 4 * (RC = 1)
2160 IF RC > 0 THEN R$(3) = "Human": GOTO 2190
2170 COLOR 11, 0, 15: PRINT "** That was incorrect. Please type E, D, M, OR H.": COLOR 3, 0, 1
2180 GOTO 2060
2190 PRINT "Which sex do you prefer";
2200 GOSUB 10710
2210 IF O$ = "M" THEN SX = 1: GOTO 2250
2220 IF O$ = "F" GOTO 2250
2230 COLOR 11, 0, 15: PRINT "** Cute "; R$(RC); ", Real cute. Try M OR F.": COLOR 3, 0, 1
2240 GOTO 2190
2250 PRINT
2260 PRINT "OK, "; R$(RC); ", you have the following attributes :"
2270 PRINT "Strength ="; ST
2280 PRINT "Intelligence ="; IQ
2290 PRINT "Dexterity ="; DX
2300 PRINT "and"; OT; "other points you allocate as you wish."
2310 PRINT
2320 Z$ = "Strength"
2330 GOSUB 10740
2340 ST = ST + Q
2350 IF OT = 0 GOTO 2430
2360 Z$ = "Intelligence"
2370 GOSUB 10740
2380 IQ = IQ + Q
2390 IF OT = 0 GOTO 2430
2400 Z$ = "Dexterity"
2410 GOSUB 10740
2420 DX = DX + Q
2430 PRINT "OK, "; R$(RC); ", you find your self at a bazaar in a small village built in the "
2440 PRINT "shadow of a large and crumbling castle.  You have nothing save the clothes on "
2450 PRINT "your back and a purse containing 60gp's to buy your equipments with."
2460 Z$ = "Armor"
2470 GOSUB 10990
2480 AV = 0: WV = 0: FL = 0: WC = 0
2490 PRINT "Plate Mail:30gp's Chainmail:20gp's Leather:10gp's Nothing:-"
2500 GOSUB 10690
2510 IF O$ = "N" GOTO 2570
2520 AV = -3 * (O$ = "P") - 2 * (O$ = "C") - (O$ = "L")
2530 IF AV > 0 GOTO 2570
2540 PRINT
2550 COLOR 11, 0, 15: PRINT "** Are you a "; R$(RC); " or "; C$(FNA(12) + 12); "?": COLOR 3, 0, 1
2560 GOTO 2460
2570 AH = AV * 7: GP! = GP! - AV * 10
2580 PRINT
2590 PRINT "OK, bold "; R$(RC); ", you have"; GP!; "gp's left."
2600 PRINT
2610 Z$ = "Weapons"
2620 GOSUB 10990
2630 PRINT "Sword:30gp's Mace:20gp's Dagger:10gp's Nothing:-"
2640 GOSUB 10690
2650 IF O$ = "N" GOTO 2710
2660 WV = -3 * (O$ = "S") - 2 * (O$ = "M") - (O$ = "D")
2670 IF WV > 0 GOTO 2710
2680 PRINT
2690 COLOR 11, 0, 15: PRINT "** Is your IQ really"; IQ; "?": COLOR 3, 0, 1
2700 GOTO 2610
2710 GP! = GP! - WV * 10
2720 IF GP! < 20 GOTO 2780
2730 PRINT
2740 PRINT "Do you want to buy a lamp for 20gp's";
2750 GOSUB 10710
2760 IF O$ = "Y" THEN LF = 1: GP! = GP! - 20: GOTO 2780
2770 IF O$ <> "N" THEN PRINT : PRINT Y$: PRINT : GOTO 2740
2780 PRINT
2790 IF GP! < 1 THEN Q = 0: GOTO 2900
2800 PRINT "OK, "; R$(RC); ", you have"; GP!; "gold pieces left."
2810 PRINT
2820 INPUT "Flares give off light which allows you to see all the rooms around you.  At a   cost of 1gp each how many do you want to buy?"; O$
2830 Q = VAL(O$)
2840 PRINT
2850 IF Q > 0 OR ASC(O$) = 48 GOTO 2890
2860 COLOR 11, 0, 15: PRINT "** If you don't want any, just type 0.": COLOR 3, 0, 1
2870 PRINT
2880 GOTO 2820
2890 COLOR 11, 0, 15: IF Q > GP! THEN PRINT "** You can only afford"; GP!; ".": COLOR 3, 0, 1: PRINT : GOTO 2820
2900 FL = FL + Q: GP! = GP! - Q
2910 X = 1: Y = 4: Z = 1
2920 COLOR 27, 0, 15: PRINT "OK, "; R$(RC); ", You are now entering the castle!": COLOR 3, 0, 1:
2930 GOTO 6370
2940 REM
2950 REM   MAIN PROCESSING LOOP
2960 REM
2970 T = T + 1
2980 IF RF + OF > 0 GOTO 3110
2990 IF C(1, 4) > T(1) THEN T = T + 1
3000 IF C(2, 4) > T(3) THEN GP! = GP! - FNA(5)
3010 IF GP! < 0 THEN GP! = 0
3020 IF C(3, 4) <= T(5) GOTO 3110
3030 A = X: B = Y: C = Z
3040 X = FNA(8): Y = FNA(8): Z = FNA(8)
3050 L(FND(Z)) = FNE(L(FND(Z))) + 100
3060 X = A: Y = B: Z = C
3070 IF L(FND(Z)) <> 1 GOTO 3110
3080 FOR Q = 1 TO 3
3090 C(Q, 4) = -(C(Q, 1) = X) * (C(Q, 2) = Y) * (C(Q, 3) = Z)
3100 NEXT Q
3110 IF FNA(5) > 1 GOTO 3610
3120 PRINT
3130 PRINT "You ";
3140 Q = FNA(7) + BL
3150 IF Q > 7 THEN Q = 4
3160 ON Q GOSUB 3460, 3200, 3440, 3180, 3480, 3510, 3530
3170 GOTO 3610
3180 PRINT "stepped on dragon @#*%!"
3190 RETURN
3200 PRINT "hear ";
3210 ON FNA(4) GOTO 3220, 3280, 3360, 3390
3220 PRINT "a scream!"
3230 FOR I = 2075 TO 1800 STEP -1
3240 SOUND I, .001
3250 NEXT
3260 SOUND 32729, 1
3270 RETURN
3280 PRINT "footsteps!"
3290 'FOR I=1 TO 5
3300 FOR J = 40 TO 37 STEP -1
3310 SOUND J, 1
3320 SOUND 32729, 10
3330 'NEXT
3340 NEXT
3350 RETURN
3360 PRINT "a Wumpus!"
3370 'PLAY "O0MST255L4AGP5AGP5AGP5AG"
     SLEEP 2
3380 RETURN
3390 PRINT "groans!"
3400 FOR I = 300 TO 37 STEP -1
3410 SOUND I, .1
3420 NEXT
3430 RETURN
3440 PRINT "sneezed!"
3450 RETURN
3460 PRINT "see a bat fly by!"
3470 RETURN
3480 PRINT "hear a "; C$(12 + FNA(13)); " growling!"
3490 GOTO 3400
3500 RETURN
3510 PRINT "feel like you're being watched!"
3520 RETURN
3530 PRINT "hear faint rustling noises!"
3540 FOR Q = 1 TO 200
3550 A = INT(RND * 50 + 37)
3560 SOUND A, .001
3570 'SOUND 32729,1
3580 NEXT
3590 SOUND 32729, 1
3600 RETURN
3610 IF BL + T(4) <> 2 GOTO 3650
3620 PRINT
3630 PRINT C$(29); " cures your blindness!"
3640 BL = 0
3650 IF BF + T(6) <> 2 GOTO 3690
3660 PRINT
3670 PRINT C$(31); " dissolves the book!"
3680 BF = 0
3690 PRINT
3695 PRINT
3700 LOCATE 23, 1: COLOR 3, 0, 1: PRINT "Enter your command:"
3705 FOR ASD = 1 TO 2
3710 LOCATE 23, 20: PRINT "-": SOUND 32767, 1
3720 LOCATE 23, 20: PRINT "\": SOUND 32767, 1
3730 LOCATE 23, 20: PRINT "ณ": SOUND 32767, 1
3740 LOCATE 23, 20: PRINT "/": SOUND 32767, 1
3750 LOCATE 23, 20: PRINT "-": SOUND 32767, 1
3760 LOCATE 23, 20: PRINT "\": SOUND 32767, 1
3770 LOCATE 23, 20: PRINT "ณ": SOUND 32767, 1
3780 LOCATE 23, 20: PRINT "/": SOUND 32767, 1
3790 LOCATE 23, 20: PRINT "-"; : SOUND 32767, 1
3791 'LINE INPUT O$
3792 NEXT
3795 LINE INPUT O$
3800 IF LEFT$(O$, 2) = "DR" GOTO 5180
3810 O$ = LEFT$(O$, 1)
3820 IF O$ = "N" GOTO 4300
3830 IF (O$ = "S") OR (O$ = "W") OR (O$ = "E") GOTO 4310
3840 IF O$ = "U" GOTO 4360
3850 IF O$ = "D" GOTO 4390
3860 IF O$ = "Þ" GOTO 10210
3870 IF O$ = "M" GOTO 4440
3880 IF O$ = "F" THEN ON BL + 1 GOTO 4680, 4440
3890 IF O$ = "L" THEN ON BL + 1 GOTO 4940, 4440
3900 IF O$ = "O" GOTO 5370
3910 IF O$ = "Q" GOTO 6240
3920 IF O$ = "G" THEN ON BL + 1 GOTO 5830, 4440
3930 IF O$ = "T" THEN PRINT : ON RF + 1 GOTO 6090, 6130
3940 IF O$ = "#" GOTO 11050
3950 IF O$ = "H" GOTO 3970
3960 GOTO 4280
3970 INPUT "Do you want a hard copy (Y/N)"; HARD$
3980 IF HARD$ = "Y" GOTO 11100
3990 PRINT "ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป"
4000 PRINT "บ"; : COLOR 27, 0, 1: PRINT "   *** TEMPLE OF LOTH'S COMMAND AND INFORMATION SUMMARY ***"; : COLOR 3, 0, 1: PRINT "   บ"
4010  PRINT "ฬออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออน"
4020  PRINT "บ The following commands available are:                        บ"
4030  PRINT "บ                                                              บ"
4040  PRINT "บ H=Help   N=North    S=South   E=East    W=West    U=Up       บ"
4050  PRINT "บ D=Down   DR=Drink   M=Map     F=Flare   L=Lamp    O=Open     บ"
4060  PRINT "บ G=Gaze   T=Teleport Q=Quit    #=Score                        บ"
4070  PRINT "ฬออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออน"
4080  PRINT "บ The contents of the rooms are as follows:                    บ"
4090  PRINT "บ                                                              บ"
4100  PRINT "บ ฮ = empty room      B = book            C = chest            บ"
4110  PRINT "บ D = stairs down     ๏ = entrance/exit    = flares           บ"
4120  PRINT "บ G = gold pieces      = monster         ่ = crystal orb      บ"
4130  PRINT "บ P = magic pool      S = sinkhole        T = treasure         บ"
4140  PRINT "บ U = stairs up       * = Drow            Û = warp/amulet      บ"
4150  PRINT "ฬออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออน"
4160  PRINT "บ The benefits of having treasures are:                        บ"
4170  PRINT "บ                                                              บ"
4180  PRINT "บ RUBY RED - avoid lethargy    PALE PEARL - avoid leech        บ"
4190  PRINT "บ GREEN GEM - avoid forgetting  OPAL EYE - cure blindness      บ"
4200  PRINT "บ BLUE FLAME - dissolves books  NORN STONE - no benefit        บ"
4210  PRINT "บ PALANTIR - no benefit         SILMARIL - no benefit          บ"
4220  PRINT "ฬออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออน"
4230 PRINT
4240 PRINT "Press RETURN when ready to resume, "; R$(RC); ".";
4250 LINE INPUT ""; O$
4260 GOTO 2970
4270 PRINT
4280 COLOR 11, 0, 15: PRINT "** Bold "; R$(RC); ", that wasn't a valid command!": COLOR 3, 0, 1
4290 GOTO 2970
4300 IF L(FND(Z)) = 2 GOTO 9710
4310 X = X + (O$ = "N") - (O$ = "S")
4320 Y = Y + (O$ = "W") - (O$ = "E")
4330 X = FNB(X)
4340 Y = FNB(Y)
4350 GOTO 6370
4360 IF L(FND(Z)) = 3 THEN Z = Z - 1: GOTO 6370
4370 Z$ = "Up"
4380 GOTO 4410
4390 Z$ = "Down"
4400 IF L(FND(Z)) = 4 THEN Z = Z + 1: GOTO 6370
4410 PRINT
4420 COLOR 11, 0, 15: PRINT "** There are no stairs going "; Z$; " from here!": COLOR 3, 0, 1
4430 GOTO 2970
4440 IF BL <> 1 GOTO 4520
4450 PRINT
4460 COLOR 11, 0, 15: PRINT "** You can't see anything "; R$(RC); "!": COLOR 3, 0, 1
4470 GOTO 2970
4480 REM
4490 REM   DISPLAY MAP OF CURRENT CASTLE LEVEL
4500 REM
4510 COLOR 6, 0, 1
4520 PRINT
4530 A = X: B = Y
4540 FOR X = 1 TO 8
4550 FOR Y = 1 TO 8
4560 Q = L(FND(Z))
4570 IF Q > 99 THEN Q = Q - 100: Q = 34: REM TO HIDE ROOMS
4580 COLOR 6, 0, 1: IF X = A AND Y = B THEN PRINT "<"; I$(Q); ">  "; : GOTO 4600: COLOR 3, 0, 1
4590 COLOR 6, 0, 1: PRINT " "; I$(Q); "   "; : COLOR 3, 0, 1
4600 NEXT Y
4610 COLOR 3, 0, 1: PRINT
4620 PRINT
4630 NEXT X
4640 X = A: Y = B
4650 GOTO 4890
4660 COLOR 12, 0, 1: PRINT ") level"; Z: COLOR 3, 0, 1
4670 GOTO 2970
4680 IF FL <> 0 GOTO 4740
4690 COLOR 11, 0, 15: PRINT "** You can't, you're out of flares!": COLOR 3, 0, 1
4700 GOTO 2970
4710 REM
4720 REM   DISPLAY ADJACENT ROOM CONTENTS WITH FLARE
4730 REM
4740 PRINT
4750 FL = FL - 1
4760 A = X: B = Y
4770 FOR Q1 = A - 1 TO A + 1
4780 X = FNB(Q1)
4790 FOR Q2 = B - 1 TO B + 1
4800 Y = FNB(Q2)
4810 Q = FNE(L(FND(Z)))
4820 L(FND(Z)) = Q
4830 COLOR 12, 0, 1: PRINT " "; I$(Q); "   "; : COLOR 3, 0, 1
4840 NEXT Q2
4850 PRINT
4860 PRINT
4870 NEXT Q1
4880 X = A: Y = B
4890 GOSUB 11020
4900 GOTO 2970
4910 REM
4920 REM   DISPLAY CONTENTS OF ADJACENT ROOM WITH LAMP
4930 REM
4940 IF LF <> 0 GOTO 4980
4950 PRINT
4960 COLOR 11, 0, 15: PRINT "** You don't have a lamp, "; R$(RC); "!": COLOR 3, 0, 1
4970 GOTO 2970
4980 PRINT
4990 PRINT "Where do you want to shine the lamp (N,S,E,W)";
5000 GOSUB 10710
5010 A = X: B = Y
5020 X = FNB(X + (O$ = "N") - (O$ = "S"))
5030 Y = FNB(Y + (O$ = "W") - (O$ = "E"))
5040 IF A - X + B - Y <> 0 GOTO 5080
5050 PRINT
5060 COLOR 11, 0, 15: PRINT "** That's not a direction "; R$(RC); "!": COLOR 3, 0, 1
5070 GOTO 2970
5080 PRINT
5090 PRINT "The lamp shines into ("; X; ","; Y; ") level"; Z; "."
5100 PRINT
5110 L(FND(Z)) = FNE(L(FND(Z)))
5120 PRINT "There you will find "; C$(L(FND(Z))); "."
5130 X = A: Y = B
5140 GOTO 2970
5150 REM
5160 REM   TAKE A DRINK FROM A POOL
5170 REM
5180 IF L(FND(Z)) = 5 GOTO 5220
5190 PRINT
5200 COLOR 11, 0, 15: PRINT "** There is no pool to drink from here!": COLOR 3, 0, 1
5210 GOTO 2970
5220 Q = FNA(8)
5230 PRINT
5240 PRINT "You take a drink and ";
5250 IF Q < 7 THEN PRINT "feel ";
5260 ON Q GOTO 5270, 5280, 5290, 5300, 5310, 5320, 5330, 5350
5270 ST = FNC(ST + FNA(3)): PRINT "stronger.": GOTO 2970
5280 ST = ST - FNA(3): COLOR 15, 0, 0: PRINT "weaker.": COLOR 7, 0, 0: ON (1 - (ST < 1)) GOTO 2880, 9120
5290 IQ = FNC(IQ + FNA(3)): PRINT "smarter.": GOTO 2970
5300 IQ = IQ - FNA(3): COLOR 11, 0, 15: PRINT "dumber.": COLOR 3, 0, 1: ON (1 - (IQ < 1)) GOTO 2970, 9590
5310 DX = FNC(DX + FNA(3)): PRINT "faster.": GOTO 2970
5320 DX = DX - FNA(3): COLOR 11, 0, 15: PRINT "clumsier.": COLOR 3, 0, 1: ON (1 - (DX < 1)) GOTO 2970, 9590
5330 Q = FNA(4): IF Q = RC GOTO 5330
5340 RC = Q: PRINT "become a "; R$(RC); ".": GOTO 2970
5350 SX = 1 - SX: PRINT "turn into a "; : IF SX = 0 THEN PRINT "fe";
5360 PRINT "male "; R$(RC); "!": GOTO 2970
5370 IF L(FND(Z)) <> 6 GOTO 5410
5380 PRINT
5390 PRINT "You open the chest and"
5400 GOTO 5670
5410 IF L(FND(Z)) <> 12 GOTO 5450
5420 PRINT
5430 PRINT "You open the book and"
5440 GOTO 5480
5450 PRINT
5460 COLOR 11, 0, 15: PRINT "** there is nothing to open here.": COLOR 3, 0, 1
5470 GOTO 2970
5480 ON FNA(6) GOTO 5490, 5520, 5540, 5560, 5590, 5620
5490 COLOR 0, 15, 15: CLS : PRINT "Flash! Oh no! you are now a blind "; R$(RC); "!"
5500 BL = 1
5510 GOTO 5650
5520 PRINT "It's another volume of Nurฃcc's poetry! - YECH!!"
5530 GOTO 5650
5540 PRINT "It's an old copy of Play"; R$(FNA(4)); "!"
5550 GOTO 5650
5560 PRINT "It's a manual of dexterity!"
5570 DX = 18
5580 GOTO 5650
5590 PRINT "It's a manual of strength!"
5600 ST = 18
5610 GOTO 5650
5620 COLOR 11, 0, 15: PRINT "The book sticks to your hands -"
5630 PRINT "now you are unable to draw your weapon!": COLOR 3, 0, 1
5640 BF = 1
5650 L(FND(Z)) = 1
5660 GOTO 2970
5670 ON FNA(4) GOTO 5680, 5730, 5770, 5730
5680 PRINT
5690 COLOR 14, 0, 15: PRINT "KABOOM!"; : COLOR 3, 0, 1: PRINT " it explodes!!"
5700 Q = FNA(6)
5710 GOSUB 9490
5720 ON (1 - (ST < 1)) GOTO 5650, 9590
5730 Q = FNA(1000)
5740 PRINT "find"; Q; "gold pieces!"
5750 GP! = GP! + Q
5760 GOTO 5650
5770 PRINT
5780 COLOR 5, 0, 15: PRINT "GAS!!"; : COLOR 3, 0, 1: PRINT "you stagger from the room!"
5790 L(FND(Z)) = 1
5800 T = T + 20
5810 O$ = MID$("NSEW", FNA(4), 1)
5820 GOTO 4310
5830 IF L(FND(Z)) = 11 GOTO 5870
5840 PRINT
5850 COLOR 11, 0, 15: PRINT "**You need an orb to use the gaze command!": COLOR 3, 0, 1
5860 GOTO 2970
5870 PRINT
5880 PRINT "You see ";
5890 ON FNA(6) GOTO 5900, 5920, 5940, 5960, 6030, 6070
5900 PRINT "Yourself in a bloody mess!"
5910 ST = ST - FNA(2): ON (1 - (ST < 1)) GOTO 2970, 9590
5920 PRINT "Yourself drinking from a pool and becoming "; C$(12 + FNA(13)); "!"
5930 GOTO 2970
5940 PRINT C$(12 + FNA(13)); " gazing back at you!"
5950 GOTO 2970
5960 A = X: B = Y: C = Z
5970 X = FNA(8): Y = FNA(8): Z = FNA(8)
5980 Q = FNE(L(FND(Z)))
5990 L(FND(Z)) = Q
6000 PRINT C$(Q); " at ("; X; ","; Y; ") level"; Z; "."
6010 X = A: Y = B: Z = C
6020 GOTO 2970
6030 A = FNA(8): B = FNA(8): C = FNA(8)
6040 IF FNA(8) < 4 THEN A = O(1): B = O(2): C = O(3)
6050 BEEP: COLOR 12, 0, 15: PRINT "The Amulet of Chaos at ("; A; ","; B; ") level"; C; "!": COLOR 3, 0, 1
6060 GOTO 2970
6070 PRINT "a soap opera rerun!"
6080 GOTO 2970
6090 IF RF <> 0 GOTO 6130
6100 PRINT
6110 COLOR 11, 0, 15: PRINT "** You can't teleport without the Runestaff!": COLOR 3, 0, 1
6120 GOTO 2970
6130 Z$ = "X-Coordinate"
6140 GOSUB 10850
6150 X = Q
6160 Z$ = "Y-Coordinate"
6170 GOSUB 10850
6180 Y = Q
6190 Z$ = "Z-Coordinate"
6200 GOSUB 10850
6210 Z = Q
6220 O$ = "T"
6230 GOTO 6370
6240 PRINT
6250 PRINT "Do you really want to quit now?";
6260 GOSUB 10710
6270 PRINT
6280 IF O$ = "Y" GOTO 6310
6290 COLOR 11, 0, 15: PRINT "** Then don't say that you do!": COLOR 3, 0, 1
6300 GOTO 2970
6310 PRINT
6320 GOTO 9870
6330 REM
6340 REM   DISPLAY STATUS INFORMATION
6350 REM
6360 CLS
6370 COLOR 3, 0, 1: PRINT
6380 IF BL = 0 THEN GOSUB 11020: PRINT
6390 LOCATE 24, 1: COLOR 3, 0, 1
6400 PRINT "Strength ="; ST; " Intelligence ="; IQ; " Dexterity ="; DX
6410 PRINT "Treasures ="; TC; " Flares ="; FL; " Gold Pieces ="; GP!
6420 PRINT "Turns ="; T; "  Weapon = "; W$(WV + 1); "  Armor = "; W$(AV + 5);
6430 IF LF = 1 THEN PRINT "  and a lamp"
6440 IF LF = 0 THEN PRINT "   "
6450 JOHN! = IQ * 100 + ST * 100 + DX * 100 + KM! + FTRS + REQ + GP! - T * 5
6460 ' IF JOHN! > 30000 THEN JOHN!=30000
6470 ' IF GP! > 30000 THEN GP!=30000
6480 PRINT "Score ="; JOHN!;
6490 PRINT "  Status = ";
6500 EQUZ = 0
6510 IF BL = 1 THEN PRINT "-Blinded": EQUZ = 1
6520 IF BF = 1 THEN PRINT "-Unable to draw weapon": EQUZ = 1
6530 IF EQUZ = 0 THEN PRINT "-Normal"
6540 MAGICAL = 0
6550 PRINT "You are carrying ";
6560 IF OF = 1 THEN COLOR 12, 0, 1: PRINT "The Amulet of Chaos": COLOR 3, 0, 1: MAGICAL = 1
6570 IF RF = 1 THEN PRINT "The Runestaff": MAGICAL = 1
6580 IF MAGICAL = 0 THEN PRINT "no magical items at the moment"
6590 QXYZ = 0
6600 PRINT "The treasures you carry are ";
6610 FOR Q = 1 TO 8
6620 IF T(Q) = 1 THEN PRINT C$(Q + 25): QXYZ = 1
6630 NEXT Q
6640 IF QXYZ = 0 THEN PRINT "nothing"
6650 IF COME = 1 THEN GOTO 6670
6660 IF T > 500 THEN GOTO 11380
6670 WC = 0
6680 Q = FNE(L(FND(Z)))
6690 L(FND(Z)) = Q
6700 Z$ = "You now have "
6710 PRINT
6720 PRINT "Here you find "; C$(Q); "."
6730 IF (Q < 7) OR (Q = 11) OR (Q = 12) GOTO 2970
6740 IF Q = 7 THEN GP! = GP! + FNA(10): PRINT Z$; GP!; ".": GOTO 5650
6750 IF Q = 8 THEN FL = FL + FNA(5): PRINT Z$; FL; ".": GOTO 5650
6760 IF Q > 9 GOTO 6790
6770 IF (O(1) = X) AND (O(2) = Y) AND (O(3) = Z) THEN ON (1 - (O$ = "T")) GOTO 4310, 10190
6780 X = FNA(8): Y = FNA(8): Z = FNA(8): GOTO 6370
6790 IF Q = 10 THEN Z = FNB(Z + 1): GOTO 6370
6800 IF Q <= 25 OR Q >= 34 GOTO 6860
6810 PRINT
6820 PRINT "It's now yours!"
6830 T(Q - 25) = 1
6840 TC = TC + 1
6850 GOTO 5650
6860 A = L(FND(Z)) - 12
6870 WC = 0
6880 IF (A < 13) OR (VF = 1) GOTO 8070
6890 PRINT
6900 PRINT "You may trade with, attack, or ignore the Drow Merchant."
6910 GOSUB 10690
6920 IF O$ = "I" GOTO 2970
6930 IF O$ <> "A" GOTO 6980
6940 VF = 1
6950 PRINT
6960 COLOR 3, 0, 12: PRINT "You'll be sorry that you did that!"
6970 GOTO 8070
6980 IF O$ = "T" GOTO 7020
6990 PRINT
7000 COLOR 11, 0, 15: PRINT "** Nice shot "; R$(RC); "!": COLOR 3, 0, 1
7010 GOTO 6890
7020 FOR Q = 1 TO 8
7030 A = FNA(Q * 1500)
7040 IF T(Q) = 0 GOTO 7100
7050 PRINT
7060 PRINT "Do you want to sell "; C$(Q + 25); " for "; A; "gp's";
7070 GOSUB 10710
7080 IF O$ = "Y" THEN TC = TC - 1: T(Q) = 0: GP! = GP! + A: GOTO 7100
7090 IF O$ <> "N" THEN PRINT Y$: GOTO 7050
7100 NEXT Q
7110 IF GP! >= 1000 GOTO 7150
7120 PRINT
7130 PRINT "You're too poor to trade, "; R$(RC); "."
7140 GOTO 2970
7150 IF GP! < 1250 GOTO 7650
7160 PRINT
7170 PRINT "OK "; R$(RC); ", you have "; GP!; "gp's and "; W$(AV + 5); " armor."
7180 PRINT
7190 Z$ = "Armor"
7200 GOSUB 10990
7210 PRINT "Nothing:0gp's Leather:1250gp's ";
7220 IF GP! > 1499 THEN PRINT "Chainmail:1500:gp's ";
7230 IF GP! > 1999 THEN PRINT "Plate Mail:2000gp's ";
7240 PRINT
7250 GOSUB 10690
7260 PRINT
7270 IF O$ = "N" GOTO 7400
7280 IF O$ = "L" THEN GP! = GP! - 1250: AV = 1: AH = 7: GOTO 7400
7290 IF O$ <> "C" OR GP! >= 1500 GOTO 7320
7300 COLOR 11, 0, 15: PRINT "** You haven't got that much gold on hand!": COLOR 3, 0, 1
7310 GOTO 7180
7320 IF O$ = "C" THEN GP! = GP! - 1500: AV = 2: AH = 14: GOTO 7400
7330 IF O$ <> "P" OR GP! >= 2000 GOTO 7360
7340 COLOR 11, 0, 15: PRINT "** You can't afford plate mail!": COLOR 3, 0, 1
7350 GOTO 7180
7360 IF O$ = "P" THEN GP! = GP! - 2000: AV = 3: AH = 21: GOTO 7400
7370 PRINT
7380 COLOR 11, 0, 15: PRINT "** Choose a selection.": COLOR 3, 0, 1
7390 GOTO 7240
7400 IF GP! < 1250 GOTO 7650
7410 PRINT
7420 PRINT "You have"; GP!; "gp's left with "; W$(WV + 1); " in hand."
7430 PRINT
7440 Z$ = "Weapon"
7450 GOSUB 10990
7460 PRINT "Nothing:- Dagger:1250gp's";
7470 IF GP! > 1499 THEN PRINT "Mace:1500gp's";
7480 IF GP! > 1999 THEN PRINT "Sword:2000gp's";
7490 PRINT
7500 GOSUB 10690
7510 PRINT
7520 IF O$ = "N" GOTO 7650
7530 IF O$ = "D" THEN GP! = GP! - 1250: WV = 1: GOTO 7650
7540 IF O$ <> "M" OR GP! >= 1500 GOTO 7570
7550 COLOR 11, 0, 15: PRINT "** Sorry sir, I'm afraid I don't give credit!": COLOR 3, 0, 1
7560 GOTO 7430
7570 IF O$ = "M" THEN GP! = GP! - 1500: WV = 2: GOTO 7650
7580 IF O$ <> "S" OR GP! >= 2000 GOTO 7620
7590 COLOR 11, 0, 15: PRINT "** Your Dungeon Express Card - ";
7600 PRINT "You left home without it!": COLOR 3, 0, 1
7610 GOTO 7430
7620 IF O$ = "S" THEN GP! = GP! - 2000: WV = 3: GOTO 7650
7630 COLOR 11, 0, 15: PRINT "** Try choosing a selection!": COLOR 3, 0, 1
7640 GOTO 7490
7650 IF GP! < 1000 GOTO 2970
7660 Z$ = "Strength"
7670 GOSUB 10930
7680 IF O$ <> "Y" GOTO 7740
7690 GP! = GP! - 1000
7700 ST = FNC(ST + FNA(6))
7710 Q = ST
7720 GOSUB 10960
7730 GOTO 7650
7740 IF O$ <> "N" THEN PRINT Y$: GOTO 7660
7750 IF GP! < 1000 GOTO 2970
7760 Z$ = "Intelligence"
7770 GOSUB 10930
7780 IF O$ <> "Y" GOTO 7840
7790 GP! = GP! - 1000
7800 IQ = FNC(IQ + FNA(6))
7810 Q = IQ
7820 GOSUB 10960
7830 GOTO 7750
7840 IF O$ <> "N" THEN PRINT Y$: GOTO 7760
7850 IF GP! < 1000 GOTO 2970
7860 Z$ = "Dexterity"
7870 GOSUB 10930
7880 IF O$ <> "Y" GOTO 7940
7890 GP! = GP! - 1000
7900 DX = FNC(DX + FNA(6))
7910 Q = DX
7920 GOSUB 10960
7930 GOTO 7850
7940 IF O$ <> "N" THEN PRINT Y$: GOTO 7860
7950 IF (GP! < 1000) OR (LF = 1) GOTO 2970
7960 PRINT
7970 PRINT "Do you want to buy a lamp for 1000 gp's";
7980 GOSUB 10710
7990 IF O$ <> "Y" GOTO 8050
8000 GP! = GP! - 1000
8010 LF = 1
8020 PRINT
8030 PRINT "It's guaranteed to outlive you!"
8040 GOTO 2970
8050 IF O$ <> "N" THEN PRINT Y$: GOTO 7960
8060 GOTO 2970
8070 Q1 = 1 + INT(A / 2): Q2 = A + 2: Q3 = 1
8080 IF (C(1, 4) > T(1)) OR (BL = 1) OR (DX < FNA(9) + FNA(9)) GOTO 9100
8090 PRINT
8100 COLOR 3, 0, 12: PRINT "You're confronting "; C$(A + 12); "!"
8110 PRINT
8120 PRINT "You may attack or retreat (strongly suggested!)."
8130 IF Q3 = 1 THEN PRINT "You can also attempt to bribe the creature."
8140 IF IQ > 14 THEN PRINT "You can also cast a spell."
8150 PRINT
8160 PRINT "Your strength is"; ST; "and your dexterity is"; DX; "."
8170 GOSUB 10690
8180 IF O$ <> "A" GOTO 8590
8190 IF WV <> 0 GOTO 8230
8200 PRINT
8210 COLOR 11, 0, 15: PRINT "** Pounding on "; C$(A + 12); " won't hurt it!": COLOR 3, 0, 12
8220 GOTO 9100
8230 IF BF <> 1 GOTO 8270
8240 PRINT
8250 COLOR 11, 0, 15: PRINT "** You can't kill it with a book, so I suggest you either attack or retreat!": COLOR 3, 0, 12
8260 GOTO 9100
8270 IF DX >= FNA(20) + (3 * BL) GOTO 8310
8280 PRINT
8290 PRINT "You barely missed the "; C$(A + 12); "!"
8300 GOTO 9100
8310 Z$ = RIGHT$(C$(A + 12), LEN(C$(A + 12)) - 2)
8320 IF LEFT$(Z$, 1) = " " THEN Z$ = MID$(Z$, 2)
8330 PRINT
8340 PRINT "A valiant blow, you hit the "; Z$; "!"
8350 Q2 = Q2 - WV
8360 IF (A <> 9 AND A <> 12) GOTO 8410
8370 IF FNA(8) <> 1 GOTO 8410
8380 PRINT
8390 COLOR 11, 0, 15: BEEP: BEEP: PRINT "OH NO! Your "; W$(WV + 1); " broke!": BEEP: BEEP: COLOR 3, 0, 12
8400 WV = 0
8410 IF Q2 > 0 GOTO 9100
8420 PRINT
8430 MC = MC - 1
8440 PRINT "You kill "; C$(A + 12); "."
8445 KM! = KM! + 1000
8450 IF H > T - 60 GOTO 8490
8460 PRINT
8470 PRINT "You spend an hour eating "; C$(A + 12); E$(FNA(8)); "."
8480 H = T
8490 IF X <> R(1) OR Y <> R(2) OR Z <> R(3) THEN ON (1 - (A = 13)) GOTO 8540, 10490
8500 PRINT
8510 COLOR 11, 0, 15: BEEP: PRINT "You've found the Runestaff!": BEEP: COLOR 3, 0, 12
8515 FTRS = 10000
8520 R(1) = 0
8530 RF = 1
8540 Q = FNA(1000)
8550 PRINT
8560 PRINT "You now get his hoard of"; Q; "gp's!"
8570 GP! = GP! + Q
8580 GOTO 5650
8590 IF O$ = "R" GOTO 9100
8600 IF O$ <> "C" GOTO 8890
8610 IF IQ >= 15 OR Q3 <= 1 GOTO 8650
8620 PRINT
8630 COLOR 11, 0, 15: PRINT "** You can't cast a spell now!": COLOR 3, 0, 12
8640 GOTO 8090
8650 PRINT
8660 PRINT "Which spell do you wish to cast, Web, Fireball, or Deathspell?";
8670 GOSUB 10710
8680 PRINT
8690 IF O$ <> "W" GOTO 8730
8700 ST = ST - 1
8710 WC = FNA(8) + 1
8720 ON (1 - (ST < 1)) GOTO 9100, 9590
8730 IF O$ <> "F" GOTO 8820
8740 Q = FNA(7) + FNA(7)
8750 ST = ST - 1
8760 IQ = IQ - 1
8770 IF (IQ < 1) OR (ST < 1) GOTO 9590
8780 PRINT "It does"; Q; "points worth of damage."
8790 PRINT
8800 Q2 = Q2 - Q
8810 GOTO 8410
8820 IF O$ = "D" GOTO 8860
8830 PRINT
8840 COLOR 11, 0, 15: PRINT "** Try one of the options given.": COLOR 3, 0, 12
8850 GOTO 8090
8860 PRINT "Death is. . . ";
8870 IF IQ < FNA(4) + 15 THEN PRINT "yours!": IQ = 0: GOTO 9590
8880 PRINT "his!": Q2 = 0: GOTO 8420
8890 IF O$ = "B" AND Q3 <= 1 GOTO 8930
8900 PRINT
8910 COLOR 11, 0, 15: PRINT "** Choose one of the options listed.": COLOR 3, 0, 12
8920 GOTO 8090
8930 IF TC <> 0 GOTO 8970
8940 PRINT
8950 PRINT "All I want is your life!"
8960 GOTO 9100
8970 Q = FNA(8)
8980 IF T(Q) = 0 GOTO 8970
8990 PRINT
9000 PRINT "I want "; C$(Q + 25); ". Will you give it to me?";
9010 GOSUB 10710
9020 IF O$ = "N" GOTO 9100
9030 IF O$ <> "Y" THEN PRINT Y$: GOTO 8990
9040 T(Q) = 0
9050 TC = TC - 1
9060 PRINT
9070 PRINT "OK, just don't tell anyone else."
9080 VF = VF + (L(FND(Z)) = 25)
9090 GOTO 2970
9100 Q3 = 2
9110 IF WC <= 0 GOTO 9140
9120 WC = WC - 1
9130 IF WC = 0 THEN PRINT : PRINT "The web just broke!"
9140 Z$ = RIGHT$(C$(A + 12), LEN(C$(A + 12)) - 2)
9150 IF LEFT$(Z$, 1) = " " THEN Z$ = MID$(Z$, 2)
9160 IF WC <= 0 GOTO 9200
9170 PRINT
9180 PRINT "The "; Z$; " is stuck and can't attack now!"
9190 GOTO 9380
9200 PRINT
9210 PRINT "The "; Z$; " attacks!"
9220 IF DX < FNA(7) + FNA(7) + FNA(7) + 3 * BL GOTO 9330
9230 PRINT
9240 HIT = INT(RND(0) * 2 + 1)
9250 ON HIT GOTO 9260, 9280, 9300
9260 PRINT "The blow barely misses your left leg making sparks a huge dent in the floor!"
9270 GOTO 9380
9280 PRINT "The "; Z$; " charges at you but you dodge out of the way just in time!"
9290 GOTO 9380
9300 PRINT "The "; Z$; " just barely misses your ear!"
9310 GOTO 9380
9320 GOTO 9380
9330 PRINT
9340 COLOR 12, 0, 4: BEEP: PRINT "Thud! The "; Z$; " hit you!": BEEP: COLOR 3, 0, 12
9350 Q = Q1
9360 GOSUB 9490
9370 IF ST < 1 GOTO 9590
9380 IF O$ <> "R" GOTO 8090
9390 PRINT
9400 PRINT "You have escaped!"
9410 PRINT
9420 PRINT "Do you want to go North, South, East, or West?";
9430 GOSUB 10710
9440 IF O$ = "N" OR O$ = "S" OR O$ = "E" OR O$ = "W" GOTO 4310
9450 PRINT
9460 COLOR 11, 0, 15: PRINT "** Don't press your luck, "; R$(RC); "!": COLOR 3, 0, 12
9470 PRINT
9480 GOTO 9420
9490 IF AV = 0 GOTO 9570
9500 Q = Q - AV
9510 AH = AH - AV
9520 IF Q < 0 THEN AH = AH - Q: Q = 0
9530 IF AH >= 0 GOTO 9570
9540 AH = 0: AV = 0
9550 PRINT
9560 PRINT "Your armor is damaged beyond use . . . good luck!"
9570 ST = ST - Q
9580 RETURN
9590 BEEP
9600 GOSUB 10630
9610 COLOR 3, 0, 7: PRINT "A noble effort, oh formerly living "; R$(RC); "!"
9620 PRINT
9630 PRINT "You died due to lack of ";
9640 IF ST < 1 THEN PRINT "Strength."
9650 IF IQ < 1 THEN PRINT "Intelligence."
9660 IF DX < 1 THEN PRINT "Dexterity."
9670 PRINT
9680 Q3 = 1
9690 PRINT "At the time you died, you had :"
9700 GOTO 9920
9710 Q3 = 0
9720 PRINT
9730 PRINT "You left the castle with";
9740 IF OF = 0 THEN PRINT "out";
9750 PRINT " the Amulet of Chaos."
9760 PRINT
9770 IF OF = 0 GOTO 9870
9780 CLS
9790 COLOR 11, 0, 15: PRINT "       Ü   Ü  ÜÜÜ   Ü   Ü       Ü   Ü  Ü  Ü   Ü    Ü  Ü"
9800 PRINT "       ฿ÜÜÜ฿ Û   Û  Û   Û       Û Ü Û  Û  Û฿Ü Û    Û  Û"
9810 PRINT "         Û   ฿ÜÜÜ฿  ฿ÜÜÜ฿        Û Û   Û  Û  ฿Û    Ü  Ü"
9820 PRINT
9830 BEEP: PRINT "An incredibly glorious victory!!!!": BEEP: BEEP: BEEP: COLOR 3, 0, 1
9840 PRINT
9850 PRINT "In addition, you got out with the following:"
9860 GOTO 9910
9870 PRINT
9880 PRINT "A less than awe-inspiring defeat."
9890 PRINT
9900 PRINT "When you left the castle, you had:"
9910 IF Q3 = 0 THEN PRINT "Your miserable life!"
9920 FOR Q = 1 TO 8
9930 IF T(Q) = 1 THEN PRINT C$(Q + 25)
9940 NEXT Q
9950 PRINT W$(WV + 1); " and "; W$(AV + 5);
9960 IF LF = 1 THEN PRINT " and a lamp";
9970 PRINT
9980 PRINT "You also had"; FL; "flares and"; GP!; "gold pieces"
9990 IF RF = 1 THEN PRINT "and the Runestaff"
10000 PRINT "Your score was "; JOHN!
10010 PRINT "And it took you"; T; "turns!"
10020 IF JOHN! < 20000 THEN RANK$ = "a Wimp"
10021 IF JOHN! > 35000! THEN RANK$ = "a Peasant"
10022 IF JOHN! > 50000! THEN RANK$ = "an Amateur"
10023 IF JOHN! > 75000! THEN RANK$ = "a Scout"
10024 IF JOHN! > 90000! THEN RANK$ = "an Adventurer"
10025 IF JOHN! > 110000! THEN RANK$ = "a Hero"
10026 IF JOHN! > 125000! THEN RANK$ = "a Wizard"
10027 IF JOHN! > 140000! THEN GOTO 11999
10040 'GOTO 11290
10050 PRINT "You are ranked as "; RANK$
10051 PRINT
10060 PRINT " Are you foolish enough to want to play again?";
10070 GOSUB 10710
10080 PRINT
10090 IF O$ <> "Y" GOTO 10150
10100 PRINT "Some "; R$(RC); "s never learn!"
10110 PRINT
10120 PRINT "Please be patient while the castle is restocked."
10130 PRINT
10140 GOTO 910
10150 IF O$ <> "N" THEN PRINT Y$: GOTO 10050
10160 PRINT "Maybe dumb "; R$(RC); " is not so dumb after all!"
10170 PRINT
10180 GOTO 11040
10190 PRINT
10200 'PRINT "Great unmitigated Nurฃcc!"
10210 PRINT
10220 COLOR 28, 0, 15: BEEP: BEEP: PRINT "You just found The Amulet of Chaos!": BEEP: BEEP: COLOR 3, 0, 1
10230 ST = 18
10240 IQ = 18
10250 DX = 18
10260 REQ = 20000
10261 BF = 0
10262 BL = 0
10270 PRINT
10280 PRINT "The Runestaff has just disappeared!"
10290 RF = 0
10300 OF = 1
10310 O(1) = 0
10320 GOTO 5650
10330 DATA An empty room,ฮ,the entrance,๏,stairs going up,U
10340 DATA stairs going down,D,a pool,P,a chest,C,gold pieces,G
10350 DATA flares,,a warp,Û,a sinkhole,S,a Crystal Orb,่
10360 DATA a book,B,a Green Slime,ฒ,an Orc,,an Evil Dwarf,,a Goblin,,a Mind Flayer,
10370 DATA a Troll,,a Giant spider,,a Minotar,,a Drow,*,a Drider,
10380 DATA a Balor Demon,,a Red Dragon,๋,a Drow Merchant,๊,the Ruby Red,T
10390 DATA the Norn Stone,T,the Pale Pearl,T,the Opal Eye,T
10400 DATA the Green Gem,T,the Blue Flame,T,the Palantir,T,the Silmaril,T
10410 DATA X,"?",no weapon," Sandwich"
10420 DATA Dagger," stew",Mace," soup",Sword," burger",No armor," roast"
10430 DATA Leather," filet",Chainmail," taco",Plate mail," pie"
10440 DATA Hobbit,Elf,Man,Dwarf
10450 X = FNA(8): Y = FNA(8)
10460 IF L(FND(Z)) <> 101 GOTO 10450
10470 L(FND(Z)) = Q
10480 RETURN
10490 PRINT
10500 PRINT "You get all his wares :"
10510 PRINT "Plate mail"
10520 AV = 3: AH = 21
10530 PRINT "A sword"
10540 WV = 3
10550 PRINT "A strength potion"
10560 ST = FNC(ST + FNA(6))
10570 PRINT "An intelligence potion"
10580 IQ = FNC(IQ + FNA(6))
10590 PRINT "A dexterity potion"
10600 DX = FNC(DX + FNA(6))
10610 IF LF = 0 THEN PRINT "A lamp": LF = 1
10620 GOTO 8540
10630 FOR Q = 1 TO 64
10640 PRINT "*";
10650 NEXT Q
10660 PRINT
10670 PRINT
10680 RETURN
10690 PRINT
10700 PRINT "Your choice";
10710 INPUT O$
10720 O$ = LEFT$(O$, 1)
10730 RETURN
10740 PRINT "How many points do you wish to add to your "; Z$;
10750 INPUT O$
10760 PRINT
10770 Q = VAL(O$)
10780 IF Q = 0 AND ASC(O$) <> 48 THEN Q = -1
10790 IF Q < 0 OR Q > OT OR Q <> INT(Q) THEN PRINT "** "; : GOTO 10740
10800 OT = OT - Q
10810 RETURN
10820 INPUT O$
10830 Q = INT(VAL(O$))
10840 RETURN
10850 PRINT
10860 PRINT Z$;
10870 INPUT O$
10880 Q = INT(VAL(O$))
10890 IF Q > 0 AND Q < 9 THEN RETURN
10900 PRINT
10910 COLOR 11, 0, 15: PRINT "** Try a number from 1 to 8.": COLOR 3, 0, 1
10920 GOTO 10850
10930 PRINT
10940 PRINT "Do you want to buy a potion of "; Z$; " for 1000 gp's";
10950 GOTO 10710
10960 PRINT
10970 PRINT "Your "; Z$; " is now"; Q; "."
10980 RETURN
10990 PRINT
11000 PRINT "These are the types of "; Z$; " you can buy :"
11010 RETURN
11020 COLOR 2, 0, 1: PRINT "You are at ("; X; ","; Y; ") level"; Z; ".": COLOR 3, 0, 1
11030 RETURN
11040 SYSTEM
11050 LET JOHN! = ST + IQ + DX + GP! - T
11060 PRINT
11070 PRINT "Your score at this time is "; JOHN!
11080 PRINT
11090 GOTO 3690

11100
      OPEN "help.txt" FOR OUTPUT AS #1
      PRINT #1, "*** TEMPLE OF LOTH'S COMMAND AND INFORMATION SUMMARY ***"
11110 PRINT #1,
11120 PRINT #1, "The following commands available are:"
11130 PRINT #1,
11140 PRINT #1, "H=Help   N=North    S=South   E=East    W=West    U=Up"
11150 PRINT #1, "D=Down   DR=Drink   M=Map     F=Flare   L=Lamp    O=Open"
11160 PRINT #1, "G=Gaze   T=Teleport Q=Quit    #=Score"
11170 PRINT #1,
11180 PRINT #1, "The contents of the rooms are as follows:"
11190 PRINT #1,
11200 PRINT #1, "ฮ = empty room      B = book            C = chest"
11210 PRINT #1, "D = stairs down     ๏ = entrance/exit    = flares"
11220 PRINT #1, "G = gold pieces      = monster         ่ = crystal orb"
11230 PRINT #1, "P = magic pool      S = sinkhole        T = treasure"
11240 PRINT #1, "U = stairs up       * = Drow            Û = warp/amulet"
11250 PRINT #1,
11260 PRINT #1,
11270 PRINT #1, "The benefits of having treasures are:"
11280 PRINT #1,
11290 PRINT #1, "RUBY RED - avoid lethargy    PALE PEARL - avoid leech"
11300 PRINT #1, "GREEN GEM - avoid forgetting  OPAL EYE - cure blindness"
11310 PRINT #1, "BLUE FLAME - dissolves books  NORN STONE - no benefit"
11320 PRINT #1, "PALANTIR - no benefit         SILMARIL - no benefit"
11330 PRINT #1,
      CLOSE #1
      PRINT "HELP.TXT created!"
      SLEEP 3
11340 GOTO 3700
11350 END
11360 RF = 1
11370 GOTO 3700
11380 PRINT
11390 COME = 1
11400 PRINT "You hear footsteps...";
11410 SOUND 32767, 28
11420 PRINT "The footsteps get louder!"
11430 SOUND 32767, 28
11440 PRINT "You hear people talking in a strange language."
11450 SOUND 32767, 28
11460 PRINT "Oh, No!! the Drow have returned!!!"
11470 DROW = INT(RND * 100)
11480 IF DROW < 10 GOTO 11530
11490 ST = 0
11500 IQ = 0
11510 DX = 0
11520 GOTO 9600
11530 PRINT
11540 PRINT "You escaped just in time!"
11550 PRINT
11560 GOTO 9760
11570 'CHAIN"TEM-INS.BAS",10

99910 'CLS:KEY OFF:COLOR 3,0,1
   CLS : COLOR 3, 0, 1
   LOCATE 1, 28: COLOR 27, 0, 1: PRINT "Temple of Loth instructions"
   COLOR 3, 0, 1: LOCATE 4, 3
   PRINT "     Temple of Loth is a computerized simulation of one of the most common and       popular fantasy motifs, the lone adventurer's quest with an immense under       ground labyrinth. Each game is separate from all others, so the game is a"
   PRINT "     challenge even after you have won. Each game will result in a win or loss       depending on the player's  skill and luck.  The instruction  which follow       will explain the rules and options of the game."
   COLOR 3, 0, 1: LOCATE 12, 7: PRINT "A. Character Creation"
   'LOCATE 4, 45: PRINT "A. Sex"
   'LOCATE 5, 7: PRINT "C. Points"
   LOCATE 12, 45: PRINT "B. Equipments"
    'LOCATE 5, 7: PRINT "C. Lamps and Flares"
    LOCATE 13, 7: PRINT "C. The Temple"
    LOCATE 13, 45: PRINT "D. Player Commands"
    LOCATE 14, 7: PRINT "E. Magic Spells"
    LOCATE 14, 45: PRINT "F. Treasures, Curses and Such"
    LOCATE 15, 7: PRINT "G. Drow Merchants"
    LOCATE 15, 45: PRINT "H. Monsters and The Runestaff"
    LOCATE 16, 7: PRINT "I. Warps and "; : COLOR 11, 0, 1: PRINT "The Amulet of Chaos ": COLOR 3, 0, 1
    LOCATE 16, 45: PRINT "J. Error Messages"
    LOCATE 17, 7: PRINT "K. Scoring"
    LOCATE 17, 45: PRINT "L. Comments and Suggestions"
    LOCATE 18, 7: PRINT "M. Return to game"
999210 LOCATE 20, 6
    COLOR 11, 0, 1: INPUT "Type in the letter of the section desired then press return"; A$
    A$ = CHR$(ASC(A$) OR &H20)
    IF A$="a" goto 999380
    IF A$="b" goto 999610
    IF A$="c" goto 999870
    IF A$="d" goto 9991190
    IF A$="e" goto 9991650
    IF A$="f" goto 9991770
    IF A$="g" goto 9992060
    IF A$="h" goto 9992160
    IF A$="i" goto 9992290
    IF A$="j" goto 9992390
    IF A$="l" goto 9992470
    IF A$="k" goto 9992600
    IF A$="m" goto 9993000
    PRINT
    COLOR 11, 0, 15: PRINT "Invalid input, try again": COLOR 3, 0, 1
    GOTO 999210
999380 CLS
    COLOR 11, 0, 1
    PRINT "                                  CHARACTER CREATION"
    PRINT : COLOR 3, 0, 1
    PRINT "     At the start of each game you will be asked a number of questions about"
    PRINT "what type of character you will have. You must make the choices as follows:"
    PRINT
    PRINT "RACE     You may be an Elf, Dwarf, Man, or Hobbit. Each score is randomly "
    PRINT "         generated, but bonus and deductions are different for each race."
    PRINT
    PRINT "SEX      You may be a female or male. Both are equal in number of points."
    PRINT "         Be creative in your response."
    PRINT
    PRINT "POINTS   Each character starts with a number of points for the attributes"
    PRINT "         of strength (ST), intelligence (IQ), and dexterity (DX).  In addition,"
    PRINT "         there are some other points you may distribute between these three"
    PRINT "         attributes as you wish."
    PRINT
    PRINT "         Your ST, IQ, and DX may be any number from 1 to 18. If any of the "
    PRINT "         three drop below 1, you have died. For all three attributes, the "
    PRINT "         larger the numerical value, the better. "
    LOCATE 25, 1: INPUT "Press enter to return to main menu"; B$
    GOTO 99910
999610 CLS : COLOR 11, 0, 1
    PRINT "                                   EQUIPMENT"
    PRINT : COLOR 3, 0, 1
    PRINT "    Every character is given 60 gold pieces (gp's), at the beginning of each"
    PRINT "to purchase some of the following items."
    PRINT
    PRINT "ARMOR    You may buy platemail armor for 30 gp's, chainmail for 20 gp's or"
    PRINT "         leather for 10 gp's. You can only wear one suit of armor at a time."
    PRINT "         The more expensive the armor, the more damage it will absorb."
    PRINT
    PRINT "WEAPONS  You may buy a sword for 30 gp's, a mace for 20 gp's, or a dagger for "
    PRINT "         10 gp's. You can only carry a single weapon at a time.  The more ex-"
    PRINT "         pensive the weapon, the more damage it does to the various monsters."
    PRINT
    PRINT "LAMP     If after selecting armor and weapons, you have 20 gp's left , you may"
    PRINT "         buy a lamp for 20 gp's. Having the lamp will allow you to look into"
    PRINT "         an adjacent room without having to enter it."
    PRINT
    PRINT "FLARES   If, after all purchases , you have money left, you may buy flares for"
    PRINT "         1 gp each. Lighting a flare reveals the contents of all the rooms "
    PRINT "         surrounding your current location."
    PRINT
    PRINT "         Once you have equipped your character, you are ready to enter the"
    PRINT "         Temple and begin your quest."
    LOCATE 25, 1: INPUT "Press enter to return to main menu."; B$
    GOTO 99910
999870 CLS : COLOR 11, 0, 1
    PRINT "                                   THE TEMPLE"
    COLOR 3, 0, 1: PRINT
    PRINT  _
"     The temple is arranged in a 8x8x8 three dimensional matrix.  This means     that there are 8 levels with 64 rooms on each level. The temple levels are      are numbered from 1 (the top level) to 8 (the bottom level. Each temple level"
    PRINT " is constructed in a doughnut like fashion, in that the north edge is connect    to the south edge and the east edge is connected to the west edge.  In a sim-   ular fashion, the sinkholes, explain later, on level 8 will "; DROP;  _
" you down"
    PRINT " to level 1. The only room that does not work in this fashion is always locat-   ed at location (1,4) level 1. Going north from this room will take you out of   the temple and end the game."
    PRINT
    PRINT " Each room of the temple will have contents as one of the following."
    PRINT
    PRINT "   ๏ = The entrance / exit room"
    PRINT "   ฮ = An empty room containing nothing"
    PRINT "   U = Stairs going up a level"
    PRINT "   D = Stairs going down a level"
     PRINT "   P = Magic Pool from which you may drink"
     PRINT "   C = A chest you may open."
     PRINT "   B = A book you may open"
     PRINT "   G = From 1 to 10 gold pieces"
     PRINT "    = From 1 to 3 flares"
     PRINT "   Û = A warp to another random location"
     LOCATE 25, 1: INPUT "Press return to continue"; B$
     LOCATE 25, 1: PRINT "                              "
     LOCATE 22, 1
     PRINT "    = A monster (1 of 9 different types)"
     PRINT "   * = A Drow fighter"
     PRINT "   ่ = A crystal orb"
     PRINT "   T = A treasure (1 of 8 in the castle)"
     PRINT "   ฒ = A Green Slime"
     PRINT "   4 = A Red Dragon"
     PRINT
     PRINT "     The letters are the abbreviations for the room contents which are display-  ed whenever you look at a map or light a flare. When you look at a map, the     room you are currently located in is bracketed by < >"
     LOCATE 25, 1: INPUT "Press enter to return to main menu"; B$
     GOTO 99910
9991190 CLS : COLOR 11, 0, 1
     PRINT "                             PLAYER COMMANDS"
     COLOR 3, 0, 1: PRINT
     PRINT "     Whenever the program asks for a command, you must decide what action you    wish to preform. If your choice is not valid, the program will inform you and   allow you to try agian.  The following is a list of commands which the pro-"
     PRINT " gram understands, with a description of their effects and restrictions:"
     PRINT
     PRINT " NORTH   Moves you to the room north from your present position. When go north           from the entrance / exit room, the game terminates. In all cases,              the north edge wraps around from the south."
     PRINT
     PRINT " SOUTH   Moves you to the room south of your present position. In all cases,             the south edge wraps around to the north edge."
     PRINT
     PRINT " EAST    Moves you to the room east of your present position. In all cases, the          east edge wraps around to the west."
     PRINT
     PRINT " WEST    Moves you to the room west of your present position. In all cases, the          west edge wraps around to the east."
     PRINT
     PRINT " UP/DOWN Causes you to ascend/descend stairs. You must be in a room containing           stairs to use this command."
     PRINT
     LOCATE 25, 1: INPUT "Press return to continue"; B$
     LOCATE 25, 1: PRINT "                           "
     LOCATE 22, 1
     PRINT " DRINK   Causes you to take a drink from a magic pool. You may repeat this               command as often as you wish, but you must be in a room with a pool             to use this command."
     PRINT
     PRINT " MAP     Causes a map of the level you are currently on to be printed. All               unexplored  rooms are displayed as `?'.  All other rooms are dis-               played as their one character symbols. You may look at your map at"
     PRINT
     PRINT  _
" FLARE   Cause one of your flares to be lit, revealing the contents of all the           rooms surrounding your current location. Because each edge is joined            to the opposite edge, you will always see nine rooms with your loca-"
     PRINT "         as long as you have some and you are not blind or fighting a monster."
     PRINT
     PRINT  _
" LAMP    Allows you to shine your lamp into any one of the rooms north, south,           east, and west of your current position, revealing the room contents.           Unlike flares, the lamp may be used repeatedly. You may use your lamp"
     PRINT "         at any time as long as you have one, are not blind, and not attacking           a monster."
     PRINT
     PRINT " OPEN    Causes you to open a book or a chest which is in the room with you."
     PRINT
     LOCATE 25, 1: INPUT "Press return to continue"; B$
     LOCATE 25, 1: PRINT "                          "
     LOCATE 22, 1
     PRINT " GAZE    Causes you to gaze into a crystal orb. When you see yourself in a               bloody mess, you lose 1 or 2 points of strength.  When you see the              location of the "; : COLOR 11, 0, 1: PRINT "Amulet of Chaos"; :  _
COLOR 3, 0, 1
     PRINT ", there is only a 50% chance that it "
     PRINT "         is correct. You cannot gaze when you are blind or when you are not in           a room containing a crystal orb."
     PRINT
     PRINT " TELE-   Allows you to teleport directly into a specific room any where in the   PORT    temple. This is the only way you can can enter the room containing              the"; : COLOR 11, 0, 1: PRINT " Amulet of Chaos."; : COLOR 3, 0, 1
     PRINT " You must have the Runestaff to teleport!"
     PRINT
     PRINT " QUIT    Allows you to end the game while you are still in the temple. You will          be asked if you are, in case you change your mind. If you quit, you             will lose the game."
     PRINT
     PRINT " HELP    Causes a summary of available commands, abbreviations used in des-               cribing the contents of rooms, and the benefits of possessing each of            the treasures to be displayed at any time."
     LOCATE 25, 1: INPUT "Press enter to return to main menu"; B$
     GOTO 99910
9991650 CLS : COLOR 11, 0, 2
     PRINT "                      MAGIC SPELLS"
     COLOR 3, 0, 1: PRINT
     PRINT "     When ever your intelligence (IQ) becomes 15 or higher, you gain the option  of casting a magic spell on a monster if you have the very first combat         option. The three spells and there effects are as follows:"
     PRINT
     PRINT " WEB     Traps the monster in a sticky web so that it can't fight back as you            attack it. This spell lasts from 2 to 9 turns and costs you one                 strength (ST) point."
     PRINT
     PRINT " FIRE-   Hits the monster with a ball of flame that causes between 2 and 14      BALL    points worth of damage instantly. It costs one strength points and one          point of intelligence."
     PRINT
     PRINT " DEATH   is a contest of will between the monster and yourself, whoever has              the lower intelligence dies at once. It costs nothing to use, but it             is very risky. Even with an IQ of 18 (the highest possible), you"
     LOCATE 25, 1: INPUT "Press enter to return to main menu"; B$
     GOTO 99910
9991770 CLS : COLOR 11, 0, 1
     PRINT "                       TREASURE, CURSES, AND SUCH"
     COLOR 3, 0, 1: PRINT
     PRINT "     In the temple there are eight randomly placed treasures:"
     PRINT
     PRINT " The Ruby Red - Wards off the curse of lethargy."
     PRINT " The Pale Pearl - Wards off the curse of the leech."
     PRINT " The Opal Eye - Cures blindness."
     PRINT " The Green Gem - Wards off the curse of forgetfulness."
     PRINT " The Blue Flame - Dissolves books stuck to your hands."
     PRINT " The Norn Stone - Has no special power."
     PRINT " The Palantir - Has no special power."
     PRINT " The Silmaril - Has no special power."
      PRINT
     PRINT "     THERE ARE THREE CURSES:"
     PRINT
     PRINT " LETHARGY - This gives the monster the first attack which prevents you from                 bribing him or casting a spell on them."
     PRINT
     PRINT " LEECH - This takes from 1 to 5 gp's from you each turn until you have no gold           left at all!"
     PRINT
     LOCATE 25, 1: INPUT "Press return to continue"; B$
     LOCATE 25, 1: PRINT "                            "
     LOCATE 20, 1
     PRINT " FORGETFULNESS - This causes you to forget what you know about each level of the          temple.  Your map will slowly turn back to all question marks, How-             ever, the contents of the rooms stay the same."
     PRINT
     PRINT "     In addition to nullifying the effects of the curses, the treasures can          also provide protection from two undesirable things which can happen            when you open a book.  These are going blind and which prevent you from"
     PRINT "     seeing your maps, lighting flares, using your lamp, gazing into orbs, and       being informed or your current location, and secondly, having a book            stuck to your hands, which prevents you to draw your weapon to fight"
     LOCATE 25, 1: INPUT "Press enter to return to main menu"; B$
     GOTO 99910
9992060 CLS : COLOR 11, 0, 1
     PRINT "                             DROW MERCHANTS"
     COLOR 3, 0, 1: PRINT
     PRINT  _
"      On every level there are Drow Merchants who sell necessary items at in-     flated prices. Normally, the merchants will make you an offer for every         treasure you have, and then, depending on the amount of gold you have, will"
     PRINT " sell you new armor, a new weapon, a potion of strength, intelligence, and       dexterity (no matter how many potions you buy, the maximum amount for these"
     PRINT " attributes is 18), and a lamp, if you don't already have one. If you chose to   attack the merchant, you will antagonize every one in the temple, and they      will all react as monsters. You will also lose the ability to trade with"
     PRINT " them. Killing a merchant, however, will give you new platemail, a sword, one    of each kind of potion, and a lamp (if you don't already have one, in add-      ition to his hoard of between 1 and 1000 gold pieces. To end hostilities"
     PRINT " and reestablish trading privileges, you must bribe any Merchant Drow in the     castle with the treasure of his choice."
     LOCATE 25, 1: INPUT "Press enter to return to main menu"; B$
     GOTO 99910
9992160 CLS : COLOR 11, 0, 1
     PRINT "                         MONSTERS AND THE RUNESTAFF"
     COLOR 3, 0, 1: PRINT
     PRINT "     There are 12 types of monsters in the temple:"
     PRINT
     PRINT " Green Slime, Orcs, Evil Dwarfs, Goblins, Mind Flayers, Trolls, Giant Spiders    Minotaurs, Driders, Balor Demon, Reds Dragons, and Drow Warriors."
     PRINT
     PRINT "     Please note that each time you strike a Drow Warrior or a Red Dragon,       there is a chance that your weapon will be shattered."
     PRINT
     PRINT  _
"     Each monster possesses a hoard of from 1 to 1000 gp's which you obtain      when you kill a monster. In addition, one of the monsters is also carring The   Runestaff, (you won't know which until one until you kill it). You must have"
     PRINT " The Runestaff to teleport, and when you teleport into the room with The         Amulet of Chaos, The Runestaff will disappear. (You must find your way out of   the temple without it)."
     LOCATE 25, 1: INPUT "Press enter to return to main menu"; B$
     GOTO 99910
9992290 CLS : COLOR 11, 0, 1
     PRINT "                         WARPS AND "; : COLOR 27, 0, 1: PRINT "THE AMULET OF CHAOS"
     COLOR 3, 0, 1: PRINT
     PRINT "      All but one of the rooms donated as `Û' are truly warps. Walking, fall-    ing, or teleporting into one of these warps will cause you to be instantly      transported to anywhere in the temple at random. The one exception to this"
     PRINT " rule is the room containing "; : COLOR 11, 0, 1: PRINT "The Amulet of Chaos"; : COLOR 3, 0, 1: PRINT ". This room is disguised as a"
     PRINT " warp. Walking into this room causes you to move one room further in the same    direction. To actually enter this room, you must teleport in using The Rune-"
     PRINT " staff. At this point, you will acquire "; : COLOR 11, 0, 1: PRINT "The Amulet of Chaos"; : COLOR 3, 0, 1: PRINT ". The Runestaff will"
     PRINT " disappear at this point. Remember, to win the game, you must leave the temple   with the amulet in your possession."
     LOCATE 25, 1: INPUT "Press enter to return to the main menu"; B$
     GOTO 99910
9992390 CLS : COLOR 11, 0, 1
     PRINT "                             ERROR MESSAGES"
     COLOR 3, 0, 1: PRINT
     PRINT "     Anytime you receive a highlighted message with a `**', it means that the     last thing you typed was unacceptable to the program at the time. For in- "
     PRINT " stance "; : COLOR 11, 0, 1: PRINT "** It's hard to gaze without an orb."; : COLOR 3, 0, 1: PRINT ", this means that you tried to"
     PRINT " gaze from a room which did not contain a crystal orb. You are always required   to redo your last response when you receive an `**' message."
     LOCATE 25, 1: INPUT "Press enter to return to main menu"; B$
     GOTO 99910
9992470 CLS : COLOR 11, 0, 1
     PRINT "                               COMMENTS AND SUGGESTION"
     COLOR 3, 0, 1: PRINT
     PRINT "      I hope that all enjoy this program. If you have any comments or suggest-   ions, please send them to:"
     PRINT
     PRINT "                            John Belew"
     PRINT "                            4329 Lenoso Common"
     PRINT "                            Fremont CA, 94536"
     PRINT
     PRINT "     if you have any ideas to improve this program yourself please do. Upload    your improved version on Wes Meier's RBBS at area code (415) 937-0156."
     PRINT ""
     LOCATE 25, 1: INPUT "Press enter to return to main menu"; B$
     GOTO 99910
9992600 CLS : COLOR 11, 0, 1
     PRINT "                                      SCORING "
     COLOR 3, 0, 1: PRINT
     PRINT "   Each game that you play you will be given a score. The scoring formula goes   as follows:"
     PRINT
     PRINT "     1 point for each gold piece  +  100 times your combined attribute scores"
     PRINT
     PRINT "       + 1000 points for each monster killed  - 5 times the turns played"
     PRINT
     PRINT " Bonus points are scored as follows:"
     PRINT ""
     PRINT "                  5000 for each treasure"
     PRINT "                 10000 for finding the Runestaff"
     PRINT "                 20000 for finding the Amulet of Chaos"
     PRINT ""
     PRINT " You will then be ranked into one of the following classes:"
     PRINT
     PRINT "             0 - 20000  Whimp                  20000 - 35000  Peasent"
     PRINT "         35000 - 50000  Ameteur                50000 - 75000  Scout"
     PRINT "         90000 -110000 Adventurer            110000 -125000  Hero"
     PRINT "        125000 -140000  Wizard                140000+  Lord"
     PRINT ""
     PRINT "  The highest score to date is that of Lord Nurฃcc: 142,498"
     LOCATE 25, 1
     LINE INPUT "Press enter to return to Main Menu"; B$
     GOTO 99910
9993000 CLS
     'CHAIN "Temple",700
     GOTO 700
'---------------------------------------------------------------------------

11999 LOCATE 25, 1: INPUT "Press return to continue."; QWERTYU$
12000 CLS : COLOR 26, 0, 1
12010 PRINT "  ÜÜ   ÜÜ  Ü   Ü  ÜÜ  ÜÜÜ   ÜÜ  ÜÜÜ  Ü  Ü Ü    ÜÜ  ÜÜÜÜÜ Ü  ÜÜ  Ü   Ü  ÜÜ    Ü"
12020 PRINT " Û  ฿ Û  Û ÛÛ  Û Û  ฿ Û  Û Û  Û Û  Û Û  Û Û   Û  Û   Û   Û Û  Û ÛÛ  Û Û  ฿  Û Û"
12030 PRINT " Û    Û  Û Û Û Û Û    ÛÜÜ฿ ÛÜÜÛ Û  Û Û  Û Û   ÛÜÜÛ   Û   Û Û  Û Û Û Û  ฿฿Ü  Û Û"
12040 PRINT " Û  Ü Û  Û Û  ÛÛ Û ฿Û Û ฿Ü Û  Û Û  Û Û  Û Û   Û  Û   Û   Û Û  Û Û  ÛÛ Ü  Û   ฿"
12050 PRINT "  ฿฿   ฿฿  ฿   ฿  ฿฿  ฿  ฿ ฿  ฿ ฿฿฿   ฿฿  ฿฿฿ ฿  ฿   ฿   ฿  ฿฿  ฿   ฿  ฿฿    ฿"
12060 COLOR 3, 0, 1: PRINT
12070 PRINT
12080 PRINT " You have been ranked as a Lord with a score of "; JOHN!
12090 PRINT
12100 IF JOHN! > 142498! THEN PRINT " Don't forget to replace my score on Tem-Ins.Bas"
12200 GOTO 10051


'810 DEF FNA (Q) = 1 + INT(RND(1) * Q)
FUNCTION FNA (Q)
FNA = 1 + INT(RND(1) * Q)
END FUNCTION

'820 DEF FNB (Q) = Q + 8 * ((Q = 9) - (Q = 0))
FUNCTION FNB (Q)
FNB = Q + 8 * ((Q = 9) - (Q = 0))
END FUNCTION

'830 DEF FNC (Q) = -Q * (Q < 19) - 18 * (Q > 18)
FUNCTION FNC (Q)
FNC = -Q * (Q < 19) - 18 * (Q > 18)
END FUNCTION

'840 DEF FND (Q) = 64 * (Q - 1) + 8 * (X - 1) + Y
FUNCTION FND (Q)
FND = 64 * (Q - 1) + 8 * (X - 1) + Y
END FUNCTION

'850 DEF FNE (Q) = Q + 100 * (Q > 99)
FUNCTION FNE (Q)
FNE = Q + 100 * (Q > 99)
END FUNCTION

