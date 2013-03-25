10 REM *** CAROLS.BAS   A selection of Christmas Carols by Greg Rismoen 12/09/84
20 REM
30 REM Merry Christmas! This was programmed on my own time at home on an IBM-XT.
40 REM Donated to the public domain. All rights reserved. Not for commercial use.
'50 KEY OFF
'60 KEY (1) ON
'70 ON KEY (1) GOSUB 250
80 CLS: INPUT "Are you using a Color Monitor (enter Y or N) ? ", C$
90 IF C$ = "Y" OR C$ = "y" OR C$ = "N" OR C$ = "n" THEN 100 ELSE GOTO 80
100 IF C$ = "N" OR C$ = "n" THEN CC = 0 ELSE CC = 1
110 SCREEN 0: COLOR 7, CC: CLS
120 LOCATE 5, 20
130 PRINT CHR$(201); STRING$(40, 205); CHR$(187)
140 FOR X = 6 TO 17
    150 LOCATE X, 20
    160 PRINT CHR$(186);
    170 LOCATE X, 61
    180 PRINT CHR$(186)
190 NEXT X
200 LOCATE X, 20: PRINT CHR$(200); STRING$(40, 205); CHR$(188)
210 LOCATE 10, 33: PRINT "CHRISTMAS CAROLS"
220 LOCATE 13, 33: PRINT "  presented by"
230 LOCATE 15, 33: PRINT "  Greg Rismoen"
240 GOTO 12910
'250 RETURN 260
260 RESTORE
270 CLS
280 PLAY "MN"
290 LOCATE 1, 2
300 PRINT CHR$(201); STRING$(76, 205); CHR$(187)
310 FOR X = 2 TO 22
    320 LOCATE X, 2
    330 PRINT CHR$(186);
    340 LOCATE X, 79
    350 PRINT CHR$(186)
360 NEXT X
370 LOCATE X, 2: PRINT CHR$(200); STRING$(76, 205); CHR$(188)
380 LOCATE 3, 2: PRINT CHR$(204); STRING$(76, 205); CHR$(185)
390 LOCATE 3, 41: PRINT CHR$(203)
400 LOCATE 23, 41: PRINT CHR$(202)
410 FOR X = 4 TO 22: LOCATE X, 41: PRINT CHR$(186): NEXT X
420 LOCATE 2, 20: PRINT "CHRISTMAS CAROLS   presented by:  Greg Rismoen"
430 LOCATE 4, 5: PRINT "1) THE TWELVE DAYS OF CHRISTMAS"
440 LOCATE 5, 5: PRINT "2) JOY TO THE WORLD"
450 LOCATE 6, 5: PRINT "3) O LITTLE TOWN OF BETHLEHEM"
460 LOCATE 7, 5: PRINT "4) SILENT NIGHT"
470 LOCATE 8, 5: PRINT "5) I HEARD THE BELLS ON XMAS DAY"
480 LOCATE 9, 5: PRINT "6) O COME ALL YE FAITHFUL"
490 LOCATE 10, 5: PRINT "7) GOOD KING WENCESLAS"
500 LOCATE 11, 5: PRINT "8) WE THREE KINGS"
510 LOCATE 12, 5: PRINT "9) GO TELL IT ON THE MOUNTAIN"
520 LOCATE 13, 4: PRINT "10) AWAY IN A MANGER"
530 LOCATE 14, 4: PRINT "11) WHAT CHILD IS THIS?"
540 LOCATE 15, 4: PRINT "12) O COME, LITTLE CHILDREN"
550 LOCATE 16, 4: PRINT "13) O HOLY NIGHT"
560 LOCATE 17, 4: PRINT "14) IT CAME UPON THE MIDNIGHT CLEAR"
570 LOCATE 18, 4: PRINT "15) THE FIRST NOEL"
580 LOCATE 19, 4: PRINT "16) GOD REST YOU MERRY GENTLEMEN"
590 LOCATE 20, 4: PRINT "17) DECK THE HALLS W/BOUGHS OF HOLLY"
600 LOCATE 21, 4: PRINT "18) HARK THE HERALD ANGELS SING"
610 LOCATE 4, 43: PRINT "19) ANGELS WE HAVE HEARD ON HIGH"
620 LOCATE 5, 43: PRINT "20) SHEPHERDS WATCHED THEIR FLOCKS"
630 LOCATE 6, 43: PRINT "21) IT'S BEGINNING TO LOOK LIKE XMAS"
640 LOCATE 7, 43: PRINT "22) WE WISH YOU A MERRY CHRISTMAS"
650 LOCATE 8, 43: PRINT "23) LET IT SNOW! LET IT SNOW!"
660 LOCATE 9, 43: PRINT "24) I'LL BE HOME FOR CHRISTMAS"
670 LOCATE 10, 43: PRINT "25) HOME FOR THE HOLIDAYS"
680 LOCATE 11, 43: PRINT "26) SILVER BELLS"
690 LOCATE 12, 43: PRINT "27) JOLLY OLD SAINT NICHOLAS"
700 LOCATE 13, 43: PRINT "28) JINGLE BELLS"
710 LOCATE 14, 43: PRINT "29) FROSTY THE SNOWMAN"
720 LOCATE 15, 43: PRINT "30) RUDOLPH THE RED-NOSED REINDEER"
730 LOCATE 16, 43: PRINT "31) SLEIGH RIDE"
740 LOCATE 17, 43: PRINT "32) O CHRISTMAS TREE"
750 LOCATE 18, 43: PRINT "33) SANTA CLAUS IS COMING TO TOWN"
760 LOCATE 19, 43: PRINT "34) HERE COMES SANTA CLAUS"
770 LOCATE 20, 43: PRINT "35) HAVE YOURSELF A MERRY CHRISTMAS"
780 LOCATE 21, 43: PRINT "36) TWAS THE NIGHT BEFORE CHRISTMAS"
790 LOCATE 22, 43: PRINT "99) EXIT TO DOS"
800 LOCATE 22, 13: INPUT "SELECT BY NUMBER: ", A$
810 IF A$ = "1" THEN GOTO 1270
820 IF A$ = "2" THEN GOTO 2200
830 IF A$ = "3" THEN GOTO 2540
840 IF A$ = "4" THEN GOTO 2800
850 IF A$ = "5" THEN GOTO 3660
860 IF A$ = "6" THEN GOTO 4790
870 IF A$ = "7" THEN GOTO 5050
880 IF A$ = "8" THEN GOTO 5430
890 IF A$ = "9" THEN GOTO 5690
900 IF A$ = "10" THEN GOTO 5990
910 IF A$ = "11" THEN GOTO 6260
920 IF A$ = "12" THEN GOTO 6440
930 IF A$ = "13" THEN GOTO 6700
940 IF A$ = "14" THEN GOTO 6920
950 IF A$ = "15" THEN GOTO 7140
960 IF A$ = "16" THEN GOTO 7420
970 IF A$ = "17" THEN GOTO 7670
980 IF A$ = "18" THEN GOTO 7890
990 IF A$ = "19" THEN GOTO 8130
1000 IF A$ = "20" THEN GOTO 8290
1010 IF A$ = "21" THEN GOTO 8470
1020 IF A$ = "22" THEN GOTO 8710
1030 IF A$ = "23" THEN GOTO 8850
1040 IF A$ = "24" THEN GOTO 9080
1050 IF A$ = "25" THEN GOTO 9310
1060 IF A$ = "26" THEN GOTO 9620
1070 IF A$ = "27" THEN GOTO 9920
1080 IF A$ = "28" THEN GOTO 10120
1090 IF A$ = "29" THEN GOTO 10420
1100 IF A$ = "30" THEN GOTO 10770
1110 IF A$ = "31" THEN GOTO 11190
1120 IF A$ = "32" THEN GOTO 11470
1130 IF A$ = "33" THEN GOTO 11680
1140 IF A$ = "34" THEN GOTO 11980
1150 IF A$ = "35" THEN GOTO 12270
1160 IF A$ = "36" THEN GOTO 12530
1170 IF A$ = "99" THEN GOTO 13010
1180 CLS
1190 LOCATE 10, 20
1200 COLOR CC, 7
1210 PRINT "YOU HAVE SELECTED AN OPTION THAT DOES NOT APPEAR ON THE MENU"
1220 FOR X = 1 TO 3000: NEXT
1230 COLOR 7, CC
1240 GOTO 260
1250 REM **********************************************************************
1260 REM
1270 CLS: PRINT "THE TWELVE DAYS OF CHRISTMAS": PRINT: PRINT
1280 'music programmed by Lynn Long, lyrics programmed by Greg Rismoen
1290 PRINT "On the first day of Christmas my true love sent to me"
1300 PLAY "T125 O2p4C8C8C4F8F8F4E8F8G8A8B-8G8A4."
1310 PRINT "A partridge in a pear tree."
1320 PLAY "B-8O3C4D8O2B-8A8F8G4F2."
1330 FOR X = 1 TO 4
    1340 IF X = 1 THEN PRINT "On the second day of Christmas my true love sent to me"
    1350 IF X = 2 THEN PRINT "On the third day of Christmas my true love sent to me"
    1360 IF X = 3 THEN PRINT "On the fourth day of Christmas my true love sent to me"
    1370 IF X = 4 THEN PRINT "On the fifth day of Christmas my true love sent to me"
    1380 PLAY "O2C8C8C4F8F8F4E8F8G8A8B-8G8A4."
    1390 GOSUB 1410
1400 NEXT
1410 FOR A = 1 TO X
    1420 IF X = 4 THEN 1540
    1430 IF X = 3 AND A = 1 THEN 2100
    1440 IF X = 3 AND A = 2 THEN 2090
    1450 IF X = 3 AND A = 3 THEN 2080
    1460 IF X = 2 AND A = 1 THEN 2090
    1470 IF X = 2 AND A = 2 THEN 2080
    1480 IF X = 1 THEN GOTO 2080
    1490 PLAY "O3C4O2G8A8B-4"
1500 NEXT
1510 PRINT "And a partridge in a pear tree."
1520 PLAY "A8B-8O3C4D8O2B-8A8F8G4F2."
1530 RETURN
1540 PRINT "Five go-ld rings!"
1550 PLAY "O3C2D2O2B2.O3C1"
1560 PRINT "Four calling birds, three French hens, two turtle doves, "
1570 PRINT "And a partridge in a pear tree."
1580 PLAY "C8O2B-8A8G8F4B-4D4F4G8F8E8D8C4A8B-8O3C4D8O2B-8A8F8G4F2."
1590 FOR X = 1 TO 7
    1600 IF X = 1 THEN PRINT "On the sixth day of Christmas my true love sent to me"
    1610 IF X = 2 THEN PRINT "On the seventh day of Christmas my true love sent to me"
    1620 IF X = 3 THEN PRINT "On the eighth day of Christmas my true love sent to me"
    1630 IF X = 4 THEN PRINT "On the ninth day of Christmas my true love sent to me"
    1640 IF X = 5 THEN PRINT "On the tenth day of Christmas my true love sent to me"
    1650 IF X = 6 THEN PRINT "On the eleventh day of Christmas my true love sent to me"
    1660 IF X = 7 THEN PRINT "On the twelfth day of Christmas my true love sent to me"
    1670 PLAY "O2C8C8C8C8F8F8F4E8F8G8A8B-8G8A2"
    1680 FOR A = 1 TO X
        1690 IF X = 1 THEN GOTO 2110
        1700 IF X = 2 AND A = 1 THEN GOTO 2120
        1710 IF X = 2 AND A = 2 THEN GOTO 2110
        1720 IF X = 3 AND A = 1 THEN GOTO 2130
        1730 IF X = 3 AND A = 2 THEN GOTO 2120
        1740 IF X = 3 AND A = 3 THEN GOTO 2110
        1750 IF X = 4 AND A = 1 THEN GOTO 2140
        1760 IF X = 4 AND A = 2 THEN GOTO 2130
        1770 IF X = 4 AND A = 3 THEN GOTO 2120
        1780 IF X = 4 AND A = 4 THEN GOTO 2110
        1790 IF X = 5 AND A = 1 THEN GOTO 2150
        1800 IF X = 5 AND A = 2 THEN GOTO 2140
        1810 IF X = 5 AND A = 3 THEN GOTO 2130
        1820 IF X = 5 AND A = 4 THEN GOTO 2120
        1830 IF X = 5 AND A = 5 THEN GOTO 2110
        1840 IF X = 6 AND A = 1 THEN GOTO 2160
        1850 IF X = 6 AND A = 2 THEN GOTO 2150
        1860 IF X = 6 AND A = 3 THEN GOTO 2140
        1870 IF X = 6 AND A = 4 THEN GOTO 2130
        1880 IF X = 6 AND A = 5 THEN GOTO 2120
        1890 IF X = 6 AND A = 6 THEN GOTO 2110
        1900 IF X = 7 AND A = 1 THEN GOTO 2170
        1910 IF X = 7 AND A = 2 THEN GOTO 2160
        1920 IF X = 7 AND A = 3 THEN GOTO 2150
        1930 IF X = 7 AND A = 4 THEN GOTO 2140
        1940 IF X = 7 AND A = 5 THEN GOTO 2130
        1950 IF X = 7 AND A = 6 THEN GOTO 2120
        1960 IF X = 7 AND A = 7 THEN GOTO 2110
        1970 PLAY "O3C8C8O2G8A8B-8G8"
    1980 NEXT A
    1990 PRINT "Five go-ld rings!"
    2000 PLAY "O3C2D2O2B..O3C1"
    2010 PRINT "Four calling birds, three French hens, two turtle doves, "
    2020 PRINT "And a Partridge in a pear tree."
    2030 PLAY "C8O2B-8A8G8F4B-4D4F4G8F8E8D8C4A8B-8O3C4D8O2B-8A8F8G4F2."
