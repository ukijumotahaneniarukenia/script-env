#!/usr/bin/env bash

usage(){
cat <<EOS
Usage:
  $0 $ENV_REPO
EOS
exit 0
}

ENV_REPO=$1;shift

[ -z $ENV_REPO ] && usage

MD_FILE_NAME=.gitignore

while read tgt;do

  echo cp $HOME/$ENV_REPO/$MD_FILE_NAME $HOME/$ENV_REPO/$tgt/$MD_FILE_NAME | sh

done < <(ls -l $HOME/$ENV_REPO | grep -P '^d' | awk '{print $9}' | grep -v docker-build-log)
