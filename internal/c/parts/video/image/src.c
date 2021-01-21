extern uint32 matchcol(int32 r,int32 g,int32 b);

#ifndef DEPENDENCY_IMAGE_CODEC
    //Stub(s):
    int32 func__loadimage(qbs *f,int32 bpp,int32 passed);
    #else
    
    #ifdef QB64_BACKSLASH_FILESYSTEM
        #include "decode\\jpg\\src.c"
        #include "decode\\png\\src.c"
        #include "decode\\bmp\\src.c"
        #include "decode\\other\\src.c" //PNG, TGA, BMP, PSD, GIF, HDR, PIC, PNM(PPM/PGM)
        #else
        #include "decode/jpg/src.c"
        #include "decode/png/src.c"
        #include "decode/bmp/src.c"
        #include "decode/other/src.c" //PNG, TGA, BMP, PSD, GIF, HDR, PIC, PNM(PPM/PGM)
    #endif
    
    int32 func__loadimage(qbs *f,int32 bpp,int32 passed){
        if (new_error) return 0;
        
        static int32 isHardware;
        isHardware=0; if (bpp==33){bpp=32; isHardware=1;}
        
        //validate bpp
        if (passed){
            if ((bpp!=32)&&(bpp!=256)){error(5); return 0;}
            }else{
            if (write_page->text){error(5); return 0;}
            bpp=-1;
        }
        if (!f->len) return -1; //return invalid handle if null length string
        if (bpp==256) return -1; //return invalid handle if 256-color mode requested (not valid in this version)
        
        //load the file
        int32 fh,result = 0;
        int64 lof;
        fh=gfs_open(f,1,0,0);
        if (fh<0) return -1;
        lof=gfs_lof(fh);
        static uint8* content;
        content=(uint8*)malloc(lof); if (!content){gfs_close(fh); return -1;}
        result=gfs_read(fh,-1,content,lof);
        gfs_close(fh);
        if (result<0){free(content); return -1;}
        
        //Identify format:
        static int32 format;
        format=0;
        
        //'.png'
        if (lof>=8){
            if ((content[0]==0x89)&&(content[1]==0x50)&&(content[2]==0x4E)&&(content[3]==0x47)&&
            (content[4]==0x0D)&&(content[5]==0x0A)&&(content[6]==0x1A)&&(content[7]==0x0A))
            {format=2; goto got_format;}//PNG
        }//8
        
        //'.bmp'
        if (lof>=6){
            if ((content[0]==0x42)&&(content[1]==0x4D)){
                if ( (*((int32*)(&content[2]))) == lof ){//length of file
                    format=3; goto got_format;
                }
            }//BMP 
        }//6
        
        //'.jpg' The first two bytes of every JPEG stream are the Start Of Image (SOI) marker values FFh D8h
        if (lof>=2){
            if ((content[0]==0xFF)&&(content[1]==0xD8)){format=1; goto got_format;}//JP[E]G
        }//2
        
        got_format:
        
        static uint8 *pixels;
        static int32 x,y;
        
        if (format==1) pixels=image_decode_jpg(content,lof,&result,&x,&y);
        if (format==2) pixels=image_decode_png(content,lof,&result,&x,&y);
        if (format==3) pixels=image_decode_bmp(content,lof,&result,&x,&y);
        if (!(result & 1)) {
            pixels=image_decode_other(content,lof,&result,&x,&y);
        }
        free(content);
        if (!(result&1)) return -1;
        
        //...
        
        static int32 i;
        static int32 prevDest;
        static uint16 scanX, scanY;
        static uint8 red, green, blue;
        
        i=func__newimage(x,y,32,1);
        if (i==-1){free(pixels); return -1;}
        memcpy(img[-i].offset,pixels,x*y*4);
        
        free(pixels);
        
        if (isHardware){
            static int32 iHardware;
            iHardware=func__copyimage(i,33,1);
            sub__freeimage(i,1);
            i=iHardware;
        }
        
        return i;
    }
    
#endif
