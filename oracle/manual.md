# ここがめちゃおもしろそう
ホスト側から見える
64桁のようだ
```
[rstudio@centos ~/unko/script_scratch/oracle]$echo 127c8230c0d3a21df7e836315d0a46103618b35f892e0196107f294f6041f8ef  | awk '{print length($0)}'
64
```

```
[rstudio@centos ~/unko/script_scratch/oracle]$sudo ls -l /var/lib/docker/volumes
合計 72
drwxr-xr-x. 3 root root  4096  9月  7 09:43 127c8230c0d3a21df7e836315d0a46103618b35f892e0196107f294f6041f8ef
drwxr-xr-x. 3 root root  4096  5月 25 13:14 4f69bcaf6ee32bfefb90229fde873c5a8f2c9f1bb4d3f0f6e4404e3d14daae39
drwxr-xr-x. 3 root root  4096  8月  4 11:59 4fd825fb61b8548aae16c9b413fe265c10a2dd11edbbf83e1e398a4e96e8be73
drwxr-xr-x. 3 root root  4096  9月  7 00:58 65f9459099a0c97ed177af9d9694d7a0c2a1324806297b81f18bcb764a05822e
drwxr-xr-x. 3 root root  4096  8月 14 14:26 7f6fac0ff0889591f7f8a1546c2d9ffbde762193de6453bcc34f1cc60462bd87
drwxr-xr-x. 3 root root  4096  6月  3 06:33 9dad4716bab2a09051b959512d64bf4663175c0e183e226965ff111eaa620433
drwxr-xr-x. 3 root root  4096  8月 14 14:25 b6b552aebf30486c2769d37b39f67a0024c87157a953416f68e19cae5167ec94
drwxr-xr-x. 3 root root  4096  8月 14 14:27 bc53c8fd16447592e678810c5ea680a279937e6f8ad179888f8123e03742f22d
drwxr-xr-x. 3 root root  4096  9月  7 12:55 cf41cda337a0e4c57861576e665a6105216cdd0e584814d24cf0bab355eb22de
drwxr-xr-x. 3 root root  4096  9月  7 12:24 d616f33f3073e16cb395f235d6965343d3300272b8bdeb7d78f726cc4b541655
-rw-------. 1 root root 65536  9月  7 12:55 metadata.db
[rstudio@centos ~/unko/script_scratch/oracle]$sudo ls -l /var/lib/docker/volumes/127c8230c0d3a21df7e836315d0a46103618b35f892e0196107f294f6041f8ef
合計 4
drwxr-xr-x. 4 54321 54322 4096  9月  7 09:56 _data
[rstudio@centos ~/unko/script_scratch/oracle]$sudo ls -l /var/lib/docker/volumes/127c8230c0d3a21df7e836315d0a46103618b35f892e0196107f294f6041f8ef/_data
合計 8
drwxr-x---. 4 54321 54321 4096  9月  7 09:45 ORCL
drwxr-xr-x. 3 54321 54321 4096  9月  7 09:56 dbconfig
[rstudio@centos ~/unko/script_scratch/oracle]$sudo ls -l /var/lib/docker/volumes/127c8230c0d3a21df7e836315d0a46103618b35f892e0196107f294f6041f8ef/_data/ORCL
合計 2469676
drwxr-x---. 2 54321 54321      4096  9月  7 09:56 PDB1
-rw-r-----. 1 54321 54321  18726912  9月  7 11:08 control01.ctl
-rw-r-----. 1 54321 54321  18726912  9月  7 11:08 control02.ctl
drwxr-x---. 2 54321 54321      4096  9月  7 09:47 pdbseed
-rw-r-----. 1 54321 54321 209715712  9月  7 11:08 redo01.log
-rw-r-----. 1 54321 54321 209715712  9月  7 09:56 redo02.log
-rw-r-----. 1 54321 54321 209715712  9月  7 09:56 redo03.log
-rw-r-----. 1 54321 54321 566239232  9月  7 11:08 sysaux01.dbf
-rw-r-----. 1 54321 54321 933240832  9月  7 11:08 system01.dbf
-rw-r-----. 1 54321 54321  33562624  9月  7 09:49 temp01.dbf
-rw-r-----. 1 54321 54321 356524032  9月  7 11:08 undotbs01.dbf
-rw-r-----. 1 54321 54321   5251072  9月  7 11:08 users01.dbf
[rstudio@centos ~/unko/script_scratch/oracle]$docker system prune --volumes
WARNING! This will remove:
        - all stopped containers
        - all networks not used by at least one container
        - all volumes not used by at least one container
        - all dangling images
        - all dangling build cache
Are you sure you want to continue? [y/N] y
Deleted Volumes:
127c8230c0d3a21df7e836315d0a46103618b35f892e0196107f294f6041f8ef
9dad4716bab2a09051b959512d64bf4663175c0e183e226965ff111eaa620433
d616f33f3073e16cb395f235d6965343d3300272b8bdeb7d78f726cc4b541655
4f69bcaf6ee32bfefb90229fde873c5a8f2c9f1bb4d3f0f6e4404e3d14daae39
4fd825fb61b8548aae16c9b413fe265c10a2dd11edbbf83e1e398a4e96e8be73
65f9459099a0c97ed177af9d9694d7a0c2a1324806297b81f18bcb764a05822e
7f6fac0ff0889591f7f8a1546c2d9ffbde762193de6453bcc34f1cc60462bd87
b6b552aebf30486c2769d37b39f67a0024c87157a953416f68e19cae5167ec94
bc53c8fd16447592e678810c5ea680a279937e6f8ad179888f8123e03742f22d
cf41cda337a0e4c57861576e665a6105216cdd0e584814d24cf0bab355eb22de

Total reclaimed space: 26.42GB
[rstudio@centos ~/unko/script_scratch/oracle]$sudo ls -l /var/lib/docker/volumes/
合計 32
-rw-------. 1 root root 65536  9月  9 11:22 metadata.db

```

