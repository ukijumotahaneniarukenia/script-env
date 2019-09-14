# dockerコンテナ削除
```
docker ps -qa | xargs -I@ bash -c 'docker stop @ && docker rm @'
```

# dockerイメージ作成
```
time docker build -t centos_oracle . | tee log
```

# dockerイメージ削除
```
docker images | awk '$1=="<none>"{print $3}' | xargs -I@ docker rmi @
```

# dockerコンテナ起動
```
docker run --privileged --shm-size=8gb --name oracle -itd -v /run/udev:/run/udev -v /run/systemd:/run/systemd -v /tmp/.X11-unix:/tmp/.X11-unix -v /var/lib/dbus:/var/lib/dbus -v /var/run/dbus:/var/run/dbus -v /etc/machine-id:/etc/machine-id -p 28787:8787 -p 21521:1521 -p 25500:5500 centos_oracle /sbin/init
```

# dockerコンテナ潜入
```
docker exec --user root -it oracle /bin/bash
```

# CDB作成
```
[oracle@30bf33351a1f ~]$./init_db.sh create_cdb
Configuring Oracle Database ORCLCDB.
[WARNING] [DBT-06208] 入力された'SYS(S)'パスワードが推奨される標準に準拠していません。
   原因: 
a. 入力するパスワードは、長さを8文字以上にし、大文字、小文字および数字(0から9)をそれぞれ最低1文字含めることをお薦めします。
b. 入力したパスワードは、Oracleがパスワードとしての使用を推奨していないキーワードです
   アクション: 強力なパスワードを指定してください。必要に応じて、Oracleドキュメントのガイドラインを参照してください。
[WARNING] [DBT-06208] 入力された'SYSTEM(Y)'パスワードが推奨される標準に準拠していません。
   原因: 
a. 入力するパスワードは、長さを8文字以上にし、大文字、小文字および数字(0から9)をそれぞれ最低1文字含めることをお薦めします。
b. 入力したパスワードは、Oracleがパスワードとしての使用を推奨していないキーワードです
   アクション: 強力なパスワードを指定してください。必要に応じて、Oracleドキュメントのガイドラインを参照してください。
DB操作の準備
10%完了
データベース・ファイルのコピー中
40%完了
Oracleインスタンスの作成および起動中
42%完了
46%完了
52%完了
56%完了
60%完了
データベース作成の完了
66%完了
70%完了
構成後アクションの実行
100%完了
データベースの作成が完了しました。詳細は、次の場所にあるログ・ファイルを参照してください:
/opt/oracle/cfgtoollogs/dbca/ORCLCDB。
データベース情報:
グローバル・データベース名:ORCLCDB
システム識別子(SID):ORCLCDB
詳細はログ・ファイル"/opt/oracle/cfgtoollogs/dbca/ORCLCDB/ORCLCDB.log"を参照してください。

Database configuration completed successfully. The passwords were auto generated, you must change them by connecting to the database using 'sqlplus / as sysdba' as the oracle user.

real	13m59.968s
user	0m17.635s
sys	0m2.314s
[oracle@30bf33351a1f ~]$tree /opt/oracle/oradata/ORCLCDB/
/opt/oracle/oradata/ORCLCDB/
|-- control01.ctl
|-- control02.ctl
|-- pdbseed
|   |-- sysaux01.dbf
|   |-- system01.dbf
|   |-- temp012019-09-14_20-47-33-328-PM.dbf
|   `-- undotbs01.dbf
|-- redo01.log
|-- redo02.log
|-- redo03.log
|-- sysaux01.dbf
|-- system01.dbf
|-- temp01.dbf
|-- undotbs01.dbf
`-- users01.dbf

1 directory, 14 files
```

