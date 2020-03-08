#!/bin/bash

docker ps -a | head -n1
docker ps -a | grep Up | grep -P $(ls -l $HOME/script-env | grep -P '^d' | awk '{print $9}' | grep -v docker-log|xargs|tr ' ' '|')
