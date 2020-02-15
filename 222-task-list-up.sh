#!/bin/bash

#RT=$(while read tgt;do
#
#  echo "grep OS_VERSION $tgt" | sh 1>/dev/null 2>&1
#  [ 0 -eq $? ] && echo 1 $tgt
#  [ 0 -eq $? ] || echo 0 $tgt
#
#done < <(find $HOME/script-env -name "Dockerfile" | xargs -I@ echo @))
#
#
#printf "完了件数[%s]未完了件数[%s]\n" $(echo "$RT" | grep -c '^1') $(echo "$RT" | grep -c '^0')
while read tgt;do

  echo "grep OS_VERSION $tgt" | sh 1>/dev/null 2>&1
#  [ 0 -eq $? ] && echo 1 $tgt
  [ 0 -eq $? ] || echo 0 $tgt

done < <(find $HOME/script-env -name "Dockerfile" | xargs -I@ echo @)

