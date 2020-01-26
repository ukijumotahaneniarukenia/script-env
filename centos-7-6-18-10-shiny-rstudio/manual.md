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
https://stackoverflow.com/questions/57989480/r-install-package-curl-handle-c301-error-unknown-type-name-curl-sslbacken</br>
https://github.com/jeroen/curl/issues/204#issuecomment-532162699 </br>

# rstudio-serverプロセス起動

あいかわらず、systemdコマンド経由は不安定なので、泥臭く起動。

rstudioユーザーになる

```
$su rstudio
$whoami
rstudio
```

rootユーザーで実行

```
$ll /etc/rc.d/init.d/rstudio-server
-rwxr-xr-x. 1 root root 1100  1月  4 22:48 /etc/rc.d/init.d/rstudio-server
$sudo /etc/rc.d/init.d/rstudio-server start
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

ブラウザからアクセス

ID:rstudio
PW:rstudio_pwd

```
http://192.168.1.109:8787/
```

ログイン後のプロセス

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

# rstudio-serverプロセス停止

rootユーザーで実行

```
$sudo /etc/rc.d/init.d/rstudio-server stop
Stopping rstudio-server:                                   [  OK  ]
```

セッションを払い出すためのプロセスは前回の作業状態を復元するためのバッググランドプロセスなので、そっとしておく
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

# shiny-serverプロセス起動

shinyユーザーになる

```
$su shiny
Password:
$whoami
shiny
```

ホームディレクトリで以下のコマンドをshinyユーザーで実行

```
$ll /opt/shiny-server/bin/shiny-server
-rwxr-xr-x. 1 root root 25343  9月 12  2018 /opt/shiny-server/bin/shiny-server
$/opt/shiny-server/bin/shiny-server 1>~/launch_shiny-server.log 2>&1 &
[1] 87
```

ログ確認
```
$ll ~/launch_shiny-server.log
-rw-rw-r--. 1 shiny shiny 280  1月  5 16:49 /home/shiny/launch_shiny-server.log

