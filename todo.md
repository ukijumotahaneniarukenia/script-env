- mysqlと同じような仕組みだろう
  - https://qiita.com/toshihirock/items/86931e3c52dc47287dd2

- sqlserver import export guiしかないぽい

- Postgres import export dump restoreデータベース単位ないしテーブル単位を使い分けて
  - https://qiita.com/rice_american/items/ceae28dad13c3977e3a8
  - https://qiita.com/cyborg__ninja/items/99efcb5b62a4cef2f156
- sqlserver dockerコンテナあった
  - https://docs.microsoft.com/ja-jp/sql/linux/quickstart-install-connect-docker?view=sql-server-ver15

- perlで標準入力からgroup byできそう。trdsql使えば一発だけど。
  - http://www.tohoho-web.com/perl/hash.htm
- mysqlのインポートエクスポートまとめる→まとめた。

- postgresのインポートエクスポートまとめる

- elasticsearchのインポートエクスポートまとめる

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
