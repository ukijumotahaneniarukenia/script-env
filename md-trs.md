# トラシュー

- 事象

```
fatal: could not read Username for 'https://github.com': No
```

- 原因

  - md-doc.mdの引数にREPO環境変数が設定されていない

- 対応

  - md-doc.mdの自動生成を行う

- 予防

  - ビルド前に実行するようにcronに仕込む

- 事象

```
make[2]: *** No rule to make target `../auto/config.mk'.  Stop.
```

- 原因

  - おそらく同時実行数が多すぎるため。単一実行では行けているので。

- 対応

  - ビルド対象リストを分割し、起動時刻をずらす。

- 予防

  - 時刻別に同時実行数を一覧で確認できるようにする。


- 事象

```
bash: 36-デフォルトユーザー以外を使用している環境のユーザー登録スクリプトの作成.sh: そのようなファイルやディレクトリはありません
使用法: grep [OPTION]... PATTERN [FILE]...
Try 'grep --help' for more information.
```

- 原因
  - フルパスで指定していない

- 対応

  - フルパスで記載

- 予防

  - linterとかあるけど、大量にエラーはかれて精神乱れそう。

- 事象

  - git repoのクローンが終わらない

- 原因
  - 同時にコネクション貼りすぎ

- 対応

  - docker buildできていないやつを再実行するようにスクリプトを修正

- 予防

  - 時刻別に同時実行数を一覧で確認できるようにする。

- 事象

  - font cannot install

```
You are using pip version 19.0.3, however version 20.1 is available.
You should consider upgrading via the 'pip install --upgrade pip' command.
cp: cannot stat ‘../opentype-svg/util’: No such file or directory
The command '/bin/sh -c cd /usr/local/src/$REPO && echo ./$OS_VERSION-config-font.sh | bash' returned a non-zero code: 1

real	5m45.217s
user	0m0.595s
sys	0m0.705s
aine@centos ~/script-env/centos-7-6-18-10-python-pycharm$cd -
```

- 原因
  - I dont know

- 対応

  - free

- 予防

  - not-free
