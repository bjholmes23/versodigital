#!/bin/bash

if git diff-index --quiet HEAD --; then
    git checkout master
    git pull
    git checkout gh-pages
    git pull
    git merge master
<<<<<<< HEAD
    gulp build
    git add -f .
=======
    git add -f .
    gulp build
>>>>>>> b2719f9eba524e297a5c144f64fcacce5abac517
    git commit -m "Build $(date +"%D %T")"
else
    echo "Uncommitted changes, exiting."
fi