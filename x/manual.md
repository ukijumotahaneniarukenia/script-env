# 参考文献
https://www.itmedia.co.jp/enterprise/articles/1604/27/news001.html
https://satoru739.hatenadiary.com/entry/20111007/1318086532

xtermの色指定
https://heruwakame.hatenablog.com/entry/2017/10/21/232112
http://xjman.dsl.gr.jp/man/man1/xterm.1x.html

sqldevelperの日本語対応
http://cory-ora.hateblo.jp/entry/2015/05/25/102237

Xの日本語対応化
http://www.rcc.ritsumei.ac.jp/?p=6403

Xの日本語入力対応
https://qiita.com/ai56go/items/63abe54f2504ecc940cd
https://tkng.org/unixuser/200405/part1.html
https://tkng.org/unixuser/200405/part2.html
https://tkng.org/unixuser/200405/part3.html

# dockerコンテナ削除
```
docker ps -qa | xargs -I@ bash -c 'docker stop @ && docker rm @'
```

# dockerイメージ作成
```
time docker build -t centos_x . | tee log
```

# dockerコンテナ作成
DISPLAYはDISPLAY=IP or ホスト名:ディスプレイ番号.ウィンドウ番号
```
docker run --privileged --shm-size=8gb --name xxx -itd -v /run/udev:/run/udev -v /run/systemd:/run/systemd -v /tmp/.X11-unix:/tmp/.X11-unix -v /var/lib/dbus:/var/lib/dbus -v /var/run/dbus:/var/run/dbus -v /etc/machine-id:/etc/machine-id -p 28787:8787 -p 21521:1521 -p 25500:5500 centos_x /sbin/init
```

# dockerコンテナ潜入
```
docker exec -it xxx /bin/bash
```

# gui起動
jdkのパスを標準入力から与えて起動
標準出力とエラー出力をlogに吐くようにして、バッググラウンド起動
```
[root@3dc97af670ad /]$echo /usr/java/jdk1.8.0_221-amd64 | /opt/sqldeveloper/sqldeveloper.sh -conf /opt/sqldeveloper/sqldeveloper/bin/sqldeveloper.conf >log 2>&1 &
```

![](./1.png)
![](./2.png)
![](./3.png)
![](./4.png)

