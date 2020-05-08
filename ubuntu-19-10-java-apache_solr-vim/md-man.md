```
https://lucene.apache.org/solr/guide/8_4/solr-tutorial.html#solr-tutorial

コア作成（データベース作成みたいなもん）

solr docker-container-ubuntu-19-10-java-apache-solr-vim /usr/local/src/solr-8.5.1$bin/solr start -e techproducts


Creating Solr home directory /usr/local/src/solr-8.5.1/example/techproducts/solr

Starting up Solr on port 8983 using command:
"bin/solr" start -p 8983 -s "example/techproducts/solr"

Waiting up to 180 seconds to see Solr running on port 8983 [/]
Started Solr server on port 8983 (pid=229). Happy searching!


Created new core 'techproducts'
Indexing tech product example docs from /usr/local/src/solr-8.5.1/example/exampledocs
SimplePostTool version 5.0.0
Posting files to [base] url http://localhost:8983/solr/techproducts/update using content-type application/xml...
POSTing file hd.xml to [base]
POSTing file solr.xml to [base]
POSTing file gb18030-example.xml to [base]
POSTing file ipod_other.xml to [base]
POSTing file ipod_video.xml to [base]
POSTing file mem.xml to [base]
POSTing file monitor2.xml to [base]
POSTing file vidcard.xml to [base]
POSTing file money.xml to [base]
POSTing file monitor.xml to [base]
POSTing file utf8-example.xml to [base]
POSTing file mp500.xml to [base]
POSTing file sd500.xml to [base]
POSTing file manufacturers.xml to [base]
14 files indexed.
COMMITting Solr index changes to http://localhost:8983/solr/techproducts/update...
Time spent: 0:00:00.373

Solr techproducts example launched successfully. Direct your Web browser to http://localhost:8983/solr to visit the Solr Admin UI


以下のURLにブラウザからアクセス

http://localhost:8983/solr


梱包されているサンプルデータも投入してみる


solr docker-container-ubuntu-19-10-java-apache-solr-vim /usr/local/src/solr-8.5.1$ll example/exampledocs/*
-rw-r--r--. 1 solr solr   959  4月  8 14:02 example/exampledocs/books.csv
-rw-r--r--. 1 solr solr  1148  4月  8 14:02 example/exampledocs/books.json
-rw-r--r--. 1 solr solr  1333  4月  8 14:02 example/exampledocs/gb18030-example.xml
-rw-r--r--. 1 solr solr  2245  4月  8 14:02 example/exampledocs/hd.xml
-rw-r--r--. 1 solr solr  2074  4月  8 14:02 example/exampledocs/ipod_other.xml
-rw-r--r--. 1 solr solr  2109  4月  8 14:02 example/exampledocs/ipod_video.xml
-rw-r--r--. 1 solr solr  2801  4月  8 14:02 example/exampledocs/manufacturers.xml
-rw-r--r--. 1 solr solr  3090  4月  8 14:02 example/exampledocs/mem.xml
-rw-r--r--. 1 solr solr  2156  4月  8 14:02 example/exampledocs/money.xml
-rw-r--r--. 1 solr solr  1420  4月  8 14:02 example/exampledocs/monitor.xml
-rw-r--r--. 1 solr solr  1402  4月  8 14:02 example/exampledocs/monitor2.xml
-rw-r--r--. 1 solr solr   178  4月  8 14:02 example/exampledocs/more_books.jsonl
-rw-r--r--. 1 solr solr  1976  4月  8 14:02 example/exampledocs/mp500.xml
-rw-r--r--. 1 solr solr 27478  4月  8 16:01 example/exampledocs/post.jar
-rw-r--r--. 1 solr solr   235  4月  8 14:02 example/exampledocs/sample.html
-rw-r--r--. 1 solr solr  1684  4月  8 14:02 example/exampledocs/sd500.xml
-rw-r--r--. 1 solr solr 21052  4月  8 14:02 example/exampledocs/solr-word.pdf
-rw-r--r--. 1 solr solr  1810  4月  8 14:02 example/exampledocs/solr.xml
-rwxr-xr-x. 1 solr solr  3742  4月  8 14:02 example/exampledocs/test_utf8.sh*
-rw-r--r--. 1 solr solr  1835  4月  8 14:02 example/exampledocs/utf8-example.xml
-rw-r--r--. 1 solr solr  2697  4月  8 14:02 example/exampledocs/vidcard.xml

solr docker-container-ubuntu-19-10-java-apache-solr-vim /usr/local/src/solr-8.5.1$bin/post -c techproducts example/exampledocs/*
/usr/local/src/jdk-11/bin/java -classpath /usr/local/src/solr-8.5.1/dist/solr-core-8.5.1.jar -Dauto=yes -Dc=techproducts -Ddata=files org.apache.solr.util.SimplePostTool example/exampledocs/books.csv example/exampledocs/books.json example/exampledocs/gb18030-example.xml example/exampledocs/hd.xml example/exampledocs/ipod_other.xml example/exampledocs/ipod_video.xml example/exampledocs/manufacturers.xml example/exampledocs/mem.xml example/exampledocs/money.xml example/exampledocs/monitor.xml example/exampledocs/monitor2.xml example/exampledocs/more_books.jsonl example/exampledocs/mp500.xml example/exampledocs/post.jar example/exampledocs/sample.html example/exampledocs/sd500.xml example/exampledocs/solr-word.pdf example/exampledocs/solr.xml example/exampledocs/test_utf8.sh example/exampledocs/utf8-example.xml example/exampledocs/vidcard.xml
SimplePostTool version 5.0.0
Posting files to [base] url http://localhost:8983/solr/techproducts/update...
Entering auto mode. File endings considered are xml,json,jsonl,csv,pdf,doc,docx,ppt,pptx,xls,xlsx,odt,odp,ods,ott,otp,ots,rtf,htm,html,txt,log
POSTing file books.csv (text/csv) to [base]
POSTing file books.json (application/json) to [base]/json/docs
POSTing file gb18030-example.xml (application/xml) to [base]
POSTing file hd.xml (application/xml) to [base]
POSTing file ipod_other.xml (application/xml) to [base]
POSTing file ipod_video.xml (application/xml) to [base]
POSTing file manufacturers.xml (application/xml) to [base]
POSTing file mem.xml (application/xml) to [base]
POSTing file money.xml (application/xml) to [base]
POSTing file monitor.xml (application/xml) to [base]
POSTing file monitor2.xml (application/xml) to [base]
POSTing file more_books.jsonl (application/json) to [base]/json/docs
POSTing file mp500.xml (application/xml) to [base]
POSTing file post.jar (application/octet-stream) to [base]/extract
POSTing file sample.html (text/html) to [base]/extract
POSTing file sd500.xml (application/xml) to [base]
POSTing file solr-word.pdf (application/pdf) to [base]/extract
POSTing file solr.xml (application/xml) to [base]
POSTing file test_utf8.sh (application/octet-stream) to [base]/extract
POSTing file utf8-example.xml (application/xml) to [base]
POSTing file vidcard.xml (application/xml) to [base]
21 files indexed.
COMMITting Solr index changes to http://localhost:8983/solr/techproducts/update...
Time spent: 0:00:01.095

これで検索できる準備ができるようになったそう



- 検索条件 未指定 先頭から3件

solr docker-container-ubuntu-19-10-java-apache-solr-vim /usr/local/src/solr-8.5.1$curl -s 'http://localhost:8983/solr/techproducts/select?q=*%3A*&rows=3&start=0' | jq --stream -c
[["responseHeader","status"],0]
[["responseHeader","QTime"],0]
[["responseHeader","params","q"],"*:*"]
[["responseHeader","params","start"],"0"]
[["responseHeader","params","rows"],"3"]
[["responseHeader","params","rows"]]
[["responseHeader","params"]]
[["response","numFound"],52]
[["response","start"],0]
[["response","docs",0,"id"],"0553573403"]
[["response","docs",0,"cat",0],"book"]
[["response","docs",0,"cat",0]]
[["response","docs",0,"name"],"A Game of Thrones"]
[["response","docs",0,"price"],7.99]
[["response","docs",0,"price_c"],"7.99,USD"]
[["response","docs",0,"inStock"],true]
[["response","docs",0,"author"],"George R.R. Martin"]
[["response","docs",0,"author_s"],"George R.R. Martin"]
[["response","docs",0,"series_t"],"A Song of Ice and Fire"]
[["response","docs",0,"sequence_i"],1]
[["response","docs",0,"genre_s"],"fantasy"]
[["response","docs",0,"_version_"],1665866796928860200]
[["response","docs",0,"price_c____l_ns"],799]
[["response","docs",0,"price_c____l_ns"]]
[["response","docs",1,"id"],"0553579908"]
[["response","docs",1,"cat",0],"book"]
[["response","docs",1,"cat",0]]
[["response","docs",1,"name"],"A Clash of Kings"]
[["response","docs",1,"price"],7.99]
[["response","docs",1,"price_c"],"7.99,USD"]
[["response","docs",1,"inStock"],true]
[["response","docs",1,"author"],"George R.R. Martin"]
[["response","docs",1,"author_s"],"George R.R. Martin"]
[["response","docs",1,"series_t"],"A Song of Ice and Fire"]
[["response","docs",1,"sequence_i"],2]
[["response","docs",1,"genre_s"],"fantasy"]
[["response","docs",1,"_version_"],1665866796930957300]
[["response","docs",1,"price_c____l_ns"],799]
[["response","docs",1,"price_c____l_ns"]]
[["response","docs",2,"id"],"055357342X"]
[["response","docs",2,"cat",0],"book"]
[["response","docs",2,"cat",0]]
[["response","docs",2,"name"],"A Storm of Swords"]
[["response","docs",2,"price"],7.99]
[["response","docs",2,"price_c"],"7.99,USD"]
[["response","docs",2,"inStock"],true]
[["response","docs",2,"author"],"George R.R. Martin"]
[["response","docs",2,"author_s"],"George R.R. Martin"]
[["response","docs",2,"series_t"],"A Song of Ice and Fire"]
[["response","docs",2,"sequence_i"],3]
[["response","docs",2,"genre_s"],"fantasy"]
[["response","docs",2,"_version_"],1665866796932006000]
[["response","docs",2,"price_c____l_ns"],799]
[["response","docs",2,"price_c____l_ns"]]
[["response","docs",2]]
[["response","docs"]]
[["response"]]



- 検索条件 未指定 4件目から3件

solr docker-container-ubuntu-19-10-java-apache-solr-vim /usr/local/src/solr-8.5.1$curl -s 'http://localhost:8983/solr/techproducts/select?q=*%3A*&rows=3&start=3' | jq --stream -c
[["responseHeader","status"],0]
[["responseHeader","QTime"],0]
[["responseHeader","params","q"],"*:*"]
[["responseHeader","params","start"],"3"]
[["responseHeader","params","rows"],"3"]
[["responseHeader","params","rows"]]
[["responseHeader","params"]]
[["response","numFound"],52]
[["response","start"],3]
[["response","docs",0,"id"],"0553293354"]
[["response","docs",0,"cat",0],"book"]
[["response","docs",0,"cat",0]]
[["response","docs",0,"name"],"Foundation"]
[["response","docs",0,"price"],7.99]
[["response","docs",0,"price_c"],"7.99,USD"]
[["response","docs",0,"inStock"],true]
[["response","docs",0,"author"],"Isaac Asimov"]
[["response","docs",0,"author_s"],"Isaac Asimov"]
[["response","docs",0,"series_t"],"Foundation Novels"]
[["response","docs",0,"sequence_i"],1]
[["response","docs",0,"genre_s"],"scifi"]
[["response","docs",0,"_version_"],1665866796932006000]
[["response","docs",0,"price_c____l_ns"],799]
[["response","docs",0,"price_c____l_ns"]]
[["response","docs",1,"id"],"0812521390"]
[["response","docs",1,"cat",0],"book"]
[["response","docs",1,"cat",0]]
[["response","docs",1,"name"],"The Black Company"]
[["response","docs",1,"price"],6.99]
[["response","docs",1,"price_c"],"6.99,USD"]
[["response","docs",1,"inStock"],false]
[["response","docs",1,"author"],"Glen Cook"]
[["response","docs",1,"author_s"],"Glen Cook"]
[["response","docs",1,"series_t"],"The Chronicles of The Black Company"]
[["response","docs",1,"sequence_i"],1]
[["response","docs",1,"genre_s"],"fantasy"]
[["response","docs",1,"_version_"],1665866796933054500]
[["response","docs",1,"price_c____l_ns"],699]
[["response","docs",1,"price_c____l_ns"]]
[["response","docs",2,"id"],"0812550706"]
[["response","docs",2,"cat",0],"book"]
[["response","docs",2,"cat",0]]
[["response","docs",2,"name"],"Ender's Game"]
[["response","docs",2,"price"],6.99]
[["response","docs",2,"price_c"],"6.99,USD"]
[["response","docs",2,"inStock"],true]
[["response","docs",2,"author"],"Orson Scott Card"]
[["response","docs",2,"author_s"],"Orson Scott Card"]
[["response","docs",2,"series_t"],"Ender"]
[["response","docs",2,"sequence_i"],1]
[["response","docs",2,"genre_s"],"scifi"]
[["response","docs",2,"_version_"],1665866796933054500]
[["response","docs",2,"price_c____l_ns"],699]
[["response","docs",2,"price_c____l_ns"]]
[["response","docs",2]]
[["response","docs"]]
[["response"]]


- 検索条件 未指定 検索最終件目から3件

solr docker-container-ubuntu-19-10-java-apache-solr-vim /usr/local/src/solr-8.5.1$curl -s 'http://localhost:8983/solr/techproducts/select?q=*%3A*&rows=3&start=51' | jq --stream -c
[["responseHeader","status"],0]
[["responseHeader","QTime"],0]
[["responseHeader","params","q"],"*:*"]
[["responseHeader","params","start"],"51"]
[["responseHeader","params","rows"],"3"]
[["responseHeader","params","rows"]]
[["responseHeader","params"]]
[["response","numFound"],52]
[["response","start"],51]
[["response","docs",0,"id"],"100-435805"]
[["response","docs",0,"name"],"ATI Radeon X1900 XTX 512 MB PCIE Video Card"]
[["response","docs",0,"manu"],"ATI Technologies"]
[["response","docs",0,"manu_id_s"],"ati"]
[["response","docs",0,"cat",0],"electronics"]
[["response","docs",0,"cat",1],"graphics card"]
[["response","docs",0,"cat",1]]
[["response","docs",0,"features",0],"ATI RADEON X1900 GPU/VPU clocked at 650MHz"]
[["response","docs",0,"features",1],"512MB GDDR3 SDRAM clocked at 1.55GHz"]
[["response","docs",0,"features",2],"PCI Express x16"]
[["response","docs",0,"features",3],"dual DVI, HDTV, svideo, composite out"]
[["response","docs",0,"features",4],"OpenGL 2.0, DirectX 9.0"]
[["response","docs",0,"features",4]]
[["response","docs",0,"weight"],48]
[["response","docs",0,"price"],649.99]
[["response","docs",0,"price_c"],"649.99,USD"]
[["response","docs",0,"popularity"],7]
[["response","docs",0,"inStock"],false]
[["response","docs",0,"manufacturedate_dt"],"2006-02-13T00:00:00Z"]
[["response","docs",0,"store"],"40.7143,-74.006"]
[["response","docs",0,"_version_"],1665866797934444500]
[["response","docs",0,"price_c____l_ns"],64999]
[["response","docs",0,"price_c____l_ns"]]
[["response","docs",0]]
[["response","docs"]]
[["response"]]

- 検索条件 検索単語 foundation 取得列を問わない

solr docker-container-ubuntu-19-10-java-apache-solr-vim /usr/local/src/solr-8.5.1$curl -s http://localhost:8983/solr/techproducts/select?q=foundation | jq --stream -c



- 検索条件 検索単語 foundation 取得列 id


http://localhost:8983/solr/techproducts/select?fl=id&q=foundation


solr docker-container-ubuntu-19-10-java-apache-solr-vim /usr/local/src/solr-8.5.1$curl -s 'http://localhost:8983/solr/techproducts/select?fl=id&q=foundation' | jq --stream -c
[["responseHeader","status"],0]
[["responseHeader","QTime"],0]
[["responseHeader","params","q"],"foundation"]
[["responseHeader","params","fl"],"id"]
[["responseHeader","params","fl"]]
[["responseHeader","params"]]
[["response","numFound"],4]
[["response","start"],0]
[["response","docs",0,"id"],"0553293354"]
[["response","docs",0,"id"]]
[["response","docs",1,"id"],"UTF8TEST"]
[["response","docs",1,"id"]]
[["response","docs",2,"id"],"SOLR1000"]
[["response","docs",2,"id"]]
[["response","docs",3,"id"],"/usr/local/src/solr-8.5.1/example/exampledocs/test_utf8.sh"]
[["response","docs",3,"id"]]
[["response","docs",3]]
[["response","docs"]]
[["response"]]


- 検索条件 取得列catの値がelectronicsである要素を取得

取得列:検索キーワード

solr docker-container-ubuntu-19-10-java-apache-solr-vim /usr/local/src/solr-8.5.1$curl -s 'http://localhost:8983/solr/techproducts/select?q=cat%3Aelectronics' | jq --stream -c



- 検索条件 複数単語を一語として扱って検索

ある単語+ある単語

solr docker-container-ubuntu-19-10-java-apache-solr-vim /usr/local/src/solr-8.5.1$curl -s 'http://localhost:8983/solr/techproducts/select?q=CAS%2Blatency' | jq --stream -c



- 検索条件 ある単語は含むがある単語は含まない


+electronics -music

solr docker-container-ubuntu-19-10-java-apache-solr-vim /usr/local/src/solr-8.5.1$curl -s 'http://localhost:8983/solr/techproducts/select?q=%2Belectronics%20-music' | jq --stream -c
solr docker-container-ubuntu-19-10-java-apache-solr-vim /usr/local/src/solr-8.5.1$curl -s 'http://localhost:8983/solr/techproducts/select?q=%2Belectronics' | jq --stream -c

検索の詳細なやり方については以下

https://lucene.apache.org/solr/guide/8_4/searching.html#searching


コアの削除


bin/solr delete -c techproducts


solr docker-container-ubuntu-19-10-java-apache-solr-vim /usr/local/src/solr-8.5.1$bin/solr delete -c techproducts

Deleting core 'techproducts' using command:
http://localhost:8983/solr/admin/cores?action=UNLOAD&core=techproducts&deleteIndex=true&deleteDataDir=true&deleteInstanceDir=true

solr docker-container-ubuntu-19-10-java-apache-solr-vim /usr/local/src/solr-8.5.1$curl -s 'http://localhost:8983/solr/techproducts/select?q=%2Belectronics'
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<title>Error 404 Not Found</title>
</head>
<body><h2>HTTP ERROR 404 Not Found</h2>
<table>
<tr><th>URI:</th><td>/solr/techproducts/select</td></tr>
<tr><th>STATUS:</th><td>404</td></tr>
<tr><th>MESSAGE:</th><td>Not Found</td></tr>
<tr><th>SERVLET:</th><td>default</td></tr>
</table>

</body>
</html>

--ここから新規での手番


solrプロセスの起動

bin/solr start

コアの作成（レプリカ数を指定）

bin/solr create -c <yourCollection> -s 2 -rf 2


bin/solr create -c films -s 2 -rf 2


solr docker-container-ubuntu-19-10-java-apache-solr-vim /usr/local/src/solr-8.5.1$bin/solr create -c films -s 2 -rf 2
WARNING: Using _default configset with data driven schema functionality. NOT RECOMMENDED for production use.
         To turn off: bin/solr config -c films -p 8983 -action set-user-property -property update.autoCreateFields -value false

Created new core 'films'

solr docker-container-ubuntu-19-10-java-apache-solr-vim /usr/local/src/solr-8.5.1$find / -name "films" 2>/dev/null
/usr/local/src/solr-8.5.1/example/films
/usr/local/src/solr-8.5.1/example/techproducts/solr/films


solr docker-container-ubuntu-19-10-java-apache-solr-vim /usr/local/src/solr-8.5.1$ll /usr/local/src/solr-8.5.1/example/films
total 896
drwxr-xr-x. 2 solr solr   4096  5月  5 18:05 ./
drwxr-xr-x. 1 solr solr   4096  5月  6 00:40 ../
-rw-r--r--. 1 solr solr   4986  4月  8 14:02 README.txt
-rw-r--r--. 1 solr solr   3829  4月  8 14:02 film_data_generator.py
-rw-r--r--. 1 solr solr    299  4月  8 14:02 films-LICENSE.txt
-rw-r--r--. 1 solr solr 124581  4月  8 14:02 films.csv
-rw-r--r--. 1 solr solr 300955  4月  8 14:02 films.json
-rw-r--r--. 1 solr solr 455444  4月  8 14:02 films.xml
solr docker-container-ubuntu-19-10-java-apache-solr-vim /usr/local/src/solr-8.5.1$ll /usr/local/src/solr-8.5.1/example/techproducts/solr/films
total 20
drwxr-xr-x. 4 solr solr 4096  5月  6 01:33 ./
drwxr-xr-x. 5 solr solr 4096  5月  6 01:33 ../
drwxr-xr-x. 3 solr solr 4096  5月  5 18:05 conf/
-rw-r--r--. 1 solr solr   75  5月  6 01:33 core.properties
drwxr-xr-x. 5 solr solr 4096  5月  6 01:33 data/


solr docker-container-ubuntu-19-10-java-apache-solr-vim /usr/local/src/solr-8.5.1$cat /usr/local/src/solr-8.5.1/example/films/films.json | jq --stream -c '' | head
[[0,"id"],"/en/45_2006"]
[[0,"directed_by",0],"Gary Lennon"]
[[0,"directed_by",0]]
[[0,"initial_release_date"],"2006-11-30"]
[[0,"genre",0],"Black comedy"]
[[0,"genre",1],"Thriller"]
[[0,"genre",2],"Psychological thriller"]
[[0,"genre",3],"Indie film"]
[[0,"genre",4],"Action Film"]
[[0,"genre",5],"Crime Thriller"]
solr docker-container-ubuntu-19-10-java-apache-solr-vim /usr/local/src/solr-8.5.1$cat /usr/local/src/solr-8.5.1/example/films/films.json | jq --stream -c '' | tail
[[1099,"genre",1],"Mystery"]
[[1099,"genre",2],"Adventure Film"]
[[1099,"genre",3],"Fantasy"]
[[1099,"genre",4],"Fantasy Adventure"]
[[1099,"genre",5],"Fiction"]
[[1099,"genre",5]]
[[1099,"directed_by",0],"David Yates"]
[[1099,"directed_by",0]]
[[1099,"directed_by"]]
[[1099]]



solr docker-container-ubuntu-19-10-java-apache-solr-vim /usr/local/src/solr-8.5.1$cat /usr/local/src/solr-8.5.1/example/films/films.csv | head
name,directed_by,genre,type,id,initial_release_date
.45,Gary Lennon,Black comedy|Thriller|Psychological thriller|Indie film|Action Film|Crime Thriller|Crime Fiction|Drama,,/en/45_2006,2006-11-30
9,Shane Acker,Computer Animation|Animation|Apocalyptic and post-apocalyptic fiction|Science Fiction|Short Film|Thriller|Fantasy,,/en/9_2005,2005-04-21
69,Lee Sang-il,Japanese Movies|Drama,,/en/69_2004,2004-07-10
300,Zack Snyder,Epic film|Adventure Film|Fantasy|Action Film|Historical fiction|War film|Superhero movie|Historical Epic,,/en/300_2007,2006-12-09
2046,Wong Kar-wai,Romance Film|Fantasy|Science Fiction|Drama,,/en/2046_2004,2004-05-20
¿Quién es el señor López?,Luis Mandoki,Documentary film,,/en/quien_es_el_senor_lopez,
"""Weird Al"" Yankovic: The Ultimate Video Collection","Jay Levey|""Weird Al"" Yankovic",Music video|Parody,,/en/weird_al_yankovic_the_ultimate_video_collection,2003-11-04
15 Park Avenue,Aparna Sen,Art film|Romance Film|Musical|Drama|Musical Drama,,/en/15_park_avenue,2005-10-27
2 Fast 2 Furious,John Singleton,Thriller|Action Film|Crime Fiction,,/en/2_fast_2_furious,2003-06-03



solr docker-container-ubuntu-19-10-java-apache-solr-vim /usr/local/src/solr-8.5.1$cat /usr/local/src/solr-8.5.1/example/films/films.csv | tail
I Love New Year,Radhika Rao|Vinay Sapru,Caper story|Crime Fiction|Romantic comedy|Romance Film|Bollywood|World cinema,,/wikipedia/en_title/I_Love_New_Year,2013-12-30
Har Dil Jo Pyar Karega,Raj Kanwar,Musical|Romance Film|World cinema|Musical Drama|Drama,,/en/har_dil_jo_pyar_karega,2000-07-24
Hard Candy,David Slade,Psychological thriller|Thriller|Suspense|Indie film|Erotic thriller|Drama,,/en/hard_candy,
Hard Luck,Mario Van Peebles,Thriller|Crime Fiction|Action/Adventure|Action Film|Drama,,/en/hard_luck,2006-10-17
Hardball,Brian Robbins,Sports|Drama,,/en/hardball,2001-09-14
Harold &amp; Kumar Go to White Castle,Danny Leiner,Stoner film|Buddy film|Adventure Film|Comedy,,/en/harold_kumar_go_to_white_castle,2004-05-20
Harry Potter and the Chamber of Secrets,Chris Columbus,Adventure Film|Family|Fantasy|Mystery,,/en/harry_potter_and_the_chamber_of_secrets_2002,2002-11-03
Harry Potter and the Goblet of Fire,Mike Newell,Family|Fantasy|Adventure Film|Thriller|Science Fiction|Supernatural|Mystery|Children's Fantasy|Children's/Family|Fantasy Adventure|Fiction,,/en/harry_potter_and_the_goblet_of_fire_2005,2005-11-06
Harry Potter and the Half-Blood Prince,David Yates,Adventure Film|Fantasy|Mystery|Action Film|Family|Romance Film|Children's Fantasy|Children's/Family|Fantasy Adventure|Fiction,,/en/harry_potter_and_the_half_blood_prince_2008,2009-07-06
Harry Potter and the Order of the Phoenix,David Yates,Family|Mystery|Adventure Film|Fantasy|Fantasy Adventure|Fiction,,/en/harry_potter_and_the_order_of_the_phoenix_2007,2007-06-28



ここから、サーバーにデータをポストしていく


コアのカラム作成

This data consists of the following fields:
 * "id" - unique identifier for the movie
 * "name" - Name of the movie
 * "directed_by" - The person(s) who directed the making of the film
 * "initial_release_date" - The earliest official initial film screening date in any country
 * "genre" - The genre(s) that the movie belongs to



curl -X POST -H 'Content-type:application/json' --data-binary '{"add-field": {"name":"name", "type":"text_general", "multiValued":false, "stored":true}}' http://localhost:8983/solr/films/schema


solr docker-container-ubuntu-19-10-java-apache-solr-vim /usr/local/src/solr-8.5.1/example/techproducts/solr/films/conf$curl -X POST -H 'Content-type:application/json' --data-binary '{"add-field": {"name":"name", "type":"text_general", "multiValued":false, "stored":true}}' http://localhost:8983/solr/films/schema
{
  "responseHeader":{
    "status":0,
    "QTime":158}}


カラム構成を変更する場合


curl http://localhost:8983/solr/films/schema -X POST -H 'Content-type:application/json' --data-binary '{
    "add-field" : {
        "name":"name",
        "type":"text_general",
        "multiValued":false,
        "stored":true
    },
    "add-field" : {
        "name":"initial_release_date",
        "type":"pdate",
        "stored":true
    }
}'


solr docker-container-ubuntu-19-10-java-apache-solr-vim /usr/local/src/solr-8.5.1/example/techproducts/solr/films/conf$cat managed-schema.json | jq --stream -c '' | grep name


データ投入

solr docker-container-ubuntu-19-10-java-apache-solr-vim /usr/local/src/solr-8.5.1$bin/post -c films example/films/films.json
/usr/local/src/jdk-11/bin/java -classpath /usr/local/src/solr-8.5.1/dist/solr-core-8.5.1.jar -Dauto=yes -Dc=films -Ddata=files org.apache.solr.util.SimplePostTool example/films/films.json
SimplePostTool version 5.0.0
Posting files to [base] url http://localhost:8983/solr/films/update...
Entering auto mode. File endings considered are xml,json,jsonl,csv,pdf,doc,docx,ppt,pptx,xls,xlsx,odt,odp,ods,ott,otp,ots,rtf,htm,html,txt,log
POSTing file films.json (application/json) to [base]/json/docs
1 files indexed.
COMMITting Solr index changes to http://localhost:8983/solr/films/update...
Time spent: 0:00:00.318



データ取得


solr docker-container-ubuntu-19-10-java-apache-solr-vim /usr/local/src/solr-8.5.1$curl -s 'http://localhost:8983/solr/films/select?q=*%3A*' | jq --stream -c ''


ファセット

solr docker-container-ubuntu-19-10-java-apache-solr-vim /usr/local/src/solr-8.5.1$curl -s 'http://localhost:8983/solr/films/select?q=*%3A*&rows=1100&start=0' | jq --stream -c ''


ピボットファセット

サブグループの集計

curl "http://localhost:8983/solr/films/select?q=*:*&rows=0&facet=on&facet.pivot=genre_str,directed_by_str"



レンジファセット

年別集計



curl 'http://localhost:8983/solr/films/select?q=*:*&rows=0&facet=true&facet.range=initial_release_date&facet.range.start=NOW-20YEAR&facet.range.end=NOW&facet.range.gap=%2B1YEAR'




solr docker-container-ubuntu-19-10-java-apache-solr-vim /usr/local/src/solr-8.5.1$curl 'http://localhost:8983/solr/films/select?q=*:*&rows=0&facet=true&facet.range=initial_release_date&facet.range.start=NOW-20YEAR&facet.range.end=NOW&facet.range.gap=%2B1YEAR'
{
  "responseHeader":{
    "status":0,
    "QTime":17,
    "params":{
      "facet.range":"initial_release_date",
      "q":"*:*",
      "facet.range.gap":"+1YEAR",
      "rows":"0",
      "facet":"true",
      "facet.range.start":"NOW-20YEAR",
      "facet.range.end":"NOW"}},
  "response":{"numFound":1100,"start":0,"docs":[]
  },
  "facet_counts":{
    "facet_queries":{},
    "facet_fields":{},
    "facet_ranges":{
      "initial_release_date":{
        "counts":[
          "2000-05-06T10:24:32.571Z",81,
          "2001-05-06T10:24:32.571Z",105,
          "2002-05-06T10:24:32.571Z",117,
          "2003-05-06T10:24:32.571Z",137,
          "2004-05-06T10:24:32.571Z",154,
          "2005-05-06T10:24:32.571Z",205,
          "2006-05-06T10:24:32.571Z",110,
          "2007-05-06T10:24:32.571Z",32,
          "2008-05-06T10:24:32.571Z",8,
          "2009-05-06T10:24:32.571Z",4,
          "2010-05-06T10:24:32.571Z",1,
          "2011-05-06T10:24:32.571Z",0,
          "2012-05-06T10:24:32.571Z",1,
          "2013-05-06T10:24:32.571Z",1,
          "2014-05-06T10:24:32.571Z",0,
          "2015-05-06T10:24:32.571Z",1,
          "2016-05-06T10:24:32.571Z",0,
          "2017-05-06T10:24:32.571Z",0,
          "2018-05-06T10:24:32.571Z",0,
          "2019-05-06T10:24:32.571Z",0],
        "gap":"+1YEAR",
        "start":"2000-05-06T10:24:32.571Z",
        "end":"2020-05-06T10:24:32.571Z"}},
    "facet_intervals":{},
    "facet_heatmaps":{}}}

年月別

curl 'http://localhost:8983/solr/films/select?q=*:*&rows=0&facet=true&facet.range=initial_release_date&facet.range.start=NOW-20YEAR&facet.range.end=NOW&facet.range.gap=%2B1MONTH'


年月日別

curl 'http://localhost:8983/solr/films/select?q=*:*&rows=0&facet=true&facet.range=initial_release_date&facet.range.start=NOW-20YEAR&facet.range.end=NOW&facet.range.gap=%2B1MONTH'


特定のドキュメントのみ削除

削除前


solr docker-container-ubuntu-19-10-java-apache-solr-vim /usr/local/src/solr-8.5.1$curl -s 'http://localhost:8983/solr/films/select?q=id:*/en/300_2007' | jq --stream -c
[["responseHeader","status"],0]
[["responseHeader","QTime"],2]
[["responseHeader","params","q"],"id:*/en/300_2007"]
[["responseHeader","params","q"]]
[["responseHeader","params"]]
[["response","numFound"],1]
[["response","start"],0]
[["response","docs",0,"id"],"/en/300_2007"]
[["response","docs",0,"directed_by",0],"Zack Snyder"]
[["response","docs",0,"directed_by",0]]
[["response","docs",0,"initial_release_date",0],"2006-12-09T00:00:00Z"]
[["response","docs",0,"initial_release_date",0]]
[["response","docs",0,"genre",0],"Epic film"]
[["response","docs",0,"genre",1],"Adventure Film"]
[["response","docs",0,"genre",2],"Fantasy"]
[["response","docs",0,"genre",3],"Action Film"]
[["response","docs",0,"genre",4],"Historical fiction"]
[["response","docs",0,"genre",5],"War film"]
[["response","docs",0,"genre",6],"Superhero movie"]
[["response","docs",0,"genre",7],"Historical Epic"]
[["response","docs",0,"genre",7]]
[["response","docs",0,"name"],"300"]
[["response","docs",0,"_version_"],1665931701953495000]
[["response","docs",0,"_version_"]]
[["response","docs",0]]
[["response","docs"]]
[["response"]]


削除後

solr docker-container-ubuntu-19-10-java-apache-solr-vim /usr/local/src/solr-8.5.1$bin/post -c films -d "<delete><id>/en/300_2007</id></delete>"
/usr/local/src/jdk-11/bin/java -classpath /usr/local/src/solr-8.5.1/dist/solr-core-8.5.1.jar -Dauto=yes -Dc=films -Ddata=args org.apache.solr.util.SimplePostTool <delete><id>/en/300_2007</id></delete>
SimplePostTool version 5.0.0
POSTing args to http://localhost:8983/solr/films/update...
COMMITting Solr index changes to http://localhost:8983/solr/films/update...
Time spent: 0:00:00.041


削除後検索

solr docker-container-ubuntu-19-10-java-apache-solr-vim /usr/local/src/solr-8.5.1$curl -s 'http://localhost:8983/solr/films/select?q=id:*/en/300_2007' | jq --stream -c
[["responseHeader","status"],0]
[["responseHeader","QTime"],2]
[["responseHeader","params","q"],"id:*/en/300_2007"]
[["responseHeader","params","q"]]
[["responseHeader","params"]]
[["response","numFound"],0]
[["response","start"],0]
[["response","docs"],[]]
[["response","docs"]]
[["response"]]


コアごと削除

bin/solr delete -c films
```
