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

find $HOME/$ENV_REPO -mindepth 1 -type d | grep -vP '\.git|docker-log|mnt' | grep -Po '[a-z]+(-[0-9]{1,}){1,}' | perl -pe 's/^([a-z]+)-(.*)$/\1/g' | sort | uniq -c | awk '{print $2,$1}'
