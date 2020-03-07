#!/usr/bin/env bash

usage(){
  cat <<EOS
Usage:
  $0 script-env
EOS
exit 0
}

execute(){

  OS_VERSION=$1;shift

  [ -z $OS_VERSION ] && usage

  OS_NAME=$(echo $OS_VERSION | perl -pe 's/^([a-z]+)-(.*)$/\1/g')

  IMAGE_VERSION=$(echo $OS_VERSION | perl -pe 's/^([a-z]+)-(.*)$/\2/g')

  if [ "centos" == $OS_NAME ];then
    IMAGE_VERSION=$(echo $IMAGE_VERSION | perl -pe 's/-/\./;s/-/\./;s/-//;')
  fi

  if [ "ubuntu" == $OS_NAME ];then
    IMAGE_VERSION=$(echo $IMAGE_VERSION | perl -pe 's/-/\./;')
  fi

  TEMPLATE_FILE=$(find $HOME/$REPO | grep -P "docker-build-template-Dockerfile-$OS_NAME")

  #テンプレートファイルのIMAGE_VERSIONの置換
  #テンプレートファイルのDOCKERFILE_ARGの置換
  while read tgt;do
    echo "sed 's/IMAGE_VERSION/$IMAGE_VERSION/' $TEMPLATE_FILE >$tgt/Dockerfile.auto" | bash
    echo "sed -i '/^USER/,/^EXPOSE/d' $tgt/Dockerfile.auto" | bash
    cat $tgt/env-build-arg.md  | sed 's/=.*//;s/^/ARG /;' >/tmp/env-build-arg-$(echo $tgt | perl -pe 's;/;-;g')
    echo "sed -i '/DOCKERFILE_ARG/r /tmp/env-build-arg-$(echo $tgt | perl -pe 's;/;-;g')' $tgt/Dockerfile.auto" | bash
    echo "sed -i '/DOCKERFILE_ARG/d' $tgt/Dockerfile.auto" | bash
  done < <(find $HOME/$REPO -type d | grep -v docker-build-log | grep $OS_VERSION)

  rm -rf /tmp/env-build-arg*

  #テンプレートファイルのMAIN_USERの置換
  while read tgt;do
    {
      echo $tgt
      grep -c -vP  'ユーザーＩＤ|aine|kuraine|nahato|mujiku|:-:|root' $tgt/env-usr.md
      grep -vP  'ユーザーＩＤ|aine|kuraine|nahato|mujiku|:-:|root' $tgt/env-usr.md | awk -v FS='|' -v ORS='' '{print ","$3}'
    } | xargs -n3 | \
    while read file cnt usr;do
      if [ 0 -eq $cnt ];then
        echo "sed -n '/^USER/,/^EXPOSE/p' $TEMPLATE_FILE | head -n-1 | perl -pe "s/MAIN_USER/kuraine/g" >>$file/Dockerfile.auto" | bash
      fi
      for (( i=0;i<$cnt;i++));do
        echo "sed -n '/^USER/,/^EXPOSE/p' $TEMPLATE_FILE | head -n-1 | perl -pe "s/MAIN_USER/$(echo $usr | cut -d',' -f$(($i+2)))/g" >>$file/Dockerfile.auto" | bash
      done
    done
  done < <(find $HOME/$REPO -type d | grep -v docker-build-log | grep $OS_VERSION)

  #テンプレートファイルのEXPOSEの置換
  while read tgt;do
    {
      echo $tgt
      grep -c -P  '\-p' $tgt/env-expose.md
      grep -P  '\-p' $tgt/env-expose.md | awk -v ORS='' '{print ","$1$2}'
    } | xargs -n3 | \
    while read file cnt port;do
      for (( i=0;i<$cnt;i++));do
        echo "sed -n '/EXPOSE/p' $TEMPLATE_FILE | perl -pe "s/PORT/$(echo $port | cut -d',' -f$(($i+2))|sed -r 's/.*://')/g" >>$file/Dockerfile.auto" | bash
      done
    done
  done < <(find $HOME/$REPO -type d | grep -v docker-build-log | grep $OS_VERSION)

  #最後に見つかったWORKDIR以外を削除
  while read tgt;do
    grep -n -P  'WORKDIR' $tgt/Dockerfile | cut -d' ' -f1 | xargs | sed '/^$/d' | awk -v FS=' ' '{$NF="";print $0}' | xargs -I@ echo @ | perl -pe "s;:.*;;;s;^;sed -i ;;s;$;d $tgt/Dockerfile.auto;" | bash
  done < <(find $HOME/$REPO -type d | grep -v docker-build-log | grep $OS_VERSION)

  #テンプレート生成したDockerfileと既存Dockerfileのうち既存にしかないものを抽出
  while read tgt;do
    echo "cd  $tgt && comm -23 --nocheck-order <(sort Dockerfile | sed -r '/^$/d') <(sort Dockerfile.auto | sed -r '/^$/d')>Dockerfile.sub"
  done < <(find $HOME/$REPO -type d | grep -v docker-build-log | grep $OS_VERSION) | bash
}

main(){
  REPO="$@"
  [ -z $REPO ] && usage
  export -f execute
  find $HOME/$REPO -type d | grep -Po '[a-z]+(-[0-9]{1,}){1,}' | sort | uniq | while read tgt;do execute $tgt;done
}

main "$@"
