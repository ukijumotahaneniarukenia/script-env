# 参考文献 
https://www.itmedia.co.jp/enterprise/articles/1604/27/news001.html

Xアプリでのフォントの設定
http://www.momonga-linux.org/docs/TTF-HOWTO/ja/fontpath.html

貴重なXtermの参考文献
https://invisible-island.net/xterm/xterm.html

Xtermの設定ファイル漁るgit
https://github.com/jfoscarini/.Xresources/blob/master/.Xresources

絵文字の表示幅
https://github.com/hamano/locale-eaw

ibusやりとり
https://github.com/ibus/ibus/issues/2005
https://github.com/ibus/ibus/issues/385

coredump味方
http://rabbitfoot141.hatenablog.com/entry/2016/11/14/153101

iBus最新
https://www.clear-code.com/blog/2018/7/25.html

iBus
https://wiki.archlinux.jp/index.php/IBus#.E5.88.9D.E6.9C.9F.E8.A8.AD.E5.AE.9A

日本語入力
https://sites.google.com/site/voidlinuxmemo/ri-ben-yu-huan-jing-1#TOC-mozc-

フォントキャッシュ作成する際に参照しているフォルダ見つける
```
[rstudio💗7c2d3e78e156 (土  9月 28 17:54:36) ~/IdeaProjects/untitled]$fc-cache -f -v
/usr/share/fonts: caching, new cache contents: 0 fonts, 3 dirs
/usr/share/fonts/dejavu: caching, new cache contents: 9 fonts, 0 dirs
/usr/share/fonts/liberation: caching, new cache contents: 4 fonts, 0 dirs
/usr/share/fonts/vlgothic: caching, new cache contents: 2 fonts, 0 dirs
/usr/share/X11/fonts/Type1: caching, new cache contents: 13 fonts, 0 dirs
/usr/share/X11/fonts/TTF: skipping, no such directory
/usr/local/share/fonts: skipping, no such directory
/home/rstudio/.local/share/fonts: skipping, no such directory
/home/rstudio/.fonts: skipping, no such directory
/usr/share/fonts/dejavu: skipping, looped directory detected
/usr/share/fonts/liberation: skipping, looped directory detected
/usr/share/fonts/vlgothic: skipping, looped directory detected
/usr/lib/fontconfig/cache: not cleaning unwritable cache directory
/home/rstudio/.cache/fontconfig: cleaning cache directory
/home/rstudio/.fontconfig: not cleaning non-existent cache directory
/usr/bin/fc-cache-64: succeeded
[rstudio💗7c2d3e78e156 (土  9月 28 17:54:41) ~/IdeaProjects/untitled]$fc-list>post
[rstudio💗7c2d3e78e156 (土  9月 28 17:54:47) ~/IdeaProjects/untitled]$ll
total 12
-rwxrwxr-x. 1 rstudio rstudio   35  9月 28 17:50 a.sh
-rw-rw-r--. 1 rstudio rstudio 2243  9月 28 17:54 post
-rw-rw-r--. 1 rstudio rstudio 2243  9月 28 17:54 pre
[rstudio💗7c2d3e78e156 (土  9月 28 17:54:49) ~/IdeaProjects/untitled]$diff post pre
```
展開したフォントファイルを参照しているフォルダにmvする。
```
[rstudio💗7c2d3e78e156 (土  9月 28 17:54:58) ~/IdeaProjects/untitled]$ll /usr/share/X11/fonts/TTF
ls: cannot access /usr/share/X11/fonts/TTF: No such file or directory
```

