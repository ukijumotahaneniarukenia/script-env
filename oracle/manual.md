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
