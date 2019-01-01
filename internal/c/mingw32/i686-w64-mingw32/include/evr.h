/**
 * This file has no copyright assigned and is placed in the Public Domain.
 * This file is part of the mingw-w64 runtime package.
 * No warranty is given; refer to the file DISCLAIMER.PD within this package.
 */
#ifndef _INC_EVR
#define _INC_EVR

#if (_WIN32_WINNT >= 0x0600)

#ifdef __cplusplus
extern "C" {
#endif

DEFINE_GUID(MR_VIDEO_RENDER_SERVICE,0x1092a86c,0xab1a,0x459a,0xa3,0x36,0x83,0x1f,0xbc,0x4d,0x11,0xff);
DEFINE_GUID(MR_VIDEO_MIXER_SERVICE,0x73cd2fc,0x6cf4,0x40b7,0x88,0x59,0xe8,0x95,0x52,0xc8,0x41,0xf8);
DEFINE_GUID(MR_VIDEO_ACCELERATION_SERVICE,0xefef5175,0x5c7d,0x4ce2,0xbb,0xbd,0x34,0xff,0x8b,0xca,0x65,0x54);
DEFINE_GUID(MR_BUFFER_SERVICE,0xa562248c,0x9ac6,0x4ffc,0x9f,0xba,0x3a,0xf8,0xf8,0xad,0x1a,0x4d);
DEFINE_GUID(VIDEO_ZOOM_RECT,0x7aaa1638,0x1b7f,0x4c93,0xbd,0x89,0x5b,0x9c,0x9f,0xb6,0xfc,0xf0);

#if (_WIN32_WINNT >= 0x0601)
typedef enum _EVRFilterConfig_Prefs {
  EVRFilterConfigPrefs_EnableQoS   = 0x00000001,
  EVRFilterConfigPrefs_Mask        = 0x00000001
} EVRFilterConfigPrefs;
#endif /*(_WIN32_WINNT >= 0x0601)*/

typedef enum MFVideoAspectRatioMode {
  MFVideoARMode_None               = 0x00000000,
  MFVideoARMode_PreservePicture    = 0x00000001,
  MFVideoARMode_PreservePixel      = 0x00000002,
  MFVideoARMode_NonLinearStretch   = 0x00000004,
  MFVideoARMode_Mask               = 0x00000007
} MFVideoAspectRatioMode;

#if (_WIN32_WINNT >= 0x0601)
typedef enum _MFVideoMixPrefs {
  MFVideoMixPrefs_ForceHalfInterlace         = 0x00000001,
  MFVideoMixPrefs_AllowDropToHalfInterlace   = 0x00000002,
  MFVideoMixPrefs_AllowDropToBob             = 0x00000004,
  MFVideoMixPrefs_ForceBob                   = 0x00000008,
  MFVideoMixPrefs_Mask                       = 0x0000000f
} MFVideoMixPrefs;
#endif /*(_WIN32_WINNT >= 0x0601)*/

typedef enum MFVideoRenderPrefs {
  MFVideoRenderPrefs_DoNotRenderBorder       = 0x00000001,
  MFVideoRenderPrefs_DoNotClipToDevice       = 0x00000002,
  MFVideoRenderPrefs_AllowOutputThrottling   = 0x00000004,
  MFVideoRenderPrefs_ForceOutputThrottling   = 0x00000008,
  MFVideoRenderPrefs_ForceBatching           = 0x00000010,
  MFVideoRenderPrefs_AllowBatching           = 0x00000020,
  MFVideoRenderPrefs_ForceScaling            = 0x00000040,
  MFVideoRenderPrefs_AllowScaling            = 0x00000080,
  MFVideoRenderPrefs_DoNotRepaintOnStop      = 0x00000100,
  MFVideoRenderPrefs_Mask                    = 0x000001ff
} MFVideoRenderPrefs;

typedef enum _MFVP_MESSAGE_TYPE {
  MFVP_MESSAGE_FLUSH                 = 0x00000000,
  MFVP_MESSAGE_INVALIDATEMEDIATYPE   = 0x00000001,
  MFVP_MESSAGE_PROCESSINPUTNOTIFY    = 0x00000002,
  MFVP_MESSAGE_BEGINSTREAMING        = 0x00000003,
  MFVP_MESSAGE_ENDSTREAMING          = 0x00000004,
  MFVP_MESSAGE_ENDOFSTREAM           = 0x00000005,
  MFVP_MESSAGE_STEP                  = 0x00000006,
  MFVP_MESSAGE_CANCELSTEP            = 0x00000007
} MFVP_MESSAGE_TYPE;

typedef struct MFVideoNormalizedRect {
  float left;
  float top;
  float right;
  float bottom;
} MFVideoNormalizedRect;

#ifdef __cplusplus
}
#endif

