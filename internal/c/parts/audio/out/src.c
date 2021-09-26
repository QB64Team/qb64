#ifndef DEPENDENCY_AUDIO_OUT
//Stubs:
void snd_mainloop(){return;}
void snd_init(){return;}
void snd_un_init(){return;}
#else

#ifdef QB64_BACKSLASH_FILESYSTEM
#include "AL\\al.h"
#include "AL\\alc.h"
#include <stdio.h>
#include <sys\\types.h>
#include <sys\\stat.h>
#include <unistd.h>
#include <stdlib.h>
#else
#include "AL/al.h"
#include "AL/alc.h"
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <stdlib.h>
#endif

//forward refs (with no struct dependencies)
void sndsetup();
void sndclose_now(int32 handle);
void sub__sndstop(int32 handle);
void sub__sndplay(int32);
uint8 *soundwave(double frequency,double length,double volume,double fadein,double fadeout);
void qb64_generatesound(double f,double l,uint8 wait);
void qb64_internal_sndraw(uint8* data,int32 bytes,int32 block);
double func__sndrawlen(int32 handle,int32 passed);


//global variables
int32 qb64_sndraw_lock=0;
int32 qb64_internal_sndraw_handle=0;
int64 qb64_internal_sndraw_lastcall=0;
int64 qb64_internal_sndraw_prepad=0;
int64 qb64_internal_sndraw_postpad=0;
int32 soundwave_bytes=0;
int32 snd_frequency=44100;
int32 snd_buffer_size=16384;
int32 snd_allow_internal=0;//set this flag before calling snd_... commands with an internal sound

uint8 *soundwave(double frequency,double length,double volume,double fadein,double fadeout){
    //this creates 16bit signed stereo data

    sndsetup();
    static uint8 *data;
    static int32 i;
    static int16 x,lastx;
    static int16* sp;
    static double samples_per_second;
    samples_per_second=snd_frequency;

    //calculate total number of samples required
    static double samples;
    static int32 samplesi;
    samples=length*samples_per_second;
    samplesi=samples; if (!samplesi) samplesi=1;

    soundwave_bytes=samplesi*4;
    data=(uint8*)malloc(soundwave_bytes);
    sp=(int16*)data;

    static int32 direction;
    direction=1;

    static double value;
    value=0;

    static double volume_multiplier;
    volume_multiplier=volume*32767.0;

    static int32 waveend;
    waveend=0;

    static double gradient;
    //frequency*4.0*length is the total distance value will travel (+1,-2,+1[repeated])
    //samples is the number of steps to do this in
    if (samples) gradient=(frequency*4.0*length)/samples; else gradient=0;//avoid division by 0

    lastx=1;//set to 1 to avoid passing initial comparison
    for (i=0;i<samplesi;i++){
        x=value*volume_multiplier;
        *sp++=x;
        *sp++=x;
        if (x>0){
            if (lastx<=0){
                waveend=i;
            }
        }
        lastx=x;
        if (direction){
            if ((value+=gradient)>=1.0){direction=0; value=2.0-value;}
        }else{
            if ((value-=gradient)<=-1.0){direction=1; value=-2.0-value;}
        }
    }//i

    if (waveend) soundwave_bytes=waveend*4;

    return (uint8*)data;
}

int32 wavesize(double length){
    static int32 samples;
    samples=length*(double)snd_frequency; if (samples==0) samples=1;
    return samples*4;
}



void sub_sound(double frequency,double lengthinclockticks){
    sndsetup();
    if (new_error) return;
    //note: there are 18.2 clock ticks per second
    if ((frequency<37.0)&&(frequency!=0)) goto error;
    if (frequency>32767.0) goto error;
    if (lengthinclockticks<0.0) goto error;
    if (lengthinclockticks>65535.0) goto error;
    if (lengthinclockticks==0.0) return;
    qb64_generatesound(frequency,lengthinclockticks/18.2,1);
    return;
error:
    error(5);
}


struct snd_sequence_struct{
    uint16 *data;
    int32 data_size;
    uint8 channels;//note: more than 2 channels may be supported in the future
    uint16 *data_left;
    int32 data_left_size;
    uint16 *data_right;
    int32 data_right_size;

    //origins of data (only relevent before src)
    uint8 endian;//0=native, 1=little(Windows, x86), 2=big(Motorola, Xilinx Microblaze, IBM POWER)
    uint8 is_unsigned;//1=unsigned, 0=signed(most common)
    int32 sample_rate;//eg. 11025, 22100
    int32 bits_per_sample;//eg. 8, 16

    int32 references;//number of SND handles dependent on this

};
list *snd_sequences=list_new(sizeof(snd_sequence_struct));


struct snd_struct{
    void *lock_offset;
    int64 lock_id;

    uint8 internal;//1=internal
    uint8 type;//1=RAW, 2=SEQUENCE

    //sequence
    snd_sequence_struct *seq;
    //----part specific variables----
    ALuint al_seq_left_buffer;
    ALuint al_seq_right_buffer;
    ALenum al_seq_format;
    ALsizei al_seq_freq;
    ALboolean al_seq_loop;
    ALuint al_seq_left_source;
    ALuint al_seq_right_source;
    //-------------------------------

    float volume;
    uint8 volume_update;

    uint8 close;

    uint8 limit_state;//0=off, 1=awaiting start[duration has been set], 2=waiting for stop point
    double limit_duration;
    int64 limit_stop_point;

    //locks
    uint8 setpos_lock_release;

    uint8 setpos_update;
    float setpos;

    float bal_left_x,bal_left_y,bal_left_z;
    float bal_right_x,bal_right_y,bal_right_z;
    uint8 bal_update;

    //usage of buffer depends heavily on type
    uint8 *buffer;
    int32 buffer_size;

    ptrszint *stream_buffer;//pointers to buffers
    int32 stream_buffer_last;
    int32 stream_buffer_start;
    int32 stream_buffer_next;

    ALuint al_source;
    ALuint *al_buffers;//[4]
    uint8 *al_buffer_state;//[4] 0=never used, 1=processing, 2=processed
    int32 *al_buffer_index;//[4]


    int64 raw_close_time;

    //The maximum number of buffers on iOS and on OS X is 1024.
    //The maximum number of sources is 32 on iOS and 256 on OS X.
    //therefore: inactive sources should be de-initialized & buffers should be 4

    uint8 state;

};
#define SND_STATE_STOPPED 0
#define SND_STATE_PLAYING 1
#define SND_STATE_PAUSED 2


list *snd_handles=list_new(sizeof(snd_struct));

void sndsetup(){

    static int32 sndsetup_called=0;
    if (!sndsetup_called){
        sndsetup_called=1;
        //...
    }

    //scan through all sounds and close marked ones, performed here to avoid thread issues
    static int32 list_index;
    for (list_index=1;list_index<=snd_handles->indexes;list_index++){
        static snd_struct *snd; snd=(snd_struct*)list_get(snd_handles,list_index);
        if (snd){

            if (snd->close==2){
                sndclose_now(list_index);
            }

        }//snd
    }//list_index

}//sndsetup