# 参考文献

gccをビルドすればいいのかな。あるいはインストール。

/u01/app/oracle/product/19.0.0/dbhome_1/install/

```
https://github.com/oraclebase/dockerfiles/tree/master/database/ol7_19
https://qiita.com/s-sasaki/items/cb768bd00d3588f494d4#%E6%9C%AA%E8%A7%A3%E6%B1%BA
https://qiita.com/manymanyuni/items/ee2a3b9032750fdf5d72#%E3%83%AC%E3%82%B9%E3%83%9D%E3%83%B3%E3%82%B9%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB
http://tamasaban.blog.fc2.com/blog-entry-40.html
https://heavywatal.github.io/cxx/gcc.html
```
dockerのdiskサイズを拡張したい時のヒント
```
https://orablogs-jp.blogspot.com/2016/07/creating-and-oracle-database-docker.html
```
dockerホストでのディスク拡張
```
https://qiita.com/yahihi/items/351018be17585f28926b
```
```
[rstudio@centos ~/unko/script_scratch/oracle]$du -sh /* 2>/dev/null | sort -rg
815M	/opt
126M	/boot
27M	/etc
16K	/lost+found
8.6G	/home
6.4G	/usr
5.1M	/tmp
4.5G	/var
4.0K	/srv
4.0K	/root
4.0K	/mnt
4.0K	/media
4.0K	/grp
2.0M	/run
0	/sys
0	/sbin
0	/proc
0	/lib64
0	/lib
0	/g
0	/dev
0	/bin
```

```
[rstudio@centos ~/unko/script_scratch/oracle]$df -h
ファイルシス   サイズ  使用  残り 使用% マウント位置
/dev/nvme0n1p2   455G   52G  380G   13% /
devtmpfs          16G     0   16G    0% /dev
tmpfs             16G  157M   16G    1% /dev/shm
tmpfs             16G   26M   16G    1% /run
tmpfs             16G     0   16G    0% /sys/fs/cgroup
/dev/nvme0n1p1   283M  136M  129M   52% /boot
tmpfs            3.2G  4.0K  3.2G    1% /run/user/42
tmpfs            3.2G   64K  3.2G    1% /run/user/1001
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
docker run --privileged -v /etc/localtime:/etc/localtime -p 1521:1521 --name oracle -itd centos_oracle /sbin/init
[rstudio@centos ~/unko/script_scratch/oracle]$docker run --privileged -itd --name oracle --shm-size=8g centos_oracle /sbin/init
```

# dockerコンテナ潜入

