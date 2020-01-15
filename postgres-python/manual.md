# 参考文献

https://www.postgresql.jp/document/11/html/plperl-funcs.html</br>

# dockerイメージ作成
```
time docker build -t centos_postgres-python . | tee log
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
docker run --privileged --shm-size=8gb --name postgres-python -itd -v /etc/localtime:/etc/localtime -v /run/udev:/run/udev -v /run/systemd:/run/systemd -v /tmp/.X11-unix:/tmp/.X11-unix -v /var/lib/dbus:/var/lib/dbus -v /var/run/dbus:/var/run/dbus -v /etc/machine-id:/etc/machine-id centos_postgres-python
```

# dockerコンテナ潜入
```
docker exec --user postgres -it postgres-python /bin/bash
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
postgres     1  0.0  0.0  42688  1576 pts/0    Ss+  22:35   0:00 /usr/sbin/init
postgres     7  0.0  0.0  14376  2084 pts/1    Ss   22:35   0:00 /bin/bash
postgres  4817  0.0  0.0 171504 13588 ?        Ss   22:55   0:00 /usr/local/bin/postgres -D /home/postgres/pgdat
postgres  4819  0.0  0.0 171504   832 ?        Ss   22:55   0:00 postgres: checkpointer   
postgres  4820  0.0  0.0 171504  1056 ?        Ss   22:55   0:00 postgres: background writer   
postgres  4821  0.0  0.0 171504   836 ?        Ss   22:55   0:00 postgres: walwriter   
postgres  4822  0.0  0.0 172056  2028 ?        Ss   22:55   0:00 postgres: autovacuum launcher   
postgres  4823  0.0  0.0  25924   968 ?        Ss   22:55   0:00 postgres: stats collector   
postgres  4824  0.0  0.0 172060  1572 ?        Ss   22:55   0:00 postgres: logical replication launcher   
postgres  4825  0.0  0.0  54296  1860 pts/1    R+   22:55   0:00 ps aux
```

待受ポート確認
```
$lsof -i:5432
COMMAND   PID     USER   FD   TYPE  DEVICE SIZE/OFF NODE NAME
postgres 4817 postgres    3u  IPv4 2745310      0t0  TCP localhost:postgres (LISTEN)
```

ログ確認

```
$ll
total 12
-rw-------.  1 postgres postgres  757  1月 13 22:55 launch_postgres.log
drwx------. 19 postgres postgres 4096  1月 13 22:55 pgdat
$tail launch_postgres.log 
2020-01-13 22:55:07.984 JST [4817] LOG:  starting PostgreSQL 12.0 on x86_64-pc-linux-gnu, compiled by gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-39), 64-bit
2020-01-13 22:55:07.986 JST [4817] LOG:  listening on IPv4 address "127.0.0.1", port 5432
2020-01-13 22:55:07.986 JST [4817] LOG:  could not bind IPv6 address "::1": Cannot assign requested address
2020-01-13 22:55:07.986 JST [4817] HINT:  Is another postmaster already running on port 5432? If not, wait a few seconds and retry.
2020-01-13 22:55:07.993 JST [4817] LOG:  listening on Unix socket "/tmp/.s.PGSQL.5432"
2020-01-13 22:55:08.008 JST [4818] LOG:  database system was shut down at 2020-01-13 22:54:58 JST
2020-01-13 22:55:08.012 JST [4817] LOG:  database system is ready to accept connections
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

# 他言語拡張可能一覧取得
postgresユーザーで実行
```
$psql -U postgres -d testdb -c "SELECT * FROM pg_available_extensions;"
    name    | default_version | installed_version |                  comment                  
------------+-----------------+-------------------+-------------------------------------------
 plpgsql    | 1.0             | 1.0               | PL/pgSQL procedural language
 plpython2u | 1.0             |                   | PL/Python2U untrusted procedural language
 plpythonu  | 1.0             |                   | PL/PythonU untrusted procedural language
(3 rows)
```

# python拡張!
postgresユーザーで実行
```
$psql -U postgres -d testdb -c "CREATE EXTENSION plpythonu;"
```

installed_versionに空白以外が出れば使える

postgresユーザーで実行
```
$psql -U postgres -d testdb -c "SELECT * FROM pg_available_extensions;"
    name    | default_version | installed_version |                  comment                  
------------+-----------------+-------------------+-------------------------------------------
 plpgsql    | 1.0             | 1.0               | PL/pgSQL procedural language
 plpython2u | 1.0             |                   | PL/Python2U untrusted procedural language
 plpythonu  | 1.0             | 1.0               | PL/PythonU untrusted procedural language
(3 rows)
```

# 動作確認

作成するファンクションは以下
```
create function pymx(a integer,b integer)
returns integer
as $$
  if a>b:
    return a
  return b
