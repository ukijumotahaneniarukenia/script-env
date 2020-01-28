#!/bin/bash

#その日の標準出力ログファイル名を取得
BUILD_STDOUT_LOG=$(ls -l ~/script_env/docker-build-log | grep -P '^-' | awk '{print $9}' | grep "$(date +%Y-%m-%d)" | grep stdout)
#その日の標準エラー出力ログファイル名を取得
BUILD_STDERR_LOG=$(ls -l ~/script_env/docker-build-log | grep -P '^-' | awk '{print $9}' | grep "$(date +%Y-%m-%d)" | grep stderr)

#各コンテナごとにその日の初回ビルド詳細ログを追記
while read tgt;do
  echo $tgt >>~/script_env/docker-build-log/$BUILD_STDOUT_LOG #対象コンテナを追記
  echo $tgt >>~/script_env/docker-build-log/$BUILD_STDERR_LOG #対象コンテナを追記
  cat $tgt | grep -Po 'Step [0-9]{1,}/[0-9]{1,}' | tail -n1 >>~/script_env/docker-build-log/$BUILD_STDOUT_LOG #Step数の抽出
  cat $tgt | grep -E 'success|SUCCESS|Success' >>~/script_env/docker-build-log/$BUILD_STDOUT_LOG #正常終了ログの抽出
  cat $tgt | grep -E '\s[0-9]{1,}m[0-9]{1,}\.[0-9]{3}s' >>~/script_env/docker-build-log/$BUILD_STDOUT_LOG  #経過時間の抽出
  cat $tgt | grep -E 'fail|FAIL|Fail|unable to prepare context' >>~/script_env/docker-build-log/$BUILD_STDERR_LOG  #異常終了ログの抽出
done < <(ls -l ~/script_env | grep -P '^d' | awk '{print $9}' | xargs -n1 -I@ echo ~/script_env/@/log | grep -v 'docker-build-log')

#各コンテナごとにその日のリトライビルド詳細ログを追記
while read tgt;do
  echo $tgt >>~/script_env/docker-build-log/$BUILD_STDOUT_LOG #対象コンテナを追記
  echo $tgt >>~/script_env/docker-build-log/$BUILD_STDERR_LOG #対象コンテナを追記
  cat $tgt | grep -Po 'Step [0-9]{1,}/[0-9]{1,}' | tail -n1 >>~/script_env/docker-build-log/$BUILD_STDOUT_LOG #Step数の抽出
  cat $tgt | grep -E 'success|SUCCESS|Success' >>~/script_env/docker-build-log/$BUILD_STDOUT_LOG #正常終了ログの抽出
  cat $tgt | grep -E '\s[0-9]{1,}m[0-9]{1,}\.[0-9]{3}s' >>~/script_env/docker-build-log/$BUILD_STDOUT_LOG  #経過時間の抽出
  cat $tgt | grep -E 'fail|FAIL|Fail|unable to prepare context' >>~/script_env/docker-build-log/$BUILD_STDERR_LOG  #異常終了ログの抽出
done < <(find ~/script_env -type f -name "*retry*" | grep log | sort)

##作成されたコンテナイメージを追記
echo SUCCESS DOCKER BUILD IMAGE >>~/script_env/docker-build-log/$BUILD_STDOUT_LOG
docker images | head -n1 >>~/script_env/docker-build-log/$BUILD_STDOUT_LOG
ls -l ~/script_env | grep -P '^d' | awk '{print $9}' | grep -E $(docker images | tail -n+1 | grep -P '(-[0-9]{1,}){2,}-' | awk '{print $1}'|xargs|tr ' ' '|')>>~/script_env/docker-build-log/$BUILD_STDOUT_LOG

#作成されなかったコンテナイメージを追記
echo FAIL DOCKER BUILD IMAGE >>~/script_env/docker-build-log/$BUILD_STDERR_LOG
ls -l ~/script_env | grep -P '^d' | awk '{print $9}' | grep -vE $(docker images | tail -n+1 | grep -P '(-[0-9]{1,}){2,}-' | awk '{print $1}'|xargs|tr ' ' '|')>>~/script_env/docker-build-log/$BUILD_STDERR_LOG

#コンテナ作成に失敗したdockerイメージを削除
#後処理
docker images | awk '$1=="<none>"{print $3}' | xargs -I@ docker rmi @
