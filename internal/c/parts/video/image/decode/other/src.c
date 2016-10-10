// DOCUMENTATION
//
// Limitations:
//    - no 16-bit-per-channel PNG
//    - no 12-bit-per-channel JPEG
//    - no JPEGs with arithmetic coding
//    - no 1-bit BMP
//    - GIF always returns *comp=4
//
// Basic usage (see HDR discussion below for HDR usage):
//    int x,y,n;
//    unsigned char *data = stbi_load(filename, &x, &y, &n, 0);
//    // ... process data if not NULL ...
//    // ... x = width, y = height, n = # 8-bit components per pixel ...
//    // ... replace '0' with '1'..'4' to force that many components per pixel
//    // ... but 'n' will always be the number that it would have been if you said 0
//    stbi_image_free(data)
//
// Standard parameters:
//    int *x       -- outputs image width in pixels
//    int *y       -- outputs image height in pixels
//    int *comp    -- outputs # of image components in image file
//    int req_comp -- if non-zero, # of image components requested in result
//
// The return value from an image loader is an 'unsigned char *' which points
// to the pixel data, or NULL on an allocation failure or if the image is
// corrupt or invalid. The pixel data consists of *y scanlines of *x pixels,
// with each pixel consisting of N interleaved 8-bit components; the first
// pixel pointed to is top-left-most in the image. There is no padding between
// image scanlines or between pixels, regardless of format. The number of
// components N is 'req_comp' if req_comp is non-zero, or *comp otherwise.
// If req_comp is non-zero, *comp has the number of components that _would_
// have been output otherwise. E.g. if you set req_comp to 4, you will always
// get RGBA output, but you can check *comp to see if it's trivially opaque
// because e.g. there were only 3 channels in the source image.
//
// An output image with N components has the following components interleaved
// in this order in each pixel:
//
//     N=#comp     components
//       1           grey
//       2           grey, alpha
//       3           red, green, blue
//       4           red, green, blue, alpha
//
// If image loading fails for any reason, the return value will be NULL,
// and *x, *y, *comp will be unchanged. The function stbi_failure_reason()
// can be queried for an extremely brief, end-user unfriendly explanation
// of why the load failed. Define STBI_NO_FAILURE_STRINGS to avoid
// compiling these strings at all, and STBI_FAILURE_USERMSG to get slightly
// more user-friendly ones.
//
// Paletted PNG, BMP, GIF, and PIC images are automatically depalettized.

//STBIDEF stbi_uc *stbi_load               (char              const *filename,           int *x, int *y, int *comp, int req_comp);
//STBIDEF stbi_uc *stbi_load_from_memory   (stbi_uc           const *buffer, int len   , int *x, int *y, int *comp, int req_comp);
//STBIDEF stbi_uc *stbi_load_from_callbacks(stbi_io_callbacks const *clbk  , void *user, int *x, int *y, int *comp, int req_comp);

#define STB_IMAGE_IMPLEMENTATION
#ifdef QB64_BACKSLASH_FILESYSTEM
 #include "src\\stb_image.h"
#else
 #include "src/stb_image.h"
#endif

uint8 *image_decode_other(uint8 *content,int32 bytes,int32 *result,int32 *x,int32 *y){
//Result:bit 1=Success,bit 2=32bit[BGRA]
*result=0;

int32 h=0,w=0;
uint8 *out;
int comp=0;

out=stbi_load_from_memory(content,bytes,&w,&h,&comp,4);

if (out==NULL) return NULL;

//RGBA->BGRA
uint8* cp=out;
int32 x2,y2;
int32 r,g,b,a;
for (y2=0;y2<h;y2++){
for (x2=0;x2<w;x2++){
 r=cp[0]; b=cp[2];
 cp[0]=b; cp[2]=r;
 cp+=4;
}
}

*result=1+2;
*x=w;
*y=h;
return out;

}
