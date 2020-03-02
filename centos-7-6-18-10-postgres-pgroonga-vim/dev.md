- ref
  - https://qiita.com/getpow/items/0fb2b0d6a5678896b4f4
  - https://pgroonga.github.io/install/centos.html#install-on-7

- rootユーザーで実行

```
yum install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-$(rpm -qf --queryformat="%{VERSION}" /etc/redhat-release)-$(rpm -qf --queryformat="%{ARCH}" /etc/redhat-release)/pgdg-redhat-repo-latest.noarch.rpm
yum install -y https://packages.groonga.org/centos/groonga-release-latest.noarch.rpm
yum install -y postgresql12-pgroonga
yum install -y groonga-tokenizer-mecab
echo 'postgres_pwd' | passwd --stdin postgres
echo 'postgres ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
```


- postgresユーザーで実行

```
su postgres
```

```
mkdir -p /var/lib/pgsql/pgdat
/usr/pgsql-12/bin/initdb -D ~/pgdat
/usr/pgsql-12/bin/pg_ctl -D ~/pgdat -l ~/launch-postgres.log start
lsof -i:5432
psql -U postgres -c "create database testdb"
```


```
bash-4.2$ psql -U postgres -d testdb
psql (12.2)
Type "help" for help.

testdb=# SELECT * FROM pg_available_extensions;
       name        | default_version | installed_version |                                    comment
-------------------+-----------------+-------------------+--------------------------------------------------------------------------------
 plpgsql           | 1.0             | 1.0               | PL/pgSQL procedural language
 pgroonga          | 2.2.2           |                   | Super fast and all languages supported full text search index based on Groonga
 pgroonga_database | 2.2.2           |                   | PGroonga database management module
(3 rows)


testdb=# CREATE EXTENSION pgroonga;
CREATE EXTENSION
testdb=# SELECT * FROM pg_available_extensions;
       name        | default_version | installed_version |                                    comment
-------------------+-----------------+-------------------+--------------------------------------------------------------------------------
 plpgsql           | 1.0             | 1.0               | PL/pgSQL procedural language
 pgroonga          | 2.2.2           | 2.2.2             | Super fast and all languages supported full text search index based on Groonga
 pgroonga_database | 2.2.2           |                   | PGroonga database management module
(3 rows)

CREATE TABLE memos (
  id integer,
  content text
);
CREATE INDEX pgroonga_content_index ON memos USING pgroonga (content);
INSERT INTO memos VALUES (1, 'PostgreSQL is a relational database management system.');
INSERT INTO memos VALUES (2, 'Groonga is a fast full text search engine that supports all languages.');
INSERT INTO memos VALUES (3, 'PGroonga is a PostgreSQL extension that uses Groonga as index.');
INSERT INTO memos VALUES (4, 'There is groonga command.');
INSERT INTO memos VALUES (10, 'あいうえお');
INSERT INTO memos VALUES (11, 'かきくけこ');
INSERT INTO memos VALUES (12, 'さしすせそ');
INSERT INTO memos VALUES (13, 'たちつてと');
INSERT INTO memos VALUES (14, 'なにぬねの');
INSERT INTO memos VALUES (15, 'はひふへほ');
INSERT INTO memos VALUES (16, 'まみむめも');
INSERT INTO memos VALUES (17, 'やゆよ');
INSERT INTO memos VALUES (18, 'らりるれろ');
INSERT INTO memos VALUES (19, 'わをん');


testdb=# \d+ memos
                                    Table "public.memos"
 Column  |  Type   | Collation | Nullable | Default | Storage  | Stats target | Description
---------+---------+-----------+----------+---------+----------+--------------+-------------
 id      | integer |           |          |         | plain    |              |
 content | text    |           |          |         | extended |              |
Indexes:
    "pgroonga_content_index" pgroonga (content)
Access method: heap


testdb=# select * from memos;
 id |                                content
----+------------------------------------------------------------------------
  1 | PostgreSQL is a relational database management system.
  2 | Groonga is a fast full text search engine that supports all languages.
  3 | PGroonga is a PostgreSQL extension that uses Groonga as index.
  4 | There is groonga command.
 10 | あいうえお
 11 | かきくけこ
 12 | さしすせそ
 13 | たちつてと
 14 | なにぬねの
 15 | はひふへほ
 16 | まみむめも
 17 | やゆよ
 18 | らりるれろ
 19 | わをん
(14 rows)

testdb=# SELECT * FROM memos WHERE content &@~ 'PGroonga OR PostgreSQL';
 id |                            content
----+----------------------------------------------------------------
  3 | PGroonga is a PostgreSQL extension that uses Groonga as index.
  1 | PostgreSQL is a relational database management system.
(2 rows)

testdb=# explain SELECT * FROM memos WHERE content &@~ 'PGroonga OR PostgreSQL';
                                      QUERY PLAN
--------------------------------------------------------------------------------------
 Index Scan using pgroonga_content_index on memos  (cost=0.00..43.63 rows=1 width=36)
   Index Cond: (content &@~ 'PGroonga OR PostgreSQL'::text)
(2 rows)

testdb=# SELECT * FROM memos WHERE content &@~ 'きく';
 id |  content
----+------------
 11 | かきくけこ
(1 row)


testdb=# explain SELECT * FROM memos WHERE content &@~ 'きく';
                                      QUERY PLAN
--------------------------------------------------------------------------------------
 Index Scan using pgroonga_content_index on memos  (cost=0.00..40.91 rows=1 width=36)
   Index Cond: (content &@~ 'きく'::text)
(2 rows)

testdb=# explain select * from memos;
                        QUERY PLAN
----------------------------------------------------------
 Seq Scan on memos  (cost=0.00..22.70 rows=1270 width=36)
(1 row)

testdb=# SELECT * FROM memos WHERE content &@~ 'あいう';
 id |  content
----+------------
 10 | あいうえお
(1 row)

testdb=#  INSERT INTO memos VALUES (20, 'あめんぼあかいなあいうえお');
INSERT 0 1
testdb=# SELECT * FROM memos WHERE content &@~ 'あいう';
 id |          content
----+----------------------------
 10 | あいうえお
 20 | あめんぼあかいなあいうえお
(2 rows)
```



