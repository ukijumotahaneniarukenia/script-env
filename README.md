# script_scratch


# x環境のdockerでvisualboxインスコしてみる

https://www.kkaneko.jp/tools/virtualbox/virtualboxlinux.html


Arch linuxをインスこする
https://qiita.com/tomi_sheep/items/ddd9c7b0f0f7c774a222

# wsl内でシンボリックリンクを貼る

コマンドソフトウェアによっては参照できない場合があるので、
ホームディレクトリと近くに仕込んでおく。

https://kledgeb.blogspot.com/2017/01/wsl-70-bashwindows.html

# 参考文献
docker install
[インストール手順公式HP](https://docs.docker.com/install/linux/docker-ce/centos/)

# dockerホスト環境
```
[aine@centos ~]$ cat /etc/redhat-release
CentOS Linux release 7.7.1908 (Core)
```

# aineユーザーでデスクトップ環境日本語化
```
[aine@centos ~]$ LANG=C xdg-user-dirs-gtk-update
```

# rootユーザーでmy-installer.shを実行

# visudoでdockerグループに属するユーザーはroot権限をもつように修正
```
[root♥centos (金 10月 04 20:39:17) /home/aine]$visudo

## Allows people in group wheel to run all commands
%wheel    ALL=(ALL)        ALL
%docker    ALL=(ALL)        ALL
```

# ユーザーごとに自身のvim環境インストール
aineユーザーで実行
```
# 自身のvim環境クローン
git clone https://github.com/ukijumotahaneniarukenia/.vim.git ~/.vim && \
git clone https://github.com/ukijumotahaneniarukenia/dotfile.git ~/tmp && \
cd ~/tmp && \
#移動したいdotfileをchoiceしてHOMEディレクトリへ
mv rc/.[^.]* ~ && \
#用が済んだらリム
rm -rf ~/tmp

#vim plugin manager
mkdir -p ~/.vim/bundle && \
cd ~ && curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh && \
sh installer.sh ~/.vim/bundle && rm -rf installer.sh
```

# git commit!
```
[aine@centos unko]$ git pull
Already up-to-date.
[aine@centos unko]$ git add README.md 
[aine@centos unko]$ git commit -m "環境構築"

*** Please tell me who you are.

Run

  git config --global user.email "you@example.com"
  git config --global user.name "Your Name"

to set your account's default identity.
Omit --global to set the identity only in this repository.

fatal: unable to auto-detect email address (got 'aine@centos.(none)')
[aine@centos unko]$ git config --global user.email "mrchildrenkh1008@gmail.com"
[aine@centos unko]$ git config --global user.name "ukijumotahaneniarukenia"
[aine@centos unko]$ git commit -m "環境構築"
[master 8ee0283] 環境構築
 1 file changed, 13 insertions(+)
[aine@centos unko]$ git push -u origin master
Username for 'https://github.com': ukijumotahaneniarukenia
Password for 'https://ukijumotahaneniarukenia@github.com': 
Counting objects: 5, done.
Delta compression using up to 12 threads.
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 639 bytes | 0 bytes/s, done.
Total 3 (delta 2), reused 0 (delta 0)
remote: Resolving deltas: 100% (2/2), completed with 2 local objects.
To https://github.com/ukijumotahaneniarukenia/script_scratch.git
   c68aec2..8ee0283  master -> master
Branch master set up to track remote branch master from origin.

```
