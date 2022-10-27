#!/bin/bash
set -ux

for project in $(find . -maxdepth 2 -name '.git')
do
    pushd "$(dirname $project)"
    git remote set-url origin "$(git remote get-url origin | sed 's/Nitori-/JennToo/g')"
    popd
done
