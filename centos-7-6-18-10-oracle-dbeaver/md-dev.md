dbeaverからの接続は安定している
ドライバは12cだったけど、19cでも余裕だった

初期化セットアップ

**root**ユーザーで実行

```
root docker-container-centos-7-6-18-10-oracle-dbeaver /home/oracle$./init_db.sh delete_cdb

root docker-container-centos-7-6-18-10-oracle-dbeaver /home/oracle$./init_db.sh create_cdb

```

oracleユーザーで実行

pdb作成後、気持ち1分程待ってからリスナー登録するといいかんじ

```
[oracle@docker-container-centos-7-6-18-10-oracle-dbeaver ~]$ ./init_db.sh create_pdb 2

[oracle@docker-container-centos-7-6-18-10-oracle-dbeaver ~]$ ./init_db.sh create_listener 2

[oracle@docker-container-centos-7-6-18-10-oracle-dbeaver ~]$ ./init_db.sh create_user 1 2
```
