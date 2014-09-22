CHDIR ".\programs\samples\qb45com\action\arqanoid"

DECLARE SUB DoEnding ()
DECLARE SUB DoLogos ()
DECLARE SUB LoadTitle ()
DECLARE SUB DoIntro ()
DECLARE SUB DoStory ()
DECLARE SUB LoadFlyExpImage ()
DECLARE SUB DoLangaw (Stat%)
DECLARE SUB CheckforLangaw (X%, Y%)
DECLARE SUB CalcLangawCoord ()
DECLARE SUB PutLangaw (X%, Y%, Axn%)
DECLARE SUB LoadLangawImage ()
DECLARE FUNCTION DoTimer% (MaxTime%)
DECLARE SUB PrintLives (EraseIt%)
DECLARE SUB CalcBombCoord (RandFactor%)
DECLARE SUB CheatError ()
DECLARE FUNCTION RGBCounter% (MaxCounter%)
DECLARE SUB EraseSaveFiles ()
DECLARE SUB Check4HoF ()
DECLARE SUB SortIt ()
DECLARE FUNCTION SubMenu% ()
DECLARE FUNCTION PullDown% (X%, Y%, Item$(), Italic%)
DECLARE SUB NameEntry ()
DECLARE SUB DoHallOfFame ()
DECLARE SUB LoadSaveFiles ()
DECLARE SUB DialogBox (X%, Y%, MaxLen%, MinColor%, Title$, Text$, Italic%, Sysmod%)
DECLARE SUB LoadGame ()
DECLARE SUB SaveGame ()
DECLARE SUB ScrollKgenTT (TopY%, Text$, Xscale%, Yscale%, MinColor%, Shadow%, OverTop%, OverTopY%, Italic%, FirstTime%)
DECLARE SUB DoCredits ()
DECLARE SUB DoGameOver ()
DECLARE SUB KgenTTFont (X%, Y%, Font$, MinColor%, Xscale%, Yscale%, Italic%)
DECLARE SUB GetDirection ()
DECLARE SUB SfxOpenDialog ()
DECLARE FUNCTION SpecialStage% (DX%, DY%, MaxLen%, Tmin%, Title$, Text$)
DECLARE SUB SfxPowerUp ()
DECLARE FUNCTION CheckPowerCaps% (X%, Y%)
DECLARE SUB DoPowerCaps (PowType%)
DECLARE SUB PutPowerCapsBG ()
DECLARE SUB GetPowerCapsBG ()
DECLARE SUB PutPowerCaps (X%, Y%, PowType%)
DECLARE SUB DoPadLsr ()
DECLARE SUB PutPadLsrBG (Image1%(), Image2%())
DECLARE SUB GetPadLsrBG (Image1%(), Image2%())
DECLARE SUB GetPadLsrCoord (I%)
DECLARE SUB PutPadLsr (X%, Y%)
DECLARE SUB LoadPadLsrImage ()
DECLARE SUB DrawBoss (BossX%, BossY%, BossFile$)
DECLARE SUB HazyFx ()
DECLARE SUB LoadPowerCapsImage ()
DECLARE SUB DoBallExp ()
DECLARE SUB LoadBallExpImage ()
DECLARE SUB LoadBallImage ()
DECLARE SUB LoadPaddleImage ()
DECLARE SUB DrawSpike (X%, Y%)
DECLARE FUNCTION MenuSub% ()
DECLARE SUB SndExplode ()
DECLARE SUB PutPointer (X%, Y%, X2%, Y2%)
DECLARE FUNCTION Menu% ()
DECLARE SUB LoadPointerImage ()
DECLARE SUB EraseKgen ()
DECLARE SUB FadeStep (R%, g%, B%)
DECLARE SUB GetBlkHoleBG ()
DECLARE SUB PutBlkHoleBG ()
DECLARE SUB GetBG (X1%, Y1%, X2%, Y2%, Image%())
DECLARE SUB DoExplode ()
DECLARE SUB LoadExplodeImage ()
DECLARE SUB PutBombBG ()
DECLARE SUB PutBomb (X%, Y%, Switch%)
DECLARE SUB DoBlkHole ()
DECLARE SUB DoBomb ()
DECLARE SUB PutBlkHole (X%, Y%)
DECLARE SUB PrintLevel ()
DECLARE SUB RefreshKey ()
DECLARE SUB MakeImageIndex (ImageArray%(), IndexArray%())
DECLARE SUB InitImageData (FileName$, ImageArray%())
DECLARE SUB LevelDoneBox ()
DECLARE SUB InitTrans ()
DECLARE SUB TransLuc (n%, X1%, Y1%, X2%, Y2%)
DECLARE SUB CheckBounceCounter (BounceCounter%)
DECLARE SUB ReInitBallSpd ()
DECLARE SUB RotateRGB ()
DECLARE SUB PrintScore ()
DECLARE SUB KgenFont (X%, Y%, Font$, MinColor%, Italic%)
DECLARE SUB LimitScore ()
DECLARE SUB ReinitValues ()
DECLARE SUB SelectLevel ()
DECLARE FUNCTION BossHit% (X%, Y%)
DECLARE SUB BlinkTile (Switch%)
DECLARE SUB CheckTile (X%, Y%)
DECLARE FUNCTION HitSpike% (X%, Y%)
DECLARE SUB StartGame ()
DECLARE SUB BlinkBoss ()
DECLARE SUB Init ()
DECLARE SUB RestoreColors ()
DECLARE SUB HideBuild ()
DECLARE SUB SaveColors ()
DECLARE SUB ReadRGB (C%, R%, g%, B%)
DECLARE SUB Fade (R%, g%, B%)
DECLARE SUB OpenLvlFile (File$)
DECLARE SUB DrawTile (X%, Y%, Clr%)
DECLARE SUB PlayGame ()
DECLARE SUB InitNums ()
DECLARE SUB PrintNum (X%, Y%, n$)
DECLARE FUNCTION Format$ (Score&)
DECLARE SUB PrintFonts (X%, Y%, n$)
DECLARE SUB DrawFonts ()
DECLARE SUB InitFonts ()
DECLARE FUNCTION Inside% (X%, Y%, X1%, Y1%, X2%, Y2%)
DECLARE SUB ReadLevel (Lvl%)
DECLARE SUB GetTileBackGround ()
DECLARE SUB InitValues ()
DECLARE SUB DrawBorder ()
DECLARE FUNCTION Collide% ()
DECLARE SUB GetBallCenter (BallCenterX%, BallCenterY%)
DECLARE SUB PutPaddle (PadX%, PadY%)
DECLARE FUNCTION MovePaddle% (PadX%, PadY%)
DECLARE SUB GetPaddleBG (PadX%, PadY%)
DECLARE FUNCTION FastKB% ()
DECLARE SUB PutBall (BallX%, BallY%)
DECLARE SUB GetBallBG (BallX%, BallY%)
DECLARE SUB PutBallBG (BallOldX%, BallOldY%)
DECLARE SUB DrawLevelBG (BGMode%, ColorStep%, ColorAttr%)
DECLARE SUB WriteRGB (C%, R%, g%, B%)
DECLARE SUB InitColors ()
DECLARE SUB MilliDelay (msecs%)
DECLARE SUB PutPaddleBG (PadOldX%, PadOldY%)
DECLARE SUB LoadBombImage ()
DECLARE SUB LoadBlkHoleImage ()
DEFINT A-Z
REM $DYNAMIC


'==========Type declarations====================================
TYPE TileType
        X       AS INTEGER
        Y       AS INTEGER
        C       AS INTEGER
        F       AS INTEGER
END TYPE

TYPE RGBtype
        R AS INTEGER
        g AS INTEGER
        B AS INTEGER
END TYPE

TYPE CoordType
        X       AS INTEGER
        Y       AS INTEGER
END TYPE

TYPE SaveType
        Num     AS INTEGER
        Namer    AS STRING * 12
        Score   AS LONG
        Level   AS INTEGER
        Lives   AS INTEGER
END TYPE

TYPE HallOfFameType
        Rank    AS INTEGER
        Namer   AS STRING * 12
        Score   AS LONG
END TYPE



'====================Constants==================================
'Misc Const
CONST False = 0, True = NOT False

'Screen const
CONST MinX = 0, MaxX = 260, MinY = 0, MaxY = 200

'KeyConstants
CONST KRight = 77, KLeft = 75, KDown = 80, KUp = 72, KEsc = 1
CONST KW = &H11, KA = &H1E, KS = &H1F, KD = &H20, KPgd = &H51
CONST KSpc = &H39, KEnt = &H1C, KCtrl = &H1D, KTab = &HF, KEnd = &H4F


'Paddle Const
CONST PadSpd = 3
'Ball Const
CONST BallRadius = 4

'Color Const
CONST PadColorMin = 30, PadColorMax = 39
CONST BorderMin = 40, Bordermax = 47
CONST SpikeMin = 50, SpikeMax = 57
CONST TcolorMin = 60, TcolorMax = 93
CONST FColorMin = 96, FcolorMax = 100
CONST KgenMin = 220, KgenMax = 227
CONST KgenBlueMin = 228, KgenBlueMax = 235
CONST KgenGreenMin = 236, KgenGreenMax = 243
CONST SnColorMin = 101, SnColorMax = 105
CONST BossColorMin = 106, BossColorMax = 121

'Offset and Tile Const
CONST OffsetBG = 122    'TileY=19(0 to 180/6), TileX=12(0 to 220/20)
CONST TileMax = 227 '0 to 227
CONST TileW = 19, TileH = 5   ' 0 to 19, 0 to 5 (20*6)

'Font constant
CONST FontOffset = 12  'Size of SmallFonts

'Directional Const
CONST UR = 1, UL = 2, DR = 3, DL = 4

'RGBCounter
CONST RGBC = 7    'for Counter of RotateRGB/RGBCounter function


'==================Shared Arrays===================
DIM SHARED Ball(1), BallBG(30), BallIndex(1)
DIM SHARED Paddle(1), PaddleIndex(1), PaddleBG(181 * 2)
DIM SHARED BackGround(27816) 'BackGround for erasing tiles
DIM SHARED SpikeBG(1) 'BackGround for erasing tiles
DIM SHARED Tile(TileMax) AS TileType
DIM SHARED Trans(256)
DIM SHARED SavRGB(0 TO 255) AS RGBtype
DIM SHARED Boss(1), BossMask(1), BossBG(1)
DIM SHARED BlkHole(1), BlkHoleMsk(1), BlkHoleIndex(1)
DIM SHARED BlkHoleXY(1 TO 4) AS CoordType
DIM SHARED BlkHoleBG(130 * 4)
DIM SHARED Bomb(1), BombMsk(1), BombIndex(1)
DIM SHARED BombXY(1 TO 91) AS CoordType
DIM SHARED BombBG(130 * 91)
DIM SHARED Explode(1 TO 1), Explodemsk(1 TO 1), ExplodeIndex(1 TO 1)
DIM SHARED BallExp(1 TO 1), BallExpmsk(1 TO 1), BallExpIndex(1 TO 1)
DIM SHARED Pointer(1 TO 1), PointerIndex(1 TO 1)
DIM SHARED PowerCaps(1), PowerCapsIndex(1)
DIM SHARED PowerCapsBG(1), PowerCapsCoord(0) AS CoordType, PowerCapsOldCoord(0) AS CoordType
DIM SHARED Padlsr(1), PadlsrIndex(1), PadLsrCoord(1) AS CoordType'(0 to 1)
DIM SHARED PadLsrBG1(1), PadLsrBG2(1), PadLsrOldCoord(1) AS CoordType
DIM SHARED Save(1 TO 8) AS SaveType
DIM SHARED Hall(1 TO 5) AS HallOfFameType
DIM SHARED Langaw(1 TO 1), LangawIndex(1 TO 1), LangawCoord(1) AS CoordType
DIM SHARED LangawOldCoord(1) AS CoordType, LangawBG1(1), LangawBG2(1), FlyExp(1)
DIM SHARED FlyExpIndex(1)

'==================Non-Global Arrays===============
DIM SmallFonts(396) AS INTEGER
DIM SmallNum(132) AS INTEGER

'==================Shared Variables
DIM SHARED BallOldX, BallOldY, BallX, BallY, BallXV, BallYV, Direction
DIM SHARED BallCenterX, BallCenterY 'Used to Process collission detection
DIM SHARED PadX, PadY, PadOldX, PadOldY
DIM SHARED Finished, BallSpd, Score&, OutStart, BounceCounter
DIM SHARED ColorAttr, ColorStep
DIM SHARED Level, TileNumber, GameOver, BossLife, BombNum, BombDes, MaxBomb, Lives
DIM SHARED PadPower, Replicant, BombSTG, BossStg
DIM SHARED SdHitPad, SdHitBoss, SdHitTile
DIM SHARED BossX, BossY, BossEnter, SpStage
DIM SHARED Shooting, Power, PowerType, Lshot, Rshot, AutoFire
DIM SHARED Path$


RANDOMIZE TIMER

CLS
SCREEN 13

'Path$ = "C:\qbasic\Arqanoid\"
'Path$ = "c:\rel\arqanoid\"
Path$ = ""
Init



DO

        PlayGame

LOOP UNTIL GameOver

Fade 0, 0, 0

DoGameOver


CLS
SCREEN 0
END

'====Data statements
Credits:


DATA "GOD/Jesus Christ"
DATA "   Gave me everything I have. LIFE."
DATA ""

DATA "Richard Eric M. Lope BSN RN"
DATA "   Coding/Story/Sound/Grafix(Mostly)."
DATA ""

DATA "Anya Therese Lope"
DATA "   Cutest & Loudest baby in the world!"
DATA ""

DATA "Pedro & Lily Lope"
DATA "   For their undying support."
DATA ""

DATA "Marie & Cristina Lope"
DATA "   Twinblades of Sara,Iloilo."
DATA ""

DATA "Loreni Farillon"
DATA "   Kitiki-TXT.2k dtym 2snd SMS L8@Nyt."
DATA ""

DATA "WIC I-net/Jason Babila,Alan,Shote&Tin2"
DATA "   Mabini St. Iloilo city."
DATA ""
                     
DATA "Archie Aurelio/Joey of Zap Zone"
DATA "   Arcade Game buddies."
DATA ""             

DATA "Special Thanks!!!"
DATA ""
DATA ""


DATA "Andrew Ayers (Blast Lib maker)"
DATA "   For his tutor on Get/Put offsetting."
DATA ""

DATA "Chris Chadwick (PP256 Developer)"
DATA "   PP256 made my life easier!!!"
DATA ""

DATA "Vance Velez (Vplanet)"
DATA "   Best Review site!!!"
DATA ""

DATA "Gianncarlo (GBGames)"
DATA "   Best QB link ever!!!"
DATA ""

DATA "Jorden Chamid (FutureSoft)"
DATA "   Best QB site. Period!!!"
DATA ""

DATA "Vic Luce (VQB Maker)"
DATA "   Great tutorial on Masking."
DATA ""

DATA "Danny Gump (VirtuaSoft-Dash Lib Maker)"
DATA "   Taught me the Get/Put Array system."
DATA ""

DATA "ZKman (?????)"
DATA "   Translucency(Non Alpha) Tutorial."
DATA ""


DATA "Steven Sivek (stevensivek@hotmail.com)"
DATA "   For the ROM address/Offset of text."
DATA ""

DATA "Dark Dread (Darkness Etherial)"
DATA "   DCrown perked me up 2 make a QBGame."
DATA ""

DATA "Andre(who are you?)"
DATA "   Used his MilliDelay in this game."
DATA ""

DATA "Nesticle"
DATA "   Heaven sent emulator!"
DATA ""

DATA "Kgen and LoopyNes"
DATA "   Great emulators!"
DATA ""

DATA "The QB Times"
DATA "   Provided me with BMP file system."
DATA ""

DATA "NeoZones"
DATA "   Got a lot of tutorials there!"
DATA ""

DATA "KONAMI(tm)"
DATA "   Ripped their LifeForce sprites."
DATA ""

DATA "IREM(tm),COMPILE(tm) & Broderbund(tm)"
DATA "   Ripped their Guardian Legend sprs."
DATA ""

DATA "TAXAN(tm)"
DATA "   Ripped their Burai Fighter sprites."
DATA ""

DATA "The Smashing Pumpkins"
DATA "   Best band in the world. Forever!"
DATA ""

DATA "PSYKYO"
DATA "   Strikers Series...Best Arcade Game!"
DATA ""

DATA "Samurai X & DragonBall Z"
DATA "   Animes I like very much."
DATA ""

DATA ""
DATA ""
DATA ""
DATA ""
DATA ""

DATA "End"



Story:

DATA "    From days of long ago, from the "
DATA "uncharted regions fo the universe, "
DATA "comes a legend... the Legend of"
DATA "BALOTRON!(Yeah, right. sounds familiar)"
DATA ""
DATA "    One day, while the people of"
DATA "BALOTLAND were living peacefully,"
DATA "Ten long years post the victory of their"
DATA "Gredius,Goardic, and Buray missions, a"
DATA "Balotland shattering BALOTQUAKE occured!"
DATA ""
DATA "    The inhabitants of BalotLand(Paddle-"
DATA "Like beings) panicked! And in the "
DATA "confusion the bacterial beings,"
DATA "imprisoned underground for ten years, "
DATA "led by the ever charming GIGA, seized"
DATA "control of the planet and imprisoned"
DATA "most of the BalotLings.  While the"
DATA "others were forced to do mining at"
DATA "the Obsidian lake which has precious"
DATA "stones below it, including Balotron's"
DATA "love, Balotae! BTW, Balotron wasn't"
DATA "captured(He was taking a nap outside"
DATA "the city. Or else we won't have a story)."
DATA ""
DATA "     Now armed w/ his trusty BALOTBALL,"
DATA "both embarked on a journey to save the "
DATA "people of Balotland.  But before they "
DATA "could save them and face GIGA, they"
DATA "must defeat his governors of Pain, and"
DATA "his army of... well, what else... "
DATA "COLORFUL BLOCKS!"
DATA "Nuff said! Let's begin..."
DATA ""
DATA ""
DATA ""
DATA ""
DATA ""
DATA ""
DATA "END"

Ending:

DATA 0,"--THE END--",220
DATA 20,"Balotron together w/ his friend",228
DATA 30,"Boy Balot, rescued princess",228
DATA 40,"Balotae from the clutches",228
DATA 50,"of GIGA, and his minions.",228
DATA 60,"the people of Balotland",228
DATA 70,"rejoiced and made our hero",228
DATA 80,"their king! (He wasn't",228
DATA 90,"supposed to be, but he married",228
DATA 100,"the princess so he will be.)",228
DATA 110,"Lucky him....",228
DATA 130,"However....",236
DATA 140,"this is an arcade game.",236
DATA 150,"so you have to continue your",236
DATA 160,"quest. Right from the start...",236
DATA 190,"End",228

'====End data



'=================temp

'-===================================================


Temp:

END

REM $STATIC
SUB BlinkBoss STATIC

        WAIT &H3DA, 8
        SOUND 1000, .2
        SOUND 500, .4

        FOR I = 106 TO 121
                WriteRGB I, 0, 63, INT(RND * 63)
        NEXT I

        SOUND 1000, .3
        SOUND 700, .2
        WAIT &H3DA, 8

        FOR I = 106 TO 121
                R = SavRGB(I).R
                g = SavRGB(I).g
                B = SavRGB(I).B
                WriteRGB I, R, g, B
        NEXT I

        SOUND 1000, .2

END SUB

SUB BlinkTile (Switch%) STATIC

