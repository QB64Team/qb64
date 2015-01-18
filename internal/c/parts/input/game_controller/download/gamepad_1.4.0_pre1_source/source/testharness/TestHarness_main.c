#include "gamepad/Gamepad.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#ifdef __APPLE__
#include <GLUT/glut.h>
#include <OpenGL/gl.h>
#else
#include <GL/glut.h>
#include <GL/gl.h>
#endif

#ifdef _MSC_VER
#define snprintf _snprintf
#endif

static bool verbose = false;

void onButtonDown(struct Gamepad_device * device, unsigned int buttonID, double timestamp, void * context) {
	if (verbose) {
		printf("Button %u down on device %u at %f with context %p\n", buttonID, device->deviceID, timestamp, context);
	}
}

void onButtonUp(struct Gamepad_device * device, unsigned int buttonID, double timestamp, void * context) {
	if (verbose) {
		printf("Button %u up on device %u at %f with context %p\n", buttonID, device->deviceID, timestamp, context);
	}
}

void onAxisMoved(struct Gamepad_device * device, unsigned int axisID, float value, float lastValue, double timestamp, void * context) {
	if (verbose) {
		printf("Axis %u moved from %f to %f on device %u at %f with context %p\n", axisID, lastValue, value, device->deviceID, timestamp, context);
	}
}

void onDeviceAttached(struct Gamepad_device * device, void * context) {
	if (verbose) {
		printf("Device ID %u attached (vendor = 0x%X; product = 0x%X) with context %p\n", device->deviceID, device->vendorID, device->productID, context);
	}
}

void onDeviceRemoved(struct Gamepad_device * device, void * context) {
	if (verbose) {
		printf("Device ID %u removed with context %p\n", device->deviceID, context);
	}
}

static unsigned int windowWidth = 800, windowHeight = 600;

static void initGamepad() {
	Gamepad_deviceAttachFunc(onDeviceAttached, (void *) 0x1);
	Gamepad_deviceRemoveFunc(onDeviceRemoved, (void *) 0x2);
	Gamepad_buttonDownFunc(onButtonDown, (void *) 0x3);
	Gamepad_buttonUpFunc(onButtonUp, (void *) 0x4);
	Gamepad_axisMoveFunc(onAxisMoved, (void *) 0x5);
	Gamepad_init();
}

static void drawGlutString(int rasterPosX, int rasterPosY, const char * string) {
	size_t length, charIndex;
	
	glRasterPos2i(rasterPosX, rasterPosY);
	length = strlen(string);
	for (charIndex = 0; charIndex < length; charIndex++) {
		glutBitmapCharacter(GLUT_BITMAP_8_BY_13, string[charIndex]);
	}
}

#define POLL_ITERATION_INTERVAL 30

