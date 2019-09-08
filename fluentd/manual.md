# めも
手順確立後、elasticにマージ

# 参考文献
```
https://docs.fluentd.org/installation/before-install
```

# dockerイメージ作成
```
time docker build -t centos_fluentd . | tee log
```

# dockerコンテナ起動
```
docker run --privileged -itd --name fluentd centos_fluentd /sbin/init
```

# dockerコンテナ潜入
```
docker exec -it fluentd /bin/bash
```

# サービス起動
```
[root@c043a1da5978 /]# systemctl start td-agent.service
[root@c043a1da5978 /]# systemctl status td-agent.service
● td-agent.service - td-agent: Fluentd based data collector for Treasure Data
   Loaded: loaded (/usr/lib/systemd/system/td-agent.service; disabled; vendor preset: disabled)
   Active: active (running) since Sun 2019-09-08 12:54:36 UTC; 4s ago
     Docs: https://docs.treasuredata.com/articles/td-agent
  Process: 632 ExecStart=/opt/td-agent/embedded/bin/fluentd --log /var/log/td-agent/td-agent.log --daemon /var/run/td-agent/td-agent.pid $TD_AGENT_OPTIONS (code=exited, status=0/SUCCESS)
 Main PID: 637 (fluentd)
   CGroup: /docker/c043a1da5978e4330de2076e27c326e03a953f8b79922db60837442bff893b25/system.slice/td-agent.service
           ├─637 /opt/td-agent/embedded/bin/ruby /opt/td-agent/embedded/bin/fluentd --log /var/log/td-agent/td-agent.log --daemon /var/run/td-agent/td-agent.pid
           └─642 /opt/td-agent/embedded/bin/ruby -Eascii-8bit:ascii-8bit /opt/td-agent/embedded/bin/fluentd --log /var/log/td-agent/td-agent.log --daemon /var/run/td-agent/td-agent.pid --...
           ‣ 637 /opt/td-agent/embedded/bin/ruby /opt/td-agent/embedded/bin/fluentd --log /var/log/td-agent/td-agent.log --daemon /var/run/td-agent/td-agent.pid

Sep 08 12:54:36 c043a1da5978 systemd[1]: Starting td-agent: Fluentd based data collector for Treasure Data...
Sep 08 12:54:36 c043a1da5978 systemd[1]: Started td-agent: Fluentd based data collector for Treasure Data.
```
