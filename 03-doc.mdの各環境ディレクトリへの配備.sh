#!/usr/bin/env bash

usage(){
cat <<EOS
Usage:
  $0 script-repo
EOS
exit 0
}

REPO=$1

[ -z "$REPO" ] && usage

while read tgt;do

  #doc.mdファイルを配備
  echo cp $HOME/script-env/doc.md $HOME/script-env/$tgt/doc.md | bash
  echo "sed -i 's;XXX;$tgt;g' $HOME/script-env/$tgt/doc.md" | bash
  echo "sed -i 's;ZZZ;$REPO;g' $HOME/script-env/$tgt/doc.md" | bash

  RT="$(echo "grep '' $HOME/script-env/$tgt/env-expose.md | xargs" | bash 2>/dev/null)"
  #デフォルト設定を適用
  [ -z "$RT" ] && printf "sed -i 's;EXPOSE;%s;' %s\n" "$(echo "grep EXPOSE $HOME/script-env/$tgt/env.md" | bash 2>/dev/null | sed 's;.*=;;' | sort | uniq)" $HOME/script-env/$tgt/doc.md | bash
  #環境個別の設定を適用
  [ -z "$RT" ] || printf "sed -i 's;EXPOSE;%s;' %s\n" "$RT" $HOME/script-env/$tgt/doc.md | bash

  RT="$(echo "grep '' $HOME/script-env/$tgt/env-shm-size.md" | bash 2>/dev/null)"
  #デフォルト設定を適用
  [ -z "$RT" ] && printf "sed -i 's;SHM_SIZE;%s;' %s\n" "$(echo "grep bashM_SIZE $HOME/script-env/env.md" | bash | sed 's;.*=;;' | sort | uniq)" $HOME/script-env/$tgt/doc.md | bash
  #環境個別の設定を適用
  [ -z "$RT" ] || printf "sed -i 's;SHM_SIZE;%s;' %s\n" "$(echo $RT | sed 's/SHM_SIZE=//g')" $HOME/script-env/$tgt/doc.md | bash

  RT="$(echo "grep '' $HOME/script-env/$tgt/env-build-arg.md | xargs" | bash 2>/dev/null)"
  #デフォルト設定を適用
  [ -z "$RT" ] && printf "sed -i 's;BUILD_ARG;%s;' %s\n" "$(echo "grep build-arg $HOME/script-env/env.md" | sort | uniq | bash)" $HOME/script-env/$tgt/doc.md | bash
  #環境個別の設定を適用
  [ -z "$RT" ] || printf "sed -i 's;BUILD_ARG;%s;' %s\n" "$(echo $RT | sed 's; ; --build-arg ;g;s;^;--build-arg ;')" $HOME/script-env/$tgt/doc.md | bash

done < <(ls -l $HOME/script-env | grep -P '^d' | awk '{print $9}' | grep -v docker-build-log)

#APP_NAMEの設定
find $HOME/script-env -name "env-usr.md" | \
while read tgt;do
  RESULT="$(grep -vP 'root|aine|kuraine|nahato|mujiku' $tgt | tail -n+3)"
  if [ "XXX" == "XXX$RESULT" ] ;then
    #デフォルトユーザーを使用
    echo 0 $tgt | awk '{print $2}' | perl -pe 's;/env-usr.md;;;s;.*/;;' | \
    while read tgt;do
      echo "sed -i 's;YYY;;g' $HOME/script-env/$tgt/doc.md" | bash
    done
  else
    #デフォルトユーザー以外を使用
    echo 1 $tgt | awk '{print $2}' | perl -pe 's;/env-usr.md;;;s;.*/;;' | \
    while read tgt;do
      NNN=$(echo $tgt | perl -pe 's/[a-zA-Z]+(?:-[0-9]+){1,}-//g')
      echo "sed -i 's;YYY;$NNN;g' $HOME/script-env/$tgt/doc.md" | bash
    done
  fi
done