# PDB作成
作成するPDB数を指定
```
[oracle@30bf33351a1f ~]$./init_db.sh create_pdb 2
pdbを2個作成します。

SQL*Plus: Release 19.0.0.0.0 - Production on 土 9月 14 21:31:25 2019
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.



Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
に接続されました。
旧   2:     for i in 1..'&1' loop
新   2:     for i in 1..'2' loop
create pluggable database orclpdb01 admin user user01 identified by oracle_pwd roles = (dba) file_name_convert = ('/opt/oracle/oradata/ORCLCDB/pdbseed','/opt/oracle/oradata/ORCLCDB/pdb01')
alter pluggable database orclpdb01 open read write
create pluggable database orclpdb02 admin user user01 identified by oracle_pwd roles = (dba) file_name_convert = ('/opt/oracle/oradata/ORCLCDB/pdbseed','/opt/oracle/oradata/ORCLCDB/pdb02')
alter pluggable database orclpdb02 open read write

PL/SQLプロシージャが正常に完了しました。

経過: 00:00:05.32
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0との接続が切断されました。
リスナー登録処理を開始します。
リスナー再起動中

LSNRCTL for Linux: Version 19.0.0.0.0 - Production on 14-9月 -2019 21:31:31

Copyright (c) 1991, 2019, Oracle.  All rights reserved.

(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=30bf33351a1f)(PORT=1521)))に接続中
コマンドは正常に終了しました。

LSNRCTL for Linux: Version 19.0.0.0.0 - Production on 14-9月 -2019 21:31:31

Copyright (c) 1991, 2019, Oracle.  All rights reserved.

/opt/oracle/product/19c/dbhome_1/bin/tnslsnrを起動しています。お待ちください...

TNSLSNR for Linux: Version 19.0.0.0.0 - Production
システム・パラメータ・ファイルは/opt/oracle/product/19c/dbhome_1/network/admin/listener.oraです。
ログ・メッセージを/opt/oracle/diag/tnslsnr/30bf33351a1f/listener/alert/log.xmlに書き込みました。
リスニングしています: (DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=30bf33351a1f)(PORT=1521)))
リスニングしています: (DESCRIPTION=(ADDRESS=(PROTOCOL=ipc)(KEY=EXTPROC1521)))

(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=30bf33351a1f)(PORT=1521)))に接続中
リスナーのステータス
------------------------
別名                      LISTENER
バージョン                TNSLSNR for Linux: Version 19.0.0.0.0 - Production
開始日                    14-9月 -2019 21:31:31
稼働時間                  0 日 0 時間 0 分 0 秒
トレース・レベル          off
セキュリティ              ON: Local OS Authentication
SNMP                      OFF
パラメータ・ファイル      /opt/oracle/product/19c/dbhome_1/network/admin/listener.ora
ログ・ファイル            /opt/oracle/diag/tnslsnr/30bf33351a1f/listener/alert/log.xml
リスニング・エンドポイントのサマリー...
  (DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=30bf33351a1f)(PORT=1521)))
  (DESCRIPTION=(ADDRESS=(PROTOCOL=ipc)(KEY=EXTPROC1521)))
リスナーはサービスをサポートしていません。
コマンドは正常に終了しました。
リスナー反映中

LSNRCTL for Linux: Version 19.0.0.0.0 - Production on 14-9月 -2019 21:33:01

Copyright (c) 1991, 2019, Oracle.  All rights reserved.

(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=30bf33351a1f)(PORT=1521)))に接続中
リスナーのステータス
------------------------
別名                      LISTENER
バージョン                TNSLSNR for Linux: Version 19.0.0.0.0 - Production
開始日                    14-9月 -2019 21:31:31
稼働時間                  0 日 0 時間 1 分 30 秒
トレース・レベル          off
セキュリティ              ON: Local OS Authentication
SNMP                      OFF
パラメータ・ファイル      /opt/oracle/product/19c/dbhome_1/network/admin/listener.ora
ログ・ファイル            /opt/oracle/diag/tnslsnr/30bf33351a1f/listener/alert/log.xml
リスニング・エンドポイントのサマリー...
  (DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=30bf33351a1f)(PORT=1521)))
  (DESCRIPTION=(ADDRESS=(PROTOCOL=ipc)(KEY=EXTPROC1521)))
  (DESCRIPTION=(ADDRESS=(PROTOCOL=tcps)(HOST=30bf33351a1f)(PORT=5500))(Security=(my_wallet_directory=/opt/oracle/admin/ORCLCDB/xdb_wallet))(Presentation=HTTP)(Session=RAW))
サービスのサマリー...
サービス"92838c975cb20efde053020011ace1aa"には、1件のインスタンスがあります。
  インスタンス"ORCLCDB"、状態READYには、このサービスに対する1件のハンドラがあります...
サービス"92838c975cb50efde053020011ace1aa"には、1件のインスタンスがあります。
  インスタンス"ORCLCDB"、状態READYには、このサービスに対する1件のハンドラがあります...
サービス"ORCLCDB"には、1件のインスタンスがあります。
  インスタンス"ORCLCDB"、状態READYには、このサービスに対する1件のハンドラがあります...
サービス"ORCLCDBXDB"には、1件のインスタンスがあります。
  インスタンス"ORCLCDB"、状態READYには、このサービスに対する1件のハンドラがあります...
サービス"orclpdb01"には、1件のインスタンスがあります。
  インスタンス"ORCLCDB"、状態READYには、このサービスに対する1件のハンドラがあります...
サービス"orclpdb02"には、1件のインスタンスがあります。
  インスタンス"ORCLCDB"、状態READYには、このサービスに対する1件のハンドラがあります...
コマンドは正常に終了しました。
リスナー登録処理が完了しました。

real	1m36.092s
user	0m0.025s
sys	0m0.031s
[oracle@30bf33351a1f ~]$tree /opt/oracle/oradata/ORCLCDB/
/opt/oracle/oradata/ORCLCDB/
|-- control01.ctl
|-- control02.ctl
|-- pdb01
|   |-- sysaux01.dbf
|   |-- system01.dbf
|   |-- temp012019-09-14_20-47-33-328-PM.dbf
|   `-- undotbs01.dbf
|-- pdb02
|   |-- sysaux01.dbf
|   |-- system01.dbf
|   |-- temp012019-09-14_20-47-33-328-PM.dbf
|   `-- undotbs01.dbf
|-- pdbseed
|   |-- sysaux01.dbf
|   |-- system01.dbf
|   |-- temp012019-09-14_20-47-33-328-PM.dbf
|   `-- undotbs01.dbf
|-- redo01.log
|-- redo02.log
|-- redo03.log
|-- sysaux01.dbf
|-- system01.dbf
|-- temp01.dbf
|-- undotbs01.dbf
`-- users01.dbf

3 directories, 22 files
```

