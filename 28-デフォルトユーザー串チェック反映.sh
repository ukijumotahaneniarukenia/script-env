#!/bin/bash

usage(){
  cat <<EOS
Usage:
  $0 centos-7-6-18-10-script-env-default-env-usr.sh \$HOME
EOS
exit 0
}

SRC="$1";shift
DIR="$1";shift
REPO=script-repo

[ -z $SRC ] && usage
[ -z $DIR ] && usage
[ -z $REPO ] && usage

while read TGT;do
  [ "$SRC" == "$TGT" ] || :
  [ "$SRC" != "$TGT" ] && echo "cp "$DIR/$REPO/$SRC" "$DIR/$REPO/$TGT
done < <(ls $DIR/$REPO | grep -Po '[a-z]+(-[0-9]{1,}){1,}' | grep -P 'ubuntu|centos' | sort | uniq | xargs -I@ echo "@$(echo "$SRC" | grep -Po '\-script-env.*')")
