#!/bin/bash

while read tgt;do

  #doc.mdファイルを配備
  echo cp $HOME/script-env/doc.md $HOME/script-env/$tgt/doc.md | sh
  echo "sed -i 's;XXX;$tgt;g' $HOME/script-env/$tgt/doc.md" | sh

  RT="$(echo "grep EXPOSE $HOME/script-env/$tgt/env.md" | sh 2>/dev/null)"
  [ -z "$RT" ] && printf "sed -i 's;EXPOSE;%s;' %s\n" "$(echo "grep EXPOSE $HOME/script-env/env.md" | sh | sed 's;.*=;;' | sort | uniq )" $HOME/script-env/$tgt/doc.md | sh
  [ -z "$RT" ] || printf "sed -i 's;EXPOSE;%s;' %s\n" "$(echo "grep EXPOSE $HOME/script-env/$tgt/env.md" | sh 2>/dev/null | sed 's;.*=;;' | sort | uniq)" $HOME/script-env/$tgt/doc.md | sh

  RT="$(echo "grep SHM_SIZE $HOME/script-env/$tgt/env.md" | sh 2>/dev/null)"
  [ -z "$RT" ] && printf "sed -i 's;SHM_SIZE;%s;' %s\n" "$(echo "grep SHM_SIZE $HOME/script-env/env.md" | sh | sed 's;.*=;;' | sort | uniq)" $HOME/script-env/$tgt/doc.md | sh
  [ -z "$RT" ] || printf "sed -i 's;SHM_SIZE;%s;' %s\n" "$(echo "grep SHM_SIZE $HOME/script-env/$tgt/env.md" | sh 2>/dev/null | sed 's;.*=;;' | sort | uniq)" $HOME/script-env/$tgt/doc.md | sh

  RT="$(echo "grep build-arg $HOME/script-env/$tgt/env.md" | sh 2>/dev/null)"
  [ -z "$RT" ] && printf "sed -i 's;BUILD_ARG;%s;' %s\n" "$(echo "grep build-arg $HOME/script-env/env.md" | sort | uniq | sh)" $HOME/script-env/$tgt/doc.md | sh
  [ -z "$RT" ] || printf "sed -i 's;BUILD_ARG;%s;' %s\n" "$(echo "grep build-arg $HOME/script-env/$tgt/env.md" | sort | uniq | sh 2>/dev/null)" $HOME/script-env/$tgt/doc.md | sh

done < <(ls -l $HOME/script-env | grep -P '^d' | awk '{print $9}' | grep -v docker-build-log)
