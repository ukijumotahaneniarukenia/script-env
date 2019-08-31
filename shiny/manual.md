# Dockerfileよりshinyイメージ作成
```
time docker build -t centos_shiny . | tee log
```

```
cat <(docker images | head -n1) <(docker images | awk '$1=="centos_shiny"{print $0}')
[oracle@centos shiny]$ cat <(docker images | head -n1) <(docker images | awk '$1=="centos_shiny"{print $0}')
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
centos_shiny        latest              cac78a083cce        5 minutes ago       4GB
```

# dockerコンテナ作成
```
docker run --privileged -v /etc/localtime:/etc/localtime -p 3838:3838 --name shiny -itd centos_shiny /sbin/init
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
[oracle@centos shiny]$ docker exec --user root -it shiny bash
[oracle@centos shiny]$ docker exec --user shiny -it shiny bash
```

# shiny-server起動確認
```
[root@e5f42d887d44 shiny-server]# systemctl status shiny-server
● shiny-server.service - ShinyServer
   Loaded: loaded (/etc/systemd/system/shiny-server.service; enabled; vendor preset: disabled)
   Active: active (running) since 土 2019-08-17 11:23:33 JST; 2min 33s ago
 Main PID: 154 (shiny-server)
   CGroup: /docker/e5f42d887d44fa32bd6c0925eb19d0a218f3d3143d24e55f1796eb1867c2c256/system.slice/shiny-server.service
           └─154 /opt/shiny-server/ext/node/bin/shiny-server /opt/shiny-server/lib/main.js
           ‣ 154 /opt/shiny-server/ext/node/bin/shiny-server /opt/shiny-server/lib/main.js

 8月 17 11:23:33 e5f42d887d44 systemd[1]: Started ShinyServer.
```

# ブラウザから起動確認

```
http://192.168.1.109:3838/
```

![](./1.png)
