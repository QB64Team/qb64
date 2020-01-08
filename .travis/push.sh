#!/bin/sh
if [ "$TRAVIS_OS_NAME" != "linux" ]; then exit; fi
if [ "${UPDATE_REPO}" != "yes" ]; then exit; fi
git config --global user.email "flukiluke@gmail.com"
git config --global user.name "Autobuild process"
git clone --depth=1 --branch=$TRAVIS_BRANCH https://${GH_TOKEN}@github.com/Galleondragon/qb64.git homeqb64
cd homeqb64
rm -r internal/source
cp -r ../internal/source internal/source
git add --all internal/source
git commit --message "Autobuild update [ci skip]"
git push
cd ..
rm -rf homeqb64
