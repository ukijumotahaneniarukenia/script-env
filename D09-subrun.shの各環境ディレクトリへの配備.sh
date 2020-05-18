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

if [ -z $DEBUG ];then
  SHELL=bash
else
  SHELL=:
fi

[ -z $ENV_REPO ] && usage

SCRIPT_FILE_NAME=subrun.sh

while read tgt;do

  if [ -f $HOME/$ENV_REPO/$tgt/$SCRIPT_FILE_NAME ];then
    :
  else
    echo cp $HOME/$ENV_REPO/$SCRIPT_FILE_NAME $HOME/$ENV_REPO/$tgt/$SCRIPT_FILE_NAME | tee >($SHELL)
  fi

done < <(ls -l $HOME/$ENV_REPO | grep -P '^d' | awk '{print $9}' | grep -v docker-build-log)
