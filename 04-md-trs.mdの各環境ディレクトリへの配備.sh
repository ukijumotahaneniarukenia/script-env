#!/bin/bash

while read tgt;do

  echo cp $HOME/script-env/md-trs.md $HOME/script-env/$tgt/md-trs.md | sh

done < <(ls -l $HOME/script-env | grep -P '^d' | awk '{print $9}' | grep -v docker-log)
