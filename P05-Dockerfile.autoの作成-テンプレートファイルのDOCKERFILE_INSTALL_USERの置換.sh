#!/usr/bin/env bash

usage(){
cat <<EOS
Usage:
  $0 script-env
  or
  $0 script-env --debug
EOS
exit 0
}

execute(){

  OS_VERSION=$1;shift

  [ -z $OS_VERSION ] && usage

  OS_NAME=$(echo $OS_VERSION | perl -pe 's/^([a-z]+)-(.*)$/\1/g')

  TEMPLATE_FILE=$(find $HOME/$ENV_REPO -name "docker-template-Dockerfile-$OS_NAME")

  TEMPLATE_CMD="RUN cd /usr/local/src/\\\$REPO && echo './\\\$OS_VERSION-install-default-user.sh ARGS' | bash"

  while read tgt;do
    REPLACE_POS=$(grep -n DOCKERFILE_INSTALL_USER $tgt/Dockerfile.auto | sed 's/:.*//')
    #テンプレートファイルのDOCKERFILE_INSTALL_USERの置換
    {
      echo $tgt
      grep -c -vP  'ユーザーＩＤ|aine|kuraine|nahato|mujiku|:-:|root' $tgt/env-user.env
      grep -vP  'ユーザーＩＤ|aine|kuraine|nahato|mujiku|:-:|root' $tgt/env-user.env | awk -v FS='|' -v ORS='' '{print ","$2}'|sed 's/$/@/'
      grep -vP  'ユーザーＩＤ|aine|kuraine|nahato|mujiku|:-:|root' $tgt/env-user.env | awk -v FS='|' -v ORS='' '{print ","$3}'|sed 's/$/@/'
      grep -vP  'ユーザーＩＤ|aine|kuraine|nahato|mujiku|:-:|root' $tgt/env-user.env | awk -v FS='|' -v ORS='' '{print ","$4}'|sed 's/$/@/'
      grep -vP  'ユーザーＩＤ|aine|kuraine|nahato|mujiku|:-:|root' $tgt/env-user.env | awk -v FS='|' -v ORS='' '{print ","$5}'|sed 's/$/@/'
    } | xargs -n6 | sed '/^$/d' |\
    while read file row_cnt user_info;do
      #echo $file $row_cnt $user_id $user_name $group_id $group_name
      if [ 0 -eq $row_cnt ];then
        #cmd=$(echo "$TEMPLATE_CMD" |  >>$file/Dockerfile.auto)
        cmd=$(sed "s:ARGS::;s:^:echo :;" <<< "$TEMPLATE_CMD")
        if [ "$SHELL" = 'bash' ];then
          echo $cmd | sed "s;echo ;sed -i \x22$REPLACE_POS i;;s;$;\x22 $file/Dockerfile.auto;" | $SHELL
        else
          echo $cmd | sed "s;echo ;sed -i \x22$REPLACE_POS i;;s;$;\x22 $file/Dockerfile.auto;"
        fi
      else
        col_cnt=$(echo $user_info | awk '{print gsub("@","",$1)}')
      fi
      for (( i=1;i<=$row_cnt;i++));do
        args="$(seq $col_cnt | while read j;do
          #echo $file $i $j $user_info $(echo $user_info | cut -d'@' -f$j | awk -v i=$(($i+1)) -v FS=',' '{print $i}')
          echo $(echo $user_info | cut -d'@' -f$j | awk -v i=$(($i+1)) -v FS=',' '{print $i}')
        done | xargs -n4)"
        cmd=$(sed "s:ARGS:$args:;s:^:echo :;" <<< "$TEMPLATE_CMD")
        #cmd=$(sed "s:ARGS:$args:;s:^:echo :;s:$: $file/Dockerfile.auto:" <<< "$TEMPLATE_CMD")
        if [ "$SHELL" = 'bash' ];then
          echo $cmd | sed "s;echo ;sed -i \x22$REPLACE_POS i;;s;$;\x22 $file/Dockerfile.auto;" | $SHELL
        else
          echo $cmd | sed "s;echo ;sed -i \x22$REPLACE_POS i;;s;$;\x22 $file/Dockerfile.auto;"
        fi
      done
    done

    sed -i '/DOCKERFILE_INSTALL_USER/d' $tgt/Dockerfile.auto

  done < <(find $HOME/$ENV_REPO -mindepth 1 -type d | grep -vP '\.git|docker-log|mnt' | grep $OS_VERSION)

}

main(){
  ENV_REPO=$1;shift
  DEBUG=$1;shift

  if [ "$DEBUG" = '--debug' ];then
    SHELL=: #なんもしない
  else
    SHELL=bash #じっこうする
  fi

  [ -z $ENV_REPO ] && usage

  export -f execute
  find $HOME/$ENV_REPO -mindepth 1 -type d | grep -vP '\.git|docker-log|mnt' | grep -Po '[a-z]+(-[0-9]{1,}){1,}' | sort | uniq | while read tgt;do execute $tgt ;done
}

main "$@"
