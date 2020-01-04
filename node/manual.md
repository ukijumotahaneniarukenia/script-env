# kibanaとelasticsearchの起動手順について

サービスの起動順序としては**elasticsearchサービス**が**最初**でそのあと**kibanaサービス**を起動。

以下のログがその理由

```
[kibana@48d59e46f51d ~]$ grep elasticsearch /var/log/kibana/kibana.stdout
{"type":"log","@timestamp":"2020-01-03T17:57:15Z","tags":["status","plugin:elasticsearch@7.5.1","info"],"pid":2907,"state":"yellow","message":"Status changed from uninitialized to yellow - Waiting for Elasticsearch","prevState":"uninitialized","prevMsg":"uninitialized"}
{"type":"log","@timestamp":"2020-01-03T17:57:16Z","tags":["status","plugin:elasticsearch@7.5.1","info"],"pid":2907,"state":"green","message":"Status changed from yellow to green - Ready","prevState":"yellow","prevMsg":"Waiting for Elasticsearch"}
```

なんどやってもサービスユニット管理下にすることができなかったので、この泥臭い方法になってしまった。
一般的なsystemdコマンドを介した方法とは異なることを認識。

## elasticsearchサービス

### 1.バージョン確認

**elasticsearchユーザー**で確認
```
[elasticsearch@48d59e46f51d ~]$ /usr/share/elasticsearch/bin/elasticsearch -V
OpenJDK 64-Bit Server VM warning: Option UseConcMarkSweepGC was deprecated in version 9.0 and will likely be removed in a future release.
Version: 7.5.1, Build: default/rpm/3ae9ac9a93c95bd0cdc054951cf95d88e1e18d96/2019-12-16T22:57:37.835892Z, JVM: 13.0.1
```
### 2.ヘルプ表示

**elasticsearchユーザー**で確認
```
[elasticsearch@48d59e46f51d ~]$ /usr/share/elasticsearch/bin/elasticsearch --help
OpenJDK 64-Bit Server VM warning: Option UseConcMarkSweepGC was deprecated in version 9.0 and will likely be removed in a future release.
starts elasticsearch

Option                Description                                               
------                -----------                                               
-E <KeyValuePair>     Configure a setting                                       
-V, --version         Prints elasticsearch version information and exits        
-d, --daemonize       Starts Elasticsearch in the background                    
-h, --help            show help                                                 
-p, --pidfile <Path>  Creates a pid file in the specified path on start         
-q, --quiet           Turns off standard output/error streams logging in console
-s, --silent          show minimal output                                       
-v, --verbose         show verbose output                                       
```
### 3.バッググラウンドで起動

**elasticsearchユーザー**で確認

**tail -f launch_elasticsearch.log**で書き込まれていることを確認

$/usr/share/elasticsearch/bin/elasticsearch --verbose 1>~/launch_elasticsearch.log 2>&1 &
$tail -f launch_elasticsearch.log

**/var/log/elasticsearch/elasticsearch.log**でもログ確認（こっちが本物）

