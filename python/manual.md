# 参考文献

```
https://www.jetbrains.com/pycharm/download/#section=linux
```

#dockerコンテナ作成

```
docker run --privileged --shm-size=8gb --name pypy -itd -v /run/udev:/run/udev -v /run/systemd:/run/systemd -v /tmp/.X11-unix:/tmp/.X11-unix -v /var/lib/dbus:/var/lib/dbus -v /var/run/dbus:/var/run/dbus -v /etc/machine-id:/etc/machine-id centos_python /sbin/init
```

#dockerコンテナ潜入

```
docker exec -it pypy /bin/bash
```

#pycharm起動
起動ログをひろう
```
/root/pycharm-community-2019.2.2/bin/pycharm.sh >log 2>&1 &
```