IF Switch THEN
        FOR I = 84 TO 86
                WriteRGB I, 63, 0, INT(RND * 63)
        NEXT I
ELSE
        FOR I = 84 TO 86
                R = SavRGB(I).R
                g = SavRGB(I).g
                B = SavRGB(I).B
                WriteRGB I, R, g, B
        NEXT I
END IF

END SUB

FUNCTION BossHit (X, Y) STATIC



BossHit = False
IF POINT(X, Y) >= BossColorMin AND POINT(X, Y) <= BossColorMax THEN
        BossHit = True
        BlinkBoss
        Score& = Score& + 2000&
        LimitScore
        PrintScore
        BossLife = BossLife - 100
        REM GOSUB InitPwrCaps   'Disabled for OverKill Reasons unrem if u want 2 have powerups on bosses
        GOSUB CheckBossKilled
END IF


EXIT FUNCTION


'=========Subs===============

CheckBossKilled:

IF BossLife <= 0 THEN

        PutBlkHoleBG
        PutBombBG
        LevelDoneBox
        EraseKgen
        PrintLives True

        T1& = TIMER
                       
        DO
                T2& = TIMER
                KK$ = INKEY$
                IF KK$ = CHR$(13) THEN EXIT DO

                DoExplode
                FadeStep 0, 0, 0

                SndExplode
        LOOP UNTIL T2& - T1& > 9&

        Finished = True
        IF Level = 50 THEN
                DoEnding
        END IF

END IF

RETURN

'==================
InitPwrCaps:

IF NOT Power THEN

        PowPow = INT(RND * 5)
        IF PowPow = 1 THEN
                Power = True
                PowerCapsCoord(0).X = 10 + INT(RND * 220)
                PowerCapsCoord(0).Y = 10 + INT(RND * 50)
                        PutPadLsrBG PadLsrBG1(), PadLsrBG2()
                GetPowerCapsBG
                PowerType = 1 + INT(RND * 3)
        END IF
END IF

RETURN


END FUNCTION

SUB CalcBombCoord (RandFactor) STATIC

I = 0
FOR Y = 10 TO 108 STEP 16
FOR X = 26 TO 220 STEP 16
        Rand = 1 + INT(RND * RandFactor)
        IF Rand = 1 THEN
        IF I < 100 THEN
        I = I + 1
                BombXY(I).X = X
                BombXY(I).Y = Y
        END IF
        END IF
NEXT X
NEXT Y

BombNum = I
MaxBomb = BombNum
BombSTG = True


END SUB

SUB CalcLangawCoord STATIC

LangawCoord(0).X = BlkHoleXY(1 + INT(RND * 4)).X
LangawCoord(0).Y = BlkHoleXY(1 + INT(RND * 4)).Y
LangawCoord(1).X = BlkHoleXY(1 + INT(RND * 4)).X
LangawCoord(1).Y = BlkHoleXY(1 + INT(RND * 4)).Y

GetBG LangawOldCoord(0).X, LangawOldCoord(0).Y, LangawOldCoord(0).X + 16, LangawOldCoord(0).Y + 16, LangawBG1()
GetBG LangawOldCoord(1).X, LangawOldCoord(1).Y, LangawOldCoord(1).X + 16, LangawOldCoord(1).Y + 16, LangawBG2()

END SUB

SUB CheatError STATIC

DX = 26
DY = 40
MaxLen = 26
Title$ = "     Cheat Error!!!"
Tmin = PadColorMin
Sysmod = True
Text$ = CHR$(11) + " Sorry! I intentionally disabled this cheat code on SPECIAL STAGES because I think it would be an overkill... ie. 2 easy a game."
DialogBox DX, DY, MaxLen, Tmin, Title$, Text$, False, Sysmod


END SUB

SUB Check4HoF STATIC

IF Score& > Hall(5).Score THEN
        NameEntry
END IF

END SUB

SUB CheckBounceCounter (BounceCounter) STATIC

        IF BounceCounter < 50 THEN
                BounceCounter = BounceCounter + 1
        END IF
                SELECT CASE BounceCounter
                        CASE IS <= 40
                                BallSpd = 1
                                ReInitBallSpd
                        CASE IS = 41
                                BallSpd = 2
                                ReInitBallSpd
                        CASE ELSE
                END SELECT


END SUB

SUB CheckforLangaw (X, Y) STATIC

IF Inside(X, Y, LangawCoord(0).X, LangawCoord(0).Y, LangawCoord(0).X + 16, LangawCoord(0).Y + 16) THEN
        PUT (LangawOldCoord(0).X, LangawOldCoord(0).Y), LangawBG1, PSET
        GOSUB XFlies
        LangawCoord(0).X = BlkHoleXY(1 + INT(RND * 4)).X
        LangawCoord(0).Y = BlkHoleXY(1 + INT(RND * 4)).Y
        GetBG LangawOldCoord(0).X, LangawOldCoord(0).Y, LangawOldCoord(0).X + 16, LangawOldCoord(0).Y + 16, LangawBG1()
ELSEIF Inside(X, Y, LangawCoord(1).X, LangawCoord(1).Y, LangawCoord(1).X + 16, LangawCoord(1).Y + 16) THEN
        PUT (LangawOldCoord(1).X, LangawOldCoord(1).Y), LangawBG2, PSET
        GOSUB XFlies
        LangawCoord(1).X = BlkHoleXY(1 + INT(RND * 4)).X
        LangawCoord(1).Y = BlkHoleXY(1 + INT(RND * 4)).Y
        GetBG LangawOldCoord(1).X, LangawOldCoord(1).Y, LangawOldCoord(1).X + 16, LangawOldCoord(1).Y + 16, LangawBG2()
END IF

EXIT SUB


XFlies:
        REDIM Temp(1)
        GetBG X - 5, Y - 5, (X - 5) + 25, (Y - 5) + 25, Temp()
        PUT (X - 5, Y - 5), FlyExp(FlyExpIndex(2)), AND
        PUT (X - 5, Y - 5), FlyExp(FlyExpIndex(1)), OR
        FOR J = 0 TO 3
                WAIT &H3DA, 8
                WAIT &H3DA, 8, 8
                SOUND 1500 - (J * 150), .3
        NEXT J
        BounceCounter = 40
        Score& = Score& + 11
        LimitScore
        PrintScore
        PUT (X - 5, Y - 5), Temp, PSET
        ERASE Temp

RETURN


END SUB

FUNCTION CheckPowerCaps (X, Y) STATIC


CheckPowerCaps = False

IF Inside(X, Y, PowerCapsCoord(0).X, PowerCapsCoord(0).Y, PowerCapsCoord(0).X + 20, PowerCapsCoord(0).Y + 10) THEN
        CheckPowerCaps = True
END IF

END FUNCTION

SUB CheckTile (X, Y) STATIC

FOR I = 0 TO 227
   IF Tile(I).F THEN
        IF Inside(X, Y, Tile(I).X, Tile(I).Y, Tile(I).X + TileW, Tile(I).Y + TileH) THEN
                GOSUB FindType
                LimitScore
                PrintScore
                GOSUB InitPowerCaps
        END IF
   END IF
NEXT I

EXIT SUB

'===========================================================================
FindType:
        SELECT CASE Tile(I).C
                CASE 1
                        SOUND 700, .5
                        Score& = Score& + 100&
                        GOSUB DestroyTiles
                CASE 2
                        SOUND 900, .5
                        Score& = Score& + 200&
                        GOSUB DestroyTiles
                CASE 3
                        SOUND 1100, .5
                        Score& = Score& + 300&
                        GOSUB DestroyTiles
                CASE 4
                        SOUND 1300, .5
                        Score& = Score& + 400&
                        GOSUB DestroyTiles
                CASE 5
                        SOUND 1500, .5
                        Score& = Score& + 500&
                        GOSUB DestroyTiles
                CASE 6
                        SOUND 1700, .5
                        Score& = Score& + 600&
                        GOSUB DestroyTiles
                CASE 7
                        SOUND 1900, .5
                        Score& = Score& + 700&
                        Tile(I).C = Tile(I).C - 1  'Change Tile
                        DrawTile Tile(I).X, Tile(I).Y, Tile(I).C
                CASE 8
                        SOUND 2100, .5
                        Score& = Score& + 800&
                        Tile(I).C = Tile(I).C - 1 'Change Tile
                        DrawTile Tile(I).X, Tile(I).Y, Tile(I).C
                CASE 9
                        SdHitTile = True
                        BlinkTile True
                CASE ELSE
        END SELECT
RETURN


DestroyTiles:


        IF Power THEN
                IF CheckPowerCaps(X, Y) THEN
                       PutPowerCapsBG
                       Power = False
                END IF
        END IF

        PUT (Tile(I).X, Tile(I).Y), BackGround(I * OffsetBG), PSET
        Tile(I).F = False

        'Check if all Tiles are Destroyed
        TileNumber = TileNumber - 1

                IF TileNumber < 1 THEN

                        LevelDoneBox
                        Shooting = False
                        Lshot = False
                        Rshot = False
                        T1& = TIMER
                        DO
                                T2& = TIMER
                                KK$ = INKEY$
                                IF KK$ = CHR$(13) THEN EXIT DO
                                WAIT &H3DA, 8
                                WAIT &H3DA, 8, 8
                                IF RGBCounter(RGBC * 5) THEN
                                        RotateRGB
                                END IF

                        LOOP UNTIL T2& - T1& > 7&

                        Finished = True
                        OutStart = True
                END IF

RETURN

'========
InitPowerCaps:

IF NOT Power THEN
   IF Tile(I).C <> 9 THEN
        PowPow = INT(RND * 10)
        IF PowPow = 1 THEN
                Power = True
                PowerCapsCoord(0).X = Tile(I).X
                PowerCapsCoord(0).Y = Tile(I).Y
                        PutPadLsrBG PadLsrBG1(), PadLsrBG2()
                GetPowerCapsBG
                PowerType = 1 + INT(RND * 3)
        END IF
   END IF
END IF

RETURN


END SUB

FUNCTION Collide STATIC
'This is the heart and soul of the game! this may be long and confusing but
'I made great effort in trying to make this as comprehensive as possible!
'If you still don't understand, print it!


IF BombSTG THEN
        IF DoTimer(61) THEN
                Perfect = False
                GOSUB Endit
        END IF
END IF

Collide = False
BallSS = BallSpd

BallX = BallX + BallXV
BallY = BallY + BallYV

GetBallCenter BallCenterX, BallCenterY

GetDirection

SELECT CASE Direction
    CASE UR
        IF POINT(BallCenterX + (BallRadius + BallSS), BallCenterY) < 129 THEN 'Right
                X = BallCenterX + (BallRadius + BallSS)
                Y = BallCenterY
                BallXV = -BallXV
                'BallX = BallX + BallXV
                Collide = True
                GOSUB CheckForSpike
                IF BossStg THEN GOSUB CheckForBossHit
                GOSUB CheckForPadHit
                GOSUB CheckForPowerHit
                GOSUB CheckForTile
                IF BombSTG THEN GOSUB Check4Bomb
                IF BossStg THEN CheckforLangaw X, Y
        ELSEIF POINT(BallCenterX, BallCenterY - (BallRadius + BallSS)) < 129 THEN  'Up
                X = BallCenterX
                Y = BallCenterY - (BallRadius + BallSS)
                BallYV = -BallYV
                'BallY = BallY + BallYV
                Collide = True
                GOSUB CheckForSpike
                IF BossStg THEN GOSUB CheckForBossHit
                GOSUB CheckForPadHit
                GOSUB CheckForPowerHit
                GOSUB CheckForTile
                IF BombSTG THEN GOSUB Check4Bomb
                IF BossStg THEN CheckforLangaw X, Y
        ELSE
        END IF

    CASE UL
        IF POINT(BallCenterX - (BallRadius + BallSS), BallCenterY) < 129 THEN  'Left
                        X = BallCenterX - (BallRadius + BallSS)
                        Y = BallCenterY
                        BallXV = -BallXV
                        'BallX = BallX + BallXV
                        Collide = True
                        GOSUB CheckForSpike
                        IF BossStg THEN GOSUB CheckForBossHit
                        GOSUB CheckForPadHit
                        GOSUB CheckForPowerHit
                        GOSUB CheckForTile
                        IF BombSTG THEN GOSUB Check4Bomb
                        IF BossStg THEN CheckforLangaw X, Y
        ELSEIF POINT(BallCenterX, BallCenterY - (BallRadius + BallSS)) < 129 THEN  'Up
                X = BallCenterX
                Y = BallCenterY - (BallRadius + BallSS)
                BallYV = -BallYV
                'BallY = BallY + BallYV
                Collide = True
                GOSUB CheckForSpike
                IF BossStg THEN GOSUB CheckForBossHit
                GOSUB CheckForPadHit
                GOSUB CheckForPowerHit
                GOSUB CheckForTile
                IF BombSTG THEN GOSUB Check4Bomb
                IF BossStg THEN CheckforLangaw X, Y
        ELSE
        END IF

    CASE DR
        IF POINT(BallCenterX + (BallRadius + BallSS), BallCenterY) < 129 THEN 'Right
                X = BallCenterX + (BallRadius + BallSS)
                Y = BallCenterY
                BallXV = -BallXV
                'BallX = BallX + BallXV
                Collide = True
                GOSUB CheckForSpike
                IF BossStg THEN GOSUB CheckForBossHit
                GOSUB CheckForPadHit
                GOSUB CheckForPowerHit
                GOSUB CheckForTile
                IF BombSTG THEN GOSUB Check4Bomb
                IF BossStg THEN CheckforLangaw X, Y
        ELSEIF POINT(BallCenterX, BallCenterY + (BallRadius + BallSS)) < 129 THEN 'Up
                X = BallCenterX
                Y = BallCenterY + (BallRadius + BallSS)
                BallYV = -BallYV
                'BallY = BallY + BallYV
                Collide = True
                GOSUB CheckForSpike
                IF BossStg THEN GOSUB CheckForBossHit
                GOSUB CheckForPadHit
                GOSUB CheckForPowerHit
                GOSUB CheckForTile
                IF BombSTG THEN GOSUB Check4Bomb
                IF BossStg THEN CheckforLangaw X, Y
        ELSE
        END IF

    CASE DL
        IF POINT(BallCenterX - (BallRadius + BallSS), BallCenterY) < 129 THEN  'Left
                        X = BallCenterX - (BallRadius + BallSS)
                        Y = BallCenterY
                        BallXV = -BallXV
                        'BallX = BallX + BallXV
                        Collide = True
                        GOSUB CheckForSpike
                        IF BossStg THEN GOSUB CheckForBossHit
                        GOSUB CheckForPadHit
                        GOSUB CheckForPowerHit
                        GOSUB CheckForTile
                        IF BombSTG THEN GOSUB Check4Bomb
                        IF BossStg THEN CheckforLangaw X, Y
        ELSEIF POINT(BallCenterX, BallCenterY + (BallRadius + BallSS)) < 129 THEN 'Up
                X = BallCenterX
                Y = BallCenterY + (BallRadius + BallSS)
                BallYV = -BallYV
                'BallY = BallY + BallYV
                Collide = True
                GOSUB CheckForSpike
                IF BossStg THEN GOSUB CheckForBossHit
                GOSUB CheckForPadHit
                GOSUB CheckForPowerHit
                GOSUB CheckForTile
                IF BombSTG THEN GOSUB Check4Bomb
                IF BossStg THEN CheckforLangaw X, Y
        ELSE
        END IF


    CASE ELSE
END SELECT



EXIT FUNCTION

'=======================Subroutines=====================================


CheckForBossHit:
        IF BossHit(X, Y) THEN
        END IF
RETURN

CheckForTile:
        CheckTile X, Y
RETURN


CheckForSpike:

        IF HitSpike(X, Y) THEN

                SOUND 900, 1

                PutBallBG BallOldX, BallOldY
                PutPaddleBG PadOldX, PadOldY
                DoBallExp
                StartGame
                EXIT FUNCTION
        END IF

RETURN

'==============
CheckForPadHit:

        IF POINT(X, Y) >= PadColorMin AND POINT(X, Y) <= PadColorMax THEN
                SdHitPad = True
        END IF


RETURN

'===============
CheckForPowerHit:

IF CheckPowerCaps(X, Y) THEN

   IF Power THEN
        PutPowerCapsBG
        Power = False
        PutPaddleBG PadOldX, PadOldY
                SELECT CASE PowerType
                        CASE 1  'PadPower
                                IF NOT PadPower THEN
                                        PadPower = True
                                        GetPadLsrCoord 0
                                        GetPadLsrBG PadLsrBG1(), PadLsrBG2()
                                        SfxPowerUp
                                END IF
                        CASE 2 'Replicant
                                Replicant = True
                                        SfxPowerUp
                        CASE 3 '1Up
                                Lives = Lives + 1
                                IF Lives > 100 THEN Lives = 100
                                PrintLives False
                                        SfxPowerUp
                        CASE ELSE
                END SELECT
     END IF
END IF

RETURN


'=========================
Check4Bomb:

        FOR I = 1 TO UBOUND(BombXY)
                IF BombXY(I).X <> 0 THEN

                IF Inside(X, Y, BombXY(I).X, BombXY(I).Y, BombXY(I).X + 16, BombXY(I).Y + 16) THEN
                        PUT (BombXY(I).X, BombXY(I).Y), BombBG(130 * (I - 1)), PSET
                        II = 1 + INT(RND * UBOUND(ExplodeIndex))
                        REDIM Temp(1)
                        GetBG BombXY(I).X, BombXY(I).Y, BombXY(I).X + 25, BombXY(I).Y + 25, Temp()
                        PUT (BombXY(I).X, BombXY(I).Y), Explodemsk(ExplodeIndex(II)), AND
                        PUT (BombXY(I).X, BombXY(I).Y), Explode(ExplodeIndex(II)), OR
                        FOR J = 0 TO 3
                                WAIT &H3DA, 8
                                WAIT &H3DA, 8, 8
                                SOUND 400 - (J * 50), .3
                        NEXT J
                        PUT (BombXY(I).X, BombXY(I).Y), Temp, PSET
                        BombXY(I).X = 0
                        BombXY(I).Y = 0
                        ERASE Temp
                        BombNum = BombNum - 1
                        BombDes = BombDes + 1


                        IF BombNum < 1 THEN
                                Perfect = True
                                GOSUB Endit
                        END IF
                END IF

                END IF

        NEXT I

RETURN

'=-==========

Endit:

'=======================

DX = 47
DY = 10
MaxLen = 21
Tmin = PadColorMin
Sysmod = False
IF NOT Perfect THEN
        Title$ = "       Bonus"
        Text$ = "2000   x   =       "
ELSE
        Title$ = "     Perfect!!!"
        Text$ = "2000   x   =       "
        Text$ = Text$ + "**Bonus   +20,000**"
END IF

REDIM DBTemp(1)  'for DialogBox
REDIM BTemp(1)   'For num BG

GetBG DX, DY, DX + MaxLen * 8, DY + 37, DBTemp()
SOUND 500, 1
SOUND 1300, 2
DialogBox DX, DY, MaxLen, Tmin, Title$, Text$, False, Sysmod
GetBG DX + (13 * 8) - 3, DY + 13, (DX + (13 * 8)) + 8 * 7, DY + 13 + 8, BTemp()
KgenFont DX + 8 * 9, DY + 14, LTRIM$(STR$(BombDes)), KgenMin, False

VL& = BombDes * 2000&

Inc = 200

