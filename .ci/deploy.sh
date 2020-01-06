#!/bin/bash

OS=$1
TZ=UTC now=`date +"%F-%H-%M-%S"`
filename="/tmp/qb64_${now}_`echo ${GITHUB_SHA} | sed 's/\(.......\).*$/\1/'`_$OS.tar.gz"
cd ..
tar --create --auto-compress --file ${filename} --exclude-from=qb64/.ci/common-exclusion.list --exclude-from=qb64/.ci/$OS-exclusion.list qb64

# Send to server
# Sometimes the connection can be a bit flakey, so try multiple times on error
for i in `seq 1 10`
do scp ${filename} remote-server:autobuilds/development/
    if [ "$?" -eq 0 ]
        then exit 0
    fi
    echo scp $i failed
done
exit 1

