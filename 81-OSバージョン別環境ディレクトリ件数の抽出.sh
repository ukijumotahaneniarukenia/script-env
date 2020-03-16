#!/usr/bin/env bash

find $HOME/script-env -mindepth 1 -type d | grep -vP '\.git|docker-log' | grep -Po '[a-z]+(-[0-9]{1,}){1,}' | sort | uniq -c | awk '{print $2,$1}'
