#!/bin/bash
git fetch -p -n
commits=`git log --grep=$1 --format=format:"%H" -1 --skip=$2` 
if [ "$commits" = "" ]
then
	echo "Commit not found";
else
	repo=`git branch --contains $commits`
	echo "Results:";
	echo "$repo";
fi
