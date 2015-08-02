//
//
// MP3decoder.cpp: implementation of the MP3decoder class.
//
//////////////////////////////////////////////////////////////////////

#include "mpglib\mpg123.h"
#include "mpglib\mpglib.h"
#include "MP3decoder.h"

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

MP3decoder::MP3decoder()
{
}

MP3decoder::~MP3decoder()
{
}

bool MP3decoder::OpenStream(char* pcfilename,int *isample,int *ichannel,int *ibyte,void * ptSettings, int *bufsizebyte)
{
	unsigned char vbrbuf[VBRHEADERSIZE+36];

	m_pos = 0;
	m_outsize = 0;
	fin = fopen( pcfilename, "rb" );
	if( !fin )
		return 0;

	fseek(fin,0,SEEK_END);
	m_nInFileSize = ftell(fin);
	fseek(fin, 0, SEEK_SET);

	InitMP3(&mp);

	int nlen = 0;

	nlen = fread(buf, sizeof(BYTE), 16384, fin);
	if( nlen < 16384)
		return 0;

	int ret = decodeMP3(&mp,buf,nlen,out,8192,&m_outsize);				//find good data
	if( ret != MP3_OK )
		return 0;

	m_pos += m_outsize;
/*	if( ret != MP3_OK ){
		while( ret != MP3_OK ){
			ret = decodeMP3(&mp,NULL,0,out,8192,&m_outsize);
			m_pos += m_outsize;
			ret = decodeMP3(&mp,NULL,0,out,8192,&m_outsize);
			m_pos += m_outsize;
			if( ret == MP3_NEED_MORE )										//tried 16384 bytes, so failed
				return 0;
		}
	}*/
	
	*bufsizebyte = BUFFER_SIZE; 
	*isample = freqs[mp.fr.sampling_frequency];
	*ibyte = 2;
	*ichannel = mp.fr.stereo; 

	memcpy(vbrbuf, mp.tail->pnt + mp.ndatabegin, VBRHEADERSIZE+36);
	if (GetVbrTag(&vbrtag,(BYTE*)vbrbuf)) {
		if( vbrtag.frames < 1 || vbrtag.bytes < 1 )
			return 0;
		int cur_bitrate = (int)(vbrtag.bytes*8/(vbrtag.frames*576.0*(mp.fr.lsf?1:2)/freqs[mp.fr.sampling_frequency]));
		m_length = vbrtag.frames*576.0*(mp.fr.lsf?1:2)/freqs[mp.fr.sampling_frequency]*1000;
		m_nbytes = vbrtag.bytes;
		m_hasVbrtag = 1;
	} else {
		double bpf = 0, tpf = 0;

		bpf = compute_bpf(&mp.fr);
		tpf = compute_tpf(&mp.fr);

		m_length = (DWORD)((double)(m_nInFileSize)/bpf*tpf)*1000;
		m_hasVbrtag = 0;
	}

	fseek(fin,16384,SEEK_SET);

	m_dwRestBufSize = 0;
	m_seeked = false;
	m_bfeof = false;

	return 1;
}

int MP3decoder::Decode(BYTE* pbout)
{
	DWORD nTotalSize = 0;
	int ret;

	if( m_bfeof )
		return 0;

	do
	{
		if( m_dwRestBufSize ){
		  CopyMemory( pbout, m_pbRestBuf, m_dwRestBufSize );
		  nTotalSize += m_dwRestBufSize;
		  m_dwRestBufSize = 0;
		}

		if( m_outsize ){
			if( nTotalSize + m_outsize > BUFFER_SIZE ){
				DWORD nRest = BUFFER_SIZE - nTotalSize;
				CopyMemory( pbout + nTotalSize, out, nRest );
				CopyMemory( m_pbRestBuf, out + nRest, m_outsize - nRest);
				nTotalSize += nRest;
				m_dwRestBufSize = m_outsize - nRest;
				m_outsize = 0;
				break;
			}else{
				CopyMemory( pbout + nTotalSize, out, m_outsize );
				nTotalSize += m_outsize;
				m_outsize = 0;
				if( nTotalSize == BUFFER_SIZE )
					break;
			}
		}

		ret = decodeMP3(&mp,NULL,0,out,8192,&m_outsize);
		m_pos += m_outsize;

		if( ret != MP3_OK ){
			if( feof( fin ) ) {
				m_bfeof = true;
				break;
			}
			int nlen = fread(buf, sizeof(BYTE), 16384, fin);
			ret = decodeMP3(&mp,buf,nlen,out,8192,&m_outsize);
			m_pos += m_outsize;
		}
		
		if(m_seeked){
			m_seeked = false;
			int nlen = fread(buf, sizeof(BYTE), 16384, fin);
			if( feof( fin ) )
				break;
			ret = decodeMP3(&mp,buf,nlen,out,8192,&m_outsize);
			m_pos += m_outsize;
			nTotalSize = 0;	
		}


	}	while( 1 );

	return nTotalSize;
}

bool MP3decoder::CloseStream()
{ 
	ExitMP3(&mp);
	return 1;

}

DWORD MP3decoder::GetTotalTime(char * pcfilename)			// 1/1000 sec
{
	int ntmp = 0;

	if(!OpenStream(pcfilename, &ntmp, &ntmp, &ntmp, NULL, &ntmp))
		return 0;
	CloseStream();
	return m_length;
}


DWORD _stdcall	MP3decoder::GetPos( void )
{
	return double(m_pos) / double(freqs[mp.fr.sampling_frequency]) / double(mp.fr.stereo) / 2.0 * 1000.0;
}

bool _stdcall	MP3decoder::SetPos( DWORD aiPosMS )
{
	int offs = 0;

	if (m_hasVbrtag) {
		offs = SeekPoint(vbrtag.toc,m_nInFileSize,(double)aiPosMS*100/(double)m_length);

		fseek(fin, offs, SEEK_SET);

		m_pos = (double)aiPosMS / 1000.0 * double(freqs[mp.fr.sampling_frequency]) * double(mp.fr.stereo) * 2.0;

	} else {
		fseek(fin, double(m_nInFileSize) * ((double)aiPosMS / (double)m_length), SEEK_SET);
		m_pos = (double)aiPosMS / 1000.0 * double(freqs[mp.fr.sampling_frequency]) * double(mp.fr.stereo) * 2.0;
	}

	m_seeked = true;

	return true;
}