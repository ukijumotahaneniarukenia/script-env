# dockerイメージ作成

- キャッシュ有効-バッググラウンド実行

```
time docker build -t ubuntu-16-04-postgres-python-vim --build-arg GIT_VERSION=2-24-1 --build-arg POSTGRES_VERSION=12-0 --build-arg PYTHON_VERSION=3-7-4 --build-arg APP_NAME=postgres-python-vim --build-arg OS_VERSION=$(echo ubuntu-16-04-postgres-python-vim | grep -Po '[a-z]{1,}(?:-[0-9]{1,}){1,}') . UNKO
```

- キャッシュ有効-フォアグラウンド実行

```
time docker build -t ubuntu-16-04-postgres-python-vim --build-arg GIT_VERSION=2-24-1 --build-arg POSTGRES_VERSION=12-0 --build-arg PYTHON_VERSION=3-7-4 --build-arg APP_NAME=postgres-python-vim --build-arg OS_VERSION=$(echo ubuntu-16-04-postgres-python-vim | grep -Po '[a-z]{1,}(?:-[0-9]{1,}){1,}') . | tee log
```

- キャッシュ無効

```
time docker build --no-cache -t ubuntu-16-04-postgres-python-vim --build-arg GIT_VERSION=2-24-1 --build-arg POSTGRES_VERSION=12-0 --build-arg PYTHON_VERSION=3-7-4 --build-arg APP_NAME=postgres-python-vim --build-arg OS_VERSION=$(echo ubuntu-16-04-postgres-python-vim | grep -Po '[a-z]{1,}(?:-[0-9]{1,}){1,}') . | tee log
```

# dockerコンテナ起動
```
docker run --privileged --shm-size=2gb --hostname=ubuntu-16-04-postgres-python-vim -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v /etc/localtime:/etc/localtime -v /run/udev:/run/udev -v /run/systemd:/run/systemd -v /tmp/.X11-unix:/tmp/.X11-unix -v /var/lib/dbus:/var/lib/dbus -v /var/run/dbus:/var/run/dbus -v /etc/machine-id:/etc/machine-id  --name ubuntu-16-04-postgres-python-vim -itd ubuntu-16-04-postgres-python-vim
```

# dockerコンテナ潜入
```
docker exec -it ubuntu-16-04-postgres-python-vim /bin/bash
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