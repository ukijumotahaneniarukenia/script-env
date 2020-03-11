#!/bin/bash

usage(){
  cat <<EOS
Usage:
  $0 script-env script-repo
EOS
exit 0
}

ENV_REPO="$1";shift
INSTALLER_REPO="$1";shift

[ -z $ENV_REPO ] && usage
[ -z $INSTALLER_REPO ] && usage


while read dir;do
  echo $dir
  OS_VERSION=$(echo $dir | grep -Po '[a-z]+(-[0-9]{1,}){1,}')
  while read arg;do
    RT=$(grep $(echo $arg | perl -pe 's/=.*//g') $dir/Dockerfile.done)
    if [ -z "$RT" ];then
      #echo not exists
      echo 0 $tgt $arg
    else
      #echo exists
      echo 1 $tgt $arg
    fi
  done < <(grep VERSION $dir/env-build-arg.md)
done < <(find $HOME/$ENV_REPO -mindepth 1 -type d | grep -vP '\.git|docker-log')