```
docker exec --user root -it mysql /bin/bash
```

# レスポンスファイル調査
```
[root@16d45a3b9f2c /]# find / -name "*db_install.rsp*"
/u01/app/oracle/product/19.0.0/dbhome_1/inventory/response/db_install.rsp
/u01/app/oracle/product/19.0.0/dbhome_1/install/response/db_install.rsp
[root@16d45a3b9f2c /]# ll /u01/app/oracle/product/19.0.0/dbhome_1/inventory/response/db_install.rsp
-rw-r-----. 1 root root 19932  2月  6  2019 /u01/app/oracle/product/19.0.0/dbhome_1/inventory/response/db_install.rsp
[root@16d45a3b9f2c /]# ll /u01/app/oracle/product/19.0.0/dbhome_1/install/response/db_install.rsp
-rw-r--r--. 1 root root 19932  2月  6  2019 /u01/app/oracle/product/19.0.0/dbhome_1/install/response/db_install.rsp
[root@16d45a3b9f2c /]# diff /u01/app/oracle/product/19.0.0/dbhome_1/install/response/db_install.rsp /u01/app/oracle/product/19.0.0/dbhome_1/install/response/db_install.rsp
[root@16d45a3b9f2c /]# 
```

設定項目
```
[root@16d45a3b9f2c /]# cat /u01/app/oracle/product/19.0.0/dbhome_1/install/response/db_install.rsp | awk '!/^#/{print}' | awk 'NF'
oracle.install.responseFileVersion=/oracle/install/rspfmt_dbinstall_response_schema_v19.0.0
oracle.install.option=
UNIX_GROUP_NAME=
INVENTORY_LOCATION=
ORACLE_HOME=
ORACLE_BASE=
oracle.install.db.InstallEdition=
oracle.install.db.OSDBA_GROUP=
oracle.install.db.OSOPER_GROUP=
oracle.install.db.OSBACKUPDBA_GROUP=
oracle.install.db.OSDGDBA_GROUP=
oracle.install.db.OSKMDBA_GROUP=
oracle.install.db.OSRACDBA_GROUP=
oracle.install.db.rootconfig.executeRootScript=
oracle.install.db.rootconfig.configMethod=
oracle.install.db.rootconfig.sudoPath=
oracle.install.db.rootconfig.sudoUserName=
oracle.install.db.CLUSTER_NODES=
oracle.install.db.config.starterdb.type=
oracle.install.db.config.starterdb.globalDBName=
oracle.install.db.config.starterdb.SID=
oracle.install.db.ConfigureAsContainerDB=
oracle.install.db.config.PDBName=
oracle.install.db.config.starterdb.characterSet=
oracle.install.db.config.starterdb.memoryOption=
oracle.install.db.config.starterdb.memoryLimit=
oracle.install.db.config.starterdb.installExampleSchemas=
oracle.install.db.config.starterdb.password.ALL=
oracle.install.db.config.starterdb.password.SYS=
oracle.install.db.config.starterdb.password.SYSTEM=
oracle.install.db.config.starterdb.password.DBSNMP=
oracle.install.db.config.starterdb.password.PDBADMIN=
oracle.install.db.config.starterdb.managementOption=
oracle.install.db.config.starterdb.omsHost=
oracle.install.db.config.starterdb.omsPort=
oracle.install.db.config.starterdb.emAdminUser=
oracle.install.db.config.starterdb.emAdminPassword=
oracle.install.db.config.starterdb.enableRecovery=
oracle.install.db.config.starterdb.storageType=
oracle.install.db.config.starterdb.fileSystemStorage.dataLocation=
oracle.install.db.config.starterdb.fileSystemStorage.recoveryLocation=
oracle.install.db.config.asm.diskGroup=
oracle.install.db.config.asm.ASMSNMPPassword=
```

# makeログ
```
[root@94477e48dcad /]# vi /u01/app/oracle/product/19.0.0/dbhome_1/install/make.log
[root@94477e48dcad /]# grep cannot /u01/app/oracle/product/19.0.0/dbhome_1/install/make.log
/usr/bin/ld: cannot find /usr/lib64/crti.o: No such file or directory
/usr/bin/ld: cannot find /usr/lib64/libc_nonshared.a
```

