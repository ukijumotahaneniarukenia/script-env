#!/bin/bash

usage(){
cat <<EOS
Usage:
  $0 script-env
EOS
exit 0
}

BASE_URL="https://github.com/ukijumotahaneniarukenia"

ENV_REPO=$1;shift

[ -z $ENV_REPO ] && usage

>$HOME/$ENV_REPO/app-env-image-list.md

while read tgt;do
  OS_NAME=$(echo $tgt | perl -pe 's;.*/;;g;' | perl -pe 's/^([a-z]+)-(.*)$/\1/g')
  IMAGE_VERSION=$(echo $tgt | perl -pe 's;.*/;;g;' | perl -pe 's/^([a-z]+)-(.*)$/\2/g;s/((?:[0-9]+-){1,})(.*)/\1/;s/-$//;')

  if [ -s $tgt/env-image.md ];then
    {
        echo "[$(echo $tgt | perl -pe 's;.*/;;g')]($BASE_URL/$ENV_REPO/blob/master/$(echo $tgt | perl -pe 's;.*/;;g')/env-image.md)"
        cat $tgt/env-image.md | perl -pe 's/.*=//g'
    } | xargs
  else
    if [ "centos" == $OS_NAME ];then
      IMAGE_VERSION=$(echo $IMAGE_VERSION | perl -pe 's/-/\./;s/-/\./;s/-//;')
    fi

    if [ "ubuntu" == $OS_NAME ];then
      IMAGE_VERSION=$(echo $IMAGE_VERSION | perl -pe 's/-/\./;')
    fi
    echo "[$(echo $tgt | perl -pe 's;.*/;;g')]($BASE_URL/$ENV_REPO/blob/master/$(echo $tgt | perl -pe 's;.*/;;g')/env-image.md)" $IMAGE_VERSION
  fi \
  | perl -pe 's/(?<=md\)) /|/;s/^/|/;s/$/|/'
done < <(find $HOME/$ENV_REPO -mindepth 1 -type d | grep -vP '\.git|docker-log') | sort | sed '1i|環境ディレクトリ名|ベースイメージ|' | sed '2i|:--|:-:|' >>$HOME/$ENV_REPO/app-env-image-list.md
