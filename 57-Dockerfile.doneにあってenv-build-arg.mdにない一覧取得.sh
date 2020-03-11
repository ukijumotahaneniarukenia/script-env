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

#Dockerfile.done内のRUNスクリプトに埋め込まれているVERSION環境変数がenv-build-arg.mdファイルに存在するかチェック
while read dir;do
  echo $dir
  OS_VERSION=$(echo $dir | grep -Po '[a-z]+(-[0-9]{1,}){1,}')
  while read cmd;do
    RT=$(echo "grep $cmd $dir/env-build-arg.md")
    if [ -z "$RT" ];then
      #echo not exists
      echo 0 $tgt $cmd
    else
      #echo exists
      echo 1 $tgt $cmd
    fi
  done < <(grep VERSION.sh $dir/Dockerfile.done | grep -Po '[A-Z_]+' | grep -P '(?<!OS_)VERSION')
done < <(find $HOME/$ENV_REPO -mindepth 1 -type d | grep -vP '\.git|docker-log')

#Dockerfile.done内のARG環境変数がenv-build-arg.mdファイルに存在するかチェック
while read dir;do
  echo $dir
  OS_VERSION=$(echo $dir | grep -Po '[a-z]+(-[0-9]{1,}){1,}')
  while read arg;do
    RT=$(echo "grep $arg $dir/env-build-arg.md")
    if [ -z "$RT" ];then
      #echo not exists
      echo 0 $tgt $arg
    else
      #echo exists
      echo 1 $tgt $arg
    fi
  done < <(grep ARG $dir/Dockerfile.done | perl -pe 's/ARG //g' | grep -P '(?<!OS_)VERSION')
done < <(find $HOME/$ENV_REPO -mindepth 1 -type d | grep -vP '\.git|docker-log')
