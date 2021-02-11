#ifdef QB64_MACOSX
#include <sys/sysctl.h>
#endif

// trigger recompilation = 3

int32 displayorder_screen=1;
int32 displayorder_hardware=2;
int32 displayorder_glrender=3;
int32 displayorder_hardware1=4;

//sub__displayorder( 1 , 2 , 4 , 3 );
//id.specialformat = "[{_SCREEN|_HARDWARE|_HARDWARE1|_GLRENDER}[,{_SCREEN|_HARDWARE|_HARDWARE1|_GLRENDER}[,{_SCREEN|_HARDWARE|_HARDWARE1|_GLRENDER}[,{_SCREEN|_HARDWARE|_HARDWARE1|_GLRENDER}]]]]"
void sub__displayorder(int32 method1,int32 method2,int32 method3,int32 method4){
    
    //check no value has been used twice
    if (method1!=0) if (method1==method2||method1==method3||method1==method4){error(5); return;}
    if (method2!=0) if (method2==method1||method2==method3||method2==method4){error(5); return;}
    if (method3!=0) if (method3==method1||method3==method2||method3==method4){error(5); return;}
    if (method4!=0) if (method4==method1||method4==method2||method4==method3){error(5); return;}
    displayorder_screen=0;
    displayorder_hardware=0;
    displayorder_hardware1=0;
    displayorder_glrender=0;
    static int32 i,method;
    for (i=1;i<=4;i++){
        if (i==1) method=method1;
        if (i==2) method=method2;
        if (i==3) method=method3;
        if (i==4) method=method4;
        if (method==1) displayorder_screen=i;
        if (method==2) displayorder_hardware=i;
        if (method==3) displayorder_hardware1=i;
        if (method==4) displayorder_glrender=i;
    }
}

//int32 gl_render_method=2; //1=behind, 2=ontop[default], 3=only
void sub__glrender(int32 method){
    //gl_render_method=method;
    if (method==1) sub__displayorder(4,1,2,3);
    if (method==2) sub__displayorder(1,2,4,3);
    if (method==3) sub__displayorder(4,0,0,0);
}


