# レポジトリ管理にする基準

- script-scratchで作成してうまく汎用化できたアプリを
レポジトリ管理に変えるようにする。いい感じになるまでは
script-scratchレポジトリ管理に留める。


# 気付き

手元に環境がないときとある時で同じフォーマットの
Todoリストを生成する。

自動でTodoリストを作ろう。

リンクを集めるとき、以下の構成で単一ファイルに書き込むようにする。

コメント、リンク、タグ単一ないし複数

ていしゅうきで各ディレクトリに分配分類する。
各ディレクトリに参考文献用の単一ファイルを用意する。
そのファイルに書き込む。
スクラッチ開始するとき、その参考文献一行を切り取り
各作業ディレクトリスクラッチ始める。

# TODO

- 最終的には環境をダイナミックに作りたいが、それはまだ先。特にライブラリの依存関係。
ソースからビルドが安全か。

  - OS名とそのバージョン　単一
  - アプリとそのバージョン　単一ないし複数
  - メモリ量　システムデフォルトとコンテナ個別
  - ユーザー名　システムデフォルトとコンテナ個別

- DockerfileにEXPOSEがあってenv.mdにEXPOSEの記載がないものにたいするパッチ

- 以下のレポジトリ構成にする。

script-sketchとscript-scratchの中身は入れ替え。


  - script-ref

    - 定周期参考文献分配分類ジョブで配布する。元ネタ。
    - 単一ファイルのみ格納。
    - ファイルサイズが閾値10gb超えたらファイル分割する。splitコマンド使える。確かあった。bashに。

  - script-sketch
    
    - プログラム単位にディレクトリを切って運用する。

  - script-scratch

    - script-env単位にディレクトリを切って、
      運用する。

  - script-env

    - os名-バージョン-アプリないしソフト名とそのバージョン単一ないし複数-エディタ単一
    - エディタデフォルトはvim

  - script-repo

    - プログラムのインストーラーシェル

- 全文検索サーバ
  - grooo
  - http://blog.createfield.com/entry/2014/04/21/120023

- 全文検索サーバ

  - fess
  - https://fess.codelibs.org/ja/

  - https://qiita.com/Takumon/items/993609a4fc0fbb70c903


# 機械学習とフォルダ構成


- https://upura.hatenablog.com/entry/2018/12/28/225234

# 悩み

- バージョンをフォルダ名に出すかとまどい
- そのときがきたらだすとおもうので、出しやすくする仕組みづくり

  - dockerコンテナのビルド引数に各ソフトのバージョンを与えれば、ポータブルなスウィッチコンテナのできあがり
  - ということで、script-repoは単一を心がける

- CPUアーキテクト疎いからアーキテクト別のパタンがいまぱっとうかばない。

- COPY句でエディタハードにしているが、これもスクリプト化できればいいが、ちょっとむずかしいので、できるようになったら変数化したい

- この改修後、つぎからenvはフォークしてからいじってまーじする

これは勉強になる

- https://rcmdnk.com/blog/2015/07/03/computer-linux/


# script_scratch

# Apache sole
全文検索エンジン

バックアップとリストアできる。

- https://www.slideshare.net/mobile/techblogyahoo/apache-solr-62053171

- https://academy.gmocloud.com/know/20160106/1509

- https://qiita.com/n_slender/items/eb629cfbc53d38eac2f1

- https://qiita.com/reflet/items/add376c6046b4e7048cf

- https://qiita.com/n_slender/items/93216bae005ac96b75c4

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

# ref.md

- 参考文献を記載

- 参考文献定周期分配分類ジョブで書き込むファイル。

# man.md

- 上記マークダウンファイル以外に該当する内容を記載

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

