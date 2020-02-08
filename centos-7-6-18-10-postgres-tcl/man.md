# 参考文献


# dockerイメージ作成
```
time docker build -t centos-7-6-18-10-postgres-tcl . | tee log
```

# dockerコンテナ削除
```
docker ps -qa | xargs -I@ bash -c 'docker stop @ && docker rm @'
```

# dockerイメージ削除
```
docker images | awk '$1=="<none>"{print $3}' | xargs -I@ docker rmi @
```

# dockerコンテナ起動
```
docker run --privileged --shm-size=8gb --name centos-7-6-18-10-postgres-tcl -itd -v /etc/localtime:/etc/localtime -v /run/udev:/run/udev -v /run/systemd:/run/systemd -v /tmp/.X11-unix:/tmp/.X11-unix -v /var/lib/dbus:/var/lib/dbus -v /var/run/dbus:/var/run/dbus -v /etc/machine-id:/etc/machine-id centos-7-6-18-10-postgres-tcl
```

# dockerコンテナ潜入
```
docker exec --user postgres -it centos-7-6-18-10-postgres-tcl /bin/bash
```

# データ格納ディレクトリの作成

postgresユーザーで実行

```
$initdb -D ~/pgdat
```

# ポスグレプロセス起動

postgresユーザーで実行

```
$pg_ctl -D ~/pgdat -l ~/launch_postgres.log start
```

プロセス確認

```
$ps aux
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
postgres     1  0.0  0.0  42688  1576 pts/0    Ss+  21:30   0:00 /usr/sbin/init
postgres 25115  0.0  0.0  14376  2056 pts/1    Ss   22:20   0:00 /bin/bash
postgres 25138  0.0  0.0 171504 13592 ?        Ss   22:20   0:00 /usr/local/bin/postgres -D /home/postgres/pgdat
postgres 25140  0.0  0.0 171504   832 ?        Ss   22:20   0:00 postgres: checkpointer   
postgres 25141  0.0  0.0 171636  1320 ?        Ss   22:20   0:00 postgres: background writer   
postgres 25142  0.0  0.0 171504  5016 ?        Ss   22:20   0:00 postgres: walwriter   
postgres 25143  0.0  0.0 172056  2032 ?        Ss   22:20   0:00 postgres: autovacuum launcher   
postgres 25144  0.0  0.0  26056  1132 ?        Ss   22:20   0:00 postgres: stats collector   
postgres 25145  0.0  0.0 172060  1572 ?        Ss   22:20   0:00 postgres: logical replication launcher   
postgres 25147  0.0  0.0  54296  1860 pts/1    R+   22:21   0:00 ps aux
```

待受ポート確認
```
$lsof -i:5432
COMMAND    PID     USER   FD   TYPE  DEVICE SIZE/OFF NODE NAME
postgres 25138 postgres    3u  IPv4 2455508      0t0  TCP localhost:postgres (LISTEN)
```

ログ確認

```
$ll
total 12
-rw-------.  1 postgres postgres  764  1月 13 22:18 launch_postgres.log
drwx------. 19 postgres postgres 4096  1月 13 22:18 pgdat
$tail launch_postgres.log 
2020-01-13 22:20:40.359 JST [25138] LOG:  starting PostgreSQL 12.0 on x86_64-pc-linux-gnu, compiled by gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-39), 64-bit
2020-01-13 22:20:40.360 JST [25138] LOG:  listening on IPv4 address "127.0.0.1", port 5432
2020-01-13 22:20:40.360 JST [25138] LOG:  could not bind IPv6 address "::1": Cannot assign requested address
2020-01-13 22:20:40.360 JST [25138] HINT:  Is another postmaster already running on port 5432? If not, wait a few seconds and retry.
2020-01-13 22:20:40.367 JST [25138] LOG:  listening on Unix socket "/tmp/.s.PGSQL.5432"
2020-01-13 22:20:40.385 JST [25139] LOG:  database system was shut down at 2020-01-13 22:18:33 JST
2020-01-13 22:20:40.391 JST [25138] LOG:  database system is ready to accept connections
```

