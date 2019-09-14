#!/bin/bash

CMD="$1";shift;
PDB_CNT="$@"

create(){
  [ -z "${PDB_CNT}" ] && echo PDB数を入力してください。 && exit 1
  time sqlplus sys/ORACLE_PWD@ORCLCDB as sysdba @launch_and_open_db.sql ${PDB_CNT}
  #リスナー登録
  seq ${PDB_CNT} | xargs -n1 echo "ORCLPDB@ = (DESCRIPTION = (ADDRESS = (PROTOCOL = TCP)(HOST = be807f28f5bd)(PORT = 1521)) (CONNECT_DATA = (SERVER = DEDICATED) (SERVICE_NAME = ORCLPDB@)))" | awk '{$NF="";RN=sprintf("%02d",NR);print "echo \x22"$0"\x22 | sed -E \x27s;@;"RN";g\x27"}' | bash >> /opt/oracle/product/19c/dbhome_1/network/admin/tnsnames.ora
  sleep 60
  #リスナー停止
  lsnrctl stop
  sleep 60
  #リスナー起動
  lsnrctl start
  sleep 60
  #リスナー起動確認
  lsnrctl status
}

configure(){
  time sudo /etc/init.d/oracledb_ORCLCDB-19c configure
}

case "${CMD}" in
    create)
        create
    ;;
    configure)
        configure
    ;;
    *)
        echo $"Usage: $0 {configure|create}"
        exit 1
    ;;
esac

exit 0
