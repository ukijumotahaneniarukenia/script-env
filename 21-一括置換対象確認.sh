#!/bin/bash

while read tgt;do

  printf "%s\t%s\n" $(grep -c -P '~' $tgt) $tgt | grep -v '^0'

done < <(find $HOME/script-env -type f -name "*sh" -o -name "*Dockerfile")
