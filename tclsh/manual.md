# TCL-readline機能
https://wiki.tcl-lang.org/page/Pure-tcl+readline


Ctrl+Dではなく、exitで抜ける。
```
[sqlite💕b64e746d9822 (土 10月 19 01:57:34) ~/tcl8.6.9/unix]$tclsh
>exit
[sqlite💕b64e746d9822 (土 10月 19 01:57:45) ~/tcl8.6.9/unix]$
```

# 参考文献
https://freesoftnet.co.jp/webfiles/tclkits/doc/TclCmdRef/UserCmd/tclsh_jp.htm
http://www.phys.shimane-u.ac.jp/tanaka_lab/lecture/joho/sec9.pdf

# 開発TREE
https://core.tcl-lang.org/index.html


# tclチュートリアル
https://wiki.tcl-lang.org/page/Tcl+Tutorial+Index


# tcl xml強み
https://wiki.tcl-lang.org/page/A+tDOM+Tutorial

# tclインストール
http://lfsbookja.osdn.jp/BLFS/svn-ja/general/tcl.html
https://sourceforge.net/projects/tcl/files/Tcl/
http://www.tcl-lang.org/doc/howto/compile.html

```
[sqlite💗b64e746d9822 (土 10月 19 01:26:22) ~]$curl -LO https://sourceforge.net/projects/tcl/files/Tcl/8.6.9/tcl8.6.9-src.tar.gz
[sqlite💗b64e746d9822 (土 10月 19 01:28:09) ~]$tar xvf tcl8.6.9-src.tar.gz 
[sqlite💗b64e746d9822 (土 10月 19 01:28:37) ~]$cd tcl8.6.9
[sqlite💗b64e746d9822 (土 10月 19 01:34:46) ~/tcl8.6.9]$cd unix/
[sqlite💗b64e746d9822 (土 10月 19 01:35:39) ~/tcl8.6.9/unix]$./configure --prefix=/usr/local --enable-shared | tee log
[sqlite💗b64e746d9822 (土 10月 19 01:36:55) ~/tcl8.6.9/unix]$sudo make -j12 | tee logg
[sqlite💗b64e746d9822 (土 10月 19 01:37:51) ~/tcl8.6.9/unix]$sudo make install -j12 | tee loggg
[sqlite💗b64e746d9822 (土 10月 19 01:41:58) ~/tcl8.6.9/unix]$echo alias tclsh="/usr/local/bin/tclsh8.6" >> ~/.bashrc
[sqlite💗b64e746d9822 (土 10月 19 01:41:58) ~/tcl8.6.9/unix]$echo alias tclsh="/usr/local/bin/tclsh8.6" >> ~/.bashrc
[sqlite💗b64e746d9822 (土 10月 19 01:42:45) ~/tcl8.6.9/unix]$source ~/.bashrc
```

# 動作確認

```
[sqlite💗b64e746d9822 (土 10月 19 01:40:35) ~/tcl8.6.9/unix]$find / -name "*tclsh*" 2>/dev/null
/usr/bin/tclsh
/usr/bin/tclsh8.5
/usr/local/bin/tclsh8.6
/usr/local/man/man1/tclsh.1
/home/sqlite/tcl8.6.9/doc/tclsh.1
/home/sqlite/tcl8.6.9/win/tclsh.rc
/home/sqlite/tcl8.6.9/win/tclsh.exe.manifest.in
/home/sqlite/tcl8.6.9/win/tclsh.ico
/home/sqlite/tcl8.6.9/unix/tclsh
[sqlite💕b64e746d9822 (土 10月 19 01:44:05) ~/tcl8.6.9/unix]$tclsh
% info tclversion
8.6
[sqlite💕b64e746d9822 (土 10月 19 01:45:27) ~/tcl8.6.9/unix]$tclsh
% puts うんこ
うんこ
```



# tclサンプル
https://qiita.com/akinori-ito/items/92ca39617773a2f48e0b
https://qiita.com/akinori-ito/items/a6abe82f4c814272f06c
https://qiita.com/akinori-ito/items/919edfd6c52cf0b37247#_reference-43be2037b7826774b1a9
https://github.com/mistachkin/jtcl/blob/master/src/main/scripts/paraffin.tcl





# sourceコマンド

コマンド置換
https://freesoftnet.co.jp/webfiles/tclkits/doc/tclcom.html

外部ファイルの切り出しに使える
https://freesoftnet.co.jp/webfiles/tclkits/doc/TclCmdRef/TclCmd/source_jp.htm


# utf-8らしい

https://freesoftnet.co.jp/webfiles/tclkits/doc/tcl.html


# 文字列つなぎのサンプル

https://qiita.com/qoLop/items/982a749fedeeb8fbe839#%E3%83%AA%E3%82%B9%E3%83%88%E3%82%92%E3%81%A4%E3%81%AA%E3%81%92%E3%81%A6hello-world


# これいいな
http://simplesandsamples.com/args.tcl.html