```
[elasticsearch@48d59e46f51d ~]$ ll /var/log/elasticsearch/
total 1204
-rw-rw-r--. 1 elasticsearch elasticsearch   24505  1月  4 03:11 elasticsearch.log
-rw-rw-r--. 1 elasticsearch elasticsearch       0  1月  4 01:45 elasticsearch_audit.json
-rw-rw-r--. 1 elasticsearch elasticsearch       0  1月  4 01:45 elasticsearch_deprecation.json
-rw-rw-r--. 1 elasticsearch elasticsearch       0  1月  4 01:45 elasticsearch_deprecation.log
-rw-rw-r--. 1 elasticsearch elasticsearch       0  1月  4 01:45 elasticsearch_index_indexing_slowlog.json
-rw-rw-r--. 1 elasticsearch elasticsearch       0  1月  4 01:45 elasticsearch_index_indexing_slowlog.log
-rw-rw-r--. 1 elasticsearch elasticsearch       0  1月  4 01:45 elasticsearch_index_search_slowlog.json
-rw-rw-r--. 1 elasticsearch elasticsearch       0  1月  4 01:45 elasticsearch_index_search_slowlog.log
-rw-rw-r--. 1 elasticsearch elasticsearch   40599  1月  4 03:11 elasticsearch_server.json
-rw-rw-r--. 1 elasticsearch elasticsearch    2519  1月  4 03:15 gc.log
-rw-rw-r--. 1 elasticsearch elasticsearch    1453  1月  4 01:43 gc.log.00
-rw-rw-r--. 1 elasticsearch elasticsearch    2330  1月  4 01:43 gc.log.01
-rw-rw-r--. 1 elasticsearch elasticsearch    1453  1月  4 01:44 gc.log.02
-rw-rw-r--. 1 elasticsearch elasticsearch    2330  1月  4 01:44 gc.log.03
-rw-rw-r--. 1 elasticsearch elasticsearch    1454  1月  4 01:45 gc.log.04
-rw-rw-r--. 1 elasticsearch elasticsearch 1137371  1月  4 03:16 gc.log.05
-rw-rw-r--. 1 elasticsearch elasticsearch    1465  1月  4 03:15 gc.log.06
```

### 4.プロセス状態の確認

**elasticsearchユーザー**でなくてもよい
ログにはかれているプロセスIDとpsコマンドの出力結果に含まれているプロセスIDが一致していればプログラムはうまく動いていそう。

```
[elasticsearch@48d59e46f51d ~]$ grep pid launch_elasticsearch.log
[2020-01-04T01:45:05,672][INFO ][o.e.n.Node               ] [48d59e46f51d] version[7.5.1], pid[333], build[default/rpm/3ae9ac9a93c95bd0cdc054951cf95d88e1e18d96/2019-12-16T22:57:37.835892Z], OS[Linux/3.10.0-1062.el7.x86_64/amd64], JVM[AdoptOpenJDK/OpenJDK 64-Bit Server VM/13.0.1/13.0.1+9]
[2020-01-04T01:45:05,673][INFO ][o.e.n.Node               ] [48d59e46f51d] JVM arguments [-Des.networkaddress.cache.ttl=60, -Des.networkaddress.cache.negative.ttl=10, -XX:+AlwaysPreTouch, -Xss1m, -Djava.awt.headless=true, -Dfile.encoding=UTF-8, -Djna.nosys=true, -XX:-OmitStackTraceInFastThrow, -Dio.netty.noUnsafe=true, -Dio.netty.noKeySetOptimization=true, -Dio.netty.recycler.maxCapacityPerThread=0, -Dio.netty.allocator.numDirectArenas=0, -Dlog4j.shutdownHookEnabled=false, -Dlog4j2.disable.jmx=true, -Djava.locale.providers=COMPAT, -Xms1g, -Xmx1g, -XX:+UseConcMarkSweepGC, -XX:CMSInitiatingOccupancyFraction=75, -XX:+UseCMSInitiatingOccupancyOnly, -Djava.io.tmpdir=/tmp/elasticsearch-16636342414391443596, -XX:+HeapDumpOnOutOfMemoryError, -XX:HeapDumpPath=/var/lib/elasticsearch, -XX:ErrorFile=/var/log/elasticsearch/hs_err_pid%p.log, -Xlog:gc*,gc+age=trace,safepoint:file=/var/log/elasticsearch/gc.log:utctime,pid,tags:filecount=32,filesize=64m, -XX:MaxDirectMemorySize=536870912, -Des.path.home=/usr/share/elasticsearch, -Des.path.conf=/etc/elasticsearch, -Des.distribution.flavor=default, -Des.distribution.type=rpm, -Des.bundled_jdk=true]
[kuraine💕48d59e46f51d (土  1月 04 01:59:41) ~]$ps -aux
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
kuraine      1  0.0  0.0  15480  3096 pts/0    Ss+  01:42   0:00 /bin/bash
kuraine     48  0.0  0.0  15612  3324 pts/1    Ss   01:42   0:00 /bin/bash
elastic+   333  3.8  4.4 9092628 1449788 pts/1 Sl   01:45   0:34 /usr/share/elasticsearch/jdk/bin/java -Des.networkaddress.cache.ttl=60 -Des.networkaddress.cache.negative.ttl=10 -XX:+AlwaysPreTouch -Xss1m -Djava
elastic+   431  0.0  0.0  70444  4516 pts/1    Sl   01:45   0:00 /usr/share/elasticsearch/modules/x-pack-ml/platform/linux-x86_64/bin/controller
```


