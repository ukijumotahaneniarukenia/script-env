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
done < <(find $HOME/$ENV_REPO -mindepth 1 -type d | grep -vP '\.git|docker-log|mnt') | sort | uniq | \
  while read tgt;do
    find $HOME/$ENV_REPO -mindepth 1 -type d | grep -vP '\.git|docker-log|mnt' | sed 's;.*/;;' | grep -P "(?<=-)$tgt" | xargs -n3 | nl | \
      while read n {a..c};do
        #echo $tgt $n $(eval echo '$'{a..c}|xargs -n1;)
        eval echo '$'{a..c}|xargs -n1 >docker-build-$tgt-list-$(printf "%02d" $n);
      done
  done

ls docker-build*list* | grep -vP 'list$'
