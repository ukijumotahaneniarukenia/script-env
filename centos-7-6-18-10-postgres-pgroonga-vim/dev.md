- レポジトリ配布物のビルドオプション
```
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
```

- 自前ビルド（失敗）

  - LIBDIRとPKGINCLUDEDIRはそろえないといけないぽい
```
$pg_config
BINDIR = /usr/local/bin
DOCDIR = /usr/local/share/doc/postgresql
HTMLDIR = /usr/local/share/doc/postgresql
INCLUDEDIR = /usr/local/include
PKGINCLUDEDIR = /usr/local/include/postgresql
INCLUDEDIR-SERVER = /usr/local/include/postgresql/server
LIBDIR = /usr/local/lib
PKGLIBDIR = /usr/local/lib/postgresql
LOCALEDIR = /usr/local/share/locale
MANDIR = /usr/local/share/man
SHAREDIR = /usr/local/share/postgresql
SYSCONFDIR = /usr/local/etc/postgresql
PGXS = /usr/local/lib/postgresql/pgxs/src/makefiles/pgxs.mk
CONFIGURE = '--prefix=/usr/local' '--libdir=/usr/local/lib'
CC = gcc -std=gnu99
CPPFLAGS = -D_GNU_SOURCE
CFLAGS = -Wall -Wmissing-prototypes -Wpointer-arith -Wdeclaration-after-statement -Werror=vla -Wendif-labels -Wmissing-format-attribute -Wformat-security -fno-strict-aliasing -fwrapv -fexcess-precision=standard -O2
CFLAGS_SL = -fPIC
LDFLAGS = -Wl,--as-needed -Wl,-rpath,'/usr/local/lib',--enable-new-dtags
LDFLAGS_EX =
LDFLAGS_SL =
LIBS = -lpgcommon -lpgport -lpthread -lz -lreadline -lrt -lcrypt -ldl -lm
VERSION = PostgreSQL 12.0
```

- 自前ビルド（成功）

```
$pg_config
BINDIR = /usr/local/bin
DOCDIR = /usr/local/share/doc/postgresql
HTMLDIR = /usr/local/share/doc/postgresql
INCLUDEDIR = /usr/local/include
PKGINCLUDEDIR = /usr/local/include/postgresql
INCLUDEDIR-SERVER = /usr/local/include/postgresql/server
LIBDIR = /usr/local/lib/postgresql
PKGLIBDIR = /usr/local/lib/postgresql
LOCALEDIR = /usr/local/share/locale
MANDIR = /usr/local/share/man
SHAREDIR = /usr/local/share/postgresql
SYSCONFDIR = /usr/local/etc/postgresql
PGXS = /usr/local/lib/postgresql/pgxs/src/makefiles/pgxs.mk
CONFIGURE = '--prefix=/usr/local' '--libdir=/usr/local/lib/postgresql'
CC = gcc -std=gnu99
CPPFLAGS = -D_GNU_SOURCE
CFLAGS = -Wall -Wmissing-prototypes -Wpointer-arith -Wdeclaration-after-statement -Werror=vla -Wendif-labels -Wmissing-format-attribute -Wformat-security -fno-strict-aliasing -fwrapv -fexcess-precision=standard -O2
CFLAGS_SL = -fPIC
LDFLAGS = -Wl,--as-needed -Wl,-rpath,'/usr/local/lib/postgresql',--enable-new-dtags
LDFLAGS_EX =
LDFLAGS_SL =
LIBS = -lpgcommon -lpgport -lpthread -lz -lreadline -lrt -lcrypt -ldl -lm
VERSION = PostgreSQL 12.0
```

成功時のリンカ状態

```
$ldd /usr/local/lib/postgresql/pgroonga.so
	linux-vdso.so.1 =>  (0x00007ffc0f119000)
	libmsgpackc.so.2 => /lib64/libmsgpackc.so.2 (0x00007f6dd8b08000)
	libgroonga.so.0 => /lib64/libgroonga.so.0 (0x00007f6dd7d89000)
	libc.so.6 => /lib64/libc.so.6 (0x00007f6dd79bb000)
	libz.so.1 => /lib64/libz.so.1 (0x00007f6dd77a5000)
	liblz4.so.1 => /lib64/liblz4.so.1 (0x00007f6dd7590000)
	libzstd.so.1 => /lib64/libzstd.so.1 (0x00007f6dd72ec000)
	libdl.so.2 => /lib64/libdl.so.2 (0x00007f6dd70e8000)
	libpthread.so.0 => /lib64/libpthread.so.0 (0x00007f6dd6ecc000)
	libstdc++.so.6 => /lib64/libstdc++.so.6 (0x00007f6dd6bc5000)
	libm.so.6 => /lib64/libm.so.6 (0x00007f6dd68c3000)
	libgcc_s.so.1 => /lib64/libgcc_s.so.1 (0x00007f6dd66ad000)
	/lib64/ld-linux-x86-64.so.2 (0x00007f6dd8f79000)
```
