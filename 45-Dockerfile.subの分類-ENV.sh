#!/bin/bash

usage(){
cat <<EOS
Usage:
  $0 ENV
EOS
exit 0
}

CHK_WORD=$1

[ -z $CHK_WORD ] && usage

while read tgt;do
  if [ -f "$tgt/Dockerfile.sub" ];then
    RT="$(grep $CHK_WORD "$tgt/Dockerfile.sub")"
    if [ -z "$RT" ];then
      :
    else
      while read n;do
        echo $tgt $n | awk '{PRE=$1;$1="";gsub("^ ","",$0);print "echo \x27"$0"\x27>>"PRE"/env-build-arg.md"}'
      done < <(echo "$RT" | perl -pe 's/ENV\s{1,}//')
    fi
  else
    :
  fi
done < <(find $HOME/script-env -mindepth 1 -type d | grep -vP '\.git')
