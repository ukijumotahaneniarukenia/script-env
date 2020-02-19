#!/bin/bash

ls -l $HOME/script-env | grep -P '^d' | awk '{print $9}' | grep -vP 'docker-build-log' | perl -pe 's/((?:-[0-9]{1,}){2,}-)/\t\1\t/g' | awk '{print $1,substr($2,2,length($2)-2),$3}' | awk '{print NR,$3,gsub("-","",$3)+1}' | perl -pe 's; ;\|;g' | sed -r 's;^|$;\|;g' | sed '1i|No|app|cnt|' | sed '2i|:-:|:-:|:-:|' >liz.md
