/* Copyright (c) Robert Walker, support@tunesmithy.co.uk
    * Free source. Do what you wish with it - treat it as you would
    * example code in a book on c programming.
*/ 
#include "time64.h"
#undef time
#undef localtime
#undef mktime
#undef difftime
#undef gmtime
#undef time_t

#include <time.h>
#include <windows.h>
#include <assert.h>

#define SECS_TO_FT_MULT 10000000
#ifdef _DEBUG
    #define DEBUG_TIME_T
#endif

/* From MSVC help:
    * The gmtime, mktime, and localtime functions use the same single, 
    * statically allocated structure to hold their results. Each call to 
    * one of these functions destroys the result of any previous call. 
    * If timer represents a date before midnight, January 1, 1970, 
    * gmtime returns NULL. There is no error return.
    *
    * So here is the struct to use for our 64 bit implementation
    *
    * However, it may be useful to be able to make this thread safe
*/

#ifdef USE_THREAD_LOCAL_VARIABLES
    #define  TIME64_THREAD_LOCAL _declspec(thread)
    #else
    #define TIME64_THREAD_LOCAL
#endif

TIME64_THREAD_LOCAL static struct tm today_ret;

static void T64ToFileTime(t64 *pt,FILETIME *pft)
{
    LARGE_INTEGER li; 
    li.QuadPart=*pt*SECS_TO_FT_MULT;
    pft->dwLowDateTime=li.LowPart;
    pft->dwHighDateTime=li.HighPart;
}

static void FileTimeToT64(FILETIME *pft,t64 *pt)
{
    LARGE_INTEGER li;    
    li.LowPart = pft->dwLowDateTime;
    li.HighPart = pft->dwHighDateTime;
    *pt=li.QuadPart;
    *pt/=SECS_TO_FT_MULT;
}

//#define  FindTimeTBase() ((t64) 11644473600)
#define  FindTimeTBase() (((__int64)11644)*1000000+473600)

// calculated using
/**
    static t64 FindTimeTBase(void)
    {
    // Find 1st Jan 1970 as a FILETIME 
    SYSTEMTIME st;
    FILETIME ft;
    memset(&st,0,sizeof(st));
    st.wYear=1970;
    st.wMonth=1;
    st.wDay=1;
    SystemTimeToFileTime(&st, &ft);
    FileTimeToT64(&ft,&tbase);
    return tbase;
    }
**/

static void SystemTimeToT64(SYSTEMTIME *pst,t64 *pt)
{
    FILETIME ft;
    SystemTimeToFileTime(pst, &ft);
    FileTimeToT64(&ft,pt);
    *pt-=FindTimeTBase();
}


static void T64ToSystemTime(t64 *pt,SYSTEMTIME *pst)
{
    FILETIME ft;
    t64 t=*pt;
    t+=FindTimeTBase();
    T64ToFileTime(&t,&ft);
    FileTimeToSystemTime(&ft,pst);
}


t64 time_64(t64 *pt)
{
    t64 t;
    SYSTEMTIME st;
    GetSystemTime(&st);
    SystemTimeToT64(&st,&t);
    #ifdef DEBUG_TIME_T
        {
            time_t t2=time(NULL);
            if(t2>=0)
            
            //2005 assert(abs(t2-(int)t)<=1);
            assert(abs((long)(t2-(int)t))<=1);
            
            // the <=1 here is in case the seconds get incremented
            // betweeen the GetSystemTime(..) call and the time(..) call
        }
    #endif
    if(pt)
    *pt=t;
    return t;
}

double difftime_64(t64 time1, t64 time0)
{
    return (double)(time1-time0);
}

t64 mktime64( struct tm *today )
{
    t64 t;
    SYSTEMTIME st;
    st.wDay=(WORD)today->tm_mday;
    st.wDayOfWeek=(WORD)today->tm_wday;
    st.wHour=(WORD)today->tm_hour;
    st.wMinute=(WORD)today->tm_min;
    st.wMonth=(WORD)(today->tm_mon+1);
    st.wSecond=(WORD)today->tm_sec;
    st.wYear=(WORD)(today->tm_year+1900);
    st.wMilliseconds=0;
    SystemTimeToT64(&st,&t);
    return t;
}

#define DAY_IN_SECS (60*60*24)
struct tm *gmtime_64(t64 t)
{
    SYSTEMTIME st;
    T64ToSystemTime(&t,&st);
    today_ret.tm_wday=st.wDayOfWeek;
    today_ret.tm_min=st.wMinute;
    today_ret.tm_sec=st.wSecond;
    today_ret.tm_mon=st.wMonth-1;
    today_ret.tm_mday=st.wDay;
    today_ret.tm_hour=st.wHour;
    today_ret.tm_year=st.wYear-1900;
    {
        SYSTEMTIME styear;
        t64 t64Year;
        memset(&styear,0,sizeof(styear));
        styear.wYear=st.wYear;
        styear.wMonth=1;
        styear.wDay=1;
        SystemTimeToT64(&styear,&t64Year);
        today_ret.tm_yday=(int)((t-t64Year)/DAY_IN_SECS);
    }
    today_ret.tm_isdst=0;
    #ifdef DEBUG_TIME_T
        {
            struct tm today2;
            long t32=(int)t;
            if(t32>=0)
            {
                //2005   today2=*gmtime(&t32);
                today2=*gmtime((time_t*)&t32);
                
                assert(today_ret.tm_yday==today2.tm_yday);
                assert(today_ret.tm_wday==today2.tm_wday);
                assert(today_ret.tm_min==today2.tm_min);
                assert(today_ret.tm_sec==today2.tm_sec);
                assert(today_ret.tm_mon==today2.tm_mon);
                assert(today_ret.tm_mday==today2.tm_mday);
                assert(today_ret.tm_hour==today2.tm_hour);
                assert(today_ret.tm_year==today2.tm_year);
            }
        }
        {
            t64 t2=mktime64(&today_ret);
            assert(t2==t);
        }
    #endif
    return &today_ret;
}

struct tm *localtime_64(t64 *pt)
{
    t64 t=*pt;
    FILETIME ft,ftlocal;
    T64ToFileTime(&t,&ft);
    FileTimeToLocalFileTime(&ft,&ftlocal);
    FileTimeToT64(&ftlocal,&t);
    today_ret=*gmtime_64(t);
    {
        TIME_ZONE_INFORMATION TimeZoneInformation;
        switch(GetTimeZoneInformation(&TimeZoneInformation))
        {
            case TIME_ZONE_ID_DAYLIGHT:today_ret.tm_isdst=1;break;
            case TIME_ZONE_ID_STANDARD:today_ret.tm_isdst=0;break;
            case TIME_ZONE_ID_UNKNOWN:today_ret.tm_isdst=-1;break;
        }
    }
    return &today_ret;
}

