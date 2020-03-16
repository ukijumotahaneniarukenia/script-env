#!/usr/bin/env bash

docker images | awk '{print $1}' | grep -P '(?:-[0-9]+){1,}' | while read tgt;do \
  echo $tgt
  MKDTM=$(docker history --human=false $tgt | sort -rk2 | sed -r 's;\s{1,}; ;g;' | cut -d' ' -f2 | sed -n '2p')
  NOW=$(date "+%Y-%m-%dT%H:%M:%S%:z")
  echo $MKDTM
  echo $NOW
  printf "(%s)/(24*60*60)\n" "$(date -d"$NOW" "+%s")-$(date -d"$MKDTM" "+%s")" | bc
done | xargs -n4  | sed -r 's/^/\|/;s/$/\|/;s/ {1,}/\|/g'| sed '1i|環境ディレクトリ名|イメージ作成日|今日|経過日数|' | sed '2i|:-:|:-:|:-:|:-:|' >app-env-image-mkdtm-list.md
