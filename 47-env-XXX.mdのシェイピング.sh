#!/bin/bash

while read tgt;do
  while read nnn;do
    if [ -f $tgt/$nnn ];then
      #空白行削除
      echo "sed -i /^$/d $tgt/$nnn" | bash
    else
      :
    fi
  done < <(find $HOME/script-env/ubuntu-16-04-vim -name "env-*" | perl -pe 's;.*/;;g')
done < <(find $HOME/script-env -mindepth 1 -type d | grep -vP '\.git|docker-log')