#undef  INTERFACE
#define INTERFACE IMFVideoPresenter
#ifdef __GNUC__
#warning COM interfaces layout in this header has not been verified.
#warning COM interfaces with incorrect layout may not work at all.
__MINGW_BROKEN_INTERFACE(INTERFACE)
#endif
DECLARE_INTERFACE_(IMFVideoPresenter,IMFClockStateSink)
{
    BEGIN_INTERFACE

    /* IUnknown methods */
    STDMETHOD(QueryInterface)(THIS_ REFIID riid, void **ppvObject) PURE;
    STDMETHOD_(ULONG, AddRef)(THIS) PURE;
    STDMETHOD_(ULONG, Release)(THIS) PURE;

    /* IMFClockStateSink methods */
    STDMETHOD_(HRESULT,OnClockPause)(THIS_ MFTIME hnsSystemTime) PURE;
    STDMETHOD_(HRESULT,OnClockRestart)(THIS_ MFTIME hnsSystemTime) PURE;
    STDMETHOD_(HRESULT,OnClockSetRate)(THIS_ MFTIME hnsSystemTime,float flRate) PURE;
    STDMETHOD_(HRESULT,OnClockStart)(THIS_ MFTIME hnsSystemTime,LONGLONG llClockStartOffset) PURE;
    STDMETHOD_(HRESULT,OnClockStop)(THIS_ MFTIME hnssSystemTime) PURE;

    /* IMFVideoPresenter methods */
    STDMETHOD_(HRESULT,GetCurrentMediaType)(THIS_ IMFVideoMediaType **ppMediaType) PURE;
    STDMETHOD_(HRESULT,ProcessMessage)(THIS_ MFVP_MESSAGE_TYPE eMessage,ULONG_PTR ulParam) PURE;

    END_INTERFACE
};

#ifdef COBJMACROS
#define IMFVideoPresenter_QueryInterface(This,riid,ppvObject) (This)->lpVtbl->QueryInterface(This,riid,ppvObject)
#define IMFVideoPresenter_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IMFVideoPresenter_Release(This) (This)->lpVtbl->Release(This)
#define IMFVideoPresenter_OnClockPause(This,hnsSystemTime) (This)->lpVtbl->OnClockPause(This,hnsSystemTime)
#define IMFVideoPresenter_OnClockRestart(This,hnsSystemTime) (This)->lpVtbl->OnClockRestart(This,hnsSystemTime)
#define IMFVideoPresenter_OnClockSetRate(This,hnsSystemTime,flRate) (This)->lpVtbl->OnClockSetRate(This,hnsSystemTime,flRate)
#define IMFVideoPresenter_OnClockStart(This,hnsSystemTime,llClockStartOffset) (This)->lpVtbl->OnClockStart(This,hnsSystemTime,llClockStartOffset)
#define IMFVideoPresenter_OnClockStop(This,hnssSystemTime) (This)->lpVtbl->OnClockStop(This,hnssSystemTime)
#define IMFVideoPresenter_GetCurrentMediaType(This,ppMediaType) (This)->lpVtbl->GetCurrentMediaType(This,ppMediaType)
#define IMFVideoPresenter_ProcessMessage(This,eMessage,ulParam) (This)->lpVtbl->ProcessMessage(This,eMessage,ulParam)
#endif /*COBJMACROS*/

