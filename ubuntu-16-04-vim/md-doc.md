# dockerイメージ作成

- キャッシュ有効-バッググラウンド実行

```
time docker build --no-cache -t ubuntu-16-04-vim --build-arg GIT_VERSION=2-24-1 --build-arg PYTHON_VERSION=3-7-4 --build-arg REPO=script-repo --build-arg OS_VERSION=$(echo ubuntu-16-04-vim | grep -Po '[a-z]{1,}(?:-[0-9]{1,}){1,}') . UNKO
```

- キャッシュ有効-フォアグラウンド実行

```
time docker build -t ubuntu-16-04-vim --build-arg GIT_VERSION=2-24-1 --build-arg PYTHON_VERSION=3-7-4 --build-arg REPO=script-repo --build-arg OS_VERSION=$(echo ubuntu-16-04-vim | grep -Po '[a-z]{1,}(?:-[0-9]{1,}){1,}') . | tee log
```

- キャッシュ無効

```
time docker build --no-cache -t ubuntu-16-04-vim --build-arg GIT_VERSION=2-24-1 --build-arg PYTHON_VERSION=3-7-4 --build-arg REPO=script-repo --build-arg OS_VERSION=$(echo ubuntu-16-04-vim | grep -Po '[a-z]{1,}(?:-[0-9]{1,}){1,}') . | tee log
```

# dockerコンテナ起動

- dockerコンテナ内でdockerホストのPID名前空間を借用しない場合

```
docker run --privileged --shm-size=2gb --hostname=doc-ubuntu-16-04-vim -v /home/aine/script-env/ubuntu-16-04-vim/mnt:/home/aine/mnt -v /home/aine/Downloads-for-docker-container/ubuntu-16-04-vim:/home/aine/media -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v /etc/localtime:/etc/localtime:ro -v /run/udev:/run/udev:ro -v /run/systemd:/run/systemd:ro -v /tmp/.X11-unix:/tmp/.X11-unix:ro -v /var/lib/dbus:/var/lib/dbus:ro -v /var/run/dbus:/var/run/dbus:ro -v /etc/machine-id:/etc/machine-id:ro -v /dev/dri:/dev/dri:ro -p 8080:80 --name ubuntu-16-04-vim -itd ubuntu-16-04-vim
```

- dockerコンテナ内でdockerホストのPID名前空間を借用する場合

```
docker run --privileged --pid=host --shm-size=2gb --hostname=doc-ubuntu-16-04-vim -v /home/aine/script-env/ubuntu-16-04-vim/mnt:/home/aine/mnt -v /home/aine/Downloads-for-docker-container/ubuntu-16-04-vim:/home/aine/media -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v /etc/localtime:/etc/localtime:ro -v /run/udev:/run/udev:ro -v /run/systemd:/run/systemd:ro -v /tmp/.X11-unix:/tmp/.X11-unix:ro -v /var/lib/dbus:/var/lib/dbus:ro -v /var/run/dbus:/var/run/dbus:ro -v /etc/machine-id:/etc/machine-id:ro -v /dev/dri:/dev/dri:ro -p 8080:80 --name ubuntu-16-04-vim -itd ubuntu-16-04-vim
```


# dockerコンテナ潜入
```
docker exec -it ubuntu-16-04-vim /bin/bash
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
