# 参考文献

https://www.mlab.im.dendai.ac.jp/~yamada/ir/MorphologicalAnalyzer/MeCab.html

https://javazuki.com/articles/mecab-install.html

# dockerイメージ作成

```
time docker build -t centos_mecab . | tee log
```

# dockerコンテナ削除

```
docker ps -qa | xargs -I@ bash -c 'docker stop @ && docker rm @'
```

# dockerコンテナ作成

```
docker run --name mecab -itd centos_mecab
```

# dockerコンテナ潜入

```
docker exec -it mecab /bin/bash
```
