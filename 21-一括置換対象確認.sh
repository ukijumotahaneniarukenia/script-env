#!/usr/bin/env bash

usage(){
cat <<EOS
Usage:
  ./21-一括置換対象確認.sh '~' '\\\$HOME'
EOS
exit 1
}

IS_AS=$1
TO_BE=$2

[ -z "$IS_AS" ] && usage
[ -z "$TO_BE" ] && usage

while read tgt;do

  printf "%s\t%s\t%s\n" $(grep -c -P "$IS_AS" $tgt) $tgt "sed -i 's;$IS_AS;$TO_BE;g' $tgt" | grep -vP "^0|${0#./}"

done < <(find $HOME/script-env -mindepth 2 -type f -name "*sh" -o -name "*Dockerfile" -o -name "env.md")
