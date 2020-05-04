#!/usr/bin/env bash

usage(){
  cat <<EOS
Usage:
  $0 script-env
EOS
exit 0
}

REPO=$1

[ -z $REPO ] && usage

while read tgt;do
  #echo $tgt;
  while read n;do
    if [ -f $tgt/$n ];then
      echo "mv $tgt/$n  $tgt/md-$n" #| bash
      echo "git rm $tgt/$n" #| bash
    else
      :
    fi
  done < <(ls *md | grep -v README.md  | perl -pe 's/^md-//;')
done < <(find $HOME/$REPO -mindepth 1 -type d | grep -vP '\.git|docker-log' )
