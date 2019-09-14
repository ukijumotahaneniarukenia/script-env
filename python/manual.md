# 参考文献

```
https://www.jetbrains.com/pycharm/download/#section=linux
```

# dockerコンテナ作成

```
docker run --privileged --shm-size=8gb --name python -itd -v /run/udev:/run/udev -v /run/systemd:/run/systemd -v /tmp/.X11-unix:/tmp/.X11-unix -v /var/lib/dbus:/var/lib/dbus -v /var/run/dbus:/var/run/dbus -v /etc/machine-id:/etc/machine-id centos_python /sbin/init
```

# dockerコンテナ潜入

```
docker exec -it python /bin/bash
```

# pycharm起動
![](~/1.png)
![](~/2.png)
![](~/3.png)
![](~/4.png)
![](~/5.png)
![](~/6.png)
![](~/7.png)
![](~/8.png)
![](~/9.png)
![](~/10.png)
![](~/11.png)
![](~/12.png)
![](~/13.png)
![](~/14.png)
![](~/15.png)
