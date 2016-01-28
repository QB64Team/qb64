//[ ]what if no glyph index could be found and it returns 0??
//[ ]FT_Done_Face
//[ ]Check for memory leaks




#ifndef DEPENDENCY_LOADFONT
//Stubs
int32 FontRenderTextUTF32(int32 i,uint32*codepoint,int32 codepoints,int32 options,
                          uint8**out_data,int32*out_x,int32 *out_y,int32*out_x_pre_increment,int32*out_x_post_increment){return NULL;}
int32 FontLoad (uint8 *content_original,int32 content_bytes,int32 default_pixel_height,int32 which_font,int32 options){return NULL;}
int32 FontRenderTextASCII(int32 i,uint8*codepoint,int32 codepoints,int32 options,
                          uint8**out_data,int32*out_x,int32 *out_y,int32*out_x_pre_increment,int32*out_x_post_increment){return NULL;}
int32 FontWidth(int32 i){return NULL;}
void FontFree(int32 i){return;}
#else

#ifdef QB64_BACKSLASH_FILESYSTEM
 #include "src\\freetypeamalgam.h"
#else
 #include "src/freetypeamalgam.h"
#endif
FT_Library ft_library;

struct fonts_struct{
uint8 in_use;
uint8 *ttf_data;
int32 default_pixel_height;
uint8 bold;
uint8 italic;
uint8 underline;
uint8 monospace;
int32 monospace_width;
uint8 unicode;
//---------------------------------
FT_Face handle;
int32 baseline;
float default_pixel_height_scale;
};
fonts_struct *fonts=(fonts_struct*)malloc(1);
int32 fonts_last=0;

struct fonts_render_struct{
uint8 *data;
int32 w;
int32 ox;
};

//Master rendering routine (to be called by all other functions)
int32 FontRenderTextUTF32(int32 i,uint32*codepoint,int32 codepoints,int32 options,
                          uint8**out_data,int32*out_x,int32 *out_y,int32*out_x_pre_increment,int32*out_x_post_increment){
//Notes:
// returns: success{1}/failure{0}
// options: 1=black{0}&white{255}
// out_x_increment: the ideal amount to move across horizontally after drawing the text
// out_data: alpha values for each pixel of the font

if (codepoints<=0){
 *out_data=NULL;
 *out_x=0;
 *out_y=fonts[i].default_pixel_height;
 *out_x_pre_increment=0;
 *out_x_post_increment=0;
 if (codepoints<0) return 0;
 return 1;
}

static int32 monochrome;
monochrome=options&1;

static int32 codepoint_w;
static int32 codepoint_i,codepoint_ox;
static uint32 codepoint_value;
static fonts_render_struct *render;
static int32 value;
static uint8 *data1,*data2;
static int w1,h1,ox,oy; //Note: Must be 'int' type
static int32 w2,h2,ox2,oy2;
static int32 x1,y1;
static int32 x2,y2;

if (codepoints>1){
 render=(fonts_render_struct*)malloc(sizeof(fonts_render_struct)*codepoints);
}

codepoint_w=0;
codepoint_ox=0;
for (codepoint_i=0;codepoint_i<codepoints;codepoint_i++){
codepoint_value=codepoint[codepoint_i];

static int32 glyph_index;
glyph_index=FT_Get_Char_Index(fonts[i].handle,codepoint_value);
if (!glyph_index){
//failed!
}
if (FT_Load_Glyph(fonts[i].handle,glyph_index,FT_LOAD_DEFAULT)){
//failed!
}

if (monochrome){

if(FT_Render_Glyph(fonts[i].handle->glyph, FT_RENDER_MODE_MONO)){
//failed!
}

}else{

if(FT_Render_Glyph(fonts[i].handle->glyph, FT_RENDER_MODE_NORMAL)){
//failed!
}

}

static int32 pitch1;
pitch1=fonts[i].handle->glyph->bitmap.pitch;

ox=fonts[i].handle->glyph->bitmap_left;
oy=0;
h1=fonts[i].handle->glyph->bitmap.rows;
w1=fonts[i].handle->glyph->bitmap.width;
data1=(uint8*)fonts[i].handle->glyph->bitmap.buffer;

h2=fonts[i].default_pixel_height;

w2=fonts[i].handle->glyph->advance.x/64;//default width
if (w2<w1) w2=w1;
ox2=0;
if (ox>0){
if ((w1+ox)>w2) w2=w1+ox;
ox2=ox;
}
if (ox<0){//compensate for loss of width from left shift
w2=w2+(-ox);
}

//Monospace resize as necessary
if (fonts[i].monospace){
if (w2!=fonts[i].monospace_width){
w2=fonts[i].monospace_width;
ox=0;//no repositioning possible
ox2=w2/2-w1/2;//align to centre
}
}

data2=(uint8*)calloc(w2*h2,1);

oy2=fonts[i].baseline - fonts[i].handle->glyph->bitmap_top;

for (y1=0;y1<h1;y1++){
y2=y1+oy2;
if ((y2>=0)&&(y2<h2)){
for (x1=0;x1<w1;x1++){
x2=x1+ox2;
if ((x2>=0)&&(x2<w2)){

if (monochrome){
data2[x2+y2*w2] = (( data1[y1*pitch1 + x1/8] >> (7-(x1&7)) )&1) * 255;//1-bit
}else{
data2[x2+y2*w2]=data1[x1+y1*pitch1];//8-bit
}

}
}//x1
}
}//y1

//single character render?
if (codepoints==1){
 *out_data=data2;
 *out_x=w2;
 *out_y=h2;
 if (ox<0) *out_x_pre_increment=ox; else *out_x_pre_increment=0;
 *out_x_post_increment=0;
 return 1;
}

if (codepoint_i==0){
 if (ox<0){
  *out_x_pre_increment=ox;
 }else{
  *out_x_pre_increment=0;
 }
}else{
 if (ox<0){//regress codepoint_ox?
  if ((codepoint_ox+ox)>=0){
   codepoint_ox+=ox;
  }else{
   codepoint_ox=0;
  }
 }
}
render[codepoint_i].data=data2;
render[codepoint_i].w=w2;
render[codepoint_i].ox=codepoint_ox;
codepoint_ox+=w2;
if (codepoint_ox>codepoint_w) codepoint_w=codepoint_ox;

}//codepointi loop

//join&'blend' multiple codepoints
w2=codepoint_w; h2=fonts[i].default_pixel_height;
data2=(uint8*)calloc(w2*h2,1);
for (codepoint_i=0;codepoint_i<codepoints;codepoint_i++){

data1=render[codepoint_i].data;
w1=render[codepoint_i].w;
h1=h2;

ox2=render[codepoint_i].ox;

for (y1=0;y1<h1;y1++){
y2=y1;
for (x1=0;x1<w1;x1++){
x2=x1+ox2;
value=data1[x1+y1*w1];
if (value>data2[x2+y2*w2]) data2[x2+y2*w2]=value;
}//x1
}//y1
free(data1);

}//codepoint_i

*out_data=data2;
*out_x=w2;
*out_y=h2;
//Note: '*out_x_pre_increment' is set above
*out_x_post_increment=0;
if (codepoints > 1) free(render);
return 1;
}

