#!/bin/bash

rm internal/source/*
mv internal/temp/* internal/source/
find . -type f -iname "*.a" -exec rm {} \;
find . -type f -iname "*.o" -exec rm {} \;
cd internal/source
rm debug_* recompile_*
