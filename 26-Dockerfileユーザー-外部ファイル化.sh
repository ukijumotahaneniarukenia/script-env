#!/bin/bash

usage(){
  cat <<EOS
Usage:
  $0 script-env
EOS
exit 0
}

REPO="$1";shift

[ -z $REPO ] && usage

while read tgt;do

  #確認
  echo $HOME/$REPO/$tgt/Dockerfile
  #作成
  touch $HOME/$REPO/$tgt/env-usr.md
  >$HOME/$REPO/$tgt/env-usr.md
  #抽出
  sed -n '/RUN groupadd/,/root/p' $HOME/$REPO/$tgt/Dockerfile >$HOME/script-repo/script-env-$tgt-env-usr.sh
  #置換
  sed -i -r 's;RUN\s{1,};;g' $HOME/script-repo/script-env-$tgt-env-usr.sh
  #挿入
  sed -i '1i#!/usr/bin/env bash' $HOME/script-repo/script-env-$tgt-env-usr.sh
  #権限付与
  chmod 755 $HOME/script-repo/script-env-$tgt-env-usr.sh
  #リネーム
  echo $HOME/script-repo/script-env-$tgt-env-usr.sh | xargs -I@ bash -c 'echo mv @ $(echo @ | perl -pe "s;(.*-[0-9]+);\1-script-env;g;s;/script-env-;/;;s;script-env;install;g")' | bash

done < <(ls -l $HOME/$REPO | grep -P '^d' | awk '{print $9}' | grep -v docker-log)

#追記
while read tgt;do

  echo $tgt
  #FILE=$(echo $tgt | perl -pe "s/(?<=[0-9])-script-env//g;s;-env-usr\.sh;/env-usr\.md;g;s/script-repo/$REPO/g")
  ##確認
  #echo $FILE
  ##作成
  #touch $FILE
  #>$FILE
  ##抽出・書込
  #grep -oP '\-g [0-9]+ [a-zA-Z]+|\-g [a-zA-Z]+ -u [0-9]+ [a-zA-Z]+|[a-zA-Z]+_pwd' $tgt | perl -pe 's/.*-u //g;s/-g //g;s/ /\n/g' | xargs -n5 | perl -pe 's/root_pwd/0 root 0 root root_pwd/g' | \
  #  sed -r '/^$/d;s;^|$| ;|;g;1i|ユーザーＩＤ|ユーザー名|グループＩＤ|グループ名|パスワード|' | sed '2i|:-:|:-:|:-:|:-:|:-:|' >$FILE

done < <(find $HOME/script-repo | grep env-usr)
