# note: this Makefile builds the Linux version only

CFLAGS = -Wall -Os -march=pentium
CFLAGS += -ffast-math
CFLAGS += -finline-functions-called-once
CFLAGS += -fno-loop-optimize
CFLAGS += -fexpensive-optimizations
CFLAGS += -fpeephole2

STRIPFLAGS  = -R .comment
STRIPFLAGS += -R .note
STRIPFLAGS += -R .note.ABI-tag
STRIPFLAGS += -R .gnu.version

BIN = minimp3
FINALBIN = $(BIN)-linux
OBJS = player_oss.o minimp3.o

all:	$(BIN)

release:	$(BIN)
	strip $(STRIPFLAGS) $(BIN)
	upx --brute $(BIN)

test:	$(BIN)
	./$(BIN) "../../../Gargaj -- Rude Awakening.mp3"

$(BIN):	$(OBJS)
	gcc $(OBJS) -o $(BIN) -lm

%.o:	%.c
	gcc $(CFLAGS) -c $< -o $@

clean:
	rm -f $(BIN) $(OBJS)

dist:	clean release
	mv $(BIN) $(FINALBIN)
	rm -f $(OBJS)