2040 NEXT X
2050 PRINT "And a Partridge in a pear tree!"
2060 PLAY "T75P4O2A8B-8O3C4D8O2B-8A8F8G4F2."
2070 GOTO 260
2080 PRINT "Two turtle doves,": GOTO 1490
2090 PRINT "Three French hens,": GOTO 1490
2100 PRINT "Four calling birds,": GOTO 1490
2110 PRINT "Six geese a-laying,": GOTO 1970
2120 PRINT "Seven swans a-swimming,": GOTO 1970
2130 PRINT "Eight maids a-milking,": GOTO 1970
2140 PRINT "Nine Ladies dancing,": GOTO 1970
2150 PRINT "Ten Lords a-leaping,": GOTO 1970
2160 PRINT "Eleven pipers piping,": GOTO 1970
2170 PRINT "Twelve drummers drumming,": GOTO 1970
2180 REM **********************************************************************
2190 REM
2200 CLS: PRINT "JOY TO THE WORLD": PRINT
2210 FOR X = 1 TO 3
    2220 IF X = 1 THEN LOCATE 3, 1: PRINT "Joy to the World!"
    2230 IF X = 2 THEN LOCATE 11, 1: PRINT "Joy to the World!"
    2240 IF X = 3 THEN LOCATE 19, 1: PRINT "He rules the World"
    2250 PLAY "O3p4D4C#8.O2B16A4."
    2260 IF X = 1 THEN PRINT "the Lord is come;"
    2270 IF X = 2 THEN PRINT "the Saviour reigns;"
    2280 IF X = 3 THEN PRINT "with truth and grace,"
    2290 PLAY "G8F#4E4D4."
    2300 IF X = 1 THEN PRINT "Let earth re-ceive her King;"
    2310 IF X = 2 THEN PRINT "Let men their songs em-ploy;"
    2320 IF X = 3 THEN PRINT "And makes the na-tions prove"
    2330 PLAY "A8B4.B8O3C#4.C#8D2P16"
    2340 IF X = 1 THEN PRINT "Let ev-'ry heart pre-pare Him room,"
    2350 IF X = 2 THEN PRINT "While fields and floods, rocks, hills and plains"
    2360 IF X = 3 THEN PRINT "The glo-ries of His right-eous-ness,"
    2370 PLAY "D8D8C#8O2B8A8A8.G16F#8O3D8D8C#8O2B8A8A8.G16F#8"
    2380 IF X = 1 THEN PRINT "And heav'n and na-ture sing,"
    2390 IF X = 2 THEN PRINT "Re-peat the sound-ing joy,"
    2400 IF X = 3 THEN PRINT "And won-ders of His love,"
    2410 PLAY "F#8F#8F#8F#8F#16G16A4."
    2420 IF X = 1 THEN PRINT "And heav'n and na-ture sing,"
    2430 IF X = 2 THEN PRINT "Re-peat the sound-ing joy,"
    2440 IF X = 3 THEN PRINT "And won-ders of His love,"
    2450 PLAY "G16F#16E8E8E8E16F#16G4."
    2460 IF X = 1 THEN PRINT "And heav'n and heav-'n and na-ture sing."
    2470 IF X = 2 THEN PRINT "Re-peat, re-peat the sound-ing joy."
    2480 IF X = 3 THEN PRINT "And won-ders, and won-ders of His love."
    2490 PLAY "F#16E16D8O3D4O2B8A8.G16F#8G8F#4E4D2"
2500 NEXT X
2510 GOTO 260
2520 REM **********************************************************************
2530 REM
2540 CLS: PRINT "O LITTLE TOWN OF BETHLEHEM": PRINT
2550 FOR X = 1 TO 4
    2560 IF X = 1 THEN PRINT "O lit-tle town of Beth-le-hem, How still we see thee lie!"
    2570 IF X = 2 THEN LOCATE 8, 1: PRINT "For Christ is born of Ma-ry, and gath-ered all a-bove,"
    2580 IF X = 3 THEN LOCATE 13, 1: PRINT "How silently, how silently, The wondrous gift is giv'n!"
    2590 IF X = 4 THEN LOCATE 18, 1: PRINT "O holy Child of Bethlehem, Descend to us, we pray;"
    2600 PLAY "t120o2p4b4P64B4P64B4A#4B4O3D4C4O2E4A4G4F#8G8A4D4b2."
    2610 IF X = 1 THEN PRINT "Above thy deep and dream-less sleep, the si-lent stars go by;"
    2620 IF X = 2 THEN PRINT "While mor-tals sleep, the an-gels keep Their watch of won-d'ring love."
    2630 IF X = 3 THEN PRINT "So God imparts to human hearts the blessings of His heav'n."
    2640 IF X = 4 THEN PRINT "Cast out our sin and enter in; Be born in us today!"
    2650 PLAY "P64B4P64B4P64B4O3E4D4P64D4C4O2E4A4G4F#8g8b4a4g2."
    2660 IF X = 1 THEN PRINT "Yet in the dark streets shin-eth the ev-er-last-ing Light;"
    2670 IF X = 2 THEN PRINT "O morn-ing stars, to-geth-er Pro-claim the holy birth,"
    2680 IF X = 3 THEN PRINT "No ear may hear His coming, But in this world of sin,"
    2690 IF X = 4 THEN PRINT "We hear the Christmas angels The great glad tidings tell;"
    2700 PLAY "B4P64B4P64B4A4G4F#2P64F#4P64F#4E4f#4g4a4b2."
    2710 IF X = 1 THEN PRINT "The hopes and fears of all the years are met in thee to-night."
    2720 IF X = 2 THEN PRINT "And prais-es sing to God the King, And peace to men on earth!"
    2730 IF X = 3 THEN PRINT "Where meek souls will receive Him still, the dear Christ enters in."
    2740 IF X = 4 THEN PRINT "O come to us, abide with us, our Lord Emmanuel!"
    2750 PLAY "P64B4P64B4P64B4A#4B4O3D4C4O2E4O3e4d4o2g4b4.a8g2."
2760 NEXT X
2770 GOTO 260
2780 REM **********************************************************************
2790 REM
2800 CLS: PRINT "SILENT NIGHT": PRINT
2810 ' Silent Night in harmony - music programmed by Steve Schlich 12/2/84
2820 ' Lyrics and multiple verses programmed by Greg Rismoen   12/09/84
2830 FOR X = 1 TO 5: PRINT
    2840 IF X = 2 GOTO 2920
    2850 IF X = 3 GOTO 2960
    2860 IF X = 4 GOTO 3000
    2870 IF X = 5 GOTO 3040
    2880 PRINT "Silent Night! Holy Night! All is calm, all is bright;"
    2890 PRINT "Round yon Vir-gin Moth-er and Child! Ho-ly In-fant so tender and mild,"
    2900 PRINT "Sleep in heav-en-ly peace, Sleep in heav-en-ly peace."
    2910 GOTO 3160
    2920 PRINT "Silent Night! Holy night! Shepherds quake at the sight!"
    2930 PRINT "Glories stream from heaven afar, Heavenly hosts sing Alleluia."
    2940 PRINT "Christ, the Saviour is born! Christ, the Saviour is born!"
    2950 GOTO 3160
    2960 PRINT "Silent Night! Holiest night! Darkness flies and all is light!"
    2970 PRINT "Shepherds hear the angels sing: Hallelujah! Hail the King!"
    2980 PRINT "Jesus the Saviour is here! Jesus the Saviour is here!"
    2990 GOTO 3160
    3000 PRINT "Silent Night! Holiest Night! Guiding star, O lend thy light"
    3010 PRINT "See the eastern wise men bring Gifts and homage to our King!"
    3020 PRINT "Jesus the Saviour is here! Jesus the Saviour is here!"
    3030 GOTO 3160
    3040 PRINT "Stil-le Nacht, hei-li-ge Nacht!  Al-les schlft, ein-sam wacht?"
    3050 PRINT "Nur das trau-te hoch-hei-li-ge Paar, Hol-der Kna-be mit lok-ki-gem Haar."
    3060 PRINT "Schlaf im himm-li-scher Ruh, Schlaf im himm-li-scher Ruh!"
    3070 GOTO 3160
    3080 REM   PLAY "ML T140 L3 o3; g. a6 g e1"
    3090 REM   PLAY "g. a6 g e1"
    3100 REM   PLAY "o4 d. p6 d o3 b1
    3110 REM   PLAY "o4 c. p6 c o3 g1
    3120 REM   PLAY "o3 a. p6 a o4 c. o3 b6 a g. a6 g e1
    3130 REM   PLAY "o3 a. p6 a o4 c. o3 b6 a g. a6 g e1
    3140 REM   PLAY "o4 d. p6 d f. d6 o3 b o4 c1 e1
    3150 REM   PLAY "o4 c o3 g e g. f6 d c1 c1
    3160 PLAY "ML T250 L24 o3; gegegegegegegegegegegege"
    3170 PLAY "o3afafafaf "
    3180 PLAY "o3gegegegegegegege"
    3190 PLAY "o3ecececececececececececececececececececececececec"
    3200 PLAY "o3gegegegegegegegegegegege "
    3210 PLAY "o3afafafaf "
    3220 PLAY "o3gegegegegegegege"
    3230 PLAY "o3ecececececececececececececececececececececececec"
    3240 PLAY "o4do3fo4do3fo4do3fo4do3fo4do3fo4do3fo4do3fo4do3fo4do3fo4do3fo4do3fo4do3fo4do3fo4do3fo4do3f p12"
    3250 PLAY "o4do3fo4do3fo4do3fo4do3fo4do3fo4do3fo4do3fo4do3f"
    3260 PLAY "o3bgbgbgbgbgbgbgbgbgbgbgbgbgbgbgbgbgbgbgbgbgbgbgbg"
    3270 PLAY "o4co3eo4co3eo4co3eo4co3eo4co3eo4co3eo4co3eo4co3eo4co3eo4co3eo4co3eo4co3eo4co3eo4co3eo4co3e p12"
    3280 PLAY "o4co3eo4co3eo4co3eo4co3eo4co3eo4co3eo4co3eo4co3e"
    3290 PLAY "o3gegegegegegegegegegegegegegegegegegegegegegegege"
    3300 PLAY "o3afafafafafafafafafafafafafafaf p12"
    3310 PLAY "o3afafafafafafafaf "
    3320 PLAY "o4co3ao4co3ao4co3ao4co3ao4co3ao4co3ao4co3ao4co3ao4co3ao4co3ao4co3ao4co3a "
    3330 PLAY "o3bgbgbgbg"
    3340 PLAY "o3afafafafafafafaf"
    3350 PLAY "o3gegegegegegegegegegegege"
    3360 PLAY "o3afafafaf"
    3370 PLAY "o3gegegegegegegege"
    3380 PLAY "o3ecececececececececececececececececececececececec"
    3390 PLAY "o3afafafafafafafafafafafafafafaf p12"
    3400 PLAY "o3afafafafafafafaf "
    3410 PLAY "o4co3ao4co3ao4co3ao4co3ao4co3ao4co3ao4co3ao4co3ao4co3ao4co3ao4co3ao4co3a "
    3420 PLAY "o3bgbgbgbg"
    3430 PLAY "o3afafafafafafafaf"
    3440 PLAY "o3gegegegegegegegegegegege"
    3450 PLAY "o3afafafaf"
    3460 PLAY "o3gegegegegegegege"
    3470 PLAY "o3ecececececececececececececececececececececececec"
    3480 PLAY "o4do3bo4do3bo4do3bo4do3bo4do3bo4do3bo4do3bo4do3bo4do3bo4do3bo4do3bo4do3bo4do3bo4do3bo4do3b p12"
    3490 PLAY "o4do3bo4do3bo4do3bo4do3bo4do3bo4do3bo4do3bo4do3b "
    3500 PLAY "o4fo3bo4fo3bo4fo3bo4fo3bo4fo3bo4fo3bo4fo3bo4fo3bo4fo3bo4fo3bo4fo3bo4fo3b "
    3510 PLAY "o4do3bo4do3bo4do3bo4do3b "
    3520 PLAY "o3bfbfbfbfbfbfbfbf"
    3530 PLAY "o4co3eo4co3eo4co3eo4co3eo4co3eo4co3eo4co3eo4co3eo4co3eo4co3eo4co3eo4co3eo4co3eo4co3eo4co3eo4co3eo4co3eo4co3eo4co3eo4co3eo4co3eo4co3eo4co3eo4co3e"
    3540 PLAY "o4eo3go4eo3go4eo3go4eo3go4eo3go4eo3go4eo3go4eo3go4eo3go4eo3go4eo3go4eo3go4eo3go4eo3go4eo3go4eo3go4eo3go4eo3go4eo3go4eo3go4eo3go4eo3go4eo3go4eo3g"
    3550 PLAY "o4co3eo4co3eo4co3eo4co3eo4co3eo4co3eo4co3eo4co3e"
    3560 PLAY "o3gegegegegegegege"
    3570 PLAY "o3ecececececececec"
    3580 PLAY "o3go2bo3go2bo3go2bo3go2bo3go2bo3go2bo3go2bo3go2bo3go2bo3go2bo3go2bo3go2b"
    3590 PLAY "o3fo2bo3fo2bo3fo2bo3fo2b"
    3600 PLAY "o3do2bo3do2bo3do2bo3do2bo3do2bo3do2bo3do2bo3do2b"
    3610 PLAY "o3co2eo3co2eo3co2eo3co2eo3co2eo3co2eo3co2eo3co2eo3co2eo3co2eo3co2eo3co2eo3co2eo3co2eo3co2eo3co2eo3co2eo3co2eo3co2eo3co2eo3co2eo3co2eo3co2eo3co2eo3co2eo3co2eo3co2eo3co2eo3co2eo3co2eo3co2eo3co2eo3co2eo3co2eo3co2eo3co2e"
