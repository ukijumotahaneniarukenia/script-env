#!/bin/bash

nonretry-pre-process(){
  exec 1>~/script-env/docker-build-log/docker-build-$(date +\%Y-\%m-\%d_\%H-\%M-\%S).stdout.log
  exec 2>~/script-env/docker-build-log/docker-build-$(date +\%Y-\%m-\%d_\%H-\%M-\%S).stderr.log
  #gitignore整備
  ls -l ~/script-env | grep -P '^d' | awk '{print $9}' | grep -v docker-build-log | xargs -I@ echo cp ~/script-env/.gitignore ~/script-env/@/.gitignore | sh
  #doc.md配備
  while read tgt;do
    echo cp ~/script-env/doc.md ~/script-env/$tgt/doc.md | sh
    echo "sed -i 's;XXX;$tgt;g' ~/script-env/$tgt/doc.md" | sh

    RT="$(echo "grep EXPOSE ~/script-env/$tgt/env.md" | sh 2>/dev/null)"
    [ -z "$RT" ] && printf "sed -i 's;EXPOSE;%s;' %s\n" "$(echo "grep EXPOSE ~/script-env/env.md" | sh | sed 's;.*=;;' | sort | uniq )" ~/script-env/$tgt/doc.md | sh
    [ -z "$RT" ] || printf "sed -i 's;EXPOSE;%s;' %s\n" "$(echo "grep EXPOSE ~/script-env/$tgt/env.md" | sh 2>/dev/null | sed 's;.*=;;' | sort | uniq)" ~/script-env/$tgt/doc.md | sh

    RT="$(echo "grep SHM_SIZE ~/script-env/$tgt/env.md" | sh 2>/dev/null)"
    [ -z "$RT" ] && printf "sed -i 's;SHM_SIZE;%s;' %s\n" "$(echo "grep SHM_SIZE ~/script-env/env.md" | sh | sed 's;.*=;;' | sort | uniq)" ~/script-env/$tgt/doc.md | sh
    [ -z "$RT" ] || printf "sed -i 's;SHM_SIZE;%s;' %s\n" "$(echo "grep SHM_SIZE ~/script-env/$tgt/env.md" | sh 2>/dev/null | sed 's;.*=;;' | sort | uniq)" ~/script-env/$tgt/doc.md | sh

    RT="$(echo "grep build-arg ~/script-env/$tgt/env.md" | sh 2>/dev/null)"
    [ -z "$RT" ] && printf "sed -i 's;BUILD_ARG;%s;' %s\n" "$(echo "grep build-arg ~/script-env/env.md" | sort | uniq | sh)" ~/script-env/$tgt/doc.md | sh
    [ -z "$RT" ] || printf "sed -i 's;BUILD_ARG;%s;' %s\n" "$(echo "grep build-arg ~/script-env/$tgt/env.md" | sort | uniq | sh 2>/dev/null)" ~/script-env/$tgt/doc.md | sh
  done < <(ls -l ~/script-env | grep -P '^d' | awk '{print $9}' | grep -v docker-build-log)
}

retry-pre-process(){
  exec 1>~/script-env/docker-build-log/docker-build-$(date +\%Y-\%m-\%d_\%H-\%M-\%S).stdout.retry.log
  exec 2>~/script-env/docker-build-log/docker-build-$(date +\%Y-\%m-\%d_\%H-\%M-\%S).stderr.retry.log
  #gitignore整備
  ls -l ~/script-env | grep -P '^d' | awk '{print $9}' | grep -v docker-build-log | xargs -I@ echo cp ~/script-env/.gitignore ~/script-env/@/.gitignore | sh
  #doc.md配備
  ls -l ~/script-env | grep -P '^d' | awk '{print $9}' | grep -v docker-build-log | xargs -I@ echo cp ~/script-env/doc.md ~/script-env/@/doc.md | sh
  ls -l ~/script-env | grep -P '^d' | awk '{print $9}' | grep -v docker-build-log | xargs -I@ echo "sed -i 's;XXX;@;g' ~/script-env/@/doc.md" | sh
}

post-process(){
  post-process-clean
}

