#!/bin/bash

usage(){
  cat <<EOS
Usage:
  bash $0 docker-build-wanted-list
EOS
exit 0
}

BUILD_LIST_FILE=$HOME/script-env/"$1";shift

[ -z $BUILD_LIST_FILE ] && usage

TGT_BUILD_IMAGE_EXPECT_LIST="$(cat $BUILD_LIST_FILE)"
TGT_BUILD_IMAGE_EXPECT_CNT=$(echo "$TGT_BUILD_IMAGE_EXPECT_LIST" | wc -l )

TGT_BUILD_IMAGE_ACTUAL_LIST="$(docker images | awk '{print $1}' | grep -P '(?:-[0-9]){1,}' | xargs -I@ bash -c "echo @ && docker history --human=false @ | sort -rk2 | sed -r 's;\s{1,}; ;g;' | cut -d' ' -f2 | sed -n '2p'" | xargs -n2 | column -t -s' ' | grep "$(date "+%Y-%m-%d")")"
TGT_BUILD_IMAGE_ACTUAL_CNT=$(echo "$TGT_BUILD_IMAGE_ACTUAL_LIST" | wc -l)

echo "本日のビルド対象予定数は$TGT_BUILD_IMAGE_EXPECT_CNT件でした"
echo "$TGT_BUILD_IMAGE_EXPECT_LIST"
echo "本日のビルド対象実績数は$TGT_BUILD_IMAGE_ACTUAL_CNT件でした"
echo "$TGT_BUILD_IMAGE_ACTUAL_LIST"
