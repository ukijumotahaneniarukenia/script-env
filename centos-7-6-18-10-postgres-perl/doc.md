# dockerイメージ作成
```
time docker build -t centos-7-6-18-10-postgres-perl . | tee log
```

# dockerコンテナ起動
```
docker run --privileged --shm-size=8gb -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v /etc/localtime:/etc/localtime -v /run/udev:/run/udev -v /run/systemd:/run/systemd -v /tmp/.X11-unix:/tmp/.X11-unix -v /var/lib/dbus:/var/lib/dbus -v /var/run/dbus:/var/run/dbus -v /etc/machine-id:/etc/machine-id -p 8080:8080 --name centos-7-6-18-10-postgres-perl -itd centos-7-6-18-10-postgres-perl
```

# dockerコンテナ潜入
```
docker exec -it centos-7-6-18-10-postgres-perl /bin/bash
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

# dockerイメージ削除
```
docker images | awk '$1=="<none>"{print $3}' | xargs -I@ docker rmi @
```
