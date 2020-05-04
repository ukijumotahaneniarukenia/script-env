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
  EDITOR=$1;shift

  [ -z $OS_VERSION ] && usage

  OS_NAME=$(echo $OS_VERSION | perl -pe 's/^([a-z]+)-(.*)$/\1/g')

  IMAGE_VERSION=$(echo $OS_VERSION | perl -pe 's/^([a-z]+)-(.*)$/\2/g')

  if [ "centos" == $OS_NAME ];then
    IMAGE_VERSION=$(echo $IMAGE_VERSION | perl -pe 's/-/\./;s/-/\./;s/-//;')
  fi

  if [ "ubuntu" == $OS_NAME ];then
    IMAGE_VERSION=$(echo $IMAGE_VERSION | perl -pe 's/-/\./;')
  fi

  TEMPLATE_FILE=$(find $HOME/$REPO -name "docker-template-Dockerfile-$OS_NAME")

  EDITOR_LIST="$(ls $HOME/script-env/env-editor-* | grep $OS_NAME | awk -v FS='-' -v OFS='-' '{$1="";$2="";$3="";$4="";print $0}' | sed -r 's/^-{1,}//g' | sort | uniq)"

  while read tgt;do

    #テンプレートファイルのDOCKERFILE_EDITORの置換
    for n in "$EDITOR_LIST";do
      #エディタが決まるまでは、ちとめんどい。
      EDITOR="$(echo "echo" $tgt "| grep -Po '("$(echo $n | tr ' ' '|')")$'" | bash)"
      if [ -z "$EDITOR" ];then
        #vimの場合またはenv-editor未定義かつ明示的にvimと環境ディレクトリに明記していない場合
        echo "sed -i '/DOCKERFILE_EDITOR/d' $tgt/Dockerfile.auto" #| bash
      else
        #env-editor定義の環境ディレクトリの場合
        echo "sed -i '/DOCKERFILE_EDITOR/r $(find $HOME/$REPO -maxdepth 1 -type f -name "env-editor*" | grep $OS_NAME | grep -P "$EDITOR$")' $tgt/Dockerfile.auto" #| bash
        echo "sed -i '/DOCKERFILE_EDITOR/d' $tgt/Dockerfile.auto" #| bash
      fi
    done

  done < <(find $HOME/$REPO -type d | grep -v docker-log | grep $OS_VERSION | grep -vP mnt | grep mysql)

  rm -rf /tmp/env-build-arg*
}

main(){
  REPO="$1";shift
  [ -z $REPO ] && usage

  bash P04-環境ディレクトリ内のmntディレクトリを削除する.sh $REPO | bash

  export -f execute
  find $HOME/$REPO -type d | grep -Po '[a-z]+(-[0-9]{1,}){1,}' | sort | uniq | while read tgt;do execute $tgt ;done
}

main "$@"
