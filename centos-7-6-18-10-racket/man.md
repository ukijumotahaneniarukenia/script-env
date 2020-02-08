# dockerイメージ作成
```
time docker build -t centos-7-6-18-10-racket . | tee log
```

# dockerコンテナ作成
```
docker run --privileged --shm-size=4gb --name centos-7-6-18-10-racket -itd -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v /run/udev:/run/udev -v /run/systemd:/run/systemd -v /tmp/.X11-unix:/tmp/.X11-unix -v /var/lib/dbus:/var/lib/dbus -v /var/run/dbus:/var/run/dbus -v /etc/machine-id:/etc/machine-id centos-7-6-18-10-racket
```

# Xアプリ転送許可設定

dockerコンテナ内のXアプリをdockerホストに転送許可する。 ローカルネットワーク内で存在する全てのマシンからのX転送を許可している。マシン単位で設定もできる。

```
xhost +local:
```

# dockerコンテナ潜入

```
docker exec --user kuraine -it centos-7-6-18-10-racket /bin/bash
```

# drracket起動

```
$drracket 1>~/launch_drracket.log 2>&1 &
[1] 122
$ll
total 0
-rw-rw-r--. 1 kuraine kuraine 0  1月  5 09:17 launch_drracket.log
```
