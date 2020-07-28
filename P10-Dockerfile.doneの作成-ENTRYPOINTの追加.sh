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

  TEMPLATE_FILE=$(find $HOME/$ENV_REPO -name "docker-template-Dockerfile-$OS_NAME-entrypoint")

  while read tgt;do
    cat $TEMPLATE_FILE | sed "s/ENTRYPOINT_ARGS/$OS_NAME/" >>$tgt/Dockerfile.done
    echo >>$tgt/Dockerfile.done
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
