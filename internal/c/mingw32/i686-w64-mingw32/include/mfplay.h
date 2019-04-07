/**
 * This file has no copyright assigned and is placed in the Public Domain.
 * This file is part of the mingw-w64 runtime package.
 * No warranty is given; refer to the file DISCLAIMER.PD within this package.
 */
#ifndef _INC_MFPLAY
#define _INC_MFPLAY
#include <evr.h>

#if (WINVER >= 0x0601)

typedef enum _MFP_CREATION_OPTIONS {
  MFP_OPTION_NONE                             = 0,
  MFP_OPTION_FREE_THREADED_CALLBACK           = 0x00000001,
  MFP_OPTION_NO_MMCSS                         = 0x00000002,
  MFP_OPTION_NO_REMOTE_DESKTOP_OPTIMIZATION   = 0x00000004 
} _MFP_CREATION_OPTIONS;

typedef enum _MFP_MEDIAITEM_CHARACTERISTICS {
  MFP_MEDIAITEM_IS_LIVE         = 0x00000001,
  MFP_MEDIAITEM_CAN_SEEK        = 0x00000002,
  MFP_MEDIAITEM_CAN_PAUSE       = 0x00000004,
  MFP_MEDIAITEM_HAS_SLOW_SEEK   = 0x00000008 
} _MFP_MEDIAITEM_CHARACTERISTICS;

typedef enum _MFP_CREDENTIAL_FLAGS {
  MFP_CREDENTIAL_PROMPT           = 0x00000001,
  MFP_CREDENTIAL_SAVE             = 0x00000002,
  MFP_CREDENTIAL_DO_NOT_CACHE     = 0x00000004,
  MFP_CREDENTIAL_CLEAR_TEXT       = 0x00000008,
  MFP_CREDENTIAL_PROXY            = 0x00000010,
  MFP_CREDENTIAL_LOGGED_ON_USER   = 0x00000020 
} _MFP_CREDENTIAL_FLAGS;

typedef enum MFP_EVENT_TYPE {
  MFP_EVENT_TYPE_PLAY                      = 0,
  MFP_EVENT_TYPE_PAUSE                     = 1,
  MFP_EVENT_TYPE_STOP                      = 2,
  MFP_EVENT_TYPE_POSITION_SET              = 3,
  MFP_EVENT_TYPE_RATE_SET                  = 4,
  MFP_EVENT_TYPE_MEDIAITEM_CREATED         = 5,
  MFP_EVENT_TYPE_MEDIAITEM_SET             = 6,
  MFP_EVENT_TYPE_FRAME_STEP                = 7,
  MFP_EVENT_TYPE_MEDIAITEM_CLEARED         = 8,
  MFP_EVENT_TYPE_MF                        = 9,
  MFP_EVENT_TYPE_ERROR                     = 10,
  MFP_EVENT_TYPE_PLAYBACK_ENDED            = 11,
  MFP_EVENT_TYPE_ACQUIRE_USER_CREDENTIAL   = 12 
} MFP_EVENT_TYPE;

typedef enum MFP_MEDIAPLAYER_STATE {
  MFP_MEDIAPLAYER_STATE_EMPTY      = 0x00000000,
  MFP_MEDIAPLAYER_STATE_STOPPED    = 0x00000001,
  MFP_MEDIAPLAYER_STATE_PLAYING    = 0x00000002,
  MFP_MEDIAPLAYER_STATE_PAUSED     = 0x00000003,
  MFP_MEDIAPLAYER_STATE_SHUTDOWN   = 0x00000004 
} MFP_MEDIAPLAYER_STATE;

#ifdef __GNUC__
#warning COM interfaces layout in this header has not been verified.
#warning COM interfaces with incorrect layout may not work at all.
#warning IMFPMediaItem is unverified.
#endif

