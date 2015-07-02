#!/bin/bash

if git diff-index --quiet HEAD --; then
    git checkout master
    git pull
    git checkout gh-pages
    git pull
    git merge master
    git add -f .
    gulp build
    git commit -m "Build $(date +"%D %T")"
else
    echo "Uncommitted changes, exiting."
fi