#!/bin/bash

#普通はMakefileとかなんとかymlファイルとか使うんかな？？よくわからん。

pre-process(){
  exec 1>~/script_env/docker-build-log/docker-build-$(date +\%Y-\%m-\%d_\%H-\%M-\%S).stdout.log
  exec 2>~/script_env/docker-build-log/docker-build-$(date +\%Y-\%m-\%d_\%H-\%M-\%S).stderr.log
  #gitignore整備
  ls -l ~/script_env | grep -P '^d' | awk '{print $9}' | grep -v docker-build-log | xargs -I@ echo cp ~/script_env/.gitignore ~/script_env/@/.gitignore | sh
  #doc.md配備
  ls -l ~/script_env | grep -P '^d' | awk '{print $9}' | grep -v docker-build-log | xargs -I@ echo cp ~/script_env/doc.md ~/script_env/@/doc.md | sh
  ls -l ~/script_env | grep -P '^d' | awk '{print $9}' | grep -v docker-build-log | xargs -I@ echo "sed -i 's;XXX;@;g' ~/script_env/@/doc.md" | sh
}

post-process(){
  post-process-clean
  post-process-summary
}

post-process-clean(){
  #コンテナ起動に失敗したコンテナを削除
  docker ps -a | awk '{print $1,$2}' | tail -n+2 | grep -vE $(ls -l ~/script_env | grep -P '^d' | awk '{print $9}' | grep -v docker-build-log |xargs|tr ' ' '|') | awk '{print $1}' | xargs -I@ bash -c 'docker stop @ && docker rm @' 1>/dev/null 2>&1

  #コンテナ作成に失敗したdockerイメージを削除
  docker images | awk '$1=="<none>"{print $3}' | xargs -I@ docker rmi @ 1>/dev/null 2>&1

  #ディレクトリにないが、イメージとして作成されてしまっているものを削除（フォルダをリネームした場合とか。同期取るようにする。）
  docker images | awk '{print $1}' | grep -P '(?:centos|ubuntu)-' | grep -vE $(ls -l ~/script_env | grep -P '^d' | awk '{print $9}' | xargs | tr ' ' '|') | xargs docker rmi 1>/dev/null 2>&1

  #Exitedしたコンテナ削除
  docker ps -a | grep Exited | awk '{print $1}' | xargs -I@ docker rm @ 1>/dev/null 2>&1
}

post-process-summary(){
  TGT_BUILD_IMAGE_EXPECT_CNT=$(ls -l ~/script_env | grep -P '^d' | grep -v docker-build-log | wc -l )
  TGT_BUILD_IMAGE_ACTUAL_CNT=$(find ~/script_env -name "log" | grep -v config | xargs -I@ bash -c 'printf "%s " @ && date -r @' | sed -r 's;\s{1,}; ;g' | grep "$(date | awk '{print $1,$2,$3,$4}')" | wc -l )
  {
    echo "ビルド対象予定数は$TGT_BUILD_IMAGE_EXPECT_CNT件でした"; \
    echo "ビルド対象実績数は$TGT_BUILD_IMAGE_ACTUAL_CNT件でした"; \
  } >>~/script_env/docker-build-log/$BUILD_STDOUT_LOG

  {
    echo 'イメージは作成されていたが、日付が本日以内でないもの'; \
    docker images | head -n1; \
    docker images | grep -P '(?:-[0-9]){1,}' | grep -P 'days|weeks|months|years'; \
    docker images | grep -P '(?:-[0-9]){1,}' | grep -P 'hours' | awk '$4 !~ /[2-9][5-9]/ {print}'; \
  } >>~/script_env/docker-build-log/$BUILD_STDOUT_LOG

  {
    echo 'イメージは作成されていたが、日付が本日以内であるもの'; \
    docker images | grep -P '(?:-[0-9]){1,}' | grep -P 'hours' | awk '$4 !~ /[2-9][5-9]/ {print}'; \
  } >>~/script_env/docker-build-log/$BUILD_STDOUT_LOG

  {
    echo 'dockerイメージ作成されていない'; \
    ls -l ~/script_env | grep -P '^d' | awk '{print $9}' | grep -vE $(docker images | tail -n+1 | grep -P '(-[0-9]{1,}){2,}-' | awk '{print $1}'|xargs|tr ' ' '|'); \
  } >>~/script_env/docker-build-log/$BUILD_STDOUT_LOG

}

