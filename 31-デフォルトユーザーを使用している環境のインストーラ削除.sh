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

  TMP_FILE=$(echo $tgt | perl -pe 's;.*/;;g' | perl -pe 's;^;/tmp/;')
  grep -vP 'root|aine|kuraine|nahato|mujiku' $tgt >$TMP_FILE
  RESULT="$(grep -vP 'bash' $TMP_FILE)"
  if [ "XXX" == "XXX$RESULT" ] ;then
    #デフォルトユーザーを使用
    echo 0 $tgt

  else
    :
    #デフォルトユーザー以外を使用
    echo 1 $tgt
  fi

  #デフォルトユーザー使用でないにもかかわらず、デフォルトユーザーを使用している場合は、削除
done < <(find $HOME/script-repo | grep env-usr) | grep -P '^0' | awk '{print $2}' | grep -v default | xargs rm -f

find /tmp -type f -name "*env-usr*" 2>/dev/null | xargs rm -f
