# dockerイメージ作成

```
time docker build -t centos-7-6-18-10-c-cpp . | tee log
```

# dockerコンテナ起動

```
docker run --shm-size=8gb --name centos-7-6-18-10-c-cpp -itd -v /etc/localtime:/etc/localtime -v /run/udev:/run/udev -v /run/systemd:/run/systemd -v /tmp/.X11-unix:/tmp/.X11-unix -v /var/lib/dbus:/var/lib/dbus -v /var/run/dbus:/var/run/dbus -v /etc/machine-id:/etc/machine-id -p 3306:3306 centos-7-6-18-10-c-cpp
```

# dockerコンテナ潜入

```
docker exec -it centos-7-6-18-10-c-cpp /bin/bash
```

# eclipseでc-cpp開発環境

初回起動のみ
一般ユーザーで実行
```
$cd /usr/local/src/eclipse-installer/
$./eclipse-inst 1>~/installer_eclipse.log 2>&1 &
```

２回目以降
一般ユーザーで実行
```
$ec
```