non-retry(){
  #開始時刻控える
  BUILD_START=$(date '+%s')

  #初回ビルド開始
  bash ~/script_env/docker-build-parallel.sh &

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
  BUILD_END=$(date '+%s')

  #すこし待った分差し引く
  BUILD_ELAPSED=$(expr $BUILD_END - $BUILD_START - 10)

  printf "docker init build process has done.ending docker init build proccess.elapsed time[%s(seconds)]\n" $BUILD_ELAPSED
}

retry(){
  RETRY_MX_CNT="$@"
  for ((RETRY_ROUND_CNT=1;RETRY_ROUND_CNT<=$RETRY_MX_CNT;RETRY_ROUND_CNT++));do

    BUILD_START=$(date '+%s')

    printf "starting docker retry $(printf '%02g' $RETRY_ROUND_CNT) round build proccess.\n"
    printf "waiting for docker retry $(printf '%02g' $RETRY_ROUND_CNT) round all build proccess done.\n"

    #初回ビルドに失敗したイメージに関してはリカバリ時間を短縮するために、到達可能なStepまでのキャッシュを作成しておく
    #リトライログ用にRETRY_ROUND_CNTを引数に渡す
    bash ~/script_env/docker-build-parallel-retry.sh $(printf '%02g' $RETRY_ROUND_CNT) &

    #psコマンドで検索できるように少しまつ
    sleep 10

    #docker buildプロセスがヒットしなくなるまで、まつ
    while $(ps aux | grep 'docker build' | grep -vq 'grep')
    do
      sleep 1
    done

    BUILD_END=$(date '+%s')

    #すこし待った分差し引く
    BUILD_ELAPSED=$(expr $BUILD_END - $BUILD_START - 10)

    printf "docker retry $(printf '%02g' $RETRY_ROUND_CNT) round build process has done.ending docker retry $(printf '%02g' $RETRY_ROUND_CNT) round build proccess.elapsed time[%s(seconds)]\n" $BUILD_ELAPSED
  done
}

pre-process-logger(){
  #その日の標準出力ログファイル名を取得
  BUILD_STDOUT_LOG=$(ls -l ~/script_env/docker-build-log | grep -P '^-' | awk '{print $9}' | grep "$(date +%Y-%m-%d)" | grep stdout)
  #その日の標準エラー出力ログファイル名を取得
  BUILD_STDERR_LOG=$(ls -l ~/script_env/docker-build-log | grep -P '^-' | awk '{print $9}' | grep "$(date +%Y-%m-%d)" | grep stderr)
}

non-retry-logger-stdout(){

  pre-process-logger

  #各コンテナごとにその日の初回ビルド詳細ログを追記
  while read tgt;do
    echo $tgt >>~/script_env/docker-build-log/$BUILD_STDOUT_LOG #対象コンテナを追記
    cat $tgt | grep -Po 'Step [0-9]{1,}/[0-9]{1,}' | tail -n1 >>~/script_env/docker-build-log/$BUILD_STDOUT_LOG #Step数の抽出
    cat $tgt | grep -E '\s[0-9]{1,}m[0-9]{1,}\.[0-9]{3}s' | xargs  >>~/script_env/docker-build-log/$BUILD_STDOUT_LOG  #経過時間の抽出
  done < <(ls -l ~/script_env | grep -P '^d' | awk '{print $9}' | xargs -n1 -I@ echo ~/script_env/@/log | grep -v 'docker-build-log')

  ##作成されたコンテナイメージを追記
  echo SUCCESS DOCKER BUILD IMAGE >>~/script_env/docker-build-log/$BUILD_STDOUT_LOG
  docker images | head -n1 >>~/script_env/docker-build-log/$BUILD_STDOUT_LOG
  ls -l ~/script_env | grep -P '^d' | grep -v docker-build-log | awk '{print $9}' | grep -E $(docker images | tail -n+1 | grep -P '(-[0-9]{1,}){2,}-' | awk '{print $1}'|xargs|tr ' ' '|')>>~/script_env/docker-build-log/$BUILD_STDOUT_LOG
}

