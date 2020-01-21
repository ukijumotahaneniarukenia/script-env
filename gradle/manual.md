# domaで自動生成

http://gradle.monochromeroad.com/docs/userguide/userguide_single.html#hello</br>

https://ksby.hatenablog.com/entry/2015/10/15/043336</br>

https://doma.readthedocs.io/en/stable/getting-started-eclipse/#install-jdk</br>

https://github.com/domaframework/doma/</br>

https://github.com/domaframework/doma-spring-boot</br>

https://doma.readthedocs.io/en/stable/config/</br>

日本語環境と時刻合わせ

https://kunst1080.hatenablog.com/entry/2016/07/17/181256

# Mysql WorkBenchいんすこ

対話入力があれなので、コンテナ潜入後、優しく実行

ロケール問題解消しておくと、ベンチ起動時のログがいい感じになるので、次のロケール設定時の前に日本語パックのインストールを実行しておきたい

rootユーザーで実行
```
$apt-get -y install language-pack-ja-base language-pack-ja ibus-mozc
```

いろいろきかれるがこんな感じで回答

98->4

```
キーボードのレイアウトは国によって異なり、いくつかの国では複数の一般的レイアウトがあります。このコンピュータのキーボードが由来する国を選択し
てください。

  1. Bangla                           21. アルメニア語                       41. スロバキア語                 61. フィリピノ語                          81. マルタ語
  2. Berber (Algeria, Latin)          22. イタリア語                          42. スロベニア語                 62. フィンランド語                       82. モンゴル語
  3. Dhivehi                          23. イラク語                             43. スワヒリ語 (ケニア)        63. フェロー語                             83. モンテネグロ語
  4. English (Australian)             24. ウォロフ語                          44. スワヒリ語 (タンザニア)  64. フランス語                             84. ラオ語
  5. French (Togo)                    25. ウクライナ語                       45. セルビア語                    65. フランス語 (カナダ)                 85. ラトビア語
  6. Indian                           26. ウズベク語                          46. ゾンカ語                       66. フランス語 (ギニア)                 86. リトアニア語
  7. Indonesian (Jawi)                27. ウルドゥー語 (パキスタン)     47. タイ語                          67. フランス語 (コンゴ民主共和国)  87. ルーマニア語
  8. Japanese (PC-98)                 28. エストニア語                       48. タジク語                       68. ブライユ点字                          88. ロシア語
  9. Malay (Jawi, Arabic Keyboard)    29. エスペラント語                    49. チェコ語                       69. ブルガリア語                          89. 英語 (UK)
  10. Moldavian                       30. オランダ語                          50. ツワナ語                       70. ヘブライ語                             90. 英語 (US)
  11. Switzerland                     31. カザフ語                             51. デンマーク語                 71. ベトナム語                             91. 英語 (カメルーン)
  12. アイスランド語           32. キルギス語                          52. トルクメン語                 72. ベラルーシ語                          92. 英語 (ガーナ)
  13. アイルランド語           33. ギリシャ語                          53. トルコ語                       73. ベルギー語                             93. 英語 (ナイジェリア)
  14. アゼルバイジャン語     34. クメール語 (カンボジア)        54. ドイツ語                       74. ペルシア語                             94. 英語 (南アフリカ)
  15. アフガニスタン語        35. クロアチア語                       55. ドイツ語 (オーストリア)  75. ボスニア語                             95. 台湾語
  16. アムハラ語                 36. グルジア語                          56. ネパール語                    76. ポーランド語                          96. 中国語
  17. アラビア語                 37. シンハラ語 (表音)                 57. ノルウェー語                 77. ポルトガル語                          97. 朝鮮語、韓国語
  18. アラビア語 (シリア)     38. スウェーデン語                    58. ハンガリー語                 78. ポルトガル語 (ブラジル)           98. 日本語
  19. アラビア語 (モロッコ)  39. スペイン語                          59. バンバラ語                    79. マオリ語
  20. アルバニア語              40. スペイン語 (ラテンアメリカ)  60. ビルマ語                       80. マケドニア語
キーボードが由来する国: 98
このマシンのキーボードに適したレイアウトを選んでください。

  1. 日本語  2. 日本語 - 日本語 (Dvorak)  3. 日本語 - 日本語 (Macintosh)  4. 日本語 - 日本語 (OADG 109A)  5. 日本語 - 日本語 (かな 86)  6. 日本語 - 日本語 (かな)
キーボードのレイアウト: 4
```

