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
  if [ -d $tgt/mnt ];then
    echo "rm -r $tgt/mnt" #| bash
  fi
done < <(find $HOME/$REPO  -mindepth 1 -type d | grep -vP 'docker-log|\.git')
