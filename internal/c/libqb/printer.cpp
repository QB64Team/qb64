#ifndef DEPENDENCY_PRINTER
    
    //stubs
    void sub__printimage(int32 i){
        return;
    }
    
    #else
    
    void sub__printimage(int32 i){
        
        #ifdef QB64_WINDOWS
            
            static LPSTR szPrinterName=NULL;
            DWORD dwNameLen;
            HDC dc;
            DOCINFO di;
            uint32 w,h;
            int32 x,y;
            int32 i2;
            BITMAPFILEHEADER bmfHeader;  
            BITMAPINFOHEADER bi;
            img_struct *s,*s2;
            
            if (i>=0){
                validatepage(i); s=&img[page[i]];
                }else{
                x=-i;
                if (x>=nextimg){error(258); return;}
                s=&img[x];
                if (!s->valid){error(258); return;}
            }
            
            if (!szPrinterName) szPrinterName=(LPSTR)malloc(65536);
            dwNameLen=65536;
            GetDefaultPrinter(szPrinterName,&dwNameLen);
            if((dc=CreateDC(TEXT("WINSPOOL"),szPrinterName,NULL,NULL))==NULL) goto failed;
            ZeroMemory(&di,sizeof(DOCINFO));
            di.cbSize=sizeof(DOCINFO);
            di.lpszDocName=TEXT("Document");
            if(StartDoc(dc,&di)<=0){DeleteDC(dc); goto failed;}
            if(StartPage(dc)<=0){EndDoc(dc); DeleteDC(dc); goto failed;}
            
            w=GetDeviceCaps(dc,HORZRES);
            h=GetDeviceCaps(dc,VERTRES);
            
            i2=func__newimage(w,h,32,1);
            if (i2==-1){EndDoc(dc); DeleteDC(dc); goto failed;}
            s2=&img[-i2];
            sub__dontblend(i2,1);
            sub__putimage(NULL,NULL,NULL,NULL,i,i2,NULL,NULL,NULL,NULL,8+32);
            
            ZeroMemory(&bi,sizeof(BITMAPINFOHEADER));
            
            bi.biSize = sizeof(BITMAPINFOHEADER);
            bi.biWidth = w;
            bi.biHeight = h;  
            bi.biPlanes = 1;
            bi.biBitCount = 32;
            bi.biCompression = BI_RGB;
            bi.biSizeImage = 0;  
            bi.biXPelsPerMeter = 0;
            bi.biYPelsPerMeter = 0;
            bi.biClrUsed = 0;
            bi.biClrImportant = 0;
            
            for (y=0;y<h;y++){
                SetDIBitsToDevice(dc,0,y,w,1,0,0,0,1,s2->offset32+(y*w),(BITMAPINFO*)&bi, DIB_RGB_COLORS);
            }
            
            sub__freeimage(i2,1);
            
            if(EndPage(dc)<=0){EndDoc(dc); DeleteDC(dc); goto failed;}
            if(EndDoc(dc)<=0){DeleteDC(dc); goto failed;}
            DeleteDC(dc);
            failed:;
        #endif
    }
    
#endif