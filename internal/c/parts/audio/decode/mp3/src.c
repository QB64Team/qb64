#ifndef DEPENDENCY_AUDIO_DECODE_MP3
//Stubs:
//(none required)
#else

#ifdef QB64_BACKSLASH_FILESYSTEM
 #include "src\\mpg123.h"
 #include "src\\mpglib.h"
#else
 #include "src/mpg123.h"
 #include "src/mpglib.h"
#endif

//mpg123 decoding 'stuff'
int frequencies[9] = { 44100, 48000, 32000, 22050, 24000, 16000 , 11025 , 12000 , 8000 };
int bitrates[15] = { 0,32,40,48, 56, 64, 80, 96,112,128,160,192,224,256,320 };
#define MP3_ERR -1
#define MP3_OK  0
#define MP3_NEED_MORE 1

snd_sequence_struct *snd_decode_mp3(uint8 *buffer,int32 bytes){

static int status;
static struct mpstr mp;
InitMP3(&mp);
static int inlen;
static int outlen;
outlen=0;
static int OUT_BUF_SIZE;
OUT_BUF_SIZE=8192;
static char *bufin,*bufin_backup;
static char *bufout,*bufout_backup;
static int32 bufout_size;
static int32 out_bytes;

inlen=bytes;
bufin=(char*)buffer; bufin_backup=bufin;

bufout_size=1000000;
bufout=(char*)malloc(bufout_size); bufout_backup=bufout;

out_bytes=0;

status = decodeMP3(&mp,bufin,inlen,bufout,OUT_BUF_SIZE,&outlen);
bufout+=outlen;
out_bytes+=outlen;
ddd:
status = decodeMP3(&mp,NULL,NULL,bufout,OUT_BUF_SIZE,&outlen);
bufout+=outlen;
out_bytes+=outlen;

if (out_bytes>((bufout_size*3)/4)){//if buffer 75%+ full double its size
bufout_size*=2;
bufout_backup=(char*)realloc(bufout_backup,bufout_size);
bufout=bufout_backup+out_bytes;
}


if (status==0) goto ddd;

//trim bufout
bufout=bufout_backup;
bufout=(char*)realloc(bufout,out_bytes);

//attach bufout to new sequence
static int32 seq_handle; seq_handle=list_add(snd_sequences);
static snd_sequence_struct *seq; seq=(snd_sequence_struct*)list_get(snd_sequences,seq_handle);

memset(seq,0,sizeof(snd_sequence_struct));
seq->references=1;
seq->data=(uint8*)bufout;
seq->data_size=out_bytes;
seq->channels=mp.fr.stereo;
seq->endian=0;//native
//***signed 16-bit 44100***
seq->is_unsigned=0;
seq->sample_rate=44100;
seq->bits_per_sample=16;

return seq;

}

#endif

