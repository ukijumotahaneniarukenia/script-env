#!/bin/bash

#よさげだったら、以下で一括置換
#
#./21-一括置換対象確認.sh | awk '{$1="";$2="";print $0}' | sh
usage(){
cat <<EOS
Usage:
  ./21-一括置換対象確認.sh '~' '\\\$HOME'

EOS
}


IS_AS=$1
TO_BE=$2

[ -z "$IS_AS" ] && usage && exit 1
[ -z "$TO_BE" ] && usage && exit 1

while read tgt;do

  printf "%s\t%s\t%s\n" $(grep -c -P "$IS_AS" $tgt) $tgt "sed -i 's;$IS_AS;$TO_BE;g' $tgt" | grep -vP "^0|${0#./}"

done < <(find $HOME/script-repo -type f -name "*sh" -o -name "*Dockerfile")
