# 参考文献
[最新版Rstudio](https://www.rstudio.com/products/rstudio/download/preview/)

# ブラウザから起動確認
```
http://192.168.1.109:18787/
```

# Dockerfileよりイメージ作成
```
time docker build -t centos_rstudio . | tee log
```

# dockerコンテナ削除
```
docker ps -qa | xargs -I@ bash -c 'docker stop @ && docker rm @'
```

# dockerイメージ削除
```
docker images | awk '$1=="<none>"{print $3}' | xargs -I@ docker rmi @
```

# dockerコンテナ作成
```
docker run --privileged -v /etc/localtime:/etc/localtime -p 18787:8787 -p 10022:22 --name rstudio -itd centos_rstudio /sbin/init
```

# dockerコンテナ潜入
```
[oracle@centos Rstudio]$ docker exec --user root -it rstudio /bin/bash
[oracle@centos Rstudio]$ docker exec --user rstudio -it rstudio /bin/bash
```