# ユーザー作成
対象のPDBと作成するユーザ数を指定
```
[oracle@30bf33351a1f ~]$./init_db.sh create_usr 1 2
ユーザー登録処理を開始します。

SQL*Plus: Release 19.0.0.0.0 - Production on 土 9月 14 21:37:15 2019
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.



Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
に接続されました。
旧   2:     for i in 1..'&2' loop
新   2:     for i in 1..'2' loop
旧  14:             dbms_output.put_line('create tablespace tabsp'||lpad(i,2,0)|| ' datafile '|| '''' ||'/opt/oracle/oradata/ORCLCDB/pdb'||lpad(&1,2,0)||'/user'||lpad(i,2,0)||'.dbf' || '''' || ' size 100m autoextend on next 500k maxsize unlimited');
新  14:             dbms_output.put_line('create tablespace tabsp'||lpad(i,2,0)|| ' datafile '|| '''' ||'/opt/oracle/oradata/ORCLCDB/pdb'||lpad(1,2,0)||'/user'||lpad(i,2,0)||'.dbf' || '''' || ' size 100m autoextend on next 500k maxsize unlimited');
旧  15:             execute immediate 'create tablespace tabsp'||lpad(i,2,0)|| ' datafile '|| '''' ||'/opt/oracle/oradata/ORCLCDB/pdb'||lpad(&1,2,0)||'/user'||lpad(i,2,0)||'.dbf' || '''' || ' size 100m autoextend on next 500k maxsize unlimited';
新  15:             execute immediate 'create tablespace tabsp'||lpad(i,2,0)|| ' datafile '|| '''' ||'/opt/oracle/oradata/ORCLCDB/pdb'||lpad(1,2,0)||'/user'||lpad(i,2,0)||'.dbf' || '''' || ' size 100m autoextend on next 500k maxsize unlimited';
drop user user01
drop tablespace tabsp01 including contents and datafiles cascade constraints
create tablespace tabsp01 datafile '/opt/oracle/oradata/ORCLCDB/pdb01/user01.dbf' size 100m autoextend on next 500k maxsize unlimited
create user user01 identified by "ORACLE_PWD" default tablespace tabsp01 temporary tablespace temp
grant dba to user01
grant unlimited tablespace to user01
drop user user02
drop tablespace tabsp02 including contents and datafiles cascade constraints
create tablespace tabsp02 datafile '/opt/oracle/oradata/ORCLCDB/pdb01/user02.dbf' size 100m autoextend on next 500k maxsize unlimited
create user user02 identified by "ORACLE_PWD" default tablespace tabsp02 temporary tablespace temp
grant dba to user02
grant unlimited tablespace to user02

PL/SQLプロシージャが正常に完了しました。

経過: 00:00:01.95
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0との接続が切断されました。

real	0m2.034s
user	0m0.010s
sys	0m0.012s
[oracle@30bf33351a1f ~]$tree /opt/oracle/oradata/ORCLCDB/
/opt/oracle/oradata/ORCLCDB/
|-- control01.ctl
|-- control02.ctl
|-- pdb01
|   |-- sysaux01.dbf
|   |-- system01.dbf
|   |-- temp012019-09-14_20-47-33-328-PM.dbf
|   |-- undotbs01.dbf
|   |-- user01.dbf
|   `-- user02.dbf
|-- pdb02
|   |-- sysaux01.dbf
|   |-- system01.dbf
|   |-- temp012019-09-14_20-47-33-328-PM.dbf
|   `-- undotbs01.dbf
|-- pdbseed
|   |-- sysaux01.dbf
|   |-- system01.dbf
|   |-- temp012019-09-14_20-47-33-328-PM.dbf
|   `-- undotbs01.dbf
|-- redo01.log
|-- redo02.log
|-- redo03.log
|-- sysaux01.dbf
|-- system01.dbf
|-- temp01.dbf
|-- undotbs01.dbf
`-- users01.dbf

3 directories, 24 files
[oracle@30bf33351a1f ~]$./init_db.sh create_usr 2 3
ユーザー登録処理を開始します。

SQL*Plus: Release 19.0.0.0.0 - Production on 土 9月 14 21:38:55 2019
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.



Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
に接続されました。
旧   2:     for i in 1..'&2' loop
新   2:     for i in 1..'3' loop
旧  14:             dbms_output.put_line('create tablespace tabsp'||lpad(i,2,0)|| ' datafile '|| '''' ||'/opt/oracle/oradata/ORCLCDB/pdb'||lpad(&1,2,0)||'/user'||lpad(i,2,0)||'.dbf' || '''' || ' size 100m autoextend on next 500k maxsize unlimited');
新  14:             dbms_output.put_line('create tablespace tabsp'||lpad(i,2,0)|| ' datafile '|| '''' ||'/opt/oracle/oradata/ORCLCDB/pdb'||lpad(2,2,0)||'/user'||lpad(i,2,0)||'.dbf' || '''' || ' size 100m autoextend on next 500k maxsize unlimited');
旧  15:             execute immediate 'create tablespace tabsp'||lpad(i,2,0)|| ' datafile '|| '''' ||'/opt/oracle/oradata/ORCLCDB/pdb'||lpad(&1,2,0)||'/user'||lpad(i,2,0)||'.dbf' || '''' || ' size 100m autoextend on next 500k maxsize unlimited';
新  15:             execute immediate 'create tablespace tabsp'||lpad(i,2,0)|| ' datafile '|| '''' ||'/opt/oracle/oradata/ORCLCDB/pdb'||lpad(2,2,0)||'/user'||lpad(i,2,0)||'.dbf' || '''' || ' size 100m autoextend on next 500k maxsize unlimited';
drop user user01
drop tablespace tabsp01 including contents and datafiles cascade constraints
create tablespace tabsp01 datafile '/opt/oracle/oradata/ORCLCDB/pdb02/user01.dbf' size 100m autoextend on next 500k maxsize unlimited
create user user01 identified by "ORACLE_PWD" default tablespace tabsp01 temporary tablespace temp
grant dba to user01
grant unlimited tablespace to user01
drop user user02
drop tablespace tabsp02 including contents and datafiles cascade constraints
create tablespace tabsp02 datafile '/opt/oracle/oradata/ORCLCDB/pdb02/user02.dbf' size 100m autoextend on next 500k maxsize unlimited
create user user02 identified by "ORACLE_PWD" default tablespace tabsp02 temporary tablespace temp
grant dba to user02
grant unlimited tablespace to user02
drop user user03
drop tablespace tabsp03 including contents and datafiles cascade constraints
create tablespace tabsp03 datafile '/opt/oracle/oradata/ORCLCDB/pdb02/user03.dbf' size 100m autoextend on next 500k maxsize unlimited
create user user03 identified by "ORACLE_PWD" default tablespace tabsp03 temporary tablespace temp
grant dba to user03
grant unlimited tablespace to user03

PL/SQLプロシージャが正常に完了しました。

経過: 00:00:02.72
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0との接続が切断されました。

real	0m3.032s
user	0m0.011s
sys	0m0.008s
[oracle@30bf33351a1f ~]$tree /opt/oracle/oradata/ORCLCDB/
/opt/oracle/oradata/ORCLCDB/
|-- control01.ctl
|-- control02.ctl
|-- pdb01
|   |-- sysaux01.dbf
|   |-- system01.dbf
|   |-- temp012019-09-14_20-47-33-328-PM.dbf
|   |-- undotbs01.dbf
|   |-- user01.dbf
|   `-- user02.dbf
|-- pdb02
|   |-- sysaux01.dbf
|   |-- system01.dbf
|   |-- temp012019-09-14_20-47-33-328-PM.dbf
|   |-- undotbs01.dbf
|   |-- user01.dbf
|   |-- user02.dbf
|   `-- user03.dbf
|-- pdbseed
|   |-- sysaux01.dbf
|   |-- system01.dbf
|   |-- temp012019-09-14_20-47-33-328-PM.dbf
|   `-- undotbs01.dbf
|-- redo01.log
|-- redo02.log
|-- redo03.log
|-- sysaux01.dbf
|-- system01.dbf
|-- temp01.dbf
|-- undotbs01.dbf
`-- users01.dbf

3 directories, 27 files
```

