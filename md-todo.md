- lsなどの実行結果に対して集合演算ハンディにしたい

  - https://nim-lang.org/docs/sets.html

- 変数宣言でvarが変更可能で、letが変更不可。javascriptみたいな雰囲気。

```
var a = toCountTable("aaabbc")
let b = toCountTable("bcc")
a.merge(b)
doAssert a == toCountTable("aaabbbccc")
```

- nim 多値タプルの配列はtable変換すると、ハッシュエントリになる。便利。Pythonの変換と同じ。

- nim 多値引数受け取れる。
  - https://nim-lang.org/docs/tables.html#basic-usage-table

- ロゼッタコード
  - https://rosettacode.org/wiki/Permutations
- csharp Linux 導入
  - https://banikojp.blogspot.com/2018/04/linuxc.html?m=1

- sudachi 導入
  - https://kurage.cc/blog-sudachi/
  - https://github.com/WorksApplications/Sudachi
- elasticsearch Kibana Kuromori
  - https://mattintosh.hatenablog.com/entry/20190205/1549371581

- perl タグクラウド
  - http://www2u.biglobe.ne.jp/~MAS/perl/waza/tagcloud.html

- go api 検索エンジン
  - https://github.com/astaxie/build-web-application-with-golang/blob/master/ja/preface.md
  - https://github.com/tenntenn/goweb-book/blob/master/README.md
  - https://github.com/tenntenn/qiitaexporter/blob/master/README.md
  - https://future-architect.github.io/articles/20200327/

- go
  - https://schoo.jp/teacher/2869

- python 入れ子

2つ目のforを後ろに持ってきて、式を前で受ける。

```
arr = [[1,2,3], [4,5,6], [7,8,9]]
[i for j in arr for i in j]
```


- perl このパターンマッチは色々応用できそうな気がする
  - https://perldoc.jp/variable/%24%5EN

- python lambdaと内包式の使い方を行列データ扱うときで比較したい。自作関数入れられるかどうか。
  - https://note.nkmk.me/python-list-comprehension/

- c# チュートリアル
  - https://docs.microsoft.com/ja-jp/learn/paths/csharp-first-steps/?WT.mc_id=docs-twitter-machiy

- Elmoとword2vec
  - https://speakerdeck.com/tagucci/elmo-for-searching-similar-keywords

- javascript最近のやつ
  - https://future-architect.github.io/typescript-guide/

- JavaScript 型変換
  - https://mtane0412.com/convert-array-to-object-using-reduce/

- JavaScript でgroup by はfindとreduceのコンボかmapとhashのコンボどっちかなのかな。

- JavaScript ハマりそう
  - https://www.webprofessional.jp/map-reduce-functional-javascript/

- 型変換に使えそう
  - https://ginpen.com/2018/12/23/array-reduce/

- perlでサブマッチ抜き出すことなどをしたかった

- nodejs sqlite3連携　標準入力からファイル名複数配列で受け取って、fsに渡す。
  - https://qiita.com/shirokuman/items/509b159bf4b8dd1c41ef

- https://www.gesource.jp/weblog/?p=8289

- js mapでシェルげいしておく。
  - https://developer.mozilla.org/ja/docs/Web/JavaScript/Reference/Global_Objects/Array/map

- ruby の変数一覧
  - https://docs.ruby-lang.org/ja/latest/doc/symref.html

- pythonのzipは使い慣れておきたい。

- 可視化ツール選定しておきたい。用途別に。

- https://blog.insightdatascience.com/ai-for-3d-generative-design-17503d0b3943
  - 機械学習のイメージ湧きやすい。

- 逆引きマスタを大量に作成する必要がありそうだ。

- 検索条件を分解した際の出現位置の差をどう導くかなど。
  セミコロンの左側単位での前回行の右側との差が前回行の文字列の長さに等しいか等しくないかで区別できる。いやできないな。
  検索条件を分解したときのグラム数を求めておく必要がある。
  セミコロンの左側単位でセミコロンの右側の数字が連続しているものが完全一致。欠番していないかチェックする。インデックス時は、文章単位、グラム順に一意の番号を振ればこのロジックはいける。
- 分解は2つあって
  - 検索条件を分割するのとテーブルデータを作成する際にgram化するのと。など。

- n gram でないときは文字列の長さも必要か。

- 自然言語処理　フロー乗ってて　導入は良さげ
  - https://towardsdatascience.com/named-entity-recognition-ner-with-bert-in-spark-nlp-874df20d1d77

- graphqの自動テスト
  - https://qiita.com/pocke/items/bfe120f07bd8d94724a7

- 文脈を意識しないといけんのだな。わかってきたぞ。テーブル持つときは、元文書IDの参照を持たせてあげる。

