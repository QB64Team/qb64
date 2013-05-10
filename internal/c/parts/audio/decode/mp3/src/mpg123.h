#include        <stdio.h>
#include        <string.h>
#include        <signal.h>

#ifndef WIN32
#include        <sys/signal.h>
#include        <unistd.h>
#endif

#include        <math.h>

//#ifdef _WIN32
# undef WIN32
# define WIN32

# define M_PI       3.14159265358979323846
# define M_SQRT2	1.41421356237309504880
# define REAL_IS_FLOAT
# define NEW_DCT9

# define random rand
# define srandom srand

//#endif

#ifdef REAL_IS_FLOAT
#  define real float
#elif defined(REAL_IS_LONG_DOUBLE)
#  define real long double
#else
#  define real double
#endif

#ifdef __GNUC__
#define INLINE inline
#else
#define INLINE
#endif

/* AUDIOBUFSIZE = n*64 with n=1,2,3 ...  */
#define		AUDIOBUFSIZE		16384

#define         FALSE                   0
#define         TRUE                    1

#define         SBLIMIT                 32
#define         SSLIMIT                 18

#define         SCALE_BLOCK             12 /* Layer 2 */

#define         MPG_MD_STEREO           0
#define         MPG_MD_JOINT_STEREO     1
#define         MPG_MD_DUAL_CHANNEL     2
#define         MPG_MD_MONO             3

#define MAXFRAMESIZE 1792


/* Pre Shift fo 16 to 8 bit converter table */
#define AUSHIFT (3)

