#!/bin/bash

git config --local user.email "flukiluke@gmail.com"
git config --local user.name "Autobuild Process"
git add internal/source
if [[ $(git diff --cached | wc -l) -gt 0 ]]
    then git commit -m "Update internal/source"
fi