#undef  INTERFACE
#define INTERFACE IMFDesiredSample
#ifdef __GNUC__
#warning COM interfaces layout in this header has not been verified.
#warning COM interfaces with incorrect layout may not work at all.
__MINGW_BROKEN_INTERFACE(INTERFACE)
#endif
DECLARE_INTERFACE_(IMFDesiredSample,IUnknown)
{
    BEGIN_INTERFACE

    /* IUnknown methods */
    STDMETHOD(QueryInterface)(THIS_ REFIID riid, void **ppvObject) PURE;
    STDMETHOD_(ULONG, AddRef)(THIS) PURE;
    STDMETHOD_(ULONG, Release)(THIS) PURE;

    /* IMFDesiredSample methods */
    STDMETHOD(Clear)(THIS) PURE;
    STDMETHOD_(HRESULT,GetDesiredSampleTimeAndDuration)(THIS_ LONGLONG *phnsSampleTime,LONGLONG *phnsSampleDuration) PURE;
    STDMETHOD(SetDesiredSampleTimeAndDuration)(THIS_ LONGLONG hnsSampleTime,LONGLONG hnsSampleDuration) PURE;

    END_INTERFACE
};
#ifdef COBJMACROS
#define IMFDesiredSample_QueryInterface(This,riid,ppvObject) (This)->lpVtbl->QueryInterface(This,riid,ppvObject)
#define IMFDesiredSample_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IMFDesiredSample_Release(This) (This)->lpVtbl->Release(This)
#define IMFDesiredSample_Clear() (This)->lpVtbl->Clear(This)
#define IMFDesiredSample_GetDesiredSampleTimeAndDuration(This,phnsSampleTime,phnsSampleDuration) (This)->lpVtbl->GetDesiredSampleTimeAndDuration(This,phnsSampleTime,phnsSampleDuration)
#define IMFDesiredSample_SetDesiredSampleTimeAndDuration(This,hnsSampleTime,hnsSampleDuration) (This)->lpVtbl->SetDesiredSampleTimeAndDuration(This,hnsSampleTime,hnsSampleDuration)
#endif /*COBJMACROS*/

#undef  INTERFACE
#define INTERFACE IMFTrackedSample
DECLARE_INTERFACE_(IMFTrackedSample,IUnknown)
{
    BEGIN_INTERFACE

    /* IUnknown methods */
    STDMETHOD(QueryInterface)(THIS_ REFIID riid, void **ppvObject) PURE;
    STDMETHOD_(ULONG, AddRef)(THIS) PURE;
    STDMETHOD_(ULONG, Release)(THIS) PURE;

    /* IMFTrackedSample methods */
    STDMETHOD_(HRESULT,SetAllocator)(THIS_ IMFAsyncCallback *pSampleAllocator,IUnknown *pUnkState) PURE;

    END_INTERFACE
};

#ifdef COBJMACROS
#define IMFTrackedSample_QueryInterface(This,riid,ppvObject) (This)->lpVtbl->QueryInterface(This,riid,ppvObject)
#define IMFTrackedSample_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IMFTrackedSample_Release(This) (This)->lpVtbl->Release(This)
#define IMFTrackedSample_SetAllocator(This,pSampleAllocator,pUnkState) (This)->lpVtbl->SetAllocator(This,pSampleAllocator,pUnkState)
#endif /*COBJMACROS*/

#undef  INTERFACE
#define INTERFACE IMFVideoDeviceID
DECLARE_INTERFACE_(IMFVideoDeviceID,IUnknown)
{
    BEGIN_INTERFACE

    /* IUnknown methods */
    STDMETHOD(QueryInterface)(THIS_ REFIID riid, void **ppvObject) PURE;
    STDMETHOD_(ULONG, AddRef)(THIS) PURE;
    STDMETHOD_(ULONG, Release)(THIS) PURE;

    /* IMFVideoDeviceID methods */
    STDMETHOD_(HRESULT,GetDeviceID)(THIS_ IID *pDeviceID) PURE;

    END_INTERFACE
};
#ifdef COBJMACROS
#define IMFVideoDeviceID_QueryInterface(This,riid,ppvObject) (This)->lpVtbl->QueryInterface(This,riid,ppvObject)
#define IMFVideoDeviceID_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IMFVideoDeviceID_Release(This) (This)->lpVtbl->Release(This)
#define IMFVideoDeviceID_GetDeviceID(This,pDeviceID) (This)->lpVtbl->GetDeviceID(This,pDeviceID)
#endif /*COBJMACROS*/

#undef  INTERFACE
#define INTERFACE IMFVideoPositionMapper
DECLARE_INTERFACE_(IMFVideoPositionMapper,IUnknown)
{
    BEGIN_INTERFACE

    /* IUnknown methods */
    STDMETHOD(QueryInterface)(THIS_ REFIID riid, void **ppvObject) PURE;
    STDMETHOD_(ULONG, AddRef)(THIS) PURE;
    STDMETHOD_(ULONG, Release)(THIS) PURE;

    /* IMFVideoPositionMapper methods */
    STDMETHOD_(HRESULT,MapOutputCoordinateToInputStream)(THIS_ float xOut,float yOut,DWORD dwOutputStreamIndex,DWORD dwInputStreamIndex,float *pxIn,float *pyIn) PURE;

    END_INTERFACE
};
#ifdef COBJMACROS
#define IMFVideoPositionMapper_QueryInterface(This,riid,ppvObject) (This)->lpVtbl->QueryInterface(This,riid,ppvObject)
#define IMFVideoPositionMapper_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IMFVideoPositionMapper_Release(This) (This)->lpVtbl->Release(This)
#define IMFVideoPositionMapper_MapOutputCoordinateToInputStream(This,xOut,yOut,dwOutputStreamIndex,dwInputStreamIndex,pxIn,pyIn) (This)->lpVtbl->MapOutputCoordinateToInputStream(This,xOut,yOut,dwOutputStreamIndex,dwInputStreamIndex,pxIn,pyIn)
#endif /*COBJMACROS*/

