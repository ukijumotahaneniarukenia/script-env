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

  DOCKERFILE_IMAGE_VERSION=$(echo $OS_VERSION | perl -pe 's/^([a-z]+)-(.*)$/\2/g')

  if [ "centos" == $OS_NAME ];then
    DOCKERFILE_IMAGE_VERSION=$(echo $DOCKERFILE_IMAGE_VERSION | perl -pe 's/-/\./;s/-/\./;s/-//;')
  fi

  if [ "ubuntu" == $OS_NAME ];then
    DOCKERFILE_IMAGE_VERSION=$(echo $DOCKERFILE_IMAGE_VERSION | perl -pe 's/-/\./;')
  fi

  while read tgt;do
    #テンプレートファイルのDOCKERFILE_ARGの置換
    cat $tgt/env-build-arg.env  | sed 's/=.*//;s/^/ARG /;' >/tmp/env-build-arg-$(echo $tgt | perl -pe 's;/;-;g')
    cmd=$(echo "sed -i '/DOCKERFILE_ARG/r /tmp/env-build-arg-$(echo $tgt | perl -pe 's;/;-;g')' $tgt/Dockerfile.auto")
    if [ "$SHELL" = 'bash' ];then
      echo $cmd | $SHELL
    else
      echo $cmd
    fi

    cmd=$(echo "sed -i '/DOCKERFILE_ARG/d' $tgt/Dockerfile.auto")
    if [ "$SHELL" = 'bash' ];then
      echo $cmd | $SHELL
    else
      echo $cmd
    fi

  done < <(find $HOME/$ENV_REPO -type d | grep -v docker-log | grep $OS_VERSION | grep -vP mnt)

  #後処理
  rm -rf /tmp/env-build-arg*
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
