#!/usr/bin/env bash

docker images | awk '{print $1}' | grep -P '(?:-[0-9]+){1,}' | while read tgt;do \
  echo $tgt
  MKDTM=$(docker history --human=false $tgt | sort -rk2 | sed -r 's;\s{1,}; ;g;' | cut -d' ' -f2 | sed -n '2p')
  echo $MKDTM
done | xargs -n2 | grep "$(date "+%Y-%m-%d")" | column -t -s' '