# 言語別のR関数群
Rの使い方ヒントありそう
```
[root@8edecc5fa34c library]# pwd
/u01/app/oracle/product/19.0.0/dbhome_1/R/library
[root@8edecc5fa34c library]# ll
total 68
drwxrwxr-x. 7 oracle oinstall 4096  4月 17 19:44 ORE
drwxrwxr-x. 7 oracle oinstall 4096  4月 17 19:44 OREbase
drwxrwxr-x. 1 oracle oinstall 4096  4月 17 19:44 OREcommon
drwxrwxr-x. 7 oracle oinstall 4096  4月 17 19:44 OREdm
drwxrwxr-x. 1 oracle oinstall 4096  9月  9 13:22 OREdplyr
drwxrwxr-x. 1 oracle oinstall 4096  4月 17 19:44 OREeda
drwxrwxr-x. 7 oracle oinstall 4096  4月 17 19:44 OREembed
drwxrwxr-x. 8 oracle oinstall 4096  4月 17 19:44 OREgraphics
drwxrwxr-x. 8 oracle oinstall 4096  4月 17 19:44 OREmodels
drwxrwxr-x. 7 oracle oinstall 4096  4月 17 19:44 OREpredict
drwxrwxr-x. 7 oracle oinstall 4096  4月 17 19:44 OREserver
drwxrwxr-x. 1 oracle oinstall 4096  4月 17 19:44 OREstats
drwxrwxr-x. 7 oracle oinstall 4096  4月 17 19:44 ORExml
```

# ログ洗い出し
```
[root@8edecc5fa34c /]# find / -name "*log" | grep oracle
/u01/app/oracle/product/19.0.0/dbhome_1/rdbms/log
/u01/app/oracle/product/19.0.0/dbhome_1/install/root_51218c79c1d1_2019-09-09_02-50-40-560103408.log
/u01/app/oracle/product/19.0.0/dbhome_1/install/make.log
/u01/app/oracle/product/19.0.0/dbhome_1/javavm/admin/version.log
/u01/app/oracle/product/19.0.0/dbhome_1/network/log
/u01/app/oracle/product/19.0.0/dbhome_1/perl/lib/5.28.1/x86_64-linux-thread-multi/auto/Sys/Syslog
/u01/app/oracle/product/19.0.0/dbhome_1/demo/schema/log
/u01/app/oracle/product/19.0.0/dbhome_1/suptools/tfa/release/tfa_home/ext/calog
/u01/app/oracle/product/19.0.0/dbhome_1/cfgtoollogs/cfgfw/oracle.server_2019-09-09_02-50-29-AM.log
/u01/app/oracle/product/19.0.0/dbhome_1/cfgtoollogs/cfgfw/oracle.assistants.netca.client_2019-09-09_02-50-29-AM.log
/u01/app/oracle/product/19.0.0/dbhome_1/cfgtoollogs/cfgfw/OuiConfigVariables_2019-09-09_02-50-29-AM.log
/u01/app/oracle/product/19.0.0/dbhome_1/cfgtoollogs/cfgfw/CfmLogger_2019-09-09_02-50-29-AM.log
/u01/app/oracle/product/19.0.0/dbhome_1/cfgtoollogs/oui/InstallActions2019-09-09_02-49-11AM/time2019-09-09_02-49-11AM.log
/u01/app/oracle/product/19.0.0/dbhome_1/cfgtoollogs/oui/InstallActions2019-09-09_02-49-11AM/installerPatchActions_2019-09-09_02-49-11AM.log
/u01/app/oracle/product/19.0.0/dbhome_1/cfgtoollogs/oui/InstallActions2019-09-09_02-49-11AM/installActions2019-09-09_02-49-11AM.log
/u01/app/oracle/product/19.0.0/dbhome_1/hs/log
/u01/app/oracle/product/19.0.0/dbhome_1/ctx/log
/u01/app/oracle/product/19.0.0/dbhome_1/apex/images/libraries/ckeditor/4.5.11/plugins/colordialog
/u01/app/oracle/product/19.0.0/dbhome_1/apex/images/libraries/ckeditor/4.5.11/plugins/dialog
/u01/app/oracle/product/19.0.0/dbhome_1/apex/images/libraries/codemirror/5.16/mode/verilog
/u01/app/oracle/product/19.0.0/dbhome_1/apex/images/libraries/codemirror/5.16/addon/dialog

```