### 5.ターミナルから起動確認

別ターミナルを開いてcurlコマンドで起動確認

```
[kuraine💕48d59e46f51d (土  1月 04 01:45:54) ~]$curl localhost:9200
{
  "name" : "48d59e46f51d",
  "cluster_name" : "elasticsearch",
  "cluster_uuid" : "le0et1XaT5-E9590dxyC0w",
  "version" : {
    "number" : "7.5.1",
    "build_flavor" : "default",
    "build_type" : "rpm",
    "build_hash" : "3ae9ac9a93c95bd0cdc054951cf95d88e1e18d96",
    "build_date" : "2019-12-16T22:57:37.835892Z",
    "build_snapshot" : false,
    "lucene_version" : "8.3.0",
    "minimum_wire_compatibility_version" : "6.8.0",
    "minimum_index_compatibility_version" : "6.0.0-beta1"
  },
  "tagline" : "You Know, for Search"
}
[kibana@48d59e46f51d kuraine]$ curl http://localhost:9200
{
  "name" : "48d59e46f51d",
  "cluster_name" : "elasticsearch",
  "cluster_uuid" : "le0et1XaT5-E9590dxyC0w",
  "version" : {
    "number" : "7.5.1",
    "build_flavor" : "default",
    "build_type" : "rpm",
    "build_hash" : "3ae9ac9a93c95bd0cdc054951cf95d88e1e18d96",
    "build_date" : "2019-12-16T22:57:37.835892Z",
    "build_snapshot" : false,
    "lucene_version" : "8.3.0",
    "minimum_wire_compatibility_version" : "6.8.0",
    "minimum_index_compatibility_version" : "6.0.0-beta1"
  },
  "tagline" : "You Know, for Search"
}
```


### 6.elasticseachプロセス停止

**kibana**のように**/etc/rc.d/init.d/elasticsearch**コマンドで実行するとunit.service経由となるので、うまくいかない。手動でプロセスkill。


```
[elasticsearch@48d59e46f51d ~]$ ps aux
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
kuraine      1  0.0  0.0  15480  3096 pts/0    Ss+  01:42   0:00 /bin/bash
elastic+   333  1.4  4.7 9110064 1554780 ?     Sl   01:45   1:22 /usr/share/elasticsearch/jdk/bin/java -Des.networkaddress.cache.ttl=60 -Des.networkaddress.cache.negative.ttl=10 -XX:+AlwaysPreTouch -Xss1m -Djava
elastic+   431  0.0  0.0  70444  4516 ?        Sl   01:45   0:00 /usr/share/elasticsearch/modules/x-pack-ml/platform/linux-x86_64/bin/controller
kuraine    515  0.0  0.0  15608  3328 pts/2    Ss   01:45   0:00 /bin/bash
kuraine   1459  0.0  0.0  58908   888 ?        S    02:09   0:00 dbus-launch --autolaunch=bc74deaa9e044c079ed6fc963d084157 --binary-syntax --close-stderr
kuraine   1460  0.0  0.0  60084  1120 ?        Ss   02:09   0:00 /usr/bin/dbus-daemon --fork --print-pid 5 --print-address 7 --session
root      3140  0.0  0.0  89352  2660 pts/2    S    03:13   0:00 su elasticsearch
elastic+  3142  0.0  0.0  15652  3428 pts/2    S    03:13   0:00 bash
elastic+  3339  0.0  0.0  54304  1864 pts/2    R+   03:20   0:00 ps aux
[elasticsearch@48d59e46f51d ~]$ kill 333
[elasticsearch@48d59e46f51d ~]$ ps aux
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
kuraine      1  0.0  0.0  15480  3096 pts/0    Ss+  01:42   0:00 /bin/bash
kuraine    515  0.0  0.0  15608  3328 pts/2    Ss   01:45   0:00 /bin/bash
kuraine   1459  0.0  0.0  58908   888 ?        S    02:09   0:00 dbus-launch --autolaunch=bc74deaa9e044c079ed6fc963d084157 --binary-syntax --close-stderr
kuraine   1460  0.0  0.0  60084  1120 ?        Ss   02:09   0:00 /usr/bin/dbus-daemon --fork --print-pid 5 --print-address 7 --session
root      3140  0.0  0.0  89352  2660 pts/2    S    03:13   0:00 su elasticsearch
elastic+  3142  0.0  0.0  15652  3428 pts/2    S    03:13   0:00 bash
elastic+  3353  0.0  0.0  54304  1864 pts/2    R+   03:20   0:00 ps aux
```

