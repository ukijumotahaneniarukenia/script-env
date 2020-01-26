#!/bin/bash

echo SUMMARY

#gitignore整備
ls -l ~/script_env | grep -P '^d' | awk '{print $9}' | xargs -I@ echo cp ~/script_env/.gitignore ~/script_env/@/.gitignore | sh

#作業ディレクトリに移動
cd ~/script_env

BUILD_START=$(date '+%s')

#初回ビルド開始
bash ~/script_env/docker-build-parallel.sh &

#psコマンドで検索できるように少しまつ
sleep 10

printf "starting docker build non-retry proccess.\n"
printf "waiting for docker build proccess done.\n"
while $(ps aux | grep 'docker build' | grep -vq 'grep')
do
  #printf "💩"
  sleep 1
done

BUILD_END=$(date '+%s')

#すこし待った分差し引く
BUILD_ELAPSED=$(expr $BUILD_END - $BUILD_START - 10)

printf "docker build non-retry process has done.ending docker build non-retry proccess.elapsed time[%s(seconds)]\n" $BUILD_ELAPSED

echo

BUILD_START=$(date '+%s')

#初回ビルドに失敗したイメージに関してはリカバリ時間を短縮するために、到達可能なStepまでのキャッシュを作成しておく
bash ~/script_env/docker-build-parallel-retry.sh &

#psコマンドで検索できるように少しまつ
sleep 10

printf "starting docker build retry proccess.\n"
printf "waiting for docker build retry proccess done.\n"
while $(ps aux | grep 'docker build' | grep -vq 'grep')
do
  #printf "💩"
  sleep 1
done

BUILD_END=$(date '+%s')

#すこし待った分差し引く
BUILD_ELAPSED=$(expr $BUILD_END - $BUILD_START - 10)

printf "docker build retry process has done.ending docker build retry proccess.elapsed time[%s(seconds)]\n" $BUILD_ELAPSED

git add .gitignore
git add --all * 1>/dev/null 2>&1
git commit -m "環境構築" 1>/dev/null 2>&1

git status

echo DETAILS #この行以降に詳細ログを追記されていく
