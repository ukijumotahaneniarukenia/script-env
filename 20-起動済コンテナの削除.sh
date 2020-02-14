#!/bin/bash
docker ps -a | awk '{print $1,$2}' | tail -n+2 | grep -vE $(ls -l ~/script-env | grep -P '^d' | awk '{print $9}' | grep -v docker-build-log |xargs|tr ' ' '|') | awk '{print $1}' | xargs -I@ bash -c 'docker stop @ && docker rm @' 1>/dev/null 2>&1
