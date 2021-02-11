#!/bin/bash

OS=$1
TZ=UTC now=`date +"%F-%H-%M-%S"`
BUCKET=qb64-development-builds
filename="/tmp/qb64_${now}_`echo ${GITHUB_SHA} | sed 's/\(.......\).*$/\1/'`_${OS}.tar.gz"
cd ..
tar --create --auto-compress --file ${filename} --exclude-from=qb64/.ci/common-exclusion.list --exclude-from=qb64/.ci/$OS-exclusion.list qb64

current_files=$(aws --output text --query 'Contents[].Key' s3api list-objects --bucket ${BUCKET} --prefix ${OS})
aws s3 cp ${filename} s3://${BUCKET}/${OS}/
echo -n $(basename "${filename}") > latest.txt
for f in $current_files; do
    aws s3 rm s3://${BUCKET}/$f
done
aws s3 cp latest.txt s3://${BUCKET}/${OS}/
