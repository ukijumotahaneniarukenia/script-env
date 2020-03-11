#!/bin/bash

usage(){
cat <<EOS
Usage:
  $0 script-env
EOS
exit 0
}

ENV_REPO=$1;shift

[ -z $ENV_REPO ] && usage

while read tgt;do
  while read nnn;do
    if [ -f $tgt/$nnn ];then
      #空白行削除
      echo "sed -i /^$/d $tgt/$nnn" | bash
    else
      :
    fi
  done < <(find $HOME/$ENV_REPO/ubuntu-16-04-vim -name "env-*" | perl -pe 's;.*/;;g') #環境ディレクトリの中から代表１つチョイス
done < <(find $HOME/$ENV_REPO -mindepth 1 -type d | grep -vP '\.git|docker-log')
