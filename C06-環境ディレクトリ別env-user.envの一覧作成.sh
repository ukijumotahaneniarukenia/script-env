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

INPUT_FILE_NAME=env-user.env
OUTPUT_FILE_NAME=app-env-user-list.md

>$HOME/$ENV_REPO/$OUTPUT_FILE_NAME

while read tgt;do
  RT=$(cat $tgt/$INPUT_FILE_NAME | sed -r '/\|ユーザーＩＤ|\|:-:/d;')
  if [ -z "$RT" ];then
    echo "[$(echo $tgt | perl -pe 's;.*/;;g')]($BASE_URL/$ENV_REPO/blob/master/$(echo $tgt | perl -pe 's;.*/;;g')/$INPUT_FILE_NAME)" 0 @1001@kuraine@1001@kuraine@kuraine_pwd
  else
    {
      echo "[$(echo $tgt | perl -pe 's;.*/;;g')]($BASE_URL/$ENV_REPO/blob/master/$(echo $tgt | perl -pe 's;.*/;;g')/$INPUT_FILE_NAME)"
      cat $tgt/$INPUT_FILE_NAME | sed -r '/\|ユーザーＩＤ|\|:-:/d;' | wc -l
      cat $tgt/$INPUT_FILE_NAME | sed -r '/\|ユーザーＩＤ|\|:-:/d;s;\|;@;g;s;@$;;' | awk -v ORS='' '{print ","$1$2}'
    } | xargs -n3 | \
    while read file cnt item;do
      for (( i=0;i<$cnt;i++));do
        echo $file $cnt $(echo $item | cut -d',' -f$(($i+2)) | perl -pe 's/-p//;s/:/ /g')
      done
    done
  fi \
  | cut -d' ' -f1,3 \
  | sed -r 's/@/\|/g;s/^/|/;s/$/|/'
done < <(find $HOME/$ENV_REPO -mindepth 1 -type d | grep -vP '\.git|docker-log|mnt') | sort | \
  sed '1i|環境ディレクトリ名|ユーザーＩＤ|ユーザー名|グループＩＤ|グループ名|パスワード|' | \
  sed '2i|:--|:--|:--|:--|:--|:--|' >>$HOME/$ENV_REPO/$OUTPUT_FILE_NAME
