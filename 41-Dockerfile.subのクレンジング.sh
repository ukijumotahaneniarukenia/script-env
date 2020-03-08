#!/bin/bash

usage(){
cat <<EOS
Usage:
  $0 Dockerfile.sub-stop-word-list
EOS
exit 0
}

STOP_WORD_LIST=$1

[ -z $STOP_WORD_LIST ] && usage

while read tgt;do
  echo $tgt
  #cat $tgt
  while read stop_word;do
    #echo $stop_word
    echo "sed -i /$stop_word/d $tgt" | bash
  done < $STOP_WORD_LIST
done < <(find $HOME/script-env -name "Dockerfile.sub" | grep -vP oracle)
