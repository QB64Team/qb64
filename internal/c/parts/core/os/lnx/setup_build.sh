#!/bin/sh
gcc -s -O2 -c ../../src/freeglut_callbacks.c -o temp/freeglut_callbacks.o
gcc -s -O2 -c ../../src/freeglut_cursor.c -o temp/freeglut_cursor.o
gcc -s -O2 -c ../../src/freeglut_display.c -o temp/freeglut_display.o
gcc -s -O2 -c ../../src/freeglut_ext.c -o temp/freeglut_ext.o
gcc -s -O2 -c ../../src/freeglut_font.c -o temp/freeglut_font.o
gcc -s -O2 -c ../../src/freeglut_font_data.c -o temp/freeglut_font_data.o
gcc -s -O2 -c ../../src/freeglut_gamemode.c -o temp/freeglut_gamemode.o
gcc -s -O2 -c ../../src/freeglut_geometry.c -o temp/freeglut_geometry.o
gcc -s -O2 -c ../../src/freeglut_glutfont_definitions.c -o temp/freeglut_glutfont_definitions.o
gcc -s -O2 -c ../../src/freeglut_init.c -o temp/freeglut_init.o
gcc -s -O2 -c ../../src/freeglut_input_devices.c -o temp/freeglut_input_devices.o
gcc -s -O2 -c ../../src/freeglut_joystick.c -o temp/freeglut_joystick.o
gcc -s -O2 -c ../../src/freeglut_main.c -o temp/freeglut_main.o
gcc -s -O2 -c ../../src/freeglut_menu.c -o temp/freeglut_menu.o
gcc -s -O2 -c ../../src/freeglut_misc.c -o temp/freeglut_misc.o
gcc -s -O2 -c ../../src/freeglut_overlay.c -o temp/freeglut_overlay.o
gcc -s -O2 -c ../../src/freeglut_spaceball.c -o temp/freeglut_spaceball.o
gcc -s -O2 -c ../../src/freeglut_state.c -o temp/freeglut_state.o
gcc -s -O2 -c ../../src/freeglut_stroke_mono_roman.c -o temp/freeglut_stroke_mono_roman.o
gcc -s -O2 -c ../../src/freeglut_stroke_roman.c -o temp/freeglut_stroke_roman.o
gcc -s -O2 -c ../../src/freeglut_structure.c -o temp/freeglut_structure.o
gcc -s -O2 -c ../../src/freeglut_videoresize.c -o temp/freeglut_videoresize.o
gcc -s -O2 -c ../../src/freeglut_window.c -o temp/freeglut_window.o
gcc -s -O2 -c ../../src/freeglut_xinput.c -o temp/freeglut_xinput.o
ar rcs src.a temp/freeglut_callbacks.o temp/freeglut_cursor.o temp/freeglut_display.o temp/freeglut_ext.o temp/freeglut_font.o temp/freeglut_font_data.o temp/freeglut_gamemode.o temp/freeglut_geometry.o temp/freeglut_glutfont_definitions.o temp/freeglut_init.o temp/freeglut_input_devices.o temp/freeglut_joystick.o temp/freeglut_main.o temp/freeglut_menu.o temp/freeglut_misc.o temp/freeglut_overlay.o temp/freeglut_spaceball.o temp/freeglut_state.o temp/freeglut_stroke_mono_roman.o temp/freeglut_stroke_roman.o temp/freeglut_structure.o temp/freeglut_videoresize.o temp/freeglut_window.o temp/freeglut_xinput.o