## kibanaサービス

### 1.バージョン確認

**kibanaユーザー**で確認
```
[kibana@48d59e46f51d kuraine]$ /usr/share/kibana/bin/kibana -V
7.5.1
```

### 2.コマンドラインツールのヘルプ表示

**kibanaユーザー**で確認

プラグイン管理等に使うのであろう。

```
[kibana@48d59e46f51d kuraine]$ /usr/share/kibana/bin/kibana --help

  Usage: bin/kibana [command=serve] [options]
  
  Kibana is an open source (Apache Licensed), browser based analytics and search dashboard for Elasticsearch.
  
  Commands:
    serve  [options]  Run the kibana server
    help  <command>   Get the help for a specific command
  
  "serve" Options:
  
    -e, --elasticsearch <uri1,uri2>  Elasticsearch instances
    -c, --config <path>              Path to the config file, use multiple --config args to include multiple config files (default: ["/etc/kibana/kibana.yml"])
    -p, --port <port>                The port to bind to
    -q, --quiet                      Prevent all logging except errors
    -Q, --silent                     Prevent all logging
    --verbose                        Turns on verbose logging
    -H, --host <host>                The host to bind to
    -l, --log-file <path>            The file to log to
    --plugin-dir <path>              A path to scan for plugins, this can be specified multiple times to specify multiple directories (default: ["/usr/share/kibana/plugins","/usr/share/kibana/src/legacy/core_plugins"])
    --plugin-path <path>             A path to a plugin which should be included by the server, this can be specified multiple times to specify multiple paths (default: [])
    --plugins <path>                 an alias for --plugin-dir
    --optimize                       Optimize and then stop the server
    -h, --help                       output usage information


```


### 2.kibanaプロセス停止

**kibanaユーザー**で実行

```
[kibana@48d59e46f51d ~]$ /etc/rc.d/init.d/kibana stop
kibana stopped.

[kibana@48d59e46f51d ~]$ tail /var/log/kibana/kibana.stdout
{"type":"log","@timestamp":"2020-01-03T17:53:57Z","tags":["info","plugins-system"],"pid":1265,"message":"Stopping all plugins."}
{"type":"log","@timestamp":"2020-01-03T17:53:57Z","tags":["info","plugins","data"],"pid":1265,"message":"Stopping plugin"}
{"type":"log","@timestamp":"2020-01-03T17:53:57Z","tags":["info","plugins","translations"],"pid":1265,"message":"Stopping plugin"}
{"type":"log","@timestamp":"2020-01-03T17:53:57Z","tags":["info","plugins","spaces"],"pid":1265,"message":"Stopping plugin"}
{"type":"log","@timestamp":"2020-01-03T17:53:57Z","tags":["info","plugins","features"],"pid":1265,"message":"Stopping plugin"}
{"type":"log","@timestamp":"2020-01-03T17:53:57Z","tags":["info","plugins","timelion"],"pid":1265,"message":"Stopping plugin"}
{"type":"log","@timestamp":"2020-01-03T17:53:57Z","tags":["info","plugins","code"],"pid":1265,"message":"Stopping plugin"}
{"type":"log","@timestamp":"2020-01-03T17:53:57Z","tags":["info","plugins","licensing"],"pid":1265,"message":"Stopping plugin"}
{"type":"log","@timestamp":"2020-01-03T17:53:57Z","tags":["info","plugins","security"],"pid":1265,"message":"Stopping plugin"}
```