#undef  INTERFACE
#define INTERFACE IMFPMediaItem
DECLARE_INTERFACE_(IMFPMediaItem,IUnknown)
{
    BEGIN_INTERFACE

    /* IUnknown methods */
    STDMETHOD(QueryInterface)(THIS_ REFIID riid, void **ppvObject) PURE;
    STDMETHOD_(ULONG, AddRef)(THIS) PURE;
    STDMETHOD_(ULONG, Release)(THIS) PURE;

    /* IMFPMediaItem methods */
    STDMETHOD_(HRESULT,GetCharacteristics)(THIS_ MFP_MEDIAITEM_CHARACTERISTICS *pCharacteristics) PURE;
    STDMETHOD_(HRESULT,GetDuration)(THIS_ REFGUID guidPositionType,PROPVARIANT *pvDurationValue) PURE;
    STDMETHOD_(HRESULT,GetMediaPlayer)(THIS_ IMFPMediaPlayer **ppMediaPlayer) PURE;
    STDMETHOD_(HRESULT,GetMetadata)(THIS_ IPropertyStore **ppMetadataStore) PURE;
    STDMETHOD_(HRESULT,GetNumberOfStreams)(THIS_ DWORD *pdwStreamCount) PURE;
    STDMETHOD_(HRESULT,GetObject)(THIS_ IUnknown **ppIUnknown) PURE;
    STDMETHOD_(HRESULT,GetPresentationAttribute)(THIS_ REFGUID guidMFAttribute,PROPVARIANT *pvValue) PURE;
    STDMETHOD_(HRESULT,GetStartStopPosition)(THIS_ GUID *pguidStartPositionType,PROPVARIANT *pvStartValue,GUID *pguidStopPositionType,PROPVARIANT *pvStopValue) PURE;
    STDMETHOD_(HRESULT,GetStreamAttribute)(THIS_ DWORD dwStreamIndex,REFGUID guidMFAttribute,PROPVARIANT *pvValue) PURE;
    STDMETHOD_(HRESULT,GetStreamSelection)(THIS_ DWORD dwStreamIndex,WINBOOL *pfEnabled) PURE;
    STDMETHOD_(HRESULT,GetURL)(THIS_ LPWSTR *ppwszURL) PURE;
    STDMETHOD_(HRESULT,GetUserData)(THIS_ DWORD_PTR *pdwUserData) PURE;
    STDMETHOD_(HRESULT,HasAudio)(THIS_ WINBOOL *pfHasAudio,WINBOOL *pfSelected) PURE;
    STDMETHOD_(HRESULT,HasVideo)(THIS_ WINBOOL *pfHasVideo,WINBOOL *pfSelected) PURE;
    STDMETHOD_(HRESULT,IsProtected)(THIS_ WINBOOL *pfProtected) PURE;
    STDMETHOD_(HRESULT,SetStartStopPosition)(THIS_ const GUID *pguidStartPositionType,const PROPVARIANT *pvStartValue,const GUID *pguidStopPositionType,const PROPVARIANT *pvStopValue) PURE;
    STDMETHOD_(HRESULT,SetStreamSelection)(THIS_ DWORD dwStreamIndex,WINBOOL fEnabled) PURE;
    STDMETHOD_(HRESULT,SetStreamSink)(THIS_ DWORD dwStreamIndex,IUnknown *pMediaSink) PURE;
    STDMETHOD_(HRESULT,SetUserData)(THIS_ DWORD_PTR dwUserData) PURE;

    END_INTERFACE
};
#ifdef COBJMACROS
#define IMFPMediaItem_QueryInterface(This,riid,ppvObject) (This)->lpVtbl->QueryInterface(This,riid,ppvObject)
#define IMFPMediaItem_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IMFPMediaItem_Release(This) (This)->lpVtbl->Release(This)
#define IMFPMediaItem_GetCharacteristics(This,pCharacteristics) (This)->lpVtbl->GetCharacteristics(This,pCharacteristics)
#define IMFPMediaItem_GetDuration(This,guidPositionType,pvDurationValue) (This)->lpVtbl->GetDuration(This,guidPositionType,pvDurationValue)
#define IMFPMediaItem_GetMediaPlayer(This,ppMediaPlayer) (This)->lpVtbl->GetMediaPlayer(This,ppMediaPlayer)
#define IMFPMediaItem_GetMetadata(This,ppMetadataStore) (This)->lpVtbl->GetMetadata(This,ppMetadataStore)
#define IMFPMediaItem_GetNumberOfStreams(This,pdwStreamCount) (This)->lpVtbl->GetNumberOfStreams(This,pdwStreamCount)
#define IMFPMediaItem_GetObject(This,ppIUnknown) (This)->lpVtbl->GetObject(This,ppIUnknown)
#define IMFPMediaItem_GetPresentationAttribute(This,guidMFAttribute,pvValue) (This)->lpVtbl->GetPresentationAttribute(This,guidMFAttribute,pvValue)
#define IMFPMediaItem_GetStartStopPosition(This,pguidStartPositionType,pvStartValue,pguidStopPositionType,pvStopValue) (This)->lpVtbl->GetStartStopPosition(This,pguidStartPositionType,pvStartValue,pguidStopPositionType,pvStopValue)
#define IMFPMediaItem_GetStreamAttribute(This,dwStreamIndex,guidMFAttribute,pvValue) (This)->lpVtbl->GetStreamAttribute(This,dwStreamIndex,guidMFAttribute,pvValue)
#define IMFPMediaItem_GetStreamSelection(This,dwStreamIndex,pfEnabled) (This)->lpVtbl->GetStreamSelection(This,dwStreamIndex,pfEnabled)
#define IMFPMediaItem_GetURL(This,ppwszURL) (This)->lpVtbl->GetURL(This,ppwszURL)
#define IMFPMediaItem_GetUserData(This,pdwUserData) (This)->lpVtbl->GetUserData(This,pdwUserData)
#define IMFPMediaItem_HasAudio(This,pfHasAudio,pfSelected) (This)->lpVtbl->HasAudio(This,pfHasAudio,pfSelected)
#define IMFPMediaItem_HasVideo(This,pfHasVideo,pfSelected) (This)->lpVtbl->HasVideo(This,pfHasVideo,pfSelected)
#define IMFPMediaItem_IsProtected(This,pfProtected) (This)->lpVtbl->IsProtected(This,pfProtected)
#define IMFPMediaItem_SetStartStopPosition(This,pguidStartPositionType,pvStartValue,pguidStopPositionType,pvStopValue) (This)->lpVtbl->SetStartStopPosition(This,pguidStartPositionType,pvStartValue,pguidStopPositionType,pvStopValue)
#define IMFPMediaItem_SetStreamSelection(This,dwStreamIndex,fEnabled) (This)->lpVtbl->SetStreamSelection(This,dwStreamIndex,fEnabled)
#define IMFPMediaItem_SetStreamSink(This,dwStreamIndex,pMediaSink) (This)->lpVtbl->SetStreamSink(This,dwStreamIndex,pMediaSink)
#define IMFPMediaItem_SetUserData(This,dwUserData) (This)->lpVtbl->SetUserData(This,dwUserData)
#endif /*COBJMACROS*/

