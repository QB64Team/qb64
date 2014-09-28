#include <ctype.h>
#include <stdlib.h>
#include <signal.h>

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#include "mpg123.h"


const int tabsel_123[2][3][16] = {
   { {0,32,64,96,128,160,192,224,256,288,320,352,384,416,448,},
     {0,32,48,56, 64, 80, 96,112,128,160,192,224,256,320,384,},
     {0,32,40,48, 56, 64, 80, 96,112,128,160,192,224,256,320,} },

   { {0,32,48,56,64,80,96,112,128,144,160,176,192,224,256,},
     {0,8,16,24,32,40,48,56,64,80,96,112,128,144,160,},
     {0,8,16,24,32,40,48,56,64,80,96,112,128,144,160,} }
};

const long freqs[9] = { 44100, 48000, 32000,
                  22050, 24000, 16000 ,
                  11025 , 12000 , 8000 };


#define HDRCMPMASK 0xfffffd00

int head_check(unsigned long head)
{
    if( (head & 0xffe00000) != 0xffe00000)
	return FALSE;
    if(!((head>>17)&3))
	return FALSE;
    if( ((head>>12)&0xf) == 0xf)
	return FALSE;
    if( ((head>>10)&0x3) == 0x3 )
	return FALSE;
    if ((head & 0xffff0000) == 0xfffe0000)
      return FALSE;

    return TRUE;
}

/*
 * the code a header and write the information
 * into the frame structure
 */
int decode_header(struct mpstr *mp, struct frame *fr,unsigned long newhead)
{
	long ltmp;

    if( newhead & (1<<20) ) {
      fr->lsf = (newhead & (1<<19)) ? 0x0 : 0x1;
      fr->mpeg25 = 0;
    }
    else {
      fr->lsf = 1;
      fr->mpeg25 = 1;
    }


    fr->lay = 4-((newhead>>17)&3);
    if( ((newhead>>10)&0x3) == 0x3) {
#ifndef BE_QUIET
      fprintf(stderr,"Stream error\n");
      exit(1);
#else
      return (0);
#endif
    }
    if(fr->mpeg25) {
      fr->sampling_frequency = 6 + ((newhead>>10)&0x3);
    }
    else
      fr->sampling_frequency = ((newhead>>10)&0x3) + (fr->lsf*3);
    fr->error_protection = ((newhead>>16)&0x1)^0x1;

    if(fr->mpeg25) /* allow Bitrate change for 2.5 ... */
      fr->bitrate_index = ((newhead>>12)&0xf);

    fr->bitrate_index = ((newhead>>12)&0xf);
    fr->padding   = ((newhead>>9)&0x1);
    fr->extension = ((newhead>>8)&0x1);
    fr->mode      = ((newhead>>6)&0x3);
    fr->mode_ext  = ((newhead>>4)&0x3);
    fr->copyright = ((newhead>>3)&0x1);
    fr->original  = ((newhead>>2)&0x1);
    fr->emphasis  = newhead & 0x3;

    fr->stereo    = (fr->mode == MPG_MD_MONO) ? 1 : 2;

    if(!fr->bitrate_index)
    {
#ifndef BE_QUIET
      fprintf(stderr,"Free format not supported.\n");
#endif
      return (0);
    }

    switch(fr->lay)
    {
      case 1:
#if 0
		fr->do_layer = do_layer1;
        fr->jsbound = (fr->mode == MPG_MD_JOINT_STEREO) ?
                         (fr->mode_ext<<2)+4 : 32;
        fr->framesize  = (long) tabsel_123[fr->lsf][0][fr->bitrate_index] * 12000;
        fr->framesize /= freqs[fr->sampling_frequency];
        fr->framesize  = ((fr->framesize+fr->padding)<<2)-4;
#else
#ifndef BE_QUIET
        fprintf(stderr,"layer=1 Not supported!\n");
#endif
#endif
        break;
      case 2:
#if 1
		fr->do_layer = do_layer2;
// in layer2.c
//        II_select_table(fr);
//        fr->jsbound = (fr->mode == MPG_MD_JOINT_STEREO) ?
//                         (fr->mode_ext<<2)+4 : fr->II_sblimit;
        fr->framesize = (long) tabsel_123[fr->lsf][1][fr->bitrate_index] * 144000;
        fr->framesize /= freqs[fr->sampling_frequency];
        fr->framesize += fr->padding - 4;
#endif
        break;
      case 3:
        fr->do_layer = do_layer3;
#if 0
        if(fr->lsf)
          ssize = (fr->stereo == 1) ? 9 : 17;
        else
          ssize = (fr->stereo == 1) ? 17 : 32;
#endif

#if 0
        if(fr->error_protection)
          ssize += 2;
#endif

/*        ------- BEGIN OF MODIFICATIONS FOR mpglib.dll
          Because LCC-Win32 made the Program crash at this
          point, the following modification was necessary.
          fr->framesize  = (long) tabsel_123[fr->lsf][2][fr->bitrate_index] * 144000;
          fr->framesize /= freqs[fr->sampling_frequency]<<(fr->lsf);
          fr->framesize = fr->framesize + fr->padding - 4;
*/        
          ltmp  = (long) tabsel_123[fr->lsf][2][fr->bitrate_index] * 144000;
          ltmp /= freqs[fr->sampling_frequency]<<(fr->lsf);
          ltmp  = ltmp + fr->padding - 4;
          fr->framesize=ltmp;
/*        ------- END OF MODIFICATIONS FOR mpglib.dll
*/

        break;
      default:
#ifndef BE_QUIET
        fprintf(stderr,"Sorry, unknown layer type.\n");
#endif
        return (0);
    }

    /*    print_header(fr); */

    return 1;
}


