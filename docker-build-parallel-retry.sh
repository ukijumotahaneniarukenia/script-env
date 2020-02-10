#!/bin/bash

./03-deploy.sh

RETRY_ROUND="$@"

while read tgt;do

  DIR=$(echo $tgt | grep -Po '(?<=/home/aine/script-env/).*(?=/doc.md:)')
  CMD=$(echo $tgt | grep -Po '(?<=:).*')

  echo "cd ~/script-env/$DIR && ( time docker build --no-cache -t $DIR . ) 1>~/script-env/$DIR/retry-$RETRY_ROUND-log 2>&1 &" | \
    grep -vP $(docker images | tail -n+1 | grep -P '(-[0-9]{1,}){2,}-' | awk '{print $1}'|xargs|tr ' ' '|')

done < <(find ~/script-env -name "*doc.md" | xargs grep -P 'script-env' | grep -v 'XXX')
