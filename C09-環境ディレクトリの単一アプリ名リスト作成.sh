#!/usr/bin/env bash

usage(){
cat <<EOS
Usage:
  $0 script-env script-sketch
EOS
exit 0
}

ENV_REPO=$1;shift
SKETCH_REPO=$1;shift

[ -z $ENV_REPO ] && usage
[ -z $SKETCH_REPO ] && usage

while read tgt;do
  echo $tgt | perl -pe 's;.*/;;' | perl -nlE 's/(?:[a-z]+(?:-[0-9]{1,}){1,})(.*)/\1/ and say' | tr '-' '\n' | sed /^$/d
done < <(find $HOME/$ENV_REPO -mindepth 1 -type d | grep -vP '\.git|docker-log|mnt') | sort | uniq