unsigned int getbits(struct StaticData * psd, int number_of_bits)
{
  unsigned long rval;
  
  if(!number_of_bits)
    return 0;

  {
    rval = psd->wordpointer[0];
    rval <<= 8;
    rval |= psd->wordpointer[1];
    rval <<= 8;
    rval |= psd->wordpointer[2];
    rval <<= psd->bitindex;
    rval &= 0xffffff;

    psd->bitindex += number_of_bits;

    rval >>= (24-number_of_bits);

    psd->wordpointer += (psd->bitindex>>3);
    psd->bitindex &= 7;
  }
  return rval;
}

unsigned int getbits_fast(struct StaticData * psd, int number_of_bits)
{
  unsigned long rval;

  {
    rval = psd->wordpointer[0];
    rval <<= 8;
    rval |= psd->wordpointer[1];
    rval <<= psd->bitindex;
    rval &= 0xffff;
    psd->bitindex += number_of_bits;

    rval >>= (16-number_of_bits);

    psd->wordpointer += (psd->bitindex>>3);
    psd->bitindex &= 7;
  }
  return rval;
}


/********************************/

double compute_bpf(struct frame *fr)
{
	double bpf;

        switch(fr->lay) {
                case 1:
                        bpf = tabsel_123[fr->lsf][0][fr->bitrate_index];
                        bpf *= 12000.0 * 4.0;
                        bpf /= freqs[fr->sampling_frequency] <<(fr->lsf);
                        break;
                case 2:
                case 3:
                        bpf = tabsel_123[fr->lsf][fr->lay-1][fr->bitrate_index];                        bpf *= 144000;
                        bpf /= freqs[fr->sampling_frequency] << (fr->lsf);
                        break;
                default:
                        bpf = 1.0;
        }

	return bpf;
}

double compute_tpf(struct frame *fr)
{
	static int bs[4] = { 0,384,1152,1152 };
	double tpf;

	tpf = (double) bs[fr->lay];
	tpf /= freqs[fr->sampling_frequency] << (fr->lsf);
	return tpf;
}

int ExtractI4(unsigned char *buf)
{
	int x;
	x = buf[0];
	x <<= 8;
	x |= buf[1];
	x <<= 8;
	x |= buf[2];
	x <<= 8;
	x |= buf[3];
	return x;
}

int GetVbrTag(VBRTAGDATA *pTagData,  unsigned char *buf)
{
	int			i, head_flags;
	int			h_id, h_mode, h_sr_index;
	static int	sr_table[4] = { 44100, 48000, 32000, 99999 };

	pTagData->flags = 0;     

	h_id       = (buf[1] >> 3) & 1;
	h_sr_index = (buf[2] >> 2) & 3;
	h_mode     = (buf[3] >> 6) & 3;

	if( h_id ) 
	{
		if( h_mode != 3 )	buf+=(32+4);
		else				buf+=(17+4);
	}
	else
	{
		if( h_mode != 3 ) buf+=(17+4);
		else              buf+=(9+4);
	}
	
	if( buf[0] != VBRTag[0] ) return 0;
	if( buf[1] != VBRTag[1] ) return 0;
	if( buf[2] != VBRTag[2] ) return 0;
	if( buf[3] != VBRTag[3] ) return 0;

	buf+=4;

	pTagData->h_id = h_id;

	pTagData->samprate = sr_table[h_sr_index];

	if( h_id == 0 )
		pTagData->samprate >>= 1;

	head_flags = pTagData->flags = ExtractI4(buf); buf+=4;

	if( head_flags & FRAMES_FLAG )
	{
		pTagData->frames   = ExtractI4(buf); buf+=4;
	}

	if( head_flags & BYTES_FLAG )
	{
		pTagData->bytes = ExtractI4(buf); buf+=4;
	}

	if( head_flags & TOC_FLAG )
	{
		if( pTagData->toc != NULL )
		{
			for(i=0;i<NUMTOCENTRIES;i++)
				pTagData->toc[i] = buf[i];
		}
		buf+=NUMTOCENTRIES;
	}

	pTagData->vbr_scale = -1;

	if( head_flags & VBR_SCALE_FLAG )
	{
		pTagData->vbr_scale = ExtractI4(buf); buf+=4;
	}

	return 1;
}

int SeekPoint(unsigned char TOC[NUMTOCENTRIES], int file_bytes, double percent)
{
	/* interpolate in TOC to get file seek point in bytes */
	int a, seekpoint;
	double fa, fb, fx;

	if( percent < (double)0.0 )   percent = (double)0.0;
	if( percent > (double)100.0 ) percent = (double)100.0;

	a = (int)percent;
	if( a > 99 ) a = 99;
	fa = TOC[a];
	if( a < 99 ) {
		fb = TOC[a+1];
	} else {
		fb = (double)256.0;
	}

	fx = fa + (fb-fa)*(percent-a);

	seekpoint = (int)(((double)(1.0/256.0))*fx*file_bytes); 

	return seekpoint;
}

