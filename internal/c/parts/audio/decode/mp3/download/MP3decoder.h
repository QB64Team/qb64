//
// MP3decoder.h: interface for the MP3decoder class.
//
//////////////////////////////////////////////////////////////////////

class MP3decoder
{
public:

	MP3decoder();
	~MP3decoder();

	bool _stdcall	OpenStream(char* pcfilename,int *isample,int *ichannel,int *ibyte,void * ptSettings, int *bufsizebyte);
	int _stdcall	Decode(BYTE* pbout);
	bool _stdcall	CloseStream();
	DWORD _stdcall	GetTotalTime(char * pcfilename);			
	DWORD _stdcall	GetPos( void );			              // 1/1000 sec
	bool _stdcall	SetPos( DWORD aiPosMS );		      // 1/1000 sec

private:
	DWORD m_pos;
	struct mpstr mp;
	char buf[16384];
	char m_pbRestBuf[8192];
	char out[8192];
	int m_outsize;
	FILE * fin;

	DWORD   m_dwBufSize;
	DWORD   m_dwRestBufSize;

	const static DWORD BUFFER_SIZE  = 16384;
	VBRTAGDATA vbrtag;
	int m_length;
	DWORD m_nInFileSize;
	int m_nbytes;
	int m_hasVbrtag;
	
	bool m_seeked;	
	bool m_bfeof;
};

#endif // !defined(AFX_MP3DECODER_H__6A643246_395C_487E_BE15_CC621BBA084A__INCLUDED_)
