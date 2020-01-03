#!/bin/bash

echo From git `echo $GITHUB_SHA | sed 's/\(.......\).*$/\1/'` > internal/version.txt
./qb64_bootstrap -x source/qb64.bas > /tmp/qb64-output
rm qb64_bootstrap
if [ `grep -v '^WARNING' /tmp/qb64-output | wc -l` -gt 2 ]; then
  cat /tmp/qb64-output
  rm /tmp/qb64-output
  exit 1
fi
