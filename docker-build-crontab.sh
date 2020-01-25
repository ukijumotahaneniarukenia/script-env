#!/bin/bash

BUILD_START=$(date '+%s')

bash ~/script_env/docker-build-parallel.sh &

#psコマンドで検索できるように少しまつ
sleep 10

printf "waiting for docker build proccess.\n"
while $(ps aux | grep 'docker build' | grep -vq 'grep')
do
  #printf "💩"
  sleep 1
done

#gitignore整備
ls -l ~/script_env | grep -P '^d' | awk '{print $9}' | xargs -I@ echo cp ~/script_env/.gitignore ~/script_env/@/.gitignore | sh
cd ~/script_env
git add .gitignore
git add --all *
git commit -m "環境構築"

BUILD_END=$(date '+%s')

BUILD_ELAPSED=$(expr $BUILD_END - $BUILD_START)

echo

printf "\ndocker build process has done.\n"

git status

#すこし待った分差し引く
echo elapsed time $(($BUILD_ELAPSED-10)) seconds.
