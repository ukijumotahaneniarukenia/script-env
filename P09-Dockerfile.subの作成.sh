#!/usr/bin/env bash

usage(){
  cat <<EOS
Usage:
  $0 script-env
EOS
exit 0
}

execute(){

  OS_VERSION=$1;shift

  [ -z $OS_VERSION ] && usage

  #テンプレート生成したDockerfileと既存Dockerfileのうち既存にしかないものを抽出
  while read tgt;do
    if [ -f $tgt/Dockerfile.sub.done ];then
      #Dockerfile.sub.doneが存在する場合はDockerfile.subを作成しない
      : #echo 1 $tgt
    elif [ -f $tgt/Dockerfile.sub.undone ];then
      #Dockerfile.sub.undoneが存在する場合は着手したが完了していない状態なので、Dockerfile.subを作成しない。
      : #echo 1 $tgt
    else
      #echo 0 $tgt
      echo "cd  $tgt && comm -23 --nocheck-order <(sort Dockerfile | sed -r '/^$/d') <(sort Dockerfile.auto | sed -r '/^$/d')>Dockerfile.sub"
    fi
  done < <(find $HOME/$REPO -type d | grep -v docker-log | grep $OS_VERSION) | bash
}

main(){
  REPO="$@"
  [ -z $REPO ] && usage
  export -f execute
  find $HOME/$REPO -type d | grep -Po '[a-z]+(-[0-9]{1,}){1,}' | sort | uniq | while read tgt;do execute $tgt;done
}

main "$@"
