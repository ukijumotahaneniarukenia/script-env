#!/usr/bin/env bash

#直前のプロセスが終了しないと後続起動しないから、ややこしくなった


#このスクリプトは１回のみ実行したいスクリプトを記載

#インプットメソッドサーバの自動起動設定rootユーザーで実行している
fcitx 1>$HOME/launch-fcitx.log 2>&1

#一定時間後1回だけ起動するスクリプト いけそうなんだけどな

function fook(){
  local limit_time=300
  #残り0秒になるまで常にスクリプトを実行を試みる
  while [[ 0 -le $limit_time ]]
  do
    if [[ $limit_time -eq 0 ]];then
      echo end
      break
    else
      echo $((--limit_time)) 1>/dev/null
      sleep 1
      bash /usr/local/src/script-repo/centos-7-6-18-10-install-ibm-db2-user.sh 1>$HOME/launch-db2-user-setup.log 2>&1
    fi
  done
}

function setup(){
  bash /var/db2_setup/lib/setup_db2_instance.sh 1>$HOME/launch-db2-setup.log 2>&1
}

export -f fook setup

#いけるとおもったけど、、いけた！
#同時起動
echo fook setup | xargs -n1 | xargs -t -I@ -P2 bash -c 'eval @'

#ログイン時のシェル設定
/usr/bin/env bash