# sqlplusから接続
これでもいいし
```
sqlplus sys/ORACLE_PWD@ORCLCDB as sysdba
sqlplus sys/ORACLE_PWD@ORCLPDB01 as sysdba
sqlplus sys/ORACLE_PWD@ORCLPDB02 as sysdba
sqlplus user01/ORACLE_PWD@ORCLPDB01
sqlplus user02/ORACLE_PWD@ORCLPDB01
sqlplus user01/ORACLE_PWD@ORCLPDB02
sqlplus user02/ORACLE_PWD@ORCLPDB02
sqlplus user03/ORACLE_PWD@ORCLPDB02
```
これでもいい
```
sqlplus sys/ORACLE_PWD@localhost:1521/ORCLCDB as sysdba
sqlplus sys/ORACLE_PWD@localhost:1521/ORCLPDB01 as sysdba
sqlplus sys/ORACLE_PWD@localhost:1521/ORCLPDB02 as sysdba
sqlplus user01/ORACLE_PWD@localhost:1521/ORCLPDB01
sqlplus user02/ORACLE_PWD@localhost:1521/ORCLPDB01
sqlplus user01/ORACLE_PWD@localhost:1521/ORCLPDB02
sqlplus user02/ORACLE_PWD@localhost:1521/ORCLPDB02
sqlplus user03/ORACLE_PWD@localhost:1521/ORCLPDB02
```
実行例
```
[oracle@30bf33351a1f ~]$sqlplus sys/ORACLE_PWD@localhost:1521/ORCLCDB as sysdba

SQL*Plus: Release 19.0.0.0.0 - Production on 土 9月 14 21:47:03 2019
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.



Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
に接続されました。
SYS@localhost:1521/ORCLCDB> show con_name

CON_NAME
------------------------------
CDB$ROOT
SYS@localhost:1521/ORCLCDB> show pdbs

       CON_ID CON_NAME                       OPEN MODE  RESTRICTED
------------- ------------------------------ ---------- ----------
            2 PDB$SEED                       READ ONLY  NO
            3 ORCLPDB01                      READ WRITE NO
            4 ORCLPDB02                      READ WRITE NO
SYS@localhost:1521/ORCLCDB> Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0との接続が切断されました。
[oracle@30bf33351a1f ~]$sqlplus sys/ORACLE_PWD@localhost:1521/ORCLPDB01 as sysdba

SQL*Plus: Release 19.0.0.0.0 - Production on 土 9月 14 21:47:23 2019
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.



Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
に接続されました。
SYS@localhost:1521/ORCLPDB01> show con_name

CON_NAME
------------------------------
ORCLPDB01
SYS@localhost:1521/ORCLPDB01> Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0との接続が切断されました。
[oracle@30bf33351a1f ~]$sqlplus sys/ORACLE_PWD@localhost:1521/ORCLPDB02 as sysdba

SQL*Plus: Release 19.0.0.0.0 - Production on 土 9月 14 21:47:44 2019
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.



Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
に接続されました。
SYS@localhost:1521/ORCLPDB02> show con_name

CON_NAME
------------------------------
ORCLPDB02
SYS@localhost:1521/ORCLPDB02> Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0との接続が切断されました。
[oracle@30bf33351a1f ~]$sqlplus user01/ORACLE_PWD@localhost:1521/ORCLPDB01

SQL*Plus: Release 19.0.0.0.0 - Production on 土 9月 14 21:50:09 2019
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.



Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
に接続されました。
USER01@localhost:1521/ORCLPDB01> show con_name

CON_NAME
------------------------------
ORCLPDB01
USER01@localhost:1521/ORCLPDB01> Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0との接続が切断されました。
[oracle@30bf33351a1f ~]$sqlplus user02/ORACLE_PWD@localhost:1521/ORCLPDB01

SQL*Plus: Release 19.0.0.0.0 - Production on 土 9月 14 21:50:34 2019
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.



Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
に接続されました。
USER02@localhost:1521/ORCLPDB01> show con_name

CON_NAME
------------------------------
ORCLPDB01
USER02@localhost:1521/ORCLPDB01> Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0との接続が切断されました。
[oracle@30bf33351a1f ~]$sqlplus user01/ORACLE_PWD@localhost:1521/ORCLPDB02

SQL*Plus: Release 19.0.0.0.0 - Production on 土 9月 14 21:50:45 2019
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.



Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
に接続されました。
USER01@localhost:1521/ORCLPDB02> show con_name

CON_NAME
------------------------------
ORCLPDB02
USER01@localhost:1521/ORCLPDB02> Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0との接続が切断されました。
[oracle@30bf33351a1f ~]$sqlplus user02/ORACLE_PWD@localhost:1521/ORCLPDB02

SQL*Plus: Release 19.0.0.0.0 - Production on 土 9月 14 21:51:24 2019
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.



Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
に接続されました。
USER02@localhost:1521/ORCLPDB02> show con_name

CON_NAME
------------------------------
ORCLPDB02
USER02@localhost:1521/ORCLPDB02> Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0との接続が切断されました。
[oracle@30bf33351a1f ~]$sqlplus user03/ORACLE_PWD@localhost:1521/ORCLPDB02

SQL*Plus: Release 19.0.0.0.0 - Production on 土 9月 14 21:51:34 2019
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.



Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
に接続されました。
USER03@localhost:1521/ORCLPDB02> show con_name

CON_NAME
------------------------------
ORCLPDB02
USER03@localhost:1521/ORCLPDB02> Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0との接続が切断されました。
```

