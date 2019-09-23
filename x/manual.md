# 参考文献 https://www.itmedia.co.jp/enterprise/articles/1604/27/news001.html
https://satoru739.hatenadiary.com/entry/20111007/1318086532

xtermの色指定
https://heruwakame.hatenablog.com/entry/2017/10/21/232112
http://xjman.dsl.gr.jp/man/man1/xterm.1x.html

Xの日本語対応化
http://www.rcc.ritsumei.ac.jp/?p=6403

Xの日本語入力対応
https://qiita.com/ai56go/items/63abe54f2504ecc940cd
https://tkng.org/unixuser/200405/part1.html
https://tkng.org/unixuser/200405/part2.html
https://tkng.org/unixuser/200405/part3.html

http://note.kurodigi.com/xterm-customize/#id304
https://solist.work/blog/posts/mozc/

日本語のロケール問題

https://www.linux.ambitious-engineer.com/?p=984

http://slavartemp.blogspot.com/2013/06/xming-teraterm-ssh-lubuntu-x.html

X11とはみたいな
http://nmaruichi.la.coocan.jp/XawDoc/Xaw02.html

X11における日本語フォントファイル
http://vega.pgw.jp/~kabe/vsd/k14/

Xtermにおける日本語の表示に関して
http://vega.pgw.jp/~kabe/vsd/k14/xterm-fontsel.html
http://bogytech.blogspot.com/2019/

Xの仕組み
http://luozengbin.github.io/blog/2014-06-21-%5B%E3%83%A1%E3%83%A2%5D%E3%83%AA%E3%83%A2%E3%83%BC%E3%83%88x%E3%81%AE%E6%8E%A5%E7%B6%9A%E6%96%B9%E6%B3%95.html

iBusのしくみ
https://ja.opensuse.org/IBus

Xフォント
https://running-dog.net/2011/10/post_303.html
https://incompleteness-theorems.at.webry.info/201009/article_6.html
https://linuxjf.osdn.jp/JFdocs/XWindow-User-HOWTO-7.html
http://hajimete-program.com/blog/2017/04/15/debian8ubuntu%E3%81%A7xterm%E3%81%AE%E3%83%95%E3%82%A9%E3%83%B3%E3%83%88%E3%82%92%E5%A4%A7%E3%81%8D%E3%81%8F%E3%81%97%E3%81%A6%E3%80%81molokai%E3%83%86%E3%83%BC%E3%83%9E%E3%81%AB%E3%81%99%E3%82%8B/

すげぇ
https://running-dog.net/category/cat_kdeandqt

これじゃないか???

https://blog.goo.ne.jp/tabitom2002/e/a18ccc75ec1ff1bbc5909ee95e5f9408

ぶらうざ
https://www.hiroom2.com/centos/centos-7-ja/

dockerにmanいれる
https://okisanjp.hatenablog.jp/entry/2017/01/06/214353

日本語入力苦しい
http://pc.casey.jp/archives/153902376

Xアプリでのキー入力
https://wiki.archlinux.jp/index.php/Xorg_%E3%81%A7%E3%81%AE%E3%82%AD%E3%83%BC%E3%83%9C%E3%83%BC%E3%83%89%E8%A8%AD%E5%AE%9A?rdfrom=https%3A%2F%2Fwiki.archlinux.org%2Findex.php%3Ftitle%3DKeyboard_Configuration_in_Xorg_%28%25E6%2597%25A5%25E6%259C%25AC%25E8%25AA%259E%29%26redirect%3Dno

SuperはWindowsキー
https://linux.keicode.com/linux/japanese.php

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
docker run --privileged --shm-size=8gb --name xxx -itd -v /run/udev:/run/udev -v /run/systemd:/run/systemd -v /tmp/.X11-unix:/tmp/.X11-unix -v /var/lib/dbus:/var/lib/dbus -v /var/run/dbus:/var/run/dbus -v /etc/machine-id:/etc/machine-id -p 28787:8787 centos_x /sbin/init
```

# dockerコンテナ潜入
```
docker exec -it xxx /bin/bash
```
