# Dockerfileよりイメージ作成
```
time docker build -t centos_perl . | tee log
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
docker run --privileged -v /etc/localtime:/etc/localtime  --name perl -itd centos_perl /sbin/init
```

# dockerコンテナ潜入
```
docker exec --user rstudio -it perl /bin/bash
docker exec --user root -it perl /bin/bash
```

# 参考文献
https://www.d-wood.com/blog/2015/12/16_7734.html
http://www.omakase.org/perl/cpanm.html
https://codeday.me/jp/qa/20190817/1461604.html
https://perlmaven.com/min-max-sum-using-list-util
https://rpms.remirepo.net/rpmphp/all.php?what=jplesnik
https://papix.hatenablog.com/entry/2018/03/10/160838

# パッケージのインストール先
システムで使用しているperlのデフォルト的な場所
```
ll /usr/local/lib64/perl5
ll /usr/local/lib64/perl5/auto
```
