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
  echo $tgt
  grep $CHK_WORD $tgt | tr ' ' '='
done < <(find . -name "Dockerfile.sub" | grep -vP oracle)
