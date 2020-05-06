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

find $HOME/$ENV_REPO -mindepth 1 -type d | grep -vP '\.git|docker-log|mnt' | perl -pe 's;.*/;;' | grep -Po '(-[a-zA-Z]+){1,}' | tr '-' '\n' | sed '/^$/d' | sort | uniq -c | awk '{print $2,$1}'
