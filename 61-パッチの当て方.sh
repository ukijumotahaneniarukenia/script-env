#!/bin/bash

./59-Dockerfile.done内のRUNコマンド行にあってARGコマンド行にないVERSION一覧取得.sh script-env script-repo | sort -k3 >D59
join -1 3 -2 1 D59 env-cmd-version-list  | awk '{gsub("Dockerfile.done","env-build-arg.md",$3);print "echo \x27"$1"="$4"\x27 >>"$3}'
