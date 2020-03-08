#!/bin/bash

usage(){
cat <<EOS
Usage:
  $0 script-env Dockerfile.sub-stop-word-list
EOS
exit 0
}

REPO=$1;shift
STOP_WORD_LIST=$1;shift

[ -z $REPO ] && usage
[ -z $STOP_WORD_LIST ] && usage

while read tgt;do
  if [ -f $tgt/Dockerfile.sub.done ];then
    #Dockerfile.sub.doneが存在する場合はクレンジングをしない
    :
  else
    #Dockerfile.sub.doneが存在しない場合はクレンジングをする
    while read stop_word;do
      echo "sed -i /$stop_word/d $tgt/Dockerfile.sub" | bash
    done < $STOP_WORD_LIST
  fi
done < <(find $HOME/$REPO -mindepth 1 -type d | grep -vP '\.git|docker-log')
