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

# Dockerfileよりイメージ作成
```
time docker build -t centos_oracle . | tee log
```

# dockerコンテナ削除
```
docker ps -qa | xargs -I@ bash -c 'docker stop @ && docker rm @'
```

# dockerイメージ削除
```
docker images | awk '$1=="<none>"{print $3}' | xargs -I@ docker rmi @
```

# dockerコンテナ起動
```
docker run --privileged -v /etc/localtime:/etc/localtime -p 28787:8787 -p 1521:1521 -p 5500:5500 -itd --name oracle --shm-size=8g centos_oracle /sbin/init
```

# dockerコンテナ潜入

```
docker exec --user root -it oracle /bin/bash
```

```
[oracle@ee5b841469f7 /]$ touch /u01/app/oracle/product/19.0.0/dbhome_1/dbs/ora_control1
[oracle@ee5b841469f7 /]$ touch /u01/app/oracle/product/19.0.0/dbhome_1/dbs/ora_control2
```

# 起動と停止
```
[oracle@a0b2f32dfc3a /]$sqlplus / as sysdba

SQL*Plus: Release 19.0.0.0.0 - Production on Mon Sep 9 20:35:55 2019
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.


Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> select banner_full from v$version;

BANNER_FULL
--------------------------------------------------------------------------------
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0


SQL> shutdown
Database closed.
Database dismounted.
ORACLE instance shut down.
SQL> startup
ORACLE instance started.

Total System Global Area 1.0033E+10 bytes
Fixed Size		   12685360 bytes
Variable Size		 1677721600 bytes
Database Buffers	 8321499136 bytes
Redo Buffers		   20865024 bytes
Database mounted.
Database opened.
```

# oracleユーザーで接続
パスワード変更する
```
[oracle@a0b2f32dfc3a /]$sqlplus / as sysdba

SQL*Plus: Release 19.0.0.0.0 - Production on Mon Sep 9 20:16:57 2019
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Connected to an idle instance.

SQL> startup
ORACLE instance started.

Total System Global Area 1.0033E+10 bytes
Fixed Size		   12685360 bytes
Variable Size		 1677721600 bytes
Database Buffers	 8321499136 bytes
Redo Buffers		   20865024 bytes
Database mounted.
Database opened.
SQL> 
SQL> select banner_full from v$version;

BANNER_FULL
--------------------------------------------------------------------------------
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0


SQL> show pdbs;

    CON_ID CON_NAME			  OPEN MODE  RESTRICTED
---------- ------------------------------ ---------- ----------
	 2 PDB$SEED			  READ ONLY  NO
	 3 ORCLPDB1			  MOUNTED

```

# sysパスワードを変更する
sysユーザーはalter文ではだめ。
```
[oracle@a0b2f32dfc3a /]$sudo find / -name "*orapwd*" | grep ora
/opt/oracle/product/19c/dbhome_1/bin/orapwd
[oracle@a0b2f32dfc3a /]$/opt/oracle/product/19c/dbhome_1/bin/orapwd --help
Usage 1: orapwd file=<fname> force={y|n} asm={y|n}
          dbuniquename=<dbname> format={12|12.2}
          delete={y|n} input_file=<input-fname>
          'sys={y | password | external(<sys-external-name>)
                | global(<sys-directory-DN>)}'
          'sysbackup={y | password | external(<sysbackup-external-name>)
                      | global(<sysbackup-directory-DN>)}'
          'sysdg={y | password | external(<sysdg-external-name>)
                  | global(<sysdg-directory-DN>)}'
          'syskm={y | password | external(<syskm-external-name>)
                  | global(<syskm-directory-DN>)}'

Usage 2: orapwd describe file=<fname>

  where
    file   - name of password file (required),
    password
           - password for SYS will be prompted
             if not specified at command line.
             Ignored, if input_file is specified,
    force  - whether to overwrite existing file (optional),
    asm    - indicates that the password to be stored in
             Automatic Storage Management (ASM) disk group
             is an ASM password. (optional),
    dbuniquename
           - unique database name used to identify database
             password files residing in ASM diskgroup only.
             Ignored when asm option is specified (optional),
    format - use format=12 for new 12c features like SYSBACKUP, SYSDG
             and SYSKM support, longer identifiers, SHA2 Verifiers etc.
             use format=12.2 for 12.2 features like enforcing user 
             profile (password limits and password complexity) and 
             account status for administrative users.
             If not specified, format=12.2 is default (optional),
    delete - drops a password file. Must specify 'asm',
             'dbuniquename' or 'file'. If 'file' is specified,
             the file must be located on an ASM diskgroup (optional),
    input_file
           - name of input password file, from where old user
             entries will be migrated (optional),
    sys    - specifies if SYS user is password, externally or 
             globally authenticated.
             For external SYS, also specifies external name.
             For global SYS, also specifies directory DN.
             SYS={y | password} specifies if SYS user password needs
             to be changed when used with input_file,
    sysbackup
           - creates SYSBACKUP entry (optional).
             Specifies if SYSBACKUP user is password, externally or
             globally authenticated.
             For external SYSBACKUP, also specifies external name.
             For global SYSBACKUP, also specifies directory DN.
             Ignored, if input_file is specified,
    sysdg  - creates SYSDG entry (optional).
             Specifies if SYSDG user is password, externally or
             globally authenticated.
             For external SYSDG, also specifies external name.
             For global SYSDG, also specifies directory DN.
             Ignored, if input_file is specified,
    syskm  - creates SYSKM entry (optional).
             Specifies if SYSKM user is password, externally or
             globally authenticated.
             For external SYSKM, also specifies external name.
             For global SYSKM, also specifies directory DN.
            Ignored, if input_file is specified,
    describe
           - describes the properties of specified password file
             (required).


  There must be no spaces around the equal-to (=) character.
```

