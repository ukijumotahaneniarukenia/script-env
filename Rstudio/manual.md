# dockerホストにもインストール
自動起動設定しておいた
```
[root@centos oracle]# userdel rstudio
[root@centos oracle]# useradd rstudio
[root@centos oracle]# usermod -aG docker rstudio
[root@centos oracle]# echo 'rstudio_pwd' | passwd --stdin rstudio
[rstudio@centos ~]$LANG=C xdg-user-dirs-gtk-update
[rstudio@centos ~]sudo yum install -y --nogpgcheck https://s3.amazonaws.com/rstudio-ide-build/server/centos6/x86_64/rstudio-server-rhel-1.2.1568-x86_64.rpm
[rstudio@centos ~]sudo systemctl enable rstudio-server.service
[rstudio@centos ~]$ su root
パスワード:
[root@centos rstudio]# reboot
[rstudio@centos ~]$ sudo systemctl status rstudio-server.service
[sudo] rstudio のパスワード:
● rstudio-server.service - RStudio Server
   Loaded: loaded (/etc/systemd/system/rstudio-server.service; enabled; vendor preset: disabled)
   Active: active (running) since 土 2019-08-24 20:31:27 JST; 1min 0s ago
  Process: 1179 ExecStart=/usr/lib/rstudio-server/bin/rserver (code=exited, status=0/SUCCESS)
 Main PID: 1192 (rserver)
    Tasks: 3
   Memory: 23.2M
   CGroup: /system.slice/rstudio-server.service
           └─1192 /usr/lib/rstudio-server/bin/rserver

 8月 24 20:31:27 centos systemd[1]: Starting RStudio Server...
 8月 24 20:31:27 centos systemd[1]: Started RStudio Server.
```

# dockerホストでの起動確認
```
http://localhost:8787/
```

# 事後準備
[最新版Rstudio](https://www.rstudio.com/products/rstudio/download/preview/)

yum installで固まったら、/sbin/initが動いていない気がするので、PC再起動してやり直す。
やっぱRstudioインストールしにくいから、一度removeして再インストールした。わからない全然わからない。この手順なくしたい。。
```
[root@905d56a22317 rstudio]# yum remove -y rstudio-server
[root@905d56a22317 rstudio]# yum install -y --nogpgcheck https://s3.amazonaws.com/rstudio-ide-build/server/centos6/x86_64/rstudio-server-rhel-1.2.1568-x86_64.rpm
[root@905d56a22317 rstudio]# systemctl status rstudio-server
● rstudio-server.service - RStudio Server
   Loaded: loaded (/etc/systemd/system/rstudio-server.service; enabled; vendor preset: disabled)
   Active: active (running) since 日 2019-08-18 07:51:24 JST; 1min 46s ago
  Process: 780 ExecStart=/usr/lib/rstudio-server/bin/rserver (code=exited, status=0/SUCCESS)
 Main PID: 781 (rserver)
   CGroup: /docker/905d56a22317df6d1052041244b6ccb5fcea0bfe494ad24c510ed53d4f4e4f8b/system.slice/rstudio-server.service
           └─781 /usr/lib/rstudio-server/bin/rserver
           ‣ 781 /usr/lib/rstudio-server/bin/rserver

 8月 18 07:51:24 905d56a22317 systemd[1]: Starting RStudio Server...
 8月 18 07:51:24 905d56a22317 systemd[1]: Started RStudio Server.
```

# ブラウザから起動確認
```
http://192.168.1.109:18787/
```

# Dockerfileよりイメージ作成
```
time docker build -t centos_rstudio . | tee log
```

# dockerコンテナ削除
```
docker ps -qa | xargs -I@ bash -c 'docker stop @ && docker rm @'
```

# dockerイメージ削除
```
docker images | awk '$1=="<none>"{print $3}' | xargs -I@ docker rmi @
```

# dockerコンテナ作成
```
docker run --privileged -v /etc/localtime:/etc/localtime -p 18787:8787 -p 10022:22 --name rstudio -itd centos_rstudio /sbin/init
```

# dockerコンテナ潜入
```
[oracle@centos Rstudio]$ docker exec --user root -it rstudio bash
[oracle@centos Rstudio]$ docker exec --user rstudio -it rstudio bash
```
