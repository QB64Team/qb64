/*
 * External functions declared as __declspec(dllexport)
 * to work in a Win32 DLL (use mpglibdll.h to access)
 */

#include <stdlib.h>
#include <stdio.h>

#include "mpg123.h"
#include "mpglib.h"

void initStaticData(struct StaticData * psd)
{
	psd->pnts[0] = psd->cos64;
	psd->pnts[1] = psd->cos32;
	psd->pnts[2] = psd->cos16;
	psd->pnts[3] = psd->cos8;
	psd->pnts[4] = psd->cos4;

	psd->bo = 1;
}


int InitMP3(struct mpstr *mp)
{
	memset(mp,0,sizeof(struct mpstr));

	initStaticData(&mp->psd);

	mp->framesize = 0;
	mp->fsizeold = -1;
	mp->bsize = 0;
	mp->head = mp->tail = NULL;
	mp->fr.single = -1;
	mp->bsnum = 0;
	mp->synth_bo = 1;

	make_decode_tables(&mp->psd, 32767);
	init_layer3(&mp->psd, SBLIMIT);

	mp->fr.II_sblimit=SBLIMIT;
	init_layer2(&mp->psd);

	return !0;
}

void ExitMP3(struct mpstr *mp)
{
	struct buf *b,*bn;

	b = mp->tail;
	while(b) {
		free(b->pnt);
		bn = b->next;
		free(b);
		b = bn;
	}
}

static struct buf *addbuf(struct mpstr *mp,char *buf,int size)
{
	struct buf *nbuf;

	nbuf = (struct buf*) malloc( sizeof(struct buf) );
	if(!nbuf) {
#ifndef BE_QUIET
		fprintf(stderr,"Out of memory!\n");
#endif
		return NULL;
	}
	nbuf->pnt = (unsigned char*) malloc(size);
	if(!nbuf->pnt) {
		free(nbuf);
		return NULL;
	}
	nbuf->size = size;
	memcpy(nbuf->pnt,buf,size);
	nbuf->next = NULL;
	nbuf->prev = mp->head;
	nbuf->pos = 0;

	if(!mp->tail) {
		mp->tail = nbuf;
	}
	else {
	  mp->head->next = nbuf;
	}

	mp->head = nbuf;
	mp->bsize += size;

	return nbuf;
}

static void remove_buf(struct mpstr *mp)
{
  struct buf *buf = mp->tail;

  mp->tail = buf->next;
  if(mp->tail)
    mp->tail->prev = NULL;
  else {
    mp->tail = mp->head = NULL;
  }

  free(buf->pnt);
  free(buf);

}

static int read_buf_byte(struct mpstr *mp)
{
	unsigned int b;

	int pos;

	pos = mp->tail->pos;
	while(pos >= mp->tail->size) {
		remove_buf(mp);
		if(!mp->tail) {
#ifndef BE_QUIET
			fprintf(stderr,"Fatal error!\n");
#endif
			return 0;
		}
		pos = mp->tail->pos;
	}

	b = mp->tail->pnt[pos];
	mp->bsize--;
	mp->tail->pos++;


	return b;
}

static void read_head(struct mpstr *mp)
{
	unsigned long head = 0;
	int i;

	while(mp->tail){
		head <<= 8;
		head |= read_buf_byte(mp);
		head &= 0xffffffff;
		if(head_check(head))
			break;
	}

	mp->header = head;
}

int decodeMP3(struct mpstr *mp, char *in, int isize,
		char *out, int osize, int *done)
{
	int len;

	if(osize < 4608) {
#ifndef BE_QUIET
		fprintf(stderr,"To less out space\n");
#endif
		return MP3_ERR;
	}

	if(in) {
		if(addbuf(mp, in, isize) == NULL) {
			return MP3_ERR;
		}
	}


	/* First decode header */
	if(mp->framesize == 0) {
		if(mp->bsize < 4) {
			return MP3_NEED_MORE;
		}
		read_head(mp);
		if(mp->tail)
			mp->ndatabegin = mp->tail->pos - 4;
		if (decode_header(mp, &mp->fr,mp->header) <= 0 )
            return MP3_ERR;

		mp->framesize = mp->fr.framesize;
	}

	/*	  printf(" fr.framesize = %i \n",mp->fr.framesize);
		  printf(" bsize        = %i \n",mp->bsize);
	*/

	if(mp->fr.framesize > mp->bsize) {
	  return MP3_NEED_MORE;
	}
	mp->psd.wordpointer = mp->bsspace[mp->bsnum] + 512;
	mp->bsnum = (mp->bsnum + 1) & 0x1;
	mp->psd.bitindex = 0;

	len = 0;
	while(len < mp->framesize) {
		int nlen;
		int blen = mp->tail->size - mp->tail->pos;
		if( (mp->framesize - len) <= blen) {
                  nlen = mp->framesize-len;
		}
		else {
                  nlen = blen;
                }
		memcpy(mp->psd.wordpointer+len,mp->tail->pnt+mp->tail->pos,nlen);
                len += nlen;
                mp->tail->pos += nlen;
		mp->bsize -= nlen;
                if(mp->tail->pos == mp->tail->size) {
                   remove_buf(mp);
                }
	}

	*done = 0;
	if(mp->fr.error_protection)
           getbits(&mp->psd, 16);

	// FOR mpglib.dll: see if error and return it
	if ((&mp->fr)->do_layer(&mp->psd, mp, &mp->fr, (unsigned char*) out, done) < 0)
      return MP3_ERR;

	mp->fsizeold = mp->framesize;
	mp->framesize = 0;
	return MP3_OK;
}

int set_pointer(struct StaticData * psd, struct mpstr * gmp, long backstep)
{
  unsigned char *bsbufold;

  if(gmp->fsizeold < 0 && backstep > 0) {
#ifndef BE_QUIET
    fprintf(stderr,"Can't step back %ld!\n",backstep);
#endif
    return MP3_ERR;
  }
  bsbufold = gmp->bsspace[gmp->bsnum] + 512;
  psd->wordpointer -= backstep;
  if (backstep)
    memcpy(psd->wordpointer,bsbufold+gmp->fsizeold-backstep,backstep);
  psd->bitindex = 0;
  return MP3_OK;
}


void MessageI(int i)
{
	char s[100];
	sprintf(s, "%d", i);
//	MessageBox (NULL, s, "Debug/Integer", 0);
}
