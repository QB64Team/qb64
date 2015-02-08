#ifndef DEPENDENCY_AUDIO_DECODE
//Stubs:
//(none required)
#else

#define DEPENDENCY_AUDIO_DECODE_OGG
#define DEPENDENCY_AUDIO_DECODE_MP3
#define DEPENDENCY_AUDIO_DECODE_WAV

#ifdef QB64_BACKSLASH_FILESYSTEM
 #ifdef DEPENDENCY_AUDIO_DECODE_MP3  
  #include "mp3_mini\\src.c"
 #endif
 #ifdef DEPENDENCY_AUDIO_DECODE_WAV
  #include "wav\\src.c"
 #endif
 #ifdef DEPENDENCY_AUDIO_DECODE_OGG
  #include "ogg\\src.c"
 #endif
#else
 #ifdef DEPENDENCY_AUDIO_DECODE_MP3
  #include "mp3_mini/src.c"
 #endif
 #ifdef DEPENDENCY_AUDIO_DECODE_WAV
  #include "wav/src.c"
 #endif
 #ifdef DEPENDENCY_AUDIO_DECODE_OGG
  #include "ogg/src.c"
 #endif
#endif

//forward refs:
void sub__sndvol(int32 handle,float volume);
void sub__sndclose(int32 handle);

