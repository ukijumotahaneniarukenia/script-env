rootユーザーで以下のスクリプトを実行

```
$cd /usr/local/src/script-repo
$bash ubuntu-19-10-healthcheck-mysql-8-X-X.sh
```

標準出力に以下のログが出力されればOK


```
mysqld will log errors to /var/log/mysql/error.log
mysqld is running as pid 1411
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
mysql        1  0.0  0.0   5108  1440 pts/0    Ss   21:53   0:00 bash /etc/init/run.sh
mysql        8  0.0  0.1  96080 37864 ?        S    21:53   0:00 fcitx
mysql        9  0.0  0.0   5372  2192 pts/0    S+   21:53   0:00 bash
mysql       14  0.0  0.0   6964   796 ?        S    21:53   0:00 dbus-launch --autolaunch bc74deaa9e044c079ed6fc963d084157 --binary-syntax --close-stderr
mysql       15  0.0  0.0   7064  1320 ?        Ss   21:53   0:00 /usr/bin/dbus-daemon --syslog-only --fork --print-pid 5 --print-address 7 --session
mysql       21  0.0  0.0   7064  1700 ?        Ss   21:53   0:00 /usr/bin/dbus-daemon --syslog --fork --print-pid 5 --print-address 7 --config-file /usr/share/fcitx/dbus/daemon.conf
mysql       25  0.0  0.0   5328   432 ?        SN   21:53   0:00 /usr/bin/fcitx-dbus-watcher unix:abstract=/tmp/dbus-gmhUjTdojE,guid=d753ea1a2bc3e6e73226ea965ec28558 21
mysql       26  0.0  0.0  73632 14324 ?        Sl   21:53   0:00 /usr/lib/mozc/mozc_server
mysql       43  0.0  0.0   5400  2364 pts/1    Ss   21:54   0:00 /bin/bash
root      1340  0.0  0.0   6456  2400 pts/1    S    22:15   0:00 su root
root      1341  0.0  0.0   5372  2368 pts/1    S    22:15   0:00 bash
root      1353  0.0  0.0   5160  1916 pts/1    S+   22:17   0:00 bash ubuntu-19-10-healthcheck-mysql-8-X-X.sh
mysql     1411  0.0  1.0 1935484 335180 ?      Sl   22:17   0:00 mysqld -D --user=mysql
root      1455  0.0  0.0   7008  1560 pts/1    R+   22:17   0:00 ps aux
2020-05-18T13:17:29.643055Z 0 [System] [MY-013169] [Server] /usr/sbin/mysqld (mysqld 8.0.20-0ubuntu0.19.10.1) initializing of server in progress as process 1364
2020-05-18T13:17:29.650492Z 1 [System] [MY-013576] [InnoDB] InnoDB initialization has started.
2020-05-18T13:17:30.506229Z 1 [System] [MY-013577] [InnoDB] InnoDB initialization has ended.
2020-05-18T13:17:32.501866Z 6 [Note] [MY-010454] [Server] A temporary password is generated for root@localhost: <26-ikkcxwbJ
2020-05-18T13:17:37.060858Z 0 [System] [MY-010116] [Server] /usr/sbin/mysqld (mysqld 8.0.20-0ubuntu0.19.10.1) starting as process 1409
2020-05-18T13:17:37.078212Z 1 [System] [MY-013576] [InnoDB] InnoDB initialization has started.
2020-05-18T13:17:37.355239Z 1 [System] [MY-013577] [InnoDB] InnoDB initialization has ended.
2020-05-18T13:17:37.455126Z 0 [System] [MY-011323] [Server] X Plugin ready for connections. Socket: '/var/run/mysqld/mysqlx.sock' bind-address: '::' port: 33060
2020-05-18T13:17:37.593732Z 0 [Warning] [MY-010068] [Server] CA certificate ca.pem is self signed.
2020-05-18T13:17:37.627311Z 0 [System] [MY-010931] [Server] /usr/sbin/mysqld: ready for connections. Version: '8.0.20-0ubuntu0.19.10.1'  socket: '/var/run/mysqld/mysqld.sock'  port: 3306  (Ubuntu).
mysql: [Warning] Using a password on the command line interface can be insecure.
mysql: [Warning] Using a password on the command line interface can be insecure.
+----------------+
| user()         |
+----------------+
| root@localhost |
+----------------+
+-------------------------+
| version()               |
+-------------------------+
| 8.0.20-0ubuntu0.19.10.1 |
+-------------------------+
+---------------------------------+------+
| rsv_args                        | ele  |
+---------------------------------+------+
| [{"x":"8"},{"x":"3"},{"x":"4"}] | 8    |
| [{"x":"8"},{"x":"3"},{"x":"4"}] | 3    |
| [{"x":"8"},{"x":"3"},{"x":"4"}] | 4    |
+---------------------------------+------+
+------+--------------+
| id   | item         |
+------+--------------+
|    1 | うんこ       |
|    2 | もりもり     |
|    3 | 森鴎外       |
+------+--------------+
+----------+
| count(*) |
+----------+
|        3 |
+----------+
mysql: [Warning] Using a password on the command line interface can be insecure.
+------------------+
| user()           |
+------------------+
| user01@localhost |
+------------------+
+-------------------------+
| version()               |
+-------------------------+
| 8.0.20-0ubuntu0.19.10.1 |
+-------------------------+
+---------------------------------+------+
| rsv_args                        | ele  |
+---------------------------------+------+
| [{"x":"8"},{"x":"3"},{"x":"4"}] | 8    |
| [{"x":"8"},{"x":"3"},{"x":"4"}] | 3    |
| [{"x":"8"},{"x":"3"},{"x":"4"}] | 4    |
+---------------------------------+------+
+------+--------------+
| id   | item         |
+------+--------------+
|    1 | うんこ       |
|    2 | もりもり     |
|    3 | 森鴎外       |
+------+--------------+
+----------+
| count(*) |
+----------+
|        3 |
+----------+
mysql: [Warning] Using a password on the command line interface can be insecure.
```
