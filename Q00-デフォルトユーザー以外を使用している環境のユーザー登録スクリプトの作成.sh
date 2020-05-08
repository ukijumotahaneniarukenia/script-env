#!/usr/bin/env bash

while read SRC_FILE_PATH;do
  #echo $SRC_FILE_PATH
  TGT_FILE_PATH="$(echo "$SRC_FILE_PATH" | perl -pe 's/([a-zA-Z]+(?:-[0-9]+){1,})(.*)/\1-install\2/g;s/script-env/script-repo/g;s:/user.md:-user.sh:g')"
  touch $TGT_FILE_PATH
  echo >$TGT_FILE_PATH
  while read MY_GROUP_ID MY_GROUP_NAME MY_USER_ID MY_USER_NAME MY_USER_PWD;do
    [ -z "$MY_GROUP_ID" ] && continue
    while read TEMPLATE_FILE_PATH;do
      echo "grep -q -P '"$(echo $SRC_FILE_PATH | perl -pe "s:$HOME/script-env/::g;s:-[0-9].*::g")-root-user-\(?=root\)"' <<<$TEMPLATE_FILE_PATH-$MY_USER_NAME" | bash
      #centosかつroot
      #ubuntuかつroot
      if [ 0 -eq $? ];then
        echo "sed 's/MY_GROUP_ID/$MY_GROUP_ID/;s/MY_GROUP_NAME/$MY_GROUP_NAME/;s/MY_USER_ID/$MY_USER_ID/;s/MY_USER_NAME/$MY_USER_NAME/;s/MY_USER_PWD/$MY_USER_PWD/;' $TEMPLATE_FILE_PATH >>$TGT_FILE_PATH" | bash
      else
        echo
      fi
      echo "grep -q -P '"$(echo $SRC_FILE_PATH | perl -pe "s:$HOME/script-env/::g;s:-[0-9].*::g")-non-root-user-\(?!root\)"' <<<$TEMPLATE_FILE_PATH-$MY_USER_NAME" | bash
      #centosかつnon-root
      #ubuntuかつnon-root
      if [ 0 -eq $? ];then
         echo "sed 's/MY_GROUP_ID/$MY_GROUP_ID/;s/MY_GROUP_NAME/$MY_GROUP_NAME/;s/MY_USER_ID/$MY_USER_ID/;s/MY_USER_NAME/$MY_USER_NAME/;s/MY_USER_PWD/$MY_USER_PWD/;' $TEMPLATE_FILE_PATH >>$TGT_FILE_PATH" | bash
      else
        echo
      fi
    done < <(ls $HOME/script-env/*user)
  done < <(sed -n '3,$p' $SRC_FILE_PATH | sed -r 's/^\|||\|$//g;s/\|/ /g')
  echo "sed -i '1i#!/usr/bin/env bash' $TGT_FILE_PATH" | bash
  echo "chmod 755 $TGT_FILE_PATH" | bash
done < <(find $HOME/script-env -name "user.md") | sed '/^$/d'

bash $HOME/script-env/31-デフォルトユーザーを使用している環境のインストーラ削除.sh script-env


#rootユーザーをしれっと追加
while read tgt;do
  while read os;do
    echo "echo $tgt | grep -q $os" | bash
    if [ 0 -eq $? ];then
      echo "cat $(ls $HOME/script-env/docker-template-install-$os-root-*) >>$tgt" | bash
      :
    else
      :
    fi
  done < <(find $HOME/script-env -type d | grep -Po '[a-z]+(-[0-9]{1,}){1,}' | grep -Po '[a-z]+' | sort | uniq)
done < <(ls $HOME/script-repo/*user* | grep -v default)
