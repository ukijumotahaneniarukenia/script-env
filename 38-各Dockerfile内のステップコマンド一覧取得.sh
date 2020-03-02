#!/bin/bash

find $HOME/script-env -name "Dockerfile" | \
  while read tgt;do
    {
      echo $tgt | perl -pe "s:$HOME/script-env/::g;s:/Dockerfile::g"; \
      printf "%s\n" $(grep -c FROM $tgt); \
      printf "%s\n" $(grep -c USER $tgt); \
      printf "%s\n" $(grep -c RUN $tgt); \
      printf "%s\n" $(grep -c ENV $tgt); \
      printf "%s\n" $(grep -c ARG $tgt); \
      printf "%s\n" $(grep -c WORKDIR $tgt); \
    } | xargs -n8
  done | sed '1iファイル名 FROM数 USER数 RUN数 ENV数 ARG数 WORKDIR数' | sed -r 's;^|$| ;\|;g' | sed '2i|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|' >step.md
