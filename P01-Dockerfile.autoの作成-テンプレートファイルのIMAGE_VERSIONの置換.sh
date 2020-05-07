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

  while read tgt;do
    #テンプレートファイルのIMAGE_VERSIONの置換
    if [ -f $tgt/env-image.md ];then
      RT="$(grep FROM $tgt/env-image.md)"
      if [ -z "$RT" ];then
        #環境個別のイメージファイルがない場合
        cmd=$(echo "sed 's;BASE_IMAGE;FROM $OS_NAME:$IMAGE_VERSION;' $TEMPLATE_FILE >$tgt/Dockerfile.auto")
        if [ "$SHELL" = 'bash' ];then
          echo $cmd | $SHELL
        else
          echo $cmd
        fi
      else
        #環境個別のイメージファイルがある場合
        cmd=$(echo "sed 's;BASE_IMAGE;$RT;' $TEMPLATE_FILE >$tgt/Dockerfile.auto")
        if [ "$SHELL" = 'bash' ];then
          echo $cmd | $SHELL
        else
          echo $cmd
        fi
      fi
    else
      #環境個別のイメージファイルがない場合
      :
    fi

    #後続処理にそなえて後処理
    cmd=$(echo "sed -i '/^USER/,/^EXPOSE/d' $tgt/Dockerfile.auto")
    if [ "$SHELL" = 'bash' ];then
      echo $cmd | $SHELL
    else
      echo $cmd
    fi

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