#ifdef __GNUC__
#warning COM interfaces layout in this header has not been verified.
#warning COM interfaces with incorrect layout may not work at all.
#warning IMFPMediaPlayer is unverified.
#endif

#undef  INTERFACE
#define INTERFACE IMFPMediaPlayer
DECLARE_INTERFACE_(IMFPMediaPlayer,IUnknown)
{
    BEGIN_INTERFACE

    /* IUnknown methods */
    STDMETHOD(QueryInterface)(THIS_ REFIID riid, void **ppvObject) PURE;
    STDMETHOD_(ULONG, AddRef)(THIS) PURE;
    STDMETHOD_(ULONG, Release)(THIS) PURE;

    /* IMFPMediaPlayer methods */
    STDMETHOD_(HRESULT,ClearMediaItem)(THIS) PURE;
    STDMETHOD_(HRESULT,CreateMediaItemFromObject)(THIS_ IUnknown *pIUnknownObj,BOOL fSync,DWORD_PTR dwUserData,IMFPMediaItem **ppMediaItem) PURE;
    STDMETHOD_(HRESULT,CreateMediaItemFromURL)(THIS_ LPCWSTR pwszURL,BOOL fSync,DWORD_PTR dwUserData,IMFPMediaItem **ppMediaItem) PURE;
    STDMETHOD_(HRESULT,FrameStep)(THIS) PURE;
    STDMETHOD_(HRESULT,GetAspectRatioMode)(THIS_ DWORD *pdwAspectRatioMode) PURE;
    STDMETHOD_(HRESULT,GetBalance)(THIS_ float *pflBalance) PURE;
    STDMETHOD_(HRESULT,GetBorderColor)(THIS_ COLORREF *pClr) PURE;
    STDMETHOD_(HRESULT,GetDuration)(THIS_ REFGUID guidPositionType,PROPVARIANT *pvDurationValue) PURE;
    STDMETHOD_(HRESULT,GetIdealVideoSize)(THIS_ SIZE *pszMin,SIZE *pszMax) PURE;
    STDMETHOD_(HRESULT,GetMediaItem)(THIS_ IMFPMediaItem **ppIMFPMediaItem) PURE;
    STDMETHOD_(HRESULT,GetMute)(THIS_ WINBOOL *pfMute) PURE;
    STDMETHOD_(HRESULT,GetNativeVideoSize)(THIS_ SIZE *pszVideo,SIZE *pszARVideo) PURE;
    STDMETHOD_(HRESULT,GetPosition)(THIS_ REFGUID guidPositionType,PROPVARIANT *pvPositionValue) PURE;
    STDMETHOD_(HRESULT,GetRate)(THIS_ float *pflRate) PURE;
    STDMETHOD_(HRESULT,GetState)(THIS_ MFP_MEDIAPLAYER_STATE *peState) PURE;
    STDMETHOD_(HRESULT,GetSupportedRates)(THIS_ WINBOOL fForwardDirection,float *pflSlowestRate,float *pflFastestRate) PURE;
    STDMETHOD_(HRESULT,GetVideoSourceRect)(THIS_ MFVideoNormalizedRect *pnrcSource) PURE;
    STDMETHOD_(HRESULT,GetVideoWindow)(THIS_ HWND *phwndVideo) PURE;
    STDMETHOD_(HRESULT,GetVolume)(THIS_ float *pflVolume) PURE;
    STDMETHOD_(HRESULT,InsertEffect)(THIS_ IUnknown *pEffect,WINBOOL fOptional) PURE;
    STDMETHOD_(HRESULT,Pause)(THIS) PURE;
    STDMETHOD_(HRESULT,Play)(THIS) PURE;
    STDMETHOD_(HRESULT,RemoveAllEffects)(THIS) PURE;
    STDMETHOD_(HRESULT,RemoveEffect)(THIS_ IUnknown *pEffect) PURE;
    STDMETHOD(SetAspectRatioMode)(THIS_ DWORD dwAspectRatioMode) PURE;
    STDMETHOD_(HRESULT,SetBalance)(THIS_ float flBalance) PURE;
    STDMETHOD_(HRESULT,SetBorderColor)(THIS_ COLORREF Clr) PURE;
    STDMETHOD_(HRESULT,SetMediaItem)(THIS_ IMFPMediaItem *pIMFPMediaItem) PURE;
    STDMETHOD_(HRESULT,SetMute)(THIS_ WINBOOL fMute) PURE;
    STDMETHOD_(HRESULT,SetPosition)(THIS_ REFGUID guidPositionType,const PROPVARIANT *pvPositionValue) PURE;
    STDMETHOD_(HRESULT,SetRate)(THIS_ float flRate) PURE;
    STDMETHOD_(HRESULT,SetVideoSourceRect)(THIS_ const MFVideoNormalizedRect *pnrcSource) PURE;
    STDMETHOD_(HRESULT,SetVolume)(THIS_ float flVolume) PURE;
    STDMETHOD_(HRESULT,Shutdown)(THIS) PURE;
    STDMETHOD_(HRESULT,Stop)(THIS) PURE;
    STDMETHOD_(HRESULT,UpdateVideo)(THIS) PURE;

    END_INTERFACE
};
#ifdef COBJMACROS
#define IMFPMediaPlayer_QueryInterface(This,riid,ppvObject) (This)->lpVtbl->QueryInterface(This,riid,ppvObject)
#define IMFPMediaPlayer_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IMFPMediaPlayer_Release(This) (This)->lpVtbl->Release(This)
#define IMFPMediaPlayer_ClearMediaItem() (This)->lpVtbl->ClearMediaItem(This)
#define IMFPMediaPlayer_CreateMediaItemFromObject(This,pIUnknownObj,fSync,dwUserData,ppMediaItem) (This)->lpVtbl->CreateMediaItemFromObject(This,pIUnknownObj,fSync,dwUserData,ppMediaItem)
#define IMFPMediaPlayer_CreateMediaItemFromURL(This,pwszURL,fSync,dwUserData,ppMediaItem) (This)->lpVtbl->CreateMediaItemFromURL(This,pwszURL,fSync,dwUserData,ppMediaItem)
#define IMFPMediaPlayer_FrameStep() (This)->lpVtbl->FrameStep(This)
#define IMFPMediaPlayer_GetAspectRatioMode(This,pdwAspectRatioMode) (This)->lpVtbl->GetAspectRatioMode(This,pdwAspectRatioMode)
#define IMFPMediaPlayer_GetBalance(This,pflBalance) (This)->lpVtbl->GetBalance(This,pflBalance)
#define IMFPMediaPlayer_GetBorderColor(This,pClr) (This)->lpVtbl->GetBorderColor(This,pClr)
#define IMFPMediaPlayer_GetDuration(This,guidPositionType,pvDurationValue) (This)->lpVtbl->GetDuration(This,guidPositionType,pvDurationValue)
#define IMFPMediaPlayer_GetIdealVideoSize(This,pszMin,pszMax) (This)->lpVtbl->GetIdealVideoSize(This,pszMin,pszMax)
#define IMFPMediaPlayer_GetMediaItem(This,ppIMFPMediaItem) (This)->lpVtbl->GetMediaItem(This,ppIMFPMediaItem)
#define IMFPMediaPlayer_GetMute(This,pfMute) (This)->lpVtbl->GetMute(This,pfMute)
#define IMFPMediaPlayer_GetNativeVideoSize(This,pszVideo,pszARVideo) (This)->lpVtbl->GetNativeVideoSize(This,pszVideo,pszARVideo)
#define IMFPMediaPlayer_GetPosition(This,guidPositionType,pvPositionValue) (This)->lpVtbl->GetPosition(This,guidPositionType,pvPositionValue)
#define IMFPMediaPlayer_GetRate(This,pflRate) (This)->lpVtbl->GetRate(This,pflRate)
#define IMFPMediaPlayer_GetState(This,peState) (This)->lpVtbl->GetState(This,peState)
#define IMFPMediaPlayer_GetSupportedRates(This,fForwardDirection,pflSlowestRate,pflFastestRate) (This)->lpVtbl->GetSupportedRates(This,fForwardDirection,pflSlowestRate,pflFastestRate)
#define IMFPMediaPlayer_GetVideoSourceRect(This,pnrcSource) (This)->lpVtbl->GetVideoSourceRect(This,pnrcSource)
#define IMFPMediaPlayer_GetVideoWindow(This,phwndVideo) (This)->lpVtbl->GetVideoWindow(This,phwndVideo)
#define IMFPMediaPlayer_GetVolume(This,pflVolume) (This)->lpVtbl->GetVolume(This,pflVolume)
#define IMFPMediaPlayer_InsertEffect(This,pEffect,fOptional) (This)->lpVtbl->InsertEffect(This,pEffect,fOptional)
#define IMFPMediaPlayer_Pause() (This)->lpVtbl->Pause(This)
#define IMFPMediaPlayer_Play() (This)->lpVtbl->Play(This)
#define IMFPMediaPlayer_RemoveAllEffects() (This)->lpVtbl->RemoveAllEffects(This)
#define IMFPMediaPlayer_RemoveEffect(This,pEffect) (This)->lpVtbl->RemoveEffect(This,pEffect)
#define IMFPMediaPlayer_SetAspectRatioMode(This,dwAspectRatioMode) (This)->lpVtbl->SetAspectRatioMode(This,dwAspectRatioMode)
#define IMFPMediaPlayer_SetBalance(This,flBalance) (This)->lpVtbl->SetBalance(This,flBalance)
#define IMFPMediaPlayer_SetBorderColor(This,Clr) (This)->lpVtbl->SetBorderColor(This,Clr)
#define IMFPMediaPlayer_SetMediaItem(This,pIMFPMediaItem) (This)->lpVtbl->SetMediaItem(This,pIMFPMediaItem)
#define IMFPMediaPlayer_SetMute(This,fMute) (This)->lpVtbl->SetMute(This,fMute)
#define IMFPMediaPlayer_SetPosition(This,guidPositionType,pvPositionValue) (This)->lpVtbl->SetPosition(This,guidPositionType,pvPositionValue)
#define IMFPMediaPlayer_SetRate(This,flRate) (This)->lpVtbl->SetRate(This,flRate)
#define IMFPMediaPlayer_SetVideoSourceRect(This,pnrcSource) (This)->lpVtbl->SetVideoSourceRect(This,pnrcSource)
#define IMFPMediaPlayer_SetVolume(This,flVolume) (This)->lpVtbl->SetVolume(This,flVolume)
#define IMFPMediaPlayer_Shutdown() (This)->lpVtbl->Shutdown(This)
#define IMFPMediaPlayer_Stop() (This)->lpVtbl->Stop(This)
#define IMFPMediaPlayer_UpdateVideo() (This)->lpVtbl->UpdateVideo(This)
#endif /*COBJMACROS*/

