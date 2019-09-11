# 参考文献
https://www.nodebeginner.org/index-jp.html
https://github.com/nodesource/distributions/blob/master/README.md

nodeのパッケージ管理にはyarnとnpmの2つがある
https://qiita.com/jigengineer/items/c75ca9b8f0e9ce462e99

#dockerイメージ作成
```
time docker build -t centos_node . | tee log
```

#dockerコンテナ作成
```
docker run --privileged -v /etc/localtime:/etc/localtime -p 180:80 -itd --name node centos_node /sbin/init
```

