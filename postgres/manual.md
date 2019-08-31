# Dockerfileよりイメージ作成
```
time docker build -t centos_postgres . | tee log
```

# dockerコンテナ削除
```
docker ps -qa | xargs -I@ bash -c 'docker stop @ && docker rm @'
```

# dockerイメージ削除
```
docker images | awk '$1=="<none>"{print $3}' | xargs -I@ docker rmi @
docker images | awk '$1 ~ "centos_"{print $3}' | xargs -I@ bash -c 'docker rmi @
```

# dockerコンテナ起動
```
docker run --privileged -v /etc/localtime:/etc/localtime  --name postgres -p 5432:5432 -itd centos_postgres /sbin/init
```

# dockerコンテナ潜入
```
docker exec --user postgres -it postgres /bin/bash
docker exec --user root -it postgres /bin/bash
```

# データベース単位での実行操作ログをバックグラウンドで回収
```
postgres -D /usr/local/pgsql/data >~/logfile 2>&1 &
```

# サンプルデータベースのリストア
tarファイルある場所でリストア
```
cd ~ && psql -U postgres -c "create database dvdrental"
cd ~ && pg_restore -U postgres -d dvdrental dvdrental.tar
```

# サンプルデータベース接続

```
[postgres@f3e84ba710ac ~]$postgres -D /usr/local/pgsql/data >~/logfile 2>&1 &
[1] 2767
[postgres@f3e84ba710ac ~]$psql -U postgres -c "create database dvdrental"
CREATE DATABASE
[postgres@f3e84ba710ac ~]$pg_restore -U postgres -d dvdrental dvdrental.tar
[postgres@f3e84ba710ac ~]$psql -l
                             List of databases
   Name    |  Owner   | Encoding  | Collate | Ctype |   Access privileges   
-----------+----------+-----------+---------+-------+-----------------------
 dvdrental | postgres | SQL_ASCII | C       | C     | 
 postgres  | postgres | SQL_ASCII | C       | C     | 
 template0 | postgres | SQL_ASCII | C       | C     | =c/postgres          +
           |          |           |         |       | postgres=CTc/postgres
 template1 | postgres | SQL_ASCII | C       | C     | =c/postgres          +
           |          |           |         |       | postgres=CTc/postgres
(4 rows)

[postgres@f3e84ba710ac ~]$psql -U postgres -d dvdrental
psql (11.5)
Type "help" for help.

dvdrental=# \dt
             List of relations
 Schema |     Name      | Type  |  Owner   
--------+---------------+-------+----------
 public | actor         | table | postgres
 public | address       | table | postgres
 public | category      | table | postgres
 public | city          | table | postgres
 public | country       | table | postgres
 public | customer      | table | postgres
 public | film          | table | postgres
 public | film_actor    | table | postgres
 public | film_category | table | postgres
 public | inventory     | table | postgres
 public | language      | table | postgres
 public | payment       | table | postgres
 public | rental        | table | postgres
 public | staff         | table | postgres
 public | store         | table | postgres
(15 rows)

dvdrental=# select * from actor;
 actor_id | first_name  |  last_name   |      last_update       
----------+-------------+--------------+------------------------
        1 | Penelope    | Guiness      | 2013-05-26 14:47:57.62
        2 | Nick        | Wahlberg     | 2013-05-26 14:47:57.62
        3 | Ed          | Chase        | 2013-05-26 14:47:57.62
        4 | Jennifer    | Davis        | 2013-05-26 14:47:57.62
        5 | Johnny      | Lollobrigida | 2013-05-26 14:47:57.62
        6 | Bette       | Nicholson    | 2013-05-26 14:47:57.62
        7 | Grace       | Mostel       | 2013-05-26 14:47:57.62
        8 | Matthew     | Johansson    | 2013-05-26 14:47:57.62
        9 | Joe         | Swank        | 2013-05-26 14:47:57.62
       10 | Christian   | Gable        | 2013-05-26 14:47:57.62
       11 | Zero        | Cage         | 2013-05-26 14:47:57.62
       12 | Karl        | Berry        | 2013-05-26 14:47:57.62
       13 | Uma         | Wood         | 2013-05-26 14:47:57.62
       14 | Vivien      | Bergen       | 2013-05-26 14:47:57.62
       15 | Cuba        | Olivier      | 2013-05-26 14:47:57.62
       16 | Fred        | Costner      | 2013-05-26 14:47:57.62
       17 | Helen       | Voight       | 2013-05-26 14:47:57.62
       18 | Dan         | Torn         | 2013-05-26 14:47:57.62
       19 | Bob         | Fawcett      | 2013-05-26 14:47:57.62
       20 | Lucille     | Tracy        | 2013-05-26 14:47:57.62
       21 | Kirsten     | Paltrow      | 2013-05-26 14:47:57.62
       22 | Elvis       | Marx         | 2013-05-26 14:47:57.62
       23 | Sandra      | Kilmer       | 2013-05-26 14:47:57.62
       24 | Cameron     | Streep       | 2013-05-26 14:47:57.62
       25 | Kevin       | Bloom        | 2013-05-26 14:47:57.62
       26 | Rip         | Crawford     | 2013-05-26 14:47:57.62
       27 | Julia       | Mcqueen      | 2013-05-26 14:47:57.62
       28 | Woody       | Hoffman      | 2013-05-26 14:47:57.62
       29 | Alec        | Wayne        | 2013-05-26 14:47:57.62
       30 | Sandra      | Peck         | 2013-05-26 14:47:57.62
       31 | Sissy       | Sobieski     | 2013-05-26 14:47:57.62
       32 | Tim         | Hackman      | 2013-05-26 14:47:57.62
       33 | Milla       | Peck         | 2013-05-26 14:47:57.62
       34 | Audrey      | Olivier      | 2013-05-26 14:47:57.62
       35 | Judy        | Dean         | 2013-05-26 14:47:57.62
       36 | Burt        | Dukakis      | 2013-05-26 14:47:57.62
       37 | Val         | Bolger       | 2013-05-26 14:47:57.62
       38 | Tom         | Mckellen     | 2013-05-26 14:47:57.62
       39 | Goldie      | Brody        | 2013-05-26 14:47:57.62
       40 | Johnny      | Cage         | 2013-05-26 14:47:57.62
       41 | Jodie       | Degeneres    | 2013-05-26 14:47:57.62
       42 | Tom         | Miranda      | 2013-05-26 14:47:57.62
       43 | Kirk        | Jovovich     | 2013-05-26 14:47:57.62
       44 | Nick        | Stallone     | 2013-05-26 14:47:57.62
       45 | Reese       | Kilmer       | 2013-05-26 14:47:57.62
       46 | Parker      | Goldberg     | 2013-05-26 14:47:57.62
       47 | Julia       | Barrymore    | 2013-05-26 14:47:57.62
dvdrental=# \q
[postgres@f3e84ba710ac ~]$exit
```