### 2.kibanaプロセス開始

**kibanaユーザー**で実行

**kibana started**と標準出力に表示されたら次はログ確認

```
[kibana@48d59e46f51d ~]$ sudo /etc/rc.d/init.d/kibana start
kibana started
```

### 2.起動ログを確認


**kibanaユーザー**でなくてもよい

ログは以下で確認できる。標準エラー出力のログファイルに何も出ていなければOK。

```
$ll /var/log/kibana/*
-rw-r--r--. 1 root root       0  1月  4 02:03 /var/log/kibana/kibana.stderr
-rw-r--r--. 1 root root 1270327  1月  4 02:31 /var/log/kibana/kibana.stdout
```

### 3.プロセス状態の確認

**kibanaユーザー**でなくてもよい
ログにはかれているプロセスIDとpsコマンドの出力結果に含まれているプロセスIDが一致していればプログラムはうまく動いていそう。


```
[kibana@48d59e46f51d ~]$ tail /var/log/kibana/kibana.stdout 
{"type":"log","@timestamp":"2020-01-03T17:57:16Z","tags":["status","plugin:cross_cluster_replication@7.5.1","info"],"pid":2907,"state":"green","message":"Status changed from yellow to green - Ready","prevState":"yellow","prevMsg":"Waiting for Elasticsearch"}
{"type":"log","@timestamp":"2020-01-03T17:57:16Z","tags":["status","plugin:file_upload@7.5.1","info"],"pid":2907,"state":"green","message":"Status changed from yellow to green - Ready","prevState":"yellow","prevMsg":"Waiting for Elasticsearch"}
{"type":"log","@timestamp":"2020-01-03T17:57:16Z","tags":["status","plugin:snapshot_restore@7.5.1","info"],"pid":2907,"state":"green","message":"Status changed from yellow to green - Ready","prevState":"yellow","prevMsg":"Waiting for Elasticsearch"}
{"type":"log","@timestamp":"2020-01-03T17:57:16Z","tags":["info","monitoring","kibana-monitoring"],"pid":2907,"message":"Starting monitoring stats collection"}
{"type":"log","@timestamp":"2020-01-03T17:57:16Z","tags":["status","plugin:maps@7.5.1","info"],"pid":2907,"state":"green","message":"Status changed from yellow to green - Ready","prevState":"yellow","prevMsg":"Waiting for Elasticsearch"}
{"type":"log","@timestamp":"2020-01-03T17:57:16Z","tags":["status","plugin:spaces@7.5.1","info"],"pid":2907,"state":"green","message":"Status changed from yellow to green - Ready","prevState":"yellow","prevMsg":"Waiting for Elasticsearch"}
{"type":"log","@timestamp":"2020-01-03T17:57:16Z","tags":["reporting","warning"],"pid":2907,"message":"Generating a random key for xpack.reporting.encryptionKey. To prevent pending reports from failing on restart, please set xpack.reporting.encryptionKey in kibana.yml"}
{"type":"log","@timestamp":"2020-01-03T17:57:16Z","tags":["status","plugin:reporting@7.5.1","info"],"pid":2907,"state":"green","message":"Status changed from uninitialized to green - Ready","prevState":"uninitialized","prevMsg":"uninitialized"}
{"type":"log","@timestamp":"2020-01-03T17:57:16Z","tags":["listening","info"],"pid":2907,"message":"Server running at http://172.17.0.2:5601"}
{"type":"log","@timestamp":"2020-01-03T17:57:16Z","tags":["info","http","server","Kibana"],"pid":2907,"message":"http server running at http://172.17.0.2:5601"}

[kibana@48d59e46f51d ~]$ ps aux
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
kuraine      1  0.0  0.0  15480  3096 pts/0    Ss+  01:42   0:00 /bin/bash
kuraine     48  0.0  0.0  15612  3324 pts/1    Ss   01:42   0:00 /bin/bash
elastic+   333  1.7  4.7 9110064 1553800 pts/1 Sl   01:45   1:17 /usr/share/elasticsearch/jdk/bin/java -Des.networkaddress.cache.ttl=60 -Des.networkaddress.cache.negative.ttl=10 -XX:+AlwaysPreTouch -Xss1m -Djava
elastic+   431  0.0  0.0  70444  4516 pts/1    Sl   01:45   0:00 /usr/share/elasticsearch/modules/x-pack-ml/platform/linux-x86_64/bin/controller
kuraine    515  0.0  0.0  15608  3312 pts/2    Ss   01:45   0:00 /bin/bash
root      1089  0.0  0.0  89352  2656 pts/1    S    01:57   0:00 su kibana
kibana    1091  0.0  0.0  15548  3276 pts/1    S    01:57   0:00 bash
kuraine   1331  0.0  0.0  15608  3308 pts/3    Ss+  02:09   0:00 /bin/bash
kuraine   1459  0.0  0.0  58908   888 pts/3    S    02:09   0:00 dbus-launch --autolaunch=bc74deaa9e044c079ed6fc963d084157 --binary-syntax --close-stderr
kuraine   1460  0.0  0.0  60084  1120 ?        Ss   02:09   0:00 /usr/bin/dbus-daemon --fork --print-pid 5 --print-address 7 --session
kuraine   1843  0.0  0.0  14240  1588 pts/3    S    02:13   0:00 /bin/sh /home/kuraine/idea-IC-192.7142.36/bin/idea.sh
kuraine   1959  6.8  3.6 8153592 1178456 pts/3 Sl   02:13   3:02 /home/kuraine/idea-IC-192.7142.36/jbr/bin/java -classpath /home/kuraine/idea-IC-192.7142.36/lib/bootstrap.jar:/home/kuraine/idea-IC-192.7142.36/li
kuraine   2021  0.0  0.0   4620   824 pts/3    S    02:13   0:00 /home/kuraine/idea-IC-192.7142.36/bin/fsnotifier64
kuraine   2128  0.0  0.0  15688  3500 pts/4    Ss+  02:14   0:00 /bin/bash --rcfile /home/kuraine/idea-IC-192.7142.36/plugins/terminal/jediterm-bash.in -i
root      2813  0.0  0.0  89352  2660 pts/2    S    02:47   0:00 su kibana
kibana    2815  0.0  0.0  15548  3264 pts/2    S+   02:47   0:00 bash
kibana    2907 23.4  1.3 1813572 436104 pts/1  Sl   02:57   0:08 /usr/share/kibana/bin/../node/bin/node /usr/share/kibana/bin/../src/cli -c /etc/kibana/kibana.yml
kibana    2960  0.0  0.0  54304  1868 pts/1    R+   02:57   0:00 ps aux
```

