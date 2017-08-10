#ifndef DEPENDENCY_AUDIO_DECODE_OGG
//Stubs:
//(none required)
#else

#ifdef QB64_BACKSLASH_FILESYSTEM
 #define STB_VORBIS_HEADER_ONLY
 #include "src\\stb_vorbis.c"
#else
 #define STB_VORBIS_HEADER_ONLY
 #include "src/stb_vorbis.c"
#endif

snd_sequence_struct *snd_decode_ogg(uint8 *buffer,int32 bytes){
  
  int result;
  int channels;
  int samplerate;
  short *out;
  result=stb_vorbis_decode_memory((unsigned char *)buffer,bytes,&channels,&samplerate,&out);
  if (result==-1) return NULL;
  //extern int stb_vorbis_decode_memory(unsigned char *mem, int len, int *channels, int *sample_rate, short **output);
  // decode an entire file and output the data interleaved into a malloc()ed
  // buffer stored in *output. The return value is the number of samples
  // decoded, or -1 if the file could not be opened or was not an ogg vorbis file.
  // When you're done with it, just free() the pointer returned in *output.
  
  //attach to new sequence
  static int32 seq_handle; seq_handle=list_add(snd_sequences);
  static snd_sequence_struct *seq; seq=(snd_sequence_struct*)list_get(snd_sequences,seq_handle);
  memset(seq,0,sizeof(snd_sequence_struct));
  seq->references=1;
  
  seq->channels=channels;
  seq->sample_rate=samplerate;
  seq->bits_per_sample=16;
  seq->endian=0;//native
  seq->is_unsigned=0;
  seq->data=(uint16*)out;
  seq->data_size=result*2*channels;
  
  
  return seq; 
}




#endif

