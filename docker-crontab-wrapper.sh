#!/usr/bin/env bash

usage(){
  cat <<EOS
Usage:
  bash $0 1 docker-build-wanted-list script-repo
EOS
exit 0
}


exec 1>$HOME/script-env/docker-build-log/docker-build-$(date +\%Y-\%m-\%dT\%H-\%M-\%S).stdout.log
exec 2>$HOME/script-env/docker-build-log/docker-build-$(date +\%Y-\%m-\%dT\%H-\%M-\%S).stderr.log

MX_RETRY_CNT="$1";shift
BUILD_LIST_FILE="$1";shift
REPO="$1";shift

[ -z $MX_RETRY_CNT ] && usage
[ -z $BUILD_LIST_FILE ] && usage
[ -z $REPO ] && usage

bash $HOME/script-env/03-doc.mdの各環境ディレクトリへの配備.sh $REPO

for((ROUND_CNT=1;ROUND_CNT<=$MX_RETRY_CNT;ROUND_CNT++));do
  BUILD_START_TIME=$(date '+%s') #開始時刻控える

  printf "starting docker build $(printf '%02g' $ROUND_CNT) round.\n" #開始メッセージ

  bash $HOME/script-env/docker-crontab-execute.sh $(printf '%02g' $ROUND_CNT) $BUILD_LIST_FILE &

  sleep 10 #psコマンドで検索できるように少しまつ

  while $(ps aux | grep 'docker build' | grep -vq 'grep') #docker buildプロセスがヒットしなくなるまで、まつ。待ち合わせ機能。
  do
    sleep 1
  done

  BUILD_END_TIME=$(date '+%s') #終了時刻控える

  BUILD_ELAPSED_TIME=$(expr $BUILD_END_TIME - $BUILD_START_TIME - 10) #すこし待った分差し引く

  printf "ending docker build $(printf '%02g' $ROUND_CNT) round.elapsed time[%s(seconds)]\n" $BUILD_ELAPSED_TIME #終了メッセージ
done

bash $HOME/script-env/docker-crontab-clean.sh
bash $HOME/script-env/docker-crontab-logger.sh $BUILD_LIST_FILE
