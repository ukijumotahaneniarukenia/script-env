# 参考文献
https://weblabo.oscasierra.net/postgresql10-centos7-install/
http://note.kurodigi.com/centos7-postgresql/
https://freelance-jak.com/technology/postgresql/451/

https://codezine.jp/article/detail/2686


# Dockerfileよりイメージ作成
```
time docker build -t centos_postgres . | tee log
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
docker run --privileged -v /etc/localtime:/etc/localtime  --name postgres -p 50022:22 -p 55050:5050 -p 58787:8787 -p 5432:5432 -itd centos_postgres
```

# ブラウザから起動確認(rstudio)
```
http://192.168.1.109:58787/
```

# ブラウザから起動確認(pgadmin)
```
http://192.168.1.109:55050/
```

# dockerコンテナ潜入
```
docker exec --user postgres -it postgres /bin/bash
docker exec --user root -it postgres /bin/bash
```

# dockerコンテナ潜入後
rootで作業。pythonはシステム共通で使用しているパスを指定。
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
```
postgresql-11-setup initdb
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

## データベースの再起動
```
systemctl restart postgresql-11.service
```

## データベースの初期化とサービス起動＆自動起動設定
```
postgresql-11-setup initdb
systemctl start postgresql-11.service
systemctl status postgresql-11.service
systemctl enable postgresql-11.service
``` 
## pgAdmin起動。pythonはシステム共通で使用しているパスを指定。
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
psql -U postgres -d dvdrentals
```

# ブラウザでの表示確認

![setup.pyで入力したものと同じ文言を入力](./0.png)
![](./1.png)
![](./2.png)
![](./3.png)
