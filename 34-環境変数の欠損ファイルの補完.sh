#!/bin/bash

while read tgt;do

  RT="$(echo "grep '' $HOME/script-env/$tgt/env-expose.md | xargs" | sh 2>/dev/null)"
  #デフォルト設定を適用
  [ -z "$RT" ] && echo 0 $RT $HOME/script-env/$tgt/env-expose.md
  #環境個別の設定を適用
  [ -z "$RT" ] || echo 1 $RT $HOME/script-env/$tgt/env-expose.md

  RT="$(echo "grep '' $HOME/script-env/$tgt/env-shm-size.md" | sh 2>/dev/null)"
  #デフォルト設定を適用
  [ -z "$RT" ] && echo 0 $RT $HOME/script-env/$tgt/env-shm-size.md
  #環境個別の設定を適用
  [ -z "$RT" ] || echo 1 $RT $HOME/script-env/$tgt/env-shm-size.md

done < <(ls -l $HOME/script-env | grep -P '^d' | awk '{print $9}' | grep -v docker-build-log)  | \
  grep -P '^0' | awk '{print $2}' | xargs -I@ ls @ 2>&1 | perl -CIO -pe 's/ \p{Hiragana}.*//g' | grep '^ls' | perl -pe 's/ls: //g' | xargs -I@ touch @
