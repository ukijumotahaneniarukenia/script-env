#!/bin/bash

usage(){
cat <<EOS
Usage:
  $0 FROM
EOS
exit 0
}

CHK_WORD=$1

[ -z $CHK_WORD ] && usage

while read tgt;do
  if [ -f $tgt/env-image.md ];then
    :
  else
    echo touch $tgt/env-image.md | bash
  fi
  if [ -f $tgt/Dockerfile.sub ];then
    RT="$(grep $CHK_WORD $tgt/Dockerfile.sub)"
    if [ -z "$RT" ];then
      :
    else
      echo "echo '$RT' >>$tgt/env-image.md" | bash
    fi
  else
    :
  fi
done < <(find $HOME/script-env -mindepth 1 -type d | grep -vP '\.git')
