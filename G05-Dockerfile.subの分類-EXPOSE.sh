#!/usr/bin/env bash

usage(){
cat <<EOS
Usage:
  $0 EXPOSE script-env
EOS
exit 0
}

CHK_WORD=$1;shift
ENV_REPO=$1;shift

[ -z $CHK_WORD ] && usage
[ -z $ENV_REPO ] && usage

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
done < <(find $HOME/$ENV_REPO -mindepth 1 -type d | grep -vP '\.git|docker-log|mnt')