ロケール設定

```
$locale-gen ja_JP.UTF-8
```

設定後
```
root@fd8b87b82555:/home/kuraine# locale-gen ja_JP.UTF-8
Generating locales (this might take a while)...
  ja_JP.UTF-8... done
Generation complete.
```

ベンチいんすこ要件としていくつかパッケージをインストールしておく

rootユーザーで実行
```
$apt-get install -y libquazip5-dev libsigc++-2.0-dev libpcrecpp0v5 libmysqlclient21 libgtk2.0-dev libglibmm-2.4-dev libatkmm-1.6-dev libxml2-dev libsecret-1-dev libpangocairo-1.0-0 libgdk-pixbuf2.0-dev libcairo2-dev libgtk-3-dev libgtkmm-3.0-dev python2.7-dev libquazip5-dev libzip5 packagekit-gtk3-module canberra-gtk* libproj-dev proj-bin````
```

ベンチいんすこ
```
$cd /usr/local/src && dpkg -i mysql-workbench-community_8.0.19-1ubuntu19.10_amd64.deb
```

いんすこ時のログ
```
以前に未選択のパッケージ mysql-workbench-community を選択しています。
(データベースを読み込んでいます ... 現在 59536 個のファイルとディレクトリがインストールされています。)
mysql-workbench-community_8.0.19-1ubuntu19.10_amd64.deb を展開する準備をしています ...
mysql-workbench-community (8.0.19-1ubuntu19.10) を展開しています...
mysql-workbench-community (8.0.19-1ubuntu19.10) を設定しています ...
desktop-file-utils (0.24-1ubuntu1) のトリガを処理しています ...
mime-support (3.63ubuntu1) のトリガを処理しています ...
hicolor-icon-theme (0.17-2) のトリガを処理しています ...
shared-mime-info (1.10-1) のトリガを処理しています ...
```


# Mysql WorkBench起動

プロセス起動
```
$myb
[1] 11103
```

ログ確認
```
$tail launch_mysql-bench.log 
Found /lib/x86_64-linux-gnu/libproj.so.13
```

プロセス確認
```
$ ps aux
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
kuraine      1  0.0  0.0   4208  1984 pts/0    Ss+  01:15   0:00 /bin/bash
kuraine  11096  0.0  0.0   5372  2320 pts/1    Ss   01:33   0:00 /bin/bash
kuraine  11103  0.0  0.0   5108  1764 pts/1    S    01:33   0:00 /bin/bash /usr/bin/mysql-workbench
kuraine  11138  0.0  0.0   3832   808 pts/1    S    01:33   0:00 /bin/sh /usr/bin/catchsegv /usr/bin/mysql-workbench-bin
kuraine  11140  7.0  0.3 514156 101880 pts/1   SLl  01:33   0:01 /usr/bin/mysql-workbench-bin
kuraine  11145  0.0  0.0   8080   844 pts/1    S    01:33   0:00 dbus-launch --autolaunch=bc74deaa9e044c079ed6fc963d084157 --binary-syntax --close-stderr
kuraine  11146  0.0  0.0   8284  1532 ?        Ss   01:33   0:00 /usr/bin/dbus-daemon --syslog-only --fork --print-pid 5 --print-address 7 --session
kuraine  11161  1.5  0.1 1641212 42720 ?       SLl  01:33   0:00 /usr/bin/gnome-software --gapplication-service
kuraine  11167  0.0  0.0 235616  5100 ?        SLl  01:33   0:00 /usr/bin/gnome-keyring-daemon --start --foreground --components=secrets
kuraine  11177  0.0  0.0 157020  3236 ?        Sl   01:33   0:00 /usr/lib/dconf/dconf-service
kuraine  11197  0.0  0.0   7008  1560 pts/1    R+   01:33   0:00 ps aux
```

# dockerイメージ作成