void sub_beep(){
    sndsetup();
    qb64_generatesound(783.99,0.2,0);
    sub__delay(0.25);
}




ALCdevice *dev;
ALCcontext *ctx;
struct stat statbuf;

void snd_un_init(){
    alcCloseDevice(dev);
    return;
}

int32 snd_init_done=0;
void snd_init(){
    if (!snd_init_done){

        dev = alcOpenDevice(NULL); if (!dev) goto done;
        ctx = alcCreateContext(dev, NULL); if (!ctx) goto done;
        alcMakeContextCurrent(ctx);

        alListener3f(AL_POSITION, 0, 0, 0);
        alListener3f(AL_VELOCITY, 0, 0, 0);
        alListener3f(AL_ORIENTATION, 0, 0, -1);//facing 'forward' on rhs co-ordinate system
        alDistanceModel(AL_LINEAR_DISTANCE_CLAMPED);



    }
    done:;
    snd_init_done=1;
}




//OPENAL

int32 snd_raw_channel=0;

int32 func__sndopenraw(){
    static int32 handle; handle=list_add(snd_handles);
    static snd_struct *snd; snd=(snd_struct*)list_get(snd_handles,handle);
    snd->internal=0;
    snd->type=1;
    snd->buffer=(uint8*)malloc(snd_buffer_size);
    snd->buffer_size=0;

    snd->stream_buffer_last=65536;
    snd->stream_buffer=(ptrszint*)malloc(sizeof(ptrszint)*(snd->stream_buffer_last+1));//range: 1-65536 (0 ignored)
    snd->stream_buffer_start=0;
    snd->stream_buffer_next=1;

    alGenSources(1,&snd->al_source);
    //if(alGetError()!=AL_NO_ERROR) return 0;

    snd->al_buffers=(ALuint*)malloc(sizeof(ALuint)*4);
    alGenBuffers(4,snd->al_buffers);
    //if(alGetError()!=AL_NO_ERROR) return 0;
    snd->al_buffer_state=(uint8*)calloc(4,1);
    snd->al_buffer_index=(int32*)calloc(4,4);
    return handle;
}





void sub__sndraw(float left,float right,int32 handle,int32 passed){
    if (passed&2){
        if (handle==0) return;//note: this would be an invalid handle
    }else{
        if (!snd_raw_channel) snd_raw_channel=func__sndopenraw();
        handle=snd_raw_channel;
    }

    static snd_struct *snd; snd=(snd_struct*)list_get(snd_handles,handle);
    if (!snd) goto error;
    if (snd->internal) goto error;
    if (snd->type!=1) goto error;

    while (qb64_sndraw_lock) Sleep(0);
    qb64_sndraw_lock=1;

    if (handle==qb64_internal_sndraw_handle) qb64_internal_sndraw_lastcall=GetTicks();

    static int16 sample_left;
    sample_left=left*32767.0;
    static int16 sample_right;
    if (passed&1) sample_right=right*32767.0; else sample_right=sample_left;

    //add sample
    if (snd->buffer_size<snd_buffer_size){
        *(int16*)(snd->buffer+snd->buffer_size)=sample_left;
        snd->buffer_size+=2;
        *(int16*)(snd->buffer+snd->buffer_size)=sample_right;
        snd->buffer_size+=2;
    }

    if (snd->buffer_size==snd_buffer_size){
        //detach buffer
        static uint8 *buffer;
        buffer=snd->buffer;

        //create new buffer
        snd->buffer=(uint8*)malloc(snd_buffer_size);
        snd->buffer_size=0;

        //attach detached buffer to stream (or discard it)
        static int32 p,p2;
        p=snd->stream_buffer_next; p2=p+1; if (p2>snd->stream_buffer_last) p2=1;
        if (p2==snd->stream_buffer_start){free(buffer); qb64_sndraw_lock=0; return;}//all buffers are full! (quietly ignore this buffer)
        snd->stream_buffer[p]=(ptrszint)buffer;
        snd->stream_buffer_next=p2;
        if (!snd->stream_buffer_start) snd->stream_buffer_start=1;

    }

    qb64_sndraw_lock=0;

    return;

error:
    error(5);
    return;

}

