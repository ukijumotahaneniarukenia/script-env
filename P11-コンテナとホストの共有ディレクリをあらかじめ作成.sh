#!/usr/bin/env bash

usage(){
  cat <<EOS
Usage:
  $0 script-env
EOS
exit 0
}

REPO=$1

[ -z $REPO ] && usage

while read tgt;do
  echo "rm -rf $tgt/mnt" #成果物共有ﾃﾞｨﾚｸﾄﾘ
  echo "rm -rf /home/aine/Downloads-for-docker-container/$(echo $tgt | perl -pe 's;.*/;;g')" #外部資産インクルードディレクﾄﾘ
  echo "mkdir -p $tgt/mnt" #成果物共有ﾃﾞｨﾚｸﾄﾘ
  echo "mkdir -p /home/aine/Downloads-for-docker-container/$(echo $tgt | perl -pe 's;.*/;;g')" #外部資産インクルードディレクﾄﾘ
done < <(find $HOME/$REPO  -mindepth 1 -type d | grep -vP 'docker-log|\.git' | grep -v mnt)
