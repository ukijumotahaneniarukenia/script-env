# dockerイメージ作成

- キャッシュ有効-バッググラウンド実行

```
time docker build --no-cache -t centos-7-6-18-10-tclsh-vim --build-arg GIT_VERSION=2-24-1 --build-arg PYTHON_VERSION=3-7-4 --build-arg TCLSH_VERSION=8-6-10 --build-arg REPO=script-repo --build-arg APP_NAME= --build-arg OS_VERSION=$(echo centos-7-6-18-10-tclsh-vim | grep -Po '[a-z]{1,}(?:-[0-9]{1,}){1,}') . UNKO
```

- キャッシュ有効-フォアグラウンド実行

```
time docker build -t centos-7-6-18-10-tclsh-vim --build-arg GIT_VERSION=2-24-1 --build-arg PYTHON_VERSION=3-7-4 --build-arg TCLSH_VERSION=8-6-10 --build-arg REPO=script-repo --build-arg APP_NAME= --build-arg OS_VERSION=$(echo centos-7-6-18-10-tclsh-vim | grep -Po '[a-z]{1,}(?:-[0-9]{1,}){1,}') . | tee log
```

- キャッシュ無効

```
time docker build --no-cache -t centos-7-6-18-10-tclsh-vim --build-arg GIT_VERSION=2-24-1 --build-arg PYTHON_VERSION=3-7-4 --build-arg TCLSH_VERSION=8-6-10 --build-arg REPO=script-repo --build-arg APP_NAME= --build-arg OS_VERSION=$(echo centos-7-6-18-10-tclsh-vim | grep -Po '[a-z]{1,}(?:-[0-9]{1,}){1,}') . | tee log
```

# dockerコンテナ起動
```
docker run --privileged --shm-size=2gb --hostname=docker-container-centos-7-6-18-10-tclsh-vim -v /home/aine/script-env/centos-7-6-18-10-tclsh-vim/mnt:/home/aine/mnt -v /home/aine/Downloads-for-docker-container/centos-7-6-18-10-tclsh-vim:/home/aine/media -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v /etc/localtime:/etc/localtime -v /run/udev:/run/udev -v /run/systemd:/run/systemd -v /tmp/.X11-unix:/tmp/.X11-unix -v /var/lib/dbus:/var/lib/dbus -v /var/run/dbus:/var/run/dbus -v /etc/machine-id:/etc/machine-id  --name centos-7-6-18-10-tclsh-vim -itd centos-7-6-18-10-tclsh-vim
```

# dockerコンテナ潜入
```
docker exec -it centos-7-6-18-10-tclsh-vim /bin/bash
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

- 自身以外削除

```
docker ps -a | grep -vP $(pwd | sed 's;.*/;;') | awk '{print $1}' | grep -v CONTAINER | xargs -I@ bash -c 'docker stop @ && docker rm @'
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
