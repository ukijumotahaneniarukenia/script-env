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
    echo cp $HOME/$ENV_REPO/md-doc.md $HOME/$ENV_REPO/$tgt/md-doc.md
    echo "sed -i 's;XXX;$tgt;g' $HOME/$ENV_REPO/$tgt/md-doc.md"
    echo "sed -i 's;HHH;$HOME;g' $HOME/$ENV_REPO/$tgt/md-doc.md"
    echo "sed -i 's;ENV_REPO;$ENV_REPO;g' $HOME/$ENV_REPO/$tgt/md-doc.md"
    printf "sed -i 's;INSTALLER_REPO;%s;' %s\n" $INSTALLER_REPO $HOME/$ENV_REPO/$tgt/md-doc.md

  } | bash
done < <(ls -l $HOME/$ENV_REPO | grep -P '^d' | awk '{print $9}' | grep -v docker-log)
