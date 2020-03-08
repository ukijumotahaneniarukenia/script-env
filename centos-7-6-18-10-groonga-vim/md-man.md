# 参考文献

- https://www.mlab.im.dendai.ac.jp/~yamada/ir/MorphologicalAnalyzer/mecab.html

- https://javazuki.com/articles/mecab-install.html

- https://github.com/naoa/docker-termextract/blob/master/Dockerfile


# 動作確認

```
$echo みなさんこんにちわ | mecab
みなさん	名詞,代名詞,一般,*,*,*,みなさん,ミナサン,ミナサン
こんにちわ	感動詞,*,*,*,*,*,こんにちわ,コンニチワ,コンニチワ
EOS
```
