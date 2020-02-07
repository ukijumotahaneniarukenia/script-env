# dockerイメージ作成
```
time docker build -t ubuntu-19-10-java-apache-solr-vim --build-arg CONTAINER_NAME=ubuntu-19-10-java-apache-solr-vim --build-arg OS_VERSION=$(echo ubuntu-19-10-java-apache-solr-vim | grep -Po '[a-z]{1,}(?:-[0-9]{1,}){1,}') . | tee log
```

# dockerコンテナ起動
```
docker run --privileged --shm-size=4gb -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v /etc/localtime:/etc/localtime -v /run/udev:/run/udev -v /run/systemd:/run/systemd -v /tmp/.X11-unix:/tmp/.X11-unix -v /var/lib/dbus:/var/lib/dbus -v /var/run/dbus:/var/run/dbus -v /etc/machine-id:/etc/machine-id -p 8983 --name ubuntu-19-10-java-apache-solr-vim -itd ubuntu-19-10-java-apache-solr-vim
```

# dockerコンテナ潜入
```
docker exec -it ubuntu-19-10-java-apache-solr-vim /bin/bash
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

- ALL削除

```
docker images | awk '$1=="<none>"{print $3}' | xargs -I@ docker rmi @
```