DO

        KgenFont DX + 86 + (9 * 8) - (LEN(LTRIM$(STR$(VL&))) * 8), DY + 14, LTRIM$(STR$(VL&)), KgenBlueMin, False
        IF RGBCounter(RGBC * 4) THEN RotateRGB
        WAIT &H3DA, 8
        WAIT &H3DA, 8, 8
        SOUND 2500, .5
        SOUND 3000, .2
        VL& = VL& - Inc
        Score& = Score& + Inc
        LimitScore
        PrintScore

        WAIT &H3DA, 8
        WAIT &H3DA, 8, 8

        PUT (DX + (13 * 8) - 3, DY + 13), BTemp, PSET
IF VL& <= 0 THEN
        IF Perfect THEN
                VL& = VL& + 20000&
                Perfect = False
                KgenFont DX + 86 + (9 * 8) - (LEN(LTRIM$(STR$(VL&))) * 8), DY + 14, LTRIM$(STR$(VL&)), KgenBlueMin, False
                SOUND 1500, 1
                SOUND 3500, 1
                FOR II = 1 TO 10
                        RotateRGB
                        MilliDelay 100
                NEXT II
        END IF
END IF

LOOP UNTIL VL& <= 0 AND NOT Perfect


PUT (DX, DY), DBTemp, PSET

'=======================

LevelDoneBox
Shooting = False
Lshot = False
Rshot = False
T1& = TIMER
DO
        T2& = TIMER
        KK$ = INKEY$
        IF KK$ = CHR$(13) THEN EXIT DO
        WAIT &H3DA, 8
        WAIT &H3DA, 8, 8
        IF RGBCounter(RGBC * 3) THEN
                RotateRGB
        END IF

LOOP UNTIL T2& - T1& > 7&

Finished = True
OutStart = True

RETURN



END FUNCTION

SUB DialogBox (X, Y, MaxLen, MinColor, Title$, Text$, Italic, Sysmod)

'========Draws an auto wrap text DialogBox
'=========Sample code=====================
'Note: to Indent first row, Pls use "~~~~" instead of Space
                'DX = 22
                'DY = 70
                'MaxLen = 27
                'Title$ = "SAVOT"
                'Tmin = PadColorMin
                'SysMod=True
                'Text$ = "~~~~This would be your last stop! Ull die here 4 sure. I Savot will shave all of your hair! Mwa ha ha ha..."
                'DialogBox DX, DY, MaxLen, Tmin, Title$, Text$, False,Sysmod
'=========End Sample=======================

DIM Row$(24)  'Maximum number of Rows
REDIM Dtemp(1)  'Array for background

P = 1
CurrentRow = 1
Leng = LEN(Text$)

WHILE P < Leng + 1
        WHILE Char$ <> " " AND P < Leng + 1
                Char$ = MID$(Text$, P, 1)
                        IF Char$ <> " " THEN
                                Word$ = Word$ + Char$
                        END IF
                        P = P + 1
        WEND
       
        IF LEN(Row$(CurrentRow)) + LEN(Word$) + 1 < MaxLen THEN
                Row$(CurrentRow) = Row$(CurrentRow) + " " + Word$
        ELSE
                CurrentRow = CurrentRow + 1
                Row$(CurrentRow) = Row$(CurrentRow) + " " + Word$
        END IF
        Word$ = ""
        Char$ = ""

WEND


X1 = X + 5
Y1 = Y + 5

IF Title$ <> "" THEN
        CurrentRow = CurrentRow + 1
        PosStart = 2
        Y1 = Y1 + 9
ELSE
        PosStart = 1
END IF


'DrawTrnsBox

TX1 = X
TY1 = Y
IF Italic THEN
        TX2 = (MaxLen * 8) + TX1 + 8
ELSE
        TX2 = (MaxLen * 8) + TX1
END IF

TY2 = (CurrentRow * 9) + TY1 + 9

GetBG TX1, TY1, TX2, TY2, Dtemp()

TransLuc 170, TX1, TY1, TX2, TY2   '170 best


'Print it
'Title
IF PosStart > 1 THEN
        Font$ = Title$
        KgenFont X1 - 2, Y + 5, Font$, PadColorMin, Italic
        KgenFont X1 - 1, Y + 4, Font$, KgenGreenMin, Italic
END IF



FOR I = 1 TO CurrentRow
        IF I = 1 THEN
                Font$ = LTRIM$(Row$(I))
                IF LEFT$(Font$, 4) = "~~~~" THEN
                        Font$ = SPACE$(4) + RIGHT$(Font$, LEN(Font$) - 4)
                END IF
        ELSE
                Font$ = LTRIM$(Row$(I))
        END IF
        KgenFont X1, Y1, Font$, MinColor, Italic
        Y1 = Y1 + (9)
NEXT I

DO
        IF RGBCounter(RGBC * 5) THEN RotateRGB
        WAIT &H3DA, 8
        K$ = INKEY$
LOOP UNTIL K$ = CHR$(13) OR K$ = CHR$(27) OR NOT Sysmod

SfxOpenDialog

IF Sysmod THEN
        PUT (TX1, TY1), Dtemp, PSET
ELSE

END IF

RefreshKey

ERASE Row$, Dtemp

END SUB

SUB DoBallExp STATIC


Lives = Lives - 1

GetPaddleBG PadX, PadY

PutPaddle PadX, PadY

REDIM ExpTemp(1)

FOR J = 1 TO 2

GetBG BallX - 5, BallY - 5, (BallX - 5) + 19, (BallY - 5) + 19, ExpTemp()
SD = 110
FOR I = 1 TO UBOUND(BallExpIndex)
        SD = SD * (2 + (INT(RND * 3)))
        PUT (BallX - 5, BallY - 5), BallExpmsk(BallExpIndex(I)), AND
        PUT (BallX - 5, BallY - 5), BallExp(BallExpIndex(I)), OR

        WAIT &H3DA, 8
        MilliDelay 50

        SOUND SD, .5

NEXT I

PUT (BallX - 5, BallY - 5), ExpTemp, PSET

NEXT J


IF PadPower THEN
        PutPadLsrBG PadLsrBG1(), PadLsrBG2()
        PadPower = False
END IF
IF Replicant THEN
        Replicant = False
END IF


PutPaddleBG PadOldX, PadOldY

IF PadPower THEN
        PutPadLsrBG PadLsrBG1(), PadLsrBG2()
END IF

IF Power THEN
        PutPowerCapsBG
END IF


END SUB

SUB DoBlkHole STATIC

FOR I = 1 TO 4
        IF BlkHoleXY(I).X <> 0 THEN
                PutBlkHole BlkHoleXY(I).X, BlkHoleXY(I).Y
        END IF
NEXT I

END SUB

SUB DoBomb STATIC


FOR I = 1 TO UBOUND(BombXY)
        IF BombXY(I).X <> 0 THEN
                GET (BombXY(I).X, BombXY(I).Y)-STEP(15, 15), BombBG(130 * (I - 1))
        END IF
NEXT I

SW = NOT SW
IF SW THEN
        Switch = 1
ELSE
        Switch = 2
END IF

FOR I = 1 TO UBOUND(BombXY)
        IF BombXY(I).X <> 0 THEN
                PutBomb BombXY(I).X, BombXY(I).Y, Switch
        END IF
NEXT I

END SUB

SUB DoCredits


Fade 0, 0, 0
LINE (0, 0)-(319, 199), 0, BF

VS = 4
VE = 23
VIEW PRINT VS TO VE
RESTORE Credits

X = 320
Y = 0
Xscale = 1
Yscale = 1
Font$ = "-Shameless Self-Promotion-"
Italic = False
KgenTTFont 159 - (4 * Xscale * LEN(Font$)), Y - 1, Font$, PadColorMin, Xscale, Yscale, Italic
KgenTTFont X, Y, Font$, KgenGreenMin, Xscale, Yscale, Italic


Text$ = "Pls. visit these sites.... 1.[WWW.QB45.com]   2.[GBGames.com]  "
Text$ = Text$ + "3.[WWW.Hulla-Balloo.Com/Members/Vplanet/Index.Shtml]   4.[NeoZones.teksCode.com]  "
Text$ = Text$ + "4.[WWW.ChainMailSales.com/Virtuasoft/] 5.[WWW.BasicGuru.com/abc]  "
Text$ = Text$ + "6.[Members.Aol.Com/RadioHands/Index.Html 7.[www.geocities.com/TimesSquare/Ring/1683/Index.Html/     "
Xscale = 2
Yscale = 1
TopY = 199 - ((Yscale) * 9)
MinColor = KgenBlueMin
Shadow = True
OverTop = True
OtY = 10
Italic = True
FirstTime = True

RestoreColors

DO

K$ = INKEY$
ScrollKgenTT TopY, Text$, Xscale, Yscale, MinColor, Shadow, OverTop, OtY, Italic, FirstTime

IF RGBCounter(RGBC * 5) THEN RotateRGB

KC = KC MOD 188 + 1
IF KC = 1 THEN
        READ T$
        IF UCASE$(T$) = "END" THEN
                EXIT DO
        END IF

        LOCATE VE, 1
        PRINT
        FC = FC MOD 3 + 1
        IF FC = 1 THEN
                KgenFont 0, 176, T$, KgenGreenMin, False
        ELSE
                KgenFont 0, 176, T$, PadColorMin, True
        END IF
END IF

LOOP UNTIL K$ = CHR$(13)


OutStart = True
Finished = True
Level = Level - 1



END SUB

SUB DoEnding STATIC

REDIM Font(1)
LINE (0, 0)-(319, 199), 0, BF
RestoreColors

Txt$ = "Congratulations!!! You have beaten the game!  "
Txt$ = Txt$ + "My hats off to you. Relsoft 2000.  "
Xscale = 1
Yscale = 3
TopY = 199 - ((Yscale) * 9)
MinColor = KgenBlueMin
Shadow = True
OverTop = False
OtY = 0
Italic = True
FirstTime = True

X = 0
RESTORE Ending
EndRead = False

DO
        IF NOT EndRead THEN
                READ Y
                READ Text$
                READ Clr
        ELSE
                ScrollKgenTT TopY, Txt$, Xscale, Yscale, MinColor, Shadow, OverTop, OtY, Italic, FirstTime
                IF RGBCounter(RGBC * 5) THEN RotateRGB
        END IF
        IF UCASE$(Text$) = "END" THEN
                EndRead = True
        ELSE
                GOSUB MoveIt
        END IF
LOOP UNTIL INKEY$ <> ""

HazyFx
Fade 0, 0, 0
LINE (0, 0)-(319, 199), 0, BF

EXIT SUB

MoveIt:

FOR I = 1 TO LEN(Text$)

        Font$ = MID$(Text$, (LEN(Text$) + 1) - I, 1)

        IF Font$ <> " " THEN
                KgenFont X, Y, Font$, Clr, False
                Center = (160 + (LEN(Text$) * 9) \ 2) - (9 * I)
                GetBG 0, Y, 9, Y + 9, Font()
                FOR J = 0 TO Center
                        PUT (J, Y), Font, PSET
                        Scount = Scount MOD 16 + 1
                        IF Scount = 1 THEN
                                ScrollKgenTT TopY, Txt$, Xscale, Yscale, MinColor, Shadow, OverTop, OtY, Italic, FirstTime
                                IF RGBCounter(RGBC * 5) THEN RotateRGB
                        END IF
                        K$ = INKEY$
                        IF K$ = CHR$(13) THEN
                                HazyFx
                                Fade 0, 0, 0
                                LINE (0, 0)-(319, 199), 0, BF
                                EXIT SUB
                        END IF
                NEXT J
        END IF

NEXT I


RETURN




END SUB

SUB DoExplode STATIC


Xmax = (Boss(0) \ 8 - 1) - 25
Ymax = (Boss(1) - 1) - 25
I = I MOD UBOUND(ExplodeIndex) + 1

X = BossX + INT(RND * Xmax)
Y = BossY + INT(RND * Ymax)
X1 = BossX + INT(RND * Xmax)
Y1 = BossY + INT(RND * Ymax)
X2 = BossX + INT(RND * Xmax)
Y2 = BossY + INT(RND * Ymax)
X3 = BossX + INT(RND * Xmax)
Y3 = BossY + INT(RND * Ymax)


        PUT (X, Y), Explodemsk(ExplodeIndex(I)), AND
        PUT (X, Y), Explode(ExplodeIndex(I)), OR
        PUT (X1, Y1), Explodemsk(ExplodeIndex(I)), AND
        PUT (X1, Y1), Explode(ExplodeIndex(I)), OR
        PUT (X2, Y2), Explodemsk(ExplodeIndex(I)), AND
        PUT (X2, Y2), Explode(ExplodeIndex(I)), OR
        PUT (X3, Y3), Explodemsk(ExplodeIndex(I)), AND
        PUT (X3, Y3), Explode(ExplodeIndex(I)), OR

WAIT &H3DA, 8
WAIT &H3DA, 8, 8
MilliDelay 100

PUT (BossX, BossY), BossBG, PSET
PUT (BossX, BossY), BossMask, AND
PUT (BossX, BossY), Boss, OR

RotateRGB



END SUB

SUB DoGameOver STATIC

LINE (0, 0)-(320, 199), 0, BF
HideBuild


X = 320
Y = 80
Xscale = 3
Yscale = 4
Font$ = "Game Over!"
Italic = False
KgenTTFont 159 - (4 * Xscale * LEN(Font$)), Y - 1, Font$, KgenMin, Xscale, Yscale, Italic
KgenTTFont X, Y, Font$, KgenGreenMin, Xscale, Yscale, Italic

X = 320
Y = 60
Font$ = "Press [ESC] while playing 4 the MENU."
Italic = False
KgenFont X, Y, Font$, KgenMin, Italic

X = 320
Y = 130
Font$ = "vic_viperph@yahoo.com"
Italic = False
KgenFont X, Y, Font$, KgenMin, Italic

X = 320
Y = 120
Font$ = "Info on Level Designer is in Readme.Txt"
Italic = False
KgenFont X, Y, Font$, KgenMin, Italic



Text$ = " You lost!!! Pls. try again.... Go for the Record!!! You may become the first Hall Of Famer!!!   "
Xscale = 3
Yscale = 5
TopY = 199 - ((Yscale) * 9)
MinColor = KgenBlueMin
Shadow = True
OverTop = True
OtY = 0
Italic = True
FirstTime = True

RestoreColors

DO
K$ = INKEY$
ScrollKgenTT TopY, Text$, Xscale, Yscale, MinColor, Shadow, OverTop, OtY, Italic, FirstTime
IF RGBCounter(RGBC * 5) THEN RotateRGB
LOOP UNTIL K$ = CHR$(13) OR K$ = CHR$(27)



END SUB

SUB DoHallOfFame STATIC

DX = 32
DY = 50
MaxLen = 25
Title$ = "Power Players:    Score:"
Tmin = PadColorMin
Sysmod = True

Rnk$ = LTRIM$(STR$(Hall(1).Rank))
Nm$ = "." + LTRIM$(RTRIM$(Hall(1).Namer))
        IF LEN(Nm$) < 12 THEN
                Nm$ = Nm$ + SPACE$(13 - LEN(Nm$))
        END IF
Nm$ = Nm$ + ":"
Scr$ = LTRIM$(STR$(Hall(1).Score))
Text$ = Rnk$ + Nm$ + STRING$(8 - (LEN(Scr$)), "-") + Scr$

FOR I = 2 TO 5
        Rnk$ = " " + LTRIM$(STR$(Hall(I).Rank))
        Nm$ = "." + LTRIM$(RTRIM$(Hall(I).Namer))
                IF LEN(Nm$) < 12 THEN
                        Nm$ = Nm$ + SPACE$(13 - LEN(Nm$))
                END IF
        Nm$ = Nm$ + ":"
        Scr$ = LTRIM$(STR$(Hall(I).Score))
        Text$ = Text$ + Rnk$ + Nm$ + STRING$(8 - (LEN(Scr$)), "-") + Scr$
NEXT I


DialogBox DX, DY, MaxLen, Tmin, Title$, Text$, False, Sysmod

END SUB

SUB DoIntro STATIC

LoadTitle


DoStory

END SUB

SUB DoLangaw (Stat) STATIC

'"Langaw" means Fly as in the insect in our country.

PUT (LangawOldCoord(0).X, LangawOldCoord(0).Y), LangawBG1, PSET
PUT (LangawOldCoord(1).X, LangawOldCoord(1).Y), LangawBG2, PSET

IF NOT Stat THEN
J = J MOD 10 + 1

FOR I = 0 TO 1
        IF J = 1 THEN
                LXR! = RND * 5
                LYR! = RND * 5
        END IF

        IF LXR! < 2.5 THEN
                LX = -2
        ELSE
                LX = 2
        END IF

        IF LYR! < 2.5 THEN
                LY = -2
        ELSE
                LY = 2
        END IF
IF I = 1 THEN
        LX = -LX
        LY = -LY
END IF
        LangawCoord(I).X = LangawCoord(I).X + LX
        IF LangawCoord(I).X > 230 THEN
                LangawCoord(I).X = 230
        ELSEIF LangawCoord(I).X < 10 THEN
                LangawCoord(I).X = 10
        END IF

        LangawCoord(I).Y = LangawCoord(I).Y + LY
        IF LangawCoord(I).Y > 140 THEN
                LangawCoord(I).Y = 140
        ELSEIF LangawCoord(I).Y < 50 THEN
                LangawCoord(I).Y = 50
        END IF

        LangawOldCoord(I).X = LangawCoord(I).X
        LangawOldCoord(I).Y = LangawCoord(I).Y
NEXT I

END IF

GetBG LangawOldCoord(0).X, LangawOldCoord(0).Y, LangawOldCoord(0).X + 16, LangawOldCoord(0).Y + 16, LangawBG1()
GetBG LangawOldCoord(1).X, LangawOldCoord(1).Y, LangawOldCoord(1).X + 16, LangawOldCoord(1).Y + 16, LangawBG2()

Axn = Axn MOD 2 + 1
PutLangaw LangawCoord(0).X, LangawCoord(0).Y, Axn
PutLangaw LangawCoord(1).X, LangawCoord(1).Y, Axn

END SUB

SUB DoLogos STATIC

SaveColors
HideBuild

X = 320
Y = 20
Xscale = 4
Yscale = 2
Font$ = "RelSoft"
Italic = False
KgenTTFont X, Y, Font$, 24, Xscale, Yscale, Italic


X = 320
Y = 77
Xscale = 2
Yscale = 1
Font$ = "and"
Italic = False
KgenTTFont X, Y, Font$, 80, Xscale, Yscale, Italic


X = 52
Y = 120
Xscale = 3
Yscale = 4
Font$ = "AnyaTech"
Italic = True
KgenTTFont 50, 118, Font$, 24, Xscale, Yscale, Italic
KgenTTFont X, Y, Font$, 59, Xscale, Yscale, Italic


RestoreColors
T& = TIMER
DO
        T2& = TIMER
LOOP UNTIL T2& - T& > 2
Fade 0, 0, 0

LINE (0, 0)-(320, 199), 0, BF


X = 320
Y = 50
Xscale = 1
Yscale = 2
Font$ = "Proudly"
Italic = False
KgenTTFont X, Y, Font$, 24, Xscale, Yscale, Italic

X = 320
Y = 100
Xscale = 3
Yscale = 1
Font$ = "Presents"
Italic = False
KgenTTFont X, Y, Font$, 24, Xscale, Yscale, Italic


RestoreColors
T& = TIMER
DO
        T2& = TIMER
LOOP UNTIL T2& - T& > 1

Fade 0, 0, 0

LINE (0, 0)-(320, 199), 0, BF

RestoreColors


END SUB

SUB DoPadLsr STATIC

LsrSpeed = 2


