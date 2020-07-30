#!/usr/bin/env bash

usage(){
cat <<EOS
Usage:
  bash $0 script-env
EOS
exit 0
}

ENV_REPO=$1;shift
INSTALLER_REPO=${1:-script-repo};shift

[ -z "$ENV_REPO" ] && usage
[ -z "$INSTALLER_REPO" ] && usage

while read tgt;do
  {
    echo cp $HOME/$ENV_REPO/md-doc.md $HOME/$ENV_REPO/$tgt/md-doc.md
    echo "sed -i 's;XXX;$tgt;g' $HOME/$ENV_REPO/$tgt/md-doc.md"
    echo "sed -i 's;HHH;$HOME;g' $HOME/$ENV_REPO/$tgt/md-doc.md"
    echo "sed -i 's;ENV_REPO;$ENV_REPO;g' $HOME/$ENV_REPO/$tgt/md-doc.md"
    printf "sed -i 's;INSTALLER_REPO;%s;' %s\n" $INSTALLER_REPO $HOME/$ENV_REPO/$tgt/md-doc.md

    RT="$(echo "grep '' $HOME/$ENV_REPO/$tgt/env-build-arg.env | xargs" | bash 2>/dev/null)"
    [ -z "$RT" ] || printf "sed -i 's;BUILD_ARG;%s;' %s\n" "$(echo $RT | sed 's; ; --build-arg ;g;s;^;--build-arg ;')" $HOME/$ENV_REPO/$tgt/md-doc.md

    RT="$(cat $HOME/$ENV_REPO/$tgt/env-shm-size.env | sed 's/.*=//g')"
    [ -z "$RT" ] || printf "sed -i 's;SHM_SIZE;%s;' %s\n" $RT $HOME/$ENV_REPO/$tgt/md-doc.md

    RT="$(cat $HOME/$ENV_REPO/$tgt/env-port* | sed 's/.*=//' | xargs -n2 | tr ' ' ':' | sed 's/^/-p /' | xargs)"
    [ -z "$RT" ] || printf "sed -i 's;EXPOSE;%s;' %s\n" "$RT" $HOME/$ENV_REPO/$tgt/md-doc.md

  } | bash
done < <(ls -l $HOME/$ENV_REPO | grep -P '^d' | awk '{print $9}' | grep -v docker-log)