# sqldeveloperから接続
```
[oracle@30bf33351a1f ~]$sqldev
[1] 4432
```
![](./1.png)
![](./2.png)

# sqlclから接続
SYSユーザーの「as sysdba付与して接続」がアンドキュメント。たぶん。
```
[oracle@30bf33351a1f ~]$sql sql:oracle://user01:ORACLE_PWD@localhost:1521/ORCLPDB01

SQL*Plus: Release 19.0.0.0.0 - Production on 土 9月 14 22:02:35 2019
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

最終正常ログイン時間: 土 9月  14 2019 21:56:56 +09:00


Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
に接続されました。
USER01@ORCLPDB01> show con_name

CON_NAME
------------------------------
ORCLPDB01
USER01@ORCLPDB01> Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0との接続が切断されました。
[oracle@30bf33351a1f ~]$sql sql:oracle://user02:ORACLE_PWD@localhost:1521/ORCLPDB01

SQL*Plus: Release 19.0.0.0.0 - Production on 土 9月 14 22:03:08 2019
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

最終正常ログイン時間: 土 9月  14 2019 21:57:15 +09:00


Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
に接続されました。
USER02@ORCLPDB01> show con_name

CON_NAME
------------------------------
ORCLPDB01
USER02@ORCLPDB01> Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0との接続が切断されました。
[oracle@30bf33351a1f ~]$sql sql:oracle://user01:ORACLE_PWD@localhost:1521/ORCLPDB02

SQL*Plus: Release 19.0.0.0.0 - Production on 土 9月 14 22:03:21 2019
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

最終正常ログイン時間: 土 9月  14 2019 21:59:42 +09:00


Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
に接続されました。
USER01@ORCLPDB02> show con_name

CON_NAME
------------------------------
ORCLPDB02
USER01@ORCLPDB02> Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0との接続が切断されました。
[oracle@30bf33351a1f ~]$sql sql:oracle://user02:ORACLE_PWD@localhost:1521/ORCLPDB02

SQL*Plus: Release 19.0.0.0.0 - Production on 土 9月 14 22:03:30 2019
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

最終正常ログイン時間: 土 9月  14 2019 21:57:44 +09:00


Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
に接続されました。
USER02@ORCLPDB02> show con_name

CON_NAME
------------------------------
ORCLPDB02
USER02@ORCLPDB02> Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0との接続が切断されました。
[oracle@30bf33351a1f ~]$sql sql:oracle://user03:ORACLE_PWD@localhost:1521/ORCLPDB02

SQL*Plus: Release 19.0.0.0.0 - Production on 土 9月 14 22:03:38 2019
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

最終正常ログイン時間: 土 9月  14 2019 21:57:52 +09:00


Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
に接続されました。
USER03@ORCLPDB02> show con_name

CON_NAME
------------------------------
ORCLPDB02
USER03@ORCLPDB02> Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0との接続が切断されました。
[oracle@30bf33351a1f ~]$
```

