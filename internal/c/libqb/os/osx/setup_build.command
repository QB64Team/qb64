cd "$(dirname "$0")"
clang++ -c -w -Wall ../../../libqb.mm -D DEPENDENCY_LOADFONT -o libqb_setup.o