int32 FontLoad (uint8 *content_original,int32 content_bytes,int32 default_pixel_height,int32 which_font,int32 options){

static int32 ft_init_called=0;
if (!ft_init_called){
 ft_init_called=1;
 if (FT_Init_FreeType(&ft_library )) exit(5633);
}

if (which_font==-1) which_font=0;

// options: 1=bold, 2=italic, 4=underline, 8=IGNORED, 16=monospace, 32=unicode

//get new index
static int32 i;
for (i=1;i<=fonts_last;i++){
if (!fonts[i].in_use){
goto got_index;
}
}//i
fonts_last++;
i=fonts_last;
fonts=(fonts_struct*)realloc(fonts,sizeof(fonts_struct)*(fonts_last+1));
fonts[i].in_use=0;
got_index:

memset(&fonts[i],0,sizeof(fonts_struct));

//duplicate content
static uint8* content;
content=(uint8*)malloc(content_bytes);
memcpy(content,content_original,content_bytes);
fonts[i].ttf_data=content;

if (FT_New_Memory_Face(ft_library,content,content_bytes,which_font,&fonts[i].handle)) return 0;
//Note: "Note that you must not deallocate the memory before calling FT_Done_Face."

if (FT_Set_Pixel_Sizes(fonts[i].handle,0,default_pixel_height)){FT_Done_Face(fonts[i].handle); return 0;}
fonts[i].default_pixel_height=default_pixel_height;

/*
static float m_height; m_height=((float)fonts[i].handle->size->metrics.height)/64.0;
static float m_up; m_up=((float)fonts[i].handle->size->metrics.ascender)/64.0;
static float m_down; m_down=-(((float)fonts[i].handle->size->metrics.descender)/64.0);
static float m_char_height; m_char_height=m_up+m_down;
static float m_h; m_h=default_pixel_height;
fonts[i].baseline= (m_h/m_height) * ((m_height-m_char_height)/2.0+m_up) ;
*/
static float m_height; m_height=((float)fonts[i].handle->size->metrics.height)/64.0;
static float m_up; m_up=((float)fonts[i].handle->size->metrics.ascender)/64.0;
static float m_h; m_h=default_pixel_height;
fonts[i].baseline=qbr((m_up/m_height) * m_h);

if (options&16){
//get the width of capital W
static uint32 cp;
cp=87;
static uint8 *data1;
int32 w1,h1,pre_x,post_x;
FontRenderTextUTF32(i,&cp,1,1,&data1,&w1,&h1,&pre_x,&post_x);
fonts[i].monospace_width=w1;
free(data1);
fonts[i].monospace=1;
}//monospace

//Note: DO NOT ADD NEW CONTENT HERE, ADD IT ABOVE MONOSPACE CHECK

fonts[i].in_use=1;
return i;

}

void FontFree(int32 i) {
  FT_Done_Face(fonts[i].handle);
  free(fonts[i].ttf_data);
  fonts[i].in_use = 0;
}

int32 FontRenderTextASCII(int32 i,uint8*codepoint,int32 codepoints,int32 options,
                          uint8**out_data,int32*out_x,int32 *out_y,int32*out_x_pre_increment,int32*out_x_post_increment){
static uint32 *utf32_codepoint;
static int32 retval;
if (codepoints>=1){
utf32_codepoint=(uint32*)malloc(codepoints*4);
 static int32 x;
 for (x=0;x<codepoints;x++){
  utf32_codepoint[x]=codepage437_to_unicode16[codepoint[x]];
 }
}
retval=FontRenderTextUTF32(i,utf32_codepoint,codepoints,options,out_data,out_x,out_y,out_x_pre_increment,out_x_post_increment);
if (codepoints>0) free(utf32_codepoint);
return retval;
}

int32 FontWidth(int32 i){
if (fonts[i].monospace) return fonts[i].monospace_width;
return 0;
}

#endif
