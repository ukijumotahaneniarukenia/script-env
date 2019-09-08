# めも
手順確立後、elasticにマージ

# 参考文献
```
https://docs.fluentd.org/installation/before-install
```

# dockerイメージ作成
```
time docker build -t centos_fluentd . | tee log
```

# dockerコンテナ起動
```
docker run --privileged -itd --name fluentd centos_fluentd /sbin/init
```

# dockerコンテナ潜入
```
docker exec -it fluentd /bin/bash
```
