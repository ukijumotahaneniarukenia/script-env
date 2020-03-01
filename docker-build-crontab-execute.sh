#!/usr/bin/env bash

usage(){
  cat <<EOS
Usage:
  bash $0 1 docker-build-wanted-list
EOS
exit 0
}

ROUND_CNT="$1";shift
BUILD_LIST_FILE="$1";shift

[ -z $ROUND_CNT ] && usage
[ -z $BUILD_LIST_FILE ] && usage

while read tgt;do

  DIR=$(echo $tgt | grep -Po "(?<=$HOME/script-env/).*(?=/doc.md:)")
  CMD=$(echo $tgt | grep -Po '(?<=:).*' | sed 's;UNKO;;')

  echo "cd $HOME/script-env/$DIR && ( $CMD ) 1>$HOME/script-env/$DIR/$ROUND_CNT-log 2>&1 &" #| bash

done < <(find $HOME/script-env -name "*doc.md" | \
  grep -vP 'script-env/doc.md' | \
  xargs grep -P 'UNKO' | \
  grep -P $(cat $HOME/script-env/$BUILD_LIST_FILE | xargs | tr ' ' '|') | \
  grep -vP $(cat $HOME/script-env/docker-build-exclude-list | xargs | tr ' ' '|') )
