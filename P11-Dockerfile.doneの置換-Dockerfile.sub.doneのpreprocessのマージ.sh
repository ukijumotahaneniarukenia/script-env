#!/usr/bin/env bash

usage(){
cat <<EOS
Usage:
  $0 script-env
  or
  $0 script-env --debug
EOS
exit 0
}

ENV_REPO=$1;shift
DEBUG=$1;shift

if [ "$DEBUG" = '--debug' ];then
  SHELL=: #なんもしない
else
  SHELL=bash #じっこうする
fi

[ -z $ENV_REPO ] && usage

while read tgt;do
  if [ -f $tgt/Dockerfile.sub.preprocess.done ];then
    cmd=$(echo "sed -i '/^DOCKERFILE_SUB_PREPROCESS$/r $tgt/Dockerfile.sub.preprocess.done' $tgt/Dockerfile.done")
    if [ "$SHELL" = 'bash' ];then
      echo $cmd | $SHELL
    else
      echo $cmd
    fi
    cmd=$(echo "sed -i '/^DOCKERFILE_SUB_PREPROCESS$/d' $tgt/Dockerfile.done")
    if [ "$SHELL" = 'bash' ];then
      echo $cmd | $SHELL
    else
      echo $cmd
    fi
  fi
done < <(find $HOME/$ENV_REPO  -mindepth 1 -type d | grep -vP '\.git|docker-log|mnt')