IF AutoFire THEN
        Lshot = True
        Rshot = True
END IF

IF Lshot THEN
        PadLsrCoord(0).Y = PadLsrCoord(0).Y - LsrSpeed
ELSE
        GetPadLsrCoord 1
END IF
IF Rshot THEN
        PadLsrCoord(1).Y = PadLsrCoord(1).Y - LsrSpeed
ELSE
        GetPadLsrCoord 2
END IF


GetPadLsrBG PadLsrBG1(), PadLsrBG2()

PutPadLsr PadLsrCoord(0).X, PadLsrCoord(0).Y
PutPadLsr PadLsrCoord(1).X, PadLsrCoord(1).Y

I = 1
X = PadLsrCoord(0).X + 2
Y = PadLsrCoord(0).Y - 3
GOSUB CheckForHit
I = 2
X = PadLsrCoord(1).X + 2
Y = PadLsrCoord(1).Y - 3
GOSUB CheckForHit


EXIT SUB
''=========
CheckForHit:

IF POINT(X, Y) < 129 THEN
        SELECT CASE I
                CASE 1
                        Lshot = False
                        GetPadLsrCoord 1
                CASE 2
                        Rshot = False
                        GetPadLsrCoord 2
                CASE ELSE
        END SELECT

GetBallBG BallX, BallY
GetPaddleBG PadX, PadY


PutBall BallX, BallY
PutPaddle PadX, PadY

        CheckTile X, Y

PutPaddleBG PadOldX, PadOldY
PutBallBG BallOldX, BallOldY

        IF NOT Lshot AND NOT Rshot THEN
                Shooting = False
        END IF

END IF


RETURN


END SUB

SUB DoPowerCaps (PowType) STATIC

PowSpeed = 1


PowerCapsCoord(0).Y = PowerCapsCoord(0).Y + PowSpeed

GetPowerCapsBG

PutPowerCaps PowerCapsCoord(0).X, PowerCapsCoord(0).Y, PowType






X = PowerCapsCoord(0).X + 9
Y = PowerCapsCoord(0).Y + 13
GOSUB Check4Hit

X = PowerCapsCoord(0).X
Y = PowerCapsCoord(0).Y + 13
GOSUB Check4Hit

X = PowerCapsCoord(0).X + 9
Y = PowerCapsCoord(0).Y + 13
GOSUB Check4Hit






EXIT SUB
''=========
Check4Hit:



IF POINT(X, Y) < 129 THEN

        'Spike
        IF POINT(X, Y) >= SpikeMin AND POINT(X, Y) <= SpikeMax THEN

                PutPowerCapsBG
                Power = False

        END IF

        'Border
        IF POINT(X, Y) >= BorderMin AND POINT(X, Y) <= Bordermax THEN

                PutPowerCapsBG
                Power = False

        END IF


END IF


'Check for Paddle

IF Replicant THEN
        PadXXStep = 72
ELSE
        PadXXStep = 38
END IF

IF Inside(X, Y, PadX - 5, PadY, PadX + PadXXStep, PadY + 8) THEN

      IF Power THEN
                PutPowerCapsBG
                Power = False

                SELECT CASE PowerType
                        CASE 1  'PadPower
                                IF NOT PadPower THEN
                                        PadPower = True
                                        GetPadLsrCoord 0
                                        GetPadLsrBG PadLsrBG1(), PadLsrBG2()
                                        SfxPowerUp
                                END IF
                        CASE 2 'Replicant
                                Replicant = True
                                        SfxPowerUp
                        CASE 3 '1Up
                                Lives = Lives + 1
                                IF Lives > 100 THEN Lives = 100
                                PrintLives False
                                        SfxPowerUp
                        CASE ELSE
                END SELECT
      END IF

END IF


RETURN


END SUB

SUB DoStory STATIC


VS = 4
VE = 23
VIEW PRINT VS TO VE
RESTORE Story

X = 320
Y = 0
Xscale = 1
Yscale = 2
Font$ = "-ARQANOID... the untold story-"
Italic = False
KgenTTFont 159 - (4 * Xscale * LEN(Font$)), Y - 1, Font$, PadColorMin, Xscale, Yscale, Italic
KgenTTFont X, Y, Font$, KgenGreenMin, Xscale, Yscale, Italic


Text$ = "    This story has been passed from generation to generation... Damn! I really suck at storytelling. (Actually, I made the game before the story... hehehehehe. Note: I intentionally mispelled some words. ie game titles.  FYI, BALOT is a"
Text$ = Text$ + " native delicacy in our country made from duck eggs."
Xscale = 2
Yscale = 1
TopY = 199 - ((Yscale) * 9)
MinColor = KgenBlueMin
Shadow = True
OverTop = False
OtY = 10
Italic = False
FirstTime = True

RestoreColors

DO

K$ = INKEY$
ScrollKgenTT TopY, Text$, Xscale, Yscale, MinColor, Shadow, OverTop, OtY, Italic, FirstTime

IF RGBCounter(RGBC * 5) THEN RotateRGB

KC = KC MOD 288 + 1
IF KC = 1 THEN
        READ T$
        IF UCASE$(T$) = "END" THEN
                EXIT DO
        END IF

        LOCATE VE, 1
        PRINT
        KgenFont 0, 176, T$, PadColorMin, False
END IF

LOOP UNTIL K$ = CHR$(13)

HazyFx
Fade 0, 0, 0
LINE (0, 0)-(319, 199), 0, BF

END SUB

FUNCTION DoTimer (MaxTime) STATIC

IF BombNum = MaxBomb THEN
        SecondTime = False
        MaxBomb = MaxBomb + 1
END IF

IF NOT SecondTime THEN
        TT = 0
        T = 0
END IF

SecondTime = True

T& = TIMER
DoTimer = False
IF T& > OldTime& THEN
        GOSUB PrintTime
END IF

EXIT FUNCTION

'==========================
PrintTime:
        T = T MOD MaxTime + 1
        TT = MaxTime - T

X = 289
Y = 125
Font$ = STR$(TT)
Italic = False
LINE (X + 8, Y)-STEP(24, 9), 0, BF
KgenFont X - 1, Y + 1, Font$, KgenMin, Italic

IF TT = 0 THEN
        DoTimer = True
        SfxOpenDialog
        SecondTime = False
END IF

OldTime& = TIMER

RETURN



END FUNCTION

SUB DrawBorder STATIC

FOR I = 0 TO 6
        LINE (I, I)-(260 - I, 200 - I), BorderMin + I, B
NEXT I


END SUB

SUB DrawBoss (BossX, BossY, BossFile$) STATIC

BossFileSpr$ = Path$ + "Images\" + BossFile$ + ".QBN"
BossFileMsk$ = Path$ + "Images\" + BossFile$ + ".Msk"

OPEN BossFileSpr$ FOR INPUT AS #1

INPUT #1, ArrSize

REDIM Boss(ArrSize)
REDIM BossMask(ArrSize)


FOR I = 0 TO ArrSize

        INPUT #1, Boss(I)


NEXT I


CLOSE

OPEN BossFileMsk$ FOR INPUT AS #1
INPUT #1, ArrSize

FOR I = 0 TO ArrSize

        INPUT #1, BossMask(I)


NEXT I

CLOSE

REDIM BossBG(ArrSize)

GET (BossX, BossY)-STEP(Boss(0) \ 8 - 1, Boss(1) - 1), BossBG

PUT (BossX, BossY), BossMask, AND
PUT (BossX, BossY), Boss, OR


END SUB

SUB DrawFonts STATIC

X = 268
Y = 2
Txt$ = "i Score:"
PrintFonts X, Y, Txt$
X = 265
Y = 0
Font$ = "H"
Italic = False
KgenFont X - 1, Y + 1, Font$, KgenBlueMin, Italic
KgenFont X, Y, Font$, KgenMin, Italic
        

IF Score& < 100000 THEN
        X = 280
        Y = 12
        PrintNum X, Y, "100,000"
ELSE
        PrintScore
END IF




X = 268
Y = 27
Txt$ = "core:"
PrintFonts X, Y, Txt$
X = 265
Y = 25
Font$ = "S"
Italic = False
KgenFont X - 1, Y + 1, Font$, KgenBlueMin, Italic
KgenFont X, Y, Font$, KgenMin, Italic


'SCORE
Temp$ = LTRIM$(Format$(Score&))
PrintNum 315 - (LEN(Temp$) * 5), 35, Temp$


X = 268
Y = 52
Txt$ = "evel:"
PrintFonts X, Y, Txt$
X = 265
Y = 50
Font$ = "L"
Italic = False
KgenFont X - 1, Y + 1, Font$, KgenBlueMin, Italic
KgenFont X, Y, Font$, KgenMin, Italic


X = 268
Y = 67
Txt$ = "ives:"
PrintFonts X, Y, Txt$

X = 265
Y = 65
Font$ = "L"
Italic = False
KgenFont X - 1, Y + 1, Font$, KgenBlueMin, Italic
KgenFont X, Y, Font$, KgenMin, Italic


X = 268
Y = 127
Txt$ = "ime:"
PrintFonts X, Y, Txt$

X = 265
Y = 125
Font$ = "T"
Italic = False
KgenFont X - 1, Y + 1, Font$, KgenBlueMin, Italic
KgenFont X, Y, Font$, KgenMin, Italic

X = 289
Y = 125
Font$ = STR$(60)
Italic = False
KgenFont X - 1, Y + 1, Font$, KgenMin, Italic



X = 268
Y = 155
Txt$ = "mail:"
PrintFonts X, Y, Txt$

X = 265
Y = 153
Font$ = "E"
Italic = False
KgenFont X - 1, Y + 1, Font$, KgenBlueMin, Italic
KgenFont X, Y, Font$, KgenMin, Italic

X = 261
Y = 167
Txt$ = "vic viperph"
PrintFonts X, Y, Txt$

LINE (281, 171)-STEP(3, 0), FcolorMax, BF

X = 261
Y = 174
Txt$ = "@Yahoo.Com"
PrintFonts X, Y, Txt$



X = 261
Y = 183
Font$ = "RelSoft"
Italic = True
KgenFont X - 1, Y - 1, Font$, KgenGreenMin, Italic
KgenFont X, Y, Font$, KgenBlueMin, Italic

X = 271
Y = 193
Font$ = "2001"
Italic = True
KgenFont X - 1, Y - 1, Font$, KgenGreenMin, Italic
KgenFont X, Y, Font$, KgenBlueMin, Italic





END SUB

SUB DrawLevelBG (BGMode, ColorStep, ColorAttr) STATIC

LINE (0, 0)-(319, 199), 255, BF    'Bug Fix

Clr = 145

FOR Y = 0 TO 199 STEP 5
    FOR X = 0 TO 320 STEP 5

        IF CC = 0 THEN
            Clr = Clr + ColorStep
        ELSE
            Clr = Clr - ColorStep
        END IF
        IF BGMode = 1 THEN
                LINE (X, Y)-(X + 4, Y + 4), Clr, BF
                LINE (X + 1, Y + 1)-(X + 3, Y + 3), Clr + 5, BF
                LINE (X + 1, Y + 1)-(X + 1, Y + 1), Clr + 11, BF
        ELSE
                LINE (X, Y)-(X + 4, Y + 4), Clr, B
                LINE (X + 1, Y + 1)-(X + 3, Y + 3), Clr + 5, B
                LINE (X + 1, Y + 1)-(X + 1, Y + 1), Clr + 11, B
        END IF
        IF Clr >= 180 THEN CC = 1
        IF Clr <= 150 THEN CC = 0
    NEXT X
NEXT Y

'Erase RightSide for Info,Scores,Etc.

LINE (MaxX, MinY)-(320, 200), 255, BF
LINE (0, 200)-(320, 200), 255, BF



GetBG 7, 183, 253, 193, SpikeBG()

'Draw Spikes

FOR X = 5 TO 250 STEP 10
        DrawSpike X, 205
NEXT X

DrawBorder
DrawFonts


END SUB

SUB DrawSpike (X, Y) STATIC

FOR I = 1 TO 5
       LINE (X + I, Y)-STEP(0, -(I * 4.5)), SpikeMax - I
       LINE ((X + 10) - I, Y)-STEP(0, -(I * 4.5)), SpikeMax - I
NEXT I


END SUB

SUB DrawTile (X, Y, Clr)

        SELECT CASE Clr
                CASE 1
                        TB = 60
                        TC = 61
                        TM = 62
                CASE 2
                        TB = 63
                        TC = 64
                        TM = 65
                CASE 3
                        TB = 66
                        TC = 67
                        TM = 68
                CASE 4
                        TB = 69
                        TC = 70
                        TM = 71
                CASE 5
                        TB = 72
                        TC = 73
                        TM = 74
                CASE 6
                        TB = 75
                        TC = 76
                        TM = 77
                CASE 7
                        TB = 78
                        TC = 79
                        TM = 80
                CASE 8
                        TB = 81
                        TC = 82
                        TM = 83
                CASE 9
                        TB = 84
                        TC = 85
                        TM = 86
                CASE ELSE
        END SELECT


        LINE (X, Y)-STEP(TileW, TileH), TC, BF
        LINE (X, Y)-STEP(TileW, TileH), TM, B
        LINE (X, Y)-STEP(0, TileH), TB
        LINE (X, Y + TileH)-STEP(TileW - 1, 0), TB



END SUB

SUB EraseKgen STATIC

KgenStart = 49

X = 265
Y = 0
Font$ = "H"
Italic = False
KgenFont X - 1, Y + 1, Font$, KgenStart, Italic
KgenFont X, Y, Font$, KgenStart, Italic


X = 265
Y = 25
Font$ = "S"
Italic = False
KgenFont X - 1, Y + 1, Font$, KgenStart, Italic
KgenFont X, Y, Font$, KgenStart, Italic


X = 265
Y = 50
Font$ = "L"
Italic = False
KgenFont X - 1, Y + 1, Font$, KgenStart, Italic
KgenFont X, Y, Font$, KgenStart, Italic



X = 265
Y = 65
Font$ = "L"
Italic = False
KgenFont X - 1, Y + 1, Font$, KgenStart, Italic
KgenFont X, Y, Font$, KgenStart, Italic



X = 265
Y = 125
Font$ = "T"
Italic = False
KgenFont X - 1, Y + 1, Font$, KgenStart, Italic
KgenFont X, Y, Font$, KgenStart, Italic


X = 289
Y = 125
Font$ = STR$(60)
Italic = False
KgenFont X - 1, Y + 1, Font$, KgenStart, Italic


X = 265
Y = 153
Font$ = "E"
Italic = False
KgenFont X - 1, Y + 1, Font$, KgenStart, Italic
KgenFont X, Y, Font$, KgenStart, Italic


X = 261
Y = 183
Font$ = "RelSoft"
Italic = True
KgenFont X - 1, Y - 1, Font$, KgenStart, Italic
KgenFont X, Y, Font$, KgenStart, Italic

X = 271
Y = 193
Font$ = "2001"
Italic = True
KgenFont X - 1, Y - 1, Font$, KgenStart, Italic
KgenFont X, Y, Font$, KgenStart, Italic


X = 297
Y = 51

IF Level < 10 THEN
        LV$ = "0" + LTRIM$(STR$(Level))
ELSE
        LV$ = LTRIM$(STR$(Level))
END IF

Font$ = LV$
Italic = True
KgenFont X - 2, Y + 1, Font$, KgenStart, Italic
KgenFont X, Y, Font$, KgenStart, Italic


END SUB

SUB EraseSaveFiles STATIC


GOSUB ConfirmErase

IF K$ = CHR$(27) THEN
        EXIT SUB
END IF

GOSUB MakeBackUp

'===================================Hall of Fame
FOR I = 1 TO 5
        Hall(I).Rank = I
        Hall(I).Namer = "Relsoft 2000"
        Hall(I).Score = 0
NEXT I

OPEN Path$ + "saves\" + "qbnoid.hof" FOR OUTPUT AS #1

FOR I = 1 TO 5
        PRINT #1, Hall(I).Rank
        PRINT #1, Hall(I).Namer
        PRINT #1, Hall(I).Score
NEXT I

CLOSE



'=================================='SaveFiles for Loading




FOR I = 1 TO 8
        Save(I).Num = I
        Save(I).Namer = "Relsoft 2000"
        Save(I).Score = 0
        Save(I).Level = 1
        Save(I).Lives = 2

NEXT I

OPEN Path$ + "saves\" + "qbnoid.qsv" FOR OUTPUT AS #1


FOR I = 1 TO 8

        PRINT #1, Save(I).Num
        PRINT #1, Save(I).Namer
        PRINT #1, Save(I).Score
        PRINT #1, Save(I).Level
        PRINT #1, Save(I).Lives
NEXT I

CLOSE
EXIT SUB


'================Subs==================
MakeBackUp:

'===========Hall of Fame
OPEN Path$ + "saves\" + "qbnbck.hof" FOR OUTPUT AS #1

FOR I = 1 TO 5
        PRINT #1, Hall(I).Rank
        PRINT #1, Hall(I).Namer
        PRINT #1, Hall(I).Score
NEXT I

CLOSE



'=================================='SaveFiles for Loading

OPEN Path$ + "saves\" + "qbnbck.qsv" FOR OUTPUT AS #1


FOR I = 1 TO 8

        PRINT #1, Save(I).Num
        PRINT #1, Save(I).Namer
        PRINT #1, Save(I).Score
        PRINT #1, Save(I).Level
        PRINT #1, Save(I).Lives
NEXT I

CLOSE

RETURN

'==============================

ConfirmErase:

REDIM Temp(1)
DX = 40
DY = 40
MaxLen = 21
Title$ = "     WARNING!!!"
Tmin = PadColorMin
Sysmod = False
Text$ = "~~~~This will erase your Hi-Scores and Load/Save file datas!!! Press [Escape] to undo or [Enter] to confirm."
GetBG DX, DY, DX + MaxLen * 8, DY + 9 * 8, Temp()
DialogBox DX, DY, MaxLen, Tmin, Title$, Text$, False, Sysmod
DO
K$ = INKEY$
        IF RGBCounter(RGBC * 5) THEN RotateRGB
        WAIT &H3DA, 8
LOOP UNTIL K$ = CHR$(27) OR K$ = CHR$(13)

SfxOpenDialog
PUT (DX, DY), Temp, PSET
ERASE Temp

RETURN


END SUB

SUB Fade (R%, g%, B%)



FOR I = 0 TO 63


FOR X = 0 TO 255

RefreshKey

        ReadRGB X, RD, GN, BLL


        IF R% > RD THEN
                RD = RD + 1
        ELSEIF R% < RD THEN
                RD = RD - 1
        ELSE
                'Do nothing
        END IF

        IF g% > GN THEN
                GN = GN + 1
        ELSEIF g% < GN THEN
                GN = GN - 1
        ELSE
                'Do nothing
        END IF

        IF B% > BLL THEN
                BLL = BLL + 1
        ELSEIF B% < BLL THEN
                BLL = BLL - 1
        ELSE
                'Do nothing
        END IF

        WriteRGB X, RD, GN, BLL

NEXT X

MilliDelay 30
WAIT &H3DA, 8
WAIT &H3DA, 8, 8

NEXT I

END SUB

SUB FadeStep (R%, g%, B%) STATIC



I = I + 1

IF I > 63 THEN
        I = 0
        EXIT SUB
END IF

FOR X = 0 TO 255