void snd_mainloop(){

    static int64 t;
    t=-1;

    //scan through all sounds
    int32 list_index;
    for (list_index = 1; list_index<=snd_handles->indexes; list_index++) {
        snd_struct *snd = (snd_struct*)list_get(snd_handles, list_index);
        if (!snd) continue;
        if (snd->type == 2){
            if (snd->limit_state == 2){
                if (t==-1) t = GetTicks();
                if (t >= snd->limit_stop_point) {
                    snd->limit_state=0;
                    sub__sndstop(list_index);
                }
            }//limit_state==2

            if (snd->close == 1){
                //directly poll to check the sound's state
                ALint al_state;
                alGetSourcei(snd->al_seq_left_source,AL_SOURCE_STATE,&al_state);
                if (al_state==AL_INITIAL) snd->state=SND_STATE_STOPPED;
                if (al_state==AL_STOPPED) snd->state=SND_STATE_STOPPED;
                if (al_state==AL_PLAYING) snd->state=SND_STATE_PLAYING;
                if (al_state==AL_PAUSED) snd->state=SND_STATE_PAUSED;
                if (snd->state!=SND_STATE_PLAYING) snd->close=2;
            }//snd->close==1

        }//2

        if (snd->type==1){//RAW
            if (snd->close!=2){
                if (snd->stream_buffer_start){
                    static int32 repeat;
                    do{
                        repeat=0; 

                        //internal sndraw post padding
                        //note: without post padding the final, incomplete buffer of sound data would not be played
                        if (list_index==qb64_internal_sndraw_handle){//internal sound raw
                            if (snd->stream_buffer_start==snd->stream_buffer_next){//on last source buffer
                                if (snd->buffer_size>0){//partial size
                                    if (GetTicks()>(qb64_internal_sndraw_lastcall+20)){//no input received for last 0.02 seconds
                                        if (!qb64_sndraw_lock){//lock (or skip)
                                            qb64_sndraw_lock=1;
                                            if (qb64_internal_sndraw_postpad){//post-pad allowed
                                                qb64_internal_sndraw_postpad=0;
                                                while (snd->buffer_size<snd_buffer_size){
                                                    *(int16*)(snd->buffer+snd->buffer_size)=0;
                                                    snd->buffer_size+=2;
                                                    *(int16*)(snd->buffer+snd->buffer_size)=0;
                                                    snd->buffer_size+=2;
                                                }
                                                //detach buffer
                                                static uint8 *buffer;
                                                buffer=snd->buffer;
                                                //create new buffer
                                                snd->buffer=(uint8*)calloc(snd_buffer_size,1);
                                                snd->buffer_size=0;
                                                //attach detached buffer to stream (or discard it)
                                                static int32 p,p2;
                                                p=snd->stream_buffer_next; p2=p+1; if (p2>snd->stream_buffer_last) p2=1;
                                                if (p2==snd->stream_buffer_start){
                                                    free(buffer); //all buffers are full! (quietly ignore this buffer)
                                                }else{
                                                    snd->stream_buffer[p]=(ptrszint)buffer;
                                                    snd->stream_buffer_next=p2;
                                                }
                                                //next sound command to prepad if necessary to begin sound
                                                qb64_internal_sndraw_prepad=1;
                                                //unlock
                                                qb64_sndraw_lock=0;
                                            }//post-pad allowed
                                        }//lock (or skip)
                                    }//no input received for last x seconds
                                }//partial size
                            }//on last source buffer
                        }//internal sound raw


                        if (snd->stream_buffer_start!=snd->stream_buffer_next){
                            static int32 p,p2;
                            static int32 i,i2;
                            p=snd->stream_buffer_start; p2=p+1; if (p2>snd->stream_buffer_last) p2=1;

                            //unqueue processed buffers (if any)
                            static ALint buffers_processed;
                            static ALuint buffers[4];
                            alGetSourcei(snd->al_source, AL_BUFFERS_PROCESSED, &buffers_processed);
                            if (buffers_processed){
                                alSourceUnqueueBuffers(snd->al_source, buffers_processed, &buffers[0]);
                                //free associated data
                                for (i2=0;i2<buffers_processed;i2++){
                                    for (i=0;i<=3;i++){
                                        if (buffers[i2]==snd->al_buffers[i]){
                                            free((void*)snd->stream_buffer[snd->al_buffer_index[i]]);
                                            snd->al_buffer_state[i]=2;//"processed"
                                        }
                                    }
                                }
                            }

                            //check for uninitiated buffers
                            for (i=0;i<=3;i++){
                                if (snd->al_buffer_state[i]==0){
                                    snd->al_buffer_state[i]=1;//"processing"
                                    snd->al_buffer_index[i]=p;
                                    static ALuint frequency;
                                    static ALenum format;
                                    frequency=snd_frequency;
                                    format=AL_FORMAT_STEREO16;
                                    alBufferData(snd->al_buffers[i], format, (void*)snd->stream_buffer[p], snd_buffer_size, frequency);
                                    alSourceQueueBuffers(snd->al_source, 1, &snd->al_buffers[i]);
                                    static ALint al_state;
                                    alGetSourcei(snd->al_source,AL_SOURCE_STATE,&al_state);
                                    if (al_state!=AL_PLAYING){
                                        alSourcePlay(snd->al_source);
                                    }
                                    goto gotbuffer;
                                }
                            }

                            //check for finished buffers
                            for (i=0;i<=3;i++){
                                if (snd->al_buffer_state[i]==2){//"processed"
                                    static ALuint buffer;
                                    static ALuint frequency;
                                    static ALenum format;
                                    frequency=snd_frequency;
                                    format=AL_FORMAT_STEREO16;
                                    alBufferData(snd->al_buffers[i], format, (void*)snd->stream_buffer[p], snd_buffer_size, frequency);
                                    alSourceQueueBuffers(snd->al_source, 1, &snd->al_buffers[i]);
                                    static ALint al_state;
                                    alGetSourcei(snd->al_source,AL_SOURCE_STATE,&al_state);
                                    if (al_state!=AL_PLAYING){
                                        alSourcePlay(snd->al_source);
                                    }
                                    snd->al_buffer_index[i]=p;
                                    snd->al_buffer_state[i]=1;//"processing"
                                    goto gotbuffer;
                                }
                            }

                            i=-1;

gotbuffer:
                            if (i!=-1){
                                repeat=1;
                                snd->stream_buffer_start=p2;
                            }

                        }//queued buffer exists

                    }while(repeat); 

                }//started
            }//close!=2



            //close raw?
            if (snd->close==1){
                if (t==-1) t=GetTicks();
                if (t>(snd->raw_close_time+3000)){
                    static ALint al_state;
                    alGetSourcei(snd->al_source,AL_SOURCE_STATE,&al_state);
                    if (al_state==AL_INITIAL) snd->state=SND_STATE_STOPPED;
                    if (al_state==AL_STOPPED) snd->state=SND_STATE_STOPPED;
                    if (al_state==AL_PLAYING) snd->state=SND_STATE_PLAYING;
                    if (al_state==AL_PAUSED) snd->state=SND_STATE_PAUSED;
                    if (snd->state!=SND_STATE_PLAYING){//not playing
                        //note: hardware interface parts closed here, handles closed in sndclose_now
                        if (snd->al_source){
                            alDeleteSources(1,&snd->al_source); snd->al_source=0;
                        }
                        static int32 i;
                        for (i=0;i<=3;i++){
                            if (snd->al_buffers[i]) alDeleteBuffers(1,&snd->al_buffers[i]);
                        }
                        //remove the buffers
                        //1)remove 4 AL buffers
                        free(snd->al_buffers);
                        free(snd->al_buffer_index);
                        free(snd->al_buffer_state);
                        //2)remove build buffer
                        free(snd->buffer);
                        //3)remove the 65536 pointers to potential buffers
                        free(snd->stream_buffer);
                        snd->close=2;
                    }//not playing
                }//time>3 secs
            }//sndclose==1
        }//RAW
    }//list_index loop
}

