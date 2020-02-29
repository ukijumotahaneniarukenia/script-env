#!/bin/bash

while read tgt;do

  #doc.mdファイルを配備
  echo cp $HOME/script-env/doc.md $HOME/script-env/$tgt/doc.md | sh
  echo "sed -i 's;XXX;$tgt;g' $HOME/script-env/$tgt/doc.md" | sh

  RT="$(echo "grep '' $HOME/script-env/$tgt/env-expose.md | xargs" | sh 2>/dev/null)"
  #デフォルト設定を適用
  [ -z "$RT" ] && printf "sed -i 's;EXPOSE;%s;' %s\n" "$(echo "grep EXPOSE $HOME/script-env/$tgt/env.md" | sh 2>/dev/null | sed 's;.*=;;' | sort | uniq)" $HOME/script-env/$tgt/doc.md | sh
  #環境個別の設定を適用
  [ -z "$RT" ] || printf "sed -i 's;EXPOSE;%s;' %s\n" "$RT" $HOME/script-env/$tgt/doc.md | sh

  RT="$(echo "grep '' $HOME/script-env/$tgt/env-shm-size.md" | sh 2>/dev/null)"
  #デフォルト設定を適用
  [ -z "$RT" ] && printf "sed -i 's;SHM_SIZE;%s;' %s\n" "$(echo "grep SHM_SIZE $HOME/script-env/env.md" | sh | sed 's;.*=;;' | sort | uniq)" $HOME/script-env/$tgt/doc.md | sh
  #環境個別の設定を適用
  [ -z "$RT" ] || printf "sed -i 's;SHM_SIZE;%s;' %s\n" "$(echo $RT | sed 's/SHM_SIZE=//g')" $HOME/script-env/$tgt/doc.md | sh

  RT="$(echo "grep '' $HOME/script-env/$tgt/env-build-arg.md | xargs" | sh 2>/dev/null)"
  #デフォルト設定を適用
  [ -z "$RT" ] && printf "sed -i 's;BUILD_ARG;%s;' %s\n" "$(echo "grep build-arg $HOME/script-env/env.md" | sort | uniq | sh)" $HOME/script-env/$tgt/doc.md | sh
  #環境個別の設定を適用
  [ -z "$RT" ] || printf "sed -i 's;BUILD_ARG;%s;' %s\n" "$(echo $RT | sed 's; ; --build-arg ;g;s;^;--build-arg ;')" $HOME/script-env/$tgt/doc.md | sh

done < <(ls -l $HOME/script-env | grep -P '^d' | awk '{print $9}' | grep -v docker-build-log)