#ifdef __GNUC__
#warning COM interfaces layout in this header has not been verified.
#warning COM interfaces with incorrect layout may not work at all.
#warning IMFPMediaPlayerCallback is unverified.
#endif

#undef  INTERFACE
#define INTERFACE IMFPMediaPlayerCallback
DECLARE_INTERFACE_(IMFPMediaPlayerCallback,IUnknown)
{
    BEGIN_INTERFACE

    /* IUnknown methods */
    STDMETHOD(QueryInterface)(THIS_ REFIID riid, void **ppvObject) PURE;
    STDMETHOD_(ULONG, AddRef)(THIS) PURE;
    STDMETHOD_(ULONG, Release)(THIS) PURE;

    /* IMFPMediaPlayerCallback methods */
    STDMETHOD(OnMediaPlayerEvent)(THIS_ MFP_EVENT_HEADER *pEventHeader) PURE;

    END_INTERFACE
};
#ifdef COBJMACROS
#define IMFPMediaPlayerCallback_QueryInterface(This,riid,ppvObject) (This)->lpVtbl->QueryInterface(This,riid,ppvObject)
#define IMFPMediaPlayerCallback_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IMFPMediaPlayerCallback_Release(This) (This)->lpVtbl->Release(This)
#define IMFPMediaPlayerCallback_OnMediaPlayerEvent(This,pEventHeader) (This)->lpVtbl->OnMediaPlayerEvent(This,pEventHeader)
#endif /*COBJMACROS*/

