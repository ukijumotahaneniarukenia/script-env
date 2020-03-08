#!/bin/bash

usage(){
cat <<EOS
Usage:
  $0 ARG
EOS
exit 0
}

CHK_WORD=$1

[ -z $CHK_WORD ] && usage

while read tgt;do
  echo $tgt
  KEY=$(grep $CHK_WORD $tgt | awk '{print $2}')
  WORD=$(grep $CHK_WORD $tgt | awk '{print $2}' | perl -pe 's/VERSION//' | perl -pe 's/_/-/g')
  while read f;do
    [ -z ${WORD} ] && continue
    if [[ ${f} =~ ${WORD,,}.* ]]; then
      {
        echo ${KEY}
        echo ${BASH_REMATCH[0]} | perl -pe 's/\.sh//g' | grep -Po '(-[0-9]+){1,}' | perl -pe 's/^-//'
      } | xargs -n2 | tr ' ' '='
    else
      :
    fi
  done < <(find $HOME/script-repo -type f | grep -vP '\.git')
done < <(find . -name "Dockerfile.sub" | grep -vP oracle)