post-process-clean(){
  #コンテナ起動に失敗したコンテナを削除
  docker ps -a | awk '{print $1,$2}' | tail -n+2 | grep -vE $(ls -l ~/script-env | grep -P '^d' | awk '{print $9}' | grep -v docker-build-log |xargs|tr ' ' '|') | awk '{print $1}' | xargs -I@ bash -c 'docker stop @ && docker rm @' 1>/dev/null 2>&1

  #コンテナ作成に失敗したdockerイメージを削除
  docker images | awk '$1=="<none>"{print $3}' | xargs -I@ docker rmi @ 1>/dev/null 2>&1

  #ディレクトリにないが、イメージとして作成されてしまっているものを削除（フォルダをリネームした場合とか。同期取るようにする。）
  docker images | awk '{print $1}' | grep -P '(?:centos|ubuntu)-' | grep -vE $(ls -l ~/script-env | grep -P '^d' | awk '{print $9}' | xargs | tr ' ' '|') | xargs docker rmi 1>/dev/null 2>&1

  #Exitedしたコンテナ削除
  docker ps -a | grep Exited | awk '{print $1}' | xargs -I@ docker rm @ 1>/dev/null 2>&1
}

post-process-logger(){
  local TGT_BUILD_IMAGE_EXPECT_CNT=$(ls -l ~/script-env | grep -P '^d' | grep -v docker-build-log | wc -l )
  local TGT_BUILD_IMAGE_ACTUAL_CNT=$(find ~/script-env -name "log" | grep -v config | xargs -I@ bash -c 'printf "%s " @ && date -r @' | sed -r 's;\s{1,}; ;g' | grep "$(date | awk '{print $1,$2,$3,$4}')" | wc -l )
  {
    echo "ビルド対象予定数は$TGT_BUILD_IMAGE_EXPECT_CNT件でした"; \
    echo "ビルド対象実績数は$TGT_BUILD_IMAGE_ACTUAL_CNT件でした"; \
  } >>~/script-env/docker-build-log/$BUILD_STDOUT_LOG

  local TGT_BUILD_IMAGE_DONE_NON_TODAY_CNT=$(docker images | grep -P '(?:-[0-9]){1,}' | grep -P '(?:[2-9][5-9])(?= hours ago)|(?:days|weeks|months)' | wc -l)
  {
    echo "作成済イメージの内、日付が本日以内でないものは$TGT_BUILD_IMAGE_DONE_NON_TODAY_CNT"件でした; \
    docker images | head -n1; \
    docker images | grep -P '(?:-[0-9]){1,}' | grep -P '(?:[2-9][5-9])(?= hours ago)|(?:days|weeks|months)'; \
  } >>~/script-env/docker-build-log/$BUILD_STDOUT_LOG

  local TGT_BUILD_IMAGE_DONE_TODAY_CNT=$(docker images | grep -P '(?:-[0-9]){1,}' | grep -vP '(?:[2-9][5-9])(?= hours ago)' | grep -vP 'days|weeks|months|years' | wc -l)
  {
    echo "作成済イメージの内、日付が本日以内であるものは$TGT_BUILD_IMAGE_DONE_TODAY_CNT"件でした; \
      docker images | grep -P '(?:-[0-9]){1,}' | grep -vP '(?:[2-9][5-9])(?= hours ago)' | grep -vP 'days|weeks|months|years'
  } >>~/script-env/docker-build-log/$BUILD_STDOUT_LOG

  local TGT_BUILD_IMAGE_NON_DONE_CNT=$(ls -l ~/script-env | grep -P '^d' | awk '{print $9}' | grep -v docker-build-log | grep -vE $(docker images | tail -n+1 | grep -P '(-[0-9]{1,}){2,}-' | awk '{print $1}'|xargs|tr ' ' '|') | wc -l)
  {
    echo "未作成イメージは$TGT_BUILD_IMAGE_NON_DONE_CNT件でした"; \
    ls -l ~/script-env | grep -P '^d' | awk '{print $9}' | grep -v docker-build-log | grep -vE $(docker images | tail -n+1 | grep -P '(-[0-9]{1,}){2,}-' | awk '{print $1}'|xargs|tr ' ' '|'); \
  } >>~/script-env/docker-build-log/$BUILD_STDOUT_LOG
}

nonretry(){
  #開始時刻控える
  local BUILD_START=$(date '+%s')

  #初回ビルド開始
  bash ~/script-env/docker-build-parallel.sh &

  #psコマンドで検索できるように少しまつ
  sleep 10

  printf "starting docker init build proccess.\n"
  printf "waiting for docker init build proccess done.\n"

  #docker buildプロセスがヒットしなくなるまで、まつ
  while $(ps aux | grep 'docker build' | grep -vq 'grep')
  do
    sleep 1
  done

  #終了時刻控える
  local BUILD_END=$(date '+%s')

  #すこし待った分差し引く
  local BUILD_ELAPSED=$(expr $BUILD_END - $BUILD_START - 10)

  printf "docker init build process has done.ending docker init build proccess.elapsed time[%s(seconds)]\n" $BUILD_ELAPSED
}