pam越え
https://blfs-support.linuxfromscratch.narkive.com/22HPbg3d/normal-user-cannot-start-x
```
[rstudio💞4931eb893dee (土  9月 28 17:25:28) /root]$find / -name "*pam_*so" 2>/dev/null
/usr/lib64/security/pam_namespace.so
/usr/lib64/security/pam_filter.so
/usr/lib64/security/pam_motd.so
/usr/lib64/security/pam_tty_audit.so
/usr/lib64/security/pam_limits.so
/usr/lib64/security/pam_succeed_if.so
/usr/lib64/security/pam_echo.so
/usr/lib64/security/pam_exec.so
/usr/lib64/security/pam_lastlog.so
/usr/lib64/security/pam_unix.so
/usr/lib64/security/pam_faildelay.so
/usr/lib64/security/pam_permit.so
/usr/lib64/security/pam_unix_acct.so
/usr/lib64/security/pam_selinux_permit.so
/usr/lib64/security/pam_group.so
/usr/lib64/security/pam_timestamp.so
/usr/lib64/security/pam_access.so
/usr/lib64/security/pam_umask.so
/usr/lib64/security/pam_warn.so
/usr/lib64/security/pam_debug.so
/usr/lib64/security/pam_issue.so
/usr/lib64/security/pam_sepermit.so
/usr/lib64/security/pam_rootok.so
/usr/lib64/security/pam_xauth.so
/usr/lib64/security/pam_chroot.so
/usr/lib64/security/pam_pwhistory.so
/usr/lib64/security/pam_systemd.so
/usr/lib64/security/pam_postgresok.so
/usr/lib64/security/pam_time.so
/usr/lib64/security/pam_tally2.so
/usr/lib64/security/pam_selinux.so
/usr/lib64/security/pam_loginuid.so
/usr/lib64/security/pam_shells.so
/usr/lib64/security/pam_console.so
/usr/lib64/security/pam_pwquality.so
/usr/lib64/security/pam_env.so
/usr/lib64/security/pam_unix_auth.so
/usr/lib64/security/pam_securetty.so
/usr/lib64/security/pam_faillock.so
/usr/lib64/security/pam_nologin.so
/usr/lib64/security/pam_listfile.so
/usr/lib64/security/pam_keyinit.so
/usr/lib64/security/pam_cap.so
/usr/lib64/security/pam_unix_passwd.so
/usr/lib64/security/pam_rhosts.so
/usr/lib64/security/pam_ftp.so
/usr/lib64/security/pam_localuser.so
/usr/lib64/security/pam_cracklib.so
/usr/lib64/security/pam_mkhomedir.so
/usr/lib64/security/pam_deny.so
/usr/lib64/security/pam_userdb.so
/usr/lib64/security/pam_unix_session.so
/usr/lib64/security/pam_stress.so
/usr/lib64/security/pam_mail.so
/usr/lib64/security/pam_wheel.so
/usr/lib64/security/pam_fprintd.so
/usr/lib64/security/pam_sss.so
/usr/lib64/security/pam_oddjob_mkhomedir.so
```

rootユーザー以外でもXアプリ起動できるか
http://www.turbolinux.com/support/document/knowledge/98.html
http://www.ep.sci.hokudai.ac.jp/~inex/y2006/1222/Debian_install/after_install.html

X.orgのWiki
https://www.x.org/wiki/


一般ユーザでstartxしたらFatal server errorと出る時の対策

PAM authentication failed, cannot start X server

http://blogcdn.rutake.com/blog/techmemo/2007/08/startxfatal_server_error.html
回避するために/etc/pam.d/xserverを編集

修正前
```
[root💟4931eb893dee (土  9月 28 17:02:42) /]$cat /etc/pam.d/xserver
#%PAM-1.0
auth       sufficient   pam_rootok.so
auth       required     pam_console.so
account    required     pam_permit.so
session    optional     pam_keyinit.so force revoke
```

修正後
pam_console.soをpam_permit.soに変更
```
#%PAM-1.0
auth       sufficient   pam_rootok.so
auth       required     pam_permit.so
account    required     pam_permit.so
session    optional     pam_keyinit.so force revoke
```

