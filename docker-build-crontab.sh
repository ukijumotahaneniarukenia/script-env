#!/bin/bash

source docker_build_parallel.sh

#gitignore整備
ls -l ~/script_env | grep -P '^d' | awk '{print $9}' | xargs -I@ echo cp ~/script_env/.gitignore ~/script_env/@/.gitignore | sh

cd ~/script_env
git add .gitignore
git add --all *
git commit -m "環境構築"