3620 NEXT X
3630 GOTO 260
3640 REM **********************************************************************
3650 REM
3660 CLS: PRINT "I HEARD THE BELLS ON CHRISTMAS DAY": PRINT: PRINT
3670 N = 34
3680 L = 6
3690 PLAY "mll64t150o3"
3700 FOR REPEAT = 1 TO 5
    3710 ON REPEAT GOSUB 4130, 4270, 4390, 4510, 4630
    3720 FOR X = 1 TO N
        3730 READ K: READ K$
        3740 FOR M = 1 TO K * L
            3750 PLAY K$
        3760 NEXT M
    3770 NEXT X
    3780 RESTORE 230
3790 NEXT REPEAT
3800 GOTO 4750
3810 DATA 1,o3e-o2b-ge-
3820 DATA 1.5,o3ge-o2b-e-
3830 DATA .5,o3f#e-o2b-o1b-
3840 DATA 1,o3ge-o2b-e-
3850 DATA 1,o3gd-o2b-e
3860 DATA 1.5,o3a-do2b-f
3870 DATA .5,o3gdo2b-o1b-
3880 DATA 1,o3a-do2b-f
3890 DATA 1,o3ae-o2b-f#
3900 DATA 1,o3b-e-o2b-g
3910 DATA 1,o4e-o3go2b-o1b-
3920 DATA 1,o4do3go2b-o1b-
3930 DATA 1,o4co3e-e-o2g
3940 DATA 1.5,o4co3fdo2a-
3950 DATA .5,o3b-fdo2a-,.25,p64
3960 DATA 1,o3b-fdo2a-
3970 DATA 1,o3b-e-e-o2g
3980 DATA 1.5,o3b-e-co2a-
3990 DATA .5,o3a-e-co2a-
4000 DATA 1,o3ge-o2b-e-
4010 DATA 1,o3a-o2b-fo1e-
4020 DATA 1.5,o3go2bgd
4030 DATA .5,o3fo2bgd
4040 DATA 1,o3e-co2gc
4050 DATA 1,o3fe-o2a-c
4060 DATA 1,o3ge-o2b-o1b-
4070 DATA 1,o3a-e-co1a-
4080 DATA 1,o3b-e-o2b-o1g,.25,p64
4090 DATA 1,o4co3e-o2fo1a-
4100 DATA 1.5,o3do2b-fo1b-
4110 DATA .5,o3fdo2a-o1b-
4120 DATA 2,o3e-o2ge-o1e-,.5,p64
4130 ' first verse
4140 '
4150 B$ = "                                        "
4160 TITLE1$ = "I HEARD THE BELLS"
4170 TITLE2$ = " ON CHRISTMAS DAY"
4180 CLS
4190 LOCATE 2, (40 - LEN(TITLE1$)) / 2: PRINT TITLE1$
4200 LOCATE 4, (40 - LEN(TITLE2$)) / 2: PRINT TITLE2$
4210 LOCATE 10
4220 PRINT "I heard the bells on Christmas day"
4230 PRINT: PRINT "Their old familiar carols play"
4240 PRINT: PRINT "And wild and sweet the words repeat"
4250 PRINT: PRINT "Of peace on earth, good will to men"
4260 RETURN
4270 ' second verse
4280 '
4290 LOCATE 10
4300 FOR LN = 1 TO 4
    4310 PRINT B$: PRINT
4320 NEXT LN
4330 '
4340 LOCATE 10: PRINT "I thought how as the day had come"
4350 PRINT: PRINT "The belfries of all Christendom"
4360 PRINT: PRINT "Had roll'd along th'unbroken song"
4370 PRINT: PRINT "Of peace on earth, good will to men"
4380 RETURN
4390 ' third verse
4400 '
4410 LOCATE 10
4420 FOR LN = 1 TO 4
    4430 PRINT B$: PRINT
4440 NEXT LN
4450 '
4460 LOCATE 10: PRINT "And in despair I hung my head"
4470 PRINT: PRINT "`There is no peace on earth,' I said"
4480 PRINT: PRINT "For hate is strong and mocks the song"
4490 PRINT: PRINT "Of peace on earth, good will to men"
4500 RETURN
4510 'fourth verse
4520 '
4530 LOCATE 10
4540 FOR LN = 1 TO 4
    4550 PRINT B$: PRINT
4560 NEXT LN
4570 '
4580 LOCATE 10: PRINT "Then pealed the bells more loud and deep"
4590 PRINT: PRINT "God is not dead nor doth he sleep"
4600 PRINT: PRINT "The wrong shall fail the right prevail"
4610 PRINT: PRINT "With peace on earth, good will to men"
4620 RETURN
4630 ' fifth verse
4640 '
4650 LOCATE 10
4660 FOR LN = 1 TO 4
    4670 PRINT B$: PRINT
4680 NEXT LN
4690 '
4700 LOCATE 10: PRINT "Till ringing singing on its way"
4710 PRINT: PRINT "The world revolved from night to day"
4720 PRINT: PRINT "A voice a chime a chant sublime"
4730 PRINT: PRINT "Of peace on earth, good will to men"
4740 RETURN
4750 FOR X = 1 TO 2000: NEXT
4760 GOTO 260
4770 REM **********************************************************************
4780 REM
4790 CLS: PRINT "O COME, ALL YE FAITHFUL (Adeste Fideles)": PRINT
4800 FOR X = 1 TO 3: PRINT
    4810 IF X = 1 THEN PRINT "O come all ye faith-ful, Joy-ful and tri-um-phant,"
    4820 IF X = 1 THEN PRINT "O come ye, O come ye to Beth-le-hem."
    4830 IF X = 1 THEN PRINT "Come and be-hold Him, Born the King of an-gels,"
    4840 IF X = 1 THEN PRINT "O come, let us a-dore Him, O come, let us a-dore Him,"
    4850 IF X = 1 THEN PRINT "O come, let us a-dore Him, Christ the Lord."
    4860 IF X = 2 THEN PRINT "Sing choirs of angels, Sing in exultation,"
    4870 IF X = 2 THEN PRINT "Sing, all ye citizens of Heav'n above."
    4880 IF X = 2 THEN PRINT "Glo-ry to God--, In-- the-- high-est."
    4890 IF X = 2 THEN PRINT "O come, let us a-dore Him, O come, let us a-dore Him,"
    4900 IF X = 2 THEN PRINT "O come, let us a-dore Him, Christ the Lord."
    4910 IF X = 3 THEN PRINT "Adeste Fideles laeti triumphantes"
    4920 IF X = 3 THEN PRINT "Venite, venite to Bethlehem."
    4930 IF X = 3 THEN PRINT "Natum vedete regem angelorum"
    4940 IF X = 3 THEN PRINT "Venite adoremus, Venite adoremus,"
    4950 IF X = 3 THEN PRINT "Venite adoremus, Dominum."
    4960 PLAY "ML O2p4G8.P8G2D4G4A2D2B4A4B4O3C4O2B2A4G8.P16G2F#4E4F#4"
    4970 PLAY "G4A4B4F#2E4.D16.P32D2.P4O3D2C4O2B4O3C2O2B2A4B4G4"
    4980 PLAY "A4F#4.E8D4G8.P16G4F#4G4A4G2D4B8.P16B4A4B4O3C4O2B2"
    4990 PLAY "A4B4O3C4O2B4A4G4F#2G4O3C4O2B2A4.G16.P32G2."
    5000 PLAY "p8"
5010 NEXT X
5020 GOTO 260
5030 REM **********************************************************************
5040 REM
5050 CLS: PRINT "  GOOD KING WENCESLAS": PRINT
5060 FOR X = 1 TO 5: PRINT
    5070 IF X = 2 GOTO 5160
    5080 IF X = 3 GOTO 5210
    5090 IF X = 4 GOTO 5260
    5100 IF X = 5 GOTO 5310
    5110 PRINT "Good King Wen-ces-las looked out  On the feast of Ste-phen."
    5120 PRINT "When the snow lay 'round a-bout, Deep and crisp and e-ven."
    5130 PRINT "Bright-ly shone the moon that night, Though the frost was cru-el."
    5140 PRINT "When a poor man came in sight, Gath-'ring win-ter fu-el."
    5150 GOTO 5350
    5160 PRINT "Hither, page, and stand by me, if thou know'st it telling."
    5170 PRINT "Yonder peasant, who is he? Where and what his dwelling?"
    5180 PRINT "Sire, he lives a good league hence, underneath the mountain."
    5190 PRINT "Right against the forest fence, by St. Agnes' fountain."
    5200 GOTO 5350
    5210 PRINT "Bring me flesh, and bring me wine, bring me pine logs hither;"
    5220 PRINT "Thou and I will see him dine, when we bear them hither."
    5230 PRINT "Page and monarch, forth they went, forth they went together;"
    5240 PRINT "Through the rude wind's wild lament, and the bitter weather."
    5250 GOTO 5350
    5260 PRINT "Sire, the night is darker now, and the wind blows stronger."
    5270 PRINT "Fails my heart, I know not how, I can go no longer."
    5280 PRINT "Mark my footsteps my good page, tread thou in them boldly."
    5290 PRINT "Thou shalt find the winter's rage freeze thy blood less coldly."
    5300 GOTO 5350
    5310 PRINT "In his master's steps he trod, where the snow lay dinted;"
    5320 PRINT "Heat was in the very sod which the Saint had printed."
    5330 PRINT "Therefore, Christian men, be sure, wealth or rank possessing."
    5340 PRINT "Ye who now will bless the poor, shall yourselves find blessing."
    5350 PLAY "T150o2L4gggaggd2edef#g2g2"
    5360 PLAY "gggaggd2edef#g2g2"
    5370 PLAY "o3dco2babag2edef#g2g2"
    5380 PLAY "ddef#gga2o3dco2bag2o3c2o2g1"
