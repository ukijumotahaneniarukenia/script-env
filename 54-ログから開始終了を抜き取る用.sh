#!/bin/bash

find $HOME/script-env -name "01-log" | while read tgt;do { echo $tgt;ls -l --time-style="+%Y-%m-%dT%H:%m:%S" $tgt | awk '{print $6}';} | xargs -n2;done | sort -rk2 | column -t -s' '
