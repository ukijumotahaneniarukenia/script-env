# 参考文献
https://www.nodebeginner.org/index-jp.html</br>
https://github.com/nodesource/distributions/blob/master/README.md</br>

nodeのパッケージ管理にはyarnとnpmの2つがある
https://qiita.com/jigengineer/items/c75ca9b8f0e9ce462e99</br>

# dockerイメージ作成
```
time docker build -t centos-7-6-18-10-node . | tee log
```

# dockerコンテナ作成
```
docker run --privileged --shm-size=8gb -v /run/udev:/run/udev -v /run/systemd:/run/systemd -v /tmp/.X11-unix:/tmp/.X11-unix -v /var/lib/dbus:/var/lib/dbus -v /var/run/dbus:/var/run/dbus -v /etc/machine-id:/etc/machine-id -v /etc/localtime:/etc/localtime -p 8080:80 -p 5601:5601 -p 9200:9200 -itd --name centos-7-6-18-10-node centos-7-6-18-10-node
```

# dockerコンテナ潜入

```
docker exec --user kuraine -it centos-7-6-18-10-node /bin/bash
```

# 不要コンテナ削除

```
docker ps -a | grep -vE "node|tcl|mysql|racket|postgres|oracle|egison|java|sqlite" | awk '/Ex/{print $1}' | xargs docker rm
```

# 不要イメージ削除

```
docker images | awk '$1=="<none>"{print $3}' | xargs -I@ docker rmi @
```
