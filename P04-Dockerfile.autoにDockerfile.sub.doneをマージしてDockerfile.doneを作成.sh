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
  if [ -f $tgt/Dockerfile.sub.done ];then
    echo "sed '/DOCKERFILE_SUB/r $tgt/Dockerfile.sub.done' $tgt/Dockerfile.auto >$tgt/Dockerfile.done" | bash
    echo "sed -i '/DOCKERFILE_SUB/d' $tgt/Dockerfile.done" | bash
  fi
done < <(find $HOME/$REPO  -mindepth 1 -type d | grep -vP 'docker-build-log|\.git')
