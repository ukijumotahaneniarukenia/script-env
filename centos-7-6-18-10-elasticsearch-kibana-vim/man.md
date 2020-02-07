# 参考文献
https://www.elastic.co/guide/en/elasticsearch/reference/current/rpm.html</br>
https://tech.recruit-mp.co.jp/infrastructure/docker-elasticsearch/</br>

# 不要コンテナ削除

```
docker ps -a | grep -vE "node|tcl|mysql|racket|postgres|oracle|egison|java|sqlite" | awk '/Ex/{print $1}' | xargs docker rm
```

# 不要イメージ削除

```
docker images | awk '$1=="<none>"{print $3}' | xargs -I@ docker rmi @
```

# dockerイメージ作成
```
time docker build -t centos_centos-7-6-18-10-elastic-kibana . | tee log
```

# dockerコンテナ起動
```
docker run --privileged -itd --name centos-7-6-18-10-elastic-kibana -v /sys/fs/cgroup:/sys/fs/cgroup:ro -p 5601:5601 -p 9200:9200 centos-7-6-18-10-elastic-kibana
```

# dockerコンテナ潜入
```
docker exec -it centos-7-6-18-10-elastic-kibana /bin/bash
```

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
$/usr/share/elasticsearch/bin/elasticsearch -V
OpenJDK 64-Bit Server VM warning: Option UseConcMarkSweepGC was deprecated in version 9.0 and will likely be removed in a future release.
Version: 7.5.1, Build: default/rpm/3ae9ac9a93c95bd0cdc054951cf95d88e1e18d96/2019-12-16T22:57:37.835892Z, JVM: 13.0.1
```
### 2.ヘルプ表示

**elasticsearchユーザー**で確認
```
$/usr/share/elasticsearch/bin/elasticsearch --help
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

```
$/usr/share/elasticsearch/bin/elasticsearch --verbose 1>~/launch_elasticsearch.log 2>&1 &
[1] 552
```

tailコマンドで書き込まれていることを確認
```
$tail -f launch_elasticsearch.log
[2020-01-05T01:31:03,105][WARN ][o.e.b.BootstrapChecks    ] [23df2d9237d5] the default discovery settings are unsuitable for production use; at least one of [discovery.seed_hosts, discovery.seed_providers, cluster.initial_master_nodes] must be configured
[2020-01-05T01:31:03,106][INFO ][o.e.c.c.Coordinator      ] [23df2d9237d5] cluster UUID [2x4llkX4QWWAU-vM0iyxqw]
[2020-01-05T01:31:03,114][INFO ][o.e.c.c.ClusterBootstrapService] [23df2d9237d5] no discovery configuration found, will perform best-effort cluster bootstrapping after [3s] unless existing master is discovered
[2020-01-05T01:31:03,170][INFO ][o.e.c.s.MasterService    ] [23df2d9237d5] elected-as-master ([1] nodes joined)[{23df2d9237d5}{d1x4quRpS8aPb52ERsulKw}{bY_pv1kcTq-MWfu-WiSA5A}{127.0.0.1}{127.0.0.1:9300}{dilm}{ml.machine_memory=33426505728, xpack.installed=true, ml.max_open_jobs=20} elect leader, _BECOME_MASTER_TASK_, _FINISH_ELECTION_], term: 2, version: 18, delta: master node changed {previous [], current [{23df2d9237d5}{d1x4quRpS8aPb52ERsulKw}{bY_pv1kcTq-MWfu-WiSA5A}{127.0.0.1}{127.0.0.1:9300}{dilm}{ml.machine_memory=33426505728, xpack.installed=true, ml.max_open_jobs=20}]}
[2020-01-05T01:31:03,207][INFO ][o.e.c.s.ClusterApplierService] [23df2d9237d5] master node changed {previous [], current [{23df2d9237d5}{d1x4quRpS8aPb52ERsulKw}{bY_pv1kcTq-MWfu-WiSA5A}{127.0.0.1}{127.0.0.1:9300}{dilm}{ml.machine_memory=33426505728, xpack.installed=true, ml.max_open_jobs=20}]}, term: 2, version: 18, reason: Publication{term=2, version=18}
[2020-01-05T01:31:03,227][INFO ][o.e.h.AbstractHttpServerTransport] [23df2d9237d5] publish_address {127.0.0.1:9200}, bound_addresses {127.0.0.1:9200}
[2020-01-05T01:31:03,227][INFO ][o.e.n.Node               ] [23df2d9237d5] started
[2020-01-05T01:31:03,323][INFO ][o.e.l.LicenseService     ] [23df2d9237d5] license [d3d3adc4-5ebc-4e8c-b5cd-c26c1b00ffcb] mode [basic] - valid
[2020-01-05T01:31:03,324][INFO ][o.e.x.s.s.SecurityStatusChangeListener] [23df2d9237d5] Active license is now [BASIC]; Security is disabled
[2020-01-05T01:31:03,329][INFO ][o.e.g.GatewayService     ] [23df2d9237d5] recovered [0] indices into cluster_state
```

