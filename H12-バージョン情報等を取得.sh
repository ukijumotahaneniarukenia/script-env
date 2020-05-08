#!/usr/bin/env bash

find -type f -name "Dockerfile" | grep -vP 'log' | while read f;do echo $f;grep -I -Po '[\-\_\~\^a-zA-Z]+-(?:(?:-|\.|_)*(?:[0-9]+)){1,}' $f|sort|uniq -c;done
