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
    RT=$(echo "grep $arg $dir/env-build-arg.md")
    if [ -z "$RT" ];then
      #echo not exists
      echo 0 $dir/env-build-arg.md $tgt $arg
    else
      #echo exists
      echo 1 $dir/env-build-arg.md $tgt $arg
    fi
  done < <(grep ARG $dir/Dockerfile.done 2>/dev/null | perl -pe 's/ARG //g' | grep -P '(?<!OS_)VERSION') | grep -P '^1'
done < <(find $HOME/$ENV_REPO -mindepth 1 -type d | grep -vP '\.git|docker-log') | uniq