int32 func__sndopen(qbs* filename,qbs* requirements,int32 passed){
sndsetup();
if (new_error) return 0;

static qbs *s1=NULL;
if (!s1) s1=qbs_new(0,0);
static qbs *req=NULL;
if (!req) req=qbs_new(0,0);
static qbs *s3=NULL;
if (!s3) s3=qbs_new(0,0);

static uint8 r[32];
static int32 i,i2,i3;
//check requirements
memset(r,0,32);
if (passed){
if (requirements->len){
i=1;
qbs_set(req,qbs_ucase(requirements));//convert tmp str to perm str
nextrequirement:
i2=func_instr(i,req,qbs_new_txt(","),1);
if (i2){
qbs_set(s1,func_mid(req,i,i2-i,1));
}else{
qbs_set(s1,func_mid(req,i,req->len-i+1,1));
}
qbs_set(s1,qbs_rtrim(qbs_ltrim(s1)));
if (qbs_equal(s1,qbs_new_txt("SYNC"))){r[0]++; goto valid;}
if (qbs_equal(s1,qbs_new_txt("VOL"))){r[1]++; goto valid;}
if (qbs_equal(s1,qbs_new_txt("PAUSE"))){r[2]++; goto valid;}
if (qbs_equal(s1,qbs_new_txt("LEN"))){r[3]++; goto valid;}
if (qbs_equal(s1,qbs_new_txt("SETPOS"))){r[4]++; goto valid;}
error(5); return 0;//invalid requirements
valid:
if (i2){i=i2+1; goto nextrequirement;}
for (i=0;i<32;i++) if (r[i]>1){error(5); return 0;}//cannot define requirements twice
}//->len
}//passed
qbs_set(s1,qbs_add(filename,qbs_new_txt_len("\0",1)));//s1=filename+CHR$(0)

if (!r[0]){//NOT SYNC
 if (snd_stream_handle){error(5); return 0;}//stream in use
}

//load file
if (s1->len==1) return 0;//return invalid handle if null length string
static int32 fh,result;
static int64 lof;
fh=gfs_open(s1,1,0,0);
if (fh<0) return 0;
lof=gfs_lof(fh);
static uint8* content;
content=(uint8*)malloc(lof); if (!content){gfs_close(fh); return 0;}
result=gfs_read(fh,-1,content,lof);
gfs_close(fh);
if (result<0){free(content); return 0;}

//identify file format
static snd_sequence_struct *seq;

//OGG?
#ifdef DEPENDENCY_AUDIO_DECODE_OGG
if (lof>=3){
if (content[0]==79){ if (content[1]==103){ if (content[2]==103){//"Ogg"
   seq=snd_decode_ogg(content,lof);
   goto got_seq;
}}}
}//3
#endif

//WAV?
#ifdef DEPENDENCY_AUDIO_DECODE_WAV
if (lof>=12){
  if ((*(uint32*)&content[8])==0x45564157){//WAVE
   seq=snd_decode_wav(content,lof);
   goto got_seq;
  }//WAVE
}
#endif

//assume mp3!
//MP3?
#ifdef DEPENDENCY_AUDIO_DECODE_MP3
seq=snd_decode_mp3(content,lof);
#endif

got_seq:
free(content);
if (seq==NULL) return 0;

//convert sequence (includes sample rate conversion etc etc)

//just perform sample_rate fix for now...

//1. 8->16bit conversion and/or edian conversion
static int32 incorrect_format;
incorrect_format=0;
if (seq->bits_per_sample!=16) incorrect_format=1;
if (seq->is_unsigned) incorrect_format=1;
//todo... if (seq->endian==???)

//this section does not fix the frequency, only the bits per sample
//and signed-ness of the data
if (incorrect_format){
 static int32 bps; bps=seq->bits_per_sample/8;
 static int32 samples; samples=seq->data_size/bps;
 static uint8 *new_data;
 if (bps!=2){
  new_data=(uint8*)malloc(samples*2);
 }else{
  new_data=seq->data;
 }
 static int32 i,v;
 for (i=0;i<samples;i++){
  //read original value
  v=0;
  if (bps==1){
   if (seq->is_unsigned){
    v=*(uint8*)(seq->data+i*1);
    v=(v-128)*256;
   }else{
    v=*(int8*)(seq->data+i*1);
    v=v*128;
   }
  }
  if (bps==2){
   if (seq->is_unsigned){
    v=*(uint16*)(seq->data+i*2);
    v=v-32768;
   }else{
    v=*(int16*)(seq->data+i*2);
   }
  }
  //place new value into array
  ((int16*)new_data)[i]=v;
 }//i
 if (bps!=2){free(seq->data); seq->data=new_data; seq->data_size=samples*2;}
 //update seq info
 seq->bits_per_sample=16;
 seq->is_unsigned=0;
}//incorrect format


//2. samplerate conversion
if (seq->sample_rate!=snd_frequency){
 static float *f_in;
 static float *f_out;
 static int32 in_samples,channels;
 channels=seq->channels;
 in_samples=seq->data_size/channels/2;
 f_in=(float*)malloc(in_samples*channels*sizeof(float));
 src_short_to_float_array((int16*)seq->data,f_in,in_samples*channels);
 static double ratio;
 ratio=((double)snd_frequency)/((double)seq->sample_rate);//output/input
 static int32 out_samples_max;
 out_samples_max=((double)in_samples)*(ratio+0.1)+100;//10%+100 extra samples as a buffer-zone
 f_out=(float*)malloc(out_samples_max*channels*sizeof(float));
 static SRC_DATA s;
 s.data_in=f_in;
 s.input_frames=in_samples;
 s.data_out=f_out;
 s.output_frames=out_samples_max;//limit
 s.src_ratio=ratio;//Equal to output_sample_rate / input_sample_rate.
 //
 //         SRC_SINC_BEST_QUALITY       = 0,
 //         SRC_SINC_MEDIUM_QUALITY     = 1,
 //         SRC_SINC_FASTEST            = 2,
 //         SRC_ZERO_ORDER_HOLD         = 3,
 //         SRC_LINEAR                  = 4
 //
 if (src_simple(&s,SRC_LINEAR,channels)){
  //error!
  free(seq->data);
  //***todo***remove the seq
  return 0;
 }
 //old seq->data is the wrong size, so resize it
 free(seq->data);
 seq->data_size=s.output_frames_gen*channels*2;
 seq->data=(uint8*)malloc(seq->data_size);
 src_float_to_short_array(f_out,(int16*)seq->data,s.output_frames_gen*channels);
 //update seq info
 seq->sample_rate=snd_frequency;
}


if (seq->channels==1){
seq->data_mono=seq->data;
seq->data_mono_size=seq->data_size;
}
if (seq->channels==2){
seq->data_stereo=seq->data;
seq->data_stereo_size=seq->data_size;
}
if (seq->channels>2) return 0;

//attach sequence to handle (& inc. refs)
//create snd handle
static int32 handle; handle=list_add(snd_handles);
static snd_struct *snd; snd=(snd_struct*)list_get(snd_handles,handle);

snd->internal=0;
snd->type=2;
snd->seq=seq;
snd->volume=1.0;
snd->capability=r[0]*SND_CAPABILITY_SYNC+r[1]*SND_CAPABILITY_VOL+r[2]*SND_CAPABILITY_PAUSE+r[3]*SND_CAPABILITY_LEN+r[4]*SND_CAPABILITY_SETPOS;
if (!r[0]){
 snd->streamed=1;//NOT SYNC
 snd_stream_handle=handle;
}

return handle;
}


void sub__sndplayfile(qbs *filename,int32 sync,double volume,int32 passed){
if (new_error) return;
sndsetup();
static int32 handle;
static int32 setvolume;
static qbs *syncstr=NULL; if (!syncstr) syncstr=qbs_new(0,0);
setvolume=0;
if (passed&2){
if ((volume<0)||(volume>1)){error(5); return;}
if (volume!=1) setvolume=1;
}
if ((!setvolume)&&(!sync)) syncstr->len=0;
if ((setvolume)&&(!sync)) qbs_set(syncstr,qbs_new_txt("VOL"));
if ((!setvolume)&&(sync)) qbs_set(syncstr,qbs_new_txt("SYNC"));
if ((setvolume)&&(sync)) qbs_set(syncstr,qbs_new_txt("SYNC,VOL"));
if (syncstr->len){
handle=func__sndopen(filename,syncstr,1);
}else{
handle=func__sndopen(filename,NULL,0);
}
if (handle==0) return;
if (setvolume) sub__sndvol(handle,volume);
sub__sndplay(handle);
sub__sndclose(handle);
}




#endif