$$ LANGUAGE plpythonu;
```

postgresユーザーで実行
```
$psql -U postgres -d testdb
psql (12.0)
Type "help" for help.

testdb=# create function pymx(a integer,b integer)
testdb-# returns integer
testdb-# as $$
testdb$#   if a>b:
testdb$#     return a
testdb$#   return b
testdb$# $$ LANGUAGE plpythonu;
CREATE FUNCTION
testdb=# select n,pymx(n,3) from generate_series(1,5) as t(n);
 n | pymx 
---+------
 1 |    3
 2 |    3
 3 |    3
 4 |    4
 5 |    5
(5 rows)
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
postgres     1  0.0  0.0  42688  1576 pts/0    Ss+  22:35   0:00 /usr/sbin/init
postgres     7  0.0  0.0  14376  2088 pts/1    Ss   22:35   0:00 /bin/bash
postgres  4848  0.0  0.0  54296  1864 pts/1    R+   23:00   0:00 ps aux
```

ログ確認
```
$tail launch_postgres.log 
2020-01-13 22:59:57.737 JST [4817] LOG:  received fast shutdown request
2020-01-13 22:59:57.749 JST [4817] LOG:  aborting any active transactions
2020-01-13 22:59:57.750 JST [4817] LOG:  background worker "logical replication launcher" (PID 4824) exited with exit code 1
2020-01-13 22:59:57.750 JST [4819] LOG:  shutting down
2020-01-13 22:59:57.773 JST [4817] LOG:  database system is shut down
```

いけたときように、pythonバージョン確認スクリプト

https://note.nkmk.me/python-sys-platform-version-info/


むずかしい
```

echo "export LD_LIBRARY_PATH=/usr/local/lib" >> ~/.bashrc && \
source ~/.bashrc


$find / -name "*Python.h*" 2>/dev/null
/usr/local/include/python3.7m/Python.h
/usr/local/src/Python-3.7.4/Include/Python.h

これを実行後2系のヘッダファイルが追加される
yum install -y python-devel

python-develパッケージをインストールせずにヘッダファイルをコンパイルオプションに認識させることができれば、うまく行けそうな気がしている。

postgresのコンパイルオプション頑張る。
Gccの環境変数cpathにヘッダファイルが存在するディレクトリを指定する方法もあるらしい。パッケージインストする前に試してみる

https://sekisuiseien.com/computer/10626/

多分これで3系のヘッダファイルインストールできる。

https://awesome-linus.com/2018/02/02/python-h-no-such-file-or-directory/

https://stackoverflow.com/questions/21530577/fatal-error-python-h-no-such-file-or-directory

オプション引数で指定したヘッダファイルを読み込んでくれるといいんだけど
$find / -name "*Python.h*" 2>/dev/null
/usr/include/python2.7/Python.h
/usr/local/include/python3.7m/Python.h
/usr/local/src/Python-3.7.4/Include/Python.h

cd /usr/local/src && curl -LO https://ftp.postgresql.org/pub/source/v12.0/postgresql-12.0.tar.gz && \
tar xvf postgresql-12.0.tar.gz && \
chown -R root:root postgresql-12.0 && \
cd postgresql-12.0 && \
./configure --includedir=/usr/local/include/python3.7m --prefix=/usr/local --libdir=/usr/local/lib/postgresql --with-python && \
make -j12 && \
make -j12 install

■libpythonダイナミックリンクファイルの確認
$find / -name "*libpython*so*" 2>/dev/null
/usr/local/lib/libpython3.7m.so
/usr/local/lib/libpython3.7m.so.1.0
/usr/local/lib/libpython3.so
/usr/local/src/Python-3.7.4/libpython3.7m.so
/usr/local/src/Python-3.7.4/libpython3.7m.so.1.0
/usr/local/src/Python-3.7.4/libpython3.so
/usr/lib64/python2.7/config/libpython2.7.so
/usr/lib64/libpython2.7.so.1.0
/usr/lib64/libpython2.7.so

■plpythonダイナミックリンクファイルの確認
$find / -name "*plpython*so*" 2>/dev/null
/usr/local/lib/postgresql/plpython2.so
/usr/local/src/postgresql-12.0/src/pl/plpython/plpython2.so

$ldd /usr/local/lib/postgresql/plpython2.so
	linux-vdso.so.1 =>  (0x00007ffdfb164000)
	libpython2.7.so.1.0 => /usr/lib64/libpython2.7.so.1.0 (0x00007fc88b80d000)
	libpthread.so.0 => /usr/lib64/libpthread.so.0 (0x00007fc88b5f1000)
	libc.so.6 => /usr/lib64/libc.so.6 (0x00007fc88b223000)
	libdl.so.2 => /lib64/libdl.so.2 (0x00007fc88b01f000)
	libutil.so.1 => /lib64/libutil.so.1 (0x00007fc88ae1c000)
	libm.so.6 => /lib64/libm.so.6 (0x00007fc88ab1a000)
	/lib64/ld-linux-x86-64.so.2 (0x00007fc88bdf9000)