5390 NEXT X
5400 GOTO 260
5410 REM **********************************************************************
5420 REM
5430 CLS: PRINT "WE THREE KINGS": PRINT
5440 FOR X = 1 TO 5: PRINT
    5450 IF X = 1 OR X = 5 THEN GOTO 5460 ELSE GOTO 5530
    5460 IF X = 1 THEN PRINT "We three Kings of O-ri-ent Are;  Bear-ing gifts we trav-erse a-far."
    5470 IF X = 5 THEN PRINT "Glo-rious now be-hold Him a-rise, King, and God, and sac-ri-fice;"
    5480 PLAY "T100O2p4B4A8G4E8F#8G8F#8E4P8B4A8G4E8F#8g8f#8e4p8"
    5490 IF X = 1 THEN PRINT "Field and foun-tain moor and moun-tain, Fol-low-ing yon-der star."
    5500 IF X = 5 THEN PRINT "Heaven sings al-le-lu-ia: Al-le-lu-ia the earth re-plies."
    5510 PLAY "g8.p16g8a8.P16A8B8.P16B8O3D8C8O2B8A8B8A8G4f#8e4p8"
    5520 GOTO 5610
    5530 IF X = 2 THEN PRINT "Born a King on Beth-le-hem's plain, Gold I bring to crown Him a-gain."
    5540 IF X = 3 THEN PRINT "Frank-in-cense to of-fer have I, In-cense owns a De-i-ty nigh:"
    5550 IF X = 4 THEN PRINT "Myrrh is mine; its bit-ter per-fume  Breathes a life of gath-er-ing gloom;"
    5560 PLAY "o2b4a8g4e8f#8g8f#8e4p8b4a8g4e8f#8g8f#8e4p8"
    5570 IF X = 2 THEN PRINT "King for-ev-er, ceas-ing nev-er  O-ver us all to reign."
    5580 IF X = 3 THEN PRINT "Prayer and prais-ing all men rais-ing, Wor-ship Him, God on high."
    5590 IF X = 4 THEN PRINT "Sor-rowing, sigh-ing, bleed-ing, dy-ing, Sealed in the stone cold tomb."
    5600 PLAY "g4g8a4a8b4b8o3d8c8o2b8a8b8a8g4f#8e4p8"
    5610 PRINT "O---Star of won-der, Star of night, Star with roy-al beaut-y bright,"
    5620 PLAY "F#4A2.G8.P16G8P32G4D8G4E8G4P8G8.P16G8P32G4D8G4E8G4P8"
    5630 PRINT "West-ward lead-ing, Still pro-ceed-ing, Guide us to the per-fect light."
    5640 PLAY "g8.p16g8A4B8O3C4O2B8A4B8G8.P16G8P32G4D8G4E8G4."
5650 NEXT X
5660 GOTO 260
5670 REM **********************************************************************
5680 REM
5690 CLS: PRINT "  GO TELL IT ON THE MOUNTAIN  ": PRINT
5700 PRINT "Oh! Go tell it on the moun-tain, o-ver the hills and ev'-- ry-where,"
5710 PLAY "t120o3c2o2a2a8.g16f8.d16c2f2g8g4f8g4f4a8g4a8o3c2"
5720 PRINT "Go tell it on the moun-tain that Je-sus Christ- is born!"
5730 PLAY "o2a2a8.g16f8.d16c2f4b-4a8a4.g8f8g4f1p4"
5740 FOR X = 1 TO 5: PRINT
    5750 IF X = 4 THEN PRINT: PRINT "    Spiritual Verses:": PRINT
    5760 IF X = 1 THEN PRINT "While shep-herds kept their watch-ing, O'er silent flocks by night,"
    5770 IF X = 2 THEN PRINT "The shep-herds feared and trembled, When lo, ab-ove the earth,"
    5780 IF X = 3 THEN PRINT "Down in a lone-ly man-ger, The humble Christ was born."
    5790 IF X = 4 THEN PRINT "When I was a seeker, I sought both night and day,"
    5800 IF X = 5 THEN PRINT "He made me a watch-man up-on the cit-y wall,"
    5810 IF X = 4 OR X = 5 THEN GOTO 5840
    5820 PLAY "t150o2p4a4o3c4c4c4.d8c4o2a2f4g4g4f4g4a2."
    5830 GOTO 5850
    5840 PLAY "t150o2p4a4o3c4c4.d8c4o2a2f4g4g4f4g4a2."
    5850 IF X = 1 THEN PRINT "Be-hold through-out the heav-ens, There shone a Holy light."
    5860 IF X = 2 THEN PRINT "Rang out the angel chorus, That hailed our Saviour's birth."
    5870 IF X = 3 THEN PRINT "And God sent us salvation, That blessed Christmas morn."
    5880 IF X = 4 THEN PRINT "I sought the Lord to help me, and He showed me the way,"
    5890 IF X = 5 THEN PRINT "And if I am a Chris-tian, I am the least of all."
    5900 PLAY "f4a4o3c4c4.d8c4o2a2f4g4g4f4d4c2"
    5910 PRINT "Oh! Go tell it on the moun-tain, o-ver the hills and ev'-- ry-where,"
    5920 PLAY "t120o3c2o2a2a8.g16f8.d16c2f2g8g4f8g4f4a8g4a8o3c2"
    5930 PRINT "Go tell it on the moun-tain that Je-sus Christ- is born!"
    5940 PLAY "o2a2a8.g16f8.d16c2f4b-4a8a4.g8f8g4f1p4"
5950 NEXT X
5960 GOTO 260
5970 REM **********************************************************************
5980 REM
5990 CLS: PRINT "AWAY IN A MANGER": PRINT
6000 FOR X = 1 TO 2: PRINT
    6010 IF X = 1 THEN PRINT "A-way in a man-ger, no crib for a bed,"
    6020 IF X = 2 THEN PRINT "Be near me, Lord Jesus, I ask Thee to stay"
    6030 PLAY "t120o2p4d4g4g4b8a8g4g4d4e4g4e4d2"
    6040 IF X = 1 THEN PRINT "The lit-tle Lord Je-sus laid down His sweet head;"
    6050 IF X = 2 THEN PRINT "Close by me forever, and love me, I pray;"
    6060 PLAY "d4g4g4a4b4b4o3d4d4o2b4g4a2"
    6070 IF X = 1 THEN PRINT "The stars in the- sky look-ing down where He lay,"
    6080 IF X = 2 THEN PRINT "Bless all the dear children in Thy tender care,"
    6090 PLAY "d4g4g4b8a8g4g4d4e4g4e4d2"
    6100 IF X = 1 THEN PRINT "The little Lord Je-sus, a-sleep on the hay."
    6110 IF X = 2 THEN PRINT "And take us to heaven, to live with Thee there."
    6120 PLAY "d4g4g4a4B4o3d4.P64c4o2d4d4f#4g2"
    6130 IF X = 2 THEN GOTO 6230
    6140 PRINT: PRINT "The cat-tle are low-ing the poor Ba-by wakes,"
    6150 PLAY "f#8g8a4a4o3d4o2a4a4f#4a4g4e4d2"
    6160 PRINT "But lit-tle Lord Je-sus no cry-ing- He- makes;"
    6170 PLAY "f#8g8a4a4o3d4o2a4a4f#4g8f#8g8a8b8o3c#8d2"
    6180 PRINT "I love Thee, Lord Je-sus! Look down from the sky,"
    6190 PLAY "o3e4d4o2B4b8a8g4g4d4e4o3c4o2e4d2"
    6200 PRINT "And stay by my cra-dle, 'Till morn-ing is nigh."
    6210 PLAY "d4g4g4a4b4o3d4.c4o2d4d4f#4g2P16"
6220 NEXT X
6230 GOTO 260
6240 REM *********************************************************************
6250 REM
6260 CLS: PRINT "WHAT CHILD IS THIS?": PRINT
6270 FOR X = 1 TO 3: PRINT
    6280 IF X = 1 THEN PRINT "What Child is this,- Who, laid to rest,- On Ma-ry's lap- is sleep-ing?"
    6290 IF X = 2 THEN PRINT "Why lies He in- such mean es-tate- Where ox and ass- are feed-ing?"
    6300 IF X = 3 THEN PRINT "So bring Him in-cense, gold, and myrrh, Come, peas-ant, king- to own Him;"
    6310 PLAY "t90o2p4e8g4a8b8.o3c16o2b8a4f#8d8.e16f#8g4e8e8.d#16e8f#4.o1b4p16"
    6320 IF X = 1 THEN PRINT "Whom an-gels greet- with an-thems sweet,- While shep-herds watch- are keep-ing?"
    6330 IF X = 2 THEN PRINT "Good Chris-tian, fear:- for sin-ners here- The si-lent Word- is plead-ing."
    6340 IF X = 3 THEN PRINT "The King of kings- sal-va-tion brings,- Let lov-ing hearts- en-throne Him."
    6350 PLAY "o2e8g4a8b8.o3c16o2b8a4f#8d8.e16f#8g8.f#16e8d#8.c#16d#8e4.e4.p16"
    6360 PRINT "This, this- is Christ the King,- Whom shep-herds guard- and an-gels sing."
    6370 PLAY "o3d4.d8.c#16o2b8a4f#8d8.e16f#8g4e8e8.d#16e8f#4d#8o1b4."
    6380 PRINT "This, this- is Christ the King,- The Babe,- the Son- of Ma-ry."
    6390 PLAY "o3d4.d8.c#16o2b8a4f#8d8.e16f#8g8.f#16e8d#8.c#16d#8e4.e4.p4"
6400 NEXT X
6410 GOTO 260
6420 REM *********************************************************************
6430 REM
6440 CLS: PRINT "O COME, LITTLE CHILDREN (Ihr Kinderlein Kommet)": PRINT
6450 FOR X = 1 TO 4: PRINT
    6460 IF X = 1 THEN PRINT "O come, little children, O come, one and all!"
    6470 IF X = 2 THEN PRINT "Ihr Kin-der-lein, kom-met, O kom-met doch all!"
    6480 IF X = 3 THEN PRINT "O seht in der Krippe im ncht-lich-en Stall."
    6490 IF X = 4 THEN PRINT "Da liegt es, ach Kinder, auf Heu and auf Stroh,"
    6500 PLAY "t100o2p4G8G4E8G8G4E8G8F4D8F8E4."
    6510 IF X = 1 THEN PRINT "O come to the cradle in Bethlehem's stall!"
    6520 IF X = 2 THEN PRINT "Zur Krip-pe her kom-met in Beth-le-hems Stall!"
    6530 IF X = 3 THEN PRINT "Seht hier bei des Licht-leins hell-gln-zen-dem Strahl:"
    6540 IF X = 4 THEN PRINT "Maria und Joseph be-trach-ten es froh;"
    6550 PLAY "o2G8G4E8G8G4E8G8F4D8F8E4."
    6560 IF X = 1 THEN PRINT "Come look in the manger! There sleeps on the hay,"
    6570 IF X = 2 THEN PRINT "und seht, was in die-ser hoch-hei-li-gen Nacht,"
    6580 IF X = 3 THEN PRINT "In rein-lich-en Win-deln das himm-lis-che Kind,"
    6590 IF X = 4 THEN PRINT "Die red-lich-en Hir-ten knien be-tend da-vor,"
    6600 PLAY "E8D4D8D8F4F8F8E4E8E8A4."
    6610 IF X = 1 THEN PRINT "An infant so lovely, in light bright as day."
    6620 IF X = 2 THEN PRINT "der Va-ter im Him-mel fr Freu-de uns macht."
    6630 IF X = 3 THEN PRINT "Viel sch3n-er und hold-er, als En-gel es sind."
    6640 IF X = 4 THEN PRINT "Hoch ob-en schwebt ju-belnd der En-gel-ein Chor."
    6650 PLAY "A8G4G8G8O3C4O2G8E8F4D8O1B8O2C4.p4"