**/var/log/elasticsearch/elasticsearch.log**でもログ確認（こっちが本物）

```
$ll /var/log/elasticsearch/*
-rw-rw-r--. 1 elasticsearch elasticsearch  21314  1月  5 01:31 /var/log/elasticsearch/elasticsearch.log
-rw-rw-r--. 1 elasticsearch elasticsearch      0  1月  5 01:21 /var/log/elasticsearch/elasticsearch_audit.json
-rw-rw-r--. 1 elasticsearch elasticsearch      0  1月  5 01:21 /var/log/elasticsearch/elasticsearch_deprecation.json
-rw-rw-r--. 1 elasticsearch elasticsearch      0  1月  5 01:21 /var/log/elasticsearch/elasticsearch_deprecation.log
-rw-rw-r--. 1 elasticsearch elasticsearch      0  1月  5 01:21 /var/log/elasticsearch/elasticsearch_index_indexing_slowlog.json
-rw-rw-r--. 1 elasticsearch elasticsearch      0  1月  5 01:21 /var/log/elasticsearch/elasticsearch_index_indexing_slowlog.log
-rw-rw-r--. 1 elasticsearch elasticsearch      0  1月  5 01:21 /var/log/elasticsearch/elasticsearch_index_search_slowlog.json
-rw-rw-r--. 1 elasticsearch elasticsearch      0  1月  5 01:21 /var/log/elasticsearch/elasticsearch_index_search_slowlog.log
-rw-rw-r--. 1 elasticsearch elasticsearch  41027  1月  5 01:31 /var/log/elasticsearch/elasticsearch_server.json
-rw-rw-r--. 1 elasticsearch elasticsearch 118052  1月  5 01:33 /var/log/elasticsearch/gc.log
-rw-rw-r--. 1 elasticsearch elasticsearch   1443  1月  5 01:20 /var/log/elasticsearch/gc.log.00
-rw-rw-r--. 1 elasticsearch elasticsearch   2485  1月  5 01:20 /var/log/elasticsearch/gc.log.01
-rw-rw-r--. 1 elasticsearch elasticsearch   1454  1月  5 01:20 /var/log/elasticsearch/gc.log.02
-rw-rw-r--. 1 elasticsearch elasticsearch   2502  1月  5 01:20 /var/log/elasticsearch/gc.log.03
-rw-rw-r--. 1 elasticsearch elasticsearch   1453  1月  5 01:21 /var/log/elasticsearch/gc.log.04
-rw-rw-r--. 1 elasticsearch elasticsearch 202454  1月  5 01:28 /var/log/elasticsearch/gc.log.05
-rw-rw-r--. 1 elasticsearch elasticsearch   1455  1月  5 01:30 /var/log/elasticsearch/gc.log.06
-rw-rw-r--. 1 elasticsearch elasticsearch   2504  1月  5 01:30 /var/log/elasticsearch/gc.log.07
-rw-rw-r--. 1 elasticsearch elasticsearch   1453  1月  5 01:30 /var/log/elasticsearch/gc.log.08
```

