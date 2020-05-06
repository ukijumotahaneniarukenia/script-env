#!/usr/bin/env bash

usage(){
cat <<EOS
Usage:
  $0 script-env
EOS
exit 0
}

ENV_REPO=$1;shift

[ -z $ENV_REPO ] && usage

while read tgt;do
  if [ -f $tgt/Dockerfile.sub.done ];then
    #Dockerfile.sub.doneが存在する場合はクレンジングをしない
    :
  elif [ -f $tgt/Dockerfile.sub.undone ];then
    #Dockerfile.sub.undoneが存在する場合は着手はしたが完了していない状態のため、個別対応スクリプトを用意して、ここではクレンジングしない
    :
  else
    #Dockerfile.sub.doneが存在しない場合はクレンジングをする
    echo $tgt/Dockerfile.sub
    cat $tgt/Dockerfile.sub
  fi
done < <(find $HOME/$ENV_REPO -mindepth 1 -type d | grep -vP '\.git|docker-log|mnt')
