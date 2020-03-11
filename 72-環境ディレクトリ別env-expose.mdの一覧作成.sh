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

>$HOME/$ENV_REPO/app-env-expose-list.md

while read tgt;do
  if [ -s $tgt/env-expose.md ];then
    {
      echo "[$(echo $tgt | perl -pe 's;.*/;;g')]($BASE_URL/$ENV_REPO/blob/master/$(echo $tgt | perl -pe 's;.*/;;g')/env-expose.md)"
      grep -c -P  '\-p' $tgt/env-expose.md
      grep -P  '\-p' $tgt/env-expose.md | awk -v ORS='' '{print ","$1$2}'
    } | xargs -n3 | \
    while read file cnt item;do
      for (( i=0;i<$cnt;i++));do
        echo $file $(echo $item | cut -d',' -f$(($i+2)) | perl -pe 's/-p//;s/:/ /g')
      done
    done
  else
    echo "[$(echo $tgt | perl -pe 's;.*/;;g')]($BASE_URL/$ENV_REPO/blob/master/$(echo $tgt | perl -pe 's;.*/;;g')/env-expose.md)" not-found not-found
  fi \
  | sed -r 's/ /|/g;s/^/|/;s/$/|/'
done < <(find $HOME/$ENV_REPO -mindepth 1 -type d | grep -vP '\.git|docker-log') | sort | sed '1i|環境ディレクトリ名|外部公開ポート番号|内部使用ポート番号|' | sed '2i|:--|:-:|:-:|' >>$HOME/$ENV_REPO/app-env-expose-list.md