RefreshKey

        ReadRGB X, RD, GN, BLL

        IF R% > RD THEN
                RD = RD + 1
        ELSEIF R% < RD THEN
                RD = RD - 1
        ELSE
                'Do nothing
        END IF

        IF g% > GN THEN
                GN = GN + 1
        ELSEIF g% < GN THEN
                GN = GN - 1
        ELSE
                'Do nothing
        END IF

        IF B% > BLL THEN
                BLL = BLL + 1
        ELSEIF B% < BLL THEN
                BLL = BLL - 1
        ELSE
                'Do nothing
        END IF

        WriteRGB X, RD, GN, BLL

NEXT X

END SUB

FUNCTION FastKB STATIC
        FastKB = INP(&H60)
        DO WHILE LEN(INKEY$): LOOP

END FUNCTION

FUNCTION Format$ (Score&) STATIC

Score$ = RTRIM$(LTRIM$(STR$(Score&)))

L = LEN(Score$)
Temp$ = ""
II = 0

FOR I = L TO 1 STEP -1
        I$ = MID$(Score$, I, 1)

        IF II = 3 THEN
                Temp$ = Temp$ + "," + I$
        ELSE
                Temp$ = Temp$ + I$
        END IF
        II = (II MOD 3) + 1

NEXT I

'Reverse it

L = LEN(Temp$)
Temp2$ = ""

FOR I = L TO 1 STEP -1
        I$ = MID$(Temp$, I, 1)
        Temp2$ = Temp2$ + I$
NEXT I

Format$ = LTRIM$(RTRIM$(Temp2$))

END FUNCTION

SUB GetBallBG (BallX, BallY) STATIC
BallOldX = BallX
BallOldY = BallY
        GET (BallX, BallY)-STEP(6, 6), BallBG
END SUB

SUB GetBallCenter (BallCenterX, BallCenterY) STATIC
        BallCenterX = BallX + BallRadius - 1
        BallCenterY = BallY + BallRadius - 1
END SUB

SUB GetBG (X1, Y1, X2, Y2, Image())

'Image() Must be Dynamic

Size = (((((((X2 + 1) - X1) * ((Y2 + 1) - Y1))))) \ 2) + 2

REDIM Image(Size)

GET (X1, Y1)-(X2, Y2), Image


END SUB

SUB GetBlkHoleBG STATIC

FOR I = 1 TO 4
        IF BlkHoleXY(I).X <> 0 THEN
                GET (BlkHoleXY(I).X, BlkHoleXY(I).Y)-STEP(15, 15), BlkHoleBG(130 * (I - 1))
        END IF
NEXT I

END SUB

SUB GetDirection STATIC

SELECT CASE SGN(BallXV)
        CASE 1
                IF SGN(BallYV) = -1 THEN
                        Direction = UR
                ELSE
                        Direction = DR
                END IF
        CASE -1
                IF SGN(BallYV) = -1 THEN
                        Direction = UL
                ELSE
                        Direction = DL
                END IF

        CASE ELSE
END SELECT

SELECT CASE SGN(BallYV)
        CASE 1
                IF SGN(BallXV) = -1 THEN
                ELSE
                END IF

        CASE -1
                IF SGN(BallXV) = -1 THEN
                ELSE
                END IF

        CASE ELSE
END SELECT

END SUB

SUB GetPaddleBG (PadX, PadY) STATIC
PadOldX = PadX
PadOldY = PadY

IF NOT Replicant THEN
        GET (PadX, PadY)-STEP(39, 8), PaddleBG
ELSE
        GET (PadX, PadY)-STEP(39 * 2, 8), PaddleBG
END IF
END SUB

SUB GetPadLsrBG (Image1(), Image2()) STATIC


PadLsrOldCoord(0).X = PadLsrCoord(0).X
PadLsrOldCoord(0).Y = PadLsrCoord(0).Y
PadLsrOldCoord(1).X = PadLsrCoord(1).X
PadLsrOldCoord(1).Y = PadLsrCoord(1).Y


GetBG PadLsrCoord(0).X, PadLsrCoord(0).Y, PadLsrCoord(0).X + 4, PadLsrCoord(0).Y + 8, Image1()
GetBG PadLsrCoord(1).X, PadLsrCoord(1).Y, PadLsrCoord(1).X + 4, PadLsrCoord(1).Y + 8, Image2()

END SUB

SUB GetPadLsrCoord (I) STATIC

SELECT CASE I
        CASE 0
                PadLsrCoord(0).X = PadX + 1
                PadLsrCoord(0).Y = PadY - 9
                IF Replicant THEN
                        PadLsrCoord(1).X = PadX + 71
                ELSE
                        PadLsrCoord(1).X = PadX + 33
                END IF
                PadLsrCoord(1).Y = PadY - 9
        CASE 1
                PadLsrCoord(0).X = PadX + 1
                PadLsrCoord(0).Y = PadY - 9
        CASE 2
                IF Replicant THEN
                        PadLsrCoord(1).X = PadX + 71
                ELSE
                        PadLsrCoord(1).X = PadX + 33
                END IF
                PadLsrCoord(1).Y = PadY - 9
        CASE ELSE
                PadLsrCoord(0).X = PadX + 1
                PadLsrCoord(0).Y = PadY - 9
                IF Replicant THEN
                        PadLsrCoord(1).X = PadX + 71
                ELSE
                        PadLsrCoord(1).X = PadX + 33
                END IF
                PadLsrCoord(1).Y = PadY - 9
END SELECT


END SUB

SUB GetPowerCapsBG STATIC

PowerCapsOldCoord(0).X = PowerCapsCoord(0).X
PowerCapsOldCoord(0).Y = PowerCapsCoord(0).Y


GetBG PowerCapsCoord(0).X, PowerCapsCoord(0).Y, PowerCapsCoord(0).X + 19, PowerCapsCoord(0).Y + 9, PowerCapsBG()


END SUB

SUB GetTileBackGround STATIC

I = 0
FOR Y = 0 TO 108 STEP 6
        FOR X = 0 TO 220 STEP 20
                GET (10 + X, 10 + Y)-STEP(19, 5), BackGround(OffsetBG * I)
                I = I + 1
        NEXT X
NEXT Y

END SUB

SUB HazyFx STATIC

StepX = 2
StepY = 2

FOR I = 1 TO 8

StepX = StepX + 2
StepY = StepY + 2

FOR Y = 0 TO 199 STEP StepY
        FOR X = 0 TO 319 STEP StepX
                C = POINT(X, Y)
                LINE (X, Y)-STEP(StepX - 1, StepY - 1), C, BF
        NEXT X
NEXT Y

MilliDelay 140

NEXT I

END SUB

SUB HideBuild

FOR I = 0 TO 255
        R = 0
        g = 0
        B = 0
        WriteRGB I, R, g, B
NEXT I

END SUB

FUNCTION HitSpike (X, Y) STATIC

HitSpike = False

IF POINT(X, Y) >= SpikeMin AND POINT(X, Y) <= SpikeMax THEN
        HitSpike = True
END IF

END FUNCTION

SUB Init STATIC

LoadSaveFiles

InitValues

DoLogos

InitColors

InitTrans


SaveColors

HideBuild

DoIntro

InitFonts
InitNums


'Load Images

LoadBallImage
LoadBallExpImage
LoadPaddleImage
LoadBlkHoleImage
LoadBombImage
LoadExplodeImage
LoadPointerImage
LoadPadLsrImage
LoadPowerCapsImage
LoadLangawImage
LoadFlyExpImage



END SUB

SUB InitColors STATIC

       WriteRGB 254, 63, 63, 63
'Color for Menu Pointer=============
WriteRGB 244, 0, 0, 0
WriteRGB 245, 0, 0, 0


'Color for Border============================================
R = 25
g = 25
B = 40

FOR I = BorderMin TO Bordermax
IF I <= BorderMin + 3 THEN
        R = R + 5
        g = g + 3
ELSE
        R = R - 5
        g = g - 3
END IF

        WriteRGB I, R, g, B
NEXT I

'FontColors================================
R = 63
g = 63
B = 63

FOR I = FColorMin TO FcolorMax
        R = R - 7
        B = B - 7
        WriteRGB I, R, g, B
NEXT I

'SmallNum colors============================
R = 63
g = 63
B = 63

FOR I = SnColorMin TO SnColorMax
        R = R - 7
        g = g - 7
        WriteRGB I, R, g, B
NEXT I

'Tile Colors=================================

'60-93

FOR I = TcolorMin TO TcolorMax
        II = II MOD 3 + 1

        IF II = 1 THEN
                IC = IC MOD 9 + 1
        END IF
        SELECT CASE II
                CASE 1
                        R = 10: g = 10: B = 10    'Dark Borders
                CASE 2
                        R = 30: g = 30: B = 30    'Tilecolor
                CASE 3
                        R = 50: g = 50: B = 50    'Light Borders
                CASE ELSE
        END SELECT
        'Tile color
        SELECT CASE IC
                CASE 1
                        g = 0
                        B = 0
                CASE 2
                        R = 0
                        B = 0
                CASE 3
                        R = 0
                        g = 0
                CASE 4
                        R = 0
                CASE 5
                        g = 0
                CASE 6
                        B = 0
                CASE 7
                        R = 25
                CASE 8
                        g = 25
                CASE 9
                        B = 25
                CASE ELSE
        END SELECT

        WriteRGB I, R, g, B
NEXT I

'BackGround Colors==============================================
I = 0

FOR I = 130 TO 193
        SELECT CASE ColorAttr
        CASE 1      'Red
               SavRGB(I).R = I \ 2
               SavRGB(I).g = 0
               SavRGB(I).B = 0
        CASE 2      'Green
               SavRGB(I).R = 0
               SavRGB(I).g = I \ 2
               SavRGB(I).B = 0

        CASE 3      'Blue
               SavRGB(I).R = 0
               SavRGB(I).g = 0
               SavRGB(I).B = I \ 2

        CASE 4      'Yellow
               SavRGB(I).R = I \ 2
               SavRGB(I).g = I \ 2
               SavRGB(I).B = 0

        CASE 5      'Purple
               SavRGB(I).R = I \ 2
               SavRGB(I).g = 0
               SavRGB(I).B = I \ 2

        CASE 6      'Metallic Blue
               SavRGB(I).R = 0
               SavRGB(I).g = I \ 2
               SavRGB(I).B = I \ 2

        CASE 7      'White
               SavRGB(I).R = I \ 2
               SavRGB(I).g = I \ 2
               SavRGB(I).B = I \ 2

        CASE ELSE
               SavRGB(I).R = I \ 2
               SavRGB(I).g = I \ 2
               SavRGB(I).B = I \ 2
        END SELECT

NEXT I
I = 0
FOR I = 130 TO 193
        WriteRGB I, SavRGB(I).R, SavRGB(I).g, SavRGB(I).B
NEXT I

'=========Boss Colors 106-121================
II = 0
FOR I = 106 TO 121
        ReadRGB II, R, g, B
        WriteRGB I, R, g, B
II = II + 1
NEXT I


'====================Kgen Colors==============================
'Red
R = 63
g = 63
B = 63
FOR I = KgenMin TO KgenMax
        IF I <= KgenMin + 3 THEN
                g = g - 13
                B = B - 13
        ELSE
                g = g + 13
                B = B + 13
        END IF
        SavRGB(I).R = R
        SavRGB(I).g = g
        SavRGB(I).B = B
        WriteRGB I, SavRGB(I).R, SavRGB(I).g, SavRGB(I).B
NEXT I

'Blue
R = 63
g = 63
B = 63
FOR I = KgenBlueMin TO KgenBlueMax
        IF I <= KgenBlueMin + 3 THEN
                g = g - 13
                R = R - 13
        ELSE
                g = g + 13
                R = R + 13
        END IF
        SavRGB(I).R = R
        SavRGB(I).g = g
        SavRGB(I).B = B
        WriteRGB I, SavRGB(I).R, SavRGB(I).g, SavRGB(I).B
NEXT I

'Green
R = 63
g = 63
B = 63
FOR I = KgenGreenMin TO KgenGreenMax
        IF I <= KgenGreenMin + 3 THEN
                B = B - 13
                R = R - 13
        ELSE
                B = B + 13
                R = R + 13
        END IF
        SavRGB(I).R = R
        SavRGB(I).g = g
        SavRGB(I).B = B
        WriteRGB I, SavRGB(I).R, SavRGB(I).g, SavRGB(I).B
NEXT I

'===========Paddle==========

R = 63
g = 63
B = 63

FOR I = PadColorMin TO PadColorMax
        IF I <= PadColorMin + 5 THEN
                R = R - 4
                g = g - 4
        ELSE
                R = R + 4
                g = g + 4
        END IF
        SavRGB(I).R = R
        SavRGB(I).g = g
        SavRGB(I).B = B
        WriteRGB I, SavRGB(I).R, SavRGB(I).g, SavRGB(I).B
NEXT I

'==========pointer
WriteRGB 244, 0, 63, 33      'Inside of pointer
WriteRGB 245, 63, 33, 63     'Border of pointer


END SUB

SUB InitFonts STATIC

SHARED SmallFonts() AS INTEGER
CLS
OPEN Path$ + "images\" + "small.fnt" FOR INPUT AS #1

INPUT #1, Maxfont



'Small numbers 0 to 4 height, 0 to 3 wide

FOR I = 1 TO Maxfont
        FOR Y = 0 TO 4
                 JC = JC MOD 5 + 1
        FOR X = 0 TO 3
                INPUT #1, J
                 IF J <> 0 THEN
                         PSET (X + XX, Y), JC + (FColorMin - 1)
                 END IF
        NEXT X
        NEXT Y
        XX = XX + 5
NEXT I

CLOSE

NI = 0
X = 0
Y = 0
FOR I = 1 TO Maxfont
        GET (X, Y)-STEP(3, 4), SmallFonts(NI * FontOffset%)
        NI = NI + 1
        X = X + 5
NEXT I

END SUB

SUB InitImageData (FileName$, ImageArray())

    IF FileName$ <> "" THEN
        '***** Read image data from file *****

        'Establish size of integer array required.
        FileNo = FREEFILE
        OPEN FileName$ FOR BINARY AS #FileNo
        Ints = (LOF(FileNo) - 7) \ 2
        CLOSE #FileNo
        REDIM ImageArray(1 TO Ints)

        'Load image data directly into array memory.
        DEF SEG = VARSEG(ImageArray(1))
        BLOAD FileName$, 0
        DEF SEG
    ELSE
        '***** Read image data from DATA statements *****

        'Establish size of integer array required.
        READ IntCount
        REDIM ImageArray(1 TO IntCount)

        'READ image DATA into array.
        FOR n = 1 TO IntCount
            READ X
            ImageArray(n) = X
        NEXT n
    END IF

END SUB

SUB InitNums STATIC
SHARED SmallNum() AS INTEGER
CLS

OPEN Path$ + "images\" + "smallnum.fnt" FOR INPUT AS #1

INPUT #1, MaxNum


'Small numbers 0 to 4 height, 0 to 3 wide
FOR I = 1 TO MaxNum
        FOR Y = 0 TO 4
                 JC = JC MOD 5 + 1
        FOR X = 0 TO 3
                INPUT #1, J
                 IF J <> 0 THEN
                         PSET (X + XX, Y), JC + (SnColorMin - 1)
                 END IF
        NEXT X
        NEXT Y
        XX = XX + 5
NEXT I

CLOSE

NI = 0
X = 0
Y = 0
FOR I = 1 TO 11
        GET (X, Y)-STEP(3, 4), SmallNum(NI * FontOffset)
        NI = NI + 1
        X = X + 5
NEXT I

END SUB

SUB InitTrans
'init Trans

FOR I = 0 TO 255
        ReadRGB I, R, g, B

        IF R >= B AND R >= g THEN
                Trans(I) = FIX(R / 4)
        ELSEIF B >= g AND B >= R THEN
                Trans(I) = FIX(B / 4)
        ELSEIF g >= R AND g >= B THEN
                Trans(I) = FIX(g / 4)
        ELSE
                Trans(I) = FIX(g / 4)
        END IF
        'Trans(I) = (r + g + b) \ 2     '16 NORMAL
NEXT I


END SUB

SUB InitValues STATIC

BallSpd = 1   'Change for Speed

BallXV = BallSpd
BallYV = -BallSpd
PadX = 100
PadY = 170
PadOldX = PadX
PadOldY = PadY

Score& = 0
Lives = 2

ColorAttr = 1 + INT(RND * 7)
ColorStep = 1 + INT(RND * 50)
Level = 0

END SUB

FUNCTION Inside (X, Y, X1, Y1, X2, Y2) STATIC

Inside = False


IF X >= X1 AND X <= X2 THEN
        IF Y >= Y1 AND Y <= Y2 THEN
                Inside = True
        END IF
END IF

IF Y >= Y1 AND Y < Y2 THEN
        IF X >= X1 AND X <= X2 THEN
                Inside = True
        END IF
END IF


END FUNCTION

SUB KgenFont (X, Y, Font$, MinColor, Italic) STATIC

'=======Prints system fonts on screen  specified by X,Y
'=======Uses 8 colors from mincolor to Mincolor+8
'=======Font$ is the string, italic? Duh!!!!!
'=====Sample Code
        'Note Kgen....Min are constants
        'X = 261
        'Y = 183
        'Font$ = "RelSoft"
        'Italic = True
        'KgenFont X - 1, Y - 1, Font$, KgenGreenMin, Italic
        'KgenFont X, Y, Font$, KgenBlueMin, Italic
'End Sample
'======================================================

DIM E(7): E(0) = 1: FOR F = 1 TO 7: E(F) = E(F - 1) + E(F - 1): NEXT F

XXX = X
YYY = Y

IF X = 320 THEN X = 160 - (4 * LEN(Font$))




DEF SEG = &HFFA6
FOR A = 1 TO LEN(Font$)
KC = 0
IF Italic THEN
        Ita = 8
ELSE
        Ita = 0
END IF

 X = X + 8
 D = ASC(MID$(Font$, A, 1)) * 8 + 14
 FOR B = 0 TO 7
  FOR C = 0 TO 7
   IF PEEK(B + D) AND E(C) THEN PSET ((X - C) + Ita, Y + B), MinColor + KC
  NEXT C
        KC = KC MOD 8 + 1
           IF Italic THEN
                Ita = Ita - 1
           END IF
 NEXT B
NEXT A

DEF SEG

X = XXX
Y = YYY

END SUB

SUB KgenTTFont (X, Y, Font$, MinColor, Xscale, Yscale, Italic) STATIC

'=======Prints scalable system fonts on screen  specified by X,Y
'=======Uses 8 colors from mincolor to Mincolor+8
'=======Font$ is the string, italic? Duh!!!!!
'=======Xscale/Yscale are scale to enlarge the font
'=====Sample Code
        'Note Kgen....Min are constants
        'X = 261
        'Y = 183
        'Xscale=3
        'Yscale=2
        'Font$ = "RelSoft"
        'Italic = True
        'KgenTTFont X - 1, Y - 1, Font$, KgenGreenMin,Xscale,Yscale Italic
        'KgenTTFont X, Y, Font$, KgenBlueMin,,Xscale,Yscale Italic
'End Sample
'======================================================

DIM E(7): E(0) = 1: FOR F = 1 TO 7: E(F) = E(F - 1) + E(F - 1): NEXT F

XXX = X
YYY = Y
XSS = Xscale
YSS = Yscale

IF X = 320 THEN X = 160 - ((4 * Xscale * LEN(Font$)))



IF Italic THEN
        Ita = 8
ELSE
        Ita = 0
END IF


DEF SEG = &HFFA6
FOR A = 1 TO LEN(Font$)

