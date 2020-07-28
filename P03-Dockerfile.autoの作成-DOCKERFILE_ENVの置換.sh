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

  while read tgt;do

    TMP_FILE=/tmp/$(echo $tgt/env-env.env | sed 's;/;-;g')

    cp $tgt/env-env.env $TMP_FILE

    sed -i 's/^/ENV /' $TMP_FILE

    #テンプレートファイルのDOCKERFILE_ENVの置換
    cmd=$(echo "sed -i '/DOCKERFILE_ENV/r /tmp$tgt/env-env.env' $tgt/Dockerfile.auto")
    if [ "$SHELL" = 'bash' ];then
      echo $cmd | $SHELL
    else
      echo $cmd
    fi

    cmd=$(echo "sed -i '/DOCKERFILE_ENV/d' $tgt/Dockerfile.auto")
    if [ "$SHELL" = 'bash' ];then
      echo $cmd | $SHELL
    else
      echo $cmd
    fi

    rm -f $TMP_FILE

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
