#!/bin/bash

CMD="$1";shift;

delete_cdb(){
  sudo /etc/init.d/oracledb_ORCLCDB-19c delete
}

create_cdb(){
  sudo /etc/init.d/oracledb_ORCLCDB-19c configure
}

create_pdb(){
  [ -z "${PDB_CNT}" ] && echo PDB数を入力してください。 && exit 1
  echo "pdbを${PDB_CNT}個作成します。"
  sqlplus sys/ORACLE_PWD@ORCLCDB as sysdba @launch_and_open_db.sql ${PDB_CNT}
  [ $? -ne 0 ] && echo "pdbの作成に失敗しました。" && exit 1
  [ $? -eq 0 ] && echo "pdbを${PDB_CNT}個作成しました。"
  #リスナー登録
  echo "リスナー登録処理を開始します。"
  seq ${PDB_CNT} | xargs -n1 echo "ORCLPDB@ = (DESCRIPTION = (ADDRESS = (PROTOCOL = TCP)(HOST = $(hostname))(PORT = 1521)) (CONNECT_DATA = (SERVER = DEDICATED) (SERVICE_NAME = ORCLPDB@)))" | awk '{$NF="";RN=sprintf("%02d",NR);print "echo \x22"$0"\x22 | sed -E \x27s;@;"RN";g\x27"}' | bash >> /opt/oracle/product/19c/dbhome_1/network/admin/tnsnames.ora
  echo "リスナー再起動中"
  #リスナー停止
  lsnrctl stop
  #リスナー起動
  lsnrctl start
  echo "リスナー反映中"
  sleep 90
  #リスナー起動確認
  lsnrctl status
  echo "リスナー登録処理が完了しました。"
}

create_usr(){
  [ -z "${PDB_NUM}" ] && echo ユーザーを作成するPDBを指定してください。&& exit 1
  [ -z "${USR_CNT}" ] && echo 作成するユーザー数を指定してください。&& exit 1
  echo "ユーザー登録処理を開始します。"
  echo "sqlplus sys/ORACLE_PWD@ORCLPDB$(printf "%02d" ${PDB_NUM}) as sysdba @create_user.sql ${PDB_NUM} ${USR_CNT}" | bash
  [ $? -ne 0 ] && echo "ユーザー登録処理に失敗しました。" && exit 1
  [ $? -eq 0 ] && echo "ユーザー登録処理が完了しました。"
}

case "${CMD}" in
    delete_cdb)
        time delete_cdb
    ;;
    create_cdb)
        time create_cdb
    ;;
    create_pdb)
        PDB_CNT="$@";shift;
        time create_pdb
    ;;
    create_usr)
        PDB_NUM="$1";shift;
        USR_CNT="$@";shift;
        time create_usr
    ;;
    *)
        echo $"Usage: $0 {delete_cdb|create_cdb|create_pdb|create_usr}"
        exit 1
    ;;
esac

exit 0
