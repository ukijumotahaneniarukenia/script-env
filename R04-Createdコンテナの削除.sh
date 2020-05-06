#!/usr/bin/env bash
docker ps -a | grep Created | awk '{print $1}' | xargs -I@ bash -c 'docker stop @ && docker rm @'
