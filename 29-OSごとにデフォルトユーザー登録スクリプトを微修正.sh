#!/usr/bin/env bash

#cat /home/aine/script-repo/ubuntu-16-04-script-env-default-env-usr.sh | sed -r "s/echo 'root_pwd' \| passwd --stdin root/echo 'root:root_pwd' | chpasswd/g"
#cat /home/aine/script-repo/ubuntu-16-04-script-env-default-env-usr.sh | sed -r "s/echo 'kuraine_pwd' \| passwd --stdin kuraine/echo 'kuraine:kuraine_pwd' | chpasswd/g"

usage(){
  cat <<EOS
Usage:
  $0 \$HOME
EOS
exit 0
}

DIR="$1";shift
REPO=script-repo

[ -z $DIR ] && usage
[ -z $REPO ] && usage

while read TGT;do
  echo $DIR/$REPO/$TGT
  sed -i -r "s/echo 'kuraine_pwd' \| passwd --stdin kuraine/echo 'kuraine:kuraine_pwd' | chpasswd/g" $DIR/$REPO/$TGT
  sed -i -r "s/echo 'root_pwd' \| passwd --stdin root/echo 'root:root_pwd' | chpasswd/g" $DIR/$REPO/$TGT
done < <(ls $DIR/$REPO | grep -P 'default-env-usr')
