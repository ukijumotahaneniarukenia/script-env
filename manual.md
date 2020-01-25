# docker-build-crontab.shファイルの作成

crontabコマンドで実行するスクリプト。

フォルダ名

os名-ソフト名-エディタ名

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

```
$mkdir -p ~/docker-build-log
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
http://tm.root-n.com/unix:command:git:cron_git_push

# 強制終了

```
su root

ps aux  | grep 'docker build' | awk '{print $2}' | xargs kill
```