```
time docker build -t ubuntu_gradle-doma . | tee log
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
docker run --privileged --shm-size=12gb --name ubuntu-gradle-doma -itd -v /run/udev:/run/udev -v /run/systemd:/run/systemd -v /tmp/.X11-unix:/tmp/.X11-unix -v /var/lib/dbus:/var/lib/dbus -v /var/run/dbus:/var/run/dbus -v /etc/machine-id:/etc/machine-id -v /etc/localtime:/etc/localtime:ro ubuntu_gradle-doma
```

# dockerコンテナ潜入

```
docker exec -it ubuntu-gradle-doma /bin/bash
```


■mysqlダウンロード

```
$cd /opt && curl -o mysql.deb https://repo.mysql.com/mysql-apt-config_0.8.14-1_all.deb
```

聞かれたらOKを選択する
```
$cd /opt && dpkg -i mysql.deb
```

ログ
```
$cd /opt && dpkg -i mysql.deb
以前に未選択のパッケージ mysql-apt-config を選択しています。
(データベースを読み込んでいます ... 現在 60827 個のファイルとディレクトリがインストールされています。)
mysql.deb を展開する準備をしています ...
mysql-apt-config (0.8.14-1) を展開しています...
mysql-apt-config (0.8.14-1) を設定しています ...
Warning: apt-key should not be used in scripts (called from postinst maintainerscript of the package mysql-apt-config)
OK
```

■mysqlインストール

```
$apt-get install -y mysql-server
```

■バージョン確認

```
$mysql --version
mysql  Ver 8.0.18-0ubuntu0.19.10.1 for Linux on x86_64 ((Ubuntu))
```

■環境整備

```
$rm -rf /var/lib/mysql
$>/var/log/mysql/error.log
$#https://stackoverflow.com/questions/34954455/mysql-daemon-lock-issue
$mkdir -p /var/run/mysqld
$chown mysql:mysql /var/run/mysqld
$mysqld --initialize --user=mysql
```

■ログからイニシャルパスワードを確認

```
$cat /var/log/mysql/error.log | grep password | cut -d' ' -f 13
```

■プロセス起動

```
$mysqld -D --user=mysql
mysqld will log errors to /var/log/mysql/error.log
mysqld is running as pid 882
$ps aux
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
kuraine      1  0.0  0.0   4076  1984 pts/0    Ss+  22:52   0:00 /bin/bash
kuraine      8  0.0  0.0   4212  2208 pts/1    Ss   22:52   0:00 /bin/bash
root        16  0.0  0.0   4428  1500 pts/1    S    22:52   0:00 su root
root        17  0.0  0.0   4208  2220 pts/1    S    22:52   0:00 bash
mysql      882 10.3  1.1 2003844 386556 ?      Sl   22:58   0:00 mysqld -D --user=mysql
root       925  0.0  0.0   5844  1496 pts/1    R+   22:58   0:00 ps aux
```

ログ確認

```
$cat /var/log/mysql/error.log
2020-01-21T13:55:59.111574Z 0 [System] [MY-013169] [Server] /usr/sbin/mysqld (mysqld 8.0.18-0ubuntu0.19.10.1) initializing of server in progress as process 827
2020-01-21T13:56:01.601176Z 5 [Note] [MY-010454] [Server] A temporary password is generated for root@localhost: w*>BYXJyW55R
2020-01-21T13:58:03.947748Z 0 [System] [MY-010116] [Server] /usr/sbin/mysqld (mysqld 8.0.18-0ubuntu0.19.10.1) starting as process 880
2020-01-21T13:58:04.371307Z 0 [Warning] [MY-010068] [Server] CA certificate ca.pem is self signed.
2020-01-21T13:58:04.415055Z 0 [System] [MY-010931] [Server] /usr/sbin/mysqld: ready for connections. Version: '8.0.18-0ubuntu0.19.10.1'  socket: '/var/run/mysqld/mysqld.sock'  port: 3306  (Ubuntu).
2020-01-21T13:58:04.494425Z 0 [System] [MY-011323] [Server] X Plugin ready for connections. Socket: '/var/run/mysqld/mysqlx.sock' bind-address: '::' port: 33060
```

# mysqlプロセスでのrootユーザーのパスワードを変更

