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
