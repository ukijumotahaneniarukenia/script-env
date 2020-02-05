#!/bin/bash

while read tgt;do
  LAST_STEP="$(cat $tgt |grep -Po 'Step [0-9]{1,}/[0-9]{1,}' | tail -n1)" #Step数の抽出
  ELAPSED_TIME="$(cat $tgt | grep -P '\s[0-9]{1,}m[0-9]{1,}\.[0-9]{3}s' | xargs;)" #経過時間の抽出
  STEP_CNT=$(sed -r 's;Step\s{1,};;;s;(.*)/(.*);\2;' <<<"$LAST_STEP")
  DONE_CNT=$(sed -r 's;Step\s{1,};;;s;(.*)/(.*);\1;' <<<"$LAST_STEP")
  echo -ne $tgt; #対象コンテナを追記
  [ $STEP_CNT -eq $DONE_CNT ] && echo STDOUT
  [ $STEP_CNT -eq $DONE_CNT ] || echo STDERR
  #[ -z "$LAST_STEP" ] && printf "\t%s\n" "$ELAPSED_TIME";
  #[ -z "$LAST_STEP" ] || printf "\t%s\t%s\n" "$LAST_STEP" "$ELAPSED_TIME";
done < <(ls -l ~/script_env | grep -P '^d' | awk '{print $9}' | xargs -n1 -I@ echo ~/script_env/@/log | grep -v 'docker-build-log')
