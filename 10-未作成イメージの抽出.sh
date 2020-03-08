#!/bin/bash

ls -l $HOME/script-env | grep -P '^d' | awk '{print $9}' | grep -v docker-log | \
  grep -vP "$(docker images | grep -P '(?:-[0-9]){1,}' | awk '{print $1}' | xargs -I@ bash -c "echo @ && docker history --human=false @ | sort -rk2 | sed -r 's;\s{1,}; ;g;' | cut -d' ' -f2 | sed -n '2p'" | xargs -n2 | grep -v "$(date "+%Y-%m-%d")" | cut -d' ' -f1|xargs|tr ' ' '|')" | \
  grep -vP "$(docker images | grep -P '(?:-[0-9]){1,}' | awk '{print $1}' | xargs -I@ bash -c "echo @ && docker history --human=false @ | sort -rk2 | sed -r 's;\s{1,}; ;g;' | cut -d' ' -f2 | sed -n '2p'" | xargs -n2 | grep "$(date "+%Y-%m-%d")" | cut -d' ' -f1|xargs|tr ' ' '|')"
