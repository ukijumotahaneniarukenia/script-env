#!/bin/bash

usage(){
cat <<EOS
Usage:
  $0 EXPOSE
EOS
exit 0
}

CHK_WORD=$1

[ -z $CHK_WORD ] && usage

while read tgt;do
  if [ -f $tgt/Dockerfile.sub ];then
    RT="$(grep $CHK_WORD $tgt/Dockerfile.sub | tr ' ' '=')"
    if [ -z "$RT" ];then
      :
    else
      while read n;do
        echo "echo '-p $n' >>$tgt/env-expose.md" | bash
      done < <(echo $RT | perl -pe 's/([0-9]+)/\1:\1/g;s/EXPOSE=//g'| tr ' ' '\n')
    fi
  else
    :
  fi
  if [ -f $tgt/Dockerfile.sub ];then
    echo "sed -i /^$/d $tgt/env-expose.md" | bash
  else
    :
  fi
done < <(find $HOME/script-env -mindepth 1 -type d | grep -vP '\.git')