ファイルの場所
/etc/pam.d/xserver
```
[root❤4931eb893dee (土  9月 28 17:01:01) /]$ll /etc/pam.d/*
-rw-r--r--. 1 root root 272 10月 31  2018 /etc/pam.d/atd
-rw-r--r--. 1 root root 192  8月  9 12:09 /etc/pam.d/chfn
-rw-r--r--. 1 root root 192  8月  9 12:09 /etc/pam.d/chsh
-rw-r--r--. 1 root root 232  4月 11  2018 /etc/pam.d/config-util
-rw-r--r--. 1 root root 287  8月  9 08:07 /etc/pam.d/crond
-rw-r--r--. 1 root root 701  4月 11  2018 /etc/pam.d/fingerprint-auth
-rw-r--r--. 1 root root  97  8月  9 23:07 /etc/pam.d/liveinst
-rw-r--r--. 1 root root 796  8月  9 12:09 /etc/pam.d/login
-rw-r--r--. 1 root root 154  4月 11  2018 /etc/pam.d/other
-rw-r--r--. 1 root root 188  6月 10  2014 /etc/pam.d/passwd
-rw-r--r--. 1 root root 760  4月 11  2018 /etc/pam.d/password-auth
-rw-r--r--. 1 root root 155  9月 14 03:09 /etc/pam.d/polkit-1
-rw-r--r--. 1 root root 329  4月 11  2018 /etc/pam.d/postlogin
-rw-r--r--. 1 root root 681  8月  9 12:09 /etc/pam.d/remote
-rw-r--r--. 1 root root 143  8月  9 12:09 /etc/pam.d/runuser
-rw-r--r--. 1 root root 138  8月  9 12:09 /etc/pam.d/runuser-l
-rw-r--r--. 1 root root 145  6月 10  2014 /etc/pam.d/setup
-rw-r--r--. 1 root root 743  4月 11  2018 /etc/pam.d/smartcard-auth
lrwxrwxrwx. 1 root root  25  9月 28 13:15 /etc/pam.d/smtp -> /etc/alternatives/mta-pam
-rw-r--r--. 1 root root  76 10月 31  2018 /etc/pam.d/smtp.postfix
-rw-r--r--. 1 root root 904  8月  9 10:40 /etc/pam.d/sshd
-rw-r--r--. 1 root root 540  8月  9 12:09 /etc/pam.d/su
-rw-r--r--. 1 root root 137  8月  9 12:09 /etc/pam.d/su-l
-rw-r--r--. 1 root root 238  8月  9 11:57 /etc/pam.d/sudo
-rw-r--r--. 1 root root 216  8月  9 11:57 /etc/pam.d/sudo-i
-rw-r--r--. 1 root root 760  4月 11  2018 /etc/pam.d/system-auth
-rw-r--r--. 1 root root 129  9月 14 03:19 /etc/pam.d/systemd-user
-rw-r--r--. 1 root root  84 10月 31  2018 /etc/pam.d/vlock
-rw-r--r--. 1 root root 163  8月  9 12:28 /etc/pam.d/xserver
```

ブラウザで日本語入力
http://www.ep.sci.hokudai.ac.jp/~inex/y2006/1222/Debian_install/after_install.html

~/.xinitrcに記載
```
export LC_ALL=ja_JP.utf8
export LANGUAGE=ja_JP.utf8
export LANG=ja_JP.utf8
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
export DefalutIMModule=ibus
export NO_AT_BRIDGE=1
```

リナックスディレクトリ構成
https://oxynotes.com/?p=5987

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
https://medium.com/source-words/how-to-manually-install-update-and-uninstall-fonts-on-linux-a8d09a3853b0
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

Xtermコマンド
https://www.ibm.com/support/knowledgecenter/ja/ssw_aix_72/x_commands/xterm.html
http://x68000.q-e-d.net/~68user/unix/pickup?xterm
http://x68000.q-e-d.net/~68user/unix/pickup?kterm
https://www.ibm.com/support/knowledgecenter/ja/ssw_aix_72/a_commands/aixterm.html
https://www.ibm.com/support/knowledgecenter/ja/ssw_aix_71/d_commands/dtterm.html


キーボード入力
全角半角キー入力の設定
https://github.com/uim/uim-doc-ja/wiki/CustomizeUim

