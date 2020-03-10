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

#env-build-arg.mdにあってDockerfile.doneにないもの
  #echo  "$(grep VERSION $dir/env-build-arg.md) $(grep VERSION.sh $dir/Dockerfile.done)"

  #grep VERSION $dir/env-build-arg.md
  #grep VERSION.sh $dir/Dockerfile.done
while read dir;do
  echo $dir
  while read arg;do
    while read cmd;do
      echo "( export $arg ; echo $(echo $cmd | grep -Po '\$([A-Z_]+){1,}VERSION(?=.sh)') ;echo $cmd)"
    done < <(grep VERSION.sh $dir/Dockerfile.done)
  done < <(grep VERSION $dir/env-build-arg.md)
done < <(find $HOME/$REPO -mindepth 1 -type d | grep -vP '\.git|docker-log' )

#Dockerfile.doneにあってenv-build-arg.mdにないもの

#Dockerfile内のVERSIONを抽出した内容で置換


#repoからファイル抽出
#find $HOME/script-repo -type f | grep -vP '\.git|md$'