non-retry-logger-stderr(){

  pre-process-logger

  #各コンテナごとにその日の初回ビルド詳細ログを追記
  while read tgt;do
    echo $tgt >>~/script_env/docker-build-log/$BUILD_STDERR_LOG #対象コンテナを追記
    cat $tgt | grep -Po 'Step [0-9]{1,}/[0-9]{1,}' | tail -n1 >>~/script_env/docker-build-log/$BUILD_STDERR_LOG #Step数の抽出
    cat $tgt | grep -E '\s[0-9]{1,}m[0-9]{1,}\.[0-9]{3}s' | xargs >>~/script_env/docker-build-log/$BUILD_STDERR_LOG  #経過時間の抽出
  done < <(ls -l ~/script_env | grep -P '^d' | awk '{print $9}' | xargs -n1 -I@ echo ~/script_env/@/log | grep -v 'docker-build-log')

  #作成されなかったコンテナイメージを追記
  echo FAIL DOCKER BUILD IMAGE >>~/script_env/docker-build-log/$BUILD_STDERR_LOG
  ls -l ~/script_env | grep -P '^d' | grep -v docker-build-log | awk '{print $9}' | grep -vE $(docker images | tail -n+1 | grep -P '(-[0-9]{1,}){2,}-' | awk '{print $1}'|xargs|tr ' ' '|')>>~/script_env/docker-build-log/$BUILD_STDERR_LOG

}

retry-logger-stdout(){

  pre-process-logger

  #各コンテナごとにその日のリトライビルド詳細ログを追記
  while read tgt;do
    echo $tgt >>~/script_env/docker-build-log/$BUILD_STDOUT_LOG #対象コンテナを追記
    cat $tgt | grep -Po 'Step [0-9]{1,}/[0-9]{1,}' | tail -n1 >>~/script_env/docker-build-log/$BUILD_STDOUT_LOG #Step数の抽出
    cat $tgt | grep -E '\s[0-9]{1,}m[0-9]{1,}\.[0-9]{3}s' | xargs  >>~/script_env/docker-build-log/$BUILD_STDOUT_LOG  #経過時間の抽出
  done < <(find ~/script_env -type f -name "*retry*" | grep log | sort)

  ##作成されたコンテナイメージを追記
  echo SUCCESS DOCKER BUILD IMAGE >>~/script_env/docker-build-log/$BUILD_STDOUT_LOG
  docker images | head -n1 >>~/script_env/docker-build-log/$BUILD_STDOUT_LOG
  ls -l ~/script_env | grep -P '^d' | grep -v docker-build-log | awk '{print $9}' | grep -E $(docker images | tail -n+1 | grep -P '(-[0-9]{1,}){2,}-' | awk '{print $1}'|xargs|tr ' ' '|')>>~/script_env/docker-build-log/$BUILD_STDOUT_LOG
}

retry-logger-stderr(){

  pre-process-logger

  #各コンテナごとにその日のリトライビルド詳細ログを追記
  while read tgt;do
    echo $tgt >>~/script_env/docker-build-log/$BUILD_STDERR_LOG #対象コンテナを追記
    cat $tgt | grep -Po 'Step [0-9]{1,}/[0-9]{1,}' | tail -n1 >>~/script_env/docker-build-log/$BUILD_STDERR_LOG #Step数の抽出
    cat $tgt | grep -E '\s[0-9]{1,}m[0-9]{1,}\.[0-9]{3}s' | xargs  >>~/script_env/docker-build-log/$BUILD_STDERR_LOG  #経過時間の抽出
  done < <(find ~/script_env -type f -name "*retry*" | grep log | sort)

  #作成されなかったコンテナイメージを追記
  echo FAIL DOCKER BUILD IMAGE >>~/script_env/docker-build-log/$BUILD_STDERR_LOG
  ls -l ~/script_env | grep -P '^d' | grep -v docker-build-log | awk '{print $9}' | grep -vE $(docker images | tail -n+1 | grep -P '(-[0-9]{1,}){2,}-' | awk '{print $1}'|xargs|tr ' ' '|')>>~/script_env/docker-build-log/$BUILD_STDERR_LOG

}

non-retry-process(){
  non-retry
  pre-process-logger
  non-retry-logger-stdout
  non-retry-logger-stderr
}

retry-process(){
  retry
  pre-process-logger
  retry-logger-stdout
  retry-logger-stderr
}

main(){
  pre-process
  [ -z "$@" ] && non-retry-process
  [ -z "$@" ] || retry-process "$@"
  post-process
}

#retry回数を引数に受け取る
main "$@"
