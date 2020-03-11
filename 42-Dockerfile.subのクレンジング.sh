#!/bin/bash

usage(){
cat <<EOS
Usage:
  $0 script-env docker-preprocess-stop-word-list
EOS
exit 0
}

ENV_REPO=$1;shift
STOP_WORD_LIST=$1;shift

[ -z $ENV_REPO ] && usage
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
done < <(find $HOME/$ENV_REPO -mindepth 1 -type d | grep -vP '\.git|docker-log')
