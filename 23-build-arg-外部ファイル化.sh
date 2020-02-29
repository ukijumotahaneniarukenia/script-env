#!/bin/bash

usage(){
  cat <<EOS
Usage:
  $0 build-arg script-env
EOS
exit 0
}

N="$1";shift
REPO="$1";shift

[ -z $N ] && usage
[ -z $REPO ] && usage

while read tgt;do

  grep -r -n -P "$N" $HOME/$REPO/$tgt | grep -P env\.md | awk -v FS=':' -v N=$N '{FILE_NAME=$1;gsub(/env.md/,"env-"N".md",FILE_NAME);print "rm -rf "FILE_NAME}'
  grep -r -n -P "$N" $HOME/$REPO/$tgt | grep -P env\.md | awk -v FS=':' -v OFS='\n' -v N=$N '{
    s=split($3,ary," ");
    FILE_NAME=$1;
  }
  END{
    for(e in ary){
      print ary[e]
      gsub(/env.md/,"env-"N".md",FILE_NAME);print FILE_NAME
    }
  }' | xargs -n2 | grep -vP "\--$N" | sort -k2,1 | awk '{print "echo \x27"$1"\x27>>"$2}'

done < <(ls -l $HOME/$REPO | grep -P '^d' | awk '{print $9}' | grep -v docker-build-log)


#ファイル存在チェック
#ls -l $HOME/$REPO | grep -P '^d' | awk '{print $9}' | grep -v docker-build-log | while read tgt;do echo $HOME/$REPO/$tgt/env-$N.md;done | xargs -I@ ls @
