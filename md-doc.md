# dockerイメージ作成

- キャッシュ有効-バッググラウンド実行

```
time docker build --no-cache -t XXX BUILD_ARG --build-arg REPO=INSTALLER_REPO --build-arg OS_VERSION=$(echo XXX | grep -Po '[a-z]{1,}(?:-[0-9]{1,}){1,}') . UNKO
```

- キャッシュ有効-フォアグラウンド実行

```
time docker build -t XXX BUILD_ARG --build-arg REPO=INSTALLER_REPO --build-arg OS_VERSION=$(echo XXX | grep -Po '[a-z]{1,}(?:-[0-9]{1,}){1,}') . | tee log
```

- キャッシュ無効

```
time docker build --no-cache -t XXX BUILD_ARG --build-arg REPO=INSTALLER_REPO --build-arg OS_VERSION=$(echo XXX | grep -Po '[a-z]{1,}(?:-[0-9]{1,}){1,}') . | tee log
```

# dockerコンテナ起動

- dockerコンテナ内でdockerホストのPID名前空間を借用しない場合

```
docker run --privileged --shm-size=SHM_SIZE --hostname=doc-XXX -v HHH/ENV_REPO/XXX/mnt:HHH/mnt -v HHH/Downloads-for-docker-container/XXX:HHH/media -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v /etc/localtime:/etc/localtime:ro -v /run/udev:/run/udev:ro -v /run/systemd:/run/systemd:ro -v /tmp/.X11-unix:/tmp/.X11-unix:ro -v /var/lib/dbus:/var/lib/dbus:ro -v /var/run/dbus:/var/run/dbus:ro -v /etc/machine-id:/etc/machine-id:ro -v /dev/dri:/dev/dri:ro EXPOSE --name XXX -itd XXX
```

- dockerコンテナ内でdockerホストのPID名前空間を借用する場合

```
docker run --privileged --pid=host --shm-size=SHM_SIZE --hostname=doc-XXX -v HHH/ENV_REPO/XXX/mnt:HHH/mnt -v HHH/Downloads-for-docker-container/XXX:HHH/media -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v /etc/localtime:/etc/localtime:ro -v /run/udev:/run/udev:ro -v /run/systemd:/run/systemd:ro -v /tmp/.X11-unix:/tmp/.X11-unix:ro -v /var/lib/dbus:/var/lib/dbus:ro -v /var/run/dbus:/var/run/dbus:ro -v /etc/machine-id:/etc/machine-id:ro -v /dev/dri:/dev/dri:ro EXPOSE --name XXX -itd XXX
```


# dockerコンテナ潜入
```
docker exec -it XXX /bin/bash
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
