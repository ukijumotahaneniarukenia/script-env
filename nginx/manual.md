# 参考文献
https://qiita.com/MuuKojima/items/afc0ad8309ba9c5ed5ee
https://www.nginx.com/resources/wiki/start/topics/tutorials/install/

# dockerイメージ作成
```
time docker build -t centos_nginx . | tee log
```

# dockerコンテナ起動
```
docker run --privileged -itd --name nginx -p 58787:8787 -p 8080:80 centos_nginx /sbin/init
```

# dockerコンテナ潜入
```
docker exec -it nginx /bin/bash
```

# httpdサービス起動
```
systemctl status httpd.service
systemctl start httpd.service
```

# ブラウザよりサービス起動確認
```
http://192.168.1.109:8080
```
