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
  while read cmd;do
    if [ -f $dir/Dockerfile.done ];then
      RT=$(grep $cmd $dir/Dockerfile.done | grep -vP 'RUN')
      if [ -z "$RT" ];then
        #echo not exists
        echo 0 $dir/Dockerfile.done $tgt $cmd
      else
        #echo exists
        echo 1 $dir/Dockerfile.done $tgt $cmd
      fi
    else
      :
    fi
  done < <(grep VERSION.sh $dir/Dockerfile.done 2>/dev/null | grep -Po '[A-Z_]+' | grep -P '(?<!OS_)VERSION') | grep -P '^0'
done < <(find $HOME/$ENV_REPO -mindepth 1 -type d | grep -vP '\.git|docker-log') | uniq
