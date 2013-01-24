# Project: mpglib
# Makefile created by Dev-C++ 4.9.9.1

CPP  = g++.exe
CC   = gcc.exe
WINDRES = windres.exe
RES  = 
OBJ  = mpglib/common.o mpglib/dct64_i386.o mpglib/decode_i386.o mpglib/interface.o mpglib/layer2.o mpglib/layer3.o mpglib/tabinit.o $(RES)
LINKOBJ  = mpglib/common.o mpglib/dct64_i386.o mpglib/decode_i386.o mpglib/interface.o mpglib/layer2.o mpglib/layer3.o mpglib/tabinit.o $(RES)
LIBS =  -L"d:/Dev-Cpp/lib" --no-export-all-symbols --add-stdcall-alias 
INCS =  -I"d:/Dev-Cpp/include" 
CXXINCS =  -I"d:/Dev-Cpp/include/c++/3.3.1"  -I"d:/Dev-Cpp/include/c++/3.3.1/mingw32"  -I"d:/Dev-Cpp/include/c++/3.3.1/backward"  -I"d:/Dev-Cpp/lib/gcc-lib/mingw32/3.3.1/include"  -I"d:/Dev-Cpp/include" 
BIN  = mpglib.dll
CXXFLAGS = $(CXXINCS) -DBUILDING_DLL=1 
CFLAGS = $(INCS) -DBUILDING_DLL=1 

.PHONY: all all-before all-after clean clean-custom

all: all-before mpglib.dll all-after


clean: clean-custom
	rm -f $(OBJ) $(BIN)

DLLWRAP=dllwrap.exe
DEFFILE=libmpglib.def
STATICLIB=libmpglib.a

$(BIN): $(LINKOBJ)
	$(DLLWRAP) --output-def $(DEFFILE) --driver-name c++ --implib $(STATICLIB) $(LINKOBJ) $(LIBS) -o $(BIN)

mpglib/common.o: mpglib/common.c
	$(CPP) -c mpglib/common.c -o mpglib/common.o $(CXXFLAGS)

mpglib/dct64_i386.o: mpglib/dct64_i386.c
	$(CPP) -c mpglib/dct64_i386.c -o mpglib/dct64_i386.o $(CXXFLAGS)

mpglib/decode_i386.o: mpglib/decode_i386.c
	$(CPP) -c mpglib/decode_i386.c -o mpglib/decode_i386.o $(CXXFLAGS)

mpglib/interface.o: mpglib/interface.c
	$(CPP) -c mpglib/interface.c -o mpglib/interface.o $(CXXFLAGS)

mpglib/layer2.o: mpglib/layer2.c
	$(CPP) -c mpglib/layer2.c -o mpglib/layer2.o $(CXXFLAGS)

mpglib/layer3.o: mpglib/layer3.c
	$(CPP) -c mpglib/layer3.c -o mpglib/layer3.o $(CXXFLAGS)

mpglib/tabinit.o: mpglib/tabinit.c
	$(CPP) -c mpglib/tabinit.c -o mpglib/tabinit.o $(CXXFLAGS)
