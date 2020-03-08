#!/bin/bash

usage(){
  cat <<EOS
Usage:
  $0 script-env
EOS
exit 0
}

REPO="$1";shift

[ -z $REPO ] && usage

while read tgt;do

  #確認
  echo $HOME/$REPO/$tgt/Dockerfile
  #置換
  sed -i -n '/RUN groupadd/,/root/!p' $HOME/$REPO/$tgt/Dockerfile

done < <(ls -l $HOME/$REPO | grep -P '^d' | awk '{print $9}' | grep -v docker-log)
