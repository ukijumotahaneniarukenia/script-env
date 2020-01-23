# vim-lspにするまではここら辺の開発環境がいいかな

https://qiita.com/tutuz/items/d055114c0ad29d5cfb59




# 参考文献
https://code.visualstudio.com/#alt-downloads
https://qiita.com/kusanoiskuzuno/items/c323446f2707f9950ebb
https://code.visualstudio.com/docs/?dv=linux64_rpm
http://www5d.biglobe.ne.jp/~noocyte/Programming/CharCode.html

# dockerイメージ削除
```
docker images | awk '$1=="<none>"{print $3}' | xargs -I@ docker rmi @
```

# dockerイメージ作成
```
time docker build -t centos_cccc . | tee log
```

# dockerコンテナ削除
```
docker ps -qa | xargs -I@ bash -c 'docker stop @ && docker rm @'
```

# dockerコンテナ起動
```
docker run --privileged --shm-size=8gb --name cccc -itd -v /run/udev:/run/udev -v /run/systemd:/run/systemd -v /tmp/.X11-unix:/tmp/.X11-unix -v /var/lib/dbus:/var/lib/dbus -v /var/run/dbus:/var/run/dbus -v /etc/machine-id:/etc/machine-id centos_cccc
```

# Xアプリ転送許可設定
dockerコンテナ内のXアプリをdockerホストに転送許可する。 ローカルネットワーク内で存在する全てのマシンからのX転送を許可している。マシン単位で設定もできる。
```
xhost local:
```

# dockerコンテナ潜入
```
docker exec -it cccc /bin/bash
```
