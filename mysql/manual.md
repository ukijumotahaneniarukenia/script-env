# サンプルデータベースのインストール
https://dev.mysql.com/doc/index-other.html
```
curl -LO https://github.com/datacharmer/test_db/archive/master.zip
curl -LO https://downloads.mysql.com/docs/world.sql.zip
curl -LO https://downloads.mysql.com/docs/world_x-db.zip
curl -LO https://downloads.mysql.com/docs/sakila-db.zip
curl -LO https://downloads.mysql.com/docs/menagerie-db.zip
```

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
```

# dockerコンテナ起動
```
docker run --privileged -v /etc/localtime:/etc/localtime -p 38787:8787 -p 30022:22 -p 3306:3306 -p 8080:80 --name mysql -itd centos_mysql /sbin/init
```

# dockerコンテナ潜入
```
docker exec --user rstudio -it mysql /bin/bash
docker exec --user root -it mysql /bin/bash
```

# サービス起動確認
```
[root@2315a8c47b0e ~]$systemctl status httpd
● httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; disabled; vendor preset: disabled)
   Active: inactive (dead)
     Docs: man:httpd(8)
           man:apachectl(8)
[root@2315a8c47b0e ~]$systemctl start httpd
[root@2315a8c47b0e ~]$systemctl status httpd
● httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; disabled; vendor preset: disabled)
   Active: active (running) since 金 2019-09-06 21:40:56 JST; 3s ago
     Docs: man:httpd(8)
           man:apachectl(8)
 Main PID: 779 (httpd)
   Status: "Processing requests..."
   CGroup: /docker/2315a8c47b0e767bef651a2e220b6f5b465135d16405e70584061de84d843c92/system.slice/httpd.service
           ├─779 /usr/sbin/httpd -DFOREGROUND
           ├─780 /usr/sbin/httpd -DFOREGROUND
           ├─781 /usr/sbin/httpd -DFOREGROUND
           ├─782 /usr/sbin/httpd -DFOREGROUND
           ├─783 /usr/sbin/httpd -DFOREGROUND
           └─784 /usr/sbin/httpd -DFOREGROUND
           ‣ 779 /usr/sbin/httpd -DFOREGROUND

 9月 06 21:40:56 2315a8c47b0e systemd[1]: Starting The Apache HTTP Server...
 9月 06 21:40:56 2315a8c47b0e httpd[779]: [Fri Sep 06 21:40:56.261585 2019] [alias:warn] [pid 779] AH00671: The Alias directive in /etc/httpd/conf.d/phpmyadmin.conf at line 5...rlier Alias.
 9月 06 21:40:56 2315a8c47b0e httpd[779]: AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using 172.17.0.2. Set the 'ServerName' direct...this message
 9月 06 21:40:56 2315a8c47b0e systemd[1]: Started The Apache HTTP Server.
Hint: Some lines were ellipsized, use -l to show in full.
[root@4000ae99ae5c ~]$systemctl status mysqld
● mysqld.service - MySQL Server
   Loaded: loaded (/usr/lib/systemd/system/mysqld.service; enabled; vendor preset: disabled)
   Active: active (running) since 金 2019-09-06 00:38:17 JST; 1min 0s ago
     Docs: man:mysqld(8)
           http://dev.mysql.com/doc/refman/en/using-systemd.html
  Process: 71 ExecStartPre=/usr/bin/mysqld_pre_systemd (code=exited, status=0/SUCCESS)
 Main PID: 687 (mysqld)
   Status: "Server is operational"
   CGroup: /docker/4000ae99ae5c9e7e6602bec890f9b804aa5869c1a283a897b2376f54a3f77fee/system.slice/mysqld.service
           └─687 /usr/sbin/mysqld
           ‣ 687 /usr/sbin/mysqld

 9月 06 00:38:11 4000ae99ae5c systemd[1]: Starting MySQL Server...
 9月 06 00:38:17 4000ae99ae5c systemd[1]: Started MySQL Server.
```

# コンテナ起動後a.shをたたく
```
[root@4000ae99ae5c /]$cd ~
[root@4000ae99ae5c ~]$./a.sh
```

# ブラウザより確認
phpMyAdminの場合
```
http://192.168.1.109:8080/phpmyadmin/
```
rstudioの場合
```
http://192.168.1.109:38787/
```
![](./1.png)
![](./2.png)
![](./3.png)


# 参考文献
```
https://blog.apar.jp/linux/9868/
https://dev.mysql.com/doc/refman/5.6/ja/tutorial.html
https://dev.mysql.com/downloads/mysql/
https://enomotodev.hatenablog.com/entry/2016/09/01/225200
https://tecadmin.net/setup-phpmyadmin-on-linux-using-source/
http://nanisore-nikki.hatenablog.com/entry/2015/03/03/152305
```
