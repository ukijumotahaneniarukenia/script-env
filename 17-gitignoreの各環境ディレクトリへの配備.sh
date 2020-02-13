#!/bin/bash

while read tgt;do

  #.gitignoreファイルを配備
  echo cp ~/script-env/.gitignore ~/script-env/$tgt/.gitignore | sh

done < <(ls -l ~/script-env | grep -P '^d' | awk '{print $9}' | grep -v docker-build-log)