KC = 0
YY = 0
XX = 0

 X = X + (8 * Xscale)
 D = ASC(MID$(Font$, A, 1)) * 8 + 14
 FOR B = 0 TO 7
        YY = YY + Yscale
        XX = 0
  FOR C = 0 TO 7
        IF PEEK(B + D) AND E(C) THEN LINE (X - (C * Xscale) + Ita, Y + YY)-STEP(-(Xscale - 1), Yscale - 1), MinColor + KC, BF
        XX = XX + Xscale
  NEXT C
        KC = KC MOD 8 + 1

           IF Italic THEN
                Ita = Ita - 1
                IF Ita < 1 THEN Ita = 8
           END IF

 NEXT B

NEXT A

DEF SEG

X = XXX
Y = YYY
Xscale = XSS
Yscale = YSS

END SUB

SUB LevelDoneBox STATIC

PutBall BallX, BallY

SELECT CASE Level
        CASE 5, 10, 15, 20, 25, 30, 35, 40, 45, 50
                X1 = 20
                Y1 = 140
                X2 = 240
                Y2 = Y1 + 40
        CASE ELSE
                X1 = 20
                Y1 = 115
                X2 = 240
                Y2 = Y1 + 40
END SELECT

TransLuc 170, X1, Y1, X2, Y2   '170 best


X = X1 + 41
Y = Y1 + 4
Font$ = CHR$(1) + " Well done!!!! " + CHR$(1)
Italic = False
KgenFont X, Y, Font$, KgenMin, Italic

X = X1 + 42
Y = Y1 + 5
Font$ = CHR$(1) + " Well done!!!! " + CHR$(1)
Italic = False
KgenFont X, Y, Font$, KgenGreenMin, Italic



X = X1 + 5
Y = Y1 + 15
Font$ = "You have defeated LEVEL:" + LTRIM$(STR$(Level))
Italic = False
KgenFont X, Y, Font$, KgenBlueMin, Italic

X = X1 + 32
Y = Y1 + 28
Font$ = "Press <Enter> key..."
Italic = True
KgenFont X, Y, Font$, KgenBlueMin, Italic

X = X1 + 33
Y = Y1 + 29
Font$ = "Press <Enter> key..."
Italic = True
KgenFont X, Y, Font$, KgenGreenMin, Italic


SfxOpenDialog

END SUB

SUB LimitScore STATIC

IF Score& >= 99999999 THEN
        Score& = 99999999

END IF

END SUB

SUB LoadBallExpImage STATIC

REDIM BallExp(1 TO 1)
REDIM BallExpmsk(1 TO 1)
REDIM BallExpIndex(1 TO 1)

FileName$ = "BallExp.put"
FileName$ = Path$ + "Images\" + FileName$
InitImageData FileName$, BallExp()
FileName$ = "BallExp.msk"
FileName$ = Path$ + "Images\" + FileName$
InitImageData FileName$, BallExpmsk()

MakeImageIndex BallExp(), BallExpIndex()

END SUB

SUB LoadBallImage STATIC

REDIM Ball(1 TO 1)   '1st image=Mask, 2nd=Ball
REDIM BallIndex(1 TO 1)

FileName$ = "QbBall.put"
FileName$ = Path$ + "Images\" + FileName$
InitImageData FileName$, Ball()

MakeImageIndex Ball(), BallIndex()

END SUB

SUB LoadBlkHoleImage STATIC


REDIM BlkHole(1 TO 1)
REDIM BlkHoleMask(1 TO 1)

REDIM BlkHoleIndex(1 TO 1)

FileName$ = "BlkHole.put"
FileName$ = Path$ + "Images\" + FileName$
InitImageData FileName$, BlkHole()
FileName$ = "BlkHole.Msk"
FileName$ = Path$ + "Images\" + FileName$
InitImageData FileName$, BlkHoleMsk()


MakeImageIndex BlkHole(), BlkHoleIndex()


END SUB

SUB LoadBombImage STATIC

REDIM Bomb(1 TO 1)
REDIM BombMsk(1 TO 1)
REDIM BombIndex(1 TO 1)

FileName$ = "Bomb.put"
FileName$ = Path$ + "Images\" + FileName$
InitImageData FileName$, Bomb()
FileName$ = "Bomb.msk"
FileName$ = Path$ + "Images\" + FileName$
InitImageData FileName$, BombMsk()

MakeImageIndex Bomb(), BombIndex()

END SUB

SUB LoadExplodeImage STATIC

REDIM Explode(1 TO 1)
REDIM Explodemsk(1 TO 1)
REDIM ExplodeIndex(1 TO 1)

FileName$ = "Explode.put"
FileName$ = Path$ + "Images\" + FileName$
InitImageData FileName$, Explode()
FileName$ = "Explode.msk"
FileName$ = Path$ + "Images\" + FileName$
InitImageData FileName$, Explodemsk()


MakeImageIndex Explode(), ExplodeIndex()

END SUB

SUB LoadFlyExpImage STATIC
REDIM FlyExp(1 TO 1)   '1st image=Spr, 2nd =Mask
REDIM FlyExpIndex(1 TO 1)
FileName$ = "FlyExp.put"
FileName$ = Path$ + "Images\" + FileName$
InitImageData FileName$, FlyExp()

MakeImageIndex FlyExp(), FlyExpIndex()

END SUB

SUB LoadGame STATIC

X = 0
Y = 0
REDIM Item$(8)

Item$(0) = "* * Load * *"
FOR I = 1 TO UBOUND(Item$)
Item$(I) = LTRIM$(STR$(Save(I).Num)) + "." + Save(I).Namer
NEXT I

P = PullDown(X, Y, Item$(), False)

IF P <> 0 THEN
        'Loadit
        Score& = Save(P).Score
        Level = Save(P).Level - 1
        Lives = Save(P).Lives
        OutStart = True
        Finished = True
END IF


END SUB

SUB LoadLangawImage STATIC

REDIM Langaw(1 TO 1)   '1st/2nd image=Spr, 3/4 =Masks
REDIM LangawIndex(1 TO 1)

FileName$ = "Langaw.put"
FileName$ = Path$ + "Images\" + FileName$
InitImageData FileName$, Langaw()

MakeImageIndex Langaw(), LangawIndex()

END SUB

SUB LoadPaddleImage STATIC

REDIM Paddle(1 TO 1)   '1st image=Mask, 2nd=paddle,3rd & 4th= PoweredUp Paddle
REDIM PaddleIndex(1 TO 1)

FileName$ = "Paddle.put"
FileName$ = Path$ + "Images\" + FileName$
InitImageData FileName$, Paddle()

MakeImageIndex Paddle(), PaddleIndex()

END SUB

SUB LoadPadLsrImage STATIC

REDIM Padlsr(1 TO 1)   '1st image=Laser, 2nd =Mask
REDIM PadlsrIndex(1 TO 1)

FileName$ = "PadLasr.put"
FileName$ = Path$ + "Images\" + FileName$
InitImageData FileName$, Padlsr()

MakeImageIndex Padlsr(), PadlsrIndex()

END SUB

SUB LoadPointerImage STATIC

REDIM Pointer(1 TO 1)   '1st image=Mask, 2nd =pointer
REDIM PointerIndex(1 TO 1)

FileName$ = "Pointer.put"
FileName$ = Path$ + "Images\" + FileName$
InitImageData FileName$, Pointer()

MakeImageIndex Pointer(), PointerIndex()

END SUB

SUB LoadPowerCapsImage STATIC

REDIM PowerCaps(1 TO 1)   '1st  to 3rd image=PowerCaps, 4nd =Mask
REDIM PowerCapsIndex(1 TO 1)

FileName$ = "PwerCaps.put"
FileName$ = Path$ + "Images\" + FileName$
InitImageData FileName$, PowerCaps()

MakeImageIndex PowerCaps(), PowerCapsIndex()

END SUB

SUB LoadSaveFiles STATIC


'Saved Games for Loading and Saving
OPEN Path$ + "saves\" + "qbnoid.qsv" FOR INPUT AS #1

FOR I = 1 TO 8
        INPUT #1, SaveNum
        INPUT #1, Name$
        INPUT #1, ScoreTemp&
        INPUT #1, LevelTemp
        INPUT #1, LivesTemp
        Save(I).Num = SaveNum
        Save(I).Namer = Name$
        Save(I).Score = ScoreTemp&
        Save(I).Level = LevelTemp
        Save(I).Lives = LivesTemp
NEXT I

CLOSE

'Hall of Fame

OPEN Path$ + "saves\" + "qbnoid.hof" FOR INPUT AS #1

FOR I = 1 TO 5
        INPUT #1, Rank
        INPUT #1, Name$
        INPUT #1, ScoreTemp&
        Hall(I).Rank = Rank
        Hall(I).Namer = Name$
        Hall(I).Score = ScoreTemp&
NEXT I

CLOSE

        SortIt


END SUB

SUB LoadTitle STATIC

LINE (0, 0)-(320, 199), 0, BF

DEF SEG = &HA000
BLOAD Path$ + "images\" + "arqanoid.bsv", 0

RestoreColors

DO
        IF RGBCounter(RGBC * 5) THEN RotateRGB
        WAIT &H3DA, 8
        WAIT &H3DA, 8, 8
LOOP UNTIL INKEY$ <> ""
DEF SEG

HazyFx
Fade 0, 0, 0

LINE (0, 0)-(319, 199), 0, BF

END SUB

SUB MakeImageIndex (ImageArray(), IndexArray())

    'The index will initially be built in a temporary array, allowing
    'for the maximum 1000 images per file.
    DIM Temp(1 TO 1000)
    Ptr& = 1: IndexNo = 1: LastInt = UBOUND(ImageArray)
    DO
        Temp(IndexNo) = Ptr&
        IndexNo = IndexNo + 1

        'Evaluate descriptor of currently referenced image to
        'calculate the beginning of the next image.
        X& = (ImageArray(Ptr&) \ 8) * (ImageArray(Ptr& + 1)) + 4
        IF X& MOD 2 THEN X& = X& + 1
        Ptr& = Ptr& + (X& \ 2)
    LOOP WHILE Ptr& < LastInt

    LastImage = IndexNo - 1

    'Copy the image index values into the actual index array.
    REDIM IndexArray(1 TO LastImage)
    FOR n = 1 TO LastImage
        IndexArray(n) = Temp(n)
    NEXT n

END SUB

FUNCTION Menu STATIC

Menu = 0

X = 48
Y = 10
REDIM Item$(7)

Item$(0) = CHR$(2) + CHR$(2) + " Menu " + CHR$(2) + CHR$(2)

Item$(1) = "New Game"
Item$(2) = "Save Game"
Item$(3) = "Load Game"
Item$(4) = "Special(???)" + CHR$(1)
Item$(5) = "View Credits"
Item$(6) = "Hall of Fame"
Item$(7) = "Exit Game"


M = PullDown(X, Y, Item$(), True)

Menu = M

END FUNCTION

SUB MilliDelay (msecs) STATIC

    IF sysfact& THEN                             'calc- system speed yet?
        IF msecs THEN                            'have to want a delay
            COUNT& = (sysfact& * msecs) \ -54    'calc- # of loops needed
            DO
                COUNT& = COUNT& + 1              'negative - add to get to 0
                IF COUNT& = z THEN EXIT DO       'when its 0 we're done
            LOOP UNTIL T2 = PEEK(&H6C)           'make it the same as below
        END IF
    ELSE                                         'calc- system speed
        DEF SEG = &H40                           'point to low memory
        T1 = PEEK(&H6C)                          'get tick count
        DO
            T2 = PEEK(&H6C)                      'get tick count
        LOOP UNTIL T2 <> T1                      'wait 'til its a new tick
        DO
            sysfact& = sysfact& + 1              'count number of loops
            IF sysfact& = z THEN EXIT DO         'make it the same as above
        LOOP UNTIL T2 <> PEEK(&H6C)              'wait 'til its a new tick
        T2 = 256                                 'prevent the above UNTIL
    END IF

END SUB

FUNCTION MovePaddle (PadX, PadY) STATIC

GOSUB CheckLives

IF Replicant THEN
        PadXMax = 180
                IF PadX > PadXMax THEN
                        PutPaddleBG PadOldX, PadOldY
                        PadX = PadXMax
                END IF
ELSE
        PadXMax = 217
END IF


MovePaddle = False
        SELECT CASE FastKB
                CASE KRight, KD
                        IF PadX < PadXMax - PadSpd THEN
                                PadX = PadX + PadSpd
                                MovePaddle = True
                        END IF
                CASE KLeft, KA
                        IF PadX > PadSpd + 5 THEN
                                PadX = PadX - PadSpd
                                MovePaddle = True
                        END IF
                CASE KDown, KS, KEnd
                        AutoFire = False
                        Shooting = False
                        Lshot = False
                        Rshot = False
                CASE KUp, KW, KCtrl
                        AutoFire = True
                        Shooting = True
                        Lshot = True
                        Rshot = True
                CASE KSpc, KPgd, KTab
                        OutStart = True
                        AutoFire = False
                        Shooting = True
                        Lshot = True
                        Rshot = True
                CASE KEsc
                        M = Menu
                        GOSUB CheckMval
                        RefreshKey
                CASE KEnt
                CASE ELSE
        END SELECT


EXIT FUNCTION



'=====================subs=================
CheckMval:

SELECT CASE M
        CASE 0  'Pressed esc do nothing
        CASE 1  'New game
                Score& = 0
                Level = 0
                Lives = 2
                OutStart = True
                Finished = True
        CASE 2  'Save Game
                SaveGame
        CASE 3  'Load Game
                LoadGame
        CASE 4  'Special
                MS = SubMenu
                GOSUB CheckMSval
        CASE 5  'Credits
                DoCredits
        CASE 6  'HallofFame
                DoHallOfFame
        CASE 7  'Exit Game
                OutStart = True
                Finished = True
                GameOver = True
                Check4HoF
        CASE ELSE
END SELECT

RETURN
'==========
CheckMSval:
        SELECT CASE MS
                CASE 0
                CASE 1   'Skip Level
                        OutStart = True
                        Finished = True
                CASE 2   'MoreLives
                        Lives = 99
                        PrintLives False
                CASE 3   'NoSpikes
                        PUT (7, 183), SpikeBG, PSET
                CASE 4   'PadPower
                        IF NOT SpStage THEN
                                IF NOT PadPower THEN
                                        PadPower = True
                                        GOSUB InitPadlsr
                                END IF
                        ELSE
                                CheatError
                        END IF
                CASE 5   'Replicant
                        IF NOT SpStage THEN
                                Replicant = True
                        ELSE
                                CheatError
                        END IF
                CASE 6   'EraseFiles
                        EraseSaveFiles
                CASE ELSE
        END SELECT
RETURN

'==========
CheckLives:

IF Lives < -1 THEN
        Finished = True
        GameOver = True
        OutStart = True
        Check4HoF
END IF

RETURN


'=========
InitPadlsr:

        GetPadLsrCoord 0
        GetPadLsrBG PadLsrBG1(), PadLsrBG2()

RETURN



END FUNCTION

SUB NameEntry STATIC


DX = 10
DY = 10
MaxLen = 24
Title$ = "Ace Player!!!"
Tmin = PadColorMin
Sysmod = False
Text$ = "~~~~Congratulations!!! Kambal! You have a new record! Pls. Send your score to me and I'll give you money.  Just jokin' hehehehe.  "
Text$ = Text$ + "Actually, you earn NOTHING by playing this game. Just  bragging rights....                                                          "

REDIM Temp(1)
GetBG DX, DY, DX + 192, DY + 135, Temp()
DialogBox DX, DY, MaxLen, Tmin, Title$, Text$, False, Sysmod
KgenFont DX + 10, DY + 106, "Your Score:", KgenBlueMin, False
KgenFont DX + 10 + (8 * 11), DY + 106, LTRIM$(STR$(Score&)), KgenMin, False
KgenFont DX + 10, DY + 116, "EnterName:", KgenBlueMin, False


GOSUB EnterName
SfxOpenDialog

IF P$ = CHR$(13) THEN
        'SaveHiscore
        IF LEN(Item$) > 0 THEN
                Hall(5).Namer = Item$
                Hall(5).Score = Score&
                SortIt
                GOSUB SaveHOF
        END IF
END IF


DoHallOfFame

EXIT SUB

'=======================

EnterName:

REDIM ST(1)
GetBG DX + 10 + (10 * 8), DY + 116, (DX + 10 + (10 * 8)) + (12 * 8), DY + 116 + 8, ST()
PUT (DX + 10 + (10 * 8), DY + 116), ST, PSET
Item$ = ""


DO

        DO
                P$ = INKEY$
                IF LEN(Item$) < 12 THEN
                        KgenFont DX + 10 + (10 * 8) + (LEN(Item$) * 8), DY + 116, "_", KgenGreenMin, False
                END IF
                IF RGBCounter(RGBC * 5) THEN RotateRGB
                WAIT &H3DA, 8
        LOOP UNTIL P$ <> ""

        IF ASC(P$) >= 32 AND ASC(P$) <= 127 THEN
                IF LEN(Item$) < 12 THEN
                        Item$ = Item$ + (P$)
                        PUT (DX + 10 + (10 * 8), DY + 116), ST, PSET
                        KgenFont DX + 10 + (10 * 8), DY + 116, Item$, KgenMin, False
                        SOUND 1200, 1
                        RefreshKey
                ELSE
                        RefreshKey
                END IF
        ELSE
                IF P$ = CHR$(8) THEN
                        IF LEN(Item$) > 0 THEN
                                Item$ = LEFT$(Item$, LEN(Item$) - 1)
                                PUT (DX + 10 + (10 * 8), DY + 116), ST, PSET
                                KgenFont DX + 10 + (10 * 8), DY + 116, Item$, KgenMin, False
                                SOUND 1200, 1
                                RefreshKey
                        ELSE
                                RefreshKey
                        END IF
                END IF
        END IF

LOOP UNTIL P$ = CHR$(13) OR P$ = CHR$(27)

PUT (DX, DY), Temp, PSET

RETURN

'=======================
SaveHOF:

        OPEN Path$ + "saves\" + "qbnoid.hof" FOR OUTPUT AS #1
                
                FOR I = 1 TO 5
                        PRINT #1, Hall(I).Rank
                        PRINT #1, Hall(I).Namer
                        PRINT #1, Hall(I).Score
                NEXT I


        CLOSE

RETURN

END SUB

SUB OpenLvlFile (File$) STATIC
OPEN File$ FOR INPUT AS #1

FOR I = 0 TO TileMax
        INPUT #1, Tile(I).X
        INPUT #1, Tile(I).Y
        INPUT #1, Tile(I).C
        IF Tile(I).C = 0 THEN
                Tile(I).F = False
        ELSE
                Tile(I).F = True
        END IF
NEXT I

CLOSE


END SUB

SUB PlayGame STATIC


ReinitValues


DrawLevelBG Level, ColorStep, ColorAttr      'Bgmode(Unused),Type(looks),color

GetTileBackGround




SelectLevel

DoBlkHole
DoBomb


RestoreColors

Finished = False


GetBallCenter BallCenterX, BallCenterY


StartGame


DO


GOSUB CheckForPowerCaps
GOSUB CheckForPadPwr



GetBallBG BallX, BallY
GetPaddleBG PadX, PadY


PutBall BallX, BallY
PutPaddle PadX, PadY



GOSUB CheckSDHit

Flag = MovePaddle(PadX, PadY)


WAIT &H3DA, 8
WAIT &H3DA, 8, 8

GOSUB BugFix:


PutBallBG BallOldX, BallOldY



IF Collide THEN
        CheckBounceCounter BounceCounter
END IF



PutPaddleBG PadOldX, PadOldY


IF PadPower THEN
        PutPadLsrBG PadLsrBG1(), PadLsrBG2()
