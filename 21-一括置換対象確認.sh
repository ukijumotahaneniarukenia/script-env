#!/bin/bash

while read tgt;do

  printf "%s\t%s\t%s\n" $(grep -c -P '~' $tgt) $tgt "sed -i 's;~;\$HOME;g' $tgt" | grep -vP '^0'

done < <(find $HOME/script-env -type f -name "*sh" -o -name "*Dockerfile")