# データベース復元

postgresユーザーで実行
tarファイルある場所でリストア
事前にデータファイルをマウントするデータベースを作成しておく

```
$psql -U postgres -c "create database dvdrental"
$pg_restore -U postgres -d dvdrental dvdrental.tar
```

# データベース作成
postgresユーザーで実行
```
$psql -U postgres -c "create database testdb"
```

# データベース削除
postgresユーザーで実行
```
$psql -U postgres -c "drop database testdb"
```

# データベース一覧取得
postgresユーザーで実行
```
$psql -l
```
# データベース接続
postgresユーザーで実行
```
$psql -U postgres -d testdb
```


# ポスグレプロセス停止

postgresユーザーで実行
```
$pg_ctl -D ~/pgdat stop
```

プロセス確認
```
$ps aux
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
postgres     1  0.0  0.0  42688  1576 pts/0    Ss+  21:30   0:00 /usr/sbin/init
postgres 25043  0.0  0.0  14376  2116 pts/1    Ss   22:13   0:00 /bin/bash
postgres 25077  0.0  0.0  54296  1860 pts/1    R+   22:16   0:00 ps aux
```

ログ確認
```
$tail launch_postgres.log 
2020-01-13 22:22:19.122 JST [25138] LOG:  received fast shutdown request
2020-01-13 22:22:19.139 JST [25138] LOG:  aborting any active transactions
2020-01-13 22:22:19.140 JST [25138] LOG:  background worker "logical replication launcher" (PID 25145) exited with exit code 1
2020-01-13 22:22:19.141 JST [25140] LOG:  shutting down
2020-01-13 22:22:19.162 JST [25138] LOG:  database system is shut down
```



# tcl拡張について

# libtclダイナミックリンクファイル確認
```
$find / -name "*libtcl*.so*" 2>/dev/null
/usr/local/lib/libtcl8.6.so
/usr/local/src/tcl8.6.10/unix/libtcl8.6.so
/usr/lib64/libtcl.so
/usr/lib64/libtcl8.5.so
```

# pltclダイナミックリンクファイル確認

/usr/local/src/postgresql-12.0/src/pl/tclディレクトリでpltclダイナミックリンクファイルを作成した後、
/usr/local/lib/postgresqlディレクトリにコピーしていることがビルドログからわかった。

```
$find / -name "*pltcl*" 2>/dev/null | grep -P 'extension|so$' | sort
/usr/local/lib/postgresql/pltcl.so
/usr/local/share/postgresql/extension/pltcl--1.0.sql
/usr/local/share/postgresql/extension/pltcl--unpackaged--1.0.sql
/usr/local/share/postgresql/extension/pltcl.control
/usr/local/share/postgresql/extension/pltclu--1.0.sql
/usr/local/share/postgresql/extension/pltclu--unpackaged--1.0.sql
/usr/local/share/postgresql/extension/pltclu.control
/usr/local/src/postgresql-12.0/src/pl/tcl/pltcl.so
```

# tcl8.6バージョンのダイナミックリンクファイルを作成

バージョン8.5のときのコマンド
```
gcc -std=gnu99 -Wall -Wmissing-prototypes -Wpointer-arith -Wdeclaration-after-statement -Werror=vla -Wendif-labels -Wmissing-format-attribute -Wformat-security -fno-strict-aliasing -fwrapv -fexcess-precision=standard -O2 -fPIC -shared -o pltcl.so pltcl.o  -L../../../src/port -L../../../src/common    -Wl,--as-needed -Wl,-rpath,'/usr/local/lib',--enable-new-dtags  -L/usr/lib64 -ltcl8.5 -ldl -lpthread -lieee -lm -lc 
```

バージョン8.6ではこうする

