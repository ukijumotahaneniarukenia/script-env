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

# dockerコンテナ作成
```
docker run --privileged --shm-size=8gb --name perl -itd -v /run/udev:/run/udev -v /run/systemd:/run/systemd -v /tmp/.X11-unix:/tmp/.X11-unix -v /var/lib/dbus:/var/lib/dbus -v /var/run/dbus:/var/run/dbus -v /etc/machine-id:/etc/machine-id -p 28787:8787 -p 20022:22 centos_perl /sbin/init
``` 

# dockerホスト内でxhostコマンドによるX転送許可

![](./1.png)
dockerコンテナ内のXアプリをdockerホストに転送許可する。
ローカルネットワーク内で存在する全てのマシンからのX転送を許可している。マシン単位で設定もできる。
```
[rstudio@centos ~/unko/script_scratch/perl]$xhost local:
non-network local connections being added to access control list
```
コンテナ破棄後、X転送許可を拒むようにする。
```
[rstudio@centos ~/unko/script_scratch/perl]$xhost -local:
non-network local connections being removed from access control list
```

# dockerコンテナ潜入
```
docker exec -it perl /bin/bash
```

# idea起動
![](./2.png)
![](./3.png)
![](./4.png)
![](./5.png)
![](./6.png)
![](./7.png)
![](./8.png)
![](./9.png)
![](./10.png)
![](./11.png)
![](./12.png)
![](./13.png)
![](./14.png)
![](./15.png)
![](./16.png)
![](./17.png)
![](./18.png)
![](./19.png)
![](./20.png)
![](./21.png)
![](./22.png)
![](./23.png)
![](./24.png)
![](./25.png)
![](./26.png)
![](./27.png)
![](./28.png)
![](./29.png)

# perlモジュールパスの通し方
```
[perl@12b1f46abf63 ~/pjj/p]$export PERL5LIB=/home/perl/perl5/lib/perl5:/home/perl/perl5/lib/perl5/x86_64-linux-thread-multi
[perl@12b1f46abf63 ~/pjj/p]$source ~/.bashrc
[perl@12b1f46abf63 ~/pjj/p]$perl -E 'say for @INC'
/home/perl/perl5/lib/perl5
/home/perl/perl5/lib/perl5/x86_64-linux-thread-multi
/usr/local/lib/perl5/site_perl/5.30.0/x86_64-linux
/usr/local/lib/perl5/site_perl/5.30.0
/usr/local/lib/perl5/5.30.0/x86_64-linux
/usr/local/lib/perl5/5.30.0
```

# ideaにperlモジュールパスを通す
Settings->Languages&Frameworks->External Libraries
「+」ボタンでフォルダ指定。
![](./30.png)

# 参考文献
https://papix.hatenablog.com/entry/2018/03/10/160838
https://dev.classmethod.jp/business/business-analytics/alteryx-r-libpaths/
https://qiita.com/aosho235/items/e8efd18364408231062d
https://qiita.com/xtetsuji/items/7007df9ff3b653c7326e
https://qiita.com/arene-calix/items/a08363db88f21c81d351
http://blog.hatak.net/2012/06/19/14234/
https://www.ibm.com/support/knowledgecenter/ja/ssw_aix_71/x_commands/xhost.html
https://unskilled.site/docker%E3%82%B3%E3%83%B3%E3%83%86%E3%83%8A%E3%81%AE%E4%B8%AD%E3%81%A7gui%E3%82%A2%E3%83%97%E3%83%AA%E3%82%B1%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%B3%E3%82%92%E8%B5%B7%E5%8B%95%E3%81%95%E3%81%9B%E3%82%8B/
https://www.d-wood.com/blog/2015/12/16_7734.html
http://www.omakase.org/perl/cpanm.html
https://codeday.me/jp/qa/20190817/1461604.html
https://perlmaven.com/min-max-sum-using-list-util
https://rpms.remirepo.net/rpmphp/all.php?what=jplesnik
https://papix.hatenablog.com/entry/2018/03/10/160838
https://www.javahelps.com/2015/04/install-intellij-idea-on-ubuntu.html
https://qiita.com/AnnPin/items/5f868f0c7cb5d1af306b
