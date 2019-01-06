#!/bin/bash
# This script reproduces any commits on upstream to the given remotes, but only on the given branches.
# It is intended to be run via a cron job or similar.
# The merge is --ff-only, so the target branches must not have anything else adding commits to them.

set -e
cd ~/qb64

# Adding a new branch/remote? git checkout -b $remote-$branch $remote/$branch to create a new local.
BRANCHES='development'
REMOTES='origin fellippe qb64team'

git fetch upstream

for branch in $BRANCHES; do
    for remote in $REMOTES; do
        git checkout -q $remote-$branch
        git merge -q --ff-only upstream/$branch
    done
done

for remote in $REMOTES; do
    refspecs=
    for branch in $BRANCHES; do
        refspecs="$refspecs $remote-$branch:$branch"
    done
    git push -q $remote $refspecs
done
