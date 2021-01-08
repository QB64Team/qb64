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
#include <string.h>
//forward refs:
void sub__sndvol(int32 handle,float volume);
void sub__sndclose(int32 handle);

int32 func__sndopen(qbs* filename,qbs* requirements,int32 passed){
    sndsetup();
    if (new_error) return 0;

    static qbs *s1=NULL;
    if (!s1) s1=qbs_new(0,0);
    qbs_set(s1,qbs_add(filename,qbs_new_txt_len("\0",1)));//s1=filename+CHR$(0)

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
            new_data=(uint8*)seq->data;
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
        if (bps!=2){free(seq->data); seq->data=(uint16*)new_data; seq->data_size=samples*2;}
        //update seq info
        seq->bits_per_sample=16;
        seq->is_unsigned=0;
    }//incorrect format


    //2. samplerate conversion
    if (seq->sample_rate != snd_frequency) { //need to resample seq->data
        //create new resampler
        SpeexResamplerState *state;
        state = speex_resampler_init(seq->channels, seq->sample_rate, snd_frequency, SPEEX_RESAMPLER_QUALITY_MIN, NULL);
        if (!state) { //NULL means failure
            free(seq->data);
            return 0;
        }

        //allocate new memory for output
        int32 out_samples_max = ((double)seq->data_size / seq->channels / 2) * ((((double)snd_frequency) / ((double)seq->sample_rate)) + 0.1) + 100;//10%+100 extra samples as a buffer-zone
        int16 *resampled = (int16 *)malloc(out_samples_max * seq->channels * sizeof(int16));
        if (!resampled) {
            free(seq->data);
            return 0;
        }

        //establish data sizes
        //in_len will be set by the resampler to number of samples processed
        spx_uint32_t in_len = seq->data_size / seq->channels / 2; // divide by 2 because 2byte samples, divide by #channels because function wants it per-channel
        //out_len will be set to the number of samples written
        spx_uint32_t out_len = out_samples_max * seq->channels * sizeof(int16);

        //resample!
        if (speex_resampler_process_interleaved_int(state, (spx_int16_t *)seq->data, &in_len, (spx_int16_t *)resampled, &out_len) != RESAMPLER_ERR_SUCCESS) {
            //Error
            free(resampled);
            free(seq->data);
            speex_resampler_destroy(state);
            return 0;
        }

        //destroy the resampler anyway
        speex_resampler_destroy(state);

        //establish real size of new data and update seq
        free(seq->data); //That was the old data
        seq->data_size = out_len * seq->channels * 2; //remember out_len is perchannel, and each sample is 2 bytes
        seq->data = (uint16_t *)realloc(resampled, seq->data_size); //we overestimated the array size before, so make it the correct size now
        if (!seq->data) { //realloc could fail
            free(resampled);
            return 0;
        }
        seq->sample_rate = snd_frequency;
    }

    //Unpack stereo data into separate left/right buffers
    if (seq->channels == 1) {
        seq->channels = 1;
        seq->data_left = seq->data;
        seq->data_left_size = seq->data_size;
        seq->data_right = NULL;
        seq->data_right_size = 0;
    }
    else if (seq->channels == 2) {
        seq->data_left_size = seq->data_right_size = seq->data_size / 2;
        seq->data_left = (uint16_t *)malloc(seq->data_size / 2);
        if (!seq->data_left) {
            free(seq->data);
            return 0;
        }
        seq->data_right = (uint16_t *)malloc(seq->data_size / 2);
        if (!seq->data_right) {
            free(seq->data_left);
            free(seq->data);
            return 0;
        }
        for (int sample = 0; sample < seq->data_size / 4; sample++) {
            seq->data_left[sample] = seq->data[sample * 2];
            seq->data_right[sample] = seq->data[sample * 2 + 1];
        }
        free(seq->data);
        seq->data = NULL;
    }
    else {
        free(seq->data);
        return 0;
    } 

    //attach sequence to handle (& inc. refs)
    //create snd handle
    static int32 handle; handle=list_add(snd_handles);
    static snd_struct *snd; snd=(snd_struct*)list_get(snd_handles,handle);

    snd->internal=0;
    snd->type=2;
    snd->seq=seq;
    snd->volume=1.0;

    if (seq->channels == 1) {
        snd->bal_left_x = snd->bal_left_y = snd->bal_left_z = 0;
    }
    else if (seq->channels == 2) {
        snd->bal_left_x = -0.01;
        snd->bal_left_y = snd->bal_left_z = 0;
        snd->bal_right_x = 0.01;
        snd->bal_right_y = snd->bal_right_z = 0;
    }
    snd->bal_update = 1;
    sndupdate(snd);
    return handle;
}

mem_block func__memsound(int32 i,int32 targetChannel){
    
    static mem_block b;
    
    if (new_error) goto error;
    if (i<=0) goto error;
    
    sndsetup();

    static snd_struct *sn;
    sn = (snd_struct*)list_get(snd_handles, i);
    if (!sn){
        goto error;
    }
    if (!snd_allow_internal){
        if (sn->internal){
            goto error;
        }
    }
    if (targetChannel<1 || targetChannel>sn->seq->channels) goto error;
    
    if (sn->lock_id){
        b.lock_offset=(ptrszint)sn->lock_offset; b.lock_id=sn->lock_id;//get existing tag
        }else{
        new_mem_lock();
        mem_lock_tmp->type=5;//sound
        b.lock_offset=(ptrszint)mem_lock_tmp; b.lock_id=mem_lock_id;
        sn->lock_offset=(void*)mem_lock_tmp; sn->lock_id=mem_lock_id;//create tag
    }
    
    if (targetChannel==1) {
        b.offset=(ptrszint)sn->seq->data_left;
        b.size=sn->seq->data_left_size;
    }
    
    if (targetChannel==2) {
        b.offset=(ptrszint)sn->seq->data_right;
        b.size=sn->seq->data_right_size;
    }

    b.type=0;//sn->bytes_per_pixel+128+1024+2048;//integer+unsigned+pixeltype
    b.elementsize=sn->seq->bits_per_sample/8;
    b.sound=i;
    
    return b;
    error:
    b.offset=0;
    b.size=0;
    b.lock_offset=(ptrszint)mem_lock_base; b.lock_id=1073741821;//set invalid lock
    b.type=0;
    b.elementsize=0;
    b.sound=0;
    return b;
}


void sub__sndplayfile(qbs *filename, int32 sync, double volume, int32 passed){
    if (new_error) return;
    sndsetup();
    int32 handle;
    handle = func__sndopen(filename, NULL, 0);
    if (!handle) return;
    if (passed & 2) {
        sub__sndvol(handle, volume);
    }
    sub__sndplay(handle);
    sub__sndclose(handle);
}




#endif

