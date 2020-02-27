#!/bin/bash

#コンテナ起動に失敗したコンテナを削除
docker ps -a | awk '{print $1,$2}' | tail -n+2 | grep -vE $(ls -l $HOME/script-env | grep -P '^d' | awk '{print $9}' | grep -v docker-build-log |xargs|tr ' ' '|') | awk '{print $1}' | xargs -I@ bash -c 'docker stop @ && docker rm @' 1>/dev/null 2>&1

#noneイメージを削除
docker images | awk '$1=="<none>"{print $3}' | xargs -I@ docker rmi @ 1>/dev/null 2>&1

#ディレクトリにないが、イメージとして作成されてしまっているものを削除（フォルダをリネームした場合とか。同期取るようにする。）
docker images | awk '{print $1}' | grep -P '(?:centos|ubuntu)-' | grep -vE $(ls -l $HOME/script-env | grep -P '^d' | awk '{print $9}' | grep -v docker-build-log | xargs | tr ' ' '|') | xargs docker rmi 1>/dev/null 2>&1

#Exitedコンテナ削除
docker ps -a | grep Exited | awk '{print $1}' | xargs -I@ docker rm @ 1>/dev/null 2>&1
