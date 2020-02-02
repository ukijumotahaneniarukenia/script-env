#!/bin/bash

RETRY_MX_CNT=2

#gitignore整備
ls -l ~/script_env | grep -P '^d' | awk '{print $9}' | grep -v docker-build-log | xargs -I@ echo cp ~/script_env/.gitignore ~/script_env/@/.gitignore | sh

#mandoc.md配備
ls -l ~/script_env | grep -P '^d' | awk '{print $9}' | grep -v docker-build-log | xargs -I@ echo cp ~/script_env/mandoc.md ~/script_env/@/mandoc.md | sh
ls -l ~/script_env | grep -P '^d' | awk '{print $9}' | grep -v docker-build-log | xargs -I@ echo "sed -i 's;XXX;@;g' ~/script_env/@/mandoc.md" | sh

#作業ディレクトリに移動
cd ~/script_env

BUILD_START=$(date '+%s')

#初回ビルド開始
bash ~/script_env/docker-build-parallel.sh &

#psコマンドで検索できるように少しまつ
sleep 10

printf "starting docker init build proccess.\n"
printf "waiting for docker init build proccess done.\n"

#docker buildプロセスがヒットしなくなるまで、まつ
while $(ps aux | grep 'docker build' | grep -vq 'grep')
do
  sleep 1
done

BUILD_END=$(date '+%s')

#すこし待った分差し引く
BUILD_ELAPSED=$(expr $BUILD_END - $BUILD_START - 10)

printf "docker init build process has done.ending docker init build proccess.elapsed time[%s(seconds)]\n" $BUILD_ELAPSED

echo

for ((RETRY_ROUND_CNT=1;RETRY_ROUND_CNT<=$RETRY_MX_CNT;RETRY_ROUND_CNT++));do

  BUILD_START=$(date '+%s')

  printf "starting docker retry $(printf '%02g' $RETRY_ROUND_CNT) round build proccess.\n"
  printf "waiting for docker retry $(printf '%02g' $RETRY_ROUND_CNT) round all build proccess done.\n"

  #初回ビルドに失敗したイメージに関してはリカバリ時間を短縮するために、到達可能なStepまでのキャッシュを作成しておく
  #リトライログ用にRETRY_ROUND_CNTを引数に渡す
  bash ~/script_env/docker-build-parallel-retry.sh $(printf '%02g' $RETRY_ROUND_CNT) &

  #psコマンドで検索できるように少しまつ
  sleep 10

  #docker buildプロセスがヒットしなくなるまで、まつ
  while $(ps aux | grep 'docker build' | grep -vq 'grep')
  do
    sleep 1
  done

  BUILD_END=$(date '+%s')

  #すこし待った分差し引く
  BUILD_ELAPSED=$(expr $BUILD_END - $BUILD_START - 10)

  printf "docker retry $(printf '%02g' $RETRY_ROUND_CNT) round build process has done.ending docker retry $(printf '%02g' $RETRY_ROUND_CNT) round build proccess.elapsed time[%s(seconds)]\n" $BUILD_ELAPSED
done