- 拡張周りの環境

```
root@b3aa33d35d6b /$find / -name "*extension*" 2>/dev/null | grep pg
/usr/pgsql-12/include/server/extension
/usr/pgsql-12/share/extension

root@b3aa33d35d6b /$ls -lh /usr/pgsql-12/share/extension
total 212K
-rw-r--r--. 1 root root    0 11月 14 11:42 pgroonga--1.0.0--1.0.1.sql
-rw-r--r--. 1 root root    0 11月 14 11:42 pgroonga--1.0.1--1.0.2.sql
-rw-r--r--. 1 root root    0 11月 14 11:42 pgroonga--1.0.2--1.0.3.sql
-rw-r--r--. 1 root root    0 11月 14 11:42 pgroonga--1.0.3--1.0.4.sql
-rw-r--r--. 1 root root    0 11月 14 11:42 pgroonga--1.0.4--1.0.5.sql
-rw-r--r--. 1 root root    0 11月 14 11:42 pgroonga--1.0.5--1.0.6.sql
-rw-r--r--. 1 root root  514 11月 14 11:42 pgroonga--1.0.6--1.0.7.sql
-rw-r--r--. 1 root root    0 11月 14 11:42 pgroonga--1.0.7--1.0.8.sql
-rw-r--r--. 1 root root    0 11月 14 11:42 pgroonga--1.0.8--1.0.9.sql
-rw-r--r--. 1 root root    0 11月 14 11:42 pgroonga--1.0.9--1.1.0.sql
-rw-r--r--. 1 root root  330 11月 14 11:42 pgroonga--1.1.0--1.1.1.sql
-rw-r--r--. 1 root root    0 11月 14 11:42 pgroonga--1.1.1--1.1.2.sql
-rw-r--r--. 1 root root    0 11月 14 11:42 pgroonga--1.1.2--1.1.3.sql
-rw-r--r--. 1 root root    0 11月 14 11:42 pgroonga--1.1.3--1.1.4.sql
-rw-r--r--. 1 root root    0 11月 14 11:42 pgroonga--1.1.4--1.1.5.sql
-rw-r--r--. 1 root root    0 11月 14 11:42 pgroonga--1.1.5--1.1.6.sql
-rw-r--r--. 1 root root    0 11月 14 11:42 pgroonga--1.1.6--1.1.7.sql
-rw-r--r--. 1 root root    0 11月 14 11:42 pgroonga--1.1.7--1.1.8.sql
-rw-r--r--. 1 root root 2.1K 11月 14 11:42 pgroonga--1.1.8--1.1.9.sql
-rw-r--r--. 1 root root  139 11月 14 11:42 pgroonga--1.1.9--1.2.0.sql
-rw-r--r--. 1 root root  13K 11月 14 11:42 pgroonga--1.2.0--1.2.1.sql
-rw-r--r--. 1 root root 2.8K 11月 14 11:42 pgroonga--1.2.1--1.2.2.sql
-rw-r--r--. 1 root root    0 11月 14 11:42 pgroonga--1.2.2--1.2.3.sql
-rw-r--r--. 1 root root  33K 11月 14 11:42 pgroonga--1.2.3--2.0.0.sql
-rw-r--r--. 1 root root    0 11月 14 11:42 pgroonga--2.0.0--2.0.1.sql
-rw-r--r--. 1 root root    0 11月 14 11:42 pgroonga--2.0.1--2.0.2.sql
-rw-r--r--. 1 root root 1.6K 11月 14 11:42 pgroonga--2.0.2--2.0.3.sql
-rw-r--r--. 1 root root 3.1K 11月 14 11:42 pgroonga--2.0.3--2.0.4.sql
-rw-r--r--. 1 root root    0 11月 14 11:42 pgroonga--2.0.4--2.0.5.sql
-rw-r--r--. 1 root root 4.3K 11月 14 11:42 pgroonga--2.0.5--2.0.6.sql
-rw-r--r--. 1 root root 5.1K 11月 14 11:42 pgroonga--2.0.6--2.0.7.sql
-rw-r--r--. 1 root root    0 11月 14 11:42 pgroonga--2.0.7--2.0.8.sql
-rw-r--r--. 1 root root    0 11月 14 11:42 pgroonga--2.0.8--2.0.9.sql
-rw-r--r--. 1 root root 4.9K 11月 14 11:42 pgroonga--2.0.9--2.1.0.sql
-rw-r--r--. 1 root root    0 11月 14 11:42 pgroonga--2.1.0--2.1.1.sql
-rw-r--r--. 1 root root    0 11月 14 11:42 pgroonga--2.1.1--2.1.2.sql
-rw-r--r--. 1 root root    0 11月 14 11:42 pgroonga--2.1.2--2.1.3.sql
-rw-r--r--. 1 root root    0 11月 14 11:42 pgroonga--2.1.3--2.1.4.sql
-rw-r--r--. 1 root root    0 11月 14 11:42 pgroonga--2.1.4--2.1.5.sql
-rw-r--r--. 1 root root    0 11月 14 11:42 pgroonga--2.1.5--2.1.6.sql
-rw-r--r--. 1 root root  436 11月 14 11:42 pgroonga--2.1.6--2.1.7.sql
-rw-r--r--. 1 root root    0 11月 14 11:42 pgroonga--2.1.7--2.1.8.sql
-rw-r--r--. 1 root root    0 11月 14 11:42 pgroonga--2.1.8--2.1.9.sql
-rw-r--r--. 1 root root  126 11月 14 11:42 pgroonga--2.1.9--2.2.0.sql
-rw-r--r--. 1 root root 1.7K 11月 14 11:42 pgroonga--2.2.0--2.2.1.sql
-rw-r--r--. 1 root root    0 11月 14 11:42 pgroonga--2.2.1--2.2.2.sql
-rw-r--r--. 1 root root  69K 11月 14 12:35 pgroonga--2.2.2.sql
-rw-r--r--. 1 root root  154 11月 14 11:42 pgroonga.control
-rw-r--r--. 1 root root  138 11月 14 12:35 pgroonga_database--2.2.2.sql
-rw-r--r--. 1 root root  120 11月 14 11:42 pgroonga_database.control
-rw-r--r--. 1 root root  310  2月 17 19:57 plpgsql--1.0.sql
-rw-r--r--. 1 root root  370  2月 17 19:57 plpgsql--unpackaged--1.0.sql
-rw-r--r--. 1 root root  179  2月 17 19:57 plpgsql.control


ここがだいじ
-rw-r--r--. 1 root root  69K 11月 14 12:35 pgroonga--2.2.2.sql
-rw-r--r--. 1 root root  154 11月 14 11:42 pgroonga.control
-rw-r--r--. 1 root root  138 11月 14 12:35 pgroonga_database--2.2.2.sql
-rw-r--r--. 1 root root  120 11月 14 11:42 pgroonga_database.control
-rw-r--r--. 1 root root  310  2月 17 19:57 plpgsql--1.0.sql
-rw-r--r--. 1 root root  370  2月 17 19:57 plpgsql--unpackaged--1.0.sql
-rw-r--r--. 1 root root  179  2月 17 19:57 plpgsql.control
```


