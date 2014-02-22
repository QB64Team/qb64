#ifndef __TARGET_H__
#define __TARGET_H__

const char * Target_getName();

void Target_init(int argc, char ** argv);
void Target_draw();

void Target_keyDown(int charCode, int keyCode);
void Target_keyUp(int charCode, int keyCode);
void Target_mouseDown(int buttonNumber, float x, float y);
void Target_mouseUp(int buttonNumber, float x, float y);
void Target_mouseMoved(float x, float y);
void Target_mouseDragged(int buttonMask, float x, float y);

void Target_resized(int newWidth, int newHeight);

#endif
