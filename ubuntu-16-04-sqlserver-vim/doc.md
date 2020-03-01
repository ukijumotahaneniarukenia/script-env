# dockerイメージ作成

- キャッシュ有効-バッググラウンド実行

```
time docker build -t ubuntu-16-04-sqlserver-vim --build-arg GIT_VERSION=2-24-1 --build-arg PYTHON_VERSION=3-7-4 --build-arg SQLSERVER_VERSION=15-0-2000-5 --build-arg USER_NAME=$(echo ubuntu-16-04-sqlserver-vim | perl -pe 's/([a-zA-Z]+(?:-[0-9]+){1,})(.*)/\\1-install\\2/g') --build-arg CONTAINER_NAME=ubuntu-16-04-sqlserver-vim --build-arg OS_VERSION=$(echo ubuntu-16-04-sqlserver-vim | grep -Po '[a-z]{1,}(?:-[0-9]{1,}){1,}') . UNKO
```

- キャッシュ有効-フォアグラウンド実行

```
time docker build -t ubuntu-16-04-sqlserver-vim --build-arg GIT_VERSION=2-24-1 --build-arg PYTHON_VERSION=3-7-4 --build-arg SQLSERVER_VERSION=15-0-2000-5 --build-arg USER_NAME=$(echo ubuntu-16-04-sqlserver-vim | perl -pe 's/([a-zA-Z]+(?:-[0-9]+){1,})(.*)/\1-install\2/g') --build-arg CONTAINER_NAME=ubuntu-16-04-sqlserver-vim --build-arg OS_VERSION=$(echo ubuntu-16-04-sqlserver-vim | grep -Po '[a-z]{1,}(?:-[0-9]{1,}){1,}') . | tee log
```

- キャッシュ無効

```
time docker build --no-cache -t ubuntu-16-04-sqlserver-vim --build-arg GIT_VERSION=2-24-1 --build-arg PYTHON_VERSION=3-7-4 --build-arg SQLSERVER_VERSION=15-0-2000-5 --build-arg USER_NAME=$(echo ubuntu-16-04-sqlserver-vim | perl -pe 's/([a-zA-Z]+(?:-[0-9]+){1,})(.*)/\1-install\2/g') --build-arg CONTAINER_NAME=ubuntu-16-04-sqlserver-vim --build-arg OS_VERSION=$(echo ubuntu-16-04-sqlserver-vim | grep -Po '[a-z]{1,}(?:-[0-9]{1,}){1,}') . | tee log
```

# dockerコンテナ起動
```
docker run --privileged --shm-size=4gb -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v /etc/localtime:/etc/localtime -v /run/udev:/run/udev -v /run/systemd:/run/systemd -v /tmp/.X11-unix:/tmp/.X11-unix -v /var/lib/dbus:/var/lib/dbus -v /var/run/dbus:/var/run/dbus -v /etc/machine-id:/etc/machine-id -p 1433:1433 --name ubuntu-16-04-sqlserver-vim -itd ubuntu-16-04-sqlserver-vim
```

# dockerコンテナ潜入
```
docker exec -it ubuntu-16-04-sqlserver-vim /bin/bash
```

# dockerコンテナ削除

- ALL削除

```
docker ps -qa | xargs -I@ bash -c 'docker stop @ && docker rm @'
```

- Exit削除

```
docker ps -a | grep Exit | awk '{print $1}' | xargs -I@ bash -c 'docker stop @ && docker rm @'
```

- 単一削除

```
docker ps -a | grep -P $(pwd | sed 's;.*/;;') | awk '{print $1}' | xargs -I@ bash -c 'docker stop @ && docker rm @'
```

# dockerイメージ削除

- none削除

```
docker images | awk '$1=="<none>"{print $3}' | xargs -I@ docker rmi @
```

- 単一削除

```
docker ps -a | grep -P $(pwd | sed 's;.*/;;') | awk '{print $1}' | xargs -I@ docker rmi @
```
