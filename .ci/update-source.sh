#!/bin/bash

rm internal/source/*
mv internal/temp/* internal/source/
find . -type f -iname "*.a" -exec rm {} \;
find . -type f -iname "*.o" -exec rm {} \;
cd internal/source
rm debug_* recompile_*
cd ../..

git config --local user.email "flukiluke@gmail.com"
git config --local user.name "Autobuild Process"
git add internal/source
git commit -m "Update internal/source"

