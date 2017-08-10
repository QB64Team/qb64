#ifndef DEPENDENCY_AUDIO_DECODE_WAV
//Stubs:
//(none required)
#else

snd_sequence_struct *snd_decode_wav(uint8 *buffer,int32 bytes){
//ref: https://ccrma.stanford.edu/courses/422/projects/WaveFormat/
if (bytes<44) return NULL;
if ((*(uint32*)&buffer[12])!=0x20746d66) return NULL;//"fmt "
if ((*(uint16*)&buffer[20])!=1) return NULL;//PCM = 1 (i.e. Linear quantization) Values other than 1 indicate some form of compression.

static int32 rif_type;
rif_type=0;
if ((*(uint32*)&buffer[0])==0x46464952) rif_type=1;//RIFF
//if ((*(uint32*)&buffer[0])==0x????????) rif_type=1;//RIFX (not supported yet)
if (rif_type==0) return NULL;

static int32 out_bytes;
static uint8 *bufout;

static int32 chunk1size;
chunk1size=*(uint32*)&buffer[16];
//qbs_print(qbs_str((int32)chunk1size),1);

//read next chunk
static uint32 chunk2name;
static int32 chunk2size;
skip_chunk:
if ((20+chunk1size)>=bytes) return NULL;//no more chunks!
chunk2name=*(uint32*)&buffer[20+chunk1size];
chunk2size=*(uint32*)&buffer[20+chunk1size+4];
if (chunk2name!=0x61746164){
chunk1size+=(8+chunk2size);
goto skip_chunk;//it's probably a "fact" chunk, pointless for PCM data
}

out_bytes=chunk2size;
bufout=(uint8*)malloc(out_bytes);
memcpy(bufout,buffer+20+chunk1size+8,out_bytes);

//qbs_print(qbs_str((int32)out_bytes),1);

//attach to new sequence
static int32 seq_handle; seq_handle=list_add(snd_sequences);
static snd_sequence_struct *seq; seq=(snd_sequence_struct*)list_get(snd_sequences,seq_handle);
memset(seq,0,sizeof(snd_sequence_struct));
seq->references=1;

seq->channels=*(uint16*)&buffer[22];
seq->sample_rate=*(uint32*)&buffer[24];
seq->bits_per_sample=*(uint16*)&buffer[34];
seq->endian=1;//little (Microsoft format)
seq->is_unsigned=0; if (seq->bits_per_sample==8) seq->is_unsigned=1;
seq->data=(uint16*)bufout;
seq->data_size=out_bytes;

//qbs_print(qbs_str((int32)seq->channels),1);
//qbs_print(qbs_str((int32)seq->sample_rate),1);
//qbs_print(qbs_str((int32)seq->bits_per_sample),1);

return seq;

}

#endif
