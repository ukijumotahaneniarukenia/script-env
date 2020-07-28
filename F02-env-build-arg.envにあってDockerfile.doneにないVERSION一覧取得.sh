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
  while read arg;do
    RT=$(grep $(echo $arg | perl -pe 's/=.*//g') $dir/Dockerfile.done 2>/dev/null)
    if [ -z "$RT" ];then
      #echo not exists
      echo 0 $dir/Dockerfile.done $tgt $arg
    else
      #echo exists
      echo 1 $dir/Dockerfile.done $tgt $arg
    fi
  done < <(grep VERSION $dir/env-build-arg.env) | grep -P '^0'
done < <(find $HOME/$ENV_REPO -mindepth 1 -type d | grep -vP '\.git|docker-log') | uniq
