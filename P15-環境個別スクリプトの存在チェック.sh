#!/usr/bin/env bash

NORMAL=$(tput sgr0)
FG_GREEN=$(tput setaf 2)
FG_YELLOW=$(tput setaf 3)
FG_CYAN=$(tput setaf 6)
FG_WHITE=$(tput setaf 7)

fg_green(){
  echo -ne "${FG_GREEN}$*${NORMAL}"
}

fg_yellow(){
  echo -ne "${FG_YELLOW}$*${NORMAL}"
}

fg_cyan(){
  echo -ne "${FG_CYAN}$*${NORMAL}"
}

fg_white(){
  echo -ne "${FG_WHITE}$*${NORMAL}"
}

usage(){
cat <<EOS
Usage:
  $0 script-env script-repo
EOS
exit 0
}

DEFAULT_INSTALLER_REPO=script-repo

ENV_REPO=$1;shift
INSTALLER_REPO=$1;shift

[ -z "$ENV_REPO" ] && usage

if [ -z "$INSTALLER_REPO" ]; then
  :
else
  DEFAULT_INSTALLER_REPO=$INSTALLER_REPO
fi

while read dir;do

  #前処理
  cat <<EOS >$dir/b
  $(cat $dir/Dockerfile | grep -P "$(cat $dir/env-build-arg.env | awk -v FS='=' '{print $1}'|xargs|tr ' ' '|')" | grep -v ARG | grep -Po '(?<=bash ).*sh')
EOS

  OS_VERSION=$(echo $dir | grep -Po '[a-z]+(-[0-9]{1,}){1,}')

  #中間処理
  cat $dir/env-build-arg.env | awk -v FS='=' '{print $1,$2}' | \
    while read k v;do
      sed -i "s/\$$k/$v/g" $dir/b
    done
  sed -i "s/\$OS_VERSION/$OS_VERSION/g" $dir/b

  #メイン処理
  cat $dir/b | while read f;do
    [ -z $f ] && continue
    if [ -f $HOME/$DEFAULT_INSTALLER_REPO/$f ];then
      :
    else
      fg_yellow $f $(fg_white USED) $(fg_cyan $dir) $(fg_white DO NOT REGISTER) $(fg_green $HOME/$DEFAULT_INSTALLER_REPO)
      echo
    fi
  done

  ##TODO 他OSからリネームしてコピーし登録する処理を別スクリプトに切り出して追加

  #後処理
  rm -f $dir/b
done < <(find $HOME/$ENV_REPO  -mindepth 1 -type d | grep -vP 'docker-log|\.git|mnt')
