#!/bin/bash
usage(){
  cat <<EOS
Usage:
  $0 script-env
EOS
exit 0
}

REPO="$1"
[ -z $REPO ] && usage

while read tgt;do
  if [ -s $tgt/env-env.md ];then
    #ゼロバイトじゃない
    #echo 1 $tgt/env-env.md
    echo "sed -i 's/^/ENV /' $tgt/env-env.md" | bash
  else
    #ゼロバイト
    :
    #echo 0 $tgt/env-env.md
  fi
done < <(find $HOME/$REPO -type d | grep -vP '\.git|docker-log')
