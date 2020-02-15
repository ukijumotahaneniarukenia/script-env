#!/bin/bash

docker images | awk '{print $1}' | grep -P '(?:centos|ubuntu)-' | grep -vP $(ls -l $HOME/script-env | grep -P '^d' | awk '{print $9}' | xargs | tr ' ' '|') #| xargs docker rmi 1>/dev/null 2>&1