#undef  INTERFACE
#define INTERFACE IMFVideoRenderer
DECLARE_INTERFACE_(IMFVideoRenderer,IUnknown)
{
    BEGIN_INTERFACE

    /* IUnknown methods */
    STDMETHOD(QueryInterface)(THIS_ REFIID riid, void **ppvObject) PURE;
    STDMETHOD_(ULONG, AddRef)(THIS) PURE;
    STDMETHOD_(ULONG, Release)(THIS) PURE;

    /* IMFVideoRenderer methods */
    STDMETHOD_(HRESULT,InitializeRenderer)(THIS_ IMFTransform *pVideoMixer,IMFVideoPresenter *pVideoPresenter) PURE;

    END_INTERFACE
};
#ifdef COBJMACROS
#define IMFVideoRenderer_QueryInterface(This,riid,ppvObject) (This)->lpVtbl->QueryInterface(This,riid,ppvObject)
#define IMFVideoRenderer_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IMFVideoRenderer_Release(This) (This)->lpVtbl->Release(This)
#define IMFVideoRenderer_InitializeRenderer(This,pVideoMixer,pVideoPresenter) (This)->lpVtbl->InitializeRenderer(This,pVideoMixer,pVideoPresenter)
#endif /*COBJMACROS*/

#undef  INTERFACE
#define INTERFACE IMFVideoDisplayControl
#ifdef __GNUC__
#warning COM interfaces layout in this header has not been verified.
#warning COM interfaces with incorrect layout may not work at all.
__MINGW_BROKEN_INTERFACE(INTERFACE)
#endif
DECLARE_INTERFACE_(IMFVideoDisplayControl,IUnknown)
{
    BEGIN_INTERFACE

    /* IUnknown methods */
    STDMETHOD(QueryInterface)(THIS_ REFIID riid, void **ppvObject) PURE;
    STDMETHOD_(ULONG, AddRef)(THIS) PURE;
    STDMETHOD_(ULONG, Release)(THIS) PURE;

    /* IMFVideoDisplayControl methods */
    STDMETHOD_(HRESULT,GetAspectRatioMode)(THIS_ DWORD *pdwAspectRatioMode) PURE;
    STDMETHOD_(HRESULT,GetBorderColor)(THIS_ COLORREF *pClr) PURE;
    STDMETHOD_(HRESULT,GetCurrentImage)(THIS_ LONGLONG *pTimeStamp) PURE;
    STDMETHOD_(HRESULT,GetFullscreen)(THIS_ BOOL *pfFullscreen) PURE;
    STDMETHOD_(HRESULT,GetIdealVideoSize)(THIS_ SIZE *pszMax) PURE;
    STDMETHOD_(HRESULT,GetNativeVideoSize)(THIS_ SIZE *pszARVideo) PURE;
    STDMETHOD_(HRESULT,GetRenderingPrefs)(THIS_ DWORD *pdwRenderFlags) PURE;
    STDMETHOD_(HRESULT,GetVideoPosition)(THIS_ MFVideoNormalizedRect *pnrcSource,LPRECT prcDest) PURE;
    STDMETHOD_(HRESULT,GetVideoWindow)(THIS_ HWND *phwndVideo) PURE;
    STDMETHOD_(HRESULT,RepaintVideo)(THIS) PURE;
    STDMETHOD_(HRESULT,SetAspectRatioMode)(THIS_ DWORD dwAspectRatioMode) PURE;
    STDMETHOD_(HRESULT,SetBorderColor)(THIS_ COLORREF Clr) PURE;
    STDMETHOD_(HRESULT,SetFullscreen)(THIS_ BOOL fFullscreen) PURE;
    STDMETHOD_(HRESULT,SetRenderingPrefs)(THIS_ DWORD dwRenderFlags) PURE;
    STDMETHOD_(HRESULT,SetVideoPosition)(THIS_ const MFVideoNormalizedRect *pnrcSource,const LPRECT prcDest) PURE;
    STDMETHOD_(HRESULT,SetVideoWindow)(THIS_ HWND hwndVideo) PURE;

    END_INTERFACE
};
#ifdef COBJMACROS
#define IMFVideoDisplayControl_QueryInterface(This,riid,ppvObject) (This)->lpVtbl->QueryInterface(This,riid,ppvObject)
#define IMFVideoDisplayControl_AddRef(This) (This)->lpVtbl->AddRef(This)
#define IMFVideoDisplayControl_Release(This) (This)->lpVtbl->Release(This)
#define IMFVideoDisplayControl_GetAspectRatioMode(This,pdwAspectRatioMode) (This)->lpVtbl->GetAspectRatioMode(This,pdwAspectRatioMode)
#define IMFVideoDisplayControl_GetBorderColor(This,pClr) (This)->lpVtbl->GetBorderColor(This,pClr)
#define IMFVideoDisplayControl_GetCurrentImage(This,pTimeStamp) (This)->lpVtbl->GetCurrentImage(This,pTimeStamp)
#define IMFVideoDisplayControl_GetFullscreen(This,pfFullscreen) (This)->lpVtbl->GetFullscreen(This,pfFullscreen)
#define IMFVideoDisplayControl_GetIdealVideoSize(This,pszMax) (This)->lpVtbl->GetIdealVideoSize(This,pszMax)
#define IMFVideoDisplayControl_GetNativeVideoSize(This,pszARVideo) (This)->lpVtbl->GetNativeVideoSize(This,pszARVideo)
#define IMFVideoDisplayControl_GetRenderingPrefs(This,pdwRenderFlags) (This)->lpVtbl->GetRenderingPrefs(This,pdwRenderFlags)
#define IMFVideoDisplayControl_GetVideoPosition(This,pnrcSource,prcDest) (This)->lpVtbl->GetVideoPosition(This,pnrcSource,prcDest)
#define IMFVideoDisplayControl_GetVideoWindow(This,phwndVideo) (This)->lpVtbl->GetVideoWindow(This,phwndVideo)
#define IMFVideoDisplayControl_RepaintVideo() (This)->lpVtbl->RepaintVideo(This)
#define IMFVideoDisplayControl_SetAspectRatioMode(This,dwAspectRatioMode) (This)->lpVtbl->SetAspectRatioMode(This,dwAspectRatioMode)
#define IMFVideoDisplayControl_SetBorderColor(This,Clr) (This)->lpVtbl->SetBorderColor(This,Clr)
#define IMFVideoDisplayControl_SetFullscreen(This,fFullscreen) (This)->lpVtbl->SetFullscreen(This,fFullscreen)
#define IMFVideoDisplayControl_SetRenderingPrefs(This,dwRenderFlags) (This)->lpVtbl->SetRenderingPrefs(This,dwRenderFlags)
#define IMFVideoDisplayControl_SetVideoPosition(This,pnrcSource,prcDest) (This)->lpVtbl->SetVideoPosition(This,pnrcSource,prcDest)
#define IMFVideoDisplayControl_SetVideoWindow(This,hwndVideo) (This)->lpVtbl->SetVideoWindow(This,hwndVideo)
#endif /*COBJMACROS*/

#ifdef __cplusplus
extern "C" {
#endif

HRESULT WINAPI MFCreateVideoMixer(IUnknown *pOwner,REFIID riidDevice,REFIID riid,void **ppVideoMixer);
HRESULT WINAPI MFCreateVideoMixerAndPresenter(IUnknown *pMixerOwner,IUnknown *pPresenterOwner,REFIID riidMixer,void **ppvVideoMixer,REFIID riidPresenter,void **ppvVideoPresenter);
HRESULT WINAPI MFCreateVideoPresenter(IUnknown *pOwner,REFIID riidDevice,REFIID riid,void **ppvVideoPresenter);
HRESULT WINAPI MFCreateVideoSampleAllocator(REFIID riid,void** ppSampleAllocator);
HRESULT WINAPI MFCreateVideoSampleFromSurface(IUnknown *pUnkSurface,IMFSample **ppSample);

#ifdef __cplusplus
}
#endif

#endif /*(_WIN32_WINNT >= 0x0600)*/

#endif /*_INC_EVR*/
