#!/bin/bash

docker images | awk '{print $1}' | grep -P '(?:-[0-9]+){1,}' | xargs -I@ bash -c "echo @ && docker history --human=false @ | sort -rk2 | sed -r 's;\s{1,}; ;g;' | cut -d' ' -f2 | sed -n '2p'" \
  | xargs -n2 \
  | grep -v "$(date "+%Y-%m-%d")" \
  #| cut -d' ' -f1

#docker images | awk '{print $1}'| grep -P '(?:-[0-9]){1,}'  | xargs -I@ bash -c "echo @ && docker history --human=false @ | sort -rk2 | sed -r 's;\s{1,}; ;g;' | cut -d' ' -f2 | sed -n '2p'" | xargs -n2 | grep -v "$(date "+%Y-%m-%d")" | cut -d' ' -f1
