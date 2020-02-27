- script-repoは肥大化していく一方なので、各環境ディレクトリごとに必要なものをインストールし終えたら、削除するようにする。
  - 初回ログイン時にscript-repoを再クローンして差分更新を行えば、ディスクイメージは不用意に増やさずに、差分リフレッシュができる。💩

- perl の順列ファンクション作って思ったのは、単一スクリプトファイルを複数のosで跨いで使用する場合は最初に実行マシン搭載のosを区別する必要があってUsageを出し分ける必要がある。ライブラリのインストール方法は異なるので。

- oracleでユーザー定義ファンクションで任意の文章を受け取ってjava拡張で組み込んだMecab解析結果をコレクションとして返却するファンクションを作成したい。
  - 便利そう。おもいついた。

- pgroongaインストール
  - https://engineer-milione.com/tips/pgroonga.html
  - https://qiita.com/getpow/items/0fb2b0d6a5678896b4f4

- mroongaインストール
  - https://mroonga.org/ja/docs/install.html
  - https://mroonga.org/ja/docs/tutorial/storage.html#how-to-use-full-text-search

- twiiter認証文言テンプーレトこれ試してみようかな→rejectされたので、とても悲しい。メールアドレス１こ残っているけど大切にしないとなー。とにかく悲しい。熟考してから送信すること。
  - https://note.com/mogya/n/nbd9a720f8a5b

- sqlserver bulk imortできるんだね
  - https://qiita.com/ExA_DEV/items/2d0cdff5bdd43591f7ce

- flockコマンドで排他制御できる実例 プロセスがシーケンシャルに起動されていることがflockコマンドのおかげでわかる
  - https://b.ueda.tech/?post=02709

- phpバインドもあるgroonga
  - https://www.clear-code.com/blog/category/groonga/2.html

- ruby バインドのrrooongaもあるそう
  - https://qiita.com/groonga/items/7642e9e22bcda4b4327f

- perlのflockとbashのflock
  - http://perl.no-tubo.net/2006/10/22/flock%e3%82%92%e4%bd%bf%e3%81%a3%e3%81%9f%e5%bc%b7%e5%9b%ba%e3%81%aa%e6%8e%92%e4%bb%96%e5%87%a6%e7%90%86/

- perlもある！最高である。
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

- sqlserver import export guiしかないぽい

- sqlserver dockerコンテナあった
  - https://docs.microsoft.com/ja-jp/sql/linux/quickstart-install-connect-docker?view=sql-server-ver15

- perlで標準入力からgroup byできそう。trdsql使えば一発だけど。
  - http://www.tohoho-web.com/perl/hash.htm

- groongaのインポートエクスポートまとめる

- mgroongaのインポートエクスポートまとめる

- pgroongaのインポートエクスポートまとめる

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

- ビルド対象ディレクトリを指定できるスクリプト作成

- ビルド対象を保持期間日数で管理するようにする

- 最終的には環境をダイナミックに作りたい。特にライブラリの依存関係。ソースからビルドが安全か。

  - OS名とそのバージョン　単一
  - アプリとそのバージョン　単一ないし複数
  - メモリ量　システムデフォルトとコンテナ個別
  - ユーザー名　システムデフォルトとコンテナ個別

- DockerfileにEXPOSEがあってenv.mdにEXPOSEの記載がないものにたいするパッチ

- DockerfileにARGがあってenv.mdにARGの記載がないものに対するパッチ
