#!/bin/bash

usage(){
  cat <<EOS
Usage:
  $0 SHM_SIZE script-env
EOS
exit 0
}

N="$1";shift
REPO="$1";shift

[ -z $N ] && usage
[ -z $REPO ] && usage

while read tgt;do

  grep -r -n -P "$N" $HOME/$REPO/$tgt | grep -P env\.md | awk -v FS=':' -v N=$(echo ${N,,} | perl -pe 's/_/-/g' ) '{FILE_NAME=$1;gsub(/env.md/,"env-"N".md",FILE_NAME);print "rm -rf "FILE_NAME}'
  grep -r -n -P "$N" $HOME/$REPO/$tgt | grep -P env\.md |  awk -v FS=':' -v N=$(echo ${N,,} | perl -pe 's/_/-/g' ) -v FILE=$HOME/$REPO/$tgt '{
  print "echo \x27"$3"\x27>>"FILE"/env-"N".md"
}'

done < <(ls -l $HOME/$REPO | grep -P '^d' | awk '{print $9}' | grep -v docker-log)

#ファイル存在チェック
#ls -l $HOME/$REPO | grep -P '^d' | awk '{print $9}' | grep -v docker-log | while read tgt;do echo $HOME/$REPO/$tgt/env-${N,,}.md;done | xargs -I@ ls @
