#!/bin/bash

while read tgt;do

  #.gitignoreファイルを配備
  echo cp $HOME/script-env/.gitignore $HOME/script-env/$tgt/.gitignore | sh

done < <(ls -l $HOME/script-env | grep -P '^d' | awk '{print $9}' | grep -v docker-log)
