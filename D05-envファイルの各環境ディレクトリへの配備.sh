#!/usr/bin/env bash

usage(){
cat <<EOS
Usage:
  $0 script-env env-build-arg.env
  or
  $0 script-env env-build-arg.env --debug
EOS
exit 0
}

ENV_REPO=$1;shift
ENV_FILE_NAME=$1;shift
DEBUG=$1;shift

if [ -z $DEBUG ];then
  SHELL=bash
else
  SHELL=:
fi

[ -z $ENV_REPO ] && usage

while read tgt;do
  cmd="cp $HOME/$ENV_REPO/$ENV_FILE_NAME $HOME/$ENV_REPO/$tgt/$ENV_FILE_NAME"
  if [ "$SHELL" = 'bash' ];then
    echo $cmd | $SHELL
  else
    echo $cmd
  fi
done < <(ls -l $HOME/$ENV_REPO | grep -P '^d' | awk '{print $9}' | grep -v docker-build-log)