END IF

IF Power THEN
        PutPowerCapsBG
END IF

GOSUB RotRGBETC
'IF BossSTG THEN
'        DoLangaw False
'END IF


LOOP UNTIL Finished

HazyFx

GOSUB CheckFadeTo

EXIT SUB

'===========subs===========================



BugFix:


IF BallY < 40 THEN
        MilliDelay 5
END IF


RETURN


CheckFadeTo:

SELECT CASE Level
        CASE 5, 10, 15, 20, 25, 30, 35, 40, 45, 50
                Fade 0, 0, 0
        CASE ELSE
                Fade INT(RND * 63), INT(RND * 63), INT(RND * 63)
END SELECT

RETURN
'===========
CheckSDHit:

IF SdHitPad THEN
        SOUND 3000, 1
        SOUND 3400, 1
        SdHitPad = False
END IF

IF SdHitTile THEN
       SOUND 2300, 1
       SdHitTile = False
       WAIT &H3DA, 8
       WAIT &H3DA, 8, 8
       BlinkTile False
END IF


RETURN

'=================
CheckForPadPwr:

IF PadPower THEN
                IF NOT Shooting THEN
                        GetPadLsrCoord 0
                        GetPadLsrBG PadLsrBG1(), PadLsrBG2()
                        PutPadLsr PadLsrCoord(0).X, PadLsrCoord(0).Y
                        PutPadLsr PadLsrCoord(1).X, PadLsrCoord(1).Y
                ELSE
                        DoPadLsr
                END IF
ELSE

END IF


RETURN

'===========
CheckForPowerCaps:
        IF Power THEN
                DoPowerCaps PowerType
        END IF
RETURN


'========
RotRGBETC:
BlkCount = BlkCount MOD 5 + 1
BombCount = BombCount MOD 50 + 1
LangawCount = LangawCount MOD 2 + 1

        IF LangawCount = 1 THEN
                IF BossStg THEN
                        DoLangaw False
                END IF
        END IF


        IF BlkCount = 1 THEN
                DoBlkHole
        END IF

        IF BombCount = 1 THEN

                GetBallBG BallX, BallY
                GetPaddleBG PadX, PadY

                PutBall BallX, BallY
                PutPaddle PadX, PadY

                PutBombBG
                DoBomb

                PutPaddleBG PadOldX, PadOldY
                PutBallBG BallOldX, BallOldY
        END IF

IF RGBCounter(RGBC) THEN RotateRGB

RETURN


END SUB

SUB PrintFonts (X, Y, n$) STATIC

SHARED SmallFonts() AS INTEGER

n$ = LTRIM$(RTRIM$(UCASE$(n$)))

Letter$ = "@.,:!?ABCDEFGHIJKLMNOPQRSTUVWXYZ "


FOR I = 1 TO LEN(n$)
        II$ = MID$(n$, I, 1)
        OffSet = INSTR(Letter$, II$)
        PUT ((I * 5) + X, Y), SmallFonts((OffSet - 1) * FontOffset), PSET
NEXT I


END SUB

SUB PrintLevel STATIC

X = 297
Y = 51

IF Level < 10 THEN
        LV$ = "0" + LTRIM$(STR$(Level))
ELSE
        LV$ = LTRIM$(STR$(Level))
END IF

Font$ = LV$
Italic = True
KgenFont X - 2, Y + 1, Font$, KgenMin, Italic
KgenFont X, Y, Font$, KgenBlueMin, Italic


END SUB

SUB PrintLives (EraseIt) STATIC



LY = 76
LX = 265
LINE (LX, LY - 1)-(320, 122), 0, BF
FOR I = 0 TO Lives
        IF NOT EraseIt THEN
                PUT (LX, LY), Ball(BallIndex(2)), PSET
        ELSE
                PUT (LX, LY), Ball(BallIndex(1)), PSET
        END IF

        LX = LX + 7
        IF LX > 313 THEN
                LX = 265
                LY = LY + 7
        END IF

        IF I > 40 THEN EXIT FOR

NEXT I


END SUB

SUB PrintNum (X, Y, n$) STATIC
SHARED SmallNum() AS INTEGER

FOR I = 1 TO LEN(n$)
        II$ = MID$(n$, I, 1)
        OffSet = INSTR("1234567890,", II$)
        PUT ((I * 5) + X, Y), SmallNum((OffSet - 1) * FontOffset), PSET
NEXT I


END SUB

SUB PrintScore STATIC

        Temp$ = LTRIM$(Format$(Score&))
        PrintNum 315 - (LEN(Temp$) * 5), 35, Temp$

        IF Score& >= 100000 THEN
                PrintNum 315 - (LEN(Temp$) * 5), 12, Temp$
        END IF

END SUB

FUNCTION PullDown (X, Y, Item$(), Italic) STATIC

'=========Draws a PullDown menu==========
'=========Returns an integer (Value of I)
'======Sample Code=======================
        'X = 10
        'Y = 20
        'REDIM Item$(8)
        'Item$(0) = "* * Save * *"
        'FOR I = 1 TO UBOUND(Item$)
        'Item$(I) = LTRIM$(STR$(I)) + ".RelSoft 2000"
        'NEXT I
        'P = PullDown(X, Y, Item$(),True)
'========End Sample========================

MaxItem = UBOUND(Item$)
REDIM PointerCoord(0 TO MaxItem) AS CoordType
REDIM PointerCoord2(0 TO MaxItem) AS CoordType

REDIM PTemp(34), Ptemp2(34)
REDIM Temp(1)

PullDown = 0
KgenStart = 30

FOR I = 0 TO MaxItem
        Item$(I) = LTRIM$(RTRIM$(Item$(I)))
NEXT I

'Calculate how big our box is
X1 = X
Y1 = Y

GOSUB CalcBox


GetBG X1, Y1, X2, Y2, Temp()

TransLuc 170, X1, Y1, X2, Y2   '170 best

'=Title
XX = ((X2 - X1) \ 2) - (4 * (LEN(Item$(0))))
KgenFont X1 + XX - 8, Y1 + 11, Item$(0), KgenMin, NOT Italic
KgenFont X1 + (XX - 8) + 1, Y1 + 12, Item$(0), KgenBlueMin, NOT Italic

GOSUB InitCoord
GOSUB DrawItem
OutPullDown = False

I = 1
GOSUB GetPLtemp
PutPointer PointerCoord(I).X - 12, PointerCoord(I).Y, PointerCoord2(I).X, PointerCoord2(I).Y


DO


        IF RGBCounter(RGBC * 6) THEN RotateRGB
        WAIT &H3DA, 8
        GOSUB CheckKey


LOOP UNTIL OutPullDown

PUT (X1, Y1), Temp, PSET

RefreshKey

ERASE PointerCoord, PointerCoord2, PTemp, Ptemp2, Temp

EXIT FUNCTION

''==============Subs=========
'============

CheckKey:

        SELECT CASE FastKB
                CASE KRight, KD
                CASE KLeft, KA
                CASE KDown, KS
                        GOSUB PutPLtemp
                        I = I MOD MaxItem + 1
                        GOSUB GetPLtemp
                        PutPointer PointerCoord(I).X - 12, PointerCoord(I).Y, PointerCoord2(I).X, PointerCoord2(I).Y
                        GOSUB DosoundP
                CASE KUp, KW
                        GOSUB PutPLtemp
                        I = (I + MaxItem - 2) MOD MaxItem + 1
                        GOSUB GetPLtemp
                        PutPointer PointerCoord(I).X - 12, PointerCoord(I).Y, PointerCoord2(I).X, PointerCoord2(I).Y
                        GOSUB DosoundP
                CASE KEsc
                        OutPullDown = True
                        PullDown = 0
                        GOSUB Dosound2P
                CASE KEnt, KSpc
                        OutPullDown = True
                        GOSUB Dosound2P
                        PullDown = I
                CASE ELSE
        END SELECT

RETURN

'============
InitCoord:

        Ystep = 14
        YY = Y1 + Ystep + 16

        FOR I = 1 TO MaxItem

                PointerCoord(I).X = X1 + 30
                PointerCoord(I).Y = YY
                YY = YY + Ystep

        NEXT I

RETURN




'==========
DrawItem:

FOR I = 1 TO MaxItem

        Font$ = LEFT$(LTRIM$(Item$(I)), 1)
        Font2$ = RIGHT$(LTRIM$(Item$(I)), LEN(Item$(I)) - 1)

        KgenFont PointerCoord(I).X + 1, PointerCoord(I).Y - 1, Font$, KgenMin, False
        KgenFont PointerCoord(I).X, PointerCoord(I).Y, Font$, KgenGreenMin, False
        KgenFont PointerCoord(I).X + 10, PointerCoord(I).Y, Font2$, KgenStart, Italic
        IF Italic THEN
                PointerCoord2(I).X = PointerCoord(I).X + ((LEN(Font2$) + 2) * 8) + 5
        ELSE
                PointerCoord2(I).X = PointerCoord(I).X + ((LEN(Font2$) + 2) * 8)
        END IF
        PointerCoord2(I).Y = PointerCoord(I).Y

NEXT I

RETURN

'========
DosoundP:
        FOR SI = 500 TO 2000 STEP 100
                SOUND SI, .1
        NEXT SI
        FOR SI = 1000 TO 500 STEP -100
                SOUND SI, .1
        NEXT SI

RETURN
'=======
Dosound2P:

        DIM Dsi AS SINGLE
        Dsi = .9

        FOR SI = 300 TO 3000 STEP 50
                IF Dsi > .1 THEN Dsi = Dsi - .1
                SOUND SI, Dsi
        NEXT SI

RETURN



'========

GetPLtemp:
        GET (PointerCoord(I).X - 12, PointerCoord(I).Y)-STEP(8, 6), PTemp
        GET (PointerCoord2(I).X, PointerCoord2(I).Y)-STEP(8, 6), Ptemp2
RETURN

PutPLtemp:
        PUT (PointerCoord(I).X - 12, PointerCoord(I).Y), PTemp, PSET
        PUT (PointerCoord2(I).X, PointerCoord2(I).Y), Ptemp2, PSET

RETURN


'===========

CalcBox:


FOR I = 0 TO MaxItem
        IF LEN(Item$(I)) > 18 THEN
                Item$(I) = LEFT$(Item$(I), 18)
        END IF
NEXT I

Longest = LEN(Item$(0))

FOR I = 1 TO MaxItem
        IF LEN(Item$(I)) > Longest THEN
                Longest = LEN(Item$(I))
        END IF
NEXT I

IF Italic THEN
        LL = 16
ELSE
        LL = 12
END IF

Y2 = (Y1 + 20 + 14 + (MaxItem * 14))
X2 = (X1 + (Longest * 8)) + 55 + LL

RETURN


END FUNCTION

SUB PutBall (BallX, BallY) STATIC


        PUT (BallX, BallY), Ball(BallIndex(1)), AND
        PUT (BallX, BallY), Ball(BallIndex(2)), XOR

END SUB

SUB PutBallBG (BallOldX, BallOldY) STATIC
        PUT (BallOldX, BallOldY), BallBG, PSET
END SUB

SUB PutBlkHole (X, Y) STATIC

I = I MOD UBOUND(BlkHoleIndex) + 1
PUT (X, Y), BlkHoleMsk(BlkHoleIndex(I)), AND
PUT (X, Y), BlkHole(BlkHoleIndex(I)), OR

END SUB

SUB PutBlkHoleBG STATIC

FOR I = 1 TO 4
        IF BlkHoleXY(I).X <> 0 THEN
                PUT (BlkHoleXY(I).X, BlkHoleXY(I).Y), BlkHoleBG(130 * (I - 1)), PSET
        END IF
NEXT I

END SUB

SUB PutBomb (X, Y, Switch) STATIC

'Switch must be 1 or 2

PUT (X, Y), BombMsk(BombIndex(Switch)), AND
PUT (X, Y), Bomb(BombIndex(Switch)), OR

END SUB

SUB PutBombBG STATIC

FOR I = 1 TO UBOUND(BombXY)
        IF BombXY(I).X <> 0 THEN
                PUT (BombXY(I).X, BombXY(I).Y), BombBG(130 * (I - 1)), PSET
        END IF
NEXT I

END SUB

SUB PutLangaw (X, Y, Axn) STATIC

'Axn=1 or 2
PUT (X, Y), Langaw(LangawIndex(Axn + 2)), AND
PUT (X, Y), Langaw(LangawIndex(Axn)), OR


END SUB

SUB PutPaddle (PadX, PadY) STATIC

IF PadPower THEN
        IF Replicant THEN
                PUT (PadX, PadY), Paddle(PaddleIndex(3)), AND
                PUT (PadX, PadY), Paddle(PaddleIndex(4)), OR
                PUT (PadX + 38, PadY), Paddle(PaddleIndex(3)), AND
                PUT (PadX + 38, PadY), Paddle(PaddleIndex(4)), OR
        ELSE
                PUT (PadX, PadY), Paddle(PaddleIndex(3)), AND
                PUT (PadX, PadY), Paddle(PaddleIndex(4)), OR
        END IF
ELSE
        IF Replicant THEN
                PUT (PadX, PadY), Paddle(PaddleIndex(1)), AND
                PUT (PadX, PadY), Paddle(PaddleIndex(2)), OR
                PUT (PadX + 38, PadY), Paddle(PaddleIndex(1)), AND
                PUT (PadX + 38, PadY), Paddle(PaddleIndex(2)), OR
        ELSE
                PUT (PadX, PadY), Paddle(PaddleIndex(1)), AND
                PUT (PadX, PadY), Paddle(PaddleIndex(2)), OR
        END IF

END IF

END SUB

SUB PutPaddleBG (PadOldX, PadOldY) STATIC
        PUT (PadOldX, PadOldY), PaddleBG, PSET
END SUB

SUB PutPadLsr (X, Y) STATIC

PUT (X, Y), Padlsr(PadlsrIndex(2)), AND
PUT (X, Y), Padlsr(PadlsrIndex(1)), OR

END SUB

SUB PutPadLsrBG (Image1(), Image2()) STATIC

PUT (PadLsrOldCoord(0).X, PadLsrOldCoord(0).Y), Image1, PSET
PUT (PadLsrOldCoord(1).X, PadLsrOldCoord(1).Y), Image2, PSET

END SUB

SUB PutPointer (X, Y, X2, Y2) STATIC

PUT (X, Y), Pointer(PointerIndex(1)), AND
PUT (X, Y), Pointer(PointerIndex(2)), OR

PUT (X2, Y2), Pointer(PointerIndex(3)), AND
PUT (X2, Y2), Pointer(PointerIndex(4)), OR



END SUB

SUB PutPowerCaps (X, Y, PowType) STATIC

PUT (X, Y), PowerCaps(PowerCapsIndex(4)), AND
PUT (X, Y), PowerCaps(PowerCapsIndex(PowType)), OR

END SUB

SUB PutPowerCapsBG STATIC
        PUT (PowerCapsOldCoord(0).X, PowerCapsOldCoord(0).Y), PowerCapsBG, PSET
END SUB

SUB ReadLevel (Lvl) STATIC

OpenLvlFile Path$ + "levels\" + "qbnoid" + LTRIM$(STR$(Lvl)) + "." + "lvl"

TileNumber = 0


FOR I = 0 TO TileMax
        IF Tile(I).F THEN
                DrawTile Tile(I).X, Tile(I).Y, Tile(I).C
                IF Tile(I).C <> 9 THEN
                        TileNumber = TileNumber + 1
                END IF
        END IF
NEXT I

END SUB

SUB ReadRGB (C%, R%, g%, B%)

OUT &H3C7, C%
R% = INP(&H3C9)
g% = INP(&H3C9)
B% = INP(&H3C9)

END SUB

SUB RefreshKey STATIC

DEF SEG = &H40
POKE &H1A, PEEK(&H1C)
DEF SEG


END SUB

SUB ReInitBallSpd STATIC

SELECT CASE SGN(BallXV)
        CASE -1
                BallXV = -BallSpd
        CASE 1
                BallXV = BallSpd
        CASE ELSE
END SELECT

SELECT CASE SGN(BallYV)
        CASE -1
                BallYV = -BallSpd
        CASE 1
                BallYV = BallSpd
        CASE ELSE
END SELECT



END SUB

SUB ReinitValues STATIC

BallSpd = 1   'Change for Speed


BallXV = BallSpd
BallYV = -BallSpd



PadX = 105
PadY = 170
PadOldX = PadX
PadOldY = PadY


ColorAttr = 1 + INT(RND * 7)
ColorStep = 1 + INT(RND * 50)
Level = Level MOD 50 + 1

'Power ups
PadPower = False    'Paddle changes and can shoot
Replicant = False   'Replicates ur paddle
MultiBall = False   '?????? not a power up makes d game harder
Shooting = False
Lshot = False
Rshot = False
Power = False
BossEnter = False


'Sounds
SdHitPad = False    'Sound for PaddleHit
SdHitTile = False
SdHitBoss = False

LimitScore


END SUB

SUB RestoreColors
II = 0
I = 0


FOR II = 0 TO 63


FOR I = 0 TO 255
RefreshKey

        ReadRGB I, RR, GG, BB
                R = SavRGB(I).R
                g = SavRGB(I).g
                B = SavRGB(I).B

        IF R > RR THEN
                RR = RR + 1
        ELSEIF R < RR THEN
                RR = RR - 1
        ELSE
                'Do nothing
        END IF

        IF g > GG THEN
                GG = GG + 1
        ELSEIF g < GG THEN
                GG = GG - 1
        ELSE
                'Do nothing
        END IF

        IF B > BB THEN
                BB = BB + 1
        ELSEIF B < BB THEN
                BB = BB - 1
        ELSE
                'Do nothing
        END IF

        WriteRGB I, RR, GG, BB

NEXT I

MilliDelay 30
WAIT &H3DA, 8
WAIT &H3DA, 8, 8

NEXT II


END SUB

FUNCTION RGBCounter (MaxCounter) STATIC

'==========Counts until reaches MaxCounter then True is returned else False
'==========Used to make Color rotation at same speed

RGBCounter = False

I = I MOD MaxCounter + 1
        IF I = MaxCounter THEN
                RGBCounter = True
        END IF

END FUNCTION

SUB RotateRGB STATIC

'==KGen==================
'red
FOR I = KgenMin TO KgenMax - 1
        SWAP SavRGB(I), SavRGB(I + 1)
NEXT I
FOR I = KgenMin TO KgenMax
        WriteRGB I, SavRGB(I).R, SavRGB(I).g, SavRGB(I).B
NEXT I

'blue
FOR I = KgenBlueMax TO KgenBlueMin + 1 STEP -1      'Shift Direction Down
        SWAP SavRGB(I), SavRGB(I - 1)
NEXT I
FOR I = KgenBlueMin TO KgenBlueMax
        WriteRGB I, SavRGB(I).R, SavRGB(I).g, SavRGB(I).B
NEXT I

'Green
FOR I = KgenGreenMin TO KgenGreenMax - 1
        SWAP SavRGB(I), SavRGB(I + 1)
NEXT I
FOR I = KgenGreenMin TO KgenGreenMax
        WriteRGB I, SavRGB(I).R, SavRGB(I).g, SavRGB(I).B
NEXT I


'==End Kgen==========================

'======Pointer=======================

IF PointerC > 57 THEN ClrDir = 1
IF PointerC < 20 THEN ClrDir = 0

IF ClrDir = 0 THEN PointerC = PointerC + 5
IF ClrDir = 1 THEN PointerC = PointerC - 5

