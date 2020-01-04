#!/bin/bash

echo From git `echo $GITHUB_SHA | sed 's/\(.......\).*$/\1/'` > internal/version.txt
./qb64_bootstrap -x -v source/qb64.bas
SUCCESS=$?
rm qb64_bootstrap
exit $SUCCESS
