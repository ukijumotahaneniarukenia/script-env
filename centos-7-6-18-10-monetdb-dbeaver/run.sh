#!/usr/bin/env bash

#このスクリプトは１回のみ実行したいスクリプトを記載

OS_NAME="$@"

if [ $OS_NAME = "ubuntu" ];then

  fcitx 1>$HOME/launch-fcitx.log 2>&1

else

  #fcitx 1>$HOME/launch-fcitx.log 2>&1

  ibus-daemon -drx
  /usr/libexec/mozc/mozc_server 1>$HOME/launch-mozc.log 2>&1 &

fi

#ログイン時のシェル設定
/usr/bin/env bash