デフォルトの値をログから確認
```
$grep password /var/log/mysql/error.log | cut -d" " -f 13
?=%1ihb/B?je
```

次のコマンドを実行して、確認した値を入力する（ログからこぴぺ）
```
$mysql -uroot -p
```

rootユーザーのパスワード変更
```
ALTER USER 'root'@'localhost' IDENTIFIED BY 'Mysql3306';
```

一般ユーザーの作成
```
CREATE USER 'user01'@'localhost' IDENTIFIED BY 'Mysql3306';
```

一般ユーザーに権限付与
```
GRANT ALL PRIVILEGES ON mysql.* TO 'user01'@'localhost' WITH GRANT OPTION;
```

データベース作成
```
create database testdb;
```

データベースに対する権限付与
```
grant all privileges on testdb.* to user01@localhost;
```

# データベース接続

rootユーザー
```
mysql -uroot -pMysql3306 -Dtestdb
```

一般ユーザー
```
mysql -uuser01 -pMysql3306 -Dtestdb
```

# サンプルデータベース投入


```
$cd ~ && $ curl -LO https://downloads.mysql.com/docs/sakila-db.zip && unzip sakila-db.zip
$cd sakila-db
$ls
sakila-data.sql  sakila-schema.sql  sakila.mwb
$mysql -uroot -pMysql3306 <sakila-schema.sql
mysql: [Warning] Using a password on the command line interface can be insecure.
$mysql -uroot -pMysql3306 <sakila-data.sql
mysql: [Warning] Using a password on the command line interface can be insecure.
$mysql -uroot -pMysql3306 -Dsakila
mysql> show tables;
+----------------------------+
| Tables_in_sakila           |
+----------------------------+
| actor                      |
| actor_info                 |
| address                    |
| category                   |
| city                       |
| country                    |
| customer                   |
| customer_list              |
| film                       |
| film_actor                 |
| film_category              |
| film_list                  |
| film_text                  |
| inventory                  |
| language                   |
| nicer_but_slower_film_list |
| payment                    |
| rental                     |
| sales_by_film_category     |
| sales_by_store             |
| staff                      |
| staff_list                 |
| store                      |
+----------------------------+
23 rows in set (0.01 sec)
```


他にもいろいろ
```
https://downloads.mysql.com/docs/menagerie-db.zip
https://github.com/datacharmer/test_db/archive/master.zip
https://downloads.mysql.com/docs/world.sql.zip
https://downloads.mysql.com/docs/world_x-db.zip
```


# build.gradleファイル作成

```
$cat build.gradle
configurations {
    domaGenRuntime
}

repositories {
    mavenCentral()
    maven {url 'https://oss.sonatype.org/content/repositories/snapshots/'}
}

dependencies {
    domaGenRuntime 'org.seasar.doma:doma-gen:2.26.0'
    domaGenRuntime 'mysql:mysql-connector-java:8.0.18'
}

task gen {
    group = 'doma-gen'
    doLast {
        ant.taskdef(resource: 'domagentask.properties',
            classpath: configurations.domaGenRuntime.asPath)
        ant.gen(url: 'jdbc:mysql://127.0.0.1/sakila', user: 'root', password: 'Mysql3306') {
            entityConfig()
            daoConfig()
            sqlConfig()
        }
    }
}
```

# build.gradleファイルがあるディレクトリでタスク実行

```
$ls
build.gradle  sakila-db  sakila-db.zip
```

# 実行
```
$gradle gen

> Task :gen
[ant:gen] Loading class `com.mysql.jdbc.Driver'. This is deprecated. The new driver class is `com.mysql.cj.jdbc.Driver'. The driver is automatically registered via the SPI and manual loading of the driver class is generally unnecessary.

