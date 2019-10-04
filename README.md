# script_scratch

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
Gtk-Message: 23:43:59.894: GtkDialog mapped without a transient parent. This is discouraged.
Moving DESKTOP directory from デスクトップ to Desktop
Moving DOWNLOAD directory from ダウンロード to Downloads
Moving TEMPLATES directory from テンプレート to Templates
Moving PUBLICSHARE directory from 公開 to Public
Moving DOCUMENTS directory from ドキュメント to Documents
Moving MUSIC directory from 音楽 to Music
Moving PICTURES directory from 画像 to Pictures
Moving VIDEOS directory from ビデオ to Videos
```

# rootユーザーでmy_installer.shを実行

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
