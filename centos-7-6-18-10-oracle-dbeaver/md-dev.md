dbeaverからの接続は安定している
ドライバは12cだったけど、19cでも余裕だった

初期化セットアップ

**root**ユーザーで実行

```
root docker-container-centos-7-6-18-10-oracle-dbeaver /home/oracle$./init_db.sh delete_cdb

root docker-container-centos-7-6-18-10-oracle-dbeaver /home/oracle$./init_db.sh create_cdb

```

**oracle**ユーザーで実行

pdb作成後、気持ち1分程待ってからリスナー登録するといいかんじ

```
oracle docker-container-centos-7-6-18-10-oracle-dbeaver ~$./init_db.sh create_pdb 2

oracle docker-container-centos-7-6-18-10-oracle-dbeaver ~$./init_db.sh create_listener 2

oracle docker-container-centos-7-6-18-10-oracle-dbeaver ~$./init_db.sh create_user 1 2
```

-管理者 as sysdba
|key|value|
|:-:|:-:|
|Host|localhost|
|Port|1521|
|Database|ORCLCDB|
|ユーザー名|sys|
|パスワード|ORACLE_PWD|

|key|value|
|:-:|:-:|
|Host|localhost|
|Port|1521|
|Database|ORCLPDB01|
|ユーザー名|sys|
|パスワード|ORACLE_PWD|

|key|value|
|:-:|:-:|
|Host|localhost|
|Port|1521|
|Database|ORCLPDB02|
|ユーザー名|sys|
|パスワード|ORACLE_PWD|

-管理者以外
|key|value|
|:-:|:-:|
|Host|localhost|
|Port|1521|
|Database|ORCLPDB01|
|ユーザー名|user01|
|パスワード|ORACLE_PWD|

|key|value|
|:-:|:-:|
|Host|localhost|
|Port|1521|
|Database|ORCLPDB01|
|ユーザー名|user02|
|パスワード|ORACLE_PWD|

|key|value|
|:-:|:-:|
|Host|localhost|
|Port|1521|
|Database|ORCLPDB02|
|ユーザー名|user01|
|パスワード|ORACLE_PWD|

|key|value|
|:-:|:-:|
|Host|localhost|
|Port|1521|
|Database|ORCLPDB02|
|ユーザー名|user02|
|パスワード|ORACLE_PWD|


ドライバのプロパティタブを選択してダウンロード