### 4.ブラウザから確認

以下のurlでアクセス

```
http://192.168.1.109:5601
```

### 4.kibanaプロセス停止

**kibanaユーザー**で実行

**kibana stoped**と標準出力に表示されたら次はログ確認

```
[kibana@48d59e46f51d ~]$ /etc/rc.d/init.d/kibana stoped
kibana stoped
```

```
[kibana@48d59e46f51d ~]$ tail /var/log/kibana/kibana.stdout 
{"type":"response","@timestamp":"2020-01-03T18:03:19Z","tags":[],"pid":2907,"method":"get","statusCode":200,"req":{"url":"/ui/fonts/inter_ui/Inter-UI-Bold.woff2","method":"get","headers":{"host":"192.168.1.109:5601","connection":"keep-alive","origin":"http://192.168.1.109:5601","user-agent":"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36","accept":"*/*","referer":"http://192.168.1.109:5601/app/kibana","accept-encoding":"gzip, deflate","accept-language":"ja,en-US;q=0.9,en;q=0.8"},"remoteAddress":"192.168.1.109","userAgent":"192.168.1.109","referer":"http://192.168.1.109:5601/app/kibana"},"res":{"statusCode":200,"responseTime":3,"contentLength":9},"message":"GET /ui/fonts/inter_ui/Inter-UI-Bold.woff2 200 3ms - 9.0B"}
{"type":"log","@timestamp":"2020-01-03T18:04:09Z","tags":["info","plugins-system"],"pid":2907,"message":"Stopping all plugins."}
{"type":"log","@timestamp":"2020-01-03T18:04:09Z","tags":["info","plugins","data"],"pid":2907,"message":"Stopping plugin"}
{"type":"log","@timestamp":"2020-01-03T18:04:09Z","tags":["info","plugins","translations"],"pid":2907,"message":"Stopping plugin"}
{"type":"log","@timestamp":"2020-01-03T18:04:09Z","tags":["info","plugins","spaces"],"pid":2907,"message":"Stopping plugin"}
{"type":"log","@timestamp":"2020-01-03T18:04:09Z","tags":["info","plugins","features"],"pid":2907,"message":"Stopping plugin"}
{"type":"log","@timestamp":"2020-01-03T18:04:09Z","tags":["info","plugins","timelion"],"pid":2907,"message":"Stopping plugin"}
{"type":"log","@timestamp":"2020-01-03T18:04:09Z","tags":["info","plugins","code"],"pid":2907,"message":"Stopping plugin"}
{"type":"log","@timestamp":"2020-01-03T18:04:09Z","tags":["info","plugins","licensing"],"pid":2907,"message":"Stopping plugin"}
{"type":"log","@timestamp":"2020-01-03T18:04:09Z","tags":["info","plugins","security"],"pid":2907,"message":"Stopping plugin"}
```

