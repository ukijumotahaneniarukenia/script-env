#!/bin/bash

while read tgt;do

  echo cp ~/script-env/doc.md ~/script-env/$tgt/doc.md | sh
  echo "sed -i 's;XXX;$tgt;g' ~/script-env/$tgt/doc.md" | sh

  RT="$(echo "grep EXPOSE ~/script-env/$tgt/env.md" | sh 2>/dev/null)"
  [ -z "$RT" ] && printf "sed -i 's;EXPOSE;%s;' %s\n" "$(echo "grep EXPOSE ~/script-env/env.md" | sh | sed 's;.*=;;')" ~/script-env/$tgt/doc.md | sh
  [ -z "$RT" ] || printf "sed -i 's;EXPOSE;%s;' %s\n" "$(echo "grep EXPOSE ~/script-env/$tgt/env.md" | sh 2>/dev/null | sed 's;.*=;;')" ~/script-env/$tgt/doc.md | sh

  RT="$(echo "grep SHM_SIZE ~/script-env/$tgt/env.md" | sh 2>/dev/null)"
  [ -z "$RT" ] && printf "sed -i 's;SHM_SIZE;%s;' %s\n" "$(echo "grep SHM_SIZE ~/script-env/env.md" | sh | sed 's;.*=;;')" ~/script-env/$tgt/doc.md | sh
  [ -z "$RT" ] || printf "sed -i 's;SHM_SIZE;%s;' %s\n" "$(echo "grep SHM_SIZE ~/script-env/$tgt/env.md" | sh 2>/dev/null | sed 's;.*=;;')" ~/script-env/$tgt/doc.md | sh

done < <(ls -l ~/script-env | grep -P '^d' | awk '{print $9}' | grep -v docker-build-log)
