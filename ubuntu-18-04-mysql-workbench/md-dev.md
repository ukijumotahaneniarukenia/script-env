- LANGの問題だった
  workbenchはmysqlユーザーで実行

とうふ
```
$export LANG=ja_JP.utf8
$mysql-workbench
```

とうふじゃない
```
$export LANG=C
$mysql-workbench
```

```
$mysql-workbench 1>launch-mysql-workbench.log 2>&1 &
```
