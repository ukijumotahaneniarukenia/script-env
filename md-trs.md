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
