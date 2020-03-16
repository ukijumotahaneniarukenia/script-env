#!/usr/bin/env bash

docker images | awk '{print $1}' | grep -P '(?:-[0-9]+){1,}' | while read tgt;do \
  echo $tgt
  docker history --human=false $tgt | sort -rk2 | sed -r 's;\s{1,}; ;g;' | cut -d' ' -f2 | sed -n '2p'
  date "+%Y-%m-%dT%H:%M:%S%:z"
done | xargs -n3 | column -t -s' '