retry(){
  RETRY_MX_CNT="$@"

  for((RETRY_ROUND_CNT=1;RETRY_ROUND_CNT<=$RETRY_MX_CNT;RETRY_ROUND_CNT++));do

    #開始時刻控える
    local BUILD_START=$(date '+%s')

    printf "starting docker retry $(printf '%02g' $RETRY_ROUND_CNT) round build proccess.\n"
    printf "waiting for docker retry $(printf '%02g' $RETRY_ROUND_CNT) round all build proccess done.\n"

    #初回ビルドに失敗したイメージに関してはリカバリ時間を短縮するために、到達可能なStepまでのキャッシュを作成しておく
    #リトライログ用にRETRY_ROUND_CNTを引数に渡す
    bash ~/script-env/docker-build-parallel-retry.sh $(printf '%02g' $RETRY_ROUND_CNT) &

    #psコマンドで検索できるように少しまつ
    sleep 10

    #docker buildプロセスがヒットしなくなるまで、まつ
    while $(ps aux | grep 'docker build' | grep -vq 'grep')
    do
      sleep 1
    done

    #終了時刻控える
    local BUILD_END=$(date '+%s')

    #すこし待った分差し引く
    local BUILD_ELAPSED=$(expr $BUILD_END - $BUILD_START - 10)

    printf "docker retry $(printf '%02g' $RETRY_ROUND_CNT) round build process has done.ending docker retry $(printf '%02g' ${10#RETRY_ROUND_CNT}) round build proccess.elapsed time[%s(seconds)]\n" $BUILD_ELAPSED
  done
}

nonretry-pre-process-logger(){
  #その日の標準出力ログファイル名を取得
  BUILD_STDOUT_LOG=$(ls -l ~/script-env/docker-build-log | grep -P '^-' | awk '{print $9}' | grep "$(date +%Y-%m-%d)" | grep stdout)
  #その日の標準エラー出力ログファイル名を取得
  BUILD_STDERR_LOG=$(ls -l ~/script-env/docker-build-log | grep -P '^-' | awk '{print $9}' | grep "$(date +%Y-%m-%d)" | grep stderr)
}

retry-pre-process-logger(){
  #その日の標準出力ログファイル名を取得
  BUILD_STDOUT_LOG=$(ls -l ~/script-env/docker-build-log | grep -P '^-' | awk '{print $9}' | grep "$(date +%Y-%m-%d)" | grep -P 'stdout\.retry')
  #その日の標準エラー出力ログファイル名を取得
  BUILD_STDERR_LOG=$(ls -l ~/script-env/docker-build-log | grep -P '^-' | awk '{print $9}' | grep "$(date +%Y-%m-%d)" | grep -P 'stderr\.retry')
}

nonretry-logger-detail-stdout(){
  #各コンテナごとにその日の初回ビルド詳細ログを追記
  while read tgt;do
    local LAST_STEP="$(cat $tgt |grep -Po 'Step [0-9]{1,}/[0-9]{1,}' | tail -n1)" #Step数の抽出
    local ELAPSED_TIME="$(cat $tgt | grep -P '\s[0-9]{1,}m[0-9]{1,}\.[0-9]{3}s' | xargs;)" #経過時間の抽出
    local STEP_CNT=$(sed -r 's;Step\s{1,};;;s;(.*)/(.*);\2;' <<<"$LAST_STEP")
    local DONE_CNT=$(sed -r 's;Step\s{1,};;;s;(.*)/(.*);\1;' <<<"$LAST_STEP")
    {
      echo -ne $tgt; #対象コンテナを追記
      [ $STEP_CNT -eq $DONE_CNT ] && printf "\t%s\t%s\n" "$LAST_STEP" "$ELAPSED_TIME";
    } >>~/script-env/docker-build-log/$BUILD_STDOUT_LOG
  done < <(ls -l ~/script-env | grep -P '^d' | awk '{print $9}' | xargs -n1 -I@ echo ~/script-env/@/log | grep -v 'docker-build-log')
}

