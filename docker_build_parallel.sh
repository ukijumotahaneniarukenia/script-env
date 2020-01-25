#!/bin/bash

ls -l ~/script_env | grep -P '^d' | awk '{print $9}' | xargs -P0 -I@ bash -c 'echo "cd ~/script_env/@ && time docker build --no-cache -t @ . 1>~/script_env/@/log 2>&1 &" ' | sh
