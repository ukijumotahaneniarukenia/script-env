#!/bin/bash

TGT_BUILD_IMAGE_EXPECT_CNT=$(ls -l $HOME/script-env | grep -P '^d' | awk '{print $9}' | grep -v docker-build-log | wc -l )
TGT_BUILD_IMAGE_EXPECT="$(ls -l $HOME/script-env | grep -P '^d' | awk '{print $9}' | grep -v docker-build-log )"
TGT_BUILD_IMAGE_ACTUAL_CNT=$(docker images | grep -P '(?:-[0-9]){1,}' | awk '{print $1}' | xargs -I@ bash -c "echo @ && docker history --human=false @ | sort -rk2 | sed -r 's;\s{1,}; ;g;' | cut -d' ' -f2 | sed -n '2p'" | xargs -n2 | grep "$(date "+%Y-%m-%d")" | wc -l)
TGT_BUILD_IMAGE_ACTUAL="$(docker images | grep -P '(?:-[0-9]){1,}' | awk '{print $1}' | xargs -I@ bash -c "echo @ && docker history --human=false @ | sort -rk2 | sed -r 's;\s{1,}; ;g;' | cut -d' ' -f2 | sed -n '2p'" | xargs -n2 | grep "$(date "+%Y-%m-%d")" | cut -d' ' -f1)"
TGT_BUILD_IMAGE_DONE_NON_TODAY_CNT=$(docker images | grep -P '(?:-[0-9]){1,}' | awk '{print $1}' | xargs -I@ bash -c "echo @ && docker history --human=false @ | sort -rk2 | sed -r 's;\s{1,}; ;g;' | cut -d' ' -f2 | sed -n '2p'" | xargs -n2 | grep -v "$(date "+%Y-%m-%d")" | wc -l)
TGT_BUILD_IMAGE_DONE_NON_TODAY="$(docker images | grep -P '(?:-[0-9]){1,}' | awk '{print $1}' | xargs -I@ bash -c "echo @ && docker history --human=false @ | sort -rk2 | sed -r 's;\s{1,}; ;g;' | cut -d' ' -f2 | sed -n '2p'" | xargs -n2 | grep -v "$(date "+%Y-%m-%d")" | cut -d' ' -f1)"
TGT_BUILD_IMAGE_DONE_TODAY_CNT=$(docker images | grep -P '(?:-[0-9]){1,}' | awk '{print $1}' | xargs -I@ bash -c "echo @ && docker history --human=false @ | sort -rk2 | sed -r 's;\s{1,}; ;g;' | cut -d' ' -f2 | sed -n '2p'" | xargs -n2 | grep "$(date "+%Y-%m-%d")" | wc -l)
TGT_BUILD_IMAGE_DONE_TODAY="$(docker images | grep -P '(?:-[0-9]){1,}' | awk '{print $1}' | xargs -I@ bash -c "echo @ && docker history --human=false @ | sort -rk2 | sed -r 's;\s{1,}; ;g;' | cut -d' ' -f2 | sed -n '2p'" | xargs -n2 | grep "$(date "+%Y-%m-%d")" | cut -d' ' -f1)"

TGT_BUILD_IMAGE_NON_DONE_CNT=$(echo "$TGT_BUILD_IMAGE_EXPECT" | grep -vP "$(echo "${TGT_BUILD_IMAGE_DONE_NON_TODAY:-UNKO}"|xargs|tr ' ' '|')" | grep -vP "$(echo "${TGT_BUILD_IMAGE_DONE_TODAY:-UNKO}"|xargs|tr ' ' '|')"|wc -l)

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
