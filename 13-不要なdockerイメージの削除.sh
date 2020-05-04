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

docker images | awk '{print $1}' | grep -P '(?:centos|ubuntu)-' | grep -vP $(ls -l $HOME/$REPO | grep -P '^d' | awk '{print $9}' | xargs | tr ' ' '|') | xargs -t -I@ docker rmi ${@:-unko}
