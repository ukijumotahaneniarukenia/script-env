```
DROP TABLE IF EXISTS tweet_mroonga;
CREATE TABLE tweet_mroonga (
  seq bigint(20) UNSIGNED NOT NULL PRIMARY KEY,
  txt text NOT NULL,
  FULLTEXT INDEX (txt)
) ENGINE=mroonga DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS tweet_InnoDB;
CREATE TABLE tweet_InnoDB (
  seq bigint(20) UNSIGNED NOT NULL PRIMARY KEY,
  txt text NOT NULL,
  FULLTEXT INDEX (txt)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

```
for i in {0..3};do bash -c "echo {{a..z},{A..Z},{0..9}}"|tr ' ' \\n|shuf -rn$(seq 10 30 | shuf -rn1) |tr -d \\n;echo;done | awk 'BEGIN{print "insert into tweet_mroonga(seq,txt)values"}{if(NR==1){print "(",NR",\x27"$1"\x27)"}else{print ",(",NR",\x27"$1"\x27)"}}END{print ";commit;"}'>insert_100000.sql
```

```
for i in {0..1000};do bash -c "echo {{a..z},{A..Z},{0..9}}"|tr ' ' \\n|shuf -rn$(seq 10 30 | shuf -rn1) |tr -d \\n;echo;done | awk 'BEGIN{print "insert into tweet_mroonga(seq,txt)values"}{if(NR==1){print "(",NR",\x27"$1"\x27)"}else{print ",(",NR",\x27"$1"\x27)"}}END{print ";commit;"}' | mysql -uroot -pMysql3306 -Dtestdb
```


```
for i in {0..10};do bash -c "echo -e '\U304'{0..9} | tr -d ' ' | grep -o . | sed 's;぀;;;/^$/d' | shuf -rn$(seq 10 30 | shuf -rn1)" |tr -d \\n;echo;done| awk 'BEGIN{print "insert into tweet_mroonga(seq,txt)values"}{if(NR==1){print "(",NR",\x27"$1"\x27)"}else{print ",(",NR",\x27"$1"\x27)"}}END{print ";commit;"}'
```
