# Dockerfileよりイメージ作成
```
time docker build -t centos_mysql . | tee log
```

# dockerコンテナ削除
```
docker ps -qa | xargs -I@ bash -c 'docker stop @ && docker rm @'
```

# dockerイメージ削除
```
docker images | awk '$1=="<none>"{print $3}' | xargs -I@ docker rmi @
docker images | awk '$1 ~ "centos_"{print $3}' | xargs -I@ bash -c 'docker rmi @
```

# dockerコンテナ起動
```
docker run --privileged -v /etc/localtime:/etc/localtime -p 38787:8787 -p 30022:22 -p 3306:3306 --name mysql -itd centos_mysql /sbin/init
```

# dockerコンテナ潜入
```
docker exec --user mysql -it mysql /bin/bash
docker exec --user root -it mysql /bin/bash
```

# ブラウザから起動確認
```
http://192.168.1.109:38787/
```

# サービス起動確認
```
[root@7b5265657b8b /]# systemctl status mysqld
● mysqld.service - MySQL Server
   Loaded: loaded (/usr/lib/systemd/system/mysqld.service; enabled; vendor preset: disabled)
   Active: active (running) since Sat 2019-08-31 15:38:27 JST; 3min 15s ago
     Docs: man:mysqld(8)
           http://dev.mysql.com/doc/refman/en/using-systemd.html
  Process: 1717 ExecStartPre=/usr/bin/mysqld_pre_systemd (code=exited, status=0/SUCCESS)
 Main PID: 2664 (mysqld)
   Status: "Server is operational"
   CGroup: /docker/7b5265657b8b102410a643ddcc14a11b530d278864b0e36d0c877960f2e3cdbb/system.slice/mysqld.service
           └─2664 /usr/sbin/mysqld
           ‣ 2664 /usr/sbin/mysqld

Aug 31 15:38:20 7b5265657b8b systemd[1]: Starting MySQL Server...
Aug 31 15:38:27 7b5265657b8b systemd[1]: Started MySQL Server.
```

# log
rootユーザーのパスワードと公開ポート控える
```
[root@7b5265657b8b /]# cat /var/log/mysqld.log
2019-08-31T06:38:20.796080Z 0 [System] [MY-013169] [Server] /usr/sbin/mysqld (mysqld 8.0.17) initializing of server in progress as process 2157
2019-08-31T06:38:24.125593Z 5 [Note] [MY-010454] [Server] A temporary password is generated for root@localhost: RgQgkah==4q3
2019-08-31T06:38:25.793495Z 0 [System] [MY-013170] [Server] /usr/sbin/mysqld (mysqld 8.0.17) initializing of server has completed
2019-08-31T06:38:27.459227Z 0 [System] [MY-010116] [Server] /usr/sbin/mysqld (mysqld 8.0.17) starting as process 2664
2019-08-31T06:38:27.825832Z 0 [Warning] [MY-010068] [Server] CA certificate ca.pem is self signed.
2019-08-31T06:38:27.842623Z 0 [System] [MY-010931] [Server] /usr/sbin/mysqld: ready for connections. Version: '8.0.17'  socket: '/var/lib/mysql/mysql.sock'  port: 3306  MySQL Community Server - GPL.
2019-08-31T06:38:27.954730Z 0 [System] [MY-011323] [Server] X Plugin ready for connections. Socket: '/var/run/mysqld/mysqlx.sock' bind-address: '::' port: 33060
```

# 権限整備

Old_pass:logにはかれているやつ
New_pass:Mysql-3306
```
[root@ab839250d53a /]# grep password /var/log/mysqld.log
2019-08-31T16:13:02.444003+09:00 5 [Note] [MY-010454] [Server] A temporary password is generated for root@localhost: s&tM7B7/til(

[root@ab839250d53a /]# mysql_secure_installation --use-default

Securing the MySQL server deployment.

Enter password for user root: 

The existing password for the user account root has expired. Please set a new password.

New password: 

Re-enter new password: 
The 'validate_password' component is installed on the server.
The subsequent steps will run with the existing configuration
of the component.
By default, a MySQL installation has an anonymous user,
allowing anyone to log into MySQL without having to have
a user account created for them. This is intended only for
testing, and to make the installation go a bit smoother.
You should remove them before moving into a production
environment.

Remove anonymous users? (Press y|Y for Yes, any other key for No) :  y 
Success.


Normally, root should only be allowed to connect from
'localhost'. This ensures that someone cannot guess at
the root password from the network.

Disallow root login remotely? (Press y|Y for Yes, any other key for No) :  y 
Success.

By default, MySQL comes with a database named 'test' that
anyone can access. This is also intended only for testing,
and should be removed before moving into a production
environment.


Remove test database and access to it? (Press y|Y for Yes, any other key for No) :  y 
 - Dropping test database...
Success.

 - Removing privileges on test database...
Success.

Reloading the privilege tables will ensure that all changes
made so far will take effect immediately.

Reload privilege tables now? (Press y|Y for Yes, any other key for No) :  y 
Success.

All done! 

```

# 動作確認
```
[root@ab839250d53a /]# mysql -u root -p
Enter password: 
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 11
Server version: 8.0.17 MySQL Community Server - GPL

Copyright (c) 2000, 2019, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> select 'unko';
+------+
| unko |
+------+
| unko |
+------+
1 row in set (0.00 sec)

mysql> ^DBye
```

# 参考文献
```
https://blog.apar.jp/linux/9868/
https://dev.mysql.com/doc/refman/5.6/ja/tutorial.html
https://dev.mysql.com/downloads/mysql/
https://enomotodev.hatenablog.com/entry/2016/09/01/225200
```