6660 NEXT X
6670 GOTO 260
6680 REM *********************************************************************
6690 REM
6700 CLS: PRINT "O HOLY NIGHT": PRINT
6710 PRINT "O ho-ly night, the stars are bright-ly shin-ing,"
6720 PLAY "t130o2p4e4.e4e8g2p64g8a4a8f4a8o3c2.o2g4"
6730 PRINT "It is the night of the dear Sa-viour's birth."
6740 PLAY "g8e4d8c4.e4f8g4.f4d8c2."
6750 PRINT "Long lay the world, in sin and er-ror pin-ing,"
6760 PLAY "e4.e4e8g2g8a4a8f4a8o3c4.o2g2."
6770 PRINT "Till He ap-peared and the soul felt its worth."
6780 PLAY "g8f#4e8b4.g4a8b4.o3c4o2b8e2."
6790 PRINT "A thrill of hope the wea-ry world re-joi-ces"
6800 PLAY "g8g4.a4.d4.g4.a4g8o3c4o2e8a4.g4"
6810 PRINT "For yon-der breaks a new and glo-rious morn."
6820 PLAY "g8g4.a4.d4.g4.a4g8o3c4o2e8g2."
6830 PRINT "Fall on your knees! O hear the an-gel voic-es!"
6840 PLAY "o3c2..o2b4a8b1b8o3d2..o2a8a4a8o3c2.c4."
6850 PRINT "O night- di-vine! O night when Christ was born!"
6860 PLAY "p32o3c8e3d3.o2g8o3c2.o2b4a8g2..g8a4g8g2.."
6870 PRINT "O night di-vine! O night O night- di-vine!"
6880 PLAY "o3c8d2..o2g8o3e2.d4.c3c8o2b4.o3c4d8c2.."
6890 GOTO 260
6900 REM *********************************************************************
6910 REM
6920 CLS: PRINT "  IT CAME UPON THE MIDNIGHT CLEAR": PRINT
6930 FOR X = 1 TO 3: PRINT
    6940 IF X = 1 THEN PRINT "It came up-on the mid-night clear, That glo-rious song of old,"
    6950 IF X = 2 THEN PRINT "Still through the cloven skies they come, With peaceful wings unfurled;"
    6960 IF X = 3 THEN PRINT "And ye beneath life's crushing load, Whose forms are bending low,"
    6970 PLAY "t120o2p4f8o3d4c8c8o2b-8g8f4g8f4f8g8a8b-8b-8o3c8d8c2"
    6980 IF X = 1 THEN PRINT "From an-gels bend-ing near the earth, to touch their harps of gold:"
    6990 IF X = 2 THEN PRINT "And still their heav'nly music floats. O'er all the weary world;"
    7000 IF X = 3 THEN PRINT "Who toil along the climbing way, With painful steps and slow,"
    7010 PLAY "o2f8o3d4c8c8o2b-8g8f4g8f4f8g4g8a8g8f8b-2"
    7020 IF X = 1 THEN PRINT "Peace to the earth, good will to men, From heav'n's all gra-cious King,"
    7030 IF X = 2 THEN PRINT "Above its sad and lowly plains, They bend on hov'ring wings;"
    7040 IF X = 3 THEN PRINT "Look now! for glad and golden hours come swiftly on the wing;"
    7050 PLAY "o3d8d4o2d8d8e8f#8g4a8b-4o3d8c8o2b-8a8g8a8g8f2"
    7060 IF X = 1 THEN PRINT "The world in sol-emn still-ness lay, to hear the an-gels sing!"
    7070 IF X = 2 THEN PRINT "And ever o'er its Babel sounds, The blessed angels sing!"
    7080 IF X = 3 THEN PRINT "Oh, rest beside the weary road, And hear the angels sing!"
    7090 PLAY "f8o3d4c8c8o2b-8g8f4g8f4f8g4g8a8g8f8b-2p8"
7100 NEXT X
7110 GOTO 260
7120 REM *********************************************************************
7130 REM
7140 CLS: PRINT "  THE FIRST NOEL": PRINT
7150 FOR X = 1 TO 4: PRINT
    7160 IF X = 1 THEN PRINT "The first- No-el the an-gel did say"
    7170 IF X = 2 THEN PRINT "They- looked-- up and- saw- a Star"
    7180 IF X = 3 THEN PRINT "This star drew nigh to the north-west"
    7190 IF X = 4 THEN PRINT "Then enter'd in there wise men three,"
    7200 PLAY "t150o2p4f#8e8d4.e8f#8g8a2b8o3c#8d4c#4o2b4a2"
    7210 IF X = 1 THEN PRINT "Was to cer-tain poor shep-herds in fields as they lay;"
    7220 IF X = 2 THEN PRINT "Shin-ing in- the East-, be-yond them far,"
    7230 IF X = 3 THEN PRINT "O'er Beth-le-hem it took its rest"
    7240 IF X = 4 THEN PRINT "Full rev'rently upon their knee,"
    7250 PLAY "b8o3c#8d4c#4o2b4a4b4o3c#4d4o2a4g4f#2"
    7260 IF X = 1 THEN PRINT "In- fields- where- they lay- keeping their sheep,"
    7270 IF X = 2 THEN PRINT "And- to- the earth it- gave- great light,"
    7280 IF X = 3 THEN PRINT "And- there- it- did both- stop- and stay,"
    7290 IF X = 4 THEN PRINT "And- of-fer'd there in- His- pre-sence,"
    7300 PLAY "f#8e8d4.e8f#8g8a2b8o3c#8d4c#4o2b4a2"
    7310 IF X = 1 THEN PRINT "On a cold win-ter's night- that was- so deep."
    7320 IF X = 2 THEN PRINT "And- so it con-tin-ued both day- and night,"
    7330 IF X = 3 THEN PRINT "right- over- the place where- Je-sus lay."
    7340 IF X = 4 THEN PRINT "Their- gold- and- myrrh- and frank-in-cense."
    7350 PLAY "b8o3c#8d4c#4o2b4a4b4o3c#4d4o2a4g4f#2"
    7360 PRINT "No-el-, No-el, No-el, No-el, Born is the King of Is-ra-el."
    7370 PLAY "f#8e8d4.e8f#8g8a2o3d8c#8o2b2b4a2.o3d4c#4o2b4a4b4o3c#4d4o2a4g4f#2p4"
7380 NEXT X
7390 GOTO 260
7400 REM *********************************************************************
7410 REM
7420 CLS: PRINT "  GOD REST YOU MERRY GENTLEMEN": PRINT
7430 FOR X = 1 TO 4: PRINT
    7440 IF X = 1 THEN PRINT "God rest you mer-ry gen-tle-men, Let noth-ing you dis-may,"
    7450 IF X = 2 THEN PRINT "In Bethlehem, in Jewery, This blessed Babe was born,"
    7460 IF X = 3 THEN PRINT "From God our heav'nly Father, A blessed Angel came,"
    7470 IF X = 4 THEN PRINT "'Fear not then,' said the Angel, 'Let nothing you affright.'"
    7480 PLAY "t150o2p4l4eebbagf#edef#gal2b."
    7490 IF X = 1 THEN PRINT "Re-mem-ber Christ our Sa-viour was born on Christ-mas Day,"
    7500 IF X = 2 THEN PRINT "And laid within a manger upon this blessed morn;"
    7510 IF X = 3 THEN PRINT "And unto certain Shepherds brought tidings of the same;"
    7520 IF X = 4 THEN PRINT "This day is born a Saviour of a pure Virgin bright,"
    7530 PLAY "l4eebbagf#edef#gal2b."
    7540 IF X = 1 THEN PRINT "To save us all from Sa-tan's pow'r, when we were gone a-stray."
    7550 IF X = 2 THEN PRINT "To which His mother Mary, Did nothing take in scorn."
    7560 IF X = 3 THEN PRINT "How that in Bethlehem was born the Son of God by Name."
    7570 IF X = 4 THEN PRINT "To free all those who trust in Him, From Satan's pow'r and might."
    7580 PLAY "l4bo3co2abo3cdeo2bagef#gl2a"
    7590 PRINT "O tid-ings of com-fort and joy, com-fort and joy,"
    7600 PLAY "l4gal2bo3l4co2bbagf#l2el8gf#l4el2a"
    7610 PRINT "O tid-ings of com-fort and joy."
    7620 PLAY "l4gabo3cdeo2bagf#l2e."
7630 NEXT X
7640 GOTO 260
7650 REM *********************************************************************
7660 REM
7670 CLS: PRINT "DECK THE HALLS WITH BOUGHS OF HOLLY": PRINT
7680 FOR X = 1 TO 3: PRINT
    7690 IF X = 1 THEN PRINT "Deck the halls with boughs of hol-ly, Fa la la la la  la la la la!"
    7700 IF X = 2 THEN PRINT "See the blazing Yule before us, Fa la la la la  la la la la."
    7710 IF X = 3 THEN PRINT "Fast away the old year passes, Fa la la la la  la la la la."
    7720 PLAY "t180o2p4a4.g8f#4e4d4e4f#4d4e8f#8g8e8f#4.e8d4c#4d2"
    7730 IF X = 1 THEN PRINT "'Tis the sea-son to be jol-ly, Fa la la la la  la la la la!"
    7740 IF X = 2 THEN PRINT "Strike the harp and join the chorus, Fa la la la la  la la la la!"
    7750 IF X = 3 THEN PRINT "Hail the new, ye lads and lasses, Fa la la la la  la la la la!"
    7760 PLAY "a4.g8f#4e4d4e4f#4d4e8f#8g8e8f#4.e8d4c#4d2"
    7770 IF X = 1 THEN PRINT "Don we now our gay ap-par-el, Fa la la Fa la la  la la la."
    7780 IF X = 2 THEN PRINT "Follow me in merry measure, Fa la la Fa la la  la la la."
    7790 IF X = 3 THEN PRINT "Sing we joyous all together, Fa la la Fa la la  la la la."
    7800 PLAY "e4.f#8g4e4f#4.g8a4e4f#8g8a4b8o3c#8d4c#4o2b4a2"
    7810 IF X = 1 THEN PRINT "Troll the an-cient yule-tide ca-rol Fa la la la la  la la la la!"
    7820 IF X = 2 THEN PRINT "While I tell of Yule-tide treasure, Fa la la la la  la la la la."
    7830 IF X = 3 THEN PRINT "Heedless of the wind and weather, Fa la la la la  la la la la."
    7840 PLAY "a4.g8f#4e4d4e4f#4d4b8b8b8b8a4.g8f#4e4d2"
7850 NEXT X
7860 GOTO 260
7870 REM *********************************************************************
7880 REM
7890 CLS: PRINT "  HARK! THE HERALD ANGELS SING": PRINT
7900 FOR X = 1 TO 3: PRINT
    7910 IF X = 1 THEN PRINT "Hark, the her-ald an-gels sing, Glory to the new-born King!"
    7920 IF X = 2 THEN PRINT "Christ by high-est heav'n a-dored; Christ the ever-last-ing Lord;"
    7930 IF X = 3 THEN PRINT "Hail! the heav'n born Prince of peace! Hail! the Son of Right-eous-ness;"
    7940 PLAY "t150o2p4l4dggf#gbbao3ddd.l8co2l4bal2b"
    7950 IF X = 1 THEN PRINT "Peace on earth and mer-cy mild, God and sin-ners re-con-ciled."
    7960 IF X = 2 THEN PRINT "Late in time be-hold Him come, Off-spring of the fa-vored one,"
    7970 IF X = 3 THEN PRINT "Light and life to all He brings, Ris'n with heal-ing in His wings."
    7980 PLAY "l4dggf#gbbao3do2aa.l8f#l4f#el2d"
    7990 IF X = 1 THEN PRINT "Joy-ful, all ye na-tions rise, Join the tri-umph of the skies,"
    8000 IF X = 2 THEN PRINT "Veiled in flesh, the God-head see; Hail th'in-car-nate De-ity;"
    8010 IF X = 3 THEN PRINT "Wild He lays His glo-ry by-, Born that man no more may die-."
    8020 PLAY "l4o3dddo2go3co2bbao3dddo2go3co2bba"
    8030 IF X = 1 THEN PRINT "With th'an-gel-ic host pro-claim, Christ is- born in Beth-le-hem."
    8040 IF X = 2 THEN PRINT "Pleased as man, with man to dwell, Je-sus- our Im-man-uel!"
    8050 IF X = 3 THEN PRINT "Born to raise the Sons of earth, Born to give them second birth."
    8060 PLAY "o3eeedco2bo3l2co2l4al8bo3cl4d.l8o2gl4gal2b"
    8070 PRINT "Hark! the her-ald an-gels sing, Glo-ry- to the new-born King."
    8080 PLAY "l4o3eeedco2bl2o3co2l4al8bo3cl4d.l8o2gl4gal2gp4"
8090 NEXT X
8100 GOTO 260
8110 REM *********************************************************************
8120 REM
8130 CLS: PRINT "  ANGELS WE HAVE HEARD ON HIGH": PRINT
8140 FOR X = 1 TO 3: PRINT
    8150 IF X = 1 THEN PRINT "An-gels we have heard on high, Sweet-ly sing-ing o'er the plain;"
    8160 IF X = 2 THEN PRINT "Shepherds, why this jubilee? Why your cheery strains prolong?"
    8170 IF X = 3 THEN PRINT "Come to Bethlehem and see, Him whose birth the angels sing;"
    8180 PLAY "t150o2p4a4a4a4o3c4c4.o2b-8a2a4g4a4o3c4o2a4.g8f2"
    8190 IF X = 1 THEN PRINT "And the moun-tains in re-ply, Ech-o-ing their joy-ous strain."
    8200 IF X = 2 THEN PRINT "What the gladsome tidings be, which inspire your heav'nly song?"
    8210 IF X = 3 THEN PRINT "Come, adore on bended knee, Christ the Lord, the new-born King."
    8220 PLAY "a4a4a4o3c4c4.o2b-8a2a4g4a4o3c4o2a4.g8f2"
    8230 PRINT "Glo-----ri-a, in ex-cel-sis De-o!  Glo------ri-a, in ex-cel-sis De-o!"
    8240 PLAY "o3c2d8c8o2b-8a8b-2o3c8o2b-8a8g8a2b-8a8g8f8g4.c8c2f4g4a4b-4a2g2o3c2d8c8o2b-8a8b-2o3c8o2b-8a8g8a2b-8a8g8f8g4.c8c2f4g4a4b-4a2g2f1.p4"
