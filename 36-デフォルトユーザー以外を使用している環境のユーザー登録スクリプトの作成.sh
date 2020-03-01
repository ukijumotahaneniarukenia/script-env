#!/bin/bash

while read SRC_FILE_PATH;do
  echo $SRC_FILE_PATH
  TGT_FILE_PATH="$(echo "$SRC_FILE_PATH" | perl -pe 's/([a-zA-Z]+(?:-[0-9]+){1,})(.*)/\1-install\2/g;s/script-env/script-repo/g;s:/env-usr.md:-env-usr.sh:g')"
  touch $TGT_FILE_PATH
  echo >$TGT_FILE_PATH
  while read MY_GROUP_ID MY_GROUP_NAME MY_USER_ID MY_USER_NAME MY_USER_PWD;do
    [ -z "$MY_GROUP_ID" ] && continue
    RT=0
    while read TEMPLATE_FILE_PATH;do
      echo "grep -q -P '"$(echo $SRC_FILE_PATH | perl -pe "s:$HOME/script-env/::g;s:-[0-9].*::g")-root-env-usr-\(?=root\)"' <<<$TEMPLATE_FILE_PATH-$MY_USER_NAME" | bash
      #centosかつroot
      #ubuntuかつroot
      if [ 0 -eq $? ];then
        echo "sed 's/MY_GROUP_ID/$MY_GROUP_ID/;s/MY_GROUP_NAME/$MY_GROUP_NAME/;s/MY_USER_ID/$MY_USER_ID/;s/MY_USER_NAME/$MY_USER_NAME/;s/MY_USER_PWD/$MY_USER_PWD/;' $TEMPLATE_FILE_PATH >>$TGT_FILE_PATH" | bash
      else
        echo
      fi
      echo "grep -q -P '"$(echo $SRC_FILE_PATH | perl -pe "s:$HOME/script-env/::g;s:-[0-9].*::g")-non-root-env-usr-\(?!root\)"' <<<$TEMPLATE_FILE_PATH-$MY_USER_NAME" | bash
      #centosかつnon-root
      #ubuntuかつnon-root
      if [ 0 -eq $? ];then
         echo "sed 's/MY_GROUP_ID/$MY_GROUP_ID/;s/MY_GROUP_NAME/$MY_GROUP_NAME/;s/MY_USER_ID/$MY_USER_ID/;s/MY_USER_NAME/$MY_USER_NAME/;s/MY_USER_PWD/$MY_USER_PWD/;' $TEMPLATE_FILE_PATH >>$TGT_FILE_PATH" | bash
      else
        echo
      fi
    done < <(ls $HOME/script-env/*env-usr)
  done < <(sed -n '3,$p' $SRC_FILE_PATH | sed -r 's/^\|||\|$//g;s/\|/ /g')
  echo "sed -i '1i#!/usr/bin/env bash' $TGT_FILE_PATH" | bash
  echo "chmod 755 $TGT_FILE_PATH" | bash
done < <(find $HOME/script-env -name "env-usr.md") | sed '/^$/d'

bash $HOME/script-env/31-デフォルトユーザーを使用している環境のインストーラ削除.sh script-env