WriteRGB 244, 0, PointerC, 33      'Inside of pointer
WriteRGB 245, PointerC, 33, PointerC     'Border of pointer

'======End pointer===================

'======Paddle========================

FOR I = PadColorMin TO PadColorMax - 1
        SWAP SavRGB(I), SavRGB(I + 1)
NEXT I
FOR I = PadColorMin TO PadColorMax
        WriteRGB I, SavRGB(I).R, SavRGB(I).g, SavRGB(I).B
NEXT I

'=====end paddle====================

END SUB

SUB SaveColors

FOR I = 0 TO 255
        ReadRGB I, R, g, B
        SavRGB(I).R = R
        SavRGB(I).g = g
        SavRGB(I).B = B
NEXT I

END SUB

SUB SaveGame STATIC


X = 0
Y = 0
REDIM Item$(8)

Item$(0) = "* * Save * *"
FOR I = 1 TO UBOUND(Item$)
Item$(I) = LTRIM$(STR$(Save(I).Num)) + "." + Save(I).Namer
NEXT I


P = PullDown(X, Y, Item$(), False)

IF P <> 0 THEN

        GOSUB EnterLevel

        IF LEN(LTRIM$(Item$(P))) > 1 AND P$ = CHR$(13) THEN
                'Saveit
                Save(P).Num = P
                Save(P).Namer = Item$(P)
                Save(P).Score = Score&
                Save(P).Level = Level
                Save(P).Lives = Lives
                GOSUB Saveit
        END IF

END IF


EXIT SUB


'================Subs========================

EnterLevel:

                DX = 0
                DY = 150
                MaxLen = 39
                Title$ = ""
                Tmin = PadColorMin
                Text$ = "Save this game as..." + "#" + LTRIM$(STR$(P)) + "[" + SPACE$(12) + "]"
                Sysmod = False
                REDIM Temp(1)
                GetBG DX, DY, DX + 319, DY + 20, Temp()
                DialogBox DX, DY, MaxLen, Tmin, Title$, Text$, False, Sysmod
                Item$(P) = ""

                REDIM ST(1)
                GetBG DX + 188, DY + 4, DX + 188 + (12 * 8), DY + 4 + 8, ST()
                PUT (DX + 188, DY + 4), ST, PSET


                DO

                        DO
                                P$ = INKEY$
                                IF LEN(Item$(P)) < 12 THEN
                                        KgenFont DX + 188 + (LEN(Item$(P)) * 8), DY + 5, "_", KgenMin, False
                                END IF
                                IF RGBCounter(RGBC * 5) THEN RotateRGB
                                WAIT &H3DA, 8

                        LOOP UNTIL P$ <> ""

                        IF ASC(P$) >= 32 AND ASC(P$) <= 127 THEN
                                IF LEN(Item$(P)) < 12 THEN
                                        Item$(P) = Item$(P) + (P$)
                                        PUT (DX + 188, DY + 4), ST, PSET
                                        KgenFont DX + 188, DY + 5, Item$(P), KgenBlueMin, False
                                        SOUND 1200, 1
                                        RefreshKey
                                ELSE
                                        RefreshKey
                                END IF
                        ELSE
                                IF P$ = CHR$(8) THEN
                                        IF LEN(Item$(P)) > 0 THEN
                                                Item$(P) = LEFT$(Item$(P), LEN(Item$(P)) - 1)
                                                PUT (DX + 188, DY + 4), ST, PSET
                                                KgenFont DX + 188, DY + 5, Item$(P), KgenBlueMin, False
                                                SOUND 1200, 1
                                                RefreshKey
                                        ELSE
                                                RefreshKey
                                        END IF
                                END IF
                        END IF

                LOOP UNTIL P$ = CHR$(13) OR P$ = CHR$(27)

                PUT (DX, DY), Temp, PSET
                SfxOpenDialog

RETURN

'=====================

Saveit:

        OPEN Path$ + "saves\" + "qbnoid.qsv" FOR OUTPUT AS #1

        FOR I = 1 TO 8

                SaveNum = Save(I).Num
                Name$ = Save(I).Namer
                ScoreTemp& = Save(I).Score
                LevelTemp = Save(I).Level
                LivesTemp = Save(I).Lives

                PRINT #1, SaveNum
                PRINT #1, Name$
                PRINT #1, ScoreTemp&
                PRINT #1, LevelTemp
                PRINT #1, LivesTemp
        NEXT I

        CLOSE

RETURN


END SUB

SUB ScrollKgenTT (TopY, Text$, Xscale, Yscale, MinColor, Shadow, OverTop, OverTopY, Italic, FirstTime) STATIC

'==========Scrolls Scalable KgenTT Fonts on screen=========================
'Sample code
        'Text$ = "Richard Eric M. Lope Bsn Rn WVSU College of Nursing.  This is Very Cool!!!!!!    "
        'Xscale = 2
        'YScale = 5
        'TopY = 199 - ((YScale) * 9)
        'MinColor = KgenBlueMin
        'Shadow = True
        'OverTop = True
        'OtY = 0
        'Italic = True
        'FirstTime=True  'always True
        'DO
        'ScrollKgenTT TopY, Text$, Xscale, YScale, MinColor, Shadow, OverTop, OtY, Italic
        'CC = CC MOD 8 + 1
        'IF CC = 1 THEN RotateRGB
        'LOOP UNTIL INKEY$ <> ""
'End sample
'========================================================================

IF FirstTime THEN
        P = 0
        PP = 0
        Counter = 0
        FirstTime = NOT FirstTime
END IF



Y = TopY
Y2 = OverTopY
X = 1
T$ = Text$
Xs = Xscale
YS = Yscale
C = MinColor
L = LEN(Text$)

REDIM Scroll(1)
REDIM Scroll2(1)
REDIM L$(L)

FOR I = 1 TO L
        L$(I) = MID$(T$, I, 1)
NEXT I


XX = 312 - (Xs * 9)

IF Shadow THEN
        XXX = (8 * Xs) + 1
ELSE
        XXX = 8 * Xs
END IF


                GetBG X, Y, 319, Y + (8 * YS) + YS, Scroll()
                PUT (X - 1, Y), Scroll, PSET
                IF OverTop THEN
                        GetBG 0, Y2, 318, Y2 + (8 * YS) + YS, Scroll2()
                        PUT (1, Y2), Scroll2, PSET
                END IF

                Counter = (Counter MOD (Xs * 8)) + 1


                IF Counter = 1 THEN
                                P = P MOD L + 1
                                PP = (PP + L - 2) MOD L + 1
                        IF Shadow THEN
                                KgenTTFont XX - 1, Y - 1, L$(P), KgenMin, Xs, YS, Italic
                                IF OverTop THEN
                                        KgenTTFont XXX - 1, Y2, L$(PP), KgenMin, Xs, YS, Italic
                                END IF
                        END IF

                        KgenTTFont XX, Y, L$(P), C, Xs, YS, Italic
                        IF OverTop THEN
                                KgenTTFont XXX, Y2 + 1, L$(PP), C, Xs, YS, Italic
                        END IF


                END IF

END SUB

SUB SelectLevel


ReadLevel Level


FOR I = 1 TO UBOUND(BombXY)
        BombXY(I).X = 0
        BombXY(I).Y = 0
NEXT I

BombNum = UBOUND(BombXY)

FOR I = 1 TO UBOUND(BlkHoleXY)
        BlkHoleXY(I).X = 0
        BlkHoleXY(I).Y = 0
NEXT I
BombSTG = False
BossStg = False


SELECT CASE Level
        CASE 5
                'Bonus 1
                CalcBombCoord 5
        CASE 10
                'Boss 1

                BossX = 73
                BossY = 9
                DrawBoss BossX, BossY, "Rotator"
                TileNumber = 1
                BossLife = 2000
                BlkHoleXY(1).X = 24
                BlkHoleXY(1).Y = 95
                BlkHoleXY(2).X = 60
                BlkHoleXY(2).Y = 55
                BlkHoleXY(3).X = 185
                BlkHoleXY(3).Y = 55
                BlkHoleXY(4).X = 220
                BlkHoleXY(4).Y = 95
                BossStg = True
                CalcLangawCoord
        CASE 15
                'Bonus 2
                CalcBombCoord 4
        CASE 20
                'Boss 2
                BossX = 85
                BossY = 9
                DrawBoss BossX, BossY, "TGL"
                TileNumber = 1
                BossLife = 2500
                BlkHoleXY(1).X = 22
                BlkHoleXY(1).Y = 59
                BlkHoleXY(2).X = 230
                BlkHoleXY(2).Y = 59
                BlkHoleXY(3).X = 70
                BlkHoleXY(3).Y = 91
                BlkHoleXY(4).X = 180
                BlkHoleXY(4).Y = 91
                BossStg = True
                CalcLangawCoord
        CASE 25
                'Bonus 3
                CalcBombCoord 3

        CASE 30
                'Boss 3
                BossX = 45
                BossY = 11
                DrawBoss BossX, BossY, "Ku2"
                TileNumber = 1
                BossLife = 3000
                BlkHoleXY(1).X = 95
                BlkHoleXY(1).Y = 110
                BlkHoleXY(2).X = 150
                BlkHoleXY(2).Y = 110
                BlkHoleXY(3).X = 72
                BlkHoleXY(3).Y = 90
                BlkHoleXY(4).X = 176
                BlkHoleXY(4).Y = 90
                BossStg = True
                CalcLangawCoord
        CASE 35
                'Bonus 4
                CalcBombCoord 2
        CASE 40
                'Boss 4
                BossX = 63
                BossY = 9
                DrawBoss BossX, BossY, "Mummy"
                TileNumber = 1
                BossLife = 4000
                BlkHoleXY(1).X = 23
                BlkHoleXY(1).Y = 100
                BlkHoleXY(2).X = 23
                BlkHoleXY(2).Y = 80
                BlkHoleXY(3).X = 226
                BlkHoleXY(3).Y = 80
                BlkHoleXY(4).X = 226
                BlkHoleXY(4).Y = 100

                BossStg = True
                CalcLangawCoord
        CASE 45
                'Bonus 5
                CalcBombCoord 1

        CASE 50
                'Boss 5

                BossX = 97
                BossY = 11
                DrawBoss BossX, BossY, "SkullQB"
                TileNumber = 1
                BossLife = 5000
                BlkHoleXY(1).X = 17
                BlkHoleXY(1).Y = 130
                BlkHoleXY(2).X = 112
                BlkHoleXY(2).Y = 130
                BlkHoleXY(3).X = 133
                BlkHoleXY(3).Y = 130
                BlkHoleXY(4).X = 226
                BlkHoleXY(4).Y = 130

                BossStg = True
                CalcLangawCoord
        CASE ELSE
                'load Normal Levels
                BossLife = 1
                FOR I = 1 TO 4
                        BlkHoleXY(I).X = 0
                        BlkHoleXY(I).Y = 0
                NEXT




END SELECT

PrintLevel
GetBlkHoleBG

END SUB

SUB SfxOpenDialog STATIC

FOR II = 400 TO 900 STEP 10
        SOUND II, .1
NEXT II


END SUB

SUB SfxPowerUp STATIC

        DIM Dsi AS SINGLE

        GetBallBG BallX, BallY
        GetPaddleBG PadX, PadY

        PutBall BallX, BallY
        PutPaddle PadX, PadY
                FOR SI = 500 TO 1400 STEP 100
                        Dsi = RND
                        SOUND SI, Dsi
                NEXT SI
        PutPaddleBG PadOldX, PadOldY
        PutBallBG BallOldX, BallOldY
END SUB

SUB SndExplode STATIC


        FOR SI = 3000 TO 400 STEP -250
                SOUND SI, .1
        NEXT SI

END SUB

SUB SortIt STATIC
'Dont Bother with this. It's bubble sort Slow but gets the job done this time

  DO
    Switcher = False
    FOR I = 1 TO 4
      IF Hall(I).Score < Hall(I + 1).Score THEN

        Hall(I + 1).Rank = I
        Hall(I).Rank = I + 1
        SWAP Hall(I), Hall(I + 1)

        Switcher = True

      END IF
    NEXT I
  LOOP WHILE Switcher


END SUB

FUNCTION SpecialStage (DX, DY, MaxLen, Tmin, Title$, Text$)

SpecialStage = False
DX = 0
DY = 0
MaxLen = 0
Title$ = ""
Tmin = PadColorMin
Text$ = ""


SELECT CASE Level
        '====Bosses=================
        CASE 10
                DX = 22
                DY = 70
                MaxLen = 27
                Title$ = "Rotator:"
                Tmin = PadColorMin
                Text$ = "~~~~You have beat me first to have a chance at defeating GIGA!!! Not even KONAMI(tm) could stop me!"
                SpecialStage = True
        CASE 20
                DX = 22
                DY = 70
                MaxLen = 27
                Title$ = "ZAVOT:"
                Tmin = PadColorMin
                Text$ = "~~~~This would be your last stop! Ull die here 4 sure. I Zavot will shave all of your hair! Mwa ha ha ha..."
                SpecialStage = True
        CASE 30
                DX = 22
                DY = 70
                MaxLen = 27
                Title$ = "Ku2:"
                Tmin = PadColorMin
                Text$ = "~~~~Hik hik hik hik... I you dare challenge me?! The parasites of all parasites?! Ha! I'll kill you now..."
                SpecialStage = True
        CASE 40
                DX = 22
                DY = 70
                MaxLen = 27
                Title$ = "The Rock:"
                Tmin = PadColorMin
                Text$ = "~~~~Time will never stop me from conquering ur world. Without Brendan Frasier and his extremely vivacious wife 2 help u... I, the Scorpion King will be victorious!!!"
                SpecialStage = True

        CASE 50
                DX = 22
                DY = 70
                MaxLen = 27
                Title$ = "GIGA:"
                Tmin = PadColorMin
                Text$ = "~~~~You idiot!!! How many times do I have to kill one of your race 4 u 2 understand that even ur whole army can't withstand the wrath of Gago?! Now Die!!!"
                SpecialStage = True

        '======Bonus stages=========
        CASE 5
                GOSUB BonusDialog
        CASE 15
                GOSUB BonusDialog
        CASE 25
                GOSUB BonusDialog
        CASE 35
                GOSUB BonusDialog
        CASE 45
                GOSUB BonusDialog
        CASE ELSE
END SELECT


EXIT FUNCTION


'==================

BonusDialog:


PUT (7, 183), SpikeBG, PSET

DX = 22
DY = 70
MaxLen = 27
Title$ = "       Bonus Stage!"
Tmin = PadColorMin
Text$ = "~~~~Pop as much BOMBS as possible before time runs out! Good luck!"
SpecialStage = True
BombDes = 0

RETURN

END FUNCTION

SUB StartGame STATIC


PrintLives False

OutStart = False
BallSpd = 1
BounceCounter = 0


BallX = PadX + (16)



GetPadLsrCoord 0
GetPadLsrBG PadLsrBG1(), PadLsrBG2()


IF SpecialStage(DX, DY, MaxLen, MinColor, Title$, Text$) THEN
        IF NOT BossEnter THEN
                Sysmod = True
                DialogBox DX, DY, MaxLen, MinColor, Title$, Text$, False, Sysmod
                BossEnter = True
        END IF
        SpStage = True
ELSE
        SpStage = False
END IF


'''==========Start Loop===============

DO

Shooting = False
Lshot = False
Rshot = False

GOSUB CheckForPadPower:


GetBallBG BallX, BallY
GetPaddleBG PadX, PadY



PutBall BallX, BallY
PutPaddle PadX, PadY

Flag = MovePaddle(PadX, PadY)
BallX = PadX + (16)


'Millidelay 2


WAIT &H3DA, 8



PutBallBG BallOldX, BallOldY

PutPaddleBG PadOldX, PadOldY

IF PadPower THEN
        PutPadLsrBG PadLsrBG1(), PadLsrBG2()
END IF


GOSUB RotMisc


LOOP UNTIL OutStart

''===================End loop=========================

PutBombBG
DoBomb


BallXV = BallSpd
BallYV = -BallSpd

EXIT SUB

'==============Subs========================
CheckForPadPower:

IF PadPower THEN
                IF NOT Shooting THEN
                        GetPadLsrCoord 0
                        GetPadLsrBG PadLsrBG1(), PadLsrBG2()
                        PutPadLsr PadLsrCoord(0).X, PadLsrCoord(0).Y
                        PutPadLsr PadLsrCoord(1).X, PadLsrCoord(1).Y
                ELSE
                        DoPadLsr
                END IF
        BallY = PadY - 7
ELSE
        BallY = PadY - 4
END IF

RETURN

'==============
RotMisc:

IF RGBCounter(RGBC) THEN RotateRGB

BlkCount = BlkCount MOD 5 + 1
BombCount = BombCount MOD 50 + 1
LangawCount = LangawCount MOD 2 + 1

        IF LangawCount = 1 THEN
                IF BossStg THEN
                        DoLangaw False
                END IF
        END IF

        IF BlkCount = 1 THEN
                DoBlkHole

        END IF

        IF BombCount = 1 THEN
                GetBallBG BallX, BallY
                GetPaddleBG PadX, PadY

                PutBall BallX, BallY
                PutPaddle PadX, PadY

                PutBombBG
                DoBomb

                PutPaddleBG PadOldX, PadOldY
                PutBallBG BallOldX, BallOldY

        END IF

RETURN




END SUB

FUNCTION SubMenu STATIC


SubMenu = 0

X = 35
Y = 20
REDIM Item$(6)

Item$(0) = CHR$(2) + " Debug Code " + CHR$(2)

Item$(1) = "Skip Level!!!"
Item$(2) = "More Lives!!!"
Item$(3) = "No Spikes!!!"
Item$(4) = "Power Paddle!!!"
Item$(5) = "Replicant!!!"
Item$(6) = "Erase Saves!"


S = PullDown(X, Y, Item$(), True)

SubMenu = S

END FUNCTION

SUB TransLuc (n, X1, Y1, X2, Y2)
'N= Test Value of Color
'X1=MinX
'X2=MaxX
'Y1=MinY
'Y2=MaxY


DEF SEG = &HA000
FOR I = 0 TO 2
        LINE (X1 + I, Y1 + I)-(X2 - I, Y1 + I), KgenMin + I + 1
        LINE (X1 + I, Y1 + I)-STEP(0, I + 2), KgenMin + I + 1
        LINE (X2 - I, Y1 + I)-STEP(0, I + 2), KgenMin + I + 1
NEXT I

FOR Y = Y1 + 3 TO Y2 - 3
        POKE (Y * 320& + X1), KgenMin + 1
        POKE (Y * 320& + X1 + 1), KgenMin + 2
        POKE (Y * 320& + X1 + 2), KgenMin + 3
        FOR X = X1 + 3 TO X2 - 3
                C = PEEK(Y * 320& + X)
                POKE (Y * 320& + X), Trans(C) + n
        NEXT X
        POKE (Y * 320& + X2), KgenMin + 1
        POKE (Y * 320& + X2 - 1), KgenMin + 2
        POKE (Y * 320& + X2 - 2), KgenMin + 3
NEXT Y
FOR I = 0 TO 2
        LINE (X1 + I, Y2 - I)-(X2 - I, Y2 - I), KgenMin + I + 1
        LINE (X1 + I, Y2 - I)-STEP(0, I - 2), KgenMin + I + 1
        LINE (X2 - I, Y2 - I)-STEP(0, I - 2), KgenMin + I + 1

NEXT I

DEF SEG

END SUB

SUB WriteRGB (C%, R%, g%, B%)

OUT &H3C8, C%

OUT &H3C9, R%
OUT &H3C9, g%
OUT &H3C9, B%

END SUB

