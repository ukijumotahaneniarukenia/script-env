#!/usr/bin/env bash

usage(){
cat <<EOS
Usage:
  $0 script-env
EOS
exit 0
}

ENV_REPO=$1;shift

[ -z $ENV_REPO ] && usage

OUTPUT_FILE_NAME=app-env-Dockerfile-step-list.md

find $HOME/$ENV_REPO -name "Dockerfile" | \
  while read tgt;do
    {
      echo $tgt | perl -pe "s:$HOME/$ENV_REPO/::g;s:/Dockerfile::g"; \
      printf "%s\n" $(grep -c FROM $tgt); \
      printf "%s\n" $(grep -c USER $tgt); \
      printf "%s\n" $(grep -c RUN $tgt); \
      printf "%s\n" $(grep -c ENV $tgt); \
      printf "%s\n" $(grep -c ARG $tgt); \
      printf "%s\n" $(grep -c WORKDIR $tgt); \
    } | xargs -n8
  done | sed '1i環境ディレクトリ名 FROM数 USER数 RUN数 ENV数 ARG数 WORKDIR数' | sed -r 's;^|$| ;\|;g' | sed '2i|:--|:-:|:-:|:-:|:-:|:-:|:-:|' >$OUTPUT_FILE_NAME
