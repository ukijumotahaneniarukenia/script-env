#!/bin/bash

bash $HOME/script-env/03-doc.mdの各環境ディレクトリへの配備.sh

while read tgt;do

  DIR=$(echo $tgt | grep -Po '(?<=/home/aine/script-env/).*(?=/doc.md:)')
  CMD=$(echo $tgt | grep -Po '(?<=:).*' | sed 's;UNKO;;')

  echo "cd $HOME/script-env/$DIR && ( $CMD ) 1>$HOME/script-env/$DIR/log 2>&1 &" | sh

done < <(find $HOME/script-env -name "*doc.md" | grep -vP 'script-env/doc.md' | xargs grep -P 'UNKO')
