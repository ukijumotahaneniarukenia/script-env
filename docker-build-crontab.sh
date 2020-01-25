#!/bin/bash

BUILD_START=$(date '+%s')

bash ~/script_env/docker-build-parallel.sh &

wait

#gitignore整備
ls -l ~/script_env | grep -P '^d' | awk '{print $9}' | xargs -I@ echo cp ~/script_env/.gitignore ~/script_env/@/.gitignore | sh
cd ~/script_env
git add .gitignore
git add --all *
git commit -m "環境構築"

BUILD_END=$(date '+%s')

BUILD_ELAPSED=$(expr $BUILD_END - $BUILD_START)

echo $BUILD_ELAPSED seconds.
