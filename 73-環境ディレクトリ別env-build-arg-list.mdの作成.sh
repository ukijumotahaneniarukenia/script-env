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

>$HOME/$ENV_REPO/env-build-arg-list.md

while read tgt;do
  if [ -s $tgt/env-build-arg.md ];then
    {
      echo "[$(echo $tgt | perl -pe 's;.*/;;g')]($BASE_URL/$ENV_REPO/blob/master/$(echo $tgt | perl -pe 's;.*/;;g')/env-build-arg.md)"
      grep -c -P  '=' $tgt/env-build-arg.md
      grep -P  '=' $tgt/env-build-arg.md | awk -v ORS='' '{print ","$1$2}'
    } | xargs -n3 | \
    while read file cnt item;do
      for (( i=0;i<$cnt;i++));do
        echo $file $(echo $item | cut -d',' -f$(($i+2))) | perl -pe 's/=/ /'
      done
    done
  else
    echo "[$(echo $tgt | perl -pe 's;.*/;;g')]($BASE_URL/$ENV_REPO/blob/master/$(echo $tgt | perl -pe 's;.*/;;g')/env-build-arg.md)" not-found not-found
  fi \
  | sed -r 's/ /|/g;s/^/|/;s/$/|/'
done < <(find $HOME/$ENV_REPO -mindepth 1 -type d | grep -vP '\.git|docker-log') | sort | sed '1i|環境ディレクトリ名|key|value|' | sed '2i|:--|:-:|:-:|' >>$HOME/$ENV_REPO/env-build-arg-list.md