- バイグラム
  - http://gihyo.jp/dev/serial/01/make-findspot/0005?page=2
  - https://qiita.com/greymd/items/3515869d9ed2a1a61a49#%23%23%20%E5%85%A8%E6%96%87%E6%A4%9C%E7%B4%A2%E3%82%A8%E3%83%B3%E3%82%B8%E3%83%B3%E3%82%92%E4%BD%9C%E3%82%8B

- 入力単語に対する類義語の距離は分析関数のレンジでエミュできる。どこまでのサジェストをするか引数にレンジ値を渡して動的に変更できる。

- word2vecインストール
  - https://qiita.com/kenta1984/items/93b64768494f971edf86

- perl 論理えんざし
  - https://tutorial.perlzemi.com/blog/20100816136168.html

- perlのオプションCSDで日本語扱える
  - https://qiita.com/ohtsuka1317/items/92c339a65533e1e6c6fc
- perl 実戦的
  - https://qiita.com/teckl/items/98de382787401d2392c3

- perl 部分マッチ文字列抜き出し
  - https://qiita.com/ngyuki/items/d5dde70cf2de952cfb87

- gpu大切なんだな
  - https://ainow.ai/2020/03/11/183804/

- errorログを抜いてtrsに書き込みたい。

- ていしゅうきエラー監視ジョブはtrsから対象抜き出して自動復旧したい。

- perl 変数
  - awkのセパレーターと比較してちょっと整理しておく。
  - https://perldoc.jp/index/variable

- bash からの書き換えはrubyでも楽しそう
  - https://qiita.com/jnchito/items/dedb3b889ab226933ccf
- ruby ファイル読み込み
  - https://www.buildinsider.net/language/rubytips/0021
- ruby map関数
  - https://uxmilk.jp/21695
- ruby group by
  - https://docs.ruby-lang.org/ja/latest/method/Enumerable/i/group_by.html
  - https://doruby.jp/users/pe/entries/ruby%E3%81%A7%E9%85%8D%E5%88%97%E3%81%8B%E3%82%89%E9%87%8D%E8%A4%87%E3%81%99%E3%82%8B%E5%80%A4%E3%82%92%E6%8A%BD%E5%87%BA%E3%81%99%E3%82%8B%E6%96%B9%E6%B3%95%E3%82%92%E6%8E%A2%E3%81%97%E3%81%9F%E9%9A%9B%E3%81%AB%E8%A6%8B%E3%81%A4%E3%81%91%E3%81%9Fgroup_by%E3%83%A1%E3%82%BD%E3%83%83%E3%83%89%E3%81%8C%E4%BE%BF%E5%88%A9%E3%81%A0%E3%81%A3%E3%81%9F
- ruby 配列メソッド
  - https://qiita.com/jnchito/items/118cca7ac2f01e1ca6a0
- python小技
  - https://qiita.com/Namibillow/items/954c7f9f53682d6dd9c9

- sedぽくぅて面白いレーベン
  - https://ja.m.wikipedia.org/wiki/%E3%83%AC%E3%83%BC%E3%83%99%E3%83%B3%E3%82%B7%E3%83%A5%E3%82%BF%E3%82%A4%E3%83%B3%E8%B7%9D%E9%9B%A2

- bashスクリプトpythonに書き換えるか。while read で変数外上書きされないのが忘れた頃にハマるんだよな。

- 楽しそうだないいなこれ。word2vec
  - https://qiita.com/Hironsan/items/11b388575a058dc8a46a

- この環境ディレクトリ自体を学習題材に使用しよう。

- 自然言語処理のデータセット。コマンド乗ってる。
  - https://towardsdatascience.com/improving-sentence-embeddings-with-bert-and-representation-learning-dfba6b444f6b

- 環境ディレクトリ名を与えれば、全てできるようにしておきたい。

- 名寄せの背景分かり易い
  - https://pompom168.hatenablog.com/entry/2019/08/09/144054

- 自然言語処理データセット
  - https://qiita.com/daimonji-bucket/items/56143b2abbfadb4429af

- 言葉が難しいけどある単語にグループ値を振りたいための話。
  - https://qiita.com/daimonji-bucket/items/47f806624a5924f2d47b

- カフェラッテ。名寄せ。
  - https://buildersbox.corp-sansan.com/entry/2020/03/10/110000

- docker-composeの操作背景が分かり易い
  - https://qiita.com/sanpo_shiho/items/fc8082f3d303c04cca2e

- アプリのインストールはAPP_NAMEに依存しないように管理する。

- バージョン番号はハイフン数字1回以上のグループの1回以上の繰り返しで表現できる。

- アプリが複数個ある場合、バージョン番号がそれぞれに付随していないものを洗い出す。

- たしかバージョン番号を気にせず、常に最新をインストールするようなソフトもあったのでバージョン指定可能かどうかをまず確認した方がいいか。

- Repoからバージョン番号を気にしていないものを洗い出す。

