#!/bin/bash

usage(){
  cat <<EOS
Usage:
   $0 'script-repo.git' 'RUN cd /usr/local/src/script-repo && echo ./\$OS_VERSION-install-default-user.sh | bash' script-env
EOS
exit 0
}

TGT_WORD="$1";shift
EMBEDED_WORD="$1";shift
REPO="$1";shift

[ -z "$TGT_WORD" ] && usage
[ -z "$EMBEDED_WORD" ] && usage
[ -z "$REPO" ] && usage

while read tgt;do

  TGT_FILE=$(echo $tgt | tr ':' '\n' | sed -n '1p')
  TGT_ROWN=$(echo $tgt | tr ':' '\n' | sed -n '2p')

  printf "sed -i \x27%si%s\x27 %s\n" "$(($TGT_ROWN+1))" "$EMBEDED_WORD" "$TGT_FILE"

done < <(grep -n -P "$TGT_WORD" -r $HOME/$REPO | grep -P 'Dockerfile') | grep -vP "${0:2}"
