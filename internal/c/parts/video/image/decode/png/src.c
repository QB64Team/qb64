#ifdef QB64_BACKSLASH_FILESYSTEM
 #include "src\\lodepng.cpp"
#else
 #include "src/lodepng.cpp"
#endif

uint8 *image_decode_png(uint8 *content,int32 bytes,int32 *result,int32 *x,int32 *y){
//Result:bit 1=Success,bit 2=32bit[BGRA]
*result=0;

static unsigned char *png;
static unsigned width, height;
if (lodepng_decode32(&png, &width, &height, (unsigned char*)content, bytes)) return NULL;//RGBA

static uint8 *si;
si=(uint8*)png;
static int32 w,h;
w=width;
h=height;
static uint8 *di;

di=(uint8*)malloc(w*h*4);
//RGBA->BGRA
static int32 c;
c=w*h;
while(c--){
 di[c*4+2]=si[c*4  ];//red
 di[c*4+1]=si[c*4+1];//green
 di[c*4  ]=si[c*4+2];//blue
 di[c*4+3]=si[c*4+3];//alpha
}

//Cleanup
free(si);

*result=1+2;
*x=w;
*y=h;
return di;

}