#!/bin/bash

#ls -l $HOME/script-env | grep -P '^d' | awk '{print $9}' | grep -v docker-log | xargs -I@ echo mv $HOME/script-env/@/manual.md $HOME/script-env/@/md-man.md
#
#
#ls docker-build-crontab* | awk '{PRE=$1;gsub("docker-build-crontab","docker-crontab",$0);print "mv "PRE" "$0}'
#
#
#ls *md | grep -v README.md | sed 's/md-//' | awk '{PRE=$1;gsub("^","md-",$0);print "./21-一括置換対象確認.sh \x27"PRE"\x27 \x27"$0"\x27"}'
#
#
#
while read tgt;do
  #echo $tgt;
  while read n;do
    if [ -f $tgt/$n ];then
      echo "mv $tgt/$n  $tgt/md-$n" | bash
      echo "git rm $tgt/$n" | bash
    else
      :
    fi
  done < <(ls *md | grep -v README.md  | perl -pe 's/^md-//;')
done < <(find $HOME/script-env -mindepth 1 -type d | grep -vP '\.git|docker-log' )
