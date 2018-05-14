#!/bin/bash
git fetch -n -p 
git checkout master
git branch | egrep -v "(master|\*)" | xargs git branch -D
git pull