### 4.プロセス状態の確認

**elasticsearchユーザー**でなくてもよい
ログにはかれているプロセスIDとpsコマンドの出力結果に含まれているプロセスIDが一致していればプログラムはうまく動いていそう。

```
$grep -Po 'pid\[([0-9]+)\]' launch_elasticsearch.log
pid[552]

$ps -aux
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
elastic+     1  0.0  0.0  42688  1560 pts/0    Ss+  01:20   0:00 /usr/sbin/init
elastic+   221  0.0  0.0  14376  2080 pts/1    Ss   01:21   0:00 /bin/bash
elastic+   552 10.1  4.0 6897796 1321640 pts/1 Sl   01:30   0:19 /usr/share/elasticsearch/jdk/bin/java -Des.networkaddress.cache.ttl=60 -Des.networkaddress.cache.negative.ttl=10 -XX:+AlwaysPreTouch -Xss1m -Djava
elastic+   648  0.0  0.0  70444  4516 pts/1    Sl   01:30   0:00 /usr/share/elasticsearch/modules/x-pack-ml/platform/linux-x86_64/bin/controller
elastic+   704  0.0  0.0  54296  1868 pts/1    R+   01:34   0:00 ps -aux
```

### 5.待ち受けポート確認

```
$lsof -i:9200
COMMAND PID          USER   FD   TYPE  DEVICE SIZE/OFF NODE NAME
java    552 elasticsearch  339u  IPv4 3950994      0t0  TCP localhost:wap-wsp (LISTEN)
```

### 6.ターミナルから起動確認

curlコマンドで起動確認

```
$curl localhost:9200
{
  "name" : "23df2d9237d5",
  "cluster_name" : "elasticsearch",
  "cluster_uuid" : "2x4llkX4QWWAU-vM0iyxqw",
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
$curl http://localhost:9200
{
  "name" : "23df2d9237d5",
  "cluster_name" : "elasticsearch",
  "cluster_uuid" : "2x4llkX4QWWAU-vM0iyxqw",
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

### 7.elasticseachプロセス停止

**kibana**のように**/etc/rc.d/init.d/elasticsearch**コマンドで実行するとunit.service経由となるので、うまくいかない。手動でプロセスkill。

```
$ps -aux
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
elastic+     1  0.0  0.0  42688  1560 pts/0    Ss+  01:20   0:00 /usr/sbin/init
elastic+   221  0.0  0.0  14376  2072 pts/1    Ss   01:21   0:00 /bin/bash
elastic+   242  5.3  4.0 7898304 1307912 pts/1 Sl   01:21   0:21 /usr/share/elasticsearch/jdk/bin/java -Des.networkaddress.cache.ttl=60 -Des.networkaddress.cache.negative.ttl=10 -XX:+AlwaysPreTouch -Xss1m -Djava
elastic+   337  0.0  0.0  70444  4512 pts/1    Sl   01:21   0:00 /usr/share/elasticsearch/modules/x-pack-ml/platform/linux-x86_64/bin/controller
elastic+   418  0.0  0.0  54296  1868 pts/1    R+   01:28   0:00 ps -aux
$sudo kill 242
$ps -aux
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
elastic+     1  0.0  0.0  42688  1560 pts/0    Ss+  01:20   0:00 /usr/sbin/init
elastic+   221  0.0  0.0  14376  2072 pts/1    Ss   01:21   0:00 /bin/bash
elastic+   452  0.0  0.0  54296  1872 pts/1    R+   01:28   0:00 ps -aux
```

ログ

```
$tail ~/launch_elasticsearch.log
[2020-01-05T01:22:05,448][INFO ][o.e.l.LicenseService     ] [23df2d9237d5] license [d3d3adc4-5ebc-4e8c-b5cd-c26c1b00ffcb] mode [basic] - valid
[2020-01-05T01:22:05,449][INFO ][o.e.x.s.s.SecurityStatusChangeListener] [23df2d9237d5] Active license is now [BASIC]; Security is disabled
[2020-01-05T01:28:44,141][INFO ][o.e.n.Node               ] [23df2d9237d5] stopping ...
[2020-01-05T01:28:44,149][INFO ][o.e.x.w.WatcherService   ] [23df2d9237d5] stopping watch service, reason [shutdown initiated]
[2020-01-05T01:28:44,149][INFO ][o.e.x.w.WatcherLifeCycleService] [23df2d9237d5] watcher has stopped and shutdown
[2020-01-05T01:28:44,308][INFO ][o.e.x.m.p.l.CppLogMessageHandler] [23df2d9237d5] [controller/337] [Main.cc@150] Ml controller exiting
[2020-01-05T01:28:44,310][INFO ][o.e.x.m.p.NativeController] [23df2d9237d5] Native controller process has stopped - no new native processes can be started
[2020-01-05T01:28:44,317][INFO ][o.e.n.Node               ] [23df2d9237d5] stopped
[2020-01-05T01:28:44,317][INFO ][o.e.n.Node               ] [23df2d9237d5] closing ...
[2020-01-05T01:28:44,322][INFO ][o.e.n.Node               ] [23df2d9237d5] closed
```

## kibanaサービス

### 1.バージョン確認

**kibanaユーザー**で確認
```
$/usr/share/kibana/bin/kibana -V
7.5.1
```

### 2.コマンドラインツールのヘルプ表示

**kibanaユーザー**で確認

プラグイン管理等に使うのであろう。

```
$/usr/share/kibana/bin/kibana --help

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

