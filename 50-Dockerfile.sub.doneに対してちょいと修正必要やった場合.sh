#!/bin/bash

usage(){
cat <<EOS
Usage:
  $0 script-env
EOS
exit 0
}

REPO=$1;shift

[ -z $REPO ] && usage

while read tgt;do
  if [ -f $tgt/Dockerfile.sub.done ];then
    #Dockerfile.sub.doneが存在する場合はちょいと確認
    echo $tgt/Dockerfile.sub.done
    cat $tgt/Dockerfile.sub.done
  else
    #Dockerfile.sub.doneが存在しない場合はなにもしない
    :
  fi
done < <(find $HOME/$REPO -mindepth 1 -type d | grep -vP '\.git|docker-log')
