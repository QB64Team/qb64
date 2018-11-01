#!/bin/sh
if [ "${UPDATE_REPO}" != "yes" ]; then exit; fi
git config --global user.email "flukiluke@gmail.com"
git config --global user.name "Autobuild process"
git clone --depth=1 https://${GH_TOKEN}@github.com/Galleondragon/qb64.git homeqb64
cd homeqb64
git checkout $TRAVIS_BRANCH
rm -r internal/source
cp -r ../internal/source internal/source
git add --all internal/source
git commit --message "Autobuild update [ci skip]"
git push
cd ..
rm -rf homeqb64