### 3.kibanaプロセス開始

棲み分け楽にするためにログ。kibanaプロセスが新規作成してくれるので。

```
$sudo rm -rf /var/log/kibana/kibana.stderr /var/log/kibana/kibana.stdout
```

**rootユーザー**で実行

**kibana started**と標準出力に表示されたら次はログ確認

```
$sudo /etc/rc.d/init.d/kibana start
kibana started
```

### 4.起動ログを確認

ログは以下で確認できる。標準エラー出力のログファイルに何も出ていなければOK。

```
$ll /var/log/kibana/*
-rw-r--r--. 1 root root     0  1月  5 01:41 /var/log/kibana/kibana.stderr
-rw-r--r--. 1 root root 24345  1月  5 01:42 /var/log/kibana/kibana.stdout
```

こういうのは
```
$cat /var/log/kibana/kibana.stderr

 FATAL  Error: listen EADDRNOTAVAIL: address not available 172.17.0.3:5601

```

**server.host: 172.17.0.2**ここの値をコンテナマシンのIPと同じか確認

```
$sudo vi /etc/kibana/kibana.yml
$head -n10 /etc/kibana/kibana.yml
# Kibana is served by a back end server. This setting specifies the port to use.
server.port: 5601

# Specifies the address to which the Kibana server will bind. IP addresses and host names are both valid values.
# The default is 'localhost', which usually means remote machines will not be able to connect.
# To allow connections from remote users, set this parameter to a non-loopback address.
server.host: "172.17.0.2"

# Enables you to specify a path to mount Kibana at if you are running behind a proxy.
# Use the `server.rewriteBasePath` setting to tell Kibana if it should remove the basePath

```

うまくいっているときのログ

