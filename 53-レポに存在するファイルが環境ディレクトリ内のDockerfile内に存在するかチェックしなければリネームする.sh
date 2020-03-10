#!/bin/bash

#perl使う予定
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

#env-build-arg.mdにあってDockerfile.doneにないもの
while read dir;do
  echo $dir
  OS_VERSION=$(echo $dir | grep -Po '[a-z]+(-[0-9]{1,}){1,}')
  while read arg;do
    while read cmd;do
      n=$HOME/$INSTALLER_REPO/$(echo "( export $arg;export OS_VERSION=$OS_VERSION;export REPO=$INSTALLER_REPO;echo \"$cmd\")" | bash | grep -Po "$OS_VERSION.+\.sh")
      while read repo;do
        if [ $repo == $n ];then
          echo 1 $n $repo
        else
          echo 0 $n $repo
        fi
      done < <(find $HOME/$INSTALLER_REPO -type f | grep -vP '\.git|md$')
    done < <(grep VERSION.sh $dir/Dockerfile.done)
  done < <(grep VERSION $dir/env-build-arg.md) | grep -P '^1'
done < <(find $HOME/$ENV_REPO -mindepth 1 -type d | grep -vP '\.git|docker-log' )

#Dockerfile.doneにあってenv-build-arg.mdにないもの
