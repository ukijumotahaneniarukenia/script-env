#!/bin/bash

usage(){
cat <<EOS
Usage:
  $0 ARG script-env script-repo
EOS
exit 0
}

CHK_WORD=$1;shift
ENV_REPO=$1;shift
INSTALLER_REPO=$1;shift

[ -z $CHK_WORD ] && usage
[ -z $ENV_REPO ] && usage
[ -z $INSTALLER_REPO ] && usage

while read tgt;do
  if [ -f $tgt/Dockerfile.sub ];then
    #Dockerfile.subが存在する場合、INSTALLER_REPOに存在するバージョンのでkey:valueペアを作成し、各環境ディレクトリのenv-build-arg.mdに追記
    KEY=$(grep $CHK_WORD $tgt/Dockerfile.sub | awk '{print $2}')
    WORD=$(grep $CHK_WORD $tgt/Dockerfile.sub | awk '{print $2}' | perl -pe 's/VERSION//' | perl -pe 's/_/-/g')
    while read f;do
      [ -z ${WORD} ] && continue
      if [[ ${f} =~ ${WORD,,}.* ]]; then
        {
          echo ${KEY}
          echo ${BASH_REMATCH[0]} | perl -pe 's/\.sh//g' | grep -Po '(-[0-9]+){1,}' | perl -pe 's/^-//'
        } | xargs -n2 | tr ' ' '='
      else
        :
      fi
    done < <(find $HOME/$INSTALLER_REPO -type f | grep -vP '\.git')
  else
    #何もしないsubファイルを作成してほしいい
    :
  fi
done < <(find $HOME/$ENV_REPO -mindepth 1 -type d | grep -vP '\.git|docker-log')