int32 sndupdate_dont_free_resources=0;
void sndupdate(snd_struct *snd){

    if (snd->type==2){//seq type
        static snd_sequence_struct *seq; seq=snd->seq;
        if (snd->al_seq_left_source){
            //update state info
            static ALint al_state;
            alGetSourcei(snd->al_seq_left_source,AL_SOURCE_STATE,&al_state);
            //ref: Each source can be in one of four possible execution states: AL_INITIAL, AL_PLAYING, AL_PAUSED, AL_STOPPED
            if (al_state==AL_INITIAL) snd->state=SND_STATE_STOPPED;
            if (al_state==AL_STOPPED) snd->state=SND_STATE_STOPPED;
            if (al_state==AL_PLAYING) snd->state=SND_STATE_PLAYING;
            if (al_state==AL_PAUSED) snd->state=SND_STATE_PAUSED;
            if (snd->state==SND_STATE_STOPPED){
                if (!sndupdate_dont_free_resources){
                    if (snd->setpos_lock_release) goto no_release;
                    //###agressively free OpenAL resources (buffers & sources are very limited on some platforms)###
                    alDeleteSources(1,&snd->al_seq_left_source); snd->al_seq_left_source=0;
                    alDeleteBuffers(1,&snd->al_seq_left_buffer); snd->al_seq_left_buffer=0;
                    if (snd->al_seq_right_source) {
                        alDeleteSources(1, &snd->al_seq_right_source); snd->al_seq_right_source = 0;
                        alDeleteBuffers(1, &snd->al_seq_right_buffer); snd->al_seq_right_buffer = 0;
                    }
                    //flag updates
                    snd->volume_update=1;
                    snd->bal_update=1;
no_release:;
                }
            }
            if (snd->limit_state==2){
                if (snd->state!=SND_STATE_PLAYING) snd->limit_state=0;//disable limit
            }
            if (snd->al_seq_left_source){//still valid?
                if (snd->bal_update){
                    snd->bal_update=0;
                     alSource3f(snd->al_seq_left_source, AL_POSITION, snd->bal_left_x, snd->bal_left_y, snd->bal_left_z);
                    if (snd->al_seq_right_source) {
                        alSource3f(snd->al_seq_right_source, AL_POSITION, snd->bal_right_x, snd->bal_right_y, snd->bal_right_z);
                    }
                /*
                   OpenAL -- like OpenGL -- uses a right-handed Cartesian coordinate system (RHS),
                   where in a frontal default view X (thumb) points right, Y (index finger) points up,
                   and Z (middle finger) points towards the viewer/camera. To switch from a left handed
                   coordinate system (LHS) to a right handed coordinate systems, flip the sign on the Z coordinate.
                 */
                /* ref: old bal system code & notes
                   x distance values go from left(negative) to right(positive).
                   y distance values go from below(negative) to above(positive).
                   z distance values go from behind(negative) to in front(positive).
                   d=sqrt(x*x+y*y+z*z);
                   if (d<1) d=0;
                   if (d>1000) d=1000;
                   d=1000-d;
                   d=d/1000.0;
                   stream_volume_mult1=d;
                   --------------------
                   snd[i].posx=x; snd[i].posy=y; snd[i].posz=z;
                   d=atan2(x,z)*57.295779513;
                   if (d<0) d=360+d;
                   i2=d+0.5; if (i2==360) i2=0;//angle
                   d2=sqrt(x*x+y*y+z*z);//distance
                   if (d2<1) d2=1;
                   if (d2>999.9) d2=999.9;
                   i3=d2/3.90625;
                 */
                }//snd->bal_update
                if (snd->volume_update){
                    snd->volume_update=0;
                    alSourcef(snd->al_seq_left_source, AL_GAIN, snd->volume);
                    if (snd->al_seq_right_source) {
                        alSourcef(snd->al_seq_right_source, AL_GAIN, snd->volume);
                    }
                }//snd->volume_update
                if (snd->setpos_lock_release){
                    if (snd->state!=SND_STATE_STOPPED){
                        snd->setpos_lock_release=0;
                    }
                }
                if (snd->setpos_update){
                    snd->setpos_update=0;
                    alSourcef(snd->al_seq_left_source,AL_SEC_OFFSET,snd->setpos);
                    if (snd->al_seq_right_source) {
                        alSourcef(snd->al_seq_right_source, AL_SEC_OFFSET, snd->setpos);
                    }
                    snd->setpos_lock_release=1;
                }
            }//snd->al_seq_source still valid?
        }//snd->al_seq_source
    }//2
/*
    if (snd->type==1){
        static ALint al_state;
        alGetSourcei(snd->al_source,AL_SOURCE_STATE,&al_state);
        //ref: Each source can be in one of four possible execution states: AL_INITIAL, AL_PLAYING, AL_PAUSED, AL_STOPPED
        if (al_state==AL_INITIAL) snd->state=SND_STATE_STOPPED;
        if (al_state==AL_STOPPED) snd->state=SND_STATE_STOPPED;
        if (al_state==AL_PLAYING) snd->state=SND_STATE_PLAYING;
        if (al_state==AL_PAUSED) snd->state=SND_STATE_PAUSED;
    }
*/
}//sndupdate

int32 func__sndcopy(int32 handle){
    if (new_error) return 0;
    sndsetup();
    if (handle == 0) return 0;//default response
    snd_struct *snd = (snd_struct*)list_get(snd_handles, handle);
    if (!snd || snd->internal) {
        error(5);
        return 0;
    }
    if (snd->type == 2){
        sndupdate(snd);
        //increment seq references
        snd->seq->references++;
        snd_struct *snd_source = snd;
        //create new snd handle
        int32 handle = list_add(snd_handles);
        snd_struct *snd = (snd_struct *)list_get(snd_handles, handle);
        //import all data
        memcpy (snd, snd_source, sizeof(snd_struct));
        //adjust data
        snd->al_seq_left_buffer = 0;//no buffer
        snd->al_seq_left_source = 0;//no source
        snd->al_seq_right_buffer = 0;
        snd->al_seq_right_source = 0;
        snd->volume_update = 1;
        snd->state = 0;
        return handle;
    }//2
    error(5);
    return 0;
}




int32 sub__sndvol_error=0;
void sub__sndvol(int32 handle, float volume){
    if (new_error) return;
    sndsetup();
    sub__sndvol_error = 0;
    if (handle == 0) return;//default response
    snd_struct *snd = (snd_struct*)list_get(snd_handles, handle);
    sub__sndvol_error = 1;
    if (!snd || snd->internal) {
        error(5);
        return;
    }
    snd->volume = volume;
    snd->volume_update = 1;
    sndupdate(snd);
    sub__sndvol_error = 0;
}

void sub__sndpause(int32 handle) {
    if (new_error) return;
    sndsetup();
    if (handle == 0) return;//default response
    snd_struct *snd = (snd_struct*)list_get(snd_handles, handle);
    if (!snd || snd->internal) {
        error(5);
        return;
    }
    if (snd->type == 2){
        sndupdate(snd);
        if (snd->al_seq_left_source && snd->state == SND_STATE_PLAYING) {
            const ALuint sources[2] = {snd->al_seq_left_source, snd->al_seq_right_source};
            alSourcePausev(snd->al_seq_right_source ? 2 : 1, sources);
            snd->state = SND_STATE_PAUSED;
            if (snd->limit_state == 2) {
                snd->limit_state = 0;
            }
        }
        return;
    }
    error(5);
}



void sub__sndstop(int32 handle){
    if (new_error) return;
    sndsetup();
    if (handle == 0) return;//default response
    snd_struct *snd = (snd_struct*)list_get(snd_handles, handle);
    if (!snd || snd->internal) {
        error(5);
        return;
    }
    if (snd->type == 2){
        sndupdate(snd);
        if (snd->al_seq_left_source && snd->state != SND_STATE_STOPPED) {
            const ALuint sources[2] = {snd->al_seq_left_source, snd->al_seq_right_source};
            alSourceStopv(snd->al_seq_right_source ? 2 : 1, sources);
            if (snd->limit_state == 2) {
                snd->limit_state = 0; //disable limit
            }
        }
        return;
    }//2
    error(5);
}


