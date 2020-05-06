#!/usr/bin/env bash

usage(){
cat <<EOS
Usage:
  $0 script-env
EOS
exit 0
}

ENV_REPO=$1;shift

[ -z $ENV_REPO ] && usage

while read tgt;do
  echo "cd $tgt && uniq Dockerfile>Dockerfile.$$" | bash
  echo "cd $tgt && mv Dockerfile.$$ Dockerfile" | bash
done < <(find $HOME/$ENV_REPO -mindepth 1 -type d | grep -vP '\.git|docker-log|mnt')
