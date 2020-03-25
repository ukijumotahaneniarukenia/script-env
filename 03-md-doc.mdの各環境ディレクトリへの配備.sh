#!/usr/bin/env bash

usage(){
cat <<EOS
Usage:
  $0 script-env script-repo
EOS
exit 0
}

ENV_REPO=$1;shift
INSTALLER_REPO=$1;shift
[ -z "$ENV_REPO" ] && usage
[ -z "$INSTALLER_REPO" ] && usage

while read tgt;do

  {
    #md-doc.mdファイルを配備
    echo cp $HOME/$ENV_REPO/md-doc.md $HOME/$ENV_REPO/$tgt/md-doc.md
    echo "sed -i 's;XXX;$tgt;g' $HOME/$ENV_REPO/$tgt/md-doc.md"
    echo "sed -i 's;HHH;$HOME;g' $HOME/$ENV_REPO/$tgt/md-doc.md"
    echo "sed -i 's;ENV_REPO;$ENV_REPO;g' $HOME/$ENV_REPO/$tgt/md-doc.md"

    RT="$(echo "grep '' $HOME/$ENV_REPO/$tgt/env-expose.md | xargs" | bash 2>/dev/null)"
    #デフォルト設定を適用
    [ -z "$RT" ] && printf "sed -i 's;EXPOSE;%s;' %s\n" "$(echo "grep EXPOSE $HOME/$ENV_REPO/$tgt/md-env.md" | bash 2>/dev/null | sed 's;.*=;;' | sort | uniq)" $HOME/$ENV_REPO/$tgt/md-doc.md
    #環境個別の設定を適用
    [ -z "$RT" ] || printf "sed -i 's;EXPOSE;%s;' %s\n" "$RT" $HOME/$ENV_REPO/$tgt/md-doc.md

    RT="$(echo "grep '' $HOME/$ENV_REPO/$tgt/env-shm-size.md" | bash 2>/dev/null)"
    #デフォルト設定を適用
    [ -z "$RT" ] && printf "sed -i 's;SHM_SIZE;%s;' %s\n" "$(echo "grep SHM_SIZE $HOME/$ENV_REPO/md-env.md" | bash | sed 's;.*=;;' | sort | uniq)" $HOME/$ENV_REPO/$tgt/md-doc.md
    #環境個別の設定を適用
    [ -z "$RT" ] || printf "sed -i 's;SHM_SIZE;%s;' %s\n" "$(echo $RT | sed 's/SHM_SIZE=//g')" $HOME/$ENV_REPO/$tgt/md-doc.md

    RT="$(echo "grep '' $HOME/$ENV_REPO/$tgt/env-build-arg.md | xargs" | bash 2>/dev/null)"
    #デフォルト設定を適用
    [ -z "$RT" ] && printf "sed -i 's;BUILD_ARG;%s;' %s\n" "$(echo "grep build-arg $HOME/$ENV_REPO/md-env.md" | sort | uniq | bash)" $HOME/$ENV_REPO/$tgt/md-doc.md
    #環境個別の設定を適用
    [ -z "$RT" ] || printf "sed -i 's;BUILD_ARG;%s;' %s\n" "$(echo $RT | sed 's; ; --build-arg ;g;s;^;--build-arg ;')" $HOME/$ENV_REPO/$tgt/md-doc.md

    printf "sed -i 's;INSTALLER_REPO;%s;' %s\n" $INSTALLER_REPO $HOME/$ENV_REPO/$tgt/md-doc.md
  } | bash

done < <(ls -l $HOME/$ENV_REPO | grep -P '^d' | awk '{print $9}' | grep -v docker-log)

#APP_NAMEの設定
find $HOME/$ENV_REPO -name "env-usr.md" | \
while read tgt;do
  {
    RESULT="$(grep -vP 'root|aine|kuraine|nahato|mujiku' $tgt | tail -n+3)"
    if [ "XXX" == "XXX$RESULT" ] ;then
      #デフォルトユーザーを使用
      echo 0 $tgt | awk '{print $2}' | perl -pe 's;/env-usr.md;;;s;.*/;;' | \
      while read tgt;do
        echo "sed -i 's;YYY;;g' $HOME/$ENV_REPO/$tgt/md-doc.md"
      done
    else
      #デフォルトユーザー以外を使用
      echo 1 $tgt | awk '{print $2}' | perl -pe 's;/env-usr.md;;;s;.*/;;' | \
      while read tgt;do
        NNN=$(echo $tgt | perl -pe 's/[a-zA-Z]+(?:-[0-9]+){1,}-//g')
        echo "sed -i 's;YYY;$NNN;g' $HOME/$ENV_REPO/$tgt/md-doc.md"
      done
    fi
  } | bash
done