# Rライブラリ
ここらへんRstudioでいじってみてもおもろそう
以下を参考に。
[超高速な機械学習を Oracle Database で実現！](https://www.slideshare.net/oracle4engineer/hikalab-20171026)
```
[root@be807f28f5bd /opt/oracle/product/19c/dbhome_1/R]$pwd
/opt/oracle/product/19c/dbhome_1/R
[root@be807f28f5bd /opt/oracle/product/19c/dbhome_1/R]$ll
total 12
drwxr-xr-x. 15 oracle oinstall 4096  9月  9 22:11 library
drwxr-xr-x.  5 oracle oinstall 4096  9月  9 22:11 migration
drwxr-xr-x.  2 oracle oinstall 4096  9月  9 22:11 server
[root@be807f28f5bd /opt/oracle/product/19c/dbhome_1/R]$find . -name "*ja*"
./library/OREdm/doc/man/ja
./library/ORExml/doc/man/ja
./library/OREbase/doc/man/ja
./library/OREmodels/doc/man/ja
./library/ORE/doc/man/ja
./library/OREgraphics/doc/man/ja
./library/OREembed/doc/man/ja
./library/OREeda/doc/man/ja
./library/OREstats/doc/man/ja
./library/OREpredict/doc/man/ja
```

# 参考文献
```
https://www.sql-dbtips.com/architecture/orapwd/
https://oracle-base.com/articles/19c/oracle-db-19c-rpm-installation-on-oracle-linux-7
https://github.com/oraclebase/dockerfiles/tree/master/database/ol7_19
https://qiita.com/s-sasaki/items/cb768bd00d3588f494d4#%E6%9C%AA%E8%A7%A3%E6%B1%BA
https://qiita.com/manymanyuni/items/ee2a3b9032750fdf5d72#%E3%83%AC%E3%82%B9%E3%83%9D%E3%83%B3%E3%82%B9%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB
http://tamasaban.blog.fc2.com/blog-entry-40.html
https://docs.oracle.com/en/database/oracle/oracle-database/19/ladbi/running-rpm-packages-to-install-oracle-database.html#GUID-BB7C11E3-D385-4A2F-9EAF-75F4F0AACF02
https://qiita.com/mon_tu/items/6726524e738071afb7a7
https://heavywatal.github.io/cxx/gcc.html
https://orablogs-jp.blogspot.com/2016/07/creating-and-oracle-database-docker.html
https://qiita.com/yahihi/items/351018be17585f28926b
http://sugimura.cc/pukiwiki/?%E6%8A%80%E8%A1%93%E6%96%87%E6%9B%B8%2FOracle%2F11g%2F%E3%83%A1%E3%83%A2%E3%83%AA%E3%81%AE%E8%A8%AD%E5%AE%9A
```
