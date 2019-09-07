# 参考文献
https://www.elastic.co/guide/en/elasticsearch/reference/current/rpm.html
https://tech.recruit-mp.co.jp/infrastructure/docker-elasticsearch/

# dockerイメージ作成
```
time docker build -t centos_elastic . | tee log
```


# dockerコンテナ起動
```
docker run --privileged -itd --name elastic -p 5601:5601 -p 9200:9200 centos_elastic /sbin/init
```

# dockerコンテナ潜入
```
docker exec -it elastic /bin/bash
```

# ポート単位で起動確認
```
```

# elasticサービス起動
```
[root@5114cdcac8a8 /]# systemctl status elasticsearch.service
● elasticsearch.service - Elasticsearch
   Loaded: loaded (/usr/lib/systemd/system/elasticsearch.service; disabled; vendor preset: disabled)
   Active: inactive (dead)
     Docs: http://www.elastic.co
[root@5114cdcac8a8 /]# systemctl start elasticsearch.service
[root@5114cdcac8a8 /]# systemctl status elasticsearch.service
● elasticsearch.service - Elasticsearch
   Loaded: loaded (/usr/lib/systemd/system/elasticsearch.service; disabled; vendor preset: disabled)
   Active: active (running) since Sat 2019-09-07 05:56:27 UTC; 1s ago
     Docs: http://www.elastic.co
 Main PID: 2637 (java)
   CGroup: /docker/5114cdcac8a8fb7e8f43a83e520f9e6eee240d0efc4e3b795a5f878bb5294d7a/system.slice/elasticsearch.service
           ├─2637 /usr/share/elasticsearch/jdk/bin/java -Xms1g -Xmx1g -XX:+UseConcMarkSweepGC -XX:CMSInitiatingOccupancyFraction=75 -XX:+UseCMSInitiatingOccupancyOnly -Des.networkaddress....
           └─2733 /usr/share/elasticsearch/modules/x-pack-ml/platform/linux-x86_64/bin/controller
           ‣ 2637 /usr/share/elasticsearch/jdk/bin/java -Xms1g -Xmx1g -XX:+UseConcMarkSweepGC -XX:CMSInitiatingOccupancyFraction=75 -XX:+UseCMSInitiatingOccupancyOnly -Des.networkaddress....

Sep 07 05:56:27 5114cdcac8a8 systemd[1]: Started Elasticsearch.
Sep 07 05:56:28 5114cdcac8a8 elasticsearch[2637]: OpenJDK 64-Bit Server VM warning: Option UseConcMarkSweepGC was deprecated in version 9.0 and will likely be removed in a future release.
```
# elasticサービス動作確認
```
[root@5114cdcac8a8 /]# curl localhost:9200
{
  "name" : "5114cdcac8a8",
  "cluster_name" : "elasticsearch",
  "cluster_uuid" : "V3XE5GN9SUOJ0G-qhymAUA",
  "version" : {
    "number" : "7.3.1",
    "build_flavor" : "default",
    "build_type" : "rpm",
    "build_hash" : "4749ba6",
    "build_date" : "2019-08-19T20:19:25.651794Z",
    "build_snapshot" : false,
    "lucene_version" : "8.1.0",
    "minimum_wire_compatibility_version" : "6.8.0",
    "minimum_index_compatibility_version" : "6.0.0-beta1"
  },
  "tagline" : "You Know, for Search"
}
```
# kibanaサービス起動
```
[root@d2e4edee78e4 /]# systemctl status kibana.service
● kibana.service - Kibana
   Loaded: loaded (/etc/systemd/system/kibana.service; disabled; vendor preset: disabled)
   Active: inactive (dead)

Sep 07 06:32:47 d2e4edee78e4 systemd[1]: [/etc/systemd/system/kibana.service:3] Unknown lvalue 'StartLimitIntervalSec' in section 'Unit'
Sep 07 06:32:47 d2e4edee78e4 systemd[1]: [/etc/systemd/system/kibana.service:4] Unknown lvalue 'StartLimitBurst' in section 'Unit'
[root@d2e4edee78e4 /]# systemctl start kibana.service
[root@d2e4edee78e4 /]# systemctl status kibana.service
● kibana.service - Kibana
   Loaded: loaded (/etc/systemd/system/kibana.service; disabled; vendor preset: disabled)
   Active: active (running) since Sat 2019-09-07 06:32:59 UTC; 1s ago
 Main PID: 2792 (node)
   CGroup: /docker/d2e4edee78e4343654f2cc4e1eb45f8db4210501f2a8575acccac50dbb8cb581/system.slice/kibana.service
           └─2792 /usr/share/kibana/bin/../node/bin/node --no-warnings --max-http-header-size=65536 /usr/share/kibana/bin/../src/cli -c /etc/kibana/kibana.yml
           ‣ 2792 /usr/share/kibana/bin/../node/bin/node --no-warnings --max-http-header-size=65536 /usr/share/kibana/bin/../src/cli -c /etc/kibana/kibana.yml

Sep 07 06:32:59 d2e4edee78e4 systemd[1]: Started Kibana.
Sep 07 06:33:00 d2e4edee78e4 kibana[2792]: {"type":"log","@timestamp":"2019-09-07T06:33:00Z","tags":["info","plugins-system"],"pid":2792,"message":"Setting up [1] plugins: [translations]"}
Sep 07 06:33:00 d2e4edee78e4 kibana[2792]: {"type":"log","@timestamp":"2019-09-07T06:33:00Z","tags":["info","plugins","translations"],"pid":2792,"message":"Setting up plugin"}
Sep 07 06:33:00 d2e4edee78e4 kibana[2792]: {"type":"log","@timestamp":"2019-09-07T06:33:00Z","tags":["info","plugins-system"],"pid":2792,"message":"Starting [1] plugins: [translations]"}
```
