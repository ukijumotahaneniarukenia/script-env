#!/bin/bash

ls -l ~/script-env | grep -P '^d' | awk '{print $9}' | grep -v docker-build-log | xargs -P0 -I@ bash -c 'echo "cd ~/script-env/@ && ( time docker build --no-cache -t @ . ) 1>~/script-env/@/log 2>&1 &" ' | sh
