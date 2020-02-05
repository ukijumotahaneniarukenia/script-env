# dockerコンテナ作成
```
time docker build -t ubuntu-19-10-keyboard-locale . | tee log
```

# dockerコンテナ起動
```
docker run --privileged --shm-size=4gb --name ubuntu-19-10-keyboard-locale -itd -v /etc/localtime:/etc/localtime -v /run/udev:/run/udev -v /run/systemd:/run/systemd -v /tmp/.X11-unix:/tmp/.X11-unix -v /var/lib/dbus:/var/lib/dbus -v /var/run/dbus:/var/run/dbus -v /etc/machine-id:/etc/machine-id ubuntu-19-10-keyboard-locale
```

# dockerコンテナ潜入
```
docker exec -it ubuntu-19-10-keyboard-locale /bin/bash
```

# 動作確認

```
$date

$echo $LANG

$echo うんこ
```
