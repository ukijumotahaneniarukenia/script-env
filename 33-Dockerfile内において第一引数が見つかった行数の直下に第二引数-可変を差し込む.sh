#!/bin/bash

usage(){
  cat <<EOS
Usage:
   $0 'script-repo.git' 'non-default-user-list' script-env
EOS
exit 0
}

TGT_WORD="$1";shift
EMBEDED_WORD_LIST="$1";shift
REPO="$1";shift

[ -z "$TGT_WORD" ] && usage
[ -z "$EMBEDED_WORD_LIST" ] && usage
[ -z "$REPO" ] && usage

while read tgt;do

  TGT_FILE=$(echo $tgt | tr ':' '\n' | sed -n '1p')
  TGT_ROWN=$(echo $tgt | tr ':' '\n' | sed -n '2p')

  while read EMBEDED_WORD;do
    grep -q -P "$(echo $EMBEDED_WORD | sed -r 's/.*install-//g;s/-user.sh//g')" <<<$TGT_FILE
    if [ 0 -eq $? ];then
       printf "sed -i \x27%si%s\x27 %s\n" "$(($TGT_ROWN+1))" "$(echo $EMBEDED_WORD | sed -r 's/(.*)(-install.*)/\2/g;s;^;RUN cd /usr/local/src/script-repo \&\& echo ./$OS_VERSION;g;s;$; \| bash;g')" "$TGT_FILE"
    else
      :
    fi
  done < $EMBEDED_WORD_LIST

done < <(grep -n -P "$TGT_WORD" -r $HOME/$REPO | grep -P 'Dockerfile') | grep -vP "${0:2}"
