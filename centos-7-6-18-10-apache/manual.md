# Dockerfileよりイメージ作成
```
time docker build -t centos-7-6-18-10-apache . | tee log
```

# dockerコンテナ作成
```
docker run --privileged -v /etc/localtime:/etc/localtime -p 8080:80 --name httpd -itd centos-7-6-18-10-apache
```

# dockerコンテナ削除
```
docker ps -qa | xargs -I@ bash -c 'docker stop @ && docker rm @'
```

# dockerイメージ削除
```
docker images | awk '$1=="<none>"{print $3}' | xargs -I@ docker rmi @
```

# dockerコンテナ潜入
```
docker exec --user kuraine -it httpd bash
```

# httpd起動確認
```
systemctl status httpd
systemctl start httpd
```

# ブラウザから起動確認
```
http://192.168.1.109:8080/
```

![](./1.png)
