#!/bin/bash

while read tgt;do

  if [ -f $HOME/script-env/$tgt/env-image.md ];then
    #echo 1 $tgt
    :
  else
    #echo 0 $tgt
    touch $HOME/script-env/$tgt/env-image.md
  fi

done < <(ls -l $HOME/script-env | grep -P '^d' | awk '{print $9}' | grep -v docker-log)