# init.ora見直し

```
[oracle@273cb161657a /]$ sqlplus / as sysdba

SQL*Plus: Release 19.0.0.0.0 - Production on Mon Sep 9 14:57:10 2019
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Connected to an idle instance.

SQL> startup
ORA-01078: failure in processing system parameters
LRM-00109: could not open parameter file '/u01/app/oracle/product/19.0.0/dbhome_1/dbs/initORCL.ora'
SQL> Disconnected
[oracle@273cb161657a /]$ ll /u01/app/oracle/product/19.0.0/dbhome_1/dbs/*
-rw-rw-r--. 1 oracle oinstall 3079  5月 14  2015 /u01/app/oracle/product/19.0.0/dbhome_1/dbs/init.ora
[oracle@273cb161657a /]$ vi /u01/app/oracle/product/19.0.0/dbhome_1/dbs/init.ora
```
治療
```
[oracle@273cb161657a /]$ mv /u01/app/oracle/product/19.0.0/dbhome_1/dbs/init.ora /u01/app/oracle/product/19.0.0/dbhome_1/dbs/initORCL.ora
[oracle@273cb161657a /]$ ll /u01/app/oracle/product/19.0.0/dbhome_1/dbs/*
-rw-rw-r--. 1 oracle oinstall 3079  5月 14  2015 /u01/app/oracle/product/19.0.0/dbhome_1/dbs/initORCL.ora

```
メモりあー

http://sugimura.cc/pukiwiki/?%E6%8A%80%E8%A1%93%E6%96%87%E6%9B%B8%2FOracle%2F11g%2F%E3%83%A1%E3%83%A2%E3%83%AA%E3%81%AE%E8%A8%AD%E5%AE%9A

```
[oracle@273cb161657a /]$ sqlplus / as sysdba

SQL*Plus: Release 19.0.0.0.0 - Production on Mon Sep 9 15:02:21 2019
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Connected to an idle instance.

SQL> 
SQL> 
SQL> 
SQL> startup
ORA-00845: MEMORY_TARGET not supported on this system

```

recoveryfileあー
http://signposts2k.hatenablog.com/entry/%3Fp%3D1909
```
[oracle@d135271a3410 /]$ sqlplus / as sysdba

SQL*Plus: Release 19.0.0.0.0 - Production on Mon Sep 9 15:09:48 2019
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Connected to an idle instance.

SQL> startup
ORA-01261: Parameter db_recovery_file_dest destination string cannot be translated
ORA-01262: Stat failed on a file destination directory
Linux-x86_64 Error: 2: No such file or directory

```

```
[oracle@07e4b825c15a ~]$ echo "show parameters" | sqlplus sys/ORACLE_PWD as sysdba | grep -A 2 oracle
audit_file_dest 		     string	 /opt/oracle/admin/ORCL/adump
audit_sys_operations		     boolean	 FALSE
audit_syslog_level		     string
--
background_dump_dest		     string	 /opt/oracle/product/19c/dbhome
						 _1/rdbms/log
backup_tape_io_slaves		     boolean	 FALSE
--
control_files			     string	 /opt/oracle/oradata/ORCL/contr
						 ol01.ctl, /opt/oracle/oradata/
						 ORCL/control02.ctl
control_management_pack_access	     string	 DIAGNOSTIC+TUNING
core_dump_dest			     string	 /opt/oracle/diag/rdbms/orcl/OR
						 CL/cdump
cpu_count			     integer	 12
--
dg_broker_config_file1		     string	 /opt/oracle/product/19c/dbhome
						 _1/dbs/dr1ORCL.dat
dg_broker_config_file2		     string	 /opt/oracle/product/19c/dbhome
						 _1/dbs/dr2ORCL.dat

--
diagnostic_dest 		     string	 /opt/oracle
disable_pdb_feature		     big integer 0
disk_asynch_io			     boolean	 TRUE
--
spfile				     string	 /opt/oracle/product/19c/dbhome
						 _1/dbs/spfileORCL.ora
sql92_security			     boolean	 TRUE
--
user_dump_dest			     string	 /opt/oracle/product/19c/dbhome
						 _1/rdbms/log
wallet_root			     string

```

