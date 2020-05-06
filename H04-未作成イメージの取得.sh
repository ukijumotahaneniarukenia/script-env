#!/usr/bin/env bash

usage(){
cat <<EOS
Usage:
  $0 script-env
EOS
exit 0
}

ENV_REPO=$1;shift

[ -z $ENV_REPO ] && usage

ls -l $HOME/$ENV_REPO | grep -P '^d' | awk '{print $9}' | grep -v docker-log | \
  grep -vP "$(docker images | awk '{print $1}' | grep -P '(?:-[0-9]){1,}' | xargs -I@ bash -c "echo @ && docker history --human=false @ | sort -rk2 | sed -r 's;\s{1,}; ;g;' | cut -d' ' -f2 | sed -n '2p'" | xargs -n2 | grep -v "$(date "+%Y-%m-%d")" | cut -d' ' -f1|xargs|tr ' ' '|')" | \
  grep -vP "$(docker images | awk '{print $1}' | grep -P '(?:-[0-9]){1,}' | xargs -I@ bash -c "echo @ && docker history --human=false @ | sort -rk2 | sed -r 's;\s{1,}; ;g;' | cut -d' ' -f2 | sed -n '2p'" | xargs -n2 | grep "$(date "+%Y-%m-%d")" | cut -d' ' -f1|xargs|tr ' ' '|')"
