- 事象
```
$ ls -l /usr/local/src/spark-2.4.5-bin-hadoop2.7/sbin/start-master.sh
-rwxr-xr-x. 1 hadoop hadoop 2050  2月  3 04:47 /usr/local/src/spark-2.4.5-bin-hadoop2.7/sbin/start-master.sh

$ start-master.sh
starting org.apache.spark.deploy.master.Master, logging to /usr/local/src/spark-2.4.5-bin-hadoop2.7/logs/spark-hadoop-org.apache.spark.deploy.master.Master-1-docker-container-ubuntu-16-04-postgres-python-vim.out
failed to launch: nice -n 0 /usr/local/src/spark-2.4.5-bin-hadoop2.7/bin/spark-class org.apache.spark.deploy.master.Master --host docker-container-ubuntu-16-04-postgres-python-vim --port 7077 --webui-port 8080
  	at org.apache.spark.SecurityManager.<init>(SecurityManager.scala:79)
  	at org.apache.spark.deploy.master.Master$.startRpcEnvAndEndpoint(Master.scala:1073)
  	at org.apache.spark.deploy.master.Master$.main(Master.scala:1058)
  	at org.apache.spark.deploy.master.Master.main(Master.scala)
  Caused by: java.lang.StringIndexOutOfBoundsException: begin 0, end 3, length 2
  	at java.base/java.lang.String.checkBoundsBeginEnd(String.java:3319)
  	at java.base/java.lang.String.substring(String.java:1874)
  	at org.apache.hadoop.util.Shell.<clinit>(Shell.java:52)
  	... 15 more
  20/05/12 07:25:32 INFO ShutdownHookManager: Shutdown hook called
full log in /usr/local/src/spark-2.4.5-bin-hadoop2.7/logs/spark-hadoop-org.apache.spark.deploy.master.Master-1-docker-container-ubuntu-16-04-postgres-python-vim.out
```

- 原因
  javaのマイクロバージョンのちがい？？イケてる環境もあるので、よくわからん。
```
curl -sSLO https://ftp.jaist.ac.jp/pub/apache/spark/spark-2.4.5/spark-2.4.5-bin-hadoop2.7.tgz
```

```
$ java -version
openjdk version "1.8.0_252"
OpenJDK Runtime Environment (build 1.8.0_252-8u252-b09-1~16.04-b09)
OpenJDK 64-Bit Server VM (build 25.252-b09, mixed mode)
```

- 対策
  - このエラー自体は起きてるらしいし、3系ではなおってるので、切り替える。

- 予防
  - 行ける環境探せばいい
