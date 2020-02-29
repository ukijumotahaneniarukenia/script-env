#!/bin/bash

find $HOME/script-repo | grep script-env | while read tgt;do
  FILE=$(echo $tgt | perl -pe 's;.*/;;g' | perl -pe 's;^;/tmp/;')
  grep -vP 'root|aine|kuraine|nahato|mujiku' $tgt >$FILE
  RESULT="$(grep -vP 'bash' $FILE)"
  if [ "XXX" == "XXX$RESULT" ] ;then
    echo non-tgt
  else
    echo $tgt
  fi
done | grep -vP 'non-tgt'

find /tmp -type f -name "*script-env*" 2>/dev/null | xargs rm
