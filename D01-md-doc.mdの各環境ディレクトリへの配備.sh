#!/usr/bin/env bash

usage(){
cat <<EOS
Usage:
  $0 script-env script-repo
EOS
exit 0
}

DEFAULT_INSTALLER_REPO=script-repo

ENV_REPO=$1;shift
INSTALLER_REPO=$1;shift

[ -z "$ENV_REPO" ] && usage

if [ -z "$INSTALLER_REPO" ]; then
  :
else
  DEFAULT_INSTALLER_REPO=$INSTALLER_REPO
fi

while read tgt;do
  {
    #md-doc.mdファイルを配備
    echo cp $HOME/$ENV_REPO/md-doc.md $HOME/$ENV_REPO/$tgt/md-doc.md
    echo "sed -i 's;XXX;$tgt;g' $HOME/$ENV_REPO/$tgt/md-doc.md"
    echo "sed -i 's;HHH;$HOME;g' $HOME/$ENV_REPO/$tgt/md-doc.md"
    echo "sed -i 's;ENV_REPO;$ENV_REPO;g' $HOME/$ENV_REPO/$tgt/md-doc.md"

    RT="$(echo "grep '' $HOME/$ENV_REPO/$tgt/env-expose.env | xargs" | bash 2>/dev/null)"
    #デフォルト設定を適用
    [ -z "$RT" ] && printf "sed -i 's;EXPOSE;%s;' %s\n" "$(echo "grep EXPOSE $HOME/$ENV_REPO/$tgt/md-env.md" | bash 2>/dev/null | sed 's;.*=;;' | sort | uniq)" $HOME/$ENV_REPO/$tgt/md-doc.md
    #環境個別の設定を適用
    [ -z "$RT" ] || printf "sed -i 's;EXPOSE;%s;' %s\n" "$RT" $HOME/$ENV_REPO/$tgt/md-doc.md

    RT="$(echo "grep '' $HOME/$ENV_REPO/$tgt/env-shm-size.env" | bash 2>/dev/null)"
    #デフォルト設定を適用
    [ -z "$RT" ] && printf "sed -i 's;SHM_SIZE;%s;' %s\n" "$(echo "grep SHM_SIZE $HOME/$ENV_REPO/md-env.md" | bash | sed 's;.*=;;' | sort | uniq)" $HOME/$ENV_REPO/$tgt/md-doc.md
    #環境個別の設定を適用
    [ -z "$RT" ] || printf "sed -i 's;SHM_SIZE;%s;' %s\n" "$(echo $RT | sed 's/SHM_SIZE=//g')" $HOME/$ENV_REPO/$tgt/md-doc.md

    RT="$(echo "grep '' $HOME/$ENV_REPO/$tgt/env-build-arg.env | xargs" | bash 2>/dev/null)"
    #デフォルト設定を適用
    [ -z "$RT" ] && printf "sed -i 's;BUILD_ARG;%s;' %s\n" "$(echo "grep build-arg $HOME/$ENV_REPO/md-env.md" | sort | uniq | bash)" $HOME/$ENV_REPO/$tgt/md-doc.md
    #環境個別の設定を適用
    [ -z "$RT" ] || printf "sed -i 's;BUILD_ARG;%s;' %s\n" "$(echo $RT | sed 's; ; --build-arg ;g;s;^;--build-arg ;')" $HOME/$ENV_REPO/$tgt/md-doc.md

    printf "sed -i 's;INSTALLER_REPO;%s;' %s\n" $DEFAULT_INSTALLER_REPO $HOME/$ENV_REPO/$tgt/md-doc.md
  } | bash

done < <(ls -l $HOME/$ENV_REPO | grep -P '^d' | awk '{print $9}' | grep -v docker-log)
