#!/bin/bash

while read tgt;do
  #echo $tgt | xargs -I@ bash -c "yes @| head -n$(echo $tgt | grep -oP '(-[a-zA-Z]{1,})' | wc -l)"
  #echo $tgt | grep -oP '(-[a-zA-Z]{1,})'
  #echo $tgt | awk '{b=split($0,a,"-[a-zA-Z]+")-1;print $0,b}'| xargs -I@ bash -c "yes @| head -n$(echo $tgt | grep -oP '(-[a-zA-Z]{1,})' | wc -l)"
  paste -d' ' <(echo $tgt | xargs -I@ bash -c "yes @| head -n$(echo $tgt | grep -oP '(-[a-zA-Z]{1,})' | wc -l)") \
    <(echo $tgt | grep -oP '(-[a-zA-Z]{1,})'|awk '{print NR,substr($0,2,length($0))}') \
    <(echo $tgt | awk '{b=split($0,a,"-[a-zA-Z]+")-1;print b}'| xargs -I@ bash -c "yes @| head -n$(echo $tgt | grep -oP '(-[a-zA-Z]{1,})' | wc -l)") | \
  sed -r 's;^|$| ;|;g'
done < <(ls -l $HOME/script-env-regression-test | grep -P '^d' | awk '{print $9}' | grep -vP 'docker-log' | grep -P '(-[a-zA-Z]+)') | \
sed '1i|環境ディレクトリ名|GRPSEQ|コンテキスト名|GRPCNT|' | \
sed '2i|:-:|:-:|:-:|:-:|' >md-env-list.md
