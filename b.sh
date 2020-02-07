#!/bin/bash

#Usage
#$./b.sh elasticsearch751 elasticsearch-7-5-1

PRE_WORD=$1
POST_WORD=$2

grep -l $PRE_WORD -r $(pwd) | grep -P 'Dockerfile$' | xargs -I@ echo "sed -i 's;$PRE_WORD;$POST_WORD;g' @"
