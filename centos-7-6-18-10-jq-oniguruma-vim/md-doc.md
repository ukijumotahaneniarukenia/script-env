# dockerイメージ作成

- キャッシュ有効-バッググラウンド実行

```
time docker build --no-cache -t centos-7-6-18-10-jq-oniguruma-vim --build-arg JQ_VERSION=1-6 --build-arg GIT_VERSION=2-24-1 --build-arg PYTHON_VERSION=3-7-4 --build-arg REPO=script-repo --build-arg APP_NAME= --build-arg OS_VERSION=$(echo centos-7-6-18-10-jq-oniguruma-vim | grep -Po '[a-z]{1,}(?:-[0-9]{1,}){1,}') . UNKO
```

- キャッシュ有効-フォアグラウンド実行

```
time docker build -t centos-7-6-18-10-jq-oniguruma-vim --build-arg JQ_VERSION=1-6 --build-arg GIT_VERSION=2-24-1 --build-arg PYTHON_VERSION=3-7-4 --build-arg REPO=script-repo --build-arg APP_NAME= --build-arg OS_VERSION=$(echo centos-7-6-18-10-jq-oniguruma-vim | grep -Po '[a-z]{1,}(?:-[0-9]{1,}){1,}') . | tee log
```

- キャッシュ無効

```
time docker build --no-cache -t centos-7-6-18-10-jq-oniguruma-vim --build-arg JQ_VERSION=1-6 --build-arg GIT_VERSION=2-24-1 --build-arg PYTHON_VERSION=3-7-4 --build-arg REPO=script-repo --build-arg APP_NAME= --build-arg OS_VERSION=$(echo centos-7-6-18-10-jq-oniguruma-vim | grep -Po '[a-z]{1,}(?:-[0-9]{1,}){1,}') . | tee log
```

# dockerコンテナ起動
```
docker run --privileged --shm-size=2gb --hostname=docker-container-centos-7-6-18-10-jq-oniguruma-vim -v /home/aine/script-env/centos-7-6-18-10-jq-oniguruma-vim/mnt:$HOME/mnt -v $HOME/Downloads-for-docker-container/centos-7-6-18-10-jq-oniguruma-vim:$HOME/media -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v /etc/localtime:/etc/localtime -v /run/udev:/run/udev -v /run/systemd:/run/systemd -v /tmp/.X11-unix:/tmp/.X11-unix -v /var/lib/dbus:/var/lib/dbus -v /var/run/dbus:/var/run/dbus -v /etc/machine-id:/etc/machine-id  --name centos-7-6-18-10-jq-oniguruma-vim -itd centos-7-6-18-10-jq-oniguruma-vim
```

# dockerコンテナ潜入
```
docker exec -it centos-7-6-18-10-jq-oniguruma-vim /bin/bash
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
