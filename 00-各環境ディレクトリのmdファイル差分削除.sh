#!/bin/bash

while read tgt;do
  echo $tgt
  find $HOME/script-env/$tgt -name "*md" | perl -pe 's;.*/;;g' | grep -vP 'systemd'
  ##echo $tgt
  #find $HOME/script-env -name "*md" | grep -vP '(-[0-9]){1,}' | perl -pe 's;.*/;;g' | grep -vP "$(find $HOME/script-env/$tgt -name "*md" | perl -pe 's;.*/;;g'|xargs|tr ' ' '|')" | \
  #  xargs -I@ echo touch $HOME/script-env/$tgt/@

done < <(ls -l ~/script-env | grep -P '^d' | awk '{print $9}' | grep -v docker-build-log) 
