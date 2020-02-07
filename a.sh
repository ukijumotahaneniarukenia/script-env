#!/bin/bash

while read tgt;do

  echo cp ~/script_env/doc.md ~/script_env/$tgt/doc.md | sh
  echo "sed -i 's;XXX;$tgt;g' ~/script_env/$tgt/doc.md" | sh

  RT="$(echo "grep EXPOSE ~/script_env/$tgt/env.md" | sh 2>/dev/null)"
  [ -z "$RT" ] && printf "sed -i 's;EXPOSE;%s;' %s\n" "$(echo "grep EXPOSE ~/script_env/env.md" | sh | sed 's;.*=;;')" ~/script_env/$tgt/doc.md | sh
  [ -z "$RT" ] || printf "sed -i 's;EXPOSE;%s;' %s\n" "$(echo "grep EXPOSE ~/script_env/$tgt/env.md" | sh 2>/dev/null | sed 's;.*=;;')" ~/script_env/$tgt/doc.md | sh

  RT="$(echo "grep SHM_SIZE ~/script_env/$tgt/env.md" | sh 2>/dev/null)"
  [ -z "$RT" ] && printf "sed -i 's;SHM_SIZE;%s;' %s\n" "$(echo "grep SHM_SIZE ~/script_env/env.md" | sh | sed 's;.*=;;')" ~/script_env/$tgt/doc.md | sh
  [ -z "$RT" ] || printf "sed -i 's;SHM_SIZE;%s;' %s\n" "$(echo "grep SHM_SIZE ~/script_env/$tgt/env.md" | sh 2>/dev/null | sed 's;.*=;;')" ~/script_env/$tgt/doc.md | sh

done < <(ls -l ~/script_env | grep -P '^d' | awk '{print $9}' | grep -v docker-build-log)
