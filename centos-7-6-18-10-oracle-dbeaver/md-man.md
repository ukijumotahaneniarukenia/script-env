[oracle19cr3](https://www.oracle.com/technetwork/jp/database/enterprise-edition/downloads/index.html)

[clob型のcollect集約関数の実装について](https://docs.oracle.com/cd/E82638_01/addci/using-user-defined-aggregate-functions.html#GUID-D7E77319-DC23-4CF0-B746-27ED7BE9240D)

[超高速な機械学習を Oracle Database で実現！](https://www.slideshare.net/oracle4engineer/hikalab-20171026)

- sqlplusから接続
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

ないしは

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
```
