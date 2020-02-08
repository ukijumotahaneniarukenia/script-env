# dockerホスト環境
```
[aine💖centos (土  9月 28 19:53:59) ~/unko/x]$cat /etc/redhat-release 
CentOS Linux release 7.7.1908 (Core)
[aine💖centos (土  9月 28 19:56:33) ~/unko]$docker --version
Docker version 19.03.2, build 6a30dfc
```

# ideaで日本語入力はできた
表示位置が微妙。

# dockerコンテナ削除
```
docker ps -qa | xargs -I@ bash -c 'docker stop @ && docker rm @'
```

# dockerイメージ作成
```
time docker build -t centos-7-6-18-10-x . | tee log

```

# dockerコンテナ削除
```
docker images | awk '$1=="<none>"{print $3}' | xargs -I@ docker rmi @
```

# dockerコンテナ作成
```
docker run --privileged --shm-size=8gb --name xxx -itd -v /run/udev:/run/udev -v /run/systemd:/run/systemd -v /tmp/.X11-unix:/tmp/.X11-unix -v /var/lib/dbus:/var/lib/dbus -v /var/run/dbus:/var/run/dbus -v /etc/machine-id:/etc/machine-id -p 28787:8787 centos-7-6-18-10-x
```

```
docker run --privileged --shm-size=8gb --name xxx -itd -v /run/udev:/run/udev -v /run/systemd:/run/systemd -v /tmp/.X11-unix:/tmp/.X11-unix -v /var/lib/dbus:/var/lib/bus -v /var/run/dbus:/var/run/dbus -v /etc/machine-id:/etc/machine-id -v /etc/X11/xorg.conf.d/00-keyboard.conf:/etc/X11/xorg.conf.d/00-keyboard.conf centos-7-6-18-10-x
```

# Xアプリ転送許可設定
dockerコンテナ内のXアプリをdockerホストに転送許可する。 ローカルネットワーク内で存在する全てのマシンからのX転送を許可している。マシン単位で設定もできる。
```
xhost +local:
```

# dockerコンテナ潜入
```
docker exec -it xxx /bin/bash
```

# 課題
X経由のブラウザ日本語入力
ideaのターミナルで絵文字が表示できない。
絵文字フォント設定