8250 NEXT X
8260 GOTO 260
8270 REM *********************************************************************
8280 REM
8290 CLS: PRINT "  WHILE SHEPHERDS WATCHED THEIR FLOCKS": PRINT
8300 FOR X = 1 TO 5: PRINT
    8310 IF X = 1 THEN PRINT "While shep-herds watched their flocks by night, All seat-ed on the ground,"
    8320 IF X = 2 THEN PRINT "Fear not, said he, for mighty dread had seized their troubled mind;"
    8330 IF X = 3 THEN PRINT "To you in David's town, this day is born of David's line,"
    8340 IF X = 4 THEN PRINT "The heav'nly babe you there shall find to human view displayed,"
    8350 IF X = 5 THEN PRINT "All glory be to God on high, and to the earth be peace;"
    8360 PLAY "t120o2p4f4a4.a8g4f4b-4b-4a4g4a4o3c4c4o2b4o3c2."
    8370 IF X = 1 THEN PRINT "The an-gel of the Lord came down, and glo-ry shone a-round."
    8380 IF X = 2 THEN PRINT "Glad tidings of great joy I bring to you and all mankind."
    8390 IF X = 3 THEN PRINT "The Saviour, who is Christ the Lord; and this shall be the sign."
    8400 IF X = 4 THEN PRINT "All meanly wrapped in swathing bands, and in a manger laid."
    8410 IF X = 5 THEN PRINT "Good-will hence-forth from heav'n to men, begin and never cease."
    8420 PLAY "o2a4o3d4.c8o2b-4a4g4f4e4a4g4f4f4e4f2.p4"
8430 NEXT X
8440 GOTO 260
8450 REM *********************************************************************
8460 REM
8470 CLS: PRINT "  IT'S BEGINNING TO LOOK A LOT LIKE CHRISTMAS": PRINT
8480 FOR X = 1 TO 2: PRINT
    8490 PRINT "It's be-gin-ning to look a lot like Christ-mas, Ev-'ry-where you go;"
    8500 PLAY "t150o1p4b8.o2c16d6e6d6c#8.d16e4g4b4d2.b4.b8a4.g8e2."
    8510 PRINT "Take a look in the five and ten, glis-ten-ing once a-gain,"
    8520 PLAY "e8.f#16g6a6g6e8.f16f#2f#6g6f#6d8.d#16e4."
    8530 PRINT "with can-dy canes and sil-ver lanes a-glow."
    8540 PLAY "e8f#8.g16a8.b16a8.g16f#8.e16a2."
    8550 PRINT "It's be-gin-ning to look a lot like Christmas, toys in ev-'ry store"
    8560 PLAY "o1b8.o2c16d6e6d6c#8.d16e4g4b4d2.b4.b8a4.g8e2."
    8570 PRINT "But the prettiest sight to see is the holly that will be on your own front";
    8580 IF X = 1 THEN PRINT " door."
    8590 IF X = 2 THEN PRINT " heart"
    8600 PLAY "e8.f#16g6a6g6f#8.g16f#4e8.e-16d8.e16g8.b16o3d4o2d8.e16o3c2O2f#2g2."
    8610 IF X = 2 THEN GOTO 260
    8620 PRINT "A pair of hopalong boots and a pistol that shoots is the wish of Barney and Ben;"
    8630 PLAY "f#16g8.a16b8o3c8o2b8a6b6a6g6a6g6f#6g6a6b8.b16a6g6f#6e4p16"
    8640 PRINT "Dolls that will talk and will go for a walk is the hope of Jan-ice and Jen;"
    8650 PLAY "a6b6a6g6a6g6f#6g6f#6e6f#6g6a8.a16g6f#6e6d4p16"
    8660 PRINT "And Mom and Dad can hard-ly wait for school to start a-gain."
    8670 PLAY "d8o3d8.c#16c8.o2b16a8.g16f#8.e16d8.c#16d8.e16d4"
8680 NEXT
8690 REM *********************************************************************
8700 REM
8710 CLS: PRINT "  WE WISH YOU A MERRY CHRISTMAS": PRINT
8720 FOR X = 1 TO 2: PRINT
    8730 PRINT "We wish you a Mer-ry Christ-mas, We wish you a Mer-ry Christ-mas,"
    8740 PLAY "t150o2p4d4g4g8a8g8f#8e4e4e4a4a8b8a8g8f#4d4"
    8750 PRINT "We wish you a Mer-ry Christ-mas, And a Hap-py New Year."
    8760 PLAY "d4b4b8o3c8o2b8a8g4e4d8d8e4a4f#4g2"
    8770 PRINT "Good ti-dings to you wher-ev-er you are;"
    8780 PLAY "d4g4g4g4f#2f#4g4f#4e4d2"
    8790 PRINT "Good ti-dings for Christ-mas and a Hap-py New Year."
    8800 PLAY "a4b4a4g4o3d4o2d4d8d8e4a4f#4g2"
8810 NEXT X
8820 GOTO 260
8830 REM *********************************************************************
8840 REM
8850 CLS: PRINT "LET IT SNOW! LET IT SNOW! LET IT SNOW!": PRINT
8860 FOR X = 1 TO 2: PRINT
    8870 PRINT "Oh! the weath-er out-side is fright-ful But the fire is so de-light-ful."
    8880 PLAY "t150o2p4c8c8o3c8c8o2b-4a4g4f4c2c8c8g4.f8g4.f8e4c2"
    8890 PRINT "And since we've no place to go, Let it snow! Let it snow! Let it snow!"
    8900 PLAY "d4o3d8d8c4o2b-4a4g2.o3e8d8c4c8o2b-8a4a8g8f2."
    8910 PRINT "It does-n't show signs of stop-ping, And I brought some corn for pop-ping;"
    8920 PLAY "c4o3c8c8o2b-4a4g4f4c2c8c8g4.f8g4.f8e4c2"
    8930 PRINT "The lights are turned 'way down low.  Let it snow! Let it snow! Let it snow!"
    8940 PLAY "d4o3d8d8c4o2b-4a4g2.o3e8d8c4c8o2b-8a4a8g8f2."
    8950 PRINT "When we fin-al-ly kiss good-night, How I'll hate go-ing out in the storm!"
    8960 PLAY "e8f8g8a8g4e4o3c4o2g2.e8g8f4f8e8d4c8d8e2."
    8970 PRINT "But if you'll real-ly hold me tight, All the way home I'll be warm."
    8980 PLAY "e8f8g4a8g8e4o3c4o2g1o3c8o2b8a4b4a8b8o3c2."
    8990 PRINT "The fi-re is slow-ly dy-ing; and, my dear, we're still good-bye-ing,"
    9000 PLAY "o2c4o3c8c8o2b-4a4g4f4c2c8c8g4.f8g4.f8e4c2"
    9010 PRINT "But as long as you love me so, Let It Snow! Let It Snow! Let It Snow!"
    9020 PLAY "d8d8o3d8d8c4o2b-4a4g2.o3e8d8c4c8o2b-8a4a8g8f2.p8"
    9030 IF X = 2 THEN GOTO 9050
9040 NEXT X
9050 GOTO 260
9060 REM *********************************************************************
9070 REM
9080 CLS: PRINT "I'LL BE HOME FOR CHRISTMAS": PRINT
9081 X = 1
9090 'FOR X = 1 TO 2:
PRINT
9100 PRINT "I'll be home for Christ-mas,"
9110 PLAY "t220o3p4c2.o2b4o3d2.c4o2g2g2d8e8f8a8e8e-8d4"
9120 PRINT "You can plan on me."
9130 PLAY "a2.g4b-2.a4d1"
9140 PRINT "Please have snow and mis-stle-toe,"
9150 PLAY "c#4d2.e4g2.f4e2.g4o3c2."
9160 PRINT "And pre-sents on the tree."
9170 PLAY "o2b4o3d2d2o2b2.b4a1."
9180 PRINT "Christ-mas Eve will find me-"
9190 PLAY "o2b4o3c2.o2b4o3d2.c4o2g2g2d8e8f8a8e8e-8d4"
9200 PRINT "Where the love- light gleams."
9210 PLAY "a2.g4b-2.a4d1"
9220 PRINT "I'll be home for Christ-mas,"
9230 PLAY "d8e8f8a8o3d2.c4d2.c4o2g1a2."
9240 PRINT "If on-ly in my dreams--."
9250 PLAY "a4o3d2e2c2d2"
9260 IF X = 1 THEN PLAY "o3c2o2g8a8b8o3c8d4o2b8b-8a4b4": X = 2: GOTO 9090
'NEXT X
9270 IF X = 2 THEN PLAY "c1"
9280 GOTO 260
9290 REM *********************************************************************
9300 REM
9310 CLS: PRINT "(There's no place like) HOME FOR THE HOLIDAYS": PRINT
9320 FOR X = 1 TO 2: PRINT
    9330 PRINT "Oh, there's no place like Home for the Hol-i-days"
    9340 PLAY "t150o2p4l4efl2gl4ecl2o3cl4o2bagfl1e"
    9350 PRINT "'cause no mat-ter how far a-way you roam"
    9360 PLAY "l4cdl2el4d#eagfedo3co2bagf"
    9370 PRINT "When you pine for the sun-shine of a friend-ly gaze"
    9380 PLAY "l4efl2gl4eco3dco2bao3co2el1g"
    9390 PRINT "for the hol-i-days you can't beat home, sweet home."
    9400 PLAY "l4o3dco2bgafgefdl1c"
    9410 PRINT "I met a man who lives in Ten-nes-see"
    9420 PLAY "l4cfgao3cco2bo3dcc."
    9430 PRINT "and he was head-in' for Penn-syl-van-ia and some home-made pump-kin pie."
    9440 PLAY "l8o2bl4o3dco2bal2gl4efggf#gbagfl1e"
    9450 PRINT "From Penn-syl-van-ia folks are trav-'lin' down to Dix-ie's sun-ny shore;"
    9460 PLAY "l4cfgao3cco2bo3dcc.l8o2bl4o3dco2bal2g"
    9470 PRINT "From At-lan-tic to Pa-ci-fic, gee, the traf-fic is ter-ri-fic."
    9480 PLAY "l4gabo3ddedco2b.l8al4gggagf"
    9490 PRINT "Oh, there's no place like Home for the Hol-i-days"
    9500 PLAY "l4efl2gl4ecl2o3cl4o2bagfl1e"
    9510 PRINT "'cause no mat-ter how far a-way you roam-"
    9520 PLAY "l4cdl2el4d#eagfedo3co2bagf"
    9530 PRINT "if you want to be hap-py in a mil-lion ways"
    9540 PLAY "l4efl2gl4eco3dco2bao3co2el1g"
    9550 PRINT "for the hol-i-days you can't beat home, sweet home."
    9560 IF X = 1 THEN PLAY "l4o3dco2bgafgefdcgggl2g"
    9570 IF X = 2 THEN PLAY "l4o3dco2bgafl2gel1fo3dc."
9580 NEXT X
9590 GOTO 260
9600 REM *********************************************************************
9610 REM
9620 CLS: PRINT "  SILVER BELLS": PRINT
9630 PRINT "Christ-mas makes you feel e-mo-tion-al."
9640 PLAY "t150o2l4f2ff2ff2fo3c.o2b-8a"
9650 PRINT "It may bring par-ties or thoughts de-vo-tion-al."
9660 PLAY "fffffff2fo3c.o2b-8a"
9670 PRINT "What-ev-er hap-pens or what may be,"
9680 PLAY "b-o3cdo2b-o3cdo2b-2o3cd2."
9690 PRINT "Here is what Christ-mas time means to me:"
9700 PLAY "o2ab-o3co2ab-o3co2a2b-o3c"
9710 FOR X = 1 TO 2: PRINT
    9720 PRINT "City side-walks, busy side-walks, dressed in hol-i-day style,"
    9730 PLAY "t150o2p4b-8g8f4d4b-8g8f4d4o3d8c8o2b-4g4g4g2"
    9740 PRINT "In the air there's a feel-ing of Christ-mas."
    9750 PLAY "o3c8o2b-8a4f4e4e-4f4.e-8e-4d2.p8"
    9760 PRINT "Child-ren laugh-ing, people pass-ing, meet-ing smile after smile,"
    9770 PLAY "b-8g8f4d4b-8g8f4d4o3d8c8o2b-4g4g4g2"
    9780 PRINT "and on every street corner you hear:"
    9790 PLAY "o3c8o2b-8a4f4e4e-4f4o3c4o2b-1"
    9800 PRINT "Silver bells, silver bells,"
    9810 PLAY "d8e-8f1g8a8b-1"
    9820 PRINT "It's Christ-mas time in the city."
    9830 PLAY "a4a4b-4o3c2o2b-8a8b-4f1"
    9840 PRINT "Hear the bells, hear them ring."
    9850 PLAY "d8e-8f1g8a8b-1"
    9860 PRINT "Soon it will be Christ-mas Day!"
    9870 PLAY "a4a4b-4o3c4o2b-4a4b-2.p4"
