- 公式マニュアル
  - http://archive.apache.org/dist/lucene/solr/ref-guide/apache-solr-ref-guide-8.1.pdf

- https://kshigeru.blogspot.com/2012/01/solr-wikipedia-data-import.html
- http://www.mwsoft.jp/programming/munou/wikipedia_solr.html
- https://gist.github.com/satom9to5/7902551

- wikiデータ
  - https://dumps.wikimedia.org/jawiki/latest/

- データインポート
  - http://lucene.apache.org/solr/guide/8_4/uploading-structured-data-store-data-with-the-data-import-handler.html#uploading-structured-data-store-data-with-the-data-import-handler



デモで練習

- https://lucene.apache.org/solr/guide/8_4/uploading-structured-data-store-data-with-the-data-import-handler.html#uploading-structured-data-store-data-with-the-data-import-handler

```
solr@9d28f1194bed ~$solr -e dih

Starting up Solr on port 8983 using command:
"/usr/local/src/solr-8.4.1/bin/solr" start -p 8983 -s "/usr/local/src/solr-8.4.1/example/example-DIH/solr"

NOTE: Please install lsof as this script needs it to determine if Solr is listening on port 8983.

Started Solr server on port 8983 (pid=163). Happy searching!


Solr dih example launched successfully. Direct your Web browser to http://localhost:8983/solr to visit the Solr Admin UI

```
- プロセス起動

```
solr@95adbde9b31c /usr/local/src/script-repo$solr start -p 8983
Waiting up to 180 seconds to see Solr running on port 8983 [/]  
Started Solr server on port 8983 (pid=828). Happy searching!
```


- 待受ポート確認

```
solr@95adbde9b31c /usr/local/src/script-repo$lsof -P -i:8983
COMMAND PID USER   FD   TYPE  DEVICE SIZE/OFF NODE NAME
java    828 solr  152u  IPv4 1432559      0t0  TCP *:8983 (LISTEN)
```

- プロセス確認

```
solr@95adbde9b31c /usr/local/src/script-repo$ps aux
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
solr         1  0.0  0.0   5372  2192 pts/0    Ss+  19:27   0:00 /bin/bash
solr         7  0.0  0.0   5372  2416 pts/1    Ss   19:28   0:00 /bin/bash
solr       828 17.3  0.7 5423016 239112 pts/1  Sl   19:39   0:05 /usr/local/src/jdk-11/bin/java -server -Xms512m -Xmx512m -XX:+UseG1GC -XX:+PerfDisableSharedMem -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=2
solr       926  0.0  0.0   7008  1560 pts/1    R+   19:39   0:00 ps aux
```

- ブラウザアクセス

  - http://localhost:8983/solr

```
solr@7b86fab03d5e ~$ls -lh
total 12G
drwxr-xr-x. 3 solr solr 4.0K  2月 11 13:56 dotfile
-rw-rw-r--. 1 solr solr  12G  2月 11 17:34 jawiki-latest-pages-articles.xml
```

- コア作成

```
solr@95adbde9b31c /usr/local/src/script-repo$solr create -c wiki
WARNING: Using _default configset with data driven schema functionality. NOT RECOMMENDED for production use.
         To turn off: bin/solr config -c wiki -p 8983 -action set-user-property -property update.autoCreateFields -value false

Created new core 'wiki'
```


- 設定ファイル編集

以下の3ファイルを修正。レポからコピってくる。

  - /usr/local/src/solr-8.4.1/server/solr/wiki/conf/managed-schema

  - /usr/local/src/solr-8.4.1/server/solr/wiki/conf/solrconfig.xml

  - /usr/local/src/solr-8.4.1/server/solr/wiki/jawiki-latest-pages-articles.xml

```
$grep -Po '<.*>' jawiki-latest-pages-articles.xml | head -n100 | awk '/<page>/,/<\/page>/{if($0=="<page>"){print 1,$0}else{print 0,$0}}' | nl
```


- 設定ファイル変更後は一度インスタンスをポート単位で落として、再起動

```
solr@95adbde9b31c /usr/local/src/solr-8.4.1/server/solr/wiki/conf$solr stop -p 8983
Sending stop command to Solr running on port 8983 ... waiting up to 180 seconds to allow Jetty process 828 to stop gracefully.
solr@95adbde9b31c /usr/local/src/solr-8.4.1/server/solr/wiki/conf$solr start -p 8983 -s "/usr/local/src/solr-8.4.1/server/solr"
Waiting up to 180 seconds to see Solr running on port 8983 [/]  
Started Solr server on port 8983 (pid=1404). Happy searching!
```

- コマンドラインからデータ取得

```
curl -s http://localhost:8983/solr/wiki/select?q=*%3A* | jq

curl -s "http://localhost:8983/solr/wiki/select?q=*%3A*&rows=100&wt=json" | jq
```

- xpath式をjqから逆算などしたい

