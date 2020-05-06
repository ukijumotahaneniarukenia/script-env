#!/usr/bin/env bash
docker images | awk '$1=="<none>"{print $3}' | xargs -I@ docker rmi @
