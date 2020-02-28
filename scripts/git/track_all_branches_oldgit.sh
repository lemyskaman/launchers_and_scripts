#!/bin/bash 
# author: lemys lopez
# mail: lemyskaman@gmail.com
# description: just track all branches from remote to local,
#			   taken as explained at: https://stackoverflow.com/questions/379081/track-all-remote-git-branches-as-local-branches

for i in `git branch -a | grep remote | grep -v HEAD | grep -v master`; do git branch --track ${i#remotes/origin/} $i; done