-Lの引数をlibtcl8.6.soが存在しているディレクトリである/usr/local/libに変更する。

-lの引数をtcl8.6に変更

-oの引数をpltcl8.6.soに変更

```
gcc -std=gnu99 -Wall -Wmissing-prototypes -Wpointer-arith -Wdeclaration-after-statement -Werror=vla -Wendif-labels -Wmissing-format-attribute -Wformat-security -fno-strict-aliasing -fwrapv -fexcess-precision=standard -O2 -fPIC -shared -o pltcl8.6.so pltcl.o  -L../../../src/port -L../../../src/common    -Wl,--as-needed -Wl,-rpath,'/usr/local/lib',--enable-new-dtags  -L/usr/local/lib -ltcl8.6 -ldl -lpthread -lieee -lm -lc 
```


# 実行コマンド

```
cd /usr/local/src/postgresql-12.0/src/pl/tcl
gcc -std=gnu99 -Wall -Wmissing-prototypes -Wpointer-arith -Wdeclaration-after-statement -Werror=vla -Wendif-labels -Wmissing-format-attribute -Wformat-security -fno-strict-aliasing -fwrapv -fexcess-precision=standard -O2 -fPIC -shared -o pltcl8.6.so pltcl.o  -L../../../src/port -L../../../src/common    -Wl,--as-needed -Wl,-rpath,'/usr/local/lib',--enable-new-dtags  -L/usr/local/lib -ltcl8.6 -ldl -lpthread -lieee -lm -lc 
/usr/bin/install -c -m 755  /usr/local/src/postgresql-12.0/src/pl/tcl/pltcl8.6.so '/usr/local/lib/postgresql/pltcl8.6.so'
```


# ポスグレプロセスが参照するライブラリディレクトリをコンパイルオプションから変更

pltclダイナミックリンクファイルは/usr/local/lib/postgresqlに格納されるので、そこをみに行くようにコンパイルする。

以下の出力が得られるように
```
$pg_config --libdir
/usr/local/lib/postgresql
```

configureの引数を変更した。

```
 cd /usr/local/src && curl -LO https://ftp.postgresql.org/pub/source/v12.0/postgresql-12.0.tar.gz && \
tar xvf postgresql-12.0.tar.gz && \
chown -R root:root postgresql-12.0 && \
cd postgresql-12.0 && \
./configure --prefix=/usr/local --libdir=/usr/local/lib/postgresql --with-tcl && \
make -j12 && \
make -j12 install
```


# 実行結果確認

```
$find / -name "*pltcl*" 2>/dev/null | grep -P 'extension|so$' | sort
/usr/local/lib/postgresql/pltcl.so
/usr/local/lib/postgresql/pltcl8.6.so
/usr/local/share/postgresql/extension/pltcl--1.0.sql
/usr/local/share/postgresql/extension/pltcl--unpackaged--1.0.sql
/usr/local/share/postgresql/extension/pltcl.control
/usr/local/share/postgresql/extension/pltclu--1.0.sql
/usr/local/share/postgresql/extension/pltclu--unpackaged--1.0.sql
/usr/local/share/postgresql/extension/pltclu.control
/usr/local/src/postgresql-12.0/src/pl/tcl/pltcl.so
/usr/local/src/postgresql-12.0/src/pl/tcl/pltcl8.6.so
$ldd /usr/local/lib/postgresql/pltcl8.6.so
	linux-vdso.so.1 =>  (0x00007ffdaef6c000)
	libtcl8.6.so => /usr/local/lib/libtcl8.6.so (0x00007f77e0f6c000)
	libc.so.6 => /lib64/libc.so.6 (0x00007f77e0b9e000)
	libdl.so.2 => /lib64/libdl.so.2 (0x00007f77e099a000)
	libz.so.1 => /lib64/libz.so.1 (0x00007f77e0784000)
	libpthread.so.0 => /lib64/libpthread.so.0 (0x00007f77e0568000)
	libm.so.6 => /lib64/libm.so.6 (0x00007f77e0266000)
	/lib64/ld-linux-x86-64.so.2 (0x00007f77e15b2000)
$ldd /usr/local/lib/postgresql/pltcl.so
	linux-vdso.so.1 =>  (0x00007ffe7bfed000)
	libtcl8.5.so => /lib64/libtcl8.5.so (0x00007f1dce6dc000)
	libc.so.6 => /lib64/libc.so.6 (0x00007f1dce30e000)
	libdl.so.2 => /lib64/libdl.so.2 (0x00007f1dce10a000)
	libpthread.so.0 => /lib64/libpthread.so.0 (0x00007f1dcdeee000)
	libm.so.6 => /lib64/libm.so.6 (0x00007f1dcdbec000)
	/lib64/ld-linux-x86-64.so.2 (0x00007f1dcec13000)
```

