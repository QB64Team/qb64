#ifndef DEPENDENCY_NO_SOCKETS
 #define DEPENDENCY_SOCKETS
#endif

#ifndef DEPENDENCY_NO_PRINTER
 #define DEPENDENCY_PRINTER
#endif

#ifndef DEPENDENCY_NO_ICON
 #define DEPENDENCY_ICON
#endif

#ifndef DEPENDENCY_NO_SCREENIMAGE
 #define DEPENDENCY_SCREENIMAGE
#endif

#ifndef INC_COMMON_CPP
#define INC_COMMON_CPP
#include "os.h"

#ifdef QB64_ANDROID
 #define QB64_GLES
 #define QB64_GLES1
 #define QB64_NOT_X86
 #define QB64_GLUT
#else
 #define QB64_GL1
 #define QB64_GLUT
#endif

#ifdef QB64_LINUX
#ifndef QB64_MACOSX
#ifndef QB64_ANDROID
#define QB64_X11
#endif
#endif
#endif

#ifdef DEPENDENCY_CONSOLE_ONLY
 #undef QB64_GLUT
#else
 #define QB64_GUI
#endif

#define NO_S_D_L


/*
  #ifdef QB64_BACKSLASH_FILESYSTEM
  #include "parts\\core\\gl_headers\\glew\\glew.h"
  #else
  #include "parts/core/gl_headers/glew/glew.h"
  #endif
*/


//core
#ifdef QB64_GUI
#ifdef QB64_GLUT
#ifdef QB64_BACKSLASH_FILESYSTEM
#include "parts\\core\\src.c"
#else
#include "parts/core/src.c"
#endif
#endif
#endif

#ifdef QB64_WINDOWS

#ifndef QB64_GUI
 #undef int64 //definition of int64 from os.h conflicts with a definition within windows.h, temporarily undefine then redefine
 #include <windows.h>
 #define int64 __int64
#endif

#include <float.h>
#include <winbase.h>

#endif

//common includes
#include <stdio.h>
#ifdef QB64_MACOSX
  #include <cmath>
#else
  //#include <math.h> //<-causes overloading abs conflicts in Windows
  #include <cmath>
#endif
#include <time.h>
#include <iostream>
#include <fstream>
#include <time.h>
#include <string.h>
#include <errno.h>


//OS/compiler specific includes
#ifdef QB64_WINDOWS
#include <direct.h>
#ifdef DEPENDENCY_PRINTER
 #include <winspool.h>
#endif
#include <csignal>
#include <process.h> //required for multi-threading
#if defined DEPENDENCY_AUDIO_OUT || defined QB64_GUI
 #include <mmsystem.h>
#endif

#else

#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <unistd.h>
#include <stdint.h>
#include <pthread.h>
#ifndef QB64_MACOSX
 #include <dlfcn.h>
#endif

#endif

#ifdef QB64_GUI
#ifdef QB64_GLUT
#ifndef QB64_ANDROID
#ifdef QB64_BACKSLASH_FILESYSTEM
#include "parts\\core\\gl_headers\\opengl_org_registery\\glext.h"
#else
#include "parts/core/gl_headers/opengl_org_registery/glext.h"
#endif
#endif
#endif
#endif

using namespace std;

//QB64 string descriptor structure
struct qbs_field{
  int32 fileno;
  int64 fileid;
  int64 size;
  int64 offset;
};

struct qbs{
  uint8 *chr;//a 32 bit pointer to the string's data
  int32 len;//must be signed for comparisons against signed int32s
  uint8 in_cmem;//set to 1 if in the conventional memory DBLOCK
  uint16 *cmem_descriptor;
  uint16 cmem_descriptor_offset;
  uint32 listi;//the index in the list of strings that references it
  uint8 tmp;//set to 1 if the string can be deleted immediately after being processed
  uint32 tmplisti;//the index in the list of strings that references it
  uint8 fixed;//fixed length string
  uint8 readonly;//set to 1 if string is read only
  qbs_field *field;
};

