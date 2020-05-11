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

TGT_LOG_FILE=01-log

find $HOME/$ENV_REPO  -mindepth 1 -type d | grep -vP '\.git|docker-log|mnt' | \
  while read dir;do
    cd $dir
    if [ -f $TGT_LOG_FILE ] ;then
      tail -n-6 $TGT_LOG_FILE | \
        while read s;do
          echo $s | grep Successfully | awk '{print $3}'|awk '{if(length($1)==12){print "image-id";print $1}else{print "container-name";print $1}}';
          echo $s | grep -v Successfully|sed '/^$/d'|awk -v OFS='\n' '{print $1,$2}';
        done | xargs -n2 | sed -r 's/ +/\t/g' | awk -vOFS='\t' -vDIR=$(pwd|sed 's;.*/;;g') '{print DIR,$0}' >$TGT_LOG_FILE-done.tsv
        #クロス集計
        datamash -s crosstab 1,2 unique 3 <$TGT_LOG_FILE-done.tsv | sed '1s/\t/dir-name\t/' >$TGT_LOG_FILE-done-done.tsv
    else
      echo not-found
    fi
done

find $HOME/$ENV_REPO -type f -name "$TGT_LOG_FILE-done-done.tsv" | xargs -I@ cat @ | grep -vP '^dir' | sed '1idir-name\tcontainer-name\timage-id\treal\tsys\tuser' >$TGT_LOG_FILE-done-done-done.tsv

#列数そろえる
{
  cat $TGT_LOG_FILE-done-done-done.tsv | head -n1
  cat $TGT_LOG_FILE-done-done-done.tsv | tail -n+2 | ruby -anle 'p $F.push("\t"*(6-$F.length)).join("\t").gsub(/\t$/,"")' | xargs -I@ echo -e @
} >01-log-summury.tsv

#ok
{
  cat $TGT_LOG_FILE-done-done-done.tsv | head -n1
  cat 01-log-summury.tsv | tail -n+2 | awk '$2 ~ /(-[0-9]+)+/{print $0}'
} >01-log-summury-ok.tsv

#ng
{
  cat $TGT_LOG_FILE-done-done-done.tsv | head -n1
  cat 01-log-summury.tsv | tail -n+2 | awk '$2 !~ /(-[0-9]+)+/{print $0}'
} >01-log-summury-ng.tsv
