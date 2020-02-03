# 参考文献

https://www.mlab.im.dendai.ac.jp/~yamada/ir/MorphologicalAnalyzer/mecab.html

https://javazuki.com/articles/mecab-install.html

# dockerイメージ作成

```
time docker build -t centos_centos-7-6-18-10-mecab . | tee log
```

# dockerコンテナ削除

```
docker ps -qa | xargs -I@ bash -c 'docker stop @ && docker rm @'
```

# dockerコンテナ作成

```
docker run --name centos-7-6-18-10-mecab -itd centos_centos-7-6-18-10-mecab
```

# dockerコンテナ潜入

```
docker exec -it centos-7-6-18-10-mecab /bin/bash
```
