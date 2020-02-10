#!/bin/bash

./03-deploy.sh

while read tgt;do

  DIR=$(echo $tgt | grep -Po '(?<=/home/aine/script-env/).*(?=/doc.md:)')
  CMD=$(echo $tgt | grep -Po '(?<=:).*' | sed 's;UNKO;;')

  echo "cd ~/script-env/$DIR && ( $CMD ) 1>~/script-env/$DIR/log 2>&1 &" | sh

done < <(find ~/script-env -name "*doc.md" | grep -vP 'script-env/doc.md' | xargs grep -P 'UNKO')
