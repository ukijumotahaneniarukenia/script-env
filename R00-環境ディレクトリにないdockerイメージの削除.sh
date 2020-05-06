#!/usr/bin/env bash

usage(){
  cat <<EOS
Usage:
  $0 script-env
EOS
exit 0
}

ENV_REPO=$1

[ -z $ENV_REPO ] && usage

docker images | awk '{print $1}' | grep -P '(?:centos|ubuntu)-' | grep -vP $(ls -l $HOME/$ENV_REPO | grep -P '^d' | awk '{print $9}' | xargs | tr ' ' '|') | \


while read tgt;do

  CONTAINER_ID="$(docker ps -a | grep $tgt | awk '{print $1}')"

  if [ -z $CONTAINER_ID ];then
    docker rmi $tgt
  else
    docker stop $CONTAINER_ID && docker rm $CONTAINER_ID
    docker rmi $tgt
  fi

done
