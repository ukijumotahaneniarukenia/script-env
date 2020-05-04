#!/usr/bin/env bash

usage(){
  cat <<EOS
Usage:
  $0 script-env
EOS
exit 0
}

REPO=$1

[ -z $REPO ] && usage

find $HOME/$REPO -name "Dockerfile.done" | awk '{PRE=$1;gsub("Dockerfile.done","Dockerfile",$0);print "mv "PRE" "$0}' #| bash
