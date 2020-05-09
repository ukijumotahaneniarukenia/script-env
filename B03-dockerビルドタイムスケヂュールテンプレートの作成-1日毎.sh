#!/usr/bin/env bash

template(){
  n=$1;shift;
  l=$1;shift;
  b=0;
  DD=$(printf "%02d" $(($n%31)))
  HH=$(printf "%02d" $(($(($n/31))+${b:-0})))
if [ $DD = '0' ];then
  cat <<EOS
10 $HH 31 * * $HOME/$ENV_REPO/docker-crontab-wrapper.sh 1 $l $SCRIPT_REPO
EOS
else
  cat <<EOS
10 $HH $DD * * $HOME/$ENV_REPO/docker-crontab-wrapper.sh 1 $l $SCRIPT_REPO
EOS
fi
}

usage(){
cat <<EOS
Usage:
  $0 script-env script-repo
EOS
exit 0
}

ENV_REPO=$1;shift
SCRIPT_REPO=$1;shift

[ -z $ENV_REPO ] && usage
[ -z $SCRIPT_REPO ] && usage

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

ls docker-build*list* | grep -vP 'list$' | nl | \
while read n l ;do
  template $n $l
done  | sort -k3 >docker-crontab-BY-ONE-DAY
