# RパッケージのinstallログからANTICONFを見つけて設定ファイルを見直す
```
Rscript install_packages.R | tee pack_inst_log
```

```
grep "ANTICONF ERROR" pack_inst_log -A 10
```

# 参考文献
[最新版Rstudio](https://www.rstudio.com/products/rstudio/download/preview/)</br>

curlパッケージをインストールするためいかを参考
https://stackoverflow.com/questions/57989480/r-install-package-curl-handle-c301-error-unknown-type-name-curl-sslbacken
https://github.com/jeroen/curl/issues/204#issuecomment-532162699

# プロセス起動

あいかわらず、systemdコマンド経由は不安定なので、泥臭く起動。

ログインユーザーはrstudioユーザーでスクリプトはrootユーザーで起動。

```
[rstudio❤542cc0682e68 (土  1月 04 23:22:34) ~]$ll /etc/rc.d/init.d/rstudio-server
-rwxr-xr-x. 1 root root 1100  1月  4 22:48 /etc/rc.d/init.d/rstudio-server
[rstudio❤542cc0682e68 (土  1月 04 23:21:37) ~]$sudo /etc/rc.d/init.d/rstudio-server start
Starting rstudio-server:                                   [  OK  ]
```

ログイン前のプロセス状態

```
$ps aux
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
rstudio      1  0.0  0.0  42696  1548 pts/0    Ss+  23:08   0:00 /usr/sbin/init
rstudio     70  0.0  0.0  14376  2088 pts/1    Ss+  23:13   0:00 /bin/bash
rstudio    186  0.0  0.0  14376  2060 pts/2    Ss   23:15   0:00 /bin/bash
rstudio+   481  0.1  0.0 149428  3116 ?        Ssl  23:21   0:00 /usr/lib/rstudio-server/bin/rserver
rstudio    513  0.0  0.0  54296  1872 pts/2    R+   23:21   0:00 ps aux
```

ログイン後

ログインユーザーに対してサーバーがトークン払い出している。

```
$ps aux
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
rstudio      1  0.0  0.0  42696  1548 pts/0    Ss+  23:08   0:00 /usr/sbin/init
rstudio     70  0.0  0.0  14376  2088 pts/1    Ss+  23:13   0:00 /bin/bash
rstudio    186  0.0  0.0  14376  2060 pts/2    Ss   23:15   0:00 /bin/bash
rstudio+   481  0.2  0.0 214964  6600 ?        Ssl  23:21   0:00 /usr/lib/rstudio-server/bin/rserver
rstudio    523  2.6  0.2 479408 69304 ?        Sl   23:23   0:00 /usr/lib/rstudio-server/bin/rsession -u rstudio --launcher-token A23F2683
rstudio    541  0.0  0.0  54296  1868 pts/2    R+   23:23   0:00 ps aux
```

# ブラウザから起動確認

```
http://192.168.1.109:8787/
```

# プロセス停止

ログインユーザーはrstudioユーザーでスクリプトはrootユーザーで起動。

```
[rstudio❤542cc0682e68 (土  1月 04 23:28:22) ~]$sudo /etc/rc.d/init.d/rstudio-server stop
Stopping rstudio-server:                                   [  OK  ]
```

セッションを払い出すためのプロセスは前回の作業状態を復元するためのバッググランドプロセスなので、そっとしておく。
```
$ps aux
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
rstudio      1  0.0  0.0  42696  1548 pts/0    Ss+  23:08   0:00 /usr/sbin/init
rstudio     70  0.0  0.0  14376  2088 pts/1    Ss+  23:13   0:00 /bin/bash
rstudio    186  0.0  0.0  14376  2060 pts/2    Ss   23:15   0:00 /bin/bash
rstudio    523  0.4  0.2 553140 70380 ?        Sl   23:23   0:01 /usr/lib/rstudio-server/bin/rsession -u rstudio --launcher-token A23F2683
rstudio    567  0.0  0.0  14380  2072 pts/3    Ss+  23:27   0:00 bash -l
rstudio    617  0.0  0.0  54296  1864 pts/2    R+   23:29   0:00 ps aux
```

# Dockerイメージ作成
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
docker run --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v /etc/localtime:/etc/localtime -p 8787:8787 --name rstudio -itd centos_rstudio
```

# dockerコンテナ潜入
```
docker exec --user rstudio -it rstudio /bin/bash
```