int32 sndplay_loop=0;
void sub__sndplay(int32 handle){
    if (new_error) return;
    sndsetup();
    if (handle == 0) return;//default response
    snd_struct *snd = (snd_struct*)list_get(snd_handles, handle);
    if (!snd){
        error(5);
        return;
    }
    if (!snd_allow_internal){
        if (snd->internal){
            error(5);
            return;
        }
    }
    if (snd->type == 2){
        snd_sequence_struct *seq; seq=snd->seq;
        if (!snd->al_seq_left_buffer){
            alGenBuffers(1, &snd->al_seq_left_buffer);
            if (!snd->al_seq_right_buffer && seq->data_right) {
                alGenBuffers(1, &snd->al_seq_right_buffer);
            }
            snd->al_seq_freq=snd_frequency;
            snd->al_seq_format = AL_FORMAT_MONO16;
            alBufferData(snd->al_seq_left_buffer, snd->al_seq_format, seq->data_left, seq->data_left_size, snd_frequency);
            if (seq->data_right) {
                alBufferData(snd->al_seq_right_buffer, snd->al_seq_format, seq->data_right, seq->data_right_size, snd_frequency);
            }
        }
        if (!snd->al_seq_left_source){
            alGenSources(1, &snd->al_seq_left_source);
            alSourcef(snd->al_seq_left_source,AL_REFERENCE_DISTANCE,0.01);
            alSourcef(snd->al_seq_left_source,AL_MAX_DISTANCE,10);
            alSourcef(snd->al_seq_left_source,AL_ROLLOFF_FACTOR,1);
            alSourcei(snd->al_seq_left_source,AL_BUFFER,snd->al_seq_left_buffer);
        }
        if (!snd->al_seq_right_source && seq->data_right) {
            alGenSources(1, &snd->al_seq_right_source);
            alSourcef(snd->al_seq_right_source,AL_REFERENCE_DISTANCE,0.01);
            alSourcef(snd->al_seq_right_source,AL_MAX_DISTANCE,10);
            alSourcef(snd->al_seq_right_source,AL_ROLLOFF_FACTOR,1);
            alSourcei(snd->al_seq_right_source,AL_BUFFER,snd->al_seq_right_buffer);
        }

        sndupdate_dont_free_resources=1;
        sndupdate(snd);
        if (snd->state==SND_STATE_PLAYING){
            sub__sndstop(handle);
            sndupdate(snd);
        }
        sndupdate_dont_free_resources=0;


        alSourcei(snd->al_seq_left_source, AL_LOOPING, sndplay_loop ? AL_TRUE : AL_FALSE);
        alSourcei(snd->al_seq_right_source, AL_LOOPING, sndplay_loop ? AL_TRUE : AL_FALSE);

        const ALuint sources[2] = {snd->al_seq_left_source, snd->al_seq_right_source};
        alSourcePlayv(snd->al_seq_right_source ? 2 : 1, sources);

        snd->state=SND_STATE_PLAYING;

        if (snd->limit_state==2) snd->limit_state=0;//disable limit
        if (snd->limit_state==1){
            snd->limit_stop_point=GetTicks()+(snd->limit_duration*1000.0);
            snd->limit_state=2;
        }

        return;
    }//2
    error(5);
}//sndplay

void sub__sndloop(int32 handle){
    sndplay_loop=1;
    sub__sndplay(handle);//call SNDPLAY with loop option set
    sndplay_loop=0;
}//sndloop

int32 func__sndpaused(int32 handle){
    if (new_error) return 0;
    sndsetup();
    if (handle==0) return 0;//default response
    snd_struct *snd = (snd_struct*)list_get(snd_handles, handle);
    if (!snd || snd->internal){
        error(5);
        return 0;
    }
    sndupdate(snd);
    if (snd->state == SND_STATE_PAUSED) return -1;
    return 0;
}

int32 func__sndplaying(int32 handle){
    if (new_error) return 0;
    sndsetup();
    if (handle==0) return 0;//default response
    snd_struct *snd = (snd_struct*)list_get(snd_handles, handle);
    if (!snd || snd->internal){
        error(5);
        return 0;
    }
    sndupdate(snd);
    if (snd->state == SND_STATE_PLAYING) return -1;
    return 0;
}

double func__sndlen(int32 handle){
    if (new_error) return 0;
    sndsetup();
    if (handle==0) return 0;//default response
    snd_struct *snd = (snd_struct*)list_get(snd_handles, handle);
    if (!snd || snd->internal){error(5); return 0;}
    if (snd->type==2){
        snd_sequence_struct *seq = snd->seq;
        int32 samples = seq->data_size / seq->channels / (seq->bits_per_sample / 8);
        double seconds = samples/(double)seq->sample_rate;
        return seconds;
    }//2
    error(5); return 0;
}

void sub__sndbal(int32 handle, double x, double y, double z, int32 channel, int32 passed){
    if (new_error) return;
    sndsetup();
    if (handle == 0) return;//default response
    snd_struct *snd = (snd_struct*)list_get(snd_handles, handle);
    if (!snd || snd->internal || channel < 1 || channel > 2){
        error(5);
        return;
    }
    if (snd->type != 2) return;
    if (!(passed & 8)) {
        channel = 1;
    }
    if (channel == 1) {
        if (passed & 1) snd->bal_left_x = x / 100;
        if (passed & 2) snd->bal_left_y = y / 100;
        if (passed & 4) snd->bal_left_z = z / 100;   
    }
    else if (channel == 2) {
        if (passed & 1) snd->bal_right_x = x / 100;
        if (passed & 2) snd->bal_right_y = y / 100;
        if (passed & 4) snd->bal_right_z = z / 100;
    }
    snd->bal_update = 1;
    sndupdate(snd);
}

double func__sndgetpos(int32 handle){
    if (new_error) return 0;
    sndsetup();
    if (handle==0) return 0;//default response
    snd_struct *snd = (snd_struct*)list_get(snd_handles, handle);
    if (!snd || snd->internal) {
        error(5);
        return 0;
    }
    if (snd->type==2){
        if (snd->al_seq_left_source){
            float seconds;
            alGetSourcef(snd->al_seq_left_source, AL_SEC_OFFSET, &seconds);
            return seconds;
        }
        return 0;
    }
    error(5); return 0;
}//getpos

void sub__sndsetpos(int32 handle,double seconds){
    if (new_error) return;
    sndsetup();
    if (handle == 0) return;//default response
    snd_struct *snd = (snd_struct*)list_get(snd_handles, handle);
        if (!snd || snd->internal || seconds < 0) {
        error(5);
        return;
    }
    if (snd->type == 2){
        snd->setpos = seconds;
        snd->setpos_update = 1;
        sndupdate(snd);
        return;
    }
    error(5);
}//setpos

