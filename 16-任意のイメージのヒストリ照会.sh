#!/usr/bin/env bash

TGT="$@"

DEFAULT="(?:-[0-9]){1,}" #全て出力

docker images | grep -P '(?:-[0-9]){1,}' | grep -P "${TGT:-$DEFAULT}" |awk '{print $1}' | xargs -t -I@ docker history --human=false @
