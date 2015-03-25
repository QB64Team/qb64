#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include "libqb.h"
#include "luke_mods.h"

void sub__keyclear(int32 buf, int32 passed) {
  if (new_error) return;
  if (passed && (buf > 3 || buf < 1)) error(5);
  //  Sleep(10);
  if ((buf == 1 && passed) || !passed) {
    //INKEY$ buffer
    cmem[0x41a]=30; cmem[0x41b]=0; //head
    cmem[0x41c]=30; cmem[0x41d]=0; //tail
  }
  if ((buf == 2 && passed) || !passed) {
    //_KEYHIT buffer
    keyhit_nextfree = 0;
    keyhit_next = 0;
  }
  if ((buf == 3 && passed) || !passed) {
    //INP(&H60) buffer
    port60h_events = 0;
  }
}
