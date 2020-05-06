#!/usr/bin/env bash

usage(){
cat <<EOS
Usage:
  $0 $ENV_REPO
EOS
exit 0
}

ENV_REPO=$1;shift

docker ps -a | awk '{print $1,$2}' | tail -n+2 | grep -vE $(ls -l $HOME/$ENV_REPO | grep -P '^d' | awk '{print $9}' | grep -v docker-log |xargs|tr ' ' '|') | awk '{print $1}' | xargs -I@ bash -c 'docker stop @ && docker rm @' 1>/dev/null 2>&1
