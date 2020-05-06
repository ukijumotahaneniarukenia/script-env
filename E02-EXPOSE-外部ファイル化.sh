#!/bin/bash

usage(){
  cat <<EOS
Usage:
  $0 EXPOSE script-env
EOS
exit 0
}

N="$1";shift
REPO="$1";shift

[ -z $N ] && usage
[ -z $REPO ] && usage

while read tgt;do

  grep -r -n -P "$N" $HOME/$REPO/$tgt | grep -P env\.md | awk -v FS=':' -v N=${N,,} '{FILE_NAME=$1;gsub(/md-env.md/,"env-"N".md",FILE_NAME);print "rm -rf "FILE_NAME}'
  grep -r -n -P "$N" $HOME/$REPO/$tgt | grep -P env\.md | perl -pe 's/(.*)(?<=EXPOSE=)(.*)/\2/g' | perl -pe 's/ -p/\n-p/g' | awk -v N=${N,,} -v FILE=$HOME/$REPO/$tgt '{
  print "echo \x27"$0"\x27>>"FILE"/env-"N".md"
}'

done < <(ls -l $HOME/$REPO | grep -P '^d' | awk '{print $9}' | grep -v docker-log)

#ファイル存在チェック

#ls -l $HOME/$REPO | grep -P '^d' | awk '{print $9}' | grep -v docker-log | while read tgt;do echo $HOME/$REPO/$tgt/env-${N,,}.md;done | xargs -I@ ls @