//substitute functionality

#ifdef QB64_WINDOWS
inline void SDL_Delay(uint32 milliseconds){//redefine SDL_Delay to call Sleep
  Sleep(milliseconds);
}
#else
inline void SDL_Delay(uint32 milliseconds){//redefine SDL_Delay to call Sleep
  static uint64 sec,nsec;
  sec=milliseconds/1000;
  nsec=(milliseconds%1000)*1000000;
  static timespec ts;
  ts.tv_sec = sec;
  ts.tv_nsec = nsec;
  nanosleep (&ts, NULL);
}
inline void Sleep(uint32 milliseconds){
  SDL_Delay(milliseconds);
}
inline uint32 _lrotl(uint32 word,uint32 shift){
  return (word << shift) | (word >> (32 - shift));
}
inline void ZeroMemory(void *ptr,int64 bytes){
  memset(ptr,0,bytes);
}
#endif

struct img_struct{
  void *lock_offset;
  int64 lock_id;
  uint8 valid;//0,1 0=invalid
  uint8 text;//if set, surface is a text surface
  uint8 console;//dummy surface to absorb unimplemented console functionality
  uint16 width,height;
  uint8 bytes_per_pixel;//1,2,4
  uint8 bits_per_pixel;//1,2,4,8,16(text),32
  uint32 mask;//1,3,0xF,0xFF,0xFFFF,0xFFFFFFFF
  uint16 compatible_mode;//0,1,2,7,8,9,10,11,12,13,32,256
  uint32 color,background_color,draw_color;
  uint32 font;//8,14,16,?
  int16 top_row,bottom_row;//VIEW PRINT settings, unique (as in QB) to each "page"
  int16 cursor_x,cursor_y;//unique (as in QB) to each "page"
  uint8 cursor_show, cursor_firstvalue, cursor_lastvalue;
  union{
    uint8 *offset;
    uint32 *offset32;
  };
  uint32 flags;
  uint32 *pal;
  int32 transparent_color;//-1 means no color is transparent
  uint8 alpha_disabled;
  uint8 holding_cursor;
  uint8 print_mode;
  //BEGIN apm ('active page migration')
  //everything between apm points is migrated during active page changes
  //note: apm data is only relevent to graphics modes
  uint8 apm_p1;
  int32 view_x1,view_y1,view_x2,view_y2;
  int32 view_offset_x,view_offset_y;
  float x,y;
  uint8 clipping_or_scaling;
  float scaling_x,scaling_y,scaling_offset_x,scaling_offset_y;
  float window_x1,window_y1,window_x2,window_y2;
  double draw_ta;
  double draw_scale;
  uint8 apm_p2;
  //END apm
};
//img_struct flags
#define IMG_FREEPAL 1 //free palette data before freeing image
#define IMG_SCREEN 2 //img is linked to other screen pages
#define IMG_FREEMEM 4 //if set, it means memory must be freed

extern void error(int32 error_number); //declare the erorr handler so we can call it if needed.

