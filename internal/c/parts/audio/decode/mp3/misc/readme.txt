This is a derivative work of the MP3 library from the mpg123 player,
specifically the 0.59r version. The home page for the player is
http://mpg123.org/ This software is under the GPL license. The GPL.TXT
file included with this software explains the license. Michael Hipp the
author of the mpg123 player may still be doing licenses other than GPL.



SRC\MAUI\DEMOS\MPGMP3\LIB\           <= contains mpglib sources
SRC\MAUI\DEMOS\MPGMP3\DEFS\          <= contains mpglib defs <used with player applications as well >
SRC\MAUI\DEMOS\MPGMP3\PLAYER\	     <= contains sample MP3 player for use with MAUI
OS9000\<CPU>\CMDS\MAUIDEMO\mpgplay	 <= OS9 MP3 player
OS9000\<CPU>\LIB\mpglib.l            <= O-CODE library for MPGMP3
OS9000\<CPU>\LIB\HOST3\mpglib.il     <= I-CODE library for MPGMP3


	struct 		mpstr mp;
	/* Initialize the MP3 decoder */
	InitMP3(&mp);

	/* Initialize buffer */
	status = decodeMP3(&mp,bufin,inlen,bufout,OUT_BUF_SIZE,&outlen);

	/* Decode buffer */
	status = decodeMP3(&mp,NULL,0,bufout,OUT_BUF_SIZE,&outlen);

	/* Exit the MP3 decoder */
	ExitMP3(&mp);



Function information:

BOOL InitMP3(struct mpstr *mp);

int decodeMP3(struct mpstr *mp,char *inmemory,int inmemsize,
				  char *outmemory,int outmemsize,int *done);


void ExitMP3(struct mpstr *mp);



Status return information:
'decodeMP3' will return the following status information.

#define MP3_ERR -1      
#define MP3_OK  0
#define MP3_NEED_MORE 1




The "mpstr" structure contains the following. 

struct mpstr {
	struct buf *head,*tail;
	int bsize;
	int framesize;
	int fsizeold;
	struct frame fr;
	unsigned char bsspace[2][MAXFRAMESIZE+512]; /* MAXFRAMESIZE */
	real hybrid_block[2][2][SBLIMIT*SSLIMIT];
	int hybrid_blc[2];
	unsigned long header;
	int bsnum;
	real synth_buffs[2][2][0x110];
	int  synth_bo;
};


Once the MP3 header is read you may use this structure to find out details as desired.

			#if defined(SHOW_FRAME)
				printf("FRAME: stereo %d jsbound %d single %d lsf %d\n",
			    mp.fr.stereo,
			    mp.fr.jsbound,
			    mp.fr.single,
			    mp.fr.lsf);
				printf("mpeg25 %d header_change %d lay %d error_protection %d\n",
			    mp.fr.mpeg25,
			    mp.fr.header_change,
			    mp.fr.lay,
			    mp.fr.error_protection);
				printf("bitrate_index %d sampling_frequency %d padding %d extension %d\n",
			    mp.fr.bitrate_index,
			    mp.fr.sampling_frequency,
			    mp.fr.padding,
			    mp.fr.extension);
				printf("mode %d mode_ext %d copyright %d original %d\n",
			    mp.fr.mode,
			    mp.fr.mode_ext,
			    mp.fr.copyright,
			    mp.fr.original);
				printf("emphasis %d framesize %d\n",
			    mp.fr.emphasis,
			    mp.fr.framesize);
			
			#endif


        
For more information refer to the mpglib.h, mpg123.h and mpgplay.c sources.

MPGPLAY
This program is not designed to be a full featured MP3 player
rather this program is designed to show how to use the MPGMP3
library sources as well sound map managment to the MAUI sound
system. 

MPGPLAY uses the "mpglib.il" MPG library based on MPG123 sources.
Three functions are all that is required to decompress MP3
information either from a file or a stream.

InitMP3(&mp);
decodeMP3(&mp,bufin,inlen,bufout,OUT_BUF_SIZE,&outlen);
ExitMP3(&mp);

When decompressing MP3 images we create as many SMAP slots as 
required. We will start the sound maps playing and continue
decompressing the next block while the current blocks are
played.  This method provides very clean playback even on 
slower machines (133Mhz or greater should be fine). 

On X86 and ARM we will run with INTEGER based code by default.
This will allow playing of MP3's even on 486SX based processors.


