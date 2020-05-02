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

>$HOME/$ENV_REPO/app-user-list.md

while read tgt;do
  RT=$(cat $tgt/user.md | sed -r '/\|ユーザーＩＤ|\|:-:/d;')
  if [ -z "$RT" ];then
    echo "[$(echo $tgt | perl -pe 's;.*/;;g')]($BASE_URL/$ENV_REPO/blob/master/$(echo $tgt | perl -pe 's;.*/;;g')/user.md)" 0 @1001@kuraine@1001@kuraine@kuraine_pwd
  else
    {
      echo "[$(echo $tgt | perl -pe 's;.*/;;g')]($BASE_URL/$ENV_REPO/blob/master/$(echo $tgt | perl -pe 's;.*/;;g')/user.md)"
      cat $tgt/user.md | sed -r '/\|ユーザーＩＤ|\|:-:/d;' | wc -l
      cat $tgt/user.md | sed -r '/\|ユーザーＩＤ|\|:-:/d;s;\|;@;g;s;@$;;' | awk -v ORS='' '{print ","$1$2}'
    } | xargs -n3 | \
    while read file cnt item;do
      for (( i=0;i<$cnt;i++));do
        echo $file $cnt $(echo $item | cut -d',' -f$(($i+2)) | perl -pe 's/-p//;s/:/ /g')
      done
    done
  fi \
  | cut -d' ' -f1,3 \
  | sed -r 's/@/\|/g;s/^/|/;s/$/|/'
done < <(find $HOME/$ENV_REPO -mindepth 1 -type d | grep -vP '\.git|docker-log') | sort | \
  sed '1i|環境ディレクトリ名|ユーザーＩＤ|ユーザー名|グループＩＤ|グループ名|パスワード|' | \
  sed '2i|:--|:--|:--|:--|:--|:--|' >>$HOME/$ENV_REPO/app-user-list.md