$tail ~/launch_shiny-server.log
[2020-01-05T16:49:48.879] [INFO] shiny-server - Shiny Server v1.5.9.923 (Node.js v8.11.3)
[2020-01-05T16:49:48.880] [INFO] shiny-server - Using config file "/etc/shiny-server/shiny-server.conf"
[2020-01-05T16:49:48.909] [INFO] shiny-server - Starting listener on http://[::]:3838
```

プロセス確認

```
$ps aux
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
rstudio      1  0.0  0.0  42696  1548 pts/0    Ss+  16:46   0:00 /usr/sbin/init
rstudio     47  0.0  0.0  14376  2044 pts/1    Ss   16:48   0:00 /bin/bash
root        68  0.0  0.0  87256  2496 pts/1    S    16:48   0:00 su shiny
shiny       69  0.0  0.0  14376  2068 pts/1    S    16:48   0:00 bash
shiny       87  0.3  0.1 935744 33828 pts/1    Sl   16:49   0:00 /opt/shiny-server/ext/node/bin/shiny-server /opt/shiny-server/lib/main.js
shiny       99  0.0  0.0  54296  1872 pts/1    R+   16:50   0:00 ps aux
```

待受ポート確認

```
$lsof -i:3838
COMMAND   PID  USER   FD   TYPE  DEVICE SIZE/OFF NODE NAME
shiny-ser  87 shiny   10u  IPv6 2537109      0t0  TCP *:sos (LISTEN)
```

shiny-serverプロセス停止

```
$ps aux
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
rstudio      1  0.0  0.0  42696  1548 pts/0    Ss+  16:46   0:00 /usr/sbin/init
rstudio+   120  0.0  0.0 288696  6764 ?        Ssl  16:57   0:01 /usr/lib/rstudio-server/bin/rserver
rstudio    154  0.3  0.4 797868 146372 ?       Sl   16:58   0:14 /usr/lib/rstudio-server/bin/rsession -u rstudio --launcher-token C59E46F2
shiny      272  0.0  0.1 1210364 57008 ?       Sl   17:03   0:01 /opt/shiny-server/ext/node/bin/shiny-server /opt/shiny-server/lib/main.js
rstudio    326  0.0  0.0  14376  2064 pts/1    Ss   17:33   0:00 /bin/bash
root       348  0.0  0.0  87256  2492 pts/1    S    17:34   0:00 su shiny
shiny      349  0.0  0.0  14376  2100 pts/1    S    17:34   0:00 bash
rstudio    644  0.0  0.0  14380  1908 pts/3    Ss+  17:53   0:00 bash -l
shiny      683  0.1  0.3 507924 130544 ?       Ssl  17:57   0:01 /usr/lib64/R/bin/exec/R --no-save --slave -f /opt/shiny-server/R/SockJSAdapter.R
shiny      797  0.0  0.0  54296  1872 pts/1    R+   18:10   0:00 ps aux
$sudo kill -9 272
$ps aux
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
rstudio      1  0.0  0.0  42696  1548 pts/0    Ss+  16:46   0:00 /usr/sbin/init
rstudio+   120  0.0  0.0 288696  6764 ?        Ssl  16:57   0:01 /usr/lib/rstudio-server/bin/rserver
rstudio    154  0.3  0.4 797868 146372 ?       Sl   16:58   0:14 /usr/lib/rstudio-server/bin/rsession -u rstudio --launcher-token C59E46F2
rstudio    326  0.0  0.0  14376  2064 pts/1    Ss   17:33   0:00 /bin/bash
root       348  0.0  0.0  87256  2492 pts/1    S    17:34   0:00 su shiny
shiny      349  0.0  0.0  14376  2100 pts/1    S    17:34   0:00 bash
rstudio    644  0.0  0.0  14380  1908 pts/3    Ss+  17:53   0:00 bash -l
shiny      683  0.1  0.3 507924 130544 ?       Ssl  17:57   0:01 /usr/lib64/R/bin/exec/R --no-save --slave -f /opt/shiny-server/R/SockJSAdapter.R
shiny      800  0.0  0.0  54296  1876 pts/1    R+   18:10   0:00 ps aux
```

shiny-serverのレンダラでうまく行っていないときは以下の情報をもとに
**/var/lib/shiny-server**ディレクトリの権限を変更する。

https://github.com/rocker-org/shiny/issues/49 </br>

```
$ll /var/lib/
total 72
drwxr-xr-x. 1 root root 4096  1月  5 15:56 alternatives
drwxr-xr-x. 2 root root 4096 11月  3  2018 dbus
drwxr-xr-x. 2 root root 4096  4月 11  2018 games
drwxr-xr-x. 2 root root 4096 11月  3  2018 initramfs
drwx------. 2 root root 4096 12月  5  2018 machines
drwxr-xr-x. 2 root root 4096  4月 11  2018 misc
drwxr-xr-x. 1 root root 4096 12月  5  2018 rpm
drwxr-xr-x. 1 root root 4096  1月  5 16:00 rpm-state
drwxr-xr-x. 5 root root 4096  1月  5 15:47 rstudio-server
drwxr-xr-x. 2 root root 4096  1月  5 15:47 shiny-server
drwxr-xr-x. 4 root root 4096  1月  5 15:42 stateless
drwxr-xr-x. 1 root root 4096 10月 19 01:48 systemd
drwxr-xr-x. 3 root root 4096  1月  5 15:57 texmf
drwxr-xr-x. 1 root root 4096  1月  5 16:10 yum
$sudo chown shiny:shiny /var/lib/shiny-server
$ll /var/lib/
total 72
drwxr-xr-x. 1 root  root  4096  1月  5 15:56 alternatives
drwxr-xr-x. 2 root  root  4096 11月  3  2018 dbus
drwxr-xr-x. 2 root  root  4096  4月 11  2018 games
drwxr-xr-x. 2 root  root  4096 11月  3  2018 initramfs
drwx------. 2 root  root  4096 12月  5  2018 machines
drwxr-xr-x. 2 root  root  4096  4月 11  2018 misc
drwxr-xr-x. 1 root  root  4096 12月  5  2018 rpm
drwxr-xr-x. 1 root  root  4096  1月  5 16:00 rpm-state
drwxr-xr-x. 5 root  root  4096  1月  5 15:47 rstudio-server
drwxr-xr-x. 1 shiny shiny 4096  1月  5 15:47 shiny-server
drwxr-xr-x. 4 root  root  4096  1月  5 15:42 stateless
drwxr-xr-x. 1 root  root  4096 10月 19 01:48 systemd
drwxr-xr-x. 3 root  root  4096  1月  5 15:57 texmf
drwxr-xr-x. 1 root  root  4096  1月  5 16:10 yum
```

# dockerイメージ作成
```
time docker build -t centos-7-6-18-10-shiny-rstudio . | tee log
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
docker run --privileged --shm-size=8gb -v /sys/fs/cgroup:/sys/fs/cgroup:ro -itd -v /etc/localtime:/etc/localtime -v /run/udev:/run/udev -v /run/systemd:/run/systemd -v /tmp/.X11-unix:/tmp/.X11-unix -v /var/lib/dbus:/var/lib/dbus -v /var/run/dbus:/var/run/dbus -v /etc/machine-id:/etc/machine-id -p 8787:8787 -p 3838:3838 --name centos-7-6-18-10-shiny-rstudio -itd centos-7-6-18-10-shiny-rstudio
```

# dockerコンテナ潜入
```
docker exec --user rstudio -it centos-7-6-18-10-shiny-rstudio /bin/bash
```
