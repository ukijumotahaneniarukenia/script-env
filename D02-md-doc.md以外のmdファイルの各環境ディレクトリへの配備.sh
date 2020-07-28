#!/usr/bin/env bash

usage(){
cat <<EOS
Usage:
  $0 script-env md-trs.md

  or

  $0 script-env md-trs.md --debug

  or

  ls md* | xargs -n1 -I@ $0 script-env @ --debug
EOS
exit 0
}

ENV_REPO=$1;shift
MD_FILE_NAME=$1;shift
DEBUG=$1;shift

if [ -z $DEBUG ];then
  SHELL=bash
else
  SHELL=:
fi

[ -z $ENV_REPO ] && usage

while read tgt;do
  cmd="cp $HOME/$ENV_REPO/$MD_FILE_NAME $HOME/$ENV_REPO/$tgt/$MD_FILE_NAME"
  if [ "$SHELL" = 'bash' ];then
    echo $cmd | $SHELL
  else
    echo $cmd
  fi

  if [ "$SHELL" = 'bash' ];then
    echo $cmd | awk '{print $3}' | grep gitignore | ruby -F/ -anle 'puts "mv "+ $F.join("/"),$F[0]+"/"+$F[1..$F.size-2].join("/")+"/"+$F[$F.size-1].gsub(/md-/,".")'|xargs -n4 | $SHELL
  else
    echo $cmd | awk '{print $3}' | grep gitignore | ruby -F/ -anle 'puts "mv "+ $F.join("/"),$F[0]+"/"+$F[1..$F.size-2].join("/")+"/"+$F[$F.size-1].gsub(/md-/,".")'|xargs -n4
  fi
done < <(ls -l $HOME/$ENV_REPO | grep -P '^d' | awk '{print $9}' | grep -v docker-build-log)