#ifdef QB64_NOT_X86
inline int64 qbr(long double f){
  int64 i; int temp=0;
  if (f<=-9223372036854775808.5) {error(6); return 0;} // if the float is smaller than what an integer 64 could possible hold, toss an overflow error.
  if (f>=18446744073709551615.5) {error(6); return 0;} // same result if the number is larger than what an integer 64 could possibly hold.
  if (f>9223372036854775807) {temp=1;f=f-9223372036854775808u;} //if it's too large for a signed int64, make it an unsigned int64 and return that value if possible.
  if (f<0) i=f-0.5f; else i=f+0.5f;
  if (temp) return i|0x8000000000000000;//+9223372036854775808;
  return i;
}
inline uint64 qbr_longdouble_to_uint64(long double f){if (f<0) return(f-0.5f); else return(f+0.5f);}
inline int32 qbr_float_to_long(float f){if (f<0) return(f-0.5f); else return(f+0.5f);}
inline int32 qbr_double_to_long(double f){if (f<0) return(f-0.5f); else return(f+0.5f);}
#else
//QBASIC compatible rounding via FPU:
#ifdef QB64_MICROSOFT
inline int64 qbr(long double f){
  int64 i; int temp=0;
  if (f<=-9223372036854775808.5) {error(6); return 0;} // if the float is smaller than what an integer 64 could possible hold, toss an overflow error.
  if (f>=18446744073709551615.5) {error(6); return 0;} // same result if the number is larger than what an integer 64 could possibly hold.
  if (f>9223372036854775807) {temp=1;f=f-9223372036854775808u;} //if it's too large for a signed int64, make it an unsigned int64 and return that value if possible.
  __asm{
      fld   f
      fistp i
      }
  if (temp) return i|0x8000000000000000;//+9223372036854775808;
  return i;
}
inline uint64 qbr_longdouble_to_uint64(long double f){
  uint64 i;
  __asm{
    fld   f
      fistp i
      }
  return i;
}
inline int32 qbr_float_to_long(float f){
  int32 i;
  __asm{
    fld   f
      fistp i
      }
  return i;
}
inline int32 qbr_double_to_long(double f){
  int32 i;
  __asm{
    fld   f
      fistp i
      }
  return i;
}
#else
//FLDS=load single
//FLDL=load double
//FLDT=load long double
inline int64 qbr(long double f){
  int64 i; int temp=0;
  if (f<=-9223372036854775808.5) {error(6); return 0;} // if the float is smaller than what an integer 64 could possible hold, toss an overflow error.
  if (f>=18446744073709551615.5) {error(6); return 0;} // same result if the number is larger than what an integer 64 could possibly hold.
  if (f>9223372036854775807) {temp=1;f=f-9223372036854775808u;} //if it's too large for a signed int64, make it an unsigned int64 and return that value if possible.
  __asm__ (
           "fldt %1;"
           "fistpll %0;"              
           :"=m" (i)
           :"m" (f)
           );
  if (temp) return i|0x8000000000000000;// if it's an unsigned int64, manually set the bit flag
  return i;
}
inline uint64 qbr_longdouble_to_uint64(long double f){
  uint64 i;
  __asm__ (
           "fldt %1;"
           "fistpll %0;"              
           :"=m" (i)
           :"m" (f)
           );
  return i;
}
inline int32 qbr_float_to_long(float f){
  int32 i;
  __asm__ (
           "flds %1;"
           "fistpl %0;"              
           :"=m" (i)
           :"m" (f)
           );
  return i;
}
inline int32 qbr_double_to_long(double f){
  int32 i;
  __asm__ (
           "fldl %1;"
           "fistpl %0;"              
           :"=m" (i)
           :"m" (f)
           );
  return i;
}
#endif
#endif //x86 support

//bit-array access functions (note: used to be included through 'bit.cpp')
static int64 bmask;
static uint64 *bptr64;
static int64 bval64;
inline uint64 getubits(uint32 bsize,uint8 *base,ptrszint i){
  bmask=~(-(((int64)1)<<bsize));
  i*=bsize;
  return ((*(uint64*)(base+(i>>3)))>>(i&7))&bmask;
}
inline int64 getbits(uint32 bsize,uint8 *base,ptrszint i){
  bmask=~(-(((int64)1)<<bsize));
  i*=bsize;
  bval64=((*(uint64*)(base+(i>>3)))>>(i&7))&bmask;
  if (bval64&(((int64)1)<<(bsize-1))) return bval64|(~bmask);
  return bval64;
}
inline void setbits(uint32 bsize,uint8 *base,ptrszint i,int64 val){
  bmask=(((uint64)1)<<bsize)-1;
  i*=bsize;
  bptr64=(uint64*)(base+(i>>3));
  *bptr64=(*bptr64&( ( (bmask<<(i&7)) ^-1)  )) | ((val&bmask)<<(i&7));
}

