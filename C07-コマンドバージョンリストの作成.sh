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

MD_FILE_NAME=env-build-arg.env
OUTPUT_FILE_NAME=app-env-cmd-version-list.md

find $HOME/$ENV_REPO -mindepth 1 -type d | grep -vP '\.git|docker-log|mnt' | xargs -I@ cat @/$MD_FILE_NAME | sort | uniq | awk -v FS='=' -v OFS=' ' '{print $1,$2}' >$OUTPUT_FILE_NAME
