#!/bin/bash

./03-deploy.sh

while read tgt;do

  DIR=$(echo $tgt | grep -Po '(?<=/home/aine/script-env/).*(?=/doc.md:)')
  CMD=$(echo $tgt | grep -Po '(?<=:).*')

  echo "cd ~/script-env/$DIR && ( time docker build --no-cache -t $DIR . ) 1>~/script-env/$DIR/log 2>&1 &" | sh

done < <(find ~/script-env -name "*doc.md" | xargs grep -P 'script-env' | grep -v 'XXX')




#ls -l ~/script-env | grep -P '^d' | awk '{print $9}' | grep -v docker-build-log | xargs -P0 -I@ bash -c 'echo "cd ~/script-env/@ && ( time docker build --no-cache -t @ . ) 1>~/script-env/@/log 2>&1 &" ' | sh