//QB64 internal variable type flags (internally referenced by some C functions)
#define ISSTRING 1073741824
#define ISFLOAT 536870912
#define ISUNSIGNED 268435456
#define ISPOINTER 134217728
#define ISFIXEDLENGTH 67108864 //only set for strings with pointer flag
#define ISINCONVENTIONALMEMORY 33554432
#define ISOFFSETINBITS 16777216

struct ontimer_struct{
  uint8 allocated;
  uint32 id;//the event ID to trigger (0=no event)
  int64 pass;//the value to pass to the triggered event (only applicable to ON ... CALL ...(x)
  uint8 active;//0=OFF, 1=ON, 2=STOP
  uint8 state;//0=untriggered,1=triggered
  double seconds;//how many seconds between events
  double last_time;//the last time this event was triggered
};

struct onkey_struct{
  uint32 id;//the event ID to trigger (0=no event)
  int64 pass;//the value to pass to the triggered event (only applicable to ON ... CALL ...(x)
  uint8 active;//0=OFF, 1=ON, 2=STOP
  uint8 state;//0=untriggered,1=triggered,2=in progress(TIMER only),2+=multiple events queued(KEY only)
  uint32 keycode;//32-bit code, same as what _KEYHIT returns
  uint32 keycode_alternate;//an alternate keycode which may also trigger event
  uint8 key_scancode;
  uint8 key_flags;
  //flags:
  //0 No keyboard flag, 1-3 Either Shift key, 4 Ctrl key, 8 Alt key,32 NumLock key,64 Caps Lock key, 128 Extended keys on a 101-key keyboard
  //To specify multiple shift states, add the values together. For example, a value of 12 specifies that the user-defined key is used in combination with the Ctrl and Alt keys.
  qbs *text;
};

struct onstrig_struct{
  uint32 id;//the event ID to trigger (0=no event)
  int64 pass;//the value to pass to the triggered event (only applicable to ON ... CALL ...(x)
  uint8 active;//0=OFF, 1=ON, 2=STOP
  uint8 state;//0=untriggered,1=triggered,2=in progress(TIMER only),2+=multiple events queued(KEY only)
};

struct byte_element_struct
{
  uint64 offset;
  int32 length;
};

struct device_struct{
  int32 used;
  int32 type;
  //0=Unallocated
  //1=Joystick/Gamepad
  //2=Keybaord
  //3=Mouse  
  char *name;
  int32 connected;
  int32 lastbutton;
  int32 lastaxis;
  int32 lastwheel;
  //--------------
  int32 max_events;
  int32 queued_events;
  uint8 *events;//the structure and size of the events depends greatly on the device and its capabilities
  int32 event_size;
  //--------------
  uint8 STRIG_button_pressed[256];//checked and cleared by the STRIG function
  //--------------
  void *handle_pointer;//handle as pointer
  int64 handle_int;//handle as integer
  char *description;//description provided by manufacturer
  int64 product_id;
  int64 vendor_id;
  int32 buttons;
  int32 axes;
  int32 balls;
  int32 hats;
};
#define QUEUED_EVENTS_LIMIT 1024

struct mem_block{
  ptrszint offset;
  ptrszint size;
  int64 lock_id;//64-bit key, must be present at lock's offset or memory region is invalid
  ptrszint lock_offset;//pointer to lock
  int32 type;
  /*
    memorytype (4 bytes, but only the first used, for flags):
    1 integer values
    2 unsigned (set in conjunction with integer)
    4 floating point values
    8 char string(s) 'element-size is the memory size of 1 string
  */
  ptrszint elementsize;
  int32 image;
};
struct mem_lock{
  uint64 id;
  int32 type;//required to know what action to take (if any) when a request is made to free the block
  //0=no security (eg. user defined block from _OFFSET)
  //1=C-malloc'ed block
  //2=image
  //3=sub/function scope block
  //4=array
  //---- type specific variables follow ----
  void *offset;//used by malloc'ed blocks to free them
};

#endif //INC_COMMON_CPP
