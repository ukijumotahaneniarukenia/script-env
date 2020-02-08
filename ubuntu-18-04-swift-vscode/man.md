# dockerイメージ作成

```
time docker build -t ubuntu-18-04-swift-vscode . | tee log
```

# dockerコンテナ削除

```
docker ps -qa | xargs -I@ bash -c 'docker stop @ && docker rm @'
```

# dockerイメージ削除

```
docker images | awk '$1=="<none>"{print $3}' | xargs -I@ docker rmi @
```

# dockerコンテナ起動

```
docker run --privileged --shm-size=8gb --name ubuntu-18-04-swift-vscode -itd -v /etc/localtime:/etc/localtime -v /run/udev:/run/udev -v /run/systemd:/run/systemd -v /tmp/.X11-unix:/tmp/.X11-unix -v /var/lib/dbus:/var/lib/dbus -v /var/run/dbus:/var/run/dbus -v /etc/machine-id:/etc/machine-id ubuntu-18-04-swift-vscode
```

# dockerコンテナ潜入

```
docker exec -it ubuntu-18-04-swift-vscode /bin/bash
```

# 動作確認

- https://github.com/ukijumotahaneniarukenia/Hatena-Textbook

- https://qiita.com/naokits/items/8f09ffc8bbc78ade366c


```
$cat a.swift
#!/usr/bin/env swift

let hello = "こんにちは"
print(hello)

// 遊び心で。。
let 挨拶 = "お世話になります"
print(挨拶)
$chmod 700 a.swift
$./a.swift
こんにちは
お世話になります
```