nonretry-logger-detail-stderr(){
  #各コンテナごとにその日の初回ビルド詳細ログを追記
  while read tgt;do
    local LAST_STEP="$(cat $tgt |grep -Po 'Step [0-9]{1,}/[0-9]{1,}' | tail -n1)" #Step数の抽出
    local ELAPSED_TIME="$(cat $tgt | grep -P '\s[0-9]{1,}m[0-9]{1,}\.[0-9]{3}s' | xargs;)" #経過時間の抽出
    local STEP_CNT=$(sed -r 's;Step\s{1,};;;s;(.*)/(.*);\2;' <<<"$LAST_STEP")
    local DONE_CNT=$(sed -r 's;Step\s{1,};;;s;(.*)/(.*);\1;' <<<"$LAST_STEP")
    {
      echo -ne $tgt; #対象コンテナを追記
      [ $STEP_CNT -eq $DONE_CNT ] || printf "\t%s\n" "$ELAPSED_TIME";
    } >>~/script-env/docker-build-log/$BUILD_STDERR_LOG
  done < <(ls -l ~/script-env | grep -P '^d' | awk '{print $9}' | xargs -n1 -I@ echo ~/script-env/@/log | grep -v 'docker-build-log')
}

retry-logger-detail-stdout(){
  #各コンテナごとにその日のリトライビルド詳細ログを追記
  while read tgt;do
    local LAST_STEP="$(cat $tgt |grep -Po 'Step [0-9]{1,}/[0-9]{1,}' | tail -n1)" #Step数の抽出
    local ELAPSED_TIME="$(cat $tgt | grep -P '\s[0-9]{1,}m[0-9]{1,}\.[0-9]{3}s' | xargs;)" #経過時間の抽出
    local STEP_CNT=$(sed -r 's;Step\s{1,};;;s;(.*)/(.*);\2;' <<<"$LAST_STEP")
    local DONE_CNT=$(sed -r 's;Step\s{1,};;;s;(.*)/(.*);\1;' <<<"$LAST_STEP")
    {
      echo -ne $tgt; #対象コンテナを追記
      [ $STEP_CNT -eq $DONE_CNT ] || printf "\t%s\n" "$ELAPSED_TIME";
      [ $STEP_CNT -eq $DONE_CNT ] && printf "\t%s\t%s\n" "$LAST_STEP" "$ELAPSED_TIME";
    } >>~/script-env/docker-build-log/$BUILD_STDOUT_LOG
  done < <(find ~/script-env -type f -name "*retry-*" | grep log | sort)
}

retry-logger-detail-stderr(){
  #各コンテナごとにその日のリトライビルド詳細ログを追記
  while read tgt;do
    local LAST_STEP="$(cat $tgt |grep -Po 'Step [0-9]{1,}/[0-9]{1,}' | tail -n1)" #Step数の抽出
    local ELAPSED_TIME="$(cat $tgt | grep -P '\s[0-9]{1,}m[0-9]{1,}\.[0-9]{3}s' | xargs;)" #経過時間の抽出
    local STEP_CNT=$(sed -r 's;Step\s{1,};;;s;(.*)/(.*);\2;' <<<"$LAST_STEP")
    local DONE_CNT=$(sed -r 's;Step\s{1,};;;s;(.*)/(.*);\1;' <<<"$LAST_STEP")
    {
      echo -ne $tgt; #対象コンテナを追記
      [[ $STEP_CNT -eq 0 ]] && [[ 0 -eq $DONE_CNT ]] && printf "\n";
      [ $STEP_CNT -eq $DONE_CNT ] || printf "\t%s\n" "$ELAPSED_TIME";
    } >>~/script-env/docker-build-log/$BUILD_STDERR_LOG
  done < <(find ~/script-env -type f -name "*retry-*" | grep log | sort)
}

nonretry-process(){
  nonretry-pre-process-logger
  nonretry
  nonretry-logger-detail-stdout
  nonretry-logger-detail-stderr
  post-process-logger
}

retry-process(){
  retry-pre-process-logger
  retry "$@"
  retry-logger-detail-stdout
  retry-logger-detail-stderr
  post-process-logger
}

main(){
  [ -z "$@" ] && nonretry-pre-process
  [ -z "$@" ] && nonretry-process

  [ -z "$@" ] || retry-pre-process "$@"
  [ -z "$@" ] || retry-process "$@"
  post-process
}

#retry回数を引数に受け取る
main "$@"
