#!/bin/bash

git fetch -p -n
if [ "$2" = "h" ]
	then
	repo=`git branch -r | grep hotfix\/4\.$1`
else
	repo=`git branch -r | grep $1`
	
fi
if [ "$repo" = "" ]
	then
	echo "Branch not found";
elif (( $(grep -c . <<<"$repo") > 1 ))
	then
	echo "Multiple results:";
	echo "$repo";
else
	repolocal="${repo#*/}"
	check=`git branch | grep $repolocal`
	echo "$check";
	if [ "$check" != "" ]
		then
		echo "Already exists! ${repolocal}";
		git fetch -n -p 
		git checkout master
		git branch | egrep -v "(master|\*)" | xargs git branch -D
	fi

	git checkout -b ${repolocal} ${repo}
	git pull
	if [ "$2" = "t" ]
		then
		grunt translate
	fi
fi
