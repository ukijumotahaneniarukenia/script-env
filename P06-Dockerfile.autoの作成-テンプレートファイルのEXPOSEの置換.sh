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

  TEMPLATE_FILE=$(find $HOME/$ENV_REPO -name "docker-template-Dockerfile-$OS_NAME")

  while read tgt;do
    #テンプレートファイルのEXPOSEの置換
    {
      echo $tgt
      grep -c -P  '\-p' $tgt/env-expose.md
      grep -P  '\-p' $tgt/env-expose.md | awk -v ORS='' '{print ","$1$2}'
    } | xargs -n3 | \
    while read file cnt port;do
      for (( i=0;i<$cnt;i++));do
        cmd=$(echo "sed -n '/EXPOSE/p' $TEMPLATE_FILE | perl -pe "s/PORT/$(echo $port | cut -d',' -f$(($i+2))|sed -r 's/.*://')/g" >>$file/Dockerfile.auto")
        if [ "$SHELL" = 'bash' ];then
          echo $cmd | $SHELL
        else
          echo $cmd
        fi
      done
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
