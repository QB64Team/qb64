#ifndef DEPENDENCY_AUDIO_DECODE_MP3
//Stubs:
//(none required)
#else

extern "C" {
#ifdef QB64_BACKSLASH_FILESYSTEM
 #include "src\\minimp3.h"
#else
 #include "src/minimp3.h"
#endif
}

snd_sequence_struct *snd_decode_mp3(uint8 *buffer,int32 bytes){

mp3_decoder_t mp3;
mp3_info_t info;
memset(&info,0,sizeof(mp3_info_t));

unsigned char *stream_pos;
int bytes_left;
int bytes_read;

int sample_buffer_allocated_bytes=2000000;
int16* sample_buffer=(int16*)malloc(2000000);
int16* sample_buffer_offset;

bytes_left=bytes;
stream_pos=(unsigned char*)buffer;

mp3 = mp3_create();

int bytes_out=0;

int firstTry=1;

sample_buffer_offset=sample_buffer;
mp3getmore:
bytes_read = mp3_decode((void**)mp3, stream_pos, bytes_left, sample_buffer_offset, &info);
if (firstTry==1 && info.audio_bytes<=0){
	free(sample_buffer);
	return NULL;
}
firstTry=0;
bytes_left-=bytes_read;
stream_pos+=bytes_read;
sample_buffer_offset=(int16*)(((uint8*)sample_buffer_offset)+info.audio_bytes);
bytes_out+=info.audio_bytes;

if (bytes_out+1000000>sample_buffer_allocated_bytes){
	sample_buffer_allocated_bytes+=1000000;
	sample_buffer=(int16*)realloc(sample_buffer,sample_buffer_allocated_bytes);
	sample_buffer_offset=(int16*)(((uint8*)sample_buffer)+bytes_out);
}

if (bytes_left>0 && bytes_read!=0) goto mp3getmore;

//attach bufout to new sequence
static int32 seq_handle; seq_handle=list_add(snd_sequences);
static snd_sequence_struct *seq; seq=(snd_sequence_struct*)list_get(snd_sequences,seq_handle);
memset(seq,0,sizeof(snd_sequence_struct));
seq->references=1;
seq->data=(uint16*)sample_buffer;
seq->data_size=bytes_out;
seq->channels=info.channels;
seq->endian=0;//native
seq->is_unsigned=0;
seq->sample_rate=info.sample_rate;
seq->bits_per_sample=16;

return seq;

}

#endif

