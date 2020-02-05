# dockerコンテナ作成

```
time docker build -t centos-7-6-18-10-xsystemd . | tee log
```

# dockerコンテナ起動

```
docker run --privileged --shm-size=8gb --name xsystemd -v /run/udev:/run/udev -v /run/systemd:/run/systemd -v /tmp/.X11-unix:/tmp/.X11-unix -v /var/lib/dbus:/var/lib/dbus -v /var/run/dbus:/var/run/dbus -v /etc/machine-id:/etc/machine-id -v /sys/fs/cgroup:/sys/fs/cgroup:ro -itd centos-7-6-18-10-xsystemd
```

# dockerコンテナ潜入

```
docker exec -it xsystemd /bin/bash
```

# Xアプリ転送許可設定

dockerコンテナ内のXアプリをdockerホストに転送許可する。 ローカルネットワーク内で存在する全てのマシンからのX転送を許可している。マシン単位で設定もできる。

以下のコマンドをdockerホストで実行。

```
xhost +local:
```