typedef struct MFP_EVENT_HEADER {
  MFP_EVENT_TYPE        eEventType;
  HRESULT               hrEvent;
  IMFPMediaPlayer       *pMediaPlayer;
  MFP_MEDIAPLAYER_STATE eState;
  IPropertyStore        *pPropertyStore;
} MFP_EVENT_HEADER;

typedef struct MFP_PLAY_EVENT {
  MFP_EVENT_HEADER header;
  IMFPMediaItem    *pMediaItem;
} MFP_PLAY_EVENT;

typedef struct MFP_PAUSE_EVENT {
  MFP_EVENT_HEADER header;
  IMFPMediaItem    *pMediaItem;
} MFP_PAUSE_EVENT;

typedef struct MFP_STOP_EVENT {
  MFP_EVENT_HEADER header;
  IMFPMediaItem    *pMediaItem;
} MFP_STOP_EVENT;

typedef struct MFP_POSITION_SET_EVENT {
  MFP_EVENT_HEADER header;
  IMFPMediaItem    *pMediaItem;
} MFP_POSITION_SET_EVENT;

typedef struct MFP_RATE_SET_EVENT {
  MFP_EVENT_HEADER header;
  IMFPMediaItem    *pMediaItem;
  float            flRate;
} MFP_RATE_SET_EVENT;

