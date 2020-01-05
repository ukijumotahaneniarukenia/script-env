# shinyはrstudioと共存しない方が確かよかった。

# dockerイメージ作成
```
time docker build -t centos_shiny . | tee log
```

# dockerコンテナ作成
```
docker run --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v /etc/localtime:/etc/localtime -p 13838:3838 --name shiny -itd centos_shiny
```

# dockerコンテナ削除
```
docker ps -qa | xargs -I@ bash -c 'docker stop @ && docker rm @'
```

# dockerイメージ削除
```
docker images | awk '$1=="<none>"{print $3}' | xargs -I@ docker rmi @
```

# dockerコンテナ潜入
```
docker exec --user shiny -it shiny /bin/bash
```

# shiny-serverプロセス起動

systemdは安定しないので、泥臭く。

以下の実行ファイルを

```
$ll /opt/shiny-server/bin/shiny-server
-rwxr-xr-x. 1 root root 25343  9月 12  2018 /opt/shiny-server/bin/shiny-server
```

rootユーザーで実行し、バッググラウンドで起動
```
$sudo /opt/shiny-server/bin/shiny-server 1>~/launch_shiny-server.log 2>&1 &
```

ログ確認

```
$ll ~/launch_shiny-server.log
-rw-rw-r--. 1 shiny shiny 280  1月  5 15:30 /home/shiny/launch_shiny-server.log

$tail ~/launch_shiny-server.log
[2020-01-05T15:30:40.577] [INFO] shiny-server - Shiny Server v1.5.9.923 (Node.js v8.11.3)
[2020-01-05T15:30:40.579] [INFO] shiny-server - Using config file "/etc/shiny-server/shiny-server.conf"
[2020-01-05T15:30:40.607] [INFO] shiny-server - Starting listener on http://[::]:3838
```

プロセス確認

```
$ps aux
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
shiny        1  0.0  0.0  42696  1548 pts/0    Ss+  15:26   0:00 /usr/sbin/init
shiny        6  0.0  0.0  14376  2064 pts/1    Ss   15:27   0:00 /bin/bash
shiny      237  0.2  0.0 936768 31500 pts/1    Sl   15:30   0:00 /opt/shiny-server/ext/node/bin/shiny-server /opt/shiny-server/lib/main.js
shiny      251  0.0  0.0  54296  1860 pts/1    R+   15:32   0:00 ps aux
```

待受ポート確認

```
$lsof -i:3838
COMMAND   PID  USER   FD   TYPE  DEVICE SIZE/OFF NODE NAME
shiny-ser 237 shiny   10u  IPv6 1970668      0t0  TCP *:sos (LISTEN)
```

# ブラウザから起動確認

```
http://192.168.1.109:3838/
```

![](./1.png)
