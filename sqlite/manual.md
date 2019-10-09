# 参考文献
https://www.sqlite.org/src/doc/trunk/README.md
https://www.sqlite.org/index.html

time docker build -t centos_sqlite . | tee log

docker run --privileged --shm-size=8gb --name sqlite -itd -v /etc/localtime:/etc/localtime -v /run/udev:/run/udev -v /run/systemd:/run/systemd -v /tmp/.X11-unix:/tmp/.X11-unix -v /var/lib/dbus:/var/lib/dbus -v /var/run/dbus:/var/run/dbus -v /etc/machine-id:/etc/machine-id centos_sqlite

docker exec -it sqlite /bin/bash

おもしろそう
```
[sqlite💙524a8de974a4 (水 10月 09 01:04:24) /usr/local/src/sqlite-autoconf-3300000]$grep -n -r group_concat .
Binary file ./sqlite3.o matches
Binary file ./sqlite3-sqlite3.o matches
Binary file ./sqlite3 matches
./shell.c:13843:    "  || group_concat(quote(s.name) || '.' || quote(f.[from]) || '=?' "
./shell.c:13848:    "  || group_concat('*=?', ' AND ') || ')'"
./shell.c:13850:    "     s.name  || '(' || group_concat(f.[from],  ', ') || ')'"
./shell.c:13852:    "     f.[table] || '(' || group_concat(COALESCE(f.[to], p.[name])) || ')'"
./shell.c:13854:    "     'CREATE INDEX ' || quote(s.name ||'_'|| group_concat(f.[from], '_'))"
./shell.c:13856:    "  || group_concat(quote(f.[from]) ||"
./shell.c:14979:          "SELECT %Q || group_concat(shell_idquote(name), ', ') "
./shell.c:15328:      "SELECT max(field), group_concat(shell_escape_crnl(quote"
./shell.c:17517:          " SELECT lower(hex(sha3_query(group_concat(a,''),%d))) AS hash"
Binary file ./sqlite3-shell.o matches
Binary file ./.libs/sqlite3.o matches
Binary file ./.libs/libsqlite3.a matches
Binary file ./.libs/libsqlite3.so.0.8.6 matches
./sqlite3.c:115634:** group_concat(EXPR, ?SEPARATOR?)
./sqlite3.c:115912:    WAGGREGATE(group_concat, 1, 0, 0, groupConcatStep, 
./sqlite3.c:115914:    WAGGREGATE(group_concat, 2, 0, 0, groupConcatStep, 
./sqlite3.c:129240:**        until we introduced the group_concat() function.  
```