```
$tail /var/log/kibana/kibana.stdout
{"type":"log","@timestamp":"2020-01-04T16:42:02Z","tags":["status","plugin:cross_cluster_replication@7.5.1","info"],"pid":1012,"state":"green","message":"Status changed from yellow to green - Ready","prevState":"yellow","prevMsg":"Waiting for Elasticsearch"}
{"type":"log","@timestamp":"2020-01-04T16:42:02Z","tags":["status","plugin:file_upload@7.5.1","info"],"pid":1012,"state":"green","message":"Status changed from yellow to green - Ready","prevState":"yellow","prevMsg":"Waiting for Elasticsearch"}
{"type":"log","@timestamp":"2020-01-04T16:42:02Z","tags":["status","plugin:snapshot_restore@7.5.1","info"],"pid":1012,"state":"green","message":"Status changed from yellow to green - Ready","prevState":"yellow","prevMsg":"Waiting for Elasticsearch"}
{"type":"log","@timestamp":"2020-01-04T16:42:02Z","tags":["info","monitoring","kibana-monitoring"],"pid":1012,"message":"Starting monitoring stats collection"}
{"type":"log","@timestamp":"2020-01-04T16:42:02Z","tags":["status","plugin:maps@7.5.1","info"],"pid":1012,"state":"green","message":"Status changed from yellow to green - Ready","prevState":"yellow","prevMsg":"Waiting for Elasticsearch"}
{"type":"log","@timestamp":"2020-01-04T16:42:02Z","tags":["status","plugin:spaces@7.5.1","info"],"pid":1012,"state":"green","message":"Status changed from yellow to green - Ready","prevState":"yellow","prevMsg":"Waiting for Elasticsearch"}
{"type":"log","@timestamp":"2020-01-04T16:42:03Z","tags":["reporting","warning"],"pid":1012,"message":"Generating a random key for xpack.reporting.encryptionKey. To prevent pending reports from failing on restart, please set xpack.reporting.encryptionKey in kibana.yml"}
{"type":"log","@timestamp":"2020-01-04T16:42:03Z","tags":["status","plugin:reporting@7.5.1","info"],"pid":1012,"state":"green","message":"Status changed from uninitialized to green - Ready","prevState":"uninitialized","prevMsg":"uninitialized"}
{"type":"log","@timestamp":"2020-01-04T16:42:03Z","tags":["listening","info"],"pid":1012,"message":"Server running at http://172.17.0.2:5601"}
{"type":"log","@timestamp":"2020-01-04T16:42:03Z","tags":["info","http","server","Kibana"],"pid":1012,"message":"http server running at http://172.17.0.2:5601"}
```

### 5.プロセス状態の確認

ログにはかれているプロセスIDとpsコマンドの出力結果に含まれているプロセスIDが一致していればプログラムはうまく動いていそう。

```
$grep -Po '"pid":([0-9]+)' /var/log/kibana/kibana.stdout | tail -n1
"pid":1012
$ps aux
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
elastic+     1  0.0  0.0  42688  1556 pts/0    Ss+  01:20   0:00 /usr/sbin/init
elastic+   552  3.8  4.1 9071040 1370988 ?     Sl   01:30   0:34 /usr/share/elasticsearch/jdk/bin/java -Des.networkaddress.cache.ttl=60 -Des.networkaddress.cache.negative.ttl=10 -XX:+AlwaysPreTouch -Xss1m -Djava
elastic+   648  0.0  0.0  70444  4516 ?        Sl   01:30   0:00 /usr/share/elasticsearch/modules/x-pack-ml/platform/linux-x86_64/bin/controller
elastic+   712  0.0  0.0  14376  2044 pts/2    Ss   01:35   0:00 /bin/bash
root       734  0.0  0.0  87256  2492 pts/2    S    01:35   0:00 su kibana
kibana     735  0.0  0.0  14376  2084 pts/2    S    01:35   0:00 bash
kibana    1012  9.9  1.0 1713012 341960 pts/2  Sl   01:41   0:22 /usr/share/kibana/bin/../node/bin/node /usr/share/kibana/bin/../src/cli -c /etc/kibana/kibana.yml
kibana    1141  0.0  0.0  54296  1872 pts/2    R+   01:45   0:00 ps aux
```