static void displayFunc(void) {
	unsigned int gamepadIndex;
	struct Gamepad_device * device;
	unsigned int axesPerRow, buttonsPerRow;
	unsigned int axisRowIndex, axisIndex;
	unsigned int buttonRowIndex, buttonIndex;
	float axisState;
	char indexString[16];
	static unsigned int iterationsToNextPoll = POLL_ITERATION_INTERVAL;
	char descriptionString[256];
	
	iterationsToNextPoll--;
	if (iterationsToNextPoll == 0) {
		Gamepad_detectDevices();
		iterationsToNextPoll = POLL_ITERATION_INTERVAL;
	}
	Gamepad_processEvents();
	
	axesPerRow = (windowWidth - 10) / 60;
	buttonsPerRow = (windowWidth - 10) / 30;
	
	glClear(GL_COLOR_BUFFER_BIT);
	glLoadIdentity();
	glTranslatef(5.0f, 20.0f, 0.0f);
	for (gamepadIndex = 0; gamepadIndex < Gamepad_numDevices(); gamepadIndex++) {
		device = Gamepad_deviceAtIndex(gamepadIndex);
		
		glColor3f(0.0f, 0.0f, 0.0f);
		snprintf(descriptionString, 256, "%s (0x%X 0x%X %u)", device->description, device->vendorID, device->productID, device->deviceID);
		drawGlutString(0, 0, descriptionString);
		
		for (axisRowIndex = 0; axisRowIndex <= device->numAxes / axesPerRow; axisRowIndex++) {
			glPushMatrix();
			for (axisIndex = axisRowIndex * axesPerRow; axisIndex < (axisRowIndex + 1) * axesPerRow && axisIndex < device->numAxes; axisIndex++) {
				axisState = device->axisStates[axisIndex];
				
				sprintf(indexString, "a%d", axisIndex);
				glColor3f(0.0f, 0.0f, 0.0f);
				drawGlutString(2, 28, indexString);
				
				glBegin(GL_QUADS);
				glVertex2f(2.0f, 5.0f);
				glVertex2f(58.0f, 5.0f);
				glVertex2f(58.0f, 15.0f);
				glVertex2f(2.0f, 15.0f);
				glColor3f(0.5f, 1.0f, 0.5f);
				glVertex2f(29.0f + axisState * 26, 6.0f);
				glVertex2f(31.0f + axisState * 26, 6.0f);
				glVertex2f(31.0f + axisState * 26, 14.0f);
				glVertex2f(29.0f + axisState * 26, 14.0f);
				glEnd();
				glTranslatef(60.0f, 0.0f, 0.0f);
			}
			glPopMatrix();
			glTranslatef(0.0f, 32.0f, 0.0f);
		}
		
		for (buttonRowIndex = 0; buttonRowIndex <= device->numButtons / buttonsPerRow; buttonRowIndex++) {
			glPushMatrix();
			for (buttonIndex = buttonRowIndex * buttonsPerRow; buttonIndex < (buttonRowIndex + 1) * buttonsPerRow && buttonIndex < device->numButtons; buttonIndex++) {
				sprintf(indexString, "b%d", buttonIndex);
				glColor3f(0.0f, 0.0f, 0.0f);
				drawGlutString(2, 32, indexString);
				
				glBegin(GL_QUADS);
				glColor3f(0.0f, 0.0f, 0.0f);
				glVertex2f(2.0f, 2.0f);
				glVertex2f(28.0f, 2.0f);
				glVertex2f(28.0f, 18.0f);
				glVertex2f(2.0f, 18.0f);
				if (device->buttonStates[buttonIndex]) {
					glColor3f(0.5f, 1.0f, 0.5f);
					glVertex2f(3.0f, 3.0f);
					glVertex2f(27.0f, 3.0f);
					glVertex2f(27.0f, 17.0f);
					glVertex2f(3.0f, 17.0f);
				}
				glEnd();
				glTranslatef(30.0f, 0.0f, 0.0f);
			}
			glPopMatrix();
			glTranslatef(0.0f, 38.0f, 0.0f);
		}
		glTranslatef(0.0f, 40.0f, 0.0f);
	}
	
	if (gamepadIndex == 0) {
		glLoadIdentity();
		glTranslatef(5.0f, 20.0f, 0.0f);
		glColor3f(0.0f, 0.0f, 0.0f);
		drawGlutString(0, 0, "No devices found; plug in a USB gamepad and it will be detected automatically");
	}
	
	glutSwapBuffers();
	glutPostRedisplay();
}

static void keyDownFunc(unsigned char charCode, int x, int y) {
	if (charCode == 'r') {
		Gamepad_shutdown();
		initGamepad();
	}
}

static void reshapeFunc(int newWidth, int newHeight) {
	windowWidth = newWidth;
	windowHeight = newHeight;
	glViewport(0, 0, newWidth, newHeight);
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	glOrtho(0.0f, windowWidth, windowHeight, 0.0f, -1.0f, 1.0f);
	glMatrixMode(GL_MODELVIEW);
}

int main(int argc, char ** argv) {
	int	argIndex;
	
	for (argIndex = 1; argIndex < argc; argIndex++) {
		if (!strcmp(argv[argIndex], "-v")) {
			verbose = true;
		}
	}
	
	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_RGBA | GLUT_DOUBLE);
	glutInitWindowPosition(30, 30);
	glutInitWindowSize(800, 600);
	glutCreateWindow("Gamepad Test Harness");
	glutReshapeFunc(reshapeFunc);
	glutDisplayFunc(displayFunc);
	glutKeyboardFunc(keyDownFunc);
	
	initGamepad();
	
	glClearColor(1.0f, 1.0f, 1.0f, 0.0f);
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	glOrtho(0.0f, windowWidth, windowHeight, 0.0f, -1.0f, 1.0f);
	glMatrixMode(GL_MODELVIEW);
	
	glutMainLoop();
}
