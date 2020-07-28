#!/usr/bin/env bash

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

MD_FILE_NAME=env-env.env
OUTPUT_FILE_NAME=app-env-env-list.md

>$HOME/$ENV_REPO/$OUTPUT_FILE_NAME

while read tgt;do
  {
    if [ -s $tgt/$MD_FILE_NAME ];then
      echo "[$(echo $tgt | perl -pe 's;.*/;;g')]($BASE_URL/$ENV_REPO/blob/master/$(echo $tgt | perl -pe 's;.*/;;g')/$MD_FILE_NAME)"
      echo found
    else
      echo "[$(echo $tgt | perl -pe 's;.*/;;g')]($BASE_URL/$ENV_REPO/blob/master/$(echo $tgt | perl -pe 's;.*/;;g')/$MD_FILE_NAME)"
      echo not-found
    fi
  } | xargs | sed -r 's/ /|/g;s/^/|/;s/$/|/'
done < <(find $HOME/$ENV_REPO -mindepth 1 -type d | grep -vP '\.git|docker-log|mnt') | sort | sed '1i|環境ディレクトリ名|環境個別変数|' | sed '2i|:--|:-:|' >>$HOME/$ENV_REPO/$OUTPUT_FILE_NAME
