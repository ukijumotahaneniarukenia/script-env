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

# nginxサービス起動
```
[root@c043a1da5978 /]# systemctl start nginx.service
[root@c043a1da5978 /]# systemctl status nginx.service
● nginx.service - nginx - high performance web server
   Loaded: loaded (/usr/lib/systemd/system/nginx.service; disabled; vendor preset: disabled)
   Active: active (running) since Sun 2019-09-08 12:56:37 UTC; 11s ago
     Docs: http://nginx.org/en/docs/
  Process: 675 ExecStart=/usr/sbin/nginx -c /etc/nginx/nginx.conf (code=exited, status=0/SUCCESS)
 Main PID: 676 (nginx)
   CGroup: /docker/c043a1da5978e4330de2076e27c326e03a953f8b79922db60837442bff893b25/system.slice/nginx.service
           ├─676 nginx: master process /usr/sbin/nginx -c /etc/nginx/nginx.conf
           └─677 nginx: worker process
           ‣ 676 nginx: master process /usr/sbin/nginx -c /etc/nginx/nginx.conf

Sep 08 12:56:37 c043a1da5978 systemd[1]: Starting nginx - high performance web server...
Sep 08 12:56:37 c043a1da5978 systemd[1]: Started nginx - high performance web server.
```

# ブラウザよりサービス起動確認
```
http://192.168.1.109:8080
```
