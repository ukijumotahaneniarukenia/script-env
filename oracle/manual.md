# 参考文献
```
https://oracle-base.com/articles/19c/oracle-db-19c-rpm-installation-on-oracle-linux-7
https://github.com/oraclebase/dockerfiles/tree/master/database/ol7_19
https://qiita.com/s-sasaki/items/cb768bd00d3588f494d4#%E6%9C%AA%E8%A7%A3%E6%B1%BA
https://qiita.com/manymanyuni/items/ee2a3b9032750fdf5d72#%E3%83%AC%E3%82%B9%E3%83%9D%E3%83%B3%E3%82%B9%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB
http://tamasaban.blog.fc2.com/blog-entry-40.html
https://docs.oracle.com/en/database/oracle/oracle-database/19/ladbi/running-rpm-packages-to-install-oracle-database.html#GUID-BB7C11E3-D385-4A2F-9EAF-75F4F0AACF02
https://qiita.com/mon_tu/items/6726524e738071afb7a7
https://heavywatal.github.io/cxx/gcc.html
https://orablogs-jp.blogspot.com/2016/07/creating-and-oracle-database-docker.html
https://qiita.com/yahihi/items/351018be17585f28926b
http://sugimura.cc/pukiwiki/?%E6%8A%80%E8%A1%93%E6%96%87%E6%9B%B8%2FOracle%2F11g%2F%E3%83%A1%E3%83%A2%E3%83%AA%E3%81%AE%E8%A8%AD%E5%AE%9A
```

# Dockerfileよりイメージ作成
```
time docker build -t centos_oracle . | tee log
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
docker run --privileged -v /etc/localtime:/etc/localtime -p 28787:8787 -p 21521:1521 -p 25500:5500 -itd --name oracle --shm-size=8g centos_oracle /sbin/init
```

# dockerコンテナ潜入

```
docker exec --user root -it oracle /bin/bash
```

```
[oracle@ee5b841469f7 /]$ touch /u01/app/oracle/product/19.0.0/dbhome_1/dbs/ora_control1
[oracle@ee5b841469f7 /]$ touch /u01/app/oracle/product/19.0.0/dbhome_1/dbs/ora_control2
```

rpmあるぽい
```
方針転換
https://docs.oracle.com/en/database/oracle/oracle-database/19/ladbi/running-rpm-packages-to-install-oracle-database.html#GUID-BB7C11E3-D385-4A2F-9EAF-75F4F0AACF02

https://docs.oracle.com/en/database/oracle/oracle-database/19/ladbi/running-rpm-packages-to-install-oracle-database.html#GUID-BB7C11E3-D385-4A2F-9EAF-75F4F0AACF02

```
