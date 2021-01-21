#ifdef QB64_BACKSLASH_FILESYSTEM
    #include "src\\EasyBMP.cpp"
    #else
    #include "src/EasyBMP.cpp"
#endif

uint8 *image_decode_bmp(uint8 *content,int32 bytes,int32 *result,int32 *x,int32 *y){
    //Result:bit 1=Success,bit 2=32bit[BGRA]
    *result=0;
    
    
    
    BMP bm;
    
    if(!bm.ReadFromMemory((char*)content, bytes)){
        return NULL;
    }
    
    
    
    
    int32 h,w;
    h=bm.TellHeight();
    w=bm.TellWidth();
    
    uint8 *out;
    out=(uint8*)malloc(h*w*4);
    
    uint8* o;
    int32 x2,y2;
    o=out;
    for (y2=0;y2<h;y2++){
        for (x2=0;x2<w;x2++){
            *o=bm(x2,y2)->Blue; o++;
            *o=bm(x2,y2)->Green; o++;
            *o=bm(x2,y2)->Red; o++;
            *o=255; o++;
        }
    }
    
    *result=1+2;
    *x=w;
    *y=h;
    return out;
    
}