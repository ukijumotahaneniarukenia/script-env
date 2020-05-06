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
  if [ -f $tgt/Dockerfile.asis ];then
    :
  else
    #asisが存在しない場合はリネーム
    echo "mv $tgt/Dockerfile $tgt/Dockerfile.asis"
  fi
done < <(find $HOME/$ENV_REPO -mindepth 1 -type d | grep -vP '\.git|docker-log|mnt')
