#!/bin/bash

pre-process(){
  exec 1>~/script-env/docker-build-log/docker-build-$(date +\%Y-\%m-\%d_\%H-\%M-\%S).stdout.non-retry.log
  exec 2>~/script-env/docker-build-log/docker-build-$(date +\%Y-\%m-\%d_\%H-\%M-\%S).stderr.non-retry.log
}

post-process(){
  clean
  logger
}

clean(){
  #コンテナ起動に失敗したコンテナを削除
  docker ps -a | awk '{print $1,$2}' | tail -n+2 | grep -vE $(ls -l ~/script-env | grep -P '^d' | awk '{print $9}' | grep -v docker-build-log |xargs|tr ' ' '|') | awk '{print $1}' | xargs -I@ bash -c 'docker stop @ && docker rm @' 1>/dev/null 2>&1

  #noneイメージを削除
  docker images | awk '$1=="<none>"{print $3}' | xargs -I@ docker rmi @ 1>/dev/null 2>&1

  #ディレクトリにないが、イメージとして作成されてしまっているものを削除（フォルダをリネームした場合とか。同期取るようにする。）
  docker images | awk '{print $1}' | grep -P '(?:centos|ubuntu)-' | grep -vE $(ls -l ~/script-env | grep -P '^d' | awk '{print $9}' | xargs | tr ' ' '|') | xargs docker rmi 1>/dev/null 2>&1

  #Exitedコンテナ削除
  docker ps -a | grep Exited | awk '{print $1}' | xargs -I@ docker rm @ 1>/dev/null 2>&1
}

