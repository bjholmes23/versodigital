#!/bin/bash

if git diff-index --quiet HEAD --; then
    git checkout master
    git pull
    git checkout gh-pages
    git pull
    git merge master
    [ $? -gt 0 ] && { echo "Merge failed"; exit 1; }
    npm install
    bower install
    gulp build
    [ $? -gt 0 ] && { echo "Build failed"; exit 1; }
    npm prune --production
    git add -f .
    git commit -m "Build $(date +"%D %T")"
    git checkout master
else
    echo "Uncommitted changes, exiting."
fi