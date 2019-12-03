# dockerイメージ作成
```
time docker build -t centos_racket . | tee log
```

# dockerコンテナ作成
```
docker run --privileged --shm-size=4gb --name racket -itd -v /run/udev:/run/udev -v /run/systemd:/run/systemd -v /tmp/.X11-unix:/tmp/.X11-unix -v /var/lib/dbus:/var/lib/dbus -v /var/run/dbus:/var/run/dbus -v /etc/machine-id:/etc/machine-id centos_racket
```

# Xアプリ転送許可設定

dockerコンテナ内のXアプリをdockerホストに転送許可する。 ローカルネットワーク内で存在する全てのマシンからのX転送を許可している。マシン単位で設定もできる。

```
xhost +local:
```

# dockerコンテナ潜入

```
docker exec --user racket -it racket /bin/bash
```
