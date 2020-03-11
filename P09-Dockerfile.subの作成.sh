#!/usr/bin/env bash

usage(){
  cat <<EOS
Usage:
  $0 script-env
EOS
exit 0
}

ENV_REPO="$1";shift

[ -z $ENV_REPO ] && usage

#自動生成したDockerfileと既存Dockerfileのうち既存にしかないものを抽出
while read tgt;do
  if [ -f $tgt/Dockerfile.sub.done ];then
    #Dockerfile.sub.doneが存在する場合はDockerfile.subを作成しない
    : #echo 1 $tgt
  elif [ -f $tgt/Dockerfile.sub.undone ];then
    #Dockerfile.sub.undoneが存在する場合は着手したが完了していない状態なので、Dockerfile.subを作成しない。
    : #echo 1 $tgt
  else
    #echo 0 $tgt
    echo "cd  $tgt && comm -23 --nocheck-order <(sort Dockerfile | sed -r '/^$/d') <(sort Dockerfile.auto | sed -r '/^$/d')>Dockerfile.sub"
  fi
done < <(find $HOME/$ENV_REPO -mindepth 1 -type d | grep -vP '\.git|docker-log')
