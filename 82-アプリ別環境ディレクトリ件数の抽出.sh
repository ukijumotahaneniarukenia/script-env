#!/usr/bin/env bash


find $HOME/script-env -mindepth 1 -type d | grep -vP '\.git|docker-log' | perl -pe 's;.*/;;' | grep -Po '(-[a-zA-Z]+){1,}' | tr '-' '\n' | sed '/^$/d' | sort | uniq -c | awk '{print $2,$1}'
