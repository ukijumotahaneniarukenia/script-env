#!/bin/bash

#CDB作成
cd ~ && time /etc/init.d/oracledb_ORCLCDB-19c configure

#PDB作成
sqlplus sys/ORACLE_PWD@ORCLCDB as sysdba @launch_and_open_db.sql

#リスナー登録
echo "ORCLPDB@ = (DESCRIPTION = (ADDRESS = (PROTOCOL = TCP)(HOST = be807f28f5bd)(PORT = 1521)) (CONNECT_DATA = (SERVER = DEDICATED) (SERVICE_NAME = ORCLPDB@)))" | parallel echo :::: - <(seq 2) | awk '{$NF="";RN=sprintf("%02d",NR);print "echo \x22"$0"\x22 | sed -E \x27s;@;"RN";g\x27"}' | bash >> /opt/oracle/product/19c/dbhome_1/network/admin/tnsnames.ora

sleep 60
#リスナー停止
lsnrctl stop
sleep 60
#リスナー起動
lsnrctl start
sleep 60
#リスナー起動確認
lsnrctl status