void sub__sndlimit(int32 handle,double limit){
    if (new_error) return;
    sndsetup();
    if (handle==0) return;//default response
    snd_struct *snd = (snd_struct*)list_get(snd_handles, handle);
    if (!snd || snd->internal || limit < 0) {
        error(5);
        return;
    }
    if (snd->type == 2){
        if (limit == 0){
            snd->limit_state = 0;
            return;
        }
        sndupdate(snd);
        if (snd->state == SND_STATE_PLAYING){
            //begin count immediately
            snd->limit_stop_point = GetTicks() + (limit * 1000.0);
            snd->limit_state = 2;
        }else{
            //begin after play is called
            snd->limit_duration = limit;
            snd->limit_state=1;
        }
        return;
    }
    error(5);
}

//note: this is an internal command
void sndclose_now(int32 handle){
    snd_struct *snd = (snd_struct*)list_get(snd_handles, handle);
    if (snd->type==2){
        //remove OpenAL content
        if (snd->al_seq_left_source){
            alDeleteSources(1,&snd->al_seq_left_source); snd->al_seq_left_source=0;
            alDeleteBuffers(1,&snd->al_seq_left_buffer); snd->al_seq_left_buffer=0;
        }
        if (snd->al_seq_right_source){
            alDeleteSources(1,&snd->al_seq_right_source); snd->al_seq_right_source=0;
            alDeleteBuffers(1,&snd->al_seq_right_buffer); snd->al_seq_right_buffer=0;
        }
        //remove sound handle
        list_remove(snd_handles,handle);

        //remove seq
        if (snd->seq->references > 1){
            snd->seq->references--;
        }else{
            if (snd->seq->data) free(snd->seq->data);
            if (snd->seq->data_left != snd->seq->data) free(snd->seq->data_left);
            if (snd->seq->data_right) free(snd->seq->data_right);
            list_remove(snd_sequences, list_get_index(snd_sequences, snd->seq));
        }
    }//2

    if (snd->type==1){
        list_remove(snd_handles,handle);
    }

}//sndclose_now

void sub__sndclose(int32 handle){
    if (new_error) return;
    sndsetup();
    if (handle==0) return;//default response
    snd_struct *snd = (snd_struct*)list_get(snd_handles, handle);
    if (!snd || snd->internal) {
        error(5);
        return;
    }
    sndupdate(snd);
    snd->internal = 1;//switch to internal, no more commands related to this sound can be accepted
    if (snd->type == 2){
        if (snd->state==SND_STATE_PLAYING){
            snd->close=1;//close when finished playing
        }else{
            sndclose_now(handle);
        }
        return;
    }
    snd->close=1;//raw
    snd->raw_close_time=GetTicks();

    if (snd->lock_id){
        free_mem_lock((mem_lock*)snd->lock_offset);//untag
    }
}//sndclose

//"macros"

void sub__sndplaycopy(int32 handle,double volume,int32 passed){
    if (new_error) return;
    sndsetup();
    int32 handle2;
    handle2=func__sndcopy(handle);
    if (!handle2) return;//an error has already happened
    if (passed){
        sub__sndvol(handle2,volume);
        if (sub__sndvol_error){
            sub__sndclose(handle2);
            return;
        }
    }
    sub__sndplay(handle2);
    sub__sndclose(handle2);
}



//uint8 *soundwave(double frequency,double length,double volume,double fadein,double fadeout,uint8 *data);
//uint8 *soundwavesilence(double length,uint8 *data);

int32 func_play(int32 ignore){
    return 0;
}

/*
Formats:
A[#|+|-][0-64]
0-64 is like temp. Lnumber, 0 is whatever the current default is
 */
