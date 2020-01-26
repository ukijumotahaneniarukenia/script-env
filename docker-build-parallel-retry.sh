#!/bin/bash

RETRY_ROUND="$@"
ls -l ~/script_env | grep -P '^d' | awk '{print $9}' | grep -vE $(docker images | tail -n+1 | grep -P '(-[0-9]{1,}){2,}-' | awk '{print $1}'|xargs|tr ' ' '|') | tail -n3 | \
  xargs -P0 -I@ bash -c "echo 'cd ~/script_env/@ && ( time docker build -t @ . ) 1>~/script_env/@/retry-$RETRY_ROUND-log 2>&1 &' " | sh
