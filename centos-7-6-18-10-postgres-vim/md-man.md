# 参考文献

環境変数の設定
https://kenpg.bitbucket.io/blog/201607/19.html

https://weblabo.oscasierra.net/postgresql10-centos7-install/
http://note.kurodigi.com/centos7-postgresql/
https://freelance-jak.com/technology/postgresql/451/
https://codezine.jp/article/detail/2686

postgresのソースコード
https://www.postgresql.org/ftp/source/


# dockerイメージ作成
```
time docker build -t centos-7-6-18-10-postgres . | tee log
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
docker run --privileged --shm-size=8gb --name centos-7-6-18-10-postgres -itd -v /etc/localtime:/etc/localtime -v /run/udev:/run/udev -v /run/systemd:/run/systemd -v /tmp/.X11-unix:/tmp/.X11-unix -v /var/lib/dbus:/var/lib/dbus -v /var/run/dbus:/var/run/dbus -v /etc/machine-id:/etc/machine-id centos-7-6-18-10-postgres
```

# ブラウザから起動確認(pgadmin)
```
http://192.168.1.109:5050/
```

# dockerコンテナ潜入
```
docker exec --user postgres -it centos-7-6-18-10-postgres /bin/bash
docker exec --user root -it centos-7-6-18-10-postgres /bin/bash
```

# dockerコンテナ潜入後
rootユーザーで実行。pythonはシステム共通で使用しているパスを指定。
```
[aine💚centos (土 10月 05 12:19:23) ~/script_scratch/postgres]$docker exec --user root -it postgres /bin/bash
[root🖤4718e7a94014 (土 10月 05 12:19:57) /]$cd /usr/lib/python2.7/site-packages/pgadmin4-web
[root🖤4718e7a94014 (土 10月 05 12:19:59) /usr/lib/python2.7/site-packages/pgadmin4-web]$/usr/bin/python2.7 ./setup.py
NOTE: Configuring authentication for SERVER mode.

Enter the email address and password to use for the initial pgAdmin user account:

Email address: mrchildrenkh1008@gmail.com
Password: 
Retype password:
pgAdmin 4 - Application Initialisation
======================================
```
## データベースの初期化
postgresユーザーで実行。
```
[postgres💗8800564297cd (土 10月 05 12:43:00) /]$initdb -D /var/lib/pgsql/11/data
The files belonging to this database system will be owned by user "postgres".
This user must also own the server process.

The database cluster will be initialized with locale "ja_JP.utf8".
The default database encoding has accordingly been set to "UTF8".
initdb: could not find suitable text search configuration for locale "ja_JP.utf8"
The default text search configuration will be set to "simple".

Data page checksums are disabled.

fixing permissions on existing directory /var/lib/pgsql/11/data ... ok
creating subdirectories ... ok
selecting default max_connections ... 100
selecting default shared_buffers ... 128MB
selecting default timezone ... Asia/Tokyo
selecting dynamic shared memory implementation ... posix
creating configuration files ... ok
running bootstrap script ... ok
performing post-bootstrap initialization ... ok
syncing data to disk ... ok

WARNING: enabling "trust" authentication for local connections
You can change this by editing pg_hba.conf or using the option -A, or
--auth-local and --auth-host, the next time you run initdb.

Success. You can now start the database server using:

    pg_ctl -D /var/lib/pgsql/11/data -l logfile start
``` 
## postgresサービス起動
```
[postgres💖8800564297cd (土 10月 05 12:48:24) ~]$pg_ctl -D /var/lib/pgsql/11/data -l logfile start
waiting for server to start.... done
server started
[postgres💖8800564297cd (土 10月 05 12:48:56) ~]$ll
total 3320
-rw-r--r--. 1 postgres postgres 2835456  5月 12 19:36 dvdrental.tar
-rw-r--r--. 1 postgres postgres  550906 10月  5 12:16 dvdrental.zip
-rw-r--r--. 1 postgres postgres    2233 10月  5 12:16 installer.sh
-rw-------. 1 postgres postgres     697 10月  5 12:48 logfile
```
いい感じに動いているとこんな具合
```
[postgres💓26c364215a07 (土 10月 05 14:48:41) ~]$sudo systemctl status
● 26c364215a07
    State: running
     Jobs: 0 queued
   Failed: 0 units
    Since: 土 2019-10-05 13:33:48 JST; 1h 14min ago
   CGroup: /
           ├─   1 /bin/bash
           ├─  74 /usr/pgsql-11/bin/postgres -D /var/lib/pgsql/11/data
           ├─  75 postgres: logger                                    
           ├─  77 postgres: checkpointer                              
           ├─  78 postgres: background writer                         
           ├─  79 postgres: walwriter                                 
           ├─  80 postgres: autovacuum launcher                       
           ├─  81 postgres: stats collector                           
           ├─  82 postgres: logical replication launcher              
           ├─ 606 sudo /usr/bin/python2.7 pgAdmin4.py
           ├─ 607 /usr/bin/python2.7 pgAdmin4.py
           ├─ 897 postgres: postgres dvdrental 127.0.0.1(36954) idle  
           ├─ 898 postgres: postgres postgres 127.0.0.1(36956) idle   
           ├─ 923 postgres: postgres dvdrental 127.0.0.1(37006) idle  
           ├─1117 /bin/bash
           ├─1153 sudo systemctl status
           ├─1154 systemctl status
           └─1155 less
```


## 外部からの接続を許可する
ローカルネットワークからのアクセスは認証なしで接続可。
修正前
```
[root@7a38ce597c69 /usr/lib/python2.7/site-packages/pgadmin4-web]$grep -E "ident|trust" /var/lib/pgsql/11/data/pg_hba.conf
# METHOD can be "trust", "reject", "md5", "password", "scram-sha-256",
# "gss", "sspi", "ident", "peer", "pam", "ldap", "radius" or "cert".
host    all             all             127.0.0.1/32            ident
host    all             all             ::1/128                 ident
host    replication     all             127.0.0.1/32            ident
host    replication     all             ::1/128                 ident
```
修正後
```
[root@7a38ce597c69 /usr/lib/python2.7/site-packages/pgadmin4-web]$grep -E "ident|trust" /var/lib/pgsql/11/data/pg_hba.conf
# METHOD can be "trust", "reject", "md5", "password", "scram-sha-256",
# "gss", "sspi", "ident", "peer", "pam", "ldap", "radius" or "cert".
host    all             all             127.0.0.1/32            trust
host    all             all             ::1/128                 ident
host    replication     all             127.0.0.1/32            ident
host    replication     all             ::1/128                 ident
```

## pgAdmin起動
pythonはシステム共通で使用しているパスを指定。
```
[root@7a38ce597c69 /]$cd /usr/lib/python2.7/site-packages/pgadmin4-web/
[root@7a38ce597c69 /usr/lib/python2.7/site-packages/pgadmin4-web]$/usr/bin/python2.7 pgAdmin4.py
Starting pgAdmin 4. Please navigate to http://0.0.0.0:5050 in your browser.
 * Serving Flask app "pgadmin" (lazy loading)
 * Environment: production
   WARNING: Do not use the development server in a production environment.
   Use a production WSGI server instead.
 * Debug mode: off
``` 

# サンプルデータベースのリストア
tarファイルある場所でリストア
```
cd ~
psql -U postgres -c "create database dvdrental"
pg_restore -U postgres -d dvdrental dvdrental.tar
```

# サンプルデータベース接続
```
psql -l
psql -U postgres -d dvdrental
```

# ブラウザでの表示確認

![](./0.png)
![](./1.png)
![](./2.png)
![](./3.png)