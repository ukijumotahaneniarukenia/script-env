#!/bin/bash

#perl使う予定
usage(){
  cat <<EOS
Usage:
  $0 script-repo
EOS
exit 0
}

REPO="$1";shift

[ -z $REPO ] && usage

while read dir;do

  if [ -f $dir/env-build-arg.md -a $dir/Dockerfile.done ];then
    {
      grep VERSION $dir/env-build-arg.md | sort | nl
      grep VERSION.sh $dir/Dockerfile.done | sort | nl
    } | awk -v dir=$dir '
    BEGIN{
      print dir
    }
    {
      key=$1
      $1=""
      a[key]=a[key]" "$0
      #print key,$0
    }
    END{
      for(e in a){
        print e,a[e]
      }
    }'
  else
    :
  fi
done < <(find $HOME/$REPO -mindepth 1 -type d | grep -vP '\.git|docker-log' )


#Dockerfile内のVERSIONを抽出した内容で置換


#repoからファイル抽出
#find $HOME/script-repo -type f | grep -vP '\.git|md$'
