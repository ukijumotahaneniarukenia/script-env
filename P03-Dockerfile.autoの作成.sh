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
  EDITOR=$1;shift

  [ -z $OS_VERSION ] && usage

  OS_NAME=$(echo $OS_VERSION | perl -pe 's/^([a-z]+)-(.*)$/\1/g')

  IMAGE_VERSION=$(echo $OS_VERSION | perl -pe 's/^([a-z]+)-(.*)$/\2/g')

  if [ "centos" == $OS_NAME ];then
    IMAGE_VERSION=$(echo $IMAGE_VERSION | perl -pe 's/-/\./;s/-/\./;s/-//;')
  fi

  if [ "ubuntu" == $OS_NAME ];then
    IMAGE_VERSION=$(echo $IMAGE_VERSION | perl -pe 's/-/\./;')
  fi

  TEMPLATE_FILE=$(find $HOME/$REPO -name "docker-template-Dockerfile-$OS_NAME")

  EDITOR_LIST="$(ls $HOME/script-env/env-editor-* | grep $OS_NAME | awk -v FS='-' -v OFS='-' '{$1="";$2="";$3="";$4="";print $0}' | sed -r 's/^-{1,}//g' | sort | uniq)"

  while read tgt;do
    #テンプレートファイルのIMAGE_VERSIONの置換
    if [ -f $tgt/env-image.md ];then
      RT="$(grep FROM $tgt/env-image.md)"
      if [ -z "$RT" ];then
        #環境個別のイメージファイルがない場合
        echo "sed 's;BASE_IMAGE;FROM $OS_NAME:$IMAGE_VERSION;' $TEMPLATE_FILE >$tgt/Dockerfile.auto" | bash
      else
        #環境個別のイメージファイルがある場合
        echo "sed 's;BASE_IMAGE;$RT;' $TEMPLATE_FILE >$tgt/Dockerfile.auto" | bash
      fi
    else
      #環境個別のイメージファイルがない場合
      :
    fi

    echo "sed -i '/^USER/,/^EXPOSE/d' $tgt/Dockerfile.auto" | bash

    #テンプレートファイルのDOCKERFILE_ARGの置換
    cat $tgt/env-build-arg.md  | sed 's/=.*//;s/^/ARG /;' >/tmp/env-build-arg-$(echo $tgt | perl -pe 's;/;-;g')
    echo "sed -i '/DOCKERFILE_ARG/r /tmp/env-build-arg-$(echo $tgt | perl -pe 's;/;-;g')' $tgt/Dockerfile.auto" | bash
    echo "sed -i '/DOCKERFILE_ARG/d' $tgt/Dockerfile.auto" | bash

    #テンプレートファイルのDOCKERFILE_ENVの置換
    echo "sed -i '/DOCKERFILE_ENV/r $tgt/env-env.md' $tgt/Dockerfile.auto" | bash
    echo "sed -i '/DOCKERFILE_ENV/d' $tgt/Dockerfile.auto" | bash

    #テンプレートファイルのDOCKERFILE_EDITORの置換
    for n in "$EDITOR_LIST";do
      #エディタが決まるまでは、ちとめんどい。
      EDITOR="$(echo "echo" $tgt "| grep -Po '("$(echo $n | tr ' ' '|')")$'" | bash)"
      if [ -z "$EDITOR" ];then
        #vimの場合またはenv-editor未定義かつ明示的にvimと環境ディレクトリに明記していない場合
        echo "sed -i '/DOCKERFILE_EDITOR/d' $tgt/Dockerfile.auto" | bash
      else
        #env-editor定義の環境ディレクトリの場合
        echo "sed -i '/DOCKERFILE_EDITOR/r $(find $HOME/$REPO -maxdepth 1 -type f -name "env-editor*" | grep $OS_NAME | grep -P "$EDITOR$")' $tgt/Dockerfile.auto" | bash
        echo "sed -i '/DOCKERFILE_EDITOR/d' $tgt/Dockerfile.auto" | bash
      fi
    done

    #テンプレートファイルのMAIN_USERの置換
    {
      echo $tgt
      grep -c -vP  'ユーザーＩＤ|aine|kuraine|nahato|mujiku|:-:|root' $tgt/env-user.md
      grep -vP  'ユーザーＩＤ|aine|kuraine|nahato|mujiku|:-:|root' $tgt/env-user.md | awk -v FS='|' -v ORS='' '{print ","$3}'
    } | xargs -n3 | \
    while read file cnt usr;do
      if [ 0 -eq $cnt ];then
        echo "sed -n '/^USER/,/^EXPOSE/p' $TEMPLATE_FILE | head -n-1 | perl -pe "s/MAIN_USER/kuraine/g" >>$file/Dockerfile.auto" | bash
      fi
      for (( i=0;i<$cnt;i++));do
        echo "sed -n '/^USER/,/^EXPOSE/p' $TEMPLATE_FILE | head -n-1 | perl -pe "s/MAIN_USER/$(echo $usr | cut -d',' -f$(($i+2)))/g" >>$file/Dockerfile.auto" | bash
      done
    done

    #テンプレートファイルのEXPOSEの置換
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

    #最後に見つかったWORKDIR以外を削除
    grep -n -P  'WORKDIR' $tgt/Dockerfile.auto | cut -d' ' -f1 | xargs | sed '/^$/d' | awk -v FS=' ' '{$NF="";print $0}' | xargs -I@ echo @ | perl -pe "s;:.*;;;s;^;sed -i ;;s;$;d $tgt/Dockerfile.auto;" | bash
  done < <(find $HOME/$REPO -type d | grep -v docker-log | grep $OS_VERSION | grep -vP mnt )

  rm -rf /tmp/env-build-arg*
}

main(){
  REPO="$1";shift
  [ -z $REPO ] && usage

  bash P04-環境ディレクトリ内のmntディレクトリを削除する.sh $REPO | bash

  export -f execute
  find $HOME/$REPO -type d | grep -Po '[a-z]+(-[0-9]{1,}){1,}' | sort | uniq | while read tgt;do execute $tgt ;done
}

main "$@"
