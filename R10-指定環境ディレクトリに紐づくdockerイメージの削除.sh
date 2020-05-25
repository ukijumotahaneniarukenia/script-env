#!/usr/bin/env bash

usage(){
  cat <<EOS
Usage:
  $0 script-env
EOS
exit 0
}

ENV_REPO=$1
EXCULDE_ENV="centos-7-6-18-10-vim|ubuntu-16-04-vim|ubuntu-18-04-vim|ubuntu-19-10-vim"

[ -z $ENV_REPO ] && usage

docker images | grep -P "$(ls $HOME/$ENV_REPO | grep -P '(?:-[0-9]+)+' | grep -P 'centos|ubuntu' | grep -vP "$EXCULDE_ENV" |xargs|tr ' ' '|')" | awk '{print $3}' | xargs docker rmi
