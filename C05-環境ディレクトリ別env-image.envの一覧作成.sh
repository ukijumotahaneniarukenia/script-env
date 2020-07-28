#!/usr/bin/env bash

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

MD_FILE_NAME=env-image.env
OUTPUT_FILE_NAME=app-env-image-list.md

>$HOME/$ENV_REPO/$OUTPUT_FILE_NAME

while read tgt;do
  OS_NAME=$(echo $tgt | perl -pe 's;.*/;;g;' | perl -pe 's/^([a-z]+)-(.*)$/\1/g')
  DOCKERFILE_IMAGE_VERSION=$(echo $tgt | perl -pe 's;.*/;;g;' | perl -pe 's/^([a-z]+)-(.*)$/\2/g;s/((?:[0-9]+-){1,})(.*)/\1/;s/-$//;')

  if [ -s $tgt/$MD_FILE_NAME ];then
    {
        echo "[$(echo $tgt | perl -pe 's;.*/;;g')]($BASE_URL/$ENV_REPO/blob/master/$(echo $tgt | perl -pe 's;.*/;;g')/$MD_FILE_NAME)"
        cat $tgt/$MD_FILE_NAME | perl -pe 's/.*=//g'
    } | xargs
  else
    if [ "centos" == $OS_NAME ];then
      DOCKERFILE_IMAGE_VERSION=$(echo $DOCKERFILE_IMAGE_VERSION | perl -pe 's/-/\./;s/-/\./;s/-//;')
    fi

    if [ "ubuntu" == $OS_NAME ];then
      DOCKERFILE_IMAGE_VERSION=$(echo $DOCKERFILE_IMAGE_VERSION | perl -pe 's/-/\./;')
    fi
    echo "[$(echo $tgt | perl -pe 's;.*/;;g')]($BASE_URL/$ENV_REPO/blob/master/$(echo $tgt | perl -pe 's;.*/;;g')/$MD_FILE_NAME)" $DOCKERFILE_IMAGE_VERSION
  fi \
  | perl -pe 's/(?<=md\)) /|/;s/^/|/;s/$/|/'
done < <(find $HOME/$ENV_REPO -mindepth 1 -type d | grep -vP '\.git|docker-log|mnt') | sort | sed '1i|環境ディレクトリ名|ベースイメージ|' | sed '2i|:--|:-:|' >>$HOME/$ENV_REPO/$OUTPUT_FILE_NAME
