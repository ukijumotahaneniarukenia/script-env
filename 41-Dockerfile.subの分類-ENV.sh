#!/bin/bash

usage(){
cat <<EOS
Usage:
  $0 ENV script-env
EOS
exit 0
}

CHK_WORD=$1;shift
ENV_REPO=$1;shift

[ -z $CHK_WORD ] && usage
[ -z $ENV_REPO ] && usage

while read tgt;do
  if [ -f "$tgt/env-env.md" ];then
    :
  else
    echo "touch $tgt/env-env.md" | bash
  fi
  if [ -f "$tgt/Dockerfile.sub" ];then
    RT="$(grep $CHK_WORD "$tgt/Dockerfile.sub")"
    if [ -z "$RT" ];then
      :
    else
      while read n;do
        echo $tgt $n | awk '{PRE=$1;$1="";gsub("^ ","",$0);print "echo \x27"$0"\x27>>"PRE"/env-env.md"}'
      done < <(echo "$RT" | perl -pe 's/ENV\s{1,}//')
    fi
  else
    :
  fi
done < <(find $HOME/$ENV_REPO -mindepth 1 -type d | grep -vP '\.git|docker-log')