BUILD SUCCESSFUL in 23s
1 actionable task: 1 executed
```

ダウンロードされたjarファイルは以下にある

```
$cd ~/.gradle/caches/modules-2/files-2.1
$find $(pwd) -name "*jar" 2>/dev/null
/home/kuraine/.gradle/caches/modules-2/files-2.1/org.seasar.doma/doma/2.26.0/a5c3237730a2c68215b7bbaa29b96bbbf9374b98/doma-2.26.0.jar
/home/kuraine/.gradle/caches/modules-2/files-2.1/org.seasar.doma/doma-gen/2.26.0/c72d09c4cc03e4cda66f172ba6c40997382ef423/doma-gen-2.26.0.jar
/home/kuraine/.gradle/caches/modules-2/files-2.1/org.freemarker/freemarker/2.3.20/5ad6bea46b5af666d88c260c8acc6a03408723c8/freemarker-2.3.20.jar
/home/kuraine/.gradle/caches/modules-2/files-2.1/mysql/mysql-connector-java/8.0.18/e088efaa4b568bc7d9f7274b9c5ea1a00da1a45c/mysql-connector-java-8.0.18.jar
/home/kuraine/.gradle/caches/modules-2/files-2.1/com.google.protobuf/protobuf-java/3.6.1/d06d46ecfd92ec6d0f3b423b4cd81cb38d8b924/protobuf-java-3.6.1.jar
/home/kuraine/.gradle/caches/modules-2/files-2.1/org.apache.ant/ant/1.9.3/311ac248030ff4f9f27e55561fadf3e99c646abb/ant-1.9.3.jar
/home/kuraine/.gradle/caches/modules-2/files-2.1/org.apache.ant/ant-launcher/1.9.3/a98ddc70a74c9cc6cad6520f857db59af8227e07/ant-launcher-1.9.3.jar
```

# 実行結果

実行後、中身が空のgradleフォルダと成果物が入ったsrcフォルダができた

```
$ls
build.gradle  gradle  sakila-db  sakila-db.zip  src
```

便利。
```
$find src -name "****"
src
src/main
src/main/resources
src/main/resources/META-INF
src/main/resources/META-INF/example
src/main/resources/META-INF/example/dao
src/main/resources/META-INF/example/dao/LanguageDao
src/main/resources/META-INF/example/dao/LanguageDao/selectById.sql
src/main/resources/META-INF/example/dao/PaymentDao
src/main/resources/META-INF/example/dao/PaymentDao/selectById.sql
src/main/resources/META-INF/example/dao/CityDao
src/main/resources/META-INF/example/dao/CityDao/selectById.sql
src/main/resources/META-INF/example/dao/FilmCategoryDao
src/main/resources/META-INF/example/dao/FilmCategoryDao/selectById.sql
src/main/resources/META-INF/example/dao/AddressDao
src/main/resources/META-INF/example/dao/AddressDao/selectById.sql
src/main/resources/META-INF/example/dao/CountryDao
src/main/resources/META-INF/example/dao/CountryDao/selectById.sql
src/main/resources/META-INF/example/dao/InventoryDao
src/main/resources/META-INF/example/dao/InventoryDao/selectById.sql
src/main/resources/META-INF/example/dao/ActorDao
src/main/resources/META-INF/example/dao/ActorDao/selectById.sql
src/main/resources/META-INF/example/dao/CustomerDao
src/main/resources/META-INF/example/dao/CustomerDao/selectById.sql
src/main/resources/META-INF/example/dao/CategoryDao
src/main/resources/META-INF/example/dao/CategoryDao/selectById.sql
src/main/resources/META-INF/example/dao/FilmDao
src/main/resources/META-INF/example/dao/FilmDao/selectById.sql
src/main/resources/META-INF/example/dao/RentalDao
src/main/resources/META-INF/example/dao/RentalDao/selectById.sql
src/main/resources/META-INF/example/dao/FilmTextDao
src/main/resources/META-INF/example/dao/FilmTextDao/selectById.sql
src/main/resources/META-INF/example/dao/SysConfigDao
src/main/resources/META-INF/example/dao/SysConfigDao/selectById.sql
src/main/resources/META-INF/example/dao/FilmActorDao
src/main/resources/META-INF/example/dao/FilmActorDao/selectById.sql
src/main/resources/META-INF/example/dao/StoreDao
src/main/resources/META-INF/example/dao/StoreDao/selectById.sql
src/main/resources/META-INF/example/dao/StaffDao
src/main/resources/META-INF/example/dao/StaffDao/selectById.sql
src/main/java
src/main/java/example
src/main/java/example/entity
src/main/java/example/entity/Language.java
src/main/java/example/entity/AddressListener.java
src/main/java/example/entity/StaffListener.java
src/main/java/example/entity/PaymentListener.java
src/main/java/example/entity/FilmTextListener.java
src/main/java/example/entity/CountryListener.java
src/main/java/example/entity/Category.java
src/main/java/example/entity/Country.java
src/main/java/example/entity/Payment.java
src/main/java/example/entity/FilmCategoryListener.java
src/main/java/example/entity/RentalListener.java
src/main/java/example/entity/Inventory.java
src/main/java/example/entity/ActorListener.java
src/main/java/example/entity/City.java
src/main/java/example/entity/SysConfig.java
src/main/java/example/entity/CustomerListener.java
src/main/java/example/entity/Film.java
src/main/java/example/entity/StoreListener.java
src/main/java/example/entity/FilmText.java
src/main/java/example/entity/FilmActorListener.java
src/main/java/example/entity/FilmActor.java
src/main/java/example/entity/Address.java
src/main/java/example/entity/InventoryListener.java
src/main/java/example/entity/Rental.java
src/main/java/example/entity/FilmCategory.java
src/main/java/example/entity/Customer.java
src/main/java/example/entity/CategoryListener.java
src/main/java/example/entity/SysConfigListener.java
src/main/java/example/entity/Store.java
src/main/java/example/entity/FilmListener.java
src/main/java/example/entity/Actor.java
src/main/java/example/entity/CityListener.java
src/main/java/example/entity/LanguageListener.java
src/main/java/example/entity/Staff.java
src/main/java/example/dao
src/main/java/example/dao/LanguageDao.java
src/main/java/example/dao/CustomerDao.java
src/main/java/example/dao/CountryDao.java
src/main/java/example/dao/CityDao.java
src/main/java/example/dao/SysConfigDao.java
src/main/java/example/dao/StoreDao.java
src/main/java/example/dao/FilmDao.java
src/main/java/example/dao/FilmActorDao.java
src/main/java/example/dao/CategoryDao.java
src/main/java/example/dao/InventoryDao.java
src/main/java/example/dao/FilmTextDao.java
src/main/java/example/dao/ActorDao.java
src/main/java/example/dao/AddressDao.java
src/main/java/example/dao/PaymentDao.java
src/main/java/example/dao/FilmCategoryDao.java
src/main/java/example/dao/StaffDao.java
src/main/java/example/dao/RentalDao.java
```

テーブル単位で確認

```
$find src -name "*" -type f | grep Rental
src/main/resources/META-INF/example/dao/RentalDao/selectById.sql
src/main/java/example/entity/RentalListener.java
src/main/java/example/entity/Rental.java
src/main/java/example/dao/RentalDao.java
```

主キー検索sql

```
$cat src/main/resources/META-INF/example/dao/RentalDao/selectById.sql
select
  /*%expand*/*
