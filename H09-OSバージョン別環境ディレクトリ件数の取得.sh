#!/usr/bin/env bash

usage(){
cat <<EOS
Usage:
  $0 script-env
EOS
exit 0
}

BASE_URL="https://github.com/ukijumotahaneniarukenia"

ENV_REPO=$1;shift

[ -z $ENV_REPO ] && usage

find $HOME/$ENV_REPO -mindepth 1 -type d | grep -vP '\.git|docker-log|mnt' | grep -Po '[a-z]+(-[0-9]{1,}){1,}' | sort | uniq -c | awk '{print $2,$1}'
