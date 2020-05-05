あんていしてる
dbeaver

コンテナ起動後、**postgres**ユーザーで実行755なので、実行できる

```
$bash /usr/local/src/script-repo/centos-7-6-18-10-healthcheck-postgres-12-X-with-python.sh
```


そのあとdbeaverに接続


|key|value|
|:-:|:-:|
|Host|localhost|
|Port|5432|
|Database|testdb|
|ユーザー名|postgres|
|パスワード|postgres_pwd|