void sub_play(qbs *str){
    sndsetup();
    static uint8 *b,*wave,*wave2,*wave3;
    static double d;
    static int32 i,bytes_left,a,x,x2,x3,x4,x5,wave_bytes,wave_base;
    static int32 o=4;
    static double t=120;//quarter notes per minute (120/60=2 per second)
    static double l=4;
    static double pause=1.0/8.0;//ML 0.0, MN 1.0/8.0, MS 1.0/4.0
    static double length,length2;//derived from l and t
    static double frequency;
    static double mb=0;
    static double v=50;

    static int32 n;//the semitone-intervaled note to be played
    static int32 n_changed;//+,#,- applied?
    static int64 number;
    static int32 number_entered;
    static int32 followup;//1=play note
    static int32 playit;
    static uint32 handle=NULL;
    static int32 fullstops=0;
    b=str->chr;
    bytes_left=str->len;
    wave=NULL;
    wave_bytes=0;
    n_changed=0;
    n=0;
    number_entered=0;
    number=0;
    followup=0;
    length=1.0/(t/60.0)*(4.0/l);
    playit=0;
    wave_base=0;//point at which new sounds will be inserted

next_byte:
    if ((bytes_left--)||followup){

        if (bytes_left<0){i=32; goto follow_up;}

        i=*b++;
        if (i==32) goto next_byte;
        if (i>=97&&i<=122) a=i-32; else a=i;

        if (i==61){//= (+VARPTR$)
            if (fullstops){error(5); return;}
            if (number_entered){error(5); return;}
            number_entered=2;
            //VARPTR$ reference
            /*
               'BYTE=1
               'INTEGER=2
               'STRING=3 SUB-STRINGS must use "X"+VARPTR$(string$)
               'SINGLE=4
               'INT64=5
               'FLOAT=6
               'DOUBLE=8
               'LONG=20
               'BIT=64+n
             */
            if (bytes_left<3){error(5); return;}
            i=*b++; bytes_left--;//read type byte
            x=*(uint16*)b; b+=2; bytes_left-=2;//read offset within DBLOCK
            //note: allowable _BIT type variables in VARPTR$ are all at a byte offset and are all
            //      padded until the next byte
            d=0;
            switch(i){
                case 1:
                    d=*(char*)(dblock+x);
                    break;
                case (1+128):
                    d=*(uint8*)(dblock+x);
                    break;
                case 2:
                    d=*(int16*)(dblock+x);
                    break;
                case (2+128):
                    d=*(uint16*)(dblock+x);
                    break;
                case 4:
                    d=*(float*)(dblock+x);
                    break;
                case 5:
                    d=*(int64*)(dblock+x);
                    break;
                case (5+128):
                    d=*(int64*)(dblock+x); //unsigned conversion is unsupported!
                    break;
                case 6:
                    d=*(long double*)(dblock+x);
                    break;
                case 8:
                    d=*(double*)(dblock+x);
                    break;
                case 20:
                    d=*(int32*)(dblock+x);
                    break;
                case (20+128):
                    d=*(uint32*)(dblock+x);
                    break;
                default:
                    //bit type?
                    if ((i&64)==0){error(5); return;}
                    x2=i&63;
                    if (x2>56){error(5); return;}//valid number of bits?
                    //create a mask
                    static int64 i64num,mask,i64x;
                    mask=(((int64)1)<<x2)-1;
                    i64num=(*(int64*)(dblock+x))&mask;
                    //signed?
                    if (i&128){
                        mask=((int64)1)<<(x2-1);
                        if (i64num&mask){//top bit on?
                            mask=-1; mask<<=x2; i64num+=mask;
                        }
                    }//signed
                    d=i64num;
            }
            if (d>2147483647.0||d<-2147483648.0){error(5); return;}//out of range value!
            number=qbr_double_to_long(d);
            goto next_byte;
        }

        //read in a number
        if ((i>=48)&&(i<=57)){
            if (fullstops||(number_entered==2)){error(5); return;}
            if (!number_entered){number=0; number_entered=1;}
            number=number*10+i-48;
            goto next_byte;
        }

        //read fullstops
        if (i==46){
            if (followup!=7&&followup!=1&&followup!=4){error(5); return;}
            fullstops++;
            goto next_byte;
        }

follow_up:

        if (followup==8){//V...
            if (!number_entered){error(5); return;}
            number_entered=0;
            if (number>100){error(5); return;}
            v=number;
            followup=0; if (bytes_left<0) goto done;
        }//8

        if (followup==7){//P...
            if (number_entered){
                number_entered=0;
                if (number<1||number>64){error(5); return;}
                length2=1.0/(t/60.0)*(4.0/((double)number));
            }else{
                length2=length;
            }
            d=length2; for (x=1;x<=fullstops;x++){d/=2.0; length2=length2+d;} fullstops=0;

            soundwave_bytes=wavesize(length2);
            if (!wave){
                //create buffer
                wave=(uint8*)calloc(soundwave_bytes,1); wave_bytes=soundwave_bytes;
                wave_base=0;
            }else{
                //increase buffer?
                if ((wave_base+soundwave_bytes)>wave_bytes){
                    wave=(uint8*)realloc(wave,wave_base+soundwave_bytes);
                    memset(wave+wave_base,0,wave_base+soundwave_bytes-wave_bytes);
                    wave_bytes=wave_base+soundwave_bytes;
                }
            }
            if (i!=44){
                wave_base+=soundwave_bytes;
            }

            playit=1;
            followup=0;
            if (i==44) goto next_byte;
            if (bytes_left<0) goto done;
        }//7

        if (followup==6){//T...
            if (!number_entered){error(5); return;}
            number_entered=0;
            if (number<32||number>255){number=120;}
            t=number;
            length=1.0/(t/60.0)*(4.0/l);
            followup=0; if (bytes_left<0) goto done;
        }//6

        if (followup==5){//M...
            if (number_entered){error(5); return;}
            switch(a){
                case 76://L
                    pause=0;
                    break;
                case 78://N
                    pause=1.0/8.0;
                    break;
                case 83://S
                    pause=1.0/4.0;
                    break;

                case 66://MB
                    if (!mb){
                        mb=1;
                        if (playit){
                            playit=0;
                            qb64_internal_sndraw(wave,wave_bytes,1);
                        }
                        wave=NULL;
                    }
                    break;
                case 70://MF
                    if (mb){
                        mb=0;
                        //preceding MB content incorporated into MF block
                    }
                    break;
                default:
                    error(5); return;
            }
            followup=0; goto next_byte;
        }//5

        if (followup==4){//N...
            if (!number_entered){error(5); return;}
            number_entered=0;
            if (number>84){error(5); return;}
            n=-33+number;
            goto followup1;
            followup=0; if (bytes_left<0) goto done;
        }//4

        if (followup==3){//O...
            if (!number_entered){error(5); return;}
            number_entered=0;
            if (number>6){error(5); return;}
            o=number;
            followup=0; if (bytes_left<0) goto done;
        }//3

        if (followup==2){//L...
            if (!number_entered){error(5); return;}
            number_entered=0;
            if (number<1||number>64){error(5); return;}
            l=number;
            length=1.0/(t/60.0)*(4.0/l);
            followup=0; if (bytes_left<0) goto done;
        }//2

        if (followup==1){//A-G...
            if (i==45){//-
                if (n_changed||number_entered){error(5); return;}
                n_changed=1; n--;
                goto next_byte;
            }
            if (i==43||i==35){//+,#
                if (n_changed||number_entered){error(5); return;}
                n_changed=1; n++;
                goto next_byte;
            }
followup1:
            if (number_entered){
                number_entered=0;
                if (number<0||number>64){error(5); return;}
                if (!number) length2=length; else length2=1.0/(t/60.0)*(4.0/((double)number));
            }else{
                length2=length;
            }//number_entered
            d=length2; for (x=1;x<=fullstops;x++){d/=2.0; length2=length2+d;} fullstops=0;
            //frequency=(2^(note/12))*440
            frequency=pow(2.0,((double)n)/12.0)*440.0;

            //create wave
            wave2=soundwave(frequency,length2*(1.0-pause),v/100.0,NULL,NULL);
            if (pause>0){
                wave2=(uint8*)realloc(wave2,soundwave_bytes+wavesize(length2*pause));
                memset(wave2+soundwave_bytes,0,wavesize(length2*pause));
                soundwave_bytes+=wavesize(length2*pause);
            }

            if (!wave){
                //adopt buffer
                wave=wave2; wave_bytes=soundwave_bytes;
                wave_base=0;
            }else{
                //mix required?
                if (wave_base==wave_bytes) x=0; else x=1;
                //increase buffer?
                if ((wave_base+soundwave_bytes)>wave_bytes){
                    wave=(uint8*)realloc(wave,wave_base+soundwave_bytes);
                    memset(wave+wave_base,0,wave_base+soundwave_bytes-wave_bytes);
                    wave_bytes=wave_base+soundwave_bytes;
                }
                //mix or copy
                if (x){
                    //mix
                    static int16 *sp,*sp2;
                    sp=(int16*)(wave+wave_base);
                    sp2=(int16*)wave2;
                    x2=soundwave_bytes/2;
                    for (x=0;x<x2;x++){
                        x3=*sp2++;
                        x4=*sp;
                        x4+=x3;
                        if (x4>32767) x4=32767;
                        if (x4<-32767) x4=-32767;
                        *sp++=x4;
                    }//x 
                }else{
                    //copy
                    memcpy(wave+wave_base,wave2,soundwave_bytes);  
                }//x
                free(wave2);
            }
            if (i!=44){
                wave_base+=soundwave_bytes;
            }

            playit=1;
            n_changed=0;
            followup=0; 
            if (i==44) goto next_byte;
            if (bytes_left<0) goto done;
        }//1

        if (a>=65&&a<=71){
            //modify a to represent a semitonal note (n) interval
            switch(a){
                //[c][ ][d][ ][e][f][ ][g][ ][a][ ][b]
                // 0  1  2  3  4  5  6  7  8  9  0  1
                case 65: n=9; break;
                case 66: n=11; break;
                case 67: n=0; break;
                case 68: n=2; break;
                case 69: n=4; break;
                case 70: n=5; break;
                case 71: n=7; break;
            }
            n=n+(o-2)*12-9;
            followup=1;
            goto next_byte;
        }//a

        if (a==76){//L
            followup=2;
            goto next_byte;
        }

        if (a==77){//M
            followup=5;
            goto next_byte;
        }

        if (a==78){//N
            followup=4;
            goto next_byte;
        }

        if (a==79){//O
            followup=3;
            goto next_byte;
        }

        if (a==84){//T
            followup=6;
            goto next_byte;
        }

        if (a==60){//<
            o--; if (o<0) o=0;
            goto next_byte;
        }

        if (a==62){//>
            o++; if (o>6) o=6;
            goto next_byte;
        }

        if (a==80){//P
            followup=7;
            goto next_byte;
        }

        if (a==86){//V
            followup=8;
            goto next_byte;
        }

        error(5); return;
    }//bytes_left
done:
    if (number_entered||followup){error(5); return;}//unhandled data

    if (playit){
        if (mb){
            qb64_internal_sndraw(wave,wave_bytes,0);
        }else{
            qb64_internal_sndraw(wave,wave_bytes,1);
        }
    }//playit

}

