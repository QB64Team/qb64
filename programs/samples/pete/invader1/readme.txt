Taito's Space Invaders


    ##     The Invaders march ...
   ####      Bom bom bom bom ...
  ######       Left, right, fire!
 ## ## ##        Faster, faster they march ...
 ########          Suddenly you're 11 again!
   #  #              Dodge the bombs ...
  # ## #               They're turning green ...
 # #  # #                Get them before they land!


A version of Taito's original Space Invaders(TM) for the PC

anarky, April 2005

http://www.anarky.tk/
anarkynet@hotmail.com

Disclaimer

This game is mailware. That is, it's free to use and distribute anywhere you
like, but only on condition that you keep the two files together and that you
don't charge any payment for it. Also, when you download it, email me on the
above address.

Also, I cannot be held responsible if this program does anything nasty to your
machine. It hasn't damaged anyone's PC that I'm aware of and there's no reason
why it should, really.


Playing

Start QuickBasic and load invader1.bas. Now press F5.

Left         - Left CTRL
Right        - Left ALT
Fire         - Right SHIFT
Stop program - Esc


History

What's to be said? I remember as a kid playing the original on the big consoles.
So I thought, "Why not port it to the PC?" Heh, so I did.


Needs

Basically, don't worry - it'll almost certainly work on your PC.

Requires:
---------

DOS - tested with MS-DOS 7.1 and Windows 95. No known lower limit. I don't
know if it works with Windows 2000 or Windows ME.

VGA - tested with generic standard low-grade video card. It uses screen 13:
320x200x256, so it should work on yours no matter what it is.

Supports:
---------

Soundblaster - tested with AWE32. Make sure you've got your soundcard driver
set up for DOS (e.g. if you have a Soundblaster, a line starting 'SET BLASTER=' in your
c:\autoexec.bat file).


Technical

Uses ports:
-----------

&H3DA - for vertical retrace

&H388
&H389 - for Adlib sound

&H3C6
&H3C8
&H3C9 - for palette setting

Uses memory locations:
----------------------

&H417 - to read the keyboard

Machine speed requirements:
---------------------------

Should run at full speed on any x86 processor.

When interpreted, rather than compiled, the program does all its work
within 15% of the vertical retrace cycle on a 486DX/66. The compiled
version should keep up with the vertical retrace on an 8086.

If you press the '=' key, the game will display how much of the vertical
retrace time the game takes up each cycle. Exciting, eh?

Unknown requirements:
---------------------

Base memory - tested with 479K free base memory
Memory manager - tested with himem.sys and emm386.exe


Notes

1. The program does not attempt to detect a soundcard; it assumes a
Soundblaster is installed. Apparently it works ok on machines without a
soundcard, but I can't guarantee it'll work on yours.

2. The player's bullet fire and explosion sound effects are pretty
dismal. But so were the original sound effects.

3. The demo mode is none. I might add one in future.

4. The program simulates a monitor 256 pixels wide, as per the original (I
think). The background colour for this is set to a dark grey to attempt to
simulate a little bit of monitor wear and burn-in. I found the jet black of a
modern PC monitor was not quite authentic enough :-) If you cannot see the
grey background, try increasing your brightness and contrast controls.

5. There's no high-score table, because the original game didn't have one.

6. You can't re-assign the keys and it doesn't work with a joystick, sorry.

7. Quake it ain't. It's just a nostalgia trip.


Source Notes

The file invader1.bas is the source code for the game. It's for QBASIC and it
compiles with QuickBasic 4.5. It runs, interpreted, within QBASIC easily at
full speed on a 486/66, probably on lower-powered machines, too.

The code is reasonably structured. I tend to suffix variables with "s"
to mean "status", so the variable 'saucers' means 'saucer status'.

The SUBs and FUNCTIONs that start with "sb", e.g. "sbreset" are general-
purpose SoundBlaster routines that can be plugged into any program
without modification.

What else? Well, not much - it's a very simple program. Hope you find
it useful, though, if you're into this sort of thing!


History

v1  - Feb 2002
---------------
Version 1.0 ;)