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

#追記
while read tgt;do

  #MD_FILEの作成
  MD_FILE=$(echo $tgt | perl -pe "s/(?<=[0-9])-script-env//g;s;-env-usr\.sh;/env-usr\.md;g;s;script-repo;$REPO;g;s;-install;;g")
  touch $MD_FILE
  >$MD_FILE

  TMP_FILE=$(echo $tgt | perl -pe 's;.*/;;g' | perl -pe 's;^;/tmp/;')
  grep -vP 'root|aine|kuraine|nahato|mujiku' $tgt >$TMP_FILE
  RESULT="$(grep -vP 'bash' $TMP_FILE)"
  if [ "XXX" == "XXX$RESULT" ] ;then
    #デフォルトユーザーを使用
    #echo 0 $tgt
    printf "%s\n%s\n" '1001 kuraine 1001 kuraine kuraine_pwd' '0 root 0 root root_pwd' | \
      sed -r '/^$/d;s;^|$| ;|;g;1i|ユーザーＩＤ|ユーザー名|グループＩＤ|グループ名|パスワード|' | sed '2i|:-:|:-:|:-:|:-:|:-:|' >$MD_FILE
    :
  else
    :
    #デフォルトユーザー以外を使用
    #echo 1 $tgt
    grep -oP '\-g [0-9]+ [a-zA-Z]+|\-g [a-zA-Z]+ -u [0-9]+ [a-zA-Z]+|[a-zA-Z]+_pwd' $tgt | perl -pe 's/.*-u //g;s/-g //g;s/ /\n/g' | xargs -n5 | perl -pe 's/root_pwd/0 root 0 root root_pwd/g' | \
      sed -r '/^$/d;s;^|$| ;|;g;1i|ユーザーＩＤ|ユーザー名|グループＩＤ|グループ名|パスワード|' | sed '2i|:-:|:-:|:-:|:-:|:-:|' >$MD_FILE
  fi

done < <(find $HOME/script-repo | grep env-usr)

find /tmp -type f -name "*env-usr*" 2>/dev/null | xargs rm
