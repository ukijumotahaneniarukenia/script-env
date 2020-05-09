#!/usr/bin/env bash

d=1 #21時始まりにしてみた

template(){
  n=$1;shift;
  l=$1;shift;
  MM=$(printf "%02d" $(($n%12)))
if [ $MM = '00' ];then
  cat <<EOS
10 00 $(printf "%02d" $d) 12 * $HOME/$ENV_REPO/docker-crontab-wrapper.sh 1 $l $SCRIPT_REPO
EOS
  if [[ $d -eq 32 ]];then
    d=1
  else
    d=$(($d+1))
  fi
else
  cat <<EOS
10 00 $(printf "%02d" $d) $MM * $HOME/$ENV_REPO/docker-crontab-wrapper.sh 1 $l $SCRIPT_REPO
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
done | sort -k4 >docker-crontab-BY-ONE-MONTH
