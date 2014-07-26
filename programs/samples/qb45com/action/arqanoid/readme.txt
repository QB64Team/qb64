ARQANOID Readme.Txt file
June 26,2001
7:30 PM
Richard Eric M. Lope BSN RN
vic_viperph@yahoo.com

Note: Use Word Wrap to see the text properly

=================
Table of Contents
=================

I. Introduction
II. History
III. Mechanics
IV. Faqs
V. Credits
VI. Disclaimer

=================
I. Introduction
=================

	The idea to make an arkanoid(tm) clone came to me while developing engines for my shooter and RPG.  I was going to make a game which would not use any library and it would also run inside the QB IDE.  I was just trying to see if a decent game could be made inside the limitations of screen 13h chained mode.  I was partially right and partially wrong.  While I was developing engines for my RPG and Gradius clone, I was loosing my patience trying to make flickerless animations.  So I searched the Net for answers and found nothing after days of research. :(.  Then with a stroke of luck, I went to GBgames' links, then to the newly resurrected Neozones and found Andrew Ayers' tutorial about Get/Put array offseting.  There came the idea to remake my Arkanoid clone.  I had simple ambitions when I started.  I was only trying to give it some background.  Then came the idea to make it better than the original.  I'm going to give it a little twist.  It would have leaders and a storyline.  I also was trying to see how much flickerfree animations I could make w/o the use of page swapping.  It was how it all began.... 
	Note: I refuse to call this a pong clone since I have never played the original Pong.  

=================
II. History
=================

   This game took a long time to make since I don't have the luxury of time while making this.  I could only work on this project during weekends, I have a social life you know..., and I also have a nagging wife who makes me go to bed early.  BTW, I'm a Registered Nurse and only have "computer 101" as a formal training in the field of computers.  Most of my knowledge came from QB's help file and from the you guys, the QB community! This game took almost 3 months to make.

Note: When I say week, I mean 2 days per week...


Month I

First week: 
	Day 1. Developed engines for the game, Read about the BMP file system
	Day 2. Made my Bmp2put file converter(Used to rip Nes game graphics),
		Developed the game's bouncing mechanism using vectors alone.
		Developed my font routines using offsetting.

Second week:
	Day 1. Developed my palletes and tile system. Added the point 			function to the colission detection system. Found out how to 		use Ascii ROM addresses and developed my KGEN font routine.

	Day 2. Added the "inside" function for colission detection. Also 		added directional colission detection.  Ripped graphics for 		my first boss.(GIGA)

Third Week:
	Day 1. Played Nesticle games. Lots of games. To see what bosses would 		look good for this game.  
	Day 2. Ripped graphics from nesticle using my BMP2Put.bas routine and 		changed its color attributes (for a little twist). 

Fourth Week:
	Day 1. Put all the sprites in my game. Started development of the 		level editor.
	Day 2. Added aesthetics to my level editor. Optimized it and made 		levels up to level 15.

Month 2

First Week:
	Day 1. Recoded some routines from the game.  Fixed some bugs. Made 		Levels.
	Day 2. Finished making Levels. Optimized my routines.  Discovered 		PP256 by Chris Chadwick.  Learned it, and wanted to make my 		game look even better. Still trying to learn PP256...

Second Week:
	Day 1. Rewrote routines for some of my sprites except BMP2Put 			compatible ones(ie. bosses). Drew sprites(PP256)...
	Day 2. Still Drawing... or trying to draw... hehehehe.

Third Week:
	Day 1. Still drawing....
	Day 2. Added power ups! And menu system. Bug Hunt. Tried to reduce 		flicker as much as possible.

Fourth Week:
	Day 1. Out of town for vacation.
	Day 2. Playing arcade games while on vacation.	

Month 3

First Week:
	Day 1. Added bonus stages. Reduced flicker for sprites...
	Day 2. Bug Hunt.Bug Hunt.Bug Hunt.Bug Hunt.Bug Hunt.Bug Hunt.

Second Week:
	Day 1. Bug Hunt.Bug Hunt.Bug Hunt.Bug Hunt.Bug Hunt.Bug Hunt.
	Day 2. Bug Hunt.Bug Hunt.Bug Hunt.Bug Hunt.Bug Hunt.Bug Hunt.

Third Week:
	Day 1. Optimized.Optimized.Optimized.Optimized.Optimized.
	Day 2. Game testing.......Bug Hunt.Bug Hunt.Bug Hunt.

Fourth Week:
	Day 1. Bug Hunt. Testing...
	Day 2. Transported my files in one directory. Finished the Game.


=================
III Mechanics
=================

   I. Arqanoid.

	License:FreeWare(Use/Abuse/Modify at your own risk)

	1. Controls
		Left Arrow/A 	: Moves paddle left
		Right Arrow/D	: Moves paddle Right
		Up Arrow/W/CTRL	: Auto Fire on when in power paddle mode
		Down Arrow/S/End: Auto Fire off when in power paddle mode
		Space/Tab/PGD	: Fire missiles when in power paddle mode
		Escape key	: Activate the MENU/Abort menu selection
		Enter Key	: Confirm menu selection

	2. How to play
			You start off at level 1.  You have to destroy all 		the blocks except the metallic yellow ones(Tile No. 9 in 		level designer). Each block has a corresponding score.  
			Every tenth(10) Level is a boss stage. There are no 		blocks to destroy in these stages.  You have to kill the boss 		to progress to the next stage.  But beware of those black 		holes. They spew unlimited number of insects to you(2 at a 		time). Once you hit an insect, your ball increases its speed 		to make the game harder.  You kill bosses by hitting them 		with your ball.  Note: I intentionally disabled some powerups 		in these stages for added challenge.  
			There's also bonus stages at levels 5,15,25...45.  		Spikes are disabled here so you don't die.  You finish these 		levels by destroying the bombs before the time runs out.  The 		bombs you destroy will be multiplied by 2000 and added to 		your score.  If you destroy all of the bombs before the 60 		second time limit expires.  You will get an additional 20,000 		for a special bonus!
			Beat all the levels and bosses up to level 50 and 		you'll see the ending!!!

	3. The Menu
		1. Main
			New Game	=Starts a new game
			Save Game	=Saves the game currently played
			Load Game	=Loads a previously saved game
			Special		=Opens a sub menu(Debug Code)
			View credits	=Ya have ta see this!
			Hall of Fame	=Opens record holders!
			Exit Game	=Game over! :(
		2. Debug Code: ie Cheat!
			Skip Level	=Warps you to the next level
			More Lives	=99 Lives
			No Spikes	=Disables spikes
			Power Paddle	=Powers up your paddle.*
			Replicant	=Doubles your paddle.*
			Erase Saves	=Erases Saved Games and Hall of Fame.

			* Unavailable during Bosses and bonus stages.

   II. Level Designer

	1. Controls
		Arrow Keys	=Moves cursor
		W,A,S,D Keys	=Moves cursor
		SpaceBar	=Rotates/Selects tile
		Tab/Enter	=Puts Tile
		Delete		=Erases Tile
		F5		=Opens a dialog box for saving level
		Escape		=Activates the menu
	2. Menu
		New File	=Opens a "bare" screen for a new level
		Edit File	=Opens a dialogbox for choosing a lvl 2 edit
		Escape		=Disables the menu
		Exit		=???
	3. Tile Types
		Number		Color		Type
		1		RED		Lowest Score
		2		Green		do
		3		Blue		do
		4		Light Blue	do
		5		Purple		do
		6		Yellow		do
		7		Metallic Blue	2 hits to destroy
		8		Metallic Purple	3 hits to destroy
		9		Metallic Yellow	Indestructible, no score


==================
IV. FAQS
==================

1. About me
	Name: 		Richard Eric M. Lope BSN RN
	Occupation: 	Nurse
	School: 	West Visayas State University
	Residence:	Florvel Homes, Buray, Oton, Iloilo, Philippines
	Status:		Married with one daughter
	Age:		26
	Laguages I program with: QuickBasic,Turbo Pascal,C/C++,Visual Basic
2. Why QuickBasic??
		The Added challenge.  I know when I started programming this 	game that Speed would be an issue but Quickbasic gives me an 		oppurtunity to flex my optimization "Muscles" and QB makes you an 	ingenius programmer.  I don't mean to pick on pascal or c++ but I'm 	much more impressed with persons who can make good games with QB than 	with persons who could make the same game with C or Pascal.  I do 	make programs with them but I'm not making money out of programming 	(except VB sometimes...) so I dedicated myself to QB.  I'm what you 	could call a "hobbyist" programmer so QB would be the best choice 	since it's "portable".  It's also because of you, the QB community, 	that I decided to be a QB game programmer.
3. Why the CRAPPY music?
		My computer doesn't have a soundcard so I can only make sound 	effects using the pc's internal speaker. In fact, I give you the 	right to add better sounds to this game as long as you notify me 	first.  I'm working on a new PIT delay sound routine to solve it... 	but I'm having problems... (PIT delay inables you to make BG sound 	routines using the PC speaker. I've managed to get it done using C++ 	already!)
4. What is your computer's specs.?
		486dx2 running on windows 95. Pls. don't laugh... this is the 	 only one I could afford.  
5. How did you get those NES sprites?!
		Developed my BMP2Put.bas routine(it converts parts of 256 	color bmp file to Qbasic's put format). Played games on NESTICLE, 	saved it as PCX(that's the only way to rip graphics from Nesticle), 	opened it using paint, saved it as 256 color bmp, then opened it with 	BMP2Put.bas and saved it as a put file. Got it?  Note: If you want my 	BMP2put routine, I could give it to you via E-Mail.  Pls. e-mail me 	if you want one.
6. Any known bugs?
		Aside from the occasional flicker? Yes. The ball sometimes 	gets "magnetized" while hitting the paddle.  I cannot do anything 	about it since it involves the paddle speed VS ball speed. The paddle 	runs at 3 pixels per move while the ball at full speed runs at 2. 	3+2=5 while collision detection is at most 2 pixels per detection, so 	the ball sometimes gets "trapped" inside the paddle.  I could fix it 	by giving my paddle a one pixel speed but playability would suffer. 	Anyway, It's a rare occasion.
7. Other bugs?
		Yes again!  The ball sometimes gets stuck inside the bosses. 	Reason: Masking! Zero's tend to be "masked" so other boss areas tend 	to be transparent and the "collide" function could not detect it.
		For other bugs you might encounter pls e-mail them to me.  I 	would love to hear from you.
8. That power capsule looks like....
		You're right! DarkDread's.  I ripped it from one of his 	games.  It's my way of giving tribute to people who help me a lot 	about Game programming. I just hope he doesn't get mad...
9. What would be your next project?
		Either an RPG or a Shooter. And for the first time I would 	use a LIBRARY so it would look better.  I've already developed 		engines for both.  In fact, I used some of it in this game, notably 	the Word-Wrap DialogBoxes, Font routines, and Enemy movement 		patterns.  If I only could draw better.... huhuhuhu. Any takers for 	sprite developer? hehehehe....
10. What methods of Colission detection are used in this game?
		There are 3 methods of collision detection used in this game. 	1. The ever popular point function,2. My "Inside" function and 3. 	Direcional collision detection( Defined by the constants 		UR,UL,DR,DL).  All are found inside the "Collide" Function.
11. And the method for bouncing?
		Vectors! You define the balls Direction by making it equal to 	ballspeed and negating(-) it when it hits something.  The vectors are 	defined my the Global Variables BallXV and BallYV.
12. Do you have a Website?
		NO! I just don't have the time to maintain it. Being unable 	to maintain a site would defeat its purpose.  There are a lot of 	great sites out there anyway...
13. The Game is too hard.
		In case you don't know, this is Arqanoid and not Pong! And 	Arkanoid is the hardest game I've known so far.  I couldn't get past 	level 4 on its arcade version! This coming from a guy who could 	finish all the strikers 1945 series w/o losing a single life using 	any plane. I could get to 2-5 in strikers 1,Finished(Up to 2-8) 	strikers 2, and got to 2-7 in Strikers 3. That using only one token. 	My record still stands at the arcades.  I could also finish all the 	Raiden games (except Raiden 1) with one token.  I also got records at 	Raiden F Jet and Viper Phase.  
		You can actually make the game easier/harder using the level 	editor.  You could also send your levels to me if you want to.  I'd 	really appreciate it.

==================
V. Credits
==================

		I would like to give thanks to people and entities who help 	me made this game(Directly or Indirectly).

	Families & Friends

	1. God/Jesus Christ
		He gave me LIFE.
	2. Anya Therese Lope
		My daughter.
	3. My Family(Pedro,Lily,Marie,Cristina)
		They'll get mad if I don't mention them here.
	4. Loreni Farillon
		My Text pal.  She took the time to chat with me via SMS at 		night when I feel like sleeping.
	5. The Guys at WIC internet
		Jason,Alan, Shote and Tin-tin.  For allowing me to bsave my 		title screen there. My Hard drive is compressed so I'm having 		problems Bsaving.  I also tested my game there on a Duron 		800.
	6. Archie Aurelio & Joey 
		My Arcade friends at ZAP ZONE.


	QB Community	

	1. Andrew Ayers(Blast Lib)
		Without you I've never have thought of making this game!
	2. Chris Chadwick(PP256)
		Made the game better looking.(w/o PP256 this game would look 		like SH%$!)
	3. Vance Velez (VPlanet)
		Reviewed my first game(Pacmaniod) paving the way for this 		game.
	4. Gianncarlo (GBgames)
		W/O his site(GBgames.com), I would never have disovered the 		QB community.
	5. Jorden Chamid(FutureSoft)
		Duh! As if you don't know it already. They're the best out 		there!
	6. Vic Luce (VQB)
		Taught me how to do masking. Also makes great tutorials.
	7. Danny Gump (Dash)
		Tutorial on get/put array system.
	8. Steven Sivek
		Rom addresses of Ascii Characters(Used in Kgen Fonts)
	9. ZKman
		Translucency (Non-Alpha blending type)
	10. DarkDread
		Dark Crown wowed! me and inspired me to make a QB game.
	11. Andre
		MilliDelay(very useful!)
	12. Nesticle
		Used to rip sprites from NES games. FYI, I own the original 		cartridge of the games I ripped sprites from. Best NES EMU!
	13. KGEN and LoopyNES
		Inspiration for my KGEN font routine and a very good NES EMU 		for the latter.
	14. The QBTIMES
		Provided me with the BMP file format.
	15. NeoZones
		Great Tutorial site.
	16. Konami(tm)
		Ripped LifeForce Sprites
	17. Irem(tm),Compile(tm) and Broderbund software(tm)
		Ripped the Guardian Legend Sprites.
	18. Taxan(tm)
		Ripped Burai Fighter Sprites.


==================		
VI. Disclaimer
==================

		This document and its accompanying files are provided as is.  I take no responsibility for the inconveniences it might cause you. No part of this document may be altered(except when you modify the game itself).  I give you the right to modify the Game in any way you want as long as you get permission from me, and you give credit to where credit is due.  The license of this game is Freeware so Use or Abuse at your own risk....

*Arkanoid is a trademark of NAMCO
*Konami & LifeForce are TradeMarks of Konami
*Irem,Compile,TGL, and Broderbund holds the right to their respective 	trademarks
*Taxan and Burai Fighter are trademarks of Taxan.


================end of File=================================================