from
  rental
where
  rental_id = /* rentalId */1
```

リスナークラス
```
$cat src/main/java/example/entity/RentalListener.java
package example.entity;

import org.seasar.doma.jdbc.entity.EntityListener;
import org.seasar.doma.jdbc.entity.PostDeleteContext;
import org.seasar.doma.jdbc.entity.PostInsertContext;
import org.seasar.doma.jdbc.entity.PostUpdateContext;
import org.seasar.doma.jdbc.entity.PreDeleteContext;
import org.seasar.doma.jdbc.entity.PreInsertContext;
import org.seasar.doma.jdbc.entity.PreUpdateContext;

/**
 *
 */
public class RentalListener implements EntityListener<Rental> {

    @Override
    public void preInsert(Rental entity, PreInsertContext<Rental> context) {
    }

    @Override
    public void preUpdate(Rental entity, PreUpdateContext<Rental> context) {
    }

    @Override
    public void preDelete(Rental entity, PreDeleteContext<Rental> context) {
    }

    @Override
    public void postInsert(Rental entity, PostInsertContext<Rental> context) {
    }

    @Override
    public void postUpdate(Rental entity, PostUpdateContext<Rental> context) {
    }

    @Override
    public void postDelete(Rental entity, PostDeleteContext<Rental> context) {
    }
}
```

ピュアクラス
```
$cat src/main/java/example/entity/Rental.java
package example.entity;

