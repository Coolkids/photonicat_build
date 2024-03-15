#!/bin/bash
CURRENT_DATE=$(date +'%y.%m')
echo "Tag check"
if git rev-parse -q --verify "refs/tags/v$CURRENT_DATE" >/dev/null; then 
	echo "Tag 'v$CURRENT_DATE' exists. Deleting..."
	git tag -d "v$CURRENT_DATE"
	git push origin --delete "v$CURRENT_DATE"
fi
