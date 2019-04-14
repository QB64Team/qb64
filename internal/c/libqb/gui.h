//Common
int32 requestedKeyboardOverlayImage=0;

#ifndef QB64_GUI //begin stubs
    
    //STUB: simulate generating a hardware surface
    int32 new_hardware_img(int32 x, int32 y, uint32 *pixels, int32 flags){
        //create hardware img
        int32 handle;
        hardware_img_struct* hardware_img;
        handle=list_add(hardware_img_handles);
        hardware_img=(hardware_img_struct*)list_get(hardware_img_handles,handle);
        hardware_img->w=x;
        hardware_img->h=y;
        hardware_img->dest_context_handle=0;
        hardware_img->depthbuffer_handle=0;
        hardware_img->pending_commands=0;
        hardware_img->remove=0;
        hardware_img->alpha_disabled=0;
        hardware_img->depthbuffer_mode=DEPTHBUFFER_MODE__ON;
        hardware_img->valid=1;
        hardware_img->source_state.PO2_fix=PO2_FIX__OFF;
        hardware_img->source_state.texture_wrap=TEXTURE_WRAP_MODE__UNKNOWN;
        hardware_img->source_state.smooth_stretched=SMOOTH_MODE__UNKNOWN;
        hardware_img->source_state.smooth_shrunk=SMOOTH_MODE__UNKNOWN;
        if (flags&NEW_HARDWARE_IMG__BUFFER_CONTENT){    
            hardware_img->texture_handle=0;
            if (flags&NEW_HARDWARE_IMG__DUPLICATE_PROVIDED_BUFFER){
                hardware_img->software_pixel_buffer=NULL;
                }else{
                free(pixels);//the buffer was meant to be consumed, so we just free it immediately
                hardware_img->software_pixel_buffer=NULL;
            }
        }
        return handle;
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    #else //end stubs
    
    
    
    int32 force_NPO2_fix=0;//This should only be set to 1 for debugging QB64
    
    uint32 *NPO2_buffer=(uint32*)malloc(4);
    int32 NPO2_buffer_size_in_pixels=1;
    
    uint32 *NPO2_texture_generate(int32 *px, int32 *py, uint32 *pixels){
        int32 ox=*px;
        int32 oy=*py;
        int32 nx=1;
        int32 ny=1;
        
        //assume not negative & not 0
        while ((ox&1)==0){
            ox>>=1;
            nx<<=1;
        }
        if (ox!=1){//x is not a power of 2
            while (ox!=0){
                ox>>=1;
                nx<<=1;
            }	
            nx<<1;
        }
        while ((oy&1)==0){
            oy>>=1;
            ny<<=1;
        }
        if (oy!=1){//y is not a power of 2
            while (oy!=0){
                oy>>=1;
                ny<<=1;
            }	
            ny<<1;
        }
        
        //reset original values
        ox=*px;
        oy=*py;
        
        if (nx==ox&&ny==oy){ //no action required
            return pixels;
        }
        
        int32 size_in_pixels=nx*ny;
        if (size_in_pixels>NPO2_buffer_size_in_pixels){
            NPO2_buffer=(uint32*)realloc(NPO2_buffer,size_in_pixels*4);
            NPO2_buffer_size_in_pixels=size_in_pixels;
        }
        
        //copy source NPO2 rectangle into destination PO2 rectangle
        if (nx==ox){ //can copy as a single block
            memcpy(NPO2_buffer,pixels,ox*oy*4);
            }else{
            uint32 *dst_pixel_offset=NPO2_buffer;
            uint32 *src_pixel_offset=pixels;
            while (oy--){
                memcpy(dst_pixel_offset,src_pixel_offset,ox*4);
                dst_pixel_offset+=nx;
                src_pixel_offset+=ox;
            }
            oy=*py;
        }
        
        //tidy edges - extend the right-most column and bottom-most row to avoid pixel/color bleeding
        //rhs column
        if (ox!=nx){
            for (int y=0;y<oy;y++){
                NPO2_buffer[ox+nx*y]=NPO2_buffer[ox+nx*y-1];
            }
        }
        //bottom row + 1 pixel for corner
        if (oy!=ny){
            for (int x=0;x<(ox+1);x++){
                NPO2_buffer[nx*oy+x]=NPO2_buffer[nx*oy+x-nx];
            }
        }
        
        //int maxtexsize;
        //glGetIntegerv(GL_MAX_TEXTURE_SIZE, &maxtexsize);
        //alert(maxtexsize); 
        
        //alert(nx);
        //alert(ny);
        
        *px=nx;
        *py=ny;
        
        return NPO2_buffer;
        
    }
    
    
    int32 new_texture_handle(){
        GLuint texture=0;
        glGenTextures(1,&texture);
        return (int32)texture;
    }
    
    
    int32 new_hardware_img(int32 x, int32 y, uint32 *pixels, int32 flags){
        //note: non power-of-2 dimensioned textures are supported on modern 3D cards and
        //      even on some older cards, as long as mip-mapping is not being used
        //      therefore, no attempt is made to convert the non-power-of-2 SCREEN sizes via software
        //      to avoid the performance hit this would incur
        //create hardware img
        int32 handle;
        hardware_img_struct* hardware_img;
        handle=list_add(hardware_img_handles);
        hardware_img=(hardware_img_struct*)list_get(hardware_img_handles,handle);
        hardware_img->w=x;
        hardware_img->h=y;
        hardware_img->dest_context_handle=0;
        hardware_img->depthbuffer_handle=0;
        hardware_img->pending_commands=0;
        hardware_img->remove=0;
        hardware_img->alpha_disabled=0;
        hardware_img->depthbuffer_mode=DEPTHBUFFER_MODE__ON;
        hardware_img->valid=1;
        hardware_img->source_state.PO2_fix=PO2_FIX__OFF;
        hardware_img->source_state.texture_wrap=TEXTURE_WRAP_MODE__UNKNOWN;
        hardware_img->source_state.smooth_stretched=SMOOTH_MODE__UNKNOWN;
        hardware_img->source_state.smooth_shrunk=SMOOTH_MODE__UNKNOWN;
        
        if (flags&NEW_HARDWARE_IMG__BUFFER_CONTENT){
            hardware_img->texture_handle=0;    
            if (flags&NEW_HARDWARE_IMG__DUPLICATE_PROVIDED_BUFFER){
                hardware_img->software_pixel_buffer=(uint32*)malloc(x*y*4);
                memcpy(hardware_img->software_pixel_buffer,pixels,x*y*4);
                }else{
                hardware_img->software_pixel_buffer=pixels;
            }
            }else{
            hardware_img->software_pixel_buffer=NULL;
            hardware_img->texture_handle=new_texture_handle();
            glBindTexture (GL_TEXTURE_2D, hardware_img->texture_handle); 
            //non-power of 2 dimensions fallback support    
            static int glerrorcode;
            glerrorcode=glGetError();//clear any previous errors
            if (force_NPO2_fix==0) glTexImage2D (GL_TEXTURE_2D, 0, GL_RGBA, x, y, 0, GL_BGRA, GL_UNSIGNED_BYTE, pixels); 
            glerrorcode=glGetError();
            if (glerrorcode!=0||force_NPO2_fix==1){
                int32 nx=x,ny=y;
                uint32 *npixels=NPO2_texture_generate(&nx,&ny,pixels);
                glTexImage2D (GL_TEXTURE_2D, 0, GL_RGBA, nx, ny, 0, GL_BGRA, GL_UNSIGNED_BYTE,npixels);
                hardware_img->source_state.PO2_fix=PO2_FIX__EXPANDED;
                hardware_img->PO2_w=nx;
                hardware_img->PO2_h=ny;
                glerrorcode=glGetError();	
                if (glerrorcode){
                    gluBuild2DMipmaps(GL_TEXTURE_2D, GL_RGBA, x, y, GL_BGRA, GL_UNSIGNED_BYTE, pixels );
                    glerrorcode=glGetError();
                    if (glerrorcode){
                        alert("gluBuild2DMipmaps failed");
                        alert(glerrorcode);
                    }
                    hardware_img->source_state.PO2_fix=PO2_FIX__MIPMAPPED;
                    hardware_img->PO2_w=x;
                    hardware_img->PO2_h=y;
                }
            }
            set_render_source(INVALID_HARDWARE_HANDLE);
        }
        return handle;
    }
    
    void hardware_img_buffer_to_texture(int32 handle){
        static hardware_img_struct* hardware_img;
        hardware_img=(hardware_img_struct*)list_get(hardware_img_handles,handle);
        if (hardware_img->texture_handle==0){
            hardware_img->texture_handle=new_texture_handle();
            glBindTexture (GL_TEXTURE_2D, hardware_img->texture_handle);    
            //non-power of 2 dimensions fallback support
            static int glerrorcode;
            glerrorcode=glGetError();//clear any previous errors
            if (force_NPO2_fix==0) glTexImage2D (GL_TEXTURE_2D, 0, GL_RGBA, hardware_img->w, hardware_img->h, 0, GL_BGRA, GL_UNSIGNED_BYTE, hardware_img->software_pixel_buffer);  
            glerrorcode=glGetError();
            if (glerrorcode!=0||force_NPO2_fix==1){
                hardware_img->source_state.PO2_fix=PO2_FIX__EXPANDED;	
                int32 x=hardware_img->w;
                int32 y=hardware_img->h;
                uint32 *pixels=NPO2_texture_generate(&x,&y,hardware_img->software_pixel_buffer);
                hardware_img->PO2_w=x;
                hardware_img->PO2_h=y;
                glTexImage2D (GL_TEXTURE_2D, 0, GL_RGBA, x, y, 0, GL_BGRA, GL_UNSIGNED_BYTE,pixels);
                glerrorcode=glGetError();	
                if (glerrorcode){
                    gluBuild2DMipmaps(GL_TEXTURE_2D, GL_RGBA, hardware_img->w, hardware_img->h, GL_BGRA, GL_UNSIGNED_BYTE, hardware_img->software_pixel_buffer);
                    glerrorcode=glGetError();
                    if (glerrorcode){
                        alert("gluBuild2DMipmaps failed");
                        alert(glerrorcode);
                    }
                    hardware_img->source_state.PO2_fix=PO2_FIX__MIPMAPPED;
                    hardware_img->PO2_w=hardware_img->w;
                    hardware_img->PO2_h=hardware_img->h;
                }
            }
            free(hardware_img->software_pixel_buffer);
            hardware_img->software_pixel_buffer=NULL;//2015 critical bug fix
            set_render_source(INVALID_HARDWARE_HANDLE);
        }
    }
    
    void hardware_img_requires_depthbuffer(hardware_img_struct* hardware_img){
        if (hardware_img->depthbuffer_handle==0){
            //inspiration... http://www.opengl.org/wiki/Framebuffer_Object_Examples#Color_texture.2C_Depth_texture
            static GLuint depth_tex;
            #ifndef QB64_GLES
                glGenTextures(1, &depth_tex);
                glBindTexture(GL_TEXTURE_2D, depth_tex);
                glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
                glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
                glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
                glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
                glTexParameteri(GL_TEXTURE_2D, GL_DEPTH_TEXTURE_MODE, GL_INTENSITY);
                glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_COMPARE_MODE, GL_COMPARE_R_TO_TEXTURE);
                glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_COMPARE_FUNC, GL_LEQUAL);
                glTexImage2D(GL_TEXTURE_2D, 0, GL_DEPTH_COMPONENT24, hardware_img->w, hardware_img->h, 0, GL_DEPTH_COMPONENT, GL_UNSIGNED_BYTE, NULL);
                glFramebufferTexture2DEXT(GL_FRAMEBUFFER_EXT, GL_DEPTH_ATTACHMENT_EXT, GL_TEXTURE_2D, depth_tex, 0/*mipmap level*/);
                #else
                glGenRenderbuffers(1, &depth_tex);    
                glBindRenderbuffer(GL_RENDERBUFFER, depth_tex);
                glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT16, hardware_img->w, hardware_img->h);
                glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, depth_tex);
            #endif
            //NULL means reserve texture memory, but texels are undefined
            glClear(GL_DEPTH_BUFFER_BIT);
            hardware_img->depthbuffer_handle=depth_tex;
            set_render_source(INVALID_HARDWARE_HANDLE);
        }
    }
    
    
#endif
