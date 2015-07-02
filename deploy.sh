#!/bin/bash

if git diff-index --quiet HEAD --; then
    git checkout master
    git pull
    git checkout gh-pages
    git pull
    git merge master
    gulp build
    git add -f .
    git commit -m "Build $(date +"%D %T")"
else
    echo "Uncommitted changes, exiting."
fi