typedef struct MFP_MEDIAITEM_CREATED_EVENT {
  MFP_EVENT_HEADER header;
  IMFPMediaItem    *pMediaItem;
  DWORD_PTR        dwUserData;
} MFP_MEDIAITEM_CREATED_EVENT;

typedef struct MFP_MEDIAITEM_SET_EVENT {
  MFP_EVENT_HEADER header;
  IMFPMediaItem    *pMediaItem;
} MFP_MEDIAITEM_SET_EVENT;

typedef struct MFP_FRAME_STEP_EVENT {
  MFP_EVENT_HEADER header;
  IMFPMediaItem    *pMediaItem;
} MFP_FRAME_STEP_EVENT;

typedef struct MFP_MEDIAITEM_CLEARED_EVENT {
  MFP_EVENT_HEADER header;
  IMFPMediaItem    *pMediaItem;
} MFP_MEDIAITEM_CLEARED_EVENT;

typedef struct MFP_MF_EVENT {
  MFP_EVENT_HEADER header;
  MediaEventType   MFEventType;
  IMFMediaEvent    *pMFMediaEvent;
  IMFPMediaItem    *pMediaItem;
} MFP_MF_EVENT;

typedef struct MFP_ERROR_EVENT {
  MFP_EVENT_HEADER header;
} MFP_ERROR_EVENT;

