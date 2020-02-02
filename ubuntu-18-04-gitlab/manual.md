# gitlabのインストール

よくわからん。Jenkinsでいいんじゃないかな。

- https://about.gitlab.com/install/

# dockerイメージ作成

```
time docker build -t ubuntu-18-04-gitlab . | tee log
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
docker run --privileged --shm-size=8gb --name ubuntu-18-04-gitlab -itd -v /etc/localtime:/etc/localtime -v /run/udev:/run/udev -v /run/systemd:/run/systemd -v /tmp/.X11-unix:/tmp/.X11-unix -v /var/lib/dbus:/var/lib/dbus -v /var/run/dbus:/var/run/dbus -v /etc/machine-id:/etc/machine-id  ubuntu-18-04-gitlab
```

# dockerコンテナ潜入

```
docker exec -it ubuntu-18-04-gitlab /bin/bash
```