9880 NEXT X
9890 GOTO 260
9900 REM *********************************************************************
9910 REM
9920 CLS: PRINT "JOLLY OLD SAINT NICHOLAS": PRINT: PRINT
9930 PRINT "Jolly old Saint Nicholas,"
9940 PLAY "t180o2p4l4bbbbaal2a"
9950 PRINT "Lean your ear this way."
9960 PLAY "l4ggggl1b"
9970 PRINT "Don't you tell a single soul"
9980 PLAY "l4eeeeddl2g"
9990 PRINT "What I'm going to say."
10000 PLAY "l4agabl1a"
10010 PRINT "Christmas Eve is coming soon;"
10020 PLAY "l4bbbbaal2a"
10030 PRINT "Now you dear old man,"
10040 PLAY "l4ggggl1b"
10050 PRINT "Whisper what you'll bring to me,"
10060 PLAY "l4eeeeddl2g"
10070 PRINT "Tell me if you can."
10080 PLAY "l4agabl1g"
10090 GOTO 260
10100 REM *********************************************************************
10110 REM
10120 CLS: PRINT "    JINGLE BELLS ": PRINT
10130 FOR X = 1 TO 3: PRINT
    10140 IF X = 1 THEN PRINT "Dashing thro' the snow, In a one horse o-pen sleigh,"
    10150 IF X = 2 THEN PRINT "A day or two ago, I tho't I'd take a ride:"
    10160 IF X = 3 THEN PRINT "Now the ground is white, Go it while you're young,"
    10170 PLAY "T180O2p4L4DBAGL2D.L8DDL4DBAGL2E."
    10180 IF X = 1 THEN PRINT "O'er the fields we go, Laugh-ing all the way;"
    10190 IF X = 2 THEN PRINT "And soon Miss Fannie Bright, was seated by my side;"
    10200 IF X = 3 THEN PRINT "Take the girls tonight; and sing this sleighing song:"
    10210 PLAY "L4EEO3CO2BAL1F#O3L4DDCO2AL1B"
    10220 IF X = 1 THEN PRINT "Bells on bob-tail ring, Making spir-its bright;"
    10230 IF X = 2 THEN PRINT "The horse was lean and lank, misfortune seem'd his lot;"
    10240 IF X = 3 THEN PRINT "Just get a bob-tailed bay, two forty for his speed,"
    10250 PLAY "L4DBAGL2D.L8DDL4DBAGL2E."
    10260 IF X = 1 THEN PRINT "What fun it is to ride and sing a sligh-ing song to-night!"
    10270 IF X = 2 THEN PRINT "He got into a drifted bank and then we got up-sot!"
    10280 IF X = 3 THEN PRINT "Then hitch him to an open sleigh and crack! you'll take the lead."
    10290 PLAY "L4EEO3CO2BAO3DDDDEDCO2AL2G."
    10300 PRINT "Jin-gle bells, Jin-gle bells, Jin-gle all the way!"
    10310 PLAY "P4L4BBL2BL4BBL2BL4BO3DO2L4G.L8AL1B"
    10320 PRINT "Oh! what fun it is to ride in a one horse open sleigh!"
    10330 PLAY "O3L4CCL4C.L8CL4CO2BBL8BBL4BAABL2A"
    10340 PRINT "Jin-gle bells, Jin-gle bells, Jin-gle all the way!"
    10350 PLAY "O3DO2L4BBL2BL4BBL2BL4BO3DO2L4G.L8AL1B"
    10360 PRINT "Oh! what fun it is to ride in a one horse open sleigh!"
    10370 PLAY "O3L4CCL4C.L8CL4CO2BBL8BBO3L4DDCO2L4AL1GP1"
10380 NEXT X
10390 GOTO 260
10400 REM *********************************************************************
10410 REM
10420 CLS: PRINT "Frosty the Snow Man"
10430 FOR X = 1 TO 2
    10440 PRINT
    10450 IF X = 1 THEN PRINT "Fros-ty the Snow man was a jolly happy soul,"
    10460 IF X = 2 THEN PRINT "Fros-ty the Snow man knew the sun was hot that day"
    10470 PLAY "t140o2p4g2e4.f8g4o3c2o2b8o3c8d4c4o2b4a8g2."
    10480 IF X = 1 THEN PRINT "with a corn cob pipe and a button nose and two eyes made out of coal."
    10490 IF X = 2 THEN PRINT "so he said Let's run and we'll have some fun now before I melt away."
    10500 PLAY "o2b8o3c8d4c4o2b4a8a8g8o3c4o2e8e4g8a8g4f4e4f4g2."
    10510 IF X = 1 THEN PRINT "Fros-ty the Snow Man is a fair-y tale, they say,"
    10520 IF X = 2 THEN PRINT "Down to the vil-lage, with a broom-stick in his hand,"
    10530 PLAY "g2e4.f8g4o3c2o2b8o3c8d4c4o2b4a8g2."
    10540 IF X = 1 THEN PRINT "He was made of snow but the chil-dren knew how he come to life one day."
    10550 IF X = 2 THEN PRINT "run-ning here and there all a-round the square, say-in' catch me if you can."
    10560 PLAY "o2b8o3c8d4c4o2b4a8a8g8o3c4o2e8e4g8a8g4f4e4d4c2."
    10570 IF X = 1 THEN PRINT "There must have been some magic in that old silk hat they found."
    10580 IF X = 2 THEN PRINT "He led them down the streets of town right to the traffic cop."
    10590 PLAY "c4a4a4o3c4c4o2b4a4g4e4f4a4g4f4e2."
    10600 IF X = 1 THEN PRINT "For when they placed it on his head he be-gan to dance a round."
    10610 IF X = 2 THEN PRINT "And he on-ly paused a moment when he heard him hol-ler Stop!"
    10620 PLAY "e8e8d4d4g4g4b4b4o3d4d8o2b8o3d4c4o2b4a4g4p4"
    10630 IF X = 1 THEN PRINT "Oh, Fros-ty the Snow Man was a-live as he could be,"
    10640 IF X = 2 THEN PRINT "For, Fros-ty the Snow Man had to hur-ry on his way"
    10650 PLAY "g2g2e4.f8g4o3c2o2b8o3c8d4c4o2b4a8g8g2."
    10660 IF X = 1 THEN PRINT "and the chil-dren say he could laugh and play just the same as you and me."
    10670 IF X = 2 THEN PRINT "but he waved good-bye say-in' Don't you cry, I'll be back a-gain some day."
    10680 PLAY "o2b8o3c8d4c4o2b4a8a8g8o3c4o2e8e4g8a8g4f4e4d4c2.p4"
10690 NEXT X
10700 PRINT: PRINT "Thump-et-y thump thump, thump-et-y thump thump, look at Fros-ty go."
10710 PLAY "t180g8g8g4g4g4a8g8g4g4g4a4g4e4g4d1"
10720 PRINT "Thump-et-y thump thump, thump-et-y thump thump, ov-er the hills of snow."
10730 PLAY "t180g8g8g4g4g4a8g8g4g4g4g8g8g4a4b4o3c2c4p1"
10740 GOTO 260
10750 REM *********************************************************************
10760 REM
10770 CLS: PRINT " RUDOLPH THE RED-NOSED REINDEER": PRINT: PRINT
10780 PRINT "You know Dash-er and Danc-er and Pranc-er and Vix-en,"
10790 PLAY "t120o2l8p4abo3co2a4fbg4eaf4dag4."
10800 PRINT "Com-et and Cu-pid and Don-ner and Blitz-en,"
10810 PLAY "o3co2a4fbg4eaf4dag4."
10820 PRINT "But do you re-call  the most fa-mous rein-deer of all?"
10830 PLAY "l4eeeea2.a8b8o3ccc8o2ba8g1"
10840 PRINT "Rudolph the red-nosed reindeer"
10850 PLAY "T160O3p4C8D4C8O2A4O3F4D4C2."
10860 PRINT "Had a very shiny nose"
10870 PLAY "o3c8d8c8d8c4f4e1"
10880 PRINT "And if you ever saw it,"
10890 PLAY "o2b-8o3c4o2b-8g4o3e4d4c2."
10900 PRINT "You would even say it glows."
10910 PLAY "o3c8d8c8d8c4d4o2a1"
10920 PRINT "All of the other reindeer,"
10930 PLAY "o3c8d4c8o2a4o3f4d4c2."
10940 PRINT "Used to laugh and call him names."
10950 PLAY "o3c8d8c8d8c4f4e1"
10960 PRINT "They never let poor Rudolph"
10970 PLAY "o2b-8o3c4o2b-8g4o3e4d4c2."
10980 PRINT "Join in any reindeer games."
10990 PLAY "o3c8d8c8d8c4g4f1"
11000 PRINT "Then one foggy Christmas Eve,"
11010 PLAY "o3d4d4f4d4c4o2a4o3c2"
11020 PRINT "Santa came to say:"
11030 PLAY "o2b-4o3d4c4o2b-4a1"
11040 PRINT "Rudolph with your nose so bright"
11050 PLAY "o2g4a4o3c4d4e4e4e2"
11060 PRINT "Won't you guide my sleigh tonight?"
11070 PLAY "o3f4f4e4d4c4o2b-4g2"
11080 PRINT "Then how the reindeer loved him,"
11090 PLAY "o3c8d4c8o2a4o3f4d4c2."
11100 PRINT "As they shouted out with glee:"
11110 PLAY "o3c8d8c8d8c4f4e1"
11120 PRINT "Rudolph the red-nosed reindeer,"
11130 PLAY "o2b-8o3c4o2b-8g4o3e4d4c2."
11140 PRINT "You'll go down in history."
11150 PLAY "o3c8d8c8d8c4g4f1"
11160 GOTO 260
11170 REM *********************************************************************
11180 REM
11190 CLS: PRINT "  SLEIGH RIDE": PRINT
11200 FOR X = 1 TO 2: PRINT
    11210 PRINT "Just hear those sleigh bells jin-gle-ing, ring-ting-tin-gle-ing, too."
    11220 PLAY "t180o3l4dddded8o2b8gaba8f#8ed1"
    11230 PRINT "Come on, it's love-ly weath-er for a Sleigh Ride to-geth-er with you,"
    11240 PLAY "o2ef#ao3ded8o2b8a8g8aa8b8a8g8eg1"
    11250 PRINT "Out-side the snow is fall-ing and friends are call-ing 'Yoo hoo',"
    11260 PLAY "o3dddded8o2b8gaba8f#8ed1"
    11270 PRINT "Come on, it's love-ly weather for a Sleigh Ride to-geth-er with you."
    11280 PLAY "o2ef#ao3ded8o2b8a8g8aa8b8a8g8eg1"
    11290 PRINT "Gid-dy-yap, gid-dy-yap, gid-dy-yap, let's go. Let's look at the show,"
    11300 PLAY "o2d#8e8bd#8e8bd8e8bO3c#O2a#1ba#8f#8d#g#1"
    11310 PRINT "We're rid-ing in a won-der-land of snow."
    11320 PLAY "a#g#8e8c#8e8g#ba#o3c#o2f#1."
    11330 PRINT "Gid-dy-yap, gid-dy-yap, gid-dy-yap, it's grand, Just holding your hand."
    11340 PLAY "c#8d8ac#8d8ac8d8abg#2ag#8e8c#f#1"
    11350 PRINT "We're glid-ing a-long with a song of a win-ter-y fair-y-land."
    11360 PLAY "o3ae8d8o2ao3de8a8ed8o2a8o3d8e8ao4do3ad"
    11370 PRINT "Our cheeks are nice and ros-y, and com-fy co-zy are we."
    11380 PLAY "dddded8o2g8gaba8f#8ed1"
    11390 PRINT "We're snug-gled up to-geth-er like two birds of a feath-er would be."
    11400 PLAY "df#ao3ded8o2b8a8g8aa8b8a8g8eg1"
    11410 PRINT "Let's take that road be-fore us and sing a cho-rus or two."
    11420 PLAY "o3dddded8o2b8gaba8f#8ed1"
    11430 PRINT "Come on, it's love-ly weath-er for a Sleigh Ride to-geth-er with you."
    11440 PLAY "ef#ao3ded8o2b8a8g8aa8b8a8g8eg1."
