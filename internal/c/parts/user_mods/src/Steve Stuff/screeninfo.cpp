int32 func_screenwidth () {
	while (!window_exists){Sleep(100);}
	return glutGet(GLUT_SCREEN_WIDTH);
}

int32 func_screenheight () {
	while (!window_exists){Sleep(100);}
	return glutGet(GLUT_SCREEN_HEIGHT);
}

void sub_screenicon () {
	while (!window_exists){Sleep(100);}
	glutIconifyWindow();
	return;
}

int32 func_windowexists () {
	return -window_exists;
}

int32 func__controlchr () {
  return -no_control_characters2;
}

int32 func_screenicon () {
	while (!window_exists){Sleep(100);}
	extern int32 screen_hide;
	if (screen_hide) {error(5); return 0;}
	#ifdef QB64_WINDOWS
        #include <windows.h>
		extern HWND window_handle;
	    return -IsIconic(window_handle);
    #else
     	#include <X11/X.h>
		#include <X11/Xlib.h>
		extern Display *X11_display;
		extern Window X11_window;
		extern int32 screen_hide;
		XWindowAttributes attribs;
		while (!(X11_display && X11_window));
		XGetWindowAttributes(X11_display, X11_window, &attribs);
		if (attribs.map_state == IsUnmapped) return -1;
		return 0;
    #endif
	return 0; //if we get here and haven't exited already, we failed somewhere along the way.
}