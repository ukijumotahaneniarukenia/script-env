#!/bin/bash

find $HOME/script-env -mindepth 1 -type d | grep -vP '\.git|docker-log' | xargs -I@ cat @/env-build-arg.md | sort | uniq | awk -v FS='=' -v OFS=' ' '{print $1,$2}' >env-cmd-version-list
