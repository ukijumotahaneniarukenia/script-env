# Dockerfileよりイメージ作成
```
time docker build -t centos_oracle . | tee log
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
docker run --privileged -v /etc/localtime:/etc/localtime -p 1521:1521 --name oracle -itd centos_oracle /sbin/init
```

# dockerコンテナ潜入

```
docker exec --user root -it mysql /bin/bash
```
