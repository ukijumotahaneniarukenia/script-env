#!/bin/bash

bash 03-doc.mdの各環境ディレクトリへの配備.sh

RETRY_ROUND="$@"

while read tgt;do

  DIR=$(echo $tgt | grep -Po '(?<=/home/aine/script-env/).*(?=/doc.md:)')
  CMD=$(echo $tgt | grep -Po '(?<=:).*' | sed 's;UNKO;;')

  echo "cd ~/script-env/$DIR && ( $CMD ) 1>~/script-env/$DIR/retry-$RETRY_ROUND-log 2>&1 &" | \
    grep -vP $(docker images | tail -n+1 | grep -P '(-[0-9]{1,}){2,}-' | awk '{print $1}'|xargs|tr ' ' '|') | sh

done < <(find ~/script-env -name "*doc.md" | grep -vP 'script-env/doc.md' | xargs grep -P 'UNKO')
