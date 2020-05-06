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
  echo $tgt | perl -pe 's;.*/;;' | grep -Po '(-[a-zA-Z]+){1,}' | tr '-' '\n'
done < <(find $HOME/$ENV_REPO -mindepth 1 -type d | grep -vP '\.git|docker-log') | sort | uniq | sed '/^$/d' | \
while read tgt;do
  echo  mkdir -p $HOME/$SKETCH_REPO/$tgt
  seq 1 | xargs -I@ printf "touch $HOME/$SKETCH_REPO/$tgt/%05g-%s-用途名-non-alias名-alias名.拡張子\n" @ $tgt
done
