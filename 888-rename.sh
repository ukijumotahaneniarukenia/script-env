#!/bin/bash

ls -l $HOME/script-env | grep -P '^d' | awk '{print $9}' | grep -v docker-log | xargs -I@ echo mv $HOME/script-env/@/manual.md $HOME/script-env/@/man.md


ls docker-build-crontab* | awk '{PRE=$1;gsub("docker-build-crontab","docker-crontab",$0);print "mv "PRE" "$0}'
