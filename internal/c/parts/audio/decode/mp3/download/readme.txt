  mpglibdll cross-platform with source (LGPL)
  Version 0.10, Dec 2004

 WHAT'S THIS
  The new mpglib.dll is base on mpglib.dll (Win32) with adapted from mpglib by 
  Martin Pesch (http://www.rz.uni-frankfurt.de/~pesch)
  The VBR compatibility has improved. It can work with 
  cross-platform compiler GCC(mingw32), So it can compile on Linux, FreeBSD, etc..
  Full Object Oriented and Thread Safe library, no global variable with Thread Safe problem.
  Include MP3decoder.h and .cpp is a wapper class, and it have some useful function
  like getpos and setpos, they are vbr supported.

  I want the mpg123 engine can have a better future compare to libmad, Because mpg123's
  decoding quality is good.

 PLEASE NOTE

  The mpglib is originally provided by Michael Hipp under
  the GNU Lesser General Public Licence (LGPL). So even this
  modified version is provided under the LGPL (see lgpl.txt).
  You find the mpg123 project at http://www.mpg123.de. I used the
  mpglib with optimized Huffman tables from the Lame project
  wich is reachable under http://www.sulaco.org/mp3.