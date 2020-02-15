#!/bin/bash


#よさげだったら、以下で一括置換
#
#./21-一括置換対象確認.sh | awk '{$1="";$2="";print $0}' | sh


while read tgt;do

  printf "%s\t%s\t%s\n" $(grep -c -P '$HOME' $tgt) $tgt "sed -i 's;$HOME;\$HOME;g' $tgt" | grep -vP '^0'

done < <(find $HOME/script-env -type f -name "*sh" -o -name "*Dockerfile")