たぶんこれじゃないか2回目
https://slackware.jp/configuration/x_window_configuration.html
149行目コメントインして150行目をコメントアウトする
```
[root💝0f0a00fd19e2 (木  9月 26 20:23:49) /etc/X11]$vi /usr/share/X11/xkb/keycodes/evdev
[root💙0f0a00fd19e2 (木  9月 26 20:31:03) /]$grep -A15 -n Japan /usr/share/X11/xkb/keycodes/evdev
147:	// Keys that are generated on Japanese keyboards
148-
149-	//<HZTG> =  93;	// Hankaku/Zenkakau toggle - not actually used
150-	alias <HZTG> = <TLDE>;
151-	<HKTG> = 101;	// Hiragana/Katakana toggle
152-	<AB11> = 97;	// backslash/underscore
153-	<HENK> = 100;	// Henkan
154-	<MUHE> = 102;	// Muhenkan
155-	<AE13> = 132;	// Yen
156-	<KATA> =  98;	// Katakana
157-	<HIRA> =  99;	// Hiragana
158-	<JPCM> = 103;	// KPJPComma
159-	//<RO>   =  97;	// Romaji
160-
161-	// Keys that are generated on Korean keyboards
162-

```

docker側のキーボード入力設定
keyboard.confのデフォルト
```
[root💜0f0a00fd19e2 (木  9月 26 21:51:43) /]$cat /etc/X11/xorg.conf.d/00-keyboard.conf
# Read and parsed by systemd-localed. It's probably wise not to edit this file
# manually too freely.
Section "InputClass"
        Identifier "system-keyboard"
        MatchIsKeyboard "on"
        Option "XkbLayout" "us"
EndSection
```

dockerコンテナ側のキーボード入力設定
```
[rstudio❤centos (木  9月 26 21:53:49) ~/unko/script_scratch/x]$find / -name "*keyboard*" 2>/dev/null |& grep X11
/etc/X11/xorg.conf.d/00-keyboard.conf
/usr/include/X11/bitmaps/keyboard16
[rstudio❤centos (木  9月 26 21:54:05) ~/unko/script_scratch/x]$vi /etc/X11/xorg.conf.d/00-keyboard.conf
[rstudio❤centos (木  9月 26 21:54:20) ~/unko/script_scratch/x]$cat /etc/X11/xorg.conf.d/00-keyboard.conf
# Read and parsed by systemd-localed. It's probably wise not to edit this file
# manually too freely.
Section "InputClass"
        Identifier "system-keyboard"
        MatchIsKeyboard "on"
        Option "XkbLayout" "jp,jp"
        Option "XkbVariant" "kana,"
EndSection

```

==================================================================================

# X11の設定
X11でぐぐる
```
[root💘25d0f3ff0af4 (土  9月 28 14:01:36) /]$find / -name "*X11*" 2>/dev/null
/etc/X11
/usr/include/X11
/usr/lib64/X11
/usr/lib64/girepository-1.0/GdkX11-2.0.typelib
/usr/lib64/girepository-1.0/GdkX11-3.0.typelib
/usr/lib64/libX11.so
/usr/lib64/libX11-xcb.so
/usr/lib64/libX11-xcb.so.1.0.0
/usr/lib64/libX11.so.6.3.0
/usr/lib64/libX11-xcb.so.1
/usr/lib64/libX11.so.6
/usr/share/X11
/usr/share/gir-1.0/GdkX11-2.0.gir
/var/lib/yum/yumdb/l/4972906b4016cfe97055d73c789653847a916870-libX11-devel-1.6.7-2.el7-x86_64
/var/lib/yum/yumdb/l/db7e8655fc08c81313cd45ca17452adfafc45a60-libX11-1.6.7-2.el7-x86_64
/var/lib/yum/yumdb/l/fe8f43ef082c3f982a0f4bd7025416ae627fdeac-libX11-common-1.6.7-2.el7-noarch
/tmp/.X11-unix

```

# /etc/X11の場所
```
[root💘25d0f3ff0af4 (土  9月 28 14:02:26) /]$ll /etc/X11
total 24
-rw-r--r--. 1 root root  547  4月 11  2018 Xmodmap
-rw-r--r--. 1 root root  493  4月 11  2018 Xresources
drwxr-xr-x. 2 root root 4096  4月 11  2018 applnk
drwxr-xr-x. 1 root root 4096  9月 28 13:09 fontpath.d
drwxr-xr-x. 1 root root 4096  9月 28 13:26 xinit
drwxr-xr-x. 1 root root 4096  9月 14 03:19 xorg.conf.d
```

