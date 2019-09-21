# RパッケージのinstallログからANTICONFを見つけて設定ファイルを見直す
```
Rscript install_packages.R | tee pack_inst_log
```

```
grep "ANTICONF ERROR" pack_inst_log -A 10
```

# 参考文献
[最新版Rstudio](https://www.rstudio.com/products/rstudio/download/preview/)

curlパッケージをインストールするためいかを参考
https://stackoverflow.com/questions/57989480/r-install-package-curl-handle-c301-error-unknown-type-name-curl-sslbacken
https://github.com/jeroen/curl/issues/204#issuecomment-532162699

# サービス起動確認

```
[root@d57bcef7f52a /]$systemctl status rstudio-server.service
● rstudio-server.service - SYSV: RStudio server provides a web interface to R
   Loaded: loaded (/etc/rc.d/init.d/rstudio-server; bad; vendor preset: disabled)
   Active: active (running) since 土 2019-09-21 13:52:58 JST; 25s ago
     Docs: man:systemd-sysv-generator(8)
  Process: 190 ExecStart=/etc/rc.d/init.d/rstudio-server start (code=exited, status=0/SUCCESS)
   CGroup: /docker/d57bcef7f52ae637abb203721f9bdc36e83b44544e8c68cd721234ef24690942/system.slice/rstudio-server.service
           └─619 /usr/lib/rstudio-server/bin/rserver

 9月 21 13:52:58 d57bcef7f52a systemd[1]: Starting SYSV: RStudio server provides a web interface to R...
 9月 21 13:52:58 d57bcef7f52a rstudio-server[190]: Starting rstudio-server: [  OK  ]
 9月 21 13:52:58 d57bcef7f52a systemd[1]: Started SYSV: RStudio server provides a web interface to R.
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
[oracle@centos Rstudio]$ docker exec --user root -it rstudio /bin/bash
[oracle@centos Rstudio]$ docker exec --user rstudio -it rstudio /bin/bash
```