import java.time.LocalDateTime;
import org.seasar.doma.Column;
import org.seasar.doma.Entity;
import org.seasar.doma.GeneratedValue;
import org.seasar.doma.GenerationType;
import org.seasar.doma.Id;
import org.seasar.doma.Table;

/**
 *
 */
@Entity(listener = RentalListener.class)
@Table(name = "rental")
public class Rental {

    /**  */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "rental_id")
    Integer rentalId;

    /**  */
    @Column(name = "rental_date")
    LocalDateTime rentalDate;

    /**  */
    @Column(name = "inventory_id")
    Integer inventoryId;

    /**  */
    @Column(name = "customer_id")
    Integer customerId;

    /**  */
    @Column(name = "return_date")
    LocalDateTime returnDate;

    /**  */
    @Column(name = "staff_id")
    Short staffId;

    /**  */
    @Column(name = "last_update")
    LocalDateTime lastUpdate;

    /**
     * Returns the rentalId.
     *
     * @return the rentalId
     */
    public Integer getRentalId() {
        return rentalId;
    }

    /**
     * Sets the rentalId.
     *
     * @param rentalId the rentalId
     */
    public void setRentalId(Integer rentalId) {
        this.rentalId = rentalId;
    }

    /**
     * Returns the rentalDate.
     *
     * @return the rentalDate
     */
    public LocalDateTime getRentalDate() {
        return rentalDate;
    }

    /**
     * Sets the rentalDate.
     *
     * @param rentalDate the rentalDate
     */
    public void setRentalDate(LocalDateTime rentalDate) {
        this.rentalDate = rentalDate;
    }

    /**
     * Returns the inventoryId.
     *
     * @return the inventoryId
     */
    public Integer getInventoryId() {
        return inventoryId;
    }

    /**
     * Sets the inventoryId.
     *
     * @param inventoryId the inventoryId
     */
    public void setInventoryId(Integer inventoryId) {
        this.inventoryId = inventoryId;
    }

    /**
     * Returns the customerId.
     *
     * @return the customerId
     */
    public Integer getCustomerId() {
        return customerId;
    }

    /**
     * Sets the customerId.
     *
     * @param customerId the customerId
     */
    public void setCustomerId(Integer customerId) {
        this.customerId = customerId;
    }

    /**
     * Returns the returnDate.
     *
     * @return the returnDate
     */
    public LocalDateTime getReturnDate() {
        return returnDate;
    }

    /**
     * Sets the returnDate.
     *
     * @param returnDate the returnDate
     */
    public void setReturnDate(LocalDateTime returnDate) {
        this.returnDate = returnDate;
    }

    /**
     * Returns the staffId.
     *
     * @return the staffId
     */
    public Short getStaffId() {
        return staffId;
    }

    /**
     * Sets the staffId.
     *
     * @param staffId the staffId
     */
    public void setStaffId(Short staffId) {
        this.staffId = staffId;
    }

    /**
     * Returns the lastUpdate.
     *
     * @return the lastUpdate
     */
    public LocalDateTime getLastUpdate() {
        return lastUpdate;
    }

    /**
     * Sets the lastUpdate.
     *
     * @param lastUpdate the lastUpdate
     */
    public void setLastUpdate(LocalDateTime lastUpdate) {
        this.lastUpdate = lastUpdate;
    }
}
```
Daoクラス
```
$cat src/main/java/example/dao/RentalDao.java
package example.dao;

import example.entity.Rental;
import org.seasar.doma.Dao;
import org.seasar.doma.Delete;
import org.seasar.doma.Insert;
import org.seasar.doma.Select;
import org.seasar.doma.Update;

/**
 */
@Dao
public interface RentalDao {

    /**
     * @param rentalId
     * @return the Rental entity
     */
    @Select
    Rental selectById(Integer rentalId);

    /**
     * @param entity
     * @return affected rows
     */
    @Insert
    int insert(Rental entity);

    /**
     * @param entity
     * @return affected rows
     */
    @Update
    int update(Rental entity);

    /**
     * @param entity
     * @return affected rows
     */
    @Delete
    int delete(Rental entity);
}
```