11450 NEXT X
11460 GOTO 260
11470 CLS: PRINT "O CHRISTMAS TREE": PRINT
11480 FOR X = 1 TO 4: PRINT
    11490 IF X = 1 THEN PRINT "O Christmas tree! O Christmas tree! Your leaves are so unchanging."
    11500 IF X = 2 THEN PRINT "O Tan-nen-baum, O Tan-nen-baum, Wie treu sind dei-ne Blt-ter!"
    11510 IF X = 3 THEN PRINT "O Tan-nen-baum, O Tan-nen-baum, Du kannst mir sehr ge-fall-en,"
    11520 IF X = 4 THEN PRINT "O Tan-nen-baum, O Tan-nen-baum, Dein Kleid will mir was leh-ren;"
    11530 PLAY "T100O2p4C4F8.F16F8.P64G8.A8.A16A4.P64A8G8A8B-4E4G4F4P8"
    11540 IF X = 1 THEN PRINT "Not only green when summer's here, but also when the snow is near."
    11550 IF X = 2 THEN PRINT "Du grnst nicht nur zur Som-mer-zeit, Nein auch im Win-ter, wenn es schneit,"
    11560 IF X = 3 THEN PRINT "Wie oft hat nicht zur Weih-nachts-zeit, Ein baum von dir mich hoch er-freut!"
    11570 IF X = 4 THEN PRINT "Die Hoff-nung und Be-stn-dig-keit, Giebt Trost und Kraft zu je-der Zeit!"
    11580 PLAY "O3C8C8O2A8O3D4.C8C8O2B-8B-4.B-8B-8G8O3C4.O2B-8b-8a8a4p16"
    11590 IF X = 1 THEN PRINT "O Christmas tree! O Christmas tree! Your leaves are so unchanging."
    11600 IF X = 2 THEN PRINT "O Tannenbaum, O Tannenbaum, Wie treu sind dei-ne Blt-ter."
    11610 IF X = 3 THEN PRINT "O Tannenbaum, O Tannenbaum, Du kannst mir sehr ge-fall-en."
    11620 IF X = 4 THEN PRINT "O Tannenbaum, O Tannenbaum, Dein Kleid will mir was leh-ren."
    11630 PLAY "C4F8.F16F4.G8A8.A16A4.A8G8A8B-4E4G4F4P4"
11640 NEXT X
11650 GOTO 260
11660 REM *********************************************************************
11670 REM
11680 CLS: PRINT "  SANTA CLAUS IS COMING TO TOWN": PRINT
11690 PRINT "You bet-ter watch out, you bet-ter not cry,"
11700 PLAY "t150o2l4p4ge8f8gg.g8a8b8o3cc2"
11710 PRINT "Bet-ter not pout, I'm tell-ing you why:"
11720 PLAY "o2e8f8ggga8g8ff2"
11730 PRINT "San-ta Claus is com-in' to town."
11740 PLAY "egcedf2o1bo2c2"
11750 PRINT "He's making a list and check-ing it twice,"
11760 PLAY "g8e8f8gg.g8a8b8o3cc2"
11770 PRINT "Gon-na find out whose naught-y and nice,"
11780 PLAY "o2e8f8ggga8g8ff2"
11790 PRINT "San-ta Claus is com-in' to town."
11800 PLAY "egcedf2o1bo2c1"
11810 PRINT "He sees you when you're sleep-in',"
11820 PLAY "o3cdco2bo3co2aa2"
11830 PRINT "He knows when you're awake."
11840 PLAY "o3cdco2bo3co2a2."
11850 PRINT "He knows if you've been bad or good,"
11860 PLAY "o3dedc#do2bbb"
11870 PRINT "So be good for good-ness sake."
11880 PLAY "o2b8o3c8dco2bag"
11890 PRINT "Oh! You bet-ter watch out, you bet-ter not cry,"
11900 PLAY "o2p4g.g8e8f8gg.g8a8b8o3cc2"
11910 PRINT "Bet-ter not pout, I'm tell-ing you why:"
11920 PLAY "o2e8f8ggga8g8ff2"
11930 PRINT "San-ta Claus is com-in' to town."
11940 PLAY "egcedf2o3dc1."
11950 GOTO 260
11960 REM *********************************************************************
11970 REM
11980 CLS: PRINT "  HERE COMES SANTA CLAUS": PRINT
11990 FOR X = 1 TO 4: PRINT
    12000 PRINT "Here comes San-ta Claus! Here comes San-ta Claus! Right down San-ta Claus Lane!"
    12010 IF X = 2 THEN GOTO 12080
    12020 IF X = 3 THEN GOTO 12120
    12030 IF X = 4 THEN GOTO 12160
    12040 PRINT "Vix-en and Blitz-en and all his rein-deer are pulling on the rein."
    12050 PRINT "Bells are ring-ing, chil-dren sing-ing, all is mer-ry and bright."
    12060 PRINT "Hang your stock-ings and say your pray'rs, 'Cause San-ta Claus comes to-night."
    12070 GOTO 12190
    12080 PRINT "He's got a bag that is filled with toys for the boys and girls a-gain."
    12090 PRINT "Hear those sleigh bells jin-gle jan-gle, what a beau-ti-ful sight."
    12100 PRINT "Jump in bed, cov-er up your head, 'Cause San-ta Claus comes to-night."
    12110 GOTO 12190
    12120 PRINT "He does-n't care if you're rich or poor for he loves you just the same."
    12130 PRINT "San-ta knows that we're God's chil-dren, that makes ev-`ry-thing right."
    12140 PRINT "Fill your hearts with a Christ-mas cheer, 'Cause San-ta Claus comes to-night."
    12150 GOTO 12190
    12160 PRINT "He'll come a-round when the chimes ring out, then it's Christ-mas morn a-gain."
    12170 PRINT "Peace on earth will come to all if we just fol-low the light."
    12180 PRINT "Let's give thanks to the Lord a-bove, 'Cause San-ta comes to-night."
    12190 PLAY "t180o2l4p4cag8g8fcag8g8fcb-b-8b-8ab-1"
    12200 PLAY "cb-8b-8ag8g8cb-ag8g8co3cco2bo3c1"
    12210 PLAY "o3dfedcedco2b-b-o3d6c6o2b-6a1"
    12220 PLAY "o3dfed8d8cedo2ao3c8c8o2b-agf1"
12230 NEXT X
12240 GOTO 260
12250 REM *********************************************************************
12260 REM
12270 CLS: PRINT "  HAVE YOURSELF A MERRY LITTLE CHRISTMAS": PRINT: PRINT
12280 PRINT "Have your-self a mer-ry lit-tle Christ-mas,"
12290 PLAY "t120o2l4cego3co2g8f8e8d8cd"
12300 PRINT "Let your heart be light."
12310 PLAY "cego3co2g2."
12320 PRINT "From now on, our troub-les will be out of sight."
12330 PLAY "ego3ced8c8o2b8a8gfe1"
12340 PRINT "Have your-self a mer-ry lit-tle Christ-mas,"
12350 PLAY "cego3co2g8f8e8d8cd"
12360 PRINT "Make the Yule-tide gay."
12370 PLAY "cego3co2g2."
12380 PRINT "From now on, our troub-les will be miles a-way."
12390 PLAY "ego3ced8c8o2b8a8g#bo3c2"
12400 PRINT "Here we are as in old-en days, hap-py gold-en days of yore."
12410 PLAY "eeed8c8o2b8o3c8d2c8o2b8a8b8o3c2o2bb2."
12420 PRINT "Faith-ful friends who are dear to us gather near to us once more"
12430 PLAY "o3ccco2b8a8g8a8b2g8a8b8o3c8d2o2dg2."
12440 PRINT "Through the years we all will be to-geth-er, if the Fates al-low."
12450 PLAY "cego3co2g8f8e8d8cdcego3co2g1"
12460 PRINT "Hang a shin-ing star up-on the high-est bough,"
12470 PLAY "ego3cef8e8d8c8o2bo3de2"
12480 PRINT "And have your-self a mer-ry lit-tle Christ-mas now."
12490 PLAY "o3eeo2fao3ce8d8c8o2b8abo3c1"
12500 GOTO 260
12510 REM *********************************************************************
12520 REM
12530 CLS: PRINT "  THE NIGHT BEFORE CHRISTMAS SONG": PRINT
12540 FOR X = 1 TO 2: PRINT
    12550 IF X = 1 THEN PRINT "'Twas the night be-fore Christ-mas and all thru the house,"
    12560 IF X = 2 THEN PRINT "And so up to the house-top the rein-deer soon flew,"
    12570 PLAY "t150o2l4g8g8o3c.c8c8o2bgbafag2"
    12580 IF X = 1 THEN PRINT "not a crea-ture was stir-ring, not e-ven a mouse."
    12590 IF X = 2 THEN PRINT "with the sleigh full of toys and Saint Nich-o-las too."
    12600 PLAY "g8g8fdfecedcde2"
    12610 IF X = 1 THEN PRINT "All the stock-ings were hung by the chim-ney with care,"
    12620 IF X = 2 THEN PRINT "Down the chim-ney he came with a leap and a bound."
    12630 PLAY "g8g8o3c.c8co2bgbafag2"
    12640 IF X = 1 THEN PRINT "In the hope that Saint Nich-o-las soon would be there."
    12650 IF X = 2 THEN PRINT "He was dressed all in fur and his bel-ly was round."
    12660 PLAY "g8g8fdfecedco1bo2c2"
    12670 IF X = 1 THEN PRINT "Then what to my won-der-ing eyes should ap-pear."
    12680 IF X = 2 THEN PRINT "He spoke not a word but went straight to his work."
    12690 PLAY "cag#ao3co2bago3co2eg2"
    12700 IF X = 1 THEN PRINT "A min-ia-ture sleigh and eight ti-ny rein-deer."
    12710 IF X = 2 THEN PRINT "And filled all the stock-ings; then turned with a jerk."
    12720 PLAY "gfefagfegce2"
    12730 IF X = 1 THEN PRINT "A lit-tle old driv-er so live-ly and quick,"
    12740 IF X = 2 THEN PRINT "And lay-ing his fin-ger a-side of his nose,"
    12750 PLAY "cag#ao3co2bago3co2eg2"
    12760 IF X = 1 THEN PRINT "I knew in a mo-ment it must be Saint Nick."
    12770 IF X = 2 THEN PRINT "then giv-ing a nod up the chim-ney he rose;"
    12780 PLAY "gf#edo3co2baaggg2"
    12790 IF X = 1 THEN PRINT "And more rap-id than ea-gles his rein-deer all came."
    12800 IF X = 2 THEN PRINT "But I heard him ex-claim as he drove out of sight,"
    12810 PLAY "g8g8o3c.c8co2bgbafag2"
    12820 IF X = 1 THEN PRINT "As he shout-ed 'On Dash-er' and each rein-deer's name."
    12830 IF X = 2 THEN PRINT "Mer-ry Christ-mas to all and to all a Good Night!"
    12840 PLAY "g8g8fdfece"
    12850 IF X = 1 THEN PLAY "dco1bo2c2"
    12860 IF X = 2 THEN PLAY "gabo3c2."
12870 NEXT X
12880 GOTO 260
12890 REM *********************************************************************
12900 REM
12910 REM      I am so glad on Christmas Eve
12920 REM "I am so glad- on Christ-mas Eve, the night of Je-sus' birth;"
12930 REM "That's when a star shone like the sun and an-gels sang on earth."
12940 REM "I am so glad- on Christ-mas Eve, my prais-es rise- a-bove,"
12950 REM "To Je-sus who has brought to earth the par-a-dise of love."
12960 PLAY "T135o2L4f8b-b-8o3d8.c16o2b-8ab-8o3co2f8o3cd8e-8.d16c8d2."
12970 PLAY "o2f8b-b-8o3d8.c16o2b-8ag8o3e-c8o2b-b-8a8.g16a8b-2."
12980 GOTO 260
12990 REM *********************************************************************
13000 REM
13010 REM     FROM HEAVEN ABOVE TO EARTH I COME
13020 REM ?"From heav'n a-bove to earth I come,"
13030 REM ?"To bear good news to- ev-'ry home."
13040 REM ?"Glad ti-dings of- great joy- I bring,"
13050 REM ?"Where-of I now will- glad-ly sing."
13060 REM verse 2
13070 REM ?"To you this night is born a Child"
13080 REM ?"Of Mary, chosen mother mild;"
13090 REM ?"This little Child of lowly birth;"
13100 REM ?"Shall be the joy of all the earth."
13110 REM verse 3
13120 REM ?"Glory to God in highest heav'n"
13130 REM ?"Who unto us His Son hath giv'n!"
13140 REM ?"While angels sing with pious mirth,"
13150 REM ?"A glad New Year to all the earth."
13160 PLAY "T140O3L4DC#O2BO3C#O2ABO3C#D."
13170 PLAY "O3DDO2AAF#8G8AGF#."
13180 PLAY "F#BBA8B8O3C#D8C#8o2BA."
13190 PLAY "O3DC#O2BAB8A8G8F#8ED."
13200 SYSTEM
13210 REM *********************************************************************
13220 REM
13230 REM *********************************************************************
13240 REM