int32 func__sndrate(){
    return snd_frequency;
}

void qb64_generatesound(double f,double l,uint8 block){
    sndsetup();
    static uint8* data;
    data=soundwave(f,l,1,0,0);
    qb64_internal_sndraw(data,soundwave_bytes,block);
}



void qb64_internal_sndraw(uint8* data,int32 bytes,int32 block){//data required in 16bit stereo at native frequency, data is freed
    sndsetup();
    static int32 i;
    if (qb64_internal_sndraw_handle==0){
        qb64_internal_sndraw_handle=func__sndopenraw();
        qb64_internal_sndraw_prepad=1;
    }


    int64 buffered_ms;
    if (block){
        buffered_ms=func__sndrawlen(qb64_internal_sndraw_handle,1)*1000.0;
        buffered_ms=((double)buffered_ms)*0.95;//take 95% of actual length to allow time for processing of new content
        buffered_ms-=250;//allow for latency (call frequency and pre/post pad)
        if (buffered_ms<0) buffered_ms=0;
    }

    if (qb64_internal_sndraw_prepad){
        qb64_internal_sndraw_prepad=0;
        //pad initial buffer so that first sound is played immediately
        static int32 snd_buffer_size_samples;
        snd_buffer_size_samples=snd_buffer_size/2/2;
        static int32 n;
        n=snd_buffer_size_samples-(bytes/2/2);
        if (n>0){
            for (i=0;i<n;i++){
                sub__sndraw(0,0,qb64_internal_sndraw_handle,2);
            }
        }
    }
    //move data into sndraw handle
    for (i=0;i<bytes;i+=4){
        sub__sndraw( (float)((int16*)(data+i))[0]/32768.0 ,(float)((int16*)(data+i))[1]/32768.0,qb64_internal_sndraw_handle,1+2);
    }
    qb64_internal_sndraw_postpad=1;
    free(data);//free the sound data

    if (block){
        int64 length_ms;
        length_ms=(((bytes/2/2)*1000)/snd_frequency);//length in ms
        length_ms=((double)length_ms)*0.95;//take 95% of actual length to allow time for processing of new content
        length_ms-=250;//allow for latency (call frequency and pre/post pad)
        if (length_ms>0){
            sub__delay(((double)length_ms+(double)buffered_ms)/1000.0);
        }
    }

}


double func__sndrawlen(int32 handle,int32 passed){
    if (passed){
        if (handle==0) return 0;
    }else{
        if (!snd_raw_channel) return 0;
        handle=snd_raw_channel;
    }
    static snd_struct *snd; snd=(snd_struct*)list_get(snd_handles,handle);
    if (!snd) goto error;
    if (snd->internal) goto error;
    if (snd->type!=1) goto error;
    if (!snd->stream_buffer_start) return 0;
    //count buffered source buffers
    static int32 source_buffers;
    source_buffers=0;
    static int32 i;
    i=snd->stream_buffer_start;
    while(i!=snd->stream_buffer_next){
        source_buffers++; i++; if (i>snd->stream_buffer_last) i=1;
    }
    //count dest buffers
    static int32 dest_buffers;
    dest_buffers=0;
    for (i=0;i<=3;i++){
        if (snd->al_buffer_state[i]==1) dest_buffers++;
    }

	static double result;
	result = ((double)((dest_buffers+source_buffers)*(snd_buffer_size/2/2)))/(double)snd_frequency;
	if (result < .375) result = 0; //hack to reenable _SNDRAWLEN, which gets stuck at .3715192763764172
    return result;

error:
    error(5);
    return 0;
}

void sub__sndrawdone(int32 handle,int32 passed){
    if (passed){
        if (handle==0) return;
    }else{
        if (!snd_raw_channel) return;
        handle=snd_raw_channel;
    }
    static snd_struct *snd; snd=(snd_struct*)list_get(snd_handles,handle);
    if (!snd) goto error;
    if (snd->internal) goto error;
    if (snd->type!=1) goto error;
    if (snd->buffer_size>0){//partial size
        if (!qb64_sndraw_lock){//lock (or skip)
            qb64_sndraw_lock=1;
            while (snd->buffer_size<snd_buffer_size){
                *(int16*)(snd->buffer+snd->buffer_size)=0;
                snd->buffer_size+=2;
                *(int16*)(snd->buffer+snd->buffer_size)=0;
                snd->buffer_size+=2;
            }
            //detach buffer
            static uint8 *buffer;
            buffer=snd->buffer;
            //create new buffer
            snd->buffer=(uint8*)calloc(snd_buffer_size,1);
            snd->buffer_size=0;
            //attach detached buffer to stream (or discard it)
            static int32 p,p2;
            p=snd->stream_buffer_next; p2=p+1; if (p2>snd->stream_buffer_last) p2=1;
            if (p2==snd->stream_buffer_start){
                free(buffer); //all buffers are full! (quietly ignore this buffer)
            }else{
                snd->stream_buffer[p]=(ptrszint)buffer;
                snd->stream_buffer_next=p2;
                if (!snd->stream_buffer_start) snd->stream_buffer_start=1;
            }
            //unlock
            qb64_sndraw_lock=0;
        }//lock (or skip)
    }//partial size
    return;

error:
    error(5);
    return;
}

#endif