# /etc/X11/xorg.conf.dにキーボード設定ファイル
```
[root💘25d0f3ff0af4 (土  9月 28 14:35:30) /]$ll /etc/X11/xorg.conf.d/
total 4
-rw-r--r--. 1 root root 232 12月  4  2018 00-keyboard.conf

```

```
[root💘25d0f3ff0af4 (土  9月 28 14:36:50) /]$ll /etc/X11/xorg.conf.d/*
-rw-r--r--. 1 root root 232 12月  4  2018 /etc/X11/xorg.conf.d/00-keyboard.conf
[root💘25d0f3ff0af4 (土  9月 28 14:36:51) /]$cat /etc/X11/xorg.conf.d/00-keyboard.conf
# Read and parsed by systemd-localed. It's probably wise not to edit this file
# manually too freely.
Section "InputClass"
        Identifier "system-keyboard"
        MatchIsKeyboard "on"
        Option "XkbLayout" "us"
EndSection

```

# inputメソッド
50-xinput.sh
```
[root💘25d0f3ff0af4 (土  9月 28 14:06:42) /]$ll /etc/X11/xinit/xinitrc.d/*
-rwxr-xr-x. 1 root root  621  3月 14  2019 /etc/X11/xinit/xinitrc.d/00-start-message-bus.sh
-rwxr-xr-x. 1 root root 4228  8月  9 08:53 /etc/X11/xinit/xinitrc.d/50-xinput.sh
-rwxr-xr-x. 1 root root  543  4月 11  2018 /etc/X11/xinit/xinitrc.d/localuser.sh
-rwxr-xr-x. 1 root root  842  8月  9 23:07 /etc/X11/xinit/xinitrc.d/zz-liveinst.sh

```

# /usr/share/X11の場所
ここ！
```
[root💘25d0f3ff0af4 (土  9月 28 14:15:38) /]$ll /usr/share/X11
total 112
-rw-r--r--.  1 root root 42077 10月  9  2018 XErrorDB
drwxr-xr-x.  2 root root  4096  9月 28 13:07 app-defaults
drwxr-xr-x.  5 root root  4096  9月 28 13:09 fonts
drwxr-xr-x. 64 root root  4096  9月 28 13:07 locale
-rw-r--r--.  1 root root 17975  8月 12  2017 rgb.txt
drwxr-xr-x.  2 root root  4096  9月 28 13:07 x11perfcomp
drwxr-xr-x.  8 root root  4096  9月 28 13:09 xkb
drwxr-xr-x.  2 root root  4096  9月 28 13:18 xorg.conf.d

```

# /usr/share/X11/app-defaults/
Xアプリのデフォルト設定ファイルはここにあるXtermとかも


# X11のロケーる設定

```
[root💘25d0f3ff0af4 (土  9月 28 14:21:58) /]$ll /usr/share/X11/locale/ja_JP.UTF-8/*
-rw-r--r--. 1 root root   77  8月  9 09:39 /usr/share/X11/locale/ja_JP.UTF-8/Compose
-rw-r--r--. 1 root root  347 10月  9  2018 /usr/share/X11/locale/ja_JP.UTF-8/XI18N_OBJS
-rw-r--r--. 1 root root 2205  8月  9 09:39 /usr/share/X11/locale/ja_JP.UTF-8/XLC_LOCALE
```

# よくわからんがシェルスクリプトの勉強になる
awkよくつかわれているな
```
[root💘25d0f3ff0af4 (土  9月 28 14:23:44) /]$ll /usr/share/X11/x11perfcomp/*
-rwxr-xr-x. 1 root root 27271  8月 12  2017 /usr/share/X11/x11perfcomp/Xmark
-rwxr-xr-x. 1 root root   424  8月 12  2017 /usr/share/X11/x11perfcomp/fillblnk
-rwxr-xr-x. 1 root root   669  8月 12  2017 /usr/share/X11/x11perfcomp/perfboth
-rwxr-xr-x. 1 root root   624  8月 12  2017 /usr/share/X11/x11perfcomp/perfratio

```

