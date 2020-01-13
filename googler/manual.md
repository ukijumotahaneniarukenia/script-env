# dockerイメージ作成

```
time docker build -t centos_googler . | tee log
```

# dockerコンテナ作成

```
docker run --privileged --shm-size=8gb -v /run/udev:/run/udev -v /run/systemd:/run/systemd -v /tmp/.X11-unix:/tmp/.X11-unix -v /var/lib/dbus:/var/lib/dbus -v /var/run/dbus:/var/run/dbus -v /etc/machine-id:/etc/machine-id -v /etc/localtime:/etc/localtime -itd --name googler centos_googler
```

# dockerコンテナ潜入

```
docker exec --user kuraine -it googler /bin/bash
```

# 参考文献