ダイナミックリンク周り

```
$find / -name "pgroonga.so" 2>/dev/null
/usr/pgsql-12/lib/pgroonga.so
$/usr/pgsql-12/bin/pg_config
BINDIR = /usr/pgsql-12/bin
DOCDIR = /usr/pgsql-12/doc
HTMLDIR = /usr/pgsql-12/doc/html
INCLUDEDIR = /usr/pgsql-12/include
PKGINCLUDEDIR = /usr/pgsql-12/include
INCLUDEDIR-SERVER = /usr/pgsql-12/include/server
LIBDIR = /usr/pgsql-12/lib
PKGLIBDIR = /usr/pgsql-12/lib
LOCALEDIR = /usr/pgsql-12/share/locale
MANDIR = /usr/pgsql-12/share/man
SHAREDIR = /usr/pgsql-12/share
SYSCONFDIR = /etc/sysconfig/pgsql
PGXS = /usr/pgsql-12/lib/pgxs/src/makefiles/pgxs.mk
CONFIGURE = '--enable-rpath' '--prefix=/usr/pgsql-12' '--includedir=/usr/pgsql-12/include' '--libdir=/usr/pgsql-12/lib' '--mandir=/usr/pgsql-12/share/man' '--datadir=/usr/pgsql-12/share' '--with-icu' 'CLANG=/opt/rh/llvm-toolset-7/root/usr/bin/clang' 'LLVM_CONFIG=/usr/lib64/llvm5.0/bin/llvm-config' '--with-llvm' '--with-perl' '--with-python' '--with-tcl' '--with-tclconfig=/usr/lib64' '--with-openssl' '--with-pam' '--with-gssapi' '--with-includes=/usr/include' '--with-libraries=/usr/lib64' '--enable-nls' '--enable-dtrace' '--with-uuid=e2fs' '--with-libxml' '--with-libxslt' '--with-ldap' '--with-selinux' '--with-systemd' '--with-system-tzdata=/usr/share/zoneinfo' '--sysconfdir=/etc/sysconfig/pgsql' '--docdir=/usr/pgsql-12/doc' '--htmldir=/usr/pgsql-12/doc/html' 'CFLAGS=-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches -m64 -mtune=generic' 'LDFLAGS=-Wl,--as-needed' 'PKG_CONFIG_PATH=:/usr/lib64/pkgconfig:/usr/share/pkgconfig' 'PYTHON=/usr/bin/python2'
CC = gcc -std=gnu99
CPPFLAGS = -D_GNU_SOURCE -I/usr/include/libxml2 -I/usr/include
CFLAGS = -Wall -Wmissing-prototypes -Wpointer-arith -Wdeclaration-after-statement -Werror=vla -Wendif-labels -Wmissing-format-attribute -Wformat-security -fno-strict-aliasing -fwrapv -fexcess-precision=standard -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches -m64 -mtune=generic
CFLAGS_SL = -fPIC
LDFLAGS = -Wl,--as-needed -L/usr/lib64/llvm5.0/lib -L/usr/lib64 -Wl,--as-needed -Wl,-rpath,'/usr/pgsql-12/lib',--enable-new-dtags
LDFLAGS_EX = 
LDFLAGS_SL = 
LIBS = -lpgcommon -lpgport -lpthread -lselinux -lxslt -lxml2 -lpam -lssl -lcrypto -lgssapi_krb5 -lz -lreadline -lrt -lcrypt -ldl -lm 
VERSION = PostgreSQL 12.2

$ldconfig -p | grep roo
	libgroonga.so.0 (libc6,x86-64) => /lib64/libgroonga.so.0
$echo $LD_LIBRARY_PATH
/usr/local/lib
$cat /etc/ld.so.conf
include ld.so.conf.d/*.conf
$cat /etc/ld.so.conf.d/
postgresql-pgdg-libs.conf  usr-local-lib.conf         
$cat /etc/ld.so.conf.d/usr-local-lib.conf 
/usr/local/lib
$cat /etc/ld.so.conf.d/postgresql-pgdg-libs.conf 
/usr/pgsql-12/lib/

$ls -lh /etc/ld.so.conf.d/postgresql-pgdg-libs.conf
lrwxrwxrwx. 1 root root 31  3月  3 07:22 /etc/ld.so.conf.d/postgresql-pgdg-libs.conf -> /etc/alternatives/pgsql-ld-conf
$ls -lh /etc/ld.so.conf.d/usr-local-lib.conf
-rw-r--r--. 1 root root 15  3月  3 07:20 /etc/ld.so.conf.d/usr-local-lib.conf
$ls -lh /etc/alternatives/pgsql-ld-conf
lrwxrwxrwx. 1 root root 43  3月  3 07:22 /etc/alternatives/pgsql-ld-conf -> /usr/pgsql-12/share/postgresql-12-libs.conf
$ls -lh /usr/pgsql-12/share/postgresql-12-libs.conf
-rw-r--r--. 1 root root 19  2月 17 19:57 /usr/pgsql-12/share/postgresql-12-libs.conf
$cat /usr/pgsql-12/share/postgresql-12-libs.conf
/usr/pgsql-12/lib/

```
