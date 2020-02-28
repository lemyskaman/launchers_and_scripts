#!/bin/bash 
# author: lemys lopez
# mail: lemyskaman@gmail.com
# description: just track all branches from remote to local,
#			   taken as explained at: https://stackoverflow.com/questions/379081/track-all-remote-git-branches-as-local-branches
 
for remote in `git branch -r `; do git branch --track $remote; done