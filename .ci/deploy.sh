#!/bin/bash

OS=$1
TZ=UTC now=`date +"%F-%H-%M-%S"`
BUCKET=qb64
filename="qb64_development_${OS}.tar.gz"
dirname="qb64_${now}_`echo ${GITHUB_SHA} | sed 's/\(.......\).*$/\1/'`_${OS}"
cd ..
mv qb64 "${dirname}"
tar --create --auto-compress --file ${filename} --exclude-from=${dirname}/.ci/common-exclusion.list --exclude-from=${dirname}/.ci/$OS-exclusion.list ${dirname}
aws --endpoint-url ${S3_ENDPOINT} s3api put-object --bucket ${BUCKET} --body ${filename} --acl public-read --key development-builds/${filename}
if [[ $OS == lnx ]]; then
    aws --endpoint-url ${S3_ENDPOINT} s3api put-object --bucket ${BUCKET} --body ${dirname}/CHANGELOG.md --acl public-read --key development-builds/changelog.md
fi
# Move it back so the post-job cleanup doesn't complain
mv "${dirname}" qb64
