#!/bin/bash

usage(){
  cat <<EOS
Usage:
   $0 'ARG OS_VERSION' 'ARG REPO' script-env
EOS
exit 0
}

IS_AS="$1";shift
TO_BE="$1";shift
REPO="$1";shift

[ -z "$IS_AS" ] && usage
[ -z "$TO_BE" ] && usage
[ -z "$REPO" ] && usage

mmm="Dockerfile$"

while read tgt;do

  TGT_FILE=$(echo $tgt | tr ':' '\n' | sed -n '1p')
  TGT_ROWN=$(echo $tgt | tr ':' '\n' | sed -n '2p')

  if [[ $(echo $tgt | cut -d' ' -f1 | awk -v FS=':' '{print $1}') =~ $mmm ]];then
    #マッチする場合
    echo "sed -i '$(($TGT_ROWN+1))i$TO_BE' $TGT_FILE"
  else
    #マッチしない場合はなにもしない
    #echo non-match
    :
  fi

done < <(grep -I -n -P "$IS_AS" -r $HOME/$REPO)