logger(){
  #出力がうるさくなるので、出力しない
  #while read tgt;do
  #  local LAST_STEP="$(cat $tgt |grep -Po 'Step [0-9]{1,}/[0-9]{1,}' | tail -n1)" #Step数の抽出
  #  local ELAPSED_TIME="$(cat $tgt | grep -P '\s[0-9]{1,}m[0-9]{1,}\.[0-9]{3}s' | xargs;)" #経過時間の抽出
  #  local STEP_CNT=$(sed -r 's;Step\s{1,};;;s;(.*)/(.*);\2;' <<<"$LAST_STEP")
  #  local DONE_CNT=$(sed -r 's;Step\s{1,};;;s;(.*)/(.*);\1;' <<<"$LAST_STEP")
  #  {
  #    echo -ne $tgt #対象コンテナを追記
  #    [[ $STEP_CNT -eq 0 ]] && [[ 0 -eq $DONE_CNT ]] && printf "\n";#実行時エラーの場合は改行のみ挿入
  #    [ $STEP_CNT -eq $DONE_CNT ] || printf "\t%s\n" "$ELAPSED_TIME";#実行ステップ数と完了ステップ数が同じの場合経過時間とともに出力
  #  }
  #done < <(find ~/script-env -type f -name "*non-retry-*" | grep log | sort)

  local TGT_BUILD_IMAGE_EXPECT_CNT=$(ls -l ~/script-env | grep -P '^d' | awk '{print $9}' | grep -v docker-build-log | wc -l )
  local TGT_BUILD_IMAGE_EXPECT="$(ls -l ~/script-env | grep -P '^d' | awk '{print $9}' | grep -v docker-build-log )"
  local TGT_BUILD_IMAGE_ACTUAL_CNT=$(docker images | grep -P '(?:-[0-9]){1,}' | awk '{print $1}' | xargs -I@ bash -c "echo @ && docker history --human=false @ | sort -rk2 | sed -r 's;\s{1,}; ;g;' | cut -d' ' -f2 | sed -n '2p'" | xargs -n2 | grep "$(date "+%Y-%m-%d")" | wc -l)
  local TGT_BUILD_IMAGE_ACTUAL="$(docker images | grep -P '(?:-[0-9]){1,}' | awk '{print $1}' | xargs -I@ bash -c "echo @ && docker history --human=false @ | sort -rk2 | sed -r 's;\s{1,}; ;g;' | cut -d' ' -f2 | sed -n '2p'" | xargs -n2 | grep "$(date "+%Y-%m-%d")" | cut -d' ' -f1)"
  local TGT_BUILD_IMAGE_DONE_NON_TODAY_CNT=$(docker images | grep -P '(?:-[0-9]){1,}' | awk '{print $1}' | xargs -I@ bash -c "echo @ && docker history --human=false @ | sort -rk2 | sed -r 's;\s{1,}; ;g;' | cut -d' ' -f2 | sed -n '2p'" | xargs -n2 | grep -v "$(date "+%Y-%m-%d")" | wc -l)
  local TGT_BUILD_IMAGE_DONE_NON_TODAY="$(docker images | grep -P '(?:-[0-9]){1,}' | awk '{print $1}' | xargs -I@ bash -c "echo @ && docker history --human=false @ | sort -rk2 | sed -r 's;\s{1,}; ;g;' | cut -d' ' -f2 | sed -n '2p'" | xargs -n2 | grep -v "$(date "+%Y-%m-%d")" | cut -d' ' -f1)"
  local TGT_BUILD_IMAGE_DONE_TODAY_CNT=$(docker images | grep -P '(?:-[0-9]){1,}' | awk '{print $1}' | xargs -I@ bash -c "echo @ && docker history --human=false @ | sort -rk2 | sed -r 's;\s{1,}; ;g;' | cut -d' ' -f2 | sed -n '2p'" | xargs -n2 | grep "$(date "+%Y-%m-%d")" | wc -l)
  local TGT_BUILD_IMAGE_DONE_TODAY="$(docker images | grep -P '(?:-[0-9]){1,}' | awk '{print $1}' | xargs -I@ bash -c "echo @ && docker history --human=false @ | sort -rk2 | sed -r 's;\s{1,}; ;g;' | cut -d' ' -f2 | sed -n '2p'" | xargs -n2 | grep "$(date "+%Y-%m-%d")" | cut -d' ' -f1)"

  local TGT_BUILD_IMAGE_NON_DONE_CNT=$(echo "$TGT_BUILD_IMAGE_EXPECT" | grep -vP "$(echo "${TGT_BUILD_IMAGE_DONE_NON_TODAY:-UNKO}"|xargs|tr ' ' '|')" | grep -vP "$(echo "${TGT_BUILD_IMAGE_DONE_TODAY:-UNKO}"|xargs|tr ' ' '|')"|wc -l)

  echo "本日のビルド対象予定数は$TGT_BUILD_IMAGE_EXPECT_CNT件でした"
  echo "$TGT_BUILD_IMAGE_EXPECT"
  echo "本日のビルド対象実績数は$TGT_BUILD_IMAGE_ACTUAL_CNT件でした"
  echo "$TGT_BUILD_IMAGE_ACTUAL"
  echo "作成済イメージの内、日付が本日以内でないものは$TGT_BUILD_IMAGE_DONE_NON_TODAY_CNT"件でした
  echo "$TGT_BUILD_IMAGE_DONE_NON_TODAY"
  echo "作成済イメージの内、日付が本日以内であるものは$TGT_BUILD_IMAGE_DONE_TODAY_CNT"件でした
  echo "$TGT_BUILD_IMAGE_DONE_TODAY"
  echo "未作成イメージは$TGT_BUILD_IMAGE_NON_DONE_CNT件でした"
  echo "$TGT_BUILD_IMAGE_EXPECT" | grep -vP "$(echo "${TGT_BUILD_IMAGE_DONE_NON_TODAY:-UNKO}"|xargs|tr ' ' '|')" | grep -vP "$(echo "${TGT_BUILD_IMAGE_DONE_TODAY:-UNKO}"|xargs|tr ' ' '|')"
}

non-retry(){
  RETRY_MX_CNT="$@"

  for((RETRY_ROUND_CNT=1;RETRY_ROUND_CNT<=$RETRY_MX_CNT;RETRY_ROUND_CNT++));do

    #開始時刻控える
    local BUILD_START=$(date '+%s')

    printf "starting docker non-retry $(printf '%02g' $RETRY_ROUND_CNT) round build proccess.\n"
    printf "waiting for docker non-retry $(printf '%02g' $RETRY_ROUND_CNT) round all build proccess done.\n"

    #初回ビルドに失敗したイメージに関してはリカバリ時間を短縮するために、到達可能なStepまでのキャッシュを作成しておく
    #リトライログ用にRETRY_ROUND_CNTを引数に渡す
    bash ~/script-env/docker-build-parallel-non-retry.sh $(printf '%02g' $RETRY_ROUND_CNT) &

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

    printf "docker non-retry $(printf '%02g' $RETRY_ROUND_CNT) round build process has done.ending docker non-retry $(printf '%02g' $RETRY_ROUND_CNT) round build proccess.elapsed time[%s(seconds)]\n" $BUILD_ELAPSED
  done
}

main(){
  [ -z "$@" ] && exit 1
  pre-process
  [ -z "$@" ] || non-retry "$@"
  post-process
}

#retry回数を引数に受け取る
main 1