#ifndef QB64_GUI //begin stubs
    
    
    
    
    #else //end stubs
    
    
    
    
    
    void GLUT_RESHAPE_FUNC(int width, int height){
        resize_event_x=width; resize_event_y=height;
        resize_event=-1;
        display_x_prev=display_x,display_y_prev=display_y;
        display_x=width; display_y=height;
        resize_pending=0;
        os_resize_event=1;
        set_view(VIEW_MODE__UNKNOWN);
        //***glutReshapeWindow(...) has no effect if called
        //   within GLUT_RESHAPE_FUNC***
    }
    
    
    
    
    //displaycall is the window of time to update our display
    
    
    #ifdef DEPENDENCY_GL
        extern void SUB__GL();
    #endif
    
    
    
    
    
    
    
    
    
    #define GL_BGR 0x80E0
    #define GL_BGRA 0x80E1
    
    
    
    /* reference
        struct hardware_img_struct{
        int32 w;
        int32 h;
        int32 texture_handle;
        int32 dest_context_handle;//used when rendering other images onto this image
        int32 temp;//if =1, delete immediately after use
        }
        list *hardware_img_handles=NULL;
    */
    
    
    
    void free_hardware_img(int32 handle, int32 caller_id){
        
        hardware_img_struct* hardware_img;
        hardware_img=(hardware_img_struct*)list_get(hardware_img_handles,handle);
        
        if (hardware_img==NULL){
            alert("free_hardware_img: image does not exist");
        }
        
        if (hardware_img->dest_context_handle){
            GLuint context=(GLuint)hardware_img->dest_context_handle;
            glDeleteFramebuffersEXT(1, &context);
        }
        if (hardware_img->depthbuffer_handle){
            GLuint depthbuffer_handle=(GLuint)hardware_img->depthbuffer_handle;
            glDeleteFramebuffersEXT(1, &depthbuffer_handle);
        }
        GLuint texture=(GLuint)hardware_img->texture_handle;
        glDeleteTextures(1, &texture);
        
        //test reasset of hardware+img
        //hardware_img=(hardware_img_struct*)list_get(hardware_img_handles,handle);
        //if (hardware_img==NULL) alert("free_hardware_img: image does not exist");
        
        //if image has not been used, it may still have buffered pixel content
        
        if (hardware_img->software_pixel_buffer!=NULL){
            free(hardware_img->software_pixel_buffer);
        }
        
        list_remove(hardware_img_handles,handle);
        
    }
    
    
    /*
        int32 new_hardware_frame(int32 x, int32 y){
        int32 handle=new_hardware_frame_handle();
        glBindTexture (GL_TEXTURE_2D, handle);
        glTexImage2D (GL_TEXTURE_2D, 0, GL_RGBA, x, y, 0, GL_BGRA, GL_UNSIGNED_BYTE, NULL);
        return handle;
        }
        
        void free_hardware_frame(int32 handle){
        GLuint texture=(GLuint)handle;
        glDeleteTextures(1, &texture);
        }
    */
    
    
    
    
    void prepare_environment_2d(){//called prior to rendering 2D content
        
        //precalculate critical dimensions, offsets & ratios
        
        static int32 can_scale;//can the screen be scaled on the window
        can_scale=0;
        static int32 need_square_pixels;//do we need square_pixels? if not we can stretch the screen
        need_square_pixels=0;
        
        environment_2d__screen_smooth=0;
        
        environment_2d__letterbox=0;
        
        if (full_screen>0){//in full screen
            //reference: ---int32 full_screen_set=-1;//0(windowed),1(stretched/closest),2(1:1)---
            can_scale=1;
            if (full_screen==2) need_square_pixels=1;
            //note: 'letter-boxing' is only requred where the size of the window cannot be controlled, and the only place where this is the
            //      case is full screen mode _SQUAREPIXELS
            environment_2d__screen_smooth=fullscreen_smooth;
            }else{//windowed
            if (resize_auto>0){//1=STRETCH,2=SMOOTH
                can_scale=1;
                if (resize_auto==2) environment_2d__screen_smooth=1;
                //note: screen will fix its aspect ratio automatically, so there is no need to enforce squarepixels
            }
        }
        
        if (environment_2d__screen_width==environment__window_width &&
        environment_2d__screen_height==environment__window_height){
            //screen size matches window
            environment_2d__screen_x1=0;
            environment_2d__screen_y1=0;
            environment_2d__screen_x2=environment_2d__screen_width-1;
            environment_2d__screen_y2=environment_2d__screen_height-1;
            environment_2d__screen_x_scale=1.0f;
            environment_2d__screen_y_scale=1.0f;
            environment_2d__screen_scaled_width=environment_2d__screen_width;
            environment_2d__screen_scaled_height=environment_2d__screen_height;
            environment_2d__screen_smooth=0;//no smoothing required
            }else{
            //screen size does not match
            //calculate ratios
            static float window_ratio;
            static float screen_ratio;
            window_ratio=(float)environment__window_width/(float)environment__window_height;
            screen_ratio=(float)environment_2d__screen_width/(float)environment_2d__screen_height;
            if (can_scale==0){
                //screen will appear in the top-left of the window with blank space on the bottom & right
                environment_2d__screen_x1=0;
                environment_2d__screen_y1=0;
                environment_2d__screen_x2=environment_2d__screen_width-1;
                environment_2d__screen_y2=environment_2d__screen_height-1;
                goto cant_scale;
            }
            if (need_square_pixels==0||(window_ratio==screen_ratio)){
                //can stretch, no 'letter-box' required
                environment_2d__screen_x1=0;
                environment_2d__screen_y1=0;
                environment_2d__screen_x2=environment__window_width-1;
                environment_2d__screen_y2=environment__window_height-1;
                }else{
                //'letter-box' required
                //this section needs revision
                static float x_scale,y_scale;
                static int32 x1,y1,x2,y2,z,x_limit,y_limit,x_offset,y_offset;
                //x_scale=(float)environment_2d__screen_width/(float)environment__window_width;
                //y_scale=(float)environment_2d__screen_height/(float)environment__window_height;
                //x_offset=0; y_offset=0;
                
                x1=0; y1=0; x2=environment__window_width-1; y2=environment__window_height-1;
                //x_limit=x2; y_limit=y2;
                if (window_ratio>screen_ratio){
                    //pad sides
                    z=(float)environment__window_height*screen_ratio;//new width
                    x1=environment__window_width/2-z/2;
                    x2=x1+z-1;
                    environment_2d__letterbox=1;//vertical black stripes required
                    //x_offset=-x1; x_scale=(float)environment_2d__screen_width/(float)z; x_limit=z-1;
                    }else{
                    //pad top/bottom
                    z=(float)environment__window_width/screen_ratio;//new height
                    y1=environment__window_height/2-z/2;
                    y2=y1+z-1;
                    environment_2d__letterbox=2;//horizontal black stripes required
                    //y_offset=-y1; y_scale=(float)environment_2d__screen_height/(float)z; y_limit=z-1;
                }
                environment_2d__screen_x1=x1;
                environment_2d__screen_y1=y1;
                environment_2d__screen_x2=x2;
                environment_2d__screen_y2=y2;
            }
            cant_scale:
            environment_2d__screen_scaled_width=environment_2d__screen_x2-environment_2d__screen_x1+1;
            environment_2d__screen_scaled_height=environment_2d__screen_y2-environment_2d__screen_y1+1;
            environment_2d__screen_x_scale=(float)environment_2d__screen_scaled_width/(float)environment_2d__screen_width;
            environment_2d__screen_y_scale=(float)environment_2d__screen_scaled_height/(float)environment_2d__screen_height;
        }
        
    }//prepare_environment_2d
    
    
    int32 environment_2d__get_window_x1_coord(int32 x){
        return qbr_float_to_long(((float)x)*environment_2d__screen_x_scale)+environment_2d__screen_x1;
    }
    int32 environment_2d__get_window_y1_coord(int32 y){
        return qbr_float_to_long((float)y*environment_2d__screen_y_scale)+environment_2d__screen_y1;
    }
    int32 environment_2d__get_window_x2_coord(int32 x){
        return qbr_float_to_long(((float)x+1.0f)*environment_2d__screen_x_scale-1.0f)+environment_2d__screen_x1;
    }
    
    int32 environment_2d__get_window_y2_coord(int32 y){
        return qbr_float_to_long(((float)y+1.0f)*environment_2d__screen_y_scale-1.0f)+environment_2d__screen_y1;
    }
    
    struct environment_2d__window_rect_struct{
        int32 x1;
        int32 y1;
        int32 x2;
        int32 y2;
    };
    
    //this functions returns a constant rect dimensions to stop warping of image
    environment_2d__window_rect_struct tmp_rect;
    environment_2d__window_rect_struct *environment_2d__screen_to_window_rect(int32 x1,int32 y1,int32 x2,int32 y2){
        tmp_rect.x1=qbr_float_to_long(((float)x1)*environment_2d__screen_x_scale)+environment_2d__screen_x1;
        tmp_rect.y1=qbr_float_to_long(((float)y1)*environment_2d__screen_y_scale)+environment_2d__screen_y1;
        static int32 w,h;
        w=abs(x2-x1)+1; h=abs(y2-y1)+1;
        //force round upwards to correct gaps when tiling
        w=((float)w)*environment_2d__screen_x_scale+0.99f;
        h=((float)h)*environment_2d__screen_y_scale+0.99f;
        tmp_rect.x2=w-1+tmp_rect.x1;
        tmp_rect.y2=h-1+tmp_rect.y1;
        //(code which doesn't support tiling)
        //tmp_rect.x2=qbr_float_to_long(((float)w)*environment_2d__screen_x_scale-1.0f)+tmp_rect.x1;
        //tmp_rect.y2=qbr_float_to_long(((float)h)*environment_2d__screen_y_scale-1.0f)+tmp_rect.y1;
        return &tmp_rect;
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    float *hardware_buffer_vertices=(float*)malloc(sizeof(float)*1);
    int32 hardware_buffer_vertices_max=1;
    int32 hardware_buffer_vertices_count=0;
    
    float *hardware_buffer_texcoords=(float*)malloc(sizeof(float)*1);
    int32 hardware_buffer_texcoords_max=1;
    int32 hardware_buffer_texcoords_count=0;
    
    void hardware_buffer_flush(){
        if (hardware_buffer_vertices_count){
            //ref: http://stackoverflow.com/questions/5009014/draw-square-with-opengl-es-for-ios
            if (hardware_buffer_vertices_count==hardware_buffer_texcoords_count){
                glVertexPointer(2, GL_FLOAT, 2*sizeof(GL_FLOAT), hardware_buffer_vertices); //http://www.opengl.org/sdk/docs/man2/xhtml/glVertexPointer.xml
                glTexCoordPointer(2, GL_FLOAT, 2*sizeof(GL_FLOAT), hardware_buffer_texcoords); //http://www.opengl.org/sdk/docs/man2/xhtml/glTexCoordPointer.xml
                glDrawArrays(GL_TRIANGLES, 0, hardware_buffer_vertices_count/2);//start index, number of indexes
                }else{
                glVertexPointer(3, GL_FLOAT, 3*sizeof(GL_FLOAT), hardware_buffer_vertices); //http://www.opengl.org/sdk/docs/man2/xhtml/glVertexPointer.xml
                glTexCoordPointer(2, GL_FLOAT, 2*sizeof(GL_FLOAT), hardware_buffer_texcoords); //http://www.opengl.org/sdk/docs/man2/xhtml/glTexCoordPointer.xml
                glDrawArrays(GL_TRIANGLES, 0, hardware_buffer_vertices_count/3);//start index, number of indexes
            }
            hardware_buffer_vertices_count=0;
            hardware_buffer_texcoords_count=0;
        }
    }
    
    
    
    
    void set_smooth(int32 new_mode_shrunk,int32 new_mode_stretched){
        static int32 current_mode_shrunk;
        current_mode_shrunk=render_state.source->smooth_shrunk;
        static int32 current_mode_stretched;
        current_mode_stretched=render_state.source->smooth_stretched;
        if (new_mode_shrunk==current_mode_shrunk&&new_mode_stretched==current_mode_stretched) return;
        hardware_buffer_flush();
        if (new_mode_shrunk==SMOOTH_MODE__DONT_SMOOTH){
            if (render_state.source->PO2_fix==PO2_FIX__MIPMAPPED){
                glTexParameterf (GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
                }else{
                glTexParameterf (GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);//Use _MAPTRIANGLE's _SMOOTHSHRUNK to apply linear filtering here
            }
        }
        if (new_mode_shrunk==SMOOTH_MODE__SMOOTH){
            glTexParameterf (GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
        }
        if (new_mode_stretched==SMOOTH_MODE__DONT_SMOOTH){
            if (render_state.source->PO2_fix==PO2_FIX__MIPMAPPED){
                glTexParameterf (GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
                }else{
                glTexParameterf (GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
            }
        }
        if (new_mode_stretched==SMOOTH_MODE__SMOOTH){
            glTexParameterf ( GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
        }
        render_state.source->smooth_shrunk=new_mode_shrunk;
        render_state.source->smooth_stretched=new_mode_stretched;
    }
    
    void set_texture_wrap(int32 new_mode){
        static int32 current_mode;
        current_mode=render_state.source->texture_wrap;
        if (new_mode==current_mode) return;
        hardware_buffer_flush();
        if (new_mode==TEXTURE_WRAP_MODE__DONT_WRAP){
            glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
            glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
        }
        if (new_mode==TEXTURE_WRAP_MODE__WRAP){
            glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
            glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
        }
        render_state.source->texture_wrap=new_mode;
    }
    
    void set_alpha(int32 new_mode){
        static int32 current_mode;
        current_mode=render_state.use_alpha;
        if (new_mode==current_mode) return;
        hardware_buffer_flush();
        if (new_mode==ALPHA_MODE__DONT_BLEND){
            glDisable(GL_BLEND);
        }
        if (new_mode==ALPHA_MODE__BLEND){
            glEnable(GL_BLEND);
            if (framebufferobjects_supported){
                #ifndef QB64_GLES
                    //glBlendFuncSeparateEXT(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA, GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
                    glBlendFuncSeparateEXT(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA, GL_ONE, GL_ONE);
                    #else
                    glBlendFuncSeparateOES(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA, GL_ONE, GL_ONE);
                #endif
                }else{
                glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
            }
        }
        render_state.use_alpha=new_mode;
    }
    
    void set_depthbuffer(int32 new_mode){
        
        static int32 current_mode;
        current_mode=render_state.depthbuffer_mode;
        if (new_mode==current_mode) return;
        hardware_buffer_flush();
        if (new_mode==DEPTHBUFFER_MODE__OFF){
            glDisable(GL_DEPTH_TEST);
            glAlphaFunc(GL_ALWAYS, 0);
        }
        if (new_mode==DEPTHBUFFER_MODE__ON){
            glEnable(GL_DEPTH_TEST);
            glDepthMask(GL_TRUE);
            glAlphaFunc(GL_GREATER, 0.001);
            glEnable(GL_ALPHA_TEST);
        }
        if (new_mode==DEPTHBUFFER_MODE__LOCKED){
            glEnable(GL_DEPTH_TEST);
            glDepthMask(GL_FALSE);
            glAlphaFunc(GL_ALWAYS, 0);
        }
        render_state.depthbuffer_mode=new_mode;
    }
    
    void set_cull_mode(int32 new_mode){
        static int32 current_mode;
        current_mode=render_state.cull_mode;
        if (new_mode==current_mode) return;
        hardware_buffer_flush();
        if (new_mode==CULL_MODE__NONE){
            glDisable(GL_CULL_FACE);
        }
        if (new_mode==CULL_MODE__CLOCKWISE_ONLY){
            glFrontFace(GL_CW);
            if (current_mode!=CULL_MODE__ANTICLOCKWISE_ONLY) glEnable(GL_CULL_FACE);
        }
        if (new_mode==CULL_MODE__ANTICLOCKWISE_ONLY){
            glFrontFace(GL_CCW);
            if (current_mode!=CULL_MODE__CLOCKWISE_ONLY) glEnable(GL_CULL_FACE);
        }
        render_state.cull_mode=new_mode;
    }
    
    void set_view(int32 new_mode){ //set view can only be called after the correct destination is chosen
        static int32 current_mode;
        current_mode=render_state.view_mode;
        if (new_mode==current_mode) return;
        hardware_buffer_flush();
        if (new_mode==VIEW_MODE__RESET){
            glDisable(GL_TEXTURE_2D);
            glDisable(GL_ALPHA_TEST);
            glDisable(GL_BLEND);
            glDisable(GL_COLOR_MATERIAL);
            glDisable(GL_DEPTH_TEST);
            glDepthMask(GL_TRUE);
            glDisable(GL_LIGHTING);
            glFrontFace(GL_CCW);
            glCullFace(GL_BACK);
            glDisable(GL_CULL_FACE);
            glDisableClientState(GL_VERTEX_ARRAY);
            glDisableClientState(GL_TEXTURE_COORD_ARRAY);
            glAlphaFunc(GL_ALWAYS, 0);
            if (framebufferobjects_supported) glBindFramebufferEXT(GL_FRAMEBUFFER, 0);
            glBindTexture (GL_TEXTURE_2D, 0);
            glClear(GL_DEPTH_BUFFER_BIT);
            glColor4f(1.f, 1.f, 1.f, 1.f);
            glMatrixMode(GL_PROJECTION);
            glLoadIdentity();
            glMatrixMode(GL_MODELVIEW);
            glLoadIdentity();
            //invalidate current states
            set_alpha(ALPHA_MODE__UNKNOWN);
            set_depthbuffer(DEPTHBUFFER_MODE__UNKNOWN);
            set_cull_mode(CULL_MODE__UNKNOWN);
            set_render_source(INVALID_HARDWARE_HANDLE);
            set_render_dest(INVALID_HARDWARE_HANDLE);
            new_mode=VIEW_MODE__UNKNOWN;//resets are performed before unknown operations are executed
        }
        if (new_mode==VIEW_MODE__2D){
            if (current_mode!=VIEW_MODE__3D){
                glColor4f(1.0f, 1.0f, 1.0f, 1.0f);
                glDisable(GL_COLOR_MATERIAL);
                glDisable(GL_LIGHTING);
                set_alpha(ALPHA_MODE__BLEND);
                glEnable(GL_TEXTURE_2D);
                glEnableClientState(GL_VERTEX_ARRAY);
                glEnableClientState(GL_TEXTURE_COORD_ARRAY);
                glCullFace(GL_BACK);
            }
            
            
            
            
            if (render_state.dest_handle==0){
                static int32 dst_w,dst_h;
                static int32 scale_factor=0;

                #ifdef QB64_MACOSX
                    if (scale_factor==0) {
                        // by default scale_factor should be 1, but in macOS Catalina (10.15.*) scale_factor must be setted in 2
                        // * in cases where the app is executed on system with Retina Display
                        scale_factor = 1; // by default

                        // lookup for retina/5k output from system_profiler (storing all outpun in stream)
                        bool b_isRetina, b_is5k;
                        FILE* consoleStream = popen("system_profiler SPDisplaysDataType", "r");
                        if (consoleStream) {
                            char buffer[128];
                            while (!feof(consoleStream)) {
                                if (fgets(buffer, 128, consoleStream) != NULL) {
                                    string szBuffer(buffer);
                                    
                                    if (!b_isRetina) b_isRetina = (szBuffer.rfind("Retina") != ULONG_MAX);
                                    if (!b_is5k) b_is5k = (szBuffer.rfind("5K") != ULONG_MAX);
                                }
                            }
                        }
                        pclose(consoleStream);

                        if (b_isRetina || b_is5k) {
                            // apply only factor = 2 if macOS is Catalina (11.15.* // kern.osrelease 19.*)
                            char str[256];
                            size_t size = sizeof(str);
                            int ret = sysctlbyname("kern.osrelease", str, &size, NULL, 0);
                          
                            string sz_osrelease(str);
                            if (sz_osrelease.rfind("19.") == 0) scale_factor=2;
                        }
                    }
                #else
                    scale_factor=1;
                #endif

                dst_w=environment__window_width;
                dst_h=environment__window_height;
                
                //alert(dst_w);
                //alert(dst_h);
                
                glMatrixMode(GL_PROJECTION);
                glLoadIdentity();
                glOrtho(0.0, dst_w, 0.0, dst_h, -1.0, 1.0);
                glMatrixMode(GL_MODELVIEW);
                glLoadIdentity();
                glScalef(1, -1, 1);//flip vertically
                glTranslatef(0, -dst_h, 0);//move to new vertical position
                glViewport(0,0,dst_w * scale_factor,dst_h * scale_factor);
                
                
                }else{
                static hardware_img_struct* hardware_img;
                hardware_img=(hardware_img_struct*)list_get(hardware_img_handles,render_state.dest_handle);
                glMatrixMode(GL_PROJECTION);
                glLoadIdentity();
                gluOrtho2D(0, hardware_img->w, 0, hardware_img->h);
                glMatrixMode(GL_MODELVIEW);
                glLoadIdentity();
                glViewport(0,0,hardware_img->w,hardware_img->h);
            }
        }
        if (new_mode==VIEW_MODE__3D){
            if (current_mode!=VIEW_MODE__2D){
                glColor4f(1.f, 1.f, 1.f, 1.f);
                glDisable(GL_COLOR_MATERIAL);
                glDisable(GL_LIGHTING);
                set_alpha(ALPHA_MODE__BLEND);
                glEnable(GL_TEXTURE_2D);
                glEnableClientState(GL_VERTEX_ARRAY);
                glEnableClientState(GL_TEXTURE_COORD_ARRAY);
                glCullFace(GL_BACK);
            }
            if (render_state.dest_handle==0){
                static int32 dst_w,dst_h;
                dst_w=environment__window_width;
                dst_h=environment__window_height;
                glViewport(0, 0, (GLsizei)dst_w, (GLsizei)dst_h);
                glMatrixMode(GL_PROJECTION);
                glLoadIdentity();
                
                //note: the max FOV is 90-degrees (this maximum applies to the longest screen dimension)
                float fov;
                if (environment_2d__screen_scaled_width>environment_2d__screen_scaled_height){
                    fov=90.0f*((float)environment__window_width/(float)environment_2d__screen_scaled_width);
                    //convert fov from horizontal to vertical
                    fov=fov*((float)dst_h/(float)dst_w);
                    }else{
                    fov=90.0f*((float)environment__window_height/(float)environment_2d__screen_scaled_height);
                }
                gluPerspective(fov, (GLfloat)dst_w / (GLfloat)dst_h, 0.1, 10000.0); // Set the Field of view angle (in degrees), the aspect ratio of our window, and the new and far planes
                glMatrixMode(GL_MODELVIEW);
                glLoadIdentity();
                }else{
                
                static hardware_img_struct* hardware_img;
                hardware_img=(hardware_img_struct*)list_get(hardware_img_handles,render_state.dest_handle);
                
                static int32 dst_w,dst_h;
                dst_w=hardware_img->w;
                dst_h=hardware_img->h;
                glViewport(0, 0, (GLsizei)dst_w, (GLsizei)dst_h);
                glMatrixMode(GL_PROJECTION);
                glLoadIdentity();
                glScalef (1.0, -1.0, 1.0);
                //note: the max FOV is 90-degrees (this maximum applies to the longest screen dimension)
                float fov;
                if (dst_w>dst_h){
                    fov=90.0f;
                    //convert fov from horizontal to vertical
                    fov=fov*((float)dst_h/(float)dst_w);
                    }else{
                    fov=90.0f;
                }
                gluPerspective(fov, (GLfloat)dst_w / (GLfloat)dst_h, 0.1, 10000.0); // Set the Field of view angle (in degrees), the aspect ratio of our window, and the new and far planes
                glMatrixMode(GL_MODELVIEW);
                glLoadIdentity();
                //alert("3D rendering onto FBO not supported yet");
            }
        }
        render_state.view_mode=new_mode;
    }//change_render_state
    
    
    void set_render_source(int32 new_handle){
        if (new_handle==INVALID_HARDWARE_HANDLE){
            hardware_buffer_flush();
            render_state.source_handle=INVALID_HARDWARE_HANDLE;
            return;
        }
        int32 current_handle;
        current_handle=render_state.source_handle;
        
        if (current_handle==new_handle) return;
        
        hardware_buffer_flush();
        
        hardware_img_struct* hardware_img;
        hardware_img=(hardware_img_struct*)list_get(hardware_img_handles,new_handle);
        if (hardware_img->texture_handle==0) hardware_img_buffer_to_texture(new_handle);
        glBindTexture (GL_TEXTURE_2D, hardware_img->texture_handle);
        render_state.source_handle=new_handle;
        render_state.source=&hardware_img->source_state;
        
        //note: some older systems require calling glTexParameterf after textures are rebound
        if (framebufferobjects_supported==0){
            render_state.source->smooth_shrunk=SMOOTH_MODE__UNKNOWN;
            render_state.source->smooth_stretched=SMOOTH_MODE__UNKNOWN;
        }
        
    }
    
    void set_render_dest(int32 new_handle){
        if (new_handle==INVALID_HARDWARE_HANDLE){
            hardware_buffer_flush();
            render_state.dest_handle=INVALID_HARDWARE_HANDLE;
            set_view(VIEW_MODE__UNKNOWN);
            return;
        }
        //0=primary surface
        static int32 current_handle;
        current_handle=render_state.dest_handle;
        if (new_handle==current_handle) return;
        hardware_buffer_flush();
        set_view(VIEW_MODE__UNKNOWN);
        if (new_handle==0){
            if (framebufferobjects_supported) glBindFramebufferEXT(GL_FRAMEBUFFER, 0);
            render_state.dest=&dest_render_state0;
            }else{
            static hardware_img_struct* hardware_img;
            hardware_img=(hardware_img_struct*)list_get(hardware_img_handles,new_handle);
            //convert to regular texture first if necessary
            if (hardware_img->texture_handle==0) hardware_img_buffer_to_texture(new_handle);
            //does it have a dest context/FBO? if not create one
            if (hardware_img->dest_context_handle==0){
                
                static GLuint framebuffer_handle;
                framebuffer_handle=0;
                glGenFramebuffersEXT(1, &framebuffer_handle);
                glBindFramebufferEXT(GL_FRAMEBUFFER, framebuffer_handle);
                hardware_img->dest_context_handle=framebuffer_handle;
                glFramebufferTexture2DEXT(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_TEXTURE_2D, hardware_img->texture_handle, 0);
                
                //glClearColor(0.0f, 0.0f, 0.0f, 0.0f);
                //glClear(GL_COLOR_BUFFER_BIT);
                glColor4f(1.f, 1.f, 1.f, 1.f);
                
                set_render_source(INVALID_HARDWARE_HANDLE);
                
                }else{
                glBindFramebufferEXT(GL_FRAMEBUFFER, hardware_img->dest_context_handle);
            }
            render_state.dest=&hardware_img->dest_state;
        }
        render_state.dest_handle=new_handle;
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    void hardware_img_put(int32 dst_x1,int32 dst_y1,int32 dst_x2,int32 dst_y2,
    int32 src_img,int32 dst_img,
    int32 src_x1,int32 src_y1,int32 src_x2,int32 src_y2,
    int32 use_alpha,
    int32 smooth
    ){
        
        if (dst_img<0) dst_img=0;//both layers render to the primary context
        
        //ensure dst_x1/y1 represent top-left co-ordinate of destination
        static int32 swap_tmp;
        if (dst_x2<dst_x1){
            swap_tmp=dst_x2; dst_x2=dst_x1; dst_x1=swap_tmp;
            swap_tmp=src_x2; src_x2=src_x1; src_x1=swap_tmp;
        }
        if (dst_y2<dst_y1){
            swap_tmp=dst_y2; dst_y2=dst_y1; dst_y1=swap_tmp;
            swap_tmp=src_y2; src_y2=src_y1; src_y1=swap_tmp;
        }
        
        set_render_dest(dst_img);
        
        
        set_view(VIEW_MODE__2D);
        
        
        
        if (dst_img){
            //static hardware_img_struct* dst_hardware_img;
            //dst_hardware_img=(hardware_img_struct*)list_get(hardware_img_handles,dst_img);
            //(no specific action required here --area reserved for future use)
            }else{ //dest is 0
            environment_2d__window_rect_struct *rect;
            rect=environment_2d__screen_to_window_rect(dst_x1,dst_y1,dst_x2,dst_y2);
            dst_x1=rect->x1;
            dst_y1=rect->y1;
            dst_x2=rect->x2;
            dst_y2=rect->y2;
        }
        
        set_render_source(src_img);
        
        static hardware_img_struct* src_hardware_img;
        static int32 src_h,src_w;
        src_hardware_img=(hardware_img_struct*)list_get(hardware_img_handles,src_img);
        src_h=src_hardware_img->h;
        src_w=src_hardware_img->w;
        
        
        
        if (smooth){
            set_smooth(SMOOTH_MODE__SMOOTH,SMOOTH_MODE__SMOOTH);
            }else{
            set_smooth(SMOOTH_MODE__DONT_SMOOTH,SMOOTH_MODE__DONT_SMOOTH);
        }
        
        if (use_alpha){
            set_alpha(ALPHA_MODE__BLEND);
            }else{
            set_alpha(ALPHA_MODE__DONT_BLEND);
        }
        
        set_depthbuffer(DEPTHBUFFER_MODE__OFF);
        set_cull_mode(CULL_MODE__NONE);
        
        set_texture_wrap(TEXTURE_WRAP_MODE__DONT_WRAP);
        
        //adjust for render (x2 & y2 need to be one greater than the destination offset)
        dst_x2++; dst_y2++;
        
        if (src_hardware_img->source_state.PO2_fix){
            src_w=src_hardware_img->PO2_w;
            src_h=src_hardware_img->PO2_h;
        }
        
        //calc source texture co-ordinates
        static float x1f,y1f,x2f,y2f;
        if (src_x1<=src_x2){
            x1f=((float)src_x1+0.01f)/(float)src_w;
            x2f=((float)src_x2+0.99f)/(float)src_w;
            }else{
            x2f=((float)src_x2+0.01f)/(float)src_w;
            x1f=((float)src_x1+0.99f)/(float)src_w;
        }
        if (src_y1<=src_y2){
            y1f=((float)src_y1+0.01f)/(float)src_h;
            y2f=((float)src_y2+0.99f)/(float)src_h;
            }else{
            y2f=((float)src_y2+0.01f)/(float)src_h;
            y1f=((float)src_y1+0.99f)/(float)src_h;
        }
        
        //expand buffers if necessary
        if ((hardware_buffer_vertices_count+18)>hardware_buffer_vertices_max){
            hardware_buffer_vertices_max=hardware_buffer_vertices_max*2+18;
            hardware_buffer_vertices=(float*)realloc(hardware_buffer_vertices,hardware_buffer_vertices_max*sizeof(float));
        }
        if ((hardware_buffer_texcoords_count+12)>hardware_buffer_texcoords_max){
            hardware_buffer_texcoords_max=hardware_buffer_texcoords_max*2+12;
            hardware_buffer_texcoords=(float*)realloc(hardware_buffer_texcoords,hardware_buffer_texcoords_max*sizeof(float));
        }
        
        //clockwise
        hardware_buffer_vertices[hardware_buffer_vertices_count++]=dst_x1; hardware_buffer_vertices[hardware_buffer_vertices_count++]=dst_y1;
        hardware_buffer_vertices[hardware_buffer_vertices_count++]=dst_x2; hardware_buffer_vertices[hardware_buffer_vertices_count++]=dst_y1;
        hardware_buffer_vertices[hardware_buffer_vertices_count++]=dst_x1; hardware_buffer_vertices[hardware_buffer_vertices_count++]=dst_y2;
        hardware_buffer_texcoords[hardware_buffer_texcoords_count++]=x1f; hardware_buffer_texcoords[hardware_buffer_texcoords_count++]=y1f;
        hardware_buffer_texcoords[hardware_buffer_texcoords_count++]=x2f; hardware_buffer_texcoords[hardware_buffer_texcoords_count++]=y1f;
        hardware_buffer_texcoords[hardware_buffer_texcoords_count++]=x1f; hardware_buffer_texcoords[hardware_buffer_texcoords_count++]=y2f;
        
        hardware_buffer_vertices[hardware_buffer_vertices_count++]=dst_x1; hardware_buffer_vertices[hardware_buffer_vertices_count++]=dst_y2;
        hardware_buffer_vertices[hardware_buffer_vertices_count++]=dst_x2; hardware_buffer_vertices[hardware_buffer_vertices_count++]=dst_y1;
        hardware_buffer_vertices[hardware_buffer_vertices_count++]=dst_x2; hardware_buffer_vertices[hardware_buffer_vertices_count++]=dst_y2;
        hardware_buffer_texcoords[hardware_buffer_texcoords_count++]=x1f; hardware_buffer_texcoords[hardware_buffer_texcoords_count++]=y2f;
        hardware_buffer_texcoords[hardware_buffer_texcoords_count++]=x2f; hardware_buffer_texcoords[hardware_buffer_texcoords_count++]=y1f;
        hardware_buffer_texcoords[hardware_buffer_texcoords_count++]=x2f; hardware_buffer_texcoords[hardware_buffer_texcoords_count++]=y2f;
        
        
        //hardware_buffer_flush(); //uncomment for debugging only
        
    }
    
    
    
    
    
    void hardware_img_tri2d(float dst_x1,float dst_y1,float dst_x2,float dst_y2,float dst_x3,float dst_y3,
    int32 src_img,int32 dst_img,
    float src_x1,float src_y1,float src_x2,float src_y2,float src_x3,float src_y3,
    int32 use_alpha,
    int32 smooth
    ){
        
        if (dst_img<0) dst_img=0;//both layers render to the primary context
        
        set_render_dest(dst_img);
        set_view(VIEW_MODE__2D);
        
        if (dst_img){
            static hardware_img_struct* dst_hardware_img;
            dst_hardware_img=(hardware_img_struct*)list_get(hardware_img_handles,dst_img);
            
            static int32 dst_w,dst_h;
            dst_w=dst_hardware_img->w;
            dst_h=dst_hardware_img->h;
            //SEAMLESS adjustments:
            //reduce texture co-ordinates (maintaining top-left)
            //(todo)
            //NON-SEAMLESS adjustments:
            //Extend rhs/bottom row to fill extra pixel space
            //calculate extents
            int32 rx1;
            int32 rx2;
            rx1=dst_x1;
            if (dst_x2<rx1){
                rx1=dst_x2;
            }
            if (dst_x3<rx1){
                rx1=dst_x3;
            }
            rx2=dst_x1;
            if (dst_x2>rx2){
                rx2=dst_x2;
            }
            if (dst_x3>rx2){
                rx2=dst_x3;
            }
            float xr;//the multiplier for where we should be (1=no change)
            if (rx1==rx2){
                xr=1.0f;
                }else{
                xr=((float)rx2-(float)rx1+1.0)/((float)rx2-(float)rx1);
            }
            int32 ry1;
            int32 ry2;
            ry1=dst_y1;
            if (dst_y2<ry1){
                ry1=dst_y2;
            }
            if (dst_y3<ry1){
                ry1=dst_y3;
            }
            ry2=dst_y1;
            if (dst_y2>ry2){
                ry2=dst_y2;
            }
            if (dst_y3>ry2){
                ry2=dst_y3;
            }
            float yr;//the multiplier for where we should be (1=no change)
            if (ry1==ry2){
                yr=1.0f;
                }else{
                yr=((float)ry2-(float)ry1+1.0f)/((float)ry2-(float)ry1);
            }
            //apply multipliers so right-most and bottom-most rows will be filled
            static int32 basex;
            basex=rx1;
            dst_x1=qbr_float_to_long(
            ((float)(dst_x1-rx1))*xr+(float)basex
            );
            dst_x2=qbr_float_to_long(
            ((float)(dst_x2-rx1))*xr+(float)basex
            );
            dst_x3=qbr_float_to_long(
            ((float)(dst_x3-rx1))*xr+(float)basex
            );
            static int32 basey;
            basey=ry1;
            dst_y1=qbr_float_to_long(
            ((float)(dst_y1-ry1))*yr+(float)basey
            );
            dst_y2=qbr_float_to_long(
            ((float)(dst_y2-ry1))*yr+(float)basey
            );
            dst_y3=qbr_float_to_long(
            ((float)(dst_y3-ry1))*yr+(float)basey
            );
            
            }else{ //dest is 0
            
            static int32 dst_w,dst_h;
            dst_w=environment__window_width;
            dst_h=environment__window_height;
            //SEAMLESS adjustments:
            //reduce texture co-ordinates (maintaining top-left)
            //(todo)
            //NON-SEAMLESS adjustments:
            //Extend rhs/bottom row to fill extra pixel space
            //calculate extents
            int32 rx1;
            int32 rx2;
            rx1=dst_x1;
            if (dst_x2<rx1){
                rx1=dst_x2;
            }
            if (dst_x3<rx1){
                rx1=dst_x3;
            }
            rx2=dst_x1;
            if (dst_x2>rx2){
                rx2=dst_x2;
            }
            if (dst_x3>rx2){
                rx2=dst_x3;
            }
            float xr;//the multiplier for where we should be (1=no change)
            if (rx1==rx2){
                xr=1.0f;
                }else{
                xr=((float)rx2-(float)rx1+1.0)/((float)rx2-(float)rx1);
            }
            int32 ry1;
            int32 ry2;
            ry1=dst_y1;
            if (dst_y2<ry1){
                ry1=dst_y2;
            }
            if (dst_y3<ry1){
                ry1=dst_y3;
            }
            ry2=dst_y1;
            if (dst_y2>ry2){
                ry2=dst_y2;
            }
            if (dst_y3>ry2){
                ry2=dst_y3;
            }
            float yr;//the multiplier for where we should be (1=no change)
            if (ry1==ry2){
                yr=1.0f;
                }else{
                yr=((float)ry2-(float)ry1+1.0f)/((float)ry2-(float)ry1);
            }
            //apply multipliers so right-most and bottom-most rows will be filled
            static int32 basex;
            basex=
            qbr_float_to_long(
            ((float)(rx1))*environment_2d__screen_x_scale+(float)environment_2d__screen_x1
            );
            dst_x1=
            basex+
            qbr_float_to_long(
            ((float)(dst_x1-rx1))*environment_2d__screen_x_scale*xr
            );
            dst_x2=
            basex+
            qbr_float_to_long(
            ((float)(dst_x2-rx1))*environment_2d__screen_x_scale*xr
            );
            dst_x3=
            basex+
            qbr_float_to_long(
            ((float)(dst_x3-rx1))*environment_2d__screen_x_scale*xr
            );
            static int32 basey;
            basey=
            qbr_float_to_long(
            ((float)(ry1))*environment_2d__screen_y_scale+(float)environment_2d__screen_y1
            );
            dst_y1=
            basey+
            qbr_float_to_long(
            ((float)(dst_y1-ry1))*environment_2d__screen_y_scale*yr
            );
            dst_y2=
            basey+
            qbr_float_to_long(
            ((float)(dst_y2-ry1))*environment_2d__screen_y_scale*yr
            );
            dst_y3=
            basey+
            qbr_float_to_long(
            ((float)(dst_y3-ry1))*environment_2d__screen_y_scale*yr
            );
            
        }
        
        set_render_source(src_img);
        
        static hardware_img_struct* src_hardware_img;
        static int32 src_h,src_w;
        src_hardware_img=(hardware_img_struct*)list_get(hardware_img_handles,src_img);
        src_h=src_hardware_img->h;
        src_w=src_hardware_img->w;
        
        if (smooth==0){
            set_smooth(SMOOTH_MODE__DONT_SMOOTH,SMOOTH_MODE__DONT_SMOOTH);
        }
        if (smooth==1){
            set_smooth(SMOOTH_MODE__SMOOTH,SMOOTH_MODE__SMOOTH);
        }
        if (smooth==2){
            set_smooth(SMOOTH_MODE__SMOOTH,SMOOTH_MODE__DONT_SMOOTH);
        }
        if (smooth==3){
            set_smooth(SMOOTH_MODE__DONT_SMOOTH,SMOOTH_MODE__SMOOTH);
        }
        
        set_texture_wrap(TEXTURE_WRAP_MODE__WRAP);
        
        if (use_alpha){
            set_alpha(ALPHA_MODE__BLEND);
            }else{
            set_alpha(ALPHA_MODE__DONT_BLEND);
        }
        
        set_depthbuffer(DEPTHBUFFER_MODE__OFF);
        set_cull_mode(CULL_MODE__NONE);
        
        if (src_hardware_img->source_state.PO2_fix){
            src_w=src_hardware_img->PO2_w;
            src_h=src_hardware_img->PO2_h;
        }
        
        //calc source texture co-ordinates
        static float x1f,y1f,x2f,y2f,x3f,y3f;
        x1f=((float)src_x1+0.5f)/(float)src_w;
        x2f=((float)src_x2+0.5f)/(float)src_w;
        x3f=((float)src_x3+0.5f)/(float)src_w;
        y1f=((float)src_y1+0.5f)/(float)src_h;
        y2f=((float)src_y2+0.5f)/(float)src_h;
        y3f=((float)src_y3+0.5f)/(float)src_h;
        
        
        //expand buffers if necessary
        if ((hardware_buffer_vertices_count+9)>hardware_buffer_vertices_max){
            hardware_buffer_vertices_max=hardware_buffer_vertices_max*2+9;
            hardware_buffer_vertices=(float*)realloc(hardware_buffer_vertices,hardware_buffer_vertices_max*sizeof(float));
        }
        if ((hardware_buffer_texcoords_count+6)>hardware_buffer_texcoords_max){
            hardware_buffer_texcoords_max=hardware_buffer_texcoords_max*2+6;
            hardware_buffer_texcoords=(float*)realloc(hardware_buffer_texcoords,hardware_buffer_texcoords_max*sizeof(float));
        }
        
        
        
        //clockwise
        hardware_buffer_vertices[hardware_buffer_vertices_count++]=dst_x1; hardware_buffer_vertices[hardware_buffer_vertices_count++]=dst_y1;
        hardware_buffer_vertices[hardware_buffer_vertices_count++]=dst_x2; hardware_buffer_vertices[hardware_buffer_vertices_count++]=dst_y2;
        hardware_buffer_vertices[hardware_buffer_vertices_count++]=dst_x3; hardware_buffer_vertices[hardware_buffer_vertices_count++]=dst_y3;
        hardware_buffer_texcoords[hardware_buffer_texcoords_count++]=x1f; hardware_buffer_texcoords[hardware_buffer_texcoords_count++]=y1f;
        hardware_buffer_texcoords[hardware_buffer_texcoords_count++]=x2f; hardware_buffer_texcoords[hardware_buffer_texcoords_count++]=y2f;
        hardware_buffer_texcoords[hardware_buffer_texcoords_count++]=x3f; hardware_buffer_texcoords[hardware_buffer_texcoords_count++]=y3f;
        
        //hardware_buffer_flush(); //uncomment for debugging only
        
    }
    
    void clear_depthbuffer(int32 dst_img){
        hardware_buffer_flush();
        if (dst_img<0) dst_img=0;//both layers render to the primary context
        set_render_dest(dst_img);
        if (dst_img>0){
            hardware_img_requires_depthbuffer((hardware_img_struct*)list_get(hardware_img_handles,dst_img));
        }
        glClear(GL_DEPTH_BUFFER_BIT);
    }
    
    void hardware_img_tri3d(float dst_x1,float dst_y1,float dst_z1,float dst_x2,float dst_y2,float dst_z2,float dst_x3,float dst_y3,float dst_z3,
    int32 src_img,int32 dst_img,
    float src_x1,float src_y1,float src_x2,float src_y2,float src_x3,float src_y3,
    int32 use_alpha,
    int32 smooth,
    int32 cull_mode,
    int32 depthbuffer_mode
    ){
        
        if (dst_img<0) dst_img=0;//both layers render to the primary context
        
        set_render_dest(dst_img);
        set_view(VIEW_MODE__3D);
        
        if (dst_img){
            static hardware_img_struct* dst_hardware_img;
            dst_hardware_img=(hardware_img_struct*)list_get(hardware_img_handles,dst_img);
            hardware_img_requires_depthbuffer(dst_hardware_img);
            }else{ //dest is 0
        }
        
        set_render_source(src_img);
        
        static hardware_img_struct* src_hardware_img;
        static int32 src_h,src_w;
        src_hardware_img=(hardware_img_struct*)list_get(hardware_img_handles,src_img);
        src_h=src_hardware_img->h;
        src_w=src_hardware_img->w;
        
        if (smooth==0){
            set_smooth(SMOOTH_MODE__DONT_SMOOTH,SMOOTH_MODE__DONT_SMOOTH);
        }
        if (smooth==1){
            set_smooth(SMOOTH_MODE__SMOOTH,SMOOTH_MODE__SMOOTH);
        }
        if (smooth==2){
            set_smooth(SMOOTH_MODE__SMOOTH,SMOOTH_MODE__DONT_SMOOTH);
        }
        if (smooth==3){
            set_smooth(SMOOTH_MODE__DONT_SMOOTH,SMOOTH_MODE__SMOOTH);
        }
        
        set_texture_wrap(TEXTURE_WRAP_MODE__WRAP);
        
        if (use_alpha){
            set_alpha(ALPHA_MODE__BLEND);
            }else{
            set_alpha(ALPHA_MODE__DONT_BLEND);
        }
        
        set_depthbuffer(depthbuffer_mode);
        
        //on frame buffers the 3D perspective is flipped vertically reversing the cull direction
        if (dst_img>0){
            if (cull_mode==CULL_MODE__CLOCKWISE_ONLY){
                cull_mode=CULL_MODE__ANTICLOCKWISE_ONLY;
                }else{
                if (cull_mode==CULL_MODE__ANTICLOCKWISE_ONLY) cull_mode=CULL_MODE__CLOCKWISE_ONLY;
            }
        }
        
        set_cull_mode(cull_mode);
        
        if (src_hardware_img->source_state.PO2_fix){
            src_w=src_hardware_img->PO2_w;
            src_h=src_hardware_img->PO2_h;
        }
        
        //calc source texture co-ordinates
        static float x1f,y1f,x2f,y2f,x3f,y3f;
        x1f=((float)src_x1+0.5f)/(float)src_w;
        x2f=((float)src_x2+0.5f)/(float)src_w;
        x3f=((float)src_x3+0.5f)/(float)src_w;
        y1f=((float)src_y1+0.5f)/(float)src_h;
        y2f=((float)src_y2+0.5f)/(float)src_h;
        y3f=((float)src_y3+0.5f)/(float)src_h;
        
        //expand buffers if necessary
        if ((hardware_buffer_vertices_count+9)>hardware_buffer_vertices_max){
            hardware_buffer_vertices_max=hardware_buffer_vertices_max*2+9;
            hardware_buffer_vertices=(float*)realloc(hardware_buffer_vertices,hardware_buffer_vertices_max*sizeof(float));
        }
        if ((hardware_buffer_texcoords_count+6)>hardware_buffer_texcoords_max){
            hardware_buffer_texcoords_max=hardware_buffer_texcoords_max*2+6;
            hardware_buffer_texcoords=(float*)realloc(hardware_buffer_texcoords,hardware_buffer_texcoords_max*sizeof(float));
        }
        
        hardware_buffer_vertices[hardware_buffer_vertices_count++]=dst_x1; hardware_buffer_vertices[hardware_buffer_vertices_count++]=dst_y1; hardware_buffer_vertices[hardware_buffer_vertices_count++]=dst_z1;
        hardware_buffer_vertices[hardware_buffer_vertices_count++]=dst_x2; hardware_buffer_vertices[hardware_buffer_vertices_count++]=dst_y2; hardware_buffer_vertices[hardware_buffer_vertices_count++]=dst_z2;
        hardware_buffer_vertices[hardware_buffer_vertices_count++]=dst_x3; hardware_buffer_vertices[hardware_buffer_vertices_count++]=dst_y3; hardware_buffer_vertices[hardware_buffer_vertices_count++]=dst_z3;
        hardware_buffer_texcoords[hardware_buffer_texcoords_count++]=x1f; hardware_buffer_texcoords[hardware_buffer_texcoords_count++]=y1f;
        hardware_buffer_texcoords[hardware_buffer_texcoords_count++]=x2f; hardware_buffer_texcoords[hardware_buffer_texcoords_count++]=y2f;
        hardware_buffer_texcoords[hardware_buffer_texcoords_count++]=x3f; hardware_buffer_texcoords[hardware_buffer_texcoords_count++]=y3f;
        //hardware_buffer_flush(); //uncomment for debugging only
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    static int32 software_screen_hardware_frame=0;
    
    static int32 in_GLUT_DISPLAY_REQUEST=0;
    
    void GLUT_DISPLAY_REQUEST(){
        
        if (in_GLUT_DISPLAY_REQUEST){
            return;
        }
        in_GLUT_DISPLAY_REQUEST=1;
        
        #ifdef QB64_MACOSX
            if (temp_window_title_set==1) {
                glutSetWindowTitle((char*)window_title);
                temp_window_title_set=0;
            }
        #endif

        //general use variables
        static int32 i,i2,i3;
        static int32 x,y,x2,y2;
        
        //determine which software frame to display
        static int32 last_i;//the last software frame displayed
        last_i=-1;
        for (i2=0;i2<=2;i2++){
            if (display_frame[i2].state==DISPLAY_FRAME_STATE__DISPLAYING){
                last_i=i2;
            }
        }
        i=-1;
        static int64 highest_order;
        highest_order=0;
        if (last_i!=-1) highest_order=display_frame[last_i].order;//avoid any frames below the current one
        for (i2=0;i2<=2;i2++){
            if (display_frame[i2].state==DISPLAY_FRAME_STATE__READY&&display_frame[i2].order>highest_order){
                highest_order=display_frame[i2].order;
                i=i2;
            }
        }
        if (i==-1) i=last_i;
        if (i==-1){
            in_GLUT_DISPLAY_REQUEST=0;
            return;//no frames exist yet, so screen size cannot be determined, therefore no action possible
        }
        if (i!=last_i){
            for (i2=0; i2<=2;i2++){
                if (display_frame[i2].order<display_frame[i].order&&(display_frame[i2].state==DISPLAY_FRAME_STATE__DISPLAYING||display_frame[i2].state==DISPLAY_FRAME_STATE__READY)) display_frame[i2].state=DISPLAY_FRAME_STATE__EMPTY;
            }
            display_frame[i].state=DISPLAY_FRAME_STATE__DISPLAYING;
        }
        
        
        static int64 order;
        order=last_hardware_display_frame_order;
        
        static int32 first_command_prev_order=0;
        static int32 rerender_prev_hardware_frame=0;
        rerender_prev_hardware_frame=0;
        
        //if no new software frame, only proceed if there is _GL content to render
        if (last_rendered_hardware_display_frame_order==last_hardware_display_frame_order){
            if (i==last_i){
                if (full_screen_set==-1){//no pending full-screen changes
                    if (os_resize_event==0){//no resize events
                        #ifndef DEPENDENCY_GL //we aren't using SUB _GL
                            in_GLUT_DISPLAY_REQUEST=0;
                            return;
                        #endif
                        if (displayorder_glrender==0){
                            in_GLUT_DISPLAY_REQUEST=0;
                            return;
                        }
                        if (first_command_prev_order){
                            rerender_prev_hardware_frame=1;
                            //reset next command to prev hardware frame's handle (if any)
                            last_hardware_command_rendered=first_command_prev_order;
                        }
                        
                    }
                }
            }
        }
        
        first_command_prev_order=0;
        
        
        //set environment variables
        environment_2d__screen_width=display_frame[i].w;
        environment_2d__screen_height=display_frame[i].h;
        
        
        
        
        
        
        
        
        
        
        
        os_resize_event=0;//turn off flag which forces a render to take place even if no content has changed
        
        
        
        
        
        if ((full_screen==0)&&(full_screen_set==-1)){//not in (or attempting to enter) full screen
            
            display_required_x=display_frame[i].w; display_required_y=display_frame[i].h;
            static int32 framesize_changed;
            framesize_changed=0;
            if ((display_required_x!=resize_snapback_x)||(display_required_y!=resize_snapback_y)) framesize_changed=1;
            
            
            resize_auto_ideal_aspect=(float)display_frame[i].w/(float)display_frame[i].h;
            resize_snapback_x=display_required_x; resize_snapback_y=display_required_y;
            
            
            
            if (resize_auto){
                //maintain aspect ratio
                static float ar;
                ar=(float)display_x/(float)display_y;
                if ((ar!=resize_auto_accept_aspect)&&(ar!=resize_auto_ideal_aspect)){
                    //set new size
                    static int32 x,y;
                    if (display_x_prev==display_x){
                        y=display_y;
                        x=(float)y*resize_auto_ideal_aspect;
                    }
                    if (display_y_prev==display_y){
                        x=display_x;
                        y=(float)x/resize_auto_ideal_aspect;
                    }
                    if ((display_y_prev!=display_y)&&(display_x_prev!=display_x)){
                        if (abs(display_y_prev-display_y)<abs(display_x_prev-display_x)){
                            x=display_x;
                            y=(float)x/resize_auto_ideal_aspect;
                            }else{
                            y=display_y;
                            x=(float)y*resize_auto_ideal_aspect;
                        }
                    }
                    resize_auto_accept_aspect=(float)x/(float)y;
                    resize_pending=1;
                    glutReshapeWindow(x,y);
                    glutPostRedisplay();
                    
                    
                    
                    goto auto_resized;
                }
            }//resize_auto
            
            
            
            if ((display_required_x!=display_x)||(display_required_y!=display_y)){
                if (resize_snapback||framesize_changed){
                    glutReshapeWindow(display_required_x,display_required_y);
                    glutPostRedisplay();
                    resize_pending=1;
                }
            }
            
            
            
            auto_resized:;
            
        }//not in (or attempting to enter) full screen
        
        //Pseudo-Fullscreen
        if (!resize_pending){//avoid switching to fullscreen before resize operations take effect
            if (full_screen_set!=-1){//full screen mode change requested
                if (full_screen_set==0){
                    if (full_screen!=0){
                        //exit full screen
                        resize_pending=1;
                        glutReshapeWindow(display_frame[i].w,display_frame[i].h);
                        glutPostRedisplay();
                    }
                    full_screen=0;
                    full_screen_set=-1;
                    }else{
                    if (full_screen==0){
                        glutFullScreen();
                    }
                    full_screen=full_screen_set;
                    full_screen_set=-1;
                }//enter full screen
            }//full_screen_set check
        }//size pending check
        
        
        
        
        
        
        //This code is deprecated but kept for reference purposes
        // 1) It was found to be unstable
        // 2) Switching modes means a high chance of losing pre-loaded OpenGL hardware textures/surfaces
        /*
            static int32 glut_window;
            //fullscreen
            if (!resize_pending){//avoid switching to fullscreen before resize operations take effect
            if (full_screen_set!=-1){//full screen mode change requested
            if (full_screen_set==0){
            //exit full screen
            glutLeaveGameMode();
            glutSetWindow(glut_window);
            reinit_glut_callbacks();
            full_screen=0;
            full_screen_set=-1;
            return;
            }else{
            static char game_mode_string[1000];
            static int32 game_mode_string_i;
            game_mode_string_i=0;
            game_mode_string_i+=sprintf(&game_mode_string[game_mode_string_i], "%d", display_frame[i].w);
            game_mode_string[game_mode_string_i++]=120;//"x"
            game_mode_string_i+=sprintf(&game_mode_string[game_mode_string_i], "%d", display_frame[i].h);
            game_mode_string[game_mode_string_i++]=58;//":"
            game_mode_string_i+=sprintf(&game_mode_string[game_mode_string_i], "%d", 32);
            glutGameModeString(game_mode_string);
            if(glutGameModeGet(GLUT_GAME_MODE_POSSIBLE)){
            //full screen using native dimensions which match the frame size
            if (full_screen==0) glut_window=glutGetWindow();
            glutEnterGameMode();
            fullscreen_width=display_frame[i].w; fullscreen_height=display_frame[i].h;
            reinit_glut_callbacks();
            full_screen=full_screen_set;//it's currently irrelavent if it is stretched or 1:1
            full_screen_set=-1;
            return;
            }else{ //native dimensions not possible
            //attempt full screen using desktop dimensions
            static int32 w; w=glutGet(GLUT_SCREEN_WIDTH);
            static int32 h; h=glutGet(GLUT_SCREEN_HEIGHT);
            game_mode_string_i=0;
            game_mode_string_i+=sprintf(&game_mode_string[game_mode_string_i], "%d", w);
            game_mode_string[game_mode_string_i++]=120;//"x"
            game_mode_string_i+=sprintf(&game_mode_string[game_mode_string_i], "%d", h);
            game_mode_string[game_mode_string_i++]=58;//":"
            game_mode_string_i+=sprintf(&game_mode_string[game_mode_string_i], "%d", 32);
            glutGameModeString(game_mode_string);
            if(glutGameModeGet(GLUT_GAME_MODE_POSSIBLE)){
            //full screen using desktop dimensions
            if (full_screen==0) glut_window=glutGetWindow();
            glutEnterGameMode();
            fullscreen_width=w; fullscreen_height=h;
            reinit_glut_callbacks();
            screen_scale=full_screen_set;
            full_screen=full_screen_set;
            full_screen_set=-1;
            return;
            }else{
            //cannot enter full screen
            full_screen=0;
            full_screen_set=-1;
            }
            }
            }//enter full screen
            }//full_screen_set check
            }//size pending check
        */
        
        
        
        
        
        
        
        //set window environment variables
        environment__window_width=display_x;
        environment__window_height=display_y;
        
        prepare_environment_2d();
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        //need a few variables here
        
        
        
        
        static int32 first_hardware_layer_rendered;
        static int32 first_hardware_layer_command;
        first_hardware_layer_rendered=0;
        first_hardware_layer_command=0;
        
        static int32 level; for (level=0; level<=5; level++){
            
            static int32 x1,y1,x2,y2;
            
            if (level==0){
                set_render_dest(0);
                glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT);
                }else{
                
                if (level==displayorder_glrender){
                    #ifdef DEPENDENCY_GL
                        
                        set_view(VIEW_MODE__RESET);
                        
                        if (close_program||dont_call_sub_gl||suspend_program||stop_program) goto abort_gl;
                        display_lock_request++;
                        while (display_lock_confirmed<display_lock_request){
                            if (close_program||dont_call_sub_gl||suspend_program||stop_program) goto abort_gl;
                            qbevent=1; Sleep(0);
                        }
                        sub_gl_called=1;
                        SUB__GL();
                        sub_gl_called=0;
                        abort_gl:;
                        display_lock_released=display_lock_confirmed;
                        
                    #endif //DEPENDENCY_GL
                }//level==displayorder_glrender
                
                
                if (level==displayorder_screen){//defaults to 1
                    
                    if (software_screen_hardware_frame!=0&&i!=last_i){
                        free_hardware_img(software_screen_hardware_frame, 847001);
                    }
                    if (i!=last_i||software_screen_hardware_frame==0){
                        software_screen_hardware_frame=new_hardware_img(display_frame[i].w, display_frame[i].h,display_frame[i].bgra,NULL);
                    }
                    
                    static hardware_img_struct* f1;
                    f1=(hardware_img_struct*)list_get(hardware_img_handles,software_screen_hardware_frame);
                    if (software_screen_hardware_frame==0){
                        alert("Invalid software_screen_hardware_frame!!");
                    }
                    if (f1==NULL) alert("Invalid software_screen_hardware_frame!");
                    
                    static int32 use_alpha;
                    use_alpha=0; if (level>1) use_alpha=1;
                    
                    
                    
                    //put the software screen
                    hardware_img_put(0,0,environment_2d__screen_width-1,environment_2d__screen_height-1,
                    software_screen_hardware_frame, 0,
                    0,0,f1->w-1,f1->h-1,
                    use_alpha,environment_2d__screen_smooth);
                    hardware_buffer_flush();
                    
                    
                }//level==displayorder_screen
                
                
                if (level==displayorder_hardware||level==displayorder_hardware1){
                    
                    static int32 dst;
                    dst=0; if (level==displayorder_hardware1) dst=-1;
                    
                    static int32 command;
                    command=0;
                    
                    static int32 caller_flag;
                    caller_flag=0;
                    
                    if (first_hardware_layer_rendered==0){
                        
                        if (first_hardware_command){
                            
                            if (last_hardware_command_rendered){
                                
                                if (rerender_prev_hardware_frame){
                                    command=last_hardware_command_rendered;
                                    caller_flag=100;
                                    }else{
                                    hardware_graphics_command_struct* last_hgc=(hardware_graphics_command_struct*)list_get(hardware_graphics_command_handles,last_hardware_command_rendered);
                                    if (last_hgc==NULL) alert("Rendering: Last HGC is NULL!");
                                    command=last_hgc->next_command;
                                    caller_flag=200;
                                }
                                
                                }else{
                                
                                command=first_hardware_command;
                                caller_flag=300;
                            }
                            
                            //process/skip pending hardware puts before this frame's order value
                            while (command){
                                hardware_graphics_command_struct* hgc=(hardware_graphics_command_struct*)list_get(hardware_graphics_command_handles,command);
                                if (hgc->order<order){
                                    
                                    if (hgc->command==HARDWARE_GRAPHICS_COMMAND__FREEIMAGE){
                                        free_hardware_img(hgc->src_img, 847002+caller_flag);
                                    }
                                    
                                    if (hgc->command==HARDWARE_GRAPHICS_COMMAND__PUTIMAGE){
                                        if (hgc->dst_img>0){ //note: rendering to the old default surface is pointless, but renders onto maintained hardware images are still required
                                            hardware_img_put(hgc->dst_x1,hgc->dst_y1,hgc->dst_x2,hgc->dst_y2,
                                            hgc->src_img, hgc->dst_img,
                                            hgc->src_x1,hgc->src_y1,hgc->src_x2,hgc->src_y2,
                                            hgc->use_alpha,hgc->smooth);
                                        }
                                    }
                                    
                                    if (hgc->command==HARDWARE_GRAPHICS_COMMAND__MAPTRIANGLE){
                                        if (hgc->dst_img>0){ //note: rendering to the old default surface is pointless, but renders onto maintained hardware images are still required
                                            hardware_img_tri2d(hgc->dst_x1,hgc->dst_y1,hgc->dst_x2,hgc->dst_y2,hgc->dst_x3,hgc->dst_y3,
                                            hgc->src_img, hgc->dst_img,
                                            hgc->src_x1,hgc->src_y1,hgc->src_x2,hgc->src_y2,hgc->src_x3,hgc->src_y3,
                                            hgc->use_alpha,hgc->smooth);
                                        }
                                    }
                                    
                                    if (hgc->command==HARDWARE_GRAPHICS_COMMAND__MAPTRIANGLE3D){
                                        if (hgc->dst_img>0){ //note: rendering to the old default surface is pointless, but renders onto maintained hardware images are still required
                                            hardware_img_tri3d(hgc->dst_x1,hgc->dst_y1,hgc->dst_z1,hgc->dst_x2,hgc->dst_y2,hgc->dst_z2,hgc->dst_x3,hgc->dst_y3,hgc->dst_z3,
                                            hgc->src_img, hgc->dst_img,
                                            hgc->src_x1,hgc->src_y1,hgc->src_x2,hgc->src_y2,hgc->src_x3,hgc->src_y3,
                                            hgc->use_alpha,hgc->smooth,hgc->cull_mode,hgc->depthbuffer_mode);
                                        }
                                    }
                                    
                                    if (hgc->command==HARDWARE_GRAPHICS_COMMAND__CLEAR_DEPTHBUFFER){
                                        if (hgc->dst_img>0){ //note: rendering to the old default surface is pointless, but renders onto maintained hardware images are still required
                                            clear_depthbuffer(hgc->dst_img);
                                        }
                                    }
                                    
                                    last_hardware_command_rendered=command;
                                    if (next_hardware_command_to_remove==0) next_hardware_command_to_remove=command;
                                    command=hgc->next_command;
                                    hgc->remove=1;
                                    }else{
                                    goto found_command_from_current_order;
                                }
                            }
                            found_command_from_current_order:;
                            
                        }//first_hardware_command
                        
                        
                        first_hardware_layer_command=command;
                        }else{
                        command=first_hardware_layer_command;
                    }
                    
                    //process pending hardware puts for this frame's order value
                    while (command){
                        hardware_graphics_command_struct* hgc=(hardware_graphics_command_struct*)list_get(hardware_graphics_command_handles,command);
                        if (hgc==NULL){
                            
                            hardware_graphics_command_struct* hgcx=(hardware_graphics_command_struct*)list_get(hardware_graphics_command_handles,next_hardware_command_to_remove);
                            alert(order);
                            alert(hgcx->order);
                            alert(command);
                            alert ("Renderer: Command does not exist.");
                        }
                        if (hgc->order==order){
                            if (first_command_prev_order==0) first_command_prev_order=command;
                            
                            if (hgc->command==HARDWARE_GRAPHICS_COMMAND__FREEIMAGE&&rerender_prev_hardware_frame==0&&first_hardware_layer_rendered==0){
                                free_hardware_img(hgc->src_img, 847003);
                            }
                            
                            if (hgc->command==HARDWARE_GRAPHICS_COMMAND__PUTIMAGE){
                                if (rerender_prev_hardware_frame==0||hgc->dst_img<=0){
                                    if ((hgc->dst_img>0&&first_hardware_layer_rendered==0)||hgc->dst_img==dst){
                                        hardware_img_put(hgc->dst_x1,hgc->dst_y1,hgc->dst_x2,hgc->dst_y2,
                                        hgc->src_img, hgc->dst_img,
                                        hgc->src_x1,hgc->src_y1,hgc->src_x2,hgc->src_y2,
                                        hgc->use_alpha,hgc->smooth);
                                    }
                                }
                            }
                            
                            if (hgc->command==HARDWARE_GRAPHICS_COMMAND__MAPTRIANGLE){
                                if (rerender_prev_hardware_frame==0||hgc->dst_img<=0){
                                    if ((hgc->dst_img>0&&first_hardware_layer_rendered==0)||hgc->dst_img==dst){
                                        hardware_img_tri2d(hgc->dst_x1,hgc->dst_y1,hgc->dst_x2,hgc->dst_y2,hgc->dst_x3,hgc->dst_y3,
                                        hgc->src_img, hgc->dst_img,
                                        hgc->src_x1,hgc->src_y1,hgc->src_x2,hgc->src_y2,hgc->src_x3,hgc->src_y3,
                                        hgc->use_alpha,hgc->smooth);
                                    }
                                }
                            }
                            
                            if (hgc->command==HARDWARE_GRAPHICS_COMMAND__MAPTRIANGLE3D){
                                if (rerender_prev_hardware_frame==0||hgc->dst_img<=0){
                                    if ((hgc->dst_img>0&&first_hardware_layer_rendered==0)||hgc->dst_img==dst){
                                        hardware_img_tri3d(hgc->dst_x1,hgc->dst_y1,hgc->dst_z1,hgc->dst_x2,hgc->dst_y2,hgc->dst_z2,hgc->dst_x3,hgc->dst_y3,hgc->dst_z3,
                                        hgc->src_img, hgc->dst_img,
                                        hgc->src_x1,hgc->src_y1,hgc->src_x2,hgc->src_y2,hgc->src_x3,hgc->src_y3,
                                        hgc->use_alpha,hgc->smooth,hgc->cull_mode,hgc->depthbuffer_mode);
                                    }
                                }
                            }
                            
                            if (hgc->command==HARDWARE_GRAPHICS_COMMAND__CLEAR_DEPTHBUFFER){
                                if (rerender_prev_hardware_frame==0||hgc->dst_img<=0){
                                    if ((hgc->dst_img>0&&first_hardware_layer_rendered==0)||hgc->dst_img==dst){
                                        clear_depthbuffer(hgc->dst_img);
                                    }
                                }
                            }
                            
                            last_hardware_command_rendered=command;
                            if (next_hardware_command_to_remove==0) next_hardware_command_to_remove=command;//!!!! should be prev to this command
                            command=hgc->next_command;
                            hgc->remove=1;
                            }else{
                            goto finished_all_commands_for_current_frame;
                        }
                        
                        
                    }
                    finished_all_commands_for_current_frame:;
                    
                    first_hardware_layer_rendered=1;
                    
                    
                    
                    hardware_buffer_flush();
                }//level==displayorder_hardware||level==displayorder_hardware1
                
                
                if (level==5){
                    
                    if (environment_2d__letterbox){
                        
                        //create a black texture (if not yet created)
                        static uint32 black_pixel=0x00000000;
                        static int32 black_texture=0;
                        if (black_texture==0){
                            black_texture=new_hardware_img(1,1,&black_pixel,NULL);
                        }
                        
                        if (environment_2d__letterbox==1){
                            //vertical stripes
                            hardware_img_put(((float)-environment_2d__screen_x1)/environment_2d__screen_x_scale-1.0f,0,-1,environment_2d__screen_height-1,
                            black_texture, 0,
                            0,0,0,0,
                            0,0);
                            hardware_img_put(environment_2d__screen_width,0,(((float)-environment_2d__screen_x1)+(float)environment__window_width-1.0f)/environment_2d__screen_x_scale+1.0f,environment_2d__screen_height-1,
                            black_texture, 0,
                            0,0,0,0,
                            0,0);
                            }else{
                            //horizontal stripes
                            hardware_img_put(0,((float)-environment_2d__screen_y1)/environment_2d__screen_y_scale-1.0f,environment_2d__screen_width-1,-1,
                            black_texture, 0,
                            0,0,0,0,
                            0,0);
                            hardware_img_put(0,environment_2d__screen_height,environment_2d__screen_width-1,(((float)-environment_2d__screen_y1)+(float)environment__window_height-1.0f)/environment_2d__screen_y_scale+1.0f,
                            black_texture, 0,
                            0,0,0,0,
                            0,0);
                        }
                        hardware_buffer_flush();
                    }//letterbox
                    
                }//level==5
                
                
            }//level!=0
        }//level loop
        
        if (requestedKeyboardOverlayImage){
            int32 src=requestedKeyboardOverlayImage-HARDWARE_IMG_HANDLE_OFFSET;
            hardware_img_struct* src_hardware_img;
            src_hardware_img=(hardware_img_struct*)list_get(hardware_img_handles,src);
            /*
                hardware_img_put(0,0,src_hardware_img->w-1,src_hardware_img->h-1,
                src, 0,
                0,0,src_hardware_img->w-1,src_hardware_img->h-1,
                1,0);
            */
            hardware_img_put(0,0,environment_2d__screen_width-1,environment_2d__screen_height-1,
            src, 0,
            0,0,src_hardware_img->w-1,src_hardware_img->h-1,
            1,0);
            hardware_buffer_flush();
        }
        
        last_rendered_hardware_display_frame_order=last_hardware_display_frame_order;
        
        
        
        if (suspend_program){ //Otherwise skipped SUB__GL content becomes "invisible"
            //...
            }else{
            glutSwapBuffers();
        }
        
        in_GLUT_DISPLAY_REQUEST=0;
        
    }//GLUT_DISPLAY_REQUEST
    
    
    
    
    
    void GLUT_MouseButton_Up(int button,int x,int y){
        #ifdef QB64_GLUT
            int32 i;
            int32 handle;
            handle=mouse_message_queue_first;
            mouse_message_queue_struct *queue=(mouse_message_queue_struct*)list_get(mouse_message_queue_handles,handle);
            
            i=queue->last+1; if (i>queue->lastIndex) i=0;
            if (i==queue->current){
                int32 nextIndex=queue->last+1; if (nextIndex>queue->lastIndex) nextIndex=0;
                queue->current=nextIndex;
            }
            queue->queue[i].x=x;
            queue->queue[i].y=y;
            queue->queue[i].movementx=0;
            queue->queue[i].movementy=0;
            queue->queue[i].buttons=queue->queue[queue->last].buttons;
            if (queue->queue[i].buttons&(1<<(button-1))) queue->queue[i].buttons^=(1<<(button-1));
            queue->last=i;
            
            if (device_last){//core devices required?
                if ((button>=1)&&(button<=3)){
                    button--;
                    static device_struct *d;
                    d=&devices[2];//mouse
                    
                    int32 eventIndex=createDeviceEvent(d);
                    setDeviceEventButtonValue(d,eventIndex,button,0);
                    commitDeviceEvent(d);
                    
                }//valid range
            }//core devices required
            
        #endif
    }
    
    void GLUT_MouseButton_Down(int button,int x,int y){
        #ifdef QB64_GLUT
            
            int32 i;
            int32 handle;
            handle=mouse_message_queue_first;
            mouse_message_queue_struct *queue=(mouse_message_queue_struct*)list_get(mouse_message_queue_handles,handle);
            
            i=queue->last+1; if (i>queue->lastIndex) i=0;
            if (i==queue->current){
                int32 nextIndex=queue->last+1; if (nextIndex>queue->lastIndex) nextIndex=0;
                queue->current=nextIndex;
            }
            queue->queue[i].x=x;
            queue->queue[i].y=y;
            queue->queue[i].movementx=0;
            queue->queue[i].movementy=0;
            queue->queue[i].buttons=queue->queue[queue->last].buttons;
            queue->queue[i].buttons|=(1<<(button-1));
            queue->last=i;
            
            if (device_last){//core devices required?
                if ((button>=1)&&(button<=3)){
                    button--;
                    static device_struct *d;
                    d=&devices[2];//mouse
                    
                    int32 eventIndex=createDeviceEvent(d);
                    setDeviceEventButtonValue(d,eventIndex,button,1);
                    commitDeviceEvent(d);
                    
                    //1-3
                    }else{
                    //not 1-3
                    //mouse wheel?
                    if ((button>=4)&&(button<=5)){
                        static float f;
                        if (button==4) f=-1; else f=1;
                        static device_struct *d;
                        d=&devices[2];//mouse
                        
                        int32 eventIndex=createDeviceEvent(d);
                        setDeviceEventWheelValue(d,eventIndex,2,f);
                        commitDeviceEvent(d);
                        
                        eventIndex=createDeviceEvent(d);
                        setDeviceEventWheelValue(d,eventIndex,2,0);
                        commitDeviceEvent(d);
                        
                    }//4-5
                }//not 1-3
            }//core devices required
        #endif
    }
    
    void GLUT_MOUSE_FUNC(int glut_button,int state,int x,int y){
        #ifdef QB64_GLUT
            if (state==GLUT_DOWN) GLUT_MouseButton_Down(glut_button + 1,x,y);
            if (state==GLUT_UP) GLUT_MouseButton_Up(glut_button + 1,x,y);
        #endif
    }
    
    void GLUT_MOTION_FUNC(int x, int y){
        
        int32 i, last_i;
        int32 handle;
        int32 xrel, yrel;
        handle=mouse_message_queue_first;
        mouse_message_queue_struct *queue=(mouse_message_queue_struct*)list_get(mouse_message_queue_handles,handle);
        
        //message #1
        last_i=queue->last;
        i=queue->last+1; if (i>queue->lastIndex) i=0; //wrap around
        if (i==queue->current){
            int32 nextIndex=queue->last+1;
            if (nextIndex>queue->lastIndex) nextIndex=0;
            queue->current=nextIndex;
        }
        #ifdef QB64_WINDOWS
        // Windows calculates relative movement by intercepting WM_INPUT events instead
        xrel = 0;
        yrel = 0;
        #else
        xrel = x - queue->queue[queue->last].x;
        yrel = y - queue->queue[queue->last].y;
        #endif

        queue->queue[i].x=x;
        queue->queue[i].y=y;
        queue->queue[i].movementx=xrel;
        queue->queue[i].movementy=yrel;
        queue->queue[i].buttons=queue->queue[last_i].buttons;
        queue->last=i;
        
        //message #2 (clears movement values to avoid confusion)
        last_i=queue->last;
        i=queue->last+1; if (i>queue->lastIndex) i=0;
        if (i==queue->current){
            int32 nextIndex=queue->last+1; if (nextIndex>queue->lastIndex) nextIndex=0;
            queue->current=nextIndex;
        }
        queue->queue[i].x=x;
        queue->queue[i].y=y;
        queue->queue[i].movementx=0;
        queue->queue[i].movementy=0;
        queue->queue[i].buttons=queue->queue[last_i].buttons;
        queue->last=i;
        
        if (device_last){//core devices required?
            if (!device_mouse_relative){
                static device_struct *d;
                d=&devices[2];//mouse
                
                int32 eventIndex=createDeviceEvent(d);
                static float fx,fy;
                static int32 z;
                fx=x;
                fx-=x_offset;
                z=x_monitor-x_offset*2;
                if (fx<0) fx=0;
                if (fx>=z) fx=z-1;
                fx=fx/(float)(z-1);//0 to 1
                fx*=2.0;//0 to 2
                fx-=1.0;//-1 to 1
                fy=y;
                fy-=y_offset;
                z=y_monitor-y_offset*2;
                if (fy<0) fy=0;
                if (fy>=z) fy=z-1;
                fy=fy/(float)(z-1);//0 to 1
                fy*=2.0;//0 to 2
                fy-=1.0;//-1 to 1
                setDeviceEventAxisValue(d,eventIndex,0,fx);
                setDeviceEventAxisValue(d,eventIndex,1,fy);
                commitDeviceEvent(d);
                
                }else{
                static device_struct *d;
                d=&devices[2];//mouse
                
                int32 eventIndex=createDeviceEvent(d);
                static float fx,fy;
                static int32 z;
                fx=xrel;
                fy=yrel;
                setDeviceEventWheelValue(d,eventIndex,0,fx);
                setDeviceEventWheelValue(d,eventIndex,1,fy);
                commitDeviceEvent(d);
                
                eventIndex=createDeviceEvent(d);
                fx=0;
                fy=0;
                setDeviceEventWheelValue(d,eventIndex,0,fx);
                setDeviceEventWheelValue(d,eventIndex,1,fy);
                commitDeviceEvent(d);
                
            }
        }//core devices required
    }
    
    void GLUT_PASSIVEMOTION_FUNC(int x, int y){
        GLUT_MOTION_FUNC(x,y);
    }
    
    
    void GLUT_MOUSEWHEEL_FUNC(int wheel, int direction, int x, int y){
        #ifdef QB64_GLUT
            //Note: freeglut specific, limited documentation existed so the following research was done:
            //  qbs_print(qbs_str(wheel),NULL); <-- was always 0 [could 1 indicate horizontal wheel?]
            //  qbs_print(qbs_str(direction),NULL); <-- 1(up) or -1(down)
            //  qbs_print(qbs_str(x),NULL); <--mouse x,y co-ordinates
            //  qbs_print(qbs_str(y),1);    <
            if (direction>0){GLUT_MouseButton_Down(4,x,y); GLUT_MouseButton_Up(4,x,y);}
            if (direction<0){GLUT_MouseButton_Down(5,x,y); GLUT_MouseButton_Up(5,x,y);}
        #endif
    }
    
    
    
    
    
    
    
    
    
    
#endif