```
SQL> select username from dba_users where username like 'SYS%';

USERNAME
--------------------------------------------------------------------------------
SYS
SYSTEM
SYSBACKUP
SYSRAC
SYSKM
SYS$UMF
SYSDG

7 rows selected.

```

```
[oracle@a0b2f32dfc3a ~]$ll
total 4
-rw-r--r--. 1 oracle oinstall 2233  9月  9 20:09 installer.sh
[oracle@a0b2f32dfc3a ~]$orapwd file=oracle_sys_pwd force=y password=ukijumotahaneniarukenia#1
[oracle@a0b2f32dfc3a ~]$ll
total 12
-rw-r--r--. 1 oracle oinstall 2233  9月  9 20:09 installer.sh
-rw-r-----. 1 oracle oinstall 6144  9月  9 21:12 oracle_sys_pwd
[oracle@a0b2f32dfc3a ~]$sqlplus sys/ukijumotahaneniarukenia#1 as sysdba

SQL*Plus: Release 19.0.0.0.0 - Production on Mon Sep 9 21:14:21 2019
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.


Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> select banner_full from v$version;

BANNER_FULL
--------------------------------------------------------------------------------
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

[oracle@a0b2f32dfc3a ~]$sqlplus system/ukijumotahaneniarukenia#1 as sysdba

SQL*Plus: Release 19.0.0.0.0 - Production on Mon Sep 9 21:17:21 2019
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.


Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> select banner_full from v$version;

BANNER_FULL
--------------------------------------------------------------------------------
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0


SQL> 
[oracle@a0b2f32dfc3a ~]$sqlplus sysbackup/ukijumotahaneniarukenia#1 as sysdba

SQL*Plus: Release 19.0.0.0.0 - Production on Mon Sep 9 21:19:49 2019
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.


Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> select banner_full from v$version;

BANNER_FULL
--------------------------------------------------------------------------------
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0


SQL> 
[oracle@a0b2f32dfc3a ~]$sqlplus sysrac/ukijumotahaneniarukenia#1 as sysdba

SQL*Plus: Release 19.0.0.0.0 - Production on Mon Sep 9 21:20:41 2019
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.


Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> select banner_full from v$version;                   

BANNER_FULL
--------------------------------------------------------------------------------
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0


[oracle@a0b2f32dfc3a ~]$sqlplus syskm/ukijumotahaneniarukenia#1 as sysdba

SQL*Plus: Release 19.0.0.0.0 - Production on Mon Sep 9 21:21:22 2019
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.


Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> select banner_full from v$version; 

BANNER_FULL
--------------------------------------------------------------------------------
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

[oracle@a0b2f32dfc3a ~]$sqlplus sys$umf/ukijumotahaneniarukenia#1 as sysdba

SQL*Plus: Release 19.0.0.0.0 - Production on Mon Sep 9 21:22:03 2019
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.


Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> select banner_full from v$version;

BANNER_FULL
--------------------------------------------------------------------------------
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0


[oracle@a0b2f32dfc3a ~]$sqlplus sysdg/ukijumotahaneniarukenia#1 as sysdba

SQL*Plus: Release 19.0.0.0.0 - Production on Mon Sep 9 21:22:40 2019
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.


Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0

SQL> select banner_full from v$version;

BANNER_FULL
--------------------------------------------------------------------------------
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.3.0.0.0




```