# Xアプリで使用するキー配列を定義している設定ファイル
```
[root💘25d0f3ff0af4 (土  9月 28 14:27:04) /]$ll /usr/share/X11/xkb/compat/*
-rw-r--r--. 1 root root 1712  6月  5  2018 /usr/share/X11/xkb/compat/README
-rw-r--r--. 1 root root 1121  6月  5  2018 /usr/share/X11/xkb/compat/accessx
-rw-r--r--. 1 root root 1054  6月  5  2018 /usr/share/X11/xkb/compat/basic
-rw-r--r--. 1 root root  507  6月  5  2018 /usr/share/X11/xkb/compat/caps
-rw-r--r--. 1 root root  228  6月  5  2018 /usr/share/X11/xkb/compat/complete
-rw-r--r--. 1 root root 1644  6月  5  2018 /usr/share/X11/xkb/compat/iso9995
-rw-r--r--. 1 root root  986  6月  5  2018 /usr/share/X11/xkb/compat/japan
-rw-r--r--. 1 root root  469  6月  5  2018 /usr/share/X11/xkb/compat/ledcaps
-rw-r--r--. 1 root root  466  6月  5  2018 /usr/share/X11/xkb/compat/lednum
-rw-r--r--. 1 root root  486  6月  5  2018 /usr/share/X11/xkb/compat/ledscroll
-rw-r--r--. 1 root root 1396  6月  5  2018 /usr/share/X11/xkb/compat/level5
-rw-r--r--. 1 root root 2724  6月  5  2018 /usr/share/X11/xkb/compat/misc
-rw-r--r--. 1 root root 4604  6月  5  2018 /usr/share/X11/xkb/compat/mousekeys
-rw-r--r--. 1 root root 1133  6月  5  2018 /usr/share/X11/xkb/compat/olpc
-rw-r--r--. 1 root root  340  6月  5  2018 /usr/share/X11/xkb/compat/pc
-rw-r--r--. 1 root root 1226  6月  5  2018 /usr/share/X11/xkb/compat/pc98
-rw-r--r--. 1 root root 1842  6月  5  2018 /usr/share/X11/xkb/compat/xfree86
-rw-r--r--. 1 root root 1457  6月  5  2018 /usr/share/X11/xkb/compat/xtest

```

# ユーザーの入力イベントを定義している設定ファイル
```
[root💘25d0f3ff0af4 (土  9月 28 14:31:09) /]$ll /usr/share/X11/xorg.conf.d/*
-rw-r--r--. 1 root root 1099 11月  9  2018 /usr/share/X11/xorg.conf.d/10-evdev.conf
-rw-r--r--. 1 root root 1867  8月  9 12:28 /usr/share/X11/xorg.conf.d/10-quirks.conf
-rw-r--r--. 1 root root   92  8月  9 12:23 /usr/share/X11/xorg.conf.d/10-radeon.conf
-rw-r--r--. 1 root root  789 11月  9  2018 /usr/share/X11/xorg.conf.d/40-libinput.conf
-rw-r--r--. 1 root root 1706 11月  9  2018 /usr/share/X11/xorg.conf.d/50-synaptics.conf
-rw-r--r--. 1 root root  115 11月  9  2018 /usr/share/X11/xorg.conf.d/50-vmmouse.conf
-rw-r--r--. 1 root root 3025  8月  9 12:23 /usr/share/X11/xorg.conf.d/50-wacom.conf

```

# Xtermで絵文字表示
https://tmtms.hatenablog.com/entry/201811/windows-terminal


# dockerコンテナ削除
```
docker ps -qa | xargs -I@ bash -c 'docker stop @ && docker rm @'
```



# dockerイメージ作成
```
time docker build -t centos_xxx . | tee log

```

# dockerコンテナ作成
DISPLAYはDISPLAY=IP or ホスト名:ディスプレイ番号.ウィンドウ番号
```
docker run --privileged --shm-size=8gb --name xxx -itd -v /run/udev:/run/udev -v /run/systemd:/run/systemd -v /tmp/.X11-unix:/tmp/.X11-unix -v /var/lib/dbus:/var/lib/dbus -v /var/run/dbus:/var/run/dbus -v /etc/machine-id:/etc/machine-id -p 28787:8787 centos_xxx
```

# dockerコンテナ潜入
```
docker exec -it xxx /bin/bash
```
