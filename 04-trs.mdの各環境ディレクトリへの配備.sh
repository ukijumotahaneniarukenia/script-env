#!/bin/bash

while read tgt;do

  echo cp ~/script-env/trs.md ~/script-env/$tgt/trs.md | sh

done < <(ls -l ~/script-env | grep -P '^d' | awk '{print $9}' | grep -v docker-build-log)
