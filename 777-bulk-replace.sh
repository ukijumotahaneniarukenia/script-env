#!/bin/bash

#Usage
#$./b.sh elasticsearch751 elasticsearch-7-5-1 md-env.md
#$./b.sh '\--build-arg PYTHON_VERSION=3-7-4$' '\--build-arg PYTHON_VERSION=3-7-4 --build-arg GIT_VERSION=2-24-1' md-env.md
#$./b.sh '^--build-arg PYTHON_VERSION=3-7-4$' '\--build-arg PYTHON_VERSION=3-7-4 --build-arg GIT_VERSION=2-24-1' md-env.md

PRE_REGREX="$1"
POST_WORD="$2"
TGT_FILE_KEY_WORD="$3"
EXCEPT_FILE_LIST="script-env/md-env.md"
grep -l -P "$PRE_REGREX" -r $(pwd) | grep -P "$TGT_FILE_KEY_WORD$" | xargs -I@ echo "sed -i 's;$PRE_WORD;$POST_WORD;g' @" | grep -Pv "$EXCEPT_FILE_LIST"
