#!/usr/bin/env bash
#このスクリプトは１回のみ実行したいスクリプトを記載

#インプットメソッドサーバの自動起動設定rootユーザーで実行している
fcitx 1>$HOME/launch-fcitx.log 2>&1

#ログイン時のシェル設定
/usr/bin/env bash
