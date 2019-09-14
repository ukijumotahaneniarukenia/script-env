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
[oracle@b3eda71dd3ec ~]$./init_db.sh configure
```

# PDB作成
作成するPDB数を指定
```
[oracle@b3eda71dd3ec ~]$./init_db.sh create 2
```

# sqlplusから接続
```
sqlplus sys/ORACLE_PWD@localhost:1521/ORCLCDB as sysdba
sqlplus sys/ORACLE_PWD@localhost:1521/ORCLPDB01 as sysdba
sqlplus sys/ORACLE_PWD@localhost:1521/ORCLPDB02 as sysdba
sqlplus pdb01/oracle_pwd@localhost:1521/ORCLPDB01
sqlplus pdb02/oracle_pwd@localhost:1521/ORCLPDB02
```

# sqldeveloperから接続
![](./1.png)
![](./2.png)
![](./3.png)
![](./4.png)
![](./5.png)
![](./6.png)

# sqlclでも接続確認
?クエリパラメータはなぜか標準出力に吐かれない。
標準入力で与える場合は標準出力に吐かれる。
SYSユーザーの「as sysdba付与して接続」がアンドキュメント。たぶん。
```
[root@be807f28f5bd /]$sql --version
GNU sql 20190822
Copyright (C) 2009,2010,2011,2012,2013,2014,2015,2016,2017
Ole Tange and Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
GNU sql comes with no warranty.

Web site: http://www.gnu.org/software/sql

When using GNU sql for a publication please cite:

O. Tange (2011): GNU SQL - A Command Line Tool for Accessing Different
Databases Using DBURLs, ;login: The USENIX Magazine, April 2011:29-32.
```
## SYSユーザー以外でPDB接続
```
[oracle@be807f28f5bd ~]$man sql | grep oracle
        sql:oracle://scott:tiger@ora.example.com/xe
       Currently supported vendors: MySQL (mysql), MySQL with SSL (mysqls, mysqlssl), Oracle (oracle, ora), PostgreSQL (postgresql, pg, pgsql, postgres), PostgreSQL with SSL
       sql sql:oracle://scott:tiger@ora.example.com/xe
[oracle@be807f28f5bd ~]$man sql | grep ?
       dburl    A DBURL has the following syntax: [sql:]vendor:// [[user][:password]@][host][:port]/[database][?sqlquery]
       A DBURL has the following syntax: [sql:]vendor:// [[user][:password]@][host][:port]/[database][?sqlquery]
        sql:sqlite2:////tmp/db.sqlite?SELECT * FROM foo;
        sqlite3:///../db.sqlite3?SELECT%20*%20FROM%20foo;
        :query  sqlite:////tmp/db.sqlite?SELECT * FROM foo;
[oracle@be807f28f5bd ~]$sql sql:oracle://pdb12:oracle_pwd@localhost/ORCLPDB12

SQL*Plus: Release 19.0.0.0.0 - Production on Wed Sep 11 02:20:39 2019
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

??????????: ?  9?   11 2019 02:19:36 +09:00


Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0
?????????
SQL> select banner_full from v$version;

BANNER_FULL
----------------------------------------------------------------------------------------------------------------------------------------------------------------
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production

SQL> Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0?????????????
[oracle@be807f28f5bd ~]$sql sql:oracle://pdb01:oracle_pwd@localhost/ORCLPDB01?select banner_full from v$version;

[oracle@be807f28f5bd /]$echo "select banner_full from v\$version;" | sql sql:oracle://pdb01:oracle_pwd@localhost/ORCLPDB01

BANNER_FULL
----------------------------------------------------------------------------------------------------------------------------------------------------------------
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production


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