停止したらログは削除しておく。棲み分け楽にするため。
ログは新規作成してくれるので。

```
[kibana@48d59e46f51d ~]$ sudo rm -rf /var/log/kibana/kibana.stderr /var/log/kibana/kibana.stdout
```

# 参考文献
https://www.nodebeginner.org/index-jp.html
https://github.com/nodesource/distributions/blob/master/README.md

nodeのパッケージ管理にはyarnとnpmの2つがある
https://qiita.com/jigengineer/items/c75ca9b8f0e9ce462e99

# dockerイメージ作成
```
time docker build -t centos_node . | tee log
```

# dockerコンテナ作成
```
docker run --privileged --shm-size=8gb -v /run/udev:/run/udev -v /run/systemd:/run/systemd -v /tmp/.X11-unix:/tmp/.X11-unix -v /var/lib/dbus:/var/lib/dbus -v /var/run/dbus:/var/run/dbus -v /etc/machine-id:/etc/machine-id -v /etc/localtime:/etc/localtime -p 8080:80 -p 5601:5601 -p 9200:9200 -itd --name node centos_node
```

# dockerコンテナ潜入

```
docker exec --user kuraine -it node /bin/bash
```

# 不要コンテナ削除

```
docker ps -a | grep -vE "node|tcl|mysql|racket|postgres|oracle|egison|java|sqlite" | awk '/Ex/{print $1}' | xargs docker rm
```

# 不要イメージ削除

```
docker images | awk '$1=="<none>"{print $3}' | xargs -I@ docker rmi @
```
