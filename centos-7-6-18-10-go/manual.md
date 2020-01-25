# go言語のデータベースある

https://godoc.org/modernc.org/ql


# 参考文献

https://tnishinaga.hatenablog.com/entry/2015/02/28/045304
https://github.com/astaxie/build-web-application-with-golang/blob/master/ja/01.1.md


# ビルド用にgo言語いんすこ
```
$mkdir ~/go1.4
$curl -LO https://dl.google.com/go/go1.4.3.linux-amd64.tar.gz
$tar xvf go1.4.3.linux-amd64.tar.gz -C ~/tmp/
$mv ~/tmp/go/* ~/go1.4
```

# 新バージョンのgo言語いんすこ
```
$curl -LO https://dl.google.com/go/go1.13.5.linux-amd64.tar.gz
$tar xvf go1.13.5.linux-amd64.tar.gz -C ~/tmp/
$cd ~/tmp/go/src/
$./all.bash
```

# ろぐ
##### API check
Go version is "go1.13.5", ignoring -next /root/tmp/go/api/next.txt

ALL TESTS PASSED
---
Installed Go for linux/amd64 in /root/tmp/go
Installed commands in /root/tmp/go/bin
*** You need to add /root/tmp/go/bin to your PATH.


# 環境設定
```
$mv /root/tmp/go /usr/local/go1.13
$echo "export GOROOT=/usr/local/go1.13">>~/.bashrc
$echo "export PATH=$PATH:$GOROOT/bin">>~/.bashrc
$source ~/.bashrc
```
