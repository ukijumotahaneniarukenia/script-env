#!/usr/bin/env bash

usage(){
cat <<EOS
Usage:
  $0 script-repo
  or
  $0 script-repo --debug
EOS
exit 0
}

SCRIPT_REPO=$1;shift
DEBUG=$1;shift

if [ "$DEBUG" = '--debug' ];then
  SHELL=: #なんもしない
else
  SHELL=bash #じっこうする
fi

[ -z $SCRIPT_REPO ] && usage

#追記
while read tgt;do
  #echo $tgt

  TMP_FILE=$(echo $tgt | perl -pe 's;.*/;;g' | perl -pe 's;^;/tmp/;')
  echo $TMP_FILE
  grep -vP 'root|aine|kuraine|nahato|mujiku' $tgt >$TMP_FILE
  cat $TMP_FILE | grep -v 'bash'
  #RESULT="$(grep -vP 'bash' $TMP_FILE)"
  #if [ "XXX" == "XXX$RESULT" ] ;then
  #  #デフォルトユーザーを使用
  #  echo 0 $tgt

  #else
  #  :
  #  #デフォルトユーザー以外を使用
  #  echo 1 $tgt
  #fi

  #デフォルトユーザー使用でないにもかかわらず、デフォルトユーザーを使用している場合は、削除
done < <(find $HOME/$SCRIPT_REPO | grep user) #| grep -P '^0' | awk '{print $2}' | grep -v default | xargs rm -f

#find /tmp -type f -name "*user*" 2>/dev/null | xargs rm -f