#ifdef __cplusplus
extern "C" {
#endif

struct StaticData {
	
	//layer3
	real ispow[8207];
	real aa_ca[8],aa_cs[8];
	real COS1[12][6];
	real win[4][36];
	real win1[4][36];
	real gainpow2[256+118+4];
	real COS9[9];
	real COS6_1,COS6_2;
	real tfcos36[9];
	real tfcos12[3];
	
	int mapbuf0[9][152];
	int mapbuf1[9][156];
	int mapbuf2[9][44];
	int *map[9][3];
	int *mapend[9][3];
	
	unsigned int n_slen2[512]; 
	unsigned int i_slen2[256]; 
	
	real tan1_1[16],tan2_1[16],tan1_2[16],tan2_2[16];
	real pow1_1[2][16],pow2_1[2][16],pow1_2[2][16],pow2_2[2][16];
	
	int longLimit[9][23];
	int shortLimit[9][14];

	real hybridIn[2][SBLIMIT][SSLIMIT];
    real hybridOut[2][SSLIMIT][SBLIMIT];

	//common
	int bitindex;
	unsigned char *wordpointer;

	//decode_i386
	real buffs[2][2][0x110];
    int bo;

	//layer2
	int grp_3tab[32 * 3];   /* used: 27 */
	int grp_5tab[128 * 3];  /* used: 125 */
	int grp_9tab[1024 * 3]; /* used: 729 */
	
	real muls[27][64];	/* also used by layer 1 */
	unsigned int scfsi_buf[64];

	//tabinit
	real decwin[512+32];
	real cos64[16],cos32[8],cos16[4],cos8[2],cos4[1];
	real *pnts[5];
};

/*
 * the ith entry determines the seek point for
 * i-percent duration
 * seek point in bytes = (toc[i]/256.0) * total_bitstream_bytes
 * e.g. half duration seek point = (toc[50]/256.0) * total_bitstream_bytes
 */


#define FRAMES_FLAG     0x0001
#define BYTES_FLAG      0x0002
#define TOC_FLAG        0x0004
#define VBR_SCALE_FLAG  0x0008

#define NUMTOCENTRIES 100

#define FRAMES_AND_BYTES (FRAMES_FLAG | BYTES_FLAG)

const static char	VBRTag[]={"Xing"};

/*structure to receive extracted header */
/* toc may be NULL*/
typedef struct
{
  int		h_id;			/* from MPEG header, 0=MPEG2, 1=MPEG1 */
  int		samprate;		/* determined from MPEG header */
  int		flags;			/* from Vbr header data */
  int		frames;			/* total bit stream frames from Vbr header data */
  int		bytes;			/* total bit stream bytes from Vbr header data*/
  int		vbr_scale;		/* encoded vbr scale from Vbr header data*/
  unsigned char	toc[NUMTOCENTRIES];	/* may be NULL if toc not desired*/
}   VBRTAGDATA;
/*
//    4 bytes for Header Tag
//    4 bytes for Header Flags
//  100 bytes for entry (NUMTOCENTRIES)
//    4 bytes for FRAME SIZE
//    4 bytes for STREAM_SIZE
//    4 bytes for VBR SCALE. a VBR quality indicator: 0=best 100=worst
//   20 bytes for LAME tag.  for example, "LAME3.12 (beta 6)"
// ___________
//  140 bytes
*/

#define VBRHEADERSIZE (NUMTOCENTRIES+4+4+4+4+4)

int GetVbrTag(VBRTAGDATA *pTagData,  unsigned char *buf);

struct frame {
    int stereo;
    int jsbound;
    int single;
    int lsf;
    int mpeg25;
    int header_change;
    int lay;
    int error_protection;
    int bitrate_index;
    int sampling_frequency;
    int padding;
    int extension;
    int mode;
    int mode_ext;
    int copyright;
    int original;
    int emphasis;
    int framesize;  /* computed framesize */
    int II_sblimit; /* Layer 2 */
    const struct al_table *alloc; /* Layer 2 */
    int (*do_layer)(struct StaticData * psd, struct mpstr * gmp, struct frame *fr, unsigned char *pcm_sample, int *pcm_point);/* Layer 2 */
};

/* extern unsigned int   get1bit(void);*/
extern unsigned int   getbits(struct StaticData * psd, int);
extern unsigned int   getbits_fast(struct StaticData * psd, int);
extern int set_pointer(struct StaticData * psd, struct mpstr * gmp, long backstep);

extern int do_layer3(struct StaticData * psd, struct mpstr * gmp, struct frame *fr, unsigned char *pcm_sample, int *pcm_point);
extern int do_layer2(struct StaticData * psd, struct mpstr * gmp, struct frame *fr,unsigned char *,int *);

extern int head_check(unsigned long head);
extern int ExtractI4(unsigned char *buf);
extern int decode_header(struct mpstr *mp, struct frame *fr,unsigned long newhead);

struct gr_info_s {
      int scfsi;
      unsigned part2_3_length;
      unsigned big_values;
      unsigned scalefac_compress;
      unsigned block_type;
      unsigned mixed_block_flag;
      unsigned table_select[3];
      unsigned subblock_gain[3];
      unsigned maxband[3];
      unsigned maxbandl;
      unsigned maxb;
      unsigned region1start;
      unsigned region2start;
      unsigned preflag;
      unsigned scalefac_scale;
      unsigned count1table_select;
      real *full_gain[3];
      real *pow2gain;
};

struct III_sideinfo
{
  unsigned main_data_begin;
  unsigned private_bits;
  struct {
    struct gr_info_s gr[2];
  } ch[2];
};

extern int synth_1to1 (struct StaticData * psd, struct mpstr * gmp, real *bandPtr,int channel,unsigned char *out,int *pnt);
extern int tsynth_1to1 (struct StaticData * psd, real *,int,unsigned char *,int *);
extern int synth_1to1_mono (struct StaticData * psd, struct mpstr * gmp, real *,unsigned char *,int *);

extern void init_layer3(struct StaticData * psd, int);
extern void init_layer2(struct StaticData * psd);
extern void make_decode_tables(struct StaticData * psd, long scaleval);
extern void dct64(struct StaticData * psd, real *,real *,real *);

const extern long freqs[9];

/* Preserves exiting */

#define BE_QUIET

/* Windows debugging message */
void MessageI(int i);

#ifdef __cplusplus
}
#endif
