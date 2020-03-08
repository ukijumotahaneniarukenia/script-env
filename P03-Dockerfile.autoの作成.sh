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

  TEMPLATE_FILE=$(find $HOME/$REPO | grep -P "docker-template-Dockerfile-$OS_NAME")

#  printf "
#OS_VERSION:%s
#OS_NAME:%s
#IMAGE_VERSION:%s
#TEMPLATE_FILE:%s
#" $OS_VERSION $OS_NAME $IMAGE_VERSION $TEMPLATE_FILE

  #テンプレートファイルのIMAGE_VERSIONの置換
  #テンプレートファイルのDOCKERFILE_ARGの置換
  while read tgt;do
    if [ -f $tgt/env-image.md ];then
      RT="$(grep FROM $tgt/env-image.md)"
      if [ -z "$RT" ];then
        echo "sed 's;BASE_IMAGE;FROM $OS_NAME:$IMAGE_VERSION;' $TEMPLATE_FILE >$tgt/Dockerfile.auto" | bash
      else
        echo "sed 's;BASE_IMAGE;$RT;' $TEMPLATE_FILE >$tgt/Dockerfile.auto" | bash
      fi
    else
      :
    fi
    echo "sed -i '/^USER/,/^EXPOSE/d' $tgt/Dockerfile.auto" | bash
    cat $tgt/env-build-arg.md  | sed 's/=.*//;s/^/ARG /;' >/tmp/env-build-arg-$(echo $tgt | perl -pe 's;/;-;g')
    echo "sed -i '/DOCKERFILE_ARG/r /tmp/env-build-arg-$(echo $tgt | perl -pe 's;/;-;g')' $tgt/Dockerfile.auto" | bash
    echo "sed -i '/DOCKERFILE_ARG/d' $tgt/Dockerfile.auto" | bash
  done < <(find $HOME/$REPO -type d | grep -v docker-log | grep $OS_VERSION)

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
  done < <(find $HOME/$REPO -type d | grep -v docker-log | grep $OS_VERSION)

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
  done < <(find $HOME/$REPO -type d | grep -v docker-log | grep $OS_VERSION)

  #最後に見つかったWORKDIR以外を削除
  while read tgt;do
    grep -n -P  'WORKDIR' $tgt/Dockerfile.auto | cut -d' ' -f1 | xargs | sed '/^$/d' | awk -v FS=' ' '{$NF="";print $0}' | xargs -I@ echo @ | perl -pe "s;:.*;;;s;^;sed -i ;;s;$;d $tgt/Dockerfile.auto;" | bash
  done < <(find $HOME/$REPO -type d | grep -v docker-log | grep $OS_VERSION)

}

main(){
  REPO="$@"
  [ -z $REPO ] && usage
  export -f execute
  find $HOME/$REPO -type d | grep -Po '[a-z]+(-[0-9]{1,}){1,}' | sort | uniq | while read tgt;do execute $tgt;done
}

main "$@"
