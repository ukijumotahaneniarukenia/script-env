# dockerコンテナ削除
```
docker ps -qa | xargs -I@ bash -c 'docker stop @ && docker rm @'
```

# dockerイメージ作成
```
time docker build -t centos_xxx . | tee log

```

# dockerコンテナ作成
```
docker run --privileged --shm-size=8gb --name xxx -itd -v /run/udev:/run/udev -v /run/systemd:/run/systemd -v /tmp/.X11-unix:/tmp/.X11-unix -v /var/lib/dbus:/var/lib/dbus -v /var/run/dbus:/var/run/dbus -v /etc/machine-id:/etc/machine-id -p 28787:8787 centos_xxx
```

# Xアプリ転送許可設定
dockerコンテナ内のXアプリをdockerホストに転送許可する。 ローカルネットワーク内で存在する全てのマシンからのX転送を許可している。マシン単位で設定もできる。
```
xhost local:
```

# dockerコンテナ潜入
```
docker exec -it xxx /bin/bash
```

# 課題
X経由のブラウザ日本語入力
絵文字フォント設定