### 6.ブラウザから確認

以下のurlでアクセス

```
http://192.168.1.109:5601
```

![](./1.png)
![](./2.png)

### 7.kibanaプロセス停止

**kibanaユーザー**で実行

**kibana stop failed; still running.** といいつつもプロセスはkillされているので。OK。

```
$/etc/rc.d/init.d/kibana stop
kibana stop failed; still running.
```

ログ

```
$tail /var/log/kibana/kibana.stdout
{"type":"response","@timestamp":"2020-01-04T16:47:46Z","tags":[],"pid":1012,"method":"post","statusCode":200,"req":{"url":"/api/telemetry/report","method":"post","headers":{"host":"192.168.1.109:5601","connection":"keep-alive","content-length":"464","kbn-system-api":"true","origin":"http://192.168.1.109:5601","kbn-version":"7.5.1","user-agent":"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36","content-type":"application/json","accept":"*/*","referer":"http://192.168.1.109:5601/app/kibana","accept-encoding":"gzip, deflate","accept-language":"ja,en-US;q=0.9,en;q=0.8"},"remoteAddress":"192.168.1.109","userAgent":"192.168.1.109","referer":"http://192.168.1.109:5601/app/kibana"},"res":{"statusCode":200,"responseTime":796,"contentLength":9},"message":"POST /api/telemetry/report 200 796ms - 9.0B"}
{"type":"log","@timestamp":"2020-01-04T16:48:47Z","tags":["info","plugins-system"],"pid":1012,"message":"Stopping all plugins."}
{"type":"log","@timestamp":"2020-01-04T16:48:47Z","tags":["info","plugins","data"],"pid":1012,"message":"Stopping plugin"}
{"type":"log","@timestamp":"2020-01-04T16:48:47Z","tags":["info","plugins","translations"],"pid":1012,"message":"Stopping plugin"}
{"type":"log","@timestamp":"2020-01-04T16:48:47Z","tags":["info","plugins","spaces"],"pid":1012,"message":"Stopping plugin"}
{"type":"log","@timestamp":"2020-01-04T16:48:47Z","tags":["info","plugins","features"],"pid":1012,"message":"Stopping plugin"}
{"type":"log","@timestamp":"2020-01-04T16:48:47Z","tags":["info","plugins","timelion"],"pid":1012,"message":"Stopping plugin"}
{"type":"log","@timestamp":"2020-01-04T16:48:47Z","tags":["info","plugins","code"],"pid":1012,"message":"Stopping plugin"}
{"type":"log","@timestamp":"2020-01-04T16:48:47Z","tags":["info","plugins","licensing"],"pid":1012,"message":"Stopping plugin"}
{"type":"log","@timestamp":"2020-01-04T16:48:47Z","tags":["info","plugins","security"],"pid":1012,"message":"Stopping plugin"}
```

プロセス

```
$ps aux
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
elastic+     1  0.0  0.0  42688  1556 pts/0    Ss+  01:20   0:00 /usr/sbin/init
elastic+   552  3.6  4.2 9078200 1388848 ?     Sl   01:30   0:41 /usr/share/elasticsearch/jdk/bin/java -Des.networkaddress.cache.ttl=60 -Des.networkaddress.cache.negative.ttl=10 -XX:+AlwaysPreTouch -Xss1m -Djava
elastic+   648  0.0  0.0  70444  4516 ?        Sl   01:30   0:00 /usr/share/elasticsearch/modules/x-pack-ml/platform/linux-x86_64/bin/controller
elastic+   712  0.0  0.0  14376  2044 pts/2    Ss   01:35   0:00 /bin/bash
root       734  0.0  0.0  87256  2492 pts/2    S    01:35   0:00 su kibana
kibana     735  0.0  0.0  14376  2084 pts/2    S    01:35   0:00 bash
kibana    1180  0.0  0.0  54296  1876 pts/2    R+   01:49   0:00 ps aux
```
