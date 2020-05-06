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

find $HOME/$ENV_REPO -name "[0-9][0-9]-log" | while read tgt;do { echo $tgt;ls -l --time-style="+%Y-%m-%dT%H:%m:%S" $tgt | awk '{print $6}';} | xargs -n2;done | sort -rk2 | column -t -s' '
