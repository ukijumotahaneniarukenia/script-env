#!/bin/bash

find $HOME/script-repo | grep env-usr | while read tgt;do
  FILE=$(echo $tgt | perl -pe 's;.*/;;g' | perl -pe 's;^;/tmp/;')
  grep -vP 'root|aine|kuraine|nahato|mujiku' $tgt >$FILE
  RESULT="$(grep -vP 'bash' $FILE)"
  if [ "XXX" == "XXX$RESULT" ] ;then
    #デフォルトユーザーを使用
    echo 0 $tgt
  else
    #デフォルトユーザー以外を使用
    echo 1 $tgt
  fi
done | grep -P '^1' | awk '{print $2}' | perl -pe 's;.*/;;g'

find /tmp -type f -name "*env-usr*" 2>/dev/null | xargs rm
