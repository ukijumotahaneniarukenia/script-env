# dockerコンテナ作成

```
docker run --privileged --shm-size=2gb --name ubuntu-19-10-tex -itd -v /etc/localtime:/etc/localtime -v /run/udev:/run/udev -v /run/systemd:/run/systemd -v /tmp/.X11-unix:/tmp/.X11-unix -v /var/lib/dbus:/var/lib/dbus -v /var/run/dbus:/var/run/dbus -v /etc/machine-id:/etc/machine-id ubuntu-19-10-tex
```

# dockerイメージ作成

```
time docker build -t ubuntu-19-10-tex . | tee log
```

# dockerコンテナ潜入

```
docker exec -it ubuntu-19-10-tex /bin/bash
```