■共有ライブラリの依存関係情報を更新する

3系のファイルがない

https://kotaeta.com/54935823
レッドハット系のデフォルト設定ではリンクキャッシュ作成してくれないので、手動で作成する
$ldconfig -p | grep py
	libpython2.7.so.1.0 (libc6,x86-64) => /lib64/libpython2.7.so.1.0
	libpython2.7.so (libc6,x86-64) => /lib64/libpython2.7.so


拡張confファイルにしてダイナミックリンクライブラリフォルダを指定する
$cat /etc/ld.so.conf
include ld.so.conf.d/*.conf

$find / -name "*ld.so.conf*"
/etc/ld.so.conf
/etc/ld.so.conf.d

$echo '/usr/local/lib'>>/etc/ld.so.conf.d/local-ld.so.conf

$find / -name "*ld.so.conf*"
/etc/ld.so.conf
/etc/ld.so.conf.d
/etc/ld.so.conf.d/local-ld.so.conf

ldconfigコマンドでキャッシュを作成し
$ldconfig

３系のリンクが更新されたことを確認する
$ldconfig -p | grep py
	libpython3.7m.so.1.0 (libc6,x86-64) => /usr/local/lib/libpython3.7m.so.1.0
	libpython3.7m.so (libc6,x86-64) => /usr/local/lib/libpython3.7m.so
	libpython3.so (libc6,x86-64) => /usr/local/lib/libpython3.so
	libpython2.7.so.1.0 (libc6,x86-64) => /lib64/libpython2.7.so.1.0
	libpython2.7.so (libc6,x86-64) => /lib64/libpython2.7.so


$initdb -D ~/pgdat

$pg_ctl -D ~/pgdat -l ~/launch_postgres.log start

$psql -U postgres -c "create database testdb"

$psql -U postgres -d testdb -c "SELECT * FROM pg_available_extensions;"


$psql -U postgres -d testdb -c "CREATE EXTENSION plpython3u;"
ERROR:  could not open extension control file "/usr/local/share/postgresql/extension/plpython3u.control": No such file or directory

share配下にはないことを確認。src配下にあることを確認。
$find / -name "*plpython3u*" 2>/dev/null
/usr/local/src/postgresql-12.0/contrib/hstore_plpython/hstore_plpython3u.control
/usr/local/src/postgresql-12.0/contrib/hstore_plpython/hstore_plpython3u--1.0.sql
/usr/local/src/postgresql-12.0/contrib/ltree_plpython/ltree_plpython3u.control
/usr/local/src/postgresql-12.0/contrib/ltree_plpython/ltree_plpython3u--1.0.sql
/usr/local/src/postgresql-12.0/contrib/jsonb_plpython/jsonb_plpython3u--1.0.sql
/usr/local/src/postgresql-12.0/contrib/jsonb_plpython/jsonb_plpython3u.control
/usr/local/src/postgresql-12.0/src/pl/plpython/plpython3u.control
/usr/local/src/postgresql-12.0/src/pl/plpython/plpython3u--1.0.sql
/usr/local/src/postgresql-12.0/src/pl/plpython/plpython3u--unpackaged--1.0.sql

plpython2はあるのでまねする。

$find / -name "*plpython2u*" 2>/dev/null | grep share
/usr/local/share/postgresql/extension/plpython2u--1.0.sql
/usr/local/share/postgresql/extension/plpython2u.control
/usr/local/share/postgresql/extension/plpython2u--unpackaged--1.0.sql


rootユーザーでsrc配下のファイルをextensionフォルダにコピー

$find / -name "*plpython3u*" 2>/dev/null | grep -v contrib | xargs -I@ sudo cp @ /usr/local/share/postgresql/extension

コピーされたことを確認
$find / -name "*plpython3u*" 2>/dev/null | grep share
/usr/local/share/postgresql/extension/plpython3u.control
/usr/local/share/postgresql/extension/plpython3u--1.0.sql
/usr/local/share/postgresql/extension/plpython3u--unpackaged--1.0.sql

一覧に追加されたことを確認
$psql -U postgres -d testdb -c "SELECT * FROM pg_available_extensions;"
    name    | default_version | installed_version |                  comment                  
------------+-----------------+-------------------+-------------------------------------------
 plpgsql    | 1.0             | 1.0               | PL/pgSQL procedural language
 plpython3u | 1.0             |                   | PL/Python3U untrusted procedural language
 plpython2u | 1.0             |                   | PL/Python2U untrusted procedural language
 plpythonu  | 1.0             | 1.0               | PL/PythonU untrusted procedural language
(4 rows)

ポスグレのライブラリディレクトリの確認


$pg_config --libdir
/usr/local/lib/postgresql


■plpython3のダイナミックリンクファイル作成

cd /usr/local/src/postgresql-12.0/src/pl/plpython

gcc -std=gnu99 -Wall -Wmissing-prototypes -Wpointer-arith -Wdeclaration-after-statement -Werror=vla -Wendif-labels -Wmissing-format-attribute -Wformat-security -fno-strict-aliasing -fwrapv -fexcess-precision=standard -O2 -fPIC -shared -o plpython3.so plpy_cursorobject.o plpy_elog.o plpy_exec.o plpy_main.o plpy_planobject.o plpy_plpymodule.o plpy_procedure.o plpy_resultobject.o plpy_spi.o plpy_subxactobject.o plpy_typeio.o plpy_util.o  -L../../../src/port -L../../../src/common    -Wl,--as-needed -Wl,-rpath,'/usr/local/lib',--enable-new-dtags  -L/usr/local/lib -lpython3.7m -lpthread -ldl  -lutil -lm

sudo /usr/bin/install -c -m 755  /usr/local/src/postgresql-12.0/src/pl/plpython/plpython3.so '/usr/local/lib/postgresql/plpython3.so'


■plpythonダイナミックリンクファイルの再確認
$find / -name "*plpython*so*" 2>/dev/null
/usr/local/lib/postgresql/plpython2.so
/usr/local/lib/postgresql/plpython3.so
/usr/local/src/postgresql-12.0/src/pl/plpython/plpython2.so
/usr/local/src/postgresql-12.0/src/pl/plpython/plpython3.so

リンクもそれぞれできている

$ldd /usr/local/lib/postgresql/plpython2.so
	linux-vdso.so.1 =>  (0x00007ffc13680000)
	libpython2.7.so.1.0 => /usr/lib64/libpython2.7.so.1.0 (0x00007fd9c068f000)
	libpthread.so.0 => /usr/lib64/libpthread.so.0 (0x00007fd9c0473000)
	libc.so.6 => /usr/lib64/libc.so.6 (0x00007fd9c00a5000)
	libdl.so.2 => /lib64/libdl.so.2 (0x00007fd9bfea1000)
	libutil.so.1 => /lib64/libutil.so.1 (0x00007fd9bfc9e000)
	libm.so.6 => /lib64/libm.so.6 (0x00007fd9bf99c000)
	/lib64/ld-linux-x86-64.so.2 (0x00007fd9c0c7b000)
$ldd /usr/local/lib/postgresql/plpython3.so
	linux-vdso.so.1 =>  (0x00007ffee618f000)
	libpython3.7m.so.1.0 => /usr/local/lib/libpython3.7m.so.1.0 (0x00007f119c6d1000)
	libpthread.so.0 => /lib64/libpthread.so.0 (0x00007f119c4b5000)
	libc.so.6 => /lib64/libc.so.6 (0x00007f119c0e7000)
	libcrypt.so.1 => /lib64/libcrypt.so.1 (0x00007f119beb0000)
	libdl.so.2 => /lib64/libdl.so.2 (0x00007f119bcac000)
	libutil.so.1 => /lib64/libutil.so.1 (0x00007f119baa9000)
	libm.so.6 => /lib64/libm.so.6 (0x00007f119b7a7000)
	/lib64/ld-linux-x86-64.so.2 (0x00007f119ce54000)
	libfreebl3.so => /lib64/libfreebl3.so (0x00007f119b5a4000)

[postgres💓4bb6195edf6f (水  1月 15 08:50:54) ~]$psql -U postgres -d testdb -c "SELECT * FROM pg_available_extensions;"
    name    | default_version | installed_version |                  comment                  
------------+-----------------+-------------------+-------------------------------------------
 plpgsql    | 1.0             | 1.0               | PL/pgSQL procedural language
 plpython3u | 1.0             |                   | PL/Python3U untrusted procedural language
 plpython2u | 1.0             |                   | PL/Python2U untrusted procedural language
 plpythonu  | 1.0             |                   | PL/PythonU untrusted procedural language
(4 rows)


３系は難しいのかもしれない。
[postgres💓4bb6195edf6f (水  1月 15 08:50:57) ~]$psql -U postgres -d testdb -c "CREATE EXTENSION plpython3u;"
ERROR:  could not load library "/usr/local/lib/postgresql/plpython3.so": /usr/local/lib/postgresql/plpython3.so: undefined symbol: _Py_ZeroStruct
これはPythonのバージョン問題で、ポスグレのコンパイルオプションで読み込んでくれたヘッダファイルが2系だったためとおもわれ
```
