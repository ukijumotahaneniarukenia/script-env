- レポジトリ構成
	- script-dat
		- 手軽なテストデータを投入していくなど
	- script-api
		- プログラム別APIなど。CRUD処理に着地。GET、POST、PUT、DELETE。
	- script-template
		- プログラム単位のテンプーレトファイルを管理
		- ディレクトリ構成はscript-sketchと同じ
	- script-sketch
		- プログラムないしアプリ単位にディレクトリを切って運用
		- ディレクトリ名は単一アプリ名
	- script-env
		- os名-バージョン-アプリないしソフト名とそのバージョン単一ないし複数-エディタ単一
		- エディタデフォルトはvim
	- script-repo
		- プログラムのインストーラーシェル
		- プログラムのローンチシェル
		- プログラムのコンフィグシェル
		- プログラムのプレパッチシェル
		- プログラムのポストパッチシェル
		- プログラムのヘルスチェックシェル
		- プログラムの実行ユーザー登録シェル
		- プログラムのデフォルトシステムシェル
		- プログラムのデフォルトユーザーシェル
	- script-cmd
		- 実行コマンドとして仕込ませるなど
	- script-ci
		- 自動実行してみるなど
	- script-search
		- 上記レポジトリ全てを全文検索など
- script-envの構成
	- 環境ファイル構成
		都度、ダイナミックに管理したいものがあれば追加
		- env-build-arg.env
			- ビルド環境引数
		- env-env.env
			- 環境変数
		- env-expose.env
			- 公開ポートと非公開ポート
		- env-image.env
			- ベンダーイメージ
		- env-shm-size.env
			- メモリ
		- env-user.env
			- 登録ユーザー

	- 環境ファイル以外の構成
		script-sketchに移植するようの元ネタ程度になればいいので、ざっくりでいいや
		- md-doc.md
			- dockerコンテナ操作を記載
		- md-dev.md
			- 開発マニュアルを記載
		- md-ref.md
			- 参考文献を記載
		- md-cmd.md
			- テンプレート作成までのコマンドを適当に記載
		- md-env.md
			- プロセスないしサービスの起動・停止・設定ファイルのメモを記載
		- md-trs.md
			- 明細trsファイルのサマリファイル
		- md-trs-00001-何がしかのメモ.md
			- 環境構築の際のトラブルシュートを記載
		- md-man.md
			- 上記マークダウンファイル以外に該当する内容を記載

- script-sketchの構成
	- 環境ファイル以外の構成
		- md-doc.md
			- dockerコンテナ操作を記載
		- md-dev.md
			- 開発マニュアルを記載
		- md-ref.md
			- 参考文献を記載
		- md-cmd.md
			- テンプレート作成までのコマンドを適当に記載
		- md-env.md
			- プログラムないしプログラムライブラリのインストール、プロセスないしサービスの起動・停止・設定ファイルのメモを記載
		- md-trs.md
			- 明細trsファイルのサマリファイル
		- md-trs-00001-何がしかのメモ.md
			- 環境構築の際のトラブルシュートを記載
		- md-man.md
			- 上記マークダウンファイル以外に該当する内容を記載


- レポジトリライフサイクル

  - sketchは重くなるので、言語個別で、レポ切るなど
```
add env
env-->sketch-->repo
remove env

or

add env
env-->sketch-->template
remove env

or

add env
env-->sketch-->cmd
remove env

or

add env
env-->sketch-->ci
remove env

or

add env
env-->sketch-->search
remove env

or

add env
env-->sketch-->api
remove env


```

- crontabで定期実行スクリプト作成
	- http://dqn.sakusakutto.jp/2012/06/cron_crontab9.html
	- https://zenpou.hatenadiary.org/entry/20080715/1216133151
	- https://qiita.com/mazgi/items/15e1fe7e130584343810
	- https://qiita.com/onomame/items/71646c5517a39bcd01cc

crontabで使用するエディタはvim.tiny以外に編集する

プラグインないので、バリエラー出るため

```
$ /usr/bin/select-editor

Select an editor.  To change later, run 'select-editor'.
  1. /bin/nano        <---- easiest
  2. /usr/bin/vim.tiny
  3. /bin/ed

Choose 1-3 [1]: 1
```

manによるとEDITOR環境変数で制御できるらしいので、以下のように設定するといいかんじになった

PRE

```
$ echo $EDITOR
```

CMD
```
$ export EDITOR=/usr/local/bin/vim

$ echo $EDITOR
/usr/local/bin/vim
```

POST

```
$ crontab -l
no crontab for aine

$ crontab -e
no crontab for aine - using an empty one
No modification made
```

バックアップ

```
$crontab -l>~/script_env/docker-build-crontab
```

編集
```
$vi ~/script_env/docker-build-crontab
```

反映
```
crontab < ~/script_env/docker-build-crontab
```

確認

```
$crontab -l
```

プロセス確認

```
$ps aux | grep cron
```

起動ログの確認

```
$sudo less /var/log/cron
```

強制終了

```
su root

ps aux  | grep 'docker build' | awk '{print $2}' | xargs kill
```

- 環境構築スクリプト

	- 環境ディレクトリに移動して実行
	- メンテスクリプトはREPOをダイナミックに管理しておく

```
cd $HOME/script-env
ls D01* P[0-1][0-9]* R07* | xargs -n1 -I@ echo "bash @ script-env" | bash
```

- 処理フローイメージ

```
in-pre

in-main

in-sub

in-post

cmd-pre

cmd-main

cmd-sub

cmd-post

out-pre

out-main

out-sub

out-post

```


- Dockerfileのライフサイクル
	- Dockerfile.seed
		- Dockerfile.autoを作成するための元ネタテンプレート

	- Dockerfile.auto
		- Dockerfile.seedからの生成物

	- Dockerfile.sub
		- デフォルトテンプレートからの環境個別のスクリプトの差分

	- Dockerfile.sub.done
		- デフォルトテンプレートからの環境個別のスクリプトの差分のメンテ完了状態

 	- Dockerfile.done
		- Dockerfile.autoにDockerfile.sub.doneをマージしたもの

	- Dockerfile
		- Dockerfile.doneをリネームしたもの


```
Dockerfile.seed-->Dockerfile.auto-->Dockerfile.done-->Dockerfile
										^
										│
Dockerfile.sub --> Dockerfile.sub.done -┘
```
