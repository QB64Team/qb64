#ifdef QB64_BACKSLASH_FILESYSTEM
 #include "src\\nanojpeg.c"
#else
 #include "src/nanojpeg.c"
#endif

uint8 *image_decode_jpg(uint8 *content,int32 bytes,int32 *result,int32 *x,int32 *y){
//Result:bit 1=Success,bit 2=32bit[BGRA]
*result=0;
static int32 init=0;
if (!init){init=1; njInit();}
if (njDecode(content,bytes)) return NULL;

static uint8 *si;
si=(uint8*)njGetImage();
static int32 w,h;
w=njGetWidth();
h=njGetHeight();
static uint8 *di;

if (njIsColor){//RGB

 //Create a buffer large enough to store image
 if (w*h*3!=njGetImageSize()) return NULL;
 di=(uint8*)malloc(w*h*4);

 //RGB->BGRA
 static int32 c;
 c=w*h;
 while(c--){
  di[c*4+2]=si[c*3  ];//red
  di[c*4+1]=si[c*3+1];//green
  di[c*4  ]=si[c*3+2];//blue
  di[c*4+3]=255;      //alpha
 }

}else{//Greyscale

 //Create a buffer large enough to store image
 if (w*h!=njGetImageSize()) return NULL; 
 di=(uint8*)malloc(w*h*4);

 //Greyscale->BGRA
 static int32 c;
 c=w*h;
 while(c--){
  di[c*4+2]=si[c];//red
  di[c*4+1]=si[c];//green
  di[c*4  ]=si[c];//blue
  di[c*4+3]=255;  //alpha
 }

}

*result=1+2;
*x=w;
*y=h;
return di;

}