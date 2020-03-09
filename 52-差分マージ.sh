#!/usr/bin/env bash

usage(){
cat <<EOS
Usage:
第一引数にキーワード
第二引数にマージ元ファイル
$0 env centos-7-6-18-10-config-env.sh
EOS
}

KEYWORD=$1
MERGE_SRC_FILE=$2

TGT_DIR="/usr/local/src/script-repo"

[ -z $KEYWORD ] && usage && exit 1
[ -z $MERGE_SRC_FILE ] && usage && exit 1

MERGE_CONTENT="$(while read MERGE_TGT_FILE;do
  comm -13 --nocheck-order <(sort $MERGE_SRC_FILE | sed -r '/^$/d') <(sort $MERGE_TGT_FILE | sed -r '/^$/d')
done < <(ls $TGT_DIR | grep $KEYWORD) | sort | uniq)"

echo "$MERGE_CONTENT" >>$MERGE_SRC_FILE
echo 'source $HOME/.bashrc' >>$MERGE_SRC_FILE

#最終行以外のsourceコマンドを排除
while true;do
  CMD="$(grep -n -P 'source \$HOME/\.bashrc' $MERGE_SRC_FILE | sed '$d' | perl -pe 's/:.*//' | xargs -I@ echo "sed -i '@d' $MERGE_SRC_FILE")"
  [ -z "$CMD" ] && break
  [ -z "$CMD" ] || echo "$CMD" | sh
done

#マージ反映
while read MERGE_TGT_FILE;do
  [ $MERGE_TGT_FILE == $MERGE_SRC_FILE ] && :
  [ $MERGE_TGT_FILE == $MERGE_SRC_FILE ] || echo "cp "$MERGE_SRC_FILE $MERGE_TGT_FILE | sh
done < <(ls $TGT_DIR | grep $KEYWORD)
