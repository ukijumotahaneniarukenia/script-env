# script_scratch

# Apache sole
全文検索エンジン

バックアップとリストアできる。

https://qiita.com/n_slender/items/eb629cfbc53d38eac2f1

- https://qiita.com/reflet/items/add376c6046b4e7048cf

# 参考文献
docker install
[インストール手順公式HP](https://docs.docker.com/install/linux/docker-ce/centos/)

より簡単にいんすこできるようになった
- https://github.com/docker/docker-install

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


# doc.md

- dockerコンテナ操作を記載

# dev.md

- 開発マニュアルを記載

# env.md

- コンテナ個別の環境を記載

# docker-build-crontab.shファイルの作成

crontabコマンドで実行するスクリプト。

フォルダ名

os名-ソフト名(単一ないしは複数)-エディタ名

script_envフォルダ配下をビルド対象にする。

作成後、実行権限を与える。所有者のみ実行できるように設定。

```
$ls -l /home/aine/script_env/docker-build-crontab.sh
-rw-rw-r--. 1 aine aine 93  1月 25 15:16 /home/aine/script_env/docker-build-crontab.sh

$chmod 700 /home/aine/script_env/docker-build-crontab.sh

$ls -l /home/aine/script_env/docker-build-crontab.sh
-rwx------. 1 aine aine 93  1月 25 15:16 /home/aine/script_env/docker-build-crontab.sh
```

# crontabで定期実行スクリプト作成

http://dqn.sakusakutto.jp/2012/06/cron_crontab9.html </br>
https://zenpou.hatenadiary.org/entry/20080715/1216133151 </br>
https://qiita.com/mazgi/items/15e1fe7e130584343810 </br>

バックアップとってから
```
$crontab -l>~/script_env/docker-build-crontab
```

編集
```
$vi ~/script_env/docker-build-crontab
```

反映
```
crontab < ~/script_env/docker-build-crontab
```

以下を記載

毎日0時44分に起動する例。 </br>

https://qiita.com/onomame/items/71646c5517a39bcd01cc </br>

```
44 0 * * * /home/aine/script_env/docker-build-crontab.sh 1>~/docker-build-log/docker-build-$(date +\%Y-\%m-\%d_\%H-\%M-\%S).stdout.log 2>~/docker-build-log/docker-build-$(date +\%Y-\%m-\%d_\%H-\%M-\%S).stderr.log
```

確認

```
$crontab -l
```

実行ログ格納ディレクトリ作成

各コンテナログから集計した結果を格納

```
$mkdir -p ~/script_env/docker-build-log
```

# プロセス確認

```
$ps aux | grep cron
```

# 起動ログの確認

```
$sudo less /var/log/cron
```

# 最後は手動push

秘密鍵をなくさない保証があれば、自動pushやりたいが、
定期的にOS換えるかもしれないので。今は手動pushでいいか。
- http://tm.root-n.com/unix:command:git:cron_git_push

# 強制終了

```
su root

ps aux  | grep 'docker build' | awk '{print $2}' | xargs kill
```

