#!/bin/bash
regex="origin\/(feature|story|bug|improvement)\/(RM4\-[0-9]{4})"
git fetch -p -n
repos=`git branch -r | egrep $regex`
if [ "$repos" = "" ]
then
	echo "No branches found";
else
	link=''
	while read -r line ; do
		if [[ $line =~ $regex ]]
		then
			link+=', '
			link+=${BASH_REMATCH[2]}
		fi
	done <<< "$repos"
	url='https://rentman.atlassian.net/issues/?jql=issue in ('
	urlend=') AND status IN("To Be Merged","Ready for Deployment",Deployed)'
	echo ${link:2}
	totallink=$url${link:2}$urlend
	open "$totallink"
fi
