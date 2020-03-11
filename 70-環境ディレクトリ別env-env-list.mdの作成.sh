#!/bin/bash

usage(){
cat <<EOS
Usage:
  $0 script-env
EOS
exit 0
}

BASE_URL="https://github.com/ukijumotahaneniarukenia"

ENV_REPO=$1;shift

[ -z $ENV_REPO ] && usage

>$HOME/$ENV_REPO/env-env-list.md

while read tgt;do
  {
    if [ -s $tgt/env-env.md ];then
      echo "[$(echo $tgt | perl -pe 's;.*/;;g')]($BASE_URL/$ENV_REPO/blob/master/$(echo $tgt | perl -pe 's;.*/;;g')/env-env.md)"
      echo found
    else
      echo "[$(echo $tgt | perl -pe 's;.*/;;g')]($BASE_URL/$ENV_REPO/blob/master/$(echo $tgt | perl -pe 's;.*/;;g')/env-env.md)"
      echo not-found
    fi
  } | xargs | sed -r 's/ /|/g;s/^/|/;s/$/|/'
done < <(find $HOME/$ENV_REPO -mindepth 1 -type d | grep -vP '\.git|docker-log') | sort | sed '1i|環境ディレクトリ名|環境個別変数|' | sed '2i|:--|:-:|' >>$HOME/$ENV_REPO/env-env-list.md
