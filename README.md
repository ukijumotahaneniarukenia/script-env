# マイインストーラの実行

- rootユーザーでmy-installer.shを実行

# docker install
- インストール手順公式HP
  - https://docs.docker.com/install/linux/docker-ce/centos/

- より簡単にいんすこできるようになった
  - https://github.com/docker/docker-install

- my-installer.shに組み込んでおきたい部分

# dockerホスト環境構築

- バージョン確認
```
$cat /etc/redhat-release
CentOS Linux release 7.7.1908 (Core)
```

# visudoでdockerグループに属するユーザーはroot権限をもつように修正

- my-installer.shに組み込んでおきたい部分
```
[root♥centos (金 10月 04 20:39:17) /home/aine]$visudo

## Allows people in group wheel to run all commands
%wheel    ALL=(ALL)        ALL
%docker    ALL=(ALL)        ALL
```

# レポジトリ構成

  - script-template
    - プログラム単位のテンプーレトファイルを管理
    - ディレクトリ構成はscript-sketchと同じ

  - script-sketch
    - プログラム単位にディレクトリを切って運用
    - プログラム単位のディレクトリ名はscript-envの単一アプリ名

    - ファイル名は

      - 5桁ゼロうめ連番-プログラム名-用途名-non-alias名-alias名

      - alias名は~/.bashrcに追加するので、短くていい感じの名前をつけてあげる

    - エイリアスにするので、実行権限を付与しておく

  - script-env

    - os名-バージョン-アプリないしソフト名とそのバージョン単一ないし複数-エディタ単一
    - エディタデフォルトはvim

  - script-repo

    - プログラムのインストーラーシェル
    - プログラムのローンチシェル
    - 環境を高速に起動できるように自動化を意識

  - script-search

    - 上記レポジトリ全てを全文検索できるようにする

    - Web化する
      - 全文検索サーバgroonga
        - http://blog.createfield.com/entry/2014/04/21/120023
      - 全文検索サーバfess
        - https://fess.codelibs.org/ja/
        - https://qiita.com/Takumon/items/993609a4fc0fbb70c903
      - 全文検索サーバmroonga
        - https://mroonga.org/ja/docs/install.html

# md-doc.md

- dockerコンテナ操作を記載

# md-dev.md

- 開発マニュアルを記載

# md-env.md

- コンテナ個別の環境を記載

# md-trs.md

- 環境構築の際のトラブルシュートを記載

# md-ref.md

- 参考文献を記載

# md-man.md

- 上記マークダウンファイル以外に該当する内容を記載

# crontabで定期実行スクリプト作成

- 同時実行プロセス数はファイル単位で管理することにした。

- http://dqn.sakusakutto.jp/2012/06/cron_crontab9.html
- https://zenpou.hatenadiary.org/entry/20080715/1216133151
- https://qiita.com/mazgi/items/15e1fe7e130584343810
- https://qiita.com/onomame/items/71646c5517a39bcd01cc

バックアップ

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

確認

```
$crontab -l
```

プロセス確認

```
$ps aux | grep cron
```

起動ログの確認

```
$sudo less /var/log/cron
```

最後は手動push

秘密鍵をなくさない保証があれば、自動pushやりたいが、
定期的にOS換えるかもしれないので。今は手動pushでいいか。
- http://tm.root-n.com/unix:command:git:cron_git_push

強制終了

```
su root

ps aux  | grep 'docker build' | awk '{print $2}' | xargs kill
```