- 元のDockerfileをDockerfile.asisにリネームして、Dockerfile.autoをDockerfileにリネームして一時的にビルドファイルをスイッチできるようにする。
引数の順序入れ替えて元に戻せるようにする。スイッチ元とスイッチ先を指定した方いいか。

- jqの強みはエスケープ機能が関数として組まれていることかもしれない。

- 検索ワードをストップワードに自動追加するしくみがほしい

- vmコマンドライン操作便利
  - https://qiita.com/tukiyo3/items/5ecea7f95cb961f07194

- ネットワークのパケット送受信量を計測
  - https://qiita.com/suin/items/d4428e65a2cc1d956581

- プロセスの起動時刻を調査
  - https://qiita.com/todaemon/items/82edbad20e37039d5162

- 便利そう
  - https://qiita.com/usiusi360/items/7b47be9d0ab5b1acd608


- プロセスId単位でプロセスの起動日時を控える。対象のプロセスidが検索に引っかからないなら、プロセス終了起動時刻を取得。
  - https://qiita.com/isaoshimizu/items/ee555b99582f251bd295

- ファイルの詳細情報を取得するコマンド。更新頻度出すのに使えそう。
  - https://qiita.com/reoring/items/275ae83dfaa65bac568c

- コンテナ手動かすやつ
  - https://www.google.com/amp/s/employment.en-japan.com/engineerhub/entry/2019/02/05/103000%3Famp%3D1

- レポに存在するファイルが環境ディレクトリ内のDockerfile内に存在するかチェックし、なければリネームする。
- docker composeはローカルイメージ見てくれる
  - https://qiita.com/zembutsu/items/9e9d80e05e36e882caaa

- flutendのサンプル
  - https://www.jkawamoto.info/blog-ja/docker-compose-for-logging-service/
- oracleとsqlserver とibmもうちょいいいい感じにしておく。

- neckなのはプログラムがバイナリ提供のものを使用しているのか、ソースからビルドしているものなのかを区別していないこと。レポジジかえればいいか。makeがあるかないかでくべつできる。


- Dockerfile.sub Dockerfileは環境ﾃﾞｨﾚｸﾄﾘを他環境からこぴっておしまいになり力尽きている際には以下のような感じで初期化しておく

```
>Dockerfile.sub
>Dockerfile
```

- rubyでxmlファイル処理するコマンドまとめる。

- 各環境ディレクトリの引数を一元管理するためのマークダウンファイルが欲しい。

- 適用されている値を一覧で管理したい。優先度を管理する。

- 必要十分条件にするためには十分条件が必要。必要条件を定義しないといけない。十分条件は絞る必要はあまりない。必要条件はテキストマイニングと呼ばれるもので、規則を見つけてパタン定義。

- gradleはsdkからインスこすればいい。ホストからマウントする必要ない。

- プログラム更新頻度を調べたい。バージョン版数への関心を更新頻度に反比例させたい。メンテが大変になるので。

- プログラム単位でデフォルトバージョンを管理したい

- Dockerfile.subの実行順序
  - patchの名称はデフォルトでpre-patch
  1. pre-patch（あれば）
  2. install
  3. post-patch（あれば）
  4. config
  5. healthcheck

- もう事前ビルドしてマウントだな。
  - https://qiita.com/IanMLewis/items/badc55b5d8e188ace34a
  - repo管理しててよかった。

- MySQL build しくってたのがここでリカバレるかも。必要そうなライブラリが乗ってて、ビルド手順乗っている。
  - https://mroonga.org/ja/docs/install/others.html
  - mysqlは5.6!!

- テンプーレトにキャッシュ削除するスクリプトを追加する。
  - centos
    - https://easyramble.com/yum-clean-and-update.html
  - Ubuntu
    - https://qiita.com/SUZUKI_Masaya/items/1fd9489e631c78e5b007

- gpuを利用したディープラーニング
  - https://techable.jp/archives/118651

- rust製のコマンド
  - https://qiita.com/navitime_tech/items/c249269a3b47666c784b

- groongaのバージョン組み合わせ作れるだけ作ってみる

- ruby groonga
  - http://ranguba.org/ja/

- スクリプトに参照を持たせ始めるタイミングと処理順序を意識し始めるタイミングは同じことが改めてわかった。処理順序をファイルで管理する。ファイル名に縛られないために。

- ダイナミックリンクディレクトリのエントリディレクトリをシステム単位でキャッシュ作成対象として認識させておく際に、

```
/etc/ld.conf.d/プロセス名.conf
```
といった名称で、

例えば、

```

/etc/ld.conf.d/postgres.conf
```

のように。環境個別に設定を利かすのがよさげ。記載するプロセス名はscript-envに格納しているディレクトリ名から選択する。

- カンマ区切り文字列をbashでunnestがレコードの意味付けを保ったままできたので、sketchに投入しておく

