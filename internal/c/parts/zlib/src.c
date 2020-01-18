#include <zlib.h>

  qbs *func__deflate(qbs *text){
        uLongf filesize = (uint32)text->len;  //length of the text
        uLongf compsize = compressBound(filesize);
        unsigned char *dest = (unsigned char *)malloc(compsize);
        int32 result = compress(dest, &compsize, text->chr, filesize);
        qbs *ret = qbs_new(compsize,1);
        memcpy(ret->chr, dest, compsize);
        free(dest);
        return ret;
  }

  qbs *func__inflate(qbs *text, int64 originalsize, int32 passed){
        int32 result=0;
        if (passed==1){
            uLongf uncompsize = originalsize;
            unsigned char *dest = (unsigned char *)malloc(originalsize);
            int32 result = uncompress(dest, &uncompsize, text->chr, text->len);
            qbs *ret = qbs_new(uncompsize,1);
            memcpy(ret->chr, dest, uncompsize);
            free(dest);
            return ret;
        }else{
            uLongf uncompsize = 0; 
            unsigned char *dest;
            do {
                uncompsize = uncompsize + 10000000; //10 mb original buffer, resized by 10 mb each pass until it's large enough to hold the uncompressed data.
                dest = (unsigned char *)malloc(uncompsize);
                result = uncompress(dest, &uncompsize, text->chr, text->len);
                if (result==Z_BUF_ERROR)free(dest); //if the buffer is too small, free the old buffer
            } while(result==Z_BUF_ERROR); // and try again with a larger buffer
            qbs *ret = qbs_new(uncompsize,1);
            memcpy(ret->chr, dest, uncompsize);
            free(dest);
            return ret;
        }
  }