typedef struct MFP_PLAYBACK_ENDED_EVENT {
  MFP_EVENT_HEADER header;
  IMFPMediaItem    *pMediaItem;
} MFP_PLAYBACK_ENDED_EVENT;

typedef struct MFP_ACQUIRE_USER_CREDENTIAL_EVENT {
  MFP_EVENT_HEADER     header;
  DWORD_PTR            dwUserData;
  BOOL                 fProceedWithAuthentication;
  HRESULT              hrAuthenticationStatus;
  LPCWSTR              pwszURL;
  LPCWSTR              pwszSite;
  LPCWSTR              pwszRealm;
  LPCWSTR              pwszPackage;
  LONG                 nRetries;
  MFP_CREDENTIAL_FLAGS flags;
  IMFNetCredential     *pCredential;
} MFP_ACQUIRE_USER_CREDENTIAL_EVENT;

typedef UINT32 MFP_CREATION_OPTIONS;
typedef UINT32 MFP_MEDIAITEM_CHARACTERISTICS;

#ifdef __cplusplus
extern "C" {
#endif

HRESULT WINAPI MFPCreateMediaPlayer(LPCWSTR pwszURL,WINBOOL fStartPlayback,MFP_CREATION_OPTIONS creationOptions,IMFPMediaPlayerCallback *pCallback,HWND hWnd,IMFPMediaPlayer **ppMediaPlayer);

#ifdef __cplusplus
}
#endif

#endif /*(WINVER >= 0x0601)*/

#endif /*_INC_MFPLAY*/
