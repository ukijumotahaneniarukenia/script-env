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

MD_FILE_NAME=env-image.env

while read tgt;do

  if [ -f $HOME/$ENV_REPO/$tgt/$MD_FILE_NAME ];then
    #echo 1 $tgt
    :
  else
    #echo 0 $tgt
    touch $HOME/$ENV_REPO/$tgt/$MD_FILE_NAME
  fi

done < <(ls -l $HOME/$ENV_REPO | grep -P '^d' | awk '{print $9}' | grep -v docker-log)
