#!/bin/sh

# Prepare archives
# mainversion=`awk '$1=="Version$" {split($3, A, /\"/);print A[2];}' < source/global/version.bas`
# buildnum=`awk '$1=="BuildNum$" {split($3,A, /[\"\/]/); print A[3];}' < source/global/version.bas`
TZ=UTC now=`date +"%F-%H-%M-%S"`
filebase="/tmp/qb64_${now}_`echo ${TRAVIS_COMMIT} | sed 's/\(.......\).*$/\1/'`"
rm -r .dpl

cd ..
tar --create --auto-compress --file ${filebase}_osx.tar.gz --exclude-from=qb64/.travis/common-exclusion.list --exclude-from=qb64/.travis/osx-exclusion.list qb64
tar --create --auto-compress --file ${filebase}_lnx.tar.gz --exclude-from=qb64/.travis/common-exclusion.list --exclude-from=qb64/.travis/lnx-exclusion.list qb64
7z a -xr@qb64/.travis/common-exclusion.list -xr@qb64/.travis/win-exclusion.list ${filebase}_win.7z qb64/ > /dev/null

# Send to server
scp ${filebase}_* m6rosupy1q2t@qb64.org:autobuilds/


