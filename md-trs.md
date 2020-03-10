# トラシュー

## 1.

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

## 2.

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


## 3.

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

