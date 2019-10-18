# 参考文献
https://www.slideshare.net/mobile/rakutentech/egison-44189985
https://www.egison.org/getting-started/getting-started-linux.html

# ghcインストール
haskellを動かすにはghc環境が必要
egisonを動かすにはhaskellが必要
https://www.haskell.org/ghc/download_ghc_8_8_1.html
https://haskell.jp/blog/posts/2019/stack-ghc8.8.html

# ghcの使い方
ダイナミック実行,コマンド文字列結合を中心に
https://downloads.haskell.org/~ghc/latest/docs/html/users_guide/ghci.html

# ghcとは
https://ja.wikipedia.org/wiki/Glasgow_Haskell_Compiler

# stackコマンドインストール
ghc環境におけるパッケージ管理コマンド
pythonのpipコマンド的な位置づけであろう（まだよくわかっていない）
https://haskell.e-bigmoon.com/stack/intro/stack-install.html
https://qiita.com/waddlaw/items/49874f4cf9b680e4b015

# haskellチュートリアル
https://wiki.haskell.org/Haskell%E5%85%A5%E9%96%80_5%E3%82%B9%E3%83%86%E3%83%83%E3%83%97
```
[sqlite💗b64e746d9822 (金 10月 18 23:45:29) ~]$echo "main=putStrLn \"hello\"" > hello.hs
[sqlite💗b64e746d9822 (金 10月 18 23:46:10) ~]$cat hello.hs 
main=putStrLn "hello"
[sqlite💗b64e746d9822 (金 10月 18 23:46:15) ~]$ghc -o hello hello.hs
[1 of 1] Compiling Main             ( hello.hs, hello.o )
Linking hello ...
[sqlite💗b64e746d9822 (金 10月 18 23:46:30) ~]$ll
total 192264
drwxrwxr-x 14 sqlite sqlite      4096 10月 18 23:25 ghc-8.8.1
-rw-rw-r--  1 sqlite sqlite 194601024 10月 18 23:20 ghc-8.8.1-x86_64-centos7-linux.tar.xz
-rwxrwxr-x  1 sqlite sqlite   2255992 10月 18 23:46 hello
-rw-rw-r--  1 sqlite sqlite       842 10月 18 23:46 hello.hi
-rw-rw-r--  1 sqlite sqlite        22 10月 18 23:46 hello.hs
-rw-rw-r--  1 sqlite sqlite      3184 10月 18 23:46 hello.o
[sqlite💗b64e746d9822 (金 10月 18 23:46:35) ~]$./hello
hello
```

# ghcインストール
```
[sqlite💚b64e746d9822 (金 10月 18 23:19:43) ~]$curl -LO https://downloads.haskell.org/~ghc/8.8.1/ghc-8.8.1-x86_64-centos7-linux.tar.xz

[sqlite💚b64e746d9822 (金 10月 18 23:21:21) ~]$tar -xvf ghc-8.8.1-x86_64-centos7-linux.tar.xz 
[sqlite💚b64e746d9822 (金 10月 18 23:21:53) ~]$cd ghc-8.8.1
[sqlite💚b64e746d9822 (金 10月 18 23:23:48) ~/ghc-8.8.1]$./configure --prefix=/usr/local | tee log
[sqlite💚b64e746d9822 (金 10月 18 23:26:09) ~/ghc-8.8.1]$sudo make -j12 install | tee logg
[sqlite💚b64e746d9822 (金 10月 18 23:26:09) ~/ghc-8.8.1]$which ghc
/usr/local/bin/ghc
[sqlite💚b64e746d9822 (金 10月 18 23:26:49) ~/ghc-8.8.1]$/usr/local/bin/ghc --version
The Glorious Glasgow Haskell Compilation System, version 8.8.1
```

# ghc動作確認
やった！
https://nekketsuuu.github.io/entries/2018/09/19/egison.html
https://haskell.e-bigmoon.com/stack/intro/stack-install.html
https://haskell.jp/blog/posts/2019/stack-ghc8.8.html
http://docs.haskellstack.org/en/stable/yaml_configuration/

```
[sqlite💚b64e746d9822 (金 10月 18 23:27:43) ~/ghc-8.8.1]$ghci
GHCi, version 8.8.1: https://www.haskell.org/ghc/  :? for help
Prelude> 1+2
3
Prelude> let x=42 in x/9
4.666666666666667
Prelude> x=42
Prelude> x
42
Prelude> 
Leaving GHCi.
```

# egisonインストール

stack install egisonは10分ぐらいかかる。

https://www.egison.org/

```
[sqlite💗b64e746d9822 (土 10月 19 00:01:25) ~]$sudo yum update
[sqlite💗b64e746d9822 (土 10月 19 00:01:25) ~]$sudo yum -y install https://git.io/egison.x86_64.rpm
[sqlite💗b64e746d9822 (土 10月 19 00:16:49) ~]$stack install egison
[sqlite💗b64e746d9822 (土 10月 19 00:16:49) ~]$echo "PATH=\$PATH:/home/sqlite/.local/bin" >> ~/.bashrc
[sqlite💗b64e746d9822 (土 10月 19 00:18:06) ~]$source ~/.bashrc
[sqlite💓b64e746d9822 (土 10月 19 00:18:15) ~]$which egison
~/.local/bin/egison
[sqlite💓b64e746d9822 (土 10月 19 00:18:26) ~]$egison --version
3.9.1
[sqlite💓b64e746d9822 (土 10月 19 00:18:34) ~]$egison
Egison Version 3.9.1 (C) 2011-2019 Satoshi Egi
https://www.egison.org
Welcome to Egison Interpreter!
> 1+2
Parse error at: "egison" (line 1, column 2):
unexpected '+'
expecting digit, "...", "_", "~", "~_", "|", "^" or end of input
> (define $x 2)
> (test (+ x 3))
5
```

