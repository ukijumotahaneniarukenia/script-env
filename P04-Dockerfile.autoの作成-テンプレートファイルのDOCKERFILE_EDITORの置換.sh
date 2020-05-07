#!/usr/bin/env bash

usage(){
cat <<EOS
Usage:
  $0 script-env
  or
  $0 script-env --debug
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

  TEMPLATE_FILE=$(find $HOME/$ENV_REPO -name "docker-template-Dockerfile-$OS_NAME")

  EDITOR_LIST="$(ls $HOME/script-env/env-editor-* | grep $OS_NAME | awk -v FS='-' -v OFS='-' '{$1="";$2="";$3="";$4="";print $0}' | sed -r 's/^-{1,}//g' | sort | uniq)"

  while read tgt;do

    #テンプレートファイルのDOCKERFILE_EDITORの置換
    for n in "$EDITOR_LIST";do
      #エディタが決まるまでは、ちとめんどい。
      cmd="$(echo "echo" $tgt "| grep -Po '("$(echo $n | tr ' ' '|')")$'")"
      EDITOR="$(echo $cmd | $SHELL)"
      if [ "$SHELL" = 'bash' ];then
        :
      else
        echo $EDITOR $cmd
      fi

      if [ -z "$EDITOR" ];then
        #echo 森鴎外いない
        #vimの場合またはenv-editor未定義かつ明示的にvimと環境ディレクトリに明記していない場合
        cmd=$(echo "sed -i '/DOCKERFILE_EDITOR/d' $tgt/Dockerfile.auto")
        if [ "$SHELL" = 'bash' ];then
          echo $cmd | $SHELL
        else
          echo $cmd
        fi
      else
        #echo 森鴎外
        #env-editor定義の環境ディレクトリの場合
        cmd=$(echo "sed -i '/DOCKERFILE_EDITOR/r $(find $HOME/$ENV_REPO -maxdepth 1 -type f -name "env-editor*" | grep $OS_NAME | grep -P "$EDITOR$")' $tgt/Dockerfile.auto")
        if [ "$SHELL" = 'bash' ];then
          echo $cmd | $SHELL
        else
          echo $cmd
        fi
      fi

      #あればあとしまつ
      cmd=$(echo "sed -i '/DOCKERFILE_EDITOR/d' $tgt/Dockerfile.auto")
      if [ "$SHELL" = 'bash' ];then
        echo $cmd | $SHELL
      else
        echo $cmd
      fi
    done

  done < <(find $HOME/$ENV_REPO -type d | grep -v docker-log | grep $OS_VERSION | grep -vP mnt)

}

main(){
  ENV_REPO=$1;shift
  DEBUG=$1;shift

  if [ "$DEBUG" = '--debug' ];then
    SHELL=: #なんもしない
  else
    SHELL=bash #じっこうする
  fi

  [ -z $ENV_REPO ] && usage

  export -f execute
  find $HOME/$ENV_REPO -mindepth 1 -type d | grep -vP '\.git|docker-log|mnt' | grep -Po '[a-z]+(-[0-9]{1,}){1,}' | sort | uniq | while read tgt;do execute $tgt ;done
}

main "$@"