- 各環境ディレクトリ特有の動作確認スクリプトをヘルスチェックスクリプトととしてレポに登録しておきたい。リグレッションで使い勝手いいように。
  - 名前はconfirmじゃなくてhealthcheckがいいか。

- windowsパッチファイルで複数ファイルに対してサクラエディタ のマクロよく適用させているから、まとめておきたい。visualbox上で再現撮っておきたい。

- Postgres-pgroongaにルビーのメモリに関するスクリプトあった。

- makeのマルチスレッド数こんな感じで制御するのを変数化して、デフォルトと環境個別で制御したい。

make -j$(grep '^processor' /proc/cpuinfo | wc -l)

- コンテナの使用頻度を出したい。それをリスト化してスケジューリングしたい。常に全てのイメージができている必要はないので。

- 各OSコンテナにvim,dev,tool,networkが入ったコンテナを用意しておく。

- メンテスクリプトはその場限りのパッチには先頭にPを運用していくパッチには先頭にOをつけ、分類する。

- md-step.mdにビルド時間も抽出して埋め込みたい。

- 遅延時間を表示したい

- gron commandの使い方。
  - mediamからサジェストきた。面白い。
  - JSON Processing Pipelines with gron
  - https://medium.com/capital-one-tech/json-processing-pipelines-with-gron-6fbd531155d7

- script-repoは肥大化していく一方なので、各環境ディレクトリごとに必要なものをインストールし終えたら、削除するようにする。
  - 初回ログイン時にscript-repoを再クローンして差分更新を行えば、ディスクイメージは不用意に増やさずに、差分リフレッシュができる。💩

- oracleでユーザー定義ファンクションで任意の文章を受け取ってjava拡張で組み込んだMecab解析結果をコレクションとして返却するファンクションを作成したい。
  - 便利そう。おもいついた。

- twiiter認証文言テンプーレトこれ試してみようかな→rejectされたので、とても悲しい。メールアドレス１こ残っているけど大切にしないとなー。とにかく悲しい。熟考してから送信すること。
  - https://note.com/mogya/n/nbd9a720f8a5b

- sqlserver bulk imort
  - https://qiita.com/ExA_DEV/items/2d0cdff5bdd43591f7ce

- flockコマンドで排他制御できる実例 プロセスがシーケンシャルに起動されていることがflockコマンドのおかげでわかる
  - https://b.ueda.tech/?post=02709

- phpバインドもあるgroonga
  - https://www.clear-code.com/blog/category/groonga/2.html

- ruby バインドのrrooongaもあるそう
  - https://qiita.com/groonga/items/7642e9e22bcda4b4327f

- perlのflockとbashのflock
  - http://perl.no-tubo.net/2006/10/22/flock%e3%82%92%e4%bd%bf%e3%81%a3%e3%81%9f%e5%bc%b7%e5%9b%ba%e3%81%aa%e6%8e%92%e4%bb%96%e5%87%a6%e7%90%86/

- perlテストデータ
  - http://tsucchi.github.io/slides/yokohamapm/11/

- json日本語データ作成はpython経由がハンディかな
  - https://qiita.com/ohbarye/items/452fefa2be5d56268b50

- elasticsearch 日時指定検索
  - http://togattti.hateblo.jp/entry/2017/08/17/174953

- elasticsearch import export ダンプコマンド別途あり

  - https://qiita.com/nakazii-co-jp/items/3199433d685d0600c6d6

  - https://qiita.com/datake914/items/2313894c684a7cba992c

- compose用のレポジトリ作成しようかな
  - script-jam
  - https://github.com/YoshinoriN/docker-redmine-orchestration

- oracle import export mysqlと同じような仕組みだろう
  - https://qiita.com/toshihirock/items/86931e3c52dc47287dd2

- oracleのインポートエクスポートまとめる

- sqlserverのインポートエクスポートまとめる

- Nodejsとgroonga連携まとめる

- コピペチェッカー使い方調べる

- postgresへdbeaverから繋ぐ

- マイリーダー用にjsonファイルからマークダウンファイルに変換するコマンド必要なので、
スクラッチから作る。
  - https://gist.github.com/mignonstyle/083c9e1651d7734f84c99b8cf49d57fa

- 検索スピード上げるツール
  - https://qiita.com/youwht/items/7f5686a30eed16864954
  - Linux版はいけなかったので、wikiないし辞書データをgroongaに投入してコマンドで引けるようにする。

- ビルド対象を保持期間日数で管理するようにする

- 最終的には環境をダイナミックに作りたい。特にライブラリの依存関係。ソースからビルドが安全か。

  - OS名とそのバージョン　単一
  - アプリとそのバージョン　単一ないし複数
  - メモリ量　システムデフォルトとコンテナ個別
  - ユーザー名　システムデフォルトとコンテナ個別
