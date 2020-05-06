#!/usr/bin/env bash
docker ps -a | grep Exited | awk '{print $1}' | xargs -I@ docker rm @
