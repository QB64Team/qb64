#!/bin/bash

echo From git `echo $GITHUB_SHA | sed 's/\(.......\).*$/\1/'` > internal/version.txt
./qb64_bootstrap -x -w source/qb64.bas
SUCCESS=$?
rm qb64_bootstrap
rm internal/source/*
mv internal/temp/* internal/source/
rm internal/source/debug_* internal/source/recompile_*
find . -type f -iname "*.a" -exec rm {} \;
find . -type f -iname "*.o" -exec rm {} \;
exit $SUCCESS
