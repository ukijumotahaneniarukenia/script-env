#!/usr/bin/env bash

#ユーザーがrootを除いて複数に存在する場合のパッチ

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
    #最後に見つかったWORKDIR以外を削除
    cmd=$(grep -n -P  'WORKDIR' $tgt/Dockerfile.auto |cut -d' ' -f1|xargs|sed '/^$/d'|awk -v FS=' ' '{$NF="";print $0}' | xargs -I@ echo @ | perl -pe "s;:.*;;;s;^;sed -i ;;s;$;d $tgt/Dockerfile.auto;")
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