```
[oracle@d135271a3410 /]$ mkdir -p /u01/app/oracle/product/19.0.0/dbhome_1/fast_recovery_area/
[oracle@d135271a3410 /]$ sqlplus / as sysdba

SQL*Plus: Release 19.0.0.0.0 - Production on Mon Sep 9 16:21:30 2019
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Connected to an idle instance.

SQL> startup
ORA-09925: Unable to create audit trail file
Linux-x86_64 Error: 2: No such file or directory
Additional information: 9925

```

```

[oracle@d135271a3410 /]$ vi /u01/app/oracle/product/19.0.0/dbhome_1/dbs/initORCL.ora
[oracle@d135271a3410 /]$ mkdir -p /u01/app/oracle/product/19.0.0/dbhome_1/admin/orcl/adump
[oracle@d135271a3410 /]$ sqlplus / as sysdba

SQL*Plus: Release 19.0.0.0.0 - Production on Mon Sep 9 16:23:27 2019
Version 19.3.0.0.0

Copyright (c) 1982, 2019, Oracle.  All rights reserved.

Connected to an idle instance.

SQL> startup
ORACLE instance started.

Total System Global Area 1073737800 bytes
Fixed Size		    8904776 bytes
Variable Size		  641728512 bytes
Database Buffers	  415236096 bytes
Redo Buffers		    7868416 bytes
ORA-00205: error in identifying control file, check alert log for more info



```

controlfileない
```
[root@d135271a3410 /]# ll /u01/app/oracle/product/19.0.0/dbhome_1/diag/rdbms/orcl/ORCL/trace/alert_ORCL.log
-rw-r-----. 1 oracle oinstall 25354  9月  9 16:23 /u01/app/oracle/product/19.0.0/dbhome_1/diag/rdbms/orcl/ORCL/trace/alert_ORCL.log
[root@d135271a3410 /]# vi /u01/app/oracle/product/19.0.0/dbhome_1/diag/rdbms/orcl/ORCL/trace/alert_ORCL.log
[root@d135271a3410 /]# tail -n 20 /u01/app/oracle/product/19.0.0/dbhome_1/diag/rdbms/orcl/ORCL/trace/alert_ORCL.log
2019-09-09T16:23:38.451872+09:00
Errors in file /u01/app/oracle/product/19.0.0/dbhome_1/diag/rdbms/orcl/ORCL/trace/ORCL_mz00_410.trc:
ORA-00202: control file: '/u01/app/oracle/product/19.0.0/dbhome_1/dbs/ora_control1'
ORA-27037: unable to obtain file status
Linux-x86_64 Error: 2: No such file or directory
Additional information: 7
2019-09-09T16:23:38.537301+09:00
Errors in file /u01/app/oracle/product/19.0.0/dbhome_1/diag/rdbms/orcl/ORCL/trace/ORCL_mz00_410.trc:
ORA-00202: control file: '/u01/app/oracle/product/19.0.0/dbhome_1/dbs/ora_control2'
ORA-27037: unable to obtain file status
Linux-x86_64 Error: 2: No such file or directory
Additional information: 7
ORA-00210: cannot open the specified control file
ORA-00202: control file: '/u01/app/oracle/product/19.0.0/dbhome_1/dbs/ora_control1'
ORA-27037: unable to obtain file status
Linux-x86_64 Error: 2: No such file or directory
Additional information: 7
Checker run found 2 new persistent data failures
2019-09-09T16:23:41.146099+09:00
Using default pga_aggregate_limit of 2048 MB

```

```
[oracle@ee5b841469f7 /]$ touch /u01/app/oracle/product/19.0.0/dbhome_1/dbs/ora_control1
[oracle@ee5b841469f7 /]$ touch /u01/app/oracle/product/19.0.0/dbhome_1/dbs/ora_control2
```

rpmあるぽい
```
方針転換
https://docs.oracle.com/en/database/oracle/oracle-database/19/ladbi/running-rpm-packages-to-install-oracle-database.html#GUID-BB7C11E3-D385-4A2F-9EAF-75F4F0AACF02

https://docs.oracle.com/en/database/oracle/oracle-database/19/ladbi/running-rpm-packages-to-install-oracle-database.html#GUID-BB7C11E3-D385-4A2F-9EAF-75F4F0AACF02

```
