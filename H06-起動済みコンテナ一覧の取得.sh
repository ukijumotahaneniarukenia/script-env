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

docker ps -a | head -n1
docker ps -a | grep Up | grep -P $(ls -l $HOME/$ENV_REPO | grep -P '^d' | awk '{print $9}' | grep -v docker-log|xargs|tr ' ' '|')
