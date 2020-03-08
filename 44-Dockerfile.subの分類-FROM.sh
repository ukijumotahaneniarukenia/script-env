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
  RT="$(grep $CHK_WORD $tgt)"
  if [ -z "$RT" ];then
    :
  else
    echo $tgt $RT
  fi
done < <(find . -name "Dockerfile.sub" | grep -vP oracle)
