#!/bin/bash

while read tgt;do
  #前回実行時の連番をコメントアウトで残す
  #echo mkdir -p $HOME/script-sketch/$tgt
  seq 1 10 | xargs -I@ printf "touch $HOME/script-sketch/$tgt/%05g-%s-用途名-non-alias名-alias名.拡張子\n" @ $tgt
  #seq 11 20 | xargs -I@ printf "touch $HOME/script-sketch/$tgt/%05g-%s-用途名-alias名.拡張子\n" @ $tgt
  #seq 21 30 | xargs -I@ printf "touch $HOME/script-sketch/$tgt/%05g-%s-用途名-alias名.拡張子\n" @ $tgt
  #seq 31 40 | xargs -I@ printf "touch $HOME/script-sketch/$tgt/%05g-%s-用途名-alias名.拡張子\n" @ $tgt

done < <(ls ~/script-env | grep -vP '(sh|md|log|crontab)$' | grep -vP '^[0-9]{1,}' | perl -pe 's/[a-z]{1,}(-[0-9]{1,}){1,}-//g;s/-/\n/g;' | sort | uniq)