ここで、思い切ってうわがいてみたらうまく行った。
複数のバージョンを併用する運用は殆ど無いような気がするので、
これでいい気がする。

コピーしてもリンクは引き継がれる

```
$sudo cp /usr/local/lib/postgresql/pltcl8.6.so /usr/local/lib/postgresql/pltcl.so
$sudo rm /usr/local/lib/postgresql/pltcl8.6.so
$ldd /usr/local/lib/postgresql/pltcl.so
	linux-vdso.so.1 =>  (0x00007ffcbf87d000)
	libtcl8.6.so => /usr/local/lib/libtcl8.6.so (0x00007f31bd515000)
	libc.so.6 => /lib64/libc.so.6 (0x00007f31bd147000)
	libdl.so.2 => /lib64/libdl.so.2 (0x00007f31bcf43000)
	libz.so.1 => /lib64/libz.so.1 (0x00007f31bcd2d000)
	libpthread.so.0 => /lib64/libpthread.so.0 (0x00007f31bcb11000)
	libm.so.6 => /lib64/libm.so.6 (0x00007f31bc80f000)
	/lib64/ld-linux-x86-64.so.2 (0x00007f31bdb5b000)
```


# 動作確認

作成するファンクション

```
create or replace function tcl_version()
returns text
as $$
  info tclversion
$$ language pltcl;
```

```
$initdb -D ~/pgdat

$pg_ctl -D ~/pgdat -l ~/launch_postgres.log start

$psql -U postgres -c "create database testdb"

$psql -U postgres -d testdb -c "SELECT * FROM pg_available_extensions;"
  name   | default_version | installed_version |                comment                
---------+-----------------+-------------------+---------------------------------------
 plpgsql | 1.0             | 1.0               | PL/pgSQL procedural language
 pltcl   | 1.0             |                   | PL/Tcl procedural language
 pltclu  | 1.0             |                   | PL/TclU untrusted procedural language
(3 rows)

$psql -U postgres -d testdb -c "CREATE EXTENSION pltcl;"

$psql -U postgres -d testdb -c "SELECT * FROM pg_available_extensions;"
  name   | default_version | installed_version |                comment                
---------+-----------------+-------------------+---------------------------------------
 plpgsql | 1.0             | 1.0               | PL/pgSQL procedural language
 pltcl   | 1.0             | 1.0               | PL/Tcl procedural language
 pltclu  | 1.0             |                   | PL/TclU untrusted procedural language
(3 rows)


$psql -U postgres -d testdb


create or replace function tcl_version()
returns text
as $$
  info tclversion
$$ language pltcl;

select tcl_version();

[postgres💓57335e935edf (水  1月 15 00:15:54) ~]$psql -U postgres -d testdb
psql (12.0)
Type "help" for help.

testdb=# create or replace function tcl_version()
testdb-# returns text
testdb-# as $$
testdb$#   info tclversion
testdb$# $$ language pltcl;
CREATE FUNCTION
testdb=# select tcl_version();
 tcl_version 
-------------
 8.6
(1 row)
```
