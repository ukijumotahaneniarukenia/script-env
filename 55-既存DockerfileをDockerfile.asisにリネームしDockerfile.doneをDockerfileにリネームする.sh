#!/usr/bin/env bash

usage(){
cat <<EOS
Usage:
  $0 script-env
EOS
exit 0
}

REPO=$1;shift

[ -z $REPO ] && usage

while read tgt;do
  if [ -f $tgt/Dockerfile.asis ];then
    #asisが存在する場合は元のDockerfileを履歴からたどる手間を増やすため、存在する場合なにもしない
    :
  else
    #asisが存在しない場合はリネーム
    echo "mv $tgt/Dockerfile $tgt/Dockerfile.asis"
  fi
  if [ -f $tgt/Dockerfile.done ];then
    #自動生成ファイルがある場合は、常にDockerfileに反映
    echo "mv $tgt/Dockerfile.done $tgt/Dockerfile"
  else
    :
  fi
done < <(find $HOME/$REPO -mindepth 1 -type d | grep -vP '\.git|docker-log')
